HA$PBExportHeader$u_nvo_query.sru
$PBExportComments$Query engine class. (inherited from n_base) <logic>
forward
global type u_nvo_query from n_base
end type
end forward

global type u_nvo_query from n_base
event type integer ue_create_sql ( )
event type integer ue_check_status ( integer ai_rc )
end type
global u_nvo_query u_nvo_query

type variables
// List Tab Controls
u_dw					idw_search, &
						idw_list
//	PDR Tab Controls
u_dw					idw_pdr		//	04/17/02	GaryR	Track 2552d

// Source Tab Controls
u_dw					idw_source

// Search Tab Controls
u_display_period	iu_period
u_dw					idw_criteria
u_cb					icb_help

// Customize Report Tab Controls 
MultiLineEdit		imle_title
u_dw					idw_available,	&
						idw_selected,	&
						idw_fastquery
u_cb              icb_add,	&
						icb_remove

n_ds              ids_report_template_case_link
n_ds              ids_report_template_pdq_cntl
n_ds              ids_report_template_pdq_columns

//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
u_report_options	iuo_report_options

// View Tab Controls
u_dw					idw_report
u_dw					idw_break
PictureButton		ipb_up, &
						ipb_down

//set from uo_query in uf_set_query_id
string				is_query_id   

// Uo_query Controls
uo_Query				iuo_Query

// Window Controls
w_query_engine		iw_Parent
u_Dw					idw_pdq_case_link
u_Dw					idw_pdq_cntl
u_Dw					idw_pdq_tables
u_Dw					idw_pdq_criteria
u_Dw					idw_pdq_columns
u_dw					idw_pdr_sources	//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs

// NVO's that have events called by other NVO's
u_nvo_report		iuo_nvo_report
u_nvo_create_sql	iuo_nvo_create_sql

// Select Count(*) service
u_nvo_count			inv_count

// SQL Structure
sx_sql_statement_container   istr_sql_container
sx_sql_statement             istr_sql_statement[]

// Data type (Base or Subset) (set from uf_set_data_type)
Protected		String	is_data_type

//Period ID (set from uo_query in uf_set_period_function)
Protected		String  	is_period_function  

//Period ID (set from uo_query in uf_set_period_key)
Protected		Integer 	ii_period_key  

// Subset ID (set from uf_set_source_subset_id)
Protected		String	is_source_subset_id

// Subset ID (set from uf_set_subset_id)
Protected		String	is_subset_id

// Invoice Type (set from uf_set_inv_type)
Protected		String	is_inv_type
Protected		String	is_old_inv_type
Protected		String	is_inv_description

//
Protected		String	is_orig_source_subset_id

// Key columns structure
sx_keys				istr_key_columns

// Drilldown structure
sx_drilldown		istr_drilldown

sx_prov_query_structure	istr_prov_query
sx_prov_query_structure	istr_npi_prov_query	//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider

sx_break_info		istr_break_info

boolean				ib_query_loaded_flag

string				is_source_type

int					ii_ml_filter_rows[]

/*variables that must be registered in u_nvo_search so that
 they can be registered in u_nvo_create_sql */

sx_subsetting_info   istr_subsetting_info

string				is_drilldown_previous_temp_table

boolean				ib_drilldown, &
						ib_subsetting, &
						ib_count, &
						ib_ancillary_inv_type

integer				ii_filter_count, &
						ii_sub_filter_count

int					IC_LIST		= 1
int					IC_PDR 		= 2
int					IC_SOURCE	= 3
int					IC_SEARCH	= 4
int					IC_REPORT	= 5
int					IC_VIEW		= 6
//	04/17/02	GaryR	Track 2552d - End

Constant	String	IC_TEMP_ALIAS = 'TMP'

// dw_criteria from the previous level of a ML PDQ
u_dw					idw_prev_criteria

//report on enhancements NLG 8-19-98
boolean				ib_load_template = TRUE

//ajs 08-27-98 Ts144-Report On enhancments
long					il_drop_row

//NLG 10-26-99 ts2463c Fraud PDQ enhancements
boolean				ib_recurring_pdq
integer				ii_run_frequency

// FDG 08/02/01 - Store column names selected from
// u_nvo_create_sql
String		is_select_column[]
end variables

forward prototypes
public subroutine uf_set_search_uo_period (ref u_display_period au_period)
public subroutine uf_set_report_mle_title (ref multilineedit amle)
public subroutine uf_set_list_dw_search (ref u_dw adw)
public subroutine uf_set_report_dw_available (ref u_dw adw)
public subroutine uf_set_search_dw_criteria (ref u_dw adw)
public subroutine uf_set_report_dw_selected (ref u_dw adw)
public subroutine uf_set_source_dw_source (ref u_dw adw)
public subroutine uf_set_report_cb_add (ref u_cb acb)
public subroutine uf_set_search_cb_help (ref u_cb acb)
public subroutine uf_set_report_cb_remove (ref u_cb acb)
public subroutine uf_set_view_dw_report (ref u_dw adw)
public subroutine uf_set_report_pb_up (ref picturebutton apb)
public subroutine uf_set_report_pb_down (ref picturebutton apb)
public function integer uf_setparent (uo_query auo_query)
public function integer uf_setparentwindow (w_query_engine aw_parent)
public subroutine uf_set_list_dw_list (u_dw adw)
public subroutine uf_set_nvo_report (boolean as_create)
public subroutine uf_set_sx_keys (ref sx_keys astr_key_columns)
public subroutine uf_set_sx_sql_statement (ref sx_sql_statement astr_sql_statement[])
public subroutine uf_set_data_type (ref string as_data_type)
public subroutine uf_set_source_subset_id (ref string as_source_subset_id)
public subroutine uf_set_inv_type (ref string as_inv_type)
public function integer uf_set_nvo_count (boolean ab_switch)
public subroutine uf_set_report_ds_case_link (ref n_ds ads_report_template_case_link)
public subroutine uf_set_report_ds_pdq_cntl (ref n_ds ads_report_template_pdq_cntl)
public subroutine uf_set_report_ds_pdq_columns (n_ds ads_report_template_pdq_columns)
public function integer uf_setstatus (u_dw adw_requestor, dwitemstatus ais_newstatus)
public subroutine uf_set_subset_id (ref string as_subset_id)
public subroutine uf_set_orig_source_subset_id (ref string as_orig_source_subset_id)
public subroutine uf_set_sx_drilldown (ref sx_drilldown astr_drilldown)
public function integer uf_set_temp_table (boolean ab_switch)
public subroutine uf_set_query_id (ref string as_query_id)
public subroutine uf_set_istr_break_info (ref sx_break_info astr_break_info)
public subroutine uf_set_istr_prov_query (ref sx_prov_query_structure astr_prov_query)
public subroutine uf_set_ib_count (ref boolean ab_count)
public subroutine uf_set_ib_drilldown (ref boolean ab_drilldown)
public subroutine uf_set_ib_subsetting (ref boolean ab_subsetting)
public subroutine uf_set_filter_count (ref integer ai_filter_count)
public subroutine uf_set_sub_filter_count (ref integer ai_sub_filter_count)
public subroutine uf_set_drilldown_previous_temp_table (ref string as_drilldown_previous_temp_table)
public subroutine uf_set_source_type (ref string as_source_type)
public subroutine uf_set_istr_subsetting_info (ref sx_subsetting_info astr_subsetting_info)
public subroutine uf_set_istr_sql_statement (ref sx_sql_statement_container astr_sql_container)
public subroutine uf_set_ib_query_loaded_flag (ref boolean ab_query_loaded_flag)
public subroutine uf_set_ib_ancillary_inv_type (ref boolean ab_ancillary_inv_type)
public function sx_sql_statement_container uf_get_istr_sql_container ()
public subroutine uf_set_old_inv_type (ref string as_old_inv_type)
public subroutine uf_set_inv_description (ref string as_inv_description)
public subroutine uf_set_period_key (ref integer ai_period_key)
public subroutine uf_set_period_function (ref string as_period_function)
public subroutine uf_set_prev_dw_criteria (ref u_dw adw_prev_criteria)
public subroutine uf_set_ib_load_template (boolean ab_load_template)
public subroutine uf_set_dw_break (u_dw adw)
public subroutine uf_set_run_frequency (integer ai_run_frequency)
public function integer uf_set_ib_recurring_pdq (ref boolean ab_switch)
public subroutine uf_set_report_dw_fastquery (ref u_dw adw)
public subroutine uf_set_pdr_dw_pdr (ref u_dw adw_pdr)
public subroutine uf_set_nvo_create_sql (boolean as_create)
public function boolean uf_is_pdr_secured (long al_pdr_security)
public subroutine uf_set_report_uo_report_options (ref u_report_options auo_report_options)
public subroutine uf_set_istr_npi_prov_query (ref sx_prov_query_structure astr_prov_query)
end prototypes

event type integer ue_create_sql();//*********************************************************************************
// Script:		u_nvo_create_sql.ue_create_sql
//
//	Arguments:	None
//
// Returns:		Integer
//
//	Description:
//			This event is a 'wrapper" for u_nvo_create_sql.ue_create_sql and can
//		be invoked from either u_nvo_view or u_nvo_search.  This script will
//		call u_nvo_create_sql.ue_create_sql and get its return code.  It will
//		then invoke ue_check_status to determine if any errors occurred.
//
//*********************************************************************************
//
//	FDG	06/15/98	Track ????.  Created.
//	FDG	07/10/98	Get the provider query data from u_nvo_create_sql.
//	FDG	08/02/01	Track ???? (Stars 4.6 SP1).  Get the list of selected columns
//						from u_nvo_create_sql.
// MikeF	03/02/04 SPR 3909d Set Views boolean (Only true if Select Count(*))
// MikeF	03/04/04 SPR 3921d Using a LOJ with a UNION ALL View gives DB error
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//*********************************************************************************

Integer	li_rc

sx_select_column	lstr_select_column				// FDG 08/02/01

IF	IsValid (iuo_nvo_create_sql)		THEN
	li_rc		=	iuo_nvo_create_sql.Event	ue_create_sql()
	// Get the SQL data
	istr_sql_container	=	iuo_nvo_create_sql.uf_get_istr_sql_container ()
	istr_sql_statement	=	istr_sql_container.lsx_sql_statement
	iuo_query.of_set_istr_sql_statement (istr_sql_container)
	// Get the subsetting data
	istr_subsetting_info	=	iuo_nvo_create_sql.uf_get_istr_subsetting_info ()
	// Get the provider query data
	istr_prov_query		=	iuo_nvo_create_sql.uf_get_istr_prov_query ()		// FDG 07/10/98
	istr_npi_prov_query	=	iuo_nvo_create_sql.uf_get_istr_npi_prov_query()
	iuo_query.of_set_istr_prov_query (istr_prov_query, FALSE)					// FDG 07/10/98
	iuo_query.of_set_istr_prov_query( istr_npi_prov_query, TRUE )
	// Get the break information 													FNC 06/24/08
	istr_break_info = iuo_nvo_create_sql.uf_get_istr_break_info()	// FNC 06/24/98
	lstr_select_column	=	iuo_nvo_create_sql.uf_get_select_column()		// FDG 08/02/01
	is_select_column		=	lstr_select_column.s_select_column				// FDG 08/02/01
ELSE
	This.uf_set_nvo_create_sql (TRUE)
	li_rc		=	iuo_nvo_create_sql.Event	ue_create_sql()
	// Get the SQL data
	istr_sql_container	=	iuo_nvo_create_sql.uf_get_istr_sql_container ()
	istr_sql_statement	=	istr_sql_container.lsx_sql_statement
	iuo_query.of_set_istr_sql_statement (istr_sql_container)
	// Get the subsetting data
	istr_subsetting_info	=	iuo_nvo_create_sql.uf_get_istr_subsetting_info ()
	// Get the provider query data
	istr_prov_query		=	iuo_nvo_create_sql.uf_get_istr_prov_query ()		// FDG 07/10/98
	istr_npi_prov_query	=	iuo_nvo_create_sql.uf_get_istr_npi_prov_query()
	iuo_query.of_set_istr_prov_query (istr_prov_query, FALSE)								// FDG 07/10/98
	iuo_query.of_set_istr_prov_query( istr_npi_prov_query, TRUE )
	// Get the break information 													FNC 06/24/08
	istr_break_info = iuo_nvo_create_sql.uf_get_istr_break_info()	// FNC 06/24/98
	lstr_select_column	=	iuo_nvo_create_sql.uf_get_select_column()		// FDG 08/02/01
	is_select_column		=	lstr_select_column.s_select_column				// FDG 08/02/01
	This.uf_set_nvo_create_sql (FALSE)
END IF

This.Event	ue_check_status (li_rc)

Return	li_rc

end event

event ue_check_status;call super::ue_check_status;//*********************************************************************************
// Script:		u_nvo_create_sql.ue_check_status
//
//	Arguments:	ai_rc - The return code passed to this event
//
// Returns:		Integer
//
//	Description:
//		This event is is invoked from either ue_create_sql, ue_format_where_criteria
//		or ue_format_where_criteria_add_clauses.
//		This script will take the return code from the corresponding script in
//		u_nvo_create_sql to determine which tab and which d/w the user should
//		be placed.
//
//	Note:
//		If returning to a multi-row datawindow (i.e. dw_criteria), the a ScrollToRow
//		must be called in the u_nvo_create_sql script.
//
//		Some errors don't need to go to a specific tab.  The same holds true if
//		there is no error.
//
//*********************************************************************************
//
//	FDG	06/15/98	Track ????. Created.
//
// FNC	07/09/98 Track 1317	Move select tab to after setfocus on idw_criteria 
//						because select tab messes up pointers to uo_query.
//
//*********************************************************************************

CHOOSE CASE ai_rc
		
	CASE -10
		// Search tab, dw_criteria, no column
		iuo_query.Event	ue_SelectTab (ic_search)
	CASE -100
		// Search tab, dw_criteria, expression_one
		idw_criteria.SetFocus()									
		idw_criteria.SetColumn('expression_one')
		iuo_query.Event	ue_SelectTab (ic_search)		
	CASE -101
		// Search tab, dw_criteria, expression_two
		idw_criteria.SetFocus()									
		idw_criteria.SetColumn('expression_two')			
		iuo_query.Event	ue_SelectTab (ic_search)
	CASE -102
		// Search tab, dw_criteria, relational_op
		idw_criteria.SetFocus()									
		idw_criteria.SetColumn('relational_op')			
		iuo_query.Event	ue_SelectTab (ic_search)		
	CASE -103
		// Search tab, dw_criteria, left_paren
		idw_criteria.SetFocus()									
		idw_criteria.SetColumn('left_paren')				
		iuo_query.Event	ue_SelectTab (ic_search)
	CASE -104
		// Search tab, dw_criteria, right_paren
		idw_criteria.SetFocus()									
		idw_criteria.SetColumn('right_paren')				
		iuo_query.Event	ue_SelectTab (ic_search)
END CHOOSE

Return	ai_rc

end event

public subroutine uf_set_search_uo_period (ref u_display_period au_period);iu_period = au_period
end subroutine

public subroutine uf_set_report_mle_title (ref multilineedit amle);imle_title = amle
end subroutine

public subroutine uf_set_list_dw_search (ref u_dw adw);idw_search = adw
end subroutine

public subroutine uf_set_report_dw_available (ref u_dw adw);idw_available = adw
end subroutine

public subroutine uf_set_search_dw_criteria (ref u_dw adw);idw_criteria = adw
end subroutine

public subroutine uf_set_report_dw_selected (ref u_dw adw);idw_selected = adw
end subroutine

public subroutine uf_set_source_dw_source (ref u_dw adw);idw_source = adw
end subroutine

public subroutine uf_set_report_cb_add (ref u_cb acb);icb_add = acb
end subroutine

public subroutine uf_set_search_cb_help (ref u_cb acb);icb_help = acb
end subroutine

public subroutine uf_set_report_cb_remove (ref u_cb acb);icb_remove = acb
end subroutine

public subroutine uf_set_view_dw_report (ref u_dw adw);idw_report = adw
end subroutine

public subroutine uf_set_report_pb_up (ref picturebutton apb);ipb_up = apb
end subroutine

public subroutine uf_set_report_pb_down (ref picturebutton apb);ipb_down = apb
end subroutine

public function integer uf_setparent (uo_query auo_query);iuo_Query =  auo_query

RETURN 1
end function

public function integer uf_setparentwindow (w_query_engine aw_parent);//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs

iw_parent = aw_parent

idw_pdq_case_link = aw_parent.dw_pdq_case_link
idw_pdq_cntl = aw_parent.dw_pdq_cntl
idw_pdq_columns = aw_parent.dw_pdq_columns
idw_pdq_criteria = aw_parent.dw_pdq_criteria
idw_pdq_tables = aw_parent.dw_pdq_tables
idw_pdr_sources = aw_parent.dw_pdr_sources

RETURN 1
end function

public subroutine uf_set_list_dw_list (u_dw adw);idw_list = adw
end subroutine

public subroutine uf_set_nvo_report (boolean as_create);///////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	03/19/98	Track 944.  Don't create if already created.  
//						Don't destroy if not created.
//
///////////////////////////////////////////////////////////

if as_create then
	IF Not IsValid (iuo_nvo_report)		THEN
		iuo_nvo_report = create u_nvo_report
	END IF
else
	IF IsValid (iuo_nvo_report)			THEN
		destroy iuo_nvo_report
	END IF
end if

return
end subroutine

public subroutine uf_set_sx_keys (ref sx_keys astr_key_columns);istr_key_columns	=	astr_key_columns

end subroutine

public subroutine uf_set_sx_sql_statement (ref sx_sql_statement astr_sql_statement[]);istr_sql_statement	=	astr_sql_statement

end subroutine

public subroutine uf_set_data_type (ref string as_data_type);//	as_data_type is passed by reference

is_data_type	=	as_data_type
end subroutine

public subroutine uf_set_source_subset_id (ref string as_source_subset_id);//	as_source_subset_id is passed by reference

is_source_subset_id	=	as_source_subset_id


end subroutine

public subroutine uf_set_inv_type (ref string as_inv_type);// as_inv_type is passed by reference

is_inv_type	=	as_inv_type

end subroutine

public function integer uf_set_nvo_count (boolean ab_switch);/////////////////////////////////////////////////////////////
//	Script:	u_nvo_query.uf_set_nvo_count
//
//	Arguments:	ab_switch
//					TRUE = Create the count service
//					FALSE = Destroy the Count service
//
//	Returns:		Integer
//
//	Description:
//		Create or destroy the Select Count(*) service
//
/////////////////////////////////////////////////////////////
//	History
//
//	01/16/98	FDG	Created
//
/////////////////////////////////////////////////////////////

Integer	li_rc

//	Validate argument
IF	IsNull (ab_switch)		THEN
	Return -1
END IF

IF	ab_switch					THEN

	//	Create the Count service
	IF	NOT IsValid (inv_count)		THEN
		inv_count	=	CREATE	u_nvo_count
	ELSE
		Return 0
	END IF
ELSE
	//	Destroy the service
	IF	IsValid (inv_count)	THEN
		Destroy	inv_count
	ELSE
		Return 0
	END IF
END IF

Return 1

end function

public subroutine uf_set_report_ds_case_link (ref n_ds ads_report_template_case_link);ids_report_template_case_link = ads_report_template_case_link
end subroutine

public subroutine uf_set_report_ds_pdq_cntl (ref n_ds ads_report_template_pdq_cntl);ids_report_template_pdq_cntl = ads_report_template_pdq_cntl
end subroutine

public subroutine uf_set_report_ds_pdq_columns (n_ds ads_report_template_pdq_columns);ids_report_template_pdq_columns = ads_report_template_pdq_columns
end subroutine

public function integer uf_setstatus (u_dw adw_requestor, dwitemstatus ais_newstatus);/////////////////////////////////////////////////////////////////////////////
// Object							Event/Function			
// ------							--------------			
//	u_nvo_query						uf_SetStatus
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Change the row status of the ref. dw.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype			Description
//	---------	--------			--------			-----------
//	Reference	adw_requestor	u_Dw				The dw to change the itemstatus.
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

Long l_rows, l_Index

l_rows = adw_Requestor.RowCount()

For l_Index = 1 To l_rows
	//set the row status
	adw_Requestor.SetItemStatus(l_Index,0,Primary!,ais_NewStatus)
Next

RETURN 1
end function

public subroutine uf_set_subset_id (ref string as_subset_id);//	as_subset_id is passed by reference

is_subset_id	=	as_subset_id
end subroutine

public subroutine uf_set_orig_source_subset_id (ref string as_orig_source_subset_id);//	as_subset_id is passed by reference

is_orig_source_subset_id	=	as_orig_source_subset_id
end subroutine

public subroutine uf_set_sx_drilldown (ref sx_drilldown astr_drilldown);istr_drilldown	=	astr_drilldown

end subroutine

public function integer uf_set_temp_table (boolean ab_switch);/////////////////////////////////////////////////////////////
//	Script:	u_nvo_query.uf_set_temp_table
//
//	Arguments:	ab_switch
//					TRUE = Create the temp table service
//					FALSE = Destroy the temp table service
//
//	Returns:		Integer
//
//	Description:
//		Create or destroy the temporary table service
//
/////////////////////////////////////////////////////////////
//	History
//
//	05/27/98	FDG	Track 1286.  Created
//
/////////////////////////////////////////////////////////////

Integer	li_rc

//	Validate argument
IF	IsNull (ab_switch)		THEN
	Return -1
END IF

IF	ab_switch					THEN
	//	Create the Count service
	IF	NOT IsValid (inv_temp_table)		THEN
		inv_temp_table	=	CREATE	n_cst_temp_table
	ELSE
		Return 0
	END IF
ELSE
	//	Destroy the service
	IF	IsValid (inv_temp_table)	THEN
		Destroy	inv_temp_table
	ELSE
		Return 0
	END IF
END IF

Return 1

end function

public subroutine uf_set_query_id (ref string as_query_id);is_query_id = as_query_id
end subroutine

public subroutine uf_set_istr_break_info (ref sx_break_info astr_break_info);istr_break_info	=	astr_break_info

end subroutine

public subroutine uf_set_istr_prov_query (ref sx_prov_query_structure astr_prov_query);istr_prov_query	=	astr_prov_query

end subroutine

public subroutine uf_set_ib_count (ref boolean ab_count);ib_count	=	ab_count

end subroutine

public subroutine uf_set_ib_drilldown (ref boolean ab_drilldown);ib_drilldown	=	ab_drilldown
end subroutine

public subroutine uf_set_ib_subsetting (ref boolean ab_subsetting);ib_subsetting	=	ab_subsetting

end subroutine

public subroutine uf_set_filter_count (ref integer ai_filter_count);ii_filter_count	=	ai_filter_count

end subroutine

public subroutine uf_set_sub_filter_count (ref integer ai_sub_filter_count);ii_sub_filter_count	=	ai_sub_filter_count
end subroutine

public subroutine uf_set_drilldown_previous_temp_table (ref string as_drilldown_previous_temp_table);is_drilldown_previous_temp_table	=	as_drilldown_previous_temp_table

end subroutine

public subroutine uf_set_source_type (ref string as_source_type);is_source_type	=	as_source_type

end subroutine

public subroutine uf_set_istr_subsetting_info (ref sx_subsetting_info astr_subsetting_info);istr_subsetting_info	=	astr_subsetting_info

end subroutine

public subroutine uf_set_istr_sql_statement (ref sx_sql_statement_container astr_sql_container);istr_sql_container	=	astr_sql_container
istr_sql_statement	=	astr_sql_container.lsx_sql_statement

end subroutine

public subroutine uf_set_ib_query_loaded_flag (ref boolean ab_query_loaded_flag);ib_query_loaded_flag	=	ab_query_loaded_flag

end subroutine

public subroutine uf_set_ib_ancillary_inv_type (ref boolean ab_ancillary_inv_type);ib_ancillary_inv_type	=	ab_ancillary_inv_type

end subroutine

public function sx_sql_statement_container uf_get_istr_sql_container ();Return	istr_sql_container

end function

public subroutine uf_set_old_inv_type (ref string as_old_inv_type);// as_old_inv_type passed by reference
is_old_inv_type	=	as_old_inv_type

end subroutine

public subroutine uf_set_inv_description (ref string as_inv_description);// as_inv_description is passed by reference
is_inv_description	=	as_inv_description

end subroutine

public subroutine uf_set_period_key (ref integer ai_period_key);//ajs 07/30/98 Stars 4.0 Track #1522 Pass period id
ii_period_key = ai_period_key
end subroutine

public subroutine uf_set_period_function (ref string as_period_function);//ajs 07/30/98 Stars 4.0 Track #1522 Pass period function
is_period_function = as_period_function
end subroutine

public subroutine uf_set_prev_dw_criteria (ref u_dw adw_prev_criteria);idw_prev_criteria	=	adw_prev_criteria

end subroutine

public subroutine uf_set_ib_load_template (boolean ab_load_template);//NLG 8-19-98 ts144 Report on enhancements
ab_load_template = ib_load_template
end subroutine

public subroutine uf_set_dw_break (u_dw adw);idw_break	=	adw

end subroutine

public subroutine uf_set_run_frequency (integer ai_run_frequency);ii_run_frequency = ai_run_frequency
end subroutine

public function integer uf_set_ib_recurring_pdq (ref boolean ab_switch);//*********************************************************************************
// Script Name:	u_nvo_query.uf_set_ib_recurring_pdq
//
//	Arguments:		boolean ab_switch
//						
//
// Returns:			integer
//
//	Description:	Set the instance variable ib_recurring_pdq	
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

public subroutine uf_set_report_dw_fastquery (ref u_dw adw);// FDG 07/17/00	-	Track 2465c.  Stars 4.5 SP1.  Added

idw_fastquery	=	adw

end subroutine

public subroutine uf_set_pdr_dw_pdr (ref u_dw adw_pdr);//	04/17/02	GaryR	Track 2552d	Predefined Reports (PDR)
idw_pdr = adw_pdr
end subroutine

public subroutine uf_set_nvo_create_sql (boolean as_create);//****************************************************************************************
//	FNC	01/06/98		Create the NVO that contains the code to create the report
//							sql. This NVO is created with the view nvo since the view
//							datawindow will call the create sql code.
//
//	FDG	03/19/98		Track 944.  Don't create if already created.  Don't destroy
//							if not created.
// FNC	06/11/98		Register UO_Query objects and variables in u_nvo_create_sql
//	NLG	10/27/99		Track 2463c Fraud PDQ. Register the text stored
//							in the payment date options dropdown listbox
// FNC	12/23/99		Perform set functions even if NVO is created so new versions
//							of variables will be set in the NVO.
//	FDG	07/17/00		Track 2465c. Stars 4.5 SP1.  Register fastquery data.
//	FDG	03/12/01		Stars 4.7.	ros_directory is no longer used.
//	GaryR	04/24/02		Track 2552d	Predefined Report (PDR)
//	GaryR	08/06/04		Track 4049d	Provide drilldown from Subset Summary
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//****************************************************************************************

string		ls_pd_opt_desc
sx_filter_info_container	lsx_filter_container

if as_create then
	IF	Not IsValid (iuo_nvo_create_sql)			THEN
		iuo_nvo_create_sql = create u_nvo_create_sql
	END IF
	iuo_nvo_create_sql.uf_set_source_dw_source (idw_source)	
	iuo_nvo_create_sql.uf_set_search_dw_criteria (idw_criteria)	
	iuo_nvo_create_sql.uf_set_report_dw_selected (idw_selected)
	
	//iuo_nvo_create_sql.uf_set_ids_ros_dir(ids_ros_dir)			// FDG 03/12/01	
	
	iuo_nvo_create_sql.uf_set_istr_drilldown(istr_drilldown)
	iuo_nvo_create_sql.uf_set_istr_subsetting_info(istr_subsetting_info)
	iuo_nvo_create_sql.uf_set_istr_sql_statement(istr_sql_container)
	
	iuo_nvo_create_sql.uf_set_source_type(is_source_type)
	iuo_nvo_create_sql.uf_set_inv_type(is_inv_type)
	iuo_nvo_create_sql.uf_set_subset_id(is_subset_id)
	iuo_nvo_create_sql.uf_set_source_subset_id(is_source_subset_id)
	iuo_nvo_create_sql.uf_set_drilldown_previous_temp_table(is_drilldown_previous_temp_table)

	iuo_nvo_create_sql.uf_set_ib_count(ib_count)
	iuo_nvo_create_sql.uf_set_ib_drilldown(ib_drilldown)
	iuo_nvo_create_sql.uf_set_ib_subsetting(ib_subsetting)		
	iuo_nvo_create_sql.uf_set_ib_ancillary_inv_type(ib_ancillary_inv_type)		
	
	iuo_nvo_create_sql.uf_set_filter_count(ii_filter_count)
	iuo_nvo_create_sql.uf_set_sub_filter_count(ii_sub_filter_count)
	iuo_nvo_create_sql.uf_set_data_type(is_data_type)
	iuo_nvo_create_sql.uf_set_iuo_period(iu_period)
	iuo_nvo_create_sql.uf_set_istr_break_info(istr_break_info)
	iuo_nvo_create_sql.uf_set_istr_prov_query(istr_prov_query)
	iuo_nvo_create_sql.uf_set_istr_npi_prov_query(istr_npi_prov_query)
	iuo_nvo_create_sql.uf_set_istr_key_columns(istr_key_columns)
	
	lsx_filter_container		=	iw_parent.wf_get_isx_filter_info()
	iuo_nvo_create_sql.uf_set_isx_filter_info(lsx_filter_container)
	//NLG 10-27-99 ts2463c fraud pdq changes
	ls_pd_opt_desc = iuo_query.of_get_pd_opt_desc()
	iuo_nvo_create_sql.uf_set_pd_opt_desc(ls_pd_opt_desc)
	iuo_nvo_create_sql.uf_set_run_frequency(ii_run_frequency)
	iuo_nvo_create_sql.uf_set_ib_recurring_pdq(ib_recurring_pdq)
	// FDG 07/17/00 - Register fast query data
	iuo_nvo_create_sql.uf_set_fastquery_ind (idw_fastquery.object.fastquery_ind [1])
	iuo_nvo_create_sql.uf_set_fastquery_rows (idw_fastquery.object.fastquery_rows [1])
	iuo_nvo_create_sql.ib_is_pdr_mode = iw_parent.of_is_pdr_mode()	//	GaryR	04/24/02	Track 2552d
	iuo_nvo_create_sql.ii_prefilter_rows = iw_parent.ii_prefilter_rows
	iuo_nvo_create_sql.is_prefilter_bool = iw_parent.is_prefilter_bool
else
	IF IsValid (iuo_nvo_create_sql)				THEN
		destroy iuo_nvo_create_sql
	END IF
end if

return
end subroutine

public function boolean uf_is_pdr_secured (long al_pdr_security);//////////////////////////////////////////////////////////////////////////
//
//	This method will validate the PDR_SECURITY flag 
//	to determine access to a PDR for the current user
//	NOTE: inv_count Must be Created and Destroyed by the caller
//
//////////////////////////////////////////////////////////////////////////
//
//	05/10/04	GaryR	Track 3756d	Streamline PDR deployment & security
//
//////////////////////////////////////////////////////////////////////////

//Long		ll_count
String	ls_sql, ls_bus_dflt, ls_trim

// Check if security is set
IF al_pdr_security = 0 THEN Return FALSE

//	Check if rows exist
ls_sql = "select count(*) from pdr_security where sec_id = " + String( al_pdr_security )
IF inv_count.uf_get_count( ls_sql ) < 1 THEN Return FALSE

//	Check Dept Security
ls_sql = "select count(*) from pdr_security where sec_id = " + &
				String( al_pdr_security ) + " and sec_type = 'D'"
IF inv_count.uf_get_count( ls_sql ) > 0 THEN
	ls_sql = "select count(*) from pdr_security where sec_id = " + String( al_pdr_security ) + &
					" and sec_type = 'D' and sec_value = '" + gc_user_dept + "'"
	IF inv_count.uf_get_count( ls_sql ) > 0 THEN Return FALSE
END IF

//	Check User ID Security
ls_sql = "select count(*) from pdr_security where sec_id = " + &
				String( al_pdr_security ) + " and sec_type = 'U'"
IF inv_count.uf_get_count( ls_sql ) > 0 THEN
	ls_sql = "select count(*) from pdr_security where sec_id = " + String( al_pdr_security ) + &
					" and sec_type = 'U' and sec_value = '" + gc_user_id + "'"
	IF inv_count.uf_get_count( ls_sql ) > 0 THEN Return FALSE
END IF

//	Check Business (LOB) Security
ls_sql = "select count(*) from pdr_security where sec_id = " + &
				String( al_pdr_security ) + " and sec_type = 'B'"
IF inv_count.uf_get_count( ls_sql ) > 0 THEN
	SELECT bus_dflt  
   INTO	:ls_bus_dflt  
   FROM	users  
   WHERE user_id = Upper( :gc_user_id )
   USING Stars2ca  ;

	IF Stars2ca.of_check_status() <> 0 then
		MessageBox( "ERROR", "Unable to retrieve business from USERS table for USER " + &
										gc_user_id, StopSign! )
		Return TRUE
	END IF

	gnv_sql.of_trimdata( ls_bus_dflt )
	ls_sql = "select count(*) from pdr_security where sec_id = " + String( al_pdr_security ) + &
					" and sec_type = 'B' and sec_value = '" + ls_bus_dflt + "'"
	IF inv_count.uf_get_count( ls_sql ) > 0 THEN Return FALSE
END IF

//	Check User Security Level Security
ls_sql = "select count(*) from pdr_security where sec_id = " + &
				String( al_pdr_security ) + " and sec_type = 'S'"
IF inv_count.uf_get_count( ls_sql ) > 0 THEN
	ls_trim = gv_user_sl
	gnv_sql.of_trimdata( ls_trim )
	ls_sql = "select count(*) from pdr_security where sec_id = " + String( al_pdr_security ) + &
					" and sec_type = 'S' and sec_value = '" + ls_trim + "'"
	IF inv_count.uf_get_count( ls_sql ) > 0 THEN Return FALSE
END IF

Return TRUE
end function

public subroutine uf_set_report_uo_report_options (ref u_report_options auo_report_options);//////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
//////////////////////////////////////////////////////////

iuo_report_options = auo_report_options
end subroutine

public subroutine uf_set_istr_npi_prov_query (ref sx_prov_query_structure astr_prov_query);//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider

istr_npi_prov_query	=	astr_prov_query

end subroutine

on u_nvo_query.create
call super::create
end on

on u_nvo_query.destroy
call super::destroy
end on

event destructor;//	Destroy any previously created objects.

This.uf_set_nvo_count (FALSE)
This.uf_set_nvo_report (FALSE)		// FDG 3/19/98 - Track 944
This.uf_set_nvo_create_sql (FALSE)	// FDG 3/19/98 - Track 944
This.uf_set_temp_table (FALSE)		// FDG 05/27/98 - Track 1286
end event

