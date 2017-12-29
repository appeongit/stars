HA$PBExportHeader$n_cst_decode.sru
$PBExportComments$<logic>
forward
global type n_cst_decode from nonvisualobject
end type
end forward

global type n_cst_decode from nonvisualobject autoinstantiate
end type

type variables
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	01/18/06	GaryR	Track 4621d	Move redundant Patient logic to improve efficiency
//	10/18/06	GaryR	Track 4832	Change scope of n_cst_stars_rel to improve efficiency

constant String	ics_not_avail = 'Description not available'
constant String	ics_decode = ";DECODE=TRUE;"
constant String	ics_enddecode = ";ENDDECODE"

String	is_prev_value, is_prev_type, is_prev_desc
String	is_prev_inv, is_prev_col
Integer	ii_decode_len, ii_en_xref
Long		il_step

n_tr	atr
w_master_status	iw_status
n_cst_decode_attrib	inv_decode_attrib
n_cst_stars_rel 	inv_rel
sx_decode_structure iv_decode_struct
end variables

forward prototypes
public function string of_get_description (string as_type, string as_value)
private function integer of_add_desc (integer ai_row)
public function string of_get_lookup (string as_tbl_type, string as_decode_col)
public subroutine of_process_code (n_cst_decode_attrib anv_decode_attrib)
private subroutine of_remove_desc (integer ai_row)
public subroutine of_reset_col (string as_db_col, u_dw adw_requestor)
public function boolean of_is_decoded (u_dw adw_requestor, string as_db_col)
public function boolean of_is_decoded (u_dw adw_requestor, integer ii_col_num)
public function integer of_remove_desc (ref string as_value)
public function integer of_remove_desc (u_dw adw_requestor, string as_db_col)
public function integer of_initialize_add ()
public function integer of_set_decode_struct (sx_decode_structure as_decode_struct)
public function integer of_display_rm_lookup (ref u_dw a_dw)
end prototypes

public function string of_get_description (string as_type, string as_value);//===================================================================================================//
// Object		n_cst_decode
// Function		of_get_description		public
// Arguments	as_type	String	Lookup Type
//					as_value	String	Lookup Value
// Returns		Description for Value and type (string)
// ------------------------------------------------------------------------------------------------- //
// Finds and returns a description for a given code/type combination
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4378d	Created
//	01/18/06	GaryR	Track 4621d	Move redundant Patient logic to improve efficiency
// 07/24/06	GaryR	Track 4799	Validate nulls in UPINs that do not get a hit
//	11/21/06 Katie SPR 4766 Added logic to decode NPI.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//===================================================================================================//

string 			ls_desc, ls_fname, ls_lname

// If this search is the same as the previous, Return last description and exit
IF  as_type  = is_prev_type &
AND as_value = is_prev_value THEN
	RETURN is_prev_desc
ELSE
	is_prev_type 	= as_type
	is_prev_value 	= as_value
END IF

as_type 	= UPPER(as_type)
as_value = UPPER(as_value)

// Perform lookup
CHOOSE CASE as_type
		
	CASE 'PV' // Providers 
		
		SELECT PROV_NAME
		INTO :ls_desc
		FROM PROVIDERS
		WHERE PROV_ID = :as_value
		Using atr;

	CASE 'RI' // Patient 
	
		IF ii_en_xref = 1 THEN
			
			// Uses XREF - Go against ENROLLEE view
			SELECT PATIENT_NAME
			INTO :ls_desc
			FROM ENROLLEE
			WHERE RECIP_ID = :as_value
			USING atr;
		
		ELSE
		
			// No XREF - Go against ENROLLEE_INFO table
			SELECT PATIENT_NAME
			INTO :ls_desc
			FROM ENROLLEE_INFO
			WHERE RECIP_RID = :as_value
			USING atr;
		
		END IF
		
	CASE 'UP' // Provider UPIN
	
		IF as_value = 'EXEMPT' THEN
			is_prev_desc = this.ics_not_avail
			RETURN is_prev_desc
		END IF
		
		SELECT MAX(PROV_NAME)
		INTO :ls_desc
		FROM PROVIDERS
		WHERE PROV_UPIN = :as_value
		USING atr;
		
		// Check for null value
		IF IsNull( ls_desc ) THEN ls_desc = this.ics_not_avail
		
	CASE 'NPI' // Provider NPI
		
		SELECT MAX(PROV_NPI_NAME)
		INTO :ls_desc
		FROM PROV_NPI_XREF
		WHERE PROV_NPI = :as_value
		USING atr;
		
		// Check for null value
		IF IsNull( ls_desc ) THEN ls_desc = this.ics_not_avail
		
	CASE 'USERS' // User ID
			
		SELECT USERS.USER_F_NAME, USERS.USER_L_NAME
		INTO :ls_fname, :ls_lname
		FROM USERS  
		WHERE USER_ID = :as_value
		USING atr;
		
		ls_desc = Trim( ls_fname + " " + ls_lname )
	
	CASE ELSE // CODE lookup

		SELECT CODE_DESC
		INTO :ls_desc
		FROM CODE
		WHERE CODE_TYPE = :as_type
		  AND CODE_CODE = :as_value
		USING atr;

END CHOOSE

// Check return code
IF gnv_sql.of_is_multiple_select( atr ) THEN
	ls_desc = 'Multiple values returned'
ELSEIF atr.of_check_status() = 0 Then
	ls_desc = Trim( ls_desc )
Elseif atr.sqlcode = 100 Then
	ls_desc = this.ics_not_avail
END IF

is_prev_desc = ls_desc

RETURN ls_desc
end function

private function integer of_add_desc (integer ai_row);//===================================================================================================//
// Object		n_cst_decode
// Function		of_add_desc		private
// Arguments	Integer	ai_row
// Returns		Integer <0 = Error	0=OK	>0 = Blanks were found
// ------------------------------------------------------------------------------------------------- //
// Loops through datawindow and appends decriptions to a column
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	Track 4378d	Created
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	01/18/06	GaryR	Track 4621d	Move redundant Patient logic to improve efficiency
//	07/10/06	GaryR	Track 4387d	Allow invoice specific lookups in ML patterns
//	09/08/06	GaryR	Track 4814	Handle sorting on Money/Unit/Break w/ Totals in QE
//	03/05/07	Katie		SPR 4864 Righttrim instead of trim the code value
// 09/10/09	GaryR	QEN.650.5229.004	Remove obsolete money/unit totals logic
//
//===================================================================================================//

string	ls_decode_col, ls_value, ls_data_type, ls_lookup, &
			ls_desc, ls_inv_type, ls_width, ls_align, ls_tag, ls_dbcol
long		ll_row, ll_rowcount, ll_width, li_blank
int		li_decode_col, li_inv_col, li_rc, li_index
u_nvo_sys_cntl	lnv_sys_cntl

Setmicrohelp(w_main,'Please wait, adding descriptions for column ' + &
								inv_decode_attrib.is_col_nam[ai_row])

//Ge the flag for Patient lookups
lnv_sys_cntl = Create u_nvo_sys_cntl
lnv_sys_cntl.of_set_cntl_id("EN_XREF")
ii_en_xref = lnv_sys_cntl.of_get_cntl_no()
Destroy lnv_sys_cntl
										
ls_decode_col = inv_decode_attrib.is_db_col[ai_row]
li_decode_col = inv_decode_attrib.ii_col_num[ai_row]
ls_lookup = inv_decode_attrib.is_lookup_type[ai_row]

// If ML query, get column number of INVOICE_TYPE column
IF inv_decode_attrib.isx_decode_struc.is_ml_query THEN
	FOR li_index = 1 to Upperbound(inv_decode_attrib.isx_decode_struc.col_name)
		IF inv_decode_attrib.isx_decode_struc.col_name[li_index] = 'INVOICE_TYPE' then
			li_inv_col = li_index
			EXIT		
		END IF			
	NEXT	
END IF

// If from Pattern, get invoice/lookup type from header prefix
IF inv_decode_attrib.isx_decode_struc.is_ml_patt THEN
	ls_inv_type = left( inv_decode_attrib.is_col_nam[ai_row], 2 )
	ls_dbcol = Upper (inv_decode_attrib.iudw_requestor.Describe( ls_decode_col + ".dbname" ))
	ls_lookup = This.of_get_lookup( ls_inv_type, ls_dbcol )
	
	// Check for errors
	IF ls_lookup = gnv_dict.ics_error OR ls_lookup = gnv_dict.ics_not_found THEN
		ls_lookup = inv_decode_attrib.is_lookup_type[ai_row]
	END IF
END IF

// Loop through all rows and decode
inv_decode_attrib.iudw_requestor.SetRedraw( FALSE )

IF inv_decode_attrib.is_sort[ai_row] = "Y" THEN
	inv_decode_attrib.iudw_requestor.SetSort( ls_decode_col + " ASC" )
	inv_decode_attrib.iudw_requestor.Sort()
END IF

ll_rowcount = inv_decode_attrib.iudw_requestor.rowcount()

FOR ll_row = 1 to ll_rowcount
	// Check to see if decode was cancelled or window was closed
	IF IsValid(iw_status) THEN
	 	IF iw_status.ib_cancelled THEN EXIT
	ELSE
		EXIT
	END IF
	
	il_step++
	iw_status.uf_step( il_step )
	ls_value = righttrim(inv_decode_attrib.iudw_requestor.GetItemString(ll_row,li_decode_col))
		
	IF len(ls_value) = 0 THEN
		li_blank++
		CONTINUE
	END IF
	
	IF inv_decode_attrib.isx_decode_struc.is_ml_query THEN
		IF ls_decode_col = 'PROV_ID' 		&
		OR ls_decode_col = 'PROV_UPIN' 	&
		OR ls_decode_col = 'RECIP_ID' 	THEN
			// Current lookup is fine. Bypass
		ELSE
			// Get invoice type of row and look for lookup
			ls_inv_type = left(inv_decode_attrib.iudw_requestor.GetItemString(ll_row,li_inv_col),2)
			ls_lookup	= this.of_get_lookup( ls_inv_type, ls_decode_col )
		END IF
	END IF
	
	ls_desc = this.of_get_description( ls_lookup, ls_value )	
	
	IF ls_desc = this.ics_not_avail THEN
		li_blank++
	ELSE
		// If DECODE is set in SYS_CNTL, truncate description
		IF ii_decode_len > 0 THEN
			ls_desc = left(ls_desc,ii_decode_len)
		END IF
	END IF

	li_rc = inv_decode_attrib.iudw_requestor.SetItem(ll_row,li_decode_col, ls_value + ' - ' + ls_desc)
NEXT

//	Resize and realign the column
// Get original Width and Alignment
ls_width = inv_decode_attrib.iudw_requestor.Describe( ls_decode_col + ".Width" )
ls_align = inv_decode_attrib.iudw_requestor.Describe( ls_decode_col + ".Alignment" )

ll_width = Long( ls_width ) + 200
// Commented out as temporary "fix" for SPR 4264d - Dissapearing headers and footers
inv_decode_attrib.iudw_requestor.Modify( ls_decode_col + ".Width = " + String( ll_width ) )
inv_decode_attrib.iudw_requestor.Modify( ls_decode_col + ".Alignment = 0" )

//Mark column as decoded
ls_tag = inv_decode_attrib.iudw_requestor.Describe( ls_decode_col + ".Tag" )
ls_tag += ics_decode + "WIDTH=" + ls_width + ";ALIGN=" + ls_align + ics_enddecode
inv_decode_attrib.iudw_requestor.Modify( ls_decode_col + ".Tag='" + ls_tag + "'" )

inv_decode_attrib.iudw_requestor.SetRedraw( TRUE )

Return li_blank
end function

public function string of_get_lookup (string as_tbl_type, string as_decode_col);//===================================================================================================//
// Object		n_cst_decode
// Function		of_get_lookup		private
// Arguments	as_tbl_type			Default invoice type to search
//					as_decode_col		Column name to obtain lookup
// Returns		String				Lookup type if found, else blank
// ------------------------------------------------------------------------------------------------- //
// Finds and returns a column's lookup type. 
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4378d	Created
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	10/18/06	GaryR	Track 4832	Change scope of n_cst_stars_rel and check 
//										previously set values to improve efficiency
//===================================================================================================//

int			li_index, li_rc
string		ls_rev_type, ls_lookup

IF as_tbl_type = gnv_dict.ics_not_found THEN RETURN ""

// If the inv type and col name have not changed, then return previuos lookup type
IF as_tbl_type = is_prev_inv AND as_decode_col = is_prev_col THEN Return is_prev_type

//	Reset previous variables
is_prev_inv = as_tbl_type
is_prev_col = as_decode_col

// Get lookup Type from dictionary
ls_lookup = gnv_dict.event ue_get_lookup_type( as_tbl_type, as_decode_col )

// If not found and UB92, search revenue 
IF  ls_lookup = gnv_dict.ics_not_found &
AND inv_rel.of_get_is_claims( as_tbl_type ) THEN
	IF inv_rel.of_get_is_ub92( as_tbl_type ) THEN
		ls_rev_type	= inv_rel.of_get_revenue( as_tbl_type )
		ls_lookup	= gnv_dict.event ue_get_lookup_type( ls_rev_type, as_decode_col )
	END IF
END IF

RETURN ls_lookup
end function

public subroutine of_process_code (n_cst_decode_attrib anv_decode_attrib);//===================================================================================================//
// Object		n_cst_decode
// Function		of_process_code	public
// Arguments	None
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Processes code/decode request. 
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4378d	Created
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

Integer	li_row, li_blank, li_rowcount
Long		ll_codecount

inv_decode_attrib = anv_decode_attrib
IF NOT IsValid( inv_decode_attrib.iw_active ) THEN Return
IF NOT IsValid( inv_decode_attrib.iudw_requestor ) THEN RETURN
inv_decode_attrib.iw_active.SetRedraw( TRUE )
inv_decode_attrib.iudw_requestor.SetRedraw( TRUE )
// Lock the requesting DW's sheet to prevent closing
inv_decode_attrib.iw_active.ib_lock_for_decode = TRUE
li_rowcount = UpperBound( inv_decode_attrib.is_col_nam )
ll_codecount = inv_decode_attrib.iudw_requestor.RowCount()

OpenWithParm(iw_status, 1)
iw_status.ib_prompt = TRUE
iw_status.uf_initialize( ll_codecount * li_rowcount, "row")

FOR li_row = 1 TO li_rowcount
	// Check to see if decode was cancelled or window was closed
	IF IsValid(iw_status) THEN
	 	IF iw_status.ib_cancelled THEN EXIT
	ELSE
		EXIT
	END IF
	
	iw_status.st_description.text = "Processing " + &
				inv_decode_attrib.is_col_nam[li_row] + "..."

	IF inv_decode_attrib.ii_code_decode[li_row] = 0 THEN				
		li_blank += This.of_add_desc( li_row )
	ELSE
		This.of_remove_desc( li_row )
	END IF
NEXT

// Close status window
IF IsValid(iw_status) THEN
	iw_status.ib_prompt = false
	CLOSE(iw_status)
END IF

//	Reset lock flag on sheet that holds the requesting DW
IF IsValid( inv_decode_attrib.iw_active ) THEN
	inv_decode_attrib.iw_active.ib_lock_for_decode = FALSE
END IF

w_main.SetMicrohelp( "Ready" )
end subroutine

private subroutine of_remove_desc (integer ai_row);//===================================================================================================//
// Object		n_cst_decode
// Function		of_remove_desc		private
// Arguments	Integer	ai_row
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Removes the description from a decoded column
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4378d	Created
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

string 	ls_value, ls_decode_col
long		ll_row, ll_rowcount

Setmicrohelp(w_main,'Please wait, removing descriptions for column ' + &
									inv_decode_attrib.is_col_nam[ai_row])
										
ls_decode_col = inv_decode_attrib.is_db_col[ai_row]

inv_decode_attrib.iudw_requestor.SetRedraw(FALSE)

// Loop through all rows and remove descriptions
ll_rowcount = inv_decode_attrib.iudw_requestor.rowcount()
FOR ll_row = 1 to ll_rowcount
	// Check to see if decode was cancelled or window was closed
	IF IsValid(iw_status) THEN
	 	IF iw_status.ib_cancelled THEN EXIT
	ELSE
		EXIT
	END IF
	
	il_step++
	iw_status.uf_step( il_step )
	ls_value = inv_decode_attrib.iudw_requestor.GetItemString(ll_row, ls_decode_col)

	IF This.of_remove_desc( ls_value ) > 0 THEN
		inv_decode_attrib.iudw_requestor.SetItem(ll_row,ls_decode_col,ls_value)
	END IF
NEXT

inv_decode_attrib.iudw_requestor.accepttext()

This.of_reset_col( ls_decode_col, inv_decode_attrib.iudw_requestor )

inv_decode_attrib.iudw_requestor.SetRedraw(TRUE)
end subroutine

public subroutine of_reset_col (string as_db_col, u_dw adw_requestor);//===================================================================================================//
// Object		n_cst_decode
// Function		of_reset_col
// Arguments	String	as_db_col - The column to reset
//					u_dw		adw_requestor - The datawindow requesting the service
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Removes the decode tag and resets properties for a decoded column of the requesting datawindow
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

int		li_pos, li_ctr
string 	ls_value, ls_tag
string	ls_properties[], ls_property[]
n_cst_string	lnv_string

//	Reset column properties and remove decode tag from column
ls_tag = adw_requestor.Describe( as_db_col + ".Tag" )
li_pos = Pos( ls_tag, ics_decode )
IF li_pos > 0 THEN
	ls_value = Mid( ls_tag, li_pos + 1 )
	ls_tag = Left( ls_tag, li_pos -1 )
	li_pos = Pos( ls_value, ics_enddecode )
	ls_tag += Mid( ls_value, li_pos + Len( ics_enddecode ) )
	ls_value = Left( ls_value, li_pos )
	ls_properties = lnv_string.of_stringtoarray( ls_value, ";")
	FOR li_ctr = 1 TO UpperBound( ls_properties )
		ls_property = lnv_string.of_stringtoarray( ls_properties[li_ctr], "=" )
		IF UpperBound( ls_property ) = 2 THEN
			CHOOSE CASE ls_property[1]
				CASE "WIDTH"
					adw_requestor.Modify( as_db_col + ".Width = " + ls_property[2] )
				CASE "ALIGN"
					adw_requestor.Modify( as_db_col + ".Alignment = " + ls_property[2] )
			END CHOOSE
		END IF
	NEXT
	
	adw_requestor.Modify( as_db_col + ".Tag='" + ls_tag + "'" )
END IF
end subroutine

public function boolean of_is_decoded (u_dw adw_requestor, string as_db_col);//===================================================================================================//
// Object		n_cst_decode
// Function		of_is_decoded
// Arguments	u_dw		adw_requestor - The datawindow requesting the service
//					String	as_db_col - The column check
//
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Checks if the column of the requesting DW has been decoded.
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

String	ls_tag

ls_tag = adw_requestor.Describe( as_db_col + ".Tag" )
Return Match( ls_tag, ics_decode )
end function

public function boolean of_is_decoded (u_dw adw_requestor, integer ii_col_num);//===================================================================================================//
// Object		n_cst_decode
// Function		of_is_decoded
// Arguments	u_dw		adw_requestor - The datawindow requesting the service
//					Integer	ii_col_num - The column number check
//
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Checks if the column of the requesting DW has been decoded.
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

String	ls_db_col

ls_db_col = adw_requestor.Describe( "#" + String( ii_col_num ) + ".Name" )
Return This.of_is_decoded( adw_requestor, ls_db_col )
end function

public function integer of_remove_desc (ref string as_value);//===================================================================================================//
// Object		n_cst_decode
// Function		of_remove_desc
// Arguments	String	as_value By Reference
// Returns		Integer -1 Error, 0 No Action, 1 Removed
// ------------------------------------------------------------------------------------------------- //
// Removes the description from a decoded value
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

Integer	li_pos

IF IsNull( as_value ) THEN Return -1

li_pos = Pos( as_value, " - " )
IF li_pos > 0 THEN
	as_value = Left(as_value, li_pos)
	gnv_sql.of_TrimData( as_value )
	Return 1
END IF

Return 0
end function

public function integer of_remove_desc (u_dw adw_requestor, string as_db_col);//===================================================================================================//
// Object		n_cst_decode
// Function		of_remove_desc
// Arguments	u_dw	adw_requestor	The datawindow requesting the service
//					String	as_db_col	The column from which to remove descriptions
// Returns		Integer	-1 Error, 0 No Action, 1 Removed
// ------------------------------------------------------------------------------------------------- //
// Removes the description from a decoded column
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

string 	ls_value
long		ll_row, ll_rowcount

IF NOT IsValid( adw_requestor ) OR IsNull( as_db_col ) OR Trim( as_db_col ) = "" THEN Return -1

IF NOT This.of_is_decoded( adw_requestor, as_db_col ) THEN Return 0

w_main.Setmicrohelp( 'Please wait, removing descriptions for column ' + as_db_col )						
adw_requestor.SetRedraw(FALSE)

// Loop through all rows and remove descriptions
ll_rowcount = adw_requestor.rowcount()
FOR ll_row = 1 to ll_rowcount
	ls_value = adw_requestor.GetItemString( ll_row, as_db_col )

	IF This.of_remove_desc( ls_value ) > 0 THEN
		adw_requestor.SetItem( ll_row, as_db_col, ls_value )
	END IF
NEXT

adw_requestor.accepttext()

This.of_reset_col( as_db_col, adw_requestor )

adw_requestor.SetRedraw( TRUE )
w_main.Setmicrohelp( "Ready" )

Return 1
end function

public function integer of_initialize_add ();//===================================================================================================//
// Object		n_cst_decode
// Function		of_initialize_add		private
// Arguments	None
// Returns		Integer	-1 Error, 1 Success
// ------------------------------------------------------------------------------------------------- //
// If adding descriptions only, get the number of characters for the description
//	and create a separate transaction object and connect to it.
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

u_nvo_sys_cntl 				lnv_sys_cntl
n_cst_clientinfo_attrib		lnv_client

//	Get the number of characters for description
lnv_sys_cntl = CREATE u_nvo_sys_cntl
lnv_sys_cntl.of_set_cntl_id( "DECODE" )
ii_decode_len = lnv_sys_cntl.of_get_cntl_no()
DESTROY lnv_sys_cntl

// Create local transaction
atr				= CREATE n_tr
atr.DBMS      	= stars2ca.DBMS
atr.Database  	= stars2ca.Database
atr.ServerName	= stars2ca.ServerName
atr.Lock      	= stars2ca.Lock
atr.DbParm    	= stars2ca.DbParm
atr.LogID     	= stars2ca.LogID
atr.LogPass   	= stars2ca.LogPass
atr.UserID    	= stars2ca.UserID
atr.DBPass    	= stars2ca.DBPass

lnv_client	=	gnv_server.of_GetClientInfo()
gnv_sql.of_set_schema (lnv_client.is_schema_name)
IF atr.of_connect( ) <> 0 THEN
	MessageBox( "Connection Error", "Unable to connect to transaction object in n_cst_decode" + &
								"~n~rThe decode process will terminate.", StopSign! )
	Return -1
END IF

Return 1
end function

public function integer of_set_decode_struct (sx_decode_structure as_decode_struct);// Katie 07/10/07 SPR 5108

iv_decode_struct = as_decode_struct

return 1
end function

public function integer of_display_rm_lookup (ref u_dw a_dw);//===================================================================================================//
// Object		n_cst_decode
// Function		of_display_rm_lookup public
// Arguments	u_dw a_dw
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Opens a window a window containing:
//		1. description of value if the selected row = 0
//		2. decode of value of the selected row > 9
// ------------------------------------------------------------------------------------------------- //
//		@TO-DO - Need new window for displaying the description/definition so that this function is not dependant on global variables.
//		@TO-DO - Needs to be tested in a situation where the column names do not start with "COMPUTE".
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/11/07	Katie	SPR 5108	Created
//	07/11/07	Katie	SPR 5108	Added logic to position window.  Changed argument name.  Changed errorboxes to MessageBoxes.
//	02/06/08	Katie	SPR 5269	Capture the row number when = 0 and bypass operations that would try to get the data type or 
//										value for that column.
//===================================================================================================//
int li_selected_row, li_selected_col
string ls_value = ''
int li_x

//Determine value to be decoded
li_selected_row = a_dw.getclickedrow( )
if IsNull(li_selected_row) then
	MessageBox('Lookup Error','Error determining row clicked.')
	return -1
end if
if (li_selected_row = 0) then
	ls_value = a_dw.getobjectatpointer( )
	if IsNull(ls_value) then
		MessageBox('Lookup Error','Error determining object at pointer.')
		return -1
	end if
	li_x = PixelsToUnits(integer( Describe(a_dw, ls_value+'.x')),XPixelsToUnits!)
	if (UPPER(left(ls_value,8)) = 'COMPUTE_') then 
		ls_value = right(left(ls_value, Pos(ls_value, '_t')-1),4)
	else 
		ls_value = left(ls_value, Pos(ls_value, '_t')-1)
	end if
	li_selected_col = integer(ls_value)
	if (li_selected_col > 0) then 
		ls_value = iv_decode_struct.db_col_name[li_selected_col]
	end if
else
	li_selected_col = a_dw.getclickedcolumn( )
	if IsNull(li_selected_col) then
		MessageBox('Lookup Error','Error determining column clicked.')
		return -1
	end if
	if (li_selected_col = 0) then
	else
		if NOT (gnv_sql.of_is_character_data_type(iv_decode_struct.data_type[li_selected_col])) then
			MessageBox('Lookup Error','Only character fields can be decoded.')
			return -1
		end if
		ls_value = a_dw.getitemstring(li_selected_row,li_selected_col)
	end if
end if

//Position the window

gv_win_y_pos = a_dw.y
gv_win_x_pos = a_dw.x+li_x+170

// Decode value and display appropriate window
if (ls_value <> '') then 
// Header row
	if (li_selected_row = 0) then
		// Store column name in global variable
		gv_element_name = ls_value
		// Store table types in global variables
		if (UpperBound(iv_decode_struct.table_type) > 0) then
			if (iv_decode_struct.table_type[1] <> '') then
				gv_element_table_type = iv_decode_struct.table_type[1] 
			end if
			if (UpperBound(iv_decode_struct.table_type) > 1) then
				if (iv_decode_struct.table_type[2] <> '') then
					gv_element_table_type2 = iv_decode_struct.table_type[2] 
				end if
				if (UpperBound(iv_decode_struct.table_type) > 3) then
					if (iv_decode_struct.table_type[3] <> '') then
						gv_element_table_type3 = iv_decode_struct.table_type[3] 
					end if
				end if 
			end if
		else
			MessageBox('Lookup Error','No table information stored for this lookup.')
			return -1
		end if
		// Open window
		open(w_dwlabel_definition)
	else
	// Data row
		// Store lookup type for column in global variable
		gv_code_to_use = iv_decode_struct.col_lookup_type[li_selected_col]
		// Store value in column in global variable
		gv_code_id_to_use = ls_value
		// Open window
		open(w_definition)
	end if
end if
return 1
end function

on n_cst_decode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_decode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//===================================================================================================//
// Object		n_cst_decode
// Event			destructor
//===================================================================================================//
// This object controls the  code / decode window operation system wide. 
//
// Notes:
// * Has it's own transaction object so it can be run in the background. 
//	* That transaction object is only initialized if decoding.
//	* Disconnect from it and destroy it here if it's been initialized.
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//===================================================================================================//

// Disconnect from transaction
IF IsValid( atr ) THEN
	atr.of_disconnect()
	DESTROY atr
END IF
end event

