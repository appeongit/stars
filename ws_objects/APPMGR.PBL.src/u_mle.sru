$PBExportHeader$u_mle.sru
$PBExportComments$ancestor multiline-edit <gui>
forward
global type u_mle from multilineedit
end type
end forward

global type u_mle from multilineedit
string accessiblename = "Multi Line Edit User Object"
string accessibledescription = "Multi Line Edit User Object"
long backcolor = 1073741824
accessiblerole accessiblerole = textrole!
integer width = 494
integer height = 360
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
event ue_dwnkey pbm_dwnkey
event rbuttonup pbm_rbuttonup
end type
global u_mle u_mle

forward prototypes
public function integer of_getparentwindow (ref window aw_window)
end prototypes

event ue_dwnkey;//	u_mle::ue_dwnkey()
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
//	Script:	u_mle.of_getparentwindow
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

on u_mle.create
end on

on u_mle.destroy
end on

