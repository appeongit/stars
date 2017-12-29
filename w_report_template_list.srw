HA$PBExportHeader$w_report_template_list.srw
$PBExportComments$(Inherited from w_master)
forward
global type w_report_template_list from w_master
end type
type dw_search from u_dw within w_report_template_list
end type
type dw_list from u_dw within w_report_template_list
end type
type dw_columns from u_dw within w_report_template_list
end type
type cb_list from u_cb within w_report_template_list
end type
type cb_use from u_cb within w_report_template_list
end type
type cb_cancel from u_cb within w_report_template_list
end type
type cb_delete from u_cb within w_report_template_list
end type
type st_count_list from statictext within w_report_template_list
end type
type st_count_cols from statictext within w_report_template_list
end type
type cb_default from u_cb within w_report_template_list
end type
type gb_1 from groupbox within w_report_template_list
end type
end forward

global type w_report_template_list from w_master
long backcolor = 67108864
string accessiblename = "Report Template List"
string accessibledescription = "Report Template List"
accessiblerole accessiblerole = windowrole!
integer x = 128
integer y = 188
integer width = 3090
integer height = 1556
string title = "Report Template List"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type integer ue_check_tbl_types ( )
event type integer ue_create_list ( )
event ue_open_menu ( )
event ue_update_default_template ( )
event type string ue_use_template ( )
event rbuttonup pbm_rbuttonup
event ue_initialize ( )
dw_search dw_search
dw_list dw_list
dw_columns dw_columns
cb_list cb_list
cb_use cb_use
cb_cancel cb_cancel
cb_delete cb_delete
st_count_list st_count_list
st_count_cols st_count_cols
cb_default cb_default
gb_1 gb_1
end type
global w_report_template_list w_report_template_list

type variables
Protected:

String is_inv_types, is_additional_data_source
string			in_selected

// Text for default commandbutton
Constant	String	is_default	= 'De&fault'
Constant	String	is_clear_default = 'C&lear Default'


end variables

event ue_check_tbl_types;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_report_template_list	ue_check_tbl_types 	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//Called in itemchanged event of dw_columns.  
//Must determine if the table types of the columns match the data 
//source selected. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	???			???			???
//	FNC			04/28/98		Track 1139. If viewing an ML subset and have ub92
//									invoices in subset add the corresponding revenue table
//									to the list of tables that are verified.
//
// FNC			03/25/99		Rls Stars 4.0 Sp2 Track 2164 Starcare TS2164C. 
//									Data source and additional data source are passed
//									in two separate variables. This window will display
//									both data sources.
/////////////////////////////////////////////////////////////////////////////
integer	li_num_inv_types,		&
			li_inv
long 		ll_dw_columns_count,	&
			ll_index,				&
			ll_occur
string 	ls_tbl_type,			&
			ls_template_type,		&
			ls_inv_types,			&
			ls_base_type,			&
			ls_rev_tbl,				&
			ls_array_inv_types[]
n_cst_string lnvo_cst_string
n_cst_revenue	lnvo_cst_revenue
			
//FNC 04/28/98 Start

ls_inv_types = is_inv_types + ',' + is_additional_data_source		// FNC 03/25/99

ls_template_type = left(dw_search.GetItemString(1,'template_types'),2)

if ls_template_type = 'ML' then
	lnvo_cst_string.of_parsetoarray(ls_inv_types,',',ls_array_inv_types)
	li_num_inv_types = upperbound(ls_array_inv_types)
	lnvo_cst_revenue = create n_cst_revenue
	for li_inv = 1 to li_num_inv_types
		ls_base_type = lnvo_cst_revenue.of_get_base_type(ls_array_inv_types[li_inv])
		if ls_base_type = 'UB92' then
			ls_rev_tbl = lnvo_cst_revenue.of_get_revenue(ls_array_inv_types[li_inv])
			ll_occur = lnvo_cst_string.of_countoccurrences(is_inv_types,ls_rev_tbl)
			if ll_occur = 0 then
				ls_inv_types = ls_inv_types + ',' + ls_rev_tbl
			end if
		end if
	next
	destroy(lnvo_cst_revenue)
end if

ll_dw_columns_count = dw_columns.rowcount()

for ll_Index = 1 to ll_dw_columns_count
	ls_tbl_type = dw_columns.GetItemString(ll_Index,'tbl_type')
	// locate the invoice type in is_inv_types 
	If Pos(ls_inv_types,ls_tbl_type) < 1 Then			//FNC 04/28/98
			MessageBox('Error',&
			+ 'This template includes columns for a data source ' &
			+ 'not selected in this query.',StopSign!,Ok!)
			//dw_columns.reset()
		/* unselect row */
			return -1
	End If
next

Return 1
end event

event ue_create_list;//ue_create_list()
//Will take the criteria from dw_search and use it to build 
//an SQL statement to retrieve dw_list.  The user_id, template_id 
//and template_description will use a like and wildcard so will by 
//the beginning of the partial strings.  The query_type will use the 
//two character invocie type in the dddw.  The date and range will be 
//used together to produce a range of dates for the creation date.  
//(Must check for valid date and number).
//	NOTE: This code is very similar to u_nvo_list's ue_tabpage_list_create_list 
//			event, so any changes made here should probably be incorporated in
//			that event.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	???		??			Created.
//	J.Mattis	02/04/98	Changed SQL logic to only select report 'RPT' types.										.
//							Added guards against assigning NULLs to SQL string. 
//	FDG		04/03/98	Track 1033. Template ID correlates to link_name (not
//							link_id).
//	FDG		04/15/98	Track 1071. Commit after retrieving to free any locks.
// AJS 		08/18/98 TS144-Report On Enhancements
// FNC		10/28/98	Track 1754. If Description for search contains a
//							single quote put string in double quotes for sql and change
//							any double quotes in string to single quotes. Otherwise use
//							single quotes. Edit for quote in template id.
//	FNC		11/03/98	Track 1939. Change link type to TMP. Change pdq_type to T.
//	FDG		01/12/99	Track 2047c.  Y2K changes to allow a 4-digit date and range.
// FNC		03/25/99	Rls Stars 4.0 Sp2 Track 2164 Starcare TS2164C. 
//							Data source and additional data source are passed
//							in two separate variables. This window will display
//							both data sources.
//	GaryR		01/05/01	Stars 4.7 DataBase Port - Date Conversion and Single quotes
//							in the where clause.
//	GaryR		03/19/01	Stars 4.7 DataBase Port - Case Sensitivity
//	GaryR		07/12/01	Track 2350d	Using the empty string in SQL
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

dw_columns.Reset(); dw_list.Reset()	

//n_cst_get_date_range lnv_get_date_range
n_cst_string	lnvo_cst_string
datawindowchild ldwc_template_type
string ls_default_templates_only
string ls_sql, ls_user_id, ls_template_id, ls_template_desc
string ls_addl_template_type
string ls_template_type, ls_from_date, ls_range
string ls_start_date, ls_end_date
string ls_single_quote, ls_double_quote
integer li_range, li_function_return, li_rc
long ll_rowcount
DateTime ldt_from_date
String	ls_empty		//	GaryR		07/12/01	Track 2350d

ls_single_quote = "'"; ls_double_quote = '"'

dw_search.getchild('template_type',ldwc_template_type)

//NLG 8-18-98 ts144 - report on enhancements 							***START***
//ls_sql = "select cl.user_id, cl.link_name, pc.query_type, " &
//		+  "cl.link_desc, cl.link_date, pc.query_id , cl.link_key " &
//		+	"from case_link cl, pdq_cntl pc " &
//		+	"where cl.link_key = pc.query_id and cl.link_type = 'RPT' and pc.pdq_type = 'R' "	

//FNC 11/03/98 Change link_type and pdq_type values
ls_sql = "select cl.user_id, cl.link_name, pc.query_type, " &
		+  "cl.link_desc, cl.link_date, pc.query_id , cl.link_key, " &
		+	"pc.addl_query_type, pc.default_template " &
		+	"from case_link cl, pdq_cntl pc " &
		+	"where cl.link_key = pc.query_id and cl.link_type = 'TMP' and pc.pdq_type = 'T' " &
		+  "and pc.user_id <> 'SYSTEM' "
//NLG 8-18-98 																			***STOP**
li_function_return = dw_search.AcceptText()		

//	FDG 04/03/98 begin
IF	li_function_return	<	0		THEN
	Return -1
END IF
// FDG 04/03/98 end

ls_user_id = dw_search.GetItemString(1,'user_id')	
ls_user_id = trim(ls_user_id)

ls_template_id = dw_search.GetItemString(1,'template_id')
ls_template_id = trim(ls_template_id)

ls_template_desc = dw_search.GetItemString(1,'description')
ls_template_desc = trim(ls_template_desc)

ls_template_type = dw_search.GetItemString(1,'template_types')
ls_template_type = left(Upper(Trim(ls_template_type)),2)

// FNC 03/25/99 Start
ls_addl_template_type = dw_search.GetItemString(1,'Addl_Template_Type')
ls_addl_template_type = left(Upper(Trim(ls_addl_template_type)),2)
// FNC 03/25/99 End

ls_range = dw_search.GetItemString(1,'range')
ls_range = Trim(ls_range)

ls_from_date = dw_search.GetItemString(1,'date')
ls_from_date = Trim(ls_from_date)

// the following checks may be done in the datawindow painter (edit fields) 

// FDG 1/12/99 begin

//If Not(isdate(ls_from_date)) then
//	MessageBox('Error','Incorrect date entered.',StopSign!,Ok!)
//	return -1
//End If
//
//If IsNull(ls_Range) Then ls_Range = ''
//
//li_range = Integer(ls_range)
//
//If li_range < 1 Then
//	MessageBox('Error','Incorrect range entered.',StopSign!,Ok!)
//	return -1
//End If

n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate (ls_from_date)

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		Return	-1
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		Return	-1
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		Return	-1
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.  These changed values must be redisplayed.
ldt_from_date		=	lnv_datetime.of_GetFromDateTime (ls_from_date, ls_range)
dw_search.object.date[1]	=	ls_from_date
dw_search.object.range[1]	=	ls_range
ls_start_date		=	String (ldt_from_date, 'mm/dd/yyyy hh:mm:ss')
ls_end_date			=	ls_from_date	+	' 23:59:59'
li_range				=	Integer(ls_range)

// FDG 1/12/99 end



/* if no criteria entered, give warning message or if only description 
is entered give another warning message  */

//verify that the user id has been populated
If Not(IsNull(ls_user_id)) AND Trim(ls_user_id) <> '' Then 
	// FNC 10/28/98 Start
	if match(ls_user_id,ls_single_quote) or match(ls_user_id,ls_double_quote) then
		Messagebox("Error","User ID cannot contain quotes",StopSign!,Ok!)
		return -1
	end if
	// FNC 10/28/98 End
	ls_sql = ls_sql + " and cl.user_id like '" + ls_user_id + "%'"
End If

//verify that the template id has been populated	
If Not(IsNull(ls_template_id)) AND Trim(ls_template_id) <> '' Then 
	//ls_sql = ls_sql + " and cl.link_key like '" + ls_template_id + "%'"	// FDG 04/03/98
	// FNC 10/28/98 Start
	if match(ls_template_id,ls_single_quote) or match(ls_template_id,ls_double_quote) then
		Messagebox("Error","Report Template ID cannot contain quotes",StopSign!,Ok!)
		return -1
	end if
	// FNC 10/28/98 End
	ls_sql = ls_sql + " and cl.link_name like '" + ls_template_id + "%'"		// FDG 04/03/98
End If
	
//verify that the template desc. has been populated		
If Not(IsNull(ls_template_desc)) AND Trim(ls_template_desc) <> '' Then 
	// FNC 10/28/98 Start
	if match(ls_template_desc,ls_single_quote) then													
		if match(ls_template_desc,ls_double_quote) then
			ls_template_desc = lnvo_cst_string.of_globalreplace(ls_template_desc,ls_double_quote,ls_single_quote)
		end if
		//	GaryR		03/19/01	Stars 4.7 DataBase Port - Begin
		IF ls_template_desc <> "" THEN
			ls_sql = ls_sql + " and cl.link_desc like '" + ls_template_desc + "%'"		// FDG 04/03/98
		END IF
	else
		IF ls_template_desc <> "" THEN
			ls_sql = ls_sql + " and cl.link_desc like '" + ls_template_desc + "%'"		// FDG 04/03/98
		END IF
		//	GaryR		03/19/01	Stars 4.7 DataBase Port - End
	end if
	// FNC 10/28/98 End
End If

//verify that the template type has been populated		
If Not(IsNull(ls_template_type)) AND Trim(ls_template_type) <> '' Then 
	ls_sql = ls_sql + " and pc.query_type = '" +ls_template_type+ "'"
End If

// FNC 03/25/99 Start
If IsNull(ls_addl_template_type) or Trim(ls_addl_template_type) = '' Then
	//	GaryR		07/12/01	Track 2350d - Begin
	//ls_sql = ls_sql + " and pc.addl_query_type = ''"
	gnv_sql.of_TrimData( ls_empty )
	ls_sql = ls_sql + " and pc.addl_query_type = '" + ls_empty + "'"
	//	GaryR		07/12/01	Track 2350d - End
else
	ls_sql = ls_sql + " and pc.addl_query_type = '" + ls_addl_template_type + "'"
End If
// FNC 03/25/99 End

// FDG 01/13/99 begin
//lnv_get_date_range = Create n_cst_get_date_range
//
//li_function_return = lnv_get_date_range.&
//	of_get_date_range(ls_from_date,ls_start_date,ls_end_date,li_range)
//	
//Destroy lnv_get_date_range
//
//If li_function_return = 1 Then
//	Return -1
//End If
// FDG 01/13/99 begin

//fx_get_date_range(ls_from_date,ls_start_date,ls_end_date,li_range)

//verify that the date range has been populated
If Not IsNull(ls_start_date) AND Not IsNull(ls_end_date) AND &
	Trim(ls_start_date) <> '' AND Trim(ls_end_date) <> '' Then 
//	GaryR		01/05/01	Stars 4.7 DataBase Port
//	ls_sql = ls_sql + " and cl.link_date between '" + ls_start_date &
//	+ "' and '" + ls_end_date + "'"
	ls_sql = ls_sql + " and cl.link_date between " + &
			gnv_sql.of_get_to_date( ls_start_date ) + " and " + &
			gnv_sql.of_get_to_date( ls_end_date )
End If

ls_default_templates_only = dw_search.GetItemString(1,'report_template_default')

//AJS 08-18-98 TS144 Report On Enhancements
If ls_default_templates_only = '1' then
	ls_sql = ls_sql + " and pc.default_template = 'Y' "
End If
//ajs end

dw_list.SetTransObject(Stars2ca)
dw_list.setSQLselect( Upper( ls_sql ) )

ll_rowcount = dw_list.retrieve()

if ll_rowcount = 0 then
	st_count_list.visible = false
	st_count_cols.visible = false
	MessageBox('Information','No templates matched the select criteria.',Information!)
	return -1
elseif ll_rowcount < 0 then
	st_count_list.visible = false
	st_count_cols.visible = false
	return -1
end if

//AJS 08/18/98 TS144-Report On Enhancements
st_count_list.visible = true
st_count_list.text = string(ll_rowcount)


Stars2ca.of_commit()								// FDG 04/15/98

Return 1

end event

event ue_update_default_template;////////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created.
//	FDG	10/16/98	Track 1717.  If the command button's text says
//						"Clear Default" then do NOT update any rows to be
//						the default template.
//
////////////////////////////////////////////////////////////////////////
integer li_return
long ll_found, ll_idx, ll_row, ll_rowcount
string ls_find, ls_query_id, ls_user_id, ls_query_name, ls_query_type, ls_addl_query_type, ls_sql
n_ds	ds_report_template

ll_row = dw_list.GetRow()
ls_query_id = dw_list.GetItemString(ll_row,'pdq_cntl_query_id')
ls_query_type = dw_list.GetItemString(ll_row,'pdq_cntl_query_type')
ls_user_id = dw_list.GetItemString(ll_row,'case_link_user_id')

If ls_user_id <> gc_user_id then
	ls_query_name = dw_list.GetItemString(ll_row,'case_link_Link_name')
	MessageBox("Error","Can not set default template.  Current user id does not own template id " + ls_query_name,StopSign!)
	Return
End IF	

ls_addl_query_type = dw_list.GetItemString(ll_row,'pdq_cntl_addl_query_type')

ds_report_template = CREATE n_Ds
ds_report_template.DataObject = 'd_report_template_default'
ds_report_template.SetTransObject(stars2ca)
ll_rowcount = ds_report_template.Retrieve(ls_user_id,ls_query_type,ls_addl_query_type) 

If ll_rowcount < 0 then
	MessageBox("Error","Cannot retrieve Report template information for user/query type: " + ls_user_id + ' / ' + ls_query_type + ':' + ls_addl_query_type,StopSign!)
	destroy(ds_report_template)
	return
END IF


For ll_idx = 1 to ll_rowcount 
	If ds_report_template.Object.pdq_cntl_default_template[ll_idx] = 'Y' then
		ds_report_template.Object.pdq_cntl_default_template[ll_idx] = ' '
	End If
	// FDG 10/16/98 - also check the cbutton's text
	If ds_report_template.Object.pdq_cntl_query_id[ll_idx] = ls_query_id		&
	And cb_default.text	=	is_default													then
		ds_report_template.Object.pdq_cntl_default_template[ll_idx] = 'Y'
	End If
Next

//Update datastore with new default template indicators

li_return = ds_report_template.EVENT ue_update( TRUE, TRUE )

If li_return < 0 then
	Stars2ca.of_rollback()
	MessageBox('Error Saving Default Template',&
		'Error updating the pdq control table.', StopSign!, Ok!)
	Return
Else
	Stars2ca.of_commit()				
End If

destroy(ds_report_template)

//refresh datawindows
This.event ue_create_list()

//scroll the roll that the user selected
dw_list.SelectRow(0, FALSE)
ls_find = "pdq_cntl_query_id = '" + ls_query_id + "'"
ll_found = dw_list.Find(ls_find,	1, dw_list.RowCount( ))
dw_list.ScrolltoRow(ll_found)
dw_list.SelectRow(ll_found,TRUE)
end event

event ue_use_template;call super::ue_use_template;
string ls_template_id
long ll_current_row
Integer		li_rc

ll_current_row = dw_list.GetRow()

If ll_current_row > 0 Then
Else
	MessageBox('Error',&
		'Please select a Pre-Defined Report Template',StopSign!,Ok!)
	Return ''
End If

li_rc	=	This.event ue_check_tbl_types()

IF	li_rc	<	0		THEN
	Return ''
END IF

ls_template_id = &
	dw_list.GetItemString(ll_current_row,'case_link_link_key')

Return ls_template_id


end event

event ue_initialize();//Will set the datawindows, load the dw_search with invoice types 
//passed in and retrieve dw_list using the defaults in dw_search.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	???		??				Created.
//	J.Mattis	02/04/98		Changed SQL logic to only select the invoice types
//								associated with the current query.
//	FDG		03/11/98		Track 65.  Include sr.id_2 in ls_sql.	
//	FDG		04/08/98		Track 1052.  Include ancillary tables in the SQL for
//								ldwc_template_types.
// FNC		04/22/98		Track 983 If viewing an ML subset and ML datasource is
//								selected want to select ML templates.
// FNC		04/29/98		Must put quotes around each table in string if not ML so 
//								that dddw retrieve is correct in case there is more than 
//								one table.
// FNC		03/25/99		Rls Stars 4.0 Sp2 Track 2164 Starcare TS2164C. 
//								Data source and additional data source are passed
//								in two separate variables. This window will display
//								both data sources.
//	GaryR		11/10/03		Track 3665d	Prevent bug caused by PB 8.0.4.10501
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

long 		ll_count,		&
			ll_new_row,		&
			ll_pos,			&
			ll_dddw_row,	&
			ll_rows_retrieved, &
			ll_row
string 	ls_sql,			&
			ls_DefaultInvoiceType,	&
			ls_id_2, 		&
			ls_elem_desc
Constant String LS_MULTI_LEVEL	=	"ML - Multi Level"
			
datawindowchild ldwc_template_types
n_cst_string n_String

ll_row	=	dw_search.insertrow(0)

dw_search.getchild('template_types',ldwc_template_types)

ll_row	=	dw_search.insertrow(0)

dw_search.getchild('template_types',ldwc_template_types)
//FNC 04/22/98 Start
if left(is_inv_types,2) = 'ML' then	/* ML Report Subset View */		//FNC 04/29/98
	is_inv_types = mid(is_inv_types,4) /*strip off ML that was temporarily added */
	ll_dddw_row	= ldwc_template_types.InsertRow(1)			//	Insert at the top
	ldwc_template_types.SetItem (ll_dddw_row, 'stars_rel_id_2', "ML")
	ldwc_template_types.SetItem (ll_dddw_row, 'dictionary_elem_desc', "Multi Level")
	ls_DefaultInvoiceType = LS_MULTI_LEVEL
else
	ls_sql = "select dt.elem_desc, sr.id_2 " &
		+ "from stars_rel sr, dictionary dt " &
		+ "where sr.id_2 = dt.elem_tbl_type " &
		+ "and sr.rel_type in ('QT','AN') " &
		+ "and dt.elem_type = 'TB'" &
		+ "and sr.id_2 = '" + Upper( is_inv_types ) + "'" 	// FNC 03/25/99
// FNC 03/25/99 End
		
	ldwc_template_types.setsqlselect(ls_sql) 
	ldwc_template_types.SetTransObject(Stars2ca)
	ll_rows_retrieved = ldwc_template_types.retrieve()
	
	If ll_rows_retrieved > 0 Then 
		ls_DefaultInvoiceType = ldwc_template_types.GetItemString(1,'stars_rel_id_2')
	end if
end if
//FNC 04/22/98 End
dw_Search.Object.template_types[1] = ls_DefaultInvoiceType

if trim(is_additional_data_source) <> '' then
	select distinct sr.id_2, dt.elem_desc
		into :ls_id_2, :ls_elem_desc
	from stars_rel sr, dictionary dt
	where sr.id_2 = dt.elem_tbl_type
		and sr.rel_type = 'DP'
		and dt.elem_type = 'TB'
		and sr.id_2 = Upper( :is_additional_data_source )
	using stars2ca;
	
	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error retrieving additional data source description.' + &
			'Description will not be displayed')
		dw_Search.Object.addl_template_type[1] = is_additional_data_source
	else
		dw_Search.Object.addl_template_type[1] = ls_id_2 + " - " + ls_elem_desc
	end if
end if

dw_search.object.user_id[1] = gc_user_id

// get the default range
If IsValid(inv_sys_cntl) Then
	dw_search.object.date[1] = inv_sys_cntl.of_get_default_date()
	dw_search.object.range[1] = string(inv_sys_cntl.of_get_cntl_no())
End If

this.event ue_create_list()
end event

on w_report_template_list.create
int iCurrent
call super::create
this.dw_search=create dw_search
this.dw_list=create dw_list
this.dw_columns=create dw_columns
this.cb_list=create cb_list
this.cb_use=create cb_use
this.cb_cancel=create cb_cancel
this.cb_delete=create cb_delete
this.st_count_list=create st_count_list
this.st_count_cols=create st_count_cols
this.cb_default=create cb_default
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_search
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.dw_columns
this.Control[iCurrent+4]=this.cb_list
this.Control[iCurrent+5]=this.cb_use
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.st_count_list
this.Control[iCurrent+9]=this.st_count_cols
this.Control[iCurrent+10]=this.cb_default
this.Control[iCurrent+11]=this.gb_1
end on

on w_report_template_list.destroy
call super::destroy
destroy(this.dw_search)
destroy(this.dw_list)
destroy(this.dw_columns)
destroy(this.cb_list)
destroy(this.cb_use)
destroy(this.cb_cancel)
destroy(this.cb_delete)
destroy(this.st_count_list)
destroy(this.st_count_cols)
destroy(this.cb_default)
destroy(this.gb_1)
end on

event ue_preopen;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_report_template_list	ue_PreOpen				Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Must set NVO to retrieve date ranges for from SYS_CNTL table to use 
// in list criteria.  Note:  see spec ts176.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/05/98		Created.
//	A.Sola			08/18/98 	TS144-Report On Enhancements
// F.Chernak		03/25/99		Rls Stars 4.0 Sp2 Track 2164 Starcare TS2164C. 
//										Data source and additional data source are passed
//										in two separate variables. This window will display
//										both data sources.
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//
/////////////////////////////////////////////////////////////////////////////

string ls_parm
integer li_pos

ls_parm = message.StringParm
li_pos = pos(ls_parm,'~t') 
If li_pos > 0 then
	is_inv_types = left(ls_parm,(li_pos - 1))
	is_additional_data_source = mid(ls_parm,(li_pos + 1))
Else
	is_inv_types = ls_parm
End if
// FNC 03/25/99 End

/* create nvo to get range from sys_cntl */
inv_sys_cntl = create u_nvo_sys_cntl
inv_sys_cntl.of_set_cntl_id ('RANGE')
end event

event close;call super::close;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_report_template_list	Close						Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Destroy NVO which retrieves date ranges for from SYS_CNTL table to use 
// in list criteria.  Note:  see spec ts176.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/05/98		Created.
// A.Sola			08/18/98		TS144-Report On Enhancements
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//
/////////////////////////////////////////////////////////////////////////////

If IsValid(inv_sys_cntl) Then
	DESTROY inv_sys_cntl
End If
end event

event ue_delete;//************************************************************************
//	Script:	w_report_template_list.ue_Delete - OVERRIDE THE ANCESTOR
//
//	Description:	Delete a row in the appropriate d/w.
//
//Maintenance Log
//
//	FNC	11/03/98		Track 1939. Change link type to TMP. Change pdq_type to T.
//
//************************************************************************

String		ls_sql,			&
				ls_query_id,	&
				ls_user_id
Integer		li_rc,			&
				li_msg
Long			ll_row

//	Any necessary edits are placed in ue_predelete.
li_rc	=	This.Event ue_PreDelete ()

IF	li_rc	<	1		THEN
	Return
END IF

ll_row	=	dw_list.GetRow()

IF	ll_row	<	1		THEN
	Return
END IF

li_msg	=	MessageBox ( 'Stars', &
				'Are you sure you want to delete this report template?', &
				Exclamation!, YesNo!)

CHOOSE CASE li_msg
	CASE 1
		//	Yes - Delete the row
	CASE 2
		// No - Cancel the deletion
		Return
END CHOOSE

ls_query_id	=	dw_list.object.pdq_cntl_query_id [ll_row]
ls_user_id	=	dw_list.object.case_link_user_id [ll_row]

// FNC 11/03/98 Change link_type value
ls_sql		=	"Delete from case_link  Where link_key = '"	+	Upper( ls_query_id )	+	&
					"' and user_id = '"	+	Upper( ls_user_id	)								+	&
					"' and link_type = 'TMP'"

li_rc			=	Stars2ca.of_execute (ls_sql)

IF	li_rc		<	0			THEN
	MessageBox ('Delete Error', 'Error deleting from the CASE_LINK table')
	Stars2ca.of_rollback()
	Return
END IF

// FNC 11/03/98 Change pdq_type value
ls_sql		=	"Delete from pdq_cntl  Where query_id = '"	+	Upper( ls_query_id )	+	&
					"' and user_id = '"	+	Upper( ls_user_id )									+	&
					"' and pdq_type = 'T'"

li_rc			=	Stars2ca.of_execute (ls_sql)

IF	li_rc		<	0			THEN
	MessageBox ('Delete Error', 'Error deleting from the PDQ_CNTL table')
	Stars2ca.of_rollback()
	Return
END IF

ls_sql		=	"Delete from pdq_columns  Where query_id = '"	+	Upper( ls_query_id )	+	&
					"' and col_type = 'TMP'"

li_rc			=	Stars2ca.of_execute (ls_sql)

IF	li_rc		<	0			THEN
	MessageBox ('Delete Error', 'Error deleting from the PDQ_COLUMNS table')
	Stars2ca.of_rollback()
	Return
END IF

Stars2ca.of_commit()

This.Event	ue_create_list()

w_main.SetMicroHelp ('Report template deleted successfully')

end event

event open;call super::open;//************************************************************************************
// 12/13/99 FNC	Pattern Library Changes - Set dw_list as the datawindow to print
//						so that window can access window operations code in w_master
//	11/10/03	GaryR	Track 3665d	Prevent bug caused by PB 8.0.4.10501
//************************************************************************************

of_SetPrintDw(dw_list)
THIS.POST Event ue_initialize()
end event

event ue_predelete;call super::ue_predelete;//************************************************************************
//	Script:			w_report_template_list.ue_PreDelete
//	Description:	Checks if the user deleting the template is the originator.
// Revision:
//************************************************************************
//
// Gary-R	10/10/2000 3014c Prevent the user from deleting a template
//									  that wasn't created by that same user.
//
//************************************************************************

Long	ll_row
SetPointer( HourGlass! )
ll_row =	dw_list.GetRow()

IF	ll_row <	1 THEN Return AncestorReturnValue

// Make sure that the creator is deleting the template
IF dw_list.GetItemString( ll_row, "case_link_user_id" ) <> gc_user_id THEN
	MessageBox ( "STARS", "You can not delete a report template~n~rThat was created by another user!", StopSign! )
	Return 0
END IF

Return AncestorReturnValue
end event

type dw_search from u_dw within w_report_template_list
string accessiblename = "Search"
string accessibledescription = "Search"
accessiblerole accessiblerole = clientrole!
integer x = 32
integer y = 72
integer width = 3008
integer height = 420
integer taborder = 10
string dataobject = "d_report_template_search"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_list from u_dw within w_report_template_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 524
integer width = 2304
integer height = 800
integer taborder = 20
string dataobject = "d_report_template_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

this.of_SingleSelect(True)

//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)


end event

event rowfocuschanged;call super::rowfocuschanged;////////////////////////////////////////////////////////////////////////
//RowFocusChanged Event:
//When a template is selected, dw_columns is retrieved with that 
//template id.  Before displaying columns must make sure their 
//table types match with invoice types passed in.  The templates 
//may contain dependent columns that do not match the data source 
//selected or ML may not contain same invoice types.
////////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created.
//
//	FDG	04/15/98	Track 1071.  Commit to free any locks.
//
//	FDG	04/29/98	Track 1140.  Display the element description instead
//						of column name in dw_columns.  To do this, must use
//						elem_desc to the left of '/' (or 15 bytes)
//
//	FDG	05/05/98	Track 1189.  Don't edit the table types until the
//						user clicks the Use button.
// AJS  	08/18/98	TS144-Report On Enhancements
//	FDG	10/16/98	Track 1717.  If PDQ_CNTL_DEFAULT_TEMPLATE = 'Y' (the
//						default template, don't disable the cbutton.  Instead,
//						allow the user to undo the default.
//	GaryR	09/12/02	SPR 3070d	Preserve case of description
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
////////////////////////////////////////////////////////////////////////


String		ls_sql,			&
				ls_query_id

Long			ll_rowcount

dw_columns.setredraw(FALSE)

If this.GetRow() > 0 then
	ls_query_id = dw_list.GetItemString(currentrow,'PDQ_CNTL_QUERY_ID')
Else
	Return
End If

ll_rowcount		=	dw_columns.retrieve(ls_query_id)

// AJS 08/18/98 TS144-Report On Enhancements
st_count_cols.text = String(ll_rowcount)
st_count_cols.visible = True
If dw_list.GetItemString(currentrow,'PDQ_CNTL_DEFAULT_TEMPLATE') = 'Y' then
	cb_default.enabled = true
	cb_default.text	=	is_clear_default			// FDG 10/16/98
else
	cb_default.text	=	is_default					// FDG 10/16/98
	IF	dw_list.GetItemString(currentrow,'case_link_user_id') <> gc_user_id	THEN
		cb_default.enabled = false
	ELSE
		cb_default.enabled = true
	END IF
End If
// AJS 08/18/98 Ts144-end


Stars2ca.of_commit()								// FDG 04/15/98

dw_columns.SelectRow(0,FALSE)					// FDG 04/03/98

dw_columns.setredraw(TRUE)
end event

event doubleclicked;////////////////////////////////////////////////////////////////////////
//Doublclicked Event:
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	FNC	12/13/99 Utilize centralized window operations in w_master
//
////////////////////////////////////////////////////////////////////////

//RETURN Parent.of_Window_Operation(this,row,dwo)

w_report_template_list	lw_parent

This.of_GetParentWindow (lw_parent)

lw_parent.of_window_operations(this ,row, dwo)
end event

type dw_columns from u_dw within w_report_template_list
string accessiblename = "Columns"
string accessibledescription = "Columns"
accessiblerole accessiblerole = clientrole!
integer x = 2336
integer y = 524
integer width = 713
integer height = 800
integer taborder = 30
string dataobject = "d_report_template_columns"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject(Stars2ca)

This.of_SetUpdateable (FALSE)

this.of_SingleSelect(True)
end event

type cb_list from u_cb within w_report_template_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 855
integer y = 1360
integer taborder = 50
string text = "&List"
boolean default = true
end type

event clicked;call super::clicked;//cb_list (inherited from u_cb)
//Lists the templates.
//Clicked Event:
//Will take the criteria from dw_search and use it to build an 
//SQL statement to retrieve dw_list. 

parent.event ue_create_list()

end event

type cb_use from u_cb within w_report_template_list
string accessiblename = "Use"
string accessibledescription = "Use"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1225
integer y = 1360
integer taborder = 60
string text = "&Use"
end type

event clicked;call super::clicked;//cb_use (inherited from u_cb)
//Returns template.
//Clicked Event:
//Will close the window returning the template id.
//
string ls_template_id

ls_template_id = parent.event ue_use_template()
If IsNull(ls_template_id) then
Else
	closewithreturn(parent,ls_template_id)
End IF

end event

type cb_cancel from u_cb within w_report_template_list
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1966
integer y = 1360
integer taborder = 80
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;//cb_cancel (inherited from u_cb)
//Close window.
//Clicked Event:
//Close window passing back flag not to load template.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	??					??				Created.
//	J.Mattis			02/05/98		Added descriptive return string to correct error in which
//										report columns were cleared from selected columns in query's 
//										report tabpage.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Constant String S_NOLOAD = 'CANCEL'

CloseWithReturn(parent,S_NOLOAD)

end event

type cb_delete from u_cb within w_report_template_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1595
integer y = 1360
integer taborder = 70
string text = "&Delete"
end type

event clicked;call super::clicked;Parent.Event	ue_delete()

end event

type st_count_list from statictext within w_report_template_list
boolean visible = false
string accessiblename = "Template Count"
string accessibledescription = "Template Count"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 1364
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_count_cols from statictext within w_report_template_list
boolean visible = false
string accessiblename = "Template Column Count"
string accessibledescription = "Template Column Count"
accessiblerole accessiblerole = statictextrole!
integer x = 2775
integer y = 1364
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_default from u_cb within w_report_template_list
string accessiblename = "Default"
string accessibledescription = "Default"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 347
integer y = 1360
integer width = 457
integer taborder = 40
boolean enabled = false
string text = "De&fault"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////
//cb_default (inherited from u_cb)
//Makes selected template the default template.
//Clicked Event:


parent.event ue_update_default_template()
end event

type gb_1 from groupbox within w_report_template_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 23
integer y = 12
integer width = 3031
integer height = 496
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

