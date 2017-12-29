$PBExportHeader$w_import_errors.srw
$PBExportComments$Displays a list of Pattern import errors (inherited from w_master)
forward
global type w_import_errors from w_master
end type
type dw_errors from u_dw within w_import_errors
end type
type cb_ok from u_cb within w_import_errors
end type
type cb_print from u_cb within w_import_errors
end type
end forward

global type w_import_errors from w_master
string accessiblename = "Import Errors Window"
string accessibledescription = "Import Errors Window"
integer x = 14
integer y = 16
integer width = 3771
integer height = 1216
string title = "Import Errors"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_errors dw_errors
cb_ok cb_ok
cb_print cb_print
end type
global w_import_errors w_import_errors

on w_import_errors.create
int iCurrent
call super::create
this.dw_errors=create dw_errors
this.cb_ok=create cb_ok
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_errors
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_print
end on

on w_import_errors.destroy
call super::destroy
destroy(this.dw_errors)
destroy(this.cb_ok)
destroy(this.cb_print)
end on

event open;call super::open;//*********************************************************************************
// Script Name:	Open
//
//	Arguments:		N/A
//						
//
// Returns:			None
//
//	Description:	
//		This window receives a datastore as a parm.  Move the contents
//		of the datastore to the datawindow.
//
//*********************************************************************************
//	
// 09/17/99 FDG	Created
//
//*********************************************************************************

n_ds	lds_error

lds_error	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

dw_errors.object.data	=	lds_error.object.data

// Disable CloseQuery processing
ib_disableclosequery	=	TRUE

end event

type dw_errors from u_dw within w_import_errors
string tag = "COLORFIXED"
string accessiblename = "Import Errors Data"
string accessibledescription = "Import Errors Data"
integer x = 5
integer y = 24
integer width = 3735
integer height = 892
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_import_errors"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)
end event

type cb_ok from u_cb within w_import_errors
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 1581
integer y = 984
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;Close (Parent)

end event

type cb_print from u_cb within w_import_errors
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 2181
integer y = 984
integer taborder = 30
boolean bringtotop = true
string text = "&Print"
end type

event clicked;dw_errors.Print()

end event

