$PBExportHeader$u_cbx.sru
$PBExportComments$Ancestor checkbox <gui>
forward
global type u_cbx from checkbox
end type
end forward

global type u_cbx from checkbox
string accessiblename = "none "
string accessibledescription = "none"
accessiblerole accessiblerole = checkbuttonrole!
integer width = 457
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
event ue_dwnkey pbm_dwnkey
event rbuttonup pbm_rbuttonup
end type
global u_cbx u_cbx

forward prototypes
public function integer of_getparentwindow (ref window aw_window)
end prototypes

event ue_dwnkey;//*********************************************************************************
// Script Name:	ue_dwnkey event (pbm_dwnkey)
//
//	Arguments:		N/A
//
// Returns:			Long
//
//	Description:	This event will trigger when a key is pressed.  
//						When F12 is pressed, trigger the window event to open a 
//						right-mouse menu.  When Ctrl and the right-arrow key
//						is pressed, trigger the window event to display the 
//						next tabpage on a tab.  When Ctrl and the left-arrow key
//						is pressed, trigger the window event to display the previous
//						tabpage on a tab.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5.	Created
//
//*********************************************************************************
	
W_master	lw_parent
Integer		li_rc

IF  KeyDown (KeyF12!)  THEN
	li_rc  =  This.of_GetParentWindow (lw_parent)
	lw_parent.Post	Event  ue_open_rmm()
ELSE
	IF  KeyDown (KeyControl!)  THEN
		IF  KeyDown (KeyRightArrow!)  THEN
			li_rc  =  This.of_GetParentWindow (lw_parent)
			lw_parent.Post	Event  ue_next_tabpage()
		ELSE
			IF  KeyDown (KeyLeftArrow!)  THEN
				li_rc  =  This.of_GetParentWindow (lw_parent)
				lw_parent.Post	Event  ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

event rbuttonup;//*********************************************************************************
// Script Name:	RButtonUp event (pbm_rbuttonup)
//
//	Arguments:		N/A
//
// Returns:			Long
//
//	Description:	Open the RMM (if one exists).  Make sure this script returns 1 
//						to prevent the windows RMM from displaying.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5.	Created
//
//*********************************************************************************

w_master		lw_parent

Integer		li_rc

li_rc		=	This.of_GetParentWindow (lw_parent)

lw_parent.Post	Event	ue_open_rmm()

// Return 1 to prevent the Windows RMM from displaying
Return	1

end event

public function integer of_getparentwindow (ref window aw_window);//************************************************************************
//	Script:	u_cbx.of_getparentwindow
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

on u_cbx.create
end on

on u_cbx.destroy
end on

