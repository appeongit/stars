$PBExportHeader$w_rstr_details.srw
$PBExportComments$Restore request individual monthly CNTL rows (Inherited from w_master)
forward
global type w_rstr_details from w_master
end type
type st_count from statictext within w_rstr_details
end type
type dw_1 from u_dw within w_rstr_details
end type
type cb_close from u_cb within w_rstr_details
end type
type cb_restart from commandbutton within w_rstr_details
end type
end forward

global type w_rstr_details from w_master
string accessiblename = "Restore Request Details"
string accessibledescription = "Restore Request Details"
accessiblerole accessiblerole = windowrole!
integer x = 96
integer y = 120
integer width = 2569
integer height = 1316
string title = "Restore Request Details"
windowtype windowtype = child!
long backcolor = 67108864
st_count st_count
dw_1 dw_1
cb_close cb_close
cb_restart cb_restart
end type
global w_rstr_details w_rstr_details

type variables
// Message.Stringparm
String	is_parm

end variables

event open;call super::open;//*******************************************************************************
// History
//
// FNC		08/25/98		Track 1607. Select a row when the window opens so that
//								the user will be able to click on a restart row.
//*******************************************************************************

long	ll_row,	&
		ll_nbr_rows

setpointer(hourglass!) 
//fx_set_window_colors(w_rstr_details)
SetMicroHelp(W_Main,'Listing Restore Request Details')	

Reset(DW_1)

/*Connects to datawindow and retrieves number of rows*/

SetTransObject(DW_1,stars2ca)

ll_nbr_rows = Retrieve(dw_1,is_parm)

// FNC 08/25/98 Start
ll_row = dw_1.getrow()
selectrow(dw_1,ll_row,true)
setrow(dw_1,ll_row)
// FNC 08/25/98 False


st_count.text = string(ll_nbr_rows)

/*Checks to see if there is no data in the table*/
If ll_nbr_rows = 0 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	SetMicroHelp(w_main,'Ready')
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
	cb_close.postevent(clicked!)
	return
end if 

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

SetMicroHelp(w_main,'Ready')	


end event

on w_rstr_details.create
int iCurrent
call super::create
this.st_count=create st_count
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_restart=create cb_restart
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_count
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_restart
end on

on w_rstr_details.destroy
call super::destroy
destroy(this.st_count)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_restart)
end on

event ue_preopen;call super::ue_preopen;
//Find out the id 
if not isnull(message.stringparm) then
	is_parm=message.stringparm
//KMM Clear out message parm (PB Bug)
	SetNull(message.stringparm)
else
	setmicrohelp(w_main,'Ready')
	cb_close.postevent(clicked!)
end if

end event

type st_count from statictext within w_rstr_details
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 37
integer y = 1100
integer width = 261
integer height = 80
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

type dw_1 from u_dw within w_rstr_details
string accessiblename = "Restore Detail Data"
string accessibledescription = "Restore Detail Data"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Request Details"
integer x = 32
integer width = 2505
integer height = 1052
integer taborder = 10
string dataobject = "d_rstr_details"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//*******************************************************************************
// History
//
// FNC		08/25/98		Track 1607. Select the row that has focus. If user id is 
//								same as original user id and status	is error, enable the 
//								restart button
//
//*******************************************************************************

integer li_parent_row
w_rstr_maint_ptc lw_parent_window

// FNC 08/25/98 Start
selectrow(dw_1,0,false)
selectrow(dw_1,currentrow,true)
setrow(dw_1,currentrow)

cb_restart.enabled = FALSE

if currentrow > 0 then
	lw_parent_window = parent.parentwindow()
	li_parent_row = lw_parent_window.dw_rstr.getrow()

	if lw_parent_window.dw_rstr.Object.user_id[li_parent_row] = gc_user_id then
		if this.object.rstr_status[currentrow] = 'E' then
			cb_restart.enabled = TRUE
		end if
	end if
end if


// FNC 08/25/98 End
end event

type cb_close from u_cb within w_rstr_details
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2117
integer y = 1088
integer width = 338
integer height = 108
integer taborder = 20
string text = "&Close"
boolean default = true
end type

on clicked;//parent.PostEvent(Activate!)  // added to correct bleed thru bug
w_main.postevent('redraw')
close(w_rstr_details)

end on

type cb_restart from commandbutton within w_rstr_details
string accessiblename = "Restart"
string accessibledescription = "Restart"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1714
integer y = 1088
integer width = 338
integer height = 108
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
boolean enabled = false
string text = "&Restart"
end type

event clicked;//*********************************************************************************
// History
//
// FNC		08/25/98		Track 1607. Set status to P so that archive job will be 
//								restarted.
//
//*********************************************************************************

integer li_row

li_row = dw_1.getrow()

if li_row > 0 then
	dw_1.object.rstr_status[li_row] = 'P'
	dw_1.settransobject(stars2ca)
	dw_1.EVENT ue_update( TRUE, TRUE )
	commit using stars2ca;
end if


end event

