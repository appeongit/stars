$PBExportHeader$w_debug_box.srw
$PBExportComments$Allows the displaying of debugging messages (Inherited from w_error_box)
forward
global type w_debug_box from w_error_box
end type
type cb_copy from u_cb within w_debug_box
end type
end forward

global type w_debug_box from w_error_box
string accessiblename = "Database Error Debug Window"
string accessibledescription = "Database Error Debug Window"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
int X=156
int Y=385
int Width=2593
int Height=1149
WindowType WindowType=main!
boolean TitleBar=true
string Title=""
cb_copy cb_copy
end type
global w_debug_box w_debug_box

on w_debug_box.create
int iCurrent
call w_error_box::create
this.cb_copy=create cb_copy
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_copy
end on

on w_debug_box.destroy
call w_error_box::destroy
destroy(this.cb_copy)
end on

type cb_print from w_error_box`cb_print within w_debug_box
int X=915
int Y=861
int Width=275
int Height=101
int TextSize=-10
string FaceName="System"
end type

type mle_msg from w_error_box`mle_msg within w_debug_box
int X=1
int Y=61
int Width=2583
int Height=761
end type

type cb_ok from w_error_box`cb_ok within w_debug_box
int X=503
int Y=861
int Width=275
int Height=101
int TextSize=-10
string FaceName="System"
end type

type cb_copy from u_cb within w_debug_box
string accessiblename = "Copy"
string accessibledescription = "Copy"
accessiblerole accessiblerole = pushbuttonrole!
int X=1303
int Y=861
int Width=650
int Height=101
int TabOrder=40
string Text="&Copy To Clipboard"
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;mle_msg.Copy()
end on

