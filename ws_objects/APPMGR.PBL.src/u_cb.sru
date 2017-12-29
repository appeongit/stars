$PBExportHeader$u_cb.sru
$PBExportComments$Ancestor commandbutton - Place this user object instead of a commandbutton on a window. <gui>
forward
global type u_cb from commandbutton
end type
end forward

global type u_cb from commandbutton
string accessiblename = "none "
string accessibledescription = "none"
accessiblerole accessiblerole = pushbuttonrole!
integer width = 315
integer height = 92
integer taborder = 1
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string pointer = "Icon!"
string text = "none"
event documentation ( )
event ue_dwnkey pbm_keydown
end type
global u_cb u_cb

forward prototypes
public function integer of_getparentwindow (ref window aw_window)
public function uo_query of_getuoquery ()
end prototypes

event ue_dwnkey;//	u_cb::ue_dwnkey()
//	This event is of type pbm_dwnkey and will get triggered 
//	when a key is pressed.  When F12 is pressed, trigger the 
//	window event to open a right-mouse menu.  
//	When Ctrl and the right-arrow key is pressed, trigger the 
//	window event to display the next tabpage on a tab. 
//	When Ctrl and the left-arrow key is pressed, trigger the 
//	window event to display the previous tabpage on a tab.  
//
//	History:
//	08-09-99	NLG	created
//////////////////////////////////////////////////////////////////////
	
	
W_master	lw_parent
Integer		li_rc

IF  KeyDown (KeyF12!)  THEN
	Li_rc  =  This.of_GetParentWindow (lw_parent)
	Lw_parent.Post	Event  ue_open_rmm()
ELSE
	IF  KeyDown (KeyControl!)  THEN
		IF  KeyDown (KeyRightArrow!)  THEN
			Li_rc  =  This.of_GetParentWindow (lw_parent)
			Lw_parent.Post	Event  ue_next_tabpage()
		ELSE
			IF  KeyDown (KeyLeftArrow!)  THEN
				Li_rc  =  This.of_GetParentWindow (lw_parent)
				Lw_parent.Post	Event  ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

public function integer of_getparentwindow (ref window aw_window);//************************************************************************
//	Script:	u_cb.of_getparentwindow
//
//	Arguments:	aw_window (by reference) 
//
//	Returns:	Integer -	1 = ok
//								-1 = unsuccessful
//
//	Description:	Get the parent window of this object
//
//************************************************************************

PowerObject		lpo_parent

//	Loop getting the parent of the object until it is a window

lpo_parent	=	This.GetParent ()

DO WHILE lpo_parent.TypeOf ()	<>	Window!	AND	IsValid (lpo_parent)
	lpo_parent	=	lpo_parent.GetParent ()
LOOP

IF	NOT	IsValid (lpo_parent)		THEN
	SetNull (aw_window)
	Return -1
END IF

aw_window	=	lpo_parent

Return 1

end function

public function uo_query of_getuoquery ();//************************************************************************
//	Script:	u_cb.of_getuoquery
//
//	Arguments:	None
//
//	Returns:		uo_query 
//
//	Description:	Get the handle to uo_query for this object
//
//************************************************************************

PowerObject		lpo_parent
uo_query			luo_query
Tab				ltab

Boolean			lb_found	=	FALSE

//	Loop getting the parent of the object until it is a window

lpo_parent	=	This.GetParent ()

DO WHILE lb_found =	FALSE		AND	IsValid (lpo_parent)
	IF	lpo_parent.TypeOf ()				=	Tab!		THEN
		ltab									=	lpo_parent
		IF	Upper ( Trim (ltab.Tag) )	>	'  '		THEN
			lb_found	=	TRUE
			luo_query	=	lpo_parent
			Return	luo_query
			Exit
		END IF
	END IF
	lpo_parent	=	lpo_parent.GetParent ()
LOOP

SetNull (luo_query)

Return	luo_query


end function

event rbuttondown;//****************************************************************
//	Script:	u_cb.RButtonDown
//
//	Description:
//			If there a description in the tag value, display the
//			tag value in a MessageBox
//
//****************************************************************

IF	Trim (This.tag)	>	' '	THEN
	MessageBox ('About this CommandButton', This.Tag)
END IF

end event

on u_cb.create
end on

on u_cb.destroy
end on

