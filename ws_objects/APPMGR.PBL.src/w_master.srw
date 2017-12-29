$PBExportHeader$w_master.srw
$PBExportComments$Ancestor window
forward
global type w_master from window
end type
end forward

global type w_master from window
string accessiblename = "Untitled "
string accessibledescription = "Untitled"
accessiblerole accessiblerole = windowrole!
integer x = 832
integer y = 356
integer width = 2747
integer height = 1368
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event type integer ue_save ( )
event ue_retrieve ( )
event ue_insert ( )
event ue_delete ( )
event ue_search ( )
event ue_postsearch ( )
event ue_preopen ( )
event ue_postopen ( )
event ue_initialize_window ( )
event type integer ue_presave ( )
event type integer ue_commit_rollback ( boolean ab_switch )
event type integer ue_postsave ( )
event type integer ue_update ( powerobject apo_control[] )
event type integer ue_validation ( powerobject apo_control[] )
event type integer ue_accepttext ( powerobject apo_control[],  boolean ab_focusonerror )
event type integer ue_updatespending ( powerobject apo_control[] )
event type integer ue_preupdate ( )
event type integer ue_postupdate ( powerobject apo_control[] )
event type integer ue_preclose ( )
event type integer ue_begintran ( )
event type integer ue_register_resize ( powerobject apo_control[] )
event ue_security ( )
event type integer ue_predelete ( )
event ue_context_help ( )
event ue_help ( )
event ue_cut ( )
event ue_copy ( )
event ue_paste ( )
event ue_clear ( )
event ue_undo ( )
event ue_print ( )
event ue_printpreview ( )
event ue_printimmediate ( )
event ue_open ( )
event ue_next_row ( )
event ue_prev_row ( )
event type boolean ue_set_window_colors ( powerobject apo_control[] )
event type integer ue_load_ddlb_dw_ops ( dropdownlistbox ddlb_to_load,  string as_ops_item,  string as_arg_items )
event move pbm_move
event ue_controlgotfocus ( dragobject adrg_control )
event type boolean ue_descendant ( )
event ue_dberror ( )
event ue_microhelp ( string as_microhelp )
event type integer ue_preinsert ( )
event ue_display_sql ( )
event type integer ue_display_sql_dw ( powerobject apo_control[] )
event documentation ( )
event type integer ue_get_upperbound ( powerobject apo_control[] )
event type integer ue_reconnect ( powerobject apo_control[] )
event ue_open_rmm ( )
event ue_next_tabpage ( )
event ue_prev_tabpage ( )
event ue_find_print_dw ( powerobject apo_control[] )
event ue_find_st_count ( powerobject apo_control[] )
event ue_set_window_operations ( )
event ue_reset_window_operations ( )
end type
global w_master w_master

type variables
/////////////////////////////////////////////////////////////////////////
//
// 01/05/05 Katie Track 5431c Added local variable for showsql.
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//
/////////////////////////////////////////////////////////////////////////

// Search datawindow object for w_search
Protected		String	is_search_dataobject

// Original Window title
Protected		String	is_orig_title

// Original Window name
Protected		String	is_window_name

// Is the window closing?
Protected		Boolean	ib_closestatus

// Is the window saving?
Protected		Boolean	ib_savestatus

// Display microhelp for d/w columns
Protected		Boolean	ib_microhelp

// Disable the CloseQuery processing?
Protected		Boolean	ib_disableclosequery

// Disable the Resize processing?
Protected		Boolean	ib_disableresize

// Disable setting the window's colors?
Protected		Boolean	ib_disablecolors

// Disable the centering of a response window?
Protected		Boolean	ib_disablecenter

// During the CloseQuery event, did the changed
// data NOT get saved.
Protected		Boolean	ib_changes_not_saved

// Is security being used in this window
Protected		Boolean	ib_security

// DBError Message
Protected		String	is_dberrormsg

// DBError Structure that is passed to w_db_error
Protected		str_db_error	istr_db

// Datawindows that will be updated
Protected		PowerObject  ipo_pendingupdates[]

// Resize service
n_cst_resize	inv_resize

//Sys Cntl service
u_nvo_sys_cntl	inv_sys_cntl

// Select Count(*) service
u_nvo_count	inv_count

// Window preferences service
n_cst_winsrv_preference	inv_preference

// Base window service
n_cst_winsrv	inv_base

// Temp Table window service
n_cst_temp_table		inv_temp_table
// This is autoinstantiated and only contains instance
// variables.
n_cst_temp_table_attrib	inv_temp_attrib

// Query engine service
uo_cst_queryengine	inv_queryengine

// Datawindow to Insert/Delete
Protected		u_dw	idw_update

// Datawindow to Print
Protected		u_dw	idw_print

// Active Datawindow
Protected		u_dw	idw_active

// Transaction object used for commits/rollbacks
Protected		n_tr	itr_trans				// FDG 02/20/01 - change transaction to n_tr

// Help ID
Protected		any		ia_helptypeid

// When resizing windows the gap between the bottom
// right control and the bottom of the window is 
// specified here.
Constant		integer	ii_resize_gap = 10

/* Boolean used in ue_register_resize to determine
   if  controls contained in tab controls should  resize
   with Window */
Protected                 boolean  ib_ResizeTabControls 

// Save unsuccessful message in ue_save
String	is_save_unsuccessful_msg = 'Save was unsuccessful'
String	is_save_successful_msg = 'Data saved successfully!'
String	is_save_no_data_msg = 'There was no data to update'

//Closequery message to save changes.
String	is_closequery_msg = 'Changes have been made to the data.~r~n~r~nDo you want to save the changes?'

// Closequery error message
String	is_closequery_error_msg = 'The information entered does not pass validation and must be corrected before changes can be saved.~r~n~r~nClose without saving changes?'

// Datastore to find the help file name
n_ds	ids_help

// Variables required for Window Operations
String		is_operation
String		is_print_dw_name
GraphicObject	igr_rowcount
Sx_decode_structure istr_decode_struct
W_uo_win	iw_uo_win
string                       is_dw_control

// Array of datastores to be included in the 
// ue_save process
// Call of_register_datastore()  to register a datastore to update
N_ds		ids_update[]
N_ds		ids_pendingupdates[]

// Should sql be showable?  Default false.
Protected		Boolean	ib_show_sql = false
Protected		Boolean	ib_allow_switch = false

//	Prevent close during decode
Boolean	ib_lock_for_decode

//	Does sheet contain popup menu
Protected		Boolean	ib_popup_menu
end variables

forward prototypes
public function string of_get_title ()
public function integer of_updatechecks ()
public function boolean of_getclosestatus ()
public function integer of_setresize (boolean ab_switch)
public function integer of_disable_dws (powerobject apo_control[])
public function integer of_setupdatedw (ref u_dw adw)
public subroutine of_setprintdw (ref u_dw adw)
public subroutine of_settransaction (ref transaction atr_trans)
public function transaction of_gettransaction ()
public function integer of_setbase (boolean ab_switch)
public function integer of_setpreference (boolean ab_switch)
public function integer of_setdberrormsg (string as_msg)
public function boolean of_getsavestatus ()
public function integer of_setdberror (str_db_error astr_db)
public function integer of_setmicrohelp (boolean ab_switch)
public function boolean of_getmicrohelp ()
public function integer of_disable_resize (boolean ab_switch)
public function integer of_disable_colors (boolean ab_switch)
public function integer settransobject (ref datawindow adw, transaction atr_trans)
public function integer of_setsecurity (boolean ab_switch)
public function boolean of_getsecurity ()
public function integer of_set_queryengine (boolean ab_switch)
public function integer of_set_sys_cntl_range (boolean ab_switch)
public function integer of_set_nvo_count (boolean ab_switch)
public function u_dw of_getprintdw ()
public function integer of_disable_center (boolean ab_switch)
public function integer of_set_temp_table (boolean ab_switch)
public function integer of_help (string as_window, string as_function)
public function integer of_help (string as_window)
public function integer of_help ()
public subroutine of_set_st_count (graphicobject arg_control)
public subroutine of_register_datastore (n_ds ads_requestor)
public function integer of_window_operations (datawindow adw_requestor, long al_row, dwobject adwo)
public subroutine of_set_is_operation (string as_operation)
public function boolean of_is_locked ()
public function boolean of_get_showsql ()
public function boolean of_get_allowswitch ()
public function integer of_set_showsql (boolean as_show)
end prototypes

event ue_save;//*********************************************************************
//	Script:	w_master.ue_save
//
//	Arguments:	None
//
//	Returns:	Integer
//	 1	=	Success
//	 0	=	No pending changes
//	-1	=	Accepttext error
//	-2	=	Updatespending error
//	-3	=	Validation error
//	-4	=	ue_preupdate error
//	-5	=	ue_begintran error
//	-6	=	ue_update error
//	-7	=	ue_commit_rollback error
//	-8	=	ue_postupdate error
//	-9	=	ue_presave error
//	-10=	ue_postsave error
//
//	Description:
//		This event will save the data on the window.  Event ue_presave
//		will edit the data before saving.  If an edit error occurs, the
//		save is discontinued.
//
//		Any datawindows that are pending changes are placed into array
//		ipo_pendingupdates[] by event ue_pendingupdates which is 
//		triggered from function of_UpdateChecks().  Only the 
//		datawindows placed in this array will be updated.
//
//*********************************************************************

Integer		li_rc,			&
				li_save_rc,		&
				li_max,			&
				li_i
				
Boolean 		lb_focusonerror

n_ds			lds

MDI_MAIN_FRAME.SetMicroHelp ('Saving the data.  Please wait....')

// Determine whether pfc_AcceptText should perform a SetFocus if an 
//	error is found.
lb_focusonerror = Not ib_closestatus

// Apply the contents of the edit controls to all datawindows.  If this
//	is triggered from the Closequery process, then there is no need
//	to repeat this process.
//IF	ib_closestatus		THEN
//ELSE
	IF This.Event ue_accepttext (This.control, lb_focusonerror)	<	0	THEN
		MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
		Return -1
	END IF
//END IF

//	Perform any necessary edits/updates before saving.
li_rc	=	This.Event ue_presave ()
IF	li_rc	<	0	THEN
	li_rc	=	This.Event ue_commit_rollback (FALSE)
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -9
END IF

//	See if there any updates pending and if they pass standard
//	validation rules.
li_rc	=	This.of_UpdateChecks ()
IF	li_rc	<=	0		THEN
	//	 0 = No pending changes
	//	-1 = Accepttext error
	// -2 = Updatespending error
	// -3 = Validation error
	IF	li_rc	=	0		THEN
		MDI_MAIN_FRAME.SetMicroHelp (is_save_no_data_msg)
	ELSE
		MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	END IF
	Return li_rc
END IF

//	Perform any additional edits before saving.  Any datastores
//	& embedded SQL updates are updated in this event.
li_rc	=	This.Event ue_preupdate ()
IF	li_rc	<>	1	THEN
	li_rc	=	This.Event ue_commit_rollback (FALSE)
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -4
END IF

//	Begin the transaction (if necessary)
li_rc	=	This.Event ue_begintran ()
IF	li_rc	<>	1	THEN
	li_rc	=	This.Event ue_commit_rollback (FALSE)
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -5
END IF

ib_savestatus	=	TRUE		//	Updates are beginning

//	Update all changed datawindows
li_save_rc	=	This.Event ue_update (ipo_pendingupdates)

IF li_save_rc  >=  0  THEN								// FNC 11/17/99 Start
	li_max  =  UpperBound (ids_pendingupdates)
	For li_i  =  1  TO  li_max
		lds			=	ids_pendingupdates[li_i]
		li_save_rc	=	lds.EVENT ue_Update(True, False)
		IF  li_save_rc  <  0  THEN
			Exit
		END IF
	NEXT
END IF													// FNC 11/17/99 End

ib_savestatus	=	FALSE		//	Updates are done

//	Commit or rollback the data depending on if the updates 
//	were successful
IF	li_save_rc	>	0	THEN
	li_rc	=	This.Event ue_commit_rollback (TRUE)
ELSE
	li_rc	=	This.Event ue_commit_rollback (FALSE)
END IF

IF	li_save_rc	<>	1	THEN
	// Update process failed
	IF	Len(is_dberrormsg)	>	0		THEN
		This.Event	ue_dberror()
	END IF
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -6
END IF

IF	li_rc	<>	1	THEN
	// Commit/rollback process failed
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -7
END IF

//	Reset the datawindow update attributes passing the
//	window's control array
li_rc	=	This.Event ue_postupdate (ipo_pendingupdates)

IF	li_rc	<>	1	THEN
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -8
END IF

//	Perform any additional post-save processing here
li_rc	=	This.Event ue_postsave ()

IF	li_rc	<>	1	THEN
	MDI_MAIN_FRAME.SetMicroHelp (is_save_unsuccessful_msg)
	Return -10
END IF

MDI_MAIN_FRAME.SetMicroHelp (is_save_successful_msg)

//	Reset any data on the window (i.e. window title)
This.Event ue_initialize_window()

Return 1
end event

event ue_insert;//*********************************************************************
//	Script:	w_master.ue_insert
//
//	Description:
//		This event will insert data on the specified datawindow.
//
//*********************************************************************

Long		ll_row
Integer	li_rc

li_rc	=	This.Event	ue_preinsert()

IF	li_rc	<	0		THEN
	Return
END IF

//	If the update d/w is set, insert a row into it.
IF	IsValid (idw_update)		THEN
	ll_row	=	idw_update.InsertRow(0)
	idw_update.ScrollToRow (ll_row)
END IF

//	Reinitialize the desired data and attributes for this window
This.Post Event ue_initialize_window()

end event

event ue_delete;//************************************************************************
//	Script:	w_master.ue_Delete 
//
//	Description:	Delete a row in the appropriate d/w.
//
//************************************************************************

Integer		li_rc,		&
				li_msg
Long			ll_row

//	Any necessary edits are placed in ue_predelete.
li_rc	=	This.Event ue_PreDelete ()

IF	li_rc	<	1		THEN
	Return
END IF

li_msg	=	MessageBox ( 'Stars', &
				'Are you sure you want to delete this data?', &
				Exclamation!, YesNo!)

CHOOSE CASE li_msg
	CASE 1
		//	Yes - Delete the row
	CASE 2
		// No - Cancel the deletion
		Return
END CHOOSE
				
IF	IsValid (idw_update)		THEN
	idw_update.DeleteRow (0)
		//	ib_singlerow is set by calling of_set_SingleRow (TRUE)
		//	If you are deleting a row in a d/w that only retrieves 1 row,
		//	then update the d/w and trigger ue_search to get another row of
		//	data.
	IF	idw_update.of_GetSingleRow()	=	TRUE		THEN
		li_rc	=	This.Event	ue_save ()
		IF	li_rc	>	0		THEN
			MDI_MAIN_FRAME.SetMicroHelp ('Data deleted successfully')
		END IF
	END IF
END IF



end event

event ue_search;//*********************************************************************
//	Script:	w_master.ue_search
//
//	Description:
//		Open the search object passing a datawindow object
//
//*********************************************************************

//	If there is no search d/w object, then get out.
IF	Trim (is_search_dataobject)	<	' '	THEN
	Return
END IF

//OpenWithParm (w_search, is_search_dataobject)

// w_search returns the ID of the selected row here
// Extend your descendant script to process the
// return value.

end event

event ue_postopen;//*********************************************************************
//	Script:	w_master.PostOpen
//
//	Description:
//		The logic to retrieve the initial data for the window is
//		usually done here.  After retrieving the data trigger the
//		ue_initialize_window event to initialize the window.
//
//*********************************************************************

This.Post Event ue_initialize_window ()

end event

event ue_initialize_window;//*********************************************************************
//	Script:	w_master.ue_initialize_window
//
//	Description:
//		This event is triggered after the data is retrieved, saved, 
//		and inserted.  Logic is placed here to protect/unprotect key
//		columns, setting focus to the appropriate location, and
//		resetting the window's title (The original window title is
//		accessed by calling of_get_title.
//
//*********************************************************************


end event

event ue_presave;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_presave
//
//	Arguments:	None
//
//	Returns:   integer
//	 1 = successful
//	-1 = unsuccessful - Discontinue the save process
//
//	Description:
//		This event is triggered by the ue_save event and will execute
//		before any of the datawindows are updated.
//
//		Perform any edits and d/w changes here.  If the edits fail,
//		return -1.
//
//////////////////////////////////////////////////////////////////////////////

Return 1

end event

event ue_commit_rollback;//*********************************************************************
//	Script:	w_master.ue_commit_rollback
//
//	Description:
//		This event will either commit or rollback the changes
//		depending on the input flag.
//
//*********************************************************************
//	History
//
//	FDG	02/18/98	Always Commit/rollback for both Stars1ca & Stars2ca.
//
//*********************************************************************


IF	IsNull (ab_switch)	THEN
	Messagebox("Error Commiting Changes", "ue_commit_rollback does not know whether to" + &
					" COMMIT or to ROLLBACK")
	Return -1
END IF

IF	ab_switch	THEN
	// Commit both Stars1ca & Stars2ca
	COMMIT	Using	Stars1ca;
	COMMIT	Using	Stars2ca;
ELSE
	// Rollback both Stars1ca & Stars2ca
	Stars2ca.of_rollback()
	Stars1ca.of_rollback()
END IF

Return 1

end event

event ue_postsave;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_postsave
//
//	Arguments:	None
//
//	Returns:   integer
//	 1 = successful
//	-1 = unsuccessful - Discontinue the save process
//
//	Description:
//		This event is triggered after the save has completed successfully.
//
//		Perform any post-save processing here.  It is important to note that
//		event ue_initialize_window is also triggered after the save is
//		successful (it is also triggered after the window is opened and after
//		data is inserted).
//
//////////////////////////////////////////////////////////////////////////////

Return 1

end event

event ue_update;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_update
//
//	Arguments:
//	apo_control   Array of controls that need to be updated
//
//	Returns:   integer
//	 1 = all updates successful
//	-1 = At least one update failed
//
//	Description:
//	Updates the specified array of controls
//
//	Note:
//	This function will update datawindows in the order
//	in which they are found in the array.  
//
// History:
//
//	11/17/99	FNC	Add code to update datastores.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_max, li_i, li_rc
Integer		li_dwtype
DataWindow	ldw_dw
u_dw 			ldw_u_dw
powerobject lpo_changed 

li_max = This.Event	ue_get_upperbound (apo_control)

For li_i = 1 to li_max
	IF	IsValid ( apo_control[li_i] )		THEN
		lpo_changed = apo_control[li_i]
		If lpo_changed.TypeOf () = DataWindow! Then 
			ldw_dw = lpo_changed
			ldw_u_dw = ldw_dw
			// See if the d/w is inherited from u_dw
			IF	ldw_dw.TriggerEvent ("ue_descendant")	=	1	THEN
				//	The d/w is inherited from u_dw		
				// ue_update event, check rc.
				li_rc = ldw_u_dw.Event ue_update (True, False)
				If li_rc < 0 Then 
					Return li_rc
				END IF
			ELSE
				// This is not inherited, Update, check rc.
				li_rc = ldw_dw.Update (True, False)
				If li_rc < 0 Then 
					Return li_rc
				END IF
			END IF
		End If
	END IF
Next

Return 1
end event

event ue_validation;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_validation
//
//	Arguments:		
//	apo_control   Array of controls that need validation.
//
//	Returns:  integer
//	 1 = success (no errors found)
//	-1 = An error was found during validation
//
//	Description:
//		Perform validation for specified powerobject array.
//
//	Note:	 
//	This event is called recursively to handle tab controls and user objects.
//	This script can be extended to check for other objects.
//////////////////////////////////////////////////////////////////////////////

Any			la_rc
Integer		li_max
Integer		li_i
Integer		li_rc
Integer		li_dwtype
DataWindow	ldw_dw
u_dw 			ldw_u_dw
UserObject	luo_uo
tab			ltab_tab

// Get the number of objects
li_max = This.Event	ue_get_upperbound (apo_control)

// Loop thru the objects
For li_i = 1 to li_max
	
	IF	IsValid ( apo_control[li_i] )		THEN
	
		Choose Case TypeOf ( apo_control[li_i] )
	
			Case Tab!
				// Test for Tab Controls (which contain TabPages which may contain datawindows)
				ltab_tab = apo_control[li_i]
				li_rc = This.Event ue_validation ( ltab_tab.control ) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case UserObject!
				// Test for UserObjects (which may contain datawindows)
				luo_uo = apo_control[li_i]
				li_rc = This.Event ue_validation ( luo_uo.control ) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case DataWindow!
				ldw_dw	=	apo_control[li_i]
	
				// See if the d/w was inherited from u_dw
				IF	ldw_dw.TriggerEvent ("ue_descendant")	=	1		THEN
					// This d/w was inherited from u_dw
					// Perform Validation, check rc.
					ldw_u_dw	=	ldw_dw	
					li_rc = ldw_u_dw.Event ue_validation ()
					If li_rc < 0 Then 
						Return -1
					END IF
				ELSE		
					// This d/w was not inherited from u_dw
					// Perform Dynamic Validation (if any), check rc.
					//la_rc = ldw_dw.Event Dynamic ue_validation ()
					If ClassName(la_rc) = 'integer' or ClassName(la_rc)='long' Then
						If la_rc < 0 Then 
							Return -1
						END IF
					END IF
				END IF
		End Choose 
	END IF			// If IsValid (...)
Next

// All validation was successful
Return 1

end event

event ue_accepttext;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_AcceptText
//
//	Arguments:
//	apo_control   Array of controls to check for DataWindows to accepttext
//	ab_focusonerror   Should focus be set to DW in error
//
//	Returns:  integer
//	 1 = accepttext successful, no errors found
//	-1 = An error was found
//
//	Description:	 Perform an AcceptText on all datawindows found on the specified array
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

// Get the number of objects
li_max = This.Event	ue_get_upperbound (apo_control)

// Loop thru the objects
For li_i = 1 to li_max
	
	IF	IsValid ( apo_control[li_i] )		THEN
		
		Choose Case TypeOf ( apo_control[li_i] )
	
			Case Tab!
				// Test for Tab Controls (which contain TabPages which may contain datawindows)
				ltab_tab = apo_control[li_i]
				li_rc = This.Event ue_AcceptText ( ltab_tab.control, ab_FocusOnError ) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case UserObject!
				// Test for UserObjects (which may contain datawindows)
				luo_uo = apo_control[li_i]
				li_rc = This.Event ue_AcceptText ( luo_uo.control, ab_FocusOnError ) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case DataWindow!
				ldw_dw = apo_control[li_i]
				// Perform AcceptText, check rc
				la_rc = ldw_dw.AcceptText()
				If la_rc < 0 Then 
					If ab_FocusOnError Then 
						ldw_dw.SetFocus()
					END IF
					Return -1
				End If
		End Choose 
	END IF		// If IsValid(...)
Next

// All AcceptText were successful
Return 1

end event

event ue_updatespending;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_UpdatesPending
//
//	Arguments:
//	apo_control  array of controls to check for any updates pending
//
//	Returns:  integer
//	 1 = updates are pending (no errors found)
//	 0 = No updates pending (no errors found)
//	-1 = error
//
//	Description:
//		Check for any unsaved datawindows. 
//
//		Any datawindows that are pending changes are placed into array
//		ipo_pendingupdates[].  Only the datawindows placed in this
//		array will be updated.
//
//	Note:
//		This script can be extended to check for other objects which
//		have updates pending
//	
//		This event is called recursively to handle tab controls and UserObjects
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_dwtype, li_max, li_controlcnt, li_i, li_rc
Boolean		lb_updatespending = False,		&
				lb_switch
UserObject	luo_uo
tab			ltab_tab
DataWindow 	ldw_dw
u_dw 			ldw_u_dw


li_controlcnt = This.Event	ue_get_upperbound (apo_control)

// Loop around all controls
For li_i = 1 to li_controlcnt
	// Get the bounds of the pending changes, so it can be added to
	// (This function can be called recursively)
	li_max = UpperBound (ipo_pendingupdates)  

	// Initialize
	lb_updatespending=False
	
	IF	IsValid ( apo_control[li_i] )		THEN
 
		Choose Case TypeOf ( apo_control[li_i] )
	
			Case Tab!
				// Test for tab controls (which contain TabPages which may contain DataWindows)
				ltab_tab = apo_control[li_i]
				li_rc = This.Event ue_updatespending ( ltab_tab.control ) 
				If li_rc < 0 Then 
					Return li_rc
				END IF
	
			Case UserObject!
				// Test for UserObjects (which may contain DataWindows)
				luo_uo = apo_control[li_i]
				li_rc = This.Event ue_updatespending ( luo_uo.control ) 
				If li_rc < 0 Then 
					Return li_rc
				END IF
	
			Case DataWindow!
				// Test for DataWindows
				ldw_dw	=	apo_control[li_i]
		
				// See if the d/w was inherited from u_dw
				//lb_switch	=	ldw_dw.Dynamic	Event ue_descendant ()
				If ldw_dw.TriggerEvent ("ue_descendant")	=	1	Then
					// Inherited from u_dw
					ldw_u_dw	=	ldw_dw
					li_rc = ldw_u_dw.Event ue_UpdatesPending() 
					If li_rc < 0 Then 
						Return -1
					END IF
					lb_updatespending = (li_rc >= 1)				
				Else
					// Non Inherited DataWindow.
					lb_updatespending = (ldw_dw.ModifiedCount() + ldw_dw.DeletedCount() >= 1)
				End If
	
				// If Updates are Pending, add the datawindow to list.
				// Note: For linked DataWindows only the root is stored.  All of the
				//		DataWindows are processed but the process is always started with 
				//		the root	datawindow.
				If lb_updatespending Then
					li_max ++
					ipo_pendingupdates[li_max] = ldw_dw
				End If
		End Choose	
	END IF			// If IsValid (...)
Next

If UpperBound (ipo_pendingupdates) > 0 Then 
	// Updates are pending
	Return 1
End If

// No updates pending
Return 0

end event

event ue_preupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_preupdate
//
//	Arguments:	None
//
//	Returns:   integer
//	 1 = successful
//	-1 = unsuccessful - Discontinue the save process
//
//	Description:
//		This event is triggered by the ue_save event and will execute
//		before any of the datawindows are updated, but after the ue_presave
//		event and after the datawindows are validated.
//
//		Perform any updates to datastores here.  If you must update any
//		data on a datawindow, update it in the ue_presave event.
//
//////////////////////////////////////////////////////////////////////////////

Return 1

end event

event ue_postupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_postupdate
//
//	Arguments:  none
//
//	Returns:  integer 
//	 1 = success
//	-1 = fail
//
//	Description:
//		Resets the datawindow update flags on a successful save
//
// History:
//
// 11/17/99	FNC	 Update datastore update flags
//////////////////////////////////////////////////////////////////////////////

Integer 		li_max, li_i, li_rc=1
Integer		li_dwtype
DataWindow 	ldw_dw
powerobject	lpo_changed

li_max = This.Event	ue_get_upperbound (apo_control)

For li_i = 1 to li_max
	IF	IsValid ( apo_control[li_i] )		THEN
		lpo_changed = apo_control[li_i]
		If lpo_changed.TypeOf () = DataWindow! Then 
			ldw_dw = lpo_changed
			li_rc = ldw_dw.ResetUpdate( )
			If li_rc <> 1 Then Exit
		End If
	END IF
Next

IF li_rc  =  1  THEN										// FNC 11/17/99 Start
	Li_max  =  UpperBound (ids_pendingupdates)
	For li_i  =  1  TO  li_max
		Li_rc  = ids_pendingupdates[li_i].ResetUpdate()
		IF  li_rc  <> 1  THEN
			Exit
		END IF
	NEXT
END IF														// FNC 11/17/99 End

Return li_rc

end event

event ue_preclose;//*********************************************************************
//	Script:	w_master.preclose
//
//	Description:
//		This event is triggered from the closequery event before the
//		closequery edits occured.  If this event returns a value
//		other than 1, then the window will not close.
//
//*********************************************************************

Return 1
end event

event ue_begintran;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_begintran
//
//	Arguments:	None
//
//	Returns:   integer
//	 1 = successful
//	-1 = unsuccessful - Discontinue the save process
//
//	Description:
//		This event is triggered by the ue_save event and will execute
//		before any of the datawindows are updated.
//
//		Begin the transaction (if necessary).
//		
//
//////////////////////////////////////////////////////////////////////////////

Return 1

end event

event ue_register_resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_Register_Resize
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
w_master		lw_window

//	If the resize service is not instantiated, get out.
IF	NOT IsValid (inv_resize)	THEN
	Return -1
END IF

// Get the number of objects
li_max = This.Event	ue_get_upperbound (apo_control)

// Loop thru the objects
For li_i = 1 to li_max
	
	IF	IsValid ( apo_control[li_i] )		THEN
		// Register the control
		This.inv_resize.of_Register (apo_control[li_i], 'Scale')
	
		// Tabs and user objects have controls within them
		Choose Case TypeOf ( apo_control[li_i] )
	
			Case Tab!
				//test if resize of controls within Tabs is 'enabled.'
				IF ib_ResizeTabControls THEN
					// Test for Tab Controls (which contain TabPages which may contain controls)
					ltab_tab = apo_control[li_i]
					li_rc = This.Event ue_Register_Resize (ltab_tab.control) 
					If li_rc < 0 Then 
						Return -1
					END IF
				END IF
	
			Case UserObject!
				// Test for UserObjects (which may contain controls)
				luo_uo = apo_control[li_i]
				li_rc = This.Event ue_Register_Resize (luo_uo.control) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
		End Choose 
	END IF
Next

// All Registration of Controls were successful
Return 1

end event

event ue_security;
//	If security is not set for this window (default is false),
//	then get out.  To enable security, code the following in
// the ue_preopen event:	This.of_setsecurity(TRUE)
IF	This.of_getsecurity()	=	TRUE		THEN
ELSE
	Return
END IF

//IF gnv_app.of_get_security_level() >= 12 THEN
//	m_stars_30.m_admin.Enabled = True
//	m_stars_30.m_data.m_deleterecord.Enabled	=	TRUE
//ELSE
//	m_stars_30.m_admin.Enabled = False
//	m_stars_30.m_data.m_deleterecord.Enabled	=	FALSE
//END IF

//IF gnv_app.of_get_read_only() = True	THEN
//	//	Disable the menu items, commandbuttons, and datawindows that
//	// can be used to update data.
//	m_stars_30.m_data.m_insert.Enabled = False
//	m_stars_30.m_data.m_updatedatabase.Enabled = False
//	m_stars_30.m_data.m_deleterecord.Enabled = False
//	This.of_disable_dws (This.Control)
//END IF

end event

event ue_predelete;//************************************************************************
//	Script:	w_master.ue_PreDelete 
//
//	Returns:	Integer
//				-1 = Don't proceed with the delete
//				 1 = Edits successful - Proceed with the delete.
//
//	Description:	This event is triggered before data is deleted from
//						a datawindow.  
//
//************************************************************************

Return 1

end event

event ue_context_help;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_context_help
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//		Determine the column clicked on the datawindow.  Once determined,
//		a messagebox will display the column's comments from the PowerBuilder
//		extended attributes (which is stored in pbcatcol).
//
//////////////////////////////////////////////////////////////////////////////

String			ls_table,		&
					ls_column,		&
					ls_dw_column,	&
					ls_header,		&
					ls_comment
Integer			li_dot
GraphicObject	lgo_focus
u_dw				ldw
u_cb				lcb

//	Get the object that has focus.  If it is not a d/w, get out.

lgo_focus	=	GetFocus ()

CHOOSE CASE TypeOf (lgo_focus)
	CASE	DataWindow!
		ldw	=	lgo_focus
	CASE	CommandButton!, Checkbox!, DropDownListBox!,							&
			DropDownPictureListBox!, EditMask!, Graph!, ListBox!,				&
			ListView!, MultiLineEdit!, OLEObject!, Picture!,					&
			PictureButton!, PictureListBox!, RadioButton!, RichTextEdit!,	&
			SingleLineEdit!, Tab!, TreeView!, Window!
		IF	Trim (lgo_focus.Tag)	>	' '			THEN
			MessageBox ('About ' + String (TypeOf (lgo_focus) ), lgo_focus.tag)
		END IF
		Return
	CASE ELSE
		Return
END CHOOSE


//	Get the column and table name from the d/w

ls_dw_column	=	ldw.GetColumnName()
ls_column		=	ldw.Describe (ls_dw_column + ".dbName")

li_dot			=	Pos (ls_column, '.')
ls_table			=	Left (ls_column, li_dot - 1)
ls_column		=	Mid (ls_column, li_dot + 1)

//	Get the column description from the PB extended attributes

//SELECT	pbcatcol.pbc_hdr,
//			pbcatcol.pbc_cmnt
//INTO		:ls_header,
//			:ls_comment
//FROM		pbcatcol
//WHERE		pbcatcol.pbc_tnam	=	:ls_table
//AND		pbcatcol.pbc_cnam	=	:ls_column
//USING		itr_trans	;
//
//SQLCA.of_check_status()

IF	IsNull (ls_comment)			&
OR Trim (ls_comment) < ' '		THEN
	ls_header	=	ls_column
	ls_comment	=	'No description defined'
END IF

MessageBox ('About ' + ls_header, ls_comment)



end event

event ue_help;//*********************************************************************
//	Script:	w_master.ue_help
//
//	Description:
//		Display the help file for this application (if one exists).
//
//*********************************************************************

String	ls_helpfile,		&
			ls_helptypeid
Long		ll_helptypeid

IF	IsValid (inv_base)		THEN
	ls_helpfile	=	inv_base.of_gethelpfile()
ELSE
	ls_helpfile	=	ProfileString ( gv_ini_path + 'STARS.INI', 'carrier', 'HelpPath', '') + &
						'starshlp.hlp'
END IF

IF	Len ( Trim (ls_helpfile) )	>	0	THEN
	ShowHelp (ls_helpfile, Index!)
END IF

//IF	Len ( Trim (ls_helpfile) )	>	0	THEN
//	IF	Lower (Classname (ia_helptypeid))	=	'long'	THEN
//		ll_helptypeid	=	ia_helptypeid
//		ShowHelp (ls_helpfile, Topic!, ll_helptypeid)
//	ELSEIF	Lower (Classname (ia_helptypeid))	=	'string'	THEN
//		ls_helptypeid	=	ia_helptypeid
//		ShowHelp (ls_helpfile, Keyword!, ls_helptypeid)
//	ELSE
//		ShowHelp (ls_helpfile, Keyword!, "")
//	END IF
//END IF

end event

event ue_cut;//*********************************************************************
//	Script:	w_master.ue_cut
//
//	Description:
//		Cut the contents of the object that has focus to the Clipboard.
//
//*********************************************************************

GraphicObject ldo_HasFocus

ldo_HasFocus = GetFocus()

If NOT Isvalid(ldo_HasFocus) Then Return

Choose Case TypeOf(ldo_HasFocus)

	Case DataWindow!
		datawindow ldw_focus
		ldw_focus = ldo_HasFocus
		ldw_focus.Cut()

	Case DropDownListBox!
		dropdownlistbox lddlb_focus
		lddlb_focus = ldo_HasFocus
		lddlb_focus.Cut()

	Case EditMask!
		editmask lem_focus
		lem_focus = ldo_HasFocus
		lem_focus.Cut()

	Case MultiLineEdit!
		multilineedit lmle_focus
		lmle_focus = ldo_HasFocus
		lmle_focus.Cut()

	Case SingleLineEdit!
		singlelineedit lsle_focus
		lsle_focus = ldo_HasFocus
		lsle_focus.Cut()

End Choose

end event

event ue_copy;//*********************************************************************
//	Script:	w_master.ue_copy
//
//	Description:
//		Copy the contents of the object that has focus to the Clipboard.
//
//*********************************************************************

GraphicObject ldo_HasFocus

ldo_HasFocus = GetFocus()

If NOT Isvalid(ldo_HasFocus) Then Return

Choose Case TypeOf(ldo_HasFocus)

	Case DataWindow!
		datawindow ldw_focus
		ldw_focus = ldo_HasFocus
		ldw_focus.Copy()

	Case DropDownListBox!
		dropdownlistbox lddlb_focus
		lddlb_focus = ldo_HasFocus
		lddlb_focus.Copy()

	Case EditMask!
		editmask lem_focus
		lem_focus = ldo_HasFocus
		lem_focus.Copy()

	Case MultiLineEdit!
		multilineedit lmle_focus
		lmle_focus = ldo_HasFocus
		lmle_focus.Copy()

	Case SingleLineEdit!
		singlelineedit lsle_focus
		lsle_focus = ldo_HasFocus
		lsle_focus.Copy()

End Choose

end event

event ue_paste;//*********************************************************************
//	Script:	w_master.ue_paste
//
//	Description:
//		Paste the contents in the Clipboard to the object that has focus.
//
//*********************************************************************

GraphicObject ldo_HasFocus

ldo_HasFocus = GetFocus()

If NOT Isvalid(ldo_HasFocus) Then Return

Choose Case TypeOf(ldo_HasFocus)

	Case DataWindow!
		datawindow ldw_focus
		ldw_focus = ldo_HasFocus
		ldw_focus.Paste()

	Case DropDownListBox!
		dropdownlistbox lddlb_focus
		lddlb_focus = ldo_HasFocus
		lddlb_focus.Paste()

	Case EditMask!
		editmask lem_focus
		lem_focus = ldo_HasFocus
		lem_focus.Paste()

	Case MultiLineEdit!
		multilineedit lmle_focus
		lmle_focus = ldo_HasFocus
		lmle_focus.Paste()

	Case SingleLineEdit!
		singlelineedit lsle_focus
		lsle_focus = ldo_HasFocus
		lsle_focus.Paste()

End Choose

end event

event ue_clear;//*********************************************************************
//	Script:	w_master.ue_clear
//
//	Description:
//		Clear the contents of the object that has focus.
//
//*********************************************************************

GraphicObject ldo_HasFocus

ldo_HasFocus = GetFocus()

If NOT Isvalid(ldo_HasFocus) Then Return

Choose Case TypeOf(ldo_HasFocus)

	Case DataWindow!
		datawindow ldw_focus
		ldw_focus = ldo_HasFocus
		ldw_focus.Clear()

	Case DropDownListBox!
		dropdownlistbox lddlb_focus
		lddlb_focus = ldo_HasFocus
		lddlb_focus.Clear()

	Case EditMask!
		editmask lem_focus
		lem_focus = ldo_HasFocus
		lem_focus.Clear()

	Case MultiLineEdit!
		multilineedit lmle_focus
		lmle_focus = ldo_HasFocus
		lmle_focus.Clear()

	Case SingleLineEdit!
		singlelineedit lsle_focus
		lsle_focus = ldo_HasFocus
		lsle_focus.Clear()

End Choose

end event

event ue_undo;//*********************************************************************
//	Script:	w_master.ue_undo
//
//	Description:
//		Undo the last changes made to the object that has focus.
//
//*********************************************************************

GraphicObject ldo_HasFocus

ldo_HasFocus = GetFocus()

If NOT Isvalid(ldo_HasFocus) Then Return

Choose Case TypeOf(ldo_HasFocus)

	Case DataWindow!
		datawindow ldw_focus
		ldw_focus = ldo_HasFocus
		ldw_focus.Undo()

	Case EditMask!
		editmask lem_focus
		lem_focus = ldo_HasFocus
		lem_focus.Undo()

	Case MultiLineEdit!
		multilineedit lmle_focus
		lmle_focus = ldo_HasFocus
		lmle_focus.Undo()

	Case SingleLineEdit!
		singlelineedit lsle_focus
		lsle_focus = ldo_HasFocus
		lsle_focus.Undo()

End Choose

end event

event ue_print;//*********************************************************************
//	Script:	w_master.ue_print

//
//	Description:
//		Calls FX_M_Print. This event is used by a descendent window that does
//		not want to open the print cols window.
//*********************************************************************

fx_m_print()

//u_dw	ldw
//
//IF	IsValid (idw_print)	THEN
//	ldw	=	idw_print
//	OpenWithParm (w_print_options, ldw)
//	Return
//END IF
//
////	Printable d/w not found, set if the object that has focus is a d/w.
//
//GraphicObject ldo_focus
//
//ldo_focus	=	GetFocus()
//
//IF	NOT	IsValid (ldo_focus)		THEN
//	Return
//END IF
//
//CHOOSE CASE TypeOf (ldo_focus)
//
//	CASE DataWindow!
//		ldw	=	ldo_focus
//		OpenWithParm (w_print_options, ldw)
//
//END CHOOSE

	
end event

event ue_printpreview;//*********************************************************************
//	Script:	w_master.ue_printpreview
//
//	Description:
//		Open the print zoom window for the datawindow that has focus.
//		If idw_print has been set, then use this d/w instead.
//
//*********************************************************************

//u_dw	ldw
//
//IF	IsValid (idw_print)	THEN
//	ldw	=	idw_print
//	OpenWithParm (w_printzoom, ldw)
//	Return
//END IF
//
////	Printable d/w not found, set if the object that has focus is a d/w.
//
//GraphicObject ldo_focus
//
//ldo_focus	=	GetFocus()
//
//IF	NOT	IsValid (ldo_focus)		THEN
//	Return
//END IF
//
//CHOOSE CASE TypeOf (ldo_focus)
//
//	CASE DataWindow!
//		ldw	=	ldo_focus
//		OpenWithParm (w_printzoom, ldw)
//
//END CHOOSE

	
end event

event ue_printimmediate;//*********************************************************************
//	Script:	w_master.ue_printimmediate
//
//	Description:
//		Print the datawindow that has focus.
//		If idw_print has been set, then print this d/w instead.
//
//*********************************************************************

u_dw	ldw

IF	IsValid (idw_print)	THEN
	ldw	=	idw_print
	ldw.Print()
	Return
END IF

//	Printable d/w not found, set if the object that has focus is a d/w.

GraphicObject ldo_focus

ldo_focus	=	GetFocus()

IF	NOT	IsValid (ldo_focus)		THEN
	Return
END IF

CHOOSE CASE TypeOf (ldo_focus)

	CASE DataWindow!
		ldw	=	ldo_focus
		ldw.Print()

END CHOOSE

	
end event

event type boolean ue_set_window_colors(powerobject apo_control[]);//*******************************************************************
//
// UE_SET_WINDOW_COLORS - This event is used to allow the STARS
//		user to override the STARS default colors.
//	USAGE: One argument is sent, this is the control array.
//		This function must be called at the top of the open script of
//			If a dynamic datawindow is used in the system,
//			this function should be called after the datawindow object		
//			is assigned.  The function returns TRUE if it operated OK or
//			FALSE if an error was encountered.
//			If you wish to have a control retain its coded color, you may
//			set the controls tagvalue to "colorfixed" and the color will
//			not be set by this function.
//			Other tag values cn be used to set colors.  Tag values are
//			processed more quickly than the default processing.
//		EX: This.Event UE_SET_WINDOW_COLORS(This.Control)
//
//	SUMMARY: On first use this function loads color values from the INI
//		file, or defaults if no colors were saved prior.
//		It then looks at the window sent and adjusts the color of all
//		controls.
// COLOR PROCESSING:  For each control on the window:
//		IF tag value of control = COLORFIXED skip to next control
//		IF tag value contains LOOKUP 
//			set to lookup colors goto next control
//		IF tag value contains PROTECT 
//			set to protected colors goto next control
//		IF StaticText or SinglelineEdit and border = raised
//			set colors to protected colors (text and background
//		IF RadioButton or CheckBox or StaticText or Groupbox
//			set colors to label colors (text and background)
//		IF SinglelineEdit or DropDownList or MultiLineEdit or ListBox or editmask
//			set colors to input colors (text and Background)
//		IF Datawindow 
//			If not freeform datawindow or dw Tag = LISTDATAWINDOW
//				set colors to Datawindow color (background only)
//			else
//				set the color of each control on the datawindow to				
//				the appropriate color for that control.  
//				Labels are set to the label color and columns are
//					set to the input color.
//				If the tag value of an individual datawindow
//					column is LOOKUP then the lookup color is used.
//				If the tag value of an individual datawindow
//					column is PROTECT then the Protected colors are used.
//		Set window background to window Background color
//
//*************************************************************************
//
// FDG	06-10-97 Move fx_set_window_colors to this event.  Include the
//						handling of custom user objects and tab controls by
//						triggering this event recursively.
// FNC	11-25-96 Prob #173 STARS35 Set group box to window color.
// FNC	11-22-96 Prob #173 STARS35 Don't check use_colors if file 			
//						does not exist. Only check if it does exists and
// 					then if it is set to false return a false to the 
//						calling program. 
//	FDG	09/27/95	Removed UpperBound from the loop.
//	FDG	07/18/96	Replace external functions with NVO GAPI.
//	FDG	05/05/98	Track 1184.  If a datawindow column has a "NOCOLOR" tag,
//						then don't change the color of the column.  The properties
//						in the datawindow object's column will perform this.
//	FDG	01/04/99	Track 1997.  If a datawindow column has an edit style of
//						radiobutton, that don't change the color of the column.
//						Also, don't try to change colors for non-existant
//						column headers.
// GaryR	11/01/2000	2920c	Standardize windows colors
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*************************************************************************

//Boolean			lb_switch
//
//RadioButton 	rb_control
//CheckBox			cbx_control
//StaticText		st_control
//Window 			window_control
//GroupBox			gbx_control
//listbox			lbx_control
//MultiLineEdit  mle_control
//SingleLineEdit sle_control
//EditMask			em_control
//DropDownListBox ddlb_control
//DataWindow 		dw_control
//Tab				tab_control
//UserObject		user_control
//Integer			li_cntl
//Long       		ll_max_curr_control
//integer 			li_num_of_columns,		&
//					li_ctr,						&
//					li_rc
//String			ls_col_name,				&
//					ls_col_tag,					&
//					ls_dddwdatacolumn,		&
//					ls_col_hdr,					&
//					ls_hdr_attributes,		&
//					ls_rb_columns
//DataWindowChild	ldwc
//
//setpointer(hourglass!)
//
//IF IsNull( SQLCA.LogId ) OR Trim( SQLCA.LogId ) = "" THEN RETURN FALSE //GaryR	11/01/2000	2920c
//
//ll_max_curr_control	=	This.Event	ue_get_upperbound (apo_control)
//
//for li_cntl = 1 to ll_max_curr_control
//	
//	IF	IsValid ( apo_control[li_cntl] )		THEN
//	
//		// this case section will process colors based on stars defaults
//		//  or tag values if set.
//		CHOOSE Case	 (apo_control[li_cntl].TypeOf() )
//				
//		CASE Tab!
//			tab_control	=	apo_control[li_cntl]
//			// Call this event recursively to get all the controls in this
//			//	tab object.
//			lb_switch	=	This.Event	ue_set_window_colors (tab_control.Control)
//				
//		CASE UserObject!
//			user_control	=	apo_control[li_cntl]
//			// Call this event recursively to get all the controls in this
//			//	user object.
//			lb_switch	=	This.Event	ue_set_window_colors (user_control.Control)
//				
//		CASE RadioButton!
//			rb_control = apo_control[li_cntl]
//			if match(upper(rb_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			rb_control.backcolor = stars_colors.label_back
//			rb_control.textcolor = stars_colors.label_text	
//	
//		CASE CheckBox!
//			cbx_control = apo_control[li_cntl]
//			if match(upper(cbx_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			cbx_control.backcolor = stars_colors.label_back
//			cbx_control.textcolor = stars_colors.label_text	
//		
//		CASE StaticText!
//			st_control = apo_control[li_cntl]
//			if match(upper(st_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			if match(upper(st_control.tag),"LOOKUP") then 
//				st_control.backcolor = stars_colors.lookup_back 
//				st_control.textcolor = stars_colors.lookup_text
//			ELSE
//				IF match(upper(st_control.tag),"PROTECT") then 
//					st_control.backcolor = stars_colors.protected_back
//					st_control.textcolor = stars_colors.protected_text
//				else
//					st_control.backcolor = stars_colors.label_back
//					st_control.textcolor = stars_colors.label_text
//				end if
//			end if
//			
//		CASE GroupBox!
//			gbx_control = apo_control[li_cntl]
//			if match(upper(gbx_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			gbx_control.backcolor = stars_colors.button_face		//11-25-96 FNC
//		
//		CASE DataWindow!
//			dw_control = apo_control[li_cntl]
//			if match(upper(dw_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			dw_control.SetRedraw (FALSE)
//			// Do colors for individual controls in freeform DW only
//			if dw_control.Describe('datawindow.processing') <> "0" then
//				// not free form datawindow - List Datawindow
//				dw_control.Modify("DataWindow.Color=" + string(stars_colors.datawindow_back))
//				dw_control.SetRedraw (TRUE)
//				continue
//			end if
//			// otherwise it is freefrom datawindow
//			dw_control.Modify("DataWindow.Color=" + string(stars_colors.button_face))
//			li_num_of_columns = integer(dw_control.Describe('datawindow.column.count'))
//			if li_num_of_columns < 1 then    // if no columns then go on 
//				dw_control.SetRedraw (TRUE)
//				continue
//			end if
//			// obtain column information and change colors accordingly
//			FOR li_ctr = 1 to li_num_of_columns
//				ls_col_name		=	dw_control.Describe('#'+string(li_ctr)+'.name')	
//				ls_col_tag		=	dw_control.Describe(ls_col_name + ".Tag")
//				ls_rb_columns	=	Upper (dw_control.Describe(ls_col_name + ".RadioButtons.Columns") )
//				if (ls_col_name = "" OR ls_col_name = "!"   &
//					OR ls_col_name= "?"      )  then           		
//					if gc_debug_mode then
//						f_debug_box("Print Message","Unable to obtain column names in order to set colors.")
//					end if
//				else
//					ls_dddwdatacolumn	=	dw_control.Describe (ls_col_name + ".DDDW.DataColumn")
//					IF	ls_dddwdatacolumn = ""	OR		ls_dddwdatacolumn	=	"?"		THEN
//						// Not a DropDownDataWindow
//						if match(upper(ls_col_tag),"LOOKUP") then
//							dw_control.Modify(ls_col_name + ".color=" + string(stars_colors.lookup_text))
//							dw_control.Modify(ls_col_name + ".background.color=" + string(stars_colors.lookup_back))
//						else
//						  if match(upper(ls_col_tag),"PROTECT") then
//							dw_control.Modify(ls_col_name + ".color=" + string(stars_colors.protected_text))
//							dw_control.Modify(ls_col_name + ".background.color=" + string(stars_colors.protected_back))
//						  else
//							if match(upper(ls_col_tag),"NOCOLOR") then		// FDG 05/05/98
//							else
//							 // FDG 01/04/99 - Don't change colors for rbutton columns. 		
//							 if IsNumber(ls_rb_columns)		&
//							 and Integer(ls_rb_columns) > 0	then
//							 	// Radiobutton.  Don't change the colors
//							 else
//							  dw_control.Modify(ls_col_name + ".color=" + string(stars_colors.input_text))
//							  dw_control.Modify(ls_col_name + ".background.color=" + string(stars_colors.input_back))
//							 end if
//							end if
//						  end if
//						end if
//					ELSE
//						//	A DropDownDataWindow
//						dw_control.Modify(ls_col_name + ".color=" + string(stars_colors.input_text))
//						dw_control.Modify(ls_col_name + ".background.color=" + string(stars_colors.input_back))
//						li_rc	=	dw_control.GetChild (ls_col_name, ldwc)
//						IF	li_rc	>	0		THEN
//							//	A DropDownDataWindow was found
//							ldwc.Modify ("DataWindow.Color=" + string(stars_colors.datawindow_back))
//						END IF
//					END IF
//					// FDG 01/04/99 - Don't change colors if the column heading doesn't exist
//					ls_col_hdr	=	ls_col_name	+	'_t'
//					ls_hdr_attributes	=	dw_control.Describe (ls_col_hdr	+	".attributes")
//					IF	ls_hdr_attributes	=	"!"		&
//					OR	ls_hdr_attributes	=	"?"		THEN
//						// No header for this column
//					ELSE
//						dw_control.Modify(ls_col_name + "_t"+ ".color=" + string(stars_colors.label_text))
//					END IF
//				end if
//			NEXT
//			dw_control.SetRedraw (TRUE)
//		CASE SingleLineEdit!
//			sle_control = apo_control[li_cntl]
//			if match(upper(sle_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			if match(upper(sle_control.tag),"LOOKUP") then 
//				sle_control.backcolor = stars_colors.lookup_back
//				sle_control.textcolor = stars_colors.lookup_text
//			ELSE
//				IF match(upper(sle_control.tag),"PROTECT") then 
//					sle_control.backcolor = stars_colors.protected_back
//					sle_control.textcolor = stars_colors.protected_text
//				ELSE
//					//GaryR	11/01/2000	2920c	begin
//					if sle_control.borderstyle = StyleRaised! then
//						sle_control.backcolor = stars_colors.protected_back
//						sle_control.textcolor = stars_colors.protected_text
//					else
//						sle_control.backcolor = stars_colors.input_back
//						sle_control.textcolor = stars_colors.input_text
//					end if		
//					//GaryR	11/01/2000	2920c end
//				END IF
//			end if
//		CASE EditMask!
//			em_control = apo_control[li_cntl]
//			if match(upper(em_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			// if maroon lookup field
//			if match(upper(em_control.tag),"LOOKUP") then 
//				em_control.backcolor = stars_colors.lookup_back
//				em_control.textcolor = stars_colors.lookup_text
//			ELSE
//				IF match(upper(em_control.tag),"PROTECT") then 
//					em_control.backcolor = stars_colors.protected_back
//					em_control.textcolor = stars_colors.protected_text
//				else
//					//GaryR	11/01/2000	2920c	begin
//					if (em_control.borderstyle = StyleRaised!) then
//						em_control.backcolor = stars_colors.protected_back
//						em_control.textcolor = stars_colors.protected_text
//					else
//						em_control.backcolor = stars_colors.input_back
//						em_control.textcolor = stars_colors.input_text
//					end if
//					//GaryR	11/01/2000	2920c end
//				end if		
//			end if
//		CASE DropDownListBox!
//			ddlb_control = apo_control[li_cntl]
//			if match(upper(ddlb_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			if match(upper(ddlb_control.tag),"LOOKUP") then 
//				ddlb_control.backcolor = stars_colors.lookup_back
//				ddlb_control.textcolor = stars_colors.lookup_text
//			ELSE
//				IF match(upper(ddlb_control.tag),"PROTECT") then 
//					ddlb_control.backcolor = stars_colors.protected_back
//					ddlb_control.textcolor = stars_colors.protected_text
//				else
//					//GaryR	11/01/2000	2920c begin
//					ddlb_control.backcolor = stars_colors.input_back
//					ddlb_control.textcolor = stars_colors.input_text
//					//GaryR	11/01/2000	2920c end
//				end if
//			end if
//		CASE MultiLineEdit!
//			mle_control = apo_control[li_cntl]
//			if match(upper(mle_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			if match(upper(mle_control.tag),"LOOKUP") then 
//				mle_control.backcolor = stars_colors.lookup_back
//				mle_control.textcolor = stars_colors.lookup_text
//			ELSE
//				IF match(upper(mle_control.tag),"PROTECT") then 
//					mle_control.backcolor = stars_colors.protected_back
//					mle_control.textcolor = stars_colors.protected_text
//				else
//					mle_control.backcolor = stars_colors.input_back
//					mle_control.textcolor = stars_colors.input_text
//				end if
//			end if
//		CASE ListBox!
//			lbx_control = apo_control[li_cntl]
//			if match(upper(lbx_control.tag),"COLORFIXED") then
//				continue
//			end if 
//			lbx_control.backcolor = stars_colors.input_back
//			lbx_control.textcolor = stars_colors.input_text
//		END CHOOSE
//	END IF				// If IsValid (...)
//next
//
////	Now set background color of the object being processed (usually
////	the window
//This.backcolor = stars_colors.button_face

RETURN TRUE
end event

event type integer ue_load_ddlb_dw_ops(dropdownlistbox ddlb_to_load, string as_ops_item, string as_arg_items);////////////////////////////////////////////////////////////////////////////
//	Script:	w_master.ue_load_ddlb_dw_ops
//
//	Arguments:	ddlb_to_load - ddlb_dw_ops (by reference)
//          	as_ops_item - 'S' = Sort or 'R' = Sort/Rank
//					as_arg_items - 'A' = Load all items
//										'P' = Load only:
//										Sort (or Rank), Display Filter, & Find
//
//	Returns:		Integer
//
//	Description:
//
//		This event will load the dropdown listbox for the window
//		operations.
//
////////////////////////////////////////////////////////////////////////////
//
// 07/18/00	GaryR	1707D	Column alignment implementation.
//	05/11/04	GaryR	Track 4016d	Add a Unique Count option to Window Operations
//	12/15/04	GaryR	Track	4161d	Rename Unique Count to Count Unique Values
//
////////////////////////////////////////////////////////////////////////////

setpointer(hourglass!)

If as_ops_item = 'S' Then
	ddlb_to_load.AddItem('Sort')
Elseif as_ops_item = 'R' Then
	ddlb_to_load .Additem('Sort/Rank')
End If

ddlb_to_load.AddItem('Display Filter')
ddlb_to_load.AddItem('Find')
ddlb_to_load.AddItem('Align')	// Gary-R	07/18/2000	1707D
ddlb_to_load.AddItem('Count Unique Values')

If as_arg_items = 'A' Then
	ddlb_to_load.AddItem('Create Col Filter')
	ddlb_to_load.AddItem('Append Col Filter')
	ddlb_to_load.AddItem('Code/Decode')
End If

Return 0
end event

event move;//*********************************************************************
//	Script:	w_master.move (pbm_move)
//
//	Description:
//		Send the move notification to the proper services.
//
//*********************************************************************

//	Store the position and size on the preference service.
//	With this info, the service knows the normal size of the
//	window even when the window is closed as maximized/minimized

IF	IsValid (inv_preference)		&
AND This.windowstate	=	Normal!	THEN
	inv_preference.Post	of_SetPosSize()
END IF

end event

event ue_controlgotfocus;//*********************************************************************
//	Script:	w_master.ue_controlgotfocus
//
//	Description:
//		Keeps track of the last active datawindow.
//
//*********************************************************************

IF	adrg_control.TypeOf()	=	DataWindow!		THEN
	IF	adrg_control.TriggerEvent ("ue_descendant")	=	1		THEN
		idw_active	=	adrg_control
	END IF
END IF


end event

event ue_descendant;//*********************************************************************
//	Script:	w_master.ue_descendant
//
//	Description:
//		Always return TRUE and use this event to determine if a window
//		is inherited from w_master.
//
//*********************************************************************

Return TRUE

end event

event ue_dberror;//*********************************************************************
//	Script:	w_master.ue_DBError
//
//	Description:
//		Display the dberror that was encountered during the ue_save
//		process.
//
//*********************************************************************

IF	IsNull (istr_db.message)				&
OR	Trim (istr_db.message)		<	' '	THEN
	MessageBox ('STARS Database Error', is_dberrormsg, StopSign!, OK!)
ELSE
	OpenWithParm (w_db_error, istr_db)
END IF

//	Clear the error message variable
This.of_SetDBErrorMsg('')

end event

event ue_microhelp;//*********************************************************************
//	Script:	w_master.ue_MicroHelp
//
//	Description:
//		Display the Microhelp for the message sent.
//
//*********************************************************************

IF	IsNull (as_microhelp)					&
OR	Trim (as_microhelp)		<	' '		THEN
	Return
END IF

MDI_MAIN_FRAME.SetMicroHelp (as_microhelp)

end event

event ue_display_sql;//*********************************************************************
//	Script:	w_master.ue_display_sql
//
//	Description:
//		Trigger the event (recursively) that find all datawindows to
//		display its SQL (via f_debug_box).
//
//*********************************************************************
//	History
//
//	FDG	01/30/98	Created.
//
//*********************************************************************


Integer	li_rc

li_rc	=	This.Event	ue_display_sql_dw (This.control)

end event

event ue_display_sql_dw;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_display_sql_dw
//
//	Arguments:
//		apo_control[]   Array of controls to check for registering for resize
//
//	Returns:  integer
//	 1 = Successful, no errors found
//	-1 = An error was found
//
//	Description:	 
//		Find all datawindows with SQL and display its SQL via f_debug_box.
//
//	Note:	 This event is called recursively to handle tab controls and user objects.
//////////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	01/30/98	Created.
//
//////////////////////////////////////////////////////////////////////////////

Any			la_rc

Integer		li_max,		&
				li_i,			&
				li_rc,		&
				li_dwtype
				
String		ls_sql
				
DataWindow	ldw
UserObject	luo_uo
tab			ltab_tab
w_master		lw_window

// Get the number of objects
li_max = This.Event	ue_get_upperbound (apo_control)

// Loop thru the objects
For li_i = 1 to li_max
	
	IF	IsValid ( apo_control[li_i] )		THEN

		// Tabs and user objects have controls within them
		Choose Case TypeOf ( apo_control[li_i] )
	
			Case Tab!
				// Test for Tab Controls (which contain TabPages which may contain controls)
				ltab_tab = apo_control[li_i]
				li_rc = This.Event ue_display_sql_dw (ltab_tab.control) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case UserObject!
				// Test for UserObjects (which may contain controls)
				luo_uo = apo_control[li_i]
				li_rc = This.Event ue_display_sql_dw (luo_uo.control) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case DataWindow!
				// Found a datawindow.  Get and display its SQL
				ldw		=	apo_control[li_i]
				ls_sql	=	ldw.GetSQLSelect()
				IF	IsNull (ls_sql)			&
				OR	Trim (ls_sql)	<	' '	THEN
				ELSE
					// This d/w has SQL.  Display it via f_debug_box.
					f_debug_box ('Display SQL', 'SQL = ' + ls_sql + '.')
					f_debug_box ('Display SQL', ' ')		//	Insert a blank line
				END IF
	


		End Choose 
	END IF			// If IsValid (...)
Next

// Display of the SQL for all datawindows was successful
Return 1

end event

event ue_get_upperbound;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_get_upperbound
//
//	Arguments:	apo_control   Array of controls to check for validity
//
//	Returns:  integer - The number of controls in this array
//
//	Description:
//		A control array can have values at the end where it is a null value.
//		For example, when removing the last control in an array, it is set
//		to null.  However, an upperbound will still include the null object.
//		This event will exclude any invalid controls when determining the
//		number of controls.
//
//////////////////////////////////////////////////////////////////////////////


Any			la_rc
Integer		li_max,		&
				li_idx,		&
				li_rc

// Get the number of objects
li_max = UpperBound (apo_control)

// Loop thru the objects
FOR li_idx = 1 TO li_max
	IF	IsValid (apo_control [li_idx])	THEN
		li_rc ++
	END IF
NEXT

Return li_rc

end event

event ue_reconnect;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.ue_reconnect
//
//	Arguments:
//		apo_control[]   Array of controls to check for reconnecting datawindows
//
//	Returns:  integer
//	 1 = Successful, no errors found
//	-1 = An error was found
//
//	Description:	
//		This script is executed when the user times out and must be reconnected
//		to the database.
//
//		Find every datawindow found in apo_control[] to call SetTransobject so that
//		the window can be reconnected.
//
//	Note:	 This event is called recursively to handle tab controls and user objects.
//////////////////////////////////////////////////////////////////////////////

Any			la_rc
Integer		li_max
Integer		li_i
Integer		li_rc
Integer		li_dwtype
u_dw			ldw
UserObject	luo_uo
tab			ltab_tab
w_master		lw_window

// Get the number of objects
li_max = This.Event	ue_get_upperbound (apo_control)

// Loop thru the objects
For li_i = 1 to li_max
	
	IF	IsValid ( apo_control[li_i] )		THEN
	
		// Tabs and user objects have controls within them
		Choose Case TypeOf ( apo_control[li_i] )
	
			Case Tab!
				// Test for Tab Controls (which contain TabPages which may contain controls)
				ltab_tab = apo_control[li_i]
				li_rc = This.Event ue_reconnect (ltab_tab.control) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case UserObject!
				// Test for UserObjects (which may contain controls)
				luo_uo = apo_control[li_i]
				li_rc = This.Event ue_reconnect (luo_uo.control) 
				If li_rc < 0 Then 
					Return -1
				END IF
	
			Case DataWindow!
				// Trigger the event in u_dw to reconnect
				ldw = apo_control[li_i]
				li_rc = ldw.Event ue_reconnect () 
				If li_rc < 0 Then 
					Return -1
				END IF
	
		End Choose 
	END IF
Next

// All reconnection of datawindows were successful
Return 1

end event

event ue_open_rmm();//user event that can be used to open a right-mouse menu

end event

event ue_next_tabpage;//*********************************************************************
//	Script:	w_master.ue_next_tabpage
//
//	Description:
//		Used to display the next tabpage on a tab folder.  This event
//		will find the first tab folder on this window from the window's
//		control array.  Once found, get the selected tabpage to select
//		the next tabpage.
//
//	History:
//	08-09-99	NLG	Created.
// 09-28-99 AJS   If tab disabled do not tab to it.
//
//*********************************************************************

tab ltab
integer li_tab, li_i, li_max, num_tabs, i

li_max = this.event ue_get_upperbound(this.control)
FOR li_i = 1 TO li_max
	CHOOSE CASE TypeOf(This.Control[li_i])
		CASE Tab!
			lTab = this.Control[li_i]
//			ajs 09-28-99
//			li_Tab = lTab.SelectedTab
//			IF li_tab > 1 THEN 

//				
//				lTab.SelectTab(li_tab + 1)
				
			li_Tab	=	ltab.SelectedTab

			//Add loop to handle multiple disabled tabs
			num_tabs = upperbound(ltab.Control[])
							
			for i = 1 to num_tabs
				li_Tab  = li_Tab + 1
				
				//go to beginning or end of tabs
				if li_Tab = 0 then
					li_Tab = num_tabs
				end if
				if li_Tab > num_tabs then
					li_Tab = 1
				end if
				
				ltab.SelectTab (li_Tab)
				If ltab.Control[li_Tab].enabled = TRUE then
					EXIT
				End if
			next
//			END IF
			return
	END CHOOSE
NEXT

end event

event ue_prev_tabpage;//*********************************************************************
//	Script:	w_master.ue_prev_tabpage
//
//	Description:
//		Used to display the previous tabpage on a tab folder.  This event
//		will find the first tab folder on this window from the window's
//		control array.  Once found, get the selected tabpage to select
//		the previous tabpage.
//
//	History:
//	08-09-99	NLG	Created.
// 09-28-99 AJS   If tab disabled do not tab to it.
//
//*********************************************************************

tab ltab
integer li_tab, li_i, li_max, num_tabs, i


li_max = this.event ue_get_upperbound(this.control)
FOR li_i = 1 TO li_max
	CHOOSE CASE TypeOf(This.Control[li_i])
		CASE Tab!
			lTab = this.Control[li_i]
//			ajs 09-28-99
//			li_Tab = lTab.SelectedTab
//			IF li_tab > 1 THEN 
//				
//				lTab.SelectTab(li_tab - 1)
				
			li_Tab	=	ltab.SelectedTab

			//Add loop to handle multiple disabled tabs
			num_tabs = upperbound(ltab.Control[])
							
			for i = 1 to num_tabs
				li_Tab  = li_Tab + -1
				
				//go to beginning or end of tabs
				if li_Tab = 0 then
					li_Tab = num_tabs
				end if
				if li_Tab > num_tabs then
					li_Tab = 1
				end if
				
				ltab.SelectTab (li_Tab)
				If ltab.Control[li_Tab].enabled = TRUE then
					EXIT
				End if
			next
//			END IF
			return
	END CHOOSE
NEXT

end event

event ue_find_print_dw;//*********************************************************************
//	Script:	w_master.ue_find_print_dw
//
//	Description:
//	This is a recursive event that finds the first datawindow in the 
// window and sets it to idw_print.  This is a recursive script because 
// the window's control array, a tab's control array, or a user object's 
// control array can be used as input.  
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
//*********************************************************************

DataWindow	ldw_dw
UserObject	luo_uo
tab			ltab_tab
w_master		lw_window

integer	li_max_objects,	&
			li_object_num

// If idw_print has been set, get out
IF IsValid (idw_print)  THEN
	Return
END IF

// Get the number of objects
li_max_objects = This.Event	ue_get_upperbound (apo_control)

// Loop thru the objects
For li_object_num = 1 to li_max_objects
	IF	IsValid ( apo_control[li_object_num] )		THEN
		// Tabs and user objects have controls within them
		Choose Case TypeOf ( apo_control[li_object_num] )
	
			Case Tab!
				// Test for Tab Controls (which contain TabPages which may contain controls)
				ltab_tab = apo_control[li_object_num]
				This.Event ue_find_print_dw (ltab_tab.control) 
	
			Case UserObject!
				// Test for UserObjects (which may contain controls)
				luo_uo = apo_control[li_object_num]
				This.Event ue_find_print_dw (luo_uo.control) 
	
			Case DataWindow!
				// found the datawindow
				IF IsValid (idw_print)  THEN
				ELSE
					idw_print  = apo_control[li_object_num]
				END IF
		End Choose 
	END IF
Next

end event

event ue_find_st_count;//*********************************************************************
//	Script:	w_master.ue_find_st_count
//
//	Description:
//	This is a recursive event that finds the first occurrence of the count 
// box in the window and sets it to igr_rowcount.  The count box is moved 
// to a graphicobject because in some windows, it's a static-text and in 
// other windows, it's an SLE.  This is a recursive script because the 
// window's control array, a tab's control array, or a user object's control 
// array can be used as input.
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
//*********************************************************************

integer 	li_max_objects,	&
			li_object_num,		&
			li_text_num,		&
			li_upperbound
			
string	ls_name

UserObject		luo_uo
tab				ltab_tab
w_master			lw_window
statictext		lst_text
singlelineedit	lsle

String		ls_text[]

// If igr_rowcount has been set, get out
IF IsValid (igr_rowcount)  THEN
	Return
END IF

// Get the number of objects
li_max_objects = This.Event	ue_get_upperbound (apo_control)

// Store all the possible names for a static-text that can be used as a count box.  
// The only name used for an SLE is 'sle_count'
ls_text[1]	=	'st_count'
ls_text[2]	=	'st_row_count'
ls_text[3]	=	'st_total_count'
ls_text[4]	=	'st_row_count1'
ls_text[5]	=	'st_count_summary'
ls_text[6]	=	'st_count_detail'
ls_text[7]	=	'st_count_list'
ls_text[8]	=	'st_count_search'
ls_text[9]	=	'st_count_report'
ls_text[10]	=	'st_count_view'
ls_text[11]	=	'st_row_ct'
ls_text[12]	=	'st_providercount'
ls_text[13]	=	'st_rows'
ls_text[14]	=	'st_no_of_rows'

li_upperbound	=	UpperBound (ls_text)

// Loop thru the objects
For li_object_num = 1 to li_max_objects
	IF	IsValid ( apo_control[li_object_num] )		THEN
		// Tabs and user objects have controls within them
		Choose Case TypeOf ( apo_control[li_object_num] )
	
			Case Tab!
				// Test for Tab Controls (which contain TabPages which may contain controls)
				ltab_tab = apo_control[li_object_num]
				This.Event ue_find_st_count (ltab_tab.control) 
	
			Case UserObject!
				// Test for UserObjects (which may contain controls)
				luo_uo = apo_control[li_object_num]
				This.Event ue_find_st_count (luo_uo.control) 
	
			Case StaticText!
				// found a Static text.  Search its name for the count box
				lst_text  = apo_control[li_object_num]
				ls_name  =  lst_text.ClassName()
				FOR  li_text_num  =  1  to li_upperbound
					IF  ls_name  =  ls_text [li_text_num]   THEN
						// found it
						IF IsValid (igr_rowcount)  THEN
						ELSE
							Igr_rowcount  = lst_text
							Return
						END IF
					END IF
				NEXT
	
			Case SingleLineEdit!
				// found a Static text.  Search its name for the count box
				lsle  = apo_control[li_object_num]
				ls_name  =  lsle.ClassName()
				IF  ls_name  =  'sle_count'   THEN
					// found it
					IF IsValid (igr_rowcount)  THEN
					ELSE
						Igr_rowcount  = lsle
						Return
					END IF
				END IF
		End Choose 
	END IF
Next
end event

event ue_set_window_operations();//*********************************************************************
//	Script:	w_master.ue_set_window_operations
//
//	Description:
// This is either triggered from the RMM window operations or from a 
// Window operations drop-down.  Some objects already have an event 
// (ue_window_operations) that performs similar functionality
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//	Katie	04/10/09	GNL.600.5633	Add decode structure to fx_uo_control call.
//
//*********************************************************************

// Get the print datawindow
This.Event	ue_find_print_dw (This.Control)
IF Not IsValid (idw_print)  THEN
	Return
END IF
// Get the static text for the row count
This.Event	ue_find_st_count (This.Control)
IF Not IsValid (igr_rowcount)  THEN
	Return
END IF
// Save the classname of idw_print for future reference
is_print_dw_name  =  idw_print.ClassName()
// Call fx_uo_control
is_dw_control  =  fx_uo_control (iw_uo_win, idw_print, is_operation, is_dw_control,igr_rowcount, istr_decode_struct)

end event

event ue_reset_window_operations;//*********************************************************************
//	Script:	w_master.ue_reset_window_operations
//
//	Description:
// This event is utilizied when window operations can be performed on multiple
// datawindows within a window.  A tab's selectionchanged event is a great 
// place to invoke this script.  This script will clear out the previous 
// window's operations functionality.  
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
//*********************************************************************

sx_decode_structure	lstr_decode_struct


istr_decode_struct	=	lstr_decode_struct
is_dw_control		=	''
is_operation				=	''
is_print_dw_name			=	''
SetNull (igr_rowcount)

IF	IsValid (iw_uo_win)		THEN
	Close (iw_uo_win)
END IF

end event

public function string of_get_title ();//*********************************************************************
//	Script:	w_master.of_get_title
//
//	Description:
//		Return the original title of the window
//
//*********************************************************************

Return is_orig_title

end function

public function integer of_updatechecks ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  w_master.of_UpdateChecks
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = updates were found
//	 0 = No changes to update were found
//	-1 = AcceptText error
//	-2 = UpdatesPending error was encountered
//	-3 = Validation error was encountered
//
//	Description:
//		Determine if any updates occured and if so, do they pass the
//		validation rules (missing required fields)
//
//	History:
//
//	11/17/99	FNC	Check to see if there are any updates pending in datastores
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_pending_rc,	&
				li_upper,		&
				li_max,			&
				li_idx,			&
				li_rc

powerobject	lpo_pendingupdates[]

n_ds			lds_clear[]

// Determine if any changes are pending.

// Clear the instances
ipo_pendingupdates	=	lpo_pendingupdates
ids_pendingupdates	=	lds_clear

li_pending_rc = This.Event ue_updatespending(This.control) 

Li_upper  =  UpperBound (ids_update)				// FNC 11/17/99 Start
Li_max  =  UpperBound (ids_pendingupdates)
FOR li_idx  =  1  TO  li_upper
	IF  ids_update [li_idx].ModifiedCount()  + ids_update [li_idx].DeletedCount()  >=  1  THEN
		Li_max ++
		ids_pendingupdates[li_max]  =  ids_update[li_idx]
		li_rc  =  1
	END IF
NEXT														// FNC 11/17/99 End

If li_pending_rc < 0 Then 
	Return -2
End If

If li_pending_rc = 0 Then 
	if li_rc = 0 then
		Return 0
	end if
End If

// Check for Errors on controls. 
If This.Event ue_validation(ipo_pendingupdates) <	0 Then 
	Return -3
End If

// There are updates pending and no Errors were found.
Return 1
end function

public function boolean of_getclosestatus ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  w_master.of_GetCloseStatus
//
//	Arguments:  none
//
//	Returns:  Boolean
//	 TRUE	= Window is closing
//	 FALSE = Window is not closing
//
//	Description:
//		Determine if the window is in the process of closing.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_closestatus

end function

public function integer of_setresize (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetResize
//
//	Arguments:		
//		ab_switch   Starts/stops the window resize service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the window resize service
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc,		&
			li_x,			&
			li_y,			&
			li_max_x,	&
			li_max_y

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create n_cst_resize
		// If opening as layered (maximized), the original size of the window
		//	has already been computed.  Get the x & y coordinates of the 
		//	bottom right control on the window and use this to control the 
		//	original size of the window.
		inv_resize.of_GetMinMaxPoints(This.Control, li_x, li_y, li_max_x, li_max_y)
		inv_resize.of_SetOrigSize ( li_max_x + ii_resize_gap, li_max_y + ii_resize_gap )
		// Register all controls in this window as "Scale"
		This.Event ue_Register_Resize (This.Control)
		li_rc = 1
	end if
else
	if IsValid (inv_resize) then
		destroy inv_resize
		li_rc = 1
	end if
end If

return li_rc

end function

public function integer of_disable_dws (powerobject apo_control[]);//************************************************************************
//	Script:	w_master.of_disable_dws
//
//	Arguments:
//		apo_control - Array of controls to check for datawindows
//
//	Description:	
//			This function will go through the control array to find all
//			datawindows.  For each datawindow found, protect every column
//			to prevent changes to the data.
//
//	NOTE:	This function can be called recursively.  This is why apo_control
//			is used as the argument.  It is possible for tabs to contain
//			tabpages to contain datawindows.  The same type of thing can
//			happen with user objects.
//
//************************************************************************

Integer		li_max,			&
				li_ctr,			&
				li_col,			&
				li_colcount,	&
				li_cb,			&
				li_upper,		&
				li_rc
Long			ll_row,			&
				ll_rowcount
				
u_dw			ldw	
UserObject	luo
Tab			ltab
u_cb			lcb

//str_cbutton	lstr_cbutton

//	Get the list of commandbuttons to disable 
//lstr_cbutton	=	gnv_app.of_get_cbuttons()
//li_upper			=	UpperBound (lstr_cbutton.cbutton)

//	Set this flag to prevent the closequery event from checking for
//	updates

ib_disableclosequery		=	TRUE

li_max		=	This.Event	ue_get_upperbound (apo_control)

//	look for the DataWindow in the control array.  If found protect all
//	columns.

FOR	li_ctr	=	1	TO	li_max
	
	IF	IsValid ( apo_control[li_ctr] )		THEN
	
		CHOOSE	CASE	TypeOf (apo_control [li_ctr] )
	
	//		CASE	CommandButton!
	//			//	Disable this commandbuttons if its text is stored in the list
	//			// of commandbuttons.
	//			lcb	=	apo_control [li_ctr]
	//			FOR	li_cb	=	1	TO	li_upper
	//				IF	Upper (lcb.Text)	=	Upper (lstr_cbutton.cbutton [li_cb] )	THEN
	//					lcb.Enabled			=	FALSE
	//				END IF
	//			NEXT
	
			CASE	DataWindow!
				//	Protect all columns in the datawindow
				ldw	=	apo_control [li_ctr]
				ll_rowcount		=	ldw.RowCount()
				ldw.Enabled		=	False
	//			li_colcount		=	Integer (ldw.Object.DataWindow.Column.Count)
	//			FOR	li_col	=	1	TO	li_colcount
	//				ldw.SetTabOrder (li_col, 0)	//	Disable column
	//			NEXT
	
			CASE	Tab!
				// Call this function recursively because tab controls have
				//	tabpages which have datawindows
				ltab	=	apo_control [li_ctr]
				li_rc	=	of_disable_dws (ltab.Control)
				IF	li_rc	<	0		THEN
					Return li_rc
				END IF
	
			CASE	UserObject!
				// Call this function recursively because user objects have
				//	datawindows
				luo	=	apo_control [li_ctr]
				li_rc	=	of_disable_dws (luo.Control)
				IF	li_rc	<	0		THEN
					Return li_rc
				END IF
	
		END CHOOSE
		
	END IF				// If IsValid (...)
	
NEXT

Return 1
end function

public function integer of_setupdatedw (ref u_dw adw);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetUpdateDW
//
//	Arguments:		
//		adw (by reference) - The DataWindow to specify as updateable
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//		Specify which d/w can insert and update rows of data.
//
//////////////////////////////////////////////////////////////////////////////

idw_update	=	adw

Return 1
end function

public subroutine of_setprintdw (ref u_dw adw);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetPrintDW
//
//	Arguments:		
//		adw (by reference) - The DataWindow to specify as Printable
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//		Specify which d/w can be printed.
//
//////////////////////////////////////////////////////////////////////////////

idw_print	=	adw

end subroutine

public subroutine of_settransaction (ref transaction atr_trans);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetTransaction
//
//	Arguments:		
//		atr_trans (by reference) - The transaction object this window will use
//
//	Returns:  N/A
//
//	Description:
//		Specify which transaction will be used by this window
//
//////////////////////////////////////////////////////////////////////////////

itr_trans	=	atr_trans

end subroutine

public function transaction of_gettransaction ();//*********************************************************************
//	Script:	w_master.of_gettransaction
//
//	Description:
//		Return the transaction object previously saved by 
//		of_settransaction.
//
//*********************************************************************

IF	IsValid (itr_trans)		THEN
	Return	itr_trans
ELSE
	Return	STARS1CA
END IF


end function

public function integer of_setbase (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetBase
//
//	Arguments:		
//		ab_switch   Starts/stops the window base service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the window base service
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_base) then
		inv_base = create n_cst_winsrv
		inv_base.of_SetRequestor (This)
		li_rc = 1
	end if
else
	if IsValid (inv_base) then
		destroy inv_base
		li_rc = 1
	end if
end If

return li_rc

end function

public function integer of_setpreference (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetPreference
//
//	Arguments:		
//		ab_switch   Starts/stops the window preference service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the window preference service
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_rc

// Check arguments
If IsNull (ab_switch) then
	Return -1
End If

If ab_Switch then
	If Not IsValid (inv_preference)	Then
		inv_preference	=	Create	n_cst_winsrv_preference
		inv_preference.of_SetRequestor (This)
		li_rc = 1
	End If
Else
	If IsValid (inv_preference)	Then
		Destroy inv_preference
		li_rc = 1
	End If
End If

Return li_rc

end function

public function integer of_setdberrormsg (string as_msg);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetDBErrorMsg
//
//	Arguments:		
//		as_msg - The Error message that needs to be displayed by the ue_save
//					process.
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//		Save the database error message that needs to be displayed by the
//		ue_save process.
//
//////////////////////////////////////////////////////////////////////////////

IF	IsNull (as_msg)	THEN
	Return -1
END IF

is_dberrormsg	=	as_msg

Return 1
end function

public function boolean of_getsavestatus ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  w_master.of_GetSaveStatus
//
//	Arguments:  none
//
//	Returns:  Boolean
//	 TRUE	= Window is in the ue_save process
//	 FALSE = Window is not in the ue_save process
//
//	Description:
//		Determine if the window is in the ue_save process.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_savestatus

end function

public function integer of_setdberror (str_db_error astr_db);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetDBError
//
//	Arguments:		
//		astr_db - The structure that is passed to w_db_error.
//					process.
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//		Save the database error structure that will eventually be sent to
//		w_db_error.
//
//////////////////////////////////////////////////////////////////////////////

IF	IsNull (astr_db)	THEN
	Return -1
END IF

istr_db	=	astr_db

Return 1
end function

public function integer of_setmicrohelp (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetMicroHelp
//
//	Arguments:		
//		ab_switch   Starts/stops the usage of d/w microhelp
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the usage of microhelp for columns in a d/w.
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

ib_microhelp	=	ab_Switch

return 1

end function

public function boolean of_getmicrohelp ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetMicroHelp
//
//	Arguments:  none
//
//	Returns:  Boolean
//	 TRUE	= Microhelp displays for each column in the d/w
//	 FALSE = Microhelp does not display for each column in the d/w
//
//	Description:
//		Determine if microhelp displays for each field that has focus in 
//		the datawindows.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_microhelp

end function

public function integer of_disable_resize (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Disable_Resize
//
//	Arguments:		
//		ab_switch   Starts/stops the usage of this window's resize
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the usage of window's resize capability.  Call this
//		function in the ue_preopen event.
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

ib_disableresize	=	ab_Switch

return 1

end function

public function integer of_disable_colors (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Disable_Colors
//
//	Arguments:		
//		ab_switch   Starts/stops the setting of this window's colors
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the setting of this window's colors.  Call this
//		function in the ue_preopen event.
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

ib_disablecolors	=	ab_Switch

return 1

end function

public function integer settransobject (ref datawindow adw, transaction atr_trans);//********************************************************
//	Script:	SetTransObject
//
//	Description:
//		This function overloads the PowerBuilder
//		SetTransObject.
//
//		NOTE:	u_dw also overloads the PB SetTransObject	
//********************************************************

Return	adw.SetTransObject (atr_trans)

end function

public function integer of_setsecurity (boolean ab_switch);//////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetSecurity
//
//	Arguments:		
//		ab_switch   Starts/stops the usage of security for this window.
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the usage of security for this window.
//
//////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

ib_security	=	ab_Switch

return 1

end function

public function boolean of_getsecurity ();/////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSecurity
//
//	Arguments:  none
//
//	Returns:  Boolean
//	 TRUE	= Security is being applied to this window
//	 FALSE = Security is not being applied to this window
//
//	Description:
//		Determine if security is being applied to this window.
//
/////////////////////////////////////////////////////////////////////////

Return ib_security

end function

public function integer of_set_queryengine (boolean ab_switch);////////////////////////////////////////////////////////////////////
//
//	Function:  of_Set_Queryengine
//
//	Arguments:		
//		ab_switch   Starts/stops the query engine service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the query engine service
//
////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	01/08/98	Created
//
//
////////////////////////////////////////////////////////////////////

Integer		li_rc

// Check arguments
If IsNull (ab_switch) then
	Return -1
End If

If ab_Switch then
	If Not IsValid (inv_queryengine)	Then
		inv_queryengine	=	Create	uo_cst_queryengine
		li_rc = 1
	End If
Else
	If IsValid (inv_queryengine)	Then
		Destroy inv_queryengine
		li_rc = 1
	End If
End If

Return li_rc

end function

public function integer of_set_sys_cntl_range (boolean ab_switch);//////////////////////////////////////////////////////////////////
// Script:		of_set_sys_cntl_range
//
// Returns:		Integer
//
// Description:
// This function will turn on/off the sys cntl service by a boolean 
// passed into it.
//
//////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	AJS		01/09/98		Created.
//
//////////////////////////////////////////////////////////////////
Integer		li_rc
// Check arguments
if IsNull (ab_switch) then
			return -1
end if

if ab_Switch then
			if not IsValid (inv_sys_cntl) then
				inv_sys_cntl = create u_nvo_sys_cntl_range
				li_rc = 1
			end if
else
			if IsValid (inv_sys_cntl) then
				destroy inv_sys_cntl
				li_rc = 1
			end if
end If

return li_rc

//
end function

public function integer of_set_nvo_count (boolean ab_switch);/////////////////////////////////////////////////////////////
//	Script:	w_master.of_set_nvo_count
//
//	Arguments:	ab_switch
//					TRUE = Create the count service
//					FALSE = Destroy the Count service
//
//	Returns:		Integer
//
//	Description:
//		Create or destroy the Select Count(*) service
//
/////////////////////////////////////////////////////////////
//	History
//
//	01/16/98	FDG	Created
//
/////////////////////////////////////////////////////////////

Integer	li_rc

//	Validate argument
IF	IsNull (ab_switch)		THEN
	Return -1
END IF

IF	ab_switch					THEN
	//	Create the Count service
	IF	NOT IsValid (inv_count)		THEN
		inv_count	=	CREATE	u_nvo_count
	ELSE
		Return 0
	END IF
ELSE
	//	Destroy the service
	IF	IsValid (inv_count)	THEN
		Destroy	inv_count

	ELSE
		Return 0
	END IF
END IF

Return 1

end function

public function u_dw of_getprintdw ();/////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetPrintDW
//
//	Arguments:  none
//
//	Returns:  u_dw - The d/w set as the print d/w
//
//	Description:
//		Return the print d/w previously set in of_SetPrintDW.
//
/////////////////////////////////////////////////////////////////////////

Return	idw_print

end function

public function integer of_disable_center (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Disable_Center
//
//	Arguments:		
//		ab_switch   Starts/stops the usage of centering a response window
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the usage of centering a response window.  Call this
//		function in the ue_preopen event.
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
IF IsNull (ab_switch)	THEN
	Return -1
END IF

ib_disablecenter	=	ab_Switch

Return 1

end function

public function integer of_set_temp_table (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Set_temp_table
//
//	Arguments:		
//		ab_switch   Starts/stops the window temp table service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the window temp table service
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_temp_table) then
		inv_temp_table = create n_cst_temp_table
		li_rc = 1
	end if
else
	if IsValid (inv_temp_table) then
		destroy inv_temp_table
		li_rc = 1
	end if
end If

return li_rc

end function

public function integer of_help (string as_window, string as_function);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_help
//
//	Arguments:		
//		as_window - The name of the window.
//		as_function - The function (if any within) the window
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		This overloaded function will open the help window with the name
//		of the help file.
//
//////////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	05/05/98	Track 1193.  Created.
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_row,			&
			ll_rowcount
String	ls_window,		&
			ls_function,	&
			ls_filename,	&
			ls_col_name
			
// Edit the input

IF	IsNull (as_window)			&
OR	Trim (as_window)	<	' '	THEN
	as_window	=	Upper ( This.ClassName() )
END IF

IF IsNull (as_function)		THEN
	as_function	=	''
END IF

ls_window		=	Upper (as_window)
ls_function		=	Upper (as_function)

IF	NOT	IsValid (ids_help)		THEN
	//	Read stars_win_parm to get the help file name
	ids_help					=	CREATE	n_ds
	ids_help.Dataobject	=	'd_help'
	ids_help.SetTransObject (Stars2ca)
	ll_rowcount				=	ids_help.Retrieve (ls_window)
ELSE
	ll_rowcount				=	ids_help.RowCount()
END IF

// Loop thru ids_help to find the function.  Don't use the 'Find'
//	function because ids_help may have col_name = null.  Displaying
//	help for a window will have the function = ''.

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name	=	Upper ( ids_help.object.col_name	[ll_row] )
	// Check for null in the table
	IF	IsNull (ls_col_name)			THEN
		ls_col_name	=	''
	END IF
	// Compare a_dflt with as_function.  both have been converted to
	//	upper case.
	IF	ls_col_name	=	ls_function		THEN
		ls_filename	=	Trim ( ids_help.object.a_dflt	[ll_row] )
		Exit

	END IF
NEXT
	
IF	ls_filename	>	' '					THEN
	OpenWithParm (w_help, ls_filename)
ELSE
	Return	0
END IF

Return 1

end function

public function integer of_help (string as_window);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_help
//
//	Arguments:		
//		as_window - The name of the window.
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		This overloaded function will perform the correct script to display
//		the help file.
//
//////////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	05/05/98	Track 1193.  Created.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_window

// Edit the input

IF	IsNull (as_window)			&
OR	Trim	(as_window)	<	' '	THEN
	as_window	=	Upper ( This.ClassName() )
END IF

ls_window		=	Upper (as_window)

Return This.of_help (ls_window, '')

end function

public function integer of_help ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_help
//
//	Arguments:	None	
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		This overloaded function will perform the correct script to display
//		the help file.
//
//////////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	05/05/98	Track 1193.  Created.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_window

ls_window	=	Upper ( This.ClassName() )

Return This.of_help (ls_window, '')

end function

public subroutine of_set_st_count (graphicobject arg_control);igr_rowcount = arg_control
end subroutine

public subroutine of_register_datastore (n_ds ads_requestor);integer li_upper

li_upper  =  UpperBound (ids_update)
li_upper ++
ids_update [li_upper]  =  ads_requestor


end subroutine

public function integer of_window_operations (datawindow adw_requestor, long al_row, dwobject adwo);//*********************************************************************
//	Script:	w_master.of_window_operations
//
//	Description:
// This function is called when the user double clicks on a datawindow.  
// It will invoke any window operations functionality associated with 
// double-clicking on a datawindow
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
//*********************************************************************

string	ls_col_name,	&
			ls_hold_object
			
integer 	li_rc,		&
			li_tabpos



SetPointer (HourGlass!)

//ls_col_name  =  adwo.Name

// Make sure that the classnames of adw_requestor and idw_print match.  
// For a tab window, this will avoid a mismatch on datawindows.  
// is_print_dw_name is set in ue_window_operations


//ls_classname  =  adw_requestor.ClassName()
//IF  ls_classname  <>  is_print_dw_name  THEN
//	Return  0
//END IF


ls_hold_object = Getobjectatpointer(adw_requestor)
If ls_hold_object = '' then
	return -1
end if
li_tabpos = pos (ls_hold_object,"~t")
ls_col_name = left(ls_hold_object,(li_tabpos - 1))

IF  Right(ls_col_name, 2)  =  '_t' AND Upper (ls_col_name)  <>  'HEADER_T'   THEN
	if trim(is_operation ) = '' then
		Messagebox('Information','You must select an option from Window Operations')
		return -1
	else
		This.Event	ue_set_window_operations()
		li_rc  =  fx_dw_control (adw_requestor, ls_hold_object, is_dw_control, iw_uo_win, '', 0, istr_decode_struct)
	end if
ElSEIF is_dw_control  =  'FILTER' OR is_dw_control  =  'FIND'   THEN
	li_rc  =  fx_dw_control (adw_requestor, ls_hold_object, is_dw_control, iw_uo_win, 'cell', al_row, istr_decode_struct)
ElSE
	Return  0
END IF

Return  li_rc


end function

public subroutine of_set_is_operation (string as_operation);is_operation = as_operation
end subroutine

public function boolean of_is_locked ();//////////////////////////////////////////////////////////////////////
//
//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//
//////////////////////////////////////////////////////////////////////

Boolean lb_lock

//	Check if retrieving
lb_lock = gnv_app.of_get_lock()
IF lb_lock THEN
	MessageBox( "Warning", "Please cancel or finish retrieve before closing!", Exclamation! )
	Return lb_lock
END IF

//	Check if decoding
lb_lock = ib_lock_for_decode
IF lb_lock THEN MessageBox( "Warning", "Please cancel or finish decode before closing!", Exclamation! )
Return lb_lock
end function

public function boolean of_get_showsql ();// 01/05/2005 Katie Track 5431c Returns local variable for whether or not sql is being shown or not for this window.

return ib_show_sql
end function

public function boolean of_get_allowswitch ();// 01/06/2005 Katie Track 5431c Returns local variable for whether or not to allow the sql to show for this window.

return ib_allow_switch
end function

public function integer of_set_showsql (boolean as_show);// 01/05/2005 Katie Track 5431c Returns local variable for whether or not sql is being shown or not for this window.
ib_show_sql = as_show
return 1
end function

on w_master.create
end on

on w_master.destroy
end on

event open;//*********************************************************************
//	Script:	w_master.Open
//
//	Description:
//		Trigger the ue_preopen event and post to the ue_postopen event.
//		Reset the window's colors and resize all the controls on the
//		window as the window resizes.
//
//		NOTE:
//			Set the default transaction object used for this window
//			in your descendant script.  Example:
//				This.of_SetTransaction (STARS1CA)
//
//*********************************************************************
//	History
//
//	FDG	02/20/98	Provide the ability to center response windows.
//	FDG	07/08/98	Track 1118.  Register all response/child windows to
//						w_main.  when the user times out, these windows can
//						be reconnected to.
//
//*********************************************************************

Integer	li_rc

//	If your window receives any parms, get the parm in
//	the ue_preopen event.
This.Event ue_preopen ()

//	ue_postopen will execute after the window opens
This.Post Event ue_postopen ()

IF	Len (This.Title)	=	0		THEN
	This.Title	=	'STARS'
END IF

is_orig_title	=	This.Title	// Save the window title

is_window_name	=	This.ClassName()	// Save the name of this window

//	Allow preference service to restore settings if necessary
IF	IsValid (inv_preference)	THEN
	IF	Len ( inv_preference.of_getuserinifile() )	>	0		THEN
		li_rc	=	inv_preference.of_restore ( inv_preference.of_getuserinifile(), &
														This.ClassName()	+	' Preferences' )
	END IF
END IF

//	Reset the colors for this window (unless it's the frame window).
IF	This.WindowType	<>	MDI!			&
AND This.WindowType	<>	MDIHelp!		THEN
	//	Setting of the window's colors can be overridden by setting
	//	ib_disablecolors thru of_disable_colors(TRUE) in the
	//	ue_preopen event.
	IF	ib_disablecolors	=	FALSE		THEN
		This.Event	ue_set_window_colors (This.Control)
	END IF
END IF

//	Invoke the resize service for Main! (Sheets) only.
//	This will automatically resize all controls on the
//	window as the window resizes.
IF	This.WindowType	=	Main!			THEN
	//	Only resize if the user has specified to do so.  Resize
	// can be overridden for the window by setting ib_disableresize
	//	thru of_disable_resize (TRUE) in the ue_preopen event.
	IF	gnv_app.of_get_resize()	=	TRUE		&
	AND ib_disableresize			=	FALSE		THEN
		This.of_SetResize (TRUE)
	END IF
ELSEIF This.WindowType	=	Response!	THEN
	// The window is a response window, center it.
	IF	ib_disablecenter	=	FALSE			&
	AND NOT	IsValid (inv_resize)			THEN
		This.of_SetBase (TRUE)			//	Enable the base window service
		inv_base.of_center()
	END IF
END IF

//	Set this window to display microhelp when each column in the
//	DataWindows get focus.
This.of_SetMicroHelp (TRUE)

// FDG 07/08/98 begin
// All non-frame and non-sheet windows must get registed to w_main
IF This.WindowType	=	Response!		&
OR This.WindowType	=	Child!			&
OR This.WindowType	=	Popup!			THEN
	IF	IsValid (w_main)		THEN
		w_main.of_set_child_response (This)
	END IF
END IF
// FDG 07/08/98 end

// Set the transaction object used by this window.  If not
//	called, this window will default to STARS1CA
//This.of_SetTransaction (STARS1CA)

// To specify which d/w will be used to delete/insert rows:
//This.of_SetUpdateDW (adw)

// To specify which d/w will be printed
//This.of_SetPrintDW (adw)

// To use the window's temp table service
//This.of_set_temp_table (TRUE)

//	After the data is retrieved, make sure to commit the retrieval
//	to free up any locks.  Examples on how to do this is below:
//		li_rc	=	This.Event ue_commit_rollback (TRUE)   
end event

event closequery;//*********************************************************************
//	Script:	w_master.closequery
//
//	Description:
//		Search for unsaved datawindows prompting the user if any
//		pending updates are found.
//
//*********************************************************************
//	History
//
//	03/04/98	FDG	The closequery message now displays is_closequery_msg
//						& is_closequery_error-msg instead of a hardcoded literal.
//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
//
//
//*********************************************************************

Integer		li_pendingrc,		&
				li_validationrc,	&
				li_accepttextrc,	&
				li_msg,				&
				li_rc
				
String		ls_msgparms[]

ib_changes_not_saved	=	FALSE

IF This.of_is_locked() THEN Return 1

//	If the closequery process flag is disabled, get out

IF	ib_disableclosequery		THEN
	Return 0
END IF

// Apply the contents of the edit controls to all datawindows.
IF This.Event ue_accepttext (This.control, TRUE)	<	0	THEN
	Return 1
END IF

//	Perform any "pre-close" processing.  If an error occered, get out.
li_rc	=	This.Event ue_preclose ()

IF	li_rc	<>	1	THEN
	//	Returning 1 prevents the window from closing
	Return 1
END IF

//	Prevent validation error messages from appearing while the window
//	is closing and allow others to check if the closequery process
//	is in progress.
ib_closestatus	=	TRUE

//	Check for any pending updates
li_rc	=	This.of_updatechecks ()

IF	li_rc	=	0		THEN
	//	No updates are pending, allow the window to be closed
	ib_closestatus	=	FALSE
	Return 0
END IF

IF	li_rc	<	0		THEN
	//	Updates are pending, but at least 1 data entry error was
	//	found.  Give the user the chance to save the window
	//	without saving
	li_msg	=	MessageBox ('Validation Error', is_closequery_error_msg, &
					Exclamation!, YesNo!, 2)
	IF	li_msg	=	1		THEN
		ib_closestatus	=	FALSE
		Return 1
	END IF
ELSE
	//	Updates are pending.  Prompt the user to save the changes
	//	before closing the window.
	li_msg	=	MessageBox ('Warning', is_closequery_msg,	&
					Exclamation!, YesNoCancel!)
	CHOOSE CASE	li_msg
		CASE	1
			//	Yes - Update.  If the update fails, prevent the 
			// window from closing
			IF	This.Event ue_save ()	>=	1	THEN
				// Successful update - allow the window to be closed
				ib_closestatus	=	FALSE
				Return 0
			END IF
		CASE	2
			//	No - Allow the window to be closed without saving the
			//			changes.
			//	Reset the datawindow update attributes passing the
			//	window's control array
			li_rc	=	This.Event ue_commit_rollback (FALSE)	// Rollback & free any locks
			li_rc	=	This.Event ue_postupdate (ipo_pendingupdates)
			ib_closestatus			=	FALSE
			ib_changes_not_saved	=	TRUE
			Return 0
		CASE	3
			//	Cancel - Prevent the window from closing (Return 1)
	END CHOOSE
END IF

//	Prevent the window from closing
ib_closestatus	=	FALSE
Return 1
end event

event resize;//*********************************************************************
//	Script:	w_master.resize
//
//	Description:
//		If the resize service is instantiated, execute the code in
//		n_cst_resize to resize the window
//
//*********************************************************************

IF	IsValid (inv_resize)		THEN
	inv_resize.Event	pfc_resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight() )
END IF

//	Store the position and size on the preference service.
//	With this info, the service knows the normal size of the
//	window even when the window is closed as maximized/minimized

IF	IsValid (inv_preference)		&
AND This.windowstate	=	Normal!	THEN
	inv_preference.Post	of_SetPosSize()
END IF

end event

event close;//*********************************************************************
//	Script:	w_master.close
//
//	Description:
//		Destroy any previously created services.
//
//*********************************************************************
//	History
//
//	AJS	01/09/98	Added destroy of sys cntl service.
//	FDG	01/08/98	Added destroy of query engine service.
//	FDG	05/05/98	Track 1193.  Destroy ids_help.
//
//*********************************************************************

Integer	li_rc

String	ls_userinifile

IF	IsValid (inv_preference)	THEN
	//	Save the preferences for this window
	ls_userinifile		=	inv_preference.of_GetUserINIFile()
	IF	Len (ls_userinifile)	>	0		THEN
		//	User's INI file exists
		li_rc	=	inv_preference.of_save ( ls_userinifile, &
													This.ClassName() + ' Preferences' )
	END IF
END IF

//	Destroy any previously created services.
This.of_SetBase (FALSE)
This.of_SetResize (FALSE)
This.of_SetPreference (FALSE)
This.of_SetMicroHelp (FALSE)
This.of_Set_QueryEngine (FALSE)		//	FDG 01/08/98
This.of_set_sys_cntl_range (FALSE)	//	AJS 01/09/98
This.of_Set_nvo_count (FALSE)			//	FDG 01/16/98
This.of_set_temp_table (FALSE)		//	FDG 03/04/98

IF	IsValid (ids_help)		THEN
	Destroy	ids_help
END IF


end event

event rbuttondown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  w_master.rbuttondown
//
//	Description:	 
//		If in debug mode, ind all datawindows with SQL and display its SQL 
//		via f_debug_box.
//
//	Note:	 This event is called recursively to handle tab controls and user objects.
//////////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	01/30/98	Created.
//
//////////////////////////////////////////////////////////////////////////////

IF	gc_debug_mode	THEN
	This.Event	ue_display_sql()
END IF
end event

event key;//*********************************************************************************
// Script Name:	<script name>
//
// Arguments:	KeyCode	value	key
//					UnsignedLong	value	keyflags
//
// Returns:		Long
//
// Description:	Check specific keyboard keys
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

GraphicObject lgo_active
SingleLineEdit	sle_active

//"Easter Egg" to display the STARS Team Picture!
IF KeyDown( KeyControl! ) AND KeyDown( KeyMultiply! ) THEN Open( w_stars_team )

//	Lookups
IF KeyDown (KeyF2!) THEN
	lgo_active = GetFocus()
	IF lgo_active.TypeOf() = SingleLineEdit! THEN
		sle_active = lgo_active
		IF Upper( sle_active.tag ) = "LOOKUP" THEN sle_active.Dynamic Event ue_lookup()
	END IF
END IF
end event

event activate;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

IF IsValid( m_stars_30 ) THEN
	m_stars_30.m_window.m_popupmenu.enabled = ib_popup_menu
END IF
end event

event deactivate;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

IF IsValid( m_stars_30 ) THEN
	m_stars_30.m_window.m_popupmenu.enabled = FALSE
END IF
end event

