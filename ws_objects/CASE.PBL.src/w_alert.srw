$PBExportHeader$w_alert.srw
$PBExportComments$Case alerts (Inherited from w_master)
forward
global type w_alert from w_master
end type
type cb_2 from u_cb within w_alert
end type
type cb_select from u_cb within w_alert
end type
type cb_1 from u_cb within w_alert
end type
type dw_1 from u_dw within w_alert
end type
end forward

global type w_alert from w_master
string accessiblename = "Case Alert"
string accessibledescription = "Case Alert"
accessiblerole accessiblerole = windowrole!
integer x = 709
integer y = 460
integer width = 1801
integer height = 1000
string title = "Case Alert"
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_select cb_select
cb_1 cb_1
dw_1 dw_1
end type
global w_alert w_alert

event open;call super::open;//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

String	ls_sql

ls_sql = Message.StringParm
SetNull( Message.StringParm )

dw_1.settransobject(stars2ca)

IF dw_1.SetSQLSelect( ls_sql ) = -1 THEN
	MessageBox('ERROR', 'GetSQLSelect Failed')
	Return
END IF

dw_1.Retrieve( )

If stars2ca.of_commit() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If
end event

on w_alert.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_select=create cb_select
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_alert.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_select)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from u_cb within w_alert
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1371
integer y = 736
integer width = 338
integer height = 108
integer taborder = 10
string text = "&Close"
end type

on clicked;close(w_alert)
end on

type cb_select from u_cb within w_alert
string accessiblename = "Select"
string accessibledescription = "Select"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 96
integer y = 736
integer width = 338
integer height = 108
integer taborder = 20
string text = "&Select"
boolean default = true
end type

event clicked;//  CLICKED EVENT ON CB_SELECT BUTTON FOR W_CASE_LIST
//NLG 8-31-99 ts2363c. Use parm to open w_case_maint
//////////////////////////////////////////////////////////////////

string lv_case_id, lv_case_spl, lv_case_ver

int row_nbr
SetMicroHelp(W_Main,'Opening the Case Screen with the selected Case.')

SetPointer(HourGlass!)

//  The active case for the w_case_maint window has already been placed in gv_case_active.
//  It was placed there in the last rowfocuschanged.

//OPENSHEET (w_case_maint,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
//setfocus(w_case_maint.sle_case_desc)
OpenSheetWithParm(w_case_maint,'L',MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)

close(parent)
end event

type cb_1 from u_cb within w_alert
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 795
integer y = 736
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Print"
end type

on clicked;dw_1.print()
cb_2.default = TRUE

end on

type dw_1 from u_dw within w_alert
string accessiblename = "Alert"
string accessibledescription = "Alert"
accessiblerole accessiblerole = clientrole!
integer x = 96
integer y = 60
integer width = 1614
integer height = 624
string dataobject = "d_alert"
boolean vscrollbar = true
end type

event rowfocuschanged;// 03-04-98 ajs 4.0 TS145-Globals
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

int row_nbr

//  This event will only function if the stop button has been clicked, 
//  or the end of the initial retrieve has been reached.
if gv_cancel_but_clicked Then

	setpointer(hourglass!)
	setmicrohelp(w_main,'Ready')
	row_nbr = getrow(dw_1)
	If row_nbr = 0 then
   	cb_select.enabled = false
		return
	end if
   //Highlights the current row
	SelectRow(dw_1,0,FALSE)
	SelectRow(dw_1,row_nbr,TRUE)
	gv_active_case  = dw_1.GetItemString( row_nbr, "lead_case_id" )
   SetFocus(parent)
end if
end event

on retrieveend;//  Set the switch to allow execution of the code in rowfocuschanged.
gv_cancel_but_clicked = TRUE
triggerevent(dw_1,rowfocuschanged!)
end on

on retrievestart;setpointer(hourglass!)
//  Reset "stop" switch at the start of the retrieve.
gv_cancel_but_clicked = FALSE

end on

