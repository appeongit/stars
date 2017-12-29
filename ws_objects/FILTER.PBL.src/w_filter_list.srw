$PBExportHeader$w_filter_list.srw
$PBExportComments$Inherited from w_master_list
forward
global type w_filter_list from w_master_list
end type
type cb_select from u_cb within w_filter_list
end type
type cb_use from u_cb within w_filter_list
end type
type gb_1 from groupbox within w_filter_list
end type
end forward

global type w_filter_list from w_master_list
string accessiblename = "Filter List"
string accessibledescription = "Filter List"
integer height = 2132
string title = "Filter List"
boolean ib_display_daterange = true
cb_select cb_select
cb_use cb_use
gb_1 gb_1
end type
global w_filter_list w_filter_list

type variables
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality

sx_filter_data ix_filter_data
end variables

forward prototypes
public function string of_get_datatype (string as_datatype)
end prototypes

public function string of_get_datatype (string as_datatype);/////////////////////////////////////////////////////////////////////////////
//	
//	MVR	12/19/97 Added powerbuilder data types to the database types...
//	MVR	12/19/97 String, character, dec, double, integer, long, real, 
//	FDG	12/14/00	Stars 4.7.  Make the checking of data types DBMS-independent.
//	GaryR	09/12/05	Track 4444d	Redesign to mimic Master List GUI and functionality
//	
/////////////////////////////////////////////////////////////////////////////

IF	gnv_sql.of_is_character_data_type (as_datatype)	THEN Return 'CHAR'
IF	gnv_sql.of_is_money_data_type (as_datatype)	THEN Return 'MONEY'
IF gnv_sql.of_is_numeric_data_type (as_datatype)	THEN Return 'NUMBER'
IF gnv_sql.of_is_date_data_type (as_datatype)	THEN Return 'DATE'

Return "ERROR"
end function

on w_filter_list.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_use=create cb_use
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_use
this.Control[iCurrent+3]=this.gb_1
end on

on w_filter_list.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_use)
destroy(this.gb_1)
end on

event ue_delete;//////////////////////////////////////////////////////////////////////////////////
//Ancestor overridden
//////////////////////////////////////////////////////////////////////////////////
//
//	03/13/98	AJS	Track 903 4.0-Update delete indicator instead of deleting from table.
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//	01/23/06 HYL 		Track 4616d 	Disallow user to delete the selected filter which is a part of a scheduled job. 
//	02/22/06 HYL		Track 4665d	Also disallow user to delete the selected filter which is associated with any PDQ. 
//	03/02/06	HYL		Track 4665d	Also disallow user to delete the selected filter which is associated with any PDR or Pattern. 
//////////////////////////////////////////////////////////////////////////////////

Integer	li_row, li_count, i_tot_cnt, i
String ls_filter_id, ls_jobs_arr[], ls_jobs
n_ds ds_jobs_related_to_filter, ds_items_tied_to_filter

setmicrohelp(w_main,'Deleting Selected Filter')
if dw_list.rowcount() <= 0 Then
	Messagebox('EDIT','No Records to be Deleted')
   return
end if

li_row = dw_list.GetRow()
IF li_row < 1 THEN
	MessageBox( "Invalid Row", "Please select a filter to delete." )
	Return
END IF

IF MessageBox ('CONFIRMATION!', 'Delete Selected Filter', &
                   Question!,YesNo!,2) = 2 THEN Return

setpointer(hourglass!)

ls_filter_id = dw_list.getitemstring( li_row, "filter_id" )

If Trim(ls_filter_id) = '' then
	Messagebox('EDIT','Unable to get Filter Id')
	RETURN
End IF

// Disallow user to delete the selected filter which is a part of a scheduled job. 01/23/06 HYL Track 4616d
ds_jobs_related_to_filter = CREATE n_ds
ds_jobs_related_to_filter.DataObject = "d_job_list_by_filter_id"
ds_jobs_related_to_filter.SetTransObject(Stars2ca)
ds_jobs_related_to_filter.Retrieve(ls_filter_id)

i_tot_cnt = ds_jobs_related_to_filter.RowCount()
IF i_tot_cnt > 0 THEN
	FOR i = 1 TO i_tot_cnt
		ls_jobs += "~r" + ds_jobs_related_to_filter.Object.subc_name[i]
	NEXT
	MessageBox("Deleting filter", "The selected filter, " + ls_filter_id + ", can not be deleted because it is used in the following scheduled jobs.~r" + &
						ls_jobs )
	RETURN
END IF

// 03/02/06 HYL Track 4665d
ds_items_tied_to_filter = CREATE n_ds
ds_items_tied_to_filter.DataObject = "d_items_tied_to_filter"
ds_items_tied_to_filter.SetTransObject(Stars2ca)
ds_items_tied_to_filter.Retrieve("@" + ls_filter_id)
i_tot_cnt = ds_items_tied_to_filter.RowCount()
IF i_tot_cnt > 0 THEN
	FOR i = 1 TO i_tot_cnt
		ls_jobs += "~r" + ds_items_tied_to_filter.Object.tied_to[i] + "~t( " + ds_items_tied_to_filter.Object.typ[i] + " )"
	NEXT
	MessageBox("Deleting filter", "The selected filter, " + ls_filter_id + ", can not be deleted because it is used in the following items.~r" + &
						ls_jobs )
	RETURN
END IF

UPDATE FILTER_CNTL  
   SET DELETE_IND = 'Y'  
 WHERE FILTER_CNTL.FILTER_ID = Upper( :ls_filter_id )
 Using Stars2ca;

If Stars2ca.of_check_status() <> 0 then
	Errorbox(Stars2ca,'Unable to Delete Filter Control Table')
	RETURN
End IF

If stars2ca.of_commit() <> 0 Then Return
 
dw_list.deleterow(li_row)

If dw_list.rowcount() <= 0 then
	cb_select.enabled = false
	cb_delete.enabled = false
Else
	dw_list.selectrow(li_row,true)	
End IF

dw_list.setfocus()
cb_close.default = true
setmicrohelp(w_main,'Ready')
end event

event ue_insert;//////////////////////////////////////////////////////////////////////////////////
//Ancestor overridden
//////////////////////////////////////////////////////////////////////////////////
//
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//
//////////////////////////////////////////////////////////////////////////////////

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Filter Maintenance...')
ix_filter_data.sx_entry_mode = 'ADD'
OpenSheetWithParm(w_filter_maintain,ix_filter_data,mdi_main_frame,help_menu_position,Layered!)
setmicrohelp(w_main,'Ready')

end event

event open;call super::open;///////////////////////////////////////////////////////////////////////////////
//	FDG 	12/18/97	Stars 3.6 (prob 184) - This window can either be opened
//						with ix_filter_data sent to it or with no parm at all.
//						As a result, Message.Powerobjectparm must always be
//						reset to null after checking to see if a parm was sent
//						to this window.
//
//	FDG 	05/01/98	Stars 4.0 (#1171) - When 'USE' set userid.text to the user.
//	GaryR	09/12/05	Track 4444d	Redesign to mimic Master List GUI and functionality
// GaryR	07/22/09	WIN.650.5721.007	Remove create and append filter from Window Ops
//
///////////////////////////////////////////////////////////////////////////////

Int li_pos
String	ls_datatype

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Filter List')

ddlb_dw_ops.Reset()
This.Event ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')

if upper(ix_filter_data.sx_entry_mode) = 'APPEND' then
	ls_datatype = ix_filter_data.sx_data_window.Describe(ix_filter_data.sx_col_name + ".ColType")
	li_pos = Pos(ls_datatype, '(')
	IF li_pos > 0 THEN
		ls_datatype = left(ls_datatype, (li_pos - 1))
	END IF
	
	ls_datatype = This.of_get_datatype( ls_datatype )
	IF ls_datatype = "ERROR" THEN
		Messagebox('EDIT','Unable to establish Data Type for the Column')
		RETURN
	END IF
	
	dw_search.modify( "user_id.Protect='1' data_type.Protect='1'")
	dw_search.SetItem( 1, "data_type", ls_datatype )
	cb_delete.enabled = false
	cb_add.enabled = false
	dw_search.SetFocus()
	dw_search.SetColumn( "filter_id" )
//Code to send datatype from w_criteria_claim_link (rbuttondown)
Elseif upper(ix_filter_data.sx_entry_mode) = 'USE' then
	cb_select.enabled = false							//KMM 8/30/95 Prob#980
	cb_use.visible = true								//KMM 8/30/95 Prob#980
	cb_use.default = true
	cb_delete.enabled = false
	cb_add.enabled = false
	ls_datatype = This.of_get_datatype( ix_filter_data.sx_col_name )
	
	IF ls_datatype = "ERROR" THEN
		Messagebox('EDIT','Unable to establish Data Type for the Column')
		RETURN
	END IF
	
	dw_search.modify( "data_type.Protect='1'")
	dw_search.SetItem( 1, "data_type", ls_datatype )
End If
end event

event ue_retrieve_search;call super::ue_retrieve_search;//=============================================================================================//
// Object		w_filter_list
// Event			ue_retrieve_search
// Parameters	None
// Returns		None
// Call stack	Called from open event (w_master_list)
//=============================================================================================//
// Prepares dw_search
// * Adds "All users"
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//=============================================================================================//
DataWindowChild 	ldwc_search
int					i

// Add "  <All Users>"
dw_search.GetChild( "user_id", ldwc_search )
i = ldwc_search.InsertRow( 1 )
ldwc_search.SetItem( i, "cf_name", "< All Users >" )
ldwc_search.SetItem( i, "user_id", "" )
dw_search.SetItem( 1, "user_id", gc_user_id )
end event

event ue_row_access;call super::ue_row_access;//////////////////////////////////////////////////////////////////////////////////
//
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//	02/22/06	GaryR	Track 4669	Disable the delete button if appending or looking up filter
//
//////////////////////////////////////////////////////////////////////////////////

String ls_user_id
Integer	li_row

setpointer(hourglass!)

// Override cb_delete if appending or looking up filter
IF ix_filter_data.sx_entry_mode = 'APPEND' &
OR ix_filter_data.sx_entry_mode = 'USE' THEN
	cb_delete.enabled = FALSE
	Return
END IF

li_row = dw_list.getrow()

// FDG 01/17/02 Track 2699d.  If no rows exist, get out
If dw_list.RowCount()	<	1	OR li_row < 1 then 
	Return
End If

ls_user_id  = dw_list.getitemstring( li_row, 'user_id' )

If ls_user_id = gc_user_id then
	cb_delete.enabled = true
Else
	// Client Admin can delete
	// other users' filters
	if upper(gv_user_sl) = 'AD' then
		cb_delete.enabled = true
	else 
		cb_delete.enabled = false
	end if
End IF
end event

event ue_postopen;call super::ue_postopen;//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality

cb_list.Triggerevent( Clicked! )
end event

event ue_list_row_doubleclicked;call super::ue_list_row_doubleclicked;//////////////////////////////////////////////////////////////////////////////////
//
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//	03/05/07	GaryR	Track 4924	Use ancestor's event to prevent confusion of DblClick
//
//////////////////////////////////////////////////////////////////////////////////

IF ix_filter_data.sx_entry_mode = 'USE' THEN
	cb_use.triggerEvent( Clicked! )
else
	cb_select.triggerEvent( Clicked! )
end if
end event

type cb_close from w_master_list`cb_close within w_filter_list
integer x = 3118
integer y = 1900
end type

type uo_range from w_master_list`uo_range within w_filter_list
integer x = 2149
integer y = 112
integer width = 928
integer height = 296
end type

event uo_range::constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////////
//
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
// 12/14/05 JasonS Track 4545d Fix GPF issue, moved this code block
//								 to the window preopen event.  Also added check to make sure
//			 				     that powerobjectparm is the correct type before assigning
//////////////////////////////////////////////////////////////////////////////////

IF IsValid( message.powerobjectparm ) then
	if (message.powerobjectparm.classname() = 'sx_filter_data') THEN
		ix_filter_data = message.powerobjectparm
		//KMM Clear out message parm (PB Bug)
		SetNull(message.powerobjectparm)			// FDG	12/18/97
	end if
END IF
end event

type st_dw_ops from w_master_list`st_dw_ops within w_filter_list
integer x = 0
integer y = 1888
integer width = 521
alignment alignment = right!
end type

type cb_delete from w_master_list`cb_delete within w_filter_list
integer x = 2770
integer y = 1900
boolean enabled = true
end type

type cb_reset from w_master_list`cb_reset within w_filter_list
boolean visible = false
integer x = 1545
integer y = 1524
end type

type cb_add from w_master_list`cb_add within w_filter_list
integer x = 2423
integer y = 1900
boolean enabled = true
end type

type dw_details from w_master_list`dw_details within w_filter_list
boolean visible = false
integer x = 1408
integer y = 1452
integer width = 114
end type

type st_rows from w_master_list`st_rows within w_filter_list
integer x = 1239
integer y = 1664
end type

type cb_update from w_master_list`cb_update within w_filter_list
boolean visible = false
integer x = 1911
integer y = 1524
end type

type cb_list from w_master_list`cb_list within w_filter_list
integer x = 3090
integer y = 160
end type

type dw_list from w_master_list`dw_list within w_filter_list
integer x = 0
integer y = 440
integer width = 3461
integer height = 1432
string dataobject = "d_filter_list"
end type

event dw_list::ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////////////////////////
//	Revision History
//
//	01/12/99	FDG	Track 2047c.  Y2K changes to allow a 4-digit date and range.
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//
/////////////////////////////////////////////////////////////////////////////

String	ls_search, ls_sql
Int		li_rc
Long		ll_rows
n_cst_sqlattrib	lnv_sqlattrib[]

setpointer(hourglass!)
setmicrohelp(w_main,'Retrieving Filter List')

IF dw_search.AcceptText() <> 1 THEN RETURN -1
li_rc = dw_search.GetRow()

IF li_rc <> 1 THEN
	MessageBox( "Error", "Unable to determine the search criteria" )
	Return -1
END IF

gnv_sql.of_parse( is_orig_list_sql, lnv_sqlattrib )

// Get FilterID
ls_search = Trim( dw_search.GetItemString( 1, "filter_id" ) )
IF ls_search <> "" THEN
	lnv_sqlattrib[1].s_where += " AND FILTER_ID LIKE ('" + ls_search + "%')"
END IF

//	Get UserID
ls_search = Trim( dw_search.GetItemString( 1, "user_id" ) )
IF ls_search <> "" THEN
	lnv_sqlattrib[1].s_where += " AND USER_ID LIKE ('" + ls_search + "%')"
END IF

// Get DataType
ls_search = Trim( dw_search.GetItemString( 1, "data_type" ) )
IF ls_search <> "" THEN
	lnv_sqlattrib[1].s_where += " AND FILTER_DATA_TYPE = '" + ls_search + "'"
END IF

//	Get FilterCol
ls_search = Trim( dw_search.GetItemString( 1, "col" ) )
IF ls_search <> "" THEN
	lnv_sqlattrib[1].s_where += " AND FILTER_COL LIKE ('%" + ls_search + "%')"
END IF

// Get FilterDesc
ls_search = Trim(dw_search.GetItemString( 1, "desc" ) )
IF ls_search <> "" THEN
	lnv_sqlattrib[1].s_where += " AND Upper( FILTER_DESC ) LIKE ('%" + Upper( ls_search ) + "%')"
END IF

// Set the ranges
lnv_sqlattrib[1].s_where += " AND FILTER_DATETIME BETWEEN " + &
								gnv_sql.of_get_to_date( String( id_from, "mm/dd/yyyy" ) ) + " AND " + &
								gnv_sql.of_get_to_date( String( id_thru, "mm/dd/yyyy" ) )

// Rebuild the SQL
ls_sql = gnv_sql.of_assemble( lnv_sqlattrib )

This.Reset()

This.SetTransObject(stars2ca)
This.SetSQLSelect( ls_sql )
ll_rows = This.Retrieve()
Stars2ca.of_commit()

IF ll_rows = 0 THEN
	if upper(ix_filter_data.sx_entry_mode) = 'USE' then   //KMM 8/30/95 Prob#980
		cb_use.enabled = false										//KMM 8/30/95 Prob#980
	else	
		cb_select.enabled = false
	end if

	Return 0
Else
	if upper(ix_filter_data.sx_entry_mode) = 'USE' then   //KMM 8/30/95 Prob#980
		cb_use.enabled = true										//KMM 8/30/95 Prob#980
		cb_use.default = true										//KMM 8/30/95 Prob#980
	else	
		cb_select.enabled = true
		cb_select.default = true
	end if
end if 
	
Setmicrohelp(w_main,'Ready')
Return 1
end event

event dw_list::constructor;call super::constructor;//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality

This.of_setupdateable( FALSE )
end event

type dw_search from w_master_list`dw_search within w_filter_list
integer x = 32
integer width = 2011
integer height = 320
string dataobject = "d_filter_search"
boolean livescroll = false
end type

event dw_search::itemchanged;call super::itemchanged;//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality

cb_list.default = TRUE
end event

type gb_details from w_master_list`gb_details within w_filter_list
boolean visible = false
integer x = 1376
integer y = 1396
integer width = 905
end type

type ddlb_dw_ops from w_master_list`ddlb_dw_ops within w_filter_list
integer x = 521
integer y = 1880
integer width = 535
integer height = 148
end type

type gb_2 from w_master_list`gb_2 within w_filter_list
integer x = 0
integer width = 2080
integer height = 400
end type

type cb_select from u_cb within w_filter_list
string accessiblename = "Select"
string accessibledescription = "Select..."
integer x = 2075
integer y = 1900
integer width = 343
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Select..."
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////
//
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//
//////////////////////////////////////////////////////////////////////////////////

Integer	li_row

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Filter Details...')

li_row = dw_list.GetRow()
IF li_row < 1 THEN Return

IF UPPER(ix_filter_data.sx_entry_mode) <> 'APPEND' THEN
	ix_filter_data.sx_entry_mode = 'SELECT'
END IF

ix_filter_data.sx_filter_id =  dw_list.getitemstring(li_row,"filter_id")


OpenSheetWithParm(w_filter_maintain,ix_filter_data,mdi_main_frame,help_menu_position,Layered!)
setmicrohelp(w_main,'Ready')
IF UPPER(ix_filter_data.sx_entry_mode) = 'APPEND' THEN
	CLOSE(PARENT)
END IF

end event

type cb_use from u_cb within w_filter_list
boolean visible = false
string accessiblename = "Use"
string accessibledescription = "Use"
integer x = 1728
integer y = 1900
integer width = 343
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Use"
end type

event clicked;//List Filters For Use / use button script

//*********************************************************************************
//	
// 02/09/00 FDG	Stars 4.5	Fix a bug where the button and the window must
//						be valid to trigger the button's clicked event.
//	09/12/05	GaryR	Track 4444d	Redesign to mimic Master List GUI and functionality
//
//*********************************************************************************

window lv_window
commandbutton lv_button
long lv_row_nbr

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

lv_row_nbr = dw_list.getrow()

gv_active_filter = Trim(dw_list.getitemstring(lv_row_nbr,"filter_id"))
lv_window = ix_filter_data.sx_window
lv_button = ix_filter_data.sx_button
close(parent)

If IsValid(lv_window)		&
and IsValid (lv_button)		then
	lv_button.triggerevent(clicked!)
End IF
// FDG 02/09/00 - end	
end event

type gb_1 from groupbox within w_filter_list
string accessiblename = "Filter Date"
string accessibledescription = "Filter Date"
accessiblerole accessiblerole = groupingrole!
integer x = 2117
integer y = 28
integer width = 1349
integer height = 400
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Filter Date"
end type

