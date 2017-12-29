$PBExportHeader$u_nvo_create_sql.sru
$PBExportComments$(inherited from n_base) <logic>
forward
global type u_nvo_create_sql from n_base
end type
end forward

global type u_nvo_create_sql from n_base
event ue_add_order_by ( ref string as_order_by,  ref string as_where[] )
event type string ue_create_from ( string as_inv_type,  integer ai_tbl_no,  string as_join[],  n_cst_tableinfo_attrib anv_base,  n_cst_tableinfo_attrib anv_addtl )
event type integer ue_create_sql ( )
event type integer ue_create_where ( ref boolean ab_add_payment_date,  ref string as_where[] )
event type integer ue_create_where_add_payment_date ( ref string as_where,  string as_inv_type,  integer ai_row_num )
event type integer ue_create_where_check_indexes ( )
event type integer ue_create_where_ml_subset_add_dependent ( ref string as_where[],  ref string as_inv_type,  ref string as_join[] )
event ue_create_where_subset_view ( ref string as_where[] )
event type string ue_create_order_by ( )
event type integer ue_subsetting_fill_step_info ( datetime ad_from_date,  datetime ad_thru_date,  string as_inv_type,  string as_add_inv_type,  integer ai_step )
event ue_replace_mc_where ( string as_inv_type,  ref string as_new_where[] )
event type string ue_add_key_cols_to_select ( ref string as_select,  ref integer ai_rowcount,  string as_tbl_type )
event type integer ue_get_paid_date_values ( ref string as_value,  ref string as_operator )
event type any ue_format_where_criteria ( string as_type,  boolean ab_add_payment_date,  ref string as_where[],  ref sx_criteria astr_criteria[] )
event type integer ue_format_where_criteria_add_clauses ( string as_type,  ref string as_where[],  ref sx_criteria astr_criteria[] )
event type integer ue_check_filter_data_type ( ref string as_data_type,  string as_filter_id )
event type integer ue_format_where_criteria_super_prov ( ref sx_criteria astr_criteria[],  ref string as_where[],  ref string as_exp2,  string as_logic_op,  boolean ab_subsetting,  boolean ab_npi )
event type string ue_create_select ( string as_inv_type,  ref string as_join[] )
end type
global u_nvo_create_sql u_nvo_create_sql

type variables
/*Source Tab Controls*/
u_dw   idw_source

/*Search Tab Controls*/
u_dw                    idw_criteria

/*Report Tab Controls*/
u_dw                      idw_selected

/*Uo_query Controls*/
//////uo_Query iuo_Query

u_display_period iuo_period

// Used to create the sql statement in event ue_create_sql
//n_ds							ids_ros_dir			// FDG 03/12/01 - Stars 4.7 - No longer used.

Constant string   IC_TEMP_ALIAS = "TMP"

sx_break_info				istr_break_info
sx_drilldown  				istr_drilldown
sx_subsetting_info		istr_subsetting_info
sx_prov_query_structure	istr_prov_query
sx_prov_query_structure	istr_npi_prov_query	//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider

sx_keys						istr_key_columns

// SQL data
sx_sql_statement_container	istr_sql_container
sx_sql_statement			istr_sql_statement[]

// Filter data
sx_filter_info				isx_filter_info[]


string is_subset_id, is_source_type, is_source_subset_id
string is_data_type, is_inv_type
string is_drilldown_previous_temp_table

integer ii_sub_filter_count, ii_filter_count

boolean ib_drilldown, ib_subsetting, ib_count

// Is this an ancillary invoice type
Boolean		ib_ancillary_inv_type

//NLG 10-27-99 ts2463c 
boolean ib_recurring_pdq
string is_pd_opt_desc
integer ii_run_frequency

//FDG 07/17/00 (Track 2465c) - Fastquery data
String		is_fastquery_ind
Long			il_fastquery_rows

//	FDG	11/21/00 - Outer join variables
Boolean		ib_outer_join
String		is_outer_table1[],			&
				is_outer_column1[],			&
				is_outer_alias1[],			&
				is_outer_table2[],			&
				is_outer_column2[],			&
				is_outer_alias2[],			&
				is_outer_from[]

// FDG 03/13/01 - Table names stored here for future use
n_cst_tableinfo_attrib	inv_base,			&
								inv_addtl

// FDG 08/02/01 (Track ????) - Save columns in select
String		is_select_column[]

//	04/24/02	GaryR	Track 2552d	Predefined Report (PDR)
Boolean		ib_is_pdr_mode

// 3909d - Set to TRUE if Sybase + views + additional data_source
boolean		ib_use_datastore_count

// 3939d - Set to TRUE if LOJ because of OR clause
boolean		ib_or_loj

//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
Integer	ii_prefilter_rows[]
String	is_prefilter_bool[]
end variables

forward prototypes
public subroutine uf_set_source_dw_source (ref u_dw adw_source)
public subroutine uf_set_search_dw_criteria (ref u_dw adw_criteria)
public subroutine uf_set_report_dw_selected (ref u_dw adw_selected)
public subroutine uf_set_istr_drilldown (ref sx_drilldown astr_drilldown)
public subroutine uf_set_subset_id (ref string as_subset_id)
public subroutine uf_set_data_type (ref string as_data_type)
public subroutine uf_set_ib_drilldown (ref boolean ab_drilldown)
public subroutine uf_set_source_type (ref string as_source_type)
public subroutine uf_set_source_subset_id (ref string as_source_subset_id)
public subroutine uf_set_inv_type (ref string as_inv_type)
public subroutine uf_set_sub_filter_count (ref integer ai_sub_filter_count)
public subroutine uf_set_filter_count (ref integer ai_filter_count)
public subroutine uf_set_ib_subsetting (ref boolean ab_subsetting)
public subroutine uf_set_istr_subsetting_info (ref sx_subsetting_info astr_subsetting_info)
public subroutine uf_set_ib_count (ref boolean ab_count)
public subroutine uf_set_iuo_period (ref u_display_period auo_period)
public subroutine uf_set_drilldown_previous_temp_table (ref string as_drilldown_previous_temp_table)
public subroutine uf_set_istr_break_info (ref sx_break_info astr_break_info)
public subroutine uf_set_istr_prov_query (ref sx_prov_query_structure astr_prov_query)
public subroutine uf_set_istr_sql_statement (ref sx_sql_statement_container astr_sql_container)
public subroutine uf_set_istr_key_columns (ref sx_keys astr_key_columns)
public subroutine uf_set_ib_ancillary_inv_type (ref boolean ab_ancillary_inv_type)
public subroutine uf_set_isx_filter_info (ref sx_filter_info_container asx_filter_container)
public function sx_sql_statement_container uf_get_istr_sql_container ()
public function sx_subsetting_info uf_get_istr_subsetting_info ()
public function sx_prov_query_structure uf_get_istr_prov_query ()
public subroutine uf_set_run_frequency (integer ai_run_frequency)
public subroutine uf_set_pd_opt_desc (string as_pd_opt_desc)
public function integer uf_set_ib_recurring_pdq (ref boolean ab_switch)
public subroutine uf_set_fastquery_ind (string as_fastquery_ind)
public subroutine uf_set_fastquery_rows (long al_fastquery_rows)
public function boolean uf_remove_payment_date (string as_date, string as_operator)
public function sx_break_info uf_get_istr_break_info ()
public function n_cst_tableinfo_attrib uf_get_base_tables ()
public function n_cst_tableinfo_attrib uf_get_additional_tables ()
public function sx_select_column uf_get_select_column ()
public function boolean uf_get_is_view (string as_inv_type)
public function boolean uf_get_use_ds_counts ()
public function string uf_get_dummy_col_select (string as_data_type, integer as_index)
public function string uf_get_col_select (string as_elem_type, string as_tbl_type, string as_col_name)
public function string uf_get_criteria (integer ai_index, string as_column)
public function boolean uf_get_is_blank (integer ai_index, string as_object)
public function string uf_get_col_where (string as_expression)
public subroutine uf_add_join (ref string as_join[], string as_inv_type)
public subroutine uf_set_istr_npi_prov_query (ref sx_prov_query_structure astr_prov_query)
public function sx_prov_query_structure uf_get_istr_npi_prov_query ()
end prototypes

event ue_add_order_by;//*********************************************************************************
// Event Name:	U_NVO_Create_Sql.UE_Add_Order_By
//	Arguments:	String	as_order_by
//					String	as_where[]
// Returns:		None 
//
//*********************************************************************************
// 12-10-97 FNC Created      
//*********************************************************************************

/*This event is called from ue_create_sql only if Break with Totals has been 
selected for the report	and this sql is not being used for a count.  This event 
will add the order by to the end of the where clause. */

integer li_count

li_count = upperbound(as_where)
as_where[li_count + 1] = as_order_by

end event

event type string ue_create_from(string as_inv_type, integer ai_tbl_no, string as_join[], n_cst_tableinfo_attrib anv_base, n_cst_tableinfo_attrib anv_addtl);//*********************************************************************************
// Event Name:	u_nvo_create_sql.ue_create_from
//
//	Arguments:	String	as_inv_type
//					Integer	ai_tbl_no
//					String	as_join[]
//					n_cst_tableinfo_attrib	anv_base	-	Contains list of base tables
//					n_cst_tableinfo_attrib	anv_addtl-	Contains list of additional data source tables
//
// Returns:		String - The From statement
//
//*********************************************************************************
// 12-17-97 FNC Created
//*********************************************************************************
// Modifications
//	01-29-98 FNC	Remove drilldown instance variables. Use structure instead
// 					Retrieve the subset database for drilldown since temp table will
//						be on same database as subsets
//						Restructured the way the database variables are filled so that 
//						this code works for drilldown.
//
//	02/03/98	FDG	1.	Call of_check_status() after each embedded SQL.
//						2. When filtering, include rel_type = 'AN'.
//						3. In dw_stars_rel_dict, the table name for rel_type = 'AN'
//							exists in value_a instead of dictionary_elem_name.
// 02/04/98 FNC	If additional datasource has a value but it is drilldown do not 
//						retrieve the table name. Already have it from section at beginning.
// 02/09/98 FNC	If drilldown use istr_drilldown.inv_type to obtain table name
// 02/10/98	FNC	Retrieve ls_sub_db if have a subset id, source is subset or it
//						is drilldown. Previously only retrieved ls_sub_db is source <> 'AN'
// 02/18/98 FNC	Change select for subset database name. Now the entry will be 
//						identified with elem_type = 'SS'
//	03/13/98	FDG	Track 898.  When getting the database name for the filter table,
//						get it from Stars1ca instead of using ls_sub_db
// 03/31/98 FNC	Track 912. If there is a join LS_Tbl_Type is blank if the source
//						is a subset. It is better to use the value in as_join for the alias
//						in the from statement.
//	05/27/98	FDG	Track 1091.  For drilldown, get the invoice type, not the 
//						original invoice type.  This is when the drilldown path <> 'AD'.
//	06/05/98	FDG	Track 1300.  When checking for the subset table, remove the
//						edit for drilldown.
// 06/11/98	FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	06/15/98	FDG	Track ????.  Check ib_ancillary_inv_type instead of 
//						is_source_type because is_source_type is getting reset.
//	08/05/98	FDG	Track 1235, 1248.  If drilldown on dependent ('AD') attempt a
//						a different filter.
// 09/08/98 FNC	Track 1611. Convert fasttrack invoice type into revenue invoice type.
// 09/11/98 FDG	Track 1700.  Can drilldown from PV to C2/CR.  If so, must get the
//						table name for CR.  Only ignore additional data source when
//						drilling down to additional data (istr_drilldown.path = 'AD'.
// 04/13/99 FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
//	07/12/00	FDG	Track 2365c.  Stars 4.5 SP1.  When using a filter, don't join
//						to filter_vals.  Instead, use filter_vals in a sub-select in 
//						the Where clause.
//	11/21/00	FDG	Stars 4.7.  If an outer join was previously specified, then
//						for UDB, create the from clause of the SQL.  This won't apply
//						for ASE and Oracle.
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	03/12/01	FDG	Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
//						Also, for base data, get the table names from the new parms.
// 11/16/01 FNC 	Track 3759 Starcare. Not putting sub_filter_vals table in the 
//						from statement anymore. The filter where is replaced with an inner
//						select in w_prefilter_ub92.
//	01/07/02	FDG	Track 2605d.  When a fasttrack table is selected with a subset, use
//						the main table invoice type to access sub_step_cntl.
//	01/11/02	FDG	Track 2671d.  When a fasttrack table is an additional data source with 
//						a subset, use the main table invoice type to access sub_step_cntl.
//	04/01/02	FDG	Stars 5.1.  Allow for ancillary subsets.
// 07/23/02 MikeF	Track 3495c. Made some substantial changes. Original function is 
//						backed up in ue_create_from_orig.
// 08/20/02 MikeF	Track 3252. Using wrong alias for setting from clause for LOJ 
//	02/25/03	GaryR	Track 3452d	Account for drilldown with subset as base
//	03/17/03	GaryR	Track 3482d	Get main invoice when viewing subset with dependent
//	04/03/03	GaryR	Track 3505d	The subset row has changed in the dictionary
//	02/10/04	GaryR	Track 6453c	Get the last alias in array for dependant table
//	04/02/04	GaryR	Track 6004c	For recurring subsets get table from DB not NVO
// 01/14/06 Jason Track 4493d If LOJ, and more than 2 tables, add the non LOJ tables to from clause
//	02/02/06	GaryR	Track 4638d	Accommodate viewing dependant data in ancillary subsets
//	02/03/06	GaryR	Track 4638d	Resolve base table name with ancillary dependants
//	03/01/06	GaryR	Track	4490	Use proper main invoice type for additional subset drilldown
//	03/10/06	GaryR	Track 4682	Convert FastTrack invoice type to the main header type
//										in subsets with additional datasource
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//*********************************************************************************

/*This event will create the FROM clause (database name .. table name and alias separated
by commas).  It must determine the source and if there are any dependents or filters 
used.  Use the source of dw_source as long as not drilling down to dependents ('AD').
If drilling down to dependents, use the temp table instead. The value in 
is_source_type will determine if the query is going against claims.  If the query is 
against claim table then the source could be either base or subset.  Base will use 
main tables (medc_prof1 if creating report or medc_prof@ if subsetting) and subset 
will use subset tables (sub_medc_{tbl_type}_{subc_id}).  If source is base will use 
as_tbl_no.  If is_subset_id is populated or rb_source on the tabpage_source equals 
"SUBSET" and the invoice types of data type and data source match then the source is 
subset else it is base (is_data_type is set to BASE in losefocus of 
tabpage_source.dw_source). If the add_data_source field is populated on 
tabpage_source, there is a dependent table involved.  Currently only claims have 
dependents but will code for any.  Dependent join must also be added if there are 
table_types in the as_join array.  This array is produced in ue_create_select event. 
It is filled with the table types of all dependents columns selected in an ML 
subset.  (Currently can only be CR, but flexible if this changes) This can only 
happen for a subset view thus will only be joining subset tables (don't need table 
names from stars_rel).

Also must determine if filters are used.  If it is a subset view (is_subset_id <> '') 
must check ii_sub_filter_count else must use ii_filter_count which is set when creating
WHERE.  If it a subset filter must use the sub_filter_vals_{subc_id} table else use 
the filter_vals table.  

Finally, if Drilldown must add temp table to the from clause and if subsetting must 
put temp table name into subset structure.*/

string 	ls_filter,				&
			ls_tbl_name,			&
			ls_subset_id,			&
			ls_sub_db,				&
			ls_filter_db,			&
			ls_base_db,				&
			ls_aux_db,				&
			ls_from[],				&
			ls_string_array[], 	&
			ls_tbl_type,			&
			ls_dep_tbls,			&
			ls_inv_type,			&
			ls_main_table,			&
			ls_rev_table,			&
			ls_inv_types[],		&
			ls_outer_join,			&
			ls_from_statement
			
integer	li_i,						&
			li_count,				&
			li_join_count,			&
			li_j,						&
			li_k,						&
			li_upper,				&
			li_rowcount

Boolean	lb_outer_join
			
n_cst_revenue lnvo_revenue

if istr_drilldown.path <> 'AD' then
	// FDG 05/27/98 begin
	ls_inv_type	=	as_inv_type
	// FDG 05/27/98 end
	ls_filter = "(rel_type = 'GP' or rel_type = 'AN') and id_2 = '" + ls_inv_type +"'"
else
	ls_inv_type = istr_drilldown.inv_type
	if as_inv_type = istr_drilldown.inv_type then
		//Main table drilldown on itself
		ls_filter = "rel_type = 'GP' and id_2 = '" +as_inv_type+"'"
	else
		//Drilldown on a dependent
		ls_filter = "rel_type = 'DP' and id_2 = '" + istr_drilldown.inv_type +"'"
	end if
end if

w_main.dw_stars_rel_dict.SetFilter("")  /* clear out */
w_main.dw_stars_rel_dict.Filter()
w_main.dw_stars_rel_dict.SetFilter(ls_filter)
w_main.dw_stars_rel_dict.Filter()

if w_main.dw_stars_rel_dict.rowcount() < 1 then 
	// FDG 08/05/98 begin
	IF	istr_drilldown.path	=	'AD'	THEN
		// Drilldown on a dependent
		ls_filter = "rel_type = 'DP' and id_2 = '" + istr_drilldown.inv_type +"'"
		w_main.dw_stars_rel_dict.SetFilter("")  /* clear out */
		w_main.dw_stars_rel_dict.Filter()
		w_main.dw_stars_rel_dict.SetFilter(ls_filter)
		w_main.dw_stars_rel_dict.Filter()
	END IF
	if w_main.dw_stars_rel_dict.rowcount() < 1 then 
		messagebox('ERROR','Error retrieving table name in U_NVO_Create_Sql.UE_Create_From')
		return 'ERROR'
	end if
	// FDG 08/05/98 end
end if

ls_tbl_name = w_main.dw_stars_rel_dict.getitemstring(1,'dictionary_elem_name')

IF	Trim (ls_tbl_name)	<	' '		THEN
	ls_tbl_name	=	w_main.dw_stars_rel_dict.getitemstring(1,'value_a')
END IF

//02-18-98 FNC
if trim(is_subset_id) <> '' &
or is_data_type = 'SUBSET' &
or ib_drilldown 					then
	Select db 
	into :ls_sub_db
	From dictionary 
	Where elem_type = 'UT'
	And elem_tbl_type = 'SS'
	Using Stars2ca;
	
	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca, + &
			'Error reading dictionary to retrieve subset database name in U_NVO_Create_Sql.ue_create_from')
		return 'ERROR'
	elseif isnull(ls_sub_db) then
		stars2ca.of_commit()						// FNC 04/13/99
		messagebox('ERROR','The value for DB in the dictionary for Elem Type = "TB" and Elem Name = "SUBSET" is null. Report processing is cancelled')
		return 'ERROR'
	else												// FNC 04/13/99
		stars2ca.of_commit()						// FNC 04/13/99
	end if
	
	//	12/04/00	GaryR	Stars 4.7 DataBase Port
	ls_sub_db = gnv_sql.of_get_database_prefix( ls_sub_db )
end if

//if is_source_type <> 'AN' then											// FDG 06/15/98
IF	ib_ancillary_inv_type	=	FALSE			THEN						// FDG 06/15/98
	if trim(is_subset_id) = '' or is_data_type = 'BASE' then
		// Claims tables
		Select db 
		into :ls_base_db
		From dictionary 
		Where elem_type = 'TB' and 
				elem_tbl_type = Upper( :ls_inv_type ) and
				elem_name = Upper( :ls_tbl_name )
		Using stars2ca;
		
		if stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error reading dictionary to retrieve base database name in U_NVO_Create_Sql.ue_create_from')
			return 'ERROR'
		elseif isnull(ls_base_db) then
			stars2ca.of_commit()						// FNC 04/13/99			
			messagebox('ERROR','The value for DB in the dictionary for Elem Type = "TB" and Elem Name = ' + ls_tbl_name + ' Elem Tbl Type = ' + as_inv_type + ' is null. Report processing is cancelled')
			return 'ERROR'
		else												// FNC 04/13/99
			stars2ca.of_commit()						// FNC 04/13/99			
		end if
		
		//	12/04/00	GaryR	Stars 4.7 DataBase Port
		ls_base_db = gnv_sql.of_get_database_prefix( ls_base_db )
	end if
else 
	// FDG 04/01/02 - Account for ancillary subsets 
	if trim(is_subset_id) = '' or is_data_type = 'BASE' then
		/* non-claim tables */
		Select db 
		into :ls_aux_db
		From dictionary 
		Where elem_type = 'TB' and
				elem_tbl_type = Upper( :ls_inv_type ) and 				
				elem_name = Upper( :ls_tbl_name )
		Using Stars2ca;
			
		if stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca, + &
				'Error reading dictionary to retrieve auxiliary database name in U_NVO_Create_Sql.ue_create_from')
			return 'ERROR'
		elseif isnull(ls_aux_db) then
			stars2ca.of_commit()					// FNC 04/13/99
			messagebox('ERROR','The value for DB in the dictionary for Elem Type = "TB" and Elem Name = ' + ls_tbl_name + ' Elem Tbl Type = ' + as_inv_type + ' is null. Report processing is cancelled')
			return 'ERROR'				
		else											// FNC 04/13/99
			stars2ca.of_commit()					// FNC 04/13/99
		end if
		
		//	12/04/00	GaryR	Stars 4.7 DataBase Port
		ls_aux_db = gnv_sql.of_get_database_prefix( ls_aux_db )
	end if
end if

if istr_drilldown.path <> 'AD' then
	li_i = 0
	/*determine source if claim*/
	IF	ib_ancillary_inv_type	=	FALSE			THEN		// FDG 06/15/98
		// FDG 06/05/98 - Remove reference to drilldown when checking for subset
		if trim(is_subset_id) <> '' or is_data_type = 'SUBSET' then
			// get subset id
			if trim(is_subset_id) <> '' then
				ls_subset_id = is_subset_id
			else
				ls_subset_id = is_source_subset_id
			end if
			li_i++
			// FNC 09/08/98 Start
			if left(as_inv_type,1) = 'Q' then
				lnvo_revenue = create n_cst_revenue
				ls_main_table = lnvo_revenue.of_get_main_table(as_inv_type)
				ls_rev_table = lnvo_revenue.of_get_revenue(ls_main_table)
				// FDG 03/12/01 - dynamically get 'SUB_MEDC_'

				// MikeFl - 7/23/02 - Track 3495 - Semi-rewrite begins. All // in position 1 are my entries
				ls_from[li_i] =	ls_sub_db + gnv_sql.of_get_subset_prefix() + ls_rev_table + "_" + &
										ls_subset_id
				ls_inv_types[li_i]	=	as_inv_type			// FDG 11/21/00
				destroy(lnvo_revenue)
			else
				// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
				ls_from[li_i] =	ls_sub_db + gnv_sql.of_get_subset_prefix() + as_inv_type + "_" + &
										ls_subset_id
				ls_inv_types[li_i]	=	as_inv_type			// FDG 11/21/00
			end if
			// FNC 09/08/98 Start			
		else
			li_i++
			// FDG 03/13/01 - Get base table name from anv_base
			IF	anv_base.is_base_table[ai_tbl_no]	=	'@'		THEN
				// Subsetting.  Append '@' to end of table name
				ls_from[li_i] = ls_base_db + ls_tbl_name + '@'
			ELSE
				ls_from[li_i] = ls_base_db + anv_base.is_base_table[ai_tbl_no]
			END IF
			// FDG 03/13/01 end
			ls_inv_types[li_i]	=	as_inv_type			// FDG 11/21/00
		end if
	else /* non-claim tables */
		// FDG 04/01/02 - Account for ancillary subsets
		if trim(is_subset_id) <> '' or is_data_type = 'SUBSET' then
			// Ancillary subset
			li_i++
			// Get subset id
			if trim(is_subset_id) <> '' then
				ls_subset_id = is_subset_id
			else
				ls_subset_id = is_source_subset_id
			end if

			ls_from[li_i] =	ls_sub_db + gnv_sql.of_get_subset_prefix() + as_inv_type + "_" + &
									ls_subset_id 							// MikeFl 7/23/02

			ls_inv_types[li_i]	=	as_inv_type	
		else
			li_i++
			ls_from[li_i] = ls_aux_db + ls_tbl_name
			ls_inv_types[li_i]	=	as_inv_type			// FDG 11/21/00
		end if
		// FDG 04/01/02 end
	end if
end if

/* determine if dependent */
if trim(idw_source.getitemstring(1,'add_data_source')) <> '' then
	// FDG 09/11/98 begin
	if ib_drilldown 						&
	and istr_drilldown.path	=	'AD'	then		
		ls_tbl_type = istr_drilldown.inv_type	//02-04-98 FNC
	else
		ls_tbl_type = left(idw_source.getitemstring(1,'add_data_source'),2)
		w_main.dw_stars_rel_dict.SetFilter("")  /* clear out */
		w_main.dw_stars_rel_dict.Filter()
		ls_filter = "rel_id = '" + as_inv_type + "' and id_2 = '" +	ls_tbl_type + "'"
		w_main.dw_stars_rel_dict.SetFilter(ls_filter)
		w_main.dw_stars_rel_dict.Filter()
		ls_tbl_name = w_main.dw_stars_rel_dict.getitemstring(1,'dictionary_elem_name')
	end if
	// FDG 09/11/98 end
	if trim(is_subset_id) <> '' or is_data_type = 'SUBSET'  then
		// FDG 01/11/02 - Track 2671d begin
		// If the additional data source is fasttrack, get its main table type
		if trim(is_subset_id) <> '' then
			ls_subset_id = is_subset_id
		else
			ls_subset_id = is_source_subset_id
		end if
		li_i++
		if left(ls_tbl_type,1) = 'O' AND NOT ib_ancillary_inv_type then
			// Additional data source is fasttrack.  Get the revenue invoice type.
			ls_dep_tbls = '%' + ls_rev_table + '%'
			// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
			ls_from[li_i] = ls_sub_db + gnv_sql.of_get_subset_prefix() + ls_main_table + "_" + ls_subset_id
			ls_inv_types[li_i]	=	ls_tbl_type					
		else
			ls_dep_tbls = '%' + ls_tbl_type + '%'
			// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
			ls_from[li_i] = ls_sub_db + gnv_sql.of_get_subset_prefix() + ls_tbl_type + "_" + ls_subset_id

			ls_inv_types[li_i]	= ls_tbl_type
		end if
		// FDG 01/11/02 end
		
		//	For drilldown use the main invoice type
		IF ib_drilldown and istr_drilldown.path = 'AD' THEN
			ls_inv_type = istr_drilldown.main_inv_type
			IF istr_drilldown.main_inv_type = istr_drilldown.inv_type THEN
				// If additional is the main invoice
				//	do not validate dependents
				ls_dep_tbls = "%"
			END IF
		ELSE
			// If FastTrack use main header invoice type
			IF Trim( ls_main_table ) <> "" THEN ls_inv_type = ls_main_table
		END IF
		
		Select count(*) 
		Into :li_count
		From sub_step_cntl 
		Where subc_id = Upper( :ls_subset_id ) and
				inv_type = Upper( :ls_inv_type ) and 
				dep_tbls like Upper( :ls_dep_tbls )
		Using Stars2ca;
		
		if stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca, &
				'Error determining status of dependent table in U_NVO_Create_Sql.ue_create_from ')
			return 'ERROR'
		else											// FNC 04/13/99
			stars2ca.of_commit()					// FNC 04/13/99
		end if
		
		if li_count = 0 then	
			Messagebox('ERROR','No ' + ls_tbl_type + ' data for this subset in U_NVO_Create_Sql.ue_create_from ')
			return 'ERROR'
		end if
	else 
		li_i++
		IF ib_ancillary_inv_type THEN
			ls_from[li_i] = ls_aux_db + ls_tbl_name
		ELSE
			// FDG 03/13/01 - Get additional data source table name from anv_addtl
			IF	ib_subsetting	AND	ib_recurring_pdq		THEN
				ls_from[li_i] = ls_base_db + ls_tbl_name + '@'
			ELSE
				ls_from[li_i] = ls_base_db + anv_addtl.is_base_table[ai_tbl_no]
			END IF
		END IF
		ls_inv_types[li_i]	=	ls_tbl_type			
		// FDG 03/13/01 end
	
	end if
end if

/* if as_join is populated then ML with dep cols selected */
li_join_count = upperbound(as_join)
if li_join_count > 0 then
	for li_j = 1 to li_join_count
		li_i++
		// FDG 03/12/01 - dynamically get 'SUB_MEDC_'
		ls_from[li_i] =	ls_sub_db + gnv_sql.of_get_subset_prefix() + as_join[li_j] + "_" + &
								ls_subset_id
		ls_inv_types[li_i]	=	as_join[li_j]					// FDG 11/21/00
	next
end if

/* if drilldown */
if ib_drilldown then
	if ib_subsetting then
		istr_subsetting_info.temp_table_name = is_drilldown_previous_temp_table
	end if
	/* using ls_sub_db since no entry in dictionary for temp tables and all the 
	temp table are created in stars2 */

	li_i++
	ls_from[li_i] = ls_sub_db + is_drilldown_previous_temp_table
	ls_inv_types[li_i]	=	IC_TEMP_ALIAS					// FDG 11/21/00
end if

	/* now put it all together */
li_rowcount = upperbound(ls_from)

// MikeF 8/20 Track 3252 - Begin
li_upper		=	UpperBound(is_outer_alias1)				

IF ib_outer_join THEN
	
	// JasonS 1/14/06  Track 4493d - If more tables exist, we must add them to the from clause																			
	if li_rowcount > 2 then
		FOR li_i = 3 to li_rowcount
			ls_from_statement = ls_from_statement	+	","	+	ls_from[li_i] + " " + ls_inv_types[li_i]
		NEXT		
	end if
	
	ls_from_statement	=	 ls_from_statement + ", " + gnv_sql.of_left_outer_join_from	(ls_from[1],					&
																												is_outer_alias1[li_upper],	&
																												ls_from[2],						&
																												is_outer_alias2[li_upper])

	// MikeF 8/20 Track 3252 - End
ELSE
	FOR li_i = 1 to li_rowcount
		ls_from_statement = ls_from_statement	+	","	+	ls_from[li_i] + " " + ls_inv_types[li_i]
	NEXT
END IF

// MikeFl - Track 3495 - Begin
IF left(ls_from_statement,1) = "," THEN
	ls_from_statement = "FROM " + mid(ls_from_statement,2)
ELSE
	ls_from_statement = "FROM " + ls_from_statement
END IF
// MikeFl - Track 3495 - END

return ls_from_statement
end event

event type integer ue_create_sql();//*********************************************************************************
// Event Name:	u_nvo_create_sql.ue_create_sql
//	Arguments:	None       
// Returns:		Integer
//*********************************************************************************
// 12-04-97 FNC	Created
//*********************************************************************************
// Modifications
// 01-28-98 FNC	Don't trigger event to add payment date if payment date is not 
//						included in the criteria.
//
//	02/03/98	FDG	Initialize li_num_tables to 1.
//	02/13/98	JTM 	Moved ue_create_order_by call AFTER ue_create_select call to
//						correct error in ORDER BY (column name not yet known error). 
// 02/19/98 FNC	Moved retrieval of ids_ros_dir out of the inv type loop so that 
//						it is not executed several times and it is populated before the 
//						event ue_subsetting_get_ros_directory_dates is triggered.
//	02/23/98 FNC	Perform upper on iuo_query.is_data_type because sometimes a lower
//						case value can be in this variable.
// 02/25/98 FNC	Track 846. 
//						1.Initialize istr_sql_statement to remove sql from a previously 
//						created report.
//						2.Reverse the table number passed to iuo_query.ue_subsetting_get_ros_directory_dates. 
//						The first number is actually the from date because it is the most 
//						recent date and the lowest date is the thru date because it is the
//						oldest date.
//	03/04/98	FNC	Track 833.  Set lb_payment_date to TRUE if period is NONE 
//						so that if payment date is entered as a criteria it is included.
// 03/05/98	FNC	Check for MC was on entire entry in datasource dddw. This never 
//						matched because the entry was MC-Common not just MC. Must look only
//						at first two positions.
// 03-11-98 FNC 	Check return code from ue_create_from
//	03-24-98 FNC	Track 912.  Check for ML was on entire entry in datasource dddw. This 
///					never matched because the entry was ML- Multi-Level not just ML. Must 
//						look only at first two positions.
//						Track 957.  Verify tables in an MC subset that is used as a source.
// 04/09/98 HRB	Track 987.  1.Add edit check not allowing multiple values for '=' for
//                paid date - check for other columns in uo_query.ue_format_where_criteria
// 04/21/98 FNC	Track 1020 Check return code from ue_subsetting_fill_step_info
// 04/30/98	FNC	Track 1141. clear out ls_join before calling ue_create_select 
//						so that it is filled or not filled correctly in ue_create_select
// 05/12/98 FNC	Track 1180 Call fx_get_specific_table after ue_create_where because 
//						dates are edited in ue_create_where(format_where_criteria) so if
//						the user enters a bad date it is caught before calling fx_get_specific
//						table.
// 06/11/98	FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	06/12/98	FDG	Move scripts from iuo_query to this object.
//	06/15/98	FDG	Track ????.  Store istr_sql_statement in uo_query for future reference.
//						Don't directly reference attributes in uo_query.
//	06/15/98	FDG	Track ????.  Check ib_ancillary_inv_type instead of 
//						is_source_type because is_source_type is getting reset.
// 07/31/98	FDG	Track 1248.  If coming in from drilldown, then get the invoice
//						type from istr_drilldown.  ue_create_select requires ls_inv_type
//						to have data.
// 09/10/98 FNC	Track 1683. Store table type for each sql statement so can
//						substitute MC in MC superprovider queries when super provider
//						where statement is added in U_NVO_Search.ue_string_sql_Statement.
//	10/28/98	FDG	Track 1934.  When entering QE from another window, there are
//						times where the 'Source' tab data is not filled in.  When this
//						occurs, ls_inv_type[1] will be null.  Default this to is_inv_type
//						when this occurs.
// 04/13/99 FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
//	04/20/99	NLG	FS/TS2239. Get rid of globals for period and period key
//	11/05/99	NLG	Ts2463c. Store run_frequency in sx_subsetting_info.
//	12-13-99	NLG	Ts2463c. If future-dated pdq (recurring pdq), parse ls_paid_date_value
//						to get the thru and from dates.  Allow dates to be in the future (not
//						loaded in ros dir.
// 12/22/99 FNC	Edit second payment date to determine if it is the ros directory
//						date range. Right now only the first date was being edited.
//	07/12/00	FDG	Track 2365c.  Stars 4.5 SP1.  Determine if the payment date is
//						to be removed from the Where clause.
//	11/21/00	FDG	Stars 4.7.  Initialize that an outer join is occuring.
//	01/05/01	GaryR	Stars 4.7 DataBase Port - Date Conversion
//	03/09/01	FDG	Stars 4.7.	Use Stars Server instead of ros_directory.  To get
//						the 'from' tables, must first determine if retrieving base data
//						of ancillary data (Taking drilldown into consideration).
//	04/10/01	FDG	Stars 4.7.	If payment_date is the only where criteria, change 'AND'
//						to 'WHERE'
//	05/30/01	GaryR	Stars 4.7	The server now parses the paid date to obtain the
//										from date and the thru date in of_GetClaimsTableNames().
//										Implement this functionality and delete the now
//										obsolete ue_parse_paid_date_value event.
//	07/05/01	GaryR	Track 3510c	Invalid error handling using multiple Paid Dates.
// 07/20/01	GaryR	Track 2368d	Handling MC Queries
//	07/27/01	GaryR	Track 2383d	Fix bug that was caused by the above Track 2368d
//	08/15/01	GaryR	Track 2401d	Fix bug that set the invalid scheduling date
//										for recuring subsets
//	11/01/01	GaryR	Stars 4.7	Populate boolean that indicates use of payment dates
//	11/15/01	FDG	Track 2520d Edit dates before determining if the dates are out of
//										range.
//	01/22/02	FDG	Track 2711d	Reset istr_subsetting_info.  This can have old data if
//										creating a ML subset AFTER creating a MC subset.
//	02/01/02	FDG	Track 2783d Don't reset all of istr_subsetting_info because filter
//										data has already been preset.
//	02/20/02	FDG	Track 2828d Edit payment date operator and value before calling
//										GetClaimsTableNames.
// 07/23/02 MikeF	Track 3495c	Modify SQL for Left Outer Join.
//	08/15/02	GaryR	Track 4558c	Do not validate loaded payment range for subsets
// 08/15/02 MikeF Track 3252	ML Subset Outer Join changes.
//	11/26/02	GaryR	Track 3275d	Validate range of dependant
// 12/10/02	GaryR	Track 3030c	Fill in additional data source in criteria table
//	04/15/03	GaryR	Track	3513d	Get additional data source even if source is subset
// 03/04/04 MikeF SPR3921d		Using a LOJ with a UNION ALL View gives DB error
// 03/10/04 MikeF SPR3939d		Using OR LOJ with UNION ALL can't be subsetted
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
// 02/15/06 HYL Track 4651d : Prevent invalid default schedule date for ancillary subset
// 10/15/09 RickB LKP.650.5678.001 Added NOT IN and BETWEEN to multiple values message
//*********************************************************************************

/*This is the controller event.  It will perform the basic logic and call the other 
events to do the actual passing invoice types.  Get MC invoice types from 
stars_rel and get ML invoice types from the data source dddw on tabpage_source.  
If it is a single invoice type then determine if it is a claim type.  If it is a 
claim type then determine the claim table numbers.  */

string	ls_inv_type[],				&
			ls_blank_array[],			&
			ls_filter,					&
			ls_paid_date_value, 		&
			ls_paid_date_operator,	&
			ls_table_directory[],	&
			ls_where[],					&
			ls_where_paid,				&
			ls_orig_where[],			&
			ls_replaced_where[],		&
			ls_order_by,				&
			ls_select,					&
			ls_join[],					&
			ls_sql,						&
			ls_add_data_source,		&
			ls_empty,					&
			ls_orig_inv_type			// 07/20/01	GaryR	Track 2368d
integer	li_rowcount,				&
			i,								&	
			j,								&
			k,								&
			li_payment_date_row,		&
			li_num_Tables,				&
			li_rc,						&
			li_num_inv_types,			&
			li_pos,						&
			li_rows,						&
			li_upper, 						&
			i_rtn								// 02/16/06 HYL Track 4651d
boolean	lb_add_payment_date,		&
			lb_remove_date,			&
			lb_in_range,				&
			lb_got_tables

datetime	ld_paid_from_date,		&
			ld_paid_thru_date
			
date		ld_second_date

n_cst_tableinfo_attrib	lnv_base[]	// 07/20/01	GaryR	Track 2368d
u_nvo_subset u_nvo_subset // 02/16/06 HYL Track 4651d
n_cst_datetime		lnv_date			// FDG 11/15/01 - Autoinstantiated

sx_subsetting_info		lstr_subsetting_info							// FDG 01/22/02
sx_filter_create			lstr_filter_create[]							// FDG 02/01/02
String						ls_filter_copy[]								// FDG 02/01/02

lstr_filter_create	=	istr_subsetting_info.filter_create		// FDG 02/01/02
ls_filter_copy			=	istr_subsetting_info.filter_copy			// FDG 02/01/02

istr_subsetting_info	=	lstr_subsetting_info							// FDG 01/22/02
istr_subsetting_info.filter_create	=	lstr_filter_create		// FDG 02/01/02
istr_subsetting_info.filter_copy		=	ls_filter_copy				// FDG 02/01/02
			
//n_ds		lds_ros_directory
			
sx_sql_statement lstr_sql_statement[]

//	FDG 11/21/00 - Reset that an outer join is occuring
ib_outer_join	=	FALSE

//02-25-98 FNC Intialize istr_sql_statement
istr_sql_statement = lstr_sql_statement

// the array will be reset if ML or MC 
ls_inv_type [1]	=	left(idw_source.getitemstring(1,'data_source'),2)

// FDG 07/31/98 begin
IF	(IsNull (ls_inv_type[1])	OR	Len (ls_inv_type[1])	=	0)		&
AND ib_drilldown																THEN
	ls_inv_type [1]	=	istr_drilldown.inv_type
END IF
// FDG 07/31/98 end

// FDG 10/28/98 begin
IF	IsNull (ls_inv_type[1])				&
OR	Trim (ls_inv_type[1])	<	' '	THEN
	 ls_inv_type[1]	=	is_inv_type
END IF
// FDG 10/28/98 end

li_num_tables	=	1								// FDG 02/03/98
ls_orig_inv_type = ls_inv_type[1]			// 07/20/01	GaryR	Track 2368d

//FNC 05/12/98 moved the rest of the code for the else after ue_create_where
//is called

if ls_inv_type[1] = 'ML' or (ls_inv_type[1] = 'MC' and is_data_type = 'SUBSET') then 				//03-24-98 FNC
	// 07/20/01	GaryR	Track 2368d - Begin
	li_rc = idw_source.Dynamic	Event ue_get_inv_types(ls_inv_type[])				// FDG 06/15/98
	if li_rc < 0 then 
		return li_rc
	end if
	lb_add_payment_date = TRUE  /*will cause payment_date to be included*/
else
	if ls_inv_type[1] = 'MC' then		//03-05-98 FNC 
		w_main.dw_stars_rel_dict.setfilter('')
		w_main.dw_stars_rel_dict.filter()
		ls_filter = "rel_type = 'GP' and id_3 = '*' "
		w_main.dw_stars_rel_dict.setfilter(ls_filter)
		w_main.dw_stars_rel_dict.filter()
		li_rowcount = w_main.dw_stars_rel_dict.rowcount()
		for i = 1 to li_rowcount
			ls_inv_type[i] = w_main.dw_stars_rel_dict.getitemstring(i,'id_2')
		next
	end if
	// 07/20/01	GaryR	Track 2368d - End
	
	//03-04-98 FNC Start
	If iuo_period.uf_return_desc() = 'NONE' Then	
		lb_add_payment_date = TRUE
	end if
end if
	//03-04-98 FNC End

// FDG 07/12/00 begin
IF NOT ib_ancillary_inv_type AND Upper(is_data_type) = "BASE" THEN
	li_payment_date_row	=	This.Event	ue_get_paid_date_values (ls_paid_date_value,	&
																				ls_paid_date_operator)
END IF
//	07/05/01	GaryR	Track 3510c
IF	li_payment_date_row	<	0		THEN Return -101

// FDG 02/20/02 - Edit paid date
IF	li_payment_date_row	>	0		THEN
	IF	Trim(ls_paid_date_operator)	=	''		THEN
		MessageBox('Error', 'Relational Operator is required.')
		idw_criteria.ScrollToRow(li_payment_date_row)
		Return -102
	END IF
	
	IF	Trim(ls_paid_date_value)	=	''		THEN
		MessageBox('Error', 'Value is required.')
		idw_criteria.ScrollToRow(li_payment_date_row)
		Return -101
	END IF
END IF
// FDG 02/20/02 end

// 07/20/01	GaryR	Track 2368d - Begin
li_num_inv_types = upperbound(ls_inv_type)
FOR k = 1 TO li_num_inv_types
	// FDG 03/09/01 - initialize inv_base and inv_addtl in case it already has data.
	inv_base.is_inv_type				=	ls_empty
	inv_base.is_operand				=	''
	inv_base.is_paid_date			=	''
	inv_base.il_period_key			=	0
	inv_base.is_where_paid_date	=	''
	inv_base.ib_view					=	FALSE
	inv_addtl.is_inv_type			=	ls_empty
	inv_addtl.is_operand				=	''
	inv_addtl.is_paid_date			=	''
	inv_addtl.il_period_key			=	0
	inv_addtl.is_where_paid_date	=	''
	inv_addtl.ib_view					=	FALSE

	// Set base table attributes
	inv_base.is_inv_type			=	ls_inv_type[k]		// 07/20/01	GaryR	Track 2368d
	inv_base.is_operand			=	ls_paid_date_operator
	inv_base.is_paid_date		=	ls_paid_date_value
	inv_base.ib_view				=	uf_get_is_view(inv_base.is_inv_type)
	
	// Determine if the payment_date is to be removed from the Where clause.  If a period is
	// specified, then lb_add_payment_date = FALSE.
	IF	lb_add_payment_date								&
	OR	iuo_period.uf_return_desc()	<>	'NONE'	THEN
		IF	li_payment_date_row	>	0		THEN
			// FDG 03/09/01 begin
			//lb_remove_date		=	This.uf_remove_payment_date (ls_paid_date_value,	&
			//																	ls_paid_date_operator)
			//IF	lb_remove_date		THEN
			//	lb_add_payment_date	=	FALSE
			//END IF
			// FDG 11/15/01 - edit payment date format
			li_rc		=	lnv_date.of_EditStringDates (ls_paid_date_value)
			IF	li_rc	<	0		THEN
				CHOOSE CASE	li_rc
					CASE	-2
						MessageBox ('Paid Date Error', 'The Paid Date must contain 4 digit years')
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
					CASE	-3
						MessageBox ('Paid Date Error', 'The Paid Date must be between '	+	&
										lnv_date.of_GetMinimumStringDate()	+	' and '			+	&
										lnv_date.of_GetMaximumStringDate() )
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
					CASE	ELSE
						MessageBox ('Paid Date Error', 'An invalid Paid Date was entered')
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
				END CHOOSE
			END IF
			// FDG 11/15/01 end
			// 07/20/01	GaryR	Track 2368d
			lb_in_range	=	gnv_server.of_AreDatesInRange (ls_inv_type[k],			&
																		ls_paid_date_operator,	&
																		ls_paid_date_value,		&
																		iuo_period.uf_return_key() )
			IF	ib_subsetting	AND	ib_recurring_pdq		THEN
				// Only recurring PDQs can be future dated
				li_num_tables	=	0
			//	08/15/02	GaryR	Track 4558c	
			//ELSEIF lb_in_range	=	FALSE						THEN
			ELSEIF NOT lb_in_range AND is_data_type <> 'SUBSET' THEN
				// FDG 11/06/98 - Display an error message stating why
				MessageBox ('Paid Date Error', 'The Paid Date entered is outside the range '	+	&
								'of loaded data')
				IF	li_payment_date_row	>	0		THEN
					idw_criteria.ScrollToRow (li_payment_date_row)
				END IF
				return -101
			END IF
			li_rc								=	gnv_server.of_GetClaimsTableNames (inv_base)
			lnv_base[k] = inv_base		// 07/20/01	GaryR	Track 2368d
			lb_got_tables					=	TRUE
			IF	inv_base.il_rc			<	0			THEN
				//	08/15/01	GaryR	Track 2401d - Begin				
				inv_base.idt_fromDate = DateTime( Date( Left( ls_paid_date_value, Pos( ls_paid_date_value, "," ) - 1 ) ) )
				inv_base.idt_tDate = DateTime( Date( Mid( ls_paid_date_value, Pos( ls_paid_date_value, "," ) + 1 ) ) )
				//	08/15/01	GaryR	Track 2401d - End
				
				lb_add_payment_date	=	TRUE
			ELSE
				//	11/01/01	GaryR - Begin
				//IF	inv_base.ib_exclude_payment_date	=	TRUE		THEN
				//	lb_add_payment_date	=	FALSE
				//END IF
				lb_add_payment_date = NOT inv_base.ib_exclude_payment_date
				//	11/01/01	GaryR - End
			END IF
			// FDG 03/09/01 end
		END IF
	END IF
	// FDG 07/12/00 end

	// FDG 03/09/01 - For base data (for non-recurring subsets), get the table names.
	IF  ib_ancillary_inv_type	=	FALSE			&
	AND Trim(is_subset_id)		=	''				&
	AND Upper(is_data_type)		<>	'SUBSET'		&
	AND (ib_subsetting	AND ib_recurring_pdq)	=	FALSE			THEN
		// For base data, get the table names for the main table.
		// Drilldown with additional data has no value in data source, but 
		//	has a value in additional data source.
		IF	istr_drilldown.path		<>	'AD'		THEN
			// If the claims tables names were already retrieved, there is no need to do it again.
			IF	lb_got_tables			=	FALSE		THEN
				//	FDG 02/20/02 - begin
				IF	 Trim(inv_base.is_operand)		=	''		&
				AND Trim(inv_base.is_paid_date)	=	''		THEN
					MessageBox ('Error', 'Payment date is required.')
					Return	-1
				END IF
				// FDG 02/20/02 end
				li_rc						=	gnv_server.of_GetClaimsTableNames (inv_base)
				lnv_base[k] = inv_base		// 07/20/01	GaryR	Track 2368d
			END IF
			IF	inv_base.il_rc			<	0			THEN
				MessageBox ('Error', inv_base.is_message)
				Return	-1
			END IF
			li_upper						=	UpperBound (inv_base.is_base_table)
			IF	li_upper					>	li_num_tables		THEN
				li_num_tables			=	li_upper
			END IF
		END IF
		//	11/01/01	GaryR - Begin
		//IF	inv_base.ib_exclude_payment_date	=	TRUE		THEN
		//	lb_add_payment_date		=	FALSE
		//END IF
		lb_add_payment_date = NOT inv_base.ib_exclude_payment_date
		//	11/01/01	GaryR - End
		//	If there's an additional data source, get the table names for that
		ls_add_data_source			=	Trim (idw_source.GetItemString(1, 'add_data_source') )
		IF	ls_add_data_source		<>	''			THEN
			// Get the table names for additional data source
			//	11/26/02	GaryR	SPR 3275d - Begin
			lb_in_range = gnv_server.of_AreDatesInRange( Left( ls_add_data_source, 2 ), 	&
																		ls_paid_date_operator,				&
																		ls_paid_date_value,					&
																		iuo_period.uf_return_key() )
			IF NOT lb_in_range AND is_data_type <> 'SUBSET' THEN
				// FDG 11/06/98 - Display an error message stating why
				MessageBox ('Paid Date Error', 'The Paid Date entered is outside the range '	+	&
								'of loaded data')
				IF	li_payment_date_row	>	0		THEN
					idw_criteria.ScrollToRow (li_payment_date_row)
				END IF
				Return -101
			END IF
			//	11/26/02	GaryR	SPR 3275d - End
			
			inv_addtl.is_inv_type		=	Left (ls_add_data_source, 2)
			inv_addtl.is_operand			=	ls_paid_date_operator
			inv_addtl.is_paid_date		=	ls_paid_date_value
			inv_addtl.ib_view				=	uf_get_is_view(inv_addtl.is_inv_type)
			
			li_rc								=	gnv_server.of_GetClaimsTableNames (inv_addtl)			
			IF	inv_addtl.il_rc			<	0			THEN
				MessageBox ('Error', inv_addtl.is_message)
				Return	-1
			END IF
			li_upper							=	UpperBound (inv_addtl.is_base_table)
			IF	li_upper						>	li_num_tables		THEN
				li_num_tables				=	li_upper
			END IF
		END IF
	END IF
	// FDG 03/09/01	end
NEXT
// 07/20/01	GaryR	Track 2368d - End

// Next build the WHERE clause and loop thru invoice types and table numbers to build
// the SELECT and FROM clauses.
// FDG 04/10/01 - lb_add_payment_date is now passed by reference because its value might change.

IF ib_ancillary_inv_type OR Upper(is_data_type) = "SUBSET" THEN lb_add_payment_date = TRUE

li_rc = this.event ue_create_where (lb_add_payment_date, ls_orig_where)
if li_rc  <	0		then 
	return li_rc
end if

ls_where = ls_orig_where

/* FNC 05/12/98 Code moved from above */
// 07/20/01	GaryR	Track 2368d - Begin
//if ls_inv_type[1] = 'ML' or (ls_inv_type[1] = 'MC' and is_data_type = 'SUBSET') then			//03-24-98 FNC
if ls_orig_inv_type = 'ML' or (ls_orig_inv_type = 'MC' and is_data_type = 'SUBSET') then
//	li_rc = idw_source.Dynamic	Event ue_get_inv_types(ls_inv_type[])				// FDG 06/15/98
//	if li_rc < 0 then 
//		return li_rc
//	end if
else
//	if ls_inv_type[1] = 'MC' then		//03-05-98 FNC 
//		w_main.dw_stars_rel_dict.setfilter('')
//		w_main.dw_stars_rel_dict.filter()
//		ls_filter = "rel_type = 'GP' and id_3 = '*' "
//		w_main.dw_stars_rel_dict.setfilter(ls_filter)
//		w_main.dw_stars_rel_dict.filter()
//		li_rowcount = w_main.dw_stars_rel_dict.rowcount()
//		for i = 1 to li_rowcount
//			ls_inv_type[i] = w_main.dw_stars_rel_dict.getitemstring(i,'id_2')
//		next
//	end if
// 07/20/01	GaryR	Track 2368d - End

	/* if claim and base, get table numbers */
	//if (is_source_type <> "AN" and upper(is_data_type) = "BASE") then //02-23-98 FNC		// FDG 06/15/98
	if (ib_ancillary_inv_type = FALSE and upper(is_data_type) = "BASE") then //02-23-98 FNC
		li_payment_date_row = This.event	ue_get_paid_date_values(ls_paid_date_value,ls_paid_date_operator)
		if li_payment_date_row = 0 then
			li_rc = messagebox('WARNING','Query will take some time, no payment_date', + &
				Exclamation!,OKCANCEL!)
			if li_rc = 2 then
				return -10
			end if
		elseif li_payment_date_row <	0 then
			return li_payment_date_row
		end if
		//HRB 4/9/98 - do not allow multiple values for '=', same check for other columns in
		//             ue_format_where_criteria()
		if ls_paid_date_operator = '=' and match(ls_paid_date_value,',') then
			messagebox('Error',"Must use the IN, NOT IN or BETWEEN operator with multiple values.", StopSign!,Ok!)
			return -10
		end if
		
		// 07/20/01	GaryR	Track 2368d - Begin
		FOR k = 1 TO li_num_inv_types
			// FDG 11/15/01 - edit payment date format
			li_rc		=	lnv_date.of_EditStringDates (ls_paid_date_value)
			IF	li_rc	<	0		THEN
				CHOOSE CASE	li_rc
					CASE	-2
						MessageBox ('Paid Date Error', 'The Paid Date must contain 4 digit years')
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
					CASE	-3
						MessageBox ('Paid Date Error', 'The Paid Date must be between '	+	&
										lnv_date.of_GetMinimumStringDate()	+	' and '			+	&
										lnv_date.of_GetMaximumStringDate() )
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
					CASE	ELSE
						MessageBox ('Paid Date Error', 'An invalid Paid Date was entered')
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
				END CHOOSE
			END IF
			// FDG 11/15/01 end
			lb_in_range	=	gnv_server.of_AreDatesInRange (ls_inv_type[k],			&
																		ls_paid_date_operator,	&
																		ls_paid_date_value,		&
																		iuo_period.uf_return_key() )
			IF	lb_in_range	=	FALSE						THEN
				IF	ib_subsetting	AND	ib_recurring_pdq		THEN
					li_num_tables	=	0
				ELSE
					//	08/15/02	GaryR	Track 4558c - Begin
					IF is_data_type <> 'SUBSET' THEN
						// FDG 11/06/98 - Display an error message stating why
						MessageBox ('Paid Date Error', 'The Paid Date entered is outside the range '	+	&
										'of loaded data')
						IF	li_payment_date_row	>	0		THEN
							idw_criteria.ScrollToRow (li_payment_date_row)
						END IF
						return -101
					END IF
					//	08/15/02	GaryR	Track 4558c - End
				END IF
			END IF														// FNC 12/22/99 End
		NEXT
		// 07/20/01	GaryR	Track 2368d - End
	else
		lb_add_payment_date = TRUE /* payment_date to be included */
	end if
end if

k = 1
/* if subsetting use the table numbers to get the ros_directory dates to pass to 
the Subset Options window and then replace the table number array with an array 
only containing '@' so only one step is created */
if ib_subsetting then
	IF ib_ancillary_inv_type THEN // 02/15/06 HYL Track 4651d : Prevent invalid default schedule date for ancillary subset
		i_rtn = u_nvo_subset.of_get_default_sched_time(ld_paid_from_date, ld_paid_thru_date)
		IF i_rtn = -1 THEN
			Messagebox('Warning', 'Error retrieving default start time. Start time will be set to current server time')
			RETURN -1
		ELSEIF i_rtn = -2 THEN	
			messagebox('Warning', 'Default time in Stars Win Parms is not in correct format. Start time will be set to current server time')
			RETURN -1
		END If
	ELSE
		ld_paid_from_date = inv_base.idt_fromDate
		ld_paid_thru_date = inv_base.idt_TDate
	END IF
	istr_subsetting_info.run_frequency = ii_run_frequency//NLG 11-05-99 ts2463c
end if

for i = 1 to li_num_inv_types
	ls_join = ls_blank_array		//FNC 04/30/98 
	ls_select	=	this.event ue_create_select (ls_inv_type[i], ls_join[]) 
	if ls_select = 'ERROR' then 
		return -1
	end if
	if upperbound(ls_join[]) > 0 then  /* ML dep join */
		li_rc = this.event ue_create_where_ML_subset_add_dependent(ls_where[],ls_inv_type[i],ls_join[])
		if li_rc <	0 then 
			return li_rc	
		end if
	end if
	// 07/20/01	GaryR	Track 2368d - Begin
	IF ib_subsetting THEN
		lnv_base[i].is_base_table[1]	=	'@'	// FDG 03/09/01
		li_num_tables = 1
	END IF
	// 07/20/01	GaryR	Track 2368d - End
	
	for j = 1 to li_num_tables
		istr_sql_statement[k].select_clause = ls_select
		istr_sql_statement[k].tbl_type = ls_inv_type[i]			// FNC 09/10/98
		
		IF IsNull( lnv_base ) OR UpperBound( lnv_base ) < 1 THEN
			istr_sql_statement[k].from_clause = this.event ue_create_from (ls_inv_type[i], j, ls_join, inv_base, inv_addtl)
		ELSE
			istr_sql_statement[k].from_clause = this.event ue_create_from (ls_inv_type[i], j, ls_join, lnv_base[i], inv_addtl)
		END IF

		if istr_sql_statement[k].from_clause = 'ERROR' then
			return -1
		end if

		// FDG 04/10/01 - lb_add_payment_date must be true for ue_create_where_add_payment_date
		//if not lb_add_payment_date and li_payment_date_row > 0 then		//01-28-98 FNC
		if lb_add_payment_date and li_payment_date_row > 0 then		//01-28-98 FNC

			li_rc	=	This.Event	ue_create_where_add_payment_date (ls_where_paid,		&
																					ls_inv_type[i],		&
																					li_payment_date_row)
			if li_rc <	0 then 
				return li_rc
			end if
			IF	Len (Trim(ls_where_paid) )		>	0		THEN
				li_upper	=	UpperBound(ls_where)	+	1
				// FDG 04/10/01 - If only one line of criteria exist (payment_date), then
				//	change 'AND' to 'WHERE'
				IF	li_upper	=	1		THEN
					// payment_date is the only criteria in the where clause
					ls_where_paid	=	Upper(ls_where_paid)
					li_pos			=	Pos (ls_where_paid, 'AND ')
					IF	li_pos		>	0		THEN
						ls_where_paid	=	Left (ls_where_paid, li_pos - 1)	+	&
												'WHERE '									+	&
												Mid (ls_where_paid, li_pos + 4)
					END IF
				END IF
				// FDG 04/10/01 end
				ls_where [li_upper]	=	ls_where_paid
			END IF
			// FDG 03/09/01 end
		end if			
		/* break with totals */	
//		if ls_order_by <> '' then 
		if upperbound(this.istr_break_info.cols) > 0 and not ib_count then 	
			IF ls_order_by = '' THEN 
				ls_order_by = this.event ue_create_order_by()
			END IF
			this.event ue_add_order_by(ls_order_by, ls_where[])
		end if
		//03-05-98 FNC Start		
		
		// MikeFl 7/23/02 Track 3495c- Begin
		// Oracle will return an empty string. Sybase will return the ON and WHERE clause in a single string
		//ls_replaced_where = ls_where
		IF ib_outer_join THEN
			ls_replaced_where[1] = gnv_sql.of_left_outer_join_on(ls_where)
			IF trim(ls_replaced_where[1]) = '' THEN
				ls_replaced_where = ls_where
			//	MikeFl 8/15/02 Track 3252- Begin	
			ELSE	
				IF ls_orig_inv_type = 'ML' THEN
					istr_sql_statement[k].from_clause = istr_sql_statement[k].from_clause + ls_replaced_where[1] 
					ls_replaced_where = ls_blank_array
				END IF
			//	MikeFl 8/15/02 Track 3252- End	
			END IF		
		ELSE
			ls_replaced_where = ls_where
		END IF
		// MikeFl 7/23/02 Track 3495c- End
		
		if left(idw_source.getitemstring(1,'data_source'),2) = 'MC' then
			this.event ue_replace_MC_where(ls_inv_type[i],ls_replaced_where)
		end if
		istr_sql_statement[k].where_clause = ls_replaced_where
		//03-05-98 FNC End
		/*clear out array */
		ls_where = ls_orig_where
		if ib_subsetting then
			ls_add_data_source			=	Trim (idw_source.GetItemString(1, 'add_data_source') )
			li_rc = this.event ue_subsetting_fill_step_info(ld_paid_from_date, ld_paid_thru_date, ls_inv_type[i], ls_add_data_source, k)
			if li_rc <	0 then 
				return li_rc		//04-21-98 FNC
			end if
		end if
		k++
	next

	// SPR 3921d - Don't allow query to execute under the following conditions due to Sybase issue:
	//	* DBMS is Sybase
	//	* Main Table is a UNION ALL view
	// * Query is against base data (NOT Subset)
	// * There isn't a ALLOWVIEWLOJ row in SYSCNTL whith CNTL_CASE='Y'
	IF  ib_outer_join					&
	AND is_data_type <> 'SUBSET' 	&
	AND inv_base.ib_view 			THEN		

		// If SYS_CNTL flag OR NON-OR LOJ and subsetting, allow
		IF gnv_sql.of_get_allow_view_loj(inv_base.is_inv_type)	&
		OR (NOT ib_or_loj AND ib_subsetting)  							THEN
			// Allow SQL to execute
		ELSE
			// Give the appropriate workaround 
			IF ib_or_loj THEN
				MessageBox ('SQL Error', &
					"The current query cannot be executed due to a database issue involving VIEWS where: " + &
					"~r * The Data Source is a view " + &
					"~r * The query includes an Additional Data Source" + &
					"~r * The query criteria from the Additional Data Source is used with an OR operator" + &
					"~r~rTo resolve this issue split your query into multiple levels as follows:" + &
					"~r * Level 1: Main Data Source.  Include search criteria fields from only the Main Data Source." + &
					"~r * Level 2: Main Data Source with Additional Data Source:  Include search criteria~r	  fields from only the Additional Data Source." )
			ELSE
				MessageBox ('SQL Error', &
					"The current query cannot be executed due to a database issue involving VIEWS where: " + &
					"~r * The Data Source is a view " + &
					"~r * The query includes an Additional Data Source" + &
					"~r * The query doesn't contain any criteria from the Additional Data Source" + &
					"~r~rTo resolve this issue do either of the following: " + &
					"~r * Create a subset using existing criteria" + &
					"~r * Add criteria using at least one field from the Additional Data Source" )
			END IF

			IF	li_payment_date_row	>	0		THEN
				idw_criteria.ScrollToRow (li_payment_date_row)
			END IF
			return -101
		END IF
	END IF
	
	ib_outer_join	=	FALSE						// 08/13/02 MikeFl Track 3252
	
next	

//	FDG 06/15/98 - Store the sql in the container so it can be referenced by uo_query
istr_sql_container.lsx_sql_statement	=	istr_sql_statement

return 0

end event

event type integer ue_create_where(ref boolean ab_add_payment_date, ref string as_where[]);//*********************************************************************************
// Event Name:	U_NVO_Create_Sql.UE_Create_Where
//	Arguments:	Boolean	ab_add_payment_date - by reference
//					String	as_where[]
// Returns:		Integer
//
//*********************************************************************************
// 12-04-97 FNC 	Created
// 03-11-98 FNC 	Check return code from ue_format_where_criteria
// 06/09/98	FNC 	Track 1137. Don't return after calling ue_create_where_subset_view
//						Must add where statement if user selects dependent data source.
//						Added if statement so that ue_format_criteria_add_clauses is
//						executed all the time, even for subset view.
// 06/11/98	FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
// 06/17/98	FNC	1.Track 1335. Check to see if as_where has been populated before
//						referencing the first item in the array.
//						2.If user clicks cancel in prefilter window do not process report.
// 06/23/98	FNC	Track 1385. Need to check if AND is in position 2 so know that 
//						it is there from ue_format_criteria_add_clauses. If so remove it. 
//						Don't remove if it is > 2 because then it is at the end and
//						the entire where statement will be removed.
// 08/18/98 AJS   TS144 - Report on Enhancements
//	08/21/00	FDG	Track 2365c.  Because payment date can be removed from the
//						Where clause, as_where[] can be empty.  If so, don't return -1.
//	04/10/01	FDG	Stars 4.7.	If payment date was added to the where clause, make
//						sure it's not added again (set ab_add_payment_date = FALSE).
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//*********************************************************************************

/*If there is a subset id (subset view) will build the WHERE clause using the 
subset id, else it will create the where clause using the info in tabpage_search.
Most of the code for this event will be taken from w_drilldown_parent.wf_format_sql(),
w_drilldown_parent.wf_check_index() and w_criteria_claim_link.wf_create_sql().  
First must check indexes.  Give warning if not found.  If ab_add_payment_date = TRUE
(set in ue_create_sql when source is subset) then add payment_date here, else it 
will be added later during table number loop if needed. Format each clause (one for
each column selected) and put into array, also performing edit checks (lead alpha, 
length, valid date).  Add clauses, if necessary, for dependent join and inv_type 
if Fasttrack. */

sx_criteria lstr_criteria[]  /* blank to use as placeholder */
integer		li_rc,			&
				li_return,		&
				li_pos,			&
				li_upper
				
String	ls_where[],			&
			ls_and = " "

if is_subset_id <> '' then
	this.event ue_create_where_subset_view(as_where)
	if upperbound(as_where) > 0 then									// FNC 06/17/98 Start
		if as_where[1] = 'CANCEL'	then	
			return -1
		end if
	end if																	// FNC 06/17/98 End
else																			// FNC 06/09/98 
	li_return = this.event ue_create_where_check_indexes()
	if li_return < 0 then return li_return
	if li_return = 0 then
//		AJS 08/18/98 TS144 - Report On Enhancements
		w_main.SetMicroHelp('Query will take some time, no indexed fields selected')
//		li_rc = messagebox('WARNING','Query will take some time, no indexed fields selected',&
//					Exclamation!,OKCANCEL!)
//		if li_rc = 2 then /* send back to SEARCH tab to pick new criteria */
//			return -10
//		end if
//		AJS 08/18/98 TS144 - end
	end if
	
	IF UpperBound( ii_prefilter_rows ) > 0 THEN
		this.event ue_create_where_subset_view(ls_where)
	END IF
	
	li_rc = This.event ue_format_where_criteria("WHERE",ab_add_payment_date,as_where,lstr_criteria)
	
	if li_rc < 0 then 
		return li_rc		//03-11-98 FNC
	end if
	ab_add_payment_date	=	FALSE				// FDG 04/10/01
	// FDG 08/21/00	Begin
	//if Upperbound(as_Where[]) < 1 Then Return -1
	li_upper	=	Upperbound (as_Where)
	if	li_upper		>	0		then
		if as_where[1] = "ERROR" then return -1			
		ls_and = " AND "
	end if
	
	IF UpperBound( ls_where ) > 0 THEN
		as_where[li_upper + 1] = ls_and + ls_where[1]
	END IF
	
end if																		// FNC 06/09/98 
 
li_rc = This.event ue_format_where_criteria_add_clauses("WHERE",as_where,lstr_criteria)

if upperbound(as_where) > 0 then												// FNC 06/17/98
	if as_where[1] <> "ERROR" then
		li_pos = pos(as_where[1],'AND')										// FNC 06/23/98
		if li_pos =2  then										   			// FNC 06/23/98
			as_where[1] = "WHERE " + mid(as_where[1],(li_pos + 3))	// FNC 06/23/98
		else
			as_where[1] = "WHERE " + as_where[1]
		end if
	end if
end if																				// FNC 06/17/98
		
return 0


end event

event type integer ue_create_where_add_payment_date(ref string as_where, string as_inv_type, integer ai_row_num);//*********************************************************************************
// Event Name:	U_NVO_Create_Sql.UE_Create_Where_Add_Payment_Date
//	Arguments:	String	as_where - by reference
//					String	as_inv_type
//					integer	ai_row_num
// Returns:		Integer
//
//	Description:
//			This event is only called from ue_create_sql to add the payment_date to
//			the where clause.  Before this event is triggered, it has already been
//			determined that the payment date must be added.
//
//*********************************************************************************
// 12-09-97 FNC	Created
//	12-30-97 FNC	Change ls filter to use col_name instead of col_desc
//	01/18/99	FDG	Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
// 01/05/01	GaryR	Stars 4.7 DataBase Port - Date Conversion.
//	03/12/01	FDG	Stars 4.7.	This event was rewritten to not use ros_directory.  The
//						comments below are no longer valid because of this change.
// 10/17/02 MikeF	Track 4730d	Allow an '=' to be used with Payment Date.
//*********************************************************************************


//This event is called from ue_create_sql within the table number loop. First must 
//get the date(s) entered by the user using ai_row_num.  Depending on the operator may have to parse 
//thru the string and break into begin and end date. Use ai_tbl_no to determine the 
//dates for that table from the lds_ros_dir created in ue_create_where().  If the 
//payment_date is needed (does not encompass entire month), then add it to the WHERE 
//clause passed in. Use the logic in fx_remove_pay_date() to determine if date 
//entered by user covers the entire month.  If the payment date does cover the 
//month do not add to ls_where[], if it covers only part of the month, then it 
//must be added. Also must check for valid date and valid operator. 

integer 	li_exp1_count, 			&
			li_row,						&
			li_comma,					&
			li_rowcount
string 	ls_exp1,						&
			ls_find,						&
			ls_col,						&
			ls_operator,				&
			ls_value,					&
			ls_filter

// MikeFl 10/17/2002 Track 4730d
datetime	ldt_date
int		li_idx, li_pos
string	ls_date_string

//Get description of payment date column	

datawindowchild ldwc_exp_one
idw_criteria.getchild('expression_one',ldwc_exp_one)
li_exp1_count = ldwc_exp_one.rowcount()
ls_exp1 = trim(idw_criteria.getitemstring(ai_row_num,'expression_one'))
ls_find = "col_name = '" + ls_exp1 + "'"		//12-30-97	FNC

//Find the row that contains the payment date criteria
li_row = ldwc_exp_one.find(ls_find,1,li_exp1_count)
if li_row > 0 then
	ls_col = trim(ldwc_exp_one.getitemstring(li_row,'col_name'))		// FDG 04/06/98
else
	messagebox('ERROR','Cannot determine payment date field in u_nvo_create_sql.ue_create_where_add_payment_date. Cannot continue processing query')
	idw_criteria.ScrollToRow(ai_row_num)			// FDG 06/15/98
	return -100
end if

//Retrieve the the operator
ls_operator = upper (idw_criteria.getitemstring(ai_row_num,'relational_op') )

//Retrieve the date value and determine if it is a valid date
ls_value = trim(idw_criteria.getitemstring(ai_row_num,'expression_two'))

// MikeF 10/18/2002 Track 4730c - Begin
CHOOSE CASE ls_operator
		
	CASE '=','>','>=','<','<=','NOT ='
		
		IF isdate(ls_value) then
			ldt_date = datetime(date(ls_value))
			as_where = " AND " + ls_col + " " + ls_operator + " " + gnv_sql.of_get_to_date( String( ldt_date, 'mm/dd/yyyy' ) )
		ELSE
			messagebox('ERROR','Date entered is invalid. Cannot continue processing query in ue_create_where_add_payment_date.')
			idw_criteria.ScrollToRow(ai_row_num)			
			return -101
		END IF

	CASE 'BETWEEN','><'
		
		li_comma = pos(ls_value,',')
		as_where = " AND " + ls_col + " between " 
		
		ls_date_string = left(ls_value,li_comma - 1)
		if isdate(left(ls_value,li_comma - 1)) then
			ldt_date	= datetime(date(left(ls_value,li_comma - 1)))
			as_where	= as_where + gnv_sql.of_get_to_date( String( ldt_date, 'mm/dd/yyyy 00:00:00' ) ) + " and " 
		else
			messagebox('ERROR','Begin date entered is invalid. Cannot continue processing query in u_nvo_create_sql.ue_create_where_add_payment_date.')
			idw_criteria.ScrollToRow(ai_row_num)			
			return -101
		end if

		ls_date_string = mid(ls_value,li_comma + 1)
		if isdate(mid(ls_value,li_comma+1)) then
			ldt_date = datetime(date(mid(ls_value,li_comma+1)))
			as_where	= as_where + gnv_sql.of_get_to_date( String( ldt_date, 'mm/dd/yyyy 23:59:59' ) )
		else
			messagebox('ERROR','End date entered is invalid. Cannot continue processing query in u_nvo_create_sql.ue_create_where_add_payment_date.')
			idw_criteria.ScrollToRow(ai_row_num)			
			return -101
		end if

	CASE 'IN', 'NOT IN'
		
		li_comma = pos(ls_value,',')
		as_where = " AND " + ls_col + " " + ls_operator + " ("
		
		DO WHILE li_comma > 0
		
			if isdate(trim(left(ls_value,li_comma - 1))) then
				ldt_date = datetime(date(trim(left(ls_value,li_comma - 1))))
				as_where = as_where + gnv_sql.of_get_to_date( String( ldt_date, 'mm/dd/yyyy' ) ) + ','
			else
				messagebox('ERROR','Invalid Date. Cannot continue processing query in u_nvo_create_sql.ue_create_where_add_payment_date.')
				idw_criteria.ScrollToRow(ai_row_num)
				return -101
			end if

			ls_value = mid(ls_value,li_comma + 1)
			li_comma = pos(ls_value,',')
			li_idx++

		LOOP		
	
		IF isdate(trim(ls_value)) THEN
			ldt_date = datetime(date(trim(ls_value)))
			as_where = as_where + gnv_sql.of_get_to_date( String( ldt_date, 'mm/dd/yyyy' ) ) + ')'
		ELSE
			messagebox('ERROR','Invalid Date. Cannot continue processing query in u_nvo_create_sql.ue_create_where_add_payment_date.')
			idw_criteria.ScrollToRow(ai_row_num)
			return -101
		END IF
	
END CHOOSE

return 1
end event

event type integer ue_create_where_check_indexes();//*********************************************************************************
// Event Name:	U_NVO_Create_SQL.UE_Create_Where_Check_Indexes
//	Arguments:	None
// Returns:		Integer
//
//*********************************************************************************
// 12-10-97 FNC	Created
//	02/03/98	FDG	Call of_check_status() after each embedded SQL.
//	03/06/98	FDG	Track 902.  Super Provider Query changes.
//						1. Retrieve column names instead of column numbers.
//						2. If the column is a super provider query ('SuperPv'), 
//						then get the columns from istr_prov_query.prov_fields.
//	05/04/98	FDG	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'
//	06/12/98	FDG	Track ????.  Use the registered prov_query structure.
//	09/29/00	FDG	Track 3004c.  Stars 4.6.  Make the arrays unbounded (from 25) so
//						that more than 25 lines of criteria can be entered.
//	12/11/01	FDG	Track 2463d.  Even if the query has 'OR', return 1 (has index) if
//						another column uses an index.
//	09/06/02	GaryR	Track 3304d	Do not process blank lines in criteria
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
//*********************************************************************************

/*This function will loop through the columns to determine if any columns have indexes.  
If all 'AND' logical operators are selected will return 1 if one column has an index.  
If there is an 'OR' operator, the expressions before and after it must have indexes 
to return 1.  Else return 0.  If there is an error, return -1.  Take code from 
w_drilldown_parent.wf_check_index(). Also will have to change the return values.*/

int 		li_row, 					&
			li_rowcount,			&
			li_logical_count,		&
			li_logical_AND,		&
			li_logical_OR,			&
			li_prov_count,			&
			li_prov_upper
String 	ls_exp_one,				&
			ls_exp_oneindx[],		&
			ls_logical[],			&
			ls_exp_one_tbl_type,	&
			ls_expression_one
Boolean 	lb_all_field_indexed = true
Boolean	lb_one_field_indexed

/*Read dictionary to find out if the exp One in DW is an indexed field also counts 
the type of logical operator */

li_rowcount = idw_criteria.rowcount()
For li_row = 1 to li_rowcount
	//	FDG 03/06/98 begin
	ls_expression_one	=	Trim (idw_criteria.getitemstring(li_row,'expression_one'))
	//	09/06/02	GaryR	Track 3304d
	IF IsNull( ls_expression_one ) OR Trim( ls_expression_one ) = "" THEN Continue
	
	ls_exp_one_tbl_type = left(ls_expression_one,2)
	ls_exp_one = mid(ls_expression_one,4)
	ls_logical[li_row] =  idw_criteria.getitemstring(li_row,'logical_op')
	If	Upper (ls_exp_one)	=	'SUPER PROVIDER'	THEN				// FDG 05/04/98
		//	Column is "super provider" - get the super provider columns
		//	from uo_query.istr_prov_query.prov_fields.
		ls_exp_one			=	''				// Reset the column name
		//lstr_prov_query	=	iuo_query.of_get_str_prov_query()		// FDG 06/12/98
		li_prov_upper		=	UpperBound (istr_prov_query.prov_fields)
		FOR li_prov_count	=	1	TO	li_prov_upper
			IF	istr_prov_query.prov_fields[li_prov_count].Selected	THEN
				ls_exp_one	=	istr_prov_query.prov_fields[li_prov_count].prov_col_name
				Exit
			END IF
		NEXT
		IF	Trim (ls_exp_one)		=	''		THEN
			MessageBox ('Error', 'Please select a column for Super Provider.')
			idw_criteria.ScrollToRow (li_row)
			Return -100
		END IF
	End If
	//	FDG 03/06/98 end	
	
	//	Super NPI Provider
	If	Upper (ls_exp_one)	=	'SUPER NPI PROVIDER'	THEN				// FDG 05/04/98
		//	Column is "super provider" - get the super provider columns
		//	from uo_query.istr_npi_prov_query.prov_fields.
		ls_exp_one			=	''				// Reset the column name
		li_prov_upper		=	UpperBound (istr_npi_prov_query.prov_fields)
		FOR li_prov_count	=	1	TO	li_prov_upper
			IF	istr_npi_prov_query.prov_fields[li_prov_count].Selected	THEN
				ls_exp_one	=	istr_npi_prov_query.prov_fields[li_prov_count].prov_col_name
				Exit
			END IF
		NEXT
		IF	Trim (ls_exp_one)		=	''		THEN
			MessageBox ('Error', 'Please select a column for Super NPI Provider.')
			idw_criteria.ScrollToRow (li_row)
			Return -100
		END IF
	End If
	
	If ls_exp_one <> '' then
		lb_one_field_indexed = gnv_dict.event ue_get_is_indexed(ls_exp_one_tbl_type,ls_exp_one )
	End If
	If trim(ls_logical[li_row]) <> '' then
		li_logical_count++
		if ls_logical[li_row] = 'AND' then
			li_logical_AND++
		Else
			li_logical_OR++
		End If
	End If
Next

//There is no logical operator in the DW
If li_logical_count = 0 then
	If lb_one_field_indexed = true then
		return 1
	Else
		return 0
	End If
End IF

//If all logical Operators are 'AND' then at least one field must be indexed
//If all logical Operators are 'OR' then all fields must be indexed
If li_logical_count = li_logical_AND then
	if  lb_one_field_indexed = true then
		 RETURN 1
	Else
		 RETURN 0
	End IF
Elseif li_logical_count = li_logical_OR then
		if lb_all_field_indexed  = true then
			return 1
		Else
			return 0
		End IF
End IF 

//There is a mix of AND's and OR's in the logical operators
//For expressions around operators AND at least one of the fields must be indexed
//for expressions around operators OR all the fields must be indexed

//	09/06/02	GaryR	Track 3304d - Begin
//For li_row = 1 to (li_rowcount - 1)
li_rowcount = UpperBound( ls_exp_oneindx ) - 1
For li_row = 1 to li_rowcount
//	09/06/02	GaryR	Track 3304d - End	
	 If ls_logical[li_row] = 'AND' then
		 If ls_exp_oneindx[li_row] = 'I' or ls_exp_oneindx[li_row + 1] = 'I' then
			 //Continue							// FDG 12/11/01
			 Return	1							// FDG 12/11/01
		 //Elseif ls_logical[li_row + 1] = 'AND' then
		 //		Continue
		 //Else
		 //	   Return 0
		 //End If
		ELSE
			Continue
		END IF
	 Else
		 If ls_exp_oneindx[li_row] = 'I' and ls_exp_oneindx[li_row + 1] = 'I' then
			 Return	1
		 Else
		    Continue
		 End If

	 End If
Next

Return 0

end event

event type integer ue_create_where_ml_subset_add_dependent(ref string as_where[], ref string as_inv_type, ref string as_join[]);//*********************************************************************************
// Event Name:	U_NVO_Create_Sql.ue_create_where_ml_subset_add_dependent
//	Arguments:	String	as_where[]
//					String	as_inv_type
//					String	as_join[]
// Returns:		Integer
//
//*********************************************************************************
// 12-10-97 FNC	Created
// 03-31-98 FNC 	Track 912 - 1. Use as_inv_type for the stars_rel filter instead of
//						iuo_query.is_inv_type.
//						2.Determine if there is already a where statement for	prefilter
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//	11/21/00	FDG	Stars 4.7.  Make the SQL DBMS-independent.
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//*********************************************************************************

/*This event is called in ue_create_sql while looping thru the invoice_types.  
If during the building of the select statement it is determined that a dependent 
join is required because this is viewing an ML subset which contains dependent 
columns on the report.  If this is true the as_join array will be populated with 
dependents that need to be joined to the main tables.  A join clause must be added 
to the where statement for each dependent. */

integer	li_rowcount,		&
			li_join_count,		&
			li_row,				&
			li_outer,			&
			li_where,			&
			li_rc
string	ls_filter,			&
			ls_dep_type,		&
			ls_key[],			&
			ls_where_string
			
n_ds		lds_unique_keys

li_rowcount = upperbound(as_where)
li_join_count = upperbound(as_join)
// FNC 02/08/00 Start
lds_unique_keys = create n_ds
lds_unique_keys.dataobject = 'd_table_indexes'
li_rc = lds_unique_keys.settransobject(stars2ca)

if li_rc = -1 then 
	messagebox('ERROR','Error setting trans object in u_nvo_create_sql.ue_create_where_ml_subet_add_dependent')
	destroy(lds_unique_keys)	
	return -1
end if

li_rowcount = lds_unique_keys.retrieve(as_inv_type)

if li_rowcount < 0 then 
	destroy(lds_unique_keys)
	return -1
end if

stars2ca.of_commit()							

for li_row = 1 to li_rowcount
	ls_key[li_row] = lds_unique_keys.getitemstring(li_row,'elem_name')
next

/* can only join to one dependent so as_join will only ever contain 1 value */
for li_row = 1 to li_rowcount
	ib_outer_join	=	TRUE
	li_outer	=	UpperBound (is_outer_column1)
	li_outer	++
	is_outer_table1[li_outer]	=	gnv_dict.Event	ue_get_table_name(as_inv_type)
	is_outer_table2[li_outer]	=	gnv_dict.Event	ue_get_table_name(as_join[1])
	is_outer_column1[li_outer]	=	ls_key[li_row]
	is_outer_column2[li_outer]	=	ls_key[li_row]
	is_outer_alias1[li_outer]	=	as_inv_type
	is_outer_alias2[li_outer]	=	as_join[1]
	ls_where_string	=	gnv_sql.of_left_outer_join_where	(is_outer_table1[li_outer],	&
																			is_outer_column1[li_outer],	&
																			is_outer_alias1[li_outer],		&
																			is_outer_table2[li_outer],		&
																			is_outer_column2[li_outer],	&
																			is_outer_alias2[li_outer])
	is_outer_from[li_outer]	=	gnv_sql.of_left_outer_join_from	(is_outer_table1[li_outer],	&
																			is_outer_alias1[li_outer],		&
																			is_outer_table2[li_outer],		&
																			is_outer_alias2[li_outer])
	IF	Trim (ls_where_string)	>	''		THEN
		// UDB will not have a where clause
		ls_where_string	=	"("	+	ls_where_string	+	")"
		li_where	++
		if li_where = 1 then
			as_where[li_where] = " WHERE " + ls_where_string
		else
			as_where[li_where] = " AND " + ls_where_string
		end if
	END IF
	//	FDG 11/21/00 end
next

destroy(lds_unique_keys)

return 0
end event

event ue_create_where_subset_view(ref string as_where[]);//*********************************************************************************
// Event Name:	U_NVO_Create_Sql.UE_Create_Where_Subset_View
//	Arguments:	String	as_where[]
// Returns:		None
//
//*********************************************************************************
// 12/10/97 FNC	Created
// 04/16/98 FNC	Track 1078 1.If revenue is in additional data source must open the
//						prefilter window.
//						2. Don't send back 'ERROR' if the user clicked cancel. This causes
//						an error when the sql is executed.
// 06/09/98 FNC	Track 1137. Don't put 'WHERE' on here. There might be an additional
//						where statement if user selected a dependent data source. Add
//						'WHERE' after call event to check for dependent.
// 06/17/98			Set as_where[1] to CANCEL if user clicks cancel on prefilter window.
// 07/20/98 AJS   4.0 track #1524; handle ignore from w_prefilter_ub92
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks,
// 01/17/02 FNC	Track 2706. Correct parsing of data returned from the prefilter window.
// 01/23/02 LMC   Track 2628  Check for Q in inv_type before additional data source processing.
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//*********************************************************************************


/*Will use the subset_id passed into w_query_engine to create a where clause 
that selects all from the subset.  This is where pre-filter window will open if
necessary. If the table selected from source is revenue (FastTrack) then will 
open the prefilter window.  The window will determine if the subset contains 
criteria for Revenue_Code or HCPCS_Codes.  It there is, it will display the 
criteria for the user to select.  When the window returns it passes the where 
clause selected and the number of filters (if used) in the criteria.  Must add 
the criteria and filter (if any) clauses to the WHERE.  The code for the 
pre-filter window is taken from w_subset_cols.wf_create_col_from_where().
Note: w_prefilter_ub92 is changing with Subset Redesign, so may have changes.*/

string	ls_base_type,	&
			ls_prefix,		&
			ls_rev_inv_type,	&
			ls_add_data_source
			
Integer	li_parser,	&
			li_current_source_row
			
n_cst_prefilter_attrib lnv_cst_prefilter_attrib;

			
//FNC 04/16/98 Start
n_cst_revenue lnvo_cst_revenue

lnvo_cst_revenue  = Create n_cst_revenue

ls_base_type = lnvo_cst_revenue.of_get_base_type(is_inv_type)

/* If additional data source is revenue or FT so must open pre-filter */
if ls_base_type = 'UB92' then
	if left(is_inv_type,1) = 'Q' then //LMC 01/23/02
		ls_prefix = is_inv_type
	else
		ls_rev_inv_type = lnvo_cst_revenue.of_get_revenue(is_inv_type)
		li_current_source_row = idw_source.getrow()
		ls_add_data_source = trim(idw_source.object.add_data_source[li_current_source_row])
		if ls_rev_inv_type = left(ls_add_data_source,2) then
			ls_prefix = ls_rev_inv_type
		else
			Destroy	lnvo_cst_revenue			// FDG 12/06/01
			return
		end if
	end if
else
	return
end if
//FNC 4/16/98 End
	
/* At this point must be fastrack or selected revenue as additional data source */
IF UpperBound( ii_prefilter_rows ) > 0 THEN
	lnv_cst_prefilter_attrib.is_where = "SS~~t" + ls_prefix + ".~~t" + is_source_subset_id
ELSE
	lnv_cst_prefilter_attrib.is_where = "SS~~t" + ls_prefix + ".~~t" + is_subset_id		//04/16/98 FNC
END IF
lnv_cst_prefilter_attrib.ii_selected_rows = ii_prefilter_rows
lnv_cst_prefilter_attrib.is_boolean = is_prefilter_bool
openwithparm(w_prefilter_ub92,lnv_cst_prefilter_attrib)
lnv_cst_prefilter_attrib = message.PowerObjectParm
setnull(message.PowerObjectParm)
if lnv_cst_prefilter_attrib.is_where = "CANCEL" then 
	as_where[1] = "CANCEL"			//FNC 04/16/98, 06/17/98
	Destroy	lnvo_cst_revenue			// FDG 12/06/01
	return 
end if
// AJS 07/20/98 4.0 track #1524
if lnv_cst_prefilter_attrib.is_where = "IGNORE" then 
	//
else
	if len(lnv_cst_prefilter_attrib.is_where) > 0 then /* returned a filter */
		ii_sub_filter_count = lnv_cst_prefilter_attrib.ii_filter_count
		li_parser = pos(trim(lnv_cst_prefilter_attrib.is_where),"AND")
//		if li_parser = 3 then  /*remove 1st AND if necessary*/
		if li_parser > 0 then		//FNC 01/17/02
			lnv_cst_prefilter_attrib.is_where = mid(lnv_cst_prefilter_attrib.is_where,li_parser + 4)
//			as_where[1] = 'WHERE ' + ls_prefilter
			as_where[1] = lnv_cst_prefilter_attrib.is_where			// FNC 06/09/98
		end if
	end if
end if

Destroy	lnvo_cst_revenue			// FDG 12/06/01

return


end event

event ue_create_order_by;//*********************************************************************************
// Event Name:	U_NVO_Create_SQL.UE_Create_Order_By
//	Arguments:	None
// Returns:		String
//
//*********************************************************************************
// 12-04-97 FNC 	Created
//	10/02/01	GaryR	Track 2448d	Do not add order by if name is empty.
//										This causes a syntax error when building the report.
//*********************************************************************************

/*This event is called from ue_create_sql only if Break with Totals has been 
selected for the report and this sql is not being used for a count.  This 
event will use the columns in the Break structure (sx_break_info - defined 
in ts144 - Break with Totals) to build the order by clause.*/

string ls_order_by
integer li_count,li_break_col,li_len

//	10/02/01	GaryR	Track 2448d - Begin
integer	li_new_ctr
sx_break_info	lstr_break_info
//	10/02/01	GaryR	Track 2448d - End

ls_order_by = "ORDER BY "
li_count = upperbound(this.istr_break_info.cols)
for li_break_col = 1 to li_count
	//	10/02/01	GaryR	Track 2448d - Begin	
	//Testing comment Gary's code
//	IF Trim( this.istr_break_info.cols[li_break_col].col_name ) = "" THEN Continue
//	li_new_ctr ++
//	
//	lstr_break_info.cols[li_new_ctr] = this.istr_break_info.cols[li_break_col]
//	lstr_break_info.cols[li_new_ctr].col_number = String( li_new_ctr )
	//	10/02/01	GaryR	Track 2448d - End
		ls_order_by = ls_order_by + this.istr_break_info.cols[li_break_col].col_name + &
			" " + this.istr_break_info.cols[li_break_col].sort + ","
next
li_len = len(ls_order_by)
ls_order_by = left(ls_order_by,li_len - 1) /* remove last ',' */

//	10/02/01	GaryR	Track 2448d - Begin
//this.istr_break_info.cols = lstr_break_info.cols
IF Trim( ls_order_by ) = "ORDER BY" THEN ls_order_by = ""
//	10/02/01	GaryR	Track 2448d - End

return ls_order_by	
end event

event type integer ue_subsetting_fill_step_info(datetime ad_from_date, datetime ad_thru_date, string as_inv_type, string as_add_inv_type, integer ai_step);//*********************************************************************************
// Event Name:	U_NVO_Create_SQL.UE_subsetting_fill_step_info
//	Arguments:	String	as_inv_type
//					String	as_join[]
// Returns:		integer
//
//*********************************************************************************
// 12-04-97 FNC	Created
// 04-02-98 FNC	Track 1020 Change subset_id to subset_name
// 04/21/98	FNC	Track 1020 Must translate subset name into subset id and move
//						subset id into the input_id
// 06/11/98	FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
// 11/06/00	GaryR	Track 3030c	Fill in additional data source in criteria table
//	12/10/02	GaryR	Track 3030c	Account for ML subsets
//	03/24/06	GaryR	Track 4522	Trim case NONE to reflect renamed Subsets in PDQs
//*********************************************************************************

/*This event is called from ue_create_sql only if subsetting.  It will fill in all 
the variables for this step needed to be passed to the Subset Options window.  This 
event will load the sx_step_info structure in the instance variable 
(istr_subsetting_info) for this level except the sql statement.  The SQL statement
will be loaded once it has been strung together in the subsetting event. */

String	ls_case_key
integer li_rc
NVO_Subset_Functions LNVO_Subset_Functions
SX_Subset_Ids	lstr_subset_ids

istr_subsetting_info.subset_step[ai_step].paid_from_date = ad_from_date
istr_subsetting_info.subset_step[ai_step].paid_thru_date = ad_thru_date
istr_subsetting_info.subset_step[ai_step].inv_type = as_inv_type

// 11/06/2000	GaryR	3030c begin
IF IsNull( as_add_inv_type ) OR Trim( as_add_inv_type ) = "" THEN
	as_add_inv_type = " "
ELSE
	as_add_inv_type = Left( as_add_inv_type, 2 )
END IF
istr_subsetting_info.subset_step[ai_step].addtl_data_source = as_add_inv_type
// 11/06/2000	GaryR	3030c end

/* if creating ML subset subset_type will be changed to ML when put levels together 
else will be MC or single invoice type */
istr_subsetting_info.subset_step[ai_step].subset_type = is_inv_type
istr_subsetting_info.subset_step[ai_step].input_type = is_data_type
if is_data_type = "SUBSET" then
	//04/21/98 FNC Start
	LNVO_Subset_Functions = Create NVO_Subset_Functions
	lstr_subset_ids.subset_name = idw_source.getitemstring(1,'subset_name')	//04-02-98 FNC
	lstr_subset_ids.subset_case_id = left(idw_source.getitemstring(1,'case_id'),10)
	if lstr_subset_ids.subset_case_id = 'NONE' then
		lstr_subset_ids.subset_case_spl = ''
		lstr_subset_ids.subset_case_ver = ''
	else
		lstr_subset_ids.subset_case_spl = mid(idw_source.getitemstring(1,'case_id'),11,2)
		lstr_subset_ids.subset_case_ver = right(idw_source.getitemstring(1,'case_id'),2)
	end if
	lnvo_subset_functions.uf_set_structure(lstr_subset_ids)
	li_rc = lnvo_subset_functions.uf_retrieve_subset_id()
	if li_rc = 1 then
		lstr_subset_ids = lnvo_subset_functions.uf_get_structure()
		destroy (lnvo_subset_functions)
	elseif li_rc = 0 then
		messagebox('ERROR','Cannot retrieve subset name from case link table. Select another subset')
		destroy (lnvo_subset_functions)
		return -1
	else
		destroy (lnvo_subset_functions)
		return -1
	end if
	istr_subsetting_info.subset_step[ai_step].input_id = &
	lstr_subset_ids.subset_id
	ls_case_key = lstr_subset_ids.subset_case_id + &
				lstr_subset_ids.subset_case_spl + lstr_subset_ids.subset_case_ver
	gnv_sql.of_trimdata( ls_case_key )
	istr_subsetting_info.subset_step[ai_step].subc_sub_src_case_id = ls_case_key
		
	//04-21-98 FNC	End
	istr_subsetting_info.subset_step[ai_step].subc_sub_src_type = "SS"
else
	istr_subsetting_info.subset_step[ai_step].subc_sub_src_type = "SB"
end if

return 0
end event

event ue_replace_mc_where;call super::ue_replace_mc_where;//*********************************************************************************
// Event Name:	U_NVO_Create_Sql.UE_Replace_MC_Where
//					
//	Arguments:	Data Type	Name					Passed By
//					String		as_new_where[]		Reference
//					String		as_inv_type			Value
//
// Returns:		None
//
//*********************************************************************************
// 03-05-98 FNC	Created
//*********************************************************************************
//This event is called from U_NVO_Create_SQL when the user has selected MC as a 
//data source. This event will loop through the where statement and replace MC with
//the invoice type of the current step that was passed in as an argument.
//*********************************************************************************

integer li_num_where, li_where_idx
long ll_pos

li_num_where = upperbound(as_new_where)

For li_where_idx = 1 to li_num_where
	/*Find first MC */
	ll_pos = pos(as_new_where[li_where_idx],'MC.')
	
	Do while ll_pos > 0
		/* Replace old_str with new_str.*/
		as_new_where[li_where_idx] = Replace(as_new_where[li_where_idx], &
												ll_pos, 2, as_inv_type)
		/* Identify next MC to be replaced*/
		ll_pos = Pos(as_new_where[li_where_idx], 'MC.', ll_pos + 3)
	Loop
Next

		
end event

event type string ue_add_key_cols_to_select(ref string as_select, ref integer ai_rowcount, string as_tbl_type);//*********************************************************************************
// Event Name:	u_nvo_create_sql.UE_Add_Key_Cols_To_Select
//	Arguments:	String	as_select
//					integer	ai_rowcount
// Returns:		String
//
//	Description:
//	This event will be called by ue_create_select() and 
//	ue_tabpage_view_create_ML_dw_sql() to add key columns not selected by the user.  
//	If coming from ML will set ai_rowcount to zero so do not update the key column 
//	structure since already done in ue_create_select().*/
//
//*********************************************************************************
// 12-10-97 FNC	Created
// 02-05-98 FNC 	If drilldown the alias for the temp table fields should be the
//						temp table alias.
//	03-19-98 JGG	STARS 4.0, TS145 - Revenue.  Remove CR hard coding.
// 04-13-98 HRB	per JGG's note of 3/19/98, also commented out code in
//                u_nvo_view.ue_tabpage_view_get_key_columns - track 1006
//	05/27/98	FDG	Track 1286.  Move script from uo_query.
//	06/05/98	FDG	Track 1302.  If coming from drilldown, do NOT change the 
//						tbl_type to 'TMP' (IC_TEMP_ALIAS).  The from and 'WHERE'
//						clauses should handle the 'TMP' columns.
// 06/11/98	FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	06/15/98	FDG	Track ????.  Move script from u_nvo_search.
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
// 10/12/00 FNC	Track 3017 Add revenue code as a key column for select statement. 
//						it is being set as a key column when they table type is CR for drilldown
//						but it is not being added to the select statement.
//	08/02/01	FDG	Track ???? (STARS 4.6 SP1).  Get the columns selected and
//						store them in an instance array to be returned to u_nvo_view
//	04/18/03	GaryR	Track 3522d	Get the key columns from the main query
//*********************************************************************************


Integer	li_next_col_number,		&
			li_idx
String	ls_inv_type

li_idx					=	UpperBound(is_select_column)		// FDG 08/02/01
li_next_col_number 	= 	ai_rowcount + 1

IF ib_drilldown AND istr_drilldown.path = "AD" THEN as_tbl_type = "TMP"
if istr_key_columns.icn.col_number > 0 and istr_key_columns.icn.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.icn.col_name
	li_idx	++																		// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.icn.col_name		// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.icn.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

// FNC 02/08/00 Start
if istr_key_columns.icn_key2.col_number > 0 and istr_key_columns.icn_key2.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.icn_key2.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.icn_key2.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.icn_key2.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.icn_key3.col_number > 0 and istr_key_columns.icn_key3.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.icn_key3.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.icn_key3.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.icn_key3.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.icn_key4.col_number > 0 and istr_key_columns.icn_key4.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.icn_key4.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.icn_key4.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.icn_key4.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.icn_key5.col_number > 0 and istr_key_columns.icn_key5.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.icn_key5.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.icn_key5.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.icn_key5.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.icn_key6.col_number > 0 and istr_key_columns.icn_key6.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.icn_key6.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.icn_key6.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.icn_key6.col_number = li_next_col_number
		li_next_col_number++
	end if
end if
// FNC 02/08/00 End

if istr_key_columns.date_paid.col_number > 0 and istr_key_columns.date_paid.visible = FALSE then

	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.date_paid.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.date_paid.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.date_paid.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.from_date.col_number > 0 and istr_key_columns.from_date.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.from_date.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.from_date.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.from_date.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.recip_id.col_number > 0 and istr_key_columns.recip_id.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.recip_id.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.recip_id.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.recip_id.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.prov_id.col_number > 0 and istr_key_columns.prov_id.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.prov_id.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.prov_id.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.prov_id.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

if istr_key_columns.allowed_srvc.col_number > 0 and istr_key_columns.allowed_srvc.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.allowed_srvc.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.allowed_srvc.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.allowed_srvc.col_number = li_next_col_number
		li_next_col_number++
	end if
end if

//FNC 10/12/00 Start
if istr_key_columns.rev_code.col_number > 0 and istr_key_columns.rev_code.visible = FALSE then
	as_select = as_select + "," + as_tbl_type + "." + &
		istr_key_columns.rev_code.col_name
	li_idx	++																			// FDG 08/02/01
	is_select_column[li_idx]	=	istr_key_columns.rev_code.col_name	// FDG 08/02/01
	if ai_rowcount > 0 then
		istr_key_columns.rev_code.col_number = li_next_col_number
		li_next_col_number++
	end if
end if
// FNC 10/12/00 End


if is_inv_type = 'ML' or is_inv_type = 'MC' then
	if istr_key_columns.invoice_type.col_number > 0 and istr_key_columns.invoice_type.visible = FALSE then
		as_select = as_select + "," + as_tbl_type + "." + &
			istr_key_columns.invoice_type.col_name
		li_idx	++																			// FDG 08/02/01
		is_select_column[li_idx]	=	istr_key_columns.invoice_type.col_name	// FDG 08/02/01
		if ai_rowcount > 0 then
			istr_key_columns.invoice_type.col_number = li_next_col_number
			li_next_col_number++
		end if
	end if
end if

return as_select

end event

event ue_get_paid_date_values;//	int ue_get_paid_date_values(string as_value,
//				string as_operator)
//
//	This event is called by ue_create_sql().  
//	It will loop thru dw_criteria and look for the paid date.  
//	It will return error (-1) if finds more than one paid date.  
//	It will load paid date values and operator into the arguments. 
//	Returns row number if payment date is found else it return 0.

//**********************************************************************************
// 12-30-97	FNC	Change ls_find to use col_name instead of col_desc. The value that
//						ls_col is set to is col_name because the data value of expression one
//						is col_name. The display value is col_desc.
//	12-30-97			Row number is equal to i. Change from li_row to i because li_row refers
//						to the row in the expression one dddw.
//	01-28-98	FDG	Changed variable i to ll_idx.  Made integers longs for d/w rows.
// 04/06/98	FDG	Track 1039.  Make sure that the find worked before trying to
//						access the corresponding data in the DDDW.  Also, do not perform
//						the Find if there is no data in the row of criteria.
//	06/15/98	FDG	Track ????.  Don't directly access uo_query attributes.
//						Script moved from u_nvo_search.ue_tabpage_search_get_paid_date_values
//	07/05/01	GaryR	2357d	Prevent the use of LIKE or NOT LIKE operands with date fields
//**********************************************************************************

integer li_exp1_count
datawindowchild ldwc_exp_one
string ls_col, ls_find
Long		ll_idx,			&
			ll_rowcount,	&
			ll_row,			&
			ll_paid_row,	&
			ll_pos

idw_criteria.getchild('expression_one',ldwc_exp_one)
li_exp1_count = ldwc_exp_one.rowcount()
ll_rowcount = idw_criteria.rowcount()

for ll_idx = 1 to ll_rowcount
	ls_col = trim(idw_criteria.object.expression_one[ll_idx])
	IF	Trim	(ls_col)		<	' '			THEN
		// This row of criteria does not have any valid data.
		// Ignore this row.
		Continue
	END IF
	ls_find = "col_name = '" + ls_col + "'"						//12-30-97 FNC
	ll_row = ldwc_exp_one.find(ls_find,1,li_exp1_count)
	// FDG 04/06/98 begin
	IF	ll_row	<	1		THEN
		// column not found in DDDW
		MessageBox ('Application Error', 'Expression_one value in row ' + String(ll_idx) + &
						' was not found in script u_nvo_create_sql.ue_tabpage_search_get_paid_date_values.' + &
						'  Find string = ' + ls_find + '.')
		Return -1
	ELSE
		ls_col = mid(ldwc_exp_one.getitemstring(ll_row,'col_name'),4)		// FDG 04/06/98
		if ls_col = "PAYMENT_DATE" then
			if ll_paid_row > 0 then
				MessageBox('Error','The query contains multiple paid dates. ' &
					+ 'Only one paid date is allowed.',StopSign!,Ok!)
				idw_criteria.ScrollToRow(ll_idx)							// FDG 04/09/98
				return -100
			end if
			as_value = idw_criteria.GetItemString(ll_idx,'expression_two')		//12-30-97 FNC
			as_operator = idw_criteria.GetItemString(ll_idx,'relational_op')		//12-30-97 FNC
			as_operator = Upper(as_operator)
			
			//	07/05/01	GaryR	2357d - Begin
			IF as_operator = 'LIKE' OR as_operator = 'NOT LIKE' THEN
				messagebox( 'INVALID OPERAND','An invalid operand was entered for PAYMENT_DATE' )
				idw_criteria.ScrollToRow(ll_idx)
				return -100
			END IF
			//	07/05/01	GaryR	2357d - End
			
			ll_paid_row = ll_idx
		end if
	END IF
	// must continue to loop thru the datawindow to make sure 
	// only one payment date
next
//
return ll_paid_row
end event

event type any ue_format_where_criteria(string as_type, boolean ab_add_payment_date, ref string as_where[], ref sx_criteria astr_criteria[]);//*********************************************************************************
// Event Name:	u_nvo_create_sql.ue_Format_Where_Criteria
//
//	Arguments:	String	as_type
//					Boolean	ab_add_payment_date
//					String	as_where[]  (by reference)
//					Sx_Criteria	astr_criteria[]  (by reference)
//
// Returns:		Integer (Negative returns go to u_nvo_query.ue_check_status)
//					-10	Display search tab & don't set focus to any object
//					-100	Set focus to expression_one
//					-101	Set focus to expression_two
//					-102	Set focus to relational_op
//					-103	Set focus to left_paren
//					-104	Set focus to right_paren
//
//	Description:
//	This is an overloaded event that will either 
//	format and create a WHERE clause or
//	format criteria and place it into the criteria 
//	structure.  This is determined by
//	the argument, as_type which can contain 'WHERE' 
//	or 'CRITERIA'.  If contains 
//	'WHERE' will format and load a WHERE clause into 
//	as_where.  If contains 'CRITERIA' 
//	it will load asx_criteria[].
//
//	If ab_add_payment_date is TRUE the where statement 
//	will include PAYMENT_DATE. When  
//	as_type = 'CRITERIA', ab_add_payment_date will 
//	always be TRUE.  
//	This event will be used to create the where 
//	clause, get criteria 
//	for criteria save and subset criteria.
//	Will loop thru, formatting each row into a clause.  
//	If the column is "SUPER PROVIDER" and as_type = "CRITERIA" must load 
//	the provider columns selected by the user (stored in isx_prov_query ) 
//	into the criteria using "OR" as logical operator.  
//	This does not get included in the WHERE clause since the SQL used 
//	to produce a Super Provider Query creates a separate SQL statement 
//	for each Provider column and strings them together using a UNION.  
//	This will be done during the execution of the SQL.
// 
//	This will also perform the edit checks.  This code is taken 
//	from w_drilldown_parent.wf_format_sql() which calls global functions 
//	format_where, format_where_d and format_where_n.  Will have to 
//	change wf_format_sql(), but not the global functions.  One thing 
//	added is when a filter is used in the criteria and if building the 
//	where for a subset, the filter id must be put into the subset 
//	structure (isx_subsetting_info).  
//
//	Also added are the edit checks for LIKE and Filters with Super 
//	Provider Queries.  Neither are allowed currently in the system.  
//	(Currently in Detail Analysis it allows you to enter a filter, 
//	it just does not resolve it and uses it as a literal ie 
//	prov_id = @provtest)
//	Returns 0 if successful, else returns -1.  
//	Note:  all checks for blanks should also check for NULLs 
//
//*********************************************************************************
// 12-10-97 FNC	Created
//	12-29-97 FNC	Changed column name in find to col_name instead of col_desc
//	01-30-98	FDG	1. Move the create of lds_dictionary to the beginning of the
//							script.
//						2. Changed j to li_j, k to li_k
//						3. Fixed a bug where if payment_date is removed from the last
//							where clause, 'AND' must be removed from the prior where
//							clause.
//	01/30/98	JTM	Added logic to correct array boundry error.
// 02/12/98 FNC	Add check to make sure that 1 row of criteria has been entered prior
//						to determining if exp2 for the first row has been entered.
//	02/26/98	FDG	When editing to see if criteria was entered, check 
//						for IsNull of expression_two.
//	03/02/98	FDG	Track 876.  Select the tab via an event
//	03/06/98	FDG	Track 920.  Get data from lds_dictionary before calling
//						fx_error_check_fields_for_dw.  For SuperPv, append the table_type
//						from istr_prov_query.
// 03/11/98	FNC	Test the find command to make sure that a row was located.
//	03/17/98	FDG	Track 871.  When deleting from dw_criteria, subtract 1 from
//						li_rowcount
//	03/19/98	FDG	Track 920.  Don't return -1 if no as_where[] occurences.
// 04/08/98 FNC	Track 993.	Remove blank line from criteria datawindow. When the 
//						search by tab is displayed a blank line is always added to the 
//						datawindow. This must be removed if the user does not enter anything
//						into it.
// 04/09/98 HRB	Track 987.  1.Add edit check not allowing multiple values for '='
//                2.formatting date values - the code taken from
//						w_drilldown_parent.wf_format_sql() is incorrect when it uses
//                format_where_d for date values, should use format_where instead.
//	04/10/98	FDG	Track 987.  When an error occurs, setfocus to the row/column
//						in error.
//	04/16/98	FDG	Track 971.  See if the filter exists by triggering 
//						w_query_engine.ue_check_filter_data_type instead of
//						fx_check_filter_datatype.  This new script will first check
//						the filter structure before reading filter_cntl.
//	05/04/98	FDG	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'
//	05/07/98	FDG	Track 1209.  If a filter is used, then the relational operator
//						must be '='.
//	05/20/98	FDG	Track 1244.  Perform an accepttext on dw_criteria because
//						w_query_engine's ue_accepttext does not handle the control
//						array for a drilldown uo_query.
//	05/22/98	FDG	Track 1272.  If you have a 'Like'/'Not Like' without a '%',
//						automatically add the '%' in expression_two.
//	05/27/98	FDG	Track 1286.  Move script from uo_query.
// 06/11/98 FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query.
//	06/30/98	FDG	All dates (not just date of birth) must have a 4 digit year.
//	07/24/98	FDG	Track 1477.  No matter where the '%' exists for a 'LIKE' or
//						'NOT LIKE', make sure there is a '%' in the last position.
//	07/29/98	FDG	Track 1477.  Undo changes to Track 1272.  Do not add '%' at
//						the end of LIKE/NOT LIKE.  Instead, display an error if '_'
//						or '%' is missing.
//	09/04/98	FDG	Track 1477.  If the relational operator is '=', then do not
//						allow a '%'.
// 09/08/98 AJS   Track 1477. Correct edit; do not allow a '_' or '%' when using
//                a relational operator of '=' or 'IN' or 'NOT IN'.
//	10/28/98	FDG	Track 1853.  When 'Like' is used, only accept one value.
//	12-08-98 AJS   Track #D2023 Added code from 3.6 to make the filter process 
//						a little flexible	
//	01/12/99	FDG	Track 2047c.  Y2K changes to edit for a 4-digit date.
//	04/04/00	FDG	Track 2841c.  The user was not allowed to enter more than 2 dates
//						while using 'IN'/'NOT IN'.  Date edits have been moved to
//						fx_error_check_fields_for_dw.
// 06/13/00 FNC	Track 2925 Starcare. The check for 'OR' and 'AND in the exp2 
//						value is obsolete and it causes problems if the value in exp2 has 
//						OR or AND in it. This was probably used in versions of stars below
//						stars 4.0.
//	07/12/00	FDG	Track 2365c.  Stars 4.5 SP1.  When using a filter, don't join
//						to filter_vals.  Instead, use filter_vals in a sub-select.
//	08/11/00	FDG	Track 2653d.  With a filter, allow a 'NOT IN'.
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
// 01/05/01	GaryR	Stars 4.7 DataBase Port - Date Conversion.
//	03/14/01	FDG	Stars 4.7.  If the where clause includes payment date, include
//						it in inv_base for future use.
// 04/20/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity.
//	06/15/01	GaryR	Stars 4.7 Make sure saved SQL is DBMS independent.
//	10/16/01	NLG	Stars 5.0 Col to col comparison
//	11/07/01	GaryR	Track 2527	Format values for Super Provider Queries.
//	11/12/01	FDG	Stars 5.0.	Allow for column-to-column comparison.
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks.
//	12/07/01	GaryR	Track 2565d	Do not mask dates if col to col comparison.
//	01/15/02	FDG	Track 2682d. If Super Provider was specified on a line other than
//						the last criteria line, add 'AND' to the logical operator.
// 2/4/02	LahuS Set exp2_field_or_value in structure Track 2552d
// 2/8/02   LahuS Check query engine mode
//	02/19/02	FDG	Track 2820d.  Make error message more descriptive.
//	04/24/02	GaryR	Track 2552d	Predefined Report (PDR)
//	12/06/02	GaryR	Track	3390d	User friendly criteria in PDRs
//	01/23/03	GaryR	Track 2353d	Encapsulate user criteria with parenthesis
//	01/31/03	GaryR	Track 3424d	Remove one line criteria validation for PDRs
//	01/31/03	GaryR	Track 3425d	Check if exp1 is also blank before deleting row
//	02/04/03	GaryR	Track 3429d	Allow filters in criteria for PDRs
//	03/03/03	GaryR	Track 3460d	Remove logic that errorneously searched value for operator
//	03/11/03	GaryR	Track 3445d	Convert character criteria to upper case
//	03/25/03	GaryR	Track 3491d	Do not add parenthesis if line is a retrieval argument
//	04/03/03	GaryR	Track 3505d	The subset row has changed in the dictionary
//	10/30/03	GaryR	Track 3686d	Do not bypass validation if criteria is required
//	11/20/03	GaryR	Track 3712d	Allow underscore in criteria with any operator in PDRs
// 09/16/04 Katie Track 4019d Do not allow field for exp 2 add SOUNDEX() around exp names 
//										for SOUNDS LIKE operator
// 10/22/04 MikeF	Track 3650d Computed columns.
//	11/19/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	12/20/04	GaryR	Track 4170d	Add Custom Criteria to PDRs and fix Soundex bug
// 12/22/04 Katie	Track 4176d Added code to retrieve computed columns formula for Soundex
// 02/28/05 MikeF Track 4327d Added additional evaluations for computed columns
//	05/02/05	GaryR	Track 4347d	Check if value is a filter with an underscore
// 07/07/05 Katie Track 3661d Added code to change criteria if keyword BLANKS is used
// 08/01/05 Katie Track 3661d Removed case sensitivity for keyword BLANKS
//	09/02/05	GaryR	Track 4492d	Accomodate trailing spaces in data
// 01/21/06 Jason Track 4524d Make Filters uppercase to make them case in-sensitive
//	01/23/06	HYL	Track 4619d	Unpaired or mismatched parentheses in criteria : ex : ()())) or ()())(
//	01/25/06	GaryR	Track 4626d	For ancillary invoices convert both sides of comparison
// 									to upper case to ensure case insensitivity.  Oracle only.
//	01/27/06	GaryR	Track 4626d	Support case insensitivity for column-to-column comparisons
//  02/15/06 JasonS  Track 4524d  remove Upper()from criteria array....mimic'd Gary's code from  starfix 4
// 	01/18/07	Katie	Track 4869/4845 Removed time from the date fields when use BETWEEN and = operands
//	03/05/07	Katie	Track 4869/4845 Fixed error with the ancillary table checking which was preventing the time
//						from being removed from dependant tables of ancillary subsets.
//	04/10/07 Katie Track 4978 Replaced missing subsetting criteria from date without time conditions.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
// 10/15/09 RickB LKP.650.5678.001 Added NOT IN and BETWEEN to the 'multiple values' message.
//*********************************************************************************

boolean 		lb_superpv,				&
				lb_superNPIpv,			&
				lb_is_field,			&
				lb_is_soundex,			&
				lb_is_computed,		&
				lb_is_blanks

integer 		li_count,				&
				li_dict_count, 		&
				li_exp1_count,			&
				li_j,						&
				li_k,						&
				li_left_paren_count,	&
				li_rc,					&
				li_right_paren_count, &
				li_row,					&
				li_rowcount, 			&
				li_sub,					&
				li_temp_pos,			&
				li_upper,				&
				li_pos,					&
				li_warned, 				&
				li_len,						&  
				li_start_pos = 1 // 01/20/06 HYL Track 4619d				

string 		ls_data_type,			&
				ls_type, 				&
				ls_dictionary_filter, &
				ls_exp1, 				&
				ls_exp2, 				&
				ls_filter_data_type,	&
				ls_filter_db,			&
				ls_filter_id,			&
				ls_filter_val,			&
				ls_filter_tbl_type,	&
				ls_filter_tbl_name,	&
				ls_find,					&
				ls_format_exp,			&
				ls_in,					&
				ls_left,					&
				ls_logic,				&
				ls_relop,				&
				ls_right,				&
				ls_temp_pos,			&
				ls_year,					&
				ls_date,					&
				ls_minimum,				&
				ls_maximum,				&
				ls_temp,					&
				ls_colname, 			&
				ls_pdr_protect				//	04/24/02	GaryR	Track 2552d
String		ls_invtype					// 12/22/04 KatieR Track 4176d
String 	ls_parens_append		// 01/20/06 HYL Track 4619d
	
Long			ll_pos,					&
				ll_length,				&
				ll_min_len,				&
				ll_elem_data_len,		&
				ll_lead_alpha,			&
				ll_dict_count

datawindowchild ldwc_exp1

n_cst_datetime				lnv_datetime		// Autoinstantiated
n_cst_stars_rel	ln_cst_stars_rel
sx_filter_info				lstr_filter_info[]		// FDG 04/16/98
//--------------------------------------------------------------------
string	ls_tbl_type, ls_elem_name, ls_sql1, ls_sql2

//--------------------------------------------------------------------
// Store the minimum and maximum dates so these dates can be changed 
//	and reset

ls_minimum	=	lnv_datetime.of_GetMinimumStringDate()
ls_maximum	=	lnv_datetime.of_GetMaximumStringDate()

// FDG 05/20/98 begin
li_rc	=	idw_criteria.AcceptText()

IF	li_rc		<	0		THEN
	Return li_rc
END IF
// FDG 05/20/98 end

idw_criteria.getchild('expression_one',ldwc_exp1)
li_exp1_count = ldwc_exp1.rowcount()
li_rowcount = idw_criteria.rowcount()

//02-12-98 FNC Start
if li_rowcount = 0 then
	//	04/24/02	GaryR	Track 2552d - Begin
	IF ib_is_pdr_mode THEN Return 0
	MessageBox('Error', 'Please enter at least one line of valid criteria.',StopSign!,Ok!)
	return -10
	//	04/24/02	GaryR	Track 2552d - End
end if
//02-12-98 FNC End

ls_exp1	=	idw_criteria.getitemstring(1,'expression_one')	//FNC 04/08/98
ls_exp2	=	idw_criteria.getitemstring(1,'expression_two')
ls_pdr_protect = Upper(trim(idw_criteria.getitemstring(1,'pdr_protect')))

//* must enter at least one row of criteria */
if li_rowcount = 1										&
and ((IsNull (ls_exp2)	or	trim(ls_exp2) < ' ')	or &
		(IsNull (ls_exp1)	or	trim(ls_exp1) < ' ')) Then			//FNC 04/08/98 
	IF ib_is_pdr_mode AND ls_pdr_protect <> "Y" AND ls_pdr_protect <> "A" THEN Return 0	
	MessageBox('Error', 'Please enter at least one line of valid criteria.',StopSign!,Ok!)
	return -10
end if

//* loop thru datawindow */
ii_filter_count = 0
li_j = 1

for li_sub = 1 to li_rowcount
	ls_left=trim(idw_criteria.getitemstring(li_sub,'left_paren'))
	ls_exp1= trim(idw_criteria.getitemstring(li_sub,'expression_one'))
	ls_relop=trim(idw_criteria.getitemstring(li_sub,'relational_op'))
	ls_exp2=RightTrim(idw_criteria.getitemstring(li_sub,'expression_two'))
	ls_right=trim(idw_criteria.getitemstring(li_sub,'right_paren'))
	ls_logic=trim(idw_criteria.getitemstring(li_sub,'logical_op'))
	ls_pdr_protect = upper(trim(idw_criteria.getitemstring(li_sub,'pdr_protect')))		//	04/24/02	GaryR	Track 2552d
	li_warned = idw_criteria.GetItemNumber( li_sub, "space_warned" )
	
	If IsNull(ls_left) Then
		ls_left = ''
	End If
	ls_parens_append += ls_left // 01/20/06 HYL Track 4619d
	If IsNull(ls_exp1) Then
		ls_exp1 = ''
	End If
	If IsNull(ls_relop) Then
		ls_relop = ''
	End If
	If IsNull(ls_exp2) Then
		ls_exp2 = ''
	End If
	If IsNull(ls_right) Then
		ls_right = ''
	End If
	ls_parens_append += ls_right // 01/20/06 HYL Track 4619d	
	If IsNull(ls_logic) Then
		ls_logic = ''
	End If
	//04-08-98 FNC Start If row is blank delete it
	if ls_left = ''  and &
		ls_exp1 = ''  and &
		ls_relop = '' and &
		ls_exp2 = ''  and &
		ls_right = '' and &
		ls_logic = '' then
			continue
	end if
	//04-08-98 FNC End

	/* remove any rows that don't have data in expression_two 
	unless have left or right parens - if need to put multiple 
	parens on a line the user uses a blank line w/ that paren */	
	//	04/24/02	GaryR	Track 2552d
	//if ls_exp2 = '' and ls_left = '' and ls_right = '' then
	if ls_exp1 = '' and ls_exp2 = '' and ls_left = '' and ls_right = '' AND ls_pdr_protect = "" then
		idw_criteria.deleterow(li_sub)
		li_sub --
		li_rowcount --
		continue
	end if
	
	//Determine if expr2 is a value or a field
	// FDG 11/12/01 begin
	ls_colName = Trim (idw_criteria.object.exp2ColName[li_sub] )
	IF ls_colName	> ' ' THEN 
		lb_is_field = TRUE
		CHOOSE CASE	ls_relop
			CASE	'=', '<>', '>', '>=', '<', '<='
				// exp2 is a column but it contains the display value.  Set expression_two to the
				//	actual column name
				ls_exp2		=	ls_colname
			CASE	ELSE
				MessageBox('Error','Invalid Relational Operator when comparing data.',StopSign!,Ok!)
				idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
				return -102
		END CHOOSE
	ELSE
		lb_is_field = FALSE
	END IF
	// FDG 11/12/01 end
	//Set lb_is_soundex to true if operator is SOUNDS LIKE
	lb_is_soundex = ls_relop = 'SOUNDS LIKE'
	
	//	04/24/02	GaryR	Track 2552d - Begin
	//	PDR functionality only.  Does not effect PDQs.
	//	If the pdr_protect field is set to "A"
	//	then current row is a retrieval argument
	//	Do not process retrieval arguments in this script
	IF ls_pdr_protect = "A" THEN		
		IF ls_exp1 = "" THEN
			MessageBox('Error','Field is required.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)
			return -100
		END IF
		IF ls_relop = "" THEN
			MessageBox('Error','Relational Operator is required.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)
			return -102
		END IF
		IF ls_exp2 = "" THEN
			MessageBox('Error','Value is required.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)
			return -101
		END IF
		
		ls_data_type = Trim( idw_criteria.GetItemString( li_sub, "c_elem_data_type" ) )
		IF Isnull( ls_data_type ) THEN ls_data_type = ""
		
		CHOOSE CASE ls_data_type
			CASE "NUMBER"
				IF NOT IsNumber( ls_exp2 ) THEN
					MessageBox( 'ERROR', "Invalid numeric value '" + ls_exp2 + &
										"' entered for field '" + ls_exp1 + "'", StopSign!, Ok! )
					idw_criteria.ScrolltoRow(li_sub)
					return -101
				END IF
				
			CASE "STRING", "STRINGARRAY"
			CASE "DATE"
				IF lnv_datetime.of_IsValidDate( ls_exp2 )	<= 0 THEN
					MessageBox( "ERROR", "Invalid date value '" + ls_exp2 + "' entered for field '" + ls_exp1 + &
										"'~n~rDate values must be between " + ls_minimum + " and " + ls_maximum + &
										" and in the MM/DD/YYYY format", StopSign!, Ok! )
					idw_criteria.ScrolltoRow(li_sub)
					return -101
				END IF
				
			CASE "DATETIME"
				//	Parse the value to obtain
				//	the date and time
				li_pos = Pos( ls_exp2, " " )
				IF li_pos > 0 THEN
					ls_date = Trim( Left( ls_exp2, li_pos - 1 ) )
					ls_temp = Trim( Mid( ls_exp2, li_pos + 1 ) )										
				ELSE
					ls_date = ls_exp2
					ls_temp = "00:00:00"
				END IF

				IF NOT lnv_datetime.of_IsValid( DateTime( Date( ls_date ), Time( ls_temp ) ) ) THEN
					MessageBox( "ERROR", "Invalid datetime value '" + ls_exp2 + "' entered for field '" + ls_exp1 + &
										"'~n~rDatetime values must be between " + ls_minimum + " and " + ls_maximum + &
										" and in the MM/DD/YYYY HH:MM:SS format", StopSign!, Ok! )
					idw_criteria.ScrolltoRow(li_sub)
					return -101
				END IF
				
			CASE "TIME"
				IF NOT lnv_datetime.of_IsValid( Time( ls_exp2 ) ) THEN
					MessageBox( "ERROR", "Invalid time value '" + ls_exp2 + "' entered for field '" + ls_exp1 + &
										"'~n~rTime values must be between 00:00:00 and 23:59:59"  + &
										" and in the HH:MM:SS format", StopSign!, Ok! )
					idw_criteria.ScrolltoRow(li_sub)
					return -101
				END IF
				
			CASE ELSE
				MessageBox( 'ERROR', "Invalid data type '" + ls_data_type + &
										"' declared for field '" + ls_exp1 + "'" + &
										"~n~rPlease contact your System Administrator regarding this particular report", Exclamation! )
				idw_criteria.ScrolltoRow(li_sub)
				return -101
		END CHOOSE		
		
		astr_criteria[li_j].expression_one = ls_exp1
		astr_criteria[li_j].rel_operator = ls_relop
		astr_criteria[li_j].expression_two = ls_exp2
		astr_criteria[li_j].pdr_protect = ls_pdr_protect
		astr_criteria[li_j].data_type = ls_data_type
		astr_criteria[li_j].exp2_column = lb_is_field
		astr_criteria[li_j].logical_operator = ls_logic
		li_j ++
		Continue
	END IF
	//	04/24/02	GaryR	Track 2552d - End
	
	lb_superpv = FALSE
	lb_superNPIpv = FALSE
	
	/* Super Provider Query logic - must get actual column name so can do edit 
	checks and formatting on expression2*/
	if mid(ls_exp1,4) = "SUPER PROVIDER" then
		ls_exp1	=	''													// FDG 03/06/98
		li_count = upperbound(istr_prov_query.prov_fields)
		for li_k = 1 to li_count
			if istr_prov_query.prov_fields[li_k].selected then
				ls_exp1	=	istr_prov_query.prov_fields[li_k].table_type	+ '.' + &
								istr_prov_query.prov_fields[li_k].prov_col_name
				ls_data_type = 'CHAR'
				lb_superpv = TRUE
				exit
			end if
		next
		if ls_exp1 = '' then
			MessageBox('Error', 'Please select a column for Super Provider.')
			idw_criteria.ScrolltoRow (li_sub)					// FDG 06/15/98			
			return -100
		end if
		
		//	Set parms
		istr_prov_query.relational_op = ls_relop				// FDG 03/09/98
		istr_prov_query.left_paren = ls_left
		istr_prov_query.right_paren = ls_right
	elseif mid(ls_exp1,4) = "SUPER NPI PROVIDER" then
		ls_exp1	=	''
		li_count = upperbound(istr_npi_prov_query.prov_fields)
		for li_k = 1 to li_count
			if istr_npi_prov_query.prov_fields[li_k].selected then
				ls_exp1	=	istr_npi_prov_query.prov_fields[li_k].table_type	+ '.' + &
								istr_npi_prov_query.prov_fields[li_k].prov_col_name
				ls_data_type = 'CHAR'
				lb_superNPIpv = TRUE
				exit
			end if
		next
		if ls_exp1 = '' then
			MessageBox('Error', 'Please select a column for Super NPI Provider.')
			idw_criteria.ScrolltoRow (li_sub)					// FDG 06/15/98			
			return -100
		end if

		//	Set parms
		istr_npi_prov_query.relational_op = ls_relop				// FDG 03/09/98
		istr_npi_prov_query.left_paren = ls_left
		istr_npi_prov_query.right_paren = ls_right
	else
		ls_find = "col_name = '" + upper(ls_exp1) + "'"		//12-29-97 FNC
		li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)
		if li_row < 1 then 											
			MessageBox('Error','Cannot locate expression 1 criteria.  Row # =' + String(li_sub)	+ &
							'.  Find string = ' + ls_find + '.  Event = u_nvo_create_sql.ue_format_where_criteria.')
			return -10
		end if															
		ls_data_type=ldwc_exp1.getitemstring(li_row,'elem_data_type')

		IF as_type = "CRITERIA" THEN
			astr_criteria[li_j].expr1_orig = ldwc_exp1.getitemstring(li_row,'col_desc')			
			IF lb_is_field THEN
				ls_find = "col_name = '" + upper(ls_exp2) + "'"
				li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)
				if li_row < 1 then 											
					MessageBox('Error','Cannot locate expression 2 criteria.  Row # =' + String(li_sub)	+ &
									'.  Find string = ' + ls_find + '.  Event = u_nvo_create_sql.ue_format_where_criteria.')
					return -10
				end if
				astr_criteria[li_j].expr2_orig = ldwc_exp1.getitemstring(li_row,'col_desc')
			ELSE
				astr_criteria[li_j].expr2_orig = ls_exp2
			END IF
		END IF
	end if			
	
	/* if row only contains left paren, remove logic_op, check 
	next row to determine if contains only right paren, if does 
	remove logic_op in current row */
	if ls_left <> '' and ls_exp1 = '' then
		ls_logic = ''
	end if
	if ls_right <> '' and li_sub + 1 <= li_rowcount then
			/* also check if NULL */
		if trim(idw_criteria.getitemstring(li_sub + 1,'right_paren')) <> '' &
   	and trim(idw_criteria.getitemstring(li_sub + 1,'expression_one')) = '' then
			ls_logic = ''
		end if
	end if
	/* must count parens to make sure have match in the end*/
	if ls_left = '(' then 
		li_left_paren_count++
	End If
	
	If ls_right = ')' then 
		li_right_paren_count++
	End If
	
	if ls_left = '((' then // 01/20/06 HYL Track 4619
		li_left_paren_count += 2
	End If
	
	If ls_right = '))' then 
		li_right_paren_count += 2
	End If

	/*edit checks from w_drilldown_parent.wf_format_sql() for rows that  
	contain some type of data*/
	if ls_exp1 <> '' or ls_relop <> '' or ls_exp2 <> '' then
		if ls_exp1 = '' then
			MessageBox('Error','Field is required.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -100
		end if
		if ls_relop = '' then
			MessageBox('Error','Relational Operator is required.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -102
		end if
		if ls_exp2 = '' then
			MessageBox('Error','Value is required.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		if pos(ls_exp2,"'") > 0 then
			MessageBox('Error','Quote is invalid in Value field.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		
		// Warn if leading spaces
		if Left(ls_exp2,1) = " " AND li_warned = 0 then
			IF MessageBox('Warning', 'Value "' + ls_exp2 + '" contains leading space(s).' + &
							"~n~rWould you like to continue?", Exclamation!, YesNo!, 2) = 2 THEN
				idw_criteria.ScrolltoRow(li_sub)
				return -101
			ELSE
				//Save that user accepted warning
				idw_criteria.object.space_warned[li_sub] = 1
			END IF
		end if
		
		//NLG 10-16-01 Don't allow certain operands if exp2 is field rather than value
		if (ls_relop = "LIKE" or ls_relop = "NOT LIKE" or ls_relop = "BETWEEN" or &
				ls_relop = "IN" or ls_relop = "NOT IN" or lb_is_soundex) AND lb_is_field then
				MessageBox('Error', 'Invalid operand',StopSign!,Ok!)
				idw_criteria.ScrolltoRow(li_sub)
				return -101
		end if
		
		if (ls_relop = "LIKE" or ls_relop = "NOT LIKE") and &
			ls_exp2 = '%' then
			MessageBox('Error', 'Value must contain more than a percent sign.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		// FDG 07/24/98		// FDG 07/29/98
		IF (ls_relop = "LIKE" or ls_relop = "NOT LIKE") &
		and pos(ls_exp2,'%') = 0 								&
		and pos(ls_exp2,'_') = 0 								then
			MessageBox('Error', 'A percent sign or underscore is required when using LIKE or NOT LIKE.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		// FDG 10/28/98 begin
		IF (ls_relop = "LIKE" or ls_relop = "NOT LIKE") &
		and pos(ls_exp2,',') >	0 								THEN
			MessageBox('Error', 'Multiple values cannot be entered when using LIKE or NOT LIKE.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)		
			return -101
		end if

		IF (ls_relop = "LIKE" or ls_relop = "NOT LIKE") then
		Else
			// Lahu S 2/8/02 begin										
			if ib_is_pdr_mode then
				if (pos(ls_exp2,'%') <> 0) then
					MessageBox('Error', 'A "%" can only be used with LIKE or NOT LIKE.',StopSign!,Ok!)
					idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
					return -101
				end if
			else
				if ((pos(ls_exp2,'%') <> 0) or ((pos(ls_exp2,'_') <> 0) &
					AND NOT lb_is_field AND left(ls_exp2,1) <> '@')) then
					MessageBox('Error', 'A "%" or "_" can only be used with LIKE or NOT LIKE.',StopSign!,Ok!)
					idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
					return -101
				end if
			End if
		end if

		/* new check for LIKE and Super Provider Query */
		if (ls_relop = "LIKE" or ls_relop = "NOT LIKE") and lb_superpv then
			MessageBox('Error', 'Cannot use LIKE with Super Provider Query.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -102
		end if
		/* new check for LIKE and Super NPI Provider Query */
		if (ls_relop = "LIKE" or ls_relop = "NOT LIKE") and lb_superNPIpv then
			MessageBox('Error', 'Cannot use LIKE with Super NPI Provider Query.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -102
		end if
	else
	/* row is blank except for a paren */
		if ls_left <> '' and ls_right <> '' then
			MessageBox('Error', '() is not a valid criteria.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -103
		end if
		if as_type = 'WHERE' then
			as_where[li_j] = ls_left + ls_right 
		else
			astr_criteria[li_j].left_paren = ls_left
			astr_criteria[li_j].right_paren = ls_right
		end if
		li_j++
		continue
	end if
	/* remove logical operator from last row */
	if li_sub = idw_criteria.rowcount() then
		ls_logic = ''
	end if
	//HRB 4/9/98 - do not allow multiple values for '='
	if ls_relop = '=' and match(ls_exp2,',') then
		messagebox('Error',"Must use the IN, NOT IN or BETWEEN operator with multiple values.",&
																					StopSign!,Ok!)
		idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
		return -101
	end if

	//	don't process PAYMENT_DATE if ab_add_payment_date = FALSE
	if mid(ls_exp1,4) = "PAYMENT_DATE" and not ab_add_payment_date then
		continue
	end if
	// check to see if ls_exp2 is a filter, if it is make sure it  
	//is valid and build where clause
	if left(ls_exp2,1) = '@' then 		// have a filter
		if lb_superpv then
			MessageBox('Error', 'Cannot use a Filter with a Super Provider Query.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		if lb_superNPIpv then
			MessageBox('Error', 'Cannot use a Filter with a Super NPI Provider Query.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		ls_filter_id = Upper( mid(ls_exp2,2) )		// 04/20/01	GaryR	Stars 4.7 DataBase Port
		if ls_filter_id = '' then
			MessageBox('Error', 'A Filter id must follow @.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		
		// FDG 05/07/98	begin		// FDG 08/11/00
		CHOOSE CASE	ls_relop
			CASE	'=', 'IN', '<>', 'NOT IN'
			CASE ELSE
				MessageBox ("Error", "When using a filter, the relational operator must be '=', 'NOT =', 'IN', or 'NOT IN'.",	&
								StopSign!,Ok!)
				idw_criteria.ScrolltoRow(li_sub)			
				Return -102
		END CHOOSE
		// FDG 05/07/98	end	
		
		// AJS 12/09/98 Track #D2023
		if mid(ls_exp1,4) = "PAYMENT_DATE" then
			MessageBox('Error', 'Cannot use a Filter with a Date Paid ',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				
			return -101
		end if
		// AJS 12/09/98 Track #D2023 end
		
		// will check for valid id and return data type and column in filter_vals table
		li_rc	= This.Event	ue_check_filter_data_type (ls_filter_data_type, ls_filter_id)
		if li_rc <> 0 then
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		
		//	AJS 12-08-98 Track #D2023 Added code from 3.6 to make the filter process a little flexible	
		// Convert REAL data type from dictionary to one that will compare
		// with filter control table
		ls_type = ls_data_type

		IF gnv_sql.of_is_character_data_type (ls_type)		THEN
			ls_type = 'CHAR'
		ELSEIF gnv_sql.of_is_number_data_type (ls_type)		THEN
			ls_type = 'NUMBER'
		ELSEIF gnv_sql.of_is_money_data_type (ls_type)		THEN
			ls_type = 'MONEY'
		ELSEIF gnv_sql.of_is_date_data_type (ls_type)		THEN
			ls_type = 'DATE'
		END IF
		// FDG 12/14/00 end
		//AJS 12-08-98 end
		if upper(ls_type) <> upper(ls_filter_data_type) then
			MessageBox('Error', 'Value does not match filter data type.',StopSign!,Ok!)
			idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
			return -101
		end if
		ii_filter_count++
		if as_type = 'WHERE' OR UpperBound( as_where ) > 0 then
			Select db 
			into :ls_filter_db
			From dictionary 
			Where elem_type = 'UT'
			  And elem_tbl_type = 'SS'
			Using Stars2ca;
			if stars2ca.of_check_status() <> 0 then
				errorbox(stars2ca, + &
					'Error reading dictionary to retrieve the filter database name in u_nvo_create_sql.ue_format_where_criteria')
				Return	-1
			elseif isnull(ls_filter_db) then
				stars2ca.of_commit()					// FNC 04/13/99	
				messagebox('ERROR','The value for DB in the dictionary for Elem Type = "TB" and elem_tbl_type = FV is null. Report processing is cancelled')
				Return	-1
			else
				stars2ca.of_commit()					// FNC 04/13/99	
			end if
			//	12/04/00	GaryR	Stars 4.7 DataBase Port
			//ls_filter_db			=	ls_filter_db	+	".."
			ls_filter_db			=	gnv_sql.of_get_database_prefix( ls_filter_db )
			ls_filter_tbl_type	=	"FV"	+	String (ii_filter_count)
			// FDG 08/11/00 begin
			CHOOSE CASE	ls_relop
				CASE	'=', 'IN'
					ls_in		=	" IN "
				CASE	'<>', 'NOT IN'
					ls_in		=	" NOT IN "
					li_rc		=	MessageBox ("Question", "This query uses ' NOT IN ' with a filter and may "	+	&
													"take a long time to run.  Would you like to continue?", 			&
													Question!, YesNo!, 1)
					IF	li_rc	=	2		THEN
						Return	-102
					END IF
			END CHOOSE
			// FDG 08/11/00 end
			ls_filter_tbl_name = gnv_server.of_GetFilterTableName(ls_filter_id)
			IF UpperBound( as_where ) > 0 THEN
				IF as_where[1] = "PDR" THEN
					//Convert both sides of comparison to 
					//upper case to ensure case insensitivity
					IF ls_filter_data_type = "CHAR" THEN
						astr_criteria[li_j].expression_one = gnv_sql.of_get_to_upper( ls_exp1 )
						astr_criteria[li_j].expression_two = "(SELECT " +  "FILTER_DATA" + &
																		" FROM " + ls_filter_db + ls_filter_tbl_name + ")"
					ELSE
						astr_criteria[li_j].expression_one = ls_exp1
						astr_criteria[li_j].expression_two = "(SELECT FILTER_DATA FROM " + ls_filter_db + ls_filter_tbl_name + ")"
					END IF
					
					astr_criteria[li_j].left_paren = ls_left
					astr_criteria[li_j].rel_operator = Trim( ls_in )
					astr_criteria[li_j].right_paren = ls_right
					astr_criteria[li_j].logical_operator = ls_logic
					astr_criteria[li_j].data_type = ls_data_type
				ELSE
					ls_sql1 = this.uf_get_col_where( ls_exp1 )
					
					IF ls_filter_data_type = "CHAR" THEN
						// For non PV and EN ancillary invoices convert both sides 
						// of comparison to upper case to ensure case insensitivity.
						// For claim invoices convert only the filter values to upper.
						IF ib_ancillary_inv_type AND is_inv_type <> 'PV' AND is_inv_type <> 'EN' THEN			
							as_where[li_j]	=	ls_left	+	"("	+ gnv_sql.of_get_to_upper( ls_sql1 ) +	&
													ls_in	+	"(SELECT " + "FILTER_DATA" 
						ELSE
							as_where[li_j]	=	ls_left	+	"("	+ ls_sql1  + ls_in	+	"(SELECT " + &
													 "FILTER_DATA" 
						END IF
					ELSE
						as_where[li_j]	=	ls_left	+	"("	+	ls_sql1	+	ls_in	+	"(SELECT FILTER_DATA"
					END IF
					as_where[li_j] += " FROM " + ls_filter_db + ls_filter_tbl_name + "))" + ls_right + " " + ls_logic					
				END IF
			ELSE
				ls_sql1 = this.uf_get_col_where( ls_exp1 )
				// For non PV and EN ancillary invoices convert both sides 
				// of comparison to upper case to ensure case insensitivity.
				// For claim invoices convert only the filter values to upper.
				IF ls_filter_data_type = "CHAR" THEN
					IF ib_ancillary_inv_type AND is_inv_type <> 'PV' AND is_inv_type <> 'EN' THEN			
						as_where[li_j]	=	ls_left	+	"("	+ gnv_sql.of_get_to_upper( ls_sql1 ) +	&
												ls_in	+	"(SELECT " + "FILTER_DATA"
					ELSE
						as_where[li_j]	=	ls_left	+	"("	+ ls_sql1  +	ls_in	+	"(SELECT " + &
												"FILTER_DATA"
					END IF
				ELSE
					as_where[li_j]	=	ls_left	+	"("	+	ls_sql1	+	ls_in	+	"(SELECT FILTER_DATA"
				END IF
				 as_where[li_j] += " FROM " + ls_filter_db + ls_filter_tbl_name + "))" + ls_right + " " + ls_logic
				// FDG 07/12/00 end
			END IF
			
			//	if creating subset must put filter id into subset struct
			if ib_subsetting then
				istr_subsetting_info.filter_copy[ii_filter_count] = ls_filter_id
			end if			
		else
			astr_criteria[li_j].left_paren = ls_left
			astr_criteria[li_j].expression_one = ls_exp1
			astr_criteria[li_j].rel_operator = ls_relop
			astr_criteria[li_j].expression_two = ls_exp2
			astr_criteria[li_j].right_paren = ls_right
			astr_criteria[li_j].logical_operator = ls_logic
			astr_criteria[li_j].data_type = ls_data_type
		end if
		li_j++
		continue
	end if
	/* the next part is taken straight from the code - must change the relop 
	before passing it to fx_error_check_fields_for_dw - 	treat LIKE and IN as 
	=, if an = is passed in with 123,133,134 it returns the operator IN anyway.   
	if not it should be =.  if = is passed with 12%,13% then LIKE is returned 
	anyway */
	choose case ls_relop
			case "LIKE", "IN"
				ls_relop = '='
			case "NOT LIKE", "NOT IN"
				ls_relop = "<>"
			case "BETWEEN"
				ls_relop = "><"
	end choose

	// Get field lengths from the dictionary
	ls_tbl_type 	= left(ls_exp1,2) 
	ls_elem_name 	= mid(ls_exp1,4) 
	
	ll_min_len			=	gnv_dict.event ue_get_min_length	(ls_tbl_type, ls_elem_name)
	ll_elem_data_len	=	gnv_dict.event ue_get_data_len	(ls_tbl_type, ls_elem_name)
	ll_lead_alpha		=	gnv_dict.event ue_get_lead_alpha	(ls_tbl_type, ls_elem_name)

	//NLG don't edit exp2 if it's a field rather than value
	IF NOT lb_is_field THEN
		ls_relop = fx_error_check_fields_for_dw(ls_data_type, &
														ls_relop, &
														ls_exp2, &
														ls_exp1, &
														idw_criteria, &
														'expression_two', &
														li_sub, &
														ll_min_len, &
														ll_elem_data_len, &
														ll_lead_alpha)
	END IF
	// FDG 03/06/98 end
	if ls_relop = 'ERROR' then 
		return -10
	end if

	// Check if computed column
	li_pos = pos(ls_exp1, '.')
	lb_is_computed = gnv_dict.event ue_get_is_computed(left(ls_exp1, li_pos - 1), mid(ls_exp1, li_pos + 1))
	
	//Check if looking for blanks
	lb_is_blanks =	Upper(ls_exp2) = 'BLANKS'
	
	IF gnv_sql.of_is_character_data_type (ls_data_type)	THEN
		ls_format_exp = format_where(ls_exp2, ls_relop, ls_exp1)

		IF lb_is_field THEN
			li_pos = pos(ls_format_exp,'~'')
			if li_pos > 0 then
				ls_format_exp = mid(ls_format_exp,li_pos + 1)
				li_pos = pos(ls_format_exp,'~'')
				if li_pos > 0 then
					ls_format_exp = left(ls_format_exp,li_pos - 1)
				end if
			end if
		END IF

		//Katie Track 3661d If keyword BLANKS used in criteria change to ' ' with a single space
		if lb_is_blanks then ls_format_exp = '~' ~''

		//Add SOUNDEX() around exp if operator is SOUNDS LIKE
		if lb_is_soundex then
			// 12/22/04 Katie	Track 4176d start
			if lb_is_computed then
				li_pos = pos(ls_exp1, '.')
				ls_exp1 = gnv_dict.event ue_get_formula( left(ls_exp1, li_pos - 1), mid(ls_exp1, li_pos + 1))
			end if
			// 12/22/04 Katie	Track 4176d end
			ls_exp1 = 'SOUNDEX(' + ls_exp1 + ')'
			ls_format_exp = 'SOUNDEX(' + ls_format_exp + ')'			
		end if
	ELSEIF gnv_sql.of_is_date_data_type (ls_data_type)		THEN
		ls_format_exp = format_where(ls_exp2,ls_relop,ls_exp1)
		//NLG 10-16-01 start
		IF lb_is_field THEN
			li_pos = pos(ls_format_exp,'~'')
			if li_pos > 0 then
				ls_format_exp = mid(ls_format_exp,li_pos + 1)
				li_pos = pos(ls_format_exp,'~'')
				if li_pos > 0 then
					ls_format_exp = left(ls_format_exp,li_pos - 1)
				end if
			end if
		END IF
		//NLG 10-16-01 end
		if left(ls_format_exp,1) <> '!' then
			//	06/15/01	GaryR	Stars 4.7
			astr_criteria[li_j].orig_expression = ls_format_exp
			if ib_ancillary_inv_type and not ib_subsetting then
				ls_exp1 = gnv_sql.of_get_to_date_no_time  (ls_exp1, True)
			end if
			// 01/05/01	GaryR	Stars 4.7 DataBase Port - Begin
			IF Upper( ls_relop ) = "BETWEEN" OR ls_relop = "><" THEN
				//Parse ls_exp2 and extract the dates								
				//Only two dates should be legal
				li_pos	=	Pos( ls_exp2, "," )
				
				IF	li_pos	=	0		THEN
					// Only one date
					if ib_ancillary_inv_type and not ib_subsetting then
						ls_format_exp	=	gnv_sql.of_get_to_date_no_time  (ls_exp2, False)
					else
						ls_format_exp	=	gnv_sql.of_get_to_date  (ls_exp2)
					end if
				ELSE
					// Multiple dates exist
					if ib_ancillary_inv_type and not ib_subsetting then
						ls_format_exp	=	gnv_sql.of_get_to_date_no_time (Left( ls_exp2, li_pos - 1 ), False) + " AND " + &
											gnv_sql.of_get_to_date_no_time  (Mid( ls_exp2, li_pos + 1 ), False)
					else
						ls_format_exp	=	gnv_sql.of_get_to_date (Left( ls_exp2, li_pos - 1 )) + " AND " + &
											gnv_sql.of_get_to_date (Mid( ls_exp2, li_pos + 1 ))
					end if
				END IF
			ELSEIF Upper( ls_relop ) = "IN" OR Upper( ls_relop ) = "NOT IN" THEN
				//Add parenthesis
				if ib_ancillary_inv_type and not ib_subsetting then
					ls_format_exp	=	"(" + gnv_sql.of_get_to_date_no_time (ls_exp2, False) + ")"
				else
					ls_format_exp	=	"(" + gnv_sql.of_get_to_date (ls_exp2) + ")"
				end if
			ELSE
				//Convert to date
				//	12/07/01	GaryR	Track 2565d - Begin
				IF lb_is_field THEN
					ls_format_exp	=	ls_exp2
				ELSE
					if ib_ancillary_inv_type and not ib_subsetting then
						ls_format_exp	=	gnv_sql.of_get_to_date_no_time (ls_exp2, False)
					else
						ls_format_exp	=	gnv_sql.of_get_to_date (ls_exp2)
					end if
				END IF
				//	12/07/01	GaryR	Track 2565d - End					
			END IF
			// 01/05/01	GaryR	Stars 4.7 DataBase Port - End
		END IF
	ELSE
		//NLG 10-16-01 don't call format_where_n if exp2 is a numeric field
		IF lb_is_field THEN
			ls_format_exp = ls_exp2
		ELSE
			ls_format_exp = format_where_n(ls_exp2,ls_relop)
		END IF
	END IF
	
	if left(ls_format_exp,1) = '!' then
		// FDG 02/19/02 Track 2820d. Make text more descriptive
		//MessageBox('Error', 'Syntax error. ! is not valid.',StopSign!,Ok!)
		MessageBox('Error', 'Invalid Value/Field entered:'	+	Mid(ls_format_exp, 2), StopSign!, Ok!)
		return -10
	end if

	if as_type = 'WHERE' then
		/* this was added for the multiple LIKE values logic */
		if lb_superpv or lb_superNPIpv then
			li_j = this.event ue_format_where_criteria_super_prov( &
					astr_criteria, as_where, ls_format_exp, ls_logic, FALSE, lb_superNPIpv )
		else		
			// Formats columns where (Checks for formula)
			ls_sql1 = this.uf_get_col_where( ls_exp1 )
			
			IF lb_is_field THEN
				ls_format_exp = this.uf_get_col_where( ls_exp2 )
			END IF
			
			IF gnv_sql.of_is_character_data_type( ls_data_type ) THEN
				// For non PV and EN ancillary invoices convert both sides 
				// of comparison to upper case to ensure case insensitivity
				IF ib_ancillary_inv_type AND is_inv_type <> 'PV' AND is_inv_type <> 'EN' &
				AND NOT lb_is_blanks AND NOT lb_is_computed AND NOT lb_is_soundex THEN
					IF lb_is_field THEN
						as_where[li_j] = ls_left + gnv_sql.of_get_to_upper( ls_sql1 ) + ' ' + ls_relop + ' ' &
											+ gnv_sql.of_get_to_upper( ls_format_exp ) + ls_right + " " + ls_logic
					ELSE
						as_where[li_j] = ls_left +  + gnv_sql.of_get_to_upper( ls_sql1 ) +  ' ' +ls_relop & 
													+ ' ' + Upper( ls_format_exp ) +  ls_right + " " + ls_logic
					END IF
				ELSE
					IF lb_is_field THEN
						as_where[li_j] = ls_left + ls_sql1 + ' ' + ls_relop &
											+ ' ' + ls_format_exp + ls_right + " " + ls_logic
					ELSE
						as_where[li_j] = ls_left +  + ls_sql1 +  ' ' +ls_relop & 
												+ ' ' + Upper( ls_format_exp ) +  ls_right + " " + ls_logic
					END IF
				END IF
			ELSE
				as_where[li_j] = ls_left + ls_sql1 + ' ' + ls_relop &
				+ ' ' + ls_format_exp + ls_right + " " + ls_logic
				// FDG 03/14/01 - If the where is for payment date, store it in inv_base
				IF	Mid (ls_exp1, 4)	=	'PAYMENT_DATE'		THEN
					inv_base.is_where_paid_date	=	ls_left + ls_sql1 + ' ' + ls_relop &
																+ ' ' + ls_format_exp + ls_right
				END IF
			END IF
		end if
	else
		if lb_superpv or lb_superNPIpv then
			//	11/07/01	GaryR	Track 2527
			li_j = this.event ue_format_where_criteria_super_prov( &
						astr_criteria, as_where, ls_format_exp, ls_logic, TRUE, lb_superNPIpv )
		else
			ls_sql1 = ls_exp1
			// Formats columns where in PDR mode only (Checks for formula)
			IF ib_is_pdr_mode THEN	ls_sql1 = this.uf_get_col_where( ls_exp1 )
			IF gnv_sql.of_is_character_data_type( ls_data_type ) THEN
				IF ib_is_pdr_mode THEN
					// Convert the column to upper case to ensure case insensitivity
					IF NOT lb_is_blanks AND NOT lb_is_computed AND NOT lb_is_soundex THEN
						IF lb_is_field THEN
							astr_criteria[li_j].expression_one = gnv_sql.of_get_to_upper( ls_sql1 )
							astr_criteria[li_j].expression_two = gnv_sql.of_get_to_upper( ls_format_exp )
						ELSE
							astr_criteria[li_j].expression_one = gnv_sql.of_get_to_upper( ls_sql1 )
							astr_criteria[li_j].expression_two = Upper( ls_format_exp )
						END IF
					ELSE
						IF lb_is_field THEN
							astr_criteria[li_j].expression_one = ls_sql1
							astr_criteria[li_j].expression_two = ls_format_exp
						ELSE
							astr_criteria[li_j].expression_one = ls_sql1
							astr_criteria[li_j].expression_two = Upper( ls_format_exp )
						END IF
					END IF
				ELSE
					IF lb_is_field THEN
						astr_criteria[li_j].expression_one = ls_sql1
						astr_criteria[li_j].expression_two = ls_format_exp
					ELSE
						astr_criteria[li_j].expression_one = ls_sql1
						astr_criteria[li_j].expression_two = Upper( ls_format_exp )
					END IF
				END IF				
			ELSE
				astr_criteria[li_j].expression_one = ls_sql1
				astr_criteria[li_j].expression_two = ls_format_exp
			END IF
			astr_criteria[li_j].left_paren = ls_left
			
			astr_criteria[li_j].rel_operator = ls_relop
			
			astr_criteria[li_j].right_paren = ls_right
			astr_criteria[li_j].logical_operator = ls_logic
			astr_criteria[li_j].data_type = ls_data_type
			// Lahu S 2/4/02 Track 2552d
			// Set exp2_column boolean in structure
			astr_criteria[li_j].exp2_column = lb_is_field
		end if
	end if
	li_j++
next

/* Last thing - check to make sure # of parens match up */
if li_left_paren_count <> li_right_paren_count then
	MessageBox('Error', 'Number of left and right parentheses do not match.')
	idw_criteria.ScrolltoRow(li_sub)				// FDG 04/10/98
	return -103
end if

// 01/20/06 HYL Track 4619d	
li_start_pos = Pos(ls_parens_append, "()", li_start_pos)
DO WHILE li_start_pos > 0
    	ls_parens_append = Replace(ls_parens_append, li_start_pos, Len("()"), "")
	li_len = Len(Trim(ls_parens_append))
	IF li_len > 2 THEN
	    li_start_pos = Pos(ls_parens_append, "()", 1)
	ELSEIF li_len = 0 THEN
		EXIT
	ELSE
		IF ls_parens_append = "()" THEN
			EXIT  // Nicely paired and matched!
		ELSE
			MessageBox("Error","Parentheses opened or closed improperly." + " '" + ls_parens_append + "'")
			RETURN -10
		END IF
	END IF
LOOP


//	FDG	01/30/98 Remove 'AND' from the last occurence of
//						as_where[]

li_upper		=	UpperBound (as_where)

// FDG 03/19/98 begin
//If li_Upper < 1 Then RETURN -1					// JTM 1/30/98
IF	li_upper	>	0		THEN
	ll_length	=	Len (as_where [li_upper] )  // length of last occurrence
	//	Find 'AND' at the end
	ll_pos	=	Pos ( as_where [li_upper], 'AND', ll_length - 3)
	IF	ll_pos	>	0		THEN
		// 'AND' found at the end of the last where clause.  Remove it.
		as_where [li_upper]	=	Left ( as_where [li_upper], ll_pos - 1)
	ELSE
		ll_pos	=	Pos ( as_where [li_upper], 'OR', ll_length - 2)
		IF	ll_pos	>	0		THEN
			// 'OR' found at the end of the last where clause.  Remove it.
			as_where [li_upper]	=	Left ( as_where [li_upper], ll_pos - 1)
		END IF
	END IF
END IF
//	FDG	03/19/98 end

//	04/24/02	GaryR	Track 2552d - Begin
IF ib_is_pdr_mode THEN
	li_upper		=	UpperBound( astr_criteria )
	IF	li_upper	>	0 THEN astr_criteria[li_upper].logical_operator = ""
END IF
//	04/24/02	GaryR	Track 2552d - End

//	Encapsulate the user criteria
//	with a set of parens.
IF as_type = "WHERE" THEN
	li_upper = UpperBound( as_where )
	IF li_upper > 1 THEN
		IF Match( as_where[1], "PAYMENT_DATE" ) THEN
			as_where[2] = "(" + as_where[2]
		ELSE
			as_where[1] = "(" + as_where[1]
		END IF
		as_where[li_upper] = Trim( as_where[li_upper] ) + ") "
	END IF
ELSE
	li_upper = UpperBound( astr_criteria )
	IF li_upper > 1 THEN
		IF Match( astr_criteria[1].expression_one, "PAYMENT_DATE" ) THEN
			astr_criteria[2].left_paren += "("
		ELSE
			FOR li_row = 1 TO li_upper
				IF astr_criteria[li_row].pdr_protect = "A" THEN Continue
				astr_criteria[li_row].left_paren += "("
				Exit
			NEXT
		END IF
		astr_criteria[li_upper].right_paren += ")"
	END IF	
END IF

Return 0

end event

event type integer ue_format_where_criteria_add_clauses(string as_type, ref string as_where[], ref sx_criteria astr_criteria[]);//*********************************************************************************
// Event Name:	u_nvo_create_sql.UE_Format_Where_Criteria_Add_Clauses
//
//	Arguments:	String	as_type
//					String	as_where[]   (by reference)
//					Sx_Criteria	astr_criteria[]	(by reference)
//
// Returns:		Integer
//
//	Description:
//	This event is called to either
//	1. Create a where clause and add to as_where OR
//	2. Create criteria and add to astr_criteria 
//	depending on as_type (either 'WHERE' or 'CRITERIA'). 
//
//	If dependent join or drilldown will add clauses for dependent join 
//	and/or temp table join.
//
//	To determine dependent join, use tabpage_source (data source and additional data 
//	source) then get join fields from STARS_REL using key1 and key2 .  
//
//	To determine if drilldown using ib_drilldown. Join field is_drilldown_join_fields.
//	If Fasttrack will add clauses for invoice_type.  
// 
//	Fasttrack is found in tabpage_source (data source like 'Q%') and must get inv_type 
//	from the code table.
//
//*********************************************************************************
// 12-10-97 FNC	Created
//	01-28-98	FNC	Move inv type to an array before retrieving hidden dictionary.
//						Use global function to retrieve dictionary datawindow.
//						Add dependent join only if not drilldown
//	01-30-98	FDG	1. Call of_check_status() after each embedded SQL
//						2. Change variable i to li_idx
//						3. When accessing index li_rowcount - 1, make sure that
//							li_rowcount is > 1.
// 04/15/98 FNC	Track 962.  Join dependent and main table with an outer join if 
//						the where or criteria does not contain any columns from the 
//						dependent table
//	05/27/98	FDG	Track 1286.  Move script from uo_query.
//	05/27/98	FDG	Track 1091.  For drilldown, as_where gets the drilldown
//						invoice type, not the original invoice type.
// 06/11/98 FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	06/15/98	FDG	Track ????.  Move script from u_nvo_search.
// 07/31/98	FDG	Track 1235, 1248.  For drilldown (additional data only), get the 
//						drilldown invoice type.
// 09/08/98 FNC	Track 1611. Moved fx_fasttrack_invoice_type to appropriate NVO.
// 09/11/98 FDG	Track 1700.  Can drilldown from PV to C2/CR.  If so, must get the
//						where for CR.  Only ignore additional data source when
//						drilling down to additional data (istr_drilldown.path = 'AD').
// 04/13/99 FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
// 01/16/00 AJS	Use d_dependent_index instead of d_table_indexes to retrieve info from dictionary
//						to see if there are non unique indexes on dependent tables.  unique_key_seq >1 in dictionary.
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
// 04/05/00 FNC	Track 2178 Stardev Stars 4.5. If query is fasttrack must convert
//						to main table before determining join keys.
// 04/12/00 FNC	Track 2852 Starcare Stars 4.5. If subsetting don't add dependent join
//						unless dependent is included in the criteria.
// 05/25/00 KTB   Starcare Track 2882. Choose appropriate invoice type for drilldown.
//	11/21/00	FDG	Stars 4.7.  If an outer join occurs, flag it and store the outer
//						join data so that the "from" clause can access this info.
//	04/17/01	GaryR	Stars 4.6 - Dependent table drilldown error
//	01/17/02	FDG	Track 2518d.  If drilling down to additional data, get the Join keys
//						instead of istr_drilldown.join_fields[].
// 07/23/02 MikeF Track SC3495 - Left Outer Join fix to workaround Sybase bug.
// 08/22/02 MikeF Track 3271 - Error when Dependent is in first line of criteria.
// 03/08/04 MikeF	SPR 3939d - Error creating subset in Sybase w/ LOJ w/ OR clause
// 03/10/04 MikeF	SPR 3940d - Executing LOJ when we shouldn't be
// 10/22/04 MikeF SPR 3650d	Removed references to hidden dictionary
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//*********************************************************************************

integer 	li_rowcount,			&
			li_join_count,			&
			li_rows,					&
			li_idx,					&
			li_num_where,			&
			li_where,				&
			li_num_crit,			&
			li_crit,					&
			li_key_row,				&
			li_uniq_keys,			&
			li_outer,				&
			li_rc
			
string 	ls_dep_type,			&
			ls_filter,				&
			ls_join1,				&
			ls_join2,				&
			ls_data_type1,			&
			ls_data_type2,			&
			ls_where_string,		&
			ls_main_tbl_type,		&
			ls_invoice_type,		&
			ls_elem_type,			&
			ls_tbl_type,			&
			ls_key[],				&
			ls_data_type[],		&
			ls_inv_type,			&
			ls_join_key,			&
			ls_outer_exp2,			&
			ls_logical_connector
			
boolean	lb_dep_found,		&
			lb_outer_join

n_ds				lds_unique_keys

n_cst_revenue	lnvo_revenue

if as_type = "WHERE" then
	li_rowcount = upperbound(as_where) + 1
else
	li_rowcount = upperbound(astr_criteria) + 1
end if

ib_or_loj = FALSE

/* check for dependent join */
/*01-28-98 FNC Only check for dependent join if not drilldown */
if ib_drilldown 			&
and	istr_drilldown.path	=	'AD'	then					// FDG 09/11/98
	// drilldown to additional data - ignore
else
	// Get the dependent table type (if any0
	ls_dep_type = left(trim(idw_source.getitemstring(1,'add_data_source')),2)
	if ls_dep_type <> '' then
		lds_unique_keys = create n_ds										// FNC 02/08/00 Start
		lds_unique_keys.dataobject = 'd_dependent_index'         //Archana 1-16-00
		li_rc = lds_unique_keys.settransobject(stars2ca)
		
		if li_rc = -1 then 
			messagebox('ERROR','Error setting trans object in u_nvo_create_sql.ue_format_where_criteria_add_clauses')
			destroy(lds_unique_keys)	
			return -1
		end if
		
		if left(is_inv_type,1) = 'Q' then							// FNC 04/05/00 Start
			lnvo_revenue = create n_cst_revenue
			ls_main_tbl_type = lnvo_revenue.of_get_main_table(is_inv_type)
		else
			ls_main_tbl_type = is_inv_type
		end if
		
		//Archana 1-16-00  Correcting dependent table unique index issue
		li_uniq_keys = lds_unique_keys.retrieve(ls_dep_type)   
		//Archana 1-16-00 End

		if li_uniq_keys < 0 then 
			destroy(lds_unique_keys)
			return -1
		end if
		
		stars2ca.of_commit()							
		
		for li_key_row = 1 to li_uniq_keys
			ls_key[li_key_row] = lds_unique_keys.getitemstring(li_key_row,'elem_name')
			ls_data_type[li_key_row] = lds_unique_keys.getitemstring(li_key_row,'elem_data_type')
		next

		lb_dep_found = FALSE
		
		if as_type = 'WHERE' then
			li_num_where = upperbound(as_where)
			for li_where = 1 to li_num_where
				
				if left(as_where[li_where],1) = '(' then
					IF left(as_where[li_where],2) = '((' then
						ls_tbl_type = mid(as_where[li_where],3,2)
					ELSE
						ls_tbl_type = mid(as_where[li_where],2,2)
					END IF
				else
					ls_tbl_type = left(as_where[li_where],2)
				end if

				if ls_tbl_type = ls_dep_type then
				// MikeFl - Track SC3495 / 3271 - Begin
					IF li_where > 1 THEN
						IF right(as_where[li_where],3) = ' OR' &
						OR right(as_where[li_where - 1],3) 	= ' OR' THEN
							//Outer Join
							ib_or_loj = TRUE
						ELSE
							lb_dep_found = TRUE
							exit
						END IF
					ELSE
						IF right(as_where[li_where],3) = ' OR' THEN
							//Outer Join
							ib_or_loj = TRUE
						ELSE
							lb_dep_found = TRUE
							exit
						END IF
					END IF
				// MikeFl - Track 3495 /3271 - End
				end if
			next
			
			if lb_dep_found then
				ls_logical_connector	=	' = ' 
				lb_outer_join			=	FALSE				// FDG 11/21/00
			else
				ls_logical_connector	=	' *= ' 
				lb_outer_join			=	TRUE				// FDG 11/21/00
			end if										
			
			ib_outer_join = lb_outer_join
			
			IF lb_dep_found &
			OR ib_outer_join &
			OR (not lb_dep_found and not ib_subsetting) then	// FNC 04/12/00
			
				for li_key_row = 1 to li_uniq_keys
					// FDG 11/21/00 begin
					// If an outer join occurs, then set the appropriate instance variables and compute
					//	the where clause portion
					IF	lb_outer_join		THEN
						li_outer	=	UpperBound (is_outer_column1)
						li_outer	++
						is_outer_table1[li_outer]	=	gnv_dict.Event	ue_get_table_name(is_inv_type)
						is_outer_table2[li_outer]	=	gnv_dict.Event	ue_get_table_name(ls_dep_type)
						is_outer_column1[li_outer]	=	ls_key[li_key_row]
						is_outer_column2[li_outer]	=	ls_key[li_key_row]
						is_outer_alias1[li_outer]	=	is_inv_type
						is_outer_alias2[li_outer]	=	ls_dep_type
						ls_where_string	=	gnv_sql.of_left_outer_join_where	(is_outer_table1[li_outer],	&
																								is_outer_column1[li_outer],	&
																								is_outer_alias1[li_outer],		&
																								is_outer_table2[li_outer],		&
																								is_outer_column2[li_outer],	&
																								is_outer_alias2[li_outer])
						is_outer_from[li_outer]	=	gnv_sql.of_left_outer_join_from	(is_outer_table1[li_outer],	&
																								is_outer_alias1[li_outer],		&
																								is_outer_table2[li_outer],		&
																								is_outer_alias2[li_outer])
						IF	Trim (ls_where_string)	>	''		THEN
							ls_where_string			=	" AND ("	+	ls_where_string	+	")"
							as_where[li_rowcount]	=	ls_where_string
							li_rowcount	++
						END IF
					ELSE
						// No outer join
						ls_where_string	=	" AND ("	+	is_inv_type	+	"."	+	ls_key[li_key_row]	+	&
													ls_logical_connector	+	ls_dep_type	+	"."	+	&
													ls_key[li_key_row]	+	")"
						as_where[li_rowcount]	=	ls_where_string
						li_rowcount	++
					END IF
					// FDG 11/21/00	End
				next
			end if																				// FNC 04/12/00 
		else // as_type = 'CRITERIA'
			li_num_crit = upperbound(astr_criteria)
			for li_crit = 1 to li_num_crit
				if left(astr_criteria[li_crit].expression_one,1) = '(' then
					ls_tbl_type = mid(astr_criteria[li_crit].expression_one,2,2)
				else
					ls_tbl_type = left(astr_criteria[li_crit].expression_one,2)
				end if
				
				if ls_tbl_type = ls_dep_type then
				// MikeFl - Track SC3495 / 3271 - Begin		
					lb_dep_found = TRUE
			
					IF li_crit > 1 THEN
						IF astr_criteria[li_crit].logical_operator = 'OR' &
						OR astr_criteria[li_crit - 1].logical_operator = 'OR' THEN
							lb_outer_join = TRUE
							exit
						END IF
					ELSE
						IF astr_criteria[li_crit].logical_operator = 'OR' THEN
							lb_outer_join = TRUE
							exit
						END IF
					END IF
				// MikeFl - Track SC3495 / 3271 - End
				end if
			next
			
			IF lb_outer_join THEN
				ib_outer_join	=	TRUE
				ls_logical_connector =	gnv_sql.of_get_outer_rel_op()	
				ls_outer_exp2			=	gnv_sql.of_get_outer_exp2()	
			ELSE
				ls_logical_connector =	' = '
				ls_outer_exp2			=	''										
			end if
	
			// MikeFl 7/23/02 - Track 3495 - Reorg Begin
			IF lb_dep_found THEN
				for li_key_row = 1 to li_uniq_keys
					IF lb_outer_join THEN
						li_outer	=	UpperBound (is_outer_column1)
						li_outer	++
						is_outer_table1[li_outer]	=	gnv_dict.Event	ue_get_table_name(is_inv_type)
						is_outer_table2[li_outer]	=	gnv_dict.Event	ue_get_table_name(ls_dep_type)
						is_outer_column1[li_outer]	=	ls_key[li_key_row]
						is_outer_column2[li_outer]	=	ls_key[li_key_row]
						is_outer_alias1[li_outer]	=	is_inv_type
						is_outer_alias2[li_outer]	=	ls_dep_type
						ls_where_string	=	gnv_sql.of_left_outer_join_where	(is_outer_table1[li_outer],	&
																								is_outer_column1[li_outer],	&
																								is_outer_alias1[li_outer],		&
																								is_outer_table2[li_outer],		&
																								is_outer_column2[li_outer],	&
																								is_outer_alias2[li_outer])
						is_outer_from[li_outer]	=	gnv_sql.of_left_outer_join_from	(is_outer_table1[li_outer],	&
																								is_outer_alias1[li_outer],		&
																								is_outer_table2[li_outer],		&
																								is_outer_alias2[li_outer])
						IF	Trim (ls_logical_connector) >	''		THEN
						// ASE & Oracle will have a relational operator, UDB will not
							astr_criteria[li_rowcount - 1].logical_operator = "AND"
							astr_criteria[li_rowcount].left_paren = "("
							astr_criteria[li_rowcount].expression_one = is_inv_type + "." + ls_key[li_key_row]
							// MikeFl 7/23/02 - Track SC3495 - BEGIN

							IF as_type = 'CRITERIA' THEN
 						  		astr_criteria[li_rowcount].rel_operator = 'LOJ'
								astr_criteria[li_rowcount].expression_two = ls_dep_type + "." + ls_key[li_key_row]
							ELSE
								astr_criteria[li_rowcount].rel_operator = ls_logical_connector			
								astr_criteria[li_rowcount].expression_two = ls_dep_type + "." + ls_key[li_key_row] + ls_outer_exp2
							END IF
							// MikeFl 7/23/02 - Track SC3495 - END
							astr_criteria[li_rowcount].right_paren = ")"		
							astr_criteria[li_rowcount].data_type = ls_data_type[li_key_row]
							li_rowcount++
						END IF
					ELSE	// No outer join
						astr_criteria[li_rowcount - 1].logical_operator = "AND"
						astr_criteria[li_rowcount].left_paren = "("
						astr_criteria[li_rowcount].expression_one = is_inv_type + "." + ls_key[li_key_row]
						astr_criteria[li_rowcount].rel_operator = ls_logical_connector			//FNC 04/15/98
						astr_criteria[li_rowcount].expression_two = ls_dep_type + "." + ls_key[li_key_row] + ls_outer_exp2
						astr_criteria[li_rowcount].right_paren = ")"		
						astr_criteria[li_rowcount].data_type = ls_data_type[li_key_row]
						li_rowcount++
					END IF
				NEXT
			END IF	// lb_dep_found
		end if	// as_type
	end if // Dep Type
	// MikeFl 7/23/02 - Track 3495 - End Reorg
	destroy(lds_unique_keys)
	
end if
		
/* check for Drilldown */
if ib_drilldown then
	// FDG 07/31/98 begin
	IF	istr_drilldown.path	=	'AD'		THEN
		ls_inv_type	=	istr_drilldown.inv_type
	ELSE
		ls_inv_type	=	is_inv_type
	END IF
	// FDG 07/31/98 end
	
	/* if filling criteria, must get data type of join fields */
	li_join_count = upperbound(istr_drilldown.join_fields)
	if li_join_count > 0 then
		if as_type = 'CRITERIA' then
			for li_idx = 1 to li_join_count
				if istr_drilldown.join_fields[li_idx] <> '' then

					IF	li_rowcount	>	1		THEN
						astr_criteria[li_rowcount - 1].logical_operator = "AND"
					END IF
					
					ls_data_type1 = gnv_dict.event ue_get_elem_data_type(ls_inv_type, istr_drilldown.join_fields[li_idx])
					astr_criteria[li_rowcount].left_paren = "("
					astr_criteria[li_rowcount].expression_one = ls_inv_type + "." + &
																			istr_drilldown.join_fields[li_idx]
					/*outer join*/																		
					astr_criteria[li_rowcount].rel_operator = " = "
					astr_criteria[li_rowcount].expression_two = IC_TEMP_ALIAS + "." + &
																			istr_drilldown.join_fields[li_idx]
					astr_criteria[li_rowcount].right_paren = ")"
					astr_criteria[li_rowcount].data_type = ls_data_type1
					li_rowcount++
				end if
			next
		else
			// FDG 01/17/02 - If drilldown to additional data, use the join keys instead of 
			//						istr_drilldown.join_fields.
			IF	istr_drilldown.path	=	'AD'		THEN
				lds_unique_keys = create n_ds										// FNC 02/08/00 Start
				lds_unique_keys.dataobject = 'd_dependent_index'         //Archana 1-16-00
				li_rc = lds_unique_keys.settransobject(stars2ca)
				if li_rc = -1 then 
					messagebox('ERROR','Error setting trans object in u_nvo_create_sql.ue_format_where_criteria_add_clauses')
					destroy(lds_unique_keys)	
					return -1
				end if
				li_uniq_keys = lds_unique_keys.retrieve(ls_inv_type)   
				if li_uniq_keys < 0 then 
					destroy(lds_unique_keys)
					return -1
				end if
				stars2ca.of_commit()							
				for li_key_row = 1 to li_uniq_keys
					ls_join_key = lds_unique_keys.getitemstring(li_key_row,'elem_name')
					as_where[li_rowcount] = &
						" AND (" + ls_inv_type + "." + ls_join_key + &
						" = " + IC_TEMP_ALIAS + "." + ls_join_key + ")"
					li_rowcount	++
				next
				Destroy	lds_unique_keys
			ELSE
				for li_idx = 1 to li_join_count
					if istr_drilldown.join_fields[li_idx] <> '' then
						// FDG 05/27/98 - use is_inv_type instead of istr_drilldown.inv_type
						// FDG 07/31/98 - is_inv_type has the original invoice type (for additional data).
						//			istr_drilldown.inv_type has the new invoice type.  Use this.
						as_where[li_rowcount] = &
							" AND (" + ls_inv_type + "." + istr_drilldown.join_fields[li_idx] + &
							" = " + IC_TEMP_ALIAS + "." + istr_drilldown.join_fields[li_idx] + ")"
						li_rowcount++
					end if
				next
			END IF
			//	FDG 01/17/02 end
		end if
	end if
end if

/* check for FastTrack */
if left(is_inv_type,1) = 'Q' then
	/* must get main inv_type for the fasttrack inv_type and use that to get the 
	invoice type from the code table - must filter the revenue table by the invoice type
	since multiple invoice types use the revenue table */
//	ls_main_tbl_type = fx_fasttrack_invoice_type(is_inv_type)		// FNC 04/05/00 09/08/98
	if trim(ls_main_tbl_type) = '' then										// FNC 04/05/00
		lnvo_revenue = create n_cst_revenue										// FNC 09/08/98
		ls_main_tbl_type = lnvo_revenue.of_get_main_table(is_inv_type)	// FNC 09/08/98
		destroy(lnvo_revenue)														// FNC 09/08/98
	end if																			// FNC 04/05/00
		
	SELECT min(code_code)
	INTO   :ls_invoice_type
	FROM   Code
   WHERE  code_type = 'IT'
   AND    code_value_a = Upper( :ls_main_tbl_type )
   Using STARS2CA;
	
	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error retrieving main invoice type (uo_query.ue_format_where_criteria_add_clauses)')
		return -1
	else												// FNC 04/13/99
		stars2ca.of_commit()						// FNC 04/13/99
	end if
		
	if as_type = "WHERE" then

	// KTB - Track #2882 If doing a drilldown we want to use the Additional Data Source
	//                   invoice type, ls_inv_type. Else this is a first level query
	//                   and we want to use the Data Source invoice type, is_inv_type.
      if ib_drilldown then
			//	04/17/01	GaryR	Stars 4.6
		else								
			as_where[li_rowcount] = " AND " + is_inv_type + ".INVOICE_TYPE = '" + &
											ls_invoice_type + "'"
		end if
	// End KTB
	else
		astr_criteria[li_rowcount - 1].logical_operator = "AND"	
		astr_criteria[li_rowcount].expression_one = is_inv_type + ".INVOICE_TYPE"
		astr_criteria[li_rowcount].rel_operator = " = "
		astr_criteria[li_rowcount].expression_two = "'" + ls_invoice_type + "'"
		astr_criteria[li_rowcount].data_type = "CHAR"
	end if
end if

return 0
end event

event type integer ue_check_filter_data_type(ref string as_data_type, string as_filter_id);//*********************************************************************
//	Script:		u_nvo_create_sql.ue_check_filter_data_type
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	This event is called by uo_query.ue_format_where_criteria and
//		will replace global function fx_check_filter_data_type.
//		This script will check the filter structure or table filter_cntl
//		for the filter ID.  If found, it will return the data type and
//		the filter column.
//
//*********************************************************************
//	History
//
//	FDG	04/16/98	Track 971.  Created.
//
//	FDG	06/15/98	Track ????.  Move script from w_query_engine.
// AJS   12-08-98 Track #D2023 Added date.
// FNC	04/13/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
//	FDG	12/14/00	Stars 4.7.  Make the checking of data types DBMS-independent.
//	GaryR	05/17/01	Stars 4.7	Make data types transparent to the DBMS
//	GaryR	02/22/06	Track 4666	Call global method to check the delete indicator
//
//*********************************************************************

SetPointer (HourGlass!)

Integer		li_max,			&
				li_idx
				
Boolean		lb_found

li_max	=	UpperBound (isx_filter_info)

FOR li_idx	=	1 TO li_max
	IF	isx_filter_info [li_idx].filter_id	=	as_filter_id		THEN
		lb_found	=	TRUE
		as_data_type	=	isx_filter_info [li_idx].data_type
		Exit
	END IF
NEXT

IF	NOT	lb_found		THEN
	// filter does not exist in the structure.  Find it in filter_cntl.
	as_data_type = gnv_app.of_get_filter_type( as_filter_id )
	IF as_data_type <> "ERROR" THEN lb_found	=	TRUE
END IF

IF	lb_found	=	FALSE			THEN
	MessageBox ('Error', 'Filter does not exist', Stopsign!)
	Return -1
END IF

// Based on the data type, get the appropriate column to use within
// table filter_vals
// AJS 12-08-98 Track #D2023 Added date & moved float from filter_num to filter_money
// FDG 12/14/00 - Make the checking of data types DBMS-independent.

IF	gnv_sql.of_is_character_data_type (as_data_type)	THEN
	as_data_type	=	'CHAR'				//	GaryR	05/17/01	Stars 4.7
ELSEIF gnv_sql.of_is_number_data_type (as_data_type)	THEN
	as_data_type	=	'NUMBER'				//	GaryR	05/17/01	Stars 4.7
ELSEIF gnv_sql.of_is_money_data_type (as_data_type)	THEN
	as_data_type	=	'MONEY'				//	GaryR	05/17/01	Stars 4.7
ELSEIF gnv_sql.of_is_date_data_type (as_data_type)		THEN
	as_data_type	=	'DATE'				//	GaryR	05/17/01	Stars 4.7
END IF
// FDG 12/14/00 end

Return 0
end event

event type integer ue_format_where_criteria_super_prov(ref sx_criteria astr_criteria[], ref string as_where[], ref string as_exp2, string as_logic_op, boolean ab_subsetting, boolean ab_npi);/*u_nvo_create_sql.UE_FORMAT_WHERE_CRITERIA_SUPER_PROV

This event will load the criteria structure with Provider columns selected for 
a Super Provider Query.  The selected columns are found in istr_prov_query which
is loaded when the user selects SuperPv in tabpage_search.  This event is called 
by ue_format_where_criteria().*/

//*************************************************************************
//12-10-97 FNC Created
//	FDG	06/15/98	Track ????.  Script moved from uo_query.
//	FDG	03/05/02	Track 2857d. Column-to-column comparison on MC queries must
//						change 'MC' to actual invoice type.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//*************************************************************************

integer li_prov_count,	&
			j,					&
			k

string	ls_exp2, ls_clause		// FDG 03/05/02
Boolean	lb_first_prov_selected
sx_prov_query_structure	lsx_prov_query

//	Initialize proper structure
IF ab_npi THEN
	lsx_prov_query = istr_npi_prov_query
ELSE
	lsx_prov_query = istr_prov_query
END IF

ls_exp2	=	as_exp2		// FDG 03/05/02

li_prov_count = upperbound(lsx_prov_query.prov_fields)

IF ab_subsetting THEN
	j = upperbound(astr_criteria)
	for k = 1 to li_prov_count
		if lsx_prov_query.prov_fields[k].selected then
			// FDG 03/05/02 - look for column-to-column with MC.  If so, change MC to the
			//						appropriate invoice type.
			IF	Upper (Left(as_exp2, 3)	)	=	'MC.'		THEN
				ls_exp2	=	lsx_prov_query.prov_fields[k].table_type	+	'.'	+	&
								Mid (as_exp2, 4)
			END IF
			// FDG 03/05/02 end
			j ++  //	increase the counter
			astr_criteria[j].expression_one = lsx_prov_query.prov_fields[k]. &
				table_type + "." + lsx_prov_query.prov_fields[k].prov_col_name
			astr_criteria[j].rel_operator = lsx_prov_query.relational_op
			astr_criteria[j].expression_two = ls_exp2				// FDG 03/05/02
			astr_criteria[j].logical_operator = "OR"
			
			if NOT lb_first_prov_selected then
				lb_first_prov_selected = TRUE
				//	If first provider then add Parenthesis for beginning of statement
				astr_criteria[j].left_paren = lsx_prov_query.left_paren + "("
			end if
		end if
	next
	//	Add closing parenthesis for OR statement and the logical operator
	astr_criteria[j].right_paren = ")" + lsx_prov_query.right_paren
	astr_criteria[j].logical_operator = as_logic_op
ELSE
	j = upperbound(as_where)
	for k = 1 to li_prov_count
		if lsx_prov_query.prov_fields[k].selected then
			if NOT lb_first_prov_selected then
				lb_first_prov_selected = TRUE
				//	If first provider then add Parenthesis for beginning of statement
				ls_clause = " " + lsx_prov_query.left_paren + "("
			else
				ls_clause = ' OR '
			end if
			// FDG 03/05/02 - IF column-to-column with MC, change MC to appropriate invoice type
			IF	Upper (Left(as_exp2, 3))	=	'MC.'		THEN
				ls_exp2	=	lsx_prov_query.prov_fields[k].table_type	+	'.'	+	&
								Mid (ls_exp2, 4)
			END IF
			// FDG 03/05/02 end
			j ++  //	increase the counter
			as_where[j] = ls_clause + &
					upper(lsx_prov_query.prov_fields[k].table_type) + "." + &
					upper(lsx_prov_query.prov_fields[k].prov_col_name) + " " + &
					upper(lsx_prov_query.relational_op) + " " + upper(ls_exp2)
		end if
	next
	//	Add closing parenthesis for OR statement and the logical operator
	as_where[j] += ")" + lsx_prov_query.right_paren + " " + as_logic_op
END IF

Return j
end event

event type string ue_create_select(string as_inv_type, ref string as_join[]);//*********************************************************************************
// Event Name:	U_NVO_Create_SQL.UE_Create_Select
//	Arguments:	String	as_inv_type
//					String	as_join[]
// Returns:		String
//
//*********************************************************************************
// 12-04-97 FNC	Created
//
//	02/03/98	FDG	Call of_check_status() after each embedded SQL.
// 2/13/98 	JTM	Added code to populate the column name and number of the break info
//						structure.
// 02/25/98 FNC	Track 842.  Place invoice type in front of * for the special
//						select statements	to accomodate joins. If there is no table type 
//						in front of * then the sql return columns from both of the tables.
// 03/05/98	FNC	Track 881.  Use as_inv_type as prefix for columns instead
//						of ls_selected_tbl_type if the query is MC.
// 03/10/98 FNC 	Added check for UB92 to non ML queries. 
//	03/17/98	FDG	Track 871.  Determine if any rows exist in w_main.dw_stars_rel_dict
//						after filtering it.  
//						NOTE:	ML invoice types will never return any rows after filtering
//								w_main.dw_stars_rel_dict.
// 03/26/98 FNC	Track 912.  If viewing an ML subset select default values if a field 
//						is not on the specific claim type.
// 04/02/98 FNC 	Track 1007. Do not populate as_join if not ML subset. 
// 04/13/98 HRB	Track 1006. Do not get join table if Fasttrack.
// 06/11/98	FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
// 06/18/98	FNC	Track 1357.Break info col_name was not getting set for UB92 
//						querries.
//	08/05/98	FDG	Track 1235, 1248.  If coming from drilldown (additional data)
//						then don't add the key columns to the select.  These key
//						columns come from the original invoice type.
// 04/13/99 FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
// 11/16/00 GaryR Stars 4.7 DataBase Port - Conversion of datatypes
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
//	08/02/01	FDG	Track ???? (STARS 4.6 SP1).  Get the columns selected and
//						store them in an instance array to be returned to u_nvo_view
//	09/18/01	GaryR	Track	2412d	Use single quotes instead
//						of double quotes for column values.
// 10/11/01	FNC	Track 2444. Always allow Break with totals so always populate
//						break info structure with column name.
//	10/16/01	GaryR	Track	2412d	Add comma to date field.
// 03/18/02	FDG	Track 2875d.  Drilldown to 'MC' (with including columns) generates
//						incorrect Select clause.
//	02/10/04	GaryR	Track 6453c	For UB92 types, if invoice is MC, check if header or revenue
// 03/02/04 MikeF	Track 3909d Getting count with Views + addtl data source was slow.
// 03/04/04 MikeF	Track 3921d Using a LOJ with a UNION ALL View gives DB error
// 03/22/04 MikeF Track 3951d SELECT 1 if either main or dependent UNION ALL view
//	04/07/04	GaryR	Track 3844d	Add aliases to dummy columns to prevent Oracle bug
// 10/20/04 MikeF Track 3650d Computed columns. Rewrote.
// 01/06/06	GaryR	Track 4585d	Set the join to include revenue not main invoice
//	10/18/06	GaryR	Track 4832	Prevent dummy values for columns disabled in the DICTIONARY
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************
/*If creating SQL for subsetting will return select all or if creating sql for 
count return select count(*) else will take the columns selected in tabpage_report
and string together to create the SELECT clause.  If viewing an ML subset the select
clause will use table_type to determine which columns to select and which to set to 
null.  One hitch is that when viewing an ML subset with a UB92 invoice type, the 
user is allowed to select columns from the revenue table.  If they do, this causes 
a join between the UB92 and revenue table.  Use stars_win_parm to determine the 
table type for the revenue table. Put the table type(s) from stars_win_parm into 
as_join[] so that know to add to the FROM and WHERE clauses.    If columns are 
selected for Break with Totals, then the column name and sequence number is added 
to the Break with Total structure to use later when modify the datawindow.  Finally
must add key columns if they are not part of the selected columns.  These will be 
added to the end of the select and made invisible after the datawindow is created.
Note:  May have to limit the number of columns in the report due to limitation  of 
fx_dw_syntax. cannot just return select clause in case have ML that requires join, 
must fill join array before returning */

boolean	lb_found
string	ls_select, ls_sql, ls_base_type, ls_rev_type
string	ls_tbl_type, ls_elem_name, ls_data_type, ls_elem_type
int		li_columns, loop_ix, loop_ix2, li_rowcount, li_joins, li_col_rows
n_ds		lds_cols
n_cst_stars_rel	lnv_rel

// If subsetting, then SELECT *
IF ib_subsetting THEN
	ls_select = "SELECT " + as_inv_type + ".* "
	RETURN ls_select
END IF

// IF selecting COUNT(*)
IF ib_count THEN
	ls_select = gnv_sql.of_get_count_sql( inv_base.ib_view, inv_addtl.ib_view, &
				inv_base.is_inv_type, inv_addtl.is_inv_type, ib_use_datastore_count)
	RETURN ls_select
END IF

// Get Base, Revenue types
if lnv_rel.of_get_is_claims(as_inv_type) then 
	ls_base_type 	= lnv_rel.of_get_base_type(as_inv_type)
	IF  lnv_rel.of_get_is_ub92( as_inv_type ) &
		AND left(as_inv_type,1) <> 'Q' THEN
		ls_rev_type	= lnv_rel.of_get_revenue( as_inv_type )
	ELSE
		ls_rev_type = " "
	END IF
else
	ls_rev_type = " "
	ls_base_type = " "
end if
		
// Retrieve Column Info
li_rowcount = idw_selected.Rowcount( )

// Get Header/Revenue datastore if needed
IF  is_inv_type  = "ML" &
AND ls_base_type = "UB92" THEN
	lds_cols = Create n_ds
	lds_cols.dataobject = "d_selected"
	lds_cols.SetTransObject( Stars2ca )
	ls_sql = "select distinct elem_desc, "+ &
				"elem_tbl_type, elem_name, crit_seq, elem_col_number, elem_data_type, "  	+ &
				"DISP_SEQ, ELEM_DATA_LEN, ELEM_DATA_SCALE, DISP_FORMAT,ELEM_TYPE "		 	+ &
				"from dictionary where elem_type IN ('CL','CC') and elem_tbl_type in ('" 	+ &
				Upper( as_inv_type ) + "','" + Upper( ls_rev_type ) + "')"
	lds_cols.SetSQLSelect( ls_sql )
	li_col_rows = lds_cols.retrieve()
	IF li_col_rows < 1 THEN
		Destroy lds_cols
		Return "ERROR"
	END IF
END IF

// Set SELECT statement
ls_select = "SELECT "

FOR loop_ix = 1 TO li_rowcount
	
	IF loop_ix > 1 THEN
		ls_select += ","
	END IF

	ls_tbl_type  = idw_selected.GetItemString(loop_ix,"ELEM_TBL_TYPE")
	ls_elem_name = idw_selected.GetItemString(loop_ix,"ELEM_NAME")
	ls_data_type = idw_selected.GetItemString(loop_ix,"ELEM_DATA_TYPE")
	ls_elem_type = idw_selected.GetItemString(loop_ix,"ELEM_TYPE")

	// ???
	is_select_column[loop_ix] = ls_elem_name
	
	IF is_inv_type = 'ML' THEN
		
		CHOOSE CASE ls_tbl_type
					
			CASE as_inv_type

				ls_select += this.uf_get_col_select(ls_elem_type, ls_tbl_type, ls_elem_name)
				
			CASE ls_rev_type
				
				ls_select += this.uf_get_col_select(ls_elem_type, ls_tbl_type, ls_elem_name)
				this.uf_add_join( as_join, ls_rev_type)
				
			CASE "MC"
	
				IF ls_base_type="UB92" THEN
					IF lds_cols.Find( "elem_tbl_type = '" 	+ as_inv_type 	+ "' AND " + &
											"elem_name = '" 		+ ls_elem_name + "'", 0, li_col_rows ) > 0 THEN 
						ls_select += this.uf_get_col_select(ls_elem_type, as_inv_type, ls_elem_name)
					ELSEIF lds_cols.Find( "elem_tbl_type = '" + ls_rev_type 	+ "' AND " + &
											"elem_name = '" + ls_elem_name + "'", 0, li_col_rows ) > 0 THEN
						ls_select += this.uf_get_col_select(ls_elem_type, ls_rev_type, ls_elem_name)
						this.uf_add_join( as_join, ls_rev_type)
					ELSE
						ls_select += this.uf_get_dummy_col_select( ls_data_type, loop_ix)
					END IF	
				ELSE
					ls_select += this.uf_get_col_select(ls_elem_type, as_inv_type, ls_elem_name)
				END IF
			
			CASE ELSE // Column from another Invoice type 
				ls_select += this.uf_get_dummy_col_select( ls_data_type, loop_ix)
		
		END CHOOSE
	
	ELSE 	// Non-ML
		IF  is_inv_type =  'MC' &
		AND ls_tbl_type <> 'TMP' THEN
			ls_select += this.uf_get_col_select(ls_elem_type, as_inv_type, ls_elem_name)
		ELSE
			ls_select += this.uf_get_col_select(ls_elem_type, ls_tbl_type, ls_elem_name)
		END IF
	END IF

NEXT

// Add additional KEY columns
ls_select = This.event ue_add_key_cols_to_select(ls_select,li_rowcount,as_inv_type)

RETURN ls_select
end event

public subroutine uf_set_source_dw_source (ref u_dw adw_source);idw_source = adw_source
end subroutine

public subroutine uf_set_search_dw_criteria (ref u_dw adw_criteria);idw_criteria = adw_criteria
end subroutine

public subroutine uf_set_report_dw_selected (ref u_dw adw_selected);idw_selected = adw_selected
end subroutine

public subroutine uf_set_istr_drilldown (ref sx_drilldown astr_drilldown);istr_drilldown = astr_drilldown
end subroutine

public subroutine uf_set_subset_id (ref string as_subset_id);is_subset_id = as_subset_id
end subroutine

public subroutine uf_set_data_type (ref string as_data_type);is_data_type = as_data_type
end subroutine

public subroutine uf_set_ib_drilldown (ref boolean ab_drilldown);ib_drilldown = ab_drilldown
end subroutine

public subroutine uf_set_source_type (ref string as_source_type);is_source_type = as_source_type
end subroutine

public subroutine uf_set_source_subset_id (ref string as_source_subset_id);is_source_subset_id = as_source_subset_id
end subroutine

public subroutine uf_set_inv_type (ref string as_inv_type);is_inv_type = as_inv_type
end subroutine

public subroutine uf_set_sub_filter_count (ref integer ai_sub_filter_count);ii_sub_filter_count = ai_sub_filter_count
end subroutine

public subroutine uf_set_filter_count (ref integer ai_filter_count);ii_filter_count = ai_filter_count
end subroutine

public subroutine uf_set_ib_subsetting (ref boolean ab_subsetting);ib_subsetting = ab_subsetting
end subroutine

public subroutine uf_set_istr_subsetting_info (ref sx_subsetting_info astr_subsetting_info);istr_subsetting_info = astr_subsetting_info
end subroutine

public subroutine uf_set_ib_count (ref boolean ab_count);ib_count = ab_count
end subroutine

public subroutine uf_set_iuo_period (ref u_display_period auo_period);iuo_period = auo_period
end subroutine

public subroutine uf_set_drilldown_previous_temp_table (ref string as_drilldown_previous_temp_table);is_drilldown_previous_temp_table = as_drilldown_previous_temp_table
end subroutine

public subroutine uf_set_istr_break_info (ref sx_break_info astr_break_info);istr_break_info	=	astr_break_info

end subroutine

public subroutine uf_set_istr_prov_query (ref sx_prov_query_structure astr_prov_query);istr_prov_query	=	astr_prov_query
end subroutine

public subroutine uf_set_istr_sql_statement (ref sx_sql_statement_container astr_sql_container);istr_sql_container	=	astr_sql_container
istr_sql_statement	=	astr_sql_container.lsx_sql_statement

end subroutine

public subroutine uf_set_istr_key_columns (ref sx_keys astr_key_columns);istr_key_columns	=	astr_key_columns

end subroutine

public subroutine uf_set_ib_ancillary_inv_type (ref boolean ab_ancillary_inv_type);ib_ancillary_inv_type	=	ab_ancillary_inv_type

end subroutine

public subroutine uf_set_isx_filter_info (ref sx_filter_info_container asx_filter_container);isx_filter_info	=	asx_filter_container.lsx_filter_info



end subroutine

public function sx_sql_statement_container uf_get_istr_sql_container ();Return	istr_sql_container

end function

public function sx_subsetting_info uf_get_istr_subsetting_info ();Return	istr_subsetting_info

end function

public function sx_prov_query_structure uf_get_istr_prov_query ();Return	istr_prov_query

end function

public subroutine uf_set_run_frequency (integer ai_run_frequency);//	u_nvo_create_sql.uf_set_run_frequency
//
//	This function stores the run frequency (in months) so it can
//	be passed to subset options
//
//	Arguments:	ai_run_frequency
//	Returns:		None
//	History
//	10-27-99	NLG	Created.  ts2463c
//
///////////////////////////////////////////////////////////////

ii_run_frequency = ai_run_frequency

end subroutine

public subroutine uf_set_pd_opt_desc (string as_pd_opt_desc);//	u_nvo_create_sql.uf_set_pd_opt_desc
//	
//	This function sets the instance variable for
//	the payment date options ddlb
//
//	Arguments:	string as_pd_opt_desc
//	Returns:		none
//
//	History:	
//	10-27-99	NLG	ts2364c.  Created.
////////////////////////////////////////////////////////////////

is_pd_opt_desc = as_pd_opt_desc
end subroutine

public function integer uf_set_ib_recurring_pdq (ref boolean ab_switch);//*********************************************************************************
// Script Name:	u_nvo_create_sql.uf_set_ib_recurring_pdq
//
//	Arguments:		boolean ab_switch
//						
//
// Returns:			integer
//
//	Description:	Set the instance variable that determines if this is a 
//						future dated pdq.
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

public subroutine uf_set_fastquery_ind (string as_fastquery_ind);// FDG 07/17/00 Track 2465c.  Stars 4.5 SP1.  Created.

is_fastquery_ind	=	as_fastquery_ind

end subroutine

public subroutine uf_set_fastquery_rows (long al_fastquery_rows);// FDG 07/17/00 Track 2465c.  Stars 4.5 SP1.  Created.

il_fastquery_rows	=	al_fastquery_rows

end subroutine

public function boolean uf_remove_payment_date (string as_date, string as_operator);//*********************************************************************
//	Script:		u_nvo_create_sql.uf_remove_payment_date
//
//	Arguments:	as_date 		-	Date entered in the criteria
//					as_operator -	Relational operator entered in the criteria
//
//	Returns:		Boolean
//					TRUE	=	Remove payment date from the Where clause
//					FALSE	=	Leave payment date in the Where clause
//
//	Description:
// 	This function will determine if the payment date is to be included
//		in the Where clause of the SQL.  The default value returned is
//		FALSE (include payment date in the SQL).  This function is called
//		from ue_format_where_criteria when the column is payment_date.
//		
//
//*********************************************************************
//	History
//
//	FDG	07/12/00	Track 2365c.  Stars 4.5 SP1.  Created.
//	FDG	03/09/01	Stars 4.7.	Function no longer used since ros_directory
//						is no longer used.
//
//*********************************************************************

//Integer	li_pos
//
//Long		ll_find_row,			&
//			ll_rowcount
//
//String	ls_date1,				&
//			ls_date2,				&
//			ls_datetime1,			&
//			ls_datetime2,			&
//			ls_find
//			
//Date		ldt_date1,				&
//			ldt_date2
//			
//DateTime	ldtm_datetime1,		&
//			ldtm_datetime2
//
//// If the query was performed against a subset, include payment date
////	in the Where clause.
//IF	Trim (is_subset_id)	<>	''				&
//OR	Upper (is_data_type)	=	'SUBSET'		THEN
//	Return	FALSE
//END IF
//
//// The operator must be between, >= or <=
//IF	 Upper (as_operator)	<>	'BETWEEN'	&
//AND as_operator			<>	'>='			&
//AND as_operator			<>	'<='			THEN
//	Return	FALSE
//END IF
//
//// as_date must be parsed into two separate dates if using 'between'
//
//// Look for a comma to determine if 1 or 2 dates exist
//li_pos		=	Pos (as_date, ',')
//
//IF	li_pos	=	0		THEN
//	// One date.  Operator must be >= or <=
//	ls_date1	=	as_date
//	IF	 as_operator	<>	'>='		&
//	AND as_operator	<>	'<='		THEN
//		Return	FALSE
//	END IF
//ELSE
//	// Two dates.  Operator must be 'between'
//	IF	 Upper (as_operator)	<>	'BETWEEN'	THEN
//		Return	FALSE
//	END IF
//	ls_date1	=	Left (as_date, li_pos - 1)
//	ls_date2	=	Mid  (as_date, li_pos + 1)
//END IF
//
//// The string dates need to be converted to datetime strings so that
//// ros_directory can be searched
//ldt_date1		=	Date (ls_date1)
//ldtm_datetime1	=	DateTime (ldt_date1)
//ls_datetime1	=	String (ldtm_datetime1)
//
//IF	Len (ls_date2)	>	0		THEN
//	ldt_date2		=	Date (ls_date2)
//	ldtm_datetime2	=	DateTime (ldt_date2)
//	ls_datetime2	=	String (ldtm_datetime2)
//END IF
//
//// Use the datetime strings to search ros_directory (which has already
////	been retrieved within ue_create_sql).  Payment date is excluded from
////	the Where clause under the following conditions:
////	1. 'between' is used and both dates are found
////	2. '>=' is used and the from_date is found
////	3.	'<=' is used and the to_date is found
//
//ll_rowcount		=	ids_ros_dir.RowCount()
//
//CHOOSE CASE	Upper(as_operator)
//	CASE	'BETWEEN'
//		ls_find		=	"from_date = DateTime('"	+	ls_datetime1	+	"')"
//		ll_find_row	=	ids_ros_dir.Find (ls_find, 1, ll_rowcount)
//		IF	ll_find_row	<	1		THEN
//			Return	FALSE
//		END IF
//		ls_find		=	"to_date = DateTime('"	+	ls_datetime2	+	"')"
//		ll_find_row	=	ids_ros_dir.Find (ls_find, 1, ll_rowcount)
//		IF	ll_find_row	>	0		THEN
//			// Both dates found
//			Return	TRUE
//		ELSE
//			Return	FALSE
//		END IF
//	CASE	'>='
//		ls_find		=	"from_date = DateTime('"	+	ls_datetime1	+	"')"
//		ll_find_row	=	ids_ros_dir.Find (ls_find, 1, ll_rowcount)
//		IF	ll_find_row	>	0		THEN
//			// Date found
//			Return	TRUE
//		ELSE
//			Return	FALSE
//		END IF
//	CASE	'<='
//		ls_find		=	"to_date = DateTime('"	+	ls_datetime1	+	"')"
//		ll_find_row	=	ids_ros_dir.Find (ls_find, 1, ll_rowcount)
//		IF	ll_find_row	>	0		THEN
//			// Date found
//			Return	TRUE
//		ELSE
//			Return	FALSE
//		END IF
//END CHOOSE

Return	FALSE


end function

public function sx_break_info uf_get_istr_break_info ();return istr_break_info
end function

public function n_cst_tableinfo_attrib uf_get_base_tables ();Return	inv_base

end function

public function n_cst_tableinfo_attrib uf_get_additional_tables ();Return	inv_addtl

end function

public function sx_select_column uf_get_select_column ();//	08/02/01	FDG	Track ???? (STARS 4.6 SP1).  Get the columns selected from
//						is_select_column[] to be returned to u_nvo_view

sx_select_column	lstr_select_column

lstr_select_column.s_select_column	=	is_select_column

Return	lstr_select_column


end function

public function boolean uf_get_is_view (string as_inv_type);//--------------------------------------------------------------------------------//
//	u_nvo_create_sql.uf_get_is_view
//
//	Determines whether or not the current table is a view
//
//--------------------------------------------------------------------------------//
// 03/03/04	MikeF	SPR3921d	Using a LOJ with a UNION ALL View gives DB error
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//--------------------------------------------------------------------------------//

int		li_rc
String	ls_inv_type

ls_inv_type = Trim( Upper( as_inv_type ) )

SELECT count(*)
INTO :li_rc
FROM DICTIONARY
WHERE ELEM_TYPE = 'TB'
AND ELEM_DATA_TYPE = 'VIEW'
AND ELEM_TBL_TYPE = :ls_inv_type
Using Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN Return FALSE
Stars2ca.of_commit()	//Release locks

//If view return true
IF li_rc = 1 THEN	RETURN TRUE

RETURN FALSE
end function

public function boolean uf_get_use_ds_counts ();//--------------------------------------------------------------------------------//
//	u_nvo_create_sql.uf_use_ds_counts
//
//	Returns boolean set by n_cst_sql.of_get_count_sql
//
//--------------------------------------------------------------------------------//
// 03/03/04	MikeF	SPR3921d	Using a LOJ with a UNION ALL View gives DB error
//--------------------------------------------------------------------------------//
RETURN ib_use_datastore_count
end function

public function string uf_get_dummy_col_select (string as_data_type, integer as_index);
string	ls_select

IF gnv_sql.of_is_character_data_type (as_data_type)	THEN
	ls_select = "' ' AS ~"" + String( as_index ) + "~""	
ELSEIF gnv_sql.of_is_date_data_type (as_data_type)	THEN
	ls_select = gnv_sql.of_get_to_date( "'01/01/1900'" ) + ' AS "' + String( as_index ) + '"'
ELSEIF gnv_sql.of_is_number_data_type (as_data_type)	THEN
	ls_select = '0 AS "' 	+ String( as_index ) + '"'
ELSEIF gnv_sql.of_is_money_data_type (as_data_type)	THEN
	ls_select = '0.00 AS "' + String( as_index ) + '"'
END IF

RETURN ls_select
end function

public function string uf_get_col_select (string as_elem_type, string as_tbl_type, string as_col_name);//	02/22/05	GaryR	Track 4308d	Do not lookup temp table columns

IF as_tbl_type = "TMP" OR as_elem_type = 'CL' THEN
	RETURN as_tbl_type + "." + as_col_name
END IF

// Column is computed, return the Formula
RETURN gnv_dict.event ue_get_formula( as_tbl_type, as_col_name) + " AS " + as_col_name

end function

public function string uf_get_criteria (integer ai_index, string as_column);string  ls_string

ls_string = trim(idw_criteria.GetItemString(ai_index,as_column))

IF IsNull(ls_string) THEN ls_string =''

RETURN ls_string
end function

public function boolean uf_get_is_blank (integer ai_index, string as_object);IF this.uf_get_criteria( ai_index, as_object ) = '' THEN 
	RETURN TRUE
END IF

RETURN FALSE

end function

public function string uf_get_col_where (string as_expression);int		li_pos
string 	ls_tbl_type, ls_col_name
string	ls_column

li_pos = pos(as_expression,'.')
		
ls_tbl_type = left(as_expression,li_pos - 1)
ls_col_name	= mid (as_expression,li_pos + 1)

IF ls_tbl_type = 'TMP' THEN
	RETURN as_expression
ELSE
	// Column is computed, return the Formula
	IF gnv_dict.event ue_get_is_computed( ls_tbl_type, ls_col_name ) THEN
		RETURN gnv_dict.event ue_get_formula( ls_tbl_type, ls_col_name ) 
	END IF
END IF

RETURN as_expression

end function

public subroutine uf_add_join (ref string as_join[], string as_inv_type);int		li_joins, li_index
boolean	lb_found

li_joins = UpperBound(as_join)
lb_found = FALSE	

FOR li_index = 1 TO li_joins
	IF as_join[li_index] = as_inv_type then
		lb_found = TRUE
		EXIT
	END IF
NEXT
		
IF NOT lb_found THEN
	li_joins++
	as_join[li_joins] = as_inv_type
END IF
end subroutine

public subroutine uf_set_istr_npi_prov_query (ref sx_prov_query_structure astr_prov_query);//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider

istr_npi_prov_query	=	astr_prov_query
end subroutine

public function sx_prov_query_structure uf_get_istr_npi_prov_query ();//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider

Return	istr_npi_prov_query

end function

on u_nvo_create_sql.create
call super::create
end on

on u_nvo_create_sql.destroy
call super::destroy
end on

