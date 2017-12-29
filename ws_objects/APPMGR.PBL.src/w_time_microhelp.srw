$PBExportHeader$w_time_microhelp.srw
$PBExportComments$Inherited from w_master
forward
global type w_time_microhelp from w_master
end type
type sle_active_invoice from singlelineedit within w_time_microhelp
end type
type sle_datetime from singlelineedit within w_time_microhelp
end type
type p_user_messages from picture within w_time_microhelp
end type
type st_user_messages from statictext within w_time_microhelp
end type
end forward

global type w_time_microhelp from w_master
string accessiblename = "Microhelp Window"
string accessibledescription = "Microhelp Window"
accessiblerole accessiblerole = windowrole!
integer x = 672
integer y = 264
integer width = 1943
integer height = 84
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = popup!
long backcolor = 67108864
sle_active_invoice sle_active_invoice
sle_datetime sle_datetime
p_user_messages p_user_messages
st_user_messages st_user_messages
end type
global w_time_microhelp w_time_microhelp

type variables

end variables

event open;//	Override the ancestor

String	ls_temp
Integer	li_border = 30

this.visible = FALSE

timer(30)
this.postevent(timer!)
end event

event timer;sle_datetime.text = string(today(),'MM/DD/YYYY') + " " + string(now(),"hh:mm AM/PM")
If gv_active_invoice <> '' Then
	sle_active_invoice.text = 'Active Invoice: ' + gv_active_invoice
End If
end event

on w_time_microhelp.create
int iCurrent
call super::create
this.sle_active_invoice=create sle_active_invoice
this.sle_datetime=create sle_datetime
this.p_user_messages=create p_user_messages
this.st_user_messages=create st_user_messages
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_active_invoice
this.Control[iCurrent+2]=this.sle_datetime
this.Control[iCurrent+3]=this.p_user_messages
this.Control[iCurrent+4]=this.st_user_messages
end on

on w_time_microhelp.destroy
call super::destroy
destroy(this.sle_active_invoice)
destroy(this.sle_datetime)
destroy(this.p_user_messages)
destroy(this.st_user_messages)
end on

type sle_active_invoice from singlelineedit within w_time_microhelp
string accessiblename = "Active Invoice"
string accessibledescription = "Active Invoice"
accessiblerole accessiblerole = textrole!
integer x = 1449
integer y = 4
integer width = 485
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type sle_datetime from singlelineedit within w_time_microhelp
string accessiblename = "Date Time"
string accessibledescription = "Date Time"
accessiblerole accessiblerole = textrole!
integer x = 887
integer y = 4
integer width = 553
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type p_user_messages from picture within w_time_microhelp
boolean visible = false
string accessibledescription = "User Messages"
string accessiblename = "User Messages"
accessiblerole accessiblerole = graphicrole!
integer x = 18
integer y = 4
integer width = 87
integer height = 72
boolean bringtotop = true
boolean enabled = false
string picturename = "exclamation.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;//*********************************************************************
//	Script:	w_time_microhelp.p_user_messages.clicked
//
//	Description: Open w_user_message_list
// 
//*********************************************************************
//	History
//
//	FDG	04/20/00	Open w_user_message_list.
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//
//*********************************************************************

//	GaryR	09/05/01	Stars 4.8
//OpenSheetWithParm (w_user_message_list, gc_user_id, mdi_main_frame, help_menu_position, Layered!)
OpenSheetWithParm( w_user_message_list, 1, mdi_main_frame, help_menu_position, Layered! )

end event

type st_user_messages from statictext within w_time_microhelp
string accessiblename = "No new messages"
string accessibledescription = "No new messages"
accessiblerole accessiblerole = statictextrole!
integer x = 119
integer y = 4
integer width = 759
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No new messages"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;//	09/05/01	GaryR	Stars 4.8	WIC #6 FS50-001	Case Reassignment
IF p_user_messages.Visible THEN p_user_messages.Event Clicked()
end event

