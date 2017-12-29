HA$PBExportHeader$w_sampling_analysis_new.srw
$PBExportComments$Patterns main window (inherited from w_master)
forward
global type w_sampling_analysis_new from w_master
end type
type tab_patt from tab within w_sampling_analysis_new
end type
type tabpage_list from userobject within tab_patt
end type
type gb_2 from groupbox within tabpage_list
end type
type uo_list_rmm from uo_tabpage_rmm within tabpage_list
end type
type dw_parms from u_dw within tabpage_list
end type
type dw_list from u_dw within tabpage_list
end type
type dw_list_desc from u_dw within tabpage_list
end type
type st_count_list from statictext within tabpage_list
end type
type cb_list_list from u_cb within tabpage_list
end type
type cb_list_select from u_cb within tabpage_list
end type
type cb_list_next from u_cb within tabpage_list
end type
type cb_list_close from u_cb within tabpage_list
end type
type tabpage_list from userobject within tab_patt
gb_2 gb_2
uo_list_rmm uo_list_rmm
dw_parms dw_parms
dw_list dw_list
dw_list_desc dw_list_desc
st_count_list st_count_list
cb_list_list cb_list_list
cb_list_select cb_list_select
cb_list_next cb_list_next
cb_list_close cb_list_close
end type
type tabpage_criteria from userobject within tab_patt
end type
type gb_1 from groupbox within tabpage_criteria
end type
type gb_3 from groupbox within tabpage_criteria
end type
type cbx_not from u_cbx within tabpage_criteria
end type
type dw_patt_cntl from u_dw within tabpage_criteria
end type
type cb_criteria_clear from u_cb within tabpage_criteria
end type
type cb_criteria_next from u_cb within tabpage_criteria
end type
type cb_criteria_prev from u_cb within tabpage_criteria
end type
type cb_criteria_close from u_cb within tabpage_criteria
end type
type pb_notes from u_pb within tabpage_criteria
end type
type dw_criteria from u_dw within tabpage_criteria
end type
type uo_criteria_rmm from uo_tabpage_rmm within tabpage_criteria
end type
type tabpage_criteria from userobject within tab_patt
gb_1 gb_1
gb_3 gb_3
cbx_not cbx_not
dw_patt_cntl dw_patt_cntl
cb_criteria_clear cb_criteria_clear
cb_criteria_next cb_criteria_next
cb_criteria_prev cb_criteria_prev
cb_criteria_close cb_criteria_close
pb_notes pb_notes
dw_criteria dw_criteria
uo_criteria_rmm uo_criteria_rmm
end type
type tabpage_options from userobject within tab_patt
end type
type uo_options_rmm from uo_tabpage_rmm within tabpage_options
end type
type dw_patt_options from u_dw within tabpage_options
end type
type cb_options_clear from u_cb within tabpage_options
end type
type cb_options_next from u_cb within tabpage_options
end type
type cb_options_prev from u_cb within tabpage_options
end type
type cb_options_close from u_cb within tabpage_options
end type
type tabpage_options from userobject within tab_patt
uo_options_rmm uo_options_rmm
dw_patt_options dw_patt_options
cb_options_clear cb_options_clear
cb_options_next cb_options_next
cb_options_prev cb_options_prev
cb_options_close cb_options_close
end type
type tabpage_timeframe from userobject within tab_patt
end type
type uo_timeframe_rmm from uo_tabpage_rmm within tabpage_timeframe
end type
type dw_timeframe from u_dw within tabpage_timeframe
end type
type cb_timeframe_clear from u_cb within tabpage_timeframe
end type
type cb_timeframe_next from u_cb within tabpage_timeframe
end type
type cb_timeframe_prev from u_cb within tabpage_timeframe
end type
type cb_timeframe_close from u_cb within tabpage_timeframe
end type
type tabpage_timeframe from userobject within tab_patt
uo_timeframe_rmm uo_timeframe_rmm
dw_timeframe dw_timeframe
cb_timeframe_clear cb_timeframe_clear
cb_timeframe_next cb_timeframe_next
cb_timeframe_prev cb_timeframe_prev
cb_timeframe_close cb_timeframe_close
end type
type tabpage_custom from userobject within tab_patt
end type
type uo_custom_rmm from uo_tabpage_rmm within tabpage_custom
end type
type dw_title from u_dw within tabpage_custom
end type
type st_1 from statictext within tabpage_custom
end type
type st_2 from statictext within tabpage_custom
end type
type dw_available from u_dw within tabpage_custom
end type
type dw_selected from u_dw within tabpage_custom
end type
type cb_custom_add from u_cb within tabpage_custom
end type
type cb_custom_remove from u_cb within tabpage_custom
end type
type cb_custom_up from u_cb within tabpage_custom
end type
type cb_custom_down from u_cb within tabpage_custom
end type
type st_custom_count from statictext within tabpage_custom
end type
type cb_custom_next from u_cb within tabpage_custom
end type
type cb_custom_prev from u_cb within tabpage_custom
end type
type cb_custom_close from u_cb within tabpage_custom
end type
type tabpage_custom from userobject within tab_patt
uo_custom_rmm uo_custom_rmm
dw_title dw_title
st_1 st_1
st_2 st_2
dw_available dw_available
dw_selected dw_selected
cb_custom_add cb_custom_add
cb_custom_remove cb_custom_remove
cb_custom_up cb_custom_up
cb_custom_down cb_custom_down
st_custom_count st_custom_count
cb_custom_next cb_custom_next
cb_custom_prev cb_custom_prev
cb_custom_close cb_custom_close
end type
type tabpage_report from userobject within tab_patt
end type
type uo_report_rmm from uo_tabpage_rmm within tabpage_report
end type
type dw_report from u_dw within tabpage_report
end type
type st_count from statictext within tabpage_report
end type
type cb_report_prev from u_cb within tabpage_report
end type
type cb_report_close from u_cb within tabpage_report
end type
type tabpage_report from userobject within tab_patt
uo_report_rmm uo_report_rmm
dw_report dw_report
st_count st_count
cb_report_prev cb_report_prev
cb_report_close cb_report_close
end type
type tab_patt from tab within w_sampling_analysis_new
tabpage_list tabpage_list
tabpage_criteria tabpage_criteria
tabpage_options tabpage_options
tabpage_timeframe tabpage_timeframe
tabpage_custom tabpage_custom
tabpage_report tabpage_report
end type
type dw_3 from u_dw within w_sampling_analysis_new
end type
type dw_2 from u_dw within w_sampling_analysis_new
end type
type sx_pattern_field from structure within w_sampling_analysis_new
end type
end forward

type sx_pattern_field from structure
	string		field_set
	integer		number
	string		label
	string		tbl_type
	string		column
	integer		set_number
	string		field_value
end type

global type w_sampling_analysis_new from w_master
string accessiblename = "Pattern Recognition Analysis"
string accessibledescription = "Pattern Recognition Analysis"
integer x = 14
integer y = 32
integer width = 2921
integer height = 1740
string title = "Pattern Recognition Analysis"
boolean ib_popup_menu = true
event type integer ue_verify_case_id ( string as_case_id )
event ue_fill_timeframe_dddw ( )
event ue_select ( )
event ue_clear_dws ( )
event ue_load_timeframe ( )
event ue_edit_enable_report ( )
event ue_get_subset_name ( )
event type integer ue_set_inv_type_dddw ( )
event ue_filter_patterns ( string as_inv_type )
event ue_edit_options_tab ( )
event ue_edit_timeframe_tab ( )
event ue_clear_timeframe_data ( )
event ue_update_timeframe_structure ( )
event ue_format_tabs ( )
event ue_format_criteria ( )
event ue_filter_criteria_dddw ( long al_row )
event ue_patt_type_changed ( string as_patt_type,  string as_old_patt_type )
event ue_view_report ( )
event ue_import ( )
event ue_export ( )
event ue_code_lookup ( string as_value,  long al_row )
event type integer ue_edit_generic_criteria ( long al_row,  string as_column,  string as_data )
event type integer ue_edit_custom_criteria ( long al_row,  string as_column,  string as_data )
event ue_lookup_exist ( string as_from )
event ue_protect_field_description ( )
event ue_subset ( )
event ue_report_and_subset ( )
event type integer ue_get_generic_sql ( )
event ue_enable_import ( boolean ab_switch )
event ue_init_pattern_sql ( )
event type integer ue_get_spec_sql ( )
event ue_enable_report_tab ( boolean ab_switch )
event ue_enable_background ( boolean ab_switch )
event type integer ue_write_subset_tables ( )
event ue_pattern_17 ( )
event ue_pattern_20 ( )
event ue_enable_decode ( boolean ab_switch )
event type integer ue_create_datawindows ( )
event ue_clear_options_tab ( )
event ue_edit_enable_prev_next ( )
event type integer ue_save_pattern ( string as_mode )
event ue_mapping ( )
event ue_create_case_link ( )
event ue_filter_dw_list ( )
event ue_custom_add ( )
event ue_custom_remove ( )
event ue_custom_remove_all ( )
event ue_custom_move ( string as_direction )
event ue_custom_set_count ( )
event type integer ue_edit_dw_parms ( )
event ue_retrieve_dw_available ( )
event ue_get_tbl_retrieve ( )
event ue_custom_default_title ( )
event ue_custom_load_selected ( )
event ue_custom_clear ( )
event ue_custom_load_patt_columns ( )
event type string ue_export_file_hdr ( integer ai_file_number,  string as_comment )
event type string ue_export_pattern_hdr ( integer ai_file_number )
event type string ue_export_pattern_tables ( integer ai_file_number )
event type string ue_export_pattern_options ( integer ai_file_number )
event type string ue_export_pattern_criteria ( integer ai_file_number )
event type string ue_export_pattern_columns ( integer ai_file_number )
event ue_enable_link ( boolean ab_switch )
event ue_retrieve_field_dddw ( )
event type integer ue_edit_save_mode ( )
event ue_custom_title_change ( string as_title )
event type integer ue_create_patt_rel ( )
event ue_import_clean_up ( long al_file_number,  boolean ab_close_file )
event type integer ue_import_file_hdr ( string as_record )
event type integer ue_import_pattern_hdr ( string as_record )
event type integer ue_import_pattern_tables ( string as_record )
event type integer ue_import_pattern_options ( string as_record )
event type integer ue_import_pattern_criteria ( string as_record )
event type integer ue_import_pattern_columns ( string as_record )
event type integer ue_import_tables_trailer ( string as_record,  string as_comment )
event ue_custom_load_title ( )
event type string ue_export_pattern_notes ( integer ai_file_number )
event type integer ue_import_pattern_notes ( string as_record )
event ue_notes ( )
event type integer ue_edit_field_value ( long al_row,  string as_data )
event type integer ue_edit_field_operator ( long al_row,  string as_data )
event ue_retrieve_notes ( )
event ue_edit_display_notes ( )
event type integer ue_notes_insert ( )
event ue_notes_clear ( )
event ue_notes_text ( long al_row )
event type integer ue_edit_save_filter ( )
event ue_enable_select ( boolean ab_switch )
event ue_enable_delete ( boolean ab_switch )
event ue_enable_save ( boolean ab_switch )
event ue_enable_saveas ( boolean ab_switch )
event ue_enable_export ( boolean ab_switch )
event ue_enable_clear ( boolean ab_switch )
event ue_enable_save_userpattern ( boolean ab_switch )
event type integer ue_select_unique_key_columns ( )
event type integer ue_edit_criteria ( )
event ue_close ( )
event ue_edit_enable_background ( )
event ue_reset_dw_report ( )
event ue_timeframe_edit_rb4 ( )
event ue_enable_subset ( boolean ab_switch )
event ue_enable_save_report ( boolean ab_switch )
event ue_init_criteria_dddw ( )
event ue_reset_dw_criteria ( )
event ue_enable_notes ( boolean ab_switch )
event ue_enable_update ( boolean ab_switch )
event type integer ue_edit_revenue ( )
tab_patt tab_patt
dw_3 dw_3
dw_2 dw_2
end type
global w_sampling_analysis_new w_sampling_analysis_new

type variables
// Has the Options tab been clicked
Boolean		ib_options_tab

// Are non-string columns included in the Criteria DDLB?
Boolean		ib_include_non_string_columns

// Saves the current state of m_showsql in m_stars_30
Boolean		ib_showsql

// Currently trying to save the pattern
Boolean		ib_save

// Remove all rows from dw_selected without re-adding
// the unique key columns
Boolean		ib_remove_all

// Right mouse menus (RMM)
m_patt_list	im_patt_list
m_patt_criteria	im_patt_criteria
m_patt_options	im_patt_options
m_patt_timeframe	im_patt_timeframe
m_patt_custom	im_patt_custom
m_patt_report	im_patt_report

// Tab pages
Constant	Int	ici_list = 1
Constant	Int	ici_criteria = 2
Constant	Int	ici_options = 3
Constant	Int	ici_timeframe = 4
Constant	Int	ici_customize = 5
Constant	Int	ici_report = 6

// Column names and table types from the SQL
String		is_sql_col_name[]
String		is_sql_tbl_type[]

// Max # of generic criteria rows
Constant	Int	ici_generic_fields = 4

// Pattern type (column patt_type)
Constant	String	ics_pattern_template = 'T'
Constant	String	ics_user_pattern = 'U'
Constant	String	ics_all_patterns = 'A'

// FDG 02/23/01 - Make all pattern upper-case because of case-sensitivity with Oracle
// Pattern IDs
Constant	String	ics_filter_pat = 'FILTER_PAT'	// filter pattern
Constant	String	ics_generic = 'GENERIC'	// Generic pattern
Constant	String	ics_patt6 = 'PAT0000006'
Constant	String	ics_patt7 = 'PAT0000007'
Constant	String	ics_patt8 = 'PAT0000008'
Constant	String	ics_patt9 = 'PAT0000009'
Constant	String	ics_patt10 = 'PAT0000010'
Constant	String	ics_patt11 = 'PAT0000011'
Constant	String	ics_patt12 = 'PAT0000012'
Constant	String	ics_patt14 = 'PAT0000014'
Constant	String	ics_patt17 = 'PAT0000017'
Constant	String	ics_patt20 = 'PAT0000020'
Constant	String	ics_patt33 = 'PAT0000033'
Constant	String	ics_patt34 = 'PAT0000034'
Constant	String	ics_patt35 = 'PAT0000035'
Constant	String	ics_patt36 = 'PAT0000036'
Constant	String	ics_patt37 = 'PAT0000037'
Constant	String	ics_patt38 = 'PAT0000038'
Constant	String	ics_patt39 = 'PAT0000039'
Constant	String	ics_patt51 = 'PAT0000051'
Constant	String	ics_patt52 = 'PAT0000052'
Constant	String	ics_patt53 = 'PAT0000053'
Constant	String	ics_patt54 = 'PAT0000054'

// Patt_cond values
Constant	String	ics_background = '%BACKGROUND'

// Options DDDW values
Constant	String	ics_any = 'A'
Constant	String	ics_different = 'D'
Constant	String	ics_same = 'S'
Constant	String	ics_alwd_svc = 'A'
Constant	String	ics_all_claims = 'C'

// dw_criteria column names
Constant	String	ics_column_description = 'column_description'
Constant	String	ics_field_value = 'field_value'
Constant	String	ics_field_operator = 'field_operator'

// Value to specify that a column is compared against itself
// This has not yet been implemented.  Code must be 
// added to convert the criteria to SQL in object
// u_nvo_pattern_sql.ue_pattern_where
Constant String	ics_same_column = '##'

DataWindowChild	idwc_row1_col1
DataWindowChild	idwc_row1_col2
DataWindowChild	idwc_row2_col1
DataWindowChild	idwc_row2_col2
DataWindowChild	idwc_row3_col1
DataWindowChild	idwc_row3_col2

// Revenue code
String		is_revenue_code

// Unique invoice types for export/import
String		is_unique_tbl_type[]

// The number of unique keys for patterns 17 and 20
Integer		ii_number_keys

// Rowcount information for dw_2 (Patterns 17 and 20)
Long		il_rowcount
Long		il_row

// Other data required for patterns 17 and 20
Long		il_consecutive_days
Constant	Integer	ici_hicn = 1
Constant	Integer	ici_from_date_col = 2
Constant	Integer	ici_to_date_col = 3
Constant	Integer	ici_proc_code = 4
Constant	Integer	ici_ccn = 10
Constant	Integer	ici_line_no = 11
Constant	Integer	ici_print_ind = 10

// Data required for pattern 20
String		is_proc_set1
String		is_proc_set2
String		is_proc_set3
String		is_proc_set_ctls[3,3]

// Data required for subsets
String		is_pattern_tables[]
String		is_table_name

// The save mode - S=Save, A=Save As, L=Link
String		is_save_mode = 'S'

// The row in dw_selected in which the data was dragged to
Long		il_drop_row

Integer		ii_last_row_label

// NVO to get the revenue table type for a UB92 
// table type
n_cst_revenue	inv_revenue	

// To edit the list of patterns for case security
//	FDG	12/21/01	Track 2497.  Make inv_case local to prevent memory leaks
//n_cst_case	inv_case

// To get the name of the subset
nvo_subset_functions	inv_subset_functions

// Datastores used
n_ds		ids_dddw_timeframe
n_ds		ids_patt_field_parm
n_ds		ids_case_link
n_ds		ids_patt_columns
n_ds		ids_patt_field_sel
n_ds		ids_patt_rel

// Datastores used for importing a pattern
n_ds		ids_summary
n_ds		ids_errors
n_ds		ids_stars_rel
n_ds		ids_notes

// Is the import in process?
Boolean		ib_import

// Has the file header record been read (import)?
Boolean		ib_file_hdr_read

// Tempory subset ID when importing
String		is_import_subset_id

// Original subset ID and name when importing
String		is_orig_subset_id
String		is_orig_subset_name

// Original is_inv_type when importing
String		is_import_inv_type

// istr_sub_opt.patt_struc.table_type[] moved here
// until import is successful
String		is_import_tbl_type[]

// Imported note_text.  Because this is stored in a text
// format and the length can be > 32K, it must be stored
// here
String		is_note_text[]

String		is_sql
String		is_case_id
String		is_case_spl
String		is_case_ver
String		is_dep_tables			
//String		is_job_id		// 03/26/01	GaryR	Stars 4.7
String		is_left_over_tbl_types[]

// Pattern ID associated with the pattern template
String		is_pattern_id
String		is_pattern_name

String		is_subset_name

// Table types used in dw_criteria or dw_columns
String		is_tbl_retrieve[]

// Rel_type (GP=Main, DP=Dependent) for is_tbl_retrieve
String		is_rel_type[]

// Base types for is_tbl-retrieve[]
String		is_base_type[]

String		is_tbl_type[]

// Pattern ID from patt_cntl
String		is_user_pattern_id

// Invoice type associated with the pattern
String		is_inv_type

sx_pattern_info	istr_pattern_info
sx_subset_options	istr_sub_opt

// NVO to create the pattern SQL
u_nvo_pattern_sql	inv_pattern_sql

// Datastores used for creating a subset
n_ds		ids_bg_sql_line
n_ds		ids_bg_step_cntl
n_ds		ids_dependent_tables

// Filter string created in ue_retrieve_field_dddw
String		is_filter

//	01/17/03	GaryR	Track 4535c	Allow removal of columns not in criteria
String	is_inv_types[]

//	03/13/03	GaryR	Track 3457d	Retrieve the list instead of filtering
String	is_list_sql
end variables

forward prototypes
public function integer wf_get_left_over_tbl_types ()
public function long wf_copy_dw_3_to_dw_2 ()
public function integer wf_sample_17_mark_hicn_rows ()
public function integer wf_sample_17_20_prep_hicn_rows ()
public function integer wf_sample_17_print_hicn_rows ()
public function integer wf_sample_20_print_hicn_rows ()
public function integer wf_sample_20_mark_rows_for_printing ()
public function integer wf_sample_20_find_proc_in_set (long al_consecutive_days, long al_last_row, long al_base_row, long al_index)
public function integer wf_add_is_tbl_type (string as_tbl_type)
public function boolean wf_is_1500_and_ub92 ()
public function integer wf_add_left_over_tbl_types (integer ai_tbl_count, ref integer ai_total_steps, datetime adtm_default_datetime)
public function string wf_get_parm_label (string as_patt_field, string as_tbl_type, string as_parm_name)
public function integer wf_verify_table (string as_inv_type)
public function integer wf_add_level (ref sx_subsetting_info astr_subsetting_info, string as_inv_type)
public function integer wf_load_subset_options ()
public function integer wf_add_column_headings ()
public function integer wf_dependency ()
public function integer wf_setup_proc_codes ()
public subroutine wf_get_sql_columns ()
public function integer wf_labels ()
public function integer wf_defaultlevelcolumns ()
public function integer wf_get_main_invoice (ref string as_inv_type[])
public function integer wf_get_crit_invoices (ref string as_inv_types[])
end prototypes

event ue_verify_case_id;//*********************************************************************************
// Script Name:	ue_verify_case_id
//
//	Arguments:		as_case_id
//
// Returns:			Integer
//
//	Description:	
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc
String		ls_case_id,		&
				ls_case_spl,	&
				ls_case_ver,	&
				ls_msg
n_cst_case	lnv_case

ls_case_id	=	Left (as_case_id, 10)
ls_case_spl =	Mid (as_case_id, 11, 2)
ls_case_ver =	Mid (as_case_id, 13, 2)

lnv_case	=	Create	n_cst_case
li_rc		=	lnv_case.uf_valid_case (ls_case_id,		&
												ls_case_spl,	&
												ls_case_ver)

Choose Case	li_rc
	Case 0
		ls_msg	=	lnv_case.uf_edit_case_security(ls_case_id,	&
																ls_case_spl,	&
																ls_case_ver)
		IF Len (ls_msg)	>	0	THEN
			MessageBox ("Security Error", ls_msg)
			li_rc = -1
		END IF
	Case -1
		MessageBox ('Error', 'Active case '	+	as_case_id	+	' not found. Select a valid case')
	Case -2
		MessageBox ('Error', 'Active case '	+	as_case_id	+	' has been deleted. Select another case')
	Case -3
		MessageBox ('Error', 'Active case '	+	as_case_id	+	' has been closed. Select another case')
	Case -4
		MessageBox ('Error', 'Error verifying case ID.')
End Choose


IF	IsValid (lnv_case)			THEN
	Destroy	lnv_case
END IF

Return	li_rc


end event

event ue_fill_timeframe_dddw;//*********************************************************************************
// Script Name:	ue_fill_timeframe_dddw
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Fill the timeframe DDDWs based on the selected columns in
//						dw_criteria.  It will initialize dw_timeframe.
//
//	Notes:			Even if there are revenue columns (CR) selected in the criteria,
//						these columns cannot be included in the drop-down.  The timeframe
//						data can only handle non-revenue columns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_timeframe_button

Long		ll_row,				&
			ll_criteria_row,	&
			ll_rowcount,		&
			ll_opt_row,			&
			ll_find_row

String	ls_find,				&
			ls_tbl_type,		&
			ls_col_name,		&
			ls_col_desc

// Reset ids_dddw_timeframe so it can be refreshed
ids_dddw_timeframe.Reset()

ll_rowcount	=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR ll_criteria_row = 1 TO ll_rowcount
	ls_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_criteria_row]
	ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_criteria_row]
	ls_col_desc		=	tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_criteria_row]
	// If the column name is blank (last row), then ignore it.
	IF	Trim (ls_col_name)	=	''		THEN
		Continue
	END IF
	// If the column is a revenue column, don't add it.
	IF	ls_tbl_type	=	is_revenue_code		THEN
		Continue
	END IF
	// If the DDDW already has this column, don't add it.
	ls_find			=	"tbl_type = '"	+	ls_tbl_type	+	&
							"' and column = '"	+	ls_col_name	+	"'"
	ll_find_row		=	ids_dddw_timeframe.Find (ls_find, 1, ids_dddw_timeframe.RowCount() )
	IF	ll_find_row	=	0		THEN
		// This column does not exist in the DDDW.  Add it.
		ll_row		=	ids_dddw_timeframe.InsertRow(0)
		ids_dddw_timeframe.object.tbl_type [ll_row]	=	ls_tbl_type
		ids_dddw_timeframe.object.column [ll_row]		=	ls_col_name
		ids_dddw_timeframe.object.field [ll_row]		=	ls_col_desc
	END IF
NEXT

ll_opt_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

li_timeframe_button	=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_opt_row]

IF	li_timeframe_button	=	0		THEN
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_opt_row]		=	1
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_opt_row]	=	'N'
	This.Event	ue_load_timeframe()
ELSE
	// Determine if the 4th button is to be allowed by updating column row4_desc.
	This.Event	ue_timeframe_edit_rb4()
END IF



end event

event ue_select();//*********************************************************************************
// Script Name:	ue_select
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern is selected.  This
//						script will clear out the data from the prior pattern (after
//						editing for saving), and load the data in the tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	02/23/01	FDG	Stars 4.7	Make patt_id upper case because of case-sensitivity
//	09/21/01	FDG	Stars 4.8.1.	Don't allow updates when the associated case is
//						closed or deleted.
//	12/21/01	FDG	Track 2497.  Make lnv_case local to prevent memory leaks
//	05/21/02	GaryR	Track 3049d	Problems viewing patterns
//	01/02/04	GaryR	Track 3144d	Remove the case validation, it's done at retrieval
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

Integer	li_rc,				&
			li_tables,			&
			li_idx

Long		ll_row,				&
			ll_rowcount

String	ls_patt_id,			&
			ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver,		&
			ls_inv_type,		&
			ls_link_name,		&
			ls_patt_type,		&
			ls_subc_tables,	&
			ls_col_desc

// FDG 09/21/01
Boolean	lb_enabled,			&
			lb_valid_case	=	TRUE


//	Determine if any prior changes need to be saved

li_rc	=	This.Event	CloseQuery()

IF	li_rc	<>	0		THEN
	Return
END IF

ll_row	=	tab_patt.tabpage_list.dw_list.GetSelectedRow(0)

IF	ll_row	<	1		THEN
	Return
END IF

tab_patt.tabpage_list.dw_list.SetRow (ll_row)

ls_patt_id		=	Upper (tab_patt.tabpage_list.dw_list.object.patt_id [ll_row])		// FDG 02/23/01
ls_link_name	=	tab_patt.tabpage_list.dw_list.object.case_link_link_name [ll_row]
ls_case_id		=	tab_patt.tabpage_list.dw_list.object.case_link_case_id [ll_row]
ls_case_spl		=	tab_patt.tabpage_list.dw_list.object.case_link_case_spl [ll_row]
ls_case_ver		=	tab_patt.tabpage_list.dw_list.object.case_link_case_ver [ll_row]
ls_patt_type	=	tab_patt.tabpage_list.dw_list.object.patt_type [ll_row]

// If this window is performing a lookup, then close this window and
//	return the selected pattern.
IF	istr_sub_opt.patt_struc.come_from	=	'LOOKUP'		THEN
	CloseWithReturn (This, ls_link_name)
	Return
END IF

is_inv_type			=	tab_patt.tabpage_list.dw_list.object.rel_type [ll_row]
is_pattern_name	=	tab_patt.tabpage_list.dw_list.object.case_link_link_name [ll_row]

// Clear out the data that was set from the previous pattern.  This should occur
//	after all edits are done.
This.Event	ue_clear_dws()

// Retrieve the data and display them on the tabs.

IF	ls_patt_id	=	ics_generic			&
OR	ls_patt_id	=	ics_filter_pat		THEN
	// Generic and filter_pat only exists for 'ML' in patt_cntl
	ls_inv_type	=	'ML'
ELSE
	ls_inv_type	=	is_inv_type
END IF

ll_row		=	tab_patt.tabpage_criteria.dw_patt_cntl.Retrieve(ls_patt_id, ls_inv_type)
tab_patt.tabpage_criteria.dw_patt_cntl.ScrolltoRow (ll_row)

// Recompute the invoice types associated with the selected pattern and re-retrieve
//	the data associated with these invoice types (dw_available and criteria dddw)
This.Event	ue_retrieve_dw_available()

// Determine if this pattern is a pattern template (i.e. Pat0000005) or
//	a user-defined template.  For pattern templates, some of the d/ws
//	get inserted.  For user-defined patterns, these d/ws get retrieved.

ids_case_link.Reset()		// Remove prior data from case_link

IF	ls_patt_type	=	ics_user_pattern		THEN
	//	User-defined pattern 
	//	Save the pattern ID read from patt_cntl for this window's title.
	is_user_pattern_id	=	ls_patt_id
	// Retrieve the data
	ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.Retrieve (ls_patt_id)
	
	//	Set the description field
	FOR ll_row = 1 TO ll_rowcount
		ls_col_desc = tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type[ll_row] + &
						"." + tab_patt.tabpage_criteria.dw_criteria.object.field_description[ll_row]
		tab_patt.tabpage_criteria.dw_criteria.object.column_description[ll_row] = ls_col_desc
	NEXT
	
	ll_rowcount		=	tab_patt.tabpage_options.dw_patt_options.Retrieve (ls_patt_id)
	tab_patt.tabpage_options.dw_patt_options.ScrolltoRow (ll_rowcount)
	// Load the Report title from dw_patt_options
	This.Event	ue_custom_load_title()
	// Get the case_link data for this pattern
	ll_rowcount		=	ids_case_link.Retrieve (ls_patt_id)
	// Set is_pattern_id to the pattern template's pattern_id
	is_pattern_id	=	Upper (tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_rowcount])	// FDG 02/23/01
	// Retrieve the pattern from patt_rel
	ll_rowcount		=	ids_patt_rel.Retrieve (ls_patt_id)
	// Enable the link RMM
	This.Event	ue_enable_link (TRUE)
	// FDG 09/21/01 - Determine if the associated case is closed/deleted
	// FDG 12/21/01 begin
	n_cst_case		lnv_case		// FDG 12/21/01
	lnv_case	=	CREATE	n_cst_case
	lb_valid_case	=	lnv_case.uf_edit_case_closed (ls_case_id, ls_case_spl, ls_case_ver)
	Destroy	lnv_case
	// FDG 12/21/01 end
ELSE
	// Pattern template - insert the data.  Do not insert the criteria until ue_format_criteria
	//	is executed (called from ue_format_tabs)
	is_pattern_id	=	ls_patt_id
	is_user_pattern_id	=	''
	ll_row			=	tab_patt.tabpage_options.dw_patt_options.InsertRow(0)
	tab_patt.tabpage_options.dw_patt_options.ScrollToRow (ll_row)
	tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_row]	=	ls_patt_id
	li_tables		=	UpperBound (istr_sub_opt.patt_struc.table_type)
	FOR	li_idx	=	1	TO	li_tables
		ls_subc_tables	=	ls_subc_tables	+	'+'	+	istr_sub_opt.patt_struc.table_type [li_idx]
	NEXT
	ls_subc_tables	=	Mid (ls_subc_tables, 2)		// Remove the leading '+'
	tab_patt.tabpage_options.dw_patt_options.object.subc_tables [ll_row]	=	ls_subc_tables
	// Set the default report title in dw_title.
	This.event	ue_custom_default_title()
	// Disable the link RMM
	This.Event	ue_enable_link (FALSE)
	lb_valid_case	=	TRUE			// FDG 09/21/01
END IF

// Determine if the notes picture is to be displayed on the criteria tab.
This.Event	ue_edit_display_notes()

// Format the data on the tabs
This.Event	ue_format_tabs()

// Enable/Disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()

// Display the Criteria tab
tab_patt.SelectTab (ici_criteria)

// Make the selected case_id (for a user defined pattern) the active case.
IF	 ls_patt_type	=	ics_user_pattern		&
AND Trim (ls_case_id)	<>	''					&
AND Upper (ls_case_id)	<>	'NONE'			THEN
	gv_active_case	=	Trim (ls_case_id	+	ls_case_spl	+	ls_case_ver)
	is_case_id		=	ls_case_id
	is_case_spl		=	ls_case_spl
	is_case_ver		=	ls_case_ver
END IF

// If selecting a filter pattern, disallow any save and export capabilities.
IF	is_pattern_id	=	ics_filter_pat		THEN
	This.Event	ue_enable_link (FALSE)
	This.Event	ue_enable_save_userpattern (FALSE)
	This.Event	ue_enable_saveas (FALSE)
	This.Event	ue_enable_export (FALSE)
ELSE
	//This.Event	ue_enable_link (TRUE)
	This.Event	ue_enable_save_userpattern (TRUE)
	This.Event	ue_enable_saveas (TRUE)
	This.Event	ue_enable_export (TRUE)
END IF

// FDG 09/21/01 begin - Don't allow changes to a user-defined pattern if its associated
//								case is closed or deleted.
IF	lb_valid_case	=	TRUE		THEN
	// Allow updates.  However, prior edits may have enabled/disabled certain menu items
	This.Event	ue_enable_update (TRUE)
	lb_enabled	=	im_patt_criteria.m_dummyitem.m_link.enabled
	This.Event	ue_enable_link (lb_enabled)
	lb_enabled	=	im_patt_criteria.m_dummyitem.m_save.m_userpattern.enabled
	This.Event	ue_enable_save_userpattern (lb_enabled)
	lb_enabled	=	im_patt_criteria.m_dummyitem.m_saveas.enabled
	This.Event	ue_enable_saveas (lb_enabled)
	lb_enabled	=	im_patt_criteria.m_dummyitem.m_save.m_patternreportandcreatesubset.enabled
ELSE
	// Invalid case.  Do not allow updates
	This.Event	ue_enable_update (FALSE)
END IF
// FDG 09/21/01 end

// Reset the window's title
This.Event	ue_initialize_window()


end event

event ue_clear_dws;//*********************************************************************************
// Script Name:	ue_clear_dws
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will clear the datawindows on the tabs.  It will
//						also clear out any instance variables set from the prior
//						pattern.
//
//	Note:				Make sure any edits occur before clearing out this data.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

//	Clear out the datawindows and datastores
This.Event	ue_reset_dw_criteria()
tab_patt.tabpage_criteria.dw_patt_cntl.Reset()
tab_patt.tabpage_options.dw_patt_options.Reset()
tab_patt.tabpage_timeframe.dw_timeframe.Reset()
tab_patt.tabpage_report.dw_report.Reset()
tab_patt.tabpage_custom.dw_title.Reset()

ids_case_link.Reset()
ids_patt_rel.Reset()
ids_patt_columns.Reset()

This.Event	ue_notes_clear()

// Clear out the contents of dw_selected and move them back to dw_available
This.Event	ue_custom_remove_all()

// Clear out the previously set user-defined pattern ID
is_user_pattern_id	=	''

// Reset the flag stating that the options tab was displayed
ib_options_tab	=	FALSE

// Clear out the last criteria row used.
ii_last_row_label	=	0

// Clear out cbx_not
tab_patt.tabpage_criteria.cbx_not.checked	=	FALSE

// Clear out any instance variables set from the prior pattern
sx_pattern_info	lstr_pattern_info




end event

event ue_load_timeframe;//*********************************************************************************
// Script Name:	ue_load_timeframe
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern is selected and
//						when the timeframe data is being cleared out.  This
//						script will load the datawindow on the Time Frame tab with
//						the data from dw_patt_options.  dw_timeframe is an external
//						source d/w used to enter the timeframe data.  As data is
//						entered in dw_timeframe, it is copied into dw_patt_options.
//
//	Note:				This script assumes that data exists in dw_patt_options
//						either thru a retrieval or by an insert.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_1500,				&
			lb_ub92

Long		ll_row,				&
			ll_rowcount,		&
			ll_opt_row,			&
			ll_crit_row,		&
			ll_num_of_days

Integer	li_timeframe_button

String	ls_from_thru,		&
			ls_tbl_type_1,		&
			ls_field_1,			&
			ls_column_1,		&
			ls_tbl_type_2,		&
			ls_field_2,			&
			ls_column_2

//	Determine if a row must be inserted into dw_timeframe
ll_rowcount	=	tab_patt.tabpage_timeframe.dw_timeframe.RowCount()

IF	ll_rowcount	=	0		THEN
	ll_rowcount	=	tab_patt.tabpage_timeframe.dw_timeframe.InsertRow(0)
	tab_patt.tabpage_timeframe.dw_timeframe.ScrollToRow(ll_rowcount)
END IF

ll_row	=		ll_rowcount

ll_opt_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

li_timeframe_button	=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_opt_row]


// Copy the data.
ls_from_thru		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_opt_row]
ls_tbl_type_1		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_opt_row]
ls_field_1			=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_opt_row]
ls_column_1			=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_opt_row]
ls_tbl_type_2		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_opt_row]
ls_field_2			=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_opt_row]
ls_column_2			=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_opt_row]
ll_num_of_days		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_opt_row]

//	Initialize the entire d/w
tab_patt.tabpage_timeframe.dw_timeframe.Reset()
ll_row	=	tab_patt.tabpage_timeframe.dw_timeframe.InsertRow(0)
tab_patt.tabpage_timeframe.dw_timeframe.ScrollToRow (ll_row)

tab_patt.tabpage_timeframe.dw_timeframe.object.button [ll_row]	=	li_timeframe_button
tab_patt.tabpage_timeframe.dw_timeframe.object.from_date_ind [ll_row]	=	ls_from_thru
//tab_patt.tabpage_timeframe.dw_timeframe.object.row1_days [ll_row]	=	0
//tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col1 [ll_row]	=	''
//tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col2 [ll_row]	=	''
//tab_patt.tabpage_timeframe.dw_timeframe.object.row2_days [ll_row]	=	0
//tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col1 [ll_row]	=	''
//tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col2 [ll_row]	=	''
//tab_patt.tabpage_timeframe.dw_timeframe.object.row3_days [ll_row]	=	0
//tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col1 [ll_row]	=	''
//tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col2 [ll_row]	=	''

// Determine if the data has to be moved.  If a pattern template was
//	selected or the original pattern was not a generic pattern, then there  
//	is no data to move.  This is determined by checking the timeframe_button value.

IF	li_timeframe_button	=	0		THEN
	// No timeframe data to copy.  Get out.
	Return
END IF

CHOOSE CASE li_timeframe_button
	CASE 1
		//	1st row selected
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_days [ll_row]		=	ll_num_of_days
		IF	Len (ls_column_1)	>	0	THEN
			tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col1 [ll_row]	=	ls_tbl_type_1	+	'.'	+	ls_field_1
		END IF
		IF	Len (ls_column_2)	>	0	THEN
			tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col2 [ll_row]	=	ls_tbl_type_2	+	'.'	+	ls_field_2
		END IF
	CASE 2
		//	2nd row selected
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_days [ll_row]		=	ll_num_of_days
		IF	Len (ls_column_1)	>	0	THEN
			tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col1 [ll_row]	=	ls_tbl_type_1	+	'.'	+	ls_field_1
		END IF
		IF	Len (ls_column_2)	>	0	THEN
			tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col2 [ll_row]	=	ls_tbl_type_2	+	'.'	+	ls_field_2
		END IF
	CASE 3
		//	3rd row selected
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_days [ll_row]		=	ll_num_of_days
		IF	Len (ls_column_1)	>	0	THEN
			tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col1 [ll_row]	=	ls_tbl_type_1	+	'.'	+	ls_field_1
		END IF
		IF	Len (ls_column_2)	>	0	THEN
			tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col2 [ll_row]	=	ls_tbl_type_2	+	'.'	+	ls_field_2
		END IF

END CHOOSE

// Determine if the 4th button is to be allowed by updating column row4_desc.
This.Event	ue_timeframe_edit_rb4()

	

end event

event ue_edit_enable_report;//*********************************************************************************
// Script Name:	ue_edit_enable_report
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will determine if the Report tab is to be
//						disabled.  A row is read in sys_cntl (cntl_Id = 'SCHEDULE')
//						to determine this.  Also, if there are no selected rows
//						for a Generic pattern, then the tab is to be disabled.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_cntl_no

Long		ll_row,				&
			ll_rowcount

String	ls_patt_cond

// Track #2005.  If coming from Query Engine (background subset), then
//	disable the tab.
IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	THEN
	tab_patt.tabpage_report.enabled	=	FALSE
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

// If a Generic or filter pattern has no rows in dw_selected, then disable the tab

IF	is_pattern_id	=	ics_generic		&
OR	is_pattern_id	=	ics_filter_pat	THEN
	ll_rowcount	=	tab_patt.tabpage_custom.dw_selected.RowCount()
	IF	ll_rowcount	=	0		THEN
		tab_patt.tabpage_report.enabled	=	FALSE
		// Enable/Disable the Next and Prev buttons
		This.Event	ue_edit_enable_prev_next()
		Return
	END IF
END IF


SELECT 	Cntl_No
INTO		:li_cntl_no
FROM		Sys_Cntl
WHERE		Cntl_Id = 'SCHEDULE'
USING		stars2ca;

IF	li_cntl_no = 1								&
OR Stars2ca.of_check_status() = 100		THEN
	tab_patt.tabpage_report.enabled	=	FALSE
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

IF	Stars2ca.SQLCode	<>	0		THEN
	MessageBox ('Error', 'In w_sampling_analysis_new.ue_edit_enable_report, '	+	&
					' cannot retrieve sys_cntl where cntl_id = SCHEDULE')
	Return
END IF

// If patt_cond = '%BACKGROUND' then disable the tab

ll_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

IF	ll_row	=	0		THEN
	// No rows in dw_patt_cntl.  This can occur when selecting a pattern
	//	and event ue_clear_dws is clearing out existing data.  Disable it 
	// for now.
	tab_patt.tabpage_report.enabled	=	FALSE
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

ls_patt_cond		=	Upper (tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_cond [ll_row] )

IF Match (ls_patt_cond, ics_background)				&
OR	istr_sub_opt.patt_struc.come_from = 'CRIT_LINK'	THEN
	tab_patt.tabpage_report.enabled	=	FALSE
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

tab_patt.tabpage_report.enabled	=	TRUE

// Enable/Disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()



end event

event ue_get_subset_name;//*********************************************************************************
// Script Name:	ue_get_subset_name
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Get the subset name from case_link.  This is based from case ID.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

String	ls_subset_name

sx_subset_ids			lstr_subset_ids		

ls_subset_name	=	is_subset_name
is_subset_name	=	''
	
lstr_subset_ids.subset_case_id	=	is_case_id
lstr_subset_ids.subset_case_spl	=	is_case_spl
lstr_subset_ids.subset_case_ver	=	is_case_ver
lstr_subset_ids.subset_id			=	istr_sub_opt.patt_struc.subset_id

inv_subset_functions.uf_set_structure (lstr_subset_ids)
	
li_rc	=	inv_subset_functions.uf_retrieve_subset_name()

IF li_rc	<	0		THEN 
	Return
END IF

lstr_subset_ids	=	inv_subset_functions.uf_get_structure()

is_subset_name	=	lstr_subset_ids.subset_name

IF	is_subset_name	=	''		THEN
	is_subset_name	=	ls_subset_name
END IF


end event

event ue_set_inv_type_dddw;//*********************************************************************************
// Script Name:	ue_set_inv_type_dddw
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	The invoice type DDDW in dw_parms is an external source d/w.
//						This script will load this DDDW with the possible invoice types.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_i,			&
			li_j,			&
			li_rc,		&
			li_tables

Long		ll_row,		&
			ll_rc,		&
			ll_rowcount

String	ls_desc,		&
			ls_inv_type

DataWindowChild	ldwc

li_tables	=	UpperBound(istr_sub_opt.patt_struc.table_type)

IF li_tables = 0		THEN
	MessageBox ('ERROR','Unable to open window, subset tables not passed correctly')
	Return -1
END IF

IF	istr_sub_opt.patt_struc.table_type [li_tables]	=	''		THEN
	li_tables --
END IF

// When an ML subset is being created and there are no records selected for one of the 
// invoice types, a subset table for that invoice type is not created. If the pattern sql
// contains a reference to this table an error will occur since the table will not be 
// found.  An edit must be placed in this function to remove those 
// table types in an ML subset that do not contain records. 

String	ls_tbl_type[]
String	ls_clear_array[]

ls_tbl_type	=	istr_sub_opt.patt_struc.table_type

// Clear out the table_type array because it will be reloaded
istr_sub_opt.patt_struc.table_type	=	ls_clear_array

FOR li_i	=	1	TO	li_tables
	IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	&
	OR	istr_sub_opt.patt_struc.come_from	=	'LOOKUP'		&
	OR	istr_sub_opt.patt_struc.come_from	=	'CRITERIA'	THEN
		li_j ++
		istr_sub_opt.patt_struc.table_type [li_j]	=	ls_tbl_type [li_i]
	ELSE
		// Determine if the invoice type exists in sub_step_cntl
		li_rc	=	This.wf_verify_table (ls_tbl_type [li_i])
		IF	li_rc	=	1		THEN
			li_j ++
			istr_sub_opt.patt_struc.table_type [li_j]	=	ls_tbl_type [li_i]
		END IF
	END IF
NEXT

// Reset the number of tables
li_tables	=	UpperBound(istr_sub_opt.patt_struc.table_type)

// If there is only one table left, then the subset is no longer
// an ML subset.
IF	istr_sub_opt.patt_struc.subset_table_type	=	'ML'		&
AND li_tables	<	2												THEN
	istr_sub_opt.patt_struc.subset_table_type	=	istr_sub_opt.patt_struc.table_type [1]
END IF

// Get the description for each invoice type (including 'ML') and fill in the DDDW

tab_patt.tabpage_list.dw_parms.GetChild ('invoice_type', ldwc)

ldwc.Reset()		// Clear out any previously set data.

IF	istr_sub_opt.patt_struc.subset_table_type	=	'ML'	THEN
	// Get the description for 'ML' and add it to the DDDW
	ls_desc	=	inv_pattern_sql.uf_get_tbl_desc (istr_sub_opt.patt_struc.subset_table_type)
	ll_row	=	ldwc.InsertRow(0)
	ldwc.SetItem (ll_row, 'inv_type', istr_sub_opt.patt_struc.subset_table_type)
	ldwc.SetItem (ll_row, 'description', ls_desc)
END IF

//	Get the description from each of the invoice types & add it to the DDDW
FOR li_i	=	1	TO	li_tables
	ll_rc	=	fx_filter_stars_rel_id_2 (istr_sub_opt.patt_struc.table_type[li_i])
	IF ll_rc	<	1		THEN
		MessageBox ('Database Error', 'In ue_set_inv_type_dddw, unable to read dictionary '	+	&
						'where elem_type = TB and elem_tbl_type = '	+	istr_sub_opt.patt_struc.table_type[li_i])
		Stars2ca.of_commit()
		Return	-1
	END IF
	ls_desc	=	w_main.dw_stars_rel_dict.GetItemString (1, "dictionary_elem_desc")
	ll_row	=	ldwc.InsertRow(0)
	ldwc.SetItem (ll_row, 'inv_type', istr_sub_opt.patt_struc.table_type[li_i])
	ldwc.SetItem (ll_row, 'description', ls_desc)
NEXT

// Set the invoice type in dw_parms

ll_row	=	tab_patt.tabpage_list.dw_parms.GetRow()

IF	istr_sub_opt.patt_struc.subset_table_type	=	'ML'	THEN
	ls_inv_type	=	istr_sub_opt.patt_struc.subset_table_type
ELSE
	ls_inv_type	=	istr_sub_opt.patt_struc.table_type [1]
END IF

tab_patt.tabpage_list.dw_parms.object.invoice_type [ll_row]	=	ls_inv_type

// If only one row exists in the DDDW, then protect invoice type
ll_rowcount		=	ldwc.RowCount()

IF	ll_rowcount	<	1		THEN
	tab_patt.tabpage_list.dw_parms.object.invoice_type.protect		=	1
ELSE
	tab_patt.tabpage_list.dw_parms.object.invoice_type.protect		=	0
END IF

// Filter the patterns DDDW based on this invoice type
This.Event	ue_filter_patterns (ls_inv_type)

// Free up any locks on the read data
Stars2ca.of_commit()


Return	1
end event

event ue_filter_patterns(string as_inv_type);//*********************************************************************************
// Script Name:	ue_filter_patterns
//
//	Arguments:		as_inv_type - The invoice type from dw_parms.
//
// Returns:			None
//
//	Description:	Filter the patterns DDDW in dw_parms based on the invoice type.
//						The only entries allowed in the DDDW are pattern templates.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	03/01/04	GaryR	Track 3886d	This code makes STARS crash under PB 8.0.4.10501
//
//*********************************************************************************

Integer	li_rc,					&
			li_tables,				&
			li_idx

Long		ll_row,					&
			ll_parm_row,			&
			ll_rowcount,			&
			ll_rc

String	ls_filter,				&
			ls_base_type[],		&
			ls_patt_base_type,	&
			ls_patt_type,			&
			ls_patt_id

DataWindowChild	ldwc

//ll_parm_row	=	tab_patt.tabpage_list.dw_parms.GetRow()
//
//IF	ll_parm_row	=	0		THEN
//	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_filter_patterns, '	+	&
//					'cannot get the current row in dw_parms')
//	Return
//END IF
//
//ls_patt_type	=	tab_patt.tabpage_list.dw_parms.object.patt_type [ll_parm_row]
//ls_patt_id		=	tab_patt.tabpage_list.dw_parms.object.patt_id [ll_parm_row]
//
//li_rc	=	tab_patt.tabpage_list.dw_parms.GetChild ('patt_id', ldwc)
//
//ls_filter	=	"rel_type = '"	+	as_inv_type	+	"' or patt_id = ''"
//
////	Remove the old filter and generate the new filter.
//li_rc	=	ldwc.SetFilter('')
//li_rc	=	ldwc.Filter()
//li_rc	=	ldwc.SetFilter(ls_filter)
//li_rc	=	ldwc.Filter()
//
//// Re-sort the data
//li_rc	=	ldwc.SetSort ("patt_id A")
//li_rc	=	ldwc.Sort()
end event

event ue_edit_options_tab;//*********************************************************************************
// Script Name:	ue_edit_options_tab
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Edit the contents of the options tab.  If the original
//						pattern is not a Generic pattern, then this tab is disabled.
//						Certain columns will be invisible or disabled depending on
//						its invoice type.  Column subc_tables (in dw_patt_options)
//						will determine the invoice type(s).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_sets	=	FALSE

Integer	li_rc

Long		ll_row,					&
			ll_rowcount,			&
			ll_find_row

String	ls_subc_tables,		&
			ls_patt_template,		&
			ls_find,					&
			ls_field_set

DataWindowChild	ldwc_field_name

ll_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_row	=	0		THEN
	MessageBox ('Application Error', 'Cannot get current row # in w_sampling_analysis_new.ue_edit_options_tab')
	Return
END IF

ls_subc_tables		=	Trim (tab_patt.tabpage_options.dw_patt_options.object.subc_tables [ll_row] )

IF	is_pattern_id	=	ics_generic		THEN
	// The original pattern template is Generic.  Enable the tab.
	tab_patt.tabpage_options.enabled	=	TRUE
ELSE
	//	The original pattern template is a numbered pattern.  Disable the tab and get out.
	tab_patt.tabpage_options.enabled	=	FALSE
	// Initialize the data in dw_patt_options
	tab_patt.tabpage_options.dw_patt_options.object.claim_ind [ll_row]	=	''
	tab_patt.tabpage_options.dw_patt_options.object.day_ind [ll_row]	=	''
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind [ll_row]	=	''
	tab_patt.tabpage_options.dw_patt_options.object.patient_ind [ll_row]	=	''
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind [ll_row]	=	''
	tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind [ll_row]	=	''
	Return
END IF

// From this point forward, we are dealing with a Generic pattern.

// Initialize the data in dw_patt_options.  This should be initialized 
//	when inserting a row.  However, it has to be re-initialized when the
//	clear button is clicked.
//tab_patt.tabpage_options.dw_patt_options.object.claim_ind [ll_row]	=	'A'
//tab_patt.tabpage_options.dw_patt_options.object.day_ind [ll_row]	=	'A'
//tab_patt.tabpage_options.dw_patt_options.object.tooth_ind [ll_row]	=	'A'
//tab_patt.tabpage_options.dw_patt_options.object.patient_ind [ll_row]	=	'S'
//tab_patt.tabpage_options.dw_patt_options.object.combination_ind [ll_row]	=	'A'
//tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind [ll_row]	=	'G'

//IF	Len (ls_subc_tables)	>	2		THEN
IF	is_inv_type		=	'ML'		THEN
	// ML pattern
	tab_patt.tabpage_options.dw_patt_options.object.claim_ind.protect	=	1
	tab_patt.tabpage_options.dw_patt_options.object.patient_ind.protect	=	1
ELSE
	// This pattern is not an ML pattern
	tab_patt.tabpage_options.dw_patt_options.object.claim_ind.protect	=	0
	tab_patt.tabpage_options.dw_patt_options.object.patient_ind.protect	=	0
END IF

// If one or more "sets" exist in the criteria, then allow data entry into combination_ind

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_field_set	=	tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]
	ls_field_set	=	Left (ls_field_set, 3)
	IF	Lower (ls_field_set)	=	'set'		THEN
		lb_sets	=	TRUE
	END IF
NEXT

IF	lb_sets	=	TRUE		THEN
	// Sets exist in the criteria.  Allow data entry for combination_ind.
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind.protect		=	0
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind.visible		=	1
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind_t.visible	=	1
ELSE
	// No sets exist in the criteria.  Do not allow data entry for combination_ind.
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind.protect		=	1
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind.visible		=	0
	tab_patt.tabpage_options.dw_patt_options.object.combination_ind_t.visible	=	0
END IF

// Determine if 'Tooth' can be enabled.  'Tooth' only applies to dental patterns.

li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', ldwc_field_name)
ll_rowcount	=	ldwc_field_name.RowCount()

ls_find	=	"Upper(elem_name) = 'TOOTH'"

ll_find_row	=	ldwc_field_name.Find (ls_find, 1, ldwc_field_name.RowCount() )

IF	ll_find_row	>	0		THEN
	// A dental table type exists.  Allow the user to change 'Tooth'.
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind.protect		=	0
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind.visible		=	1
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind_t.visible	=	1
ELSE
	// A dental table type does not exist.  Disallow the user to change 'Tooth'.
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind.protect		=	1
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind.visible		=	0
	tab_patt.tabpage_options.dw_patt_options.object.tooth_ind_t.visible	=	0
END IF

// Enable/Disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()






end event

event ue_edit_timeframe_tab;//*********************************************************************************
// Script Name:	ue_edit_timeframe_tab
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is posted to when dw_criteria.field_description is
//						changed and when dw_patt_options.day_ind is changed.  It is
//						also triggered when a pattern is loaded.  This script will
//						determine if the timeframe tab is to be enabled.  The following
//						conditions must occur to enable the timeframe tab: 
//						1.	The original pattern must be a generic pattern.
//						2.	Two (non-revenue) fields must be selected in dw_criteria
//						3.	In dw_options, the Day must be 'Any' or 'Different'
//
//	Notes:			For the 2nd criteria listed above, the Time Frame tab can
//						be enabled if 2 non-revenue columns are selected and a
//						revenue column is selected.  However, this revenue column
//						cannot exist in the any of the drop-downs in the Time Frame
//						tab (event ue_fill_timeframe_dddw).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_fields,				&
			li_patt_count

Long		ll_row,					&
			ll_rowcount

String	ls_subc_tables,		&
			ls_patt_template,		&
			ls_day_ind,				&
			ls_col_name,			&
			ls_tbl_type,			&
			ls_description,		&
			ls_operator,			&
			ls_base_type,			&
			ls_value

ll_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_row	=	0		THEN
	MessageBox ('Application Error', 'Cannot get current row # in w_sampling_analysis_new.ue_edit_timeframe_tab')
	Return
END IF

ls_patt_template	=	tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_row]
ls_day_ind			=	tab_patt.tabpage_options.dw_patt_options.object.day_ind [ll_row]

IF	is_pattern_id	<>	ics_generic		THEN
	//	The original pattern template is a numbered or filter pattern.  Disable the tab and get out.
	tab_patt.tabpage_timeframe.enabled	=	FALSE
	This.Event	ue_clear_timeframe_data()
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

// From this point forward, we are dealing with a Generic pattern.

// Based on the data in dw_criteria, determine if the timeframe tab is
//	to be enabled

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

IF	ll_rowcount	<	1		THEN
	//	No criteria rows exist.  Disable the tab and get out
	tab_patt.tabpage_timeframe.enabled	=	FALSE
	This.Event	ue_clear_timeframe_data()
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]
	ls_description	=	tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_row]
	ls_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]
	IF	IsNull (ls_description)				&
	OR	Trim (ls_description)	=	''		THEN
		// Do not edit this row of criteria
		Continue
	END IF
	ls_operator	=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_row] )
	ls_value		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_value	[ll_row] )
	// Do not edit 'value' because 'value' cannot be set until the itemchanged event
	//	is completed.  If 'value' was included in this edit, the user would have to
	//	tab away from 'value' before the TimeFrame tab becomes enabled.
	IF	ls_operator	=	''		THEN
		li_fields	=	0		// Causes the tab to be disabled
		Exit
	END IF
	// Determine if this invoice type is a revenue code.
	// If so, the number of fields cannot be counted.
	//ls_base_type	=	inv_pattern_sql.uf_get_base_type (ls_tbl_type)
	//IF	ls_base_type	=	'UB92'	THEN
	//	li_fields	=	0
	//	Exit
	//END IF
	IF	ls_tbl_type			=	is_revenue_code	&
	AND is_revenue_code	<>	''						THEN
		// This column is a revenue code.  This cannot be counted as a column.
		Continue
	END IF
	li_fields ++
NEXT

// Free up any locks from reading data.
Stars2ca.of_commit()

// On the options tab, if 'Day' is 'Same', then disable the tab.
IF	ls_day_ind	=	ics_same		THEN
	tab_patt.tabpage_timeframe.enabled	=	FALSE
	This.Event	ue_clear_timeframe_data()
	// Enable/Disable the Next and Prev buttons
	This.Event	ue_edit_enable_prev_next()
	Return
END IF

IF	li_fields	>=	2		THEN
	tab_patt.tabpage_timeframe.enabled	=	TRUE
	// Because this event can be posted from dw_criteria.itemchanged, fill
	//	in the DDDWs in dw_timeframe
	This.Event	ue_fill_timeframe_dddw()
ELSE
	tab_patt.tabpage_timeframe.enabled	=	FALSE
	This.Event	ue_clear_timeframe_data()
END IF

// Enable/Disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()





end event

event ue_clear_timeframe_data;//*********************************************************************************
// Script Name:	ue_clear_timeframe_data
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Clear out the data on the timeframe tab by clearing out
//						the timeframe data in dw_patt_options.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long			ll_row

// Clear out the data in istr_pattern_info
istr_pattern_info.timeframe.from_thru			=	''
istr_pattern_info.timeframe.timeframe_btn		=	0
istr_pattern_info.timeframe.timeframe_fields[1].tbl_type	=	''
istr_pattern_info.timeframe.timeframe_fields[1].field		=	''
istr_pattern_info.timeframe.timeframe_fields[2].tbl_type	=	''
istr_pattern_info.timeframe.timeframe_fields[2].field		=	''
istr_pattern_info.timeframe.num_of_days		=	0

// Clear out the timeframe data in dw_patt_options
ll_row		=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_clear_timeframe_data, '	+	&
					'could not get the current row in dw_patt_options.')
	Return
END IF

tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_row]			=	0
tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_row]		=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]		=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row]			=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]		=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]		=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]			=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]		=	''
tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]	=	0

//	Reflect this data in the Timeframe tab
This.Event	ue_load_timeframe()





end event

event ue_update_timeframe_structure;//*********************************************************************************
// Script Name:	ue_update_timeframe_structure
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This script will get the timeframe data from dw_patt_options
//						to update istr_pattern_info.timeframe.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_button

Long			ll_row,				&
				ll_opt_row

ll_opt_row		=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_opt_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_update_timeframe_structure, '	+	&
					'could not get the current row in dw_patt_options.')
	Return
END IF

// Depending on which button is set, clear out the other data.
ll_row		=	tab_patt.tabpage_timeframe.dw_timeframe.GetRow()

li_button	=	tab_patt.tabpage_timeframe.dw_timeframe.object.button [ll_row]

CHOOSE CASE	li_button
	CASE	1
		// Clear out data for buttons 2 and 3
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_days [ll_row]	=	0
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_days [ll_row]	=	0
	CASE	2
		// Clear out data for buttons 1 and 3
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_days [ll_row]	=	0
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_days [ll_row]	=	0
	CASE	3
		// Clear out data for buttons 1 and 2
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_days [ll_row]	=	0
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_days [ll_row]	=	0
	CASE	4
		// Clear out data for buttons 1, 2 and 3
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row1_days [ll_row]	=	0
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row2_days [ll_row]	=	0
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col1 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_col2 [ll_row]	=	''
		tab_patt.tabpage_timeframe.dw_timeframe.object.row3_days [ll_row]	=	0
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_opt_row]	=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_opt_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_opt_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_opt_row]	=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_opt_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_opt_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_opt_row]	=	0
END CHOOSE

istr_pattern_info.timeframe.from_thru			=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_opt_row]
istr_pattern_info.timeframe.timeframe_btn		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_opt_row]
istr_pattern_info.timeframe.timeframe_fields[1].tbl_type	=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_opt_row]
istr_pattern_info.timeframe.timeframe_fields[1].field		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_opt_row]
istr_pattern_info.timeframe.timeframe_fields[2].tbl_type	=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_opt_row]
istr_pattern_info.timeframe.timeframe_fields[2].field		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_opt_row]
istr_pattern_info.timeframe.num_of_days		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_opt_row]

// Redraw dw_timeframe
tab_patt.tabpage_timeframe.dw_timeframe.SetRedraw (TRUE)

end event

event ue_format_tabs;//*********************************************************************************
// Script Name:	ue_format_tabs
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern is selected and when
//						a pattern is imported.  This event assumes that the datawindows
//						have been retrieved or inserted.  It also assumes that the
//						calling script has already set is_pattern_id and is_user_pattern_id.
//
//						This script will format the data on the tabs for the selected pattern.
//						This script will determine which tabs are to be enabled/disabled
//						and will move the data from dw_patt_options to dw_timeframe.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_revenue_moved

Integer	li_rc,				&
			li_tables,			&
			li_idx

Long		ll_row,				&
			ll_rowcount

String	ls_base_type

sx_pattern_info	lstr_pattern_info

// Clear out the pattern structure
istr_pattern_info	=	lstr_pattern_info

ll_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

// If the window operations window is opened, close it.
IF	IsValid (iw_uo_win)		THEN
	Close (iw_uo_win)
END IF

// Fill in the data for dw_timeframe (from dw_patt_options)
This.Event	ue_load_timeframe()

// Determine if the time frame tab is to be enabled.  If so, fill in
//	the DDDWs in this tab
This.Event	ue_edit_timeframe_tab()

// Enable the criteria, options and report tabs (in case they were previously disabled).
tab_patt.tabpage_criteria.enabled	=	TRUE
tab_patt.tabpage_report.enabled		=	TRUE

IF	is_pattern_id	=	ics_generic			&
OR	is_pattern_id	=	ics_filter_pat		THEN
	// Generic or filter pattern
	tab_patt.tabpage_custom.enabled		=	TRUE
	// A base type of '1500' (or ML pattern) will allow the user to enter 'Allwd Srvc'
	IF	is_inv_type	=	'ML'		THEN
		// Allow the user to enter 'Allwd Srvc'
		tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind.visible		=	1
		tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind_t.visible	=	1
		tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind.protect		=	0
	ELSE
		// Not an ML pattern.  Get the base type.
		inv_pattern_sql.uf_filter_stars_rel (is_inv_type)
		ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]
		IF	ls_base_type	=	'1500'		THEN
			tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind.visible		=	1
			tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind_t.visible	=	1
			tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind.protect		=	0
		ELSE
			tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind.visible		=	0
			tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind_t.visible	=	0
			tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind.protect		=	1
		END IF		
	END IF
	// Format the Custom Report Tab
	This.Event	ue_custom_load_selected()	
ELSE
	//	Not a generic pattern.  Disable the Options tab.
	tab_patt.tabpage_custom.enabled		=	FALSE
END IF

//	The 'Not In' checkbox is only visible for Filter patterns
IF	is_pattern_id	=	ics_filter_pat		THEN
	tab_patt.tabpage_criteria.cbx_not.visible	=	TRUE
ELSE
	tab_patt.tabpage_criteria.cbx_not.visible	=	FALSE
END IF

// Determine if the options tab (and its data) is to be enabled
This.Event	ue_edit_options_tab()

// Format the criteria d/w (and its DDDWs)
This.Event	ue_format_criteria()

// Determine if the report tab is to be enabled
This.event	ue_edit_enable_report()

// Determine if the 'Pattern Report and Create Subset' RMM is to
//	be enabled/disabled.
This.Event	ue_edit_enable_background()

// Reset the contents of dw_report
This.Event	ue_reset_dw_report()

// Reset the window title to include/exclude the pattern ID
This.Event	ue_initialize_window()

// Free up any locks resulting from reading data.
Stars2ca.of_commit()





end event

event ue_format_criteria;//*********************************************************************************
// Script Name:	ue_format_criteria
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern is being loaded (from
//						ue_format_tabs) or cleared.
//
//						This script will format the data and the DDDWs in dw_criteria.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/21/00	FDG	Track 2931 (4.5 SP1).  Filter patterns should have the operator
//						= 'in' and it should be protected.
//	02/23/01	FDG	Stars 4.7	Make patt_id upper case because of case-sensitivity
//
//*********************************************************************************

Boolean	lb_revenue_moved

Integer	li_rc,				&
			li_tables,			&
			li_idx,				&
			li_j,					&
			li_pos,				&
			li_line_num

Long		ll_row,				&
			ll_rowcount,		&
			ll_crit_row,		&
			ll_rc

String	ls_inv_type,		&
			ls_base_type,		&
			ls_filter,			&
			ls_revenue,			&
			ls_patt_field,		&
			ls_field_type,		&
			ls_col_name,		&
			ls_operator

n_ds		lds_patt_field

li_tables	=	UpperBound (istr_sub_opt.patt_struc.table_type)

// If the invoice type associated with the pattern has a revenue dependent
//	table, then the revenue columns must display also.

String	ls_temp[]

ls_temp [1]		=	is_inv_type

IF	is_inv_type	<>	'ML'	THEN
	ll_rc	=	inv_pattern_sql.uf_filter_stars_rel (is_inv_type)
	ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]
	IF	ls_base_type	=	'UB92'	THEN
		// UB92
		ls_revenue	=	inv_revenue.of_get_revenue (is_inv_type)
		// If coming from subset options, there will be a bg job
		//	with no entry yet in sub_step_cntl
		IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	THEN
			ls_temp [2]	=	ls_revenue
		ELSE
			li_pos	=	Pos (is_dep_tables, ls_revenue)
			IF	li_pos	>	0		THEN
				ls_temp [2]	=	ls_revenue
			END IF
		END IF
	END IF
END IF

// Field operator is disabled for a numbered pattern
//IF	is_pattern_id	=	ics_generic		THEN
//	tab_patt.tabpage_criteria.dw_criteria.object.field_operator.protect	=	0
//ELSE
//	tab_patt.tabpage_criteria.dw_criteria.object.field_operator.protect	=	1
//END IF

// A user-defined pattern has column field description protected.  This means that the DDDW
//	associated with this column is not necessary

IF	 is_user_pattern_id	=	''					&
AND ib_import				=	FALSE				THEN
	// Pattern template.  Insert the available criteria.
	// Retrieve patt_field to determine the # of criteria rows.
	lds_patt_field	=	CREATE	n_ds
	lds_patt_field.DataObject	=	'd_patt_field'
	lds_patt_field.SetTransObject (Stars2ca)
	ll_rowcount	=	lds_patt_field.Retrieve (is_pattern_id)
	// For each row in lds_patt_field, insert a row in dw_criteria
	ls_filter	=	"patt_id = '"	+	Upper( is_pattern_id )	+	"'"		// FDG 02/23/01
	// Reset dw_criteria
	This.Event	ue_reset_dw_criteria()
	FOR ll_row	=	1	TO	ll_rowcount
		ls_patt_field	=	Lower (lds_patt_field.object.patt_field [ll_row])
		li_line_num		=	lds_patt_field.object.line_num [ll_row]
		ls_field_type	=	lds_patt_field.object.field_type [ll_row]
		ll_crit_row		=	tab_patt.tabpage_criteria.dw_criteria.InsertRow(0)
		tab_patt.tabpage_criteria.dw_criteria.object.seq_num [ll_crit_row]	=	ll_crit_row
		IF	is_pattern_id	<>	ics_generic		THEN
			SELECT	field_oper
			INTO		:ls_operator
			FROM		patt_field_oper
			WHERE		patt_id	=	Upper( :is_pattern_id )
			AND		patt_field	=	Upper( :ls_patt_field )
			USING		Stars2ca;
			li_rc		=	Stars2ca.of_check_status()
			IF	li_rc	=	100		THEN
				// Stars 4.5 change.  Operand not found in patt_field_oper.  Default to '=' and allow it to change.
				tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_crit_row]	=	'='
				//tab_patt.tabpage_criteria.dw_criteria.object.field_operator.protect	=	0
			ELSE
				tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_crit_row]	=	ls_operator
			END IF
		ELSE
			// Generic pattern template.  Default the operator to '='.
			tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_crit_row]	=	'='
		END IF
		tab_patt.tabpage_criteria.dw_criteria.object.field_value [ll_crit_row]	=	''
		tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_crit_row]		=	ls_patt_field
		tab_patt.tabpage_criteria.dw_criteria.object.field_also [ll_crit_row]	=	ls_field_type
		// Stars 4.5 Change.  If this field exists in patt_field_parm, get the parm_name
		//	in patt_field_parm and set the column name in dw_criteria.
		
		// Filter the field_description DDDW by filtering ids_patt_field_parm.  This is
		// performed within the loop because if the DDDW only has 1 row, then the data
		//	is copied from the DDDW to dw_criteria.  It also determines if the operand
		// is going to be protected.
		This.Event	ue_filter_criteria_dddw (ll_row)
	NEXT
ELSE
	// User-defined pattern or a pattern is being imported.
	// Loop thru each read row.  If the column name is empty, then clear out
	// column_description.
	ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()
	FOR	ll_row	=	1	TO	ll_rowcount
		ls_col_name	=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]
		IF	IsNull (ls_col_name)			&
		OR	Trim (ls_col_name)	=	''	THEN
			tab_patt.tabpage_criteria.dw_criteria.object.column_description [ll_row]	=	''
		END IF
		// Filter the field_description DDDW by filtering ids_patt_field_parm.  This is
		// performed within the loop because if the DDDW only has 1 row, then the data
		//	is copied from the DDDW to dw_criteria.  It also determines if the operand
		// is going to be protected.
		This.Event	ue_filter_criteria_dddw (ll_row)
	NEXT
END IF								//	ls_patt_type <> ics_user_pattern

// Set the possible values in the column_description DDDW
This.Event	ue_retrieve_field_dddw()

// For a Filter pattern, set the 1st value to '@'
// FDG 06/21/00 - set the operator to 'in' and protect it.
IF	is_pattern_id	=	ics_filter_pat		THEN
	tab_patt.tabpage_criteria.dw_criteria.object.field_value [1]			=	'@'
	tab_patt.tabpage_criteria.dw_criteria.object.field_operator [1]		=	'IN'		// FDG 02/23/01
	tab_patt.tabpage_criteria.dw_criteria.object.protect_operand_ind [1]	=	'Y'
END IF

// Determine if 'field_description' is enabled (based on 'field_alone')
This.event	ue_protect_field_description()

// Set the 1st row in dw_criteria as the current row
tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (1)

// Make sure the DDDW displays the correct entries for the 1st criteria row.
ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()
IF	ll_rowcount	>	0		THEN
	This.Event	ue_filter_criteria_dddw (1)
END IF

// Fill in the 'field_lookup' column where applicable
This.Event	ue_lookup_exist('init')

// Determine if the Time Frame tab is to be enabled or disabled
This.Event	ue_edit_timeframe_tab()




end event

event ue_filter_criteria_dddw(long al_row);//*********************************************************************************
// Script Name:	ue_filter_criteria_dddw
//
//	Arguments:		al_row - Row # in dw_criteria
//
// Returns:			N/A
//
//	Description:	This event will filter the field_description DDDW in dw_criteria.
//						In ue_postopen, ids_patt_field_parm retrieves the data in
//						table patt_field_parm.
//
//	Notes:			Based on the # of rows in the DDDW (from patt_field_parm),
//						protect/unprotect field operator.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/13/00	FDG	Track 2923c (4.5 SP1).  If the column is specified as protected,
//						then don't filter it.
//	02/23/01	FDG	Stars 4.7	Make patt_id upper case because of case-sensitivity
//	12/05/07	GaryR	SPR 4773	Make provider numbered patterns NPI compliant
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

Integer		li_pos,						&
				li_upper,					&
				li_idx,						&
				li_rc,						&
				li_crit_seq

Long			ll_rc,						&
				ll_row,						&
				ll_new_row,					&
				ll_rowcount,				&
				ll_dwc_rowcount

String		ls_filter,					&
				ls_temp_filter,			&
				ls_retrieve_filter,		&
				ls_table_filter,			&
				ls_tbl_type,				&
				ls_col_name,				&
				ls_col_desc,				&
				ls_patt_field,				&
				ls_base_type,				&
				ls_compare_base_type,	&
				ls_revenue,					&
				ls_temp[],					&
				ls_patt_type,				&
				ls_protect

DataWindowChild	ldwc_field_name

// If the row # is zero, get out.  This can occur when resetting dw_criteria.
IF	al_row	=	0		THEN
	Return
END IF

// If the pattern is a User-defined pattern, there is no need
// to filter this DDDW
ll_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

IF	ll_row	=	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_filter_criteria_dddw, '	+	&
					'cannot get the current row in dw_patt_cntl.')
	Return
END IF

ls_patt_type		=	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_type [ll_row]

ls_patt_field	=	Upper(tab_patt.tabpage_criteria.dw_criteria.object.field_set [al_row])	// FDG 02/23/01
ls_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [al_row]
ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [al_row]
ls_protect		=	tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [al_row]

// FDG 06/13/00	Begin
// If the column is protected, there is no need to filter the DDDW

IF	Upper (ls_protect)	=	'Y'		THEN
	Return
END IF
// FDG 06/13/00	End

// FDG 02/23/01 - make patt_id upper-case because of Oracle case-insensitivity
ls_filter		=	"patt_id = '"	+	Upper( is_pattern_id )	+	&
						"' and patt_field = '"	+	Upper( ls_patt_field )	+	"'"

// Use the is_tbl_retrieve array (set in ue_format_criteria) to format
//	ls_retrieve_filter
li_upper			=	UpperBound (is_tbl_retrieve)
FOR li_idx	=	1	TO	li_upper
	ls_retrieve_filter	=	ls_retrieve_filter	+	" or tbl_type = '"	+	&
									is_tbl_retrieve [li_idx]		+	"'"
NEXT
// Remove the leading ' or ' and surround it with parenthesis
ls_retrieve_filter	=	Mid (ls_retrieve_filter, 5)
ls_retrieve_filter	=	"("	+	ls_retrieve_filter	+	")"


// Use the istr_sub_opt.patt_struc.table_type array to format
//	ls_table_filter
li_upper			=	UpperBound (istr_sub_opt.patt_struc.table_type)
FOR li_idx	=	1	TO	li_upper
	ls_table_filter	=	ls_table_filter	+	" or tbl_type = '"	+	&
								istr_sub_opt.patt_struc.table_type [li_idx]	+	"'"
NEXT
// Remove the leading ' or ' and surround it with parenthesis
ls_table_filter	=	Mid (ls_table_filter, 5)
ls_table_filter	=	"("	+	ls_table_filter	+	")"


// Generic and numbered patterns have different sets of rules for filtering

IF	is_pattern_id	=	ics_generic		THEN
	// Generic pattern

	// If the invoice type associated with the pattern has a revenue dependent
	//	table, then the revenue columns must display also.
	ls_temp [1]		=	is_inv_type
	ls_temp_filter	=	" and (tbl_type = '"	+	is_inv_type	+	"'"
	IF	is_inv_type	<>	'ML'	THEN
		ll_rc	=	inv_pattern_sql.uf_filter_stars_rel (is_inv_type)
		ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]
		IF	ls_base_type	=	'UB92'	THEN
			// UB92
			ls_revenue	=	inv_revenue.of_get_revenue (is_inv_type)
			// If coming from subset options, there will be a bg job
			//	with no entry yet in sub_step_cntl
			IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	THEN
				ls_temp [2]	=	ls_revenue
				ls_temp_filter	=	ls_temp_filter	+	" or tbl_type = '"	+	ls_revenue	+	"'"
			ELSE
				li_pos	=	Pos (is_dep_tables, ls_revenue)
				IF	li_pos	>	0		THEN
					ls_temp [2]	=	ls_revenue
					ls_temp_filter	=	ls_temp_filter	+	" or tbl_type = '"	+	ls_revenue	+	"'"
				END IF
			END IF
		END IF
	END IF
	ls_temp_filter	=	ls_temp_filter	+	")"
	
	IF	Len (ls_retrieve_filter)	>	0		THEN
		ls_filter	=	ls_filter	+	' and '	+	ls_retrieve_filter
	ELSE
		ls_filter	=	ls_filter	+	ls_temp_filter
	END IF
ELSE
	// This is not a Generic pattern
	IF	Len (ls_retrieve_filter)	>	0		THEN
		ls_filter	=	ls_filter	+	' and '	+	ls_retrieve_filter
	ELSE
		ls_filter	=	ls_filter	+	' and '	+	ls_table_filter
	END IF
END IF

// Now that we have the filter string, filter ids_patt_field_parm & sort it
li_rc	=	ids_patt_field_parm.SetFilter('')
li_rc	=	ids_patt_field_parm.Filter()
li_rc	=	ids_patt_field_parm.SetFilter(ls_filter)
li_rc	=	ids_patt_field_parm.Filter()

li_rc	=	ids_patt_field_parm.SetSort ("tbl_type A, parm_label A")
li_rc	=	ids_patt_field_parm.Sort()

// If there is only one row, then set the value in dw_criteria from the DDDW
ll_rowcount		=	ids_patt_field_parm.RowCount()

// If at least 1 row exists in patt_field_parm, then protect the operator.
//	Otherwise, let the user select the operator.  This is protected/unprotected
//	based on the value in column protect_operand_ind.
IF	ll_rowcount	>	0		THEN
	tab_patt.tabpage_criteria.dw_criteria.object.protect_operand_ind [al_row]	=	'Y'
ELSE
	tab_patt.tabpage_criteria.dw_criteria.object.protect_operand_ind [al_row]	=	'N'
END IF

IF	is_user_pattern_id	>	' '		&
OR	ib_import				=	TRUE		THEN
	// User-defined & imported patterns have the field description protected.  
	//	Therefore there is no DDDW.
	Return
END IF


// If data exists in ids_patt_field_parm, then make these the only entries
//	in the DDDW.  Otherwise, reset the DDDW to its originally retrieved values.

IF	ll_rowcount	>	0		THEN
	// Multiple rows exists in ids_patt_field_parm.  Make these the only entries in
	//	ldwc_field_name.  Setting the crit_seq = 0 in the filter will remove
	//	all dictionary rows in the DDDW.
	li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', ldwc_field_name)
	ls_filter	=	"crit_seq = 0"
	li_rc	=	ldwc_field_name.SetFilter('')
	li_rc	=	ldwc_field_name.Filter()
	ll_dwc_rowcount	=	ldwc_field_name.RowCount()
	li_rc	=	ldwc_field_name.SetFilter(ls_filter)
	li_rc	=	ldwc_field_name.Filter()
	// Now that the dictionary rows have been filtered out, discard any patt_field_parm
	//	rows previously inserted into the DDDW.  This can occur when going from row
	//	to row in dw_criteria.  These rows will be re-inserted.
	ll_dwc_rowcount	=	ldwc_field_name.RowCount()
	FOR	ll_row	=	1	TO	ll_dwc_rowcount
		li_crit_seq	=	ldwc_field_name.GetItemNumber (ll_row, 'crit_seq')
		IF IsNull (li_crit_seq)		&
		OR	li_crit_seq	=	0			THEN
			ldwc_field_name.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row	--
			ll_dwc_rowcount	--
		END IF
	NEXT
	ll_dwc_rowcount	=	ldwc_field_name.RowCount()
	// Insert the data from ids_patt_field_parm into the DDDW
	FOR	ll_row	=	1	TO	ll_rowcount
		ls_col_name	=	ids_patt_field_parm.object.parm_name [ll_row]
		ls_col_desc	=	ids_patt_field_parm.object.parm_label [ll_row]
		ls_tbl_type	=	ids_patt_field_parm.object.tbl_type [ll_row]
		ll_new_row	=	ldwc_field_name.InsertRow(0)
		ldwc_field_name.SetItem (ll_new_row, 'crit_seq', 0)
		ldwc_field_name.SetItem (ll_new_row, 'elem_tbl_type', ls_tbl_type)
		ldwc_field_name.SetItem (ll_new_row, 'elem_desc', ls_col_desc)
		ldwc_field_name.SetItem (ll_new_row, 'elem_name', ls_col_name)
	NEXT
	IF	ll_rowcount	=	1		THEN
		// Only one row exists in patt_field_parm.  Set this value in dw_criteria and protect
		//	the column.
		ls_col_name	=	ids_patt_field_parm.object.parm_name [1]
		ls_col_desc	=	ids_patt_field_parm.object.parm_label [1]
		ls_tbl_type	=	ids_patt_field_parm.object.tbl_type [1]
		tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [al_row]		=	ls_col_name
		tab_patt.tabpage_criteria.dw_criteria.object.field_description [al_row]	=	ls_col_desc
		tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [al_row]		=	ls_tbl_type
		tab_patt.tabpage_criteria.dw_criteria.object.field_alone [al_row]			=	'SI'
		tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [al_row]			=	'Y'
		tab_patt.tabpage_criteria.dw_criteria.object.column_description [al_row]	=	ls_tbl_type + '.' + ls_col_desc
		Return
	END IF
ELSE
	// No rows exists in ids_patt_field_parm (this is the norm).  Remove the entries
	//	previously inserted from ldwc_field_name and re-add the originally
	//	retrieved rows.
	This.Event	ue_retrieve_field_dddw()
	li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', ldwc_field_name)
	// For patterns 51 and 52, field1 can only have '1500' base_type rows (i.e. C1) and field2
	//	can only have UB92 base type rows (i.e. C2)
	IF	is_pattern_id	=	ics_patt51			&
	OR	is_pattern_id	=	ics_patt52			THEN
		IF	al_row		=	1		THEN
			ls_compare_base_type	=	'1500'
		ELSE
			ls_compare_base_type	=	'UB92'
		END IF
		// Loop thru istr_sub_opt.patt_struc.table_type until a table type that
		//	has a base type = '1500' is found
		li_upper			=	UpperBound (istr_sub_opt.patt_struc.table_type)
		FOR	li_idx	=	1	TO	li_upper
			ls_tbl_type		=	istr_sub_opt.patt_struc.table_type[li_idx]
			ls_base_type	=	inv_pattern_sql.uf_get_base_type (ls_tbl_type)
			IF	ls_base_type	=	ls_compare_base_type	THEN
				is_filter	=	is_filter	+	" and elem_tbl_type = '"	+	ls_tbl_type		+	"' "
				Exit
			END IF
		NEXT
		li_rc	=	ldwc_field_name.SetFilter('')
		li_rc	=	ldwc_field_name.Filter()
		ll_dwc_rowcount	=	ldwc_field_name.RowCount()
		li_rc	=	ldwc_field_name.SetFilter(is_filter)
		li_rc	=	ldwc_field_name.Filter()
		li_rc	=	ldwc_field_name.SetSort('elem_tbl_type A, crit_seq A, elem_desc A')
		li_rc	=	ldwc_field_name.Sort()
		ll_dwc_rowcount	=	ldwc_field_name.RowCount()
	END IF
	
	// For patterns 53, field1 can only have 'UB92' base_type rows (i.e. C2)
	IF	 ( is_pattern_id	=	ics_patt53 OR is_pattern_id	=	ics_patt54 ) &
	AND al_row			=	1						THEN
		// Loop thru istr_sub_opt.patt_struc.table_type until a table type that
		//	has a base type = 'UB92' is found
		li_upper			=	UpperBound (istr_sub_opt.patt_struc.table_type)
		FOR	li_idx	=	1	TO	li_upper
			ls_tbl_type		=	istr_sub_opt.patt_struc.table_type[li_idx]
			ls_base_type	=	inv_pattern_sql.uf_get_base_type (ls_tbl_type)
			IF	ls_base_type	=	'UB92'	THEN
				is_filter	=	is_filter	+	" and elem_tbl_type = '"	+	ls_tbl_type		+	"' "
				Exit
			END IF
		NEXT
		li_rc	=	ldwc_field_name.SetFilter('')
		li_rc	=	ldwc_field_name.Filter()
		ll_dwc_rowcount	=	ldwc_field_name.RowCount()
		li_rc	=	ldwc_field_name.SetFilter(is_filter)
		li_rc	=	ldwc_field_name.Filter()
		ll_dwc_rowcount	=	ldwc_field_name.RowCount()
		li_rc	=	ldwc_field_name.SetSort('elem_tbl_type A, crit_seq A, elem_desc A')
		li_rc	=	ldwc_field_name.Sort()
	END IF
	
	// For Patterns 33, 34, & 38, field1 cannot include revenue entries
	IF	is_pattern_id	=	ics_patt33		&
	OR	is_pattern_id	=	ics_patt34		&
	OR	is_pattern_id	=	ics_patt35		THEN
		// Loop thru istr_sub_opt.patt_struc.table_type until a table type that
		//	has a base type = 'UB92' is found
		li_upper			=	UpperBound (istr_sub_opt.patt_struc.table_type)
		FOR	li_idx	=	1	TO	li_upper
			ls_tbl_type		=	istr_sub_opt.patt_struc.table_type[li_idx]
			ls_base_type	=	inv_pattern_sql.uf_get_base_type (ls_tbl_type)
			IF	ls_base_type	=	'UB92'	THEN
				is_filter	=	is_filter	+	" and elem_tbl_type = '"	+	ls_tbl_type		+	"' "
				Exit
			END IF
		NEXT
		li_rc	=	ldwc_field_name.SetFilter('')
		li_rc	=	ldwc_field_name.Filter()
		ll_dwc_rowcount	=	ldwc_field_name.RowCount()
		li_rc	=	ldwc_field_name.SetFilter(is_filter)
		li_rc	=	ldwc_field_name.Filter()
		li_rc	=	ldwc_field_name.SetSort('elem_tbl_type A, crit_seq A, elem_desc A')
		li_rc	=	ldwc_field_name.Sort()
		ll_dwc_rowcount	=	ldwc_field_name.RowCount()
	END IF
END IF
end event

event ue_patt_type_changed(string as_patt_type, string as_old_patt_type);//*********************************************************************************
// Script Name:	ue_patt_type_changed
//
//	Arguments:		1.	as_patt_type -	Pattern Type in dw_parms.  Values:
//							T - Pattern templates only
//							U - User defined patterns only
//							A - All patterns
//						2.	as_old_patt_type - Original Pattern Type
//
// Returns:			N/A
//
//	Description:	This event is triggered when dw_parms.patt_type changed and
//						when the window is opened.  If the pattern type is changed
//						to display pattern templates, then several columns in dw_parms
//						must by reset and protected.  These columns only relate to 
//						user-defined patterns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	11/04/02	GaryR	SPR 4311c	Disable protected controls
//
//*********************************************************************************

Long		ll_row

DateTime	ldtm_date

String	ls_userid

u_nvo_sys_cntl	lnv_sys_cntl

ll_row		=	tab_patt.tabpage_list.dw_parms.GetRow()

IF	ll_row	=	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_patt_type_changed, '	+	&
					'could not get the current row in dw_parms')
	Return
END IF

// Prevent screen flicker
tab_patt.tabpage_list.dw_parms.SetRedraw (FALSE)

// If the original pattern type is Pattern Templates and the user_id is
//	empty, then fill in user_id.
IF	as_old_patt_type	=	ics_pattern_template	THEN
	ls_userid			=	tab_patt.tabpage_list.dw_parms.object.user_id [ll_row]
	IF	Trim (ls_userid)	=	''		THEN
		tab_patt.tabpage_list.dw_parms.object.user_id [ll_row]	=	gc_user_id
	END IF
END IF

//	11/04/02	GaryR	SPR 4311c - Begin
IF	as_patt_type	=	ics_pattern_template	THEN
	// Pattern Template - Protect and reset the user-defined patterns columns
	tab_patt.tabpage_list.dw_parms.object.patt_id.protect					=	1
	tab_patt.tabpage_list.dw_parms.object.patt_id.color					=	stars_colors.protected_text
	tab_patt.tabpage_list.dw_parms.object.patt_id.background.color		=	stars_colors.protected_back
	tab_patt.tabpage_list.dw_parms.object.user_id.protect					=	1
	tab_patt.tabpage_list.dw_parms.object.user_id.color					=	stars_colors.protected_text
	tab_patt.tabpage_list.dw_parms.object.user_id.background.color		=	stars_colors.protected_back
	tab_patt.tabpage_list.dw_parms.object.patt_date.protect				=	1
	tab_patt.tabpage_list.dw_parms.object.patt_date.color					=	stars_colors.protected_text
	tab_patt.tabpage_list.dw_parms.object.patt_date.background.color	=	stars_colors.protected_back
	tab_patt.tabpage_list.dw_parms.object.patt_range.protect				=	1
	tab_patt.tabpage_list.dw_parms.object.patt_range.color				=	stars_colors.protected_text
	tab_patt.tabpage_list.dw_parms.object.patt_range.background.color	=	stars_colors.protected_back
	tab_patt.tabpage_list.dw_parms.object.patt_id [ll_row]		=	''
	tab_patt.tabpage_list.dw_parms.object.user_id [ll_row]		=	''
	tab_patt.tabpage_list.dw_parms.object.patt_range [ll_row]	=	0
	SetNull(ldtm_date)
	tab_patt.tabpage_list.dw_parms.object.patt_date [ll_row]		=	ldtm_date
ELSE
	// User-defined patterns or all patterns - Unprotect the user-defined patterns columns
	tab_patt.tabpage_list.dw_parms.object.patt_id.protect					=	0
	tab_patt.tabpage_list.dw_parms.object.patt_id.color					=	stars_colors.input_text
	tab_patt.tabpage_list.dw_parms.object.patt_id.background.color		=	stars_colors.input_back
	tab_patt.tabpage_list.dw_parms.object.user_id.protect					=	0
	tab_patt.tabpage_list.dw_parms.object.user_id.color					=	stars_colors.input_text
	tab_patt.tabpage_list.dw_parms.object.user_id.background.color		=	stars_colors.input_back
	tab_patt.tabpage_list.dw_parms.object.patt_date.protect				=	0
	tab_patt.tabpage_list.dw_parms.object.patt_date.color					=	stars_colors.input_text
	tab_patt.tabpage_list.dw_parms.object.patt_date.background.color	=	stars_colors.input_back
	tab_patt.tabpage_list.dw_parms.object.patt_range.protect				=	0
	tab_patt.tabpage_list.dw_parms.object.patt_range.color				=	stars_colors.input_text
	tab_patt.tabpage_list.dw_parms.object.patt_range.background.color	=	stars_colors.input_back
	// If changed from pattern templates, compute the date and range
	IF	as_old_patt_type	=	ics_pattern_template	THEN
		lnv_sys_cntl		=	CREATE	u_nvo_sys_cntl
		lnv_sys_cntl.of_set_cntl_id ('RANGE')
		tab_patt.tabpage_list.dw_parms.object.patt_date [ll_row]		=	gnv_app.of_get_server_date_time()
		tab_patt.tabpage_list.dw_parms.object.patt_range [ll_row]	=	lnv_sys_cntl.of_get_cntl_no()
		Destroy	lnv_sys_cntl
	END IF
END IF
//	11/04/02	GaryR	SPR 4311c - End

// Re-retrieve the data for dw_list
This.Event	ue_retrieve()

// Redraw the d/w
tab_patt.tabpage_list.dw_parms.SetRedraw (TRUE)

end event

event ue_view_report();//*********************************************************************************
// Script Name:	ue_view_report
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the report tab is clicked.  This
//						event will generate the SQL for the pattern (via
//						u_nvo_pattern_sql) and generate the report.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 08/22/02 JasonS Track 2982d  Call n_cst_labels to dictionarize the headings
//	01/10/03	GaryR	Track 3405d	Append the prefix to report columns
//	01/13/03	GaryR	Track 2868d	Fix logic for duplicate column names
// 07/13/05 Katie Track 3661d Change empty field to BLANKS before sending to QE.
//	07/10/06	GaryR	Track 4387d	Allow invoice specific lookups in ML patterns
//	03/21/07	GaryR	Track 4958	Do not log pattern SQL
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//  05/29/08 RickB	Track 5335 - Reset gv_rowcounter to 0 when the "create the report"
//						msgbox is generated.
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

Integer		li_rc

Long			ll_rowcount

String		ls_style,			&
				ls_syntax,			&
				ls_error,			&
				ls_empty[],			&
				ls_where,			&
				ls_window_name

n_cst_labels	lnv_labels	// JasonS 08/22/02  Track 2982d
long ll_index, ll_upperbound	// JasonS 08/22/02 Track 2982d
sx_decode_structure	lsx_decode

li_rc	=	MessageBox ('Attention', 'Create the Report?', Exclamation!, OkCancel!)
gv_rowcounter = 0

IF	li_rc	=	2		THEN
	Return
END IF

SetPointer (HourGlass!)
w_main.SetMicroHelp ('Creating Pattern Report...')

// Issue an Accepttext on each d/w

li_rc	=	This.Event	ue_accepttext (This.Control, TRUE)

IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// Edit the criteria
li_rc	=	This.Event	ue_edit_criteria()

IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// Clear out the previously assigned data in inv_pattern_sql
inv_pattern_sql.uf_clear_data()

// Tell inv_pattern_sql that the report will not be run in background mode.
inv_pattern_sql.uf_set_background_flag (FALSE)

// Get the revenue selections
IF This.Event ue_edit_revenue() < 0 THEN Return

IF	is_pattern_id	=	ics_generic		THEN
	// Get the SQL for a generic pattern and place it in istr_sub_opt.patt_struc.pattern_sql
	li_rc	=	This.Event	ue_get_generic_sql()
	IF	li_rc	<	0		THEN
		GOTO	Exit_Script				// Perform cleanup and issue a 'Return'
	END IF
ELSE
	// Get the SQL for a non-generic pattern and place it in istr_sub_opt.patt_struc.pattern_sql
	li_rc	=	This.Event	ue_get_spec_sql()
END IF

// If an error occured, display the Criteria Tab and get out.

IF	li_rc	<	0		THEN
	tab_patt.SelectTab (ici_criteria)
	tab_patt.tabpage_criteria.dw_criteria.SetFocus()
	GOTO	Exit_Script				// Perform cleanup and issue a 'Return'
END IF

// Prevent dw_report from repainting multiple times
tab_patt.tabpage_report.dw_report.SetRedraw (FALSE)

// Create the datawindow and move the SQL to is_sql.
li_rc	=	This.Event	ue_create_datawindows()

IF	li_rc	<	0		THEN
	GOTO	Exit_Script					// Perform cleanup and issue a 'Return'
END IF

// Determine if pattern 17 or pattern 20.

CHOOSE CASE	is_pattern_id
	CASE	ics_patt17
		This.Event	ue_pattern_17()
		GOTO	Exit_Script				// Perform cleanup and issue a 'Return'
	CASE	ics_patt20
		This.Event	ue_pattern_20()
		GOTO	Exit_Script				// Perform cleanup and issue a 'Return'
END CHOOSE

// Parse the datawindow syntax for decode.
lsx_decode.pattern = TRUE
ls_window_name	=	Upper (This.ClassName())

li_rc	=	fx_dw_syntax (ls_window_name,							&
							tab_patt.tabpage_report.dw_report,	&
							lsx_decode,						&
							Stars2ca)

lsx_decode.is_ml_patt = is_inv_type = "ML"
istr_decode_struct = lsx_decode

IF	li_rc	=	-5		THEN
	// Disable Code/Decode
	This.Event	ue_enable_decode (FALSE)
ELSE
	// Enable Code/Decode
	This.Event	ue_enable_decode (TRUE)
END IF

// Reset the previous contents of dw_report and connect to the database
tab_patt.tabpage_report.dw_report.Reset()
tab_patt.tabpage_report.dw_report.SetTransObject (Stars2ca)

// Reset the global that says cancel was clicked
gv_cancel_but_clicked	=	FALSE											

ll_rowcount	=	tab_patt.tabpage_report.dw_report.Retrieve()
tab_patt.tabpage_report.st_count.text	=	String (ll_rowcount)

// Enable the Create Subset and Save Report RMMs
This.Event	ue_enable_subset (TRUE)
This.Event	ue_enable_save_report (TRUE)

// JasonS 08/22/02 Begin - Track 2982d
lnv_labels = create n_cst_labels
lnv_labels.of_setdw(tab_patt.tabpage_report.dw_report)

ll_upperbound = upperbound(istr_sub_opt.patt_struc.table_type[])

for ll_index = 1 to ll_upperbound
	lnv_labels.of_labels2(istr_sub_opt.patt_struc.table_type[ll_index],'95','40','50')
next

destroy lnv_labels
// JasonS 08/22/02 End - Track 2982d

//	Dictionaryze the column labels.
// Edit inv_pattern_sql.ids_report_cols to insure that the alias_name has no non-alphanumeric characters
//	Also, for patterns 17 and 20, this routine will set the text in the column headers
li_rc	=	inv_pattern_sql.uf_edit_report_cols( TRUE )

// Any cleanup including Commits and repainting dw_report is done here.  The GoTo Exit_Script
//	is only used to prevent duplication of code when issuing a Return.

Exit_Script:

// Repaint dw_report
tab_patt.tabpage_report.dw_report.BringToTop			=	TRUE
tab_patt.tabpage_report.uo_report_rmm.BringToTop	=	FALSE
tab_patt.tabpage_report.dw_report.SetRedraw (TRUE)

//	Free up any locks
Stars2ca.of_commit()					

w_main.SetMicroHelp ('Ready')
end event

event ue_import();//*********************************************************************************
// Script Name:	ue_import
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will take a sequential file (that was previously
//						exported) and import the contents into the tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// JasonS 10/5/04	Track 5651c remove case requirements
//*********************************************************************************

// Determine if any prior changes need to be saved

Constant	String	lcs_error		=	'ERROR'
Constant	String	lcs_delimiter	=	'^'

Boolean	lb_eof,					&
			lb_errors,				&
			lb_criteria_errors

Integer	li_rc

Long		ll_row,					&
			ll_filenumber,			&
			ll_record_count,		&
			ll_crit_count,			&
			ll_tables_count,		&
			ll_rowcount,			&
			ll_count

String	ls_comment,				&
			ls_data_type,			&
			ls_error_ind,			&
			ls_file_name,			&
			ls_file_hdr,			&
			ls_path,					&
			ls_path_file,			&
			ls_next_file_id,		&
			ls_record,				&
			ls_record_type,		&
			ls_rel_type,			&
			ls_tbl_type,			&
			ls_rc,					&
			ls_message

sx_import_pattern_summary	lstr_summary

n_cst_string	lnv_string			// Autoinstantiated

//	Determine if any prior changes need to be saved

li_rc	=	This.Event	CloseQuery()

IF	li_rc	<>	0		THEN
	Return
END IF

ls_path				=	ProfileString (gv_ini_path + 'STARS.INI', 'Carrier','UserINIPath', '')
ls_path_file		=	ls_path

li_rc		=	GetFileOpenName ('Select Pattern File',				&
										ls_path_file,							&
										ls_file_name,							&
										'PAT',									&
										'Pattern Files (*.PAT),*.PAT')

IF	li_rc	<>	1		THEN
	MessageBox ('Error', 'Unable to access Pattern file '	+	ls_path_file)
	Return
END IF

ll_filenumber	=	FileOpen (ls_path_file)

IF	ll_filenumber	<	0		THEN
	MessageBox ('Error', 'Unable to open Pattern file '	+	ls_path_file)
	Return
END IF

// Reset any data from a previous import
ids_errors.Reset()
ids_summary.Reset()

This.Event	ue_notes_clear()

ib_file_hdr_read		=	FALSE
is_import_subset_id	=	''
is_import_tbl_type	=	istr_sub_opt.patt_struc.table_type
is_user_pattern_id	=	''

// w_subset_use (from w_import_pattern_summary) sets these globals.  Save these
//	values in case an error occurs.
is_orig_subset_id		=	gc_active_subset_id
is_orig_subset_name	=	gc_active_subset_name

// Reset the previously selected pattern
This.Event	ue_import_clean_up (ll_filenumber, FALSE)

// Specify to the other scripts that this is part of the import process.
// Make sure this is set after ue_import_clean_up is executed because
// this script resets ib_import.
ib_import				=	TRUE

// Save is_inv_type (which can change in ue_import_tables_trailer)
is_import_inv_type	=	is_inv_type

// Read the imported file

DO	UNTIL	lb_eof	=	TRUE
	li_rc		=	FileRead (ll_filenumber, ls_record)
	IF	li_rc	<	0		THEN
		lb_eof	=	TRUE
		Exit
	END IF
	
	ls_record_type	=	Left (ls_record, 1)
	
	CHOOSE CASE	ls_record_type
		CASE	'A'
			// File Header
			li_rc		=	This.Event	ue_import_file_hdr (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			ls_comment	=	Trim ( Mid(ls_record, 45, 255) )
			
		CASE	'B'
			// Pattern Header
			ll_record_count	++
			li_rc		=	This.Event	ue_import_pattern_hdr (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'C'
			// Pattern Tables
			ll_record_count	++
			ll_tables_count	++
			li_rc		=	This.Event	ue_import_pattern_tables (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'D'
			// Pattern Tables Trailer
			ll_record_count	++
			li_rc		=	This.Event	ue_import_tables_trailer (ls_record, ls_comment)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'E'
			// Pattern Options
			ll_record_count	++
			li_rc		=	This.Event	ue_import_pattern_options (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'F'
			// Pattern Criteria
			ll_record_count	++
			ll_crit_count	++
			IF	ll_tables_count	=	0		THEN
				MessageBox ('Import Error', 'Pattern file '	+	ls_file_name	+	&
								' has been corrupted.  Import cancelled.')
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			li_rc		=	This.Event	ue_import_pattern_criteria (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'G'
			// Pattern Criteria Trailer
			ll_record_count	++
			
		CASE	'H'
			// Pattern Columns
			ll_record_count	++
			IF	ll_tables_count	=	0		THEN
				MessageBox ('Import Error', 'Pattern file '	+	ls_file_name	+	&
								' has been corrupted.  Import cancelled.')
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			li_rc		=	This.Event	ue_import_pattern_columns (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'I'
			// Pattern Columns Trailer
			ll_record_count	++
			
		CASE	'J'
			// Pattern Notes
			ll_record_count	++
			li_rc		=	This.Event	ue_import_pattern_notes (ls_record)
			IF	li_rc	<	0		THEN
				istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
				This.Event	ue_import_clean_up (ll_filenumber, TRUE)
				Return
			END IF
			
		CASE	'Y'
			// Pattern Control Trailer
			ll_record_count	++
			
		CASE	'Z'
			// File Trailer
			
	END CHOOSE				// ls_record_type
	
LOOP							// Until lb_eof = TRUE

IF	ll_record_count	=	0		THEN
	MessageBox ('Import Error', 'Pattern file '	+	ls_file_name	+	&
					' does not contain any data to import.  Import cancelled.')
	istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
	This.Event	ue_import_clean_up (ll_filenumber, TRUE)
	Return
END IF

IF	ll_crit_count	=	0		THEN
	MessageBox ('Import Error', 'Pattern file '	+	ls_file_name	+	&
					' does not contain any criteria.  Import cancelled.')
	istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
	This.Event	ue_import_clean_up (ll_filenumber, TRUE)
	Return
END IF

// Determine if any errors exist in ids_errors.  If so, open w_import_errors.

ll_rowcount	=	ids_errors.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_error_ind	=	ids_errors.object.error_ind [ll_row]
	ls_data_type	=	Upper ( ids_errors.object.data_type [ll_row] )
	IF	ls_error_ind	=	'Y'	THEN
		lb_errors	=	TRUE
		IF	ls_data_type	<>	'COLUMN'		THEN
			//	These types of errors will cause the import to be cancelled.
			lb_criteria_errors	=	TRUE
		END IF
	END IF
NEXT

IF	lb_errors	=	TRUE		THEN
	// Found at least one error in ids_errors.
	OpenWithParm (w_import_errors, ids_errors)
	IF	lb_criteria_errors	THEN
		// One or more criteria errors occurred.  Cancel the import.
		MessageBox ('Import Error', 'Pattern file '	+	ls_file_name	+	&
						' cannot be imported because criteria errors exist.')
		istr_sub_opt.patt_struc.table_type	=	is_import_tbl_type
		This.Event	ue_import_clean_up (ll_filenumber, TRUE)
		Return
	END IF
END IF

// No import errors exist.  The remaining logic will emulate selecting
//	a pattern template.  Also, because the subset ID was changed, the
// contents of the library tab must change to reflect the new subset.

// Disable the Link RMMM
This.Event	ue_enable_link (FALSE)

// Set the new subset ID, case ID, and subset name
istr_sub_opt.patt_struc.subset_id	=	is_import_subset_id
istr_sub_opt.patt_struc.case_id		=	gc_active_subset_case
is_case_id									=	Left (istr_sub_opt.patt_struc.case_id, 10)
is_case_spl									=	Mid (istr_sub_opt.patt_struc.case_id, 11, 2)
is_case_ver									=	Mid (istr_sub_opt.patt_struc.case_id, 13, 2)

This.Event	ue_get_subset_name()

// Determine if the imported pattern is 'ML'.  is_inv_type
// is set when the patterns tables trailer record is read.
istr_sub_opt.patt_struc.subset_table_type	=	is_inv_type

tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_inv_type [1]	=	istr_sub_opt.patt_struc.subset_table_type

// Set the invoice type (and its DDDW) in dw_parms
This.Event	ue_set_inv_type_dddw()

// Hide the notes picture because the imported notes have not been added to
// the notes table.
tab_patt.tabpage_criteria.pb_notes.visible	=	FALSE

// Retrieve the data for the column_description (dw_criteria) drop-down
This.Event	ue_init_criteria_dddw()

// Format the data on the tabs
This.Event	ue_format_tabs()

// For a generic or filter pattern, make sure the unique key columns are included
// in the selected list.
IF	is_pattern_id	=	ics_generic		&
OR	is_pattern_id	=	ics_filter_pat	THEN
	This.Event	ue_select_unique_key_columns()
END IF

// Enable/disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()

// Display the Criteria tab
tab_patt.SelectTab (ici_criteria)

// Close the file
FileClose (ll_filenumber)

// Re-retrieve the list of patterns in the Library tab
This.Event	ue_retrieve()

ls_message	=	'Pattern file '	+	ls_file_name	+	' has been successfully imported.'

IF	lb_errors	=	TRUE		THEN
	// At least one column did not get imported.
	ls_message	=	ls_message	+	'  The Customize Report tab will have at least one column '		+	&
						'that could not be imported.'
END IF

ll_rowcount	=	ids_notes.RowCount()

IF	ll_rowcount	>	0		THEN
	ls_message	=	ls_message	+	'  One or more notes have been imported with this pattern.  '	+	&
						'You can view these notes when the pattern is saved.'
END IF

MessageBox ('Import', ls_message)

// Please note that ue_retrieve_dw_available and ue_retrieve perform commits to
// free up any locks.

// Reset import mode
ib_import		=	FALSE

w_main.SetMicroHelp ('Ready')

This.SetRedraw (TRUE)


end event

event ue_export;//*********************************************************************************
// Script Name:	ue_export
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Export the contents of the tabs to a sequential file.
//
//	Notes:			The data does not have to be saved (like PDQ exports) before
//						exporting to the file.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	10/03/00	FDG	Stars 4.6	Track 3006.  No notes will be exported for a pattern.
//
//*********************************************************************************

Constant	String	lcs_error		=	'ERROR'
Constant	String	lcs_delimiter	=	'^'

Boolean	lb_found_file

Integer	li_rc,					&
			li_filenumber

Long		ll_row

String	ls_comment,				&
			ls_file_name,			&
			ls_file_hdr,			&
			ls_path,					&
			ls_path_file,			&
			ls_next_file_id,		&
			ls_record,				&
			ls_rc

n_cst_string	lnv_string			// Autoinstantiated

// Issue an Accepttext on each d/w

li_rc	=	This.Event	ue_accepttext (This.Control, TRUE)

IF	li_rc	<	0		THEN
	Return
END IF

// Edit the criteria
li_rc	=	This.Event	ue_edit_criteria()

IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// If the pattern is a filter pattern, display a warning.
li_rc	=	This.Event	ue_edit_save_filter()

IF	li_rc	<	0		THEN
	// User cancelled.
	Return
END IF

// For a generic or filter pattern, make sure the unique key columns are included
// in the selected list.
IF	is_pattern_id	=	ics_generic		&
OR	is_pattern_id	=	ics_filter_pat	THEN
	This.Event	ue_select_unique_key_columns()
END IF

// Take the data from dw_selected and load ids_patt_columns
This.Event	ue_custom_load_patt_columns()

// Open a window for the user to enter export/import comments
// To do this, get the existing comments.

ll_row		=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()
ls_comment	=	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_row]

OpenWithParm (w_import_export_comments, ls_comment)

ls_comment	=	Message.StringParm
SetNull (Message.StringParm)

IF	IsNull (ls_comment)		THEN
	ls_comment	=	''
END IF

IF	Upper (ls_comment)	=	'CANCEL'		THEN
	// User cancelled out.  Get Out.
	Return
END IF

// Move changed comment back to dw_patt_cntl
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_row]	=	ls_comment


ls_comment		=	lnv_string.of_padright (ls_comment, 255)

ls_next_file_id	=  fx_get_next_key_id ('PATEXPORT')
ls_next_file_id	=  lnv_string.of_padnumber (ls_next_file_id, 6)
ls_path_file		=  'PA'  +  ls_next_file_id  +  '.PAT'
ls_path				=	ProfileString (gv_ini_path + 'STARS.INI', 'Carrier','UserINIPath', '')
ls_path_file		=	ls_path	+	ls_path_file

DO
	li_rc	=	GetFileSaveName ('Export Pattern File Save Window', ls_path_file,		+	&
										ls_file_name, 'PAT', 'Pattern Files (*.PAT),*.PAT')
	CHOOSE CASE	li_rc
		CASE	0
			// User cancelled
			lb_found_file	=	TRUE
			Return
		CASE	IS <	0
			MessageBox ('Error', 'Error retrieving file name')
			lb_found_file	=	TRUE
			Return
	END CHOOSE
	IF	FileExists (ls_path_file)		THEN
		li_rc	=	MessageBox ('WARNING', 'Save file exists.  Do you want to save over the existing file?',Question!,YesNo!)
		IF	li_rc	=	1		THEN
			// Overlaying existing file.  Get out of the loop.
			lb_found_file	=	TRUE
		END IF
	ELSE
		// New file.  Get out of the loop.
		lb_found_file		=	TRUE
	END IF
LOOP WHILE lb_found_file	=	FALSE


li_filenumber  =  FileOpen (ls_file_name, Linemode!, Write!, Lockwrite!, Replace!)

IF	li_filenumber	<	0		THEN
	MessageBox ('Error', 'Error opening file.  Export cancelled.')
	Return
END IF

// Write the File Header
ls_rc		=	This.Event	ue_export_file_hdr (li_filenumber, ls_comment)
IF	Upper (ls_rc)	=	lcs_error		THEN
	Return
END IF

// Write the Pattern Header
ls_rc		=	This.Event	ue_export_pattern_hdr (li_filenumber)
IF	Upper (ls_rc)	=	lcs_error		THEN
	Return
END IF

// Write the Pattern Tables records
ls_rc		=	This.Event	ue_export_pattern_tables (li_filenumber)
IF	Upper (ls_rc)	=	lcs_error		THEN
	Return
END IF

// Write the Pattern Options record
ls_rc		=	This.Event	ue_export_pattern_options (li_filenumber)
IF	Upper (ls_rc)	=	lcs_error		THEN
	Return
END IF

// Write the Pattern Criteria records
ls_rc		=	This.Event	ue_export_pattern_criteria (li_filenumber)
IF	Upper (ls_rc)	=	lcs_error		THEN
	Return
END IF

// Write the Pattern Columns records
ls_rc		=	This.Event	ue_export_pattern_columns (li_filenumber)
IF	Upper (ls_rc)	=	lcs_error		THEN
	Return
END IF

//	10/03/00	FDG	Stars 4.6	Track 3006.  No notes will be exported for a pattern.
// Write the Pattern notes records
//ls_rc		=	This.Event	ue_export_pattern_notes (li_filenumber)
//IF	Upper (ls_rc)	=	lcs_error		THEN
//	Return
//END IF

// Write the Pattern Trailer
ls_record		=	'Y Pattern Control Trailer'
li_rc				=	FileWrite (li_filenumber, ls_record)
IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing the pattern trailer for the export file.  Export is cancelled.')
	Return
END IF

// Write the File Trailer
ls_record		=	'Z File Trailer'
li_rc				=	FileWrite (li_filenumber, ls_record)
IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing the file trailer for the export file.  Export is cancelled.')
	Return
END IF

// Close the file
FileClose (li_filenumber)

MessageBox ('Export', 'This pattern was successfully exported to file '	+	ls_path_file	+	'.')

w_main.SetMicroHelp ('Ready')




end event

event ue_code_lookup(string as_value, long al_row);//*********************************************************************************
// Script Name:	ue_code_lookup
//
//	Arguments:		1.	as_value -	The value currently displayed in dw_criteria.
//						2.	al_row	-	The row # in dw_criteria.
//
// Returns:			None
//
//	Description:	Determine if a code lookup is required in dw_criteria.
//						If not, display the RMM.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/11/01	GaryR	Stars 4.7 	DataBase Port - Trimming the data
// 10/14/09 RickB LKP.650.5678.001 Added code to open w_code_lookup as multiselect with parm.
// 10/20/09 RickB LKP.650.5678.001 Deleted code that created comma separated
// 								values string...need to overwrite value if ls_field_op not IN or NOT IN.
//	11/10/09 RickB  LKP.650.5678.001 - Saving current list of values and using if gv_code_to_use = ""
//*********************************************************************************

String		ls_col_name, ls_tbl_type, ls_parm, ls_field_op, ls_prev_list

ls_col_name	=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [al_row]
ls_tbl_type	=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [al_row]
ls_field_op = UPPER(tab_patt.tabpage_criteria.dw_criteria.object.field_operator [al_row])
// Save existing values
ls_prev_list = tab_patt.tabpage_criteria.dw_criteria.object.field_value [al_row]

IF	IsNull (ls_col_name)		&
OR	ls_col_name		=	''		THEN
	MessageBox ('Error', 'Please select a field before performing a code lookup.')
	Return
END IF

//	04/11/01	GaryR	Stars 4.7 DataBase Port
gv_code_to_use = Trim( tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [al_row] )

IF	gv_code_to_use	=	''		THEN
	//	No code to lookup.  Open the RMM.
	This.Event	ue_open_rmm()
ELSE
	// Use parm to open code lookup as multiselect.
	IF ls_field_op = "IN" OR ls_field_op = "NOT IN" THEN 
		ls_parm = "1" + as_value
		OpenWithParm( w_code_lookup, ls_parm )
		// If user clicks close without clicking on a row, use previous value list
		If trim(gv_code_to_use) = "" then
			tab_patt.tabpage_criteria.dw_criteria.object.field_value [al_row] = ls_prev_list
		else
			tab_patt.tabpage_criteria.dw_criteria.object.field_value [al_row]	=	gv_code_to_use
		end if
	ELSE
		// Don't need parm for single select.  Also, deleted code that created comma separated
		// values string...need to overwrite if ls_field_op not IN or NOT IN.
		Open (w_code_lookup)
		tab_patt.tabpage_criteria.dw_criteria.object.field_value [al_row]	=	gv_code_to_use
		// Determine if the Time Frame tab is to be enabled and fill in the DDDWs for dw_timeframe.
		This.Event	ue_edit_timeframe_tab()
	END IF
END IF

end event

event type integer ue_edit_generic_criteria(long al_row, string as_column, string as_data);//*********************************************************************************
// Script Name:	ue_edit_generic_criteria
//
//	Arguments:		1.	al_row - Current row # in dw_criteria
//						2.	as_column - Column name that changed
//						3. as_data - The data desired to be changed.
//
// Returns:			Integer.
//						-1	=	Error
//						 1	=	Successful
//
//	Description:	This event is triggered from the itemchanged event of dw_criteria.
//						This event will edit the changed data to the other criteria data.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	09/25/00	FDG	Track 2995c - Stars 4.5 SP1.  When a column is selected in 
//						the criteria, automatically add it to dw_selected.
//	04/16/01	FDG	Stars 4.7.	Empty string in SQL.
//	08/09/04	GaryR	Track 7166c	Do not allow more than two fields in set
//
//*********************************************************************************

Boolean	lb_sets

Integer	li_rc

Long		ll_row,					&
			ll_row2,					&
			ll_curr_row,			&
			ll_parm_row,			&
			ll_patt_row,			&
			ll_opt_row,				&
			ll_find_row,			&
			ll_rowcount,			&
			ll_avail_rowcount,	&
			ll_select_count,		&
			ll_field_number,		&
			ll_occurs

String	ls_find,					&
			ls_match,				&
			ls_desc,					&
			ls_tbl_type,			&
			ls_col_name,			&
			ls_field_set

DataWindowChild	ldwc

sx_pattern_field	lstr_pattern_field[]		// This is a window structure
			
ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

as_data			=	Trim (as_data)

FOR ll_row	=	1	TO	ll_rowcount
	lstr_pattern_field[ll_row].tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]
	lstr_pattern_field[ll_row].column		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]
	lstr_pattern_field[ll_row].field_set	=	tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]
	lstr_pattern_field[ll_row].number		=	ll_row
	lstr_pattern_field[ll_row].set_number	=	1
	lstr_pattern_field[ll_row].field_set	=	Upper ( Left(lstr_pattern_field[ll_row].field_set, 1) )
	IF	 ll_row		=	al_row						&
	AND as_column	=	ics_column_description	THEN
		// This column_description is being changed.  Get its value from the argument
		//	instead of the datawindow.
		IF	Trim (as_data)	>	' '		THEN
			lstr_pattern_field[ll_row].label	=	as_data
		ELSE
			lstr_pattern_field[ll_row].label	=	''
		END IF
	ELSE
		// Get column_description from the d/w
		ls_desc	=	tab_patt.tabpage_criteria.dw_criteria.object.column_description [ll_row]
		IF	Trim (ls_desc)	>	' '		THEN
			lstr_pattern_field[ll_row].label	=	ls_desc
		ELSE
			lstr_pattern_field[ll_row].label	=	''
		END IF
	END IF
	IF	 ll_row		=	al_row						&
	AND as_column	=	ics_field_value		THEN
		// This field_value is being changed.  Get its value from the argument
		//	instead of the datawindow.
		lstr_pattern_field[ll_row].field_value	=	as_data
	ELSE
		// Get field_value from the d/w
		lstr_pattern_field[ll_row].field_value	=	tab_patt.tabpage_criteria.dw_criteria.object.field_value [ll_row]
	END IF
NEXT

// Determine if any sets exist.

FOR ll_row	=	1	TO	ll_rowcount
	lb_sets				=	FALSE
	IF	ll_row	=	al_row	THEN
		// No need to compare the current row against itself
		Continue
	END IF
	// Compare this row against the current row
	IF	lstr_pattern_field[ll_row].label			=	lstr_pattern_field[al_row].label		THEN
		// Found a set
		IF	lb_sets	=	FALSE		THEN
			ll_occurs	++
		END IF
		lstr_pattern_field[al_row].field_set	=	'S'
		IF	lstr_pattern_field[ll_row].field_set	=	'F'	THEN
			// Convert 'field' to 'set'
			lstr_pattern_field[ll_row].field_set	=	'S'
		END IF
	END IF
NEXT

// Cannot have multiple sets
IF	ll_occurs	>	1		THEN
	MessageBox ("Edit Error", "You cannot have more than 2 fields in the same set.", StopSign!)
	Return	-1
END IF

// Cannot have a set with an ML grouping
IF	ll_occurs	>	0		THEN
	IF	is_inv_type	=	'ML'		THEN
		MessageBox ("Edit Error", "You cannot have sets with a ML grouping.", StopSign!)
		Return	-1
	END IF
END IF

// Cannot have 2 different field sets
FOR	ll_row	=	1	TO	ll_rowcount
	FOR	ll_row2	=	ll_row + 1	TO	ll_rowcount
		IF	lstr_pattern_field[ll_row].label		=	lstr_pattern_field[ll_row2].label		&
		AND lstr_pattern_field[ll_row].label	<>	''													THEN
			IF	ls_match		<>	''												&
			AND ls_match	<>	lstr_pattern_field[ll_row].label		THEN
				MessageBox ("Edit Error", "You cannot have 2 different field sets.", StopSign!)
				Return	-1
			END IF
			ls_match	=	lstr_pattern_field[ll_row2].label
		END IF
	NEXT
NEXT

//	Delete the old sets
FOR	ll_row	=	1	TO	ll_rowcount
	ll_occurs	=	0
	IF	lstr_pattern_field[ll_row].field_set	=	'S'	THEN
		FOR	ll_row2	=	1	TO	ll_rowcount
			IF	lstr_pattern_field[ll_row].label		=	lstr_pattern_field[ll_row2].label	&
			AND ll_row	<>	ll_row2																			THEN
				ll_occurs	++
			END IF
		NEXT
		IF	ll_occurs	=	0								&
		AND as_column	=	ics_column_description	THEN
			lstr_pattern_field[ll_row].field_set	=	'F'
		END IF
	END IF
NEXT

// Numbering sets and set the "field_set" column based on this number
FOR	ll_row	=	1	TO	ll_rowcount
	ll_occurs	=	1
	IF	lstr_pattern_field[ll_row].field_set	=	'S'	THEN
		lb_sets			=	TRUE
		FOR	ll_row2	=	ll_row + 1	TO	ll_rowcount
			IF	lstr_pattern_field[ll_row].label		=	lstr_pattern_field[ll_row2].label	THEN
				ll_occurs	++
				lstr_pattern_field[ll_row2].set_number	=	ll_occurs
			END IF
		NEXT
		ls_field_set	=	'set'	+	String (lstr_pattern_field[ll_row].set_number)
	ELSE
		ll_field_number	++
		//ls_field_set	=	'field'	+	String (lstr_pattern_field[ll_row].number)
		ls_field_set	=	'field'	+	String (ll_field_number)
	END IF
	tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]	=	ls_field_set
NEXT

// If the current row is the last row and the current row < 4 (the max # of generic rows),
//	then insert a new row of criteria
IF	 al_row			=	ll_rowcount					&
AND as_column		=	ics_column_description	&
AND ll_rowcount	<	ici_generic_fields		THEN
	ll_occurs	=	0
	// Get the # of "field" rows
	FOR	ll_row	=	1	TO	ll_rowcount
		IF	lstr_pattern_field[ll_row].field_set	=	'F'	THEN
			ll_occurs	++
		END IF
	NEXT
	ls_field_set	=	'field'	+	String (ll_occurs + 1)
	// Insert a new row in dw_criteria
	ll_row	=	tab_patt.tabpage_criteria.dw_criteria.InsertRow(0)
	tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]		=	ls_field_set
	tab_patt.tabpage_criteria.dw_criteria.object.seq_num [ll_row]			=	ll_row
	tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_row]	=	'='
	tab_patt.tabpage_criteria.dw_criteria.object.field_value [ll_row]		=	''
END IF

tab_patt.tabpage_criteria.dw_criteria.SetRedraw (TRUE)

// FDG 09/25/00	Begin
//	If a column was selected in dw_criteria, then add the column to the list
//	of selected columns (dw_selected).
IF	Upper (as_column)	=	'COLUMN_DESCRIPTION'		&
AND al_row				>	0								THEN
	ls_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [al_row]
	ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [al_row]
	IF	ls_col_name	=	'DAYS'				&
	OR	ls_col_name	=	'OCCURRENCES'		&
	OR	ls_col_name	=	'PROVIDERS'			THEN
	ELSE
		ls_find		=	"elem_name = '"	+	ls_col_name		+	&
							"' and elem_tbl_type = '"	+	ls_tbl_type	+	"'"
		ll_avail_rowcount	=	tab_patt.tabpage_custom.dw_available.RowCount()
		ll_find_row	=	tab_patt.tabpage_custom.dw_available.Find (ls_find, 1, ll_avail_rowcount)
		IF	ll_find_row	>	0		THEN
			//tab_patt.tabpage_custom.dw_available.SelectRow (ll_find_row, TRUE)
			ll_select_count	=	tab_patt.tabpage_custom.dw_selected.RowCount()
			tab_patt.tabpage_custom.dw_available.RowsMove	(ll_find_row,						&
																			ll_find_row,						&
																			Primary!,								&
																			tab_patt.tabpage_custom.dw_selected,	&
																			ll_select_count + 1,					&
																			Primary!)
			ll_avail_rowcount		--
		END IF
	END IF
END IF
// FDG 09/25/00	End
		
	

// Set the 'Combination' column in the options tab based on if there is a set.
This.Event	ue_edit_options_tab()

// Reset the contents of dw_report
This.Event	ue_reset_dw_report()

Return	1


end event

event type integer ue_edit_custom_criteria(long al_row, string as_column, string as_data);//*********************************************************************************
// Script Name:	ue_edit_custom_criteria
//
//	Arguments:		1.	al_row - Current row # in dw_criteria
//						2.	as_column - Column name that changed
//						3. as_data - The data desired to be changed.
//
// Returns:			Integer.
//						-1	=	Error
//						 1	=	Successful
//
//	Description:	This event is triggered from the itemchanged event of dw_criteria.
//						This event will edit the changed data to the other criteria data.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/18/02	GaryR	Track 2563d	Empty string in SQL
//	01/04/07	GaryR	SPR 4773	Make provider numbered patterns NPI compliant
//
//*********************************************************************************

Boolean	lb_exception

Long		ll_row,					&
			ll_curr_row,			&
			ll_find_row,			&
			ll_rowcount
			
String	ls_field_also,			&
			ls_curr_field_also,	&
			ls_field_lookup,		&
			ls_field_set,			&
			ls_col_name,			&
			ls_tbl_type,			&
			ls_desc,					&
			ls_parm_label

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()
			
ll_curr_row		=	tab_patt.tabpage_criteria.dw_criteria.GetRow()

IF	ll_curr_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_edit_custom_criteria, '	+	&
					' could not get the current row in dw_criteria.')
	Return	-1
END IF

// Set the exception flag to bypass filling all field names with the
//	selected field name for these patterns
CHOOSE CASE Upper (is_pattern_id)
	CASE	'PAT0000031', 'PAT0000032', ics_patt33, ics_patt34, ics_patt35, &
			ics_patt36, ics_patt37, ics_patt38, ics_patt39
		lb_exception	=	TRUE
	CASE ELSE
		lb_exception	=	FALSE
END CHOOSE

//	01/18/02	GaryR	Track 2563d
ls_curr_field_also	=	Trim( tab_patt.tabpage_criteria.dw_criteria.object.field_also [ll_curr_row] )

IF	Len (ls_curr_field_also)	>	0		THEN
	// 'field_also' exists for this current row.  Set the column in each row to the column
	// in the current row.
	ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_curr_row]
	ls_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_curr_row]
	ls_desc			=	tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_curr_row]
	FOR	ll_row	=	1	TO	ll_rowcount
		IF	ll_row					<>	ll_curr_row				&
		AND ls_field_also			=	ls_curr_field_also	&
		AND ls_curr_field_also	>	''							THEN
			ls_field_set		=	tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]
			// Get the label from patt_field_parm
			ls_parm_label		=	This.wf_get_parm_label (ls_field_set, ls_tbl_type, ls_col_name)
			IF	ls_parm_label	=	''					&
			AND lb_exception	=	FALSE				THEN
				ls_parm_label	=	ls_desc
			END IF
			IF	ls_parm_label	<>	''		THEN
				tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_row]	=	ls_parm_label
				tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]		=	ls_tbl_type
				tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]		=	ls_col_name
				tab_patt.tabpage_criteria.dw_criteria.object.column_description [ll_row]	=	ls_tbl_type + &
																														'.' + ls_parm_label
			END IF
		END IF
	NEXT
END IF

// Edit/change 'field_lookup'
This.Event	ue_lookup_exist ('')

ls_field_lookup		=	tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_curr_row]

FOR	ll_row	=	1	TO	ll_rowcount
	//	01/18/02	GaryR	Track 2563d
	ls_field_also		=	Trim( tab_patt.tabpage_criteria.dw_criteria.object.field_also [ll_row] )
	IF	ll_row					<>	ll_curr_row				&
	AND ls_field_also			=	ls_curr_field_also	&
	AND ls_curr_field_also	>	''							THEN
		tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_row]	=	ls_field_lookup
	END IF
NEXT

// Set the current row for future Pattern 12 edits
ii_last_row_label	=	al_row

// Determine if 'field_description' is enabled (based on 'field_alone')
This.Event	ue_protect_field_description()

// Reset the contents of dw_report
This.Event	ue_reset_dw_report()

// Free up any locks
Stars2ca.of_commit()

Return	1


end event

event ue_lookup_exist;//*********************************************************************************
// Script Name:	ue_lookup_exist
//
//	Arguments:		as_from.	'init' means that a pattern was selected/imported.
//									It will = '' in all other cases	
//
// Returns:			None
//
//	Description:	This event will loop through each criteria row to determine
//						if the selected field is a lookup.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long			ll_row,				&
				ll_rowcount
				
String		ls_col_name,		&
				ls_tbl_type,		&
				ls_lookup_type
				

ll_rowcount	=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name	=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]
	ls_tbl_type	=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]
	IF	IsNull (ls_col_name)					&
	OR	Trim (ls_col_name)	=	''			&
	OR	is_pattern_id	=	ics_filter_pat	THEN
		// No column was selected for this row (or a filter pattern).  Initialize field_lookup.
		tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_row]	=	''
	ELSE
		// Field_description was selected.  Get the lookup type from dictionary.
		SELECT	elem_lookup_type
		INTO		:ls_lookup_type
		FROM		Dictionary
		WHERE		elem_type		=	'CL'
		  AND		elem_tbl_type	=	Upper( :ls_tbl_type )
		  AND		elem_name		=	Upper( :ls_col_name )
		USING		Stars2ca ;
		IF	Stars2ca.of_check_status()	=	0		THEN
			tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_row]	=	ls_lookup_type
		ELSE
			tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_row]	=	''
		END IF
	END IF
NEXT

// Free up any locks
Stars2ca.of_commit()

end event

event ue_protect_field_description;//*********************************************************************************
// Script Name:	ue_protect_field_description
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered from ue_edit_custom_criteria (from
//						dw_criteria.itemchanged), and from ue_format_criteria (when a 
//						pattern is selected/imported).
//
//						This script will protect/unprotect 'field_description'. 
//						
//	Note:				The d/w object for dw_criteria protects/unprotects
//						'field_description' based on the value of protect_ind.  If
//						set to 'Y', then the column is protected.
//						
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long			ll_row,					&
				ll_rowcount

String		ls_mod_string,			&
				ls_rc,					&
				ls_protect_ind,		&
				ls_field_col_name,	&
				ls_field_alone
				
ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	// Default to unprotect.
	tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [ll_row]		=	'N'
	IF	is_user_pattern_id	>	' '		THEN
		// User-defined pattern.  Always protect field_description.
		tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [ll_row]	=	'Y'
		Continue
	END IF
	ls_field_col_name	=	Trim (Upper ( tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row] ) )
	ls_field_alone		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_alone [ll_row] )
	//	If the column name is 'DAYS', 'OCCURRENCES', OR 'PROVIDERS', then there are no DDDW options.
	IF	ls_field_col_name	=	'DAYS'			&
	OR	ls_field_col_name	=	'OCCURRENCES'	&
	OR	ls_field_col_name	=	'PROVIDERS'		THEN
		tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [ll_row]	=	'Y'
		Continue
	END IF
	// If field_alone exists, then protect it.
	IF	Len (ls_field_alone)	>	0		THEN
		tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [ll_row]	=	'Y'
		Continue
	END IF
	// If the column_description DDDW only has one row from patt_field_parm,
	//	then protect it.
	This.Event	ue_filter_criteria_dddw (ll_row)
NEXT

tab_patt.tabpage_criteria.dw_criteria.SetRedraw (TRUE)

//ls_mod_string	=	"field_description.Protect = '0~tIf(Len(field_alone)>0,1,0)'"
//
//ls_rc				=	tab_patt.tabpage_criteria.dw_criteria.Modify (ls_mod_string)
//
//IF	ls_rc	<>	''	THEN
//	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_protect_field_description, '	+	&
//					'cannot modify dw_criteria.  Return = '	+	ls_rc	+	'.')
//END IF

//ii_cust_proc	=	0



end event

event ue_subset();//*********************************************************************************
// Script Name:	ue_subset
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the Subset RMM (from the Report Tab)
//						is selected.  This event will create the subset based on the
//						report.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	03/21/01	FDG	Stars 4.7.	Get next job ID from Stars Server.
//	03/26/01	GaryR	Stars 4.7 - Move the Stars Server Functionality to w_subset_options.
//	08/08/01	GaryR	Track 2396d Functional flaw creating subsets
//	02/24/05	GaryR	Track 4317d	Remove active case requirement
// 02/01/07 Katie SPR 4891 Removed code that was dropping temp tables.
//
//*********************************************************************************

Boolean		lb_union_flag,			&
				lb_found_tbl

Integer		li_rc,					&
				li_col_num,				&
				li_columns,				&
				li_pos,					&
				li_pos2,					&
				li_plus_pos,			&
				li_idx,					&
				li_idx2,					&
				li_idx3,					&
				li_idx4,					&
				li_upper,				&
				li_upper2,				&
				li_upper3

Long			ll_row,					&
				ll_rowcount

String		ls_select,				&
				ls_from,					&
				ls_column,				&
				ls_alias[],				&
				ls_table_alias[],		&
				ls_table_name[],		&
				ls_tbl_type[],			&
				ls_table_type,			&
				ls_subset,				&
				ls_table,				&
				ls_rel_id

SetPointer (HourGlass!)
w_main.SetMicroHelp ('Creating the subset from the pattern...')

// If any data has been filter out of dw_report, unfilter dw_report

IF	tab_patt.tabpage_report.dw_report.FilteredCount()	>	0		THEN
	li_rc	=	tab_patt.tabpage_report.dw_report.SetFilter ('')
	li_rc	=	tab_patt.tabpage_report.dw_report.Filter ()
END IF

// If there is no data in the report, don't create the subset

ll_rowcount	=	tab_patt.tabpage_report.dw_report.Rowcount()

IF	ll_rowcount	=	0		THEN
	MessageBox ('Error', 'Unable to create subset.  Nothing is displayed '	+	&
					'in the report')
	w_main.SetMicroHelp ('Ready')
	Return
END IF

li_columns	=	Integer ( tab_patt.tabpage_report.dw_report.Describe ('DataWindow.Column.Count') )

IF	li_columns	<	1		THEN
	MessageBox ('Error', 'Unable to create subset.  Nothing is displayed '	+	&
					'in the report')
	w_main.SetMicroHelp ('Ready')
	Return
END IF

is_sql	=	Upper (is_sql)
istr_sub_opt.patt_struc.pattern_sql	=	is_sql

// Take off 'Select' portion of the SQL
li_pos		=	Pos (is_sql, 'FROM SUB')
ls_select	=	Mid (is_sql, 1, li_pos - 1)

//	Take off the word 'FROM'
ls_from		=	Mid (is_sql, li_pos)
li_pos		=	Pos (ls_from, ' ')
ls_from		=	Mid (ls_from, li_pos + 1)

// Remove the 'Where' statement
li_pos		=	Pos (ls_from, 'WHERE')
ls_from		=	Mid (ls_from, 1, li_pos - 1)

// Extract the table names and alias from the 'From' clause
DO
	li_idx	++
	li_pos						=	Pos (ls_from, ' ')
	ls_table_alias	[li_idx]	=	Mid (ls_from, li_pos + 1, 1)
	ls_table_name [li_idx]	=	Mid (ls_from, 1, li_pos - 1)
	ls_from						=	Mid (ls_from, li_pos + 4)
	li_rc	=	inv_pattern_sql.uf_parse_subset_table (ls_table_name [li_idx], 	&
																	ls_tbl_type [li_idx],		&
																	ls_subset)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'Cannot retrieve table type from '	+	&
						'u_nvo__pattern_sql.uf_parse_subset_table.  Table name = '	+	&
						ls_table_name [li_idx]	+	'.')
		w_main.SetMicroHelp ('Ready')
		Return
	END IF
LOOP UNTIL	ls_from	=	''		OR	ls_from	=	' '


// Load the main table types into is_pattern_tables.
//	is_patterns_tables is used in wf_load_subset_options().

li_upper		=	UpperBound (ls_tbl_type)

FOR li_idx2	=	1	TO	li_upper
	IF	ls_tbl_type [li_idx2]	<>	''		THEN
		lb_found_tbl		=	FALSE
		// Get the main table type for the dependent table
		li_rc			=	fx_get_stars_rel_rel_id ('DP', ls_tbl_type [li_idx2], '  ', ls_rel_id)
		IF	li_rc	<	0		THEN
			// Dependent table not found.  Place the main table type
			// into is_pattern_tables (if its not already there).
			li_upper2	=	UpperBound (is_pattern_tables)
			FOR li_idx4	=	1	TO	li_upper2
				IF	ls_tbl_type [li_idx2]	=	is_pattern_tables [li_idx4]		THEN
					lb_found_tbl	=	TRUE
					Exit
				END IF
			NEXT
			IF	lb_found_tbl	=	FALSE		THEN
				// Add the main table to is_pattern_tables
				li_idx3	++
				is_pattern_tables [li_idx3]	=	ls_tbl_type [li_idx2]
			END IF
		END IF						//	li_rc < 0
	END IF							// ls_tbl_type [li_idx2] <> ''
NEXT									//	li_idx2 = 1	TO	li_upper

Stars2ca.of_commit()					// Free up any locks

// Create the temp table.
// Insert the ICNs into the temp table.  Please note that there can
//	be multiple ICN columns in the report.  If so, insert each one.
// Also, since the index is specified as ignore dup key, any
// duplicate rows will not be inserted.

//	03/26/01	GaryR	Stars 4.7
//is_table_name	=	inv_pattern_sql.Event	ue_create_temp_table (is_job_id)
is_table_name	=	inv_pattern_sql.Event	ue_create_temp_table()

//	08/08/01	GaryR	Track 2396d Functional flaw creating subsets
istr_sub_opt.server_job_id = inv_pattern_sql.uf_get_server_job_id()

istr_sub_opt.subset_id		=	fx_get_next_key_id ('SUBSET')
istr_sub_opt.subset_name	=	''

IF	Upper(is_table_name)	=	'ERROR'		THEN
	w_main.SetMicroHelp ('Ready')
	Return
END IF
	
// Set up the data to be sent to w_subset_options
li_rc	=	This.wf_load_subset_options()

Stars2ca.of_commit()					// Free up any locks

w_main.SetMicroHelp ('Ready')

OpenWithParm (w_subset_options, istr_sub_opt)

istr_sub_opt	=	Message.PowerObjectParm

Stars2ca.of_commit()					// Free up any locks

// If an error occurred or the user cancels from subset options,
//	undo any database updates performed by this transaction.
//	Do not undo the rows inserted into inv_pattern_sql.ids_report_cols.

IF	istr_sub_opt.status	=	'ERROR'				THEN
	w_main.SetMicroHelp ('Error creating subset.')
	Stars2ca.of_commit()				//	Free up any locks
	Return
ELSEIF	istr_sub_opt.status	=	'CANCEL'		THEN
	w_main.SetMicroHelp ('Subset request cancelled')
	Stars2ca.of_commit()				//	Free up any locks
	Return
END IF

// Disable the Create Subset RMM
This.Event	ue_enable_subset (FALSE)
end event

event ue_report_and_subset();//*********************************************************************************
// Script Name:	ue_report_and_subset
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the Create Report and Subset RMM
//						is selected.  This event will generate the SQL for the pattern (via
//						u_nvo_pattern_sql) and generate the report.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	03/29/01	GaryR	Stars 4.7	Implement Stars Server Functionality
//	01/10/03	GaryR	Track 3405d	Append the prefix to report columns
// 10/06/04 JasonS Track 5651c Report List-move pattern report schedule down below
//										 subset options window so we can use the same case id
//	02/01/07 Katie SPR 4891 Removed code that was dropping temp tables.
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//  05/05/08 RickB SPR 5335  Removed reference to obsolete variable gv_bg_process.
//*********************************************************************************

Boolean		lb_union_flag

Integer		li_rc

SetPointer (HourGlass!)
w_main.SetMicroHelp ('Creating Pattern Report...')

// Issue an Accepttext on each d/w

li_rc	=	This.Event	ue_accepttext (This.Control, TRUE)

IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// Edit the criteria
li_rc	=	This.Event	ue_edit_criteria()

IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// Clear out the previously assigned data in inv_pattern_sql
inv_pattern_sql.uf_clear_data()

// Tell inv_pattern_sql that the report will be run in background mode.
inv_pattern_sql.uf_set_background_flag (TRUE)

// Get the revenue selections
IF This.Event ue_edit_revenue() < 0 THEN Return

IF	is_pattern_id	=	ics_generic		THEN
	// Get the SQL for a generic pattern and place it in istr_sub_opt.patt_struc.pattern_sql
	li_rc	=	This.Event	ue_get_generic_sql()
	IF	li_rc	<	0		THEN
		Stars2ca.of_commit()			//	Free up any locks
		Return
	END IF
ELSE
	// Get the SQL for a non-generic pattern and place it in istr_sub_opt.patt_struc.pattern_sql
	li_rc	=	This.Event	ue_get_spec_sql()
	IF	li_rc	<	0		THEN
		Stars2ca.of_commit()			//	Free up any locks
		Return
	END IF
END IF								//	is_pattern_id	=	ics_generic

lb_union_flag	=	inv_pattern_sql.uf_get_union_flag()

IF	lb_union_flag	=	TRUE		THEN
	This.Event	ue_enable_report_tab (TRUE)
	MessageBox ('Warning', 'The same values have been entered for set fields.  '	+	&
					'This pattern must be run online and will take a great deal of time.  '	+	&
					'To run in background mode, clear the criteria and enter '	+	&
					'different values.')
	This.Event	ue_enable_background (FALSE)
	w_main.SetMicroHelp ('Ready')
	Stars2ca.of_commit()			//	Free up any locks
	Return
END IF							//	lb_union_flag	=	TRUE

// Edit inv_pattern_sql.ids_report_cols to insure that the alias_name has no non-alphanumeric characters
li_rc	=	inv_pattern_sql.uf_edit_report_cols( FALSE )

is_sql	=	istr_sub_opt.patt_struc.pattern_sql

// schedule report using case id from subset options
li_rc		=	This.Event	ue_write_subset_tables()

IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Unable to schedule pattern.')
	Return
else 
	w_main.SetMicroHelp ('Pattern scheduled successfully.  Job created: '	+	istr_sub_opt.patt_struc.job_id)
END IF

istr_sub_opt.subset_id	=	gv_subset_id

Stars2ca.of_commit()				//	Free up any locks

OpenWithParm (w_subset_options, istr_sub_opt)

istr_sub_opt	=	Message.PowerObjectParm



// If an error occurred or the user cancels from subset options,
//	undo any database updates performed by this transaction.

IF	istr_sub_opt.status	=	'ERROR'				THEN
	w_main.SetMicroHelp ('Error creating subset.')
	inv_pattern_sql.uf_delete_report_cols()
//	This.wf_delete_subset_data()				//	03/29/01	GaryR	Stars 4.7
	Stars2ca.of_commit()				//	Free up any locks
	Return
ELSEIF	istr_sub_opt.status	=	'CANCEL'		THEN
	w_main.SetMicroHelp ('Subset request cancelled')
	inv_pattern_sql.uf_delete_report_cols()
//	This.wf_delete_subset_data()				//	03/29/01	GaryR	Stars 4.7
	Stars2ca.of_commit()				//	Free up any locks
	Return
END IF



// The pattern and subset was scheduled successfully

// If coming from the Pattern button in Subset Options, the job ID was pre-set
//	and cannot be changed.  As a result the RMM must be disabled to prevent
// duplicate inserts.
IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	THEN
	This.Event	ue_enable_background (FALSE)
END IF

end event

event ue_get_generic_sql;//*********************************************************************************
// Script Name:	ue_get_generic_sql
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered when the Report tab is clicked
//						(ue_view_report) and when the 'Create Subset' RMM is clicked
//						(ue_report_and_subset).
//
//						This event will use inv_pattern_sql to generate the SQL for
//						a Generic pattern and move it to 
//						istr_sub_opt.patt_struc.pattern_sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc

Long			ll_row

String		ls_inv_type[]

// Has the options tab been displayed?  If not, display a warning message.

IF	ib_options_tab	=	FALSE		THEN
	li_rc	=	MessageBox ('Warning', 'You are attempting to generate the report before '	+	&
								'viewing the contents of the Options tab.  Would you like '		+	&
								'to continue generating the report?', Question!, YesNo!, 1)
	IF	li_rc	=	2		THEN
		// User selected No.  Cancel the report and display the options tab.
		tab_patt.SelectTab (ici_options)
		tab_patt.tabpage_options.dw_patt_options.SetFocus()
		Return	-1
	END IF
END IF

// Initialize any data required in inv_pattern_sql
This.Event	ue_init_pattern_sql()

// Edit the criteria and generate the pattern sql.

li_rc		=	inv_pattern_sql.uf_edit_generic_criteria ()

IF	li_rc	<	0		THEN
	Return	li_rc
END IF

istr_sub_opt.patt_struc.pattern_sql		=	inv_pattern_sql.Event	ue_pattern_sql()

// Because unique key columns can be moved to dw_selected, reset the row count.
This.Event	ue_custom_set_count()

IF	Upper (istr_sub_opt.patt_struc.pattern_sql)	=	'ERROR'		THEN
	Return	-1
END IF

Return	1

end event

event ue_enable_import;//*********************************************************************************
// Script Name:	ue_enable_import
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the import RMM
//						FALSE	-	Disable the import RMM
//
// Returns:			None
//
//	Description:	Enable/disable the import RMM depending on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_list.m_dummyitem.m_importpattern.enabled		=	ab_switch

end event

event ue_init_pattern_sql;//*********************************************************************************
// Script Name:	ue_init_pattern_sql
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered when the Report tab is clicked
//						(ue_view_report) and when the 'Create Subset' RMM is clicked
//						(ue_report_and_subset) for both generic patterns and
//						non-generic patterns.
//
//						This event will initialize inv_pattern_sql for generic patterns
//						and non-generic patterns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc

Long			ll_row

String		ls_inv_type[]

// Get the data from istr_sub_opt and load it in inv_pattern_sql
inv_pattern_sql.uf_set_sub_src_type (istr_sub_opt.patt_struc.sub_src_type)
inv_pattern_sql.uf_set_subset_id (istr_sub_opt.patt_struc.subset_id)
inv_pattern_sql.uf_set_case_id (is_case_id + is_case_spl + is_case_ver)	// Pass the 14-byte case_id

inv_pattern_sql.uf_set_last_label_row (ii_last_row_label)
inv_pattern_sql.uf_set_pattern_id (is_pattern_id)

// Load the invoice types to inv_pattern_sql
			
ll_row		=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

IF	ll_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_init_pattern_sql, '	+	&
					' could not get the current row in dw_patt_cntl.')
	Return
END IF

IF	is_inv_type	=	'ML'		THEN
	inv_pattern_sql.uf_set_subset_tbl_type (istr_sub_opt.patt_struc.table_type)
ELSE
	ls_inv_type [1]	=	is_inv_type
	inv_pattern_sql.uf_set_subset_tbl_type (ls_inv_type)
END IF

// Initialize the "NOT IN" checkbox in inv_pattern_sql
IF	tab_patt.tabpage_criteria.cbx_not.checked	=	TRUE		THEN
	inv_pattern_sql.uf_set_not_flag (TRUE)
ELSE
	inv_pattern_sql.uf_set_not_flag (FALSE)
END IF


end event

event ue_get_spec_sql;//*********************************************************************************
// Script Name:	ue_get_spec_sql
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered when the Report tab is clicked
//						(ue_view_report) and when the 'Create Subset' RMM is clicked
//						(ue_report_and_subset).
//
//						This event will use inv_pattern_sql to generate the SQL for
//						a non-generic pattern and move it to 
//						istr_sub_opt.patt_struc.pattern_sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc

Long			ll_row

String		ls_inv_type[]

// Initiale any data required in inv_pattern_sql
This.Event	ue_init_pattern_sql()

istr_sub_opt.patt_struc.pattern_sql		=	inv_pattern_sql.Event	ue_spec_sql()

IF	Upper (istr_sub_opt.patt_struc.pattern_sql)	=	'ERROR'		THEN
	Return	-1
END IF

istr_sub_opt.patt_struc.pattern_id		=	is_pattern_id
istr_sub_opt.patt_struc.invoice_type	=	is_inv_type

Return	1

end event

event ue_enable_report_tab;//*********************************************************************************
// Script Name:	ue_enable_report_tab
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the 'Report' tab
//						FALSE	-	Disable the 'Report' tab
//
// Returns:			None
//
//	Description:	Enable/disable the 'Report' tab depending on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

tab_patt.tabpage_report.enabled	=	ab_switch

// Enable/Disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()

end event

event ue_enable_background;//*********************************************************************************
// Script Name:	ue_enable_background
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the background RMM (Pattern Report and Subset)
//						FALSE	-	Disable the background RMM (Pattern Report and Subset)
//
// Returns:			None
//
//	Description:	Enable/disable the 'Pattern Report and Subset' RMM 
//						depending on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_save.m_patternreportandcreatesubset.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_save.m_patternreportandcreatesubset.enabled		=	ab_switch
im_patt_timeframe.m_dummyitem.m_save.m_patternreportandcreatesubset.enabled	=	ab_switch
im_patt_custom.m_dummyitem.m_save.m_patternreportandcreatesubset.enabled		=	ab_switch

end event

event type integer ue_write_subset_tables();//*********************************************************************************
// Script Name:	ue_write_subset_tables
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered when the 'Create Report and Subset' RMM 
//						is clicked (ue_report_and_subset).
//
//						This event will generate the necessary data in order to create
//						a subset (w_subset_options).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	01/12/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	03/12/01	FDG	Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
//	03/26/01	GaryR	Stars 4.7 DataBase Port - Obtain the Job Id from Stars Server
//	01/24/03	GaryR	Track 3222d	Default the pattern report description
// 10/06/04 Jason	Track 5651c Report List changes, set bg step cntl case id = that in 
//										inv_pattern_sql, REMOVE ANY CASE REQUIREMENTS
//	02/07/05	GaryR	Track 4275d	Previous fix (5651c), erroneously commented out update logic.
//	02/11/05	GaryR	Track 4279d	Trim Case split and version for Oracle
//	02/14/05	GaryR	Track 4287d	Add logic for new subset background patterns missed with 5651c.
//*********************************************************************************

Boolean	lb_found			

DateTime	ldtm_default_datetime

Integer	li_after_place_holder,		&
			li_index,						&
			li_idx,							&
			li_len,							&
			li_max_sql_lines,				&
			li_number_tables,				&
			li_pos,							&
			li_rc,							&
			li_sql_row,						&
			li_tbl,							&
			li_tbl_count,					&
			li_total_steps,				&
			li_upper,						&
			li_upperbound_tbl_type,		&
			li_x,								&
			li_y

Long		ll_row, ll_job_id

String	ls_case_id,						&
			ls_case_spl,					&
			ls_case_ver,					&
			ls_case,							&
			ls_clear_array[],				&
			ls_compare_keys,				&
			ls_days,							&
			ls_empty,						&
			ls_job_id,						&
			ls_main_tbl[],					&
			ls_rpt_id,						&
			ls_sql[],						&
			ls_sql_statement,				&
			ls_src_subset_name,			&
			ls_string,						&
			ls_subc_desc

nvo_subset_functions		lnv_subset_Functions

sx_subset_ids				lstr_subset_ids

sx_main_tbl					lstr_main_tbl

sx_pattern_tbl_types		lstr_tbl_types

sx_subset_options			lstr_sub_opt

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ls_rpt_id		=	fx_get_next_key_id ('REPORT')

// Determine if the subset case matches the current case

ls_case	=	Trim (is_case_id	+	is_case_spl	+	is_case_ver)

ldtm_default_datetime = Datetime (Date('01/01/1900'))		

gv_subset_id	=	fx_get_next_key_id ('SUBSET')
gv_crit_name	=	fx_get_next_key_id ('CRITERIA')

// Get the main_tbl info set within inv_pattern_sql
lstr_main_tbl	=	inv_pattern_sql.uf_get_sx_main_tbl()
ls_main_tbl		=	lstr_main_tbl.s_main_tbl

// First set the values of some variables depending on 
// whether the subset currently exists.
IF istr_sub_opt.patt_struc.come_from = 'SUB_OPT' THEN
	li_total_steps	=	istr_sub_opt.patt_struc.total_steps + 1 
	ls_job_id		=	istr_sub_opt.patt_struc.job_id
ELSE
	li_total_steps	=	1
	li_rc	=	gnv_server.of_JobCreate( ll_job_id )
	IF li_rc < 0 THEN
		MessageBox ('ERROR', 'Pattern could not be scheduled.~r'	+	&
						'Problem in obtaining job_id')
		Stars2ca.of_rollback()
		Return -1
	END IF
	ls_job_id = String( ll_job_id )
	istr_sub_opt.server_job_id = ll_job_id
//	03/26/01	GaryR	Stars 4.7 DataBase Port - End	
	istr_sub_opt.patt_struc.job_id = ls_job_id
END IF

//NLG 10-23 get source subset name to write to bg_step_cntl
lnv_subset_functions = CREATE nvo_subset_functions
lstr_subset_ids.subset_id = istr_sub_opt.patt_struc.subset_id
lstr_subset_ids.subset_case_id = left(istr_sub_opt.patt_struc.case_id,10)
lstr_subset_ids.subset_case_spl = mid(istr_sub_opt.patt_struc.case_id,11,2)
lstr_subset_ids.subset_case_ver = mid(istr_sub_opt.patt_struc.case_id,13,2)

li_rc = lnv_subset_functions.uf_set_structure(lstr_subset_ids)
li_rc = lnv_subset_functions.uf_retrieve_subset_name()

IF li_rc > 0 THEN
	lstr_subset_ids = lnv_subset_functions.uf_get_structure()
	ls_src_subset_name = lstr_subset_ids.subset_name
ELSE
	ls_src_subset_name = istr_sub_opt.patt_struc.subset_id
END IF

li_sql_row = 0
ids_bg_Step_Cntl.reset()

//	01/12/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( gv_crit_name ) = "" THEN gv_crit_name = ls_empty

ll_row = ids_bg_Step_Cntl.insertrow(0)
ids_bg_step_cntl.SetRow (ll_row)
ids_bg_step_cntl.SetItem (ll_row,'job_id',ls_job_id)
ids_bg_step_cntl.SetItem (ll_row,'step_num',li_total_steps)
ids_bg_step_cntl.SetItem (ll_row,'step_type','PATTERN')
ids_bg_step_cntl.SetItem (ll_row,'error_msg',' ')
ids_bg_step_cntl.SetItem (ll_row,'start_date',ldtm_default_datetime)
ids_bg_step_cntl.SetItem (ll_row,'end_date',ldtm_default_datetime)
ids_bg_step_cntl.SetItem (ll_row,'rows_affected',0)
ids_bg_step_cntl.SetItem (ll_row,'step_status',' ')
ids_bg_step_cntl.SetItem (ll_row,'use_temp_table_ind','N')
ids_bg_step_cntl.SetItem (ll_row,'Delete_Source_Ind','N')
ids_bg_step_cntl.SetItem (ll_row,'paid_from_date',ldtm_default_datetime)
ids_bg_step_cntl.SetItem (ll_row,'paid_thru_date',ldtm_default_datetime)
ids_bg_step_cntl.SetItem (ll_row,'inv_type',' ')
ids_bg_step_cntl.SetItem (ll_row,'subset_type',' ')
ids_bg_step_cntl.SetItem (ll_row,'subc_sub_src_type','SS')
ids_bg_step_cntl.SetItem (ll_row,'subc_crit_id',gv_crit_name)
ids_bg_step_cntl.SetItem (ll_row,'input_type','SUBSET')
ids_bg_step_cntl.SetItem (ll_row,'input_id',istr_sub_opt.patt_struc.subset_id)
ids_bg_step_cntl.SetItem (ll_row,'src_case_id',' ')
ids_bg_step_cntl.SetItem (ll_row,'src_subc_name',ls_src_subset_name)
ids_bg_step_cntl.SetItem (ll_row,'output_id',ls_rpt_id)
ids_bg_step_cntl.SetItem (ll_row,'subc_name',' ')

IF is_pattern_id	=	ics_patt17		THEN
	li_pos	=	Pos (istr_sub_opt.patt_struc.pattern_sql, '#')
   	is_sql = Left (istr_sub_opt.patt_struc.pattern_sql, li_pos - 1)
	ls_days   = Trim (Mid(istr_sub_opt.patt_struc.pattern_sql, li_pos + 1))
	ls_subc_desc = '17~~' + ls_days
ELSEIF is_pattern_id	=	ics_patt20	THEN
	This.wf_setup_proc_codes()  
	ls_subc_desc = '20~~' + is_proc_set1	+ '~~' + is_proc_set2 + '~~' + is_proc_set3
ELSE
	ls_subc_desc = ' '
END IF

ls_subc_desc = "Pat:" + is_pattern_name + " on Sub:" + is_subset_name + " by" + &
		gc_user_id + " " + String( Datetime( Today(), Now() ), "mm/dd/yyyy hh:mm" )
IF IsNull( ls_subc_desc	) THEN ls_subc_desc = " "

ids_bg_step_cntl.SetItem (ll_row,'subc_desc', ls_subc_desc)

ls_case_id = Trim( inv_pattern_sql.is_case_id )
ls_case_spl = Trim( inv_pattern_sql.is_case_spl )
ls_case_ver = Trim( inv_pattern_sql.is_case_ver )
IF ls_case_spl = "" THEN ls_case_spl = ls_empty
IF ls_case_ver = "" THEN ls_case_ver = ls_empty

ids_bg_step_cntl.SetItem (ll_row,'case_id',ls_case_id )
ids_bg_step_cntl.SetItem (ll_row,'case_spl',ls_case_spl)
ids_bg_step_cntl.SetItem (ll_row,'case_ver',ls_case_ver)

IF len(is_sql) <= 80 THEN
  ls_sql[1] = is_sql
ELSE
  ls_sql_statement = is_sql
  li_index = 1
  DO
	 ls_sql[li_index] = mid(ls_sql_statement,1,80)
	 ls_sql_statement = mid(ls_sql_statement,81)
	 li_len = len(ls_sql_statement)
	 li_index = li_index + 1
  LOOP UNTIL li_len = 0
END IF
  
ids_bg_Sql_Line.reset()
li_sql_row = 0
li_max_sql_lines = UpperBound (ls_sql)

FOR li_index = 1 TO li_max_sql_lines
	ids_bg_Sql_Line.InsertRow(0)
	li_sql_row++
	ls_string = UPPER(ls_sql[li_index])
	ids_bg_sql_line.SetItem (li_sql_row,'job_id',ls_job_id)
	ids_bg_sql_line.SetItem (li_sql_row,'step_num',li_total_steps)
	ids_bg_sql_line.SetItem (li_sql_row,'line_num',li_index)
	ids_bg_sql_line.SetItem (li_sql_row,'sql_line',ls_string)
NEXT

li_x = 1			

is_tbl_type		=	ls_clear_array

li_rc				=	This.wf_dependency()
IF li_rc	<	0		THEN
	Return	-1
END IF

IF istr_sub_opt.patt_struc.come_from = 'SUB_OPT' THEN
	istr_sub_opt.come_from = 'PATTSUB'
ELSE
	istr_sub_opt.come_from = 'PATTERN'
END IF

// Reset istr_sub_opt.sub_info[] from the prior execution.
istr_sub_opt.sub_info	=	lstr_sub_opt.sub_info

li_number_tables = UpperBound (is_tbl_type)
//HRB - changed temp table name to ICN_{ls_job_id}
FOR li_tbl = 1 TO li_number_tables
	// Load the prefixes ('I' and 'S') and tbl types to set up the join with
	// the temp table.
	inv_pattern_sql.uf_clear_from_tables()
	inv_pattern_sql.uf_set_tbl_type ('I', is_tbl_type[li_tbl] )
	inv_pattern_sql.uf_set_tbl_type ('S', is_tbl_type[li_tbl] )
	// Get the join on the unique keys (i.e. I.C1_ICN = S.ICN AND I.C1_ICN_LINE_NO = S.ICN_LINE_NO)
	//	The columns in the the temp table have the table type as its prefix (i.e. C1_ICN).
	ls_compare_keys	=	inv_pattern_sql.uf_compare_keys (1, 2)
	// Fill in istr_sub_opt
	istr_sub_opt.sub_info[li_tbl].source_subset_id = istr_sub_opt.patt_struc.subset_id 
	istr_sub_opt.sub_info[li_tbl].subset_step[1].paid_from_date = ldtm_default_datetime
	istr_sub_opt.sub_info[li_tbl].subset_step[1].paid_thru_date = ldtm_default_datetime
	istr_sub_opt.sub_info[li_tbl].subset_step[1].inv_type = is_tbl_type[li_tbl]
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subset_type =	istr_sub_opt.patt_struc.subset_table_type
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subc_sub_src_type = 'SS'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].input_type = 'ICN'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].input_id =	istr_sub_opt.patt_struc.subset_id
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subc_sub_src_case_id =	istr_sub_opt.patt_struc.case_id
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - Begin
	// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].sql_statement = 'SELECT S.* FROM ' + &
				UPPER(gnv_sql.of_get_database_prefix( STARS2CA.DATABASE )) + 'KEY_' + &
				upper(ls_job_id) + ' I, ' + UPPER(gnv_sql.of_get_database_prefix( STARS2CA.DATABASE )) + &
				gnv_sql.of_get_subset_prefix() +	upper(is_tbl_type[li_tbl]) + '_' + &
				upper(ISTR_SUB_OPT.PATT_STRUC.SUBSET_ID) + ' S WHERE ' +	ls_compare_keys +	' '
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - End
	istr_sub_opt.sub_info[li_tbl].criteria[1].left_paren = ' '
	istr_sub_opt.sub_info[li_tbl].criteria[1].expression_one = 'PATTERN'
	istr_sub_opt.sub_info[li_tbl].criteria[1].rel_operator = '='
	istr_sub_opt.sub_info[li_tbl].criteria[1].expression_two = is_pattern_id
	istr_sub_opt.sub_info[li_tbl].criteria[1].right_paren = ' '
	istr_sub_opt.sub_info[li_tbl].criteria[1].Logical_operator = ' '
	istr_sub_opt.sub_info[li_tbl].criteria[1].data_type = 'CHAR'

NEXT

li_after_place_holder = li_tbl
li_upper						=	UpperBound (istr_sub_opt.patt_struc.table_type)

IF li_upper	>	1		THEN
	// ML subset.  Get the "left over" table types and include them in the
	//	structure (to be passed to subset options).
	is_left_over_tbl_types	=	ls_clear_array
	li_rc = This.wf_get_left_over_tbl_types()
	IF li_rc = -1 THEN
		Return -1
	END IF
	li_tbl_count = UpperBound (is_left_over_tbl_types)
	IF li_tbl_count > 0 THEN
		IF is_left_over_tbl_types[li_tbl_count] = '' THEN 
			li_tbl_count --
		END IF
		li_rc = This.wf_add_left_over_tbl_types (li_tbl_count,						&
															li_after_place_holder,				&
															ldtm_default_datetime)		
		is_left_over_tbl_types	=	ls_clear_array
		IF li_rc = -1 THEN
			Return -1
		END IF
	END IF
END IF

// Update the data inserted into report_cols
li_rc		=	inv_pattern_sql.uf_update_report_cols(ls_rpt_id)

IF li_rc	<	1		THEN
	MessageBox ('ERROR', 'Pattern could not be scheduled.~r'	+	&
					'Error inserting data into report_cols')
	Stars2ca.of_rollback()
	Return -1
END IF

Stars2ca.of_commit()

Return	1
end event

event ue_pattern_17();//*********************************************************************************
// Script Name:	ue_pattern_17
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered from ue_view_report.  This
//						event will generate the report for pattern 17.
//
//	Note:				The SQL has already been placed into is_sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

Integer	li_pos,						&
			li_rc

Long		ll_row,						&
			ll_rowcount

String	ls_days,						&
			ls_sql,						&
			ls_hicn,						&
			ls_prior_hicn,				&
			ls_sort,						&
			ls_modify,					&
			ls_describe,				&
			ls_col_name

// Remove Code/Decode from Window Operations
This.Event	ue_enable_decode (FALSE)

// Get the SQL to the left of '#'.  The # of days is to the right of '#'.
li_pos		=	Pos (istr_sub_opt.patt_struc.pattern_sql, '#')
ls_days		=	Trim ( Mid(istr_sub_opt.patt_struc.pattern_sql, li_pos + 1) )
il_consecutive_days	=	Long (ls_days)

// Retrieve the data into dw_3
il_rowcount	=	dw_3.Retrieve()

FOR	il_row	=	1	TO	il_rowcount
	ls_hicn		=	dw_3.GetItemString (il_row, ici_hicn)
	IF	il_row	=	1		THEN
		// First row
		li_rc		=	This.wf_sample_17_20_prep_hicn_rows()
		ls_prior_hicn	=	ls_hicn
	ELSE
		// Not the first row
		IF	ls_hicn	=	ls_prior_hicn		THEN
			// Still processing the same HICN
			li_rc		=	This.wf_sample_17_20_prep_hicn_rows()
		ELSE
			// New HICN encountered.  First evaluate and print the prior HICN.
			li_rc		=	This.wf_sample_17_mark_hicn_rows()
			li_rc		=	This.wf_sample_17_print_hicn_rows()
			li_rc		=	This.wf_sample_17_20_prep_hicn_rows()
			ls_prior_hicn	=	ls_hicn
		END IF				//	ls_hicn	=	ls_prior_hicn
	END IF					//	il_row	=	1
NEXT

// Process the last HICN
li_rc		=	This.wf_sample_17_mark_hicn_rows()
li_rc		=	This.wf_sample_17_print_hicn_rows()

// Final sort by HICN, From Date, To Date
ls_sort	=	'#'	+	String (ici_hicn)	+	' A, '	+	&
				'#'	+	String (ici_from_date_col)	+	' A, '	+	&
				'#'	+	String (ici_to_date_col)	+	' A'

li_rc		=	tab_patt.tabpage_report.dw_report.SetSort (ls_sort)
li_rc		=	tab_patt.tabpage_report.dw_report.Sort ()

// Set the count box on tabpage_report
ll_rowcount	=	tab_patt.tabpage_report.dw_report.RowCount()
tab_patt.tabpage_report.st_count.text	=	String (ll_rowcount)

ls_modify	=	"report_number.text="	+	"~'("		+	&
					is_pattern_id	+	")~'"
// Make the print_ind invisible
ls_describe	=	"#"	+	String (ici_print_ind, "00")	+	".Name"
ls_col_name	=	tab_patt.tabpage_report.dw_report.Describe (ls_describe)
ls_modify	=	ls_modify	+	" "	+	ls_col_name	+	".visible=0"

tab_patt.tabpage_report.dw_report.Modify (ls_modify)
ls_modify	=	ls_col_name	+	".width=0"
tab_patt.tabpage_report.dw_report.Modify (ls_modify)
end event

event ue_pattern_20();//*********************************************************************************
// Script Name:	ue_pattern_20
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered from ue_view_report.  This
//						event will generate the report for pattern 20.
//
//	Note:				The SQL has already been placed into is_sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

Integer	li_pos,						&
			li_in_pos,					&
			li_l_pos,					&
			li_r_pos,					&
			li_rc

Long		ll_row,						&
			ll_rowcount

String	ls_days,						&
			ls_sql,						&
			ls_hicn,						&
			ls_prior_hicn,				&
			ls_sort,						&
			ls_modify,					&
			ls_describe,				&
			ls_col_name


// Remove Code/Decode from Window Operations
This.Event	ue_enable_decode (FALSE)

// Set the values for is_proc_set1, is_proc_set2, is_proc_set3.
// In the SQL, looking for "in(a,b,c)".

//	Get is_proc_set1
li_in_pos		=	Pos (is_sql, ' IN')
li_l_pos			=	Pos (is_sql, '(', li_in_pos)
li_r_pos			=	Pos (is_sql, ')', li_in_pos)
is_proc_set1	=	Mid (is_sql, li_l_pos + 2, li_r_pos - li_l_pos - 3)	+	','
li_pos			=	1
// Loop through and pull out single quotes
DO
	li_pos	=	Pos (is_proc_set1, "'", li_pos)
	IF	li_pos	>	0		THEN
		is_proc_set1	=	Left (is_proc_set1, li_pos - 1)	+	&
								Mid  (is_proc_set1, li_pos + 1)
	END IF
LOOP UNTIL	li_pos	<=	0

//	Get is_proc_set2
li_in_pos		=	Pos (is_sql, ' IN', li_r_pos)
li_l_pos			=	Pos (is_sql, '(', li_in_pos)
li_r_pos			=	Pos (is_sql, ')', li_in_pos)
is_proc_set2	=	Mid (is_sql, li_l_pos + 2, li_r_pos - li_l_pos - 3)	+	','
li_pos			=	1
// Loop through and pull out single quotes
DO
	li_pos	=	Pos (is_proc_set2, "'", li_pos)
	IF	li_pos	>	0		THEN
		is_proc_set2	=	Left (is_proc_set2, li_pos - 1)	+	&
								Mid  (is_proc_set2, li_pos + 1)
	END IF
LOOP UNTIL	li_pos	<=	0

//	Get is_proc_set3
li_in_pos		=	Pos (is_sql, ' IN', li_r_pos)
li_l_pos			=	Pos (is_sql, '(', li_in_pos)
li_r_pos			=	Pos (is_sql, ')', li_in_pos)
is_proc_set3	=	Mid (is_sql, li_l_pos + 2, li_r_pos - li_l_pos - 3)	+	','
li_pos			=	1
// Loop through and pull out single quotes
DO
	li_pos	=	Pos (is_proc_set3, "'", li_pos)
	IF	li_pos	>	0		THEN
		is_proc_set3	=	Left (is_proc_set3, li_pos - 1)	+	&
								Mid  (is_proc_set3, li_pos + 1)
	END IF
LOOP UNTIL	li_pos	<=	0


// Retrieve the data into dw_3
il_rowcount	=	dw_3.Retrieve()

FOR	il_row	=	1	TO	il_rowcount
	ls_hicn		=	dw_3.GetItemString (il_row, ici_hicn)
	IF	il_row	=	1		THEN
		// First row
		li_rc		=	This.wf_sample_17_20_prep_hicn_rows()
		ls_prior_hicn	=	ls_hicn
	ELSE
		// Not the first row
		IF	ls_hicn	=	ls_prior_hicn		THEN
			// Still processing the same HICN (recip_id)
			li_rc		=	This.wf_sample_17_20_prep_hicn_rows()
		ELSE
			// New HICN (recip_id) encountered.  First evaluate and print the prior HICN.
			li_rc		=	This.wf_sample_20_mark_rows_for_printing()
			li_rc		=	This.wf_sample_20_print_hicn_rows()
			li_rc		=	This.wf_sample_17_20_prep_hicn_rows()
			ls_prior_hicn	=	ls_hicn
		END IF				//	ls_hicn	=	ls_prior_hicn
	END IF					//	il_row	=	1
NEXT

// Process the last HICN (recip_id)
li_rc		=	This.wf_sample_20_mark_rows_for_printing()
li_rc		=	This.wf_sample_20_print_hicn_rows()

// Final sort by HICN (recip_id), From Date, To Date
ls_sort	=	String (ici_hicn)	+	' A, '	+	&
				String (ici_from_date_col)	+	' A, '	+	&
				String (ici_to_date_col)	+	' A'

li_rc		=	tab_patt.tabpage_report.dw_report.SetSort (ls_sort)
li_rc		=	tab_patt.tabpage_report.dw_report.Sort ()

// Set the count box on tabpage_report
ll_rowcount	=	tab_patt.tabpage_report.dw_report.RowCount()
tab_patt.tabpage_report.st_count.text	=	String (ll_rowcount)

ls_modify	=	"report_number.text="	+	"~'("		+	&
					is_pattern_id	+	")~'"
tab_patt.tabpage_report.dw_report.Modify (ls_modify)

// Make the print_ind invisible
ls_describe	=	"#"	+	String (ici_print_ind, "00")	+	".Name"
ls_col_name	=	tab_patt.tabpage_report.dw_report.Describe (ls_describe)
ls_modify	=	ls_modify	+	" "	+	ls_col_name	+	".visible=0"

tab_patt.tabpage_report.dw_report.Modify (ls_modify)

ls_modify	=	ls_col_name	+	".width=0"

tab_patt.tabpage_report.dw_report.Modify (ls_modify)


end event

event ue_enable_decode;//*********************************************************************************
// Script Name:	ue_enable_decode
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the code/decode RMM
//						FALSE	-	Disable the code/decode RMM
//
// Returns:			None
//
//	Description:	Enable/disable the Report tab's code/decode RMM depending 
//						on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_report.m_dummyitem.m_windowoperations.m_codedecode.enabled		=	ab_switch

end event

event type integer ue_create_datawindows();//*********************************************************************************
// Script Name:	ue_create_datawindows
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered from ue_view_report when the report tab 
//						is clicked.  This event will create the datawindows for
//						dw_report, dw_2 and dw_3.  dw_2 & dw_3 are used for patterns
//						17 and 20.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/05/07	GaryR	SPR 4773	Make provider numbered patterns NPI compliant
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

Integer		li_rc,				&
				li_pos,				&
				li_width

Long			ll_rowcount,		&
				ll_row

String		ls_style,			&
				ls_syntax,			&
				ls_error,			&
				ls_empty[],			&
				ls_rpt_title,		&
				ls_where,			&
				ls_sql,				&
				ls_window_name,	&
				ls_order_by

DateTime		ldtm_curr_datetime

// Get the report title

ll_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_create_datawindows, '	+	&
					'cannot get the current row in dw_patt_options')
	Return	-1
END IF

ls_rpt_title	=	tab_patt.tabpage_options.dw_patt_options.object.rpt_title [ll_row]
ls_order_by		=	' ORDER BY A.RECIP_ID, A.FROM_DATE'

// Modify the SQL for pattern 17.
IF	is_pattern_id	=	ics_patt17		THEN
	li_pos	=	Pos (istr_sub_opt.patt_struc.pattern_sql, '#')
	is_sql	=	Left (istr_sub_opt.patt_struc.pattern_sql, li_pos - 1)	+	&
					ls_order_by
ELSEIF	is_pattern_id	=	ics_patt20		THEN
	is_sql	=	istr_sub_opt.patt_struc.pattern_sql	+	ls_order_by
ELSE
	is_sql	=	istr_sub_opt.patt_struc.pattern_sql
END IF

// Create the datawindows

ls_style		=	"datawindow(units=1 color = "	+	String(stars_colors.window_background)	+	")"	+	&
					" style(type=grid)"	+	&
					"Column(font.Face='System' font.height =-10 font.weight =700)"	+	&
					"Text(font.Face='System' font.height =-10 font.weight =700 )"

// The SQL for patterns 35 - 39 are too complex for PowerBuilder to handle the d/w creation.
// For patterns 35 - 39, remove the 'Where' clause, create the d/w, then reset the SQL.

IF	is_pattern_id	=	ics_patt35			&
OR	is_pattern_id	=	ics_patt36			&
OR	is_pattern_id	=	ics_patt37			&
OR	is_pattern_id	=	ics_patt38			&
OR	is_pattern_id	=	ics_patt39			THEN
	ls_sql	=	Upper (is_sql)
	li_pos	=	Pos (ls_sql, ' WHERE ')
	ls_sql	=	Left (ls_sql, li_pos)
ELSE
	ls_sql	=	is_sql
END IF

ls_syntax	=	SyntaxFromSQL (Stars2ca, 		&
										ls_sql,			&
										ls_style,		&
										ls_error)
										
IF	ls_error	<>	''		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_create_datawindows, '	+	&
					'cannot get the syntax to create the datawindow.  Error text = '	+	ls_error	+	&
					'.  SQL = '	+	ls_sql	+	'.')
	Return	-1
END IF

li_rc	=	tab_patt.tabpage_report.dw_report.Create (ls_syntax)

IF	li_rc	<	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_create_datawindows, '	+	&
					'cannot create the datawindow.  Error text = '	+	ls_error	+	&
					'.  SQL = '	+	ls_sql	+	'.')
	Return	-1
END IF

// Reset the SQL for patterns 35 thru 39.  These patterns perform many subselects

IF	is_pattern_id	=	ics_patt35			&
OR	is_pattern_id	=	ics_patt36			&
OR	is_pattern_id	=	ics_patt37			&
OR	is_pattern_id	=	ics_patt38			&
OR	is_pattern_id	=	ics_patt39			THEN
	tab_patt.tabpage_report.dw_report.SetSQLSelect (is_sql)
END IF

// Store the columns and table types from the SQL into is_sql_col_name[]
//	and is_sql_tbl_type[].  These arrays will be used in wf_labels()
This.wf_get_sql_columns()

//	Add the headers to dw_report.

fx_add_d_head (ls_rpt_title,									&
					tab_patt.tabpage_report.dw_report,		&
					ls_empty[],										&
					'100',											&
					'40',												&
					'300',											&
					'2',												&
					'500')

// Add names to any column headers that currently don't exist.
li_rc	=	This.wf_add_column_headings()

IF	li_rc	<	0		THEN
	Return	-1
END IF

// Add labels to dw_report
li_rc	=	This.wf_labels()

IF	li_rc	<	0		THEN
	Return	-1
END IF

// For Patterns 17 & 20, create dw_2 and dw_3 using the SQL for dw_report.
IF	is_pattern_id	=	ics_patt17		&
OR	is_pattern_id	=	ics_patt20		THEN
	li_rc	=	dw_2.Create (ls_syntax)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_create_datawindows, '	+	&
						'cannot create dw_2.  Error text = '	+	ls_error	+	&
						'.  SQL = '	+	is_sql	+	'.')
		Return	-1
	END IF
	li_rc	=	dw_3.Create (ls_syntax)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_create_datawindows, '	+	&
						'cannot create dw_3.  Error text = '	+	ls_error	+	&
						'.  SQL = '	+	is_sql	+	'.')
		Return	-1
	END IF
	li_rc	=	dw_2.SetTransObject (Stars2ca)
	li_rc	=	dw_3.SetTransObject (Stars2ca)
END IF

Return	1
end event

event ue_clear_options_tab;//*********************************************************************************
// Script Name:	ue_clear_options_tab
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Clear the contents of the options tab and initialize the
//						data on this tab.
//
//						This event is triggered when the Clear button is pressed
//						on the Options tab.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount

String	ls_patt_template

ll_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_row	=	0		THEN
	MessageBox ('Application Error', 'Cannot get current row # in w_sampling_analysis_new.ue_clear_options_tab')
	Return
END IF

ls_patt_template	=	tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_row]

// Initialize the data in dw_patt_options.  This should be initialized 
//	when inserting a row.  However, it has to be re-initialized when the
//	clear button is clicked.
tab_patt.tabpage_options.dw_patt_options.object.claim_ind [ll_row]	=	'A'
tab_patt.tabpage_options.dw_patt_options.object.day_ind [ll_row]	=	'A'
tab_patt.tabpage_options.dw_patt_options.object.patient_ind [ll_row]	=	'S'
tab_patt.tabpage_options.dw_patt_options.object.combination_ind [ll_row]	=	'A'
tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind [ll_row]	=	'G'
tab_patt.tabpage_options.dw_patt_options.object.tooth_ind [ll_row]	=	'A'

// Edit the remaining data on this tab based on the data in dw_criteria
This.Event	ue_edit_options_tab()

// Determine if the Time Frame tab is to be enabled or disabled
This.Event	ue_edit_timeframe_tab()





end event

event ue_edit_enable_prev_next;//*********************************************************************************
// Script Name:	ue_edit_enable_prev_next
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will determine if Prev and Next buttons on
//						each tab should be enabled or disabled.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

// Edit the Next buttons.

IF	tab_patt.tabpage_criteria.enabled	=	TRUE		&
OR	tab_patt.tabpage_options.enabled		=	TRUE		&
OR	tab_patt.tabpage_timeframe.enabled	=	TRUE		&
OR	tab_patt.tabpage_custom.enabled		=	TRUE		&
OR	tab_patt.tabpage_report.enabled		=	TRUE		THEN
	tab_patt.tabpage_list.cb_list_next.enabled	=	TRUE
ELSE
	tab_patt.tabpage_list.cb_list_next.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_options.enabled		=	TRUE		&
OR	tab_patt.tabpage_timeframe.enabled	=	TRUE		&
OR	tab_patt.tabpage_custom.enabled		=	TRUE		&
OR	tab_patt.tabpage_report.enabled		=	TRUE		THEN
	tab_patt.tabpage_criteria.cb_criteria_next.enabled	=	TRUE
ELSE
	tab_patt.tabpage_criteria.cb_criteria_next.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_timeframe.enabled	=	TRUE		&
OR	tab_patt.tabpage_custom.enabled		=	TRUE		&
OR	tab_patt.tabpage_report.enabled		=	TRUE		THEN
	tab_patt.tabpage_options.cb_options_next.enabled	=	TRUE
ELSE
	tab_patt.tabpage_options.cb_options_next.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_report.enabled		=	TRUE		&
OR	tab_patt.tabpage_custom.enabled		=	TRUE		THEN
	tab_patt.tabpage_timeframe.cb_timeframe_next.enabled	=	TRUE
ELSE
	tab_patt.tabpage_timeframe.cb_timeframe_next.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_report.enabled		=	TRUE		THEN
	tab_patt.tabpage_custom.cb_custom_next.enabled	=	TRUE
ELSE
	tab_patt.tabpage_custom.cb_custom_next.enabled	=	FALSE
END IF

// Edit the Prev buttons.

IF	tab_patt.tabpage_list.enabled			=	TRUE		&
OR	tab_patt.tabpage_criteria.enabled	=	TRUE		&
OR	tab_patt.tabpage_options.enabled		=	TRUE		&
OR	tab_patt.tabpage_timeframe.enabled	=	TRUE		&
OR	tab_patt.tabpage_custom.enabled		=	TRUE		THEN
	tab_patt.tabpage_report.cb_report_prev.enabled	=	TRUE
ELSE
	tab_patt.tabpage_report.cb_report_prev.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_list.enabled			=	TRUE		&
OR	tab_patt.tabpage_criteria.enabled	=	TRUE		&
OR	tab_patt.tabpage_options.enabled		=	TRUE		&
OR	tab_patt.tabpage_timeframe.enabled	=	TRUE		THEN
	tab_patt.tabpage_custom.cb_custom_prev.enabled	=	TRUE
ELSE
	tab_patt.tabpage_custom.cb_custom_prev.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_list.enabled			=	TRUE		&
OR	tab_patt.tabpage_criteria.enabled	=	TRUE		&
OR	tab_patt.tabpage_options.enabled		=	TRUE		THEN
	tab_patt.tabpage_timeframe.cb_timeframe_prev.enabled	=	TRUE
ELSE
	tab_patt.tabpage_timeframe.cb_timeframe_prev.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_list.enabled			=	TRUE		&
OR	tab_patt.tabpage_criteria.enabled	=	TRUE		THEN
	tab_patt.tabpage_options.cb_options_prev.enabled	=	TRUE
ELSE
	tab_patt.tabpage_options.cb_options_prev.enabled	=	FALSE
END IF

IF	tab_patt.tabpage_list.enabled			=	TRUE		THEN
	tab_patt.tabpage_criteria.cb_criteria_prev.enabled	=	TRUE
ELSE
	tab_patt.tabpage_criteria.cb_criteria_prev.enabled	=	FALSE
END IF




end event

event ue_save_pattern;//*********************************************************************************
// Script Name:	ue_save_pattern
//
//	Arguments:		as_mode:
//						S	=	Save (Default)
//						A	=	Save As
//						L	=	Link
//
// Returns:			Integer - The return code from ue_save
//
//	Description:	Save the mode in which the save is occurring and trigger the
//						ue_save event.
//
//	Note:				The ue_presave event will open the pattern save window depending
//						on the mode set in this event.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc

is_save_mode	=	as_mode

li_rc	=	This.Event	ue_save()

is_save_mode	=	'S'		// Reset for CloseQuery processing

Return	li_rc

end event

event ue_mapping;//*********************************************************************************
// Script Name:	ue_mapping
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event will open the Map Interface window and eventually
//						MapInfo.  First it will tag the columns in the datawindow that 
//						can be used in the range from the map legend.  This is determined 
//						by entries in the stars_win_parm table.  Then open w_geo_interface 
//						passing it the datawindow and the invoice type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

SetPointer(HourGlass!)

Long		ll_rowcount, 				&
			ll_row

String	ls_modify

sx_map_struct	lstr_map 		// Defined in stmap.pbl

n_ds				lds_stars_win_parm

// Get the invoice type
ll_row		=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

IF	ll_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_mapping, '	+	&
					'cannot get the current row in dw_patt_cntl.')
	Return
END IF

IF	is_inv_type	=	'ML'		THEN
	MessageBox ('Error', 'You cannot Map against a ML pattern.')
	Return
END IF


tab_patt.tabpage_report.dw_report.SetRedraw (FALSE)		// Prevent flicker

lds_stars_win_parm		=	CREATE	n_ds
lds_stars_win_parm.DataObject	=	"d_get_tag_cols"
lds_stars_win_parm.SetTransObject(stars2ca)

// Get tag columns and tag the columns in the report datawindow
ll_rowcount = lds_stars_win_parm.Retrieve (is_inv_type, gv_sys_dflt)

Stars2ca.of_commit ()						// Free up any locks
	
FOR ll_row = 1 TO ll_rowcount
	ls_modify	=	lds_stars_win_parm.object.col_name[ll_row]	+	&
						".tag = '"												+	&
						lds_stars_win_parm.object.a_dflt[ll_row]	+	"'"
	tab_patt.tabpage_report.dw_report.Modify (ls_modify)
NEXT

DESTROY	lds_stars_win_parm
	
// Set parms to pass to w_geo_interface
lstr_map.dw				=	tab_patt.tabpage_report.dw_report
lstr_map.table_type	=	is_inv_type

tab_patt.tabpage_report.dw_report.SetRedraw (TRUE)

OpenSheetWithParm (w_geo_interface, lstr_map, MDI_main_frame, help_menu_position, Layered!)

end event

event ue_create_case_link;//*********************************************************************************
// Script Name:	ue_create_case_link
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will create a case_link row for a newly created
//						user-defined pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row

ids_case_link.RowsDiscard (1, ids_case_link.RowCount(), Primary!)
ids_case_link.Reset()

ll_row	=	ids_case_link.InsertRow(0)
ids_case_link.SetRow (ll_row)

ids_case_link.object.link_type [ll_row]	=	'PAT'
ids_case_link.object.case_id [ll_row]		=	'NONE'
ids_case_link.object.link_status [ll_row]	=	'A'
ids_case_link.object.user_id [ll_row]		=	gc_user_id
ids_case_link.object.case_id [ll_row]		=	'NONE'
ids_case_link.object.link_date [ll_row]	=	DateTime (Today())





end event

event ue_filter_dw_list();//*********************************************************************************
// Script Name:	ue_filter_dw_list
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when the List button on the Library
//						tab is clicked and when the data on dw_parms is changed.  
//						This script will filter the previously retrieved data in
//						dw_list.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	08/20/02	GaryR	Track 2929d	Enhance retrieval performance
// 10/03/02 JasonS Track 3144d add filter criteria for ML patterns
//	03/12/03	GaryR	Track 3478d	Do not filter ML patterns when used as lookup
//	03/13/03	GaryR	Track 3457d	Retrieve the list instead of filtering
//	03/19/03	GaryR	Track 3457d	Remove invalid rows pulled in by outer join
//	04/01/03	GaryR	Track 3457d	Remove invalid rows pulled in by outer join
//	06/23/03	GaryR	Track 3144d	Subset invoices should match exactly the user pattern invoices
//	11/02/07	GaryR	Track 4773d	Check whether to display NPI Patterns
//	11/08/07	Katie	SPR 5177 Added call to rowfocuschange event to appropriately enable/disable delete option.
//	12/05/07	GaryR	SPR 4773	Make provider numbered patterns NPI compliant
//*********************************************************************************

Boolean	lb_found,				&
			lb_1500_and_ub92,		&
			lb_match

Integer	li_rc,					&
			li_rowcount

Integer  li_counter	// JasonS 10/03/02 Track 3144d
datawindowchild ldwc_inv_type	// JasonS 10/03/02 Track 3144d


Long		ll_rowcount,			&
			ll_row,					&
			ll_parm_row,			&
			ll_patt_range,			&
			ll_find_row,			&
			ll_rc

String	ls_find,					&
			ls_msg,					&
			ls_patt_type,			&
			ls_pattern_type,		&
			ls_invoice_type,		&
			ls_case_id,				&
			ls_case_spl,			&
			ls_case_ver,			&
			ls_user_id,				&
			ls_patt_id,				&
			ls_pattern_id,			&
			ls_patt_desc,			&
			ls_patt_inv_type,		&
			ls_patt_string,		&
			ls_patt_user_id,		&
			ls_patt_template,		&
			ls_prev_patt_id,		&
			ls_filter,				&
			ls_from_date,			&
			ls_to_date,				&
			ls_base_type[],		&
			ls_patt_base_type,	&
			ls_sql,					&
			ls_subc_tables

Date		ldt_patt_date,			&
			ldt_from_date,			&
			ldt_link_date

Datetime	ldtm_patt_date,		&
			ldtm_from_date,		&
			ldtm_link_date

n_cst_datetime		lnv_datetime		//	Autoinstantiated
n_cst_case			lnv_case				//	08/20/02	GaryR	Track 2929d
n_cst_sqlattrib	lnv_sql[]

li_rc	=	tab_patt.tabpage_list.dw_parms.AcceptText()

IF	li_rc	<	0		THEN
	Return
END IF

// Edit the input on dw_parms
ll_parm_row	=	tab_patt.tabpage_list.dw_parms.GetRow()

IF	ll_parm_row	=	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_filter_dw_list, cannot '	+	&
					'get the current row in dw_parms')
	Return
END IF

li_rc	=	This.Event	ue_edit_dw_parms()

IF	li_rc	<	0		THEN
	Return
END IF

//	08/20/02	GaryR	Track 2929d - Begin
tab_patt.tabpage_list.dw_list.SetRedraw( FALSE )
tab_patt.tabpage_list.dw_list_desc.SetRedraw ( FALSE )
//	08/20/02	GaryR	Track 2929d - End

ls_pattern_type	=	tab_patt.tabpage_list.dw_parms.object.patt_type [ll_parm_row]
ls_invoice_type	=	tab_patt.tabpage_list.dw_parms.object.invoice_type [ll_parm_row]
ldtm_patt_date		=	tab_patt.tabpage_list.dw_parms.object.patt_date [ll_parm_row]
ll_patt_range		=	tab_patt.tabpage_list.dw_parms.object.patt_range [ll_parm_row]
ls_user_id			=	tab_patt.tabpage_list.dw_parms.object.user_id [ll_parm_row]
ls_pattern_id		=	tab_patt.tabpage_list.dw_parms.object.patt_id [ll_parm_row]
ls_patt_string		=	tab_patt.tabpage_list.dw_parms.object.patt_desc [ll_parm_row]

// Always filter invoice type (column patt_rel.rel_type) unless a criteria display
//	is occuring
IF	istr_sub_opt.patt_struc.come_from	=	'CRITERIA'		THEN
	// Initialize the following data so that nothing else gets filtered.
	ll_patt_range		=	0
	ls_user_id			=	''
	ls_pattern_id		=	''
	ls_pattern_type	=	ics_user_pattern
ELSE
	// JasonS 10/03/02 Begin - Track 3144d
	if ls_invoice_type = 'ML' and ls_pattern_type = ics_user_pattern &
	and istr_sub_opt.patt_struc.come_from	<>	'LOOKUP'	then
		tab_patt.tabpage_list.dw_parms.getchild('invoice_type', ldwc_inv_type)
		for li_counter = 1 to ldwc_inv_type.rowcount()
			if ldwc_inv_type.getitemstring(li_counter, 'inv_type') <> 'ML' then
				ls_filter += " AND (PATT_OPTIONS.SUBC_TABLES like '%" + ldwc_inv_type.getitemstring(li_counter, 'inv_type') + "%')"					
			end if
		next
	end if
	ls_filter	=	" AND PATT_REL.REL_TYPE = '"	+	ls_invoice_type	+	"'"		
	// JasonS 10/03/02 End - Track 3144d
END IF

// If this window is performing a lookup, then restrict the user-defined patterns
// where case ID is NONE.
IF	istr_sub_opt.patt_struc.come_from	=	'LOOKUP'		THEN
	ls_filter	=	ls_filter	+	" AND CASE_LINK.CASE_ID = 'NONE'"
END IF

// If coming from subset options, remove patterns 17 and 20 from the list.  
//	These patterns are not allowed to schedule "background" patterns and are
//	useless for this purpose
IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'		THEN
	ls_filter	=	ls_filter	+	" AND PATT_CNTL.PATT_ID <> '"	+	ics_patt17	+	&
						"' AND PATT_CNTL.PATT_ID <> '"	+	ics_patt20	+	"'"
END IF


IF	ls_pattern_type	<>	ics_all_patterns		THEN
	// Filtering either User-defined patterns or Pattern templates
	ls_filter	=	ls_filter	+	" AND PATT_CNTL.PATT_TYPE = '"	+	ls_pattern_type	+	"'"
END IF

IF	ll_patt_range	=	0		&
OR	IsNull (ldtm_patt_date)	THEN
ELSE
	// Compute the from and to date ranges.
	ldt_patt_date	=	Date (ldtm_patt_date)
	ldtm_patt_date	=	DateTime (ldt_patt_date, 23:59:59)
	ldtm_from_date	=	lnv_datetime.of_GetFromDateTime(ldt_patt_date, ll_patt_range)
	ldt_from_date	=	Date (ldtm_from_date)
END IF

//	08/20/02	GaryR	Track 2929d - Begin
// If a pattern description was entered, it must exist in patt_desc
IF	Len (ls_patt_string)	>	0		THEN
	ls_filter = ls_filter + " AND ( " + gnv_sql.of_get_to_upper( "PATT_CNTL.PATT_DESC" ) + &
									" LIKE '%" + Upper( ls_patt_string ) + "%' )"
END IF

//	The following edits are for user-defined patterns only
IF	ls_pattern_type	=	ics_user_pattern		THEN
	// Edit user id for a user-defined pattern
	IF	 Len (ls_user_id)	>	0 THEN
		ls_filter = ls_filter + " AND ( CASE_LINK.USER_ID LIKE '" + ls_user_id + "%' )"
	END IF
	
	// Edit pattern template id for a user-defined pattern
	IF	 Len (ls_pattern_id)	>	0 THEN
		ls_filter = ls_filter + " AND PATT_OPTIONS.PATT_TEMPLATE = '" + ls_pattern_id + "'"
	END IF
	
	// Edit date range for a user-defined pattern
	IF	ll_patt_range	<>	0 AND NOT IsNull (ldtm_patt_date)	THEN
		ls_filter = ls_filter + " AND CASE_LINK.LINK_DATE BETWEEN " + gnv_sql.of_get_to_date( String( ldtm_from_date, "mm/dd/yyyy hh:mm:ss" ) ) + &
										" AND " + gnv_sql.of_get_to_date( String( ldtm_patt_date, "mm/dd/yyyy hh:mm:ss" ) )
	END IF
END IF

// For a ML subset, determine if the invoice types include only one 1500 and
//	UB92 invoice type.
lb_1500_and_ub92	=	This.wf_is_1500_and_ub92()

// Patterns 51, 52, 53, and 54 must have only one 1500 and UB92 invoice type
IF NOT lb_1500_and_ub92 THEN
	ls_filter = ls_filter + " AND PATT_CNTL.PATT_ID NOT IN ('" + ics_patt51 + "', '" + &
									ics_patt52 + "', '" + ics_patt53 + "', '" + ics_patt54 + "')"
END IF
//	08/20/02	GaryR	Track 2929d - End

// Check whether to display NPI Patterns
IF gv_npi_cntl = 0 THEN
	ls_filter = ls_filter + " AND PATT_CNTL.EXE_IND <> 'N'"
END IF

li_rc	=	tab_patt.tabpage_list.dw_list.SetFilter('')
li_rc	=	tab_patt.tabpage_list.dw_list.Filter()

ls_sql = tab_patt.tabpage_list.dw_list.GetSQLSelect()
IF Trim( is_list_sql ) = "" THEN
	is_list_sql = ls_sql
ELSE
	ls_sql = is_list_sql
END IF

IF gnv_sql.of_parse( ls_sql, lnv_sql ) <> 1 THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_filter_dw_list, cannot '	+	&
					'interpret SQL')
	Return
END IF

lnv_sql[1].s_where += ls_filter
ls_sql = gnv_sql.of_assemble( lnv_sql )
tab_patt.tabpage_list.dw_list.SetSQLSelect( ls_sql )
ll_rowcount	=	tab_patt.tabpage_list.dw_list.Retrieve()

// Re-sort the d/w
li_rc	=	tab_patt.tabpage_list.dw_list.SetSort("patt_type A, patt_id A, patt_inv_type A")
li_rc	=	tab_patt.tabpage_list.dw_list.Sort()

lnv_case	=	CREATE	n_cst_case			//	08/20/02	GaryR	Track 2929d

FOR ll_row	=	1	TO	ll_rowcount
	// Compare the base type in the d/w to the base types associated with the invoice
	//	types.  If a match occurs, then remove the row.  Only apply this to pattern
	//	templates.
	ls_patt_id			=	tab_patt.tabpage_list.dw_list.object.patt_id [ll_row]
	ls_patt_base_type	=	tab_patt.tabpage_list.dw_list.object.base_type [ll_row]
	ls_patt_type		=	tab_patt.tabpage_list.dw_list.object.patt_type [ll_row]
	ls_patt_inv_type	=	tab_patt.tabpage_list.dw_list.object.rel_type [ll_row]
	ls_patt_user_id	=	tab_patt.tabpage_list.dw_list.object.user_id [ll_row]
	ls_patt_template	=	tab_patt.tabpage_list.dw_list.object.patt_template [ll_row]
	ldtm_link_date		=	tab_patt.tabpage_list.dw_list.object.link_date [ll_row]
	ls_subc_tables		=	tab_patt.tabpage_list.dw_list.object.subc_tables [ll_row]
	lb_match 			=	TRUE
	//	If the pattern ID matches that of the previous row, remove the current row
	IF	ls_patt_id		=	ls_prev_patt_id		THEN
		tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
		Continue
	END IF
	ls_prev_patt_id	=	ls_patt_id
	
	IF IsNull( ls_patt_template ) THEN ls_patt_template = ""

	//	Edit the case for case security
	ls_case_id		=	tab_patt.tabpage_list.dw_list.object.case_link_case_id [ll_row]
	ls_case_spl		=	tab_patt.tabpage_list.dw_list.object.case_link_case_spl [ll_row]
	ls_case_ver		=	tab_patt.tabpage_list.dw_list.object.case_link_case_ver [ll_row]
	IF	Len (ls_case_id)	>	0		THEN
		//	08/20/02	GaryR	Track 2929d - Begin
		//ls_msg			=	This.Event	ue_case_security (ls_case_id, ls_case_spl, ls_case_ver)
		ls_msg		=	lnv_case.uf_edit_case_security( ls_case_id, ls_case_spl, ls_case_ver )
		//	08/20/02	GaryR	Track 2929d - End
		
		IF	Len (ls_msg)	>	0	THEN
			// Case is a secured case.  Discard the row.
			tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row --
			ll_rowcount --
			Continue
		END IF
	END IF

	//	08/20/02	GaryR	Track 2929d - Begin
	//	The following edits are for user-defined patterns only.
	IF	ls_patt_type	<>	ics_user_pattern		THEN Continue
	
	//	Remove invalid rows pulled in by outer join
	IF IsNull( ls_patt_template ) OR Trim( ls_patt_template ) = "" THEN
		tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
		Continue
	END IF
	
	//	Remove ML templates that do not have invoices for current subset
	IF ls_invoice_type = 'ML' AND istr_sub_opt.patt_struc.come_from	<>	'LOOKUP'	&
	AND istr_sub_opt.patt_struc.come_from	<>	'CRITERIA' THEN
		tab_patt.tabpage_list.dw_parms.getchild('invoice_type', ldwc_inv_type)
		
		li_rowcount = ldwc_inv_type.rowcount()
		IF ((li_rowcount * 3) - 4) <> Len( Trim( ls_subc_tables ) ) THEN
			lb_match = FALSE
		ELSE
			FOR li_counter = 1 to li_rowcount
				IF ldwc_inv_type.getitemstring(li_counter, 'inv_type') <> 'ML' then
					IF NOT Match( ls_subc_tables, ldwc_inv_type.getitemstring(li_counter, 'inv_type') ) THEN
						lb_match = FALSE
						EXIT
					END IF
				END IF
			NEXT
		END IF
		
		IF NOT lb_match THEN
			tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row --
			ll_rowcount --
			Continue
		END IF
	END IF
	
	// Edit user id for a user-defined pattern
	IF	 Len (ls_user_id)	>	0					&
	AND NOT Match( ls_patt_user_id, ls_user_id )		THEN
	//AND ls_patt_user_id	<>	ls_user_id		THEN		//	08/20/02	GaryR	Track 2929d
		// User Id doesn't match for a user-defined pattern.  Discard the row.
		tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
		Continue
	END IF
	// Edit pattern template id for a user-defined pattern
	IF	 Len (ls_pattern_id)	>	0					&
	AND ls_patt_template	<>	ls_pattern_id		THEN
		// Pattern template doesn't match for a user-defined pattern.  Discard the row.
		tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
		Continue
	END IF
	// Edit date range for a user-defined pattern
	IF	ll_patt_range	=	0		&
	OR	IsNull (ldtm_patt_date)	THEN
	ELSE
		IF	ldtm_link_date		>	ldtm_patt_date	&
		OR ldtm_link_date		<	ldtm_from_date	THEN
			// Link date doesn't fall in the range for a user-defined pattern.  Discard the row.
			tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row --
			ll_rowcount --
			Continue
		END IF
	END IF
	//	08/20/02	GaryR	Track 2929d - End
NEXT

Destroy	lnv_case				//	08/20/02	GaryR	Track 2929d

// If Generic exists in the list, hilite that row, else hilite the 1st row.
ll_rowcount		=	tab_patt.tabpage_list.dw_list.RowCount()

IF	ll_rowcount	>	0		THEN
	ls_find	=	"patt_id = '"	+	ics_generic	+	"'"
	ll_find_row	=	tab_patt.tabpage_list.dw_list.Find (ls_find, 1, ll_rowcount)
	IF	ll_find_row		>	0		THEN
		tab_patt.tabpage_list.dw_list.ScrollToRow (ll_find_row)
		tab_patt.tabpage_list.dw_list.Event	ue_singleselect (ll_find_row)
		tab_patt.tabpage_list.dw_list.event rowfocuschanged(ll_find_row)
	ELSE
		tab_patt.tabpage_list.dw_list.ScrollToRow (1)
		tab_patt.tabpage_list.dw_list.Event	ue_singleselect (1)
		tab_patt.tabpage_list.dw_list.event rowfocuschanged(1)
	END IF
	// Enable the Select button and RMM
	This.event	ue_enable_select (TRUE)
ELSE
	// Disable the Select button and RMM
	This.event	ue_enable_select (FALSE)
END IF


// Set the Count box on this tab
tab_patt.tabpage_list.st_count_list.text	=	String (ll_rowcount)

tab_patt.tabpage_list.dw_parms.SetRedraw (TRUE)
tab_patt.tabpage_list.dw_list.SetRedraw (TRUE)
tab_patt.tabpage_list.dw_list_desc.SetRedraw( TRUE )		//	08/20/02	GaryR	Track 2929d
end event

event ue_custom_add;//*********************************************************************************
// Script Name:	ue_custom_add
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is called from multiple scripts and will move the
//						highlighted rows from dw_available to dw_selected.
//
//	Note:				This event is call when dw_selected is dragged onto itself. 
//						When this occurs, move the highlighted rows to the dropped
//						location.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 10/10/00 GaryR 3002c Dragging columns in Patterns not consistent with Query Engine
//
//*********************************************************************************

Integer	li_idx,						&
			li_upper

Long		ll_selected_row,			&
			ll_rowcount,				&
			ll_select_count,			&
			ll_row_increment

String	ls_col_desc[],				&
			ls_find

DragObject	ldrg_object

ldrg_object	=	DraggedObject()

tab_patt.tabpage_custom.dw_available.Drag (Cancel!)		// Drag mode is completed

IF	IsValid (ldrg_object)		THEN
	IF	 TypeOf (ldrg_object)	=	DataWindow!		&
	AND ldrg_object.ClassName()			=	'dw_selected'	THEN
		// dw_selected is being dragged onto itself.
		// Move the highlighted rows to the dropped location.
		ll_selected_row	=	tab_patt.tabpage_custom.dw_selected.GetSelectedRow(0)
		ll_rowcount			=	tab_patt.tabpage_custom.dw_selected.RowCount()

		// If the insertion point is 0, move them to the end
		IF	il_drop_row	=	0		THEN
			il_drop_row	=	ll_rowcount	+	1
		END IF

		// Code for users with 'slippery mice'
		IF	tab_patt.tabpage_custom.dw_selected.IsSelected (il_drop_row)	=	TRUE		THEN
			Return
		END IF
		
		tab_patt.tabpage_custom.dw_selected.of_multiselect( FALSE )
		
		DO WHILE	ll_selected_row	>	0
			// Deselect the row, move it, and increment the # of rows moved
			tab_patt.tabpage_custom.dw_selected.SelectRow (ll_selected_row, FALSE)
			tab_patt.tabpage_custom.dw_selected.RowsMove (ll_selected_row,						&
																		ll_selected_row,						&
																		Primary!,								&
																		tab_patt.tabpage_custom.dw_selected,	&
																		il_drop_row	+	ll_row_increment,	&
																		Primary!)
			// Only increment when you get lower than the insertion point
			IF	il_drop_row	<	ll_selected_row		THEN
				ll_row_increment	++
			END IF
			// Get the next selected row to move
			ll_selected_row	=	tab_patt.tabpage_custom.dw_selected.GetSelectedRow( 0 )
		LOOP
		
		tab_patt.tabpage_custom.dw_selected.of_multiselect( TRUE )
		
		// Reset the drop row and get out
		il_drop_row	=	0
		// Make sure that the unique key columns exist in dw_selected.
		This.Event	ue_select_unique_key_columns()
		Return
	END IF								//	TypeOf (ldrg_object)	=	DataWindow! AND ldrg_object.ClassName() = 'dw_selected'
END IF									//	IsValid (ldrg_object)

// From this point on, we are dealing with moving rows from dw_available to dw_selected

// Get list of hi-lited rows

ll_selected_row	=	tab_patt.tabpage_custom.dw_available.GetSelectedRow(0)
ll_rowcount			=	tab_patt.tabpage_custom.dw_available.RowCount()

DO WHILE	ll_selected_row >	0
	li_idx	++
	ls_col_desc [li_idx]		=	tab_patt.tabpage_custom.dw_available.object.column_desc [ll_selected_row]
	ll_selected_row	=	tab_patt.tabpage_custom.dw_available.GetSelectedRow(ll_selected_row)
LOOP

SetRedraw( FALSE ) // 10/10/00 GaryR 3002c

li_upper				=	UpperBound (ls_col_desc)


FOR li_idx	=	1	TO	li_upper
	ls_find	=	"column_desc = '"	+	ls_col_desc [li_idx]		+	"'"
	ll_selected_row	=	tab_patt.tabpage_custom.dw_available.Find (ls_find, 1, ll_rowcount)
	IF	ll_selected_row	>	0		THEN
		// 10/10/00 GaryR 3002c Begin**********************
		ll_select_count = tab_patt.tabpage_custom.dw_selected.GetSelectedRow( 0 )
		IF ll_select_count > 0 THEN
			IF tab_patt.tabpage_custom.dw_selected.GetSelectedRow( ll_select_count ) > 0 THEN
				ll_select_count	=	tab_patt.tabpage_custom.dw_selected.RowCount() + 1
			END IF
		ELSE
			ll_select_count	=	tab_patt.tabpage_custom.dw_selected.RowCount() + 1
		END IF
		// 10/10/00 GaryR 3002c End***********************
		tab_patt.tabpage_custom.dw_available.RowsMove	(ll_selected_row,						&
																		ll_selected_row,						&
																		Primary!,								&
																		tab_patt.tabpage_custom.dw_selected,	&
																		ll_select_count,					& 
																		Primary!)
																		
		tab_patt.tabpage_custom.dw_selected.SelectRow ( 0, FALSE )
		tab_patt.tabpage_custom.dw_selected.SelectRow ( ll_select_count, TRUE )
		
	END IF
NEXT

// Make sure that the unique key columns exist in dw_selected.
This.Event	ue_select_unique_key_columns()

// Unhilite every row in both dw_available and dw_selected
//tab_patt.tabpage_custom.dw_available.SelectRow (0, FALSE) // 10/10/00 GaryR 3002c
tab_patt.tabpage_custom.dw_selected.SelectRow (0, FALSE)

SetRedraw( TRUE ) // 10/10/00 GaryR 3002c

// Set the count.
This.Event	ue_custom_set_count()

// Reset the contents of dw_report
This.Event	ue_reset_dw_report()

// Determine if the Report tab is to enabled or disabled
This.Event	ue_edit_enable_report()


end event

event ue_custom_remove();//*********************************************************************************
// Script Name:	ue_custom_remove
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is called from multiple scripts and will move the
//						highlighted rows from dw_selected to dw_available.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 10/11/00 GaryR Track 3016c	Prevent "ICN" from being removed.
// 10/22/01 GaryR Track 3491c	Switching between ML patterns causes errors.
//	01/17/02	GaryR	Track 2562d	Allow removal of dependant keys.
//	01/17/03	GaryR	Track 4535c	Allow removal of columns not in criteria
//
//*********************************************************************************

Integer	li_rc,						&
			li_idx,						&
			li_upper,					&
			li_upper_inv,				&
			li_ctr

Long		ll_selected_row,			&
			ll_rowcount,				&
			ll_avail_count,			&
			ll_row_increment

String	ls_find,						&
			ls_col_desc[],				&
			ls_inv_types[],			&
			ls_inv_type

Boolean	lb_found

DragObject	ldrg_object

ldrg_object	=	DraggedObject()

tab_patt.tabpage_custom.dw_selected.Drag (Cancel!)		// Drag mode is completed

IF	IsValid (ldrg_object)		THEN
	//	Make sure that dw_available is not being dragged onto itself
	IF	 TypeOf (ldrg_object)	=	DataWindow!		&
	AND ldrg_object.ClassName()			=	'dw_available'	THEN
		// dw_available is being dragged onto itself.  Get out.
		li_rc	=	tab_patt.tabpage_custom.dw_available.Drag (Cancel!)
		il_drop_row	=	0
		Return
	END IF								//	TypeOf (ldrg_object)	=	DataWindow! AND ldrg_object.ClassName() = 'dw_available'
END IF									//	IsValid (ldrg_object)

// From this point on, we are dealing with moving rows from dw_selected to dw_available

ll_selected_row	=	tab_patt.tabpage_custom.dw_selected.GetSelectedRow(0)
ll_rowcount			=	tab_patt.tabpage_custom.dw_selected.RowCount()

DO WHILE	ll_selected_row >	0
	li_idx	++
	ls_col_desc [li_idx]		=	tab_patt.tabpage_custom.dw_selected.object.column_desc [ll_selected_row]
	ll_selected_row	=	tab_patt.tabpage_custom.dw_selected.GetSelectedRow(ll_selected_row)
LOOP

li_upper_inv = This.wf_get_crit_invoices( ls_inv_types )
li_upper				=	UpperBound (ls_col_desc)

FOR li_idx	=	1	TO	li_upper
	ls_find	=	"column_desc = '"	+	ls_col_desc [li_idx]		+	"'"
	ll_selected_row	=	tab_patt.tabpage_custom.dw_selected.Find (ls_find, 1, ll_rowcount)
	IF	ll_selected_row	>	0		THEN
		//	Check if key column can be removed		
		IF tab_patt.tabpage_custom.dw_selected.GetItemString( ll_selected_row, "elem_name" ) = "ICN" AND NOT ib_remove_all THEN
			IF li_upper_inv <= 0 THEN 
				ls_inv_types[1] = "00000"		// set non matching invoice type
				li_upper_inv = 1
			END IF
			
			lb_found = FALSE
			ls_inv_type = tab_patt.tabpage_custom.dw_selected.GetItemString( ll_selected_row, "elem_tbl_type" )
			
			FOR li_ctr = 1 TO li_upper_inv
				IF ls_inv_type = ls_inv_types[li_ctr] THEN 
					lb_found = TRUE
					EXIT
				END IF
			NEXT	
						
			//	If invoice found
			//	do not allow removal
			IF lb_found THEN	Continue
		END IF
		
		ll_avail_count	=	tab_patt.tabpage_custom.dw_available.RowCount()
		tab_patt.tabpage_custom.dw_selected.RowsMove	(ll_selected_row,						&
																	ll_selected_row,						&
																	Primary!,								&
																	tab_patt.tabpage_custom.dw_available,	&
																	ll_avail_count + 1,					&
																	Primary!)
		
	END IF
NEXT

// Make sure that the unique key columns exist in dw_selected.
IF	ib_remove_all	=	FALSE AND tab_patt.tabpage_custom.dw_selected.RowCount() > 0 THEN
	This.Event	ue_select_unique_key_columns()
END IF

// The columns have been moved back to dw_available at the end.  Unhilite and re-sort the data.
tab_patt.tabpage_custom.dw_available.SetSort ('elem_tbl_type A, crit_seq A, elem_desc A')
tab_patt.tabpage_custom.dw_available.Sort()

// Please note that duplicate columns in dw_available will not be removed.
// If this changes, then dw_available would have to be sorted in a
// different sequence in order to remove the duplicates

// Unhilite every row in both dw_available and dw_selected
tab_patt.tabpage_custom.dw_available.SelectRow (0, FALSE)
tab_patt.tabpage_custom.dw_selected.SelectRow (0, FALSE)

// Set the count.
This.Event	ue_custom_set_count()

// Reset the contents of dw_report
This.Event	ue_reset_dw_report()

// Determine if the Report tab is to enabled or disabled
This.Event	ue_edit_enable_report()



end event

event ue_custom_remove_all;//*********************************************************************************
// Script Name:	ue_custom_remove_all
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will move all rows from dw_selected to dw_available.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

// Hilite all rows in dw_selected
tab_patt.tabpage_custom.dw_selected.SelectRow (0, TRUE)

// Remove all rows from dw_selected without re-adding the unique key columns
ib_remove_all	=	TRUE

// Execute the script to remove the hilited rows
This.Event	ue_custom_remove()

ib_remove_all	=	FALSE




end event

event ue_custom_move;//*********************************************************************************
// Script Name:	ue_custom_move
//
//	Arguments:		as_direction
//						'UP'		=	Move up 1 row
//						'DOWN'	=	Move down 1 row
//
// Returns:			N/A
//
//	Description:	This event is called from the Up and Down buttons to move
//						a Selected column up or down a row.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 10/10/00 GaryR 3002c Dragging columns in Patterns not consistent with Query Engine
//
//*********************************************************************************

Long		ll_selected_row,			&
			ll_rowcount,				&
			ll_new_position

// Move the highlighted rows to the dropped location.
ll_selected_row	=	tab_patt.tabpage_custom.dw_selected.GetSelectedRow(0)
ll_rowcount			=	tab_patt.tabpage_custom.dw_selected.RowCount()

// 10/10/00 GaryR 3002c Begin*************************
IF ll_selected_row < 1 THEN
	MessageBox( "Error", "Please select a row to move.", StopSign!, Ok! )
	Return
END IF

IF ll_selected_row = ll_rowcount AND as_direction = 'DOWN' THEN
	MessageBox( "Error", "Down is not valid. Selected field is at the bottom.", StopSign!, Ok! )
	Return
END IF

IF ll_selected_row = 1 AND as_direction = 'UP' THEN
	MessageBox( "Error", "Top is not valid. Selected field is at the top.", StopSign!, Ok! )
	Return
END IF
// 10/10/00 GaryR 3002c End***************************

IF	as_direction		=	'UP'		THEN
	tab_patt.tabpage_custom.dw_selected.RowsMove (ll_selected_row,						&
																ll_selected_row,						&
																Primary!,								&
																tab_patt.tabpage_custom.dw_selected,	&
																ll_selected_row - 1,					&
																Primary!)
	ll_new_position	=	ll_selected_row	-	1
ELSE
	tab_patt.tabpage_custom.dw_selected.RowsMove (ll_selected_row,						&
																ll_selected_row,						&
																Primary!,								&
																tab_patt.tabpage_custom.dw_selected,	&
																ll_selected_row + 2,					&
																Primary!)
	ll_new_position	=	ll_selected_row	+	1
END IF

// Make sure that the unique key columns exist in dw_selected and make sure
// that ICN is the first column.
This.Post	Event	ue_select_unique_key_columns()

tab_patt.tabpage_custom.dw_selected.SelectRow (0, FALSE)
tab_patt.tabpage_custom.dw_selected.ScrollToRow (ll_new_position)
tab_patt.tabpage_custom.dw_selected.SelectRow (ll_new_position, TRUE)




end event

event ue_custom_set_count;//*********************************************************************************
// Script Name:	ue_custom_set_count
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Get the rowcount from dw_selected and set it in
//						st_custom_count.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_rowcount

ll_rowcount		=	tab_patt.tabpage_custom.dw_selected.RowCount()

tab_patt.tabpage_custom.st_custom_count.text	=	String (ll_rowcount)

end event

event ue_edit_dw_parms;//*********************************************************************************
// Script Name:	ue_edit_dw_parms
//
//	Arguments:		N/A
//
// Returns:			Integer
//						 1	=	All edits pass.
//						-1	=	Error
//
//	Description:	This event is triggered when the dw_list is being retrieved
//						and when dw_list is being filtered. 
//						This script will edit the data in dw_parms to ensure that
//						dw_list can display the proper data.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_parm_row,		&
			ll_patt_range

String	ls_patt_type,		&
			ls_invoice_type,	&
			ls_user_id,			&
			ls_patt_id,			&
			ls_patt_string

Datetime	ldtm_patt_date

n_cst_datetime		lnv_datetime		//	Autoinstantiated

// Edit the input on dw_parms
ll_parm_row	=	tab_patt.tabpage_list.dw_parms.GetRow()

IF	ll_parm_row	=	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_edit_dw_parms, cannot '	+	&
					'get the current row in dw_parms')
	Return	-1
END IF

ls_patt_type		=	tab_patt.tabpage_list.dw_parms.object.patt_type [ll_parm_row]
ls_invoice_type	=	tab_patt.tabpage_list.dw_parms.object.invoice_type [ll_parm_row]
ldtm_patt_date		=	tab_patt.tabpage_list.dw_parms.object.patt_date [ll_parm_row]
ll_patt_range		=	tab_patt.tabpage_list.dw_parms.object.patt_range [ll_parm_row]
ls_user_id			=	tab_patt.tabpage_list.dw_parms.object.user_id [ll_parm_row]
ls_patt_id			=	tab_patt.tabpage_list.dw_parms.object.patt_id [ll_parm_row]
ls_patt_string		=	tab_patt.tabpage_list.dw_parms.object.patt_desc [ll_parm_row]

IF	Len (ls_invoice_type)	=	0		THEN
	MessageBox ('Error', 'Invoice type is required to retrieve the patterns', StopSign!)
	tab_patt.tabpage_list.dw_parms.SetFocus()
	tab_patt.tabpage_list.dw_parms.SetColumn ('invoice_type')
	Return	-1
END IF

IF IsNull (ldtm_patt_date)		&
OR	ll_patt_range	=	0			THEN
ELSE
	// Date is entered.  Edit it.
	IF	ldtm_patt_date	>	lnv_datetime.of_GetMaximumDatetime()	&
	OR	ldtm_patt_date	<	lnv_datetime.of_GetMinimumDatetime()	THEN
		MessageBox ('Error', 'The entered date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	+	'.', StopSign!)
		tab_patt.tabpage_list.dw_parms.SetFocus()
		tab_patt.tabpage_list.dw_parms.SetColumn ('patt_date')
		Return	-1
	END IF
END IF

Return	1

end event

event ue_retrieve_dw_available();//*********************************************************************************
// Script Name:	ue_retrieve_dw_available
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when the window is opened and when
//						a pattern is imported.  This script will retrieve the data
//						for the criteria DDDW and for the available columns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_row,					&
			ll_rowcount

String	ls_inv_type,			&
			ls_elem_desc

// Must make sure that a revenue subset exists if one of the base tables has
//	a UB92 base type (unless the pattern is being created from bg job).  The
// following logic will load is_tbl_retrieve[] with the invoice types and
//	the revenue type (if it exists).  The revenue type will be added only once.
This.Event	ue_get_tbl_retrieve()

// Filter the field description DDDW (ids_field_name) and truncate the descriptions. 
This.Event	ue_retrieve_field_dddw()

// Retrieve dw_available and truncate the descriptions

ll_rowcount	=	tab_patt.tabpage_custom.dw_available.Retrieve (is_tbl_retrieve)

FOR	ll_row	=	1	TO	ll_rowcount
	ls_inv_type		=	tab_patt.tabpage_custom.dw_available.GetItemString (ll_row, 'elem_tbl_type')
	ls_elem_desc	=	tab_patt.tabpage_custom.dw_available.GetItemString (ll_row, 'elem_desc')
	// Truncate to 15 bytes and convert to upper case
	inv_pattern_sql.uf_edit_elem_desc (ls_elem_desc)
	tab_patt.tabpage_custom.dw_available.SetItem (ll_row, 'elem_desc', ls_elem_desc)
NEXT

inv_pattern_sql.uf_set_dw_available (tab_patt.tabpage_custom.dw_available)

// Free up any locks
Stars2ca.of_commit()

	


end event

event ue_get_tbl_retrieve();//*********************************************************************************
// Script Name:	ue_get_tbl_retrieve
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will get the original table types and determine
//						if a revenue code exists.  If so, it will add it to the list
//						of table types.  is_tbl_retrieve[] is loaded.  
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	03/12/02	FDG	Track 2871d.  Possible for a UB92 subset to not have revenue as
//						a dependent.  Must read sub_step_cntl (via wf_verify_table) to
//						determine this.
// JasonS 08/28/02 Track 2793  change error message to a more user friendly message
//*********************************************************************************

Boolean	lb_revenue_moved

Integer	li_rc,				&
			li_tables,			&
			li_idx,				&
			li_j,					&
			li_pos,				&
			li_line_num

Long		ll_row,				&
			ll_rowcount,		&
			ll_crit_row,		&
			ll_rc

String	ls_inv_type,		&
			ls_base_type,		&
			ls_empty[],			&
			ls_filter,			&
			ls_patt_type,		&
			ls_patt_field,		&
			ls_patt_cond,		&
			ls_field_type,		&
			ls_table_type[],	&
			ls_operator

n_ds		lds_patt_field

// Reset the previously set revenue code and tbl type data
is_revenue_code		=	''
is_tbl_retrieve		=	ls_empty
is_rel_type				=	ls_empty

// Only use multiple table types if an ML pattern was selected.  Otherwise,
//	just use the selected table type.

IF	is_inv_type			=	'ML'		&
OR	is_inv_type			=	''			THEN
	ls_table_type		=	istr_sub_opt.patt_struc.table_type
ELSE
	ls_table_type [1]	=	is_inv_type
END IF

// Must insure that a revenue subset exists if one of the tables has a base type
//	of UB92, unless the pattern is being created from a bg job.

li_tables	=	UpperBound (ls_table_type)

FOR li_idx	=	1	TO	li_tables
	ls_inv_type	=	ls_table_type [li_idx]
	IF	ls_inv_type	=	'ML'		THEN
		Continue
	END IF
	//	Get the base type for this invoice type
	ll_rc	=	inv_pattern_sql.uf_filter_stars_rel (ls_inv_type)
	ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]
	IF	ls_base_type	=	'UB92'	THEN
		// UB92
		is_revenue_code	=	inv_revenue.of_get_revenue (ls_inv_type)
		// If coming from subset options, there will be a bg job
		//	with no entry yet in sub_step_cntl
		IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	&
		OR	istr_sub_opt.patt_struc.come_from	=	'LOOKUP'		&
		OR	istr_sub_opt.patt_struc.come_from	=	'CRITERIA'	THEN
			IF	lb_revenue_moved	=	FALSE		THEN
				// Only move revenue once
				lb_revenue_moved	=	TRUE
				li_j ++
				is_tbl_retrieve [li_j]		=	is_revenue_code
				is_rel_type [li_j]			=	'DP'
				is_base_type [li_j]			=	inv_pattern_sql.uf_get_base_type (is_tbl_retrieve [li_j])
			END IF
		ELSE
			// FDG 03/12/02 - Possible for CR subset to not exist
			li_rc	=	This.wf_verify_table (ls_inv_type)	// Functions reads into is_dep_tables
			IF	li_rc	=	1		THEN
				// Find revenue (CR) in the dependent tables
				li_pos	=	Pos (is_dep_tables, is_revenue_code)
				IF	li_pos	>	0		THEN
					IF	lb_revenue_moved	=	FALSE		THEN
						// Only move revenue once
						li_j ++
						is_tbl_retrieve [li_j]	=	is_revenue_code
						is_rel_type [li_j]		=	'DP'
						is_base_type [li_j]		=	inv_pattern_sql.uf_get_base_type (is_tbl_retrieve [li_j])
					END IF
				END IF
			ELSE
				// JasonS 08/28/02 Begin - Track 2793d
				//MessageBox ('Application Error',	'In w_sampling_analysis_new.ue_get_tbl_retrieve, '	+	&
				//				'could not read sub_step_cntl for invoice type '	+	ls_inv_type)
				MessageBox ('Application Error',	'The invoice type  ' + ls_inv_type + &
								' is not in the selected subset.')
				// JasonS 08/28/02 End - Track 2793d								
				Return
			END IF
		END IF
	END IF
	// Include the original invoice type in is_tbl_retrieve
	li_j ++
	is_tbl_retrieve [li_j]		=	ls_inv_type
	is_rel_type [li_j]			=	'GP'
	is_base_type [li_j]			=	inv_pattern_sql.uf_get_base_type (is_tbl_retrieve [li_j])
NEXT

// Set the revenue code in inv_pattern_sql
inv_pattern_sql.uf_set_revenue_code (is_revenue_code)




end event

event ue_custom_default_title;//*********************************************************************************
// Script Name:	ue_custom_default_title
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern template is selected 
//						and when the Custom tab is cleared.  This script will set
//						the report's title to a default value.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row

String	ls_title

tab_patt.tabpage_custom.dw_title.Reset()

ll_row		=	tab_patt.tabpage_custom.dw_title.InsertRow(0)
tab_patt.tabpage_custom.dw_title.ScrollToRow (ll_row)

ls_title		=	'Pattern Recognition Report ('	+	is_pattern_id	+	')'

tab_patt.tabpage_custom.dw_title.object.rpt_title [1]	=	ls_title

// Update the report title in dw_patt_options
This.Event	ue_custom_title_change (ls_title)



end event

event ue_custom_load_selected;//*********************************************************************************
// Script Name:	ue_custom_load_selected
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern is selected or imported,
//						and when the Customize Report tab is cleared.  This event will
//						only get triggered for a generic pattern.
//
//						This event will reload dw_selected based on whether the pattern
//						is a user-defined pattern, imported pattern or a pattern template.
//						This event will also set the title based on these same conditions.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount,			&
			ll_avail_rowcount,	&
			ll_find_row,			&
			ll_select_count

String	ls_tbl_type,			&
			ls_col_name,			&
			ls_find

// Move all previously selected rows back to dw_available
This.Event	ue_custom_remove_all()

// Unhilite all rows in dw_available
tab_patt.tabpage_custom.dw_available.SelectRow (0, FALSE)

ll_avail_rowcount	=	tab_patt.tabpage_custom.dw_available.RowCount()

IF	Len (is_user_pattern_id)	>	0		&
OR	ib_import						=	TRUE	THEN
	// User defined pattern or importing.  The report title has been already read.
	//	Read the data from patt_columns and move them to dw_selected.
	IF	ib_import	=	FALSE		THEN
		// Get the previously saved selected columns for the user-defined pattern
		ids_patt_columns.Reset()
		ll_rowcount		=	ids_patt_columns.Retrieve (is_user_pattern_id)
	ELSE
		// Importing a pattern.  ids_patt_columns was already loaded from the
		//	import records.
		ll_rowcount		=	ids_patt_columns.RowCount()
	END IF
	FOR	ll_row	=	1	TO	ll_rowcount
		ls_tbl_type	=	ids_patt_columns.object.tbl_type [ll_row]
		ls_col_name	=	ids_patt_columns.object.col_name [ll_row]
		ls_find		=	"elem_tbl_type = '"		+	ls_tbl_type	+	&
							"' and elem_name = '"	+	ls_col_name	+	"'"
		// Move the found row from dw_available to dw_selected.  
		ll_find_row	=	tab_patt.tabpage_custom.dw_available.Find (ls_find, 1, ll_avail_rowcount)
		IF	ll_find_row	>	0		THEN
			//tab_patt.tabpage_custom.dw_available.SelectRow (ll_find_row, TRUE)
			ll_select_count	=	tab_patt.tabpage_custom.dw_selected.RowCount()
			tab_patt.tabpage_custom.dw_available.RowsMove	(ll_find_row,						&
																			ll_find_row,						&
																			Primary!,								&
																			tab_patt.tabpage_custom.dw_selected,	&
																			ll_select_count + 1,					&
																			Primary!)
			ll_avail_rowcount		--
		END IF
	NEXT	
	// Set the report title based on the data in dw_patt_options
	This.Event	ue_custom_load_title()
	// Now that the desired rows are moved, perform additional "Add" logic to dw_selected
	This.Event	ue_custom_add()	
ELSE
	// Pattern Template.  Logic below (this 'IF') will load dw_selected from patt_field_sel.
	//	patt_field_sel has the default columns for a pattern template.
	// Also, set the report title to its default value.
	This.Event	ue_custom_default_title()
END IF

// If there are no rows in dw_selected (which will occur for a pattern template and
//	could occur for a user-defined pattern/imported pattern with no selected columns), 
//	read patt_field_sel to load dw_selected with the default columns.

ll_rowcount			=	tab_patt.tabpage_custom.dw_selected.RowCount()
ll_avail_rowcount	=	tab_patt.tabpage_custom.dw_available.RowCount()

IF	ll_rowcount	=	0		THEN
	// Load dw_selected from patt_field_sel
	ids_patt_field_sel.Reset()
	// Include the revenue table in the retrieve
	//ll_rowcount	=	ids_patt_field_sel.Retrieve(is_tbl_retrieve)
	ll_rowcount	=	ids_patt_field_sel.Retrieve(istr_sub_opt.patt_struc.table_type)
	// FDG 05/02/01 - If no rows exist in patt_field_sel, hilite ICN so it can be moved.
	IF	ll_rowcount	=	0		THEN
		ls_find	=	"Upper(elem_name) = 'ICN'"
		ll_find_row	=	tab_patt.tabpage_custom.dw_available.Find (ls_find, 1, ll_avail_rowcount)
		IF	ll_find_row	>	0		THEN
			tab_patt.tabpage_custom.dw_available.SelectRow (ll_find_row, TRUE)
		END IF
	ELSE
	// FDG 05/02/01 end
		FOR	ll_row	=	1	TO	ll_rowcount
			ls_tbl_type	=	ids_patt_field_sel.object.tbl_type [ll_row]
			ls_col_name	=	ids_patt_field_sel.object.field_column [ll_row]
			ls_find		=	"elem_tbl_type = '"		+	ls_tbl_type	+	&
								"' and elem_name = '"	+	ls_col_name	+	"'"
			// Hilite each row found in dw_available.  Then move those rows to
			//	dw_selected.
			ll_find_row	=	tab_patt.tabpage_custom.dw_available.Find (ls_find, 1, ll_avail_rowcount)
			IF	ll_find_row	>	0		THEN
				tab_patt.tabpage_custom.dw_available.SelectRow (ll_find_row, TRUE)
			END IF
		NEXT
	END IF
	
END IF

// Now that the desired rows are hilited, move the hilited rows to dw_selected
This.Event	ue_custom_add()


end event

event ue_custom_clear;//*********************************************************************************
// Script Name:	ue_custom_clear
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when the Clear RMM/Button occurs
//						on the Customize Report tab.
//
//						This event will clear dw_selected (except the unique key columns)
//						and reset the report title.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

// Hilite all rows in dw_selected
tab_patt.tabpage_custom.dw_selected.SelectRow (0, TRUE)

// Execute the script to remove the hilited rows (except the unique key columns).
This.Event	ue_custom_remove()

// Execute the script to reset the report title
This.Event	ue_custom_default_title()





end event

event ue_custom_load_patt_columns;//*********************************************************************************
// Script Name:	ue_custom_load_patt_columns
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a pattern is saved and when
//						a pattern is being exported.
//
//						This event will read dw_selected to load ids_patt_columns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_row,					&
			ll_rowcount,			&
			ll_new_row,				&
			ll_find_row

String	ls_tbl_type,			&
			ls_col_name,			&
			ls_find,					&
			ls_sql

// Reset any previously read data
IF	(is_save_mode	=	'S'	OR	is_save_mode	=	'L')		&
AND ib_save	=	TRUE													THEN
	// Saving a previously read pattern.  Since all data is going to be refreshed,
	// use DeleteRow() to generate SQL deletes on the old data.
	ls_sql	=	"delete from patt_columns where patt_id = '"	+	Upper( is_user_pattern_id )	+	"'"
	Stars2ca.of_set_sql (ls_sql)
	li_rc		=	Stars2ca.of_execute (ls_sql)
END IF

// Remove all prior data.
ids_patt_columns.Reset()

ll_rowcount	=	tab_patt.tabpage_custom.dw_selected.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ll_new_row	=	ids_patt_columns.InsertRow(0)
	ids_patt_columns.object.seq_num [ll_new_row]		=	ll_new_row
	ids_patt_columns.object.tbl_type [ll_new_row]	=	tab_patt.tabpage_custom.dw_selected.object.elem_tbl_type [ll_row]
	ids_patt_columns.object.col_name [ll_new_row]	=	tab_patt.tabpage_custom.dw_selected.object.elem_name [ll_row]
	ids_patt_columns.object.col_type [ll_new_row]	=	'PAT'
	tab_patt.tabpage_custom.dw_selected.SetItemStatus (ll_row, 0, Primary!, NotModified!)
NEXT



end event

event type string ue_export_file_hdr(integer ai_file_number, string as_comment);//*********************************************************************************
// Script Name:	ue_export_file_hdr
//
//	Arguments:		as_comment - The comment to be included in the file header record.
//
// Returns:			String - The record layout for the File header
//
//	Description:	Create the record layout for the file header record.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/15/01	GaryR	Track 2662d	Software version can be > 10 bytes.
//
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

Integer		li_rc

String		ls_record,				&
				ls_software_version,	&
				ls_file_type,			&
				ls_date_time

//	01/15/01	GaryR	Track 2662d - Begin
//ls_software_version	= 	lnv_string.of_PadRight (gnv_app.of_get_version(), 10)
ls_software_version	=	Upper (gnv_app.of_get_version() )

IF	Left (ls_software_version, 7)	=	'VERSION'	THEN
	ls_software_version	=	Trim ( Mid(ls_software_version, 8) )
END IF

IF	Len (ls_software_version)	>	10		THEN
	ls_software_version	=	Left (ls_software_version, 10)
END IF

ls_software_version	= 	lnv_string.of_PadRight (ls_software_version, 10)
//	01/15/01	GaryR	Track 2662d - End

ls_file_type			=	lnv_string.of_PadRight ('PATTERN', 10)
ls_date_time			= 	String (gnv_app.of_get_server_date_time(), 'mm/dd/yyyy hh:mm:ss')

ls_record	=	'A'						+	lcs_delimiter	+	&
					ls_software_version	+	lcs_delimiter	+	&
					ls_date_time			+	lcs_delimiter	+	&
					ls_file_type			+	lcs_delimiter	+	&
					as_comment				+	lcs_delimiter

li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing file header for the export file.  Export is cancelled.')
	Return	'ERROR'
END IF


Return	ls_record

end event

event ue_export_pattern_hdr;//*********************************************************************************
// Script Name:	ue_export_pattern_hdr
//
//	Arguments:		ai_file_number - The file number for the exported file.
//
// Returns:			String - The record layout for the Pattern header
//
//	Description:	Create the record layout for the Pattern header record.
//
//	Notes:			Make sure that the pattern template ID is the exported pattern ID.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

Integer		li_rc

Long			ll_row

String		ls_record,				&
				ls_patt_id,				&
				ls_patt_inv_type,		&
				ls_base_plus,			&
				ls_exe_ind,				&
				ls_patt_desc,			&
				ls_patt_cond,			&
				ls_patt_type

// Get the data from patt_cntl

ll_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

ls_patt_inv_type	=	Trim (tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_inv_type [ll_row])
ls_patt_type		=	Trim (tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_type [ll_row])
ls_patt_cond		=	Trim (tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_cond [ll_row])
ls_patt_desc		=	Trim (tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_row])
ls_patt_id			=	Trim (is_pattern_id)			//	Always export the pattern template ID
ls_base_plus		=	Trim (tab_patt.tabpage_criteria.dw_patt_cntl.object.base_plus [ll_row])
ls_exe_ind			=	Trim (tab_patt.tabpage_criteria.dw_patt_cntl.object.exe_ind [ll_row])

IF	IsNull (ls_patt_cond)	THEN
	ls_patt_cond	=	''
END IF

ls_patt_id			= 	lnv_string.of_PadRight (ls_patt_id, 10)
ls_patt_inv_type	=	lnv_string.of_PadRight (ls_patt_inv_type, 2)
ls_base_plus		= 	lnv_string.of_PadRight (ls_base_plus, 1)
ls_exe_ind			= 	lnv_string.of_PadRight (ls_exe_ind, 1)
ls_patt_type		= 	lnv_string.of_PadRight (ls_patt_type, 1)
ls_patt_cond		= 	lnv_string.of_PadRight (ls_patt_cond, 25)
ls_patt_desc		= 	lnv_string.of_PadRight (ls_patt_desc, 255)

ls_record	=	'B'						+	lcs_delimiter	+	&
					ls_patt_id				+	lcs_delimiter	+	&
					ls_patt_inv_type		+	lcs_delimiter	+	&
					ls_base_plus			+	lcs_delimiter	+	&
					ls_exe_ind				+	lcs_delimiter	+	&
					ls_patt_type			+	lcs_delimiter	+	&
					ls_patt_cond			+	lcs_delimiter	+	&
					ls_patt_desc			+	lcs_delimiter

li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing the pattern header for the export file.  Export is cancelled.')
	Return	'ERROR'
END IF


Return	ls_record

end event

event type string ue_export_pattern_tables(integer ai_file_number);//*********************************************************************************
// Script Name:	ue_export_pattern_tables
//
//	Arguments:		ai_file_number - The file number for the exported file.
//
// Returns:			String
//						''			=	Success
//						'ERROR'	=	Error
//
//	Description:	Create the record layout for the Pattern tables record.
//						When exporting, a record will be written for each distinct 
//						invoice type.  For example, if the first two lines of criteria
//						use C1 and the next two lines use C4, then two records will
//						be written.  Because multiple invoice types can have the
//						same base type, there could be multiple records with the same
//						base type.
//
//	Notes:			Array is_tbl_retrieve[] has the list of unique invoice types.
//						However, only the invoice types accessed in dw_criteria and
//						dw_selected will be added to the file.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// JasonS 08/27/02	Track 2973d Only insert valid tbl types into array
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

Boolean		lb_found

Integer		li_rc,					&
				li_idx,					&
				li_idx2,					&
				li_upper,				&
				li_upper2

Long			ll_row,					&
				ll_rowcount

String		ls_record,				&
				ls_empty[],				&
				ls_field_tbl_type,	&
				ls_tbl_desc,			&
				ls_base_type,			&
				ls_rel_type,			&
				ls_seq_num

// Clear out the previous list of unique table types
is_unique_tbl_type	=	ls_empty

// Get the unique table types from dw_criteria

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.Rowcount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_field_tbl_type	=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]
	IF IsNull (ls_field_tbl_type)			&
	OR	ls_field_tbl_type	=	''				THEN
		Continue
	END IF
	//	Find the tbl type within the list of generated unique table types
	lb_found		=	FALSE
	li_upper		=	UpperBound (is_unique_tbl_type)
	FOR	li_idx	=	1	TO	li_upper
		IF	ls_field_tbl_type	=	is_unique_tbl_type [li_idx]		THEN
			lb_found	=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_found		=	FALSE		THEN
		// Table type not found in is_unique_tbl_type[].  Add it to the end.
		li_upper	++
		// JasonS 08/27/02 Begin - Track 2973d
		//is_unique_tbl_type [li_upper]	=	ls_field_tbl_type		
		if trim(ls_field_tbl_type) <> '' then
			is_unique_tbl_type [li_upper]	=	ls_field_tbl_type
		end if
		// JasonS 08/27/02 End - Track 2973d
	END IF
NEXT

// Get the unique table types from dw_selected

ll_rowcount		=	tab_patt.tabpage_custom.dw_selected.Rowcount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_field_tbl_type	=	tab_patt.tabpage_custom.dw_selected.object.elem_tbl_type [ll_row]
	IF IsNull (ls_field_tbl_type)			&
	OR	ls_field_tbl_type	=	''				THEN
		Continue
	END IF
	//	Find the tbl type within the list of generated unique table types
	lb_found		=	FALSE
	li_upper		=	UpperBound (is_unique_tbl_type)
	FOR	li_idx	=	1	TO	li_upper
		IF	ls_field_tbl_type	=	is_unique_tbl_type [li_idx]		THEN
			lb_found	=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_found		=	FALSE		THEN
		// Table type not found in is_unique_tbl_type[].  Add it to the end.
		li_upper	++
		is_unique_tbl_type [li_upper]	=	ls_field_tbl_type
	END IF
NEXT


// Loop thru is_unique_tbl_type to get its table description and base type.
//	Then use this data to write the export records.

li_upper		=	UpperBound (is_unique_tbl_type)
li_upper2	=	UpperBound (is_tbl_retrieve)	// Corresponds to is_rel_type[]

FOR	li_idx	=	1	TO	li_upper
	ls_tbl_desc	=	inv_pattern_sql.uf_get_tbl_desc (is_unique_tbl_type[li_idx])
	//	Get the base type for this table type
	ls_base_type	=	inv_pattern_sql.uf_get_base_type (is_unique_tbl_type[li_idx])
	// Get the rel type for this table type
	FOR	li_idx2	=	1	TO	li_upper2
		IF	is_unique_tbl_type[li_idx]	=	is_tbl_retrieve[li_idx2]	THEN
			ls_rel_type		=	is_rel_type [li_idx2]
			Exit
		END IF
	NEXT
	ls_tbl_desc		=	lnv_string.of_PadRight (ls_tbl_desc, 30)
	ls_base_type	=	lnv_string.of_PadRight (ls_base_type, 30)
	ls_seq_num		=	String (li_idx, '000')
	ls_record		=	'C'					+	lcs_delimiter	+	&
							ls_seq_num			+	lcs_delimiter	+	&
							ls_base_type		+	lcs_delimiter	+	&
							ls_tbl_desc			+	lcs_delimiter	+	&
							ls_rel_type			+	lcs_delimiter
	li_rc				=	FileWrite (ai_file_number, ls_record)
	IF	li_rc	<	0		THEN
		MessageBox ('Export Error', 'Error writing patterns tables record for the export file.  Export is cancelled.')
		Return	'ERROR'
	END IF
NEXT

// Write the Patterns Tables Trailer record
ls_record		=	'D'	+	' Pattern Tables Trailer Record'
li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing patterns tables trailer record for the export file.'	+	&
					'Export is cancelled.')
	Return	'ERROR'
END IF


Return	''

end event

event ue_export_pattern_options;//*********************************************************************************
// Script Name:	ue_export_pattern_options
//
//	Arguments:		ai_file_number - The file number for the exported file.
//
// Returns:			String
//						''			=	Success
//						'ERROR'	=	Error
//
//	Description:	Create the record layout for the Pattern options record.
//						The table type is not imported from this record because it 
//						is computed from the patterns tables record.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

Boolean		lb_found

Integer		li_rc,							&
				li_idx,							&
				li_upper,						&
				li_timeframe_button,			&
				li_timeframe_num_of_days

Long			ll_row,							&
				ll_rowcount

String		ls_record,						&
				ls_patt_id,						&
				ls_patt_template,				&
				ls_subc_tables,				&
				ls_claim_ind,					&
				ls_day_ind,						&
				ls_patient_ind,				&
				ls_tooth_ind,					&
				ls_combination_ind,			&
				ls_allwd_srvc_ind,			&
				ls_timeframe_from_thru,		&
				ls_timeframe_tbl_type_1,	&
				ls_timeframe_field_1,		&
				ls_timeframe_column_1,		&
				ls_timeframe_tbl_type_2,	&
				ls_timeframe_field_2,		&
				ls_timeframe_column_2,		&
				ls_rpt_title,					&
				ls_timeframe_button,			&
				ls_timeframe_num_of_days,	&
				ls_seq1,							&
				ls_seq2,							&
				ls_desc1,						&
				ls_desc2


// Get the data for this record from dw_selected

ll_row		=	tab_patt.tabpage_options.dw_patt_options.GetRow()

IF	ll_row	<	1		THEN
	MessageBox ('Export Error', 'In ue_export_pattern_options, cannot get the current patt_options data.  '	+	&
					'Export is cancelled.')
	Return	'ERROR'
END IF
	
ls_patt_id					=	Trim (tab_patt.tabpage_options.dw_patt_options.object.patt_id [ll_row])
ls_patt_template			=	Trim (tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_row])
ls_subc_tables				=	Trim (tab_patt.tabpage_options.dw_patt_options.object.subc_tables [ll_row])
ls_claim_ind				=	Trim (tab_patt.tabpage_options.dw_patt_options.object.claim_ind [ll_row])
ls_day_ind					=	Trim (tab_patt.tabpage_options.dw_patt_options.object.day_ind [ll_row])
ls_patient_ind				=	Trim (tab_patt.tabpage_options.dw_patt_options.object.patient_ind [ll_row])
ls_tooth_ind				=	Trim (tab_patt.tabpage_options.dw_patt_options.object.tooth_ind [ll_row])
ls_combination_ind		=	Trim (tab_patt.tabpage_options.dw_patt_options.object.combination_ind [ll_row])
ls_allwd_srvc_ind			=	Trim (tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind [ll_row])
ls_timeframe_from_thru	=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_row])
ls_timeframe_tbl_type_1	=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row])
ls_timeframe_field_1		=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row])
ls_timeframe_column_1	=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row])
ls_timeframe_tbl_type_2	=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row])
ls_timeframe_field_2		=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row])
ls_timeframe_column_2	=	Trim (tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row])
ls_rpt_title				=	Trim (tab_patt.tabpage_options.dw_patt_options.object.rpt_title [ll_row])
li_timeframe_num_of_days =	tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]
li_timeframe_button		=	tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_row]

// Get the column descriptions for the time frame columns
//ls_desc1						=	inv_pattern_sql.uf_get_col_desc (ls_timeframe_tbl_type_1, ls_timeframe_column_1)
//ls_desc2						=	inv_pattern_sql.uf_get_col_desc (ls_timeframe_tbl_type_2, ls_timeframe_column_2)
ls_desc1						=	ls_timeframe_field_1
ls_desc2						=	ls_timeframe_field_2

//	Find the tbl type for the timeframe columns within the list of generated unique 
//	table types to assign the sequence number.

ls_seq1		=	'000'
ls_seq2		=	'000'
li_upper		=	UpperBound (is_unique_tbl_type)

lb_found		=	FALSE

FOR	li_idx	=	1	TO	li_upper
	IF	ls_timeframe_tbl_type_1	=	is_unique_tbl_type [li_idx]		THEN
		lb_found				=	TRUE
		ls_seq1				=	String (li_idx, '000')
		Exit
	END IF
NEXT

lb_found		=	FALSE

FOR	li_idx	=	1	TO	li_upper
	IF	ls_timeframe_tbl_type_2	=	is_unique_tbl_type [li_idx]		THEN
		lb_found				=	TRUE
		ls_seq2				=	String (li_idx, '000')
		Exit
	END IF
NEXT

ls_patt_id					=	lnv_string.of_PadRight (ls_patt_id, 10)
ls_patt_template			=	lnv_string.of_PadRight (ls_patt_template, 10)
ls_subc_tables				=	lnv_string.of_PadRight (ls_subc_tables, 14)
ls_claim_ind				=	lnv_string.of_PadRight (ls_claim_ind, 1)
ls_day_ind					=	lnv_string.of_PadRight (ls_day_ind, 1)
ls_patient_ind				=	lnv_string.of_PadRight (ls_patient_ind, 1)
ls_tooth_ind				=	lnv_string.of_PadRight (ls_tooth_ind, 1)
ls_combination_ind		=	lnv_string.of_PadRight (ls_combination_ind, 1)
ls_allwd_srvc_ind			=	lnv_string.of_PadRight (ls_allwd_srvc_ind, 1)
ls_timeframe_button		=	String (li_timeframe_button, '00')
ls_timeframe_from_thru	=	lnv_string.of_PadRight (ls_timeframe_from_thru, 1)
ls_timeframe_tbl_type_1	=	lnv_string.of_PadRight (ls_timeframe_tbl_type_1, 2)
ls_timeframe_column_1	=	lnv_string.of_PadRight (ls_timeframe_column_1, 30)
ls_timeframe_tbl_type_2	=	lnv_string.of_PadRight (ls_timeframe_tbl_type_2, 2)
ls_timeframe_column_2	=	lnv_string.of_PadRight (ls_timeframe_column_2, 30)
ls_timeframe_num_of_days =	String (li_timeframe_num_of_days, '000000')
ls_rpt_title				=	lnv_string.of_PadRight (ls_rpt_title, 255)
ls_desc1						=	lnv_string.of_PadRight (ls_desc1, 30)
ls_desc2						=	lnv_string.of_PadRight (ls_desc2, 30)

ls_record		=	'E'							+	lcs_delimiter	+	&
						ls_patt_id					+	lcs_delimiter	+	&
						ls_patt_template			+	lcs_delimiter	+	&
						ls_subc_tables				+	lcs_delimiter	+	&
						ls_claim_ind				+	lcs_delimiter	+	&
						ls_day_ind					+	lcs_delimiter	+	&
						ls_patient_ind				+	lcs_delimiter	+	&
						ls_tooth_ind				+	lcs_delimiter	+	&
						ls_combination_ind		+	lcs_delimiter	+	&
						ls_allwd_srvc_ind			+	lcs_delimiter	+	&
						ls_timeframe_from_thru	+	lcs_delimiter	+	&
						ls_timeframe_button		+	lcs_delimiter	+	&
						ls_timeframe_tbl_type_1	+	lcs_delimiter	+	&
						ls_seq1						+	lcs_delimiter	+	&
						ls_timeframe_column_1	+	lcs_delimiter	+	&
						ls_timeframe_tbl_type_2	+	lcs_delimiter	+	&
						ls_seq2						+	lcs_delimiter	+	&
						ls_timeframe_column_2	+	lcs_delimiter	+	&
						ls_timeframe_num_of_days +	lcs_delimiter	+	&
						ls_rpt_title				+	lcs_delimiter	+	&
						ls_desc1						+	lcs_delimiter	+	&
						ls_desc2						+	lcs_delimiter

li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing patterns options record for the export file.  Export is cancelled.')
	Return	'ERROR'
END IF


Return	''

end event

event type string ue_export_pattern_criteria(integer ai_file_number);//*********************************************************************************
// Script Name:	ue_export_pattern_criteria
//
//	Arguments:		ai_file_number - The file number for the exported file.
//
// Returns:			String
//						''			=	Success
//						'ERROR'	=	Error
//
//	Description:	Create the record layout for the Pattern criteria record.
//						The table type is not imported from this record because it 
//						is computed from the patterns tables record.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 11/13/09 RickB LKP.650.5678.001 Defect #162 - Expanded ls_field_value to 255
//
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

Boolean		lb_found

Integer		li_rc,						&
				li_idx,						&
				li_upper,					&
				li_seq_num

Long			ll_row,						&
				ll_rowcount

String		ls_record,					&
				ls_field_tbl_type,		&
				ls_field_description,	&
				ls_field_col_name,		&
				ls_field_value,			&
				ls_field_operator,		&
				ls_field_type,				&
				ls_field_name,				&
				ls_and_field,				&
				ls_field_set,				&
				ls_field_lookup,			&
				ls_field_alone,			&
				ls_field_also,				&
				ls_base_type,				&
				ls_protect_ind,			&
				ls_protect_oper_ind,		&
				ls_seq_num

// Loop thru dw_criteria to get the data for this record.

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.Rowcount()
li_upper			=	UpperBound (is_unique_tbl_type)

FOR	ll_row	=	1	TO	ll_rowcount
	ls_field_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]
	//IF IsNull (ls_field_tbl_type)			&
	//OR	ls_field_tbl_type	=	''				THEN
	//	Continue
	//END IF
	ls_field_col_name		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row])
	ls_field_description	=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_row])
	ls_field_value			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_value [ll_row])
	ls_field_operator		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_row])
	ls_field_type			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_type [ll_row])
	ls_field_name			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_name [ll_row])
	ls_and_field			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.and_field [ll_row])
	ls_field_set			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row])
	ls_field_lookup		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_row])
	ls_field_alone			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_alone [ll_row])
	ls_field_also			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_also [ll_row])
	ls_protect_ind			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [ll_row])
	ls_protect_oper_ind	=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.protect_operand_ind [ll_row])
	//	Find the tbl type within the list of generated unique table types to assign the 
	//	sequence number.
	IF	Len (ls_field_col_name)	>	0		THEN
		lb_found		=	FALSE
		FOR	li_idx	=	1	TO	li_upper
			IF	ls_field_tbl_type	=	is_unique_tbl_type [li_idx]		THEN
				lb_found				=	TRUE
				ls_seq_num			=	String (li_idx, '000')
				Exit
			END IF
		NEXT
	ELSE
		// No column selected
		ls_seq_num			=	'000'
	END IF
	ls_field_tbl_type		=	lnv_string.of_PadRight (ls_field_tbl_type, 2)
	ls_field_col_name		=	lnv_string.of_PadRight (ls_field_col_name, 30)
	ls_field_description	=	lnv_string.of_PadRight (ls_field_description, 50)
	ls_field_value			=	lnv_string.of_PadRight (ls_field_value, 255)
	ls_field_operator		=	lnv_string.of_PadRight (ls_field_operator, 10)
	ls_field_type			=	lnv_string.of_PadRight (ls_field_type, 20)
	ls_field_name			=	lnv_string.of_PadRight (ls_field_name, 10)
	ls_and_field			=	lnv_string.of_PadRight (ls_and_field, 2)
	ls_field_set			=	lnv_string.of_PadRight (ls_field_set, 10)
	ls_field_lookup		=	lnv_string.of_PadRight (ls_field_lookup, 2)
	ls_field_alone			=	lnv_string.of_PadRight (ls_field_alone, 10)
	ls_field_also			=	lnv_string.of_PadRight (ls_field_also, 10)
	ls_record		=	'F'						+	lcs_delimiter	+	&
							ls_seq_num				+	lcs_delimiter	+	&
							ls_field_tbl_type		+	lcs_delimiter	+	&
							ls_field_col_name		+	lcs_delimiter	+	&
							ls_field_value			+	lcs_delimiter	+	&
							ls_field_operator		+	lcs_delimiter	+	&
							ls_field_type			+	lcs_delimiter	+	&
							ls_field_name			+	lcs_delimiter	+	&
							ls_and_field			+	lcs_delimiter	+	&
							ls_field_set			+	lcs_delimiter	+	&
							ls_field_lookup		+	lcs_delimiter	+	&
							ls_field_alone			+	lcs_delimiter	+	&
							ls_field_also			+	lcs_delimiter	+	&
							ls_field_description	+	lcs_delimiter	+	&
							ls_protect_ind			+	lcs_delimiter	+	&
							ls_protect_oper_ind	+	lcs_delimiter
	li_rc				=	FileWrite (ai_file_number, ls_record)
	IF	li_rc	<	0		THEN
		MessageBox ('Export Error', 'Error writing patterns criteria record for the export file.  Export is cancelled.')
		Return	'ERROR'
	END IF
NEXT

// Write the Patterns Criteria Trailer record
ls_record		=	'G'	+	' Pattern Criteria Trailer Record'
li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing patterns criteria trailer record for the export file.'	+	&
					'Export is cancelled.')
	Return	'ERROR'
END IF


Return	''

end event

event ue_export_pattern_columns;//*********************************************************************************
// Script Name:	ue_export_pattern_columns
//
//	Arguments:		ai_file_number - The file number for the exported file.
//
// Returns:			String
//						''			=	Success
//						'ERROR'	=	Error
//
//	Description:	Create the record layout for the Pattern columns record.
//						The table type is not imported from this record because it 
//						is computed from the patterns tables record.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

Boolean		lb_found

Integer		li_rc,					&
				li_idx,					&
				li_upper

Long			ll_row,					&
				ll_rowcount

String		ls_record,				&
				ls_empty[],				&
				ls_tbl_type,			&
				ls_col_type,			&
				ls_col_desc,			&
				ls_col_name,			&
				ls_base_type,			&
				ls_seq_num

// Get the data for this record from dw_selected

ll_rowcount		=	tab_patt.tabpage_custom.dw_selected.Rowcount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_tbl_type		=	tab_patt.tabpage_custom.dw_selected.object.elem_tbl_type [ll_row]
	IF IsNull (ls_tbl_type)			&
	OR	ls_tbl_type	=	''				THEN
		Continue
	END IF
	ls_tbl_type		=	Trim (tab_patt.tabpage_custom.dw_selected.object.elem_tbl_type [ll_row])
	ls_col_desc		=	Trim (tab_patt.tabpage_custom.dw_selected.object.elem_desc [ll_row])
	ls_col_name		=	Trim (tab_patt.tabpage_custom.dw_selected.object.elem_name [ll_row])
	ls_col_type		=	'PAT'
	//	Find the tbl type within the list of generated unique table types
	lb_found		=	FALSE
	li_upper		=	UpperBound (is_unique_tbl_type)
	FOR	li_idx	=	1	TO	li_upper
		IF	ls_tbl_type	=	is_unique_tbl_type [li_idx]		THEN
			lb_found	=	TRUE
			ls_seq_num		=	String (li_idx, '000')
			Exit
		END IF
	NEXT
	ls_col_name		=	lnv_string.of_PadRight (ls_col_name, 30)
	ls_col_desc		=	lnv_string.of_PadRight (ls_col_desc, 30)
	ls_record		=	'H'				+	lcs_delimiter	+	&
							ls_seq_num		+	lcs_delimiter	+	&
							ls_col_type		+	lcs_delimiter	+	&
							ls_col_name		+	lcs_delimiter	+	&
							ls_col_desc		+	lcs_delimiter
	li_rc				=	FileWrite (ai_file_number, ls_record)
	IF	li_rc	<	0		THEN
		MessageBox ('Export Error', 'Error writing patterns columns record for the export file.  Export is cancelled.')
		Return	'ERROR'
	END IF
NEXT

// Write the Patterns Columns Trailer record

ls_record		=	'I'	+	' Pattern Columns Trailer Record'
li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing patterns columns trailer record for the export file.'	+	&
					'Export is cancelled.')
	Return	'ERROR'
END IF

Return	''

end event

event ue_enable_link;//*********************************************************************************
// Script Name:	ue_enable_link
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the import RMM
//						FALSE	-	Disable the import RMM
//
// Returns:			None
//
//	Description:	Enable/disable the Link RMM depending on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_link.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_link.enabled		=	ab_switch
im_patt_timeframe.m_dummyitem.m_link.enabled		=	ab_switch
im_patt_custom.m_dummyitem.m_link.enabled			=	ab_switch
im_patt_report.m_dummyitem.m_link.enabled			=	ab_switch

end event

event ue_retrieve_field_dddw();//*********************************************************************************
// Script Name:	ue_retrieve_field_dddw
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when the pattern is selected and when
//						a pattern is imported.  This script will retrieve the data
//						for the criteria DDDW.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

Boolean	lb_revenue_moved

Integer	li_idx,					&
			li_idx2,					&
			li_upper,				&
			li_rc,					&
			li_pos

Long		ll_row,					&
			ll_rowcount

String	ls_base_type,			&
			ls_tbl_type[],			&
			ls_data_type,			&
			ls_revenue,				&
			ls_elem_desc

DataWindowChild	ldwc_field_name

is_filter		=	''		// Re-initialize the filter string

// is_tbl_retrieve is already set.

// Filter the field description DDDW (ldwc_field_name) and truncate the descriptions. 

li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', ldwc_field_name)

li_upper	=	UpperBound (is_tbl_retrieve)

FOR	li_idx	=	1	TO	li_upper
	is_filter	=	is_filter	+	" or "	+	"elem_tbl_type = '"	+	&
						is_tbl_retrieve [li_idx]	+	"'"
NEXT

IF	Len (is_filter)	>	0		THEN
	// Remove the leading ' or ' and append crit_seq
	is_filter	=	'('	+	Mid (is_filter, 5)	+	')'	+	' and crit_seq > 0'
	li_rc	=	ldwc_field_name.SetFilter('')
	li_rc	=	ldwc_field_name.Filter()
	ll_rowcount	=	ldwc_field_name.RowCount()
	li_rc	=	ldwc_field_name.SetFilter(is_filter)
	li_rc	=	ldwc_field_name.Filter()
	li_rc	=	ldwc_field_name.SetSort('elem_tbl_type A, crit_seq A, elem_desc A')
	li_rc	=	ldwc_field_name.Sort()
END IF

ll_rowcount	=	ldwc_field_name.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_elem_desc	=	ldwc_field_name.GetItemString (ll_row, 'elem_desc')
	// Truncate to 15 bytes and convert to upper case
	inv_pattern_sql.uf_edit_elem_desc (ls_elem_desc)
	ldwc_field_name.SetItem (ll_row, 'elem_desc', ls_elem_desc)

	IF	ib_include_non_string_columns	=	FALSE		THEN
		//	If the data type is not VARCHAR or CHAR, then remove it.
		ls_data_type	=	Upper (ldwc_field_name.GetItemString (ll_row, 'elem_data_type') )
		// FDG 04/16/01 - Make data type checking dbms independent
		IF	gnv_sql.of_is_character_data_type (ls_data_type)	=	TRUE		THEN
			// Column has a 'VARCHAR' or 'CHAR' data type.  Keep it.
		ELSE
			// Remove the row from the drop-down
			ldwc_field_name.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row	--
			ll_rowcount	--
		END IF
	END IF
NEXT

// Free up any locks
Stars2ca.of_commit()
end event

event ue_edit_save_mode;//*********************************************************************************
// Script Name:	ue_edit_save_mode
//
//	Arguments:		None
//
// Returns:			Integer
//						-1	=	Error.  Don't continue with the Save
//						1	=	Success.  Continue with the Save.
//
//	Description:	This event is triggered from ue_presave when the save mode
//						is 'S' (Save) or 'L' (Link).
//
//						This script will determine if the save mode is to changed
//						to 'A' (Save As).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_userid,				&
			ls_link_key,			&
			ls_save_mode

// Store the previously set save mode so we can compare the old
//	with the new value.
ls_save_mode		=	is_save_mode

IF	Len (is_user_pattern_id)	=	0		THEN
	// Saving a pattern template.  Change to Save As.
	is_save_mode	=	'A'
	Return	1
END IF

// From this point on, we are saving/linking a previously read user-defined
// pattern.

ls_userid	=	ids_case_link.object.user_id [1]
ls_link_key	=	ids_case_link.object.link_key [1]

IF	ls_userid	<>	gc_user_id		THEN
	// User IDs don't match.  Change to Save As.
	is_save_mode	=	'A'
END IF

IF	is_save_mode	=	'A'		THEN
	// Save mode changed to 'Save As'.  If a case_link row was retrieved,
	//	create a new one.  If notes are ever added to patterns, they may
	//	need to be copied from the old case_link to the new (if case_id
	//	= 'NONE').
END IF			//	is_save_mode	=	'A'

Return	1

end event

event ue_custom_title_change;//*********************************************************************************
// Script Name:	ue_custom_title_change
//
//	Arguments:		as_title - Value in dw_title
//
// Returns:			N/A
//
//	Description:	This event will take the contents in dw_title and update it 
//						in dw_patt_options.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row


ll_row		=	tab_patt.tabpage_options.dw_patt_options.GetRow()

tab_patt.tabpage_options.dw_patt_options.object.rpt_title [ll_row]	=	as_title



end event

event ue_create_patt_rel;//*********************************************************************************
// Script Name:	ue_create_patt_rel
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will create a patt_rel row for a newly created
//						user-defined pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,			&
			ll_cntl_row

ids_patt_rel.RowsDiscard (1, ids_patt_rel.RowCount(), Primary!)
ids_patt_rel.Reset()

ll_row	=	ids_patt_rel.InsertRow(0)
ids_patt_rel.SetRow (ll_row)

ll_cntl_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

IF	ll_cntl_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_create_patt_rel, '	+	&
					'cannot get the current row in dw_patt_cntl.')
	Return	-1
END IF

ids_patt_rel.object.patt_id [ll_row]	=	''
ids_patt_rel.object.rel_type [ll_row]	=	is_inv_type
ids_patt_rel.object.rel_id [ll_row]		=	is_inv_type


Return	1

end event

event ue_import_clean_up;//*********************************************************************************
// Script Name:	ue_import_clean_up
//
//	Arguments:		1.	al_file_number - File # to close
//						2.	ab_close_file.  
//							TRUE = Close the file.  
//							FALSE = Leave it open.
//
// Returns:			N/A
//
//	Description:	This event will clear the datawindows on the tabs and will
//						disable the tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

// Clear out the datawindows
This.Event	ue_clear_dws()

//	Disable the tabs
tab_patt.tabpage_criteria.enabled		=	FALSE
tab_patt.tabpage_options.enabled			=	FALSE
tab_patt.tabpage_timeframe.enabled		=	FALSE
tab_patt.tabpage_custom.enabled			=	FALSE
tab_patt.tabpage_report.enabled			=	FALSE

// Re-retrieve the data in dw_available based on the data loaded
// in istr_sub_opt.patt_struc.table_type
This.Event	ue_retrieve_dw_available()

// Close the file and reset globals previous set by w_subset_use
IF	ab_close_file	=	TRUE		THEN
	is_inv_type					=	is_import_inv_type
	gc_active_subset_id		=	is_orig_subset_id
	gc_active_subset_name	=	is_orig_subset_name
	FileClose (al_file_number)
END IF

// Retrieve the data for the column_description (dw_criteria) drop-down
This.Event	ue_init_criteria_dddw()

// Reset import mode
ib_import		=	FALSE



end event

event ue_import_file_hdr;//*********************************************************************************
// Script Name:	ue_import_file_hdr
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event will process the file header record.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_record_type

ib_file_hdr_read	=	TRUE

ls_record_type	=	Mid (as_record, 34, 7)

IF	Upper (ls_record_type)	<>	'PATTERN'		THEN
	MessageBox ('Import Error', 'This file cannot be imported into a pattern.')
	Return	-1
END IF

Return	1

end event

event ue_import_pattern_hdr;//*********************************************************************************
// Script Name:	ue_import_pattern_hdr
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event will process the pattern header record.  Table
//						patt_cntl will be created from this
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/12/01	GaryR	Stars 4.7	DataBase Port - Empty String in SQL
//
//*********************************************************************************

String	ls_record_type,	&
			ls_sql,				&
			ls_desc,				&
			ls_base_plus,		&
			ls_empty

Long		ll_row,				&
			ll_count					//	01/12/01	GaryR	Stars 4.7	DataBase Port

Integer	li_rc

u_nvo_count		lnv_count

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

IF	ib_file_hdr_read	=	FALSE		THEN
	MessageBox ('Import Error', 'This file is either not a pattern file or it has been corrupted.')
	Return	-1
END IF

ll_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.InsertRow(0)
tab_patt.tabpage_criteria.dw_patt_cntl.ScrollToRow (ll_row)

// Edit the pattern ID.  The exported pattern ID is always the pattern template ID.

is_pattern_id	=	Trim (Mid (as_record, 3, 10) )

lnv_count		=	CREATE	u_nvo_count

ls_sql			=	"Select count(*) from patt_cntl where patt_id = '"		+	&
						Upper( is_pattern_id )	+	"'"

ll_count			=	lnv_count.uf_get_count (ls_sql)

Destroy	lnv_count

IF	ll_count		<	1		THEN
	// Pattern does not exist
	MessageBox ('Import Error', 'Pattern ID '	+	is_pattern_id	+	' does not exist.')
	is_pattern_id	=	''
	Return	-1
END IF

//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin		// FDG 04/16/01
ls_desc			=	Trim (Mid (as_record, 49, 255) )
ls_base_plus 	=	Trim (Mid (as_record, 17, 1) )

IF ls_desc			= "" THEN ls_desc			= ls_empty
IF ls_base_plus	= "" THEN ls_base_plus	= ls_empty
//	01/12/01	GaryR	Stars 4.7	DataBase Port - End

tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_id [ll_row]			=	is_pattern_id
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_inv_type [ll_row]	=	ls_empty	//	01/12/01	GaryR	Stars 4.7	DataBase Port
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_row]		=	ls_desc
tab_patt.tabpage_criteria.dw_patt_cntl.object.base_plus [ll_row]		=	ls_base_plus	//	01/12/01	GaryR	Stars 4.7	DataBase Port
tab_patt.tabpage_criteria.dw_patt_cntl.object.exe_ind [ll_row]			=	Trim (Mid (as_record, 19, 1) )
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_type [ll_row]		=	ics_user_pattern
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_cond [ll_row]		=	Trim (Mid (as_record, 23, 25) )

Return	1

end event

event ue_import_pattern_tables;//*********************************************************************************
// Script Name:	ue_import_pattern_tables
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event will process the pattern tables record.  This script
//						will fill ids_summary so that window w_import_pattern_summary
//						can be opened.  This window is opened in ue_import_tables_trailer.
//
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

String	ls_base_type,		&
			ls_filter,			&
			ls_rel_type,		&
			ls_inv_type,		&
			ls_msg,				&
			ls_description

Long		ll_row,				&
			ll_rowcount

u_nvo_count		lnv_count

IF	ib_file_hdr_read	=	FALSE		THEN
	MessageBox ('Import Error', 'This file is either not a pattern file or it has been corrupted.')
	Return	-1
END IF

ls_rel_type		=	Mid (as_record, 69, 2)
ls_base_type	=	Trim ( Mid(as_record, 7, 30) )

ll_row	=	ids_summary.InsertRow(0)
ids_summary.SetRow (ll_row)

ids_summary.object.sequence_num [ll_row]	=	Integer ( Mid(as_record, 3, 3) )
ids_summary.object.base_type [ll_row]		=	ls_base_type
ids_summary.object.inv_type [ll_row]		=	''
ids_summary.object.inv_type_desc [ll_row]	=	Trim ( Mid(as_record, 38, 30) )
ids_summary.object.rel_type [ll_row]		=	ls_rel_type

Return	1

end event

event type integer ue_import_pattern_options(string as_record);//*********************************************************************************
// Script Name:	ue_import_pattern_options
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event will process the pattern options record.  Table
//						patt_options will be created from this
//
//	Notes:			All errors in the timeframe columns will be reflected
//						in ids_errors.  As a result, when these error occurs,
//						return 1.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/12/01	GaryR	Stars 4.7	DataBase Port - Empty String in SQL
//  04/14/09  RickB  SPR 5633 - Section 508 - Added "ERROR:" to front of error message.
//
//*********************************************************************************

Integer	li_sequence,		&
			li_rc,				&
			li_idx,				&
			li_upper

String	ls_record_type,	&
			ls_sql,				&
			ls_find

Long		ll_row,				&
			ll_rowcount,		&
			ll_find_row,		&
			ll_summ_row,		&
			ll_error_row

String	ls_subc_tables,	&
			ls_tbl_type,		&
			ls_col_name

//	01/12/01	GaryR	Stars 4.7	DataBase Port			
String	ls_claim_ind,				&
			ls_day_ind,					&
			ls_patient_ind,			&
			ls_tooth_ind,				&
			ls_combination_ind,		&
			ls_allwd_srvc_ind,		&
			ls_timeframe_from_thru,	&
			ls_timeframe_field_1,	&
			ls_timeframe_field_2,	&
			ls_empty

IF	ib_file_hdr_read	=	FALSE		THEN
	MessageBox ('Import Error', 'This file is either not a pattern file or it has been corrupted.')
	Return	-1
END IF

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ll_row	=	tab_patt.tabpage_options.dw_patt_options.InsertRow(0)
tab_patt.tabpage_options.dw_patt_options.ScrollToRow (ll_row)

tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_row]	=	is_pattern_id

// Compute subc_tables (i.e. C1+C2 - not CR) from istr_sub_opt.patt_struc.table_type[].
// This array is set in the tables trailer record.

li_upper		=	UpperBound (istr_sub_opt.patt_struc.table_type)

FOR	li_idx	=	1	TO	li_upper
	ls_subc_tables	=	ls_subc_tables	+	'+'	+	istr_sub_opt.patt_struc.table_type [li_idx]
NEXT

// Remove the leading '+'
ls_subc_tables	=	Mid (ls_subc_tables, 2)

//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin		// FDG 04/16/01
ls_claim_ind				=	Trim (Mid (as_record, 40, 1) )
ls_day_ind					=	Trim (Mid (as_record, 42, 1) )
ls_patient_ind				=	Trim (Mid (as_record, 44, 1) )
ls_tooth_ind				=	Trim (Mid (as_record, 46, 1) )
ls_combination_ind		=	Trim (Mid (as_record, 48, 1) )
ls_allwd_srvc_ind			=	Trim (Mid (as_record, 50, 1) )
ls_timeframe_from_thru	=	Trim (Mid (as_record, 52, 1) )

IF ls_claim_ind				= "" THEN ls_claim_ind				= ls_empty
IF ls_day_ind 					= "" THEN ls_day_ind					= ls_empty
IF ls_patient_ind				= "" THEN ls_patient_ind			= ls_empty
IF ls_tooth_ind				= "" THEN ls_tooth_ind				= ls_empty
IF ls_combination_ind		= "" THEN ls_combination_ind		= ls_empty
IF ls_allwd_srvc_ind			= "" THEN ls_allwd_srvc_ind		= ls_empty
IF ls_timeframe_from_thru	= "" THEN ls_timeframe_from_thru	= ls_empty

tab_patt.tabpage_options.dw_patt_options.object.subc_tables [ll_row]				=	ls_subc_tables
tab_patt.tabpage_options.dw_patt_options.object.claim_ind [ll_row]				=	ls_claim_ind
tab_patt.tabpage_options.dw_patt_options.object.day_ind [ll_row]					=	ls_day_ind
tab_patt.tabpage_options.dw_patt_options.object.patient_ind [ll_row]				=	ls_patient_ind
tab_patt.tabpage_options.dw_patt_options.object.tooth_ind [ll_row]				=	ls_tooth_ind
tab_patt.tabpage_options.dw_patt_options.object.combination_ind [ll_row]		=	ls_combination_ind
tab_patt.tabpage_options.dw_patt_options.object.allwd_srvc_ind [ll_row]			=	ls_allwd_srvc_ind
tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_row]	=	ls_timeframe_from_thru
//	01/12/01	GaryR	Stars 4.7	DataBase Port - End

tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_row]		=	Integer(Trim(Mid(as_record,54,2)))

// Use the imported sequence numbers to determine the table types (within ids_summary)

// Compute timeframe_tbl_type_1
li_sequence		=	Integer(Trim(Mid(as_record,60,3)))

IF	li_sequence	>	0		THEN
	ls_find			=	"sequence_num = "		+	String (li_sequence)
	ll_find_row		=	ids_summary.Find (ls_find, 1, ids_summary.Rowcount() )
	IF	ll_find_row	<	1		THEN
		MessageBox ('Import Error', 'Cannot find the table type for timeframe column 1.  Import is cancelled.')
		Return	-1
	END IF
	ls_tbl_type		=	ids_summary.object.tbl_type [ll_find_row]
	ls_col_name		=	Trim (Mid (as_record, 64, 30) )
	
	//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin		// FDG 04/16/01
	IF Trim( ls_tbl_type )	= "" THEN ls_tbl_type = ls_empty
	IF 	ls_col_name			= "" THEN ls_col_name = ls_empty
	//	01/12/01	GaryR	Stars 4.7	DataBase Port - End
	
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]	=	ls_tbl_type
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]	=	ls_col_name
	// Edit the table type and column against dictionary
	li_rc	=	inv_pattern_sql.uf_edit_column (ls_tbl_type, ls_col_name)
	IF	li_rc	<	0		THEN
		// Timeframe column does not exist
		ll_error_row	=	ids_errors.InsertRow(0)
		ids_errors.object.level_num [ll_error_row]		=	1
		ids_errors.object.seq_num [ll_error_row]			=	1
		ids_errors.object.data_type [ll_error_row]		=	'Timeframe'
		ids_errors.object.error_ind [ll_error_row]		=	'Y'
		ids_errors.object.column_desc [ll_error_row]		=	Trim (Mid (as_record, 396, 30) )
		ids_errors.object.error_text [ll_error_row]		=	'ERROR: Column not found in dictionary for table type '	+	&
																			ls_tbl_type		+	'.'
	END IF
ELSE
	//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin		// FDG 04/16/01
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]	=	ls_empty
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]	=	ls_empty
	//	01/12/01	GaryR	Stars 4.7	DataBase Port - End
END IF

// Compute timeframe_tbl_type_2
li_sequence		=	Integer(Trim(Mid(as_record,98,3)))

IF	li_sequence	>	0		THEN
	ls_find			=	"sequence_num = "		+	String (li_sequence)
	ll_find_row		=	ids_summary.Find (ls_find, 1, ids_summary.Rowcount() )
	IF	ll_find_row	<	1		THEN
		MessageBox ('Import Error', 'Cannot find the table type for timeframe column 2.  Import is cancelled.')
		Return	-1
	END IF
	ls_tbl_type		=	ids_summary.object.tbl_type [ll_find_row]
	ls_col_name		=	Trim (Mid (as_record, 102, 30) )
	
	//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin		// FDG 04/16/01
	IF Trim( ls_tbl_type )	= "" THEN ls_tbl_type = ls_empty
	IF 	ls_col_name			= "" THEN ls_col_name = ls_empty
	//	01/12/01	GaryR	Stars 4.7	DataBase Port - End
	
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]	=	ls_tbl_type
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]	=	ls_col_name
	// Edit the table type and column against dictionary
	li_rc	=	inv_pattern_sql.uf_edit_column (ls_tbl_type, ls_col_name)
	IF	li_rc	<	0		THEN
		// Timeframe column does not exist
		ll_error_row	=	ids_errors.InsertRow(0)
		ids_errors.object.level_num [ll_error_row]		=	1
		ids_errors.object.seq_num [ll_error_row]			=	1
		ids_errors.object.data_type [ll_error_row]		=	'Timeframe'
		ids_errors.object.error_ind [ll_error_row]		=	'Y'
		ids_errors.object.column_desc [ll_error_row]		=	Trim (Mid (as_record, 427, 30) )
		ids_errors.object.error_text [ll_error_row]		=	'ERROR: Column not found in dictionary for table type '	+	&
																			ls_tbl_type		+	'.'
	END IF
ELSE
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]	=	' '
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]	=	' '
	tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]		=	' '
END IF

//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin
ls_timeframe_field_1 = Trim (Mid (as_record, 396, 30) )
ls_timeframe_field_2 = Trim (Mid (as_record, 427, 30) )

IF ls_timeframe_field_1 = "" THEN ls_timeframe_field_1 = ls_empty
IF ls_timeframe_field_2 = "" THEN ls_timeframe_field_2 = ls_empty
//	01/12/01	GaryR	Stars 4.7	DataBase Port - End

tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row]		=	ls_timeframe_field_1
tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]		=	ls_timeframe_field_2
tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]	=	Integer(Trim(Mid(as_record,133,6)))
tab_patt.tabpage_options.dw_patt_options.object.rpt_title [ll_row]				=	Trim (Mid (as_record, 140, 255) )


Return	1

end event

event type integer ue_import_pattern_criteria(string as_record);//*********************************************************************************
// Script Name:	ue_import_pattern_criteria
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered mutiple times and will process the 
//						pattern criteria record.  Table patt_criteria will be created 
//						from this record.
//
//	Notes:			All errors in criteria and columns records will be reflected
//						in ids_errors.  As a result, when an error occurs in this script,
//						return 1.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/12/01	GaryR	Stars 4.7	DataBase Port - Empty String in SQL
//  04/14/09  RickB  SPR 5633 - Section 508 - Formatted error message to match PDQ import errors.
// 11/13/09 RickB LKP.650.5678.001 Defect #162 - Expanded ls_value to 255 and adjusted all 
//						subsequent fields in as_record to the right starting point.
//
//*********************************************************************************

Integer	li_sequence,		&
			li_rc

String	ls_find

Long		ll_row,				&
			ll_rowcount,		&
			ll_find_row,		&
			ll_error_row

String	ls_tbl_type,		&
			ls_col_name,		&
			ls_col_desc,		&
			ls_operand,			&
			ls_value,			&
			ls_where,			&
			ls_empty
			
String	ls_field_type,		&
			ls_field_name,		&
			ls_and_field,		&
			ls_field_lookup,	&
			ls_field_alone,	&
			ls_field_also			

IF	ib_file_hdr_read	=	FALSE		THEN
	MessageBox ('Import Error', 'This file is either not a pattern file or it has been corrupted.')
	Return	-1
END IF

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

li_sequence	=	Integer(Trim(Mid(as_record,3,3)))

ll_row	=	tab_patt.tabpage_criteria.dw_criteria.InsertRow(0)
tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
ls_tbl_type	=	Trim (Mid (as_record, 7, 2) )
ls_col_name	=	Trim (Mid (as_record, 10, 30) )
ls_col_desc	=	Trim (Mid (as_record, 379, 50) )
ls_operand	=	Trim (Mid (as_record, 297, 10) )
ls_value		=	Trim (Mid (as_record, 41, 255) )

//	01/12/01	GaryR	Stars 4.7	DataBase Port - Begin		// FDG 04/16/01
ls_field_type		=	Trim (Mid (as_record, 308, 20) )
ls_field_name		=	Trim (Mid (as_record, 329, 10) )
ls_and_field		=	Trim (Mid (as_record, 340, 2) )
ls_field_lookup	=	Trim (Mid (as_record, 354, 2) )
ls_field_alone		=	Trim (Mid (as_record, 357, 10) )
ls_field_also		=	Trim (Mid (as_record, 368, 10) )

IF ls_col_desc			= "" THEN ls_col_desc = ls_empty
IF ls_tbl_type			= "" THEN ls_tbl_type = ls_empty
IF ls_col_name			= "" THEN ls_col_name = ls_empty
IF ls_value				= "" THEN ls_value = ls_empty
IF ls_tbl_type			= "" THEN ls_tbl_type = ls_empty
IF ls_field_type		= "" THEN ls_field_type = ls_empty
IF ls_field_name		= "" THEN ls_field_name = ls_empty
IF ls_and_field		= "" THEN ls_and_field = ls_empty
IF ls_field_lookup	= "" THEN ls_field_lookup = ls_empty
IF ls_field_alone		= "" THEN ls_field_alone = ls_empty
IF ls_field_also		= "" THEN ls_field_also = ls_empty

IF	li_sequence	=	0		THEN
	// An empty row of criteria exists (usually the last row)
	ls_where		=	''
ELSE
	ls_where		=	ls_tbl_type	+	'.'	+	ls_col_desc	+	' '	+	&
						ls_operand	+	' '	+	ls_value
END IF

tab_patt.tabpage_criteria.dw_criteria.object.seq_num [ll_row]					=	ll_row
tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_row]		=	ls_col_desc
tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]			=	ls_col_name
tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]			=	ls_tbl_type
tab_patt.tabpage_criteria.dw_criteria.object.field_value [ll_row]				=	ls_value
tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_row]			=	ls_operand
tab_patt.tabpage_criteria.dw_criteria.object.field_type [ll_row]				=	ls_field_type
tab_patt.tabpage_criteria.dw_criteria.object.field_name [ll_row]				=	ls_field_name
tab_patt.tabpage_criteria.dw_criteria.object.and_field [ll_row]				=	ls_and_field
tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]				=	Trim (Mid (as_record, 343, 10) )
tab_patt.tabpage_criteria.dw_criteria.object.field_lookup [ll_row]			=	ls_field_lookup
tab_patt.tabpage_criteria.dw_criteria.object.field_alone [ll_row]				=	ls_field_alone
tab_patt.tabpage_criteria.dw_criteria.object.field_also [ll_row]				=	ls_field_also
// Always protect column_description by setting protect_ind = 'Y'.  
//	If this requirement is ever changed, use 'Trim (Mid (as_record, 275, 1) )'
tab_patt.tabpage_criteria.dw_criteria.object.protect_ind [ll_row]				=	'Y'
tab_patt.tabpage_criteria.dw_criteria.object.protect_operand_ind [ll_row]	=	Trim (Mid (as_record, 432, 1) )
//	01/12/01	GaryR	Stars 4.7	DataBase Port - End

ll_rowcount		=	ids_summary.Rowcount()

// All criteria will be added to ids_errors.  error_ind will specify
//	whether or not the criteria is in error.

IF	li_sequence	>	0		THEN
	// This row of criteria has data
	ll_error_row	=	ids_errors.InsertRow(0)
	ids_errors.object.level_num [ll_error_row]		=	1
	ids_errors.object.seq_num [ll_error_row]			=	ll_error_row
	ids_errors.object.data_type [ll_error_row]		=	'Criteria'
	ids_errors.object.error_ind [ll_error_row]		=	'N'
	ids_errors.object.column_desc [ll_error_row]		=	ls_col_desc
	ids_errors.object.error_text [ll_error_row]		=	ls_where
	// Get the table type from ids_summary.
	ls_find			=	"sequence_num = "		+	String (li_sequence)
	ll_find_row		=	ids_summary.Find (ls_find, 1, ids_summary.Rowcount() )
	IF	ll_find_row	<	1		THEN
		ids_errors.object.error_ind [ll_error_row]		=	'Y'
		ids_errors.object.error_text [ll_error_row]		=	ls_where	+	'.  ERROR: Column for table type '	+	&
																			ls_tbl_type		+	' was not found.'
		Return	1
	END IF
	ls_tbl_type		=	ids_summary.object.tbl_type [ll_find_row]
	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]			=	ls_tbl_type
	tab_patt.tabpage_criteria.dw_criteria.object.column_description [ll_row]	=	ls_tbl_type	+	'.'	+	&
																											ls_col_desc
	// Reset the table type in the where clause
	ls_where		=	ls_tbl_type	+	'.'	+	ls_col_desc	+	' '	+	&
						ls_operand	+	' '	+	ls_value
	ids_errors.object.error_text [ll_error_row]			=	ls_where
	// Edit the table type and column against dictionary
	li_rc	=	inv_pattern_sql.uf_edit_column (ls_tbl_type, ls_col_name)
	IF	li_rc	<	0		THEN
		// Pattern column does not exist
		ids_errors.object.error_ind [ll_error_row]		=	'Y'
		ids_errors.object.error_text [ll_error_row]		=	ls_where	+	'.  ERROR: Column for table type '	+	&
																			ls_tbl_type		+	' was not found.'
		Return	1
	END IF
END IF												// li_sequence	>	0

Return	1

end event

event type integer ue_import_pattern_columns(string as_record);//*********************************************************************************
// Script Name:	ue_import_pattern_columns
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered mutiple times and will process the 
//						pattern column record.  Table patt_columns will be created 
//						from this record.
//
//	Notes:			All errors in criteria and columns records will be reflected
//						in ids_errors.  As a result, when an error occurs in this script,
//						return 1.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//  04/14/09  RickB  SPR 5633 - Section 508 - Added "ERROR:" to front of error message.
//
//*********************************************************************************

Integer	li_sequence,		&
			li_rc

String	ls_find

Long		ll_row,				&
			ll_rowcount,		&
			ll_find_row,		&
			ll_error_row

String	ls_tbl_type,		&
			ls_col_name,		&
			ls_col_desc,		&
			ls_col_type

IF	ib_file_hdr_read	=	FALSE		THEN
	MessageBox ('Import Error', 'This file is either not a pattern file or it has been corrupted.')
	Return	-1
END IF

li_sequence	=	Integer(Trim(Mid(as_record,3,3)))
ls_col_name	=	Trim (Mid (as_record, 11, 30) )
ls_col_desc	=	Trim (Mid (as_record, 42, 30) )
ls_col_type	=	Trim (Mid (as_record, 7, 3) )

IF	li_sequence	=	0		THEN
	// This column has no data.  get out
	Return	1
END IF

ll_rowcount		=	ids_summary.Rowcount()

// This column has data.  Get the table type from ids_summary.
ls_find			=	"sequence_num = "		+	String (li_sequence)
ll_find_row		=	ids_summary.Find (ls_find, 1, ids_summary.Rowcount() )

IF	ll_find_row	<	1		THEN
	// Sequence # mismatch.
	ll_error_row	=	ids_errors.InsertRow(0)
	ids_errors.object.level_num [ll_error_row]		=	1
	ids_errors.object.seq_num [ll_error_row]			=	ll_error_row
	ids_errors.object.data_type [ll_error_row]		=	'Column'
	ids_errors.object.column_desc [ll_error_row]		=	ls_col_desc
	ids_errors.object.error_ind [ll_error_row]		=	'Y'
	ids_errors.object.error_text [ll_error_row]		=	'ERROR: Column not found in dictionary for table type '	+	&
																		ls_tbl_type		+	'.'
	Return	1
END IF

ls_tbl_type		=	ids_summary.object.tbl_type [ll_find_row]

// Edit the table type and column against dictionary
li_rc	=	inv_pattern_sql.uf_edit_column (ls_tbl_type, ls_col_name)

IF	li_rc	<	0		THEN
	// Pattern column does not exist
	ll_error_row	=	ids_errors.InsertRow(0)
	ids_errors.object.level_num [ll_error_row]		=	1
	ids_errors.object.seq_num [ll_error_row]			=	ll_error_row
	ids_errors.object.data_type [ll_error_row]		=	'Column'
	ids_errors.object.column_desc [ll_error_row]		=	ls_col_desc
	ids_errors.object.error_ind [ll_error_row]		=	'Y'
	ids_errors.object.error_text [ll_error_row]		=	'ERROR: Column not found in dictionary for table type '	+	&
																		ls_tbl_type		+	'.'
	Return	1
END IF									//	li_rc	<	0

ll_row	=	ids_patt_columns.InsertRow(0)
ids_patt_columns.SetRow (ll_row)

ids_patt_columns.object.seq_num [ll_row]			=	ll_row
ids_patt_columns.object.col_type [ll_row]			=	ls_col_type
ids_patt_columns.object.col_name [ll_row]			=	ls_col_name
ids_patt_columns.object.tbl_type [ll_row]			=	ls_tbl_type

Return	1

end event

event ue_import_tables_trailer;//*********************************************************************************
// Script Name:	ue_import_tables_trailer
//
//	Arguments:		1.	as_record - Record layout
//						2.	as_comment - Comment from the file header record.
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event will process the pattern tables trailer record.  
//						This script will pass ids_summary to window w_import_pattern_summary
//						so that the invoice types and subset ID can be entered.
//
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_rowcount,		&
			ll_row,				&
			ll_count,			&
			ll_idx

String	ls_patt_id,			&
			ls_patt_desc,		&
			ls_empty[],			&
			ls_rel_type,		&
			ls_inv_type,		&
			ls_inv_type_desc,	&
			ls_tbl_type

sx_import_pattern_summary	lstr_summary

lstr_summary.s_comment						=	as_comment
lstr_summary.s_subset_id					=	''
lstr_summary.ds_import						=	CREATE	n_ds
lstr_summary.ds_import.DataObject		=	'd_import_pattern_summary'
lstr_summary.ds_import.object.data		=	ids_summary.object.data

ll_rowcount		=	ids_summary.RowCount()
FOR	ll_row	=	1	TO	ll_rowcount
	ls_inv_type			=	ids_summary.object.inv_type [ll_row]
	ls_inv_type_desc	=	ids_summary.object.inv_type_desc [ll_row]
NEXT

OpenWithParm (w_import_pattern_summary, lstr_summary)

lstr_summary	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

IF	Upper (lstr_summary.s_subset_id)		=	'CANCEL'		THEN
	MessageBox ('Import', 'Import has been cancelled.')
	Return	-1
END IF

ids_summary.object.data	=	lstr_summary.ds_import.object.data
is_import_subset_id		=	lstr_summary.s_subset_id

// Update the invoice type on patt_cntl

ll_rowcount		=	ids_summary.RowCount()

IF	ll_rowcount	<	1		THEN
	MessageBox ('Import Error', 'Import has been cancelled because the imported pattern has no table types.')
	Return	-1
END IF

// Get the # of main tables
FOR	ll_row	=	1	TO	ll_rowcount
	ls_rel_type	=	ids_summary.object.rel_type [ll_row]
	IF	ls_rel_type		=	'GP'		THEN
		ll_count	++
		ls_tbl_type	=	ids_summary.object.tbl_type [ll_row]
	END IF
NEXT

IF	ll_count	>	1		THEN
	is_inv_type		=	'ML'
	ls_tbl_type		=	is_inv_type
ELSE
	is_inv_type		=	ls_tbl_type
END IF

// Get Pattern description
ll_row			=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()
ls_patt_desc	=	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_row]

// If the pattern ID is generic or Filter, change the tbl_type to 'ML'.
IF	is_pattern_id	=	ics_generic			&
OR	is_pattern_id	=	ics_filter_pat		THEN
	ls_tbl_type	=	'ML'
END IF

// Retrieve the pattern template from patt_cntl
ll_rowcount		=	tab_patt.tabpage_criteria.dw_patt_cntl.Retrieve (is_pattern_id, ls_tbl_type)

IF	ll_rowcount	<	1		THEN
	MessageBox ('Import Error', 'Pattern ID '	+	is_pattern_id	+	&
					' does not exist for table type '	+	is_inv_type	+	&
					'.  Import is cancelled.')
	Return	-1
END IF

tab_patt.tabpage_criteria.dw_patt_cntl.ScrollToRow (ll_rowcount)
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_row]		=	ls_patt_desc

// Set istr_sub_opt.patt_struc.table_type[] from ids_summary and retrieve the available columns from
//	dictionary.  Subsequent import records will edit against these columns.

istr_sub_opt.patt_struc.table_type	=	ls_empty
ll_rowcount									=	ids_summary.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_rel_type	=	ids_summary.object.rel_type [ll_row]
	IF	ls_rel_type	<>	'DP'		THEN
		// Main table, move it.
		ll_idx	++
		istr_sub_opt.patt_struc.table_type [ll_idx]	=	ids_summary.object.tbl_type [ll_row]
	END IF
NEXT

// Get the new available list of columns in the Criteria tab and in the Customize
//	Report tab
This.Event	ue_retrieve_dw_available()

// Retrieve the data for the column_description (dw_criteria) drop-down
This.Event	ue_init_criteria_dddw()

ll_rowcount									=	ids_summary.RowCount()		// Remove.  Its useless here


Return	1

end event

event ue_custom_load_title;//*********************************************************************************
// Script Name:	ue_custom_load_title
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a user-defined pattern is selected 
//						and when a pattern is imported.  This script will set
//						the report's title based on the data in dw_patt_options.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,				&
			ll_opt_row

String	ls_title

tab_patt.tabpage_custom.dw_title.Reset()

ll_row		=	tab_patt.tabpage_custom.dw_title.InsertRow(0)
tab_patt.tabpage_custom.dw_title.ScrollToRow (ll_row)

ll_opt_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

ls_title		=	tab_patt.tabpage_options.dw_patt_options.object.rpt_title [ll_opt_row]

tab_patt.tabpage_custom.dw_title.object.rpt_title [1]	=	ls_title



end event

event ue_export_pattern_notes;//*********************************************************************************
// Script Name:	ue_export_pattern_notes
//
//	Arguments:		ai_file_number - The file number for the exported file.
//
// Returns:			String
//						''			=	Success
//						'ERROR'	=	Error
//
//	Description:	Create the record layout for the Pattern notes record.
//						All notes for this pattern are retrieved and added to the export 
//						file.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

n_cst_string		lnv_string			// Autoinstantiated

Constant	String	lcs_delimiter	=	'^'

DateTime		ldtm_note_datetime

Integer		li_rc

Long			ll_row,					&
				ll_rowcount

String		ls_record,				&
				ls_dept_id,				&
				ls_user_id,				&
				ls_note_rel_type,		&
				ls_note_sub_type,		&
				ls_note_rel_id,		&
				ls_note_id,				&
				ls_note_text,			&
				ls_note_datetime,		&
				ls_rte_ind

// Reset any previously read/imported notes
This.Event	ue_notes_clear()

// Read notes (ids_notes) to get the notes for this pattern
This.Event	ue_retrieve_notes()

ll_rowcount		=	ids_notes.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_dept_id				=	Trim (ids_notes.object.dept_id [ll_row])
	ls_user_id				=	Trim (ids_notes.object.user_id [ll_row])
	ls_note_rel_type		=	Trim (ids_notes.object.note_rel_type [ll_row])
	ls_note_sub_type		=	Trim (ids_notes.object.note_sub_type [ll_row])
	ls_note_rel_id			=	Trim (ids_notes.object.note_rel_id [ll_row])
	ls_note_id				=	Trim (ids_notes.object.note_id [ll_row])
	ldtm_note_datetime	=	ids_notes.object.note_datetime [ll_row]
	ls_rte_ind				=	Trim (ids_notes.object.rte_ind [ll_row])
	
	// Get the note_text into is_note_text[]
	This.Event	ue_notes_text(ll_row)
	
	ls_dept_id				=	lnv_string.of_PadRight (ls_dept_id, 10)
	ls_user_id				=	lnv_string.of_PadRight (ls_user_id, 8)
	ls_note_rel_type		=	lnv_string.of_PadRight (ls_note_rel_type, 2)
	ls_note_sub_type		=	lnv_string.of_PadRight (ls_note_sub_type, 2)
	ls_note_rel_id			=	lnv_string.of_PadRight (ls_note_rel_id, 10)
	ls_note_id				=	lnv_string.of_PadRight (ls_note_id, 10)
	ls_note_datetime		=	lnv_string.of_PadRight (String (ldtm_note_datetime, 'mm/dd/yyyy'), 10)
	ls_rte_ind				=	lnv_string.of_PadRight (ls_rte_ind, 1)

	// Since note text varies in length, place it at the end and do NOT
	//	place a delimiter at the end.
	ls_record				=	'J'					+	lcs_delimiter	+	&
									ls_dept_id			+	lcs_delimiter	+	&
									ls_user_id			+	lcs_delimiter	+	&
									ls_note_rel_type	+	lcs_delimiter	+	&
									ls_note_sub_type	+	lcs_delimiter	+	&
									ls_note_rel_id		+	lcs_delimiter	+	&
									ls_note_id			+	lcs_delimiter	+	&
									ls_note_datetime	+	lcs_delimiter	+	&
									ls_rte_ind			+	lcs_delimiter	+	&
									is_note_text[ll_row]
	li_rc				=	FileWrite (ai_file_number, ls_record)
	IF	li_rc	<	0		THEN
		MessageBox ('Export Error', 'Error writing patterns notes record for the export file.  Export is cancelled.')
		Return	'ERROR'
	END IF
NEXT

// Write the Patterns Notes Trailer record - as long as one note was added.
IF	ll_rowcount	=	0		THEN
	Return	''
END IF

ls_record		=	'K'	+	' Pattern Notes Trailer Record'
li_rc				=	FileWrite (ai_file_number, ls_record)

IF	li_rc	<	0		THEN
	MessageBox ('Export Error', 'Error writing patterns notes trailer record for the export file.'	+	&
					'Export is cancelled.')
	Return	'ERROR'
END IF

Return	''

end event

event ue_import_pattern_notes;//*********************************************************************************
// Script Name:	ue_import_pattern_notes
//
//	Arguments:		as_record - Record layout
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered mutiple times and will process the 
//						pattern notes record.  Table notes will be created 
//						from this record.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,				&
			ll_rowcount

IF	ib_file_hdr_read	=	FALSE		THEN
	MessageBox ('Import Error', 'This file is either not a pattern file or it has been corrupted.')
	Return	-1
END IF

ll_row	=	ids_notes.InsertRow(0)
ids_notes.SetRow (ll_row)
ids_notes.object.dept_id [ll_row]			=	gc_user_dept
ids_notes.object.user_id [ll_row]			=	gc_user_id
ids_notes.object.note_rel_type [ll_row]	=	Trim (Mid (as_record, 23, 2) )
ids_notes.object.note_sub_type [ll_row]	=	Trim (Mid (as_record, 26, 2) )
ids_notes.object.note_rel_id [ll_row]		=	is_pattern_id
ids_notes.object.note_id [ll_row]			=	fx_get_next_key_id ('NOTE')
ids_notes.object.note_datetime [ll_row]	=	DateTime (Today())
ids_notes.object.rte_ind [ll_row]			=	Trim (Mid (as_record, 62, 1) )

is_note_text [ll_row]							=	Trim (Mid (as_record, 64) )

Return	1

end event

event ue_notes;//*********************************************************************************
// Script Name:	ue_notes
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is called to add/modify a pattern note.  If a note 
//						is being created for a user-defined pattern and this pattern
//						is linked to a case, then a case note must be added/modified.
//
//	Notes:			1.	Add a new note type ('PA') to Notes list and Notes Maintenance.
//						2.	Notes can be added for pattern templates and for user-defined
//							patterns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 10/15/01	FDG	Stars 4.8.1.  Fix GPF on lnv_notes.idt_notes_date.
//
//*********************************************************************************

SetPointer(HourGlass!)

Long		ll_row

Integer	li_rc

String	ls_case_id,				&
			ls_case_spl,			&
			ls_case_ver

n_cst_notes		lnv_notes						// Autoinstantiated

// Default to a pattern note
lnv_notes.is_notes_rel_type	=	'PA'
lnv_notes.idt_notes_date		=	Today()
lnv_notes.is_notes_rel_id		=	is_pattern_id		//	Pattern Template

// Determine if a patterns note or a case note.

IF	is_user_pattern_id	>	' '		THEN
	// User-defined pattern ID.  Get the case ID to determine if the
	// pattern is linked to a case.
	lnv_notes.is_notes_rel_id		=	is_user_pattern_id
	ll_row		=	ids_case_link.GetRow()
	ls_case_id	=	ids_case_link.object.case_id [ll_row]
	ls_case_spl	=	ids_case_link.object.case_spl [ll_row]
	ls_case_ver	=	ids_case_link.object.case_ver [ll_row]
	IF	 ls_case_id	<>	''				&
	AND ls_case_id	<>	'NONE'		THEN
		// Pattern is linked to a case.  Create a case note instead of a pattern note.
		li_rc = MessageBox ('NOTES', 'Note will be attached to the case, not the pattern.'	+	&
									'~rDo you want to view or add case notes?', Exclamation!, YesNo!)
		IF li_rc = 2	THEN
			Return
		END IF
		lnv_notes.is_notes_rel_type	=	'CA'			// Case note
		lnv_notes.is_notes_rel_id		=	ls_case_id	+	ls_case_spl	+	ls_case_ver
		// FDG 10/15/01 - fix GPF
		//lnv_notes.idt_notes_date		=	ids_case_link.object.link_date [ll_row]
		lnv_notes.idt_notes_date		=	Date ( ids_case_link.object.link_date [ll_row] )
		// FDG 10/15/01 end
	END IF
END IF

gv_from						=	'A'
lnv_notes.is_notes_from	=	'PA'

OpenSheetWithParm (w_notes_list, lnv_notes, mdi_main_frame, help_menu_position, Layered!)


end event

event ue_edit_field_value;//*********************************************************************************
// Script Name:	ue_edit_field_value
//
//	Arguments:		1.	al_row - Current row # in dw_criteria
//						2. as_data - The data desired to be changed.
//
// Returns:			Integer.
//						-1	=	Error
//						 1	=	Successful
//
//	Description:	This event is triggered from the itemchanged event of dw_criteria.
//						This event will edit field_value.  If the column is comparing
//						a value against itself, then the pattern must be Generic.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

String	ls_field_value,		&
			ls_field_operator,	&
			ls_col_name

ls_col_name			=	Upper (tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [al_row])
ls_field_value		=	tab_patt.tabpage_criteria.dw_criteria.object.field_value [al_row]
ls_field_operator	=	tab_patt.tabpage_criteria.dw_criteria.object.field_operator [al_row]

IF	as_data	=	ics_same_column		THEN
	IF	is_pattern_id	<>	ics_generic	THEN
		// Cannot compare a column's value against itself for a
		// numbered pattern.
		MessageBox ("Edit Error", "You cannot compare a column's value against itself "	+	&
						"for a non-generic pattern.", StopSign!)
		// Reset field_value back to its original value
		tab_patt.tabpage_criteria.dw_criteria.SetText (ls_field_value)
		Return	-1
	END IF
	CHOOSE CASE	ls_field_operator
		CASE	'',	'=',	'<>',	'>',	'<'
			// Valid value
		CASE	ELSE
			// The operator can only be certain values when comparing a value against itself
			MessageBox ("Edit Error", "When comparing a column's value against itself, "	+	&
							"the operator must be '=', '<>', '>' or '<'.", StopSign!)
			// Reset field_value back to its original value
			tab_patt.tabpage_criteria.dw_criteria.SetText (ls_field_value)
			Return	-1
	END CHOOSE
	IF	IsNull (ls_col_name)		&
	OR	ls_col_name		=	''		THEN
		// Must select a column first
		MessageBox ("Edit Error", "Please select a column before entering '"	+	&
						ics_same_column	+	"' in the value field.", StopSign!)
		// Reset field_value back to its original value
		tab_patt.tabpage_criteria.dw_criteria.SetText (ls_field_value)
		Return	-1
	END IF
	IF	ls_col_name		=	'ICN'		THEN
		// Cannot compare ICN against itself because of unique key issues.
		MessageBox ("Edit Error", "You cannot compare an ICN against itself.  "	+	&
						"Specify the Claim option on the Options tab.", StopSign!)
		// Reset field_value back to its original value
		tab_patt.tabpage_criteria.dw_criteria.SetText (ls_field_value)
		Return	-1
	END IF
END IF

Return	1


end event

event ue_edit_field_operator;//*********************************************************************************
// Script Name:	ue_edit_field_operator
//
//	Arguments:		1.	al_row - Current row # in dw_criteria
//						2. as_data - The data desired to be changed.
//
// Returns:			Integer.
//						-1	=	Error
//						 1	=	Successful
//
//	Description:	This event is triggered from the itemchanged event of dw_criteria.
//						This event will edit field_operator.  If the column is comparing
//						a value against itself, then the field_operator can only be
//						certain values.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

String	ls_field_value,		&
			ls_field_operator

ls_field_value		=	tab_patt.tabpage_criteria.dw_criteria.object.field_value [al_row]
ls_field_operator	=	tab_patt.tabpage_criteria.dw_criteria.object.field_operator [al_row]

IF	ls_field_value	=	ics_same_column		THEN
	CHOOSE CASE	as_data
		CASE	'',	'=',	'<>',	'>',	'<'
			// Valid value
		CASE	ELSE
			// The operator can only be certain values when comparing a value against itself
			MessageBox ("Edit Error", "When comparing a column's value against itself, "	+	&
							"the operator must be '=', '<>', '>' or '<'.", StopSign!)
			// Reset field_operator back to its original value
			tab_patt.tabpage_criteria.dw_criteria.SetText (ls_field_operator)
			Return	-1
	END CHOOSE
END IF

Return	1


end event

event ue_retrieve_notes();//*********************************************************************************
// Script Name:	ue_retrieve_notes
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Retrieve the notes for this pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	10/31/01	FDG	Stars 4.8.1.	Reverse order of retrieve to conform with rest
//						of system.  d_notes now exists in case.pbl.
//
//*********************************************************************************

Long			ll_rowcount,		&
				ll_row

String		ls_pattern_id

ll_rowcount		=	ids_notes.Rowcount()

IF	ll_rowcount	>	0		THEN
	// Pattern was just imported.  Use what was imported.
	Return
END IF

IF	Len (is_user_pattern_id)	>	0		THEN
	// User defined pattern
	ls_pattern_id	=	is_user_pattern_id
ELSE
	ls_pattern_id	=	is_pattern_id
END IF

// FDG 10/31/01
//ll_rowcount		=	ids_notes.Retrieve (ls_pattern_id, 'PA')
ll_rowcount		=	ids_notes.Retrieve ('PA', ls_pattern_id)

// Get the note text separately because this column is a text data type.

FOR	ll_row	=	1	TO	ll_rowcount
	This.Event	ue_notes_text (ll_row)
NEXT


end event

event ue_edit_display_notes;//*********************************************************************************
// Script Name:	ue_edit_display_notes
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Determine if the notes button is to be displayed by
//						seeing if any notes exist for this pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long			ll_rowcount

String		ls_pattern_id,			&
				ls_sql

u_nvo_count	lnv_count

lnv_count		=	CREATE	u_nvo_count

IF	Len (is_user_pattern_id)	>	0		THEN
	// User defined pattern
	ls_pattern_id	=	is_user_pattern_id
ELSE
	ls_pattern_id	=	is_pattern_id
END IF

ls_sql			=	"Select count(*) from notes where note_rel_type = 'PA' and "	+	&
						"note_rel_id = '"		+	Upper( ls_pattern_id )	+	"'"

ll_rowcount		=	lnv_count.uf_get_count (ls_sql)

IF	ll_rowcount	>	0		THEN
	tab_patt.tabpage_criteria.pb_notes.visible	=	TRUE
ELSE
	tab_patt.tabpage_criteria.pb_notes.visible	=	FALSE
END IF


end event

event type integer ue_notes_insert();//*********************************************************************************
// Script Name:	ue_notes_insert
//
//	Arguments:		al_row - Row # in ids_notes
//
// Returns:			None
//
//	Description:	Retrieve inserts a note from ids_notes.  Column notes_text
//						must be proceesed separately because the column is a 
//						text data type.  This is why embedded SQL is required to
//						insert a note.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/12/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 12/09/02 JasonS Track 3883d  add note description.
//*********************************************************************************

DateTime		ldtm_note_datetime

Long			ll_row,					&
				ll_rowcount

String		ls_user_id,				&
				ls_dept_id,				&
				ls_note_rel_type,		&
				ls_note_sub_type,		&
				ls_note_rel_id,		&
				ls_note_text,			&
				ls_note_id,				&
				ls_rte_ind,				&
				ls_empty

Integer		li_rc
string ls_note_desc 	// JasonS 12/9/02 Track 2883d
// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ll_rowcount	=	ids_notes.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_dept_id			=	ids_notes.object.dept_id [ll_row]
	ls_user_id			=	ids_notes.object.user_id [ll_row]
	ls_note_rel_type	=	ids_notes.object.note_rel_type [ll_row]
	ls_note_sub_type	=	ids_notes.object.note_sub_type [ll_row]
	ls_note_rel_id		=	ids_notes.object.note_rel_id [ll_row]
	ls_note_id			=	ids_notes.object.note_id [ll_row]
	ls_note_text		=	is_note_text [ll_row]
	ldtm_note_datetime =	ids_notes.object.note_datetime [ll_row]
	ls_rte_ind			=	ids_notes.object.rte_ind [ll_row]
	ls_note_desc 		=  ls_empty	// JasonS 12/9/02 Track 2883d
	//	01/12/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
	IF Trim( ls_note_rel_id ) = "" THEN ls_note_rel_id = ls_empty
	
	Insert into notes
			(dept_id, 
			user_id,
	 		note_rel_type,
			note_sub_type,
			note_rel_id,
			note_id,
			note_datetime,
			note_text,
			rte_ind,
			note_desc)		// JasonS 12/9/02 Track 2883d
	Values (:ls_dept_id,
			:ls_user_id,
	 		:ls_note_rel_type,
			:ls_note_sub_type,
			:ls_note_rel_id,
			:ls_note_id,
			:ldtm_note_datetime,
			:ls_note_text,
			:ls_rte_ind,
			:ls_note_desc)	// JasonS 12/9/02 Track 2883d
	Using stars2ca;
	IF	Stars2ca.of_check_status()	<	0		THEN
		Return	-1
	END IF
NEXT


Return	1



end event

event ue_notes_clear;//*********************************************************************************
// Script Name:	ue_notes_clear
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will clear the existing notes.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_empty[]

ids_notes.Reset()

is_note_text	=	ls_empty


end event

event ue_notes_text(long al_row);//*********************************************************************************
// Script Name:	ue_notes_text
//
//	Arguments:		al_row - Row # in ids_notes
//
// Returns:			None
//
//	Description:	Retrieve column notes_text for this note.  This column
//						must be retrieved separately because the column is a 
//						text data type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/13/00	FDG	Stars 4.7.  Make the retrieval of note_text DBMS-independent.
//	09/17/02	GaryR	SPR 4182c	Pass three unique key arguments for notes retrieval
//
//*********************************************************************************

String		ls_pattern_id

IF	Len (is_user_pattern_id)	>	0		THEN
	// User defined pattern
	ls_pattern_id	=	is_user_pattern_id
ELSE
	ls_pattern_id	=	is_pattern_id
END IF

// FDG 12/13/00 Begin
//Select	note_text
//Into		:is_note_text[al_row]
//From		notes
//Where		note_rel_type	=	'PA'
//And		note_rel_id		=	:ls_pattern_id
//Using		Stars2ca ;
//
//Stars2ca.of_check_status()

//	09/17/02	GaryR	SPR 4182c
//is_note_text[al_row]		=	gnv_sql.of_get_note_text ('PA', ls_pattern_id)
is_note_text[al_row]		=	gnv_sql.of_get_note_text( ids_notes.object.note_id[al_row], 'PA', ls_pattern_id )

// FDG 12/13/00 End


end event

event ue_edit_save_filter;//*********************************************************************************
// Script Name:	ue_edit_save_filter
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event is triggered from ue_save and ue_export.  This
//						event will see if the pattern being saved is a filter pattern.
//						If so, display a warning message.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

// User defined filter patterns need not be edited
IF	Len (is_user_pattern_id)	>	0		THEN
	Return	1
END IF

IF	is_pattern_id		=	ics_filter_pat		THEN
	li_rc	=	MessageBox ('Warning', 'To reuse a filter pattern, you should fully document '	+	&
				'the pattern description to ensure that it can be reused.  '	+	&
				'Would you like to continue?', Exclamation!, OkCancel!, 1)
	IF	li_rc	=	2		THEN
		Return	-1
	END IF
END IF



Return	1

end event

event ue_enable_select;//*********************************************************************************
// Script Name:	ue_enable_select
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the select RMM & button
//						FALSE	-	Disable the select RMM & button
//
// Returns:			None
//
//	Description:	Enable/disable the select RMM depending on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_list.m_dummyitem.m_selectpattern.enabled		=	ab_switch

tab_patt.tabpage_list.cb_list_select.enabled				=	ab_switch

end event

event ue_enable_delete;//*********************************************************************************
// Script Name:	ue_enable_delete
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the delete RMM 
//						FALSE	-	Disable the delete RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the delete RMM depending on the boolean passed.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_list.m_dummyitem.m_deletepattern.enabled		=	ab_switch


end event

event ue_enable_save;//*********************************************************************************
// Script Name:	ue_enable_save
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Save RMM 
//						FALSE	-	Disable the Save RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the Save RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_save.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_save.enabled		=	ab_switch
im_patt_custom.m_dummyitem.m_save.enabled			=	ab_switch
im_patt_timeframe.m_dummyitem.m_save.enabled		=	ab_switch
im_patt_report.m_dummyitem.m_save.enabled			=	ab_switch


end event

event ue_enable_saveas;//*********************************************************************************
// Script Name:	ue_enable_saveas
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Saveas RMM 
//						FALSE	-	Disable the Saveas RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the Saveas RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_saveas.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_saveas.enabled			=	ab_switch
im_patt_custom.m_dummyitem.m_saveas.enabled			=	ab_switch
im_patt_timeframe.m_dummyitem.m_saveas.enabled		=	ab_switch
im_patt_report.m_dummyitem.m_saveas.enabled			=	ab_switch


end event

event ue_enable_export;//*********************************************************************************
// Script Name:	ue_enable_export
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Export RMM 
//						FALSE	-	Disable the Export RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the Export RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_exportpattern.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_exportpattern.enabled		=	ab_switch
im_patt_custom.m_dummyitem.m_exportpattern.enabled			=	ab_switch
im_patt_timeframe.m_dummyitem.m_exportpattern.enabled		=	ab_switch
im_patt_report.m_dummyitem.m_exportpattern.enabled			=	ab_switch


end event

event ue_enable_clear;//*********************************************************************************
// Script Name:	ue_enable_clear
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Clear RMM & button
//						FALSE	-	Disable the Clear RMM & button
//
// Returns:			None
//
//	Description:	Enable/disable the Clear RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_clear.enabled				=	ab_switch
im_patt_options.m_dummyitem.m_clear.enabled				=	ab_switch
im_patt_custom.m_dummyitem.m_clear.enabled				=	ab_switch
im_patt_timeframe.m_dummyitem.m_clear.enabled			=	ab_switch

tab_patt.tabpage_criteria.cb_criteria_clear.enabled	=	ab_switch
tab_patt.tabpage_options.cb_options_clear.enabled		=	ab_switch
tab_patt.tabpage_timeframe.cb_timeframe_clear.enabled	=	ab_switch

end event

event ue_enable_save_userpattern;//*********************************************************************************
// Script Name:	ue_enable_save_userpattern
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Save/User Pattern RMM 
//						FALSE	-	Disable the Save/User Pattern RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the Save/User Pattern RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_save.m_userpattern.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_save.m_userpattern.enabled			=	ab_switch
im_patt_custom.m_dummyitem.m_save.m_userpattern.enabled			=	ab_switch
im_patt_timeframe.m_dummyitem.m_save.m_userpattern.enabled		=	ab_switch
im_patt_report.m_dummyitem.m_save.m_userpattern.enabled			=	ab_switch


end event

event ue_select_unique_key_columns;//*********************************************************************************
// Script Name:	ue_select_unique_key_columns
//
//	Arguments:		None
//
// Returns:			Integer
//						-1	=	Error. 
//						1	=	Success. 
//
//	Description:	This script will perform the logic to move the unique key
//						columns to dw_selected.  It will also move ICN to the top of
//						the selected list (in case a Select Distinct occurs).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

// Clear any previous data
inv_pattern_sql.uf_clear_data()

// Re-initialize any required data to the NVO
This.Event	ue_init_pattern_sql()

// Determine which table types we will be getting unique keys for.
// This will load istr_from_tables[]
inv_pattern_sql.Event	ue_pattern_from()

// Retrieve the unique keys for these table types
inv_pattern_sql.uf_retrieve_tbl_type()

// Now that all table types are determined and the unique keys for these
//	table types are retrieved, move these unique keys from dw_available
//	to dw_selected.  This will also move ICN to the 1st entry in
//	dw_selected (to handle a Select Distinct).
inv_pattern_sql.Event	ue_select_unique_key_columns()

Return	1

end event

event type integer ue_edit_criteria();//*********************************************************************************
// Script Name:	ue_edit_criteria
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	All edits are successful
//						-1	=	Error
//
//	Description:	Loop thru each line of criteria to insure that everything has
//						been properly entered.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/21/00	FDG	Track 2931 (4.5 SP1).  For a filter pattern, make sure a filter ID
//						is entered and don't call fx_error_check_fields_for_dw()
//	04/23/01	GaryR	Stars 4.7 - Filters can only be implemented in a Filter Pattern
//	04/23/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	10/08/02	GaryR	Track 2893d	Text sensitive search in DropDowns
//	06/25/04	GaryR	Track 4042d	Allow filters across all patterns
// 	01/10/06 HYL 		TRACK 4347d	Allow underscore(_) in filter name
//*********************************************************************************

Integer	li_data_len,			&
			li_lead_alpha,			&
			li_min_len,				&
			li_pos

Long		ll_row,					&
			ll_rowcount,			&
			ll_dwc_rowcount

String	ls_col_name,			&
			ls_data_type,			&
			ls_date1,				&
			ls_date2,				&
			ls_description,		&
			ls_field_set,			&
			ls_filter_id,			&
			ls_message,				&
			ls_relop,				&
			ls_tbl_type,			&
			ls_type,					&
			ls_operator,			&
			ls_value

n_cst_datetime		lnv_datetime		// Autoinstantiated

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	// FDG 04/16/01 - Trim the data.
	ls_col_name		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row])
	ls_description	=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_row])
	ls_tbl_type		=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row])
	ls_field_set	=	tab_patt.tabpage_criteria.dw_criteria.object.field_set [ll_row]
	ls_operator		=	Trim ( Upper(tab_patt.tabpage_criteria.dw_criteria.object.field_operator [ll_row] ))
	ls_value			=	Trim (tab_patt.tabpage_criteria.dw_criteria.object.field_value	[ll_row] )
	
	// Edit column
	IF	IsNull (ls_description)				&
	OR	Trim (ls_description)	=	''		THEN
		IF	 is_pattern_id			=	ics_generic		&
		AND ll_row					>	1					THEN
			// Last row (not the 1st) row of generic criteria.  No further edits required.
			Continue
		ELSE
			// A value is required in the column
			IF	is_pattern_id		=	ics_generic		THEN
				ls_message			=	'You must select a column for this field.'
			ELSE
				ls_message			=	'You must select a column for all fields.'
			END IF
			tab_patt.SelectTab (ici_criteria)
			tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
			tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
			tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_col_name')
			MessageBox ('Error', ls_message)
			Return	-1
		END IF
	END IF
	// Edit operator
	IF	Trim (ls_operator)	=	''		THEN
		IF	is_pattern_id		=	ics_generic		THEN
			ls_message			=	'You must select an operator for this field.'
		ELSE
			ls_message			=	'You must select an operator for all fields.'
		END IF
		tab_patt.SelectTab (ici_criteria)
		tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
		tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
		tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_operator')
		MessageBox ('Error', ls_message)
		Return	-1
	END IF
	// The operator passed to fx_error_check_fields_for_dw can only be certain
	//	values.  To do this, convert ls_operator to ls_relop
	CHOOSE CASE	Upper (ls_operator)
		CASE	'LIKE',	'IN'
			ls_relop		=	'='
		CASE	'NOT LIKE',	'NOT IN'
			ls_relop		=	'<>'
		CASE	'BETWEEN'
			ls_relop		=	'><'
		CASE	ELSE
			ls_relop		=	ls_operator
	END CHOOSE
	// Edit value
	IF	Trim (ls_value)		=	''		THEN
		IF	is_pattern_id		=	ics_generic		THEN
			ls_message			=	'You must enter a value for this field.'
		ELSE
			ls_message			=	'You must enter a value for all fields.'
		END IF
		tab_patt.SelectTab (ici_criteria)
		tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
		tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
		tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_value')
		MessageBox ('Error', ls_message)
		Return	-1
	END IF
	
	//	10/08/02	GaryR	SPR 2893d - Begin
	ls_data_type	=	inv_pattern_sql.uf_get_data_type (ls_tbl_type, ls_col_name)
	li_data_len		=	inv_pattern_sql.uf_get_data_len ()		//	Get the column's length
	li_min_len		=	inv_pattern_sql.uf_get_min_len ()		//	Get the column's minimum length
	li_lead_alpha	=	inv_pattern_sql.uf_get_lead_alpha ()	//	Get the column's # of leading characters
	//	10/08/02	GaryR	SPR 2893d - End
	
	IF	Trim (ls_value)		=	ics_same_column		THEN
		// A column is compared against itself.  No further edits 
		// are necessary
		Continue
	END IF
	// Continue edits on operator
	IF	ls_operator	=	'LIKE'		&
	OR	ls_operator	=	'NOT LIKE'	THEN
		IF	 Pos (ls_value, '%')	=	0		&
		AND Pos (ls_value, '_')	=	0		THEN
			//	Need a wildcard
			ls_message	=	"A percent sign or underscore is required when using 'like' or 'not like'."
			tab_patt.SelectTab (ici_criteria)
			tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
			tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
			tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_value')
			MessageBox ('Error', ls_message)
			Return	-1
		END IF
	ELSE
		// Any value other than 'like' or 'not like'
		IF	( ( Pos (ls_value, '%') > 0 OR Pos (ls_value, '_') > 0 ) AND &
		       Left(ls_value,1) <> '@' )	THEN // HYL 01/10/06 TRACK 4347d Allow underscore(_) in filter name
			//	Wildcard is not allowed
			ls_message	=	"A percent sign or underscore is only valid when using 'like' or 'not like'."
			tab_patt.SelectTab (ici_criteria)
			tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
			tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
			tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_value')
			MessageBox ('Error', ls_message)
			Return	-1
		END IF
	END IF			// ls_operator = 'LIKE' or 'NOT LIKE'
	CHOOSE CASE	ls_operator
		CASE	'>',	'<',	'<=',	'>=',	'<>',	'LIKE',	'NOT LIKE'
			IF	 Pos (ls_value, ',')	>	0		THEN
				//	Multiple values not allowed
				ls_message	=	"Multiple values cannot be entered when operator '"	+	&
									ls_operator	+	"' is used"
				tab_patt.SelectTab (ici_criteria)
				tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
				tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
				tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_value')
				MessageBox ('Error', ls_message)
				Return	-1
			END IF
	END CHOOSE

	// For a filter pattern, make sure a filter ID is entered and don't
	//	call fx_error_check_fields_for_dw()
	IF NOT gnv_app.of_is_filter_name( ls_value ) THEN
		//	Edit this row of criteria in fx_error_check_fields_for_dw
		//	04/23/01	GaryR	Stars 4.7 DataBase Port
		ls_relop		=	fx_error_check_fields_for_dw (ls_data_type,		&
																	ls_relop,			&
																	Upper( ls_value ),&
																	ls_description,	&
																	tab_patt.tabpage_criteria.dw_criteria,		&
																	'field_value',		&
																	ll_row,				&
																	li_min_len,			&
																	li_data_len,		&
																	li_lead_alpha)
		IF	Upper (ls_relop)	=	'ERROR'		THEN
			tab_patt.SelectTab (ici_criteria)
			tab_patt.tabpage_criteria.dw_criteria.SetFocus ()
			tab_patt.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
			tab_patt.tabpage_criteria.dw_criteria.SetColumn ('field_value')
			Return	-1
		END IF
	END IF								// is_pattern_id	=	ics_filter_pat
	
NEXT

Return	1
end event

event ue_close;//*********************************************************************************
// Script Name:	ue_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is posted to if the window is closing.  This event
//						is posted to from ue_postopen and ue_import when the case
//						assigned to the subset is a secure case or is invalid.
//
//						This script will close the window.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

ib_disableclosequery	=	TRUE

Close (This)

end event

event ue_edit_enable_background;//*********************************************************************************
// Script Name:	ue_edit_enable_background
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will determine if the 'Pattern Report and Create
//						Subset RMM is to be enabled/disabled.  Since Patterns 17 and
//						20 programatically generate the report (instead of using SQL),
//						a background subset cannot be created.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	is_pattern_id	=	ics_patt17		&
OR	is_pattern_id	=	ics_patt20		THEN
	// Disable background subset
	This.Event	ue_enable_background (FALSE)
ELSE
	// Enable background subset
	This.Event	ue_enable_background (TRUE)
END IF




end event

event ue_reset_dw_report;//*********************************************************************************
// Script Name:	ue_reset_dw_report
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is called when a pattern is selected, when a column in
//						dw_criteria is changed and when highlighted rows from
//						dw_selected or dw_available are added/removed. 
//
//						This event will reset the contents of dw_report and will reset
//						the data in inv_pattern_sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

tab_patt.tabpage_report.dw_report.Reset()

tab_patt.tabpage_report.st_count.text	=	'0'

inv_pattern_sql.uf_clear_data()

// Disable the Create Subset and Save Report RMMs
This.Event	ue_enable_subset (FALSE)
This.Event	ue_enable_save_report (FALSE)

end event

event ue_timeframe_edit_rb4;//*********************************************************************************
// Script Name:	ue_timeframe_edit_rb4
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when a column is selected in the criteria
//						(From ue_fill_timeframe_dddw and ue_load_timeframe.
//	
//						This script will loop thru all criteria tows, if a '1500' and 
//						'UB92' column exists, then the 4th radio button will display
//						a description.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_1500,				&
			lb_ub92

Long		ll_rowcount,		&
			ll_crit_row,		&
			ll_row

String	ls_base_type,		&
			ls_tbl_type,		&
			ls_col_name

ll_row		=	tab_patt.tabpage_timeframe.dw_timeframe.GetRow()

// Determine if the 4th button is to be allowed by updating column row4_desc.

ll_rowcount	=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR ll_crit_row	=	1 TO ll_rowcount
	ls_tbl_type		=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_crit_row]
	ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_crit_row]
	// If the column name is blank (last row), then ignore it.
	IF	Trim (ls_col_name)	=	''		THEN
		Continue
	END IF
	// If the column is a revenue column, don't add it.
	IF	ls_tbl_type	=	is_revenue_code		THEN
		Continue
	END IF
	ls_base_type		=	Upper ( inv_pattern_sql.uf_get_base_type (ls_tbl_type) )
	IF	ls_base_type	=	'1500'		THEN
		lb_1500			=	TRUE
	END IF
	IF	ls_base_type	=	'UB92'		THEN
		lb_ub92			=	TRUE
	END IF
NEXT

IF	lb_1500	AND	lb_ub92		THEN
	// Enable the 4th button
	tab_patt.tabpage_timeframe.dw_timeframe.object.row4_desc [ll_row]	=	'YES'
	tab_patt.tabpage_timeframe.dw_timeframe.object.ub92_1500_title_t.color	=	stars_colors.label_text
ELSE
	// Disable the 4th button
	tab_patt.tabpage_timeframe.dw_timeframe.object.row4_desc [ll_row]	=	'NO'
	tab_patt.tabpage_timeframe.dw_timeframe.object.ub92_1500_title_t.color	=	stars_colors.protected_text
END IF


end event

event ue_enable_subset;//*********************************************************************************
// Script Name:	ue_enable_subset
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Save/Create Subset & m_reportsave RMM 
//						FALSE	-	Disable the Save/Create & m_reportsave Subset RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the Save/Create Subset RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_report.m_dummyitem.m_save.m_createsubset.enabled			=	ab_switch


end event

event ue_enable_save_report;//*********************************************************************************
// Script Name:	ue_enable_save_report
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Save/Save Report RMM 
//						FALSE	-	Disable the Save/Save Report RMM 
//
// Returns:			None
//
//	Description:	Enable/disable the Save/Save Report RMM depending on the boolean passed.
//						This will occur for all tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_report.m_dummyitem.m_save.m_reportsave.enabled			=	ab_switch


end event

event ue_init_criteria_dddw;//*********************************************************************************
// Script Name:	ue_init_criteria_dddw
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when the window is opened and when a
//						pattern is imported.  This script will retrieve the data
//						for the criteria DDDW passing is_tbl_retrieve[] as the
//						retrieval arguments.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_rowcount,		&
			ll_row

DataWindowChild	ldwc_field_name

// Get the entries into is_tbl_retrieve[]
This.Event	ue_get_tbl_retrieve ()

li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', ldwc_field_name)

ll_row	=	ldwc_field_name.InsertRow(0)

ldwc_field_name.SetTransObject (Stars2ca)

ll_rowcount	=	ldwc_field_name.Retrieve (is_tbl_retrieve)

//FOR	ll_row	=	1	TO	ll_rowcount
//	ls_inv_type		=	ldwc_field_name.GetItemString (ll_row, 'elem_tbl_type')
//	ls_elem_desc	=	ldwc_field_name.GetItemString (ll_row, 'elem_desc')
//	// Truncate to 15 bytes and convert to upper case
//	inv_pattern_sql.uf_edit_elem_desc (ls_elem_desc)
//	ldwc_field_name.SetItem (ll_row, 'elem_desc', ls_elem_desc)
//	ldwc_field_name.SetItem (ll_row, 'column_description', ls_inv_type + '.' + ls_elem_desc)
//	IF	ib_include_non_string_columns	=	FALSE		THEN
//		//	If the data type is not VARCHAR or CHAR, then remove it.
//		ls_data_type	=	Upper (ldwc_field_name.GetItemString (ll_row, 'elem_data_type') )
//		IF	ls_data_type	=	'VARCHAR'		&
//		OR	ls_data_type	=	'CHAR'			THEN
//			// Column has a 'VARCHAR' or 'CHAR' data type.  Keep it.
//		ELSE
//			// Remove the row from the drop-down
//			ldwc_field_name.RowsDiscard (ll_row, ll_row, Primary!)
//			ll_row	--
//			ll_rowcount	--
//		END IF
//	END IF
//NEXT

// Free up any locks
Stars2ca.of_commit()

	


end event

event ue_reset_dw_criteria;//*********************************************************************************
// Script Name:	ue_reset_dw_criteria
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will clear the criteria datawindow on the Criteria
//						tab.  Because the DDDW for 'column_description' has retrieval
//						arguments, insert a row into the DDDW to prevent the
//						PowerBuilder Retrieval Arguments window from displaying.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_idx,				&
			li_rc

Long		ll_row

DataWindowChild	ldwc

//	Clear out the datawindows and datastores
tab_patt.tabpage_criteria.dw_criteria.Reset()

// Insert a row into the Criteria DDDW because the DDDW has retrieval arguments.
//	This will prevent the PowerBuilder 'Retrieval Arguments' window
// from displaying.
li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', ldwc)

ll_row	=	ldwc.InsertRow(0)





end event

event ue_enable_notes;//*********************************************************************************
// Script Name:	ue_enable_notes
//
//	Arguments:		ab_switch
//						TRUE	-	Enable the Notes RMM
//						FALSE	-	Disable the Notes RMM
//
// Returns:			None
//
//	Description:	Enable/disable the Notes RMM depending on the boolean passed.
//
//*********************************************************************************
//	
// 09/21/00 FDG	Stars 4.8.1.	Created
//
//*********************************************************************************

IF	IsNull (ab_switch)	THEN
	Return
END IF

im_patt_criteria.m_dummyitem.m_notes.enabled		=	ab_switch
im_patt_options.m_dummyitem.m_notes.enabled		=	ab_switch
im_patt_timeframe.m_dummyitem.m_notes.enabled	=	ab_switch
im_patt_custom.m_dummyitem.m_notes.enabled		=	ab_switch
im_patt_report.m_dummyitem.m_notes.enabled		=	ab_switch

end event

event ue_enable_update;//*********************************************************************************
// Script Name:	ue_enable_update
//
//	Arguments:		ab_switch
//						TRUE -	Enable the updating of the pattern
//						FALSE -	Disable the updating of the pattern
//
// Returns:			None
//
//	Description:	This event will enable/disable the changing of the pattern.  This
//						includes modifying data and performing any kind of save.
//
//						FALSE is passed when the case associated with the user pattern
//						is Closed or Deleted.
//
//*********************************************************************************
//	
// 09/21/01 FDG	Stars 4.8.	Created
//
//*********************************************************************************

This.Event	ue_enable_link (ab_switch)
This.Event	ue_enable_save_userpattern (ab_switch)
This.Event	ue_enable_saveas (ab_switch)
This.Event	ue_enable_background (ab_switch)
This.Event	ue_enable_clear (ab_switch)
This.Event	ue_enable_save (ab_switch)
This.Event	ue_enable_save_report (ab_switch)
This.Event	ue_enable_subset (ab_switch)
This.Event	ue_enable_notes (ab_switch)

tab_patt.tabpage_custom.cb_custom_add.enabled		=	ab_switch
tab_patt.tabpage_custom.cb_custom_remove.enabled	=	ab_switch
tab_patt.tabpage_custom.cb_custom_up.enabled			=	ab_switch
tab_patt.tabpage_custom.cb_custom_down.enabled		=	ab_switch


IF	ab_switch	=	TRUE		THEN
	// Allow updates.  However, prior edits may have enabled/disabled certain menu items
	tab_patt.tabpage_criteria.dw_criteria.object.DataWindow.ReadOnly		=	'No'
	tab_patt.tabpage_criteria.dw_patt_cntl.object.DataWindow.ReadOnly		=	'No'
	tab_patt.tabpage_options.dw_patt_options.object.DataWindow.ReadOnly	=	'No'
	tab_patt.tabpage_timeframe.dw_timeframe.object.DataWindow.ReadOnly	=	'No'
	tab_patt.tabpage_custom.dw_available.object.DataWindow.ReadOnly		=	'No'
	tab_patt.tabpage_custom.dw_selected.object.DataWindow.ReadOnly			=	'No'
ELSE
	// Invalid case.  Do not allow updates
	w_main.SetMicroHelp ('This pattern cannot be changed since its associated case is '	+	&
								'Closed or Deleted.')
	tab_patt.tabpage_criteria.dw_criteria.object.DataWindow.ReadOnly		=	'Yes'
	tab_patt.tabpage_criteria.dw_patt_cntl.object.DataWindow.ReadOnly		=	'Yes'
	tab_patt.tabpage_options.dw_patt_options.object.DataWindow.ReadOnly	=	'Yes'
	tab_patt.tabpage_timeframe.dw_timeframe.object.DataWindow.ReadOnly	=	'Yes'
	tab_patt.tabpage_custom.dw_available.object.DataWindow.ReadOnly		=	'Yes'
	tab_patt.tabpage_custom.dw_selected.object.DataWindow.ReadOnly			=	'Yes'
END IF

end event

event type integer ue_edit_revenue();///////////////////////////////////////////////////////////////////////////////////
//
//	This method will check for Revenue in criteria
//
///////////////////////////////////////////////////////////////////////////////////
//
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//
///////////////////////////////////////////////////////////////////////////////////

Integer	li_count, li_row
String	ls_inv_type, ls_claim_ind, ls_msg
n_ds		lds_claim_keys

//	Reset the revenue crit flag
inv_pattern_sql.ib_rev_crit = FALSE

//	If ML or not Generic get out
IF is_inv_type = "ML" OR is_pattern_id <> ics_generic THEN Return 0

//	Check for revenue in criteria
IF is_revenue_code <> "" THEN
	li_count = tab_patt.tabpage_criteria.dw_criteria.RowCount()
	
	FOR li_row = 1 TO li_count
		ls_inv_type = Trim( tab_patt.tabpage_criteria.dw_criteria.GetItemString( li_row, "column_description" ) )
		//	Make sure prefix exists
		IF Pos( ls_inv_type, "." ) <> 3 THEN Continue
		//	Get first two bytes
		ls_inv_type = Left( ls_inv_type, 2 )
		IF ls_inv_type = is_revenue_code THEN
			inv_pattern_sql.ib_rev_crit = TRUE
			Return 1
		END IF
	NEXT
	
	ls_msg = "~n~r~n~rTo work around this limitation you can either select " + &
				"the Different Claim option on the Options Tab or add " + &
				"Revenue criteria to your query on the Criteria Tab."
ELSE
	ls_msg = "~n~r~n~rTo work around this limitation you can select " + &
				"the Different Claim option on the Options Tab."
END IF

//	Check if same claim
li_row = tab_patt.tabpage_options.dw_patt_options.GetRow()
IF li_row > 0 THEN
	ls_claim_ind = tab_patt.tabpage_options.dw_patt_options.object.claim_ind [li_row]
END IF

IF ls_claim_ind <> "S" THEN Return 0

// Check if claim line keys exist
lds_claim_keys = Create n_ds
lds_claim_keys.DataObject = "d_claim_keys"
lds_claim_keys.SetTransObject( Stars2ca )
li_count = lds_claim_keys.Retrieve( is_inv_type )
IF lds_claim_keys.Find( "key_type = 'L'", 0, li_count ) > 0 THEN
	Destroy lds_claim_keys
	Return 1
END IF

Destroy lds_claim_keys

// No revenue found in criteria
MessageBox( "Data Source Error", "Your site does not support the Same Claim pattern " + &
							"option for this data source configuration. At this level each " + &
							"claim is unique." + ls_msg, StopSign! )
tab_patt.SelectTab( ici_options )
tab_patt.tabpage_options.dw_patt_options.SetFocus()
tab_patt.tabpage_options.dw_patt_options.SetColumn( "claim_ind" )
Return -1
end event

public function integer wf_get_left_over_tbl_types ();//*********************************************************************************
// Script Name:	wf_get_left_over_tbl_types
//
//	Arguments:		None
//
// Returns:			Integer
//						 0	=	No entries in is_tbl_type[]
//						 1	=	Success
//
//	Description:	This function is called by event ue_write_subset_tables.
//
//						This script will get the tables in the subset that are not in the
//						pattern and add them to is_left_over_tbl_types[].
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_found

Integer	li_upper,				&
			li_idx,					&
			li_idx2,					&
			li_idx3,					&
			li_num_of_fields

String	ls_empty[]

is_left_over_tbl_types	=	ls_empty

li_num_of_fields	=	UpperBound (is_tbl_type)

IF	li_num_of_fields	>	0		THEN
	IF	is_tbl_type [li_num_of_fields]	=	''		THEN
		li_num_of_fields	--
	END IF
ELSE
	Return	0
END IF

li_upper		=	UpperBound (istr_sub_opt.patt_struc.table_type)

FOR	li_idx	=	1	TO	li_upper
	lb_found		=	FALSE
	FOR	li_idx2	=	1	TO	li_num_of_fields
		IF	istr_sub_opt.patt_struc.table_type[li_idx]	=	is_tbl_type[li_idx2]		THEN
			lb_found	=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_found	=	FALSE		THEN
		FOR	li_idx2	=	1	TO	li_idx3
			IF	istr_sub_opt.patt_struc.table_type[li_idx]	=	is_left_over_tbl_types[li_idx2]	THEN
				lb_found	=	TRUE
				Exit
			END IF
		NEXT
		IF	lb_found	=	FALSE		THEN
			li_idx3	++
			is_left_over_tbl_types[li_idx3]	=	istr_sub_opt.patt_struc.table_type[li_idx]
		END IF
	END IF
NEXT

Return	1

end function

public function long wf_copy_dw_3_to_dw_2 ();//*********************************************************************************
// Script Name:	wf_copy_dw_3_to_dw_2
//
//	Arguments:		None
//
// Returns:			Long - The new row # in dw_2
//
//	Description:	This function is called for patterns 17 and 20 that copies
//						a row of data from dw_3 to dw_2.  Instance variable il_row
//						stores the row # to use from dw_3.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_new

ll_new	=	dw_2.InsertRow(0)
dw_2.ScrollToRow (ll_new)

dw_2.object.data [ll_new]	=	dw_3.object.data [il_row]

Return	ll_new

end function

public function integer wf_sample_17_mark_hicn_rows ();//*********************************************************************************
// Script Name:	wf_sample_17_mark_hicn_rows
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function gets all rows from the invisible dw_2 and
//						checks to see if they should be printed.  If so, it marks
//						the row with a 'Y' in the print indicator column (= ici_print_ind).
//
//	Note:				1.	il_consecutive_days is set in ue_pattern_17.
//
//						2.	Changes to wf_sample_20_mark_hicn_rows MAY also have to be
//							made here.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_base_row,			&
			ll_consecutive_ct,	&
			ll_days_diff,			&
			ll_index,				&
			ll_row,					&
			ll_row2,					&
			ll_rowcount,			&
			ll_times_to_compare

String	ls_colsort

Date		ldt_cur_row_date,		&
			ldt_next_row_date

ll_rowcount		=	dw_2.RowCount()

ll_base_row		=	1

IF ll_rowcount	<	il_consecutive_days	THEN
	// Not as many transactions as required consecutive days.  
	//	No analysis necessary.  Exit without printing.
	RETURN 1
ELSE
	//  Form a base starting point for the evaluation of all 
	//	"series" of consecutive rows.
	ls_colsort = "#"	+	String (ici_from_date_col) + " A"

	li_rc = dw_2.SetSort(ls_colsort)
	IF li_rc = 1 THEN

		li_rc = dw_2.sort( )
		IF li_rc = -1 THEN
			Return -1
		END IF
	ELSE
		Return -1
	END IF

	//  Begin to evaluate and mark rows for printing.
	ll_times_to_compare  = (ll_rowcount - (il_consecutive_days - 1))
	FOR ll_row2 = 1 TO ll_times_to_compare
		ll_index = 0
		ll_consecutive_ct = 0 

		If ll_rowcount >= (ll_base_row + ll_index + 1) THEN
			ldt_cur_row_date  = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
			ldt_next_row_date = Date (dw_2.getitemdatetime((ll_base_row + ll_index + 1), ici_from_date_col))
			ll_days_diff     = DaysAfter (ldt_cur_row_date,ldt_next_row_date)
		ELSE
			//  Done all checking for this HICN, exit the function.
			EXIT
		END IF

		//  Within the "base" of each row, evaluate the following rows 
		//	in a series until consecutives are found, a date break is encountered, 
		//	or we exhaust the table.
		DO UNTIL (ll_days_diff > 1)  &
			OR  ((ll_rowcount - 1) - (ll_base_row - 1) - ll_index ) <= 0

			//  "FROM_DATE" is in column 2.
			ldt_cur_row_date  = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
			ldt_next_row_date = Date (dw_2.getitemdatetime((ll_base_row + ll_index + 1), ici_from_date_col))
			ll_days_diff     = DaysAfter (ldt_cur_row_date, ldt_next_row_date)
			IF ll_days_diff  = 1 THEN
				ll_consecutive_ct = ll_consecutive_ct + 1
				ll_index = ll_index + 1
			ELSE
				IF ll_days_diff = 0 THEN
					//  Same day transaction, bypass it and continue.
					ll_index = ll_index + 1
				END IF
			END IF
		LOOP

		//  Break in days or end of DW is found.
		IF ll_consecutive_ct >= (il_consecutive_days - 1 ) THEN 
		//  We found some hits.  Mark these records for printing.
			FOR ll_row = 0 TO ll_index
				dw_2.setitem((ll_base_row + ll_row), ici_print_ind, 'Y')
			NEXT
		END IF
		IF ll_index = 0 THEN
			ll_base_row = ll_base_row + 1
		ELSE
			ll_base_row = ll_base_row + ll_index
		END IF
	NEXT
	RETURN 1
END IF


end function

public function integer wf_sample_17_20_prep_hicn_rows ();//*********************************************************************************
// Script Name:	wf_sample_17_20_prep_hicn_rows
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function gets called for both patterns 17 and 20.
//
//						This function breaks down the from/to date range into single
//						from/to date transactions.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Date		ldt_from_date,				&
			ldt_thru_date,				&
			ldt_new_date

DateTime	ldtm_from_date
			
Long		ll_num_days,				&
			ll_new_row,					&
			ll_idx

ldt_from_date		=	Date (dw_3.GetItemDateTime (il_row, ici_from_date_col) )
ldt_thru_date		=	Date (dw_3.GetItemDateTime (il_row, ici_to_date_col) )

IF	ldt_from_date	<>	ldt_thru_date		THEN
	ll_num_days		=	DaysAfter (ldt_from_date, ldt_thru_date)
	FOR	ll_idx	=	0	TO	ll_num_days
		ldt_new_date	=	RelativeDate (ldt_from_date, ll_idx)
		ldtm_from_date	=	DateTime (ldt_new_date)
		ll_new_row		=	This.wf_copy_dw_3_to_dw_2()
		dw_3.SetItem (ll_new_row, ici_from_date_col, ldtm_from_date)
	NEXT
ELSE
	ll_new_row		=	This.wf_copy_dw_3_to_dw_2()
END IF

Return	1



end function

public function integer wf_sample_17_print_hicn_rows ();//*********************************************************************************
// Script Name:	wf_sample_17_print_hicn_rows
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function gets all rows from the invisible dw_2 and
//						checks to see if they should be printed.  If so, the print
//						indicator column (= ici_print_ind) will be 'Y'.  All rows with
//						a 'Y' are moved to dw_1 (printed).  Whether or not they move
//						to dw_1, they are still deleted from dw_2.
//
//	Note:				There is only one line of code that is different than
//						wf_sample_20_print_hicn_rows.  Changes to this function
//						must also be made here.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_match

DateTime	ldtm_base_from,		&
			ldtm_next_from

Long		ll_row,					&
			ll_rowcount,			&
			ll_base_row,			&
			ll_new_row

Integer	li_col,					&
			li_col_count,			&
			li_rc,					&
			li_idx2

String	ls_sort,					&
			ls_print_ind
			

ll_rowcount = dw_2.Rowcount()

IF ll_rowcount < 1  THEN
	Return -1
END IF

li_col_count = Integer (dw_2.Describe("DataWindow.Column.Count"))

// Include the unique column numbers in the sort.  The first 10 columns
//	are fixed.  The 11th column on are the unique key columns.
FOR	li_col	=	11	TO	li_col_count
	ls_sort		=	ls_sort	+	" #"	+	String (li_col)	+	" A,"
NEXT

// Remove the last ',' which is at the end of ls_sort
IF	li_col_count	>=	11		THEN
	ls_sort		=	Left (ls_sort, Len(ls_sort) - 1)
	ls_sort		=	Trim (ls_sort)
END IF

// Sort dw_2 by the unique key columns
li_rc = dw_2.SetSort(ls_sort)
li_rc = dw_2.Sort()

li_idx2 = 1
ll_base_row = 1

FOR ll_row = 1 TO ll_rowcount
	IF ll_row = ll_rowcount  THEN
		Exit
	END IF
	Lb_match = TRUE
	// Compare the unique keys
	FOR li_col = 11 TO li_col_count
		IF dw_2.object.data[ll_base_row, li_col] <> dw_2.object.data[ll_base_row + li_idx2, li_col] THEN
			// Unique keys do not match
			lb_match = FALSE
			Exit
		END IF
	NEXT
	IF lb_match = TRUE  THEN
		// A match occurred between unique keys
		ldtm_base_from = dw_2.GetItemDateTime (ll_base_row, ici_from_date_col)
		ldtm_next_from = dw_2.GetItemDateTime (ll_base_row + li_idx2, ici_from_date_col)
		IF ldtm_base_from > ldtm_next_from  THEN
			dw_2.SetItem (ll_base_row, ici_from_date_col, ldtm_next_from)
		END IF
		ls_print_ind = Upper (dw_2.GetItemString (ll_base_row + li_idx2, ici_print_ind) )
		IF ls_print_ind = 'Y'  THEN
			dw_2.SetItem (ll_base_row, ici_print_ind, ls_print_ind)
		END IF
		dw_2.SetItem (ll_base_row + li_idx2, ici_print_ind, '')
		li_idx2 ++
	ELSE
		// No match occurred.  Set the new base row.
		ll_base_row = ll_row				//	Only change from wf_sample_20_print_hicn_rows
		li_idx2 = 1
	END IF
NEXT

FOR ll_row = 1 TO ll_rowcount
	// If the row is printable, move it to dw_1
	IF dw_2.GetItemString (ll_row, ici_print_ind) = 'Y'  THEN
		ll_new_row = tab_patt.tabpage_report.dw_report.InsertRow(0)
		tab_patt.tabpage_report.dw_report.object.data [ll_new_row] = dw_2.object.data [ll_row]
	END IF
NEXT

// Clean out dw_2
dw_2.RowsDiscard (1, ll_rowcount, Primary!)

Return	1

end function

public function integer wf_sample_20_print_hicn_rows ();//*********************************************************************************
// Script Name:	wf_sample_20_print_hicn_rows
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function gets all rows from the invisible dw_2 and
//						checks to see if they should be printed.  If so, the print
//						indicator column (= ici_print_ind) will be 'Y'.  All rows with
//						a 'Y' are moved to dw_1 (printed).  Whether or not they move
//						to dw_1, they are still deleted from dw_2.
//
//	Note:				There is only one line of code that is different than
//						wf_sample_17_print_hicn_rows.  Changes to this function
//						must also be made here.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_match

DateTime	ldtm_base_from,		&
			ldtm_next_from

Long		ll_row,					&
			ll_rowcount,			&
			ll_base_row,			&
			ll_new_row

Integer	li_col,					&
			li_col_count,			&
			li_rc,					&
			li_idx2

String	ls_sort,					&
			ls_print_ind

String	ls_icn1,	ls_icn2, ls_print
Integer	li_line1, li_line2

ll_rowcount = dw_2.Rowcount()

IF ll_rowcount < 1  THEN
	Return -1
END IF

li_col_count = Integer (dw_2.Describe("DataWindow.Column.Count"))

// Include the unique column numbers in the sort.  The first 10 columns
//	are fixed.  The 11th column on are the unique key columns.
FOR	li_col	=	11	TO	li_col_count
	ls_sort		=	ls_sort	+	" #"	+	String (li_col)	+	" A,"
NEXT

// Remove the last ',' which is at the end of ls_sort
IF	li_col_count	>=	11		THEN
	ls_sort		=	Left (ls_sort, Len(ls_sort) - 1)
	ls_sort		=	Trim (ls_sort)
END IF

// Sort dw_2 by the unique key columns
li_rc = dw_2.SetSort(ls_sort)
li_rc = dw_2.Sort()

li_idx2 = 1
ll_base_row = 1

FOR ll_row = 1 TO ll_rowcount
	IF ll_row						>=	ll_rowcount  	&
	OR	(ll_base_row + li_idx2)	>	ll_rowcount		THEN
		Exit
	END IF
	// Debug - begin
//	ls_icn1	=	dw_2.object.data[ll_base_row, 10]
//	li_line1	=	dw_2.object.data[ll_base_row, 11]
//	ls_icn2	=	dw_2.object.data[ll_base_row + li_idx2, 10]
//	li_line2	=	dw_2.object.data[ll_base_row + li_idx2, 11]
//	ls_print	=	dw_2.object.data[ll_base_row, ici_print_ind]
	// Debug - end
	lb_match = TRUE
	// Compare the unique keys
	FOR li_col = 11 TO li_col_count
		IF dw_2.object.data[ll_base_row, li_col] <> dw_2.object.data[ll_base_row + li_idx2, li_col] THEN
			// Unique keys do not match
			Lb_match = FALSE
			Exit
		END IF
	NEXT
	IF lb_match = TRUE  THEN
		// A match occurred between unique keys
		ldtm_base_from = dw_2.GetItemDateTime (ll_base_row, ici_from_date_col)
		ldtm_next_from = dw_2.GetItemDateTime (ll_base_row + li_idx2, ici_from_date_col)
		IF ldtm_base_from > ldtm_next_from  THEN
			dw_2.SetItem (ll_base_row, ici_from_date_col, ldtm_next_from)
		END IF
		ls_print_ind = Upper (dw_2.GetItemString (ll_base_row + li_idx2, ici_print_ind) )
		IF ls_print_ind = 'Y'  THEN
			dw_2.SetItem (ll_base_row, ici_print_ind, ls_print_ind)
		END IF
		dw_2.SetItem (ll_base_row + li_idx2, ici_print_ind, '')
		li_idx2 ++
	ELSE
		// No match occurred.  Set the new base row.
		ll_base_row = ll_row	+	li_idx2		//	Only change from wf_sample_17_print_icn_rows
		li_idx2 = 1
	END IF
NEXT

FOR ll_row = 1 TO ll_rowcount
	// If the row is printable, move it to dw_1
	IF dw_2.GetItemString (ll_row, ici_print_ind) = 'Y'  THEN
		ll_new_row = tab_patt.tabpage_report.dw_report.InsertRow(0)
		tab_patt.tabpage_report.dw_report.object.data [ll_new_row] = dw_2.object.data [ll_row]
	END IF
NEXT

// Clean out dw_2
dw_2.RowsDiscard (1, ll_rowcount, Primary!)

Return	1

end function

public function integer wf_sample_20_mark_rows_for_printing ();//*********************************************************************************
// Script Name:	wf_sample_20_mark_rows_for_printing
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function gets all rows from the invisible dw_2 and
//						checks to see if they should be printed.  If so, it marks
//						the row with a 'Y' in the print indicator column (= ici_print_ind).
//
//	Note:				1.	il_consecutive_days is set in ue_pattern_20.
//
//						2.	Changes to wf_sample_17_mark_hicn_rows MAY also have to be
//							made here.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lv_sample_hit	=	FALSE

Integer	li_rc,								&
			li_pc_day,							&
			li_pc_set

Long		ll_base_row,						&
			ll_consecutive_ct,				&
			ll_consecutive_days,				&
			ll_days_diff,						&
			ll_index,							&
			ll_last_row,						&
			ll_required_consecutive_days,	&
			ll_row,								&
			ll_rowcount,						&
			ll_times_to_compare

String	ls_colsort

Date		ldt_cur_row_date,					&
			ldt_next_row_date,				&
			ldt_range_start_date

// For Sample 20 - Permanent hard fix  - 3 consecutive days
ll_required_consecutive_days	=	3

ll_rowcount		=	dw_2.RowCount()

IF ll_rowcount < ll_required_consecutive_days THEN
	//  Not as many transactions as required consecutive days.  
	//	No analysis necessary.  Exit without printing.
	RETURN 1
ELSE
	//  Form a base starting point for the evaluation of all 
	//	"series" of consecutive rows.  After claim lines from/to dates are exploded 
	//  into single line items, they may not be in sequence.  Sort them by from_date.
	ls_colsort = "#"	+	String (ici_from_date_col) + " A"

	li_rc = dw_2.SetSort(ls_colsort)
	IF li_rc = 1 THEN
		li_rc = dw_2.sort( )
		IF li_rc = -1 THEN
			return -1
		END IF
	else
		return -1
	END IF

//-------Begin Evaluation of All Rows in DW2---------------------------------------
//  Line items are evaluated for consecutive dates.  As soon as 3 
//  consecutive days are found, (relative to 1 base row - ll_base_row),
//  evaluation stops and those rows are marked for printing.  Then the
//  evaluation starts again with the next base row.  This is done
//  to avoid complications with handling duplicate days.  

//  Currently, this logic drops subsequent transactions that have the
//  same date as the last consecutive day in a series if the duplicate
//  date is not part of a separate consecutive date series.  (i.e. a bug)

	ll_consecutive_ct  = (ll_rowcount - 1)
	FOR ll_base_row = 1 TO ll_consecutive_ct
		ll_index = 0
		ll_consecutive_days = 0 

		IF ll_rowcount >= (ll_base_row + ll_index + 1) THEN
			ldt_cur_row_date     = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
			ldt_range_start_date = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
			ldt_next_row_date    = Date (dw_2.getitemdatetime((ll_base_row + ll_index + 1), ici_from_date_col))
			ll_days_diff        = DaysAfter (ldt_cur_row_date,ldt_next_row_date)
		ELSE
			//  Done all checking for this HICN, exit the function.
			EXIT
		END IF

		//  Within the "base" of each row, evaluate the following rows 
		//  in a series until:
		//		- we exhaust the table,
		//		- a date break is encountered,
		//		- next "from" date is beyond the date range for consecutive days.
		//			(i.e. we found the required # of consecutive days)

		//  Only evaluate the rows within the required consecutive date range.
		//  Stop evaluation when end of DW2 is reached.

		DO UNTIL ((ll_consecutive_ct) - (ll_base_row - 1) - ll_index ) <= 0 &
			OR  (DaysAfter (ldt_range_start_date,Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))) >= ll_required_consecutive_days - 1) &
			OR  (ll_days_diff > 1) 

			IF ll_days_diff  = 1 THEN
				//  Identify which proc sets that the current row is in
				ll_consecutive_days = ll_consecutive_days + 1
				wf_sample_20_find_proc_in_set(ll_consecutive_days,ll_last_row,ll_base_row,ll_index)
				ll_index = ll_index + 1
			ELSE
				IF ll_days_diff = 0 THEN
					//  Same day transaction, bypass it and continue.
					wf_sample_20_find_proc_in_set(ll_consecutive_days,ll_last_row,ll_base_row,ll_index)
					ll_index = ll_index + 1
				END IF
			END IF

			//  "FROM_DATE" is in column 2.
			IF ll_rowcount >= (ll_base_row + ll_index + 1) THEN
				ldt_cur_row_date  = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
				ldt_next_row_date = Date (dw_2.getitemdatetime((ll_base_row + ll_index + 1), ici_from_date_col))
				ll_days_diff     = DaysAfter (ldt_cur_row_date,ldt_next_row_date)
			ELSE
				ldt_cur_row_date  = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
				ldt_next_row_date = ldt_cur_row_date
				ll_days_diff     = DaysAfter (ldt_cur_row_date, ldt_next_row_date)
				//  This exit prevents running past the end of the table.
				EXIT
			END IF

		LOOP

		//  Break in days or end of DW is found.
		//  Now test if we had at least the required # of consecutive days.
		IF ll_consecutive_days >= (ll_required_consecutive_days - 1 ) THEN 

			//  ll_last_row is only set here to handle the last consecutive day (i.e. the 3rd)
			ll_last_row = 1
			//  Verify the proc code for the 3rd consecutive day.
			wf_sample_20_find_proc_in_set(ll_consecutive_days,ll_last_row,ll_base_row,ll_index)
			ll_index = ll_index + 1

			//  Logic to detect and process duplicate 3rd day claims
			//  Test for a "next" row before getting its data.
			IF ll_rowcount >= (ll_base_row + ll_index ) THEN
				ldt_cur_row_date  = Date (dw_2.getitemdatetime((ll_base_row + ll_index - 1), ici_from_date_col))
				ldt_next_row_date = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
				ll_days_diff     = DaysAfter (ldt_cur_row_date, ldt_next_row_date)

				DO UNTIL ((ll_rowcount) - (ll_base_row - 1) - ll_index ) <= 0 &  
					OR  (ll_days_diff <> 0) 

					wf_sample_20_find_proc_in_set(ll_consecutive_days,ll_last_row,ll_base_row,ll_index)
					ll_index = ll_index + 1

					//  Do calculation to find out if there is a break in days.
					IF ll_rowcount >= (ll_base_row + ll_index) THEN
						ldt_cur_row_date  = Date (dw_2.getitemdatetime((ll_base_row + ll_index - 1), ici_from_date_col))
						ldt_next_row_date = Date (dw_2.getitemdatetime((ll_base_row + ll_index ), ici_from_date_col))
						ll_days_diff     = DaysAfter (ldt_cur_row_date, ldt_next_row_date)
					ELSE
						//  This exit prevents running past the end of the table.
						EXIT
					END IF
				LOOP
			END IF

			//  ll_last_row is reset here to handle consecutive days 1 and 2.
			ll_last_row = 0

			//  All claim lines have now been evaluated for consecutive days and proc code.
			//  Now determine if we found at least 1 from each proc group, on each day.

			//  We found some hits.  Mark these records for printing.
			IF  (is_proc_set_ctls[1,1] = 'Y') AND (is_proc_set_ctls[2,2] = 'Y') AND (is_proc_set_ctls[3,3] = 'Y') THEN
				lv_sample_hit = TRUE
			ELSEIF (is_proc_set_ctls[1,1] = 'Y') AND (is_proc_set_ctls[2,3] = 'Y') AND (is_proc_set_ctls[3,2] = 'Y') THEN
				lv_sample_hit = TRUE
			ELSEIF (is_proc_set_ctls[1,2] = 'Y') AND (is_proc_set_ctls[2,1] = 'Y') AND (is_proc_set_ctls[3,3] = 'Y') THEN
				lv_sample_hit = TRUE
			ELSEIF (is_proc_set_ctls[1,2] = 'Y') AND (is_proc_set_ctls[2,3] = 'Y') AND (is_proc_set_ctls[3,1] = 'Y') THEN
				lv_sample_hit = TRUE
			ELSEIF (is_proc_set_ctls[1,3] = 'Y') AND (is_proc_set_ctls[2,1] = 'Y') AND (is_proc_set_ctls[3,2] = 'Y') THEN
				lv_sample_hit = TRUE
			ELSEIF (is_proc_set_ctls[1,3] = 'Y') AND (is_proc_set_ctls[2,2] = 'Y') AND (is_proc_set_ctls[3,1] = 'Y') THEN
				lv_sample_hit = TRUE
			END IF
			IF lv_sample_hit THEN
				FOR ll_row = 1 TO ll_index 
					li_rc = dw_2.setitem((ll_base_row + (ll_row - 1)), ici_print_ind, 'Y')
				NEXT
			END IF 
		END IF

		lv_sample_hit = FALSE
		//  Clear out the proc set control array for the next group
		FOR li_pc_day = 1 TO 3
			FOR li_pc_set = 1 TO 3
				is_proc_set_ctls[li_pc_day,li_pc_set] = ''
			NEXT
		NEXT
		//  add any other clearing or resetting of variables.
	NEXT

	RETURN 1
END IF

Return 1

end function

public function integer wf_sample_20_find_proc_in_set (long al_consecutive_days, long al_last_row, long al_base_row, long al_index);//*********************************************************************************
// Script Name:	wf_sample_20_find_proc_in_set
//
//	Arguments:		1.	al_consecutive_days
//						2.	al_last_row
//						3.	al_base_row
//						4.	al_index
//
// Returns:			Integer
//
//	Description:	This function is called by wf_sample_20_mark_rows_for_printing
//						for pattern 20.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_comma,				&
			ll_dash,					&
			ll_rel_day_row

String	ls_cur_proc,			&
			ls_end_proc_code,		&
			ls_proc_code,			&
			ls_start_proc_code,	&
			ls_work_set

ll_rel_day_row	=	al_consecutive_days + al_last_row

IF ll_rel_day_row < 1		THEN
	ll_rel_day_row = 1
END IF

//  Check to find if claim line item proc code is in set 1
ls_work_set	=	is_proc_set1

DO UNTIL Len (ls_work_set) = 0
	ll_comma = Pos (ls_work_set,',')
	IF ll_comma > 0 THEN
		ls_proc_code = Mid (ls_work_set,1,ll_comma - 1)
		ll_dash = Pos (ls_proc_code,'-')
		IF ll_dash > 0 THEN
			ls_start_proc_code = Mid (ls_proc_code,1,ll_dash - 1)
			ls_end_proc_code   = Mid (ls_proc_code,ll_dash + 1)
		ELSE
			ls_start_proc_code = ls_proc_code
			ls_end_proc_code   = ls_proc_code
		END IF
		ls_cur_proc = dw_2.getitemstring((al_base_row + al_index),ici_proc_code)
		IF ls_cur_proc >= ls_start_proc_code and ls_cur_proc <= ls_end_proc_code THEN
			//  Mark day,proc code set 1 in master table
			is_proc_set_ctls[ll_rel_day_row,1] = 'Y'
		END IF
		ls_work_set = Mid (ls_work_set,ll_comma + 1)
	ELSE
		ls_work_set = ''
	END IF
LOOP

//  Check to find IF claim line item proc code is in set 2

ls_work_set = is_proc_set2

DO UNTIL Len (ls_work_set) = 0
	ll_comma = Pos (ls_work_set,',')
	IF ll_comma > 0 THEN
		ls_proc_code = Mid (ls_work_set,1,ll_comma - 1)
		ll_dash = Pos (ls_proc_code,'-')
		IF ll_dash > 0 THEN
			ls_start_proc_code = Mid (ls_proc_code,1,ll_dash - 1)
			ls_end_proc_code   = Mid (ls_proc_code,ll_dash + 1)
		ELSE
			ls_start_proc_code = ls_proc_code
			ls_end_proc_code   = ls_proc_code
		END IF
		ls_cur_proc = dw_2.getitemstring((al_base_row + al_index),ici_proc_code)
		IF ls_cur_proc >= ls_start_proc_code &
		and ls_cur_proc <= ls_end_proc_code THEN
			//  Mark day,proc code set 2 in master table
			is_proc_set_ctls[ll_rel_day_row,2] = 'Y'
		END IF
		ls_work_set = Mid (ls_work_set,ll_comma + 1)
	ELSE
		ls_work_set = ''
	END IF
LOOP

//  Check to find if claim line item proc code is in set 3
ls_work_set = is_proc_set3

DO UNTIL Len (ls_work_set) = 0
	ll_comma = Pos (ls_work_set,',')
	IF ll_comma > 0 THEN
		ls_proc_code = Mid (ls_work_set,1, ll_comma - 1)
		ll_dash = Pos (ls_proc_code, '-')
		IF ll_dash > 0 THEN
			ls_start_proc_code = Mid (ls_proc_code, 1, ll_dash - 1)
			ls_end_proc_code   = Mid (ls_proc_code, ll_dash + 1)
		ELSE
			ls_start_proc_code = ls_proc_code
			ls_end_proc_code   = ls_proc_code
		END IF
		ls_cur_proc = dw_2.getitemstring((al_base_row + al_index),ici_proc_code)
		IF  ls_cur_proc >= ls_start_proc_code		&
		AND ls_cur_proc <= ls_end_proc_code			THEN
			//  Mark day,proc code set 3 in master table
			is_proc_set_ctls[ll_rel_day_row,3] = 'Y'
		END IF
		ls_work_set = Mid (ls_work_set,ll_comma + 1)
	ELSE
		ls_work_set = ''
	END IF
LOOP
	
RETURN 1



end function

public function integer wf_add_is_tbl_type (string as_tbl_type);//*********************************************************************************
// Script Name:	wf_add_is_tbl_type
//
//	Arguments:		as_tbl_type
//
// Returns:			Integer
//						>0	=	New UpperBound of is_tbl_type
//						0	=	Nothing to add
//
//	Description:	Add the passed invoice type to is_tbl_type[].  This is called
//						from wf_dependency().
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/05/07	GaryR	SPR 4773	Make provider numbered patterns NPI compliant
//
//*********************************************************************************

Boolean		lb_found

Integer		li_upper,		&
				li_idx

String		ls_base_type

// Edit the input

IF	IsNull (as_tbl_type)				&
OR	Trim (as_tbl_type)	=	''		THEN
	Return	0
END IF

li_upper		=		UpperBound (is_tbl_type)

// Search for duplicates
FOR	li_idx	=	1	TO	li_upper
	IF	as_tbl_type		=	is_tbl_type [li_idx]		THEN
		// Table type already exists.  Get out.
		Return	0
	END IF
NEXT

// For patterns 53 & 54, UB92 invoice types only get added.
//	The SQL for Patterns 53 & 54 only includes C2 (UB92) data in the Select and From clause.  
//	However, the Where clause performs a sub-select which includes 1500 (i.e. C1) columns.
IF	is_pattern_id	=	ics_patt53 OR is_pattern_id	=	ics_patt54	THEN
	ls_base_type	=	Upper (inv_pattern_sql.uf_get_base_type (as_tbl_type) )
	IF	ls_base_type	<>	'UB92'		THEN
		Return	0
	END IF
END IF

// Add to the end
li_upper	++

is_tbl_type [li_upper]	=	as_tbl_type

Return	li_upper

		


end function

public function boolean wf_is_1500_and_ub92 ();//*********************************************************************************
// Script Name:	wf_is_1500_and_ub92()
//
//	Arguments:		None
//
// Returns:			Boolean
//						TRUE	=	ML has only one 1500 and UB92 invoice type
//						FALSE	=	ML does not have only one 1500 and UB92 invoice type
//
//	Description:	This function will loop through is_tbl_retrieve[] to determine
//						if the ML subset has only one '1500' and 'UB92' invoice type.
//						
//						This is required to determine if numbered patterns 51 thru 53
//						can be used with a ML subset.  These patterns require that one
//						invoice type be '1500' and the other be 'UB92'
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_1500,		&
			lb_ub92

Integer	li_idx,			&
			li_max

li_max	=	UpperBound (is_tbl_retrieve)

FOR	li_idx	=	1	TO	li_max
	IF	is_rel_type [li_idx]		=	'DP'		THEN
		// Dependent table.  Ignore since we only care about the main tables.
		Continue
	END IF
	IF	is_base_type [li_idx]	=	'1500'	THEN
		IF	lb_1500									THEN
			// Already found a '1500'.  Get out.
			Return	FALSE
		ELSE
			lb_1500					=	TRUE
		END IF
	END IF
	IF	is_base_type [li_idx]	=	'UB92'	THEN
		IF	lb_UB92									THEN
			// Already found a 'UB92'.  Get out.
			Return	FALSE
		ELSE
			lb_ub92					=	TRUE
		END IF
	END IF
NEXT

IF	 lb_1500			&
AND lb_ub92			THEN
	Return	TRUE
ELSE
	Return	FALSE
END IF


end function

public function integer wf_add_left_over_tbl_types (integer ai_tbl_count, ref integer ai_total_steps, datetime adtm_default_datetime);//*********************************************************************************
// Script Name:	wf_add_left_over_tbl_types
//
//	Arguments:		1.	ai_tbl_count
//						2.	ai_total_steps (by reference)
//						3.	adtm_default_datetime
//						4.	as_rpt_id
//
// Returns:			Integer
//
//	Description:	This function is called by event ue_write_subset_tables.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
// 10/25/04 MikeF SPR3650d	Replaced call to fx_col_sel with gnv_dict
//*********************************************************************************

Integer		li_idx,					&
				li_tbl

String		ls_select,				&
				ls_tbl_sql,				&
				ls_table
						
FOR	li_idx	=	1	TO	ai_tbl_count
	li_tbl	=	ai_total_steps
	ai_total_steps	++
	ls_select	=	'SELECT ' +	gnv_dict.uf_get_select_all( is_left_over_tbl_types[li_idx], TRUE)	+	&
						' FROM '
	ls_table		=	fx_build_subset_table_name (is_left_over_tbl_types[li_idx],	&
															istr_sub_opt.patt_struc.subset_id)
	//	12/04/00	GaryR	Stars 4.7 DataBase Port
	//ls_tbl_sql	=	Upper (ls_select	+	Stars2ca.Database	+	'..'	+	ls_table	+	&
	ls_tbl_sql	=	Upper (ls_select	+	gnv_sql.of_get_database_prefix( Stars2ca.Database ) +	&
						ls_table	+	' '	+	is_left_over_tbl_types[li_idx] )
	istr_sub_opt.sub_info[li_tbl].subset_step[1].paid_from_date	=	adtm_default_datetime
	istr_sub_opt.sub_info[li_tbl].subset_step[1].paid_from_date =	adtm_default_datetime
	istr_sub_opt.sub_info[li_tbl].subset_step[1].inv_type			=	is_left_over_tbl_types[li_idx]
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subset_type		=	istr_sub_opt.patt_struc.subset_table_type
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subc_sub_src_type	=	'SS'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].input_type		=	'SUBSET'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].input_id			=	istr_sub_opt.patt_struc.subset_id
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subc_sub_src_case_id = istr_sub_opt.patt_struc.case_id
	istr_sub_opt.sub_info[li_tbl].subset_step[1].sql_statement	=	ls_tbl_sql
	istr_sub_opt.sub_info[li_tbl].source_subset_id					=	istr_sub_opt.patt_struc.subset_id 
NEXT										//	li_idx =	1	TO	ai_tbl_count

Return	1

end function

public function string wf_get_parm_label (string as_patt_field, string as_tbl_type, string as_parm_name);//*********************************************************************************
// Script Name:	wf_get_parm_label()
//
//	Arguments:		1.	as_patt_field
//						2.	as_tbl_type
//						3. as_parm_name
//
// Returns:			String - Column parm_label from patt_field_parm
//
//	Description:	Get column parm_label from patt_field_parm based on the parms
//						passed to this function.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************
			
String	ls_parm_label
			
SELECT	parm_label
INTO		:ls_parm_label
FROM		patt_field_parm
WHERE		patt_id		=	Upper( :is_pattern_id )
  AND		patt_field	=	Upper( :as_patt_field )
  AND		tbl_type		=	Upper( :as_tbl_type )
  AND		parm_name	=	Upper( :as_parm_name )
USING		Stars2ca;

IF	Stars2ca.of_check_status()	<>	0		THEN
	ls_parm_label	=	''
END IF

Return	ls_parm_label


end function

public function integer wf_verify_table (string as_inv_type);//*********************************************************************************
// Script Name:	wf_verify_table
//
//	Arguments:		as_inv_type
//
// Returns:			Integer
//						1	=	Retrieved rows and/or dependent tables in sub_step_cntl
//						0	=	No rows in sub_step_cntl
//
//	Description:	When determining valid invoice types for a ML subset, if
//						there are no rows in sub_step_cntl for that invoice type,
//						then the invoice type is invalid.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_rows

IF	IsNull (as_inv_type)		THEN
	as_inv_type	=	''
END IF

is_dep_tables	=	''

SELECT	num_rows, dep_tbls
INTO		:ll_rows, :is_dep_tables
FROM		sub_step_cntl
WHERE		subc_id	=	Upper( :istr_sub_opt.patt_struc.subset_id )
  AND		inv_type	=	Upper( :as_inv_type )
USING		Stars2ca ;

IF	Stars2ca.of_check_status()	<	0		THEN
	MessageBox ('Database Error', 'Could not read sub_step_cntl in w_sampling_analysis_new.wf_verify_table.' +	&
					'  subc_id = '	+	istr_sub_opt.patt_struc.subset_id	+	' and inv_type = '	+	as_inv_type)
	Return	-1
END IF

IF	ll_rows	>	0		THEN
	li_rc	=	1
ELSE
	li_rc	=	0
END IF

Return	li_rc

end function

public function integer wf_add_level (ref sx_subsetting_info astr_subsetting_info, string as_inv_type);//*********************************************************************************
// Script Name:	wf_add_level
//
//	Arguments:		1.	astr_subsetting_info (Type sx_subsetting_info - by reference)
//						2.	as_inv_type
//
// Returns:			Integer
//
//	Description:	This function adds a subset step to astr_subsetting_info.
//
//						This function is called from wf_load_subset_options when the 
//						Subset RMM is selected on the Report tab.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	03/12/01	FDG	Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
//
//*********************************************************************************

String		ls_sql

//	12/04/00	GaryR	Stars 4.7 DataBase Port
// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
//ls_sql	=	"SELECT * FROM "	+	Stars2ca.database	+	"..SUB_MEDC_"	+	&
ls_sql	=	"SELECT * FROM "	+	gnv_sql.of_get_database_prefix( Stars2ca.database ) + &
				gnv_sql.of_get_subset_prefix()	+	as_inv_type	+	"_"	+	istr_sub_opt.patt_struc.subset_id
ls_sql	=	Upper (ls_sql)

astr_subsetting_info.subset_step[1].inv_type = as_inv_type
astr_subsetting_info.subset_step[1].subset_type = 'ML'
astr_subsetting_info.subset_step[1].subc_sub_src_type = 'SS'
astr_subsetting_info.subset_step[1].input_type = 'SUBSET'
astr_subsetting_info.subset_step[1].subc_sub_src_case_id = istr_sub_opt.patt_struc.case_id
astr_subsetting_info.subset_step[1].sql_statement = ls_sql
astr_subsetting_info.source_subset_id = istr_sub_opt.patt_struc.subset_id
astr_subsetting_info.subset_step[1].input_id = istr_sub_opt.patt_struc.subset_id

Return	1

end function

public function integer wf_load_subset_options ();//*********************************************************************************
// Script Name:	wf_load_subset_options
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function loads the structure that will be passed to
//						w_subset_options.
//
//						This function is called from ue_subset when the Subset RMM
//						is selected on the Report tab.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	03/12/01	FDG	Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
// 03/26/01	GaryR	Stars 4.7 - Move Stars Server Functionality to w_subset_options.
//
//*********************************************************************************

Boolean	lb_found_tbl

DateTime	ldt_datetime,					&
			ldt_default_datetime

Integer	li_number_tables,				&
			li_patt_idx,					&
			li_rc,							&
			li_sub_index,					&
			li_tbl,							&
			li_upperbound1,				&
			li_upperbound2

String	ls_subset_tables[],			&
			ls_table_id,					&
			ls_compare_keys

sx_subset_options		lstr_sub_opt

// Get the data from istr_sub_opt
ls_subset_tables		=	istr_sub_opt.patt_struc.table_type
ls_table_id				=	istr_sub_opt.patt_struc.subset_table_type

ldt_datetime			=	gnv_app.of_get_server_date_time()
ldt_default_datetime	=	DateTime (Date('01/01/1900'))	

istr_sub_opt.come_from	=	'REPSUB'

li_number_tables	=	UpperBound (is_pattern_tables)

// Reset istr_sub_opt.sub_info[] from the prior execution.
istr_sub_opt.sub_info	=	lstr_sub_opt.sub_info

FOR li_tbl = 1 TO li_number_tables
	// Load the prefixes ('I' and 'S') and tbl types to set up the join with
	// the temp table.
	inv_pattern_sql.uf_clear_from_tables()
	inv_pattern_sql.uf_set_tbl_type ('I', is_pattern_tables[li_tbl] )
	inv_pattern_sql.uf_set_tbl_type ('S', is_pattern_tables[li_tbl] )
	// Get the join on the unique keys (i.e. I.C1_ICN = S.ICN AND I.C1_ICN_LINE_NO = S.ICN_LINE_NO)
	//	The columns in the the temp table have the table type as its prefix (i.e. C1_ICN).
	ls_compare_keys	=	inv_pattern_sql.uf_compare_keys (1, 2)
	// Fill in istr_sub_opt
	istr_sub_opt.sub_info[li_tbl].source_subset_id	=	istr_sub_opt.patt_struc.subset_id
	istr_sub_opt.sub_info[li_tbl].subset_step[1].paid_from_date	=	ldt_default_datetime
	istr_sub_opt.sub_info[li_tbl].subset_step[1].paid_from_date =	ldt_default_datetime
	istr_sub_opt.sub_info[li_tbl].subset_step[1].inv_type	=	is_pattern_tables[li_tbl]
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subset_type	=	ls_table_id

	istr_sub_opt.sub_info[li_tbl].subset_step[1].subc_sub_src_type	=	'SS'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].input_type	=	'ICN'
	istr_sub_opt.sub_info[li_tbl].subset_step[1].input_id	=	istr_sub_opt.patt_struc.subset_id
	istr_sub_opt.sub_info[li_tbl].subset_step[1].subc_sub_src_case_id	=	istr_sub_opt.patt_struc.case_id 
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - Begin
	// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
//	istr_sub_opt.sub_info[li_tbl].subset_step[1].sql_statement = &
//				'SELECT S.* FROM '	+	Upper(is_table_name)	+	&
//				' I,'	+	Upper(STARS2CA.DATABASE)	+	'..SUB_MEDC_' +	&
//				Upper(is_pattern_tables[li_tbl])	+	'_'	+	&
//				istr_sub_opt.patt_struc.subset_id	+	&
//				' S WHERE '	+	ls_compare_keys
	istr_sub_opt.sub_info[li_tbl].subset_step[1].sql_statement = 'SELECT S.* FROM ' + &
				Upper(is_table_name)	+ ' I,' + gnv_sql.of_get_database_prefix( Upper(STARS2CA.DATABASE) )	+ &
				gnv_sql.of_get_subset_prefix() + Upper(is_pattern_tables[li_tbl])	+	'_'	+	&
				istr_sub_opt.patt_struc.subset_id + ' S WHERE '	+	ls_compare_keys
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - End
	istr_sub_opt.sub_info[li_tbl].temp_table_name	=	is_table_name
	istr_sub_opt.sub_info[li_tbl].criteria[1].left_paren	=	' '
	istr_sub_opt.sub_info[li_tbl].criteria[1].expression_one = 'PATTERN'
	istr_sub_opt.sub_info[li_tbl].criteria[1].rel_operator = '='
	istr_sub_opt.sub_info[li_tbl].criteria[1].expression_two = is_pattern_id 
	istr_sub_opt.sub_info[li_tbl].criteria[1].right_paren = ' '
	istr_sub_opt.sub_info[li_tbl].criteria[1].Logical_operator = ' '
	istr_sub_opt.sub_info[li_tbl].criteria[1].data_type = 'CHAR'
NEXT

//For ML subset, include any 'left over' tables not used in pattern
li_upperbound1 = UpperBound (ls_subset_tables)
li_sub_index = 1

DO WHILE li_sub_index <= li_upperbound1    
	IF ls_subset_tables[li_sub_index] <> ''		THEN
		lb_found_tbl = FALSE
      li_upperbound2 = UpperBound (is_pattern_tables)  
		FOR li_patt_idx = 1 TO li_upperbound2    
			IF ls_subset_tables[li_sub_index] = is_pattern_tables[li_patt_idx]		THEN
				lb_found_tbl	=	TRUE
				EXIT
			END IF
		NEXT
		IF lb_found_tbl	=	FALSE		THEN  
			li_rc = wf_add_level (istr_sub_opt.sub_info[li_tbl],	&
										ls_subset_tables[li_sub_index])
			li_tbl ++
		END IF
	END IF
	li_sub_index ++
LOOP

//istr_sub_opt.job_id	=	is_job_id


Return	1

end function

public function integer wf_add_column_headings ();//*********************************************************************************
// Script:		wf_add_column_headings
//
//	Arguments:	None
//
// Returns:		Integer
//					-1	=	Error
//					 0	=	Nothing was changed
//					 1	=	Datawindow syntax was changed
//
//	Description:
//		Since joins occur on itself, it is possible to select the same column
//		name from two different tables (i.e. C1.prov_id & C1.prov_id).  When the
//		datawindow syntax is generated via SyntaxFromSQL(), the column headings
//		for the duplicate column does not get assigned a name.
//
//		This function will scan thru the datawindow syntax and assign a column name
//		for the duplicate column.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long			ll_pos,						&
				ll_beg_pos,					&
				ll_end_pos,					&
				ll_prev_pos,				&
				ll_column
				
String		ls_syntax,					&
				ls_column_name,			&
				ls_error

Constant	String	lcs_column_find = 'text('
Constant	String	lcs_no_header_find = '(band=header'

Boolean		lb_finished = FALSE,		&
				lb_found = FALSE

ls_syntax	=	tab_patt.tabpage_report.dw_report.object.DataWindow.Syntax

ll_prev_pos	=	1

DO WHILE lb_finished = FALSE
	// get the column #
	ll_column ++
	// Get the position of the next column
	ll_beg_pos	=	Pos (ls_syntax, lcs_column_find, ll_prev_pos)
	IF	ll_beg_pos	<	1		THEN
		// Next column not found.  Get out.
		lb_finished	=	TRUE
		Exit
	END IF
	ll_prev_pos	=	ll_beg_pos	+	1
	// Get the end of this column by getting the beginning position
	//	of the next column
	ll_end_pos	=	Pos (ls_syntax, lcs_column_find, ll_beg_pos + 1)
	IF	ll_end_pos	<	1		THEN
		// Reached the last column
		ll_end_pos	=	9999999
	END IF
	// Determine if this column's header has a name
	ll_pos		=	Pos (ls_syntax, lcs_no_header_find, ll_beg_pos + 1)
	IF	ll_pos	>	0					&
	AND ll_pos	<	ll_end_pos		THEN
		// This column's header has no name.  Assign a name to it.
		lb_found	=	TRUE
		//	Get the name of the column
		ls_column_name	=	tab_patt.tabpage_report.dw_report.Describe ("#"	+	String (ll_column)	+	".Name")
		//	Insert the column header name in the datawindow syntax
		ls_syntax		=	Left (ls_syntax, ll_pos)					+	&
								"name="	+	ls_column_name	+	"_t "		+	&
								Mid (ls_syntax, ll_pos + 1)
		
	END IF
LOOP

IF	lb_found	=	TRUE		THEN
	tab_patt.tabpage_report.dw_report.Create (ls_syntax, ls_error)
	Return	1
ELSE
	Return	0
END IF

end function

public function integer wf_dependency ();//*********************************************************************************
// Script Name:	wf_dependency
//
//	Arguments:		None
//
// Returns:			Integer
//
//	Description:	This function is called by event ue_write_subset_tables.  This
//						function will get the main table types used to create the SQL.
//						If a table type used in the SQL is a dependent table (Revenue),
//						then get its main table.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_found

Integer	li_idx,							&
			li_idx2,							&
			li_idx3,							&
			li_idx4,							&
			li_idx5,							&
			li_upper,						&
			li_upper2,						&
			li_upper3,						&
			li_rc

Long		ll_row,							&
			ll_rowcount

String	ls_tbl_type[],					&
			ls_label,						&
			ls_table_type,					&
			ls_col_name,					&
			ls_filter,						&
			ls_tbl_desc

sx_parm	lstr_parm

sx_pattern_tbl_types		lstr_tbl_types

// Get the table types used to create the SQL
lstr_tbl_types	=	inv_pattern_sql.uf_get_sql_tbl_types()
ls_tbl_type		=	lstr_tbl_types.tbl_type
li_upper			=	UpperBound (ls_tbl_type)

ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]
	ls_label			=	Upper (tab_patt.tabpage_criteria.dw_criteria.object.field_description [ll_row])
	ls_table_type	=	tab_patt.tabpage_criteria.dw_criteria.object.field_tbl_type [ll_row]
	IF	IsNull (ls_label)				&
	OR	Trim (ls_label)	=	''		THEN
		Continue
	END IF
	IF	Upper (ls_col_name)	=	'DAYS'			&
	OR	Upper (ls_col_name)	=	'OCCURRENCES'	&
	OR	Upper (ls_col_name)	=	'PROVIDERS'		THEN
		Continue
	ELSE
		li_idx	++
		// Match the table type so that the column description can be saved.
		lb_found	=	FALSE
		FOR	li_idx2	=	1	TO	li_upper
			IF	ls_table_type				=	ls_tbl_type [li_idx2]	THEN
				lb_found	=	TRUE
			END IF
		NEXT
		IF	lb_found		=	FALSE		THEN
			// Main table not found.  Save the column description.
			ls_tbl_desc	=	ls_label
		END IF
	END IF
NEXT

// Loop thru the selected columns to determine if there are any selected revenue columns

ll_rowcount		=	tab_patt.tabpage_custom.dw_selected.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	tab_patt.tabpage_custom.dw_selected.object.elem_name [ll_row]
	ls_label			=	Upper (tab_patt.tabpage_custom.dw_selected.object.elem_desc [ll_row])
	ls_table_type	=	tab_patt.tabpage_custom.dw_selected.object.elem_tbl_type [ll_row]
	lb_found			=	FALSE
	FOR	li_idx2	=	1	TO	li_upper
		IF	ls_table_type				=	ls_tbl_type [li_idx2]	THEN
			lb_found	=	TRUE
		END IF
	NEXT
	IF	lb_found		=	FALSE		THEN
		// Main table not found.  Save the column description.
		ls_tbl_desc	=	ls_label
	END IF
NEXT

li_upper2	=	UpperBound (istr_sub_opt.patt_struc.table_type)

FOR	li_idx	=	1	TO	li_upper
	IF	ls_tbl_type[li_idx]	=	''		THEN
		Continue
	END IF
	// Don't include ls_tbl_type into is_tbl_type if it already exists in is_tbl_type.
	lb_found		=	FALSE
	li_upper3	=	UpperBound (is_tbl_type)
	FOR	li_idx5	=	1	TO	li_upper3
		IF	ls_tbl_type[li_idx]	=	is_tbl_type[li_idx5]		THEN
			lb_found	=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_found	=	TRUE		THEN
		// ls_tbl_type already added to is_tbl_type.
		Continue
	END IF
	// Make sure ls_tbl_type exists in istr_sub_opt.patt_struc.table_type.  If it
	//	doesn't, then ls_tbl_type is a dependent (revenue) table.
	lb_found		=	FALSE
	FOR	li_idx2	=	1	TO	li_upper2
		IF	istr_sub_opt.patt_struc.table_type[li_idx2]	<>	''		&
		AND istr_sub_opt.patt_struc.table_type[li_idx2]	=	ls_tbl_type[li_idx]	THEN
			lb_found	=	TRUE
			li_idx3	=	This.wf_add_is_tbl_type (ls_tbl_type[li_idx])
			Exit
		END IF				
	NEXT									//	li_idx2 = 1	TO	li_upper2
	IF	lb_found	=	FALSE		THEN
		// Main table not found.  Find the main table associated with the dependent table.
		
		ls_filter	=	"id_2 = '"	+	ls_tbl_type[li_idx]	+	"'"
		li_rc	=	ids_dependent_tables.SetFilter ('')
		li_rc	=	ids_dependent_tables.Filter()
		li_rc	=	ids_dependent_tables.SetFilter (ls_filter)
		li_rc	=	ids_dependent_tables.Filter()
		ll_rowcount	=	ids_dependent_tables.RowCount()
		FOR	ll_row	=	1	TO	ll_rowcount
			ls_table_type	=	ids_dependent_tables.object.rel_id [ll_row]
			FOR	li_idx2	=	1	TO	li_upper2
				IF	istr_sub_opt.patt_struc.table_type[li_idx2]	<>	''					&
				AND istr_sub_opt.patt_struc.table_type[li_idx2]	=	ls_table_type	THEN
					li_idx4	++
					lstr_parm.main_tbls[li_idx4]	=	istr_sub_opt.patt_struc.table_type[li_idx2]
					Exit
				END IF
			NEXT							//	FOR li_idx2	=	1	TO	li_upper2
		NEXT								//	ll_row =	1	TO	ll_rowcount
		IF	UpperBound(lstr_parm.main_tbls)	>	1		THEN
			// More than one main table exists for dependent tables.  The user
			//	must select one.  For 'ML' numbered patterns only.
			IF	 is_inv_type		=	'ML'				&
			AND is_pattern_id		<>	ics_generic		THEN
				lstr_parm.dep_tbl		=	ls_tbl_type[li_idx]
				lstr_parm.label		=	ls_tbl_desc
				OpenWithParm (w_invoice_type_selection, lstr_parm)
				IF	Message.StringParm	=	''		THEN
					MessageBox ('Error', 'Unable to determine table type')
					Return	-1
				END IF
				li_idx3	=	This.wf_add_is_tbl_type (Message.StringParm)
			ELSE
				li_idx3	=	This.wf_add_is_tbl_type (lstr_parm.main_tbls[1])
			END IF
		ELSEIF UpperBound(lstr_parm.main_tbls)	=	1		THEN
			li_idx3	=	This.wf_add_is_tbl_type (lstr_parm.main_tbls[1])
		ELSE
			MessageBox ('Error', 'Unable to find the main table type')
			Return	-1
		END IF							//	UpperBound(lstr_parm.main_tbls)	>	1
	END IF								//	lb_found	=	FALSE
NEXT										//	li_idx =	1	TO	li_upper


Return	1

end function

public function integer wf_setup_proc_codes ();//*********************************************************************************
// Script Name:	wf_setup_proc_codes
//
//	Arguments:		None
//
// Returns:			Integer
//						1	=	Success
//
//	Description:	This function is called by event ue_write_subset_tables.
//
//						This code is executed when a user wishes to create a 
//						Pattern 20 report in the background. The purpose of this code 
//						is to extract the three proc code sets from the sql and remove 
//						the parenthesis around each set and the quotes around each 
//						proc code.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_pos,					&
			li_in_pos,				&
			li_l_pos,				&
			li_r_pos

String	ls_sql_stmt

ls_sql_stmt		= 	istr_sub_opt.patt_struc.pattern_sql
li_in_pos		= 	Pos (ls_sql_stmt, ' in')
li_l_pos			= 	Pos (ls_sql_stmt, '(', li_in_pos)
li_r_pos			= 	Pos (ls_sql_stmt, ')', li_in_pos)

// Strip off Parenthesis and first quote and last quote
is_proc_set1	= 	Mid(ls_sql_stmt,li_l_pos + 2,li_r_pos - li_l_pos - 3) + ','
li_pos			=	1

// Loop thru and pull out single quotes	
DO 		
	li_pos = pos(is_proc_set1,"'",li_pos)
	IF li_pos > 0 THEN
		is_proc_set1 = left(is_proc_set1,li_pos - 1) + mid(is_proc_set1,li_pos + 1)
	ELSE
		Exit
	END IF			
LOOP UNTIL li_pos <= 0

li_in_pos		=	Pos (ls_sql_stmt,' in',li_r_pos)
li_l_pos			=	Pos (ls_sql_stmt,'(',li_in_pos)
li_r_pos			=	Pos (ls_sql_stmt,')',li_in_pos)
is_proc_set2	= 	Mid (ls_sql_stmt, li_l_pos + 2, li_r_pos - li_l_pos - 3) + ','
li_pos			=	1

// Loop thru and pull out single quotes	
DO 		
	li_pos = pos(is_proc_set2,"'",li_pos)
	IF li_pos > 0 THEN
		is_proc_set2 = left(is_proc_set2,li_pos - 1) + mid(is_proc_set2,li_pos + 1)
	ELSE
		Exit
	END IF			
LOOP UNTIL li_pos <= 0

li_in_pos		=	Pos (ls_sql_stmt,' in',li_r_pos)
li_l_pos			=	Pos (ls_sql_stmt,'(',li_in_pos)
li_r_pos			=	Pos (ls_sql_stmt,')',li_in_pos)
is_proc_set3	= 	Mid (ls_sql_stmt,li_l_pos + 2,li_r_pos - li_l_pos - 3) + ','
li_pos			=	1

// Loop thru and pull out single quotes	
DO 		
	li_pos		=	Pos (is_proc_set3, "'", li_pos)
	IF li_pos	>	0		THEN
		is_proc_set3	=	Left(is_proc_set3, li_pos - 1) + Mid(is_proc_set3,li_pos + 1)
	ELSE
		Exit
	END IF			
LOOP UNTIL li_pos <= 0



Return 1

end function

public subroutine wf_get_sql_columns ();//*********************************************************************************
// Script Name:	wf_get_sql_columns()
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This function will loop through the columns in dw_report
//						and store the column name in is_sql_col_name[] and the
//						table type in is_sql_tbl_type[].
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/20/00	FDG	Track 2930 (4.5 SP1).  Clear out is_sql_col_name[] and
//						is_sql_tbl_type[].
//	04/30/01	FDG	Stars 4.7.	The column aliases use double-quotes for Oracle.
//										Trim columns for Oracle.
//
//*********************************************************************************

Integer	li_idx,				&
			li_col_count,		&
			li_pos,				&
			li_pos2,				&
			li_pos3

String	ls_sql,				&
			ls_empty[]

// FDG 06/20/00	Begin
is_sql_col_name	=	ls_empty
is_sql_tbl_type	=	ls_empty
// FDG 06/20/00	End

li_pos			=	1

ls_sql			=	istr_sub_opt.patt_struc.pattern_sql

li_col_count	=	Integer (tab_patt.tabpage_report.dw_report.Describe('Datawindow.Column.Count'))

FOR	li_idx	=	1	TO	li_col_count
	li_pos		=	Pos (ls_sql, '.',	li_pos)
	li_pos2		=	Pos (ls_sql, ' ', li_pos)
	// FDG 04/20/01 - The column aliases use double-quotes for Oracle.
	//li_pos3		=	Pos (ls_sql, "'", li_pos)
	li_pos3		=	Pos (ls_sql, '"', li_pos)
	// FDG 04/30/01 - Trim data for Oracle
	is_sql_col_name[li_idx]	=	Trim (Mid (ls_sql, li_pos + 1, li_pos2 - li_pos) )
	is_sql_tbl_type[li_idx]	=	Trim (Mid (ls_sql, li_pos3 + 1, 2) )
	li_pos		=	li_pos3	+	1
NEXT

Return

end subroutine

public function integer wf_labels ();//*********************************************************************************
// Script Name:	wf_labels
//
//	Arguments:		None
//
// Returns:			Integer
//						-1	=	Error
//						 1	=	Success
//
//	Description:	This script will set the labels to dw_report based on what 
//						is in Dictionary.
//
//	Note:				The calling script (ue_view_report) has already issued
//						a SetRedraw (FALSE) to prevent dw_report from redrawing
//						each time a 'Modify' occurs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/27/01	FDG	Stars 4.7.	Make the data types (ls_hold_data_type) DBMS independent.
//	04/30/01	FDG	Stars 4.7.	Remove column borders since their not needed.
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

//  Avg pixels set at 11 for Capital letters in System 10 font; 8 for numbers
Constant	Integer	lci_cap_char_pixels = 11
Constant	Integer	lci_number_pixels = 8
Constant	Integer	lci_max_hdr_hgt = 120
//	FDG 04/27/01 - increase title height from 50 to 100 so that underline is lower.
Constant	Integer	lci_max_col_hgt = 100
Constant	Integer	lci_max_col_y = 50
Constant	Integer	lci_font_weight = 700

//  -10 is font height in points; positive number is in window units.  Always use points.
Constant	Integer	lci_font_height = -10

Constant	String	lcs_title_x_pos = '10'
Constant	String	lcs_title_width = '275'
Constant	String	lcs_font_weight = '700'
Constant	String	lcs_title_height = '36'	

Integer	li_col_len,					&
			li_count,					&
			li_db_col_len,				&
			li_hold_org_pos,			&
			li_idx,						&
			li_org_pos,					&
			li_pos,						&
			li_position,				&
			li_rc,						&
			li_start,					&
			li_textlen

Long		ll_num_of_col

String	ls_cname,					&
			ls_describe,				&
			ls_hold_data_type,		&
			ls_hold_label,				&
			ls_mod_string,				&
			ls_modify,					&
			ls_rc,						&
			ls_text,						&
			ls_text1,					&
			ls_text2,					&
			ls_tlen,						&
			ls_title
			
n_cst_string	lnv_string

// FDG 05/02/01 - Prevent screen flicker & improve performance
tab_patt.tabpage_report.dw_report.SetRedraw (FALSE)

ls_title = 'Subset ID: ' + is_subset_name
ls_mod_string	=	"create text(band=foreground color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'"	+	&
						"  x='"	+	lcs_title_x_pos	+	"' y='2' height='"	+	&
						lcs_title_height	+	"' width= '"	+	lcs_title_width	+	&
						"' text=~'" + ls_title+ "~' "	+	&
						" name=header_t font.face='System' font.height= '-10' font.weight=~'"	+	&
						String (lcs_font_weight)	+	&
						"~' font.family='2' font.pitch='2' font.charset='0' font.italic='0' "	+	&
						" font.strikethrough='0' font.underline='0' background.mode='1' background.color='"	+	&
						String( stars_colors.window_background )	+	"' " + &
						'accessibledescription="~~"Subset ID~~"~~t~~"Subset ID~~"" accessiblename="~~"Subset ID~~"~~t~~"Subset ID~~"" accessiblerole=42 ) '

ls_rc				=	tab_patt.tabpage_report.dw_report.Modify (ls_mod_string)


// Increase header height so can have 2 columns for column labels
ls_rc	=	tab_patt.tabpage_report.dw_report.Modify ("DataWindow.Header.Height="	+	String (lci_max_hdr_hgt))
ll_num_of_col	=	UpperBound (is_sql_col_name)
li_count			=	0


// READ AND PROCESS THE LABELS PARM STRING
FOR	li_idx = 1 TO ll_num_of_col
	ls_cname		= 	'Compute_' + String (li_idx,'0000')	
	
	// Compute the length of the text
	ls_text		=	tab_patt.tabpage_report.dw_report.Describe(ls_cname+'_t.text')
	IF match(ls_text,'~n') THEN
		li_position = pos(ls_text,'~n')
		ls_text1 = left(ls_text,li_position - 1)
		ls_text2 = mid(ls_text,li_position + 1)
		IF len(ls_text1) >= len(ls_text2) THEN
			li_textlen=len(ls_text1)
		ELSEIF len(ls_text2) > len(ls_text1) THEN
			li_textlen = len(ls_text2)
		END IF
	ELSEIF match(ls_text,'~r') THEN
		li_position = pos(ls_text,'~r')
		ls_text1 = left(ls_text,li_position - 1)
		ls_text2 = mid(ls_text,li_position + 1)
		IF len(ls_text1) >= len(ls_text2) THEN
			li_textlen=len(ls_text1)
		ELSEIF len(ls_text2) > len(ls_text1) THEN
			li_textlen = len(ls_text2)
		END IF
	ELSE
		li_textlen = len(ls_text)
	END IF
	//  10 is the avg # of pixels per character, (for BOLD, SYSTEM 10 font).
	li_textlen = li_textlen * lci_cap_char_pixels

	//  Modify the Column Header Label height and 'y' pos, if necessary.
	// FDG 05/02/01 - Concatenate the Modify string
	ls_modify	=	ls_modify	+	ls_cname	+	"_t.height=~'" + String (lci_max_col_hgt) + "~' "	+	&
						ls_cname	+	"_t.y=~'" + String (lci_max_col_y) + "~' "
	
	SELECT ELEM_ELEM_LABEL,ELEM_DATA_LEN,ELEM_DATA_TYPE
	INTO :ls_hold_label,:li_col_len,:ls_hold_data_type
	FROM Dictionary
	where ELEM_type = 'CL' AND
			ELEM_TBL_TYPE = Upper( :is_sql_tbl_type[li_idx] ) AND
			ELEM_NAME = Upper( :is_sql_col_name[li_idx] )
	using stars2ca;
	IF stars2ca.of_check_status() = 100 THEN
		//This modifications are done for colums that are not in the dictionary
		//such as calculated fields
		//  Modify column hdr font height and weight; and col data font height and weight.
		//  Set standard font face and column header underlining.
		// FDG 05/02/01 - Set li_col_len and ls_hold_data_type and fall thru
		// FDG 04/30/01 - remove border
		li_col_len			=	0
		ls_describe			=	ls_cname	+	'.ColType'
		ls_hold_data_type	=	tab_patt.tabpage_report.dw_report.Describe (ls_describe)
	ELSEIF stars2ca.sqlcode <> 0 THEN
		errorbox(stars2ca,'In wf_labels(), error reading the Dictionary Table.')
		Return -1
	END IF

	//  this handles the col # format
	// FDG 04/27/01 - Make ls_hold_data_type DBMS independent
	IF	gnv_sql.of_is_money_data_type (ls_hold_data_type)		THEN
		Setformat(tab_patt.tabpage_report.dw_report,li_idx,'#,##0.00')
		li_db_col_len = 14 * lci_number_pixels
	ELSEIF gnv_sql.of_is_date_data_type (ls_hold_data_type)		THEN
		Setformat(tab_patt.tabpage_report.dw_report,li_idx,'mm/dd/yyyy')
		li_db_col_len = 10 * lci_number_pixels	
	ELSE
		IF	li_col_len	=	0		THEN
			li_col_len	=	15
		END IF
		li_db_col_len = li_col_len * lci_cap_char_pixels
	END IF
	// FDG 04/27/01 end

	//  Set the length to the longest of the col hdr label width or the chars of data in the dict.
	IF li_textlen > li_db_col_len THEN
		//added for patterns to shorten the column labels
		li_pos = 0
		li_start = 1
		do while li_pos < li_db_col_len
			li_org_pos = pos(ls_text,' ',li_start)
			IF li_org_pos <> 0 THEN             //if find blank in label
				li_pos = li_org_pos * lci_cap_char_pixels
				li_hold_org_pos = li_org_pos //to hold orginal pos to build text below
				IF li_pos < li_db_col_len THEN
					li_start = li_org_pos + 1        //continue looking if less
				ELSE
					exit
				END IF
			ELSE
				exit
			END IF
		loop
		IF li_pos > 0 THEN
			//put in new label
			ls_text = left(ls_text,li_hold_org_pos - 1) + '~r' + mid(ls_text,li_hold_org_pos +1)
			// FDG 05/02/01 - Concatenate the Modify string
			ls_modify	=	ls_modify	+	ls_cname	+	"_t.text = '"	+	ls_text	+	"' "
			ls_tlen = String (li_pos + lci_cap_char_pixels)
		ELSE
			ls_tlen = String (li_textlen)
		END IF
	ELSE
		ls_tlen = String (li_db_col_len)
	END IF
	// FDG 05/02/01 - Concatenate the Modify string
	//  Modify column hdr font height and weight; and col data font height and weight.
	//  Set standard font face and column header underlining.
	ls_modify	=	ls_modify	+	ls_cname	+	"_t.border='0'	"									+	&
						ls_cname + '.width= ~''	+	ls_tlen	+	'~''	+	' '						+	&
						ls_cname	+	".font.Height=~'" + String (lci_font_height)	+ "~' "		+	&
						ls_cname	+	".font.Face='System' "												+	&
						ls_cname	+	".font.Face='System' "												+	&
						ls_cname	+	"_t.font.Height=~'" + String (lci_font_height) + "~' "	+	&
						ls_cname	+	"_t.font.Weight=~'" + String (lci_font_weight) + "~' "	+	&
						ls_cname	+	"_t.font.Face='System' "											+	&
						ls_cname	+	"_t.border='0' "
	// FDG 05/02/01	end
	
	//	Set Accessibility Properties
	IF ls_text = "!" THEN Continue
	ls_text = lnv_string.of_clean_string_acc( ls_text )
	ls_text = '"' + ls_text + '"~t"' + ls_text + '"'
	ls_modify += " " + ls_cname + ".AccessibleName='" + ls_text + "'"
	ls_modify += " " + ls_cname + ".AccessibleDescription='" + ls_text + "'"
	ls_modify += " " + ls_cname + ".AccessibleRole='27'"	//	ColumnRole!
	ls_modify += " " + ls_cname + "_t.AccessibleName='" + ls_text + "'"
	ls_modify += " " + ls_cname + "_t.AccessibleDescription='" + ls_text + "'"
	ls_modify += " " + ls_cname + "_t.AccessibleRole='42'"	//	TextRole!
next

// FDG 05/02/01 - Generate the one large modify to dw_report
IF	Len (ls_modify)	>	1		THEN
	ls_rc = tab_patt.tabpage_report.dw_report.Modify(ls_modify)
END IF

tab_patt.tabpage_report.dw_report.SetRedraw (TRUE)
// FDG 05/02/01 end

Return 0
end function

public function integer wf_defaultlevelcolumns ();////////////////////////////////////////////////////////////////////////
//
//	This method will scrutinize the criteria to identify
//	columns that need to be selected or removed from the report.
//
//	Returns	Integer
//					 0	: No criteria
//					 1 : Success
//
////////////////////////////////////////////////////////////////////////
//
//	01/17/03	GaryR	Track 4535c	Allow removal of columns not in criteria
//
////////////////////////////////////////////////////////////////////////

Long		ll_rowcount, ll_row
String	ls_inv_type, ls_inv_types[], ls_main_inv[]
Integer	li_upper, li_ctr, li_main_cnt, li_idx, li_upper2
Boolean	lb_found

li_upper = This.wf_get_crit_invoices( ls_inv_types )
IF li_upper <= 0 THEN Return 0

li_upper2 = UpperBound( is_inv_types )

IF li_upper = li_upper2 THEN
	FOR li_idx = 1 TO li_upper2
		lb_found = FALSE
		FOR li_ctr = 1 TO li_upper
			IF is_inv_types[li_idx] = ls_inv_types[li_ctr] THEN lb_found = TRUE
		NEXT
		IF NOT lb_found THEN EXIT
	NEXT
END IF

IF lb_found THEN Return 1

is_inv_types = ls_inv_types

tab_patt.tabpage_custom.dw_selected.SetRedraw( FALSE )
tab_patt.tabpage_custom.dw_available.SetRedraw( FALSE )
ll_rowcount = tab_patt.tabpage_custom.dw_selected.RowCount()

//	Remove selected rows
FOR ll_row = 1 TO ll_rowcount
	lb_found = FALSE
	ls_inv_type = tab_patt.tabpage_custom.dw_selected.GetItemString( ll_row, "elem_tbl_type" )
	ls_main_inv[1] = ls_inv_type
	li_main_cnt = This.wf_get_main_invoice( ls_main_inv[] )
	IF li_main_cnt < 1 THEN
		ls_main_inv[1] = ls_inv_type
		li_main_cnt = 1
	END IF
	
	FOR li_idx = 1 TO li_main_cnt	
		FOR li_ctr = 1 TO li_upper
			IF ls_main_inv[li_idx] = ls_inv_types[li_ctr] THEN 
				lb_found = TRUE
				EXIT
			END IF
		NEXT	
		IF lb_found THEN EXIT
	NEXT
	
	//	If invoice not found, flag row for removal
	IF NOT lb_found THEN	tab_patt.tabpage_custom.dw_selected.SelectRow( ll_row, TRUE )
NEXT

This.Event	ue_custom_remove()

tab_patt.tabpage_custom.dw_selected.SetRedraw( TRUE )
tab_patt.tabpage_custom.dw_available.SetRedraw( TRUE )

Return 1
end function

public function integer wf_get_main_invoice (ref string as_inv_type[]);////////////////////////////////////////////////////////////////////////
//
//	This method will populate as_inv_type with 
//	main invoices for the passed in dependant (as_inv_type[1])
//
////////////////////////////////////////////////////////////////////////
//
//	01/17/03	GaryR	Track 4535c	Allow removal of columns not in criteria
//
////////////////////////////////////////////////////////////////////////

String	ls_empty[], ls_dependant
Integer	i

IF UpperBound( as_inv_type ) <> 1 THEN Return -1

ls_dependant = as_inv_type[1]
as_inv_type = ls_empty

w_main.dw_stars_rel_dict.SetFilter( "" )
w_main.dw_stars_rel_dict.Filter()
w_main.dw_stars_rel_dict.SetFilter( "rel_type = 'DP' and  id_2 = '" + ls_dependant + "'" )
w_main.dw_stars_rel_dict.Filter()

FOR i = 1 TO w_main.dw_stars_rel_dict.RowCount()
	as_inv_type[i] = w_main.dw_stars_rel_dict.object.rel_id[i]
NEXT

Return UpperBound( as_inv_type )
end function

public function integer wf_get_crit_invoices (ref string as_inv_types[]);////////////////////////////////////////////////////////////////////////
//
//	This method will loop through each row of the 
//	criteria datawindow to identify distinct invoice 
//	types used and populate back to as_inv_types
//
//	Returns	Integer
//					-1 : Error
//					 0	: No criteria
//					>0 : Number of elements in as_inv_types
//
////////////////////////////////////////////////////////////////////////
//
//	01/17/03	GaryR	Track 4535c	Allow removal of columns not in criteria
//
////////////////////////////////////////////////////////////////////////

String	ls_inv_type, ls_inv_types[]
Integer	li_row, li_rowcount, li_upper, li_ctr
Boolean	lb_found

//	Get the rows from criteria DW
li_rowcount = tab_patt.tabpage_criteria.dw_criteria.RowCount()
IF li_rowcount < 1 THEN Return 0

//	Get the distinct invoice 
//	types used in criteria
FOR li_row = 1 TO li_rowcount
	lb_found = FALSE
	ls_inv_type = Trim( tab_patt.tabpage_criteria.dw_criteria.GetItemString( li_row, "column_description" ) )
	IF IsNull( ls_inv_type ) OR ls_inv_type = "" THEN Continue
	ls_inv_type = Left( ls_inv_type, 2 )
	li_upper = UpperBound( ls_inv_types )
	FOR li_ctr = 1 TO li_upper
		IF ls_inv_type = ls_inv_types[li_ctr] THEN 
			lb_found = TRUE
			EXIT
		END IF
	NEXT
	
	IF NOT lb_found THEN
		li_upper ++
		ls_inv_types[li_upper] = ls_inv_type
	END IF
NEXT

as_inv_types = ls_inv_types
Return UpperBound( as_inv_types )
end function

on w_sampling_analysis_new.create
int iCurrent
call super::create
this.tab_patt=create tab_patt
this.dw_3=create dw_3
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_patt
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_2
end on

on w_sampling_analysis_new.destroy
call super::destroy
destroy(this.tab_patt)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event open;call super::open;//*********************************************************************************
// Script Name:	Open
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//
//*********************************************************************************

Integer	li_rc,			&
			li_cntl_no

Long		ll_row

nvo_subset_functions	lnv_subset_functions
sx_subset_ids			lstr_subset_ids	

Datawindowchild	ldwc

//	Create the right-mouse menus (RMM)
im_patt_list		=	CREATE	m_patt_list
im_patt_criteria	=	CREATE	m_patt_criteria
im_patt_options	=	CREATE	m_patt_options
im_patt_timeframe	=	CREATE	m_patt_timeframe
im_patt_custom		=	CREATE	m_patt_custom
im_patt_report		=	CREATE	m_patt_report

// Retrieve the field_description DDDW in dw_criteria.  First, we must determine if 
//	Money/Date columns can be included in the field_description DDDW.  Please note 
//	that the retrieval of ldwc_field_name gets every 'CL' row in dictionary.

SELECT 	Cntl_No
INTO		:li_cntl_no
FROM		Sys_Cntl
WHERE		Cntl_Id = 'PAT-DDLB'
USING		stars2ca;

IF	Stars2ca.of_check_status() <	0		THEN
	MessageBox ('Database Error', 'In w_sampling_analysis_new.open,'		+	&
					' cannot get PAT-DDLB sys_cntl entry')
END IF

IF	li_cntl_no	=	1		THEN
	ib_include_non_string_columns	=	TRUE
END IF


// Create any NVOs used in this window
inv_revenue	=	CREATE	n_cst_revenue

//	Create the NVO to generate the pattern SQL
inv_pattern_sql	=	CREATE	u_nvo_pattern_sql
inv_pattern_sql.uf_set_dw_patt_cntl (tab_patt.tabpage_criteria.dw_patt_cntl)
inv_pattern_sql.uf_set_dw_criteria (tab_patt.tabpage_criteria.dw_criteria)
inv_pattern_sql.uf_set_dw_patt_options (tab_patt.tabpage_options.dw_patt_options)
//inv_pattern_sql.uf_set_dw_available (tab_patt.tabpage_custom.dw_available)  // Done in ue_retrieve_dw_available via ue_postopen
inv_pattern_sql.uf_set_dw_selected (tab_patt.tabpage_custom.dw_selected)
inv_pattern_sql.uf_set_dw_report (tab_patt.tabpage_report.dw_report)
inv_pattern_sql.uf_set_same_column (ics_same_column)

// Retrieve the data for the column_description (dw_criteria) drop-down
This.Event	ue_init_criteria_dddw()

// dw_parms is an external source d/w
ll_row	=	tab_patt.tabpage_list.dw_parms.InsertRow(0)
tab_patt.tabpage_list.dw_parms.ScrollToRow (ll_row)

// dw_timeframe is an external source d/w
ll_row	=	tab_patt.tabpage_timeframe.dw_timeframe.InsertRow(0)
tab_patt.tabpage_timeframe.dw_timeframe.ScrollToRow (ll_row)

// dw_title is an external source d/w
ll_row	=	tab_patt.tabpage_custom.dw_title.InsertRow(0)
tab_patt.tabpage_custom.dw_title.ScrollToRow (ll_row)

// Create the datastore to retrieve/update the case_link data for a pattern.
ids_case_link			=	CREATE	n_ds
ids_case_link.DataObject	=	'd_case_link_patterns'
ids_case_link.SetTransObject (Stars2ca)
ids_case_link.of_SetTrim (TRUE)					// FDG 04/16/01

// Register ids_case_link so it can be included in the ue_save process
This.of_register_datastore (ids_case_link)

// Create the datastore to retrieve/update the columns for a user-defined pattern.
ids_patt_columns					=	CREATE	n_ds
ids_patt_columns.DataObject	=	'd_patt_columns'
ids_patt_columns.SetTransObject (Stars2ca)

// Register ids_patt_columns so it can be included in the ue_save process
This.of_register_datastore (ids_patt_columns)

// Create the datastore to retrieve/update patt_rel for a user-defined pattern.
ids_patt_rel					=	CREATE	n_ds
ids_patt_rel.DataObject		=	'd_patt_rel'
ids_patt_rel.SetTransObject (Stars2ca)

// Register ids_patt_rel so it can be included in the ue_save process
This.of_register_datastore (ids_patt_rel)

// Create the datastore to retrieve the default columns for a pattern template.
ids_patt_field_sel				=	CREATE	n_ds
ids_patt_field_sel.DataObject	=	'd_patt_field_sel'
ids_patt_field_sel.SetTransObject (Stars2ca)

// Create the datastore to import/export notes for a pattern.
// ids_notes is not registered to be included in the ue_save process because
//	embedded SQL will be used to update the notes table.
ids_notes				=	CREATE	n_ds
ids_notes.DataObject	=	'd_notes'
ids_notes.SetTransObject (Stars2ca)

// Create the datastores for importing a Pattern
ids_errors							=	CREATE	n_ds
ids_errors.DataObject			=	'd_import_errors'

ids_summary							=	CREATE	n_ds
ids_summary.DataObject			=	'd_import_pattern_summary'

// Get a handle on each of the DDDWs in dw_timeframe and perform
//	a ShareData on ids_dddw_timeframe.  ids_dddw_timeframe is an
// external source d/w
ids_dddw_timeframe	=	CREATE	n_ds
ids_dddw_timeframe.DataObject	=	'd_dddw_timeframe'

li_rc		=	tab_patt.tabpage_timeframe.dw_timeframe.GetChild ('row1_col1', idwc_row1_col1)
li_rc		=	tab_patt.tabpage_timeframe.dw_timeframe.GetChild ('row1_col2', idwc_row1_col2)
li_rc		=	tab_patt.tabpage_timeframe.dw_timeframe.GetChild ('row2_col1', idwc_row2_col1)
li_rc		=	tab_patt.tabpage_timeframe.dw_timeframe.GetChild ('row2_col2', idwc_row2_col2)
li_rc		=	tab_patt.tabpage_timeframe.dw_timeframe.GetChild ('row3_col1', idwc_row3_col1)
li_rc		=	tab_patt.tabpage_timeframe.dw_timeframe.GetChild ('row3_col2', idwc_row3_col2)

ids_dddw_timeframe.ShareData (idwc_row1_col1)
ids_dddw_timeframe.ShareData (idwc_row1_col2)
ids_dddw_timeframe.ShareData (idwc_row2_col1)
ids_dddw_timeframe.ShareData (idwc_row2_col2)
ids_dddw_timeframe.ShareData (idwc_row3_col1)
ids_dddw_timeframe.ShareData (idwc_row3_col2)

// Get the case ID
IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'		&
OR	istr_sub_opt.patt_struc.come_from	=	'CRITERIA'		THEN
	is_case_id	=	Left (istr_sub_opt.patt_struc.case_id,10)
	is_case_spl	=	Mid (istr_sub_opt.patt_struc.case_id,11,2)
	is_case_ver	=	Mid (istr_sub_opt.patt_struc.case_id,13,2)
ELSEIF istr_sub_opt.patt_struc.come_from = 'SUB_MAINT'	THEN
	is_case_id	=	Left (gc_active_subset_case,10)
	is_case_spl	=	Mid (gc_active_subset_case,11,2)
	is_case_ver	=	Mid (gc_active_subset_case,13,2)
ELSE
	is_case_id	=	Left (gv_active_case,10)
	is_case_spl	=	Mid (gv_active_case,11,2)
	is_case_ver	=	Mid (gv_active_case,13,2)
END IF

// FDG 04/16/01 - begin
is_case_id	=	Trim(is_case_id)
li_rc			=	gnv_sql.of_TrimData (is_case_spl)
li_rc			=	gnv_sql.of_TrimData (is_case_ver)
// FDG 04/16/01 - end

// Get the subset name (is_subset_name based on subset ID & case ID)
inv_subset_functions	=	CREATE	nvo_subset_functions
This.Event	ue_get_subset_name()

// Set the invoice type (and its DDDW) in dw_parms
This.Event	ue_set_inv_type_dddw()

// Determine if the Import RMM is to be enabled.
IF	istr_sub_opt.patt_struc.come_from	=	'SUB_OPT'	THEN
	This.Event	ue_enable_import (FALSE)	// Disable the Import RMM
ELSE
	This.Event	ue_enable_import (TRUE)		// Enable the Import RMM
END IF

// Free up any locks resulting from reading data.
Stars2ca.of_commit()
end event

event ue_retrieve;//*********************************************************************************
// Script Name:	ue_retrieve
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered when the List button on the Library
//						tab is clicked and when the window is opened.  This script will 
//						retrieve the list of patterns and filter out the unwanted
//						patterns based on the search criteria.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	08/20/02	GaryR	Track 2929d	Enhance retrieval performance
//	03/13/03	GaryR	Track 3457d	Retrieve the list instead of filtering
//
//*********************************************************************************

tab_patt.tabpage_list.dw_list.ShareData (tab_patt.tabpage_list.dw_list_desc)

// Retireve data based on what's entered in dw_parms
This.Event	ue_filter_dw_list()

// Commit the changes
Stars2ca.of_commit()



end event

event ue_preopen;//*********************************************************************************
// Script Name:	ue_preopen
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event executes before the Open event.  This script
//						will get the parm passed to this window.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

istr_sub_opt	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

// Resize the controls on a tab
ib_ResizeTabControls	=	TRUE

// Don't repaint the window until the beginning of ue_postopen to
//	prevent flicker when resizing the controls
//This.SetRedraw (FALSE)

// Get a handle on the column description DDDW in dw_criteria.
//li_rc	=	tab_patt.tabpage_criteria.dw_criteria.GetChild ('column_description', idwc_field_name)

// Create the datastore to retrieve the list of available columns in the field DDDW.
// do this in ue_preopen because we want to retrieve ids_field_name in the postopen
//	and the 'Modify' statements in ue_set_window_colors will attempt to retrieve the DDDWs

//ids_field_name						=	CREATE	n_ds
//ids_field_name.DataObject		=	'd_dddw_field_description'
//ids_field_name.SetTransObject (Stars2ca)
//ids_field_name.ShareData (idwc_field_name)

end event

event ue_postopen;//*********************************************************************************
// Script Name:	ue_postopen - Override the ancestor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is posted to after the window opens.  This script
//						overrides the ancestor so that ue_initialize_window does not
//						get Posted to.  Event ue_compare_case_id can possibly close
//						the window.
//
//						This script will retrieve the data required for the 
//						DDDWs in dw_criteria.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	09/21/01	FDG	Stars 4.8.1.	When coming from Case Folder, make sure that the
//						criteria, options and report tabs are enabled.
//	FDG	12/21/01	Track 2497.  Make lnv_case local to prevent memory leaks
//	GaryR	05/21/02	Track 3049d	Problems viewing patterns
// JasonS 10/5/04	Track 5651c remove case requirements
//*********************************************************************************

Integer	li_rc,							&
			li_cntl_no

Long		ll_row,							&
			ll_rowcount,					&
			ll_find_row

String	ls_patt_id,						&
			ls_prev_patt_id,				&
			ls_case,							&
			ls_find

DataWindowChild	ldwc,					&
						ldwc_field_name

// Repaint the window to handle Resize
//This.SetRedraw (TRUE)

This.Event	ue_retrieve_dw_available()

//	Create the NVO to edit for case security when retrieving the list of subsets.
//inv_case	=	CREATE	n_cst_case			// FDG 12/21/01

// Retrieve the data in ids_patt_field_parm
ids_patt_field_parm	=	CREATE	n_ds
ids_patt_field_parm.DataObject	=	'd_patt_field_parm'
ids_patt_field_parm.SetTransObject (Stars2ca)
ids_patt_field_parm.Retrieve()

// Create the datastores used for storing subset information.
ids_bg_sql_line		=	CREATE	n_ds
ids_bg_sql_line.DataObject		=	'd_bg_sql_line'
ids_bg_sql_line.SetTransObject (Stars2ca)

ids_bg_step_cntl		=	CREATE	n_ds
ids_bg_step_cntl.DataObject	=	'd_bg_step_cntl'
ids_bg_step_cntl.SetTransObject (Stars2ca)

// Retrieve the data to get all of the dependent tables.  This is used in wf_dependency()
// in order to create the data for a subset.
ids_dependent_tables	=	CREATE	n_ds
ids_dependent_tables.DataObject	=	'd_dependent_tables'
ids_dependent_tables.SetTransObject (Stars2ca)
ids_dependent_tables.Retrieve()

// Create the datastore used to edit the base types for importing
ids_stars_rel					=	CREATE	n_ds
ids_stars_rel.DataObject	=	'd_stars_rel_dict'
ids_stars_rel.SetTransObject (Stars2ca)
ll_rowcount		=	ids_stars_rel.Retrieve()

IF	istr_sub_opt.patt_struc.come_from	<>	'CRITERIA'	THEN
	// Retrieve the data in the pattern template DDDW, remove duplicate rows, 
	//	and add a blank entry to the beginning of the DDDW.
	li_rc		=	tab_patt.tabpage_list.dw_parms.GetChild ('patt_id', ldwc)
	ldwc.SetTransObject (Stars2ca)
	ll_rowcount	=	ldwc.Retrieve()

	FOR	ll_row	=	1	TO	ll_rowcount
		ls_patt_id	=	ldwc.GetItemstring (ll_row, 'patt_id')
		IF	ls_patt_id	=	ls_prev_patt_id		&
		AND ls_patt_id	<>	''							THEN
			ldwc.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row	--
			ll_rowcount	--
		END IF
		ls_prev_patt_id	=	ls_patt_id
	NEXT
	
	ll_row	=	ldwc.InsertRow(1)
END IF

// If displaying the 'Criteria' (from case folder), the list tab and report tab won't be used 
//	because there is no subset.  All tabs will be display only, and the user cannot save the pattern.
IF	istr_sub_opt.patt_struc.come_from	=	'CRITERIA'		THEN
	ib_disableclosequery	=	TRUE		//	Disable closequery
	is_subset_name	=	'N/A'
	tab_patt.tabpage_list.dw_parms.object.patt_type [1]		=	ics_user_pattern
	This.Event	ue_patt_type_changed (ics_user_pattern, '')
	// Find the pattern in dw_list and hilite it.  Once hilited, perform the 'Select'
	//	script to display the information on the other tabs.
	ll_rowcount	=	tab_patt.tabpage_list.dw_list.RowCount()
	// FDG 04/16/01 - properly trim the data.  Empty string in Oracle = ' '.
	li_rc	=	gnv_sql.of_TrimData (is_case_spl)
	li_rc	=	gnv_sql.of_TrimData (is_case_ver)
	ls_find	=	"patt_id = '"	+	istr_sub_opt.patt_struc.pattern_id		+	&
					"' and case_link_case_id = '"		+	Trim(is_case_id)		+	&
					"' and case_link_case_spl = '"	+	is_case_spl				+	&
					"' and case_link_case_ver = '"	+	is_case_ver				+	"'"	
	ll_find_row	=	tab_patt.tabpage_list.dw_list.Find (ls_find, 1, ll_rowcount)
	IF	ll_find_row		>	0		THEN
		tab_patt.tabpage_list.dw_list.ScrollToRow (ll_find_row)
		tab_patt.tabpage_list.dw_list.Event	ue_singleselect (ll_find_row)
	ELSE
		MessageBox ('Application Error', 'Cannot find pattern: '	+	&
						istr_sub_opt.patt_struc.pattern_id	+	&
						' in w_sampling_analysis_new.ue_postopen.')
		Close (This)
	END IF
	// Select the hilited pattern and display this pattern on the other tabs
	This.Event	ue_select()
	// Disable the list and report tabs, disable all datawindows, and disable any
	//	Save functionality.
	This.Event	ue_enable_link (FALSE)
	This.Event	ue_enable_save (FALSE)
	This.Event	ue_enable_saveas (FALSE)
	//This.Event	ue_enable_export (FALSE)
	This.Event	ue_enable_clear (FALSE)
	tab_patt.tabpage_list.enabled		=	FALSE
	This.Event	ue_enable_report_tab (FALSE)
	// FDG 09/21/01 begin
	tab_patt.tabpage_criteria.enabled	=	TRUE
	tab_patt.tabpage_options.enabled		=	TRUE
	
	//	GaryR	05/21/02	Track 3049d - Begin
	//tab_patt.tabpage_report.enabled		=	TRUE
	tab_patt.tabpage_timeframe.enabled		=	TRUE
	tab_patt.SelectTab( ici_criteria )
	//	GaryR	05/21/02	Track 3049d - End
	
	// FDG 09/21/01 end
	This.Event	ue_edit_enable_prev_next()
	// Disable the contents of each tab.
//	tab_patt.tabpage_criteria.dw_patt_cntl.enabled		=	FALSE
//	tab_patt.tabpage_criteria.dw_criteria.enabled		=	FALSE
//	tab_patt.tabpage_options.dw_patt_options.enabled	=	FALSE
//	tab_patt.tabpage_timeframe.dw_timeframe.enabled		=	FALSE
//	tab_patt.tabpage_custom.dw_title.enabled				=	FALSE
//	tab_patt.tabpage_custom.dw_available.enabled			=	FALSE
//	tab_patt.tabpage_custom.dw_selected.enabled			=	FALSE
	tab_patt.tabpage_criteria.dw_patt_cntl.object.DataWindow.ReadOnly		=	'Yes'
	tab_patt.tabpage_criteria.dw_criteria.object.DataWindow.ReadOnly		=	'Yes'
	tab_patt.tabpage_options.dw_patt_options.object.DataWindow.ReadOnly	=	'Yes'
	tab_patt.tabpage_timeframe.dw_timeframe.object.DataWindow.ReadOnly	=	'Yes'
	tab_patt.tabpage_custom.dw_title.object.DataWindow.ReadOnly				=	'Yes'
	tab_patt.tabpage_custom.dw_available.object.DataWindow.ReadOnly		=	'Yes'
	tab_patt.tabpage_custom.dw_selected.object.DataWindow.ReadOnly			=	'Yes'
	tab_patt.tabpage_custom.cb_custom_add.enabled		=	FALSE
	tab_patt.tabpage_custom.cb_custom_remove.enabled	=	FALSE
	tab_patt.tabpage_custom.cb_custom_up.enabled			=	FALSE
	tab_patt.tabpage_custom.cb_custom_down.enabled		=	FALSE
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// Disable some of the columns in dw_parms because we are defaulting
// to pattern templates.  ue_patt_type_changed will also retrieve the data in dw_list.
// If this window is performing a lookup, then only display user-defined patterns.
IF	istr_sub_opt.patt_struc.come_from	=	'LOOKUP'		THEN
	tab_patt.tabpage_list.dw_parms.object.patt_type [1]		=	ics_user_pattern
	tab_patt.tabpage_list.dw_parms.object.patt_type.protect	=	1
	This.Event	ue_patt_type_changed (ics_user_pattern, '')
	// The list tab is the only available tab
	This.Event	ue_enable_import (FALSE)
	This.Event	ue_enable_delete (FALSE)
	// The Select button and RMM will now say 'Use'
	im_patt_list.m_dummyitem.m_selectpattern.text	=	'&Use Pattern'
	tab_patt.tabpage_list.cb_list_select.text			=	'&Use'
	// Disable CloseQuery
	ib_disableclosequery	=	TRUE
ELSE
	This.Event	ue_patt_type_changed (ics_pattern_template, '')
END IF


w_main.SetMicroHelp ('Ready')



end event

event close;call super::close;//*********************************************************************************
// Script Name:	Close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Destroy any instance objects previously created.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	03/27/01	GaryR	Stars 4.7 - Implement Stars Server Functionality
//	FDG	12/21/01	Track 2497.  Make lnv_case local to prevent memory leaks
//
//*********************************************************************************

IF	IsValid (ids_dddw_timeframe)		THEN
	Destroy	ids_dddw_timeframe
END IF

IF	IsValid (ids_patt_field_parm)		THEN
	Destroy	ids_patt_field_parm
END IF

IF	IsValid (ids_patt_rel)		THEN
	Destroy	ids_patt_rel
END IF

IF	IsValid (ids_dependent_tables)		THEN
	Destroy	ids_dependent_tables
END IF

IF	IsValid (ids_case_link)		THEN
	Destroy	ids_case_link
END IF

IF	IsValid (ids_notes)		THEN
	Destroy	ids_notes
END IF

IF	IsValid (ids_bg_sql_line)		THEN
	Destroy	ids_bg_sql_line
END IF

IF	IsValid (ids_bg_step_cntl)		THEN
	Destroy	ids_bg_step_cntl
END IF

IF	IsValid (ids_patt_columns)		THEN
	Destroy	ids_patt_columns
END IF

IF	IsValid (ids_patt_field_sel)		THEN
	Destroy	ids_patt_field_sel
END IF

IF	IsValid (ids_stars_rel)		THEN
	Destroy ids_stars_rel
END IF

IF	IsValid (inv_revenue)		THEN
	Destroy	inv_revenue
END IF

IF	IsValid (inv_pattern_sql)		THEN
	Destroy	inv_pattern_sql
END IF

IF	IsValid (ids_errors)		THEN
	Destroy	ids_errors
END IF

IF	IsValid (ids_summary)		THEN
	Destroy	ids_summary
END IF

// FDG 12/21/01
//IF	IsValid (inv_case)		THEN
//	Destroy	inv_case
//END IF

IF IsValid (inv_subset_functions)	THEN
	DESTROY	inv_subset_functions
END IF

IF	IsValid (im_patt_list)		THEN
	Destroy	im_patt_list
END IF

IF	IsValid (im_patt_criteria)		THEN
	Destroy	im_patt_criteria
END IF

IF	IsValid (im_patt_options)		THEN
	Destroy	im_patt_options
END IF

IF	IsValid (im_patt_timeframe)		THEN
	Destroy	im_patt_timeframe
END IF

IF	IsValid (im_patt_custom)		THEN
	Destroy	im_patt_custom
END IF

IF	IsValid (im_patt_report)		THEN
	Destroy	im_patt_report
END IF

//	03/27/01	GaryR	Stars 4.7
IF istr_sub_opt.job_sched = 1 THEN	
	gnv_server.of_JobDelete( istr_sub_opt.server_job_id )
END IF
end event

event ue_initialize_window;call super::ue_initialize_window;//*********************************************************************************
// Script Name:	ue_initialize_window
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is triggered after the window is opened, after
//						the data is saved, and when a pattern is selected/imported.
//
//						This script will set the title of the window.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String		ls_orig_title,		&
				ls_pattern_title

ls_pattern_title	=	''
ls_orig_title		=	This.of_get_title()

// Include the pattern ID in the title only if one has been selected
IF	Len (is_user_pattern_id)	>	0		THEN
	ls_pattern_title	=	' Pattern: '	+	is_pattern_name	+	','
END IF

IF	Len (is_pattern_id)	>	0		THEN
	ls_pattern_title	=	ls_pattern_title	+	' Template: '	+	is_pattern_id	+	','
END IF

This.Title	=	ls_orig_title		+	' - '	+	ls_pattern_title	+	&
					' Subset: '			+	is_subset_name		+	&
					', Case: '			+	gv_active_case


end event

event type integer ue_presave();call super::ue_presave;//*********************************************************************************
// Script Name:	ue_presave
//
//	Arguments:		None
//
// Returns:			Integer
//						-1	=	Error.  Don't continue with the Save
//						1	=	Success.  Continue with the Save.
//
//	Description:	Depending on the Save mode (S=Save, A=Save As, L=Link), 
//						open the Save window.
//
//	Note:				The ue_presave event will open the pattern save window depending
//						on the mode set in this event.  Theoretically, the user should
//						never be allowed to link a pattern template. 
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/12/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 10/11/01	FDG	Stars 4.8.1.	Add case_log entry.
//	12/21/01	FDG	Track 2497.  Make lnv_case local to prevent memory leaks
//	01/14/01	GaryR	Track 2556d	Do not reset idw_report_cols when saving the pattern
//
//*********************************************************************************

Boolean	lb_change_mode,		&
			lb_criteria

Integer	li_rc

Long		ll_row,					&
			ll_rowcount,			&
			ll_patt_row,			&
			ll_save_row

String	ls_userid,				&
			ls_link_key,			&
			ls_pattern_id,			&
			ls_patt_desc,			&
			ls_desc,					&
			ls_link_case_id,		&
			ls_field_col_name,	&
			ls_empty,				&
			ls_case_spl, ls_case_ver	//	01/12/01	GaryR	Stars 4.7 DataBase Port
String	ls_message						// FDG 10/11/01

n_ds		lds_save

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

// If the pattern is a filter pattern, display a warning.
li_rc	=	This.Event	ue_edit_save_filter()

IF	li_rc	<	0		THEN
	// User cancelled.
	Return	-1
END IF

// For numbered patterns, at least one line of criteria must exist.

IF	is_pattern_id	<>	ics_generic		THEN
	ll_rowcount		=	tab_patt.tabpage_criteria.dw_criteria.Rowcount()
	FOR	ll_row	=	1	TO	ll_rowcount
		ls_field_col_name		=	tab_patt.tabpage_criteria.dw_criteria.object.field_col_name [ll_row]
		IF	Trim (ls_field_col_name)	>	' '	THEN
			lb_criteria		=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_criteria	=	FALSE		THEN
		// No criteria specified for a numbered pattern
		MessageBox ('Save Error', 'There is no data to save.')
		Return	-1
	END IF
END IF

// Edit the criteria
li_rc		=	This.Event	ue_edit_criteria()
IF	li_rc	<	0		THEN
	Return	li_rc
END IF

IF	is_save_mode	=	'S'		&
OR	is_save_mode	=	'L'		THEN
	// In save or link mode.  Determine if you have to change it
	//	to Save As mode
	li_rc	=	This.Event	ue_edit_save_mode()
END IF				//	is_save_mode	=	'S' OR is_save_mode	=	'L'

// If in Save As mode, create a new case_link, patt_rel, and read the prior notes
//	so the original notes can be copied to the new pattern.  The script to read
// the notes will not read ids_notes if the pattern was just imported.
IF	is_save_mode	=	'A'		THEN
	This.Event	ue_create_case_link()
	This.Event	ue_create_patt_rel()
	This.Event	ue_retrieve_notes()
END IF

// For a generic or filter pattern, make sure the unique key columns are included
// in the selected list.
IF	is_pattern_id	=	ics_generic		&
OR	is_pattern_id	=	ics_filter_pat	THEN
	inv_pattern_sql.ib_reset_report_cols = FALSE	//	01/14/01	GaryR	Track 2556d
	This.Event	ue_select_unique_key_columns()
END IF

// Take the data from dw_selected and load ids_patt_columns (which is being updated)
This.Event	ue_custom_load_patt_columns()

// If in 'Save As' or 'link' mode, open the Query Save window
lds_save		=	CREATE	n_ds
lds_save.DataObject	=	'd_save_pattern'

ll_save_row	=	lds_save.InsertRow(0)

ll_patt_row	=	tab_patt.tabpage_criteria.dw_patt_cntl.GetRow()

IF	ll_patt_row	<	1		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_presave, '	+	&
					'cannot get the current patt_cntl data.  ')
	Return	-1
END IF

ls_patt_desc		=	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_patt_row]
lds_save.object.description [1]			=	ls_patt_desc
lds_save.object.save_ind [1]				=	is_save_mode
lds_save.object.user_id [1]				=	gc_user_id
lds_save.object.pattern_template [1]	=	is_pattern_id

// fill in the invoice type description
ls_desc	=	inv_pattern_sql.uf_get_tbl_desc (is_inv_type)
ls_desc	=	is_inv_type	+	' - '	+	ls_desc
lds_save.object.invoice_type [1]		=	ls_desc

IF	is_save_mode	=	'S'		&
OR	is_save_mode	=	'L'		THEN
	lds_save.object.pattern_id [1]		=	is_user_pattern_id
	lds_save.object.link_name [1]			=	ids_case_link.object.link_name [1]
	lds_save.object.short_desc [1]		=	ids_case_link.object.link_desc [1]
	lds_save.object.create_date [1]		=	ids_case_link.object.link_date [1]
	lds_save.object.case_id [1]			=	Trim (ids_case_link.object.case_id [1]		+	&
														ids_case_link.object.case_spl [1]	+	&
														ids_case_link.object.case_ver [1] )
	ls_link_case_id							=	lds_save.object.case_id [1]
	IF	Trim (lds_save.object.case_id [1])	=	'NONE'		&
	OR	lds_save.object.case_id [1]			=	''				THEN
		lds_save.object.link_ind [1]			=	'N'
	ELSE
		lds_save.object.link_ind [1]			=	'Y'
	END IF
END IF

IF	is_save_mode	=	'L'		THEN
	// Link to the active case and do not open the pattern save window
	is_save_successful_msg	=	'Pattern successfully linked to the active case'
	lds_save.object.case_id [1]	=	gv_active_case
	ls_message		=	"Pattern "	+	is_pattern_name	+	" linked to case."		// FDG 10/11/01
ELSE
	OpenWithParm (w_save_pattern, lds_save)
	lds_save	=	Message.PowerObjectParm
	SetNull (Message.PowerObjectParm)
	ls_pattern_id		=	Upper (lds_save.object.pattern_id [1])		// FDG 04/16/01
	is_pattern_name	=	lds_save.object.link_name [1]
	is_save_successful_msg	=	'Pattern '	+	is_pattern_name	+	' is successfully saved.'
	ls_message		=	"Pattern "	+	is_pattern_name	+	" saved to case."			// FDG 10/11/01
	IF	Upper (ls_pattern_id)	=	'CANCEL'		THEN
		// User canceled the Save/Link.  Get out.
		Return	-1
	END IF
END IF

// FDG 10/11/01 begin

// FDG 12/21/01 begin
n_cst_case		lnv_case		// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case
li_rc			=	lnv_case.uf_audit_log ( lds_save.object.case_id [1], ls_message )

Destroy	lnv_case			// FDG 12/21/01
// FDG 12/21/01 end

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for pattern '	+	is_pattern_name	+	&
					'. Script: '		+	&
					'w_sampling_analysis_new.ue_presave')
	Return	-1
END IF
// FDG 10/11/01 end

// If in 'Save As' mode, get the user-defined pattern ID and load them
//	in the datawindows (ids_case_link, dw_patt_cntl, dw_patt_options, dw_criteria, ids_patt_columns)
//	and change the row status to ensure an SQL insert occurs.
ls_pattern_id	=	Upper (lds_save.object.pattern_id [1])		// FDG 04/16/01

IF	is_save_mode	=	'A'		THEN
	// Update pattern ID on ids_patt_rel
	ids_patt_rel.object.patt_id [1]			=	ls_pattern_id
	// Update pattern ID	on patt_cntl
	tab_patt.tabpage_criteria.dw_patt_cntl.SetItemStatus (ll_patt_row, 0, Primary!, NewModified!)
	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_id [ll_patt_row]		=	ls_pattern_id
	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_type [ll_patt_row]	=	ics_user_pattern
	tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_inv_type [ll_patt_row]	=	is_inv_type
	// Update pattern_id on dw_patt_options
	ll_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()
	tab_patt.tabpage_options.dw_patt_options.SetItemStatus (ll_row, 0, Primary!, NewModified!)
	tab_patt.tabpage_options.dw_patt_options.object.patt_id [ll_row]			=	ls_pattern_id
	tab_patt.tabpage_options.dw_patt_options.object.patt_template [ll_row]	=	is_pattern_id
	// Update pattern ID on dw_criteria
	ll_rowcount	=	tab_patt.tabpage_criteria.dw_criteria.RowCount()
	FOR	ll_row	=	1	TO	ll_rowcount
		tab_patt.tabpage_criteria.dw_criteria.SetItemStatus (ll_row, 0, Primary!, NewModified!)
		tab_patt.tabpage_criteria.dw_criteria.object.patt_id [ll_row]	=	ls_pattern_id
	NEXT
	// Update pattern ID on ids_notes
	ll_rowcount	=	ids_notes.RowCount()
	FOR	ll_row	=	1	TO	ll_rowcount
		ids_notes.object.note_rel_id [ll_row]	=	ls_pattern_id
	NEXT
	This.Event	ue_notes_insert()
END IF

// Update pattern ID on ids_patt_columns.  This is done for both save and save as
//	because ids_patt_columns is refreshed on every update.

ll_rowcount	=	ids_patt_columns.RowCount()
FOR	ll_row	=	1	TO	ll_rowcount
	ids_patt_columns.SetItemStatus (ll_row, 0, Primary!, NewModified!)
	ids_patt_columns.object.patt_id [ll_row]	=	ls_pattern_id
NEXT

// Take the pattern description returned from the save window and update patt_cntl
ls_patt_desc	=	lds_save.object.description [1]
tab_patt.tabpage_criteria.dw_patt_cntl.object.patt_desc [ll_patt_row]	=	ls_patt_desc

// Take the returned data (including is_save_mode = 'L' data) to fill in case_link
ids_case_link.object.link_key [1]		=	ls_pattern_id
ids_case_link.object.link_name [1]		=	lds_save.object.link_name [1]
ids_case_link.object.link_desc [1]		=	lds_save.object.short_desc [1]
ids_case_link.object.link_date [1]		=	lds_save.object.create_date [1]
ids_case_link.object.case_id [1]			=	Left (lds_save.object.case_id [1], 10)

//	01/12/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
ls_case_spl = Mid (lds_save.object.case_id [1], 11, 2)
ls_case_ver = Mid (lds_save.object.case_id [1], 13, 2)
IF Trim( ls_case_spl ) = "" THEN ls_case_spl = ls_empty
IF Trim( ls_case_ver ) = "" THEN ls_case_ver = ls_empty
ids_case_link.object.case_spl [1]		=	ls_case_spl
ids_case_link.object.case_ver [1]		=	ls_case_ver
//	01/12/01	GaryR	Stars 4.7 DataBase Port - End

Destroy	lds_save

Return	1

end event

event ue_postsave;call super::ue_postsave;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_postsave
//
//	Arguments:	None
//
//	Returns:   integer
//	 1 = successful
//	-1 = unsuccessful - Discontinue the save process
//
//	Description:
//		This event is triggered after the save has completed successfully.
//
//		Perform any post-save processing here.  Get the new pattern ID that
//		was set in the ue_presave event.
//
//////////////////////////////////////////////////////////////////////////////

// Link key was set in ue_presave event
is_user_pattern_id	=	ids_case_link.object.link_key [1]

// Determine if the notes picture is to be displayed on the criteria tab.
This.Event	ue_edit_display_notes()

// Reset the notes (from a previous import) so it won't get saved again
This.Event	ue_notes_clear()

// Enable any RMMs that could have been disabled resulting from saving
//	a pattern template into a user-defined pattern
This.Event	ue_enable_link (TRUE)

// Enable/Disable the Next and Prev buttons
This.Event	ue_edit_enable_prev_next()

// Reset the window's title
This.Event	ue_initialize_window()

Return	1

end event

event ue_delete;//*********************************************************************************
// Script Name:	ue_delete
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Delete the pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	10/11/01	FDG	Stars 4.8.1.	Create a case_log entry
//	FDG	12/21/01	Track 2497.  Make lnv_case local to prevent memory leaks
// JasonS 07/17/02 Track 3093d log pattern name when deleteing from a case
// Katie	11/07/07	SPR 5188 Changed ls_patt_id to link_key and not link_name to allow for deletion of 
//						user patterns that were renamed during creation.
//*********************************************************************************

Integer		li_rc,				&
				li_msg

Long			ll_row,				&
				ll_rowcount,		&
				ll_count

String		ls_patt_id,			&
				ls_sql,				&
				ls_count,			&
				ls_delete_msg

u_nvo_count	lnv_count

//	Any necessary edits are placed in ue_predelete.
li_rc	=	This.Event ue_PreDelete ()

IF	li_rc	<	1		THEN
	Return
END IF

li_msg	=	MessageBox ( 'Stars', &
				'Are you sure you want to delete this pattern?', &
				Exclamation!, YesNo!)

CHOOSE CASE li_msg
	CASE 1
		//	Yes - Delete the row
	CASE 2
		// No - Cancel the deletion
		Return
END CHOOSE

w_main.SetMicroHelp ('Deleting Pattern ...')

// All edits passed.  Get the pattern ID to delete.

ll_row	=	tab_patt.tabpage_list.dw_list.GetSelectedRow(0)

// JasonS 07/17/02 - Begin Track 3093d
//ls_patt_id		=	tab_patt.tabpage_list.dw_list.object.patt_id [ll_row]
ls_patt_id		=	tab_patt.tabpage_list.dw_list.object.case_link_link_key [ll_row]
// End - Track 3093d

// FDG 10/11/01	Create a case_log entry

String	ls_message,		&
			ls_case_id,		&
			ls_case_spl,	&
			ls_case_ver

ls_case_id		=	tab_patt.tabpage_list.dw_list.object.case_link_case_id [ll_row]
ls_case_spl		=	tab_patt.tabpage_list.dw_list.object.case_link_case_spl [ll_row]
ls_case_ver		=	tab_patt.tabpage_list.dw_list.object.case_link_case_ver [ll_row]

ls_message	=	"Pattern "	+	ls_patt_id	+	" removed from case."

n_cst_case		lnv_case		// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case

li_rc			=	lnv_case.uf_audit_log ( ls_case_id, ls_case_spl, ls_case_ver, ls_message )

Destroy	lnv_case			// FDG 12/21/01

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for pattern '	+	ls_patt_id	+	&
					'.  Case: ' + ls_case_id + ls_case_spl + ls_Case_ver + '. Script: '		+	&
					'w_sampling_analysis_new.ue_delete')
	Return
END IF

// FDG 10/11/01	end

// Since the hilited Pattern can be different than the selected pattern,
// delete the hilited pattern directly.

ls_sql	=	"delete from case_link where link_key = '"	+	Upper( ls_patt_id )	+	&
				"' and link_type = 'PAT'"
ls_count	=	"select count(*) from case_link where link_key = '"	+	Upper( ls_patt_id )	+	&
				"' and link_type = 'PAT'"

li_rc		=	Stars2ca.of_execute (ls_sql)

IF	li_rc	<	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
					'cannot delete case_link')
	Stars2ca.of_rollback ()
	w_main.SetMicroHelp ('Ready')
	Return
END IF

ls_sql	=	"delete from notes where note_rel_id = '"	+	Upper( ls_patt_id	) +	&
				"' and note_rel_type = 'PA'"

li_rc		=	Stars2ca.of_execute (ls_sql)

IF	li_rc	<	0		THEN
	MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
					'cannot delete notes')
	Stars2ca.of_rollback ()
	w_main.SetMicroHelp ('Ready')
	Return
END IF

// Only delete from the remaining tables if no more case_link rows exists.

lnv_count	=	CREATE	u_nvo_count
ll_count		=	lnv_count.uf_get_count (ls_count)
DESTROY	lnv_count

IF	ll_count	>	0		THEN
	ls_delete_msg	=	'This pattern has been deleted from this case.  This pattern '	+	&
							'is also linked to other cases.'
ELSE
	// No more links exist.  Delete the entire pattern.
	ls_delete_msg	=	'Pattern deleted successfully.'
	ls_sql	=	"delete from patt_cntl where patt_id = '"	+	Upper( ls_patt_id )	+	"'"
	li_rc		=	Stars2ca.of_execute (ls_sql)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
						'cannot delete patt_cntl')
		Stars2ca.of_rollback ()
		w_main.SetMicroHelp ('Ready')
		Return
	END IF
	ls_sql	=	"delete from patt_rel where patt_id = '"	+	Upper( ls_patt_id )	+	"'"
	li_rc		=	Stars2ca.of_execute (ls_sql)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
						'cannot delete patt_rel')
		Stars2ca.of_rollback ()
		w_main.SetMicroHelp ('Ready')
		Return
	END IF
	ls_sql	=	"delete from patt_criteria where patt_id = '"	+	Upper( ls_patt_id )	+	"'"
	li_rc		=	Stars2ca.of_execute (ls_sql)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
						'cannot delete patt_criteria')
		Stars2ca.of_rollback ()
		w_main.SetMicroHelp ('Ready')
		Return
	END IF
	ls_sql	=	"delete from patt_columns where patt_id = '"	+	Upper( ls_patt_id	) +	"'"
	li_rc		=	Stars2ca.of_execute (ls_sql)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
						'cannot delete patt_columns')
		Stars2ca.of_rollback ()
		w_main.SetMicroHelp ('Ready')
		Return
	END IF
	ls_sql	=	"delete from patt_options where patt_id = '"	+	Upper( ls_patt_id )	+	"'"
	li_rc		=	Stars2ca.of_execute (ls_sql)
	IF	li_rc	<	0		THEN
		MessageBox ('Application Error', 'In w_sampling_analysis_new.ue_delete, '	+	&
						'cannot delete patt_options')
		Stars2ca.of_rollback ()
		w_main.SetMicroHelp ('Ready')
		Return
	END IF
END IF

Stars2ca.of_commit()

IF	ls_patt_id	=	is_user_pattern_id		THEN
	// Hilited pattern matches the selected pattern.  Clear out the
	//	selected pattern and disable all tabs associated with the
	//	previously selected pattern.
	This.Event	ue_clear_dws()
	tab_patt.tabpage_criteria.enabled	=	FALSE
	tab_patt.tabpage_options.enabled		=	FALSE
	tab_patt.tabpage_timeframe.enabled	=	FALSE
	tab_patt.tabpage_custom.enabled		=	FALSE
	tab_patt.tabpage_report.enabled		=	FALSE
	is_pattern_id								=	''
	This.Event	ue_initialize_window()
END IF

// Remove the row from dw_list
tab_patt.tabpage_list.dw_list.RowsDiscard (ll_row, ll_row, Primary!)

// Set the Count box on the Library tab
ll_rowcount		=	tab_patt.tabpage_list.dw_list.RowCount()
tab_patt.tabpage_list.st_count_list.text	=	String (ll_rowcount)

w_main.SetMicroHelp (ls_delete_msg)

tab_patt.tabpage_list.dw_list.SetRedraw (TRUE)




end event

event ue_predelete;call super::ue_predelete;//*********************************************************************************
// Script Name:	ue_predelete
//
//	Arguments:		N/A
//
// Returns:			Integer
//						 1	=	Continue with the delete
//						-1	=	Error.  Don't continue with the delete
//
//	Description:	This event is triggered when deleting a user-defined pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,					&
			ll_link_row

String	ls_userid,				&
			ls_link_key,			&
			ls_patt_id,				&
			ls_patt_type,			&
			ls_user_pattern_id

ll_row	=	tab_patt.tabpage_list.dw_list.GetSelectedRow(0)

IF	ll_row	=	0		THEN
	MessageBox ('Error', 'There are no highlighted patterns to delete.')
	Return	-1
END IF

ls_patt_id		=	tab_patt.tabpage_list.dw_list.object.patt_id [ll_row]
ls_patt_type	=	tab_patt.tabpage_list.dw_list.object.patt_type [ll_row]
ls_userid		=	tab_patt.tabpage_list.dw_list.object.user_id [ll_row]

IF	ls_patt_type	<>	ics_user_pattern		THEN
	// Cannot delete a pattern template.
	MessageBox ('Error', 'Only user defined patterns can be deleted.')
	Return	-1
END IF

ll_link_row	=	ids_case_link.Retrieve (ls_patt_id)

ls_userid	=	ids_case_link.object.user_id [ll_link_row]
ls_link_key	=	ids_case_link.object.link_key [ll_link_row]

IF	ls_userid	<>	gc_user_id		&
AND gv_user_sl	<>	'AD'				THEN
	// User IDs don't match and this user is not an administrator.  Cannot delete this pattern.
	MessageBox ('Error', 'This pattern cannot be deleted because it belongs to another user.')
	Return	-1
END IF


Return	1

end event

event activate;call super::activate;//*********************************************************************************
// Script Name:	Activate
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is always triggered when the window becomes active.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//
//*********************************************************************************

// Save the current state of the menu items
ib_showsql	=	m_stars_30.m_file.m_showsql.enabled

m_stars_30.m_file.m_showsql.enabled		=	FALSE

end event

event deactivate;call super::deactivate;//*********************************************************************************
// Script Name:	Deactivate
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event is always triggered when the window becomes inactive.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//
//*********************************************************************************

// Restore the menu items to its current state
m_stars_30.m_file.m_showsql.enabled	=	ib_showsql




end event

event ue_open_rmm;call super::ue_open_rmm;//*********************************************************************************
// Script Name:	ue_open_rmm
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This event will open the appropriate right-mouse menu (RMM).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
//
//*********************************************************************************

Integer	li_tab

IF gnv_app.of_get_lock() THEN Return

li_tab	=	tab_patt.SelectedTab

CHOOSE CASE	li_tab
	CASE	ici_list
		IF	IsValid (im_patt_list)	THEN
			im_patt_list.m_dummyitem.PopMenu (This.pointerx() + 5, This.pointery() + 20)
		END IF
	CASE	ici_criteria
		IF	IsValid (im_patt_criteria)	THEN
			im_patt_criteria.m_dummyitem.PopMenu (This.pointerx() + 5, This.pointery() + 20)
		END IF
	CASE	ici_options
		IF	IsValid (im_patt_options)	THEN
			im_patt_options.m_dummyitem.PopMenu (This.pointerx() + 5, This.pointery() + 20)
		END IF
	CASE	ici_timeframe
		IF	IsValid (im_patt_timeframe)	THEN
			im_patt_timeframe.m_dummyitem.PopMenu (This.pointerx() + 5, This.pointery() + 20)
		END IF
	CASE	ici_customize
		IF	IsValid (im_patt_custom)	THEN
			im_patt_custom.m_dummyitem.PopMenu (This.pointerx() + 5, This.pointery() + 20)
		END IF
	CASE	ici_report
		IF	IsValid (im_patt_report)	THEN
			im_patt_report.m_dummyitem.PopMenu (This.pointerx() + 5, This.pointery() + 20)
		END IF
END CHOOSE


end event

event ue_save;//*********************************************************************************
// Script Name:	ue_save - Override the ancestor
//
//	Arguments:		None
//
// Returns:			Integer
//						-1	=	Error.  Don't continue with the Save
//						1	=	Success.  Continue with the Save.
//
//	Description:	Set a flag stating that a pattern is being saved.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc

ib_save		=	TRUE

li_rc			=	Super::Event	ue_save()

ib_save		=	FALSE

Return	li_rc

end event

type tab_patt from tab within w_sampling_analysis_new
event rbuttonup pbm_rbuttonup
string accessiblename = "Tabs"
string accessibledescription = "Tabs"
accessiblerole accessiblerole = clientrole!
integer y = 20
integer width = 2885
integer height = 1592
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean showpicture = false
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_list tabpage_list
tabpage_criteria tabpage_criteria
tabpage_options tabpage_options
tabpage_timeframe tabpage_timeframe
tabpage_custom tabpage_custom
tabpage_report tabpage_report
end type

event rbuttonup;//*********************************************************************************
// Script Name:	tab_patt.rbuttonup
//
//	Arguments:		N/A
//
// Returns:			N/A	
//
//	Description:	Open the right-mouse menu
//		
//
//*********************************************************************************
//	
// 10/01/99 FDG	Created
//
//*********************************************************************************

Parent.Event	ue_open_rmm()

end event

on tab_patt.create
this.tabpage_list=create tabpage_list
this.tabpage_criteria=create tabpage_criteria
this.tabpage_options=create tabpage_options
this.tabpage_timeframe=create tabpage_timeframe
this.tabpage_custom=create tabpage_custom
this.tabpage_report=create tabpage_report
this.Control[]={this.tabpage_list,&
this.tabpage_criteria,&
this.tabpage_options,&
this.tabpage_timeframe,&
this.tabpage_custom,&
this.tabpage_report}
end on

on tab_patt.destroy
destroy(this.tabpage_list)
destroy(this.tabpage_criteria)
destroy(this.tabpage_options)
destroy(this.tabpage_timeframe)
destroy(this.tabpage_custom)
destroy(this.tabpage_report)
end on

event key;//*********************************************************************************
// Script Name:	tab_patt.Key
//
//	Arguments:		N/A
//
// Returns:			N/A	
//
//	Description:	If F12 is pressed, open the right-mouse menu
//		
//
//*********************************************************************************
//	
// 10/01/99 FDG	Created
//
//*********************************************************************************

IF	KeyDown (KeyF12!)	THEN
	Parent.Event	ue_open_rmm()
END IF


end event

event selectionchanged;//*********************************************************************************
// Script Name:	tab_patt.SelectionChanged
//
//	Arguments:		N/A
//
// Returns:			N/A	
//
//	Description:	Depending on which tab is clicked, set idw_print.  If the 
//						Report Tab is clicked, generate the report.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Created
//	06/13/00	FDG	Track 2923c (4.5 SP1).  If the criteria tab was clicked, get
//						the first available row that has an unprotected 'column description'.
//						For this row, filter the drop-down.
//	01/17/03	GaryR	Track 4535c	Allow removal of columns not in criteria
//
//*********************************************************************************


//	For ML, load default columns only for invoices used in criteria
IF oldindex = ici_criteria AND is_inv_type = "ML" AND is_pattern_id = ics_generic THEN Parent.wf_DefaultLevelColumns()

CHOOSE CASE newindex
	CASE ici_list
		Parent.of_SetPrintDW (tabpage_list.dw_list)
		Parent.of_set_st_count (tabpage_list.st_count_list)
		This.tabpage_list.dw_parms.SetFocus()
		This.tabpage_list.dw_parms.SetColumn ('patt_type')
		w_main.SetMicroHelp ('Ready')
	CASE ici_options
		ib_options_tab	=	TRUE
		This.tabpage_options.dw_patt_options.SetFocus()
		This.tabpage_options.dw_patt_options.SetColumn('day_ind')
		w_main.SetMicroHelp ('Ready')
	CASE ici_criteria
		Long			ll_row,			&
						ll_rowcount
		String		ls_protect
		This.tabpage_criteria.dw_criteria.SetFocus()
		This.tabpage_criteria.dw_criteria.SetColumn('column_description')
		// FDG 06/13/00	Begin
		ll_rowcount	=	This.tabpage_criteria.dw_criteria.RowCount()
		FOR	ll_row	=	1	TO	ll_rowcount
			ls_protect	=	This.tabpage_criteria.dw_criteria.object.protect_ind [ll_row]
			IF	Upper (ls_protect)	<>	'Y'	THEN
				This.tabpage_criteria.dw_criteria.ScrollToRow (ll_row)
				Parent.Event	ue_filter_criteria_dddw (ll_row)
				Exit
			END IF
		NEXT
		// FDG 06/13/00	End
		This.tabpage_criteria.dw_criteria.SetRedraw (TRUE)
		w_main.SetMicroHelp ('Ready')
	CASE ici_report
		Parent.of_SetPrintDW (tabpage_report.dw_report)
		Parent.of_set_st_count (tabpage_report.st_count)
		Parent.Event	ue_view_report()
	CASE	ici_timeframe
		This.tabpage_timeframe.dw_timeframe.SetFocus()
		This.tabpage_timeframe.dw_timeframe.SetColumn('from_date_ind')
	CASE	ELSE
		w_main.SetMicroHelp ('Ready')
END CHOOSE

// If the window operations window is opened, close it.
IF	IsValid (iw_uo_win)		THEN
	Close (iw_uo_win)
END IF
end event

event selectionchanging;
Integer		li_rc

// Issue an Accepttext on each d/w

li_rc	=	Parent.Event	ue_accepttext (Parent.Control, TRUE)

IF	li_rc	<	0		THEN
	// Prevent the tab from selecting the new tab.
	Return	1
END IF

end event

type tabpage_list from userobject within tab_patt
string accessiblename = "Library"
string accessibledescription = "Library"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 2848
integer height = 1464
long backcolor = 67108864
string text = "Library"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
uo_list_rmm uo_list_rmm
dw_parms dw_parms
dw_list dw_list
dw_list_desc dw_list_desc
st_count_list st_count_list
cb_list_list cb_list_list
cb_list_select cb_list_select
cb_list_next cb_list_next
cb_list_close cb_list_close
end type

on tabpage_list.create
this.gb_2=create gb_2
this.uo_list_rmm=create uo_list_rmm
this.dw_parms=create dw_parms
this.dw_list=create dw_list
this.dw_list_desc=create dw_list_desc
this.st_count_list=create st_count_list
this.cb_list_list=create cb_list_list
this.cb_list_select=create cb_list_select
this.cb_list_next=create cb_list_next
this.cb_list_close=create cb_list_close
this.Control[]={this.gb_2,&
this.uo_list_rmm,&
this.dw_parms,&
this.dw_list,&
this.dw_list_desc,&
this.st_count_list,&
this.cb_list_list,&
this.cb_list_select,&
this.cb_list_next,&
this.cb_list_close}
end on

on tabpage_list.destroy
destroy(this.gb_2)
destroy(this.uo_list_rmm)
destroy(this.dw_parms)
destroy(this.dw_list)
destroy(this.dw_list_desc)
destroy(this.st_count_list)
destroy(this.cb_list_list)
destroy(this.cb_list_select)
destroy(this.cb_list_next)
destroy(this.cb_list_close)
end on

type gb_2 from groupbox within tabpage_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 5
integer y = 16
integer width = 2830
integer height = 400
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

type uo_list_rmm from uo_tabpage_rmm within tabpage_list
string accessiblename = "Library Tab"
string accessibledescription = "Library Tab"
integer y = 28
integer width = 2848
integer height = 1444
integer taborder = 70
end type

on uo_list_rmm.destroy
call uo_tabpage_rmm::destroy
end on

type dw_parms from u_dw within tabpage_list
string accessiblename = "Search Criteria on Library Tab"
string accessibledescription = "Search Criteria on Library Tab"
integer x = 59
integer y = 88
integer width = 2766
integer height = 304
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pattern_parms"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;//*********************************************************************************
// Script Name:	dw_parms.itemchanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	If the invoice type changed, filter the "pattern template" DDDW.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer							li_rc
String							ls_old_patt_type
w_sampling_analysis_new		lw_parent

li_rc	=	This.of_GetParentWindow(lw_parent)

CHOOSE CASE dwo.name
	CASE 'invoice_type'
		lw_parent.Event	ue_filter_patterns (data)
	CASE 'patt_type'
		// Must post the event because the data is being re-retrieved.  The
		//	retrieval script (ue_retrieve) issues an accepttext to this d/w.
		ls_old_patt_type	=	This.object.patt_type [row]
		lw_parent.Post	Event	ue_patt_type_changed (data, ls_old_patt_type)
		Return	0
	CASE 'patt_desc'
		//	If the original data is not empty, retrieve dw_list.
		// Must post the event because the data is being re-retrieved.  The
		//	retrieval script (ue_retrieve) issues an accepttext to this d/w.
		IF	this.object.patt_desc [row]	<>	''		THEN
			lw_parent.Post	Event	ue_retrieve ()
			Return	0
		END IF
END CHOOSE

// Filter dw_list based on the entered data.
lw_parent.Post	Event		ue_filter_dw_list()

end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_parms.constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	D/W doesn't have update capability
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

This.of_SetUpdateable (FALSE)

end event

type dw_list from u_dw within tabpage_list
string accessiblename = "Pattern List"
string accessibledescription = "Pattern List"
integer x = 5
integer y = 428
integer width = 2830
integer height = 720
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pattern_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_list.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Set the transaction object and allow highlighting of rows.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	11/21/00	FDG	Stars 4.7	Make dw_list DBMS-independent
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	01/16/02	GaryR	Track 2688d The join logic is resolved by the datawindow object.
//
//*********************************************************************************

//This.of_set_dw_dbms()		// FDG 11/21/00 - Call this before SetTransObject	//	01/16/02	GaryR	Track 2688d

This.SetTransObject (Stars2ca)

// Be able to highlight rows
This.of_SingleSelect (TRUE)

This.of_SetUpdateable (FALSE)

//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)


end event

event doubleclicked;//*********************************************************************************
// Script Name:	dw_list.DoubleClicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Invoke the Window Operations.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

IF	row	>	0		THEN
	IF	IsValid (iw_uo_win)				THEN
		IF iw_uo_win.visible	=	TRUE	THEN
			lw_parent.of_window_operations (This, row, dwo)
		ELSE
			lw_parent.Event	ue_select()
		END IF
	ELSE
		lw_parent.Event	ue_select()
	END IF
ELSE
	lw_parent.of_window_operations (This, row, dwo)
END IF


end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_list.rowfocuschanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	dw_list and dw_list_desc share data.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	09/21/01	FDG	Stars 4.8.1.	User Pattern cannot be deleted if its associated
//						case is closed or deleted.
//	12/21/01	FDG	Track 2497.  Make lnv_case local to prevent memory leaks
//	01/11/02	GaryR	Track 2663d	GPF occurs when there are no rows in the DataWindow
//	02/06/02	FDG	Track 2792.  A display filter causes rows between this d/w and
//						dw_list_desc to be out of sync.
//	08/28/02	GaryR	Track 2792d	currentrow is null from Window Operations
//
//*********************************************************************************

//	08/28/02	GaryR	Track 2792d
currentrow = This.GetRow()

// FDG 09/21/01	begin
//	GaryR	01/11/02	Track 2663
//IF	currentrow	=	0		THEN
IF	currentrow	=	0 OR This.RowCount() < 1 THEN
	Return
END IF

IF	currentrow	>	0		THEN
	// FDG 02/06/02 begin
	String	ls_find,		&
				ls_patt_id
	Long		ll_find_row,	&
				ll_rowcount
	ll_rowcount	=	tab_patt.tabpage_list.dw_list_desc.RowCount()
	ls_patt_id	=	This.object.patt_id [currentrow]
	ls_find		=	"patt_id = '"	+	ls_patt_id	+	"'"
	ll_find_row	=	tab_patt.tabpage_list.dw_list_desc.Find (ls_find, 1, ll_rowcount)
	IF	ll_find_row	>	0		THEN
		tab_patt.tabpage_list.dw_list_desc.ScrollToRow (ll_find_row)
	END IF
	// FDG 02/06/02 end
END IF

w_sampling_analysis_new		lw_parent

String	ls_patt_type,			&
			ls_case_id,				&
			ls_case_spl,			&
			ls_case_ver

Integer	li_rc

Boolean	lb_valid_case

li_rc		=	This.of_GetParentWindow (lw_parent)

ls_patt_type	=	This.object.patt_type [currentrow]
ls_case_id		=	This.object.case_link_case_id [currentrow]
ls_case_spl		=	This.object.case_link_case_spl [currentrow]
ls_case_ver		=	This.object.case_link_case_ver [currentrow]

IF	ls_patt_type	=	ics_user_pattern		THEN
	// User defined pattern
	n_cst_case		lnv_case		// FDG 12/21/01
	lnv_case	=	CREATE	n_cst_case	// FDG 12/21/01
	lb_valid_case	=	lnv_case.uf_edit_case_closed (ls_case_id, ls_case_spl, ls_case_ver)
	Destroy	lnv_case			// FDG 12/21/01
	IF	lb_valid_case		THEN
		lw_parent.Event	ue_enable_delete (TRUE)
	ELSE
		lw_parent.Event	ue_enable_delete (FALSE)
	END IF
ELSE
	// Pattern template - disable deletes of pattern templates.
	lw_parent.Event	ue_enable_delete (FALSE)
END IF
// FDG 09/21/01	end



end event

type dw_list_desc from u_dw within tabpage_list
string accessiblename = "Pattern List Description"
string accessibledescription = "Pattern List Description"
integer x = 5
integer y = 1164
integer width = 2830
integer height = 168
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pattern_list_desc"
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_list_desc.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This d/w is not updateable.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	11/21/00	FDG	Stars 4.7	Make dw_list_desc DBMS-independent
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	01/16/02	GaryR	Track 2688d The join logic is resolved by the datawindow object.
//
//*********************************************************************************

//This.of_set_dw_dbms()		// FDG 11/21/00 - Call this before SetTransObject	//	01/16/02	GaryR	Track 2688d

This.of_SetUpdateable (FALSE)

//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)


end event

type st_count_list from statictext within tabpage_list
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 105
integer y = 1356
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_list_list from u_cb within tabpage_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 1115
integer y = 1348
integer taborder = 30
boolean bringtotop = true
string text = "&List"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_list_list
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Retrieve the list of patterns based on the data in dw_parms.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_retrieve()

end event

type cb_list_select from u_cb within tabpage_list
string accessiblename = "Select"
string accessibledescription = "Select"
integer x = 1467
integer y = 1348
integer taborder = 40
boolean bringtotop = true
string text = "&Select"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_list_select
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Select the highlighted pattern and display the appropriate
//						tabs.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_select()

end event

type cb_list_next from u_cb within tabpage_list
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2167
integer y = 1348
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string text = "&Next"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_list_next
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the next tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_next_tabpage()

end event

type cb_list_close from u_cb within tabpage_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 1348
integer taborder = 60
boolean bringtotop = true
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_list_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Close the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

// If this window was performing a lookup, then close this window and
//	return an empty string.
IF	istr_sub_opt.patt_struc.come_from	=	'LOOKUP'		THEN
	CloseWithReturn (lw_parent, '')
ELSE
	Close (lw_parent)
END IF


end event

type tabpage_criteria from userobject within tab_patt
string accessiblename = "Criteria"
string accessibledescription = "Criteria"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 2848
integer height = 1464
boolean enabled = false
long backcolor = 67108864
string text = "Criteria"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_1 gb_1
gb_3 gb_3
cbx_not cbx_not
dw_patt_cntl dw_patt_cntl
cb_criteria_clear cb_criteria_clear
cb_criteria_next cb_criteria_next
cb_criteria_prev cb_criteria_prev
cb_criteria_close cb_criteria_close
pb_notes pb_notes
dw_criteria dw_criteria
uo_criteria_rmm uo_criteria_rmm
end type

on tabpage_criteria.create
this.gb_1=create gb_1
this.gb_3=create gb_3
this.cbx_not=create cbx_not
this.dw_patt_cntl=create dw_patt_cntl
this.cb_criteria_clear=create cb_criteria_clear
this.cb_criteria_next=create cb_criteria_next
this.cb_criteria_prev=create cb_criteria_prev
this.cb_criteria_close=create cb_criteria_close
this.pb_notes=create pb_notes
this.dw_criteria=create dw_criteria
this.uo_criteria_rmm=create uo_criteria_rmm
this.Control[]={this.gb_1,&
this.gb_3,&
this.cbx_not,&
this.dw_patt_cntl,&
this.cb_criteria_clear,&
this.cb_criteria_next,&
this.cb_criteria_prev,&
this.cb_criteria_close,&
this.pb_notes,&
this.dw_criteria,&
this.uo_criteria_rmm}
end on

on tabpage_criteria.destroy
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.cbx_not)
destroy(this.dw_patt_cntl)
destroy(this.cb_criteria_clear)
destroy(this.cb_criteria_next)
destroy(this.cb_criteria_prev)
destroy(this.cb_criteria_close)
destroy(this.pb_notes)
destroy(this.dw_criteria)
destroy(this.uo_criteria_rmm)
end on

type gb_1 from groupbox within tabpage_criteria
string accessiblename = "Fields"
string accessibledescription = "Fields"
accessiblerole accessiblerole = groupingrole!
integer x = 50
integer y = 524
integer width = 2720
integer height = 616
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Fields"
end type

type gb_3 from groupbox within tabpage_criteria
string accessiblename = "Pattern Description"
string accessibledescription = "Pattern Description"
accessiblerole accessiblerole = groupingrole!
integer x = 50
integer y = 24
integer width = 2715
integer height = 460
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Pattern Description"
end type

type cbx_not from u_cbx within tabpage_criteria
boolean visible = false
string accessiblename = "NOT IN"
string accessibledescription = "NOT IN"
integer x = 27
integer y = 1188
integer width = 329
integer height = 100
integer taborder = 80
boolean bringtotop = true
string text = "&NOT IN"
end type

type dw_patt_cntl from u_dw within tabpage_criteria
string accessiblename = "Pattern Control"
string accessibledescription = "Pattern Control"
integer x = 187
integer y = 152
integer width = 2496
integer height = 240
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_patt_cntl"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_patt_cntl.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Set the transaction object.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/16/01	FDG	Stars 4.7.	In Oracle, empty string = ' '.
//
//*********************************************************************************

This.SetTransObject (Stars2ca)

// FDG 04/16/01 - In Oracle, empty string = ' '.
This.of_SetTrim (TRUE)

end event

type cb_criteria_clear from u_cb within tabpage_criteria
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1467
integer y = 1348
integer taborder = 30
boolean bringtotop = true
string text = "C&lear"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_criteria_clear
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Clear out and reinitialize the criteria.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_format_criteria()

end event

type cb_criteria_next from u_cb within tabpage_criteria
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2167
integer y = 1348
integer taborder = 40
boolean bringtotop = true
string text = "&Next"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_criteria_next
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the next tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_next_tabpage()

end event

type cb_criteria_prev from u_cb within tabpage_criteria
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 1815
integer y = 1348
integer taborder = 50
boolean bringtotop = true
string text = "&Prev"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_criteria_prev
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the previous tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_prev_tabpage()

end event

type cb_criteria_close from u_cb within tabpage_criteria
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 1348
integer taborder = 60
boolean bringtotop = true
string text = "&Close"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_criteria_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Close the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

Close (lw_parent)

end event

type pb_notes from u_pb within tabpage_criteria
boolean visible = false
string accessiblename = "Notes"
string accessibledescription = "Notes"
integer x = 539
integer y = 1180
integer width = 137
integer height = 108
integer taborder = 70
boolean bringtotop = true
string picturename = "script1.bmp"
alignment htextalign = center!
vtextalign vtextalign = vcenter!
end type

event clicked;//*********************************************************************************
// Script Name:	pb_notes
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the notes list window for this pattern.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_notes()

end event

type dw_criteria from u_dw within tabpage_criteria
string accessiblename = "Pattern Criteria"
string accessibledescription = "Pattern Criteria"
integer x = 69
integer y = 604
integer width = 2619
integer height = 492
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_patt_criteria"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;//*********************************************************************************
// Script Name:	dw_criteria.itemchanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	If column field_description changed, determine if the timeframe
//						tab can be enabled, fill the timeframe DDDWs, and modify the
//						column name.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	10/08/02	GaryR	SPR 2893d	Text sensitive search in DropDowns
//  10/8/09 RickB LKP.650.5678.005 Added code to clear the values when field selection changes
//
//*********************************************************************************

Integer		li_rc

Long			ll_row,				&
				ll_rowcount

String		ls_find,				&
				ls_tbl_type,		&
				ls_col_name,		&
				ls_field_lookup,	&
				ls_desc,				&
				ls_temp_col_name

w_sampling_analysis_new		lw_parent

li_rc	=	This.of_GetParentWindow (lw_parent)

CHOOSE CASE dwo.name
	CASE ics_column_description
		//	10/08/02	GaryR	SPR 2893d - Begin
		IF IsNull( data) OR Trim( data ) = "" THEN
			This.SetText( "" )
			This.SetFocus()
			Return 0
		ELSE
			This.object.field_value [row] = ""
		END IF
		
		
		//	Get the column name and tbl type from the DDDW
		DataWindowChild	ldwc
		li_rc		=	This.GetChild ('column_description', ldwc)
		ls_find	=	"Trim( column_description ) = '"	+	Trim( data ) +	"'"
		ll_row	=	ldwc.Find (ls_find, 0, ldwc.RowCount() )
		IF	ll_row < 1 THEN
			MessageBox( "Error", "Selected column (" + data + ") not in the list." + &
										"~n~rPlease select a valid column from the list." )
			Return 1
		END IF
		//	10/08/02	GaryR	SPR 2893d - End
		
		// Save the original tbl_type and col_name in case an edit error occurs
		ls_tbl_type	=	This.object.field_tbl_type [row]
		ls_col_name	=	This.object.field_col_name [row]
		ls_desc		=	This.object.field_description [row]
		// Set tbl_type and col_name based on the selected value of field_description
		This.object.field_tbl_type [row]		=	ldwc.GetItemString (ll_row, 'elem_tbl_type')
		This.object.field_col_name [row]		=	ldwc.GetItemString (ll_row, 'elem_name')
		This.object.field_description [row]	=	ldwc.GetItemString (ll_row, 'elem_desc')
		This.object.field_lookup [row]		=	ldwc.GetItemString (ll_row, 'elem_lookup_type')
		// Compare this value to the other field_description values
		IF	is_pattern_id	=	ics_generic		THEN
			li_rc	=	lw_parent.Event	ue_edit_generic_criteria (row, dwo.name, data)
		ELSE
			li_rc	=	lw_parent.Event	ue_edit_custom_criteria (row, dwo.name, data)
		END IF
		IF	li_rc	<	0		THEN
			// Reset tbl_type and col_name back to its original value and reject this data
			This.object.field_tbl_type [row]		=	ls_tbl_type
			This.object.field_col_name [row]		=	ls_col_name
			This.object.field_description [row]	=	ls_desc
			Return	1
		END IF
		//	For Patterns 6,7,8,9,10,11,12,14,20, set every criteria row to the same value
		CHOOSE CASE	is_pattern_id
			CASE	ics_patt6, ics_patt7, ics_patt8, ics_patt9, ics_patt10, ics_patt11,	&
					ics_patt12, ics_patt14, ics_patt20
				ll_rowcount		=	This.RowCount()
				FOR	ll_row	=	1	TO	ll_rowcount
					ls_temp_col_name	=	Upper (This.object.field_col_name [ll_row])
					IF	ls_temp_col_name	=	'DAYS'			&
					OR	ls_temp_col_name	=	'OCCURRENCES'	&
					OR	ls_temp_col_name	=	'PROVIDERS'		THEN
						// Don't overlay these columns 
						Continue
					END IF
					This.object.column_description [ll_row]	=	data
					This.object.field_tbl_type [ll_row]			=	This.object.field_tbl_type [row]
					This.object.field_col_name [ll_row]			=	This.object.field_col_name [row]
					This.object.field_description [ll_row]		=	This.object.field_description [row]
					This.object.field_lookup [ll_row]			=	This.object.field_lookup [row]
				NEXT
		END CHOOSE
		// Determine if the Time Frame tab is to be enabled and fill in the DDDWs for dw_timeframe.
		lw_parent.Post	Event	ue_edit_timeframe_tab()
	CASE ics_field_operator
		// If a column is being compared against itself, then this column can only be certain values.
		li_rc	=	lw_parent.Event	ue_edit_field_operator (row, data)
		IF	li_rc	<	0		THEN
			Return	1
		END IF
		// Determine if the Time Frame tab is to be enabled and fill in the DDDWs for dw_timeframe.
		lw_parent.Post	Event	ue_edit_timeframe_tab()
	CASE ics_field_value
		// Edit the field value to determine if a column is being compared against itself.
		li_rc	=	lw_parent.Event	ue_edit_field_value (row, data)
		IF	li_rc	<	0		THEN
			Return	1
		END IF
		// Determine if the Time Frame tab is to be enabled and fill in the DDDWs for dw_timeframe.
		lw_parent.Post	Event	ue_edit_timeframe_tab()
END CHOOSE


end event

event itemfocuschanged;call super::itemfocuschanged;//*********************************************************************************
// Script Name:	dw_criteria.ItemFocusChanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	If the original pattern is a filter pattern and the column
//						receiving focus is 'field_value', then select (highlight)
//						the value in 'field_value' starting with the 2nd byte.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

String	ls_text, ls_modify

IF row < 1 OR Lower( dwo.name ) <> "field_value" THEN Return

IF	is_pattern_id	=	ics_filter_pat		THEN
	ls_text	=	This.object.field_value [row]
	This.SelectText (2, Len (ls_text) - 1)
END IF

ls_text = Trim( This.GetItemString( row, "field_lookup" ) )
IF ls_text > "" THEN
	//	Set Accessibility Properties
	ls_text = This.GetItemString( row, "column_description" )
	ls_text = '"Lookup Field - ' + ls_text + '"~t"Lookup Field - ' + ls_text + '"'
	ls_modify = "field_value.Tag='LOOKUP'"
ELSE
	//	Reset Accessibility Properties
	ls_text = '"Value/Field"~t"Value/Field"'
	ls_modify = "field_value.Tag=''"
END IF

ls_modify += " field_value.AccessibleName='" + ls_text + "'"
ls_modify += " field_value.AccessibleDescription='" + ls_text + "'"
This.Modify( ls_modify )
end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_criteria.RowfocusChanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Filter the entries in the field_description DDDW for this row.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_rc

IF	currentrow	>	0		THEN
	This.ScrollToRow (currentrow)
END IF

//	Performed in clicked event
//w_sampling_analysis_new		lw_parent
//
//IF	is_pattern_id	<>	ics_generic		&
//AND is_pattern_id	<>	''					THEN
//	li_rc		=	This.of_GetParentWindow (lw_parent)
//	lw_parent.Event	ue_filter_criteria_dddw (currentrow)
//END IF

end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_criteria.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Set the transaction object.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/16/01	FDG	Stars 4.7.	Properly trim the data.  In Oracle, empty string = ' '
//	10/08/02	GaryR	SPR 2893d	Text sensitive search in DropDowns
//
//*********************************************************************************

Integer		li_rc

Long			ll_row

Datawindowchild	ldwc

This.SetTransObject (Stars2ca)

// FDG 04/16/01 - In Oracle, empty string = ' '.
This.of_SetTrim (TRUE)

//	10/08/02	GaryR	SPR 2893d
This.of_SetDropDownSearch( TRUE )

// Insert a row into the DDDW because the DDDW has retrieval arguments.
//	This will prevent the PowerBuilder 'Retrieval Arguments' window
// from displaying.

li_rc	=	This.GetChild ('column_description', ldwc)

ll_row	=	ldwc.InsertRow(0)





end event

event itemerror;call super::itemerror;//*********************************************************************************
// Script Name:	dw_criteria.itemerror
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Return 1 to prevent the PowerBuilder default error message from
//						displaying.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	1

end event

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	dw_criteria.Clicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Filter the entries in the field_description DDDW for this row.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/13/00	FDG	Track 2923c (4.5 SP1).  Only filter the DDDW if that was the
//						column that was clicked (dwo.name = 'column_description').
//
//*********************************************************************************

Integer		li_rc

w_sampling_analysis_new		lw_parent

IF	is_pattern_id	<>	ics_generic		&
AND is_pattern_id	<>	''					&
AND dwo.name		=	'column_description'	THEN
	li_rc		=	This.of_GetParentWindow (lw_parent)
	lw_parent.Event	ue_filter_criteria_dddw (row)
END IF

end event

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

String	ls_value
Integer	li_row
w_sampling_analysis_new		lw_parent

This.AcceptText()
li_row = This.GetRow()
IF li_row < 1 OR Lower( as_col ) <> "field_value" THEN Return

ls_value						=	This.object.field_value [li_row]
IF NOT gnv_app.of_is_filter_name( ls_value ) THEN
	// Determine if a code lookup is required.
	This.of_GetParentWindow (lw_parent)
	lw_parent.Post	Event	ue_code_lookup (ls_value, li_row)
END IF
end event

event ue_dblclick;call super::ue_dblclick;//*********************************************************************************
// Script Name:	dw_criteria.ue_dblclick
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	If the original pattern is a filter pattern and the column
//						being double-clicked is 'field_value', then set 'field_value'
//						to the current filter ID.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/25/04	GaryR	Track 4042d	Allow filters across all patterns
//	01/05/05	GaryR	Track 4216d	Do not check for @ as first character
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

Integer	li_row
String	ls_col

li_row = This.GetRow()
ls_col = This.GetColumnName()
	
IF li_row < 1 OR Lower( ls_col ) <> "field_value" THEN Return
This.object.field_value [li_row]	=	'@'	+	gv_active_filter
end event

event ue_lookup_filter;call super::ue_lookup_filter;//*********************************************************************************
// Script Name:	ue_lookup_filter
//
//	Arguments:		as_col	-	The lookup column
//
// Returns:			None
//
//	Description:	Determine if a filter lookup is required in dw_criteria for 
//						a filter pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

Integer		li_row
String		ls_col_name,		&
				ls_tbl_type,		&
				ls_data_type
sx_filter_data		lstr_filter_data

li_row = This.GetRow()
IF Lower( as_col ) <> "field_value" OR li_row < 1 THEN Return

ls_col_name	=	This.object.field_col_name [li_row]
ls_tbl_type	=	This.object.field_tbl_type [li_row]

IF	IsNull (ls_col_name)		&
OR	Trim( ls_col_name )		=	''		THEN
	MessageBox ('Error', 'Please select a field before performing a filter lookup.')
	Return
END IF

Select	elem_data_type
Into		:ls_data_type
From		Dictionary
Where		elem_type		=	'CL'
  And		elem_tbl_type	=	Upper( :ls_tbl_type )
  And		elem_name		=	Upper( :ls_col_name )
Using		Stars2ca ;

IF	Stars2ca.of_check_status()	<>	0		THEN
	MessageBox ("Database Error", "In w_sampling_analysis_new.dw_criteria.ue_filter_lookup, dictionary "	+	&
					"error retrieving data type.  Where: elem_type = 'CL', elem_tbl_type = '"		+	&
					ls_tbl_type	+	"', elem_name = '"	+	ls_col_name	+	"'.")
	Return
END IF

SetNull(lstr_filter_data.sx_window)
SetNull(lstr_filter_data.sx_button)
lstr_filter_data.sx_entry_mode	=	'USE'
lstr_filter_data.sx_col_name		=	ls_data_type

OpenwithParm (w_filter_list_response, lstr_filter_data)

IF gv_active_filter <> '' THEN
	This.object.field_value [li_row]	=	'@'	+	gv_active_filter
END IF
end event

event ue_lookup_cell;call super::ue_lookup_cell;//*********************************************************************************
// Script Name:	dw_criteria.ue_lookup_cell
//
//	Arguments:		as_col
//						al_row
//
// Returns:			N/A
//
//	Description:	If field_description is right-clicked, then display the
//						description of the column.  
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/25/04	GaryR	Track 4042d	Allow filters across all patterns
//	05/19/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Lower( as_col ) = "column_description" THEN
	// Display the description of 'field_description'
	gv_element_name			=	This.object.field_col_name [al_row]
	gv_element_table_type	=	This.object.field_tbl_type [al_row]
	Open (w_dwlabel_definition)
END IF
end event

type uo_criteria_rmm from uo_tabpage_rmm within tabpage_criteria
string accessiblename = "Criteria Tab"
string accessibledescription = "Criteria Tab"
integer y = 4
integer width = 2848
integer height = 1468
integer taborder = 90
end type

on uo_criteria_rmm.destroy
call uo_tabpage_rmm::destroy
end on

type tabpage_options from userobject within tab_patt
string accessiblename = "Options"
string accessibledescription = "Options"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 2848
integer height = 1464
boolean enabled = false
long backcolor = 67108864
string text = "Options"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_options_rmm uo_options_rmm
dw_patt_options dw_patt_options
cb_options_clear cb_options_clear
cb_options_next cb_options_next
cb_options_prev cb_options_prev
cb_options_close cb_options_close
end type

on tabpage_options.create
this.uo_options_rmm=create uo_options_rmm
this.dw_patt_options=create dw_patt_options
this.cb_options_clear=create cb_options_clear
this.cb_options_next=create cb_options_next
this.cb_options_prev=create cb_options_prev
this.cb_options_close=create cb_options_close
this.Control[]={this.uo_options_rmm,&
this.dw_patt_options,&
this.cb_options_clear,&
this.cb_options_next,&
this.cb_options_prev,&
this.cb_options_close}
end on

on tabpage_options.destroy
destroy(this.uo_options_rmm)
destroy(this.dw_patt_options)
destroy(this.cb_options_clear)
destroy(this.cb_options_next)
destroy(this.cb_options_prev)
destroy(this.cb_options_close)
end on

type uo_options_rmm from uo_tabpage_rmm within tabpage_options
string accessiblename = "Options Tab"
string accessibledescription = "Options Tab"
integer x = 14
integer y = 16
integer width = 2848
integer height = 1444
integer taborder = 60
end type

on uo_options_rmm.destroy
call uo_tabpage_rmm::destroy
end on

type dw_patt_options from u_dw within tabpage_options
string accessiblename = "Options"
string accessibledescription = "Options"
integer x = 201
integer y = 256
integer width = 2290
integer height = 572
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_patt_options"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	dw_patt_options.ItemChanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	If the day_ind changed, then post the event to determine
//						whether or not to enable the timeframe tab.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

CHOOSE CASE dwo.name
	CASE 'day_ind'
		w_sampling_analysis_new		lw_parent
		Integer	li_rc
		
		li_rc	=	This.of_GetParentWindow (lw_parent)
		lw_parent.Post	Event	ue_edit_timeframe_tab()
END CHOOSE

end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_patt_options.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Set the transaction object.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/16/01	FDG	Stars 4.7.	In Oracle, empty string = ' '.
//
//*********************************************************************************

This.SetTransObject (Stars2ca)

// FDG 04/16/01 - In Oracle, empty string = ' '.
This.of_SetTrim (TRUE)

end event

type cb_options_clear from u_cb within tabpage_options
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1467
integer y = 1348
integer taborder = 20
boolean bringtotop = true
string text = "C&lear"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_options_clear
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Clear and re-initialize the data on the Options tab
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_clear_options_tab()

end event

type cb_options_next from u_cb within tabpage_options
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2167
integer y = 1348
integer taborder = 30
boolean bringtotop = true
string text = "&Next"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_options_next
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the next tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_next_tabpage()

end event

type cb_options_prev from u_cb within tabpage_options
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 1815
integer y = 1348
integer taborder = 40
boolean bringtotop = true
string text = "&Prev"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_options_prev
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the previous tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_prev_tabpage()

end event

type cb_options_close from u_cb within tabpage_options
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 1348
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_options_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Close the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

Close (lw_parent)

end event

type tabpage_timeframe from userobject within tab_patt
string accessiblename = "Time Frame"
string accessibledescription = "Time Frame"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 2848
integer height = 1464
boolean enabled = false
long backcolor = 67108864
string text = "Time Frame"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_timeframe_rmm uo_timeframe_rmm
dw_timeframe dw_timeframe
cb_timeframe_clear cb_timeframe_clear
cb_timeframe_next cb_timeframe_next
cb_timeframe_prev cb_timeframe_prev
cb_timeframe_close cb_timeframe_close
end type

on tabpage_timeframe.create
this.uo_timeframe_rmm=create uo_timeframe_rmm
this.dw_timeframe=create dw_timeframe
this.cb_timeframe_clear=create cb_timeframe_clear
this.cb_timeframe_next=create cb_timeframe_next
this.cb_timeframe_prev=create cb_timeframe_prev
this.cb_timeframe_close=create cb_timeframe_close
this.Control[]={this.uo_timeframe_rmm,&
this.dw_timeframe,&
this.cb_timeframe_clear,&
this.cb_timeframe_next,&
this.cb_timeframe_prev,&
this.cb_timeframe_close}
end on

on tabpage_timeframe.destroy
destroy(this.uo_timeframe_rmm)
destroy(this.dw_timeframe)
destroy(this.cb_timeframe_clear)
destroy(this.cb_timeframe_next)
destroy(this.cb_timeframe_prev)
destroy(this.cb_timeframe_close)
end on

type uo_timeframe_rmm from uo_tabpage_rmm within tabpage_timeframe
string accessiblename = "Timeframe Tab"
string accessibledescription = "Timeframe Tab"
integer x = 14
integer y = 12
integer width = 2839
integer height = 1440
integer taborder = 60
end type

on uo_timeframe_rmm.destroy
call uo_tabpage_rmm::destroy
end on

type dw_timeframe from u_dw within tabpage_timeframe
string accessiblename = "Time Frame"
string accessibledescription = "Time Frame"
integer x = 224
integer y = 188
integer width = 2478
integer height = 856
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pattern_timeframe_parms"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;//*********************************************************************************
// Script Name:	dw_timeframe.itemchanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Based on the changed data, modify the corresponding data
//						in tabpage_options.dw_patt_options.  Then trigger the script
//						to update istr_pattern_info accordingly.
//
//	Notes:			1.	There is no need to protect/unprotect data in this d/w
//							because the d/w object will handle this automatically.
//						2.	The 4th radiobutton (Professional within Facility (UB92) 
//							Service Stay) is only allowed if one of the columns is
//							a 1500 base type and another is UB92.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	10/09/02	GaryR	SPR 3349d	Clear out old params when option changes
//
//*********************************************************************************

Integer	li_rc,				&
			li_button

Long		ll_row,				&
			ll_find_row

DataWindowChild	ldwc

String	ls_tbl_type,		&
			ls_find,				&
			ls_field,			&
			ls_column,			&
			ls_row4_desc

ls_find	=	"description = '"	+	data	+	"'"

ll_row	=	tab_patt.tabpage_options.dw_patt_options.GetRow()

CHOOSE CASE dwo.name
	CASE 'from_date_ind'
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_from_thru [ll_row]	=	data
	CASE 'button'
		li_button		=	Integer (data)
		ls_row4_desc	=	Upper ( This.object.row4_desc [row] )
		IF	 li_button		=	4			&
		AND ls_row4_desc	=	'NO'		THEN
			// Reject the value, but don't display a message.
			Return	1
		END IF
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_button [ll_row]	=	Integer (data)
		
		//	10/09/02	GaryR	SPR 3349d - Begin
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]	=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]	=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]		=	''
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]	=	0
		//	10/09/02	GaryR	SPR 3349d - End
	CASE 'row1_col1'
		li_rc	=	This.GetChild (dwo.name, ldwc)
		ll_find_row	=	ldwc.Find (ls_find, 1, ldwc.RowCount() )
		IF	ll_find_row	<	1		THEN
			MessageBox ('Application Error', 'In w_sampling_analysis_new.dw_timeframe, '	+	&
							'could not find row in column row1_col1.  Find = '	+	ls_find	+	'.')
			Return	1
		END IF
		ls_tbl_type	=	ldwc.GetItemString (ll_find_row, 'tbl_type')
		ls_field		=	ldwc.GetItemString (ll_find_row, 'field')
		ls_column	=	ldwc.GetItemString (ll_find_row, 'column')
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]	=	ls_tbl_type
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row]		=	ls_field
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]	=	ls_column
	CASE 'row1_col2'
		li_rc	=	This.GetChild (dwo.name, ldwc)
		ll_find_row	=	ldwc.Find (ls_find, 1, ldwc.RowCount() )
		IF	ll_find_row	<	1		THEN
			MessageBox ('Application Error', 'In w_sampling_analysis_new.dw_timeframe, '	+	&
							'could not find row in column row1_col2.  Find = '	+	ls_find	+	'.')
			Return	1
		END IF
		ls_tbl_type	=	ldwc.GetItemString (ll_find_row, 'tbl_type')
		ls_field		=	ldwc.GetItemString (ll_find_row, 'field')
		ls_column	=	ldwc.GetItemString (ll_find_row, 'column')
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]	=	ls_tbl_type
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]		=	ls_field
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]	=	ls_column
	CASE 'row1_days'
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]	=	Long (data)
	CASE 'row2_col1'
		li_rc	=	This.GetChild (dwo.name, ldwc)
		ll_find_row	=	ldwc.Find (ls_find, 1, ldwc.RowCount() )
		IF	ll_find_row	<	1		THEN
			MessageBox ('Application Error', 'In w_sampling_analysis_new.dw_timeframe, '	+	&
							'could not find row in column row2_col1.  Find = '	+	ls_find	+	'.')
			Return	1
		END IF
		ls_tbl_type	=	ldwc.GetItemString (ll_find_row, 'tbl_type')
		ls_field		=	ldwc.GetItemString (ll_find_row, 'field')
		ls_column	=	ldwc.GetItemString (ll_find_row, 'column')
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]	=	ls_tbl_type
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row]		=	ls_field
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]	=	ls_column
	CASE 'row2_col2'
		li_rc	=	This.GetChild (dwo.name, ldwc)
		ll_find_row	=	ldwc.Find (ls_find, 1, ldwc.RowCount() )
		IF	ll_find_row	<	1		THEN
			MessageBox ('Application Error', 'In w_sampling_analysis_new.dw_timeframe, '	+	&
							'could not find row in column row2_col2.  Find = '	+	ls_find	+	'.')
			Return	1
		END IF
		ls_tbl_type	=	ldwc.GetItemString (ll_find_row, 'tbl_type')
		ls_field		=	ldwc.GetItemString (ll_find_row, 'field')
		ls_column	=	ldwc.GetItemString (ll_find_row, 'column')
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]	=	ls_tbl_type
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]		=	ls_field
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]	=	ls_column
	CASE 'row2_days'
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]	=	Long (data)
	CASE 'row3_col1'
		li_rc	=	This.GetChild (dwo.name, ldwc)
		ll_find_row	=	ldwc.Find (ls_find, 1, ldwc.RowCount() )
		IF	ll_find_row	<	1		THEN
			MessageBox ('Application Error', 'In w_sampling_analysis_new.dw_timeframe, '	+	&
							'could not find row in column row3_col1.  Find = '	+	ls_find	+	'.')
			Return	1
		END IF
		ls_tbl_type	=	ldwc.GetItemString (ll_find_row, 'tbl_type')
		ls_field		=	ldwc.GetItemString (ll_find_row, 'field')
		ls_column	=	ldwc.GetItemString (ll_find_row, 'column')
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_1 [ll_row]	=	ls_tbl_type
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_1 [ll_row]		=	ls_field
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_1 [ll_row]	=	ls_column
	CASE 'row3_col2'
		li_rc	=	This.GetChild (dwo.name, ldwc)
		ll_find_row	=	ldwc.Find (ls_find, 1, ldwc.RowCount() )
		IF	ll_find_row	<	1		THEN
			MessageBox ('Application Error', 'In w_sampling_analysis_new.dw_timeframe, '	+	&
							'could not find row in column row3_col2.  Find = '	+	ls_find	+	'.')
			Return	1
		END IF
		ls_tbl_type	=	ldwc.GetItemString (ll_find_row, 'tbl_type')
		ls_field		=	ldwc.GetItemString (ll_find_row, 'field')
		ls_column	=	ldwc.GetItemString (ll_find_row, 'column')
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_tbl_type_2 [ll_row]	=	ls_tbl_type
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_field_2 [ll_row]		=	ls_field
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_column_2 [ll_row]	=	ls_column
	CASE 'row3_days'
		tab_patt.tabpage_options.dw_patt_options.object.timeframe_num_of_days [ll_row]	=	Long (data)
END CHOOSE

// Move the data from dw_patt_options to istr_pattern_info.timeframe
w_sampling_analysis_new		lw_parent
li_rc		=	This.of_GetParentWindow (lw_parent)
lw_parent.Post	Event	ue_update_timeframe_structure()


end event

event itemerror;call super::itemerror;//*********************************************************************************
// Script Name:	dw_timeframe.itemerror
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Prevent the standard d/w error message from displaying.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	1

end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_timeframe.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Set the transaction object.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

This.SetTransObject (Stars2ca)

This.of_SetUpdateable (FALSE)


end event

type cb_timeframe_clear from u_cb within tabpage_timeframe
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1467
integer y = 1348
integer taborder = 20
boolean bringtotop = true
string text = "C&lear"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_timeframe_clear
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Clear and re-initialize the data on the Timeframe tab
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_clear_timeframe_data()

end event

type cb_timeframe_next from u_cb within tabpage_timeframe
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2167
integer y = 1348
integer taborder = 30
boolean bringtotop = true
string text = "&Next"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_timeframe_next
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the next tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_next_tabpage()

end event

type cb_timeframe_prev from u_cb within tabpage_timeframe
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 1815
integer y = 1348
integer taborder = 40
boolean bringtotop = true
string text = "&Prev"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_timeframe_prev
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the previous tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_prev_tabpage()

end event

type cb_timeframe_close from u_cb within tabpage_timeframe
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 1348
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_timeframe_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Close the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

Close (lw_parent)

end event

type tabpage_custom from userobject within tab_patt
string accessiblename = "Customize Report"
string accessibledescription = "Customize Report"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 2848
integer height = 1464
boolean enabled = false
long backcolor = 67108864
string text = "Customize Report"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_custom_rmm uo_custom_rmm
dw_title dw_title
st_1 st_1
st_2 st_2
dw_available dw_available
dw_selected dw_selected
cb_custom_add cb_custom_add
cb_custom_remove cb_custom_remove
cb_custom_up cb_custom_up
cb_custom_down cb_custom_down
st_custom_count st_custom_count
cb_custom_next cb_custom_next
cb_custom_prev cb_custom_prev
cb_custom_close cb_custom_close
end type

on tabpage_custom.create
this.uo_custom_rmm=create uo_custom_rmm
this.dw_title=create dw_title
this.st_1=create st_1
this.st_2=create st_2
this.dw_available=create dw_available
this.dw_selected=create dw_selected
this.cb_custom_add=create cb_custom_add
this.cb_custom_remove=create cb_custom_remove
this.cb_custom_up=create cb_custom_up
this.cb_custom_down=create cb_custom_down
this.st_custom_count=create st_custom_count
this.cb_custom_next=create cb_custom_next
this.cb_custom_prev=create cb_custom_prev
this.cb_custom_close=create cb_custom_close
this.Control[]={this.uo_custom_rmm,&
this.dw_title,&
this.st_1,&
this.st_2,&
this.dw_available,&
this.dw_selected,&
this.cb_custom_add,&
this.cb_custom_remove,&
this.cb_custom_up,&
this.cb_custom_down,&
this.st_custom_count,&
this.cb_custom_next,&
this.cb_custom_prev,&
this.cb_custom_close}
end on

on tabpage_custom.destroy
destroy(this.uo_custom_rmm)
destroy(this.dw_title)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_available)
destroy(this.dw_selected)
destroy(this.cb_custom_add)
destroy(this.cb_custom_remove)
destroy(this.cb_custom_up)
destroy(this.cb_custom_down)
destroy(this.st_custom_count)
destroy(this.cb_custom_next)
destroy(this.cb_custom_prev)
destroy(this.cb_custom_close)
end on

type uo_custom_rmm from uo_tabpage_rmm within tabpage_custom
string accessiblename = "Customize Report Tab"
string accessibledescription = "Customize Report Tab"
integer x = 18
integer y = 4
integer width = 2839
integer height = 1456
integer taborder = 100
end type

on uo_custom_rmm.destroy
call uo_tabpage_rmm::destroy
end on

type dw_title from u_dw within tabpage_custom
string accessiblename = "Title"
string accessibledescription = "Title"
integer x = 114
integer y = 32
integer width = 2213
integer height = 264
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pattern_title"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_title.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This d/w is not part of the update process since it shares
//						its data with dw_patt_options.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

This.of_SetUpdateable (FALSE)


end event

event itemchanged;//*********************************************************************************
// Script Name:	dw_title.itemchanged
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Update the changed value in dw_patt_options
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_custom_title_change (data)

end event

type st_1 from statictext within tabpage_custom
string accessiblename = "Available Fields"
string accessibledescription = "Available Fields"
accessiblerole accessiblerole = statictextrole!
integer x = 69
integer y = 332
integer width = 489
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Available Fields"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_custom
string accessiblename = "Selected Fields (After ICN)"
string accessibledescription = "Selected Fields (After ICN)"
accessiblerole accessiblerole = statictextrole!
integer x = 1417
integer y = 332
integer width = 832
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Selected Fields (After ICN)"
boolean focusrectangle = false
end type

type dw_available from u_dw within tabpage_custom
event ue_mousemove pbm_mousemove
string accessiblename = "Available Fields List"
string accessibledescription = "Available Fields List"
integer x = 59
integer y = 416
integer width = 910
integer height = 860
integer taborder = 15
string dragicon = "ROWS.ICO"
boolean bringtotop = true
string dataobject = "d_available_pattern"
boolean vscrollbar = true
end type

event ue_mousemove;//*********************************************************************************
// Script Name:	dw_available.ue_mousemove (pbm_mousemove)
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Begin Drag Mode if a row is hilited and the mouse is clicked.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

DragObject		ldrg_control

IF Message.WordParm	=	1				THEN
	IF GetSelectedRow(This, 0)	>	0	THEN
  		Drag(This, Begin!)
	END IF
END IF

SetNull(Message.WordParm)

end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_available.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Multi-select rows.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

This.of_SetUpdateable (FALSE)

This.SetTransObject (Stars2ca)

// If in 'Criteria' mode, all datawindows are in 'readonly' mode.  This allows the
//	user to click or double-click, but not modify.  When this situation occurs,
// do nothing.
IF	istr_sub_opt.patt_struc.come_from	<>	'CRITERIA'		THEN
	This.of_MultiSelect (TRUE)
END IF



end event

event doubleclicked;//*********************************************************************************
// Script Name:	dw_available.DoubleClicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_available to
//						dw_selected.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

// If in 'Criteria' mode, all datawindows are in 'readonly' mode.  This allows the
//	user to click or double-click, but not modify.  When this situation occurs,
// do nothing.
IF	istr_sub_opt.patt_struc.come_from	<>	'CRITERIA'		THEN
	lw_parent.Event	ue_custom_add()
END IF


end event

event dragdrop;//*********************************************************************************
// Script Name:	dw_available.DragDrop
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_selected to
//						dw_available.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_custom_remove()

end event

type dw_selected from u_dw within tabpage_custom
event ue_mousemove pbm_mousemove
string accessiblename = "Selected Fields List"
string accessibledescription = "Selected Fields List"
integer x = 1403
integer y = 416
integer width = 910
integer height = 860
integer taborder = 20
string dragicon = "ROWS.ICO"
boolean bringtotop = true
string dataobject = "d_available_pattern"
boolean vscrollbar = true
end type

event ue_mousemove;//*********************************************************************************
// Script Name:	dw_selected.ue_mousemove (pbm_mousemove)
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Begin Drag Mode if a row is hilited and the mouse is clicked.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

DragObject		ldrg_control

IF Message.WordParm	=	1				THEN
	IF GetSelectedRow(This, 0)	>	0	THEN
  		Drag(This, Begin!)
	END IF
END IF

SetNull(Message.WordParm)

end event

event doubleclicked;//*********************************************************************************
// Script Name:	dw_selected.DoubleClicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_selected to
//						dw_available.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

// If in 'Criteria' mode, all datawindows are in 'readonly' mode.  This allows the
//	user to click or double-click, but not modify.  When this situation occurs,
// do nothing.
IF	istr_sub_opt.patt_struc.come_from	<>	'CRITERIA'		THEN
	lw_parent.Event	ue_custom_remove()
END IF


end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_selected.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Multi-select rows.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

This.of_SetUpdateable (FALSE)

// If in 'Criteria' mode, all datawindows are in 'readonly' mode.  This allows the
//	user to click or double-click, but not modify.  When this situation occurs,
// do nothing.
IF	istr_sub_opt.patt_struc.come_from	<>	'CRITERIA'		THEN
	This.of_MultiSelect (TRUE)
END IF


end event

event dragdrop;//*********************************************************************************
// Script Name:	dw_selected.DragDrop
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_available to
//						dw_selected.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

il_drop_row		=	row

lw_parent.Event	ue_custom_add()

end event

event ue_updatespending;//*********************************************************************************
// Script Name:	dw_selected.ue_UpdatesPending (Override the ancestor)
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_available to
//						dw_selected.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

//	Check for pending updates
IF	This.ModifiedCount()	+	This.DeletedCount()	>	0	THEN
	RETURN 1
END IF

//	There are no pending updates
RETURN 0

end event

type cb_custom_add from u_cb within tabpage_custom
string accessiblename = "Add Button"
string accessibledescription = "Add Button"
integer x = 1079
integer y = 588
integer width = 224
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$ae00$$ENDHEX$$"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_add
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_available to
//						dw_selected.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_custom_add()

end event

type cb_custom_remove from u_cb within tabpage_custom
string accessiblename = "Remove Button"
string accessibledescription = "Remove Button"
integer x = 1079
integer y = 752
integer width = 224
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$ac00$$ENDHEX$$"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_remove
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns from dw_selected to
//						dw_available.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_custom_remove()

end event

type cb_custom_up from u_cb within tabpage_custom
string accessiblename = "Up Button"
string accessibledescription = "Up Button"
integer x = 2395
integer y = 588
integer width = 224
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$ad00$$ENDHEX$$"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_up
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns in dw_selected up one row.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_custom_move('UP')

end event

type cb_custom_down from u_cb within tabpage_custom
string accessiblename = "Down Button"
string accessibledescription = "Down Button"
integer x = 2395
integer y = 752
integer width = 224
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$af00$$ENDHEX$$"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_down
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Move the highlighted columns in dw_selected down one row.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_custom_move ('DOWN')

end event

type st_custom_count from statictext within tabpage_custom
string accessiblename = "Selected Fields Count"
string accessibledescription = "Selected Fields Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1399
integer y = 1356
integer width = 261
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_custom_next from u_cb within tabpage_custom
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2167
integer y = 1348
integer taborder = 70
boolean bringtotop = true
string text = "&Next"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_next
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the next tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_next_tabpage()

end event

type cb_custom_prev from u_cb within tabpage_custom
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 1815
integer y = 1348
integer taborder = 80
boolean bringtotop = true
string text = "&Prev"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_prev
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the previous tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_prev_tabpage()

end event

type cb_custom_close from u_cb within tabpage_custom
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 1348
integer taborder = 90
boolean bringtotop = true
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_custom_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Close the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

Close (lw_parent)

end event

type tabpage_report from userobject within tab_patt
string accessiblename = "View Report"
string accessibledescription = "View Report"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 2848
integer height = 1464
boolean enabled = false
long backcolor = 67108864
string text = "View Report"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_report_rmm uo_report_rmm
dw_report dw_report
st_count st_count
cb_report_prev cb_report_prev
cb_report_close cb_report_close
end type

on tabpage_report.create
this.uo_report_rmm=create uo_report_rmm
this.dw_report=create dw_report
this.st_count=create st_count
this.cb_report_prev=create cb_report_prev
this.cb_report_close=create cb_report_close
this.Control[]={this.uo_report_rmm,&
this.dw_report,&
this.st_count,&
this.cb_report_prev,&
this.cb_report_close}
end on

on tabpage_report.destroy
destroy(this.uo_report_rmm)
destroy(this.dw_report)
destroy(this.st_count)
destroy(this.cb_report_prev)
destroy(this.cb_report_close)
end on

type uo_report_rmm from uo_tabpage_rmm within tabpage_report
string accessiblename = "View Report Tab"
string accessibledescription = "View Report Tab"
integer x = 5
integer y = 16
integer width = 2853
integer height = 1444
integer taborder = 40
boolean bringtotop = true
end type

on uo_report_rmm.destroy
call uo_tabpage_rmm::destroy
end on

type dw_report from u_dw within tabpage_report
string tag = "CRYSTAL, title=Pattern Recognition Analysis"
string accessiblename = "Report Data"
string accessibledescription = "Report Data"
integer x = 23
integer y = 20
integer width = 2807
integer height = 1304
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;//*********************************************************************************
// Script Name:	dw_report.DoubleClicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Invoke the Window Operations.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.of_window_operations (This, row, dwo)


end event

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_report.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Use the Retrieve Meter.  This involves adding code to
//						the retrieverow event.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/13/03	GaryR	Track 2868d	Allow single row selection on report
//
//*********************************************************************************

This.of_SetRetrieveMeter(TRUE)

This.of_SetUpdateable (FALSE)

This.of_SingleSelect(TRUE)


end event

event retrieverow;//*********************************************************************************
// Script Name:	dw_report.RetrieveRow
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Use the Retrieve Meter.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 05/05/08	RickB		SPR 5335 - Changed iu_retrievemeter.of_progress (1) to
//							iu_retrievemeter.of_progress () because function of_Progress (Integer ai_style)
//            				was deleted.
//
//*********************************************************************************

IF	gv_cancel_but_clicked		THEN
	Integer	li_rc
	li_rc		=	This.DBCancel()
	gv_cancel_but_clicked	=	FALSE
	Return	1
END IF

IF	IsValid (iu_retrievemeter)	THEN
	iu_retrievemeter.of_progress ()
END IF

end event

event rbuttonup;///////////////////////////////////////////////////////////////////////////////
//
// 08/19/02	Jason	Track 2982d	Created
// 01/14/03	Jason	Track 2982d	Fixed bug in lookup
//	07/10/06	GaryR	Track 4387d	Allow invoice specific lookups in ML patterns
//
///////////////////////////////////////////////////////////////////////////////

String	ls_hold_object,		&
			ls_lookup_table,		&
			ls_dbname,				&
			ls_colname, 			&
			ls_text,					&
			ls_colno

Long 		ll_index, 				&
			ll_upperbound	// JasonS 08/22/02 Track 2982d

w_sampling_analysis_new	lw_parent	
datawindowchild	ldwc_inv_type			

This.of_getparentwindow ( lw_parent )

Setpointer(Hourglass!)
ls_hold_object	=	This.GetObjectAtPointer()

IF	Trim (ls_hold_object)	<	'  '		THEN
	// Display RMM
	lw_parent.Event	ue_open_rmm()
	Return 1
END IF

ls_colno = String( this.getclickedcolumn() )
ls_dbname 		=	this.Describe('#' + ls_colno + '.dbname')
ls_colname 		=	this.Describe('#' + ls_colno + '.name')

tab_patt.tabpage_list.dw_parms.getchild('invoice_type', ldwc_inv_type)
ls_lookup_table = ldwc_inv_type.getitemstring(ldwc_inv_type.getrow(), 'inv_type')

if ls_lookup_table = 'ML' then
	// Check if header or cell was clicked
	IF ls_colno = "0" THEN
		// Get invoice type from header prefix stored in ls_hold_object
		ls_hold_object = Trim( Left( ls_hold_object, Pos( ls_hold_object, "~t" ) - 1 ) )
		ls_text = this.Describe(ls_hold_object + '.text')
	ELSE
		// Get invoice type from header prefix
		ls_text 	=	this.Describe(ls_colname + '_t.text')
		IF ls_text = "!" AND Match( Right( ls_colname, 2 ), "^_[0-9]$" ) THEN
			ls_text = Left( ls_colname, Len( ls_colname ) - 2 ) &
							+ "_t_" + Right( ls_colname, 1 ) + "_t.text"
			ls_text 		=	this.Describe(ls_text)
		END IF
	END IF
	
	IF ls_text = "!" THEN
		MessageBox( "ERROR", "Unable to get the invoice type for the selected column." )
		Return 1
	END IF
	
	ls_lookup_table = left( ls_text, 2 )
else
	// JasonS 1/14/03 Begin - Track 2982d
	ls_lookup_table = ''
	ll_upperbound = upperbound(w_sampling_analysis_new.istr_decode_struct.table_type[])
	for ll_index = 1 to ll_upperbound
		if ls_lookup_table = '' then
			select elem_tbl_type
			into :ls_lookup_table
			from dictionary
			where elem_name = UPPER(:ls_dbname)
			and elem_tbl_type = :istr_decode_struct.table_type[ll_index]
			using stars2ca;
		end if
	next
	// JasonS 1/14/03 End - Track 2982d
end if

fx_lookup(dw_report,ls_lookup_table)

stars2ca.of_commit()						// FNC 04/14/99

Return 	1
end event

type st_count from statictext within tabpage_report
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 87
integer y = 1348
integer width = 247
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_report_prev from u_cb within tabpage_report
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 1815
integer y = 1348
integer taborder = 20
boolean bringtotop = true
string text = "&Prev"
boolean default = true
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_report_prev
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Open the previous tabpage
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_prev_tabpage()

end event

type cb_report_close from u_cb within tabpage_report
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 1348
integer taborder = 30
boolean bringtotop = true
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_report_close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Close the window
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

w_sampling_analysis_new	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)

Close (lw_parent)

end event

type dw_3 from u_dw within w_sampling_analysis_new
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer y = 420
integer width = 73
integer taborder = 20
boolean enabled = false
string dataobject = "d_ccn_temp"
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

end event

type dw_2 from u_dw within w_sampling_analysis_new
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer y = 40
integer width = 64
integer taborder = 30
boolean enabled = false
string dataobject = "d_initial"
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

end event

