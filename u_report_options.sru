HA$PBExportHeader$u_report_options.sru
$PBExportComments$<gui>
forward
global type u_report_options from u_base
end type
type cbx_header from checkbox within u_report_options
end type
type cbx_page from checkbox within u_report_options
end type
type cbx_gridline from checkbox within u_report_options
end type
type cbx_rpt_name from checkbox within u_report_options
end type
type cbx_subset from checkbox within u_report_options
end type
type cbx_rpt_id from checkbox within u_report_options
end type
type cbx_rpt_date from checkbox within u_report_options
end type
type cbx_criteria from checkbox within u_report_options
end type
type gb_2 from groupbox within u_report_options
end type
type dw_1 from u_dw within u_report_options
end type
type gb_1 from groupbox within u_report_options
end type
type st_main_title from statictext within u_report_options
end type
type st_sub_title1 from statictext within u_report_options
end type
type st_sub_title2 from statictext within u_report_options
end type
type st_sub_title3 from statictext within u_report_options
end type
type st_sub_title4 from statictext within u_report_options
end type
type st_desc from statictext within u_report_options
end type
type st_cust_stmt from statictext within u_report_options
end type
type st_company_name from statictext within u_report_options
end type
end forward

global type u_report_options from u_base
string accessiblename = "Report Options"
string accessibledescription = "Report Options"
integer width = 3127
integer height = 1604
boolean border = false
cbx_header cbx_header
cbx_page cbx_page
cbx_gridline cbx_gridline
cbx_rpt_name cbx_rpt_name
cbx_subset cbx_subset
cbx_rpt_id cbx_rpt_id
cbx_rpt_date cbx_rpt_date
cbx_criteria cbx_criteria
gb_2 gb_2
dw_1 dw_1
gb_1 gb_1
st_main_title st_main_title
st_sub_title1 st_sub_title1
st_sub_title2 st_sub_title2
st_sub_title3 st_sub_title3
st_sub_title4 st_sub_title4
st_desc st_desc
st_cust_stmt st_cust_stmt
st_company_name st_company_name
end type
global u_report_options u_report_options

type variables
//	Reference to the requesting DW
Protected	u_dw	idw_requestor

//	Supporting NVOs
Protected	n_cst_dw_format	inv_format		// Auto instantiated
Protected	n_cst_numerical	inv_numerical	// Auto instantiated
Protected	n_cst_string		inv_string		// Auto instantiated

//	The options below are used for bitwise mappings
Protected	Constant	Integer	ici_header = 1		// This flag is used in both cases
Protected	Constant	Integer	ici_crit = 2
Protected	Constant	Integer	ici_rpt_name = 4
Protected	Constant	Integer	ici_rpt_date = 8
Protected	Constant	Integer	ici_rpt_id = 16
Protected	Constant	Integer	ici_subset = 32
Protected	Constant	Integer	ici_grid_lines = 64
Protected	Constant	Integer	ici_page_numbers = 128

//	PDR formatting bitwise options
Protected	Constant	Integer	ici_headings = 2
Protected	Constant	Integer	ici_body = 4
Protected	Constant	Integer	ici_footer = 8

//	The carriage return character combo
protected	Constant	String	BREAK = Char(13) + Char(10)

//	Used to determine if changes were made
Protected	Boolean	ib_updatespending = FALSE

//	Used for switching header options
Protected	sx_dw_format	isx_header_options
end variables

forward prototypes
public function integer of_register (ref u_dw adw_requestor)
protected function integer of_enable (boolean ab_switch, string as_field)
public function integer of_get (ref sx_dw_format asx_report_options)
public function integer of_load (sx_dw_format asx_report_options)
public subroutine of_enable (boolean ab_switch)
public subroutine of_parse_title_desc (ref sx_dw_format asx_report_options)
public function boolean of_updatespending ()
public function integer of_apply (sx_dw_format asx_format)
public subroutine of_clear ()
public function sx_dw_format of_init (integer ai_pdr_flags, boolean ab_subset)
public function integer of_set (sx_dw_format asx_report_options)
public subroutine of_resetupdates ()
end prototypes

public function integer of_register (ref u_dw adw_requestor);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

// Validate the requestor
IF NOT IsValid( adw_requestor ) OR IsNull( adw_requestor ) THEN Return -1

//	Register the DW requesting this service
idw_requestor = adw_requestor

// Register the datawindow with the format service
inv_format.event ue_register_dw( adw_requestor )

Return 1
end function

protected function integer of_enable (boolean ab_switch, string as_field);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

String	ls_modify, ls_err

IF IsNull( as_field ) OR Trim( as_field ) = "" THEN
	MessageBox( "Report Options", "Field parameter is invalid", StopSign! )
	Return -1
END IF

IF ab_switch THEN
	ls_modify = as_field + ".Protect='0' "
	ls_modify += as_field + ".Background.Color='" + &
						String(stars_colors.input_back ) + "' "
	ls_modify += as_field + ".Color='" + &
						String(stars_colors.input_text ) + "' "
ELSE
	ls_modify = as_field + ".Protect='1' "
	ls_modify += as_field + ".Background.Color='" + &
						String(stars_colors.protected_back ) + "' "
	ls_modify += as_field + ".Color='" + &
						String(stars_colors.protected_text ) + "'"
END IF

ls_err = dw_1.Modify( ls_modify )

IF Trim( ls_err ) <> "" THEN
	MessageBox( "Report Options", "Unable to modify field due to the following error:~n~r" + &
											ls_err, StopSign! )
	Return -1
END IF

Return 1
end function

public function integer of_get (ref sx_dw_format asx_report_options);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//	12/22/04	GaryR	Track 4182d	Resolve various formatting bugs
//	06/04/10	GaryR	Track 5825d	Remove obsolete logic that accounted for titles in legacy reports
//
/////////////////////////////////////////////////////////////////

String	ls_val
integer	li_row, li_options
DatawindowChild	ldwc_details

IF cbx_header.checked THEN
	dw_1.AcceptText()
	IF dw_1.GetRow() <> 1 THEN Return -1
	
	li_options += ici_header
	ls_val = dw_1.GetItemString( 1, "main_title" )
	IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN ls_val = ""
	asx_report_options.title = ls_val
	
	ls_val = dw_1.GetItemString( 1, "sub_title1" )
	IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN
		asx_report_options.subtitle1 = ""
	ELSE
		asx_report_options.subtitle1 = ls_val
	END IF
	
	ls_val = dw_1.GetItemString( 1, "sub_title2" )
	IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN
		asx_report_options.subtitle2 = ""
	ELSE
		asx_report_options.subtitle2 = ls_val
	END IF
	
	ls_val = dw_1.GetItemString( 1, "sub_title3" )
	IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN
		asx_report_options.subtitle3 = ""
	ELSE
		asx_report_options.subtitle3 = ls_val
	END IF
	
	ls_val = dw_1.GetItemString( 1, "sub_title4" )
	IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN
		asx_report_options.subtitle4 = ""
	ELSE
		asx_report_options.subtitle4 = ls_val
	END IF
	
	ls_val = dw_1.GetItemString( 1, "desc" )
	IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN ls_val = ""
	asx_report_options.description = ls_val
	
	ls_val = dw_1.GetItemString( 1, "custom_statement" )
	IF NOT IsNull( ls_val ) AND Trim( ls_val ) <> "" THEN
		asx_report_options.stmt_code = ls_val
		dw_1.GetChild( "custom_statement", ldwc_details )
		li_row = ldwc_details.Find( "code_code = '" + ls_val + "'", 1, ldwc_details.RowCount() )
		IF li_row < 1 THEN
			MessageBox( "Report Options", "Custom Statement is not found.", StopSign! )
			Return -1
		END IF
		
		//	Get the description
		ls_val = ldwc_details.GetItemString( li_row, "code_desc" )
		IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN ls_val = ""
		asx_report_options.statement = ls_val
	END IF
	
	ls_val = dw_1.GetItemString( 1, "company_name" )
	IF NOT IsNull( ls_val ) AND Trim( ls_val ) <> "" THEN
		asx_report_options.client_code = ls_val
		dw_1.GetChild( "company_name", ldwc_details )
		li_row = ldwc_details.Find( "code_code = '" + ls_val + "'", 1, ldwc_details.RowCount() )
		IF li_row < 1 THEN
			MessageBox( "Report Options", "Company Name is not found.", StopSign! )
			Return -1
		END IF
		
		//	Get the description
		ls_val = ldwc_details.GetItemString( li_row, "code_desc" )
		IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN ls_val = ""
		asx_report_options.client_name = ls_val
		
		//	Get the logo file
		ls_val = ldwc_details.GetItemString( li_row, "code_value_a" )
		IF IsNull( ls_val ) OR Trim( ls_val ) = "" THEN ls_val = ""
		asx_report_options.logo_file = ls_val
	END IF
	
	IF cbx_criteria.checked THEN
		li_options += ici_crit
		asx_report_options.display_criteria = TRUE
	END IF
	
	IF cbx_rpt_name.checked THEN
		li_options += ici_rpt_name
		asx_report_options.display_report_name = TRUE
	END IF
	
	IF cbx_rpt_date.checked THEN
		li_options += ici_rpt_date
		asx_report_options.display_report_date = TRUE
	END IF
	
	IF cbx_rpt_id.checked THEN
		li_options += ici_rpt_id
		asx_report_options.display_report_id = TRUE
	END IF
	
	IF cbx_subset.checked THEN
		li_options += ici_subset
		asx_report_options.display_subset = TRUE
		asx_report_options.display_inv_type = TRUE
	END IF
END IF

IF cbx_gridline.checked THEN
	li_options += ici_grid_lines
	asx_report_options.gridlines = TRUE
END IF

IF cbx_page.checked THEN
	li_options += ici_page_numbers
	asx_report_options.page_numbers = TRUE
END IF

asx_report_options.report_options = li_options

Return 1
end function

public function integer of_load (sx_dw_format asx_report_options);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

IF dw_1.GetRow() <> 1 THEN Return -1

IF inv_numerical.of_is_bitwise( ici_header, asx_report_options.report_options ) THEN
	cbx_header.checked = TRUE
	This.of_parse_title_desc( asx_report_options )
	dw_1.SetItem( 1, "main_title", asx_report_options.title )
	dw_1.SetItem( 1, "sub_title1", asx_report_options.subtitle1 )
	dw_1.SetItem( 1, "sub_title2", asx_report_options.subtitle2 )
	dw_1.SetItem( 1, "sub_title3", asx_report_options.subtitle3 )
	dw_1.SetItem( 1, "sub_title4", asx_report_options.subtitle4 )
	dw_1.SetItem( 1, "desc", asx_report_options.description )
	dw_1.SetItem( 1, "company_name", asx_report_options.client_code )
	dw_1.SetItem( 1, "custom_statement", asx_report_options.stmt_code )
	cbx_criteria.checked = inv_numerical.of_is_bitwise( ici_crit, asx_report_options.report_options )
	cbx_rpt_name.checked = inv_numerical.of_is_bitwise( ici_rpt_name, asx_report_options.report_options )
	cbx_rpt_date.checked = inv_numerical.of_is_bitwise( ici_rpt_date, asx_report_options.report_options )
	cbx_rpt_id.checked = inv_numerical.of_is_bitwise( ici_rpt_id, asx_report_options.report_options )
	cbx_subset.checked = inv_numerical.of_is_bitwise( ici_subset, asx_report_options.report_options )
ELSE
	cbx_header.checked = FALSE
	cbx_criteria.checked = FALSE
	cbx_rpt_name.checked = FALSE
	cbx_rpt_date.checked = FALSE
	cbx_rpt_id.checked = FALSE
	cbx_subset.checked = FALSE
	This.of_enable( FALSE )
END IF

cbx_gridline.checked = inv_numerical.of_is_bitwise( ici_grid_lines, asx_report_options.report_options )
cbx_page.checked = inv_numerical.of_is_bitwise( ici_page_numbers, asx_report_options.report_options )

Return 1
end function

public subroutine of_enable (boolean ab_switch);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

This.SetRedraw( FALSE )
dw_1.Accepttext()

IF ab_switch THEN
	IF isx_header_options.title = "1" THEN
		This.of_enable( TRUE, "main_title" )
		st_main_title.disabledlook = FALSE
	END IF
	
	IF isx_header_options.subtitle1 = "1" THEN
		This.of_enable( TRUE, "sub_title1" )
		st_sub_title1.disabledlook = FALSE
	END IF
	
	IF isx_header_options.subtitle2 = "1" THEN
		This.of_enable( TRUE, "sub_title2" )
		st_sub_title2.disabledlook = FALSE
	END IF
	
	IF isx_header_options.subtitle3 = "1" THEN
		This.of_enable( TRUE, "sub_title3" )
		st_sub_title3.disabledlook = FALSE
	END IF
	
	IF isx_header_options.subtitle4 = "1" THEN
		This.of_enable( TRUE, "sub_title4" )
		st_sub_title4.disabledlook = FALSE
	END IF
	
	IF isx_header_options.description = "1" THEN
		This.of_enable( TRUE, "desc" )
		st_desc.disabledlook = FALSE
	END IF
	
	IF isx_header_options.statement = "1" THEN
		This.of_enable( TRUE, "custom_statement" )
		st_cust_stmt.disabledlook = FALSE
	END IF
	
	IF isx_header_options.client_name = "1" THEN
		This.of_enable( TRUE, "company_name" )
		st_company_name.disabledlook = FALSE
	END IF
	
	cbx_criteria.enabled = isx_header_options.display_criteria
	cbx_rpt_name.enabled = isx_header_options.display_report_name
	cbx_rpt_date.enabled = isx_header_options.display_report_date
	cbx_rpt_id.enabled = isx_header_options.display_report_id
	cbx_subset.enabled = isx_header_options.display_subset
ELSE
	This.of_enable( FALSE, "main_title" )
	st_main_title.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "sub_title1" )
	st_sub_title1.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "sub_title2" )
	st_sub_title2.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "sub_title3" )
	st_sub_title3.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "sub_title4" )
	st_sub_title4.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "desc" )
	st_desc.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "custom_statement" )
	st_cust_stmt.disabledlook = NOT ab_switch
	This.of_enable( FALSE, "company_name" )
	st_company_name.disabledlook = NOT ab_switch		
	
	cbx_criteria.enabled = FALSE
	cbx_rpt_name.enabled = FALSE
	cbx_rpt_date.enabled = FALSE
	cbx_rpt_id.enabled = FALSE
	cbx_subset.enabled = FALSE
END IF

This.SetRedraw( TRUE )
end subroutine

public subroutine of_parse_title_desc (ref sx_dw_format asx_report_options);////////////////////////////////////////////////////////////////////////////////
//
//	This method will parse old titles and break them down into the new format
//
////////////////////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//	12/22/04	GaryR	Track 4182d	Resolve various formatting bugs
//	06/04/10	GaryR	Track 5825d	Remove obsolete logic that accounted for titles in legacy reports
//
////////////////////////////////////////////////////////////////////////////////

String	ls_title[]
Integer	i, li_ctr, li_pos

//	Check for line breaks in legacy titles
inv_string.of_parsetoarray( asx_report_options.title, BREAK, ls_title )

FOR i = 1 TO UpperBound( ls_title )
	//	Check for more than 80 bytes in legacy titles
	li_ctr ++
	IF Len( ls_title[i] ) > 80 THEN
		//	Break on last space before 80 bytes
		li_pos  = LastPos( ls_title[i], " ", 80 )
		IF li_pos < 1 THEN li_pos = 80
		CHOOSE CASE li_ctr
			CASE 1
				asx_report_options.title = Left( ls_title[i], li_pos )
				asx_report_options.subtitle1 = Mid( ls_title[i], li_pos + 1 )
				IF Trim( asx_report_options.subtitle1 ) <> "" THEN
					This.of_enable( TRUE, "sub_title1" )
					st_sub_title1.disabledlook = FALSE
					isx_header_options.subtitle1 = "1"
				END IF
			CASE 2
				asx_report_options.subtitle1 = Left( ls_title[i], li_pos )
				IF Trim( asx_report_options.subtitle1 ) <> "" THEN
					This.of_enable( TRUE, "sub_title1" )
					st_sub_title1.disabledlook = FALSE
					isx_header_options.subtitle1 = "1"
				END IF
				asx_report_options.subtitle2 = Mid( ls_title[i], li_pos + 1 )
				IF Trim( asx_report_options.subtitle2 ) <> "" THEN
					This.of_enable( TRUE, "sub_title2" )
					st_sub_title2.disabledlook = FALSE
					isx_header_options.subtitle2 = "1"
				END IF
			CASE 3
				asx_report_options.subtitle2 = Left( ls_title[i], li_pos )
				IF Trim( asx_report_options.subtitle2 ) <> "" THEN
					This.of_enable( TRUE, "sub_title2" )
					st_sub_title2.disabledlook = FALSE
					isx_header_options.subtitle2 = "1"
				END IF
				asx_report_options.subtitle3 = Mid( ls_title[i], li_pos + 1 )
				IF Trim( asx_report_options.subtitle3 ) <> "" THEN
					This.of_enable( TRUE, "sub_title3" )
					st_sub_title3.disabledlook = FALSE
					isx_header_options.subtitle3 = "1"
				END IF
			CASE 4
				asx_report_options.subtitle3 = Left( ls_title[i], li_pos )
				IF Trim( asx_report_options.subtitle3 ) <> "" THEN
					This.of_enable( TRUE, "sub_title3" )
					st_sub_title3.disabledlook = FALSE
					isx_header_options.subtitle3 = "1"
				END IF
				asx_report_options.subtitle4 = Mid( ls_title[i], li_pos + 1 )
				IF Trim( asx_report_options.subtitle4 ) <> "" THEN
					This.of_enable( TRUE, "sub_title4" )
					st_sub_title4.disabledlook = FALSE
					isx_header_options.subtitle4 = "1"
				END IF
		END CHOOSE
		li_ctr ++
	ELSE
		CHOOSE CASE li_ctr
			CASE 1
				asx_report_options.title = ls_title[i]
			CASE 2
				asx_report_options.subtitle1 = ls_title[i]
				IF Trim( ls_title[i] ) <> "" THEN
					This.of_enable( TRUE, "sub_title1" )
					st_sub_title1.disabledlook = FALSE
					isx_header_options.subtitle1 = "1"
				END IF
			CASE 3
				asx_report_options.subtitle2 = ls_title[i]
				IF Trim( ls_title[i] ) <> "" THEN
					This.of_enable( TRUE, "sub_title2" )
					st_sub_title2.disabledlook = FALSE
					isx_header_options.subtitle2 = "1"
				END IF
			CASE 4
				asx_report_options.subtitle3 = ls_title[i]
				IF Trim( ls_title[i] ) <> "" THEN
					This.of_enable( TRUE, "sub_title3" )
						st_sub_title3.disabledlook = FALSE
						isx_header_options.subtitle3 = "1"
					END IF
			CASE 5
				asx_report_options.subtitle4 = ls_title[i]
				IF Trim( ls_title[i] ) <> "" THEN
					This.of_enable( TRUE, "sub_title4" )
						st_sub_title4.disabledlook = FALSE
						isx_header_options.subtitle4 = "1"
					END IF
		END CHOOSE
	END IF
NEXT

//	Remove any carriage returns in legacy descriptions
asx_report_options.description = inv_string.of_globalreplace( asx_report_options.description, BREAK, " " )
end subroutine

public function boolean of_updatespending ();/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

dw_1.Accepttext()
Return ib_updatespending
end function

public function integer of_apply (sx_dw_format asx_format);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//	12/22/04	GaryR	Track 4182d	Resolve various formatting bugs
//
/////////////////////////////////////////////////////////////////

IF NOT IsValid( idw_requestor ) THEN Return -1
IF This.of_get( asx_format ) < 0 THEN Return -1

// Reset original report options
asx_format.report_options = isx_header_options.report_options

//	Add header
IF inv_numerical.of_is_bitwise( ici_header, isx_header_options.report_options ) THEN
	//	Dynamic
	inv_format.uf_add_header( asx_format )
ELSE
	//	Static
	inv_format.uf_set_header( asx_format )
END IF

//	Format headings
IF inv_numerical.of_is_bitwise( ici_headings, isx_header_options.report_options ) THEN
	inv_format.uf_format_col_headers()
END IF

//	Format body
IF inv_numerical.of_is_bitwise( ici_body, isx_header_options.report_options ) THEN
	inv_format.uf_format_details()
END IF

//	Add footer
IF inv_numerical.of_is_bitwise( ici_footer, isx_header_options.report_options ) THEN
	inv_format.uf_add_footer( asx_format.page_numbers )
END IF

//	Toggle grid lines
inv_format.uf_toggle_gridlines(asx_format.gridlines )

Return 1
end function

public subroutine of_clear ();/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

This.of_init( isx_header_options.report_options , isx_header_options.display_subset )
ib_updatespending = TRUE
end subroutine

public function sx_dw_format of_init (integer ai_pdr_flags, boolean ab_subset);/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//
/////////////////////////////////////////////////////////////////

Boolean			lb_switch, lb_header
sx_dw_format	lsx_dw_format
DataWindowChild	ldwc_init

IF NOT IsValid( idw_requestor ) THEN
	MessageBox( "Invalid Datawindow", "The datawindow requesting this service is invalid", StopSign! )
	Return lsx_dw_format
END IF

This.SetRedraw( FALSE )

// Reset the internal variables
isx_header_options = lsx_dw_format
ib_updatespending = FALSE

isx_header_options.report_options = ai_pdr_flags
isx_header_options.display_subset = ab_subset

//	Read the datawindow controls
lsx_dw_format = inv_format.uf_get_structure()

dw_1.Reset()
dw_1.InsertRow( 0 )

// Initialize dropdowns
dw_1.GetChild( "company_name", ldwc_init )
ldwc_init.SetTransObject( Stars2ca )
ldwc_init.Retrieve( "ACN" )
ldwc_init.InsertRow( 1 )
ldwc_init.SetItem( 1, 2, " " )

dw_1.GetChild( "custom_statement", ldwc_init )
ldwc_init.SetTransObject( Stars2ca )
ldwc_init.Retrieve( "STMT" )
ldwc_init.InsertRow( 1 )
ldwc_init.SetItem( 1, 2, " " )

//	Initialize the header
IF inv_numerical.of_is_bitwise( ici_header, ai_pdr_flags ) THEN
	//	Enable all header options
	This.of_enable( TRUE, "main_title" )
	st_main_title.disabledlook = FALSE
	isx_header_options.title = "1"
	This.of_enable( TRUE, "sub_title1" )
	st_sub_title1.disabledlook = FALSE
	isx_header_options.subtitle1 = "1"
	This.of_enable( TRUE, "sub_title2" )
	st_sub_title2.disabledlook = FALSE
	isx_header_options.subtitle2 = "1"
	This.of_enable( TRUE, "sub_title3" )
	st_sub_title3.disabledlook = FALSE
	isx_header_options.subtitle3 = "1"
	This.of_enable( TRUE, "sub_title4" )
	st_sub_title4.disabledlook = FALSE
	isx_header_options.subtitle4 = "1"
	This.of_enable( TRUE, "desc" )
	st_desc.disabledlook = FALSE
	isx_header_options.description = "1"
	This.of_enable( TRUE, "custom_statement" )
	st_cust_stmt.disabledlook = FALSE
	isx_header_options.statement = "1"
	This.of_enable( TRUE, "company_name" )
	st_company_name.disabledlook = FALSE
	isx_header_options.client_name = "1"

	//	Initialize checkboxes
	cbx_header.enabled = TRUE
	cbx_header.checked = TRUE
	cbx_criteria.enabled = TRUE
	cbx_criteria.checked = TRUE
	isx_header_options.display_criteria = TRUE
	cbx_rpt_name.enabled = TRUE
	cbx_rpt_name.checked = TRUE
	isx_header_options.display_report_name = TRUE
	cbx_rpt_date.enabled = TRUE
	cbx_rpt_date.checked = TRUE
	isx_header_options.display_report_date = TRUE
	cbx_rpt_id.enabled = TRUE
	cbx_rpt_id.checked = TRUE
	isx_header_options.display_report_id = TRUE
	cbx_subset.enabled = ab_subset
	cbx_subset.checked = ab_subset
	isx_header_options.display_subset = ab_subset
ELSE
	lb_switch = inv_format.uf_get_object_exists( "st_title" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.title = "1"
	END IF
	This.of_enable( lb_switch, "main_title" )
	st_main_title.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_sub1" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.subtitle1 = "1"
	END IF
	This.of_enable( lb_switch, "sub_title1" )
	st_sub_title1.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_sub2" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.subtitle2 = "1"
	END IF
	This.of_enable( lb_switch, "sub_title2" )
	st_sub_title2.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_sub3" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.subtitle3 = "1"
	END IF
	This.of_enable( lb_switch, "sub_title3" )
	st_sub_title3.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_sub4" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.subtitle4 = "1"
	END IF
	This.of_enable( lb_switch, "sub_title4" )
	st_sub_title4.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_description" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.description = "1"
	END IF
	This.of_enable( lb_switch, "desc" )
	st_desc.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_customstatement" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.statement = "1"
	END IF
	This.of_enable( lb_switch, "custom_statement" )
	st_cust_stmt.disabledlook = NOT lb_switch
	lb_switch = inv_format.uf_get_object_exists( "st_clientname" )
	IF lb_switch THEN
		lb_header = TRUE
		isx_header_options.client_name = "1"
	END IF
	This.of_enable( lb_switch, "company_name" )
	st_company_name.disabledlook = NOT lb_switch

	IF lsx_dw_format.display_criteria THEN lb_header = TRUE
	cbx_criteria.enabled = lsx_dw_format.display_criteria
	cbx_criteria.checked = lsx_dw_format.display_criteria
	isx_header_options.display_criteria = lsx_dw_format.display_criteria
	IF lsx_dw_format.display_report_name THEN lb_header = TRUE
	cbx_rpt_name.enabled = lsx_dw_format.display_report_name
	cbx_rpt_name.checked = lsx_dw_format.display_report_name
	isx_header_options.display_report_name = lsx_dw_format.display_report_name
	IF lsx_dw_format.display_report_date THEN lb_header = TRUE
	cbx_rpt_date.enabled = lsx_dw_format.display_report_date
	cbx_rpt_date.checked = lsx_dw_format.display_report_date
	isx_header_options.display_report_date = lsx_dw_format.display_report_date
	IF lsx_dw_format.display_report_id THEN lb_header = TRUE
	cbx_rpt_id.enabled = lsx_dw_format.display_report_id
	cbx_rpt_id.checked = lsx_dw_format.display_report_id
	isx_header_options.display_report_id = lsx_dw_format.display_report_id
	
	lb_switch = ab_subset AND lsx_dw_format.display_subset
	IF lb_switch THEN lb_header = TRUE
	cbx_subset.enabled = lb_switch
	cbx_subset.checked = lb_switch
	isx_header_options.display_subset = lb_switch

	cbx_header.enabled = lb_header
	cbx_header.checked = lb_header
END IF

//	Initialize the footer
IF inv_numerical.of_is_bitwise( ici_footer, ai_pdr_flags ) THEN
	cbx_page.enabled = TRUE
	cbx_page.checked = TRUE
	isx_header_options.page_numbers = TRUE
ELSE
	cbx_page.enabled = FALSE
	cbx_page.checked = lsx_dw_format.page_numbers
	isx_header_options.page_numbers = FALSE
END IF

//	Check for grid lines
lb_switch = inv_format.uf_get_is_dw_grid()
cbx_gridline.enabled = lb_switch
cbx_gridline.checked = lb_switch
isx_header_options.gridlines = lb_switch

This.SetRedraw( TRUE )

Return lsx_dw_format
end function

public function integer of_set (sx_dw_format asx_report_options);//////////////////////////////////////////////////////////////////////////////////
//
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//	12/22/04	GaryR	Track 4182d	Resolve various formatting bugs
//
//////////////////////////////////////////////////////////////////////////////////

Integer	li_options, li_find
DatawindowChild	ldwc_code

IF Trim( asx_report_options.title ) <> "" THEN li_options = ici_header
IF Trim( asx_report_options.subtitle1 ) <> "" THEN li_options = ici_header
IF Trim( asx_report_options.subtitle2 ) <> "" THEN li_options = ici_header
IF Trim( asx_report_options.subtitle3 ) <> "" THEN li_options = ici_header
IF Trim( asx_report_options.subtitle4 ) <> "" THEN li_options = ici_header
IF Trim( asx_report_options.description ) <> "" THEN li_options = ici_header
IF Trim( asx_report_options.client_name ) <> "" THEN
	li_options = ici_header
	//	Set the client name code
	dw_1.GetChild( "company_name", ldwc_code )
	//	Replace quotes
	asx_report_options.client_name = inv_string.of_globalreplace( asx_report_options.client_name, "'", "_" )
	asx_report_options.client_name = inv_string.of_globalreplace( asx_report_options.client_name, '"', "_" )
	li_find = ldwc_code.Find( "code_desc like ('" + asx_report_options.client_name + "')", 0, ldwc_code.RowCount() )
	IF li_find > 0 THEN
		asx_report_options.client_code = ldwc_code.GetItemString( li_find, "code_code" )
	ELSE
		MessageBox( "Value Error", "Unable to find the code for Company Name." + &
											"~n~rValue will not be set in Report Options", StopSign! )
	END IF
END IF
IF Trim( asx_report_options.statement ) <> "" THEN
	li_options = ici_header
	//	Set the Custom Statement code
	dw_1.GetChild( "custom_statement", ldwc_code )
	//	Replace quotes
	asx_report_options.statement = inv_string.of_globalreplace( asx_report_options.statement, "'", "_" )
	asx_report_options.statement = inv_string.of_globalreplace( asx_report_options.statement, '"', "_" )
	li_find = ldwc_code.Find( "code_desc like ('" + asx_report_options.statement + "')", 0, ldwc_code.RowCount() )
	IF li_find > 0 THEN
		asx_report_options.stmt_code = ldwc_code.GetItemString( li_find, "code_code" )
	ELSE
		MessageBox( "Value Error", "Unable to find the code for Custom Statement." + &
											"~n~rValue will not be set in Report Options", StopSign! )
	END IF
END IF
IF asx_report_options.display_criteria THEN li_options = ici_header
IF asx_report_options.display_report_name THEN li_options = ici_header
IF asx_report_options.display_report_date THEN li_options = ici_header
IF asx_report_options.display_report_id THEN li_options = ici_header
IF asx_report_options.display_subset THEN li_options = ici_header
IF asx_report_options.display_criteria THEN	li_options += ici_crit
IF asx_report_options.display_report_name THEN	li_options += ici_rpt_name
IF asx_report_options.display_report_date THEN	li_options += ici_rpt_date
IF asx_report_options.display_report_id THEN	li_options += ici_rpt_id
IF asx_report_options.display_subset THEN	li_options += ici_subset
IF asx_report_options.gridlines THEN	li_options += ici_grid_lines
IF asx_report_options.page_numbers THEN	li_options += ici_page_numbers
	
asx_report_options.report_options = li_options

This.of_load( asx_report_options )

Return 1
end function

public subroutine of_resetupdates ();// 12/28/04	GaryR	Track 4196d	Reset update flag on save

ib_updatespending = FALSE
end subroutine

on u_report_options.create
int iCurrent
call super::create
this.cbx_header=create cbx_header
this.cbx_page=create cbx_page
this.cbx_gridline=create cbx_gridline
this.cbx_rpt_name=create cbx_rpt_name
this.cbx_subset=create cbx_subset
this.cbx_rpt_id=create cbx_rpt_id
this.cbx_rpt_date=create cbx_rpt_date
this.cbx_criteria=create cbx_criteria
this.gb_2=create gb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.st_main_title=create st_main_title
this.st_sub_title1=create st_sub_title1
this.st_sub_title2=create st_sub_title2
this.st_sub_title3=create st_sub_title3
this.st_sub_title4=create st_sub_title4
this.st_desc=create st_desc
this.st_cust_stmt=create st_cust_stmt
this.st_company_name=create st_company_name
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_header
this.Control[iCurrent+2]=this.cbx_page
this.Control[iCurrent+3]=this.cbx_gridline
this.Control[iCurrent+4]=this.cbx_rpt_name
this.Control[iCurrent+5]=this.cbx_subset
this.Control[iCurrent+6]=this.cbx_rpt_id
this.Control[iCurrent+7]=this.cbx_rpt_date
this.Control[iCurrent+8]=this.cbx_criteria
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.st_main_title
this.Control[iCurrent+13]=this.st_sub_title1
this.Control[iCurrent+14]=this.st_sub_title2
this.Control[iCurrent+15]=this.st_sub_title3
this.Control[iCurrent+16]=this.st_sub_title4
this.Control[iCurrent+17]=this.st_desc
this.Control[iCurrent+18]=this.st_cust_stmt
this.Control[iCurrent+19]=this.st_company_name
end on

on u_report_options.destroy
call super::destroy
destroy(this.cbx_header)
destroy(this.cbx_page)
destroy(this.cbx_gridline)
destroy(this.cbx_rpt_name)
destroy(this.cbx_subset)
destroy(this.cbx_rpt_id)
destroy(this.cbx_rpt_date)
destroy(this.cbx_criteria)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.st_main_title)
destroy(this.st_sub_title1)
destroy(this.st_sub_title2)
destroy(this.st_sub_title3)
destroy(this.st_sub_title4)
destroy(this.st_desc)
destroy(this.st_cust_stmt)
destroy(this.st_company_name)
end on

type cbx_header from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Report Headings"
string accessibledescription = "Display Report Headings"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 64
integer width = 736
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Report Headings"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

//	Enable/disable all header options
ib_updatespending = TRUE
Parent.of_enable( This.checked )
end event

type cbx_page from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Page Numbers in Footer"
string accessibledescription = "Display Page Numbers in Footer"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 1500
integer width = 919
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Page Numbers in Footer"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type cbx_gridline from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Grid Lines"
string accessibledescription = "Display Grid Lines"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 1428
integer width = 736
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Grid Lines"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type cbx_rpt_name from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Report Name"
string accessibledescription = "Display Report Name"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 1060
integer width = 736
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Report Name"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type cbx_subset from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Subset Information"
string accessibledescription = "Display Subset Information"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 1276
integer width = 773
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Subset Information"
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type cbx_rpt_id from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Report ID"
string accessibledescription = "Display Report ID"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 1204
integer width = 736
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Report ID"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type cbx_rpt_date from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Report Run Date"
string accessibledescription = "Display Report Run Date"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 1132
integer width = 736
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Report Run Date"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type cbx_criteria from checkbox within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Display Selection Criteria"
string accessibledescription = "Display Selection Criteria"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 50
integer y = 988
integer width = 736
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Selection Criteria"
boolean checked = true
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

event clicked;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

type gb_2 from groupbox within u_report_options
event rbuttondown pbm_rbuttondown
string tag = "NO RESIZE"
string accessiblename = "Additional Report Options"
string accessibledescription = "Additional Report Options"
accessiblerole accessiblerole = groupingrole!
integer x = 5
integer y = 1376
integer width = 3095
integer height = 216
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Additional Report Options"
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

type dw_1 from u_dw within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Report Options"
string accessibledescription = "Report Options"
integer x = 526
integer y = 152
integer width = 2560
integer height = 952
integer taborder = 10
string dataobject = "d_report_options"
boolean border = false
end type

event rbuttondown;call super::rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( 0, xpos, ypos )
end event

event itemchanged;call super::itemchanged;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

ib_updatespending = TRUE
end event

event constructor;call super::constructor;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

This.of_setupdateable( FALSE )
end event

type gb_1 from groupbox within u_report_options
event rbuttondown pbm_rbuttondown
string tag = "NO RESIZE"
string accessiblename = "Header Options"
string accessibledescription = "Header Options"
accessiblerole accessiblerole = groupingrole!
integer x = 5
integer width = 3095
integer height = 1368
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Header Options"
end type

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

Parent.event rbuttondown( flags, xpos, ypos )
end event

type st_main_title from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Main Title"
string accessibledescription = "Main Title"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 160
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Main Title:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_sub_title1 from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Sub Title1"
string accessibledescription = "Sub Title1"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 244
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sub Title1:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_sub_title2 from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Sub Title2"
string accessibledescription = "Sub Title2"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 332
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sub Title2:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_sub_title3 from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Sub Title3"
string accessibledescription = "Sub Title3"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 424
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sub Title3:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_sub_title4 from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Sub Title4"
string accessibledescription = "Sub Title4"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 512
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sub Title4:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_desc from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 596
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_cust_stmt from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Custom Statement"
string accessibledescription = "Custom Statement"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 812
integer width = 498
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Custom Statement:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_company_name from statictext within u_report_options
string tag = "NO RESIZE"
string accessiblename = "Company Name"
string accessibledescription = "Company Name"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 904
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Company Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

