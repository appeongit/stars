$PBExportHeader$u_nvo_pdr.sru
$PBExportComments$Inherited from u_nvo_query. <logic>
forward
global type u_nvo_pdr from u_nvo_query
end type
end forward

global type u_nvo_pdr from u_nvo_query
event type integer ue_tabpage_pdr_construct ( string as_pdr_mode )
event type integer ue_tabpage_pdr_load_source ( boolean ab_new )
event type integer ue_tabpage_pdr_create_report ( )
event type integer ue_tabpage_pdr_load_search ( boolean ab_new )
event type integer ue_tabpage_pdr_load ( integer ai_level_num )
event type integer ue_tabpage_pdr_secure ( ref datawindowchild adwc_pdr_ver )
event ue_tabpage_pdr_filter_source ( )
event type integer ue_tabpage_pdr_validate_source ( )
event type integer ue_tabpage_pdr_save ( integer ai_level,  string as_query_id )
event type integer ue_tabpage_pdr_build_syntax ( string as_pdr_name )
event ue_tabpage_pdr_init_report_options ( )
end type
global u_nvo_pdr u_nvo_pdr

type variables

//	Datastore to retrieve criteria
n_ds	ids_pdr_criteria

//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
// Datastore to retrieve data sources
n_ds	ids_pdr_sources
end variables

forward prototypes
public function integer of_setlabels ()
public function integer of_replace_table (ref string as_expression, sx_pdr_tables asx_pdr_tables[], boolean ab_proc, boolean ab_claims)
end prototypes

event type integer ue_tabpage_pdr_construct(string as_pdr_mode);//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	11/14/07 Katie		SPR 4770 	Add support for NPI PDRs.

Integer	li_rc, li_row, li_rows
DataWindowChild	ldwc_child
string ls_select

idw_pdr.Reset()
li_row =	idw_pdr.InsertRow( 0 )
idw_pdr.ScrollToRow( li_row )
idw_pdr.SetRow( li_row )

// Setup PDR Types
idw_pdr.GetChild( "pdr_type", ldwc_child )
ldwc_child.SetTransObject(Stars2ca)

// Setup PDR Version
idw_pdr.GetChild( "pdr_report", ldwc_child )

// Add where criteria when gv_npi_cntl < 1
if (gv_npi_cntl < 1) then
	ldwc_child.setfilter("pdr_name not like '%NPI%'")
	ldwc_child.filter( )
end if

ldwc_child.SetTransObject(Stars2ca)

// Setup PDR Category
idw_pdr.GetChild( "pdr_cat", ldwc_child )
ldwc_child.SetTransObject(Stars2ca)
li_rows = ldwc_child.retrieve()

IF li_rows < 1 THEN
	MessageBox( "ERROR", "There are no PDR Categories available." + &
					"~n~rPlease contact your System Administrator.")
	Return -1
END IF

idw_pdr.SetColumn( "pdr_cat" )
li_row = ldwc_child.Find( "code_value_n > 0", 0, li_rows)
IF li_row > 0 THEN
	idw_pdr.SetText( ldwc_child.GetItemString( li_row, "code_desc" ) )
ELSE
	li_row = 1
	idw_pdr.SetText( ldwc_child.GetItemString( li_row, "code_desc" ) )
END IF

IF as_pdr_mode = "PDCR" THEN
	li_row = ldwc_child.Find( "Upper(code_value_a) = 'CASERPT'", 0, li_rows)
	IF li_row > 0 THEN
		idw_pdr.SetText( ldwc_child.GetItemString( li_row, "code_desc" ) )
	END IF
END IF

ldwc_child.Selectrow( 0, FALSE )
ldwc_child.Selectrow( li_row, TRUE )
ldwc_child.SetRow( li_row )
ldwc_child.ScrollToRow( li_row )
idw_pdr.AcceptText()	

Return 1
end event

event type integer ue_tabpage_pdr_load_source(boolean ab_new);/////////////////////////////////////////////////////////////////////////
//
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	12/28/04	GaryR	Track 4198d	Do not reset new query flag
//	12/20/07	GaryR	SPR 5199	Add the facility to categorize and sort data sources
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////

Long					ll_pdr_source
Integer				li_row, li_rows, li_new_row, li_ancillary, li_find
String				ls_src_type, ls_sql, ls_inv_types, ls_inv_type
String				ls_type, ls_subset_id, ls_case_id, ls_rel_id
sx_pdr_parms		lsx_pdr_parms
n_cst_stars_rel	lnv_stars_rel
nvo_subset_functions	lnv_subset
sx_subset_ids		lsx_subset_ids
DatawindowChild	ldwc_data_source

//	Setup the claims invoice types
iw_parent.of_get_pdr_parm( lsx_pdr_parms )
ll_pdr_source = lsx_pdr_parms.pdr_source
IF IsNull( ll_pdr_source ) THEN
	MessageBox( "ERROR", "This report is missing the 'PDR_SOURCE' entry in the 'PDR_CNTL' table" + &
								"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
	Return -1
END IF

idw_source.reset()
ids_pdr_sources.reset()

li_rows = ids_pdr_sources.retrieve( ll_pdr_source )

IF li_rows < 1 THEN
	MessageBox( "ERROR", "This report does not have any data sources defined in 'PDR_SOURCE' table" + &
								"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
	Return -1
END IF

// If opening a saved PDR, make sure the data sources match
IF NOT ab_new THEN
	IF li_rows <> idw_pdr_sources.RowCount() THEN
		MessageBox( "ERROR", "The saved data sources do not match the data sources defined for this report" + &
									"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
		Return -1
	END IF
END IF

// Initialize the data sources
idw_source.GetChild( "inv_type", ldwc_data_source )
ldwc_data_source.SetTransObject( Stars2ca )
ldwc_data_source.Reset()
ldwc_data_source.SetFilter( "" )
ldwc_data_source.Filter()

ls_rel_id = "Substring(STARS_REL.REL_ID,1,2), "

ls_sql = "SELECT " + ls_rel_id + "DICTIONARY.ELEM_DESC, " + ls_rel_id + &
			"STARS_REL.rel_seq, STARS_REL.value_n, STARS_REL.rel_desc " + &
			"FROM DICTIONARY, STARS_REL " + &
			"WHERE ( STARS_REL.REL_ID = DICTIONARY.ELEM_TBL_TYPE ) " + &
			"AND ( DICTIONARY.ELEM_TYPE = 'TB' ) " + &
			"AND ( STARS_REL.REL_TYPE IN ( 'IT', 'AN' ) )"
			
gnv_sql.of_get_substring( ls_sql )
ldwc_data_source.SetSQLSelect( ls_sql )
ldwc_data_source.Retrieve()

// Create the source row for each type
FOR li_row = 1 TO li_rows
	// Reset variables
	li_ancillary = 0
	
	ls_src_type = ids_pdr_sources.GetItemString( li_row, "src_type" )
	IF IsNull( ls_src_type ) OR Trim( ls_src_type ) = "" THEN
		MessageBox( "ERROR", "This report is missing the 'SRC_TYPE' parameter in 'PDR_SOURCE' table for 'PDR_LINK' " + String( ll_pdr_source ) + &
									"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
		Return -1
	END IF
	
	// Make sure that the src type matches the saved src_type
	IF NOT ab_new THEN
		IF ls_src_type <> idw_pdr_sources.GetItemString( li_row, "src_type" ) THEN
			MessageBox( "ERROR", "The saved 'SRC_TYPE' does not match the 'SRC_TYPE' parameter defined for Data Source #"  + String( li_row ) + &
									"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
			Return -1
		END IF
	END IF
	
	//	Determine Base/Invoice type
	IF Len( ls_src_type ) > 2 THEN
		ls_inv_types = lnv_stars_rel.of_get_invoice_types( ls_src_type)
		IF ls_inv_types = "ERROR" THEN	Return -1
	ELSE
		ls_inv_types = ls_src_type
	END IF
	
	li_new_row = idw_source.InsertRow( 0 )
	
	IF Pos( ls_inv_types, "," ) = 0 THEN
		ls_inv_type = ls_inv_types
		IF lnv_stars_rel.of_is_ancillary_type( ls_inv_type ) THEN li_ancillary = 1
		li_find = ldwc_data_source.Find( "stars_rel_rel_type = '" + &
										ls_inv_type + "'", 0, ldwc_data_source.RowCount() )
		IF li_find < 1 THEN
			MessageBox( "ERROR", "Unable to map invoice type " + ls_inv_type + &
								"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
			Return -1
		END IF
		idw_source.SetRow( li_new_row )
		idw_source.SetColumn( "inv_type" )
		idw_source.SetText( ldwc_data_source.GetItemString( li_find, "compute_0001" ) )
		idw_source.AcceptText()
	ELSE
		IF NOT ab_new THEN
			ls_inv_type = idw_pdr_sources.GetItemString( li_row, "src_inv_type" )
			li_find = ldwc_data_source.Find( "stars_rel_rel_type = '" + ls_inv_type + &
												"'", 0, ldwc_data_source.RowCount() )
			IF li_find < 1 THEN
				MessageBox( "ERROR", "Unable to map invoice type " + ls_inv_type + &
									"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
				Return -1
			END IF
			idw_source.SetRow( li_new_row )
			idw_source.SetColumn( "inv_type" )
			idw_source.SetText( ldwc_data_source.GetItemString( li_find, "compute_0001" ) )
			idw_source.AcceptText()
		END IF
	END IF
	
	idw_source.SetItem( li_new_row, "ancillary", li_ancillary )
	idw_source.SetItem( li_new_row, "inv_types", ls_inv_types )
	idw_source.SetItem( li_new_row, "source_desc", ids_pdr_sources.GetItemString( li_row, "src_desc" ) )
	// This identifier combines src_type and seq_num to form a unique key
	idw_source.SetItem( li_new_row, "src_type", ls_src_type + &
										String( ids_pdr_sources.GetItemNumber( li_row, "seq_num" ) ) )
	idw_source.SetItem( li_new_row, "base_invoice", ls_src_type )
	idw_source.SetItem( li_new_row, "src_crit_use_dict", ids_pdr_sources.GetItemString( li_row, "src_crit_use_dict" ) )
	
	IF ab_new THEN
		IF li_ancillary = 1 THEN 
			ls_type = ids_pdr_sources.GetItemString( li_row, "src_dflt" )
			idw_source.SetItem( li_new_row, "source_type", ls_type )
		ELSE
			idw_source.SetItem( li_new_row, "source_type", "S" )
		END IF
	ELSE
		ls_type = idw_pdr_sources.GetItemString( li_row, "src_dflt" )
		idw_source.SetItem( li_new_row, "source_type", ls_type )
		
		IF ls_type = "S" THEN
			ls_subset_id = idw_pdr_sources.GetItemString( li_row, "src_subset_id" )
			ls_case_id = idw_pdr_sources.GetItemString( li_row, "src_case_id" )
			idw_source.SetItem( li_new_row, "subset_id", ls_subset_id )
			idw_source.SetItem( li_new_row, "case_id", ls_case_id )
			
			// Get the subset name
			lnv_subset = Create nvo_subset_functions
			lsx_subset_ids.Subset_ID = ls_subset_id
			lsx_subset_ids.subset_Case_ID = left(ls_case_id,10)
			lsx_subset_ids.subset_Case_Spl = mid(ls_case_id,11,2)
			lsx_subset_ids.subset_Case_Ver = mid(ls_case_id,13,2)
			lnv_subset.uf_set_structure(lsx_subset_ids)
			IF lnv_subset.uf_retrieve_subset_name() < 1 THEN
				MessageBox( "ERROR", "Unable to locate subset id '" + ls_subset_id + "' in case '" + ls_case_id + "'" + &
									"~n~rPlease contact your System Administrator regarding this report", Exclamation! )
				Destroy lnv_subset
				Return -1
			END IF
			
			lsx_subset_ids = lnv_subset.uf_get_structure()
			Destroy lnv_subset
			idw_source.SetItem( li_new_row, 'subset_desc', lsx_subset_ids.subset_desc )
			idw_source.SetItem( li_new_row, 'subset_name', lsx_subset_ids.subset_name )
		END IF
	END IF		
NEXT

//iuo_query.of_set_ib_new_flag( TRUE )
idw_source.SetRow( 1 )

// Filter dropdown invoices
This.Event ue_tabpage_pdr_filter_source()

Return 1
end event

event type integer ue_tabpage_pdr_create_report();/////////////////////////////////////////////////////////////////////////////
// Script:	ue_tabpage_pdr_create_report
//	
//	Arguments:	None
//
//	Returns:		Integer	1 - Success, -1 - Failure
//
//	Description: 	
// Create and display the PDR Report
//
/////////////////////////////////////////////////////////////////////////////
//
//	04/24/02	GaryR	Track 2552d	Predefined Report (PDR)
// 04/25/02 LahuS Track 2552d Show/hide criteria
//	12/06/02	GaryR	Track	3390d	Export to PSR and user friendly criteria
//	01/15/03	GaryR	Track 3400d	Dictionarize the headers
//	02/04/03	GaryR	Track 3429d	Allow filters in criteria for PDRs
//	04/22/03	GaryR	Track 3508d	PDR Title page clean-up
//	05/09/03	GaryR	Track 3545d	Do not export to PSR, issue is resolved by
//						pulling in the retrieval arguments into the select of PDR
//	05/14/03	GaryR	Track 3546d	Remove the time from a date column for comparison
//	05/16/03	GaryR	Track 3584d	Facilitate decode functionality
//	08/12/03	GaryR	Track 3459d	Accept PDRs with Stored Procedures as Datasource
//	08/14/03	GaryR	Track 3627d	Link client names with logos
//	09/05/03	GaryR	Track 3653d	Allow use of quotes in user input
// 09/15/03 MikeF Track 3655d Toggle AutoCommit ON for Stored Procedures
//	09/30/03	GaryR	Track 3459d & 3655d Move logic outside of the FastQuery block
//	10/27/03	GaryR	Added logic to remove ANSI join from SQL prior to parsing tables
//	12/22/03	GaryR	Track 3667d	Add option to remove header from PDRs
//	04/12/04	GaryR	Track 3978d	Remove time from exp2 if col2col criteria
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//	12/28/04	GaryR	Track 4199d	Store original SQL
//
//////////////////////////////////////////////////////////////////////////////

any					la_ret_arg[]
string				ls_exp1, ls_exp2, ls_left, ls_relop, ls_right, ls_logic, &
						ls_data_type, ls_syntax, ls_temp_db, ls_sql, ls_tables, ls_where, &
						ls_wherecriteria[], ls_whereclause, ls_case_cat, ls_msg, ls_pdr, &
						ls_date, ls_time, ls_id, ls_constraint, ls_orig1, &
						ls_orig2, ls_alias, ls_inv_type, ls_join, ls_subset
integer				li_pos, li_row, li_ctr
long					ll_rc, ll_row
boolean				lb_proc, lb_claims
n_cst_case 			lnv_case
sx_criteria			lstr_criteria[]
n_cst_sqlattrib	lnv_sqlattrib[]
sx_pdr_parms		lsx_pdr_parms
sx_pdr_tables		lsx_pdr_tables[]
n_cst_datetime		lnv_datetime
DataWindowChild	ldwc_report
sx_decode_structure	lstr_decode_struct
sx_dw_format		lsx_format
n_cst_string		lnv_string
string				ls_value[], ls_table[]

SetPointer( HourGlass! )
idw_report.SetRedraw( FALSE )

iw_parent.of_get_pdr_parm( lsx_pdr_parms )

//	Validate and obtain the the criteria
ls_wherecriteria[1] = "PDR"
IF iuo_query.Event ue_format_where_criteria( "CRITERIA", FALSE, ls_wherecriteria, lstr_criteria ) < 0 THEN	Return -1

// Check if PDR is static or claims based
lb_claims = lsx_pdr_parms.pdr_source > 0

//	Check if PDR is a
//	Stored Procedure
ls_sql = iuo_query.is_pdr_sql
IF ls_sql = "!" THEN
	lb_proc = TRUE
	GOTO SKIP_PROC
END IF

ll_rc = gnv_sql.of_parse( ls_sql, lnv_sqlattrib )
IF UpperBound( lnv_sqlattrib ) <= 0 THEN
	MessageBox( 'ERROR', "Unable to parse the SQL used in this report" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
	Return -1
END IF

//Modify where clause
ls_tables = lnv_sqlattrib[1].s_tables
ls_where = lnv_sqlattrib[1].s_where

IF IsNull( ls_tables ) OR Trim( ls_tables ) = "" THEN
	MessageBox( 'ERROR', "Unable to obtain the tables used in the SQL of this report" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
	Return -1
END IF

//Remove the ANSI JOIN logic
li_pos = Pos( ls_tables, " LEFT " )
IF li_pos > 0 THEN
	ls_join = Mid( ls_tables, li_pos )
	ls_tables = Trim( Left( ls_tables, li_pos ) )
ELSE
	li_pos = Pos( ls_tables, " RIGHT " )
	IF li_pos > 0 THEN
		ls_join = Mid( ls_tables, li_pos )
		ls_tables = Trim( Left( ls_tables, li_pos ) )
	END IF
END IF

//	Obtain the tables used 
//	in the first FROM clause
DO WHILE Trim( ls_tables ) <> ""
	li_row ++
	li_pos = Pos( ls_tables, "," )
	IF li_pos > 0 THEN
		lsx_pdr_tables[li_row].s_table = Trim( Left( ls_tables, li_pos - 1 ) )
		ls_tables = Mid( ls_tables, li_pos + 1 )
	ELSE
		lsx_pdr_tables[li_row].s_table = Trim( ls_tables )
		ls_tables = ""
	END IF
	
	ls_table[li_row] = lsx_pdr_tables[li_row].s_table
	
	// Parse the database prefix
	li_pos = Pos( lsx_pdr_tables[li_row].s_table, ".." )
	IF li_pos > 0 THEN
		lsx_pdr_tables[li_row].s_db_name = Trim( Left( lsx_pdr_tables[li_row].s_table, li_pos - 1 ) )
		lsx_pdr_tables[li_row].s_table = Trim( Mid( lsx_pdr_tables[li_row].s_table, li_pos + 2 ) )
	ELSE
		lsx_pdr_tables[li_row].s_db_name = ""
	END IF
	
	//	Parse the alias
	li_pos = Pos( lsx_pdr_tables[li_row].s_table, " " )
	IF li_pos > 0 THEN
		lsx_pdr_tables[li_row].s_alias = Trim( Mid( lsx_pdr_tables[li_row].s_table, li_pos + 1 ) )
		lsx_pdr_tables[li_row].s_table = Trim( Left( lsx_pdr_tables[li_row].s_table, li_pos - 1 ) )
	ELSE
		lsx_pdr_tables[li_row].s_alias = ""
	END IF
	
	//	Check if claim or static PDR
	IF lb_claims THEN
		ls_alias = Upper( lsx_pdr_tables[li_row].s_alias )
		//	If there is no alias, then nothing to replace
		IF ls_alias = "" THEN Continue
		//	Remove any breaks in the alias.
		// PDR alias will not have breaks and will be similar to A15001
		// A is for alias 1500 is for base/invoice type 
		//	and the last digit is the pdr_source sequence
		li_pos = Pos( ls_alias, " " )
		IF li_pos > 0 THEN ls_alias = Trim( Left( ls_alias, li_pos ) )
		// Remove double quotes if applicable
		lnv_string.of_globalreplace( ls_alias, '"', "" )
		
		// Remove the first byte (A)
		ls_alias = Mid( ls_alias, 2 )
		
		// Now look for match in idw_source
		li_pos = idw_source.Find( "src_type='" + ls_alias + "'", 1, idw_source.RowCount() )
		IF li_pos < 1 THEN Continue
		// Replace the table if found
		ls_inv_type = Left( idw_source.GetItemString( li_pos, "inv_type" ), 2 )
		IF IsNull( ls_inv_type ) OR Trim( ls_inv_type ) = "" THEN
			MessageBox( "ERROR", "Invoice type is missing in Data Source #" + String( li_pos ), Exclamation! )	
			Return -1
		END IF
			
		IF idw_source.GetItemString( li_pos, "source_type" ) = "S" THEN
			// Source type is SUBSET, get subset id
			ls_id = idw_source.GetItemString( li_pos, "subset_id" )
			IF IsNull( ls_id ) OR Trim( ls_id ) = "" THEN
				MessageBox( "ERROR", "Subset id is missing in Data Source #" + String( li_pos ), Exclamation! )	
				Return -1
			END IF
			
			//	Obtain the database
			SELECT db
			INTO :ls_temp_db
			FROM dictionary 
			WHERE elem_type = 'UT'
			AND  elem_tbl_type = 'SS'
			USING stars2ca;
			
			IF Stars2ca.of_check_status() <> 0 THEN
				MessageBox( "ERROR", "Unable to identify the database name for subsets in the Stars DICTIONARY" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
			END IF
			
			// Validate database
			IF IsNull( ls_temp_db ) OR Trim( ls_temp_db ) = "" THEN
				MessageBox( "ERROR", "Database name for subsets is invalid in the Stars DICTIONARY" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
			END IF
			ls_temp_db = gnv_sql.of_get_database_prefix( ls_temp_db )
			ls_table[li_row] = ls_temp_db + gnv_sql.of_get_subset_prefix() + &
								ls_inv_type + "_" + ls_id + " " + lsx_pdr_tables[li_row].s_alias
		ELSE
			// Source type is BASE			
			//	Obtain the name and database
			SELECT elem_name, db
			INTO :ls_table[li_row], :ls_temp_db
			FROM dictionary 
			WHERE elem_type = 'TB'
			AND  elem_tbl_type = :ls_inv_type
			USING stars2ca;
			
			IF Stars2ca.of_check_status() <> 0 THEN
				MessageBox( "ERROR", "Unable to locate table name for invoice type '" + ls_inv_type + "' in the Stars DICTIONARY" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
			END IF
			
			// Validate table name
			IF IsNull( ls_table[li_row] ) OR Trim( ls_table[li_row] ) = "" THEN
				MessageBox( "ERROR", "Table name for invoice type '" + ls_inv_type + "' is invalid in the Stars DICTIONARY" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
			END IF
			
			// Validate database
			IF IsNull( ls_temp_db ) OR Trim( ls_temp_db ) = "" THEN
				MessageBox( "ERROR", "Database name for table '" + ls_table[li_row] + "' is invalid in the Stars DICTIONARY" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
			END IF
			ls_temp_db = gnv_sql.of_get_database_prefix( ls_temp_db )
			ls_table[li_row] = ls_temp_db + ls_table[li_row] + " " + lsx_pdr_tables[li_row].s_alias
		END IF
		lsx_pdr_tables[li_row].s_table = ls_table[li_row]
		lsx_pdr_tables[li_row].s_db_name = ls_temp_db
		lsx_pdr_tables[li_row].s_elem_tbl_type = ls_inv_type
	ELSE
		//	Obtain the elem_tbl_type and database
		SELECT elem_tbl_type, db
		INTO :lsx_pdr_tables[li_row].s_elem_tbl_type, :ls_temp_db
		FROM dictionary 
		WHERE elem_type = 'TB'
		AND  elem_name = :lsx_pdr_tables[li_row].s_table
		USING stars2ca;
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "ERROR", "Unable to locate table '" + lsx_pdr_tables[li_row].s_table + "' in the Stars DICTIONARY" + &
									"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
			Return -1
		END IF
		
		IF IsNull( lsx_pdr_tables[li_row].s_elem_tbl_type ) OR Trim( lsx_pdr_tables[li_row].s_elem_tbl_type )  = "" THEN
			MessageBox( "ERROR", "Unable to identify elem_tbl_type for table'" + lsx_pdr_tables[li_row].s_table + "' in the Stars DICTIONARY" + &
									"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
			Return -1
		END IF
		
		//	Validate the databases
		IF lsx_pdr_tables[li_row].s_db_name <> "" THEN
			IF lsx_pdr_tables[li_row].s_db_name = Upper( ls_temp_db ) THEN
			ELSE
				MessageBox( "ERROR", "Database name '" + lsx_pdr_tables[li_row].s_db_name + &
									"' specified for table'" + lsx_pdr_tables[li_row].s_table + &
									"'~n~rdoes not match the database name specified in the Stars DICTIONARY" + &
									"~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
			END IF
		END IF
	END IF
LOOP

IF lb_claims THEN
	lnv_string.of_arraytostring( ls_table, ",", ls_tables )
	lnv_sqlattrib[1].s_tables = ls_tables + ls_join
END IF

SKIP_PROC:

//	Validate the where criteria
ll_rc = UpperBound( lstr_criteria )
FOR li_row = 1 TO ll_rc
	ls_left	=	lstr_criteria[li_row].left_paren
	ls_exp1	=	lstr_criteria[li_row].expression_one
	ls_relop	=	lstr_criteria[li_row].rel_operator
	ls_exp2	=	lstr_criteria[li_row].expression_two
	ls_right	=	lstr_criteria[li_row].right_paren
	ls_logic	=	lstr_criteria[li_row].logical_operator
	ls_pdr	=	lstr_criteria[li_row].pdr_protect
	ls_orig1	= lstr_criteria[li_row].expr1_orig
	ls_orig2	= lstr_criteria[li_row].expr2_orig
	ls_data_type = lstr_criteria[li_row].data_type

	//	Validate parameters
	IF IsNull( ls_left )		THEN ls_left	= ""
	IF IsNull( ls_exp1 )		THEN ls_exp1	= ""
	IF IsNull( ls_relop )	THEN ls_relop	= ""
	IF IsNull( ls_exp2 )		THEN ls_exp2	= ""
	IF IsNull( ls_logic )	THEN ls_logic	= ""
	IF IsNull( ls_right ) 	THEN ls_right	= ""
	IF IsNull( ls_orig1 ) 	THEN ls_orig1	= ""
	IF IsNull( ls_orig2 ) 	THEN ls_orig2	= ""
	IF IsNull( ls_data_type ) 	THEN ls_data_type	= ""

	//	Check if retrieval argument
	IF ls_pdr = "A" THEN
		//	This is a Retrieval Argument
		li_ctr ++
		
		//	Cast the data type of the retrieval argument		
		CHOOSE CASE ls_data_type
			CASE "NUMBER"
				la_ret_arg[li_ctr] = Dec( ls_exp2 )
			CASE "STRING"
				la_ret_arg[li_ctr] = String( ls_exp2 )
			CASE "STRINGARRAY"
				lnv_string.of_parsetoarray( ls_exp2, ",", ls_value )
				la_ret_arg[li_ctr] = ls_value
			CASE "DATE"
				la_ret_arg[li_ctr] = Date( ls_exp2 )
			CASE "DATETIME"
				li_pos = Pos( ls_exp2, " " )
				IF li_pos > 0 THEN
					ls_date = Trim( Left( ls_exp2, li_pos - 1 ) )
					ls_time = Trim( Mid( ls_exp2, li_pos + 1 ) )										
				ELSE
					ls_date = ls_exp2
					ls_time = "00:00:00"
				END IF
				
				la_ret_arg[li_ctr] = DateTime( Date( ls_date ), Time( ls_time ) )
			CASE "TIME"
				la_ret_arg[li_ctr] = Time( ls_exp2 )
			CASE ELSE
				MessageBox( "ERROR", "Invalid data type specified for column '" + ls_exp1 + "'" + &
							"~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
				Return -1
		END CHOOSE
		ls_constraint += ls_left + ls_exp1 + " " + ls_relop + " " + &
											ls_exp2 + ls_right + " " + ls_logic + " "
	ELSE
		//	Assemble user friendly where criteria
		ls_constraint += ls_left + ls_orig1 + " " + ls_relop + " " + &
											ls_orig2 + ls_right + " " + ls_logic + " "
		
		// Replace the table name in criteria column
		IF This.of_replace_table( ls_exp1, lsx_pdr_tables, lb_proc, lb_claims ) < 0 THEN Return -1
		
		// For date columns, remove the time
		IF gnv_sql.of_is_date_data_type( ls_data_type ) THEN
			IF gnv_sql.of_remove_time( ls_exp1 ) < 0 THEN Return -1
		END IF
		
		//	Replace the table name in column comparison
		IF lstr_criteria[li_row].exp2_column THEN
			IF This.of_replace_table( ls_exp2, lsx_pdr_tables, lb_proc, lb_claims ) < 0 THEN Return -1
			
			// For date columns, remove the time
			IF gnv_sql.of_is_date_data_type( ls_data_type ) THEN
				IF gnv_sql.of_remove_time( ls_exp2 ) < 0 THEN Return -1
			END IF
		END IF
		
		//	Assemble SQL where criteria
		ls_whereclause += ls_left + ls_exp1 + " " + ls_relop + " " + &
											ls_exp2 + ls_right + " " + ls_logic + " "
	END IF
NEXT

//	Build the final where clause
IF Trim( ls_where ) <> "" AND Trim( ls_whereclause ) <> "" THEN ls_where += " AND "
ls_where += ls_whereclause

IF NOT lb_proc THEN
	//	Build the SQL
	lnv_sqlattrib[1].s_where = ls_where
	ls_sql = gnv_sql.of_assemble( lnv_sqlattrib )
	idw_report.SetTransObject( Stars2ca )
	idw_report.Object.DataWindow.Table.Select = ls_sql
END IF

IF fx_dw_syntax( Upper( iw_parent.classname() ), idw_report, lstr_decode_struct, stars2ca ) <> 0 THEN Return -1

//	Save this structure for code/decode
iuo_query.of_set_decode_struct( lstr_decode_struct )

//	Add report options
lsx_format.criteria = ls_constraint
lsx_format.report_date = String( gnv_sql.of_get_current_datetime(), "mm/dd/yyyy" )
lsx_format.report_id = fx_get_next_key_id( "PDQ_TMP_ID" )
lsx_format.report_name = lsx_pdr_parms.rpt_name

IF lb_claims THEN
	IF idw_source.RowCount() = 1 THEN
		//	Check if subset or base
		IF idw_source.GetItemString( 1, "source_type" ) = "S" THEN
			ls_subset = idw_source.GetItemString( 1, "subset_name" )
			ls_subset += " - " + idw_source.GetItemString( 1, "subset_desc" )
			lsx_format.subset = ls_subset
		END IF
		
		lsx_format.inv_type = idw_source.GetItemString( 1, "inv_type" )
	END IF
END IF

iuo_report_options.of_apply( lsx_format )

//	Reset the labels 
//	from the dictionary
This.of_SetLabels()

IF NOT lb_proc THEN
	ls_syntax	=	idw_report.object.datawindow.syntax
	idw_break.Create( ls_syntax )
	idw_break.SetTransObject( Stars2ca )
	
	//	Reset the new sql
	idw_break.Object.DataWindow.Table.Select = ls_sql
	
	//	Retrieve upto 5 
	//	Retrieval Arguments
	CHOOSE CASE li_ctr
		CASE 0
			ll_rc	=	idw_break.Retrieve()
		CASE 1
			ll_rc	=	idw_break.Retrieve( la_ret_arg[1] )
		CASE 2
			ll_rc	=	idw_break.Retrieve( la_ret_arg[1], la_ret_arg[2] )
		CASE 3
			ll_rc	=	idw_break.Retrieve( la_ret_arg[1], la_ret_arg[2], la_ret_arg[3] )
		CASE 4
			ll_rc	=	idw_break.Retrieve( la_ret_arg[1], la_ret_arg[2], la_ret_arg[3], la_ret_arg[4] )
		CASE 5
			ll_rc	=	idw_break.Retrieve( la_ret_arg[1], la_ret_arg[2], la_ret_arg[3], la_ret_arg[4], la_ret_arg[5] )
		CASE ELSE
			MessageBox( "ERROR", String( li_ctr ) + " Retrieval Arguments were defined for this report" + &
										"~n~rThe maximum number of Retrieval Arguments allowed is 5" + &
										"~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
			Return -1
	END CHOOSE
	
	IF ll_rc < 0 THEN Return -1
	
	IF	idw_break.RowCount()	>	0	THEN
		idw_report.object.data	=	idw_break.object.data
	ELSE
		idw_report.Reset()
	END IF
	idw_break.Reset()
ELSE	//	Stored Procedure
	stars2ca.of_set_autocommit(TRUE)
	IF Trim( ls_where ) <> "" THEN ls_where = "and (" + ls_where + ")"
	
	// Check if claims PDR
	IF lb_claims THEN
		// Claims PDR, get all tables to pass to the Stored Procedure
		FOR li_row = 1 TO idw_source.RowCount()
			ls_inv_type = Left( idw_source.GetItemString( li_row, "inv_type" ), 2 )
			IF IsNull( ls_inv_type ) OR Trim( ls_inv_type ) = "" THEN
				MessageBox( "ERROR", "Invoice type is missing in Data Source #" + String( li_row ), Exclamation! )	
				stars2ca.of_set_autocommit(FALSE)
				Return -1
			END IF
				
			IF idw_source.GetItemString( li_row, "source_type" ) = "S" THEN
				// Source type is SUBSET, get subset id
				ls_id = idw_source.GetItemString( li_row, "subset_id" )
				IF IsNull( ls_id ) OR Trim( ls_id ) = "" THEN
					MessageBox( "ERROR", "Subset id is missing in Data Source #" + String( li_row ), Exclamation! )	
					stars2ca.of_set_autocommit(FALSE)
					Return -1
				END IF
				
				//	Obtain the database
				SELECT db
				INTO :ls_temp_db
				FROM dictionary 
				WHERE elem_type = 'UT'
				AND  elem_tbl_type = 'SS'
				USING stars2ca;
				
				IF Stars2ca.of_check_status() <> 0 THEN
					MessageBox( "ERROR", "Unable to identify the database name for subsets in the Stars DICTIONARY" + &
											"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
					stars2ca.of_set_autocommit(FALSE)
					Return -1
				END IF
				
				// Validate database
				IF IsNull( ls_temp_db ) OR Trim( ls_temp_db ) = "" THEN
					MessageBox( "ERROR", "Database name for subsets is invalid in the Stars DICTIONARY" + &
											"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
					stars2ca.of_set_autocommit(FALSE)
					Return -1
				END IF
				ls_temp_db = gnv_sql.of_get_database_prefix( ls_temp_db )
				ls_table[li_row] = ls_temp_db + gnv_sql.of_get_subset_prefix() + ls_inv_type + "_" + ls_id
			ELSE
				// Source type is BASE			
				//	Obtain the name and database
				SELECT elem_name, db
				INTO :ls_table[li_row], :ls_temp_db
				FROM dictionary 
				WHERE elem_type = 'TB'
				AND  elem_tbl_type = :ls_inv_type
				USING stars2ca;
				
				IF Stars2ca.of_check_status() <> 0 THEN
					MessageBox( "ERROR", "Unable to locate table name for invoice type '" + ls_inv_type + "' in the Stars DICTIONARY" + &
											"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
					stars2ca.of_set_autocommit(FALSE)
					Return -1
				END IF
				
				// Validate table name
				IF IsNull( ls_table[li_row] ) OR Trim( ls_table[li_row] ) = "" THEN
					MessageBox( "ERROR", "Table name for invoice type '" + ls_inv_type + "' is invalid in the Stars DICTIONARY" + &
											"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
					stars2ca.of_set_autocommit(FALSE)
					Return -1
				END IF
				
				// Validate database
				IF IsNull( ls_temp_db ) OR Trim( ls_temp_db ) = "" THEN
					MessageBox( "ERROR", "Database name for table '" + ls_table[li_row] + "' is invalid in the Stars DICTIONARY" + &
											"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
					stars2ca.of_set_autocommit(FALSE)
					Return -1
				END IF
				ls_temp_db = gnv_sql.of_get_database_prefix( ls_temp_db )
				ls_table[li_row] = ls_temp_db + ls_table[li_row]
			END IF
		NEXT
		
		// Create a comma delimited string of all data sources
		lnv_string.of_arraytostring( ls_table, ",", ls_tables )
		
		ls_syntax	=	idw_report.object.datawindow.syntax
		idw_break.Create( ls_syntax )
		idw_break.SetTransObject( Stars2ca )
		
		//	Retrieve upto 5 
		//	Retrieval Arguments
		CHOOSE CASE li_ctr
			CASE 0
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, ls_tables )
			CASE 1
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, ls_tables, la_ret_arg[1] )
			CASE 2
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, ls_tables, la_ret_arg[1], la_ret_arg[2] )
			CASE 3
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, ls_tables, la_ret_arg[1], la_ret_arg[2], la_ret_arg[3] )
			CASE 4
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, ls_tables, la_ret_arg[1], la_ret_arg[2], la_ret_arg[3], la_ret_arg[4] )
			CASE 5
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, ls_tables, la_ret_arg[1], la_ret_arg[2], la_ret_arg[3], la_ret_arg[4], la_ret_arg[5] )
			CASE ELSE
				MessageBox( "ERROR", String( li_ctr ) + " Retrieval Arguments were defined for this report" + &
											"~n~rThe maximum number of Retrieval Arguments allowed is 5" + &
											"~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
				stars2ca.of_set_autocommit(FALSE)
				Return -1
		END CHOOSE
		
		stars2ca.of_set_autocommit(FALSE)
		IF ll_rc < 0 THEN Return -1
		
		IF	idw_break.RowCount()	>	0	THEN
			idw_report.object.data	=	idw_break.object.data
		ELSE
			idw_report.Reset()
		END IF
		idw_break.Reset()
	ELSE	// Non claims
		ls_syntax	=	idw_report.object.datawindow.syntax
		idw_break.Create( ls_syntax )
		idw_break.SetTransObject( Stars2ca )
		
		//	Retrieve upto 5 
		//	Retrieval Arguments
		CHOOSE CASE li_ctr
			CASE 0
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where )
			CASE 1
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, la_ret_arg[1] )
			CASE 2
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, la_ret_arg[1], la_ret_arg[2] )
			CASE 3
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, la_ret_arg[1], la_ret_arg[2], la_ret_arg[3] )
			CASE 4
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, la_ret_arg[1], la_ret_arg[2], la_ret_arg[3], la_ret_arg[4] )
			CASE 5
				ll_rc	=	idw_break.Retrieve( gc_user_id, ls_where, la_ret_arg[1], la_ret_arg[2], la_ret_arg[3], la_ret_arg[4], la_ret_arg[5] )
			CASE ELSE
				MessageBox( "ERROR", String( li_ctr ) + " Retrieval Arguments were defined for this report" + &
											"~n~rThe maximum number of Retrieval Arguments allowed is 5" + &
											"~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
				stars2ca.of_set_autocommit(FALSE)
				Return -1
		END CHOOSE
		
		stars2ca.of_set_autocommit(FALSE)
		IF ll_rc < 0 THEN Return -1
		
		IF	idw_break.RowCount()	>	0	THEN
			idw_report.object.data	=	idw_break.object.data
		ELSE
			idw_report.Reset()
		END IF
		idw_break.Reset()

		stars2ca.of_set_autocommit(FALSE)
		IF ll_rc < 0 THEN Return -1
	END IF
END IF

Stars2ca.of_commit()

IF ll_rc = 0 THEN
	MessageBox( "INFORMATION", "Your query has not returned any rows" )
	iuo_query.Event ue_selecttab( IC_SEARCH )
	Return -1
END IF

//Case security check
IF lsx_pdr_parms.case_security = "Y" THEN
	SetPointer( HourGlass! )
	IF idw_report.Describe( "case_cat.visible" ) = "!" THEN
		idw_report.Reset()
		MessageBox( "ERROR", "Unable to apply Case Security because column 'CASE_CAT' is not defined in the report" + &
									"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
		Return -1
	END IF
	
	w_main.SetMicroHelp( "Applying Case Security.    Please wait..." )
	
	lnv_case = CREATE n_cst_case
	idw_report.SetRedraw( FALSE )
	
	FOR ll_row = 1 TO ll_rc
		ls_case_cat = idw_report.object.case_cat[ll_row]
		ls_msg = lnv_case.uf_edit_case_security( ls_case_cat )
		IF len( ls_msg ) > 0 THEN
			idw_report.RowsDiscard( ll_row, ll_row, Primary! )
			ll_row --
			ll_rc --
		END IF
	NEXT
	
	idw_report.GroupCalc()
	idw_report.SetRedraw( TRUE )
	Destroy lnv_case
END IF

idw_report.SetRedraw( TRUE )
iuo_query.Event	ue_set_count_view()

w_main.SetMicroHelp( "Ready" )

Return 1
end event

event type integer ue_tabpage_pdr_load_search(boolean ab_new);///////////////////////////////////////////////////////////////////
//
// Description: Load the search criteria for the PDR
//
///////////////////////////////////////////////////////////////////
//
//	04/24/02	GaryR	Track 2552d	Predefined Report (PDR)
//	09/12/02	GaryR	Track 3070d	Preserve case of description
//	02/03/03	GaryR	Track 3400d	Do not retrieve fields turned off
//	05/07/03	GaryR	Track 3549d	Prevent the extra blank row
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	11/19/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//	08/19/08	Katie	SPR 5509	Changed SQL to use col number in ORDER BY
//						because using column name not supported by Oracle.
//
///////////////////////////////////////////////////////////////////

Long					ll_row, ll_rowcount, ll_dddw_count
String				ls_sql, ls_pdr_link, ls_table, ls_col_name
String				ls_inv_type[], ls_src_type[]
Integer				li_newrow, li_found
DataWindowChild	ldwc_exp_one
sx_pdr_parms		lsx_pdr_parms

SetPointer( HourGlass! )

iw_parent.of_get_pdr_parm( lsx_pdr_parms )
ls_pdr_link = String( lsx_pdr_parms.pdr_criteria )

IF lsx_pdr_parms.pdr_source > 0 THEN
	//	Check if invoice type has changed
	IF iuo_query.ib_pdr_inv_changed THEN
		// invoice type changed - reset criteria
		IF ab_new THEN idw_criteria.Reset()
		iuo_query.ib_pdr_inv_changed = FALSE
	ELSE
		// Invoice type did not change - do nothing
		Return 1
	END IF
	
	// Set the SQL
	FOR li_newrow = 1 TO idw_source.RowCount()
		ls_inv_type[li_newrow] = Left( idw_source.GetItemString( li_newrow, "inv_type" ), 2 )
		IF IsNull( ls_inv_type[li_newrow] ) OR Trim( ls_inv_type[li_newrow] ) = "" THEN
			MessageBox( "ERROR", "Data Source #" + String( li_newrow ) + &
								" does not have a valid Invoice Type selected", StopSign! )

			Return -1
		END IF
		
		// Get the source type
		ls_src_type[li_newrow] = idw_source.GetItemString( li_newrow, "src_type" )
		
		IF li_newrow > 1 THEN ls_sql += " UNION "
		//	Check if flag is set to use dictionary criteria vs. pdr_criteria
		IF Upper( idw_source.GetItemString( li_newrow, "src_crit_use_dict" ) ) = "Y" THEN
			ls_sql += "SELECT DISTINCT DICTIONARY.ELEM_DESC," + &
						" DICTIONARY.ELEM_DATA_TYPE," + &
						" DICTIONARY.ELEM_DATA_LEN," + &
						" DICTIONARY.ELEM_COL_NUMBER," + &
						" DICTIONARY.CRIT_SEQ," + &
						" DICTIONARY.ELEM_NAME," + &
						" DICTIONARY.ELEM_LOOKUP_TYPE," + &
						" DICTIONARY.ELEM_TBL_TYPE," + &
						" DICTIONARY.ELEM_INDX_IND," + &
						" DICTIONARY.ELEM_TYPE" + &
						" FROM DICTIONARY" + &  
						" WHERE ( DICTIONARY.ELEM_TYPE IN ('CL','CC') )" + &
						" AND DICTIONARY.ELEM_TBL_TYPE = '" + ls_inv_type[li_newrow] + "'" + &
						" AND ( DICTIONARY.CRIT_SEQ > 0 )"
		ELSE
			IF IsNull( ls_pdr_link ) OR Trim( ls_pdr_link ) = "" OR ls_pdr_link = "0" THEN Continue
			ls_sql += "SELECT DISTINCT DICTIONARY.ELEM_DESC," + &
						" DICTIONARY.ELEM_DATA_TYPE," + &
						" DICTIONARY.ELEM_DATA_LEN," + &
						" DICTIONARY.ELEM_COL_NUMBER," + &
						" PDR_CRITERIA.SEQ_NUM," + &
						" DICTIONARY.ELEM_NAME," + &
						" DICTIONARY.ELEM_LOOKUP_TYPE," + &
						" DICTIONARY.ELEM_TBL_TYPE," + &
						" DICTIONARY.ELEM_INDX_IND," + &
						" DICTIONARY.ELEM_TYPE" + &
						" FROM DICTIONARY, PDR_CRITERIA" + &  
						" WHERE ( DICTIONARY.ELEM_TYPE IN ('CL','CC') ) AND" + &
						" ( PDR_CRITERIA.PDR_LINK = " + ls_pdr_link + " ) AND" + &
						" ( DICTIONARY.ELEM_TBL_TYPE = '" + ls_inv_type[li_newrow] + "' )" + &
						" AND ( PDR_CRITERIA.TBL_NAME = '" + ls_src_type[li_newrow] + "' )" + &
						" AND ( DICTIONARY.ELEM_NAME = PDR_CRITERIA.COL_NAME )" + &
						" AND ( DICTIONARY.CRIT_SEQ > 0 )"
		END IF
	NEXT
	ls_sql += " ORDER BY DICTIONARY.ELEM_TBL_TYPE ASC, DICTIONARY.ELEM_DESC ASC, DICTIONARY.CRIT_SEQ ASC"
ELSE
	//	Disable the search criteria tab (Return 0) if any of the conditions are met
	IF Isnull( ls_pdr_link ) OR Trim( ls_pdr_link ) = "" OR ls_pdr_link = "0" THEN Return 0
	
	// Set the SQL
	ls_sql = "SELECT DISTINCT DICTIONARY.ELEM_DESC," + &
				" DICTIONARY.ELEM_DATA_TYPE," + &
				" DICTIONARY.ELEM_DATA_LEN," + &
				" DICTIONARY.ELEM_COL_NUMBER," + &
				" PDR_CRITERIA.SEQ_NUM," + &
				" DICTIONARY.ELEM_NAME," + &
				" DICTIONARY.ELEM_LOOKUP_TYPE," + &
				" DICTIONARY.ELEM_TBL_TYPE," + &
				" DICTIONARY.ELEM_INDX_IND," + &
				" DICTIONARY.ELEM_TYPE" + &
				" FROM DICTIONARY, PDR_CRITERIA" + &  
				" WHERE ( DICTIONARY.ELEM_TYPE IN ('CL','CC') ) AND" + &
				" ( PDR_CRITERIA.PDR_LINK = " + ls_pdr_link + " ) AND" + &
				" ( DICTIONARY.ELEM_TBL_TYPE = ( SELECT DICTIONARY.ELEM_TBL_TYPE" + &
															" FROM DICTIONARY" + &
															" WHERE DICTIONARY.ELEM_TYPE = 'TB'" + &
															" AND DICTIONARY.ELEM_NAME = PDR_CRITERIA.TBL_NAME" + &
															" AND PDR_CRITERIA.PDR_LINK = " + ls_pdr_link + " ) )" + &
				" AND ( DICTIONARY.ELEM_NAME = PDR_CRITERIA.COL_NAME )" + &
				" AND ( DICTIONARY.CRIT_SEQ > 0 )" + &
				" ORDER BY 5 ASC" //PDR_CRITERIA.SEQ_NUM
END IF

idw_criteria.getchild( "expression_one", ldwc_exp_one )
ldwc_exp_one.SetTransObject( stars2ca )
ldwc_exp_one.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' )

//	Retrieve the data
ll_rowcount = ldwc_exp_one.retrieve( '', '', '' )
IF ll_rowcount < 0 THEN	Return -1
Stars2ca.of_commit()

idw_criteria.TriggerEvent( "ue_load_exp2_dddw" )
ll_dddw_count = ll_rowcount
ll_row = 0

//	Now set the default values
ids_pdr_criteria.Reset()
ls_sql = "SELECT DISTINCT PDR_CRITERIA.PDR_LINK, " + &
					"' ', " + &
					"PDR_CRITERIA.COL_NAME, " + &
					"' ', " + &
					"PDR_CRITERIA.SEQ_NUM, " + &
					"PDR_CRITERIA.TBL_NAME, " + &
					"PDR_CRITERIA.LEFT_PAREN, " + &
					"PDR_CRITERIA.COL_NAME, " + &
					"PDR_CRITERIA.REL_OP, " + &
					"PDR_CRITERIA.DFLT_VALUE, " + & 
					"PDR_CRITERIA.RIGHT_PAREN, " + &
					"PDR_CRITERIA.LOGIC_OP, " + &
					"PDR_CRITERIA.REQ_IND, " + &
					"PDR_CRITERIA.RA_DATA_TYPE " + &
			 "FROM PDR_CRITERIA " + &
			"WHERE PDR_CRITERIA.PDR_LINK = :an_pdr_link " + &
			  "AND PDR_CRITERIA.TBL_NAME = 'ARGUMENT' "
IF lsx_pdr_parms.pdr_source > 0 THEN
	FOR li_newrow = 1 TO UpperBound( ls_inv_type )
		ls_sql += "UNION SELECT DISTINCT PDR_CRITERIA.PDR_LINK, " + &
							"DICTIONARY.ELEM_TBL_TYPE, " + &
							"DICTIONARY.ELEM_NAME, " + &
							"DICTIONARY.ELEM_LOOKUP_TYPE, " + &
							"PDR_CRITERIA.SEQ_NUM, " + &
							"PDR_CRITERIA.TBL_NAME, " + &
							"PDR_CRITERIA.LEFT_PAREN, " + &
							"PDR_CRITERIA.COL_NAME, " + &
							"PDR_CRITERIA.REL_OP, " + &
							"PDR_CRITERIA.DFLT_VALUE, " + & 
							"PDR_CRITERIA.RIGHT_PAREN, " + &
							"PDR_CRITERIA.LOGIC_OP, " + &
							"PDR_CRITERIA.REQ_IND, " + &
							"PDR_CRITERIA.RA_DATA_TYPE " + &
					 "FROM PDR_CRITERIA, DICTIONARY " + &
					"WHERE PDR_CRITERIA.PDR_LINK = :an_pdr_link " + &
					  "AND ( PDR_CRITERIA.REQ_IND = 'Y' ) " + &
					  "AND ( DICTIONARY.ELEM_TYPE IN ('CL','CC') ) " + &
					  "AND ( DICTIONARY.ELEM_NAME = PDR_CRITERIA.COL_NAME ) " + &
					  "AND ( PDR_CRITERIA.TBL_NAME = '" + ls_src_type[li_newrow] + "' ) " + &
					  "AND ( DICTIONARY.ELEM_TBL_TYPE = '" + ls_inv_type[li_newrow] + "' ) "
	NEXT
ELSE
	ls_sql += "UNION SELECT DISTINCT PDR_CRITERIA.PDR_LINK, " + &
						"DICTIONARY.ELEM_TBL_TYPE, " + &
						"DICTIONARY.ELEM_NAME, " + &
						"DICTIONARY.ELEM_LOOKUP_TYPE, " + &
						"PDR_CRITERIA.SEQ_NUM, " + &
						"PDR_CRITERIA.TBL_NAME, " + &
						"PDR_CRITERIA.LEFT_PAREN, " + &
						"PDR_CRITERIA.COL_NAME, " + &
						"PDR_CRITERIA.REL_OP, " + &
						"PDR_CRITERIA.DFLT_VALUE, " + & 
						"PDR_CRITERIA.RIGHT_PAREN, " + &
						"PDR_CRITERIA.LOGIC_OP, " + &
						"PDR_CRITERIA.REQ_IND, " + &
						"PDR_CRITERIA.RA_DATA_TYPE " + &
				 "FROM PDR_CRITERIA, DICTIONARY " + &
				"WHERE PDR_CRITERIA.PDR_LINK = :an_pdr_link " + &
				  "AND ( PDR_CRITERIA.REQ_IND = 'Y' ) " + &
				  "AND ( DICTIONARY.ELEM_TYPE IN ('CL','CC') ) " + &
				  "AND ( DICTIONARY.ELEM_NAME = PDR_CRITERIA.COL_NAME ) " + &
				  "AND ( DICTIONARY.ELEM_TBL_TYPE in ( SELECT DICTIONARY.ELEM_TBL_TYPE " + &
																	"FROM DICTIONARY, PDR_CRITERIA " + &
																	"WHERE DICTIONARY.ELEM_TYPE = 'TB' " + &
																	"AND DICTIONARY.ELEM_NAME = PDR_CRITERIA.TBL_NAME " + &
																	"AND PDR_CRITERIA.PDR_LINK = :an_pdr_link ) ) "
END IF

IF lsx_pdr_parms.pdr_criteria = 0 THEN
	ll_rowcount = 0
ELSE
	ls_sql += " ORDER BY 5 ASC" //PDR_CRITERIA.SEQ_NUM
	ids_pdr_criteria.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' )
	ll_rowcount = ids_pdr_criteria.Retrieve( lsx_pdr_parms.pdr_criteria )
END IF

IF ll_rowcount < 0 THEN	Return -1
Stars2ca.of_commit()

FOR ll_row = 1 to ll_rowcount
	IF ab_new THEN
		//	Insert new row and populate data
		li_newrow = idw_criteria.InsertRow( 0 )
		idw_criteria.SetItem( li_newrow, "expression_one", ids_pdr_criteria.GetItemString( ll_row, "col_name" ) )
		idw_criteria.SetItem( li_newrow, "relational_op", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_rel_op" ) )
		idw_criteria.SetItem( li_newrow, "expression_two", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_dflt_value" ) )
		
		//	Check if Retrieval argument
		ls_table = ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_tbl_name" )
		IF ls_table = "ARGUMENT" THEN		// Retrieval Argument
			idw_criteria.SetItem( li_newrow, "logical_op", "AND" )
			idw_criteria.SetItem( li_newrow, "c_elem_data_type", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_ra_data_type" )	)
			idw_criteria.SetItem( li_newrow, "pdr_protect", "A" )
		ELSE										//	Regular Column
			idw_criteria.SetItem( li_newrow, "left_paren", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_left_paren" ) )
			idw_criteria.SetItem( li_newrow, "right_paren", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_right_paren" ) )
			idw_criteria.SetItem( li_newrow, "logical_op", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_logic_op" ) )
			idw_criteria.SetItem( li_newrow, "lookup", ids_pdr_criteria.GetItemString( ll_row, "dictionary_elem_lookup_type" ) )
			idw_criteria.SetItem( li_newrow, "pdr_protect", "Y" )
		END IF
	ELSE
		//	See if the PDR required row matches the loaded criteria row
		ls_col_name = ids_pdr_criteria.GetItemString( ll_row, "col_name" )
		li_found = idw_criteria.Find( "expression_one = '" + ls_col_name + "'", 1, idw_criteria.RowCount() )
		IF li_found > 0 THEN
			ls_table = ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_tbl_name" )
			IF ls_table = "ARGUMENT" THEN		// Retrieval Argument
				idw_criteria.SetItem( li_found, "logical_op", "AND" )
				idw_criteria.SetItem( li_found, "c_elem_data_type", ids_pdr_criteria.GetItemString( ll_row, "pdr_criteria_ra_data_type" )	)
				idw_criteria.SetItem( li_found, "pdr_protect", "A" )
			ELSE										//	Regular Column
				idw_criteria.SetItem( li_found, "lookup", ids_pdr_criteria.GetItemString( ll_row, "dictionary_elem_lookup_type" ) )
				idw_criteria.SetItem( li_found, "pdr_protect", "Y" )
			END IF
		ELSE
			MessageBox( "ERROR", "Required column '" + ls_col_name + "' is missing from the criteria" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
			Return -1
		END IF
	END IF
NEXT

IF ll_dddw_count = 0 AND ll_rowcount = 0 THEN
	MessageBox( "ERROR", "Unable to identify any criteria with link id " + ls_pdr_link + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
	Return -1
END IF

//	IF there are required fields
//	Set focus on expression_two
IF ll_rowcount > 0 THEN
	idw_criteria.SetColumn( "expression_two" )
END IF

// Validate the last row
ll_row = idw_criteria.RowCount()
IF ll_row > 0 THEN
	IF Trim( idw_criteria.GetItemString( ll_row, "pdr_protect" ) ) = "A" THEN
		IF ll_dddw_count > 0 THEN li_newrow = idw_criteria.InsertRow( 0 )
	END IF
ELSE
	li_newrow = idw_criteria.InsertRow( 0 )
END IF

idw_criteria.AcceptText()

Return 1
end event

event type integer ue_tabpage_pdr_load(integer ai_level_num);///////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_pdr_load								u_nvo_pdr
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_load_query 
//	when a pre-defined report is loaded.
// It will take the information out of dw_pdq_tables 
//	(per level_num) and load it into this 
// tabpage.  When the datawindow is loaded it should 
//	trigger the itemchanged event which 
// will prepare the next tabs to be loaded.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype			Description
//		---------	--------			--------			-----------
//		Value			ai_level_num	Integer			The level.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
//						-1				Failure
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Date		Author	Description
// ----		------	-----------
//	04/29/02	GaryR		Track 2552d	Predefined Report (PDR)
//	05/10/04	GaryR		Track 3756d	Streamline PDR deployment & security
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_rowcount, li_idx, li_current_row, li_rc
String	ls_value, ls_pd_opt_desc, ls_fastquery_ind
Long		ll_fastquery_rows
DataWindowChild ldwc_pdr_cat, ldwc_pdr_type, ldwc_pdr_report
sx_dw_format	lsx_report_options

li_rc	=	This.Event	ue_tabpage_pdr_construct( "PDR" )

idw_pdr.GetChild( "pdr_cat", ldwc_pdr_cat )
idw_pdr.GetChild( "pdr_type", ldwc_pdr_type )
idw_pdr.GetChild( "pdr_report", ldwc_pdr_report )

IF NOT IsValid( ldwc_pdr_cat ) THEN Return -1
IF NOT IsValid( ldwc_pdr_type ) THEN Return -1
IF NOT IsValid( ldwc_pdr_type ) THEN Return -1
IF NOT IsValid( iuo_query ) THEN Return -1

iw_parent.wf_SetLevelFilter( ai_level_num, "PDR" )

li_rowcount = idw_pdq_tables.RowCount()

IF li_rowcount < 1 THEN	Return -1

FOR li_idx = 1 TO li_rowcount
	// First trigger ItemChanged on PDR Cat
	ls_value = idw_pdq_tables.object.tbl_type[li_idx]
	li_rc = ldwc_pdr_cat.Find( "code_code = '" + ls_value + "'", 1, ldwc_pdr_cat.RowCount() )
	IF li_rc > 0 THEN
		idw_pdr.SetColumn( "pdr_cat" )
		idw_pdr.SetText( ls_value )
		idw_pdr.AcceptText()
	ELSE
		MessageBox( "ERROR", "Unable to find Report Category '" + ls_value + "'" )
		Return -1
	END IF
	
	// Trigger ItemChanged on PDR Type
	IF idw_pdq_cntl.RowCount() <> 1 THEN
		MessageBox( "ERROR", "Unable to find Report Type '" + ls_value + "'" )
		Return -1
	END IF
		
	ls_value = idw_pdq_cntl.object.addl_query_type[1]
	li_rc = ldwc_pdr_type.Find( "code_code = '" + ls_value + "'", 1, ldwc_pdr_type.RowCount() )
	IF li_rc > 0 THEN
		idw_pdr.SetColumn( "pdr_type" )
		idw_pdr.SetText( ls_value )
		idw_pdr.AcceptText()
	ELSE
		MessageBox( "ERROR", "Unable to find Report Type '" + ls_value + "'" )
		Return -1
	END IF
	
	// Trigger ItemChanged on PDR Report
	ls_value = idw_pdq_tables.object.predefined_report[li_idx]
	li_rc = ldwc_pdr_report.Find( "pdr_name = '" + ls_value + "'", 1, ldwc_pdr_report.RowCount() )
	IF li_rc > 0 THEN
		ls_value = ldwc_pdr_report.GetItemString( li_rc, "pdr_label" )
		idw_pdr.SetColumn( "pdr_report" )
		idw_pdr.SetText( ls_value )
		idw_pdr.AcceptText()
	ELSE
		MessageBox( "ERROR", "Unable to find report '" + ls_value + "'" + &
						"~n~rYou may not have sufficient privileges to view this report!", StopSign! )
		Return -1
	END IF
	
	lsx_report_options.title = idw_pdq_tables.object.rpt_title[li_idx]
	lsx_report_options.subtitle1 = idw_pdq_tables.object.sub_title1[li_idx]
	lsx_report_options.subtitle2 = idw_pdq_tables.object.sub_title2[li_idx]
	lsx_report_options.subtitle3 = idw_pdq_tables.object.sub_title3[li_idx]
	lsx_report_options.subtitle4 = idw_pdq_tables.object.sub_title4[li_idx]
	lsx_report_options.description = idw_pdq_tables.object.rpt_desc[li_idx]
	lsx_report_options.client_code = idw_pdq_tables.object.client_name[li_idx]
	lsx_report_options.stmt_code = idw_pdq_tables.object.custom_statement[li_idx]
	lsx_report_options.report_options = idw_pdq_tables.object.report_options[li_idx]
	IF iuo_report_options.of_load( lsx_report_options ) < 1 THEN Return -1
	
	ls_pd_opt_desc = idw_pdq_tables.object.payment_date_options[li_idx]
	iuo_query.of_set_pd_opt_desc(ls_pd_opt_desc)
NEXT

iuo_query.of_enable_tabpage( ic_pdr, TRUE )
iuo_query.Event	ue_SelectTab(0)

iw_parent.wf_SetLevelfilter( 0, "PDR" )
This.uf_SetStatus( idw_pdr, NotModified! )

Return 1
end event

event type integer ue_tabpage_pdr_secure(ref datawindowchild adwc_pdr_ver);//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection

Integer li_rows, li_row

li_rows = adwc_pdr_ver.RowCount()
inv_count = Create u_nvo_count
FOR li_row = 1 TO li_rows
	IF This.uf_is_pdr_secured( adwc_pdr_ver.GetItemNumber( li_row, "pdr_security" ) ) THEN
		adwc_pdr_ver.DeleteRow( li_row )
		li_row --
		li_rows --
	END IF
NEXT
Destroy inv_count

Return li_rows
end event

event ue_tabpage_pdr_filter_source();/////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////

String	ls_inv_types, ls_filter, ls_inv_type, ls_remove_inv_types
Integer	li_row, li_pos, i
DatawindowChild	ldwc_data_source

idw_source.GetChild( "inv_type", ldwc_data_source )
li_row = idw_source.GetRow()
IF li_row < 1 THEN Return

ls_inv_types = idw_source.GetItemString( li_row, "inv_types" )
IF IsNull( ls_inv_types ) OR Trim( ls_inv_types ) = "" THEN Return

//	Prevent selection of duplicate invoices in two data sources
FOR i = 1 TO idw_source.RowCount()
	IF i = li_row THEN Continue
	ls_inv_type = Left( idw_source.GetItemString( i, "inv_type" ), 2 )
	IF NOT IsNull( ls_inv_type ) AND Trim( ls_inv_type ) <> "" THEN
		ls_remove_inv_types += ",'" + ls_inv_type + "'"
	END IF
NEXT

IF ls_remove_inv_types > "" THEN
	ls_remove_inv_types = " and stars_rel_rel_type not in (" + &
									Mid( ls_remove_inv_types, 2 ) + ")"
END IF

li_pos = Pos( ls_inv_types, "," )
ls_filter = ",'" + Mid( ls_inv_types, 1, 2 ) + "'"

DO WHILE li_pos > 0
	ls_filter += ",'" + Mid( ls_inv_types, li_pos + 1, 2 ) + "'"
	li_pos = Pos( ls_inv_types, ",", li_pos + 1 )
LOOP

// Remove the leading comma
ls_filter = Mid( ls_filter, 2 )
//	Build the actual filter clause
ls_filter = "stars_rel_rel_type in (" + ls_filter + ")" + ls_remove_inv_types
ldwc_data_source.SetFilter( ls_filter )
ldwc_data_source.Filter()
end event

event type integer ue_tabpage_pdr_validate_source();//////////////////////////////////////////////////////////////////////////////////////
//
// This method will validate if all of the information has been filled in.
//	Then it will load the search criteria and enable the search tab
//	Returns:	1 - Everything went smoothly, enable tabs
//				0 - Source tab not ready, keep tabs disabled
//				-1 - Error occured, keep tabs disabled
//
//////////////////////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	12/28/04	GaryR	Track 4198d	Do not reset new query flag
//	01/28/05	GaryR	Track 4212d	Enable the Next button if validation passes
//
//////////////////////////////////////////////////////////////////////////////////////

String	ls_subset, ls_invoice
Integer	i

idw_source.AcceptText( )

FOR i = 1 TO idw_source.RowCount()
	//	Check if subset or base
	IF idw_source.GetItemString( i, "source_type" ) = "S" THEN
		ls_subset = idw_source.GetItemString( i, "subset_name" )
		IF IsNull( ls_subset ) OR Trim( ls_subset ) = "" THEN
			iuo_query.tabpage_search.enabled = FALSE
			iuo_query.tabpage_report.enabled = FALSE
			iuo_query.tabpage_view.enabled = FALSE
			Return 0
		END IF
	END IF
	
	ls_invoice = idw_source.GetItemString( i, "inv_type" )
	IF IsNull( ls_invoice ) OR Trim( ls_invoice ) = "" THEN
		iuo_query.tabpage_search.enabled = FALSE
		iuo_query.tabpage_report.enabled = FALSE
		iuo_query.tabpage_view.enabled = FALSE
		Return 0
	END IF
NEXT

i = This.Event ue_tabpage_pdr_load_search( TRUE )

IF i < 0 THEN	// Error
	iuo_query.tabpage_search.enabled = FALSE
	iuo_query.tabpage_report.enabled = FALSE
	iuo_query.tabpage_view.enabled = FALSE
	Return -1
ELSEIF i = 0 THEN		// No criteria
	iuo_query.tabpage_search.enabled = FALSE
	iuo_query.tabpage_report.enabled = TRUE
	iuo_query.tabpage_view.enabled = TRUE
	Return 0
ELSE	// Success
	iuo_query.tabpage_source.cb_next_source.enabled = TRUE
	iuo_query.tabpage_search.enabled = TRUE
	iuo_query.tabpage_report.enabled = TRUE
	iuo_query.tabpage_view.enabled = TRUE
	Return 1
END IF
end event

event type integer ue_tabpage_pdr_save(integer ai_level, string as_query_id);/////////////////////////////////////////////////////////////////////////
//
// This event will only fire if the current PDR is claims based.
//	Loop thru all of the data sources and selected options and save
//
/////////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////////////

String	ls_src_desc, ls_subset_id, ls_case_id
Integer	li_row, li_newrow

FOR li_row = 1 TO idw_source.RowCount()
	li_newrow = idw_pdr_sources.InsertRow( 0 )
	idw_pdr_sources.object.pdr_link[li_newrow] = Double( as_query_id )
	idw_pdr_sources.object.seq_num[li_newrow] = li_row
	idw_pdr_sources.object.src_type[li_newrow] = idw_source.object.base_invoice[li_row]
	idw_pdr_sources.object.src_dflt[li_newrow] = idw_source.object.source_type[li_row]
	idw_pdr_sources.object.src_crit_use_dict[li_newrow] = idw_source.object.src_crit_use_dict[li_row]
	idw_pdr_sources.object.src_inv_type[li_newrow] = Left( idw_source.object.inv_type[li_row], 2 )
	
	// Trim data for DBMS
	ls_src_desc = idw_source.object.source_desc[li_row]
	ls_subset_id = idw_source.object.subset_id[li_row]
	ls_case_id = idw_source.object.case_id[li_row]
	
	gnv_sql.of_trimdata( ls_src_desc )
	gnv_sql.of_trimdata( ls_subset_id )
	gnv_sql.of_trimdata( ls_case_id )
	
	idw_pdr_sources.object.src_desc[li_newrow] = ls_src_desc
	idw_pdr_sources.object.src_subset_id[li_newrow] = ls_subset_id
	idw_pdr_sources.object.src_case_id[li_newrow] = ls_case_id
NEXT

Return 1
end event

event type integer ue_tabpage_pdr_build_syntax(string as_pdr_name);/////////////////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//	12/28/04	GaryR	Track 4199d	Store original SQL
//	02/29/08	GaryR	Track 4771	Support NPI PDRs
//	05/02/08	GaryR	Track 4771	Hide NPI column to remove from Excel export
//
/////////////////////////////////////////////////////////////////////////////

Blob		lbl_pdr_syntax
String	ls_pdr_syntax, ls_error, ls_name, ls_modify
Integer	li_ctr, li_cnt

//Create from dw syntax
SELECTBLOB pdr_syntax
INTO	:lbl_pdr_syntax
FROM	pdr_cntl
WHERE	pdr_name = :as_pdr_name
USING	Stars2ca;

ls_pdr_syntax = String( lbl_pdr_syntax )
lbl_pdr_syntax = Blob( "" )

IF Stars2ca.of_check_status() <> 0 OR IsNull( ls_pdr_syntax ) OR Trim( ls_pdr_syntax ) = "" THEN
	MessageBox( "ERROR", "~n~rCannot find PDR Syntax in PDR_CNTL where PDR_NAME = '" + as_pdr_name + "'" + &
										 "~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
	Return -1
END IF

IF idw_report.Create( ls_pdr_syntax, ls_error ) < 0 THEN
	MessageBox( "ERROR", "Unable to build report due to the following error:~n~r" + ls_error + &
								"~n~r~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
	Return -1
END IF

//	Reregister the DW
iuo_report_options.of_register( idw_report )

//	Get the SQL
idw_report.SetTransObject( Stars2ca )
iuo_query.is_pdr_sql = Upper( idw_report.Object.DataWindow.Table.Select )
IF Trim( iuo_query.is_pdr_sql ) = "" THEN
	MessageBox( "ERROR", "Unable to obtain the SQL from the report" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )	
	Return -1
END IF

// Hide NPI columns when gv_npi_cntl < 1
IF gv_npi_cntl < 1 THEN
	li_cnt = Integer( idw_report.Object.DataWindow.Column.Count )
	FOR li_ctr = 1 TO li_cnt
		ls_name = idw_report.Describe( "#" + String( li_ctr ) + ".Name" )
		IF Match( Upper( ls_name ), "NPI" ) THEN
			ls_modify += "#" + String( li_ctr ) + ".Width='0' "
			ls_modify += "#" + String( li_ctr ) + ".Visible='0' "
		END IF
	NEXT
END IF

IF ls_modify > "" THEN
	ls_error = idw_report.Modify( ls_modify )
END IF

Return 1
end event

event ue_tabpage_pdr_init_report_options();/////////////////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////////////////

Boolean			lb_subset
sx_pdr_parms	lsx_pdr_parms

iw_parent.of_get_pdr_parm( lsx_pdr_parms )

IF lsx_pdr_parms.pdr_source > 0 THEN
	lb_subset = idw_source.RowCount() = 1
END IF

iuo_report_options.of_init( lsx_pdr_parms.format_flags, lb_subset )
end event

public function integer of_setlabels ();///////////////////////////////////////////////////////////////
//
//	01/15/03	GaryR	Track 3400d	Dictionarize the headers
//	09/11/03	GaryR	Convert SP col name to upper case
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//  05/27/09 RickB GNL.600.5633.006 Added code to create accessibility name and description
//						for columns not in the database.
//
///////////////////////////////////////////////////////////////

Integer	li_num_of_col, li_col, li_pos, li_display
String 	ls_name, ls_col_name, ls_table, &
			ls_label, ls_header, ls_modify, ls_text
sx_pdr_parms	lsx_pdr_parms
n_cst_string	lnv_string

SetPointer( HourGlass! )
idw_report.SetRedraw( FALSE )

iw_parent.of_get_pdr_parm( lsx_pdr_parms )

// Get the number of columns on the datawindow
li_num_of_col 		= 	Long( idw_report.Describe( 'datawindow.column.count' ) )

// Read and process the labels for each column
FOR li_col	=	1 to li_num_of_col
	//	Check if header exists and empty
	ls_name =	idw_report.Describe( '#' + String( li_col )  + '.name' )
	ls_header = ls_name + "_t"
	
	ls_text = Trim( idw_report.Describe( ls_header + ".text" ) )
	
	IF ls_text <> "" OR ls_text = "!" THEN
		//	Set Accessibility Properties for columns with headers NOT in database.
		ls_label = lnv_string.of_clean_string_acc( ls_text )
		ls_label = '"' + ls_label + '"~t"' + ls_label + '"'
		ls_modify += ls_name + ".AccessibleName='" + ls_label + "' "
		ls_modify += ls_name + ".AccessibleDescription='" + ls_label + "' "
		ls_modify += ls_header + ".AccessibleName='" + ls_label + "' "
		ls_modify += ls_header + ".AccessibleDescription='" + ls_label + "' "		
		Continue
	END IF
	
	// Get the name of the database column from the datawindow 
	ls_col_name =	Upper( idw_report.Describe( '#' + String( li_col )  + '.dbname' ) )
	
	// Split up table and name
	li_pos =	Pos( ls_col_name, '.' )
	
	//	Check if claims PDR
	IF lsx_pdr_parms.pdr_source > 0 THEN
		IF li_pos < 1 THEN
			MessageBox( "Error", "Unable to identify table for column " + ls_col_name + &
										"~n~rLabels will not be changed." )
			Return -1
		END IF
		
		ls_table	= Upper( Trim( Left( ls_col_name, li_pos - 1 ) ) )
		ls_col_name = Upper( Trim( Mid( ls_col_name, li_pos + 1 ) ) )
		ls_table = idw_source.Dynamic Event ue_get_inv_type( ls_table )
		
		// Get descriptive information for this database column from the dictionary
		SELECT	elem_elem_label, crit_seq
		INTO 	 	:ls_label, :li_display
		FROM 		dictionary 
		WHERE 	elem_type 		=	'CL' 
		AND 		elem_tbl_type 	=	:ls_table
		AND		ELEM_NAME 		= :ls_col_name
		USING 	stars2ca;
	ELSE
		IF li_pos > 0 THEN
			ls_table	= Upper( Trim( Left( ls_col_name, li_pos - 1 ) ) )
			ls_col_name = Upper( Trim( Mid( ls_col_name, li_pos + 1 ) ) )
		ELSE
			ls_table = "CASE_CNTL"
		END IF
		
		// Get descriptive information for this database column from the dictionary
		SELECT	elem_elem_label, crit_seq
		INTO 	 	:ls_label, :li_display
		FROM 		dictionary 
		WHERE 	elem_type 		=	'CL' 
		AND 		elem_tbl_type 	=	(SELECT elem_tbl_type 
											FROM dictionary 
											WHERE elem_type = 'TB' 
											AND elem_name = :ls_table)
		AND		ELEM_NAME 		= :ls_col_name
		USING 	stars2ca;
	END IF
	 
	IF Stars2ca.of_check_status() = -1 THEN
		MessageBox( "Error", "Unable to query DICTIONARY label for column: " + &
									ls_col_name + " in table: " + ls_table + "~n~r" + &
									"Labels will not be changed." )
		Return -1
	END IF 
	
	//	If not found then do not process
	IF Stars2ca.of_check_status() = 100 THEN
		li_display = 0
		ls_label = ""
	END IF
	
	//	Set modifies
	IF IsNull( ls_label ) THEN ls_label = ""
	ls_modify += ls_header + ".text = '" + ls_label + "' "
	IF li_display <= 0 OR Trim( ls_label ) = "" THEN
		ls_modify += ls_name + ".Visible='0' "
	ELSE
		//	Set Accessibility Properties
		ls_label = lnv_string.of_clean_string_acc( ls_label )
		ls_label = '"' + ls_label + '"~t"' + ls_label + '"'
		ls_modify += ls_name + ".AccessibleName='" + ls_label + "' "
		ls_modify += ls_name + ".AccessibleDescription='" + ls_label + "' "
		ls_modify += ls_header + ".AccessibleName='" + ls_label + "' "
		ls_modify += ls_header + ".AccessibleDescription='" + ls_label + "' "
	END IF
NEXT

ls_modify = Trim( ls_modify )
IF	ls_modify <> "" THEN idw_report.Modify( ls_modify )

idw_report.SetRedraw( TRUE )

Return 1
end function

public function integer of_replace_table (ref string as_expression, sx_pdr_tables asx_pdr_tables[], boolean ab_proc, boolean ab_claims);///////////////////////////////////////////////////////////////////////
//
//	04/24/02	GaryR	Track 2552d	Predefined Report (PDR)
//	03/11/03	GaryR	Track 3445d	Convert character criteria to upper case
//	08/12/03	GaryR	Track 3459d	Accept PDRs with Stored Procedures as Datasource
// 09/20/04 Katie Track 4019d Added lines 34-37 to accomidate SOUNDEX.
//	10/19/04	GaryR	Track 3650d	Utilize global dictionary service
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	12/20/04	GaryR	Track 4170d	Add Custom Criteria to PDRs
//
///////////////////////////////////////////////////////////////////////

Integer	li_pos, li_ctr, li_cnt
String	ls_elem_tbl_type, ls_table

IF IsNull( as_expression ) OR Trim( as_expression ) = "" THEN
	MessageBox( 'ERROR', "Invalid expression passed to u_nvo_pdr::of_replace_table" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
	Return - 1
END IF

// Parse the elem_tbl_type
li_pos = Pos( as_expression, "." )
IF li_pos <= 0 THEN
	MessageBox( 'ERROR', "Unable to identify the table type declared for field '" + as_expression + "'" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
	Return -1
END IF

ls_elem_tbl_type = Trim( Upper( Mid( as_expression, li_pos - 2, 2 ) ) )
//li_pos = Pos( ls_elem_tbl_type, "(" )
//IF li_pos <> 0 THEN
//	ls_elem_tbl_type = Trim( Mid( ls_elem_tbl_type, li_pos + 1 ) )
//END IF
//
//li_pos = Pos( ls_elem_tbl_type, "(" )
//IF li_pos <> 0 THEN
//	ls_elem_tbl_type = Trim( Mid( ls_elem_tbl_type, li_pos + 1 ) )
//END IF

IF ls_elem_tbl_type = "" THEN
	MessageBox( 'ERROR', "Unable to identify the table type declared for field '" + as_expression + "'" + &
								"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
	Return -1
END IF

IF NOT ab_proc THEN
	//	Locate the table for the tbl type
	li_cnt = UpperBound( asx_pdr_tables )
	FOR li_ctr = 1 TO li_cnt
		IF ls_elem_tbl_type = asx_pdr_tables[li_ctr].s_elem_tbl_type THEN Exit
	NEXT
	
	// No table matched
	IF li_ctr > li_cnt THEN
		MessageBox( 'ERROR', "Unable to map table type '" + ls_elem_tbl_type + "' to any of the tables used in the report" + &
									"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
		Return -1
	END IF
	
	// Replace the table type with
	//	the name defined in the SQL
	li_pos = Pos( as_expression, ls_elem_tbl_type + "." )
	IF asx_pdr_tables[li_ctr].s_alias <> "" THEN
		//	Replace alias
		as_expression = Replace( as_expression, li_pos, Len( ls_elem_tbl_type ), asx_pdr_tables[li_ctr].s_alias )
	ELSE
		IF asx_pdr_tables[li_ctr].s_db_name <> "" THEN
			//	Add database prefix
			asx_pdr_tables[li_ctr].s_db_name = gnv_sql.of_get_database_prefix( asx_pdr_tables[li_ctr].s_db_name )
		END IF
		
		//	Replace full table name
		as_expression = Replace( as_expression, li_pos, Len( ls_elem_tbl_type ), asx_pdr_tables[li_ctr].s_db_name + asx_pdr_tables[li_ctr].s_table )
	END IF
ELSE	//	Stored Procedures
	// Check if claims
	IF ab_claims THEN
		li_pos = idw_source.Find( "Left( inv_type, 2 ) = '" + ls_elem_tbl_type + "'", 1, idw_source.RowCount() )
		IF li_pos < 1 THEN
			MessageBox( 'ERROR', "Unable to map table type '" + ls_elem_tbl_type + "' to any of the sources used in the report" + &
									"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
			Return -1
		END IF
		ls_table = "A" + idw_source.GetItemString( li_pos, "src_type" )
	ELSE
		ls_table = gnv_dict.Event ue_get_table_name( ls_elem_tbl_type )
	END IF
	
	// Replace the table type with
	//	the name defined in the dictionary
	li_pos = Pos( as_expression, ls_elem_tbl_type + "." )
	
	//	Replace full table name
	as_expression = Replace( as_expression, li_pos, Len( ls_elem_tbl_type ), ls_table )
END IF
Return 1
end function

on u_nvo_pdr.create
call super::create
end on

on u_nvo_pdr.destroy
call super::destroy
end on

event constructor;call super::constructor;//	04/25/02	GaryR	Track 2552d Predefined Report (PDR)
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs

//	Prep the datastore for criteria
ids_pdr_criteria = Create n_ds
ids_pdr_criteria.dataobject = "d_pdr_criteria"
ids_pdr_criteria.SetTransObject( Stars2ca )
	
ids_pdr_sources = Create n_ds
ids_pdr_sources.dataobject = "d_pdr_sources"
ids_pdr_sources.SetTransObject( Stars2ca )


end event

event destructor;call super::destructor;//	04/25/02	GaryR	Track 2552d Predefined Report (PDR)
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs

//	Destroy the critria datastore
IF IsValid( ids_pdr_criteria) THEN Destroy ids_pdr_criteria
IF IsValid( ids_pdr_sources) THEN Destroy ids_pdr_sources
end event

