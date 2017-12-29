HA$PBExportHeader$w_import_pattern_summary.srw
$PBExportComments$Enter the invoice types and subset ID associated with the imported pattern (inherited from w_master)
forward
global type w_import_pattern_summary from w_master
end type
type cb_cancel from u_cb within w_import_pattern_summary
end type
type cb_print from u_cb within w_import_pattern_summary
end type
type cb_ok from u_cb within w_import_pattern_summary
end type
type st_comment from statictext within w_import_pattern_summary
end type
type st_1 from statictext within w_import_pattern_summary
end type
type gb_1 from groupbox within w_import_pattern_summary
end type
type st_2 from statictext within w_import_pattern_summary
end type
type sle_subset from u_sle within w_import_pattern_summary
end type
type gb_2 from groupbox within w_import_pattern_summary
end type
type dw_import from u_dw within w_import_pattern_summary
end type
end forward

global type w_import_pattern_summary from w_master
string accessiblename = "Pattern Import Summary"
string accessibledescription = "Pattern Import Summary"
integer width = 2309
integer height = 1556
string title = "Pattern Import Summary"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_cancel ( )
event ue_close ( )
event ue_edit_enable_subset ( )
event ue_filter_inv_type_dddw ( long al_row )
event ue_inv_type_change ( long al_row,  string as_data )
cb_cancel cb_cancel
cb_print cb_print
cb_ok cb_ok
st_comment st_comment
st_1 st_1
gb_1 gb_1
st_2 st_2
sle_subset sle_subset
gb_2 gb_2
dw_import dw_import
end type
global w_import_pattern_summary w_import_pattern_summary

type variables
// Parm to this window
sx_import_pattern_summary	istr_summary

// NVO to get the revenue table type for a UB92 
// table type
n_cst_revenue	inv_revenue	

// Datastore to retrieve stars_rel/dictionary
n_ds		ids_stars_rel

// All possible revenue codes for the table types in
// dw_import
String		is_rev_tbl_type[]

// Subset ID returned from w_subset_use
String		is_subset_id

// JasonS 08/27/02 Track 2973d  declare variable for nvo_subset_function
nvo_subset_functions invo_subset_functions
end variables

event ue_cancel;//*********************************************************************************
// Script Name:	ue_cancel
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the Cancel button is clicked.
//						This script will let the calling script know that this
//						window was cancelled.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

istr_summary.s_subset_id				=	'CANCEL'
istr_summary.s_comment					=	st_comment.text
istr_summary.ds_import.object.data	=	dw_import.object.data

CloseWithReturn (This, istr_summary)


end event

event ue_close;//*********************************************************************************
// Script Name:	ue_close
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the OK button is clicked.
//						This script will edit the contents of the window to
//						ensure that all data is entered.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,				&
			ll_rowcount
			
String	ls_tbl_type

// Make sure all table types have been specified

ll_rowcount		=	dw_import.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_tbl_type	=	dw_import.object.tbl_type [ll_row]
	IF	IsNull (ls_tbl_type)			&
	OR	Len (ls_tbl_type)	=	0		THEN
		MessageBox ('Error', 'All invoice types must be selected before continuing '	+	&
						'with the import')
		Return
	END IF
NEXT

// A subset must be selected
IF	sle_subset.text	=	''		THEN
	MessageBox ('Error', 'A subset must be selected before continuing '			+	&
					'with the import.  Make sure all invoice types are selected'	+	&
					' before selecting a subset')
	Return
END IF

istr_summary.s_subset_id				=	is_subset_id
istr_summary.s_subset_name				=	sle_subset.text
istr_summary.s_comment					=	st_comment.text
istr_summary.ds_import.object.data	=	dw_import.object.data

CloseWithReturn (This, istr_summary)


end event

event ue_edit_enable_subset();//*********************************************************************************
// Script Name:	ue_edit_enable_subset
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the window is opened and
//						when an invoice type is selected.
//
//						This script will do two things.  
//						First, it will determine if all 'UB92' table types have
//						been specified and only one exists.  If so, the revenue code is 
//						computed and set in the d/w.
//						Second, if all table types have been entered, then enable
//						the subset button.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
// JasonS 08/27/02 Track 2973d  Remove 'select subset' button
//*********************************************************************************

Boolean	lb_found

Integer	li_idx,					&
			li_upper,				&
			li_rc

Long		ll_row,					&
			ll_rowcount,			&
			ll_dep_row,				&
			ll_find_row,			&
			ll_tbl_count


String	ls_rel_type,			&
			ls_tbl_type,			&
			ls_base_type,			&
			ls_revenue,				&
			ls_empty[],				&
			ls_find,					&
			ls_desc

// Reset the list of revenue codes in case the user changes a table type.
is_rev_tbl_type	=	ls_empty

// Reset any previously filtered data in ids_stars_rel
li_rc	=	ids_stars_rel.SetFilter('')
li_rc	=	ids_stars_rel.Filter()

ll_rowcount			=	dw_import.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_rel_type		=	dw_import.object.rel_type [ll_row]
	ls_tbl_type		=	dw_import.object.tbl_type [ll_row]
	ls_base_type	=	dw_import.object.base_type [ll_row]
	ls_desc			=	dw_import.object.inv_type [ll_row]
	IF	 ls_rel_type	=	'DP'		&
	AND ls_tbl_type	=	''			THEN
		// Found an empty revenue code
		ll_dep_row	=	ll_row
		Continue
	END IF
	IF	ls_base_type	=	'UB92'			THEN
		// Found a UB92 base type
		IF	Len (ls_tbl_type)		>	0		THEN
			// A table type has been assigned to this base type.
			// Get its revenue code and add it to a list of unique
			//	revenue codes.
			ls_revenue	=	inv_revenue.of_get_revenue (ls_tbl_type)
			// Add the revenue code to the list of unique revenue codes.
			lb_found	=	FALSE
			li_upper	=	UpperBound (is_rev_tbl_type)
			FOR	li_idx	=	1	TO	li_upper
				IF	is_rev_tbl_type [li_idx]	=	ls_revenue	THEN
					lb_found	=	TRUE
					Exit
				END IF
			NEXT
			IF	lb_found	=	FALSE		THEN
				// Add the revenue code to the list of unique revenue codes
				li_upper	++
				is_rev_tbl_type [li_upper]	=	ls_revenue
			END IF
		ELSE
			// Even though a UB92 base type was found, at least
			// one of them does not yet have a table type.
			is_rev_tbl_type	=	ls_empty
			Exit
		END IF
	END IF
NEXT

li_upper	=	UpperBound (is_rev_tbl_type)

IF ll_dep_row		>	0		THEN
	// At least one row in dw_import is a revenue table type.
	IF	li_upper		=	1		THEN
		// There exist a revenue table type on the d/w.  All UB92 table types
		//	have been assigned and all of these table types has only one
		// revenue code.  Take this revenue code and add it to the d/w.  First
		// get its description from ids_stars_rel.
		ls_find		=	"rel_type = 'DP' and id_2 = '"	+	is_rev_tbl_type [1]	+	"'"
		ll_find_row	=	ids_stars_rel.Find (ls_find, 1, ids_stars_rel.RowCount())
		ls_desc		=	ids_stars_rel.object.dictionary_elem_desc [ll_find_row]
		dw_import.object.tbl_type [ll_dep_row]		=	is_rev_tbl_type [1]
		dw_import.object.protect_ind [ll_dep_row]	=	'Y'
		dw_import.object.inv_type [ll_dep_row]		=	is_rev_tbl_type [1]	+	' - '	+	ls_desc
	END IF
	IF	li_upper	>	1			THEN
		// There are multiple revenue codes.  Enable the column to allow
		// the user to select which revenue code to choose
		dw_import.object.protect_ind [ll_dep_row]	=	'N'
	END IF
END IF


// Now that revenue code was potentially added to dw_import, loop thru
// dw_import again to determine if cb_subset can be enabled

ll_rowcount		=	dw_import.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_rel_type		=	dw_import.object.rel_type [ll_row]
	ls_tbl_type		=	dw_import.object.tbl_type [ll_row]
	ls_base_type	=	dw_import.object.base_type [ll_row]
	ls_desc			=	dw_import.object.inv_type [ll_row]
	IF	Len (ls_tbl_type)	>	0		THEN
		ll_tbl_count	++
	ELSE
		// At least one row has no table type.  Get Out.
		Exit
	END IF
NEXT

// JasonS 08/27/02 Begin - Track 2973d
//IF	ll_tbl_count	=	ll_rowcount		THEN
//	cb_subset.enabled		=	TRUE
//ELSE
//	cb_subset.enabled		=	FALSE
//END IF
// JasonS 08/27/02 End - Track 2973d



end event

event ue_filter_inv_type_dddw;//*********************************************************************************
// Script Name:	ue_filter_inv_type_dddw
//
//	Arguments:		al_row - Row # in dw_import
//
// Returns:			None
//
//	Description:	Filter the inv_type dddw base on whether this is a main
//						table (rel_type = 'GP') or a revenue table (rel_type = 'DP').
//						If its a revenue table, then is_rev_tbl_type[] will have
//						the list of revenue codes.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_upper,				&
			li_idx,					&
			li_rc

Long		ll_rowcount

String	ls_filter,				&
			ls_protect_ind,		&
			ls_base_type,			&
			ls_rel_type,			&
			ls_desc

DataWindowChild	ldwc

// Edit the input

IF	al_row	<	1		THEN
	Return
END IF

ls_protect_ind		=	dw_import.object.protect_ind [al_row]
ls_base_type		=	dw_import.object.base_type [al_row]
ls_rel_type			=	dw_import.object.rel_type [al_row]
ls_desc				=	dw_import.object.inv_type [al_row]

IF	ls_protect_ind	=	'Y'		THEN
	// The column is protected, don't bother with filtering the DDDW
	Return
END IF

IF	ls_rel_type		=	'DP'		THEN
	// Revenue table
	li_upper			=	UpperBound (is_rev_tbl_type)
	IF	li_upper	<	1		THEN
		// Should never happen.  If it does, there is nothing to filter
		Return
	END IF
	FOR	li_idx	=	1	TO	li_upper
		ls_filter	=	ls_filter	+	" or id_2 = '"	+	is_rev_tbl_type [li_idx]	+	"'"
	NEXT
	// Remove the leading ' or '
	ls_filter		=	Mid (ls_filter, 5)
	ls_filter		=	"rel_type = 'DP' and (" +	ls_filter	+	")"
ELSE
	// Main table.  Filter by base type
	ls_filter		=	"rel_type = 'QT' and key6 = '"	+	ls_base_type	+	"'"
END IF

// Filter the DDDW

li_rc	=	dw_import.GetChild ('inv_type',	ldwc)

li_rc	=	ldwc.SetFilter ('')
li_rc	=	ldwc.Filter ()
li_rc	=	ldwc.SetFilter (ls_filter)
li_rc	=	ldwc.Filter ()

ll_rowcount	=	ldwc.RowCount()
end event

event ue_inv_type_change(long al_row, string as_data);//*********************************************************************************
// Script Name:	ue_inv_type_change
//
//	Arguments:		1.	al_row - Row # in dw_import
//						2.	as_data - The new inv_type value in dw_import.
//
// Returns:			None
//
//	Description:	This event is triggered when the invoice type is changed.
//
//						This script will do two things.  
//						First, if the invoice type is a main table, clear out the
//						existing revenue codes.  Next, execute the script to
//						determine if all 'UB92' table types have been specified and 
//						only one exists.  If so, the revenue code is computed and 
//						set in the d/w.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
// 03/20/03 JasonS Track 3072 don't reset subset on change
//*********************************************************************************

String		ls_rel_type,		&
				ls_inv_type

Long			ll_row,				&
				ll_rowcount



dw_import.object.tbl_type [al_row]	=	Left (as_data, 2)		// Set the table type

// If this invoice type is a main table, clear out the revenue code in the drop-down.

ls_rel_type	=	dw_import.object.rel_type [al_row]

IF	ls_rel_type	=	'GP'		THEN
	// This invoice type is a main table, clear out all dependent tables
	ll_rowcount	=	dw_import.RowCount()
	FOR	ll_row	=	1	TO	ll_rowcount
		ls_rel_type	=	dw_import.object.rel_type [ll_row]
		IF	ls_rel_type	=	'DP'		THEN
			dw_import.object.tbl_type [ll_row]	=	''
			dw_import.object.inv_type [ll_row]	=	''
		END IF
	NEXT
END IF

// Determine if the subset button is to be enabled and if
//	the revenue code can be set.
This.Post	Event	ue_edit_enable_subset()

end event

on w_import_pattern_summary.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.cb_ok=create cb_ok
this.st_comment=create st_comment
this.st_1=create st_1
this.gb_1=create gb_1
this.st_2=create st_2
this.sle_subset=create sle_subset
this.gb_2=create gb_2
this.dw_import=create dw_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_comment
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.sle_subset
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.dw_import
end on

on w_import_pattern_summary.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.cb_ok)
destroy(this.st_comment)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.sle_subset)
destroy(this.gb_2)
destroy(this.dw_import)
end on

event open;call super::open;//*********************************************************************************
// Script Name:	Open
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will load the window from the structure.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
// JasonS 08/27/02 Track 2973d  instantiate nvo_subset_functions
// JasonS 03/20/03 Track 3072d  Set initial subset id
//*********************************************************************************

Integer	li_rc,					&
			li_sequence_num

Long		ll_rowcount,			&
			ll_row,					&
			ll_new_row,				&
			ll_find_row,			&
			ll_rel_count

String	ls_rel_type,			&
			ls_inv_type,			&
			ls_inv_type_desc,		&
			ls_base_type,			&
			ls_tbl_type,			&
			ls_protect_ind,		&
			ls_filter,				&
			ls_description

DataWindowChild	ldwc

invo_subset_functions = create nvo_subset_functions	// JasonS 08/27/02 Track 2973d

st_comment.text			=	istr_summary.s_comment
sle_subset.text			=	istr_summary.s_subset_id
//dw_import.object.data	=	istr_summary.ds_import.object.data

// Create the datastore to read starsrel and dictionary
ids_stars_rel	=	CREATE	n_ds
ids_stars_rel.DataObject	=	'd_stars_rel_dict'
ids_stars_rel.SetTransObject (Stars2ca)
ll_rowcount	=	ids_stars_rel.Retrieve()

// Loop thru the datastore sent to this window and load dw_import.

ll_rowcount		=	istr_summary.ds_import.RowCount()
FOR	ll_row	=	1	TO	ll_rowcount
	li_sequence_num		=	istr_summary.ds_import.object.sequence_num [ll_row]
	ls_base_type			=	istr_summary.ds_import.object.base_type [ll_row]
	ls_inv_type				=	istr_summary.ds_import.object.inv_type [ll_row]
	ls_inv_type_desc		=	istr_summary.ds_import.object.inv_type_desc [ll_row]
	ls_rel_type				=	istr_summary.ds_import.object.rel_type [ll_row]
	ls_tbl_type				=	istr_summary.ds_import.object.tbl_type [ll_row]
	ls_protect_ind			=	istr_summary.ds_import.object.protect_ind [ll_row]
	ll_new_row				=	dw_import.InsertRow(0)
	dw_import.object.sequence_num [ll_new_row]	=	li_sequence_num
	dw_import.object.base_type [ll_new_row]		=	ls_base_type
	dw_import.object.inv_type [ll_new_row]			=	ls_inv_type
	dw_import.object.inv_type_desc [ll_new_row]	=	ls_inv_type_desc
	dw_import.object.rel_type [ll_new_row]			=	ls_rel_type
	dw_import.object.tbl_type [ll_new_row]			=	ls_tbl_type
	dw_import.object.protect_ind [ll_new_row]		=	ls_protect_ind
	dw_import.object.inv_type [ll_new_row]			=	''
	IF	ls_rel_type	=	'DP'		THEN
		// Dependent table (revenue).  Get the dependent table types for
		// this base type.
		ls_filter	=	"rel_type = 'DP'"
		// Protect revenue table until all UB92 table types are determined
		dw_import.object.protect_ind [ll_new_row]	=	'Y'
	ELSE
		ls_filter	=	"rel_type = 'QT' and key6 = '"	+	ls_base_type	+	"'"
	END IF
	li_rc	=	ids_stars_rel.SetFilter('')
	li_rc	=	ids_stars_rel.Filter()
	li_rc	=	ids_stars_rel.SetFilter(ls_filter)
	li_rc	=	ids_stars_rel.Filter()
	ll_rel_count	=	ids_stars_rel.RowCount()
	IF	ll_rel_count	=	1		THEN
		// Only one table type exists for this base type, set it in dw_import
		ls_inv_type											=	ids_stars_rel.object.id_2 [1]
		ls_description										=	ids_stars_rel.object.dictionary_elem_desc [1]
		dw_import.object.tbl_type [ll_new_row]		=	ls_inv_type
		dw_import.object.protect_ind [ll_new_row]	=	'Y'
		dw_import.object.inv_type [ll_new_row]		=	ls_inv_type	+	' - '	+	ls_description
	END IF
NEXT

// Retrieve the DDDW (since no insertrow or retrieve occured with dw_import)
li_rc	=	dw_import.GetChild ('inv_type',	ldwc)
ldwc.SetTransObject (Stars2ca)
ll_rowcount	=	ldwc.Retrieve()

// Determine if the subset button is to be enabled
This.Event	ue_edit_enable_subset()

// Filter the DDDW for the 1st row
This.Event	ue_filter_inv_type_dddw (1)

// Create the NVO to get the revenue code for a UB92 table type
inv_revenue		=	CREATE	n_cst_revenue

sle_subset.text = gc_active_subset_id
sle_subset.triggerevent(LoseFocus!)
end event

event ue_preopen;//*********************************************************************************
// Script Name:	ue_preopen
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will receive the structure from the calling script.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

istr_summary	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

end event

event ue_print;//*********************************************************************************
// Script Name:	ue_print - Override the ancestor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will print dw_import.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

//dw_import.Print ()

Long		ll_job

SetPointer (HourGlass!)

ll_Job	=	PrintOpen( )

This.Print(ll_Job, 500,1000)

PrintClose(ll_Job)

end event

event close;call super::close;//*********************************************************************************
// Script Name:	Close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Destroy any previously created.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
// JasonS 08/27/02 Track 2973d  destroy nvo_subset_functions
//*********************************************************************************

destroy invo_subset_functions	// JasonS 08/27/02 Track 2973d

IF	IsValid (inv_revenue)		THEN
	Destroy	inv_revenue
END IF

IF	IsValid (ids_stars_rel)		THEN
	Destroy	ids_stars_rel
END IF


end event

type cb_cancel from u_cb within w_import_pattern_summary
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 1911
integer y = 1336
integer taborder = 40
string text = "&Cancel"
end type

event clicked;Parent.Event	ue_cancel()

end event

type cb_print from u_cb within w_import_pattern_summary
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 1024
integer y = 1336
integer taborder = 30
string text = "&Print"
end type

event clicked;Parent.Event	ue_print()

end event

type cb_ok from u_cb within w_import_pattern_summary
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 119
integer y = 1336
integer taborder = 20
string text = "&OK"
end type

event clicked;Parent.Event	ue_close()
end event

type st_comment from statictext within w_import_pattern_summary
string accessiblename = "Comments"
string accessibledescription = "Comments"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 92
integer width = 2217
integer height = 316
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_import_pattern_summary
string accessiblename = "Comments"
string accessibledescription = "Comments"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 12
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Comments:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_import_pattern_summary
string accessiblename = "Subset"
string accessibledescription = "Subset"
accessiblerole accessiblerole = groupingrole!
integer x = 224
integer y = 1112
integer width = 1847
integer height = 176
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Subset"
end type

type st_2 from statictext within w_import_pattern_summary
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 334
integer y = 1180
integer width = 338
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Subset ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_subset from u_sle within w_import_pattern_summary
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Subset ID"
string accessibledescription = "Lookup Field - Subset ID"
integer x = 686
integer y = 1168
integer width = 773
integer height = 96
boolean bringtotop = true
long textcolor = 134217747
long backcolor = 134217731
end type

event losefocus;call super::losefocus;// JasonS 08/27/02 Begin - Track 2973d Validate subset id
// JasonS 03/20/03 JasonS Track 3072d set is_subset_id
long ll_retval

if trim(this.text) <> '' then
	ll_retval = invo_subset_functions.uf_isvalid_subset(this.text, 'I')

	if ll_retval = -1 then
		Messagebox("Error", "Invalid Subset ID. ~r~nPlease choose another.")
		this.setfocus()
	else
		is_subset_id = this.text
	end if
end if
// JasonS 08/27/02 End - Track 2973d
end event

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_subset
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This script will open w_subset_use to allow the user to
//						select a subset associated with the main table types.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

Long		ll_row,				&
			ll_rowcount
			
String	ls_tbl_type,		&
			ls_rel_type,		&
			ls_subc_tables

sx_subset_use		lstr_subset_use

ll_rowcount		=	dw_import.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_tbl_type	=	dw_import.object.tbl_type [ll_row]
	ls_rel_type	=	dw_import.object.rel_type [ll_row]
	IF	IsNull (ls_tbl_type)			&
	OR	Len (ls_tbl_type)	=	0		THEN
		MessageBox ('Error', 'All invoice types must be selected before selecting '	+	&
						'a subset')
		Return
	END IF
	IF	ls_rel_type	<>	'DP'		THEN
		// Main table
		ls_subc_tables	=	ls_subc_tables	+	'+'	+	ls_tbl_type
	END IF
NEXT

// Remove the leading '+'
ls_subc_tables		=	Mid (ls_subc_tables, 2)

// Before opening w_subset_use, the following globals must be set.
gv_subset_tbl_type	=	gv_active_invoice
gv_from					=	'U'
gv_result				=	0

IF	Len (ls_subc_tables)	>	2		THEN
	// ML subset
	lstr_subset_use.subc_tables	=	ls_subc_tables
ELSE
	// Single invoice type
	lstr_subset_use.inv_type		=	ls_subc_tables
	gv_subset_tbl_type				=	ls_subc_tables
END IF

OpenWithParm (w_subset_use, lstr_subset_use)
IF	gv_result	=	100		THEN	Return

This.text	=	gc_active_subset_name
is_subset_id		=	gc_active_subset_id
end event

type gb_2 from groupbox within w_import_pattern_summary
string accessiblename = "Invoice"
string accessibledescription = "Invoice"
accessiblerole accessiblerole = groupingrole!
integer x = 224
integer y = 420
integer width = 1847
integer height = 664
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Invoice"
end type

type dw_import from u_dw within w_import_pattern_summary
string accessiblename = "Import Pattern Summary"
string accessibledescription = "Import Pattern Summary"
integer x = 288
integer y = 484
integer width = 1746
integer height = 580
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_import_pattern_summary"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;//*********************************************************************************
// Script Name:	dw_import.Itemchanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Trigger the script to determine if the subset button is
//						to be enabled.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

CHOOSE CASE	dwo.name
	CASE	'inv_type'
		Parent.Event	ue_inv_type_change (row, data)
END CHOOSE


end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_import.RowfocusChanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Filter the contents of the DDDW.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	currentrow	>	0		THEN
	Parent.Event	ue_filter_inv_type_dddw (currentrow)
END IF

end event

