HA$PBExportHeader$u_append_filter.sru
forward
global type u_append_filter from u_base
end type
type dw_append_filter from u_dw within u_append_filter
end type
type cb_append from u_cb within u_append_filter
end type
end forward

global type u_append_filter from u_base
string accessiblename = "Append Filter"
string accessibledescription = "Append Filter"
integer width = 1819
integer height = 132
boolean border = false
dw_append_filter dw_append_filter
cb_append cb_append
end type
global u_append_filter u_append_filter

type variables
//*********************************************************************************
//
//	04/14/09		Katie				GNL.600.5633				Initial Creation.
//
//*********************************************************************************

u_dw idw_dw_name
sx_decode_structure isx_decode_struct
boolean ib_join = false
boolean ib_create = false
end variables

forward prototypes
public subroutine of_setcolumn (string as_col_name, sx_decode_structure asx_decode_struct, boolean ab_join)
public subroutine of_setcreate (boolean ab_create)
public function long of_populatecolumns (ref u_dw audw_requestor, sx_decode_structure asx_decode_struct)
public subroutine of_appendfilter ()
end prototypes

public subroutine of_setcolumn (string as_col_name, sx_decode_structure asx_decode_struct, boolean ab_join);// Script Name:	u_append_filter.of_setcolumn
//
// Arguments: string	as_col_name
//					sx_decode_structure	asx_decode_structure
//					boolean ab_join
//
// Returns:		None
//
// Description:	Set the column when the user double clicks on a column header.
//
//*********************************************************************************
//
//	04/14/09	Katie		GNL.600.5633		Initial Creation.
//	07/17/09	GaryR		WIN.650.5721.002	Standardize logic that removes return characters
//
//*********************************************************************************

n_cst_string	lnv_string

// Remove the return character from the label
lnv_string.of_clean_label( as_col_name )
isx_decode_struct = asx_decode_struct
ib_join =ab_join
dw_append_filter.Object.col_name[1] = as_col_name

cb_append.setfocus( )
end subroutine

public subroutine of_setcreate (boolean ab_create);// Script Name:	u_append_filter.of_setcreate
//
// Arguments: boolean ab_create
//
// Returns:		None
//
// Description:	Set the titles, accessibility properties, etc. for this to be a create filter instead of an append filter.
//
//*********************************************************************************
//
//	04/14/09		Katie				GNL.600.5633				Initial Creation.
//
//*********************************************************************************

ib_create = ab_create

if ib_create then 
	dw_append_filter.accessiblename = "Create Filter"
	dw_append_filter.accessibledescription = "Create Filter"

	cb_append.text = "Create"
	cb_append.accessibledescription = "Create Col Filter"
	cb_append.accessiblename = "Create Filter"
else
	dw_append_filter.accessiblename = "Append Col Filter"
	dw_append_filter.accessibledescription = "Append Col Filter"

	cb_append.text = "Append"
	cb_append.accessibledescription = "Append Col Filter"
	cb_append.accessiblename = "Append Col Filter"
end if
end subroutine

public function long of_populatecolumns (ref u_dw audw_requestor, sx_decode_structure asx_decode_struct);// Script Name:	u_append_filter.of_populatecolumns
//
// Arguments:  N/A
//
// Returns:		long
//
// Description:	Populate the col_name drop down in dw_append_filter.
//
//*********************************************************************************
//
//	04/14/09	Katie		GNL.600.5633		Initial Creation.
//	05/04/09	Katie		GNL.600.5633		Handle duplicate headers.
//	05/05/09	Katie		GNL.600.5633		Added isvalid check before processing columns.
//	05/12/09	Katie		GNL.600.5633		Add logic to check that columns are visible.
//	07/17/09	GaryR		WIN.650.5721.002	Standardize logic that removes return characters
//	07/30/09	GaryR		WIN.650.5721.006	Check visible property for formula
//
//*********************************************************************************

int li_col_num = 0, li_index
long ll_row, ll_visible, ll_width
string ls_col_name, ls_col_label, ls_data_type, ls_lookup, ls_dbname, &
			ls_visible, ls_hdr_name
datawindowchild ldwc_uo_columns
n_cst_string	lnv_string

if not IsValid(audw_requestor) then return -1

dw_append_filter.GetChild( "col_name", ldwc_uo_columns )
idw_dw_name = audw_requestor

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
isx_decode_struct = asx_decode_struct
if (upperbound(asx_decode_struct.table_type) > 1) then 
	ib_join = true
end if
ldwc_uo_columns.setsort( "col_name")
ldwc_uo_columns.sort( )

ll_row = dw_append_filter.getrow( )
dw_append_filter.setitem( ll_row,"col_name", " ")
return 1
end function

public subroutine of_appendfilter ();//*********************************************************************************
// Script Name:	of_appendfilter
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Open appropriate filter window per the ib_create function.  
//
//*********************************************************************************
//
// 04/27/09 Katie	GNL.600.5633 Initial Creation.
//	05/11/09	Katie	GNL.600.5633	Add edit for when the user does not select a value from the column
//											drop down.
// 09/04/2009 RickB SUM.650.5610.004 - Added Upper to value being assigned to ls_col_name
// 09/10/2009 RickB LKP.650.5678.004 - Getting table type from gv_code_to_use, which is 	
//							assigned a value in w_code_lookup.cb_filter clicked event.
//
//*********************************************************************************

int  				lv_len, li_index, li_row
int 				lv_count
string 			ls_col_name, ls_tbl_type
sx_filter_data lsx_filter_data
datawindowchild ldwc_uo_columns

setpointer(hourglass!)

if ib_create then
	setmicrohelp(w_main,'Opening Filter Independent Add...')
else
	setmicrohelp(w_main,'Opening Filter Independent List...')
end if


ls_col_name = dw_append_filter.getitemstring( 1, "col_name")
if (trim(ls_col_name) = "" or isNull(ls_col_name))then 
	if ib_create then
		Messagebox('Create Filter','Please select the column you wish to use to create your filter.')
	else
		Messagebox('Append Filter','Please select the column you wish to use to append to a filter.')
	end if
	setmicrohelp(w_main,'Ready')
	dw_append_filter.setfocus ()
	return
end if

dw_append_filter.getchild( "col_name", ldwc_uo_columns)
li_row = ldwc_uo_columns.getrow( )
ls_col_name = Upper(ldwc_uo_columns.getitemstring( li_row, "db_col"))

IF ls_col_name = 'CODE_CODE' THEN
	ls_tbl_type = gv_code_to_use

ELSE
	
	 //Loop through the table types until the column is found
	FOR li_index = 1 to UPPERBOUND(isx_decode_struct.table_type)
		IF gnv_dict.event ue_get_col_exists( isx_decode_struct.table_type[li_index], ls_col_name) THEN
			ls_tbl_type = isx_decode_struct.table_type[li_index]
			EXIT
		END IF
		
	NEXT
	
END IF
if ib_create then
	lsx_filter_data.sx_entry_mode 	= 'CREATE'
else
	lsx_filter_data.sx_entry_mode 	= 'APPEND'
end if
lsx_filter_data.sx_data_window 	= idw_dw_name
lsx_filter_data.sx_col_name 		= ls_col_name								
lsx_filter_data.sx_col_no 			= integer(idw_dw_name.Describe(lsx_filter_data.sx_col_name + '.ID'))
lsx_filter_data.sx_inv_type 			= ls_tbl_type
lsx_filter_data.sx_join 				= ib_join

if ib_create then
	OpenSheetWithParm(w_filter_maintain,lsx_filter_data,mdi_main_frame,help_menu_position,Layered!)
else
	Opensheetwithparm(w_filter_list,lsx_filter_data,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
end if

setmicrohelp(w_main,'Ready')
end subroutine

on u_append_filter.create
int iCurrent
call super::create
this.dw_append_filter=create dw_append_filter
this.cb_append=create cb_append
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_append_filter
this.Control[iCurrent+2]=this.cb_append
end on

on u_append_filter.destroy
call super::destroy
destroy(this.dw_append_filter)
destroy(this.cb_append)
end on

type dw_append_filter from u_dw within u_append_filter
string accessiblename = "Column Selection"
string accessibledescription = "Column Selection"
integer y = 12
integer width = 1458
integer height = 108
integer taborder = 10
string title = "none"
string dataobject = "d_append_filter"
boolean border = false
end type

event constructor;// Script Name:	dw_append_filter.constructor
//
// Arguments:  N/A
//
// Returns:		long
//
// Description:	 Insert single row into dw_append_filter.
//
//*********************************************************************************
//
//	04/14/09		Katie				GNL.600.5633				Initial Creation.
//
//*********************************************************************************

This.SetTransObject (Stars2ca) 
dw_append_filter.reset()
dw_append_filter.insertrow(0)

end event

type cb_append from u_cb within u_append_filter
string accessiblename = "Append Filter"
string accessibledescription = "Append Filter"
integer x = 1467
integer y = 16
integer width = 325
integer taborder = 20
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Append"
boolean cancel = true
end type

event clicked;call super::clicked;// Script Name:	cb_append.clicked
//
// Arguments:  N/A
//
// Returns:		long
//
// Description:	 Call the create filter function for the column selected.
//
//*********************************************************************************
//
//	04/14/09		Katie				GNL.600.5633				Initial Creation.
//	04/14/09		Katie				GNL.600.5633				Replace fx_create_filter call with call to of_appendfilter.
//
//*********************************************************************************

of_appendfilter()
end event

