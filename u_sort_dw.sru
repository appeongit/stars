HA$PBExportHeader$u_sort_dw.sru
$PBExportComments$Inherited from u_base <gui>
forward
global type u_sort_dw from u_base
end type
type cb_delete from u_cb within u_sort_dw
end type
type cb_insert from u_cb within u_sort_dw
end type
type cbx_suppress from checkbox within u_sort_dw
end type
type cb_reset from u_cb within u_sort_dw
end type
type cb_clear from u_cb within u_sort_dw
end type
type cb_sort from u_cb within u_sort_dw
end type
type dw_sort from u_dw within u_sort_dw
end type
type gb_1 from groupbox within u_sort_dw
end type
end forward

global type u_sort_dw from u_base
string accessiblename = "Sort"
string accessibledescription = "Sort"
integer width = 1947
integer height = 468
boolean border = false
long picturemaskcolor = 25166016
cb_delete cb_delete
cb_insert cb_insert
cbx_suppress cbx_suppress
cb_reset cb_reset
cb_clear cb_clear
cb_sort cb_sort
dw_sort dw_sort
gb_1 gb_1
end type
global u_sort_dw u_sort_dw

type variables
//*********************************************************************************
// Script Name:	Instance Variables
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Instance Variables
//
//*********************************************************************************
//
//	05/19/09	Katie	GNL.600.5633	Removed obsolete variables.
//
//*********************************************************************************

string in_data_type
int in_counter
u_dw in_datawindow_name
boolean in_already_selected,in_dups_allowed = false,iv_rows_exist
long in_row
graphicobject in_count_object
end variables

forward prototypes
public subroutine fuo_initialize_var ()
public subroutine fuo_set_dw (u_dw arg_datawindow_name)
public subroutine fuo_dups_allowed (boolean arg_dups_allowed)
public subroutine fuo_set_total_count (ref graphicobject arg_object)
public subroutine of_filtercolumns ()
public function integer of_populatecolumns (u_dw audw_requestor)
public function integer of_insert_sort_info (ref string as_sort_name, boolean ib_defaultsort)
public subroutine of_insert_sort_info (string is_sort_name)
public function string of_default_order (string as_datatype)
end prototypes

public subroutine fuo_initialize_var ();//*********************************************************************************
// Script Name:	fuo_initialize_var
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Intializes all variables.
//
//*********************************************************************************
//
//	05/12/94	SWD			Created	
//
//*******************************************************************

in_counter = 0
end subroutine

public subroutine fuo_set_dw (u_dw arg_datawindow_name);//*********************************************************************************
// Script Name:	fuo_set_dw
//
// Arguments:	u_dw	arg_datawindow_name
//
// Returns:		N/A
//
// Description:	Set the datawindow instance variable.
//
//*********************************************************************************
//
//
//*********************************************************************************

in_datawindow_name = arg_datawindow_name
end subroutine

public subroutine fuo_dups_allowed (boolean arg_dups_allowed);//*********************************************************************************
// Script Name:	fuo_dups_allowed
//
// Arguments:	boolean arg_dups_allowed
//
// Returns:		N/A
//
// Description:	Set duplicates allowed indicator.
//
//*********************************************************************************
//
//
//*********************************************************************************

in_dups_allowed = arg_dups_allowed
end subroutine

public subroutine fuo_set_total_count (ref graphicobject arg_object);//*********************************************************************************
// Script Name:	fuo_set_total_count
//
// Arguments:	graphic_object arg_object
//
// Returns:		N/A
//
// Description:	Set the in_count instance variable.
//
//*********************************************************************************
//
//
//*********************************************************************************
in_count_object=arg_object
end subroutine

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
//	04/21/09	Katie	GNL.600.5633	Initial Creation.
//	05/04/09	Katie	GNL.600.5633	Added upper to filter criteria to ensure columns filtered properly.
//	05/11/09	Katie	GNL.600.5633	Added logic to only apply filter criteria if there are columns to be filtered.
//
//*********************************************************************************

datawindowchild ldwc_uo_columns
int li_rowcount, li_ctr
string ls_filter, ls_dbcolname
boolean lb_filter = false

dw_sort.accepttext()
dw_sort.getchild( "sort_name", ldwc_uo_columns)
//Get row count for table
li_rowcount = dw_sort.rowcount( )
//Go through rows creating string for filtering the child datawindow
of_populatecolumns(in_datawindow_name)
ls_filter = "UPPER(col_name) not in("
FOR li_ctr = 1 TO li_rowcount
	ls_dbcolname = dw_sort.getitemstring(li_ctr,"sort_name")
	if not (trim(ls_dbcolname) = "" or isNull(ls_dbcolname))then 
		ls_filter = ls_filter + "'" + UPPER(ls_dbcolname) + "',"
		lb_filter= true
	end if
Next
if lb_filter then 
	ls_filter = Left(ls_filter, Len(ls_filter) - 1) + ")"
	ldwc_uo_columns.setfilter( ls_filter)
	ldwc_uo_columns.filter( )
end if
end subroutine

public function integer of_populatecolumns (u_dw audw_requestor);//*********************************************************************************
// Script Name:	of_populatecolumns
//
// Arguments:	u_dw	audw_requestor
//
// Returns:		N/A
//
// Description:	Populate the sort_name datawindow child for the requesting datawindow.
//
//*********************************************************************************
//
// 04/11/09 Katie	GNL.600.5633 Initial Creation.
//	04/27/09	Katie	GNL.600.5633	Change function name to match programming standards.
//	05/04/09	Katie	GNL.600.5633	Accomidate duplicate columns as encountered in Patterns.  
//	05/05/09	Katie	GNL.600.5633	Added isvalid check before processing columns.
//	05/12/09	Katie	GNL.600.5633  Add logic to ensure a column is visible before adding it to the drop-down.
//	05/19/09	Katie	GNL.600.5633	Add logic to populate the datatype in the drop-down.
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
//	07/30/09	GaryR	WIN.650.5721.006	Check visible property for formula
//
//*********************************************************************************

int li_col_num = 0, li_index
long ll_row, ll_width, ll_visible
string ls_col_name, ls_col_label, ls_data_type, ls_lookup, ls_dbname, &
			ls_visible, ls_hdr_name
datawindowchild ldwc_uo_columns
n_cst_string	lnv_string

if not IsValid(audw_requestor) then return -1

dw_sort.GetChild( "sort_name", ldwc_uo_columns )
in_datawindow_name = audw_requestor

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
return ldwc_uo_columns.rowcount( )
end function

public function integer of_insert_sort_info (ref string as_sort_name, boolean ib_defaultsort);//*********************************************************************************
// Script Name:	of_insert_sort_info
//
// Arguments:	string arg_dw_control
//
// Returns:		N/A
//
// Description:	This inserts a the sort choice into the datawindow.
//
//*********************************************************************************
//
//	05/12/94	FNC	Track 223 Rel3.6 TS 243			This function is identical except that it does not
//							reference cbx_suppress. CBX_Suppress is bleeding 
//							through in Windows NT when display filter is selected and 
//							cbx_suppress is referenced. This function will be 
//							called when the user selects display filter.
//	04/22/09	Katie	GNL.600.5633	Enbabled the delete button.  Added call to of_filtercolumns
//	05/13/09	Katie	GNL.600.5633	Rewrote to remove use of the in_code_table because the information
//							already exists in the column drop-down.
//	05/29/09	Katie	GNL.600.5633	Ensured that of_filtercolumns was not called if dups are allowed.
// 05/29/09	GaryR	GNL.600.5633.003	Address defect with filtering on value
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
//	07/20/09	GaryR	WIN.650.5721.003	Reorganize the execution of filtering columns
//
//*********************************************************************************

string ls_datatype
datawindowchild ldwc_uo_columns
long ll_row, ll_rowcount
n_cst_string	lnv_string

iv_rows_exist = TRUE
//enable all the objects
cb_sort.enabled = TRUE
cbx_suppress.enabled = TRUE
dw_sort.enabled = TRUE
cb_clear.enabled = TRUE
cb_reset.enabled = TRUE
cb_delete.enabled = true
in_row = 0

// Remove the return character from the label
lnv_string.of_clean_label( as_sort_name )

// Check for duplicate choice and blank row
ll_rowcount = dw_sort.RowCount()
FOR ll_row = 1 TO ll_rowcount
	ls_datatype = dw_sort.GetItemString( ll_row, "sort_name" )
	IF ls_datatype = as_sort_name THEN
		//	Duplicate column, set its existing row
		dw_sort.SetRow( ll_row )
		RETURN 1
	ELSEIF IsNull( ls_datatype ) OR Trim( ls_datatype ) = "" THEN
		//	Use the first blank row
		IF in_row = 0 THEN in_row = ll_row
	END IF
NEXT

//Inserts the row and sets the the first column to the sort
//text sent in or adds to the first blank row
IF in_row = 0 THEN in_row = dw_sort.InsertRow( 0 )
dw_sort.setitem(in_row,"sort_name",as_sort_name)
dw_sort.getchild('sort_name',ldwc_uo_columns)
ll_row = ldwc_uo_columns.Find("col_name = '" + as_sort_name + "'",1,ldwc_uo_columns.rowcount())
IF ll_row > 0 THEN
	ls_datatype = ldwc_uo_columns.getitemstring(ll_row,"datatype")
	if ib_defaultsort then
		dw_sort.setitem(in_row,"sort_order",of_default_order(ls_datatype))
	end if
END IF

dw_sort.accepttext()
dw_sort.SetRow( in_row )

return 0
end function

public subroutine of_insert_sort_info (string is_sort_name);//*********************************************************************************
// Script Name:	of_insert_sort_info
//
// Arguments:	string arg_dw_control
//
// Returns:		N/A
//
// Description:	This inserts a the sort choice into the datawindow.  This function handles those that may not
//					be passed the default sort boolean flag.  
//
//*********************************************************************************
//
//	05/13/09	Katie	GNL.600.5633	Initial Creation
//
//*********************************************************************************

of_insert_sort_info(is_sort_name, false)
end subroutine

public function string of_default_order (string as_datatype);//*********************************************************************************
// Script Name:	of_default_order
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Set default order based on data type.
//
//*********************************************************************************
//
//	09/22/97	JOHN_WO						Added long.
//	04/21/09	Katie			GNL.600.5633	Changed values for the default sort order.	
//	05/14/09	Katie			GNL.600.5633	Removed the in_code_table dependence
//
//*********************************************************************************

string ls_asc = 'A', ls_desc = 'D'



if Match(UPPER(as_datatype),'CHAR') OR UPPER(as_datatype) = 'DATETIME' Then
	return ls_asc
elseif UPPER(as_datatype) = 'NUMBER' OR &
	UPPER(as_datatype) = 'LONG' OR &
	Match(UPPER(as_datatype),'DECIMAL')  Then
	return ls_desc
end if
return ls_asc
end function

event constructor;//*********************************************************************************
// Script Name:	constructor
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	This is a sort user object.  It allows the user to
//				select a column(standard is double clicking) in which
//				it will insert the colmn text into the datawindow
//				with radiobutton choices for asc and desc.  The user
//				can delete any of the sorts in the datawindow by
//				doubleclicking on the choice that needs to be deleted
//				The clear button will delete all choices.  The sort
//				button does the actual sort from the selections in
//				the datawindow.  The following is an example of how
//				the functions should be called in the window that
//				object is placed in.  UO_SORT is the name that you assign to the sort object
//		         within your window.			
//
//*********************************************************************************
//
//	06/12/94	SWD		Created
//
//*********************************************************************************
end event

on u_sort_dw.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cbx_suppress=create cbx_suppress
this.cb_reset=create cb_reset
this.cb_clear=create cb_clear
this.cb_sort=create cb_sort
this.dw_sort=create dw_sort
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_insert
this.Control[iCurrent+3]=this.cbx_suppress
this.Control[iCurrent+4]=this.cb_reset
this.Control[iCurrent+5]=this.cb_clear
this.Control[iCurrent+6]=this.cb_sort
this.Control[iCurrent+7]=this.dw_sort
this.Control[iCurrent+8]=this.gb_1
end on

on u_sort_dw.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cbx_suppress)
destroy(this.cb_reset)
destroy(this.cb_clear)
destroy(this.cb_sort)
destroy(this.dw_sort)
destroy(this.gb_1)
end on

type cb_delete from u_cb within u_sort_dw
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1591
integer y = 244
integer taborder = 50
boolean enabled = false
string text = "&Delete"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_delete.clicked()
//
// Arguments: N/A
//
// Returns:		long
//
// Description:	Delete rows from dw_sort where delete checkbox is selected. 
// 					If no rows to delete present message.
//
//*********************************************************************************
//
// 04/11/09	Katie	GNL.600.5633	Initial Creation.
//	04/21/09	Katie	GNL.600.5633	Added logic to filter the sort_name datawindow child properly.  Fixed typo
//											in delete message.
//
//*********************************************************************************

int li_rowcount, li_ctr, li_delcount = 0
string ls_deltvalue
//Get row count for table
li_rowcount = parent.dw_sort.rowcount( )
//Go through rows removing those with del indicator checked
FOR li_ctr = 1 TO li_rowcount
	ls_deltvalue = parent.dw_sort.GetItemString( li_ctr, "delete" )
	if (ls_deltvalue = "Y") then
		parent.dw_sort.deleterow( li_ctr)
		li_rowcount = li_rowcount - 1
		li_ctr=li_ctr - 1
		li_delcount = li_delcount + 1
	end if
Next

if (li_delcount = 0 ) then
	Messagebox('Delete Row','Please check the Delete Indicator for the row(s) you wish to delete.')
end if

li_rowcount = parent.dw_sort.rowcount( )
if (li_rowcount > 0) then
	cb_sort.enabled = TRUE
	if not in_dups_allowed then 
		of_filtercolumns()
	end if
else
	cb_sort.enabled = FALSE
	cbx_suppress.enabled = FALSE
	iv_rows_exist = FALSE
	in_counter = 0
	cb_clear.enabled = FALSE
	cb_sort.enabled = FALSE
	THIS.Enabled = FALSE
	cbx_suppress.enabled = FALSE	
	if not in_dups_allowed then 
		of_populatecolumns(in_datawindow_name)
	end if
end if
end event

type cb_insert from u_cb within u_sort_dw
string accessiblename = "Insert"
string accessibledescription = "Insert"
integer x = 1591
integer y = 148
integer taborder = 40
string text = "&Insert"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_insert.clicked()
//
// Arguments: N/A
//
// Returns:		long
//
// Description:	Insert row into dw_sort
//
//*********************************************************************************
//
// 04/10/09 Katie GNL.600.5633 Initial Creation.
//	05/04/09	Katie	GNL.600.5633	Set column to the first column when inserting row.
//	05/07/09	Katie	GNL.600.5633	Set iv_rows_exist to properly handle enableing and disabline of objects.
//
//*********************************************************************************

integer li_newrow
li_newrow = dw_sort.insertrow( 0)
dw_sort.setrow( li_newrow)
dw_sort.setcolumn(1)
dw_sort.setfocus( )

iv_rows_exist = TRUE
cb_sort.enabled = true
cb_clear.enabled = true
cb_delete.enabled = true
cbx_suppress.enabled = TRUE
end event

type cbx_suppress from checkbox within u_sort_dw
string accessiblename = "Suppress"
string accessibledescription = "Suppress"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1184
integer y = 52
integer width = 398
integer height = 68
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Su&ppress"
end type

type cb_reset from u_cb within u_sort_dw
boolean visible = false
string accessiblename = "Reset"
string accessibledescription = "Reset"
integer x = 1152
integer y = 276
integer width = 242
integer taborder = 80
integer weight = 400
string text = "Reset"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_reset.clicked()
//
// Arguments: N/A
//
// Returns:		long
//
// Description:	Reset the datawindow.
//
//*********************************************************************************
//
//
//*********************************************************************************

int rc
rc = in_datawindow_name.Setfilter('')
if rc = -1 then return 
in_datawindow_name.Filter()
end event

type cb_clear from u_cb within u_sort_dw
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1591
integer y = 340
integer taborder = 60
boolean enabled = false
string text = "C&lear All"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_clear.clicked()
//
// Arguments: N/A
//
// Returns:		long
//
// Description:	This script clear the contents of dw_sort
//
//*********************************************************************************
//
//	09/29/97	FDG	Stars 3.5.4		Initialize of in_code_table[]
//											done incorrectly for 16-bit PB 5.0
//	04/21/09	Katie	GNL.600.5633	Added logic to reset the sort_name datawindowchild.   Removed disabling
//											of dw_sort after clearing.  Disable the delete button.
//
//**************************************************************

dw_sort.Reset()

cb_sort.enabled = FALSE
cbx_suppress.enabled = FALSE
cb_clear.enabled = FALSE
cb_delete.enabled = FALSE
iv_rows_exist = FALSE

if not in_dups_allowed then 
	of_populatecolumns(in_datawindow_name)
end if
end event

type cb_sort from u_cb within u_sort_dw
string accessiblename = "Sort"
string accessibledescription = "Sort"
integer x = 1591
integer y = 52
integer taborder = 30
boolean enabled = false
string text = "&Sort"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_sort.clicked()
//
// Arguments: N/A
//
// Returns:		long
//
// Description:	Execute sort.
//
//*********************************************************************************
//
//  04/10/09	Katie	GNL.600.5633 Changed to retrieving column names from the sort_name column
//						of dw_sort.  Clean out duplicates and blanks before processing sort.
//	04/21/09	Katie	GNL.600.5633	Remove logic that is removing duplicate rows and change the clean-up
//						to be performed without calling the cb_delete.clicked event.
//	05/13/09	Katie	GNL.600.5633  When the fuo_insert_sort_info function is called it is only setting the value 
//						of the drop-down and not selecting the actual row in the datawindowchild.  Rather than try to
//						set the row in the datawindowchild use the datawindowchild as a datasource to retrieve
//						the db_col at the time that sort is clicked.
//	05/19/09	Katie	GNL.600.5633	Remove logic that was using the code structure and instead just use the datawindow
//						and datawindowchild to do the sorting.
//	07/20/09	GaryR	WIN.650.5721.006	Accomodate blank rows
//
//*********************************************************************************

long num_of_rows,lv_row, ll_currow
int li_rowcount, li_ctr, li_index
string lv_sort_name,lv_order,lv_sort_value,lv_sort
string lv_sparse,lv_rc
datawindowchild ldwc_uo_columns

num_of_rows = dw_sort.rowcount()
dw_sort.getchild( "sort_name",ldwc_uo_columns)
ldwc_uo_columns.setfilter( "")
ldwc_uo_columns.filter( )

//This loops through the datawindow  and builds the sort string
//for the setsort
for lv_row = 1 to num_of_rows	
	lv_sort_name = dw_sort.GetItemString(lv_row,"sort_name")
	//	Bypass blank row
	IF IsNull( lv_sort_name ) OR Trim( lv_sort_name ) = "" THEN Continue
	lv_order = dw_sort.getitemstring(lv_row,"sort_order")
	ll_currow = ldwc_uo_columns.Find("col_name = '" + lv_sort_name + "'",0,ldwc_uo_columns.rowcount())
	lv_sort_value = ldwc_uo_columns.getitemstring( ll_currow, "db_col") 
	lv_sort = lv_sort+' '+lv_sort_value +' '+lv_order + ','
	//HRB 12/14/95 - Suppress Repeating Values
	if cbx_suppress.checked then
		lv_sparse = lv_sparse + '~t' + lv_sort_value
	end if
next

IF Trim( lv_sort ) = "" THEN
	MessageBox( "Sort", "Please select at least one column to sort." )
	Return
END IF

lv_sort = left(trim(lv_sort),Len(trim(lv_sort)) - 1)
//HRB 12/14/95 - Suppress Repeating Values
lv_rc = in_datawindow_name.modify("datawindow.sparse = ''")	
if cbx_suppress.checked then
	lv_sparse = mid(lv_sparse,2)
end if

//does the setsort and the sort
in_datawindow_name.SetSort(lv_sort)

in_datawindow_name.Sort()
in_datawindow_name.groupcalc()		//added by pat-d on 10/27/95

in_datawindow_name.setrow(1)
in_datawindow_name.scrolltorow(1)
in_datawindow_name.triggerevent(rowfocuschanged!)

//HRB 12/14/95 - Suppress Repeating Values
lv_rc = in_datawindow_name.modify("datawindow.sparse = ''")	//clear all other suppressions - prob 91 HRB 2/5/95
if cbx_suppress.checked then
	lv_rc = in_datawindow_name.modify("datawindow.sparse = '"+lv_sparse+"'")	
end if


cb_sort.enabled = FALSE
cbx_suppress.enabled = FALSE
end event

type dw_sort from u_dw within u_sort_dw
event accept pbm_custom01
event changeofcol pbm_custom02
string accessiblename = "Sort Criteria"
string accessibledescription = "Sort Criteria"
integer x = 37
integer y = 148
integer width = 1531
integer height = 284
integer taborder = 20
string dataobject = "d_sorts"
boolean vscrollbar = true
end type

event accept;//*********************************************************************************
// Script Name:	dw_sort.accept()
//
// Arguments:	unsignedlong wparam
//					long	lparam
//
// Returns:		long
//
// Description:	Accept text.
//
//*********************************************************************************
//
//
//*********************************************************************************
this.accepttext()
end event

event itemchanged;//*********************************************************************************
// Script Name:	dw_sort.itemchanged()
//
// Arguments: long	row
//					dwobject	dwo
//					string	data
//
// Returns:		long
//
// Description:	Enable buttons as appropriate when items change.
//
//*********************************************************************************
//
//	Katie	04/11/09	GNL.600.5633 Change logic to enable sort and suppress for both the first and second columns.  
//	Katie	05/04/09	GNL.600.5633	Moved filter functionality to rowfocuschanged event.
//
//*********************************************************************************

int lv_col_no

lv_col_no = this.getcolumn()

if (lv_col_no = 1 or lv_col_no = 2) then
	cb_sort.enabled = TRUE
	cbx_suppress.enabled = TRUE
end if
end event

event doubleclicked;//*********************************************************************************
// Script Name:	dw_sort.doubleclicked()
//
// Arguments: integer xpos
//					integer ypos
//					long	row
//					dwobject dwo
//
// Returns:		long
//
// Description:	Code to execute when double clicking on a row.
//
//*********************************************************************************
//
//	Katie	04/11/09	GNL.600.5633	Removed double click clearing of the items from the datawindow.
//
//*********************************************************************************
end event

event losefocus;//*********************************************************************************
// Script Name:	dw_sort.losefocus()
//
// Arguments:	N/A
// Returns:		long
//
// Description:	Execute accept event when datawindow loses focus.
//
//*********************************************************************************
//
//
//*********************************************************************************

this.postevent("Accept")
end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_sort.rowfocuschanged()
//
// Arguments: long	currentrow
//
// Returns:		long
//
// Description:	Filter columns when row focus changes.
//
//*********************************************************************************
//
//	Katie	05/04/09	GNL.600.5633 Initial Creation.
//
//*********************************************************************************
	if not in_dups_allowed then 
		of_filtercolumns()
	end if
end event

type gb_1 from groupbox within u_sort_dw
string accessiblename = "Sort By"
string accessibledescription = "Sort By"
accessiblerole accessiblerole = groupingrole!
integer x = 14
integer width = 1920
integer height = 452
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Sort By"
end type

