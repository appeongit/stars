$PBExportHeader$u_align_columns.sru
$PBExportComments$Inherited from u_base <gui>
forward
global type u_align_columns from u_base
end type
type cb_delete from u_cb within u_align_columns
end type
type cb_insert from u_cb within u_align_columns
end type
type dw_col_align from u_dw within u_align_columns
end type
type cb_align from u_cb within u_align_columns
end type
type cb_clear from u_cb within u_align_columns
end type
end forward

global type u_align_columns from u_base
string accessiblename = "Align Columns"
string accessibledescription = "Align Columns"
integer width = 1714
integer height = 408
boolean border = false
cb_delete cb_delete
cb_insert cb_insert
dw_col_align dw_col_align
cb_align cb_align
cb_clear cb_clear
end type
global u_align_columns u_align_columns

type variables
u_dw	iudw_requestor
end variables

forward prototypes
public function integer of_insertaligndata (string as_col_nam, string as_dbcol_nam, u_dw audw_requestor)
public subroutine of_filtercolumns ()
public function long of_populatecolumns (ref u_dw audw_requestor)
end prototypes

public function integer of_insertaligndata (string as_col_nam, string as_dbcol_nam, u_dw audw_requestor);//*********************************************************************************
// Script Name:	u_align_columns::of_InsertAlignData
//
// Arguments: String - as_col_nam
//					String - as_dbcol_nam
//					U_dw - audw_requestor
//
// Returns:		Integer
//
// Description:	Inserts alignment information passed from 
//							the query engine window operations process
//
//*********************************************************************************
//
// 	04/18/00 	Gary Rubalsky 	STARS 4.5 TS1707c	Report Column Alignment
//	09/25/00 	Gary Rubalsky 	STARS 4.5 TS1707c	Check for duplicate choice
//	01/13/03		GaryR				Track 2868d				Fix logic for duplicate column names
//	04/22/09		Katie				GNL.600.5633			Added call to of_filtercolumns
//	05/29/09		Katie				GNL.600.5633			Enable delete button.
//	07/17/09		GaryR				WIN.650.5721.002		Standardize logic that removes return characters
//
//*********************************************************************************

Int		li_NewRow
n_cst_string	lnv_string

// Validate argumants
IF IsNull( as_col_nam ) OR Trim( as_col_nam ) = "" THEN RETURN -1
IF IsNull( as_dbcol_nam ) OR Trim( as_dbcol_nam ) = "" THEN RETURN -1
IF IsNull( audw_requestor ) OR NOT IsValid( audw_requestor ) THEN RETURN -1

// Remove the return character from the label
lnv_string.of_clean_label( as_col_nam )

//09/25/2000 Gary Rubalsky Begin
// Check for duplicate choice.
IF dw_col_align.RowCount() > 0 THEN
	IF dw_col_align.Find( "col_nam = '" + as_col_nam + "'", 1, dw_col_align.RowCount() ) <> 0 THEN RETURN 1
END IF
//09/25/2000 Gary Rubalsky End

iudw_requestor = audw_requestor

// Insert the values to the DW
li_NewRow = dw_col_align.InsertRow( 0 )
IF IsNull( li_NewRow ) OR li_NewRow < 0 THEN RETURN -1
IF dw_col_align.SetItem( li_NewRow, "col_nam", as_col_nam ) = -1 THEN RETURN -1
IF dw_col_align.SetItem( li_NewRow, "align_typ", 0 ) = -1 THEN RETURN -1
IF dw_col_align.SetItem( li_NewRow, "dbcol_nam", as_dbcol_nam ) = -1 THEN RETURN -1
dw_col_align.ScrollToRow( li_NewRow )

cb_align.Enabled = TRUE
cb_clear.Enabled = TRUE
cb_delete.enabled = true

of_filtercolumns()

RETURN 1
end function

public subroutine of_filtercolumns ();//*********************************************************************************
// Script Name:	of_filtercolumns()
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Reset col_name datawindow, parse through dw_decode creating new filter string, and
//					then apply filter back to the col_name datawindow.
//
//*********************************************************************************
//
//	04/22/09	Katie	GNL.600.5633	Initial Creation.
//	05/11/09	Katie	GNL.600.5633	Added logic to only apply filter criteria if there are columns to be filtered.
//
//*********************************************************************************

datawindowchild ldwc_uo_columns
int li_rowcount, li_ctr
string ls_filter, ls_dbcolname
boolean lb_filter = false

dw_col_align.accepttext()

dw_col_align.getchild( "col_nam", ldwc_uo_columns)
//Get row count for table
li_rowcount = dw_col_align.rowcount( )
//Go through rows creating string for filtering the child datawindow
of_populatecolumns(iudw_requestor)
ls_filter = "db_col not in("
FOR li_ctr = 1 TO li_rowcount
	ls_dbcolname = dw_col_align.getitemstring(li_ctr,"dbcol_nam")
	if not (trim(ls_dbcolname) = "" or isNull(ls_dbcolname))then 
		ls_filter = ls_filter + "'" + ls_dbcolname + "',"
		lb_filter = true
	end if
Next
if lb_filter then 
	ls_filter = Left(ls_filter, Len(ls_filter) - 1) + ")"
	ldwc_uo_columns.setfilter( ls_filter)
	ldwc_uo_columns.filter( )
end if
end subroutine

public function long of_populatecolumns (ref u_dw audw_requestor);//*********************************************************************************
// Script Name:	u_align_columns::of_populatecolumns
//
// Arguments: Datawindow	audw_requestor
//
// Returns:		None
//
// Description:	 Populate the col_name drop down in dw_decode.
//
//*********************************************************************************
//
// 	04/12/09 	Katie	GNL.600.5633	Initial Creation.
//	05/04/09		Katie	GNL.600.5633	Handle duplicate headers.
//	05/05/09		Katie	GNL.600.5633	Added isvalid check before processing columns.
//	05/11/09		Katie	GNL.600.5633	Add logic to ensure columns are visible before adding them to the 
//												drop-down list.
//	07/17/09		GaryR	WIN.650.5721.002		Standardize logic that removes return characters
//	07/30/09		GaryR	WIN.650.5721.006	Check visible property for formula
//
//*********************************************************************************

int li_col_num = 0, li_index
long ll_row, ll_visible, ll_width
string ls_col_name, ls_col_label, ls_data_type, ls_lookup, ls_hdr_name, &
			ls_visible, ls_dbname
datawindowchild ldwc_uo_columns
n_cst_string	lnv_string

if not IsValid(audw_requestor) then return -1

dw_col_align.GetChild( "col_nam", ldwc_uo_columns )
iudw_requestor = audw_requestor

ldwc_uo_columns.reset( )

li_col_num =  long(audw_requestor.Describe('datawindow.column.count'))

FOR li_index = 1 TO li_col_num
	ls_dbname 		=	String(audw_requestor.Describe('#'+string(li_index)+'.dbname'))
	ls_col_name = String(audw_requestor.Describe ('#'+string(li_index)+'.name'))
	if (upper(ls_dbname) <> upper(ls_col_name)) and (match(right(ls_col_name,2), '^_[0-9]$')) then
		ls_hdr_name = Left( ls_col_name, Len( ls_col_name ) - 2 ) + &
				'_t' + right(ls_col_name,2) + '_t'
	else
		ls_hdr_name = ls_col_name + '_t'
	end if
	ls_col_label = String(audw_requestor.Describe(ls_hdr_name+'.text'))
	ls_data_type = String(audw_requestor.Describe ('#'+string(li_index)+'.coltype'))
	ls_visible = audw_requestor.Describe ('#'+string(li_index)+'.visible')
	IF NOT IsNumber( ls_visible ) THEN
		//	Formula, means column is visible
		ll_visible = 1
	ELSE
		ll_visible = Long( ls_visible )
	END IF
	ll_width = Long(audw_requestor.Describe ('#'+string(li_index)+'.width'))
	if ((trim(ls_col_label) <> "!") AND (ll_visible > 0) AND (ll_width > 1)) then
		// Remove special characters
		lnv_string.of_clean_label( ls_col_label )	
		ll_row = ldwc_uo_columns.insertrow( 0)
		ldwc_uo_columns.setitem( ll_row, "col_name", ls_col_label)
		ldwc_uo_columns.setitem( ll_row, "db_col",trim(ls_col_name))
		ldwc_uo_columns.setitem( ll_row, "datatype",trim(ls_data_type))
	end if
NEXT
ldwc_uo_columns.setsort( "col_name")
ldwc_uo_columns.sort( )
ldwc_uo_columns.setrow( 1)

return 1
end function

on u_align_columns.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_col_align=create dw_col_align
this.cb_align=create cb_align
this.cb_clear=create cb_clear
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_insert
this.Control[iCurrent+3]=this.dw_col_align
this.Control[iCurrent+4]=this.cb_align
this.Control[iCurrent+5]=this.cb_clear
end on

on u_align_columns.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_col_align)
destroy(this.cb_align)
destroy(this.cb_clear)
end on

type cb_delete from u_cb within u_align_columns
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1385
integer y = 192
integer taborder = 40
boolean enabled = false
string text = "&Delete"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_delete.clicked
//
// Arguments:	n/a
//
// Returns:		long pbm_clicked
//
// Description:	Clicked even for the delete button.  Delete rows from dw_col_align where delete checkbox is selected.  
//					If no rows to delete present message.
//
//*********************************************************************************
//
//	04/13/09	 Katie 	GNL.600.5633		Initial Creation.
//	04/21/09	 Katie 	GNL.600.5633		Fixed typo in delete message.
//
//*********************************************************************************

int li_rowcount, li_ctr, li_delcount = 0
string ls_deltvalue
//Get row count for table
li_rowcount = parent.dw_col_align.rowcount( )
//Go through rows removing those with del indicator checked
FOR li_ctr = 1 TO li_rowcount
	ls_deltvalue = parent.dw_col_align.GetItemString( li_ctr, "delete" )
	if (ls_deltvalue = "Y") then
		parent.dw_col_align.deleterow( li_ctr)
		li_rowcount = li_rowcount - 1
		li_ctr=li_ctr - 1
		li_delcount = li_delcount + 1
	end if
Next

if (li_delcount = 0 ) then
	Messagebox('Delete Row','Please check the Delete Indicator for the row(s) you wish to delete.')
end if

li_rowcount = parent.dw_col_align.rowcount( )
if (li_rowcount > 0) then
	cb_align.enabled = TRUE
	of_filtercolumns()
else
	cb_align.enabled = FALSE
	cb_clear.enabled = FALSE
	THIS.Enabled = FALSE
	of_populatecolumns(iudw_requestor)
end if
end event

type cb_insert from u_cb within u_align_columns
string accessiblename = "Insert"
string accessibledescription = "Insert"
integer x = 1385
integer y = 100
integer taborder = 30
string text = "&Insert"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_insert.clicked
//
// Arguments:	n/a
//
// Returns:		long pbm_clicked
//
// Description:	Clicked even for the Insert button.  Insert row into dw_col_align.  Enable and disable buttons as appropriate.
//
//*********************************************************************************
//
//	04/13/09	 Katie 	GNL.600.5633		Initial Creation.
//
//*********************************************************************************


// Insert row into dw_col_align
// 04/13/09 Katie GNL.600.5633 Initial Creation.
integer li_newrow
li_newrow = dw_col_align.insertrow( 0)
dw_col_align.setrow( li_newrow)
dw_col_align.scrolltorow(li_newrow)
dw_col_align.setfocus( )

cb_align.enabled = true
cb_clear.enabled = true
cb_delete.enabled = true
end event

type dw_col_align from u_dw within u_align_columns
string accessiblename = "Column Align Data Window"
string accessibledescription = "Column Align Data Window"
integer x = 9
integer y = 8
integer width = 1362
integer height = 368
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_col_align"
boolean vscrollbar = true
end type

event doubleclicked;//*********************************************************************************
// Script Name:	dw_col_align.doubleclicked
//
// Arguments: interger xpos
//					integer ypos
//					long row
//					dwobject dwo
//
// Returns:		long
//
// Description:	Does nothing.  
//
//*********************************************************************************
//
//	04/13/09	 Katie 	GNL.600.5633		Removed double-click to delete functionality.
//
//*********************************************************************************
end event

event itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	dw_col_align.itemchanged
//
// Arguments:long row
//					dwobject dwo
//					string data
//
// Returns:		long
//
// Description:	When col_name changes retrieve the db_col from the data window child and set it to be the dbcol_name in dw_col_align.
//
//*********************************************************************************
//
//	04/13/09	 Katie 	GNL.600.5633		Initial Creation.
//	04/22/09	Katie		GNL.600.5633		Added logic to filter columns when change is made.
//	05/04/09	Katie	GNL.600.5633	Move filter to rowfocuschanged.
//
//*********************************************************************************

int li_currentdecode, li_currentrow
datawindowchild ldwc_uo_columns
String ls_colname, ls_dccolname

if (dwo.name = "col_nam") then 
	getchild( "col_nam", ldwc_uo_columns)

	li_currentrow = ldwc_uo_columns.getrow( )
	li_currentdecode = dw_col_align.getrow( )

	ls_colname = ldwc_uo_columns.getitemstring( li_currentrow, "col_name") 
	
	dw_col_align.SetItem( li_currentdecode, "col_nam", ls_colname)
	dw_col_align.SetItem( li_currentdecode, "dbcol_nam",  ldwc_uo_columns.getitemstring( li_currentrow,"db_col"))
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_col_align.rowfocuschanged
//
// Arguments:long currentrow
//
// Returns:		long
//
// Description:	Filter drop down column.
//
//*********************************************************************************
//
//	04/13/09	 Katie 	GNL.600.5633		Initial Creation.
//
//*********************************************************************************
of_filtercolumns()
end event

type cb_align from u_cb within u_align_columns
string accessiblename = "Align"
string accessibledescription = "Align"
integer x = 1385
integer y = 8
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string text = "&Align"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_align.clicked
//
// Arguments:	n/a
//
// Returns:		long pbm_clicked
//
// Description:	Click event for the Align button.  Processes rows marking duplicate field names or blank lines with a delete indicator then 
//					exectes the cb_delete.clicked() event.  Processes the rows again modigying the iudw_requestor data window with the field names
//					and alignments provided.
//
//*********************************************************************************
//
//	04/13/09	Katie 		GNL.600.5633		Add logic to clear out duplicate rows, empty rows, or deleted rows before processing alignment.
//	04/22/09	Katie		GNL.600.5633		Change logic to not use the delete button for clearing out rows.  Also
//													only remove rows that are blanks, do not remove duplicates.
//
//*********************************************************************************

Int		li_index,li_delcount, li_rowcount, li_rowcount2, li_ctr
String	ls_mod_string, ls_colname

//Go through rows removing blanks
FOR li_ctr = 1 TO li_rowcount
	ls_colname = parent.dw_col_align.GetItemString( li_ctr, "col_nam" )
	if (trim(ls_colname) = "" or isNull(ls_colname))then 
		parent.dw_col_align.deleterow(li_ctr)
	end if
Next

FOR li_index = 1 TO dw_col_align.RowCount()
	
	// Modify DWObject with the built syntax	
	ls_mod_string = dw_col_align.GetItemString( li_index, "dbcol_nam" ) + ".Alignment='" + String( dw_col_align.GetItemNumber( li_index, "align_typ" ) ) + "'"
	iudw_requestor.Modify( ls_mod_string )
NEXT
end event

type cb_clear from u_cb within u_align_columns
string accessiblename = "Clear All"
string accessibledescription = "Clear All"
integer x = 1385
integer y = 284
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string text = "C&lear All"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_clear.clicked
//
// Arguments:	n/a
//
// Returns:		long pbm_clicked
//
// Description:	Click event for the Clear button.  Resets the dw_col_align datawindow and properly enables/disables the remaining buttons.
//
//*********************************************************************************
//
//	04/13/09	 Katie 	GNL.600.5633		Added CMMI compliant header.
//	04/22/09	Katie		GNL.600.5633		Reset the col_name drop down datawindow.
//
//*********************************************************************************

dw_col_align.Reset()
cb_align.Enabled = FALSE
cb_delete.enabled = FALSE
THIS.Enabled = FALSE
of_populatecolumns(iudw_requestor)
end event

