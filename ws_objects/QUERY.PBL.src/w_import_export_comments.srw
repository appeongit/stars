$PBExportHeader$w_import_export_comments.srw
$PBExportComments$Enter/display comments for importing/exporting
forward
global type w_import_export_comments from w_master
end type
type mle_1 from u_mle within w_import_export_comments
end type
type cb_ok from u_cb within w_import_export_comments
end type
type cb_print from u_cb within w_import_export_comments
end type
type st_heading from statictext within w_import_export_comments
end type
type cb_cancel from commandbutton within w_import_export_comments
end type
end forward

global type w_import_export_comments from w_master
string accessiblename = "Import Export Comments Window"
string accessibledescription = "Import Export Comments Window"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
int Width=2011
int Height=1012
WindowType WindowType=response!
boolean TitleBar=true
string Title="Import/Export Comments"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
mle_1 mle_1
cb_ok cb_ok
cb_print cb_print
st_heading st_heading
cb_cancel cb_cancel
end type
global w_import_export_comments w_import_export_comments

on w_import_export_comments.create
int iCurrent
call super::create
this.mle_1=create mle_1
this.cb_ok=create cb_ok
this.cb_print=create cb_print
this.st_heading=create st_heading
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.st_heading
this.Control[iCurrent+5]=this.cb_cancel
end on

on w_import_export_comments.destroy
call super::destroy
destroy(this.mle_1)
destroy(this.cb_ok)
destroy(this.cb_print)
destroy(this.st_heading)
destroy(this.cb_cancel)
end on

event open;call super::open;//*********************************************************************************
// Script Name:	Open	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	If a string was sent to this window, move it to mle_1.
//		
//
//*********************************************************************************
//	
// 10/13/99	FDG	Stars 4.5.	Created
//
//	01/21/00	FDG	Stars 4.5.	Remove the disabling of mle_1.  This will allow
//						a default comment to be sent to this window.
//
//*********************************************************************************

String	ls_message

ls_message	=	Message.StringParm
SetNull (Message.StringParm)

IF	Len (ls_message)	>	0		THEN
	// Display message from the import file
	mle_1.text			=	ls_message
//	mle_1.enabled		=	FALSE
//	st_heading.text	=	"Comments previously entered for this exported file"
//ELSE
//	// Window used for entering comments regarding the export.
//	st_heading.text	=	"Please enter comments regarding this export"
END IF



end event

type mle_1 from u_mle within w_import_export_comments
string accessiblename = "Import Export Comments Text"
string accessibledescription = "Import Export Comments Text"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
int X=41
int Y=92
int Width=1888
int Height=716
boolean BringToTop=true
boolean AutoVScroll=true
int Limit=255
long BackColor=1073741824
string FaceName="System"
end type

type cb_ok from u_cb within w_import_export_comments
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
int X=110
int Y=820
int TabOrder=20
boolean BringToTop=true
string Text="&OK"
boolean Default=true
end type

event clicked;CloseWithReturn (Parent, mle_1.text)

end event

type cb_print from u_cb within w_import_export_comments
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
int X=782
int Y=820
int TabOrder=30
boolean BringToTop=true
string Text="&Print"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_print.clicked	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Print the contents of the MLE.
//		
//
//*********************************************************************************
//	
// 10/13/99	FDG	Stars 4.5.	Created
//
//*********************************************************************************

Long	ll_Job

SetPointer (HourGlass!)

ll_Job	=	PrintOpen( )

mle_1.Print(ll_Job, 500,1000)

PrintClose(ll_Job)


end event

type st_heading from statictext within w_import_export_comments
string accessiblename = "Heading"
string accessibledescription = "Heading"
accessiblerole accessiblerole = statictextrole!
int X=41
int Y=8
int Width=1888
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Please enter comments regarding this export"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="System"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_import_export_comments
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
int X=1403
int Y=820
int Width=315
int Height=92
int TabOrder=40
boolean BringToTop=true
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="System"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn (Parent, 'CANCEL')
end event

