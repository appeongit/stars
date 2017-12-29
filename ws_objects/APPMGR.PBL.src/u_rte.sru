$PBExportHeader$u_rte.sru
$PBExportComments$Rich-text edit ancestor <gui>
forward
global type u_rte from richtextedit
end type
end forward

global type u_rte from richtextedit
string accessiblename = "Rich Text Edit User Object"
string accessibledescription = "Rich Text Edit User Object"
accessiblerole accessiblerole = textrole!
integer width = 494
integer height = 360
integer taborder = 10
borderstyle borderstyle = stylelowered!
event ue_dwnkey pbm_dwnkey
end type
global u_rte u_rte

forward prototypes
public function integer of_getparentwindow (ref window aw_window)
public function integer of_clear ()
end prototypes

public function integer of_getparentwindow (ref window aw_window);//************************************************************************
//	Script:	u_rte.of_getparentwindow
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

public function integer of_clear ();//*********************************************************************************
// Script Name:	u_rte.of_clear()
//
//	Arguments:		None
//						
//
// Returns:			Integer	1 = Success
//
//	Description:	The SelectTextAll function returns an integer which means 
//						that only 32K can be selected at a time.  This function clears
//						the selected text until the entire contents of the RTE is
//						clear.
//
//*********************************************************************************
//	
// 10/12/99 NG		Stars 4.5.	Created
//
//*********************************************************************************

int	li_rc

this.SelectTextAll()
this.clear()

return 1

end function

event rbuttonup;//*********************************************************************************
// Script Name:	RButtonUp event (pbm_renrbuttonup)
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

on u_rte.create
end on

on u_rte.destroy
end on

event constructor;//	10/29/08	GaryR	SPR 5522	PowerBuilder 11 New RTE Changes

This.TopMargin = 1000
This.BottomMargin = 1000
This.LeftMargin = 1000
This.RightMargin = 1000
end event

event key;//	u_rte::key
//	This event will get triggered when a key is pressed.  
//	When F12 is pressed, trigger the window event to open a right-mouse menu.  
//
//	History:
//	08-09-99	NLG	created
//	05/20/09	GaryR	GNL.600.5633.012	Provide keyboard alternative to RTE focus bug
//
//////////////////////////////////////////////////////////////////////

w_master	lw_parent

IF key = KeyF12!  THEN
	This.of_GetParentWindow (lw_parent)
	lw_parent.Post	Event  ue_open_rmm()
ELSEIF key = KeyF4! THEN
	//	Shift focus from the RTE
	This.of_GetParentWindow (lw_parent)
	lw_parent.SetFocus()
END IF
end event

