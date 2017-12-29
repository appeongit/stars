HA$PBExportHeader$u_decode.sru
$PBExportComments$Inherited from u_base <gui>
forward
global type u_decode from u_base
end type
type cb_delete from u_cb within u_decode
end type
type cb_insert from u_cb within u_decode
end type
type st_1 from statictext within u_decode
end type
type dw_decode from u_dw within u_decode
end type
type cb_execute from u_cb within u_decode
end type
type cb_clear from u_cb within u_decode
end type
end forward

global type u_decode from u_base
string accessiblename = "Decode"
string accessibledescription = "Decode"
integer width = 1902
integer height = 460
boolean border = false
cb_delete cb_delete
cb_insert cb_insert
st_1 st_1
dw_decode dw_decode
cb_execute cb_execute
cb_clear cb_clear
end type
global u_decode u_decode

type variables
//*********************************************************************************
// Script Name:	Instance Variables
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Instance variables for u_decode.
//
//*********************************************************************************
//
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//
//*********************************************************************************

String	is_invoice_type

u_dw	iudw_requestor
sx_decode_structure isx_decode_struc
w_uo_win	iw_parent
w_master	iw_active
end variables

forward prototypes
public function integer of_insertdecodedata (string as_col_nam, string as_dbcol_nam, u_dw audw_requestor, ref sx_decode_structure asx_decode_struc)
public subroutine of_set_invoice_type (string as_inv_type)
public subroutine of_filtercolumns ()
public function long of_populatecolumns (ref sx_decode_structure asx_decode_struc, ref u_dw audw_requestor)
end prototypes

public function integer of_insertdecodedata (string as_col_nam, string as_dbcol_nam, u_dw audw_requestor, ref sx_decode_structure asx_decode_struc);//*********************************************************************************
// Script Name:	u_decode::of_InsertDecodeData
//
// Arguments:	String						as_col_nam
//					String						as_dbcol_nam
//					u_dw 						audw_requestor 
//					sx_decode_structure	asx_decode_struc
//
// Returns:		integer
//
// Description:	Inserts decode information passed from 
//							the component's window operations process
//
//*********************************************************************************
//
//	07/29/05	GaryR	Track 4432d		Allow multi-column decode in background
//	08/11/06	GaryR	Track 4807		Default to not sorting the data
//	09/08/06	GaryR	Track 4814		Handle sorting on Money/Unit/Break w/ Totals in QE
//	09/14/06	GaryR	Track 4687		Check the claim main and dependent 
//												invoice type(s) if drilldown to Pat/Prov
//	12/16/08	GaryR	Track 5611		Account for when a computed column is clicked
//	04/08/09	Katie		GNL.600.5633	Enabled the delete button when row added.
//	04/22/09	Katie		GNL.600.5633	Added call to of_filtercolumns
//	07/17/09	GaryR		WIN.650.5721.002	Standardize logic that removes return characters
//
//************************************************************************

Int		li_NewRow, li_decode_col, li_index, li_col
String	ls_data_type, ls_lookup, ls_inv_type
n_cst_decode	lnv_decode
w_query_engine	lw_query_engine
uo_query	luo_query
n_cst_string	lnv_string

// Validate arguments
IF IsNull( as_col_nam ) OR Trim( as_col_nam ) = "" THEN RETURN -1
IF IsNull( as_dbcol_nam ) OR Trim( as_dbcol_nam ) = "" THEN RETURN -1
IF IsNull( audw_requestor ) OR NOT IsValid( audw_requestor ) THEN RETURN -1
IF IsNull( asx_decode_struc ) OR NOT IsValid( asx_decode_struc ) THEN RETURN -1

ls_data_type	= Upper(audw_requestor.Describe( as_dbcol_nam + ".ColType" ))
li_decode_col  = Integer(audw_requestor.Describe( as_dbcol_nam + ".ID" ))

// If NOT character data type, return error messagebox
IF NOT gnv_sql.of_is_character_data_type( ls_data_type ) THEN
	MessageBox( "Decode Error", "Only character fields can be decoded", Exclamation! )
	RETURN -1
END IF

// Remove the return character from the label
lnv_string.of_clean_label( as_col_nam )

// Check for duplicate choice.
IF dw_decode.RowCount() > 0 THEN
	IF dw_decode.Find( "col_nam = '" + as_col_nam + "'", 1, dw_decode.RowCount() ) <> 0 THEN RETURN 1
END IF

// Initialize column info if there is none
IF Upperbound(asx_decode_struc.col_name) = 0 THEN
	FOR li_index = 1 TO Integer(audw_requestor.Describe ("datawindow.column.count"))
		asx_decode_struc.col_name			[li_index] = audw_requestor.Describe('#'+string(li_index)+'.name')
		asx_decode_struc.col_lookup_type	[li_index] = ""
	NEXT
END IF

iudw_requestor = audw_requestor
isx_decode_struc = asx_decode_struc

// If coded, decode. If decode, code.
IF lnv_decode.of_is_decoded( iudw_requestor, as_dbcol_nam ) THEN
	li_col = 1
ELSE
	// Get invoice type
	IF len(is_invoice_type) > 0 AND is_invoice_type <> gnv_dict.ics_not_found THEN
		ls_inv_type = is_invoice_type
	ELSEIF Upperbound(asx_decode_struc.table_type) > 0 THEN
		ls_inv_type = asx_decode_struc.table_type[1]
	ELSE
		MessageBox( "Decode Error", "Unable to determine invoice type", Exclamation! )
		RETURN -1	
	END IF

	// Get Lookup type for decode column
	IF li_decode_col > 0 &
	AND Upperbound(asx_decode_struc.col_name) 		 >= li_decode_col &
	AND Upperbound(asx_decode_struc.col_lookup_type) >= li_decode_col THEN
		IF len(asx_decode_struc.col_lookup_type [li_decode_col]) > 0 THEN
		// Use decode from structure
			ls_lookup = asx_decode_struc.col_lookup_type [li_decode_col]
		ELSE
			ls_lookup = lnv_decode.of_get_lookup( ls_inv_type, as_dbcol_nam )
		END IF
	ELSE
		// Get lookup from Dictionary
		ls_lookup = lnv_decode.of_get_lookup( ls_inv_type, as_dbcol_nam )	
	END IF
	
	// Check the claim main and dependent 
	// invoice type(s) if drilldown to Pat/Prov
	IF len(ls_lookup) = 0 OR ls_lookup = gnv_dict.ics_not_found THEN
		IF ls_inv_type = "PV" OR ls_inv_type = "EN" THEN
			IF Upper( iw_active.ClassName() ) = "W_QUERY_ENGINE" THEN
				lw_query_engine = iw_active
				luo_query = lw_query_engine.wf_getpreviousquery()
				IF IsValid( luo_query ) THEN
					IF luo_query.of_get_ib_drilldown_mode() THEN
						// Check main claim type
						ls_lookup = lnv_decode.of_get_lookup( luo_query.is_inv_type, as_dbcol_nam )
						
						// If still not found check dependent invoice type
						IF len(ls_lookup) = 0 OR ls_lookup = gnv_dict.ics_not_found THEN
							ls_lookup = lnv_decode.of_get_lookup( luo_query.is_add_inv_type, as_dbcol_nam )
						END IF
					END IF
				END IF
			END IF
		END IF
	END IF
	
	// If No lookup found, exit
	IF len(ls_lookup) = 0 &
	OR ls_lookup = gnv_dict.ics_not_found THEN
		MessageBox( "Decode Error", "This column is not a lookup field and cannot be decoded.", Exclamation! )
		RETURN -1	
	END IF
END IF

// Insert the values to the DW
li_NewRow = dw_decode.InsertRow( 0 )
IF IsNull( li_NewRow ) OR li_NewRow < 0 THEN RETURN -1
IF dw_decode.SetItem( li_NewRow, "col_nam", as_col_nam ) = -1 THEN RETURN -1
IF dw_decode.SetItem( li_NewRow, "db_col", as_dbcol_nam ) = -1 THEN RETURN -1
IF dw_decode.SetItem( li_NewRow, "code_decode", li_col ) = -1 THEN RETURN -1
IF dw_decode.SetItem( li_NewRow, "col_num", li_decode_col ) = -1 THEN RETURN -1
IF dw_decode.SetItem( li_NewRow, "sort", "N" ) = -1 THEN RETURN -1
IF dw_decode.SetItem( li_NewRow, "lookup_type", ls_lookup ) = -1 THEN RETURN -1
dw_decode.ScrollToRow( li_NewRow )

// Turn off sorting if break 
// with totals is enabled in QE
IF Upper( iw_active.ClassName() ) = "W_QUERY_ENGINE" THEN
	lw_query_engine = iw_active
	IF IsValid( lw_query_engine ) THEN
		IF lw_query_engine.ib_break_with_totals THEN
			dw_decode.Object.sort.Visible="0"
			st_1.visible = FALSE
		END IF
	END IF
END IF

cb_execute.Enabled = TRUE
cb_clear.Enabled = TRUE
cb_delete.enabled = true

of_filtercolumns()

RETURN 1
end function

public subroutine of_set_invoice_type (string as_inv_type);//*********************************************************************************
// Script Name:	u_decode::of_set_invoice_type
//
// Arguments:	string		as_inv_type
//
// Returns:		N/A
//
// Description:	Populate the col_name drop down in dw_decode
//
//*********************************************************************************
//
//	04/19/05	MikeF		SPR4378d		Created
//	07/29/05	GaryR	Track 4432d		Allow multi-column decode in background
//
//*********************************************************************************
is_invoice_type = as_inv_type
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

dw_decode.getchild( "col_nam", ldwc_uo_columns)
//Get row count for table
li_rowcount = dw_decode.rowcount( )
//Go through rows creating string for filtering the child datawindow
of_populatecolumns(isx_decode_struc, iudw_requestor)
ls_filter = "UPPER(db_col) not in("
FOR li_ctr = 1 TO li_rowcount
	ls_dbcolname = dw_decode.getitemstring(li_ctr,"db_col")
	if not (trim(ls_dbcolname) = "" or isNull(ls_dbcolname))then 
		ls_filter = ls_filter + "'" + UPPER(ls_dbcolname) + "',"
		lb_filter = true
	end if
Next
if lb_filter then 
	ls_filter = Left(ls_filter, Len(ls_filter) - 1) + ")"
	ldwc_uo_columns.setfilter( ls_filter)
	ldwc_uo_columns.filter( )
end if
end subroutine

public function long of_populatecolumns (ref sx_decode_structure asx_decode_struc, ref u_dw audw_requestor);//*********************************************************************************
// Script Name:	u_decode::of_populatecolumns
//
// Arguments:	sx_decode_structure	asx_decode_struct
//					u_dw						audw_requestor
//
// Returns:		integer
//
// Description:	Populate the col_name drop down in dw_decode
//
//*********************************************************************************
//
// 04/07/09 Katie	GNL.600.5633 Initial Creation.
// 04/10/09 Katie	GNL.600.5633 Trimmed column name and returned rowcount rather 
//						than 0 so that the w_uo_win can determine if any fields were populated into the drop-down.
//	05/04/09	Katie	GNL.600.5633	Accomidate duplicate columns as encountered in Patterns.  
//	05/05/09	Katie	GNL.600.5633	Added isvalid check before processing columns.
//	05/12/09	Katie	GNL.600.5633	Add logic to ensure columns are visible before adding them to the drop-down 
//											list.
// 07/15/09	GaryR	WIN.650.5721.001	Replace two references to db_col_name with col_name
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
//	07/30/09	GaryR	WIN.650.5721.006	Check visible property for formula
//
//*********************************************************************************

int li_col_num = 0, li_index
long ll_row, ll_width, ll_visible
string ls_col_name, ls_col_label, ls_data_type, ls_lookup, ls_hdr_name, &
			ls_visible, ls_dbname
datawindowchild ldwc_uo_columns
n_cst_decode	lnv_decode
w_query_engine	lw_query_engine
uo_query	luo_query
n_cst_string	lnv_string

if not IsValid(audw_requestor) then return -1

dw_decode.GetChild( "col_nam", ldwc_uo_columns )
iudw_requestor = audw_requestor
isx_decode_struc = asx_decode_struc

ldwc_uo_columns.reset( )

// Initialize column info if there is none
IF Upperbound(asx_decode_struc.col_name) = 0 THEN
	FOR li_index = 1 TO Integer(audw_requestor.Describe ("datawindow.column.count"))
		asx_decode_struc.col_name			[li_index] = audw_requestor.Describe('#'+string(li_index)+'.name')
		asx_decode_struc.col_lookup_type	[li_index] = ""
	NEXT
END IF

li_col_num =  Upperbound(asx_decode_struc.data_type) 

FOR li_index = 1 TO li_col_num
	ls_data_type = asx_decode_struc.data_type[li_index]
	//determine if character data type before adding column to drop-down list
	if gnv_sql.of_is_character_data_type( ls_data_type ) then
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
					
		// Get Lookup type for decode column
		IF li_index > 0 &
		AND Upperbound(asx_decode_struc.col_name) 		 >= li_index &
		AND Upperbound(asx_decode_struc.col_lookup_type) >= li_index THEN
			IF len(asx_decode_struc.col_lookup_type [li_index]) > 0 THEN
			// Use decode from structure
				ls_lookup = asx_decode_struc.col_lookup_type [li_index]
			ELSE
				ls_lookup = lnv_decode.of_get_lookup( asx_decode_struc.table_type[1], asx_decode_struc.col_name[li_index])
			END IF
		ELSE
			// Get lookup from Dictionary
			ls_lookup = lnv_decode.of_get_lookup(asx_decode_struc.table_type[1], asx_decode_struc.col_name[li_index])
		END IF
		
		// Check the claim main and dependent 
		// invoice type(s) if drilldown to Pat/Prov
		IF len(ls_lookup) = 0 OR ls_lookup = gnv_dict.ics_not_found THEN
			IF asx_decode_struc.table_type[1] = "PV" OR asx_decode_struc.table_type[1] = "EN" THEN
				IF Upper( iw_active.ClassName() ) = "W_QUERY_ENGINE" THEN
					lw_query_engine = iw_active
					luo_query = lw_query_engine.wf_getpreviousquery()
					IF IsValid( luo_query ) THEN
						IF luo_query.of_get_ib_drilldown_mode() THEN
							// Check main claim type
							ls_lookup = lnv_decode.of_get_lookup( luo_query.is_inv_type,asx_decode_struc.col_name[li_index] )
							
							// If still not found check dependent invoice type
							IF len(ls_lookup) = 0 OR ls_lookup = gnv_dict.ics_not_found THEN
								ls_lookup = lnv_decode.of_get_lookup( luo_query.is_add_inv_type,asx_decode_struc.col_name[li_index] )
							END IF
						END IF
					END IF
				END IF
			END IF
		END IF
		
		// If No lookup found, exit
		IF len(ls_lookup) = 0 &
		OR ls_lookup = gnv_dict.ics_not_found THEN
		else 
			if (ll_visible > 0) AND (ll_width > 1) then
				lnv_string.of_clean_label( ls_col_label )
				ll_row = ldwc_uo_columns.insertrow( 0)
				ldwc_uo_columns.setitem( ll_row, "col_name", ls_col_label)
				ldwc_uo_columns.setitem( ll_row, "lookup_type",ls_lookup)
				ldwc_uo_columns.setitem( ll_row, "col_num",li_index)
				ldwc_uo_columns.setitem( ll_row, "db_col",ls_col_name)
				IF lnv_decode.of_is_decoded( iudw_requestor, ls_col_name ) THEN
					ldwc_uo_columns.setitem( ll_row, "code_decode",1)
				else
					ldwc_uo_columns.setitem( ll_row, "code_decode",0)
				end if
			end if
		END IF
	end if
NEXT
ldwc_uo_columns.setsort( "col_name")
ldwc_uo_columns.sort( )
ldwc_uo_columns.setrow( 1)
return ldwc_uo_columns.rowcount( )
end function

on u_decode.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.st_1=create st_1
this.dw_decode=create dw_decode
this.cb_execute=create cb_execute
this.cb_clear=create cb_clear
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_insert
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_decode
this.Control[iCurrent+5]=this.cb_execute
this.Control[iCurrent+6]=this.cb_clear
end on

on u_decode.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.st_1)
destroy(this.dw_decode)
destroy(this.cb_execute)
destroy(this.cb_clear)
end on

type cb_delete from u_cb within u_decode
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1568
integer y = 208
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
// Description:	Clicked even for the delete button.  Delete rows from dw_decode where delete checkbox is selected.  
//					If no rows to delete present message.
//
//*********************************************************************************
//
// 04/07/09	Katie	GNL.600.5633	Initial Creation.
// 04/21/09	Katie	GNL.600.5633	Fix typo in delete message
// 04/21/09	Katie	GNL.600.5633	Added function calls to update the filter on the col_nam column after deletion has occurred.
//
//*********************************************************************************

int li_rowcount, li_ctr, li_delcount = 0
string ls_deltvalue
//Get row count for table
li_rowcount = parent.dw_decode.rowcount( )
//Go through rows removing those with del indicator checked
FOR li_ctr = 1 TO li_rowcount
	ls_deltvalue = parent.dw_decode.GetItemString( li_ctr, "delete" )
	if (ls_deltvalue = "Y") then
		parent.dw_decode.deleterow( li_ctr)
		li_rowcount = li_rowcount - 1
		li_ctr=li_ctr - 1
		li_delcount = li_delcount + 1
	end if
Next

if (li_delcount = 0 ) then
	Messagebox('Delete Row','Please check the Delete Indicator for the row(s) you wish to delete.')
end if

li_rowcount = parent.dw_decode.rowcount( )
if (li_rowcount > 0) then
	cb_execute.enabled = TRUE
	of_filtercolumns()
else
	cb_clear.enabled = FALSE
	cb_execute.enabled = FALSE
	THIS.Enabled = FALSE
	of_populatecolumns(isx_decode_struc, iudw_requestor)
end if
end event

type cb_insert from u_cb within u_decode
string accessiblename = "Insert"
string accessibledescription = "Insert"
integer x = 1568
integer y = 108
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
// Description:	Insert row into dw_decode and enable buttons as needed
//
//*********************************************************************************
//
// 04/07/09 Katie GNL.600.5633 Initial Creation.
//	05/04/09	Katie	GNL.600.5633	Ensure focus is on the col name column if the user happens to be tabbing
//						through the controls.
//
//*********************************************************************************

integer li_newrow
li_newrow = dw_decode.insertrow( 0)
dw_decode.setrow( li_newrow)
dw_decode.setcolumn( 1)
dw_decode.setfocus( )

cb_execute.enabled = true
cb_clear.enabled = true
cb_delete.enabled = true

end event

type st_1 from statictext within u_decode
string accessiblename = "To improve the decode performance, please enable the sort on each column that requires decoding."
string accessibledescription = "To improve the decode performance, please enable the sort on each column that requires decoding."
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 328
integer width = 1134
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "To improve the decode performance, please enable the sort on each column that requires decoding."
boolean focusrectangle = false
end type

type dw_decode from u_dw within u_decode
string accessiblename = "Decode Data Window"
string accessibledescription = "Decode Data Window"
integer x = 9
integer y = 8
integer width = 1550
integer height = 312
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_decode"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;//*********************************************************************************
// Script Name:	dw_decode.doubleclicked
//
// Arguments:	int 		xpos
//					int			ypos
//					long		row
//					dwobject dwo
//
// Returns:		long pbm_dwnlbutton
//
// Description:	Executes code when a row in the data window is double-clicked.
//
//*********************************************************************************
//
// 04/08/09 Katie	GNL.600.5633 Removed the double click functionality.
//
//*********************************************************************************
end event

event itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	dw_decode.itemchanged
//
// Arguments:	long		row
//					dwobject dwo
//					string		data
//
// Returns:		long pbm_dwnitemchange
//
// Description:	When col_name changed properly set the items in dw_decode from the items in d_dddw_uo_columns.
//
//*********************************************************************************
//
// 04/07/09 Katie GNL.600.5633 Initial Creation.
// 04/21/09 Katie GNL.600.5633 Added logic to filter data window when column selection has changed.
//	05/04/09	Katie	GNL.600.5633	Removed column filtering because it was causing user to get stuck in a loop when
//						using the keyboard functionality.
//
//*********************************************************************************

int li_currentdecode, li_currentrow, li_rowcount, li_ctr
datawindowchild ldwc_uo_columns
String ls_colname, ls_dbcolname, ls_filter

if (dwo.name = "col_nam") then 
	getchild( "col_nam", ldwc_uo_columns)

	li_currentrow = ldwc_uo_columns.getrow( )
	li_currentdecode = dw_decode.getrow( )

	ls_colname = ldwc_uo_columns.getitemstring( li_currentrow, "col_name") 
	
	dw_decode.SetItem( li_currentdecode, "col_nam", ls_colname)
	dw_decode.SetItem( li_currentdecode, "db_col",  ldwc_uo_columns.getitemstring( li_currentrow,"db_col"))
	dw_decode.SetItem( li_currentdecode, "code_decode", ldwc_uo_columns.getitemnumber( li_currentrow,"code_decode"))
	dw_decode.SetItem( li_currentdecode, "col_num",  ldwc_uo_columns.getitemnumber( li_currentrow,"col_num"))
	dw_decode.SetItem( li_currentdecode, "lookup_type",  ldwc_uo_columns.getitemstring( li_currentrow,"lookup_type"))
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_decode.rowfocuschanged
//
// Arguments:	long		currentrow
//
// Returns:		long
//
// Description:	When the user moves to a new row filter the columns that they can view.
//
//*********************************************************************************
//
//	05/04/09	Katie	GNL.600.5633	Initial creation.
//
//*********************************************************************************

of_filtercolumns()
end event

type cb_execute from u_cb within u_decode
string accessiblename = "Execute"
string accessibledescription = "Execute"
integer x = 1568
integer y = 8
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "&Execute"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_execute.clicked
//
// Arguments:	n/a
//
// Returns:		long pbm_clicked
//
// Description:	Execute decode of selected columns
//
//*********************************************************************************
//
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	04/13/09	Katie		GNL.600.5633	Clear out blank rows before executing decode.
//	04/21/09	Katie		GNL.600.5633	Changed clean-up logic to only remove blank rows and to do so
//							by deleting directly instead of using the db_delete.clicked() functionality.
//
//*********************************************************************************

Integer	li_rowcount, li_ctr, li_delcount, li_rowcount2, li_ctr2
Long		ll_codecount
String 	ls_colname, ls_colname2, ls_delind
n_cst_decode	lnv_decode
n_cst_decode_attrib	lnv_decode_attrib

//Go through rows removing blanks
FOR li_ctr = 1 TO li_rowcount
	ls_colname = parent.dw_decode.GetItemString( li_ctr, "col_nam" )
	if (trim(ls_colname) = "" or isNull(ls_colname))then 
		dw_decode.deleterow( li_ctr)
	end if
Next

li_rowcount = dw_decode.RowCount()
ll_codecount = iudw_requestor.RowCount()
IF li_rowcount < 1 THEN Return

IF dw_decode.Find( "code_decode=0", 1, li_rowcount ) > 0 THEN
	IF ll_codecount > 1000 Then
		IF Messagebox('Decode','Decoding a large result set may take awhile.' + &
						'~n~rDo you wish to continue with the decoding process?', Exclamation!,YesNo!,2) = 2 THEN Return
	End If
	
	//	If decoding, initialize transaction
	IF lnv_decode.of_initialize_add() < 1 THEN Return
END IF

li_rowcount = dw_decode.rowcount( )
// Set the attributes
FOR li_ctr = 1 TO li_rowcount
		lnv_decode_attrib.is_col_nam[li_ctr] = dw_decode.GetItemString( li_ctr, "col_nam" )
		lnv_decode_attrib.is_db_col[li_ctr] = dw_decode.GetItemString( li_ctr, "db_col" )
		lnv_decode_attrib.ii_code_decode[li_ctr] = dw_decode.GetItemNumber( li_ctr, "code_decode" )
		lnv_decode_attrib.ii_col_num[li_ctr] = dw_decode.GetItemNumber( li_ctr, "col_num" )
		lnv_decode_attrib.is_sort[li_ctr] = dw_decode.GetItemString( li_ctr, "sort" )
		lnv_decode_attrib.is_lookup_type[li_ctr] = dw_decode.GetItemString( li_ctr, "lookup_type" )
NEXT

lnv_decode_attrib.isx_decode_struc = isx_decode_struc
lnv_decode_attrib.iudw_requestor = iudw_requestor
lnv_decode_attrib.iw_active = iw_active
lnv_decode.POST of_process_code( lnv_decode_attrib )

// Close this window
iw_parent.cb_close.event clicked()
end event

type cb_clear from u_cb within u_decode
string accessiblename = "Clear All"
string accessibledescription = "Clear All"
integer x = 1568
integer y = 308
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
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
// Description:	Clear dw_decode and disable buttons as needed.
//
//*********************************************************************************
//
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//  04/07/09 Katie	GNL.600.5633 Disable cb_delete with all rows cleared
//  04/21/09	Katie	GNL.600.5633	Added function call to update the filter on the col_nam column after datawindow has been cleared.
//
//*********************************************************************************

dw_decode.Reset()
is_invoice_type = ""

cb_execute.Enabled = FALSE
cb_delete.enabled = false
THIS.Enabled = FALSE

of_populatecolumns(isx_decode_struc, iudw_requestor)
end event

