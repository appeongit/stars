﻿$PBExportHeader$u_tabpg.sru
$PBExportComments$PFC TabPage class <gui>
forward
global type u_tabpg from userobject
end type
end forward

global type u_tabpg from userobject
string accessiblename = "Tab Page User Object"
string accessibledescription = "Tab Page User Object"
accessiblerole accessiblerole = clientrole!
integer width = 1330
integer height = 740
long backcolor = 67108864
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
event resize pbm_size
event type integer ue_register_resize ( powerobject apo_control[] )
event rbuttonup pbm_rbuttonup
end type
global u_tabpg u_tabpg

type variables
Public:
n_cst_resize		inv_resize
end variables

forward prototypes
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_setresize (boolean ab_switch)
end prototypes

event resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services
//
//////////////////////////////////////////////////////////////////////////////

// Notify the resize service that the object size has changed.
If IsValid (inv_resize) Then
	inv_resize.Event pfc_Resize (sizetype, This.Width, This.Height)
End If
end event

event ue_register_resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_tabpg.ue_Register_Resize
//
//	Arguments:
//		apo_control[]   Array of controls to check for registering for resize
//
//	Returns:  integer
//	 1 = Successful, no errors found
//	-1 = An error was found
//
//	Description:	 
//		Register every control found in apo_control[] to the resize service
//		as "Scale".
//
//	Note:	 This event is called recursively to handle tab controls and user objects.
//////////////////////////////////////////////////////////////////////////////

Any			la_rc
Integer		li_max
Integer		li_i
Integer		li_rc
Integer		li_dwtype
DataWindow	ldw_dw
UserObject	luo_uo
tab			ltab_tab

//	If the resize service is not instantiated, get out.
IF	NOT IsValid (inv_resize)	THEN
	Return -1
END IF

// Get the number of objects
li_max = UpperBound (apo_control)

// Loop thru the objects
For li_i = 1 to li_max
	// Register the control
	This.inv_resize.of_Register (apo_control[li_i], 'Scale')

	// Tabs and user objects have controls within them
	Choose Case TypeOf ( apo_control[li_i] )

		Case Tab!
			// Test for Tab Controls (which contain TabPages which may contain controls)
			ltab_tab = apo_control[li_i]
			li_rc = This.Event ue_Register_Resize (ltab_tab.control) 
			If li_rc < 0 Then 
				Return -1
			END IF

		Case UserObject!
			// Test for UserObjects (which may contain controls)
			luo_uo = apo_control[li_i]
			li_rc = This.Event ue_Register_Resize (luo_uo.control) 
			If li_rc < 0 Then 
				Return -1
			END IF

	End Choose 
Next

// All Registration of Controls were successful
Return 1

end event

event rbuttonup;//*********************************************************************************
// Script Name:	u_tabpg.RButtonUp event
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

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetParentWindow
//
//	Access:  public
//
//	Arguments:
//	aw_parent   The Parent window for this object (passed by reference).
//	   If a parent window is not found, aw_parent is NULL
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	 Calculates the parent window of a window object
//
//////////////////////////////////////////////////////////////////////////////

powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

public function integer of_setresize (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetResize
//
//	Access:  public
//
//	Arguments:		
//	ab_switch   starts/stops the window resize service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//	Starts or stops the window resize service
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

// Check arguments
If IsNull (ab_switch) Then
	Return -1
End If

If ab_Switch Then
	If IsNull(inv_resize) Or Not IsValid (inv_resize) Then
		inv_resize = Create n_cst_resize
		inv_resize.of_SetOrigSize (This.Width, This.Height)
		This.Event	ue_register_resize (This.Control)
		li_rc = 1
	End If
Else
	If IsValid (inv_resize) Then
		Destroy inv_resize
		li_rc = 1
	End If
End If

Return li_rc

end function

on u_tabpg.create
end on

on u_tabpg.destroy
end on

