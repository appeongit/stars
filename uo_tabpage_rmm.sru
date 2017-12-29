HA$PBExportHeader$uo_tabpage_rmm.sru
$PBExportComments$Placed on each tabpage to provide RMM functionality <gui>
forward
global type uo_tabpage_rmm from u_tabpg
end type
end forward

global type uo_tabpage_rmm from u_tabpg
string accessiblename = "Tab Page Right Mouse Menu User Object"
string accessibledescription = "Tab Page Right Mouse Menu User Object"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
event ue_dwnkey pbm_dwnkey
end type
global uo_tabpage_rmm uo_tabpage_rmm

event ue_dwnkey;//*********************************************************************************
// Script Name:	uo_tabpage_rmm ue_dwnkey
//
//	Arguments:		none
//						
//
// Returns:			none
//
//	Description:	display right mouse menu
//		
//
//*********************************************************************************
//	
// 10/22/99 AJS	Created
//
//	Note: Whenever rbuttonup is used, always Return 1 to prevent the windows
//			Cut/Copy/Paste RMM from displaying
//
//*********************************************************************************

w_master	lw_parent
Integer		li_rc

IF	KeyDown (KeyF12!)		THEN
	li_rc = This.of_GetParentWindow(lw_parent)
	lw_parent.Event Dynamic ue_open_rmm()
END IF
Return 1
end event

on uo_tabpage_rmm.create
call super::create
end on

on uo_tabpage_rmm.destroy
call super::destroy
end on

event rbuttonup;//*********************************************************************************
// Script Name:	rbuttonup
//
//	Arguments:		none
//						
//
// Returns:			none
//
//	Description:	display right mouse menu
//		
//
//*********************************************************************************
//	
// 10/22/99 AJS	Created
//
//	Note: Whenever rbuttonup is used, always Return 1 to prevent the windows
//			Cut/Copy/Paste RMM from displaying
//
//*********************************************************************************

w_master	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event Dynamic ue_open_rmm()
Return 1

end event

