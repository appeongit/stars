$PBExportHeader$w_get_savedatawindow_name.srw
$PBExportComments$Inherited from w_master
forward
global type w_get_savedatawindow_name from w_master
end type
type sle_save_name from singlelineedit within w_get_savedatawindow_name
end type
type st_instructions from statictext within w_get_savedatawindow_name
end type
type cb_cancel from u_cb within w_get_savedatawindow_name
end type
type cb_ok from u_cb within w_get_savedatawindow_name
end type
end forward

global type w_get_savedatawindow_name from w_master
string accessiblename = "Get Saved Datawindow"
string accessibledescription = "Get Saved Datawindow"
accessiblerole accessiblerole = windowrole!
integer x = 667
integer y = 264
integer width = 1582
integer height = 756
windowtype windowtype = response!
long backcolor = 67108864
sle_save_name sle_save_name
st_instructions st_instructions
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_get_savedatawindow_name w_get_savedatawindow_name

type variables
String	parms
end variables

event open;call super::open;//***********************************************************************
// Reads Message.StringParm value and splits it at the tab characters
// into the following values:
//
//   1) Default value for the entry field
//   2) Window Title
//   3) Instructions for entry field
//
// Any values not found after the split are set to an empty string
//
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 11/17/93 JMS  Created
//***********************************************************************

String  parm[3]
Long    tab_pos
Integer parm_number

for parm_number = 1 to 3
    tab_pos = Pos(parms,'~t')
    if (tab_pos <> 0) then
       parm[parm_number] = Mid(parms,1,tab_pos - 1)
       parms             = Mid(parms,tab_pos   + 1)
    else
       parm[parm_number] = parms
       parms             = ''
    end if       
next

if (parm[1] <> '') then
   sle_save_name.text = parm[1]
   SelectText(sle_save_name,1,Len(sle_save_name.text))
end if
if (parm[2] <> '') then this.title           = parm[2]
if (parm[3] <> '') then st_instructions.text = parm[3]


end event

on w_get_savedatawindow_name.create
int iCurrent
call super::create
this.sle_save_name=create sle_save_name
this.st_instructions=create st_instructions
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_save_name
this.Control[iCurrent+2]=this.st_instructions
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
end on

on w_get_savedatawindow_name.destroy
call super::destroy
destroy(this.sle_save_name)
destroy(this.st_instructions)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event ue_preopen;call super::ue_preopen;
parms = Message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type sle_save_name from singlelineedit within w_get_savedatawindow_name
long backcolor = 1073741824
string accessiblename = "Name"
string accessibledescription = "Name"
accessiblerole accessiblerole = textrole!
integer x = 457
integer y = 248
integer width = 690
integer height = 88
integer taborder = 10
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_instructions from statictext within w_get_savedatawindow_name
string accessiblename = "Instructions"
string accessibledescription = "Instructions"
accessiblerole accessiblerole = statictextrole!
integer x = 155
integer y = 80
integer width = 1294
integer height = 84
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from u_cb within w_get_savedatawindow_name
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 901
integer y = 464
integer width = 338
integer height = 108
integer taborder = 30
integer textsize = -16
string text = "&Cancel"
end type

on clicked;CloseWithReturn(Parent,'')
end on

type cb_ok from u_cb within w_get_savedatawindow_name
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 343
integer y = 464
integer width = 338
integer height = 108
integer taborder = 20
integer textsize = -16
string text = "&OK"
boolean default = true
end type

on clicked;SetFocus(sle_save_name)
if (sle_save_name.text <> '') then CloseWithReturn(Parent,sle_save_name.text)

end on

