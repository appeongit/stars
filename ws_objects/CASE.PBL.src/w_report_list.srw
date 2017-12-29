$PBExportHeader$w_report_list.srw
forward
global type w_report_list from w_master_list
end type
type cb_view from commandbutton within w_report_list
end type
type cb_download from u_cb within w_report_list
end type
type gb_1 from groupbox within w_report_list
end type
end forward

global type w_report_list from w_master_list
string accessiblename = "Document Manager "
string accessibledescription = "Document Manager"
integer width = 3561
integer height = 2592
string title = "Document Manager"
boolean ib_display_details = true
boolean ib_display_update = true
boolean ib_display_daterange = true
boolean ib_case_security = true
string is_case_field = "case_id"
cb_view cb_view
cb_download cb_download
gb_1 gb_1
end type
global w_report_list w_report_list

type variables

end variables

on w_report_list.create
int iCurrent
call super::create
this.cb_view=create cb_view
this.cb_download=create cb_download
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_view
this.Control[iCurrent+2]=this.cb_download
this.Control[iCurrent+3]=this.gb_1
end on

on w_report_list.destroy
call super::destroy
destroy(this.cb_view)
destroy(this.cb_download)
destroy(this.gb_1)
end on

event ue_retrieve_detail;call super::ue_retrieve_detail;//=============================================================================================//
// Object		w_report_list
// Event			ue_retrieve_detail
// Parameters	al_row (long) - Selected row in dw_list
// Returns		None
//=============================================================================================//
// Sets instance variables then Retrieves dw_details 
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 09/13/05	MikeF	SPR4509d	Enable Reset button - Removed row level access code
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//=============================================================================================//

Long		ll_row
String	ls_link_type, ls_link_key, ls_case_id, ls_case_spl, ls_case_ver, ls_case_key

ls_link_type 	= trim(dw_list.GetItemString( al_row, "link_type" 		))
ls_link_key 	= trim(dw_list.GetItemString( al_row, "link_key" ))
ls_case_key 	= trim(dw_list.GetItemString( al_row, "case_id"			))

ls_case_spl 	= trim(mid(ls_case_key, 11, 2))
ls_case_ver 	= trim(mid(ls_case_key, 13, 2))
ls_case_id 		= trim(left(ls_case_key, 10))

gnv_sql.of_trimdata( ls_case_spl )
gnv_sql.of_trimdata( ls_case_ver )

dw_details.reset( )

ll_row = dw_details.Retrieve( ls_link_type, ls_link_key, ls_case_id, ls_case_spl, ls_case_ver )

RETURN ll_row
end event

event ue_preopen;call super::ue_preopen;dw_details.insertrow(0)
end event

event ue_set_list_sql;call super::ue_set_list_sql;//	12/14/04	GaryR	Track 4158d	Add time to thru date
// 01/07/05 Katie Track 4221d Added Order by to sql
// 06/10/05 MikeF Track 4319d Moved all SQL to d_report_list

RETURN TRUE

end event

event open;call super::open;// 12/01/04 Katie Added defaults for user_id and create to_date and from_date
//	10/04/05	GaryR	Track 4530d	Reset access variable which impacts PDR reports
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

datawindowchild ldwc_code

This.of_set_sys_cntl_range (TRUE)

// Set blank and defualt user_id
dw_search.GetChild( "user_id", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "cf_name", "" )
dw_search.SetItem( 1, "user_id", gc_user_id )

//	Set blank file_ext
dw_search.GetChild( "file_ext", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "file_type", "" )
end event

event ue_delete;///////////////////////////////////////////////////////////////////////////////
//
//	12/01/04	Katie	Removed cb_delete to prevent duplication from w_master_list.  
//						Added ue_delete and moved code from old delete button here.
//	02/01/05	GaryR	Track 4268d	Override parent and move message here.
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////////

Long		ll_row
String 	ls_delete_ind, ls_link_id, ls_link_name, ls_link_type
String	ls_case_id, ls_case_spl, ls_case_ver, ls_message
n_cst_report		lnv_report
n_cst_attachments	lnv_att
n_cst_case	lnv_case

ll_row = dw_list.GetRow()
IF ll_row < 1 THEN
	MessageBox( "Delete Error", "Unable to identify the current row" )
	Return
END IF

ls_link_id 		= dw_list.GetItemString( ll_row, "link_key" )
ls_link_type 	= dw_list.GetItemString( ll_row, "link_type" )
ls_link_name 	= dw_list.GetItemString( ll_row, "link_name" )
ls_case_id 		= dw_list.GetItemString( ll_row, "case_id" )

ls_case_spl = Mid( ls_case_id, 11, 2 )
ls_case_ver = Mid( ls_case_id, 13, 2 )
ls_case_id = Left( ls_case_id, 10 )
gnv_sql.of_TrimData ( ls_case_id )
gnv_sql.of_TrimData ( ls_case_spl )
gnv_sql.of_TrimData ( ls_case_ver )

IF MessageBox ( 'Delete Row', 'Are you sure you want to delete the selected document name ' + &
								ls_link_name + '?', Exclamation!, YesNoCancel! ) <> 1 THEN Return


// delete case link row
dw_details.deleterow( dw_details.getrow( ) )	
IF dw_details.Update( ) <> 1 THEN
	MessageBox( "Delete Error", "Failed to delete document from CSE_LINK", StopSign! )
	Return
END IF

IF ls_link_type = "ATT" THEN
	IF lnv_att.of_delete_cntl( ls_link_id ) <> 1 THEN
		Stars2ca.of_rollback()
		Return
	END IF
ELSE
	Select delete_ind         
		into :ls_delete_ind
		from bg_rpt_cntl
		where rpt_id = Upper( :ls_link_id )
	Using stars2ca;
			
	If stars2ca.of_check_status() <> 0 then
		if stars2ca.of_check_status() <> 100 then
			errorbox(stars2ca,'Error removing report.')
			Return
		else
			/* Report is not a background pattern report */
			Stars2ca.of_commit()
			IF lnv_report.of_delete( ls_link_id, ls_link_type ) < 0 THEN Return
		end if
	else
		Stars2ca.of_commit()
	End If	
			
	if ls_delete_ind = 'Y' then	
		/* Background Pattern report has been viewed*/
		IF lnv_report.of_delete( ls_link_id, ls_link_type ) < 0 THEN Return
	else
		/* Report is background pattern that has not be viewed */
		Update bg_rpt_cntl
			Set delete_ind = 'Y'
			Where rpt_id = Upper( :ls_link_id )
		Using Stars2ca;
				
		If stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error setting delete indicator. Report not removed')
			Return
		else
			stars2ca.of_commit()
		End If	
	end if
END IF

// Create case log entry
ls_message	=	"Link "	+	ls_link_name	+	" ("	+	ls_link_type	+	") removed."
lnv_case = Create n_cst_case
IF	lnv_case.uf_audit_log (gv_active_case, ls_message) < 0 THEN
	Stars2ca.of_rollback()
	MessageBox ('Delete Error', 'Could not insert case log for removal of link '	+	ls_link_name	+	&
					'.  Case: ' + gv_active_case + '. Script: '		+	&
					'w_report_list.ue_delete')
	Return
END IF

// Mass commit
Stars2ca.of_commit()

// re-retrieve dw list
this.event ue_retrieve_list( )
end event

event ue_list_row_doubleclicked;call super::ue_list_row_doubleclicked;// 12/14/04	SPR4156d MikeFl Double click views report
cb_view.event clicked()
end event

event ue_presave;call super::ue_presave;//==========================================================================================//
// Object:  	w_report_list 
// Script:		ue_presave
// Arguments:	none
// Returns:		Integer	0 if successful, -1 if there is an issue
//------------------------------------------------------------------------------------------
// Maintenance 
// -------- -----	--------	-----------------------------------------------------------------
// 05/04/05	GaryR	SPR4366d	Validate Link Name and add entry to Case Log
// 06/08/05	MikeF	SPR4319d	Rewrote to take advantage of new n_cst_case method
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//==========================================================================================//

string		ls_case_id, ls_case_spl, ls_case_ver
string		ls_link_type, ls_old_name, ls_new_name, ls_message
long			ll_row, ll_count
n_cst_case	lnv_case

ll_row = dw_list.GetRow()
IF ll_row < 1 THEN
	MessageBox( "Save Error", "Unable to identify the current row" )
	Return -1
END IF

ls_case_id 		= dw_list.GetItemString( ll_row, "case_id" )
ls_link_type 	= dw_list.GetItemString( ll_row, "link_type" )
ls_old_name 	= dw_list.GetItemString( ll_row, "link_name" )
ls_new_name 	= trim(dw_details.GetItemString( 1, "link_name" ))

ls_case_spl = Mid( ls_case_id, 11, 2 )
ls_case_ver = Mid( ls_case_id, 13, 2 )
ls_case_id = Left( ls_case_id, 10 )
gnv_sql.of_TrimData ( ls_case_id )
gnv_sql.of_TrimData ( ls_case_spl )
gnv_sql.of_TrimData ( ls_case_ver )

IF Trim( ls_new_name ) = "" THEN
	MessageBox('Edit','Link Name cannot be blank, please enter a new Id.')
	Return -1
ELSEIF Pos( ls_new_name, "'" ) > 0 OR Pos( ls_new_name, '"' ) > 0 THEN
	Messagebox('Edit','Invalid Character entered, please enter a new Id.')
	Return -1
END IF

IF ls_new_name <> ls_old_name THEN
	lnv_case = CREATE n_cst_case
	
	// Check if Link with that name already exists
	IF lnv_case.uf_get_link_exists(ls_case_id, ls_case_spl, ls_case_ver, ls_link_type, ls_new_name) THEN
		Destroy lnv_case
		MessageBox('Edit','Duplicate Link Name, please choose another name')
		RETURN -1
	END IF
	
	// Write to audit log
	IF ls_case_id <> 'NONE' THEN
		IF ls_link_type = "ATT" THEN
			ls_message   = "Attachment " + ls_old_name + " renamed to " + ls_new_name
		ELSE
			ls_message   = "Report " + ls_old_name + " renamed to " + ls_new_name
		END IF
	
		IF	lnv_case.uf_audit_log ( ls_case_id, ls_case_spl, ls_case_ver, ls_message )	< 0 THEN
			Destroy lnv_case
			Stars2ca.of_rollback()
			MessageBox ('Database Error', 'Could not insert new document name into case log')
			Return -1
		END IF

	END IF
	
	Destroy lnv_case
	
END IF

Return AncestorReturnValue
end event

event ue_row_access;call super::ue_row_access;//=============================================================================================//
// Object		w_report_list
// Event			ue_row_access
// Parameters	None
// Returns		None
//=============================================================================================//
// Enables / disables objects based on access rules
//=============================================================================================//
// Maintenance
// -------- ----- -----------	--------------------------------------------------------------------
// 09/13/05	MikeF	Track 4509d	Enable Reset button - Moved all access code here
//	10/04/05	GaryR	Track 4530d	Reset access variable which impacts PDR reports
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//=============================================================================================//

Long		ll_row
String	ls_user_id, ls_case_status, ls_link_type

ll_row = dw_list.GetRow()

cb_download.enabled = FALSE

IF ll_row > 0 THEN
	ls_user_id		= trim(dw_list.GetItemString( ll_row, "link_user_id" 	))
	ls_link_type	= trim(dw_list.GetItemString( ll_row, "link_type" 	))
	cb_download.enabled = ls_link_type = "ATT"
	
	ls_case_status	= trim(dw_list.GetItemString( ll_row, "case_status" 	))
	IF IsNull(ls_case_status) THEN ls_case_status = ' '
	
	// If case is closed, referred closed, deleted, OR not owner then disable
	IF ls_case_status = 'CL'		&
	OR ls_case_status = 'RC'		&
	OR ls_case_status = 'DL'		&
	OR gc_user_id <> ls_user_id THEN
		ib_admin_user = FALSE
	ELSE
		ib_admin_user = TRUE
	END IF
ELSE
	ib_admin_user = FALSE
END IF

cb_update.enabled = ib_admin_user
cb_delete.enabled = ib_admin_user
cb_reset.enabled  = ib_admin_user

IF ib_admin_user THEN
	dw_details.Object.link_name.border = 5
	dw_details.Object.link_name.tabsequence = 10
	dw_details.Object.link_name.background.color = icl_white

	dw_details.Object.link_desc.border = 5
	dw_details.Object.link_desc.tabsequence = 20
	dw_details.Object.link_desc.background.color = icl_white
ELSE
	dw_details.Object.link_name.border = 0
	dw_details.Object.link_name.tabsequence = 0
	dw_details.Object.link_name.background.color = icl_grey
	
	dw_details.Object.link_desc.border = 0
	dw_details.Object.link_desc.tabsequence = 0
	dw_details.Object.link_desc.background.color = icl_grey
END IF
end event

type cb_close from w_master_list`cb_close within w_report_list
integer x = 3113
integer y = 2100
end type

type uo_range from w_master_list`uo_range within w_report_list
integer x = 2181
integer y = 128
integer width = 942
integer height = 284
end type

type st_dw_ops from w_master_list`st_dw_ops within w_report_list
integer x = 32
integer y = 2116
integer height = 64
end type

type cb_delete from w_master_list`cb_delete within w_report_list
integer x = 2011
integer y = 2100
end type

type cb_reset from w_master_list`cb_reset within w_report_list
integer x = 3113
integer y = 2356
end type

type cb_add from w_master_list`cb_add within w_report_list
boolean visible = false
integer x = 3058
integer y = 1480
end type

type dw_details from w_master_list`dw_details within w_report_list
integer x = 50
integer y = 2244
integer width = 2981
integer height = 212
string dataobject = "d_report_maint"
end type

type st_rows from w_master_list`st_rows within w_report_list
end type

type cb_update from w_master_list`cb_update within w_report_list
integer x = 3113
integer y = 2232
end type

type cb_list from w_master_list`cb_list within w_report_list
integer x = 3127
integer y = 200
end type

type dw_list from w_master_list`dw_list within w_report_list
integer y = 480
integer width = 3474
integer height = 1616
string dataobject = "d_report_list"
boolean hsplitscroll = true
end type

event dw_list::rowfocuschanged;call super::rowfocuschanged;if this.getrow() > 0 then
	cb_view.enabled = true
else
	cb_view.enabled = false
End if
end event

event dw_list::ue_retrieve;call super::ue_retrieve;//=======================================================================================//
//	Object:			dw_list
//	Script:			ue_retrieve
//	Arguments:		None
//	Returns:			Long
//---------------------------------------------------------------------------------------//
// Retrieves list data
//=======================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------
//	06/10/05 MikeF	SPR4319d Moved retrieve logic here rather than setting SQL
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//=======================================================================================//

String	ls_user, ls_report_name, ls_report_type, ls_desc
String	ls_file_name, ls_file_type, ls_case_id, ls_case_spl, ls_case_ver
int		li_rc, li_len

IF dw_search.AcceptText() <> 1 THEN RETURN 0

ls_user 			= Trim(dw_search.GetItemString( 1, "user_id" ) )
ls_report_name	= Trim(dw_search.GetItemString( 1, "report_name" ) ) 	+ "%"
ls_case_id 		= Trim(dw_search.GetItemString( 1, "case_id" ) )
ls_desc	 		= Trim(dw_search.GetItemString( 1, "description" ) ) 	+ "%"
ls_report_type = Trim(dw_search.GetItemString( 1, "report_type" ) )	+ "%"
ls_file_name	= Trim(dw_search.GetItemString( 1, "file_name" ) ) 	+ "%"
ls_file_type	= Trim(dw_search.GetItemString( 1, "file_ext" ) ) 		+ "%"

// Set values for searches
IF IsNull(ls_user) THEN ls_user = "%"
IF IsNull(ls_file_name) THEN ls_file_name = "%"
IF IsNull(ls_file_type) THEN ls_file_type = "%"
IF len(ls_desc) > 1 	THEN ls_desc = "%" + ls_desc
IF len(ls_file_name) > 1 THEN ls_file_name = "%" + ls_file_name

li_len = Len( ls_case_id )
IF li_len > 10 THEN
	ls_case_spl = Trim( Mid( ls_case_id, 11, 2 )) + "%"
	ls_case_ver = Trim( Mid( ls_case_id, 13, 2 )) + "%"
	ls_case_id = Trim( Left( ls_case_id, 10 )) + "%"
ELSE
	ls_case_id += "%"
	ls_case_spl = "%"
	ls_case_ver = "%"
END IF

RETURN dw_list.retrieve(ls_report_name, ls_user, ls_desc, ls_report_type, &
								ls_case_id, ls_case_spl, ls_case_ver, id_from, id_thru, ls_file_name, ls_file_type)
end event

type dw_search from w_master_list`dw_search within w_report_list
integer x = 37
integer y = 68
integer width = 2107
integer height = 404
string dataobject = "d_report_search"
end type

event dw_search::constructor;call super::constructor;THIS.of_SetUpdateable( FALSE )
THIS.of_SetDropDownCalendar( TRUE )
THIS.iuo_calendar.of_Register( "from_date", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "to_date", this.iuo_calendar.NONE )
end event

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

IF Lower( as_col ) = 'case_id' THEN
	gv_from = 'AC'
	Open(w_case_list_response)
	IF Trim( gv_active_case ) > "" THEN
		This.object.case_id[1] = gv_active_case
	END IF
END IF
end event

type gb_details from w_master_list`gb_details within w_report_list
integer x = 27
integer y = 2188
integer width = 3465
integer height = 292
end type

type ddlb_dw_ops from w_master_list`ddlb_dw_ops within w_report_list
integer y = 2100
integer height = 328
end type

type gb_2 from w_master_list`gb_2 within w_report_list
integer y = 8
integer width = 2130
integer height = 472
string text = "Search Criteria"
end type

type cb_view from commandbutton within w_report_list
string accessiblename = "View"
string accessibledescription = "View"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2747
integer y = 2100
integer width = 343
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "View"
end type

event clicked;//	12/22/04	GaryR	Track 4182d	Apply modify/update security
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	07/02/07	GaryR	Track 5089	When modifing saved PDR, update date and create log

Long	ll_row
String ls_link_name, ls_link_id, ls_delete_ind, ls_link_type, ls_case_id
n_cst_report		lnv_report
n_cst_attachments	lnv_att

ll_row = dw_list.getrow()

IF ll_row <= 0 THEN
	Messagebox('Error', 'Please select a document to view.', StopSign! )
	Return
END IF
	
ls_link_name = dw_list.GetItemString( ll_row, "link_name" )
ls_link_id = dw_list.GetItemString( ll_row, "link_key" )
ls_link_type = dw_list.GetItemString( ll_row, "link_type" )
ls_case_id = Trim( dw_list.GetItemString( ll_row, "case_id" ) )

// Handle attachments
IF ls_link_type = "ATT" THEN
	lnv_att.of_view( ls_link_id )
	Return
END IF

Select delete_ind                   
	into :ls_delete_ind					
	from bg_rpt_cntl
	where rpt_id = Upper( :ls_link_id )
Using stars2ca;
Stars2ca.of_check_status()
If stars2ca.sqlcode = 100 then
	//rpt not generated and 'ML' from back end
	stars2ca.of_commit()
	lnv_report.of_view( ls_case_id, ls_link_id, ls_link_name, ib_admin_user )
ElseIf stars2ca.sqlcode = 0 Then
	If ls_delete_ind = 'Y' Then		//01-20-97 AJS
		//Rpt has already been viewed and saved as stars report
		stars2ca.of_commit()
		lnv_report.of_view( ls_case_id, ls_link_id, ls_link_name, ib_admin_user )
	Else 
		lnv_report.of_view_patt_rpt( ls_case_id, ls_link_id, ls_link_name )
	End If
Else				
	Messagebox('Database error','Unable to read the Background Report Control Table')
	Return
End If
end event

type cb_download from u_cb within w_report_list
string accessiblename = "Download"
string accessibledescription = "Download"
integer x = 2373
integer y = 2100
integer width = 357
integer height = 108
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string text = "Download"
end type

event clicked;call super::clicked;//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

Long	ll_row
String	ls_link_id
n_cst_attachments	lnv_att

ll_row = dw_list.getrow()

IF ll_row <= 0 THEN
	Messagebox('Error', 'Please select a document to download.', StopSign! )
	Return
END IF
	
ls_link_id = dw_list.GetItemString( ll_row, "link_key" )
lnv_att.of_download( ls_link_id )
end event

type gb_1 from groupbox within w_report_list
string accessiblename = "Last Updated"
string accessibledescription = "Last Updated"
accessiblerole accessiblerole = groupingrole!
integer x = 2167
integer y = 8
integer width = 1330
integer height = 472
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Last Updated"
end type

