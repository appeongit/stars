$PBExportHeader$w_master_list.srw
forward
global type w_master_list from w_master
end type
type cb_close from commandbutton within w_master_list
end type
type uo_range from uo_date_range within w_master_list
end type
type st_dw_ops from statictext within w_master_list
end type
type cb_delete from commandbutton within w_master_list
end type
type cb_reset from commandbutton within w_master_list
end type
type cb_add from commandbutton within w_master_list
end type
type dw_details from u_dw within w_master_list
end type
type st_rows from statictext within w_master_list
end type
type cb_update from commandbutton within w_master_list
end type
type cb_list from commandbutton within w_master_list
end type
type dw_list from u_dw within w_master_list
end type
type dw_search from u_dw within w_master_list
end type
type gb_details from groupbox within w_master_list
end type
type ddlb_dw_ops from dropdownlistbox within w_master_list
end type
type gb_2 from groupbox within w_master_list
end type
end forward

global type w_master_list from w_master
string accessiblename = "List Window"
string accessibledescription = "List Window"
integer width = 3525
integer height = 2316
event ue_list ( )
event type integer ue_retrieve_list ( )
event ue_retrieve_search ( )
event type integer ue_retrieve_detail ( long al_row )
event ue_set_access ( )
event type boolean ue_set_list_sql ( )
event type boolean ue_validate_criteria ( )
event ue_reset ( )
event ue_list_row_doubleclicked ( )
event type boolean ue_isupdatespending ( )
event ue_row_access ( )
event ue_postretrieve ( )
event ue_disable_details ( )
cb_close cb_close
uo_range uo_range
st_dw_ops st_dw_ops
cb_delete cb_delete
cb_reset cb_reset
cb_add cb_add
dw_details dw_details
st_rows st_rows
cb_update cb_update
cb_list cb_list
dw_list dw_list
dw_search dw_search
gb_details gb_details
ddlb_dw_ops ddlb_dw_ops
gb_2 gb_2
end type
global w_master_list w_master_list

type variables


boolean 	ib_admin_user
boolean 	ib_auto_list
boolean	ib_display_details
boolean	ib_display_update
boolean	ib_display_daterange
boolean	ib_case_security

date		id_from, id_thru

string	is_orig_list_sql
string	is_case_field			// Case field name in datawindow

long		ll_update_row

constant long	icl_grey 	= 536870912
constant long	icl_white 	= 16777215

end variables

forward prototypes
public function string of_get_like_string (string as_string)
public subroutine wf_apply_case_security ()
end prototypes

event type integer ue_retrieve_list();//=======================================================================================//
//	Object:			w_master_list
//	Event:			ue_retrieve_list
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Retrieves the list datawindow
//---------------------------------------------------------------------------------------//
//	* Calls ue_set_list_sql
// * if sql is set ok continue, else foret about it
// * Calls ue_retrieve of dw_list (Specific logic for that list)
//	* Sets rowcount text box
// * If no rows returned, gives messagebox
// -------- ----- -------- 	--------------------------------------------------------------
//	09/20/04 MikeF	5.3			Created
// 10/01/04 Jason	5.3			Added call to ue_set_list and only retrieve if it returns true
//	05/04/05	GaryR	SPR 4366d	Check for pending updates before changing row or refresh
// 06/10/05 MikeF	SPR4319d		Added calls to accomodate Subset list
// 12/22/05 HYL 	SPR 4535d	Keep the current sort as is because the updated row needs to be highlighted
//	06/06/06	GaryR	SPR 4757		Perform housekeeping on detail functionality when 0 rows
// 06/13/08	GaryR	SPR5390		Convert Integers to Longs to prevent overflow
//=======================================================================================//

Long		ll_rowcount
boolean  lb_is_sql_set

dw_list.setRedraw( FALSE )

IF This.event ue_isupdatespending( ) THEN Return 0

// Ensure that the search criteria passes all edits
IF NOT this.event ue_validate_criteria( ) THEN RETURN -1

// descendant windows should change sql in ue_set_list_sql for each specific list, also
// ue_set_list_sql should call ue_validate_criteria before using any criteria
lb_is_sql_set = event ue_set_list_sql()

If lb_is_sql_set then
	//dw_list.setsort("") TRACK 4535 HYL 12/21/05
	dw_list.setfilter("")
	ll_rowcount = dw_list.event ue_retrieve( )
	
	IF ll_rowcount < 0 THEN
		MessageBox(this.title,"Error retrieving list data")
		RETURN - 1
	END IF
End if

// Apply case security
IF ib_case_security THEN
	this.wf_apply_case_security()	
END IF

dw_list.SetRedraw(TRUE)

this.event ue_postretrieve()

st_rows.text = string(dw_list.rowcount())

// Check results / Highlight row
IF dw_list.rowcount( ) = 0 THEN
	// No results or all results removed due to case security
	IF ib_display_details THEN This.Event ue_disable_details()
	MessageBox(this.title,"No rows meeting criteria")
ELSE			
	IF ll_update_row > 0 THEN
		// Re-listing due to update - scroll to and highlight updated row
		dw_list.selectrow( ll_update_row, TRUE)
		dw_list.scrolltorow( ll_update_row ) 
		ll_update_row = 0
	ELSE
		dw_list.event rowfocuschanged( dw_list.getselectedrow( 1 )  )
	END IF
END IF

RETURN dw_list.RowCount()

end event

event type boolean ue_set_list_sql();RETURN TRUE
end event

event type boolean ue_validate_criteria();
IF ib_display_daterange THEN
	IF uo_range.of_get_range( id_from, id_thru ) < 0 THEN
		RETURN FALSE
	END IF
END IF
	
RETURN TRUE
end event

event ue_reset();//=============================================================================================//
// Object		w_master_list
// Event			ue_reset
// Parameters	None
// Returns		None
//=============================================================================================//
// Sets the detail datawindow to its pre-altered status by retrieving the data
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 09/13/05	MikeF	SPR4509d	Reset button functionality
//=============================================================================================//
dw_list.event rowfocuschanged( dw_list.getrow() )
end event

event type boolean ue_isupdatespending();//*********************************************************************
//	Script:	w_master_list.ue_IsUpdatesPending
//
//	Description:
//		Search for unsaved datawindows prompting the user if any
//		pending updates are found.
//
//*********************************************************************
//
//	05/04/05	GaryR	Track 4366d	Check for pending updates before changing row or refresh
//
//*********************************************************************

Integer		li_msg,				&
				li_rc
				
// Apply the contents of the edit controls to all datawindows.
IF This.Event ue_accepttext (This.control, TRUE)	<	0	THEN Return TRUE

//	Check for any pending updates
li_rc	=	This.of_updatechecks ()
IF	li_rc	=	0		THEN	Return FALSE

IF	li_rc	<	0		THEN
	//	Updates are pending, but at least 1 data entry error was	found.
	li_msg	=	MessageBox ('Validation Error', "The information entered does not pass validation" + &
												"and must be corrected before changes can be saved." + &
												"~n~rContinue without saving changes?", &
					Exclamation!, YesNo!, 2)
	IF	li_msg	=	1		THEN Return FALSE
ELSE
	//	Updates are pending.  Prompt the user to save the changes
	//	before closing the window.
	li_msg	=	MessageBox ('Warning', is_closequery_msg,	&
					Exclamation!, YesNoCancel!)
	CHOOSE CASE	li_msg
		CASE	1
			//	Yes - Update.
			IF	This.Event ue_save ()	>=	1	THEN
				This.Event ue_retrieve_list( )
				Return FALSE
			END IF
		CASE	2
			//	No
			//	Reset the datawindow update attributes passing the
			//	window's control array
			li_rc	=	This.Event ue_commit_rollback (FALSE)	// Rollback & free any locks
			li_rc	=	This.Event ue_postupdate (ipo_pendingupdates)
			Return FALSE
		CASE	3
			//	Cancel - Prevent the window from closing (Return TRUE)
	END CHOOSE
END IF

Return TRUE
end event

event ue_row_access();// Script:		ue_row_access
// Called by:	dw_list.rowfocuschanged event
// Use to set various properties based on selected row
end event

event ue_postretrieve();// Script:		ue_postretrieve
// Called by:	w_master.ue_retrieve_list
// Use to set various window level properties after the list window is retrieved.
end event

event ue_disable_details();////////////////////////////////////////////////////////////////////////////////////
//
//	06/06/06	GaryR	SPR 4757	Perform housekeeping on detail functionality when 0 rows
//
////////////////////////////////////////////////////////////////////////////////////

dw_details.Reset()
cb_update.enabled = false
cb_reset.enabled = false
cb_delete.enabled = false
end event

public function string of_get_like_string (string as_string);string		ls_string

ls_string = trim(as_string)

IF len(ls_string) = 0 THEN
	ls_string = '%'
END IF

RETURN ls_string
end function

public subroutine wf_apply_case_security ();//=======================================================================================//
//	Object:			w_master_list
//	Script:			wf_apply_case_security
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Loops through retrieved rows and removes the ones the user isn't allowed to see.
//=======================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------
//	06/10/05 MikeF	SPR4319d Created
//=======================================================================================//
long				ll_row
string			ls_case_id, ls_case_spl, ls_case_ver
n_cst_case		lnv_case

lnv_case	=	CREATE	n_cst_case
This.SetRedraw( FALSE )

FOR ll_row = 1 to dw_list.RowCount()
	ls_case_id	=	dw_list.GetItemString( ll_row, is_case_field )
	ls_case_spl	=	mid( ls_case_id, 11, 2 )
	ls_case_ver	=	mid( ls_case_id, 13, 2 )
	ls_case_id	=	left( ls_case_id, 10 )
	
	IF Len( lnv_case.uf_edit_case_security( ls_case_id, ls_case_spl, ls_case_ver ) ) > 0 THEN
		// The report is linked to a secured case - remove it form the list.
		dw_list.RowsDiscard( ll_row, ll_row, Primary! )
		ll_row --
	END IF
NEXT

Destroy	lnv_case
This.Setredraw( TRUE )
end subroutine

on w_master_list.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_range=create uo_range
this.st_dw_ops=create st_dw_ops
this.cb_delete=create cb_delete
this.cb_reset=create cb_reset
this.cb_add=create cb_add
this.dw_details=create dw_details
this.st_rows=create st_rows
this.cb_update=create cb_update
this.cb_list=create cb_list
this.dw_list=create dw_list
this.dw_search=create dw_search
this.gb_details=create gb_details
this.ddlb_dw_ops=create ddlb_dw_ops
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_range
this.Control[iCurrent+3]=this.st_dw_ops
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_reset
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.dw_details
this.Control[iCurrent+8]=this.st_rows
this.Control[iCurrent+9]=this.cb_update
this.Control[iCurrent+10]=this.cb_list
this.Control[iCurrent+11]=this.dw_list
this.Control[iCurrent+12]=this.dw_search
this.Control[iCurrent+13]=this.gb_details
this.Control[iCurrent+14]=this.ddlb_dw_ops
this.Control[iCurrent+15]=this.gb_2
end on

on w_master_list.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_range)
destroy(this.st_dw_ops)
destroy(this.cb_delete)
destroy(this.cb_reset)
destroy(this.cb_add)
destroy(this.dw_details)
destroy(this.st_rows)
destroy(this.cb_update)
destroy(this.cb_list)
destroy(this.dw_list)
destroy(this.dw_search)
destroy(this.gb_details)
destroy(this.ddlb_dw_ops)
destroy(this.gb_2)
end on

event open;call super::open;//=======================================================================================//
//	Object:			w_master_list
//	Event:			open
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Open event for List windows
//---------------------------------------------------------------------------------------//
//	* Sets Trans Objects for datawindow controls
//	* Retrieves Search Datawindow
//	* Retrieves List window
//	* Sets Admin level
// * Populates Windows Ops
//=======================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------
//	09/20/04 MikeF	5.3		Created
//	06/10/05 MikeF	SPR4319d	Added call to fx_dw_syntax to set decode structure
// 10/05/05 MikeF	SPR4537d Saving List window as a report saves just the Row Details
//=======================================================================================//
int	li_rc

// Search
dw_search.SetTransObject( Stars2ca )
dw_search.of_SetUpdateable( FALSE )
dw_search.InsertRow( 0 )
this.event ue_retrieve_search( )

// List
li_rc = fx_dw_syntax(this.classname(), dw_list, istr_decode_struct, stars2ca) 
dw_list.SetTransObject( Stars2ca )
dw_list.of_SetUpdateable( FALSE )
is_orig_list_sql = dw_list.Describe("DataWindow.Table.Select")

IF ib_auto_list THEN
	this.event ue_retrieve_list( )
END IF

// Check/Set security settings
IF gv_user_sl = "AD" THEN
	ib_admin_user 		= TRUE
END IF

this.event ue_set_access( )

// Populate windows ops
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

// Set print dw
idw_print = dw_list
end event

event ue_preopen;call super::ue_preopen;//=======================================================================================//
//	Object:			w_master_list
//	Event:			ue_preopen
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Pre-Open event for List windows
//---------------------------------------------------------------------------------------//
//	* Alters visible/location properties based on whether or not to display Update/Details
//
// -------- ----- -----------	-------------------------------------------------------------
//	09/20/04 MikeF	5.3			Created
// 08/15/05 MikeF	Track 4485d	Initialize uo_range 
//	09/12/05	GaryR	Track 4444d	Fix non-details mode logic
//=======================================================================================//

// Details
IF ib_display_details THEN
	dw_details.SetTransObject( Stars2ca )
	dw_list.of_SetUpdateable( TRUE )
ELSE
	cb_update.visible  = FALSE
	dw_details.visible = FALSE
	gb_details.visible = FALSE
END IF

uo_range.visible = ib_display_daterange
IF ib_display_daterange THEN
	uo_range.event ue_initialize()
END IF

end event

type cb_close from commandbutton within w_master_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3054
integer y = 1612
integer width = 343
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;Close(parent)
end event

type uo_range from uo_date_range within w_master_list
string tag = "RANGE"
boolean visible = false
string accessiblename = "Date Range Options"
string accessibledescription = "Date Range Options"
integer x = 2199
integer y = 84
integer width = 901
integer height = 372
integer taborder = 20
end type

on uo_range.destroy
call uo_date_range::destroy
end on

type st_dw_ops from statictext within w_master_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 1628
integer width = 535
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Window Operations:"
boolean focusrectangle = false
end type

type cb_delete from commandbutton within w_master_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3008
integer y = 1988
integer width = 343
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Delete"
end type

event clicked;parent.event ue_delete( )
end event

type cb_reset from commandbutton within w_master_list
string accessiblename = "Reset"
string accessibledescription = "Reset"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3008
integer y = 1752
integer width = 343
integer height = 108
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Reset"
end type

event clicked;parent.event ue_reset( )
end event

type cb_add from commandbutton within w_master_list
string accessiblename = "Add"
string accessibledescription = "Add"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3008
integer y = 1604
integer width = 343
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Add"
end type

event clicked;parent.event ue_insert( )
end event

type dw_details from u_dw within w_master_list
string tag = "NO SAVE"
string accessiblename = "Row Details"
string accessibledescription = "Row Details"
integer x = 64
integer y = 1768
integer width = 2907
integer height = 276
integer taborder = 80
boolean border = false
end type

event clicked;call super::clicked;// 08/12/05 MikeF SPR4472d	Cell copy/paste not working
SetFocus(this)
end event

type st_rows from statictext within w_master_list
boolean visible = false
string accessiblename = "none"
string accessibledescription = "none"
accessiblerole accessiblerole = statictextrole!
integer x = 2985
integer y = 1644
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_update from commandbutton within w_master_list
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3008
integer y = 1872
integer width = 343
integer height = 108
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Update"
end type

event clicked;int	li_rc

dw_details.AcceptText()

li_rc = Parent.Event ue_save()

ll_update_row = dw_list.Getselectedrow( 0 )

IF li_rc = 1 THEN
	parent.event ue_retrieve_list( )
END IF
end event

type cb_list from commandbutton within w_master_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3072
integer y = 228
integer width = 343
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&List"
boolean default = true
end type

event clicked;

parent.event ue_retrieve_list( )

end event

type dw_list from u_dw within w_master_list
event ue_delete ( )
event ue_reset ( )
string accessiblename = "List"
string accessibledescription = "List"
integer x = 27
integer y = 556
integer width = 3360
integer height = 1036
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_singleselect = true
boolean ib_isupdateable = false
end type

event doubleclicked;call super::doubleclicked;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

int tabpos,rc
long lv_row_nbr
string lv_hold_object,lv_col

setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_list)
If lv_hold_object = '' then return

tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
	If is_operation <> '1' Then
		Messagebox('Information','You must select an option from Window Operations')
	Else
		ddlb_dw_ops.triggerevent(selectionchanged!)
	End If
	rc = fx_dw_control(dw_list,lv_hold_object,is_dw_control,iw_uo_win,'',0,istr_decode_struct)
ElseIf is_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
	rc = fx_dw_control(dw_list,lv_hold_object,is_dw_control,iw_uo_win,'cell',lv_row_nbr,istr_decode_struct)
ElseIf is_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
	rc = fx_dw_control(dw_list,lv_hold_object,is_dw_control,iw_uo_win,'cell',lv_row_nbr,istr_decode_struct)
ELSEIF dw_list.getselectedrow(0) > 0 THEN
	parent.event ue_list_row_doubleclicked( )
End If
end event

event rowfocuschanged;call super::rowfocuschanged;///////////////////////////////////////////////////////////////////////////
//
//	09/12/05	GaryR	Track 4444d	Fix non-details mode logic
//
///////////////////////////////////////////////////////////////////////////

Long		ll_row


ll_row = dw_list.GetRow()

IF ll_row < 1 THEN Return

IF ib_display_details THEN	
	dw_details.SetRedraw(FALSE)
	
	IF parent.event ue_retrieve_detail( ll_row ) <> 1 THEN
		MessageBox( parent.title, "Error retrieving details for current row" )
		Return
	END IF
	
	dw_details.SetRedraw(TRUE)
END IF	
	
// Enable update / add stuff.
parent.event ue_row_access( )
end event

event rowfocuschanging;call super::rowfocuschanging;///////////////////////////////////////////////////////////////////////////////////////
//
//	05/04/05	GaryR	Track 4366d	Check for pending updates before changing row or refresh
//
///////////////////////////////////////////////////////////////////////////////////////
Parent.event ue_isupdatespending( )
end event

event ue_retrieve;// Override locally
RETURN 0
end event

event clicked;call super::clicked;// 08/12/05 MikeF SPR4472d	Cell copy/paste not working
SetFocus(this)
end event

type dw_search from u_dw within w_master_list
string tag = "NO SAVE"
string accessiblename = "Search Criteria"
string accessibledescription = "Search Criteria"
integer x = 59
integer y = 96
integer width = 2062
integer height = 328
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;// 08/12/05 MikeF SPR4472d	Cell copy/paste not working
SetFocus(this)
end event

type gb_details from groupbox within w_master_list
string accessiblename = "Row details"
string accessibledescription = "Row details"
accessiblerole accessiblerole = groupingrole!
integer x = 32
integer y = 1712
integer width = 3360
integer height = 368
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Row details"
end type

type ddlb_dw_ops from dropdownlistbox within w_master_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Options"
accessiblerole accessiblerole = comboboxrole!
integer x = 567
integer y = 1612
integer width = 955
integer height = 400
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
// 06/13/08	GaryR	SPR5390		Convert Integers to Longs to prevent overflow
//
///////////////////////////////////////////////////////////////////////////

SetPointer( Hourglass! )
is_operation = '1'
is_dw_control = fx_uo_control( iw_uo_win, dw_list, ddlb_dw_ops.text, is_dw_control, st_rows, istr_decode_struct )
end event

type gb_2 from groupbox within w_master_list
string accessiblename = "Search criteria"
string accessibledescription = "Search criteria"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer y = 28
integer width = 2121
integer height = 476
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search criteria"
end type

