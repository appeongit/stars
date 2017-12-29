HA$PBExportHeader$w_change_password.srw
$PBExportComments$Change the user's password (Inherited from w_master)
forward
global type w_change_password from w_master
end type
type sle_user_id from singlelineedit within w_change_password
end type
type st_user_id from statictext within w_change_password
end type
type sle_confirm_new_pswd from singlelineedit within w_change_password
end type
type sle_new_pswd from singlelineedit within w_change_password
end type
type cb_close from u_cb within w_change_password
end type
type cb_update from u_cb within w_change_password
end type
type sle_current_pswd from singlelineedit within w_change_password
end type
type st_confirm_new_pswd from statictext within w_change_password
end type
type st_new_pswd from statictext within w_change_password
end type
type st_current_pswd from statictext within w_change_password
end type
type gb_1 from groupbox within w_change_password
end type
end forward

global type w_change_password from w_master
string accessiblename = "Change Password Window"
string accessibledescription = "Change Password"
accessiblerole accessiblerole = windowrole!
integer x = 672
integer y = 264
integer width = 1440
integer height = 788
string title = "Change Password"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
sle_user_id sle_user_id
st_user_id st_user_id
sle_confirm_new_pswd sle_confirm_new_pswd
sle_new_pswd sle_new_pswd
cb_close cb_close
cb_update cb_update
sle_current_pswd sle_current_pswd
st_confirm_new_pswd st_confirm_new_pswd
st_new_pswd st_new_pswd
st_current_pswd st_current_pswd
gb_1 gb_1
end type
global w_change_password w_change_password

type variables
Boolean	ib_signon		//	GaryR	11/05/01	Stars 5.0	Redesign password expiration at logon.
end variables

event open;call super::open;////////////////////////////////////////////////////////////////////////////////
//
//	GaryR	11/05/01	Stars 5.0	Redesign password expiration at logon.
//
////////////////////////////////////////////////////////////////////////////////

String	ls_user_id

ls_user_id = Message.StringParm
SetNull( Message.StringParm )

IF IsNull( ls_user_id ) OR Trim( ls_user_id ) = "" THEN
	sle_user_id.text = gc_user_id
ELSE
	ib_signon = TRUE
	sle_user_id.text = ls_user_id
END IF
end event

on w_change_password.create
int iCurrent
call super::create
this.sle_user_id=create sle_user_id
this.st_user_id=create st_user_id
this.sle_confirm_new_pswd=create sle_confirm_new_pswd
this.sle_new_pswd=create sle_new_pswd
this.cb_close=create cb_close
this.cb_update=create cb_update
this.sle_current_pswd=create sle_current_pswd
this.st_confirm_new_pswd=create st_confirm_new_pswd
this.st_new_pswd=create st_new_pswd
this.st_current_pswd=create st_current_pswd
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_user_id
this.Control[iCurrent+2]=this.st_user_id
this.Control[iCurrent+3]=this.sle_confirm_new_pswd
this.Control[iCurrent+4]=this.sle_new_pswd
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.sle_current_pswd
this.Control[iCurrent+8]=this.st_confirm_new_pswd
this.Control[iCurrent+9]=this.st_new_pswd
this.Control[iCurrent+10]=this.st_current_pswd
this.Control[iCurrent+11]=this.gb_1
end on

on w_change_password.destroy
call super::destroy
destroy(this.sle_user_id)
destroy(this.st_user_id)
destroy(this.sle_confirm_new_pswd)
destroy(this.sle_new_pswd)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.sle_current_pswd)
destroy(this.st_confirm_new_pswd)
destroy(this.st_new_pswd)
destroy(this.st_current_pswd)
destroy(this.gb_1)
end on

type sle_user_id from singlelineedit within w_change_password
string accessiblename = "User ID"
string accessibledescription = "User ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 791
integer y = 68
integer width = 558
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_user_id from statictext within w_change_password
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 76
integer width = 699
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "User ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_confirm_new_pswd from singlelineedit within w_change_password
string accessiblename = "Confirm New Password"
string accessibledescription = "Confirm New Password"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 791
integer y = 404
integer width = 558
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;this.SelectText(1,Len(this.text))
SetMicroHelp('Enter your NEW password again to confirm the change')
end on

type sle_new_pswd from singlelineedit within w_change_password
string accessiblename = "New Password"
string accessibledescription = "New Password"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 791
integer y = 292
integer width = 558
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;this.SelectText(1,Len(this.text))
SetMicroHelp('Enter your NEW password')
end on

type cb_close from u_cb within w_change_password
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1061
integer y = 568
integer width = 338
integer height = 108
integer taborder = 50
string text = "&Cancel"
boolean cancel = true
end type

on getfocus;SetMicroHelp('Close password update window')
end on

on clicked;Close(Parent)
end on

type cb_update from u_cb within w_change_password
string accessiblename = "Change"
string accessibledescription = "Change"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 37
integer y = 568
integer width = 338
integer height = 108
integer taborder = 40
string text = "Chan&ge"
boolean default = true
end type

event clicked;// FDG	03/28/01	Stars 4.7.	Call Stars Server method to update the password.  
//						The password is not maintained in the users table.
//	GaryR	11/05/01	Stars 5.0	Redesign password expiration at logon.

String	ls_current_pswd,		&
			ls_message

Long		ll_rc

SetPointer(HourGlass!)

sle_current_pswd.text		= Trim ( sle_current_pswd.text )
sle_new_pswd.text				= Trim ( sle_new_pswd.text )
sle_confirm_new_pswd.text	= Trim ( sle_confirm_new_pswd.text )

if (sle_current_pswd.text = '') then
   MessageBox('Set PassWord','You MUST enter your CURRENT password.',StopSign!)
   SetFocus(sle_current_pswd)
   return
end if

if (sle_new_pswd.text = '') then
   MessageBox('Set PassWord','You MUST enter a NEW password.',StopSign!)
   SetFocus(sle_new_pswd)
   return
end if

if (sle_new_pswd.text <> sle_confirm_new_pswd.text) then
   MessageBox('Set PassWord','NEW password and CONFIRM NEW password do NOT match.',StopSign!)
   SetFocus(sle_confirm_new_pswd)
   return
end if

// FDG 03/28/01 - Password is not maintained in the users table
//SELECT user_pw 
//  INTO :ls_current_pswd
//  FROM USERS
//  WHERE user_id = :sle_user_id.text
//  Using Stars2CA;
//if (Stars2CA.of_check_status() <> 0) then
//   ErrorBox(Stars2CA,'Could NOT read current password from database.')
//   return 
//end if
//Stars2ca.of_commit()

ls_current_pswd	=	gnv_app.of_get_server_password()
// FDG 03/28/01 end

if (ls_current_pswd <> sle_current_pswd.text) then
   MessageBox('Set Password','The CURRENT password specified does NOT match your current signon password.',StopSign!)
   SetFocus(sle_current_pswd)
   return
end if
        
// FDG 03/28/01 - Password is not maintained in the users table

//UPDATE USERS
//  SET   user_pw = :sle_new_pswd.text
//  WHERE user_id = :sle_user_id.text
//  Using Stars2CA;
//if (Stars2CA.of_check_status() <> 0) then
//   ErrorBox(Stars2CA,'Could NOT update database with NEW password.')
//   return
//end if

//	GaryR	11/05/01	Stars 5.0 - Begin
if (sle_new_pswd.text = sle_current_pswd.text) then
   MessageBox('Set Password','Current password and new password can not be same.',StopSign!)
   SetFocus(sle_confirm_new_pswd)
   return
end if

IF ib_signon THEN
	gnv_app.of_set_new_password (sle_new_pswd.text)
	ll_rc = gnv_app.of_logon_and_change_password()
ELSE
	ll_rc	=	gnv_server.of_ChangePassword (sle_current_pswd.text, sle_new_pswd.text)
END IF
//	GaryR	11/05/01	Stars 5.0 - End	
	
	//Stars2ca.of_commit()
	
IF	ll_rc	<	0		THEN
	SetMicroHelp('Your signon password has not been changed.')
	Return
END IF

// Change the current password in gnv_app
gnv_app.of_set_server_password (sle_new_pswd.text)

ls_message	=	'Your signon password has been successfully changed.'	

w_main.SetMicroHelp(ls_message)

MessageBox ('Password Change', ls_message)

// FDG 03/28/01 end

SetPointer(Arrow!)

//	GaryR	11/05/01	Stars 5.0
//cb_close.TriggerEvent (Clicked!)			// FDG 03/28/01 - close the window
CloseWithReturn( Parent, 1 )
end event

event getfocus;SetMicroHelp('Change signon password')
end event

type sle_current_pswd from singlelineedit within w_change_password
string accessiblename = "Current Password"
string accessibledescription = "Current Password"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 791
integer y = 180
integer width = 558
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;this.SelectText(1,Len(this.text))
SetMicroHelp('Enter your CURRENT password')
end on

type st_confirm_new_pswd from statictext within w_change_password
string accessiblename = "Confirm New Password"
string accessibledescription = "Confirm New Password"
accessiblerole accessiblerole = statictextrole!
integer x = 46
integer y = 412
integer width = 718
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Confirm New Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_new_pswd from statictext within w_change_password
string accessiblename = "New Password"
string accessibledescription = "New Password"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 300
integer width = 699
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "New Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_current_pswd from statictext within w_change_password
string accessiblename = "Current Password"
string accessibledescription = "Current Password"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 188
integer width = 699
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Current Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_change_password
string accessiblename = "Change Password Fields"
string accessibledescription = "Change Password Fields"
accessiblerole accessiblerole = groupingrole!
integer x = 37
integer width = 1362
integer height = 540
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

