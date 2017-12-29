HA$PBExportHeader$u_sle.sru
$PBExportComments$Single-line edit ancestor <gui>
forward
global type u_sle from singlelineedit
end type
end forward

global type u_sle from singlelineedit
string accessiblename = "Single Line Edit User Object"
string accessibledescription = "Single Line Edit User Object"
accessiblerole accessiblerole = textrole!
integer width = 603
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
event rbuttonup pbm_rbuttonup
event ue_lookup ( )
end type
global u_sle u_sle

forward prototypes
public function integer of_getparentwindow (ref window aw_window)
end prototypes

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

event ue_lookup();//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Use this event to script the lookup logic for this control
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************
end event

public function integer of_getparentwindow (ref window aw_window);//************************************************************************
//	Script:	u_sle.of_getparentwindow
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

on u_sle.destroy
end on

event rbuttondown;//*********************************************************************************
// Script Name:	<script name>
//
// Returns:		Long
//
// Description:	For lookup fields execute specific event
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Upper( This.Tag ) = "LOOKUP" THEN This.Post Event ue_lookup()
end event

on u_sle.create
end on

event getfocus;//*********************************************************************************
// Script Name:	GetFocus
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Set microhelp
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Upper( This.Tag ) = "LOOKUP" THEN
	w_main.SetMicroHelp( "Press the Right Mouse Button or F2 Key to perform a lookup")
END IF
end event

event losefocus;//*********************************************************************************
// Script Name:	LoseFocus
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Reset microhelp
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Upper( This.Tag ) = "LOOKUP" THEN
	w_main.SetMicroHelp( "Ready")
END IF
end event

event constructor;//	10/20/09	GaryR	ACC.650.5786.001	Provide alternative color scheme
//													for lookup and indexed fields

IF Upper( This.Tag ) = "LOOKUP" THEN
	This.backcolor = stars_colors.lookup_back
	This.textcolor = stars_colors.lookup_text
END IF
end event

