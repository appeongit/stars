HA$PBExportHeader$w_detail_main.srw
$PBExportComments$Inherited from w_master
forward
global type w_detail_main from w_master
end type
type st_total_count_label from statictext within w_detail_main
end type
type st_total_count from statictext within w_detail_main
end type
type rb_user_selected from radiobutton within w_detail_main
end type
type rb_none from radiobutton within w_detail_main
end type
type cb_details from u_cb within w_detail_main
end type
type rb_all from radiobutton within w_detail_main
end type
type cb_close from u_cb within w_detail_main
end type
type dw_1 from u_dw within w_detail_main
end type
type gb_select from groupbox within w_detail_main
end type
end forward

global type w_detail_main from w_master
string accessiblename = "Claim Details Selection"
string accessibledescription = "Claim Details Selection"
integer x = 672
integer y = 264
integer width = 2139
integer height = 1060
string title = "Claim Details Selection"
event ue_postactivate ( )
st_total_count_label st_total_count_label
st_total_count st_total_count
rb_user_selected rb_user_selected
rb_none rb_none
cb_details cb_details
rb_all rb_all
cb_close cb_close
dw_1 dw_1
gb_select gb_select
end type
global w_detail_main w_detail_main

type variables
sx_details_structure in_common_info_struct
long in_row_nbr
string in_tbl_types_to_process[]
uo_prepare_detail_win in_u_prepare_left_side,in_u_prepare_right_side
w_parent_details in_detail_win[]
string iv_invoice_type
boolean iv_boolean = false
end variables

forward prototypes
public subroutine wf_determine_which_detail_win ()
public function integer wf_insert_into_dw ()
end prototypes

event ue_postactivate;call super::ue_postactivate;//AJS 08-04-98 Stars 4.0 Track #1370; Moved following 
//script from the activate event because it caused 
//an invalid page fault in user.exe.
in_u_prepare_left_side.fuo_close_windows('ALL')
in_u_prepare_right_side.fuo_close_windows('ALL')

IF iv_Boolean = TRUE THEN Close(this)

end event

public subroutine wf_determine_which_detail_win ();string lv_value
long lv_row_start
boolean lv_done
int lv_counter,lv_position
lv_row_start = 0
lv_done = FALSE
lv_counter = 1
do while lv_done = FALSE
	lv_row_start = dw_1.GetSelectedRow(lv_row_start)
	if lv_row_start = 0 then exit
	lv_value = dw_1.getvalue(1,lv_row_start)
	lv_position = pos(lv_value,'~t')
	lv_value = mid(lv_value,lv_position + 1)
	in_tbl_types_to_process[lv_counter] = lv_value
	lv_counter++
loop	





end subroutine

public function integer wf_insert_into_dw ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_detail_main				wf_insert_into_dw
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This function determines the dependent table types for the invoice type and gets a 
// count for each table type and lists this information in a datawindow (dw_1).  This 
// will now only list the dependent table types that contain counts greater than zero.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success
//						-1			Failure
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	01/15/98		Created.
//	J.Mattis	02/09/98		1) Added logic to correct object ref. error for elem_name &
//								elem_desc (both MUST be prefixed with dictionary_) since
//								the SQL is dynamically modified. 
//								2) Added guard against null & empty assignments to ls_Where.
// FNC		06/10/98		Track 1313. If there is no key2 value should not 
//								blank out ls_where. Must have only a key1 value. If no 
//								Key1 field display an error and end execution.
// FNC		06/22/98		Track 1309. 1. If src_type is SS then must set 
//								lt_trans = stars2ca before attempting the settransobject.
//								2. When retrieve lds_dep_tables check for a return code 
//								< 0 and = 0.
//								3. Don't need to set the sql for lds_dep_tables. Just 
//								retrieve with the arugments. Anyway, can't do setsqlselect
//								for a datawindow that uses retrieval arguments must use
//								a dwmodify.
// FNC		02/08/00		Unique Key TS2072 - Add flexiblity for client to select
//								custom claim key fields.
//	FDG		12/14/00		Stars 4.7.  
//								1.	Make the checking of data types DBMS-independent.
//								2. Makes the dates in the Where clause DBMS-independent.
//								3.	Get the table names from Stars Server (4/11/01)
//	GaryR		07/11/01		Track 2359D Add payment date to where clause 
//								to avoid full table scan on partitioned tables.
//	FDG		02/01/02		Track 2768d.  Must use the values of the dependent tables
//								join keys (instead of the main table's unique keys).
//								The code must be restructured because the join keys
//								could be different for each dependent table.
//	GaryR		12/06/07		Track 5215	Use proper dependent invoice type for subsets
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_filter, ls_sql, ls_tbl_name, ls_tbl_type, ls_where, ls_label, ls_find
//String ls_key1, ls_key2
Integer li_rc, li_uniq_keys
Long ll_count,	ll_find_row
n_Tr lt_trans


n_cst_tableinfo_attrib	lnv_table					// FDG 04/11/01

this.of_Set_Nvo_count(TRUE)

/* if Subset must get the dependents in the subset (non-zero) */
if in_common_info_struct.src_type = 'SS' then
	lt_trans = stars2ca											// FNC 06/22/98
	/* create datastore (n_ds) to get dep table types */
	n_Ds lds_dep_tables
	lds_dep_tables = Create n_Ds
	String ls_dep_tables
	lds_dep_tables.DataObject = 'd_source_load_addtl_data'
	
	li_rc = lds_dep_tables.SetTransObject(lt_Trans)
	
	// FNC 06/22/98
	li_rc = lds_dep_tables.Retrieve(in_common_info_struct.subset_id, in_common_info_struct.tbl_type)
	
	// FNC 06/22/98 Start
	IF li_rc > 0 then 
		ls_dep_tables = lds_dep_tables.object.dep_tbls[1]
		DESTROY lds_dep_tables 
	ELSE
		DESTROY lds_dep_tables 
		if li_rc = 0 then
			messageBox('Error','No dependents for the selected invoice type in in w_detail_main.wf_insert_into_dw.',StopSign!)
			iv_boolean = TRUE /* used to close window */
			RETURN -1
		else
			messageBox('Error','Error retrieving dependents in w_detail_main.wf_insert_into_dw.',StopSign!)
			iv_boolean = TRUE /* used to close window */
			RETURN -1
		end if
	END IF
	// FNC 06/22/98 End
else
	lt_trans = stars1ca
end if

/*set the transaction for the count ds. 
lt_trans = stars1ca if from base, stars2ca if from subset */

inv_count.uf_set_transaction(lt_trans)

/* lds_count = create datastore (n_ds) using lt_trans to hold the count 
from ls_sql which is built in the loop below */
Long i, ll_row, ll_dep_count

/* filter w_main.dw_stars_rel_dict to get dependent table info */
w_main.dw_stars_rel_dict.setfilter('')
w_main.dw_stars_rel_dict.filter()

ls_filter = Upper ("rel_type = 'DP' and rel_id = '" + in_common_info_struct.tbl_type + "'")
w_main.dw_stars_rel_dict.setfilter(ls_filter)
w_main.dw_stars_rel_dict.filter()
ll_count = w_main.dw_stars_rel_dict.rowcount()

if ll_count = 0 then
	messagebox("Error","No dependents tables for the selected invoice type.",StopSign!)
	iv_boolean = TRUE /* used to close window */
	return -1
end if

//FNC 02/08/00 Start 
//Keys are now passed in structure in_common_info_struct 
//	ls_key1 = w_main.dw_stars_rel_dict.object.key1[i]
//	ls_key2 = w_main.dw_stars_rel_dict.object.key2[i]

//Move create of where outside of loop through dependent tables since
//where is the same for all dependent tables. Also restructure creation of where

// FDG 02/01/02 begin
// Create datastore of dependent join keys to match to where clause later. 
n_Ds lds_unique_keys
lds_unique_keys = create n_ds						
lds_unique_keys.dataobject = 'd_dependent_index' 

li_rc = lds_unique_keys.settransobject(stars2ca)

if li_rc = -1 then 
	messagebox('ERROR','Error setting trans object for lds_unique_keys in w_detail_main.wf_insert_into_dw.')
	destroy(lds_unique_keys)	
	return -1
end if
// FDG 02/01/02 end

for i = 1 to ll_count
	ls_tbl_type = w_main.dw_stars_rel_dict.object.id_2[i]
	ls_tbl_name = w_main.dw_stars_rel_dict.object.dictionary_elem_name[i]	//JTM 2/9/98
	ls_label = w_main.dw_stars_rel_dict.object.dictionary_elem_desc[i]		//JTM 2/9/98

	if ls_tbl_type = '' or IsNull(ls_tbl_type) then
		messagebox('ERROR','Cannot determine table type for details in w_detail_main.wf_insert_into_dw. Details not available.')
		destroy(lds_unique_keys)
		return -1	
	end if

	if in_common_info_struct.src_type = 'SS' then
		if match(ls_dep_tables,ls_tbl_type) then
			ls_tbl_name = fx_build_subset_table_name(ls_tbl_type,	in_common_info_struct.subset_id)
		else
			/* don't insert this dep since zero rows */
			continue
		end if
	else
		// FDG 04/11/01 - Get table name from Stars Server
		////validate table number
		lnv_table.is_inv_type		=	ls_tbl_type
		lnv_table.is_operand			=	'='
		lnv_table.is_paid_date		=	in_common_info_struct.paid_date
		lnv_table.il_period_key		=	0
		li_rc								=	gnv_server.of_GetClaimsTableNames (lnv_table)
		IF	lnv_table.il_rc			<	0			THEN
			MessageBox ('Error', lnv_table.is_message)
			iv_boolean	=	TRUE					//	Used to close the window
			destroy(lds_unique_keys)
			Return	-1
		END IF
		IF	UpperBound (lnv_table.is_base_table)	<	1		THEN
			MessageBox ('Application Error', 'Could not retrieve table name in w_detail_main.wf_insert_into_dw().'	+	&
							'  paid_date = '	+	in_common_info_struct.paid_date	+	'.'	+	&
							'  tbl type = '	+	in_common_info_struct.tbl_type)
			iv_boolean	=	TRUE					//	Used to close the window
			destroy(lds_unique_keys)
			Return	-1
		END IF
		ls_tbl_name	=	lnv_table.is_base_table[1]
		// FDG 04/11/01 - end
	end if
	
	ls_where		=	''

	lds_unique_keys.Reset()
	li_uniq_keys = lds_unique_keys.retrieve(ls_tbl_type) 
	
	if li_uniq_keys < 0 then
		messagebox('ERROR','Error retrieving unique join keys for invoice type in w_detail_main.wf_insert_into_dw.')
		destroy(lds_unique_keys)
		return -1
	end if

	ls_find = "elem_name = '" + trim(in_common_info_struct.key1_name) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.key1_name = ''
	end if
	//end jsb
	
	If trim(in_common_info_struct.key1_name) <> '' then
		ls_where = "WHERE " + in_common_info_struct.key1_name + " = " 
		// FDG 12/14/00 Begin
		IF	gnv_sql.of_is_character_data_type (in_common_info_struct.key1_data_type)	THEN
			ls_where = ls_where + "'" + Upper( in_common_info_struct.key1_value ) + "'"
		ELSEIF gnv_sql.of_is_date_data_type (in_common_info_struct.key1_data_type)	THEN
			ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.key1_value )
		ELSE
			ls_where = ls_where + in_common_info_struct.key1_value
		END IF
		// FDG 12/14/00 end
	Else
		messagebox('ERROR','Cannot identify key field for details. Details not available')	
		destroy(lds_unique_keys)
		return -1	
	End If
	
	ls_find = "elem_name = '" + trim(in_common_info_struct.key2_name) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.key2_name = ''
	end if
	
	If trim(in_common_info_struct.key2_name) <> '' then
		ls_where = ls_where + " AND " + in_common_info_struct.key2_name + " = "
		// FDG 12/14/00 Begin
		IF	gnv_sql.of_is_character_data_type (in_common_info_struct.key2_data_type)	THEN
			ls_where = ls_where + "'" + Upper( in_common_info_struct.key2_value ) + "'"
		ELSEIF gnv_sql.of_is_date_data_type (in_common_info_struct.key2_data_type)	THEN
			ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.key2_value )
		ELSE
			ls_where = ls_where + in_common_info_struct.key2_value
		END IF
		// FDG 12/14/00 end
	End If
	
	ls_find = "elem_name = '" + trim(in_common_info_struct.key3_name) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.key3_name = ''
	end if
	
	If trim(in_common_info_struct.key3_name) <> '' then
		ls_where = ls_where + " AND " + in_common_info_struct.key3_name + " = "
		// FDG 12/14/00 Begin
		IF	gnv_sql.of_is_character_data_type (in_common_info_struct.key3_data_type)	THEN
			ls_where = ls_where + "'" + Upper( in_common_info_struct.key3_value ) + "'"
		ELSEIF gnv_sql.of_is_date_data_type (in_common_info_struct.key3_data_type)	THEN
			ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.key3_value )
		ELSE
			ls_where = ls_where + in_common_info_struct.key3_value
		END IF
		// FDG 12/14/00 end
	End If
	
	ls_find = "elem_name = '" + trim(in_common_info_struct.key4_name) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.key4_name = ''
	end if
	
	If trim(in_common_info_struct.key4_name) <> '' then
		ls_where = ls_where + " AND " + in_common_info_struct.key4_name + " = "
		// FDG 12/14/00 Begin
		IF	gnv_sql.of_is_character_data_type (in_common_info_struct.key4_data_type)	THEN
			ls_where = ls_where + "'" + Upper( in_common_info_struct.key4_value ) + "'"
		ELSEIF gnv_sql.of_is_date_data_type (in_common_info_struct.key4_data_type)	THEN
			ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.key4_value )
		ELSE
			ls_where = ls_where + in_common_info_struct.key4_value
		END IF
		// FDG 12/14/00 end
	End If
	
	ls_find = "elem_name = '" + trim(in_common_info_struct.key5_name) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.key5_name = ''
	end if
	
	If trim(in_common_info_struct.key5_name) <> '' then
		ls_where = ls_where + " AND " + in_common_info_struct.key5_name + " = "
		// FDG 12/14/00 Begin
		IF	gnv_sql.of_is_character_data_type (in_common_info_struct.key5_data_type)	THEN
			ls_where = ls_where + "'" + Upper( in_common_info_struct.key5_value ) + "'"
		ELSEIF gnv_sql.of_is_date_data_type (in_common_info_struct.key5_data_type)	THEN
			ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.key5_value )
		ELSE
			ls_where = ls_where + in_common_info_struct.key5_value
		END IF
		// FDG 12/14/00 end
	End If
	
	ls_find = "elem_name = '" + trim(in_common_info_struct.key6_name) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.key6_name = ''
	end if
	
	If trim(in_common_info_struct.key6_name) <> '' then
		ls_where = ls_where + " AND " + in_common_info_struct.key6_name + " = "
		// FDG 12/14/00 Begin
		IF	gnv_sql.of_is_character_data_type (in_common_info_struct.key6_data_type)	THEN
			ls_where = ls_where + "'" + Upper( in_common_info_struct.key6_value ) + "'"
		ELSEIF gnv_sql.of_is_date_data_type (in_common_info_struct.key6_data_type)	THEN
			ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.key6_value )
		ELSE
			ls_where = ls_where + in_common_info_struct.key6_value
		END IF
		// FDG 12/14/00 end
	End If
	// FNC 02/08/00 End
	
	ls_find = "elem_name = '" + trim(in_common_info_struct.paid_date_col) + "'"
	ll_find_row	=	lds_unique_keys.find(ls_find,1,lds_unique_keys.rowcount())
	if ll_find_row = 0	then
		in_common_info_struct.paid_date_col = ''
	end if

	//	GaryR		07/11/01		Track 2359D - Begin
	If trim(in_common_info_struct.paid_date_col) <> '' then
		ls_where = ls_where + " AND " + in_common_info_struct.paid_date_col + " = "
		ls_where = ls_where + gnv_sql.of_get_to_date( in_common_info_struct.paid_date )	
	End If
	//	GaryR		07/11/01		Track 2359D - End

	ls_sql = "SELECT COUNT(*) FROM " + ls_tbl_name + " " + ls_where 
				
	// send the SQL to the count nvo
	ll_dep_count = inv_count.uf_get_count (ls_sql)
	
	if ll_dep_count > 0 then
		/* load dependent table into datawindow */
		ll_row = dw_1.insertrow(0)
		dw_1.setitem(ll_row,1,ls_label)
		dw_1.setitem(ll_row,2,ll_dep_count)
		dw_1.setvalue(1,ll_row,ls_label + "~t" + ls_tbl_type)
	end if
	
next

stars2ca.of_commit()


Destroy	lds_unique_keys 


ll_count = dw_1.rowcount()

if ll_count = 0 then
	messageBox('Error','No dependent data for the selected invoice type.',StopSign!)
	iv_boolean = TRUE /* used to close window */
	return -1
end if

st_total_count.text = string(ll_count)


RETURN 1

end function

on deactivate;
MDI_main_frame.toolbarvisible = TRUE
end on

event open;call super::open;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_detail_main				Open
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// When this opens it calls the wf_inset_into_dw to load the datawindow and triggers the 
// clicked event of rb_greater_0 to select the rows with counts greater than zero. 
// Change this code to select all rows in the datawindow and select the All radio button. 
// Remove the reference to rb_greater_0.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/15/98		Created.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_count, i
Integer rc

//this.x = 302
//this.y = 421

in_u_prepare_right_side = create uo_prepare_detail_win
in_u_prepare_left_side = create uo_prepare_detail_win
iv_invoice_type = in_common_info_struct.invoice_type

rc = wf_insert_into_dw()

if rc = -1 then return

/* new code */
if iv_boolean = false then
	/* select all */
	ll_count = dw_1.rowcount()
	for i = 1 to ll_count
		dw_1.selectrow(i,TRUE)
	next
	rb_all.checked = TRUE
else
	close(this)
end if
end event

event close;call super::close;in_u_prepare_left_side.fuo_close_windows('ALL')
in_u_prepare_right_side.fuo_close_windows('ALL')
destroy(in_u_prepare_left_side)
destroy(in_u_prepare_right_side)
end event

event activate;call super::activate;//AJS 08-04-98 Stars 4.0 Track #1370; Moved following 
//script to ue_postactivate event because it caused 
//an invalid page fault in user.exe.
//in_u_prepare_left_side.fuo_close_windows('ALL')
//in_u_prepare_right_side.fuo_close_windows('ALL')
//
//IF iv_Boolean = TRUE THEN Close(this)

w_detail_main.Post Event ue_postactivate()


end event

on w_detail_main.create
int iCurrent
call super::create
this.st_total_count_label=create st_total_count_label
this.st_total_count=create st_total_count
this.rb_user_selected=create rb_user_selected
this.rb_none=create rb_none
this.cb_details=create cb_details
this.rb_all=create rb_all
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_select=create gb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_total_count_label
this.Control[iCurrent+2]=this.st_total_count
this.Control[iCurrent+3]=this.rb_user_selected
this.Control[iCurrent+4]=this.rb_none
this.Control[iCurrent+5]=this.cb_details
this.Control[iCurrent+6]=this.rb_all
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.gb_select
end on

on w_detail_main.destroy
call super::destroy
destroy(this.st_total_count_label)
destroy(this.st_total_count)
destroy(this.rb_user_selected)
destroy(this.rb_none)
destroy(this.cb_details)
destroy(this.rb_all)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_select)
end on

event ue_preopen;in_common_info_struct = message.Powerobjectparm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)



end event

type st_total_count_label from statictext within w_detail_main
string accessiblename = "Total Count"
string accessibledescription = "Total Count"
accessiblerole accessiblerole = statictextrole!
integer x = 41
integer y = 848
integer width = 366
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Total Count:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_total_count from statictext within w_detail_main
string accessiblename = "Total Count"
string accessibledescription = "Total Count"
accessiblerole accessiblerole = statictextrole!
integer x = 425
integer y = 844
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type rb_user_selected from radiobutton within w_detail_main
string accessiblename = "User  Selected"
string accessibledescription = "User  Selected"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1513
integer y = 244
integer width = 558
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "User  Selected"
end type

on clicked;w_main.SetMicroHelp('Selection Criteria is in user selected mode')
end on

type rb_none from radiobutton within w_detail_main
string accessiblename = "Unselect"
string accessibledescription = "Unselect"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1513
integer y = 160
integer width = 357
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Unselect"
end type

on clicked;long num_of_rows,lv_rows

num_of_rows = dw_1.rowcount()

for lv_rows = 1 to num_of_rows
	dw_1.SelectRow(lv_rows,FALSE)
next

rb_none.enabled = FALSE
cb_details.enabled = FALSE
end on

type cb_details from u_cb within w_detail_main
string accessiblename = "Details"
string accessibledescription = "Details..."
integer x = 1367
integer y = 828
integer width = 338
integer height = 108
integer taborder = 50
string text = "&Details..."
boolean default = true
end type

on clicked;string lv_clear_array[]
long lv_cum_count

OpenSheet(w_detail_backdrop,MDI_main_frame,help_menu_position,layered!)

in_u_prepare_left_side.fuo_set_cumulative_win_count(1)
wf_determine_which_detail_win()
in_u_prepare_left_side.fuo_set_tbl_types_to_process(in_tbl_types_to_process)
in_u_prepare_left_side.fuo_set_structure(in_common_info_struct)
in_u_prepare_left_side.fuo_fx_load_details('LEFT')
lv_cum_count = in_u_prepare_LEFT_side.fuo_get_cumulative_win_count()
in_u_prepare_right_side.fuo_set_cumulative_win_count(lv_cum_count)


in_u_prepare_right_side.fuo_set_tbl_types_to_process(in_tbl_types_to_process)

//clears the in_tbl_types_to_process//
in_tbl_types_to_process[]=lv_clear_array[]

in_u_prepare_right_side.fuo_set_structure(in_common_info_struct)
in_u_prepare_right_side.fuo_fx_load_details('RIGHT')

in_u_prepare_left_side.fuo_maximize_windows()
in_u_prepare_right_side.fuo_maximize_windows()
end on

type rb_all from radiobutton within w_detail_main
string accessiblename = "All"
string accessibledescription = "All"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1513
integer y = 76
integer width = 206
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "All"
end type

on clicked;long num_of_rows,lv_rows

num_of_rows = dw_1.rowcount()


for lv_rows = 1 to num_of_rows
	dw_1.SelectRow(lv_rows,TRUE)
next

rb_none.enabled = TRUE
cb_details.enabled = TRUE
end on

type cb_close from u_cb within w_detail_main
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 1746
integer y = 828
integer width = 338
integer height = 108
integer taborder = 60
string text = "&Close"
end type

on clicked;close(parent)
end on

type dw_1 from u_dw within w_detail_main
event shiftclicked pbm_custom01
event cntrlclicked pbm_custom02
string accessiblename = "Detail Table List"
string accessibledescription = "Detail Table List"
integer x = 32
integer y = 28
integer width = 1435
integer height = 756
integer taborder = 10
string dataobject = "d_detail_table_list"
boolean vscrollbar = true
end type

on shiftclicked;long lv_oldrow,lv_newrow,lv_startrow,lv_endrow,lv_counter

lv_oldrow = in_row_nbr
lv_newrow = dw_1.GetRow()

if lv_oldrow > lv_newrow then
	lv_startrow = lv_newrow
	lv_endrow = lv_oldrow
else
	lv_startrow = lv_oldrow
	lv_endrow = lv_newrow
end if

for lv_counter  = lv_startrow to lv_endrow
	Selectrow(lv_counter,true)
next
end on

on cntrlclicked;long lv_newrow

lv_newrow = dw_1.Getrow()
dw_1.Selectrow(lv_newrow,TRUE)

end on

event clicked;long lv_row_nbr,lv_num_of_highlighted_rows

lv_row_nbr = row //getclickedrow(dw_1)
if lv_row_nbr > 0 then
	rb_user_selected.checked = TRUE	
	if IsSelected(lv_row_nbr) = True Then
		selectrow(lv_row_nbr,FALSE)
	else
		selectrow(lv_row_nbr,TRUE)
	end if
	lv_num_of_highlighted_rows = dw_1.GetSelectedRow(0) 
	if lv_num_of_highlighted_rows <= 0 then
		rb_none.enabled = FALSE
		cb_details.enabled = FALSE
	else
		rb_none.enabled = TRUE
		cb_details.enabled = TRUE
	end if
end if
end event

on rowfocuschanged;//long lv_row_nbr
//
//lv_row_nbr = dw_1.getrow()
//if lv_row_nbr > 0 Then
//	If Keydown(keyshift!) then
//		this.triggerevent('shiftclicked')
//		return
//	elseif KeyDown(keycontrol!) = TRUE Then
//		this.triggerevent('cntrlclicked')
//		RETURN
//	else
//		selectrow(0,FALSE)
//		selectrow(lv_row_nbr,TRUE)
//		in_row_nbr = lv_row_nbr
//	end if
//end if
//
//
//
end on

type gb_select from groupbox within w_detail_main
string accessiblename = "Select"
string accessibledescription = "Select"
accessiblerole accessiblerole = groupingrole!
integer x = 1486
integer y = 4
integer width = 599
integer height = 368
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Select"
end type

