HA$PBExportHeader$uo_query.sru
$PBExportComments$Query engine user object (inherited from u_tab) <gui>
forward
global type uo_query from u_tab
end type
type tabpage_list from userobject within uo_query
end type
type uo_range from uo_date_range within tabpage_list
end type
type dw_search from u_dw within tabpage_list
end type
type gb_1 from groupbox within tabpage_list
end type
type dw_list from u_dw within tabpage_list
end type
type cb_close_list from u_cb within tabpage_list
end type
type cb_next_list from u_cb within tabpage_list
end type
type cb_select_list from u_cb within tabpage_list
end type
type cb_list_list from u_cb within tabpage_list
end type
type st_count_list from statictext within tabpage_list
end type
type cb_new from u_cb within tabpage_list
end type
type gb_2 from groupbox within tabpage_list
end type
type uo_tabpage_list from uo_tabpage_qe within tabpage_list
end type
type tabpage_list from userobject within uo_query
uo_range uo_range
dw_search dw_search
gb_1 gb_1
dw_list dw_list
cb_close_list cb_close_list
cb_next_list cb_next_list
cb_select_list cb_select_list
cb_list_list cb_list_list
st_count_list st_count_list
cb_new cb_new
gb_2 gb_2
uo_tabpage_list uo_tabpage_list
end type
type tabpage_pdr from userobject within uo_query
end type
type dw_pdr from u_dw within tabpage_pdr
end type
type cb_close_pdr from u_cb within tabpage_pdr
end type
type cb_next_pdr from u_cb within tabpage_pdr
end type
type cb_prev_pdr from u_cb within tabpage_pdr
end type
type tabpage_pdr from userobject within uo_query
dw_pdr dw_pdr
cb_close_pdr cb_close_pdr
cb_next_pdr cb_next_pdr
cb_prev_pdr cb_prev_pdr
end type
type tabpage_source from userobject within uo_query
end type
type dw_source from u_dw within tabpage_source
end type
type cb_close_source from u_cb within tabpage_source
end type
type cb_next_source from u_cb within tabpage_source
end type
type uo_tabpage_source from uo_tabpage_qe within tabpage_source
end type
type cb_prev_source from u_cb within tabpage_source
end type
type tabpage_source from userobject within uo_query
dw_source dw_source
cb_close_source cb_close_source
cb_next_source cb_next_source
uo_tabpage_source uo_tabpage_source
cb_prev_source cb_prev_source
end type
type tabpage_search from userobject within uo_query
end type
type st_text_view_search from statictext within tabpage_search
end type
type dw_criteria from u_dw within tabpage_search
end type
type cb_close_search from u_cb within tabpage_search
end type
type cb_next_search from u_cb within tabpage_search
end type
type st_count_search from statictext within tabpage_search
end type
type st_count_view_search from statictext within tabpage_search
end type
type cb_prev_search from u_cb within tabpage_search
end type
type pb_notes_search from u_pb within tabpage_search
end type
type ddlb_pdr_opt from u_ddlb within tabpage_search
end type
type gb_available_claims from groupbox within tabpage_search
end type
type uo_tabpage_search from uo_tabpage_qe within tabpage_search
end type
type uo_period from u_display_period within tabpage_search
end type
type st_period from statictext within tabpage_search
end type
type st_payment_date_options from statictext within tabpage_search
end type
type ddlb_pd_opt from u_ddlb within tabpage_search
end type
type tabpage_search from userobject within uo_query
st_text_view_search st_text_view_search
dw_criteria dw_criteria
cb_close_search cb_close_search
cb_next_search cb_next_search
st_count_search st_count_search
st_count_view_search st_count_view_search
cb_prev_search cb_prev_search
pb_notes_search pb_notes_search
ddlb_pdr_opt ddlb_pdr_opt
gb_available_claims gb_available_claims
uo_tabpage_search uo_tabpage_search
uo_period uo_period
st_period st_period
st_payment_date_options st_payment_date_options
ddlb_pd_opt ddlb_pd_opt
end type
type tabpage_report from userobject within uo_query
end type
type gb_fastquery from groupbox within tabpage_report
end type
type dw_pipeline from u_dw within tabpage_report
end type
type st_available_count from statictext within tabpage_report
end type
type st_title from statictext within tabpage_report
end type
type dw_available from u_dw within tabpage_report
end type
type st_selected from statictext within tabpage_report
end type
type dw_selected from u_dw within tabpage_report
end type
type cb_add from u_cb within tabpage_report
end type
type cb_remove from u_cb within tabpage_report
end type
type cb_up from u_cb within tabpage_report
end type
type cb_down from u_cb within tabpage_report
end type
type cb_close_report from u_cb within tabpage_report
end type
type cb_next_report from u_cb within tabpage_report
end type
type st_count_report from statictext within tabpage_report
end type
type cb_prev_report from u_cb within tabpage_report
end type
type st_available from statictext within tabpage_report
end type
type uo_report_options from u_report_options within tabpage_report
end type
type uo_tabpage_report from uo_tabpage_qe within tabpage_report
end type
type mle_title from multilineedit within tabpage_report
end type
type dw_fastquery from u_dw within tabpage_report
end type
type tabpage_report from userobject within uo_query
gb_fastquery gb_fastquery
dw_pipeline dw_pipeline
st_available_count st_available_count
st_title st_title
dw_available dw_available
st_selected st_selected
dw_selected dw_selected
cb_add cb_add
cb_remove cb_remove
cb_up cb_up
cb_down cb_down
cb_close_report cb_close_report
cb_next_report cb_next_report
st_count_report st_count_report
cb_prev_report cb_prev_report
st_available st_available
uo_report_options uo_report_options
uo_tabpage_report uo_tabpage_report
mle_title mle_title
dw_fastquery dw_fastquery
end type
type tabpage_view from userobject within uo_query
end type
type cb_close_view from u_cb within tabpage_view
end type
type st_count_view from statictext within tabpage_view
end type
type st_unique_count_view from statictext within tabpage_view
end type
type cb_prev_view from u_cb within tabpage_view
end type
type pb_notes_view from u_pb within tabpage_view
end type
type st_unique_text_view from statictext within tabpage_view
end type
type dw_break from u_dw within tabpage_view
end type
type dw_report from u_dw within tabpage_view
end type
type uo_tabpage_view from uo_tabpage_qe within tabpage_view
end type
type tabpage_view from userobject within uo_query
cb_close_view cb_close_view
st_count_view st_count_view
st_unique_count_view st_unique_count_view
cb_prev_view cb_prev_view
pb_notes_view pb_notes_view
st_unique_text_view st_unique_text_view
dw_break dw_break
dw_report dw_report
uo_tabpage_view uo_tabpage_view
end type
end forward

global type uo_query from u_tab
string tag = "uo_query"
string accessiblename = "Query Engine Tabs"
string accessibledescription = "The Query Library tab is the only active tab until you select a Predefined Query (PDQ) to work with or have listed PDQs through a Query Search."
integer width = 3246
integer height = 2040
integer textsize = -10
fontcharset fontcharset = ansi!
boolean raggedright = false
boolean boldselectedtext = true
alignment alignment = center!
tabpage_list tabpage_list
tabpage_pdr tabpage_pdr
tabpage_source tabpage_source
tabpage_search tabpage_search
tabpage_report tabpage_report
tabpage_view tabpage_view
event ue_tabpage_view_create_report ( )
event type integer ue_register_vars ( string as_query_id,  string as_subset_id,  integer ai_period_key,  string as_period_function )
event ue_next_tabpage ( )
event type integer ue_format_where_criteria ( string as_type,  boolean ab_add_payment_date,  ref string as_where[],  ref sx_criteria astr_criteria[] )
event type integer ue_tabpage_source_construct ( string as_subset_id,  string as_auth_id )
event type integer ue_tabpage_source_load_additional_data ( string as_inv_type,  string as_subset_id )
event ue_tabpage_report_remove ( )
event ue_tabpage_report_add ( )
event type integer ue_tabpage_report_move_col ( string as_direction )
event type integer ue_tabpage_report_set_columns ( string as_inv_types[],  character ac_claim_type )
event type string ue_tabpage_report_get_ub92_base_type ( string as_inv_types )
event type integer ue_tabpage_report_load ( integer ai_level_num )
event type integer ue_tabpage_report_drilldown_load_cols ( sx_rpt_cols astr_cols[] )
event type integer ue_tabpage_search_set_dates ( )
event type integer ue_tabpage_search_get_prov_choices ( boolean ab_npi )
event type integer ue_tabpage_source_set_data_type ( string as_data_type,  string as_subset_name,  string as_case_id )
event ue_tabpage_source_determine_source_type ( )
event type integer ue_tabpage_source_load ( integer ai_level_num )
event type integer ue_tabpage_source_match_type_and_source ( )
event type string ue_tabpage_source_get_inv_type ( )
event type integer ue_tabpage_source_get_both_data_sources ( ref string as_inv_types[] )
event type integer ue_tabpage_source_save ( integer ai_level,  string as_query_id )
event type integer ue_tabpage_source_clear ( string as_path )
event ue_tabpage_search_set_period_visibility ( )
event ue_tabpage_search_set_period ( )
event type integer ue_tabpage_search_set_columns ( string as_inv_type,  string as_dep_type,  string as_claim_type )
event type integer ue_tabpage_source_get_source_sub_tables ( string as_subset_id,  ref string as_inv_type[] )
event ue_drilldown_drop_temp_table ( )
event type integer ue_tabpage_list_construct ( string as_query_id )
event type integer ue_tabpage_list_create_list ( string as_query_id )
event type string ue_tabpage_list_get_selected_query_id ( )
event type integer ue_tabpage_search_ml_filter_check ( string as_come_from )
event ue_tabpage_search_add_row ( )
event type integer ue_tabpage_search_code_lookup ( string as_value,  integer ai_row )
event ue_tabpage_search_set_periods ( )
event type integer ue_tabpage_search_clear ( )
event type integer ue_tabpage_search_set_authorization ( string as_auth_id )
event type integer ue_tabpage_search_load ( integer ai_level_num )
event type integer ue_tabpage_search_delete_row ( )
event type integer ue_tabpage_search_insert_row ( )
event type integer ue_tabpage_search_save ( integer ai_level,  string as_query_id )
event type string ue_tabpage_view_translate_invoice_type ( ref string as_inv_type )
event ue_tabpage_view_view_claim ( )
event type integer ue_tabpage_view_get_key_columns ( )
event type integer ue_format_where_criteria_add_clauses ( string as_type,  ref string as_where[],  ref sx_criteria astr_criteria[] )
event type integer ue_drilldown_build_temp_table ( ref sx_drilldown astr_drilldown )
event type integer ue_drilldown_load_new_query ( )
event ue_string_sql_statement ( ref string as_sql_statement[] )
event ue_new_query ( )
event ue_tabpage_list_notes ( )
event type integer ue_tabpage_list_query_save_info ( ref sx_query_save asx_query_save )
event ue_open_menu ( )
event ue_tabpage_list_delete_query ( )
event type integer ue_subsetting_set_filter_create ( sx_all_filter_info asx_all_filter_info )
event ue_criteriasave ( )
event ue_tabpage_view_mapping ( )
event ue_window_operations ( string as_operation,  string as_type )
event ue_tabpage_view_list ( string as_type )
event ue_tabpage_view_unique_count ( string as_type )
event ue_count ( )
event ue_tabpage_view_detail ( )
event type integer ue_tabpage_report_save ( integer ai_level,  string as_query_id )
event type integer ue_subsetting ( ref sx_subsetting_info asx_subsetting_info )
event type boolean ue_get_new_flag ( )
event type integer ue_tabpage_report_load_template ( string as_template_id )
event type boolean ue_tabpage_report_get_new_flag ( )
event type integer ue_tabpage_report_get_template_info ( ref sx_report_template_save asx_report_template_info )
event type string ue_tabpage_report_get_title ( )
event type integer ue_tabpage_report_save_template ( sx_report_template_save asx_report_template_save )
event type integer ue_tabpage_report_get_selected_columns ( ref sx_col_desc asx_col_desc[] )
event type integer ue_tabpage_report_clear_break_info ( )
event type integer ue_tabpage_report_clear ( boolean ab_keep_title )
event type integer ue_tabpage_report_set_break_info ( sx_break_info asx_break_info )
event type string ue_tabpage_view_prov_pat_drilldown ( string as_tag_value )
event type integer ue_tabpage_report_get_selected_col_names ( ref sx_selected_cols astr_selected_cols[] )
event type string ue_tabpage_list_get_selected_user_id ( )
event type string ue_tabpage_list_get_selected_case_id ( )
event type string ue_tabpage_list_get_selected_case_spl ( )
event type string ue_tabpage_list_get_selected_case_ver ( )
event type integer ue_selecttab ( integer ai_tabpage )
event type integer ue_tabpage_source_set_subset_id ( integer ai_row,  string as_subset_name )
event type integer ue_tabpage_source_set_subset_data_source ( string as_subset_id )
event ue_reset_query ( )
event ue_edit_initial_search_by_data ( )
event type integer ue_tabpage_source_filter_data_source ( )
event type integer ue_tabpage_search_edit_report_dates ( )
event ue_set_ancillary_inv_type ( string as_data_source )
event type integer ue_add_data_source_change ( string as_add_data_source )
event ue_set_count_list ( )
event ue_set_count_search ( )
event ue_set_count_report ( )
event ue_set_count_view ( )
event type integer ue_tabpage_report_get_selected ( )
event type integer ue_tabpage_report_load_user_template ( )
event type integer ue_tabpage_report_load_system_template ( )
event rbuttonup pbm_dwnrbuttonup
event type integer ue_subsetting_clear_filter_copy ( )
event ue_prev_tabpage ( )
event type integer ue_set_payment_date ( )
event type integer ue_reset_payment_date_opt ( )
event ue_tabpage_search_set_pd_opt_visibility ( )
event ue_notes ( )
event type integer ue_clear_pd_opt ( )
event type integer ue_set_query_engine_run_frequency ( integer ai_run_frequency )
event ue_initialize_dw_fastquery ( )
event ue_edit_enable_fastquery ( )
event ue_edit_disable_tabs ( boolean ab_switch )
event type integer ue_tabpage_pdr_construct ( )
event type integer ue_tabpage_pdr_load_source ( boolean ab_new )
event type integer ue_tabpage_pdr_create_report ( )
event type integer ue_tabpage_pdr_load_search ( boolean ab_new )
event type integer ue_tabpage_pdr_load ( integer ai_level_num )
event ue_pipe_data ( )
event type integer ue_tabpage_pdr_secure ( ref datawindowchild adwc_pdr_ver )
event ue_tabpage_pdr_filter_source ( )
event type integer ue_tabpage_pdr_validate_source ( )
event type integer ue_tabpage_pdr_save ( integer ai_level,  string as_query_id )
event type integer ue_tabpage_pdr_build_syntax ( string as_pdr_name )
event ue_tabpage_pdr_init_report_options ( )
event type integer ue_tabpage_source_itemchanged ( string data )
event ue_tabpage_source_get_desc ( )
event type integer ue_tabpage_view_stats ( )
end type
global uo_query uo_query

type variables
nvo_subset_functions		invo_subset_functions 
n_cst_temp_table			invo_temp_table

sx_prov_query_structure	istr_prov_query
sx_prov_query_structure	istr_npi_prov_query   //	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
sx_criteria					istr_criteria 
sx_decode_structure		istr_decode_struct
sx_details_structure		istr_claim_view_struct

// SQL
sx_sql_statement_container	istr_sql_container

//C - claims, FT, MC, ML, P - prov/pat
string			is_source_type 

//striped from data source
string			is_inv_type 

//passed into window
string			is_query_id 
string			is_subset_id 
string			is_period_function
integer			ii_period_key

//when selects subset as source
string			is_source_subset_id

//subset or base
string			is_data_type 

//contains selected window operation
String			is_window_operation
String			is_operation
String			is_operation_type

//if window operation selected from right mouse menu 
//set to 1
string			is_selected

// for report template - must stay separate from pdq's
n_ds		ids_report_template_case_link
n_ds		ids_report_template_pdq_cntl
n_ds		ids_report_template_pdq_columns

// count of independent and subset filters used in 
// WHERE, need to pass to FROM 
int			ii_filter_count
int			ii_sub_filter_count

// used when filters from previous levels are used in criteria 
int			ii_ml_filter_rows[]

Constant int		IC_LIST = 1
Constant	int		IC_PDR = 2
Constant int		IC_SOURCE = 3
Constant int		IC_SEARCH = 4
Constant int		IC_REPORT = 5
Constant int		IC_VIEW = 6
//	04/17/02	GaryR	Track 2552d

Constant int		IC_MAX_LEVELS = 10

// MikeFl 6/2/04 4268c
Constant	int		ii_sql_cutoff = 80

/* Other constants */
Constant	String		ics_list = 'LIST'

// Variables for data retrieval 
Long           il_dw_limit = gc_dw_limit
boolean			ib_win_busy
boolean			ib_list_retrieve

// used for drilldown
boolean		ib_drilldown
boolean		ib_drilldown_column_flag 

//01-29-98 FNC Use cols in structure rather than separate cols
string		is_drilldown_previous_temp_table_name

//01-29-98 FNC Define sx_drilldown as an instance
sx_drilldown	istr_drilldown, &
					istr_prev_drilldown
sx_criteria		istr_drilldown_criteria[]

// for window operations - may be in the wrong place, might need to be on window
w_uo_win			iw_uo_win

// for tabpage_view, key column vars
sx_keys			istr_key_columns

// for subsetting
boolean			ib_subsetting

// Ancillary data source?
Boolean			ib_ancillary_inv_type

sx_subsetting_info		istr_subsetting_info
// defined in ts144 - sx_subsetting_info

// for count 
boolean			ib_count

// new query 
boolean			ib_new_flag

// Has query been loaded
boolean			ib_query_loaded_flag

// break with totals
sx_break_info	istr_break_info /*defined in ts144 - Break with Totals*/

// to reference temp table alias 
Constant string	                IC_TEMP_ALIAS = "TMP"

//uo_query                                   iuo_query
u_nvo_list                                  invo_TabPageList
u_nvo_source                           invo_TabPageSource
u_nvo_report                             invo_TabPageReport
u_nvo_search                           invo_TabPageSearch
u_nvo_view                              invo_TabPageView
u_nvo_pdr										invo_TabPagePDR	//	04/17/02	GaryR	Track 2552d

Integer                                      ii_Level

// flag to prevent w_master's ue_save event from 
// attempting update in datawindows which need 
// CloseQuery processing (ie. still need to check for updates)
Boolean                                    ib_FromCloseQuery
// did user cancel retrieve
Boolean                                    ib_RetrieveCancelled

// Did the user change criteria for date criteria set
// by a period (new queries only)
Boolean			ib_criteria_date_change

// Invoice type for additional data source
String			is_add_inv_type

// The previous invoice type for a query
String			is_old_inv_type

// The invoice type with it's description
String			is_inv_description

// Used for drilldown - Original period description
String			is_period_desc

// dw_criteria from the previous level
u_dw			idw_prev_criteria

//NLG 8-19-98 - Determines if Report on columns should be saved
boolean 			ib_load_template=TRUE

//AJS 8-25-98 - TS144 Report On - set dropped row
long			il_drop_row

// FDG 11/20/98 (1946) - In drilldown mode?
Boolean			ib_drilldown_mode

//NLG 10/20/99 ts2463c. For recurring PDQs:
boolean ib_recurring_pdq
integer ii_run_frequency

//engine mode
string	is_query_engine_mode		//Lahu S
int		ii_view_report  //Lahu S

//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
Boolean	ib_pdr_inv_changed

//	12/28/04	GaryR	Track 4199d	Store original SQL
String	is_pdr_sql

//	07/04/05	GaryR	Track 3316d	Keep claims detail menu setting on drilldown
Boolean	ib_claimdetail

// 	03/06/06 HYL		Track 4471d and 4631d  
Boolean ib_subnet_name_changed
end variables

forward prototypes
public function string of_getreporttitle ()
public function integer of_setreporttitle (string as_reporttitle)
public function u_dw of_get_report_dw ()
public function u_Dw of_get_search_dw ()
public function u_Dw of_get_source_dw ()
public function u_Dw of_get_view_dw ()
public function integer of_setfromclosequery (boolean ab_Flag)
public function boolean of_getfromclosequery ()
public function string of_getinvoicetypes ()
public function string of_getinvoicetype ()
public function string of_getavailableinvoicetypes ()
public function string of_determine_data_type (string as_col_type)
public function sx_break_info uf_get_sxbreakinfo ()
public function integer uf_set_sxbreakinfo (sx_break_info asx_break_info)
protected function integer of_setstatus (ref u_dw adw_requestor, dwitemstatus ais_newstatus, integer ai_column)
public function integer of_setstatus (dwitemstatus adis_Status)
public function integer of_getcasesecurity (readonly string as_case_id, readonly string as_case_spl, readonly string as_case_ver)
public function integer of_setdwlimit (Long al_Limit)
public subroutine of_set_data_type (string as_data_type)
public function sx_prov_query_structure of_get_str_prov_query ()
public subroutine of_set_decode_struct (sx_decode_structure astr_decode_struct)
public function sx_decode_structure of_get_decode_struct ()
public function boolean of_get_ancillary_inv_type ()
public function integer of_set_list_retrieve (boolean ab_switch)
public function boolean of_get_list_retrieve ()
public function sx_prov_query_structure of_get_istr_prov_query ()
public function boolean of_edit_criteria_changed ()
public function string of_get_add_inv_type ()
public subroutine of_set_add_inv_type (string as_add_inv_type)
public function boolean of_get_ib_drilldown ()
public function sx_drilldown of_get_istr_drilldown ()
public subroutine of_set_istr_drilldown (sx_drilldown astr_drilldown)
public function sx_keys of_get_istr_key_columns ()
public subroutine of_set_istr_key_columns (sx_keys astr_key_columns)
public function boolean of_get_ib_count ()
public subroutine of_set_ib_count (boolean ab_count)
public function sx_criteria of_get_istr_criteria ()
public subroutine of_set_istr_criteria (sx_criteria astr_criteria)
public function string of_get_drilldown_prev_table ()
public subroutine of_set_drilldown_prev_table (string as_drilldown_previous_temp_table_name)
public function string of_get_subset_id ()
public subroutine of_set_subset_id (string as_subset_id)
public function sx_sql_statement_container of_get_istr_sql_statement ()
public function sx_subsetting_info of_get_istr_subsetting_info ()
public subroutine of_set_istr_subsetting_info (sx_subsetting_info astr_subsetting_info)
public function boolean of_get_ib_subsetting ()
public subroutine of_set_ib_subsetting (boolean ab_subsetting)
public function string of_get_source_subset_id ()
public subroutine of_set_source_subset_id (string as_source_subset_id)
public function string of_get_period_desc ()
public subroutine of_set_period_desc (string as_period_desc)
public function integer of_get_ii_filter_count ()
public subroutine of_set_ii_filter_count (integer ai_filter_count)
public function sx_drilldown of_get_istr_prev_drilldown ()
public subroutine of_set_istr_prev_drilldown (sx_drilldown astr_drilldown)
public function string of_get_data_type ()
public function w_query_engine of_getwindow ()
public subroutine of_set_istr_sql_statement (sx_sql_statement_container astr_sql_container)
public subroutine of_set_period_visibility (boolean ab_switch)
public subroutine of_set_count_text (string as_text)
public subroutine of_set_ib_new_flag (boolean ab_flag)
public function integer of_date_change ()
public subroutine of_set_ib_load_template (boolean ab_load_template)
public function boolean of_get_ib_load_template ()
public function long of_get_drop_row ()
public subroutine of_set_idw_prev_criteria (u_dw adw_prev_criteria)
public function u_dw of_get_dw_criteria ()
public subroutine of_set_ib_drilldown_mode (boolean ab_drilldown_mode)
public function boolean of_get_ib_drilldown_mode ()
public subroutine of_set_run_frequency (integer ai_run_frequency)
public function integer of_get_run_frequency ()
public function boolean of_get_ib_recurring_pdq ()
public function integer of_set_ib_recurring_pdq (ref boolean ab_switch)
public subroutine of_set_fastquery_ind (string as_fastquery_ind)
public subroutine of_set_fastquery_rows (long al_fastquery_rows)
public function string of_get_default_ind (string as_user_id, string as_template_id, string as_inv_type, string as_addl_inv_type)
public function string of_get_pd_opt_desc ()
public subroutine of_set_engine_mode (string as_mode)
public subroutine of_set_pd_opt_desc (string as_pd_opt_desc)
protected function long of_windowoperation (u_dw adw_requestor, long al_row, dwobject adwo)
public function integer of_setquerynvo (boolean ab_flag, integer ai_index)
public function integer of_enable_tabpage (integer ai_tabpage, boolean ab_switch)
public subroutine of_check_filter_id (ref sx_filter_info asx_filter_info[])
public function integer of_set_instance_variables (integer ai_index, u_nvo_query au_nvo_tabpage)
public subroutine of_set_pd_opt_visibility (boolean ab_switch)
public subroutine of_set_pdr_date_range_option ()
public function integer of_getcasesecurity (integer ai_row, readonly sx_subset_ids asx_subset_ids)
public function integer of_reset_super_provider (integer ai_switch)
public function sx_prov_query_structure of_get_istr_npi_prov_query ()
public subroutine of_set_istr_prov_query (sx_prov_query_structure astr_prov_query, boolean ab_npi)
end prototypes

event ue_tabpage_view_create_report();
integer li_rc

If Not(IsValid(invo_tabpageview)) THEN
	//create the view tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	li_rc	=	invo_tabpageview.Event ue_tabpage_view_create_report()
	//destroy the view tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	li_rc	=	invo_tabpageview.Event ue_tabpage_view_create_report()
End If

if li_rc = -1 then
	messagebox('INFORMATION','Report not created.')
	return 
end if

end event

event type integer ue_register_vars(string as_query_id, string as_subset_id, integer ai_period_key, string as_period_function);//*************************************************************************
//ue_register_dw(dw ad_pdq_case_link, dw ad_pdq_cntl, dw ad_pdq_tables,
//dw ad_pdq_criteria, 
//dw ad_pdq_columns, string as_query_id, string as_subset_id)
//
//Register the invisible datawindows on the w_query_engine window 
//within the active uo_query.  This way, the datawindows can be 
//accessed by the uo_query without going outside the user object.  
//Also register the query id and subset_id.  
//This event is called in the pre-open event of w_query_engine 
//and the selecttionchanged event of w_query_engine.tab_level.
//*************************************************************************
//	ajs	07/30/98 Track #1522. Pass period id & period function.
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//*************************************************************************

is_query_id = as_query_id
is_subset_id = as_subset_id
ii_period_key = ai_period_key					//ajs 07/30/98 Track #1522. 
is_period_function = as_period_function	//ajs 07/30/98 Track #1522. 
Return 1
end event

event ue_next_tabpage();//////////////////////////////////////////////////////////////////////////
//	Event:		ue_next_tabpage()
//
//	This event is called by w_query_engine.cb_next.clicked to determine 
//	which tabpage on uo_query is selected and select the next 
//	enabled tabpage.  (Do not have to worry about last instance 
//	since cb_next will be invisible on last tab.)
//
//////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	03/02/98	Track 876.  Select the tab via an event.
//
//	FDG	12/02/98	Track 2004.  Don't display a message if all other tabpages
//						are disabled.
//
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
//
//////////////////////////////////////////////////////////////////////////


choose case this.selectedtab
	case IC_LIST
		//	GaryR	04/17/02	Track 2552d - Begin
		IF tabpage_pdr.visible AND tabpage_pdr.enabled THEN 
			Event ue_SelectTab(IC_PDR)
			Return
		END IF
		//	GaryR	04/17/02	Track 2552d - End
			
		if this.tabpage_source.enabled then
			This.Event ue_SelectTab(IC_SOURCE)
		else 
			if this.tabpage_search.enabled then
				This.Event ue_SelectTab(IC_SEARCH)
			else 
				if this.tabpage_report.enabled then
					This.Event ue_SelectTab(IC_REPORT)
				else 
					if this.tabpage_view.enabled then
						This.Event ue_SelectTab(IC_VIEW)
					else
						//MessageBox('Error',&
						//'Please select a pre-defined query before	proceeding.',&
						//StopSign!,Ok!)
						Return
					end if
				End If
			End If
		End If
		
	//	GaryR	04/17/02	Track 2552d - Begin
	case IC_PDR
		if this.tabpage_source.enabled then
			This.Event ue_SelectTab(IC_SOURCE)
		else 
			if this.tabpage_search.enabled then
				This.Event ue_SelectTab(IC_SEARCH)
			else 
				if this.tabpage_report.enabled then
					This.Event ue_SelectTab(IC_REPORT)
				else 
					if this.tabpage_view.enabled then
						This.Event ue_SelectTab(IC_VIEW)
					else
						//MessageBox('Error',&
						//'Please select a pre-defined query before	proceeding.',&
						//StopSign!,Ok!)
						Return
					end if
				End If
			End If
		End If
	//	GaryR	04/17/02	Track 2552d - End
	
	case IC_SOURCE
		if this.tabpage_search.enabled then
			This.Event ue_SelectTab(IC_SEARCH)
		else 
			if this.tabpage_report.enabled then
				This.Event ue_SelectTab(IC_REPORT)
			else 
				if this.tabpage_view.enabled then
					This.Event ue_SelectTab(IC_VIEW)
				else
					//MessageBox('Error',&
					//'Please select a data source before	proceeding.',&
					//StopSign!,Ok!)
					Return
				end if
			End If
		End If
	case IC_SEARCH
		if this.tabpage_report.enabled then
			This.Event ue_SelectTab(IC_REPORT)
		else 
			if this.tabpage_view.enabled then
				This.Event ue_SelectTab(IC_VIEW)
			else
				//MessageBox('Error',&
				//	'Please select criteria before proceeding.',&
				//	StopSign!,Ok!)
				Return
			end if
		End If
		
	case IC_REPORT
		if this.tabpage_view.enabled then
			This.Event ue_SelectTab(IC_VIEW)
		else
			//MessageBox('Error',&
			//	'Please select report column(s) before proceeding.',&
			//StopSign!,Ok!)
			Return
		end if
		
	case else
		//MessageBox('Error',&
		//'This tab should not be visible. SelectedTab = ' &
		//+ String(this.selectedTab) &
		//+ '. Please contact VIPS',&
		//StopSign!,Ok!)
		Return

end choose

end event

event ue_format_where_criteria;call super::ue_format_where_criteria;
Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_format_where_criteria (as_type, ab_add_payment_date, as_where, astr_criteria)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_format_where_criteria (as_type, ab_add_payment_date, as_where, astr_criteria)
End If

RETURN li_rc

end event

event type integer ue_tabpage_source_construct(string as_subset_id, string as_auth_id);Integer li_rc

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	li_rc = invo_tabpagesource.Event ue_tabpage_source_construct(as_subset_id,as_auth_id)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	li_rc = invo_tabpagesource.Event ue_tabpage_source_construct(as_subset_id,as_auth_id)
End If

RETURN li_rc
end event

event type integer ue_tabpage_source_load_additional_data(string as_inv_type, string as_subset_id);Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_load_additional_data(as_inv_type,as_subset_id)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_load_additional_data(as_inv_type,as_subset_id)
End If

RETURN i_Return
end event

event ue_tabpage_report_remove;call super::ue_tabpage_report_remove;//ue_tabpage_report_remove()
//This event is called by multiple events and controls in 
//tabpage_report to move the highlighted rows in dw_selected to 
//dw_available.  If no columns are put into dw_selected then items 
//on the right mouse menu must be invisible and the tabpage_view 
//must be disabled.

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	invo_tabpagereport.Event ue_tabpage_report_remove()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	invo_tabpagereport.Event ue_tabpage_report_remove()
End If
end event

event ue_tabpage_report_add();//ue_tabpage_report_add()
//This event is called by multiple events and controls in
//tabpage_report to move the highlighted rows in dw_available 
//to dw_selected.   If columns are put into dw_selected then 
//items on the right mouse menu must be visible and the tabpage_view 
//must be enabled.  

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	invo_tabpagereport.Event ue_tabpage_report_add()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	invo_tabpagereport.Event ue_tabpage_report_add()
End If
end event

event ue_tabpage_report_move_col;call super::ue_tabpage_report_move_col;//ue_tabpage_report_move_col(string as_direction)
//This event is called by the up and down buttons to move a 
//field up or down one field in the Selected Fields datawindow.

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_move_col(as_direction)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_move_col(as_direction)
End If

RETURN i_Return
end event

event ue_tabpage_report_set_columns;call super::ue_tabpage_report_set_columns;//ue_tabpage_report_set_columns(string as_inv_types[],char ac_claim_type)


//This event is called by the itemchanged event of 
//tabpage_source.dw_source.  It will load dw_available with columns 
//from the dictionary for the invoice types selected, whether it is 
//the data source ('M' for main) or additional data source 
//('A' for additional data source).    
//

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_set_columns(as_inv_types[],ac_claim_type)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_set_columns(as_inv_types[],ac_claim_type)
End If

RETURN i_Return
end event

event ue_tabpage_report_get_ub92_base_type;call super::ue_tabpage_report_get_ub92_base_type;//string ue_tabpage_report_get_UB92_base_type(string as_inv_types)
//This event is called by ue_tabpage_report_set_columns() 
//to determine if there is a UB92 invoice type in the subset.  
//Using the string of comma delimited invoice types will select 
//from get base types from stars_rel and determine if there is 
//a UB92.  (use invisible datawindow on w_main which is loaded 
//with stars_rel/dictionary info)  If there is will return a 
//comma delimeted string of the UB92 invoice types enclosed 
//in single quotes, else return empty string.

String s_Return

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	s_Return = invo_tabpagereport.Event ue_tabpage_report_get_ub92_base_type(as_inv_types)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	s_Return = invo_tabpagereport.Event ue_tabpage_report_get_ub92_base_type(as_inv_types)
End If

RETURN s_Return
end event

event ue_tabpage_report_load;call super::ue_tabpage_report_load;//ue_tabpage_report_load(int ai_level_num)
//This event is called by w_query_engine.ue_load_query when a 
//pre-defined query is loaded.  It will take the information out 
//of dw_pdq_tables (per level_num) and load it into this tabpage.  
//It will load the selected fields datawindow with columns found in 
//the PDQ_COLUMNS table that have col_type of 'PDQ' 
//(not 'SPQ' - Super Provider Query). 
//It will use the col_name in the table to determine the row 
//in the Available Fields datawindow and select it.  Once all 
//are selected, the add event (ue_tapbage_report_add()) will 
//be triggered to move the columns into the Selected Fields 
//datawindow.  Also must insert the report title into the report mle.
//The report title is found on PDQ_CNTL.

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load(ai_level_num)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load(ai_level_num)
End If

RETURN i_Return
end event

event ue_tabpage_report_drilldown_load_cols;call super::ue_tabpage_report_drilldown_load_cols;//ue_tabpage_report_drilldown_load_cols(sx_rpt_cols asx_cols)
//This event is called by uo_query.ue_drilldown_load_new_query() 
//to load the report tabpage with the temp table columns 
//from the temp table created in the previous uo_query.  
//The prefix for the columns will be IC_TEMP_ALIAS.
Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_drilldown_load_cols(astr_cols[])
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_drilldown_load_cols(astr_cols[])
End If

RETURN i_Return
end event

event ue_tabpage_search_set_dates;call super::ue_tabpage_search_set_dates;
Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_set_dates()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_set_dates()
End If

RETURN i_Return
end event

event type integer ue_tabpage_search_get_prov_choices(boolean ab_npi);//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider

Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_get_prov_choices( ab_npi )
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_get_prov_choices( ab_npi )
End If

RETURN i_Return
end event

event ue_tabpage_source_set_data_type;call super::ue_tabpage_source_set_data_type;
SetPointer(HourGlass!)

Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_set_data_type(as_data_type,as_subset_name,as_case_id)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_set_data_type(as_data_type,as_subset_name,as_case_id)
End If

RETURN i_Return
end event

event ue_tabpage_source_determine_source_type();If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	invo_tabpagesource.Event ue_tabpage_source_determine_source_type()
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	invo_tabpagesource.Event ue_tabpage_source_determine_source_type()
End If
end event

event type integer ue_tabpage_source_load(integer ai_level_num);Integer i_Return

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_load(ai_level_num)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_load(ai_level_num)
End If

RETURN i_Return
end event

event ue_tabpage_source_match_type_and_source;call super::ue_tabpage_source_match_type_and_source;
Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_match_type_and_source()
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_match_type_and_source()
End If

RETURN i_Return
end event

event ue_tabpage_source_get_inv_type;call super::ue_tabpage_source_get_inv_type;//This event will be called by w_query_engine.ue_query_save() to get the selected
// invoice type for the query.
return is_inv_type

end event

event ue_tabpage_source_get_both_data_sources;call super::ue_tabpage_source_get_both_data_sources;
Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_get_both_data_sources(as_inv_types[])
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_get_both_data_sources(as_inv_types[])
End If

RETURN i_Return
end event

event type integer ue_tabpage_source_save(integer ai_level, string as_query_id);Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_save(ai_level,as_query_id)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_save(ai_level,as_query_id)
End If

RETURN i_Return
end event

event type integer ue_tabpage_source_clear(string as_path);SetPointer(HourGlass!)

Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_clear(as_path)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_clear(as_path)
End If

RETURN i_Return
end event

event ue_tabpage_search_set_period_visibility;
If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	invo_tabpagesearch.Event ue_tabpage_search_set_period_visibility()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	invo_tabpagesearch.Event ue_tabpage_search_set_period_visibility()
End If
end event

event ue_tabpage_search_set_period;call super::ue_tabpage_search_set_period;
Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_tabpage_search_set_period()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_tabpage_search_set_period()
End If

//RETURN li_rc

end event

event type integer ue_tabpage_search_set_columns(string as_inv_type, string as_dep_type, string as_claim_type);Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_set_columns(as_inv_type,as_dep_type,as_claim_type)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_set_columns(as_inv_type,as_dep_type,as_claim_type)
End If

RETURN i_Return
end event

event ue_tabpage_source_get_source_sub_tables;call super::ue_tabpage_source_get_source_sub_tables;
Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_get_source_sub_tables(as_subset_id,as_inv_type[])
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_get_source_sub_tables(as_subset_id,as_inv_type[])
End If

RETURN i_Return
end event

event ue_drilldown_drop_temp_table;call super::ue_drilldown_drop_temp_table;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_drilldown_drop_temp_table			uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_parent_drilldown and the close event of
// w_query_engine.  It is used to drop the temp table created by this uo_query. 
// The name of the temp table is in is_drilldown_new_temp_table_name.  Since called 
// by close event, must determine if table was created. (to drop temp table will use the
// NVO defined in ts145 - NVO Temp Table)
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.	
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.	
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/09/97		Created.
//
//	F.Chernak		01/29/98		Change temp table name variable from 
//										is_drilldown_new_temp_table_name to temp table name
//										in the drilldown structure.
//
//	FDG				02/09/98		Make sure that invo_temp_table isvalid.
//										Invoke this event from the destructor event
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

if len(istr_drilldown.temp_table_name)	>	1 	&
and IsValid (invo_temp_table)						then 
	invo_temp_table.of_drop_table(istr_drilldown.temp_table_name)	//01-29-98 FNC
end if

end event

event ue_tabpage_list_construct;call super::ue_tabpage_list_construct;
Integer i_Return 

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	i_Return = invo_tabpagelist.Event ue_tabpage_list_construct(as_query_id)
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	i_Return = invo_tabpagelist.Event ue_tabpage_list_construct(as_query_id)
End If

RETURN i_Return
end event

event ue_tabpage_list_create_list;call super::ue_tabpage_list_create_list;////////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created
//
//	FDG	04/07/98	Track 1046.  Before generating a new list, invoke
//						closequery to dtermine if the prior query needs to
//						be saved.
//
////////////////////////////////////////////////////////////////////////

Integer 		i_Return 

Integer		li_rc

//	See if changes occured to the previous query
li_rc		=	This.of_GetWindow().event CloseQuery()
If	li_rc	<>	0		THEN
	// An error or a cancel occured.  Don't set up the new query.
	Return 0
End If

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	i_Return = invo_tabpagelist.Event ue_tabpage_list_create_list(as_query_id)
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	i_Return = invo_tabpagelist.Event ue_tabpage_list_create_list(as_query_id)
End If

RETURN i_Return
end event

event ue_tabpage_list_get_selected_query_id;call super::ue_tabpage_list_get_selected_query_id;
String s_Return

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_query_id()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_query_id()
End If

RETURN s_Return
end event

event ue_tabpage_search_ml_filter_check;call super::ue_tabpage_search_ml_filter_check;
Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_ml_filter_check(as_come_from)	// FNC 05/20/98
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_ml_filter_check(as_come_from)	// FNC 05/20/98 
End If

RETURN i_Return
end event

event ue_tabpage_search_add_row;call super::ue_tabpage_search_add_row;//ue_tabpage_search_add_row()
//This event is called by dw_criteria.itemchanged when logical_op 
//is changed and it is the last row.  It will add a row to end.  
//The code for this taken from stances.w_drilldown_parent.insertrow 
//event.

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	invo_tabpagesearch.Event ue_tabpage_search_add_row()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	invo_tabpagesearch.Event ue_tabpage_search_add_row()
End If
end event

event ue_tabpage_search_code_lookup;call super::ue_tabpage_search_code_lookup;//ue_tabpage_search_code_lookup(string as_value, int ai_row)
//
//This event is called by dw_criteria.rbuttondown when there 
//is no filter indicator in dw_criteria.expression_two.  
//It will set the global (gv_code_to_use) with the lookup type 
//found in the lookup field and open the code lookup window to 
//allow the user to select a value for that lookup type.  
//The value selected by the user will be placed into expression_two.  
//(Code from stances.w_drilldown_parent.dw_1.rbuttondown event)

Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_code_lookup(as_value,ai_row)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_code_lookup(as_value,ai_row)
End If

RETURN i_Return
end event

event ue_tabpage_search_set_periods;call super::ue_tabpage_search_set_periods;
tabpage_search.uo_period.uf_load_dddw('SUM',is_inv_type,'AC','TRUE')
this.event ue_tabpage_search_set_dates()


end event

event type integer ue_tabpage_search_clear();//ue_tabpage_search_clear()
//This event is called by im_search.m_clear to clear out the tabpage.
//Will clear out dw_criteria and set uo_period to the default (max date).

Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_clear()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_clear()
End If

RETURN i_Return
end event

event ue_tabpage_search_set_authorization;call super::ue_tabpage_search_set_authorization;
Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_set_authorization(as_auth_id)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_set_authorization(as_auth_id)
End If

RETURN i_Return
end event

event ue_tabpage_search_load;call super::ue_tabpage_search_load;
Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_tabpage_search_load(ai_level_num)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_tabpage_search_load(ai_level_num)
End If

RETURN li_rc
end event

event ue_tabpage_search_delete_row;call super::ue_tabpage_search_delete_row;//ue_tabpage_search_delete_row()
//This event is called by im_search.m_row.m_delete to delete 
//selected row. The code for this taken from 
//stances.w_drilldown_parent.pb_delete.clicked event.

Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_delete_row()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_delete_row()
End If

RETURN i_Return
end event

event ue_tabpage_search_insert_row;call super::ue_tabpage_search_insert_row;
Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_insert_row()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_insert_row()
End If

RETURN i_Return
end event

event ue_tabpage_search_save;call super::ue_tabpage_search_save;
Integer i_Return 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_save(ai_level,as_query_id)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpagesearch.Event ue_tabpage_search_save(ai_level,as_query_id)
End If

RETURN i_Return
end event

event ue_tabpage_view_translate_invoice_type;
String s_Return

If Not(IsValid(invo_tabpageview)) THEN
	//create the view tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	s_Return = invo_tabpageview.Event ue_tabpage_view_translate_invoice_type(as_inv_type)
	//destroy the view tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	s_Return = invo_tabpageview.Event ue_tabpage_view_translate_invoice_type(as_inv_type)
End If

RETURN s_Return
end event

event ue_tabpage_view_view_claim;call super::ue_tabpage_view_view_claim;//********************************************************************************
// 06/24/98 FNC 	Track 1409. The value sent to of_SetQueryNVO was ic_search. This
//						is incorrect since the event is on the view tab. I changed it to
//						ic_view.
//********************************************************************************

If Not(IsValid(invo_tabpageview)) THEN
	//create the view tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	invo_tabpageview.Event ue_tabpage_view_view_claim()
	//destroy the view tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	invo_tabpageview.Event ue_tabpage_view_view_claim()
End If
end event

event ue_tabpage_view_get_key_columns;call super::ue_tabpage_view_get_key_columns;
Integer i_Return 

If Not(IsValid(invo_tabpageview)) THEN
	//create the view tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	i_Return = invo_tabpageview.Event ue_tabpage_view_get_key_columns()
	//destroy the view tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	i_Return = invo_tabpageview.Event ue_tabpage_view_get_key_columns()
End If

RETURN i_Return
end event

event ue_format_where_criteria_add_clauses;call super::ue_format_where_criteria_add_clauses;
Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_format_where_criteria_add_clauses (as_type, as_where, astr_criteria)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_format_where_criteria_add_clauses (as_type, as_where, astr_criteria)
End If

RETURN li_rc

end event

event ue_drilldown_build_temp_table;call super::ue_drilldown_build_temp_table;
SetPointer(HourGlass!)

Integer	li_rc

If Not(IsValid(invo_tabpageview)) THEN
	//create the View tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	li_rc	=	invo_tabpageview.Event ue_drilldown_build_temp_table(astr_drilldown)
	//destroy the View tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	li_rc	=	invo_tabpageview.Event ue_drilldown_build_temp_table(astr_drilldown)
End If

Return	li_rc
end event

event ue_drilldown_load_new_query;call super::ue_drilldown_load_new_query;
Integer li_rc 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	li_rc = invo_tabpagesource.Event ue_drilldown_load_new_query()
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	li_rc = invo_tabpagesource.Event ue_drilldown_load_new_query()
End If

RETURN li_rc

end event

event ue_string_sql_statement;call super::ue_string_sql_statement;
If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	invo_tabpagesearch.Event ue_string_sql_statement (as_sql_statement)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	invo_tabpagesearch.Event ue_string_sql_statement (as_sql_statement)
End If

end event

event ue_new_query();/////////////////////////////////////////////////////////////////////////////
// Event/Function									Object				
//	--------------									------				
//	ue_new_query									uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by im_list.m_new to allow the user to create a new query.  
// Will enable tabpage_source, populate it with all possible query data sources, select 
// the tabpage and enable Next button.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/05/98	Created.
//	J.Mattis	01/21/98	Added code to prevent user from not saving changes before
//							new query, to reset PDQ dws, and to reset the window title.
//	J.Mattis	01/27/98	Added code to clear previous query levels.
//	J.Mattis	2/5/98 	Added code to reset unique count and is_inv_type.
//	FDG		03/02/98	Track 876.  Select the tab via an event
// FNC		03/17/98	Should not reset is_inv_type because ue_tabpage_source_construct
//							set it to the default invoice type. If this is nulled and
//							user selects the default invoice type, is_inv_type will be null.
//	FDG		03/23/98	Track 954.  Reset this tab in case a PDQ was 
//							previously displayed.
//	FDG		04/02/98	Track 1003.  Perform Closequery processing in case the
//							previous query was changed.
//	FDG		04/09/98	Track 1063.  Open up the source tab without selecting
//							a data source.
//	FDG		04/22/98	Track 1104.  Disable the link and note menu items.
//	FDG		12/04/98	Track 2004.  Pass a true/false argument to
//							ue_enable_next_button.
//	FDG		07/17/00	Track 2465c.  Stars 4.5 SP1.  Allow for FastQuery.
// FDG		09/21/01	Stars 4.8.1.	Reset the ability to update the query
// FNC		10/25/01	Track 3683 Starcare. Make the data ddlb's invisible if
//							source of query is a subset.
// LahuS 	01/21/02	Track 2552d Disable reset title for PDQ and PDR/PDCR
//	GaryR		04/17/02	Track 2552d	Predefined Reports (PDR)
//	GaryR		05/07/03	Track 3563d	Reset the title for new queries
//	GaryR		11/16/04	Track 4115d	STARS Reporting - Claims PDRs
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer		li_rc
w_query_engine	lw_parent

lw_parent	=	This.of_GetWindow()

If IsValid(lw_parent) Then
	//	See if changes occured to the previous query
	li_rc		=	lw_parent.event CloseQuery()
	If	li_rc	<>	0		THEN
		// An error or a cancel occured.  Don't set up the new query.
		Return
	End If
End If

// FDG 09/21/01 - Reset the ability to update the query
lw_parent.Event	ue_set_menus_subset_view (TRUE) 
This.Event			ue_edit_disable_tabs( FALSE )

This.Event	ue_reset_query()				//	FDG 03/23/98

ib_new_flag = TRUE

//	GaryR	04/17/02	Track 2552d - Begin
IF lw_parent.of_is_pdr_mode() THEN
	tabpage_pdr.enabled = TRUE
	tabpage_source.enabled = FALSE
ELSE
	tabpage_source.enabled = TRUE
END IF
//	GaryR	04/17/02	Track 2552d - End

tabpage_search.enabled = FALSE
tabpage_report.enabled = FALSE
tabpage_view.enabled = FALSE

If IsValid(lw_parent) Then
	lw_parent.event ue_enable_next_button(TRUE)	// FDG 12/04/98
	lw_parent.event ue_clear_pdq_datawindows()	//JTM -1/21/98 To reset PDQ dws.
	lw_parent.wf_ResetTitle()							//JTM -1/21/98	To reset the window title.
	lw_parent.wf_ClearLevels()							//JTM - 1/27/98 To clear previous query levels.
	lw_parent.event ue_set_unique_count(0,'')		//JTM - 2/5/98 To reset unique count.
	lw_parent.Event ue_set_menus_query_select (FALSE)		// FDG 04/22/98
End If

// init. the source tabpage
//	GaryR	04/17/02	Track 2552d - Begin
IF lw_parent.of_is_pdr_mode() THEN
	this.event ue_tabpage_pdr_construct()
	This.Event ue_SelectTab(IC_PDR)
ELSE
	this.event ue_tabpage_source_construct('INITIAL_LEVEL','')		// FDG 04/09/98
	This.Event ue_SelectTab(IC_SOURCE)
END IF
//	GaryR	04/17/02	Track 2552d - End

// FDG 07/17/00 
// Because dw_fastquery is an external source d/w, insert a new row
This.Event	ue_initialize_dw_fastquery()

This.Event ue_tabpage_search_set_period_visibility()			//FNC 10/25/01
This.Event ue_tabpage_search_set_pd_opt_visibility()			//FNC 10/25/01

w_main.SetMicroHelp ('Ready')				// FDG 04/02/98

end event

event ue_tabpage_list_notes;call super::ue_tabpage_list_notes;
SetPointer(HourGlass!)

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)

	invo_tabpagelist.Event ue_tabpage_list_notes()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	invo_tabpagelist.Event ue_tabpage_list_notes()
End If
end event

event ue_tabpage_list_query_save_info;call super::ue_tabpage_list_query_save_info;
SetPointer(HourGlass!)

Integer i_Return

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	i_Return = invo_tabpagelist.Event ue_tabpage_list_query_save_info(asx_Query_Save)
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	i_Return = invo_tabpagelist.Event ue_tabpage_list_query_save_info(asx_Query_Save)
End If

RETURN i_Return
end event

event ue_open_menu;call super::ue_open_menu;// display menu depending on which uo_query tabpage is selected
This.of_GetWindow().event ue_open_menu()

end event

event ue_tabpage_list_delete_query;call super::ue_tabpage_list_delete_query;
If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	invo_tabpagelist.Event ue_tabpage_list_delete_query()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	invo_tabpagelist.Event ue_tabpage_list_delete_query()
End If
end event

event ue_subsetting_set_filter_create;call super::ue_subsetting_set_filter_create;Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_subsetting_set_filter_create (asx_all_filter_info)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_subsetting_set_filter_create (asx_all_filter_info)
End If

RETURN li_rc

end event

event ue_criteriasave();If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	invo_tabpagesearch.Event ue_criteria_save ()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	invo_tabpagesearch.Event ue_criteria_save ()
End If
end event

event ue_tabpage_view_mapping;call super::ue_tabpage_view_mapping;
SetPointer(HourGlass!)

If Not(IsValid(invo_tabpageview)) THEN
	//create the View tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	invo_tabpageview.Event ue_tabpage_view_mapping()
	//destroy the View tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	invo_tabpageview.Event ue_tabpage_view_mapping()
End If

end event

event ue_window_operations(string as_operation, string as_type);//***********************************************************
//	Script:	uo_query.ue_window_operations
//
//	Arguments:	as_operation.	Values:
//										Append Col Filter
//										Create Col Filter
//										Code/Decode
//										Sort/Rank
//										Display Filter
//										Find
//					as_type = REPORT
//
//	Returns:		None
//
//	Description:
//		This event is called by m_view.m_windowoperations and
//		m_list.m_windowoperations.  It will call fx_uo_control() 
//		passing it the name of the window declared on the report (w_uo_win),
//		the name of the datawindow (determined by as_type), the name of the 
//		option selected, and the count of the datawindow.
//
//************************************************************
//	Revision History
//
//	FDG	01/07/98	Created
//	JTM   02/27/98	Added assignment to is_window_operation 
//						to hold the window operation
//						(ie. sort, filter, ...) to the doubleclicked 
//						event of dw_list & dw_report.
//	FDG	04/21/98	Track 1090.  Save the window operation in
//						case the user closes w_uo_win.
//	FDG	05/12/98	Track 1223.  Get the st_count from the
//						appropriate tab.
//	GaryR	07/29/05	Track 4432d	Allow multi-column decode in background
//	Katie	04/07/09	GNL.600.5633 Added call to populate the WO columns
//************************************************************

u_dw		ldw
GraphicObject	lgr_row_count

SetPointer(Hourglass!)

If	Upper(as_type)	=	ics_list			Then
	ldw	=	tabpage_list.dw_list
Else
	ldw	=	tabpage_view.dw_report
End If

is_operation			=	as_operation		// FDG 04/21/98
is_operation_type		=	as_type				// FDG 04/21/98

//	FDG 05/12/98 begin
//lgr_row_count			=	This.of_GetWindow().Event	ue_get_count()

IF	Upper (as_type)	=	'REPORT'		THEN
	lgr_row_count		=	tabpage_view.st_count_view
ELSE
	lgr_row_count		=	tabpage_list.st_count_list
END IF
// FDG 05/12/98 end

is_window_operation	=	fx_uo_control (iw_uo_win,		&
													ldw,				&
													as_operation,	&
													'',				&
													lgr_row_count,	&
													istr_decode_struct)

IF as_operation = "Code/Decode" THEN
	iw_uo_win.uo_decode.of_set_invoice_type (is_inv_type)		// FDG 3/23/98
//	iw_uo_win.wf_populatecolumns(istr_decode_struct,ldw)
end if
end event

event ue_tabpage_view_list;call super::ue_tabpage_view_list;
SetPointer(HourGlass!)

If Not(IsValid(invo_tabpageview)) THEN
	//create the View tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	invo_tabpageview.uf_set_istr_sql_statement (istr_sql_container)
	invo_tabpageview.Event ue_tabpage_view_list(as_type)
	//destroy the View tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	invo_tabpageview.uf_set_istr_sql_statement (istr_sql_container)
	invo_tabpageview.Event ue_tabpage_view_list(as_type)
End If

end event

event ue_tabpage_view_unique_count;call super::ue_tabpage_view_unique_count;
SetPointer(HourGlass!)

Long	ll_count

If Not(IsValid(invo_tabpageview)) THEN
	//create the View tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	ll_count	=	invo_tabpageview.Event ue_tabpage_view_unique_count(as_type)
	//destroy the View tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	invo_tabpageview.uf_set_sx_keys (istr_key_columns)
	ll_count	=	invo_tabpageview.Event ue_tabpage_view_unique_count(as_type)
End If

This.of_GetWindow().Event	ue_set_unique_count(ll_count, as_type)

end event

event ue_count();//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

w_query_engine		lw_parent
lw_parent = of_GetWindow()

//	04/17/02	GaryR	Track 2552d - Begin
IF NOT lw_parent.of_is_pdr_mode() THEN
	If Not(IsValid(invo_tabpagesearch)) THEN
		//create the search tabpage NVO
		this.of_SetQueryNVO(TRUE,ic_search)
		invo_tabpagesearch.Event ue_count ()
		//destroy the search tabpage NVO
		this.of_SetQueryNVO(FALSE,ic_search)
	Else
		invo_tabpagesearch.Event ue_count ()
	End If
END IF
//	04/17/02	GaryR	Track 2552d - End
end event

event ue_tabpage_view_detail;call super::ue_tabpage_view_detail;
SetPointer(HourGlass!)

If Not(IsValid(invo_tabpageview)) THEN
	//create the View tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	invo_tabpageview.Event ue_tabpage_view_detail()
	//destroy the View tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	invo_tabpageview.Event ue_tabpage_view_detail()
End If

end event

event ue_tabpage_report_save;call super::ue_tabpage_report_save;// This event is called by w_query_engine.ue_save_query() to load the information from 
// the tabpage to the pdq_column datawindow.

SetPointer(HourGlass!)

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_save(ai_level,as_query_id)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_save(ai_level,as_query_id)
End If

RETURN i_Return
end event

event ue_subsetting;
Integer li_rc, li_run_frequency
w_query_engine lw_parent 
boolean lb_recurring_pdq 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	
	//NLG 12-17-99 This sets the boolean in uo_query which will be passed to u_nvo_query and
	//u_nvo_create_sql that determines if query is future-dated (recurring). Need to know this
	//so that thru_date and from_date can be calculated differently than non-future dated
	this.of_getparentwindow(lw_parent)
	li_run_frequency = lw_parent.wf_get_ii_run_frequency()
	IF li_run_frequency > 0 THEN
		lb_recurring_pdq = TRUE
	ELSE
		lb_recurring_pdq = FALSE
	END IF
	invo_tabpagesearch.uf_set_ib_recurring_pdq(lb_recurring_pdq)
	//NLG 12-17-99 end 
	invo_tabpagesearch.uf_set_run_frequency(li_run_frequency)			// FNC 03/27/00	
	li_rc = invo_tabpagesearch.Event ue_subsetting (asx_subsetting_info)
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	//NLG 12-17-99 This sets the boolean in uo_query which will be passed to u_nvo_query and
	//u_nvo_create_sql that determines if query is future-dated (recurring). Need to know this
	//so that thru_date and from_date can be calculated differently than non-future dated
	this.of_getparentwindow(lw_parent)
	li_run_frequency = lw_parent.wf_get_ii_run_frequency()
	IF li_run_frequency > 0 THEN
		lb_recurring_pdq = TRUE
	ELSE
		lb_recurring_pdq = FALSE
	END IF
	invo_tabpagesearch.uf_set_ib_recurring_pdq(lb_recurring_pdq)
	invo_tabpagesearch.uf_set_run_frequency(li_run_frequency)			// FNC 03/27/00	
	//NLG 12-17-99  end
	li_rc = invo_tabpagesearch.Event ue_subsetting (asx_subsetting_info)
End If

RETURN li_rc

end event

event ue_get_new_flag;call super::ue_get_new_flag;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	uo_query						ue_get_new_flag
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event will be called by all the right mouse menu Query Save menu items to 
// determine if the Query Save is selected for an existing query or a new query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Boolean		ib_new_flag	New query flag.			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			01/15/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

return(ib_new_flag)
end event

event ue_tabpage_report_load_template;call super::ue_tabpage_report_load_template;//ue_tabpage_report_load_template
//This event is called by w_query_engine.ue_list_report_template() to load a 
//report template into instance datastores of the case_link, pdq_cntl and pdq_columns 
//tables.  Then the columns will be loaded into dw_selected on tabpage report.  
//The datastores are instances since they need to be available if the user should 
//resave this template.

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load_template(as_template_id)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load_template(as_template_id)
End If

RETURN i_Return
end event

event ue_tabpage_report_get_new_flag;call super::ue_tabpage_report_get_new_flag;//boolean ue_tabpage_report_get_new_flag()
//Called by im_report.reporttemplatesave to determine if this is the first 
//time a template is being saved or if just being updated.  
//Return true if this is a new template else return false.

Boolean lb_Return

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	lb_Return = invo_tabpagereport.Event ue_tabpage_report_get_new_flag()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	lb_Return = invo_tabpagereport.Event ue_tabpage_report_get_new_flag()
End If

RETURN lb_Return
end event

event ue_tabpage_report_get_template_info;call super::ue_tabpage_report_get_template_info;integer li_Return

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	li_Return = invo_tabpagereport.Event ue_tabpage_report_get_template_info(asx_report_template_info)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	li_Return = invo_tabpagereport.Event ue_tabpage_report_get_template_info(asx_report_template_info)
End If

RETURN li_Return
end event

event ue_tabpage_report_get_title;call super::ue_tabpage_report_get_title;String ls_Return

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	ls_Return = invo_tabpagereport.Event ue_tabpage_report_get_title()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	ls_Return = invo_tabpagereport.Event ue_tabpage_report_get_title()
End If

RETURN ls_Return
end event

event ue_tabpage_report_save_template;call super::ue_tabpage_report_save_template;//ue_tabpage_report_save_template(sx_report_template_save asx_report_template_save)
//This event is called by w_query_engine.ue_save_report_template() 
//to save a report template into the case_link, pdq_cntl and pdq_columns tables.  
//If the Path is Save As (A) then must create the datastores (n_ds) to hold this 
//info else clean out the datastores before loading the new information.  
//Finally update the datastores.  Note:  Report Templates are unique by USER_ID 
//and TEMPLATE_NAME.  To keep this replationship unique in the case_link table 
//put user_id into the case_id column.

SetPointer(HourGlass!)

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_save_template(asx_report_template_save)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_save_template(asx_report_template_save)
End If

RETURN i_Return
end event

event ue_tabpage_report_get_selected_columns;call super::ue_tabpage_report_get_selected_columns;integer li_Return

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	li_Return = invo_tabpagereport.Event ue_tabpage_report_get_selected_columns(asx_col_desc[])
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	li_Return = invo_tabpagereport.Event ue_tabpage_report_get_selected_columns(asx_col_desc[])
End If

RETURN li_Return
end event

event ue_tabpage_report_clear_break_info;call super::ue_tabpage_report_clear_break_info;sx_break_info lsx_clear_array /* defined in ts144 - Break with Totals */
istr_break_info = lsx_clear_array

RETURN 1
end event

event ue_tabpage_report_clear;//11-17-98	NLG	Track #1805.  Add argument arg_keep_title. If this script is
//						being called from w_query_engine::ue_save_query, and not
//						saving pdq columns because used default template, don't clear title
//
integer li_Return


If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	li_Return = invo_tabpagereport.Event ue_tabpage_report_clear(ab_keep_title)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	li_Return = invo_tabpagereport.Event ue_tabpage_report_clear(ab_keep_title)
End If

RETURN li_Return
end event

event ue_tabpage_report_set_break_info;call super::ue_tabpage_report_set_break_info;SetPointer(HourGlass!)

// This event is called by w_query_engine.ue_break_with_totals() to set the instance 
// structure with break info.  This structure will be used when creating the SQL to 
// determine the order by and used during the create of the datawindow to alter the syntax. 
// (sx_break_info is defined in ts144 - Break with Totals)

istr_break_info = asx_break_info

RETURN 1
end event

event ue_tabpage_view_prov_pat_drilldown;call super::ue_tabpage_view_prov_pat_drilldown;
SetPointer(HourGlass!)

string ls_key_value

If Not(IsValid(invo_tabpageview)) THEN
	//create the view tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	ls_key_value = invo_tabpageview.Event ue_tabpage_view_prov_pat_drilldown(as_tag_value)
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	ls_key_value = invo_tabpageview.Event ue_tabpage_view_prov_pat_drilldown(as_tag_value)
End If

RETURN ls_key_value
end event

event ue_tabpage_report_get_selected_col_names;call super::ue_tabpage_report_get_selected_col_names;integer li_Return = 1

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	invo_tabpagereport.Event ue_tabpage_report_get_selected_col_names(astr_selected_cols[])
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	invo_tabpagereport.Event ue_tabpage_report_get_selected_col_names(astr_selected_cols[])
End If

RETURN li_Return
end event

event ue_tabpage_list_get_selected_user_id;call super::ue_tabpage_list_get_selected_user_id;
String s_Return

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_user_id()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_user_id()
End If

RETURN s_Return
end event

event ue_tabpage_list_get_selected_case_id;call super::ue_tabpage_list_get_selected_case_id;
String s_Return

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_case_id()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_case_id()
End If

RETURN s_Return
end event

event ue_tabpage_list_get_selected_case_spl;call super::ue_tabpage_list_get_selected_case_spl;
String s_Return

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_case_spl()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_case_spl()
End If

RETURN s_Return
end event

event ue_tabpage_list_get_selected_case_ver;call super::ue_tabpage_list_get_selected_case_ver;
String s_Return

If Not(IsValid(invo_tabpagelist)) THEN
	//create the list tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_list)
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_case_ver()
	//destroy the list tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_list)
Else
	s_Return = invo_tabpagelist.Event ue_tabpage_list_get_selected_case_ver()
End If

RETURN s_Return
end event

event type integer ue_selecttab(integer ai_tabpage);/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.ue_selecttab
//	
//	Arguments:	ai_tabpage - The tab to select.  If = 0, then
//					the tabpage was already selected.
//
//	Returns:		None
//
//	Description:	
//		The Selecting of a new tab is always performed thru this
//		event.  This event will select the tabpage passed and
//		will determine if the Next button is to be enabled.
//
//		This event is also called during the selectionchanged event.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	03/02/98	Created via track 876.
//
//	FDG	12/04/98	Track 2004.  Pass a true/false argument to
//						ue_enable_next_button.
//
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
//	05/20/09	Katie	GNL.600.5633	Set focus on the datawindow when the view report tab is selected.
//						
/////////////////////////////////////////////////////////////////////////////

Integer	li_tabpage

w_query_engine		lw_parent

lw_parent	=	This.of_GetWindow()

IF	ai_tabpage	=	0		THEN
	//	The tabpage has been selected by the user.  Find out
	//	which tabpage was clicked by the user.
	li_tabpage	=	This.SelectedTab
ELSE
	//	The tabpage needs to be programmatically set.
	li_tabpage	=	ai_tabpage
	This.SelectTab (li_tabpage)
END IF


CHOOSE CASE li_tabpage
	CASE ic_list
		//	PDQ (List) tab
		//	GaryR	04/17/02	Track 2552d
		IF	( tabpage_pdr.enabled AND tabpage_pdr.visible ) &
		OR tabpage_source.enabled	=	TRUE		&
		OR	tabpage_search.enabled	=	TRUE		&
		OR	tabpage_report.enabled	=	TRUE		&
		OR	tabpage_view.enabled		=	TRUE		THEN
			lw_parent.Event	ue_enable_next_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_next_button(FALSE)
		END IF
		lw_parent.Event	ue_enable_prev_button(FALSE)
		
	//	GaryR	04/17/02	Track 2552d - Begin	
	CASE ic_pdr
		//	PDR tab
		IF	tabpage_source.enabled	=	TRUE		&
		OR tabpage_search.enabled	=	TRUE		&
		OR	tabpage_report.enabled	=	TRUE		&
		OR	tabpage_view.enabled		=	TRUE		THEN
			lw_parent.Event	ue_enable_next_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_next_button(FALSE)
		END IF
		IF	tabpage_list.enabled		=	TRUE		THEN
			lw_parent.Event	ue_enable_prev_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_prev_button(FALSE)
		END IF
	//	GaryR	04/17/02	Track 2552d - End
	
	CASE ic_source
		//	Source tab
		IF	tabpage_search.enabled	=	TRUE		&
		OR	tabpage_report.enabled	=	TRUE		&
		OR	tabpage_view.enabled		=	TRUE		THEN
			lw_parent.Event	ue_enable_next_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_next_button(FALSE)
		END IF
		
		//	GaryR	04/17/02	Track 2552d
		IF	tabpage_list.enabled		=	TRUE		&
		OR ( tabpage_pdr.enabled AND tabpage_pdr.visible )	THEN
			lw_parent.Event	ue_enable_prev_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_prev_button(FALSE)
		END IF
	
	CASE ic_search
		//	Search tab
		IF	tabpage_report.enabled	=	TRUE		&
		OR	tabpage_view.enabled		=	TRUE		THEN
			lw_parent.Event	ue_enable_next_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_next_button(FALSE)
		END IF
		
		//	GaryR	04/17/02	Track 2552d
		IF	tabpage_list.enabled		=	TRUE		&
		OR ( tabpage_pdr.enabled AND tabpage_pdr.visible )	&
		OR	tabpage_source.enabled	=	TRUE		THEN
			lw_parent.Event	ue_enable_prev_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_prev_button(FALSE)
		END IF
	CASE ic_report
		//	Report tab
		IF	tabpage_view.enabled		=	TRUE		THEN
			lw_parent.Event	ue_enable_next_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_next_button(FALSE)
		END IF
		
		//	GaryR	04/17/02	Track 2552d
		IF	tabpage_list.enabled		=	TRUE		&
		OR ( tabpage_pdr.enabled AND tabpage_pdr.visible )	&
		OR	tabpage_source.enabled	=	TRUE		&
		OR	tabpage_search.enabled	=	TRUE		THEN
			lw_parent.Event	ue_enable_prev_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_prev_button(FALSE)
		END IF
	CASE ic_view
		//	Report tab
		lw_parent.Event	ue_enable_next_button(FALSE)
		
		//	GaryR	04/17/02	Track 2552d
		IF	tabpage_list.enabled		=	TRUE		&
		OR ( tabpage_pdr.enabled AND tabpage_pdr.visible )	&
		OR	tabpage_source.enabled	=	TRUE		&
		OR	tabpage_search.enabled	=	TRUE		&
		OR	tabpage_report.enabled	=	TRUE		THEN
			lw_parent.Event	ue_enable_prev_button(TRUE)
		ELSE
			lw_parent.Event	ue_enable_prev_button(FALSE)
		END IF
		tabpage_view.dw_report.setfocus()
	CASE ELSE
		Return	-1
END CHOOSE

Return 1


end event

event type integer ue_tabpage_source_set_subset_id(integer ai_row, string as_subset_name);//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

SetPointer(HourGlass!)

Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_set_subset_id( ai_row, as_subset_name )
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_set_subset_id( ai_row, as_subset_name )
End If

RETURN i_Return
end event

event ue_tabpage_source_set_subset_data_source;call super::ue_tabpage_source_set_subset_data_source;
SetPointer(HourGlass!)


Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_set_subset_data_source(as_subset_id)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_set_subset_data_source(as_subset_id)
End If

RETURN i_Return
end event

event ue_reset_query();/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.ue_reset_query 
//	
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//		This event is triggered when the user selects a PDQ or creates a 
//		new PDQ.  This script will clear out any data and attributes set
//		from the previously displayed PDQ.
//
//	Note:
//		This event must execute before ue_tabpage_source_construct and
//		ue_tabpage_source_load.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	03/23/98	Track 954.  Created
//	FDG	03/27/98	Track 972.  Clear out the mle on tabpage report.
//	FDG	04/02/98	Track 1003. Reset the flag that says if a row has been
//						deleted in dw_criteria.
//	FDG	04/02/98	Track 1014. Reset is_add_inv_type & is_old_inv_type.  These
//						two fields are used to determine if dw_criteria and
//						dw_selected are to be reset within dw_source.itemchanged.
//	FDG	04/02/98	Track 959.  Reset is_inv_description.
//	FDG	04/21/98	Track 1090.  If a window operation was performed on dw_report
//						of the previous PDQ, then close the window and reset it's
//						variables.
//	FDG	05/12/98	Track 1223.  Reset the counts.
//	FDG	05/13/98	Track 1237.  Reset Super provider query structure.
//	FNC	07/22/98	Track 1514. Reset sx_filter_info.
// AJS   08/25/98 TS144-Report On Enhancements
// AJS   08/28/98 Reset report template datastores
//	FDG	10/14/98	Track 1831.  ii_spq_row & ib_super_provider_query are no
//						longer used.
//	FDG	02/05/99	Track 2084c.  Pass '' to wf_clear_filter_info to ensure
//						that only the current level gets cleared.
//	FDG	02/12/02	Track 2806d.  Clear out istr_subsetting_info to prevent extra
//						Filter Copy step from being created.
//	GaryR	11/10/03	Track 3697d	Release memory on reset of report datawindow
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
/////////////////////////////////////////////////////////////////////////////

//	Reset the invoice type information
is_inv_type			=	''
is_source_type		=	''
is_add_inv_type	=	''			// FDG 04/02/98
is_old_inv_type	=	''			// FDG 04/02/98
is_inv_description	=	''		// FDG 04/02/98 (Track 959)

//	Reset "Window Operations"
sx_decode_structure	lstr_decode_struct
istr_decode_struct	=	lstr_decode_struct
is_window_operation	=	''
is_selected				=	''

IF	IsValid (iw_uo_win)		THEN
	Close (iw_uo_win)
END IF

tabpage_report.mle_title.text	=	''

//	Reset the previously created report
tabpage_view.dw_report.dataobject = 'd_initial'

// Reset Super Provider Query
sx_prov_query_structure		lstr_prov_query	// FDG 05/13/98
istr_prov_query			=	lstr_prov_query	// FDG 05/13/98
istr_npi_prov_query		=	lstr_prov_query
sx_break_info					lstr_break_info
istr_break_info			=	lstr_break_info


// Reset Retrieve cancelled
ib_retrievecancelled		=	FALSE

// Reset the flag which states that the user changed date criteria
//	set by a period (new queries only).
ib_criteria_date_change	=	FALSE

//	Reset dw_criteria data
This.of_GetWindow().wf_SetRowDelete(FALSE)					//FDG 04/02/98 (track 1003)

// Reset the counts on the tabpages
tabpage_search.st_count_search.text				=	''
tabpage_search.st_count_view_search.text		=	''
tabpage_search.st_text_view_search.text		=	''
tabpage_report.st_count_report.text				=	''
tabpage_view.st_count_view.text					=	''
tabpage_view.st_unique_count_view.text			=	''
tabpage_view.st_unique_text_view.text			=	''
tabpage_search.st_count_view_search.visible	=	FALSE
tabpage_search.st_text_view_search.visible	=	FALSE

// FDG 04/21/98 begin
// Determine if a window operation was performed on dw_report of
//	the previous PDQ.

IF	is_operation_type	=	'REPORT'			THEN
	is_operation_type	=	''
	is_operation		=	''
	IF	IsValid (iw_uo_win)					THEN
		Close (iw_uo_win)
	END IF
END IF

// FDG 04/21/98 end

This.of_GetWindow().wf_clear_filter_info('') 		// FNC 07/22/98 	// FDG 02/05/99

// AJS 08/25/98 TS144-Report On Enhancements
This.of_set_ib_load_template(FALSE)

// AJS 08/28/98 Reset report template datastores
ids_report_template_case_link.Reset()
ids_report_template_pdq_cntl.Reset()
ids_report_template_pdq_columns.Reset()

//	NLG 11-17-99	Set the run frequency to zero and empty the ddlb
this.of_set_run_frequency(0)
this.event ue_reset_payment_date_opt()//of_set_pd_opt_desc(' ')

// FDG 02/12/02 - Reset subsetting info
sx_subsetting_info	lstr_subsetting_info
This.of_set_istr_subsetting_info (lstr_subsetting_info)

end event

event ue_edit_initial_search_by_data();/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.ue_edit_initial_search_by_data
//	
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//		This event is triggered from dw_source.itemchanged when either the
//		data source or the additional data source changes.  If the additional
//		data source changed, this event only triggers if there was a previous
//		value.
//
//		This script will determine the initial data to be loaded in "Search By"
//		tab.  the logic in this script was moved from dw_source.itemchanged
//		event.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	04/02/98	Track 1014. Created.
//	NLG	11/22/99	Fraud PDQ changes. When datasource is ancillary,
//						set payment date options listbox invisible.
// FNC	02/20/00 Track 2089 - If period = NONE then make first row of
//						criteria contain payment date with nothing in 
//						expression two.
//	GaryR	07/05/01	Track	2358d	Changing additional data source creates second Paid Date.
// FNC	10/24/01	Track 3683 Starcare. Make the data ddlb's invisible if
//							source of query is a subset.
//	GaryR	09/12/02	Track	3275d	Display the available claims range.
//	GaryR	03/26/03	Track 3490d	Clean up payment date logic
/////////////////////////////////////////////////////////////////////////////

boolean	lb_visible
integer	li_exp1_count,	&
			li_rowcount,	&
			li_row
string	ls_find,			&
			ls_exp1,			&
			ls_col
			
Datetime	ldtm_from_date, ldtm_to_date		//	GaryR	09/12/02	Track	3275d		

w_query_engine lw_parent
datawindowchild	ldwc_exp1

IF is_subset_id	=	''			THEN 
	tabpage_search.enabled	=	TRUE
	This.event ue_tabpage_search_set_columns(is_inv_type,'','M') 
	This.event ue_tabpage_search_set_period_visibility()
	This.event ue_tabpage_search_set_pd_opt_visibility()//NLG 11/22/99	
	
	IF Upper(Trim(is_source_type)) <> 'AN' or is_data_type = 'BASE' THEN //FNC 10/24/01
		// Set period only for claims
		This.event ue_tabpage_search_set_period()
//FNC 12/13/99		Start		
//		lw_parent = this.of_getwindow()
//		lb_visible = lw_parent.event ue_determine_pd_opt_visibility()
//	ELSE
//		lb_visible = FALSE
	END IF
// FNC 12/13/99 End
	
	IF Upper( is_data_type ) = 'SUBSET' THEN Return
	
	//	GaryR	09/12/02	Track	3275d - Begin
	IF Upper(Trim(is_source_type)) <> 'AN' THEN
		IF gnv_server.of_GetLoadedRange( is_inv_type, is_add_inv_type, ldtm_from_date, ldtm_to_date ) < 0 THEN
			tabpage_search.gb_available_claims.text = "No common claims range"
		ELSE
			tabpage_search.gb_available_claims.text = "Claims available from " + &
												String( ldtm_from_date, "mm/dd/yyyy" ) + " to " + &
												String( ldtm_to_date, "mm/dd/yyyy" )
		END IF
	END IF
	//	GaryR	09/12/02	Track	3275d - End

	// FNC 02/22/00 Start
	
	//	GaryR	07/05/01	Track	2358d - Begin
	ls_find = "mid(expression_one,4) = 'PAYMENT_DATE'"
	li_row = tabpage_search.dw_criteria.find( ls_find,1,tabpage_search.dw_criteria.Rowcount() )	
	IF li_row > 0 THEN RETURN
	//	GaryR	07/05/01	Track	2358d - End
	
	tabpage_search.dw_criteria.getchild('expression_one',ldwc_exp1)
	li_exp1_count = ldwc_exp1.rowcount()
	
	ls_find = "mid(col_name,4) = 'PAYMENT_DATE'"
	li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)
	
//	li_rowcount = tabpage_search.dw_criteria.rowcount()
	
	If li_row > 0 Then
		ls_col = ldwc_exp1.getitemstring(li_row,'col_name')
		tabpage_search.dw_criteria.setitem(1,'expression_one',ls_col)
		tabpage_search.dw_criteria.setitem(1,'relational_op','BETWEEN')
		tabpage_search.dw_criteria.setitem(1,'expression_two','')
		// Protect_row_sw is a new column.  The Protect attribute 
		// expression looks at the contents of this column.  In
		//	the d/w object, if protect_row_sw = Y, then each column
		//	is protected.
		tabpage_search.dw_criteria.setitem(li_row,'protect_row_sw','Y')
	END IF
END IF
// FNC 02/22/00 End
end event

event type integer ue_tabpage_source_filter_data_source();// Create 04/14/98
//	GaryR		12/20/07	SPR 5199	Add the facility to categorize and sort data sources

Integer i_Return 

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	i_Return = invo_tabpagesource.Event ue_tabpage_source_filter_data_source()
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	i_Return = invo_tabpagesource.Event ue_tabpage_source_filter_data_source()
End If

Return i_Return
end event

event ue_tabpage_search_edit_report_dates;call super::ue_tabpage_search_edit_report_dates;// This event is called when a report is being generated.  It will trigger
// the script to determine whether or not to add a payment date to the
// criteria.  This will be needed when a from date is entered without a
//	payment date

Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_tabpage_search_edit_report_dates()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_tabpage_search_edit_report_dates()
End If

RETURN li_rc

end event

event ue_set_ancillary_inv_type;/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.ue_set_ancillary_inv_type 
//	
//	Arguments:	as_data_source - The data source on the Source tab
//
//	Returns:		None
//
//	Description:	
//		This event will take the data source and determine if it is
//		an ancillary data source (i.e. EN - enrollee, PV - providers).
//		This will set boolean ib_ancillary_inv_type.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	05/07/98	Track 1207.  Created.
//	FDG	10/23/98	Track 1934.  Set to ancillary if not found (i.e. PA won't
//						be found).
//	FDG	10/28/98	Track 1867.  If found, use li_find_row instead of li_row
//						when setting ls_rel_type
//	NLG	11/22/99	Track 2075d. Clear out is_source_type if not ancillary invoice type.
//						Was causing prob if started w/ancillary then switched to non-ancillary
// FNC 	03/09/00	Track 2791 starcare. If the table might be a dependent of an
//						ancillary table.
/////////////////////////////////////////////////////////////////////////////

Integer	li_row,				&
			li_rowcount,		&
			li_find_row
String	ls_rel_type,		&
			ls_filter,			&
			ls_main_tbl,		&
			ls_tbl_type

DataWindowChild	ldwc_data_source

ib_ancillary_inv_type	=	FALSE

tabpage_source.dw_source.GetChild('data_source',ldwc_data_source)

li_row			=	ldwc_data_source.RowCount()
li_find_row	=	ldwc_data_source.Find ("compute_0001='" + as_data_source + "'", 1, li_row)

IF	li_find_row	>	0		THEN
	ls_rel_type	=	ldwc_data_source.GetItemString (li_find_row, 'stars_rel_rel_type')
	IF Upper (ls_rel_type)		=	'AN'		THEN
		ib_ancillary_inv_type	=	TRUE
		is_source_type				=	'AN'					// FDG 06/15/98
	ELSE							//NLG 11-22-99 
		is_source_type = ''	//nlg 11-22-99 clear out is_source_type
	END IF				
ELSE													// FNC 03/09/00 Start
	ls_tbl_type = left(as_data_source,2)
	ls_filter = "rel_type = 'DP' and id_2 = '" + ls_tbl_type +"'"
	w_main.dw_stars_rel_dict.SetFilter("")  /* clear out */
	w_main.dw_stars_rel_dict.Filter()
	w_main.dw_stars_rel_dict.SetFilter(ls_filter)
	w_main.dw_stars_rel_dict.Filter()
	
	if w_main.dw_stars_rel_dict.rowcount() = 1 then
		ls_main_tbl = w_main.dw_stars_rel_dict.object.rel_id[1] 
		ls_filter = "rel_id = '" + ls_main_tbl +"'"
		w_main.dw_stars_rel_dict.SetFilter("")  /* clear out */
		w_main.dw_stars_rel_dict.Filter()
		w_main.dw_stars_rel_dict.SetFilter(ls_filter)
		w_main.dw_stars_rel_dict.Filter()
		li_rowcount = w_main.dw_stars_rel_dict.rowcount()
		if li_rowcount > 1 then
			for li_row = 1 to li_rowcount
				ls_rel_type = w_main.dw_stars_rel_dict.object.rel_type[li_row]
				if Upper(ls_rel_type) = 'AN' then
					ib_ancillary_inv_type	=	TRUE
					exit
				end if
			next
		end if
	end if											// FNC 03/09/00 End
//	// FDG 10/23/98 begin
//	IF	li_row	>	0			THEN
//		ib_ancillary_inv_type	=	TRUE
//		is_source_type				=	'AN'	
//	END IF
//	// FDG 10/23/98 end	
END IF

end event

event type integer ue_add_data_source_change(string as_add_data_source);//	12/21/07	GaryR	SPR 5234	Add descriptions to selected data sources

Integer li_rc 

//	Set the data source description
This.Post Event ue_tabpage_source_get_desc()

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	li_rc = invo_tabpagesource.Event ue_add_data_source_change(as_add_data_source)
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	li_rc = invo_tabpagesource.Event ue_add_data_source_change(as_add_data_source)
End If

RETURN li_rc
end event

event ue_set_count_list;call super::ue_set_count_list;//*********************************************************************************
// Event:		uo_query.ue_set_count_list
//
//	Descrption:
//		This script will get and set the count for the list tab.
//
//*********************************************************************************
// History
//
//	FDG	05/12/98	Track 1223.  Created.
//
//*********************************************************************************

Long		ll_rowcount

ll_rowcount		=	tabpage_list.dw_list.RowCount()

tabpage_list.st_count_list.text	=	String (ll_rowcount)

end event

event ue_set_count_search;call super::ue_set_count_search;//*********************************************************************************
// Event:		uo_query.ue_set_count_search
//
//	Descrption:
//		This script will get and set the count for the search tab.
//
//*********************************************************************************
// History
//
//	FDG	05/12/98	Track 1223.  Created.
//
//*********************************************************************************

Long		ll_rowcount

ll_rowcount		=	tabpage_search.dw_criteria.RowCount()

tabpage_search.st_count_search.text	=	String (ll_rowcount)

end event

event ue_set_count_report();//*********************************************************************************
// Event:		uo_query.ue_set_count_report
//
//	Descrption:
//		This script will get and set the count for the report tab.
//
//*********************************************************************************
// History
//
//	FDG	05/12/98	Track 1223.  Created.
//
//*********************************************************************************

Long		ll_rowcount

ll_rowcount		=	tabpage_report.dw_selected.RowCount()

tabpage_report.st_count_report.text		=	String (ll_rowcount) + " columns selected"
tabpage_report.st_available_count.text	=	String (tabpage_report.dw_available.RowCount()) + " columns available"

end event

event ue_set_count_view;call super::ue_set_count_view;//*********************************************************************************
// Event:		uo_query.ue_set_count_view
//
//	Descrption:
//		This script will get and set the count for the view tab.
//
//*********************************************************************************
// History
//
//	FDG	05/12/98	Track 1223.  Created.
//
//*********************************************************************************

Long		ll_rowcount

ll_rowcount		=	tabpage_view.dw_report.RowCount()

tabpage_view.st_count_view.text				=	String (ll_rowcount)
tabpage_search.st_count_view_search.text	=	String (ll_rowcount)

end event

event ue_tabpage_report_get_selected;call super::ue_tabpage_report_get_selected;//ue_tabpage_report_get_selected
//History:
// 8-21-98	NLG Created.

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_get_selected()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_get_selected()
End If

RETURN i_Return
end event

event ue_tabpage_report_load_user_template;call super::ue_tabpage_report_load_user_template;//ue_tabpage_report_load_user_template
//History:
// 8-21-98	NLG Created.
//

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load_user_template()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load_user_template()
End If

RETURN i_Return
end event

event ue_tabpage_report_load_system_template;call super::ue_tabpage_report_load_system_template;//ue_tabpage_report_load_system_template
//History:
// 8-21-98	NLG Created.
//

Integer i_Return 

If Not(IsValid(invo_tabpagereport)) THEN
	//create the report tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_report)
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load_system_template()
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_report)
Else
	i_Return = invo_tabpagereport.Event ue_tabpage_report_load_system_template()
End If

RETURN i_Return
end event

event rbuttonup;This.event ue_open_menu()

Return 1


end event

event type integer ue_subsetting_clear_filter_copy();Integer li_rc 

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_subsetting_clear_filter_copy()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_subsetting_clear_filter_copy()
End If

// FDG 03/13/02	Track 2806d - reset filter copy on this object
String	ls_clear_array[]

istr_subsetting_info.filter_copy	=	ls_clear_array


RETURN li_rc
end event

event ue_prev_tabpage();//////////////////////////////////////////////////////////////////////////
//	Event:		ue_prev_tabpage()
//
//	This event is called by w_query_engine.cb_next.clicked to determine 
//	which tabpage on uo_query is selected and select the next 
//	enabled tabpage.  (Do not have to worry about last instance 
//	since cb_next will be invisible on last tab.)
//
//////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	03/02/98	Track 2004.  Created.
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
//
//////////////////////////////////////////////////////////////////////////


choose case this.selectedtab
	case ic_view
		if this.tabpage_report.enabled then
			This.Event ue_SelectTab(IC_REPORT)
		else 
			if this.tabpage_search.enabled then
				This.Event ue_SelectTab(IC_SEARCH)
			else 
				if this.tabpage_source.enabled then
					This.Event ue_SelectTab(IC_SOURCE)
				else 
					
					//	GaryR	04/17/02	Track 2552d - Begin
					IF tabpage_pdr.visible AND tabpage_pdr.enabled THEN 
						Event ue_SelectTab(IC_PDR)
						Return
					END IF
					//	GaryR	04/17/02	Track 2552d - End
					
					if this.tabpage_list.enabled then
						This.Event ue_SelectTab(IC_LIST)
					else
						//MessageBox('Error',&
						//'Please select a pre-defined query before	proceeding.',&
						//StopSign!,Ok!)
						Return
					end if
				End If
			End If
		End If
	case ic_report
		if this.tabpage_search.enabled then
			This.Event ue_SelectTab(IC_SEARCH)
		else 
			if this.tabpage_source.enabled then
				This.Event ue_SelectTab(IC_SOURCE)
			else 
				//	GaryR	04/17/02	Track 2552d - Begin
				IF tabpage_pdr.visible AND tabpage_pdr.enabled THEN 
					Event ue_SelectTab(IC_PDR)
					Return
				END IF
				//	GaryR	04/17/02	Track 2552d - End
				
				if this.tabpage_list.enabled then
					This.Event ue_SelectTab(IC_LIST)
				else
					//MessageBox('Error',&
					//'Please select a data source before	proceeding.',&
					//StopSign!,Ok!)
					Return
				end if
			End If
		End If
	case IC_SEARCH
		if this.tabpage_source.enabled then
			This.Event ue_SelectTab(IC_SOURCE)
		else
			//	GaryR	04/17/02	Track 2552d - Begin
			IF tabpage_pdr.visible AND tabpage_pdr.enabled THEN 
				Event ue_SelectTab(IC_PDR)
				Return
			END IF
			//	GaryR	04/17/02	Track 2552d - End
			
			if this.tabpage_list.enabled then
				This.Event ue_SelectTab(IC_LIST)
			else
				//MessageBox('Error',&
				//	'Please select criteria before proceeding.',&
				//	StopSign!,Ok!)
				Return
			end if
		End If
		
	case ic_source
		//	GaryR	04/17/02	Track 2552d - Begin
		IF tabpage_pdr.visible AND tabpage_pdr.enabled THEN 
			Event ue_SelectTab(IC_PDR)
			Return
		END IF
		//	GaryR	04/17/02	Track 2552d - End
		
		if this.tabpage_list.enabled then
			This.Event ue_SelectTab(IC_LIST)
		else
			//MessageBox('Error',&
			//	'Please select report column(s) before proceeding.',&
			//StopSign!,Ok!)
			Return
		end if
		
	//	GaryR	04/17/02	Track 2552d - Begin
	case ic_pdr
		if this.tabpage_list.enabled then
			This.Event ue_SelectTab(IC_LIST)
		else
			//MessageBox('Error',&
			//	'Please select report column(s) before proceeding.',&
			//StopSign!,Ok!)
			Return
		end if		
	//	GaryR	04/17/02	Track 2552d - End	
		
	case else
		//MessageBox('Error',&
		//'This tab should not be visible. SelectedTab = ' &
		//+ String(this.selectedTab) &
		//+ '. Please contact VIPS',&
		//StopSign!,Ok!)
		Return

end choose

end event

event ue_set_payment_date;// uo_query.ue_set_payment_date
//
//	Returns:	integer 
//	Arguments:	none
//
//	This event redirects the logic to the same event name in u_nvo_search
//
//	NLG	10-27-99	ts2364c Created
///////////////////////////////////////////////////////////////////////



Integer li_rc 
If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	li_rc = invo_tabpagesearch.Event ue_set_payment_date()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	li_rc = invo_tabpagesearch.Event ue_set_payment_date()
End If

RETURN li_rc

end event

event ue_reset_payment_date_opt;//*********************************************************************************
// Event:		uo_query.ue_reset_payment_date_opt
//
//	Descrption:
//		This script is called when the period in uo_period changes.
//		It empties the payment date options dropdown listbox.
//
//*********************************************************************************
// History
//
//	NLG	11/08/99 ts2463c Fraud PDQ.  Created.
//	FNC	02/22/00	Set run frequency in w_query_engien by calling deterimine_ue_pd_opt_visibility
//						rather than triggering selection changed so that period
//						doesn't keep getting reset to NONE.
//*********************************************************************************


w_query_engine lw_parent

//tabpage_search.ddlb_pd_opt.text = ''

tabpage_search.ddlb_pd_opt.selectItem(1)			

//NLG 12-22-99 This will set the run_frequency back to 0 in w_query_engine

// FNC 02/22/00 Start
//tabpage_search.ddlb_pd_opt.triggerevent(selectionchanged!)	
//
lw_parent = of_getwindow()
lw_parent.wf_set_ii_run_frequency(ii_run_frequency)
lw_parent.event ue_determine_pd_opt_visibility()

// FNC 02/22/00 End

return 1

end event

event ue_tabpage_search_set_pd_opt_visibility;//uo_tabpage_search_set_pd_opt_visibility()
//This event is called by the itemchanged event of 
//tabpage_source.dw_source.  It sets payment_date_options listbox to be visible for 
//claim queries and invisible for ancillary table queries.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	NLG		11/22/99		Created.
/////////////////////////////////////////////////////////////////////////////

If Not(IsValid(invo_tabpagesearch)) THEN
	//create the search tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_search)
	invo_tabpagesearch.Event ue_tabpage_search_set_pd_opt_visibility()
	//destroy the search tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_search)
Else
	invo_tabpagesearch.Event ue_tabpage_search_set_pd_opt_visibility()
End If
end event

event ue_notes;//*********************************************************************************
// Script Name:	uo_query.ue_notes()
//
//	Arguments:		None
//						
//
// Returns:			None
//
//	Description:	When user clicks on the notes icon, open the note list
//						window
//		
//
//*********************************************************************************
//	
// 12/03/1999	NLG	Created
//
//*********************************************************************************

SetPointer(HourGlass!)

/*this is from m_notes.clicked() */
//iw_Parent		=	This.ParentWindow
//
//If IsValid(iw_Parent) Then
//	iuo_Query	=	iw_Parent.wf_GetActiveQuery()
//End If
//
//If IsValid(iuo_Query) Then
//	iuo_Query.Event	ue_tabpage_list_notes()
//End If

/*this is from 12-3-99*/
//integer li_rc
//string ls_case_id, ls_case_spl, ls_case_ver, ls_case
//
//ls_case = ls_case_id + ls_case_spl + ls_case_ver
//
//Setpointer(hourglass!)
//setmicrohelp(w_main,'Ready')
//
//
//n_cst_notes lnv_notes	//autoinstantiated
//
//lnv_notes.is_notes_from = 'PQ'
//
//if trim(UPPER(ls_case)) = 'NONE' then
//	lnv_notes.is_notes_rel_id = is_query_id
//	lnv_notes.is_notes_rel_type = 'PQ'
//	lnv_notes.is_notes_sub_type = 'GI'
//else
//	li_rc = MessageBox("NOTES","Notes will be attached to the case, not the query."+&
//								"~rDo you want to view or add case notes?",exclamation!,YesNo!)
//	if li_rc = 2 then return
//	lnv_notes.is_notes_rel_id = ls_case 
//	lnv_notes.is_notes_rel_type = 'CA'
//	lnv_notes.is_notes_sub_type = 'PQ'
//end if
//
//OpenSheetWithParm(w_notes_list,lnv_notes,MDI_main_frame,help_menu_position,Layered!)
//

this.event ue_tabpage_list_notes()
end event

event ue_clear_pd_opt;//*********************************************************************************
// Script Name:	uo_query.ue_clear_pd_opt
//
//	Arguments:		None
//						
// Returns:			Integer
//
//	Description:	This event is called when a level is added to the pdq.
//						For levels 2+, clear out the recurring pdq entries in
//						the payment date options listbox
//		
//
//*********************************************************************************
//	
// 12/09/99 NLG	Created.
//
//*********************************************************************************



integer li_index,li_delete

li_index = tabpage_search.ddlb_pd_opt.finditem("M",0)
if li_index > 0 then
	li_delete = tabpage_search.ddlb_pd_opt.deleteItem(li_index)
end if

li_index = tabpage_search.ddlb_pd_opt.finditem("Q",0)
if li_index > 0 then
	li_delete = tabpage_search.ddlb_pd_opt.deleteItem(li_index)
end if

li_index = tabpage_search.ddlb_pd_opt.finditem("S",0)
if li_index > 0 then
	li_delete = tabpage_search.ddlb_pd_opt.deleteItem(li_index)
end if 

li_index = tabpage_search.ddlb_pd_opt.finditem("A",0)
if li_index > 0 then
	li_delete = tabpage_search.ddlb_pd_opt.deleteItem(li_index)
end if

return 1
end event

event ue_set_query_engine_run_frequency;//*********************************************************************************
// Script Name:	uo_query.ue_set_query_engine_run_frequency	
//
//	Arguments:		ai_run_frequency
//						
// Returns:			Integer
//
//	Description:	This event is called from uo_query.ddlb_pd_opt.selectionchanged
//						if this is level 1. Set w_query_engine.ii_run_frequency. 
//		
//*********************************************************************************
//	
// 12/13/99 NLG	Created
//
//*********************************************************************************

Integer		li_rc,	&
				li_run_frequency



w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)
IF li_rc < 1 THEN
	return -1
END IF

lw_parent.wf_set_ii_run_frequency(ai_run_frequency)

return 1
end event

event ue_initialize_dw_fastquery();/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.ue_initialize_dw_fastquery
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//		This event will initialize the settings for dw_fastquery (residing 
//		on the Customize Report tab).  sys_cntl will be read to determine
//		how dw_fastquery will be initialized.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY     
//    
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Created.
// Lahu S 			Track 2552d Set initial value (checked) for fastquery
//	GaryR	12/11/04	Track 4108d	Dynamic Report Options
/////////////////////////////////////////////////////////////////////////////

Long		ll_row

Integer	li_fastquery

String	ls_enable_max_rows

// Insert a new row since dw_fastquery is an external source d/w.
tabpage_report.dw_fastquery.Reset()
ll_row		=	tabpage_report.dw_fastquery.InsertRow(0)

tabpage_report.dw_fastquery.ScrollToRow(ll_row)
This.of_SetDWLimit (gc_dw_limit)

// Initialize dw_fastquery.
This.Event	ue_edit_enable_fastquery()



end event

event ue_edit_enable_fastquery();/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.ue_edit_enable_fastquery
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//		This event will initialize the settings for dw_fastquery (residing 
//		on the Customize Report tab).  sys_cntl will be read to determine
//		how dw_fastquery will be initialized.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY     
//    
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Created.
//	FDG	02/27/01	Stars 4.6.  Allow a client to have option #4 which would
//						default the usage of fastquery.
//	GaryR	12/11/04	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////////////////

Integer	li_fastquery
String	ls_enable_max_rows
w_query_engine		lw_parent

lw_parent	=	This.of_GetWindow()
IF lw_parent.of_is_pdr_mode() THEN
	//	Turn off fast query
	li_fastquery = 0
ELSE
	// Read sys_cntl to determine how FastQuery is being used	
	Select	cntl_no, 
				cntl_case
	Into		:li_fastquery,
				:ls_enable_max_rows
	From		sys_cntl
	Where		cntl_id	=	'FASTQUERY'
	Using		Stars2ca;
	
	IF	Stars2ca.of_check_status()	<>	0		THEN
		MessageBox ('Application Error', 'Cannot retrieve sys_cntl where cntl_id = FASTQUERY.'	+	&
						'  Script: uo_query.ue_initialize_dw_fastquery')
		// Default to not allowing fast query
		tabpage_report.dw_fastquery.visible		=	FALSE
		tabpage_report.dw_fastquery.enabled		=	FALSE
		Return
	END IF
END IF
	
CHOOSE CASE	li_fastquery
	CASE	0, 1
		// Don't display or allow Fast Query.  This is the default for many sites.
		tabpage_report.dw_fastquery.visible		=	FALSE
		tabpage_report.dw_fastquery.enabled		=	FALSE
		tabpage_report.gb_fastquery.visible		=	FALSE
		This.of_set_fastquery_ind ('N')
		This.of_set_fastquery_rows (0)
		This.of_SetDWLimit (gc_dw_limit)
		Return
	CASE	2
		// Allow Fast Query.  
		tabpage_report.gb_fastquery.visible		=	TRUE
		tabpage_report.dw_fastquery.visible		=	TRUE
		tabpage_report.dw_fastquery.enabled		=	TRUE
		tabpage_report.dw_fastquery.BringToTop	=	TRUE
	CASE	3
		// Allow Fast Query for subsets only. 
		IF	Upper (tabpage_source.dw_source.object.rb_source [1])	=	'SUBSET'	THEN
			tabpage_report.gb_fastquery.visible		=	TRUE
			tabpage_report.dw_fastquery.visible		=	TRUE
			tabpage_report.dw_fastquery.enabled		=	TRUE
			tabpage_report.dw_fastquery.BringToTop	=	TRUE
		ELSE
			tabpage_report.dw_fastquery.visible		=	FALSE
			tabpage_report.dw_fastquery.enabled		=	FALSE
			tabpage_report.gb_fastquery.visible		=	FALSE
			This.of_set_fastquery_ind ('N')
			This.of_set_fastquery_rows (0)
			This.of_SetDWLimit (gc_dw_limit)
			Return
		END IF
	CASE	4			// FDG 02/27/01 - Allow this option
		// Allow Fast Query and default fastquery_ind = 'Y'
		tabpage_report.gb_fastquery.visible		=	TRUE
		tabpage_report.dw_fastquery.visible		=	TRUE
		tabpage_report.dw_fastquery.enabled		=	TRUE
		tabpage_report.dw_fastquery.BringToTop	=	TRUE
		This.of_set_fastquery_ind ('Y')
		This.of_set_fastquery_rows (gc_dw_limit)
		This.of_SetDWLimit (gc_dw_limit)
END CHOOSE

// At this point, dw_fastquery is enabled.  Determine if fastquery rows can be modified.

IF	Trim (ls_enable_max_rows)	=	'Y'		THEN
	tabpage_report.dw_fastquery.object.fastquery_rows.protect	=	0
ELSE
	tabpage_report.dw_fastquery.object.fastquery_rows.protect	=	1
END IF
end event

event ue_edit_disable_tabs(boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.ue_edit_disable_tabs
//	
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//		This event is triggered when the user selects a PDQ or creates a 
//		new PDQ or imports a PDQ.  This script will determine if anything
//		on the PDQ can be changed.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	09/21/01	Stars 4.8.1	Created
// GaryR 05/28/02 Track 2552d Predefined Report (PDR)
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR	12/11/04	Track 4108d	Dynamic Report Options
/////////////////////////////////////////////////////////////////////////////

String	ls_switch = "No"

IF	ab_switch THEN	ls_switch = "Yes"
ab_switch = NOT ab_switch
	
tabpage_source.dw_source.object.DataWindow.ReadOnly	=	ls_switch
tabpage_search.dw_criteria.object.DataWindow.ReadOnly	=	ls_switch
tabpage_search.uo_period.enabled		=	ab_switch
tabpage_search.ddlb_pd_opt.enabled	=	ab_switch
tabpage_report.dw_available.enabled	=	ab_switch
tabpage_report.dw_selected.enabled	=	ab_switch
tabpage_report.dw_fastquery.object.DataWindow.ReadOnly	=	ls_switch
tabpage_report.mle_title.enabled		=	ab_switch
tabpage_report.cb_add.enabled			=	ab_switch
tabpage_report.cb_remove.enabled		=	ab_switch
tabpage_report.cb_up.enabled			=	ab_switch
tabpage_report.cb_down.enabled		=	ab_switch
// GaryR 05/28/02 Track 2552d - Begin
IF This.of_GetWindow().of_is_pdr_mode() THEN
	tabpage_pdr.dw_pdr.object.DataWindow.ReadOnly	=	ls_switch
	tabpage_search.ddlb_pdr_opt.enabled	=	ab_switch
	tabpage_report.uo_report_options.enabled = ab_switch
END IF
end event

event type integer ue_tabpage_pdr_construct();//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)

Integer li_rc 

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Construct the PDR tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_construct( is_query_engine_mode )
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Construct the PDR tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_construct( is_query_engine_mode )
End If

RETURN li_rc
end event

event type integer ue_tabpage_pdr_load_source(boolean ab_new);//	04/17/02	GaryR	Track 2552d	Predefined Report (PDR)
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

Integer li_rc 

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Load the data source on PDR tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_load_source( ab_new )
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Load the data source on PDR tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_load_source( ab_new )
End If

RETURN li_rc
end event

event type integer ue_tabpage_pdr_create_report();//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)

Integer li_rc

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	li_rc	=	invo_tabpagepdr.Event ue_tabpage_pdr_create_report()
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	li_rc	=	invo_tabpagepdr.Event ue_tabpage_pdr_create_report()
End If

if li_rc = -1 then
	messagebox('INFORMATION','Report not created.')
	Return -1
end if

Return 1
end event

event type integer ue_tabpage_pdr_load_search(boolean ab_new);//	04/24/02	GaryR	Track 2552d	Predefined Report (PDR)

Integer li_rc 

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Load the search criteria on the Search tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_load_search( ab_new )
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Load the search criteria on the Search tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_load_search( ab_new )
End If

RETURN li_rc
end event

event type integer ue_tabpage_pdr_load(integer ai_level_num);//	04/29/02	GaryR	Track 2552d	Predefined Reports (PDR)

Integer li_rc 

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Load the saved PDR
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_load( ai_level_num )
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Load the saved PDR
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_load( ai_level_num )
End If

RETURN li_rc
end event

event ue_pipe_data();//=======================================================================================//
//	Object:			uo_query
//	Event:			ue_pipe_data
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Re-directs the results of a query to an Access database
//---------------------------------------------------------------------------------------//
//	Steps:	1. Generates SELECT SQL 
//				2. Connects to an Access database
//				3. Prompts user for target table name and save criteria options
//				4. Creates dummy datawindow based on SQL and sets it's labels
//				5. Creates pipeline and alters its syntax 
//				6. Executes the transfer
//				7. Saves Criteria, SQL, and labels to Access, if requested
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
// 12/02/04 MikeF	SPR3852d	Fixed issue if no User template
// 12/22/04 MikeF SPR4184d	Pushed control to the pipe so QE can be closed.
// 01/19/05 MikeF SPR4239d Check for existing Access table: Moved functions to n_cst_export
// 02/17/05 MikeF	SPR4297d Reset key structure so no additional columns are added to SELECT
// 02/21/05 MikeF	SPR4300d Reset invoice type (only issue with MC)
// 02/22/05 MikeF	SPR4311d Added implicit disconnects to Access db for every RETURN
//=======================================================================================//
string				ls_sql, ls_syntax, ls_error, ls_select, ls_table
int					li_rc
int					loop_ix1, loop_ix2, li_levels, li_where	// SQL creation
boolean				lb_exists

u_nvo_pipeline		lp_pipe
n_cst_export		ln_export
n_cst_labels 		lnvo_labels

sx_sql_statement 	lsx_sql
sx_keys				lsx_keys
sx_break_info		lsx_break_info
sx_drilldown		lsx_drilldown

// Prompt with HIPAA message
IF fx_disclaimer() = 2 THEN RETURN

// Check for selected columns. If none, prompt for template
IF invo_TabPageReport.idw_selected.Rowcount( ) = 0 THEN
	li_rc = MessageBox("Select export columns","No columns selected. Load default template?",Question!,YesNo!)
	IF li_rc = 1 THEN
		IF this.event ue_tabpage_report_load_user_template() = 0 THEN
			this.event ue_tabpage_report_load_system_template()
		END IF
	ELSE
		RETURN
	END IF
END IF

// Create SELECT SQL ---------------------------------------------------------------- //
IF IsValid(invo_tabpageview) THEN
	
	IF NOT IsValid (invo_tabpageview.iuo_nvo_create_sql) THEN
		invo_tabpageview.uf_set_nvo_create_sql (TRUE)
	END IF
	
	invo_tabpageview.iuo_nvo_create_sql.uf_set_inv_type( is_inv_type )
	invo_tabpageview.iuo_nvo_create_sql.uf_set_istr_key_columns( lsx_keys )
	invo_tabpageview.iuo_nvo_create_sql.uf_set_istr_break_info( lsx_break_info )
	invo_tabpageview.iuo_nvo_create_sql.uf_set_istr_drilldown( lsx_drilldown )
	invo_tabpageview.Event ue_create_sql ()
ELSE
	this.of_SetQueryNVO(TRUE,ic_view)
	
	IF NOT IsValid (invo_tabpageview.iuo_nvo_create_sql) THEN
		invo_tabpageview.uf_set_nvo_create_sql (TRUE)
	END IF

	invo_tabpageview.iuo_nvo_create_sql.uf_set_inv_type( is_inv_type )
	invo_tabpageview.iuo_nvo_create_sql.uf_set_istr_key_columns( lsx_keys )
	invo_tabpageview.iuo_nvo_create_sql.uf_set_istr_break_info( lsx_break_info )
	invo_tabpageview.iuo_nvo_create_sql.uf_set_istr_drilldown( lsx_drilldown )
	invo_tabpageview.Event ue_create_sql ()
	this.of_SetQueryNVO(FALSE,ic_view)
End If

li_levels = UpperBound(istr_sql_container.lsx_sql_statement)

IF li_levels = 0 THEN
	// Edit or error in SQL statement
	RETURN
END IF

FOR loop_ix1 = 1 to li_levels

	IF loop_ix1 > 1 THEN
		ls_sql += " UNION ALL "
	END IF

	lsx_sql	= istr_sql_container.lsx_sql_statement[loop_ix1]
	
	ls_sql  	+= trim(lsx_sql.select_clause) + " " + lsx_sql.from_clause + " "
	li_where = Upperbound(lsx_sql.where_clause)
	
	FOR loop_ix2 = 1 to Upperbound(lsx_sql.where_clause)
		ls_sql += lsx_sql.where_clause[loop_ix2] + " "
	NEXT
NEXT

// Connect to Access database - Moved here so we can check for existing table name
IF ln_export.of_set_access_tran() < 1 THEN 
	RETURN 							// Connect failed or was cancelled
END IF
ln_export.itr_access.autocommit = FALSE

// Get Options
ln_export.of_set_access_options("QUERY" )

IF ln_export.isx_access_options.cancelled THEN
	RETURN
END IF

// Create dummy datawindow --------------------------------------------------------- //
ls_syntax = stars2ca.syntaxfromsql(ls_sql,"style(type=grid)",ls_error)
IF len(ls_error) > 0 THEN 
	IF match(ls_error,"ORA-01719") THEN
		messagebox('Error',"Queries utilizing an 'OR' operand require parentheses.")
		this.Post selecttab( IC_SEARCH )
		tabpage_search.dw_criteria.setfocus( )
	ELSE
		messagebox('Error','Error creating datawindow for pipeline. Error = ' + &
		ls_error	+	'  SQL = '	+	ls_sql)
	END IF
	
	ln_export.itr_access.of_disconnect()
	RETURN
END IF

li_rc = tabpage_report.dw_pipeline.create(ls_syntax, ls_error)
tabpage_report.dw_pipeline.SetTrans( stars2ca )

IF li_rc < 0 THEN
	MessageBox("Error","Error setting datawindow syntax")
	ln_export.itr_access.of_disconnect()
	RETURN
END IF

// Set labels on dummy datawindow
lnvo_labels = CREATE n_cst_labels
lnvo_labels.of_setdw(tabpage_report.dw_pipeline)

lnvo_labels.of_labels2(is_inv_type,'95','40','50') 
IF len(trim(is_add_inv_type)) > 0 THEN
	lnvo_labels.of_labels2(is_add_inv_type,'95','40','50')
END IF

// User requested Support Type stuff ---------------------------------------------- //
// Save SQL
IF ln_export.isx_access_options.save_sql THEN
	ln_export.of_save_export_sql( ls_sql )
END IF

// Save Criteria
IF ln_export.isx_access_options.save_criteria THEN
	ln_export.of_save_export_criteria( tabpage_search.dw_criteria )
END IF

// Create the pipeline ------------------------------------------------------------- //
lp_pipe = CREATE u_nvo_pipeline
lp_pipe.dataobject = 'p_dummy_pipe'
lp_pipe.uf_set_syntax( ls_sql, invo_TabPageReport.idw_selected, ln_export.isx_access_options.table_name)
lp_pipe.ib_create_view 	= ln_export.isx_access_options.create_query 
lp_pipe.is_view_sql		= ln_export.uf_get_view_sql(tabpage_report.dw_pipeline, ln_export.isx_access_options.table_name)
lp_pipe.itr_target		= ln_export.itr_access

// Execute transfer ---------------------------------------------------------------- //
lp_pipe.uf_execute()
end event

event type integer ue_tabpage_pdr_secure(ref datawindowchild adwc_pdr_ver);//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection

Integer li_rows

If Not(IsValid(invo_tabpagepdr)) THEN
	//	Create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Perform PDR security
	li_rows = invo_tabpagepdr.Event ue_tabpage_pdr_secure( adwc_pdr_ver )
	//	Destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Perform PDR security
	li_rows = invo_tabpagepdr.Event ue_tabpage_pdr_secure( adwc_pdr_ver )
End If

Return li_rows
end event

event ue_tabpage_pdr_filter_source();//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Load the data source on PDR tab
	invo_tabpagepdr.Event ue_tabpage_pdr_filter_source()
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Load the data source on PDR tab
	invo_tabpagepdr.Event ue_tabpage_pdr_filter_source()
End If
end event

event type integer ue_tabpage_pdr_validate_source();//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

Integer li_rc

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	li_rc	=	invo_tabpagepdr.Event ue_tabpage_pdr_validate_source()
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	li_rc	=	invo_tabpagepdr.Event ue_tabpage_pdr_validate_source()
End If

Return li_rc
end event

event type integer ue_tabpage_pdr_save(integer ai_level, string as_query_id);///////////////////////////////////////////////////////////////////////////////////////
//
// This event is called by w_query_engine.ue_save_query() to load the information from 
// the tabpage to the pdr_sources datawindow.
//
///////////////////////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
//
///////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer i_Return 

If Not(IsValid(invo_tabpagepdr)) THEN
	//	Create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	i_Return = invo_tabpagepdr.Event ue_tabpage_pdr_save(ai_level,as_query_id)
	//destroy the report tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	i_Return = invo_tabpagepdr.Event ue_tabpage_pdr_save(ai_level,as_query_id)
End If

RETURN i_Return
end event

event type integer ue_tabpage_pdr_build_syntax(string as_pdr_name);/////////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////////

Integer	li_rc

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Load the data source on PDR tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_build_syntax( as_pdr_name )
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Load the data source on PDR tab
	li_rc = invo_tabpagepdr.Event ue_tabpage_pdr_build_syntax( as_pdr_name )
End If

Return li_rc
end event

event ue_tabpage_pdr_init_report_options();/////////////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////////

If Not(IsValid(invo_tabpagepdr)) THEN
	//create the PDR tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_pdr)
	// Load the data source on PDR tab
	invo_tabpagepdr.Event ue_tabpage_pdr_init_report_options()
	//destroy the PDR tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_pdr)
Else
	// Load the data source on PDR tab
	invo_tabpagepdr.Event ue_tabpage_pdr_init_report_options()
End If
end event

event type integer ue_tabpage_source_itemchanged(string data);////////////////////////////////////////////////////////////////////////////////////////////
//
//	Code was moved here from dw_source itemchanged
//
////////////////////////////////////////////////////////////////////////////////////////////
//
// 01/06/05	GaryR	Track 4217d	Move data_source itemchanged to user event for external use
// 01/27/06	GaryR	Track 4631d	Do not reset criteria or report columns if the 
//										only change is a subset within the same invoice type
// 03/07/06	HYL	Track 4471d	Do not display Period and Payment Date Options contols 
//										when different subset is selected from Subset List screen
//	12/21/07	GaryR	SPR 5234	Add descriptions to selected data sources
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
////////////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String		ls_inv_types[],	&
				ls_rb_source
Integer		li_rc,				&
				li_upper
w_query_engine	lw_parent

li_rc	=	tabpage_source.dw_source.of_getparentwindow(lw_parent)

uo_query		luo_query
luo_query	=	tabpage_source.dw_source.of_getuoquery()

is_old_inv_type	=	is_inv_type					// FDG 04/02/98
is_inv_type = Upper(left(trim(data),2))

//	Set the data source description
This.Post Event ue_tabpage_source_get_desc()

// Do not continue processing
// if invoice has not changed
IF ib_subnet_name_changed THEN // 03/07/06 HYL Track 4471d
	IF is_old_inv_type = is_inv_type THEN 
		ib_subnet_name_changed = FALSE
		Return 1
	END IF
	ib_subnet_name_changed = FALSE
END IF

is_inv_description	=	data						// FDG 04/02/98 (Track 959)

luo_query.of_reset_super_provider( 0 )				// FDG 09/11/98

If IsValid(lw_parent) Then
	//set the level tabpage text
	Integer li_SelectedTabpage
	li_SelectedTabpage = lw_parent.wf_GetTab().SelectedTab
	lw_parent.wf_SetLevelText(li_SelectedTabpage)
	// Clear the filter info for this level
	lw_parent.wf_clear_filter_info('')			// FDG 02/05/99
End If

if is_inv_type = '' then
	luo_query.event ue_tabpage_source_clear('')
	return 1
end if

// FDG 04/14/98 begin
if ib_drilldown then									// FNC 03/09/00
	if istr_drilldown.path = 'AD' then
	else
		luo_query.Event	ue_set_ancillary_inv_type (data)			// FDG 05/07/98
	end if
else
	luo_query.Event	ue_set_ancillary_inv_type (data)				// FDG 05/07/98
end if													// FNC 03/09/00

//Lahu S 2/28/02 begin
if not ib_ancillary_inv_type then
	tabpage_report.dw_fastquery.object.t_1.visible = 1
else
	tabpage_report.dw_fastquery.object.t_1.visible = 0			
end if
//Lahu S 2/28/02 end

lw_parent.Event	ue_remove_all_levels (ib_ancillary_inv_type)
IF	ib_ancillary_inv_type	=	FALSE		THEN
	gnv_app.of_set_default_inv_type (is_inv_type)	//	FDG 04/14/98	Track 975
END IF
// FDG 04/14/98 end

// FDG 04/02/98 Start
tabpage_search.dw_criteria.Reset()
tabpage_report.dw_selected.Reset()

// FDG 04/02/98 end		

ls_inv_types[1] = is_inv_type

//02-10-98 FNC Start
if ib_drilldown and istr_drilldown.path <> 'AD' then
	istr_drilldown.inv_type = is_inv_type
end if
//02-10-98 FNC End

luo_query.event ue_tabpage_source_determine_source_type()

choose case is_inv_type
		
	case 'MC'
		If IsValid(lw_parent) Then
			// Reset additional data source
			luo_query.event ue_tabpage_source_load_additional_data(is_inv_type,is_source_subset_id) // FDG 01/27/99
			/* set additional data source dddw to be disabled */
			tabpage_source.dw_source.object.add_data_source.Protect = 1
			lw_parent.Event ue_remove_all_levels_mc()		// FNC 06/03/98
		End If
		
	case 'ML'  /* need all inv_types for report */
				tabpage_source.dw_source.event ue_get_inv_types(ls_inv_types[])
				//	FDG 03/03/98 - Add 'MC' to the invoice types.
				li_upper	=	UpperBound (ls_inv_types)				//	FDG 03/03/98
				ls_inv_types [li_upper + 1]	=	gv_sys_dflt		// FDG 03/03/98
		/* set additional data source dddw to be disabled */	
		tabpage_source.dw_source.object.add_data_source.Protect = 1
		
		luo_query.event ue_tabpage_source_load_additional_data(is_inv_type,is_source_subset_id)
		
	case else
		If IsValid(lw_parent) Then
			/* set additional data source dddw to be enabled */
			tabpage_source.dw_source.object.add_data_source.Protect = 0
		End If
		
		luo_query.event ue_tabpage_source_load_additional_data(is_inv_type,is_source_subset_id)
		
end choose

luo_query.Event	ue_edit_initial_search_by_data()		// FDG 04/02/98

tabpage_report.enabled = TRUE

// FDG 04/28/98	begin
ls_rb_source	=	Upper (tabpage_source.dw_source.object.rb_source [1])
tabpage_search.uo_period.uf_scroll_to_row('NONE')		// FNC 02/22/00
// FDG 04/28/98	end

//	Load the data in the report tab.
luo_query.event ue_tabpage_report_set_columns(ls_inv_types[],'M')

If IsValid(lw_parent) Then
	lw_parent.event ue_set_menus_data_source(is_source_type,&
		is_inv_type,istr_drilldown.path)	// FNC 04/21/99
End If

gv_active_invoice = is_inv_type			// FNC 06/13/00 
w_main.triggerevent('timer')				// FNC 06/13/00 

This.SetFocus()								// FDG 04/14/98
Return 1
end event

event ue_tabpage_source_get_desc();//	12/21/07	GaryR	SPR 5234	Add descriptions to selected data sources

If Not(IsValid(invo_tabpagesource)) THEN
	//create the source tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_source)
	invo_tabpagesource.Event ue_tabpage_source_get_desc()
	//destroy the source tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_source)
Else
	invo_tabpagesource.Event ue_tabpage_source_get_desc()
End If
end event

event type integer ue_tabpage_view_stats();//*********************************************************************************
// Event Name:	u_nvo_view.ue_tabpage_view_stats
//
//	Arguments:	None
//
// Returns:		1 = Success; -1 = Failure
//
//	Description:
//		This event is triggered from the m_view popup menu in order to
//		setup the computed fields that will hold the report statistics.
//
//*********************************************************************************
//
//	09/10/09	GaryR	QEN.650.5229.006	Add statistical and arithmetic functions to QE reports
//
//*********************************************************************************

Integer	li_rtn

If Not(IsValid(invo_tabpageview)) THEN
	//create the View tabpage NVO
	this.of_SetQueryNVO(TRUE,ic_view)
	li_rtn = invo_tabpageview.Event ue_tabpage_view_stats()
	//destroy the View tabpage NVO
	this.of_SetQueryNVO(FALSE,ic_view)
Else
	li_rtn = invo_tabpageview.Event ue_tabpage_view_stats()
End If

Return li_rtn
end event

public function string of_getreporttitle ();RETURN Trim(tabpage_report.mle_title.Text)
end function

public function integer of_setreporttitle (string as_reporttitle);tabpage_report.mle_title.Text = Trim(as_ReportTitle)

RETURN 1
end function

public function u_dw of_get_report_dw ();Return	tabpage_report.dw_selected	
end function

public function u_Dw of_get_search_dw ();RETURN tabpage_search.dw_criteria
end function

public function u_Dw of_get_source_dw ();RETURN tabpage_source.dw_source
end function

public function u_Dw of_get_view_dw ();RETURN tabpage_view.dw_report
end function

public function integer of_setfromclosequery (boolean ab_Flag);ib_fromclosequery = ab_Flag

RETURN 1
end function

public function boolean of_getfromclosequery ();RETURN ib_fromclosequery
end function

public function string of_getinvoicetypes ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	uo_query						of_GetInvoiceTypes	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Get the invoice type(s) associated with the Query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
// None
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	String						A comma delimited string of invoice types.			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		02/03/98		Created.
//	FDG 			03/11/98		Check for nulls before appending to ls_returninvoice
// FNC			04/22/98		Track 983 check for '' before appending to ls_returninvoice
//									if the additional datasource was enabled there will be
//									'' in second item in the array.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_ReturnInvoice, ls_Invoice[]
Constant String S_DELIMITER = ","
Long ll_Range, ll_Index

this.Event ue_tabpage_source_get_both_data_sources(ls_Invoice[])

ll_Range = UpperBound(ls_Invoice)

FOR ll_Index = 1 TO ll_Range
	IF	Not IsNull (ls_Invoice[ll_Index]) and ls_invoice[ll_index] <> ''	THEN
		ls_ReturnInvoice = ls_ReturnInvoice + S_DELIMITER + ls_Invoice[ll_Index]
	END IF
NEXT

//trim the leading delimiter
ls_ReturnInvoice = Mid(ls_ReturnInvoice,2)

RETURN ls_ReturnInvoice
end function

public function string of_getinvoicetype ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	uo_query						of_GetInvoiceType	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Get the invoice type ASSOCIATED with the Query (ie. the selected source 
//	in tabpage source).
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
// None
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	String						The selected source in tabpage source.			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/03/98		Created.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

RETURN is_inv_type
end function

public function string of_getavailableinvoicetypes ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function						Access	
// ------						--------------						------	
//	uo_query						of_GetAvailableInvoiceTypes	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Get the invoice type(s) AVAILABLE in the Query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
// None
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	String						A comma delimited string of AVAILABLE invoice types
//									from the data source dddw on tabpage source.			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/05/98		Created.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_InvoiceTypes, ls_Invoice[]
Constant String S_DELIMITER = ","
Long ll_Range, ll_Index

tabpage_source.dw_source.Event ue_get_inv_types(ls_Invoice)

ll_Range = UpperBound(ls_Invoice)

For ll_Index = 1 To ll_Range
	ls_InvoiceTypes = ls_InvoiceTypes + S_DELIMITER + ls_Invoice[ll_Index]	
Next

ls_InvoiceTypes = Mid(ls_InvoiceTypes,2)

RETURN ls_InvoiceTypes
end function

public function string of_determine_data_type (string as_col_type);//*********************************************************************************
// Event Name:	UO_Query.Of_Determine_Data_Type
//
//	Arguments:	as_col_type
//
// Returns:		String
//*********************************************************************************
// 02/08/00 FNC	Unique Key TS2072 - Update to return proper datat types
// 10/02/00 KTB   Tr. 2582 - Always return a datetime type, never use a smalldatetime
//*********************************************************************************

//choose case left(as_col_type,4)
//		case "char"
//			return as_col_type
//		case "date","time" 
//			return "smalldatetime"
//		case "deci","long"
//			return "int"
//		case "numb"
//			return "float"
//end choose

choose case left(as_col_type,4)
	case "char"
		return as_col_type
	case "date","time" 
// KTB - Track 2582
//		if upper(as_col_type) = "DATE_BIRTH" OR upper(as_col_type) = "DATE_DEATH" then // KTB 01-20-00
			return "datetime"
//		else
//			return 'smalldatetime'
//		end if
// End KTB
	case "long"
		return "int"
	case "deci","numb"
	 	return "float"
end choose
end function

public function sx_break_info uf_get_sxbreakinfo ();RETURN istr_break_info
end function

public function integer uf_set_sxbreakinfo (sx_break_info asx_break_info);istr_break_info = asx_break_info

RETURN 1
end function

protected function integer of_setstatus (ref u_dw adw_requestor, dwitemstatus ais_newstatus, integer ai_column);/////////////////////////////////////////////////////////////////////////////
// Object							Event/Function			Access
// ------							--------------			------
//	u_nvo_query						uf_SetStatus			Protected
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Change the itemstatus of the ref. dw.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype			Description
//	---------	--------			--------			-----------
//	Reference	adw_requestor	u_Dw				The dw to change the itemstatus.
//	Value			ais_newstatus	dwItemStatus	The new itemstatus.
//	Value			ai_Column		Integer			The column to change the status (0 = row).
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/18/98			Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long l_rows, l_Index

l_rows = adw_Requestor.RowCount()

For l_Index = 1 To l_rows
	//set the row status
	adw_Requestor.SetItemStatus(l_Index,ai_Column,Primary!,ais_NewStatus)
Next

RETURN 1
end function

public function integer of_setstatus (dwitemstatus adis_Status);/////////////////////////////////////////////////////////////////////////////
// Object							Event/Function			Access
// ------							--------------			------
//	u_nvo_query						uf_SetStatus			Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Change the itemstatus of the non updateable dws.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype			Description
//	---------	--------			--------			-----------
//	Value			ais_newstatus	dwItemStatus	The new itemstatus.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/18/98			Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

this.of_SetStatus(tabpage_source.dw_source,adis_Status,0)
this.of_SetStatus(tabpage_search.dw_criteria,adis_Status,0)
this.of_SetStatus(tabpage_report.dw_selected,adis_Status,0)

RETURN 1
end function

public function integer of_getcasesecurity (readonly string as_case_id, readonly string as_case_spl, readonly string as_case_ver);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	uo_query						of_GetCaseSecurity	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Obtain the case security of the argument case.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument		Datatype	Description
//	---------	--------		--------	-----------
//	ReadOnly		as_case_id	String	The case id.
//	ReadOnly		as_case_spl	String	The case split.
//	ReadOnly		as_case_ver	String	The case ver.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer		> 0			Success.			
//					-1				Insufficient security.
//					-2				DB/other error.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	02/20/98		Created.
//
//	FDG		04/30/98		Track 1156.  This script is also called when
//								retrieving the PDQs.  The PDQs that belong to
//								a secured case will be removed from the list and
//								will not have an error message displayed.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_Return
Long ll_row
String ls_CaseIdSplVer
Constant String LS_UNSECUREDCASE = 'NONE'

// if case is not secured return success
IF Upper(Trim(as_case_id)) = LS_UNSECUREDCASE THEN RETURN 1

ls_CaseIdSplVer = as_case_id

IF Not(IsNull(as_case_spl)) THEN
	ls_CaseIdSplVer = ls_CaseIdSplVer + as_case_spl
	IF Not(IsNull(as_case_ver)) THEN
		ls_CaseIdSplVer = ls_CaseIdSplVer + as_case_ver
	END IF
END IF

/* check security */
li_return = invo_subset_functions.uf_determine_case_security(ls_CaseIdSplVer)

if li_return = 100 then
	// The user does not have priviledges to the PDQ.  It belongs to a
	// secured case.
	// FDG 04/30/98 begin
	IF	This.of_get_list_retrieve()	=	FALSE		THEN
		MessageBox("Secure Case", "You have insufficient privileges.", StopSign!)
	END IF
	// FDG 04/30/98 end
	return -1
elseif li_return < 0 then
	return -2
end if	

RETURN li_Return
end function

public function integer of_setdwlimit (Long al_Limit);il_dw_limit = al_Limit

RETURN 1
end function

public subroutine of_set_data_type (string as_data_type);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	of_Set_Data_Type							uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Initial set is_data_type. Set to the rb that is intialized in ue_tabpage_source_construct
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			as_data_type	String				Data type set in ue_tabpage_source_construct
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None
/////////////////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
// F.Chernak		03/03/98 	Created
//										Track 868. Set is_data_type so that this 
//										variable is set at same time that rb_source is set. 
////////////////////////////////////////////////////////////////////////////////////////

is_data_type = as_data_type
end subroutine

public function sx_prov_query_structure of_get_str_prov_query ();Return	istr_prov_query

end function

public subroutine of_set_decode_struct (sx_decode_structure astr_decode_struct);//***********************************************************
//	Script:	uo_query.ue_set_decode_struct
//
//	Arguments:	astr_decode_struct (type sx_decode_structure)
//
//	Returns:		None
//
//	Description:
//		This event is called after fx_dw_syntax to save the returned
//		sx_decode_structure.
//
//************************************************************
//	Revision History
//
//	FDG	03/23/98	Track 950.	Created.
//
//************************************************************

istr_decode_struct	=	astr_decode_struct

end subroutine

public function sx_decode_structure of_get_decode_struct ();//***********************************************************
//	Script:	uo_query.ue_get_decode_struct
//
//	Arguments:	None
//
//	Returns:		istr_decode_struct (type sx_decode_structure)
//
//	Description:
//		This event will return istr_decode_struct previously
//		saved in of_set_decode_struct.
//
//************************************************************
//	Revision History
//
//	FDG	03/23/98	Track 950.	Created.
//
//************************************************************

Return	istr_decode_struct

end function

public function boolean of_get_ancillary_inv_type ();Return	ib_ancillary_inv_type

end function

public function integer of_set_list_retrieve (boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_set_list_retrieve (ab_switch)
//	
//	Arguments:	ab_switch
//
//	Returns:		Integer 
//
//	Description:	
//		This script is called when retrieving the PDQs are being retrieved.
//		This will set a flag stating that the retrieval is in process.  This
//		flag is checked when determining if a PDQ is linked to a secure
//		case.  When this occurs while retrieving the data, then 
//		the PDQ will be removed from the PDQ list (instead of displaying an
//		error message).
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	04/30/98	Track 1156.  Created.
//						
/////////////////////////////////////////////////////////////////////////////

// Validate input
IF	IsNull (ab_switch)	THEN
	Return -1
END IF

ib_list_retrieve	=	ab_switch

Return 1

end function

public function boolean of_get_list_retrieve ();/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_get_list_retrieve ()
//	
//	Arguments:	None
//
//	Returns:		Boolean (ib_list_retrieve
//
//	Description:	
//		ib_list_retrieve is set when retrieving the PDQs are being retrieved.
//		This will set a flag stating that the retrieval is in process.  This
//		flag is checked when determining if a PDQ is linked to a secure
//		case.  When this occurs while retrieving the data, then 
//		the PDQ will be removed from the PDQ list (instead of displaying an
//		error message).
//
//		This function will return the flag set in of_set_list_retrieve
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	04/30/98	Track 1156.  Created.
//						
/////////////////////////////////////////////////////////////////////////////

Return	ib_list_retrieve

end function

public function sx_prov_query_structure of_get_istr_prov_query ();/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_get_istr_prov_query ()
//	
//	Arguments:	None
//
//	Returns:		istr_prov_query (Type sx_prov_query_structure)
//
//	Description:	
//		This function will return the structure of columns selected for a
//		Super Provider Query.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	05/04/98	Track 1185.  Created.
//						
/////////////////////////////////////////////////////////////////////////////

Return	istr_prov_query

end function

public function boolean of_edit_criteria_changed ();/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_edit_criteria_changed
//	
//	Arguments:	None
//
//	Returns:		Boolean:	TRUE	=	Data exists in dw_criteria
//								FALSE	=	Data does not exist in dw_criteria
//
//	Description:	
//		This fucntion will determine if data exists in dw_criteria.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	05/11/98	Track 1178.  Created.
//
/////////////////////////////////////////////////////////////////////////////

Long		ll_criteria_rowcount
String	ls_expression_one

//	See if any data exists in dw_criteria and dw_selected
ll_criteria_rowcount		=	tabpage_search.dw_criteria.RowCount()

//	Determine if dw_criteria has any entered data
CHOOSE CASE ll_criteria_rowcount
	CASE 0
		// no data exists
		Return	FALSE
	CASE 1
		//	A row exists.  See if there is data in this row
		ls_expression_one	=	tabpage_search.dw_criteria.object.expression_one [1]
		IF	IsNull (ls_expression_one)			&
		OR	Trim (ls_expression_one)	=	''	THEN
			Return	FALSE
		ELSE
			Return	TRUE
		END IF
	CASE ELSE
		// More than one row exists.  Data automatically exists in the 1st row.
		Return	TRUE
END CHOOSE



end function

public function string of_get_add_inv_type ();Return	is_add_inv_type
end function

public subroutine of_set_add_inv_type (string as_add_inv_type);is_add_inv_type	=	as_add_inv_type

end subroutine

public function boolean of_get_ib_drilldown ();Return	ib_drilldown

end function

public function sx_drilldown of_get_istr_drilldown ();Return	istr_drilldown

end function

public subroutine of_set_istr_drilldown (sx_drilldown astr_drilldown);istr_drilldown	=	astr_drilldown

end subroutine

public function sx_keys of_get_istr_key_columns ();Return	istr_key_columns

end function

public subroutine of_set_istr_key_columns (sx_keys astr_key_columns);istr_key_columns	=	astr_key_columns

end subroutine

public function boolean of_get_ib_count ();Return	ib_count

end function

public subroutine of_set_ib_count (boolean ab_count);ib_count	=	ab_count

end subroutine

public function sx_criteria of_get_istr_criteria ();Return	istr_criteria

end function

public subroutine of_set_istr_criteria (sx_criteria astr_criteria);istr_criteria	=	astr_criteria

end subroutine

public function string of_get_drilldown_prev_table ();Return	is_drilldown_previous_temp_table_name

end function

public subroutine of_set_drilldown_prev_table (string as_drilldown_previous_temp_table_name);is_drilldown_previous_temp_table_name	=	as_drilldown_previous_temp_table_name

end subroutine

public function string of_get_subset_id ();Return	is_subset_id

end function

public subroutine of_set_subset_id (string as_subset_id);is_subset_id	=	as_subset_id

end subroutine

public function sx_sql_statement_container of_get_istr_sql_statement ();//sx_sql_statement_container	lstr_sql_container

//lstr_sql_container.lsx_sql_statement	=	istr_sql_statement

Return	istr_sql_container
end function

public function sx_subsetting_info of_get_istr_subsetting_info ();Return	istr_subsetting_info
end function

public subroutine of_set_istr_subsetting_info (sx_subsetting_info astr_subsetting_info);istr_subsetting_info	=	astr_subsetting_info
end subroutine

public function boolean of_get_ib_subsetting ();Return	ib_subsetting

end function

public subroutine of_set_ib_subsetting (boolean ab_subsetting);ib_subsetting	=	ab_subsetting

end subroutine

public function string of_get_source_subset_id ();Return	is_source_subset_id

end function

public subroutine of_set_source_subset_id (string as_source_subset_id);is_source_subset_id	=	as_source_subset_id
end subroutine

public function string of_get_period_desc ();Return	is_period_desc

end function

public subroutine of_set_period_desc (string as_period_desc);is_period_desc	=	as_period_desc

end subroutine

public function integer of_get_ii_filter_count ();Return	ii_filter_count

end function

public subroutine of_set_ii_filter_count (integer ai_filter_count);ii_filter_count	=	ai_filter_count

end subroutine

public function sx_drilldown of_get_istr_prev_drilldown ();Return	istr_prev_drilldown
end function

public subroutine of_set_istr_prev_drilldown (sx_drilldown astr_drilldown);istr_prev_drilldown	=	astr_drilldown
end subroutine

public function string of_get_data_type ();Return	is_data_type
end function

public function w_query_engine of_getwindow ();w_query_engine		lw_window
PowerObject			lpo_parent

lpo_parent	=	This.GetParent()

DO WHILE lpo_parent.TypeOf()	<>	Window!	AND	IsValid (lpo_parent)
	lpo_parent	=	This.GetParent()
LOOP

IF	IsValid (lpo_parent)		THEN
	lw_window	=	lpo_parent
ELSE
	SetNull (lw_window)
END IF

Return	lw_window

end function

public subroutine of_set_istr_sql_statement (sx_sql_statement_container astr_sql_container);istr_sql_container	=	astr_sql_container

end subroutine

public subroutine of_set_period_visibility (boolean ab_switch);//////////////////////////////////////////////////////////////////////
//
//	09/12/02	GaryR	Track	3275d	Display the available claims range.
//
//////////////////////////////////////////////////////////////////////

// Set the visibility of uo_period
tabpage_search.gb_available_claims.visible		=	ab_switch			//	09/12/02	GaryR	Track	3275d
tabpage_search.uo_period.visible		=	ab_switch
tabpage_search.st_period.visible		=	ab_switch

end subroutine

public subroutine of_set_count_text (string as_text);// Set the text of the count boxes on tabpage_search & tabpage_view

tabpage_search.st_count_view_search.text		=	as_text
tabpage_view.st_count_view.text					=	as_text
tabpage_search.st_text_view_search.text		=	'Report Count'
tabpage_search.st_count_view_search.visible	=	TRUE
tabpage_search.st_text_view_search.visible	=	TRUE

end subroutine

public subroutine of_set_ib_new_flag (boolean ab_flag);//********************************************************************************
// 07/21/98 FNC	Created 
//						Track 1264. Set new flag to FALSE once query has been saved.
//********************************************************************************

ib_new_flag = ab_flag
end subroutine

public function integer of_date_change ();///////////////////////////////////////////////////////////
//	Script:		of_date_change
//
//	Arguments:	None
//
//	Returns:		Integer - 1=success
//
//	Description:
//		This function is called when a payment date or from date changes
//		and will reset the period to NONE.
///////////////////////////////////////////////////////////

ib_criteria_date_change	=	TRUE

tabpage_search.uo_period.uf_scroll_to_row('NONE')

ib_criteria_date_change	=	FALSE

Return 1

end function

public subroutine of_set_ib_load_template (boolean ab_load_template);ib_load_template = ab_load_template
end subroutine

public function boolean of_get_ib_load_template ();return ib_load_template
end function

public function long of_get_drop_row ();RETURN il_drop_row
end function

public subroutine of_set_idw_prev_criteria (u_dw adw_prev_criteria);idw_prev_criteria	=	adw_prev_criteria

end subroutine

public function u_dw of_get_dw_criteria ();Return	tabpage_search.dw_criteria

end function

public subroutine of_set_ib_drilldown_mode (boolean ab_drilldown_mode);
ib_drilldown_mode	=	ab_drilldown_mode

end subroutine

public function boolean of_get_ib_drilldown_mode ();
Return	ib_drilldown_mode

end function

public subroutine of_set_run_frequency (integer ai_run_frequency);//	uo_query.of_set_run_frequency()
//
//	Store the run frequency (in months) so it can be passed 
//	to subset options.  This function will be called from 
//	u_nvo_search.ue-compute_payment_date and 
//	u_nvo_search.ue_tabpage_search_clear().
//
//10-26-99	NLG	Created
//
/////////////////////////////////////////////////////////////////


ii_run_frequency = ai_run_frequency
end subroutine

public function integer of_get_run_frequency ();return ii_run_frequency
end function

public function boolean of_get_ib_recurring_pdq ();//*********************************************************************************
// Script Name:	uo_query.of_get_ib_recurring_pdq
//
//	Arguments:		none
//						
//
// Returns:			boolean ib_recurring_pdq
//
//	Description:	Returns the instance variable ib_recurring_pdq
//						which determines if query is future dated query
//		
//
//*********************************************************************************
//	
//  12-13-99	NLG	Created
//
//*********************************************************************************

return ib_recurring_pdq
end function

public function integer of_set_ib_recurring_pdq (ref boolean ab_switch);//*********************************************************************************
// Script Name:	uo_query.of_set_ib_recurring_pdq
//
//	Arguments:	boolean ab_switch	
//						
//
// Returns:			integer
//
//	Description:	Sets ib_recurring_pdq, which will be used by
//						nvo_create_sql to determine if pdq is future dated.
//		
//
//*********************************************************************************
//	
// 12/13/99 NLG	Created
//
//*********************************************************************************

ib_recurring_pdq = ab_switch


return 1
end function

public subroutine of_set_fastquery_ind (string as_fastquery_ind);/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.of_set_fastquery_ind
//
//	Arguments:	as_fastquery_ind
//
//	Returns:		None
//
//	Description:	
//		Set fastquery_ind in dw_fastquery. 
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY     
//    
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Created.
//
/////////////////////////////////////////////////////////////////////////////

Long		ll_row

ll_row	=	tabpage_report.dw_fastquery.GetRow()

tabpage_report.dw_fastquery.object.fastquery_ind [ll_row]	=	as_fastquery_ind

end subroutine

public subroutine of_set_fastquery_rows (long al_fastquery_rows);/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.of_set_fastquery_rows
//
//	Arguments:	al_fastquery_rows
//
//	Returns:		None
//
//	Description:	
//		Set fastquery_rows in dw_fastquery. 
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY     
//    
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Created.
//
/////////////////////////////////////////////////////////////////////////////

Long		ll_row

ll_row	=	tabpage_report.dw_fastquery.GetRow()

tabpage_report.dw_fastquery.object.fastquery_rows [ll_row]	=	al_fastquery_rows

end subroutine

public function string of_get_default_ind (string as_user_id, string as_template_id, string as_inv_type, string as_addl_inv_type);//***********************************************************
//	Script:	uo_query.uf_get_default_ind
//
//	Arguments:	1)	as_user_id - user id
//						2)	as_inv_type - main invoice type
//						3)	as_addl_inv_type - additional invoice type
//
//	Returns 'Y' if default template
//                     ' ' if not default template
//
//	Description:
//		This event will return 'Y' if invoice type/additional
//				invoice type combination is a default template,
//				returns empty string if not default template.
//
//************************************************************
//	Revision History
//
//	NLG	08/26/98	ts144 Report on enhancements
//	FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
//************************************************************

string ls_default_ind
integer li_status

select default_template into :ls_default_ind
from pdq_cntl
where user_id = Upper( :as_user_id )
	and query_id = Upper( :as_template_id )
	and query_type = Upper( :as_inv_type )
	and addl_query_type = Upper( :as_addl_inv_type )
using stars2ca;

li_status =  stars2ca.of_check_status()

if li_status < 0 then
	errorbox(stars2ca,'Error checking pdq_cntl table for default template indicator.')
else											// FNC 04/14/99
	stars2ca.of_commit()					// FNC 04/14/99
end if

if ls_default_ind = "" then ls_default_ind = " "

return ls_default_ind
end function

public function string of_get_pd_opt_desc ();//this function returns the text from the payment date options dropdownlistbox (ddlb_pd_opt)
//

//Lahu S 1/22/01 Track 2552d


string ls_pd_opt_text
//Lahu S 1/22/01 Begin	Track 2552d
if is_query_engine_mode = "PDQ" then
//Lahu S 1/22/01 End	
	ls_pd_opt_text = tabpage_search.ddlb_pd_opt.text
//Lahu S 1/22/01 Begin	
else
	ls_pd_opt_text = tabpage_search.ddlb_pdr_opt.text	
end if
//Lahu S 1/22/01 End
return ls_pd_opt_text
end function

public subroutine of_set_engine_mode (string as_mode);//Lahu S Track 2552d 
//set query engine mode
is_query_engine_mode = as_mode		
end subroutine

public subroutine of_set_pd_opt_desc (string as_pd_opt_desc);// Lahu S 1/22/01 Track 2552d

//this function sets the payment date options dropdownlistbox (ddlb_pd_opt)
// Lahu S 1/22/01 Begin
if is_query_engine_mode="PDR" or is_query_engine_mode = "PDCR" then
	tabpage_search.ddlb_pdr_opt.text = as_pd_opt_desc
else
// Lahu S 1/22/01 End	
	tabpage_search.ddlb_pd_opt.text = as_pd_opt_desc
end if
end subroutine

protected function long of_windowoperation (u_dw adw_requestor, long al_row, dwobject adwo);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	uo_query						of_WindowOperations	Protected
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Call the global method () to perform window operations (sort, filter, & find).
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype	Description
//	---------	--------			--------	-----------
//	Value*		adw_requestor	u_Dw		The dw to perform the op. on.	
//	Value			al_row			Long		the current dw row.
//	Value			adwo				dwObject	The object to perform the op. on.		
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			1				Success			
//					0				Failure
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	02/25/98	Created.
//
//	FDG		03/18/98	Track 940.  Fix a system error where 'adwo.Band'
//							could not be referenced.  Get the column name
//							instead.
//
//	FDG		03/23/98	Track 950.  Fill in data to istr_decode_struct
//							before calling fx_dw_control.
//
//	FDG		04/21/98	Track 1090.  If the header is double-clicked, w_uo_win
//							may have to be reopened again.  Also, don't invoke
//							fx_dw_control unless the window operations were
//							performed on the correct datawindow.
//
//	FDG		04/28/98	Track 1114.  Any window operations that changes the #
//							of rows or changes the sequence of the rows must remove
//							the totals row previously created.
// Lahu S    2/28/02 Track 2552d 
//	09/10/09	GaryR	QEN.650.5229.004	Remove obsolete money/unit totals logic 
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_tabpos, 			&
			li_rc,				&
			li_upper

String 	ls_sort_name,		&
			ls_hold_object,	&
			ls_col,				&
			ls_col_name, 		&
			ls_data_type,		&
			ls_tbl_type,		&
			ls_ClassName,		&
			ls_window_operation

Constant String LS_REPORTDW = 'dw_report'	//	the report dw name
Constant String LS_LISTDW = 'dw_list'	//	the list dw name

/*gets the row and makes sure a row was clicked*/
setpointer(hourglass!)

ls_window_operation	=	Upper ( Trim(is_window_operation) )

// find out which dw is the argument.
ls_ClassName = Lower ( adw_requestor.ClassName() )

IF ls_ClassName	=	LS_LISTDW		THEN 
	// List d/w.  determine if a double-click was for a window
	//	operation or to select a PDQ.
	IF is_operation_type	<>	'LIST'	THEN
		This.of_GetWindow().Event ue_select_pdq()
		Return 1													// FDG 03/18/98
	END IF
END IF

// had to build this format since the global fx_dw_control expects this format
ls_hold_object = adwo.Name + "~t" + String(al_row) 

ls_col_name		=	adwo.Name		// FDG 03/18/98

// FDG 3/23/98 begin
li_upper			=	UpperBound (istr_decode_struct.table_type)

IF	li_upper		<	1		THEN
	istr_decode_struct.table_type [1]	=	is_inv_type
END IF
// FDG 2/23/98 end

// Check for Header band
IF	Right (ls_col_name, 2)	=	'_t'	AND Upper(ls_col_name)	<>	'HEADER_T'	THEN
	// Header band
	// Determine if w_uo_win needs to be reopened
	// FDG 04/21/98 begin
	IF (is_operation_type	=	'LIST'	AND	ls_ClassName = LS_LISTDW)		&
	OR	(is_operation_type	=	'REPORT'	AND	ls_ClassName = LS_REPORTDW)	THEN
		This.Event	ue_window_operations	(is_operation,		&
													is_operation_type)
		li_rc = fx_dw_control	(adw_requestor,		&
										ls_hold_object,		&
										is_window_operation,	&
										iw_uo_win,				&
										'',						&
										0,							&
										istr_decode_struct)
	ELSE
		Return 0
	END IF
	// FDG 04/21/98 end
ElseIf Upper(Trim(is_window_operation)) = 'FILTER' &
		OR Upper(Trim(is_window_operation)) = 'FIND' Then	
	// perform display filter OR find op.
	IF (is_operation_type	=	'LIST'	AND	ls_ClassName = LS_LISTDW)		&
	OR	(is_operation_type	=	'REPORT'	AND	ls_ClassName = LS_REPORTDW)	THEN
		li_rc = fx_dw_control	(adw_requestor,		&
										ls_hold_object,		&
										is_window_operation,	&
										iw_uo_win,				&
										'cell',					&
										al_row,					&
										istr_decode_struct)
	ELSE
		Return 0
	END IF
Else
	// Only perform if current dw is report dw
	IF Lower(ls_ClassName) = LS_REPORTDW THEN
		IF al_row = 0 then 
			return 0
		END IF
		IF is_source_type = 'AN' then 
			return 0
		END IF
		setpointer(hourglass!)
		//Lahu S 2/28/02 begin		
		if is_query_engine_mode = "PDQ" then		
			This.Event ue_tabpage_view_view_claim()
		end if
		//Lahu S 2/28/02 end
		setpointer(arrow!)  
	END IF	
end if

RETURN li_Rc

end function

public function integer of_setquerynvo (boolean ab_flag, integer ai_index);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	of_SetQueryNvo								uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Create or destroy (ab_flag) an instance of the NVO associated with the selected 
// tabpage (ai_index). Also, provide the NVO with access to objects on the tabpage. 
// Note: Each NVO contains ONLY the method code and instance variables specific 
//	to THE SELECTED TABPAGE.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			ab_flag		Boolean		Create (TRUE) or Destroy (FALSE) flag.
//		Value			ai_index		Integer		The tabpage index.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success			
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/15/97		Created.
//	GaryR				04/17/02		Track 2552d	Predefined Reports (PDR)
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

u_nvo_query lu_nvo_query

CHOOSE CASE ai_Index
		
	CASE IC_LIST					//list tabpage
		
		IF ab_Flag THEN 
			If Not(IsValid(invo_tabpagelist)) Then 
				//instantiate nvo and set instance vars.
				invo_tabpagelist = CREATE u_nvo_list
				//set the tabpage specific instance variables
				this.of_Set_Instance_Variables(ai_index,invo_tabpagelist)
			End If
		ELSE
			If IsValid(invo_tabpagelist) Then 
				Destroy invo_tabpagelist
			End If
		END IF
	
	//	04/17/02	GaryR	Track 2552d - Begin
	CASE IC_PDR					//Report Template tabpage
		
		IF ab_Flag THEN 
			If Not(IsValid(invo_tabpagepdr)) Then 
				//instantiate nvo and set instance vars.
				invo_tabpagepdr = CREATE u_nvo_pdr
				//set the tabpage specific instance variables
				this.of_Set_Instance_Variables(ai_index,invo_tabpagepdr)
			End If
		ELSE
			If IsValid(invo_tabpagepdr) Then 
				Destroy invo_tabpagepdr
			End If
		END IF	
	//	04/17/02	GaryR	Track 2552d - End
		
	CASE IC_SOURCE					//source tabpage
		
		IF ab_Flag THEN 
			If Not(IsValid(invo_tabpagesource)) Then 
				//instantiate nvo and set instance vars.
				invo_tabpagesource = CREATE u_nvo_source
				//set the tabpage specific instance variables
				this.of_Set_Instance_Variables(ai_index,invo_tabpagesource)
			End If
		ELSE
			If IsValid(invo_tabpagesource) Then 
				Destroy invo_tabpagesource
			End If	
		END IF
			
	CASE IC_SEARCH					//search tabpage
		
		IF ab_Flag THEN 
			If Not(IsValid(invo_tabpagesearch)) Then 
				//instantiate nvo and set instance vars.
				invo_tabpagesearch = CREATE u_nvo_search
				//set the tabpage specific instance variables
				this.of_Set_Instance_Variables(ai_index,invo_tabpagesearch)
			End If
		ELSE
			If IsValid(invo_tabpagesearch) Then 
				Destroy invo_tabpagesearch
			End If	
		END IF
		
	CASE IC_REPORT			//report tabpage
		
		IF ab_Flag THEN 
			If Not(IsValid(invo_tabpagereport)) Then 
				//instantiate nvo and set instance vars.
				invo_tabpagereport = CREATE u_nvo_report
				//set the tabpage specific instance variables
				this.of_Set_Instance_Variables(ai_index,invo_tabpagereport)
			End If
		ELSE
			If IsValid(invo_tabpagereport) Then 
				Destroy invo_tabpagereport
			End If	
		END IF
		
	CASE IC_VIEW			//view tabpage
		
		IF ab_Flag THEN 
			If Not(IsValid(invo_tabpageview)) Then 
				//instantiate nvo and set instance vars.
				invo_tabpageview = CREATE u_nvo_view
				//set the tabpage specific instance variables
				this.of_Set_Instance_Variables(ai_index,invo_tabpageview)
			End If
		ELSE
			If IsValid(invo_tabpageview) Then 
				Destroy invo_tabpageview
			End If	
		END IF
		
END CHOOSE

RETURN 1
end function

public function integer of_enable_tabpage (integer ai_tabpage, boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_enable_tabpage
//	
//	Arguments:	1.	ai_tabpage - The tabpage to enable/disable
//					2. ab_switch - TRUE = enable,  FALSE = Disable
//
//	Returns:		Integer - 1 = success, -1 = failure
//
//	Description:	
//		This function will enable/disable the appropriate tabpage.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	06/11/98	Track ????.  Created.
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
//
/////////////////////////////////////////////////////////////////////////////

// Edit the input
IF	IsNull (ai_tabpage)		&
OR	ai_tabpage	=	0			THEN
	Return	-1
END IF

IF	IsNull (ab_switch)		THEN
	Return	-1
END IF

CHOOSE CASE ai_tabpage
	CASE ic_list
		This.tabpage_list.enabled		=	ab_switch
	CASE ic_pdr		//	GaryR	04/17/02	Track 2552d
		This.tabpage_pdr.enabled		=	ab_switch
	CASE ic_source
		This.tabpage_source.enabled	=	ab_switch
	CASE ic_search
		This.tabpage_search.enabled	=	ab_switch
	CASE ic_report
		This.tabpage_report.enabled	=	ab_switch
	CASE ic_view
		This.tabpage_view.enabled		=	ab_switch
	CASE ELSE
		Return	-1
END CHOOSE

Return	1

end function

public subroutine of_check_filter_id (ref sx_filter_info asx_filter_info[]);/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_check_filter_id
//	
//	Arguments:	sx_filter_info asx_filter_info[]
//
//	Returns:		None
//
//	Description:	
//		This function checks to see if a filter that will be created in this 
//		query is used in the criteria. If it is then it sets the filter used boolean
//		to true so that the user cannot modify the filter id or remove the filter in
//		the w_qe_filter_create window.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FNC	08/04/98	Track 1265. Created.
//	GaryR	04/20/01	Stars 4.7 DataBase Port - Case Sensitivity
//
/////////////////////////////////////////////////////////////////////////////

integer 	li_num_filters,		&
			li_filter,			&
			li_exp2_row,		&
			li_crit_rows
string	ls_exp2
datawindowchild ldwc_exp2

li_num_filters = upperbound(asx_filter_info)
for li_filter = 1 to li_num_filters
	asx_filter_info[li_filter].filter_used = FALSE
next

li_crit_rows = this.tabpage_search.dw_criteria.rowcount()
this.tabpage_search.dw_criteria.GetChild ('expression_two',ldwc_exp2)		// FNC 05/20/98

for li_exp2_row = 1 to li_crit_rows
	ls_exp2 = trim(this.tabpage_search.dw_criteria.object.expression_two[li_exp2_row])
	if left(ls_exp2,1) = '@' then
		
		for li_filter = 1 to li_num_filters
			//	GaryR	04/20/01	Stars 4.7 DataBase Port
			if asx_filter_info[li_filter].filter_id = Upper( mid(ls_exp2,2) ) then
				asx_filter_info[li_filter].filter_used = TRUE
				continue
			end if
		next
	end if
next
	
end subroutine

public function integer of_set_instance_variables (integer ai_index, u_nvo_query au_nvo_tabpage);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	of_Set_Instance_Variables				uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Create or destroy (ab_flag) an instance of the NVO associated with the selected 
// tabpage (ai_index). Also, provide the NVO with access to objects on the tabpage. 
// Note: Each NVO contains ONLY the method code and instance variables specific 
//	to THE SELECTED TABPAGE. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			ab_flag			Boolean				Create (TRUE) or Destroy (FALSE) flag.
//		Value			ai_index			Integer				The tabpage index.
//		Reference	au_nvo_tabpage	u_nvo_query			The tabpage NVO.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success			
/////////////////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/15/97		Created.
// FNC		12/29/97		Call uf_set_report_dw_selected when the view tab is 
//								selected because the view tab references this datawindow.
//	FNC		04/28/98		Track 1132 Set invoice type in report NVO because
//								it is needed when an existing report template is saved.
//	FDG		05/12/98		Track 1223.  Remove cb_help.
//	FDG		05/21/98		Track 1248.  Register istr_drilldown to u_nvo_view.
//	FDG		06/12/98		Track ????.  Register more entitities
// AJS      07/30/98    Track #1522. Pass period id & period function.
//	FDG		08/19/98		Track 1501.  Pass idw_prev_criteria to u_nvo-search.
//	NLG		08/19/98		ts144 Report on enhancements.  Set ib_load_template
// AJS		08/24/98    ts144 Report on enhancements. pass a pointer for dw_source
//	NLG		10/20/99		ts2463c. Fraud PDQ library enhancements. Register the 
//								run frequency to report,search,view NVOs
//	NLG		12-13-99		ts2463c. Check w_query_engine.ii_run_frequency. If > 0
//								it's a recurring pdq.
// FNC		12/23/99		Fraud PDQ's set ib_recurring_pdq in u_nvo_search and u_nvo_view
//	FDG		07/17/00		Track 2465c.  Stars 4.5 SP1.  Register the Fast Query d/w.
//	FDG		03/13/01		Stars 4.7.	Remove ros_directory.
//	GaryR		04/17/02		Track 2552d	Predefined Report (PDR)
//	GaryR		11/16/04		Track 4115d	STARS Reporting - Claims PDRs
//	GaryR		12/11/04		Track 4108d	Dynamic Report Options
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
////////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

CHOOSE CASE ai_Index
		
	CASE IC_LIST					//list tabpage
		
		If IsValid(au_nvo_tabpage) Then
			//set instance vars.
			au_nvo_tabpage.uf_set_list_dw_search(tabpage_list.dw_search)
			au_nvo_tabpage.uf_set_list_dw_list(tabpage_list.dw_list)
		End If
	
	//	04/17/02	GaryR	Track 2552d - Begin
	CASE IC_PDR					//PDR tabpage
		
		If IsValid(au_nvo_tabpage) Then
			//set instance vars.
			au_nvo_tabpage.uf_set_inv_type( is_inv_type )
			au_nvo_tabpage.uf_set_pdr_dw_pdr( tabpage_pdr.dw_pdr )
			au_nvo_tabpage.uf_set_source_dw_source (tabpage_source.dw_source)
			au_nvo_tabpage.uf_set_search_dw_criteria( tabpage_search.dw_criteria )
			au_nvo_tabpage.uf_set_view_dw_report( tabpage_view.dw_report )
			au_nvo_tabpage.uf_set_dw_break( tabpage_view.dw_break )
			au_nvo_tabpage.uf_set_report_mle_title( tabpage_report.mle_title )
			au_nvo_tabpage.uf_set_report_dw_fastquery( tabpage_report.dw_fastquery )
			au_nvo_tabpage.uf_set_report_uo_report_options( tabpage_report.uo_report_options )
		End If
	//	04/17/02	GaryR	Track 2552d - End	
	
	CASE IC_SOURCE					//source tabpage
		
		If IsValid(au_nvo_tabpage) Then
			//set instance vars.
			au_nvo_tabpage.uf_set_source_dw_source (tabpage_source.dw_source)
			// FDG 06/12/98 begin
			au_nvo_tabpage.uf_set_data_type(is_data_type)
			au_nvo_tabpage.uf_set_subset_id(is_subset_id)
			au_nvo_tabpage.uf_set_source_subset_id(is_source_subset_id)
			au_nvo_tabpage.uf_set_source_type(is_source_type)
			au_nvo_tabpage.uf_set_inv_type(is_inv_type)
			au_nvo_tabpage.uf_set_old_inv_type(is_old_inv_type)
			au_nvo_tabpage.uf_set_inv_description(is_inv_description)
			au_nvo_tabpage.uf_set_ib_drilldown(ib_drilldown)
			au_nvo_tabpage.uf_set_ib_ancillary_inv_type(ib_ancillary_inv_type)
			au_nvo_tabpage.uf_set_sx_drilldown(istr_drilldown)			
			au_nvo_tabpage.uf_set_report_dw_selected (tabpage_report.dw_selected)
			au_nvo_tabpage.uf_set_search_dw_criteria (tabpage_search.dw_criteria)
			au_nvo_tabpage.uf_set_search_uo_period (tabpage_search.uo_period)
			au_nvo_tabpage.uf_set_source_dw_source (tabpage_source.dw_source)		
			au_nvo_tabpage.uf_set_report_dw_available (tabpage_report.dw_available)
			// FDG 06/12/98 end
			au_nvo_tabpage.uf_set_report_dw_fastquery (tabpage_report.dw_fastquery)		// FDG 07/17/00
			
			//	GaryR	04/17/02	Track 2552d - Begin
			au_nvo_tabpage.uf_set_pdr_dw_pdr( tabpage_pdr.dw_pdr )
			au_nvo_tabpage.uf_set_report_dw_fastquery( tabpage_report.dw_fastquery )
			au_nvo_tabpage.uf_set_report_uo_report_options( tabpage_report.uo_report_options )
			//	GaryR	04/17/02	Track 2552d - End
		End If
		
	CASE IC_REPORT			//report tabpage
		
		If IsValid(au_nvo_tabpage) Then
			//set instance vars.
			au_nvo_tabpage.uf_set_report_dw_available (tabpage_report.dw_available)
			au_nvo_tabpage.uf_set_report_mle_title (tabpage_report.mle_title)
			au_nvo_tabpage.uf_set_report_cb_add (tabpage_report.cb_add)
			au_nvo_tabpage.uf_set_report_dw_selected (tabpage_report.dw_selected)
			au_nvo_tabpage.uf_set_report_ds_case_link (ids_report_template_case_link)
			au_nvo_tabpage.uf_set_report_ds_pdq_cntl (ids_report_template_pdq_cntl)
			au_nvo_tabpage.uf_set_report_ds_pdq_columns (ids_report_template_pdq_columns)
			au_nvo_tabpage.uf_set_inv_type(is_inv_type)		//FNC 04/28/98 
			// FDG 06/12/98 begin
			au_nvo_tabpage.uf_set_ib_drilldown(ib_drilldown)
			au_nvo_tabpage.uf_set_ib_ancillary_inv_type(ib_ancillary_inv_type)
			au_nvo_tabpage.uf_set_sx_drilldown(istr_drilldown)			// FDG 05/21/98
			au_nvo_tabpage.uf_set_view_dw_report (tabpage_view.dw_report)
			// FDG 06/12/98 end
			au_nvo_tabpage.uf_set_ib_load_template(ib_load_template)		//NLG 8-19-98 ts144
			au_nvo_tabpage.uf_set_source_dw_source (tabpage_source.dw_source)	//AJS 8-24-98 ts144
//			au_nvo_tabpage.uf_set_report_drop_row (il_drop_row) //AJS 8-27-98 ts144
			au_nvo_tabpage.uf_set_run_frequency (ii_run_frequency) //NLG 10-20-99 ts2463c
		End If
		
		
	CASE IC_VIEW,	IC_SEARCH			//view & search tabpage
		
		If IsValid(au_nvo_tabpage) Then
			//set instance vars.
			au_nvo_tabpage.uf_set_search_uo_period (tabpage_search.uo_period)
			au_nvo_tabpage.uf_set_source_dw_source (tabpage_source.dw_source)		
			au_nvo_tabpage.uf_set_search_dw_criteria (tabpage_search.dw_criteria)
			au_nvo_tabpage.uf_set_report_dw_selected (tabpage_report.dw_selected)
			au_nvo_tabpage.uf_set_report_mle_title (tabpage_report.mle_title)
			au_nvo_tabpage.uf_set_view_dw_report (tabpage_view.dw_report)
			au_nvo_tabpage.uf_set_sx_keys (istr_key_columns)
			au_nvo_tabpage.uf_set_istr_sql_statement (istr_sql_container)
			au_nvo_tabpage.uf_set_data_type(is_data_type)
			au_nvo_tabpage.uf_set_source_subset_id(is_source_subset_id)
			au_nvo_tabpage.uf_set_inv_type(is_inv_type)
			au_nvo_tabpage.uf_set_sx_drilldown(istr_drilldown)			// FDG 05/21/98
			// FDG 06/12/98 begin
			au_nvo_tabpage.uf_set_ib_count(ib_count)
			au_nvo_tabpage.uf_set_ib_drilldown(ib_drilldown)
			au_nvo_tabpage.uf_set_ib_subsetting(ib_subsetting)
			au_nvo_tabpage.uf_set_ib_query_loaded_flag(ib_query_loaded_flag)
			au_nvo_tabpage.uf_set_ib_ancillary_inv_type(ib_ancillary_inv_type)
			au_nvo_tabpage.uf_set_filter_count(ii_filter_count)
			au_nvo_tabpage.uf_set_sub_filter_count(ii_sub_filter_count)
			au_nvo_tabpage.uf_set_drilldown_previous_temp_table(is_drilldown_previous_temp_table_name)
			au_nvo_tabpage.uf_set_source_type(is_source_type)
			au_nvo_tabpage.uf_set_subset_id(is_subset_id)
			au_nvo_tabpage.uf_set_istr_break_info(istr_break_info)
			au_nvo_tabpage.uf_set_istr_prov_query(istr_prov_query)
			au_nvo_tabpage.uf_set_istr_npi_prov_query(istr_npi_prov_query)
			au_nvo_tabpage.uf_set_istr_subsetting_info(istr_subsetting_info)
			// FDG 06/12/98 end
			au_nvo_tabpage.uf_set_period_key(ii_period_key)							//ajs 07/30/98 Track #1522
			au_nvo_tabpage.uf_set_period_function(is_period_function)			//ajs 07/30/98 Track #1522
			au_nvo_tabpage.uf_set_prev_dw_criteria(idw_prev_criteria)			// FDG 08/19/98
			au_nvo_tabpage.uf_set_dw_break (tabpage_view.dw_break)				// FDG 09/23/98
			au_nvo_tabpage.uf_set_report_dw_fastquery (tabpage_report.dw_fastquery)		// FDG 07/17/00
			au_nvo_tabpage.uf_set_pdr_dw_pdr( tabpage_pdr.dw_pdr )	//	GaryR	04/17/02	Track 2552d
		End If

END CHOOSE

//set the instance variables to which ALL tabpage NVOs need access.
IF IsValid(au_nvo_tabpage) THEN
	au_nvo_tabpage.uf_set_query_id (is_query_id)
	au_nvo_tabpage.uf_SetParent(this)
	au_nvo_tabpage.uf_SetParentWindow(This.of_GetWindow())
END IF	

RETURN 1
end function

public subroutine of_set_pd_opt_visibility (boolean ab_switch);//uo_query.of_set_pd_opt()
// Set the visibility of the payment date options listbox and its label
//
//	11/22/99	NLG	Created.
// 01/22/01	LahuS	Track 2552d Check for engine mode
//////////////////////////////////////////////////////////////////////

// 1/22/01  Lahu S Begin
if is_query_engine_mode = "PDQ" then 
// 1/22/01  Lahu S End	
	tabpage_search.ddlb_pd_opt.visible		=	ab_switch
	tabpage_search.st_payment_date_options.visible		=	ab_switch
// 1/22/01  Lahu S Begin	
end if
// 1/22/01  Lahu S End
end subroutine

public subroutine of_set_pdr_date_range_option ();//////////////////////////////////////////////////////////////////////
// set PDR date range option
//
// 01/22/01	LahuS	Track 2552d Created.
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//						This functionality will be resolved in a post 5.1.0 release
//	09/12/02	GaryR	Track	3275d	Display the available claims range.
//////////////////////////////////////////////////////////////////////

//	04/17/02	GaryR	Track 2552d - Begin
//tabpage_search.st_payment_date_options.text = "Date Range Options:"
tabpage_search.ddlb_pd_opt.visible = false
//tabpage_search.ddlb_pdr_opt.visible = true

tabpage_search.st_payment_date_options.visible = FALSE
tabpage_search.ddlb_pdr_opt.visible = FALSE
tabpage_search.gb_available_claims.visible	= FALSE			//	09/12/02	GaryR	Track	3275d	Display the available claims range.

//	04/17/02	GaryR	Track 2552d - End
end subroutine

public function integer of_getcasesecurity (integer ai_row, readonly sx_subset_ids asx_subset_ids);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	uo_query						of_GetCaseSecurity	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Obtain the case security of the argument subset(s).
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype			Description
//	---------	--------			--------			-----------
//	ReadOnly		asx_subset_ids	sx_subset_ids	The argument subset ids. 
//	Value			ai_row			Integer			The current dw_source row
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer		> 0			Success.			
//					-1				Insufficient security.
//					-2				DB/other error.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/13/98		Created.
//	GaryR				11/16/04		Track 4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_Return
String ls_case_id

ls_case_id = asx_subset_ids.subset_case_id + &
asx_subset_ids.subset_case_spl + asx_subset_ids.subset_case_ver

/* 1st check security then load case id into case_id */
li_return = invo_subset_functions.uf_determine_case_security(ls_case_id)

if li_return = 100 then
		//message - 
		MessageBox("Secure Case", "You have insufficient privileges.", StopSign!)
		return -1
elseif li_return < 0 then
	return -2
end if	

// populate case id
IF ai_row > 0 THEN
	tabpage_source.dw_source.object.case_id[ai_row] = ls_case_id
ELSE
	RETURN -3
END IF

RETURN li_Return
end function

public function integer of_reset_super_provider (integer ai_switch);/////////////////////////////////////////////////////////////////////
//	Script:		of_reset_super_provider
//
//	Arguments:	Integer - ai_switch (0=All, 1=Super Provider, 2=Super NPI Provider)
//
//	Returns:		Integer - 1=successful
//
//	Description:
//		This function will reset any information relating to the
//		Super Provider Query.  This function is invoked when a new
//		Data Source is selected on the source tab and when 'Super
//		Provider' is removed from the Search tab.
//
/////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	09/11/98	Track 1687.  Created.
//	FDG	10/14/98	Track 1831.  ii_spq_row & ib_super_provider_query are
//						no longer used.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
//
/////////////////////////////////////////////////////////////////////

Integer		li_rc
w_query_engine	lw_parent
sx_prov_query_structure		lstr_prov_query

CHOOSE CASE ai_switch
	CASE 1	// Reset Provider
		istr_prov_query	=	lstr_prov_query
	CASE 2	// Reset NPI Provider
		istr_npi_prov_query	=	lstr_prov_query
	CASE ELSE	// Reset Both
		istr_prov_query	=	lstr_prov_query
		istr_npi_prov_query	=	lstr_prov_query
END CHOOSE

li_rc	=	This.of_GetParentWindow (lw_parent)
lw_parent.Event	ue_set_menus_super_provider_query (TRUE)

Return 1
end function

public function sx_prov_query_structure of_get_istr_npi_prov_query ();/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_get_istr_npi_prov_query ()
//	
//	Arguments:	None
//
//	Returns:		istr_prov_query (Type sx_prov_query_structure)
//
//	Description:	
//		This function will return the structure of columns selected for a
//		Super NPI Provider Query.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	05/04/98	Track 1185.  Created.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//						
/////////////////////////////////////////////////////////////////////////////

Return	istr_npi_prov_query

end function

public subroutine of_set_istr_prov_query (sx_prov_query_structure astr_prov_query, boolean ab_npi);/////////////////////////////////////////////////////////////////////////////
// Script:		uo_query.of_set_istr_prov_query ()
//	
//	Arguments:	astr_prov_query (Type sx_prov_query_structure)
//					Boolean	ab_npi	NPI flag
//
//	Returns:		None
//
//	Description:	
//		This function will save the structure of columns selected for a
//		Super Provider Query.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	05/04/98	Track 1185.  Created.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//						
/////////////////////////////////////////////////////////////////////////////

IF ab_npi THEN
	istr_npi_prov_query	=	astr_prov_query
ELSE
	istr_prov_query	=	astr_prov_query
END IF

end subroutine

on uo_query.create
this.tabpage_list=create tabpage_list
this.tabpage_pdr=create tabpage_pdr
this.tabpage_source=create tabpage_source
this.tabpage_search=create tabpage_search
this.tabpage_report=create tabpage_report
this.tabpage_view=create tabpage_view
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_list
this.Control[iCurrent+2]=this.tabpage_pdr
this.Control[iCurrent+3]=this.tabpage_source
this.Control[iCurrent+4]=this.tabpage_search
this.Control[iCurrent+5]=this.tabpage_report
this.Control[iCurrent+6]=this.tabpage_view
end on

on uo_query.destroy
call super::destroy
destroy(this.tabpage_list)
destroy(this.tabpage_pdr)
destroy(this.tabpage_source)
destroy(this.tabpage_search)
destroy(this.tabpage_report)
destroy(this.tabpage_view)
end on

event selectionchanged;//*********************************************************************************
// Event Name:	UO_Query.SelectionChanged
//
//	Arguments:	Integer OldIndex
//					Integer newindex
//
//	Descrption:
//	If tabpage_list is selected, then w_query_engine.cb_select and 
//	w_query_engine.cb_list is visible.  If tabpage_list, tabpage_search or 
//	tabpage_view is visible then w_query_engine.st_count is visible.  If tabpage_list,
//	tabpage_source, tabpage_search or tabpage_report is visible then 
//	w_query_engine.cb_next is visible. To do this will call user event on the window 
//	to access the objects on the window.  Also, if the selected tabpages is 
//	tabpage_view then will give user a warning and create the report.
//
//*********************************************************************************
// History
// FNC	02/26/98	Track 855.  Set the count if the displayed tab 
//						is search or view
//	FDG	03/02/98	Track 880.  Trigger the ue_selecttab(0) to determine if 
//						the Next button is to be enabled.
//
//	FDG	03/03/98	Perform an accepttext on all d/ws before going to
//						the next tab.
//
//	FDG	04/06/98	Track 986.  For the Search tab, set focus to dw_criteria.  For
//						the source tab, set focus to dw_source.
//
//	FDG	04/27/98	Track 1108.  Set the d/w on tabpage_view as the "printable" d/w.
//
//	FDG	05/07/98	Track	1211.  Change the display message when the view report
//						tab is clicked.
//
//	FDG	05/12/98	Track 1223.  st_count is now on each tab.
//
//	FDG	06/17/98	Track ????.  Don't destroy u_nvo_view because u_nvo_view
//						scripts make programmatically do a SelectTab on Search
//
// FNC	08/12/98	Track 1541. If the old tab and new tab are the same then don't need
//						to execute this code. This can occur when the the PB SelectTab 
//						function is invoked in the U_NVO_Query.UE_Check_Status.
// AJS   12/10/98 Track 2026 . StarDev. Chg "Create rpt?" default button to OK.
//	KTB   01/19/00 FS/TS2638 Starcare Track 2638. Hide unique count box if coming
//                back into View Report.
//	FDG	04/17/00	Track 2865C.  Close w_uo_win.
//	FDG	02/27/01	Stars 4.6.  Make sure dw_fastquery allows the user to click
//						on fastquery_ind
// JSB   01/07/02 Track 2609 --> Reset microhelp when tabs are changed.
// Lahu S 1/7/02  Track 2552d check mode	
//	GaryR	02/05/02	Track 2552d	Predefined Report (PDR)
//	GaryR	04/17/02	Track 2552d	Predefined Report (PDR)
// LahuS  4/23/02 Track 2552d PDR Drilldown
//	GaryR	03/03/06	Track 4537	Set the proper D/W to print/save
//  RickB 05/29/08 Track 5335  Reset gv_rowcounter to 0 when the "create the report"
//                         msgbox is displayed.
//*********************************************************************************

integer 	li_tab
integer 	li_return
long 		ll_count
String	ls_desc

w_query_engine	lw_parent

if oldindex = newindex then return		// FNC 08/12/98

li_tab = this.selectedtab

lw_parent	=	This.of_GetWindow()

//list tabpage NVO is created in uo_Query::Constructor event
IF oldindex		<> ic_list 				&
AND oldindex	<>	ic_view				THEN

	//destroy the previous tabpage NVO
	this.of_SetQueryNVO(FALSE,oldindex)
END IF

//list tabpage NVO is destroyed in uo_Query::Destructor event
IF newindex <> ic_list THEN
	//create the selected tabpage NVO
	this.of_SetQueryNVO(TRUE,newindex)
END IF

If IsValid(lw_parent) Then
	lw_parent.Event	ue_accepttext (lw_parent.Control, FALSE)	//	FDG 03/03/98
	lw_parent.wf_set_print (TRUE)
	lw_parent.of_SetPrintDW( tabpage_view.dw_report )
End If

If li_tab = ic_view Then
	setmicrohelp(w_main,'View Report')                    // JSB 01/07/02
	gv_rowcounter = 0
	li_return = MessageBox('Attention:', 'Create the Report?', Exclamation!, OkCancel!)	// ajs 12/10/98
	If li_return = 2 Then
		This.Event	ue_set_count_view()								// FDG 05/12/98
		This.Post	Event	ue_selecttab(0)							//	FDG 03/02/98
		ii_view_report = 2		//Lahu S 4/23/02	Track 2552d
		Return
	Else
		ii_view_report = 1		//Lahu S 4/23/02	Track 2552d			
		//	GaryR	04/17/02	Track 2552d - Begin
		IF lw_parent.of_is_pdr_mode() THEN
			lw_parent.Event ue_set_menus_data_source( is_source_type, is_inv_type, istr_drilldown.path )
			THIS.Post Event ue_tabpage_pdr_create_report()
		ELSE
			this.post event ue_tabpage_view_create_report()
		END IF
		//	GaryR	04/17/02	Track 2552d - End
		
		//KTB 1-19-00 Hide Unique count if it was visible
		if tabpage_view.st_unique_count_view.visible = TRUE then
			tabpage_view.st_unique_count_view.visible = FALSE
			tabpage_view.st_unique_text_view.visible = FALSE
		end if
		//End KTB
End If
	this.of_SetQueryNVO(FALSE,li_tab)								// FDG 06/17/98
End If

//02-26-98 FNC Start
if li_tab = ic_search then
	ib_criteria_date_change	=	TRUE									// FDG 04/06/98
	ls_desc	=	tabpage_search.uo_period.uf_return_desc()		//	FDG 04/06/98
	tabpage_search.uo_period.uf_scroll_to_row(ls_desc)			// FDG 04/06/98
	tabpage_search.dw_criteria.SetFocus()							// FDG 04/06/98
	setmicrohelp(w_main,'Search Criteria')                   // JSB 01/07/02
	ib_criteria_date_change	=	FALSE									// FDG 04/06/98
	ll_count = tabpage_search.dw_criteria.rowcount()
	//lw_parent.event UE_Set_Count(ll_count)						// FDG 05/12/98
	This.Event	ue_set_count_search()								// FDG 05/12/98
end if
//02-26-98 FNC End

// FDG 04/10/98 begin
IF	li_tab	=	ic_source		THEN
	tabpage_source.dw_source.SetFocus()
	// Lahu S 1/7/02 begin	
	if NOT lw_parent.of_is_pdr_mode() then
		tabpage_source.dw_source.SetColumn('data_source')
	end if
	// Lahu S 1/7/02 End			
	setmicrohelp(w_main,'Data Source')                      // JSB 01/07/02
END IF
// FDG 04/10/98 end

// FDG 12/02/98 begin
IF	li_tab	=	ic_report		THEN
	// FDG 02/27/01 begin
	IF	tabpage_report.dw_fastquery.visible	=	TRUE		THEN
		tabpage_report.dw_fastquery.BringToTop	=	TRUE
		tabpage_report.dw_fastquery.SetFocus()
		tabpage_report.dw_fastquery.SetColumn('fastquery_rows')
	END IF
	// FDG 02/27/01 end
	tabpage_report.mle_title.SetFocus()
	setmicrohelp(w_main,'Customize Report')                // JSB 01/07/02
END IF

IF	li_tab	=	ic_list		THEN
	lw_parent.of_SetPrintDW( tabpage_list.dw_list )
	tabpage_list.dw_search.SetFocus()
	setmicrohelp(w_main,'Query Library')                // JSB 01/07/02
END IF

// FDG 12/02/98 end

// FDG 04/17/00 - If w_uo_win is open, close it
IF	IsValid (iw_uo_win)		THEN
	Close (iw_uo_win)
END IF

//	Determine if the Next button is to be enabled.
This.Post	Event	ue_selecttab(0)		//	FDG	03/02/98

// Lahu S 1/7/02 begin	
// hide period
if newindex = IC_SEARCH AND lw_parent.of_is_pdr_mode() then 
	This.of_Set_period_visibility(FALSE)
	This.of_set_pdr_date_range_option()
end if	
// Lahu S 1/7/02 End
end event

event constructor;/////////////////////////////////////////////////////////////////////////////
// Script:	uo_query.Constructor
//
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//		When this user object is created, certain things will need 
//		to be set per tabpage.  Create user objects  and set the datawindows 
//		on tabpage_source.  The subset user object is used for 
//		retrieving subset id and check case security.  The temp table 
//		user object is for creating and dropping temp tables.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY     
//    
//	???	????????	Created.
// FDG	02/12/98	Disable the print menu items until the view tab is clicked.
//	JTM  	02/13/98	Added code to prevent source construct from occurring multiple
//						times.
//	JTM	02/20/97	Removed source construct code because errors could occur if
//						method code impacted and object which had not yet been constructed.
//	NLG	11-16-99	Insert a blank line in the payment date options ddlb.
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Allow for FastQuery.
// FDG	03/13/01	Stars 4.7.	Remove ros_directory.
// LahuS	01/07/02	Track 2552d Insert a blank line for date range options ddlb
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
//	GaryR	04/11/03	Track 3517d	PDR label changes
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR	02/03/05	Track 4271d	Set Query Engine reports read-only
/////////////////////////////////////////////////////////////////////////////

Long ll_PDQTableRows
Boolean	lb_is_pdr		//	GaryR	04/17/02	Track 2552d
DatawindowChild	ldwc_client_name, ldwc_cust_stmt
w_query_engine		lw_parent
u_Dw ldw_PdqTables

lw_parent	=	This.of_GetWindow()

//iuo_query = this

//this.of_GetParentWindow(iw_Parent)
ldw_PdqTables	=	lw_parent.wf_GetDwPdqTables()

IF IsValid(ldw_PdqTables) THEN
	ll_PDQTableRows = ldw_PdqTables.RowCount()
END IF

invo_subset_functions = Create nvo_Subset_Functions

//ids_ros_dir	= create n_ds						// FDG 03/13/01

invo_temp_table = create n_cst_temp_table

ids_report_template_case_link = create n_ds
ids_report_template_pdq_cntl = create n_ds
ids_report_template_pdq_columns = create n_ds


// Create the list tabpage NVO
this.of_SetQueryNVO(TRUE,ic_list)

// Disable the print menu items until the view tab is clicked.
lw_parent.wf_set_print (FALSE)

//NLG 11-16-99 Insert a blank line in the payment date options ddlb.
tabpage_search.ddlb_pd_opt.InsertItem(' ',1)//Insert space as first item in listbox
tabpage_search.ddlb_pd_opt.SelectItem(1)//select the first item

//LahuS 1-7-02 Insert a blank line in the Date range options ddlb.
tabpage_search.ddlb_pdr_opt.InsertItem(' ',1)//Insert space as first item in listbox
tabpage_search.ddlb_pdr_opt.SelectItem(1)//select the first item

// FDG 07/17/00 Begin
// Because dw_fastquery is an external source d/w, insert a new row
This.Event	ue_initialize_dw_fastquery()
// Set the maximum limit on the number of rows to retrieve
This.of_SetDWLimit(gc_dw_limit)
// FDG 07/17/00 End

//	GaryR	04/17/02	Track 2552d - Begin
//	Show the Report Template tabpage in PDR mode
lb_is_pdr = lw_parent.of_is_pdr_mode()
tabpage_pdr.visible = lb_is_pdr
IF lb_is_pdr THEN
	tabpage_list.text = "Report Library"
	tabpage_search.text = "Report Criteria"
	tabpage_report.text = "Report Options"
	tabpage_source.dw_source.dataobject = "d_pdr_source"
ELSE
	tabpage_view.dw_report.Object.DataWindow.ReadOnly='Yes'
END IF
//	GaryR	04/17/02	Track 2552d - End

end event

event destructor;call super::destructor;//Destructor Event 

//When this user object is destroyed, datastores that may have 
//been created for report templates must be destroyed as well as 
//the subset functions user object. 

// FDG	03/13/01	Stars 4.7.	Remove ros_directory.

//	Drop the previously create temp table
This.Event	ue_drilldown_drop_temp_table()

//	Destroy any previously created objects

if isvalid(ids_report_template_case_link) then
	destroy ids_report_template_case_link
end if

if isvalid(ids_report_template_pdq_cntl) then
	destroy ids_report_template_pdq_cntl
end if

if isvalid(ids_report_template_pdq_columns) then
	destroy ids_report_template_pdq_columns
end if

//if isvalid(ids_ros_dir) then		// FDG 03/13/01
//	destroy ids_ros_dir
//end if

if isvalid(invo_subset_functions) then
	destroy invo_subset_functions
end if

if isvalid(invo_temp_table) then
	destroy invo_temp_table
end if

//	FDG 03/18/98 begin
IF	IsValid(iw_uo_win)		THEN
	Close (iw_uo_win)
END IF

// FDG 03/18/98 end

this.of_SetQueryNVO(FALSE,ic_list)
this.of_SetQueryNVO(FALSE,ic_source)
this.of_SetQueryNVO(FALSE,ic_report)
this.of_SetQueryNVO(FALSE,ic_search)
this.of_SetQueryNVO(FALSE,ic_view)
end event

event rightclicked;call super::rightclicked;this.Event ue_open_menu()
end event

event key;//*********************************************************************
//	Script:		key (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)		THEN
	This.Post	Event	ue_open_menu()
END IF

end event

type tabpage_list from userobject within uo_query
string accessiblename = "Query Library Tab"
string accessibledescription = "The Query Library tab lists the previously defined queries by User ID, Query Type, or Date Range."
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 3209
integer height = 1912
boolean enabled = false
long backcolor = 67108864
string text = "Query Library"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uo_range uo_range
dw_search dw_search
gb_1 gb_1
dw_list dw_list
cb_close_list cb_close_list
cb_next_list cb_next_list
cb_select_list cb_select_list
cb_list_list cb_list_list
st_count_list st_count_list
cb_new cb_new
gb_2 gb_2
uo_tabpage_list uo_tabpage_list
end type

on tabpage_list.create
this.uo_range=create uo_range
this.dw_search=create dw_search
this.gb_1=create gb_1
this.dw_list=create dw_list
this.cb_close_list=create cb_close_list
this.cb_next_list=create cb_next_list
this.cb_select_list=create cb_select_list
this.cb_list_list=create cb_list_list
this.st_count_list=create st_count_list
this.cb_new=create cb_new
this.gb_2=create gb_2
this.uo_tabpage_list=create uo_tabpage_list
this.Control[]={this.uo_range,&
this.dw_search,&
this.gb_1,&
this.dw_list,&
this.cb_close_list,&
this.cb_next_list,&
this.cb_select_list,&
this.cb_list_list,&
this.st_count_list,&
this.cb_new,&
this.gb_2,&
this.uo_tabpage_list}
end on

on tabpage_list.destroy
destroy(this.uo_range)
destroy(this.dw_search)
destroy(this.gb_1)
destroy(this.dw_list)
destroy(this.cb_close_list)
destroy(this.cb_next_list)
destroy(this.cb_select_list)
destroy(this.cb_list_list)
destroy(this.st_count_list)
destroy(this.cb_new)
destroy(this.gb_2)
destroy(this.uo_tabpage_list)
end on

type uo_range from uo_date_range within tabpage_list
event destroy ( )
string tag = "RANGE"
string accessiblename = "Range"
string accessibledescription = "Range"
integer x = 1888
integer y = 72
integer width = 951
integer height = 280
integer taborder = 20
end type

on uo_range.destroy
call uo_date_range::destroy
end on

type dw_search from u_dw within tabpage_list
string accessiblename = "Search"
string accessibledescription = "Search"
integer x = 55
integer y = 52
integer width = 1774
integer height = 292
integer taborder = 10
string dataobject = "d_search"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetUpdateable( FALSE )
end event

event rbuttonup;This.of_getuoquery().Event ue_open_menu()

Return 1

end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

event itemchanged;call super::itemchanged;//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection

String	ls_cat_code, ls_type_code
Integer	li_row
DatawindowChild	ldwc_pdr_cat, ldwc_pdr_type, ldwc_pdr_ver

IF is_query_engine_mode = "PDQ" THEN Return 0

CHOOSE CASE dwo.name
	CASE "pdr_cat"
		This.GetChild( "pdr_cat", ldwc_pdr_cat )
		li_row = ldwc_pdr_cat.GetSelectedrow(0)
		IF li_row > 0 THEN
			ls_cat_code = ldwc_pdr_cat.GetItemString( li_row, "code_code" )
			IF IsNull( ls_cat_code ) OR Trim( ls_cat_code ) = "" THEN
				MessageBox( "Error", "Code not found for Category " + data )
				Return 0
			END IF
			
			This.GetChild( "pdr_type", ldwc_pdr_type )
			This.GetChild( "pdr_version", ldwc_pdr_ver )
			IF ls_cat_code = "AA" THEN
				ldwc_pdr_type.Reset()
			ELSE				
				ldwc_pdr_type.retrieve( ls_cat_code )				
			END IF
			
			li_row = ldwc_pdr_type.InsertRow(1)
			ldwc_pdr_type.SetItem(li_row,1,'AA')		
			ldwc_pdr_type.SetItem(li_row,2,'All PDR Types')
			
			ldwc_pdr_ver.Reset()
			li_row = ldwc_pdr_ver.InsertRow(1)
			ldwc_pdr_ver.SetItem(li_row,1,'AA')		
			ldwc_pdr_ver.SetItem(li_row,2,'All PDR Versions')
			
			This.object.pdr_type[1] = 'AA'
			This.object.pdr_version[1] = 'AA'
		END IF
	CASE "pdr_type"
		This.GetChild( "pdr_cat", ldwc_pdr_cat )
		li_row = ldwc_pdr_cat.GetSelectedrow(0)
		IF li_row < 1 THEN Return 0
		ls_cat_code = ldwc_pdr_cat.GetItemString( li_row, "code_code" )
		IF IsNull( ls_cat_code ) OR Trim( ls_cat_code ) = "" THEN
			MessageBox( "Error", "Code not found for Category" )
			Return 0
		END IF
		
		This.GetChild( "pdr_type", ldwc_pdr_type )
		This.GetChild( "pdr_version", ldwc_pdr_ver )
		
		li_row = ldwc_pdr_type.GetSelectedrow(0)
		IF li_row < 1 THEN Return 0
		ls_type_code = ldwc_pdr_type.GetItemString( li_row, "code_code" )
		IF IsNull( ls_type_code ) OR Trim( ls_type_code ) = "" THEN
			MessageBox( "Error", "Code not found for Type " + data )
			Return 0
		END IF
		
		IF ls_type_code = "AA" THEN
			ldwc_pdr_ver.Reset()
		ELSE				
			ldwc_pdr_ver.retrieve( ls_cat_code, ls_type_code )
		END IF
		
		li_row = ldwc_pdr_ver.InsertRow(1)
		ldwc_pdr_ver.SetItem(li_row,1,'AA')		
		ldwc_pdr_ver.SetItem(li_row,2,'All PDR Versions')
		
		This.object.pdr_version[1] = 'AA'
END CHOOSE
end event

type gb_1 from groupbox within tabpage_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer width = 1829
integer height = 376
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By:"
end type

type dw_list from u_dw within tabpage_list
string accessiblename = "Predefined Query List"
string accessibledescription = "A list of available PDQs."
integer x = 23
integer y = 388
integer width = 3173
integer height = 1356
integer taborder = 40
string dataobject = "d_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;this.of_SingleSelect(True)
This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(FALSE) 

//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)
end event

event doubleclicked;call super::doubleclicked;RETURN This.of_getuoquery().of_WindowOperation(this,row,dwo)
end event

event rbuttonup;This.of_getuoquery().Event ue_open_menu()

Return 1


end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;//	dw_list.RowFocusChanged
//
// FDG 09/21/01	Stars 4.8.1.	Created.  Enable/disable the delete RMM
//						depending on if the associated case is closed/deleted.
//	FDG 01/16/02	Track 2699d.  If the display filter causes 0 rows to be
//						retrieved, then currentrow can still = 1.

// Make sure there's a row to process
IF	currentrow	<	1		&
OR	IsNull(currentrow)	THEN
	Return
END IF

// FDG 01/16/02 - Make sure there are rows in this d/w
Long	ll_rowcount
ll_rowcount	=	This.RowCount()
IF	ll_rowcount	<	1		THEN
	Return
END IF
// FDG 01/16/02 end

Integer	li_rc

String	ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver

w_query_engine	lw_parent

ls_case_id	=	This.object.case_link_case_id [currentrow]
ls_case_spl	=	This.object.case_link_case_spl [currentrow]
ls_case_ver	=	This.object.case_link_case_ver [currentrow]

li_rc	=	This.of_GetParentWindow (lw_parent)

lw_parent.Event	ue_edit_menus_delete (ls_case_id, ls_case_spl, ls_case_ver)

end event

type cb_close_list from u_cb within tabpage_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2930
integer y = 1764
integer width = 261
integer taborder = 80
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;Integer		li_rc

w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)

Close (lw_parent)

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_next_list from u_cb within tabpage_list
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2592
integer y = 1764
integer width = 261
integer taborder = 70
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Next"
end type

event clicked;call super::clicked;This.of_getuoquery().Event	ue_next_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_select_list from u_cb within tabpage_list
string accessiblename = "Select"
string accessibledescription = "Select"
integer x = 1915
integer y = 1764
integer width = 261
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Select"
end type

event clicked;call super::clicked;Integer		li_rc
w_query_engine	lw_parent

li_rc	=	This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_select_pdq()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_list_list from u_cb within tabpage_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 2880
integer y = 156
integer width = 261
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&List"
boolean default = true
end type

event clicked;call super::clicked;Long		ll_rowcount

dw_list.reset()                 // JSB Track 2699  01/24/02
dw_list.SetFilter('')           // JSB Track 2699  01/24/02
dw_list.Filter()                // JSB Track 2699  01/24/02

ll_rowcount	=	This.of_getuoquery().Event	ue_tabpage_list_create_list (is_query_id)
end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type st_count_list from statictext within tabpage_list
string accessiblename = "List Row Count"
string accessibledescription = "List Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1764
integer width = 274
integer height = 92
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_new from u_cb within tabpage_list
string accessiblename = "New"
string accessibledescription = "New"
integer x = 2254
integer y = 1764
integer width = 261
integer taborder = 60
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "N&ew"
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	cb_new						clicked
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This will enable tabpage_source, populate it will all possible datasources and select it.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	NONE.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
// NONE.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	A.Sola			08/25/98		Created. TS144 Report On Enhancements
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

This.of_getuoquery().Event ue_new_query()



end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type gb_2 from groupbox within tabpage_list
string accessiblename = "Date Range"
string accessibledescription = "Date Range"
accessiblerole accessiblerole = groupingrole!
integer x = 1865
integer width = 1326
integer height = 380
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Date Range"
end type

type uo_tabpage_list from uo_tabpage_qe within tabpage_list
event destroy ( )
string accessiblename = "Query Library"
string accessibledescription = "Query Library"
integer x = 18
integer y = 24
integer width = 3163
integer height = 1696
end type

on uo_tabpage_list.destroy
call uo_tabpage_qe::destroy
end on

type tabpage_pdr from userobject within uo_query
event create ( )
event destroy ( )
string accessiblename = "Report Template Tab"
string accessibledescription = "The Report Template tab allows you to specify the PDR category, type, and version."
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 3209
integer height = 1912
boolean enabled = false
long backcolor = 67108864
string text = "Report Template"
long tabtextcolor = 33554432
long tabbackcolor = 83871458
long picturemaskcolor = 536870912
dw_pdr dw_pdr
cb_close_pdr cb_close_pdr
cb_next_pdr cb_next_pdr
cb_prev_pdr cb_prev_pdr
end type

on tabpage_pdr.create
this.dw_pdr=create dw_pdr
this.cb_close_pdr=create cb_close_pdr
this.cb_next_pdr=create cb_next_pdr
this.cb_prev_pdr=create cb_prev_pdr
this.Control[]={this.dw_pdr,&
this.cb_close_pdr,&
this.cb_next_pdr,&
this.cb_prev_pdr}
end on

on tabpage_pdr.destroy
destroy(this.dw_pdr)
destroy(this.cb_close_pdr)
destroy(this.cb_next_pdr)
destroy(this.cb_prev_pdr)
end on

type dw_pdr from u_dw within tabpage_pdr
string accessiblename = "PDR"
string accessibledescription = "PDR"
integer y = 4
integer width = 3209
integer height = 1456
integer taborder = 10
string dataobject = "d_pdr"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rbuttonup;call super::rbuttonup;//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)

This.of_getuoquery().Event ue_open_menu()
Return
end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//		If F1 is pressed, disply the PDR Help.
//
//*********************************************************************
//	History
//
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	04/16/09	GaryR	GNL.600.5633.012	Section 508 Compliance
//
//*********************************************************************

sx_pdr_parms	lsx_pdr_parms
w_query_engine	lw_parent

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyF1!)	THEN
		// Call help for this column
		This.of_GetParentWindow (lw_parent)
		lw_parent.of_get_pdr_parm( lsx_pdr_parms )
		lw_parent.of_help ('W_QUERY_ENGINE', lsx_pdr_parms.pdr_name )
	ELSE
		IF KeyDown (KeyControl!)				THEN
			IF	KeyDown (KeyRightArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_next_tabpage()
			ELSE
				IF	KeyDown (KeyLeftArrow!)		THEN
					This.of_getuoquery().Post	Event	ue_prev_tabpage()
				END IF
			END IF
		END IF
	END IF
END IF
end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////
//
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	04/11/03	GaryR	Track 3517d	PDR label changes
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//	01/28/05	GaryR	Track 4212d	Enable the Next button if PDR selected
//
////////////////////////////////////////////////////////////////////

Integer	li_rc, li_selectedtabpage, li_rowcount, li_row
uo_query			luo_query
w_query_engine	lw_parent
DatawindowChild	ldwc_pdr_type, ldwc_pdr_ver

SetPointer( HourGlass! )

li_rc	=	This.of_getparentwindow(lw_parent)
luo_query	=	This.of_getuoquery()

// Reset criteria and report tabs
tabpage_source.enabled = FALSE
tabpage_search.enabled = FALSE
tabpage_report.enabled = FALSE
tabpage_view.enabled = FALSE
cb_next_pdr.enabled = FALSE

THIS.object.pdr_desc[1] = ""

IF NOT IsValid( lw_parent ) OR IsNull( lw_parent ) THEN
	MessageBox( "ERROR", "Unable to instantiate parent window" )
	Return 1
END IF

li_SelectedTabpage = lw_parent.wf_GetTab().SelectedTab
lw_parent.wf_ResetLevelText(li_SelectedTabpage)

IF NOT IsValid( luo_query ) OR IsNull( luo_query ) THEN
	MessageBox( "ERROR", "Unable to instantiate query object" )
	Return 1
END IF

THIS.GetChild( "pdr_type", ldwc_pdr_type )
THIS.GetChild( "pdr_report", ldwc_pdr_ver )

CHOOSE CASE dwo.name
	case "pdr_cat"		
		ldwc_pdr_type.Reset()
		ldwc_pdr_ver.Reset()
		This.object.pdr_type[1] = ""
		This.object.pdr_report[1] = ""
		
		is_inv_type = Upper( Left( Trim( data ), 2 ) )
		IF IsNull( is_inv_type ) OR Trim( is_inv_type ) = "" THEN
			MessageBox( "ERROR", "Invalid Invoice Type" )
			Return 0
		END IF
		
		//	Select the pdr_type
		li_rowcount = ldwc_pdr_type.retrieve( data )
		IF li_rowcount < 1 THEN
			MessageBox( "ERROR", "There are no PDR Types available." + &
					"~n~rPlease contact your System Administrator.", StopSign!)
			Return 0
		END IF
		
		// Check for default
		li_row = ldwc_pdr_type.Find( "code_value_n > 0", 0, li_rowcount )
		IF li_row > 0 THEN
			This.SetColumn( "pdr_type" )
			This.SetText( ldwc_pdr_type.GetItemString( li_row, "code_code" ) )
			This.AcceptText()
		ELSE
			li_row = ldwc_pdr_type.InsertRow(1)
			ldwc_pdr_type.SetItem(li_row,1,'AA')		
			ldwc_pdr_type.SetItem(li_row,2,'(Select PDR Type)')
			This.object.pdr_type[1] = 'AA'			
		END IF
			
	case "pdr_type"
		ldwc_pdr_ver.Reset()
		This.object.pdr_report[1] = ""
		
		IF data = "AA" THEN Return 0
		
		li_rowcount = ldwc_pdr_ver.Retrieve( This.object.pdr_cat[1], data )

		IF	li_rowcount	<	1		THEN
			MessageBox( "ERROR", "There are no reports associated with the current PDR Type" + &
										"~n~rPlease contact your System Administrator regarding this error", StopSign! )
			Return 0
		END IF

		// Perform PDR security
		li_rowcount = luo_query.event ue_tabpage_pdr_secure( ldwc_pdr_ver )
		
		IF li_rowcount < 1 THEN
			//	All PDRs secured
			MessageBox( "Warning", "You do not have sufficient privileges " + &
										"to view any reports under the current PDR Type", Exclamation! )
			Return -1
		END IF

		li_row = ldwc_pdr_ver.InsertRow(1)
		ldwc_pdr_ver.SetItem(li_row,"pdr_label","(Select PDR Version)")
		This.object.pdr_report[1] = "(Select PDR Version)"

	case "pdr_report"
		//	Reset items
		tabpage_search.dw_criteria.Reset()
		tabpage_search.ddlb_pdr_opt.SelectItem(1)
		
		//	Validate the data argument
		IF IsNull( data ) OR Trim( data ) = "" THEN
			MessageBox( "ERROR", "Invalid Report" )
			Return 0
		END IF
		
		IF data = "(Select PDR Version)" THEN Return 0
		
		//	Select the pdr_report
		li_row = ldwc_pdr_ver.GetSelectedRow(0)
		
		IF li_row < 1 THEN
			MessageBox( "ERROR", "Unable to identify selected report" )
			Return 0
		END IF
			
		//	Populate the description
		THIS.object.pdr_desc[1] = ldwc_pdr_ver.GetItemString( li_row, "pdr_desc" )
		
		//	Rebuild the report syntax
		IF luo_query.Event ue_tabpage_pdr_build_syntax( &
				ldwc_pdr_ver.GetItemString( li_row, "pdr_name" ) ) < 0 THEN Return 0
		
		//	Check if the current PDR Type will query Claims/Ancillary Base/Subsets
		IF ldwc_pdr_ver.GetItemNumber( li_row, "pdr_source" ) > 0 THEN
			// Load the data source on PDR tab
			IF luo_query.event ue_tabpage_pdr_load_source( luo_query.ib_new_flag ) < 0 THEN Return 0
			tabpage_source.enabled = TRUE
		ELSE
			li_rc = luo_query.Event ue_tabpage_pdr_load_search( TRUE )
			IF li_rc < 0 THEN Return 0
			
			tabpage_report.enabled = TRUE
			tabpage_view.enabled = TRUE
			
			IF li_rc > 0 THEN	tabpage_search.enabled = TRUE
		END IF
		
		cb_next_pdr.enabled = TRUE
		
		//set the level tabpage text
		lw_parent.wf_SetLevelText(li_SelectedTabpage)
		
		//	Initialize the report options
		luo_query.Event ue_tabpage_pdr_init_report_options()
END CHOOSE
end event

event buttonclicked;call super::buttonclicked;//*********************************************************************************
// Script Name:	buttonclicked
//
//	Arguments:		1.	row
//						2.	actionreturncode
//						3.	dwo
//
// Returns:			Long
//
//	Description:	This event is triggered when any button is clicked in the
//						d/w object.  This script will identify the current report name.  
//						This name is passed to of_help() to display help for this report.
//
//*********************************************************************************
//	
//	04/11/03	GaryR	Track 3518d	Add RTF help for PDRs
//	04/29/03	GaryR	Track 3541d	Add PDR tab-sensitive help
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//
//*********************************************************************************

Integer	li_rc
sx_pdr_parms	lsx_pdr_parms
w_query_engine	lw_parent

// Call help for this column
li_rc			=	This.of_GetParentWindow (lw_parent)
lw_parent.of_get_pdr_parm( lsx_pdr_parms )

lw_parent.of_help ('W_QUERY_ENGINE', lsx_pdr_parms.pdr_name )

end event

type cb_close_pdr from u_cb within tabpage_pdr
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2930
integer y = 1764
integer width = 261
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

event clicked;call super::clicked;Integer		li_rc

w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)


Close (lw_parent)

end event

type cb_next_pdr from u_cb within tabpage_pdr
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2592
integer y = 1764
integer width = 261
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Next"
end type

event clicked;call super::clicked;This.of_getuoquery().Event	ue_next_tabpage()
end event

type cb_prev_pdr from u_cb within tabpage_pdr
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 2254
integer y = 1764
integer width = 261
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Prev"
end type

event clicked;call super::clicked;This.of_getuoquery().Event	ue_prev_tabpage()
end event

type tabpage_source from userobject within uo_query
string accessiblename = "Data Source Tab"
string accessibledescription = "The Data Source tab allows you to specify the STARS tables you want to select data from or the subset of data that was previously saved."
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 3209
integer height = 1912
boolean enabled = false
long backcolor = 67108864
string text = "Data Source"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_source dw_source
cb_close_source cb_close_source
cb_next_source cb_next_source
uo_tabpage_source uo_tabpage_source
cb_prev_source cb_prev_source
end type

on tabpage_source.create
this.dw_source=create dw_source
this.cb_close_source=create cb_close_source
this.cb_next_source=create cb_next_source
this.uo_tabpage_source=create uo_tabpage_source
this.cb_prev_source=create cb_prev_source
this.Control[]={this.dw_source,&
this.cb_close_source,&
this.cb_next_source,&
this.uo_tabpage_source,&
this.cb_prev_source}
end on

on tabpage_source.destroy
destroy(this.dw_source)
destroy(this.cb_close_source)
destroy(this.cb_next_source)
destroy(this.uo_tabpage_source)
destroy(this.cb_prev_source)
end on

type dw_source from u_dw within tabpage_source
event type integer ue_get_inv_types ( ref string as_inv_type[] )
event type string ue_get_inv_type ( string ls_alias )
string accessiblename = "Source"
string accessibledescription = "Source"
integer x = 5
integer y = 40
integer width = 3154
integer height = 1468
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_source"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_get_inv_types;/////////////////////////////////////////////////////////////////////////////
// Event/Function					Object				
//	--------------					------				
// ue_get_inv_types				tabpage_source
//
//	Description
//	-----------
// This event is called from the itemchanged event, ue_tabpage_report_reset_available_cols, 
// ue_list_report_tempate() and ue_create_sql().  If the user selects ML as an invoice type,
// it will get all the other invoice types and put them into an array. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument						Description
//		---------	--------						-----------
//		Reference	as_inv_type[]			All invoice types.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.
//						
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/04/97		Created.
//	F.Chernak		03/24/98		Track 912. 1.Clear ML out of as_inv_type array.
//										2. Must use a different index to move invoice type into 
//										invoice type array. If use same index to load and read
//										invoice types can wind up with null invoice types.
//										3.Do not load invoice if it is MC
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

datawindowchild ldwc_data_source
Integer	li_RowCount,	&
			li_Index,		&
			li_tbl_type
string 	ls_clear_array[]

this.getchild('data_source',ldwc_data_source)

li_RowCount = ldwc_data_source.rowcount()

if li_RowCount > 0 then
	as_inv_type = ls_clear_array
else
	messagebox('ERROR','Cannot determine invoice types in uo_query.dw_source.ue_get_inv_types')
	return -1
end if

li_tbl_type = 1
for li_Index = 1 to li_RowCount
	if Left(Trim(Upper(ldwc_data_source.getitemstring(li_Index,1))),2) <> "ML" then
		if Left(Trim(Upper(ldwc_data_source.getitemstring(li_Index,1))),2) <> "MC" then
			as_inv_type[li_tbl_type] = left(ldwc_data_source.getitemstring(li_Index,1),2)
			li_tbl_type++
		end if
	end if
next

RETURN 1
end event

event type string ue_get_inv_type(string ls_alias);//////////////////////////////////////////////////////////////////////////
//
//	This method will get the selected invoice type for the alias argument
//
//////////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
//
//////////////////////////////////////////////////////////////////////////

Integer	li_find
String ls_inv_type

li_find = This.find( "base_invoice = '" + ls_alias + "'", 1, This.RowCount() )

IF li_find > 0 THEN
	ls_inv_type = Left( This.GetItemString( li_find, "inv_type" ), 2 )
END IF

Return ls_inv_type
end event

event losefocus;call super::losefocus;/////////////////////////////////////////////////////////////////////////////
// Event/Function			Object							
//	--------------			------							
// losefocus				tabpage_source.dw_source	
//
//	Description
//	-----------
//	When this event is triggered, must check to see if data type and data source match if 
// data type = SUBSET.  If match will set is_data_type = "SUBSET" else "BASE" for future 
// use  (see Note under Overview of ts144-uo_query-uo_create_sql).  The check is performed 
// here since if the data source = "MC" and the subset is not, must not allow them to continue.  
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		DataType		Description
//		---------	--------		--------		-----------
//		NONE.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Long			0				(Default) Accept the data value
//						1				Reject the data value and don't allow focus to change
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/04/97		Created.
// Lahu S			12/21/01		Track 2552d Check for engine mode
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_match, li_Row

//Lahu S 12/21/01 Begin
if is_query_engine_mode = "PDR" or is_query_engine_mode = "PDCR" then	Return
//Lahu S End

li_Row = tabpage_source.dw_source.GetRow()

If li_Row > 0 THEN
	

	if tabpage_source.dw_source.object.rb_source[li_Row] = "SUBSET" then
		li_match = This.of_getuoquery().event ue_tabpage_source_match_type_and_source()
		if li_match = -1 then
			/* set focus to dw_source.object.data_source */
			tabpage_source.dw_source.SetColumn('data_source')
			tabpage_source.dw_source.SetFocus()
		end if
	end if
	
End if
end event

event itemchanged;/////////////////////////////////////////////////////////////////////////////
// Event/Function			Object							
//	--------------			------							
// itemchanged				tabpage_source.dw_source	
//
//	Description
//	-----------
//	When this event is triggered, three fields need to be checked.  The first is 
//	rb_source. If the Base radio button is clicked, the case_id and subset_name should
//	be cleared out and made invisible. If the Subset radio button is checked, the 
//	case_id and subset_name should be visible and if have active subset populate the 
//	fields. If a data source is selected, must retrieve additional data source drop 
//	down datawindow basedon what was selected.  Then must enable tabpage_search 
//	(if not subset view) and tabpage_report and set the periods and columns depending 
//	on data source selected.  Must also get the data source type (C, FT, MC, ML, AN)
//	to determine if Data Type group box should be visible and if the period object on 
//	the search tabpage should be visible.  Also must set the right mouse menus 
//	depending on data source selected, Break with Totals is set only if single invoice 
//	type for subset view. Lastly, if an additional data source is selected, it must be 
//	added to columns on both tabpages.  Note:  All the calls to events on 
//	w_query_engine may have to be placed in user events on iuo_query and posted since
//	maybe one level too deep.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		DataType		Description
//		---------	--------		--------		-----------
//		Value			row			Long			Row of item which has changed.
//						dwo			dwobject		The changed column of the dw.
//						data			string		The data in the changed column.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Long			0				(Default) Accept the data value
//						1				Reject the data value and don't allow focus to change
//						2				Reject the data value but allow the focus to change
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/04/97	Created.
// FNC		01/14/98	Add dependent type to ue_tabpage_search_set_columns.
//							Must retrieve the dependent and main tables in the dddw
//							at the same time because the dependent columns overlay the
//							main columns when they are retrieved after the main cols.
// FNC		01/28/98	If drilldown don't pass the main table invoice type to
//							the criteria datawindow because don't want to retrieve
//							the main inv type.
// FNC		01/29/98	If drilldown set drilldown invoice type
// FNC		02/11/98	Enable search and report tabs if drilldown and
//							change add source.
//	FDG		03/02/98	When enabling tabs, see if the Next button
//							is to be enabled.
//	FDG		03/03/98	Track 884.  For an ML invoice type, add MC to
//							the list of invoice types.
// FNC		03/07/98	Track 858.  Active subset name is in gc_active_subset_name.
//							Pass this value to event so that the subset name is defaulted.
//	FNC		03/11/98	When subset id is set or changed it must be saved into
//							is_source_subset_id.
// FNC		03/18/98	Track 931.  Load datasource with invoice types in subset. 
//							Once loaded, protect datasource is source is a subset.
//	FDG		04/02/98	Track 1014. When data_source or add_data_source is
//							changed, clear out the previous data in the Search By
//							and Report On tabs.
//	FDG		04/02/98	Track 959.  When the data source changes, save its entire
//							description so it can be passed to w_query_save.
//	FDG		04/14/98	Track 975, 1063.  If the data source has changed, set
//							a boolean stating if the data source is an ancillary
//							table.  Then trigger an event to enable/disable
//							the appropriate RMM items.
//	FDG		04/14/98	Track 1014. Removed the warning messages because it would
//							display when selecting another PDQ.
//	FDG		04/28/98	Track 1115. Period on tabpage_search needs to be set
//							to 'NONE' for PDQ's built from subsets.
// FNC		04/30/98	Track 1146. Don't reset tabpage_report.dw_selected if
//							additional datasource is modified. There is code in U_NVO_report
//							that removes an columns that are not from the main table.
//							So the datawindow does not have to be reset.
//	FDG		05/07/98	Track 1207.  Triggger a script to determine if the data source
//							is an ancillary data source.
//	FDG		05/11/98	Track 1178.  Perform logic thru events/functions because
//							other scripts must execute the same functionality.
// FNC		05/26/98	Track 1110. Remove trigger to 
//							w_query_engine.ue_set_menus_subset_view_break_w_totals because
//							this event is already triggered correctly in other places. It
//							is unecessary to trigger it here and it causes problems.
// FNC		06/03/98	Track 1166. Call Remove_All_Levels if user selects MC because
//							can only have one level if invoice type is MC.
//	FDG		09/11/98	Track 1687.  When the data source changes, reset the super
//							provider data that was previously set.
//	FDG		02/05/99	Track 2084c.  When the data source changes, ALWAYS clear out
//							the filter information for ONLY this level.
// FNC		04/21/99	FS/TS 2212C Starcare Track 2212 Trigger event rather than 
//							post event
// FNC		02/22/00	Track 2089 Development. Always set period to NONE each time
//							a new datasource is selected even is source is Base. 
// FNC 		06/13/00	Track 2263. Set active invoice to selected invoice type.
// FNC		10/24/01	Track 3683 Starcare. Make the data ddlb's invisible if
//							source of query is a subset.
// Lahu S   2/28/02  Track 2552d Make 'Per Month Paid' text in fast query dw 
//							visible if invoice type is claims or query type is subset
//	GaryR		10/18/02	Track 3986c	Reset the criteria when the query type changes
//	GaryR		11/26/02	Track 3275d	Reset the criteria if additional query type changes
//	GaryR		03/04/03	Track 3385d	Disable Claim Detail when ML
//	GaryR		11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR		12/30/04	Track 4212d Beefed up subset validation and improve control flow
// GaryR		01/06/05	Track 4217d	Move data_source itemchanged to user event for external use
// HYL 		01/12/06 Track 4613d	When subset id is blank or empty string, don't even bother to run the case section for 'subset_name'
// HYL 		03/06/06 Track 4471d	Introduced ib_subset_name_changed to coordinate the availability of Period and Payment Date Options controls
//JasonS		04/02/06 Track 4711d	added code to call  ue_tabpage_source_itemchanged when the subset name changes
//JasonS		04/04/06	Track 4711d  only fire ue_tabpage_source_itemchanged if in PDQ mode
//	GaryR		12/20/07	SPR 5199	Add the facility to categorize and sort data sources
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String		ls_expression_one,		&
				ls_rel_type, 				&
				ls_add_inv_type
Integer		li_rc,						&
				li_rowcount
Long			ll_criteria_rowcount,	&
				ll_selected_rowcount,	&
				ll_row
Boolean		lb_criteria_changed

uo_query		luo_query
luo_query	=	This.of_getuoquery()
//	FDG 04/02/98 Start
//	See if any data exists in dw_criteria and dw_selected
lb_criteria_changed		=	luo_query.of_edit_criteria_changed()			// FDG 05/11/98

ll_selected_rowcount		=	tabpage_report.dw_selected.RowCount()

// FDG 04/02/98 End

choose case dwo.Name
	
	case 'rb_source'
		If IsValid(luo_query) Then
			luo_query.post event ue_tabpage_source_set_data_type(data, & 
				gc_active_subset_name, gc_active_subset_case)		//03-07-98 FNC
		End If
		
		luo_query.post event	ue_tabpage_search_set_period_visibility()
		luo_query.post event	ue_tabpage_search_set_pd_opt_visibility()
		
		//LahuS  2/28/02 begin
		if data = "Subset" then
			tabpage_report.dw_fastquery.object.t_1.visible = 0
		else
			tabpage_report.dw_fastquery.object.t_1.visible = 1			
		end if
		//LahuS 2/28/02 End		
		
		//	GaryR		10/18/02	SPR 3986c - Begin
		luo_query.of_set_data_type( data )
		tabpage_search.dw_criteria.Reset()
		tabpage_search.uo_period.uf_scroll_to_row('NONE')
		//	GaryR		10/18/02	SPR 3986c - End
	case 'subset_name'													//03-11-98 FNC
		IF IsNull(data) OR Len(Trim(data)) = 0 THEN // HYL 01/12/06 Track 4613d
		ELSE
			IF is_query_engine_mode = "PDR" OR is_query_engine_mode = "PDCR" THEN
				luo_query.Post Event ue_tabpage_pdr_validate_source()
			ELSEIF is_query_engine_mode = "PDQ" THEN
				ib_subnet_name_changed = TRUE  // 03/06/06 HYL Track 4471d
			END IF
			
			IF luo_query.Event UE_Tabpage_Source_Set_Subset_ID( row, data ) < 0 THEN
				luo_query.Post Event ue_SelectTab(IC_SOURCE)
				Return 2
			END IF
			
			if is_query_engine_mode = 'PDQ' then
				luo_query.event ue_tabpage_source_itemchanged(is_inv_type)
			end if			
		END IF
	case "category"
		IF luo_query.event ue_tabpage_source_filter_data_source() < 0 THEN
			MessageBox( "ERROR", "Category (" + data + ") does not have any data sources.", StopSign! )
			Return 0
		END IF
	case 'data_source' 
		luo_query.event ue_tabpage_source_itemchanged( data )
	case 'add_data_source'
		ls_add_inv_type = luo_query.of_get_add_inv_type( )

		luo_query.Event	ue_add_data_source_change (data)		// FDG 05/11/98
		
		if ib_drilldown then												// FNC 03/09/00
			if istr_drilldown.path = 'AD' then
				luo_query.Event	ue_set_ancillary_inv_type (data)
			end if
		end if		
	
		if (trim(ls_add_inv_type) <> '') then 
			tabpage_search.uo_period.uf_scroll_to_row('NONE')	//	GaryR		11/26/02	SPR 3275d
		end if
	
	// PDR columns
	case "inv_type"
		//	Check for duplicate invoice types
		FOR li_rc = 1 TO This.RowCount()
			IF li_rc = row THEN Continue
			IF This.GetItemString( li_rc, "inv_type" ) = data AND NOT IsNull( data ) AND Trim( data ) <> "" THEN
				MessageBox( "ERROR", "Invoice Type (" + data + ") is already selected in Data Source #" + String( li_rc ) + &
									"~n~rPlease select another invoice type for Data Source #" + String( row ), StopSign! )
				Return 2
			END IF
		NEXT
		This.object.subset_name[row] = ""
		// Flag to reset claims pdr criteria
		ib_pdr_inv_changed = TRUE
		luo_query.Post Event ue_tabpage_pdr_validate_source()

	case "source_type"
		luo_query.Post Event ue_tabpage_pdr_validate_source()
		
end choose

luo_query.Event	ue_SelectTab(0)			//	FDG 03/03/98

RETURN 0
end event

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(FALSE)
end event

event ue_updatespending;////////////////////////////////////////////////////////////////////////////
//	OVERRIDE!
//	Function:  	u_dw.ue_updatespending
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Determine if there are any pending updates on this d/w.
//						NOTE: this logic is only for the CloseQuery event
//
//////////////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
//
//////////////////////////////////////////////////////////////////////////////

// don't attempt a 'REAL UPDATE'
If Not(ib_FromCloseQuery) OR is_query_engine_mode = "PDR" OR is_query_engine_mode = "PDCR" Then RETURN 0

//	Check for pending updates
// NOTE: is_inv_type is reset in parent.Event ue_new_query, and 
//       set in this.Event itemchanged. This 'flag' is necessary
//			since tabpage source always contains modified data due to load event.
IF	This.ModifiedCount()	+	This.DeletedCount()	>	0	AND Trim(is_inv_type) <> '' THEN
	RETURN 1
END IF

//	There are no pending updates
RETURN 0
end event

event rbuttonup;//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

w_query_engine	lw_parent
This.of_getparentwindow(lw_parent)

if dwo.name = 'subset_name' AND NOT This.of_getuoquery().ib_drilldown &
AND NOT lw_parent.wf_get_disable_update() then

else
	This.of_getuoquery().Event ue_open_menu()
end if

Return 1

end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	12/02/98	FDG	Track 2004.	Created
//	01/28/05	GaryR	Track 4212d	Trigger itemchanged if Enter is pressed
//
//*********************************************************************

IF key = KeyEnter! THEN This.AcceptText()

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

uo_query		luo_query

IF is_query_engine_mode = "PDR" OR is_query_engine_mode = "PDCR" THEN
	luo_query	=	This.of_getuoquery()
	luo_query.Event ue_tabpage_pdr_filter_source()
END IF
end event

event ue_lookup;call super::ue_lookup;/////////////////////////////////////////////////////////////////////////////
// Event/Function			Object							
//	--------------			------							
// rbuttondown				tabpage_source.dw_source
//
//	Description
//	-----------
//	When this event is triggered, if clicked on subset_name will open the subset list window 
// and allow the user to select a subset name to use in the data type.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/04/97	Created. NOTE: the tech. spec. refers to gc_active_subset_name
//												and gc_active_subset_case, neither of
//												which are declared in the app.. Therefore,
//												the declarations MUST BE VERIFIED!!
// A.Sola   02/03/98 TS145- Fix Globals; changed case id global variable
//	J.Mattis	12/08/97	Changed assignments to correct global variables.
//	J.Mattis	02/11/98	Switched global variable assignments to correct error.
//	FDG		04/07/98	Track 991.  Open w_subset_use as a response window.
//	FDG		09/25/95	Track 1745.  Move from rbuttondown.
//	FDG		11/18/98	Track 1903.  Always return 1 from any rbuttonup event
//							to prevent the window's cut/copy/paste RMM from
//							displaying.
// AJS      11/01/99 Rel 4.5 ts2463 - pass empty structure to w_subset_use
//	FDG		11/01/01	Track 2505d.  If user blanks out subset name, then RMM,
//							system thinks that subset name is blank & displays an
//							error message.
//	GaryR		02/25/03	Track 3452d	Account for drilldown with subset as base
//	GaryR		11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR		02/01/05	Track 4212d	Prevent RMM popup on cancel
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
/////////////////////////////////////////////////////////////////////////////

Integer	li_row
sx_subset_use lstr_subset_use
w_query_engine	lw_parent

This.of_getparentwindow(lw_parent)

if Lower( as_col ) = 'subset_name' AND NOT This.of_getuoquery().ib_drilldown &
AND NOT lw_parent.wf_get_disable_update() then
	li_row = This.GetRow()
	IF li_row < 1 THEN Return

	SetPointer(HourGlass!)
	gv_from = 'U'
	
	IF is_query_engine_mode = "PDR" OR is_query_engine_mode = "PDCR" THEN
		lstr_subset_use.inv_type = Left( This.object.inv_type[li_row], 2 )
		IF IsNull( lstr_subset_use.inv_type ) OR Trim( lstr_subset_use.inv_type ) = "" THEN
			lstr_subset_use.inv_type = This.object.inv_types[li_row]
		END IF
	END IF
	
	OpenWithParm (w_subset_use,lstr_subset_use)	//ajs 11/01/99 				// FDG 04/07/98
	IF gv_result = 100 THEN Return
	this.object.case_id[li_row] = gc_active_subset_case	//ajs 4.0 03-11-98 fix globals
	This.SetRow(li_row)
	This.SetColumn( "subset_name" )
	This.SetText( gc_active_subset_name )
	This.AcceptText()
end if
end event

type cb_close_source from u_cb within tabpage_source
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2930
integer y = 1764
integer width = 261
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

event clicked;call super::clicked;Integer		li_rc

w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)


Close (lw_parent)

end event

type cb_next_source from u_cb within tabpage_source
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2592
integer y = 1764
integer width = 261
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Next"
end type

event clicked;call super::clicked;This.of_getuoquery().Event	ue_next_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type uo_tabpage_source from uo_tabpage_qe within tabpage_source
event destroy ( )
string accessiblename = "Data Source"
string accessibledescription = "Data Source"
integer x = 18
integer y = 24
integer width = 3163
integer height = 1696
end type

on uo_tabpage_source.destroy
call uo_tabpage_qe::destroy
end on

type cb_prev_source from u_cb within tabpage_source
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 2254
integer y = 1764
integer width = 261
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Prev"
end type

event clicked;This.of_getuoquery().Event	ue_prev_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type tabpage_search from userobject within uo_query
string accessiblename = "Search Criteria Tab"
string accessibledescription = "The Search Criteria tab defines the parameters used to select data from the tables or subset."
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 3209
integer height = 1912
boolean enabled = false
long backcolor = 67108864
string text = "Search Criteria"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_text_view_search st_text_view_search
dw_criteria dw_criteria
cb_close_search cb_close_search
cb_next_search cb_next_search
st_count_search st_count_search
st_count_view_search st_count_view_search
cb_prev_search cb_prev_search
pb_notes_search pb_notes_search
ddlb_pdr_opt ddlb_pdr_opt
gb_available_claims gb_available_claims
uo_tabpage_search uo_tabpage_search
uo_period uo_period
st_period st_period
st_payment_date_options st_payment_date_options
ddlb_pd_opt ddlb_pd_opt
end type

on tabpage_search.create
this.st_text_view_search=create st_text_view_search
this.dw_criteria=create dw_criteria
this.cb_close_search=create cb_close_search
this.cb_next_search=create cb_next_search
this.st_count_search=create st_count_search
this.st_count_view_search=create st_count_view_search
this.cb_prev_search=create cb_prev_search
this.pb_notes_search=create pb_notes_search
this.ddlb_pdr_opt=create ddlb_pdr_opt
this.gb_available_claims=create gb_available_claims
this.uo_tabpage_search=create uo_tabpage_search
this.uo_period=create uo_period
this.st_period=create st_period
this.st_payment_date_options=create st_payment_date_options
this.ddlb_pd_opt=create ddlb_pd_opt
this.Control[]={this.st_text_view_search,&
this.dw_criteria,&
this.cb_close_search,&
this.cb_next_search,&
this.st_count_search,&
this.st_count_view_search,&
this.cb_prev_search,&
this.pb_notes_search,&
this.ddlb_pdr_opt,&
this.gb_available_claims,&
this.uo_tabpage_search,&
this.uo_period,&
this.st_period,&
this.st_payment_date_options,&
this.ddlb_pd_opt}
end on

on tabpage_search.destroy
destroy(this.st_text_view_search)
destroy(this.dw_criteria)
destroy(this.cb_close_search)
destroy(this.cb_next_search)
destroy(this.st_count_search)
destroy(this.st_count_view_search)
destroy(this.cb_prev_search)
destroy(this.pb_notes_search)
destroy(this.ddlb_pdr_opt)
destroy(this.gb_available_claims)
destroy(this.uo_tabpage_search)
destroy(this.uo_period)
destroy(this.st_period)
destroy(this.st_payment_date_options)
destroy(this.ddlb_pd_opt)
end on

type st_text_view_search from statictext within tabpage_search
boolean visible = false
string accessiblename = "Report Count"
string accessibledescription = "Report Count"
accessiblerole accessiblerole = statictextrole!
integer x = 750
integer y = 1780
integer width = 585
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_criteria from u_dw within tabpage_search
event ue_set_lookup ( integer ai_row,  string as_data )
event ue_filter_exp2 ( string arg_data_type,  string arg_data )
event type boolean ue_is_exp2_column ( string as_data )
event ue_remove_exp2_column ( string as_column )
event ue_load_exp2_dddw ( )
event type string ue_get_exp1_datatype ( string as_column )
event ue_set_exp2colname ( long al_row )
string accessiblename = "Criteria"
string accessibledescription = "Criteria"
integer x = 18
integer y = 320
integer width = 3163
integer height = 1416
integer taborder = 20
string dataobject = "d_criteria_drilldown"
boolean vscrollbar = true
end type

event ue_set_lookup(integer ai_row, string as_data);//************************************************************
//This event determines if the field selected is a lookup field.  
//If it is, it sets the lookup global (gv_code_to_use) and the 
//lookup field for this row.  Must make changes to the original script.  
//Get rid of the getitemstrings (may have to pass argument 
//from itemchanged event, both row & data).  
//Also should use datastore (n_ds) instead of select to get lookup_type.  
//Will add code to change the color of expression_two if the field is 
//a lookup.
//************************************************************
//	02/04/98	FDG	Use of_check_status() for embedded SQL.
//						Call of_commit() to Commit
//
//	03/06/98	FDG	Get lookup type from DDDW.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//************************************************************

string	ls_find
Long		ll_row
DataWindowChild	ldwc

This.GetChild ('expression_one',ldwc)

ls_find	=	"col_name = '"	+	as_data	+	"'"
ll_row	=	ldwc.Find ( ls_find, 1, ldwc.RowCount() )

IF	ll_row	>	0		THEN
	gv_code_to_use	=	ldwc.GetItemString (ll_row, 'elem_lookup_type')
ELSE
	gv_code_to_use	=	''
END IF

This.SetItem( ai_row, "lookup", gv_code_to_use )
end event

event ue_filter_exp2(string arg_data_type, string arg_data);///////////////////////////////////////////////////////////////////////
//	Script:		dw_criteria.ue_filter_exp2
//
//	Arguments:	arg_data = the value in exp1 on dw_criteria
//
//	Returns:		None
//
//	Description:
//		This event will take the column name and data type passed to filter
//		the possible entries in the expression-two DDDW.  Please note that
//		invoice type is also used in the filter to prevent a column from one
//		invoice type to be compared against a column in a different invoice
//		type.  This isn't allowed because ASE doesn't allow an outer join
//		to be combined with an inner join.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	NLG	10/16/01	Stars 5.0.	Created.
//	FDG	11/08/01	Stars 5.0.	Modified.
//	GaryR	06/21/02	Track 3151d	Filter by data type groups.
//
///////////////////////////////////////////////////////////////////////

datawindowchild ldwc_exp_two

String ls_datatype = "", ls_data = ""
String ls_find, ls_filter,	ls_sort, ls_inv_type
//Long ll_find_row
Int li_rc

//	GaryR	06/21/02	Track 3151d - Begin
String	ls_exp2_type
Integer	li_ctr, li_count
Constant String	lcs_filterall = "FILTERALL"		//	Indicate to filter out all rows
//	GaryR	06/21/02	Track 3151d - End

ls_datatype	= Trim (arg_data_type)
ls_data		= Trim (arg_data)
ls_filter 	= ""

// If a column name was passed without a data type, get the column's datatype.
IF	 ls_datatype	=	""		&
AND ls_data			>	" "	THEN
	// Get the data type
	ls_datatype		=	This.Event	ue_get_exp1_datatype (ls_data)
END IF

// If the column is payment_date, no column-to-column comparison is allowed.
IF	Mid (ls_data, 4)	=	'PAYMENT_DATE'		THEN
	ls_data		=	""
	ls_datatype	=	""
	ls_inv_type = lcs_filterall				//	GaryR	06/21/02	Track 3151d
END IF

// If no data type was passed, set the data type to a value that will
// cause the filter to remove all rows
IF	IsNull (ls_datatype)				&
OR	Trim (ls_datatype)	=	""		THEN
	ls_datatype	=	"99999xx99999999999"
	ls_inv_type = lcs_filterall				//	GaryR	06/21/02	Track 3151d
END IF

//	GaryR	06/21/02	Track 3151d
IF Trim( ls_inv_type ) = "" THEN ls_inv_type		=	Left (ls_data, 2)

li_rc = this.getchild('expression_two',ldwc_exp_two)
//unfilter exp2
li_rc = ldwc_exp_two.setfilter(ls_filter)
li_rc = ldwc_exp_two.filter()

//	GaryR	06/21/02	Track 3151d - Begin

//filter by exp1 datatype
//ls_filter = "Upper(elem_data_type) = '" + Upper(ls_datatype) + &
//				"' and Upper(elem_tbl_type) = '"	 + Upper(ls_inv_type)	+	"'"
ls_filter = "Upper(elem_tbl_type) = '"	 + Upper(ls_inv_type)	+	"'"
li_rc = ldwc_exp_two.setFilter(ls_filter)
li_rc = ldwc_exp_two.filter()

//	Loop thru each column in exp2
//	and determine if the datatype 
//	satisfies the datatype of the group
li_count = ldwc_exp_two.RowCount()

FOR li_ctr = 1 TO li_count
	ls_exp2_type = ldwc_exp_two.GetItemString( li_ctr, "elem_data_type" )
	
	//	Check for character data type
	IF gnv_sql.of_is_character_data_type( ls_datatype ) THEN
		IF NOT gnv_sql.of_is_character_data_type( ls_exp2_type ) THEN
			ldwc_exp_two.RowsMove( li_ctr, li_ctr, Primary!, ldwc_exp_two, 1, Filter! )
			li_ctr --
			li_count --
		END IF		
	END IF
	
	//	Check for date data type
	IF gnv_sql.of_is_date_data_type( ls_datatype ) THEN
		IF NOT gnv_sql.of_is_date_data_type( ls_exp2_type ) THEN
			ldwc_exp_two.RowsMove( li_ctr, li_ctr, Primary!, ldwc_exp_two, 1, Filter! )
			li_ctr --
			li_count --
		END IF
	END IF
	
	//	Check for number data type
	IF gnv_sql.of_is_number_data_type( ls_datatype ) THEN
		IF NOT gnv_sql.of_is_number_data_type( ls_exp2_type ) THEN
			ldwc_exp_two.RowsMove( li_ctr, li_ctr, Primary!, ldwc_exp_two, 1, Filter! )
			li_ctr --
			li_count --
		END IF
	END IF
	
	//	Check for money data type
	IF gnv_sql.of_is_money_data_type( ls_datatype ) THEN
		IF NOT gnv_sql.of_is_money_data_type( ls_exp2_type ) THEN
			ldwc_exp_two.RowsMove( li_ctr, li_ctr, Primary!, ldwc_exp_two, 1, Filter! )
			li_ctr --
			li_count --
		END IF
	END IF
NEXT
//	GaryR	06/21/02	Track 3151d - End

// Re-Sort the DDDW
ls_sort	=	"col_desc A"
li_rc		=	ldwc_exp_two.SetSort(ls_sort)
li_rc		=	ldwc_exp_two.Sort()

// Find field displayed in exp1 and filter it out of exp2.  This will prevent
// a column being compared against itself.  Post this event because 
//	ldwc_exp_two is required here and in ue_remove_exp2_column.
//
//ls_find = "col_name = '" + ls_data + "'"
//ll_find_row = ldwc_exp_two.find(ls_find,1,ldwc_exp_two.rowCount())
//if ll_find_row < 1 then
//	//do nothing
//else
//	li_rc = ldwc_exp_two.rowsMove(ll_find_row,ll_find_row,Primary!,ldwc_exp_two,1,Filter!)
//end if
This.Event	ue_remove_exp2_column (ls_data)		
					

end event

event type boolean ue_is_exp2_column(string as_data);/////////////////////////////////////////////////////////////////////////////
//
//	Script:		ue_is_exp2_column
//
//	Arguments: 	as_data = the value in exp2 on dw_criteria
//
//	Returns:		Boolean
//					TRUE	=	expression_two is a selected column
//					FALSE	=	expression_two is either empty or was manually entered
//
//	Description:
//			This event will determine if the value in expression_two (as_data)
//			was a selected column from the drop-down.  Please note that it
//			searches for col_name (not the displayed text) in the expression_two
//			dropdown.
//
//			This script assumes that expression_two stores the column description
//			& expression_one stores the column name.
//
/////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	11/08/01	Stars 5.0.	Created
//
/////////////////////////////////////////////////////////////////////////////

DataWindowChild	ldwc_exp_one

String	ls_find

Long		ll_find_row,		&
			ll_rowcount

Integer	li_rc

// If no data was passed, get out
// cause the filter to remove all rows
IF	IsNull (as_data)				&
OR	Trim (as_data)	=	""		THEN
	Return	FALSE
END IF

li_rc			=	This.GetChild ('expression_one', ldwc_exp_one)

ll_rowcount	=	ldwc_exp_one.RowCount()

ls_find		=	"Upper(col_desc) = '"	+	Upper(as_data)	+	"'"

ll_find_row =	ldwc_exp_one.Find (ls_find, 1, ll_rowcount)

if ll_find_row >	0	then
	Return	TRUE
else
	Return	FALSE
end if

					

end event

event ue_remove_exp2_column(string as_column);///////////////////////////////////////////////////////////////////////
//	Script:		dw_criteria.ue_remove_exp2_column
//
//	Arguments:	as_column - Column name to remove from the expression_two DDDW
//
//	Returns:		None
//
//	Description:
//		This event will take the column name passed and remove it from the
//		expression-two DDDW.  This will prevent the query from comparing a 
//		column against itself.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	11/08/01	Stars 5.0.	Created.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
///////////////////////////////////////////////////////////////////////

DataWindowChild	ldwc_exp_two

String	ls_find,				&
			ls_tbl_type,		&
			ls_colname

Long		ll_findrow,			&
			ll_rowcount
			
Integer	li_rc,				&
			li_upper,			&
			li_idx

li_rc			=	This.GetChild ('expression_two', ldwc_exp_two)

ll_rowcount	=	ldwc_exp_two.RowCount()

ls_find		=	"Upper(col_name) = '"	+	Upper(as_column)	+	"'"

ll_findrow	=	ldwc_exp_two.Find (ls_find, 1, ll_rowcount)

IF	ll_findrow	>	0		THEN
	li_rc		=	ldwc_exp_two.RowsMove (ll_findrow, ll_findrow, Primary!, ldwc_exp_two, 1, Filter!)
END IF

IF	Mid (as_column, 4)	=	'SUPER PROVIDER'	THEN
	// Super Provider - Get all selected columns associated with Super Provider
	//	and remove them from the DDDW
	li_upper		=	UpperBound (istr_prov_query.prov_fields)
	FOR	li_idx	=	1	TO	li_upper
		IF	istr_prov_query.prov_fields[li_idx].selected	=	TRUE	THEN
			ls_tbl_type		=	istr_prov_query.prov_fields[li_idx].table_type
			ls_colname		=	istr_prov_query.prov_fields[li_idx].prov_col_name
			ls_find			=	"Upper(col_name) = '"	+	Upper(ls_tbl_type + '.' + ls_colname)	+	"'"
			ll_findrow		=	ldwc_exp_two.Find (ls_find, 1, ll_rowcount)
			IF	ll_findrow	>	0		THEN
				li_rc			=	ldwc_exp_two.RowsMove (ll_findrow, ll_findrow, Primary!, ldwc_exp_two, 1, Filter!)
			END IF
		END IF
	NEXT
END IF

IF	Mid (as_column, 4)	=	'SUPER NPI PROVIDER'	THEN
	// Super NPI Provider - Get all selected columns associated
	//	with Super NPI Provider	and remove them from the DDDW
	li_upper		=	UpperBound (istr_npi_prov_query.prov_fields)
	FOR	li_idx	=	1	TO	li_upper
		IF	istr_npi_prov_query.prov_fields[li_idx].selected	=	TRUE	THEN
			ls_tbl_type		=	istr_npi_prov_query.prov_fields[li_idx].table_type
			ls_colname		=	istr_npi_prov_query.prov_fields[li_idx].prov_col_name
			ls_find			=	"Upper(col_name) = '"	+	Upper(ls_tbl_type + '.' + ls_colname)	+	"'"
			ll_findrow		=	ldwc_exp_two.Find (ls_find, 1, ll_rowcount)
			IF	ll_findrow	>	0		THEN
				li_rc			=	ldwc_exp_two.RowsMove (ll_findrow, ll_findrow, Primary!, ldwc_exp_two, 1, Filter!)
			END IF
		END IF
	NEXT
END IF

end event

event ue_load_exp2_dddw();///////////////////////////////////////////////////////////////////////
//	Script:		dw_criteria.ue_load_exp2_dddw
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This event will copy the entries from the expression_one DDDW
//		into the expression-two DDDW.  It will also remove the Super 
//		Provider entry from the expression_two DDDW.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	11/08/01	Stars 5.0.	Created.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
///////////////////////////////////////////////////////////////////////

DataWindowChild	ldwc_exp_one,			&
						ldwc_exp_two

String	ls_find,				&
			ls_col_name

Long		ll_findrow,			&
			ll_rowcount,		&
			ll_row
			
Integer	li_rc

li_rc			=	This.GetChild ('expression_one', ldwc_exp_one)
li_rc			=	This.GetChild ('expression_two', ldwc_exp_two)

// Clear out any previously created DDDW entries
ldwc_exp_two.Reset()

ll_rowcount	=	ldwc_exp_one.RowCount()

// Copy the data
li_rc		=	ldwc_exp_one.RowsCopy (1, ll_rowcount, Primary!, ldwc_exp_two, 1, Primary!)

// Remove the Super Provider and Super NPI Provider
//	entries from the expression_two DDDW
FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name	=	ldwc_exp_two.GetItemString (ll_row, 'col_name')
	IF	Mid (ls_col_name, 4)	=	'SUPER PROVIDER' &
	OR Mid (ls_col_name, 4)	=	'SUPER NPI PROVIDER' THEN
		// Remove the corresponding row in ldwc_exp_two
		li_rc		=	ldwc_exp_two.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row	--
		ll_rowcount	--
		Exit
	END IF
NEXT
end event

event type string ue_get_exp1_datatype(string as_column);///////////////////////////////////////////////////////////////////////
//	Script:		dw_criteria.ue_get_exp1_datatype
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This event will get the data type from the expression_one DDDW.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	11/08/01	Stars 5.0.	Created.
//
///////////////////////////////////////////////////////////////////////

DataWindowChild	ldwc_exp_one

String	ls_find,				&
			ls_col_name,		&
			ls_datatype

Long		ll_findrow,			&
			ll_rowcount,		&
			ll_row
			
Integer	li_rc

li_rc			=	This.GetChild ('expression_one', ldwc_exp_one)

ll_rowcount	=	ldwc_exp_one.RowCount()

ls_find		=	"Upper(col_name) = '"	+	Upper(as_column)	+	"'"

ll_findrow	=	ldwc_exp_one.Find (ls_find, 1, ll_rowcount)

IF	ll_findrow	>	0		THEN
	ls_datatype	=	ldwc_exp_one.GetItemString (ll_findrow, "elem_data_type")
	Return	ls_datatype
ELSE
	Return	""
END IF



end event

event ue_set_exp2colname(long al_row);///////////////////////////////////////////////////////////////////////
//	Script:		dw_criteria.ue_set_exp2colname
//
//	Arguments:	al_row.  If 0, get all rows
//
//	Returns:		None
//
//	Description:
//		This event will determine if expression_two is a column (instead of
//		a value.  If so, it will set column exp2colname.
//
//	Note:	If expression_two is a column, it's value will be the column
//			name even though it displays the column description.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	11/08/01	Stars 5.0.	Created.
//
///////////////////////////////////////////////////////////////////////

DataWindowChild	ldwc_exp_one

String	ls_find,					&
			ls_col_name,			&
			ls_datatype,			&
			ls_exp2

Long		ll_findrow,				&
			ll_critrowcount,		&
			ll_rowcount,			&
			ll_row,					&
			ll_beginrow
			
Integer	li_rc

Boolean	lb_is_column

IF	al_row	=	0		THEN
	ll_critrowcount	=	This.RowCount()
	ll_beginrow			=	1
ELSE
	ll_critrowcount	=	al_row
	ll_beginrow			=	al_row
END IF

li_rc	=	This.GetChild ('expression_one', ldwc_exp_one)

ll_rowcount	=	ldwc_exp_one.RowCount()

FOR	ll_row	=	ll_beginrow	TO	ll_critrowcount
	This.object.exp2colname [ll_row]	=	""
	ls_exp2		=	This.object.expression_two [ll_row]
	lb_is_column	=	This.Event	ue_is_exp2_column (ls_exp2)
	IF	lb_is_column	=	TRUE	THEN
		ls_find		=	"Upper(col_desc) = '"	+	Upper(ls_exp2)	+	"'"
		ll_findrow	=	ldwc_exp_one.Find (ls_find, 1, ll_rowcount)
		IF	ll_findrow	>	0		THEN
			// Get column name from DDDW
			ls_col_name	=	ldwc_exp_one.GetItemString (ll_findrow, 'col_name')
			This.object.exp2colname [ll_row]	=	ls_col_name
		END IF
	END IF
NEXT




end event

event itemchanged;////////////////////////////////////////////////////////////////////////
//	Script:	ItemChanged Event
//
//	Description:
//	Must set lookup field if column selected is 'expression_one'.  
//	(See code in stances.w_drilldown_parent.dw_1.lookup event)  
//	If a filter is used in expression_two and it is from a 
//	previous level, must not allow the user to create a report since 
//	the filter has not been created yet.  In the same resepect, 
//	it there are filters being used from pervious levels and they 
//	are removed from the criteria, then must allow a report 
//	to be created.   If 'logical_op' is set to AND or OR and it is 
//	the last row then must insert a row into dw_criteria.  
//	If column selected is 'expression_one' and the item is 'SuperPv' 
//	then must open Provider Choices window (this lookup is 
//	hardcoded to PV).  The Provider Choices window allows the user 
//	to select the provider fields to use in the query and loads the 
//	structure passed in.  This new code may not need all info loaded 
//	into the structure, but to save from changing any code in the window, 
//	will not change the structure.  Also if Super Provider Query must 
//	set right mouse menu.  If Super Provider Query had been previously 
//	selected (ib_super_provider_query) must reset right mouse menus.
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created
//	FDG	02/11/98	If And/or is entered, see if the column is supposed
//						to be protected.  If so, and you're not in the last
//						row, do not allow the change.
//	FDG	03/04/98	Track 830.  When dates are filled in from the period
//						for a new query, the row will have protect_row_sw
//						= 'Y'.  If the user changes data in this row, then
//						set the period to 'NONE'.  Also, remove any edits
//						associated with the protect_row_sw.
//	FDG	03/05/98	Track 908.  Fix track 830 (3/4/98).  Set period = 'NONE'
//						only when expression_one or expression_two changes.
//	FDG	03/09/98	Track 920.  When SuperPv is selected, move 'PV' to
//						column lookup so the user can right-click on
//						expression_two to do a lookup.  Also, scan the d/w
//						instead of checking ib_super_provider_query to 
//						determine if SuperPv was already selected.
//						When an error occurs here, reset the text back to
//						its original value.
//	FDG	04/06/98	Track 1039.  Edit logical_op when it is set to none.
//						This can only be set to NONE to the last row.  If it's
//						set to the 2nd to last row, the last row will be 
//						deleted.
//	FDG	05/04/98	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'
//	FNC	05/20/98 Track 1107. Check if filter exists in either UO_Query.UE_Count
//						or U_NVO_View.UE_Tabpage_View_Create_Report.
//	FDG	08/19/98	Track 1560.  Call a function to reset the period to
//						'NONE'
//	FDG	09/11/98	Track 1687.  When the data source changes, reset the super
//						provider data that was previously set.  This was previously
//						done, but will now done thru a function.
//	FDG	10/14/98	Track 1831.  Change how you determine if expression_one
//						was changed from 'SUPER PROVIDER' to non-provider.
//	NLG	11/19/99	If expression_one or expression_two changes, set 
//						payment date listbox to empty
//	NLG	10/16/01	Stars 5.0.	Col to col comparison changes
// LahuS 01/25/02 Track 2552d Populate c_elem_Data_type column in dw
//	GaryR	09/25/02	Track 2893d	Text sensitive search in DropDowns
//	GaryR	12/30/03	Track	3525d	Allow focus to change even if criteria is invalid
//	HYL	01/05/06 TRACK 4492d	Display the warning message when different value
//										(ie, provider id) with leading spaces is entered.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//  10/8/09 RickB LKP.650.5678.005 Commented (for now, pending design review) that only 
//					cleared values when field selection changed if the value was a column.  The 
//					values should be cleared every time field selection changes 
//					whether they are a column or not.
////////////////////////////////////////////////////////////////////////

integer	li_return,				&
			i, li_rc, li_pos

long		ll_row,					&
			ll_count,				&
			ll_rowcount,			&
			ll_find_row

string	ls_data,					&
			ls_protect,				&
			ls_column,				&
			ls_logical_op,			&
			ls_expression_one,	&
			ls_expression_two,	&
			ls_find, 				&
			ls_colName,				&
			ls_desc, 				&
			ls_filter,				&
			ls_datatype

Boolean	lb_exp2_is_column			

uo_query	luo_query

datawindowchild ldwc_exp_two, ldwc_exp_one

w_query_engine	lw_parent

li_return	=	This.of_getparentwindow(lw_parent)

luo_query	=	This.of_getuoquery()

//	FDG 03/04/98 Begin
ls_column	=	This.GetColumnName()
ls_protect	=	this.GetItemString(row, 'protect_row_sw')
//	FDG 03/04/98 end
ll_rowcount	=	This.RowCount()

choose case ls_column

	case 'expression_one'
		//	GaryR	09/25/02	SPR 2893d - Begin
		IF IsNull( data) OR Trim( data ) = "" THEN
			This.SetText( "" )
			This.SetFocus()
			Return 0
		END IF
		
		ls_find = "Trim( col_name ) = '" + Trim( data ) + "'"
		This.GetChild( "expression_one", ldwc_exp_one )
		ll_find_row = ldwc_exp_one.Find( ls_find, 0, ldwc_exp_one.RowCount() )
		IF ll_find_row < 1 THEN
			MessageBox( "Error", "Selected column (" + data + ") not in the list." + &
										"~n~rPlease select a valid column from the list." )
			Return 2
		END IF
		//	GaryR	09/25/02	SPR 2893d - End
		
		//	FDG 03/04/98 Begin
		IF	Upper(ls_protect)	=	'Y'		THEN
			luo_query.of_date_change()				// FDG 08/19/98
			luo_query.of_set_run_frequency(0)		//NLG 11-19-99
			luo_query.event ue_reset_payment_date_opt()	//NLG 11-19-99
		END IF
		//	FDG 03/04/98 End
		ls_data	=	This.object.expression_one [row]		// FDG 10/14/98
		if mid(data,4) = 'SUPER PROVIDER' then
			//	FDG 03/09/98 begin
			// See if SuperPv was already selected.
			FOR ll_row	=	1 TO	ll_rowcount
				ls_expression_one	=	This.object.expression_one [ll_row]
				IF	Mid (ls_expression_one, 4)	=	'SUPER PROVIDER'	&
				AND ll_row	<>	row									THEN
					MessageBox('Error','Already selected one Super Provider column for this query.')
					This.SetText(ls_expression_one)							// FDG 03/09/98
					Return 2		// set back to expression_one 
				END IF
			NEXT
			
			This.object.lookup [row]	=	'PV'	// Allow for provider lookup
			// FDG 03/09/98 end
		
			lw_parent.Post Event ue_set_menus_super_provider_query(FALSE)
			
			// get prov fields but only if user selects field, 
			// expression_two DDDW processing is performed here
			luo_query.Post	event ue_tabpage_search_get_prov_choices( FALSE )
		elseif mid(data,4) = 'SUPER NPI PROVIDER' then
			// See if SuperPv was already selected.
			FOR ll_row	=	1 TO	ll_rowcount
				ls_expression_one	=	This.object.expression_one [ll_row]
				IF	Mid (ls_expression_one, 4)	=	'SUPER NPI PROVIDER'	&
				AND ll_row	<>	row									THEN
					MessageBox('Error','Already selected one Super NPI Provider column for this query.')
					This.SetText(ls_expression_one)							// FDG 03/09/98
					Return 2		// set back to expression_one 
				END IF
			NEXT
			
			This.object.lookup [row]	=	'NPI'	// Allow for NPI provider lookup
			lw_parent.Post Event ue_set_menus_super_provider_query(FALSE)
			
			// get prov fields but only if user selects field, 
			// expression_two DDDW processing is performed here
			luo_query.Post	event ue_tabpage_search_get_prov_choices( TRUE )
		else
			// reset menus if have been changed by Super Provider Query
			// FDG 10/14/98 - Check old value for super provider
			IF	Mid (ls_data,4) = 'SUPER PROVIDER'		THEN
				li_return	=	luo_query.of_reset_super_provider( 1 )
			end if
			
			// reset menus if have been changed by Super NPI Provider Query
			IF	Mid (ls_data,4) = 'SUPER NPI PROVIDER'		THEN
				li_return	=	luo_query.of_reset_super_provider( 2 )
			end if
			
			//NLG 10-16-01
			//	expression_one has changed. 
			// If the column changed and a column was previously selected in expression_two,
			//	then reset it.
			
			// Expression_two should be cleared whenever expression_one is changed, regardless of
			// whether or not expression_two is a column.  Commenting for now.
			//ls_expression_two	=	This.object.expression_two [row]
			//lb_exp2_is_column	=	This.Event	ue_is_exp2_column (ls_expression_two)
			//IF	lb_exp2_is_column	=	TRUE		THEN
			
			// ** Moving the next two lines outside of this IF, so expression_two will clear
			// when expression_one changes to, from, or within SuperProvider options.
			//	This.object.expression_two [row]	=	""
			//	This.object.exp2colname [row]		=	""
			
			//END IF
			// Get the datatype for expression_one to filter the expression_two drop-down.
			this.event ue_filter_exp2 ("", data)
			this.event ue_set_lookup( row, data )
		end if
		
		//Lahu S 1/25/02 begin
		This.object.c_elem_data_type[row] = ldwc_exp_one.getitemstring(ldwc_exp_one.getselectedrow(0), "elem_data_type")
		This.object.relational_op[row] = ""	
		// Moved from above
		This.object.expression_two [row]	=	""
		This.object.exp2colname [row]		=	""
		//Lahu S 1/25/02 end
		
		// reset space_warned field to zero(0)
		This.Object.space_warned[row] = 0 // HYL 01/05/06 TRACK 4492d		
		
	case 'expression_two'
		// if a filter used must determine if it is a filter created 
		//	on a previous level - if it is must force down the subset path 
		//	FDG 03/04/98 Begin
		IF	Upper(ls_protect)	=	'Y'		THEN
			luo_query.of_date_change()				// FDG 08/19/98
			luo_query.of_set_run_frequency(0)		//NLG 11-19-99
			luo_query.event ue_reset_payment_date_opt()	//NLG 11-19-99
		END IF
		//	FDG 03/04/98 End
		
		//NLG 10-16-01   **start**
		//populate exp2ColName 
		this.object.exp2ColName[row] = ""
		This.Post	Event	ue_set_exp2colname (row)
		
		// reset space_warned field to zero(0)
		This.Object.space_warned[row] = 0	// HYL 01/05/06 TRACK 4492d	
			
	case 'logical_op'
		
		if row = ll_rowcount then 
			// Last row.  Add a new row.
			If data = 'AND' or data = 'OR' then
				luo_query.post event ue_tabpage_search_add_row()
			END IF
		else
			// Not the last row
			IF	data	=	'NONE'	OR	data	=	''		THEN
				// Data changed to 'NONE' or the empty string.  Determine
				//	if the this value can change and may have to delete
				//	the last row of criteria.
				ls_logical_op	=	This.object.logical_op [row]
				// This can only be changed to 'None' in the last row or
				//	the second to last row
				IF row	=	ll_rowcount - 1	THEN
					// The second to last row.  
					// See if there is valid criteria in the last row.
					ls_expression_one	=	this.object.expression_one [ll_rowcount]
					IF	Not IsNull (ls_expression_one)		&
					AND Trim (ls_expression_one)	>	' '	THEN
						// the last row of criteria has data.  Prompt the user about
						//	removing it.
						li_return	=	MessageBox ('Warning', 'The last line of criteria will ' + &
											'be automatically deleted.', Information!, OKCancel!)
						IF	li_return	=	2		THEN
							// Cancel out of setting this data
							This.SetText (ls_logical_op)
							Return 1
						END IF
					END IF
					// Remove the last row
					This.SetRow (ll_rowcount)
					luo_query.Post	Event	ue_tabpage_search_delete_row()
				ELSE
					// This row is not the last row or the 2nd to last row.  Under
					//	this condition logical_op cannot be changed to 'NONE'
					MessageBox ("Error", "This row of criteria cannot be set to 'NONE' " + &
									"without first removing the subsequent lines of criteria", &
									StopSign!)
					This.SetText (ls_logical_op)
					Return 1
				END IF		// IF row	=	ll_rowcount - 1
			END IF			// IF	data	=	'NONE' OR data	=	''
		END IF				// IF row = ll_rowcount
	CASE 'relational_op' // HYL 01/05/06 TRACK 4492d
		// reset space_warned field to zero(0)
		This.Object.space_warned[row] = 0
end choose
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	JohnW	??/??/??	The following code was taken from the
//						activate event of w_drilldown_parent.  
//						This code will cause the background color of
//						expression two to change if there is a lookup color.
//	GaryR	09/25/02	SPR 2893d	Text sensitive search in DropDowns
//
//////////////////////////////////////////////////////////////////////////////

//This.SetTransObject (Stars2ca)
this.of_SetUpdateable(FALSE)
This.of_SetDropDownSearch( TRUE )		//	GaryR	09/25/02	SPR 2893d

end event

event retrievestart;call super::retrievestart;//RetrieveStart Event
//This event is called when the datawindow is first retrieved.  
//Set return to 2 so that a retrieve will append to data already 
//loaded into the datawindow.

return 2

end event

event ue_updatespending;////////////////////////////////////////////////////////////////////////////
//	OVERRIDE!
//	Function:  	u_dw.ue_updatespending
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Determine if there are any pending updates on this d/w.
//						NOTE: this logic is only for the CloseQuery event
//
//////////////////////////////////////////////////////////////////////////////

// don't attempt a 'REAL UPDATE'
If Not(ib_FromCloseQuery) Then RETURN 0

//	Check for pending updates
IF	This.ModifiedCount()	+	This.DeletedCount()	>	0	THEN
	RETURN 1
END IF

//	There are no pending updates
RETURN 0
end event

event itemerror;call super::itemerror;// Override the ancestor to not display a message
Return 1
end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;//NLG 10-16-01		Stars 5.0.

if IsNull (currentrow)		&
or currentrow < 1				then 
	return
end if

// Get the datatype for the exp1 field to filter exp2
String ls_datatype,ls_colName
String ls_find, ls_data
int li_rc
long ll_find_row
datawindowchild ldwc_exp_one


ls_colName = this.object.expression_one[currentrow]
li_rc = this.getchild('expression_one',ldwc_exp_one)
ls_find = "col_name = '" + ls_colName + "'"
ll_find_row = ldwc_exp_one.find(ls_find,1,ldwc_exp_one.rowCount())
if ll_find_row < 1 then
	// Remove all entries from expression_two DDDW
	this.event ue_filter_exp2("", "")	
else
	ls_data = ldwc_exp_one.getItemString(ll_find_row,"col_name")
	ls_datatype = ldwc_exp_one.getItemString(ll_find_row,"elem_data_type")
	this.event ue_filter_exp2 (ls_datatype, ls_data)
end if

end event

event itemfocuschanged;call super::itemfocuschanged;//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

Long		ll_row
String	ls_text, ls_modify
Integer	li_pos
DataWindowChild	ldwc_exp_one

IF row < 1 OR Lower( dwo.name ) <> "expression_two" THEN Return

ls_text = Trim( This.GetItemString( row, "lookup" ) )
IF ls_text > "" THEN
	//	Set Accessibility Properties
	ls_text = This.GetItemString( row, "expression_one" )
	This.GetChild( "expression_one", ldwc_exp_one )
	ls_text = "col_name = '" + ls_text + "'"
	ll_row = ldwc_exp_one.Find( ls_text, 1, ldwc_exp_one.RowCount() )
	
	IF ll_row < 1 THEN
		ls_text = '"Lookup Field"~t"Lookup Field"'
	ELSE
		ls_text = ldwc_exp_one.GetItemString( ll_row, "elem_desc" )
		li_pos = Pos( ls_text , "/" )
		IF li_pos > 0 THEN ls_text = Left( ls_text, li_pos - 1 )
		ls_text = Trim( ls_text )
		
		ls_text = ldwc_exp_one.GetItemString( ll_row, "elem_tbl_type" ) + "." + ls_text
		ls_text = '"Lookup Field - ' + ls_text + '"~t"Lookup Field - ' + ls_text + '"'
	END IF
	
	ls_modify = "expression_two.Tag='LOOKUP'"
ELSE
	//	Reset Accessibility Properties
	ls_text = '"Value/Field"~t"Value/Field"'
	ls_modify = "expression_two.Tag=''"
END IF

ls_modify += " expression_two.AccessibleName='" + ls_text + "'"
ls_modify += " expression_two.AccessibleDescription='" + ls_text + "'"
This.Modify( ls_modify )
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

String 	ls_value
Integer	li_row
uo_query	luo_query

This.AcceptText()
li_row = This.GetRow()
IF li_row < 1 THEN Return
luo_query	=	This.of_getuoquery()

IF Lower( as_col ) = 'expression_two' THEN
	ls_value = dw_criteria.object.expression_two[li_row]
	IF Left( ls_value, 1 ) <> '@' THEN
		luo_query.Post	Event ue_tabpage_search_code_lookup( ls_value, li_row )
	END IF
END IF
end event

event ue_lookup_filter;call super::ue_lookup_filter;////////////////////////////////////////////////////////////////////////
//	Script:	ue_lookup_filter
//
//	Arguments:
//				as_col (String)
//
//	Returns:	None
//
//	Description:
//		This event is called by dw_criteria.rbuttondown when a filter id 
//		or marker (@) is in dw_criteria.expression_two.  If there are filters 
//		created in other levels will open to w_qe_filter_list to list all 
//		the filters created in this query 
//		(filter_id, filter_type, level number).  
//		Allow the user to select a filter and place it into expression_two.  
//		If no filters have been created, this will open the filter list 
//		window (w_filter_list) to allow the user to select a filter 
//		and place it into expression_two.  
//		(Use code from stances.w_drilldown_parent.cb_filter 
//		and stfilter.w_filter_list.cb_use - do not change this use code) 
//
////////////////////////////////////////////////////////////////////////
//	History:
//
//	???	????????	Created
//	FDG	02/12/98	Event ue_get_filter_info was passing the wrong # of
//						parms and it was being triggered on the wrong object.
//	FDG	03/12/98	Track 897.  To get the data type you must first find
//						the value in the 'expression_one' DDDW.
//	FDG	03/17/98	Track 941.  Open w_filter_list_response instead of
//						w_filter_list because this must be a response window.
// FDG	11/09/01 Stars 5.0. Set exp2colname based on whether or not expression_two 
//						contains a selected column instead of a value.
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
////////////////////////////////////////////////////////////////////////

String	ls_data_type,			&
			ls_expression_one,	&
			ls_find
Integer	li_rc
Long		ll_row, ll_curr_row
w_query_engine		lw_parent
sx_filter_info 	lstr_filter_info[] /* defined in ts144 - Filter Windows */

sx_all_filter_info lstr_all_filter_info /* defined in ts144 - Filter Windows */
datawindowchild ldwc_exp_one

IF Lower( as_col ) <> "expression_two" THEN Return

ll_curr_row = This.GetRow()

//	FDG 03/12/98 begin
ls_expression_one	=	This.object.expression_one [ll_curr_row]		// FDG 03/12/98
ls_find				=	"col_name = '"	+	ls_expression_one	+	"'"

IF	IsNull (ls_expression_one)				&
OR	Trim (ls_expression_one)	<	'  '	THEN
	MessageBox ('Error', 'Cannot perform a filter lookup without first selecting a field')
	Return
END IF

This.getchild('expression_one',ldwc_exp_one)
ll_row	=	ldwc_exp_one.Find ( ls_find, 1, ldwc_exp_one.RowCount() )

IF	ll_row <	1	THEN
	MessageBox ('Application Error', 'Cannot find the expression one value in ' + &
					'dw_criteria.ue_lookup_filter.  Find expression = ' + &
					ls_find + '.')
	Return
END IF

ls_data_type = ldwc_exp_one.getitemstring(ll_row,'elem_data_type')
// FDG 03/12/98 end

/* get previously saved filters (if there are any) */
li_rc	=	This.of_getparentwindow ( lw_parent )
li_rc	=	lw_parent.Event ue_get_filter_info('', lstr_filter_info)	//	FDG 02/12/98

if upperbound(lstr_filter_info) > 0 then /* have filters */
	lstr_all_filter_info.filters = lstr_filter_info
	lstr_all_filter_info.data_type[1] = ls_data_type
	openwithparm(w_qe_filter_list,lstr_all_filter_info)
else
	// Open filter list with data_type, filter list puts selected
	// filter into gv_active_filter, so set this into expression field.  
	//	Set window parm to NULL 
	sx_filter_data lstr_filter_data  /* stfilter.pbl */
	SetNull(lstr_filter_data.sx_window)
	lstr_filter_data.sx_entry_mode = 'USE'
	lstr_filter_data.sx_col_name=ls_data_type
	SetNull(lstr_filter_data.sx_button)
	OpenWithParm (w_filter_list_response, lstr_filter_data)		// FDG 03/17/98
end if

IF gv_active_filter <> '' THEN
	This.object.expression_two [ll_curr_row] = '@' + gv_active_filter
	This.Event	ue_set_exp2colname (ll_curr_row)		// FDG 11/09/01
END IF
end event

event ue_dblclick;call super::ue_dblclick;////////////////////////////////////////////////////////////////////////////
//
//	DoubleClicked User Event
//	If the column clicked on is 'expression_two' then insert the 
//	active filter into the field or if filter(s) are 'created' in 
//	previous level, then insert last filter created.
//
////////////////////////////////////////////////////////////////////////////
//
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
////////////////////////////////////////////////////////////////////////////

String	ls_col, ls_filter_id
Integer	li_row, li_filter_count
w_query_engine	lw_parent
sx_all_filter_info	lstr_all_filter_info	// Passed to w_qe_filter_list
sx_filter_info			lstr_filter_info[]

li_row = This.GetRow()
ls_col = This.GetColumnName()
	
IF li_row < 1 OR Lower( ls_col ) <> "expression_two" THEN Return

This.of_getparentwindow ( lw_parent )
lw_parent.Event	ue_get_filter_info ('', lstr_filter_info)

li_filter_count	=	Upperbound (lstr_filter_info)		// Get # of filters
IF li_filter_count > 0	THEN
	// Have filters - place the last filter into expression_two
	lstr_all_filter_info.filters	=	lstr_filter_info
	This.object.expression_two [li_row]	=	&
	'@'	+	lstr_filter_info [li_filter_count].filter_id
ELSE
	//	Filters cleared out - get the active filter (if any)
	IF gv_active_filter <> '' THEN
		This.object.expression_two [li_row] = '@' + gv_active_filter
	ELSE
		MessageBox('Error','No active filter has been set.')
	End If
End If
end event

event ue_lookup_cell;call super::ue_lookup_cell;//*********************************************************************************
// Script Name:	ue_lookup_cell
//
// Arguments:	String	as_col
//					Long		al_row
//
// Returns:		None
//
// Description:	Execute cell & header lookup functionality in this event
//						This event is triggered either via right click or F2 key.
//
//*********************************************************************************
//
//	05/19/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

String	ls_value
Integer	li_pos
	
IF Lower( as_col ) = 'expression_one' THEN
	ls_value = This.object.expression_one[al_row]
	IF Trim( ls_value ) <> "" THEN
		IF Trim( This.GetItemString( al_row, "pdr_protect" ) ) <> "A" THEN
			gv_element_table_type = Left( ls_value, 2 )
			li_pos = Len( ls_value ) - 3
			gv_element_name = Right( ls_value, li_pos )
			Open( w_dwlabel_definition )
		END IF
	END IF
END IF
end event

type cb_close_search from u_cb within tabpage_search
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2930
integer y = 1764
integer width = 261
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;Integer		li_rc

w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)


Close (lw_parent)

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_next_search from u_cb within tabpage_search
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2592
integer y = 1764
integer width = 261
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Next"
end type

event clicked;call super::clicked;This.of_getuoquery().Event	ue_next_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type st_count_search from statictext within tabpage_search
string accessiblename = "Records Count"
string accessibledescription = "Records Count"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 1764
integer width = 274
integer height = 92
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_count_view_search from statictext within tabpage_search
boolean visible = false
string accessiblename = "Records Count"
string accessibledescription = "Records Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1367
integer y = 1764
integer width = 274
integer height = 92
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_prev_search from u_cb within tabpage_search
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 2254
integer y = 1764
integer width = 261
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Prev"
end type

event clicked;This.of_getuoquery().Event	ue_prev_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type pb_notes_search from u_pb within tabpage_search
boolean visible = false
string accessiblename = "Notes"
string accessibledescription = "Notes"
integer x = 384
integer y = 1752
integer width = 123
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = fixed!
string facename = "System"
string picturename = "script1.bmp"
end type

event clicked;This.of_getuoquery().Event	ue_notes()
end event

type ddlb_pdr_opt from u_ddlb within tabpage_search
boolean visible = false
string accessiblename = "Date Range Options"
string accessibledescription = "Date Range Options"
integer x = 1728
integer y = 160
integer width = 1038
integer height = 268
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean sorted = false
string item[] = {"1. Month to date","2. Calendar Year to Date","3. Fiscal Year to Date","4. Last Month","5. Last Calendar Quarter","6. Q1 - Calendar","7. O2 - Calendar","8. Q3 - Calendar","9. Q4 - Calendar","10. Last Calendar Year","11. Last Fiscal Year"}
end type

event selectionchanged;call super::selectionchanged;/////////////////////////////////////////////////////////////////
//	Description:
//	Compute date column in Criteria dw based upon the selection 
// in date range ddlb.  
//
//	Lahu S.	1-23-02		Track 2552d Created.  
//
/////////////////////////////////////////////////////////////////

long		ll_rowcount, ll_row
string 	ls_column, ls_date


//compute date range
//ls_date=This.Event dynamic ue_compute_date (ls_date)

// Find the date column in the criteria dw and change the 
//operator and expression_two value.
ll_rowcount  =  dw_criteria.RowCount()
FOR  ll_row  =  1  TO  ll_rowcount
	ls_column  =  TRIM(dw_criteria.object.c_elem_data_type[ll_row])
	IF  ls_column  =  'DATE'  THEN
		dw_criteria.object.expression_two [ll_row] = ls_date
		dw_criteria.object.relational_op [ll_row] = "BETWEEN"
		dw_criteria.object.protect_row_sw [ll_row] = "Y"
		dw_criteria.SetItemStatus(ll_row,0,Primary!,NotModified!)
	END IF
NEXT

end event

type gb_available_claims from groupbox within tabpage_search
string accessiblename = "No common claims range"
string accessibledescription = "No common claims range"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer y = 20
integer width = 3163
integer height = 280
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "No common claims range"
end type

type uo_tabpage_search from uo_tabpage_qe within tabpage_search
event destroy ( )
string accessiblename = "Search"
string accessibledescription = "Search"
integer x = 18
integer y = 24
integer width = 3163
integer height = 1696
end type

on uo_tabpage_search.destroy
call uo_tabpage_qe::destroy
end on

type uo_period from u_display_period within tabpage_search
string accessiblename = "Claims Period"
string accessibledescription = "Claims Period"
integer x = 46
integer y = 160
integer width = 1257
integer height = 108
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//ItemChanged Event
//When the user selects a period, the payment and 
//from date must be loaded into the criteria datawindow.  
//But only if dates have not already been set.
////////////////////////////////////////////////////////////////////////
// History
//
//	FDG	03/04/98	Track 830.  Don't change the dates if this event was triggered from
//						dw_criteria's itemchanged event or the tab's selectionchanged
//						event.
//
//	NLG	11-08-99	ts2463c Fraud PDQ. When the period changes, 
//						empty the payment date options ddlb.
///////////////////////////////////////////////////////////////////////

uo_query		luo_query

luo_query	=	cb_next_search.of_getuoquery()


IF Not ib_criteria_date_change	THEN
	luo_query.event ue_tabpage_search_set_dates()
	luo_query.event ue_reset_payment_date_opt()	//NLG 11-08-99
END IF



end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF

	END IF
END IF

end event

type st_period from statictext within tabpage_search
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = statictextrole!
integer x = 46
integer y = 92
integer width = 247
integer height = 60
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
string text = "Period:"
boolean focusrectangle = false
end type

type st_payment_date_options from statictext within tabpage_search
string accessiblename = "Payment Date Options"
string accessibledescription = "Payment Date Options"
accessiblerole accessiblerole = statictextrole!
integer x = 1728
integer y = 92
integer width = 686
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Payment Date Options:"
boolean focusrectangle = false
end type

type ddlb_pd_opt from u_ddlb within tabpage_search
string accessiblename = "Date Range Options"
string accessibledescription = "Date Range Options"
integer x = 1733
integer y = 160
integer width = 1289
integer height = 536
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "                                                                        "
boolean sorted = false
string item[] = {"M - Future Monthly Subset","Q - Future Quarterly Subset","S - Future Semi-Annual Subset","A - Future Annual Subset","1 - Query Most Recent Month","2 - Query Most Recent 2 Months","3 - Query Most Recent 3 Months","4 - Query Most Recent 4 Months","5 - Query Most Recent 5 Months","6 - Query Most Recent 6 Months","7 - Query Most Recent 7 Months","8 - Query Most Recent 8 Months","9 - Query Most Recent 9 Months","10 - Query Most Recent 10 Months","11 - Query Most Recent 11 Months","12 - Query Most Recent 12 Months"}
end type

event selectionchanged;//	uo_query.ddlb_pd_opt.selectionchanged()
//
//	Description:
//	When the selection changes, the payment date may need to be 
//	recomputed based upon the selection.  Also, the period needs
//	to be reset to 'NONE' 
//
//	NLG	10-27-99	Created.  ts2364c.
//	NLG	12-13-99	Set run_frequency in w_query_engine 
// FNC	02/10/00 Display different microhelp if user selected recurring pdq.
/////////////////////////////////////////////////////////////////


integer li_rc
string ls_frequency
uo_query	luo_query
w_query_engine lw_parent//12-13-99

luo_query = this.of_getuoquery()

luo_query.event ue_set_payment_date()

//reset the period to NONE
li_rc = luo_query.of_date_change()

//NLG 12-13-99 Set w_query_engine.ii_run_frequency						*START*
//u_nvo_search.ue_set_payment_date sets ii_run_frequency for uo_query.
integer li_index
li_index = this.finditem('M - Future Monthly Subset',0)
IF  li_index > 0 THEN
	li_rc	=	This.of_getparentwindow(lw_parent)
	lw_parent.wf_set_ii_run_frequency(ii_run_frequency)
END IF
//NLG 12-13-99 *STOP*

// FNC 02/10/00 Start

ls_frequency = trim(Left (this.text, 2))

CHOOSE CASE ls_frequency
	CASE 'M','Q','S','A'
		w_main.SetMicroHelp('This selection requires PDQ to be saved as a subset')
	CASE ELSE
		w_main.SetMicroHelp('Ready')
END CHOOSE

// FNC 02/10/00 End

lw_parent = of_getwindow()
lw_parent.event ue_determine_pd_opt_visibility()
end event

type tabpage_report from userobject within uo_query
event ue_post_construct ( )
string accessiblename = "Customize Report Tab"
string accessibledescription = "The Customize Report tab formats the display of the data on the final report."
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 3209
integer height = 1912
boolean enabled = false
long backcolor = 67108864
string text = "Customize Report"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_fastquery gb_fastquery
dw_pipeline dw_pipeline
st_available_count st_available_count
st_title st_title
dw_available dw_available
st_selected st_selected
dw_selected dw_selected
cb_add cb_add
cb_remove cb_remove
cb_up cb_up
cb_down cb_down
cb_close_report cb_close_report
cb_next_report cb_next_report
st_count_report st_count_report
cb_prev_report cb_prev_report
st_available st_available
uo_report_options uo_report_options
uo_tabpage_report uo_tabpage_report
mle_title mle_title
dw_fastquery dw_fastquery
end type

event ue_post_construct();/////////////////////////////////////////////////////////////////
//
// Lahu S Track 2552d Created
//	10/02/03	GaryR	Hide the counter in PDR mode
//	12/22/03	GaryR	Track 3667d	Add option to remove header from PDRs
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////

//	Hide PDQ options and enable PDR options
if is_query_engine_mode = "PDCR" or is_query_engine_mode = "PDR" then 
	st_available.visible = false
	st_selected.visible = false
	dw_available.visible = false
	dw_selected.visible = false
	cb_add.visible = false
	cb_remove.visible = false
	cb_up.visible = false
	cb_down.visible = false
	st_count_report.visible = FALSE
	mle_title.visible = FALSE
	st_title.visible = FALSE
	
	uo_report_options.visible = TRUE
	uo_report_options.bringtotop = TRUE
end if
end event

on tabpage_report.create
this.gb_fastquery=create gb_fastquery
this.dw_pipeline=create dw_pipeline
this.st_available_count=create st_available_count
this.st_title=create st_title
this.dw_available=create dw_available
this.st_selected=create st_selected
this.dw_selected=create dw_selected
this.cb_add=create cb_add
this.cb_remove=create cb_remove
this.cb_up=create cb_up
this.cb_down=create cb_down
this.cb_close_report=create cb_close_report
this.cb_next_report=create cb_next_report
this.st_count_report=create st_count_report
this.cb_prev_report=create cb_prev_report
this.st_available=create st_available
this.uo_report_options=create uo_report_options
this.uo_tabpage_report=create uo_tabpage_report
this.mle_title=create mle_title
this.dw_fastquery=create dw_fastquery
this.Control[]={this.gb_fastquery,&
this.dw_pipeline,&
this.st_available_count,&
this.st_title,&
this.dw_available,&
this.st_selected,&
this.dw_selected,&
this.cb_add,&
this.cb_remove,&
this.cb_up,&
this.cb_down,&
this.cb_close_report,&
this.cb_next_report,&
this.st_count_report,&
this.cb_prev_report,&
this.st_available,&
this.uo_report_options,&
this.uo_tabpage_report,&
this.mle_title,&
this.dw_fastquery}
end on

on tabpage_report.destroy
destroy(this.gb_fastquery)
destroy(this.dw_pipeline)
destroy(this.st_available_count)
destroy(this.st_title)
destroy(this.dw_available)
destroy(this.st_selected)
destroy(this.dw_selected)
destroy(this.cb_add)
destroy(this.cb_remove)
destroy(this.cb_up)
destroy(this.cb_down)
destroy(this.cb_close_report)
destroy(this.cb_next_report)
destroy(this.st_count_report)
destroy(this.cb_prev_report)
destroy(this.st_available)
destroy(this.uo_report_options)
destroy(this.uo_tabpage_report)
destroy(this.mle_title)
destroy(this.dw_fastquery)
end on

event constructor;/////////////////////////////////////////////////////////////////
//
// LahuS Track 2552d Created
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////


// hide available fields and selected fields
This.Post Event ue_post_construct()

end event

type gb_fastquery from groupbox within tabpage_report
string accessiblename = "Fast Query Options"
string accessibledescription = "Fast Query Options"
accessiblerole accessiblerole = groupingrole!
integer x = 2345
integer y = 64
integer width = 837
integer height = 304
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Fast Query Options"
end type

type dw_pipeline from u_dw within tabpage_report
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 1888
integer y = 1736
integer width = 183
integer height = 124
integer taborder = 0
end type

type st_available_count from statictext within tabpage_report
string accessiblename = "Available Fields Count"
string accessibledescription = "Available Fields Count"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 1660
integer width = 635
integer height = 76
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
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_title from statictext within tabpage_report
string accessiblename = "Report Title"
string accessibledescription = "Report Title"
accessiblerole accessiblerole = statictextrole!
integer x = 59
integer y = 20
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Report Title:"
boolean focusrectangle = false
end type

type dw_available from u_dw within tabpage_report
event type integer ue_make_common ( integer ai_num_inv )
event ue_mousemove pbm_mousemove
string accessiblename = "Available Fields"
string accessibledescription = "Available Fields"
integer x = 55
integer y = 456
integer width = 1335
integer height = 1200
integer taborder = 40
string dragicon = "ROWS.ICO"
string dataobject = "d_selected"
boolean vscrollbar = true
end type

event type integer ue_make_common(integer ai_num_inv);///////////////////////////////////////////////////////////////////////
//	Script:	UO_Query.Tabpage_Report.DW_Available.UE_Make_Common 
//
//	Arguments:	Integer  AI_Num_Inv 
//
//	Returns:		None
//
//	Description:
// 
//	This event is called from ue_tabpage_report_set_columns() to make 
//	duplicate fields common.  When there are duplicate columns 
//	must determine if there is a duplicate for each invoice type 
//	in the subset.  If there is this is a common column.  
//	Must delete all the dups, except one.  Revise that one row 
//	to have invoice type of MC.
///////////////////////////////////////////////////////////////////////
//	History:
//
//	11/??/98	???	Created

// 03/31/98 FNC	Track 912. Rework looping because columns are prefixed by
//						invoice type. Accordlingly, columns are sorted by column name
//						within invoice type so must compare all columns agains each 
//						other rather than just comparing one column with the next one.
//	04/07/04	GaryR	Track 4000d	Delete the row via find not hardcoded row number
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
///////////////////////////////////////////////////////////////////////

long ll_rowcount
string 	ls_hold_elem_name,			&
			ls_hold_elem_tbl_type
			
integer 	li_count,			&
			li_main,				&
			li_compare,			&
			li_save_rows[],	&
			li_clear_array[],	&
			li_row,				&
			li_equal_rows
boolean	lb_mc_match

ll_rowcount = this.rowcount()
/*select each column in dw_available */
for li_main = 1 to ll_rowcount
	ls_hold_elem_tbl_type = this.object.elem_tbl_type[li_main]
	ls_hold_elem_name = this.object.elem_name[li_main]
	/*compare against each row in dw_available */
	li_count = 1
	li_save_rows = li_clear_array
	li_save_rows[1] = li_main
	lb_mc_match = false
	for li_compare = 1 to ll_rowcount
		/*if same tbl type don't compare */
		if ls_hold_elem_tbl_type <> this.object.elem_tbl_type[li_compare] then 
			if ls_hold_elem_name = this.object.elem_name[li_compare] then
				li_count++
				li_save_rows[li_count] = li_compare
				/* if column matches an MC column then it is a common column too */
				if ls_hold_elem_tbl_type = 'MC' or &
					this.object.elem_tbl_type[li_compare] = 'MC' then
						lb_mc_match = TRUE
				end if
			end if
		end if
	next
	if li_count = ai_num_inv or lb_mc_match then /* have a common field */
			li_row = li_save_rows[1]
			/*reset first field to MC */
			this.object.elem_tbl_type[li_row] = 'MC'
			
			/*delete all other rows*/
			li_row = This.Find( "elem_name = '" + ls_hold_elem_name + "'", &
												li_save_rows[1] + 1, ll_rowcount )
			DO WHILE li_row > 0				
				this.deleterow(li_row)
				ll_rowcount --
				li_row = This.Find( "elem_name = '" + ls_hold_elem_name + "'", &
												li_save_rows[1] + 1, ll_rowcount )
			LOOP
	end if
next

Return 1
end event

event ue_mousemove;call super::ue_mousemove;dragobject ldrg_control
If Message.WordParm = 1 Then
	If GetSelectedRow(this,0) > 0 Then
  		Drag(This, Begin!)
	End If
End IF
SetNull(message.wordparm)
end event

event constructor;call super::constructor;//Constructor Event
//Turn on multiselect and turn off update process 
//(when window closes automatically does a dwupdate).

This.SetTransObject(Stars2ca) 
this.of_multiselect(TRUE)
/* not sure, might have to do something here so can select ranges */
this.of_SetUpdateable(FALSE)
end event

event retrievestart;call super::retrievestart;//RetrieveStart Event
//This event is called when the datawindow is first retrieved.  
//Set return 2 so that a retrieve will append to data already 
//loaded into the datawindow.
//
return 2

end event

event dragdrop;call super::dragdrop;//DragDrop Event
//This event is called to drag selected rows from dw_selected 
//to drop in this datawindow.
//
This.of_getuoquery().event ue_tabpage_report_remove()

end event

event doubleclicked;call super::doubleclicked;//DoubleClicked Event
//This event is called when the selected row needs to be 
//moved to dw_selected

This.of_getuoquery().Event ue_tabpage_report_add()

end event

event rbuttonup;This.of_getuoquery().Event ue_open_menu()

Return 1


end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type st_selected from statictext within tabpage_report
string accessiblename = "Selected Fields"
string accessibledescription = "Selected Fields"
accessiblerole accessiblerole = statictextrole!
integer x = 1637
integer y = 376
integer width = 535
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Selected Fields"
boolean focusrectangle = false
end type

type dw_selected from u_dw within tabpage_report
event ue_mousemove pbm_mousemove
string accessiblename = "Selected"
string accessibledescription = "Selected"
integer x = 1637
integer y = 456
integer width = 1335
integer height = 1200
integer taborder = 50
string dragicon = "ROWS.ICO"
string dataobject = "d_selected"
boolean vscrollbar = true
end type

event ue_mousemove;call super::ue_mousemove;dragobject ldrg_control
If Message.WordParm = 1 Then
	If GetSelectedRow(this,0) > 0 Then
  		Drag(This, Begin!)
	End If
End IF
SetNull(message.wordparm)
end event

event constructor;call super::constructor;//Constructor Event
//Turn on multiselect and turn off update process 
//(when window closes automatically does a dwupdate).

this.of_SetUpdateable(FALSE)
this.of_multiselect(TRUE)
/* not sure, might have to do something here so can select ranges */

end event

event dragdrop;call super::dragdrop;//DragDrop Event 
//This event is called to drag selected rows from dw_available 
//to drop in this datawindow.
//
il_drop_row = row
This.of_getuoquery().Event ue_tabpage_report_add()

end event

event doubleclicked;call super::doubleclicked;//DoubleClicked Event
//This event is called when the selected row needs to be moved 
//to dw_available

This.of_getuoquery().Event ue_tabpage_report_remove()

end event

event ue_updatespending;////////////////////////////////////////////////////////////////////////////
//	OVERRIDE!
//	Function:  	u_dw.ue_updatespending
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Determine if there are any pending updates on this d/w.
//						NOTE: this logic is only for the CloseQuery event
//
//////////////////////////////////////////////////////////////////////////////

// don't attempt a 'REAL UPDATE'
If Not(ib_FromCloseQuery) Then RETURN 0

//	Check for pending updates
IF	This.ModifiedCount()	+	This.DeletedCount()	>	0	THEN
	RETURN 1
END IF

//	There are no pending updates
RETURN 0
end event

event rbuttonup;This.of_getuoquery().Event ue_open_menu()

Return 1


end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_add from u_cb within tabpage_report
string accessiblename = "Add Button"
string accessibledescription = "$$HEX1$$ae00$$ENDHEX$$"
integer x = 1435
integer y = 976
integer width = 137
integer height = 112
integer taborder = 60
integer textsize = -12
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$ae00$$ENDHEX$$"
end type

event clicked;call super::clicked;//cb_add (inherited from u_cb)
//When clicked will remove selected columns from Available Fields 
//and add to Selected Fields datawindow.

This.of_getuoquery().Event ue_tabpage_report_add()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_remove from u_cb within tabpage_report
string accessiblename = "Remove Button"
string accessibledescription = "$$HEX1$$ac00$$ENDHEX$$"
integer x = 1431
integer y = 1140
integer width = 137
integer height = 112
integer taborder = 70
integer textsize = -12
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$ac00$$ENDHEX$$"
end type

event clicked;call super::clicked;//cb_remove (inherited from u_cb)
//When clicked will remove selected columns from Selected Fields 
//and add to Available Fields datawindow.

This.of_getuoquery().Event ue_tabpage_report_remove()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_up from u_cb within tabpage_report
string accessiblename = "Up Button"
string accessibledescription = "$$HEX1$$ad00$$ENDHEX$$"
integer x = 3022
integer y = 976
integer width = 137
integer height = 112
integer taborder = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$ad00$$ENDHEX$$"
end type

event clicked;call super::clicked;//pb_up (picture button)
//Moves selected column in the Selected Fields datawindow up one 
//field. Note: Need to find a proper up arrow bitmap.

This.of_getuoquery().Event ue_tabpage_report_move_col('UP')

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_down from u_cb within tabpage_report
string accessiblename = "Down Button"
string accessibledescription = "$$HEX1$$af00$$ENDHEX$$"
integer x = 3022
integer y = 1136
integer width = 137
integer height = 112
integer taborder = 90
integer textsize = -11
integer weight = 400
fontcharset fontcharset = symbol!
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "$$HEX1$$af00$$ENDHEX$$"
end type

event clicked;call super::clicked;//pb_down (picture button)
//Moves selected column in the Selected Fields datawindow down one 
//field. Note: Need to find a proper down arrow bitmap.
//
This.of_getuoquery().Event ue_tabpage_report_move_col('DOWN')

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_close_report from u_cb within tabpage_report
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2930
integer y = 1764
integer width = 261
integer taborder = 120
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;Integer		li_rc

w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)


Close (lw_parent)

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type cb_next_report from u_cb within tabpage_report
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2592
integer y = 1764
integer width = 261
integer taborder = 110
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Next"
end type

event clicked;call super::clicked;This.of_getuoquery().Event	ue_next_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type st_count_report from statictext within tabpage_report
string accessiblename = "Selected Fields Count"
string accessibledescription = "Selected Fields Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1637
integer y = 1660
integer width = 635
integer height = 76
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
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_prev_report from u_cb within tabpage_report
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 2254
integer y = 1764
integer width = 261
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Prev"
end type

event clicked;This.of_getuoquery().Event	ue_prev_tabpage()

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type st_available from statictext within tabpage_report
string accessiblename = "Available Fields"
string accessibledescription = "Available Fields"
accessiblerole accessiblerole = statictextrole!
integer x = 59
integer y = 376
integer width = 535
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Available Fields"
boolean focusrectangle = false
end type

type uo_report_options from u_report_options within tabpage_report
event destroy ( )
boolean visible = false
integer x = 18
integer y = 20
integer width = 3163
integer height = 1696
integer taborder = 20
end type

on uo_report_options.destroy
call u_report_options::destroy
end on

event rbuttondown;call super::rbuttondown;//	12/11/04	GaryR	Track 4108d	Dynamic Report Options

uo_query		luo_query
luo_query	=	cb_next_report.of_getuoquery()

If IsValid(luo_query) Then
	luo_query.Event ue_open_menu()
End If

Return 1
end event

type uo_tabpage_report from uo_tabpage_qe within tabpage_report
event destroy ( )
string accessiblename = "Report"
string accessibledescription = "Report"
integer x = 18
integer y = 24
integer width = 3163
integer height = 1696
end type

on uo_tabpage_report.destroy
call uo_tabpage_qe::destroy
end on

type mle_title from multilineedit within tabpage_report
event rbutonup pbm_rbuttonup
event ue_dwnkey pbm_keydown
string accessiblename = "Report Title"
string accessibledescription = "Report Title"
accessiblerole accessiblerole = textrole!
integer x = 59
integer y = 88
integer width = 2267
integer height = 272
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
integer limit = 160
borderstyle borderstyle = stylelowered!
end type

event rbutonup;
uo_query		luo_query

luo_query	=	cb_next_report.of_getuoquery()


If IsValid(luo_query) Then
	luo_query.Event ue_open_menu()
End If

Return 1

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	dw_selected.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			dw_selected.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				dw_selected.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type dw_fastquery from u_dw within tabpage_report
string accessiblename = "Fastquery"
string accessibledescription = "Fastquery"
integer x = 2373
integer y = 112
integer width = 777
integer height = 244
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fastquery_parms"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;////////////////////////////////////////////////////////////////////////
//	Script:	ItemChanged Event
//
//	Description:
//			Store the information entered.  
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Created.
// Lahu S 2/11/02 Track 2552d   Check mode
////////////////////////////////////////////////////////////////////////

String	ls_fastquery_ind

Long		ll_fastquery_rows

CHOOSE CASE dwo.Name
	CASE 'fastquery_ind'
		ls_fastquery_ind	=	Upper (data)
		ll_fastquery_rows	=	This.object.fastquery_rows [row]
		// If fastquery ind is set to 'Y', then initialize the fastquery rows.
		IF	 ls_fastquery_ind		=	'Y' AND ll_fastquery_rows	=	0	&
		and is_query_engine_mode = "PDQ"	THEN  //Lahu S 2/11/02 
			This.object.fastquery_rows [row]	=	il_dw_limit
		END IF
	CASE 'fastquery_rows'
		ls_fastquery_ind	=	This.object.fastquery_ind [row]
		ll_fastquery_rows	=	Long (data)
		uo_query			luo_query
		luo_query			=	This.of_GetUOQuery()
		luo_query.of_SetDWLimit (ll_fastquery_rows)
END CHOOSE

end event

type tabpage_view from userobject within uo_query
string accessiblename = "View Report Tab"
string accessibledescription = "The View Report tab launches the query, creates the report, and can also filter and subset the returned data."
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 112
integer width = 3209
integer height = 1912
boolean enabled = false
long backcolor = 67108864
string text = "View Report"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_close_view cb_close_view
st_count_view st_count_view
st_unique_count_view st_unique_count_view
cb_prev_view cb_prev_view
pb_notes_view pb_notes_view
st_unique_text_view st_unique_text_view
dw_break dw_break
dw_report dw_report
uo_tabpage_view uo_tabpage_view
end type

on tabpage_view.create
this.cb_close_view=create cb_close_view
this.st_count_view=create st_count_view
this.st_unique_count_view=create st_unique_count_view
this.cb_prev_view=create cb_prev_view
this.pb_notes_view=create pb_notes_view
this.st_unique_text_view=create st_unique_text_view
this.dw_break=create dw_break
this.dw_report=create dw_report
this.uo_tabpage_view=create uo_tabpage_view
this.Control[]={this.cb_close_view,&
this.st_count_view,&
this.st_unique_count_view,&
this.cb_prev_view,&
this.pb_notes_view,&
this.st_unique_text_view,&
this.dw_break,&
this.dw_report,&
this.uo_tabpage_view}
end on

on tabpage_view.destroy
destroy(this.cb_close_view)
destroy(this.st_count_view)
destroy(this.st_unique_count_view)
destroy(this.cb_prev_view)
destroy(this.pb_notes_view)
destroy(this.st_unique_text_view)
destroy(this.dw_break)
destroy(this.dw_report)
destroy(this.uo_tabpage_view)
end on

type cb_close_view from u_cb within tabpage_view
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2930
integer y = 1764
integer width = 261
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;Integer		li_rc

w_query_engine	lw_parent

li_rc	=	This.of_getparentwindow(lw_parent)


Close (lw_parent)

end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type st_count_view from statictext within tabpage_view
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 1764
integer width = 274
integer height = 92
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_unique_count_view from statictext within tabpage_view
boolean visible = false
string accessiblename = "Unique Records Count"
string accessibledescription = "Unique Records Count"
accessiblerole accessiblerole = statictextrole!
integer x = 2034
integer y = 1764
integer width = 274
integer height = 92
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_prev_view from u_cb within tabpage_view
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 2592
integer y = 1764
integer width = 261
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Prev"
end type

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

event clicked;This.of_getuoquery().Event	ue_prev_tabpage()

end event

type pb_notes_view from u_pb within tabpage_view
boolean visible = false
string accessiblename = "Notes"
string accessibledescription = "Notes"
integer x = 361
integer y = 1764
integer width = 123
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = fixed!
string facename = "System"
string picturename = "script1.bmp"
end type

event clicked;This.of_getuoquery().Event	ue_notes()
end event

type st_unique_text_view from statictext within tabpage_view
boolean visible = false
string accessiblename = "none"
string accessibledescription = "none"
accessiblerole accessiblerole = statictextrole!
integer x = 901
integer y = 1776
integer width = 1088
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_break from u_dw within tabpage_view
string tag = "Break with totals hidden d/w"
boolean visible = false
string accessiblename = "Break with Totals"
string accessibledescription = "Break with Totals"
integer x = 1289
integer y = 1756
integer width = 114
integer height = 68
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_initial"
end type

event retrievestart;call super::retrievestart;
Return 2
end event

event constructor;call super::constructor;//	01/14/05	GaryR	Track 4240d	Remove this datawindow from the save process
this.of_SetUpdateable(FALSE)
end event

type dw_report from u_dw within tabpage_view
string accessiblename = "Report Data"
string accessibledescription = "Report Data"
integer width = 3195
integer height = 1748
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(FALSE)
This.of_SetRetrieveMeter(TRUE)	//	Use the retrieve meter
this.of_SingleSelect(TRUE)

end event

event doubleclicked;call super::doubleclicked;RETURN This.of_getuoquery().of_WindowOperation(this,row,dwo)
end event

event retrievestart;call super::retrievestart;// ib_win_busy must be checked in the closequery event of w_query_engine. If it
// is true then should return 1. Look at w_parent report.

ib_win_busy=true

Return 2
end event

event retrieverow;call super::retrieverow;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	dw_report					retrieverow				Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	??					//				Created.
//	J.Mattis			02/25/98		1) Removed refs. to global gv_cancel_but_clicked
//										2) Changed il_dw_limit's datatype from integer to long
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

int li_message_nbr, li_Return

// MUST CHECK IF USER CLICKED THE STOP RETRIEVE MENU/TOOLBAR ITEM
IF gv_cancel_but_clicked THEN 
	li_Return = this.dbCancel()
	ib_RetrieveCancelled = TRUE
	Return 1
END IF

IF IsValid(iu_retrievemeter) THEN
	iu_retrievemeter.of_Progress()
END IF

// check if we are at limit
if row = il_dw_limit Then
	
	li_message_nbr = messagebox('ERROR','Over the system limit!~r'+&
				  'Do you still wish to continue?',Question!,OKCANCEL!,2) 
	if li_message_nbr = 2 Then
		SetMicrohelp(w_main,'Retrieve Being Cancelled. Please wait...')
		SetPointer(Hourglass!)
		li_Return = this.dbCancel()
		ib_RetrieveCancelled = TRUE
		Return 1
	else 
		SetMicrohelp(w_main,'Retrieve Continuing.  Please wait...')
		SetPointer(Hourglass!)
		// increment retrieve limit by system default limit
		il_dw_limit = il_dw_limit + gc_dw_limit
	end if
end if
end event

event retrieveend;call super::retrieveend;///////////////////////////////////////////////////////////////////////////////
// Change History:
///////////////////////////////////////////////////////////////////////////////
// JasonS 07/17/02	Track 3182d	force dw to redraw after retrieving
///////////////////////////////////////////////////////////////////////////////
dw_report.triggerevent(rowfocuschanged!)
ib_win_busy=false

// JasonS 07/17/02 Begin - Track 3182
this.width = this.width
// JasonS 07/17/02 End - Track 3182d



end event

event rowfocuschanged;call super::rowfocuschanged;/* UO_Query.DW_Report.RowFocusChanged
   
This event will initialized the key columns structure if no row is selected.
If a row is selected it will retrieve the value for the key columns that have
been selected for display in the report on tab */

//******************************************************************************
//	01-13-98 FNC 	Use visible field to determine if column is on the report. 
//						This code was using the col number but this field is not equal
//						to 0. The column number is set whether or not the field is 
//						displayed.
// 01-13-98 FNC 	Determine if row has changed. If not, exit event.
//	03-04-98 FNC	Track 838.  Stop resetting the key cols structure. 
//						It is initialized before it is loaded.
//	01/18/99	FDG	Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//	02/09/01	GaryR	Stars 4.7 DataBase Port - Validation of Data Types
//	03/04/03	GaryR	Track 3385d	Disable Claim Detail when ML
//	10/20/06	GaryR	Track 4820	Get first two bytes of invoice type in case it was decoded
//******************************************************************************
	
Long	ll_selected_row

ll_selected_row = tabpage_view.dw_report.getrow()

if ll_selected_row <> 0 then		//03-04-98 FNC End
	if istr_key_columns.icn.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.icn.col_value = dw_report.getitemstring &
		(ll_selected_row,istr_key_columns.icn.col_number)
	end if

	if istr_key_columns.icn_key2.col_number > 0 then
		IF gnv_sql.of_is_character_data_type( Upper( Trim( istr_key_columns.icn_key2.data_type ) ) ) &
		OR Upper( Trim( istr_key_columns.icn_key2.data_type ) ) = "" &
		OR Upper( Trim( istr_key_columns.icn_key2.data_type ) ) = "*"	THEN
			istr_key_columns.icn_key2.col_value = dw_report.getitemstring &
							(ll_selected_row,istr_key_columns.icn_key2.col_number)
		ELSEIF gnv_sql.of_is_date_data_type( Upper( Trim( istr_key_columns.icn_key2.data_type ) ) ) THEN
			istr_key_columns.icn_key2.col_value = String (dw_report.getitemdatetime &
							(ll_selected_row,istr_key_columns.icn_key2.col_number), 'mm/dd/yyyy')
		ELSEIF gnv_sql.of_is_money_data_type( Upper( Trim( istr_key_columns.icn_key2.data_type ) ) ) THEN
			istr_key_columns.icn_key2.col_value = String (dw_report.getitemdecimal &
							(ll_selected_row,istr_key_columns.icn_key2.col_number))
		ELSE
			istr_key_columns.icn_key2.col_value = String (dw_report.getitemnumber &
							(ll_selected_row,istr_key_columns.icn_key2.col_number))
		END IF
	end if

	if istr_key_columns.icn_key3.col_number > 0 then		
		IF gnv_sql.of_is_character_data_type( Upper( Trim( istr_key_columns.icn_key3.data_type ) ) ) &
		OR Upper( Trim( istr_key_columns.icn_key3.data_type ) ) = "" &
		OR Upper( Trim( istr_key_columns.icn_key3.data_type ) ) = "*"	THEN
			istr_key_columns.icn_key3.col_value = dw_report.getitemstring &
							(ll_selected_row,istr_key_columns.icn_key3.col_number)
		ELSEIF gnv_sql.of_is_date_data_type( Upper( Trim( istr_key_columns.icn_key3.data_type ) ) ) THEN
			istr_key_columns.icn_key3.col_value = String (dw_report.getitemdatetime &
							(ll_selected_row,istr_key_columns.icn_key3.col_number), 'mm/dd/yyyy')
		ELSEIF gnv_sql.of_is_money_data_type( Upper( Trim( istr_key_columns.icn_key3.data_type ) ) ) THEN
			istr_key_columns.icn_key3.col_value = String (dw_report.getitemdecimal &
							(ll_selected_row,istr_key_columns.icn_key3.col_number))
		ELSE
			istr_key_columns.icn_key3.col_value = String (dw_report.getitemnumber &
							(ll_selected_row,istr_key_columns.icn_key3.col_number))
		END IF
	end if
	
	if istr_key_columns.icn_key4.col_number > 0 then		
		IF gnv_sql.of_is_character_data_type( Upper( Trim( istr_key_columns.icn_key4.data_type ) ) ) &
		OR Upper( Trim( istr_key_columns.icn_key4.data_type ) ) = "" &
		OR Upper( Trim( istr_key_columns.icn_key4.data_type ) ) = "*"	THEN
			istr_key_columns.icn_key4.col_value = dw_report.getitemstring &
							(ll_selected_row,istr_key_columns.icn_key4.col_number)
		ELSEIF gnv_sql.of_is_date_data_type( Upper( Trim( istr_key_columns.icn_key4.data_type ) ) ) THEN
			istr_key_columns.icn_key4.col_value = String (dw_report.getitemdatetime &
							(ll_selected_row,istr_key_columns.icn_key4.col_number), 'mm/dd/yyyy')
		ELSEIF gnv_sql.of_is_money_data_type( Upper( Trim( istr_key_columns.icn_key4.data_type ) ) ) THEN
			istr_key_columns.icn_key4.col_value = String (dw_report.getitemdecimal &
							(ll_selected_row,istr_key_columns.icn_key4.col_number))
		ELSE
			istr_key_columns.icn_key4.col_value = String (dw_report.getitemnumber &
							(ll_selected_row,istr_key_columns.icn_key4.col_number))
		END IF
	end if

	if istr_key_columns.icn_key5.col_number > 0 then		
		IF gnv_sql.of_is_character_data_type( Upper( Trim( istr_key_columns.icn_key5.data_type ) ) ) &
		OR Upper( Trim( istr_key_columns.icn_key5.data_type ) ) = "" &
		OR Upper( Trim( istr_key_columns.icn_key5.data_type ) ) = "*"	THEN
			istr_key_columns.icn_key5.col_value = dw_report.getitemstring &
							(ll_selected_row,istr_key_columns.icn_key5.col_number)
		ELSEIF gnv_sql.of_is_date_data_type( Upper( Trim( istr_key_columns.icn_key5.data_type ) ) ) THEN
			istr_key_columns.icn_key5.col_value = String (dw_report.getitemdatetime &
							(ll_selected_row,istr_key_columns.icn_key5.col_number), 'mm/dd/yyyy')
		ELSEIF gnv_sql.of_is_money_data_type( Upper( Trim( istr_key_columns.icn_key5.data_type ) ) ) THEN
			istr_key_columns.icn_key5.col_value = String (dw_report.getitemdecimal &
							(ll_selected_row,istr_key_columns.icn_key5.col_number))
		ELSE
			istr_key_columns.icn_key5.col_value = String (dw_report.getitemnumber &
							(ll_selected_row,istr_key_columns.icn_key5.col_number))
		END IF
	end if
	
	if istr_key_columns.icn_key6.col_number > 0 then		
		IF gnv_sql.of_is_character_data_type( Upper( Trim( istr_key_columns.icn_key6.data_type ) ) ) &
		OR Upper( Trim( istr_key_columns.icn_key6.data_type ) ) = "" &
		OR Upper( Trim( istr_key_columns.icn_key6.data_type ) ) = "*"	THEN
			istr_key_columns.icn_key6.col_value = dw_report.getitemstring &
							(ll_selected_row,istr_key_columns.icn_key6.col_number)
		ELSEIF gnv_sql.of_is_date_data_type( Upper( Trim( istr_key_columns.icn_key6.data_type ) ) ) THEN
			istr_key_columns.icn_key6.col_value = String (dw_report.getitemdatetime &
							(ll_selected_row,istr_key_columns.icn_key6.col_number), 'mm/dd/yyyy')
		ELSEIF gnv_sql.of_is_money_data_type( Upper( Trim( istr_key_columns.icn_key6.data_type ) ) ) THEN
			istr_key_columns.icn_key6.col_value = String (dw_report.getitemdecimal &
							(ll_selected_row,istr_key_columns.icn_key6.col_number))
		ELSE
			istr_key_columns.icn_key6.col_value = String (dw_report.getitemnumber &
							(ll_selected_row,istr_key_columns.icn_key6.col_number))
		END IF
	end if
	//	02/09/01	GaryR	Stars 4.7 DataBase Port - End
		
	if istr_key_columns.date_paid.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.date_paid.col_value = string(dw_report.getitemdatetime &
		(ll_selected_row,istr_key_columns.date_paid.col_number), 'mm/dd/yyyy')		// FDG 01/18/99
		//(ll_selected_row,istr_key_columns.date_paid.col_number))		// FDG 01/18/99
	end if
		
	if istr_key_columns.from_date.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.from_date.col_value = string(dw_report.getitemdatetime &
		(ll_selected_row,istr_key_columns.from_date.col_number), 'mm/dd/yyyy')		// FDG 01/18/99
		//(ll_selected_row,istr_key_columns.from_date.col_number))		// FDG 01/18/99
	end if
		
	if istr_key_columns.recip_id.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.recip_id.col_value = dw_report.getitemstring &
		(ll_selected_row,istr_key_columns.recip_id.col_number)
	end if
		
	if istr_key_columns.prov_id.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.prov_id.col_value = dw_report.getitemstring &
		(ll_selected_row,istr_key_columns.prov_id.col_number)
	end if
		
	if istr_key_columns.allowed_srvc.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.allowed_srvc.col_value = string(dw_report.getitemnumber &
		(ll_selected_row,istr_key_columns.allowed_srvc.col_number))
	end if
		
	if istr_key_columns.invoice_type.col_number > 0 then			//01-13-97 FNC
		// Get first two bytes
		istr_key_columns.invoice_type.col_value = Left (dw_report.getitemstring &
		(ll_selected_row,istr_key_columns.invoice_type.col_number), 2 )
	end if
		
	if istr_key_columns.rev_code.col_number > 0 then			//01-13-97 FNC
		istr_key_columns.rev_code.col_value = dw_report.getitemstring &
		(ll_selected_row,istr_key_columns.rev_code.col_number)
	end if
end if
end event

event ue_retrieve;// OVERRIDE! since retrieve is called in ancestor before I can set gv_cancel_but_clicked
/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	dw_report					ue_Retrieve				Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Set the boolean which indicates if user is attempting retrieve cancel. 
// Then retrieve the report data, and reset the boolean.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			> -1			Success			
//					-2				Failure or Cancel.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/23/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_Return

// reset cancel retrieve boolean
ib_RetrieveCancelled = FALSE

//call overidden event
ll_Return = SUPER::Event ue_Retrieve()

// check if user cancelled retrieve
// NOTE: ib_retrievecancelled is set to TRUE in retrieverow event if user selects cancel.
IF ib_RetrieveCancelled THEN
	ll_Return = -2
END IF

RETURN ll_Return


end event

event rbuttonup;////////////////////////////////////////////////////////////////////////////////////
//	Change History
//
//	???				Created
//
//	FDG	01/26/98	If nothing was clicked on the d/w, then display the right-mouse 
//						menu.
// FNC	04/15/98	Track 1028. If inv_type is ML must get the numeric invoice type 
//						for the line that was clicked and then obtain the table type from
//						the code table.
//	FDG	11/18/98	Track 1903.  Always return 1 from any rbuttonup event
//						to prevent the window's cut/copy/paste RMM from
//						displaying.
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
// MikeF 10/08/02 Track 3339d Lookup Error on ML subsets for Row # > 32K
//	GaryR	01/14/03	Track 3651d	Add lookup functionality to PDRs
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
// MikeF	11/17/04 Track 3650d	Removed refernces to W_SUBSET_COLS_JOIN
//	GaryR	09/14/06	Track 4687	Check the claim main and dependent 
//										invoice type(s) if drilldown to Pat/Prov
//	GaryR	10/18/06	Track 4820	Get first two bytes of invoice type in case it was decoded
////////////////////////////////////////////////////////////////////////////////////

String ls_add_source, ls_main_table
String	ls_hold_object,		&
			ls_inv_type,			&
			ls_lookup_table
		
int		li_rc, li_status
long		li_row

w_query_engine		lw_parent
n_cst_stars_rel 	lnv_stars_rel
sx_pdr_parms		lsx_pdr_parms

uo_query	luo_query
li_rc	=	This.of_getparentwindow ( lw_parent )

ls_hold_object	=	This.GetObjectAtPointer()

IF	Trim (ls_hold_object)	=	""	THEN
	// Display RMM
	lw_parent.Event	ue_open_menu()
	Return 1
END IF

//	GaryR	04/17/02	Track 2552d - Begin
IF lw_parent.of_is_pdr_mode() THEN	
	ls_hold_object = Left( ls_hold_object, Pos( ls_hold_object, "~t" ) - 1 )
	IF Right( ls_hold_object, 2 ) = '_t' THEN
		IF match(right(ls_hold_object,6), '^_t_[0-9]_t$') then
			ls_hold_object = mid(ls_hold_object, 1, len(ls_hold_object) - 6)
		ELSE
			ls_hold_object = mid(ls_hold_object, 1, len(ls_hold_object) - 2)
		END IF
	END IF

	ls_lookup_table = This.Describe( ls_hold_object + ".dbname" )
	
	lw_parent.of_get_pdr_parm( lsx_pdr_parms )
	//	Check if claims PDR
	IF lsx_pdr_parms.pdr_source > 0 THEN
		IF Pos( ls_lookup_table, "." ) > 0 THEN
			ls_lookup_table = Upper( Trim( Left( ls_lookup_table, Pos( ls_lookup_table, "." ) - 1 ) ) )
			ls_lookup_table = tabpage_source.dw_source.event ue_get_inv_type( ls_lookup_table )
			IF IsNull( ls_lookup_table ) OR Trim( ls_lookup_table ) = "" THEN Return -1
		ELSE
			Return -1
		END IF
	ELSE
		IF Pos( ls_lookup_table, "." ) > 0 THEN
			ls_lookup_table	= Upper( Trim( Left( ls_lookup_table, Pos( ls_lookup_table, "." ) - 1 ) ) )
		ELSE
			ls_lookup_table = "CASE_CNTL"
		END IF

		ls_lookup_table = gnv_dict.event ue_get_table_type(ls_lookup_table)

		IF ls_lookup_table = gnv_dict.ics_error THEN Return 1
	END IF

	fx_lookup(dw_report,ls_lookup_table)
	Return 1
END IF
//	GaryR	04/17/02	Track 2552d - End

Setpointer(Hourglass!)

ls_add_source = left(tabpage_source.dw_source.getitemstring(1,'add_data_source'),2)

if trim(ls_add_source) <> '' then
	gv_element_table_type2 = ls_add_source
end if

// If this is not really a claim join, but there are filters applied,
//   then set gv_elem... to 'FL' so fx_lookup will strip off 'c'
//  prob 609 - lookups don't work when filter join occurs

if gv_element_table_type2 = '' and ii_filter_count > 0 then
	gv_element_table_type2 = 'FL'
end if		

ls_main_table = left(tabpage_source.dw_source.getitemstring(1,'data_source'),2)

//FNC 04/15/98 Start
if ls_main_table = 'ML' then		/*subset view */
	li_row = this.getrow()
	ls_inv_type = this.getitemstring(li_row,'invoice_type')
	
	// Get first two bytes of inv type
	ls_inv_type = Trim( Left( ls_inv_type, 2 ) )
	
	SELECT CODE_VALUE_A
  	  INTO :ls_lookup_table
     FROM CODE
	 WHERE (CODE_TYPE = 'IT') AND
	  		 (CODE_CODE = Upper( :ls_inv_type ) )
	 USING STARS2CA;
		
	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error retrieving main invoice type (uo_query.dw_report.rbuttondown). Cannot perform lookup')
		return 1
	end if
	
	/*Put join table into global because when viewing an ML will not have a table
	  selected in the add data source but can select CR columns if UB92 table type is
	  in subset*/
	
	IF lnv_stars_rel.of_get_is_ub92(ls_lookup_table) THEN
		gv_element_table_type2 = lnv_stars_rel.of_get_revenue(ls_lookup_table)
	ELSE
		gv_element_table_type2 = ''
	END IF

	IF gv_element_table_type2 = gnv_dict.ics_error THEN
		MessageBox("ERROR",'Error retrieving join invoice type (uo_query.dw_report.rbuttondown). Cannot perform lookup')
		return 1
	end if
ElseIf ls_main_table = "PV" OR ls_main_table = "EN" THEN
	luo_query = lw_parent.wf_getpreviousquery()
	IF IsValid( luo_query ) THEN
		IF luo_query.of_get_ib_drilldown_mode() THEN
			// Set the claim main and dependent 
			// invoice type(s) if drilldown to Pat/Prov
			gv_element_table_type2 = luo_query.is_inv_type
			gv_element_table_type3 = luo_query.is_add_inv_type
		END IF
	END IF
	ls_lookup_table = ls_main_table
else
	ls_lookup_table = ls_main_table
end if
//FNC 04/15/98 End

fx_lookup(dw_report,ls_lookup_table)

stars2ca.of_commit()						// FNC 04/14/99

Return 	1
end event

event ue_dwnkey;//*********************************************************************
//	Script:		ue_dwnkey (pbm_keydown)
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If F12 is pressed, display the Right Mouse Menu.
//
//*********************************************************************
//	History
//
//	FDG	12/02/98	Track 2004.  Created
//
//*********************************************************************

IF	KeyDown (KeyF12!)							THEN
	This.of_getuoquery().Post	Event	ue_open_menu()
ELSE
	IF KeyDown (KeyControl!)				THEN
		IF	KeyDown (KeyRightArrow!)		THEN
			This.of_getuoquery().Post	Event	ue_next_tabpage()
		ELSE
			IF	KeyDown (KeyLeftArrow!)		THEN
				This.of_getuoquery().Post	Event	ue_prev_tabpage()
			END IF
		END IF
	END IF
END IF

end event

type uo_tabpage_view from uo_tabpage_qe within tabpage_view
event destroy ( )
boolean visible = false
string accessiblename = "View Report"
string accessibledescription = "View Report"
integer x = 18
integer y = 24
integer width = 3163
integer height = 1696
end type

on uo_tabpage_view.destroy
call uo_tabpage_qe::destroy
end on

