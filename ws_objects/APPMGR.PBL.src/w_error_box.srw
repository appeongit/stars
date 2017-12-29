$PBExportHeader$w_error_box.srw
$PBExportComments$Non Modal Messagebox (inherited from w_master)
forward
global type w_error_box from w_master
end type
type cb_print from u_cb within w_error_box
end type
type mle_msg from multilineedit within w_error_box
end type
type cb_ok from u_cb within w_error_box
end type
end forward

global type w_error_box from w_master
string accessiblename = "Error Dialog Box"
string accessibledescription = "Error Dialog Box"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
int X=677
int Y=269
int Width=1825
int Height=1081
WindowType WindowType=popup!
cb_print cb_print
mle_msg mle_msg
cb_ok cb_ok
end type
global w_error_box w_error_box

on w_error_box.create
int iCurrent
call w_master::create
this.cb_print=create cb_print
this.mle_msg=create mle_msg
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_print
this.Control[iCurrent+2]=mle_msg
this.Control[iCurrent+3]=cb_ok
end on

on w_error_box.destroy
call w_master::destroy
destroy(this.cb_print)
destroy(this.mle_msg)
destroy(this.cb_ok)
end on

type cb_print from u_cb within w_error_box
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
int X=883
int Y=853
int Width=247
int Height=89
int TabOrder=30
string Text="&Print"
int TextSize=-9
string FaceName="Arial"
end type

on clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_error_box.cb_print
//
// Purpose:  Print error message displayed in the multi line edit.
// 		
// Log:
// 
// DATE		NAME			REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation INITIAL VERSION
//
/////////////////////////////////////////////////////////////////////////

int li_job

li_job = printopen()

setpointer ( hourglass! )

print(li_job, mle_msg.text)
printclose(li_job)
end on

type mle_msg from multilineedit within w_error_box
string accessiblename = "Error Message"
string accessibledescription = "Error Message"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
int X=55
int Y=65
int Width=1683
int Height=757
int TabOrder=10
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=1073741824
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from u_cb within w_error_box
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
int X=590
int Y=853
int Width=247
int Height=89
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
string FaceName="Arial"
end type

event clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_error_box.cb_ok
//
//
/////////////////////////////////////////////////////////////////////////

close(parent)
end event

