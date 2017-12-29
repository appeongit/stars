$PBExportHeader$w_help.srw
$PBExportComments$Help window
forward
global type w_help from w_master
end type
type rte_help from u_rte within w_help
end type
type cb_close from u_cb within w_help
end type
type cb_print from u_cb within w_help
end type
end forward

global type w_help from w_master
string accessiblename = "STARS Help"
string accessibledescription = "STARS Help"
integer x = 46
integer y = 64
integer width = 2798
integer height = 1284
string title = "STARS Help"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
rte_help rte_help
cb_close cb_close
cb_print cb_print
end type
global w_help w_help

type variables
// Help file name passed to this window
String		is_helpfile

end variables

on w_help.create
int iCurrent
call super::create
this.rte_help=create rte_help
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rte_help
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
end on

on w_help.destroy
call super::destroy
destroy(this.rte_help)
destroy(this.cb_close)
destroy(this.cb_print)
end on

event ue_preopen;call super::ue_preopen;// Get the help file name from the parm

is_helpfile		=	Message.StringParm
SetNull (Message.StringParm)

end event

event open;call super::open;/////////////////////////////////////////////////////////////////////////////
//
// Assign the helpfile name to the RTE control (include the file path)
//
/////////////////////////////////////////////////////////////////////////////
//
//	04/16/09	GaryR	GNL.600.5633.012	Section 508 Compliance
//
/////////////////////////////////////////////////////////////////////////////

String	ls_filename,		&
			ls_path

ls_path		=	ProfileString ( gnv_app.of_get_ini_file(), 'carrier', 'HelpPath', '')

IF	ls_path	=	''		THEN
	ls_path	=	gv_ini_path
END IF

//ajs 10-22-98 Add help files for track and case
//             Added the following code to make the application a little bit more
//             forgiving if the user leaves the '\' off the end of the HelpPath in STARS.ini
if right(ls_path,1) <> '\' then 
		ls_path = ls_path + '\'
end if

ls_filename	=	ls_path	+	is_helpfile

rte_help.InsertDocument (ls_filename, TRUE)

// FDG 03/16/00 - Make it display only which allows the user to scroll but
//	cannot change the text.
rte_help.DisplayOnly	=	TRUE
cb_close.SetFocus()
end event

type rte_help from u_rte within w_help
string accessiblename = "Help"
string accessibledescription = "Help"
integer width = 2779
integer height = 1088
boolean init_hscrollbar = true
boolean init_vscrollbar = true
end type

type cb_close from u_cb within w_help
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 1577
integer y = 1092
integer taborder = 10
string text = "&Close"
boolean cancel = true
boolean default = true
end type

event clicked;call super::clicked;Close (Parent)
end event

type cb_print from u_cb within w_help
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 498
integer y = 1092
integer taborder = 2
string text = "&Print"
end type

event clicked;call super::clicked;Integer	li_rc

li_rc	=	rte_help.Print(1, '', TRUE, TRUE)

end event

