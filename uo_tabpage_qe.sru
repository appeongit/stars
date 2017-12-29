HA$PBExportHeader$uo_tabpage_qe.sru
$PBExportComments$Placed on each tabpage of uo_query to handle right-mouse menu. <gui>
forward
global type uo_tabpage_qe from u_tabpg
end type
end forward

global type uo_tabpage_qe from u_tabpg
string accessiblename = "Tab Page"
string accessibledescription = "Tab Page"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
event ue_dwnkey pbm_dwnkey
end type
global uo_tabpage_qe uo_tabpage_qe

forward prototypes
public function uo_query of_getuoquery ()
end prototypes

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

public function uo_query of_getuoquery ();//************************************************************************
//	Script:	uo_tabpage_qe.of_getuoquery
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
	IF	lpo_parent.TypeOf ()			=	Tab!		THEN
		ltab								=	lpo_parent
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

event rbuttonup;//************************************************************************
//	Script:	uo_tabpage_qe.rbuttonup
//
//	Description:	Trigger uo_query.ue_open_menu event.
//
//	Note: Whenever rbuttonup is used, always Return 1 to prevent the windows
//			Cut/Copy/Paste RMM from displaying
//
//************************************************************************

This.of_Getuoquery().Event	ue_open_menu()

Return 1




end event

on uo_tabpage_qe.create
call super::create
end on

on uo_tabpage_qe.destroy
call super::destroy
end on

