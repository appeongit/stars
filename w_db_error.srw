HA$PBExportHeader$w_db_error.srw
$PBExportComments$Database error window (inherited from w_master)
forward
global type w_db_error from w_master
end type
type dw_1 from u_dw within w_db_error
end type
type cb_close from u_cb within w_db_error
end type
type cb_print from u_cb within w_db_error
end type
end forward

global type w_db_error from w_master
long backcolor = 67108864
string accessiblename = "Database Error"
string accessibledescription = "Database Error"
accessiblerole accessiblerole = windowrole!
string tag = "This window will display the database error information."
integer x = 5
integer y = 4
integer width = 2254
integer height = 1800
string title = "Database Error"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
cb_close cb_close
cb_print cb_print
end type
global w_db_error w_db_error

event ue_print;call super::ue_print;dw_1.Print ()
end event

event open;call super::open;//************************************************************************
//	Script:	w_db_error.Open 
//
//	Description:	Get the transaction data and display it on the d/w.
//
//************************************************************************
//
//	05/17/01	GaryR	Stars 4.7	Display the App userid not the DB userid
//	07/03/01	GaryR	Stars 4.7	Check for a dead session.
// 06/12/02 JasonS Track 3125d  Change database error message
// 07/10/02 JasonS Track 3125d  Changed database error message to 
// 									'Please review the message below or contact your STARS System Administrator'
//										per updated track
//************************************************************************

Long				ll_row
str_db_error	lstr_db

lstr_db	=	Message.PowerObjectParm

//	07/03/01	GaryR	Stars 4.7
// Call a method on the server
// if the current session was destroyed
// the server is coded to handle this.
gnv_server.of_PreventTimeOut()

ll_row	=	dw_1.InsertRow (0)
dw_1.ScrollToRow (ll_row)

dw_1.object.sqlcode [ll_row]			=	lstr_db.trans.sqlcode
dw_1.object.sqldbcode [ll_row]		=	lstr_db.sqldbcode
dw_1.object.dbms [ll_row]				=	lstr_db.trans.dbms
dw_1.object.database [ll_row]			=	lstr_db.trans.database
//	05/17/01	GaryR	Stars 4.7 - Begin
//dw_1.object.logid [ll_row]				=	lstr_db.trans.logid
//dw_1.object.userid [ll_row]			=	lstr_db.trans.userid
dw_1.object.userid [ll_row]			=	gc_user_id
//	05/17/01	GaryR	Stars 4.7 - End
dw_1.object.dbparm [ll_row]			=	lstr_db.trans.dbparm
dw_1.object.servername [ll_row]		=	lstr_db.trans.servername
dw_1.object.sqlerrtext [ll_row]		=	lstr_db.sqlerrtext
dw_1.object.sqlreturndata [ll_row]	=	lstr_db.sqlreturndata
dw_1.object.row_num [ll_row]			=	lstr_db.row_num
dw_1.object.sqlsyntax [ll_row]		=	lstr_db.sqlsyntax
dw_1.object.window_name [ll_row]		=	lstr_db.window_name
dw_1.object.dataobject [ll_row]		=	lstr_db.dataobject

// Begin - Track 3125d
//IF	Trim (lstr_db.message)	>	' '	THEN
//	dw_1.object.error_message [ll_row] = lstr_db.message
//ELSE
//	dw_1.object.error_message [ll_row]	=	&
//									'A database error has occurred in STARS'
//END IF
//
// Begin - Track 3125d (7/11/02)
//	dw_1.object.error_message [ll_row] = &
//									'A processing exception has occurred.  Please review the User Message or contact your STARS SA'
	dw_1.object.error_message [ll_row] = &
									'Please review the message below or contact your STARS System Administrator'
// End - Track 3125d (7/11/02)									
									
//// End - Track 3125d

This.Title	=	This.of_get_title () + ' - STARS'

end event

event ue_security;// Override to do nothing

end event

on w_db_error.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
end on

on w_db_error.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_print)
end on

event ue_preopen;call super::ue_preopen;ib_disablecenter	=	TRUE
end event

event closequery;///////////////////////////////////////////////////////////////////////////
//
// Override this event in case this 
//	error occurred during retrieval 
//	and ib_lock in gnv_app is set to true
//
///////////////////////////////////////////////////////////////////////////
//
//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
//
///////////////////////////////////////////////////////////////////////////
end event

type dw_1 from u_dw within w_db_error
string accessiblename = "Database Error Datawindow"
string accessibledescription = "Database Error Datawindow"
accessiblerole accessiblerole = clientrole!
string tag = "COLORFIXED"
integer x = 9
integer width = 2226
integer height = 1592
integer taborder = 10
string dataobject = "d_db_error"
boolean vscrollbar = true
boolean livescroll = false
end type

type cb_close from u_cb within w_db_error
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
string tag = "Close this window"
integer x = 1157
integer y = 1604
integer taborder = 20
string text = "&OK"
end type

event clicked;call super::clicked;Close (Parent)
end event

type cb_print from u_cb within w_db_error
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
string tag = "Print the database error information"
integer x = 622
integer y = 1604
integer taborder = 2
string text = "&Print"
end type

event clicked;call super::clicked;dw_1.Print ()
end event

