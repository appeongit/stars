$PBExportHeader$n_cst_menu.sru
$PBExportComments$PFC Menu service (inherited from n_base) <logic>
forward
global type n_cst_menu from n_base
end type
end forward

global type n_cst_menu from n_base autoinstantiate
end type
global n_cst_menu n_cst_menu

forward prototypes
protected function boolean of_IsInArray (integer ai_barindexarray[], integer ai_barindex)
public function integer of_getmdiframe (menu am_source, ref window aw_frame)
public function integer of_getalltoolbarindex (menu am_source, ref integer ai_barindex[])
public function boolean of_toolbarexists (menu am_source)
public function integer of_triggerevent (menu am_source, string as_event)
end prototypes

protected function boolean of_IsInArray (integer ai_barindexarray[], integer ai_barindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsInArray
//
//	Access:  		protected
//
//	Arguments:		
//	ai_barindexarray[]	Array on which to test.
//	ai_barindex				Index that needs to be searched for on the array.
//
//	Returns:  		boolean
//						True if the entry is already in the array.
//						False if the entry is not in the array.
//
//	Description:  	Determine if the new ToolbarItemBarIndex is already in the
//						array.
//
//////////////////////////////////////////////////////////////////////////////

integer li
integer li_arraysize

li_arraysize = UpperBound(ai_barindexarray[])

For li = 1 to li_arraysize
	If ai_barindex = ai_barindexarray[li] Then
		Return True
	End If
Next

Return False

end function

public function integer of_getmdiframe (menu am_source, ref window aw_frame);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetMDIFrame
//
//	Access:  		public
//
//	Arguments:		none
//	am_source		The menu for which to find the MDI frame
//	aw_frame			The frame window found (if any) passed by reference.
//						Returns a NULL value if the MDI frame window could not be
//						obtained.
//
//	Returns:  		Integer.
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Returns the MDI frame window (if any).
//
//////////////////////////////////////////////////////////////////////////////

window	lw_obj
boolean	lb_foundframe=False

//Check arguments
If Not IsValid(am_source) or IsNull(am_source) Then
	SetNull (aw_frame)
	Return -1
End If

//Get the window that owns the Menu object.
lw_obj = am_source.ParentWindow

//Search until no more windows or a MDI type window is found.
Do While IsValid (lw_obj)
	If lw_obj.windowtype = mdi! or lw_obj.windowtype = mdihelp! Then
		//Found a MDI Frame
		lb_foundframe = true
		Exit
	Else
		//Look in the window's parent (if any)
		lw_obj = lw_obj.ParentWindow()
	End if
Loop

If Not lb_foundframe Then
	//MDI Frame was not found
	SetNull (aw_frame)
	Return -1
End If

//MDI Frame was found
aw_frame = lw_obj
Return 1

end function

public function integer of_getalltoolbarindex (menu am_source, ref integer ai_barindex[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetAllToolbarIndex
//
//	Access:  		public
//
//	Arguments:		
//	am_source			The menu that should be searched.
//	ai_barindex[]	Array to hold all unique ToolbarItemBarIndex found.
//
//	Returns:  		integer
//						The size of the array holding the unique entries found.
//						-1 if an error occurs.
//
//	Description:  	Returns an array holding all unique ToolbarItemBarIndex
//						found.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_limit
integer	li_cnt
integer	li_toolbaritembarindex
boolean	lb_found

//Check arguments
If Not IsValid(am_source) or IsNull(am_source) Then
	Return -1
End If

//Hold in array those ToolbarItemBarIndex that have not been previously
//stored.
if Len (am_source.toolbaritemname) > 0 then
	If Not of_IsInArray(ai_barindex, am_source.ToolbarItemBarIndex) Then
		ai_barindex[UpperBound(ai_barindex)+1] = am_source.ToolbarItemBarIndex
	End If
End If
	
//Search through the rest of the menu	
li_limit = UpperBound (am_source.item)
For li_cnt = 1 to li_limit
	of_GetAllToolbarIndex (am_source.item[li_cnt], ai_barindex)
Next

return upperbound(ai_barindex)

end function

public function boolean of_toolbarexists (menu am_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ToolbarExists
//
//	Access:  		public
//
//	Arguments:		
//	am_source			The menu that should be searched.
//
//	Returns:  		boolean
//						True if it Toolbar Exists.
//						False if the Toolbar does not Exists.
//						If any argument's value is NULL or not Valid,
//						  function returns NULL.
//						
//
//	Description:  	Determines if the toolbar exists on the passed menu.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_limit
integer	li_cnt
boolean	lb_toolbarexists

//Check arguments
If Not IsValid(am_source) or IsNull(am_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If Len (am_source.ToolbarItemName) > 0 Then
	Return True
End If
	
//Search through the rest of the menu until an item with a 
//Toolbar item is found.
li_limit = UpperBound (am_source.item)
For li_cnt = 1 to li_limit
	lb_toolbarexists = of_ToolbarExists (am_source.item[li_cnt])
	If lb_toolbarexists = True or IsNull(lb_toolbarexists) Then
		Return lb_toolbarexists
	End If
Next

Return False

end function

public function integer of_triggerevent (menu am_source, string as_event);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_TriggerEvent
//
//	Access:  		public
//
//	Arguments:		
//	am_source		The menu for which to trigger the event.
// as_event			The name of the event to be triggered
//
//	Returns:  		integer
//						 1 Event triggered successfully. 
//						-1 if the event is not a valid event, or no script
//							exists for the event.
//
//	Description:  	Triggers the event name specified on the active MDI sheet.
//
//		Sequence:
//			If application is MDI:
//				1) Active MDI sheet triggerevent
//				2) MDI Frame Window triggerevent
//
//			Application is SWI:
//				3) ParentWindow triggerevent
//
//////////////////////////////////////////////////////////////////////////////

window	lw_frame, &
			lw_sheet, &
			lw_obj
integer	li_rc
boolean	lb_frame_exists=False

//Check arguments
If Not IsValid(am_source) or IsNull(am_source) Then
	Return -1
End If

//////////////////////////////////////////////////////////////////////////////
//Get the frame window (if any)
//////////////////////////////////////////////////////////////////////////////
of_GetMDIFrame(am_source, lw_frame)
if Not IsNull (lw_frame) And IsValid (lw_frame) Then
	lb_frame_exists = True
End If

//////////////////////////////////////////////////////////////////////////////
// Try triggering the event on the active MDI sheet
//////////////////////////////////////////////////////////////////////////////
If lb_frame_exists Then
	lw_sheet = lw_frame.GetActiveSheet()
	if IsValid (lw_sheet) then
		Return lw_sheet.TriggerEvent (as_event)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// There is no active MDI sheet. 
// Try triggering the event on the MDI Frame
//////////////////////////////////////////////////////////////////////////////
If lb_frame_exists Then
	Return lw_frame.TriggerEvent (as_event)	
End If

//////////////////////////////////////////////////////////////////////////////
// There is no MDI frame.
//	Trigger the event on the ParentWindow
//////////////////////////////////////////////////////////////////////////////
lw_obj = am_source.ParentWindow
Return lw_obj.TriggerEvent (as_event)		

end function

on n_cst_menu.create
TriggerEvent( this, "constructor" )
end on

on n_cst_menu.destroy
TriggerEvent( this, "destructor" )
end on

