HA$PBExportHeader$w_dw_viewer.srw
$PBExportComments$Data Window Viewer (inherited from w_master)
forward
global type w_dw_viewer from w_master
end type
type cb_save from u_cb within w_dw_viewer
end type
type cb_report_options from u_cb within w_dw_viewer
end type
type cb_calendar from u_cb within w_dw_viewer
end type
type st_count from statictext within w_dw_viewer
end type
type ddlb_dw_ops from dropdownlistbox within w_dw_viewer
end type
type st_dw_ops from statictext within w_dw_viewer
end type
type dw_1 from u_dw within w_dw_viewer
end type
type cb_close from u_cb within w_dw_viewer
end type
end forward

global type w_dw_viewer from w_master
string accessiblename = "Datawindow Viewer"
string accessibledescription = "Datawindow Viewer"
integer x = 73
integer y = 116
integer width = 3109
integer height = 2068
event ue_enable_report_options ( boolean ab_unsecure,  string as_report_id )
event type integer ue_save_report_changes ( )
cb_save cb_save
cb_report_options cb_report_options
cb_calendar cb_calendar
st_count st_count
ddlb_dw_ops ddlb_dw_ops
st_dw_ops st_dw_ops
dw_1 dw_1
cb_close cb_close
end type
global w_dw_viewer w_dw_viewer

type variables
w_uo_win iv_uo_win
string in_selected
string  in_dw_control
sx_decode_structure in_decode_struct
int in_row

// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
boolean ib_data_changed = false
boolean ib_syntax_changed = false
n_cst_report inv_report
string is_link_name
end variables

event ue_enable_report_options(boolean ab_unsecure, string as_report_id);// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//	12/22/04	GaryR Track 4182d	Apply modify/update security
//	10/04/05	GaryR	Track 4531d	For PDR reports, use the CASE_LINK report_id

Boolean	lb_pdr

// For PDR reports enable the report options button
//	and reset the report id to the CASE_LINK link_key
lb_pdr = dw_1.describe("st_report_id.visible") <> '!'
cb_report_options.visible = lb_pdr
IF lb_pdr THEN dw_1.modify("st_report_id.text = '" + as_report_id + "'" )

// Apply security
IF NOT ab_unsecure THEN
	dw_1.Object.DataWindow.ReadOnly='Yes'
	cb_report_options.enabled = FALSE
END IF

// If calendar, enable the calendar button
cb_calendar.visible = dw_1.describe("t_calendar.text") = 'calendar'
end event

event type integer ue_save_report_changes();// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//	05/31/07	GaryR	Track 5049	Use link_key instead of link_name
//	07/02/07	GaryR	Track 5089	When modifing saved PDR, update date and create log

Integer	li_rc
String 	ls_report_id, ls_case_id, ls_case_spl, ls_case_ver, ls_msg
Boolean	lb_saved
n_cst_case	lnv_case

dw_1.accepttext()
ls_report_id = dw_1.Describe("st_report_id.text")

IF ls_report_id = "!" OR Trim( ls_report_id ) = "" THEN
	Messagebox("Error", "Cannot find the report id necessary for update.")
	Return -1
END IF

if ib_data_changed then
	if inv_report.of_update_rpt_data(dw_1, ls_report_id) > 0 then
		lb_saved = TRUE
		ib_data_changed = false
		if ib_syntax_changed then
			if inv_report.of_update_rpt_syntax(dw_1, ls_report_id) > 0 then
				ib_syntax_changed = false
				cb_save.enabled = false
			else
				Return -1
			end if
		end if
	else
		Return -1
	end if
else
	if ib_syntax_changed then
		if inv_report.of_update_rpt_syntax(dw_1, ls_report_id) > 0 then
			lb_saved = TRUE
			ib_syntax_changed = false
			cb_save.enabled = false
		else
			Return -1
		end if
	end if
end if

//	Update CASE_CNTL
IF lb_saved THEN
	inv_report.idt_update = gnv_app.of_get_server_date_time()
	
	// Parse CaseId
	ls_case_id  = Trim( Left( inv_report.is_case_id, 10 ) )				
	ls_case_spl = Upper( Mid( inv_report.is_case_id, 11, 2 ) )
	ls_case_ver = Upper( Mid( inv_report.is_case_id, 13, 2 ) )
	gnv_sql.of_TrimData(ls_case_spl)
	gnv_sql.of_TrimData(ls_case_ver)
	
	// Update CASE_LINK
	UPDATE CASE_LINK
	SET link_date = :inv_report.idt_update
	WHERE case_id	= :ls_case_id
	AND	case_spl	= :ls_case_spl
	AND	case_ver	= :ls_case_ver
	AND	link_type= 'RPT'
	AND	link_key = :ls_report_id
	USING	Stars2ca;
	
	IF Stars2ca.of_check_status() <> 0 THEN
		Stars2ca.of_rollback()
		MessageBox(  "Update Error", "Error updating CASE_LINK:~n~r" + Stars2ca.sqlerrtext )
		Return -1
	END IF
	
	//	If not Case NONE then create log entry
	IF ls_case_id <> "NONE" THEN
		lnv_case = Create n_cst_case
		ls_msg = "Report " + is_link_name + " has been updated."
		li_rc = lnv_case.uf_audit_log( ls_case_id, ls_case_spl, ls_case_ver, ls_msg )
		Destroy lnv_case
		
		IF	li_rc		<	0		THEN
			Stars2ca.of_rollback()
			MessageBox ('Update Error', 'Could not insert case log entry for'	+	&
							'  Case: ' + inv_report.is_case_id + &
							"~n~rSQLError:" + Stars2ca.sqlerrtext )
			Return	-1
		END IF
	END IF
	
	//	Commit
	Stars2ca.of_commit()
END IF

Return 1
end event

event open;call super::open;//*******************************************************************
// 11-25-96 FNC Prob #173 STARS35 Call colors function
//*******************************************************************

This.Event ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
//fx_set_window_colors(w_dw_viewer)

end event

on w_dw_viewer.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_report_options=create cb_report_options
this.cb_calendar=create cb_calendar
this.st_count=create st_count
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_dw_ops=create st_dw_ops
this.dw_1=create dw_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_report_options
this.Control[iCurrent+3]=this.cb_calendar
this.Control[iCurrent+4]=this.st_count
this.Control[iCurrent+5]=this.ddlb_dw_ops
this.Control[iCurrent+6]=this.st_dw_ops
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_close
end on

on w_dw_viewer.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_report_options)
destroy(this.cb_calendar)
destroy(this.st_count)
destroy(this.ddlb_dw_ops)
destroy(this.st_dw_ops)
destroy(this.dw_1)
destroy(this.cb_close)
end on

event closequery;call super::closequery;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save

Integer	i

IF ib_data_changed OR ib_syntax_changed THEN
	i =  MessageBox( "Save Changes", "Changes have been made to the data." + &
								"~n~rDo you want to save the changes?", Exclamation!, YesNoCancel! )
	IF i = 1 THEN
		IF This.Event ue_save_report_changes() < 1 THEN Return 1
	END IF
	
	IF i = 3 THEN Return 1
	
END IF

Return 0
end event

type cb_save from u_cb within w_dw_viewer
string accessiblename = "Save"
string accessibledescription = "Save"
integer x = 2423
integer y = 1824
integer width = 302
integer height = 108
integer taborder = 40
integer textsize = -8
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Save"
end type

event clicked;call super::clicked;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
parent.event ue_save_report_changes()
end event

type cb_report_options from u_cb within w_dw_viewer
boolean visible = false
string accessiblename = "Report Options"
string accessibledescription = "Report Options"
integer x = 1993
integer y = 1824
integer width = 411
integer height = 108
integer taborder = 40
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "Report Options"
end type

event clicked;call super::clicked;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save

OpenWithParm( w_report_options,dw_1 )

//	Check if syntax has been modified
ib_syntax_changed = message.doubleparm = 1
SetNull( message.doubleparm )
cb_save.enabled = ib_syntax_changed
end event

type cb_calendar from u_cb within w_dw_viewer
boolean visible = false
string accessiblename = "Calendar"
string accessibledescription = "Calendar"
integer x = 1673
integer y = 1824
integer width = 302
integer height = 108
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "Calendar"
end type

event clicked;call super::clicked;OpenSheetwithParm(w_calendar,dw_1,MDI_main_frame,help_menu_position,Layered!)
end event

type st_count from statictext within w_dw_viewer
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 635
integer y = 1836
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 700
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

type ddlb_dw_ops from dropdownlistbox within w_dw_viewer
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 9
integer y = 1856
integer width = 590
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.

string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_count, in_decode_struct)
end event

type st_dw_ops from statictext within w_dw_viewer
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 9
integer y = 1788
integer width = 613
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_dw_viewer
string tag = "CRYSTAL"
string accessiblename = "Data"
string accessibledescription = "Data"
integer width = 3045
integer height = 1772
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;//commented by HRB per Pat-D 12/13/95 - please uncomment after 12/15/95
//DJP uncommented 4/2/96
////Script for w_dw_viewer doubleclicked for dw_1
////////////////////////////////////////////////////////////////////////
int tabpos,rc,lv_indx,lv_found
long lv_row_nbr
int lv_upper
string lv_hold_object,lv_col,lv_tbl_type
string lv_string_width,lv_hold_col_width,lv_col_name
boolean lv_lookup,lv_found_flag,lv_join

lv_join = FALSE

setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_1)
If lv_hold_object = '' then
	return
end if
tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
	else
		ddlb_dw_ops.triggerevent(selectionchanged!)  // MVR 3.6 01/13/97 Aded to match other routines
	End if      
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		lv_row_nbr = row
//		lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		lv_row_nbr = row
//		lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
End If
end event

on rowfocuschanged;int rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

in_row = getrow(dw_1)
If in_row = 0 then
	return
end if
  //Highlights the current row
rc = SelectRow(dw_1,0,FALSE)
rc = SelectRow(dw_1,in_row,TRUE)

end on

event itemerror;call super::itemerror;Return 2		//10/22/01	GaryR	Track 3635c	Error retrieving report that was saved with decoded columns
end event

event constructor;call super::constructor;//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
This.of_SetUpdateable( FALSE )
end event

event editchanged;call super::editchanged;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
if ib_data_changed = false then
	ib_data_changed = true
	cb_save.enabled = true
end if

end event

type cb_close from u_cb within w_dw_viewer
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2738
integer y = 1824
integer width = 302
integer height = 108
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean default = true
end type

on clicked;Close(Parent)
end on

