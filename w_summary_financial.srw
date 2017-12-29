HA$PBExportHeader$w_summary_financial.srw
$PBExportComments$Generic financial summaries (inherited from w_master)
forward
global type w_summary_financial from w_master
end type
type dw_dict_cols from u_dw within w_summary_financial
end type
type dw_sum_select from u_dw within w_summary_financial
end type
type uo_functions from u_display_functions within w_summary_financial
end type
type uo_1 from u_display_period within w_summary_financial
end type
type cbx_provider_universe from checkbox within w_summary_financial
end type
type st_count from statictext within w_summary_financial
end type
type dw_label from u_dw within w_summary_financial
end type
type dw_rel from u_dw within w_summary_financial
end type
type dw_fields from u_dw within w_summary_financial
end type
type cb_close from u_cb within w_summary_financial
end type
type cb_clear from u_cb within w_summary_financial
end type
type cb_save from u_cb within w_summary_financial
end type
type cb_more_crit from u_cb within w_summary_financial
end type
type cb_view from u_cb within w_summary_financial
end type
type cb_query from u_cb within w_summary_financial
end type
type ddlb_sorts from dropdownlistbox within w_summary_financial
end type
type sle_rank from singlelineedit within w_summary_financial
end type
type rb_bottom from radiobutton within w_summary_financial
end type
type rb_top from radiobutton within w_summary_financial
end type
type gb_fields from groupbox within w_summary_financial
end type
type gb_rank from groupbox within w_summary_financial
end type
type gb_sort from groupbox within w_summary_financial
end type
type uo_sort from u_def_query_grps within w_summary_financial
end type
type gb_1 from groupbox within w_summary_financial
end type
type gb_2 from groupbox within w_summary_financial
end type
type wsx_sort from structure within w_summary_financial
end type
type wsx_field from structure within w_summary_financial
end type
end forward

type wsx_sort from structure
    string label
    string col_name
end type

type wsx_field from structure
    string label
    string col_name
    string lookup_type
    string operator
    string value
    integer sequence
end type

global type w_summary_financial from w_master
string accessiblename = "Summary Analysis"
string accessibledescription = "Summary Analysis - "
integer x = 55
integer y = 32
integer width = 3351
integer height = 2180
string title = "Summary Analysis - "
event ue_reset_window pbm_custom01
event type integer ue_load_sort ( )
event type integer ue_pre_load_sort ( )
dw_dict_cols dw_dict_cols
dw_sum_select dw_sum_select
uo_functions uo_functions
uo_1 uo_1
cbx_provider_universe cbx_provider_universe
st_count st_count
dw_label dw_label
dw_rel dw_rel
dw_fields dw_fields
cb_close cb_close
cb_clear cb_clear
cb_save cb_save
cb_more_crit cb_more_crit
cb_view cb_view
cb_query cb_query
ddlb_sorts ddlb_sorts
sle_rank sle_rank
rb_bottom rb_bottom
rb_top rb_top
gb_fields gb_fields
gb_rank gb_rank
gb_sort gb_sort
uo_sort uo_sort
gb_1 gb_1
gb_2 gb_2
end type
global w_summary_financial w_summary_financial

type variables
boolean iv_switch = true
boolean iv_open_flag
private wsx_sort iv_sort[]
sx_field iv_fields[]
string iv_asterisk_col[]       //holds col_names of col = *
string iv_inv_type
string iv_summary_table
string iv_sum_tbl_type
string iv_header
string iv_tbl_types[]
string iv_mo_01
string iv_connector
int ii_index
int iv_sum_num                                 //num of field when coming from summary
string ic_field_name = 'field_name_'    //part of field name in dw_fields
string ic_operator = 'operator_'           //part of field name in dw_fields
string ic_value = 'value_'                   //part of field name in dw_fields
string ic_sum_fld = 'sum_fld'               //part of field name in sum_rel
string ic_seq = '_seq'                         //part of field name in sum_rel
int ic_field_num = 6                           //# of entry fields
int ic_col_pos = 60                            //pos of col_name in field string
int ic_lookup_pos = 108                     //pos of lookup_type in field string
string is_function
String is_group_by	= ''		//Group by clause if available
u_nvo_summary	inv_summ		//Summary NVO
sx_summary_parm	istr_in_parm	//Summary structure
String is_universe_table		//Provider Universe Table name
constant string ics_drugcat = 'DRUG_CAT'
boolean ib_from_cb_details
string is_detail_inv_type // FNC 05/25/00

end variables

forward prototypes
public function integer wf_clear_fields (integer arg_field_num)
public function string wf_make_sql ()
public function integer wf_load_summ_row (sx_summary_parm arg_parm)
public function string wf_make_universe_sql ()
public function string wf_get_invoice_type ()
public function integer wf_load_first_dw_field ()
public function string wf_set_filter ()
public subroutine wf_get_dw_fields ()
public function string wf_filter_sum_rel ()
public function integer wf_load_dw_fields (string arg_filter, string arg_field, integer arg_field_num)
public function string wf_format_line (string arg_col_name, string arg_operator, string arg_value)
public function string wf_create_where ()
public function string wf_select_fields ()
public function integer wf_check_field ()
public function string wf_make_select ()
public function integer wf_load_ddlbs ()
end prototypes

event ue_reset_window;//******************************************************************
// 06-05-97 FNC	Track 89 RLS36 FS/TS156. Take out call to colors
//						so that the period dddw is not reset. Move it to the
//						open event so that it is only called once.
//******************************************************************

//clear out first row and make all others invisible
//if Bill Type is in first ddlb, then must be set and disabled

int lv_rc
string lv_rs,lv_col


dw_fields.setredraw(false)
lv_rc = dw_fields.setitem(1,ic_value + string(1),'')
lv_rc = wf_clear_fields(1)
lv_rc = wf_load_first_dw_field()
dw_fields.setredraw(true)

inv_summ.fuo_set_pat_profile(FALSE)
this.event ue_load_sort()
st_count.text = ''
sle_rank.Text = ""

cbx_provider_universe.visible=false
cbx_provider_universe.checked=false
cbx_provider_universe.enabled=false


end event

event type integer ue_load_sort();//////////////////////////////////////////////////////////////////////////////////////////////
//
//w_summary_financial.ue_load_sort()
// This event calls uo_sort.uf_load_dddw() which retrieves the sort columns
// to initially sort the report on.
// If not a patient profile, defined_query_groups has the sort columns.
// If is patient profile period_cntl.pat_profile_rank_col determines sort column.
// This script is called from 3 places: ue_pre_load_sort, wf_load_ddlbs(), ue_reset_window().
//
//Returns:	Integer	 1	Success
//							-1	Error
//////////////////////////////////////////////////////////////////////////////////////////////
//
//	02/14/00	NLG	Created.
//	10/15/02	Jason Track 2991d dictionarize sort dddw
// 01/07/03	Jason Track 3396d call uf_set_label()
//	04/17/03	GaryR	Track 3396d	Rewrite the flow of sorting
//	05/28/03	GaryR	Track 3593d	Add visual aid for sorting options
// 10/26/04 MikeF	Track 3650d	Replaced SQL with gnv_dict
//////////////////////////////////////////////////////////////////////////////////////////////

long ll_row, ll_period, ll_rc
string ls_base_type, ls_field
string ls_summary_table, ls_tbl_type, ls_sum_flag
Boolean	lb_load = TRUE
datawindowchild ldwc_sort	// JasonS 10/15/02 Track 2991d
// JasonS 10/14/02 Begin - Track 2991d Moved out of if statement below
//Get the table type

//	Do not populate sort if no criteria
IF dw_fields.RowCount() < 1 THEN lb_load = FALSE
ls_field = dw_fields.GetItemString( 1, "field_name_1" )
IF IsNull( ls_field ) OR Trim( ls_field ) = "" THEN lb_load = FALSE

uo_sort.GetChild('col_label',ldwc_sort)

if dw_rel.rowcount() < 1 then
	ldwc_sort.reset()
	return -1
end if
ls_summary_table  = dw_rel.getitemstring(1,'table_name')
ls_sum_flag = dw_rel.getitemstring(1, 'sum_flag')
ls_tbl_type = gnv_dict.event ue_get_table_type(ls_summary_table)

//Determine if patient profile. If sum_rel.sum_flag for the criteria user has selected is 'B', 
//it's patient profile and sort column will be different
IF inv_summ.fuo_get_ib_pat_profile() THEN
	//get the period
	ll_period = uo_1.uf_return_period()
	
	uo_sort.dataobject = 'd_period_cntl_dict'
	uo_sort.uf_set_patient_boolean(TRUE)
	uo_sort.uf_load_dddw(ll_period,'SUM',iv_inv_type,ls_tbl_type, lb_load)
ELSE
	uo_sort.dataobject = 'd_def_query_col_label'
	//get the base_type from stars_rel
	ll_row	=	fx_filter_stars_rel_1 ('QT', gv_sys_dflt, iv_inv_type)
	IF	ll_row	<	1		THEN
		Messagebox('Error','Unable to retrieve base type.')
		Return -1
	END IF
	ls_base_type	=	w_main.dw_stars_rel_dict.GetItemString (1, "KEY6")
	uo_sort.uf_set_patient_boolean(FALSE)
	uo_sort.uf_load_dddw(ls_tbl_type, ls_sum_flag, lb_load) // JasonS 10/15/02 Track 2991d
END IF

return 1
end event

event type integer ue_pre_load_sort();//w_summary_financial.ue_pre_load_sort().
//
// This event is called from:  dw_fields.check_dw()
// It is called to populate uo_sort, the user object that contains
// the columns that the report can be sorted by.  
// First, create a local datastore for sum_rel to determine if the grouping 
// the user has selected is a patient profile.  Patient profiles are sorted
// by the column which was used to rank the summaries on the mainframe. Set
// the patient_profile boolean in u_nvo_summary.  The call ue_load_sort().
//
//	Returns:	integer	 1 if success
//							-1 if error
//	
//History
//	2/14/00	NLG	Created.
//	3/28/00	NLG	Track 2161. If dw_rel is empty, there are no
//						summaries for selected criteria. wf_set_filter
//						handles the user message.  Set patient profile boolean
//						to false and call uo_load_sort to reset uo_sort.
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in the data.
//////////////////////////////////////////////////////////////////////////

boolean lb_pat_profile
int li_rc
long ll_period
string ls_sum_flag,ls_summary_table
long ll_rows
n_ds lds_sum_rel_pat_profile  


IF dw_rel.RowCount() > 0 THEN//NLG 3-28-00 
	ls_summary_table  = dw_rel.getitemstring(1,'table_name')
	
	//create the datastore that will check sum_rel to see if this is a patient profile
	lds_sum_rel_pat_profile = CREATE n_ds
	lds_sum_rel_pat_profile.dataobject = "d_sum_rel_pat_profile"
	lds_sum_rel_pat_profile.of_SetTrim (TRUE)					// FDG 04/16/01
	lds_sum_rel_pat_profile.SetTransObject(stars2ca)
	ll_period = uo_1.uf_return_period()
	ll_rows = lds_sum_rel_pat_profile.Retrieve(iv_inv_type,ll_period,ls_summary_table)
	
	//There should only be 1 row
	if ll_rows > 1 then
		Messagebox('ERROR','Error in ue_pre_load_sort() in w_summary_financial.' +&
				'~nMore than 1 row in sum rel for Period = ' + string(ll_period) +& 
				'~nFunction Name = SUM~nInvoice Type = ' + iv_inv_type + '~nTable: ' +&
				ls_summary_table + '~nsum_fld1_seq = 0')
		lb_pat_profile = False
	elseif ll_rows < 1 then
		if ll_rows = 0 then
			lb_pat_profile = FALSE
		else	
			Messagebox("ERROR","Error in ue_pre_load_sort() in w_summary_financial." +&
					"~nError reading sum rel for Period = " + string(ll_period) +& 
					"~nFunction Name = SUM~nInvoice Type = " + iv_inv_type + "~nTable: " +&
					ls_summary_table + "~nsum_fld1_seq = 0")
			lb_pat_profile = False
		end if
	else
		ls_sum_flag = lds_sum_rel_pat_profile.GetItemString(1,'sum_flag')
		if UPPER(ls_sum_flag) = 'B' then 
			lb_pat_profile = TRUE
		else
			lb_pat_profile = FALSE
		end if
		
	end if 
ELSE								//NLG 3-28-00 
	lb_pat_profile = FALSE	//NLG 3-28-00 
END IF							//NLG 3-28-00 


li_rc = inv_summ.fuo_set_pat_profile(lb_pat_profile)

//This event will call a function in uo_sort to retrieve the sort columns
li_rc = this.event ue_load_sort()

IF IsValid(lds_sum_rel_pat_profile) THEN destroy lds_sum_rel_pat_profile

//Use return code from ue_load_sort() 1 if success; -1 if error
return li_rc

end event

public function integer wf_clear_fields (integer arg_field_num);//******************************************************************
//06-05-97 FNC	Track 89 RLS36 FS/TS156. Take out call to colors
//					so that the period dddw is not reset. Move it to the
//					open event so that it is only called once. A color was
//					hardcoded. Changed it to use color from structure.
//******************************************************************

int i,lv_rc
string lv_rs,lv_name
datawindowchild lv_temp_child

setpointer(hourglass!)

for i = arg_field_num to ic_field_num
	lv_rc = dw_fields.setitem(1,ic_field_name + string(i),'')
	lv_rc = dw_fields.clearvalues(ic_field_name + string(i))
	lv_rs = dw_fields.modify(ic_field_name + string(i) + '.visible=0')
	lv_rc = dw_fields.setitem(1,ic_operator + string(i),'=')
	lv_rs = dw_fields.modify(ic_operator + string(i) + '.visible=0')
	lv_rc = dw_fields.setitem(1,ic_value + string(i),'')
	lv_rs = dw_fields.modify(ic_value+string(i)+".tag = ''")
	lv_rs = dw_fields.modify(ic_value + string(i) + '.visible=0')	
//06-05-97 FNC Start
//   lv_rs = dw_fields.modify(ic_value+string(i)+".background.color=" + string(8421376))
	lv_rs = dw_fields.modify(ic_value+string(i)+".background.color=" + string(stars_colors.datawindow_back))
//06-05-97 FNC end
next

return 0
end function

public function string wf_make_sql ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	window function
//	Script Name:	wf_make_sql
//	Description:	Build the 'From' clause, the 'Where' clause, and the
//						'Group by' clause.  If the 'Group by' clause exists,
//						then there will also be an 'Order by' clause.
//	Arguments:		None
//	Returns:			String - The 'From' and 'Where' clause
//************************************************************************
//
//10/11/95 FNC	Take upperbound out of script
//
//07/30/96 FDG	STARS35 - Add a 'Group by' clause if column 'sum_flag'
//					= 'G' on table sum_rel.  Also, add the table type to
//					each column.
//
//************************************************************************

string lv_where,lv_line,lv_field_string,lv_filter
string lv_col_name,lv_sql,lv_temp,lv_temp2,lv_where_message
boolean lv_found

setpointer(hourglass!)

sx_field lv_clear_fields[]
string lv_clear_asterisks[]
string lc_equal = ' = '
string lc_and = ' and '
string lc_not_zero = ' <> 0'
string lc_equal_zero = ' = 0'
string lc_asterisk = " = '*'"
string lc_no_asterisk = " <> '*'"
String lc_comma = ', '								//FDG 07/30/96
//clear structures
iv_fields = lv_clear_fields
iv_asterisk_col = lv_clear_asterisks
dw_fields.accepttext()
//Get fields selected

IF	wf_select_fields ()	=	'ERROR'		THEN
	Return 'ERROR'
END IF

//Set the filter

IF	wf_set_filter ()	=	'ERROR'		THEN
	Return 'ERROR'
END IF

iv_summary_table = dw_rel.getitemstring(1,'table_name')
iv_sum_tbl_type	=	inv_summ.fuo_get_tbl_type (iv_summary_table)

//	Get the 'group by' clause if it exists.  NOTE: wf_create_where
//	must check is_group_by.
is_group_by	=	inv_summ.fuo_create_group_by()		//FDG 07/30/96
lv_where	=	wf_create_where()
IF	lv_where	=	'ERROR'	THEN
	Return lv_where
END IF
lv_sql = 'FROM ' + iv_summary_table + ' ' + iv_sum_tbl_type + ' ' + &
			lv_where + is_group_by

return lv_sql
end function

public function integer wf_load_summ_row (sx_summary_parm arg_parm);//***************************************************************
//	10/11/95	FNC	Take upperbound out of script
//	05/23/07	GaryR	Track 5031	Simulate ItemChanged event when setting columns
//***************************************************************

datawindowchild ldw_child
int i,j,lv_rc,lv_upperbound
long lv_rank, ll_child_row, ll_period_key
string lv_rs,lv_col, ls_find

setpointer(hourglass!)

string lc_z = 'zxzxzxzxz'  //set string to garbage
dw_fields.setredraw(false)
iv_sum_num = 0
lv_upperbound = upperbound(arg_parm.group_fields)  //10-11-95 FNC
for i = 1 to lv_upperbound                         //10-11-95 FNC
	iv_sum_num++
	iv_open_flag = true
	j = 1
	do 	
		lv_col = lefttrim(dw_fields.getvalue(ic_field_name+string(i),j))
		if lv_col <> '' then
			if pos(lv_col,' ') < 2 then  //if lv_col contains blanks (blank row) then fill with garbage so no match
				lv_col = lc_z
			end if
			if match(lv_col,arg_parm.group_fields[i].label) then
				lv_rc = dw_fields.setitem(1,ic_field_name+string(i),lv_col)
				lv_rc =wf_check_field()
				if lv_rc = -1 then exit
				dw_fields.postevent('check_dw')	// ItemChanged not firing
				lv_rc = dw_fields.setitem(1,ic_operator+string(i),arg_parm.group_fields[i].operator)	
				If arg_parm.group_fields[i].value <> '%'  then		//pat-d was putting in a % sign
					lv_rc = dw_fields.setitem(1,ic_value+string(i),arg_parm.group_fields[i].value)	
				End IF		//pat-d was putting ina % sign
				exit
			end if
		else
			exit
		end if
		j++
	loop until j = 50	
next

//set rank
lv_rank = arg_parm.rank
if lv_rank > 0 then
	sle_rank.text = string(lv_rank)
	if upper(arg_parm.rank_btn) = 'BOTTOM' then
		rb_bottom.checked = true
	elseif upper(arg_parm.rank_btn) = 'TOP' then
		rb_top.checked = true
	end if
end if

//set sort
ddlb_sorts.selectitem(arg_parm.sort,1)

dw_fields.setredraw(true)
return 0


end function

public function string wf_make_universe_sql ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	window function
//	Script Name:	wf_make_universe_sql
//	Description:	Build the 'From' clause and the 'Where' clause
//						when the 'Provider Universe' is checked.
//	Arguments:		None
//	Returns:			String - The 'From' and 'Where' clause
//************************************************************************

String	lv_where,		&
			lv_filter,		&
			lv_sql,			&
			ls_universe_table,	&
			ls_universe_where,	&
			ls_universe_tbl_type

setpointer(hourglass!)

sx_field lv_clear_fields[]
string lv_clear_asterisks[]
string lc_equal = ' = '
string lc_and = ' and '
string lc_not_zero = ' <> 0'
string lc_equal_zero = ' = 0'
string lc_asterisk = " = '*'"
string lc_no_asterisk = " <> '*'"
String lc_comma = ', '								//FDG 07/30/96

//clear structures
iv_fields = lv_clear_fields
iv_asterisk_col = lv_clear_asterisks

//f_debug_box ('Debug', 'Entering wf_make_universe_sql.')

dw_fields.accepttext()


//Get fields selected

IF	wf_select_fields ()	=	'ERROR'		THEN
	Return 'ERROR'
END IF

//Set the filter

IF	wf_set_filter ()	=	'ERROR'		THEN
	Return 'ERROR'
END IF

iv_summary_table = dw_rel.getitemstring(1,'table_name')

//get summary table type

iv_sum_tbl_type	=	inv_summ.fuo_get_tbl_type (iv_summary_table)

	//	Get the 2nd 'Universe' table name & where clause
ls_universe_table		=	inv_summ.fuo_get_universe_table()

ls_universe_tbl_type	=	inv_summ.fuo_get_universe_tbl_type()

ls_universe_where		=	inv_summ.fuo_get_universe_where()

//djp - added the group by part
//	Get the 'group by' clause if it exists.
is_group_by	=	inv_summ.fuo_create_group_by()		//FDG 07/30/96

//	Format the where clause
//djp - move where clause to after create group by
lv_where	=	wf_create_where()

IF	lv_where	=	'ERROR'		THEN
	Return	lv_where
END IF

lv_where					=	lv_where	+	ls_universe_where

lv_sql = 'FROM '+ iv_summary_table + ' ' + iv_sum_tbl_type + ', ' + &
			ls_universe_table + ' ' + ls_universe_tbl_type + ' ' + &
			lv_where + is_group_by
			
return lv_sql

end function

public function string wf_get_invoice_type ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	Window Function
//	Script Name:	wf_get_invoice_type
//
//	Description:	This function gets the invoice type from dw_rel
//	Arguments:		None
//	Returns:			String - Invoice type.  If none found, ''.
//************************************************************************

String	ls_inv_type
Long		ll_row

ll_row	=	dw_rel.GetRow()

IF	ll_row	<	1		THEN
	Return ''
END IF

ls_inv_type	=	dw_rel.GetItemString (ll_row, 'inv_type')

Return ls_inv_type

end function

public function integer wf_load_first_dw_field ();//**************************************************************
//LOAD FIRST ROW OF DW_FIELDS
//**************************************************************
// 10-11-95 FNC Take rowcount out of script
//	08/15/96	FDG	STARS35 - If there is a "Group by", then only
//						populate field_name_x with sum_rel column names
//						Group by SQL only permits non-summarized columns
//						to be selected.
// 10/27/04 MikeF SPR3650d Computed columns
//**************************************************************
int		li_index, li_rows
int		li_dd_ix 
string	ls_col_name, ls_desc, ls_lookup, ls_blanks1, ls_blanks2

// Make first dropdown visible
dw_fields.modify('field_name_1.visible=1')
dw_fields.modify('operator_1.visible=1')
dw_fields.modify('value_1.visible=1')

// Filter and sort dw_rel 
inv_summ.fuo_set_sum_rel_filter ('sum_fld1_seq<>0')
inv_summ.fuo_reset_sum_rel_filter()
dw_rel.setsort('sum_fld1')
dw_rel.sort()

// Default blank row and operator
dw_fields.setvalue('field_name_1',1,' ')
dw_fields.setitem(1,ic_operator+string(1),'=')

// Loop through the SUM_REL rows
li_dd_ix = 1
li_rows 	= dw_rel.RowCount()

FOR li_index = 1 TO li_rows
	ls_col_name = dw_rel.GetItemString(li_index,"SUM_FLD1")
	ls_desc  	= gnv_dict.event ue_get_col_desc		(iv_inv_type, ls_col_name)
	ls_lookup 	= gnv_dict.event ue_get_lookup_type	(iv_inv_type, ls_col_name)
	
	IF ls_desc = gnv_dict.ics_error &
	OR ls_desc = gnv_dict.ics_not_found THEN
		CONTINUE
	END IF

	ls_blanks1 = fill(' ',60  - len(ls_desc))
	ls_blanks2 = fill(' ',108 - len(ls_col_name) - 60)
	
	li_dd_ix++
	dw_fields.setvalue('field_name_1',li_dd_ix,ls_desc + ls_blanks1 + ls_col_name + ls_blanks2 + ls_lookup)
NEXT

return 0
end function

public function string wf_set_filter ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	window function
//	Script Name:	wf_set_filter
//	Description:	This function sets the filter for dw_rel.
//						
//	Arguments:		None
//	Returns:			String - 'ERROR'= unsuccessful, ''=successful 
//************************************************************************

int lv_row_count

	//	Filter sum_rel (dw_rel)
wf_filter_sum_rel()

	// There should only be 1 row after filtering

lv_row_count = dw_rel.rowcount()

if lv_row_count <> 1 then
	if lv_row_count = 0 then
		messagebox('Selection Error','There are no summaries of this combination.  Please select another field.')
		inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
		Return 'ERROR'
	else
		messagebox('Table Error','Error selecting from Sum_Rel.  Please contact your system administrator.')
		inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
		Return 'ERROR'
	end if
end if


return ''

end function

public subroutine wf_get_dw_fields ();
long lv_row,lv_pos
Long		ll_row
Integer	li,					&
			li_j,					&
			li_rc,				&
			li_rc_hold,			&
			li_upper
String	ls_tbl_types[],	&
			ls_filter =	''


ll_row				=	0
li						=	1
ls_tbl_types[li] 	= 	iv_inv_type

DO UNTIL ll_row	<	0
	li++
	ll_row	=	fx_get_next_stars_rel (ll_row, 'DP', iv_inv_type, ' ')
	IF ll_row		<	0		THEN
		exit
	END IF
	ls_tbl_types[li]	=	w_main.dw_stars_rel_dict.GetItemString (ll_row, "id_2")
LOOP

dw_fields.Reset()

dw_fields.InsertRow(0)

li_j = 0

li_upper = UpperBound(ls_tbl_types)      //10-11-95 FNC

//djp 9/19/96 - for time out
dw_label.settransobject(stars2ca)

FOR li = 1 TO li_upper                    //10-11-95 FNC
	li_rc = dw_label.retrieve(ls_tbl_types[li])
	IF li_rc > 0 AND li_rc <> li_rc_hold THEN
		li_j++
		iv_tbl_types[li_j] = ls_tbl_types[li]
		li_rc_hold = li_rc
	END IF
NEXT

For lv_row = 1 to dw_label.rowcount()
	lv_pos=pos(dw_label.getitemstring(lv_row,2),'/')
	if lv_pos=0 then lv_pos=99
	dw_label.setitem(lv_row,2,left(dw_label.getitemstring(lv_row,2),min(18,lv_pos - 1)))
Next

end subroutine

public function string wf_filter_sum_rel ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	window function
//	Script Name:	wf_filter_sum_rel
//	Description:	This function sets the filter for dw_rel.
//						
//	Arguments:		None
//	Returns:			String - 'ERROR'= unsuccessful, ''=successful 
//************************************************************************

int i,j,k,lv_len,lv_rc,lv_row_count,lv_pos,lv_upperbound
string lv_where,lv_line,lv_field_string,lv_filter = ''
string lv_col_name,lv_sql,lv_temp,lv_temp2,lv_where_message
boolean lv_found

sx_field lv_clear_fields[]
string lv_clear_asterisks[]

string lc_equal = ' = '
string lc_and = ' and '
string lc_not_zero = ' <> 0'
string lc_equal_zero = ' = 0'
string lc_asterisk = " = '*'"
string lc_no_asterisk = " <> '*'"
String lc_comma = ', '								//FDG 07/30/96

//Get table name
//lv_filter = 'period =' + istr_in_parm.period

lv_upperbound = upperbound(iv_fields)    //10-11-95 FNC

for i = 1 to lv_upperbound               //10-11-95 FNC
	if i > 1 then 
		lv_filter = lv_filter + lc_and
	end if
	lv_filter = lv_filter + ic_sum_fld + string(i) + lc_equal + &
					"'" + iv_fields[i].col_name + "'"	
	lv_filter = lv_filter + lc_and + ic_sum_fld+string(i) + &
					ic_seq + lc_not_zero
next


IF	lv_upperbound	>	0		THEN
	lv_filter = lv_filter + lc_and + ic_sum_fld + string(i) + &
					ic_seq + lc_equal_zero
END IF

	//	Save the filter so it can be used later
inv_summ.fuo_set_sum_rel_filter (lv_filter)

	//	Filter sum_rel (dw_rel)
inv_summ.fuo_reset_sum_rel_filter ()

Return ''
end function

public function integer wf_load_dw_fields (string arg_filter, string arg_field, integer arg_field_num);//LOAD DW FIELDS, BASED ON FILTER AND FIELD NUMBER ARGUMENTS

//**************************************************************
//10-11-95 FNC Take rowcount out of script
//02-06-96 HRB put the rowcount from above after each sort of dw
//07-23-96 FNC STARCARE Prob #920 Take out call to fx_set_win_colors. 
//01-02-98 FDG Stars 3.6 (Prob 201) - Set windows colors after
//					changing background color
//03-07-00 NLG Patient profiles. Special Pharmacy summary column
//					DRUGCAT must be loaded in dw fields for certain
//					pharmacy summaries.
//11/01/00 GaryR	2920c	Standardize windows colors
//11/22/00 GaryR	Stars 4.7 DataBase Port - Conversion of data types
//	FDG	2/16/01	Lookup color not displaying
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/29/09	GaryR	GNL.600.5633.005	Provide mouse alternative navigation
//**************************************************************

string lv_rs,lv_temp_col_name,lv_col_name,lv_rel_col_name,lv_prior_col_name
string lv_field_name,lv_blank,lv_blank2,lv_filter,lv_col_string,lv_col
string lv_selected_col_name, ls_acc
int i,j,k,l,lv_len,lv_len2,lv_rc
int lv_rowcount1,lv_rowcount2
boolean lv_found,lv_colors

setpointer(hourglass!)

//set lookup field
if trim(right(arg_field,2)) <> '' then  //had to use this instead of below since it duplicates the first field
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+".tag = 'LOOKUP'")
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+".color="					+	&
				String(stars_colors.lookup_text))					//FDG 2/16/01
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+".background.color="	+	&
				String(stars_colors.lookup_back))					//FDG 2/16/01
	//	Set accessibility properties
	ls_acc = Trim( Left( arg_field, 60 ) )
	ls_acc = '"Lookup Field - ' + ls_acc + '"~t"Lookup Field - ' + ls_acc + '"'
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+ ".AccessibleName='" + ls_acc + "'")
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+ ".AccessibleDescription='" + ls_acc + "'")
else
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+".tag = ''")
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+".color="	+	&
				String(stars_colors.input_text))						//FDG 2/16/01
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+".background.color="	+	&
				String(stars_colors.input_back))						//FDG 2/16/01
	//	Set accessibility properties
	ls_acc = Trim( Left( arg_field, 60 ) )
	ls_acc = '"' + ls_acc + '"~t"' + ls_acc + '"'
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+ ".AccessibleName='" + ls_acc + "'")
	lv_rs = dw_fields.modify(ic_value+string(arg_field_num)+ ".AccessibleDescription='" + ls_acc + "'")
end if

//	Save this filter for future processing
inv_summ.fuo_set_sum_rel_filter (arg_filter)

//	Filter dw_rel
inv_summ.fuo_reset_sum_rel_filter()

lv_rc = dw_rel.setsort(ic_sum_fld+string(arg_field_num+1)+' A')
lv_rc = dw_rel.sort()
lv_filter = arg_filter

lv_rc = dw_fields.setitem(1,ic_value + string(arg_field_num),'')

for i = arg_field_num+1 to ic_field_num

		if lv_prior_col_name <> '' then
			lv_filter = lv_filter + ' and ' + ic_sum_fld + string(i - 1) + &
							" = '" + lv_prior_col_name + "' and " + &
							ic_sum_fld + string(i) + ic_seq + ' <> 0 '
				//	Save this filter for future processing
			inv_summ.fuo_set_sum_rel_filter (lv_filter)
				//	Filter dw_rel
			inv_summ.fuo_reset_sum_rel_filter()
			lv_rc = dw_rel.setsort(ic_sum_fld+string(i+1)+' A')
			lv_rc = dw_rel.sort()			
			lv_rowcount1 = dw_rel.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort
			if lv_rowcount1 = 0 then         //10-11-95 FNC
				lv_rc = wf_clear_fields(i)
				inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
				if lv_rc = -1 then					
					return -1
				else
					return 0
				end if							
			end if			
		end if


	if dw_fields.describe(ic_field_name+string(i)+'.visible') = '1' then		


		lv_col_string = dw_fields.getitemstring(1,ic_field_name+string(i))
		if isnull(lv_col_string) then lv_col_string = ''
		lv_len = pos(lv_col_string,' ',ic_col_pos+1)
		lv_len = lv_len - ic_col_pos
		lv_selected_col_name = trim(mid(lv_col_string,ic_col_pos+1,lv_len))	
		lv_col_name = lv_selected_col_name
		lv_rowcount1 = dw_rel.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort
		for j = 1 to lv_rowcount1           //10-11-95 FNC
			lv_rel_col_name = dw_rel.getitemstring(j,ic_sum_fld+string(i))
			if lv_col_name = lv_rel_col_name then
				lv_found = true			
				exit
			end if
		next		
		if not lv_found then
			lv_rc = wf_clear_fields(i)
			if lv_rc = -1 then
				inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
				return -1
			end if
		else
			if i > arg_field_num + 1 then //only add to filter if > one level down
			end if
			k = 1
			lv_rc = dw_fields.clearvalues(ic_field_name + string(i))
			lv_rc = dw_fields.setvalue(ic_field_name+string(i),k,' ')
			lv_rc = dw_fields.setitem(1,ic_operator+string(i),'=')			
			lv_rowcount1 = dw_rel.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort
			for l = 1 to lv_rowcount1         //10-11-95 FNC
				lv_temp_col_name = dw_rel.getitemstring(l,ic_sum_fld+string(i))
				if lv_temp_col_name <> '' then //and lv_temp_col_name <> lv_col_name then
					lv_rowcount2 = dw_label.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort
					for j = 1 to lv_rowcount2    //10-11-95 FNC
						if lv_temp_col_name = dw_label.getitemstring(j,1) then
							lv_len = len(dw_label.getitemstring(j,2))
							lv_blank = fill(' ',60 - lv_len)
							lv_len2 = len(lv_temp_col_name)+len(lv_blank)+lv_len
							lv_blank2 = fill(' ',108 - lv_len2)
							lv_field_name = dw_label.getitemstring(j,2)+lv_blank&
									+lv_temp_col_name+lv_blank2+dw_label.getitemstring(j,3)
							exit
						end if
					next
					k++
					lv_rc = dw_fields.setitem(1,ic_operator+string(i),'=')
					lv_rc = dw_fields.setvalue(ic_field_name+string(i),k,lv_field_name)
					if lv_rc = -1 then
						messagebox('Error','Error loading fields.')
						inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
						return -1
					end if
					lv_col_name = lv_temp_col_name
				end if
			next
			dw_fields.setitem(1,ic_field_name+string(i),lv_col_string)
		end if	
	end if
   lv_rowcount1 = dw_rel.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort	
	if dw_fields.describe(ic_field_name+string(i)+'.visible') <> '1' and&
	  lv_rowcount1 > 0 then         //10-11-95 FNC
	     //elseif i = arg_field_num+1 then  //first field looked at is invisible
		lv_rs = dw_fields.modify(ic_field_name+string(i) + '.visible=1')
		lv_rs = dw_fields.modify(ic_operator+string(i) + '.visible=1')
		lv_rs = dw_fields.modify(ic_value+string(i) + '.visible=1')		
		k=1
		lv_rc = dw_fields.clearvalues(ic_field_name + string(i))
		lv_rc = dw_fields.setvalue(ic_field_name+string(i),k,' ')
		lv_rc = dw_fields.setitem(1,ic_operator+string(i),'=')
		lv_rowcount1 = dw_rel.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort
		for l = 1 to lv_rowcount1         //10-11-95 FNC
			lv_temp_col_name = dw_rel.getitemstring(l,ic_sum_fld+string(i))
			//if lv_temp_col_name <> lv_col_name then
				lv_rowcount2 = dw_label.rowcount()  //HRB 2/6/96 - the rowcount changes after each sort
				for j = 1 to lv_rowcount2   //10-11-95 FNC
					if lv_temp_col_name = dw_label.getitemstring(j,1) then
						lv_len = len(dw_label.getitemstring(j,2))
						lv_blank = fill(' ',60 - lv_len)
						lv_len2 = len(lv_temp_col_name)+len(lv_blank)+lv_len
						lv_blank2 = fill(' ',108 - lv_len2)
						lv_field_name = dw_label.getitemstring(j,2)+lv_blank&
								+lv_temp_col_name+lv_blank2+dw_label.getitemstring(j,3)
						exit
					else//NLG 3-7-00														*** start ***
						int li_rc
						long ll_rows
						string ls_tbl_type
						IF UPPER(lv_temp_col_name) = ics_drugcat THEN
							n_ds lds_phar_sum_drugcat, lds_drugcat
							
							//This datastore retrieves dictionary.elem_tbl_type for
							//all pharmacy summary tables that use DRUGCAT
							lds_phar_sum_drugcat = CREATE n_ds
							lds_phar_sum_drugcat.dataobject = 'd_phar_sum_%_drugcat'
							li_rc = lds_phar_sum_drugcat.SetTransObject(STARS2CA)
							ll_rows = lds_phar_sum_drugcat.retrieve()
							if ll_rows > 0 then 
								//Returns more than 1 row, but can use any of the rows
								ls_tbl_type = lds_phar_sum_drugcat.GetItemString(1,'elem_tbl_type')
							end if
							IF IsValid(lds_phar_sum_drugcat) THEN DESTROY lds_phar_sum_drugcat
							
							//This datastore uses the elem_tbl_type from above to get dictionary.elem_name
							//and elem_desc for column 'DRUGCAT'
							lds_drugcat = CREATE  n_ds
							lds_drugcat.dataobject = 'd_drugcat'
							li_rc = lds_drugcat.SetTransObject(STARS2CA)
							
							//11/22/00 GaryR	Stars 4.7 DataBase Port
							gnv_sql.of_get_substring( lds_drugcat )
							ll_rows = lds_drugcat.Retrieve(ls_tbl_type)
							IF ll_rows > 0 THEN
								lv_len = len(lds_drugcat.getitemstring(1,'elem_desc'))
								lv_blank = fill(' ',60 - lv_len)
								lv_len2 = len(lv_temp_col_name)+len(lv_blank)+lv_len
								lv_blank2 = fill(' ',108 - lv_len2)
								lv_field_name = lds_drugcat.getitemstring(1,'elem_desc')+lv_blank&
										+lv_temp_col_name+lv_blank2+lds_drugcat.getitemstring(1,'elem_lookup_type')
								IF IsValid(lds_drugcat) THEN DESTROY lds_drugcat
								exit
							END IF
						END IF
						//NLG 3-7-00															*** stop ***
					end if
				next
				k++
				lv_rc = dw_fields.setitem(1,ic_operator+string(i),'=')
				lv_rc = dw_fields.setvalue(ic_field_name+string(i),k,lv_field_name)
				if lv_rc = -1 then
					messagebox('Error','Error loading fields.')
					inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
					return -1
				end if
				lv_col_name = lv_temp_col_name
			//end if
		next
		if dw_fields.describe(ic_field_name+string(i+1)+'.visible') <> '1' then
			exit  //if next field is invisible exit
		end if
	else
		lv_prior_col_name = lv_selected_col_name //to use in filter for next level down
		continue //exit
	end if
	lv_prior_col_name = lv_selected_col_name //to use in filter for next level down
next

lv_col = dw_fields.getvalue(ic_field_name+'1',2)
if match(lv_col,'Bill Type') then
	lv_rs = dw_fields.modify(ic_field_name+"1.color=" + String( stars_colors.protected_text ) )
end if

inv_summ.fuo_reset_filter()	// Reset filter on dw_rel

return 0
end function

public function string wf_format_line (string arg_col_name, string arg_operator, string arg_value);/////////////////////////////////////////////////////////////
//	Script:	wf_format_line
//
//	Arguments:	1. arg_col_name (string)
//					2. arg_operator (string)
//					3. arg_value (string)
//
//	Returns:		String
//
//	Description;
// 	fashioned after wf_format_line of w_sampling_analysis_new
// 	returns table type for column and formatted line
/////////////////////////////////////////////////////////////
//	History
//
//	FDG	03/10/98	Track 914 Rls40.  Replace fx_load_crit_globals
//						with inv_queryengine.uf_load_where() so
//						that query engine will open.
// AJS   08/03/98 Stars 4.0 - Track 1522.  Pass period key to QE if present.
// FNC	04/20/99	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
// NLG	03/07/00	Patient profiles. DRUGCAT is a pharmacy summary column
//						that needs special handling.
//	FDG	12/14/00	Stars 4.7.  Make the checking of data types DBMS-independent.
// MikeF	10/02/03 2989d	Use Filters with summaries - rewrote
//	GaryR	09/02/05	Track 4492d	Accomodate trailing spaces in data
// 	HYL 		01/13/06 Track 4614d	Add alias in front of column names in where clause for fields user selected to avoid 'column ambiguously defined' error
// 10/15/09 RickB LKP.650.5678.001 Added BETWEEN to the 'invalid operator' message.
//	11/13/09	GaryR	LKP.650.5678	Validate the length of values
// 11/16/09 RickB LKP.650.5678 Added + 4 to length validation to account for spaces and parens
//										in subset create SQL.
/////////////////////////////////////////////////////////////

string		ls_line, ls_value, ls_operator, ls_format_value, ls_type
string		ls_filter, ls_where, ls_desc, ls_vals[]
Integer		li_len
n_cst_string	lnv_string

// Parse the value and set operands
ls_value = RightTrim(arg_value)

IF gnv_app.of_is_filter_name( ls_value ) THEN
	
	CHOOSE CASE arg_operator
		CASE '=', 'IN'
			ls_operator = "IN"
		CASE '<>', 'NOT IN'
			ls_operator = 'NOT IN'
		CASE ELSE
			RETURN "!Invalid operator used with a filter. Must be 'IN', 'NOT IN', '=' or '<>'."
	END CHOOSE

	ls_format_value = ls_value
	ls_filter = Upper(mid(ls_value,2))
	
	ls_type = gnv_app.of_get_filter_type( ls_filter )
	
	CHOOSE CASE ls_type
		CASE "CHAR"
			ls_format_value = "(SELECT FILTER_DATA FROM " + gnv_sql.of_get_database_prefix( stars2ca.database ) + &
									"FV_" + ls_filter + ") "
		CASE 'ERROR' 			
			RETURN "!Filter " + ls_filter + " does not exist."
		CASE ELSE
			RETURN "!Filter " + ls_filter + " is of type " + ls_type + " and cannot be used with summaries."
	END CHOOSE
	
ELSE

	IF pos(ls_value,'%') > 0  	THEN
		CHOOSE CASE arg_operator
			CASE 'LIKE', 'NOT LIKE'
				ls_operator = arg_operator
			CASE ELSE
				RETURN "!Invalid operator used with a wildcard. Must be LIKE or NOT LIKE"
		END CHOOSE
	END IF
	
	IF pos(ls_value,',') > 0  	THEN
		CHOOSE CASE arg_operator
			CASE 'IN', 'NOT IN', 'BETWEEN'
				ls_operator = arg_operator
			CASE ELSE
				RETURN "!Invalid operator used with multiple values. Must be IN, NOT IN or BETWEEN."
		END CHOOSE
		
		//	Count two single quotes for each value + 4 for spaces and parens
		ls_vals = lnv_string.of_stringtoarray( arg_value, "," )
		li_len = (UpperBound( ls_vals )*2) + Len( arg_value ) + 4
		
		IF li_len > 255 THEN
			Return "!The values entered for " + arg_col_name + " exceed the field size limit. ~n~r" + &
								"If you would like to include additional codes in your " + &
								"criteria, please create a filter."
		END IF
	END IF

	IF len(ls_value) = 0 	&
	OR isnull(ls_value) 		THEN
		ls_operator = '<>'	
		ls_value		= '*'
	ELSE
		ls_operator = arg_operator
	END IF

	ls_format_value = format_where(ls_value,ls_operator,arg_col_name)

	IF left(ls_format_value,1) = '!' THEN
		RETURN ls_format_value
	END IF

END IF

RETURN " AND " + iv_sum_tbl_type + "." + arg_col_name + " " + ls_operator + " " + ls_format_value // HYL 01/13/06 Track 4614d
end function

public function string wf_create_where ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	window function
//	Script Name:	wf_create_where
//	Description:	Build the 'Where' clause
//	Arguments:		None
//	Returns:			String - The 'Where' clause
//************************************************************************
//	Modification History
//
//	FDG	05/18/98	Track 1229.  TYPE_BILL is only 2 bytes in the summary
//						but is 3 bytes in the claim data.  When TYPE_BILL is
//						used in the Where criteria, change it to like 'xx%'.
//
// FNC	04/20/99	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
// 10/02/03 MikeF	2989d	Use Filters with summaries - Rewrote function.
// 10/21/03 MikeF 3681d Missing Asterisk cols for trending
//	01/26/05	GaryR	Track 4251d	Add check for NOTFOUND in addition to ERROR
// 07/15/05 Katie Track 3661d Change BLANKS to ' ' with single space.
// 10/13/2005 Katie Track 4533d Removed Case Sensitivity with BLANKS.
//************************************************************************
String 	ls_where, ls_rel_filter, ls_fld_name, ls_fld_type, ls_line, ls_sum_flag
String	ls_column, ls_value, ls_operator
int		li_rc, li_rows, li_asterisk = 0
int		loop_ix1, loop_ix2, loop_ix3
boolean	lb_found

ii_index = 0
istr_in_parm.period = string(uo_1.uf_return_period())					
istr_in_parm.period_key = uo_1.uf_return_key()		

inv_queryengine.uf_clear_query_parms()	

If istr_in_parm.period_key > 0 then						
	inv_queryengine.uf_set_period_key(int(istr_in_parm.period_key)) 
	inv_queryengine.uf_set_period_function('SUM')					
End If

// Filter SUM_REL_ROWS
inv_summ.fuo_reset_filter()
ls_rel_filter = inv_summ.fuo_get_function_filter() 					+ &
					" AND TABLE_NAME = '" + iv_summary_table 	+ "'" 	+ &
					" AND SUM_FLD1_SEQ = 0"
li_rc	=	dw_rel.setfilter (ls_rel_filter)
li_rc	=	dw_rel.filter()

li_rows = dw_rel.rowcount()

IF li_rows <> 1 THEN
	MessageBox('Table Error','Error selecting table from Sum_Rel.  Please contact your system administrator.')
	inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
	Return 'ERROR'
END IF

// Set WHERE clause
ls_where 	= 'WHERE ' + iv_sum_tbl_type + '.PERIOD = ' + string(istr_in_parm.period)
ls_sum_flag = dw_rel.getitemstring( 1, "SUM_FLAG")  

FOR loop_ix1 = 1 to ic_field_num			
	// ic_field_num = 6, ic_sum_fld = 'sum_fld'
	ls_fld_name = trim(dw_rel.getitemstring (1, ic_sum_fld + string(loop_ix1) ))
	lb_found = FALSE
	
	IF len(ls_fld_name) = 0	&
	OR isnull(ls_fld_name)	THEN
		EXIT
	END IF
		
	FOR loop_ix2 = 1 to UpperBound(iv_fields)
		
		IF iv_fields[loop_ix2].col_name = ls_fld_name THEN
			lb_found = TRUE
			
			ls_line = wf_format_line(iv_fields[loop_ix2].col_name,iv_fields[loop_ix2].operator,iv_fields[loop_ix2].value)
			
			IF left(ls_line,1) = '!' THEN
				MessageBox("Summary Error",mid(ls_line,2),StopSign!,OK!)
				dw_fields.setrow(1)
				IF pos(ls_line,"Filter") > 0 THEN
					dw_fields.setcolumn( ic_value + string(loop_ix2) )
				ELSE
					dw_fields.setcolumn( ic_operator + string(loop_ix2) )
				END IF

				dw_fields.setfocus( )
				
				RETURN "ERROR"
			END IF
			
			ls_where += ls_line
			
			// Set the table type
			IF ls_fld_name = ics_drugcat THEN
				iv_fields[loop_ix2].tbl_type = iv_inv_type
			ELSE
				FOR loop_ix3 = 1 TO Upperbound(iv_tbl_types)
					ls_fld_type = gnv_dict.event ue_get_data_type( iv_tbl_types[loop_ix3], ls_fld_name)
					CHOOSE CASE ls_fld_type 
						CASE gnv_dict.ics_error
							RETURN "ERROR"
						CASE gnv_dict.ics_not_found 
							CONTINUE
						CASE ELSE
							iv_fields[loop_ix2].tbl_type = iv_tbl_types[loop_ix3]
							EXIT						
					END CHOOSE
				NEXT
			END IF

			IF len(trim(iv_fields[loop_ix2].value)) > 0 THEN
				ii_index++
				ls_operator = iv_fields[loop_ix2].operator 
				ls_value 	= iv_fields[loop_ix2].value 
				ls_column	= iv_fields[loop_ix2].col_name
				
				IF iv_fields[loop_ix2].col_name = "TYPE_BILL" THEN
				
					CHOOSE CASE iv_fields[loop_ix2].operator 
						CASE "="  
							ls_operator = "LIKE"
						CASE "<>" 
							ls_operator = "NOT LIKE"
						CASE ELSE
							ls_operator = iv_fields[loop_ix2].operator 
					END CHOOSE
		
					IF NOT right(trim(iv_fields[loop_ix2].value),1) = '%' THEN
						ls_value = iv_fields[loop_ix2].value + '%'
					END IF
					
				END IF
						
				IF iv_fields[loop_ix2].col_name = ics_drugcat THEN
					ls_value 	= "@" + iv_fields[loop_ix2].value 
					ls_column 	= "NDC_CODE" 
				END IF
	
				if UPPER(ls_value) = 'BLANKS' then
					iv_fields[loop_ix2].value = ' '
				END IF
				
				// Set the Query Engine values if hitting 'Details' button
				inv_queryengine.uf_load_where	('',							&
											iv_fields[loop_ix2].tbl_type,		&
											ls_column,								&
											ls_operator,							&
											ls_value,								&
											'',										&
											"AND",									&
											ii_index)

			END IF
			
		END IF

	NEXT

	IF NOT lb_found AND len(trim(is_group_by)) = 0 THEN
		ls_where += wf_format_line(ls_fld_name,"=","*")
		li_asterisk++
		iv_asterisk_col[li_asterisk] = ls_fld_name
	END IF

NEXT
RETURN ls_where
end function

public function string wf_select_fields ();//************************************************************************
//	Object Name:	w_summary_financial
//	Object Type:	window function
//	Script Name:	wf_select_fields
//	Description:	Get the fields selected and place them in iv_fields.
//	Arguments:		None
//	Returns:			String - 'ERROR' = unsuccessful, '' = successful
//************************************************************************
//
//	11/13/01	GaryR	Track 2541	List of values ending with "," returns all rows for Summaries
//
//************************************************************************

Integer	i,				&
			li_len
String	ls_field_string,	&
			ls_temp				//	11/13/01	GaryR	Track 2541

FOR i = 1 to ic_field_num		//ic_field_num = 6, ic_field_name = 'field_name_'
	IF dw_fields.describe(ic_field_name+string(i)+'.visible') = '1' THEN
		ls_field_string = dw_fields.getitemstring(1,ic_field_name+string(i))		
		IF len(ls_field_string)	>	1		&
		AND NOT IsNull(ls_field_string) THEN
			li_len = pos(ls_field_string,'    ',1)
			iv_fields[i].label = trim(left(ls_field_string,li_len - 1))
			li_len = pos(ls_field_string,' ',ic_col_pos+1)
			li_len = li_len - ic_col_pos
			iv_fields[i].col_name = trim(mid(ls_field_string,ic_col_pos+1,li_len))
			iv_fields[i].lookup_type = trim(mid(ls_field_string,ic_lookup_pos+1,2))
			iv_fields[i].operator = dw_fields.getitemstring(1,ic_operator+string(i))
			iv_fields[i].value = dw_fields.getitemstring(1,ic_value+string(i))
			//	11/13/01	GaryR	Track 2541 - Begin
			ls_temp = Trim( iv_fields[i].value )
			IF Right( ls_temp, 1 ) = "," THEN iv_fields[i].value = Left( ls_temp, Len(ls_temp ) - 1 )
			//	11/13/01	GaryR	Track 2541 - End
		ELSE
			IF i = 1	then //						&
//			AND is_group_by	=	''		THEN
				messagebox('Entry Error','Please select field(s).')
				inv_summ.fuo_reset_filter()	// Reset filter on dw_rel
				Return 'ERROR'
			END IF
		END IF
	ELSE
		Exit
	END IF
NEXT

inv_summ.fuo_set_sx_field(iv_fields)

Return ''
end function

public function integer wf_check_field ();//************************************************************************

string lv_sel_col_name,lv_field_name,lv_col_name,lv_filter
string lv_sel_col_string,lv_col_string
int i,lv_sel_field_num,lv_rc,lv_len
string lc_equal,lc_and,lc_not_zero
datawindowchild lv_ddlb
string ls_univ_fields[]
boolean lb_show_univ

setpointer(hourglass!)

lc_equal = ' = '
lc_and = ' and '
lc_not_zero = ' <> 0'

if iv_open_flag then
	lv_field_name = ic_field_name + string(iv_sum_num)
else
	lv_field_name = dw_fields.getcolumnname()
end if

if match(lv_field_name,ic_field_name) or iv_open_flag then  //if selected ddlb or filling w/ summ fields
	lv_sel_col_string = dw_fields.getitemstring(1,lv_field_name)
	if isnull(lv_sel_col_string) then
		return -1
	end if
	lv_sel_field_num = integer(right(lv_field_name,1))
	lv_filter =''
	for i = 1 to lv_sel_field_num
		lv_col_string = dw_fields.getitemstring(1,ic_field_name+string(i))
		lv_len = pos(lv_col_string,' ',ic_col_pos+1)
		lv_len = lv_len - ic_col_pos
		if lv_len < 0 and lv_sel_field_num = 1 then  // ABO 12/23/96 prob #229 stars35 start
			Return -1
		end if                                       // ABO 12/23/96 end
		lv_col_name = mid(lv_col_string,ic_col_pos+1,lv_len)
		ls_univ_fields[i]=trim(lv_col_name)
		if lv_col_name='' then
			lv_sel_field_num --
			lv_sel_col_string=dw_fields.getitemstring(1,ic_field_name+string(lv_sel_field_num))
			if lv_sel_field_num=0 then
				wf_clear_fields(2)
				return -1
			end if
			exit
		end if
		if i > 1 then 
			lv_filter = lv_filter + lc_and
		end if
		lv_filter = lv_filter + ic_sum_fld+string(i)+lc_equal+"'"+lv_col_name+"'"
	next
	lv_filter = lv_filter +lc_and+ic_sum_fld+string(lv_sel_field_num+1)+ic_seq+lc_not_zero
	lv_rc = wf_load_dw_fields(lv_filter,lv_sel_col_string,lv_sel_field_num)
end if

iv_open_flag = false

Return 0
end function

public function string wf_make_select ();//**********************************************************************************
//
//		w_summary_financial.wf_make_select()  returns string
//		get columns for SELECT, first the grouping fields then the calculated fields
//
//**********************************************************************************
//
//	08/02/96	FDG	STARS35 - The select statement must allow for 'Group by'
//						and for 'Provider Universe'.  The table type must also
//						be added to the select.  At the end of the Select, get
//						any calculated columns from table sum_select.
//	10/20/95	FNC	Take out connects and disconnects
//	10/11/95	FNC	Take upperbound out of script
//	03/22/02 FDG	Track 2916d.  If PRESC_PHYS_SPEC & PRESC_PHYS are selected
//						columns, then PRESC_PHYS does not get included in sql (it should).
//	05/24/02 GaryR	Track 3067d	Correct bug caused by fix of Track 2916 above.
//	10/21/04 MikeF	Track 3650d Add filter to limit to Display Seq > 0
//	09/19/06	GaryR	Track 4541	Perpetuate any calculated columns from Summary to Trending
//**********************************************************************************

String	lv_sel,			&
			lv_col_name,	&
			lv_where_message, &
			ls_calc,			&	
			ls_provider
Int		i,					&
			lv_upperbound
Long		ll_row,			&
			ll_max_rows

setpointer(hourglass!)

//FDG 08/02/96 -	IF the Select has a 'group by' clause, call the routine
//						to create this type of select

IF	is_group_by	<>	''			THEN
	lv_sel	=	inv_summ.fuo_create_group_by_select (iv_sum_tbl_type)
END IF

//Get the data from dictionary for this table type
dw_dict_cols.settransobject(stars2ca)
ll_max_rows	=	dw_dict_cols.Retrieve ( iv_sum_tbl_type )

// Filter by rows with DIsplay Seq > 0
dw_dict_cols.SetFilter("DISP_SEQ > 0")
ll_max_rows = dw_dict_cols.Filter()
ll_max_rows = dw_dict_cols.RowCount()

//first get grouping selected
lv_upperbound = upperbound(iv_fields)  //10-11-95 FNC
for i = 1 to lv_upperbound             //10-11-95 FNC
	// FDG 03/22/02 - look for entire value
	//if pos(lv_sel,iv_fields[i].col_name)=0 then
	
	//	05/24/02 GaryR	Track 3067d
	//if pos(lv_sel, iv_fields[i].col_name + ' ') = 0 then
	if Pos( lv_sel, "." + iv_fields[i].col_name + "," ) = 0 then
		if Trim (lv_sel) = '' then 
			lv_sel = iv_sum_tbl_type + '.' + iv_fields[i].col_name + ' '
		else
			lv_sel = Trim(lv_sel) + ',' + iv_sum_tbl_type + '.' + iv_fields[i].col_name + ' '
		end if
	end if
next

lv_sel	=	Trim (lv_sel)		// FDG 03/22/02

//Then get rest of columns from the summary table that have a 
//display sequence > 0
FOR	ll_row	=	1	TO	ll_max_rows
	lv_col_name	=	dw_dict_cols.GetItemString ( ll_row, 'elem_name')
	if dw_rel.getitemstring(1,'sum_flag')='G' and dw_dict_cols.getitemstring(ll_row,'elem_target_type')='G' then continue
	if pos(lv_sel,lv_col_name)=0 then
		if lv_sel = '' then 
			lv_sel = iv_sum_tbl_type + '.' + lv_col_name 
		else
			lv_sel = lv_sel + ',' + iv_sum_tbl_type + '.' + lv_col_name
		end if
	end if
NEXT

//	Get any required calculated columns from sum_select
ls_calc	=	inv_summ.fuo_get_calculated_fields()
istr_in_parm.s_calc_cols = Trim( ls_calc )

IF	ls_calc	>	' '	THEN
	ls_calc	=	', '	+	ls_calc
END IF

if upper(left(lv_sel,6))='SELECT' THEN
	lv_sel = lv_sel+ls_calc
else
	lv_sel = 'SELECT ' + lv_sel	+	ls_calc
end if

//	If the 'Provider Universe' is checked, then add the 'Provider
//	Universe' columns (which come from another table). 

IF	cbx_provider_universe.checked	=	TRUE		THEN
	ls_provider	=	inv_summ.fuo_get_universe_select()
	IF	ls_provider	>	' '	THEN
		ls_provider	=	', '	+	ls_provider
	END IF
	lv_sel		=	lv_sel	+	ls_provider
END IF

//f_debug_box ('Debug', 'Leaving wf_make_select.  lv_sel =' + lv_sel)

Return lv_sel

end function

public function integer wf_load_ddlbs ();//************************************************************************
//		Object Type:	Window Function
//		Object Name:	w_summary_financial
//		Script Name:	wf_load_ddlbs
//
//
//************************************************************************
//
//10-20-95 FNC Take out connects and disconnects
//
//11-20-95 FDG Access Stars_rel via w_main.dw_stars_rel_dict
//
//07-30-96 FDG	STARS35 - change ddlb_sorts to default to Group Seq #1
//					instead of 'Billed Amount'
//02-25-00 NLG Patient profile changes.  Comment code that fills ddlb_sort
//				DDLB_sort replaced by user object uo_sorts.
//************************************************************************

//FILL SORT & PERIOD DDLBS
//
//string lv_yr_01,lv_yr_02,lv_yr_03,lv_base_type,lv_where_message
//int i,lv_rc
//long	ll_row										//FDG 11/20/95
//long	ll_group_seq,	ll_found_row = 0				//FDG 07/30/96
//
//setpointer(hourglass!)
//
//ll_row	=	fx_filter_stars_rel_1 ('QT', gv_sys_dflt, iv_inv_type)
//
//IF	ll_row	<	1		THEN
//	Messagebox('Error','Unable to retrieve base type.')
//	Return -1
//END IF
//
//lv_base_type	=	w_main.dw_stars_rel_dict.GetItemString (1, "KEY6")
//
//DECLARE Sort CURSOR FOR
//	SELECT group_label,
//			 group_col_name,
//			 group_seq
//	FROM Defined_Query_Groups
//	WHERE WIN_ID = 'W_SUMMARY_FINANCIAL'
//	AND SYS_ID = :gv_sys_dflt
//	AND BASE_TYPE = :lv_base_type
//	AND QUERY_TYPE = 'SORT'
//	USING stars2ca;
//
//OPEN Sort;
//if stars2ca.of_check_status() <> 0 then
//	//HRB - 7/28/95 - swat
//	lv_where_message = "WHERE WIN_ID = 'W_SUMMARY_FINANCIAL' AND SYS_ID = :"+gv_sys_dflt+"	AND BASE_TYPE = :"+lv_base_type+" AND QUERY_TYPE = 'SORT'"
//   COMMIT using stars2ca;
//   if stars2ca.of_check_status() <> 0 then
//      messagebox('ERROR','Error performing commit in wf_load_ddlbs')
//   end if                             //10-20-95 FNC End
//	Messagebox('Error','Unable to open Sort Cursor: '+lv_where_message)
//	return -1
//end if
//i=0
//do while stars2ca.sqlcode = 0
//	i++
//	FETCH Sort
//		INTO	:iv_sort[i].label,
//				:iv_sort[i].col_name,
//				:ll_group_seq;
//	if stars2ca.of_check_status() = 100 then exit
//	if stars2ca.sqlcode <> 0 then
//		//HRB - 7/28/95 - swat
//		lv_where_message = "WHERE WIN_ID = 'W_SUMMARY_FINANCIAL' AND SYS_ID = :"+gv_sys_dflt+"	AND BASE_TYPE = :"+lv_base_type+" AND QUERY_TYPE = 'SORT'"
//      COMMIT using stars2ca;
//      if stars2ca.of_check_status() <> 0 then
//         messagebox('ERROR','Error performing commit in wf_load_ddlbs')
//      end if                             
//		Messagebox('Error','Unable to fetching Sort Cursor: '+lv_where_message)
//		return -1
//	end if
//	ddlb_sorts.additem(iv_sort[i].label)
////FDG	07/30/96 begin
//	IF	ll_group_seq	=	1		THEN
//		ll_found_row	=	i	
//		ddlb_sorts.SelectItem(i)
//	END If
////FDG	07/30/96 end
//loop
//
//	// If no rows are selected, select the first row
//IF	ll_found_row	<	1		THEN
//	ddlb_sorts.SelectItem (1)
//END IF
////FDG	07/30/96 end
//
//CLOSE Sort;
//if stars2ca.of_check_status() <> 0 then
//	//HRB - 7/28/95 - swat
//	lv_where_message = "WHERE WIN_ID = 'W_SUMMARY_FINANCIAL' AND SYS_ID = :"+gv_sys_dflt+"	AND BASE_TYPE = :"+lv_base_type+" AND QUERY_TYPE = 'SORT'"
//	//sqlcmd('DISCONNECT',Stars2ca,'',2)   10-20-95 FNC Start
//   COMMIT using stars2ca;
//   if stars2ca.of_check_status() <> 0 then
//      messagebox('ERROR','Error performing commit in wf_load_ddlbs')
//   end if                             //10-20-95 FNC End
//	Messagebox('Error','Unable to close Sort Cursor: '+lv_where_message)
//	return -1
//end if
//
//COMMIT using stars2ca;
//if stars2ca.of_check_status() <> 0 then
//   errorbox(stars2ca,'Error performing commit in wf_load_ddlbs')
//   return -1
//end if                             

//NLG 2-25-00 Call ue_load_sort to load uo_sort
int li_rc

SetPointer(hourglass!)
//li_rc = this.event ue_load_sort()

//FILL FUNCTION DDDW AND DEFAULT TO SUM
uo_functions.uf_load_dddw(iv_inv_type)

return 0
end function

event open;call super::open;//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_summary_financial
//		Event Name:		Open
//
//
//************************************************************************
//
//	06-05-97 FNC	Track 89 (3.6) FS/TS156. Take out call to colors
//					so that the period dddw is not reset. Move it to the
//					open event so that it is only called once.
//
//	03/10/98 FDG	Track 914.  Use the query engine service.
//	11/22/00 GaryR	Stars 4.7 DataBase Port - Conversion of data types
//	11/05/03	MikeF	3685d	Error with Patient summaries coming from w_summ_rpt 
//************************************************************************

string 	lv_tbl_types[], lv_rs, lv_col
int 		lv_rc
long		ll_row												// FDG 11/20/95

this.SetRedraw(FALSE)			// FDG 10/16/95

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Summary Analysis Window...')

iv_inv_type = istr_in_parm.invoice_type
iv_header = istr_in_parm.header
this.title = this.title + iv_header

This.of_set_queryengine (TRUE)	//	FDG 03/10/98

inv_summ		=	CREATE	u_nvo_summary						//FDG 07/30/96

//PUT RELATIONSHIP TABLE INTO INVISIBLE DW & LABELS INTO INVISIBLE DW

lv_rc = dw_rel.settransobject(stars2ca)
lv_rc = dw_rel.retrieve(iv_inv_type)

	// Register istr_in_parm and dw_rel to inv_summ
inv_summ.fuo_set_summary_parm (istr_in_parm)
inv_summ.fuo_set_dw (dw_rel)

lv_rc = dw_label.settransobject(stars2ca)
//11/22/00 GaryR	Stars 4.7 DataBase Port
gnv_sql.of_get_substring( dw_label )

	//	Fill the data for dw_fields
wf_get_dw_fields()

lv_rc = wf_load_ddlbs()

if lv_rc = -1 then
	setmicrohelp(w_main,'Error loading window (ddlb)')
	This.SetRedraw(TRUE)							//	FDG 04/01/96
	return
end if

//FDG 07/30/96 Begin - Fill sx_summary_parm with period & function.  Then
//					filter dw_rel

istr_in_parm.period			=	String (uo_1.uf_return_period() )
istr_in_parm.period_key		=	uo_1.uf_return_key()
istr_in_parm.function_nm	=	uo_functions.uf_get_function()

	// Register istr_in_parm to inv_summ.  fuo_filter_dw requires
	//	istr_in_parm to be registered.
inv_summ.fuo_set_summary_parm (istr_in_parm)

	//	Register dw_sum_select & dw_dict_cols for future processing
inv_summ.fuo_set_dw_sum_select ( dw_sum_select )
inv_summ.fuo_set_dw_dict_cols ( dw_dict_cols )

//FDG 07/30/96 End

iv_open_flag = true //used in wf_check_fields to preload certain fields
if gv_summ_flg then  //comming from SUMM button on report window
	wf_load_summ_row(istr_in_parm)	
	this.event ue_pre_load_sort( )
end if

	// Get dw_fields 
//This.TriggerEvent ('ue_reset_window')

gv_summ_flg = false
iv_open_flag = false

this.SetRedraw(TRUE)			// FDG 10/16/95

//dw_fields.setredraw(true)
setmicrohelp(w_main,'Ready')
end event

on w_summary_financial.create
int iCurrent
call super::create
this.dw_dict_cols=create dw_dict_cols
this.dw_sum_select=create dw_sum_select
this.uo_functions=create uo_functions
this.uo_1=create uo_1
this.cbx_provider_universe=create cbx_provider_universe
this.st_count=create st_count
this.dw_label=create dw_label
this.dw_rel=create dw_rel
this.dw_fields=create dw_fields
this.cb_close=create cb_close
this.cb_clear=create cb_clear
this.cb_save=create cb_save
this.cb_more_crit=create cb_more_crit
this.cb_view=create cb_view
this.cb_query=create cb_query
this.ddlb_sorts=create ddlb_sorts
this.sle_rank=create sle_rank
this.rb_bottom=create rb_bottom
this.rb_top=create rb_top
this.gb_fields=create gb_fields
this.gb_rank=create gb_rank
this.gb_sort=create gb_sort
this.uo_sort=create uo_sort
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dict_cols
this.Control[iCurrent+2]=this.dw_sum_select
this.Control[iCurrent+3]=this.uo_functions
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.cbx_provider_universe
this.Control[iCurrent+6]=this.st_count
this.Control[iCurrent+7]=this.dw_label
this.Control[iCurrent+8]=this.dw_rel
this.Control[iCurrent+9]=this.dw_fields
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.cb_clear
this.Control[iCurrent+12]=this.cb_save
this.Control[iCurrent+13]=this.cb_more_crit
this.Control[iCurrent+14]=this.cb_view
this.Control[iCurrent+15]=this.cb_query
this.Control[iCurrent+16]=this.ddlb_sorts
this.Control[iCurrent+17]=this.sle_rank
this.Control[iCurrent+18]=this.rb_bottom
this.Control[iCurrent+19]=this.rb_top
this.Control[iCurrent+20]=this.gb_fields
this.Control[iCurrent+21]=this.gb_rank
this.Control[iCurrent+22]=this.gb_sort
this.Control[iCurrent+23]=this.uo_sort
this.Control[iCurrent+24]=this.gb_1
this.Control[iCurrent+25]=this.gb_2
end on

on w_summary_financial.destroy
call super::destroy
destroy(this.dw_dict_cols)
destroy(this.dw_sum_select)
destroy(this.uo_functions)
destroy(this.uo_1)
destroy(this.cbx_provider_universe)
destroy(this.st_count)
destroy(this.dw_label)
destroy(this.dw_rel)
destroy(this.dw_fields)
destroy(this.cb_close)
destroy(this.cb_clear)
destroy(this.cb_save)
destroy(this.cb_more_crit)
destroy(this.cb_view)
destroy(this.cb_query)
destroy(this.ddlb_sorts)
destroy(this.sle_rank)
destroy(this.rb_bottom)
destroy(this.rb_top)
destroy(this.gb_fields)
destroy(this.gb_rank)
destroy(this.gb_sort)
destroy(this.uo_sort)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;
istr_in_parm = message.powerobjectparm

//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectParm)

end event

event close;call super::close;// FDG 04/12/02	Track 2984d. Destroy inv_summ
IF	IsValid(inv_summ)	THEN
	Destroy	inv_summ
END IF

end event

type dw_dict_cols from u_dw within w_summary_financial
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2624
integer y = 444
integer height = 432
integer taborder = 0
boolean enabled = false
string dataobject = "d_dict_cols"
end type

type dw_sum_select from u_dw within w_summary_financial
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 128
integer y = 372
integer width = 672
integer taborder = 0
boolean enabled = false
string dataobject = "d_sum_select"
end type

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Properly trim the data.
This.of_SetTrim (TRUE)

end event

type uo_functions from u_display_functions within w_summary_financial
integer x = 91
integer y = 112
integer width = 731
integer height = 116
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////
// Change History
//////////////////////////////////////////////////////////////////
// JasonS 10/15/02 Track 2991d  Reload dddw's on function change
//////////////////////////////////////////////////////////////////

string	ls_function
string	ls_filter
integer	li_return
long		ll_row

//FILL PERIOD DDDW

ls_function = this.gettext()

//	If this is triggered for the 1st time, set function_name to 'SUM'

IF	Trim (ls_function)	<	' '		THEN
	This.SetItem(1,'function_name','SUM')
	ll_row	=	This.GetRow()
	ls_function	=	This.GetItemString (ll_row, 'function_name')
END IF

uo_1.uf_load_dddw(ls_function, iv_inv_type, 'AC', 'FALSE')

// JasonS 10/15/02 Begin - Track 2991d
Parent.TriggerEvent ('ue_reset_window')
// JasonS 10/15/02 End - Track 2991d

if ls_function <> 'SUM' then
	cb_more_crit.enabled = FALSE
else
	cb_more_crit.enabled = TRUE
end if
dw_fields.setfocus()

end event

type uo_1 from u_display_period within w_summary_financial
integer x = 992
integer y = 112
integer width = 1289
integer height = 116
integer taborder = 20
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//************************************************************************
//	This event will get the period key and function to re-filter dw_rel
//************************************************************************
//
// 10/12/2000 GaryR 3019c Retain the criteria when the period changes in Summaries
//
///////////////////////////////////////////////////////////////////////////

Integer		li_rc

istr_in_parm.period			=	String (This.uf_return_period() )
istr_in_parm.period_key		=	This.uf_return_key()
istr_in_parm.function_nm	=	uo_functions.uf_get_function()

	// Register istr_in_parm to inv_summ.  fuo_filter_dw requires
	//	istr_in_parm to be registered.
inv_summ.fuo_set_summary_parm (istr_in_parm)

	//	Filter dw_rel based on period and function
inv_summ.fuo_reset_filter()
inv_summ.fuo_filter_dw()

//li_rc = wf_load_first_dw_field()

	// Get dw_fields 
// Parent.TriggerEvent ('ue_reset_window')  *********** 10/12/2000 GaryR 3019c *********
dw_fields.setfocus()

end event

type cbx_provider_universe from checkbox within w_summary_financial
string accessiblename = "Provider Universe"
string accessibledescription = "Provider Universe"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 343
integer y = 1964
integer width = 562
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Provider Universe"
end type

type st_count from statictext within w_summary_financial
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 41
integer y = 1940
integer width = 279
integer height = 108
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_label from u_dw within w_summary_financial
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2446
integer y = 372
integer width = 114
integer height = 460
integer taborder = 0
string dataobject = "d_label"
end type

event retrievestart;Return 2
end event

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

type dw_rel from u_dw within w_summary_financial
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 832
integer y = 368
integer width = 987
integer height = 620
integer taborder = 0
string dataobject = "d_sum_rel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

type dw_fields from u_dw within w_summary_financial
event check_dw pbm_custom13
string accessiblename = "Field List"
string accessibledescription = "Field List"
integer x = 69
integer y = 324
integer width = 3150
integer height = 1312
integer taborder = 40
string dataobject = "d_summary_financial_fields"
boolean border = false
end type

event check_dw;int lv_rc,lv_col_num, lv_row_count, li_rc
sx_field lv_clear_fields[]
string lv_clear_asterisks[]

dw_fields.setredraw(false)
wf_check_field()
dw_fields.setredraw(true)

	//	Clear structures
iv_fields			= lv_clear_fields
iv_asterisk_col	= lv_clear_asterisks

	//	Fill the structures so wf_filter_sum_rel can use them
wf_select_fields() 

	//	See if additional selections are required
wf_filter_sum_rel()

lv_row_count = dw_rel.rowcount()
//djp - check for universe
if lv_row_count=1 then
	if dw_rel.getitemstring(1,'sum_flag')='U' then 
		cbx_provider_universe.enabled=true
		cbx_provider_universe.visible=true
	else
		cbx_provider_universe.visible=false
		cbx_provider_universe.enabled=false
		cbx_provider_universe.checked=false
	end if	
else
	cbx_provider_universe.visible=false
	cbx_provider_universe.enabled=false
	cbx_provider_universe.checked=false
end if	

//NLG 2/14/00 The columns in uo_sort may have to change, depending
//on what grouping user has selected. 
li_rc = parent.event ue_pre_load_sort()

IF	lv_row_count	=	0	THEN
	SetMicroHelp (w_main, 'Please select another field')
ELSE
	SetMicroHelp (w_main, 'Ready')
END IF
end event

event itemchanged;string lv_col
lv_col = dw_fields.getcolumnname()
//only if field selection changed
if match(lv_col,ic_field_name) then
	postevent('check_dw')
end if

//HRB - 7/17/95 - prob#549
//clear count if change field or value
if not match(lv_col,ic_operator) then
	st_count.text = ''
end if
end event

event ue_lookup;call super::ue_lookup;////////////////////////////////////////////////////////////////////////////////////
//
//	03/29/00	NLG	Patient Profiles. If user right-clicks dw_fields for drug category
//						display Filter List window
//	03/02/04	GaryR	Track 3908d	Prevent GPF if no combinations exist for selected fields
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
// 10/20/09 RickB LKP.650.5678.001 Added code to accommodate multiselect code lookups
// 11/10/09 RickB LKP.650.5678.001 Defect #158 - removed code that cleared existing values
//			if multiselect, orig there to elim dups.  wf_build_multi_code takes care of dups.
//
////////////////////////////////////////////////////////////////////////////////////

string ls_col_name, ls_value
string lv_value_name,lv_sel_col_string,lv_value_info,lv_row,lv_ndc_lab
int lv_col_num,lv_rc,lv_prior_row
string ls_parm, ls_rel_op						

//HRB 6/1/95 - HARDCODING	
//special lookup for NDC_LAB and NDC_PROD
string lc_ndc_prod = 'NDC_PROD_CODE'
string lc_prod_label = 'NDC Product Code'
string lc_lab_label = 'NDC Lab Code'
string ls_lookup_code

lv_value_name = as_col

if match(lv_value_name,ic_value) then //clicked on value field
	IF dw_rel.RowCount() < 1 THEN	
		MessageBox( "Lookup Error", "There are no summaries of this combination." + &
											 " Please select another field." )
		Return
	END IF

	// Get Row and Column Data 
	lv_row				= mid(lv_value_name,len(ic_value)+1,1)
	lv_sel_col_string = dw_fields.getitemstring(1,ic_field_name+lv_row)
	ls_col_name 		= trim(mid(lv_sel_col_string,ic_col_pos+1,ic_lookup_pos - ic_col_pos))
	ls_rel_op = UPPER(dw_fields.getitemstring(1,ic_operator + lv_row))       
	ls_value = dw_fields.getitemstring(1, ic_value + lv_row)
	ls_parm = "1" + ls_value																
	IF pos(ls_value,'@') = 0 THEN
		if len(lv_sel_col_string) > ic_lookup_pos + 4 then
			gv_code_to_use = trim(right(lv_sel_col_string,2))
		else
			gv_code_to_use = trim(mid(lv_sel_col_string,ic_lookup_pos))
		end if
		ls_lookup_code=gv_code_to_use
		if gv_code_to_use <> '' then      //is a lookup field		
			//HRB 6/1/95 - added for NDC lookup
			if match(lv_sel_col_string,lc_ndc_prod) then
				if integer(lv_row) > 1 then 
					lv_prior_row = integer(lv_row) - 1
				else
					messagebox('Warning','Unable to lookup code.  There may be an error in the Summary Relationship.'&
									+'  Please contact your system Administrator.')
					return
				end if
				lv_ndc_lab = dw_fields.getitemstring(1,ic_value+string(lv_prior_row))
				if len(trim(lv_ndc_lab)) > 0 and not isnull(lv_ndc_lab) then
					if not match(lv_ndc_lab,',') and dw_fields.getitemstring(1,ic_operator+string(lv_prior_row)) = '=' then

						gv_code_to_use = gv_code_to_use + '~~' + lv_ndc_lab
					end if			
				end if
			end if
			// If multiselect, open w_code_lookup with parm.
			IF ls_rel_op = "IN" or ls_rel_op = "NOT IN" THEN 
				OpenWithParm( w_code_lookup, ls_parm )			
			ELSE
				open(w_code_lookup)
			END IF
			
			if gv_code_to_use <> '' then   //returned a value to use
				//djp - add whole section for LP lookup
				if ls_lookup_code='LP' and len(gv_code_to_use)=9 then
					lv_value_info = trim(dw_fields.getitemstring(1,lv_value_name))
					if lv_value_info = '' or isnull(lv_value_info) then
						dw_fields.setitem(1,lv_value_name,right(gv_code_to_use,4))
					else
						dw_fields.setitem(1,lv_value_name,lv_value_info+','+right(gv_code_to_use,4))
					end if				
					lv_value_info = trim(dw_fields.getitemstring(1,ic_value+string(lv_prior_row)))
					if  lv_value_info = '' or isnull(lv_value_info) then
						dw_fields.setitem(1,ic_value+string(lv_prior_row),left(gv_code_to_use,5))
					elseif lv_value_info<>left(gv_code_to_use,5) then
						dw_fields.setitem(1,ic_value+string(lv_prior_row),lv_value_info+','+left(gv_code_to_use,5))
					end if				
				else
					dw_fields.setitem(1,lv_value_name,gv_code_to_use)			
				end if
			end if
			lv_col_num = dw_fields.getcolumn()
			lv_rc = dw_fields.setcolumn(lv_col_num+1)
		else//Not a lookup field. Is it drug category?
			IF UPPER(ls_col_name) = ics_drugcat THEN
				IF dw_rel.RowCount() > 0 THEN
					This.Event ue_lookup_filter( as_col )
				END IF
			END IF
		end if//is it a lookup field	
	END IF //Filter
end if//clicked on value field
		
end event

event ue_dblclick;call super::ue_dblclick;//======================================================================================//
// Parent		w_summary_financial
// Object		dw_fields
// Event			ue_dblclick
//	Description	Set the value field to the active filter if set
//======================================================================================//
// Maintenance
// ------------------------------------------------------------------------------------
// 10/10/03	MikeF	Track 2989d	Using Filters in summaries.
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//======================================================================================//

String	ls_col
Integer	li_row

li_row = This.GetRow()
ls_col = This.GetColumnName()
	
IF li_row > 0 AND Match( ls_col, ic_value ) THEN
	IF gv_active_filter <> '' then
		dw_fields.setitem( li_row, ls_col, '@' + gv_active_filter)
	ELSE
		MessageBox("Filter error", "No active filter set",StopSign!, OK!)
	END IF
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

String	ls_col

ls_col = This.GetColumnName()

IF Match( ls_col, ic_value ) THEN
	// Get Summary Table and Table type information
	iv_summary_table = dw_rel.GetItemString(1,'table_name')
	iv_sum_tbl_type = inv_summ.fuo_get_tbl_type(iv_summary_table)
END IF
end event

event ue_lookup_filter;call super::ue_lookup_filter;//*********************************************************************************
// Script Name:	ue_lookup_filter
//
//	Arguments:		as_col -	The lookup column.
//
// Returns:			None
//
//	Description:	Open filter use window. This event was created for Patient profiles.
//						If pharmacy patient summary uses drug category, user can right-click
//						to bring up filter list window and select a drug category filter
//						as part of criteria.
//
//*********************************************************************************
//	
// 03/29/00	NLG	Stars 4.5	Created
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

String		ls_col_val, ls_val_row, ls_db_col, ls_data_type

sx_filter_data		lstr_filter_data

ls_val_row	= Right( as_col, 1 )
ls_col_val	= This.GetItemString( 1, ic_field_name + ls_val_row )
ls_db_col	= Trim( Mid( ls_col_val, ic_col_pos+1, ic_lookup_pos - ic_col_pos ) )

Select	elem_data_type
Into		:ls_data_type
From		Dictionary
Where		elem_type		=	'CL'
  And		elem_tbl_type	=	Upper( :iv_sum_tbl_type )
  And		elem_name		=	Upper( :ls_db_col )
Using		Stars2ca ;

IF	Stars2ca.of_check_status()	<>	0		THEN
	MessageBox ("Database Error", "In w_summary_financial.ue_filter_lookup, dictionary "	+	&
					"error retrieving data type.  Where: elem_type = 'CL', elem_tbl_type = '"		+	&
					iv_sum_tbl_type	+	"', elem_name = '"	+	ls_db_col	+	"'.")
	Return
END IF

SetNull(lstr_filter_data.sx_window)
lstr_filter_data.sx_entry_mode	=	'USE'
lstr_filter_data.sx_col_name		=	ls_data_type

OpenwithParm (w_filter_list_response, lstr_filter_data)

IF gv_active_filter <> "" THEN
	This.SetItem(1,as_col,'@'	+	gv_active_filter)
END IF
end event

event getfocus;call super::getfocus;//	05/29/09	GaryR	GNL.600.5633.005	Provide mouse alternative navigation

This.SetRow( 1 )
This.SetColumn( 1 )
end event

type cb_close from u_cb within w_summary_financial
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2921
integer y = 1948
integer width = 325
integer height = 108
integer taborder = 140
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

on clicked;close(parent)
end on

type cb_clear from u_cb within w_summary_financial
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 2546
integer y = 1948
integer width = 325
integer height = 108
integer taborder = 130
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "C&lear"
end type

on clicked;
Parent.TriggerEvent ('ue_reset_window')

end on

type cb_save from u_cb within w_summary_financial
string accessiblename = "Save"
string accessibledescription = "Save"
integer x = 2171
integer y = 1948
integer width = 325
integer height = 108
integer taborder = 120
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Save"
end type

event clicked;//***************************************************************
//
//	10/11/95 FNC	Take upperbound out of script
//	10/20/95 FNC	Take out connects and disconnects
//	03/02/04	GaryR	Track 3912d	Prevent infinite loop
// 08/01/05 Katie Track 3661d Change Blanks to a single space.
//
//***************************************************************

setpointer(hourglass!)
int count,rc, lv_len,i,lv_upperbound
string lv_crit_lines[50,4],lv_sorts[25,4],lv_group[25,2], lv_where, lv_rank
string lv_table_type[]
string lv_sort_type
count = 1

Setpointer(hourglass!)
setmicrohelp(w_main,'Saving Criteria...')

ib_from_cb_details = FALSE//NLG 5-19-00 Used in wf_format_line

//edit check for num of rows in rank
if sle_rank.text <> '' then
	if not isnumber(sle_rank.text) then
		messagebox('Error','Please enter a NUMBER for this field.',stopsign!)
		setfocus(sle_rank)
		setmicrohelp(w_main,'Ready')
		return
	end if
end if

lv_where = wf_make_sql()
if lv_where = 'ERROR' then
	return
end if

//NLG 2/14/00 use uo_sort instead of iv_sort to get the sort column
//lv_upperbound = upperbound(iv_sort)  //10-11-95 FNC
//for i = 1 to lv_upperbound           //10-11-95 FNC
//	if iv_sort[i].label = ddlb_sorts.text then
//		lv_sorts[1,1] = iv_sort[i].col_name
//		exit
//	end if
//next
lv_sorts[1,1] = uo_sort.uf_get_sort_col()
//NLG 2/14/00 STOP

if lv_sorts[1,1] = '' then
	messagebox('Sort Error','Error retreiving sort column.  Unable to save criteria.')
	return
end if

if rb_top.checked = TRUE then
	lv_rank = 'top'
   lv_sort_type = 'asc'
else
	lv_rank = 'bottom'
   lv_sort_type = 'desc'
end if

lv_sorts[1,2] = ''						//functions for sort such as sum or count
lv_sorts[1,3] = '1'						//the sort sequence
lv_sorts[1,4] = lv_sort_type			//The sort type asc or desc


lv_upperbound = upperbound(gv_exp1)   //10-11-95 FNC
do while count <= lv_upperbound       //10-11-95 FNC
	if gv_exp1[count] <> '' then
		lv_crit_lines[count,1] = gv_exp1[count]
		lv_crit_lines[count,2] = gv_op[count]
		if (upper(gv_exp2[count]) = 'BLANKS') then
			lv_crit_lines[count,3] = '~' ~''
		else
			lv_crit_lines[count,3] = gv_exp2[count]
		end if
		lv_crit_lines[count,4] = gv_logic[count]
	end if
	count++
loop

//put table type into proper form for function
lv_table_type[1] = iv_sum_tbl_type

rc = save_anal_crit('ANL',lv_table_type,lv_rank,integer(sle_rank.text),lv_crit_lines,lv_sorts,lv_group)
if rc = -1 then
	return
end if
end event

type cb_more_crit from u_cb within w_summary_financial
string accessiblename = "Details"
string accessibledescription = "Details..."
integer x = 1797
integer y = 1948
integer width = 325
integer height = 108
integer taborder = 110
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Details..."
end type

event clicked;//***************************************************************
//10-20-95 FNC Take out connect
//10-11-95 FNC Take upperbound out of script
//03/10/98 FDG	Track 914 RLS40.  Open w_query_engine instead of
//					w_detail_analysis_mc.  This entails rewriting the
//					entire script
//05/25/00 FNC	Track 2303 Starsdev. If a revenue field is included in 
//					the criteria all of the table types must be converted
//					to the fasttrack invoice type.
//	01/29/02	LahuS	Track 2552d	Predefined Report (PDR)
//04/12/02 FDG	Track 2984d.  Destroy lnv_revenue to prevent memory leaks.
//***************************************************************

string 	ls_rc,			&
			ls_base_type,	&
			ls_inv_type,	&
			ls_rev_tbl_type
integer	li_index1,		&
			li_index2,		&
			li_upperbound
boolean lv_found
sx_analysis_structure lv_criteria
sx_query_engine_parms lstr_query_parms
n_cst_revenue	lnv_revenue

setpointer(hourglass!)

//NLG 3-20-00 Set boolean ib_from_cb_details. For patient profiles, need to 
//know this when we're in wf_format_line. That script is called from here
//as well as when click view report.  When going straight to query engine
//from initial summary analysis window (this path), must convert
//drug_cat into ndc code (for certain pharmacy patient summaries) upfront.
//If not going directly to query engine from initial window, must keep
//drugcat as it is so it will pull data from summary table.
ib_from_cb_details = TRUE


// Clear out the query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

//use to fill query engine parms
ls_rc		=	wf_make_sql()
if ls_rc	=	'ERROR'	then
  RETURN
end if

lstr_query_parms = inv_queryengine.uf_get_sx_query_engine_parms()

// FNC 05/25/00 Start

lnv_revenue	=	CREATE n_cst_revenue	

//if iv_inv_type = 'CH'then  	
ls_base_type = lnv_revenue.of_get_base_type(iv_inv_type)
if ls_base_type = 'UB92' then
	
	li_upperbound = UpperBound(lstr_query_parms.criteria[])
	For li_index1 = 1 to li_upperbound

		IF	Trim (ls_rev_tbl_type)	<	' '	THEN
			ls_rev_tbl_type = lnv_revenue.of_get_revenue(lstr_query_parms.criteria[li_index1].tbl_type)
		END IF
		
		if lstr_query_parms.criteria[li_index1].tbl_type = ls_rev_tbl_type then
			ls_inv_type = lnv_revenue.of_get_fasttrack_invoice(iv_inv_type)
			if ls_inv_type <> 'ERROR' then
				is_detail_inv_type = ls_inv_type
			else
				if IsValid(lnv_revenue)	then	Destroy(lnv_revenue)			// FDG 04/12/02
				return
			end if
			For li_index2 = 1 to li_upperbound
				lstr_query_parms.criteria[li_index2].tbl_type = is_detail_inv_type
			Next
			inv_queryengine.uf_set_sxqueryengineparms(lstr_query_parms)
			Exit
		else
			is_detail_inv_type = iv_inv_type
		end if
	Next
else
	is_detail_inv_type = iv_inv_type
end if
// FNC 05/25/00 End

if IsValid(lnv_revenue)	then	Destroy(lnv_revenue)			// FDG 04/12/02

inv_queryengine.uf_set_invoice_type(is_detail_inv_type)
inv_queryengine.uf_set_tbl_type(is_detail_inv_type)
inv_queryengine.uf_set_tbl_rel('GP')
//inv_queryengine.uf_set_src_type(iv_inv_type)

inv_queryengine.uf_set_rpt_title('Claim Report - ' + iv_header)

ib_from_cb_details = FALSE//Done with this; set it back to false

w_main.SetMicroHelp ('Bringing up Query Engine.  Please Wait!')

//	01/29/02	Lahu S	Track 2552d
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

// Open the query engine window.
inv_queryengine.uf_open_query_engine()
end event

type cb_view from u_cb within w_summary_financial
string accessiblename = "View Report"
string accessibledescription = "View Report..."
integer x = 1307
integer y = 1948
integer width = 439
integer height = 108
integer taborder = 100
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&View Report..."
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
//
//the cb_view_report button calls the function wf_make_sql to create the
//where clause.  It then adds on the sort criteria as well as the selection
//criteria.  
//
/////////////////////////////////////////////////////////////////////////////
//
//	10/11/95	FNC	Take upperbound out of script
//	10/20/95 FNC	Take out connects and disconnects
//	07/29/96 FDG	STARS35 - If the 'Provider Universe' checkbox is checked,
//						call wf_make_universe_sql() to create the SQL with the
//						join for the Universe Count.  If the 'Group by' clause
//						exists, there is no need to create an 'Order by' clause.
//	06/19/97 FNC	Display debug box if use debug option in command line
//	11/30/98	NLG	Implement Archana's ts341
//	02/14/00	NLG	Patient profile changes
// 02/20/01	FDG	Stars 4.7.  Remove lv_transaction
//	11/01/01	FDG	Track 2512d.  Place double quotes around aliases to
//						conform to Oracle.
//	04/17/03	GaryR	Track 3396d	Rewrite the flow of sorting
//	05/28/03	GaryR	Track 3593d	Add visual aid for sorting options
// 10/27/04 MikeF SPR3650d Replaced SQL with gnv_dict
//	09/19/06	GaryR	Track 4541	Perpetuate any calculated columns from Summary to Trending
//	04/20/07	GaryR	Track 4995	Include Provider Universe Computed Columns
//	05/29/07	GaryR	Track 5031	Use DB column name not label for grouping alias in order by
//
/////////////////////////////////////////////////////////////////////////////

string lv_sort_by, lv_order_by, lv_where_cl, lv_which_dw, lv_which_tbl
string lv_value, lv_which_label, lv_values[2], lv_sel, lv_sort_by_two
string lv_color,lv_style,lv_sql_select,lv_error,lv_syntax
integer li_upperbound, i
string ls_col_name
//n_tr lv_transaction							// FDG 02/20/01
sx_summary_parm lv_parm

setpointer(Hourglass!)
SetMicroHelp(w_main,'Formatting Data for Summary Report')

//NLG 5-12-00 Set boolean ib_from_cb_details to false. For patient profiles, need to 
//know this when we're in wf_format_line. That script is called from here
//as well as when click cb_details.  When going straight to query engine
//from initial summary analysis window (cb_details), must convert
//drug_cat into ndc code (for certain pharmacy patient summaries) upfront.
//If not going directly to query engine from initial window (this path), must keep
//drugcat as it is so it will pull data from summary table. Track #2280.
ib_from_cb_details = FALSE

lv_sort_by_two = ''

// determine the number of rows to show on report is an integer
if sle_rank.text <> '' Then
   if isnumber(sle_rank.text) = FALSE Then
	   messagebox('Error','Please enter a Number for this field',stopsign!)
	   setfocus(sle_rank)
		setmicrohelp(w_main,'Ready')
	   return
   end if
end if

// create where clause based on data window information 

//	FDG 07/29/96 begin
IF	cbx_provider_universe.checked	=	TRUE	THEN
	lv_where_cl	=	wf_make_universe_sql()
	lv_parm.provider_universe	=	TRUE
ELSE
	lv_where_cl	=	wf_make_sql()
	lv_parm.provider_universe	=	FALSE
END IF
//	FDG 07/29/96 end

//lv_where_cl = wf_make_sql()						//FDG 07/29/96
if lv_where_cl = 'ERROR' then
	return
end if


ls_col_name = uo_sort.uf_get_sort_col()

if isnull(ls_col_name) OR Trim( ls_col_name ) = "" OR ls_col_name = "Selected Fields" then
	// determine the order 
	if rb_top.checked = TRUE then
		lv_order_by = " ASC"
	else
		lv_order_by = " DESC"
	end if
	
	li_upperbound = UpperBound( iv_fields )
	FOR i = 1 TO li_upperbound
		lv_sort_by += iv_sum_tbl_type + "." + iv_fields[i].col_name + lv_order_by + ", "
	NEXT
	lv_sort_by = Left( lv_sort_by, Len( lv_sort_by ) - 2 ) 
else
	// determine the order 
	if rb_top.checked = TRUE then
		lv_order_by = " DESC"
	else
		lv_order_by = " ASC"
	end if

	if pos(lv_where_cl,'GROUP BY') > 0 then
		lv_sort_by = ls_col_name + lv_order_by
	else
		lv_sort_by = iv_sum_tbl_type+'.'+ls_col_name + lv_order_by
	end if
end if

if upper(ls_col_name) = 'TYPE_BILL' then
			lv_sort_by_two = iv_sum_tbl_type+'.BILLED_AMT ASC'
end if
//NLG 2/14/00 stop

if lv_sort_by = '' then
	messagebox('Sort Error','Error retreiving sort column.  Unable to save criteria.')
	return
end if

IF lv_sort_by_two = '' then
	lv_where_cl = lv_where_cl + ' ORDER BY ' + lv_sort_by
ELSE
	lv_where_cl = lv_where_cl + ' ORDER BY ' + lv_sort_by + ', ' + lv_sort_by_two
END IF
//END IF

	// GET SELECT CLAUSE 
lv_sel = wf_make_select()

lv_sql_select = lv_sel  + ' ' + lv_where_cl

gv_summ_flg = FALSE

if isvalid(w_summ_rpt) then
	close(w_summ_rpt)
end if 

lv_parm.s_calc_cols = istr_in_parm.s_calc_cols
lv_parm.group_fields = iv_fields
lv_parm.asterisk_cols = iv_asterisk_col
lv_parm.sql_statement = upper(lv_sql_select)
lv_parm.sum_tbl_type = iv_sum_tbl_type
lv_parm.sum_tbl_name = iv_summary_table
lv_parm.invoice_type = iv_inv_type
lv_parm.header = iv_header
lv_parm.rank = long(sle_rank.text)

//NLG 2/14/00 set patient profile boolean 
lv_parm.pat_sum_flag = inv_summ.fuo_get_ib_pat_profile()


//NLG 11-30-98 ts341 					***Start
if match(lv_sql_select,'GROUP BY') then
	lv_parm.group_by_flag = 'G'
end if
//NLG 11-30-98 ts341 					***Stop

if rb_bottom.checked then
	lv_parm.rank_btn = 'BOTTOM'
else
	lv_parm.rank_btn = 'TOP'
end if

lv_parm.sort	=	ddlb_sorts.text
lv_parm.period	=	String (uo_1.uf_return_period() )
//lv_parm.period =	uo_1.uf_return_desc()
lv_parm.period_key = uo_1.uf_return_key()
lv_parm.filter	=	inv_summ.fuo_get_sum_rel_filter()		//FDG 08/29/96
lv_parm.function_nm = istr_in_parm.function_nm  //djp 9/18/96

lv_parm.calc_disp_format = inv_summ.fuo_get_calc_disp_formats( lv_parm.provider_universe )

if gc_debug_mode then				//06-19-97 FNC start
	f_debug_box ('Debug', 'cb_view.clicked.  SQL = ' + lv_sql_select)
end if									//06-19-97 FNC end

OpenSheetwithParm(w_summ_rpt,lv_parm,MDI_main_frame,help_menu_position,Layered!)
end event

type cb_query from u_cb within w_summary_financial
string accessiblename = "Query"
string accessibledescription = "Query"
integer x = 933
integer y = 1948
integer width = 325
integer height = 108
integer taborder = 90
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Query"
boolean default = true
end type

event clicked;//***********************************************************
//10-20-95 FNC Take out connects and disconnects
//
//07/29/96 FDG	STARS35 - If the 'Provider Universe' checkbox is checked,
//					call wf_make_universe_sql() to create the SQL with the
//					join for the Universe Count
//
//06/19-97 FNC Display debug box if use debug option in command line
//***********************************************************
string lv_sql,lv_err_text
Long lv_count,lv_temp		//pat-d changed from int to long PROB 397

setpointer(hourglass!)
setmicrohelp(w_main,'Selecting count, please wait...')

//	FDG 07/29/96 begin
IF	cbx_provider_universe.checked	=	TRUE	THEN
	lv_sql	=	wf_make_universe_sql()
ELSE
	lv_sql	=	wf_make_sql()
END IF
//	FDG 07/29/96 end

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in cb_query')
   return
 end if                             

if lv_sql = 'ERROR' then
	return
end if

lv_sql = 'select count(*) ' + lv_sql

if gc_debug_mode then				//06-19-97 FNC start
	f_debug_box ('Debug', 'cb_query.clicked.  lv_sql =' + &
					lv_sql)
end if									//06-19-97 FNC end

DECLARE count DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA from :lv_sql USING stars1ca;
OPEN DYNAMIC count;
if stars1ca.of_check_status() <> 0 then
	lv_err_text = stars1ca.sqlerrtext
	messagebox('DATABASE ERROR',lv_err_text)
else
//djp - add do loop for test
	if pos(upper(lv_sql),'GROUP BY')>0 then
		do until stars1ca.sqlcode=100
			FETCH count INTO :lv_temp;
			if stars1ca.of_check_status()=0 then lv_count++
		loop
	else
		FETCH count into :lv_count;
	end if
end if

COMMIT using stars1ca;
if stars1ca.of_check_status() <> 0 then
   errorbox(stars1ca,'Error performing commit in cb_query')
   return
end if                             

st_count.text = string(lv_count)
setmicrohelp(w_main,'Ready')


end event

type ddlb_sorts from dropdownlistbox within w_summary_financial
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = comboboxrole!
integer x = 2304
integer y = 100
integer width = 773
integer height = 312
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
end type

type sle_rank from singlelineedit within w_summary_financial
string accessiblename = "Rank"
string accessibledescription = "Rank"
accessiblerole accessiblerole = textrole!
integer x = 1339
integer y = 1764
integer width = 279
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_bottom from radiobutton within w_summary_financial
string accessiblename = "Bottom"
string accessibledescription = "Bottom"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1024
integer y = 1820
integer width = 338
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bottom"
end type

type rb_top from radiobutton within w_summary_financial
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1024
integer y = 1744
integer width = 247
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Top"
boolean checked = true
end type

type gb_fields from groupbox within w_summary_financial
string accessiblename = "Fields"
string accessibledescription = "Fields"
accessiblerole accessiblerole = groupingrole!
integer x = 50
integer y = 272
integer width = 3200
integer height = 1388
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Fields"
end type

type gb_rank from groupbox within w_summary_financial
string accessiblename = "Rank"
string accessibledescription = "Rank"
accessiblerole accessiblerole = groupingrole!
integer x = 946
integer y = 1680
integer width = 2304
integer height = 228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Rank"
end type

type gb_sort from groupbox within w_summary_financial
string accessiblename = "Sort"
string accessibledescription = "Sort"
accessiblerole accessiblerole = groupingrole!
integer x = 50
integer y = 1680
integer width = 873
integer height = 228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Sort"
end type

type uo_sort from u_def_query_grps within w_summary_financial
string accessiblename = "Sort"
string accessibledescription = "Sort"
integer x = 69
integer y = 1756
integer width = 818
integer height = 100
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_summary_financial
string accessiblename = "Function"
string accessibledescription = "Function"
accessiblerole accessiblerole = groupingrole!
integer x = 50
integer y = 32
integer width = 878
integer height = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Function"
end type

type gb_2 from groupbox within w_summary_financial
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = groupingrole!
integer x = 951
integer y = 32
integer width = 2299
integer height = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Period"
end type

