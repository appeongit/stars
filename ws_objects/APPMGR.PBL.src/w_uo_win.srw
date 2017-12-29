$PBExportHeader$w_uo_win.srw
$PBExportComments$inherited from w_master
forward
global type w_uo_win from w_master
end type
type uo_decode from u_decode within w_uo_win
end type
type uo_unique_counts from u_unique_counts within w_uo_win
end type
type cb_close from u_cb within w_uo_win
end type
type uo_sort from u_sort_dw within w_uo_win
end type
type uo_find from u_find within w_uo_win
end type
type uo_filter from u_filter1 within w_uo_win
end type
type uo_rank from u_sort_rank within w_uo_win
end type
type uo_align_columns from u_align_columns within w_uo_win
end type
type uo_append_filter from u_append_filter within w_uo_win
end type
end forward

global type w_uo_win from w_master
boolean visible = false
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
integer x = 302
integer y = 612
integer width = 2615
integer height = 864
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
uo_decode uo_decode
uo_unique_counts uo_unique_counts
cb_close cb_close
uo_sort uo_sort
uo_find uo_find
uo_filter uo_filter
uo_rank uo_rank
uo_align_columns uo_align_columns
uo_append_filter uo_append_filter
end type
global w_uo_win w_uo_win

type variables
//*********************************************************************************
//
//	07/29/05		GaryR		Track 4432d		Allow multi-column decode in background
//
//*********************************************************************************

w_master		iwm_active
end variables

forward prototypes
public subroutine wf_size_win ()
public subroutine wf_clear ()
public function integer wf_populatecolumns (sx_decode_structure asx_decode_struct, u_dw audw_requestor)
end prototypes

public subroutine wf_size_win ();// Script Name:	wf_size_win
//
// Arguments:  N/A
//
// Returns:		None
//
// Description:	Size the window and place close button appropriately for the displayed windows function. 
//
//*********************************************************************************
//
//	05/11/04		GaryR		Track 4016d		Add a Unique Count option to Window Operations
//	12/15/04		GaryR		Track	4161d		Rename Unique Count to Count Unique Values
//	07/29/05		GaryR		Track 4432d		Allow multi-column decode in background
//  04/07/09 	Katie 		GNL.600.5633 	Adjust cb_close coordinates and window sizing
//													issues causing objects to be cut off. 
//	04/14/09		Katie		GNL.600.5633	Add the append/create filter object.
//
//*********************************************************************************

if uo_rank.visible Then 
	this.title = 'Sort/Rank'	
	cb_close.x = (uo_rank.width/2 - cb_close.width/2)
	cb_close.y = uo_rank.height + 75
	this.width = uo_rank.width + 50
	this.height = uo_rank.height + 350
elseif uo_sort.visible Then 
	this.title = 'Sort'
	cb_close.x = (uo_sort.width/2 - cb_close.width/2)
	cb_close.y = uo_sort.height + 75
	this.width = uo_sort.width + 50
	this.height = uo_sort.height + 350
elseif uo_filter.visible Then 
	this.title = 'Filter'
	cb_close.x = (uo_filter.width/2 - cb_close.width/2)
	cb_close.y = uo_filter.height + 75
	this.width = uo_filter.width + 50
	this.height = uo_filter.height + 350
elseif uo_find.visible Then 
	this.title = 'Find'
	cb_close.x = (uo_find.width/2 - cb_close.width/2)
	cb_close.y = uo_find.height + 75
	this.width = uo_find.width + 50
	this.height = uo_find.height + 350
elseif uo_align_columns.visible Then // GR 04/14/2000 1707 Report Column Alignment
	this.title = 'Alignment'
	cb_close.x = (uo_align_columns.width/2 - cb_close.width/2)
	cb_close.y = uo_align_columns.height + 75
	this.width = uo_align_columns.width + 50
	this.height = uo_align_columns.height + 350		
elseif uo_unique_counts.visible Then
	this.title = 'Unique Values Count'
	cb_close.x = (uo_unique_counts.width/2 - cb_close.width/2)
	cb_close.y = uo_unique_counts.height + 75
	this.width = uo_unique_counts.width + 50
	this.height = uo_unique_counts.height + 350
elseif uo_decode.visible Then
	this.title = 'Code/Decode'
	cb_close.x = (uo_decode.width/2 - cb_close.width/2)
	cb_close.y = uo_decode.height + 75
	this.width = uo_decode.width + 50
	this.height = uo_decode.height + 350
	uo_decode.iw_parent = THIS
	uo_decode.iw_active = iwm_active
elseif uo_append_filter.visible Then
	if uo_append_filter.ib_create then 
		this.title = 'Create Col Filter'
	else
		this.title = 'Append Col Filter'	
	end if
	cb_close.x = (uo_append_filter.width/2 - cb_close.width/2)
	cb_close.y = uo_append_filter.height + 75
	this.width = uo_append_filter.width + 50
	this.height = uo_append_filter.height + 350
end if
end subroutine

public subroutine wf_clear ();// Script Name:	wf_clear
//
// Arguments:  N/A
//
// Returns:		None
//
// Description:	Clear the datawindow.
//
//*********************************************************************************
//
//	05/11/04		GaryR		Track 4016d		Add a Unique Count option to Window Operations
//	07/29/05		GaryR		Track 4432d		Allow multi-column decode in background
//
//*********************************************************************************


If uo_sort.visible = true Then
	uo_sort.cb_clear.TriggerEvent(Clicked!)
End If
If uo_filter.visible = true Then
	uo_filter.cb_clear.TriggerEvent(Clicked!)
End If
If uo_rank.visible = true Then
	uo_rank.cb_clear.TriggerEvent(Clicked!)
End If
If uo_find.visible = true Then
	uo_find.cb_clear.TriggerEvent(Clicked!)
End If
IF uo_align_columns.visible = TRUE THEN
	uo_align_columns.cb_clear.TriggerEvent( Clicked! )
END IF
IF uo_decode.visible = TRUE THEN
	uo_decode.cb_clear.TriggerEvent( Clicked! )
END IF
IF uo_unique_counts.visible = TRUE THEN
	uo_unique_counts.cb_clear.TriggerEvent( Clicked! )
END IF
end subroutine

public function integer wf_populatecolumns (sx_decode_structure asx_decode_struct, u_dw audw_requestor);// Script Name:	wf_populatecolumns
//
// Arguments:  sx_decode_structure  asx_decode_struct
//					u_dw						audw_requestor
//
// Returns:		integer
//
// Description:	Call the correct function to populate the column drop downs for the windows operation.
//
//*********************************************************************************
//
// 04/07/09	Katie	GNL.600.5633 Initial Creation.
// 04/10/09	Katie	GNL.600.5633 If the count returned from uo_decode.of_populatecolumns is 0
//						no lookups defined.  Inform user and close the window.
//	04/27/09	Katie	GNL.600.5633	Change function names to match programming standards.
//	05/07/09	Katie	GNL.600.5633	Return value other than 0 when the windows operations window is closed.
//
//*********************************************************************************

int li_rowspopulated

if uo_rank.visible Then 
	uo_rank.of_populatecolumns( audw_requestor)
elseif uo_sort.visible Then 
	uo_sort.of_populatecolumns( audw_requestor)
elseif uo_filter.visible Then 
	uo_filter.of_populatecolumns( audw_requestor)
elseif uo_find.visible Then
	uo_find.fuo_populatecolumns( audw_requestor)
elseif uo_align_columns.visible Then
	uo_align_columns.of_populatecolumns( audw_requestor)
elseif uo_append_filter.visible Then
	uo_append_filter.of_populatecolumns( audw_requestor, asx_decode_struct)	
elseif uo_unique_counts.visible Then
	uo_unique_counts.of_populatecolumns(audw_requestor)
elseif uo_decode.visible Then
	li_rowspopulated = uo_decode.of_populatecolumns( asx_decode_struct, audw_requestor)
	if li_rowspopulated = 0 then
		MessageBox( "Decode Error", "There are no lookup fields defined for these columns.  No columns can be decoded.", Exclamation! )
		this.cb_close.event clicked( )
		return -1
	end if
end if
return 0
end function

on w_uo_win.create
int iCurrent
call super::create
this.uo_decode=create uo_decode
this.uo_unique_counts=create uo_unique_counts
this.cb_close=create cb_close
this.uo_sort=create uo_sort
this.uo_find=create uo_find
this.uo_filter=create uo_filter
this.uo_rank=create uo_rank
this.uo_align_columns=create uo_align_columns
this.uo_append_filter=create uo_append_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_decode
this.Control[iCurrent+2]=this.uo_unique_counts
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.uo_sort
this.Control[iCurrent+5]=this.uo_find
this.Control[iCurrent+6]=this.uo_filter
this.Control[iCurrent+7]=this.uo_rank
this.Control[iCurrent+8]=this.uo_align_columns
this.Control[iCurrent+9]=this.uo_append_filter
end on

on w_uo_win.destroy
call super::destroy
destroy(this.uo_decode)
destroy(this.uo_unique_counts)
destroy(this.cb_close)
destroy(this.uo_sort)
destroy(this.uo_find)
destroy(this.uo_filter)
destroy(this.uo_rank)
destroy(this.uo_align_columns)
destroy(this.uo_append_filter)
end on

event ue_preopen;call super::ue_preopen;This.of_disable_resize(TRUE)		//	Don't resize this window

end event

event timer;// Script Name:	timer
//
// Arguments:  N/A
//
// Returns:		Long
//
// Description:	Closes the windows operations window when the functionality changes the active window - see filters.
//
//*********************************************************************************
//
//	05/25/00	Gary-R	Ts2898 SC		Close window operations when sheet changes
//	05/08/09	Katie		GNL.600.5633	The close operation sets the focus to the active window variable, which in 
//												the cases when the active window has changed is still set to the old active
//												window.  Set the active window variable to be the active window.
//
//*********************************************************************************

w_master	lwm_active
lwm_active = w_main.GetActiveSheet()

//If initial sheet doesn't match current sheet then close
IF lwm_active <> iwm_active THEN	
	iwm_active = lwm_active
	cb_close.EVENT Clicked()
end if

end event

event show;//////////////////////////////////////////////////////////////////////////////
//
//	05/25/00	GaryR	Ts2898 SC	Close window operations when sheet changes
//	05/26/09	GaryR	GNL.600.5633.005	Set initial focus
//
//////////////////////////////////////////////////////////////////////////////

//Store the current sheet and trigger the timer event
iwm_active = w_main.GetActiveSheet()
Timer( .25 )

cb_close.SetFocus()
end event

event hide;///////////////////////////////////////////////////////////////////////////
//
//	Gary-R	05/25/2000	Ts2898 SC	Close window operations when sheet changes
//
///////////////////////////////////////////////////////////////////////////

//Cancel the timer event
Timer( 0 )

end event

type uo_decode from u_decode within w_uo_win
boolean visible = false
integer x = 37
integer y = 28
integer width = 1915
integer taborder = 80
end type

on uo_decode.destroy
call u_decode::destroy
end on

type uo_unique_counts from u_unique_counts within w_uo_win
boolean visible = false
integer x = 32
integer y = 28
integer width = 1742
integer height = 328
integer taborder = 30
end type

on uo_unique_counts.destroy
call u_unique_counts::destroy
end on

type cb_close from u_cb within w_uo_win
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 1006
integer y = 460
integer width = 274
integer height = 108
integer taborder = 90
string text = "&Close"
end type

event clicked;// Script Name:	cb_close.clicked
//
// Arguments:  N/A
//
// Returns:		Long
//
// Description:	Close the window.
//
//*********************************************************************************
//
// 09/24/02	JasonS	Track 3309d		move clear code to its own function
// 04/19/00	GR			????				???? 
//	05/04/09	Katie		GNL.600.5633	Returned focus to parent window when the win ops window is closed.
//	05/07/09	Katie		GNL.600.5633  Do not return focus to parent window for create/append filter.
//	05/08/09	Katie		GNL.600.5633	Remove the criteria added on 05/07/09.  Handling this issue in the 
//												timer event to make help ensure that the focus is passed to the 
//												requestor window when the 
//*********************************************************************************
wf_clear()
Hide(parent)
if (IsValid(iwm_active)) then iwm_active.setfocus()
end event

type uo_sort from u_sort_dw within w_uo_win
boolean visible = false
integer x = 37
integer y = 32
integer width = 1975
integer taborder = 60
end type

on uo_sort.destroy
call u_sort_dw::destroy
end on

type uo_find from u_find within w_uo_win
boolean visible = false
integer x = 32
integer y = 24
integer width = 2272
integer height = 344
integer taborder = 70
end type

on uo_find.destroy
call u_find::destroy
end on

type uo_filter from u_filter1 within w_uo_win
boolean visible = false
integer x = 37
integer y = 32
integer width = 2469
integer taborder = 40
end type

on uo_filter.destroy
call u_filter1::destroy
end on

type uo_rank from u_sort_rank within w_uo_win
boolean visible = false
integer taborder = 10
end type

on uo_rank.destroy
call u_sort_rank::destroy
end on

type uo_align_columns from u_align_columns within w_uo_win
boolean visible = false
integer x = 32
integer y = 28
integer width = 1719
integer height = 396
integer taborder = 50
boolean bringtotop = true
long backcolor = 79741120
end type

on uo_align_columns.destroy
call u_align_columns::destroy
end on

type uo_append_filter from u_append_filter within w_uo_win
boolean visible = false
integer x = 5
integer y = 4
integer width = 1870
integer height = 124
integer taborder = 20
boolean bringtotop = true
end type

on uo_append_filter.destroy
call u_append_filter::destroy
end on

