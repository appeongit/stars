HA$PBExportHeader$u_unique_counts.sru
$PBExportComments$Inherited from u_base <gui>
forward
global type u_unique_counts from u_base
end type
type cb_delete from u_cb within u_unique_counts
end type
type cb_insert from u_cb within u_unique_counts
end type
type dw_unique_count from u_dw within u_unique_counts
end type
type cb_clear from u_cb within u_unique_counts
end type
end forward

global type u_unique_counts from u_base
string accessiblename = "Unique Count"
string accessibledescription = "Unique Count"
integer width = 1733
integer height = 332
boolean border = false
cb_delete cb_delete
cb_insert cb_insert
dw_unique_count dw_unique_count
cb_clear cb_clear
end type
global u_unique_counts u_unique_counts

type variables
//*********************************************************************************
//
//	04/13/09		Katie				GNL.600.5633				Added requesting datawindow variable.
//
//*********************************************************************************

u_dw iudw_requestor 
end variables

forward prototypes
public function integer of_insertcountdata (string as_col_nam, string as_dbcol_nam, u_dw adw_requestor)
public subroutine of_filtercolumns ()
public function long of_populatecolumns (ref u_dw audw_requestor)
end prototypes

public function integer of_insertcountdata (string as_col_nam, string as_dbcol_nam, u_dw adw_requestor);// Script Name:	u_unique_counts::of_InsertCountData
//
// Arguments: String - as_col_nam
//					String - as_dbcol_nam
//					U_dw - adw_requestor
//
// Returns:		Integer
//
// Description:	Inserts unique counts of selected columns 
//							requested by the window operations process
//
//*********************************************************************************
//
//	05/11/04	GaryR	Track 4016d			Add a Unique Count option to Window Operations
//	04/22/09	Katie	GNL.600.5633		Added call to of_filtercolumns.
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
//
//*********************************************************************************

Int		li_NewRow
String	ls_count
n_cst_string	lnv_string

// Validate arguments
IF IsNull( as_col_nam ) OR Trim( as_col_nam ) = "" THEN RETURN -1
IF IsNull( as_dbcol_nam ) OR Trim( as_dbcol_nam ) = "" THEN RETURN -1
IF IsNull( adw_requestor ) OR NOT IsValid( adw_requestor ) THEN RETURN -1

// Remove the return character from the label
lnv_string.of_clean_label( as_col_nam )

// Check for duplicate choice.
IF dw_unique_count.RowCount() > 0 THEN
	IF dw_unique_count.Find( "col_nam = '" + as_col_nam + "'", 1, dw_unique_count.RowCount() ) <> 0 THEN RETURN 1
END IF

// Get the count
ls_count = adw_requestor.Describe( 'evaluate( " count( ' + as_dbcol_nam + ' for all DISTINCT ) " ,1)' )
IF IsNull( ls_count ) OR NOT IsNumber( ls_count ) THEN Return -1

// Insert the values to the DW
li_NewRow = dw_unique_count.InsertRow( 0 )
IF IsNull( li_NewRow ) OR li_NewRow < 0 THEN RETURN -1
IF dw_unique_count.SetItem( li_NewRow, "col_nam", as_col_nam ) = -1 THEN RETURN -1
IF dw_unique_count.SetItem( li_NewRow, "unique_count", Long( ls_count )  ) = -1 THEN RETURN -1
dw_unique_count.ScrollToRow( li_NewRow )

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
// Description:	Reset col_name datawindow, parse through dw_unique_count creating new filter string, and
//					then apply filter back to the col_name datawindow.
//
//*********************************************************************************
//
//	04/21/09	Katie	GNL.600.5633	Initial Creation.
//	05/11/09	Katie	GNL.600.5633	Added logic to only apply filter criteria if there are columns to be filtered.
//
//*********************************************************************************

datawindowchild ldwc_uo_columns
int li_rowcount, li_ctr
string ls_filter, ls_dbcolname
boolean lb_filter = false

dw_unique_count.accepttext()
dw_unique_count.getchild( "col_nam", ldwc_uo_columns)
//Get row count for table
li_rowcount = dw_unique_count.rowcount( )
//Go through rows creating string for filtering the child datawindow
of_populatecolumns(iudw_requestor)
ls_filter = "col_name not in("
FOR li_ctr = 1 TO li_rowcount
	ls_dbcolname = dw_unique_count.getitemstring(li_ctr,"col_nam")
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

public function long of_populatecolumns (ref u_dw audw_requestor);// Script Name:	u_unique_counts::of_populatecolumns
//
// Arguments:  U_dw - adw_requestor
//
// Returns:		none
//
// Description:	Populate the col_name drop down in dw_decode
//
//*********************************************************************************
//
//	04/13/09	Katie	GNL.600.5633		Initial Creation.
//	05/04/09	Katie	GNL.600.5633		Allow for duplicate column headers.
//	05/05/09	Katie	GNL.600.5633		Added isvalid check before processing columns.
//	05/12/09	Katie	GNL.600.5633		Add logic to ensure columns are visible before adding them
//												to the drop-down.
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
//	07/30/09	GaryR	WIN.650.5721.006	Check visible property for formula
//
//*********************************************************************************

int li_col_num = 0, li_index
long ll_row, ll_width, ll_visible
string ls_col_name, ls_col_label, ls_dbname, ls_hdr_name, ls_visible
datawindowchild ldwc_uo_columns
n_cst_string	lnv_string

if not IsValid(audw_requestor) then return -1

dw_unique_count.GetChild( "col_nam", ldwc_uo_columns )
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
	end if
NEXT
ldwc_uo_columns.setsort( "col_name")
ldwc_uo_columns.sort( )
ldwc_uo_columns.setrow( 1)

return 1
end function

on u_unique_counts.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_unique_count=create dw_unique_count
this.cb_clear=create cb_clear
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_insert
this.Control[iCurrent+3]=this.dw_unique_count
this.Control[iCurrent+4]=this.cb_clear
end on

on u_unique_counts.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_unique_count)
destroy(this.cb_clear)
end on

type cb_delete from u_cb within u_unique_counts
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1413
integer y = 116
integer taborder = 30
boolean enabled = false
string text = "&Delete"
end type

event clicked;call super::clicked;// Script Name:cb_delete.clicked
//
// Arguments:  N/A
//
// Returns:		long
//
// Description:	 Delete rows from dw_unique_count where delete checkbox is selected. 
// 					If no rows to delete present message.
//
//*********************************************************************************
//
//	04/13/09		Katie				GNL.600.5633				Initial Creation.
//	04/22/09		Katie				GNL.600.5633				Filter the drop down datawindow.
//
//*********************************************************************************

int li_rowcount, li_ctr, li_delcount = 0
string ls_deltvalue
//Get row count for table
li_rowcount = parent.dw_unique_count.rowcount( )
//Go through rows removing those with del indicator checked
FOR li_ctr = 1 TO li_rowcount
	ls_deltvalue = parent.dw_unique_count.GetItemString( li_ctr, "delete" )
	if (ls_deltvalue = "Y") then
		parent.dw_unique_count.deleterow( li_ctr)
		li_rowcount = li_rowcount - 1
		li_ctr=li_ctr - 1
		li_delcount = li_delcount + 1
	end if
Next

if (li_delcount = 0 ) then
	Messagebox('Delete Row','Please check the Delete Indicator for the row(s) you with to delete.')
end if

li_rowcount = parent.dw_unique_count.rowcount( )
if (li_rowcount = 0) then
	cb_clear.enabled = FALSE
	THIS.Enabled = FALSE
	of_populatecolumns(iudw_requestor)
else
	of_filtercolumns()
end if
end event

type cb_insert from u_cb within u_unique_counts
string accessiblename = "Insert"
string accessibledescription = "Insert"
integer x = 1413
integer y = 8
integer taborder = 20
string text = "&Insert"
end type

event clicked;call super::clicked;// Script Name:	cb_insert.clicked
//
// Arguments:  N/A
//
// Returns:		long
//
// Description:	 Insert row into dw_unique_count.  Enable buttons as appropriate.
//
//*********************************************************************************
//
//	04/13/09		Katie				GNL.600.5633				Initial Creation.
//
//*********************************************************************************

integer li_newrow
li_newrow = dw_unique_count.insertrow( 0)
dw_unique_count.setrow( li_newrow)
dw_unique_count.scrolltorow(li_newrow)
dw_unique_count.setfocus( )

cb_clear.enabled = true
cb_delete.enabled = true
end event

type dw_unique_count from u_dw within u_unique_counts
string accessiblename = "Unique Count Criteria"
string accessibledescription = "Unique Count Criteria"
integer x = 9
integer y = 8
integer width = 1394
integer height = 308
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_unique_count"
boolean vscrollbar = true
end type

event doubleclicked;// Script Name:	u_unique_counts::of_populatecolumns
//
// Arguments:  N/A
//
// Returns:		long
//
// Description:	Does nothing.
//
//*********************************************************************************
//
//	04/13/09		Katie				GNL.600.5633				Remove deletion on double click.
//
//*********************************************************************************



end event

event itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	dw_unique_counts.itemchanged()
//
// Arguments:  long	row
//					dwobject dwo
//					string	data
//
// Returns:		long
//
// Description:	When column name changes calculate and set the unique count column.
//
//*********************************************************************************
//
//	04/13/09		Katie				GNL.600.5633					Initial Creation.
//	04/22/09		Katie				GNL.600.5633					Filter the drop down datawindow.
//	05/04/09		Katie				GNL.600.5633					Move filter of columns to rowfocuschanged.
//
//*********************************************************************************
String ls_count, ls_col_name, ls_dbcol_name
long ll_row
datawindowchild ldwc_uo_columns

if (dwo.name = "col_nam") then 
	dw_unique_count.getchild( "col_nam", ldwc_uo_columns)
	ll_row = ldwc_uo_columns.find( "col_name = '" + data + "'", 1, ldwc_uo_columns.rowcount())
	ls_dbcol_name = ldwc_uo_columns.getitemstring(ll_row, "db_col")
	ls_count = iudw_requestor.Describe( 'evaluate( " count( ' + ls_dbcol_name + ' for all DISTINCT ) " ,1)' )
	IF IsNull( ls_count ) OR NOT IsNumber( ls_count ) THEN Return -1
	IF dw_unique_count.SetItem( row, "unique_count", Long( ls_count )  ) = -1 THEN RETURN -1
	dw_unique_count.accepttext( )
end if


end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_unique_counts.itemchanged()
//
// Arguments:  long	currentrow
//
// Returns:		long
//
// Description:	Filter column when row focus is changed.
//
//*********************************************************************************
//
//	04/13/09		Katie				GNL.600.5633					Initial Creation.
//
//*********************************************************************************
of_filtercolumns()
end event

type cb_clear from u_cb within u_unique_counts
string accessiblename = "Clear All"
string accessibledescription = "Clear All"
integer x = 1413
integer y = 224
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string text = "C&lear All"
end type

event clicked;// Script Name:	cb_clear.clicked
//
// Arguments:  U_dw - adw_requestor
//
// Returns:		none
//
// Description:	Rest dw_unique_count and disable the clear button.
//
//*********************************************************************************
//
//
//*********************************************************************************

dw_unique_count.Reset()
THIS.Enabled = FALSE
cb_delete.enabled = false
of_populatecolumns(iudw_requestor)
end event

