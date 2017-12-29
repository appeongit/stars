HA$PBExportHeader$u_nvo_pattern_sql.sru
$PBExportComments$NVO to generate the SQL for a pattern (inherited from n_base) <logic>
forward
global type u_nvo_pattern_sql from n_base
end type
end forward

global type u_nvo_pattern_sql from n_base
event type integer ue_pattern_from ( )
event type string ue_pattern_sql ( )
event type string ue_pattern_where ( boolean ab_dep_set_diff )
event type string ue_pattern_select ( string as_tbl_type,  string as_prefix,  string as_label_alias,  boolean ab_no_label,  string as_set_type )
event type string ue_spec_sql ( )
event type integer ue_filter_pat ( )
event type integer ue_select_unique_key_columns ( )
event type string ue_create_temp_table ( )
event type string ue_pattern_select_add_selected ( string as_select )
end type
global u_nvo_pattern_sql u_nvo_pattern_sql

type variables
// FDG 02/23/01	Stars 4.7	Make patt_id upper-case because of Oracle case-sensitivity
// Pattern IDs
Constant	String	ics_filter_pat = 'FILTER_PAT'	// Filter pattern
Constant	String	ics_generic = 'GENERIC'	// Generic pattern

// Wiil the pattern be run in the background or be
// displayed directly on the window.
Boolean		ib_background_flag

// Unions cannot run in Background mode
Boolean		ib_union_flag

// Was the 'Not In' checkbox checked
Boolean		ib_not_flag

// When converting @SELECT1 and @SELECT2 to
// unique key columns, will the unique key columns also
// be added to ids_report_cols?
Boolean		ib_report_cols

// DataWindows used in w_sampling_analysis_new
u_dw		idw_patt_cntl
u_dw		idw_criteria
u_dw		idw_patt_options
u_dw		idw_available
u_dw		idw_selected
u_dw		idw_report

// Datastore to retrieve all dependent tables
n_ds		ids_dependent_tables

// Datastore to tell middleware where columns are in the
// report
n_ds		ids_report_cols

// Datastore to retrieve the 'Select' columns for a
// numbered pattern
n_ds		ids_patt_columns

// Subset invoice types.  There can be multiple entries
// for a ML subset
String		is_subset_tbl_type[]

// Where clauses (from ue_pattern_where)
String		is_where[]

// Data stored from istr_sub_opt.patt_struc
String		is_sub_src_type
String		is_subset_id
String		is_case_id
String		is_case_spl
String		is_case_ver

// Pattern template ID
String		is_pattern_id

// Revenue Code
String		is_revenue_code

// Data associated with sets in idw_criteria
String		is_set_tbl_type
String		is_set_col_name
String		is_set_main_tbl
String		is_set_tbl_rel
String		is_set_field_value
String		is_set_field_operator
Integer		ii_set_num_of_fields
String		is_same_column

// Data associated with the timeframe data
String		is_timeframe_main_tbl_1
String		is_timeframe_main_tbl_2
String		is_timeframe_tbl_rel_1
String		is_timeframe_tbl_rel_2

// Additional info required for each line of criteria
String		is_where_clause[]
String		is_main_tbl[]
String		is_tbl_rel[]
Boolean		ib_multiple_likes[]

// Data required for non-generic patterns
String		is_sql
String		is_value1[]
String		is_value2[]
Integer		ii_last_label_row

// NVO used to edit for case security
//	FDG	12/21/01	Track 2497.  Declare n_cst_case as a local to remove memory leaks.
//n_cst_case	inv_case

// Structure to hold from-table information
sx_from_tables	istr_from_tables[]

// Structure to hold an array of columns used in the 
// upper Select for NOT logic
sx_select_cols_not	istr_select_cols_not[]

// Structure to hold an array of tables used in the
// upper Select for NOT logic
sx_tables		istr_tables[]

// Revenue NVO
n_cst_revenue	inv_revenue

// To get the column description for unique key columns
n_ds		ids_dictionary

// Required for unique key changes
String		is_i_columns[]
String		is_j_columns[]

// Data length of a column (set in uf_get_data_type)
Integer		ii_data_len
Integer		ii_min_len
Integer		ii_lead_alpha

// Temporary table name
String		is_temp_table

// Array of flags for each row in dw_selected stating if
// the row has been added to the SQL
String		is_added_to_sql[]

// 08/08/01	GaryR	Track 2396d
Protected	Long	il_server_job_id

//	01/14/01	GaryR	Track 2556d
// Indicator to reset idw_report_cols
Boolean		ib_reset_report_cols = TRUE

//	04/13/07	GaryR	Track 4885
//	Flag to indicate revenue in criteria
Boolean		ib_rev_crit

//	04/23/07	GaryR	Track 4885
//	Flag to indicate same criteria in numbered patterns
Boolean		ib_same_crit
end variables

forward prototypes
public subroutine uf_set_background_flag (boolean ab_background_flag)
public subroutine uf_set_dw_patt_cntl (ref u_dw adw)
public subroutine uf_set_dw_criteria (ref u_dw adw)
public subroutine uf_set_dw_patt_options (ref u_dw adw)
public subroutine uf_set_subset_tbl_type (string as_tbl_type[])
public subroutine uf_set_sub_src_type (string as_sub_src_type)
public subroutine uf_set_subset_id (string as_subset_id)
public subroutine uf_set_case_id (string as_case)
public function integer uf_edit_generic_criteria ()
public subroutine uf_set_union_flag (boolean ab_union_flag)
public function boolean uf_get_union_flag ()
public subroutine uf_set_not_flag (boolean ab_not_flag)
public function integer uf_upperbound_from_tables ()
public subroutine uf_edit_elem_desc (ref string as_elem_desc)
public function integer uf_multiple_likes (ref string as_where, string as_col_name, string as_prefix)
public function integer uf_filter_stars_rel (string as_tbl_type)
public subroutine uf_set_pattern_id (string as_pattern_id)
public function string uf_get_patt_cond ()
public function boolean uf_spec_dep_set ()
public subroutine uf_set_last_label_row (integer al_last_label_row)
public subroutine uf_set_dw_available (ref u_dw adw)
public subroutine uf_set_dw_selected (u_dw adw)
public subroutine uf_set_revenue_code (string as_revenue_code)
public function string uf_get_main_tbl (string as_dep_tbl_type, string as_col_name)
public function string uf_get_base_type (string as_tbl_type)
public function sx_main_tbl uf_get_sx_main_tbl ()
public function integer uf_edit_column (string as_tbl_type, string as_col_name)
public function string uf_get_col_desc (string as_tbl_type, string as_col_name)
public subroutine uf_set_same_column (string as_same_column)
public subroutine uf_set_dw_report (ref u_dw adw)
public function string uf_create_sql_prefix (string as_prefix)
public function long uf_retrieve_tbl_type (integer ai_index)
public function integer uf_get_index (string as_prefix)
public function integer uf_get_tbl_type_index (string as_tbl_type)
public function integer uf_get_nbr_unique_keys (string as_tbl_type)
public function long uf_retrieve_tbl_type ()
public function integer uf_set_tbl_type (string as_tbl_type)
public subroutine uf_load_tbl_type (string as_tbl_type[])
public subroutine uf_edit_sql_prefix ()
public subroutine uf_replace_sql (string as_old, string as_new)
public function string uf_string_keys (string as_prefix)
public subroutine uf_init_multiple_likes ()
public function sx_pattern_tbl_types uf_get_sql_tbl_types ()
public function string uf_compare_keys (integer ai_index1, integer ai_index2)
public function integer uf_set_prefix (string as_prefix)
public function integer uf_load_criteria_tables ()
public subroutine uf_clear_from_tables ()
public function integer uf_set_tbl_type (string as_prefix, string as_tbl_type)
public function integer uf_get_tbl_type_index (string as_prefix, string as_tbl_type)
public subroutine uf_set_sql (string as_sql)
public function string uf_get_sql ()
public function string uf_get_data_type (string as_tbl_type, string as_col_name)
public function integer uf_get_data_len (string as_tbl_type, string as_col_name)
public function integer uf_get_data_len ()
public function integer uf_get_min_len (string as_tbl_type, string as_col_name)
public function integer uf_get_min_len ()
public function integer uf_get_lead_alpha (string as_tbl_type, string as_col_name)
public function integer uf_get_lead_alpha ()
public function string uf_get_col_hdr (string as_tbl_type, string as_col_name)
public function boolean uf_is_ml ()
public function string uf_pattern_timeframe (sx_field_array astr_timeframe[])
public function string uf_select1_keys ()
public function string uf_select2_keys ()
public function integer uf_edit_sql ()
public function integer uf_update_report_cols (string as_report_id)
public function integer uf_delete_report_cols ()
public function string uf_get_tbl_desc (string as_tbl_type)
public function string uf_dep_set_sql (string as_sql, string as_dep_delect, sx_dep_set astr_dep_set, string as_order_by_prefix)
public function integer uf_format_line (long al_row)
public function integer uf_pattern_select_not_array ()
public function integer uf_parse_subset_table (string as_table, ref string as_table_type, ref string as_subset_id)
public function string uf_pattern_sql_not (string as_sql)
public function string uf_get_string_value (long al_row, integer ai_column)
public function long uf_get_server_job_id ()
public function string uf_concatenate_keys (integer ai_index)
public function boolean uf_is_unique_key (string as_tbl_type, string as_col_name)
public subroutine uf_clear_data ()
public function integer uf_load_selected_tables ()
public function string uf_select1_keys (integer ai_index)
public function string uf_select2_keys (integer ai_index)
public function integer uf_edit_report_cols (boolean ab_switch)
public function string uf_where_claim (string as_claim_ind, integer ai_idx1, integer ai_idx2)
public function string uf_where_rev_claim (integer ai_idx1, integer ai_idx2)
public function string uf_where_rev_line (integer ai_idx1, integer ai_idx2)
public function string uf_get_set_operand (string as_clm_type)
end prototypes

event type integer ue_pattern_from();//*********************************************************************************
// Script Name:	ue_pattern_from
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	Generate the 'From' clause into structure into istr_from_tables[] 
//						for a Generic pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/14/00	FDG	Track 2924c (4.5 SP1).  For a ML generic pattern, do not join
//						onto itself (create a 'set').
//
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	10/30/02	GaryR	SPR 3363d	If is_set_tbl_type is set to null, set it to empty string
//
//*********************************************************************************

Boolean	lb_found,						&
			lb_dep_filter,					&
			lb_implied_set,				&
			lb_ml_subset,					&
			lb_same_column

Constant Integer	lci_max_tables 		= 	14
Constant Integer	lci_too_many_tables	=	4
Constant	String	lcs_error				=	'error'

Integer	li_upper,						&
			li_upper2,						&
			li_upper3,						&
			li_rc,							&
			li_idx,							&
			li_idx2,							&
			li_idx3,							&
			li_main_tbl_count,			&
			li_dep_tbl_count,				&
			li_time_cnt[],					&
			li_clear_cnt[],				&
			li_timeframe_button,			&
			li_set_num_of_fields

Long		ll_row,							&
			ll_opt_row,						&
			ll_rowcount,					&
			ll_crit_rowcount

String	ls_col_name,					&
			ls_tbl_type,					&
			ls_value,						&
			ls_main_tbl,					&
			ls_tbl_rel,						&
			ls_alias,						&
			ls_timeframe_tbl_type_1,	&
			ls_timeframe_tbl_type_2,	&
			ls_combination_ind,			&
			ls_claim_ind,					&
			ls_day_ind,						&
			ls_patient_ind,				&
			ls_allwd_srvc_ind,			&
			ls_tooth_ind

sx_fields	lstr_dep_temp[],			&
				lstr_main_temp[]


// Get timeframe data
ll_opt_row		=	idw_patt_options.GetRow()
IF	ll_opt_row	<	1		THEN
	MessageBox ('Application Error', 'In u_nvo_pattern_sql.ue_pattern_from, '	+	&
					'cannot get the current row in dw_patt_options.')
	Return	-1
END IF
li_timeframe_button		=	idw_patt_options.object.timeframe_button [ll_opt_row]
ls_timeframe_tbl_type_1	=	idw_patt_options.object.timeframe_tbl_type_1 [ll_opt_row]
ls_timeframe_tbl_type_2	=	idw_patt_options.object.timeframe_tbl_type_2 [ll_opt_row]
ls_combination_ind		=	idw_patt_options.object.combination_ind [ll_opt_row]
ls_claim_ind				=	idw_patt_options.object.claim_ind [ll_opt_row]
ls_day_ind					=	idw_patt_options.object.day_ind [ll_opt_row]
ls_patient_ind				=	idw_patt_options.object.patient_ind [ll_opt_row]
ls_combination_ind		=	idw_patt_options.object.combination_ind [ll_opt_row]
ls_allwd_srvc_ind			=	idw_patt_options.object.allwd_srvc_ind [ll_opt_row]
ls_tooth_ind				=	idw_patt_options.object.tooth_ind [ll_opt_row]

// FDG 06/14/00	Determine if this subset is a ML
lb_ml_subset	=	This.uf_is_ml()

li_upper			=	UpperBound (is_subset_tbl_type)

ll_crit_rowcount		=	idw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_crit_rowcount
	is_tbl_rel [ll_row]		=	''
	is_main_tbl [ll_row]		=	''
	ls_col_name		=	idw_criteria.object.field_col_name [ll_row]
	ls_tbl_type		=	idw_criteria.object.field_tbl_type [ll_row]
	ls_value			=	idw_criteria.object.field_value [ll_row]
	IF	IsNull (ls_col_name)		&
	OR	Trim (ls_col_name)	=	''		THEN
		// This line has no selected column (This could be the last line).
		Continue
	END IF
	// Determine if this is a main table or a revenue table
	FOR	li_idx	=	1	TO	li_upper
		// is_subset_tbl_type[] contains the list of table types for the subset.
		IF	ls_tbl_type		=	is_subset_tbl_type [li_idx]	THEN
			// This is a main table (not a dependent table)
			is_main_tbl [ll_row]		=	ls_tbl_type
			is_tbl_rel [ll_row]		=	'M'		// Main table
			Exit
		END IF
	NEXT
	IF	is_tbl_rel [ll_row]	<>	'M'	THEN
		// This is a revenue table.  Get the main table associated with
		//	this dependent table.  If there are multiple main tables
		// associated with the dependent table, open w_invoice_type_selection
		// so the user can select the main table.
		ls_main_tbl		=	This.uf_get_main_tbl (ls_tbl_type, ls_col_name)
		IF	Lower (ls_main_tbl)	=	lcs_error		THEN
			Return	-1
		END IF
		is_tbl_rel [ll_row]		=	'D'			// Dependent table
		is_main_tbl [ll_row]		=	ls_main_tbl
	END IF
	// Fill in the timeframe data (if applicable)
	IF	li_timeframe_button	>	0		THEN
		IF	ls_tbl_type		=	ls_timeframe_tbl_type_1		THEN
			is_timeframe_main_tbl_1		=	is_main_tbl [ll_row]
			is_timeframe_tbl_rel_1		=	is_tbl_rel [ll_row]
		END IF
		IF	ls_tbl_type		=	ls_timeframe_tbl_type_2		THEN
			is_timeframe_main_tbl_2		=	is_main_tbl [ll_row]
			is_timeframe_tbl_rel_2		=	is_tbl_rel [ll_row]
		END IF
	END IF
	//	Determine if the column is being compared against itself.
	//	If so, we have a set.
	IF	 ls_value		=	is_same_column		THEN
		// FDG 06/14/00 - ML subsets do not have sets.
		lb_same_column					=	TRUE
		IF	ii_set_num_of_fields		=	0			&
		AND lb_ml_subset				=	FALSE		THEN
			lb_implied_set				=	TRUE
			is_set_tbl_type			=	ls_tbl_type
			is_set_col_name			=	''
			is_set_field_value		=	''
			is_set_field_operator	=	''
		END IF
	END IF
NEXT

// Fill in the Set and TimeFrame dependency.  First, determine if any
//	data on the options tab or in the criteria creates an implied set.

IF	ii_set_num_of_fields		=	0		THEN
	// FDG 06/14/00 - The invoice type cannot be ML
	IF	((ls_patient_ind = 'S'	OR	ls_patient_ind = 'D')	&
	OR	(ls_tooth_ind = 'S'		OR	ls_tooth_ind = 'D')		&
	OR	(ls_day_ind = 'S'			OR	ls_day_ind = 'D'))		&
	AND lb_ml_subset	=	FALSE										THEN
		// Have an implied set (based on same or different)
		lb_implied_set				=	TRUE
		is_set_col_name			=	''
		IF	ll_crit_rowcount		>	0		THEN
			is_set_tbl_type			=	idw_criteria.object.field_tbl_type [1]
		END IF
		is_set_field_value		=	''
		is_set_field_operator	=	''

	END IF
END IF

IF	lb_implied_set			THEN
	li_set_num_of_fields		=	2
ELSE
	li_set_num_of_fields		=	ii_set_num_of_fields
END IF

IF	li_set_num_of_fields		>	0		THEN
	// At least one set exists
	FOR	ll_row	=	1	TO	ll_crit_rowcount
		ls_col_name		=	idw_criteria.object.field_col_name [ll_row]
		ls_tbl_type		=	idw_criteria.object.field_tbl_type [ll_row]
		IF	IsNull (ls_col_name)		&
		OR	Trim (ls_col_name)	=	''		THEN
			// This line has no selected column (This could be the last line).
			Continue
		END IF
		// Fill in the timeframe data (if applicable)
		//IF	li_timeframe_button	>	0		THEN
		//	IF	ls_tbl_type		=	ls_timeframe_tbl_type_1		THEN
		//		is_timeframe_main_tbl_1		=	is_main_tbl [ll_row]
		//		is_timeframe_tbl_rel_1		=	is_tbl_rel [ll_row]
		//	END IF
		//	IF	ls_tbl_type		=	ls_timeframe_tbl_type_2		THEN
		//		is_timeframe_main_tbl_2		=	is_main_tbl [ll_row]
		//		is_timeframe_tbl_rel_2		=	is_tbl_rel [ll_row]
		//	END IF
		//END IF
		//	Fill in the Set data (if applicable)
		IF	is_set_tbl_type	=	ls_tbl_type		THEN
			// This is a main table (not a dependent table)
			// Stars 4.0 note.  The old code moves main_tbl & tbl_rel from
			// arg_pattern_info.fields_group[i].  However, w_sampling_analysis_new
			//	never initializes these values.  Move the values set in
			// the previous loop to the 'set' values.
			is_set_main_tbl		=	is_main_tbl [ll_row]
			is_set_tbl_rel			=	is_tbl_rel [ll_row]
			Exit
		END IF
	NEXT
END IF

IF IsNull( is_set_tbl_type ) THEN is_set_tbl_type = ""	//	10/30/02	GaryR	SPR 3363d

li_upper			=	UpperBound (is_subset_tbl_type)

ll_rowcount		=	idw_criteria.RowCount()

// Get the list of unique invoice types from dw_criteria
li_rc	=	This.uf_load_criteria_tables()

// Get the list of unique invoice types from the selected columns (dw_selected)
li_rc	=	This.uf_load_selected_tables()

// Get the Set tables.  The Set data was loaded in ue_pattern_sql.

ll_rowcount		=	idw_criteria.RowCount()

IF	li_set_num_of_fields		>	0		THEN
	// At least one set exists.
	li_upper		=	This.uf_upperbound_from_tables()
	// Add table for each field in the set.  1st table is added in the 1st step.
	FOR	li_idx	=	1	TO	(li_set_num_of_fields - 1)
		istr_from_tables[li_upper].tbl_type	=	is_set_tbl_type
		istr_from_tables[li_upper].tbl_rel	=	is_set_tbl_rel
		istr_from_tables[li_upper].main_tbl	=	is_set_main_tbl
	NEXT
	CHOOSE CASE is_set_tbl_rel
		CASE 'D'
			//	The set is a dependent table.  Get its main table.
			li_main_tbl_count	=	0
			li_upper				=	UpperBound (istr_from_tables)
			FOR	li_idx	=	1	TO	li_upper
				IF	is_set_main_tbl	=	istr_from_tables[li_upper].tbl_type	THEN
					li_main_tbl_count	++
				END IF
			NEXT
			li_upper		=	This.uf_upperbound_from_tables()
			// Add the main table for each field in the set
			FOR	li_idx	=	1	TO	(li_set_num_of_fields - li_main_tbl_count)
				istr_from_tables[li_upper].tbl_type	=	is_set_main_tbl
				istr_from_tables[li_upper].tbl_rel	=	'M'
				istr_from_tables[li_upper].main_tbl	=	is_set_main_tbl
			NEXT
		CASE 'M'
			// The set is a main table.
			lb_dep_filter	=	FALSE
			FOR	ll_row	=	1	TO	ll_rowcount
				ls_col_name		=	idw_criteria.object.field_col_name [ll_row]
				ls_tbl_type		=	idw_criteria.object.field_tbl_type [ll_row]
				IF	IsNull (ls_col_name)		&
				OR	Trim (ls_col_name)	=	''		THEN
					// This line has no selected column (This could be the last line).
					Continue
				END IF
				IF	is_tbl_rel [ll_row]		=	'D'					&
				AND is_main_tbl [ll_row]	=	is_set_tbl_type	THEN
					lb_dep_filter	=	TRUE
					lb_found			=	FALSE
					// Find the table type in the list of dependent tables
					li_upper		=	UpperBound (lstr_dep_temp)
					FOR	li_idx	=	1	TO	li_upper
						IF	lstr_dep_temp[li_idx].tbl_type	=	ls_tbl_type		THEN
							lb_found	=	TRUE
							Exit
						END IF
					NEXT
					IF	lb_found	=	FALSE		THEN
						// Table type not found in the list of dependent tables.
						//	Add it to the end.
						li_upper		=	UpperBound (lstr_dep_temp)
						li_upper	++
						lstr_dep_temp[li_upper].tbl_type	=	ls_tbl_type
						lstr_dep_temp[li_upper].tbl_rel	=	is_tbl_rel [ll_row]
						lstr_dep_temp[li_upper].main_tbl	=	is_main_tbl [ll_row]
					END IF		// lb_found	=	FALSE
				END IF			//	is_tbl_rel [ll_row]		=	'D' AND ...
			NEXT
			// Per dependent table type, must make sure you have a dependent
			//	table for each main table to join to.
			IF	lb_dep_filter	=	TRUE		THEN
				li_upper		=	UpperBound (lstr_dep_temp)
				FOR	li_idx	=	1	TO	li_upper
					li_dep_tbl_count	=	0
					li_upper2	=	UpperBound (istr_from_tables)
					FOR	li_idx2	=	1	TO	li_upper2
						IF	 istr_from_tables[li_idx2].tbl_type	<>	''			&
						AND istr_from_tables[li_idx2].tbl_rel	=	'D'		&
						AND istr_from_tables[li_idx2].tbl_type	=	lstr_dep_temp[li_idx].tbl_type	&
						AND istr_from_tables[li_idx2].main_tbl	=	is_set_tbl_type		THEN
							li_dep_tbl_count	++
						END IF
					NEXT
					li_upper2	=	This.uf_upperbound_from_tables()
					//	Add the dependent tables to istr_from_tables
					DO WHILE li_set_num_of_fields		>	li_dep_tbl_count
						istr_from_tables[li_upper2].tbl_type	=	lstr_dep_temp[li_idx].tbl_type
						istr_from_tables[li_upper2].tbl_rel		=	lstr_dep_temp[li_idx].tbl_rel
						istr_from_tables[li_upper2].main_tbl	=	lstr_dep_temp[li_idx].main_tbl
						li_dep_tbl_count	++
					LOOP
				NEXT
			END IF		// lb_dep_filter	=	TRUE
	END CHOOSE			//	CASE is_set_tbl_rel
END IF					//	li_set_num_of_fields	>	0

li_upper	=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	CHOOSE CASE	istr_from_tables[li_idx].tbl_rel
		CASE	'D'
			// Dependent table.
			lb_found		=	FALSE
			li_upper2	=	UpperBound (lstr_dep_temp)
			FOR	li_idx2	=	1	TO	li_upper2
				IF	lstr_dep_temp[li_idx2].tbl_type	=	istr_from_tables[li_idx].tbl_type	THEN
					lb_found	=	TRUE
					Exit
				END IF
			NEXT
			IF	lb_found	=	FALSE	THEN
				// not found.  Add it to istr_from_tables.
				IF	li_upper2	>	0		THEN
					IF	lstr_dep_temp[li_upper2].tbl_type	<>	''		THEN
						li_upper2	++
					END IF
				ELSE
					li_upper2	=	1
				END IF	//	li_upper2	>	0
				lstr_dep_temp[li_upper2].tbl_type	=	istr_from_tables[li_idx].tbl_type
				lstr_dep_temp[li_upper2].tbl_rel		=	istr_from_tables[li_idx].tbl_rel
				lstr_dep_temp[li_upper2].main_tbl	=	istr_from_tables[li_idx].main_tbl
			END IF		//	lb_found	=	FALSE
		CASE	'M'
			// Main table.
			lb_found		=	FALSE
			li_upper2	=	UpperBound (lstr_main_temp)
			FOR	li_idx2	=	1	TO	li_upper2
				IF	lstr_main_temp[li_idx2].tbl_type	=	istr_from_tables[li_idx].tbl_type	THEN
					lb_found	=	TRUE
					Exit
				END IF
			NEXT
			IF	lb_found	=	FALSE	THEN
				// not found.  Add it to istr_from_tables.
				IF	li_upper2	>	0		THEN
					IF	lstr_main_temp[li_upper2].tbl_type	<>	''		THEN
						li_upper2	++
					END IF
				ELSE
					li_upper2	=	1
				END IF	//	li_upper2	>	0
				lstr_main_temp[li_upper2].tbl_type	=	istr_from_tables[li_idx].tbl_type
				lstr_main_temp[li_upper2].tbl_rel	=	istr_from_tables[li_idx].tbl_rel
				lstr_main_temp[li_upper2].main_tbl	=	istr_from_tables[li_idx].main_tbl
			END IF		//	lb_found	=	FALSE
	END CHOOSE		//	CASE istr_from_tables[li_idx].tbl_rel
NEXT

// Add the dependent tables to istr_from_tables where applicable

li_upper		=	This.uf_upperbound_from_tables()

li_upper2	=	UpperBound (lstr_dep_temp)
li_upper3	=	UpperBound (lstr_main_temp)

FOR	li_idx	=	1	TO	li_upper2
	lb_found		=	FALSE
	FOR	li_idx2	=	1	TO	li_upper3
		IF	 lstr_dep_temp[li_idx].main_tbl		=	lstr_main_temp[li_idx2].tbl_type		&
		AND lstr_main_temp[li_idx2].tbl_type	<>	'used'										THEN
			lb_found	=	TRUE
			lstr_main_temp[li_idx2].tbl_type		=	'used'
		END IF
	NEXT
	IF	lb_found	=	FALSE		THEN
		// Add to the end of istr_from_tables
		istr_from_tables[li_upper].tbl_type		=	lstr_dep_temp[li_idx].main_tbl
		istr_from_tables[li_upper].tbl_rel		=	'M'
		istr_from_tables[li_upper].main_tbl		=	lstr_dep_temp[li_idx].main_tbl
		li_upper	++
	END IF
NEXT

// Check for timeframe fields
li_idx2	=	0

IF	li_timeframe_button	>	0		THEN
	li_upper		=	This.uf_upperbound_from_tables()
	// Dependent table check
	IF	ls_timeframe_tbl_type_1		<>	''		&
	AND is_timeframe_tbl_rel_1		=	'D'	THEN
		lb_found		=	FALSE
		li_upper2	=	UpperBound (istr_from_tables)
		FOR li_idx	=	1	TO	li_upper2
			IF	ls_timeframe_tbl_type_1	=	istr_from_tables[li_idx].tbl_type	THEN
				IF	li_idx2	=	0		THEN
					lb_found		=	TRUE
					li_idx2	++
					li_time_cnt [li_idx2]	=	li_idx
					Exit
				ELSE
					IF	li_time_cnt [li_idx2]	<>	li_idx	THEN
						lb_found		=	TRUE
						li_idx2	++
						li_time_cnt [li_idx2]	=	li_idx
						Exit
					END IF		//	li_time_cnt [li_idx2]	<>	li_idx
				END IF			// li_idx2	=	0
			END IF				// ls_timeframe_tbl_type_1	=	istr_from_tables[li_idx].tbl_type
			IF	lb_found	=	FALSE		THEN
				istr_from_tables[li_upper].tbl_type	=	ls_timeframe_tbl_type_1
				istr_from_tables[li_upper].tbl_rel	=	is_timeframe_tbl_rel_1
				istr_from_tables[li_upper].main_tbl	=	is_timeframe_main_tbl_1
			END IF				//	lb_found	=	FALSE				
		NEXT
	END IF						//	ls_timeframe_tbl_type_1		<>	'' ...
	IF	ls_timeframe_tbl_type_2		<>	''		&
	AND is_timeframe_tbl_rel_2		=	'D'	THEN
		lb_found		=	FALSE
		li_upper2	=	UpperBound (istr_from_tables)
		FOR li_idx	=	1	TO	li_upper2
			IF	ls_timeframe_tbl_type_2	=	istr_from_tables[li_idx].tbl_type	THEN
				IF	li_idx2	=	0		THEN
					lb_found		=	TRUE
					li_idx2	++
					li_time_cnt [li_idx2]	=	li_idx
					Exit
				ELSE
					IF	li_time_cnt [li_idx2]	<>	li_idx	THEN
						lb_found		=	TRUE
						li_idx2	++
						li_time_cnt [li_idx2]	=	li_idx
						Exit
					END IF		//	li_time_cnt [li_idx2]	<>	li_idx
				END IF			// li_idx2	=	0
			END IF				// ls_timeframe_tbl_type_1	=	istr_from_tables[li_idx].tbl_type
			IF	lb_found	=	FALSE		THEN
				istr_from_tables[li_upper].tbl_type	=	ls_timeframe_tbl_type_2
				istr_from_tables[li_upper].tbl_rel	=	is_timeframe_tbl_rel_2
				istr_from_tables[li_upper].main_tbl	=	is_timeframe_main_tbl_2
			END IF				//	lb_found	=	FALSE				
		NEXT
	END IF						//	ls_timeframe_tbl_type_1		<>	'' ...
	
	// Main table check (For both dependent and main tables).  If there is a 'set'
	//	add an additional entry into istr_from_tables[].
	
	li_time_cnt	=	li_clear_cnt
	li_idx2		=	0
	li_upper		=	This.uf_upperbound_from_tables()
	IF	ls_timeframe_tbl_type_1		<>	''		THEN
		lb_found		=	FALSE
		li_upper2	=	UpperBound (istr_from_tables)
		FOR li_idx	=	1	TO	li_upper2
			IF	ls_timeframe_tbl_type_1	=	istr_from_tables[li_idx].tbl_type	THEN
				IF	li_idx2	=	0		THEN
					lb_found		=	TRUE
					li_idx2	++
					li_time_cnt [li_idx2]	=	li_idx
					Exit
				ELSE
					IF	li_time_cnt [li_idx2]	<>	li_idx	THEN
						lb_found		=	TRUE
						li_idx2	++
						li_time_cnt [li_idx2]	=	li_idx
						Exit
					END IF		//	li_time_cnt [li_idx2]	<>	li_idx
				END IF			// li_idx2	=	0
			END IF				// ls_timeframe_tbl_type_1	=	istr_from_tables[li_idx].tbl_type
		NEXT
		IF	lb_found	=	FALSE		THEN
			istr_from_tables[li_upper].tbl_type	=	is_timeframe_main_tbl_1
			istr_from_tables[li_upper].tbl_rel	=	'M'
			istr_from_tables[li_upper].main_tbl	=	is_timeframe_main_tbl_1
		END IF				//	lb_found	=	FALSE				
	END IF						//	ls_timeframe_tbl_type_1		<>	'' ...
	IF	ls_timeframe_tbl_type_2		<>	''		THEN
		IF	ls_timeframe_tbl_type_1	<>	ls_timeframe_tbl_type_2		THEN
			// Time frame table types don't match.  There is no set.
			li_idx2	=	0
		END IF
		lb_found		=	FALSE
		li_upper2	=	UpperBound (istr_from_tables)
		FOR li_idx	=	1	TO	li_upper2
			IF	ls_timeframe_tbl_type_2	=	istr_from_tables[li_idx].tbl_type	THEN
				IF	li_idx2	=	0		THEN
					lb_found		=	TRUE
					li_idx2	++
					li_time_cnt [li_idx2]	=	li_idx
					Exit
				ELSE
					IF	li_time_cnt [li_idx2]	<>	li_idx	THEN
						lb_found		=	TRUE
						li_idx2	++
						li_time_cnt [li_idx2]	=	li_idx
						Exit
					END IF		//	li_time_cnt [li_idx2]	<>	li_idx
				END IF			// li_idx2	=	0
			END IF				// ls_timeframe_tbl_type_1	=	istr_from_tables[li_idx].tbl_type
		NEXT
		IF	lb_found	=	FALSE		THEN
			istr_from_tables[li_upper].tbl_type	=	is_timeframe_main_tbl_1
			istr_from_tables[li_upper].tbl_rel	=	'M'
			istr_from_tables[li_upper].main_tbl	=	is_timeframe_main_tbl_1
		END IF				//	lb_found	=	FALSE				
	END IF						//	ls_timeframe_tbl_type_1		<>	'' ...

END IF							// li_timeframe_button	>	0

// FDG 06/14/00	Begin

// If a column is being compared against itself for a ML subset,
// then add the other invoice types.

IF	 lb_same_column				&
AND lb_ml_subset					THEN
	li_upper		=	UpperBound (istr_from_tables)
	li_upper2	=	UpperBound (is_subset_tbl_type)
	
	FOR	li_idx	=	1	TO	li_upper2
		lb_found		=	FALSE
		FOR	li_idx2	=	1	TO	li_upper
			IF	 istr_from_tables[li_idx2].tbl_type		=	is_subset_tbl_type [li_idx]	THEN
				lb_found	=	TRUE
				Exit
			END IF
		NEXT
		IF	lb_found	=	FALSE		THEN
			// Add to the end of istr_from_tables
			li_upper	++
			istr_from_tables[li_upper].tbl_type		=	is_subset_tbl_type [li_idx]
			istr_from_tables[li_upper].tbl_rel		=	'M'
			istr_from_tables[li_upper].main_tbl		=	is_subset_tbl_type [li_idx]
		END IF
	NEXT
END IF

// FDG 06/14/00	End

// Error checking for more than 4 tables

li_upper	=	UpperBound (istr_from_tables)

IF	li_upper	>	0		THEN
	IF	istr_from_tables[li_upper].tbl_type	=	''		THEN
		li_upper	--
	END IF
END IF

IF	li_upper	>	lci_max_tables		THEN
	MessageBox ('Selection Error', 'This query will result in a '	+	String (li_upper)	+	&
					' table join.  The system only allows '	+	String (lci_max_tables)		+	&
					' table joins.  Please reselect your criteria.', StopSign!)
	istr_from_tables[li_upper].tbl_type	=	'error'
	Return	-1
END IF

IF	li_upper	>	lci_too_many_tables		THEN
	li_rc	=	MessageBox ('Warning', 'This query will result in a '	+	String (li_upper)	+	&
					' table join.  The query can take a long time to execute.  Do you '		+	&
					'wish to continue?', Question!, YesNo!, 1)
	IF	li_rc	=	2		THEN
		istr_from_tables[li_upper].tbl_type	=	'error'
		Return	-1
	END IF
END IF

// Get table name and aliases

ls_alias	=	'a'

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].tbl_type	<>	''		THEN
		istr_from_tables[li_idx].prefix	=	ls_alias
		ls_alias	=	Char (Asc(ls_alias) + 1)		// Increment the alias (i.e. 'a' to 'b')
		istr_from_tables[li_idx].tbl_name	=	&
					fx_build_subset_table_name (istr_from_tables[li_idx].tbl_type,	&
														is_subset_id)
		// If running in background mode, attach the database to the subset
		IF	ib_background_flag	=	TRUE		THEN
			//	12/04/00	GaryR		Stars 4.7 DataBase Port
//			istr_from_tables[li_idx].tbl_name	=	Upper (Stars2ca.database)	+	'..'	+	&
//																istr_from_tables[li_idx].tbl_name
			istr_from_tables[li_idx].tbl_name	=	&
						gnv_sql.of_get_database_prefix( Upper (Stars2ca.database) ) + &
																istr_from_tables[li_idx].tbl_name
		END IF
	END IF
NEXT


Return	1

end event

event type string ue_pattern_sql();//*********************************************************************************
// Script Name:	ue_pattern_sql
//
//	Arguments:		None
//
// Returns:			String
//						'Error' - An error occured whn generating the SQL
//
//	Description:	Generate the pattern SQL for a Generic pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	05/22/07	GaryR	Track 5033	Remove DISTINCT from select clause
//
//*********************************************************************************

Constant	String	lcs_dep_dep_prefix	=	't'
Constant	String	lcs_dep_main_prefix	=	's'
Constant	String	lcs_error	=	'error'
Constant	String	lcs_prefix	=	'z'
Constant	String	lcs_recip_id	=	'RECIP_ID'		// For 'NOT IN' logic only

Boolean		lb_dep_set,						&
				lb_dep_set_diff,				&
				lb_found,						&
				lb_no_label,					&
				lb_no_prefix

Integer		li_cnt,							&
				li_end_pos,						&
				li_from_cnt,					&
				li_idx,							&
				li_idx2,							&
				li_label_cnt[],				&
				li_pos,							&
				li_pos1,							&
				li_pos2,							&
				li_rc,							&
				li_sequence,					&
				li_upper,						&
				li_upper2

Long			ll_crit_rowcount,				&
				ll_opt_row,						&
				ll_row,							&
				ll_row2,							&
				ll_rowcount
				

String		ls_added_to_sql[],			&
				ls_base_type,					&
				ls_col_name,					&
				ls_col_name1,					&
				ls_col_name2,					&
				ls_dep_prefix,					&
				ls_dep_select,					&
				ls_field_col_name,			&
				ls_field_description,		&
				ls_field_tbl_type,			&
				ls_filter,						&
				ls_first_main_tbl,			&
				ls_from_thru,					&
				ls_label_alias,				&
				ls_label_tbl_type[],			&
				ls_main_tbl_type,				&
				ls_prefix,						&
				ls_order_by_prefix,			&
				ls_return_select,				&
				ls_select,						&
				ls_set_dep_tbl_name,			&
				ls_set_main_tbl_name,		&
				ls_set_type,					&
				ls_sql,							&
				ls_tbl_type,					&
				ls_temp_where,					&
				ls_where[],						&
				ls_where1,						&
				ls_where2

// Structure passed to uf_dep_set_sql
sx_dep_set	lstr_dep_set

SetPointer (HourGlass!)
w_main.SetMicroHelp ('Creating Pattern SQL...')

// Reset flags stating that the column in dw_selected was added to the SQL
is_added_to_sql	=	ls_added_to_sql

// Reset any previous data inserted into ids_report_cols
ids_report_cols.Reset()

// Load the tables in the From clause into istr_from_tables
li_rc	=	This.Event	ue_pattern_from()

IF	li_rc	<	0		THEN
	Return	lcs_error
END IF

li_upper		=	UpperBound (istr_from_tables)

IF	li_upper	>	0			&
AND Lower (istr_from_tables[li_upper].tbl_name)	=	lcs_error		THEN
	Return	lcs_error
END IF

// For each occurrence of istr_from_tables[], initialize ib_multiple_likes[]
This.uf_init_multiple_likes()

// Retrieve the unique keys for all table types
This.uf_retrieve_tbl_type()

// Make sure that the unique key columns are included in the Select clause
//	by moving them from idw_available to idw_selected
li_rc	=	This.Event	ue_select_unique_key_columns()

IF	li_rc	<	0		THEN
	Return	lcs_error
END IF

// Determine if the user has selected a dependent set (Dep set, any in set,
//	and like values).  IF yes, loop through all from tables (istr_from_tables)
// to find the dependent set tables.
li_idx2	=	1

IF	ii_set_num_of_fields	>	0		&
AND is_set_tbl_rel		=	'D'	THEN
	// Get the base type for is_set_main_tbl
	ls_filter	=	"rel_type = 'QT' and id_2 = '"	+	is_set_main_tbl	+	"'"
	li_rc	=	w_main.dw_stars_rel_dict.SetFilter('')
	li_rc	=	w_main.dw_stars_rel_dict.Filter()
	li_rc	=	w_main.dw_stars_rel_dict.SetFilter(ls_filter)
	li_rc	=	w_main.dw_stars_rel_dict.Filter()
	ll_rowcount	=	w_main.dw_stars_rel_dict.RowCount()
	IF	ll_rowcount		>	0		THEN
		ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]
		IF	ls_base_type	=	'1500'		THEN
			FOR	ll_row	=	1	TO	ll_crit_rowcount
				ls_where1		=	is_where_clause [ll_row]
				ls_col_name1	=	idw_criteria.object.field_col_name [ll_row]
				// Loop thru all remaining rows and compare with the current row
				FOR	ll_row2	=	ll_row + 1	TO	ll_crit_rowcount
					ls_where2	=	is_where_clause [ll_row2]
					ls_col_name2	=	idw_criteria.object.field_col_name [ll_row2]
					IF	ls_col_name1	=	ls_col_name2			&
					AND ls_col_name1	=	is_set_col_name		THEN
						IF	Match (ls_where1, ls_where2)			THEN
							IF	Match (ls_where1, ',')				THEN
								// A comma is found in ls_where1.  Break up ls_where1
								// into multiple where clauses and place into ls_where[]
								DO
									li_pos1	=	Pos (ls_where1, "'")	// Find ' in ls_where1
									IF	li_pos1	=	0		THEN
										// Can't find a quote, find (
										li_pos1	=	Pos (ls_where1, "(")
									END IF
									li_pos2	=	Pos (ls_where1, ",")
									IF	li_pos2	=	0		THEN
										li_pos2	=	Pos (ls_where1, ")")
									END IF
									li_end_pos	=	li_pos2	-	li_pos1
									ls_where [li_idx2]	=	Mid (ls_where1, li_pos1, li_end_pos)
									IF	ls_where [li_idx2]	=	''		THEN
										Exit
									END IF
									li_idx2	++
									ls_where1	=	Mid (ls_where1, li_pos2 + 1)
								LOOP	UNTIL	li_pos2	=	0
							ELSE		
								// No comma found in ls_where1.  Move ls_where1 into ls_where[]
								// after trimming the spaces.
								li_pos1	=	Pos (ls_where1, ' ')
								ls_temp_where	=	Trim (Mid(ls_where1, li_pos1))
								li_pos1	=	Pos (ls_temp_where, ' ')
								li_idx2	++
								ls_where [li_idx2]	=	Trim (Mid(ls_temp_where, li_pos1))
							END IF	// Match (ls_where1, ',')
							lb_dep_set			=	TRUE
							lb_dep_set_diff	=	FALSE
						ELSE
							// ls_where1 and ls_where2 do not match
							IF	lb_dep_set	=	FALSE		THEN
								lb_dep_set_diff	=	TRUE
							END IF
						END IF		// Match (ls_where1, ls_where2)
						IF	Match (ls_where2, ',')		THEN
							DO
								li_pos1	=	Pos (ls_where2, "'")	// Find ' in ls_where2
								IF	li_pos1	=	0		THEN
									// Can't find a quote, find (
									li_pos1	=	Pos (ls_where2, "(")
								END IF
								li_pos2	=	Pos (ls_where2, ",")
								IF	li_pos2	=	0		THEN
									li_pos2	=	Pos (ls_where2, ")")
								END IF
								li_end_pos	=	li_pos2	-	li_pos1
								ls_temp_where	=	Mid (ls_where2, li_pos1, li_end_pos)
								IF	Match (ls_where1, ls_temp_where)		THEN
									lb_dep_set			=	TRUE
									lb_dep_set_diff	=	FALSE
									ls_where [li_idx2]	=	ls_temp_where
									IF	ls_where [li_idx2]	=	''		THEN
										Exit
									END IF
									li_idx2	++
								ELSE
									// ls_where1 and ls_where2 do not match
									IF	lb_dep_set	=	FALSE		THEN
										lb_dep_set_diff	=	TRUE
									END IF
								END IF	// Match (ls_where1, ls_temp_where)
								ls_where2	=	Mid (ls_where2, li_pos2 + 1)
							LOOP	UNTIL	li_pos2	=	0
						ELSE
							// No comma found in ls_where2
							DO
								li_pos1	=	Pos (ls_where1, "'")	// Find ' in ls_where1
								IF	li_pos1	=	0		THEN
									// Can't find a quote, find (
									li_pos1	=	Pos (ls_where1, "(")
								END IF
								li_pos2	=	Pos (ls_where1, ",")
								IF	li_pos2	=	0		THEN
									li_pos2	=	Pos (ls_where1, ")")
								END IF
								li_end_pos	=	li_pos2	-	li_pos1
								ls_temp_where	=	Mid (ls_where1, li_pos1, li_end_pos)
								IF	Match (ls_where2, ls_temp_where)		THEN
									lb_dep_set			=	TRUE
									lb_dep_set_diff	=	FALSE
									ls_where [li_idx2]	=	ls_temp_where
									IF	ls_where [li_idx2]	=	''		THEN
										Exit
									END IF
									li_idx2	++
								ELSE
									// ls_where1 and ls_where2 do not match
									IF	lb_dep_set	=	FALSE		THEN
										lb_dep_set_diff	=	TRUE
									END IF
								END IF	// Match (ls_where1, ls_temp_where)
								ls_where1	=	Mid (ls_where1, li_pos2 + 1)
							LOOP	UNTIL	li_pos2	=	0
							IF	lb_dep_set		THEN
								Exit
							END IF
						END IF			//	Match (ls_where2, ',')
					END IF				//	ls_col_name1	=	ls_col_name2 AND ls_col_name1	=	is_set_col_name
				NEXT						//	ll_row2 = ll_row + 1	TO	ll_crit_rowcount
			NEXT							// ll_row =	1	TO	ll_crit_rowcount
		END IF							// ls_base_type =	'1500'
	END IF								// ll_rowcount	>	0 (for w_main.dw_stars_rel_dict)
END IF									// ii_set_num_of_fields	>	0 AND is_set_tbl_rel	=	'D'

// If a dependent set exists, cannot do a 'NOT IN'

IF	lb_dep_set		THEN
	IF	ib_not_flag		THEN
		MessageBox ('WARNING', 'Unable to perform NOT on sets of dependent fields '	+	&
						'with the same values.  Please remove the NOT or change SET '		+	&
						'values to be different.')
		Return	lcs_error
	ELSE
		IF	ib_background_flag	=	FALSE		THEN
			// Not running in background
			li_rc	=	MessageBox ('WARNING', 'This Pattern will run slowly since it '	+	&
										'contains sets of dependent fields with the same '		+	&
										'values.  Do you wish to continue?', Question!, YesNo!, 1)
			IF	li_rc	=	2		THEN
				Return	lcs_error
			END IF
		ELSE
			// Running in background mode
			This.uf_set_union_flag (TRUE)
			Return	''
		END IF		// ib_background_flag	=	FALSE
	END IF			//	ib_not_flag
END IF				//	lb_dep_set

ls_from_thru	=	This.Event	ue_pattern_where (lb_dep_set_diff)

IF	Upper (ls_from_thru)	=	'ERROR'	THEN
	Return	lcs_error
END IF

IF	ib_not_flag	=	FALSE	THEN
	// 'NOT IN' was NOT checked
	li_upper			=	UpperBound (istr_from_tables)
	ls_select	=	'select '
	ls_dep_select	=	'select '
	
	li_from_cnt		=	1
	li_sequence		=	1
	
	DO	WHILE	li_from_cnt	<=	li_upper
		FOR	li_idx	=	1	TO	li_upper
			IF	istr_from_tables[li_idx].select_seq	=	li_sequence		THEN
				lb_found		=	FALSE
				li_upper2	=	UpperBound (ls_label_tbl_type)
				FOR	li_idx2	=	1	TO	li_upper2
					IF	istr_from_tables[li_idx].tbl_type	=	ls_label_tbl_type [li_idx2]	THEN
						lb_found	=	TRUE
						li_label_cnt[li_idx2]	++
						li_cnt	=	li_label_cnt[li_idx2]
						ls_label_alias	=	ls_label_tbl_type [li_idx2]	+	String (li_cnt)
						Exit
					END IF			//	istr_from_tables[li_idx].tbl_type =	ls_label_tbl_type [li_idx2]
				NEXT					// li_idx2	=	1	TO	li_upper2
				IF	lb_found	=	FALSE		THEN
					li_upper2	=	UpperBound (ls_label_tbl_type)
					IF	li_upper2	>	0		THEN
						IF	ls_label_tbl_type [li_upper2]	<>	''	THEN
							li_upper2	++
						END IF
					ELSE
						li_upper2	=	1
					END IF			//	li_upper2	>	0
					ls_label_tbl_type [li_upper2]	=	istr_from_tables[li_idx].tbl_type
					li_label_cnt [li_upper2]		=	1
					li_cnt								=	li_label_cnt [li_upper2]
					ls_label_alias						=	ls_label_tbl_type [li_upper2]	+	String (li_cnt)
				END IF				// lb_found	=	FALSE
				ls_prefix		=	istr_from_tables[li_idx].prefix
				lb_no_prefix	=	TRUE
				IF	lb_dep_set				THEN
					IF	istr_from_tables[li_idx].tbl_type	=	is_set_tbl_type		THEN
						IF	li_cnt	=	1		THEN
							lb_no_label		=	FALSE
							ls_set_dep_tbl_name	=	istr_from_tables[li_idx].tbl_name
							ls_set_type				=	'D'
						END IF		//	li_cnt	=	1
					ELSE
						IF	istr_from_tables[li_idx].tbl_type	=	is_set_main_tbl	THEN
							IF	li_cnt	=	1		THEN
								lb_no_label		=	FALSE
								ls_set_main_tbl_name	=	istr_from_tables[li_idx].tbl_name
								ls_order_by_prefix	=	istr_from_tables[li_idx].prefix
								ls_set_type				=	'M'
							END IF	//	li_cnt	=	1
						END IF		//	istr_from_tables[li_idx].tbl_type	=	is_set_main_tbl
					END IF			//	istr_from_tables[li_idx].tbl_type	=	is_set_tbl_type
				END IF				//	lb_dep_set
				ls_return_select	=	This.Event	ue_pattern_select (istr_from_tables[li_idx].tbl_type,	&
															istr_from_tables[li_idx].prefix,	&
															ls_label_alias,	&
															lb_no_label,		&
															ls_set_type)
				IF	ls_return_select	=	':'	THEN
					ls_return_select	=	''
				END IF
				IF	ls_return_select	<>	''		THEN
					li_pos	=	Pos (ls_return_select, ':')
					ls_select	=	ls_select	+	Left (ls_return_select, li_pos - 1)	+	','
					ls_dep_select	=	ls_dep_select	+	Mid (ls_return_select, li_pos + 1)	+	','
				END IF				//	ls_return_select	<>	''
				FOR	ll_row	=	1	TO	ll_crit_rowcount
					ls_field_col_name		=	idw_criteria.object.field_col_name [ll_row]
					ls_field_tbl_type		=	idw_criteria.object.field_tbl_type [ll_row]
					ls_field_description	=	idw_criteria.object.field_description [ll_row]
					IF	istr_from_tables[li_idx].tbl_type	=	ls_field_tbl_type	THEN
						IF NOT Match (ls_select, ls_prefix + '.' + ls_field_col_name)	THEN
							ls_select	=	ls_select	+	&
												istr_from_tables[li_idx].prefix	+	&
												"."	+	ls_field_col_name			+	&
												' "'	+	ls_label_alias	+	" "	+	&
												ls_field_description	+	'",'
							IF	lb_no_label		THEN
								ls_dep_select	=	ls_dep_select	+	"'',"
							ELSE
								IF	is_tbl_rel [ll_row]	=	'D'		THEN
									ls_dep_prefix	=	lcs_dep_dep_prefix
								ELSE
									ls_dep_prefix	=	lcs_dep_main_prefix
								END IF	//	is_tbl_rel [ll_row]	=	'D'
								ls_dep_select	=	ls_dep_select	+	ls_dep_prefix	+	&
														"."	+	ls_field_col_name			+	&
														' "'	+	ls_label_alias	+	" "	+	&
														ls_field_description	+	'",'
							END IF	//	lb_no_label
						END IF		//	NOT Match (ls_select, ls_prefix + '.' + ls_field_col_name)
					END IF			//	istr_from_tables[li_idx].tbl_type =	idw_criteria.object.field_tbl_type [ll_row]
				NEXT					//	ll_row =	1	TO	ll_crit_rowcount
			END IF					//	istr_from_tables[li_idx].select_seq	=	li_sequence
		NEXT							//	li_idx =	1	TO	li_upper
		li_sequence	++
		li_from_cnt	++
	LOOP								//	WHILE	li_from_cnt	<=	li_upper
	ls_select		=	Left (ls_select, Len(ls_select) - 1)
	ls_dep_select	=	Left (ls_dep_select, Len(ls_dep_select) - 1)
	// Add the remaining columns from dw_selected to the Select clause
	ls_select		=	This.Event	ue_pattern_select_add_selected (ls_select)
ELSE
	// 'NOT IN' was checked
	li_upper		=	UpperBound (istr_from_tables)
	FOR	li_idx	=	1	TO	li_upper
		IF	istr_from_tables[li_idx].tbl_rel	=	'M'		THEN
			ls_first_main_tbl	=	istr_from_tables[li_idx].prefix
			Exit
		END IF						//	istr_from_tables[li_idx].tbl_rel = 'M'
	NEXT
	ls_select	=	ls_select	+	lcs_prefix	+	'.'	+	&
						lcs_recip_id	+	' NOT IN (select '	+	&
						ls_first_main_tbl	+	'.'	+	lcs_recip_id
END IF								//	ib_not_flag	=	FALSE

// Get the 'From' clause from istr_from_tables

ls_sql		=	' FROM '

li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].tbl_name	<>	''		THEN
		ls_sql	=	ls_sql	+	istr_from_tables[li_idx].tbl_name	+	&
						' '	+	istr_from_tables[li_idx].prefix	+	', '
	END IF						//	istr_from_tables[li_idx].tbl_name <> ''
NEXT

ls_sql	=	Left (ls_sql, Len(ls_sql) - 2)	// Remove the trailing ', '

// Get the 'Where' clause from is_where[] (set in ue_pattern_where)

ls_sql	=	ls_sql	+	' WHERE '

li_upper	=	UpperBound (is_where)

FOR	li_idx	=	1	TO	li_upper
	IF	is_where [li_idx]	<>	''		THEN
		ls_sql	=	ls_sql	+	is_where[li_idx]	+	' AND '
	END IF
NEXT

// Remove the trailing 'AND '
ls_sql	=	Left (ls_sql, Len(ls_sql) - 4)

// Concatenate the Select, From and Where clauses
ls_sql	=	Upper (ls_select	+	ls_sql)

IF	lb_dep_set		THEN
	// Create the Union SQL for a dependent set
	lstr_dep_set.col_name		=	is_set_col_name
	lstr_dep_set.tbl_type		=	is_set_tbl_type
	lstr_dep_set.main_tbl		=	is_set_main_tbl
	lstr_dep_set.main_tbl_name	=	ls_set_main_tbl_name
	lstr_dep_set.values			=	ls_where
	lstr_dep_set.subc_id			=	is_subset_id
	ls_sql	=	This.uf_dep_set_sql (ls_sql,					&
												ls_dep_select,			&
												lstr_dep_set,			&
												ls_order_by_prefix)
	This.uf_set_union_flag (TRUE)				// Set ib_union_flag
END IF

IF	ib_not_flag		THEN
	ls_sql	=	ls_sql	+	")"
	ls_sql	=	This.uf_pattern_sql_not (ls_sql)
	IF	Lower (ls_sql)	=	lcs_error		THEN
		Return	lcs_error
	END IF
END IF

w_main.SetMicroHelp ('Pattern SQL Created. ')
ls_sql	=	Upper (ls_sql)


Return	ls_sql

end event

event type string ue_pattern_where(boolean ab_dep_set_diff);//*********************************************************************************
// Script Name:	ue_pattern_where
//
//	Arguments:		ab_dep_set_diff
//
// Returns:			String
//
//	Description:	Generate the pattern SQL Where clause for a Generic pattern.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/14/00	FDG	Track 2924c (4.5 SP1).  For a ML generic pattern, do not join
//						onto itself (create a 'set').
//	09/21/00	FDG	Track 2993c (4.5 SP1).  When using is_where_clause[li_idx3] 
//						& ib_multiple_likes[], compare li_idx3 with the UpperBound 
//						of is_where_clause[].  There are time where is_where_clause & 
//						ib_multiple_likes is not initially filled in (i.e. when using 
//						'##' and when using 'Days').
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//	05/31/07	GaryR	Track 5044	Add revenue line criteria for all claim comparisons
//
//*********************************************************************************

Constant	Integer	lci_ab					=	4			//	Timeframe #4 = Part B within Part A
Constant	String	lcs_main_join_field	=	'RECIP_ID'
Constant	String	lcs_from_date			=	'FROM_DATE'
Constant	String	lcs_tooth				=	'TOOTH'
Constant	String	lcs_error				=	'Error'

Boolean	lb_compare,						&
			lb_exact,						&
			lb_in_set,						&
			lb_in_timeframe,				&
			lb_not_found,					&
			lb_this_tbl,					&
			lb_ml_subset

Integer	li_idx,							&
			li_idx2,							&
			li_idx3,							&
			li_idx4,							&
			li_idx5,							&
			li_idx6,							&
			li_main_tbl_cnt,				&
			li_nbr_rows,					&
			li_num_of_timeframes,		&
			li_rev_lines[],				&
			li_rc,							&
			li_rc2,							&
			li_select_seq,					&
			li_tbls,							&
			li_temp,							&
			li_temp_2,						&
			li_timeframe_button,			&
			li_timeframe_num_of_days,	&
			li_upper,						&
			li_upper1,						&
			li_upper2,						&
			li_upper3,						&
			li_upper4,						&
			li_upper_where,				&
			li_used[],						&
			li_where_in_where

Long		ll_opt_row,						&
			ll_row,							&
			ll_fields,						&
			ll_rowcount

String	ls_allwd_srvc_ind,			&
			ls_base_type,					&
			ls_claim_ind,					&
			ls_cnt_tbls[],					&
			ls_combination_ind,			&
			ls_compare_col_name,			&
			ls_compare_operator,			&
			ls_compare_tbl_type,			&
			ls_compare_value,				&
			ls_day_ind,						&
			ls_domestic_dep_alias[],	&
			ls_domestic_main_alias[],	&
			ls_dwfilter,					&
			ls_field_col_name,			&
			ls_field_operator,			&
			ls_field_tbl_type,			&
			ls_field_value,				&
			ls_op,							&
			ls_patient_ind,				&
			ls_prefix,						&
			ls_rc,							&
			ls_rel_op,						&
			ls_same_different,			&
			ls_tbl_type,					&
			ls_timeframe_column[],		&
			ls_timeframe_main_tbl[],	&
			ls_timeframe_tbl_rel[],		&
			ls_timeframe_tbl_type[],	&
			ls_tooth_ind,					&
			ls_type_select,				&
			ls_units_allowed,				&
			ls_where

sx_field_array	lstr_set_array[],		&
					lstr_timeframe_array[]

SetPointer (HourGlass!)
w_main.SetMicroHelp ('Creating Pattern SQL... (where)')

// Get the timeframe data
ll_opt_row	=	idw_patt_options.GetRow()

IF	ll_opt_row	<	1		THEN
	MessageBox ('Application Error', 'In u_nvo_pattern_sql.ue_pattern_where, '	+	&
					'cannot get the current row in idw_patt_options.')
	Return	lcs_error
END IF

// FDG 09/21/00 - Get the UpperBound of is_where_clause[]
li_upper_where	=	UpperBound(is_where_clause)

// FDG 06/14/00	Determine if this subset is a ML
lb_ml_subset	=	This.uf_is_ml()

li_timeframe_button			=	idw_patt_options.object.timeframe_button [ll_opt_row]
li_timeframe_num_of_days	=	idw_patt_options.object.timeframe_num_of_days [ll_opt_row]
ls_timeframe_tbl_type[1]	=	idw_patt_options.object.timeframe_tbl_type_1 [ll_opt_row]
ls_timeframe_tbl_type[2]	=	idw_patt_options.object.timeframe_tbl_type_2 [ll_opt_row]
ls_timeframe_column[1]		=	idw_patt_options.object.timeframe_column_1 [ll_opt_row]
ls_timeframe_column[2]		=	idw_patt_options.object.timeframe_column_2 [ll_opt_row]
ls_claim_ind					=	idw_patt_options.object.claim_ind [ll_opt_row]
ls_day_ind						=	idw_patt_options.object.day_ind [ll_opt_row]
ls_patient_ind					=	idw_patt_options.object.patient_ind [ll_opt_row]
ls_combination_ind			=	idw_patt_options.object.combination_ind [ll_opt_row]
ls_allwd_srvc_ind				=	idw_patt_options.object.allwd_srvc_ind [ll_opt_row]
ls_tooth_ind					=	idw_patt_options.object.tooth_ind [ll_opt_row]
ls_timeframe_main_tbl[1]	=	is_timeframe_main_tbl_1
ls_timeframe_main_tbl[2]	=	is_timeframe_main_tbl_2
ls_timeframe_tbl_rel[1]		=	is_timeframe_tbl_rel_1
ls_timeframe_tbl_rel[2]		=	is_timeframe_tbl_rel_2

// Will need the number of tables in the from clause thru out the function
li_tbls	=	UpperBound (istr_from_tables)
IF li_tbls <> 0 THEN
	IF istr_from_tables[li_tbls].tbl_type = '' THEN
		li_tbls --
	END IF
END IF

// Will need the number of fields in the fields group thru out the function
ll_fields	=	idw_criteria.RowCount() 
IF ll_fields <> 0 THEN
	ls_field_tbl_type	=	idw_criteria.object.field_tbl_type [ll_fields]
	IF ls_field_tbl_type	=	''		THEN
		ll_fields --
	END IF
END IF

// Fill in set info: fill set array with set fields and their corresponding table prefixes
// and put the set filters into the where clause array
li_temp = 0
li_where_in_where = UpperBound (is_where)
IF li_where_in_where <> 0 THEN
	IF is_where[li_where_in_where] <> '' THEN
		li_where_in_where++
	END IF
ELSE
	li_where_in_where = 1
END IF
li_idx4 = li_where_in_where

IF ii_set_num_of_fields > 0 THEN  //IF there is a set
	FOR li_idx = 1 to ii_set_num_of_fields
		lstr_set_array[li_idx].field		=	is_set_col_name
		lstr_set_array[li_idx].tbl_rel	=	is_set_tbl_rel
		lstr_set_array[li_idx].operator	=	is_set_field_operator
		FOR li_idx2 = 1 to li_tbls  //get prefix
			IF is_set_tbl_type = istr_from_tables[li_idx2].tbl_type &
			AND li_temp < li_idx2 THEN
				lstr_set_array[li_idx].tbl_alias = istr_from_tables[li_idx2].prefix					
				FOR li_idx3 = 1 to ll_fields
					ls_field_col_name	=	idw_criteria.object.field_col_name [li_idx3]
					IF is_set_col_name = ls_field_col_name		&
					AND li_temp_2 < li_idx3 THEN
						// FDG 09/21/00 - Only use is_where_clause & ib_multiple_likes when applicable
						IF	li_idx3	<=	li_upper_where		THEN
							IF ib_multiple_likes[li_idx3] THEN
								li_rc = This.uf_multiple_likes (is_where_clause[li_idx3],	&
																		ls_field_col_name,				&
																		istr_from_tables[li_idx2].prefix)
								IF li_rc = 0 THEN
									is_where[li_idx4] = is_where_clause[li_idx3]
								ELSE
									MessageBox ('Error','Error creating SQL with multiple likes.')
									Return	lcs_error
								END IF
							ELSE		
								is_where[li_idx4]	=	istr_from_tables[li_idx2].prefix + '.' + &
															is_where_clause[li_idx3]
							END IF
							li_temp_2 = li_idx3
							li_idx4++
							Exit
						END IF
					END IF					
				NEXT
				li_temp = li_idx2
				Exit
			END IF
		NEXT
	NEXT
END IF

// Check to see if the where clauses of the set are equal, if they are will have to
// change duplication check below so don't get a.1,b.2 and b.2,a.1
IF ls_combination_ind = 'D' &
OR ab_dep_set_diff 						THEN  
	// Select different in set.  Set all filter fields <> to each other
	li_idx = UpperBound (lstr_set_array)
	IF li_idx <> 0 THEN
		IF lstr_set_array[li_idx].field = '' THEN li_idx --
	ELSE
		li_idx = 1
	END IF
	li_idx4 = UpperBound (is_where)
	IF li_idx4 <> 0 THEN
		IF is_where[li_idx4] <> '' THEN li_idx4++
	ELSE 
		li_idx4 = 1
	END IF
	FOR li_idx2 = 1 to li_idx - 1
		FOR li_idx3 = li_idx2 + 1 to li_idx
			is_where[li_idx4] =	lstr_set_array[li_idx2].tbl_alias +	"."	+	&
										lstr_set_array[li_idx2].field	+ " <> "  +	&
										lstr_set_array[li_idx3].tbl_alias	+	&
										"."	+	lstr_set_array[li_idx3].field 
			li_idx4++
		NEXT
	NEXT
ELSEIF ls_combination_ind = 'A' AND ls_claim_ind = 'A' THEN
	//to get rid of duplication (same row = same row)
	li_idx3 = UpperBound (is_where)
	IF li_idx3 <> 0 THEN
		IF is_where[li_idx3] <> '' THEN	li_idx3++
	ELSE
		li_idx3 = 1
	END IF
   li_upper1 = UpperBound (istr_from_tables)  
	FOR li_idx = 1 to li_upper1
		FOR li_idx2 = li_idx + 1 to li_upper1    
			IF istr_from_tables[li_idx].tbl_type = istr_from_tables[li_idx2].tbl_type &
			AND istr_from_tables[li_idx].tbl_rel = 'M' THEN
				ls_where				=	This.uf_where_claim (ls_claim_ind, li_idx, li_idx2)
				IF	Len (ls_where)	>	0		THEN
					is_where[li_idx3] =	ls_where
					li_idx3	++
				ELSE
					Return	lcs_error
				END IF
			END IF
		NEXT
	NEXT	
END IF
			

// Get join info
// **the dep and main join fields are currently hardcoded, if should ever change
// **will have to add to WIN PARM


// Join dep to main: put relationship of dep and main tables into domestic join array
// by prefix and add where clause joining dep to main table
li_idx3 = UpperBound (is_where)
IF li_idx3 <> 0 THEN
	IF is_where[li_idx3] <> '' THEN li_idx3 ++
ELSE 
	li_idx3 = 1
END IF
li_idx4 = 1
li_idx6 = 1
FOR li_idx = 1 to li_tbls
	IF istr_from_tables[li_idx].tbl_rel = 'D' THEN
		FOR li_idx2 = 1 to li_tbls
			IF istr_from_tables[li_idx].main_tbl = istr_from_tables[li_idx2].tbl_type THEN
				lb_this_tbl = true
            li_upper1 = UpperBound (li_used)  
				FOR li_idx5 = 1 to li_upper1    
					IF li_used[li_idx5] = li_idx2 THEN  // Main table already used by another dep table
						lb_this_tbl = false
					END IF
				NEXT
				li_used[li_idx4] = li_idx2
				li_idx4 ++
				IF lb_this_tbl THEN 
					ls_where				=	This.uf_where_rev_claim( li_idx, li_idx2 )
					IF	Len (ls_where)	>	0		THEN
						is_where[li_idx3] =	ls_where
						ls_domestic_dep_alias[li_idx6] = istr_from_tables[li_idx].prefix
						ls_domestic_main_alias[li_idx6] = istr_from_tables[li_idx2].prefix
						li_idx6++
						li_idx3	++
						li_upper ++
						li_rev_lines[li_upper] = li_idx
						Exit
					END IF
				END IF
			END IF
		NEXT
	END IF
NEXT

//	Add revenue line criteria
IF UpperBound( li_rev_lines ) = 2 THEN	
	ls_where	=	This.uf_where_rev_line( li_rev_lines[1], li_rev_lines[2] )
	IF Trim( ls_where ) <> "" THEN
		is_where[li_idx3] =	ls_where
		li_idx3	++
	END IF
END IF

// Join Main to Main: put relationship of main tables into foreign join array by
// prefixes and add where cluases joining main tables

FOR li_idx = 1 to li_tbls  // Fill ls_cnt_tbls with all different invoice types
	IF istr_from_tables[li_idx].tbl_rel = 'M' THEN
		lb_not_found = true
      li_upper1 = UpperBound (ls_cnt_tbls)  
		FOR li_idx2 = 1 to li_upper1               
			IF istr_from_tables[li_idx].tbl_type = ls_cnt_tbls[li_idx2] THEN
				lb_not_found = false
				Exit
			END IF
		NEXT
		IF lb_not_found THEN
			li_idx2 = UpperBound (ls_cnt_tbls)
			IF li_idx2 <> 0 THEN
				IF ls_cnt_tbls[li_idx2] <> '' THEN li_idx2++
			ELSE
				li_idx2 = 1
			END IF
			ls_cnt_tbls[li_idx2] = istr_from_tables[li_idx].tbl_type
		END IF
	END IF			
NEXT

li_main_tbl_cnt = UpperBound (ls_cnt_tbls)
IF li_main_tbl_cnt <> 0 THEN
	IF ls_cnt_tbls[li_main_tbl_cnt] = '' THEN li_main_tbl_cnt --
ELSE
	li_main_tbl_cnt = 1
END IF

//	IF more than one invoice type, must join
IF li_main_tbl_cnt > 1 THEN  
	li_idx3 = 1
	li_idx4 = UpperBound (is_where)
	IF li_idx4 <> 0 THEN
		IF is_where[li_idx4] <> '' THEN li_idx4 ++
	ELSE
		li_idx4 = 1
	END IF
	FOR li_idx = 1 to li_tbls
		IF istr_from_tables[li_idx].tbl_rel = 'M' THEN
			FOR li_idx2 = li_idx + 1 to li_tbls
				IF istr_from_tables[li_idx2].tbl_rel = 'M' THEN
					IF istr_from_tables[li_idx].tbl_type <> istr_from_tables[li_idx2].tbl_type THEN
						//ls_foreign_main_alias1[li_idx3] = istr_from_tables[li_idx].prefix  // Not used
						//ls_foreign_main_alias2[li_idx3] = istr_from_tables[li_idx2].prefix  // not used
						is_where[li_idx4] =	istr_from_tables[li_idx].prefix	+	'.'	+	&
													lcs_main_join_field	+	' = '	+	&
													istr_from_tables[li_idx2].prefix	+	'.'	+	lcs_main_join_field
						li_idx3++						
						li_idx4 ++
					END IF
				END IF
			NEXT
		END IF
	NEXT				
END IF	

// Get timeframe fields: fill timeframe array with timeframe fields and their corresponding
// table prefixes

IF  li_timeframe_button <> 0			&
AND li_timeframe_button <> lci_ab	THEN
	li_num_of_timeframes = 2
	IF ls_timeframe_tbl_type[li_num_of_timeframes] = '' THEN 
		li_num_of_timeframes --
	END IF
	// Set array to size of num of timeframes
	lstr_timeframe_array[li_num_of_timeframes].tbl_alias = ''  
	li_temp = 0 
	// 1st see if timeframe is a set field (do set fields first, but
	// must be kept in order in the lstr_set_array
	FOR li_idx = 1 to li_num_of_timeframes  
		lb_in_set = false               
      li_upper1 = UpperBound (lstr_set_array)  
		FOR li_idx2 = 1 to li_upper1                
			IF ls_timeframe_column[li_idx] = lstr_set_array[li_idx2].field THEN
				IF li_temp <> li_idx2 THEN
					li_temp = li_idx2
					lb_in_set = true
					Exit
				END IF
			END IF
		NEXT
		IF lb_in_set THEN
			// If dep, get corresponding main table from domestic join array
			IF lstr_set_array[li_idx2].tbl_rel = 'D' THEN  
            li_upper1 = UpperBound (ls_domestic_dep_alias) 
				FOR li_idx3 = 1 to li_upper1    
					IF lstr_set_array[li_idx2].tbl_alias = ls_domestic_dep_alias[li_idx3] THEN
						lstr_timeframe_array[li_idx].tbl_alias = ls_domestic_main_alias[li_idx3]
						lstr_timeframe_array[li_idx].field = ls_timeframe_column[li_idx]
						lstr_timeframe_array[li_idx].tbl_type = ls_timeframe_main_tbl[li_idx]
						Exit
					END IF
				NEXT
			ELSE
				lstr_timeframe_array[li_idx].tbl_alias = lstr_set_array[li_idx2].tbl_alias
				lstr_timeframe_array[li_idx].field = ls_timeframe_column[li_idx]
				lstr_timeframe_array[li_idx].tbl_type = ls_timeframe_main_tbl[li_idx]
			END IF
		END IF
	NEXT
	// Get rest of timeframe fields not in the set - must do Dep fields 1st
	FOR li_idx = 1 to li_num_of_timeframes  
		// For dep must get main table for timeframes
		IF lstr_timeframe_array[li_idx].tbl_alias = '' THEN    
         li_upper1 = UpperBound (istr_from_tables) 
			FOR li_idx2 = 1 to li_upper1    
				IF ls_timeframe_tbl_type[li_idx] = istr_from_tables[li_idx2].tbl_type THEN
					IF ls_timeframe_tbl_rel[li_idx] = 'D' THEN
						lb_in_timeframe = false
						FOR li_idx3 = 1 to li_num_of_timeframes
                     li_upper2 = UpperBound (ls_domestic_dep_alias)    
							FOR li_idx4 = 1 to li_upper2   
								IF istr_from_tables[li_idx2].prefix = ls_domestic_dep_alias[li_idx4] THEN
									ls_prefix = ls_domestic_main_alias[li_idx4]
									Exit
								END IF
							NEXT
							IF lstr_timeframe_array[li_idx3].tbl_alias = ls_prefix THEN
								lb_in_timeframe = true
								Exit
							END IF
						NEXT
						IF NOT lb_in_timeframe THEN
                     li_upper2 = UpperBound (ls_domestic_dep_alias) 
							FOR li_idx3 = 1 to li_upper2  
								IF istr_from_tables[li_idx2].prefix = ls_domestic_dep_alias[li_idx3] THEN
									lstr_timeframe_array[li_idx].tbl_alias = ls_domestic_main_alias[li_idx3]
									lstr_timeframe_array[li_idx].field = ls_timeframe_column[li_idx]
									lstr_timeframe_array[li_idx].tbl_type = ls_timeframe_main_tbl[li_idx]
									Exit
								END IF
							NEXT						
							IF lstr_timeframe_array[li_idx].tbl_alias <> '' THEN 
								Exit	 //if filled above, THEN go to NEXT timeframe			
							END IF
						END IF
					END IF
				END IF
			NEXT
		END IF
	NEXT 
	// Do for main
	FOR li_idx = 1 to li_num_of_timeframes  //get rest of timeframe - only main tables left
		IF lstr_timeframe_array[li_idx].tbl_alias = '' THEN    
         li_upper1 = UpperBound (istr_from_tables) 
			FOR li_idx2 = 1 to li_upper1   
				IF ls_timeframe_tbl_type[li_idx] = istr_from_tables[li_idx2].tbl_type THEN
					lb_in_timeframe = false
					FOR li_idx3 = 1 to li_num_of_timeframes
						IF lstr_timeframe_array[li_idx3].tbl_alias = istr_from_tables[li_idx2].prefix THEN
							lb_in_timeframe = true
							Exit
						END IF
					NEXT
					IF NOT lb_in_timeframe THEN
						lstr_timeframe_array[li_idx].tbl_alias = istr_from_tables[li_idx2].prefix
						lstr_timeframe_array[li_idx].field = ls_timeframe_column[li_idx]
						lstr_timeframe_array[li_idx].tbl_type = ls_timeframe_main_tbl[li_idx]
					END IF
					IF lstr_timeframe_array[li_idx].tbl_alias <> '' THEN 
						Exit	 // If filled above, then go to NEXT timeframe
					END IF
				END IF
			NEXT
		END IF
	NEXT 

	ls_rc = This.uf_pattern_timeframe (lstr_timeframe_array)
	// Remove checking for day_ind = 'S' in the following ELSEIF.  It is handled later.
ELSEIF li_timeframe_button	=	lci_ab		THEN
	li_idx = 1
	FOR li_idx2 = 1 to li_tbls
		IF istr_from_tables[li_idx2].tbl_rel = 'M' THEN
			lstr_timeframe_array[li_idx].tbl_alias	=	istr_from_tables[li_idx2].prefix
			lstr_timeframe_array[li_idx].field		=	'SAME'
			lstr_timeframe_array[li_idx].tbl_type	=	istr_from_tables[li_idx2].tbl_type
			li_idx ++
		END IF
	NEXT
	ls_rc = This.uf_pattern_timeframe (lstr_timeframe_array)
END IF		

IF	Upper (ls_rc)	=	'ERROR'		THEN
	Return	lcs_error
END IF

// Put in filter fields
li_idx4 = UpperBound (is_where)
IF li_idx4 <> 0 THEN
	IF is_where[li_idx4] <> '' THEN	li_idx4++
ELSE
	li_idx4 = 1
END IF

// Will need the number of tables in the from clause thru out the function
li_tbls	=	UpperBound (istr_from_tables)
IF li_tbls <> 0 THEN
	IF istr_from_tables[li_tbls].tbl_type = '' THEN
		li_tbls --
	END IF
END IF

FOR li_idx = 1 to ll_fields
	ls_field_col_name		=	idw_criteria.object.field_col_name [li_idx]
	ls_field_tbl_type		=	idw_criteria.object.field_tbl_type [li_idx]
	ls_field_operator		=	idw_criteria.object.field_operator [li_idx]
	ls_field_value			=	idw_criteria.object.field_value [li_idx]
	// Determine if the column is being compared against itself
	IF	ls_field_value		=	is_same_column		THEN
		//	A column is being compared against itself.  Handle this later
		//	in the script.
		lb_compare			=	TRUE
		Continue
	END IF
	IF UpperBound (lstr_set_array) > 0 THEN
		IF ls_field_col_name <> lstr_set_array[1].field THEN
			lb_in_timeframe = false
         li_upper1 = UpperBound (lstr_timeframe_array)  
			FOR li_idx2 = 1 to li_upper1  
				IF ls_field_col_name = lstr_timeframe_array[li_idx2].field &
				AND ls_field_tbl_type = lstr_timeframe_array[li_idx2].tbl_type THEN	//01-20-98 MVR
					IF is_tbl_rel[li_idx] = 'D' THEN
                  li_upper2 = UpperBound (ls_domestic_main_alias) 
						FOR li_idx5 = 1 to li_upper2   
							IF lstr_timeframe_array[li_idx2].tbl_alias = ls_domestic_main_alias[li_idx5] THEN
								ls_prefix = ls_domestic_dep_alias[li_idx5]
								Exit
							END IF
						NEXT
					ELSE
						ls_prefix = lstr_timeframe_array[li_idx2].tbl_alias
					END IF
					// FDG 09/21/00 - Only use is_where_clause & ib_multiple_likes when applicable
					IF	li_idx	<=	li_upper_where		THEN
						IF ib_multiple_likes[li_idx] THEN
							li_rc = This.uf_multiple_likes (is_where_clause[li_idx], &
																	ls_field_col_name, &
																	ls_prefix)
							IF li_rc = 0 THEN
								is_where[li_idx4] = is_where_clause[li_idx]
							ELSE
								MessageBox ('Error','Error creating SQL with multiple likes.')
								Return	lcs_error
							END IF
						ELSE				
							is_where[li_idx4] = ls_prefix + '.' + is_where_clause[li_idx]
						END IF
						li_idx4 ++
						lb_in_timeframe = true
						Exit
					END IF
				END IF
			NEXT
			IF NOT lb_in_timeframe THEN
				FOR li_idx3 = 1 to li_tbls
					IF ls_field_tbl_type = istr_from_tables[li_idx3].tbl_type THEN						
						// FDG 09/21/00 - Only use is_where_clause & ib_multiple_likes when applicable
						IF	li_idx	<=	li_upper_where		THEN
							IF ib_multiple_likes[li_idx] THEN
								li_rc = This.uf_multiple_likes(is_where_clause[li_idx], &
																		ls_field_col_name, &
																		istr_from_tables[li_idx3].prefix)
								IF li_rc = 0 THEN
									is_where[li_idx4] = is_where_clause[li_idx]
								ELSE
									MessageBox ('Error','Error creating SQL with multiple likes.')
									Return	lcs_error
								END IF
							ELSE				
								is_where[li_idx4] = istr_from_tables[li_idx3].prefix + '.' + is_where_clause[li_idx]
							END IF
							li_idx4 ++
						END IF
					END IF
				NEXT
			END IF
		END IF
	ELSE
		lb_in_timeframe = false
      li_upper1 = UpperBound (lstr_timeframe_array)  
		FOR li_idx2 = 1 to li_upper1    
			IF ls_field_col_name = lstr_timeframe_array[li_idx2].field &
			AND ls_field_tbl_type = lstr_timeframe_array[li_idx2].tbl_type THEN	//01-20-98 MVR
				IF is_tbl_rel[li_idx] = 'D' THEN
               li_upper2 = UpperBound (ls_domestic_main_alias)  
					FOR li_idx5 = 1 to li_upper2   
						IF lstr_timeframe_array[li_idx2].tbl_alias = ls_domestic_main_alias[li_idx5] THEN
							ls_prefix = ls_domestic_dep_alias[li_idx5]
							Exit
						END IF
					NEXT
				ELSE
					ls_prefix = lstr_timeframe_array[li_idx2].tbl_alias
				END IF
				// FDG 09/21/00 - Only use is_where_clause & ib_multiple_likes when applicable
				IF	li_idx	<=	li_upper_where		THEN
					IF ib_multiple_likes[li_idx] THEN
						li_rc = This.uf_multiple_likes (is_where_clause[li_idx], &
																ls_field_col_name,	&
																ls_prefix)
						IF li_rc = 0 THEN
							is_where[li_idx4] = is_where_clause[li_idx]
						ELSE
							MessageBox ('Error','Error creating SQL with multiple likes.')
							Return	lcs_error
						END IF
					ELSE				
						is_where[li_idx4] = ls_prefix + '.' + is_where_clause[li_idx]
					END IF
					li_idx4 ++
					lb_in_timeframe = true
					Exit
				END IF
			END IF
		NEXT
		IF NOT lb_in_timeframe THEN
			FOR li_idx3 = 1 to li_tbls
				IF ls_field_tbl_type = istr_from_tables[li_idx3].tbl_type THEN
					// FDG 09/21/00 - Only use is_where_clause & ib_multiple_likes when applicable
					IF	li_idx3	<=	li_upper_where		THEN
						IF ib_multiple_likes[li_idx3] THEN
							li_rc = This.uf_multiple_likes (is_where_clause[li_idx3],	&
																	ls_field_col_name,	&
																	istr_from_tables[li_idx].prefix)
							IF li_rc = 0 THEN
								is_where[li_idx4] = is_where_clause[li_idx3]
							ELSE
								MessageBox ('Error','Error creating SQL with multiple likes.')
								Return	lcs_error
							END IF
						ELSE				
							is_where[li_idx4] = istr_from_tables[li_idx3].prefix + '.' + is_where_clause[li_idx]
						END IF
						li_idx4 ++
					END IF
				END IF
			NEXT
		END IF
	END IF
NEXT
		
		
// Put in SAME CLAIM filters

li_idx3 = UpperBound (is_where)
IF li_idx3 <> 0 THEN
	IF is_where[li_idx3] <> '' THEN	li_idx3++
ELSE
	li_idx3 = 1
END IF

IF ls_claim_ind	=	'S'		&
OR	ls_claim_ind	=	'D'	THEN
	// Same or different claim.  This cannot occur on a ML subset.
   li_upper1 = UpperBound (istr_from_tables) 
	FOR li_idx = 1 to li_upper1
		FOR li_idx2 = li_idx + 1 to li_upper1    
			IF istr_from_tables[li_idx].tbl_type = istr_from_tables[li_idx2].tbl_type &
			AND istr_from_tables[li_idx].tbl_rel = 'M' THEN
				ls_where				=	This.uf_where_claim (ls_claim_ind, li_idx, li_idx2)
				IF	Len (ls_where)	>	0		THEN
					is_where[li_idx3] =	ls_where
					li_idx3	++
				ELSE
					Return	lcs_error
				END IF
			END IF
		NEXT
	NEXT
END IF

li_idx3 = UpperBound (is_where)

IF li_idx3 <> 0 THEN
	IF is_where[li_idx3] <> '' THEN	li_idx3++
ELSE
	li_idx3 = 1
END IF

IF ls_patient_ind	=	'S'		&
OR	ls_patient_ind	=	'D'		THEN
	// Same patient or different Patient
	IF	ls_patient_ind	=	'D'		THEN
		ls_rel_op	=	' <> '
	ELSE
		ls_rel_op	=	' = '
	END IF
   li_upper1 = UpperBound (istr_from_tables)  
	FOR li_idx = 1 to li_upper1
		FOR li_idx2 = li_idx + 1 to li_upper1     
			// FDG 06/14/00	Begin
			IF	lb_ml_subset		THEN
				// ML subset.  Same patient is fixed and cannot be changed.  Logic earlier
				//	in this script has already been executed to handle this.
				Continue
				// FDG 06/14/00 End
			ELSE
				// Not a ML subset.  Join onto itself
				IF istr_from_tables[li_idx].tbl_type = istr_from_tables[li_idx2].tbl_type	&
				AND istr_from_tables[li_idx].tbl_rel = 'M' 											THEN
					is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'	+	lcs_main_join_field	+	&
												ls_rel_op	+	istr_from_tables[li_idx2].prefix	+	'.'	+	lcs_main_join_field
					li_idx3++
				END IF
			END IF				// IF lb_ml_subset
		NEXT						// li_idx2 = li_idx + 1 to li_upper1
	NEXT							// li_idx = 1 to li_upper1
END IF

IF ls_tooth_ind	=	'S'		&
OR	ls_tooth_ind	=	'D'		THEN
	// Same tooth or different tooth
	IF	ls_tooth_ind	=	'D'		THEN
		ls_rel_op	=	' <> '
	ELSE
		ls_rel_op	=	' = '
	END IF
   li_upper1 = UpperBound (istr_from_tables)  
	FOR li_idx = 1 to li_upper1
		FOR li_idx2 = li_idx + 1 to li_upper1     
			// FDG 06/14/00	Begin
			IF	lb_ml_subset		THEN
				// ML subset.  Join onto the other invoice types (not itself)
				IF istr_from_tables[li_idx].tbl_type	<>	istr_from_tables[li_idx2].tbl_type	&
				AND istr_from_tables[li_idx].tbl_rel	=	'M' 											&
				AND istr_from_tables[li_idx2].tbl_rel	=	'M' 											THEN
					// Found separate table types.  Edit both columns
					li_rc		=	This.uf_edit_column (istr_from_tables[li_idx].tbl_type,	lcs_tooth)
					li_rc2	=	This.uf_edit_column (istr_from_tables[li_idx2].tbl_type,	lcs_tooth)
					IF	 li_rc	>	0		&
					AND li_rc2	>	0		THEN
						is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'			+	&
													lcs_tooth													+	&
													ls_rel_op	+	istr_from_tables[li_idx2].prefix	+	&
													'.'	+	lcs_tooth
						li_idx3++
					END IF
				END IF
				
				// FDG 06/14/00 End
			ELSE
				// Not a ML subset.  Join onto itself
				IF istr_from_tables[li_idx].tbl_type = istr_from_tables[li_idx2].tbl_type	&
				AND istr_from_tables[li_idx].tbl_rel = 'M' 											THEN
					is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'	+	lcs_tooth	+	&
												ls_rel_op	+	istr_from_tables[li_idx2].prefix	+	'.'	+	lcs_tooth
					li_idx3++
				END IF
			END IF
		NEXT
	NEXT
END IF


IF ls_day_ind = 'S'		&
OR	ls_day_ind = 'D'		THEN
	// Same or different day.  Simply compare dates (i.e. A.FROM_DATE = B.FROM_DATE).  This can be
	// done because the times associated with from_date is always = 00:00.  Otherwise,
	// a DateDiff SQL function would be required.
	IF	ls_day_ind	=	'D'		THEN
		ls_rel_op	=	' <> '
	ELSE
		ls_rel_op	=	' = '
	END IF
   li_upper1 = UpperBound (istr_from_tables)  
	FOR li_idx = 1 to li_upper1
		FOR li_idx2 = li_idx + 1 to li_upper1     
			// FDG 06/14/00	Begin
			IF	lb_ml_subset		THEN
				// ML subset.  Join onto the other invoice types (not itself)
				IF istr_from_tables[li_idx].tbl_type	<>	istr_from_tables[li_idx2].tbl_type	&
				AND istr_from_tables[li_idx].tbl_rel	=	'M' 											&
				AND istr_from_tables[li_idx2].tbl_rel	=	'M' 											THEN
					// Found separate table types.  Edit both columns
					li_rc		=	This.uf_edit_column (istr_from_tables[li_idx].tbl_type,	lcs_from_date)
					li_rc2	=	This.uf_edit_column (istr_from_tables[li_idx2].tbl_type,	lcs_from_date)
					IF	 li_rc	>	0		&
					AND li_rc2	>	0		THEN
						is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'			+	&
													lcs_from_date												+	&
													ls_rel_op	+	istr_from_tables[li_idx2].prefix	+	&
													'.'	+	lcs_from_date
						li_idx3++
					END IF
				END IF
				
				// FDG 06/14/00 End
			ELSE
				// Not a ML subset.  Join onto itself
				IF istr_from_tables[li_idx].tbl_type = istr_from_tables[li_idx2].tbl_type	&
				AND istr_from_tables[li_idx].tbl_rel = 'M' 											THEN
					is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'	+	lcs_from_date	+	&
												ls_rel_op	+	istr_from_tables[li_idx2].prefix	+	'.'	+	lcs_from_date
					li_idx3++
				END IF
			END IF
		NEXT
	NEXT
END IF

// If one or more columns are being compared against itself, add the criteria
//	to is_where[]

IF	lb_compare	=	TRUE		THEN
	ll_fields	=	idw_criteria.RowCount()
	FOR ll_row	= 1 TO ll_fields
		ls_field_col_name		=	idw_criteria.object.field_col_name [ll_row]
		ls_field_tbl_type		=	idw_criteria.object.field_tbl_type [ll_row]
		ls_field_operator		=	idw_criteria.object.field_operator [ll_row]
		ls_field_value			=	idw_criteria.object.field_value [ll_row]
		IF	ls_field_value		=	is_same_column		THEN
			li_upper1 = UpperBound (istr_from_tables)  
			FOR li_idx = 1 to li_upper1
				// FDG 06/14/00	Begin
				IF	lb_ml_subset		THEN
					// ML subset.  Join onto the other invoice types (not itself)
					FOR	li_idx2	=	1	TO	li_upper1
						IF istr_from_tables[li_idx].tbl_type	<>	istr_from_tables[li_idx2].tbl_type	&
						AND istr_from_tables[li_idx].tbl_rel	=	'M' 											&
						AND istr_from_tables[li_idx2].tbl_rel	=	'M' 											THEN
							// Found separate table types.  Edit both columns
							li_rc		=	This.uf_edit_column (istr_from_tables[li_idx].tbl_type,	ls_field_col_name)
							li_rc2	=	This.uf_edit_column (istr_from_tables[li_idx2].tbl_type,	ls_field_col_name)
							IF	 li_rc	>	0		&
							AND li_rc2	>	0		THEN
								is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'			+	&
															ls_field_col_name											+	&
															ls_field_operator											+	&
															istr_from_tables[li_idx2].prefix						+	&
															'.'	+	ls_field_col_name
								li_idx3++
							END IF
						END IF
					NEXT
					// FDG 06/14/00 End
				ELSE
					// Not a ML subset.  Join onto itself
					// Find the tbl_type in istr_from_tables
					IF	ls_field_tbl_type	<>	istr_from_tables[li_idx].tbl_type	THEN
						Continue
					END IF
					FOR li_idx2 = li_idx + 1 to li_upper1     
						IF ls_field_tbl_type =	istr_from_tables[li_idx2].tbl_type	THEN
							is_where[li_idx3] =	istr_from_tables[li_idx].prefix	+	'.'	+	ls_field_col_name	+	&
														ls_field_operator	+	istr_from_tables[li_idx2].prefix	+	'.'	+	&
														ls_field_col_name
							li_idx3++
						END IF
					NEXT
				END IF
			NEXT
		END IF
	NEXT
END IF				//	lb_compare = TRUE

IF ls_allwd_srvc_ind = 'G' THEN //NLG 10-29-98 Track #1753
	li_idx3 = UpperBound (is_where)
	IF li_idx3 <> 0 THEN
		IF is_where[li_idx3] <> '' THEN li_idx3++
	ELSE
		li_idx3 = 1
	END IF

	li_upper1 = UpperBound (istr_from_tables)  
	FOR li_idx = 1 to li_upper1  
		ls_type_select = istr_from_tables[li_idx].tbl_type
		ls_dwfilter = "rel_type = 'QT' and Id_2 = '" + ls_type_select + "'"
		w_main.dw_stars_rel_dict.SetFilter('')
		w_main.dw_stars_rel_dict.SetFilter(ls_dwfilter)
		w_main.dw_stars_rel_dict.filter()
		li_nbr_rows = w_main.dw_stars_rel_dict.rowcount()
		IF li_nbr_rows > 0 THEN
		   ls_base_type = w_main.dw_stars_rel_dict.getitemstring(1,'key6')
			IF ls_base_type = '1500' THEN 
				is_where[li_idx3] = istr_from_tables[li_idx].prefix	+	'.units_allowed > 0'
				li_idx3++
			END IF
		END IF			
	NEXT
END IF														// NLG Track #1753
 	
// Determine sequence of tables for the select clause
// will be put in order of fields selected with main followed by its dependent
li_select_seq = 1
FOR li_idx = 1 to ll_fields
	ls_field_col_name		=	idw_criteria.object.field_col_name [li_idx]
	ls_field_tbl_type		=	idw_criteria.object.field_tbl_type [li_idx]
   li_upper2 = UpperBound (istr_from_tables)
	FOR li_idx2 = 1 to li_upper2           
		IF ls_field_tbl_type = istr_from_tables[li_idx2].tbl_type THEN
			IF istr_from_tables[li_idx2].select_seq = 0 THEN
				IF istr_from_tables[li_idx2].tbl_rel = 'D' THEN
               li_upper3 = UpperBound (ls_domestic_dep_alias) 
					FOR li_idx3 = 1 to li_upper3   
						IF istr_from_tables[li_idx2].prefix = ls_domestic_dep_alias[li_idx3] THEN
                     li_upper4 = UpperBound (istr_from_tables) 
							FOR li_idx4 = 1 to li_upper4   
								IF ls_domestic_main_alias[li_idx3] = istr_from_tables[li_idx4].prefix THEN
									IF istr_from_tables[li_idx4].select_seq = 0 THEN
										istr_from_tables[li_idx4].select_seq = li_select_seq
										li_select_seq++
										istr_from_tables[li_idx2].select_seq = li_select_seq
										li_select_seq++
										Exit
									END IF
								END IF
							NEXT
						END IF
					NEXT
				ELSE
               li_upper3 = UpperBound (ls_domestic_main_alias)  
					FOR li_idx3 = 1 to li_upper3  
						IF istr_from_tables[li_idx2].prefix = ls_domestic_main_alias[li_idx3] THEN
                     li_upper4 = UpperBound (istr_from_tables)
							FOR li_idx4 = 1 to li_upper4   
								IF ls_domestic_dep_alias[li_idx3] = istr_from_tables[li_idx4].prefix THEN
									IF istr_from_tables[li_idx4].select_seq = 0 THEN
										istr_from_tables[li_idx2].select_seq = li_select_seq
										li_select_seq++
										istr_from_tables[li_idx4].select_seq = li_select_seq
										li_select_seq++
										Exit
									END IF
								END IF
							NEXT
						END IF
					NEXT
					IF istr_from_tables[li_idx2].select_seq = 0 THEN
						istr_from_tables[li_idx2].select_seq = li_select_seq
						li_select_seq++
						Exit
					END IF
				END IF
			END IF
		END IF
	NEXT
NEXT


Return	ls_rc	// Returned from uf_pattern_timeframe to determine if using
					// from/thru dates or from date need to pass for order by

end event

event type string ue_pattern_select(string as_tbl_type, string as_prefix, string as_label_alias, boolean ab_no_label, string as_set_type);//*********************************************************************************
// Script Name:	ue_pattern_select
//
//	Arguments:		1.	as_tbl_type - The table type you want all the fields for
//						2.	as_prefix - Alias name to tack on to each field.
//						3.	as_label_alias - Label alias to tack on to each label
//						4.	ab_no_label
//						5.	as_set_type - 'M' is main, 'D' is dependent
//
// Returns:			String
//						'Error' - An error occured when generating the select
//
//	Description:	This script is called for a generic pattern (ue_pattern_sql)
//						and for a filter pattern (ue_spec_sql).
//						
//						This script will retrieve all fields for the table type passed
//						in for the sequence specified and tack on the alias name for
//						each field.  It also will tack on the label for each field.
//						Each field will be comma separated.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/14/00	FDG	Stars 4.7.	Make data type checking DBMS-independent
//	12/04/00	GaryR	Stars 4.7.  DataBase Port - Empty String in SQL
//	02/01/01	FDG	Stars 4.7.	Make the column alias use a double-quote instead of
//										single-quote.
// JasonS 08/22/02	Track 2982d  Dictionarize the labels, don't use field alias'
//*********************************************************************************

Boolean		lb_unique

Long			ll_row,					&
				ll_rowcount,			&
				ll_find_row,			&
				ll_new_row

Integer		li_rc

String		ls_dep_alias,			&
				ls_find,					&
				ls_select,				&
				ls_dep_select,			&
				ls_data_type,			&
				ls_field_column,		&
				ls_field_label,		&
				ls_alias,				&
				ls_empty

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

IF	as_set_type	=	'D'		THEN
	// Dependent table
	ls_dep_alias	=	't'
ELSE
	// Main table
	ls_dep_alias	=	's'
END IF

// Loop thru idw_selected for the table type passed
ls_find			=	"elem_tbl_type = '"	+	as_tbl_type	+	"'"

ll_rowcount		=	idw_selected.RowCount()
ll_find_row		=	idw_selected.Find (ls_find, 1, ll_rowcount)

DO	WHILE	ll_find_row	>	0	
	ls_field_column	=	idw_selected.object.elem_name [ll_find_row]
	ls_field_label		=	Trim ( idw_selected.object.elem_desc [ll_find_row] )
	//ls_field_label		=	Trim ( idw_selected.object.elem_elem_label [ll_find_row] )
	ls_data_type		=	Upper (idw_selected.object.elem_data_type [ll_find_row])
	// Flag that the column in dw_selected was added to the Select clause
	is_added_to_sql [ll_find_row]	=	'Y'
	// FDG 02/01/01 - Make alias begin with a double-quote
	//ls_select			=	ls_select	+	","	+	as_prefix	+	&
	//							"."	+	ls_field_column	+	" '"	+	&
	//							as_label_alias	+	" "	+	ls_field_label	+	"'"
	// JasonS 08/22/02 Begin - Track 2982d
//	ls_select			=	ls_select	+	","	+	as_prefix	+	&
//								"."	+	ls_field_column	+	' "'	+	&
//								as_label_alias	+	" "	+	ls_field_label	+	'"'
//	
	ls_select			=	ls_select	+	","	+	as_prefix	+	&
								"."	+	ls_field_column	//+	' "'	+	&
								//as_label_alias	//+	" "	+	ls_field_label	+	'"'
	// JasonS 08/22/02 End - Track 2982d
	// FDG 02/01/01 - end
	IF	ab_no_label		THEN
		// No label.  Append an empty string ('') or 0 to Select
		// FDG 12/14/00 - Make the checking of data types DBMS-independent.
		//CHOOSE CASE	ls_data_type
		//	CASE	'CHAR', 'DATETIME', 'SMALLDATETIME', 'VARCHAR'
		//		ls_dep_select	=	ls_dep_select	+	",''"
		//	CASE	ELSE
		//		ls_dep_select	=	ls_dep_select	+	",0"
		//END CHOOSE
		IF gnv_sql.of_is_date_data_type (ls_data_type)			&
		OR	gnv_sql.of_is_character_data_type (ls_data_type)	THEN
			ls_dep_select	=	ls_dep_select	+	",' '"
		ELSE
			ls_dep_select	=	ls_dep_select	+	",0"
		END IF
		// FDG 12/14/00 end
	ELSE
		ls_alias			=	as_label_alias	+	" "	+	ls_field_label
		// JasonS 08/22/02 Begin - Track 2982d
		//ls_dep_select	=	ls_dep_select	+	","	+	ls_dep_alias	+	"."	+	&
		//						ls_field_column	+	' "'	+	ls_alias	+	'"'		
		ls_dep_select	=	ls_dep_select	+	","	+	ls_dep_alias	+	"."	+	&
								ls_field_column	//+	' "'	+	ls_alias	+	'"'
		// JasonS 08/22/02 End - Track 2982d								
	END IF
	// Insert the data into ids_report_cols
	//	12/04/00	GaryR	Stars 4.7 DataBase Port
	IF Trim( ls_alias ) = "" THEN ls_alias = ls_empty
	
	ll_new_row			=	ids_report_cols.InsertRow(0)
	ids_report_cols.object.tbl_type [ll_new_row]		=	as_tbl_type
	ids_report_cols.object.col_name [ll_new_row]		=	ls_field_column
	ids_report_cols.object.alias_name [ll_new_row]	=	ls_alias
	ids_report_cols.object.query_pos [ll_new_row]	=	ll_new_row
	ids_report_cols.object.delete_ind [ll_new_row]	=	'N'
	lb_unique	=	This.uf_is_unique_key (as_tbl_type, ls_field_column)
	IF	lb_unique		THEN
		ids_report_cols.object.key_ind [ll_new_row]	=	'Y'
	ELSE
		ids_report_cols.object.key_ind [ll_new_row]	=	'N'
	END IF
	// Get the next row in idw_selected.
	ll_find_row	++
	IF	ll_find_row	>	ll_rowcount		THEN
		Exit			// Prevent searching backwards
	END IF
	ll_find_row		=	idw_selected.Find (ls_find, ll_find_row, ll_rowcount)
LOOP

// Remove the leading ',' from ls_select and ls_dep_select
IF	Len (ls_select)	>	0		THEN
	ls_select	=	Mid (ls_select, 2)
END IF

IF	Len (ls_dep_select)	>	0		THEN
	ls_dep_select	=	Mid (ls_dep_select, 2)
END IF

IF	ll_rowcount	=	0		THEN
	ls_select	=	''
END IF

ls_select	=	ls_select	+	':'	+	ls_dep_select

Return	ls_select

end event

event type string ue_spec_sql();//*********************************************************************************
// Script Name:	ue_spec_sql
//
//	Arguments:		None
//
// Returns:			String - is_sql
//
//	Description:	This script is executed for a non-generic pattern and
//						will create the SQL.
//	
//	Notes:			When converting the data from patt_columns into the 'Select'
//						there can be column called @FIELDx.  When this occurs, the base
//						type (which is included in the column's alias), must be different
//						than the other columns in the select.  A duplicate alias will
//						cause the d/w creation to fail.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/20/00	FDG	Track 2930 (SP1).  Get the column description from uf_get_col_desc().
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Empty String in SQL.
// 09/03/02	Jason	Track 2982d  Dictionarize the labels, don't use field alias'
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//*********************************************************************************

Constant	Long		lcl_new_sql_first_line	=	29

Constant	String	lcs_alias_a		=	'a.'
Constant	String	lcs_alias_c		=	'c.'
Constant	String	lcs_depset		=	'%DEPSET'
Constant	String	lcs_error		=	'ERROR'
Constant	String	lcs_likes		=	'%LIKES'
Constant	String	lcs_type_bill	=	'TYPE_BILL'
Constant	String	lcs_union		=	'%UNION'
Constant	String	lcs_value1		=	'@VALUE1'
Constant	String	lcs_value2		=	'@VALUE2'

Boolean	lb_dep_set_sql

Integer	li_tbl_no,					&
			li_idx,						&
			li_index,					&
			li_len,						&
			li_first_type_bill,		&
			li_pattern_id,				&
			li_pos,						&
			li_pos2,						&
			li_pos3,						&
			li_upper,					&
			li_rc,						&
			li_num_tables

Long		ll_rc,						&
			ll_pos,						&
			ll_start,					&
			ll_row,						&
			ll_new_row,					&
			ll_start_row,				&
			ll_rowcount,				&
			ll_crit_count,				&
			ll_crit_row,				&
			ll_find_row,				&
			ll_column_count,			&
			ll_avail_count

String	ls_alias,					&
			ls_back,						&
			ls_base_type,				&
			ls_col_desc,				&
			ls_col_name,				&
			ls_empty,					&
			ls_field_parm,				&
			ls_field_set,				&
			ls_filter,					&
			ls_find,						&
			ls_front,					&
			ls_new,						&
			ls_old,						&
			ls_one,						&
			ls_one_value,				&
			ls_patt_cond,				&
			ls_pattern_id,				&
			ls_prefix,					&
			ls_rpt_col_name,			&
			ls_revenue,					&
			ls_sql,						&
			ls_sql_string,				&
			ls_subset_base_type[],	&
			ls_suffix,					&
			ls_tbl_name,				&
			ls_tbl_type,				&
			ls_temp_base_type,		&
			ls_three,					&
			ls_three_value,			&
			ls_two,						&
			ls_two_value,				&
			ls_value1,					&
			ls_value2,					&
			ls_where_message

n_ds		lds_patt_template

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

// Reset any previous data inserted into ids_report_cols and istr_from_tables
ids_report_cols.Reset()
This.uf_clear_from_tables()

// Preload the base types for each subset table type into ls_subset_base_type[].
//	Prefix each entry with '@'
li_num_tables	=	UpperBound (is_subset_tbl_type)

FOR	li_tbl_no	=	1	TO	li_num_tables
	ls_subset_base_type[li_tbl_no]	=	'@'	+	This.uf_get_base_type (is_subset_tbl_type[li_tbl_no])
	IF	ls_subset_base_type[li_tbl_no]	=	'@UB92'	THEN
		// Get the revenue code
		ls_revenue	=	inv_revenue.of_get_revenue(is_subset_tbl_type[li_tbl_no])
	END IF
NEXT

// Get the data in patt_template
lds_patt_template	=	CREATE	n_ds
lds_patt_template.DataObject	=	'd_patt_template'
lds_patt_template.SetTransObject (Stars2ca)
ll_rowcount	=	lds_patt_template.Retrieve (is_pattern_id)

ls_patt_cond	=	Upper ( This.uf_get_patt_cond() )

ls_pattern_id	=	is_pattern_id
ll_avail_count	=	idw_available.RowCount()
ll_crit_count	=	idw_criteria.Rowcount()

// Determine the 1st and last row to access in patt_template.

ll_start_row	=	1
ib_same_crit = FALSE

IF	Match (ls_patt_cond, lcs_depset)		THEN
	lb_dep_set_sql		=	This.uf_spec_dep_set()
	IF	lb_dep_set_sql		THEN
		ib_same_crit = TRUE
		IF	Match (ls_patt_cond, lcs_union)	THEN
			This.uf_set_union_flag (TRUE)
		ELSE
			This.uf_set_union_flag (FALSE)
		END IF			//	Match (ls_patt_cond, lcs_union)
		// Start with the 29th row
		ll_start_row	=	lcl_new_sql_first_line
		ls_filter		=	"line_num >= "	+	String(ll_start_row)
		// Because we are getting a different set of SQL, a different set of
		//	'Select' columns will be retrieved from patt_columns.  For example,
		//	Pat0000035 will be changed to Pat0000935 for patt_columns
		li_pattern_id	=	Integer (Mid (ls_pattern_id, 8) )
		li_pattern_id	=	li_pattern_id	+	900
		ls_pattern_id	=	Left(ls_pattern_id, 7)	+	String(li_pattern_id, '000')
	ELSE
		// Use only rows 1 through 28
		ll_rowcount		=	lcl_new_sql_first_line	-	1
		ls_filter		=	"line_num < "	+	String(ll_rowcount)
	END IF				//	lb_dep_set_sql
	// Filter out the unused rows
	li_rc					=	lds_patt_template.SetFilter ('')
	li_rc					=	lds_patt_template.Filter()
	li_rc					=	lds_patt_template.SetFilter (ls_filter)
	li_rc					=	lds_patt_template.Filter()
	ll_rowcount			=	lds_patt_template.RowCount()
	ll_start_row		=	1
	// 
END IF					//	Match (ls_patt_cond, lcs_depset)

// Loop thru ls_sql to find each occurrence of @TBxxxx.  Each occurrence found
// has an associated prefix.  To find the unique keys, the prefixes must
// be registered and its associated table type must be registered.

// Set ls_sql based on the data in patt_template
FOR	ll_row	=	1	TO	ll_rowcount
	ls_sql_string	=	Upper (lds_patt_template.object.sql_text [ll_row])
	ls_sql			=	ls_sql	+	ls_sql_string	+	" "
NEXT

li_pos				=	Pos (ls_sql, '@TB')

DO WHILE li_pos	>	0
	// Found '@TB'.  Get the prefix and the characters immediately
	//	after @TB.  These characters will either be '1500', 'UB92' or 'REV'.
	// Use these characters to search ls_subset_base_type[] to get its
	//	associated table type.
	li_pos2			=	Pos (ls_sql, ' ', li_pos + 1)		// Find ' ' after '@TB'
	ls_base_type	=	Mid (ls_sql, li_pos + 3, li_pos2 - li_pos - 3)
	ls_prefix		=	Mid (ls_sql, li_pos2 + 1, 1)
	ls_tbl_type		=	''
	// Get the table type assosiated with the base type.  When searching
	//	ls_subset_base_type[], each entry has a '@' in front of the base type.
	// Note that revenue base types are not in ls_subset_base_type[].
	IF	ls_base_type	=	'REV'		THEN
		ls_tbl_type		=	ls_revenue
	ELSE
		FOR	li_tbl_no	=	1	TO	li_num_tables
			ls_temp_base_type	=	Mid (ls_subset_base_type[li_tbl_no], 2)
			IF	ls_base_type	=	ls_temp_base_type		THEN
				ls_tbl_type		=	is_subset_tbl_type [li_tbl_no]
				Exit
			END IF
		NEXT
	END IF
	// Register the prefix and table type and retrieve its unique keys
	This.uf_set_tbl_type (ls_prefix, ls_tbl_type)
	// Get the next table
	li_pos			=	Pos (ls_sql, '@TB', li_pos + 1)	
LOOP

// Read the data in patt_columns to get the columns in the Select.  Please note
//	that Patterns 36 and 37 can issue a UNION, when this occurs, the union SQL
//	resides in patt_template.  First, get the 1st row in patt_template to
//	differentiate between a 'Select' and a 'Select Distinct'.
ib_report_cols		=	TRUE
is_sql				=	Trim (lds_patt_template.object.sql_text [1] )	+	" "

ll_column_count	=	ids_patt_columns.Retrieve (ls_pattern_id)

FOR	ll_row		=	1	TO	ll_column_count
	ls_base_type	=	Trim (ids_patt_columns.object.base_type [ll_row])
	ls_col_name		=	ids_patt_columns.object.col_name [ll_row]
	ls_prefix		=	Trim (ids_patt_columns.object.tbl_type [ll_row])
	ls_tbl_type		=	''
	ls_col_desc		=	''
	//	If @FIELDx exists, get the column name from the criteria.  Please note
	li_pos			=	Pos (ls_col_name, '@FIELD')
	IF	li_pos		>	0		THEN
		// Remove the '@'
		ls_col_name	=	Mid (ls_col_name, 2)
		// Get the column name from the criteria for @FIELDx
		FOR	ll_crit_row	=	1	TO	ll_crit_count
			ls_field_set	=	Upper (idw_criteria.object.field_set [ll_crit_row])
			IF	ls_field_set	=	ls_col_name		THEN
				// Get the new column name from dw_criteria
				ls_col_name	=	Upper ( idw_criteria.object.field_col_name [ll_crit_row] )
				ids_patt_columns.object.col_name [ll_row]	=	ls_col_name
				Exit
			END IF
		NEXT
	END IF
	// Convert the base type to an invoice type.  The base types were preloaded.
	//	Normally, base type = @15001 where 1 is the suffix & @1500 is the base type.
	//	Note: When reading base_type from patt_columns, the suffix must always start
	//	in the 6th position because the suffix can be multiple bytes.
	li_len			=	Len (ls_base_type)
	IF	li_len		>	0		THEN
		ls_suffix		=	Mid (ls_base_type, 6)
		// Must trim base type because you can have "@REV 1"
		ls_base_type	=	Trim (Upper ( Left (ls_base_type, 5) ) )
	ELSE
		// Patterns 17 and 20 will not have data in column base_type
		ls_suffix		=	''
		ls_base_type	=	'@1500'
	END IF
	IF	ls_base_type	=	'@REV'	THEN
		// Set table type to revenue
		ls_tbl_type		=	ls_revenue
	ELSE
		// Loop thru the list of base types to get the table type.
		FOR	li_tbl_no	=	1	TO	li_num_tables
			IF	ls_base_type	=	ls_subset_base_type[li_tbl_no]	THEN
				// Found the table type associated with the base type
				ls_tbl_type		=	is_subset_tbl_type[li_tbl_no]
				Exit
			END IF
		NEXT
	END IF
	// Get the column description.
	li_pos	=	Pos (ls_col_name, '+')
	IF	li_pos	>	0		THEN
		// Found a '+'.  The column name is to the left of the '+'.
		ls_col_name	=	Left (ls_col_name, li_pos - 1)
	END IF
	// If the column name has a quote (in 1st byte) or '@SELECT', 
	//	there is no column description
	li_pos3	=	Pos (ls_col_name, "'")
	li_pos2	=	Pos (ls_col_name, "@SELECT")
	IF	 li_pos3	=	0		&
	AND li_pos2	=	0		THEN
		// Get the column's description by searching dw_available
		// FDG 06/20/00 Begin
		ls_col_desc	=	This.uf_get_col_desc (ls_tbl_type, ls_col_name)
		// FDG 06/20/00 end
	END IF
	// Reset ls_col_name from the d/w (in case of col_name = 'ICN+' '+ICN_LINE_NO')
	ls_col_name		=	ids_patt_columns.object.col_name [ll_row]
	//	If the tbl_type has a '+' in it, then columns will get concatenated.
	li_pos	=	Pos (ls_prefix, '+')
	IF	li_pos	>	0		THEN
		// Concatenate this column with the column in the next row
		ls_prefix			=	Left (ls_prefix, 1)		//	Remove the '+'
		ls_rpt_col_name	=	ls_col_name	+	gnv_sql.is_concat		+	&
									ids_patt_columns.object.col_name [ll_row + 1]
		// The prefix will get attached to the 1st ls_col_name later.
		ls_col_name			=	ls_col_name	+	gnv_sql.is_concat		+	&
									ids_patt_columns.object.tbl_type [ll_row + 1]	+	'.'	+	&
									ids_patt_columns.object.col_name [ll_row + 1]
		ll_row	++		// Ignore the next row since its being concatenated
	ELSE
		ls_rpt_col_name	=	ls_col_name
	END IF
	// Determine if an alias is to appended (most of the time it is).  If a column
	//	contains a quote or '@SELECT', then ls_col_desc will be empty and li_pos2 > 0.
	li_index		=	This.uf_get_tbl_type_index (ls_prefix, ls_tbl_type)
	IF  li_pos2		=	0		THEN
		// @SELECT does not exist in the column name
		// Append the alias (if the column name isn't hard-coded)
		IF	li_pos3	=	1		&
		OR	li_len	=	0		THEN
			// The column name has a quote in it (1st byte) or the base_type was
			//	empty.  There is no alias.
			ls_alias				=	''
			IF	li_pos3			=	1		THEN
				// The 1st position of the column has a quote.  Do not include
				//	the prefix and do not append the alias
				ls_sql_string	=	ls_col_name	+	","
			ELSE
				//	The column does not have an alias.  Include the prefix and column name.
				ls_sql_string	=	ls_prefix	+	"."	+	ls_col_name	+	","
			END IF
		ELSE
			// Append the alias to the column name
			ls_alias				=	ls_tbl_type	+	ls_suffix	+	" "	+	ls_col_desc
			IF Len (ls_prefix)	>	0		THEN
				// JasonS 09/03/02 Begin - Track 2982d
				//ls_sql_string	=	ls_prefix	+	"."	+	ls_col_name	+	' "'	+	&
				//						ls_alias		+	'",'
				ls_sql_string	=	ls_prefix	+	"."	+	ls_col_name	+	','
				// JasonS 09/03/02 End - Track 2982d								
			ELSE
				// JasonS 09/03/02 End - Track 2982d								
				//ls_sql_string	=	ls_col_name	+	' "'	+	ls_alias		+	'",'
				ls_sql_string	=	ls_col_name	+ ','
				// JasonS 09/03/02 End - Track 2982d								
			END IF
		END IF
		
		//	12/04/00	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
		IF Trim( ls_alias ) = "" THEN ls_alias = ls_empty
		
		// Insert the data into ids_report_cols
		ll_new_row			=	ids_report_cols.InsertRow(0)
		ids_report_cols.object.tbl_type [ll_new_row]		=	ls_tbl_type
		ids_report_cols.object.col_name [ll_new_row]		=	ls_rpt_col_name
		ids_report_cols.object.alias_name [ll_new_row]	=	ls_alias
		ids_report_cols.object.query_pos [ll_new_row]	=	ll_new_row
		ids_report_cols.object.key_ind [ll_new_row]		=	'N'
		ids_report_cols.object.delete_ind [ll_new_row]	=	'N'
	ELSE
		// @SELECT exists in the column name
		IF ls_col_name	=	'@SELECT1'	THEN
			// Get the 'select1' unique keys and insert them into ids_report_cols
			ls_sql_string		=	This.uf_select1_keys (li_index)
		ELSE
			IF ls_col_name	=	'@SELECT2'	THEN
				// Get the 'select2' unique keys and insert them into ids_report_cols
				ls_sql_string		=	This.uf_select2_keys (li_index)
			END IF
		END IF
	END IF
	is_sql		=	is_sql	+	ls_sql_string
NEXT

// Remove the trailing ',' from the Select
//	04/20/01	GaryR	Stars 4.7
is_sql			=	Left (is_sql, Len(is_sql) - 1) + " "

ib_report_cols		=	FALSE

// Set is_sql based on the remaining data in patt_template
FOR	ll_row	=	2	TO	ll_rowcount
	ls_sql_string	=	Upper (lds_patt_template.object.sql_text [ll_row])
	is_sql			=	is_sql	+	ls_sql_string	+	" "
NEXT

IF Trim (is_sql)	=	''		THEN
	MessageBox('Application Error', 'Error retrieving pattern sql from Patt_template '+&
					'for pattern_id = '	+	is_pattern_id, StopSign!)
	Destroy	lds_patt_template
	Return	lcs_error
END IF

is_sql	=	Upper (is_sql)


// Loop through the criteria

li_num_tables	=	UpperBound (is_subset_tbl_type)
ll_rowcount		=	idw_criteria.Rowcount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	idw_criteria.object.field_col_name [ll_row]
	ls_col_desc		=	Trim ( idw_criteria.object.field_description [ll_row] )
	IF	(IsNull (ls_col_name)	OR	Trim (ls_col_name)	=	'')	&
	AND ll_row	=	ll_rowcount												&
	AND ll_row	>	1															THEN
		// No criteria entered for the last line, continue.
		Continue
	END IF
	ls_field_parm	=	Upper ( idw_criteria.object.field_set [ll_row] )
	// If ls_field_parm has 'set' in it, convert it to 'field'
	li_pos			=	Pos (ls_field_parm, 'SET')
	IF	li_pos		>	0		THEN
		ls_field_parm	=	'FIELD'	+	Mid (ls_field_parm, 4)
	END IF
	ls_one			=	'@'	+	ls_field_parm
	ls_two			=	'@@'	+	ls_field_parm
	ls_three			=	'@@@'	+	ls_field_parm
	// The old code accessed patt_field_parm to get ls_one_value.  No longer necessary since
	//	the d/w already gets it from patt_field_parm
	ls_one_value	=	ls_col_name
	IF	Upper (ls_one_value)	=	'DAYS'			&
	OR	Upper (ls_one_value)	=	'OCCURRENCES'	&
	OR	Upper (ls_one_value)	=	'PROVIDERS'		THEN
		ls_one_value	=	idw_criteria.object.field_value [ll_row]
		IF	NOT	IsNumber (ls_one_value)		THEN
			ls_one_value	=	idw_criteria.object.field_description [ll_row]
			MessageBox ('Error', 'Please enter a value for '	+	ls_one_value)
			Destroy	lds_patt_template
			Return	lcs_error
		END IF
	ELSE
		li_rc		=	This.uf_format_line (ll_row)
		IF	li_rc	<	0		THEN
			Destroy	lds_patt_template
			Return	lcs_error
		END IF
		ls_two_value	=	is_where_clause [ll_row]
	END IF
	// Patterns 21 and 22 have to allow for multiple likes
	IF	Match (ls_patt_cond, lcs_likes)	THEN
		// Found '%LIKES' within patt_cond
		IF	Match (Upper(ls_two_value), lcs_type_bill)		THEN
			// Found 'TYPE_BILL' within the where clause
			ll_start		=	1
			IF	li_first_type_bill	=	0		THEN
				ls_alias	=	lcs_alias_a
				li_first_type_bill	++
			ELSE
				ls_alias	=	lcs_alias_c
			END IF						//	li_first_type_bill =	0
			DO
				ll_pos	=	Pos (Upper(ls_two_value), lcs_type_bill, ll_start)
				IF	ll_pos	>	0		THEN
					// Found 'TYPE_BILL' within the where clause.  Append the alias in
					//	front of 'TYPE_BILL'
					ls_front	=	Left (ls_two_value, ll_pos - 1)
					ls_back	=	Mid (ls_two_value, ll_pos)
					ls_two_value	=	ls_front	+	ls_alias	+	ls_back
					ll_start	=	ll_pos	+	Len(lcs_type_bill)
				END IF
			LOOP UNTIL	ll_pos	<=	0
		END IF							//	Match (Upper(ls_two_value), lcs_type_bill)
	END IF								//	Match (ls_patt_cond, lcs_likes)
	//	Replace the @@@fields in the SQL (Column description)
	ls_old	=	ls_three
	ls_new	=	ls_col_desc
	This.uf_replace_sql (ls_old, ls_new)
	//	Replace the @@fields in the SQL (Where clause)
	ls_old	=	ls_two
	ls_new	=	ls_two_value
	This.uf_replace_sql (ls_old, ls_new)
	//	Replace the @fields in the SQL (Column name)
	ls_old	=	ls_one
	ls_new	=	ls_one_value
	This.uf_replace_sql (ls_old, ls_new)
	// Replace the base types with table types
	FOR	li_tbl_no	=	1	TO	li_num_tables
		li_rc	=	This.uf_filter_stars_rel (is_subset_tbl_type[li_tbl_no])
		IF	li_rc	<	0		THEN
			Destroy	lds_patt_template
			Return	lcs_error
		END IF
		ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]
		ls_tbl_name		=	fx_build_subset_table_name (is_subset_tbl_type[li_tbl_no],	&
																	is_subset_id)
		CHOOSE CASE	ls_base_type
			CASE	'UB92'
				ls_old	=	'@UB92'
			CASE	'1500'
				ls_old	=	'@1500'
			CASE ELSE
				// FDG 03/01/00 - Track 2707c
				IF	is_pattern_id	=	ics_filter_pat		THEN
					// Can do a filter pattern on a pharmacy subset.  This value in ls_old
					//	won't be found.
					ls_old	=	'@1500'
				ELSE
					MessageBox ('Warning', 'Except for filter patterns, flexible patterns are not '	+	&
									'permitted for table type '	+	is_subset_tbl_type[li_tbl_no] )
					Destroy	lds_patt_template
					Return	lcs_error
				END IF
		END CHOOSE
		ls_new	=	is_subset_tbl_type [li_tbl_no]
		This.uf_replace_sql (ls_old, ls_new)
		CHOOSE CASE	ls_base_type
			CASE	'UB92'
				ls_old	=	'@TBUB92'
			CASE	'1500'
				ls_old	=	'@TB1500'
			CASE ELSE
				// FDG 03/01/00 - Track 2707c
				IF	is_pattern_id	=	ics_filter_pat		THEN
					// Can do a filter pattern on a pharmacy subset.  This value in ls_old
					//	won't be found.
					ls_old	=	'@TB1500'
				ELSE
					MessageBox ('Warning', 'Except for filter patterns, flexible patterns are not '	+	&
									'permitted for table type '	+	is_subset_tbl_type[li_tbl_no] )
					Destroy	lds_patt_template
					Return	lcs_error
				END IF
		END CHOOSE
		IF	ib_background_flag		THEN
			//	12/04/00	GaryR		Stars 4.7 DataBase Port
			//ls_tbl_name	=	Upper (Stars2ca.Database)	+	'..'	+	ls_tbl_name
			ls_tbl_name	=	gnv_sql.of_get_database_prefix( Upper(Stars2ca.Database) ) + ls_tbl_name
		END IF
		ls_new	=	ls_tbl_name
		This.uf_replace_sql (ls_old, ls_new)
		// Get the revenue table name and replace '@TBREV' with the revenue table name.
		IF	ls_base_type	=	'UB92'		THEN
			ls_revenue		=	inv_revenue.of_get_revenue (is_subset_tbl_type[li_tbl_no])
			ls_tbl_name		=	fx_build_subset_table_name (ls_revenue, is_subset_id)
			IF	ib_background_flag		THEN
				//	12/04/00	GaryR		Stars 4.7 DataBase Port
				//ls_tbl_name	=	Upper (Stars2ca.Database)	+	'..'	+	ls_tbl_name
				ls_tbl_name	=	gnv_sql.of_get_database_prefix( Upper (Stars2ca.Database) ) +	ls_tbl_name
			END IF
			ls_old			=	'@TBREV'
			ls_new			=	ls_tbl_name
			This.uf_replace_sql (ls_old, ls_new)
		END IF							//	ls_base_type =	'UB92'
	NEXT									//	li_tbl_no =	1	TO	li_num_tables
NEXT										//	ll_row =	1	TO	ll_rowcount

ls_sql	=	is_sql

IF	lb_dep_set_sql		THEN
	// Replace each occurrence of '@VALUE1' with its actual value.
	ls_value1	=	''
	li_upper	=	UpperBound (is_value1)
	FOR	li_idx	=	1	TO	li_upper
		IF	is_value1 [li_idx]	<>	''		THEN
			IF	li_idx	>	1		THEN
				ls_value1	=	ls_value1	+	','
			END IF
			ls_value1	=	ls_value1	+	is_value1[li_idx]
		END IF
	NEXT
	DO
		ll_pos	=	Pos (ls_sql, lcs_value1)
		IF	ll_pos	>	0		THEN
			// Found '@VALUE1'.  Replace '@VALUE1' with its actual value.
			ls_front	=	Left (ls_sql, ll_pos - 1)
			ls_back	=	Mid (ls_sql, ll_pos + Len(lcs_value1))
			ls_sql	=	ls_front	+	ls_value1	+	ls_back
		END IF
	LOOP	UNTIL	ll_pos	=	0
	// Replace each occurrence of '@VALUE2' with its actual value.
	ls_value2	=	''
	li_upper	=	UpperBound (is_value2)
	FOR	li_idx	=	1	TO	li_upper
		IF	is_value2 [li_idx]	<>	''		THEN
			IF	li_idx	>	1		THEN
				ls_value2	=	ls_value2	+	','
			END IF
			ls_value2	=	ls_value2	+	is_value2[li_idx]
		END IF
	NEXT
	DO
		ll_pos	=	Pos (ls_sql, lcs_value2)
		IF	ll_pos	>	0		THEN
			// Found '@VALUE2'.  Replace '@VALUE2' with its actual value.
			ls_front	=	Left (ls_sql, ll_pos - 1)
			ls_back	=	Mid (ls_sql, ll_pos + Len(lcs_value2))
			ls_sql	=	ls_front	+	ls_value2	+	ls_back
		END IF
	LOOP	UNTIL	ll_pos	=	0
END IF									//	lb_dep_set_sql

is_sql	=	ls_sql

IF	is_pattern_id	=	ics_filter_pat		THEN
	li_rc	=	This.Event	ue_filter_pat()
	IF	li_rc	<	0		THEN
		Destroy	lds_patt_template
		Return	lcs_error
	END IF
END IF

// Now that the prefixes and table types are registered, edit the SQL to
//	replace some additional placeholders in the Where clause (in is_sql)
This.uf_edit_sql()

Destroy	lds_patt_template

Return	is_sql


end event

event type integer ue_filter_pat();//*********************************************************************************
// Script Name:	ue_filter_pat
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This script is called for a filter pattern (ue_spec_sql) and
//						will create the SQL for a filter pattern.
//						
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	12/04/00	GaryR	Stars 4.7	DataBase Port - Prefixing the DataBase name.
//	12/14/00	FDG	Stars 4.7.	Make data type checking DBMS-independent.
//	04/20/01	GaryR	Stars 4.7	DataBase Port - Column Aliases.
//	01/17/02	GaryR	Track 2701d	Unable to create a filter Pattern.
//	02/12/02	FDG	Track 2701d Allow subsetting of a filter pattern by adding the
//										row to report_cols.
//
//*********************************************************************************

Boolean	lb_found,				&
			lb_unique

Constant String	lcs_not_operator = 'not in'
Constant String	lcs_operator = 'in'
Constant String	lcs_select_place_hold = '@SEL_CLAUSE'
Constant String	lcs_table_place_hold = '@TBL_NAME'
Constant String	lcs_operator_place_hold = '@OPERATOR'
//Constant String	lcs_filter_name_place_hold = '@FILTER_NAME'		//	01/17/02	GaryR	Track 2701d
Constant String	lcs_filter_table_place_hold = '@FILTER_TABLE'
Constant String	lcs_column_name = 'FILTER_DATA'

Integer	li_upper,				&
			li_idx,					&
			li_pos,					&
			li_len,					&
			li_rc

Long		ll_find_row,			&
			ll_new_row

String	ls_sql,					&
			ls_tbl_type,			&
			ls_label,				&
			ls_value,				&
			ls_select,				&
			ls_select_keys,		&
			ls_dep_select,			&
			ls_tbl_name,			&
			ls_filter_table,		&
			ls_filter_table_name, &
			ls_operator,			&
			ls_data_type,			&
			ls_find,					&
			ls_col_name				//	01/17/02	GaryR	Track 2701d

ls_sql		=	is_sql				// Preserve is_sql in case any errors happen
ls_col_name	=	idw_criteria.object.field_col_name [1]		//	01/17/02	GaryR	Track 2701d
ls_tbl_type	=	idw_criteria.object.field_tbl_type [1]
ls_label		=	idw_criteria.object.field_description [1]
ls_value		=	idw_criteria.object.field_value [1]
ls_value		=	Mid (ls_value, 2)		// Remove the leading @

// Reset the previously registered prefixes and invoice types
This.uf_clear_from_tables()
// Register the prefix ('A')
This.uf_set_prefix ('A')
// Register the invoice type in order to get its unique keys
This.uf_set_tbl_type (ls_tbl_type)

// Load istr_from_tables[] based on what is in dw_criteria and dw_selected.
li_rc	=	This.Event	ue_pattern_from()

// Retrieve the unique key columns for the table types.
li_rc	=	This.uf_retrieve_tbl_type()

// Make sure that the unique key columns are included in the Select clause
//	by moving them from idw_available to idw_selected
li_rc	=	This.Event	ue_select_unique_key_columns()

ls_select	=	This.Event	ue_pattern_select (ls_tbl_type, 'A', ls_tbl_type + '1', TRUE, '')

// Get the select to the left of ':'
IF	ls_select	<>	''		THEN
	li_pos	=	Pos (ls_select, ':')
	IF	li_pos	>	0		THEN
		ls_select	=	Left (ls_select, li_pos - 1)
	END IF
END IF

// Append the selected column in the criteria to the Select (if it isn't already included)
//	01/17/02	GaryR	Track 2701d - Begin
//ls_find		=	"elem_tbl_type = '"		+	ls_tbl_type	+	&
//					"' and elem_name = '"	+	lcs_column_name	+	"'"
ls_find		=	"elem_tbl_type = '"		+	ls_tbl_type	+	&
					"' and elem_name = '"	+	ls_col_name	+	"'"
//	01/17/02	GaryR	Track 2701d - End
ll_find_row	=	idw_selected.Find (ls_find, 1, idw_available.RowCount() )

IF	ll_find_row	=	0		THEN
	// Criteria column has not been selected.  Add it to the SQL.
	//	04/20/01	GaryR	Stars 4.7 DataBase Port
	//	01/17/02	GaryR	Track 2701d - Begin
//	ls_select	=	ls_select	+	', A.'	+	lcs_column_name	+	' "'	+	ls_tbl_type	+	&
//						'1 '	+	ls_label	+	'" '
	ls_select	=	ls_select	+	', A.'	+	ls_col_name	+	' "'	+	ls_tbl_type	+	&
						'1 '	+	ls_label	+	'" '
	// FDG 02/12/02 begin
	ll_new_row			=	ids_report_cols.InsertRow(0)
	ids_report_cols.object.tbl_type [ll_new_row]		=	ls_tbl_type
	ids_report_cols.object.col_name [ll_new_row]		=	ls_col_name
	ids_report_cols.object.alias_name [ll_new_row]	=	ls_label
	ids_report_cols.object.query_pos [ll_new_row]	=	ll_new_row
	ids_report_cols.object.delete_ind [ll_new_row]	=	'N'
	lb_unique	=	This.uf_is_unique_key (ls_tbl_type, ls_col_name)
	IF	lb_unique		THEN
		ids_report_cols.object.key_ind [ll_new_row]	=	'Y'
	ELSE
		ids_report_cols.object.key_ind [ll_new_row]	=	'N'
	END IF
	// FDG 02/12/02 end
	//	01/17/02	GaryR	Track 2701d - End					
END IF

// See if the table type is a main or dependent.  If found, it's a main table.
li_upper	=	UpperBound (is_subset_tbl_type)

FOR	li_idx	=	1	TO	li_upper
	IF	ls_tbl_type	=	is_subset_tbl_type [li_idx]		THEN
		lb_found	=	TRUE
	END IF
NEXT

li_pos	=	Pos (ls_sql, lcs_select_place_hold)
li_len	=	Len (lcs_select_place_hold)
ls_sql	=	Replace (ls_sql, li_pos, li_len, ls_select)

ls_tbl_name	=	fx_build_subset_table_name (ls_tbl_type, is_subset_id)

// If subsetting the pattern in background mode, add the database name

ls_filter_table = gnv_server.of_GetFilterTableName(ls_value)

IF	ib_background_flag	=	TRUE		THEN
	//	12/04/00	GaryR		Stars 4.7 DataBase Port - Begin
//	ls_tbl_name	=	Upper (Stars2ca.Database)	+	'..'	+	ls_tbl_name
//	ls_filter_table	=	Upper (Stars2ca.Database)	+	'..'	+	lcs_filter_table
	ls_tbl_name	=	gnv_sql.of_get_database_prefix( Upper (Stars2ca.Database) )	+ ls_tbl_name
	ls_filter_table	=	gnv_sql.of_get_database_prefix( Upper (Stars2ca.Database) )	+ gnv_server.of_GetFilterTableName(ls_value)
	//	12/04/00	GaryR		Stars 4.7 DataBase Port - End
END IF

// Replace the filter table name placeholder with the filter table name
li_pos	=	Pos (ls_sql, lcs_filter_table_place_hold)
li_len	=	Len (lcs_filter_table_place_hold)
//ls_sql	=	Replace (ls_sql, li_pos, li_len, "'" + ls_filter_table + "'")
ls_sql	=	Replace (ls_sql, li_pos, li_len, ls_filter_table )		//	01/17/02	GaryR	Track 2701d

// Replace the table name placeholder with the table name
li_pos	=	Pos (ls_sql, lcs_table_place_hold)
li_len	=	Len (lcs_table_place_hold)
ls_sql	=	Replace (ls_sql, li_pos, li_len, ls_tbl_name)

// Append 'in' or 'not in'
IF	ib_not_flag	=	TRUE		THEN
	ls_operator	=	lcs_not_operator
ELSE
	ls_operator	=	lcs_operator
END IF

// Replace the operator placeholder with the operator
li_pos	=	Pos (ls_sql, lcs_operator_place_hold)
li_len	=	Len (lcs_operator_place_hold)
ls_sql	=	Replace (ls_sql, li_pos, li_len, ls_operator)

// Get the data type for the specified column

SELECT	FILTER_DATA_TYPE
INTO		:ls_data_type
FROM		FILTER_CNTL
WHERE		FILTER_ID = Upper( :ls_value )
USING 	STARS2CA;

IF Stars2ca.of_check_status() <> 0	THEN
	MessageBox ('Database Error', 'Filter '	+	ls_value	+	' is not a valid filter.')
	Return -1
END IF

//	01/17/02	GaryR	Track 2701d - Begin
//// Replace the filter name placeholder with the filter value
//li_pos	=	Pos (ls_sql, lcs_filter_name_place_hold)
//li_len	=	Len (lcs_filter_name_place_hold)
//ls_sql	=	Replace (ls_sql, li_pos, li_len, "'" + ls_value + "'")
//	01/17/02	GaryR	Track 2701d - End

is_sql	=	ls_sql

Return	1
end event

event type integer ue_select_unique_key_columns();//*********************************************************************************
// Script Name:	ue_select_unique_key_columns
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered from ue_pattern_sql after ue_pattern_from 
//						(ue_pattern_from fills in istr_from_tables).
//
//						This event will make sure that all unique key columns are
//						included in the SQL.  This is done by moving these columns
//						from idw_available to idw_selected.
//
//	Notes:			The middleware, when creating a subset from a pattern, requires
//						that all unique key columns be included in the SELECT.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// 11/14/02 JasonS Track 2763d Allow user to move ICN
//*********************************************************************************

Integer	li_idx,				&
			li_idx2,				&
			li_upper,			&
			li_upper2

Long		ll_row,				&
			ll_rowcount,		&
			ll_find_row,		&
			ll_select_count

String	ls_tbl_type,		&
			ls_find,				&
			ls_key_columns[],	&
			ls_col_name
			
li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	ls_tbl_type		=	istr_from_tables[li_idx].tbl_type
	IF	IsNull (ls_tbl_type)			&
	OR	ls_tbl_type		=	''			THEN
		Continue
	END IF
	li_upper2		=	istr_from_tables[li_idx].ids_index_columns.RowCount()
	FOR	li_idx2	=	1	TO	li_upper2
		ls_col_name	=	istr_from_tables[li_idx].ids_index_columns.object.elem_name [li_idx2]
		ls_find		=	"elem_tbl_type = '"		+	ls_tbl_type	+	&
							"' and elem_name = '"	+	ls_col_name	+	"'"
		ll_find_row	=	idw_available.Find (ls_find, 1, idw_available.RowCount() )
		IF	ll_find_row		>	0		THEN
			// Found the unique key in dw_available.  Move it to dw_selected.
			ll_select_count	=	idw_selected.RowCount()
			idw_available.RowsMove	(ll_find_row,				&
											ll_find_row,				&
											Primary!,					&
											idw_selected,				&
											ll_select_count + 1,		&
											Primary!)
		END IF
	NEXT
NEXT

// Because of the possibility of issuing a 'Select Distinct', make sure that ICN is the
//	first column in the Select.  This has an impact in the result set.
ls_col_name	=	Upper ( idw_selected.object.elem_name [1] )

// Unhilite all rows
idw_available.SelectRow (0, FALSE)
Return	1
end event

event type string ue_create_temp_table();//*********************************************************************************
// Script Name:	ue_create_temp_table
//
//	Arguments:		None
//
// Returns:			String
//
//	Description:	This script is called from w_sampling_analysis_new.ue_subset
//						and will perform the logic necessary to create the temp table
//						and to insert the data into the temp table.
//						
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	12/11/00	FDG	Stars 4.7.  
//						1.	Allow for ignore dup key
//						2.	Make data type checking DBMS-independent
//	03/20/01	FDG	Stars 4.7.  Pass the invoice types when creating a temp table.
//						For a ML pattern, lnv_temp_attrib.is_inv_type can = 'C1+C2'
//	03/26/01	GaryR	Stars 4.7 - Eliminate as_job_id parameter.
// 08/08/01	GaryR	Track 2396d	Functional flaw creating subsets
// 08/28/01	GaryR	Track 2404d	Inserting values not matching the column order
//	11/02/01	FDG	Track 2457d.  When a table is joined onto itself more than twice,
//						too many columns get inserted into the temp table.  Please note
//						that 2 dimensional tables must be fixed in size.
//	04/15/02	FDG	Track 2974d.  In a ML pattern, if only one of two table types does
//						a self-join (i.e. CF-CH-CF), then the 2nd insert into the temp
//						table does not include all columns.  This is done by adding the CH
//						columns to tbl2_unique_cols[].
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//
//*********************************************************************************

Boolean	lb_found,						&
			lb_found_unique,				&
			lb_found_dup

Integer	tbl1_unique_cols[],			&
			tbl2_unique_cols[6, 10],	&
			li_tbl1_upper,					&
			li_tbl2_upper,					&
			li_tbl_type_upper,			&
			li_unique_upper,				&
			li_unique2_upper,				&
			li_unique3_upper = 10,		&
			li_query_pos,					&
			li_idx,							&
			li_idx2,							&
			li_idx3,							&
			li_idx4,							&
			li_idx5,							&
			li_idx6,							&
			li_idx7,							&
			li_pos,							&
			li_data_len,					&
			li_column,						&
			li_found_colnum,				&
			li_number_dups,				&
			li_rc

Long		ll_row,							&
			ll_row2,							&
			ll_rowcount,					&
			ll_find_row

String	ls_col_name,					&
			ls_col_name2,					&
			ls_data_type,					&
			ls_index_type,					&
			ls_key_ind,						&
			ls_key_ind2,					&
			ls_sql,							&
			ls_table,						&
			ls_tbl_type,					&
			ls_tbl_type2,					&
			ls_temp_sql,					&
			ls_temp_sql2,					&
			ls_unique_tbl_type[],		&
			ls_tbl2_unique_col_name[6, 10],	&
			ls_tbl2_col_name,				&
			ls_tbl1_unique_col_name[],	&
			ls_value

n_cst_temp_table			lnv_temp_table
n_cst_temp_table_attrib	lnv_temp_attrib

w_main.setMicroHelp ('Creating the KEY Table ...')

// Initialize data in lnv_temp_attrib
lnv_temp_attrib.is_function					=	'CREATE'
//lnv_temp_attrib.is_table_name					=	'KEY_'	+	as_job_id		// FDG 03/21/01
lnv_temp_attrib.is_table_name					=	''										// FDG 03/21/01

// Loop thru ids_report_cols to get the unique key columns.  If the combination
//	of tbl type and column name exists twice (a table is joined onto itself),
//	separate the 2nd occurence of the unique key columns into tbl2_unique_cols.
//	When a table is joined onto itself, each unique key value in the report
//	will be a separate row in the temp table.

ll_rowcount	=	ids_report_cols.Rowcount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	ids_report_cols.object.col_name [ll_row]
	ls_tbl_type		=	ids_report_cols.object.tbl_type [ll_row]
	ls_key_ind		=	Upper (ids_report_cols.object.key_ind [ll_row] )
	// query_pos should alway match the row #
	li_query_pos	=	ids_report_cols.object.query_pos [ll_row]
	IF	ls_key_ind	<>	'Y'		THEN
		// Not a unique key.  Get the next entry.
		Continue
	END IF
	// Have a unique key.  If this unique key already exists, then
	// add the column # to tbl2_unique_cols[] instead of
	// tbl1_unique_cols[]
	lb_found		=	FALSE
	FOR	ll_row2	=	1	TO	ll_row - 1
		ls_col_name2		=	ids_report_cols.object.col_name [ll_row2]
		ls_tbl_type2		=	ids_report_cols.object.tbl_type [ll_row2]
		ls_key_ind2			=	Upper (ids_report_cols.object.key_ind [ll_row2] )
		IF	 ls_key_ind2	=	'Y'				&
		AND ls_col_name2	=	ls_col_name		&
		AND ls_tbl_type2	=	ls_tbl_type		THEN
			// Unique key match
			lb_found			=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_found		THEN
		// Duplicate unique key
		// FDG 11/02/01 - Must now determine if if the table was joined more than
		//	twice.  That's why the duplicate columns will be placed in a 2-dimensional
		//	array.
		//li_tbl2_upper	++
		//tbl2_unique_cols [li_tbl2_upper]	=	ll_row
		li_found_colnum	=	0
		lb_found_dup		=	FALSE
		ls_tbl2_col_name	=	ls_tbl_type	+	'_'	+	ls_col_name
		li_tbl2_upper		=	UpperBound (ls_tbl2_unique_col_name)
		li_unique2_upper	=	UpperBound (ls_tbl2_unique_col_name, 2)
		FOR li_idx6		=	1	TO	li_tbl2_upper
			FOR li_idx7		=	1	TO	li_unique2_upper
				IF	ls_tbl2_unique_col_name [li_idx6, li_idx7]	=	""	THEN
					// End of this loop.  If the 1st entry in the 2nd dimension is null
					//	then, the entire 1st dimension is null
					//IF	li_idx7	=	1		THEN
					//	li_tbl2_upper	=	li_idx6	-	1
					//END IF
					Exit
				END IF
				IF	ls_tbl2_col_name	=	ls_tbl2_unique_col_name [li_idx6, li_idx7]	THEN
					// Found the duplicate key
					lb_found_dup		=	TRUE
					li_found_colnum	=	li_idx7
					Exit
				END IF
			NEXT
		NEXT
		IF	lb_found_dup	=	FALSE		THEN
			// Did not find a duplicate column.  Find the 1st available column
			FOR li_idx7		=	1	TO	li_unique2_upper
				IF	tbl2_unique_cols [1, li_idx7]	=	0		THEN
					li_found_colnum	=	li_idx7
					Exit
				END IF
			NEXT
		END IF
		//IF	lb_found_dup				&
		//OR	li_found_columns	=	1	THEN
		//	// Found the duplicate key (table joined more than twice) or 1st time
		//	li_tbl2_upper	++
		//END IF
		// Add the duplicate col_name and its d/w column # to the 2nd dimension
		FOR li_idx6		=	1	TO	li_tbl2_upper
			IF	tbl2_unique_cols [li_idx6, li_found_colnum]	=	0		THEN
				li_number_dups	++
				tbl2_unique_cols [li_idx6, li_found_colnum]			=	ll_row
				ls_tbl2_unique_col_name [li_idx6, li_found_colnum]	=	ls_tbl2_col_name
				Exit
			END IF
		NEXT
		// FDG 11/02/01 end
	ELSE
		li_tbl1_upper	++
		tbl1_unique_cols [li_tbl1_upper]	=	ll_row
		// FDG 04/15/02 - store the column name for future reference
		ls_tbl1_unique_col_name [li_tbl1_upper]	=	ls_tbl_type	+	'_'	+	ls_col_name
		// Add the table type to the list of unique table types
		lb_found_unique	=	FALSE
		li_unique_upper	=	UpperBound (ls_unique_tbl_type)
		FOR	li_idx4		=	1	TO	li_unique_upper
			IF	ls_tbl_type	=	ls_unique_tbl_type [li_idx4]		THEN
				lb_found_unique	=	TRUE
				Exit
			END IF
		NEXT
		IF	lb_found_unique		=	FALSE		THEN
			// Add the table type to the list of unique table types
			li_unique_upper	++
			ls_unique_tbl_type [li_unique_upper]	=	ls_tbl_type
			lnv_temp_attrib.is_inv_type	+=	'+'	+	ls_tbl_type			// FDG 03/21/01
		END IF
	END IF
NEXT

// FDG 03/21/01 - remove the leading '+' in front of lnv_temp_attrib.is_inv_type
lnv_temp_attrib.is_inv_type	=	Mid (lnv_temp_attrib.is_inv_type, 2)

// Create the index on what is in tbl1_unique_cols[] only.
li_tbl1_upper		=	UpperBound (tbl1_unique_cols)
li_tbl2_upper		=	UpperBound (tbl2_unique_cols)
li_tbl_type_upper	=	UpperBound (istr_from_tables)
li_unique_upper	=	UpperBound (ls_unique_tbl_type)

// FDG 04/15/02 - Make sure that tbl2_unique_cols[] includes any missing columns stored in
//	ls_tbl1_unique_col_name[].
FOR	li_idx	=	1	TO	li_tbl1_upper
	// Get the next ls_tbl1_unique_col_name[] in this loop
	FOR	li_idx2	=	1	TO	li_tbl2_upper
		IF	Trim (ls_tbl2_unique_col_name[li_idx2, 1])	<	' '	THEN
			// This dimension has no entries.  Get out.
			Exit
		END IF
		lb_found_unique	=	FALSE
		FOR	li_idx4	=	1	TO	li_unique3_upper
			IF	ls_tbl1_unique_col_name[li_idx]	=	ls_tbl2_unique_col_name[li_idx2, li_idx4]	THEN
				// Found the column in ls_tbl2_unique_col_name[].  Get out of this loop.
				lb_found_unique	=	TRUE
				Exit
			END IF
			IF	Trim(ls_tbl2_unique_col_name[li_idx2, li_idx4])	=	''		&
			AND lb_found_unique	=	FALSE											THEN
				// Did not find the column in ls_tbl2_unique_col_name[].  Add the column.
				ls_tbl2_unique_col_name[li_idx2, li_idx4]	=	ls_tbl1_unique_col_name[li_idx]
				tbl2_unique_cols[li_idx2, li_idx4]			=	tbl1_unique_cols[li_idx]
				Exit
			END IF
		NEXT
	NEXT
NEXT
// FDG 04/15/02 end

// Loop thru the unique key columns to get a list of unique key table types.
// If more than one table type exists, then separate non-unique indexes
//	will be created for each table type.
IF	li_unique_upper	>	1		THEN
	// Multiple table types exist.  Indexes will be non-unique
	ls_index_type		=	'D'
ELSE
	//	One index.  Use ignore dup key
	ls_index_type		=	'I'
END IF

FOR	li_idx	=	1	TO	li_tbl1_upper
	ll_row			=	tbl1_unique_cols [li_idx]
	ls_col_name		=	ids_report_cols.object.col_name [ll_row]
	ls_tbl_type		=	Upper( ids_report_cols.object.tbl_type [ll_row] )
	ls_key_ind		=	Upper (ids_report_cols.object.key_ind [ll_row] )
	
	// If there's a '+' in ls_col_name, remove it.
	li_pos			=	Pos (ls_col_name, '+')
	IF	li_pos	>	0		THEN
		ls_col_name	=	Left (ls_col_name, li_pos - 1)
	END IF
	// Find the unique key column in order to get the column's data type
	FOR	li_idx2	=	1	TO	li_tbl_type_upper
		IF	istr_from_tables[li_idx2].tbl_type	=	ls_tbl_type		THEN
			// Match on tbl type.  Find the column.
			ls_data_type	=	gnv_dict.event ue_get_data_type( ls_tbl_type, ls_col_name )
			li_data_len		=	gnv_dict.event ue_get_data_len( ls_tbl_type, ls_col_name )

			// FDG 12/14/00 - Make the checking of data types DBMS-independent.
			IF gnv_sql.of_is_character_data_type (ls_data_type)		THEN
				// Get the length and attach it to the data type
				ls_data_type	=	ls_data_type	+	"("	+	&
										String (li_data_len, "000")	+	")"
			END IF
			li_idx3	++
			// Set the column name to insure uniqueness (i.e. C1_ICN)
			ls_col_name	=	ls_tbl_type	+	"_"	+	ls_col_name
			lnv_temp_attrib.istr_cols[li_idx3].is_col_name					=	ls_col_name
			lnv_temp_attrib.istr_cols[li_idx3].is_data_type					=	ls_data_type
			// Set the index.  If multiple table types exists, then create a separate
			//	non-unique index for each table type.
			FOR	li_idx4	=	1	TO	li_unique_upper
				IF	ls_tbl_type		=	ls_unique_tbl_type [li_idx4]		THEN
					lnv_temp_attrib.istr_index_cols[li_idx4].is_index_type				=	ls_index_type
					li_idx5	=	UpperBound (lnv_temp_attrib.istr_index_cols[li_idx4].is_index_col)
					li_idx5	++
					lnv_temp_attrib.istr_index_cols[li_idx4].is_index_col[li_idx5]		=	ls_col_name
					Exit
				END IF
			NEXT						//	li_idx4	=	1	TO	li_unique_upper
			Exit
		END IF						//	istr_from_tables[li_idx].tbl_type =	ls_tbl_type
	NEXT								//	li_idx2	=	1	TO	li_tbl_type_upper
NEXT									//	li_idx	=	1	TO	li_tbl1_upper

// Execute the SQL to create the temp table
lnv_temp_table	=	CREATE	n_cst_temp_table

lnv_temp_attrib.ii_request	=	lnv_temp_attrib.ici_key_table			// FDG 03/21/01

li_rc		=	lnv_temp_table.of_execute_sql (lnv_temp_attrib)

IF	li_rc	>	0		THEN
	is_temp_table	=	lnv_temp_table.of_get_table_name()
	//	12/04/00	GaryR		Stars 4.7 DataBase Port
	//ls_table			=	Stars2ca.Database	+	'..'	+	is_temp_table
	ls_table			=	gnv_sql.of_get_database_prefix( Stars2ca.Database ) +	is_temp_table
	// 08/08/01	GaryR	Track 2396d
	il_server_job_id = lnv_temp_table.of_get_server_job_id()
ELSE
	MessageBox ('Application Error',	'In u_nvo_pattern_sql.ue_create_temp_table '	+	&
					'(from w_sampling_analysis_new.ue_subset), error creating the '	+	&
					'KEY Table.   Subset will not be created.')
	Stars2ca.of_rollback()
	Destroy	lnv_temp_table
	Return	'ERROR'
END IF

w_main.setMicroHelp ('Inserting into the KEY Table ...')

// Insert the ICNs into the temp table.  If there are columns stored in
//	tbl2_unique_cols[], then a table is joined onto itself.  When this occurs,
//	add a second row with the unique keys.

ll_rowcount	=	idw_report.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	// Insert the data for the columns stored in tbl1_unique_cols []
	//ls_sql			=	"Insert Into "	+	ls_table	+	" values ("
	ls_sql			=	"Insert Into "	+	ls_table			// 08/28/01	GaryR	Track 2404d
	ls_temp_sql		=	''
	ls_temp_sql2	=	''	// 08/28/01	GaryR	Track 2404d
	FOR	li_idx	=	1	TO	li_tbl1_upper
		li_column	=	tbl1_unique_cols [li_idx]
		
		// 08/28/01	GaryR	Track 2404d - Begin
		// Obtain the name of the columns in the key table
		ls_col_name		=	ids_report_cols.object.col_name [li_column]
		ls_tbl_type		=	ids_report_cols.object.tbl_type [li_column]
		// Assamble the column name to insure uniqueness (i.e. C1_ICN)
		ls_col_name	=	ls_tbl_type	+	"_"	+	ls_col_name
		ls_temp_sql2 += ", " + ls_col_name
		// 08/28/01	GaryR	Track 2404d - End
		
		ls_value		=	This.uf_get_string_value (ll_row, li_column)
		IF	ls_value	<>	''		THEN
			ls_temp_sql	=	ls_temp_sql	+	", "	+	ls_value
		END IF
	NEXT
	// 08/28/01	GaryR	Track 2404d - Begin
	//ls_temp_sql		=	Mid (ls_temp_sql, 3)		// Remove leading ', '
	// Remove leading ', ' and format the insert clauses
	ls_temp_sql		=	" values ( " + Mid (ls_temp_sql, 3) + " ) "
	ls_temp_sql2	=	" ( " + Mid (ls_temp_sql2, 3) + " ) "
	//ls_sql			=	ls_sql	+	ls_temp_sql	+	")"
	ls_sql			=	ls_sql	+	ls_temp_sql2	+	ls_temp_sql
	// 08/28/01	GaryR	Track 2404d - End
	
	// Insert the value
	// FDG 12/11/00 - Allow for ignore dup key
	//li_rc				=	Stars2ca.of_execute (ls_sql)
	li_rc				=	Stars2ca.of_insert (ls_sql)
	IF	li_rc			<	0		THEN
		MessageBox ('Application Error',	'In u_nvo_pattern_sql.ue_create_temp_table '	+	&
						'(from w_sampling_analysis_new.ue_subset), could not insert the '	+	&
						'data into the Key Table.   SQL = '	+	ls_sql	+	'.')
		Stars2ca.of_rollback()
		Destroy	lnv_temp_table
		Return	'ERROR'
	END IF
	//	IF there are columns in tbl2_unique_cols [], insert this data also.
	IF	li_number_dups	>	0		THEN
		// FDG 11/02/01 - The # of additional inserts depends on the # of times the
		//	same table joins upon itself.  As a result, place this in a loop.
		FOR li_idx	=	1	TO	li_tbl2_upper
			//ls_sql			=	"Insert Into "	+	ls_table	+	" values ("
			IF	tbl2_unique_cols [li_idx, 1]	=	0		THEN
				// No columns - get out
				Exit
			END IF
			ls_temp_sql		=	''
			ls_temp_sql2	=	''	// 08/28/01	GaryR	Track 2404d
			ls_sql			=	"Insert Into "	+	ls_table			// 08/28/01	GaryR	Track 2404d
			li_unique2_upper	=	UpperBound (tbl2_unique_cols, 2)
			FOR	li_idx7	=	1	TO	li_unique2_upper
				li_column		=	tbl2_unique_cols [li_idx, li_idx7]
				IF	li_column	=	0	THEN
					Continue
				END IF
				
				// 08/28/01	GaryR	Track 2404d - Begin
				// Obtain the name of the columns in the key table
				ls_col_name		=	ids_report_cols.object.col_name [li_column]
				ls_tbl_type		=	ids_report_cols.object.tbl_type [li_column]
				// Assamble the column name to insure uniqueness (i.e. C1_ICN)
				ls_col_name	=	ls_tbl_type	+	"_"	+	ls_col_name
				ls_temp_sql2 += ", " + ls_col_name
				// 08/28/01	GaryR	Track 2404d - End
				
				ls_value		=	This.uf_get_string_value (ll_row, li_column)
				IF	ls_value	<>	''		THEN
					ls_temp_sql	=	ls_temp_sql	+	", "	+	ls_value
				END IF
			NEXT							// FOR li_idx7	=	1	TO	li_unique2_upper
			//ls_temp_sql		=	Mid (ls_temp_sql, 3)		// Remove leading ', '
			//ls_sql			=	ls_sql	+	ls_temp_sql	+	")"
			
			// 08/28/01	GaryR	Track 2404d - Begin
			//ls_temp_sql		=	Mid (ls_temp_sql, 3)		// Remove leading ', '
			// Remove leading ', ' and format the insert clauses
			ls_temp_sql		=	" values ( " + Mid (ls_temp_sql, 3) + " ) "
			ls_temp_sql2	=	" ( " + Mid (ls_temp_sql2, 3) + " ) "
			//ls_sql			=	ls_sql	+	ls_temp_sql	+	")"
			ls_sql			=	ls_sql	+	ls_temp_sql2	+	ls_temp_sql
			// 08/28/01	GaryR	Track 2404d - End
			
			// Insert the value
			// FDG 12/11/00 - Allow for ignore dup key
			//li_rc				=	Stars2ca.of_execute (ls_sql)
			li_rc				=	Stars2ca.of_insert (ls_sql)
			IF	li_rc			<	0		THEN
				MessageBox ('Application Error',	'In u_nvo_pattern_sql.ue_create_temp_table '	+	&
								'(from w_sampling_analysis_new.ue_subset), could not insert the '	+	&
								'data into the KEY Table.   SQL = '	+	ls_sql	+	'.')
				Stars2ca.of_rollback()
				Destroy	lnv_temp_table
				Return	'ERROR'
			END IF
		NEXT							// FOR li_idx	=	1 TO	li_tbl2_upper
		// FDG 11/02/01 end
	END IF
NEXT									//	ll_row =	1	TO	ll_rowcount

w_main.setMicroHelp ('Data successfully inserted into the KEY Table')

Destroy	lnv_temp_table

Return	ls_table

end event

event ue_pattern_select_add_selected;//*********************************************************************************
// Script Name:	ue_pattern_select_add_selected
//
//	Arguments:		as_select - The originally created Select
//
// Returns:			String - The new select.
//						'Error' - An error occured when generating the select
//
//	Description:	This script is called for a generic pattern (ue_pattern_sql)
//						and will fill in the remaining Select clause.  This is done
//						by looping thru dw_selected and including those columns that
//						have not already been added to the SQL.  Event ue_pattern_select
//						has already set flag is_added_to_sql[] for those columns already
//						added.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean		lb_unique

Integer		li_index

Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_upper

String		ls_label_alias,		&
				ls_prefix,				&
				ls_tbl_type,			&
				ls_select,				&
				ls_dep_select,			&
				ls_data_type,			&
				ls_field_column,		&
				ls_field_label,		&
				ls_alias

ls_select	=	as_select

ll_upper		=	UpperBound (is_added_to_sql)

ll_rowcount	=	idw_selected.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	IF	ll_row							>	ll_upper		THEN
		// set this row to not added
		is_added_to_sql [ll_row]	=	'N'
	END IF
	IF	is_added_to_sql [ll_row]	<>	'Y'			THEN
		// Row not already added.  Add it.
		ls_field_column	=	idw_selected.object.elem_name [ll_row]
		ls_tbl_type			=	idw_selected.object.elem_tbl_type [ll_row]
		ls_field_label		=	Trim ( idw_selected.object.elem_desc [ll_row] )
		ls_data_type		=	Upper (idw_selected.object.elem_data_type [ll_row])
		// Get the unique key info to get the prefix
		li_index				=	This.uf_get_tbl_type_index (ls_tbl_type)
		ls_prefix			=	istr_from_tables[li_index].prefix
		ls_label_alias		=	ls_tbl_type		+	String(li_index)
		// Flag that the column in dw_selected was added to the Select clause
		is_added_to_sql [ll_row]	=	'Y'
		ls_alias				=	ls_label_alias	+	" "	+	ls_field_label
		ls_select			=	ls_select	+	","	+	ls_prefix	+	&
									"."	+	ls_field_column	+	' "'	+	&
									ls_alias	+	'"'
		// Insert the data into ids_report_cols
		ll_new_row			=	ids_report_cols.InsertRow(0)
		ids_report_cols.object.tbl_type [ll_new_row]		=	ls_tbl_type
	
		ids_report_cols.object.col_name [ll_new_row]		=	ls_field_column
		ids_report_cols.object.alias_name [ll_new_row]	=	ls_alias
		ids_report_cols.object.query_pos [ll_new_row]	=	ll_new_row
		ids_report_cols.object.delete_ind [ll_new_row]	=	'N'
		lb_unique	=	This.uf_is_unique_key (ls_tbl_type, ls_field_column)
		IF	lb_unique		THEN
			ids_report_cols.object.key_ind [ll_new_row]	=	'Y'
		ELSE
			ids_report_cols.object.key_ind [ll_new_row]	=	'N'
		END IF
	END IF
NEXT

Return	ls_select



end event

public subroutine uf_set_background_flag (boolean ab_background_flag);//*********************************************************************************
// Script Name:	uf_set_background_flag
//
//	Arguments:		ab_background_flag
//
// Returns:			None
//
//	Description:	Store the boolean stating if the pattern report will be
//						run in the background or be displayed directly on the window.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

ib_background_flag	=	ab_background_flag

end subroutine

public subroutine uf_set_dw_patt_cntl (ref u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw_patt_cntl
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to dw_patt_cntl since dw_patt_cntl is
//						passed by reference.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

idw_patt_cntl	=	adw

end subroutine

public subroutine uf_set_dw_criteria (ref u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw_criteria
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to dw_criteria since dw_criteria is
//						passed by reference.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

idw_criteria	=	adw

end subroutine

public subroutine uf_set_dw_patt_options (ref u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw_patt_options
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to dw_patt_options since dw_patt_options is
//						passed by reference.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

idw_patt_options	=	adw

end subroutine

public subroutine uf_set_subset_tbl_type (string as_tbl_type[]);//*********************************************************************************
// Script Name:	uf_set_subset_tbl_type
//
//	Arguments:		as_tbl_type[] - String array of invoice types.
//
// Returns:			None
//
//	Description:	Store the invoice types into a string array.  If the subset
//						is a ML subset, there can be multiple invoice types in the
//						array.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_subset_tbl_type	=	as_tbl_type

end subroutine

public subroutine uf_set_sub_src_type (string as_sub_src_type);//*********************************************************************************
// Script Name:	uf_set_sub_src_type
//
//	Arguments:		as_sub_src_type
//
// Returns:			None
//
//	Description:	Store sub_src_type (from istr_sub_opt.patt_struc)
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_sub_src_type	=	as_sub_src_type

end subroutine

public subroutine uf_set_subset_id (string as_subset_id);//*********************************************************************************
// Script Name:	uf_set_subset_id
//
//	Arguments:		as_subset_id
//
// Returns:			None
//
//	Description:	Store subset_id (from istr_sub_opt.patt_struc)
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_subset_id	=	as_subset_id

end subroutine

public subroutine uf_set_case_id (string as_case);//*********************************************************************************
// Script Name:	uf_set_case_id
//
//	Arguments:		as_case - The 14-byte case id
//
// Returns:			None
//
//	Description:	Store case_id (from istr_sub_opt.patt_struc).  Please note that
//						the case ID passed must be broken up into case_id, case_spl,
//						and case_ver.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_case_id	=	Left (as_case, 10)
is_case_spl	=	Mid (as_case, 11, 2)
is_case_ver	=	Mid (as_case, 13, 2)

end subroutine

public function integer uf_edit_generic_criteria ();//*********************************************************************************
// Script Name:	uf_edit_generic_criteria
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	When a report is generated or a subset is created for a 
//						generic pattern, edit the criteria.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// JasonS 10/5/04	Track 5651c remove case requirements
//*********************************************************************************

Integer		li_rc

Long			ll_row,				&
				ll_rowcount,		&
				ll_valid_fields

String		ls_col_name,		&
				ls_desc,				&
				ls_field_set

// Initialize the 'set' data
is_set_col_name		=	''
is_set_tbl_type		=	''
ii_set_num_of_fields	=	0

ll_rowcount		=	idw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_desc			=	idw_criteria.object.field_description [ll_row]
	ls_field_set	=	idw_criteria.object.field_set [ll_row]
	ls_field_set	=	Left (ls_field_set, 3)	// Get left most 3 bytes
	IF	IsNull (ls_desc)				&
	OR	Trim (ls_desc)		=	''		THEN
		Continue
	END IF
	ll_valid_fields	++
	// Determine if a set exists
	IF	Lower (ls_field_set)		=	'set'		THEN
		ii_set_num_of_fields	++
		is_set_col_name			=	idw_criteria.object.field_col_name [ll_row]
		is_set_tbl_type			=	idw_criteria.object.field_tbl_type [ll_row]
		is_set_field_value		=	idw_criteria.object.field_value [ll_row]
		is_set_field_operator	=	idw_criteria.object.field_operator [ll_row]
	END IF
	// Edit and format part of the Where clause
	li_rc	=	This.uf_format_line (ll_row)
	IF	li_rc	<	0		THEN
		Return	li_rc
	END IF
NEXT

IF	ll_valid_fields	=	0		THEN
	MessageBox ('Error', 'You need to select at least one field.')
	Return	-1
END IF



// Since w_sampling_analysis_new does not store the active case, do not
//	compare the subset case against the active case.  Make the subset
//	case the active case.

IF	is_case_id	=	''						&
OR	IsNull (is_case_id)					&
OR	Upper (is_case_id)	=	'NONE'	THEN
ELSE
	gv_active_case	=	is_case_id	+	is_case_spl	+	is_case_ver
END IF


Return	1

end function

public subroutine uf_set_union_flag (boolean ab_union_flag);//*********************************************************************************
// Script Name:	uf_set_union_flag
//
//	Arguments:		ab_union_flag
//
// Returns:			None
//
//	Description:	Store the boolean stating if a union is occuring in the
//						pattern SQL.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

ib_union_flag	=	ab_union_flag

end subroutine

public function boolean uf_get_union_flag ();//*********************************************************************************
// Script Name:	uf_get_union_flag
//
//	Arguments:		None
//
// Returns:			ib_union_flag
//
//	Description:	Return ib_union_flag previously set in uf_set_union_flag.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	ib_union_flag
end function

public subroutine uf_set_not_flag (boolean ab_not_flag);//*********************************************************************************
// Script Name:	uf_set_not_flag
//
//	Arguments:		ab_union_flag
//
// Returns:			None
//
//	Description:	Store the boolean stating if the 'Not In' checkbox was
//						checked.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

ib_not_flag	=	ab_not_flag

end subroutine

public function integer uf_upperbound_from_tables ();//*********************************************************************************
// Script Name:	uf_upperbound_from_tables
//
//	Arguments:		None
//
// Returns:			Integer - The Upperbound of istr_from_tables
//
//	Description:	Get the next available entry from istr_from_tables[].
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_upper

li_upper		=	UpperBound (istr_from_tables)

IF	li_upper	>	0		THEN
	IF	istr_from_tables[li_upper].tbl_type	<>	''		THEN
		li_upper	++
	END IF
ELSE
	li_upper	=	1
END IF


Return	li_upper

end function

public subroutine uf_edit_elem_desc (ref string as_elem_desc);//*********************************************************************************
// Script Name:	uf_edit_elem_desc
//
//	Arguments:		as_elem_desc (by reference) - elem_desc as found in dictionary
//
// Returns:			None
//
//	Description:	This script will clean up elem_desc by removing the text to
//						the right of the '/' or by getting the 1st 15 bytes.  Also, 
//						convert it to upper case.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	09/12/02	GaryR	SPR 3070d	Preserve case of description
//
//*********************************************************************************

Integer		li_pos

String		ls_new_desc


li_pos	=	Pos (as_elem_desc, '/')

IF	li_pos	=	0		&
OR	li_pos	>	16		THEN
	// '/' not found, get 1st 15 bytes
	li_pos	=	16
END IF

//	09/12/02	GaryR	SPR 3070d
//as_elem_desc	=	RightTrim ( Upper ( Left(as_elem_desc, li_pos - 1) ) )
as_elem_desc	=	RightTrim ( Left(as_elem_desc, li_pos - 1) )

end subroutine

public function integer uf_multiple_likes (ref string as_where, string as_col_name, string as_prefix);//*********************************************************************************
// Script Name:	uf_multiple_likes
//
//	Arguments:		1.	as_where (by reference) - From is_where_clause[]
//						2.	as_col_name - From idw_criteria.field_col_name
//						3. as_prefix - From istr_from_tables[].prefix
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This script parses the where clause with multiple likes and
//						puts the alias on each column name.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_pos,			&
				li_start

String		ls_front,		&
				ls_back

li_start		=	1

DO
	li_pos	=	Pos (as_where, as_col_name, li_start)
	IF	li_pos	>	0		THEN
		// Found as_col_name within as_where
		ls_front		=	Left (as_where, li_pos - 1)
		ls_back		=	Mid (as_where, li_pos)
		as_where		=	ls_front	+	as_prefix	+	'.'	+	ls_back
		li_start		=	li_pos	+	Len(as_col_name)
	END IF
LOOP	UNTIL	li_pos	<=	0

IF	li_start	=	1			&
AND li_pos	=	0			THEN
	Return	-1
ELSE
	Return	1
END IF

end function

public function integer uf_filter_stars_rel (string as_tbl_type);//*********************************************************************************
// Script Name:	uf_filter_stars_rel
//
//	Arguments:		1.	as_tbl_type (by reference)
//
// Returns:			Integer
//
//	Description:	This function filters the stars rel/dictionary datawindow on
//						w_main in order to retrieve the base type corresponding to a  
//						given table type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String		ls_filter

Integer		li_rc

Long			ll_rowcount

IF IsNull (as_tbl_type)		THEN
	as_tbl_type	=	''
END IF

li_rc			=	w_main.dw_stars_rel_dict.SetFilter("")
li_rc			=	w_main.dw_stars_rel_dict.Filter()

ls_filter	=	" rel_type = 'QT' and id_2 = '"		+	as_tbl_type		+	"'"

li_rc			=	w_main.dw_stars_rel_dict.SetFilter(ls_filter)
li_rc			=	w_main.dw_stars_rel_dict.Filter()

If	li_rc		<>	1	Then
	MessageBox ("Application Error", "Unable to set the filter on stars_rel in "	+	&
					"u_nvo_pattern_sql.uf_filter_stars_rel().  Filter = "			+	&
					ls_filter	+	".")
	Return -1
End If

ll_rowcount	=	w_main.dw_stars_rel_dict.RowCount()

IF	ll_rowcount	<	1		THEN
	Return	0
ELSE
	Return	1
END IF


end function

public subroutine uf_set_pattern_id (string as_pattern_id);//*********************************************************************************
// Script Name:	uf_set_pattern_id
//
//	Arguments:		as_pattern_id - The pattern template ID
//
// Returns:			None
//
//	Description:	Store the pattern template ID (from is_pattern_id)
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_pattern_id	=	as_pattern_id

end subroutine

public function string uf_get_patt_cond ();//*********************************************************************************
// Script Name:	uf_get_patt_cond
//
//	Arguments:		None
//
// Returns:			String - patt_cntl.patt_cond
//
//	Description:	Return column patt_cond from patt_cntl.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row

String	ls_patt_cond

		
ll_row		=	idw_patt_cntl.GetRow()

IF	ll_row	<	1		THEN
	MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_get_patt_cond, '	+	&
					' could not get the current row in idw_patt_cntl.')
	Return	''
END IF

ls_patt_cond	=	idw_patt_cntl.object.patt_cond [ll_row]

Return	ls_patt_cond


end function

public function boolean uf_spec_dep_set ();//*********************************************************************************
// Script Name:	uf_spec_dep_set
//
//	Arguments:		None
//
// Returns:			Boolean - Whether or not to use diferent SQL
//
//	Description:	This function is performed when column patt_cond in patt_cntl
//						is '%DEPSET'.
//
//						This script will compare the where clauses for HCPCS and revenue
//						codes to see if HCPCS' values match and if the revenue codes'
//						values match.  If so, they will have to use different SQL
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_dep_set,					&
			lb_dep_set_diff

Integer	li_rc,						&
			li_pos_i,					&
			li_pos2_i,					&
			li_pos_j,					&
			li_pos2_j,					&
			li_end_pos_i,				&
			li_end_pos_j,				&
			li_idx,						&
			li_idx2

Long		ll_row,						&
			ll_rowcount
			
String	ls_desc,						&
			ls_value_i,					&
			ls_value_j,					&
			ls_temp_value,				&
			ls_temp_value_i,			&
			ls_temp_value_j

ll_rowcount		=	idw_criteria.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_desc			=	idw_criteria.object.field_description [ll_row]
	IF	IsNull (ls_desc)				&
	OR	Trim (ls_desc)		=	''		THEN
		Continue
	END IF
	// Edit and format part of the Where clause
	li_rc	=	This.uf_format_line (ll_row)
	IF	li_rc	<	0		THEN
		Return	FALSE
	END IF
NEXT

li_idx		=	1
li_idx2		=	1

ls_value_i	=	is_where_clause[1]
ls_value_j	=	is_where_clause[3]

IF Match (ls_value_i, ls_value_j) THEN
	IF Match (ls_value_i, ',') THEN
		DO
			li_pos_i = Pos (ls_value_i, "'")
			IF li_pos_i = 0 THEN 									
				li_pos_i = Pos (ls_value_i, '(')		
			END IF
			li_pos2_i = Pos (ls_value_i, ',')
			IF li_pos2_i = 0 THEN 									
				li_pos2_i = Pos (ls_value_i, ')')									
			END IF
			li_end_pos_i = li_pos2_i - li_pos_i
			is_value1[li_idx] = Mid (ls_value_i, li_pos_i, li_end_pos_i)
			IF is_value1[li_idx] = '' THEN Exit
			li_idx++
			ls_value_i = Mid (ls_value_i, li_pos2_i+1)
		LOOP UNTIL li_pos2_i = 0
	ELSE			
		li_pos_i = Pos (ls_value_i, ' ')
		ls_temp_value = Trim (Mid (ls_value_i, li_pos_i))
		li_pos_i = Pos (ls_temp_value, ' ')
		ls_temp_value = Trim (Mid (ls_temp_value, li_pos_i))
		is_value1[li_idx] = ls_temp_value
		li_idx++
	END IF
	lb_dep_set = TRUE							
	lb_dep_set_diff = FALSE	
ELSEIF NOT lb_dep_set THEN
	lb_dep_set_diff = TRUE
END IF
IF Match (ls_value_j, ',') THEN
	// Pull out each item in j and compare to i
	DO
		li_pos_j = Pos (ls_value_j, "'")
		IF li_pos_j = 0 THEN
			li_pos_j = Pos (ls_value_j, '(')									
		END IF
		li_pos2_j = Pos (ls_value_j, ',')
		IF li_pos2_j = 0 THEN 									
			li_pos2_j = Pos (ls_value_j, ')')									
		END IF
		li_end_pos_j = li_pos2_j - li_pos_j
		ls_temp_value_j = Mid (ls_value_j, li_pos_j, li_end_pos_j)		
		IF Match (ls_value_i, ls_temp_value_j) THEN
			lb_dep_set = TRUE
			lb_dep_set_diff = FALSE
			is_value1[li_idx] = ls_temp_value_j
			IF is_value1[li_idx] = '' THEN Exit
			li_idx++
		ELSEIF NOT lb_dep_set THEN
			lb_dep_set_diff = TRUE

		END IF
		ls_value_j = Mid (ls_value_j, li_pos2_j + 1)
	LOOP UNTIL li_pos2_j = 0
ELSEIF NOT lb_dep_set THEN
	// Compare all of j to each item in i				
	DO
		li_pos_i = Pos (ls_value_i, "'")
		IF li_pos_i = 0 THEN 									
			li_pos_i = Pos (ls_value_i,'(')		
		END IF
		li_pos2_i = Pos (ls_value_i, ',')
		IF li_pos2_i = 0 THEN 									
			li_pos2_i = Pos (ls_value_i, ')')									
		END IF
		li_end_pos_i = li_pos2_i - li_pos_i
		ls_temp_value_i = Mid (ls_value_i, li_pos_i, li_end_pos_i)	
		IF Match (ls_value_j, ls_temp_value_i) THEN
			lb_dep_set = TRUE
			lb_dep_set_diff = FALSE
			is_value1[li_idx] = ls_temp_value_i
			IF is_value1[li_idx] = '' THEN Exit
			li_idx++	
		ELSEIF NOT lb_dep_set THEN
			lb_dep_set_diff = TRUE
		END IF
		ls_value_i = Mid (ls_value_i, li_pos2_i+1)
	LOOP UNTIL li_pos2_i = 0
END IF


IF lb_dep_set THEN
	lb_dep_set = FALSE
	ls_value_i = is_where_clause[2]
	ls_value_j = is_where_clause[4]
	IF Match (ls_value_i, ls_value_j) THEN
		IF Match (ls_value_i, ',') THEN
			DO
				li_pos_i = Pos (ls_value_i, "'")
				IF li_pos_i = 0 THEN 									
					li_pos_i = Pos (ls_value_i, '(')		
				END IF
				li_pos2_i = Pos (ls_value_i, ',')
				IF li_pos2_i = 0 THEN 									
					li_pos2_i = Pos (ls_value_i, ')')									
				END IF
				li_end_pos_i = li_pos2_i - li_pos_i
				is_value2[li_idx2] = Mid (ls_value_i, li_pos_i, li_end_pos_i)
				IF is_value2[li_idx2] = '' THEN Exit
				li_idx2 ++
				ls_value_i = Mid (ls_value_i, li_pos2_i + 1)
			LOOP UNTIL li_pos2_i = 0
		ELSE			
			li_pos_i = Pos (ls_value_i,' ')
			ls_temp_value = Trim (Mid (ls_value_i, li_pos_i))
			li_pos_i = Pos (ls_temp_value,' ')
			ls_temp_value = Trim (Mid (ls_temp_value, li_pos_i))
			is_value2[li_idx2] = ls_temp_value
			li_idx2 ++
		END IF
		lb_dep_set = TRUE							
		lb_dep_set_diff = FALSE	
	ELSEIF lb_dep_set	=	FALSE		THEN
		lb_dep_set_diff = TRUE
	END IF
	IF Match (ls_value_j,',') THEN
	//pull out each item in j and compare to i
		DO
			li_pos_j = Pos (ls_value_j, "'")
			IF li_pos_j = 0 THEN
				li_pos_j = Pos (ls_value_j, '(')									
			END IF
			li_pos2_j = Pos (ls_value_j, ',')
			IF li_pos2_j = 0 THEN 									
				li_pos2_j = Pos (ls_value_j, ')')									
			END IF
			li_end_pos_j = li_pos2_j - li_pos_j
			ls_temp_value_j = Mid (ls_value_j, li_pos_j, li_end_pos_j)		
			IF Match (ls_value_i, ls_temp_value_j) THEN
				lb_dep_set = TRUE
				lb_dep_set_diff = FALSE
				is_value2[li_idx2] = ls_temp_value_j
				IF is_value2[li_idx2] = '' THEN Exit
					li_idx2 ++
				ELSEIF NOT lb_dep_set THEN
				lb_dep_set_diff = TRUE
			END IF
			ls_value_j = Mid (ls_value_j, li_pos2_j + 1)
		LOOP UNTIL li_pos2_j = 0
	ELSEIF NOT lb_dep_set THEN
		// Compare all of j to each item in i				
		DO
			li_pos_i = Pos (ls_value_i, "'")
			IF li_pos_i = 0 THEN 									
				li_pos_i = Pos (ls_value_i, '(')		
			END IF
			li_pos2_i = Pos (ls_value_i, ',')
			IF li_pos2_i = 0 THEN 									
				li_pos2_i = Pos (ls_value_i, ')')									
			END IF
			li_end_pos_i = li_pos2_i - li_pos_i
			ls_temp_value_i = Mid (ls_value_i, li_pos_i, li_end_pos_i)	
			IF Match (ls_value_j, ls_temp_value_i) THEN
				lb_dep_set = TRUE
				lb_dep_set_diff = FALSE
				is_value2[li_idx2] = ls_temp_value_i
				IF is_value2[li_idx2] = '' THEN Exit
				li_idx2 ++	
			ELSEIF NOT lb_dep_set THEN
				lb_dep_set_diff = TRUE
			END IF
			ls_value_i = Mid (ls_value_i, li_pos2_i+1)
		LOOP UNTIL li_pos2_i = 0
	END IF
END IF

IF lb_dep_set THEN 
	Return TRUE
ELSE
	Return FALSE
END IF

Return	FALSE


end function

public subroutine uf_set_last_label_row (integer al_last_label_row);//*********************************************************************************
// Script Name:	uf_set_last_label_row
//
//	Arguments:		as_pattern_id - The pattern template ID
//
// Returns:			None
//
//	Description:	Store the last criteria row updated for a non-generic pattern
//

//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

ii_last_label_row	=	al_last_label_row

end subroutine

public subroutine uf_set_dw_available (ref u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw_available
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to dw_available since dw_available is
//						passed by reference.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

idw_available	=	adw

// Copy the data from idw_available to ids_dictionary so that ids_dictionary
//	has an all inclusive list of possible columns.
ids_dictionary.Reset()
ids_dictionary.object.data		=	idw_available.object.data

end subroutine

public subroutine uf_set_dw_selected (u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw_selected
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to dw_selected since dw_selected is
//						passed by reference.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

idw_selected	=	adw

end subroutine

public subroutine uf_set_revenue_code (string as_revenue_code);//*********************************************************************************
// Script Name:	uf_set_revenue_code
//
//	Arguments:		as_revenue_code
//
// Returns:			None
//
//	Description:	Store the revenue code to determine if the revenue table
//						is being included in the selected columns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_revenue_code	=	as_revenue_code

end subroutine

public function string uf_get_main_tbl (string as_dep_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_main_tbl
//
//	Arguments:		as_dep_tbl_type - The dependent table type (Revenue table)
//
// Returns:			String
//						'error' - An error occured when determining the main table
//
//	Description:	For the revenue table type passed to this function, 
//						determine the main table type.  If there are multiple
//						tables associated with the dependent table, open window
//						w_invoice_type_selection so that the user can select the
//						main table.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Constant	String	lcs_error	=	'error'

Integer		li_idx,							&
				li_rc,							&
				li_upper

Long			ll_dep_row,						&
				ll_dep_rowcount,				&
				ll_main_tables

String		ls_filter,						&
				ls_col_desc,					&
				ls_main_tbl_type,				&
				ls_subset_filter
			
// Structure passed to w_invoice_type_selection
sx_parm		lstr_parm

ls_filter	=	"id_2 = '"	+	as_dep_tbl_type	+	"'"

// Loop thru the is_subset_tbl_type[] array, get each tbl_type,
//	and add it to the filter string.

li_upper		=	UpperBound (is_subset_tbl_type)

FOR	li_idx	=	1	TO	li_upper
	IF	is_subset_tbl_type [li_idx]	<>	'ML'	THEN
		// Rel_id is the "main" table associated with the dependent table.
		ls_subset_filter	=	ls_subset_filter	+	" or rel_id = '"	+	&
									is_subset_tbl_type [li_idx]	+	"'"
	END IF
NEXT

IF	Len (ls_subset_filter)	>	0		THEN
	ls_subset_filter	=	Mid (ls_subset_filter, 4)	// Remove the leading ' or '
	ls_subset_filter	=	" and ("	+	ls_subset_filter	+	")"
	ls_filter	=	ls_filter	+	ls_subset_filter
END IF

// Filter the total list of dependent tables
li_rc	=	ids_dependent_tables.SetFilter ('')
li_rc	=	ids_dependent_tables.Filter ()
li_rc	=	ids_dependent_tables.SetFilter (ls_filter)
li_rc	=	ids_dependent_tables.Filter ()
ll_dep_rowcount	=	ids_dependent_tables.RowCount()

FOR	ll_dep_row	=	1	TO	ll_dep_rowcount
	ls_main_tbl_type	=	ids_dependent_tables.object.rel_id [ll_dep_row]
	FOR	li_idx	=	1	TO	li_upper
		IF	ls_main_tbl_type		=	is_subset_tbl_type [li_idx]	THEN
			// This is a main table (not a dependent table).  Add it
			//	to the list of tbl_types passed to w_invoice_type_selection
			ll_main_tables	++
			lstr_parm.main_tbls [ll_main_tables]		=	ls_main_tbl_type
			Exit
		END IF
	NEXT
NEXT

IF	ll_main_tables	>	1		THEN
	// Multiple main tables exist for this dependent table.  Let the
	// user select the main table.
	ls_col_desc				=	This.uf_get_col_desc (as_dep_tbl_type, as_col_name)
	lstr_parm.dep_tbl		=	as_dep_tbl_type
	lstr_parm.label		=	ls_col_desc
	OpenWithParm (w_invoice_type_selection, lstr_parm)
	IF	Message.StringParm	=	''		THEN
		MessageBox ('Error', 'Unable to determine table_type.')
		Return	lcs_error
	END IF
	ls_main_tbl_type		=	Message.StringParm
ELSEIF ll_main_tables	=	1		THEN
	// Only one main table exist for this dependent table.  Use it.
	ls_main_tbl_type		=	lstr_parm.main_tbls [1]
ELSE
	MessageBox ('Error', 'Unable to find the main table for dependent table '	+	as_dep_tbl_type)
	Return	lcs_error
END IF

Return	ls_main_tbl_type

end function

public function string uf_get_base_type (string as_tbl_type);//*********************************************************************************
// Script Name:	uf_get_base_type
//
//	Arguments:		1.	as_tbl_type
//
// Returns:			String - The base type
//
//	Description:	This function gets the base type associated with the table type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String		ls_filter,				&
				ls_base_type

Integer		li_rc

IF IsNull (as_tbl_type)		THEN
	as_tbl_type	=	''
END IF

li_rc			=	This.uf_filter_stars_rel (as_tbl_type)

// If a dependent table (i.e. revenue code) was passed to this script,
//	then there will be no rows in w_main.dw_stars_rel_dict.

IF	li_rc		<>	1	THEN
	Return	''
END IF

ls_base_type	=	w_main.dw_stars_rel_dict.object.key6 [1]

Return	ls_base_type


end function

public function sx_main_tbl uf_get_sx_main_tbl ();//*********************************************************************************
// Script Name:	uf_get_sx_main_tbl
//
//	Arguments:		None
//
// Returns:			sx_main_tbl
//
//	Description:	Return  is_main_tbl[], ib_multiple_likes[], is_tbl_rel[], 
//						and is_where_clause[] within sx_main_tbl
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

sx_main_tbl		lstr_main_tbl

lstr_main_tbl.s_main_tbl			=	is_main_tbl
lstr_main_tbl.b_multiple_likes	=	ib_multiple_likes
lstr_main_tbl.s_tbl_rel				=	is_tbl_rel
lstr_main_tbl.s_where_clause		=	is_where_clause

Return	lstr_main_tbl

end function

public function integer uf_edit_column (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_edit_column
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//
//	Notes:			This script is called when a pattern is being imported.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/14/00	FDG	Track 2924c (4.5 SP1).  If the column doesn't exist in
//						idw_available, check idw_selected (since columns can be moved
//						from idw_available to idw_selected).
//
//*********************************************************************************

Integer		li_rc

Long			ll_row,				&
				ll_rowcount,		&
				ll_rowcount2

String		ls_find

// IF Days, Occurrences or Providers, the column is okay
IF	Upper (as_col_name)	=	'DAYS'			&
OR	Upper (as_col_name)	=	'OCCURRENCES'	&
OR	Upper (as_col_name)	=	'PROVIDERS'		THEN
	Return	1
END IF

ll_rowcount		=	idw_available.RowCount()
ll_rowcount2	=	idw_selected.RowCount()

ls_find			=	"elem_tbl_type = '"		+	as_tbl_type	+	&
						"' and elem_name = '"	+	as_col_name	+	"'"

ll_row			=	idw_available.Find (ls_find, 1, ll_rowcount)

IF	ll_row	>	0		THEN
	Return	1
ELSE
	//	FDG 06/14/00	Begin
	ll_row		=	idw_selected.Find (ls_find, 1, ll_rowcount2)
	IF	ll_row	>	0		THEN
		Return	1
	ELSE
		Return	-1
	END IF
	// FDG 06/14/00	END
END IF



end function

public function string uf_get_col_desc (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_col_desc
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			String - The column's label
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//						Once found, get and return the column description.
//
//	Notes:			This script is called when a pattern is being imported.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/20/00	FDG	Track 2930 (SP1).  If the column doesn't exist, look at 
//						idw_selected.
//
//*********************************************************************************

Integer		li_rc,				&
				li_pos

Long			ll_row,				&
				ll_rowcount,		&
				ll_rowcount2

String		ls_find,				&
				ls_desc

// Edit the input
li_pos			=	Pos (as_col_name,	"+")
IF	li_pos		>	0		THEN
	// Found a '+'.  Set the column name to what is left of the '+' and
	//	ignore what is to the right of the plus.
	as_col_name	=	Trim (Left(as_col_name, li_pos - 1))
END IF

li_pos			=	Pos (as_col_name, "'")
IF	li_pos		>	0		THEN
	// Found a quote in the column name.  Return a space
	Return ' '
END IF

ll_rowcount		=	idw_available.RowCount()
ll_rowcount2	=	idw_selected.RowCount()

ls_find			=	"elem_tbl_type = '"		+	as_tbl_type	+	&
						"' and elem_name = '"	+	as_col_name	+	"'"

ll_row			=	idw_available.Find (ls_find, 1, ll_rowcount)

IF	ll_row	<	1		THEN
	// FDG 06/20/00 - If not found, look in idw_selected
	ll_row		=	idw_selected.Find (ls_find, 1, ll_rowcount2)
	IF	ll_row	<	1		THEN
		Return	''
	ELSE
		ls_desc	=	idw_selected.object.elem_desc [ll_row]
	END IF
ELSE
	ls_desc	=	idw_available.object.elem_desc [ll_row]
	// FDG 06/20/00 end
END IF

// Truncate the description
This.uf_edit_elem_desc (ls_desc)

Return	ls_desc




end function

public subroutine uf_set_same_column (string as_same_column);//*********************************************************************************
// Script Name:	uf_set_same_column
//
//	Arguments:		as_same_column
//
// Returns:			None
//
//	Description:	Store the value to determine if a column's value is being
//						declared against itself.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_same_column	=	as_same_column


end subroutine

public subroutine uf_set_dw_report (ref u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw_report
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to dw_report since dw_report is
//						passed by reference.
//		
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

idw_report	=	adw

end subroutine

public function string uf_create_sql_prefix (string as_prefix);//*********************************************************************************
// Script Name:	uf_create_sql_prefix
//
//	Arguments:		as_prefix
//
// Returns:			String
//
//	Description:	This function takes the passed prefix and appends a '.'.  
//						This prefix can then be used in the SQL.  However, if no
//						prefix is passed, the empty string is returned.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_prefix

// Edit the prefix

IF IsNull (as_prefix)			&
OR Trim (as_prefix)	=	''		&
OR Upper (as_prefix) = 'NULL'  THEN
	// no prefix exists
	ls_prefix	=	''
ELSE
	// Prefix exists, append '.' to it.
	ls_prefix	=	as_prefix	+	'.'
END IF

Return	ls_prefix

end function

public function long uf_retrieve_tbl_type (integer ai_index);//*********************************************************************************
// Script Name:	uf_retrieve_tbl_type
//
//	Arguments:		ai_index
//
// Returns:			Long	-	Number of unique keys
//
//	Description:	This function gets the table type from istr_from_tables[]
//						and then retrieves the unique keys for this table type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//
//*********************************************************************************

Integer	li_upper

Long		ll_rowcount,			&
			ll_row

String	ls_tbl_type,			&
			ls_label

// Edit the input
IF	IsNull (ai_index)			&
OR	ai_index		=	0			THEN
	Return	0
END IF

ls_tbl_type		=	istr_from_tables[ai_index].tbl_type

IF	IsNull (ls_tbl_type)		THEN
	MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_retrieve_tbl_type, '	+	&
					'cannot determine the table type.')
	Return	-1
END IF

//	Retrieve Claim Keys
IF	NOT	IsValid (istr_from_tables[ai_index].ids_claim_keys)		THEN
	istr_from_tables[ai_index].ids_claim_keys	=	CREATE	n_ds
	istr_from_tables[ai_index].ids_claim_keys.DataObject		=	'd_claim_keys'
	istr_from_tables[ai_index].ids_claim_keys.SetTransObject (Stars2ca)
END IF

ll_rowcount = istr_from_tables[ai_index].ids_claim_keys.Retrieve (ls_tbl_type)

//	Retrieve Index Cols
IF	NOT	IsValid (istr_from_tables[ai_index].ids_index_columns)		THEN
	istr_from_tables[ai_index].ids_index_columns	=	CREATE	n_ds
	istr_from_tables[ai_index].ids_index_columns.DataObject		=	'd_index_columns'
	istr_from_tables[ai_index].ids_index_columns.SetTransObject (Stars2ca)
END IF

ll_rowcount	=	istr_from_tables[ai_index].ids_index_columns.Retrieve (ls_tbl_type)

// Get each column label and truncate to 15 bytes
FOR	ll_row	=	1	TO	ll_rowcount
	ls_label		=	istr_from_tables[ai_index].ids_index_columns.object.elem_desc [ll_row]
	This.uf_edit_elem_desc (ls_label)
	istr_from_tables[ai_index].ids_index_columns.object.elem_desc [ll_row]	=	ls_label
NEXT

Stars2ca.of_commit()
Return	ll_rowcount
end function

public function integer uf_get_index (string as_prefix);//*********************************************************************************
// Script Name:	uf_get_index
//
//	Arguments:		as_prefix
//
// Returns:			Integer
//
//	Description:	This function gets the the index (from istr_from_tables[])
//						associated with a prefix.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_idx,			&
			li_upper


li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].prefix	=	as_prefix	THEN
		Return	li_idx
	END IF
NEXT

// Prefix does not exist.  Add it

//li_idx	=	This.uf_set_prefix (as_prefix)

Return	0

end function

public function integer uf_get_tbl_type_index (string as_tbl_type);//*********************************************************************************
// Script Name:	uf_get_tbl_type_index
//
//	Arguments:		as_tbl_type
//
// Returns:			Integer
//
//	Description:	This function gets the the index (from istr_from_tables[])
//						associated with a table type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_idx,			&
			li_upper


li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].tbl_type	=	as_tbl_type	THEN
		Return	li_idx
	END IF
NEXT

Return	0

end function

public function integer uf_get_nbr_unique_keys (string as_tbl_type);//*********************************************************************************
// Script Name:	uf_get_nbr_unique_keys
//
//	Arguments:		as_tbl_type
//
// Returns:			Integer
//
//	Description:	This function will return the # of unique keys for an invoice type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_index,			&
				li_count

li_index		=	This.uf_get_tbl_type_index (as_tbl_type)

IF	li_index	>	0		THEN
	li_count	=	istr_from_tables[li_index].ids_index_columns.RowCount()
END IF

Return	li_count

end function

public function long uf_retrieve_tbl_type ();//*********************************************************************************
// Script Name:	uf_retrieve_tbl_type
//
//	Arguments:		None
//
// Returns:			Long
//
//	Description:	This is an overloaded function that gets all table types.  For
//						each table type, call the function to retrieve its unique keys.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_upper,			&
				li_idx

Long			ll_rowcount

li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	ll_rowcount	=	This.uf_retrieve_tbl_type (li_idx)
NEXT

Return	1

end function

public function integer uf_set_tbl_type (string as_tbl_type);//*********************************************************************************
// Script Name:	uf_set_tbl_type
//
//	Arguments:		as_tbl_type
//
// Returns:			Long
//
//	Description:	This function stores the table type into istr_from_tables.
//						
//	Notes:			The prefixes must be loaded into istr_from_tables before calling
//						this function.  When processing SQL from patt_template, function
//						uf_edit_sql_prefix.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_upper,			&
				li_idx

Long			ll_rowcount

String		ls_tbl_type

li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	ls_tbl_type	=	istr_from_tables[li_idx].tbl_type
	IF	as_tbl_type	=	ls_tbl_type		THEN
		// Table type already loaded.  Get out.
		Return	li_idx
	END IF
	// Fill in 1st available slot
	IF	IsNull (ls_tbl_type)				&
	OR	Trim (ls_tbl_type)	=	''		THEN
		istr_from_tables[li_idx].tbl_type	=	as_tbl_type
		// Retrieve the unique keys for this invoice type
		This.uf_retrieve_tbl_type (li_idx)
		Return	li_idx
	END IF
NEXT

// Add at the end
li_upper	++
istr_from_tables[li_upper].tbl_type	=	as_tbl_type

// Retrieve the unique keys for this invoice type
This.uf_retrieve_tbl_type (li_upper)


Return	li_upper


end function

public subroutine uf_load_tbl_type (string as_tbl_type[]);//*********************************************************************************
// Script Name:	uf_load_tbl_type
//
//	Arguments:		as_tbl_type[]
//
// Returns:			Long
//
//	Description:	This function stores the array of table types into istr_from_tables.
//						
//	Notes:			The prefixes must be loaded into istr_from_tables before calling
//						this function.  When processing SQL from patt_template, function
//						uf_edit_sql_prefix.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_upper,			&
				li_upper2,			&
				li_idx

li_upper			=	UpperBound (as_tbl_type)

FOR	li_idx	=	1	TO	li_upper
	This.uf_set_tbl_type ( as_tbl_type[li_idx] )
NEXT

// If there are more prefixes than table types, then load the remaining
// prefixes with the last table type.  This can occur when the pattern
//	is joining onto itself.

li_upper2		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper2
	IF	li_upper	<	li_upper2		THEN
		// There are prefixes without a table type assigned to them.
		// Get the last table type and assign them to the remaining
		//	prefixes.
		FOR	li_idx	=	li_upper + 1	TO	li_upper2
			This.uf_set_tbl_type ( as_tbl_type[li_upper] )
		NEXT
	END IF
NEXT


end subroutine

public subroutine uf_edit_sql_prefix ();//*********************************************************************************
// Script Name:	uf_edit_sql_prefix
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	In is_sql, find each prefix placeholder (i.e. @prefixa), 
//						and replace it with its prefix.  This function will also
//						register its prefixes.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc,			&
			li_pos,			&
			li_idx

// Convert is_sql to upper case
is_sql	=	Upper (is_sql)

// Convert @prefixa
li_pos	=	Pos (is_sql, '@PREFIXA')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('A')
END IF
This.uf_replace_sql ('@PREFIXA', 'A')

// Convert @prefixb
li_pos	=	Pos (is_sql, '@PREFIXB')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('B')
END IF
This.uf_replace_sql ('@PREFIXB', 'B')

// Convert @prefixc
li_pos	=	Pos (is_sql, '@PREFIXC')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('C')
END IF
This.uf_replace_sql ('@PREFIXC', 'C')

// Convert @prefixd
li_pos	=	Pos (is_sql, '@PREFIXD')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('D')
END IF
This.uf_replace_sql ('@PREFIXD', 'D')

// Convert @prefixe
li_pos	=	Pos (is_sql, '@PREFIXE')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('E')
END IF
This.uf_replace_sql ('@PREFIXE', 'E')

// Convert @prefixf
li_pos	=	Pos (is_sql, '@PREFIXF')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('F')
END IF
This.uf_replace_sql ('@PREFIXF', 'F')

// Convert @prefixg
li_pos	=	Pos (is_sql, '@PREFIXG')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('G')
END IF
This.uf_replace_sql ('@PREFIXG', 'G')

// Convert @prefixs
li_pos	=	Pos (is_sql, '@PREFIXS')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('S')
END IF
This.uf_replace_sql ('@PREFIXS', 'S')

// Convert @prefixt
li_pos	=	Pos (is_sql, '@PREFIXT')
IF	li_pos	>	0		THEN
	li_idx	=	This.uf_set_prefix ('T')
END IF
This.uf_replace_sql ('@PREFIXT', 'T')



end subroutine

public subroutine uf_replace_sql (string as_old, string as_new);//*********************************************************************************
// Script Name:	uf_replace_sql
//
//	Arguments:		1.	as_old - The string's original value
//						2.	as_new - The string's new value
//
// Returns:			None
//
//	Description:	In is_sql, find each occurence of as_old, and replace it
//						with as_new.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_start,			&
			ll_new_start,		&
			ll_len

String	ls_sql

ll_start	=	1
ls_sql	=	is_sql

// Find 1st occurrence of as_old
ll_start	=	Pos (ls_sql, as_old, ll_start)

// Only loop through is_sql if you find as_old

DO	WHILE	ll_start	>	0
	// Replace as_old with as_new
	ll_len			=	Len(as_old)
	ls_sql			=	Replace (ls_sql, ll_start, ll_len, as_new)
	// Find the next occurrence of as_old 
	ll_new_start	=	ll_start + Len(as_new)
	ll_start			=	Pos (ls_sql, as_old, ll_new_start )
LOOP

is_sql		=	ls_sql

end subroutine

public function string uf_string_keys (string as_prefix);//*********************************************************************************
// Script Name:	uf_string_keys
//
//	Arguments:		as_prefix
//
// Returns:			String
//
//	Description:	This function gets all columns that comprise of the unique key
//						and converts them to a string.  This string can be used as part
//						of a SELECT, ORDER BY, or GROUP BY.  For example, if table type
//						C1 has a unique key of ICN and ICN_LINE_NO, the resulting
//						string would be "a.ICN, a.ICN_LINE_NO" or "ICN, ICN_LINE_NO".
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_index,			&
			li_upper

String	ls_prefix,			&
			ls_sql

li_index		=	This.uf_get_index (as_prefix)

IF	li_index	=	0			THEN
	// No prefix found
	li_index		=	1
	ls_prefix	=	''
ELSE
	// Prefix found.  Append a '.'
	ls_prefix	=	This.uf_create_sql_prefix (as_prefix)
END IF

ls_sql	=	This.uf_select2_keys (li_index)
ls_sql	=	Left (ls_sql, Len(ls_sql) - 1)	// Remove trailing ','

Return	ls_sql


end function

public subroutine uf_init_multiple_likes ();//*********************************************************************************
// Script Name:	uf_init_multiple_likes
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This function will initialize ib_multiple_likes[] to 
//						correspond to the # of occurrences in is_where_clause[].
//
//	Note:				is_where_clause[] must be loaded before calling this function
//						(from uf_format_line()).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean		lb_empty[]

Integer		li_idx,				&
				li_upper
				
ib_multiple_likes		=	lb_empty

li_upper		=	UpperBound (is_where_clause)

FOR	li_idx	=	1	TO	li_upper
	ib_multiple_likes [li_idx]		=	FALSE
NEXT


end subroutine

public function sx_pattern_tbl_types uf_get_sql_tbl_types ();//*********************************************************************************
// Script Name:	uf_get_sql_tbl_types
//
//	Arguments:		None
//
// Returns:			sx_pattern_tbl_types - Contains only an array of table types
//
//	Description:	Return the table types used to generate the sql.  For
//						generic patterns, get these table types from istr_from_tables[].
//						For numbered patterns, use is_subset_tbl_type.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_upper,			&
				li_idx,				&
				li_idx2

String		ls_tbl_type[]

sx_pattern_tbl_types		lstr_tbl_types

IF	is_pattern_id	=	ics_generic		THEN
	li_upper			=	UpperBound (istr_from_tables)
	FOR	li_idx	=	1	TO	li_upper
		IF	istr_from_tables[li_idx].tbl_type	>	' '		THEN
			li_idx2	++
			ls_tbl_type [li_idx2]	=	istr_from_tables[li_idx].tbl_type
		END IF
	NEXT
ELSE
	li_upper			=	UpperBound (is_subset_tbl_type)
	FOR	li_idx	=	1	TO	li_upper
		IF	is_subset_tbl_type [li_idx]	>	' '		THEN
			li_idx2	++
			ls_tbl_type [li_idx2]	=	is_subset_tbl_type [li_idx]
		END IF
	NEXT
END IF

lstr_tbl_types.tbl_type		=	ls_tbl_type

Return	lstr_tbl_types


end function

public function string uf_compare_keys (integer ai_index1, integer ai_index2);//*********************************************************************************
// Script Name:	uf_compare_keys
//
//	Arguments:		1.	ai_index1 - 1st index from istr_from_tables
//						2.	ai_index2 - 2nd index from istr_from_tables
//
// Returns:			String - SQL string
//
//	Description:	This script gets all columns that comprise of the unique key
//						and creates a string that compares each unique key.
//						For example, if table type C1 (or C1 and C3) has a unique
//						key of ICN and ICN_LINE_NO, the resulting comparison string
//						would be: 
//							a.ICN = b.ICN AND a.ICN_LINE_NO = b.ICN_LINE_NO
//						Prefixes are required to make this work.  If ai_index1
//						and ai_index2 match, then the table is being compared
//						against itself.  If so, the 2nd prefix will be automatically
//						set to the next possible letter.
//
//	Notes:			The only time the prefix can = 'I', we are dealing with a temp
//						table when creating a subset.  When this occurs, these columns
//						will have the table type as its prefix (i.e. C1_ICN).
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount,			&
			ll_ids_rowcount

String	ls_i_prefix,			&
			ls_j_prefix,			&
			ls_inv_type,			&
			ls_compare,				&
			ls_i_col_name,			&
			ls_j_col_name
			
// Edit the input
IF	IsNull (ai_index1)				&
OR	ai_index1	=	0					THEN
	Return	''
END IF

IF	IsNull (ai_index2)				&
OR	ai_index2	=	0					THEN
	Return	''
END IF

// Get the table prefixes from istr_from_tables[]
ls_i_prefix	=	istr_from_tables[ai_index1].prefix
ls_j_prefix	=	istr_from_tables[ai_index2].prefix

IF	ls_i_prefix	=	ls_j_prefix		THEN
	//	Get the next letter and set it to ls_j_prefix
	ls_j_prefix	=	Char (Asc(ls_i_prefix) + 1)	
END IF

// Get the column names from ids_index_columns

ll_rowcount	=	istr_from_tables[ai_index1].ids_index_columns.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_i_col_name	=	istr_from_tables[ai_index1].ids_index_columns.object.elem_name [ll_row]
	ls_j_col_name	=	ls_i_col_name
	IF	ls_i_prefix	=	'I'	THEN
		// This is a temp table.  Place the table type as its prefix (i.e. C1_ICN_LINE_NO)
		ls_i_col_name	=	istr_from_tables[ai_index1].tbl_type	+	'_'	+	ls_i_col_name
	END IF
	ls_compare		=	ls_compare	+	" AND "	+	ls_i_prefix	+	"."	+	&
							ls_i_col_name	+	" = "	+	ls_j_prefix	+	"."	+	&
							ls_j_col_name
NEXT

IF	Len (ls_compare)	>	1		THEN
	// Remove the leading " AND "
	ls_compare	=	Mid (ls_compare, 6)	
END IF

Return	ls_compare
end function

public function integer uf_set_prefix (string as_prefix);//*********************************************************************************
// Script Name:	uf_set_prefix
//
//	Arguments:		as_prefix
//
// Returns:			None
//
//	Description:	This function stores the prefix into istr_from_tables[].
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_idx,				&
			li_upper
			
String	ls_prefix

// Look for an existing prefix in istr_from_tables[].  If not found, append
//	the prefix to the end of the array.

li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].prefix	=	as_prefix		THEN
		// Prefix already added.  Get out.
		Return	li_idx
	END IF
NEXT

li_upper	++

istr_from_tables[li_upper].prefix	=	as_prefix

Return	li_upper

end function

public function integer uf_load_criteria_tables ();//*********************************************************************************
// Script Name:	uf_load_criteria_tables
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	Get the list of unique invoice types from dw_criteria and load 
//						it into istr_from_tables.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_found,						&
			lb_dep_filter

Constant Integer	lci_max_tables 		= 	14
Constant Integer	lci_too_many_tables	=	4

Integer	li_upper,						&
			li_idx

Long		ll_row,							&
			ll_rowcount

String	ls_col_name,					&
			ls_tbl_type
			
ll_rowcount		=	idw_criteria.RowCount()

// Get the list of unique invoice types from dw_criteria

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	idw_criteria.object.field_col_name [ll_row]
	ls_tbl_type		=	idw_criteria.object.field_tbl_type [ll_row]
	IF	IsNull (ls_col_name)		&
	OR	Trim (ls_col_name)	=	''		THEN
		// This line has no selected column (This could be the last line).
		Continue
	END IF
	lb_found		=	FALSE
	li_upper		=	UpperBound (istr_from_tables)
	// Determine if this tbl type has already been added to istr_from_tables
	FOR	li_idx	=	1	TO	li_upper
		IF	ls_tbl_type		=	istr_from_tables[li_idx].tbl_type	THEN
			// Found in istr_from_tables
			lb_found		=	TRUE
			Exit
		END IF
	NEXT
	IF	lb_found		=	FALSE		THEN
		// tbl_type not found.  Add it to the list of unique table types.
		istr_from_tables[li_upper + 1].tbl_type	=	ls_tbl_type
		istr_from_tables[li_upper + 1].tbl_rel		=	is_tbl_rel [ll_row]
		istr_from_tables[li_upper + 1].main_tbl	=	is_main_tbl [ll_row]
	END IF
NEXT


Return	1

end function

public subroutine uf_clear_from_tables ();//*********************************************************************************
// Script Name:	uf_clear_from_tables
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Clear out istr_from_tables[]
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

sx_from_tables			lstr_from_tables[]

// Initialize the structures
istr_from_tables			=	lstr_from_tables


end subroutine

public function integer uf_set_tbl_type (string as_prefix, string as_tbl_type);//*********************************************************************************
// Script Name:	uf_set_tbl_type
//
//	Arguments:		1.	as_prefix
//						2.	as_tbl_type
//
// Returns:			Long
//
//	Description:	This function stores the table type and prefix into istr_from_tables.
//						This function differs from uf_set_tbl_type(as_tbl_type) in that
//						the prefix and tbl type is loaded concurrently.  This will
//						ensure that if a table is joining onto itself, then the unique
//						keys are retrieved for both prefixes.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer		li_upper,			&
				li_idx

Long			ll_rowcount

String		ls_tbl_type,		&
				ls_prefix

li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	ls_tbl_type	=	istr_from_tables[li_idx].tbl_type
	ls_prefix	=	istr_from_tables[li_idx].prefix
	IF	 as_tbl_type	=	ls_tbl_type		&
	AND as_prefix		=	ls_prefix		THEN
		// Table type already loaded.  Get out.
		Return	li_idx
	END IF
	// Fill in 1st available slot
	IF	IsNull (ls_prefix)					&
	OR	Trim (ls_prefix)	=	''				&
	OR	as_prefix			=	ls_prefix	THEN
		istr_from_tables[li_idx].prefix		=	as_prefix
		istr_from_tables[li_idx].tbl_type	=	as_tbl_type
		// Retrieve the unique keys for this invoice type
		This.uf_retrieve_tbl_type (li_idx)
		Return	li_idx
	END IF
NEXT

// Add at the end
li_upper	++
istr_from_tables[li_upper].prefix		=	as_prefix
istr_from_tables[li_upper].tbl_type		=	as_tbl_type

// Retrieve the unique keys for this invoice type
This.uf_retrieve_tbl_type (li_upper)


Return	li_upper


end function

public function integer uf_get_tbl_type_index (string as_prefix, string as_tbl_type);//*********************************************************************************
// Script Name:	uf_get_tbl_type_index
//
//	Arguments:		1.	as_prefix
//						2.	as_tbl_type
//
// Returns:			Integer
//
//	Description:	This function gets the the index (from istr_from_tables[])
//						associated with a table type and prefix.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_idx,			&
			li_upper


li_upper		=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	IF	 istr_from_tables[li_idx].tbl_type	=	as_tbl_type	&
	AND istr_from_tables[li_idx].prefix		=	as_prefix	THEN
		Return	li_idx
	END IF
NEXT

Return	0

end function

public subroutine uf_set_sql (string as_sql);//*********************************************************************************
// Script Name:	uf_set_sql
//
//	Arguments:		as_sql
//
// Returns:			None
//
//	Description:	This function is called from w_subset_summary_analysis and
//						will set is_sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

is_sql	=	Upper (as_sql)

end subroutine

public function string uf_get_sql ();//*********************************************************************************
// Script Name:	uf_get_sql
//
//	Arguments:		None
//
// Returns:			String - is_sql
//
//	Description:	Return the sql.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	Upper (is_sql)

end function

public function string uf_get_data_type (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_data_type
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			String - The data type
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//						Once found, get and return the column's data type (i.e. MONEY,
//						CHAR, VARCHAR, etc)
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/20/00	FDG	Track 2930 (SP1).  If the column doesn't exist, look at 
//						idw_selected.
//  07/13/2005 Katie Track 4888d  Set value of ll_rowcount2 before calling FIND on dw_selected.
//
//*********************************************************************************

Integer		li_rc

Long			ll_row,				&
				ll_rowcount,		&
				ll_rowcount2

String		ls_find,				&
				ls_data_type

ii_data_len		=	0		// Re-initialize the column's length
ii_min_len		=	0		// Re-initialize the column's minimum length
ii_lead_alpha	=	0		// Re-initialize the column's # of leading characters

// If days or occurrences or providers, the column doesn't actually exist
//	in dictionary.  When this occurs, return SMALLINT.
IF	Upper (as_col_name)	=	'DAYS'			&
OR	Upper (as_col_name)	=	'OCCURRENCES'	&
OR	Upper (as_col_name)	=	'PROVIDERS'		THEN
	ii_data_len				=	9
	ii_min_len				=	1
	ii_lead_alpha			=	0
	Return	'SMALLINT'
END IF

ll_rowcount		=	idw_available.RowCount()

ls_find			=	"elem_tbl_type = '"		+	as_tbl_type	+	&
						"' and elem_name = '"	+	as_col_name	+	"'"

ll_row			=	idw_available.Find (ls_find, 1, ll_rowcount)

IF	ll_row	<	1		THEN
	// FDG 06/20/00 - If it doesn't exist, look at idw_selected
	ll_rowcount2		=	idw_selected.RowCount()
	ll_row		=	idw_selected.Find (ls_find, 1, ll_rowcount2)
	IF	ll_row	<	1		THEN
		Return	''
	ELSE
		ls_data_type	=	Upper (idw_selected.object.elem_data_type [ll_row])
		ii_data_len		=	idw_selected.object.elem_data_len [ll_row]		// Store the data length
		ii_min_len		=	idw_selected.object.min_len [ll_row]				// Store the minimum length
		ii_lead_alpha	=	idw_selected.object.lead_alpha [ll_row]			// Store the # of leading characters
	END IF
ELSE
	ls_data_type	=	Upper (idw_available.object.elem_data_type [ll_row])
	ii_data_len		=	idw_available.object.elem_data_len [ll_row]		// Store the data length
	ii_min_len		=	idw_available.object.min_len [ll_row]				// Store the minimum length
	ii_lead_alpha	=	idw_available.object.lead_alpha [ll_row]			// Store the # of leading characters
	// FDG 06/20/00 end
END IF


Return	ls_data_type




end function

public function integer uf_get_data_len (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_data_len
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			Integer	-	 Column's length
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//						Once found, get and return the column's length.
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria.
//						Also, uf_get_data_type computes ii_data_len.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_data_type

ls_data_type	=	This.uf_get_data_type (as_tbl_type, as_col_name)

Return	ii_data_len

end function

public function integer uf_get_data_len ();//*********************************************************************************
// Script Name:	uf_get_data_len
//
//	Arguments:		None
//
// Returns:			Integer	-	 Column's length
//
//	Description:	Return the length of the column as stored in dictionary.  This
//						length was already computed in uf_get_data_type.
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria.
//						Also, uf_get_data_type computes ii_data_len.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	ii_data_len

end function

public function integer uf_get_min_len (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_min_len
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			Integer	-	 Column's length
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//						Once found, get and return the column's minimum length.
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria.
//						Also, uf_get_data_type computes ii_min_len.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_data_type

ls_data_type	=	This.uf_get_data_type (as_tbl_type, as_col_name)

Return	ii_min_len

end function

public function integer uf_get_min_len ();//*********************************************************************************
// Script Name:	uf_get_min_len
//
//	Arguments:		None
//
// Returns:			Integer	-	 Column's length
//
//	Description:	Return the minimum length of the column as stored in dictionary.  
//						This length was already computed in uf_get_data_type.
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria.
//						Also, uf_get_data_type computes ii_min_len.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	ii_min_len

end function

public function integer uf_get_lead_alpha (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_lead_alpha
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			Integer	-	 # of leading characters
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//						Once found, get and return the column's # of leading characters.
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria.
//						Also, uf_get_data_type computes ii_lead_alpha.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String	ls_data_type

ls_data_type	=	This.uf_get_data_type (as_tbl_type, as_col_name)

Return	ii_lead_alpha

end function

public function integer uf_get_lead_alpha ();//*********************************************************************************
// Script Name:	uf_get_lead_alpha
//
//	Arguments:		None
//
// Returns:			Integer	-	 # of leading characters
//
//	Description:	Return the # of leading characters as stored in dictionary.  This
//						length was already computed in uf_get_data_type.
//
//	Notes:			This script is called from w_sampling_analysis_new.ue_edit_criteria.
//						Also, uf_get_data_type computes ii_lead_alpha.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	ii_lead_alpha

end function

public function string uf_get_col_hdr (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_get_col_hdr
//
//	Arguments:		1.	as_tbl_type - Invoice type
//						2.	as_col_name - Column name
//
// Returns:			String - The column's label
//
//	Description:	Take the input and determine if the column exists in dictionary.
//						dw_available has the list of valid columns from dictionary.
//						Once found, get and return the column header from elem_elem_label.
//
//	Notes:			This script is called when a pattern is being imported.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/20/00	FDG	Track 2930 (SP1).  If the column doesn't exist, look at 
//						idw_selected.
//
//*********************************************************************************

Integer		li_rc,				&
				li_pos

Long			ll_row,				&
				ll_rowcount,		&
				ll_rowcount2

String		ls_find,				&
				ls_desc

// Edit the input
li_pos			=	Pos (as_col_name,	"+")
IF	li_pos		>	0		THEN
	// Found a '+'.  Set the column name to what is left of the '+' and
	//	ignore what is to the right of the plus.
	as_col_name	=	Trim (Left(as_col_name, li_pos - 1))
END IF

li_pos			=	Pos (as_col_name, "'")
IF	li_pos		>	0		THEN
	// Found a quote in the column name.  Return a space
	Return ' '
END IF

ll_rowcount		=	idw_available.RowCount()
ll_rowcount2	=	idw_selected.RowCount()

ls_find			=	"elem_tbl_type = '"		+	as_tbl_type	+	&
						"' and elem_name = '"	+	as_col_name	+	"'"

ll_row			=	idw_available.Find (ls_find, 1, ll_rowcount)

IF	ll_row	<	1		THEN
	// FDG 06/20/00 - If not found, look in idw_selected
	ll_row		=	idw_selected.Find (ls_find, 1, ll_rowcount2)
	IF	ll_row	<	1		THEN
		Return	''
	ELSE
		ls_desc	=	idw_selected.object.elem_elem_label [ll_row]
	END IF
ELSE
	ls_desc	=	idw_available.object.elem_elem_label [ll_row]
	// FDG 06/20/00 end
END IF


Return	ls_desc




end function

public function boolean uf_is_ml ();//*********************************************************************************
// Script Name:	uf_is_ml
//
//	Arguments:		None
//
// Returns:			Boolean
//						TRUE	-	The subset is a ML subset
//						FALSE	-	The subset is not a ML subset
//
//	Description:	Determine if the subset is a ML subset. 
//
//*********************************************************************************
//
//	06/14/00	FDG	Track 2924c (4.5 SP1).  Created.
//
//*********************************************************************************

Boolean	lb_ml_subset

Integer	li_upper

li_upper			=	UpperBound (is_subset_tbl_type)

IF	li_upper	>	1		THEN
	lb_ml_subset	=	TRUE
ELSE
	lb_ml_subset	=	FALSE
END IF

Return	lb_ml_subset

end function

public function string uf_pattern_timeframe (sx_field_array astr_timeframe[]);//*********************************************************************************
// Script Name:	uf_pattern_timeframe
//
//	Arguments:		astr_timeframe[] - Type sx_field_array
//
// Returns:			String
//
//	Description:	Place the where clause into is_where[] for the timeframe data
//						in a generic pattern.
//
//	Note:				This function is called from ue_pattern_where when the
//						timeframe button <> 0.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	03/22/00	FDG	Track 2783c.  When the from date buttom (not from and thru date) 
//						is clicked, do not include thru_date in the SQL.
//
// 11/20/00 GaryR	Stars 4.7 DataBase Port - Conversion of data types
//
//*********************************************************************************

Constant	String	lcs_error			=	'Error'
Constant	String	lcs_from_more		=	'.from_date >= '
Constant	String	lcs_from_equal		=	'.from_date = '
Constant	String	lcs_from_less		=	'.from_date <= '
Constant	String	lcs_thru_more		=	'.thru_date >= '
Constant	String	lcs_thru_less		=	'.thru_date <= '
Constant	String	lcs_object_from	=	'.from_date'
Constant	String	lcs_object_thru	=	'.thru_date'

Boolean	lb_match

Integer	li_rc,							&
			li_timeframe_button,			&
			li_timeframe_num_of_days,	&
			li_upper,						&
			li_upper2,						&
			li_upper3,						&
			li_upper4,						&
			li_idx,							&
			li_idx2,							&
			li_idx3,							&
			li_type_idx_1,					&
			li_type_idx_2

Long		ll_opt_row,						&
			ll_rowcount,					&
			ll_row,							&
			ll_row2

String	ls_timeframe_from_thru,		&
			ls_timeframe_field_1,		&
			ls_timeframe_field_2,		&
			ls_filter,						&
			ls_tbl_types[],				&
			ls_from_thru[],				&
			ls_key6[],						&
			ls_value_a
			
SetPointer (HourGlass!)
w_main.SetMicroHelp ('Creating Pattern SQL... (timeframe)')

ll_opt_row	=	idw_patt_options.GetRow()

IF	ll_opt_row	<	1		THEN
	MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_pattern_timeframe, '	+	&
					'cannot get the current row in idw_patt_options.')
	Return	lcs_error
END IF

li_timeframe_button			=	idw_patt_options.object.timeframe_button [ll_opt_row]
li_timeframe_num_of_days	=	idw_patt_options.object.timeframe_num_of_days [ll_opt_row]
ls_timeframe_from_thru		=	idw_patt_options.object.timeframe_from_thru [ll_opt_row]
ls_timeframe_field_1			=	idw_patt_options.object.timeframe_field_1 [ll_opt_row]
ls_timeframe_field_2			=	idw_patt_options.object.timeframe_field_2 [ll_opt_row]

IF	li_timeframe_button				=	0		THEN
	// No time frame data was entered, get out.
	Return	''
END IF

IF	li_timeframe_button				<>	4		THEN
	// When the 4th radiobutton is clicked on the timeframe tab, there is no other
	//	data to edit (since nothing is entered).
	IF	 Trim (ls_timeframe_field_1)	=	''		&
	AND Trim (ls_timeframe_field_2)	=	''		&
	AND (li_timeframe_num_of_days		=	0	OR IsNull (li_timeframe_num_of_days) )		THEN
		// No time frame data was entered, get out.
		Return	''
	END IF
	IF	 Trim (ls_timeframe_field_1)	=	''		&
	OR Trim (ls_timeframe_field_2)	=	''		&
	OR (li_timeframe_num_of_days		=	0	OR IsNull (li_timeframe_num_of_days) )		THEN
		// One or more timeframe columns were not entered.  Either enter everything or nothing.
		MessageBox ('TimeFrame Error', 'This report cannot be generated because incomplete '	+	&
						'timeframe information was entered.  Go to the Time Frame tab and '			+	&
						'either complete all of the data or clear out its contents.')
		Return	'ERROR'
	END IF
END IF

ls_filter	=	"rel_id = '"	+	gv_sys_dflt	+	"' and rel_type = 'QT'"

li_rc	=	w_main.dw_stars_rel_dict.SetFilter ('')
li_rc	=	w_main.dw_stars_rel_dict.Filter ()
li_rc	=	w_main.dw_stars_rel_dict.SetFilter (ls_filter)
li_rc	=	w_main.dw_stars_rel_dict.Filter ()

ll_rowcount	=	w_main.dw_stars_rel_dict.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_tbl_types[ll_row]	=	w_main.dw_stars_rel_dict.object.id_2 [ll_row]
	ls_key6[ll_row]		=	w_main.dw_stars_rel_dict.object.key6 [ll_row]
	CHOOSE CASE	ls_key6[ll_row]
		CASE	'PHAR'
			ls_from_thru[ll_row]		=	'N'
		CASE	'UB92'
			ls_from_thru[ll_row]		=	'Y'
		CASE	'1500'
			ls_value_a	=	w_main.dw_stars_rel_dict.object.value_a [ll_row]
			IF	Right (ls_value_a, 4)	=	"DENT"	THEN
				ls_from_thru[ll_row]		=	'N'
			ELSE
				ls_from_thru[ll_row]		=	'Y'
			END IF
	END CHOOSE
NEXT

li_upper4		=	UpperBound (is_where)

IF	li_upper4	>	0		THEN
	IF	is_where [li_upper4]	<>	''		THEN
		li_upper4	++
	END IF
ELSE
	li_upper4	=	1
END IF

li_upper2	=	UpperBound (astr_timeframe)
li_upper3	=	UpperBound (ls_tbl_types)

FOR	li_idx	=	1	TO	li_upper2		// astr_timeframe[]
	FOR li_idx2	=	1	TO	li_upper3		//	ls_tbl_types
		IF	astr_timeframe[li_idx].tbl_type	=	ls_tbl_types[li_idx2]		THEN
			IF	li_idx	=	1	THEN
				li_type_idx_1	=	li_idx
			ELSE
				li_type_idx_2	=	li_idx2
			END IF
			IF	ls_timeframe_from_thru	=	'Y'		&
			AND ls_from_thru [li_idx2]	=	'N'		THEN
				MessageBox ('Timeframe Warning', 'You have selected From/Thru dates, but at least '	+	&
								'one of the subset tables does not contain a Thru date. Only From date '	+	&
								'checking will be performed on tables that do not have a Thru date.')
				Exit
			END IF
		END IF
	NEXT
NEXT

CHOOSE CASE li_timeframe_button
	CASE 1
		//	a.field WITHIN X days of b.field
		IF	ls_timeframe_from_thru	=	'Y'		THEN
			// 11/20/00 GaryR	Stars 4.7 DataBase Port
//			is_where [li_upper4]	=	'(abs(datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) <= '	+	String(li_timeframe_num_of_days)	+	' or '	+	&
//											'abs(datediff(day,'	+	astr_timeframe[2].tbl_alias +	&
//											'.thru_date,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date)) <= '	+	String(li_timeframe_num_of_days)	+	' or '	+	&
//											'abs(datediff(day,'	+	astr_timeframe[1].tbl_alias +	&
//											'.thru_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) <= '	+	String(li_timeframe_num_of_days)	+	')'
			is_where [li_upper4]	=	"(abs(" + gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".from_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + ") <= "	+	String(li_timeframe_num_of_days)	+	' or '	+	&
											"abs(" + gnv_sql.of_get_days_diff( astr_timeframe[2].tbl_alias +	&
											".thru_date", astr_timeframe[1].tbl_alias	+	&
											".from_date" ) + ") <= "	+	String(li_timeframe_num_of_days)	+	' or '	+	&
											"abs(" + gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias +	&
											".thru_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + ") <= "	+	String(li_timeframe_num_of_days)	+	')'								
// FDG 03/22/00 begin
//		ELSEIF (li_type_idx_1	>	0	AND ls_from_thru[li_type_idx_1]	=	'Y')	THEN
//			// Only 1st table has thru date
//			is_where [li_upper4]	=	'abs(datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.thru_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) <= '	+	String(li_timeframe_num_of_days)
//		ELSEIF (li_type_idx_2	>	0	AND ls_from_thru[li_type_idx_2]	=	'Y')	THEN
//			// Only 2nd table has thru date
//			is_where [li_upper4]	=	'abs(datediff(day,'	+	astr_timeframe[2].tbl_alias +	&
//											'.thru_date,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date)) <= '	+	String(li_timeframe_num_of_days)
// FDG 03/22/00 begin
		ELSE
			// 11/20/00 GaryR	Stars 4.7 DataBase Port
//			is_where [li_upper4]	=	'abs(datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) <= '	+	String(li_timeframe_num_of_days)
			is_where [li_upper4]	=	"abs(" + gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".from_date",	astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + ") <= "	+	String(li_timeframe_num_of_days)								
		END IF
	CASE 2
		//	a.field >= X days PRIOR to b.field
		IF	ls_timeframe_from_thru	=	'Y'		THEN
			// Only 1st table has thru date
			// 11/20/00 GaryR	Stars 4.7 DataBase Port
//			is_where [li_upper4]	=	'datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.thru_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date) >= '	+	String(li_timeframe_num_of_days)
			is_where [li_upper4]	=	gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".thru_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + " >= "	+	String(li_timeframe_num_of_days)								
		ELSE
			// Ist table has no thru date (compare from dates)
			// 11/20/00 GaryR	Stars 4.7 DataBase Port
//			is_where [li_upper4]	=	'datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date) >= '	+	String(li_timeframe_num_of_days)
			is_where [li_upper4]	=	gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".from_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + " >= "	+	String(li_timeframe_num_of_days)
		END IF
	CASE 3
		//	a.field and b.field >= X days apart 
		IF	ls_timeframe_from_thru	=	'Y'		THEN
			// 11/20/00 GaryR	Stars 4.7 DataBase Port
//			is_where [li_upper4]	=	'(abs(datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) >= '	+	String(li_timeframe_num_of_days)	+	' or '	+	&
//											'abs(datediff(day,'	+	&
//											astr_timeframe[1].tbl_alias	+	'.thru_date,'	+	&
//											astr_timeframe[2].tbl_alias	+	'.from_date)) >= '	+	&
//											String(li_timeframe_num_of_days)	+	' or '	+	&
//											'abs(datediff(day,'	+	&
//											astr_timeframe[2].tbl_alias	+	'.thru_date,'	+	&
//											astr_timeframe[1].tbl_alias	+	'.from_date)) >= '	+	&
//											String(li_timeframe_num_of_days)	+	')'
			is_where [li_upper4]	=	"(abs(" + gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".from_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + ") >= "	+	String(li_timeframe_num_of_days)	+	' or '	+	&
											"abs(" + gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".thru_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + ") >= "	+	String(li_timeframe_num_of_days)	+	' or '	+	&
											"abs(" + gnv_sql.of_get_days_diff( astr_timeframe[2].tbl_alias	+	&
											".thru_date", astr_timeframe[1].tbl_alias	+	&
											".from_date" ) + ") >= "	+	String(li_timeframe_num_of_days)	+	')'
// FDG 03/22/00 begin
//		ELSEIF (li_type_idx_1	>	0	AND ls_from_thru[li_type_idx_1]	=	'Y')	THEN
//			// Only 1st table has thru date
//			is_where [li_upper4]	=	'abs(datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.thru_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) >= '	+	String(li_timeframe_num_of_days)
//		ELSEIF (li_type_idx_2	>	0	AND ls_from_thru[li_type_idx_2]	=	'Y')	THEN
//			// Only 2nd table has thru date
//			is_where [li_upper4]	=	'abs(datediff(day,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.thru_date,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date)) >= '	+	String(li_timeframe_num_of_days)
// FDG 03/22/00 end
		ELSE
			// Neither table has thru date
			// 11/20/00 GaryR	Stars 4.7 DataBase Port
//			is_where [li_upper4]	=	'abs(datediff(day,'	+	astr_timeframe[1].tbl_alias	+	&
//											'.from_date,'	+	astr_timeframe[2].tbl_alias	+	&
//											'.from_date)) >= '	+	String(li_timeframe_num_of_days)
			is_where [li_upper4]	=	"abs(" + gnv_sql.of_get_days_diff( astr_timeframe[1].tbl_alias	+	&
											".from_date", astr_timeframe[2].tbl_alias	+	&
											".from_date" ) + ") >= "	+	String(li_timeframe_num_of_days)
		END IF
	CASE 4
		// Part B within Part A Stay - Compare all professional tables to all hospital tables.
		li_upper	=	UpperBound (astr_timeframe)
		FOR	li_idx	=	1	TO	li_upper
			FOR	li_idx2	=	li_idx + 1	TO	li_upper
				lb_match		=	FALSE
				FOR	ll_row	=	1	TO	ll_rowcount		// Rows in w_main.dw_stars_rel_dict
					IF	astr_timeframe[li_idx].tbl_type	=	ls_tbl_types[ll_row]		&
					AND ls_key6[ll_row]						=	'1500'						THEN
						FOR	ll_row2	=	1	TO	ll_rowcount
							IF	astr_timeframe[li_idx2].tbl_type	=	ls_tbl_types[ll_row2]	&
							AND ls_key6[ll_row2]						=	'UB92'						THEN
								lb_match	=	TRUE
								Exit
							END IF			//	astr_timeframe[li_idx2].tbl_type = ls_tbl_types[ll_row] & ls_key6[ll_row] = UB92
						NEXT					//	ll_row2 = 1	TO	ll_rowcount
					ELSEIF (astr_timeframe[li_idx].tbl_type	=	ls_tbl_types[ll_row]		&
					AND	ls_key6[ll_row]							=	'UB92')						THEN
						FOR	ll_row2	=	1	TO	ll_rowcount
							IF	astr_timeframe[li_idx2].tbl_type	=	ls_tbl_types[ll_row2]	&
							AND ls_key6[ll_row2]						=	'1500'						THEN
								lb_match	=	TRUE
								Exit
							END IF			//	astr_timeframe[li_idx2].tbl_type = ls_tbl_types[ll_row] & ls_key6[ll_row] = 1500
						NEXT					//	ll_row2 = 1	TO	ll_rowcount
					END IF					//	astr_timeframe[li_idx].tbl_type = ls_tbl_types[ll_row] & ls_key6[ll_row] = 1500
					IF	lb_match			THEN
						Exit
					END IF
				NEXT							// ll_row =	1	TO	ll_rowcount
				IF	lb_match				THEN
					IF	ls_timeframe_from_thru	<>	'Y'		THEN
						IF	ls_from_thru[ll_row2]	=	'Y'	THEN
							is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_more	+	&
															astr_timeframe[li_idx2].tbl_alias	+	lcs_object_from
							li_upper4	++
							is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_less	+	&
															astr_timeframe[li_idx2].tbl_alias	+	lcs_object_thru
							li_upper4	++
						ELSE
							is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_equal	+	&
															astr_timeframe[li_idx2].tbl_alias	+	lcs_object_from
							li_upper4	++
						END IF				//	ls_from_thru[ll_row2] =	'Y'
					ELSEIF (ls_from_thru[ll_row]	=	'Y'	AND	ls_from_thru[ll_row2]	=	'Y')	THEN
						is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_less	+	&
														astr_timeframe[li_idx2].tbl_alias	+	lcs_object_thru
						li_upper4	++
						is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_thru_more	+	&
														astr_timeframe[li_idx2].tbl_alias	+	lcs_object_from
						li_upper4	++
					ELSEIF ls_from_thru[ll_row]	=	'Y'		THEN
						is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_less	+	&
														astr_timeframe[li_idx2].tbl_alias	+	lcs_object_from
						li_upper4	++
						is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_thru_more	+	&
														astr_timeframe[li_idx2].tbl_alias	+	lcs_object_from
						li_upper4	++
					ELSE
						is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_more	+	&
														astr_timeframe[li_idx2].tbl_alias	+	lcs_object_from
						li_upper4	++
						is_where[li_upper4]	=	astr_timeframe[li_idx].tbl_alias	+	lcs_from_less	+	&
														astr_timeframe[li_idx2].tbl_alias	+	lcs_object_thru
						li_upper4	++
					END IF					//	ls_timeframe_from_thru	<>	'Y'
				END IF						// lb_match
			NEXT								//	li_idx2 = li_idx + 1	TO	li_upper
		NEXT									// li_idx =	1	TO	li_upper
		li_upper4	--
	CASE ELSE
		// This should never happen since the timeframe button <> 0 when calling
		//	this script.  Prior to Stars 4.5, fx_pattern_timeframe had erroneous logic
		MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_pattern_timeframe, '	+	&
					'cannot get the correct value of timeframe button.  Value accessed = '	+	&
					String (li_timeframe_button)	+	'.')
		Return	lcs_error
END CHOOSE

Return	ls_timeframe_from_thru


end function

public function string uf_select1_keys ();//*********************************************************************************
// Script Name:	uf_select1_keys - Overloaded function
//
//	Arguments:		None
//
// Returns:			String - SQL string
//
//	Description:	This script gets all columns that comprise of the unique key,
//						converts the column to a string (if necessary), and creates
//						a 'Select' portion.  For example, if table type C1 has a
//						unique key of ICN and ICN_LINE_NO, the resulting Select string
//						would be: 
//							a.ICN '@15001 ICN', a.ICN_LINE_NO '@15001 Line No'
//						The @1500' portion will be converted to C1.  As a result,
//						the SQL will be:
//							a.ICN 'C11 ICN', a.ICN_LINE_NO 'C11 Line No'
//
//	Note:				Prefix is not required.  As a result, this script can return:
//							ICN 'C11 ICN', ICN_LINE_NO 'C11 Line No'
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	This.uf_select1_keys(1)

end function

public function string uf_select2_keys ();//*********************************************************************************
// Script Name:	uf_select2_keys - Overloaded function
//
//	Arguments:		None
//
// Returns:			String - SQL string
//
//	Description:	This script gets all columns that comprise of the unique key,
//						converts the column to a string (if necessary), and creates
//						a 'Select' portion.  For example, if table type C1 has a
//						unique key of ICN and ICN_LINE_NO, the resulting Select string
//						would be: 
//							a.ICN, a.ICN_LINE_NO
//
//	Note:				Prefix is not required.  As a result, this script can return:
//							ICN, ICN_LINE_NO
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	This.uf_select2_keys (1)

end function

public function integer uf_edit_sql ();//*********************************************************************************
// Script Name:	uf_edit_sql
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This function looks at is_sql and replaces several placeholders
//						with actual SQL.
//
//	Note:				This function should be called after the prefixes and invoice
//						types have been registered (uf_edit_sql_prefix() and
//						uf_load_tbl_type).
//
//	SQL Examples:	A.@CONCAT		a.icn + convert(char(8),a.icn_line_no)
//						AB.@COMPARE		a.icn = b.icn and a.icn_line_no = b.icn_line_no
//						A.@SELECT1		a.icn 'C11 ICN', a.icn_line_no 'C11 LINE NUM'
//						A.@SELECT2		a.icn, a.icn_line_no
//						AB.@ANYCLAIM	(a.icn = b.icn and a.icn_line_no > b.icn_line_no)
//											or a.icn <> b.icn
//						AB.@SAMECLAIM	a.icn = b.icn and a.icn_line_no > b.icn_line_no
//						AB.@DIFFCLAIM	a.icn <> b.icn
//						AB.@REVJOIN		a.icn = b.icn			// Header to revenue join
//						AB.@REVLINE		a.rowid > b.rowid		// Revenue dummy line to prevent dup claims
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/19/01	FDG	Stars 4.6 (PIMR).  Look for @DAYSDIFF so that a DBMS-independent
//						SQL can be generated to compute the difference between 2 dates.
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//	04/11/08	GaryR	SPR 5249	Resolve DBMS dependent logic to increment days @DAYSADD
//
//*********************************************************************************

Boolean	lb_not_found

Integer	li_pos,					&
			li_pos2,					&
			li_rc,					&
			li_index,				&
			li_index2,				&
			li_length

String	ls_prefix,				&
			ls_prefix2,				&
			ls_dot,					&
			ls_new_sql,				&
			ls_old_sql,				&
			ls_and_or

// Convert is_sql to upper case
is_sql	=	Upper (is_sql)

// Replace B.@CONCAT with the appropriate concatenation string

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@CONCAT')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found B.@CONCAT.  The prefix is 2 bytes before @CONCAT (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		li_index		=	This.uf_get_index (ls_prefix)
		li_length	=	9
		li_pos		=	li_pos - 2
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_length	=	7
	END IF
	ls_new_sql		=	This.uf_concatenate_keys (li_index)
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. B.@CONCAT
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// Replace A.@COMPARE with the appropriate comparison string.  You can also
// have AB.@COMPARE which specifies which prefixes are being compared.

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@COMPARE')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found A.@COMPARE.  The prefix is 2 bytes before @COMPARE (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		ls_prefix2	=	Mid (is_sql, li_pos - 3, 1)
		IF	 ls_prefix2	<>	' '		&
		AND ls_prefix2	<>	'('		THEN
			// Have two prefixes to compare (i.e. ab.@COMPARE).  Get the index for both.
			li_index		=	This.uf_get_index (ls_prefix2)		//	Leftmost prefix
			li_index2	=	This.uf_get_index (ls_prefix)			// Rightmost prefix
			li_length	=	11
			li_pos		=	li_pos - 3
		ELSE
			// Only the 1st prefix is specified (i.e. a.@COMPARE)
			li_index		=	This.uf_get_index (ls_prefix)
			li_index2	=	li_index	+	1
			li_length	=	10
			li_pos		=	li_pos - 2
		END IF
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_index2	=	2
		li_length	=	8
	END IF
	ls_new_sql		=	This.uf_compare_keys (li_index, li_index2)
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. A.@COMPARE
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// Replace B.@SELECT1 with the appropriate select string

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@SELECT1')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found B.@SELECT1.  The prefix is 2 bytes before @SELECT1 (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		li_index		=	This.uf_get_index (ls_prefix)
		li_length	=	10
		li_pos		=	li_pos - 2
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_length	=	8
	END IF
	ls_new_sql		=	This.uf_select1_keys (li_index)
	ls_new_sql		=	Left (ls_new_sql, Len(ls_new_sql) - 1)	// Remove trailing ','
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)			// i.e. B.@SELECT1
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// Replace B.@SELECT2 with the appropriate select string

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@SELECT2')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found B.@SELECT2.  The prefix is 2 bytes before @SELECT2 (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		li_index		=	This.uf_get_index (ls_prefix)
		li_length	=	10
		li_pos		=	li_pos - 2
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_length	=	8
	END IF
	ls_new_sql		=	This.uf_select2_keys (li_index)
	ls_new_sql		=	Left (ls_new_sql, Len(ls_new_sql) - 1)	// Remove trailing ','
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)			// i.e. B.@SELECT2
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

//	Replace the AB.@REVJOIN with the actual Revenue join keys
lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@REVJOIN')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	
	// Found AB.@REVJOIN.  The prefix is 2 bytes before @REVJOIN
	// Get the index for this prefix so that the table	type can be accessed
	ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
	ls_prefix2	=	Mid (is_sql, li_pos - 3, 1)
	li_index		=	This.uf_get_index (ls_prefix2)		//	Leftmost prefix
	li_index2	=	This.uf_get_index (ls_prefix)			// Rightmost prefix
	
	li_length	=	11
	li_pos		=	li_pos - 3

	ls_new_sql		=	This.uf_where_rev_claim( li_index2, li_index )
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. AB.@REVJOIN
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

//	Replace the AB.@REVLINE with the actual Revenue line keys
lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@REVLINE')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	
	// Found AB.@REVLINE.  The prefix is 2 bytes before @REVLINE
	// Get the index for this prefix so that the table	type can be accessed
	ib_rev_crit = 	TRUE
	ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
	ls_prefix2	=	Mid (is_sql, li_pos - 3, 1)
	li_index		=	This.uf_get_index (ls_prefix2)		//	Leftmost prefix
	li_index2	=	This.uf_get_index (ls_prefix)			// Rightmost prefix
	
	li_length	=	11
	li_pos		=	li_pos - 3

	ls_new_sql		=	This.uf_where_rev_line( li_index, li_index2 )
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. AB.@REVLINE
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// Replace A.@ANYCLAIM with the appropriate comparison string.  You can also
// have AB.@ANYCLAIM which specifies which prefixes are being compared.
// Please note that when computing this SQL, "Any Claim" can generate an empty
//	string if the unique key only includes one column.  When this occurs, remove 
//	the preceeding 'AND' or 'OR'.

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@ANYCLAIM')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found A.@ANYCLAIM.  The prefix is 2 bytes before @ANYCLAIM (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		ls_prefix2	=	Mid (is_sql, li_pos - 3, 1)
		IF	 ls_prefix2	<>	' '		&
		AND ls_prefix2	<>	'('		THEN
			// Have two prefixes to compare (i.e. ab.@ANYCLAIM).  Get the index for both.
			li_index		=	This.uf_get_index (ls_prefix2)		//	Leftmost prefix
			li_index2	=	This.uf_get_index (ls_prefix)			// Rightmost prefix
			li_length	=	12
			li_pos		=	li_pos - 3
		ELSE
			// Only the 1st prefix is specified (i.e. a.@ANYCLAIM)
			li_index		=	This.uf_get_index (ls_prefix)
			li_index2	=	li_index	+	1
			li_length	=	11
			li_pos		=	li_pos - 2
		END IF
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_index2	=	2
		li_length	=	9
	END IF
	ls_new_sql		=	This.uf_where_claim ('A', li_index, li_index2)
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. A.@ANYCLAIM
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
	IF	Trim (ls_new_sql)	=	''		THEN
		// Any claim returns an empty string since the unique key only returns
		//	one column.  Remove the preceeding 'AND' or 'OR' if they exist.
		// Remove the preceeding 'AND'
		ls_and_or		=	Mid (is_sql, li_pos - 4, 3)
		IF	ls_and_or	=	'AND'		THEN
			is_sql		=	Left (is_sql, li_pos - 5)	+	Mid (is_sql, li_pos)
		ELSE
			// Remove the preceeding 'OR'
			ls_and_or		=	Mid (is_sql, li_pos - 3, 2)
			IF	ls_and_or	=	'OR'		THEN
				is_sql		=	Left (is_sql, li_pos - 4)	+	Mid (is_sql, li_pos)
			END IF
		END IF
	END IF
LOOP

// Replace A.@SAMECLAIM with the appropriate comparison string.  You can also
// have AB.@SAMECLAIM which specifies which prefixes are being compared.

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@SAMECLAIM')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found A.@SAMECLAIM.  The prefix is 2 bytes before @SAMECLAIM (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		ls_prefix2	=	Mid (is_sql, li_pos - 3, 1)
		IF	 ls_prefix2	<>	' '		&
		AND ls_prefix2	<>	'('		THEN
			// Have two prefixes to compare (i.e. ab.@SAMECLAIM).  Get the index for both.
			li_index		=	This.uf_get_index (ls_prefix2)		//	Leftmost prefix
			li_index2	=	This.uf_get_index (ls_prefix)			// Rightmost prefix
			li_length	=	13
			li_pos		=	li_pos - 3
		ELSE
			// Only the 1st prefix is specified (i.e. a.@SAMECLAIM)
			li_index		=	This.uf_get_index (ls_prefix)
			li_index2	=	li_index	+	1
			li_length	=	12
			li_pos		=	li_pos - 2
		END IF
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_index2	=	2
		li_length	=	10
	END IF
	ls_new_sql		=	This.uf_where_claim ('S', li_index, li_index2)
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. A.@SAMECLAIM
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// Replace A.@DIFFCLAIM with the appropriate comparison string.  You can also
// have AB.@DIFFCLAIM which specifies which prefixes are being compared.

lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@DIFFCLAIM')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found A.@DIFFCLAIM.  The prefix is 2 bytes before @DIFFCLAIM (if one exists)
	ls_dot		=	Mid (is_sql, li_pos - 1, 1)
	IF	ls_dot	=	'.'			THEN
		// A prefix exists.  Get the index for this prefix so that the table
		//	type can be accessed.
		ls_prefix	=	Mid (is_sql, li_pos - 2, 1)
		ls_prefix2	=	Mid (is_sql, li_pos - 3, 1)
		IF	 ls_prefix2	<>	' '		&
		AND ls_prefix2	<>	'('		THEN
			// Have two prefixes to compare (i.e. ab.@DIFFCLAIM).  Get the index for both.
			li_index		=	This.uf_get_index (ls_prefix2)		//	Leftmost prefix
			li_index2	=	This.uf_get_index (ls_prefix)			// Rightmost prefix
			li_length	=	13
			li_pos		=	li_pos - 3
		ELSE
			// Only the 1st prefix is specified (i.e. a.@DIFFCLAIM)
			li_index		=	This.uf_get_index (ls_prefix)
			li_index2	=	li_index	+	1
			li_length	=	12
			li_pos		=	li_pos - 2
		END IF
	ELSE
		//	No prefix exists.  Use the defaults.
		li_index		=	1
		li_index2	=	2
		li_length	=	10
	END IF
	ls_new_sql		=	This.uf_where_claim ('D', li_index, li_index2)
	ls_old_sql		=	Mid (is_sql, li_pos, li_length)		// i.e. A.@DIFFCLAIM
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// FDG 01/19/01 Begin
// Replace @DAYSDIFF(a.THRU_DATE,b.FROM_DATE) with the DBMS-independent SQL
lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@DAYSDIFF')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found @DAYSDIFF.  Generate the DBMS-independent SQL
	li_pos2		=	Pos (is_sql, ')', li_pos + 1)		// Find the trailing ')'
	li_length	=	li_pos2	-	li_pos	+	1
	ls_old_sql	=	Mid (is_sql, li_pos, li_length)
	ls_new_sql	=	gnv_sql.of_get_days_diff (ls_old_sql)
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

// Replace @DAYSADD(DATE,DAYS) with the DBMS-independent SQL
lb_not_found	=	FALSE

DO	UNTIL	lb_not_found	=	TRUE
	li_pos		=	Pos (is_sql, '@DAYSADD')
	IF	li_pos	=	0		THEN
		lb_not_found	=	TRUE
		Exit
	END IF
	// Found @DAYSADD.  Generate the DBMS-independent SQL
	li_pos2		=	Pos (is_sql, ')', li_pos + 1)		// Find the trailing ')'
	li_length	=	li_pos2	-	li_pos	+	1
	ls_old_sql	=	Mid (is_sql, li_pos, li_length)
	ls_new_sql	=	gnv_sql.of_get_days_add (ls_old_sql)
	This.uf_replace_sql (ls_old_sql, ls_new_sql)
LOOP

Return	1
end function

public function integer uf_update_report_cols (string as_report_id);//*********************************************************************************
// Script Name:	uf_update_report_cols
//
//	Arguments:		as_report_id - Report ID to be set in report_cols
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This script is called from w_sampling_analysis_new.ue_subset
//						and will update ids_report_cols.
//						
//	Note:				The contents of ids_report_cols (except report_id) was filled
//						in (by ue_spec_sql and ue_pattern_select) when the SQL was
//						generated for the report.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_rowcount,			&
			ll_row

ll_rowcount		=	ids_report_cols.RowCount()

// Update the report ID in each row.

FOR	ll_row	=	1	TO	ll_rowcount
	ids_report_cols.object.report_id [ll_row]	=	as_report_id
NEXT

// Update the datastore
li_rc		=	ids_report_cols.EVENT ue_update( TRUE, TRUE )

IF	li_rc	<	0		THEN
	Return	-1
ELSE
	Return	1
END IF

end function

public function integer uf_delete_report_cols ();//*********************************************************************************
// Script Name:	uf_delete_report_cols
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This script is called from the Cancel button is clicked from
//						Subset options when creating a Pattern Report and Subset.
//
//						This script will remove all rows from ids_report_cols and
//						update the database.
//						
//	Note:				The contents of ids_report_cols (except report_id) was filled
//						in (by ue_spec_sql and ue_pattern_select) when the SQL was
//						generated for the report.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_rowcount,			&
			ll_row

ll_rowcount		=	ids_report_cols.RowCount()

// Delete each row.

FOR	ll_row	=	1	TO	ll_rowcount
	ids_report_cols.DeleteRow (ll_row)
	ll_row	--
	ll_rowcount	--
NEXT

// Update the datastore
li_rc		=	ids_report_cols.EVENT ue_update( TRUE, TRUE )

IF	li_rc	<	0		THEN
	Return	-1
ELSE
	Return	1
END IF

end function

public function string uf_get_tbl_desc (string as_tbl_type);//*********************************************************************************
// Script Name:	uf_get_tbl_desc
//
//	Arguments:		1.	as_tbl_type
//
// Returns:			String - The description for the table type
//
//	Description:	This function gets the description for the table type
//						from the dictionary table.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

String		ls_tbl_desc

Integer		li_rc

Select	elem_desc
Into		:ls_tbl_desc
From		Dictionary
Where		elem_type	=	'TB'
  And		elem_tbl_type	=	Upper( :as_tbl_type )
Using		Stars2ca ;

Stars2ca.of_check_status()

// Use the 1st 15 bytes of the table description
This.uf_edit_elem_desc (ls_tbl_desc)


Return	ls_tbl_desc


end function

public function string uf_dep_set_sql (string as_sql, string as_dep_delect, sx_dep_set astr_dep_set, string as_order_by_prefix);//*********************************************************************************
// Script Name:	uf_dep_set_sql
//
//	Arguments:		1.	as_sql - The originally created SQL
//						2.	as_dep_delect
//						3.	astr_dep_set (type sx_dep_set)
//						4.	as_order_by_prefix
//
// Returns:			String - The new SQL
//
//	Description:	Create a select statement to be "unioned" with the original
//						sql to return dependent rows for hits found in the same claim.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Constant	String	lcs_icn = 'ICN'

Integer		li_idx,					&
				li_upper

String		ls_from,					&
				ls_where,				&
				ls_sub_sql,				&
				ls_in,					&
				ls_group_by,			&
				ls_dep_sql,				&
				ls_new_sql
				
ls_from		=	' FROM '	+	astr_dep_set.main_tbl_name	+	&
					' s, '	+	astr_dep_set.tbl_name		+	' t'
ls_sub_sql	=	" and t.icn in (select icn from "		+	&
					astr_dep_set.tbl_name	+	" WHERE subc_id = '"	+	&
					Upper( astr_dep_set.subc_id )		+	"'"
ls_where		=	" WHERE s.subc_id = '"	+	&
					Upper( astr_dep_set.subc_id )		+	&
					"' and t.subc_id = '"	+	&
					Upper( astr_dep_set.subc_id )		+	&
					"' and s."	+	lcs_icn	+	&
					" = t."		+	lcs_icn
ls_in			=	''

li_upper		=	UpperBound (astr_dep_set.values)

FOR	li_idx	=	1	TO	li_upper
	IF	astr_dep_set.values[li_idx]	<>	''		THEN
		IF	li_idx	>	1		THEN
			ls_in	=	ls_in	+	','
		END IF
		ls_in		=	ls_in	+	astr_dep_set.values[li_idx]
	END IF
NEXT

ls_where		=	ls_where	+	" and t."	+	&
					astr_dep_set.col_name	+	&
					" in ( "	+	ls_in	+	")"

ls_sub_sql	=	ls_sub_sql	+	" and "	+	&
					astr_dep_set.col_name	+	&
					" in ( "	+	ls_in	+	")"

ls_group_by	=	' GROUP BY '	+	lcs_icn	+	&
					' HAVING COUNT('				+	&
					astr_dep_set.col_name		+	&
					') > 1) ORDER BY '			+	&
					as_order_by_prefix			+	&
					'.'	+	lcs_icn

ls_dep_sql	=	as_dep_delect	+	ls_from	+	&
					ls_where	+	ls_sub_sql		+	&
					ls_group_by

ls_new_sql	=	as_sql	+	' UNION '	+	ls_dep_sql

Return	ls_new_sql

end function

public function integer uf_format_line (long al_row);//*********************************************************************************
// Script Name:	uf_format_line
//
//	Arguments:		al_row - The row in idw_criteria
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	For the row # passed, determine the where clause for
//						the line of criteria.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	06/25/04	GaryR	Track 4042d	Allow filters across all patterns
//
//*********************************************************************************

Integer		li_or_pos,				&
				li_and_pos

String		ls_field_set,			&
				ls_col_name,			&
				ls_tbl_type,			&
				ls_data_type,			&
				ls_operator,			&
				ls_value,				&
				ls_temp_value,			&
				ls_filter_id,			&
				ls_filter_data_type, &
				ls_filter_tbl_name,	&
				ls_filter_db

IF	al_row	>	0		THEN
ELSE
	Return	0
END IF

ls_field_set	=	idw_criteria.object.field_set [al_row]
ls_col_name		=	idw_criteria.object.field_col_name [al_row]
ls_tbl_type		=	idw_criteria.object.field_tbl_type [al_row]
ls_operator		=	idw_criteria.object.field_operator [al_row]
ls_value			=	idw_criteria.object.field_value [al_row]

IF	IsNull (ls_col_name)		THEN
	ls_col_name		=	''
END IF

IF	(IsNull (ls_col_name)	OR	Trim (ls_col_name)	=	'')		&
AND al_row			>	1														&
AND is_pattern_id	=	ics_generic											THEN
	// Last line of generic criteria (not the first) that was not entered.  Get out.
	Return	0
END IF

IF	Trim (ls_col_name)	=	''		THEN
	//	For a numbered pattern, all columns are required
	MessageBox ('Error', 'You must select a column for all fields.')
	Return	-1
END IF

IF	ls_value		=	is_same_column		THEN
	// A column's value is being compared against itself.  Get out.
	Return	0
END IF

IF	Upper (ls_col_name)	=	'DAYS'			&
OR	Upper (ls_col_name)	=	'OCCURRENCES'	&
OR	Upper (ls_col_name)	=	'PROVIDERS'		THEN
	// Do not format these values
	Return	0
END IF

IF	ls_value		=	'%'		THEN
	ls_operator	=	'like'
END IF

IF	Trim (ls_operator)	=	''		THEN
	MessageBox ('Error', 'You must select an operator for all fields.')
	Return	-1
END IF

IF	Trim (ls_value)	=	''		THEN
	MessageBox ('Error', 'You must select a value for all fields.')
	Return	-1
END IF

SELECT	elem_data_type
INTO		:ls_data_type
FROM		Dictionary
WHERE		elem_type		=	'CL'
  AND		elem_tbl_type	=	Upper( :ls_tbl_type )
  AND		elem_name		=	Upper( :ls_col_name )
USING		Stars2ca;

IF	Stars2ca.of_check_status()	<>	0		THEN
	MessageBox ('Database Error', 'In u_nvo_pattern_sql.uf_format_line, cannot '	+	&
					'retrieve elem_data_type from dictionary where elem_type = CL '	+	&
					'and elem_tbl_type = '	+	ls_tbl_type	+	&
					' and elem_name = '		+	ls_col_name	+	'.')
	Return	-1
END IF

// Process filter
IF gnv_app.of_is_filter_name( ls_value ) THEN
	ls_filter_id = Upper( Mid( ls_value, 2 ) )
	
	IF Trim( ls_filter_id ) = '' then
		MessageBox('Error', 'A Filter id must follow @.',StopSign!,Ok!)
		Return -1
	END IF

	IF	is_pattern_id	<>	ics_filter_pat		THEN
		CHOOSE CASE	Upper( ls_operator )
			CASE	'=', 'IN'
				ls_operator = "IN"
			CASE	'<>', 'NOT IN'
				ls_operator = "NOT IN"
			CASE ELSE
				MessageBox ("Error", "When using a filter, the relational operator must be '=', 'NOT =', 'IN', 'NOT IN'.",	&
								StopSign!,Ok!)
				Return -1
		END CHOOSE
	ELSE
		CHOOSE CASE	Upper( ls_operator )
			CASE	'=', 'IN'
				ls_operator = "IN"
			CASE ELSE
				MessageBox ("Error", "When using a filter pattern, the relational operator must be '=' OR 'IN'.",	&
								StopSign!,Ok!)
				Return -1
		END CHOOSE
	END IF
	
	if ls_col_name = "PAYMENT_DATE" then
		MessageBox('Error', 'Cannot use a Filter with a Date Paid.',StopSign!,Ok!)
		Return -1
	end if

	// will check for valid id and return data type and column in filter_vals table
	ls_filter_data_type = gnv_app.of_get_filter_type( ls_filter_id )
	IF ls_filter_data_type = "ERROR" THEN
		MessageBox('Error', "Filter ID: " + ls_filter_id + " is not valid." ,StopSign!,Ok!)
		Return -1
	END IF

	IF gnv_sql.of_is_character_data_type (ls_data_type)		THEN
		ls_data_type = 'CHAR'
	ELSEIF gnv_sql.of_is_number_data_type (ls_data_type)		THEN
		ls_data_type = 'NUMBER'
	ELSEIF gnv_sql.of_is_money_data_type (ls_data_type)		THEN
		ls_data_type = 'MONEY'
	ELSEIF gnv_sql.of_is_date_data_type (ls_data_type)		THEN
		ls_data_type = 'DATE'
	END IF
	
	if upper(ls_data_type) <> upper(ls_filter_data_type) then
		MessageBox('Error', 'Value does not match filter data type.',StopSign!,Ok!)
		Return -1
	end if
	
	SELECT db 
	  INTO :ls_filter_db
	  FROM dictionary 
 	 WHERE elem_type = 'UT'
	   AND elem_tbl_type = 'FV'
	 USING Stars2ca;
	 
	if stars2ca.of_check_status() < 0 then
		MessageBox( "ERROR", "Unable to obtain the filters database name " + &
						"where elem_type = 'UT' and elem_tbl_type = 'FV'", StopSign! )
		Return -1
	end if
	
	stars2ca.of_commit()
	
	IF IsNull( ls_filter_db ) OR Trim( ls_filter_db ) = "" THEN
		ls_filter_db = gnv_sql.of_get_database_prefix( Stars2ca.database )
	ELSE
		ls_filter_db = gnv_sql.of_get_database_prefix( ls_filter_db )
	END IF

	ls_filter_tbl_name = gnv_server.of_GetFilterTableName(ls_filter_id)
	ls_value = "(SELECT FILTER_DATA FROM " + ls_filter_tbl_name + ")"
else
	IF gnv_sql.of_is_date_data_type (ls_data_type)		THEN
		// Call format_where for editing purposes only
		ls_temp_value	=	format_where (ls_value, ls_operator, ls_col_name)
		IF	Left (ls_temp_value, 1)	=	'!'	THEN
			ls_value	=	ls_temp_value
		ELSE
			ls_value	=	gnv_sql.of_get_to_date (ls_value)
		END IF
	ELSEIF gnv_sql.of_is_character_data_type (ls_data_type)		THEN
		ls_value	=	format_where (ls_value, ls_operator, ls_col_name)
	ELSE
		ls_value	=	format_where_n (ls_value, ls_operator)
	END IF
	
	IF	Left (ls_value, 1)	=	'!'	THEN
		MessageBox ('Error', Mid (ls_value, 2) )
		Return	-1
	END IF
END IF

// Look for a ' OR ' or ' AND ' in the value.  It doesn't matter 
//	which one you find.
li_or_pos	=	Pos (ls_value, ' OR ')

IF	li_or_pos	=	0		THEN
	li_and_pos	=	Pos (ls_value, ' AND ')
END IF


IF	( Upper(ls_operator)	=	'LIKE'	OR	 Upper(ls_operator)	=	'NOT LIKE' )	&
AND (li_or_pos	>	0	OR	li_and_pos	>	0)													THEN
	
	ib_multiple_likes [al_row]		=	TRUE
	IF	li_or_pos	>	0		THEN
		// Convert "col_name like '001% OR 0007%'" to:
		//		"col_name like '001%' OR col_name like '007%'"
		is_where_clause [al_row]	=	ls_col_name	+	" "	+	ls_operator			+	&
												" "	+	Mid (ls_value, 1, li_or_pos - 1)	+	&
												"' OR "	+	ls_col_name	+	" "				+	&
												ls_operator	+	" '"	+	Mid (ls_value, li_or_pos + 4)	+	"'"
	ELSE
		is_where_clause [al_row]	=	ls_col_name	+	" "	+	ls_operator			+	&
												" "	+	Mid (ls_value, 1, li_or_pos - 1)	+	&
												"' AND "	+	ls_col_name	+	" "				+	&
												ls_operator	+	" '"	+	Mid (ls_value, li_or_pos + 4)	+	"'"
	END IF
ELSE
	is_where_clause [al_row]		=	ls_col_name	+	" "	+	ls_operator			+	&
												" "	+	ls_value
	ib_multiple_likes [al_row]		=	FALSE
END IF

Return 1
end function

public function integer uf_pattern_select_not_array ();//*********************************************************************************
// Script Name:	uf_pattern_select_not_array
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This function is called by uf_pattern_sql_not() and will fill
//						an array of columns (istr_select_cols_not[]) and tables
//						(istr_tables[]) to be used in the upper select for 'NOT IN'.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_found

Integer	li_idx,				&
			li_idx2,				&
			li_idx3,				&
			li_upper,			&
			li_upper2

Long		ll_row,				&
			ll_rowcount,		&
			ll_find_row

String	ls_tbl_type,		&
			ls_field_column,	&
			ls_field_label,	&
			ls_data_type,		&
			ls_find,				&
			ls_temp_column

// Get the distinct list of table types

li_upper	=	UpperBound (istr_from_tables)

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].tbl_rel		=	'M'		THEN
		// Main table.  Load the DISTINCT invoice types from istr_from_tables
		li_upper2	=	UpperBound (istr_tables)
		lb_found		=	FALSE
		FOR	li_idx2	=	1	TO	li_upper2
			IF	istr_from_tables[li_idx].tbl_type	=	istr_tables[li_idx2].tbl_type	THEN
				lb_found	=	TRUE
				Exit
			END IF
		NEXT
		IF	lb_found	=	FALSE			THEN
			// Add the distinct tbl_type to istr_tables
			istr_tables[li_upper2 + 1].tbl_type		=	istr_from_tables[li_idx].tbl_type
			istr_tables[li_upper2 + 1].tbl_name		=	istr_from_tables[li_idx].tbl_name
		END IF		// lb_found	=	FALSE
	END IF			//	istr_from_tables[li_idx].tbl_rel	 =	'M'
NEXT					// li_idx	=	1	TO	li_upper

// Fill in the column array

ll_rowcount		=	idw_selected.RowCount()
li_upper			=	UpperBound (istr_tables)

FOR	li_idx	=	1	TO	li_upper
	ls_find			=	"elem_tbl_type = '"	+	istr_tables[li_idx].tbl_type	+	"'"
	ll_find_row		=	idw_selected.Find (ls_find, 1, ll_rowcount)
	DO	WHILE	ll_find_row	>	0
		ls_tbl_type			=	idw_selected.object.elem_tbl_type [ll_find_row]
		ls_field_column	=	idw_selected.object.elem_name [ll_find_row]
		ls_field_label		=	idw_selected.object.elem_desc [ll_find_row]
		ls_data_type		=	Upper (idw_selected.object.elem_data_type [ll_find_row])
		lb_found				=	FALSE
		li_upper2			=	UpperBound (istr_select_cols_not)
		FOR	li_idx2	=	1	TO	li_upper2
			IF	ls_field_column	=	istr_select_cols_not[li_idx2].column	THEN
				lb_found		=	TRUE
				Exit
			END IF
		NEXT				//	li_idx2	=	1	TO	li_upper2
		IF	lb_found	=	FALSE		THEN
			li_idx2	=	li_upper2	+	1
		END IF
		li_idx3		=	UpperBound (istr_select_cols_not[li_idx2].tbl_type) +	1
		istr_select_cols_not[li_idx2].tbl_type[li_idx3]	=	ls_tbl_type
		istr_select_cols_not[li_idx2].column				=	ls_field_column
		istr_select_cols_not[li_idx2].label					=	ls_field_label
		istr_select_cols_not[li_idx2].data_type			=	ls_data_type
		
		ll_find_row	++
		IF	ll_find_row	>	ll_rowcount		THEN
			Exit			// Prevent searching backwards
		END IF
		ll_find_row		=	idw_selected.Find (ls_find, ll_find_row, ll_rowcount)
	LOOP
	// Columns added from dw_selected.  Add any additional criteria
	//	columns to istr_select_cols_not
	ls_temp_column	=	''
	ll_rowcount	=	idw_criteria.RowCount()
	FOR	ll_row	=	1	TO	ll_rowcount
		ls_tbl_type			=	idw_criteria.object.field_tbl_type [ll_row]
		ls_field_column	=	idw_criteria.object.field_col_name [ll_row]
		ls_field_label		=	idw_criteria.object.field_description [ll_row]
		// Find the distinct column in istr_select_cols_not
		IF	istr_tables[li_idx].tbl_type	=	ls_tbl_type		THEN
			IF	ls_temp_column	<>	ls_field_column				THEN
				lb_found				=	FALSE
				li_upper2			=	UpperBound (istr_select_cols_not)
				FOR	li_idx2	=	1	TO	li_upper2
					IF	ls_field_column	=	istr_select_cols_not[li_idx2].column	THEN
						lb_found		=	TRUE
						Exit
					END IF
				NEXT				//	li_idx2	=	1	TO	li_upper2
				IF	lb_found	=	FALSE		THEN
					li_idx2	=	li_upper2	+	1
					istr_select_cols_not[li_idx2].tbl_type[li_idx3]	=	ls_tbl_type
					istr_select_cols_not[li_idx2].column				=	ls_field_column
					istr_select_cols_not[li_idx2].label					=	ls_field_label
					istr_select_cols_not[li_idx2].data_type			=	''
				END IF		//	lb_found	=	FALSE
				ls_temp_column	=	ls_field_column
			END IF			// ls_temp_column	<>	ls_field_column
		END IF				//	istr_tables[li_idx].tbl_type	=	ls_tbl_type
	NEXT						// ll_row	=	1	TO	ll_rowcount
NEXT							// li_idx	=	1	TO	li_upper

// Loop through istr_select_cols_not.  If no data_type exists, get from dictionary.

li_upper	=	UpperBound (istr_select_cols_not)

FOR	li_idx	=	1	TO	li_upper
	IF IsNull (istr_select_cols_not[li_idx].data_type)		&
	OR	istr_select_cols_not[li_idx].data_type	=	''			THEN
		SELECT	elem_data_type
		INTO		:istr_select_cols_not[li_idx].data_type
		FROM		dictionary
		WHERE		elem_type		=	'CL'
		  AND		elem_tbl_type	=	Upper( :istr_select_cols_not[li_idx].tbl_type[1] )
		  AND		elem_name		=	Upper( :istr_select_cols_not[li_idx].column )
		USING		Stars2ca;
		IF	Stars2ca.of_check_status()	<>	0		THEN
			MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_pattern_select_not_array, '	+	&
							'cannot read dictionary where elem_type = CL, elem_tbl_type = '	+	&
							istr_select_cols_not[li_idx].tbl_type[1]	+	', elem_name = '		+	&
							istr_select_cols_not[li_idx].column	+	'.')
			Return	-1
		END IF
	END IF
NEXT


Return	1

end function

public function integer uf_parse_subset_table (string as_table, ref string as_table_type, ref string as_subset_id);//*********************************************************************************
// Script Name:	uf_parse_subset_table
//
//	Arguments:		1.	as_table
//						2.	as_table_type (by reference)
//						3.	as_subset_id (by reference)
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This function will take a subset table (as_table) and parse it
//						out to a table type and subset ID.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	03/12/01	FDG	Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
//
//*********************************************************************************

String		ls_table,		&
				ls_prefix
Long			ll_pos
Int			li_rc,			&
				li_len

ls_prefix	=	Upper (gnv_sql.of_get_subset_prefix() )	// FDG 03/12/01
li_len		=	Len (ls_prefix)	+	1							// FDG 03/12/01

as_table		=	Upper (as_table)
//ll_pos		=	Pos (as_table, 'SUB_MEDC_')
ll_pos		=	Pos (as_table, ls_prefix)						// FDG 03/12/01

IF	 ll_pos	= 1		THEN
	//ls_table			=	Mid (as_table, 10)
	//as_table_type	=	Mid (as_table, 10, 2)
	ls_table			=	Mid (as_table, li_len)					// FDG 03/12/01
	as_table_type	=	Mid (as_table, li_len, 2)				// FDG 03/12/01
	ll_pos			=	Pos (ls_table, '_')
	IF ll_pos = 3		THEN
		as_subset_id	=	Mid (ls_table, 4, 10)
		Return	1
	ELSE
		Return	-1
	END IF
ELSE
	Return	-1
END IF


end function

public function string uf_pattern_sql_not (string as_sql);//*********************************************************************************
// Script Name:	uf_pattern_sql_not
//
//	Arguments:		as_sql
//
// Returns:			String
//
//	Description:	This function is called by ue_pattern_sql and will build
//						the SQL for 'NOT IN' using an array of columns 
//						(istr_select_cols_not[]) and tables (istr_tables[]).
//						uf_pattern_select_not_array() fills in these structures.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/14/00	FDG	Stars 4.7.  Make data type checking DBMS-independent
//
//*********************************************************************************

Boolean		lb_found	=	FALSE

Constant	String	lcs_prefix	=	'z'
Constant	String	lcs_error	=	'ERROR'

Integer		li_rc,			&
				li_idx,			&
				li_idx2,			&
				li_idx3,			&
				li_upper,		&
				li_upper2,		&
				li_upper3
				
String		ls_sql,			&
				ls_select

// Fill in istr_select_cols_not[] and istr_tables[]
li_rc	=	This.uf_pattern_select_not_array ()

IF	li_rc	<	0		THEN
	Return	lcs_error
END IF

li_upper		=	UpperBound (istr_tables)
li_upper2	=	UpperBound (istr_select_cols_not)

FOR	li_idx	=	1	TO	li_upper			// Each table type
	FOR	li_idx2	=	1	TO	li_upper2	//	Each column
		lb_found		=	FALSE
		li_upper3	=	UpperBound (istr_select_cols_not[li_idx2].tbl_type)
		FOR	li_idx3	=	1	TO	li_upper3
			IF	istr_select_cols_not[li_idx2].tbl_type[li_idx3]	=	istr_tables[li_idx].tbl_type	THEN
				lb_found	=	TRUE
				Exit
			END IF
		NEXT				//	li_idx3	=	1	TO	li_upper3
		IF	lb_found		THEN
			ls_select	=	ls_select	+	lcs_prefix	+	'.'		+	&
								istr_select_cols_not[li_idx2].column	+	&
								' "'	+	istr_select_cols_not[li_idx2].label	+	'",'
		ELSE
			// FDG 12/14/00 - Make the checking of data types DBMS-independent.
			//CHOOSE CASE	istr_select_cols_not[li_idx2].data_type
			//	CASE	'CHAR', 'SMALLDATETIME', 'DATETIME', 'VARCHAR'
			//		ls_select	=	ls_select	+	"' '" +  ' "'	+	&
			//							istr_select_cols_not[li_idx2].label	+	'",'
			//	CASE	ELSE
			//		ls_select	=	ls_select	+	"0"	+	' "'	+	&
			//							istr_select_cols_not[li_idx2].label	+	'",'
			//END CHOOSE
			IF gnv_sql.of_is_character_data_type (istr_select_cols_not[li_idx2].data_type)		THEN
				ls_select	=	ls_select	+	"' '" +  ' "'	+	&
									istr_select_cols_not[li_idx2].label	+	'",'
			ELSEIF gnv_sql.of_is_date_data_type (istr_select_cols_not[li_idx2].data_type)			THEN
				ls_select	=	ls_select	+	gnv_sql.of_get_to_date('01/01/1900') +  ' "'	+	&
									istr_select_cols_not[li_idx2].label	+	'",'
			ELSE
				ls_select	=	ls_select	+	"0"	+	' "'	+	&
									istr_select_cols_not[li_idx2].label	+	'",'
			END IF
		END IF
	NEXT					//	li_idx2	=	1	TO	li_upper2
	ls_select	=	"SELECT "	+	Left (ls_select, Len(ls_select) - 1)	+	&
						" FROM "	+	istr_tables[li_idx].tbl_name	+	" "	+	lcs_prefix
	ls_sql		=	ls_sql	+	ls_select	+	" "	+	as_sql	+	" UNION "
	ls_select	=	''
NEXT						//	li_idx	=	1	TO	li_upper

// remove the trailing ' UNION '
ls_sql	=	Left (ls_sql, Len(ls_sql) - 7)

Return	ls_sql

end function

public function string uf_get_string_value (long al_row, integer ai_column);//*********************************************************************************
// Script Name:	uf_get_string_value
//
//	Arguments:		1.	al_row		-	The row # in dw_report
//						2.	ai_column	-	The column # in dw_report
//
// Returns:			String (including quotes if necessary)
//
//	Description:	This function gets the column's value from dw_report and
//						converts it to a string.  This returned string can then be
//						used as part of an SQL string to insert into a temp table.
//
//						This function is called from ue_create_temp_table() when 
//						the Subset RMM is selected on the Report tab.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	08/07/01	GaryR	Stars 4.7	Track 2396d Date conversion
//
//*********************************************************************************



String	ls_colname,				&
			ls_coltype,				&
			ls_describe,			&
			ls_value

Long		ll_value

Date		ldt_value

DateTime	ldtm_value

Time		ltm_value

Decimal	ldc_value

// Edit the input
IF	al_row		=	0		&
OR	ai_column	=	0		THEN
	Return	''
END IF

// Determine the data type of the column.  To do this, you need the column name.

ls_describe	=	"#"	+	String (ai_column)	+	".Name"
ls_colname	=	idw_report.Describe (ls_describe)

ls_describe	=	ls_colname	+	".ColType"
ls_coltype	=	idw_report.Describe (ls_describe)

// Get the 1st 5 bytes of the column type to remove any lengths for 'Char(n)'
//	and 'Decimal(n)'.
ls_coltype	=	Trim ( Left(ls_coltype, 5) )
ls_coltype	=	Upper (ls_coltype)		// Convert to upper case

// The 1st 5 bytes of column type can be: 'CHAR(', 'DATE', 'DATET', 'DECIM',
//	'INT', 'LONG', 'NUMBE', 'REAL', 'TIME', 'TIMES', 'ULONG'

CHOOSE CASE ls_coltype
	CASE 'CHAR('
		ls_value		=	idw_report.GetItemString (al_row, ai_column)
		ls_value		=	"'"	+	ls_value	+	"'"
	CASE 'INT', 'LONG', 'NUMBE', 'ULONG'
		ll_value		=	idw_report.GetItemNumber (al_row, ai_column)
		ls_value		=	String (ll_value)
	CASE 'DECIM', 'REAL'
		ldc_value	=	idw_report.GetItemDecimal (al_row, ai_column)
		ls_value		=	String (ldc_value)
	CASE 'DATE'
		ldt_value	=	idw_report.GetItemDate (al_row, ai_column)
		//	08/07/01	GaryR	Stars 4.7
		//ls_value		=	"'"	+	String (ldt_value, 'mm/dd/yyyy')	+	"'"
		ls_value		=	gnv_sql.of_get_to_date(	String( ldt_value, 'mm/dd/yyyy' ) )
	CASE 'DATET'
		ldtm_value	=	idw_report.GetItemDateTime (al_row, ai_column)
		//	08/07/01	GaryR	Stars 4.7
		//ls_value		=	String (ldtm_value, 'mm/dd/yyyy hh:mm')
		ls_value		=	gnv_sql.of_get_to_date(	String( ldtm_value, 'mm/dd/yyyy hh:mm:ss' ) )
	CASE 'TIME', 'TIMES'
		ltm_value	=	idw_report.GetItemTime (al_row, ai_column)
		ls_value		=	"'"	+	String (ltm_value, 'hh:mm')	+	"'"
END CHOOSE


Return	ls_value


end function

public function long uf_get_server_job_id ();///////////////////////////////////////////////////////////////
//
// 08/08/01	GaryR	Track 2396d	Functional flaw creating subsets
//
///////////////////////////////////////////////////////////////

RETURN il_server_job_id
end function

public function string uf_concatenate_keys (integer ai_index);//*********************************************************************************
// Script Name:	uf_concatenate_keys
//
//	Arguments:		ai_index - Index from istr_from_tables
//
// Returns:			String - SQL string
//
//	Description:	This script gets all columns that comprise of the unique key,
//						converts the column to a string (if necessary), and creates
//						a concatenation.  For example, if table type C1 has a
//						unique key of ICN and ICN_LINE_NO, the resulting concatenation
//						would be: 
//							(a.ICN + Convert(Char(10), a.ICN_LINE_NO)))
//						Prefix is not required.  As a result, this script can return:
//							(ICN + Convert(Char(10), ICN_LINE_NO)))
//
//						Part of this process is to include a 'Convert' for key columns
//						with a numeric or datatime data type.  For example, a column
//						of type money/smallmoney will have: Convert(Char(10), column)
//						whereas a datetime column will have:
//						Convert(Char(10), column, 101)
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	12/14/00	FDG	Stars 4.7.
//						1.	Make the checking of data types DBMS-independent.
//						2. Change the ASE "Convert" to be DBMS-independent.
//						3. Use '||' instead of '+' to concatenate columns.
//	09/18/01	GaryR	Track 2424d	Do not format date.  Causes parsing problems.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount,			&
			ll_ids_rowcount

String	ls_prefix,				&
			ls_inv_type,			&
			ls_convert,				&
			ls_col_name,			&
			ls_col_type
			
// Edit the input
IF	IsNull (ai_index)				&
OR	ai_index	=	0					THEN
	Return	''
END IF

ls_convert	=	''
ls_prefix	=	istr_from_tables[ai_index].prefix
ls_inv_type	=	istr_from_tables[ai_index].tbl_type

// Edit the prefix to append '.'
ls_prefix	=	This.uf_create_sql_prefix(ls_prefix)

// Get the column name and data type from ids_index_columns

ll_rowcount	=	istr_from_tables[ai_index].ids_index_columns.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	istr_from_tables[ai_index].ids_index_columns.object.elem_name [ll_row]
	ls_col_type		=	Upper ( istr_from_tables[ai_index].ids_index_columns.object.elem_data_type [ll_row] )
	
	IF gnv_sql.of_is_date_data_type (ls_col_type)		THEN
		ls_convert	=	ls_convert	+	gnv_sql.is_concat	+	&
							gnv_sql.of_get_to_char ("char(10), "	+	ls_prefix + ls_col_name	 )	//	09/18/01	GaryR	Track 2424d
	ELSEIF gnv_sql.of_is_numeric_data_type (ls_col_type)		THEN
		ls_convert	=	ls_convert	+	gnv_sql.is_concat	+	&
							gnv_sql.of_get_to_char ("char(10), "	+	ls_prefix + ls_col_name)
	ELSE
		ls_convert	=	ls_convert	+	gnv_sql.is_concat	+	ls_prefix	+	ls_col_name
	END IF
NEXT

IF	Len (ls_convert)	>	1		THEN
	// Remove the leading " + " and place parenthesis around it
	ls_convert	=	'('	+	Mid (ls_convert, Len( gnv_sql.is_concat ) + 1)	+	')'
END IF

Return	ls_convert
end function

public function boolean uf_is_unique_key (string as_tbl_type, string as_col_name);//*********************************************************************************
// Script Name:	uf_is_unique_key
//
//	Arguments:		1.	as_tbl_type
//						2.	as_col_name
//
// Returns:			Boolean
//						TRUE	=	tbl_type & col_name are part of the unique key
//						FALSE	=	tbl_type & col_name are NOT part of the unique key
//
//	Description:	Based on the table type and column name passed, determine if
//						the column is part of the table type's unique key.  This 
//						function is needed for Generic/filter patterns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//*********************************************************************************

Boolean	lb_found

Integer	li_idx,					&
			li_upper

Long		ll_rowcount,			&
			ll_find_row

String	ls_find			

li_upper	=	UpperBound (istr_from_tables)

// Revenue tables do not have unique keys
IF	as_tbl_type	=	is_revenue_code		THEN
	Return	FALSE
END IF

FOR	li_idx	=	1	TO	li_upper
	IF	istr_from_tables[li_idx].tbl_type	<>	as_tbl_type		THEN
		Continue
	END IF
	// Match on table type.  Find the column name.
	ls_find	=	"elem_tbl_type = '"		+	as_tbl_type	+	&
					"' and elem_name = '"	+	as_col_name	+	"'"
	ll_rowcount	=	istr_from_tables[li_idx].ids_index_columns.RowCount()
	ll_find_row	=	istr_from_tables[li_idx].ids_index_columns.Find (ls_find, 1, ll_rowcount)
	IF	ll_find_row	>	0		THEN
		lb_found	=	TRUE
	ELSE
		lb_found	=	FALSE
	END IF
NEXT

Return	lb_found
end function

public subroutine uf_clear_data ();//*********************************************************************************
// Script Name:	uf_clear_data
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Clear any instance variables that was previously set.  This
//						can occur from the Constructor event and when a pattern
//						is selected/imported.
//
//	Note:				Since many instance variables are set by calling uf_set_...
//						functions, call these same functions to reset the data.
//
//						The instance datawindows are pointers to what is actually
//						displayed in the window.  As a result, these datawindows
//						don't get reset.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/14/01	GaryR	Track 2556d	Do not reset idw_report_cols when saving the pattern
//	01/15/01	GaryR	Track 2558d	Do not reset is_revenue_code
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//
//*********************************************************************************

Boolean	lb_false[]

String	ls_empty_string[]

sx_from_tables			lstr_from_tables[]
sx_select_cols_not	lstr_select_cols_not[]
sx_tables				lstr_tables[]

This.uf_set_background_flag (FALSE)
This.uf_set_union_flag (FALSE)
This.uf_set_not_flag (FALSE)
This.uf_set_subset_tbl_type (ls_empty_string)
This.uf_set_subset_id ('')
This.uf_set_case_id ('')
This.uf_set_pattern_id ('')

is_where				=	ls_empty_string
is_where_clause	=	ls_empty_string
is_tbl_rel			=	ls_empty_string
is_main_tbl			=	ls_empty_string
ib_multiple_likes	=	lb_false
ib_same_crit		= 	FALSE

// Initialize non-generic data
is_value1			=	ls_empty_string
is_value2			=	ls_empty_string
is_sql				=	''
//	01/15/01	GaryR	Track 2558d
//is_revenue_code	=	''

// Initialize the 'set' data
is_set_col_name		=	''
is_set_tbl_type		=	''
is_set_main_tbl		=	''
is_set_tbl_rel			=	''
ii_set_num_of_fields	=	0

// Initialize the timeframe data
is_timeframe_main_tbl_1	=	''
is_timeframe_main_tbl_2	=	''
is_timeframe_tbl_rel_1	=	''
is_timeframe_tbl_rel_2	=	''

// Initialize the unique key data
is_i_columns		=	ls_empty_string
is_j_columns		=	ls_empty_string

// Initialize the temp table data
is_temp_table		=	''

// Initialize the structures
istr_from_tables			=	lstr_from_tables
istr_select_cols_not		=	lstr_select_cols_not
istr_tables					=	lstr_tables

// Reset any previously retrieved data in ids_report_cols
IF	IsValid (ids_report_cols)	THEN
	//	01/14/01	GaryR	Track 2556d - Begin
	IF ib_reset_report_cols THEN ids_report_cols.Reset()
	ib_reset_report_cols = TRUE
	//	01/14/01	GaryR	Track 2556d - End
END IF



end subroutine

public function integer uf_load_selected_tables ();//*********************************************************************************
// Script Name:	ue_load_selected_tables
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	Get the list of unique invoice types from the 
//						selected columns (dw_selected) and load it into istr_from_tables[].
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	02/22/02	FDG	Track 2832d. If you find istr_from_tables[], set select_seq = 1 so
//						the columns get included in the 'Select clause'
//
//*********************************************************************************

Boolean	lb_found,						&
			lb_dep_filter

Constant Integer	lci_max_tables 		= 	14
Constant Integer	lci_too_many_tables	=	4

Integer	li_upper,						&
			li_upper2,						&
			li_rc,							&
			li_idx,							&
			li_found_idx
			
Long		ll_row,							&
			ll_rowcount

String	ls_col_name,					&
			ls_tbl_type,					&
			ls_main_tbl,					&
			ls_tbl_rel

// Get the list of unique invoice types from the selected columns (dw_selected)

ll_rowcount		=	idw_selected.RowCount()
li_upper2		=	UpperBound (is_subset_tbl_type)

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	idw_selected.object.elem_name [ll_row]
	ls_tbl_type		=	idw_selected.object.elem_tbl_type [ll_row]
	lb_found		=	FALSE
	li_upper		=	UpperBound (istr_from_tables)
	// Determine if this tbl type has already been added to istr_from_tables
	FOR	li_idx	=	1	TO	li_upper
		IF	ls_tbl_type		=	istr_from_tables[li_idx].tbl_type	THEN
			// Found in istr_from_tables
			lb_found			=	TRUE
			li_found_idx	=	li_idx		// FDG 02/22/02
			Exit
		END IF
	NEXT
	IF	lb_found		=	FALSE		THEN
		// tbl_type not found.  Add it to the list of unique table types.
		// First, determine if its a main or dependent table.  is_subset_tbl_type[]
		//	has the list of main tables.
		ls_tbl_rel	=	'D'
		FOR	li_idx	=	1	TO	li_upper2
			IF	ls_tbl_type	=	is_subset_tbl_type [li_idx]	THEN
				// This is a main table
				ls_main_tbl	=	ls_tbl_type
				ls_tbl_rel	=	'M'
				Exit
			END IF
		NEXT
		IF	ls_tbl_rel	=	'D'		THEN
			// This is a dependent table.  Get its main table.
			ls_main_tbl		=	This.uf_get_main_tbl (ls_tbl_type, ls_col_name)
			IF	Lower (ls_main_tbl)	=	'error'		THEN
				Return	-1
			END IF
		END IF
		istr_from_tables[li_upper + 1].tbl_type	=	ls_tbl_type
		istr_from_tables[li_upper + 1].tbl_rel		=	ls_tbl_rel
		istr_from_tables[li_upper + 1].main_tbl	=	ls_main_tbl
		// Make sure ue_pattern_sql calls ue_pattern_select since the selected
		//	tbl_type is not included in the criteria.
		istr_from_tables[li_upper + 1].select_seq	=	1
	ELSE
		// FDG 02/22/02
		// Found the tbl_type.  Make sure these columns are included in the Select
		istr_from_tables[li_found_idx].select_seq	=	1
	END IF									//	lb_found	=	FALSE
NEXT											// FOR ll_row	=	1	TO	ll_rowcount


Return	1

end function

public function string uf_select1_keys (integer ai_index);//*********************************************************************************
// Script Name:	uf_select1_keys
//
//	Arguments:		ai_index - Index from istr_from_tables
//
// Returns:			String - SQL string
//
//	Description:	This script gets all columns that comprise of the unique key,
//						converts the column to a string (if necessary), and creates
//						a 'Select' portion.  For example, if table type C1 has a
//						unique key of ICN and ICN_LINE_NO, the resulting Select string
//						would be: 
//							a.ICN '@15001 ICN', a.ICN_LINE_NO '@15001 Line No'
//						The @1500' portion will be converted to C1.  As a result,
//						the SQL will be:
//							a.ICN 'C11 ICN', a.ICN_LINE_NO 'C11 Line No',
//
//	Note:				Prefix is not required.  As a result, this script can return:
//							ICN 'C11 ICN', ICN_LINE_NO 'C11 Line No',
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
// JasonS 09/03/02	Track 2982d  Dictionarize the labels, don't use field alias'
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount,			&
			ll_ids_rowcount,		&
			ll_new_row

String	ls_prefix,				&
			ls_inv_type,			&
			ls_select,				&
			ls_col_name,			&
			ls_alias,				&
			ls_col_label
			
// Edit the input
IF	IsNull (ai_index)				&
OR	ai_index	=	0					THEN
	Return	''
END IF

ls_prefix	=	istr_from_tables[ai_index].prefix
ls_inv_type	=	istr_from_tables[ai_index].tbl_type

// Edit the prefix to append '.'
ls_prefix	=	This.uf_create_sql_prefix(ls_prefix)

// Get the column name and label from ids_index_columns

ll_rowcount	=	istr_from_tables[ai_index].ids_index_columns.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	istr_from_tables[ai_index].ids_index_columns.object.elem_name [ll_row]
	ls_col_label	=	istr_from_tables[ai_index].ids_index_columns.object.elem_desc [ll_row]
	ls_alias			=	ls_inv_type	+	String(ai_index, '0')	+	" "	+	ls_col_label
	// JasonS 09/03/02 Begin - Track 2982d
	//ls_select		=	ls_select	+	ls_prefix	+	ls_col_name	+	' "'	+	&
	//						ls_alias	+	'",'
	ls_select		=	ls_select	+	ls_prefix	+	ls_col_name	+ ','
   // JasonS 09/03/02 End - Track 2982d							
	// Insert this data into ids_report_cols.  When performing a 'UNION' in the 'Select',
	//	rows won't be added to ids_report_cols
	IF	ib_report_cols		THEN
		ll_new_row		=	ids_report_cols.InsertRow(0)
		ids_report_cols.object.tbl_type [ll_new_row]		=	ls_inv_type
		ids_report_cols.object.col_name [ll_new_row]		=	ls_col_name
		ids_report_cols.object.alias_name [ll_new_row]	=	ls_alias
		ids_report_cols.object.query_pos [ll_new_row]	=	ll_new_row
		ids_report_cols.object.key_ind [ll_new_row]		=	'Y'
		ids_report_cols.object.delete_ind [ll_new_row]	=	'N'
	END IF
NEXT

Return	ls_select
end function

public function string uf_select2_keys (integer ai_index);//*********************************************************************************
// Script Name:	uf_select2_keys
//
//	Arguments:		ai_index - Index from istr_from_tables
//
// Returns:			String - SQL string
//
//	Description:	This script gets all columns that comprise of the unique key,
//						converts the column to a string (if necessary), and creates
//						a 'Select' portion.  For example, if table type C1 has a
//						unique key of ICN and ICN_LINE_NO, the resulting Select string
//						would be: 
//							a.ICN, a.ICN_LINE_NO,
//
//	Note:				Prefix is not required.  As a result, this script can return:
//							ICN, ICN_LINE_NO,
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	01/12/01	GaryR	Stars 4.7	DataBase Port - Empty String in SQL
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount,			&
			ll_ids_rowcount,		&
			ll_new_row

Integer	li_rc

String	ls_prefix,				&
			ls_inv_type,			&
			ls_select,				&
			ls_col_name,			&
			ls_col_label,			&
			ls_empty
			
// Edit the input
IF	IsNull (ai_index)				&
OR	ai_index	=	0					THEN
	Return	''
END IF

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ls_prefix	=	istr_from_tables[ai_index].prefix
ls_inv_type	=	istr_from_tables[ai_index].tbl_type

// Edit the prefix to append '.'
ls_prefix	=	This.uf_create_sql_prefix(ls_prefix)

// Get the column name and label from ids_index_columns

ll_rowcount	=	istr_from_tables[ai_index].ids_index_columns.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_col_name		=	istr_from_tables[ai_index].ids_index_columns.object.elem_name [ll_row]
	ls_col_label	=	istr_from_tables[ai_index].ids_index_columns.object.elem_desc [ll_row]
	ls_select		=	ls_select	+	ls_prefix	+	ls_col_name	+	","
	// Insert this data into ids_report_cols.  When performing a 'UNION' in the 'Select',
	//	rows won't be added to ids_report_cols
	IF	ib_report_cols		THEN
		//	01/12/01	GaryR	Stars 4.7	DataBase Port		// FDG 04/16/01
		IF Trim( ls_col_label ) = "" THEN ls_col_label = ls_empty
		ll_new_row		=	ids_report_cols.InsertRow(0)
		ids_report_cols.object.tbl_type [ll_new_row]		=	ls_inv_type
		ids_report_cols.object.col_name [ll_new_row]		=	ls_col_name
		ids_report_cols.object.alias_name [ll_new_row]	=	ls_col_label
		ids_report_cols.object.query_pos [ll_new_row]	=	ll_new_row
		ids_report_cols.object.key_ind [ll_new_row]		=	'Y'
		ids_report_cols.object.delete_ind [ll_new_row]	=	'N'
	END IF
NEXT

Return	ls_select
end function

public function integer uf_edit_report_cols (boolean ab_switch);//*********************************************************************************
// Script Name:	uf_edit_report_cols
//
//	Arguments:		Boolean - ab_switch
//							True = Replace labels in report.
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	Loop thru each row in ids_report_cols and edit the alias.
//						Set the label to idw_report from the dictionary.
//						The open server code cannot handle non-alphanumeric columns.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//
//	06/20/00	FDG	Track 2930c (4.5 SP1).  Get the tbl_type and index and append
//						it to the alias.
//	01/10/03	GaryR	Track 3405d	Append the prefix to report columns
//
//*********************************************************************************

Long		ll_row,					&
			ll_rowcount

String	ls_alias,				&
			ls_col_name,			&
			ls_tbl_type,			&
			ls_modify,				&
			ls_dbname,				&
			ls_prefix

Integer	li_query_pos,			&
			li_pos,					&
			li_index

n_cst_string	lnv_string			// Autoinstantiated

ll_rowcount		=	ids_report_cols.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_alias		=	ids_report_cols.object.alias_name [ll_row]
	ls_col_name	=	ids_report_cols.object.col_name [ll_row]
	ls_tbl_type	=	ids_report_cols.object.tbl_type [ll_row]
	li_query_pos =	ids_report_cols.object.query_pos [ll_row]
	li_index		=	This.uf_get_tbl_type_index (ls_tbl_type)		// FDG 06/20/00
	IF	IsNull (ls_alias)				&
	OR	Trim (ls_alias)	=	''		THEN
		// Get the alias from dictionary (Patterns 17 & 20 & filter_pat).  Since no alias exist,
		//	then the column header on the report must be set.
		ls_alias		=	This.uf_get_col_desc (ls_tbl_type, ls_col_name)
		//	FDG 06/20/00 - Append tbl_type to the alias for filter_pat
		IF	is_pattern_id	=	ics_filter_pat		THEN
			ls_alias		=	ls_tbl_type	+	String(li_index)	+	' '	+	ls_alias
		END IF
		ls_alias		=	lnv_string.of_WordCap (ls_alias)
	END IF
	ls_alias		=	lnv_string.of_ReplaceNonAlphaNum (ls_alias)
	ids_report_cols.object.alias_name [ll_row]	=	ls_alias
	
	IF ab_switch THEN
		// Get the name and the dbname of column from the datawindow 
		ls_dbname 	=	idw_report.Describe( "#" + String( li_query_pos ) + ".dbname" )
		ls_col_name	=	idw_report.Describe( "#" + String( li_query_pos ) + ".name" )
		
		// Strip off table name if necessary
		li_pos =	pos(ls_dbname, '.')
		IF li_pos > 0 THEN ls_dbname 	= 	Mid( ls_dbname, li_pos + 1 )

		IF Upper( ls_dbname ) <> Upper( ls_col_name ) &
		AND Match( Right( ls_col_name, 2 ), "^_[0-9]$" ) THEN
			ls_prefix = "_t" + Right( ls_col_name, 2 ) + "_t"
		ELSE
			ls_prefix = "_t"
		END IF
		
		ls_modify += ls_dbname	+	ls_prefix + ".text='"	+	ls_alias	+	"' "
	END IF
NEXT

ls_modify = Trim( ls_modify )
IF ls_modify <> "" THEN	idw_report.Modify( ls_modify )

Return	1
end function

public function string uf_where_claim (string as_claim_ind, integer ai_idx1, integer ai_idx2);//*********************************************************************************
// Script Name:	uf_where_claim
//
//	Arguments:		1.	as_claim_ind - A=Any, S=Same, D=Different
//						2.	ai_idx1 - 1st occurrence in istr_from_table[]
//						3.	ai_idx2 - 2nd occurrence in istr_from_table[]
//
// Returns:			String - The where clause for claim_ind
//						Empty = error
//
//	Description:	Compute the Where clause for claim_ind.  The final result
//						should be the following:
//						Any: ((A.ICN = B.ICN AND A.ICN_LINE_NO > B.ICN_LINE_NO) OR A.ICN <> B.ICN)
//						Same: (A.ICN = B.ICN AND A.ICN_LINE_NO > B.ICN_LINE_NO)
//						Different: A.ICN <> B.ICN
//
//	Notes:			1.	ai_idx1 and ai_idx2 should be different.
//						2.	When comparing claims, the combination of ICN and 
//							ICN_LINE_NO can't match because you shouldn't compare 
//							against yourself.  Take the following example for ANY claim:
//								Row#	ICN	Line# (a)		ICN	Line# (b)
//								----	---	---------		---	---------
//								  1	123		1				123		1
//								  2	123		2				123		2
//								  3	456		1				456		1
//							In this example, for ANY claim, row #1 in table a will match
//							row #2 in table b.  Since we already have a match we don't
//							want row #2 in table a will match row #1 in table b.  Setting
//							'A.ICN_LINE_NO > B.ICN_LINE_NO' (instead of 
//							'A.ICN_LINE_NO <> B.ICN_LINE_NO) will prevent this situation
//							from occurring.  However (track 2909), if performing set processing,
//							the criteria in the 'A' table will be different than the criteria
//							in the 'B' table.  As a result, '<>' must be used instead of '>'.
//
//						3.	When the unique key changes are made, fill in the
//							unique key columns into ls_column[]
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	08/01/01	FDG	Track 3547 (Stars 4.6 SP2).  Add parenthesis around Where clause 
//						for same select because of the possibility of having 'OR' in 
//						the Where clause.
//	03/20/02	FDG	Track 2909d.  When dealing with sets in the criteria, the criteria
//						in one set can be different than criteria in the other set.  As a 
//						result, 'A.ICN_LINE_NO <> B.ICN_LINE_NO' must be used instead of
//						'A.ICN_LINE_NO > B.ICN_LINE_NO' when processing sets.
//	04/03/02	FDG	Track 2964d (5.0 SP1).  If the unique key only comprises of 1 column,
//						then the Where clause must contain A.ICN <> B.ICN to prevent rows
//						from being compared against itself.
//	12/11/02	GaryR	Track 4703c	Validate operand for set criteria
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//	04/27/07	GaryR	Track 4885	Add logic for multiple keys/different claims
//	05/18/07	GaryR	Track 5027	Handle multiple values and revenue criteria
//	05/23/07	GaryR	Track 4926	Set proper operand on claims when same revenue criteria
//	05/30/07	GaryR	Track 5041	Set proper operand on claims when any revenue criteria
//
//*********************************************************************************

Integer	li_claims,						&
			li_lines

Long		ll_rowcount,					&
			ll_row,							&
			ll_ctr

String	ls_any_select,					&
			ls_different_select,			&
			ls_key_type,					&
			ls_rel_op,						&
			ls_logic_op,					&			
			ls_same_select,				&
			ls_column

This.uf_filter_stars_rel( istr_from_tables[ai_idx1].tbl_type )

// FDG 04/03/02 - If processing a set, use '<>', otherwise use '>'
IF	ii_set_num_of_fields	>	0		THEN
	ls_rel_op	=	uf_get_set_operand( "M" )		//	12/11/02	GaryR	Track 4703c
ELSE
	IF ib_rev_crit THEN
		//	Revenue Criteria
		ls_rel_op	=	' <> '
	ELSE
		ls_rel_op	=	' > '
	END IF
END IF

ll_rowcount			=	istr_from_tables[ai_idx1].ids_claim_keys.RowCount()
FOR ll_row	=	1	TO	ll_rowcount
	ls_column =	istr_from_tables[ai_idx1].ids_claim_keys.object.col_name [ll_row]
	ls_key_type = istr_from_tables[ai_idx1].ids_claim_keys.object.key_type [ll_row]
	
	CHOOSE CASE Upper( ls_key_type )
		CASE "C"		//	Compute the claim keys
			// Compute the same select.  When computing this, 
			//	you cannot compare the row against itself.
			// Same select example: (A.ICN = B.ICN AND A.ICN_LINE_NO > B.ICN_LINE_NO)
			ls_same_select += " AND " + istr_from_tables[ai_idx1].prefix + "." + &
					ls_column + " = "	+ istr_from_tables[ai_idx2].prefix + "." + ls_column

			//	If more then one "C" claim line, add previuos lines to different select
			//	Example (A.ICN > B.ICN) OR (A.ICN = B.ICN AND A.ICN_VER > B.ICN_VER)
			IF as_claim_ind <> 'S' THEN
				IF ll_row = 1 THEN
					// Different select example: A.ICN <> B.ICN		
					// FDG 08/01/01 - Add parenthesis
					ls_different_select += " (" + istr_from_tables[ai_idx1].prefix + "." + &
							ls_column + ls_rel_op + istr_from_tables[ai_idx2].prefix + "." + ls_column + ")"
				ELSE
					//	Reset the logical operator to OR
					ls_logic_op = " OR ("
					FOR ll_ctr = 1 TO ll_row
						ls_column =	istr_from_tables[ai_idx1].ids_claim_keys.object.col_name [ll_ctr]
						IF ll_ctr = ll_row THEN
							//	The last key is >
							ls_different_select += ls_logic_op + istr_from_tables[ai_idx1].prefix + "." + &
								ls_column + ls_rel_op + istr_from_tables[ai_idx2].prefix + "." + ls_column + ")"
						ELSE
							//	The initial keys are =
							ls_different_select += ls_logic_op + istr_from_tables[ai_idx1].prefix + "." + &
								ls_column + " = " + istr_from_tables[ai_idx2].prefix + "." + ls_column
						END IF
						//	Reset logical operator to AND
						ls_logic_op = " AND "
					NEXT
				END IF
			END IF
					
			li_claims ++
		CASE "L"
			//	Now add lines if any for same only. "L"
			ls_same_select += " AND " + istr_from_tables[ai_idx1].prefix + "." + &
					ls_column + ls_rel_op	+ istr_from_tables[ai_idx2].prefix + "." + ls_column
			li_lines ++
		CASE ELSE
			IF IsNull( ls_key_type ) THEN ls_key_type = "NULL"
			MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_where_claim '	+	&
							'invalid claim key: ' + ls_key_type )
			Return ""
	END CHOOSE
NEXT

// Remove the leading ' AND '
IF	li_claims	>	0		THEN
	ls_same_select = Mid ( ls_same_select, 5 )
ELSE
	MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_where_claim '	+	&
							'no claim keys found.')
	Return ""
END IF

// FDG 08/01/01 - Add parenthesis around Where clause because of
//						the possibility of having 'OR' in the Where clause.
ls_same_select			=	'('	+	ls_same_select	+	')'
ls_different_select	=	'('	+	ls_different_select	+	')'

// Append the Same select to ' OR A.ICN <> B.ICN to compute the 'Any' select
// Example Any select: ((A.ICN = B.ICN AND A.ICN_LINE_NO > B.ICN_LINE_NO) OR A.ICN <> B.ICN)
IF	li_lines		>	0 OR ib_rev_crit THEN
	// The unique key has lines or revenue criteria
	ls_any_select	=	'('	+	ls_same_select	+	' OR '	+	&
							ls_different_select	+	')'
ELSE
	// The unique key contains no claim lines.  There is no comparison.
	// FDG 04/03/02 - When this occurs, ls_any_select = ls_different_select in order
	//	to prevent rows from being compared against itself.
	ls_any_select	=	ls_different_select
END IF

CHOOSE CASE	as_claim_ind
	CASE	'A'
		// Any claim
		Return ls_any_select
	CASE	'S'
		// Same claim
		Return ls_same_select
	CASE	'D'
		// Different claim
		Return ls_different_select
	CASE ELSE
		IF IsNull( as_claim_ind ) THEN as_claim_ind = "NULL"
		MessageBox ('Application Error', 'In u_nvo_pattern_sql.uf_where_claim '	+	&
							'invalid claim comparison indicator: ' + as_claim_ind )
		Return ""
END CHOOSE
end function

public function string uf_where_rev_claim (integer ai_idx1, integer ai_idx2);//*********************************************************************************
// Script Name:	uf_where_rev_claim
//
//	Arguments:		1.	ai_idx1 - Rev occurrence in istr_from_table[]
//						2.	ai_idx2 - Main occurrence in istr_from_table[]
//
// Returns:			String - The where clause for revenue join
//
//
//*********************************************************************************
//
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//
//*********************************************************************************

String	ls_select, &
			ls_column, &
			ls_key_type
			
Integer	li_cnt, li_row

//	Get the main claim keys to join
li_cnt = istr_from_tables[ai_idx2].ids_claim_keys.RowCount()
FOR li_row	=	1	TO	li_cnt
	ls_column =	istr_from_tables[ai_idx2].ids_claim_keys.object.col_name [li_row]
	ls_key_type = istr_from_tables[ai_idx2].ids_claim_keys.object.key_type [li_row]
	
	IF Upper( ls_key_type ) = "C"	THEN
		ls_select += " AND " + istr_from_tables[ai_idx1].prefix + "." + &
					ls_column + " = "	+ istr_from_tables[ai_idx2].prefix + "." + ls_column
	END IF
NEXT

// Trim leading " AND "
Return Mid( ls_select, 5 )
end function

public function string uf_where_rev_line (integer ai_idx1, integer ai_idx2);//*********************************************************************************
// Script Name:	uf_where_rev_line
//
//	Arguments:		1.	ai_idx1 - First Rev occurrence in istr_from_table[]
//						2.	ai_idx2 - Second Rev occurrence in istr_from_table[]
//
// Returns:			String - The where clause for revenue line join
//
//
//*********************************************************************************
//
//	04/13/07	GaryR	Track 4885	Identify unique claim based on datasource settings
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//	05/18/07	GaryR	Track 5027	Handle multiple values and revenue criteria
//
//*********************************************************************************

Integer 	li_cnt, li_row
String 	ls_col_name, ls_key_type, ls_rev_where, ls_rel_op

ls_rel_op	=	uf_get_set_operand( "R" )

li_cnt = istr_from_tables[ai_idx1].ids_claim_keys.RowCount()
FOR li_row	=	1	TO	li_cnt
	ls_col_name =	istr_from_tables[ai_idx1].ids_claim_keys.object.col_name [li_row]
	ls_key_type = istr_from_tables[ai_idx1].ids_claim_keys.object.key_type [li_row]
	
	IF Upper( ls_key_type ) = "L"	THEN
		ls_rev_where += " AND " + istr_from_tables[ai_idx1].prefix + &
		"." + ls_col_name + ls_rel_op	+ &
		istr_from_tables[ai_idx2].prefix + "." + ls_col_name
	END IF
NEXT

// Trim leading " AND "
IF Trim( ls_rev_where ) <> "" THEN ls_rev_where = Mid( ls_rev_where, 5 )
Return ls_rev_where
end function

public function string uf_get_set_operand (string as_clm_type);////////////////////////////////////////////////////////////////////
//
//	Argument:	String as_clm_type - Type of Claim (M=Main, R=Revenue)
//
//	This method will determine if set criteria is the same.
//	If it is, then operand is > else operand is <>
//
//	For multiple values check if same regardless of order.
//	If same, then for "M" return <> for "R" return >
//
////////////////////////////////////////////////////////////////////
//
//	12/11/02	GaryR	Track 4703c	Validate operand for set criteria
//	04/23/07	GaryR	Track 4885	Add support for identity columns in numbered patterns
//	05/18/07	GaryR	Track 5027	Handle multiple values and revenue criteria
//
////////////////////////////////////////////////////////////////////

CONSTANT String	NOT_EQUALS = " <> "
CONSTANT String	GREATER_THAN = " > "
String	ls_set1, ls_set2, ls_set1_list[], ls_set2_list[]
integer	li_pos
Boolean	lb_multi, lb_same
n_cst_string	lnv_string

IF ib_same_crit THEN Return GREATER_THAN		//	Same crit in numbered Pattern
IF UpperBound( is_where ) < 2 THEN Return NOT_EQUALS

ls_set1 = Upper( is_where[1] )
ls_set2 = Upper( is_where[2] )

li_pos = Pos( ls_set1, "." )
IF li_pos > 0 THEN ls_set1 = Mid( ls_set1, li_pos + 1 )

li_pos = Pos( ls_set2, "." )
IF li_pos > 0 THEN ls_set2 = Mid( ls_set2, li_pos + 1 )

//	Check multiple values in both sets
li_pos = Pos( ls_set1, "," )
IF li_pos > 0 THEN
	//	Get values between parenthesis
	li_pos = Pos( ls_set1, "(" )
	IF li_pos > 0 THEN ls_set1 = Mid( ls_set1, li_pos + 1 )
	li_pos = Pos( ls_set1, ")" )
	IF li_pos > 0 THEN ls_set1 = Left( ls_set1, li_pos - 1 )
	ls_set1 = Trim( ls_set1	)
	
	//	Convert to array
	ls_set1_list = lnv_string.of_stringtoarray( ls_set1, "," )
	lnv_string.of_sortarray( ls_set1_list, TRUE )
	lb_multi = TRUE
END IF

li_pos = Pos( ls_set2, "," )
IF li_pos > 0 THEN
	//	Get values between parenthesis
	li_pos = Pos( ls_set2, "(" )
	IF li_pos > 0 THEN ls_set2 = Mid( ls_set2, li_pos + 1 )
	li_pos = Pos( ls_set2, ")" )
	IF li_pos > 0 THEN ls_set2 = Left( ls_set2, li_pos - 1 )
	ls_set2 = Trim( ls_set2	)
	
	//	Convert to array
	ls_set2_list = lnv_string.of_stringtoarray( ls_set2, "," )
	lnv_string.of_sortarray( ls_set2_list, TRUE )
	lb_multi = TRUE
END IF

//	Check if sets are same
IF lb_multi THEN
	// Convert to array if single value
	IF UpperBound( ls_set1_list ) = 0 THEN ls_set1_list[1] = ls_set1
	IF UpperBound( ls_set2_list ) = 0 THEN ls_set2_list[1] = ls_set2
	
	lb_same = ls_set1_list = ls_set2_list
ELSE
	lb_same = ls_set1 = ls_set2
END IF

IF lb_same THEN
	IF ib_rev_crit THEN
		//	If same, then for "M" return <> for "R" return >
		IF as_clm_type = "R" THEN Return GREATER_THAN
	ELSE
		Return GREATER_THAN
	END IF
END IF

Return NOT_EQUALS
end function

on u_nvo_pattern_sql.create
call super::create
end on

on u_nvo_pattern_sql.destroy
call super::destroy
end on

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	Constructor event
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Create any instance objects required and initialize the
//						data.
//
//*********************************************************************************
//	
// 04/01/00 FDG	Stars 4.5	Created
//	FDG	12/21/01	Track 2497.  Declare n_cst_case as a local to remove memory leaks.
//
//*********************************************************************************

Long		ll_rowcount,		&
			ll_row

String	ls_elem_desc

// Create the NVO used to edit case security
//inv_case	=	CREATE	n_cst_case		// FDG 12/21/01

// Initialize the data
This.uf_clear_data()

// Create and retrieve the datastore to get all dependent tables from
//	stars_rel
ids_dependent_tables	=	CREATE	n_ds
ids_dependent_tables.DataObject	=	'd_dependent_tables'
ids_dependent_tables.SetTransObject (Stars2ca)
ll_rowcount	=	ids_dependent_tables.Retrieve()

// Create the NVO to get the revenue code
inv_revenue	=	CREATE	n_cst_revenue

// Create the datastore to get the unique key column descriptions.
//	The originally read data from idw_available will be copied
//	to this datastore.
ids_dictionary			=	CREATE	n_ds
ids_dictionary.DataObject	=	'd_available_pattern'
ids_dictionary.SetTransObject (Stars2ca)

// Create the datastore to tell the middleware where the columns are
// in the report.
ids_report_cols		=	CREATE	n_ds
ids_report_cols.DataObject	=	'd_report_cols'
ids_report_cols.SetTransObject (Stars2ca)

// Create the datastore to retrieve the columns required for a
// numbered pattern.
ids_patt_columns		=	CREATE	n_ds
ids_patt_columns.DataObject	=	'd_patt_columns_template'
ids_patt_columns.SetTransObject (Stars2ca)


end event

event destructor;call super::destructor;//*********************************************************************************
// Script Name:	Destructor event
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
//	FDG	12/21/01	Track 2497.  Declare n_cst_case as a local to remove memory leaks.
//
//*********************************************************************************

// FDG 12/21/01
//IF	IsValid (inv_case)		THEN
//	Destroy	inv_case
//END IF

IF	IsValid (inv_revenue)		THEN
	Destroy	inv_revenue
END IF

IF	IsValid (ids_dependent_tables)	THEN
	Destroy	ids_dependent_tables
END IF

IF	IsValid (ids_dictionary)	THEN
	Destroy	ids_dictionary
END IF

IF	IsValid (ids_report_cols)	THEN
	Destroy	ids_report_cols
END IF

IF	IsValid (ids_patt_columns)	THEN
	Destroy	ids_patt_columns
END IF

end event

