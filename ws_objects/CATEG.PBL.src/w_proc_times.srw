$PBExportHeader$w_proc_times.srw
forward
global type w_proc_times from w_master_list
end type
end forward

global type w_proc_times from w_master_list
string accessiblename = "Procedure Code List "
string accessibledescription = "Procedure Code List"
integer width = 3465
integer height = 2200
string title = "Procedure Code List"
boolean ib_auto_list = true
boolean ib_display_details = true
boolean ib_display_update = true
event type boolean ue_set_sql_list ( )
end type
global w_proc_times w_proc_times

type variables

end variables

forward prototypes
public function integer of_disable_details (boolean as_enable)
end prototypes

public function integer of_disable_details (boolean as_enable);//*********************************************************************************
// Script Name:	of_disable_details
//
// Arguments:	Boolean value	as_enable
//
// Returns:		Integer
//
// Description:	Enable/disable controls based on user role
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

Long column_text_color, proc_code_color, proc_code_bg_color, ll_border
String	ls_acc

if as_enable then
	column_text_color = stars_colors.window_background
	proc_code_color = stars_colors.lookup_text
	proc_code_bg_color = stars_colors.lookup_back
	ll_border = 5
	ls_acc = "LOOKUP FIELD - Procedure Code"
	dw_details.Object.proc_code.tabsequence = 10
	dw_details.Object.proc_code.tag = "LOOKUP"
	dw_details.Object.staff_time.tabsequence = 20
	dw_details.Object.pre_time.tabsequence = 30
	dw_details.Object.intra_time.tabsequence = 40
	dw_details.Object.post_time.tabsequence = 50
	dw_details.Object.total_time.tabsequence = 60
	dw_details.Object.default_time.tabsequence = 70
	dw_details.Object.override_time.tabsequence = 80
else
	column_text_color = stars_colors.button_face
	proc_code_bg_color = stars_colors.button_face
	proc_code_color = stars_colors.window_text
	ll_border = 0
	ls_acc = "Procedure Code"
	dw_details.Object.proc_code.tabsequence = 0
	dw_details.Object.proc_code.tag = ""
	dw_details.Object.staff_time.tabsequence = 0
	dw_details.Object.pre_time.tabsequence = 0
	dw_details.Object.intra_time.tabsequence = 0
	dw_details.Object.post_time.tabsequence = 0
	dw_details.Object.total_time.tabsequence = 0
	dw_details.Object.report_time.tabsequence = 0
	dw_details.Object.default_time.tabsequence = 0
end if

dw_details.Object.proc_code.border = ll_border
dw_details.Object.staff_time.border = ll_border
dw_details.Object.pre_time.border = ll_border
dw_details.Object.intra_time.border = ll_border
dw_details.Object.post_time.border = ll_border
dw_details.Object.total_time.border = ll_border
dw_details.Object.default_time.border = ll_border
dw_details.Object.proc_code.color = proc_code_color
dw_details.Object.proc_code.background.color = proc_code_bg_color
dw_details.Object.staff_time.background.color = column_text_color
dw_details.Object.pre_time.background.color = column_text_color
dw_details.Object.intra_time.background.color = column_text_color
dw_details.Object.post_time.background.color = column_text_color
dw_details.Object.total_time.background.color = column_text_color
dw_details.Object.default_time.background.color = column_text_color

//	Set Accessibility Props
ls_acc = '"' + ls_acc + '"~t"' + ls_acc + '"'
dw_details.Modify( "proc_code.AccessibleName='" + ls_acc + "' " + &
							"proc_code.AccessibleDescription='" + ls_acc + "'" )

cb_add.enabled = not as_enable

return 1
end function

on w_proc_times.create
int iCurrent
call super::create
end on

on w_proc_times.destroy
call super::destroy
end on

event ue_retrieve_search;call super::ue_retrieve_search;datawindowchild	ldwc_betos_group, ldwc_betos_code

// Add blank to top of list
dw_search.GetChild( "betos_group", ldwc_betos_group )
ldwc_betos_group.InsertRow( 1 )
ldwc_betos_group.SetItem( 1, "betos_group", "" )

dw_search.GetChild( "betos_codes", ldwc_betos_code)
ldwc_betos_code.InsertRow( 1 )
ldwc_betos_code.SetItem( 1, "betos_codes", "" )
end event

event ue_retrieve_detail;call super::ue_retrieve_detail;Long		ll_row
String	ls_proc_code

ls_proc_code = dw_list.GetItemString( al_row, "proc_code" )


RETURN dw_details.Retrieve( ls_proc_code )
end event

event ue_set_access;call super::ue_set_access;//*********************************************************************************
// Script Name:	ue_set_access
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Enable/disable controls based on user role
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

cb_add.enabled = ib_admin_user
cb_reset.enabled = ib_admin_user
cb_delete.enabled = ib_admin_user
cb_update.enabled = ib_admin_user

IF ib_admin_user THEN
	// Leave it as is
ELSE
	// Disable all visual update cues
	dw_details.Object.override_time.border = 0
	dw_details.Object.override_time.tabsequence = 0
	dw_details.Object.override_time.background.color = stars_colors.transparent
END IF
end event

event ue_postsave;call super::ue_postsave;// 01/25/05 Katie Track 4254d Changed return type to allow code to reflect success on save.
of_disable_details(false)
this.event ue_retrieve_list()
RETURN 1
end event

event open;call super::open;/// 01/25/05	Katie Track 4254d Changed code to set dw_details as the update window and allow w_master to handle the deletes/
/// 				for this table

int li_index
event ue_set_access()

li_index = ddlb_dw_ops.finditem( 'Code/Decode', 1)
ddlb_dw_ops.deleteitem( li_index)

of_setupdatedw(dw_details)

dw_details.of_setsinglerow( TRUE)



end event

event ue_preopen;call super::ue_preopen;dw_details.insertrow(0)
end event

event ue_insert;call super::ue_insert;dw_list.setrow(0)
dw_details.Retrieve("")
dw_details.Insertrow( 0)
of_disable_details(true)
end event

event ue_reset;call super::ue_reset;long currentrow
currentrow = dw_details.getrow()
if (dw_details.getitemstatus( currentrow, 0, Primary!) = NewModified!) or &
	(dw_details.getitemstatus( currentrow, 0, Primary!) = New!) then
	this.event ue_insert()
else 
	currentrow = dw_list.getRow( )
	this.event ue_retrieve_detail(currentrow)
	of_disable_details(false)
end if
end event

event ue_presave;call super::ue_presave;int li_save
long currentrow
string ls_proc_code
currentrow = dw_details.GetRow()
if (currentrow > 0) then 
	dw_details.AcceptText()
	ls_proc_code = dw_details.GetItemString(currentrow, "proc_code")
	If (ls_proc_code = "") or IsNull(ls_proc_code) then
		Messagebox('Warning', 'Please enter a procedure code.', None!, Ok!)
		dw_details.setcolumn( "proc_code")
		dw_details.setFocus()
		return -1
	end if
	If (dw_details.GetItemStatus(currentrow, "proc_Code", Primary!) = DataModified!) then
		SELECT PROC_CODE into :ls_proc_code
		FROM PROC_TIMES WHERE PROC_TIMES.PROC_CODE = :ls_proc_code
		Using stars2ca;
		if (stars2ca.sqlnrows > 0) then
			Messagebox('Warning', 'Times already exist for this project code.', None!, Ok!)
			dw_details.setcolumn( "proc_code")
			dw_details.setFocus()
			return -1
		end if
	end if
	If (dw_details.GetItemNumber(currentrow, "total_time") = 0) or IsNull(dw_details.GetItemNumber(1, "total_time")) then
		Messagebox('Warning', 'Please enter a total time.', None!, Ok!)
		dw_details.setcolumn( "total_time")
		dw_details.setFocus()
		return -1
	end if
	If (dw_details.GetItemNumber(currentrow, "default_time") = 0) or IsNull(dw_details.GetItemNumber(1, "default_time")) then
		Messagebox('Warning', 'Please enter a default time.', None!, Ok!)
		dw_details.setcolumn( "default_time")
		dw_details.setFocus()
		return -1
	end if
	if (dw_details.GetItemNumber(currentrow, "override_time") > 0) then
		dw_details.Object.report_time[currentrow] = dw_details.Object.override_time[currentrow]
	else
		dw_details.Object.report_time[currentrow] = dw_details.Object.default_time[currentrow]
	end if
end if
return 0
end event

event ue_set_list_sql;call super::ue_set_list_sql;dw_list.getsqlselect( )
return true
end event

type cb_close from w_master_list`cb_close within w_proc_times
integer x = 3008
integer y = 1556
integer taborder = 70
end type

type uo_range from w_master_list`uo_range within w_proc_times
end type

type st_dw_ops from w_master_list`st_dw_ops within w_proc_times
integer y = 1572
integer width = 521
end type

type cb_delete from w_master_list`cb_delete within w_proc_times
integer y = 1828
integer taborder = 100
end type

type cb_reset from w_master_list`cb_reset within w_proc_times
integer y = 1700
end type

type cb_add from w_master_list`cb_add within w_proc_times
integer x = 2651
integer y = 1556
integer taborder = 60
end type

type dw_details from w_master_list`dw_details within w_proc_times
integer y = 1704
integer height = 376
string dataobject = "d_proc_time_detail"
end type

event dw_details::itemfocuschanged;call super::itemfocuschanged;if (dw_details.GetItemStatus(row, "proc_code", Primary!) = DataModified!) then
	string		ls_sql, ls_proc_desc, ls_proc_code
	ls_proc_code = dw_details.getitemstring( row, "proc_code")
	
	SELECT 	CODE.CODE_DESC INTO :ls_proc_desc
	FROM CODE WHERE CODE.CODE_CODE = :ls_proc_code AND CODE.CODE_TYPE="PC"
	Using stars2ca;
	
	dw_details.Object.proc_desc[row] = ls_proc_desc
	
end if
RETURN 0
end event

event dw_details::ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Lower( as_col ) <> 'proc_code' THEN Return

gv_code_to_use = 'PC'
Open(w_code_lookup)
dw_details.SetItemStatus(1,"proc_code", Primary!, DataModified!)

IF gv_code_to_use <> '' THEN
	dw_details.SetItem( 1, as_col, gv_code_to_use )
END IF
end event

type st_rows from w_master_list`st_rows within w_proc_times
integer x = 1033
integer y = 1568
end type

type cb_update from w_master_list`cb_update within w_proc_times
integer y = 1956
integer taborder = 110
string text = "Save"
end type

type cb_list from w_master_list`cb_list within w_proc_times
integer x = 3003
integer y = 124
end type

type dw_list from w_master_list`dw_list within w_proc_times
integer y = 312
integer height = 1232
string dataobject = "d_proc_time_list"
end type

event dw_list::ue_retrieve;// Katie 01/11/05 Track 4232d Made adjustments for quotes when setting sql.
string	ls_proc_code, ls_proc_desc, ls_orig_sql, ls_new_sql
int		li_pos

// Get paramaters from dw_search
dw_search.AcceptText()
ls_proc_code 	= parent.of_get_like_string( dw_search.GetitemString( 1, "proc_code" ))
ls_proc_desc 	= parent.of_get_like_string( dw_search.GetitemString( 1, "proc_desc" ))

// Set the SQL to original (in case it was overridden by DESC SQL
dw_list.modify("DataWindow.Table.Select=~"" + is_orig_list_sql + "~"")

// Alter the SQL to include Description (causes an inner join)
IF ls_proc_desc <> '%' THEN
	ls_orig_sql = 	dw_list.getsqlselect( )
	li_pos 		= 	pos(ls_orig_sql,"ORDER BY")
	ls_new_sql  = 	left(ls_orig_sql,li_pos - 1) + ' AND CODE.CODE_DESC LIKE ~'%' + UPPER(ls_proc_desc) + '%~' ' + &
						mid(ls_orig_sql,li_pos)	
	dw_list.modify("DataWindow.Table.Select=~"" + ls_new_sql +"~"")
END IF

RETURN this.retrieve( ls_proc_code )
end event

event dw_list::rowfocuschanging;call super::rowfocuschanging;long li_row, li_save
li_row = dw_details.GetRow()
dw_details.Accepttext( )
if (li_row <> 0) then 
	if ((dw_details.GetItemStatus(li_row, "proc_code", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "staff_time", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "pre_time", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "intra_time", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "post_time", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "total_time", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "default_time", Primary!) = DataModified!) or &
		(dw_details.GetItemStatus(li_row, "override_time", Primary!) = DataModified!) or &
		dw_details.Object.PROC_CODE[li_row] = "" )then
		li_save = Messagebox('Warning','Changing rows will lose your changes.~rDo you wish to continue?', Information!, YesNo!)
		if (li_save = 1) then
			of_disable_details(false)
			return 0		
		elseif (li_save = 2) then
			return 1				
		end if
	end if
end if
of_disable_details(false)
return 0
end event

event dw_list::clicked;// override
end event

type dw_search from w_master_list`dw_search within w_proc_times
integer x = 69
integer y = 84
integer height = 200
string dataobject = "d_proc_list_search"
end type

event dw_search::ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Lower( as_col ) <> 'proc_code' THEN Return

gv_code_to_use = 'PC'
Open(w_code_lookup)

IF gv_code_to_use <> '' THEN
	dw_search.SetItem( 1, as_col, gv_code_to_use)
END IF
end event

type gb_details from w_master_list`gb_details within w_proc_times
integer y = 1652
integer height = 436
end type

type ddlb_dw_ops from w_master_list`ddlb_dw_ops within w_proc_times
integer x = 549
integer y = 1560
integer height = 460
end type

type gb_2 from w_master_list`gb_2 within w_proc_times
integer width = 3360
integer height = 264
end type

