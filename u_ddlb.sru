HA$PBExportHeader$u_ddlb.sru
$PBExportComments$Ancestor DDLB <gui>
forward
global type u_ddlb from dropdownlistbox
end type
end forward

global type u_ddlb from dropdownlistbox
string accessiblename = "Drop Down List Box User Object"
string accessibledescription = "Drop Down List Box User Object"
accessiblerole accessiblerole = comboboxrole!
int Width=791
int Height=244
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=1073741824
int TextSize=-10
int Weight=400
string FaceName="Terminal"
FontCharSet FontCharSet=Oem!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
event ue_dwnkey pbm_dwnkey
event rbuttonup pbm_rbuttonup
end type
global u_ddlb u_ddlb

forward prototypes
public function integer of_getparentwindow (ref window aw_window)
public function uo_query of_getuoquery ()
end prototypes

event ue_dwnkey;//*********************************************************************************
// Script Name:	u_ddlb.ue_dwnkey event (pbm_dwnkey)
//
//	Arguments:		N/A
//
// Returns:			Long
//
//	Description:	
//	This event is of type pbm_dwnkey and will get triggered 
//	when a key is pressed.  When F12 is pressed, trigger the 
//	window event to open a right-mouse menu.  
//	When Ctrl and the right-arrow key is pressed, trigger the 
//	window event to display the next tabpage on a tab. 
//	When Ctrl and the left-arrow key is pressed, trigger the 
//	window event to display the previous tabpage on a tab.  
//
//*********************************************************************************
//	
// 08/09/99 NLG	Stars 4.5.	Created
//
//*********************************************************************************

	
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
//	Script:	u_ddlb.of_getparentwindow
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
//	Script:		u_ddlb.of_getuoquery
//
//	Arguments:	None
//
//	Returns:		uo_query 
//
//	Description:	This function will return the "handle" to uo_query.  
//						This function will only be called when this object is 
//						placed on a tab within uo_query. 
//
//************************************************************************

PowerObject		lpo_parent
uo_query			luo_query
Tab				ltab

Boolean			lb_found	=	FALSE

//	Loop getting the parent of the object until it is a window

lpo_parent	=	This.GetParent ()

DO WHILE lb_found =	FALSE		AND	IsValid (lpo_parent)
	IF	lpo_parent.TypeOf ()			=	Tab!		THEN
		ltab			=	lpo_parent
		IF	Trim (ltab.Tag)	>	' '				THEN
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

on u_ddlb.destroy
end on

