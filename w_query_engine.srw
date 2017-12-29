HA$PBExportHeader$w_query_engine.srw
$PBExportComments$Main window for Query Engine (Inherited from w_master). Changes to this will require regening w_query_engine_response.
forward
global type w_query_engine from w_master
end type
type dw_pdr_sources from u_dw within w_query_engine
end type
type dw_pdq_cntl from u_dw within w_query_engine
end type
type dw_pdq_case_link from u_dw within w_query_engine
end type
type dw_pdq_criteria from u_dw within w_query_engine
end type
type dw_pdq_columns from u_dw within w_query_engine
end type
type tab_level from tab within w_query_engine
end type
type tabpage_1 from userobject within tab_level
end type
type tabpage_1 from userobject within tab_level
end type
type tabpage_2 from userobject within tab_level
end type
type tabpage_2 from userobject within tab_level
end type
type tabpage_3 from userobject within tab_level
end type
type tabpage_3 from userobject within tab_level
end type
type tabpage_4 from userobject within tab_level
end type
type tabpage_4 from userobject within tab_level
end type
type tabpage_5 from userobject within tab_level
end type
type tabpage_5 from userobject within tab_level
end type
type tabpage_6 from userobject within tab_level
end type
type tabpage_6 from userobject within tab_level
end type
type tabpage_7 from userobject within tab_level
end type
type tabpage_7 from userobject within tab_level
end type
type tabpage_8 from userobject within tab_level
end type
type tabpage_8 from userobject within tab_level
end type
type tabpage_9 from userobject within tab_level
end type
type tabpage_9 from userobject within tab_level
end type
type tabpage_10 from userobject within tab_level
end type
type tabpage_10 from userobject within tab_level
end type
type tab_level from tab within w_query_engine
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type
type dw_pdq_tables from u_dw within w_query_engine
end type
type wsx_columns from structure within w_query_engine
end type
end forward

type wsx_columns from structure
	sx_col_desc		sx_columns[]
end type

global type w_query_engine from w_master
string accessiblename = "PDQ Queries"
string accessibledescription = "PDQ Queries"
integer x = 5
integer y = 4
integer width = 3406
integer height = 2008
string title = "PDQ Queries"
boolean ib_popup_menu = true
event type integer ue_set_menus_data_source ( string as_source_type,  string as_inv_type,  string as_drilldown_path )
event type integer ue_set_drilldown_menu ( string as_data_source,  string as_drilldown_path )
event type integer ue_load_query ( integer ai_level )
event ue_set_subset_title ( )
event ue_set_menus_subset_view ( boolean ab_switch )
event ue_set_pdq_title ( )
event type integer ue_unload_parms ( sx_query_engine_parms astr_parms )
event type integer ue_register_level ( integer ai_newlevel,  integer ai_oldlevel )
event type integer ue_set_menus_query_select ( boolean ab_switch )
event ue_enable_next_button ( boolean ab_switch )
event type integer ue_load_pdq_dws ( string as_query_id,  string as_userid,  string as_case_id,  string as_case_spl,  string as_case_ver )
event type integer ue_get_level_num ( )
event type integer ue_show_levels ( integer ai_level )
event ue_new_level ( )
event type integer ue_set_menus_report ( boolean ab_visible )
event type integer ue_save_query ( string as_path )
event ue_open_filter_window ( )
event type integer ue_get_filter_info ( string as_type,  ref sx_filter_info asx_filter_info[] )
event type integer ue_get_level_filter_info ( ref sx_filter_info asx_filter_info[] )
event type integer ue_set_filter_info ( sx_filter_info asx_new_filter_info[] )
event ue_open_menu ( )
event ue_prov_pat_drilldown ( string as_tag_value )
event ue_parent_drilldown ( string as_tag_value )
event ue_create_subset ( )
event ue_clear_pdq_datawindows ( )
event type integer ue_save_cntl_pdq ( sx_query_save asx_query_save )
event type integer ue_subsetting_add_level ( ref sx_subsetting_info asx_subsetting_info,  string as_subset_id,  string as_case_id,  string as_inv_type )
event ue_set_menus_new_level ( )
event ue_set_menus_drilldown ( boolean ab_visible )
event ue_list_report_template ( )
event ue_save_report_template ( string as_path )
event ue_crystal_reports ( )
event ue_select_pdq ( )
event ue_set_unique_count ( long al_count,  string as_type )
event type integer ue_set_menus_break_with_totals ( boolean ab_flag )
event type integer ue_break_with_totals ( )
event ue_set_menus_super_provider_query ( boolean ab_switch )
event type integer ue_get_active_level_num ( )
event ue_parent_undo_drilldown ( )
event type integer ue_open_uo_query ( ref uo_query auo_query,  sx_drilldown_parms astr_drilldown_parms,  string as_level )
event ue_set_ml_subset_type ( ref sx_subsetting_info astr_subsetting_info[] )
event type integer ue_get_source_subset_type ( string as_subset_id,  ref string as_sub_src_type )
event type integer ue_delete_pdq_data ( string as_query_id )
event ue_remove_level ( )
event ue_remove_all_levels ( boolean ab_ancillary_inv_type )
event type string ue_get_current_query_id ( )
event ue_reset_current_pdq ( )
event ue_remove_all_levels_mc ( )
event ue_copy_notes ( string arg_rel_id,  string arg_case_id,  string arg_rel_id_orig )
event ue_enable_prev_button ( boolean ab_switch )
event type integer ue_set_menus_dependent_info_menu ( boolean ab_switch )
event type integer ue_export_pdq ( string as_come_from )
event type string ue_build_file_hdr ( string as_comments )
event type string ue_build_pdq_hdr ( )
event type string ue_build_pdq_table ( integer ai_row )
event type string ue_build_pdq_crit ( integer ai_row )
event type string ue_build_pdq_col ( integer ai_row )
event type integer ue_import_pdq ( )
event type integer ue_import_file_hdr ( string as_record )
event type integer ue_import_pdq_hdr ( string as_record )
event type integer ue_import_pdq_table ( string as_record )
event type integer ue_import_pdq_crit ( string as_record )
event type integer ue_import_pdq_col ( string as_record )
event ue_import_clean_up ( long al_file_number )
event type integer ue_import_get_table_types ( )
event ue_show_notes_icon ( string as_case_id )
event ue_determine_pd_opt_visibility ( )
event ue_edit_menus_delete ( string as_case_id,  string as_case_spl,  string as_case_ver )
dw_pdr_sources dw_pdr_sources
dw_pdq_cntl dw_pdq_cntl
dw_pdq_case_link dw_pdq_case_link
dw_pdq_criteria dw_pdq_criteria
dw_pdq_columns dw_pdq_columns
tab_level tab_level
dw_pdq_tables dw_pdq_tables
end type
global w_query_engine w_query_engine

type variables
// LahuS 12/21/01  
sx_query_engine_parms  istr_parms 

n_cst_pdr_drilldown incst_drilldown[]  //Lahu 
int			ii_ctr = 1  //Lahu

//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
Boolean	ib_sumbyrev
Boolean	ib_pdq_subset
Integer	ii_prefilter_rows[]
String	is_prefilter_bool[]
String	is_subset_inv_type

//	09/08/06	GaryR	Track 4814	Handle sorting on Break w/ Totals in QE
Boolean	ib_break_with_totals

Protected:
string   	is_query_id			
string     	is_parm_subset_id		
string	is_parm_subset_name	
string       	is_auth_id
string	is_period_function   

m_list         im_list
m_pdr			im_pdr		//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
m_source	 im_source			
m_search	 im_search			
m_report 	 im_report		
m_view	 im_view	
		
int	 ii_level_num	
int 	 ii_period_key
uo_query iu_active_query		
uo_query iu_query[]		
uo_query iu_previous_query		
u_nvo_view iuo_nvo_view

sx_criteria  istr_drilldown_criteria[]
boolean  ib_multiple_drilldown = FALSE

sx_filter_info  isx_filter_info[]	

//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR) - Begin
Constant int	IC_LIST		=	1
Constant int	IC_PDR		=	2
Constant int	IC_SOURCE	=	3
Constant int	IC_SEARCH	=	4
Constant int	IC_REPORT	=	5
Constant int	IC_VIEW 		=	6
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR) - End

Constant int             IC_MAX_LEVELS = 10

//position info. for uo_query
int IIX_POS=60		//X coordinate of uo_query within w_query_engine
int IIY_POS=145		//Y coordinate of uo_query within w_query_engine	

Constant String	IS_LEVELTEXT = 'Level '
Constant String	IS_LVLTEXT = 'Lvl '
Constant String	ics_icn = 'ICN'
Constant String	ics_providers = 'PROVIDERS'
Constant String	ics_patients = 'PATIENTS'
Constant String	ics_revenue = 'REVENUE'
Constant String	ics_patsrvc = 'PATSRVC'

// Determines if the print menu item is to be enabled
Boolean		ib_enable_print = FALSE

// Has a row of criteria been deleted?
Boolean		ib_delete_criteria

sx_subset_ids          isx_subset

//03-12-98 FNC Track 931
//subset id of source subset if query is against another inv type.
string		is_subset_id

// The old state of m_stars_30.m_showsql
Boolean		ib_showsql

// Is the window opening?
Boolean		ib_opening_window

// Is a new level being created?
Boolean		ib_new_level

// FNC 10/27/99 Added for Fraud PDQ's
n_ds	ids_stars_rel
string is_inv_type[], is_dep_inv_type[]

//AJS 12/32/99 Added for Import PDQ's
Boolean	ib_error
n_ds	ids_summary
n_ds	ids_errors
n_ds	ids_status

long	il_record_count
long	il_prev_level_num
String	is_prev_Inv_type
String	is_import_comments
String	is_import_query_id
String	is_import_inv_type[]
long	il_summ_row
long	il_status_row

//NLG 12/13/99
int ii_run_frequency
string is_prev_frequency

//FNC 12/29/99 Import Super Provider
boolean ib_spq
integer ii_spq_idx
sx_prov_query_structure_container istr_prov_query_container[]

//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
boolean ib_npq
integer ii_npq_idx
sx_prov_query_structure_container istr_npi_prov_query_container[]

// Stars 4.8 - Disable update functionality?
Boolean	ib_disable_update
end variables

forward prototypes
protected function integer wf_getuoxpos ()
protected function integer wf_getuoypos ()
protected function integer wf_setuopos ()
public function uo_query wf_getactivequery ()
public function integer wf_newlevel (integer ai_level)
public function integer wf_setleveltext (integer ai_level)
public function tab wf_gettab ()
protected function integer wf_resizeuo (integer ai_level)
protected function integer wf_disablelevels ()
public function integer of_updatechecks ()
public function integer wf_set_print (boolean ab_switch)
public function sx_subset_ids wf_get_sxsubset ()
public function u_Dw wf_getdwpdqtables ()
public function integer wf_get_max_uo_query ()
public function integer wf_setfilter (ref u_dw adw_requestor, integer ai_level, string as_filterstring)
public subroutine wf_setrowdelete (boolean ab_switch)
public function boolean wf_getrowdelete ()
public function integer wf_enable_select (boolean ab_switch)
public function string wf_get_query_id ()
public function menu wf_get_m_view ()
public function sx_filter_info_container wf_get_isx_filter_info ()
public subroutine wf_clear_filter_info (string as_parm)
public function integer wf_set_ii_run_frequency (integer ai_run_frequency)
public function integer wf_get_ii_run_frequency ()
public function boolean wf_get_disable_update ()
public function integer wf_resettitle ()
public function integer wf_clearlevels ()
public function boolean of_is_pdr_mode ()
public function integer wf_loadquery (integer ai_level)
public function integer wf_setlevelfilter (integer ai_level, string as_source)
public function integer of_get_pdr_parm (ref sx_pdr_parms astr_pdr_parms)
public subroutine wf_resetleveltext (integer ai_level)
public function uo_query wf_getpreviousquery ()
end prototypes

event type integer ue_set_menus_data_source(string as_source_type, string as_inv_type, string as_drilldown_path);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_menus_data_source				w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by uo_query.tabpage_source.dw_source.itemchanged event when 
// a data source is selected.  This event will set the right mouse menus depending on 
// which type of data source is selected.  The drilldown menu items must be actually set 
// (different menu items for each type of data source and what type of drilldown - 
// as_drilldown_path) where the others must just be set to be invisible.  The possibilities
// of the data source are claims or auxillary (as_source_type) and within claims whether 
// it is multi-level (ML or MC) or single invoice type (as_inv_type).  
// Note: See tech spec ts144 - Menu Visibility for details.
/////////////////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		Value			as_source_type		String				The source type.
//		Value			as_inv_type			String				The invoice type.
//		Value			as_drilldown_path	String				The drilldown path.
/////////////////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
/////////////////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		12/04/97		Created.
// F.Chernak	01/20/98		Added if stmt before trigger event ue_set_drilldown_menu
//									so can send MC instead of tbl type to the event if claims
//									drilldown
//	J.Mattis		12/08/97	   Correct refs. from im_list.m_menu.m_notes to
//									im_list.m_menu.m_note.
//	FDG			02/09/98		Changed the visible attribute to enabled to
//									avoid a menu conflict with m_stars_30.
//	FNC			04/14/98		Track 1027. If data source is MC, disable filters on
//									search RMM so that the user cannot create a filter.
//	FDG			04/22/98		Track 1104. m_note & m_link are no longer on m_list.
// FNC			07/08/98		Track 1218. Don't enable m_drilldown in this script
//	FDG			11/25/98		Track 1990.  The 'Save' menu items also exist
//									under m_report.
// KTB         06/02/00    Track 2873 Starcare. Added Money Units tab.
//	FDG			04/27/01		Stars 4.6.	Check for specific invoice types instead of 'M'.
// FDG			09/21/01		Stars 4.8.1 Don't enable if the associated case is
//									closed or deleted
// FNC			11/07/01		Track 2466 Stardev. Don't enable next level is user is in
//									drilldown mode.
//	GaryR			02/12/02		Track 2552d Predefined Report (PDR)
//	FDG			03/19/02		Stars 5.1.  Allow subsetting of ancillary invoice types.
//	GaryR			05/23/05		Track 4406d	Allow filters in Ancillary invoice types.
//	GaryR			07/04/05		Track 3316d	Keep claims detail menu setting on drilldown
//	HYL		03/13/06		Track 4562d	Disable <Create Subset...> and <Criteria Save> menu items when it is drill down mode.
//	09/10/09	GaryR	QEN.650.5229.006	Add statistical and arithmetic functions to QE reports
//	Katie			05/24/2010	Track 5809	Added statistical and arithmetic functions for ancillary tables.
//
////////////////////////////////////////////////////////////////////////////////////////

// FDG 09/21/01 begin
IF	ib_disable_update		THEN	Return 1

/* check type of data source (claim or aux) */
if as_source_type = 'AN' then
	im_search.m_menu.m_filters.enabled = TRUE
	im_search.m_menu.m_save.m_createsubset.enabled = TRUE		// FDG 03/19/02
	im_search.m_menu.m_save.m_criteriasave.enabled = TRUE		// FDG 03/19/02
	im_search.m_menu.m_nextlevel.enabled = FALSE
	im_view.m_menu.m_save.m_createsubset.enabled = TRUE		// FDG 03/19/02
	im_view.m_menu.m_save.m_criteriasave.enabled = TRUE		// FDG 03/19/02
	// FDG 11/25/98 begin
	im_report.m_menu.m_save.m_createsubset.enabled = TRUE		// FDG 03/19/02
	im_report.m_menu.m_save.m_criteriasave.enabled = TRUE		// FDG 03/19/02
	// FDG 11/25/98 end
	im_view.m_menu.m_nextlevel.enabled = FALSE
	im_view.m_menu.m_claimoperations.enabled = FALSE
	im_view.m_menu.m_list.enabled = FALSE
	im_view.m_menu.m_uniquecounts.enabled = FALSE
	// KTB - Track 2873
	im_view.m_menu.m_statistics.enabled = TRUE
	// END KTB
else /* claims */
	/* reset just in case may have been set previously */
	im_search.m_menu.m_filters.enabled = TRUE
	im_search.m_menu.m_save.m_createsubset.enabled = TRUE
	im_search.m_menu.m_save.m_criteriasave.enabled = TRUE
	IF iu_active_query.ib_drilldown THEN // HYL 03/13/06 Track 4562d
		im_view.m_menu.m_save.m_createsubset.enabled = FALSE
		im_view.m_menu.m_save.m_criteriasave.enabled = FALSE
	ELSE
		im_view.m_menu.m_save.m_createsubset.enabled = TRUE
		im_view.m_menu.m_save.m_criteriasave.enabled = TRUE
	END IF
	// FDG 11/25/98 begin
	im_report.m_menu.m_save.m_createsubset.enabled = TRUE
	im_report.m_menu.m_save.m_criteriasave.enabled = TRUE
	// FDG 11/25/98 end
	im_view.m_menu.m_claimoperations.enabled = TRUE
	im_view.m_menu.m_claimoperations.m_claimdetail.enabled = iu_active_query.ib_claimdetail
	im_view.m_menu.m_list.enabled = TRUE
	im_view.m_menu.m_uniquecounts.enabled = TRUE
	//KTB - Track 2873
	im_view.m_menu.m_statistics.enabled = TRUE
	//END KTB
	/* now set for claims */
	// FDG 04/27/01 - Check for 'MC' or 'ML' (instead of 'M')
	IF	as_inv_type	=	'MC'		&
	OR	as_inv_type	=	'ML' 		&
	OR iu_active_query.of_get_ib_drilldown() = TRUE THEN		//FNC 11/07/01
		im_search.m_menu.m_nextlevel.enabled = FALSE
		im_view.m_menu.m_nextlevel.enabled = FALSE
	else
		im_search.m_menu.m_nextlevel.enabled = TRUE
		im_view.m_menu.m_nextlevel.enabled = TRUE
	end if
	if as_inv_type = 'MC' then										//FNC 04/14/98 Start
		im_search.m_menu.m_filters.enabled = FALSE
	else
		im_search.m_menu.m_filters.enabled = TRUE
	end if																//FNC 04/14/98 End
end if

//	GaryR	02/12/02	Track 2552d
IF This.of_is_pdr_mode() THEN
	this.event ue_set_drilldown_menu(as_inv_type, as_drilldown_path)
	RETURN 1
END IF

/* only set drilldown menu if have not 'drilled down' yet or if have 'drilled 
down' and doing a claim drilldown */
if im_view.m_menu.m_drilldown.enabled then
	if as_source_type = 'AN' then							//01-20-98 FNC
		this.event ue_set_drilldown_menu(as_inv_type, as_drilldown_path)
	else														//01-20-98 FNC
		this.event ue_set_drilldown_menu('MC', as_drilldown_path)	//01-20-98 FNC
	end if
end if

RETURN 1
end event

event type integer ue_set_drilldown_menu(string as_data_source, string as_drilldown_path);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_drilldown_menu					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by the active uo_query's tabpage_source.dw_source.itemchanged
// event (ue_set_menu_data_source()) when a data source is selected.  The drilldown menu
// must be set depending on that data source.  First must retrieve rows from STARS_WIN_PARM 
// for the data source passed in.  If as_drilldown_path = 'AD' is set then only get Additional 
// Data.  Then clear out the drilldown menu.  Then using the STARS_WIN_PARM load the menu. 
// Since menus items must be reference literally (like tabpages) must hardcode the menu items. 
// Thus another limitation, max number of drilldown items is 10. Note: For more information
// on drilldown, see ts144 - drilldown.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		Value			as_data_source		String				The data source.
//		Value			as_drilldown_path	String				The drilldown.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/04/97		Created.
//
//	FDG		02/09/98		Changed the visible attribute to enabled to
//								avoid a menu conflict with m_stars_30.
//
// FNC		02/11/98-1	Select cntl_id instead of a_dflt. Put data into
//								cntl_id so that the key for stars_win_parm would
//								be unique
//
// FNC		02/11/98-2	1.Determine if attrib is null. If is is null set it to a space
//								so that the menu tag value is not nulled when the tag is set
//								to the value in cntl_id concatenated with attrib. I did
//								a separate select because it would have been too messy to 
//								to put this code in the same select.
//								2.Set menu text to blank because will set text later on
//								in the code. Those menu items that are not valid will be
//								blank
//
//	FDG		09/11/98		Track 1687.  Access the menus via the instance variables
//								(i.e. im_view) instead of globally (i.e. m_view).
// FNC		04/15/99		FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//								to prevent locking.
//	FDG		12/06/01		Track 2497, 2561.  Prevent memory leaks.
//	GaryR		02/05/02		Track 2552d Predefined Report (PDR)
//	FDG		02/15/02		Track 2881c.  If the invoice type = 'MC', drilldown to
//								additional data makes no sense and is not allowed.
//	FDG		03/20/02		Stars 5.1.  New ancillary invoice types may not necessarily
//								have stars_win_parm entries for drilldown.
// Lahu S    4/17/02		Track 2552d Get PDR label from stars_win_parm to display in menu
//	GaryR		06/05/03		Track 3602d	Add win_id to select for PDR label
//	GaryR		02/19/04		Track 3874d	Set unused menu items invisible
//	GaryR		05/10/04		Track 3756d	Streamline PDR deployment & security
//	GaryR		12/11/04		Track 4108d	Dynamic Report Options
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String 	ls_sql, 			&
			ls_attrib_1,	&
			ls_attrib_2,	&
			ls_attrib_3,	&
			ls_attrib_4,	&
			ls_attrib_5,	&
			ls_attrib_6,	&
			ls_attrib_7,	&
			ls_attrib_8,	&
			ls_attrib_9,	&
			ls_attrib_10,	&
			ls_filter,		&
			ls_inv_type
			
n_ds		lds_parm

Integer 	li_rowcount,	&
			li_rc

//	GaryR	02/05/02	Track 2552d - Begin
//	This logic will execute only in PDR or PDCR mode
String			ls_pdr_text
sx_pdr_parms	lsx_pdr_parms

IF This.of_is_pdr_mode() THEN
	im_view.m_menu.m_drilldown.enabled =  FALSE	
	This.of_get_pdr_parm( lsx_pdr_parms )
	
	//Lahu S 4/17/02 Track 2552d begin
	// Get value from structure for drilldown/case maintenance report
	if lsx_pdr_parms.pdr_drilldown = "CASE_MAINT" then
		ls_pdr_text	= "Case Maintenance"
	elseif lsx_pdr_parms.pdr_drilldown <> "" then
		SELECT RPT_NAME
		INTO	:ls_pdr_text
		FROM	PDR_CNTL
		WHERE	PDR_NAME = :lsx_pdr_parms.pdr_drilldown
		USING	Stars2ca;
		
		IF Stars2ca.of_commit() <> 0 THEN
			MessageBox( "ERROR", "Unable to find row in PDR_CNTL where PDR_NAME = " + &
								lsx_pdr_parms.pdr_drilldown, StopSign! )
			Return -1
		END IF
	else
		Return 1
	end if

	//	Setup drilldown menu for PDR
	im_view.m_menu.m_drilldown.enabled =  TRUE
	im_view.m_menu.m_drilldown.m_2.visible = FALSE
	im_view.m_menu.m_drilldown.m_3.visible = FALSE
	im_view.m_menu.m_drilldown.m_4.visible = FALSE
	im_view.m_menu.m_drilldown.m_5.visible = FALSE
	im_view.m_menu.m_drilldown.m_6.visible = FALSE
	im_view.m_menu.m_drilldown.m_7.visible = FALSE
	im_view.m_menu.m_drilldown.m_8.visible = FALSE
	im_view.m_menu.m_drilldown.m_9.visible = FALSE
	im_view.m_menu.m_drilldown.m_10.visible = FALSE
	//Lahu S Track 2552d end

	im_view.m_menu.m_drilldown.m_1.text = ls_pdr_text
	Return 1
END IF
//	GaryR	02/05/02	Track 2552d - End

/* build datastore for stars_win_parm with ls_sql */
lds_parm = create n_ds

if as_drilldown_path = 'AD' then
	//02-11-98-1 FNC
	ls_sql = "select label,cntl_id,attrib,n_dflt " + &
				"from stars_win_parm "+ &
				"where win_id = 'M_DRILLDOWN' "  + &
				"and tbl_type = '" + Upper( as_data_source ) + &
				"' and cntl_id = '" + Upper( as_drilldown_path )  + &
				"' order by n_dflt "
	
else
	//02-11-98-1 FNC
	ls_sql = "select label,cntl_id,attrib,n_dflt " + &
				"from stars_win_parm "+ &
				"where win_id = 'M_DRILLDOWN' "  + &
				"and tbl_type = '" + Upper( as_data_source ) + &
				"' order by n_dflt "
end if

lds_Parm.DataObject = 'd_set_drilldown_menu'

IF lds_parm.SetTransObject(stars2ca) <> 1 THEN
	MessageBox("Error","Transaction error attempting to obtain drilldown menu parameters.",StopSign!)
	IF IsValid(lds_parm)	THEN	Destroy	lds_parm			// FDG 12/06/01
	RETURN -1
END IF

im_view.m_menu.m_drilldown.m_1.enabled =  FALSE
im_view.m_menu.m_drilldown.m_2.enabled =  FALSE
im_view.m_menu.m_drilldown.m_3.enabled =  FALSE
im_view.m_menu.m_drilldown.m_4.enabled =  FALSE
im_view.m_menu.m_drilldown.m_5.enabled =  FALSE
im_view.m_menu.m_drilldown.m_6.enabled =  FALSE
im_view.m_menu.m_drilldown.m_7.enabled =  FALSE
im_view.m_menu.m_drilldown.m_8.enabled =  FALSE
im_view.m_menu.m_drilldown.m_9.enabled =  FALSE
im_view.m_menu.m_drilldown.m_10.enabled = FALSE

//02-11-98 FNC Start
im_view.m_menu.m_drilldown.m_1.text = ''
im_view.m_menu.m_drilldown.m_2.text = ''
im_view.m_menu.m_drilldown.m_3.text = ''
im_view.m_menu.m_drilldown.m_4.text = ''
im_view.m_menu.m_drilldown.m_5.text = ''
im_view.m_menu.m_drilldown.m_6.text = ''
im_view.m_menu.m_drilldown.m_7.text = ''
im_view.m_menu.m_drilldown.m_8.text = ''
im_view.m_menu.m_drilldown.m_9.text = ''
im_view.m_menu.m_drilldown.m_10.text = ''
//02-11-98 FNC End

//	Set items invisible
im_view.m_menu.m_drilldown.m_1.visible =  FALSE
im_view.m_menu.m_drilldown.m_2.visible =  FALSE
im_view.m_menu.m_drilldown.m_3.visible =  FALSE
im_view.m_menu.m_drilldown.m_4.visible =  FALSE
im_view.m_menu.m_drilldown.m_5.visible =  FALSE
im_view.m_menu.m_drilldown.m_6.visible =  FALSE
im_view.m_menu.m_drilldown.m_7.visible =  FALSE
im_view.m_menu.m_drilldown.m_8.visible =  FALSE
im_view.m_menu.m_drilldown.m_9.visible =  FALSE
im_view.m_menu.m_drilldown.m_10.visible = FALSE

//set the SQL select stmt., and check for success before continuing.
IF lds_parm.SetSQLSelect(ls_Sql) = 1 THEN
		
	li_rowcount = lds_parm.retrieve()
		
	if li_rowcount < 1 then
		// FDG 03/20/02 - New ancillary invoice types might not exist in stars_win_parm
		IF IsValid(lds_parm)	THEN	Destroy	lds_parm			// FDG 12/06/01
		return 1
	end if
	// FDG 02/15/02 - begin
	ls_inv_type	=	iu_active_query.of_GetInvoiceType()
	IF	ls_inv_type	=	'MC'		THEN
		// 'MC' queries cannot drilldown onto additional data
		ls_filter	=	"cntl_id <> 'AD'"
		li_rc			=	lds_parm.SetFilter(ls_filter)
		li_rc			=	lds_parm.Filter()
		li_rowcount	=	lds_parm.RowCount()
	END IF
	// FDG 02/15/02 - end
	//02-11-98-2 FNC Start
	if li_rowcount > 0 then
		stars2ca.of_commit()									// FNC 04/15/99
		ls_attrib_1 = trim(lds_parm.object.attrib[1])
		if isnull(ls_attrib_1) then
			ls_attrib_1 = ''
		end if
	end if
	
	if li_rowcount > 1 then 
		ls_attrib_2 = trim(lds_parm.object.attrib[2])
		if isnull(ls_attrib_2) then
			ls_attrib_2 = ''
		end if
	end if
	
	if li_rowcount > 2 then 
		ls_attrib_3 = trim(lds_parm.object.attrib[3])
		if isnull(ls_attrib_3) then
			ls_attrib_3 = ''
		end if
	end if
	if li_rowcount > 3 then 
		ls_attrib_4 = trim(lds_parm.object.attrib[4])
		if isnull(ls_attrib_4) then
			ls_attrib_4 = ''
		end if
	end if
	
	if li_rowcount > 4 then 
		ls_attrib_5 = trim(lds_parm.object.attrib[5])
		if isnull(ls_attrib_5) then
			ls_attrib_5 = ''
		end if
	end if
	
	if li_rowcount > 5 then 
		ls_attrib_6 = trim(lds_parm.object.attrib[6])
		if isnull(ls_attrib_6) then
			ls_attrib_6 = ''
		end if
	end if
	
	if li_rowcount > 6 then 
		ls_attrib_7 = trim(lds_parm.object.attrib[7])
		if isnull(ls_attrib_7) then
			ls_attrib_7 = ''
		end if
	end if
	
	if li_rowcount > 7 then 
		ls_attrib_8 = trim(lds_parm.object.attrib[8])
		if isnull(ls_attrib_8) then
			ls_attrib_8 = ''
		end if
	end if
	
	if li_rowcount > 8 then 
		ls_attrib_9 = trim(lds_parm.object.attrib[9])
		if isnull(ls_attrib_9) then
			ls_attrib_9 = ''
		end if
	end if
	
	if li_rowcount > 9 then 
		ls_attrib_10 = trim(lds_parm.object.attrib[10])
		if isnull(ls_attrib_10) then
			ls_attrib_10 = ''
		end if
	end if
	//02-11-98-2 FNC End
	
	if li_rowcount > 0 then
		im_view.m_menu.m_drilldown.m_1.text = lds_parm.object.label[1]
		//02-11-98-1 FNC
		im_view.m_menu.m_drilldown.m_1.tag = trim(lds_parm.object.cntl_id[1]) + &
			ls_attrib_1																//02-11-98-2 FNC
		im_view.m_menu.m_drilldown.m_1.enabled = TRUE
		im_view.m_menu.m_drilldown.m_1.visible = TRUE
		if li_rowcount > 1 then
			im_view.m_menu.m_drilldown.m_2.text = lds_parm.object.label[2]
			//02-11-98-1 FNC
			im_view.m_menu.m_drilldown.m_2.tag = trim(lds_parm.object.cntl_id[2]) + &
				ls_attrib_2															//02-11-98-2 FNC
			im_view.m_menu.m_drilldown.m_2.enabled = TRUE
			im_view.m_menu.m_drilldown.m_2.visible = TRUE
			if li_rowcount > 2 then	
				im_view.m_menu.m_drilldown.m_3.text = lds_parm.object.label[3]
				//02-11-98-1 FNC
				im_view.m_menu.m_drilldown.m_3.tag = trim(lds_parm.object.cntl_id[3]) + &
					ls_attrib_3														//02-11-98-2 FNC
				im_view.m_menu.m_drilldown.m_3.enabled = TRUE
				im_view.m_menu.m_drilldown.m_3.visible = TRUE
				if li_rowcount > 3 then
					im_view.m_menu.m_drilldown.m_4.text = lds_parm.object.label[4]
					//02-11-98-1 FNC
					im_view.m_menu.m_drilldown.m_4.tag = trim(lds_parm.object.cntl_id[4]) + &
					 ls_attrib_4
					im_view.m_menu.m_drilldown.m_4.enabled = TRUE 
					im_view.m_menu.m_drilldown.m_4.visible = TRUE
					if li_rowcount > 4 then
						im_view.m_menu.m_drilldown.m_5.text = lds_parm.object.label[5]
						//02-11-98-1 FNC
						im_view.m_menu.m_drilldown.m_5.tag = trim(lds_parm.object.cntl_id[5]) + &
						 ls_attrib_5												//02-11-98-2 FNC
						im_view.m_menu.m_drilldown.m_5.enabled = TRUE  
						im_view.m_menu.m_drilldown.m_5.visible = TRUE
					if li_rowcount > 5 then
						im_view.m_menu.m_drilldown.m_6.text = lds_parm.object.label[6]
						//02-11-98-1 FNC
						im_view.m_menu.m_drilldown.m_6.tag = trim(lds_parm.object.cntl_id[6]) + &
						 ls_attrib_6							 //02-11-98-2 FNC
						im_view.m_menu.m_drilldown.m_6.enabled = TRUE 
						im_view.m_menu.m_drilldown.m_6.visible = TRUE
					if li_rowcount > 6 then
						im_view.m_menu.m_drilldown.m_7.text = lds_parm.object.label[7]
						//02-11-98-1 FNC
						im_view.m_menu.m_drilldown.m_7.tag = trim(lds_parm.object.cntl_id[7]) + &
						 ls_attrib_7												//02-11-98-2 FNC
						im_view.m_menu.m_drilldown.m_7.enabled = TRUE 
						im_view.m_menu.m_drilldown.m_7.visible = TRUE
					if li_rowcount > 7 then
						im_view.m_menu.m_drilldown.m_8.text = lds_parm.object.label[8]
						//02-11-98-1 FNC
						im_view.m_menu.m_drilldown.m_8.tag = trim(lds_parm.object.cntl_id[8]) + &
						 ls_attrib_8												//02-11-98-2 FNC
						im_view.m_menu.m_drilldown.m_8.enabled = TRUE 
						im_view.m_menu.m_drilldown.m_8.visible = TRUE
					if li_rowcount > 8 then
						im_view.m_menu.m_drilldown.m_9.text = lds_parm.object.label[9]
						//02-11-98-1 FNC
						im_view.m_menu.m_drilldown.m_9.tag = trim(lds_parm.object.cntl_id[9]) + &
						 ls_attrib_9										 //02-11-98-2 FNC
						 im_view.m_menu.m_drilldown.m_9.enabled = TRUE 
						 im_view.m_menu.m_drilldown.m_9.visible = TRUE
					if li_rowcount > 9 then
						im_view.m_menu.m_drilldown.m_10.text = lds_parm.object.label[10]
						//02-11-98-1 FNC
						im_view.m_menu.m_drilldown.m_10.tag = trim(lds_parm.object.cntl_id[10]) + &
						 ls_attrib_10							 //02-11-98-2 FNC
						im_view.m_menu.m_drilldown.m_10.enabled = TRUE 
						im_view.m_menu.m_drilldown.m_10.visible = TRUE
					end if
					end if
					end if
					end if
					end if
					end if
				end if
			end if
		end if
	end if	
		
END IF

Destroy lds_parm

RETURN 1
end event

event type integer ue_load_query(integer ai_level);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_Load_Query								w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			ai_Level		Integer				The query level to load.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.
//						-1				Error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//	J.Mattis	01/21/98		Moved selecttab to top to prevent null object refs.
//								in load events.
//	J.Mattis	01/22/98		Removed selecttab to correct multi-level load error.
// FNC		12/15/99		Set pd_opt for each level that was loaded.
//	FDG		09/21/01		Stars 4.8.1.  For each level, determine if the data can
//								be changed.
//	GaryR		11/16/04		Track 4115d	STARS Reporting - Claims PDRs
/////////////////////////////////////////////////////////////////////////////

Integer	li_idx
Boolean	lb_disable_update
lb_disable_update	=	This.wf_get_disable_update()

SetPointer(HourGlass!)

this.setredraw(FALSE)

// Set all objects enabled
FOR	li_idx	=	1	TO	ai_level
	iu_query[li_idx].Event	ue_edit_disable_tabs( FALSE )
NEXT

this.wf_LoadQuery(1)

if ai_level > 1 then
	this.wf_LoadQuery(2)
	if ai_level > 2 then
		this.wf_LoadQuery(3)
		if ai_level > 3 then
			this.wf_LoadQuery(4)
			if ai_level > 4 then
				this.wf_LoadQuery(5)
				if ai_level > 5 then
					this.wf_LoadQuery(6)
					if ai_level > 6 then
						this.wf_LoadQuery(7)
						if ai_level > 7 then
							this.wf_LoadQuery(8)
							if ai_level > 8 then
								this.wf_LoadQuery(9)
								if ai_level > 9 then
									this.wf_LoadQuery(10)
									end if 	//level 10
							end if 	//level 9	
						end if	//level 8	
					end if	//level 7
				end if	//level 6
			end if	//level 5
		end if	//level 4
	end if	//level 3
end if	//level 2

iu_active_query.visible = TRUE
iu_active_query.enabled = TRUE

this.setredraw(TRUE)

this.event ue_determine_pd_opt_visibility()		// FNC 12/15/99

// FDG 09/21/01	begin
IF lb_disable_update THEN
	FOR	li_idx	=	1	TO	ai_level
		iu_query[li_idx].Event	ue_edit_disable_tabs( lb_disable_update )
	NEXT
END IF
// FDG 09/21/01

RETURN 1
end event

event ue_set_subset_title;call super::ue_set_subset_title;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_subset_title						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Will set the subset name passed in the window into the title of the window.
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
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

this.title = "Subset: " + is_parm_subset_name

end event

event ue_set_menus_subset_view(boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_menus_subset_view				w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// 
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
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//	FDG		02/09/98		Changed the visible attribute to enabled to
//								avoid a menu conflict with m_stars_30.
//	FDG		05/14/98		Track 1239.  Disable the 'Link' & 'Notes' menu items.
// FNC		05/28/98		Track 1110. Break with totals must be initially disabled
//								because no cols are selected. It will be enabled when the
//								cols are selected.
//	FDG		11/25/98		Track 1990.  The 'Save' menu items also exist
//								under m_report.
//	FDG		09/21/01		Stars 4.8.1.  Pass a parm to this event so that these
//								menu items can be enabled.  Then set the menu items
//								to this parm.  Enable/disable additional items.
//	FDG		12/13/01		Track 2574.  Do not disable the report template library RMM.
//	GaryR		05/28/02		Track 2552d	Predefined Report (PDR)
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

// FDG 09/21/01 - Store whether or not to disable the d/ws on each tab
IF	ab_switch	=	FALSE		THEN
	ib_disable_update	=	TRUE
ELSE
	ib_disable_update	=	FALSE
END IF
// FDG 09/21/01 end
im_pdr.m_menu.m_reset.enabled = ab_switch					//	GaryR	05/28/02	Track 2552d
im_search.m_menu.m_filters.enabled = ab_switch
im_search.m_menu.m_save.enabled = ab_switch
im_search.m_menu.m_link.enabled = ab_switch				// FDG 05/14/98
im_search.m_menu.m_note.enabled = ab_switch				// FDG 05/14/98
im_search.m_menu.m_nextlevel.enabled = ab_switch
im_view.m_menu.m_save.enabled = ab_switch
im_view.m_menu.m_link.enabled = ab_switch					// FDG 05/14/98
im_view.m_menu.m_note.enabled = ab_switch					// FDG 05/14/98
im_view.m_menu.m_nextlevel.enabled = ab_switch
im_view.m_menu.m_drilldown.enabled = ab_switch
im_report.m_menu.m_save.enabled = ab_switch				// FDG 11/25/98

// FDG 09/21/01 new menu items to enable/disable
im_search.m_menu.m_row.enabled = ab_switch
im_search.m_menu.m_clear.enabled = ab_switch
im_search.m_menu.m_removelevel.enabled = ab_switch
im_source.m_menu.m_clear.enabled = ab_switch
im_source.m_menu.m_reset.enabled = ab_switch
im_source.m_menu.m_removelevel.enabled = ab_switch
im_report.m_menu.m_reporttemplatesave.enabled = ab_switch
im_report.m_menu.m_reporttemplatesaveas.enabled = ab_switch
//im_report.m_menu.m_reporttemplatelibrary.enabled = ab_switch		// FDG 12/13/01
im_report.m_menu.m_clear.enabled = ab_switch
im_report.m_menu.m_removelevel.enabled = ab_switch
im_report.m_menu.m_save.enabled = ab_switch
im_view.m_menu.m_removelevel.enabled = ab_switch
// FDG 09/21/01 end


end event

event ue_set_pdq_title();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_pdq_title							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Will set the PDQ description from the case link datawindow and put it into the 
// title of the window. 
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
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		12/09/97		Created.
//
//	FDG			05/14/98		Trach 1240?  Add link_name to the title.
// Lahu S		 2/22/02    Track 2552d Set Query title
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

IF dw_pdq_case_link.RowCount() > 0 THEN
	// Lahu S		 2/22/02    begin
	if istr_parms.query_engine_mode = "PDQ" then
		this.title	=	"PDQ Query: "	+	dw_pdq_case_link.object.link_name[1]	+	&
						" - "	+	dw_pdq_case_link.object.link_desc[1]
	else
		this.title	=	"PDR Query: "	+	dw_pdq_case_link.object.link_name[1]	+	&
						" - "	+	dw_pdq_case_link.object.link_desc[1]
	end if
	// Lahu S		 2/22/02    end 	
END IF
end event

event type integer ue_unload_parms(sx_query_engine_parms astr_parms);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_Unload_parms							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// take data passed into window out of the messageparm and put into the 
// instance variables and datawindows. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//	FDG		01/28/98		Insert a row into d/ws and perform the
//								individual assignments.
//	J.Mattis	02/11/98		Added assignment to sx_subset structure.
// ajs      07/30/98    Stars 4.0 Track #1522 pass period id & period function
//	FDG		07/17/00		Track 2465c. Stars 4.5 SP1.  Allow for FastQuery.
//	GaryR		08/06/04		Track 4049d	Provide drilldown from Subset Summary
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_Range, 		&
			li_idx
Long		ll_row

is_query_id = astr_parms.query_id
is_parm_subset_id = astr_parms.subset_id
is_parm_subset_name = astr_parms.subset_name
is_auth_id = astr_parms.authorization_id
ii_period_key = astr_parms.period_key						//ajs 4.0 07/30/98 Track #1522
is_period_function = astr_parms.period_function			//ajs 4.0 07/30/98 Track #1522
ib_sumbyrev = astr_parms.sumbyrev
ib_pdq_subset = astr_parms.pdq_subset
ii_prefilter_rows = astr_parms.prefilter_rows
is_prefilter_bool = astr_parms.prefilter_bool
is_subset_inv_type = astr_parms.sub_inv_type

IF Trim(astr_parms.subset_id) <> '' AND Not(IsNull(astr_parms.subset_id)) THEN
	// populate the subset structure
	isx_subset.subset_case_id = astr_parms.case_id
	isx_subset.subset_case_spl = astr_parms.case_spl
	isx_subset.subset_case_ver = astr_parms.case_ver
	isx_subset.subset_id = astr_parms.subset_id
	isx_subset.subset_name = astr_parms.subset_name
END IF

//NOTE: If d_pdq_tables or sx_pdq_tables changes columns the other object MUST change
//			or this assignment will fail.
li_Range = UpperBound(astr_parms.tables)
FOR li_idx = 1 TO li_Range
	ll_row	=	dw_pdq_tables.InsertRow(0)
	dw_pdq_tables.object.query_id [ll_row]					=	astr_parms.tables[li_idx].query_id 
	dw_pdq_tables.object.level_num [ll_row]				=	astr_parms.tables[li_idx].level_num 
	dw_pdq_tables.object.tbl_type [ll_row]					=	astr_parms.tables[li_idx].tbl_type 
	dw_pdq_tables.object.tbl_rel [ll_row]					=	astr_parms.tables[li_idx].tbl_rel 
	dw_pdq_tables.object.src_type [ll_row]					=	astr_parms.tables[li_idx].src_type 
	dw_pdq_tables.object.src_case_id [ll_row]				=	astr_parms.tables[li_idx].src_case_id 
	dw_pdq_tables.object.src_case_spl [ll_row]			=	astr_parms.tables[li_idx].src_case_spl 
	dw_pdq_tables.object.src_case_ver [ll_row]			=	astr_parms.tables[li_idx].src_case_ver 
	dw_pdq_tables.object.src_subset_name [ll_row]		=	astr_parms.tables[li_idx].src_subset_name 
	dw_pdq_tables.object.rpt_title [ll_row]				=	astr_parms.tables[li_idx].rpt_title
	//dw_pdq_tables.Object.Data[ll_row] = astr_parms.tables[li_idx]	// FDG 01/28/98
	// FDG 07/17/00 begin
	dw_pdq_tables.object.fastquery_ind [ll_row]			=	astr_parms.tables[li_idx].fastquery_ind
	dw_pdq_tables.object.fastquery_rows [ll_row]			=	astr_parms.tables[li_idx].fastquery_rows
	dw_pdq_tables.object.payment_date_options [ll_row]	=	astr_parms.tables[li_idx].payment_date_options
	// FDG 07/17/00 end
NEXT

//NOTE: If d_pdq_criteria or sx_pdq_criteria changes columns the other object MUST change
//			or this assignment will fail.
li_Range = UpperBound(astr_parms.criteria)
FOR li_idx = 1 TO li_Range
	ll_row	=	dw_pdq_criteria.InsertRow(0)
	dw_pdq_criteria.Object.query_id [ll_row] 		= astr_parms.criteria[li_idx].query_id 
	dw_pdq_criteria.Object.level_num [ll_row] 	= astr_parms.criteria[li_idx].level_num 
	dw_pdq_criteria.Object.seq_num [ll_row] 		= astr_parms.criteria[li_idx].seq_num 
	dw_pdq_criteria.Object.tbl_type [ll_row] 		= astr_parms.criteria[li_idx].tbl_type 
	dw_pdq_criteria.Object.left_paren [ll_row] 	= astr_parms.criteria[li_idx].left_paren 
	dw_pdq_criteria.Object.col_name [ll_row] 		= astr_parms.criteria[li_idx].col_name 
	dw_pdq_criteria.Object.rel_op [ll_row] 		= astr_parms.criteria[li_idx].rel_op 
	dw_pdq_criteria.Object.col_value [ll_row] 	= astr_parms.criteria[li_idx].col_value 
	dw_pdq_criteria.Object.right_paren [ll_row]	= astr_parms.criteria[li_idx].right_paren 
	dw_pdq_criteria.Object.logic_op [ll_row]		= astr_parms.criteria[li_idx].logic_op 
	//dw_pdq_criteria.Object.Data[ll_row] = astr_parms.criteria[li_idx]	// FDG 01/28/98
NEXT

RETURN 1

end event

event ue_register_level;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_register_level							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			ai_NewLevel	Integer			The new level.
//		Value			ai_OldLevel	Integer			The old level.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.			
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		12/09/97		Created.
//	J.Mattis		01/22/98		Added call to of_SetLevelFilter to filter the PDQ dws.
//	FDG			03/16/98		Track 918.  Get the upperbound of iu_query thru
//									function wf_get_max_uo_query().
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

if ai_NewLevel > wf_get_max_uo_query() then 
	RETURN -1
end if

this.setredraw(FALSE)

if isvalid(iu_active_query) then
	iu_active_query.visible = FALSE
	iu_active_query.enabled = FALSE
end if

//assign the active query
iu_active_query = iu_query[ai_NewLevel]

iu_active_query.visible = TRUE
iu_active_query.enabled = TRUE
ii_level_num = ai_NewLevel

//If NOT(this.ib_initiallevel) Then
//check for initial selection of default selected tabpage
If ai_OldLevel <> -1 Then
	this.wf_SetLevelFilter(ai_NewLevel,'ALL')
End If

this.setredraw(TRUE)

RETURN 1
end event

event type integer ue_set_menus_query_select(boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_menus_query_select				w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by cb_select.clicked event to make Notes and Link visible on
// the List Menu once a query has been selected from the list.  Note: See tech spec ts144 -
// Menu Visibility for details. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			ab_switch	Boolean		TRUE = enable, FALSE = disable
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//
//	FDG		02/09/98		Changed the visible attribute to enabled to
//								avoid a menu conflict with m_stars_30.
//	J.Mattis	02/19/98		Changed menu attributes in painter to make ALL
//								menu items visible. 
//	FDG		04/22/98		Track 1104.  ab_switch is passed to this event to
//								enable/disable the menu item.
//	FDG		05/15/98		Track 1241?  Set/reset the reset menu item.
//
// FNC		07/08/98		Track 1218. Disable drilldown for ML querries.
// FDG		09/21/01		Stars 4.8.1.  Don't enable if the associated case is
//								closed or deleted
//	GaryR		09/13/06		Track 4601	Do not execute PDQ specific script in PDR mode.
/////////////////////////////////////////////////////////////////////////////
integer li_level_num

SetPointer(HourGlass!)

IF	IsNull (ab_switch)		THEN
	Return -1
END IF

// FDG 09/21/01 begin
IF	ib_disable_update		THEN
ELSE
	im_search.m_menu.m_link.enabled	=	ab_switch
	im_view.m_menu.m_link.enabled		=	ab_switch
	im_search.m_menu.m_note.enabled	=	ab_switch
	im_view.m_menu.m_note.enabled		=	ab_switch
	im_source.m_menu.m_reset.enabled	=	ab_switch		// FDG 05/15/98

	IF This.of_is_pdr_mode() THEN Return 1

	// FNC 07/08/98 Start
	li_level_num = This.event ue_get_level_num()
	if li_level_num > 1 then
		im_view.m_menu.m_drilldown.enabled = FALSE
	else
		im_view.m_menu.m_drilldown.enabled = TRUE
	end if
	// FNC 07/08/98 End	
END IF
// FDG 09/21/01 end

Return 1
end event

event ue_enable_next_button(boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_enable_next_button					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by cb_select.clicked and uo_query.ue_new_query() to enable
// the Next button on the window.	 
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
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//
//	FDG		05/12/98		Track 1223.  cb_next is now on each tabpage.
//
//	FDG		12/04/98		Track 2004.  Pass a true/false argument to
//								ue_enable_next_button.
//
//	GaryR		04/17/02		Track 2552d	Predefined Reports (PDR)
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

CHOOSE CASE iu_active_query.SelectedTab
	CASE IC_LIST
		iu_active_query.tabpage_list.cb_next_list.enabled		=	ab_switch
	CASE IC_PDR			//	04/17/02	GaryR	Track 2552d
		iu_active_query.tabpage_pdr.cb_next_pdr.enabled		=	ab_switch	
	CASE IC_SOURCE
		iu_active_query.tabpage_source.cb_next_source.enabled	=	ab_switch
	CASE IC_SEARCH
		iu_active_query.tabpage_search.cb_next_search.enabled	=	ab_switch
	CASE IC_REPORT
		iu_active_query.tabpage_report.cb_next_report.enabled	=	ab_switch
END CHOOSE



//this.cb_next.enabled = ab_switch

end event

event type integer ue_load_pdq_dws(string as_query_id, string as_userid, string as_case_id, string as_case_spl, string as_case_ver);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_load_pdq_dws							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Will use query id passed in to retrieve the pdq invisible datawindows.  
// This is called in uo_query when query is selected from the tabpage_list. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			as_query_id	String				The query id.
//		Value			as_userid	String				The user id.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.
//						-1				DB error.
//						-2				no pdq for that query_id
//						-3				no pdq for that query_id
//						-4				no tables for that pdq
//						-5				no criteria for the pdq
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//	J.Mattis	01/21/98		Added call to ue_clear_pdq_datawindows() to clear residual
//								data prior to retrieve.
//	FDG		03/26/98		Track 982.  Always clears these d/ws before 
//								retrieving.
//	FDG		03/27/98		Track 984.  Reset all the pdq filters before retrieving.
// FNC		04/15/99		FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//								to prevent locking.
//	FDG		04/16/01		Stars 4.7.	Properly trim the data.
// LahuS     2/21/02		Track 2552d Additional parameter, link_type, for dw_pdq_case_link
//	GaryR		11/16/04		Track 4115d	STARS Reporting - Claims PDRs
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_sql
Int 	li_rowcount,	li_rc
string	ls_link_type	//Lahu S 2/21/02

dw_pdq_case_link.SetTransObject(stars2ca)

//	Reset the PDQ filters (set when changing tabs) before re-retrieving
This.wf_setlevelfilter(0, 'ALL')

this.Event ue_clear_pdq_datawindows()

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (as_query_id)
li_rc	=	gnv_sql.of_TrimData (as_userid)
li_rc	=	gnv_sql.of_TrimData (as_case_id)
li_rc	=	gnv_sql.of_TrimData (as_case_spl)
li_rc	=	gnv_sql.of_TrimData (as_case_ver)
// FDG 04/16/01 end

//Lahu S 2/21/02 Begin
if istr_parms.query_engine_mode = "PDQ" then
	ls_link_type = "PDQ"	
else
	ls_link_type = "PDR"
end if
//Lahu S 2/21/02 end

li_rowcount = dw_pdq_case_link.retrieve(as_query_id,as_userid, as_case_id,as_case_spl,as_case_ver, ls_link_type)

if li_rowcount <> 1 then
	if li_rowcount = 0 then
		//error - no pdq for that query_id  /* should be impossible */
		MessageBox("Error","No case_link pdq/pdr for selected query id.",StopSign!)
		return -2
	else
		//error - database error
		MessageBox("Error","Error retrieving case link record.",StopSign!)
		return -1	
	end if
else													// FNC 04/15/99
	stars2ca.of_commit()							// FNC 04/15/99
end if

li_rowcount = dw_pdq_cntl.retrieve(as_query_id)

if li_rowcount <> 1 then
	if li_rowcount = 0 then
		//error - no pdq for that query_id  /* should be impossible */
		MessageBox("Error","No pdq/pdr for selected query id.",StopSign!)
		return -3
	else
		//error - database error
		return -1	
	end if
else													// FNC 04/15/99
	stars2ca.of_commit()							// FNC 04/15/99
end if

li_rowcount = dw_pdq_tables.retrieve(as_query_id)

if li_rowcount < 1 then
	if li_rowcount = 0 then
		//error - no tables for selected pdq /* should be impossible */
		MessageBox("Error","No tables for selected pdq/pdr.",StopSign!)  
		return -4
	else
		//error - database error
		return -1
	end if
else													// FNC 04/15/99
	stars2ca.of_commit()							// FNC 04/15/99
end if

li_rowcount = dw_pdq_criteria.retrieve(as_query_id)

if li_rowcount < 1 then
	if li_rowcount = 0 then
		//error - no criteria for that pdq  /* should be impossible */
		return -5
	else
		//error - database error
		return -1
	end if
else													// FNC 04/15/99
	stars2ca.of_commit()							// FNC 04/15/99
end if

// Retrieve pdr_sources
IF This.of_is_pdr_mode() THEN
	li_rowcount = dw_pdr_sources.retrieve( Double( as_query_id ) )
	
	if li_rowcount < 1 then
		// error - database error
		return -1
	else
		stars2ca.of_commit()
	end if
END IF

li_rowcount = dw_pdq_columns.retrieve(as_query_id)

if li_rowcount < 1 then
	// error - database error
	return -1
else													// FNC 04/15/99
	stars2ca.of_commit()							// FNC 04/15/99
end if

RETURN 1
end event

event ue_get_level_num;call super::ue_get_level_num;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_get_level_num							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// will get and return the max level number from dw_pdq_tables
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		[1 - 10]		Success. The level number.
//						-1				Data or DB error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
// F.Chernak	01/14/98		Add tbl_rel to sort so that GP records are listed
//									before DP records. This will allow UE_Tabpage_Source_Load
//									to process correctly.
//	J.Mattis		12/10/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

/* sort dw by level_num and select largest level_num if it is > 1 then 
multi-level */
 
this.dw_pdq_tables.setsort("level_num D, tbl_rel D")		//01-14-98 FNC
this.dw_pdq_tables.sort()

if this.dw_pdq_tables.rowcount() > 0 then
	return(this.dw_pdq_tables.object.level_num[1])
else
	return -1
end if
end event

event ue_show_levels;call super::ue_show_levels;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_show_levels								w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Depending on the number of levels, will make that many tabpages visible and open 
// that many query engine user objects.  This must be hardcoded as follows since the 
// tabpages cannot be dynamically referenced (must use their actual name). 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			ai_level		Integer				the level to show.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1 				Success.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date		Description
// ------		----		-----------
//	J.Mattis		12/10/97	Created.
//	J.Mattis		01/26/98	Added code to destroy previous levels > 1.
//	FDG			02/24/98	Open uo_query via a script instead of
//								openuserobjectwithparm & ue_tabpage_source_construct
//	J.Mattis		02/25/98	Added code to select the report tabpage on each query level > 1.
//	FDG			03/02/98	Track 876 - Enable tabs via ue_selecttab event.
/////////////////////////////////////////////////////////////////////////////

sx_drilldown_parms	lstr_drilldown_parms

SetPointer(HourGlass!)

Integer		li_rc

this.wf_ClearLevels()

if ai_level > 1 then
	//set the coordinates of uo_Query
	this.wf_SetUoPos()
	tab_level.tabpage_2.visible = TRUE
	tab_level.tabpage_2.enabled = TRUE
	li_rc	=	This.Event	ue_open_uo_query (iu_query[2], lstr_drilldown_parms, '')	// FDG 02/24/98
	//this.openuserobjectwithparm(iu_query[2],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
	//iu_query[2].Event ue_tabpage_source_construct('','')
	iu_active_query = iu_query[2]
	// select the report tab
	iu_active_query.Event ue_SelectTab(ic_report)
	iu_active_query.visible = FALSE  /* only want last one to be visible */
	iu_active_query.enabled = FALSE     
	if ai_level > 2 then
		tab_level.tabpage_3.visible = TRUE
		tab_level.tabpage_3.enabled = TRUE
		li_rc	=	This.Event	ue_open_uo_query (iu_query[3], lstr_drilldown_parms, '')	// FDG 02/24/98
		//this.openuserobjectwithparm(iu_query[3],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
		//iu_query[3].Event ue_tabpage_source_construct('','')
		iu_active_query = iu_query[3]
		// select the report tab
		iu_active_query.Event ue_SelectTab(ic_report)
		iu_active_query.visible = FALSE
		iu_active_query.enabled = FALSE
		if ai_level > 3 then
			tab_level.tabpage_4.visible = TRUE
			tab_level.tabpage_4.enabled = TRUE
			li_rc	=	This.Event	ue_open_uo_query (iu_query[4], lstr_drilldown_parms, '')	// FDG 02/24/98
			//this.openuserobjectwithparm(iu_query[4],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
			//iu_query[4].Event ue_tabpage_source_construct('','')
			iu_active_query = iu_query[4]
			// select the report tab
			iu_active_query.Event ue_SelectTab(ic_report)
			iu_active_query.visible = FALSE
			iu_active_query.enabled = FALSE
			if ai_level > 4 then
				tab_level.tabpage_5.visible = TRUE
				tab_level.tabpage_5.enabled = TRUE
				li_rc	=	This.Event	ue_open_uo_query (iu_query[5], lstr_drilldown_parms, '')	// FDG 02/24/98
				//this.openuserobjectwithparm(iu_query[5],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
				//iu_query[5].Event ue_tabpage_source_construct('','')
				iu_active_query = iu_query[5]
				// select the report tab
				iu_active_query.Event ue_SelectTab(ic_report)
				iu_active_query.visible = FALSE
				iu_active_query.enabled = FALSE
				if ai_level > 5 then
					tab_level.tabpage_6.visible = TRUE
					tab_level.tabpage_6.enabled = TRUE
					li_rc	=	This.Event	ue_open_uo_query (iu_query[6], lstr_drilldown_parms, '')	// FDG 02/24/98
					//this.openuserobjectwithparm(iu_query[6],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
					//iu_query[6].Event ue_tabpage_source_construct('','')
					iu_active_query = iu_query[6]
					// select the report tab
					iu_active_query.Event ue_SelectTab(ic_report)
					iu_active_query.visible = FALSE
					iu_active_query.enabled = FALSE
					if ai_level > 6 then
						tab_level.tabpage_7.visible = TRUE
						tab_level.tabpage_7.enabled = TRUE
						li_rc	=	This.Event	ue_open_uo_query (iu_query[7], lstr_drilldown_parms, '')	// FDG 02/24/98
						//this.openuserobjectwithparm(iu_query[7],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
						//iu_query[7].Event ue_tabpage_source_construct('','')
						iu_active_query = iu_query[7]
						// select the report tab
						iu_active_query.Event ue_SelectTab(ic_report)
						iu_active_query.visible = FALSE
						iu_active_query.enabled = FALSE
						if ai_level > 7 then
							tab_level.tabpage_8.visible = TRUE
							tab_level.tabpage_8.enabled = TRUE
							li_rc	=	This.Event	ue_open_uo_query (iu_query[8], lstr_drilldown_parms, '')	// FDG 02/24/98
							//this.openuserobjectwithparm(iu_query[8],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
							//iu_query[8].Event ue_tabpage_source_construct('','')
							iu_active_query = iu_query[8]
							// select the report tab
							iu_active_query.Event ue_SelectTab(ic_report)
							iu_active_query.visible = FALSE
							iu_active_query.enabled = FALSE
							if ai_level > 8 then
								tab_level.tabpage_9.visible = TRUE
								tab_level.tabpage_9.enabled = TRUE
								li_rc	=	This.Event	ue_open_uo_query (iu_query[9], lstr_drilldown_parms, '')	// FDG 02/24/98
								//this.openuserobjectwithparm(iu_query[9],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
								//iu_query[9].Event ue_tabpage_source_construct('','')
								iu_active_query = iu_query[9]
								// select the report tab
								iu_active_query.Event ue_SelectTab(ic_report)
								iu_active_query.visible = FALSE
								iu_active_query.enabled = FALSE
								if ai_level > 9 then
									tab_level.tabpage_10.visible = TRUE
									tab_level.tabpage_10.enabled = TRUE
									li_rc	=	This.Event	ue_open_uo_query (iu_query[10], lstr_drilldown_parms, '')	// FDG 02/24/98
									//this.openuserobjectwithparm(iu_query[10],lsx_drilldown_parms,IIX_Pos,IIY_Pos)
									//iu_query[10].Event ue_tabpage_source_construct('','')
									iu_active_query = iu_query[10]
									// select the report tab
									iu_active_query.Event ue_SelectTab(ic_report)
									iu_active_query.visible = FALSE
									iu_active_query.enabled = FALSE
								end if	//level 9
							end if	//level 8
						end if	//level 7
					end if	//level 6
				end if	//level 5
			end if	//level 4
		end if	//level 3
	end if	//level 2
end if	//level 1

//resize uo_Query
this.wf_ResizeUo(ai_level)

iu_active_query.visible = TRUE
iu_active_query.enabled = TRUE

RETURN 1
end event

event ue_new_level;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_New_level								w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will create a new level.  It is called by the Next Level menu item on 
// Search By and View tabs.  First it must determine which is the next level 
// (next invisible tabpage on tab_level) then create a uo_query for that level and set 
// it's tabpage_list to be disabled.  Then select the tab_level tabpage to trigger the 
// selectionchanged event which will make it the active level and will make the previous 
// uo_query invisible and make the new one visible.  Also will register the pdq tables 
// in the new uo_query.  Finally clear out the title bar and set the right mouse menus. 
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
//	J.Mattis			12/10/97		Created.
//	FNC				12/15/99		Set payment dates for new level based on 
//										payment date option on previous level
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

this.wf_SetUoPos()

if not tab_level.tabpage_1.visible then /* should never happen */
	tab_level.tabpage_1.visible = TRUE
	tab_level.tabpage_1.enabled = TRUE
	this.wf_NewLevel(1)
elseif not tab_level.tabpage_2.visible then
	tab_level.tabpage_2.visible = TRUE
	tab_level.tabpage_2.enabled = TRUE
	this.wf_NewLevel(2)
elseif not tab_level.tabpage_3.visible then
	tab_level.tabpage_3.visible = TRUE
	tab_level.tabpage_3.enabled = TRUE
	this.wf_NewLevel(3)
elseif not tab_level.tabpage_4.visible then 
	tab_level.tabpage_4.visible = TRUE
	tab_level.tabpage_4.enabled = TRUE
	this.wf_NewLevel(4)
elseif not tab_level.tabpage_5.visible then
	tab_level.tabpage_5.visible = TRUE
	tab_level.tabpage_5.enabled = TRUE
	this.wf_NewLevel(5)
elseif not tab_level.tabpage_6.visible then
	tab_level.tabpage_6.visible = TRUE
	tab_level.tabpage_6.enabled = TRUE
	this.wf_NewLevel(6)
elseif not tab_level.tabpage_7.visible then 
	tab_level.tabpage_7.visible = TRUE
	tab_level.tabpage_7.enabled = TRUE
	this.wf_NewLevel(7)
elseif not tab_level.tabpage_8.visible then
	tab_level.tabpage_8.visible = TRUE
	tab_level.tabpage_8.enabled = TRUE
	this.wf_NewLevel(8)
elseif not tab_level.tabpage_9.visible then
	tab_level.tabpage_9.visible = TRUE
	tab_level.tabpage_9.enabled = TRUE
	this.wf_NewLevel(9)
elseif not tab_level.tabpage_10.visible then
	tab_level.tabpage_10.visible = TRUE
	tab_level.tabpage_10.enabled = TRUE
	this.wf_NewLevel(10)
else
	/* should never happen */
	MessageBox("Error","Max. number of levels is 10.",StopSign!)
end if

this.event ue_set_menus_new_level()

this.event ue_determine_pd_opt_visibility()		// FNC 12/15/99
end event

event ue_set_menus_report;/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
// --------------						------				
// ue_set_menus						w_Query_engine
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event will be called by tabpage_report.ue_tabpage_report_add() to turn on the report 
// menu items when columns are selected for the report and 
// tabpage_report.ue_tabpage_report_remove() to turn off the menu items when no columns are
// selected. Break with Totals is only visible if subset view with single invoice type.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument		Datatype		Description
//	---------	--------		--------		-----------
//	Value			ab_visible	Boolean		The menu item's visible property.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/24/97		Created.
//
//	FDG		02/09/98		Changed the visible attribute to enabled to
//								avoid a menu conflict with m_stars_30.
//	FDG		09/25/98		Track 1827.  Remove Export & Crystal Reports from
//								m_report.
//	FDG		01/27/99		Track 2083c.  If in drilldown mode, do not enable
//								the report template save menu items.
// FNC		10/08/01		Track 2444 Starsdev. Enable break with totals for ML queries.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

// FDG 01/27/99 begin
//im_report.m_menu.m_reporttemplatesave.enabled = ab_visible
//im_report.m_menu.m_reporttemplatesaveas.enabled = ab_visible

Boolean	lb_drilldown

lb_drilldown	=	iu_active_query.of_get_ib_drilldown()

IF	NOT	lb_drilldown		THEN
	im_report.m_menu.m_reporttemplatesave.enabled	=	ab_visible
	im_report.m_menu.m_reporttemplatesaveas.enabled	=	ab_visible
END IF

// FDG 01/27/99 end

//im_report.m_menu.m_crystalreports.enabled = ab_visible			// FDG 09/25/98
//im_report.m_menu.m_exportreports.enabled = ab_visible			// FDG 09/25/98

im_report.m_menu.m_breakwithtotals.enabled = ab_visible						//FNC 10/8/01

//RETURN this.event ue_set_menus_subset_view_break_w_totals(ab_visible)	//FNC 10/8/01
RETURN 1																			//FNC 10/8/01

end event

event type integer ue_save_query(string as_path);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_save_query								w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by the Query Save (S), 
//	Query Save As (A) and Link (L) menu 
// items on the tabpage right mouse menus to open 
//	the Query Save window and save a criteria.
// First it will open the window to get the user 
//	information, then get the criteria from 
// the uo_querys and put into the invisible pdq 
//	datawindows  and save the info to the pdq 
// tables (including the claim_link table). 
//	Note: the reason the event is in the window and
// not the user object is that it is opening a 
//	response windows.  Since there are memory 
// problems with PB I thought it would be cleaner 
//	to have the response window a child of
// the window and not the user object.  This goes 
//	for all windows opened from Query Engine 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			as_path		String		The calling 'path.'
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value		Description
//		--------		-----		-----------
//		Integer		1			Success.
//						-1			Failure in ue_tabpage_list_query_save_info event. 
//						-2			Failure or Cancel in w_query_save. 
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/08/97	Created.
//	J.Mattis	01/21/98	Moved call to w_query_engine's ue_clear_pdq_datawindows to 
//							uo_Query's ue_new_query event, and to w_query_engine's 
//							ue_load_pdq_dws event. this will prevent SQL insert when
//							an update is needed.
//	J.Mattis	02/02/98	Added guard to call to ue_Save event due to closequery 
//							processing.
//	J.Mattis	02/03/98	Added 'X' suffix logic to as_Path argument to prevent 
//							recursive call to ue_Save event. 
//	J.Mattis	02/18/98	1 - Added code to prevent non updateable dws on uo_query 
// 						from being updated during ue_save process. 
//							2 - Added code to prevent non updateable dws from 
//							triggering updates pending logic.
//	J.Mattis	02/20/98	Added code to prevent Save As from updating previous 
//							data.
// FNC		02/26/98	Track 867
//							Accept criteria datawindow before creating subset
//	FDG		03/16/98	Track 918.  Get the upperbound of iu_query thru
//							function wf_get_max_uo_query().
//	FDG		03/25/98	Track 981.  When saving an existing PDQ, trigger a new
//							event to delete all levels from dw_pdq_columns,
//							dw_pdq_tables, dw_pdq_criteria.  This is needed in case
//							a level was removed or the user saved the same query
//							twice.
//	FDG		04/02/98	Track 1003. Reset the flag stating if a row in dw_criteria has
//							been deleted (upon a successful save).
//	FDG		04/02/98	Track 959.  If there is only one invoice type, add the 
//							description to query type.
//	FDG		04/22/98	Track 1104. Enable the notes & link menu items.
// FNC		07/14/98	Track 1151. Do not open Query save window if query is being
//							linked.
// FNC		07/14/98	Track 1264. Do not delete pdq data if performing a link. 
//							Reset new flag to false after query is saved. It is no longer
//							new once it is saved.
// FNC		07/28/98	Track 1264. Delete existing PDQ data for links as well as
//							saves because later in the script it will be saved. This way
//							link and save the newest version in case it was changed.
//	NLG		07/28/98	Track #1153. If link or save as, notes must accompany
//							independent pdqs.
//	NLG		08/25/98	ts144 Report On enhancements.
//	NLG		11/17/98	If not saving pdq columns because used default template, don't
//							clear report title (added argument to ue_tabpage_report_clear()
//	FDG		04/11/01	Stars 4.7 (Track 3325).	Do not allow a Link if there is no active case.
//	GaryR		04/26/02	Track 2552d	Predefined Report (PDR)
//	GaryR		06/14/02	Track 3142d	Enter log when saving/linking PDQ
//	GaryR		09/04/02	Track 3273d	Prevent saving duplicate link names
// JasonS   10/17/02 Track 2883d Added trim to if statement so notes are copied
//	GaryR		02/27/03	Track 3455d	Check for duplicate case link entry
//	GaryR		05/07/03	Track 3553d	Do not default PDR description for Save
//	GaryR		05/10/04	Track 3756d	Streamline PDR deployment & security
//	GaryR		10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR		11/16/04	Track 4115d	STARS Reporting - Claims PDRs
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

// get info for Query Save window 
sx_query_save lsx_query_save  // defined in ts144 - w_query_save 
lsx_query_save.path = as_path

Integer 	li_max_level,		&
			li_idx, 				&
			li_Return = 1,		&
			li_rc
String	ls_query_type

//NLG 7-28-98 Notes variables
string 	ls_note_case_id_new, &
			ls_note_rel_id,		&
			ls_note_case_id_orig,&
			ls_note_rel_id_orig,	&
			ls_case_id_orig
			
String	ls_message								//	GaryR		06/14/02	Track 3142d		
			
sx_pdr_parms	lsx_pdr_parms					//	GaryR		04/26/02	Track 2552d

li_max_level = wf_get_max_uo_query()		// FDG 03/16/98

//02-28-98 FNC Start
if this.event ue_accepttext(this.control, FALSE) < 0 then
	messagebox('ERROR','Error processing criteria. Cannot save.')		// FDG 04/21/98
	return -1
end if
//02-28-98 FNC End

if Left(as_path,1) = 'S' or Left(as_path,1) = 'L' then
	/* the list tabpage is only visible on 1st uo_query */
	If li_max_level > 0 Then 
		// Determine what data is to be filled into lsx_query_save
		li_rc	=	iu_query[1].event ue_tabpage_list_query_save_info(lsx_query_save)
		if li_rc < 0 then 
			return -1
		end if
	End If
end if

for li_idx = 1 to li_max_level 	//IC_MAX_LEVELS /* loop thru uo_querys to get invoice_types */
	if not isvalid(iu_query[li_idx]) then /* loop until no more */
		li_max_level = li_idx - 1
		exit
	end if
	ls_query_type = ls_query_type + "," + iu_query[li_idx].event ue_tabpage_source_get_inv_type()
next

lsx_query_save.query_type = Trim (mid(ls_query_type,2)) /* get rid of that comma */

// FDG 04/02/98 track 959 begin
IF	Len (lsx_query_save.query_type)	=	2		THEN
	// Only one invoice type. Append its description.
	//	GaryR	04/26/02	Track 2552d
	IF NOT This.of_is_pdr_mode() THEN &
		lsx_query_save.query_type	=	iu_active_query.is_inv_description
ELSE
	// Multiple invoice types
	lsx_query_save.query_type	=	'ML - Multi-level (' + lsx_query_save.query_type + ')'
END IF
// FDG 04/02/98 end

// FNC 07/14/98 Start
if Left(lsx_query_save.path,1) <> 'L' then
	//NLG Track #1153 																		START***
	//save the query name for when we check if any notes are attached
	if Left(lsx_query_save.path,1) = 'A' then	
		long ll_rowcount								//nlg Track #1566
		ll_rowcount	=	dw_pdq_cntl.RowCount()	//nlg Track #1566 
		IF	ll_rowcount	> 0		THEN				//nlg Track #1566 (if saving existing query...)
			ls_case_id_orig = dw_pdq_case_link.object.case_id[1] + dw_pdq_case_link.object.case_spl[1] +&
								dw_pdq_case_link.object.case_ver[1]
			ls_note_case_id_orig = ls_case_id_orig	
			// JasonS 10/17/02 Track 2883d added trim to if statement below
			if Trim(ls_note_case_id_orig) = 'NONE' then//only independent pdq's carry notes over
				ls_note_rel_id_orig = dw_pdq_case_link.object.link_name[1]	
			end if
		end if											//nlg Track #1566
	end if
	//NLG Track #1153 																		STOP***
	
	lsx_query_save.link_type = "PDQ"
	
	//	GaryR		04/26/02	Track 2552d - Begin
	// Initialize the Query Description field	
	IF This.of_is_pdr_mode() THEN
		lsx_query_save.link_type = "PDR"
	END IF
	//	GaryR		04/26/02	Track 2552d - End

	openwithparm(w_query_save,lsx_query_save)
	lsx_query_save = message.powerobjectparm
	
	//NLG Track #1153 																		START***
	ls_note_case_id_new = lsx_query_save.case_id	
	if ls_note_case_id_new = 'NONE' then
		ls_note_rel_id = lsx_query_save.query_name
	else
		ls_note_rel_id = lsx_query_save.case_id
	end if
	//NLG Track #1153 																		STOP***
	
	//	GaryR		06/14/02	Track 3142d - Begin
	IF This.of_is_pdr_mode() THEN
		ls_message		=	"PDR "	+	lsx_query_save.query_name	+	" saved to case."
	ELSE
		ls_message		=	"PDQ "	+	lsx_query_save.query_name	+	" saved to case."
	END IF
	//	GaryR		06/14/02	Track 3142d - End
else
	// Linking a case
	// FDG 04/11/01 (Track 3325) - If there is no active case, display an error message.
	IF	IsNull(gv_active_case)				&
	OR	Trim (gv_active_case)	<	' '	THEN
		Stars2ca.of_rollback()
		MessageBox ('Error', 'There is no active case to link the query to.')
		Return	-1
	ELSE
		lsx_query_save.case_id = gv_active_case
		ls_note_rel_id = gv_active_case	
	END IF

	// FDG 04/11/01
	//NLG Track #1153 																		START***
	ls_note_case_id_new = lsx_query_save.case_id	
	ls_note_case_id_orig = 'NONE'		
	ls_note_rel_id_orig = dw_pdq_case_link.object.link_name[1]
	//NLG Track #1153 																		STOP***
	
	//	GaryR		06/14/02	Track 3142d - Begin
	IF This.of_is_pdr_mode() THEN
		ls_message		=	"PDR "	+	dw_pdq_case_link.object.link_name[1]	+	" linked to case."
	ELSE
		ls_message		=	"PDQ "	+	dw_pdq_case_link.object.link_name[1]	+	" linked to case."
	END IF
	//	GaryR		06/14/02	Track 3142d - End
end if																
// FNC 07/14/98 End

If IsValid(lsx_query_save) Then
	if Upper(String(lsx_query_save.path)) = 'N' then 
		// Query save either Canceled of failed.
		w_main.SetMicroHelp ('Ready')
		return -2
	elseif Upper(String(left(lsx_query_save.path,1))) = 'A' then
		// MUST clear save datawindows so previous data will not be updated
		this.Event ue_clear_pdq_datawindows()
	else																				// FNC  07/28/98
		// Saving a query or saving a link.  Delete the existing
		// data from dw_pdq_columns, dw_pdq_tables, and
		// dw_pdq_criteria
		This.Event ue_delete_pdq_data (lsx_query_save.query_id)		// FDG 03/25/98
	end if
	
	/* NLG 8-25-98 ts144.  Before saving pdq cntl info, determine if used default template.  
		Then determine if user wants to save the default columns with the rest of the query. */
	if iu_active_query.of_get_ib_load_template() = true then
		boolean lb_keep_title=true
		li_rc = MessageBox('Query Save','Report produced using default template columns. '+&
										'~rDo you want to save the columns with the query?',Question!,YesNoCancel!)
		if li_rc = 2 then
			iu_active_query.event ue_tabpage_report_clear(lb_keep_title)
		end if
		
		iu_active_query.of_set_ib_load_template(FALSE)
	end if 
	
	//this.event ue_clear_pdq_datawindows()
	
	//	GaryR	09/04/02	Track 3273d - Begin
	//this.event ue_save_cntl_pdq(lsx_query_save)
	IF Event ue_save_cntl_pdq(lsx_query_save) < 0 THEN
		this.Event ue_clear_pdq_datawindows()
		Return -1
	END IF
	//	GaryR	09/04/02	Track 3273d - End

	for li_idx = 1 to li_max_level
		// assign user keyed datawindows to PDQ datawindows
		iu_query[li_idx].event ue_tabpage_source_save(li_idx,lsx_query_save.query_id)
		iu_query[li_idx].event ue_tabpage_search_save(li_idx,lsx_query_save.query_id)
		iu_query[li_idx].event ue_tabpage_report_save(li_idx,lsx_query_save.query_id)
		
		IF This.of_is_pdr_mode() THEN
			This.of_get_pdr_parm( lsx_pdr_parms )
			IF lsx_pdr_parms.pdr_source > 0 THEN iu_query[li_idx].event ue_tabpage_pdr_save(li_idx,lsx_query_save.query_id)
		END IF
	next
	
End If

//	GaryR		06/14/02	Track 3142d - Begin
IF Upper( lsx_query_save.path ) = 'A' OR Upper( lsx_query_save.path ) = 'L' THEN
	n_cst_case		lnv_case
	lnv_case	=	CREATE	n_cst_case
	li_rc			=	lnv_case.uf_audit_log ( lsx_query_save.case_id, ls_message )
	
	Destroy	lnv_case

	//	Validate method processing
	IF	li_rc		<	0		THEN
		Stars2ca.of_rollback()
		MessageBox ('Database Error', 'Failed to insert case log entry' + &
												'~n~rw_query_engine.ue_save_query')
		Return	-1
	END IF
END IF
//	GaryR		06/14/02	Track 3142d - End

//NLG 7-28-98 copy notes for new pdq	Track #1153							***Start**
if left(ls_note_case_id_orig,4) = 'NONE' then
	this.event ue_copy_notes(ls_note_rel_id,ls_note_case_id_new,ls_note_rel_id_orig)
end if
//NLG 7-28-98 									Track #1153							***STOP***

/* put query desc into title bar */
this.event ue_set_pdq_title()

// check if call is from ue_Save event
If Right(as_Path,1) <> 'X' Then
	Integer		li_Index, li_Range

	li_Range = wf_get_max_uo_query()							// FDG 03/16/98				
				
	FOR li_Index = 1 TO li_Range
		If IsValid(iu_query[li_Index]) Then
			// set flag which will prevent non updateable dws on uo_query from
			// being updated during ue_save process
			iu_query[li_Index].of_SetFromCloseQuery(FALSE)
		End If
	NEXT
	
	
	// trigger only the ancestor save method
	li_Return = SUPER::Event ue_Save()
	IF li_Return = 1 OR li_Return = 0 THEN
		// clear the row status from non updateable dws on CURRENT uo_query
		iu_active_query.of_SetStatus(NotModified!)
		This.wf_setrowdelete(FALSE)							// FDG 04/02/98
		// Enable the Link and the Notes menu items
		This.event ue_set_menus_query_select(TRUE)		// FDG 04/22/98
	END IF
End If

this.wf_SetLevelFilter(ii_level_num,'ALL')

// FNC 07/14/98 Start
if iu_active_query.event ue_get_new_flag() then
	iu_active_query.of_set_ib_new_flag(FALSE)
end if
// FNC 07/14/98 End

RETURN li_Return

end event

event ue_open_filter_window;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_open_filter_window					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by im_search.m_filter to open a window 
// (defined in ts144 - Filter Windows) to allow 
//	the user to select filters to create from 
// the columns produced by the query on this level.  
//	Once the user selects filters, he is
// forced down the subset path if he uses a filter 
//	in the next level.  If the user had 
// previously selected filters, they will be highlighted 
//	when the window is opened.  Also 
// the user will be allowed to delete previously 
//	selected filters for that level by 
// deselecting them. 
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
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/06/98		Created.
//
//	FDG			03/19/98		Track 942.  When cancelling from w_qe_filter_create,
//									edit the level_num instead of filter_id.
//
// FNC			08/04/98		Track 1265. Set filter_used field in sx_filter_info
//									if user is using a filter that is being created in 
//									this query in the criteria on any level .
//
//	FDG			12/11/98		Track 2033.  Use a function to get the maximum
//									occurences of uo_query.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

integer li_num_querries,li_query
sx_all_filter_info lsx_filter_parm  /* defined in ts144 - Filter Windows */

this.event ue_get_level_filter_info(lsx_filter_parm.filters)

iu_active_query.event ue_tabpage_source_get_both_data_sources(lsx_filter_parm.data_type)


// FNC 08/04/98 Start
//li_num_querries = upperbound(iu_query)			// FDG 12/11/98
li_num_querries = wf_get_max_uo_query()			// FDG 12/11/98
for li_query = 1 to li_num_querries
	IF	IsValid (iu_query[li_query])			THEN	// FDG 12/11/98
		iu_query[li_query].of_check_filter_id(lsx_filter_parm.filters)
	END IF
next
// FNC 08/04/98 End

openwithparm(w_qe_filter_create, lsx_filter_parm)

lsx_filter_parm = message.Powerobjectparm

SetNull(message.PowerobjectParm)	// needed since some STARS windows are not opened with
											// an OpenWithParm() call even though they have parameters.
											
IF IsNull(lsx_filter_parm.filters[1].filter_id) 	&
OR	lsx_filter_parm.filters[1].level_num	<	0		THEN 
	Return
END IF

this.event ue_set_filter_info(lsx_filter_parm.filters)

iu_active_query.event ue_subsetting_set_filter_create(lsx_filter_parm)

end event

event ue_get_filter_info;call super::ue_get_filter_info;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_get_filter_info						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by uo_query.ue_tabpage_search_filter_lookup() to get the 
// filter information from filters created on previous levels to load into w_qe_filter_list
// or by uo_query.ue_tabpage_search_set_filter() to set the last filter created 
// (from previous level) or by uo_query.tabpage_search.dw_search.itemchanged 
// (ue_tabpage_search_ml_filter_check()) when a user enters a filter to determine if the 
// filter entered was created in a previous level.  The as_type is 'ALL' when coming from 
// the last path since it needs all filters created to determine if  user has selected a 
// filter from a later level so can give them an error message.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		value			as_type				String
//		reference	asx_filter_info[]	sx_filter_info		Filter info.
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
//	J.Mattis			01/06/98		Created.
//
//	FDG				02/11/98		Changed i to ll_i, j to ll_j
//
// FNC				05/20/98		Track 1107. Must set asx_filter_info = isx_filter_info
//										so that it is passed back to the calling script.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_count, ll_i, ll_j

sx_filter_info lsx_filter_info[] /* defined in ts144 - Filter Windows */

if as_type = 'ALL' then 	
	asx_filter_info = isx_filter_info		// FNC 05/20/98
	RETURN 1											// FNC 05/20/98
end if												// FNC 05/20/98

ll_count = upperbound(isx_filter_info)

/* get only filters created in previous levels */
for ll_i = 1 to ll_count
	if isx_filter_info[ll_i].level_num < ii_level_num then
		ll_j++
		lsx_filter_info[ll_j] = isx_filter_info[ll_i]
	end if
next

asx_filter_info = lsx_filter_info

RETURN 1
end event

event ue_get_level_filter_info;call super::ue_get_level_filter_info;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_get_filter_info						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by ue_open_filter_window() to get any filters that may 
// already be saved for the active level to pass to w_qe_filter_create.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		reference	asx_filter_info[]	sx_filter_info		Filter info.
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
//	J.Mattis			01/06/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
Long ll_count, i, j

sx_filter_info lsx_filter_info[]  /* defined in ts144 - Filter Windows */
ll_count = upperbound(isx_filter_info)
/* get only filters created in active level */
for i = 1 to ll_count
	if isx_filter_info[i].level_num = ii_level_num then
		j++
		lsx_filter_info[j] = isx_filter_info[i]
	end if
next

asx_filter_info = lsx_filter_info

RETURN 1

end event

event ue_set_filter_info;call super::ue_set_filter_info;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_filter_info						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by ue_open_filter_window to set the filter information into 
// isx_filter_info returned from w_qe_filter_create.  Must loop thru the structures
// since may be appending to isx_filter_info.  The structure isx_filter_info holds all
// the filters for each level.  May have to clear out any previous set info for the level.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument						Datatype				Description
//		---------	--------						--------				-----------
//		value			asx_new_filter_info[]	sx_filter_info		Filter info.
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
//	J.Mattis			01/06/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_count, i, j, ll_all_filter_count, ll_new_filter_count

/* first clear out any previous filters for this level */
sx_filter_info lsx_filter_info[] /* defined in ts144 - Filter Windows */
ll_count = upperbound(isx_filter_info)

for i = 1 to ll_count
	if isx_filter_info[i].level_num <> ii_level_num then
		j++
		lsx_filter_info[j] = isx_filter_info[i]
	end if
next

isx_filter_info = lsx_filter_info
ll_all_filter_count = j
/* now add new filters to end of array of structures */
ll_all_filter_count++
ll_new_filter_count = upperbound(asx_new_filter_info[])

for i = 1 to ll_new_filter_count
	isx_filter_info[ll_all_filter_count] = asx_new_filter_info[i]
	isx_filter_info[ll_all_filter_count].level_num = ii_level_num
	ll_all_filter_count++
next

RETURN 1
end event

event ue_open_menu();// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

This.event ue_open_rmm()
end event

event ue_prov_pat_drilldown;call super::ue_prov_pat_drilldown;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_parent_drilldown						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//Invoke the user event defined in the View Report Tab page 
//(ue_tabpage_view_prov_pat_drilldown) to validate that the drilldown function can be 
//performed.  Pass the tag value to the event script.  Return control to the tab page if 
//the value of the argument returned by the View Report Tab user event is empty.  This 
//occurs when an error condition is encountered.  If the user event performs its tasks 
//successfully, the event returns the key value of the appropriate column (provider or 
//patient) within the row selected by the user. Set up the argument list for the List 
//Detail window using the tag value and the key value returned from the View Report Tab 
//page user event. Open the List Detail window (w_prov_enroll_maint), passing the argument 
//list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		None
//						
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
//	F.Chernak		01/08/98		Created.
/////////////////////////////////////////////////////////////////////////////

String ls_key_arg

ls_key_arg = iu_active_query.event ue_tabpage_view_prov_pat_drilldown(as_tag_value)
if ls_key_arg = "" then
   MessageBox(  this.tag + ' DRILLDOWN', 'Please select a row to drilldown from.')
   return
end if
gv_from    = 'LOOKUP'
gv_prov_id = ls_key_arg

Choose Case as_tag_value
  Case 'PR'
    OpenSheetWithParm(w_prov_enroll_maint, 'PV', mdi_main_frame,help_menu_position, Layered!)
  Case 'PT'
    OpenSheetWithParm(w_prov_enroll_maint, 'EI', mdi_main_frame,help_menu_position, Layered!)
End Choose

end event

event ue_parent_drilldown(string as_tag_value);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_parent_drilldown						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	This event is called by drilldown paths from 
//	m_view.m_drilldown.  It is passed with the 
//	tag which consist of the path followed by the 
//	flag which determines if can add columns 
//	from the previous report (only if drilling down 
//	from patients, providers or claims to 
//	claims).  First ask user if wants to add 
//	columns and then clean up any 'old' uo_query 
//	objects (if path is AD) and then call the 
//	ue_drilldown_build_temp_table event of the 
//	active uo_query.  Once temp table is created 
//	and populated must open a new drilldown 
//	uo_query and populate the data source depending 
//	on the path and current invoice type 
//	which are passed into the uo_query user event 
//	(ue_drilldown_load_new_query) of the new 
//	drilldown uo_query.  This becomes the active 
//	uo_query and it's tabpage_list is disabled 
//	and the tabpage_source is selected.  Finally must 
//	adjust menu functionality depending on 
//	selected path.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//						as_tag_value	string
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date		Description
// ------		----		-----------
//	F.Chernak	01/08/98	Created.
//	F.Chernak	01/28/98	Set active query to nulls before opening it for the
//								next level of drilldown. Set ib_drilldown to TRUE
//	F.Chernak	02/04/98	Check return from uo_query.ue_drilldown_build_temp_table
//								and uo_query.ue_drilldown_load_new_query
//	J.Mattis		02/20/98	Added code to open local instance of query, and to pass
//								a sx_criteria parameter to the new query instance.
// F.Chernak	02/23/98	Add a boolean so code can determine if it is the 
//								first drilldown.
//	FDG			02/24/98	1. Open uo_query via a script instead of
//								openuserobjectwithparm 
//								2. Call wf_ResizeUo(1) to resize uo_query for
//								drilldown.
//	FDG			05/28/98	Track 1287.  Save uo_query.istr_drilldown in case
//								there are multiple drilldowns. 
//	FDG			11/04/98	Track 1825.  On drilldown, carry over the dates
//								from the primary criteria.  This is done by passing
//								dw_criteria into the new uo_query's idw_prev_crieria.
//	FDG			11/20/98	Track 1946.  Let the original uo_query know that it's in 
//								drilldown mode.
//	GaryR			02/05/02	Track 2552d Predefined Report (PDR)
// Lahu S       4/19/02 Track 2552d Drilldown PDR
//	GaryR			05/07/03	Track 3516d	Carry the selected value with drilldown
//	GaryR			06/23/03	Track 2769d	Clean up drilldown/undodrilldown menu options
//	GaryR			11/25/03	Track 3716d	Remove decoded value in PDR drilldown
//	GaryR			02/02/04	Track	3828d	Do not populate drilldown criteria
//								that already exists in the parent level
//	GaryR			05/10/04	Track 3756d	Streamline PDR deployment & security
// MikeF			10/13/04 Track 3650d	Replace local n_cst_dict with gnv_dict
//	GaryR			10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR			11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR			12/11/04	Track 4108d	Dynamic Report Options
//	GaryR			12/13/04	Track 4148d	Execute the validate event to enable tabs
//	GaryR			01/05/05	Track	4180d	Redesign drilldown control flow
//	GaryR			03/01/05	Track 4298d	If temp table fails, revert to main query
//	GaryR			07/29/05	Track 4432d	Allow multi-column decode in background
/////////////////////////////////////////////////////////////////////////////

string 	ls_path,			&
			ls_all_cols,	&
			ls_where[]
integer	li_index,		&
			li_rc,			&
			li_upperbound
			
uo_query					lu_new_query
sx_drilldown			lstr_drilldown,	&
							lstr_prev_drilldown
sx_criteria  			lstr_drilldown_criteria[]
sx_drilldown_parms	lsx_drilldown_parms
u_dw						ldw_prev_criteria, ldw_report, ldw_criteria

//	GaryR	02/05/02	Track 2552d - Begin
Long		ll_row
String	ls_sql, ls_tag, ls_type, ls_value, ls_col_name, ls_table, ls_find, ls_lookup

String	ls_case_id, ls_case_ver, &
			ls_case_spl, ls_pdr_cat, &
			ls_pdr_type, ls_pdr_label  //Lahu S
Integer	li_next, li_pos, li_row
boolean	lb_criteria  //Lahu
sx_pdr_parms		lsx_pdr_parms  //Lahu
sx_dw_format 		lsx_report_options
DataWindowChild	ldwc_exp1
n_cst_decode		lnv_decode

//	Account for PDRs that require drilldown to details.
IF This.of_is_pdr_mode() THEN
//Lahu S 4/18/02 Track 2552d Begin		
	This.of_get_pdr_parm( lsx_pdr_parms )
	if trim(lsx_pdr_parms.pdr_drilldown) = "CASE_MAINT" then	//open Case Maintenance window
		ll_row = iu_active_query.tabpage_view.dw_report.GetRow()
		IF ll_row < 1 THEN
			MessageBox( "Invalid Row", "Please select a valid row" )
			Return
		END IF

		IF iu_active_query.tabpage_view.dw_report.Describe( "case_id.visible" ) = "!" OR & 
			iu_active_query.tabpage_view.dw_report.Describe( "case_ver.visible" ) = "!" OR & 
			iu_active_query.tabpage_view.dw_report.Describe( "case_spl.visible" ) = "!"  THEN
	
			MessageBox( "ERROR", "Unable to drilldown to Case Maintenance because column 'CASE_ID' or 'CASE_VER' or 'CASE_SPL' is not defined in the report" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
			Return
		END IF

		ls_case_id	=	iu_active_query.tabpage_view.dw_report.object.case_id[ll_row]
		ls_case_ver	=	iu_active_query.tabpage_view.dw_report.object.case_ver[ll_row]
		ls_case_spl	=	iu_active_query.tabpage_view.dw_report.object.case_spl[ll_row]
	
		gv_active_case = ls_case_id + ls_case_spl + ls_case_ver
		if isvalid(w_case_maint) then close(w_case_maint)
		OpenSheetWithParm(w_case_maint,"L",mdi_main_frame,help_menu_position,Layered!)		
		Return
	elseif trim(lsx_pdr_parms.pdr_drilldown) <> "" then	//show drilldown/child report
		SELECT PDR_CAT, PDR_TYPE, PDR_LABEL
		INTO	:ls_pdr_cat, :ls_pdr_type, :ls_pdr_label
		FROM	PDR_CNTL
		WHERE	PDR_NAME = :lsx_pdr_parms.pdr_drilldown
		USING	Stars2ca;
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "ERROR", "Unable to find PDR in PDR_CNTL where PDR_NAME = " + &
									lsx_pdr_parms.pdr_drilldown, StopSign! )
			Return
		END IF
		
		This.SetRedraw( FALSE )

		//store PDR drilldown info
		incst_drilldown[ii_ctr].pdr_cat = &
			iu_active_query.tabpage_pdr.dw_pdr.object.pdr_cat[1]
		incst_drilldown[ii_ctr].pdr_type = &
			iu_active_query.tabpage_pdr.dw_pdr.object.pdr_type[1]
		incst_drilldown[ii_ctr].pdr = &
			iu_active_query.tabpage_pdr.dw_pdr.object.pdr_report[1]
			
		iu_active_query.tabpage_report.uo_report_options.of_get( lsx_report_options )
		incst_drilldown[ii_ctr].isx_report_options = lsx_report_options

		if iu_active_query.tabpage_search.dw_criteria.rowcount() > 0 then
			incst_drilldown[ii_ctr].ids_criteria.object.data = &
				iu_active_query.tabpage_search.dw_criteria.object.data
		end if
		
		//	Check if source needs to be carried down
		IF lsx_pdr_parms.pdr_source > 0 THEN
			incst_drilldown[ii_ctr].ids_source.object.data = &
				iu_active_query.tabpage_source.dw_source.object.data
		END IF
		
		//	Recreate the report for later use
		ll_row = iu_active_query.tabpage_view.dw_report.GetRow()
		IF ll_row > 0 THEN
			iu_active_query.tabpage_view.dw_break.Create( iu_active_query.tabpage_view.dw_report.object.datawindow.syntax )
			iu_active_query.tabpage_view.dw_break.object.data = iu_active_query.tabpage_view.dw_report.object.data
		END IF

		iu_active_query.tabpage_pdr.dw_pdr.object.DataWindow.ReadOnly	=	'No'
		
		iu_active_query.tabpage_pdr.dw_pdr.SetColumn("pdr_cat")
		iu_active_query.tabpage_pdr.dw_pdr.SetText( ls_pdr_cat )
		iu_active_query.tabpage_pdr.dw_pdr.accepttext()
		iu_active_query.tabpage_pdr.dw_pdr.SetColumn("pdr_type")
		iu_active_query.tabpage_pdr.dw_pdr.SetText( ls_pdr_type )
		iu_active_query.tabpage_pdr.dw_pdr.accepttext()
		iu_active_query.tabpage_pdr.dw_pdr.SetColumn("pdr_report")
		iu_active_query.tabpage_pdr.dw_pdr.SetText( ls_pdr_label )						
		iu_active_query.tabpage_pdr.dw_pdr.accepttext()

		//	Check if source needs to be carried down
		IF lsx_pdr_parms.pdr_source > 0 THEN
			iu_active_query.tabpage_source.dw_source.object.data = & 
				incst_drilldown[ii_ctr].ids_source.object.data
			//	Validate sources
			iu_active_query.event ue_tabpage_pdr_validate_source()
		END IF
		
		if	incst_drilldown[ii_ctr].ids_criteria.rowcount() > 0 then
			iu_active_query.tabpage_search.dw_criteria.object.data = & 
				incst_drilldown[ii_ctr].ids_criteria.object.data
		end if

		IF ll_row > 0 THEN
			ldw_report = iu_active_query.tabpage_view.dw_break
			li_upperbound = Long( ldw_report.object.datawindow.column.count )
			FOR li_index = 1 TO li_upperbound
				ls_tag = Upper( ldw_report.Describe( "#" + String( li_index ) + ".Tag" ) )
				IF NOT Match( ls_tag,"DRILLDOWN" ) THEN Continue
				
				// Get the columns to add to criteria
				ls_col_name = ldw_report.Describe( "#" + String( li_index ) + ".dbname" )
				
				// Split up table and name
				li_pos =	Pos( ls_col_name, '.' )
				
				IF li_pos > 0 THEN
					ls_table	= Upper( Trim( Left( ls_col_name, li_pos - 1 ) ) )
					ls_col_name = Upper( Trim( Mid( ls_col_name, li_pos + 1 ) ) )
					
					// For claims PDR table is the alias
					IF lsx_pdr_parms.pdr_source > 0 THEN
						ls_table = iu_active_query.tabpage_source.dw_source.event ue_get_inv_type( ls_table )
					ELSE						
						ls_table = gnv_dict.event ue_get_inv_type( ls_table )
					END IF
				ELSE
					ls_table = ""
				END IF
				
				// Get the value to add to criteria
				ls_type = ldw_report.Describe( "#" + String( li_index ) + ".ColType" )
				IF gnv_sql.of_is_character_data_type( ls_type ) THEN
					ls_value = ldw_report.GetItemString( ll_row, li_index )
					//	Remove decoded value		
					IF lnv_decode.of_is_decoded( ldw_report, li_index ) THEN
						lnv_decode.of_remove_desc( ls_value )
					END IF							
				ELSEIF gnv_sql.of_is_date_data_type( ls_type ) THEN
					ls_value = String( ldw_report.GetItemDateTime( ll_row, li_index ), "mm/dd/yyyy" )
				ELSEIF gnv_sql.of_is_money_data_type( ls_type ) THEN
					ls_value = String( ldw_report.GetItemDecimal( ll_row, li_index ) )
				ELSE
					ls_value = String( ldw_report.GetItemNumber( ll_row, li_index ) )
				END IF
				
				//	Insert the criteria row into the datawindow
				ldw_criteria = iu_active_query.tabpage_search.dw_criteria
				ldw_criteria.GetChild( "expression_one", ldwc_exp1 )
				IF Trim( ls_table ) <> "" THEN
					ls_find = "elem_name = '" + Upper( ls_col_name ) + "' and elem_tbl_type = '" + ls_table + "'"
				ELSE
					ls_find = "elem_name = '" + Upper( ls_col_name ) + "'"
				END IF
				li_row = ldwc_exp1.Find( ls_find, 0, ldwc_exp1.RowCount() )
				IF li_row < 1 THEN
					MessageBox( "Warning", "Unable to find the following row in criteria:~n~r" + ls_find, Exclamation! )
					Continue
				END IF
				
				ls_col_name = ldwc_exp1.GetItemString( li_row, "col_name" )
				ls_lookup = ldwc_exp1.GetItemString( li_row, "elem_lookup_type" )
				ls_type = ldwc_exp1.GetItemString( li_row, "elem_data_type" )
				
				//	Check if the critaria already exists
				lb_criteria = FALSE
				FOR li_next = 1 TO ldw_criteria.RowCount()
					IF		Upper( Trim( ldw_criteria.GetItemString( li_next, "expression_one" ) ) ) = Upper( Trim( ls_col_name ) ) &
					AND	Upper( Trim( ldw_criteria.GetItemString( li_next, "expression_two" ) ) ) = Upper( Trim( ls_value ) ) &
					AND Trim( ldw_criteria.GetItemString( li_next, "relational_op" ) ) = "=" THEN
						lb_criteria = TRUE
						Continue
					END IF
				NEXT
				
				IF lb_criteria THEN Continue
				
				ldwc_exp1.SetRow( li_row )
				ldwc_exp1.ScrollToRow( li_row )
				
				//	Check if row is empty
				IF ldw_criteria.RowCount() = 1 THEN
					IF	Trim( ldw_criteria.GetItemString( 1, "expression_one" ) ) <> "" THEN
						li_row = ldw_criteria.InsertRow( 0 )
					ELSE
						li_row = 1
					END IF
				ELSE
					li_row = ldw_criteria.InsertRow( 0 )
				END IF

				IF ldw_criteria.RowCount() > 1 THEN
					IF ldw_criteria.GetItemString( li_row - 1, "pdr_protect" ) <> "A" THEN ldw_criteria.SetItem( li_row - 1, "logical_op", "AND" )
				END IF
				ldw_criteria.SetItem( li_row, "expression_one", ls_col_name )
				ldw_criteria.SetItem( li_row, "relational_op", "=" )
				ldw_criteria.SetItem( li_row, "expression_two", ls_value )
				ldw_criteria.SetItem( li_row, "lookup", ls_lookup )
				ldw_criteria.SetItem( li_row, "c_elem_data_type", ls_type )
			NEXT
			ldw_report.Reset()
		END IF
				
		iu_active_query.of_set_ib_drilldown_mode(TRUE) 	
		im_view.m_menu.m_undodrilldown.enabled =  TRUE
		im_pdr.m_menu.m_undodrilldown.enabled = TRUE					
		im_report.m_menu.m_undodrilldown.enabled = TRUE							
		im_search.m_menu.m_undodrilldown.enabled = TRUE
		
		// Prevent changing of PDR source
		iu_active_query.tabpage_pdr.dw_pdr.object.DataWindow.ReadOnly	=	'Yes'
		
		ii_ctr++
		
		iu_active_query.selecttab("tabpage_pdr")
		iu_active_query.selecttab("tabpage_view")	
		
		This.SetRedraw( TRUE )
		Return		
	end if
//Lahu S 4/18/02 Track 2552d End				
END IF
//	GaryR	02/05/02	Track 2552d - End

// FDG 05/28/98 begin
//	Save istr_drilldown from the existing uo_query before changing it.
lstr_prev_drilldown	=	iu_active_query.of_get_istr_drilldown()
iu_active_query.of_set_istr_prev_drilldown (lstr_prev_drilldown)
iu_active_query.of_set_ib_drilldown_mode (TRUE)			// FDG 11/20/98
// FDG 05/28/98 end

// FDG 11/04/98 - Get dw_criteria from the original query
ldw_prev_criteria	=	iu_active_query.of_get_dw_criteria()

ls_path = left(as_tag_value,2)
ls_all_cols = mid(as_tag_value,3)
if ls_all_cols = 'A' then
	li_rc = messagebox('QUESTION','Would you like the columns in this report included in the next report?',Question!,YesNo!)
	if li_rc = 1 then 
		lstr_drilldown.column_flag = TRUE
	end if
end if

if ls_path = "AD" and ib_multiple_drilldown then	//02-23-98 FNC
	/* get criteria from 1st uo_query then drop it's temp table and close it */
	li_upperbound = upperbound(istr_drilldown_criteria)
	li_index = li_upperbound + 1
	iu_active_query.event ue_format_where_criteria('CRITERIA',TRUE,ls_where, istr_drilldown_criteria)
	iu_active_query.event ue_drilldown_drop_temp_table()
end if

lstr_drilldown.path = ls_path
/*UE_Drilldown_Build_Temp_Table sets the istr_drilldown structure to the argument passed */
li_rc = iu_active_query.event ue_drilldown_build_temp_table(lstr_drilldown)	//02-04-98 FNC
if li_rc < 1 then
	iu_active_query.of_set_ib_drilldown_mode (FALSE)
	return		//02-04-98 FNC
end if
	
// save pointer to current query 
iu_active_query.visible = FALSE			//02-23-98 FNC
iu_previous_query = iu_active_query

/* contain the drilldown structures within the parm. structure
   to message the info. to the new query */
lsx_drilldown_parms.sx_drilldown_parm		=	iu_previous_query.istr_drilldown		// FDG 02/25/98
lsx_drilldown_parms.sx_drilldown_criteria =	istr_drilldown_criteria
lsx_drilldown_parms.is_inv_type				=	iu_previous_query.is_inv_type

// instantiate the new, local query.
This.Event	ue_open_uo_query (lu_new_query, lsx_drilldown_parms, '')		// FDG 02/24/98
//this.openuserobjectwithparm(lu_new_query,lsx_drilldown_parms,iix_pos,iiy_pos)

//02-20-98 JTM Start
/* make the new, local query the current query since almost all code in query engine
	references the active query. */
iu_active_query = lu_new_query 

this.wf_ResizeUo(1)
//02-20-98 JTM Start
iu_active_query.visible	=	TRUE
li_rc = iu_active_query.event ue_drilldown_load_new_query()	//02-04-98 FNC

if li_rc < 1 then return												//02-04-98 FNC

// FDG 11/04/98 - save dw_criteria from the original query into the drilldown query
iu_active_query.of_set_idw_prev_criteria (ldw_prev_criteria)

this.event ue_set_menus_drilldown( FALSE )

iu_active_query.ib_drilldown = TRUE									//01-28-98 FNC
ib_multiple_drilldown = TRUE											//02-23-98 FNC
end event

event ue_create_subset;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_create_subset							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by im_view.m_save.m_createsubset or 
// im_search.m_save.m_createsubset to load an array of subset structures 
// (one structure per level) and pass to the Subset Options window.  For every visible 
// tabpage a structure (sx_subsetting_info: definition in ts145 - sx_subsetting_info) 
// will be loaded for the corresponding uo_query and placed in an array.  If it is 
// determined that a subset is the source of the query and it is an ML subset then must 
// make sure all levels (invoice types) are part of the new subset.  Finally load the 
// array of sx_subsetting_info structures into sx_subset_options (definition in ts145 - 
// SX_Subset_Options), set the come_from flag to 'QUERY' and open the Subset Options window.
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
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/08/98	Created.
// FNC		02/26/98	Track 867
//							Accept criteria datawindow before creating subset
// FNC		03/03/98	Track 882
//							1.Must read sub_cntl to determine source type of 
//							original subset. Created an event to perform this task
//							2.Must loop through invoice types of all levels to
//							determine if creating an ML subset. If so set
//							subset type for all level = ML
// FNC		03/04/98	Track 890
//							Check return code from uo_query.ue_subsetting.
//	FDG		03/19/98	Track 890
//							Check return code from ue_tabpage_source_get_source_sub_tables
//	FDG		03/20/98	Track 874
//							After successful subset, get the # of rows in the subset.
//	FDG		03/24/98	Track 961
//							Include the subset name in the microhelp message.
//	FNC		07/16/98	Track 1319. Check return code from ue_subsetting_add_level
// FNC		07/16/98	Track 1521. Loop through all the steps in the level when the
//							invoice type is moved to ls_inv_types[]. If this is not
//							done only the first invoice type is moved when and ML subset is 
//							used as source with MC criteria.
// FNC		07/29/98	Track 1530. After subset is created must clear out filter 
//							create structure. Call event loads filter create structure
//							when filter is first created.
// FNC		07/30/98	Track 1514. Reset sx_filter_info after subset is created 
//							because filters are now ready to be used.
// FNC		08/26/98	Track 1578. Use uo_query to determine number of levels. 
//							Shouldn't use lsx_subsetting_info because it contains added
//							entries for ml subset levels that weren't included in query.
//	FDG		11/11/98	Track 1946.  Trigger ue_subsetting from iu_active_query
//							instead of the iu_query array.  This is needed because of
//							the potential to create a subset while in drilldown mode.
//	NLG		11/20/98	Track #1979. Undo changes made for Track 1946.  This is causing
//							filter_create[] to be empty.
// FDG		11/20/98	Track 1946.  Trigger ue_subsetting from iu_active_query only
//							if the tab's uo_query is in drilldown mode.
// FNC		11/25/98	Track 2000. Call new function in uo_query.u_nvo_search to clear out
//							filter copy data.
//	FDG		12/11/98	Track 2033.  Get the upperbound of uo_query thru a function.
//	FDG		02/05/99	Track 2084c.  Pass 'ALL' to wf_clear_filter_info to ensure
//							that all levels get cleared.  This results in some logic
//							in this script moving to wf_clear_filter_info.
//	NLG		11/08/99	ts2463c. Put the run_frequency in the subset options structure
//							before opening Subset Options
//	NLG		12/13/99	ts2463c. Set ii_run_frequency. First level uo_query 
//							determines run_frequency.  Also set recurring pdq boolean for uo_query.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

sx_subsetting_info lsx_subsetting_info[]
sx_subset_options lsx_subset_options
sx_all_filter_info lsx_clear_array

boolean lb_recurring_pdq			//NLG 12-13-99
Integer i, j,li_rc
integer li_num_inv_types, li_lookup_inv_type, li_list_inv_type
integer li_num_steps, li_step, li_inv_type
integer li_nbr_levels,li_level
String ls_source_subset_id, ls_sub_inv_types[], ls_inv_types[], ls_case_id
String ls_source_subset_type, ls_err_msg
Boolean lb_check_ml, lb_found, lb_more_than_one_inv_type
Boolean	lb_drilldown_mode
Long ll_sub_count, ll_count, ll_level_count

//02-28-98 FNC Start
if this.event ue_accepttext(this.control, FALSE) < 0 then
	messagebox('ERROR','Error processing criteria. Cannot create subset')
	return
end if
//02-28-98 FNC End

if tab_level.tabpage_1.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[1].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
//		//NLG 12/13/99  *START****
//		ii_run_frequency = iu_query[1].of_get_run_frequency()	//this is set in uo_query.ddlb_pd_opt.selectionchanged
		IF ii_run_frequency > 0 THEN
			lb_recurring_pdq = TRUE
		ELSE
			lb_recurring_pdq = FALSE
		END IF 
		iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)
//		//NLG 12/13/99  *STOP****
		li_rc = iu_query[1].event ue_subsetting(lsx_subsetting_info[i])
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
	
	/* check to see if source is ML subset & get inv types*/
	ls_source_subset_id = lsx_subsetting_info[i].source_subset_id
	if ls_source_subset_id <> '' then
	//03-03-98 FNC Start
		li_rc = this.event &
			ue_get_source_subset_type(ls_source_subset_id,ls_source_subset_type)
		if li_rc <> 1 then 
			messagebox('ERROR','Error determining source subset type in W_Query_Engine.UE_Create_Subset')
			return
		end if
		if ls_source_subset_type = 'ML' then	//03-03-98 FNC End
			lb_check_ml = TRUE
			/* need case id if create new level */
			ls_case_id = lsx_subsetting_info[i].subset_step[1].subc_sub_src_case_id
			li_rc = iu_query[1].event ue_tabpage_source_get_source_sub_tables(ls_source_subset_id,ls_sub_inv_types)
			IF li_rc	<	0		THEN
				Return						// FDG 03/19/98
			END IF
		end if
	end if
end if

if tab_level.tabpage_2.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[2].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[2].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_3.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[3].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[3].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_4.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[4].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[4].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_5.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[5].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[5].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_6.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[6].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[6].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_7.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[7].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[7].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i	
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_8.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[8].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[8].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_9.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[9].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[9].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

if tab_level.tabpage_10.visible then
	i++
	//li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	// FDG 11/20/98 begin
	lb_drilldown_mode	=	iu_query[10].of_get_ib_drilldown_mode()
	IF	lb_drilldown_mode	=	TRUE		THEN
		li_rc = iu_active_query.event ue_subsetting(lsx_subsetting_info[i])		// FDG 11/11/98
	ELSE
		//iu_query[i].of_set_ib_recurring_pdq(lb_recurring_pdq)							// NLG 12/13/99
		li_rc = iu_query[10].event ue_subsetting(lsx_subsetting_info[i])			// NLG 11/20/98
	END IF
	// FDG 11/20/98 end
	if li_rc < 1 then return		//03-04-98 FNC
	// FNC 07/16/98 Start
	li_num_steps = upperbound(lsx_subsetting_info[i].subset_step)
	li_inv_type = i
	for li_step = 1 to li_num_steps
		ls_inv_types[li_inv_type] = lsx_subsetting_info[i].subset_step[li_step].inv_type
		li_inv_type++
	next
	// FNC 07/16/98 End
end if

/* if source is ML subset must make sure that all invoice types are part of the subset, if 
not must create a level for each invoice type copying that subset's invoice type to the 
new subset */
if lb_check_ml then
	ll_sub_count = upperbound(ls_sub_inv_types) /*all inv_types in subset*/
	ll_count = upperbound(ls_inv_types)         /*inv_types in query*/
	ll_level_count = upperbound(lsx_subsetting_info)
	for i = 1 to ll_sub_count
		lb_found = FALSE
		for j = 1 to ll_count
			if ls_sub_inv_types[i] = ls_inv_types[j] then
				lb_found = TRUE
				exit
			end if
		next
		if not lb_found then
			ll_level_count++
			// FNC 07/16/98 Start
			li_rc = this.event ue_subsetting_add_level &
				(lsx_subsetting_info[ll_level_count],ls_source_subset_id, &
				ls_case_id, ls_sub_inv_types[i])
			if li_rc < 0 then return
			// FNC 07/16/98 End			
		end if
	next
	this.event ue_set_ML_subset_type(lsx_subsetting_info)
else	
	/*03-03-98 FNC Must determine if an ML subset is being created. If it is then 
	must change subset type to ML */
	li_num_inv_types = upperbound(ls_inv_types)
	for li_lookup_inv_type = 1 to li_num_inv_types
		if lb_more_than_one_inv_type then EXIT
		for li_list_inv_type = 1 to li_num_inv_types
			if ls_inv_types[li_lookup_inv_type] <> ls_inv_types[li_list_inv_type] then
				lb_more_than_one_inv_type = TRUE
				EXIT
			end if
		next
	next
	
	if lb_more_than_one_inv_type then
		this.event ue_set_ML_subset_type(lsx_subsetting_info)
	end if
end if		//03-03-98 FNC End

lsx_subset_options.run_frequency = lsx_subsetting_info[1].run_frequency//NLG 11-08-99

lsx_subset_options.come_from = 'QUERY'
lsx_subset_options.sub_info = lsx_subsetting_info

openwithparm(w_subset_options,lsx_subset_options)

// FDG 03/20/98 begin
lsx_subset_options	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

//IF	Upper (lsx_subset_options.status)	=	'COMPLETE'		THEN
//	//	Subset was successfully created.  Display the # of rows
//	//	in the Microhelp.
//	String	ls_subset_id,		&
//				ls_subset_name
//	ls_subset_id	=	Trim (lsx_subset_options.subset_id)
//	ls_subset_name	=	Trim (lsx_subset_options.subset_name)		// FDG 03/24/98
//	IF	ls_subset_id	>	'  '		THEN
//		//	The subset exists.  Retrieve this subset data from SUB_CNTL
//		ls_err_msg	=	'The subset was not created because there was no data for the subset'
//		n_ds	lds_sub_cntl
//		lds_sub_cntl	=	CREATE	n_ds
//		lds_sub_cntl.DataObject	=	'd_qe_sub_cntl'
//		lds_sub_cntl.SetTransObject (Stars2ca)
//		ll_count	=	lds_sub_cntl.Retrieve (ls_subset_id)
//		IF	ll_count	>	0		THEN
//			IF	ls_subset_id	=	ls_subset_name		THEN
//				// Subset ID and name match.  Only display this once in the microhelp.
//				ls_subset_id	=	''
//			ELSE
//				//	Subset ID and name don't match.  Display both in the microhelp.
//				ls_subset_id	=	' ('	+	ls_subset_id	+	')'
//			END IF
//			ll_sub_count	=	lds_sub_cntl.object.subc_no_rows [ll_count]
//			This.Event	ue_set_count (ll_sub_count)		//	Set st_count.text
//			IF	ll_sub_count	>	0		THEN
//				w_main.SetMicroHelp ('Request successful.  ' + &
//											String (ll_sub_count)	+ &
//											' rows exist in subset ' + &
//											ls_subset_name	+	&
//											ls_subset_id	+	'.')
//			ELSE
//				MessageBox ('Subset Error', ls_err_msg)
//				w_main.SetMicroHelp (ls_err_msg)
//			END IF
//		ELSE
//			// No rows in subset
//			This.Event	ue_set_count (0)		//	Set st_count.text to zero
//			MessageBox ('Subset Error', ls_err_msg)
//			w_main.SetMicroHelp (ls_err_msg)
//		END IF
//		Destroy	lds_sub_cntl
//	END IF
//END IF
// FDG 03/20/98 end

// FNC 07/29/98 Start

IF	Upper (lsx_subset_options.status)	=	'COMPLETE'		THEN
//	li_nbr_levels = upperbound(lsx_subsetting_info)
	//li_nbr_levels = upperbound(iu_query)			// FDG 12/11/98
	
	// FDG 02/05/99 - Commented logic moved to wf_clear_filter_info()
	//li_nbr_levels = wf_get_max_uo_query()			// FDG 12/11/98
	//for li_level = 1 to li_nbr_levels
	//	IF	IsValid (iu_query[li_level])		THEN
	//		iu_query[li_level].event ue_subsetting_set_filter_create(lsx_clear_array)
	//		iu_query[li_level].event ue_subsetting_clear_filter_copy()		// FNC 11/25/98
	//	END IF
	//next
	wf_clear_filter_info('ALL')						// FNC 07/30/98		// FDG 02/05/99
End if
// FNC 07/29/98 End



end event

event ue_clear_pdq_datawindows();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_clear_pdq_datwindows					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_save_query() to clear out the datawindows so
// they can be loaded with the undated query. 
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
//	J.Mattis			01/08/98		Created.
//
//	FDG				01/27/98		Clear the unique counts
//	GaryR				11/16/04		Track 4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

this.SetRedraw(FALSE)
dw_pdq_case_link.reset()
dw_pdq_cntl.reset()
dw_pdq_tables.reset()
dw_pdq_criteria.reset()
dw_pdq_columns.reset()
dw_pdr_sources.reset()
This.event ue_set_unique_count(0, '')		//	Clear out the unique counts
this.SetRedraw(TRUE)
end event

event type integer ue_save_cntl_pdq(sx_query_save asx_query_save);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_save_cntl_pdq							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_save_query() to load the case_link and 
// pdq_cntl datawindow with the query control information from the sx_query_save 
// structure (defined in ts144 -w_query_save) passed in.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			asx_query_save	sx_query_save	
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.		
//						-1				Failure.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	01/08/98		Created.
//	J.Mattis	01/21/98		Added guard against inserting into an update datawindows to
//								prevent SQL insert duplicate key errors. Also, added code
//								to get the report title.
//	J.Mattis	02/20/98		Changed 'C' link status to 'A' (Active). 
//	FDG		04/13/98		Track 1054.  Set the rpt title in pdq_cntl to the empty
//								string since it's no longer needed in this table (It
//								is used in pdq_tables instead).
//	FDG		04/30/98		Track 1095.  Remove references to common_flg.  It
//								is no longer being used.
// FNC		07/14/98		Track 1264. Do not write over cntl and case link data if 
//								performing a link or save as.
// FNC		07/21/98		Track 1264. Reverse 7/14/98 change. Do not keep none record
//								when link so want to write over record if it is a link. So
//								only when do save as get a new row.
//	FDG		07/22/98		Track 1526.  The Mid() function to fill in case_spl &
//								case_ver should only fill in 2 bytes.
//	GaryR		01/16/01		Stars 4.7 DataBase Port - Empty String in SQL
//	FDG		03/29/01		Stars 4.7.  Only save 1st 2 bytes of query_type
//	GaryR		04/29/02		Track 2552d Predefined Report (PDR)
//	GaryR		09/04/02		Track 3273d	Prevent saving duplicate link names
//	GaryR		01/23/03		Track 3420d	Do not check for dups when saving an existing PDQ
//	GaryR		10/21/04		Track 4089d	Add third tier to PDR report selection
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

DateTime ld_datetime
integer li_row, li_rc
sx_pdr_parms	lsx_pdr_parms

//	GaryR		01/16/01		Stars 4.7 DataBase Port
String	ls_case_spl, ls_case_ver, ls_link_desc, ls_empty

//	GaryR	09/04/02	Track 3273d - Begin
String	ls_case_id
Long		ll_count
//	GaryR	09/04/02	Track 3273d - End

Constant String LS_LINKSTATUS = 'A'
Constant String LS_PDQTYPE = 'Q'

String LS_LINKTYPE

//	GaryR	04/29/02	Track 2552d - Begin
IF This.of_is_pdr_mode() THEN
	ls_linktype = "PDR"
ELSE
	ls_linktype = "PDQ"
END IF
//	GaryR	04/29/02	Track 2552d - End

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

//get the server date
ld_datetime = gnv_App.of_Get_Server_Date_Time()

//	GaryR		01/16/01		Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
ls_case_id		= Trim( Left( asx_query_save.case_id, 10 ) )	//	GaryR	09/04/02	Track 3273d
ls_case_spl		= mid(asx_query_save.case_id,11,2)	// FDG 07/22/98
ls_case_ver		= mid(asx_query_save.case_id,13,2)	// FDG 07/22/98
ls_link_desc	= asx_query_save.query_desc

IF Trim( ls_case_spl ) 	= "" THEN ls_case_spl	= ls_empty
IF Trim( ls_case_ver ) 	= "" THEN ls_case_ver	= ls_empty
IF Trim( ls_link_desc )	= "" THEN ls_link_desc	= ls_empty

//	GaryR	09/04/02	Track 3273d - Begin
// FNC 07/14/98 Change row number from 1 to li_row
if left(asx_query_save.path,1) = 'A' then
	li_row = dw_pdq_case_link.insertrow(0)
else
	li_row = 1
end if

//	Do not check for dups if saving an existing PDQ
IF Left( asx_query_save.path, 1 ) <> "S" THEN
	//	Check if PDQ already linked to 
	//	the case under the same name
	SELECT	count(*)
	INTO	 	:ll_count
	FROM		case_link
	WHERE		case_id		= Upper( :ls_case_id )
	AND		case_spl		= Upper( :ls_case_spl )
	AND		case_ver		= Upper( :ls_case_ver )
	AND		link_type	= Upper( :ls_linktype )
	AND		link_name	= Upper( :asx_query_save.query_name	)
	USING		Stars2ca;
	
	IF stars2ca.of_check_status() < 0 THEN
		MessageBox( "Query Save", "Error reading CASE_LINK table" )
		Return -1
	ELSEIF ll_count > 0 THEN
		Messagebox( "Query Save", "Link name (" + asx_query_save.query_name + &
													") already exists in Case.", Exclamation! )
		Return -1
	END IF
END IF

//dw_pdq_case_link.object.case_id[li_row] = left(asx_query_save.case_id,10)
dw_pdq_case_link.object.case_id[li_row] = ls_case_id
//	GaryR	09/04/02	Track 3273d - End

dw_pdq_case_link.object.case_spl[li_row] = ls_case_spl
dw_pdq_case_link.object.case_ver[li_row] = ls_case_ver
dw_pdq_case_link.object.link_type[li_row] = LS_LINKTYPE
dw_pdq_case_link.object.link_key[li_row] = asx_query_save.query_id
dw_pdq_case_link.object.link_name[li_row] = asx_query_save.query_name
dw_pdq_case_link.object.link_desc[li_row] = ls_link_desc
dw_pdq_case_link.object.user_id[li_row] = gc_user_id
dw_pdq_case_link.object.link_date[li_row] = ld_datetime 
dw_pdq_case_link.object.link_status[li_row] = LS_LINKSTATUS	// JTM 02/20/98
//	GaryR		01/16/01		Stars 4.7 DataBase Port - End

// FNC 07/14/98 Start
IF dw_pdq_cntl.RowCount() < 1 THEN					//JTM 1/21/98 Added guard against inserting
	li_row = dw_pdq_cntl.insertrow(0)				//into an update datawindow.
else
	li_row = 1
END IF
// FNC 07/14/98 End

// FNC 07/14/98 Change row number from 1 to li_row
dw_pdq_cntl.object.user_id[li_row] = gc_user_id
dw_pdq_cntl.object.query_id[li_row] = asx_query_save.query_id

if match(asx_query_save.query_type,',') then /*more than 1 inv_type then ML*/
	dw_pdq_cntl.object.query_type[li_row] =	'ML'
else
	//	FDG 03/29/01 - Save only 1st 2 bytes of query type
	dw_pdq_cntl.object.query_type[li_row] = Left (asx_query_save.query_type, 2)
end if

// Set the PDR Type
IF This.of_is_pdr_mode() THEN
	This.of_get_pdr_parm( lsx_pdr_parms )
	dw_pdq_cntl.object.addl_query_type[li_row] = lsx_pdr_parms.pdr_type
END IF
	

dw_pdq_cntl.object.create_date[li_row] = ld_datetime
dw_pdq_cntl.object.pdq_type[li_row] = LS_PDQTYPE

dw_pdq_cntl.object.rpt_title[li_row]	=	' '							// FDG 04/13/98
//	GaryR		01/16/01		Stars 4.7 DataBase Port - End

RETURN 1
end event

event type integer ue_subsetting_add_level(ref sx_subsetting_info asx_subsetting_info, string as_subset_id, string as_case_id, string as_inv_type);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_subsetting_add_level					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by w_query_engine.ue_create_subset if a level needs to be 
// added to copy an invoice type from the source subset to the new subset.  If using an 
// ML subset as a source, must include all invoice types from the source subset in the
// new subset even if user does not query against them.  This will create sql just to 
// copy the data from the source subset to the new subset.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument					Datatype					Description
//		---------	--------					--------					-----------
//		reference	asx_subsetting_info	sx_subsetting_info	The subset info.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------

//	J.Mattis		01/08/98		Created.
// FNC			07/16/98		Track 1319. Add database name in front of table name
//									and move source subset id to input id.
//	GaryR			12/08/00		Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	FDG			03/12/01		Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
//	GaryR			04/03/03		Track 3505d	The subset row has changed in the dictionary
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_sql, ls_sub_db

// FNC 07/16/98 Start

Select db 
into :ls_sub_db
From dictionary 
Where elem_type = 'UT'
And elem_tbl_type = 'SS'
Using Stars2ca;

if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca, + &
		'Error reading dictionary to retrieve subset database name in W_Query_Engine.UE_Subsetting_Add_Level.')
	return -1
elseif isnull(ls_sub_db) then
	messagebox('ERROR','The value for DB in the dictionary for Elem Type = "TB" and Elem Name = "SUBSET" is null. Report processing is cancelled')
	return -1
end if

//	12/04/00	GaryR	Stars 4.7 DataBase Port
//ls_sub_db = ls_sub_db + ".."
ls_sub_db = gnv_sql.of_get_database_prefix( ls_sub_db )

// FNC 07/16/98 End

// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
//ls_sql = "SELECT * FROM " + ls_sub_db + "SUB_MEDC_" + as_inv_type + "_" + & 
ls_sql = "SELECT * FROM " + ls_sub_db + gnv_sql.of_get_subset_prefix() + as_inv_type + "_" + & 
			as_subset_id + " " + as_inv_type

asx_subsetting_info.subset_step[1].inv_type = as_inv_type
asx_subsetting_info.subset_step[1].subset_type = 'ML'
asx_subsetting_info.subset_step[1].subc_sub_src_type = 'SS'
asx_subsetting_info.subset_step[1].input_type = 'SUBSET'
asx_subsetting_info.subset_step[1].subc_sub_src_case_id = as_case_id
asx_subsetting_info.subset_step[1].input_id = as_subset_id				// FNC 07/16/98 
asx_subsetting_info.subset_step[1].sql_statement = ls_sql
asx_subsetting_info.source_subset_id = as_subset_id

RETURN 1
end event

event ue_set_menus_new_level();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_set_menus_new_level					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by ue_new_level() to set right mouse menus when Next Level 
// is selected.  Note: See tech spec ts144 - Menu Visibility for details.
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
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	01/13/98		Created.
//	FDG		02/09/98		Changed the visible attribute to enabled to
//								avoid a menu conflict with m_stars_30.
//	FDG		04/14/98		Track 975, 1063.  Set the appropriate menu items
//								based on the total # of levels.
// FNC		05/26/98		Track 1110. If remove a level and only have one level
//								want to enable break with totals. If add a level disable
//								break with totals. Break with totals only valid if 
//								report cols are selected.
// FDG		09/21/01		Stars 4.8.1.  Don't enable if the associated case is
//								closed or deleted
// FNC		10/08/01		Track 2444 Starsdev. Enable break with totals for ML queries.
// FDG		01/07/01
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_level, li_rowcount


// Get the max # of levels for the query
li_level	=	This.wf_get_max_uo_query()

// The drilldown menu is only enabled if there is one level.
IF	li_level	=	1		THEN
	// FDG 09/21/01 begin
	IF	ib_disable_update		THEN
	ELSE
		im_view.m_menu.m_drilldown.enabled = TRUE
	END IF
	// FDG 09/21/01 end

ELSE
	//This.event ue_set_menus_subset_view_break_w_totals(FALSE)						// FNC 10/8/01 FNC 05/26/98
	im_view.m_menu.m_drilldown.enabled = FALSE
END IF

//FNC 10/8/01 As long as report columns are selected, enable break with totals.
li_rowcount	=	iu_active_query.tabpage_report.dw_selected.RowCount()			// FNC 05/26/98 Start
IF li_rowcount	>	0	THEN
	//This.event ue_set_menus_subset_view_break_w_totals(TRUE)
	im_report.m_menu.m_breakwithtotals.enabled = TRUE								// FNC 10/8/01
END IF

end event

event ue_set_menus_drilldown(boolean ab_visible);////////////////////////////////////////////////////////////////////////
//	Script:	ue_set_menus_drilldown
//
//	Arguments:	ab_visible - TRUE  = Enable the menu items
//									 FALSE = Disable the menu items
//
//	Returns:		None
//
//	Description:
//			This event will be called by ue_parent_drilldown()
//			to set menus and menu items 
//			to enabled that are not allowed during 
//			drilldown (ab_visible = FALSE).  This 
//			event will be called by m_view.m_undodrilldown 
//			to set menus and menu items to 
//			enable that have been disabled by drilldown 
//			(ab_visible = TRUE).
////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	FDG		02/09/98		Changed the visible attribute to enabled to
//								avoid a menu conflict with m_stars_30.
//	FDG		02/24/98		Make sure that the undo drilldown menu item
//								is not enabled until the user has drilled down
//								at least once.  Once an undo drilldown is
//								performed (FALSE is passed to this event),
//								then the undo drilldown menu must be disabled.
//	FDG		11/25/98		Track 1990.  The 'Save' menu items also exist
//								under m_report.
//	FDG		01/27/99		Track 2083c.  Disable the saving of report
//								templates while in drilldown.  
// FDG		09/21/01		Stars 4.8.1.  Don't enable if the associated case is
//								closed or deleted
//	GaryR		10/16/01		Track 2493d	Disable the creation of subsets while in drilldown
//	GaryR		02/25/03		Track 3452d	Account for drilldown with subset as base
//	GaryR		05/12/03		Track 3017c	Allow one drilldown level
//	GaryR		06/23/03	Track 2769d	Clean up drilldown/undodrilldown menu options
///////////////////////////////////////////////////////////////////////

Boolean	lb_switch

//	Set lb_switch to be the opposite of ab_visible
lb_switch = NOT ab_visible

// FDG 09/21/01 begin
IF	ib_disable_update		THEN
	Return
END IF
// FDG 09/21/01 end

im_search.m_menu.m_save.enabled = ab_visible 						//	GaryR		10/16/01		Track 2493d
im_report.m_menu.m_save.enabled = ab_visible
// FDG 11/25/98 begin
im_view.m_menu.m_save.m_createsubset.enabled = ab_visible 						//	GaryR		10/16/01		Track 2493d
im_view.m_menu.m_save.m_criteriasave.enabled = ab_visible 
im_view.m_menu.m_save.m_querysave.enabled = ab_visible
im_view.m_menu.m_save.m_querysaveas.enabled = ab_visible

im_view.m_menu.m_undodrilldown.enabled = lb_switch			// FDG 02/24/98
im_report.m_menu.m_undodrilldown.enabled = lb_switch		// FDG 02/25/98
im_search.m_menu.m_undodrilldown.enabled = lb_switch		// FDG 02/25/98
im_source.m_menu.m_undodrilldown.enabled = lb_switch		// FDG 02/25/98

im_search.m_menu.m_filters.enabled = ab_visible
im_search.m_menu.m_nextlevel.enabled = ab_visible
im_view.m_menu.m_nextlevel.enabled = ab_visible
im_view.m_menu.m_drilldown.enabled = ab_visible

// FDG 01/27/99 begin
im_report.m_menu.m_reporttemplatesave.enabled	=	ab_visible
im_report.m_menu.m_reporttemplatesaveas.enabled	=	ab_visible
// FDG 01/27/99 end

im_source.m_menu.m_clear.enabled = ab_visible
im_source.m_menu.m_reset.enabled = ab_visible
end event

event ue_list_report_template();//ue_list_report_template()
//This event will be called by the im_report.m_reporttemplatelibrary 
//to open the Report Template Library window.  
//The window will be passed the invoice types being used in this 
//uo_query so that it can get the related templates.  
//Once the window is open the user is able to select a report 
//template to use in the query.  
//When the window is closed the template is saved into a datastore 
//and the columns are loaded into the selected datawindow.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	??				??				Created.
//	J.Mattis		02/04/98		Added call to get invoice types method.
//	J.Mattis		02/05/98		Added code for ML subsets.
//	F.Chernak	04/22/98		Track 983. Add MC to invoice types for ML subset because
//									common cols that are on a template are prefixed with MC.
//									Any ML subset can have MC columns selected. Place an ML
//									at the beginning of invoice types for ML subsets so that
//									W_Report_Template_List
// F.Chernak	03/25/99		Rls Stars 4.0 Sp2 Track 2164 Starcare TS2164C. 
//									Move data source and additional data source into separate
//									variables so that they are passed to w_report_template_list
//									in separate variables. W_report_template_list will display
//									both data sources.
//Archana		2/3/00		Fs/Ts 2414c Unable to view ML subset using ML template.
//									Add correct parameters to pass to w_report_template_list if subset is ML.
// 03/03/05 MikeF SPR4340d	Error when retrieving templates on drilldown
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

//string ls_ml_inv_types[], ls_inv_types_parm
string ls_data_source,ls_additional_data_Source,ls_data_sources_parm
string ls_template_id
Constant String S_MULTILEVELSUBSET = 'ML'
string ls_inv_types_parm

ls_data_source = iu_active_query.of_GetInvoiceType ()
//2-3-99 Archana  					***Begin***
If Upper(Left(Trim(ls_data_source),2)) = S_MULTILEVELSUBSET Then
	//get the invoice types AVAILABLE in this query
	ls_inv_types_parm = iu_active_query.of_GetAvailableInvoiceTypes()
	ls_inv_types_parm = 'ML,' + ls_inv_types_parm + ',MC'
	openwithparm(w_report_template_list,ls_inv_types_parm)
Else
	ls_additional_data_source = iu_active_query.of_get_add_inv_type()
	if  trim(ls_additional_data_source) <> '' &
	AND ls_additional_data_source <> ls_data_source then
		ls_data_sources_parm = ls_data_source + '~t' + ls_additional_data_source
	else
		ls_data_sources_parm = ls_data_source
	end if
	openwithparm(w_report_template_list,ls_data_sources_parm)
End If
//2-3-99 Archana 				***END***

ls_template_id = message.stringparm

if Upper(Trim(ls_template_id)) = 'CANCEL' then  /* user canceled */
	return
end if

iu_active_query.event ue_tabpage_report_load_template(ls_template_id)
end event

event ue_save_report_template;call super::ue_save_report_template;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_save_report_template					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//This event will be called by the Report Template Save and 
//Report Template Save As right mouse menu items on im_report.  
//It will open the Report Template Save window to allow the user 
//to enter the report id and description then will save an entry 
//to the case_link and pdq_cntl tables.  Then will loop thru the 
//tabpage_report.dw_selected datawindow and save those columns to 
//the pdq_columns table.  To save the information there will be 
//three datastores local to uo_query which are created when a 
//report template is used or if saving for the first time and 
//destroyed when the uo_query is destroyed.  These datastores 
//will be used by both the retrieve of templates and the save of 
//templates.
//If this window is opened as a Save (S) window then must get the 
//report id, name and description from these local datastores 
//to populate w_report_template_save else use the title to populate 
//the description field. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			as_path		String
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	john_wo 	01/22/98		Add code to w_query_engine
//	FNC		04/28/98		Track 1135 Move statement that checks for an 'N' in
//								lsx_report_template_save.path before statement that moves
//								as_path into lsx_report_template_save.path
//	NLG		08/26/98		ts144 Report on enhancements
//	FDG		10/14/98		Track 1714.  Remove logic to carry report title to the
//								report template description.
/////////////////////////////////////////////////////////////////////////////


sx_report_template_save lsx_report_template_save 
/* defined in ts144 - w_report_template_save */
lsx_report_template_save.path = as_path

if as_path = 'S' then
	if iu_active_query.event ue_tabpage_report_get_template_info(lsx_report_template_save) = -1 then
		return
	end if
else
	// FDG 10/14/98 - remove the setting of report_template_desc
	//lsx_report_template_save.report_template_desc = iu_active_query.event ue_tabpage_report_get_title()
	
	// get the invoice type
	lsx_report_template_save.report_template_type = iu_active_query.of_GetInvoiceType()
end if

/* NLG 8-25-98 Report on enhancements.  Get additional data source .*/
lsx_report_template_save.report_template_addl_type = iu_active_query.of_get_add_inv_type() 

/* NLG 8-25-98 Report on enhancements.  Get the default template indicator.*/
if lsx_report_template_save.report_template_id <> '' then 
	lsx_report_template_save.report_template_default = iu_active_query.of_get_default_ind(gc_user_id,&
		lsx_report_template_save.report_template_id,lsx_report_template_save.report_template_type,&
		lsx_report_template_save.report_template_addl_type)
end if

openwithparm(w_report_template_save, lsx_report_template_save)

lsx_report_template_save = message.Powerobjectparm

If lsx_report_template_save.path = 'N' then 	//04/28/98 FNC Start
	return
End If													//04/28/98 FNC End

lsx_report_template_save.path = as_path		
	

iu_active_query.event ue_tabpage_report_save_template(lsx_report_template_save)

end event

event ue_select_pdq();///////////////////////////////////////////////////
//	Script:	ue_select_pdq
//
//	Description:
//
//		This event is triggered from cb_select and
//		when the d/w on the PDQ tab is double-clicked.
//
// 	First make sure the PDQ is not linked to a 
// 	secure case that the user does not belong to.
// 	If Query Engine is being used as a lookup 
//		(see Entry Point #3) then must put the selected
// 	query id into a global since cannot close a main
//		window with return parms (see ts144 -
// 	w_query_engine parms).  Else call uo_query event
//		which will to load the query hilighted 
// 	in dw_list datawindow on iu_active_query.tabpage_list.
//		Will retrieve the data from the
// 	pdq tables and load them into the invisible 
//		datawindows on w_query_engine.  Then must use 
// 	the data in the invisible windows to determine 
//		how many levels must be opened for the 
// 	selected query.  For each level must make a 
//		tabpage visible on tab_level and open a new
// 	uo_query.  Make the Next button enabled and 
//		make Notes and Link visible on the List right
// 	mouse menu..  If using this window just to list
//		queries, then get query_id and return it
// 	when close the window.
//////////////////////////////////////////////////////////
//	History
//
//	12/31/97	???	Created
//
//	01/27/98	FDG	Moved from cb_select
//	02/19/98	JTM	Added call to get the user id and send it to 
//						the case link retrieve.
//	04/01/98	FDG	Track 1003.  Perform Closequery processing
//						on the previous query before selecting
//						the new query.
//	04/22/98	FDG	Track 1104.  ab_switch is passed to event 
//						ue_set_menus_query_select to
//						enable the appropriate menu items.
// 07/14/98 FNC 	Track 1264. Must pass case id to ue_load_pdq_dws because when 
//						retrieve case link entries there could be more than one entry
//						per query id because the none entry will not be removed.
//	12/04/98	FDG	Track 2004.  Pass a true/false argument to
//						ue_enable_next_button.  Set focus to dw_search.
//	12/03/99	NLG	Show notes icon if selected pdq has notes 
// 12/09/99	FNC	Display source tab after user selects a query
// 03/16/00 FNC	Track 2143 Stardev. Move select tab inside of if so
//						it doesn't get executed if in "USE" mode.
// 09/21/01	FDG	Stars 4.8.1.  Don't allow updates if the PDQ's associated
//						case is closed or deleted.
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
//////////////////////////////////////////////////////////

String	ls_QueryId, 	&
			ls_UserId,		&
			ls_CaseId,		&
			ls_CaseSpl, 	&
			ls_CaseVer
Integer	li_level_num,	&
			li_rc
Long		ll_rc

n_cst_case		lnv_case			// FDG 12/21/01

//	FDG 04/01/98 begin
// Determine if the previous query needs to be saved.
ll_rc			=	This.Event	CloseQuery()

IF	ll_rc		<>	0		THEN
	// Either an error or a cancel occured in CloseQuery.  Get out.
	Return
END IF
// FDG 04/01/98 end

ls_CaseId	=	iu_active_query.event ue_tabpage_list_get_selected_case_id()
ls_CaseSpl	=	iu_active_query.event ue_tabpage_list_get_selected_case_spl()
ls_CaseVer	=	iu_active_query.event ue_tabpage_list_get_selected_case_ver()

// determine if user has security to open this query
li_rc	=	iu_active_query.of_GetCaseSecurity (ls_CaseId,ls_CaseSpl,ls_CaseVer)

if li_rc < 0 then
	return
end if

ls_QueryId = iu_active_query.event ue_tabpage_list_get_selected_query_id()
ls_UserId = iu_active_query.event ue_tabpage_list_get_selected_user_id()

IF is_query_id = 'USE'		THEN
	gnv_app.of_set_query_id(ls_QueryId)
	Close(This)
ELSE
	This.setredraw(FALSE)
	// FDG 09/21/01 begin
	Boolean	lb_valid_case
	// FDG 12/21/01 change inv_case to lnv_case
	lnv_case	=	CREATE	n_cst_case
	lb_valid_case	=	lnv_case.uf_edit_case_closed (ls_caseid, ls_casespl, ls_casever)
	Destroy		lnv_case
	// FDG 12/21/01 end
	IF	lb_valid_case	=	TRUE		THEN
		ib_disable_update	=	FALSE
		w_main.SetMicroHelp ('Ready')
	ELSE
		ib_disable_update	=	TRUE
		w_main.SetMicroHelp ('This query cannot be updated since its associated case is closed or deleted')
	END IF
	This.Event	ue_set_menus_subset_view (lb_valid_case)
	// FDG 09/21/01 end
	
	// FNC 07/14/98
	This.event ue_load_pdq_dws(ls_QueryId,ls_UserId,ls_caseid,ls_casespl,ls_casever)
	iu_active_query.of_set_ib_new_flag( FALSE )
		
	li_level_num = This.event ue_get_level_num()			//get the max level number, NOTE: ue_get_level_num
																		//assumes the first row is the max.!
	This.event ue_show_levels(li_level_num)
	This.event ue_load_query(li_level_num)
	This.event ue_set_pdq_title()
	This.event ue_enable_next_button(TRUE)					// FDG 12/04/98
	This.event ue_set_menus_query_select(TRUE)			// FDG 04/22/98
	This.event ue_set_unique_count(0, '')					//	Clear out the unique counts
	This.wf_setrowdelete(FALSE)								// FDG 04/02/98
	iu_active_query.tabpage_list.dw_search.SetFocus()	// FDG 12/04/98
	this.event ue_show_notes_icon(ls_caseid+ls_casespl+ls_casever)							// NLG 12/03/99
	iu_active_query.Event	ue_SelectTab(ic_search)			// FNC 12/09/99, 03/16/00
	This.setredraw(TRUE)
END IF
end event

event ue_set_unique_count;call super::ue_set_unique_count;///////////////////////////////////////////////////
//	Script:	ue_set_unique_count
//
//	Arguments:
//			al_count -	The unique count for the selected
//							menu item
//			as_type -	The text of the selected menu item
//
//	Returns:	None
//
//	Description:
//
//		This event is triggered from 
//		uo_query.ue_tabpageview_unique_count() to set the
//		unique count for the menu item selected from the
//		right mouse menu on tabpage_view.
//
//////////////////////////////////////////////////////////
//	History
//
//	01/27/98	FDG	Created
//	
//	05/12/98	FDG	Track 1223.  st_unique_count is now on
//						the View tab page.
//
//////////////////////////////////////////////////////////

CHOOSE CASE as_type
	CASE ics_icn				// ICN
		iu_active_query.tabpage_view.st_unique_text_view.text	=	'Unique Claims'
	CASE ics_providers		// Providers
		iu_active_query.tabpage_view.st_unique_text_view.text	=	'Unique Providers'
	CASE ics_patients			//	Patients
		iu_active_query.tabpage_view.st_unique_text_view.text	=	'Unique Patients'
	CASE ics_revenue			//	Revenue
		iu_active_query.tabpage_view.st_unique_text_view.text	=	'Unique Revenue Codes'
	CASE ics_patsrvc			//	Patsrvc
		iu_active_query.tabpage_view.st_unique_text_view.text	=	'Unique Patients with Allwd Srvc > 0'
	CASE ELSE
		iu_active_query.tabpage_view.st_unique_text_view.visible	=	FALSE
		iu_active_query.tabpage_view.st_unique_text_view.visible	=	FALSE
		Return
END CHOOSE

iu_active_query.tabpage_view.st_unique_text_view.visible		=	TRUE

iu_active_query.tabpage_view.st_unique_count_view.text		=	String (al_count)
iu_active_query.tabpage_view.st_unique_count_view.visible	=	TRUE


end event

event type integer ue_set_menus_break_with_totals(boolean ab_flag);// This event will be called by m_report.m_breakwithtotals to set right mouse menus. 
// When Break with Totals is selected the menu items will be made invisible and when 
// it is deselected, the menu items will be made visible.   Note: See tech spec ts144 - 
// Menu Visibility for details.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	FDG				02/09/98		Changed the visible attribute to enabled to
//										avoid a menu conflict with m_stars_30.
// AJS 				01/25/99		Disable money unit totals when break with totals on
//	GaryR				09/08/06		Track 4814	Handle sorting on Money/Unit/Break w/ Totals in QE
//	09/10/09	GaryR	QEN.650.5229.006	Add statistical and arithmetic functions to QE reports
//
/////////////////////////////////////////////////////////////////////////////

im_view.m_menu.m_windowoperations.m_sortrank.enabled = ab_flag 
im_view.m_menu.m_windowoperations.m_displayfilter.enabled = ab_flag
im_view.m_menu.m_statistics.enabled = ab_flag		//ajs 01/25/99 FS2075c 4.1
ib_break_with_totals = NOT ab_flag

RETURN 1
end event

event type integer ue_break_with_totals();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_query_engine				ue_break_with_totals	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event will be called by the im_report.m_breakwithtotals to create a report 
// that may contain sorted columns with total breaks.  First it opens a window 
// (w_subset_sort) displaying all the columns selected for the report columns. 
// Once the user determines which columns and what type of sort/break, the information
// is stored in an instance variable in uo_query.  When the user clicks the View Report 
// tab this structure is used to alter the SQL to add the sort order columns.  If breaks 
// are included then once the datawindow is created, it's sql syntax will be altered to 
// display the breaks and totals before the retrieve.  Note:  This functionality can only
// be allowed when doing a single retrieve on the datawindow since the syntax of the 
// datawindow is manipulated and an ORDER BY is added to the sql.  Thus only allowed 
// when doing subset view on a single invoice type (current functionality).
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success	
//						-1			No report columns selected.
//						-2			No sort columns selected
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		02/06/98		Created.
// FNC			05/27/98		Track 1252. 
//									1.Move code from m_report.m_breakwithtotals.
//									2.If break info already selected pass it to w_subset_sort.
// Katie			12/15/04		Track 4121d Added code for col_name and col_number in sx_break_info
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

sx_col_desc lsx_columns[] /* defined in ts144 -uo_query */
sx_col_desc_parm lsx_ColumnParm	
sx_break_info lsx_break_info /* defined in ts144 - Break with Totals */

integer li_upperbound_cols, li_col_num
// FNC 05/27/98 Start
if upperbound(iu_active_query.istr_break_info.cols) > 0 then
	lsx_ColumnParm.break_info = iu_active_query.istr_break_info
end if 
// FNC 05/27/98 End

iu_active_query.event ue_tabpage_report_get_selected_columns(lsx_columns)
lsx_ColumnParm.columns = lsx_columns			
// check if columns returned
li_upperbound_cols = UpperBound(lsx_columns)
IF li_upperbound_cols > 0 THEN
	for li_col_num = 1 to li_upperbound_cols
		lsx_break_info.cols[li_col_num].col_desc = lsx_columns[li_col_num].col_desc
		lsx_break_info.cols[li_col_num].col_data_type = lsx_columns[li_col_num].data_type
		lsx_break_info.cols[li_col_num].col_name = lsx_columns[li_col_num].col_name
		lsx_break_info.cols[li_col_num].col_number = lsx_columns[li_col_num].col_number
	next
	openwithparm(w_subset_sort,lsx_ColumnParm)
ELSE
	RETURN -1
END IF

lsx_break_info = message.Powerobjectparm

if upperbound(lsx_break_info.cols) = 0 then
	iu_active_query.event ue_tabpage_report_clear_break_info() 
	this.event ue_set_menus_break_with_totals(TRUE)
else
	this.event ue_set_menus_break_with_totals(FALSE)
end if

//FNC 05/27/98 End
	
iu_active_query.event ue_tabpage_report_set_break_info(lsx_break_info)

return 0
end event

event ue_set_menus_super_provider_query(boolean ab_switch);//*********************************************************************
//	Script:	ue_set_menus_super_provider_query
//
//	Arguments:	ab_switch
//					TRUE = Enable the menu items
//					FALSE= Disable the menu items
//
//	Description:
// This event is called by uo_query.tabpage_search.itemchanged event
//	if Super Provider is selected to set certain right-mouse menu items
//	to enabled/disabled.  Break with totals is only visible if subset
//	view with a single invoice type.
//
//*********************************************************************
//	History
//
//	FDG	02/11/98	Created
// FDG	09/21/01	Stars 4.8.1.  Don't enable if the associated case is
//						closed or deleted
//	GaryR	09/01/05	Track 4493d	Do not enable in drilldown mode
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
//*********************************************************************

// FDG 09/21/01 begin
IF	ib_disable_update		THEN
	Return
END IF
// FDG 09/21/01 end

// Do not set in drilldown mode
IF iu_active_query.of_get_ib_drilldown() THEN Return

//	Make sure that both Super Provider 
//	and Super NPI Provider are turned off
IF ab_switch THEN
	IF iu_active_query.istr_prov_query.do_prov_query &
	OR iu_active_query.istr_npi_prov_query.do_prov_query THEN Return
END IF

IF	IsValid (im_search)		THEN
	im_search.m_menu.m_nextlevel.enabled	=	ab_switch
END IF

IF	IsValid (im_view)		THEN
	im_view.m_menu.m_nextlevel.enabled	=	ab_switch
	im_view.m_menu.m_drilldown.enabled	=	ab_switch
END IF

end event

event ue_get_active_level_num;call super::ue_get_active_level_num;//*********************************************************************
//	Script:	ue_get_active_level_num
//
//	Arguments:	none
//					
//	Returns:		Integer
//
//	Description:
// This event is called by uo_query.ue_tabpage_search_ml_filter_check()
//	to determine the current level_number.
//
//*********************************************************************
//	History
//
//	FDG	02/11/98	Created
//
//
//*********************************************************************

Return	ii_level_num

end event

event ue_parent_undo_drilldown();//*********************************************************************
//	Script:	ue_parent_undo_drilldown
//
//	Arguments:	None
//
//	Returns:	None
//
//	Description:
// 	This event is called by m_view.m_undodrilldown.  It will drop the
//		temp table created during the drilldown and close the active
//		user object.  This will return the user to the prior user
//		object.  Finally, the menus are reset.
//
//*********************************************************************
//	History
//
//	FDG	02/12/98	Created
//	JTM	02/20/98	Altered logic to close the 'drilldown query', and to reset
//						the active query.
//	FDG	02/25/98	1. Made the original uo_query visible
//						2. Reset the drilldown menus. 
//	FDG	04/14/98	Track 975, 1063.  When undoing a drilldown (which can
//						only occur on the 1st level), determine if the
//						invoice type is an ancillary table.  If so, disable
//						the appropriate menu items.
//	FDG	05/28/98	Track 1287.  Recover uo_query.istr_drilldown
//						from istr_prev_drilldown.
//	FDG	09/09/98	No track #.  When undoing a drilldown, set the print
//						d/w to the original d/w on tabpage_view.
//	FDG	11/20/98	Track 1946.  Reset uo_query.ib_drilldown_mode.
// LahuS  4/23/02 Track 2552d  Undo PDR Drilldown
//	GaryR	06/23/03	Track 2769d	Clean up drilldown/undodrilldown menu options
//	GaryR	10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR	12/11/04	Track 4108d	Dynamic Report Options
//	GaryR	12/13/04	Track 4148d	Execute the validate event to enable tabs
//	GaryR	01/05/05	Track	4180d	Redesign drilldown control flow
//*********************************************************************

Boolean	lb_ancillary_inv_type

sx_drilldown	lstr_drilldown,		&
					lstr_null_drilldown
sx_pdr_parms	lsx_pdr_parms					
					
//Lahu S 4/23/02 Track 2552d Begin	
//	PDRs that require undo drilldown.
IF This.of_is_pdr_mode() THEN
	This.of_get_pdr_parm( lsx_pdr_parms )

	ii_ctr --
	this.setredraw(false)
	iu_active_query.tabpage_pdr.dw_pdr.object.DataWindow.ReadOnly	=	'No'
	iu_active_query.tabpage_pdr.dw_pdr.SetColumn("pdr_cat")
	iu_active_query.tabpage_pdr.dw_pdr.SetText( incst_drilldown[ii_ctr].pdr_cat )
	iu_active_query.tabpage_pdr.dw_pdr.accepttext()
	iu_active_query.tabpage_pdr.dw_pdr.SetColumn("pdr_type")
	iu_active_query.tabpage_pdr.dw_pdr.SetText( incst_drilldown[ii_ctr].pdr_type )
	iu_active_query.tabpage_pdr.dw_pdr.accepttext()
	iu_active_query.tabpage_pdr.dw_pdr.SetColumn("pdr_report")
	iu_active_query.tabpage_pdr.dw_pdr.settext(incst_drilldown[ii_ctr].pdr)						
	iu_active_query.tabpage_pdr.dw_pdr.accepttext()

	iu_active_query.tabpage_pdr.dw_pdr.object.DataWindow.ReadOnly	=	'Yes'
	
	iu_active_query.tabpage_report.uo_report_options.of_load( incst_drilldown[ii_ctr].isx_report_options)
	
	//	Check if source needs to be carried down
	IF lsx_pdr_parms.pdr_source > 0 THEN
		iu_active_query.tabpage_source.dw_source.object.data = & 
			incst_drilldown[ii_ctr].ids_source.object.data
			
		//	Validate sources
		iu_active_query.event ue_tabpage_pdr_validate_source()
	END IF
	
	if incst_drilldown[ii_ctr].ids_criteria.rowcount() > 0 then
		iu_active_query.tabpage_search.dw_criteria.object.data = & 
			incst_drilldown[ii_ctr].ids_criteria.object.data
	end if

	if ii_ctr = 1 then
		im_view.m_menu.m_undodrilldown.enabled = FALSE
		im_pdr.m_menu.m_undodrilldown.enabled = FALSE			
		im_report.m_menu.m_undodrilldown.enabled = FALSE
		im_search.m_menu.m_undodrilldown.enabled = FALSE
		iu_active_query.tabpage_pdr.dw_pdr.object.DataWindow.ReadOnly	=	'No'
	end if
	
	iu_active_query.selecttab("tabpage_pdr")
	iu_active_query.selecttab("tabpage_view")	
	
	This.SetRedraw( TRUE )
	
	Return 
end if
//Lahu S 4/18/02 Track 2552d End			

//	Drop the temp table
iu_active_query.Event ue_drilldown_drop_temp_table()

// Close the 'drilldown query'
CloseUserObject(iu_active_query)

//	make the previous user object (the one 'saved' in ue_parent_drilldown) active.
iu_active_query =	iu_previous_query
iu_active_query.visible	=	TRUE

This.Event	ue_set_menus_drilldown ( TRUE )
This.Event	ue_set_menus_data_source ( iu_active_query.is_source_type,			&
													iu_active_query.is_inv_type,				&
													'')

// Reset uo_query.ib_drilldown_mode
iu_active_query.of_set_ib_drilldown_mode (FALSE)			// FDG 11/20/98

// FDG 05/28/98 begin
// Recover uo_query.istr_drilldown from istr_prev_drilldown
lstr_drilldown	=	iu_active_query.of_get_istr_prev_drilldown()
iu_active_query.of_set_istr_drilldown(lstr_drilldown)
// FDG 05/28/98 end

// FDG 04/14/98	begin
lb_ancillary_inv_type	=	iu_active_query.of_get_ancillary_inv_type()

This.Event	ue_remove_all_levels (lb_ancillary_inv_type)
// FDG 04/14/98 end

This.of_SetPrintDW (iu_active_query.tabpage_view.dw_report)		// FDG 09/09/98

end event

event type integer ue_open_uo_query(ref uo_query auo_query, sx_drilldown_parms astr_drilldown_parms, string as_level);///////////////////////////////////////////////////////////////////////
//	Script:	ue_open_uo_query
//
//	Arguments:
//				1. auo_query (type uo_query)
//				2. astr_drilldown_parms (type sx_drilldown_parms)
//				3. as_level (type string) - Passed to ue_tabpage_source_construct
//								Values:	'INITIAL_LEVEL' - from ue_preopen
//											'NEW_LEVEL' - from wf_newlevel()
//
//	Returns:	Integer
//
//	Description:
// 	This event will open uo_query using openuserobject and trigger
//		the ue_tabpage_source_construct to initialize uo_query.
//
//	NOTE:
//		This should be the only script creating uo_query.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	02/11/98	Created
//
//	FDG	02/25/98	Fill in the parms from drilldown before 
//						ue_tabpage_source_construct executes.
//
//	FDG	03/05/98	Reset the windows colors for uo_query
//
//	FDG	04/14/98	Track 975, 1063.  Don't do source construct when
//						opening the window.
//	LahuS 12/21/01 Track 2552d Set PDR type dw object
//	GaryR	10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR	10/22/04	Standardize the appearance
///////////////////////////////////////////////////////////////////////

Integer		li_rc,		&
				li_max,		&
				li_x,			&
				li_y,			&
				li_level
Boolean		lb_switch

// Level 1 has a different offset than the other levels

IF	ib_opening_window		THEN
	li_y	=	tab_level.y		+	80
ELSE
	li_y	=	tab_level.y		+	120
END IF

li_x		=	tab_level.x		+	15

This.OpenUserObject ( auo_query, li_x, li_y )

//	FDG	02/25/98		Begin
auo_query.istr_drilldown	=	astr_drilldown_parms.sx_drilldown_parm

IF	UpperBound (astr_drilldown_parms.sx_drilldown_criteria)	>	0		THEN
	auo_query.istr_drilldown_criteria	=	astr_drilldown_parms.sx_drilldown_criteria
END IF
//	FDG	02/25/98		End

lb_switch	=	This.Event	ue_set_window_colors (auo_query.Control)	// FDG 03/05/98

IF	Upper(as_level)	<>	'OPEN'		THEN	
	li_rc	=	auo_query.Event ue_tabpage_source_construct ( as_level, '' )
END IF

//Lahu S 12/21/01 begin set PDR type dw object
auo_query.of_set_engine_mode (istr_parms.query_engine_mode )
//Lahu S 12/21/01 end

//	ue_tabpage_source_construct resets is_inv_type which is why
//	the following IF statement is performed here.
IF	Trim (astr_drilldown_parms.is_inv_type)	>	' '	THEN
	auo_query.is_inv_type	=	astr_drilldown_parms.is_inv_type
END IF


Return	li_rc
end event

event ue_set_ml_subset_type;call super::ue_set_ml_subset_type;/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_set_ML_subset_type							W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	This event will be called by w_query_engine.ue_create_subset() to set the subset
//	type on every level = ML if the new subset will be an ML subsets
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument						Datatype					Description
//		---------	--------						--------					-----------
//		Reference	astr_subsettting_info	sx_subsetting_info	The structure passed
//																					to w_subset_options
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
// None
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	F.Chernak		03/03/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

integer li_num_levels, li_num_steps, li_level, li_step

li_num_levels = upperbound(astr_subsetting_info)

for li_level = 1 to li_num_levels
	li_num_steps = upperbound(astr_subsetting_info[li_level].subset_step)
	for li_step = 1 to li_num_steps
		astr_subsetting_info[li_level].subset_step[li_step].subset_type = 'ML'
	next
next

end event

event ue_get_source_subset_type;/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_get_source_subset_type						W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	This event will be called by w_query_engine.ue_create_subset() to determine the 
//	subset type of the source subset, if the source of the new subset is a subset
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			as_subset_id	String				The subset id.
//		Reference	as_subset_type	String				The source subset type
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success
//						-2				transaction error.
//						-1				Data error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	F.Chernak	03/03/98		Created.
//
//	FDG			03/19/98		Track 944.  Make sure that the create object is
//									always destroyed.
// FNC			04/15/99		FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//									to prevent locking.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

/*	select subc_sub_tbl_type
	from sub_cntl
	where subc_id = as_subset_id */
	
n_Ds lds_source_type

String s_Null[]
Integer li_rowcount, i


lds_source_type = Create n_Ds

lds_source_type.dataobject = "d_subset_source_type"

IF lds_source_type.SetTransObject(stars2ca) <> 1 THEN
	MessageBox("Error","Could not assign transaction to obtain subset invoice type.",StopSign!)
	Destroy	lds_source_type				// FDG 03/19/98
	return -2
END IF

li_rowcount = lds_source_type.Retrieve(as_subset_id)

If li_RowCount < 0 THEN
	MessageBox("Error","Error retrieving subset invoice type from SUB_STEP_CNTL table. " + &
	"Please contact your database administrator.",StopSign!,Ok!)
	Destroy	lds_source_type				// FDG 03/19/98
	return -1
else												// FNC 04/15/99
	stars2ca.of_commit()						// FNC 04/15/99
End If

as_sub_src_type = lds_source_type.getitemstring(1,'subc_sub_tbl_type')

Destroy lds_source_type

RETURN 1
end event

event type integer ue_delete_pdq_data(string as_query_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_delete_pdq_data						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by the Query Save (S) and Link (L) menu  
//	items (from ue_save_query).  This event will delete all data
// associated with the passed query ID.  This will occur to the
//	following datawindows:
// 	dw_pdq_columns
//		dw_pdq_tables
// 	dw_pdq_criteria
//	This event is necessary because a level could have been deleted or
// because an existing PDQ was saved twice.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			as_query_id	String		The query ID to remove from
//														the pdq datawindows.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value		Description
//		--------		-----		-----------
//		Integer		 1			Success.
//						 0			No data to delete.
//						-1			Failure.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date		Description
// ------		----		-----------
//	FDG			03/25/98	Track 981.  Created.
//	FDG			05/11/98	Track 1214.  Delete the data in PDQ_COLUMNS that
//								has any Super Provider (SPQ) data.
//	FDG			05/14/98	Track 1214, 1201.  Embedded SQL is needed to delete the
//								SPQ data because it may not exist in dw_pdq_columns.
//								However, there are times where SPQ data does exist
//								in dw_pdq_columns.
//	FDG			05/28/98	Track 1201.  After deleting the 'SPQ' thru embedded
//								SQL, discard these rows in the d/w.
//	GaryR			11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
/////////////////////////////////////////////////////////////////////////////

// Edit the passed query ID.
IF	IsNull (as_query_id)				&
OR	Trim (as_query_id)	<	' '	THEN
	// No query to process
	Return 0
END IF

Long		ll_row,				&
			ll_rowcount
String	ls_query_id,		&
			ls_sql,				&
			ls_col_type
Integer	li_rc

// Unfilter any previously filtered data in all 3 of the pdq datawindows.
This.wf_SetLevelFilter (0, 'ALL')


// Remove from dw_pdq_columns

ll_rowcount		=	dw_pdq_columns.RowCount()

// FDG 05/11/98 begin
//	Delete any Super Provider data (SPQ) from pdq_columns (in case this
//	query was previously defined as a Super Provider query).

ls_sql	=	"Delete from pdq_columns Where query_id = '"	+	&
				Upper( as_query_id )	+	"' And col_type = 'SPQ'"
				
li_rc		=	Stars2ca.of_execute(ls_sql)

IF	li_rc	<	0		THEN
	MessageBox ('Database Error', 'Could not delete SPQ data from pdq_columns.  ' + &
					'Script: w_query_engine.ue_delete_pdq_data)')
END IF

// FDG 05/11/98 end

//	Delete any Super NPI Provider data (NPQ) from pdq_columns (in case this
//	query was previously defined as a Super NPI Provider query).
ls_sql	=	"Delete from pdq_columns Where query_id = '"	+	&
				Upper( as_query_id )	+	"' And col_type = 'NPQ'"
				
li_rc		=	Stars2ca.of_execute(ls_sql)

IF	li_rc	<	0		THEN
	MessageBox ('Database Error', 'Could not delete NPQ data from pdq_columns.  ' + &
					'Script: w_query_engine.ue_delete_pdq_data)')
END IF

FOR ll_row = 1 TO	ll_rowcount
	//	Make sure query IDs match before deleting
	ls_query_id	=	dw_pdq_columns.object.query_id [ll_row]
	ls_col_type	=	dw_pdq_columns.object.col_type [ll_row]	// FDG 05/14/98
	IF	ls_query_id		=	as_query_id			THEN
		IF ls_col_type	=	'SPQ' or ls_col_type	=	'NPQ'	THEN					// FDG 05/28/98
			// Super providers already deleted thru the previous
			//	embedded SQL
			dw_pdq_columns.RowsDiscard (ll_row, ll_row, Primary!)
 			ll_row --
			ll_rowcount --
		ELSE
			// Found the query ID, delete it
			dw_pdq_columns.DeleteRow(ll_row)
 			ll_row --
			ll_rowcount --
		END IF
	END IF
NEXT

// Remove from dw_pdq_tables

ll_rowcount		=	dw_pdq_tables.RowCount()

FOR ll_row = 1 TO	ll_rowcount
	//	Make sure query IDs match before deleting
	ls_query_id	=	dw_pdq_tables.object.query_id [ll_row]
	IF	ls_query_id	=	as_query_id		THEN
		// Found the query ID, delete it
		dw_pdq_tables.DeleteRow(ll_row)
		ll_row --
		ll_rowcount --
	END IF
NEXT

// Remove from dw_pdq_criteria

ll_rowcount		=	dw_pdq_criteria.RowCount()

FOR ll_row = 1 TO	ll_rowcount
	//	Make sure query IDs match before deleting
	ls_query_id	=	dw_pdq_criteria.object.query_id [ll_row]
	IF	ls_query_id	=	as_query_id		THEN
		// Found the query ID, delete it
		dw_pdq_criteria.DeleteRow(ll_row)
		ll_row --
		ll_rowcount --
	END IF
NEXT

// Remove from dw_pdr_sources
IF This.of_is_pdr_mode() THEN
	ll_rowcount		=	dw_pdr_sources.RowCount()
	
	FOR ll_row = 1 TO	ll_rowcount
		//	Make sure query IDs match before deleting
		ls_query_id	=	String( dw_pdr_sources.object.pdr_link [ll_row] )
		IF	ls_query_id	=	as_query_id		THEN
			// Found the query ID, delete it
			dw_pdr_sources.DeleteRow(ll_row)
			ll_row --
			ll_rowcount --
		END IF
	NEXT
END IF

Return 1
end event

event ue_remove_level();/////////////////////////////////////////////////////////////////////////////
// Script:	ue_remove_level	
// 
//	Arguments:	None
//
//	Returns:		None
//
// Description:
//		This event "undoes" everything that function wf_newlevel() does.  It 
//		logically removes the last tab from the window.
//
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	FDG	03/26/98	Track 982.  Created.
//
//	FDG	04/14/98	Track 975, 1063.  Every time a level is added or removed
//						trigger an event to set the appropriate menu items.
//	GaryR	11/28/08	SPR 5591	Do not set array item to null it crashes in PB11
//	GaryR	05/21/09	GNL.600.5633.005	Apply focus for keyboard users (Section 508)
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_rc,				&
			li_level,			&
			li_controlrange

// Get the # of controls in the control array.  The last control
//	is the most recently created uo_query.
li_controlrange	=	This.Event	ue_get_upperbound (This.Control)

// Get and edit the maximum tab level.

li_level	=	wf_get_max_uo_query()		// The maximum level #

// ii_level_num is the current level & is set in ue_register_level

IF	ii_level_num	=	1		THEN
	MessageBox ('Error', 'The first level cannot be removed')
	Return
END IF

IF	ii_level_num	<>	li_level		THEN
	MessageBox ('Error', 'Only the last level can be removed')
	Return
END IF

//	Prevent the window from repainting multiple times
This.SetRedraw(FALSE)

// We have established that the level being removed is the last level.
// It can now be removed.

// Destroy the corresponding uo_query and remove it from the control array

IF	IsValid (iu_query [ii_level_num])	THEN
	// destroy the user object
	CloseUserObject (iu_query [ii_level_num])
	SetNull (This.Control [li_controlrange])
	li_controlrange --
END IF

// Disable and Hide the corresponding tabpage.
CHOOSE CASE ii_level_num
	CASE 2
		tab_level.tabpage_2.enabled	=	FALSE
		tab_level.tabpage_2.visible	=	FALSE
	CASE 3
		tab_level.tabpage_3.enabled	=	FALSE
		tab_level.tabpage_3.visible	=	FALSE
	CASE 4
		tab_level.tabpage_4.enabled	=	FALSE
		tab_level.tabpage_4.visible	=	FALSE
	CASE 5
		tab_level.tabpage_5.enabled	=	FALSE
		tab_level.tabpage_5.visible	=	FALSE
	CASE 6
		tab_level.tabpage_6.enabled	=	FALSE
		tab_level.tabpage_6.visible	=	FALSE
	CASE 7
		tab_level.tabpage_7.enabled	=	FALSE
		tab_level.tabpage_7.visible	=	FALSE
	CASE 8
		tab_level.tabpage_8.enabled	=	FALSE
		tab_level.tabpage_8.visible	=	FALSE
	CASE 9
		tab_level.tabpage_9.enabled	=	FALSE
		tab_level.tabpage_9.visible	=	FALSE
	CASE 10
		tab_level.tabpage_10.enabled	=	FALSE
		tab_level.tabpage_10.visible	=	FALSE
END CHOOSE

//	Set the new level number
ii_level_num --

// Set the new active query by selecting the new tab.  This will trigger
//	the appropriate scripts (tab_level.SelectionChanged) to set the active query.
tab_level.SelectTab (ii_level_num)
tab_level.SetFocus()

//	Set/reset the appropriate menu items
This.Event	ue_set_menus_new_level()		// FDG 04/14/98

This.SetRedraw(TRUE)


end event

event ue_remove_all_levels(boolean ab_ancillary_inv_type);/////////////////////////////////////////////////////////////////////////////
// Script:	ue_remove_all_levels	
// 
//	Arguments:	as_rel_type:
//					'QT' - Non-ancillary invoice type
//					'AN' - Ancillary invoice type.
//
//	Returns:		None
//
// Description:
//		This event is posted from uo_query.dw_source.itemchanged event when
//		the data source is changed.  If an ancillary table was selected, then
//		all of the levels (except the 1st) will be removed.
//
//	Note:
//		The 1st level is the only level that a user can select an ancillary
//		table.
//
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	FDG	04/13/98	Track 975, 1063.  Created.
// FDG	09/21/01	Stars 4.8.1.  Don't enable if the associated case is
//						closed or deleted
//	GaryR	01/07/09	SPR 5597	Remove levels only if data source is changed in the first tab
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_level

Constant	String	lcs_ancillary = 'AN'

// Edit the rel type to see if it's an ancillary table ('AN' = ancillary)

IF	IsNull(ab_ancillary_inv_type)		THEN
	Return
END IF

// Get the max # of levels for the query
li_level	=	This.wf_get_max_uo_query()

IF	ab_ancillary_inv_type	=	FALSE		THEN
	// Non-ancillary table.  Allow the user to specify a new level (if the
	// current level is the last level)
	// FDG 09/21/01 begin
	IF	ib_disable_update		THEN
	ELSE
		IF	ii_level_num				=	li_level		THEN
			im_search.m_menu.m_nextlevel.enabled		=	TRUE	
			im_view.m_menu.m_nextlevel.enabled			=	TRUE	
		ELSE
			im_search.m_menu.m_nextlevel.enabled		=	FALSE	
			im_view.m_menu.m_nextlevel.enabled			=	FALSE	
		END IF
	END IF
	// FDG 09/21/01 end
	Return
END IF

// Ancillary table - Remove all levels (except the 1st) if any exist.
//	Ancillary can only be selected on the first tab.
IF This.tab_level.selectedtab <> 1 THEN Return

DO WHILE ii_level_num	>	1
	This.Event	ue_remove_level()
LOOP

// Disable the next level RMM for this ancillary invoice type
im_search.m_menu.m_nextlevel.enabled		=	FALSE	
im_view.m_menu.m_nextlevel.enabled			=	FALSE	

// FDG 09/21/01 begin
IF	ib_disable_update		THEN
	Return
END IF
// FDG 09/21/01 end

// The drilldown menu is only enabled if there is one level.
This.Event	ue_set_menus_new_level()


end event

event ue_get_current_query_id;call super::ue_get_current_query_id;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_get_current_query_id					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be return the selected query ID
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		None.
//		Value			as_inv_type			String				The invoice type.
//		Value			as_drilldown_path	String				The drilldown path.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		String						The currently selected query ID
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	FDG		04/22/98		Track 1104.	Created.
//
/////////////////////////////////////////////////////////////////////////////

String	ls_query_id
Long		ll_row

ll_row	=	dw_pdq_cntl.RowCount()

IF	ll_row	<	1		THEN
	Return	''
END IF

ls_query_id		=	dw_pdq_cntl.object.query_id [ll_row]

Return ls_query_id

end event

event ue_reset_current_pdq();///////////////////////////////////////////////////
//	Script:		ue_reset_current_pdq
//
//	Description:
//
//		This event is triggered from 'Reset' RMM is clicked
//		from the Source Tab.  This menu item can only be selected
//		when an existing PDQ is selected.
//
// 	This event will Reset the tabs with the originally
// 	selected PDQ.  The end result is the changes to the
// 	selected PDQ are reversed.
// 	
//////////////////////////////////////////////////////////
//	History
//
//	05/15/98	FDG	Track 1241?  Created
//	12/04/98	FDG	Track 2004.  Pass a true/false argument to
//						ue_enable_next_button.
//	02/07/02	LahuS	Track 2552d New reset functionality for PDR
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
//////////////////////////////////////////////////////////

Integer	li_level_num,	&
			li_rc

// Prompt the user that changes will be lost.
li_rc			=	MessageBox ('Warning', 'This will reset the query back to its original state.' + &
									'  Do you want to continue?', Question!, OkCancel!, 1)

IF	li_rc		=	2		THEN
	// Cancel clicked.  Get out.
	Return
END IF

w_main.SetMicroHelp ('Resetting the Query.  Please wait...')

This.SetRedraw (FALSE)
	
//Lahu S 2/7/02 Track 2552d Begin
if This.of_is_pdr_mode() then 
	goto PDR_Reset
end if
//Lahu S 2/7/02 Track 2552d End

li_level_num = This.event ue_get_level_num()		// Get the max level number, 
																//	NOTE: ue_get_level_num
																// assumes the first row is the max.
This.event ue_load_query(li_level_num)
This.event ue_set_pdq_title()
This.event ue_enable_next_button(TRUE)				// FDG 12/04/98
This.event ue_set_menus_query_select (TRUE)		
This.event ue_set_unique_count (0, '')				//	Clear out the unique counts
This.wf_SetRowDelete (FALSE)	

w_main.SetMicroHelp ('Ready')

This.SetRedraw (TRUE)
Return

//Lahu S 2/7/02 Track 2552d Begin
PDR_Reset:

//	04/17/02	GaryR	Track 2552d - Begin
IF iu_active_query.SelectedTab = IC_PDR THEN
	iu_active_query.Event ue_tabpage_pdr_construct()
ELSEIF iu_active_query.SelectedTab = IC_SOURCE THEN
	iu_active_query.Event ue_tabpage_pdr_load_source( TRUE )
END IF
//	04/17/02	GaryR	Track 2552d - End

w_main.SetMicroHelp ('Ready')
This.SetRedraw (TRUE)
Return
//Lahu S 2/7/02 Track 2552d End
end event

event ue_remove_all_levels_mc;call super::ue_remove_all_levels_mc;/////////////////////////////////////////////////////////////////////////////
// Script:	ue_remove_all_levels	
// 
//	Arguments:	as_rel_type:
//					'QT' - Non-ancillary invoice type
//					'AN' - Ancillary invoice type.
//
//	Returns:		None
//
// Description:
//		This event is posted from uo_query.dw_source.itemchanged event when
//		the data source is changed to MC.  It is modeled from ue_remove_all_levels.
//
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	 FNC	06/03/98		Track 1166. If select datasource of MC then cannot have
//							more than 1 level. Must remove any levels that the user
//							previously specified.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_level

// Get the max # of levels for the query
li_level	=	This.wf_get_max_uo_query()

ii_level_num = li_level
DO WHILE ii_level_num	>	1
	This.Event	ue_remove_level()
LOOP

// Disable the next level RMM for MC datasource
im_search.m_menu.m_nextlevel.enabled		=	FALSE	
im_view.m_menu.m_nextlevel.enabled			=	FALSE	

// The drilldown menu is only enabled if there is one level.
This.Event	ue_set_menus_new_level()


end event

event ue_copy_notes(string arg_rel_id, string arg_case_id, string arg_rel_id_orig);// ue_copy_notes for w_query_engine
//--------------------------------------------------------------------------------
// description:
//	this event is called when an independent pdq is being linked or saved as.
// First, check Notes table for any notes attached to the independent pdq being
//	linked/saved as (don't copy notes for case_linked pdqs), then copy over to 
//	new pdq or case.
// The notes_rel_type, notes_sub_type and note_id are changed accordingly.
//---------------------------------------------------------------------------------
//	Arguments:
//	1)	arg_rel_id - 		note_rel_id of the new note(s)
//	2)	arg_case_id -		case id of the new notes
//	3)	arg_rel_id_orig -	note_rel_id of the originating note(s)
//---------------------------------------------------------------------------------
//	History:
// 07/28/98	NLG	created. Track #1153
// 10/06/99 AJS	TS2443 - Rls 4.5 Enhanced notes
//	10/13/99 NLG	ts2443 - must use embedded sql for enhanced notes.
// 10/17/02	Jason Track 2883d  populate notes structure with note_desc
//	08/16/05	GaryR	Track 4361d	Add log entry for new notes
//----------------------------------------------------------------------------------

string ls_rel_type, ls_rel_id, ls_new_sub_type, ls_dept_id, ls_user_id, ls_desc, ls_note_id
string ls_new_rel_type, ls_new_rel_id, ls_rte_ind
string ls_note_desc
datetime ldt_datetime
long ll_rows, ll_row_num, ll_new_row
integer li_rc 
string ls_old_note_id

ls_rel_type = 'PQ'
ls_rel_id = arg_rel_id_orig								//rel id of original notes

ldt_datetime = gnv_app.of_get_server_date_time()

if arg_case_id = 'NONE' then 								// if new pdq is independent ...
	ls_new_rel_type = 'PQ'
	ls_new_sub_type = 'GI'
	ls_new_rel_id = arg_rel_id
else																//if new pdq is linked to case ...
	ls_new_rel_type = 'CA'
	ls_new_sub_type = 'PQ'
	ls_new_rel_id = arg_rel_id
end if

//NLG Notes changes - must use embedded sql. Cannot retrieve large note_text in dw
n_ds ds_notes
ds_notes = CREATE n_Ds
ds_notes.DataObject = 'd_notes'
li_rc = ds_notes.SetTransObject(stars2ca)
if li_rc <> 1 then
	messagebox("ERROR","Error checking for attached Notes.")
else
	ll_rows = ds_notes.Retrieve(ls_rel_type, ls_rel_id) 
	if ll_rows < 0 Then
		MessageBox("Error","Error checking for notes.",StopSign!)
	else
		//if notes exist for PDQ, copy rows for new PDQ
		if ll_rows > 0 then
			
				for ll_row_num = 1 to ll_rows
					//ts2443c Notes changed to rich text. Cannot retrieve 32K+ note
					//in datawindow.  Must use embedded sql to copy notes.

					n_cst_notes lnvo_notes
					lnvo_notes.is_notes_id = fx_get_next_key_id('NOTE')
					lnvo_notes.is_user_id = ds_notes.GetItemString(ll_row_num, 'user_id')
					lnvo_notes.is_dept_id = ds_notes.GetItemString(ll_row_num, 'dept_id')
					lnvo_notes.is_notes_rel_type = ls_new_rel_type
					lnvo_notes.is_notes_rel_id = ls_new_rel_id
					lnvo_notes.is_notes_sub_type = ls_new_sub_type
					lnvo_notes.idt_datetime = ldt_datetime
					lnvo_notes.is_rte_ind = ds_notes.getItemString(ll_row_num,'rte_ind')
					lnvo_notes.is_old_note_id = ds_notes.GetItemString(ll_row_num, 'note_id')
					lnvo_notes.is_old_rel_type = ds_notes.GetItemString(ll_row_num, 'note_rel_type')
					lnvo_notes.is_old_rel_id = ds_notes.GetItemString(ll_row_num, 'note_rel_id')
					// JasonS 10/17/02 Begin - Track 2883d
					lnvo_notes.is_notes_desc = ds_notes.getitemstring(ll_row_num, 'note_desc')
					// JasonS 10/17/02 End - Track 2883d					
					li_rc = lnvo_notes.uf_copy_note()
					if li_rc <> 1 then
						messagebox('NOTES','Error copying notes')
					end if
					
				next
//				li_rc = ds_notes.update()
				if stars2ca.of_check_status() <> 0 then
					messagebox('ERROR','Error copying attached Notes')
				else
					stars2ca.of_commit()
				end if

		end if //ll_rows > 0
	end if //ll_rows < 0
end if //li_rc <> 1
	
if isValid(ds_notes) then destroy(ds_notes)
end event

event ue_enable_prev_button(boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_enable_prev_button					w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by cb_select.clicked and uo_query.ue_new_query() to enable
// the Prev button on the window.	 
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
// Author	Date			Description
// ------	----			-----------
//
//	FDG		12/04/98		Track 2004.  Created.
//	GaryR		04/17/02		Track 2552d	Predefined Reports (PDR)
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

CHOOSE CASE iu_active_query.SelectedTab
	CASE IC_PDR				//	04/17/02	GaryR	Track 2552d
		iu_active_query.tabpage_pdr.cb_prev_pdr.enabled	=	ab_switch	
	CASE IC_SOURCE
		iu_active_query.tabpage_source.cb_prev_source.enabled	=	ab_switch
	CASE IC_SEARCH
		iu_active_query.tabpage_search.cb_prev_search.enabled	=	ab_switch
	CASE IC_REPORT
		iu_active_query.tabpage_report.cb_prev_report.enabled	=	ab_switch
	CASE IC_VIEW
		iu_active_query.tabpage_view.cb_prev_view.enabled		=	ab_switch
END CHOOSE


end event

event type integer ue_set_menus_dependent_info_menu(boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Description
// This event will be called by ue_tabpage_source_load_additional_data event of uo_query
// to set the menu Visibility for claim details. 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			ab_switch	Boolean		TRUE = enable, FALSE = disable
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	A.Sola	01/12/99		Created. FS1711d 4.1
//	GaryR		07/04/05		Track 3316d	Keep claims detail menu setting on drilldown
/////////////////////////////////////////////////////////////////////////////

IF	IsNull (ab_switch)		THEN
	Return -1
END IF

im_view.m_menu.m_claimoperations.m_claimdetail.enabled	=	ab_switch
iu_active_query.ib_claimdetail = ab_switch	//Save setting for drilldown

Return 1
end event

event ue_export_pdq;/////////////////////////f////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_export_pdq						W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event formats a pdq into flat file records and writes the records
// to a flat file specified by the user.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype		Description
//		---------	--------			--------		-----------
//		Value			as_come_from	String		Indicates the query engine tab page 
//															from which event was invoked.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value				Description
//		--------		-----				-----------
//	 	Integer		0					File created
//						-1					File not created
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	FNC				11/08/99		Created.
//	AJS 				01-13-00 	TRACK 2088D - Added user ini path
// FNC				01/19/00		Track 2092 Check to see if save file exists.
// FNC				04/13/00		Track 2189 StarDev stars 4.5. If user
//										does not save query, export is cancelled.
/////////////////////////////////////////////////////////////////////////////
		
/*records written to file */
string	ls_file_hdr,	&	
			ls_pdq_hdr,		&
			ls_tbl_rec,		&
			ls_crit_rec,	&
			ls_col_rec,		&
			ls_comments,	&
			ls_file_name,	&
			ls_next_file_id,	&
			ls_path_file
			
integer	li_rc,			&
			li_filenumber,	&
			li_rowcount,	&
			li_row,			&
			li_max_levels,	&
			li_level_num,	&
			li_crit_rows,	&
			li_col_rows

CONSTANT string 	LCS_SINGLE_QUOTE = "'",	&
						LCS_DOUBLE_QUOTE = '"'


n_cst_string 	lnv_string

/* Save PDQ */

if as_come_from <> 'LIST' then
		/*force to use query engine of_updatechecks instead of w_master */
		iu_active_query.of_SetFromCloseQuery(TRUE)
		li_rc	=	This.of_updatechecks ()
		IF	li_rc	=	0		THEN
			/* See if rows were deleted in dw_criteria */
			if	wf_getrowdelete()	=	FALSE		THEN
				/*no update so don't save */
			else
				li_rc = this.Event ue_save_query ('S')
				if li_rc <> 1 then
					li_rc = MessageBox ('Query Save', 'Query was not saved. Export cancelled.')				
					return -1
				end if
			end if
		ELSEIF	li_rc	<	0		THEN
			/*	Updates are pending, but at least 1 data entry error was
				found.  Give the user the chance to save the window
				without saving */
			li_rc = MessageBox ('Validation Error', 'An error was found in the query. Export cancelled')
			return -1
		ELSE
			li_rc  = This.Event ue_save_query ('S')
			if li_rc <> 1 then
				li_rc = MessageBox('Query Save', 'Query was not saved. Export cancelled.')
				return -1
			end if
		end if
//	END IF
end if


/* Retrieve user comments */
openwithparm(w_import_export_comments,ls_comments)

ls_comments	=	Message.StringParm
SetNull (Message.StringParm)

if isnull(ls_comments) then
	ls_comments = lnv_string.of_padright(iu_active_query.of_GetReportTitle(),255)
elseif trim(ls_comments) = '' then
	ls_comments = lnv_string.of_padright(iu_active_query.of_GetReportTitle(),255)
elseif ls_comments = 'CANCEL' then
	return 0
else
	ls_comments = lnv_string.of_padright(ls_comments,255)
end if

ls_next_file_id  =  lnv_string.of_padnumber(fx_get_next_key_id ('PDQEXPORT'),6)

/* Clean up microhelp message set by fx_get_next_key_id */
setmicrohelp(w_main,'')

//AJS 01-13-00 TRACK 2088D
ls_path_file  =  gv_user_ini_path + 'QE'  +  ls_next_file_id  +  '.PDQ'

li_rc = 	GetFileSaveName('Export PDQ File Save Window',ls_path_file,  + &
			ls_file_name,'PDQ','PDQ Files (*.PDQ),*.PDQ')
			
if li_rc = 0 then
	/* User cancelled export */
	return 0
elseif li_rc = -1 then
	/* Error receiving file name*/
	messagebox('ERROR','Error retrieving file name')
	return -1
end if

if FileExists(ls_path_file) then			// FNC 01/19/00 Start
	li_rc = messagebox('WARNING','Save file exists, Do you want to save over the existing file?',Question!,YesNo!)
end if

if li_rc = 2 then
	do while li_rc <> 1
		li_rc = 	GetFileSaveName('Export PDQ File Save Window',ls_path_file,  + &
			ls_file_name,'PDQ','PDQ Files (*.PDQ),*.PDQ')

		if li_rc = 0 then
			/* User cancelled export */
			return 0
		elseif li_rc = -1 then
			/* Error receiving file name*/
			messagebox('ERROR','Error retrieving file name')
			return -1
		end if
		if FileExists(ls_path_file) then
			li_rc = messagebox('WARNING','Save file exists, Do you want to save over the existing file?',Question!,YesNo!)
		else
			li_rc = 1
		end if
	loop
end if											// FNC 01/19/00 End

li_filenumber  =  FileOpen (ls_file_name, Linemode!, Write!, Lockwrite!, Replace!)
if  li_filenumber  <  0  THEN
	MessageBox('ERROR','Error opening file. Export cancelled')
	Return -1
end if

/*Build File Header Record */

ls_file_hdr = this.event ue_build_file_hdr(ls_comments)

li_rc = FileWrite(li_filenumber,ls_file_hdr)

if li_rc < 1 then 
	messagebox('ERROR','Error writing file header for export file. Export is cancelled.')
	return -1
end if

/*Build PDQ Header Record */

ls_pdq_hdr = this.event ue_build_pdq_hdr()
					
li_rc = FileWrite(li_filenumber,ls_pdq_hdr)

if li_rc < 1 then 
	messagebox('ERROR','Error writing pqd header for export file. Export is cancelled.')
	FileClose(li_filenumber)
	FileDelete(ls_path_file)
	return -1
end if


/* Build PDQ Table Record */

/*Clear filter on dw so all levels are displayed */
dw_pdq_tables.setfilter('')
dw_pdq_tables.filter()

dw_pdq_tables.SetSort("query_id A, level_num A, tbl_rel D")
dw_pdq_tables.sort()

/*Set is_dep_inv_type = spaces for all levels to eliminate a null
  object reference in ue_build_pdq_crit */
li_max_levels = this.wf_get_max_uo_query()

for li_level_num = 1 to li_max_levels
	is_dep_inv_type[li_level_num] = ' '
next

li_rowcount = dw_pdq_tables.rowcount()
for li_row = 1 to li_rowcount
	
	ls_tbl_rec = this.event ue_build_pdq_table(li_row)
	
	li_rc = FileWrite(li_filenumber,ls_tbl_rec)
	
	if li_rc < 1 then 
		messagebox('ERROR','Error writing table record for export file. Export is cancelled.')
		FileClose(li_filenumber)
		FileDelete(ls_path_file)
		return -1
	end if
	
Next

/* Write Table Trailer Record */

ls_tbl_rec = 'D'

li_rc = FileWrite(li_filenumber,ls_tbl_rec)

if li_rc < 1 then 
	messagebox('ERROR','Error writing table trailer record for export file. Export is cancelled.')
	FileClose(li_filenumber)	
	FileDelete(ls_path_file)	
	return -1
end if


/* Build PDQ Criteria Record */

/*Clear filter on dw so all levels are displayed */
dw_pdq_criteria.setfilter('')
dw_pdq_criteria.filter()

dw_pdq_criteria.SetSort("query_id A, level_num A, seq_num A")
dw_pdq_criteria.sort()

li_rowcount = dw_pdq_criteria.rowcount()

for li_row = 1 to li_rowcount
	
	ls_crit_rec = this.event ue_build_pdq_crit(li_row)
	
	if ls_crit_rec = 'NOREC' THEN
	else
		li_rc = FileWrite(li_filenumber,ls_crit_rec)
		li_crit_rows++
	end if
	
	if li_rc < 1 then 
		messagebox('ERROR','Error writing criteria record for export file. Export is cancelled.')
		FileClose(li_filenumber)
		FileDelete(ls_path_file)		
		return -1
	end if
						
Next

/* Write Criteria Trailer Record */

if li_crit_rows > 0 then
	ls_crit_rec = 'F'
		
	li_rc = FileWrite(li_filenumber,ls_crit_rec)
	
	if li_rc < 1 then 
		messagebox('ERROR','Error writing criteria trailer record for export file. Export is cancelled.')
		FileClose(li_filenumber)
		FileDelete(ls_path_file)		
		return -1
	end if
else 
	messagebox('ERROR','Cannot export PDQ without search by criteria. Export is cancelled.')
	FileClose(li_filenumber)
	FileDelete(ls_path_file)		
	return -1
end if

/* Build PDQ Columns Record */

/*Clear filter on dw so all levels are displayed */
dw_pdq_columns.setfilter('')
dw_pdq_columns.filter()

dw_pdq_columns.SetSort("query_id A, level_num A, seq_num A")
dw_pdq_columns.sort()

li_rowcount = dw_pdq_columns.rowcount()
if li_rowcount > 0 then
	for li_row = 1 to li_rowcount
		
		ls_col_rec = this.event ue_build_pdq_col(li_row)
		
		if ls_col_rec = 'NOREC' THEN
		else
			li_rc = FileWrite(li_filenumber,ls_col_rec)
			li_col_rows++
		end if
		
		if li_rc < 1 then 
			messagebox('ERROR','Error writing column record for export file. Export is cancelled.')
			FileClose(li_filenumber)
			FileDelete(ls_path_file)			
			return -1
		end if
							
	Next
end if

/* Write Column Trailer Record */

if li_col_rows > 0 then					// FNC 02/17/00
	ls_col_rec = 'H'
	
	li_rc = FileWrite(li_filenumber,ls_col_rec)
	
	if li_rc < 1 then 
		messagebox('ERROR','Error writing column trailer record for export file. Export is cancelled.')
		FileClose(li_filenumber)
		FileDelete(ls_path_file)		
		return -1
	end if
end if

/* Write PDQ Trailer Record */

ls_pdq_hdr = 'Y'

li_rc = FileWrite(li_filenumber,ls_pdq_hdr)

if li_rc < 1 then 
	messagebox('ERROR','Error writing PDQ trailer record for export file. Export is cancelled.')
	FileClose(li_filenumber)
	FileDelete(ls_path_file)	
	return -1
end if

/* Write File Trailer Record */

ls_file_hdr = 'Z'

li_rc = FileWrite(li_filenumber,ls_file_hdr)

if li_rc < 1 then 
	messagebox('ERROR','Error writing file trailer record for export file. Export is cancelled.')
	FileClose(li_filenumber)	
	FileDelete(ls_path_file)	
	return -1
end if

FileClose(li_filenumber)


/*Reset filters on PDQ Datawindows so only the datawindow they contain data only for
the current level. */

this.wf_SetLevelFilter(ii_level_num,'ALL')

return 0
end event

event ue_build_file_hdr;/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_build_file_hdr				W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event formats the file hearder record for the flat exported file.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value				Description
//		--------		-----				-----------
//	 	String		ls_file_hdr		Formatted file header record
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	FNC		11/08/99		Created.
//	FDG		04/27/01		Stars 4.7.  Software version can be > 10 bytes.
//
/////////////////////////////////////////////////////////////////////////////

string	ls_software_version,	&
			ls_file_type,			&
			ls_date_time_created,	&
			ls_file_hdr,	&
			ls_comments
			
			
n_cst_string lnv_string
CONSTANT string lcs_delimiter = '^'

// FDG 04/27/01 - Software version can be > 10 bytes.
ls_software_version	=	Upper (gnv_app.of_get_version() )

IF	Left (ls_software_version, 7)	=	'VERSION'	THEN
	ls_software_version	=	Trim ( Mid(ls_software_version, 8) )
END IF

IF	Len (ls_software_version)	>	10		THEN
	ls_software_version	=	Left (ls_software_version, 10)
END IF
// FDG 04/27/01 end

ls_software_version 	= 	lnv_string.of_PadRight(ls_software_version,10)
ls_file_type 			=	lnv_string.of_PadRight('PDQ',10)
ls_date_time_created = 	String(gnv_app.of_get_server_date_time(), 'mm/dd/yyyy hh:mm:ss')

ls_file_hdr = 	'A' + LCS_DELIMITER + &
					ls_software_version + LCS_DELIMITER + &
					ls_date_time_created + LCS_DELIMITER + &
					ls_file_type + LCS_DELIMITER + &
					as_comments + LCS_DELIMITER
					
return ls_file_hdr
end event

event ue_build_pdq_hdr;/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_build_pdq_hdr					W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event formats the pdq header for the flat exported file. This record
//	corresponds with the pdq_cntl record
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value				Description
//		--------		-----				-----------
//	 	String		ls_pdq_hdr		Formatted pdq header record
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	FNC				11/08/99		Created.
//
/////////////////////////////////////////////////////////////////////////////

integer	li_row 

string	ls_query_type, 			&
			ls_create_date, 			&
			ls_rpt_template_title, 	&
			ls_delete_ind, 			&
			ls_common_ind, 			&
			ls_addl_query_type, 		&
			ls_default_template, 	&
			ls_user_id,					&
			ls_pdq_hdr,					&
			ls_pdq_type

n_cst_string lnv_string

CONSTANT string lcs_delimiter = '^'

li_row = 					dw_pdq_cntl.getrow()
ls_user_id 				= 	lnv_string.of_padright(gc_user_id,8)
ls_query_type 			= 	left(dw_pdq_cntl.object.query_type[li_row],2)
ls_create_date 		= 	string(dw_pdq_cntl.object.create_date[li_row],'mm/dd/yyyy hh:mm:ss')
ls_common_ind 			= 	lnv_string.of_padright(dw_pdq_cntl.object.common_ind[li_row],1)
ls_pdq_type				= 'Q'
ls_delete_ind 			= 	lnv_string.of_padright(dw_pdq_cntl.object.delete_ind[li_row],1)
ls_addl_query_type 	= 	lnv_string.of_padright(dw_pdq_cntl.object.addl_query_type[li_row],2)
ls_default_template 	= 	lnv_string.of_padright(dw_pdq_cntl.object.default_template[li_row],1)

ls_pdq_hdr = 	'B' + LCS_DELIMITER + &
					ls_user_id + LCS_DELIMITER + &
					ls_query_type + LCS_DELIMITER + &
					ls_create_date + LCS_DELIMITER + &
					ls_common_ind + LCS_DELIMITER + &
					ls_pdq_type + LCS_DELIMITER + &
					ls_delete_ind + LCS_DELIMITER + &
					ls_addl_query_type + LCS_DELIMITER + &
					ls_default_template + LCS_DELIMITER 
					
return ls_pdq_hdr
end event

event type string ue_build_pdq_table(integer ai_row);/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_build_pdq_table				W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event formats the pdq_table record for the flat exported file.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			ai_row		integer		Row number of the current row in the 
//														pdq table table
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value				Description
//		--------		-----				-----------
//	 	String		ls_table_rec	Formatted pdq_table_record
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	FNC		11/08/99		Created.
//	FDG		07/14/00		Track 2465c.  Stars 4.5 SP1.  Include fastquery data
//								in the import and export.
//	GaryR		03/01/02		Track 2552d	RPT_TITLE increasing to 160 bytes from 60
// 10/13/04 MikeF SPR3650d		Replace local n_cst_dict with gnv_dict
//	GaryR		06/22/07		Track 5085	Look for a match of AN in STARS_REL
/////////////////////////////////////////////////////////////////////////////

string	ls_tbl_rec,				&
			ls_tbl_rel,				&
			ls_level_num,			&
			ls_src_type,			&			
			ls_rpt_title,			&	
			ls_rpt_title1,			&
			ls_prev_inv_type,		&
			ls_base_type,			&
			ls_seq_num,				&
			ls_tbl_desc,			&
			ls_tbl_type,			&
			ls_pay_opt,				&
			ls_fastquery_ind,		&
			ls_fastquery_rows
			
integer 	li_rc,					&
			li_level_num,			&
			li_rows

Long		ll_fastquery_rows
	
n_cst_string	lnv_string
n_cst_revenue	lnv_revenue
n_ds				lds_stars_rel

lnv_revenue = Create n_cst_revenue
lds_stars_rel = Create n_ds
lds_stars_rel.dataobject = 'd_stars_rel'
lds_stars_rel.settransobject(stars2ca)

CONSTANT string lcs_delimiter = '^'

ls_tbl_rec 			= 	''
li_level_num 		= 	dw_pdq_tables.object.level_num[ai_row]
ls_level_num		=	lnv_string.of_padnumber(string(li_level_num),5)
ls_tbl_rel 			= 	dw_pdq_tables.object.tbl_rel[ai_row]
ls_src_type 		= 	dw_pdq_tables.object.src_type[ai_row]
//	GaryR	03/01/02	Track 2552d - Begin
// RPT_TITLE column has increased to 160 bytes from 60.
//	In order to continue PDQ export backwards compatability,
//	Break up the available 160 byte string into two 80 byte strings.
//	The first 80 byte portion of this string will be exported as usual,
//	The last 80 byte string will be appended to the very end of this record.
//ls_rpt_title 		= 	lnv_string.of_padright(dw_pdq_tables.object.rpt_title[ai_row],80)
ls_rpt_title 		=	dw_pdq_tables.object.rpt_title[ai_row]
ls_rpt_title1		= 	lnv_string.of_padright( Mid( ls_rpt_title, 81 ), 80 )
ls_rpt_title		= 	lnv_string.of_padright( Left( ls_rpt_title, 80 ), 80 )
//	GaryR	03/01/02	Track 2552d - End
ls_pay_opt			=  dw_pdq_tables.object.payment_date_options[ai_row]
ll_fastquery_rows	=	dw_pdq_tables.object.fastquery_rows[ai_row]				// FDG 07/14/00
ls_fastquery_rows	=	lnv_string.of_padnumber(String(ll_fastquery_rows),10)	// FDG 07/14/00
ls_fastquery_ind	=	dw_pdq_tables.object.fastquery_ind[ai_row]				// FDG 07/14/00
ls_fastquery_ind	=	lnv_string.of_padright(ls_fastquery_ind, 1)				// FDG 07/14/00

if isnull(ls_pay_opt) then
	ls_pay_opt = '' 
end if

ls_pay_opt		=  lnv_string.of_padright(ls_pay_opt,60)

Choose Case ls_tbl_rel
	Case 'GP'
		ls_seq_num = '01'
		ls_tbl_type = dw_pdq_tables.object.tbl_type[ai_row]
		is_inv_type[li_level_num] = ls_tbl_type
		/* Determine if main or ancillary table*/
		li_rows = lds_stars_rel.retrieve(ls_tbl_type)
		
		// Look for AN rel type
		li_rows = lds_stars_rel.Find( "rel_type = 'AN'", 0, lds_stars_rel.RowCount()) 
		if li_rows > 0 then
				ls_base_type = gnv_dict.event ue_get_table_name(ls_tbl_type)
				ls_tbl_rel = 'AN'
		else
			/* Not ancillary */
			ls_base_type = lnv_revenue.of_get_base_type(ls_tbl_type)
		end if
	Case 'DP'
		ls_seq_num 							= '02'
		ls_tbl_type 						= dw_pdq_tables.object.tbl_type[ai_row]
		is_dep_inv_type[li_level_num] = dw_pdq_tables.object.tbl_type[ai_row]
		ls_base_type 						= ' '
End Choose

ls_base_type 	= lnv_string.of_padright(ls_base_type,32)
ls_tbl_desc 	= lnv_string.of_padright(trim(gnv_dict.event ue_get_table_desc(ls_tbl_type)),15)
if trim(ls_tbl_desc) = 'ERROR' then
	messagebox('ERROR','Error retrieving table description. Field will be spaces in exported file')
end if 

destroy(lnv_revenue)
destroy(lds_stars_rel)

// Write out record 

// FDG 07/14/00 - include fastquery_ind and fastquery_rows to record

//	03/01/02	GaryR	Track 2552d - Begin
ls_tbl_rec = 	'C' + LCS_DELIMITER						+	&
					ls_level_num + LCS_DELIMITER			+	&
					ls_seq_num + LCS_DELIMITER				+	&
					ls_base_type + LCS_DELIMITER			+	&
					ls_tbl_rel + LCS_DELIMITER				+	&
					ls_src_type + LCS_DELIMITER			+	&
					ls_rpt_title + LCS_DELIMITER			+	&
					ls_tbl_desc + LCS_DELIMITER			+	&
					ls_pay_opt + LCS_DELIMITER				+	&
					ls_fastquery_ind	+	LCS_DELIMITER	+	&
					ls_fastquery_rows	+	LCS_DELIMITER	+	&
					ls_rpt_title1 + LCS_DELIMITER			
//	03/01/02	GaryR	Track 2552d - End

return ls_tbl_rec
end event

event type string ue_build_pdq_crit(integer ai_row);/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_build_pdq_crit					W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event formats the pdq_criteria record for the flat exported file.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			ai_row		integer		Row number of the current row in the
//														pdq criteria table
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value				Description
//		--------		-----				-----------
//	 	String		ls_crit_rec	Formatted pdq_criteria_record
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	FNC				11/08/99		Created.
// 10/13/04 MikeF SPR3650d		Replace local n_cst_dict with gnv_dict
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
/////////////////////////////////////////////////////////////////////////////

string	ls_crit_rec,		&
			ls_level_num,	&
			ls_seq_num,		&
			ls_level_seq_num,	&
			ls_tbl_type,	&
			ls_left_paren,	&
			ls_col_name,	&
			ls_rel_op,		&
			ls_col_value,	&
			ls_right_paren,&
			ls_logic_op,	&
			ls_col_label			

			
integer 	li_rc,				&
			li_level_num,		&
			li_seq_num

n_cst_string	lnv_string	
	
CONSTANT string lcs_delimiter = '^'

ls_crit_rec 		= 	''

li_level_num 	= 	dw_pdq_criteria.object.level_num[ai_row]
ls_level_num	=	lnv_string.of_padnumber(string(li_level_num),5)

ls_tbl_type		=	dw_pdq_criteria.object.tbl_type[ai_row]
if ls_tbl_type = is_inv_type[li_level_num] then
	ls_level_seq_num = '01'
elseif ls_tbl_type = is_dep_inv_type[li_level_num] then
	ls_level_seq_num = '02'
else 
	return 'NOREC'
end if

li_seq_num 	= 	dw_pdq_criteria.object.seq_num[ai_row]
ls_seq_num	=	lnv_string.of_padnumber(string(li_seq_num),8)
ls_left_paren 	= lnv_string.of_padright(dw_pdq_criteria.object.left_paren[ai_row],2)
ls_rel_op		= lnv_string.of_padright(dw_pdq_criteria.object.rel_op[ai_row],12)
ls_col_value	= dw_pdq_criteria.object.col_value[ai_row]
/* If criteria contains a filter remove filter id */
if left(ls_col_value,1) = '@' then
	ls_col_value = '@'
end if
ls_col_value	= lnv_string.of_padright(ls_col_value,255)
ls_right_paren	= lnv_string.of_padright(dw_pdq_criteria.object.right_paren[ai_row],2)
ls_logic_op		= lnv_string.of_padright(dw_pdq_criteria.object.logic_op[ai_row],3)
ls_col_name		= dw_pdq_criteria.object.col_name[ai_row]
if Match( ls_col_name, "SUPER PROVIDER" ) &
or Match( ls_col_name, "SUPER NPI PROVIDER" ) then
	ls_col_label =	lnv_string.of_padright(ls_col_name,30) 
else
	ls_col_label	= gnv_dict.event ue_get_col_desc(ls_tbl_type,ls_col_name)
	ls_col_label	= lnv_string.of_padright(trim(ls_col_label),15)
end if
ls_col_name		= lnv_string.of_padright(ls_col_name,30)

/* Write out record */

ls_crit_rec = 	'E' + LCS_DELIMITER + &
					ls_level_num + LCS_DELIMITER + &
					ls_level_seq_num + LCS_DELIMITER + &
					ls_seq_num + LCS_DELIMITER + & 	
					ls_left_paren + LCS_DELIMITER + & 
					ls_col_name + LCS_DELIMITER + & 
					ls_rel_op + LCS_DELIMITER + & 
					ls_col_value + LCS_DELIMITER + & 
					ls_right_paren + LCS_DELIMITER + & 
					ls_logic_op + LCS_DELIMITER + & 
					ls_col_label + LCS_DELIMITER	
					
					
return ls_crit_rec


end event

event type string ue_build_pdq_col(integer ai_row);/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_build_pdq_col				W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event formats the pdq_columns record for the flat exported file.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype		Description
//		---------	--------		--------		-----------
//		Value			ai_row		integer		Row number of the current row in the
//														pdq columns table
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value				Description
//		--------		-----				-----------
//	 	String		ls_col_rec	Formatted pdq_columns_record
/////////////////////////////////////////////////////////////////////////////
//
//	11/08/99	FNC	Created.
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//
/////////////////////////////////////////////////////////////////////////////

string	ls_col_rec,		&
			ls_level_num,	&
			ls_seq_num,		&
			ls_level_seq_num,	&
			ls_tbl_type,	&
			ls_col_name,	&
			ls_col_type,	&
			ls_col_label
			
integer 	li_rc,				&
			li_level_num,		&
			li_seq_num

n_cst_string	lnv_string	
	
CONSTANT string lcs_delimiter = '^'

ls_col_rec 		= 	''

li_level_num 	= 	dw_pdq_columns.object.level_num[ai_row]
ls_level_num	=	lnv_string.of_padnumber(string(li_level_num),5)

ls_tbl_type		=	dw_pdq_columns.object.tbl_type[ai_row]
if ls_tbl_type = is_inv_type[li_level_num] then
	ls_level_seq_num = '01'
elseif ls_tbl_type = is_dep_inv_type[li_level_num] then
	ls_level_seq_num = '02'
else 
	return 'NOREC'
end if

li_seq_num 	= 	dw_pdq_columns.object.seq_num[ai_row]
ls_seq_num	=	lnv_string.of_padnumber(string(li_seq_num),8)
ls_col_type =	lnv_string.of_padright(dw_pdq_columns.object.col_type[ai_row],3)
ls_col_name	=	dw_pdq_columns.object.col_name[ai_row]
ls_col_label	= gnv_dict.event ue_get_col_desc(ls_tbl_type,ls_col_name)
ls_col_label	= lnv_string.of_padright(trim(ls_col_label),15)
ls_col_name	=	lnv_string.of_padright(ls_col_name,30)

/* Write out record */

ls_col_rec = 	'G' + LCS_DELIMITER + &
					ls_level_num + LCS_DELIMITER + &
					ls_level_seq_num + LCS_DELIMITER + &
					ls_seq_num + LCS_DELIMITER + &
					ls_col_name + LCS_DELIMITER + &
					ls_col_type + LCS_DELIMITER + &
					ls_col_label + LCS_DELIMITER
				
return ls_col_rec
end event

event type integer ue_import_pdq();//*********************************************************************************
// Script Name:	ue_import_pdq	
//
//	Arguments:		none
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will is the driver event for importing
//						a pdq from as flat file.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//	12/29/99 FNC	Set super provider structure in uo_query so can run an imported
//						super provider query
// 01-18-99 AJS	Track 2091 - remove the extra "and/or" for error lines
// 02/17/00	FNC	Track 2106. If no criteria record is imported cancel import
// 09/21/01	FDG	Stars 4.8.1.  Re-enable the update menu items.
//	02/21/03	GaryR	Track 2937d	If level < 1 then not SPQ level
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//						
//*********************************************************************************

Boolean lb_eof
Integer	li_rc, li_level_num
Integer	li_num_prov_query, li_query
Long ll_filenumber, ll_level_num, ll_max_row
String ls_path_filename, ls_filename, ls_record, ls_record_type
boolean	lb_import_criteria

//Determine if any previous changes need to be saved.  Sample code:
li_rc  =  This.Event  CloseQuery()
IF  li_rc  <>  0  THEN
	Return  -1
END IF
			
//Get the file name and open it. 
ls_path_filename  =  gv_user_ini_path 
li_rc  =  GetFileOpenName ("Select PDQ File",  &
			ls_path_filename,  ls_filename, "PDQ" , &
			"PDQ Files (*.PDQ),*.PDQ" )
IF  li_rc <>  1  THEN
	Return -1
END IF
ll_filenumber  =  Fileopen (ls_path_filename, Linemode!, Read!)
IF  ll_filenumber  <  0  THEN
	MessageBox ("Error","Unable to open PDQ file " + ls_filename)
	Return -1
END IF

//Clear out the existing PDQ datawindows.
This.Event  ue_clear_pdq_datawindows()

il_record_count = 0
il_prev_level_num = 0
ib_error  =  FALSE

//Create the instance datastores
ids_summary  =  CREATE  n_ds
ids_summary.DataObject = 'd_import_pdq_summary'

ids_errors  =  CREATE  n_ds
ids_errors.DataObject = 'd_import_errors'

ids_status  =  CREATE  n_ds
ids_status.DataObject = 'd_import_pdq_status'

//Process import files
	DO until  lb_eof  =  TRUE
		li_rc  =  FileRead (ll_filenumber, ls_record)
		IF  li_rc  <  0   THEN
			lb_eof  =  TRUE
			Exit
		END IF
		
		ls_record_type  	=  left(ls_record, 1)	//record type
				
		CHOOSE CASE  ls_record_type
			CASE 'A'
				//Import File Header
				li_rc  =  this.Event ue_import_file_hdr(ls_record)
				IF  li_rc  <  0   THEN 
					this.Event ue_import_clean_up(ll_filenumber)
					Return -1
				END IF
					
			CASE 'B'
				//Import PDQ Header
				li_rc  =  this.Event ue_import_pdq_hdr(ls_record)
				IF  li_rc  <  0   THEN 
					this.Event ue_import_clean_up(ll_filenumber)
					Return -1
				END IF
					
			CASE 'C'
				//Import PDQ Tables
				li_rc  =  this.Event ue_import_pdq_table(ls_record)
				IF  li_rc  <  0   THEN 
					this.Event ue_import_clean_up(ll_filenumber)
					Return -1
				END IF
					
			CASE 'D'
				//PDQ Tables Trailer - Since all tables have been read,
				//get user input for table types and source subsets
				li_rc  =  this.Event ue_import_get_table_types()
				IF  li_rc  <  0   THEN 
					this.Event ue_import_clean_up(ll_filenumber)
					Return -1
				END IF
				il_prev_level_num  =  0	
				
			CASE 'E'
				//Import PDQ Criteria
				li_rc  =  this.Event ue_import_pdq_crit(ls_record)
				IF  li_rc  <  0   THEN 
					this.Event ue_import_clean_up(ll_filenumber)
					Return -1
				END IF
				
				lb_import_criteria = TRUE				//FNC 02/17/00
					
			CASE 'F'
				//PDQ Criteria trailer 
				//Reset the previous level # for the columns and criteria
				
				/* if error and no criteria then don't process 'F' record */
				if lb_import_criteria then				// FNC 02/17/00
					il_record_count ++
					il_prev_level_num  =  0			
					//ajs 01-18-99 Track 2091 
					ll_max_row = dw_pdq_criteria.Rowcount()
					dw_pdq_criteria.object.logic_op [ll_max_row] = ""
				end if

			CASE 'G'
				li_rc  =  this.Event ue_import_pdq_col(ls_record)
				
			CASE 'H'
				//PDQ Columns trailer  
				//Reset the previous level # for the columns and criteria
				il_record_count ++
				il_prev_level_num  =  0		
				
			CASE 'Y'
				//PDQ Trailer
				il_record_count ++	
				
			CASE 'Z'
				//File trailer 
				il_record_count ++
				
			CASE ELSE
				MessageBox ("Error","Invalid Record Type = " + ls_record_type)
				this.Event ue_import_clean_up(ll_filenumber)
				Return -1
				Exit
		END CHOOSE
	LOOP
	
IF il_record_count  <  1  THEN
	MessageBox ("Error","PDQ file " + ls_filename + ", does not contain any data")
	this.Event ue_import_clean_up(ll_filenumber)
	Return -1
END IF

if not lb_import_criteria then			// FNC 02/17/00 Start
	MessageBox ("Error","PDQ file " + ls_filename + ", does not contain any criteria. Import Cancelled.")
	this.Event ue_import_clean_up(ll_filenumber)
	Return -1
end if											// FNC 02/17/00 End

//Get the maximum level # on the window and load the window from the PDQ datawindows just loaded.  Sample code:
This.SetRedraw(FALSE)
ll_level_num = This.event ue_get_level_num()
This.Event  ue_show_levels (ll_level_num)
li_rc = This.event ue_load_query(ll_level_num)
IF  li_rc  <> 1   THEN 
	this.Event ue_import_clean_up(ll_filenumber)
	Return -1
END IF

// FDG 09/21/01 - reset the ability to update the query
This.Event	ue_set_menus_subset_view (TRUE)

If ib_spq then				// FNC 12/29/99 Start
	/* reset flag and index in case import another query */
	ib_spq = FALSE
	ii_spq_idx = 0
	li_num_prov_query = upperbound(istr_prov_query_container)
	for li_query = 1 to li_num_prov_query
		li_level_num = istr_prov_query_container[li_query].li_level_num
		IF li_level_num < 1 THEN Continue
		iu_query[li_level_num].of_set_istr_prov_query (istr_prov_query_container[li_query].lstr_prov_query, FALSE)	
		/*set istr_prov_query in u_nvo_search so that it gets set in u_nvo_create_sql */
		iu_query[li_level_num].of_Set_Instance_Variables(3,iu_query[li_level_num].invo_tabpagesource)
	next
end if						// FNC 12/29/99 End	

If ib_npq then
	/* reset flag and index in case import another query */
	ib_npq = FALSE
	ii_npq_idx = 0
	li_num_prov_query = upperbound(istr_npi_prov_query_container)
	for li_query = 1 to li_num_prov_query
		li_level_num = istr_npi_prov_query_container[li_query].li_level_num
		IF li_level_num < 1 THEN Continue
		iu_query[li_level_num].of_set_istr_prov_query (istr_npi_prov_query_container[li_query].lstr_prov_query, TRUE)	
		/*set istr_prov_query in u_nvo_search so that it gets set in u_nvo_create_sql */
		iu_query[li_level_num].of_Set_Instance_Variables(3,iu_query[li_level_num].invo_tabpagesource)
	next
end if				

This.event ue_enable_next_button(TRUE)
This.event ue_set_menus_query_select(TRUE)
This.event ue_set_unique_count(0, '')
this.wf_ResetTitle()
this.event ue_show_notes_icon('NONE')							//reset notes for new PDQ
This.wf_setrowdelete(FALSE)
iu_active_query.Event	ue_SelectTab(ic_search)		
w_main.SetMicroHelp ('Ready')
This.setredraw(TRUE)
//iu_active_query.of_SetStatus(Modified!)
iu_active_query.of_SetStatus(DataModified!)

//If any errors occurred, display the PDQ import status window to display the columns in error to the user.  This window allows the user the display a summary of the errors.  From this window, the user can display the details for a level.  The occurrence of errors will not prevent the PDQ from being imported.  Sample code:
IF  ib_error  =  TRUE  THEN
	sx_import_pdq_status lstr_status	
	lstr_status.comments = is_import_comments
	lstr_status.ds_import_pdq_status  =  ids_status
	lstr_status.ds_import_errors  =  ids_errors
	OpenSheetWithParm(w_import_pdq_status,lstr_status,MDI_main_frame,help_menu_position, Layered!)
END IF

this.Event ue_import_clean_up(ll_filenumber)

Return 1
end event

event ue_import_file_hdr;//*********************************************************************************
// Script Name:	ue_import_file_hdr	
//
//	Arguments:		as_record - record being processed in import
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will import the file header.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

String ls_record, ls_file_type
il_record_count ++
				
ls_record = as_record
ls_file_type 		= mid(ls_record,34,3)	//file type 

IF ls_file_type <> 'PDQ'  THEN
	messageBox ('Import Error', 'This file cannot be imported into a PDQ')
	Return  -1
END IF

//Display the comments stored in the file header record
is_import_comments  =  trim(mid(ls_record,45,255))  //comments
Return 1
end event

event ue_import_pdq_hdr;//*********************************************************************************
// Script Name:	ue_import_pdq_hdr	
//
//	Arguments:		as_record - record being processed in import
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will import the pdq header & create 
//						the case link record.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Datetime ldte_datetime
String ls_record

// PDQ Header
ls_record = as_record
il_record_count ++

// Reset the previous level #
il_prev_level_num = 0  

dw_pdq_cntl.InsertRow(0)
dw_pdq_cntl.object.user_id[1] = gc_user_id

is_import_query_id = fx_get_next_key_id("PDQ_TMP_ID")
w_main.SetMicroHelp ('')

dw_pdq_cntl.object.query_id[1] = is_import_query_id

ldte_datetime = gnv_app.of_get_server_date_time()
dw_pdq_cntl.object.create_date[1]  =  ldte_datetime

//Create case_link record
dw_pdq_case_link.InsertRow(0)
dw_pdq_case_link.object.case_id[1] = "NONE"
dw_pdq_case_link.object.case_spl[1] = "  "	
dw_pdq_case_link.object.case_ver[1] = "  "	
dw_pdq_case_link.object.link_type[1] = "PDQ"
dw_pdq_case_link.object.link_key[1] = is_import_query_id
dw_pdq_case_link.object.link_name[1] = is_import_query_id
dw_pdq_case_link.object.link_desc[1] = is_import_query_id + " created on " + &
								String(ldte_datetime,"m-d-yy h:mm am/pm;'none'") + "."
dw_pdq_case_link.object.user_id[1] = gc_user_id
dw_pdq_case_link.object.link_date[1] = ldte_datetime 
dw_pdq_case_link.object.link_status[1] = "A"

Return 1
end event

event type integer ue_import_pdq_table(string as_record);//*********************************************************************************
// Script Name:	ue_import_pdq_table	
//
//	Arguments:		as_record - record being processed in import
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will import the pdq table records.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//	07/14/00	FDG	Track 2465c.  Stars 4.5 SP1.  Include fastquery data in the import.
//	01/16/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	03/01/02	GaryR	Track 2552d	RPT_TITLE increasing to 160 bytes from 60
// 10/13/04 MikeF SPR3650d		Replace local n_cst_dict with gnv_dict
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//*********************************************************************************
//may want to pass in il_status_row, il_summ_row, 

Long		ll_level_num,				&
			ll_rowcount,				&
			ll_row

Integer	li_rc

String	ls_base_type,				&
			ls_record,					&
			ls_rel_type,				&
			ls_table_name,				&
			ls_invoice_type[],		&
			ls_inv_type,				&
			ls_filter,					&
			ls_src_type,				&
			ls_empty

//	01/16/01	GaryR	Stars 4.7 DataBase Port
String	ls_rpt_title, ls_payment_date_options, ls_fastquery_ind
String	ls_rpt_title1	//	03/01/02	GaryR	Track 2552d

N_ds lds_stars_rel

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

lds_stars_rel = Create n_ds
lds_stars_rel.dataobject = 'd_stars_rel_dict'
lds_stars_rel.settransobject(stars2ca)

ls_record = as_record
il_record_count ++

ll_level_num =  Long(mid(ls_record,3,5)) //level_num
IF  ll_level_num  <>  il_prev_level_num  THEN
	// A new level occurred.  Insert the appropriate rows for this level
	il_status_row  =  ids_status.InsertRow(0)
	ids_status.SetRow(il_status_row)
	ids_status.object.level_num [il_status_row] =  ll_level_num
	il_summ_row  =  ids_summary.InsertRow(0)
	ids_summary.SetRow(il_summ_row)
	ids_summary.object.level_num [il_summ_row] =  ll_level_num
END IF
il_prev_level_num  =  ll_level_num

// Get rel_type from the record.
ls_rel_type = mid(ls_record,45,2)	//tbl_rel
ll_rowcount = lds_stars_rel.retrieve()
ids_summary.object.dep_inv_type_required [il_summ_row] = 'N'

CHOOSE CASE ls_rel_type
	CASE 'AN'	// Ancillary table
		// Get base_type from the record.  Base_type has the table name.
		ls_table_name = trim(mid(ls_record,12,32))		//table_name
		ls_inv_type	= gnv_dict.event ue_get_inv_type(ls_table_name)
		If Upper(ls_inv_type) = 'ERROR' then
			Return -1
		End If
		is_prev_inv_type  =  ls_inv_type
		ids_summary.object.tbl_rel [il_summ_row] = 'AN'
		ls_base_type = trim(mid(ls_record,12,32)) //base type
		ids_summary.object.base_type [il_summ_row] = ls_base_type
		ids_summary.object.inv_type [il_summ_row] =  ls_inv_type
		ids_summary.object.inv_type_desc [il_summ_row] = trim(mid(ls_record,132,15)) //tbl_desc
		ids_summary.object.dep_inv_type_required [il_summ_row] = 'N'
//		ids_summary.object.dep_inv_type_desc [il_summ_row] = ""
//		ids_summary.object.dep_inv_type [il_summ_row] = ""
  	CASE 'DP'	// Dependent table (The GP record always preceeds the DP record)
		ids_summary.object.dep_inv_type_required [il_summ_row] = 'Y'
		ids_summary.object.dep_inv_type_desc [il_summ_row] = trim(mid(ls_record,132,15)) //tbl_desc
		ls_filter  =  "rel_type = 'DP'  and  rel_id  = '"  +  is_prev_inv_type  +  "'"
		lds_stars_rel.SetFilter('')
		lds_stars_rel.Filter()
		lds_stars_rel.SetFilter(ls_filter)
		lds_stars_rel.Filter()
		ll_rowcount  =  lds_stars_rel.RowCount()
		IF  ll_rowcount  =  1  THEN
			ls_inv_type  =  lds_stars_rel.object.id_2 [1]
			ids_summary.object.dep_inv_type [il_summ_row] =  ls_inv_type
		END IF
	CASE 'GP'	// Base table
		ls_base_type = trim(mid(ls_record,12,32)) //base type
		ids_summary.object.tbl_rel [il_summ_row] = 'GP'
		ids_summary.object.base_type [il_summ_row] =  ls_base_type
		ids_summary.object.inv_type_desc [il_summ_row] = trim(mid(ls_record,132,15)) //tbl_desc
		ls_filter  =  "rel_type = 'QT'  and  key6  = '"  +  ls_base_type  +  "'"
		lds_stars_rel.SetFilter('')
		lds_stars_rel.Filter()
		lds_stars_rel.SetFilter(ls_filter)
		lds_stars_rel.Filter()
		ll_rowcount  =  lds_stars_rel.RowCount()
		IF  ll_rowcount  =  0  THEN
				// No invoice types exist for this base type.  Get out
				MessageBox('Error', 'No invoice types exist for base type: '  +  ls_base_type)
				If isValid(lds_stars_rel) then Destroy(lds_stars_rel)
				Return  -1
		END IF
		IF  ll_rowcount  =  1  THEN
				ls_inv_type  =  lds_stars_rel.object.id_2 [1]
				ids_summary.object.inv_type [il_summ_row] =  ls_inv_type
		END IF
		// If the source is a subset, specify for this level that a subset ID is required.  
		// Please note that each level of a ML PDQ can have a different subset.
		ls_src_type = trim(mid(ls_record,48,2)) // Source Subset
		IF ls_src_type = 'SS'  THEN	
				ids_summary.object.subset_required [il_summ_row] = 'Y'
		END IF
		is_prev_inv_type  =  ls_inv_type

	CASE ELSE
		MessageBox ('Error', 'Can not determine table relation: main, dependent, or ancillary table')
		If isValid(lds_stars_rel) then Destroy(lds_stars_rel)
		Return -1
		
END CHOOSE

//Populate PDQ table record
//TBL_TYPE will be filled in after the user selects them in the w_import_pdq_summary window
ll_row = dw_pdq_tables.InsertRow(0)
dw_pdq_tables.object.query_id [ll_row] = is_import_query_id
dw_pdq_tables.object.level_num [ll_row] = Long(mid(ls_record,3,5))		//level_num

//The following line of code is necessary because QE stores all ancillary table
//on the PDQ table as GP.  This is done so QE knows it is a main and not
//a dependent table.
If ls_rel_type = 'AN' then
	dw_pdq_tables.object.tbl_rel [ll_row] = 'GP'
else
	dw_pdq_tables.object.tbl_rel [ll_row] = trim(mid(ls_record,45,2))		//tbl_rel
End If

dw_pdq_tables.object.src_type [ll_row] = trim(mid(ls_record,48,2))		//src_type
dw_pdq_tables.object.src_case_id [ll_row] = " "
dw_pdq_tables.object.src_case_spl [ll_row] = " "
dw_pdq_tables.object.src_case_ver [ll_row] = " "
dw_pdq_tables.object.src_subset_name [ll_row] = " "

//	01/16/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
ls_rpt_title				= trim(mid(ls_record,51,80))						//report title part 1
//	03/01/02	GaryR	Track 2552d - Begin
ls_rpt_title1				= trim(mid(ls_record,222,80))						//report title part 2
ls_rpt_title 				+= ls_rpt_title1
//	03/01/02	GaryR	Track 2552d - End
ls_payment_date_options	= trim(mid(ls_record,149,60))		//payment date options
ls_fastquery_ind			= trim(mid(ls_record,209,1))				//	FDG 07/14/00

IF Trim( ls_rpt_title )					= "" THEN ls_rpt_title					= ls_empty
IF Trim( ls_payment_date_options )	= "" THEN ls_payment_date_options	= ls_empty
IF Trim( ls_fastquery_ind )			= "" THEN ls_fastquery_ind				= ls_empty

dw_pdq_tables.object.rpt_title [ll_row]				= ls_rpt_title
dw_pdq_tables.object.payment_date_options [ll_row]	= ls_payment_date_options
dw_pdq_tables.object.fastquery_ind [ll_row]			= ls_fastquery_ind
//	01/16/01	GaryR	Stars 4.7 DataBase Port - End

dw_pdq_tables.object.fastquery_rows [ll_row] = Long(mid(ls_record,211,10))				//	FDG 07/14/00

IF	gc_debug_mode	THEN
	f_debug_box ('Debug', ' ')
	f_debug_box ('Debug', 'fastquery_ind = '	+	dw_pdq_tables.object.fastquery_ind [ll_row]	+	&
				'.  fastquery_rows = '			+	String (dw_pdq_tables.object.fastquery_rows [ll_row])	+	'.')
END IF

If isValid(lds_stars_rel) then Destroy(lds_stars_rel)

Return 1

end event

event type integer ue_import_pdq_crit(string as_record);//*********************************************************************************
// Script Name:	ue_import_pdq_crit	
//
//	Arguments:		as_record - record being processed in import
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will import the pdq criteria records.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
// 12/29/99 FNC	If expression one contains 'SUPER PROVIDER' ignore error.
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//	05/12/09 RickB GNL.600.5633.013 Changed beginning of error message from 'Criteria:' to 'ERROR:'
//						The datatype identifies the error as a 'Criteria' error.
//	05/28/09	GaryR	GNL.600.5633.013	Fix color issues and error identification issues
//						identified in defect #47
//
//*********************************************************************************

Long ll_level_num, ll_level_seq_num, ll_row
String ls_record, ls_inv_type, ls_col_name, ls_import_inv_type[]

sx_prov_query_structure	lstr_prov_query   

// Determine if the criteria exists using col_name from the record.
// and determine the invoice type (Criteria could be from the dependent table)
ls_record = as_record
il_record_count ++

ll_level_num =  Long(mid(ls_record,3,5)) //level_num 
IF  ll_level_num  <>  il_prev_level_num  THEN
	// Get the invoice type & dependent table from lds_summary
	// Clear out for each level first
	is_import_inv_type = ls_import_inv_type[]
	If IsNull(ids_summary.object.inv_type [ll_level_num]) then
		//Continue
	Else
		is_import_inv_type [1]  = left(ids_summary.object.inv_type [ll_level_num],2)
	End If
	If IsNull(ids_summary.object.dep_inv_type [ll_level_num]) then
		//Continue
	Else
		is_import_inv_type [2]  = left(ids_summary.object.dep_inv_type [ll_level_num],2)
	End If
END IF

il_prev_level_num  =  ll_level_num

//level_seq_num determines whether this is a main or dependent table column
//Value will equal 1 for main and 2 for a dependent 
ll_level_seq_num =  Long(mid(ls_record,9,2)) //level_num 
ls_inv_type  = is_import_inv_type [ll_level_seq_num]

//If an error exists, ALL criteria will be displayed so automatically
//add all criteria to the errors datastore
ll_row  =  ids_errors.InsertRow(0)
ids_errors.object.level_num [ll_row]  =  ll_level_num
ids_errors.object.seq_num [ll_row] = Long(mid(ls_record,12,8)) //seq_num
ids_errors.object.data_type [ll_row]  =  'CRITERIA'
ids_errors.object.column_desc [ll_row]  =  mid(ls_record,331,15) //col_desc

//For criteria "error text" contains criteria line
//The following lines = left_paren + col_desc + rel_op
//								+ col_value + right_paren + logic_op
ids_errors.object.error_text [ll_row]  =  Trim (mid(ls_record,21,2))  +  Trim(mid(ls_record,331,15))  +  ' '  +  Trim(mid(ls_record,55,12))  +  &
	' '  +  Trim(mid(ls_record,68,255))  +  Trim(mid(ls_record,324,2))  +  ' '  +  Trim(mid(ls_record,327,3))

ls_col_name = Trim(mid(ls_record,24,30))
	
IF gnv_dict.event ue_get_col_exists( ls_inv_type, ls_col_name ) &
OR ls_col_name = 'SUPER PROVIDER' OR ls_col_name = 'SUPER NPI PROVIDER' THEN 	// FNC 12/29/99
	//Populate dw_pdq_criteria table
	ll_row = dw_pdq_criteria.InsertRow(0)
	dw_pdq_criteria.object.query_id [ll_row] = is_import_query_id
	dw_pdq_criteria.object.level_num [ll_row] = ll_level_num
	dw_pdq_criteria.object.seq_num [ll_row] = Long(Trim(mid(ls_record,12,8)))				
	dw_pdq_criteria.object.tbl_type [ll_row] = ls_inv_type
	dw_pdq_criteria.object.left_paren [ll_row] = Trim(mid(ls_record,21,2))
	dw_pdq_criteria.object.col_name [ll_row] = Trim(mid(ls_record,24,30))
	dw_pdq_criteria.object.rel_op [ll_row] = Trim(mid(ls_record,55,12))
	dw_pdq_criteria.object.col_value [ll_row] = Trim(mid(ls_record,68,255))
	dw_pdq_criteria.object.right_paren [ll_row] = Trim(mid(ls_record,324,2))
	dw_pdq_criteria.object.logic_op [ll_row] = Trim(mid(ls_record,327,3))
ELSE
	//Column does not exist, so mark criteria line in error
	ib_error  =  TRUE
	ids_errors.object.error_ind [ll_row]  = 'Y'
	ids_status.object.criteria_errors [ll_level_num] = 'Y'
	ids_errors.object.error_text [ll_row]  =  'ERROR: '  +  &
										ids_errors.object.error_text [ll_row]
END IF

Return 1
end event

event type integer ue_import_pdq_col(string as_record);//*********************************************************************************
// Script Name:	ue_import_pdq_col	
//
//	Arguments:		as_record - record being processed in import
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will import the pdq column records.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//	12/29/99 FNC	Set super provider structure which will be set in uo_query in 
//						ue_import_pdq.
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//  04/13/09  RickB  SPR 5633  Added "Error:" to the error message displayed when a column does
//  									not exist.  Section 508 requirement.
//  04/17/09 RickB GNL.600.5633.013 - Changed "Error" to all caps.
//
//*********************************************************************************

Long ll_level_num, ll_level_seq_num, ll_row
String ls_record, ls_inv_type, ls_col_name, ls_import_inv_type[]

sx_prov_query_structure	lstr_prov_query   

// Determine if the column exists using col_name from the record.
// and determine the invoice type (Column could be from the dependent table)
ls_record = as_record

il_record_count ++
ll_level_num =  Long(mid(ls_record,3,5)) //level_num
IF  ll_level_num  <>  il_prev_level_num  THEN
	// Get the invoice type & dependent table from lds_summary
	// Clear out for each level first
	is_import_inv_type = ls_import_inv_type[]
	If IsNull(ids_summary.object.inv_type [ll_level_num]) then
		//Continue
	Else
		is_import_inv_type [1]  = left(ids_summary.object.inv_type [ll_level_num],2)
	End If
	If IsNull(ids_summary.object.dep_inv_type [ll_level_num]) then
		//Continue
	Else
		is_import_inv_type [2]  = left(ids_summary.object.dep_inv_type [ll_level_num],2)
	End If
END IF
il_prev_level_num  =  ll_level_num

//level_seq_num determines whether this is a main or dependent table column
//Value will equal 1 for main and 2 for a dependent 
ll_level_seq_num =  Long(mid(ls_record,9,2)) //level_seq_num 
ls_inv_type = is_import_inv_type [ll_level_seq_num]
ls_col_name = Trim(mid(ls_record,21,30))
	
IF gnv_dict.event ue_get_col_exists( ls_inv_type, ls_col_name ) THEN
	//Populate PDQ column table 
	ll_row = dw_pdq_columns.InsertRow(0)
	dw_pdq_columns.object.query_id[ll_row]  = is_import_query_id
	dw_pdq_columns.object.level_num[ll_row]  = ll_level_num
	dw_pdq_columns.object.seq_num[ll_row]  = Long(Trim(mid(ls_record,12,8))) 
	dw_pdq_columns.object.tbl_type[ll_row]  = ls_inv_type 
	dw_pdq_columns.object.col_name[ll_row]  = ls_col_name 
	dw_pdq_columns.object.col_type[ll_row]  = Trim(mid(ls_record,52,3))
	if Trim(mid(ls_record,52,3)) = 'SPQ' then			// FNC 12/29/99 Start
		IF  ll_level_num  <>  il_prev_level_num  THEN
			/* Reset super provider query query index for each level */
			ii_spq_idx = 0
		END IF
		ib_spq = TRUE
		ii_spq_idx++
		istr_prov_query_container[ll_level_num].lstr_prov_query.do_prov_query = TRUE
		istr_prov_query_container[ll_level_num].lstr_prov_query.prov_fields[ii_spq_idx].selected			=	TRUE
		istr_prov_query_container[ll_level_num].lstr_prov_query.prov_fields[ii_spq_idx].table_type		=	ls_inv_type 
		istr_prov_query_container[ll_level_num].lstr_prov_query.prov_fields[ii_spq_idx].prov_col_name	=	Trim(mid(ls_record,21,30))
		istr_prov_query_container[ll_level_num].li_level_num = ll_level_num
	end if															// FNC 12/29/99 End
	if Trim(mid(ls_record,52,3)) = 'NPQ' then			// FNC 12/29/99 Start
		IF  ll_level_num  <>  il_prev_level_num  THEN
			/* Reset super npi provider query query index for each level */
			ii_npq_idx = 0
		END IF
		ib_npq = TRUE
		ii_npq_idx++
		istr_npi_prov_query_container[ll_level_num].lstr_prov_query.do_prov_query = TRUE
		istr_npi_prov_query_container[ll_level_num].lstr_prov_query.prov_fields[ii_npq_idx].selected			=	TRUE
		istr_npi_prov_query_container[ll_level_num].lstr_prov_query.prov_fields[ii_npq_idx].table_type		=	ls_inv_type 
		istr_npi_prov_query_container[ll_level_num].lstr_prov_query.prov_fields[ii_npq_idx].prov_col_name	=	Trim(mid(ls_record,21,30))
		istr_npi_prov_query_container[ll_level_num].li_level_num = ll_level_num
	end if
ELSE
	//Column does not exist, add it to the list of columns in error
	ib_error  =  TRUE
	ll_row  =  ids_errors.InsertRow(0)
	ids_errors.object.level_num [ll_row]  =  ll_level_num
	ids_errors.object.seq_num [ll_row] = Long(mid(ls_record,12,8)) //seq_num
	ids_errors.object.data_type [ll_row]  =  'COLUMN'
	ids_errors.object.column_desc [ll_row]  =  mid(ls_record,56,15) //col_desc
	ids_errors.object.error_text [ll_row]  =  'ERROR: Column does not exist'
	ids_errors.object.error_ind [ll_row]  = 'Y'
	ids_status.object.column_errors [ll_level_num] = 'Y'
END IF

Return 1
end event

event ue_import_clean_up(long al_file_number);//*********************************************************************************
// Script Name:	ue_import_clean_up	
//
//	Arguments:		al_file_number - number of the file to close
//						
//
// Returns:			N/A
//
//	Description:	This user event will clean up all open objects at the end of an
//						import or if the import fails in the middle.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//
//*********************************************************************************

//Clean up PDQ datawindows
This.Event  ue_clear_pdq_datawindows()

//Close the file
FileClose(al_file_number)

//Destroy the instance datastores created in ue_import_pdq
If IsValid(ids_summary) then Destroy ids_summary
If IsValid(ids_errors)  then Destroy ids_errors
If IsValid(ids_status)  then Destroy ids_status
end event

event ue_import_get_table_types;//*********************************************************************************
// Script Name:	ue_import_get_table_types	
//
//	Arguments:		N/A
//						
//
// Returns:			-1 = failure
//						 1 = success
//
//	Description:	This user event will open the import summary window for the user 
//						to choose invoice types, dependent invoice types and source 
//						subsets.  It will also process the returned choices.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Long ll_row, ll_max_rows, ll_level, ll_max_levels
sx_import_pdq_summary	lstr_summary
il_record_count ++

// Reset the previous level # for the columns and criteria
il_prev_level_num  =  0

//Open Import summary window
lstr_summary.comments = is_import_comments
lstr_summary.ds_import_pdq_summary = ids_summary
OpenWithParm (w_import_pdq_summary, lstr_summary)
lstr_summary = Message.PowerObjectParm
SetNull (Message.PowerObjectParm)
IF  lstr_summary.message = 'CANCEL'  THEN
		Return -1
END IF

//Process the invoice types and subsets chosen by the user
ids_summary  =  lstr_summary.ds_import_pdq_summary

ll_max_levels = ids_summary.RowCount()
FOR ll_level = 1 to ll_max_levels
		ll_max_rows = dw_pdq_tables.RowCount()
		for ll_row = 1 to ll_max_rows
			If dw_pdq_tables.object.level_num[ll_row] = ids_summary.object.level_num[ll_level] and &
				dw_pdq_tables.object.tbl_rel[ll_row] = 'DP' then
						dw_pdq_tables.object.tbl_type [ll_row] = left(ids_summary.object.dep_inv_type[ll_level],2)		//tbl_type
			End IF
			If dw_pdq_tables.object.level_num[ll_row] = ids_summary.object.level_num[ll_level] and &
				dw_pdq_tables.object.tbl_rel[ll_row] = 'GP' or dw_pdq_tables.object.tbl_rel[ll_row] = 'AN' then
				//do I need an here
				dw_pdq_tables.object.tbl_type [ll_row] = left(ids_summary.object.inv_type[ll_level],2)		//tbl_type
				
				If ids_summary.object.subset_required [ll_level] = 'Y' then
					String ls_subset_name
					ls_subset_name = ids_summary.object.subset_name[ll_level]
					If len(ls_subset_name) > 0 then
							//get subsetname and case id
							dw_pdq_tables.object.src_subset_name [ll_row] = ids_summary.object.subset_name[ll_level]
							dw_pdq_tables.object.src_case_id [ll_row] = ids_summary.object.case_id[ll_level]
							dw_pdq_tables.object.src_case_spl [ll_row] = ids_summary.object.case_spl[ll_level]
							dw_pdq_tables.object.src_case_ver [ll_row] = ids_summary.object.case_ver[ll_level]
					else
						//must choose subset, taken care of in summary window
					End If
				End IF
			End If
		next
NEXT
il_prev_level_num = 0
Return 1
end event

event ue_show_notes_icon(string as_case_id);//*********************************************************************************
// Script Name:	w_query_engine.ue_show_notes()
//
//	Arguments:		as_case_id
//						
//
// Returns:			none
//
//	Description:	This script is called from w_query_engine.ue_select_pdq().
//						It checks to see if notes are attached to the pdq.  
//						If so, display the notes icon on tabpages search & view.  If it's
//						an independent pdq, the note_rel_type will be the case_link.link_name
//						of the pdq.  If it's a case pdq, it will check if there are any
//						case notes of type PQ.  The note rel type will be the case id+spl+ver.
//		
//
//*********************************************************************************
//	
// 12-03-99 NLG	Created.
// 10/16/2006 Katie SPR 2901 - Added trim for CASE = NONE
//
//*********************************************************************************

long ll_count
string ls_query_id

IF upper(trim(as_case_id)) = 'NONE' THEN
	ls_query_id = dw_pdq_case_link.object.link_name[1]
	Select count(*) into :ll_count
	From Notes
	Where note_rel_type = 'PQ' 
	and note_rel_id = Upper( :ls_query_id )
	using stars2ca;
	if stars2ca.of_check_status() < 0 then
		errorbox(stars2ca,'Error reading Notes table: Note_rel_type = PQ and note_rel_id = ' + is_query_id )
		return
	end if
ELSE
	Select count(*) into :ll_count
	From Notes
	Where note_rel_type = 'CA' and
			note_sub_type = 'PQ'
	and note_rel_id = Upper( :as_case_id )
	using stars2ca;
	if stars2ca.of_check_status() < 0 then
		errorbox(stars2ca,'Error reading Notes table: ' +&
		'~rNote_rel_type = CA ~rNote_sub_type = PQ ~rNote_rel_id = ' + Upper( as_case_id ) )
		return
	end if
END IF

if ll_count > 0 then
	iu_active_query.tabpage_search.pb_notes_search.visible = true
	iu_active_query.tabpage_view.pb_notes_view.visible = true
else
	iu_active_query.tabpage_search.pb_notes_search.visible = false
	iu_active_query.tabpage_view.pb_notes_view.visible = false
end if
end event

event ue_determine_pd_opt_visibility();/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	ue_determine_pd_opt_visibility						W_Query_Engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event determines if the ddlb_pd_opts on the search tab of uo_query
//	should be seen. If it is a ML and it is a regularly scheduled pdq then
// the pd_opt_ddlb is invisible on levels> 1.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype		Description
//		---------	--------			--------		-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		None
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	FNC				12/13/99		Created. Fraud PDQs.
// FNC				10/25/01 	Track 3683. Make pd_opt ddlb invisible is query
//										uses a Subset as the source.
/////////////////////////////////////////////////////////////////////////////

integer 	li_levels, li_level_num, li_run_frequency
boolean 	lb_visible,			&
			lb_clear_pd_opt
string 	ls_frequency

u_dw						ldw_prev_criteria


/*Retrieve frequency of first level */
ls_frequency = trim(iu_query[1].of_get_pd_opt_desc() )
ls_frequency  =  trim(Left (ls_frequency, 2))

if iu_active_query.is_source_type = 'AN' or &
	iu_active_query.of_get_data_type() = 'SUBSET' then //FNC 10/25/01
	iu_active_query.of_set_pd_opt_visibility(FALSE)
else
	iu_active_query.of_set_pd_opt_visibility(TRUE)	
end if

/* Set run frequency here so that it is set for existing querries. The other place that
   it is set is in the uo_query.ddlb_pd_opt selection changed event */
	
CHOOSE CASE  ls_frequency
	CASE  'M'
		li_run_frequency  =  1
	CASE  'Q'
		li_run_frequency  =  3
	CASE  'S'
		li_run_frequency  =  6
	CASE  'A'
		li_run_frequency  =  12
	CASE ELSE
		li_run_frequency 	= 0
END CHOOSE

wf_set_ii_run_frequency(li_run_frequency)

li_levels	=	wf_get_max_uo_query()
if li_levels > 1 then
	/* Store criteria from first level so dates can be copied to other levels.*/
	ldw_prev_criteria	=	iu_query[1].of_get_dw_criteria()
	CHOOSE CASE  ls_frequency
		CASE 'M','S','Q','A'
		/* If job is recurring payment date options ddlb must be invisible and dates
		   carried forward */
			for li_level_num = 2 to li_levels
				/* set ddlb to invisible */
				iu_query[li_level_num].of_set_pd_opt_visibility(FALSE)
				iu_query[li_level_num].of_set_idw_prev_criteria(ldw_prev_criteria)
				/* Set dates in dw_criteria on subsequent levels */
				iu_query[li_level_num].Event ue_tabpage_search_set_dates()
			next
		CASE ELSE
			/* If first level is not recuring, payment date options ddlb is visible
				and recuring options are removed */
			for li_level_num = 2 to li_levels
				if iu_query[li_level_num].of_get_data_type() = 'BASE' then		//FNC 10/25/01
					iu_query[li_level_num].of_set_idw_prev_criteria(ldw_prev_criteria)	
					/* Set ddlb to visible and remove recurring items */
					iu_query[li_level_num].of_set_pd_opt_visibility(TRUE)
					iu_query[li_level_num].event ue_clear_pd_opt()
				end if
				if ii_level_num = 1 then
					CHOOSE CASE  is_prev_frequency
						CASE 'M','S','Q','A'
							/* Set dates in dw_criteria on subsequent levels */
							iu_query[li_level_num].Event ue_tabpage_search_set_dates()
							/* Set value in ddlb */
							iu_query[li_level_num].tabpage_search.ddlb_pd_opt.text = &
							iu_query[1].tabpage_search.ddlb_pd_opt.text
						END CHOOSE
				end if
			next
		END CHOOSE
end if

is_prev_frequency = ls_frequency


end event

event ue_edit_menus_delete(string as_case_id, string as_case_spl, string as_case_ver);//*********************************************************************
//	Script:		ue_edit_menus_delete
//
//	Arguments:	1. as_case_id
//					2. as_case_spl
//					3.	as_case_ver
//
//	Returns:		None
//
//	Description:
// 	Determine if the selected PDQ in dw_list can be deleted based
//		on whether or not its associated case is closed or deleted.
//
//*********************************************************************
//	History
//
//	FDG	09/21/01	Stars 4.8.1.	Created
//	FDG	12/21/01	Track 2497.  Make lnv_case local to prevent memory leaks
//
//*********************************************************************

Boolean	lb_valid_case

n_cst_case		lnv_case		// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case

lb_valid_case	=	lnv_case.uf_edit_case_closed (as_case_id, as_case_spl, as_case_ver)

Destroy	lnv_case			// FDG 12/21/01

IF	lb_valid_case	=	TRUE		THEN
	im_list.m_menu.m_delete.enabled	=	TRUE
ELSE
	im_list.m_menu.m_delete.enabled	=	FALSE
END IF

end event

protected function integer wf_getuoxpos ();RETURN iix_pos
end function

protected function integer wf_getuoypos ();RETURN iiy_pos
end function

protected function integer wf_setuopos ();iix_pos = tab_level.tabpage_1.X + 20
iiy_pos = tab_level.tabpage_1.Y + 20

RETURN 1
end function

public function uo_query wf_getactivequery ();Return iu_active_query
end function

public function integer wf_newlevel (integer ai_level);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_engine				wf_NewLevel
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Open the ai_Level query engine, call source construct event, select the
//	source tabpage, and select the level tabpage.
/////////////////////////////////////////////////////////////////////////////

// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			ai_level	Integer	The new query level.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success	
//						-1			Level is over ic_max_levels.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	JTM		01/13/98	Created.
//	FDG		02/24/98	Open uo_query via a script instead of
//							openuserobjectwithparm & ue_tabpage_source_construct
//	FDG		03/02/98	Track 876.  Select uo_query tab via an event.
//	FDG		08/19/98	Track 1560.  Take dw_criteria from the previous level
//							and store it into idw_prev_criteria in the new level.
//	FDG		11/04/98	Track 1825.  Use uo_query functions when accessing
//							dw_criteria and idw_prev_criteria.
//	FDG		02/05/99	Track 2084c.  Set ib_new_level so that the filter info
//							does not get cleared out in the prior level.
//	NLG		12/08/99	Fraud pdq. Hide payment date options listbox for 
//							levels greater than 1 for recurring pdqs
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_Return

sx_drilldown_parms	lstr_drilldown_parms

u_dw						ldw_prev_criteria

Constant String LS_NEWLEVEL = "NEW_LEVEL"

IF ai_Level > ic_max_levels THEN RETURN -1

this.SetRedraw(FALSE)

ib_new_level	=	TRUE			// FDG 02/05/99

//ldw_prev_criteria	=	iu_active_query.tabpage_search.dw_criteria	// FDG 08/19/98	// FDG 11/04/98
ldw_prev_criteria	=	iu_active_query.of_get_dw_criteria()				// FDG 11/04/98

li_return	=	This.Event ue_open_uo_query ( iu_query[ai_Level], lstr_drilldown_parms, LS_NEWLEVEL)	// FDG 02/24/98
iu_query[ai_level].of_set_idw_prev_criteria(ldw_prev_criteria)	// FDG 11/04/98
iu_query[ai_level].Event	ue_tabpage_search_set_dates()			// FDG 08/19/98
//NLG 12/08/99 START****
string ls_frequency
boolean lb_visible
ls_frequency = trim(iu_query[1].of_get_pd_opt_desc() )
ls_frequency  =  trim(Left (ls_frequency, 2))
CHOOSE CASE  ls_frequency
	CASE 'M','S','Q','A'
		lb_visible = FALSE
	CASE ELSE
		lb_visible = TRUE
END CHOOSE
iu_query[ai_level].of_set_pd_opt_visibility(lb_visible)
//NLG 12/08/99 STOP*****
iu_Query[ai_Level].tabpage_source.enabled = TRUE
iu_query[ai_Level].Event	ue_SelectTab(ic_source)		//	FDG 03/02/98
tab_level.selecttab(ai_Level)
If ai_Level = 1 Then this.wf_ResetTitle()
this.wf_ResizeUo(ai_level)
this.SetRedraw(True)

ib_new_level	=	FALSE			// FDG 02/05/99


RETURN li_Return
end function

public function integer wf_setleveltext (integer ai_level);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_engine				wf_SetLevelText
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Sets the level tabpage text based upon the invoice type of query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			ai_Level	Integer	The level.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/16/98	Created.
//
//	FDG		02/27/97	Change the text of all levels to make the tab size
//							smaller.  Add SetRedraw to prevent screen flicker.
//
//	FDG		03/16/98	Track 918.  Get the upperbound of iu_query thru
//							function wf_get_max_uo_query().
//
//	GaryR		04/11/03	Track 3517d	PDR label changes
//	GaryR		05/10/04	Track 3756d	Streamline PDR deployment & security
//	GaryR		10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR		12/11/04	Track 4108d	Dynamic Report Options
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

This.SetRedraw (FALSE)

Integer	li_upper,		&
			li_level,		&
			li_row

String	ls_LevelText, ls_desc
Constant String	LS_DELIMIT = ' '
sx_pdr_parms	lsx_pdr_parms
DatawindowChild	ldwc_desc

li_upper	=	wf_get_max_uo_query()			//	FDG 03/16/98

FOR	li_level	=	1	TO	IC_MAX_LEVELS
	// check if active query has been assigned to array
	IF	li_level	=	ai_level		THEN
		// Current level - use full text for the current level
		ls_leveltext	=	IS_LEVELTEXT
	ELSE
		// Not the current level - use abbreviated text for the other levels
		ls_leveltext	=	IS_LVLTEXT
	END IF
	ls_leveltext	=	ls_leveltext	+	String(li_level)	+	LS_DELIMIT
	
	IF This.of_is_pdr_mode() THEN
		IF This.of_get_pdr_parm( lsx_pdr_parms ) < 0 THEN Return -1
		
		IF li_level	<=	li_upper						THEN
			iu_Query[li_Level].Tag = ls_leveltext + iu_query[li_level].is_inv_type
		ELSE
			iu_active_query.Tag = ls_leveltext	+	iu_active_query.is_inv_type
		END IF
		
		ls_leveltext += "- " + lsx_pdr_parms.rpt_name
	ELSE
		IF li_level	<=	li_upper						THEN
			// setting text from change of invoice type
			ls_LevelText	=	ls_leveltext	+	iu_query[li_level].is_inv_type
			iu_Query[li_Level].Tag = ls_LevelText	
		ELSE
			// setting text from default invoice type being set in tabpage_source_construct event
			ls_LevelText	=	ls_leveltext	+	iu_active_query.is_inv_type	
			iu_active_query.Tag = ls_LevelText	
		END IF
	END IF
	
	CHOOSE CASE li_Level
		
		CASE 1
			tab_level.tabpage_1.text = ls_LevelText
		CASE 2
			tab_level.tabpage_2.text = ls_LevelText
		CASE 3
			tab_level.tabpage_3.text = ls_LevelText
		CASE 4
			tab_level.tabpage_4.text = ls_LevelText
		CASE 5
			tab_level.tabpage_5.text = ls_LevelText
		CASE 6
			tab_level.tabpage_6.text = ls_LevelText
		CASE 7
			tab_level.tabpage_7.text = ls_LevelText
		CASE 8
			tab_level.tabpage_8.text = ls_LevelText
		CASE 9
			tab_level.tabpage_9.text = ls_LevelText
		CASE 10
			tab_level.tabpage_10.text = ls_LevelText
	END CHOOSE
NEXT

This.SetRedraw (TRUE)

RETURN 1
end function

public function tab wf_gettab ();RETURN tab_level
end function

protected function integer wf_resizeuo (integer ai_level);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// wf_ResizeUo									w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This f() will resize uo_Query with respect to the current size
//	of the level tabpage.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			ai_level		Integer				The levels to resize.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success
//						-1				ai_Level is invalid.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/18/97		Created.
//	J.Mattis	01/27/98		Added level parameter to correct resize error on
//								query levels > 2.
//	FDG		02/26/98		If the window's not resized, don't resize the
//								user object.
//	FDG		03/30/98		Track 997.  Only add uo_query to the control array
//								once.
//	FDG		05/08/98		Track 1195.  Add uo_query to the control array before
//								checking for the resize.
//	GaryR		10/22/04		Standardize the appearance
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_Height, li_Width, li_MaxControl, i
Boolean lb_ResizeActive = TRUE

IF ai_Level < 1 OR ai_Level > ic_max_levels THEN RETURN -1

this.SetRedraw(FALSE)
	
//add the instance of uo_Query to w_query_engine's control array
li_MaxControl = This.Event	ue_get_upperbound (This.Control)		// FDG 03/30/98
this.Control[li_MaxControl + 1] = iu_query[ai_level]				// FDG 03/30/98

iu_active_query.BringToTop = TRUE

IF gnv_app.of_get_resize()	=	FALSE		THEN
	this.SetRedraw(TRUE)
	Return 0
END IF

FOR i = 1 TO ai_level
	
	//resize the user object to fit tabpage
	li_Height = tab_level.tabpage_1.height - 5 
	li_Width = tab_level.tabpage_1.width - 5

	If NOT(IsValid(iu_active_query.inv_resize)) Then 
		//instantiate the resize service of the current (active) instance of uo_Query.
		iu_active_query.of_SetResize(TRUE)
	End If
	
	//instantiate resize service 
	If NOT(IsValid(iu_query[i].inv_resize)) Then 
		iu_query[i].of_SetResize(TRUE)
	End If

	iu_query[i].Event ue_register_resize(iu_query[i].Control)
	
	//set the new size for uo_Query
	iu_query[i].height = li_Height
	iu_query[i].width = li_Width
	
	//only resize active query once
	If lb_ResizeActive Then
		iu_active_query.height = li_Height
		iu_active_query.width = li_Width
		lb_ResizeActive = FALSE
	End If
	
NEXT

this.SetRedraw(TRUE)

RETURN 1
end function

protected function integer wf_disablelevels ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_query_engine				wf_DisableLevels		Protected
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Removes all but the initial instance of uo_query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
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
//	J.Mattis			01/27/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

tab_level.tabpage_2.enabled = FALSE
tab_level.tabpage_2.visible = FALSE
tab_level.tabpage_3.enabled = FALSE
tab_level.tabpage_3.visible = FALSE
tab_level.tabpage_4.enabled = FALSE
tab_level.tabpage_4.visible = FALSE
tab_level.tabpage_5.enabled = FALSE
tab_level.tabpage_5.visible = FALSE
tab_level.tabpage_6.enabled = FALSE
tab_level.tabpage_6.visible = FALSE
tab_level.tabpage_7.enabled = FALSE
tab_level.tabpage_7.visible = FALSE
tab_level.tabpage_8.enabled = FALSE
tab_level.tabpage_8.visible = FALSE
tab_level.tabpage_9.enabled = FALSE
tab_level.tabpage_9.visible = FALSE
tab_level.tabpage_10.enabled = FALSE
tab_level.tabpage_10.visible = FALSE

RETURN 1
end function

public function integer of_updatechecks ();//////////////////////////////////////////////////////////////////////////////

//	OVERRIDE! - due to save processing in query engine having to update ONLY the PDQ
//					dws.
//	Function:  w_query_engine.of_UpdateChecks
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = updates were found
//	 0 = No changes to update were found
//	-1 = AcceptText error
//	-2 = UpdatesPending error was encountered
//	-3 = Validation error was encountered
//
//	Description:
//		Determine if any updates occured and if so, do they pass the
//		validation rules (missing required fields)
//
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		02/02/98		Created.
//	J.Mattis		02/03/98		If not processing closequery then perform overridden method.
//	FDG			03/16/98		Track 918.  Get the upperbound of iu_query thru
//									function wf_get_max_uo_query().
//	GaryR			12/11/04		Track 4108d	Dynamic Report Options
/////////////////////////////////////////////////////////////////////////////


// if not processing closequery then perform overridden method
IF Not(iu_active_query.of_GetFromCloseQuery()) Then RETURN SUPER::of_UpdateChecks()

Integer		li_pending_rc, li_Level, li_Index, li_MaxLevel
Boolean		lb_rpt_updates
powerobject	lpo_pendingupdates[]

li_MaxLevel = wf_get_max_uo_query()			// FDG 03/16/98

// Determine if any changes are pending.
ipo_pendingupdates = lpo_pendingupdates // Clear the instance

//loop through all levels and assign dws used to populate PDQ dws
FOR li_Level = 1 TO li_MaxLevel
	If IsValid(iu_query[li_Level]) Then
		li_Index++
		lpo_pendingupdates[li_Index]=iu_query[li_Level].of_Get_Source_Dw()
		li_Index++
		lpo_pendingupdates[li_Index]=iu_query[li_Level].of_Get_Search_Dw()
		li_Index++
		lpo_pendingupdates[li_Index]=iu_query[li_Level].of_Get_Report_Dw()
	End If
NEXT

li_Index = UpperBound(lpo_pendingupdates)

li_pending_rc = This.Event ue_updatespending(lpo_pendingupdates) 

If li_pending_rc < 0 Then 
	Return -2
End If

//	Check if changes are pending in report options
IF This.of_is_pdr_mode() THEN
	lb_rpt_updates = iu_active_query.tabpage_report.uo_report_options.of_updatespending()
END IF

If li_pending_rc = 0 AND NOT lb_rpt_updates Then 
	Return 0
End If

// Check for Errors on controls. 
If This.Event ue_validation(ipo_pendingupdates) <	0 Then 
	Return -3
End If

// There are updates pending and no Errors were found.
Return 1
end function

public function integer wf_set_print (boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_engine				wf_set_print
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Enables/disables the print menu items and the assigned d/w to print.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument		Datatype	Description
//	---------	--------		--------	-----------
//	Value			ab_switch	Boolean	TRUE = Enable the print menu item
//												FALSE= Disable the print menu item
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success	
//						-1			Error
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	FDG				02/12/98		Created.
//	GaryR				12/27/04		Track 3971d	Check if data is retrieving
//	GaryR				01/13/05		Track 4245d	Check lock status do not call message event
//	
/////////////////////////////////////////////////////////////////////////////

// Verify input
IF	IsNull (ab_switch)		THEN
	Return -1
END IF

IF gnv_app.of_get_lock() THEN Return 1

ib_enable_print	=	ab_switch

IF	IsValid (m_stars_30)		THEN
	m_stars_30.m_file.m_print.enabled			=	ab_switch
	m_stars_30.m_file.m_printpreview.enabled	=	ab_switch
	m_stars_30.m_file.m_fax.enabled				=	ab_switch
	m_stars_30.m_file.m_export.enabled			=	ab_switch
END IF

Return 1
end function

public function sx_subset_ids wf_get_sxsubset ();RETURN isx_subset
end function

public function u_Dw wf_getdwpdqtables ();RETURN dw_pdq_tables
end function

public function integer wf_get_max_uo_query ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// wf_get_max_uo_query						w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This f() will get the maximum # of uo-query instances created.  Doing
//	an upperbound on iu_query is not enough because removing occurences
//	of iu_query does not reduce the upperbound.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Description
//		--------		-----------
//		Integer		The number of valid instances of iu_query[]
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	FDG		03/16/98		Track 918.  Created.
//
/////////////////////////////////////////////////////////////////////////////

Integer	li_upper,		&
			li_idx,			&
			li_count
			
li_upper	=	UpperBound (iu_query)

FOR	li_idx	=	1	TO	li_upper
	IF	IsValid (iu_query[li_idx])		THEN
		li_count	=	li_idx
	END IF
NEXT

Return	li_count

end function

public function integer wf_setfilter (ref u_dw adw_requestor, integer ai_level, string as_filterstring);Integer i_Return

//clear any previous filter
adw_Requestor.setfilter('')
i_Return = adw_Requestor.filter()

// make sure as_FilterString filter should be set
If ai_Level <> 0 Then
	adw_Requestor.setfilter(as_FilterString)
	i_Return = adw_Requestor.filter()
End If

RETURN i_Return
end function

public subroutine wf_setrowdelete (boolean ab_switch);//*********************************************************************
//	Script:	wf_SetRowDelete
//
//	Arguments:	ab_switch
//
//	Description:
// 	Set ib_delete_criteria which indicates if a row has been deleted
// 	in dw_criteria.
//
//*********************************************************************
//	History
//
//	FDG		04/02/98	Track 1010.  Created.
//
//*********************************************************************

ib_delete_criteria	=	ab_switch

end subroutine

public function boolean wf_getrowdelete ();//*********************************************************************
//	Script:	wf_GetRowDelete
//
//	Returns:		Boolean - ib_delete_criteria
//
//	Description:
// 	Return ib_delete_criteria which indicates if a row has been deleted
// 	in dw_criteria.
//
//*********************************************************************
//	History
//
//	FDG		04/02/98	Track 1010.  Created.
//
//*********************************************************************

Return	ib_delete_criteria

end function

public function integer wf_enable_select (boolean ab_switch);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_engine				wf_enable_select
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Enables/disables the select button when dw_list is retrieved
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument		Datatype	Description
//	---------	--------		--------	-----------
//	Value			ab_switch	Boolean	TRUE = Enable the select button
//												FALSE= Disable the select button
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success	
//						-1			Error
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	FDG		04/21/98		Track 1096.	Created.
//
//	FDG		04/22/98		Track 1104.  Enable/disable the delete menu item
//								on the list tab because it depends on at least one
//								row being displayed.
//
//	FDG		05/12/98		Track 1223.  Button moved to tabpage.
//	
/////////////////////////////////////////////////////////////////////////////

// Verify input
IF	IsNull (ab_switch)		THEN
	Return -1
END IF

//This.cb_select.enabled				=	ab_switch
iu_active_query.tabpage_list.cb_select_list.enabled	=	ab_switch
im_list.m_menu.m_delete.enabled	=	ab_switch

Return 1

end function

public function string wf_get_query_id ();/////////////////////////////////////////////////////////////////////////////
// Script:		w_query_engine.wf_get_query_id
//	
//	Arguments:	None
//
//	Returns:		String - Query id retrieved.
//
//	Description:	
//		This function will return the query id of the selected query.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	05/04/98	Track 1185.  Created.
//						
/////////////////////////////////////////////////////////////////////////////

String	ls_query_id
Long		ll_rowcount,		&
			ll_row
			
ll_rowcount	=	dw_pdq_cntl.RowCount()

IF	ll_rowcount	<	1		THEN
	Return ''
END IF

ls_query_id	=	dw_pdq_cntl.object.query_id [ll_rowcount]

Return	ls_query_id

end function

public function menu wf_get_m_view ();//**************************************************************************
// FNC 06/03/98	Track 1255 Need to register view menu to U_Nvo_View so that
//						check for money/unit totals can be turned off.
//**************************************************************************

return im_view
end function

public function sx_filter_info_container wf_get_isx_filter_info ();sx_filter_info_container		lsx_filter_container

lsx_filter_container.lsx_filter_info	=	isx_filter_info

Return	lsx_filter_container

end function

public subroutine wf_clear_filter_info (string as_parm);///////////////////////////////////////////////////////////////////////
//	Script:		wf_clear_filter_info
//
//	Arguments:	as_parm - 'ALL' = Clear all levels
//
//	Returns:		None
//
//	Description:
//		Clear the filter info for the current level.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	02/04/99	Track 2084c.  Pass a parm.  If this parm is 'ALL',
//						then clear the filter info for all levels.  Otherwise,
//						clear the filter info for the current level.  Also,
//						if this function is called from creating a new level
//						do not clear the filter data.
//
///////////////////////////////////////////////////////////////////////

sx_filter_info			lstr_filter_info[],		&
							lstr_clear_filter
				
sx_all_filter_info	lstr_all_filter_info

Integer		li_level,			&
				li_filter_level,	&
				li_idx,				&
				li_upper

// If this function is being called when a new level is being created, get out
IF	ib_new_level		THEN
	Return
END IF

IF	Upper (as_parm)	=	'ALL'		THEN
	//	Clear the filter info for all levels
	isx_filter_info[] = lstr_filter_info
	li_upper	=	wf_get_max_uo_query()
	FOR li_level	=	1	TO	li_upper
		IF	IsValid (iu_query[li_level])		THEN
			// Clear the filter info stored in uo_query
			iu_query[li_level].Event ue_subsetting_set_filter_create (lstr_all_filter_info)
			iu_query[li_level].Event ue_subsetting_clear_filter_copy ()
		END IF
	NEXT
	Return
END IF

// Clear the filter info for the current level only

li_level	=	tab_level.SelectedTab

IF	li_level	>	0		THEN
	li_upper	=	UpperBound (isx_filter_info)
	FOR li_idx	=	1	TO	li_upper
		li_filter_level		=	isx_filter_info[li_idx].level_num
		IF	li_filter_level	=	li_level		THEN
			// Found the level # stored.  Clear this level.
			isx_filter_info [li_idx]	=	lstr_clear_filter
		END IF
	NEXT
	// Clear the filter info stored in uo_query
	iu_query[li_level].Event ue_subsetting_set_filter_create (lstr_all_filter_info)
	iu_query[li_level].Event ue_subsetting_clear_filter_copy ()	
END IF


end subroutine

public function integer wf_set_ii_run_frequency (integer ai_run_frequency);//*********************************************************************************
// Script Name:	w_query_engine.wf_set_ii_run_frequency
//
//	Arguments:		ai_run_frequency
//						
// Returns:			integer
//
//	Description:	This function is called from uo_query.ddlb_pd_opt.selectionchanged.
//						ii_run_frequency is set if on first level and user has selected
//						a recurring pdq option.
//		
//
//*********************************************************************************
//	
// 12/13/99 NLG	Created
//
//*********************************************************************************



ii_run_frequency = ai_run_frequency

return 1
end function

public function integer wf_get_ii_run_frequency ();//*********************************************************************************
// Script Name:	w_query_engine.wf_get_ii_run_frequency
//
//	Arguments:		NONE
//						
// Returns:			Integer
//
//	Description:	This function is called from uo_query.of_set_instance_variables
//						when tab is View or Search. It returns the ii_run_frequency.
//		
//*********************************************************************************
//	
// 12/13/99 NLG	Created
//
//*********************************************************************************

return ii_run_frequency
end function

public function boolean wf_get_disable_update ();/////////////////////////////////////////////////////////////////////////////
// Script:		w_query_engine.wf_get_disable_update
//	
//	Arguments:	None
//
//	Returns:		Boolean
//
//	Description:	
//		This function will return whether or not to disable the datawindows
//		on each tab.
//
//	Note: ib_disable_update is set in ue_set_menus_subset_view.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// FDG	09/21/01	Stars 4.8.1.  Created.
//						
/////////////////////////////////////////////////////////////////////////////

Return	ib_disable_update

end function

public function integer wf_resettitle ();////////////////////////////////////////////////////////////////////
//
//	05/07/03	GaryR	Track 3563d	Reset the title for new queries
//
////////////////////////////////////////////////////////////////////

IF This.of_is_pdr_mode() THEN
	This.Title = "PDR Queries"
ELSE
	This.Title = "PDQ Queries"
END IF

RETURN 1
end function

public function integer wf_clearlevels ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_query_engine				wf_ClearLevels			Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Removes all but the initial instance of uo_query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/27/98		Created.
//	FDG			03/16/98		Track 918.  Get the upperbound of iu_query thru
//									function wf_get_max_uo_query().
//	FDG			03/26/98		Track 982.  Get the upperbound from ue_get_upperbound
//									and SetNull the control array when removing it.
//	FDG			02/05/99		Track 2084c.  Clear the filter information for all levels.
//	GaryR			11/28/08		SPR 5591	Do not set array item to null it crashes in PB11
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_idx, li_QueryRange, li_ControlRange

li_QueryRange	= wf_get_max_uo_query()
li_ControlRange = This.Event	ue_get_upperbound (This.Control)

//DESTROY previous levels > 1.							// 1/26/98 JTM - Added
FOR li_idx = li_QueryRange TO 2 STEP -1
	IF IsValid(iu_query[li_idx]) Then 
		//destroy the user object
		CloseUserObject(iu_Query[li_idx])
		//remove user object from control array
		SetNull (This.Control[li_ControlRange])		// FDG 03/26/98
		li_ControlRange --
	END IF
NEXT																// end 1/26/98 JTM

this.wf_DisableLevels()

This.wf_clear_filter_info('ALL')							// FDG 02/05/99

RETURN 1

end function

public function boolean of_is_pdr_mode ();//////////////////////////////////////////////////////////////////////
//
//	02/06/02	GaryR	Track 2552d Predefined Report (PDR)
//
/////////////////////////////////////////////////////////////////////

IF istr_parms.query_engine_mode = "PDR" &
OR istr_parms.query_engine_mode = "PDCR" THEN Return TRUE
Return FALSE
end function

public function integer wf_loadquery (integer ai_level);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_engine				wf_LoadQuery
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Call the load events on source, search, and report tabpages.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			ai_level	Integer	The query level.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success	
//						-1			Level is over ic_max_levels.
//						-2			Source load failed.
//						-3			Search load failed.
//						-4			Report load failed.
//						-5			PDR load failed.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/13/98	Created.
//	J.Mattis	01/22/98	Added selecttab to correct multi-level load error.
//	FDG		03/02/98	Track 876 - Select the uo_query tab via an event.
//	FDG		03/23/98	Track 954.  Reset this tab in case a PDQ was 
//							previously displayed.
//	GaryR		04/29/02	Track 2552d Predefined Report (PDR)
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

IF ai_level > ic_max_levels THEN RETURN -1

this.tab_level.SelectTab(ai_level)
this.wf_SetLevelText(ai_level)

// NOTE: iu_active_query is set in the ue_register_level event which happens
// due to the tab_level.SelectTab()

iu_active_query.Event	ue_reset_query()		// FDG 03/23/98

//	GaryR	04/29/02	Track 2552d - Begin
IF This.of_is_pdr_mode() THEN
	IF iu_active_query.Event ue_tabpage_pdr_load(ai_Level) < 0 THEN 
		RETURN -5
	END IF
ELSE
	IF iu_active_query.Event ue_tabpage_source_load(ai_Level) < 0 THEN 
		RETURN -2
	END IF
END IF
//	GaryR	04/29/02	Track 2552d - End

IF iu_active_query.Event ue_tabpage_search_load(ai_Level) < 0 THEN 
	RETURN -3
END IF

IF iu_active_query.Event ue_tabpage_report_load(ai_Level) < 0 THEN 
	RETURN -4
END IF

iu_active_query.visible = FALSE
iu_active_query.enabled = FALSE

//select the data source tabpage
IF ai_level > 1 Then 
	iu_active_query.Event	ue_SelectTab(ic_report)
END IF
	
RETURN 1
end function

public function integer wf_setlevelfilter (integer ai_level, string as_source);/////////////////////////////////////////////////////
//
//	GaryR	04/29/02	Track 2552d Predefined Report (PDR)
//
/////////////////////////////////////////////////////

String s_FilterText
Integer i_Return

//make sure level is valid
If ai_Level > 0 AND ai_Level < IC_MAX_LEVELS Then
	s_FilterText = "level_num = " + String(ai_Level)
End If

CHOOSE CASE Upper(as_source)
		
	CASE 'REPORT'	//set the PDQ_COLUMNS dw filter
		i_Return = this.wf_SetFilter(dw_pdq_columns,ai_Level,s_FilterText)
	
	CASE 'SOURCE', "PDR"	//set the PDQ_TABLES dw filter		//	GaryR	04/29/02	Track 2552d
		i_Return = this.wf_SetFilter(dw_pdq_tables,ai_Level,s_FilterText)
		
	CASE 'SEARCH'	//set the PDQ_CRITERIA dw filter
		i_Return = this.wf_SetFilter(dw_pdq_criteria,ai_Level,s_FilterText)
	
	CASE ELSE		//set the all the above PDQ dw filters
		i_Return = this.wf_SetFilter(dw_pdq_columns,ai_Level,s_FilterText)
		i_Return = this.wf_SetFilter(dw_pdq_tables,ai_Level,s_FilterText)
		i_Return = this.wf_SetFilter(dw_pdq_criteria,ai_Level,s_FilterText)
END CHOOSE

RETURN i_Return
end function

public function integer of_get_pdr_parm (ref sx_pdr_parms astr_pdr_parms);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// of_get_pdr_parm							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Populate PDR parameter structure
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		reference	astr_pdr_parms		sx_pdr_parms		PDR parameter structure
/////////////////////////////////////////////////////////////////////////////
//	RETURNS - Integer 1 - Success  -1 - Failure
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
// -------- ----- ----------- -----------------------------------------------
//	01/29/02	LahuS	Track 2552d	Created. 
//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs
// 12/02/04	MikeF	Track 4106d Add fields to structure
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
/////////////////////////////////////////////////////////////////////////////

Integer				li_row
DatawindowChild	ldwc_pdr_report

iu_active_query.tabpage_pdr.dw_pdr.GetChild( "pdr_report", ldwc_pdr_report )
IF NOT IsValid( ldwc_pdr_report ) THEN Return -1

li_row = ldwc_pdr_report.GetSelectedRow(0)
IF li_row = 0 THEN Return -1

astr_pdr_parms.pdr_name			= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_name" ) )
astr_pdr_parms.pdr_label 		= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_label" ) )
astr_pdr_parms.pdr_cat			= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_cat" ) )
astr_pdr_parms.pdr_type			= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_type" ) )
astr_pdr_parms.pdr_desc 		= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_desc" ) )
astr_pdr_parms.pdr_criteria	= ldwc_pdr_report.GetItemNumber( li_row, "pdr_criteria" )
astr_pdr_parms.pdr_drilldown	= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_drilldown" ) )
astr_pdr_parms.pdr_window_ops	= Trim( ldwc_pdr_report.GetItemString( li_row, "pdr_window_ops" ) )
astr_pdr_parms.case_security	= Trim( ldwc_pdr_report.GetItemString( li_row, "case_security" ) )
astr_pdr_parms.pdr_security 	= ldwc_pdr_report.GetItemNumber	( li_row, "pdr_security" )
astr_pdr_parms.pdr_source 		= ldwc_pdr_report.GetItemNumber	( li_row, "pdr_source" )
astr_pdr_parms.enable_calendar = ldwc_pdr_report.GetItemString	( li_row, "calendar_ind" ) = "Y"
astr_pdr_parms.format_flags	= ldwc_pdr_report.GetItemNumber	( li_row, "format_flags" )
astr_pdr_parms.rpt_name			= Trim( ldwc_pdr_report.GetItemString( li_row, "rpt_name" ) )

Return 1
end function

public subroutine wf_resetleveltext (integer ai_level);//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection

SetPointer(HourGlass!)

This.SetRedraw (FALSE)

Integer	li_upper,		&
			li_level

String	ls_LevelText

li_upper	=	wf_get_max_uo_query()

FOR	li_level	=	1	TO	IC_MAX_LEVELS
	// check if active query has been assigned to array
	IF	li_level	=	ai_level		THEN
		// Current level - use full text for the current level
		ls_leveltext	=	IS_LEVELTEXT
	ELSE
		// Not the current level - use abbreviated text for the other levels
		ls_leveltext	=	IS_LVLTEXT
	END IF
	ls_leveltext	=	ls_leveltext	+	String(li_level)
	
	
	IF li_level	<=	li_upper						THEN
		// setting text from change of invoice type
		iu_Query[li_Level].Tag = ls_LevelText	
	ELSE
		// setting text from default invoice type being set in tabpage_source_construct event
		iu_active_query.Tag = ls_LevelText	
	END IF
	
	CHOOSE CASE li_Level
		
		CASE 1
			tab_level.tabpage_1.text = ls_LevelText
		CASE 2
			tab_level.tabpage_2.text = ls_LevelText
		CASE 3
			tab_level.tabpage_3.text = ls_LevelText
		CASE 4
			tab_level.tabpage_4.text = ls_LevelText
		CASE 5
			tab_level.tabpage_5.text = ls_LevelText
		CASE 6
			tab_level.tabpage_6.text = ls_LevelText
		CASE 7
			tab_level.tabpage_7.text = ls_LevelText
		CASE 8
			tab_level.tabpage_8.text = ls_LevelText
		CASE 9
			tab_level.tabpage_9.text = ls_LevelText
		CASE 10
			tab_level.tabpage_10.text = ls_LevelText
	END CHOOSE
NEXT

This.SetRedraw (TRUE)
end subroutine

public function uo_query wf_getpreviousquery ();////////////////////////////////////////////////////////////////////////
//
//		09/14/06	Track 4687	Provide access to parent insance in drilldown
//
////////////////////////////////////////////////////////////////////////

Return iu_previous_query
end function

on w_query_engine.create
int iCurrent
call super::create
this.dw_pdr_sources=create dw_pdr_sources
this.dw_pdq_cntl=create dw_pdq_cntl
this.dw_pdq_case_link=create dw_pdq_case_link
this.dw_pdq_criteria=create dw_pdq_criteria
this.dw_pdq_columns=create dw_pdq_columns
this.tab_level=create tab_level
this.dw_pdq_tables=create dw_pdq_tables
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pdr_sources
this.Control[iCurrent+2]=this.dw_pdq_cntl
this.Control[iCurrent+3]=this.dw_pdq_case_link
this.Control[iCurrent+4]=this.dw_pdq_criteria
this.Control[iCurrent+5]=this.dw_pdq_columns
this.Control[iCurrent+6]=this.tab_level
this.Control[iCurrent+7]=this.dw_pdq_tables
end on

on w_query_engine.destroy
call super::destroy
destroy(this.dw_pdr_sources)
destroy(this.dw_pdq_cntl)
destroy(this.dw_pdq_case_link)
destroy(this.dw_pdq_criteria)
destroy(this.dw_pdq_columns)
destroy(this.tab_level)
destroy(this.dw_pdq_tables)
end on

event ue_preopen;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_PreOpen									w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Obtain message parms. (if any), create popup menus, and open initial 
//	query level.
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
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/08/97	Created.
//	FDG		02/24/98	Open uo_query via a script instead of
//							openuserobjectwithparm & ue_tabpage_source_construct
//	FDG		03/04/98	Track 888.  Change the closequery message
//	FDG		05/08/98	Track 1195.  Don't turn off the resize service.  
//							The user may have turned it on or off.
//	FDG		05/12/98	Track 1223.  Buttons moved to the tabpages.  
// ajs      07/30/98 Track #1522. Pass period id & period function.
//	FDG		11/20/98	Track 1981.  If 'Use', disable the cbuttons and menu
//							items that can update data.
// FNC		10/27/99 Stars 4.5 Fraud PDQ's create and retrieve stars_rel datastore
// LahuS					Track 2552d store istr_parms 
//	GaryR		04/17/02	Track 2552d	Predefined Reports (PDR)
//	GaryR		11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR		07/05/05	Track 4451d	Add a seperate close message for Report Center
/////////////////////////////////////////////////////////////////////////////

sx_drilldown_parms	lstr_drilldown_parms

integer ll_rowcount

SetPointer(HourGlass!)

Constant String LS_INITIAL_LEVEL = 'INITIAL_LEVEL'
Constant String LS_OPEN = 'OPEN'

// Opening the window - Reset at end of ue_postopen
ib_opening_window	=	TRUE

//load messageparm into variable
sx_query_engine_parms  lstr_parms 

lstr_parms = message.powerobjectparm
//Lahu S Store istr_parms
istr_parms = message.powerobjectparm

IF This.of_is_pdr_mode() THEN
	is_closequery_msg	=	'A change has been made to one of '	+	&
								'the Report Center tabs.~r~n~r~n'	+	&
								'Do you want to save these changes?'
ELSE
	is_closequery_msg	=	'A change has been made to one of '	+	&
								'the Query Engine tabs.~r~n~r~n'	+	&
								'Do you want to save these changes?'
END IF

//create 6 menus

im_list = create m_list
im_pdr = create m_pdr						//	04/17/02	GaryR	Track 2552d
im_source = create m_source
im_search = create m_search
im_report = create m_report
im_view = create m_view

//make first tabpage of tab_level visible and create first uo_query
tab_level.tabpage_1.visible = TRUE
tab_level.tabpage_1.enabled = TRUE
this.wf_SetUoPos()
This.Event	ue_open_uo_query (iu_active_query, lstr_drilldown_parms, LS_OPEN)	// FDG 02/24/98	// FDG 04/14/98
//this.openuserobjectwithparm(iu_active_query,lsx_drilldown_parms,iix_pos,iiy_pos)
iu_query[1] = iu_active_query 
//iu_active_query.Event ue_tabpage_source_construct(LS_INITIAL_LEVEL,'')

If IsValid(lstr_parms) Then
	//take data from lstr_parm and load into instance variables and datawindows
	this.event ue_unload_parms(lstr_parms)
End If

//set text on cb_select if query_id passed in equals 'USE'
if Upper(Trim(is_query_id)) = 'USE' then
	//this.cb_select.text = '&Use'
	iu_active_query.tabpage_list.cb_select_list.text	=	'&Use'	// FDG 05/12/98
	// FDG 11/20/98 begin
	iu_active_query.tabpage_list.cb_new.enabled	=	FALSE
	im_list.m_menu.m_new.enabled						=	FALSE
	im_list.m_menu.m_delete.enabled					=	FALSE
	im_list.m_menu.m_select_pdq.text					=	'&Use'
	// FDG 11/20/98 end
end if

//register the variables
this.iu_active_query.event ue_register_vars(is_query_id,is_parm_subset_id,ii_period_key,is_period_function)	//ajs 4.0 07/30/98 Track #1522

//set transaction object to stars2ca
this.of_settransaction(stars2ca)

this.wf_ResizeUo(1)

//clear out query id in case may have been set prior: see ts155 - w_query_engine parms
gnv_app.of_set_query_id('')


end event

event close;call super::close;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	close											w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// 
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
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		12/08/97		Created.
//
//	FDG			1/27/98		Changed variable i to li_idx.
//
//	FDG			2/24/98		Close iu_active_query & iu_previous_query to
//									prevent memory leaks.
//
//	FDG			03/16/98		Track 918.  Get the upperbound of iu_query thru
//									function wf_get_max_uo_query().
//
//	FDG			09/21/01		Stars 4.8.1.  Destroy inv_case.
//	GaryR			04/17/02		Track 2552d	Predefined Reports (PDR)
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_idx, li_Levels

//destroy 6 menus
if isvalid(im_list) then Destroy im_list 
if isvalid(im_pdr) then Destroy im_pdr		//	04/17/02	GaryR	Track 2552d
if isvalid(im_source) then Destroy im_source 
if isvalid(im_search) then Destroy im_search
if isvalid(im_report) then Destroy im_report 
if isvalid(im_view) then Destroy im_view 

If IsValid(iu_previous_query) Then
	/* clean up any temp tables created by drilldown */
	iu_previous_query.event ue_drilldown_drop_temp_table()
	CloseUserObject (iu_previous_query)
End If

If IsValid(iu_active_query) Then
	CloseUserObject (iu_active_query)
End If

li_Levels = wf_get_max_uo_query()			// FDG 03/16/98

for li_idx = 1 to IC_MAX_LEVELS
	if li_idx > li_Levels then exit
	if isvalid(iu_query[li_idx]) then
			closeuserobject(iu_query[li_idx])
	end if
next

uo_query		lu_query[]

iu_query	=	lu_query

// FDG 09/21/01
//IF IsValid (inv_case)	THEN	Destroy	inv_case

end event

event ue_postopen;call super::ue_postopen;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_PostOpen									w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//1. If the messageparm contained tables and criteria,
//	will only be viewing one level.  
// Must make the first tab_level tabpage visible for 
//	the level and open a query engine
// user object for the level.  Then load the tabpages 
//	on the query engine user object 
// and select the report tabpage.
//2. else if a subset id and subset name are passed in, 
//	must adjust the right mouse menus, 
// load only the source tabpage with the subset's data 
//	source(s), select the datasource 
// (ML for ML subset), select the Report On tab  
//	and change the title of the window 
// (tabpage_list & tabpage_search are disabled)
//3. else if a query id is passed (not "USE" if 
//	entering from w_case_folder - add link),
// load the list datawindow in the list tabpage 
//	of u_query_1 with that query id, select
// it so that it loads the other tabs (and levels if ML)
//	and then select the search tabpage
//4. else if and authorization id is passed in, must 
//	load data source with Authorization
// table and search tab with the patient or provider value
//5. else load the list datawindow with the default 
//	and select the list tabpage 
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
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/08/97		Created.
//
//	FDG		02/02/98		When an authorization is passed in, enable
//								tabpage_search & tabpage_report
//	J.Mattis	02/12/98		For subset view:
//								1) enable source & report tabpages.
//								2) disable closequery processing.
//	FDG		03/02/98		Track 876.  Select the tab via an event.
//	FDG		03/13/98		Track 935.  Reset the Microhelp to 'Ready'
//	FDG		05/12/98		Track 1223.  Object moved to the tabpages.
//	FDG		05/13/98		Track 1230.  When coming in from outside sources,
//								disable the query tab.
// FNC		06/02/98		Track 1210. Break with totals option set to disabled
//								so don't need to call ue_set_menus_subset_view to 
//								disable it.
//	FDG		06/03/98		Track 1299.  When loading a query, go to the search
//								by tab instead of the report on tab.
//	NLG		08/26/98		ts144 Report on enhancements.  Changes to which tab
//								is selected based on navigation path.
//	FDG		10/23/98		Track 1934.  When 'PA' (is_auth_id = 'PA'), tell
//								uo_query that this is an ancillary invoice type.
//	FDG		10/30/98		Reset ii_period_key (passed from another window)
//								because it is no longer needed.
//	FDG		12/04/98		Track 2004.  Pass a true/false argument to
//								ue_enable_next_button.
// AJS      01/13/99    FS2036c Do not allow create subset on subset view.
// FNC		05/31/00		Track 2227 Stardev. Default to the search by tab
//								when a PDQ is viewed from case folder.
//	FDG		09/21/01		Stars 4.8.1. Pass argument to ue_set_menus_subset_view
//								to disable update functionality.
//	Lahu S 	12/21/01 	Set title for the query engine window
//	GaryR		07/08/02		Track 3185d	Set proper window title.
//	GaryR		03/12/03		Track 3477d	Disable list tab on first level
//	GaryR		08/06/04		Track 4049d	Provide drilldown from Subset Summary
//	MikeF		09/29/05	SPR4471d/4528d Issues when coming from w_subset_list							
/////////////////////////////////////////////////////////////////////////////

Boolean	lb_switch

SetPointer(HourGlass!)

ib_disableclosequery = TRUE	// turn off closequery processing


if dw_pdq_tables.rowcount() > 0 then  /*if something passed in */
	/* load uo_query and set to search tab */
	iu_active_query.event ue_tabpage_list_construct('')
	this.event ue_load_query(1)
	//iu_active_query.Event ue_SelectTab(ic_search)			// FDG 06/03/98	
	iu_active_query.Event ue_SelectTab(ic_view)				//NLG 08/26/98 ts144 Report on enhancements
	iu_active_query.tabpage_list.enabled = FALSE				// FDG 05/13/98
	ib_disableclosequery = FALSE	// turn on closequery processing
elseif Trim(is_parm_subset_id) <> '' and Not IsNull(is_parm_subset_id) then	// subset view
	/* adjust menus, load source tabpage of uo_query & set Report On tab */
	iu_active_query.event ue_tabpage_source_construct(is_parm_subset_id,'')
	this.event ue_set_subset_title()
	// FDG 09/21/01 - Pass false to ue_set_menus_subset_view
	//this.event ue_set_menus_subset_view() 						// AJS 01-13-99
	this.event ue_set_menus_subset_view (FALSE)
	iu_active_query.tabpage_list.enabled = FALSE
	iu_active_query.tabpage_source.enabled = TRUE
	iu_active_query.tabpage_report.enabled = TRUE
	//iu_active_query.Event ue_SelectTab(ic_report)
	iu_active_query.Event ue_SelectTab(ic_view)				//NLG 08/26/98 ts144 Report on enhancements
	This.Event	ue_enable_next_button(TRUE)					// FDG 12/04/98
	ib_disableclosequery = TRUE	// turn off closequery processing
elseif ib_pdq_subset THEN		// subset details with criteria enabled
	/* adjust menus, load source tabpage of uo_query & set Report On tab */
	iu_active_query.event ue_tabpage_source_construct('*SUBSET_DETAILS*','')
	IF dw_pdq_criteria.RowCount() > 0 THEN	iu_active_query.Event ue_tabpage_search_load(1)
	iu_active_query.tabpage_list.enabled = FALSE
	iu_active_query.tabpage_source.enabled = TRUE
	iu_active_query.tabpage_report.enabled = TRUE
	iu_active_query.Event ue_SelectTab(ic_search)
	This.Event	ue_enable_next_button(TRUE)
	ib_disableclosequery = TRUE	// turn off closequery processing

elseif Upper(Trim(is_query_id)) <> 'USE' and Trim(is_query_id) <> '' &
		and Not IsNull(is_query_id) then  
	/* if no criteria and query_id, then load PDQ list and will populate the 
	rest of the tabs & levels set to search tabpage */
	iu_active_query.event ue_tabpage_list_construct(is_query_id)
	this.event ue_set_pdq_title()
	//this.cb_select.triggerevent(Clicked!) // this will load PDQ dw's 
	This.Event	ue_select_pdq()					// FDG 05/12/98 (cb_select triggers this)
	iu_query[1].tabpage_list.enabled = FALSE
	iu_active_query.Event ue_SelectTab(ic_search)			// FNC 05/31/00
	ib_disableclosequery = FALSE	// turn on closequery processing
elseif Trim(is_auth_id) <> '' and Not IsNull(is_auth_id) then
	/* must load authorization info */
	String	ls_inv_type[1]
	ls_inv_type[1]	=	Mid(is_auth_id,2,2)
	iu_active_query.is_inv_type	=	ls_inv_type[1]
	iu_active_query.event ue_set_ancillary_inv_type (ls_inv_type[1])		// FDG 10/23/98
	iu_active_query.event ue_tabpage_source_construct('',is_auth_id)
	iu_active_query.event ue_tabpage_search_set_authorization(is_auth_id)
	iu_active_query.event ue_tabpage_report_set_columns(ls_inv_type,'M')
	iu_active_query.tabpage_list.enabled = FALSE
	iu_active_query.tabpage_source.enabled = FALSE
	iu_active_query.tabpage_search.enabled = TRUE
	iu_active_query.tabpage_report.enabled = TRUE
	iu_active_query.Event ue_SelectTab(ic_view)		//NLG 08/26/98 ts144 Report on enhancements
	ib_disableclosequery = FALSE	// turn on closequery processing
else	
	/* else if no query_id or USE set the defaults, set to list tab */
	iu_active_query.tabpage_search.enabled = FALSE
	iu_active_query.tabpage_report.enabled = FALSE
	iu_active_query.tabpage_view.enabled = FALSE
	iu_active_query.event ue_tabpage_list_construct(is_query_id)
	iu_active_query.Event ue_SelectTab(ic_list)	
	ib_disableclosequery = FALSE	// turn on closequery processing
end if

this.wf_ResizeUo(1)

lb_switch	=	This.Event	ue_set_window_colors (This.Control)	// FDG 04/09/98

// No longer opening the window
ib_opening_window	=	FALSE
ii_period_key		=	0								// FDG 10/30/98
iu_active_query.ii_period_key	=	0				// FDG 10/30/98

w_main.SetMicroHelp ('Ready')						//	FDG 03/13/98
end event

event rbuttondown;call super::rbuttondown;// display menu depending on which uo_query tabpage is selected
//this.event ue_open_menu()

end event

event ue_save;// OVERRIDE! - due to query engine save process design. QE saves the hidden PDQ
//					datawindows; not the datawindows into which users key data.
/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_engine				ue_Save
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Trigger the save query logic. Then trigger overridden ue_Save.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
// None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	02/02/98	Created.
//	J.Mattis	02/03/98	Added 'X' suffix to s_Path parameter of ue_save_query() to 
//							prevent recursive call to this method. 
//	FDG		03/16/98	Track 918.  Get the upperbound of iu_query thru
//							function wf_get_max_uo_query().
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer i_Return, li_Index, li_Range
String s_Path = 'AX'		//prevent recursive call to this method -> 'X' suffix

//prevent recursive call to this method -> 'X' suffix
if Not(iu_active_query.event ue_get_new_flag()) then s_Path = 'SX'

//save user entered (via save window & uo_Query's tabpages) data
i_Return = this. Event ue_save_query(s_Path)

If i_Return > 0 Then
	
	li_Range = wf_get_max_uo_query()				// FDG 03/16/98
	
	// make sure updates are prevented on updateable dws on uo_query 
	FOR li_Index = 1 TO li_Range
		If IsValid(iu_query[li_Index]) Then
			// set flag which will prevent non updateable dws on uo_query from
			// being updated during ue_save process
			iu_query[li_Index].of_SetFromCloseQuery(FALSE)
		End If
	NEXT
	
	// save PDQ data
	i_Return = SUPER::Event ue_Save()
End If

RETURN i_Return
end event

event closequery;// OVERRIDE!
//*********************************************************************
//	Script:	w_master.closequery
//
//	Description:
// Set flag which will permit non updateable dws on uo_query to
// be 'flagged' as needing updates during closequery process. 
//	Then call overridden script.
//
//*********************************************************************
//	History
//
//	J.Mattis	1/2/98	Created
//
//	FDG		03/10/98	Track 910.  Must copy closequery code into this
//							event because if changes were made, then event
//							ue_save_query must be triggered instead of ue_save.
//	FDG		03/16/98	Track 918.  Get the upperbound of iu_query thru
//							function wf_get_max_uo_query().
//	FDG		04/02/98	Track 1003.  Deletion of rows in dw_criteria don't
//							get detected because they're marked as non-updateable.
//							To get around this, ib_delete_criteria is checked
//							instead.
//	GaryR		07/13/04	Track 3971d	Lock all functionality during retrieval
//
//*********************************************************************

Integer		li_Index, 	&
				li_Range
String		ls_path
Boolean		lb_new_query

IF This.of_is_locked() THEN Return 1

li_Range = wf_get_max_uo_query()			// FDG 03/16/98		
				
FOR li_Index = 1 TO li_Range
	If IsValid(iu_query[li_Index]) Then
		// set flag which will prevent non updateable dws on uo_query from
		// being updates during ue_save process
		iu_query[li_Index].of_SetFromCloseQuery(TRUE)
	End If
NEXT

//RETURN SUPER::Event closequery()
//*********************************************************************
//	w_master.closequery logic.  The only difference is ue_save_query
//	is triggered instead of ue_save.
//
//*********************************************************************

Integer		li_pendingrc,		&
				li_validationrc,	&
				li_accepttextrc,	&
				li_msg,				&
				li_rc
				
String		ls_msgparms[]

ib_changes_not_saved	=	FALSE

//	If the closequery process flag is disabled, get out

IF	ib_disableclosequery		THEN
	Return 0
END IF

// Apply the contents of the edit controls to all datawindows.
IF This.Event ue_accepttext (This.control, TRUE)	<	0	THEN
	Return 1
END IF

//	Perform any "pre-close" processing.  If an error occered, get out.
li_rc	=	This.Event ue_preclose ()

IF	li_rc	<>	1	THEN
	//	Returning 1 prevents the window from closing
	Return 1
END IF

//	Prevent validation error messages from appearing while the window
//	is closing and allow others to check if the closequery process
//	is in progress.
ib_closestatus	=	TRUE

//	Check for any pending updates
li_rc	=	This.of_updatechecks ()

IF	li_rc	=	0		THEN
	// FDG 04/02/98 -  See if rows were deleted in dw_criteria
	IF	wf_getrowdelete()	=	FALSE		THEN
		//	No updates are pending, allow the window to be closed
		ib_closestatus	=	FALSE
		Return 0
	END IF
END IF

IF	li_rc	<	0		THEN
	//	Updates are pending, but at least 1 data entry error was
	//	found.  Give the user the chance to save the window
	//	without saving
	li_msg	=	MessageBox ('Validation Error', is_closequery_error_msg, &
					Exclamation!, YesNo!, 2)
	IF	li_msg	=	1		THEN
		ib_closestatus	=	FALSE
		Return 1
	END IF
ELSE
	//	Updates are pending.  Prompt the user to save the changes
	//	before closing the window.
	li_msg	=	MessageBox ('Warning', is_closequery_msg,	&
					Exclamation!, YesNoCancel!)
	CHOOSE CASE	li_msg
		CASE	1
			//	Yes - Update.  If the update fails, prevent the 
			// window from closing
			IF	This.Event ue_save_query ('S')	>=	1	THEN
				// Successful update - allow the window to be closed
				ib_closestatus	=	FALSE
				Return 0
			END IF
		CASE	2
			//	No - Allow the window to be closed without saving the
			//			changes.
			//	Reset the datawindow update attributes passing the
			//	window's control array
			li_rc	=	This.Event ue_commit_rollback (FALSE)	// Rollback & free any locks
			li_rc	=	This.Event ue_postupdate (ipo_pendingupdates)
			ib_closestatus			=	FALSE
			ib_changes_not_saved	=	TRUE
			Return 0
		CASE	3
			//	Cancel - Prevent the window from closing (Return 1)
	END CHOOSE
END IF

//	Prevent the window from closing
ib_closestatus	=	FALSE
Return 1
end event

event activate;call super::activate;//*********************************************************************
//	Script:		Activate
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	This event is always triggered when the window becomes active.
//		Since menu items on m_stars_30 was enabled/disabled from other
//		scripts ( wf_set_print() ), these menu items must be reset
//		back to the same values as when the user left this window.
//
//		This value (enabled/disabled) was saved in ib_enable_print
//		in the window's deactivate event.
//
//*********************************************************************
//	History
//
//	FDG	02/12/98	Created
//
//	FDG	06/03/98	Track	1295.  Disable the m_showsql menu item
//
//*********************************************************************

This.wf_set_print (ib_enable_print)

//	FDG 06/03/98 begin
// Save the current state of the menu items
ib_showsql	=	m_stars_30.m_file.m_showsql.enabled

m_stars_30.m_file.m_showsql.enabled		=	FALSE
// FDG 06/03/98 end


end event

event deactivate;call super::deactivate;//*********************************************************************
//	Script:		Deactivate
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	This event is always triggered when the window becomes inactive.
//		Since menu items on m_stars_30 was enabled/disabled from other
//		scripts ( wf_set_print() ), these menu items must be enabled
//		for the newly activated window to use.
//
//		Save whether or not these menu items were previously saved from
//		prior scripts in ib_enable_print.  When this window becomes the
//		active window, it will remember what to set these menu items to.
//
//*********************************************************************
//	History
//
//	FDG	02/12/98	Created
//
//	FDG	06/03/98	Track	1295.  Enable the m_showsql menu item
//
//
//*********************************************************************

Boolean	lb_prior_print_status

// Save ib_enable_print because wf_set_print may change its value
lb_prior_print_status	=	ib_enable_print

//	Always enable these print menu items when leaving this window
This.wf_set_print (TRUE)

//	Save ib_enable_print to its prior status for when the window 
//	becomes active.
ib_enable_print			=	lb_prior_print_status

//	FDG 06/03/98 begin
// Restore the menu items to its current state
m_stars_30.m_file.m_showsql.enabled	=	ib_showsql
// FDG 06/03/98 end



end event

event open;call super::open;//*********************************************************************
//	Script:		Open
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	This event is display the hidden datawindows when in debug mode.
//
//*********************************************************************
//	History
//
//	FDG	02/26/98	Created
//
//	FDG	05/08/98	Track 1195.  Don't force the resize service.  The user
//						may have turned it off.
//
//	FDG	09/21/01	Stars 4.8.1.  Instantiate inv_case.
//	GaryR	07/08/02	Track 3185d	Set proper window title.
//
//*********************************************************************

// check if PDQ datawindows should be made visible
IF gc_debug_mode THEN
	dw_pdq_case_link.Visible = TRUE
	dw_pdq_cntl.Visible = TRUE
	dw_pdq_columns.Visible = TRUE
	dw_pdq_criteria.Visible = TRUE
	dw_pdq_tables.Visible = TRUE	
ELSE
	dw_pdq_case_link.Visible = FALSE
	dw_pdq_cntl.Visible = FALSE
	dw_pdq_columns.Visible = FALSE
	dw_pdq_criteria.Visible = FALSE
	dw_pdq_tables.Visible = FALSE
END IF

//	GaryR	07/08/02	Track 3185d
//	Set initial title for the query engine window
IF This.of_is_pdr_mode() THEN	This.Title = "PDR Queries"

// FDG 09/21/01 create inv_case
//inv_case	=	CREATE	n_cst_case


end event

event ue_reconnect;call super::ue_reconnect;// Track 1118 - Extend the ancestor
// ajs 4.0	07/30/98 Track #1522 Pass period id & period function.
//	GaryR		11/16/04	Track 4115d	STARS Reporting - Claims PDRs

Integer	li_rc

iu_active_query.Event	ue_register_vars(is_query_id,	is_parm_subset_id, ii_period_key, is_period_function)

Return 1
end event

event ue_open_rmm;call super::ue_open_rmm;// Open right mouse menu depending on which tabpage is selected
//	on the uo_query called by 
// RButtonDowm event on w_query_engine and uo_query.
///////////////////////////////////////////////////////////////
//	Revision History
//
//	FDG	02/09/98	Add 5 to pointerx and add 20 to pointery
//
//	FDG	11/18/98	Track 1903.  When this window is opened as
//						a response window (from case folder), the 
//						RMM appears on the list tab.
//	LahuS	12/21/01	Track 2552d Update popup menu
//	GaryR	04/17/02	Track 2552d	Predefined Reports (PDR)
// LahuS 04/22/02 Track 2552d Drilldown PDR
//	GaryR	04/24/03	Track 3538d	Disable Map and Graph options in PDR
//	GaryR	05/10/04	Track 3756d	Streamline PDR deployment & security
//	GaryR	07/13/04	Track 3971d	Lock all functionality during retrieval
// MikeF 08/17/04 Track 3851d	Disable Redirect to Access for PDR's
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
// 12/01/04 MikeF Track 4106d Add calendar navigation to QE
//	GaryR	12/13/04	Track 4148d	Enable undo drilldown menu on source tab
//	GaryR	06/11/07	Track 5064	Disable drilldown menu item when no options are available
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//	09/10/09	GaryR	QEN.650.5229.006	Add statistical and arithmetic functions to QE reports
//
///////////////////////////////////////////////////////////////

Integer li_tab
sx_pdr_parms		lsx_pdr_parms

//	FDG 11/18/98 begin
IF	ib_opening_window	=	TRUE		THEN
	Return
END IF
// FDG 11/18/98 end

IF gnv_app.of_get_lock() THEN Return

//Lahu S	12/21/01	begin
//disable menu options 

This.of_get_pdr_parm( lsx_pdr_parms )

if This.of_is_pdr_mode() then
	//disable the Import PDQ option 	
	im_list.m_menu.m_importpdq.enabled = FALSE
	
	//	GaryR	04/17/02	Track 2552d
	im_pdr.m_menu.m_undodrilldown.enabled = FALSE
	im_pdr.m_menu.m_reset.enabled = NOT iu_active_query.of_get_ib_drilldown_mode()

	//Disable Clear, Enable Reset, disable removelevel
	im_source.m_menu.m_clear.enabled = FALSE
	im_source.m_menu.m_reset.enabled = NOT This.wf_get_disable_update()			
	im_source.m_menu.m_removelevel.enabled = FALSE

	//Disable the Next Level, Save ->Criteria Subset and Export PDQ option	
	//Rename Save -> PDQ Save and PDQ SaveAs to Query Save and Query SaveAs	
	im_search.m_menu.m_nextlevel.enabled = FALSE	
	im_search.m_menu.m_save.m_createsubset.enabled = FALSE	
	im_search.m_menu.m_exportpdq.enabled = FALSE		
	im_search.m_menu.m_removelevel.enabled = FALSE
	im_search.m_menu.m_filters.enabled = FALSE
	im_search.m_menu.m_count.enabled = FALSE	
	
	//Disable Report template and Save ->Criteria Subset 
	//Rename Save -> PDQ Save and PDQ SaveAs to Query Save and Query SaveAs	
	im_report.m_menu.m_reporttemplatelibrary.enabled = FALSE
	im_report.m_menu.m_reporttemplatesave.enabled = FALSE
	im_report.m_menu.m_reporttemplatesaveas.enabled = FALSE
	im_report.m_menu.m_save.m_createsubset.enabled = FALSE	
	im_report.m_menu.m_exportpdq.enabled = FALSE		
	im_report.m_menu.m_removelevel.enabled = FALSE
	im_report.m_menu.m_redirectresultstoaccess.enabled = FALSE
	
	im_view.m_menu.m_save.m_createsubset.enabled = FALSE		
	im_view.m_menu.m_exportpdq.enabled = FALSE		
	im_view.m_menu.m_nextlevel.enabled = FALSE			
	im_view.m_menu.m_undodrilldown.enabled = FALSE				
	im_view.m_menu.m_claimoperations.enabled = FALSE
	im_view.m_menu.m_reporttools.m_map.enabled = FALSE
	im_view.m_menu.m_reporttools.m_graph.enabled = FALSE	
	im_view.m_menu.m_list.enabled = FALSE					
	im_view.m_menu.m_uniquecounts.enabled = FALSE					
	im_view.m_menu.m_statistics.enabled = FALSE						
	im_view.m_menu.m_removelevel.enabled = FALSE

	im_view.m_menu.m_reporttools.m_calendar.enabled = lsx_pdr_parms.enable_calendar

	IF Upper( lsx_pdr_parms.pdr_window_ops ) = "N" THEN
		im_view.m_menu.m_windowoperations.enabled = FALSE
	ELSE
		im_view.m_menu.m_windowoperations.enabled = TRUE	
	END IF
ELSE
	//	Disable drilldown if no options
	IF im_view.m_menu.m_drilldown.enabled &
	AND NOT im_view.m_menu.m_drilldown.m_1.visible THEN
		im_view.m_menu.m_drilldown.enabled = FALSE
	END IF
end if
//Lahu S	12/21/01	end

//Lahu S	4/22/02	Track 2552d begin
if iu_active_query.of_get_ib_drilldown_mode() then
	This.event ue_set_drilldown_menu("", "")
	if trim(lsx_pdr_parms.pdr_drilldown) = "" then
		im_view.m_menu.m_drilldown.enabled = FALSE
	else
		im_view.m_menu.m_drilldown.enabled = TRUE	
	end if
	if ii_ctr > 1 then 
		im_view.m_menu.m_undodrilldown.enabled = TRUE			
		im_pdr.m_menu.m_undodrilldown.enabled = TRUE					
		im_report.m_menu.m_undodrilldown.enabled = TRUE							
		im_search.m_menu.m_undodrilldown.enabled = TRUE
		im_source.m_menu.m_undodrilldown.enabled = TRUE	
	end if
end if
//Lahu S	4/22/02	end

li_tab = iu_active_query.selectedtab

choose case li_tab
	case IC_LIST
		If IsValid(im_list) Then im_list.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case IC_PDR				//	GaryR	04/17/02	Track 2552d
		If IsValid(im_pdr) Then im_pdr.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)	
	case IC_SOURCE
		If IsValid(im_source) Then im_source.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case IC_SEARCH
		If IsValid(im_search) Then im_search.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case IC_REPORT
		If IsValid(im_report) Then im_report.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case IC_VIEW
		If IsValid(im_view) Then im_view.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
end choose
end event

type dw_pdr_sources from u_dw within w_query_engine
boolean visible = false
string accessiblename = "PDR Sources"
string accessibledescription = "PDR Sources"
integer x = 2688
integer y = 40
integer width = 471
integer height = 100
integer taborder = 60
boolean titlebar = true
string title = "PDR Sources"
string dataobject = "d_pdr_sources"
end type

event constructor;call super::constructor;//	11/16/04	GaryR	Track 4115d	STARS Reporting - Claims PDRs

This.SetTransObject (Stars2ca)
This.of_SetUpdateable(TRUE)
end event

type dw_pdq_cntl from u_dw within w_query_engine
boolean visible = false
string accessiblename = "PDQ Control"
string accessibledescription = "PDQ Control"
integer x = 1897
integer y = 28
integer width = 462
integer height = 96
integer taborder = 20
boolean titlebar = true
string title = "Cntl"
string dataobject = "d_pdq_cntl"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(TRUE)
end event

type dw_pdq_case_link from u_dw within w_query_engine
boolean visible = false
string accessiblename = "Case Link"
string accessibledescription = "Case Link"
integer x = 1394
integer width = 558
integer height = 92
integer taborder = 10
boolean titlebar = true
string title = "Case Link"
string dataobject = "d_case_link"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(TRUE)

// FDG 04/16/01 Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//This.of_SetTrim (TRUE)
end event

type dw_pdq_criteria from u_dw within w_query_engine
boolean visible = false
string accessiblename = "PDQ Criteria"
string accessibledescription = "PDQ Criteria"
integer x = 978
integer y = 52
integer width = 453
integer height = 96
integer taborder = 40
boolean titlebar = true
string title = "Criteria"
string dataobject = "d_pdq_criteria"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(TRUE)

// GaryR	07/03/01	Track 2356D - Trim Data
THIS.of_SetTrim( TRUE )
end event

type dw_pdq_columns from u_dw within w_query_engine
boolean visible = false
string accessiblename = "PDQ Columns"
string accessibledescription = "PDQ Columns"
integer x = 2135
integer y = 32
integer width = 535
integer height = 100
integer taborder = 50
boolean titlebar = true
string title = "Columns"
string dataobject = "d_pdq_columns"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
this.of_SetUpdateable(TRUE)
end event

type tab_level from tab within w_query_engine
string accessiblename = "Tab"
string accessibledescription = "Tab"
accessiblerole accessiblerole = clientrole!
integer y = 4
integer width = 3369
integer height = 1908
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type

on tab_level.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10}
end on

on tab_level.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
end on

event selectionchanged;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	selectionchanged							w_query_engine
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Must make the corresponding query engine user object visible and register the 
// PDQ datawindows within the user object and make the current query engine user object 
// invisible.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			oldindex		Integer				The old tabpage index.
//		Value			newindex		Integer				The new tabpage index.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Long			0				Continue. 
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//	J.Mattis	01/26/98		Added logic to correct button visibility error when
//								changing to a new level.
//	FDG		02/27/98		Reset the text for the newly selected tab.
//	FDG		03/26/98		Track 982.  Set the enabled/disabled menu items for 	
//								removing this level.
//	FDG		04/14/98		Track 975, 1063.  If the selected tab is the last
//								tab, then allow enable the next level.  Also,
//								filter/unfilter the ancillary data from the 
//								data_source DDDW.
//	FDG		05/12/98		Track 1223.  The "counts" are on the appropriate
//								tabpages.
// FNC		07/07/98		Track 1218. The drilldown option on the view RMM should
//								only be enabled for single level querries.
// ajs      07/30/98    Track #1522. Pass period id & period function.
// FDG		09/21/01		Stars 4.8.1.  Don't enable if the associated case is
//								closed or deleted
//	GaryR		11/16/04		Track 4115d	STARS Reporting - Claims PDRs
//	GaryR		12/20/07		SPR 5199	Add the facility to categorize and sort data sources
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
long ll_count
Integer	li_level
boolean	lb_ancillary_inv_type,	&
			lb_visible

parent.event ue_register_level(newindex,oldindex)

iu_active_query.event ue_register_vars(is_query_id,is_parm_subset_id,ii_period_key,is_period_function)		//ajs 4.0 07/30/98 Track #1522
Parent.wf_SetLevelText (newindex)		//	FDG 02/27/98

// FDG 03/26/98	begin

// Get the maximum # levels for this query
li_level	=	wf_get_max_uo_query()

// ii_level_num is the current level and is set in ue_register_level
IF	ii_level_num	>	1				&
AND ii_level_num	=	li_level		THEN
	// The current level is the last level and not the 1st level.
	//	Provide the ability to remove this level.
	// FDG 09/21/01 begin
	IF	ib_disable_update		THEN
	ELSE
		im_report.m_menu.m_removelevel.enabled		=	TRUE
		im_search.m_menu.m_removelevel.enabled		=	TRUE
		im_source.m_menu.m_removelevel.enabled		=	TRUE
		im_view.m_menu.m_removelevel.enabled		=	TRUE
	END IF
	// FDG 09/21/01 end
ELSE
	// The current level is either the 1st level or not the last level.
	// Do not allow the user to remove this level.
	im_report.m_menu.m_removelevel.enabled		=	FALSE
	im_search.m_menu.m_removelevel.enabled		=	FALSE
	im_source.m_menu.m_removelevel.enabled		=	FALSE
	im_view.m_menu.m_removelevel.enabled		=	FALSE
END IF

// The last level can have the next level menu items enabled
lb_ancillary_inv_type	=	iu_active_query.of_get_ancillary_inv_type()

IF	ii_level_num				=	li_level		&
AND lb_ancillary_inv_type	=	FALSE			THEN
	// FDG 09/21/01 begin
	IF	ib_disable_update		THEN
	ELSE
		im_search.m_menu.m_nextlevel.enabled		=	TRUE			// FDG 04/14/98
		im_view.m_menu.m_nextlevel.enabled			=	TRUE			// FDG 04/14/98
	END IF
	// FDG 09/21/01 end
ELSE
	im_search.m_menu.m_nextlevel.enabled		=	FALSE			// FDG 04/14/98
	im_view.m_menu.m_nextlevel.enabled			=	FALSE			// FDG 04/14/98
END IF

// If there are multiple levels, then filter out the ancillary data
//	from the data source DDDW
IF	ii_level_num	=	1				&
AND ii_level_num	=	li_level		THEN
	// FDG 09/21/01 begin
	IF	NOT ib_disable_update		THEN	im_view.m_menu.m_drilldown.enabled = TRUE						// FNC 07/07/98
	// FDG 09/21/01 end
ELSE
	im_view.m_menu.m_drilldown.enabled = FALSE					// FNC 07/07/98
END IF

// FDG 04/14/98 end


RETURN 0
end event

type tabpage_1 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 1"
string accessibledescription = "Level 1"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 1   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 2"
string accessibledescription = "Level 2"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 2   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 3   "
string accessibledescription = "Level 3   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 3   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 4   "
string accessibledescription = "Level 4   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 4   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 5   "
string accessibledescription = "Level 5   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 5   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 6   "
string accessibledescription = "Level 6   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 6   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_7 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 7   "
string accessibledescription = "Level 7   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 7   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_8 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 8   "
string accessibledescription = "Level 8   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 8   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_9 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 9   "
string accessibledescription = "Level 9   "
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 9   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_10 from userobject within tab_level
boolean visible = false
string accessiblename = "Level 10"
string accessibledescription = "Level 10"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 3333
integer height = 1876
long backcolor = 67108864
string text = "Level 10   "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type dw_pdq_tables from u_dw within w_query_engine
boolean visible = false
string accessiblename = "PDQ Tables"
string accessibledescription = "PDQ Tables"
integer x = 1669
integer y = 16
integer width = 288
integer height = 104
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Tables"
string dataobject = "d_pdq_tables"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca)
this.of_SetUpdateable(TRUE)
end event

event sqlpreview;call super::sqlpreview;// comment
end event

