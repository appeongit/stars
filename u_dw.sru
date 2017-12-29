HA$PBExportHeader$u_dw.sru
$PBExportComments$Ancestor DataWindow - Place this user object instead of d/w controls on a window. <gui>
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
string accessiblename = "Data Window User Object"
string accessibledescription = "Data Window User Object"
accessiblerole accessiblerole = clientrole!
integer width = 494
integer height = 360
integer taborder = 1
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_dwnkey pbm_dwnkey
event ue_dwnprocessenter pbm_dwnprocessenter
event ue_scrollvertical ( )
event ue_multiselect ( long al_row )
event type integer ue_updatespending ( )
event type integer ue_update ( boolean ab_accepttext,  boolean ab_resetflag )
event type integer ue_validation ( )
event type integer ue_descendant ( )
event type integer ue_sort ( integer ai_xpos,  integer ai_ypos,  long al_row,  ref dwobject adwo_obj )
event type integer ue_singleselect ( long al_row )
event type long ue_retrieve ( )
event ue_insert ( )
event type long ue_retrievedddw ( string as_column )
event type integer ue_selectall ( )
event type integer ue_firstpage ( )
event type integer ue_lastpage ( )
event type integer ue_nextpage ( )
event type integer ue_previouspage ( )
event documentation ( )
event type integer ue_reconnect ( )
event rbuttonup pbm_dwnrbuttonup
event type integer ue_preupdate ( )
event dropdown pbm_dwndropdown
event ue_lookup ( string as_col )
event ue_lookup_filter ( string as_col )
event ue_dblclick ( )
event ue_lookup_cell ( string as_col,  long al_row )
end type
global u_dw u_dw

type variables
//	Transaction object used by this d/w
n_tr	itr_object

// DropDownDataWindow Search service NVO
n_cst_dwsrv_dropdownsearch  inv_dropdownsearch

// Data trimming service NVO
n_cst_trim  inv_trim

// Base datawindow service (copied from the PFC)
n_cst_dwsrv	inv_base

// Resize datawindow service (copied from the PFC)
n_cst_dwsrv_resize	inv_resize

// String service (autoinstantiated)
n_cst_string	inv_string

// Label Processing service	JGG	01/12/98
n_cst_labels	inv_labels

// Multirow select?
Protected		Boolean	ib_MultiSelect

// Single Row Select?
Protected		Boolean	ib_SingleSelect

// ENTER key treated as a TAB?
Protected		Boolean	ib_EnterIsTab

// Is this d/w updateable? (Initialize to yes)
Protected		Boolean	ib_isupdateable = TRUE

// Is the right-mouse menu available? (Initialize to no)
Protected		Boolean	ib_rmbmenu = FALSE

// Is rbuttondown allowed to change focus
Protected		Boolean	ib_rmbfocuschange = TRUE

// Does this d/w sort on columns?
Protected		Boolean	ib_sortcol

// Does this d/w only retrieve 1 row?  This is checked
// when deleting a row in a d/w (If true, the data is
// immediately updated.
Protected		Boolean	ib_SingleRow = FALSE

Protected		String	is_defaultheadersuffix = '_t'
Protected		String	is_sortcolumn
Protected		String	is_sortorder

// Is the retrieve meter going to be used when retrieving
// data?
Protected		Boolean	ib_use_retrievemeter
u_retrievemeter	iu_retrievemeter

// DropDown calendar service
u_calendar 	iuo_calendar

// Date string for reports - MikeFl 4/4/02 - Track 2947  
string 		is_run_date

end variables

forward prototypes
public subroutine of_enteristab (boolean ab_switch)
public subroutine of_singleselect (boolean ab_switch)
public function boolean of_getupdateable ()
public function integer of_getparentwindow (ref window aw_window)
public subroutine of_setupdateable (boolean ab_switch)
public subroutine of_setcolumnsort (boolean ab_switch)
public subroutine of_setsinglerow (boolean ab_switch)
public function boolean of_getsinglerow ()
public function integer settransobject (transaction atr_trans)
public function integer of_setbase (boolean ab_switch)
public function integer of_setresize (boolean ab_switch)
public function integer of_setlabels (boolean ab_switch)
public subroutine of_setretrievemeter (boolean ab_switch)
public function uo_query of_getuoquery ()
public subroutine of_set_dw_dbms (n_tr atr_trans)
public subroutine of_set_dw_dbms ()
public subroutine of_multiselect (boolean ab_switch)
public function integer of_set_dddw_dbms ()
public function integer of_setdropdownsearch (boolean ab_switch)
public function integer of_settrim (boolean ab_switch)
public function integer of_setdropdowncalendar (boolean ab_switch)
public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly)
end prototypes

event ue_dwnkey;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_dwnkey
//
//	Modifications:
//	08-09-99	NLG	When F12 is pressed, trigger the window event 
//				to open a right-mouse menu.  When Ctrl and right-arrow key 
//				pressed, trigger the window event to display the next tabpage 
//				on a tab. When Ctrl and the left-arrow key is pressed, 
//				trigger the window event to display previous tabpage on a tab.  
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/19/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
///////////////////////////////////////////////////////////////////////////

Long		ll_row
String	ls_col, ls_value
Integer	li_rc
w_master	lw_parent

IF KeyDown (KeyF12!)  THEN
	Li_rc  =  This.of_GetParentWindow (lw_parent)
	Lw_parent.Post	Event  ue_open_rmm()
ELSEIF KeyDown( KeyF2! ) THEN
	This.AcceptText()
	ll_row = This.GetRow()
	ls_col = This.GetColumnName()
	
	IF ll_row < 1 OR ls_col = "" THEN Return
	
	//	Check if column contains filter prefix
	ls_value = This.Describe( ls_col + ".ColType" )
	IF gnv_sql.of_is_character_data_type( ls_value ) THEN
		ls_value = This.GetItemString( ll_row, ls_col )
		IF gnv_app.of_is_filter_name( ls_value ) THEN
			This.Event ue_lookup_filter( ls_col )
			Return
		END IF
	END IF
	
	//	See if column is lookup	
	IF Upper( This.Describe( ls_col + ".Tag" ) ) = "LOOKUP" THEN 
		This.Event ue_lookup( ls_col )
		Return
	END IF
	
	//	Trigger cell lookup event
	This.Event ue_lookup_cell( ls_col, ll_row )
ELSEIF KeyDown( KeyF3! ) THEN
	//	Trigger custom DoubleClick event
	This.event ue_dblclick( )
ELSE
	IF  KeyDown (KeyControl!)  THEN
		IF  KeyDown (KeyRightArrow!)  THEN
			Li_rc  =  This.of_GetParentWindow (lw_parent)
			Lw_parent.Post	Event  ue_next_tabpage()
		ELSEIF  KeyDown (KeyLeftArrow!)  THEN
			Li_rc  =  This.of_GetParentWindow (lw_parent)
			Lw_parent.Post	Event  ue_prev_tabpage()
		//moved from above:
		ElseIf KeyDown(KeyUpArrow!) Then
			Post(Handle(Parent), 277, 0, 0)
		ElseIf KeyDown(KeyDownArrow! ) Then
			Post(Handle(Parent), 277, 1, 0)
		ElseIf KeyDown(KeyPageUp! ) Then
			Post(Handle(Parent), 277, 2, 0)	
		ElseIf KeyDown(KeyPageDown! ) Then
			Post(Handle(Parent), 277, 3, 0)
		ElseIf KeyDown(KeyHome! ) AND KeyDown(KeyControl!) Then
			Post(Handle(Parent), 277, 6, 0)
		ElseIf KeyDown(KeyEnd! ) AND KeyDown(KeyControl!) Then
			Post(Handle(Parent), 277, 7, 0)
		END IF
	END IF
END IF
end event

event ue_dwnprocessenter;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_dwnprocessenter 
//
//	Description:  Determine if ENTER is to treated as a TAB.
//
//////////////////////////////////////////////////////////////////////////////

IF	ib_EnterIsTab		THEN
	Send (Handle (This), 256, 9, Long (0, 0) )
	Return 1
END IF

end event

event ue_multiselect;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	u_dw.ue_multiselect
//
//	Arguments:
//	al_row				The row on which some action is required.
//
//	Returns:  		None
//
//	Description:  Performs specific Extended select processing on a row.
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_row,		&
			ll_rowcount,	&
			ll_anchor_row

// Check arguments.
IF IsNull(al_row) 		&
OR al_row <	0				THEN
	Return 
END IF

ll_rowcount		=	This.RowCount()

//	If the SHIFT key was not pressed, select/unselect the
//	clicked row, and set the clicked row as the current row.
IF KeyDown (KeyShift!)	=	FALSE		THEN
	// Either CTRL was pressed or nothing was pressed with the click
	This.SelectRow ( al_row, NOT ( This.IsSelected(al_row) ) )
	IF	This.GetRow()	<>	al_row	THEN
		This.SetRow (al_row)
	END IF
	Return
END IF

//	From this point on, either the SHIFT key was pressed

//	Get the first selected row - This becomes the "anchor" row.
ll_anchor_row	=	This.GetSelectedRow (0)
	
// If there is no anchor row, then only select the row that was clicked.
IF ll_anchor_row	=	0	THEN
	This.SelectRow ( al_row, TRUE )
ELSE
	// Prevent flickering.  Improve performance.
	This.SetReDraw ( FALSE ) 
	// Select all rows in between anchor row and current row 
	IF ll_anchor_row	>	al_row	THEN
		FOR ll_row = ll_anchor_row TO al_row STEP -1
			This.SelectRow ( ll_row, TRUE )	
		NEXT
	Else
		FOR ll_row = ll_anchor_row TO al_row
			This.SelectRow ( ll_row, TRUE )	
		NEXT 
	END IF
	// Prevent flickering.  Improve performance.
	This.SetReDraw ( TRUE ) 
END IF
	
// Make the row the current row.
IF This.GetRow() <> al_row		THEN
	This.SetRow ( al_row ) 
END IF	
		
Return

end event

event ue_updatespending;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	u_dw.ue_updatespending
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Determine if there are any pending updates on this d/w.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

//	See if the d/w is updateable
IF	NOT	This.of_GetUpdateable ()	THEN
	Return 0
END IF

//	Check for pending updates
IF	This.ModifiedCount()	+	This.DeletedCount()	>	0	THEN
	Return 1
END IF

//	There are no pending updates
Return 0

end event

event ue_update;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	u_dw.ue_update
//
//	Arguments:
//	ab_accepttext	Should an Accepttext be performed before updating?
//	ab_resetflag	Should the d/w reset the update flags?
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Update this d/w.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

//	Verify arguments
IF	IsNull (ab_accepttext)	&
OR	IsNull (ab_resetflag)	THEN
	Return -1
END IF

// Fire the pre-update event
IF THIS.Event ue_preupdate() < 0 THEN Return -1

li_rc	=	This.Update (ab_accepttext, ab_resetflag)

Return li_rc

end event

event ue_validation;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	u_dw.ue_validation
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Validate the d/w (check for required fields)
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_column = 1,		&
				li_rc
				
Long			ll_row = 1
String		ls_colname = ''
Boolean		lb_updateonly = TRUE

//	Check for missing required fields

li_rc	=	This.of_checkrequired (Primary!, ll_row, li_column, ls_colname, lb_updateonly)

IF	(li_rc	<	0)		&
OR	(ll_row	>	0)		THEN
	Return -1
END IF

//	No errors
Return 1

end event

event ue_descendant;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	u_dw.ue_descendant
//
//	Arguments:	None
//
//	Returns:  		Integer - Always returns 1
//
//	Description:	This event notifys the calling script that the
//						d/w was inherited from u_dw
//
//////////////////////////////////////////////////////////////////////////////

Return 1

end event

event ue_sort;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			ue_sort
//
//	Arguments:  	(passed arguments of dw Clicked event)
//  xpos (integer)  		 	The x-position of the mouse
//  ypos (integer)  			The y-position of the mouse
//  row (long) 				The row number clicked on, if any
//	 dwo (dwobject)   		The dwobject clicked on )
//
//	Returns:   		Integer
//   					 1 if it succeeds.
//						 0 if no action was required.
//						-1 if an error occurs.
//
//	Description:  	Causes sorting when the user clicks on the header
//					  	of a datawindow, emulating the WIN95 style.
//					  	Click causes new sort (alternately Asc/Desc if same column).
//
//////////////////////////////////////////////////////////////////////////////

string	ls_headername
string 	ls_colname
integer	li_rc
integer	li_suffixlen
integer	li_headerlen
string	ls_sortstring

// Validate the dwo reference.
IF IsNull(adwo_obj) OR NOT IsValid(adwo_obj) THEN	 
	Return -1
END IF 

// Only valid on header column.
If adwo_obj.Name = 'datawindow' THEN Return 0
IF adwo_obj.Band <> "header" THEN Return 0

// Get column header information.
ls_headername = adwo_obj.Name
li_headerlen = Len(ls_headername)
li_suffixlen = Len(is_defaultheadersuffix)

// Extract the columname from the header label 
// (by taking out the header suffix).
IF Right(ls_headername, li_suffixlen) <> is_defaultheadersuffix THEN 
	// Cannot determine the column name from the header.	
	Return -1
END IF 	

ls_colname = Left (ls_headername, li_headerlen - li_suffixlen)

// Validate the column name.
If IsNull(ls_colname) or Len(Trim(ls_colname))=0 Then 
	Return -1
End If

// Check the previous sort click.
IF is_sortcolumn = ls_colname THEN	
	// Second sort click on the same column, reverse sort order.
	IF is_sortorder = " A" THEN 	
		is_sortorder = " D"
	ELSE
		is_sortorder = " A"
	END IF 
ELSE
	// Clicked on a different column.
	is_sortcolumn = ls_colname
	is_sortorder = " A" 
END IF 

// Build the sort string.
//IF of_GetUseDisplay() And of_UsesDisplayValue(ls_colname) THEN
//	ls_sortstring = "LookUpDisplay(" + ls_colname + ") " + is_sortorder 
//ELSE
	ls_sortstring = is_sortcolumn + is_sortorder
//END IF 

// Perform the SetSort operation (check the rc).
li_rc = This.SetSort (ls_sortstring) 
If li_rc < 0 Then 
	Return li_rc
END IF

// Perform the actual Sort operation (check the rc).
li_rc = This.Sort()
If li_rc < 0 Then 
	Return li_rc	
END IF
	
Return 1

end event

event ue_singleselect;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.SingleSelect
//
//	Argument:	al_row - The selected row
//
//	Description:	Unhilite all rows and hilite the current row.
//						Do not set the hilited row as the current row in this 
//						event because this event is triggered from the
//						RowFocusChanged event (which can cause an infinite loop).
//
//////////////////////////////////////////////////////////////////////////////

IF	al_row	>	0		THEN
	This.SelectRow (0, FALSE)
	This.SelectRow (al_row, TRUE)
END IF

Return 1
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_retrieve
//
//	Description:	Retrieve the data for this d/w.
//
//	NOTE:	Triggering this event is not necessary to retrieve data.
//			This event simply enables you to extend or override this
//			script should the need arise.
//
//////////////////////////////////////////////////////////////////////////////

Return	This.Retrieve()

end event

event ue_retrievedddw;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_retrievedddw
//
//	Arguments:  none
//
//	Returns:  long
//		Can be used with Powerscript Retrieve function, to indicate
//	   success/failure, or number of rows retrieved.
//
//	Description:  
//		This event should be used in descendants to
//	   populate any DropDownDataWindows on the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////

Return 0
end event

event ue_selectall;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_selectall
//
//	Description:  
//		Select all text in the current row/column
//
//////////////////////////////////////////////////////////////////////////////

Return	SelectText (1, 32767)

end event

event ue_firstpage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_firstpage
//
//	Description:	
//			Scroll to the first page of the d/w.
//
//////////////////////////////////////////////////////////////////////////////

Return	This.ScrollToRow (0)

end event

event ue_lastpage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_lastpage
//
//	Description:	
//			Scroll to the last page of the d/w.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_rc
String	ls_rc

ll_rc	=	ScrollToRow (2147483647)

IF	ll_rc	>	0		THEN
	ls_rc	=	This.object.datawindow.firstrowonpage
	IF	IsNumber (ls_rc)		THEN
		ll_rc	=	Long (ls_rc)
	ELSE
		ll_rc	=	-1
	END IF
END IF

Return	ll_rc

end event

event ue_nextpage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_nextpage
//
//	Description:	
//			Scroll to the next page of the d/w.
//
//////////////////////////////////////////////////////////////////////////////

Return	This.ScrollNextPage ()

end event

event ue_previouspage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_previouspage
//
//	Description:	
//			Scroll to the previous page of the d/w.
//
//////////////////////////////////////////////////////////////////////////////

Return	This.ScrollPriorPage ()

end event

event ue_reconnect;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ue_reconnect
//
//	Description:	
//		This event is triggered from w_master.ue_reconnect when the user is
//		disconnected from timing out of the system.  If there is a valid
//		transaction object, perform a SetTransobject.
//
//////////////////////////////////////////////////////////////////////////////
//
//	History
//
//	FDG	04/29/98		Track 1118.  Created.
//
//////////////////////////////////////////////////////////////////////////////

IF	IsValid (itr_object)		THEN
	This.SetTransobject (itr_object)
ELSE
	Return 0
END IF

Return 1


end event

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
lw_parent.Event ue_open_rmm()

Return 1
end event

event ue_preupdate;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	u_dw.ue_preupdate
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Additional processing prior to updating this d/w.
//
//////////////////////////////////////////////////////////////////////////////
//	Revision History
//
//	FDG	04/12/01	Stars 4.7.	Add ability to trim the data.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rtn = 1

// Convert specified fields to be updated to upper case
IF Upper( THIS.Describe( "t_uppercase.Text") ) = "UPPER" THEN
	li_rtn = gnv_sql.of_SetUpper( THIS )
	IF	li_rtn	<	0		THEN
		Return	li_rtn
	END IF
END IF	

IF	IsValid (inv_trim)		THEN
	li_rtn	=	inv_trim.Event	ue_preupdate()
	IF	li_rtn	<	0		THEN
		Return	li_rtn
	END IF
END IF

Return li_rtn

end event

event dropdown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  dropdown
//
//	Arguments:  none
//
//	Returns:  none
//	
//	Description:	 Notification that a dropdown object has been requested.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	10/17/01	GaryR	Stars 4.8.1	Created
//
//////////////////////////////////////////////////////////////////////////////

If IsValid(iuo_calendar) Then
	// Check if this a column that has the calendar associated to it.
	If iuo_calendar.Event pfc_dropdown() = 1 Then
		// Column is a ddcalendar column.  Prevent listbox from appearing.
		Return 1
	End If
End If

//If IsValid(iuo_calculator) Then
//	// Check if this a column that has the calculator associated to it.
//	If iuo_calculator.Event pfc_dropdown() = 1 Then
//		// Column is a ddcalculator column.  Prevent listbox from appearing.
//		Return 1
//	End If
//End If
end event

event ue_lookup(string as_col);//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	String	value	as_col
//
// Returns:		None
//
// Description:	Use this event to add column specific lookup logic
//						This event is triggered either via right click or F2 key.
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************
end event

event ue_lookup_filter(string as_col);//*********************************************************************************
// Script Name:	ue_lookup_filter
//
// Arguments:	String	value	as_col
//
// Returns:		None
//
// Description:	Use this event to add filter lookup logic
//						This event is triggered either via right click or F2 key.
//
//*********************************************************************************
//
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************
end event

event ue_dblclick();//*********************************************************************************
// Script Name:	ue_dblclick
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute DoubleClicked functionality
//
//*********************************************************************************
//
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************
end event

event ue_lookup_cell(string as_col, long al_row);//*********************************************************************************
// Script Name:	ue_lookup_cell
//
// Arguments:	String	as_col
//					Long		al_row
//
// Returns:		None
//
// Description:	Execute cell & header lookup functionality in this event
//						This event is triggered either via right click or F2 key.
//
//*********************************************************************************
//
//	05/19/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************
end event

public subroutine of_enteristab (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_enteristab
//
//	Arguments:	ab_switch -	TRUE = Set the enter key as a tab
//									FALSE = Set the enter key as enter
//
//	Returns:	None
//
//************************************************************************

IF	ab_switch		THEN
	ib_enteristab	=	TRUE
ELSE
	ib_enteristab	=	FALSE
END IF


end subroutine

public subroutine of_singleselect (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_singleselect
//
//	Arguments:	ab_switch -	TRUE = Set single selection of rows
//									FALSE = Do not set single selection of rows
//
//	Returns:	None
//
//************************************************************************

IF	ab_switch		THEN
	ib_singleselect	=	TRUE
ELSE
	ib_singleselect	=	FALSE
END IF


end subroutine

public function boolean of_getupdateable ();//************************************************************************
//	Script:	u_dw.of_getupdateable
//
//	Arguments:	N/A
//
//	Returns:	Boolean -	TRUE = This d/w can be updated
//								FALSE = This d/w cannot be updated
//
//************************************************************************

//	If the d/w attributes doesn't have an update table assigned to it,
//	then the d/w cannot be updated.
string ls_st

ls_st	=	This.Describe ("DataWindow.Table.UpdateTable")

IF	IsNull (ls_st)				&
OR	Trim (ls_st)	=	'?'	&
OR Trim (ls_st)	=	'!'	THEN
	Return FALSE
END IF

Return	ib_isupdateable

end function

public function integer of_getparentwindow (ref window aw_window);//************************************************************************
//	Script:	u_dw.of_getupdateable
//
//	Arguments:	N/A
//
//	Returns:	Boolean -	TRUE = This d/w can be updated
//								FALSE = This d/w cannot be updated
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

public subroutine of_setupdateable (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setupdateable
//
//	Arguments:	ab_switch - Set this d/w to be updated based on its value
//
//	Returns:		N/A
//
//************************************************************************

ib_isupdateable	=	ab_switch

end subroutine

public subroutine of_setcolumnsort (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setcolumnsort
//
//	Arguments:	ab_switch -	TRUE = Set the column headers to sort
//									FALSE = Do not set column headers to sort
//
//	Returns:	None
//
//************************************************************************

IF	ab_switch		THEN
	ib_sortcol	=	TRUE
ELSE
	ib_sortcol	=	FALSE
END IF


end subroutine

public subroutine of_setsinglerow (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setsinglerow
//
//	Arguments:	ab_switch -	TRUE = Datawindow retrieves one row
//									FALSE = Datawindow retrieves multiple rows
//
//	Returns:	None
//
//	Description:
//			This function specifies that the d/w only retrieves one row.
//			The flag set is checked when deleting a row.  If the row
//			deleted is the only row, then immediately update.
//
//************************************************************************

IF	ab_switch		THEN
	ib_singlerow	=	TRUE
ELSE
	ib_singlerow	=	FALSE
END IF

end subroutine

public function boolean of_getsinglerow ();//************************************************************************
//	Script:	u_dw.of_getsinglerow
//
//	Arguments:	None
//
//	Returns:		ab_switch -	TRUE = Datawindow retrieves one row
//									FALSE = Datawindow retrieves multiple rows
//
//	Description:
//			This function returns if the d/w only retrieves one row.
//			The flag set is checked when deleting a row.  If the row
//			deleted is the only row, then immediately update.
//
//************************************************************************

Return	ib_singlerow

end function

public function integer settransobject (transaction atr_trans);//************************************************************************
//	Script:	u_dw.SetTransObject
//
//	Arguments:	atr_trans -	The transaction to perform a SetTransobject on
//
//	Returns:	Integer
//
//	Description:
//		This function overloads the PowerBuilder SetTransObject()
//		function.  This script will save the transaction object passed
//		before calling PowerBuilder's SetTransObject function.
//
//************************************************************************

itr_object	=	atr_trans

Return	Super::Function	SetTransObject (atr_trans)

end function

public function integer of_setbase (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setbase
//
//	Arguments:	ab_switch -	TRUE = Start (Create) the service
//									FALSE = Stop (Destroy) the service
//
//	Returns:	Integer
//				1	-	Successful
//				0	-	No action taken
//				-1	-	An error occured
//
//	Description:	Start or stop the Base DataWindow Service
//
//************************************************************************

//	Check argument
IF	IsNull (ab_switch)	THEN
	Return -1
END IF

IF	ab_switch	THEN
	IF	NOT	IsValid (inv_base)	THEN
		inv_base	=	CREATE	n_cst_dwsrv
		inv_base.of_SetRequestor (THIS)
		Return 1
	END IF
ELSE
	IF	IsValid (inv_base)	THEN
		DESTROY	inv_base
		Return 1
	END IF
END IF

Return 0
	


end function

public function integer of_setresize (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setresize
//
//	Arguments:	ab_switch -	TRUE = Start (Create) the service
//									FALSE = Stop (Destroy) the service
//
//	Returns:	Integer
//				1	-	Successful
//				0	-	No action taken
//				-1	-	An error occured
//
//	Description:	Start or stop the DataWindow Resize Service
//
//************************************************************************

//	Check argument
IF	IsNull (ab_switch)	THEN
	Return -1
END IF

IF	ab_switch	THEN
	IF	NOT	IsValid (inv_resize)	THEN
		inv_resize	=	CREATE	n_cst_dwsrv_resize
		inv_resize.of_SetRequester (THIS)
		inv_resize.of_SetOrigSize (This.Width, This.Height)
		//	register all d/w objects to the service
		//inv_resize.of_RegisterAll()
		Return 1
	END IF
ELSE
	IF	IsValid (inv_resize)	THEN
		DESTROY	inv_resize
		Return 1
	END IF
END IF

Return 0
	


end function

public function integer of_setlabels (boolean ab_switch);// STARS 4.0		Subset Redesign
//						TS144 - labels
//
// Object:			u_dw - ancestor datawindow 
//	Object Type:	function
//
// Log: 				JGG	01/12/98		Created function
//
// 
// This function will either create or destroy the labels service (non-visual object).
// It will receive a boolean argument (ab_switch) to determine action to take.
// If switch is set to TRUE, the service is created.
// If switch is set to FALSE, the service is destroyed.

integer						li_rc

// Check argument is set - i.e. is not null

If IsNull(ab_switch) Then
	RETURN -1
End if

// Create or destory service based on switch setting
If ab_switch Then
	
	// Create service only if it does not already exist
	If not IsValid(inv_labels) Then
		// Create the service
		inv_labels	=	create n_cst_labels
		
		// Register this datawindow to the service
		inv_labels.of_setdw(This)
		
		li_rc			=	1
	End if
Else
	
	// Destroy service only if it exists
	If IsValid(inv_labels) Then
		destroy inv_labels
		li_rc			=	1
	End if
End if

RETURN li_rc

end function

public subroutine of_setretrievemeter (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setretrievemeter
//
//	Arguments:	ab_switch 
//					TRUE  - Use the retrievemeter when retrieving data.
//					FALSE - Don't use the retrievementer
//
//	Returns:		N/A
//
//************************************************************************
//	History:
//
//	FDG	02/13/98	Created (Stars 4.0)
//
//
//************************************************************************

ib_use_retrievemeter	=	ab_switch

end subroutine

public function uo_query of_getuoquery ();//************************************************************************
//	Script:	u_dw.of_getuoquery
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

public subroutine of_set_dw_dbms (n_tr atr_trans);//************************************************************************
//	Script:		u_dw.of_set_dw_dbms
//
//	Arguments:	atr_trans (Type n_tr)
//
//	Returns:		None
//
//	Description:	This overloaded function will change the name of the 
//						d/w object based on which DBMS the client is using.
//
//************************************************************************
//
//	FDG	11/15/00	Stars 4.7 - Oracle port.  
//
//************************************************************************

This.of_set_dw_dbms()

IF	IsValid(atr_trans)		THEN
	This.SetTransObject(atr_trans)
END IF



end subroutine

public subroutine of_set_dw_dbms ();//************************************************************************
//	Script:		u_dw.of_set_dw_dbms
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	This overloaded function will change the name of the 
//						d/w object based on which DBMS the client is using.
//
//************************************************************************
//
//	FDG	11/15/00	Stars 4.7 - Oracle port.  
//
//************************************************************************

String	ls_dataobject

Integer	li_rc

ls_dataobject	=	This.DataObject
ls_dataobject	=	gnv_sql.of_get_dw_object(ls_dataobject)

This.DataObject	=	ls_DataObject

// If this datawindow object has any DDDWs with transact-SQL, the d/w
//	object name associated with the DDDW must be changed.
li_rc				=	This.of_set_dddw_dbms()



end subroutine

public subroutine of_multiselect (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_multiselect
//
//	Arguments:	ab_switch -	TRUE = Set multiple selection of rows
//									FALSE = Set single selection of rows
//
//	Returns:	None
//
//************************************************************************

IF	ab_switch		THEN
	ib_multiselect	=	TRUE
ELSE
	ib_multiselect	=	FALSE
END IF


end subroutine

public function integer of_set_dddw_dbms ();//************************************************************************
//	Script:		u_dw.of_set_dddw_dbms
//
//	Arguments:	None
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:	This function will loop thru every column to determine
//						which DDDW columns have transact-SQL.  These columns
//						will contain ';DDDWSQL;' in its tag value.  For each
//						column containing this tag value, do the following:
//						1. Get the d/w object name from the DDDW
//						2. Get the new d/w object name and reassign it to
//							the DDDW.
//
//************************************************************************
//
//	FDG	11/15/00	Stars 4.7 - Oracle port.  
//
//************************************************************************

Integer	li_col,			&
			li_colcount,	&
			li_pos

String	ls_tag,			&
			ls_colname,		&
			ls_describe,	&
			ls_modify,		&
			ls_dwname,		&
			ls_rc
			
li_colcount	=	Integer( This.object.datawindow.column.count )

FOR	li_col	=	1	to	li_colcount
	// Get the column name
	ls_describe	=	'#'	+	String(li_col)	+	'.Name'
	ls_colname	=	This.Describe (ls_describe)
	// Get the tag value for the column name
	ls_describe	=	ls_colname	+	'.Tag'
	ls_tag		=	This.Describe (ls_describe)
	// Determine if this tag specifies that the DDDW has transact SQL
	li_pos		=	Pos (ls_tag, gnv_sql.ics_dddwsql)
	IF	li_pos	>	0		THEN
		// Tag found.  DDDW d/w object contains transact-SQL.
		//	Change the d/w object name
		ls_describe	=	ls_colname	+	'.dddw.Name'
		ls_dwname	=	This.Describe (ls_describe)
		ls_dwname	=	gnv_sql.of_get_dw_object(ls_dwname)
		ls_modify	=	ls_colname	+	".dddw.Name='"	+	ls_dwname	+	"'"
		ls_rc			=	This.Modify (ls_modify)
	END IF
NEXT

Return	1

end function

public function integer of_setdropdownsearch (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_setdropdownsearch
//
//	Arguments:	ab_switch -	TRUE = Start (Create) the service
//									FALSE = Stop (Destroy) the service
//
//	Returns:	Integer
//				1	-	Successful
//				0	-	No action taken
//				-1	-	An error occured
//
//	Description:	Start or stop the DropDownDataWindow Search Service
//
//************************************************************************

//	Check argument
IF	IsNull (ab_switch)	THEN
	Return -1
END IF

IF	ab_switch	THEN
	IF	NOT	IsValid (inv_dropdownsearch)	THEN
		inv_dropdownsearch	=	CREATE	n_cst_dwsrv_dropdownsearch
		inv_dropdownsearch.of_SetRequestor (THIS)
		inv_dropdownsearch.of_AddColumn ()
		Return 1
	END IF
ELSE
	IF	IsValid (inv_dropdownsearch)	THEN
		DESTROY	inv_dropdownsearch
		Return 1
	END IF
END IF

Return 0


end function

public function integer of_settrim (boolean ab_switch);//************************************************************************
//	Script:	u_dw.of_settrim
//
//	Arguments:	ab_switch -	TRUE = Start (Create) the service
//									FALSE = Stop (Destroy) the service
//
//	Returns:	Integer
//				1	-	Successful
//				0	-	No action taken
//				-1	-	An error occured
//
//	Description:	Start or stop the data trimming service
//
//************************************************************************

//	Check argument
IF	IsNull (ab_switch)	THEN
	Return -1
END IF

IF	ab_switch	THEN
	IF	NOT	IsValid (inv_trim)	THEN
		inv_trim	=	CREATE	n_cst_trim
		inv_trim.of_SetRequestor (THIS)
		Return 1
	END IF
ELSE
	IF	IsValid (inv_trim)	THEN
		DESTROY	inv_trim
		Return 1
	END IF
END IF

Return 0


end function

public function integer of_setdropdowncalendar (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
// 
//	Event:  of_SetDropDownCalendar
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDown Calendar visual object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	10/17/01	GaryR	Stars 4.8.1	Created
//
//////////////////////////////////////////////////////////////////////////////

window lw_parent
string	ls_classname
powerobject	lpo_message
n_cst_calendarattrib lnv_calendarattrib
constant	integer	SUCCESS = 1
constant	integer	NO_ACTION = 0
constant	integer	FAILURE = -1

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

// Get parent window reference.
of_GetParentWindow(lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF Not IsValid (iuo_Calendar) THEN
		// If using pfc_n_msg, store the Message Object (dynamic call).
		If IsValid(message) Then
			ls_classname = Trim(Lower(message.ClassName()))
			If ls_classname = 'n_msg' Then lpo_message = Create Using 'n_msg'
			If IsValid(lpo_message) Then message.Dynamic of_CopyTo(lpo_message)
		End If				
		
		// Tell the object to behave as a dropdown object.
		lnv_calendarattrib.ib_dropdown = True
		lw_parent.OpenUserObjectWithParm(iuo_Calendar, lnv_calendarattrib)
		iuo_Calendar.of_SetRequestor (this)
		
		// If using pfc_n_msg, restore the Message Object (dynamic call).
		If IsValid(lpo_message) Then 
			lpo_message.Dynamic of_CopyTo(message)
			Destroy lpo_message
		End If
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (iuo_Calendar) THEN
		lw_parent.CloseUserObject(iuo_Calendar)
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  u_dw.of_CheckRequired 
//
//	Arguments:
//	adw_buffer (value)   The buffer to check for required fields
// al_row (reference)  	First row to be checked.  Also stores the number of the found row
//	ai_col (reference)	First column to be checked.  Also stores the number of the found column
//	as_colname (reference)   Contains the columnname in error
//
//	Returns:  integer
//	 1 = The required fields test was successful, check arguments for required fields missing
//	 0 = The required fields test was successful and no errors were found
//  -1 = The FindRequired failed
//
//	Description:
//	Calls the FindRequired function to determine if any of the required
//	columns contain null values.
//
//////////////////////////////////////////////////////////////////////////////

Window		lw_parent
boolean		lb_skipmessage=False
string		ls_msgparm[2]

// Check arguments
IF IsNull (adw_buffer)	&
OR IsNull (al_row) 		&
OR IsNull (ai_col)		&
OR IsNull (as_colname)	THEN
	Return -1
END IF

SetPointer(HourGlass!) 

// Call FindRequired to locate first error, if any
IF This.FindRequired (adw_buffer, al_row, ai_col, as_colname, ab_updateonly) < 0 THEN
	Return -1
END IF

// Get a reference to the window
This.of_GetParentWindow (lw_parent) 

// Check if an error was found.
IF al_row <> 0 then
	
	IF Not lb_skipmessage Then
		MessageBox ( 'Validation Error', "Required value missing for " + &
						as_colname + " on row "  + String (al_row) + &
						".  Please enter a value.", information!)
		This.SetRow (al_row)
		This.ScrollToRow (al_row)		
		This.SetColumn (ai_col)
		This.SetFocus () 		
	END IF
	
	Return 1
END IF

Return 0
end function

event dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  DBError
//
//	Description:
//		Open w_db_error to display the database error data.  If this occured
//		during the ue_save process, do not open w_db_error until after
//		the data is rolled back.
//
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	02/17/98	Added dataobject to the structure.
//
//////////////////////////////////////////////////////////////////////////////

str_db_error	lstr_db
w_master			lw_window
Boolean			lb_pfcsaveprocess = FALSE
String			ls_message,				&
					ls_msgparm[1]
Integer			li_rc

IF	NOT	IsValid (itr_object)		THEN
	itr_object	=	STARS1CA
END IF

ls_message =	"A database error has occurred in STARS." 

lstr_db.trans				=	itr_object
lstr_db.message			=	ls_message
lstr_db.row_num			=	row
lstr_db.sqldbcode			=	sqldbcode
lstr_db.sqlerrtext		=	sqlerrtext
lstr_db.sqlsyntax			=	sqlsyntax
lstr_db.sqlreturndata	=	itr_object.sqlreturndata
lstr_db.dataobject		=	This.DataObject			// FDG 02/17/98

li_rc		=	This.of_GetParentWindow (lw_window)

IF	IsValid (lw_window)		THEN
	//	Get the name of the window
	lstr_db.window_name		=	lw_window.ClassName()
	// Only perform if window is inherited from w_master
	IF	lw_window.Event	ue_descendant()	=	TRUE		THEN
		//	Save the transaction data 
		lw_window.of_SetTransaction (itr_object)
		lb_pfcsaveprocess	=	lw_window.of_GetSaveStatus()
		// If this occured during the ue_save process, then delay opening
		//	the Database error window until after the data is rolled back
		IF	lb_pfcsaveprocess	=	TRUE		THEN
			lw_window.of_SetDBErrorMsg (ls_message)
			lw_window.of_SetDBError (lstr_db)
			Return 1
		END IF
	END IF
END IF

OpenWithParm (w_db_error, lstr_db)

Return 1

end event

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.Constructor
//
//	Description:  Use the desired services needed for this datawindow.
//
//////////////////////////////////////////////////////////////////////////////

// If the d/w control is associated with a d/w object with multiple suffixes
//	for database independence (i.e. d_pattern_list & d_pattern_list_ora), then
// call the following (before setting the transaction object):
//This.of_set_dw_dbms()

// If the datawindow objects has DDDW columns pointing to another d/w object
// with multiple suffixes for database independence (i.e. d_dddw_case & d_dddw_case_ora),
//	then call the following (before setting the transaction object):
// This.of_set_dddw_dbms()
// Make sure the tag value of the DDDW column has ';DDDWSQL:' in it.

//	You can set the transaction object here
//This.SetTransObject (SQLCA)
//This.SetTransObject (Stars2ca) 

//	If you want this datawindow to select single rows, code this:
//This.of_SingleSelect (TRUE)

//	If you want this datawindow to select multiple rows, code this:
//This.of_MultiSelect (TRUE)

//	If you want the ENTER key to betreated as a tab, code this:
//This.of_EnterIsTab (TRUE)

//	If you want to resize the objects in the datawindow as the
//	window resizes, code this:
//This.of_SetResize (TRUE)

//	If you want sort on the column headers, code this:
//This.of_SetColumnSort (TRUE)

//	If you want the d/w NOT to be updateable
//This.of_SetUpdateable (FALSE)

//	If you only retrieves one row.  This is editted when a row is deleted.
//	If this is set to true, then immediately update the d/w. 
//This.of_SetSingleRow (TRUE)

//	Set this if you have DDDWs or DDLBs with search capabilities.
//	NOTE: This service has not been tested so it may not work. 
//This.of_SetDropDownSearch (TRUE)

//	If you want a dropdown calendar for date fields
//THIS.of_SetDropDownCalendar( TRUE )
//	Then register the fields
//THIS.iuo_calendar.of_Register( "from_period", this.iuo_calendar.NONE )
//THIS.iuo_calendar.of_Register( "to_period", this.iuo_calendar.DDLB )
//THIS.iuo_calendar.of_Register( "from_date_received", this.iuo_calendar.DDLB_WITHARROW )

// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating), call:
//This.of_SetTrim (TRUE)

// If you want to display the retrieve meter while the retrieval
//	is in progress, code the following
//This.of_SetRetrieveMeter(TRUE)
//	NOTE:	If using the retrievemeter, you can code the following in the
//			retrieverow event:
//					IF	gv_cancel_but_clicked		THEN
//						Integer	li_rc
//						li_rc		=	This.DBCancel()
//						gv_cancel_but_clicked	=	FALSE
//						Return	1
//					END IF
//					IF	IsValid (iu_retrievemeter)	THEN
//						iu_retrievemeter.of_progress (1)
//					END IF
//			The reason why this isn't coded within u_dw is that any code in
//			the retrieverow event will slow the retrieval.

// IF you want to convert data to be updated to upper case
// (1) - add an invisible text object to the dataobject
//			must be named t_uppercase.  Set the text to UPPER.
//			This indicates that this dataobject needs conversion.
// (2) - Set the Tag value to ;UPPER; for each column to be converted
end event

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.Clicked
//
//	Description:	If you are allowed to multi select rows, trigger
//						ue_multiselect (when clicking on the current row).
//
//	NOTE:	When the clicked row is different than the current row, then
//			the RowFocusChanged event gets triggered automatically.
//
//////////////////////////////////////////////////////////////////////////////

IF	ib_sortcol		THEN
	This.Event	ue_sort (xpos, ypos, row, dwo)
END IF

IF	ib_multiselect					&
AND This.GetRow ()	=	row	THEN
	This.Event	ue_multiselect (row)
	Return
END IF

IF	ib_singleselect				THEN
	This.Event	ue_singleselect (row)	// hilite clicked row
	//	Set the clicked row as the current row
	IF	This.GetRow ()	<>	row	THEN
		This.SetRow (row)
	END IF
END IF

//This.SetRow (row)		//	Set the clicked row as the current row

end event

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			u_dw.Destructor
//
//	Description:  	Reset anything that was previously set.
//
// Log:				
//		JGG	01/12/98	Destroy labels service
//		FDG	04/12/01	Destroy the data trimming service
//
//////////////////////////////////////////////////////////////////////////////

This.of_EnterIsTab (FALSE)

This.of_SingleSelect (FALSE)

This.of_MultiSelect (FALSE)

This.of_SetColumnSort (FALSE)

This.of_SetUpdateable (FALSE)

This.of_SetSingleRow (FALSE)

This.of_SetDropDownSearch (FALSE)

This.of_SetResize (FALSE)

This.of_SetLabels (FALSE)			//	JGG	01/12/98

This.of_SetTrim (FALSE)				//	FDG	04/12/01

This.of_SetDropDownCalendar( FALSE )	//	GaryR	10/17/01

This.of_SetBase (FALSE)		//	Always destroy this last

end event

event rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.RowFocusChanged
//
//	Description:	If you are allowed to multi select rows, trigger
//						ue_multiselect.  If you are allowed to select single
//						rows, unhilite all rows, and hilite the current row.
//
//////////////////////////////////////////////////////////////////////////////

IF	ib_multiselect		THEN
	This.Event	ue_multiselect (currentrow)
	Return
END IF

//	Only highlight the row if specified to do so
IF ib_singleselect	THEN
	This.Event	ue_singleselect (currentrow)

END IF

end event

event itemfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ItemFocusChanged
//
//	Description:  
//		Send itemfocuschanged notification to the d/w services.
//		If appropriate, display the microhelp stored in the tag value of the
//		current column.  Format:
//				MICROHELP=<microhelp text>
//
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	03/20/98	Remove logic from this event.  It will never get used in
//						STARS and it makes debugging longer
//	GaryR	09/25/02	SPR 2893d	Text sensitive search in DropDowns
//
//////////////////////////////////////////////////////////////////////////////


//	GaryR	09/25/02	SPR 2893d
IF	IsValid (inv_dropdownsearch)	THEN
	inv_dropdownsearch.Event  ue_ItemFocusChanged (row, dwo)
END IF
end event

event getfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.GetFocus
//
//	Description:  Notify the window that the control got focus.
//
//////////////////////////////////////////////////////////////////////////////

w_master		lw_parent

This.of_GetParentWindow (lw_parent)

IF	IsValid (lw_parent)		THEN
	lw_parent.Dynamic	Event	ue_ControlGotFocus (This)
END IF

end event

event itemerror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.ItemError
//
//	Description:  If the window is closing, suppress all errors
//
//////////////////////////////////////////////////////////////////////////////

w_master		lw_parent

This.of_GetParentWindow (lw_parent)

IF	IsValid (lw_parent)		THEN
	IF	lw_parent.Event	ue_descendant()	=	TRUE		THEN
		IF	lw_parent.of_GetCloseStatus()		THEN
			Return 1			//	Reject the data value with no messagebox
		END IF
	END IF
END IF

end event

event rbuttondown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.RButtonDown
//
//	Description:  
//		Allow for focus change on rbuttondown
//
//////////////////////////////////////////////////////////////////////////////
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/19/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//////////////////////////////////////////////////////////////////////////////

String	ls_colname,			&
			ls_value
Integer	li_pos			
			
//	Validate arguments
IF IsNull( dwo ) OR row <= 0 OR dwo.type	<>	'column' THEN
	ls_value = This.GetObjectAtPointer()
	IF ls_value = "" THEN Return

	li_pos = Pos( ls_value, "~t" )
	ls_colname = Left( ls_value, li_pos - 1 )
	This.Event ue_lookup_cell( ls_colname, 0 )
	Return
END IF

//	Set the row and column
ls_colname		=	dwo.name
This.SetColumn (ls_colname)
This.SetRow (row)

//	Check if column contains filter prefix
IF gnv_sql.of_is_character_data_type( dwo.ColType ) THEN
	ls_value = dwo.Primary[row]
	IF gnv_app.of_is_filter_name( ls_value ) THEN
		This.Event ue_lookup_filter( ls_colname )
		Return
	END IF
END IF

//	Check if column is lookup
IF Upper( This.Describe( ls_colname + ".Tag" ) ) = "LOOKUP" THEN 
	This.Event ue_lookup( ls_colname )
	Return
END IF

//	Trigger cell lookup event
This.Event ue_lookup_cell( ls_colname, row )
end event

event resize;// Use the resize service (If instantiated)

IF	IsValid (inv_resize)		THEN
	inv_resize.Event	pfc_resize (sizetype, newwidth, newheight)
END IF

end event

event retrievestart;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.RetrieveStart
//
//	Description:	If you are using the retrievemeter, open it.
//
//	NOTE:	If using the retrievemeter, you can code the following in the
//			retrieverow event:
//				iu_retrievemeter.of_progress(1)
//			The reason why this isn't coded within u_dw is that any code in
//			the retrieverow event will slow the retrieval.
//
//////////////////////////////////////////////////////////////////////////////
//
//	GaryR	09/14/01	Track 2430d	PB's Idle() method causes memory corruption
//	GaryR	10/23/01	Track 2502d	Disable microhelp during retrieval to prevent
//										user messages from executing and causing a GPF.
//	GaryR	02/20/04	Track 6028c	Keep a continuous count of rows retrieved
//	GaryR	07/13/04	Track 3971d	Lock all functionality during retrieval
//	GaryR	07/29/05	Track 4432d	Allow multi-column decode in background
// 	RickB	05/05/08	SPR 5335	Added code to get parent window parms
//
//////////////////////////////////////////////////////////////////////////////
String	ls_db_col
Integer	li_cols, li_ctr
n_cst_decode	lnv_decode

IF	ib_use_retrievemeter			THEN	
	SetPointer (HourGlass!)
	//	GaryR	10/23/01	Track 2502d
	w_time_microhelp.Enabled = FALSE
	w_main.SetMicroHelp ('Retrieving data, Please Wait!!')
	gnv_app.of_set_idle( FALSE )	//	GaryR	09/14/01	Track 2430d
	gnv_app.of_set_lock( TRUE )
	w_master		lw_parent
	Integer		li_rc
	li_rc		=	This.of_GetParentWindow (lw_parent)
	IF	IsValid (lw_parent)		THEN
		lw_parent.OpenUserObjectWithParm (iu_retrievemeter, lw_parent, lw_parent.x, lw_parent.y)
	END IF
END IF

//	Reset decoded columns if any
li_cols = Long( This.Describe( "datawindow.column.count" ) )
FOR li_ctr = 1 TO li_cols
	ls_db_col = This.Describe( "#" + String( li_ctr ) + ".Name" )
	lnv_decode.of_reset_col( ls_db_col, This )
NEXT
end event

event retrieveend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  u_dw.RetrieveEnd
//
//	Description:	If you are using the retrievemeter, close it.
//
//	NOTE:	If using the retrievemeter, you can code the following in the
//			retrieverow event:
//				iu_retrievemeter.of_progress(1)
//			The reason why this isn't coded within u_dw is that any code in
//			the retrieverow event will slow the retrieval.
//
//////////////////////////////////////////////////////////////////////////////
//	Revision History
//
//	FDG	04/12/01	Stars 4.7.	Add ability to trim the data.
//	GaryR	09/14/01	Track 2430d	PB's Idle() method causes memory corruption.
//	GaryR	10/23/01	Track 2502d	Disable microhelp during retrieval to prevent
//										user messages from executing and causing a GPF.
// MikeF	04/04/02 Track 2947  Replace today() in reports with static date/time
//	GaryR	07/13/04	Track 3971d	Lock all functionality during retrieval
//////////////////////////////////////////////////////////////////////////////

Integer		li_rc

IF	ib_use_retrievemeter			THEN
	SetPointer (Arrow!)
	//	GaryR	10/23/01	Track 2502d
	w_time_microhelp.Enabled = TRUE
	w_main.SetMicroHelp ('Ready')
	gnv_app.of_set_idle ( TRUE )	//	GaryR	09/14/01	Track 2430d
	gnv_app.of_set_lock( FALSE )
	w_master		lw_parent
	li_rc		=	This.of_GetParentWindow (lw_parent)
	IF	IsValid (lw_parent)		THEN
		lw_parent.CloseUserObject (iu_retrievemeter)
	END IF
END IF

//	Multi-selected datawindows should not hilite any rows.
IF	ib_multiselect					THEN
	This.SelectRow (0, FALSE)
END IF

// FDG 04/12/01 - Trim the retrieve data - if necessary
IF	IsValid (inv_trim)		THEN
	li_rc	=	inv_trim.Event	ue_retrieveend (rowcount)
END IF

end event

event sqlpreview;////////////////////////////////////////////////////////////////////////////
//
//	Script:  		u_dw.SQLPreview
//
//	Arguments:		1.	request (type sqlpreviewfunction)
//						2.	sqltype (type sqltype)
//						3.	sqlsyntax (type string) - The SQL passed to the DBMS
//						4. buffer (type dwbuffer)
//						5.	row (type long)
//
//	Returns:  		Integer - Always returns 1
//
//	Description:	If the application is in debug mode, display the SQL using
//						f_debug_box.
//
//-------------------------------------------------------------------------------------//
// Maintenance
//
// MikeFl	4/4/02	Add code to Set a string to current date/time. Put in this event
//							Because RetrieveEnd and Start are often overridden.
//-------------------------------------------------------------------------------------//

IF	gc_debug_mode						THEN
	IF	IsNull (sqlsyntax)			&
	OR	Trim (sqlsyntax)	<	' '	THEN
	ELSE
		// This d/w has SQL.  Display it via f_debug_box.
		f_debug_box ('Display SQL', 'SQL = ' + sqlsyntax + '.')
		f_debug_box ('Display SQL', ' ')		//	Insert a blank line
	END IF
END IF

// MikeFl 4/4/02 - Track 2947 - BEGIN
string 	ls_desc

is_run_date			= string(Today()) + ' ' + left(string(now()),5)

ls_desc = This.describe("st_report_date.text")

IF ls_desc <> "!" THEN 
	This.object.st_report_date.text = is_run_date
END IF
// MikeFl 4/4/02 - Track 2947 - END
end event

on u_dw.create
end on

on u_dw.destroy
end on

event editchanged;/////////////////////////////////////////////////////////////////
//
//	GaryR	09/25/02	SPR 2893d	Text sensitive search in DropDowns
//
/////////////////////////////////////////////////////////////////

//	GaryR	09/25/02	SPR 2893d
IF	IsValid (inv_dropdownsearch)	THEN
	inv_dropdownsearch.Event  ue_EditChanged (row, dwo, data)
END IF
end event

event doubleclicked;//*********************************************************************************
// Script Name:	DoubleClicked
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute the user event ue_dblclick
//
//*********************************************************************************
//
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

This.event ue_dblclick( )
end event

