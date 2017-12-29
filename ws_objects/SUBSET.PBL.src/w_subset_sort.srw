$PBExportHeader$w_subset_sort.srw
$PBExportComments$Sorts, Totals and provides Level breaks for Subset View (Inherited from w_master)
forward
global type w_subset_sort from w_master
end type
type st_2 from statictext within w_subset_sort
end type
type st_1 from statictext within w_subset_sort
end type
type cbx_counts from checkbox within w_subset_sort
end type
type cb_clear from u_cb within w_subset_sort
end type
type cb_ok from u_cb within w_subset_sort
end type
type cb_cancel from u_cb within w_subset_sort
end type
type dw_sortedby from u_dw within w_subset_sort
end type
type dw_displayed from u_dw within w_subset_sort
end type
type dw_total_buttons from u_dw within w_subset_sort
end type
end forward

shared variables

end variables

global type w_subset_sort from w_master
string accessiblename = "Sort Fields Selection"
string accessibledescription = "Sort Fields Selection"
accessiblerole accessiblerole = windowrole!
integer x = 960
integer y = 364
integer width = 1733
integer height = 1680
string title = "Sort Fields Selection"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
st_1 st_1
cbx_counts cbx_counts
cb_clear cb_clear
cb_ok cb_ok
cb_cancel cb_cancel
dw_sortedby dw_sortedby
dw_displayed dw_displayed
dw_total_buttons dw_total_buttons
end type
global w_subset_sort w_subset_sort

type variables
Protected:

Boolean           ib_First
Constant String ICS_NOTOTALS = 'N'  // default to no totals
Constant String ICS_COLUMNSORT = 'col_desc A'  // sort ascending on col_desc

// 01/26/06	GaryR	Track 4555d	Improve flow of cancel and retain previuos selections
sx_break_info	istr_break_info
end variables

on w_subset_sort.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.cbx_counts=create cbx_counts
this.cb_clear=create cb_clear
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_sortedby=create dw_sortedby
this.dw_displayed=create dw_displayed
this.dw_total_buttons=create dw_total_buttons
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cbx_counts
this.Control[iCurrent+4]=this.cb_clear
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.dw_sortedby
this.Control[iCurrent+8]=this.dw_displayed
this.Control[iCurrent+9]=this.dw_total_buttons
end on

on w_subset_sort.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_counts)
destroy(this.cb_clear)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_sortedby)
destroy(this.dw_displayed)
destroy(this.dw_total_buttons)
end on

event ue_postopen;call super::ue_postopen;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_subset_sort				ue_PostOpen		
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Will load dw_display will the columns passed in. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		02/06/98		Created.
//
// FNC			05/27/98		Track 1252. Pass sx_break_info inside of sx_col_desc_parm. 
//									SX_break_info contains any previously selected break info.
//									Any data in this structure is loaded into the sorted by dw.
// Katie			12/15/04		Track 4121d Added code for col_name and col_number in sx_break_info
//	GaryR			02/03/05		Track 4271d	Fix col_number when resetting existing totals columns
// GaryR			01/26/06		Track 4555d	Improve flow of cancel and retain previuos selections
//////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)


sx_col_desc_parm lsx_ColumnParm	// structure to permit passing of array in message object.
sx_col_desc lsx_col_desc[] /* defined in ts-144 uo_query */

Integer 	li_Index,		&
			li_Count,		&
			li_break_cols,	&
			li_col,			&
			li_found,		&
			li_dw_totals_row

string	ls_find
// get the array of structures from message object
lsx_ColumnParm = message.PowerObjectParm	

//assign the array of structures to local
lsx_col_desc = lsx_ColumnParm.Columns

li_dw_totals_row = dw_total_buttons.insertrow(0)

li_count = upperbound(lsx_col_desc)			

for li_Index = 1 to li_count
	dw_displayed.insertrow(li_Index)
	dw_displayed.object.col_desc[li_Index] = lsx_col_desc[li_Index].col_desc
	dw_displayed.object.data_type[li_Index] = lsx_col_desc[li_Index].data_type
	dw_displayed.object.col_name[li_Index] = lsx_col_desc[li_Index].col_name
	dw_displayed.object.col_number[li_Index] = lsx_col_desc[li_Index].col_number
next

//05/27/98 FNC Start
/*Have break columns already been selected. If so load them in the sorted by DW.*/
li_break_cols = upperbound(lsx_columnparm.break_info.cols)
if li_break_cols > 0 then
	for li_col = 1 to li_break_cols
		ls_find = "col_desc = '" + lsx_columnparm.break_info.cols[li_col].col_desc + "'"
		li_found = dw_displayed.find(ls_find,1,li_index)
		if li_found > 0 then
			//	Found the column in dw_displayed.  Move the data to dw_sortedby
			//	Then remove the row from dw_displayed.
			dw_displayed.setrow(li_found)
			dw_displayed.RowsDiscard (li_found, li_found, Primary!)
			dw_sortedby.object.col_desc[li_col] = &
				lsx_columnparm.break_info.cols[li_col].col_desc
			dw_sortedby.object.data_type[li_col] = &
				lsx_columnparm.break_info.cols[li_col].col_data_type
			dw_sortedby.object.options[li_col] = &
				lsx_columnparm.break_info.cols[li_col].options
			dw_sortedby.object.sort[li_col] =  &
				lsx_columnparm.break_info.cols[li_col].sort
			dw_sortedby.object.col_name[li_col] =  &
				lsx_columnparm.break_info.cols[li_col].col_name
			dw_sortedby.object.col_number[li_col] =  &
				lsx_columnparm.break_info.cols[li_col].col_number
		else
			MessageBox ('Error', 'Unable to find previously selected break col'  + &
							' in w_subset_sort.ue_postopen.  ' + &
							'The find string = ' + ls_find + '.  Row # =' + String(li_col) + '.')
		end if
	next	
	cbx_counts.checked = lsx_columnparm.break_info.counts 
	dw_total_buttons.object.totals[li_dw_totals_row] = lsx_columnparm.break_info.totals
	// Reinitialize the instance structure to maintain data
	istr_break_info = lsx_columnparm.break_info
else
	cbx_counts.checked = TRUE
end if
//FNC 05/27/98 End


//ib_first = TRUE		// FNC 05/27/98 - not used
end event

event close;call super::close;// 01/26/06	GaryR	Track 4555d	Improve flow of cancel and retain previuos selections

// Return the structure to the caller
message.powerobjectparm = istr_break_info
end event

type st_2 from statictext within w_subset_sort
string accessiblename = "Sorted By"
string accessibledescription = "Sorted By"
accessiblerole accessiblerole = statictextrole!
integer x = 869
integer y = 332
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Sorted By:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_subset_sort
string accessiblename = "Displayed"
string accessibledescription = "Displayed"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 332
integer width = 352
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Displayed:"
boolean focusrectangle = false
end type

type cbx_counts from checkbox within w_subset_sort
string accessiblename = "Counts for Level Breaks"
string accessibledescription = "Counts for Level Breaks"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 32
integer y = 1300
integer width = 887
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Counts for Level Breaks"
end type

type cb_clear from u_cb within w_subset_sort
string accessiblename = "Clear"
string accessibledescription = "Clear"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 718
integer y = 1424
integer taborder = 60
integer weight = 400
string text = "C&lear"
end type

event clicked;call super::clicked;// Will move all entries from dw_sortby to dw_display.

Long ll_SortedByCount, ll_MoveToRow
integer li_row

ll_SortedByCount = dw_sortedby.rowcount()
ll_MoveToRow = dw_displayed.rowcount() + 1

dw_sortedby.RowsMove(1,ll_SortedByCount,Primary!,dw_displayed,ll_MoveToRow,Primary!)

/* enable dw_total_buttons and select All Money & Quantities */
dw_total_buttons.Enabled = TRUE
li_row = dw_total_buttons.getrow()
dw_total_buttons.object.totals[li_row] = 'A'

// sort the displayed dw
dw_displayed.SetRedraw(False)
dw_displayed.SetSort(ICS_COLUMNSORT)
dw_displayed.Sort()
dw_displayed.SetRedraw(True)

end event

type cb_ok from u_cb within w_subset_sort
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 315
integer y = 1424
integer taborder = 50
integer weight = 400
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////
//
// Loop thru dw_sortby and load into the structure (sx_break_info) 
// Also get counts and totals info.  Close with return.
//
//////////////////////////////////////////////////////////////////////////////////////////////
//
// 12/15/04 Katie	Track 4121d Added code for col_name and col_number in sx_break_info
// 01/26/06	GaryR	Track 4555d	Improve flow of cancel and retain previuos selections
//
//////////////////////////////////////////////////////////////////////////////////////////////

sx_break_info	lsx_clear
Long ll_count, ll_Index, ll_Row

ll_count = dw_sortedby.rowcount()

// Reset the instance structure in case there 
// were changes from the previous operation
istr_break_info = lsx_clear

//NLG 5-18-98 moved next two lines up from below
istr_break_info.counts = cbx_counts.checked
istr_break_info.totals = ICS_NOTOTALS	// default to no totals

if ll_count = 0 then
	Close( Parent )								//NLG 5-18-98 
	return											//NLG 5-18-98
end if

//lsx_break_info.counts = cbx_counts.checked //NLG 5-18-98 move above
ll_Row = dw_total_buttons.GetRow()
//lsx_break_info.totals = ICS_NOTOTALS	// default to no totals //NLG 5-18-98 move above

If ll_Row > 0 Then &
	istr_break_info.totals = dw_total_buttons.object.totals[ll_row]

for ll_Index = 1 to ll_count
	istr_break_info.cols[ll_Index].col_desc = dw_sortedby.object.col_desc[ll_Index]
	istr_break_info.cols[ll_Index].col_data_type = dw_sortedby.object.data_type[ll_Index]
	istr_break_info.cols[ll_Index].options = dw_sortedby.object.options[ll_Index]
	istr_break_info.cols[ll_Index].sort = dw_sortedby.object.sort[ll_Index]
	istr_break_info.cols[ll_Index].col_name = dw_sortedby.object.col_name[ll_Index]
	istr_break_info.cols[ll_Index].col_number = dw_sortedby.object.col_number[ll_Index]
next

Close( Parent )
end event

type cb_cancel from u_cb within w_subset_sort
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1120
integer y = 1424
integer taborder = 70
integer weight = 400
string text = "&Cancel"
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	cb_cancel					clicked		
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Close parent and pass empty structure back.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/06/98		Created.
// GaryR				01/26/06		Track 4555d	Improve flow of cancel 
//														and retain previuos selections
//
/////////////////////////////////////////////////////////////////////////////

Close( Parent )
end event

type dw_sortedby from u_dw within w_subset_sort
string accessiblename = "Fields Sorted By"
string accessibledescription = "Fields Sorted By"
accessiblerole accessiblerole = clientrole!
integer x = 869
integer y = 424
integer width = 773
integer height = 832
integer taborder = 40
string dataobject = "d_ss_sort_columns"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	dw_sortedby					clicked		
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// When a column name is selected, must move the column to back to dw_selected. 
// Do not have to worry about clearing out options or sort fields since if used again 
// will be overwritten.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			xpos		Integer
//					ypos		Integer
//					row		Long
//					dwo		DwObject
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/06/98		Created.
//	FDG				01/25/99		Track 2076c.  If the row # = 0, get out.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_MoveToRow

// FDG 01/25/99 begin
IF	row	<	1		THEN
	Return
END IF
// FDG 01/25/99 end

ll_MoveToRow = dw_displayed.RowCount() + 1

this.RowsMove(row,row,Primary!,dw_displayed,ll_MoveToRow,Primary!)

// sort the displayed dw
dw_displayed.SetRedraw(False)
dw_displayed.SetSort(ICS_COLUMNSORT)
dw_displayed.Sort()
dw_displayed.SetRedraw(True)
end event

event constructor;call super::constructor;this.of_SetUpdateable(False)
this.of_SingleSelect(True)
end event

type dw_displayed from u_dw within w_subset_sort
string accessiblename = "Fields Displayed"
string accessibledescription = "Fields Displayed"
accessiblerole accessiblerole = clientrole!
integer x = 37
integer y = 424
integer width = 773
integer height = 832
integer taborder = 20
string dataobject = "d_ss_sort_columns"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	dw_displayed				clicked		
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// When a column name is selected, if it is the first time must allow the user to back 
// out and select the totaling information first else open the options window 
// (w_subset_popup) and takes the info returned from the window and loads into dw_
// sortby with the column name.  First does a move and then loads in the info.	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			xpos		Integer
//					ypos		Integer
//					row		Long
//					dwo		DwObject
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		02/06/98		Created.
// FNC			05/27/98		Track 1110. Remove message advising user to select
//									totalling information.
//	FNC			5/28/98		Track 1252. Don't sort the sorted by dw by col_desc
//									The sorted by datawindow should stay in the order in
//									which the user selects it.
//	FDG			01/25/99		Track 2076c.  If the row # = 0, get out.
// Katie			12/15/04		Track 4121d Added code for col_name and col_number in sx_break_info
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_Row, ll_MoveToRow
Integer i_Return
sx_popup_parm lsx_popup_parms
String ls_return

// check if first pass
// FNC 05/27/98 Start
//if ib_first then
//	// check if user has selected from total button dw
//	If MessageBox("Sort","Must determine totals for Selected Fields before "+ &
//					"selecting Break/Sort columns. If you continue, you will not be able to change "+ &
//					"this selection. Would you like to return and make "+ &
//					"this selection?" ,Question!,YesNo!) = 1 Then
//		return
//	else
//		/* disable dw_total_button dw */
//		dw_total_buttons.enabled = FALSE
//	end if
//		ib_first = FALSE
//end if
// FNC 05/27/98 End

// FDG 01/25/99 begin
IF	row	<	1		THEN
	Return
END IF
// FDG 01/25/99 end

lsx_popup_parms.col_desc = this.object.col_desc[row]
lsx_popup_parms.data_type = this.object.data_type[row]
lsx_popup_parms.col_name = this.object.col_name[row]
lsx_popup_parms.col_number = this.object.col_number[row]
ll_Row = dw_total_buttons.GetRow()
lsx_popup_parms.totals = ICS_NOTOTALS	// default to no totals

If ll_Row > 0 Then &
	lsx_popup_parms.totals = dw_total_buttons.object.totals[ll_row]

OpenWithParm(w_subset_popup,lsx_popup_parms)

ls_return = message.StringParm

ll_MoveToRow = dw_sortedby.rowcount() + 1

IF row > 0 THEN
	// move the clicked row to sortedby dw
	this.RowsMove(row,row,Primary!,dw_sortedby,ll_MoveToRow,Primary!)
END IF

// FNC 05/28/98 Start
// sort the sorted by dw
//dw_sortedby.SetRedraw(False)
//dw_sortedby.SetSort(ICS_COLUMNSORT)
//dw_sortedby.Sort()
//dw_sortedby.SetRedraw(True)
// FNC 05/28/98 End

// set the non visible column values
dw_sortedby.object.options[ll_MoveToRow] = Left(ls_return,1)
dw_sortedby.object.sort[ll_MoveToRow] = Mid(ls_return,2)
end event

event constructor;call super::constructor;this.of_SetUpdateable(False)
this.of_SingleSelect(True)
end event

type dw_total_buttons from u_dw within w_subset_sort
string accessiblename = "Totals Options"
string accessibledescription = "Totals Options"
accessiblerole accessiblerole = clientrole!
integer x = 41
integer y = 32
integer width = 1582
integer height = 292
integer taborder = 10
string dataobject = "d_total_buttons"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetUpdateable(False)
end event

