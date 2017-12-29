$PBExportHeader$w_random_sampling_unique_hics.srw
$PBExportComments$DW that shows just unique hics (Inherited from w_master)
forward
global type w_random_sampling_unique_hics from w_master
end type
type dw_sample_method from u_dw within w_random_sampling_unique_hics
end type
type cbx_add_rpt from checkbox within w_random_sampling_unique_hics
end type
type st_distinct_sample_size from statictext within w_random_sampling_unique_hics
end type
type st_selected_count from statictext within w_random_sampling_unique_hics
end type
type st_distinct_sample_desc from statictext within w_random_sampling_unique_hics
end type
type cb_2 from u_cb within w_random_sampling_unique_hics
end type
type st_1 from statictext within w_random_sampling_unique_hics
end type
type st_4 from statictext within w_random_sampling_unique_hics
end type
type st_3 from statictext within w_random_sampling_unique_hics
end type
type rb_across_providers from radiobutton within w_random_sampling_unique_hics
end type
type rb_within_prov from radiobutton within w_random_sampling_unique_hics
end type
type cb_prov_counts from u_cb within w_random_sampling_unique_hics
end type
type cb_3 from u_cb within w_random_sampling_unique_hics
end type
type st_selectedproviders from statictext within w_random_sampling_unique_hics
end type
type cb_apply_random_sample from u_cb within w_random_sampling_unique_hics
end type
type cb_1 from u_cb within w_random_sampling_unique_hics
end type
type dw_2 from u_dw within w_random_sampling_unique_hics
end type
type st_providercount from statictext within w_random_sampling_unique_hics
end type
type cb_close from u_cb within w_random_sampling_unique_hics
end type
type gb_2 from groupbox within w_random_sampling_unique_hics
end type
type dw_3 from u_dw within w_random_sampling_unique_hics
end type
type gb_1 from groupbox within w_random_sampling_unique_hics
end type
type dw_sample_size from u_dw within w_random_sampling_unique_hics
end type
type gb_sample_size from groupbox within w_random_sampling_unique_hics
end type
type dw_1 from u_dw within w_random_sampling_unique_hics
end type
type gb_3 from groupbox within w_random_sampling_unique_hics
end type
end forward

global type w_random_sampling_unique_hics from w_master
string accessiblename = "Random Sampling Universe"
string accessibledescription = "Random Sampling Universe"
accessiblerole accessiblerole = windowrole!
integer x = 110
integer y = 100
integer width = 2953
integer height = 1984
string title = "Random Sampling Universe"
long backcolor = 67108864
event ue_universe_count pbm_custom11
event ue_selected_count pbm_custom12
event ue_getselectedproviders pbm_custom13
event ue_countforprovider pbm_custom14
event ue_sample_size ( )
event ue_sample_method ( )
dw_sample_method dw_sample_method
cbx_add_rpt cbx_add_rpt
st_distinct_sample_size st_distinct_sample_size
st_selected_count st_selected_count
st_distinct_sample_desc st_distinct_sample_desc
cb_2 cb_2
st_1 st_1
st_4 st_4
st_3 st_3
rb_across_providers rb_across_providers
rb_within_prov rb_within_prov
cb_prov_counts cb_prov_counts
cb_3 cb_3
st_selectedproviders st_selectedproviders
cb_apply_random_sample cb_apply_random_sample
cb_1 cb_1
dw_2 dw_2
st_providercount st_providercount
cb_close cb_close
gb_2 gb_2
dw_3 dw_3
gb_1 gb_1
dw_sample_size dw_sample_size
gb_sample_size gb_sample_size
dw_1 dw_1
gb_3 gb_3
end type
global w_random_sampling_unique_hics w_random_sampling_unique_hics

type variables
Long			iv_line_univ		//GaryR 02/10/04	Track 3840d	Changed to Long

// Replaces the radiobuttons for "Sample Size Per Provide"
// Only set in event ue_sample_size.
Integer			ii_sample_size


Long			iv_lProviderCount[]
Long			iv_lProviderOffSet[]
Long			iv_lProviderSampleSize[]
Long			ii_RowCount  
Long			iv_lSelectedColumnType

n_ds			ids_datastore

String                    		iv_sample_count
String			iv_sSelectedColumn
String			iv_sSelColDataType
String			iv_sSelColLen
	
s_rand_samp 		iv_rand_samp
sx_rand_samp_prov_count 	iv_prov_count_struct


end variables

forward prototypes
public function boolean wf_getprovidercounts (string arg_providerid, long arg_providerindex)
public function long wf_rand (long al_max)
public function long wf_getcolumntype (string arg_table_type, string arg_colname)
public function long wf_calc_count_by_prov (string as_prov_key[])
public function integer wf_calc_count_prov_icns (string as_prov[])
public function boolean edit_calc_sample_count ()
public function boolean wf_getselectedcounts (boolean arg_called_from_open)
public function boolean wf_buildselectdatawindow ()
public function boolean delete_from_temp ()
public function integer wf_create_sampling_reports ()
public subroutine wf_load_any_dropdownlistbox (string arg_table_type[])
end prototypes

event ue_universe_count;//*********************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_unique_hics.ue_universe_count
//		Event Name:		N/A
//
//*********************************************************************************
// FNC 	09/22/94	If provider name not on prov_name table, send out
//						messagebox and continue to process.
//	FDG 	11/10/95	Rename the subset table (thru fx_open_server_table)
//						to account for open server.
// DKG 	12/14/95	Access dictionary (elem_type = 'TB') thru
//					   w_main.dw_stars_rel_dict.
// FNC 	02/22/96	Stop selecting all providers when window is opened
// FNC 	07/03/96	STARS33 prob #8 Allow user to select any number of
// 					providers but display a message allowing them to
//						cancel if they select > 75
// FNC 	12/05/96	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
//	FDG 	09/18/97	Stars 3.6.  Call wf_load_any_dropdown_list_box 
//						instead of fx_load_any_dropdown_list_box.
// JGG 	01/30/98	STARS 4.0 TS 145 - Random Sampling Universe.
// AJS 	08-04-98	Stars 4.0 Track #1410.  Remove posting of close event
//                because it destroys datastore needed for the rest of RS
//                Instead call delete_from_temp to remove unwanted records.
// AJS 	09-02-98	Change code to use datawindow instead of listbox
//	FNC 	09/03/98	Track 1662. Order by for dw_2 should be the provider column
//						chosen by the user. Previously it was hard coded to 
//						provider id.
// FNC	09/23/98	Track 1742. Reverse AJS 8/04/98 changes. If user does not want
//						to continue must close window. If user wants to continue, exit
//						script and user must select providers manually.
//	FDG 	10/09/98	Track 1840.  Replace radiobuttons with dw_sample_size.
//	FDG 	12/11/98	Track 1731.  Set windows colors for dw_2.
//	GaryR	08/14/01	Track 3479c	Statistical option error when more than 75 providers
//	SAH	01/11/02	Track 2619	No error checking after Retrieve(), so users not 
//										notified if no rows are returned.
//	GaryR	02/06/02	Changed erroneous code that triggered 
//						methods directly in the n_cst_sql desendants
//	GaryR	03/22/02	Track 2870d Eliminate duplicate UPINs
//	GaryR	09/05/03	Track 3598d	Add seed logic to sampling process
//	Katie		02/09/07 SPR 4754 Changed prov_id_t column label on dw_2, Handle "N" as an 
//						option for the Provider Column Name
//	Katie		04/16/07	SPR 4959 Check dw_2 for occurances of duplicate NPIs.  Prompt user for whether to 
//						continue or not.  If continuing remove duplicates for selection.  If all selections removed
//						close window.
//	Katie		05/24/07 SPR 4959 Updated the prov count after removing the duplicate NPIs.
//	GaryR		04/22/08	SPR 5103	Resolve dup providers and centralize logic
//
//*********************************************************************************

Integer		li_rc		

Long			ll_idx
Long			ll_loop_idx
Long			ll_num_rows
Long			ll_prov_count
Long			ll_unique_icns

String		ls_mod_string
String		ls_prov_id
String 		ls_return_text
string 		ls_sql_string
String		ls_subsets[]
String		ls_subset_list
String		ls_table									
String		ls_table_type
String 		ls_table_types[]

SetPointer(Hourglass!)
setmicrohelp(w_main,'Loading Universe Counts')

//	Verify that the selected subsets for this invoice type
//	contain data

ls_subsets		 	= iv_Rand_Samp.Case_Subset_Id 

//	Count the number of lines in all subsets using the SUB_STEP_CNTL
//	table and summing the number of rows in the subset column.

ids_datastore.DataObject	=	'd_rand_samp_subset_rows'

ids_datastore.SetTransObject(Stars2ca)

ll_num_rows					= 	ids_datastore.Retrieve(iv_rand_samp.table_id, ls_subsets)

If ll_num_rows > 0 Then
	iv_line_univ			=	ids_datastore.GetItemNumber(ll_num_rows, 'TOTAL_SUBSET_ROWS')
Else
	MessageBox("Universe Count", "Selected subsets do not contain any claim data.")
	Return
End if

//	Join the temporary table named in iv_rand_samp structure
//	and the providers table to get a list of unique providers

dw_2.DataObject	=	'd_Random_Sampling_Provider_List'
dw_2.SetTransObject(Stars2ca)

ls_sql_string = "SELECT " + iv_rand_samp.prov_orig_name + &
						", " + iv_rand_samp.prov_name_col_name + &
						" FROM " + iv_rand_samp.Unique_Cnt_Temp_Table_Name	+ 	&
						" ORDER BY " + iv_rand_samp.prov_orig_name +	" ASC"

// Substitute ls_where for hardcode so it's not dbms specific
ls_mod_string		=	"DataWindow.Table.Select='"  					+	&
				 	 		ls_sql_string + "'"
							
ls_mod_string = ls_mod_string + " prov_id_t.text = '" + trim(iv_rand_samp.pit_label) + "'"

ls_return_text = dw_2.Modify(ls_mod_string)
dw_2.Reset()

IF ls_return_text = "" THEN
	ll_prov_count = dw_2.Retrieve()
ELSE
	MessageBox(This.Title, "Modify Failed" + ls_return_text)
END IF

ls_table_types[1] = iv_Rand_Samp.Table_id
if iv_rand_samp.bJoinActive = TRUE then
	ls_table_types[2] = iv_rand_samp.sJoinTableType
else
	ls_table_types[2] = ''
end if
wf_Load_Any_DropDownListBox(ls_table_types[])				
//AJS 09-02-98 end

// EK 06/21/95 - EDIT to limit number of providers

st_ProviderCount.text = string(ll_prov_count)

If ll_prov_count > 75 then
	li_rc = MessageBox('EDIT','Your data contains more than 75 distinct providers.~r~n Providers must be selected manually. ~r~nWould you like to cancel?',Information!,YesNo!)
	if li_rc = 1 then
		cb_close.triggerevent(clicked!)								// FNC 09/23/98 
		return																// FNC 09/23/98 
	else
		This.Event	ue_sample_size()									//	GaryR	08/14/01	Track 3479c
		return																// FNC 09/23/98
	end if
end if
// FNC 09/23/98 End

// Selects all of the Providers 

dw_2.SelectRow(0 ,TRUE)             

st_selectedproviders.text 	= st_providercount.text    

// Default to random sample within Provider. 

rb_within_prov.checked	=	TRUE
rb_within_prov.triggerevent(clicked!)

// Default to the Statistical Table to get sample size from
// This event triggers the edit_calc_sample_count window function 
// to calculate the universe and sample sizes.

//rb_stats.triggerevent(clicked!)			// FDG 10/09/98
This.Event	ue_sample_size()					// FDG 10/09/98

Commit Using stars2ca;

This.Event	ue_set_window_colors (This.Control)		// FDG 12/11/98

setmicrohelp(w_main,'Ready')

end event

event ue_sample_size();//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_unique_hics
//		Event Name:		ue_sample_size
//
//		This event is triggered in place of the "Sample Size Per Provider"
//		radiobuttons.
//
//************************************************************************
//
// FDG	10/09/98	Track 1840 - Created.
//	GaryR	09/05/03	Track 3598d	Add seed logic to sampling process
//
//************************************************************************

dw_sample_size.AcceptText()
ii_sample_size	=	dw_sample_size.object.sample_size [1]
dw_sample_size.Object.size_val[1] = 0
end event

event ue_sample_method();//	GaryR	09/05/03	Track 3598d	Add seed logic to sampling process

String	ls_method

dw_sample_method.AcceptText()
ls_method = dw_sample_method.GetItemString( 1, "sample_method" )

IF ls_method = "1" THEN
	dw_sample_method.Object.seed_id[1] = 0
	dw_sample_method.Object.seed_id.Protect = 1
	dw_sample_method.Object.seed_id.Background.Color = stars_colors.protected_back
	dw_sample_method.Object.seed_id.Color = stars_colors.protected_text
	dw_sample_method.Object.t_1.Background.Color = stars_colors.protected_back
	dw_sample_method.Object.t_1.Color = stars_colors.protected_text
ELSE
	dw_sample_method.Object.seed_id[1] = 1
	dw_sample_method.Object.seed_id.Protect = 0
	dw_sample_method.Object.seed_id.Background.Color = stars_colors.input_back
	dw_sample_method.Object.seed_id.Color = stars_colors.input_text
	dw_sample_method.Object.t_1.Background.Color = stars_colors.label_back
	dw_sample_method.Object.t_1.Color = stars_colors.label_text
END IF
end event

public function boolean wf_getprovidercounts (string arg_providerid, long arg_providerindex);//*******************************************************************
//  Window Function:		wf_GetProviderCounts
//
//  Purpose:				Count the total number of detail lines
//  							contained in all selected subsets where the 
//  							provider id or upin matches the ones listed 
//								in the dw_2 data window.  This only occurs
//								if the number in the list is less than 75.
//
//								JGG 02/02/98 - This function and wf_ResetProviderCounts merged
//
//								This function now counts the number of distinct
//								values of the selected column within each subset
//								by the selected provider column (pin or upin).
//
//*******************************************************************
// Maintenance Log:
// By:   Date     Description:
// --- --------   ---------------------------------------------------
// JGG 02/02/98	STARS 4.0 TS145 - Random Sample Universe changes
//
// FNC 12/05/96	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
//
//*******************************************************************

Integer			li_rc

Long				ll_detail_count
Long				ll_prov_idx

String			ls_prov_id
String			ls_prov_array[]

// Set up

setpointer(hourglass!)

ls_prov_id		= arg_ProviderId
ll_prov_idx 	= arg_ProviderIndex

ls_prov_array[1]	=	ls_prov_id

setmicrohelp(w_main,'Get the Counts for the Provider: ' + ls_prov_id)

//						Based on the new data model, we now need to select all of
//						the selected column values from each subset table and store them
//						in the datastore.  Then come back and count the distinct values
//						contained in the datastore.  If we SELECT DISTINCT and use the UNION 
//						operator, the resulting datastore will contain 1 row for each unique
//						key.  UNION eliminates the duplicate key values across subsets.
//						To get the count, just get the total number of rows in the datastore.

// Set up the datastore

ids_datastore.DataObject			=	"d_rand_samp_prov_count"
ids_datastore.SetTransObject(Stars2ca)

// Now get the count for this provider key

ll_detail_count						=	wf_calc_count_by_prov(ls_prov_array[])

// Check count returned.  
// If less than 1, an error occurred.

If ll_detail_count > 0 Then
	iv_lProviderCount[ll_prov_idx] = ll_detail_count
	RETURN TRUE
Else
	MessageBox(This.Title, "Unable to count selected column values in all selected subsets.")
	RETURN FALSE
End if

end function

public function long wf_rand (long al_max);//************************************************************************
//	Object Name:	w_random_sampling_unique_hics
//	Object Type:	Window function
//	Script Name:	wf_rand
//	Description:	This function returns a randomly generated number
//						based on the input parm.  Because PowerBuilder can
//						only generate a random number up to 32,767 (32K), other
//						provisions must be made to generate the random number
//	Input parms:	al_max - Maximum number to generate
//	Returns:			long	-	The random number generated.
//
//	Example:			
//************************************************************************

Long		ll_categories = 1,		&
			ll_max_categories = 1,	&
			ll_last_category_num,	&
			ll_category_num,			&
			ll_random_num,				&
			ll_random_category_num,	&
			ll_random_category,		&
			ll_32k = 32767

Decimal{4}	ldc_category_num

	//	If the number is within the 32k limit, randomize this number.

IF	al_max	<=	ll_32k		THEN
	Return Rand (al_max)
END IF

	//	The number is > 32k which is beyond PowerBuilder's 32k limit.  
	//	First break up the input parm into categories.  The number of
	//	categories must be less than 32K.  Second, create
	//	a random # on that category.  Then, create a random # on the
	//	numbers within that category.  Finally, compute the actual
	//	number based on the category and the number within the category.

ldc_category_num	=	al_max

	//	Determine the # of categories

DO WHILE ldc_category_num	>=	ll_32k
	ll_max_categories++
	ldc_category_num	=	al_max	/	ll_max_categories
LOOP

	//	Compute the # in each category
ll_category_num	=	Round (ldc_category_num, 0)

	//	Compute the # in the last category
ll_last_category_num	=	al_max -	&
								( (ll_max_categories - 1) * ll_category_num )

	//	Randomize the category #
ll_random_category	=	Rand (ll_max_categories)

	//	Randomize the number within the category.  If the randomized 
	//	category is the last category, then randomize that number
	//	instead.

IF	ll_random_category	=	ll_max_categories		THEN
	ll_random_category_num	=	Rand (ll_last_category_num)
ELSE
	ll_random_category_num	=	Rand (ll_category_num)
END IF

	//	Compute the random number based on the randomized category and 
	//	randomized number within the category.

ll_random_num	=	( (ll_random_category - 1)	*	ll_category_num )	+	&
						ll_random_category_num

Return	ll_random_num

end function

public function long wf_getcolumntype (string arg_table_type, string arg_colname);//**********************************************************************
//		Object Type:	Window Function
//		Object Name:	wf_getcolumntype
//
// This function will load a list box with all of the field
// labelss for the table type passed into the function as an argument.
// This function may be called multiple times in order to load fields
// from multiple tables into the same listbox.
//		
//
// Arguments: arg_table_type - Type of the table for which field names 
//                             are to be loaded
//            arg_listbox_name - The name of the listbox that is 
//                               to be loaded
//**********************************************************************
//
//	FDG	10/31/95	1.	Remove the additional transaction because it is
//							not needed.
//						2.	Change the cursor to getting the data from
//							w_main.dw_dictionary_hidden.
//						3.	Change variable names to conform to window
//							standards.
//
//	FDG	09/18/97	Stars 3.6.  Move logic from fx_getcolumntype
//
// JGG	02/25/98	STARS 4.0 - TS145 Random Sampling Universe changes
// AJS   09-02-98 The column name is passed into this function so it
//                does not need to be stripped off.
//	FDG	12/14/00	Stars 4.7.  Make the checking of data types DBMS-independent.
//
//**********************************************************************

string 	ls_col_type

ls_col_type = gnv_dict.event ue_get_elem_data_type( arg_table_type, arg_colname)

IF ls_col_type = gnv_dict.ics_error THEN
	Messagebox('ERROR','Unable to Load Column Type from dictionary')
	Return -1
ELSE
	iv_sSelColDataType 	= ls_col_type
	iv_sSelColLen			= string(gnv_dict.event ue_get_data_len( arg_table_type, arg_colname))
END IF

IF gnv_sql.of_is_character_data_type 	(ls_col_type)	THEN
	Return	2
ELSEIF gnv_sql.of_is_number_data_type 	(ls_col_type)	THEN
	Return	1
ELSEIF gnv_sql.of_is_date_data_type 	(ls_col_type)	THEN
	Return	3
ELSEIF gnv_sql.of_is_money_data_type 	(ls_col_type)	THEN
	Return	4
ELSE
	Return	0
END IF

Return 0

end function

public function long wf_calc_count_by_prov (string as_prov_key[]);//*******************************************************************
//  Window Function:		wf_calc_count_by_proc
//
//  Purpose:				This function counts the number of distinct
//								values of the user selected column within each 
//								subset by the selected provider column
//								(pin or upin).
//
//  Arguments:				as_prov_key[] - a string array of all selected 
//													 provider key values
//
//  Returns:				  0 = Unsuccessful
//								> 0 = Count of unique keys in all subsets for 
//								      the provider keys passed as an argument
//
//*******************************************************************
// Maintenance Log:
// By:   Date     Description:
// --- --------   ---------------------------------------------------
// JGG 02/02/98	STARS 4.0 TS145 - Random Sample Universe changes
//
//*******************************************************************

Integer							li_rc

Long								ll_detail_count
Long								ll_idx
Long								ll_max_provs

String							ls_curr_key
String							ls_errors
String							ls_join_clause
String							ls_mod_string
String							ls_next_key
String							ls_presentation
String							ls_prov_id[]
String							ls_prov_list
String							ls_return_string
String							ls_select_tables
String 							ls_sql
String							ls_where_clause

// Initialize

setpointer(hourglass!)

ls_prov_id					=	as_prov_key

ll_max_provs				=	UpperBound(ls_prov_id)

FOR ll_idx = 1 to ll_max_provs
	
	If ll_idx > 1 Then
		ls_prov_list		=	ls_prov_list 				&
								+	","
	End If
	
	ls_prov_list			=	ls_prov_list				&
								+	"'"							&
								+	ls_prov_id[ll_idx]		&
								+	"'"
NEXT

//						Based on the new data model, we now need to select all of
//						the selected column values from each subset table and store them
//						in the datastore.  Then come back and count the distinct values
//						contained in the datastore.  If we SELECT DISTINCT and use the UNION 
//						operator, the resulting datastore will contain 1 row for each unique
//						key.  UNION eliminates the duplicate key values across subsets.
//						To get the count, just get the total number of rows in the datastore.

// Reset the datastore now.  The transaction object and the data object for the
// instance of the datastore should be set up prior to calling this script.

li_rc							=	ids_datastore.Reset()
	
If li_rc < 1 Then
	ErrorBox(Stars2ca, "Unable to initialize prior to counting unique values by provider key.")
	RETURN 0
End if

// Create the sql to retrieve the selected column count across all selected subset
// by the list of provider keys passed as an argument.

FOR ll_idx = 1 to iv_rand_samp.subsets_selected
	
	If ll_idx > 1 Then
		ls_sql				=	ls_sql + " UNION "
	End if
	
	ls_select_tables		=	iv_rand_samp.subset_table_name [ll_idx]	+	" "	&
								+ 	iv_rand_samp.table_id 						 	+	" "
								
	ls_join_clause			=	" "
	
	// Join condition is now optional.  User selects to join by checking the
	// check box on the random sampling selection window.  This sets the value
	// of all the sJoin* fields in iv_rand_samp.  If set and the user selected
	// a column from the joined table, set up the join condition.

	If iv_rand_samp.sJoinTableType > "" Then
		if  Left(iv_sSelectedColumn, 3)  &
		 =	(RightTrim(iv_rand_samp.sJoinTableType) + ".") 	Then
		
			ls_select_tables	=	RightTrim(ls_select_tables) 				+ 	",  "		&
									+	iv_rand_samp.sJoinSubsetName[ll_idx]	+ 	" " 		&
									+ 	iv_rand_samp.sJoinTableType 				+ 	" "
											
			ls_join_clause 	= 	" AND ( " 	+ iv_rand_samp.table_id						&
									+ 	"." 			+ iv_rand_samp.sJoinMainKey				&
									+ 	" = "			+ iv_rand_samp.sJoinTableType				&
									+ 	"." 			+ iv_rand_samp.sJoinDepnKey				&
									+	" ) "
		End if
	End if
	
	ls_sql						=	ls_sql												&
									+	" SELECT DISTINCT "								&
									+	iv_sSelectedColumn								&
									+	" FROM "												&
									+	ls_select_tables									&
									+	" WHERE ("											&
									+	iv_rand_samp.table_id							&
									+	'.'													&
									+	iv_rand_samp.prov_col_name						&
									+	" in ("												&
									+	Upper( ls_prov_list )							&
									+	") ) "												&
									+	ls_join_clause
	
NEXT

// Create the data object for the datastore by getting the datawindow
// syntax from the SQL statement.

ls_mod_string						=	ls_sql 	&
										+	"' "
										
ls_presentation					=	"style(type=grid)"
										
ls_return_string					=	Stars2ca.SyntaxFromSQL(ls_sql, ls_presentation, ls_errors)

If Len(ls_errors) > 0 Then
	ErrorBox(Stars2ca, "SQL Syntax failed: " + ls_errors)
	RETURN 0
End If

li_rc								= ids_datastore.Create(ls_return_string, ls_errors)

If li_rc = 1 Then
	// Create successful, so retrieve unique key values
	ids_datastore.SetTransObject(Stars2ca)
	ll_detail_count			=	ids_datastore.Retrieve()
Else
	// Modify failed
	ErrorBox(Stars2ca, "Set up to retrieve unique key values failed.")
	RETURN 0
End if

// If we get to here, the retrieve call was issued, so check its status.

CHOOSE CASE ll_detail_count
	CASE IS < 1
		// Retrieve unsuccessful
		RETURN 0
	CASE 1
		// Only 1 row returned, no need to check for duplicate keys
		RETURN 1
	CASE ELSE
		// More than one row returned, so check for duplicates
END CHOOSE

// Check for duplicate key values across subsets by sorting the rows first.
// Since there is only one column, sort by column number.

ids_datastore.SetSort('#1 A')
ids_datastore.Sort()

// Now compare the key values on ajoining rows.

FOR ll_idx = 1 TO ll_detail_count - 1
	
	CHOOSE CASE iv_lSelectedColumnType
		CASE 1
			ls_curr_key			=	String(ids_datastore.GetItemNumber(ll_idx, 1))
			ls_next_key			=	String(ids_datastore.GetItemNumber(ll_idx + 1, 1))
		CASE 2
			ls_curr_key			=	ids_datastore.GetItemString(ll_idx, 1)
			ls_next_key			=	ids_datastore.GetItemString(ll_idx + 1, 1)
		CASE 3
			ls_curr_key			=	String(ids_datastore.GetItemDateTime(ll_idx, 1))
			ls_next_key			=	String(ids_datastore.GetItemDateTime(ll_idx + 1, 1))
		CASE 4
			ls_curr_key			=	String(ids_datastore.GetItemDecimal(ll_idx, 1))
			ls_next_key			=	String(ids_datastore.GetItemDecimal(ll_idx + 1, 1))
	END CHOOSE
	
	If ls_curr_key = ls_next_key Then
		// Duplicate found so discard current row
		ids_datastore.RowsDiscard(ll_idx, ll_idx, Primary!)
		
		// Decrement total number of rows
		ll_detail_count --
	End if
NEXT

// The value now in ll_detail_count should be the total number of unique keys,
// so return it to the calling script.

RETURN ll_detail_count

end function

public function integer wf_calc_count_prov_icns (string as_prov[]);//*******************************************************************
//  Window Function:		wf_calc_count_by_prov_icn
//
//  Purpose:				This function counts the number of distinct
//								icns within each subset by the selected provider 
//								column (pin or upin).
//
//  Arguments:				as_prov[] - a string array of all selected 
//													 provider key values
//
//  Returns:				  0 = Unsuccessful
//								> 0 = Count of unique keys in all subsets for 
//								      the provider keys passed as an argument
//
//*******************************************************************
// Maintenance Log:
// By:   Date     Description:
// --- --------   ---------------------------------------------------
// FNC 11/25/98	Track 1406. Calculate distinct ICN's among selected
//						subsets and providers
// JGG 12/07/98	Track 2022. Always use GetItemString when retrieving
//						icn value for duplicate checking.
//
// Gary-R	 08/10/2000		2936C		Random Sample Revenue
//*******************************************************************

Integer							li_rc

Long								ll_detail_count
Long								ll_idx
Long								ll_max_provs

String							ls_curr_key
String							ls_errors
String							ls_join_clause
String							ls_mod_string
String							ls_next_key
String							ls_presentation
String							ls_prov_id[]
String							ls_prov_list
String							ls_return_string
String							ls_select_tables
String 							ls_sql
String							ls_where_clause

// Initialize

setpointer(hourglass!)

ls_prov_id					=	as_prov

ll_max_provs				=	UpperBound(ls_prov_id)

FOR ll_idx = 1 to ll_max_provs
	
	If ll_idx > 1 Then
		ls_prov_list		=	ls_prov_list 				&
								+	","
	End If
	
	ls_prov_list			=	ls_prov_list				&
								+	"'"							&
								+	ls_prov_id[ll_idx]		&
								+	"'"
NEXT

//						Based on the new data model, we now need to select all of
//						the selected column values from each subset table and store them
//						in the datastore.  Then come back and count the distinct values
//						contained in the datastore.  If we SELECT DISTINCT and use the UNION 
//						operator, the resulting datastore will contain 1 row for each unique
//						key.  UNION eliminates the duplicate key values across subsets.
//						To get the count, just get the total number of rows in the datastore.

// Reset the datastore now.  The transaction object and the data object for the
// instance of the datastore should be set up prior to calling this script.

li_rc							=	ids_datastore.Reset()
	
If li_rc < 1 Then
	ErrorBox(Stars2ca, "Unable to initialize prior to counting unique values by provider key.")
	RETURN 0
End if

// Create the sql to retrieve the selected column count across all selected subset
// by the list of provider keys passed as an argument.

FOR ll_idx = 1 to iv_rand_samp.subsets_selected
	
	If ll_idx > 1 Then
		ls_sql				=	ls_sql + " UNION "
	End if
	
	ls_select_tables		=	iv_rand_samp.subset_table_name [ll_idx]	+	" "	&
								+ 	iv_rand_samp.table_id 						 	+	" "
								
	ls_join_clause			=	" "
	
	// Join condition is now optional.  User selects to join by checking the
	// check box on the random sampling selection window.  This sets the value
	// of all the sJoin* fields in iv_rand_samp.  If set and the user selected
	// a column from the joined table, set up the join condition.

	If iv_rand_samp.sJoinTableType > "" Then
		if  Left(iv_sSelectedColumn, 3)  &
		 =	(RightTrim(iv_rand_samp.sJoinTableType) + ".") 	Then
		
			ls_select_tables	=	RightTrim(ls_select_tables) 				+ 	",  "		&
									+	iv_rand_samp.sJoinSubsetName[ll_idx]	+ 	" " 		&
									+ 	iv_rand_samp.sJoinTableType 				+ 	" "
											
			ls_join_clause 	= 	" AND ( " 	+ iv_rand_samp.table_id						&
									+ 	"." 			+ iv_rand_samp.sJoinMainKey				&
									+ 	" = "			+ iv_rand_samp.sJoinTableType				&
									+ 	"." 			+ iv_rand_samp.sJoinDepnKey				&
									+	" ) "
		End if
	End if
	// Gary-R	 08/10/2000		2936C		Begin
	ls_sql						=	ls_sql												&
									+	" SELECT DISTINCT "								&
									+  iv_rand_samp.table_id + ".ICN"				&
									+	" FROM "												&
									+	ls_select_tables									&
									+	" WHERE ("											&
									+	iv_rand_samp.table_id							&
									+	'.'													&
									+	iv_rand_samp.prov_col_name						&
									+	" in ("												&
									+	Upper( ls_prov_list )							&
									+	") ) "												&
									+	ls_join_clause
	// Gary-R	 08/10/2000		2936C		End
NEXT

// Create the data object for the datastore by getting the datawindow
// syntax from the SQL statement.

ls_mod_string						=	ls_sql 	&
										+	"' "
										
ls_presentation					=	"style(type=grid)"
										
ls_return_string					=	Stars2ca.SyntaxFromSQL(ls_sql, ls_presentation, ls_errors)

If Len(ls_errors) > 0 Then
	ErrorBox(Stars2ca, "SQL Syntax failed: " + ls_errors)
	RETURN 0
End If

li_rc								= ids_datastore.Create(ls_return_string, ls_errors)

If li_rc = 1 Then
	// Create successful, so retrieve unique key values
	ids_datastore.SetTransObject(Stars2ca)
	ll_detail_count			=	ids_datastore.Retrieve()
Else
	// Modify failed
	ErrorBox(Stars2ca, "Set up to retrieve unique key values failed.")
	RETURN 0
End if

// If we get to here, the retrieve call was issued, so check its status.

CHOOSE CASE ll_detail_count
	CASE IS < 1
		// Retrieve unsuccessful
		RETURN 0
	CASE 1
		// Only 1 row returned, no need to check for duplicate keys
		RETURN 1
	CASE ELSE
		// More than one row returned, so check for duplicates
END CHOOSE

// Check for duplicate key values across subsets by sorting the rows first.
// Since there is only one column, sort by column number.

ids_datastore.SetSort('#1 A')
ids_datastore.Sort()

// Now compare the key values on ajoining rows.

FOR ll_idx = 1 TO ll_detail_count - 1
	
	ls_curr_key			=	ids_datastore.GetItemString(ll_idx, 1)
	ls_next_key			=	ids_datastore.GetItemString(ll_idx + 1, 1)
	
	// JGG 12/07/98 - Track 2022 - end
	
	If ls_curr_key = ls_next_key Then
		// Duplicate found so discard current row
		ids_datastore.RowsDiscard(ll_idx, ll_idx, Primary!)
		
		// Decrement total number of rows
		ll_detail_count --
	End if
NEXT

// The value now in ll_detail_count should be the total number of unique keys,
// so return it to the calling script.

RETURN ll_detail_count

end function

public function boolean edit_calc_sample_count ();// This function will edit the sample size field and calculate
// the sample count based on user input.
// Function returns TRUE if OK and FALSE otherwise

//***********************************************************************
// 09-02-98 AJS   Change code to use datawindow instead of listbox
// 02-04-98 JGG	STARS 4.0 TS145 - Random Sampling Universe changes
// 08-28-96 FNC 	Remove integer function and replace with long so large
//						numbers can be handled.
// 03-13-96 FNC	Calculate % for each provider if random sample within providers
//
// 02-27-96 FNC 	Populate provider count structure to send provider count
//            	 	window
//
// 02-22-96 FNC 	Move table lookup to window functions. Add a different
//              	table for professional claims
//	10/09/98	FDG	Track 1840.  Replace radiobuttons with dw_sample_size and
//						ii_sample_size (1=rb_stats, 2=rb_#, 3=rb_%).
//	11/14/01	GaryR	Track 2543	Entering % with the number in the Sample Size
//										box generates an incorrect message.
//	12/18/02	GaryR	Track 2898d	Incorrect sample size within providers
//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process
//***********************************************************************

Boolean		lb_row_selected
Boolean		lb_stop_work

Long			ll_loop_idx
Long			ll_next_selected
long        ll_pos
Long			ll_prov_count
Long			ll_prov_samp_size
Long			ll_row_count
Long			ll_samp_size
Long			ll_set_samp_size
Long			ll_total_size
Long			ll_universe_size

Integer     li_index
Integer		li_rc

String		ls_base_type
String		ls_clear_array[]
String		ls_col_name
String		ls_data_type
String		ls_prov_id
String		ls_sql
String		ls_temp_table

setpointer(hourglass!)
setmicrohelp(w_main,'Calculate Universe Size')

// JGG 05/01/98 - Calculate the provider counts for rows in the datawindow.
//						If the row is selected, get counts for this provider.
//						Otherwise, set the provider count to zero.
//						This saves counts for within provider functionality.

ll_loop_idx			=	0						// used to store prov counts in array
ll_row_count		=	dw_2.RowCount()

FOR ll_loop_idx = 1 TO ll_row_count
	ls_prov_id 			= 	dw_2.GetItemString(ll_loop_idx, 1)
	lb_row_selected	=	dw_2.IsSelected(ll_loop_idx)
	
	If lb_row_selected = TRUE Then
		If not wf_GetProviderCounts(ls_prov_id, ll_loop_idx) then
			MessageBox("Window Function: Edit_Calc_Sample_Count", &
						  "Reset Provider Counts failure")
			RETURN FALSE
		End if
	Else
		iv_lProviderCount[ll_loop_idx]	=	0
	End if
NEXT

// Now create a list of selected providers and calculate the universe size.

if not wf_getselectedcounts(false) then
	Return(False)
end if

setmicrohelp(w_main,'Calculate Sample Size')
ll_universe_size = long(st_selected_count.text)			
ll_total_size = 0

//						Base type for the selected subsets is now contained
//						in iv_rand_samp.  Change following code to reference
//						base type in this structure instead of retrieving it.

dw_sample_size.AcceptText()
ll_samp_size = dw_sample_size.GetItemNumber( 1, "size_val" )
if ll_samp_size = 0 then
	Messagebox("ERROR","Please enter a Sample Size")
	return(FALSE)
	iv_sample_count = ""
end if
//	11/14/01	GaryR	Track 2543 - End

If  (ii_sample_size	=	2) &					 
And (ll_samp_size > long(st_selected_count.text)) Then 
	MessageBox("ERROR","Sample size may not be greater than the total universe.")
	iv_sample_count = ""
	RETURN(FALSE)
Elseif (ii_sample_size	=	3) Then
	If ll_samp_size > 100 Then			
		Messagebox("ERROR","Sample percent may not be greater than 100")
		iv_sample_count = ""
		RETURN(FALSE)
	End if
End if

if ii_sample_size	=	2 then
	iv_sample_count 					= String( ll_samp_size )
ELSEif ii_sample_size	=	3 then
	iv_sample_count = string (ceiling(ll_universe_size &
								* (ll_samp_size / 100)  ) )
END IF

st_distinct_sample_size.text 	= iv_sample_count

/*
 *  Check to see if across providers??
 *    if so return! it's already done!!!!!!!
 *    if not perform the count for each selected provider
 *
 */
if rb_across_providers.checked = true then
   setmicrohelp(w_main,'Ready')
	Return(True)
end if

/*
 *  JMT 4-8-95
 *  The User has selected Sampling for each provider selected and
 *  NOT ACROSS PROVIDERS.  
 *
 */

iv_prov_count_struct.ls_provider_id[] = ls_clear_array[]

//AJS 09-02-98 Change code to use datawindow instead of listbox
//ll_pos = pos(ddlb_columns.text,'.')
//iv_prov_count_struct.ls_sample_selection = mid(ddlb_columns.text,(ll_pos+1))
iv_prov_count_struct.ls_sample_selection = dw_3.Object.as_columns[1]

lb_stop_work = false
ll_next_selected = 0
li_index = 0

do while not lb_stop_work 
	ll_next_selected = dw_2.GetSelectedRow(ll_next_selected) 
	if ll_next_selected = 0 then
		lb_stop_work = TRUE
	else
		ls_prov_id = DW_2.GetItemString(ll_next_selected, 1)
		ll_prov_count = iv_lProviderCount[ll_next_selected]
		ll_universe_size = ll_prov_count
      if ii_sample_size	=	3 then     
         ll_prov_samp_size = (ceiling(ll_universe_size &
								* (ll_samp_size / 100)  ) )
      else
		   ll_prov_samp_size = long(iv_sample_count)			
      end if                  
		
		if ll_prov_count > ll_prov_samp_size then
			ll_total_size = ll_total_size + ll_prov_samp_size
			iv_lProviderSampleSize[ll_next_selected] = ll_prov_samp_size
		else
			ll_total_size = ll_total_size + ll_prov_count
			iv_lProviderSampleSize[ll_next_selected] = ll_prov_count
		end if

      li_index++
      iv_prov_count_struct.ls_provider_id[li_index] = ls_prov_id
      iv_prov_count_struct.ls_provider_name[li_index] = DW_2.GetItemString(ll_next_selected, 2)      
      iv_prov_count_struct.ll_provider_count[li_index] = ll_prov_count
      iv_prov_count_struct.ll_provider_samplesize[li_index] = iv_lProviderSampleSize[ll_next_selected]

	end if

loop

iv_sample_count = String(ll_total_size)
st_distinct_sample_size.text = string(ll_total_size)  

setmicrohelp(w_main,'Ready')
return(TRUE)

end function

public function boolean wf_getselectedcounts (boolean arg_called_from_open);//
// This function calculates the counts for the selected Provider(s)
//
//

//**********************************************************************
//	NLG 08-10-98	Track #1563 - Sampling Across Providers - fix errors
//						with Universe and Sample Size count boxes
// JGG 02/02/98	STARS 4.0 TS145 - Random Sample Universe changes
//
// FNC 12/05/96	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
//	FNC 10-16-96 	Prob #178 Stars35 Universe count for sampling within
//						providers should be = to count for each provider
//						Only select distinct count from subset when it is 
//						accross providers.
// FNC 08-27-96	Check the variable field instead of the sle because
//						the sle was being converted to an integer which didn't	
//						work with large numbers.
// FNC 08-07-96   Prob #931 STARCARE FS114, TS116 
//						Move fields to structure passed to W_RANDOM_SAMPLING_CLAIMS
//						that are needed to create a subset
// 07-03-96 FNC 	Take out edit for number of providers. User receives 
//						a warning if greater than 75 in ue_universe_count
// 02-27-96 FNC   Move edit for more than 75 providers from ue_universe 
//                ue_universe_count. Remove static text no longer used
//**********************************************************************

Boolean			lb_stop_work

Long				ll_distinct_col_count
Long				ll_next_prov_row
Long				ll_num_providers

Integer			li_prov_idx

String			ls_provider_id
String			ls_prov_id_list
string 			ls_clear_array[]		//NLG Track #1563

setpointer(hourglass!)
setmicrohelp(w_main,'Load the Selected Providers Counts')

cb_apply_random_sample.enabled 	= 	TRUE

//  Load the Universe Count for the Column Selected (distinct)

lb_stop_work 							= 	false
ll_next_prov_row 						= 	0
ll_num_providers 						= 	0
ls_prov_id_list 						= 	""

//  Get the Selected Providers

li_prov_idx 							= 	0										

iv_rand_samp.selected_provs = ls_clear_array		//NLG Track #1563

DO WHILE not lb_stop_work 
	li_prov_idx++
	ll_next_prov_row 					= 	dw_2.GetSelectedRow(ll_next_prov_row) 
	
	if ll_next_prov_row = 0 then
		lb_stop_work 					= 	TRUE
	else
		ll_num_providers 				= 	ll_num_providers + 1
		ll_distinct_col_count		= 	ll_distinct_col_count 	&
											+ 	iv_lprovidercount[ll_next_prov_row]
		
		If ll_num_providers > 1 Then
			ls_prov_id_list			=	ls_prov_id_list + ","
		End if
		
		ls_provider_id					=	dw_2.GetItemString(ll_next_prov_row, 1)
		
		iv_rand_samp.selected_provs[ll_num_providers] = ls_provider_id
		
		ls_prov_id_list				=	ls_prov_id_list + "'" + ls_provider_id + "'"
	end if
	
LOOP

If ll_num_providers = 0 then
	MessageBox("Random Sample PIN/UPIN Counts", "Please Select at Least 1 Provider")
	RETURN False
End if

iv_rand_samp.selected_prov_list	=	ls_prov_id_list

if rb_across_providers.checked then	
	
	setmicrohelp(w_main,'Get the Distinct Count for Across Providers')
	
	//					Based on the new data model, we now need to select all of
	//					the selected column values from each subset table and store them
	//					in the datastore.  Then come back and count the distinct values
	//					contained in the datastore.  If we SELECT DISTINCT and use the UNION 
	//					operator, the resulting datastore will contain 1 row for each unique
	//					key.  UNION eliminates the duplicate key values across subsets.
	//					To get the count, just get the total number of rows in the datastore.

	// Set up the data object and the transaction object for the instance of the datastore
	
	ids_datastore.DataObject		=	"d_rand_samp_prov_count"
	ids_datastore.SetTransObject(Stars2ca)
	
	// Now trigger the window function to calculate counts across providers
	
	ll_distinct_col_count			=	wf_calc_count_by_prov(iv_rand_samp.selected_provs[])
	
	If ll_distinct_col_count < 1 Then
		Errorbox(stars2ca,'Unable to select rows matching PROV_IDs in selected subsets.')
		RETURN FALSE
	End if	

End if						

st_selected_count.text 				= 	string(ll_distinct_col_count)

st_SelectedProviders.text 			= 	string(ll_num_providers)

setmicrohelp(w_main,'Counts Complete')

RETURN True
end function

public function boolean wf_buildselectdatawindow ();/*
 *  Window Function: wf_BuildSelectDataWindow
 *		
 *		This function will Select the Data from the SubSets
 *		for the Select Criteria used to get the Unique Count
 *
 */
//******************************************************************
//
//	07/23/96	FNC	Take out ICN from DW_1. This will allow for 1 row
//         		   for each unique value of the selected column.
//	12/05/96	FNC	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
//	03/26/97	FNC	Track #12 Take prov id off of DW_1 because already 
//						put UPIN or	prov id in. 
//	02/04/98	JGG	STARS 4.0 TS145 - Random Sample Universe changes
//	08/05/98	NLG	Track #1408 - Take out the hardcoding of 'SUBSET' in the report
//	12/08/98	AJS	Track #1896 - StarDev change subset_id on RDM rpt to subset name
//	01/18/99	FDG	Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
//						Track 2020c.  Get server date instead of PC date.
//	11/17/00	GaryR	Stars 4.7	DataBase Port - Conversion of data types
//	10/17/01	GaryR	Stars 5.0.0	Conversion of data types
//	11/14/01	FDG	Stars 5.0.  Since SQL can now do "union", remove
//						Order By from the SQL and sort the retrieved d/w instead.
//	03/14/02	GaryR	Track 2870d	Correct sorting error
//	03/18/03	GaryR	Track 2934d	Get unique claims universe for all subsets
//	12/31/03	GaryR	Track 3754d	Add sampling field to sort order
//	02/09/07 Katie		SPR 3645 Prevented PROV_ID from being included in RDM report
//							if the sample is across providers.
//
//******************************************************************

Boolean			lb_stop_work

Long				ll_check_detail_idx
Long				ll_details
Long				li_idx
Long				ll_idx1
Long				ll_idx2
Long				ll_prov_idx
Long				ll_prov_rows
Long				ll_start_idx
Long				ll_stop_idx

String			ls_detail_prov_id
String			ls_join_clause
String			ls_mod_string
string			ls_prov_col					
String			ls_prov_id
String			ls_return_code
String			ls_select_tables
String			ls_table_type
String			ls_subset_id
String			ls_sort						// FDG 11/14/01

Integer			li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Build the Select DataWindow')

/*
 *  Set the Transaction Object for DataWindow 1
 *
 */

If settransobject(dw_1,Stars2ca) < 0 then	
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_apply_random_sample.enabled = FALSE
	cb_close.default = true
	RETURN False
End If

ls_table_type = iv_Rand_Samp.table_id

ls_mod_string 				=	'DataWindow.Table.Select = "'

FOR li_idx = 1 to iv_rand_samp.subsets_selected
	
//	ls_subset_id = iv_rand_samp.case_subset_id[li_idx]//NLG Track #1408
	ls_subset_id = iv_rand_samp.case_subset_name[li_idx]//AJS Track #1896
	If li_idx > 1 Then
		ls_mod_string		=	ls_mod_string + " UNION "
	End if
	
ls_mod_string	=	ls_mod_string														&
							+ 	"SELECT DISTINCT 0, " 											&
							+ 	"~~~' ~~~', "
							
if not iv_rand_samp.across_provs then 
	ls_mod_string	=	ls_mod_string														&
							+ 	ls_table_type + "." 												&
							+ 	iv_rand_samp.prov_col_name 									&
							+ 	", "
else
	ls_mod_string	=	ls_mod_string														&
							+ 	"~~~' ~~~', "
end if
//NLG 																							STOP***						

	// FDG 01/18/98 - Use mm/dd/yyyy format and use server date.
	CHOOSE CASE iv_lSelectedColumnType
			
		CASE 1				// Integer data type
			ls_mod_string 	= 	ls_mod_string				 									&
							+ 	iv_sSelectedColumn 	+  ", " 									&
							+ 	"~~~' ~~~', " 														&
							+ 	gnv_sql.of_get_to_date( String(gnv_app.of_get_server_date_time(), 'mm/dd/yyyy hh:mm:ss') ) + ", " 	&
							+ 	"0.0, "																&
							+	"0 " 											
					
		CASE 2				// Character data type
			ls_mod_string 	= 	ls_mod_string													&
							+ 	" 0, " 																&
							+ 	iv_sSelectedColumn + ",  " 									&
							+ 	gnv_sql.of_get_to_date( "01/01/1900 00:00:00" ) + ", "&
							+ 	"0.0, "																&
							+	"0 "
							
		CASE 3				// Datetime data type
			ls_mod_string 	= 	ls_mod_string 													&
							+ 	"0, " 																&
							+ 	"~~~' ~~~', " 														&							
							+ gnv_sql.of_get_to_char( "CHAR(25), " + iv_sSelectedColumn + ", 1" ) + ", " &							
							+ 	"0.0, "																&
							+	"0 " 
							
		CASE 4				// Money data type
			ls_mod_string 	= 	ls_mod_string													&
							+ 	"0, " 																&
							+ 	"~~~' ~~~', " 														&
							+ 	gnv_sql.of_get_to_date( String(gnv_app.of_get_server_date_time(), 'mm/dd/yyyy hh:mm:ss') ) + ", " 	&
							+ 	iv_sSelectedColumn + ", "										&
							+ 	"0 " 
							
		CASE ELSE			// Default condition for integer, character, datetime
								// Money, random Number respectively
			ls_mod_string 	= 	ls_mod_string													&
							+	 "0, " 																&	
							+ 	"~~~' ~~~', " 														&	
							+ 	gnv_sql.of_get_to_date( "01/01/1900 00:00:00" ) + ", "&	
							+ 	"0.0, " 																&	
							+ 	"0  " 																	
	END CHOOSE

	ls_select_tables	=	iv_rand_samp.Subset_Table_Name[li_idx] &
							+	" "	+	ls_table_type 
	ls_join_clause		=	" "


	If iv_rand_samp.sJoinTableType > "" Then
		if  Left(iv_sSelectedColumn, 3)  &
		 =	(RightTrim(iv_rand_samp.sJoinTableType) + ".") 	Then
		
			ls_select_tables	=	RightTrim(ls_select_tables) 				+ 	",  "		&
									+	iv_rand_samp.sJoinSubsetName[li_idx]	+ 	" " 		&
									+ 	iv_rand_samp.sJoinTableType 				+ 	" "
											
			ls_join_clause 	= 	" AND ( " 	+ iv_rand_samp.table_id						&
									+ 	"." 			+ iv_rand_samp.sJoinMainKey				&
									+ 	" = "			+ iv_rand_samp.sJoinTableType				&
									+ 	"." 			+ iv_rand_samp.sJoinDepnKey				&
									+	" ) "
		End if
	End if

	ls_mod_string		=	ls_mod_string									&
							+	" FROM "											&
							+	ls_select_tables								&
							+	" WHERE "										&
							+	ls_table_type	+	"."						&
							+	iv_rand_samp.prov_col_name					&
							+	" IN ("											&
							+	Upper( iv_rand_samp.selected_prov_list ) &
							+	") "												&
							+	ls_join_clause						
NEXT

ls_mod_string	=	RightTrim(ls_mod_string)	+	'"'

ls_return_code = dw_1.Modify(ls_mod_string)

setmicrohelp(w_main,'Retrieve the Distinct Values for Random Selection')

IF ls_return_code = "" THEN
	ii_RowCount = dw_1.Retrieve()
ELSE
	MessageBox(This.Title, "Modify Failed:~r~n " + ls_return_code)
END IF

if ii_rowcount < 1 then
	MessageBox(This.Title, "No Rows Selected For Random Sampling")
	Return False
end if	

ls_sort			=	"#3 A, #4 A, #5 A, #6 A, #7 A"
li_rc				=	dw_1.SetSort (ls_sort)
li_rc				=	dw_1.Sort()


SelectRow(dw_1,0,FALSE)    

ll_prov_rows = dw_2.RowCount()


ll_idx1 = 1
ll_start_idx = 0
ll_check_detail_idx = 1
if not ii_rowcount > 0 then lb_stop_work = True


setmicrohelp(w_main,'Setup Provider Detail Row Info')

for ll_idx1 = 1 to ll_prov_rows
	ls_prov_id	= dw_2.GetItemString(ll_idx1, 1)
	ll_prov_idx = ll_idx1
	lb_stop_work		= False
	ll_start_idx = 0
	ll_idx2 = ll_check_detail_idx
	
	do until lb_stop_work
		ls_detail_prov_id = dw_1.GetItemString(ll_idx2, 3) 				

		if ls_prov_id 	= ls_detail_prov_id then
			ll_start_idx 	= ll_idx2
			lb_stop_work 		= True
		elseif ls_prov_id 	< ls_detail_prov_id then
			lb_stop_work = True
		else
			ll_idx2 		= ll_idx2 + 1
			if ll_idx2 > ii_rowcount then lb_stop_work = True
		end if
	Loop

	if ll_start_idx = 0 then
		iv_lProviderCount[ll_prov_idx]  = 0
		iv_lProviderOffSet[ll_prov_idx] = 0
	else
		lb_stop_work = False
		ll_idx2 = ll_start_idx
		ll_stop_idx = 0
		ll_details = 0

		do until lb_stop_work
		
			ls_detail_prov_id = dw_1.GetItemString(ll_idx2, 3) 				
		
			if ls_prov_id = ls_detail_prov_id then
				ll_details = ll_details + 1
				ll_stop_idx = ll_idx2
				ll_idx2 = ll_idx2 + 1
				if ll_idx2 > ii_rowcount then
					lb_stop_work = True
					ll_idx2 = ll_idx2 - 1
				end if
			else
				lb_stop_work = True
			end if
		Loop
	
		iv_lProviderCount[ll_prov_idx] = ll_details
		iv_lProviderOffSet[ll_prov_idx] = ll_start_idx - 1
		ll_check_detail_idx = ll_idx2
		
	end if

next

Return True

end function

public function boolean delete_from_temp ();//******************************************************************
// 03/27/96 FNC Change gv_user_id to gc_user_id
// 02/04/98 JGG STARS 4.0 - TS145 Random Sampling Unique Hics changes
//	10/31/01	GaryR	Track 2444d	Trim milliseconds off the date value
//******************************************************************

//	10/31/01	GaryR	Track 2444d - Begin
String	ls_temp_date, ls_temp_time
DateTime	ldt_temp_date

ls_temp_date = String( iv_rand_samp.temp_datetime, 'mm/dd/yyyy' )
ls_temp_time = String( iv_rand_samp.temp_datetime, 'hh:mm:ss' )
ldt_temp_date = DateTime( Date( ls_temp_date ), Time( ls_temp_time ) )

//DELETE from USER_TEMP_RAND_SAMPLE
//	where USER_ID = Upper( :gc_user_id ) and TEMP_DATETIME = :iv_rand_samp.temp_datetime
//	using stars2ca;

DELETE from USER_TEMP_RAND_SAMPLE
	where USER_ID = Upper( :gc_user_id ) and TEMP_DATETIME = :ldt_temp_date
	using stars2ca;
//	10/31/01	GaryR	Track 2444d - End

If stars2ca.of_check_status() < 0  then
	Errorbox(stars2ca,'Error deleting rows from temp table (USER_TEMP_RAND_SAMPLE)')
	return(FALSE)
End If

COMMIT using stars2ca;

return(TRUE)

end function

public function integer wf_create_sampling_reports ();//*********************************************************************************
//
//	Window		W_RANDOM_SAMPLING_UNIQUE_HICS
//	Function	WF_CREATE_SAMPLING_REPORTS
//
//	This function adds a sequence number to the invisible datawindow used
//	to select randomly selected claims. It also sets the col width to 0 
//	for all cols except for the sequence number and the column being sampled
//	Lastly it saves the dw to the case folder
//
//*********************************************************************************
//
//	11/12/96	FNC	Created
//	11-20-96	FNC	Put generated id nbrs on same report as universe.
//	03/26/97 FNC	Track #12 Take prov id off of DW_1 because already 
//						put UPIN or	prov id in. 
//	08/05/98	NLG	Track #1407 Randomly Selected ID Number not showing on RDM report
//	09/02/98	AJS	Change code to use datawindow instead of listbox
//	06/13/02	Jason	Track - 2946d   Report Save window changes
//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process
//	02/28/05	GaryR	Track 4318d	Random Sample report is scrambled
//	02/16/07	Katie		SPR 4754 Changed PROV_ID Column label and hid of Across Providers.
//	05/21/07	GaryR	Track 3645	Remove ProvId when reporting accross providers
//  06/06/07 Katie		SPR 5057 Remove code to obtain label for sample field.  Instead 
//							retrieve the label from iv_rand_samp.
//*********************************************************************************

integer 	li_col_num
integer	li_idx
integer	li_num_of_cols
integer 	li_num_subsets

long		ll_pos
long 		ll_row

string 	ls_col_name
string	ls_col_text
string	ls_field_name
string	ls_rc
string	ls_select_col
string	ls_select_field, ls_select_tbl_type
string 	ls_subsets
string	ls_title

CHOOSE CASE iv_lSelectedColumnType
	CASE 1
		ls_select_col = 'COMPUTE_0004'	//03-26-97 FNC
	CASE 2
		ls_select_col = 'COMPUTE_0005'	//03-26-97 FNC 
	CASE 3
		ls_select_col = 'COMPUTE_0006'	//03-26-97 FNC
	CASE 4
		ls_select_col = 'COMPUTE_0007'	//03-26-97 FNC
END CHOOSE

li_num_of_cols = integer(dw_1.Describe('datawindow.column.count'))

//For all cols other than seq num and sampling field set width to 0
//so they are not saved to the case folder.

ls_rc = dw_1.Modify("prov_id.visible='1'")
ls_rc = dw_1.Modify("prov_id_t.visible='1'")

For li_col_num = 1 to li_num_of_cols
	ls_col_name = dw_1.Describe('#'+string(li_col_num)+'.name')	
	
	if  (upper(ls_col_name) <> ls_select_col 	&
	and li_col_num 		  <> 1 					&
	and upper(ls_col_name) <> 'PROV_ID' 		&
	and upper(ls_col_name) <> 'COMPUTE_0008') &
	or (upper(ls_col_name) = 'PROV_ID' and iv_rand_samp.across_provs) &
	then //NLG Changed COMPUTE_0009 to COMPUTE_0008 - randomly select ID number
		ls_rc = dw_1.Modify(ls_col_name + ".visible='0'")
		ls_rc = dw_1.Modify(ls_col_name + "_t.visible='0'")
	elseif  (upper(ls_col_name) = ls_select_col) then
		ls_rc = dw_1.Modify(ls_col_name + ".visible='1'")
		ls_rc = dw_1.Modify(ls_col_name + "_t.visible='1'")
	end if
Next

ls_field_name 	= trim(mid(iv_rand_samp.sample_by,4))

ls_title 		= 'LIST OF RANDOM SAMPLE UNIVERSE AND~rRANDOMLY GENERATED RAND SAMP ID NBRS'

ls_rc 			= dw_1.Modify('rpt_title.text = ~'' + ls_title + '~'')
ls_rc 			= dw_1.Modify('case_id_t.text = ~'' + gv_active_case + '~'')
ls_rc 			= dw_1.Modify('sample_by_t.text = ~'' + ls_field_name + '~'')
ls_rc 			= dw_1.Modify('seed.text = ~'' + String( iv_rand_samp.sample_seed ) + '~'')
ls_rc 			= dw_1.Modify(ls_select_col + "_t.text = '" + ls_field_name + "'")
if NOT iv_rand_samp.across_provs then
	ls_rc 			= dw_1.Modify("prov_id_t.text = '" + iv_rand_samp.pit_label + "'")
end if

li_num_subsets = upperbound(iv_rand_samp.case_subset_id)
ls_subsets 		= iv_rand_samp.case_subset_id[1]

if li_num_subsets > 1 then
	for li_idx = 2 to li_num_subsets
		ls_subsets = ls_subsets + ',' + iv_rand_samp.case_subset_id[li_idx]
	next
end if

//Save reports to case folder. The dw_rand_samp_nbrs datawindow was
//populated in cb_apply_random_sample when the random sample numbers
//were selected

// Begin - Track 2946d -- call same report window as rest of application
fx_m_save()
//if wf_save_datawindow(dw_1) <> 0 then
//	messagebox('ERROR','Could not save list of of Random Sample Universe')
//end if
// End - Track 2946d

COMMIT Using Stars2CA;

return 0
end function

public subroutine wf_load_any_dropdownlistbox (string arg_table_type[]);//************************************************************************
//		Object Type:	Window function
//		Object Name:	wf_load_any_dropdownlistbox
//
//
// This function will load a list box with all of the field
// labelss for the table type passed into the function as an argument.
// This function may be called multiple times in order to load fields
// from multiple tables into the same listbox.
//		
//
// Arguments: arg_table_type - Type of the table for which field names 
//                             are to be loaded
//            arg_listbox_name - The name of the listbox that is 
//                               to be loaded
//
//*********************************************************************************
//
//	FDG	09/17/97	Stars 3.6.  Move logic from fx_load_any_dropdownlistbox
// AJS   09/02/98 Changed Code to use DDDW instead of listbox
// FNC	09/23/98	Track 1694 - Correct the initial setting of the dddw to ICN
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

datawindowchild ldwc
string ls_inv2
long ll_find_row

dw_3.SetTransObject(Stars2ca)
dw_3.of_setupdateable(false)
dw_3.InsertRow(0)

dw_3.Getchild('as_columns',ldwc)

IF Trim( arg_table_type[2] ) > "" THEN
	ls_inv2 = arg_table_type[2]
ELSE
	ls_inv2 = arg_table_type[1]
END IF

ldwc.SetTransObject(Stars2ca)
ldwc.Retrieve( arg_table_type[1], ls_inv2 )

// FNC 09/23/98 Start
ll_find_row = ldwc.find("elem_name = 'ICN'",1,ldwc.rowcount())
IF ll_find_row > 0 THEN
	ldwc.selectrow(ll_find_row,TRUE)
	dw_3.setcolumn('as_columns')
	dw_3.settext('ICN')
	dw_3.accepttext()
END IF
end subroutine

event close;call super::close;//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_unique_hics.close
//		Event Name:		N/A
//
//09-04-96 FNC	Move delete of temp table entries from close button
//02-04-98 JGG STARS 4.0 - TS145 Random Sampling Unique Hics changes
//
//*****************************************************************************

//	Declare local variables.

Integer									li_rc

//						Check the ue_preclose event script to view the code
//						required to drop the temp table.

if (not IsValid(w_random_sampling_claims) )  then
	delete_from_temp()
end if

// 02-04-98 JGG - begin
//						Must destroy the instance of the datastore used in this window

destroy	ids_datastore

setmicrohelp(w_main,'Ready')

end event

event open;call super::open;//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_unique_hics.open
//		Event Name:		N/A
//
//
//************************************************************************
//
// FNC 	09/22/94	If provider name not on prov_name table, send out
//						messagebox and continue to process.
//
// JGG 	02/28/98	STARS 4.0 - TS145 Random Sample Unique Hics changes
// ajs 	03/11/98	4.0 TS145 - fix globals
//	FDG 	10/09/98	Track 1840.  Replace radiobuttons with dw_sample_size.
//	GaryR	09/05/03	Track 3598d	Add seed logic to sampling process
//
//************************************************************************

String ls_mod_string, ls_return_code

SetPointer(Hourglass!)

This.title += " - Case: " + gv_active_case	//ajs 4.0 03-11-98 Ts145-fix globals

//  Set the Transaction Object for DataWindow 1

If settransobject(dw_1,Stars2ca) < 0 then	
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_apply_random_sample.enabled = FALSE
	cb_close.default = true
	RETURN
End If

//  Set the Transaction Object for DataWindow 2

If settransobject(dw_2,Stars2ca) < 0 then	
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_apply_random_sample.enabled = FALSE
	cb_close.default = true
	RETURN
End If


//						Create an instance of a datastore for use by window functions
//						wf_GetProviderCounts, wf_GetSelectedCounts

ids_datastore		=	CREATE n_ds

//						Create an instance of the temp table non visual object for use
//						by window functions wf_GetProviderCounts, wf_GetSelectedCounts

This.of_set_temp_table(TRUE)

Long			ll_row

ll_row	=	dw_sample_size.InsertRow (0)
dw_sample_size.ScrollToRow (ll_row)
ll_row	=	dw_sample_method.InsertRow (0)
This.Event ue_sample_method()


PostEvent('ue_Universe_Count')
end event

on deactivate;//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_unique_hics.deactivate
//		Event Name:		N/A
//
//
//************************************************************************

setmicrohelp(w_main,'Ready')
end on

on w_random_sampling_unique_hics.create
int iCurrent
call super::create
this.dw_sample_method=create dw_sample_method
this.cbx_add_rpt=create cbx_add_rpt
this.st_distinct_sample_size=create st_distinct_sample_size
this.st_selected_count=create st_selected_count
this.st_distinct_sample_desc=create st_distinct_sample_desc
this.cb_2=create cb_2
this.st_1=create st_1
this.st_4=create st_4
this.st_3=create st_3
this.rb_across_providers=create rb_across_providers
this.rb_within_prov=create rb_within_prov
this.cb_prov_counts=create cb_prov_counts
this.cb_3=create cb_3
this.st_selectedproviders=create st_selectedproviders
this.cb_apply_random_sample=create cb_apply_random_sample
this.cb_1=create cb_1
this.dw_2=create dw_2
this.st_providercount=create st_providercount
this.cb_close=create cb_close
this.gb_2=create gb_2
this.dw_3=create dw_3
this.gb_1=create gb_1
this.dw_sample_size=create dw_sample_size
this.gb_sample_size=create gb_sample_size
this.dw_1=create dw_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sample_method
this.Control[iCurrent+2]=this.cbx_add_rpt
this.Control[iCurrent+3]=this.st_distinct_sample_size
this.Control[iCurrent+4]=this.st_selected_count
this.Control[iCurrent+5]=this.st_distinct_sample_desc
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.rb_across_providers
this.Control[iCurrent+11]=this.rb_within_prov
this.Control[iCurrent+12]=this.cb_prov_counts
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.st_selectedproviders
this.Control[iCurrent+15]=this.cb_apply_random_sample
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.dw_2
this.Control[iCurrent+18]=this.st_providercount
this.Control[iCurrent+19]=this.cb_close
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.dw_3
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.dw_sample_size
this.Control[iCurrent+24]=this.gb_sample_size
this.Control[iCurrent+25]=this.dw_1
this.Control[iCurrent+26]=this.gb_3
end on

on w_random_sampling_unique_hics.destroy
call super::destroy
destroy(this.dw_sample_method)
destroy(this.cbx_add_rpt)
destroy(this.st_distinct_sample_size)
destroy(this.st_selected_count)
destroy(this.st_distinct_sample_desc)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.rb_across_providers)
destroy(this.rb_within_prov)
destroy(this.cb_prov_counts)
destroy(this.cb_3)
destroy(this.st_selectedproviders)
destroy(this.cb_apply_random_sample)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.st_providercount)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.dw_3)
destroy(this.gb_1)
destroy(this.dw_sample_size)
destroy(this.gb_sample_size)
destroy(this.dw_1)
destroy(this.gb_3)
end on

event ue_preopen;call super::ue_preopen;iv_rand_samp = Message.PowerObjectParm
SetNull(message.powerobjectparm)


end event

event ue_preclose;call super::ue_preclose;//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_unique_hics.ue_preclose
//		Event Name:		N/A
//
//02-04-98 JGG STARS 4.0 - TS145 Random Sampling Unique Hics changes
//
//*****************************************************************************

//	Declare local variables.

Integer									li_rc

//						Drop the temporary table built to store provider ids.

inv_temp_attrib.is_function	=	"DROP"
inv_temp_attrib.is_table_name	=	iv_rand_samp.Unique_Cnt_Temp_Table_Name

inv_temp_table.of_set_attrib(inv_temp_attrib)

li_rc	=	inv_temp_table.of_drop_table()

If li_rc < 0 Then
	MessageBox("Warning", "Temporary table " + inv_temp_attrib.is_table_name + " not dropped!", Exclamation!)
End if

RETURN 1

end event

type dw_sample_method from u_dw within w_random_sampling_unique_hics
string accessiblename = "Sample Size"
string accessibledescription = "Sample Size"
accessiblerole accessiblerole = clientrole!
string tag = "NO SAVE"
integer x = 1710
integer y = 724
integer width = 1152
integer height = 228
integer taborder = 80
string dataobject = "d_sample_method_external"
boolean border = false
end type

event constructor;call super::constructor;//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process

// This datawindow is not updateable
This.of_SetUpdateable (FALSE)
end event

event itemchanged;call super::itemchanged;//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process

CHOOSE CASE dwo.name
	CASE "sample_method"
		Parent.Post Event ue_sample_method()
END CHOOSE
end event

type cbx_add_rpt from checkbox within w_random_sampling_unique_hics
long textcolor = 33554432
string accessiblename = "Save Sampling Report"
string accessibledescription = "Save Sampling Report"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1696
integer y = 992
integer width = 709
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Save Sampling Report"
end type

type st_distinct_sample_size from statictext within w_random_sampling_unique_hics
string accessiblename = "Sample Size"
string accessibledescription = "Sample Size"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 2135
integer y = 1216
integer width = 320
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "0"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_selected_count from statictext within w_random_sampling_unique_hics
string accessiblename = "Universe Size"
string accessibledescription = "Universe Size"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 2135
integer y = 1136
integer width = 320
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "0"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_distinct_sample_desc from statictext within w_random_sampling_unique_hics
string accessiblename = "Sample Size"
string accessibledescription = "Sample Size"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 1705
integer y = 1216
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Sample Size:"
boolean focusrectangle = false
end type

type cb_2 from u_cb within w_random_sampling_unique_hics
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1737
integer y = 1724
integer width = 274
integer height = 96
integer taborder = 100
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Update"
end type

on clicked;edit_calc_sample_count()
end on

type st_1 from statictext within w_random_sampling_unique_hics
string accessiblename = "Universe Size"
string accessibledescription = "Universe Size"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 1705
integer y = 1136
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Universe Size:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_random_sampling_unique_hics
string accessiblename = "Selected"
string accessibledescription = "Selected"
accessiblerole accessiblerole = statictextrole!
integer x = 891
integer y = 1628
integer width = 270
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
string text = "Selected:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_random_sampling_unique_hics
string accessiblename = "Total"
string accessibledescription = "Total"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 1628
integer width = 160
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
string text = "Total:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_across_providers from radiobutton within w_random_sampling_unique_hics
long textcolor = 33554432
string accessiblename = "Across Selection"
string accessibledescription = "Across Selection"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 658
integer y = 80
integer width = 603
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Across Selection"
end type

event clicked;//
// This radio button sets random sampling up to be performed looking for the
// selected column by matching against all distinct provider ids within all 
// the selected subsets.
//
//************************************************************************
//
//	JGG	05/01/98	STARS 4.0 - TS 145 Random Sampling changes
// FDG	10/09/98	Track 1840.  Replace radiobuttons with dw_sample_size and
//						ii_sample_size.
//	GaryR	09/05/03	Track 3598d	Add seed logic to sampling process
//
//************************************************************************

dw_sample_size.Object.size_val[1] = 0
cb_prov_counts.enabled = FALSE
end event

type rb_within_prov from radiobutton within w_random_sampling_unique_hics
long textcolor = 33554432
string accessiblename = "Within Selection"
string accessibledescription = "Within Selection"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 41
integer y = 80
integer width = 649
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Within Selection"
boolean checked = true
end type

event clicked;//
// This radio button sets random sampling up to be performed looking for the
// selected column by a distinct provider id within all the selected subsets.
//
//************************************************************************
//
// FDG	10/09/98	Track 1840.  Replace radiobuttons with dw_sample_size and
//						ii_sample_size.
//	GaryR	09/05/03	Track 3598d	Add seed logic to sampling process
//
//************************************************************************

dw_sample_size.Object.size_val[1] = 0
cb_prov_counts.enabled = TRUE
end event

type cb_prov_counts from u_cb within w_random_sampling_unique_hics
string accessiblename = "List"
string accessibledescription = "List..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2030
integer y = 1724
integer width = 274
integer height = 96
integer taborder = 110
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&List..."
end type

event clicked;////////////////////////////////////////////////////////////////////////////////
//
// 09/03/98	FNC 	Track 1659. If user receives error message when click on list
//						button the list is still displayed with the previous values.
//						The list should not be displayed if an error is found. 
//	02/09/07 Katie	SPR 4754 Pass the pit_label to iv_prov_count_struct
////////////////////////////////////////////////////////////////////////////////

if not edit_calc_sample_count() then
	setmicrohelp(w_main,'Edit Error')
	return
end if

if isvalid(w_random_sampling_prov_count) then
   close(w_random_sampling_prov_count)
end if

iv_prov_count_struct.ls_pin_ind = iv_rand_samp.pin_ind
iv_prov_count_struct.ls_pit_label = iv_rand_samp.pit_label

OpenSheetWithParm(w_random_sampling_prov_count,iv_prov_count_struct,MDI_Main_Frame,Help_Menu_Position,Original!)
end event

type cb_3 from u_cb within w_random_sampling_unique_hics
string accessiblename = "Select All"
string accessibledescription = "Select All"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 846
integer y = 1720
integer width = 274
integer height = 96
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Select All"
end type

event clicked;/*
 * 
 *  highlites all of the selected rows 
 *
 */
//************************************************************************************
// 09/23/98	FNC	Track 1742. If more than 75 providers must select manually.
//
//************************************************************************************

if dw_2.rowcount() > 75 then					// FNC 09/23/98 Start
	messagebox('WARNING','There are more than 75 providers. Providers must be selected manually')
	return
else													// FNC 09/23/98 End
 	dw_2.SelectRow(0, TRUE)
	st_selectedproviders.text = string(dw_2.rowcount())
end if

end event

type st_selectedproviders from statictext within w_random_sampling_unique_hics
string accessiblename = "Selected Provider Count"
string accessibledescription = "Selected Provider Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 1166
integer y = 1628
integer width = 361
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_apply_random_sample from u_cb within w_random_sampling_unique_hics
string accessiblename = "View"
string accessibledescription = "View..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2322
integer y = 1724
integer width = 274
integer height = 96
integer taborder = 120
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&View..."
boolean cancel = true
boolean default = true
end type

event clicked;//***********************************************************************
//		Object Type:	CommandButton
//		Object Name:	w_random_sampling_unique_hics.cb_apply_random_sample
//		 Event Name:	Clicked
//***********************************************************************
//
// 11/12/96 FNC	FS118 add a sequential number to dw_1. This will be 
//						added to the case folder if the user checked the 
//						checkbox. The only fields that will be visible will be
//						the sequence number and the random sample field. 
// 11/20/96 FNC	Put generated id nbrs on same report as universe.
//	11/21/96 FNC	Write id nbr to temp table so that it can appear on 
//						Random Sample Claim List
// 03/26/97 FNC	Track #12 Take prov id off of DW_1 because already 
//						put UPIN or	prov id in. 
// 08/21/97	FNC	Track #676 Starcare take provider id out of iv_sSQLInsertWhere. 
//						The where statement must include the individual provider id/upin 
//						associated the selected icn. Select the prov id/upin off of dw_1 
//						and put it in the	where statement that is used when 
//						user_temp_rand_sample is joined to the subset table in order to 
//						select claims for the sample
// 02/04/98	JGG	STARS 4.0 TS145 - Random Sample Univers Changes
// 07/20/98	AJS	4.0  Track #1524 Add code for 'IGNORE' rtnd from w_prefilter_ub92 
// 09/02/98	FNC	Track 1579. The column where must be included in each part of the
//						union. Originally it was put on at the end of the 
//						sql so it was only applied to the last subset.
// 09/02/98	AJS 	Change code to use dw instead of listbox
// 09/03/98	FNC	Keep button enabled.
//	10/09/98	FDG	Track 1840.  Replace radiobuttons with dw_sample_size and
//						ii_sample_size (1=rb_stats, 2=rb_#, 3=rb_%).
// 11/25/98	FNC	Track 1406. Modify labels in note
//	01/18/99	FDG	Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
//	07/26/01	GaryR	Track 2381d	Improper use of a date field in select
//	10/23/01	GaryR	Track 2381d	Improper use of a date field in where
//	11/09/01	GaryR	Track 2533d	Handle duplicate inserts to USER_TEMP_RAND_SAMPLE
//	01/16/02 SAH	Track 2619: DB error when two or more subsets are used.
//						Because we retrieve each time through while building the
//						SELECT statement, UNION was getting tacked on to the end
//						of the last INSERT statement.  Call the Retrieve() after
//						the entire SELECT is built.
// 01/18/02 JSB   Track 2593b. Change name of COMPUTE_0001 to ID_NBR and
//                also make corresponding change to datawindow
//                d_random_sampling_random_selection.
//	02/07/02	FDG	Track 2796d. An infinite loop can occur when iv_lprovidercount[] = 0
//						and iv_lprovideroffset[] = 0.  This causes li_rand_num to be 0.
//	02/25/02	GaryR	Track 3979c	Obtain the correct column name.
//	02/28/02	GaryR	Track 2844d	Prevent infinate loop.
//	03/11/02	FDG	Track 4033c.  Problem occurs when d/w has more than 32K rows.
//	03/14/02	GaryR	Track 2870d	Continue getting random values upto the sample size
// 07/26/02	Jason	Track 3199d Increment row counter only if you get a sample hit
// 07/31/02	Jason	Backed out Track 3199d change
//	12/24/02	GaryR	Track 2934d	Fixed multilpe subset logic
//	06/24/03	GaryR	Track 3278d	Trim the column value in where
//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process
//	09/23/03	GaryR	Track 3598d	Post-DCG changes
//	02/09/07 Katie		SPR 4754 Moved code setting iv_rand_samp.across_providers to before
//							we call wf_BuildSelectDataWindow ()
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//************************************************************************

Boolean		lb_first_time	
Boolean		lb_stop_work

Datawindowchild ldwc_columns

Integer		li_filter_count						
Integer		li_i
Integer		li_idx
Integer		li_rc								
Integer		li_subsets_selected

Long	 		ll_hit_count		// FDG 03/11/02
Long			ll_rand_num			// FDG 03/11/02
Long			ll_row				// FDG 03/11/02
Long			ll_suba				// FDG 03/11/02
Long			ll_suba_rowcount	// FDG 03/11/02
Long			ll_next_prov_selected
Long			ll_num_provs_selected
Long			ll_prov_count
Long			ll_prov_offset
Long			ll_prov_rows
Long			ll_prov_sample_size
Long			ll_rc											
Long			ll_rowcount			//	GaryR	11/09/01	Track 2533d

String		ls_col_value
String		ls_column_where
string		ls_filter_table_name = 'SUB_FILTER_VALS'
String		ls_join_clause
String		ls_prefix	
String		ls_prov_id
String		ls_rand_nbr
String		ls_select_tables
String		ls_sub_src_type	
String		ls_sql
String		ls_sql_where
String		ls_table_type
String		ls_table_type_and_name
String		ls_sample_field
String		ls_distinct_icns
String		ls_icn_value					//	GaryR	11/09/01	Track 2533d
String		ls_subset_id
String 		ls_empty_string

Date			ld_dummy							//	10-23-01	GaryR	Track 2381d

n_ds			lds_ignore_dup_key			//	GaryR	11/09/01	Track 2533d

n_cst_prefilter_attrib lnv_cst_prefilter_attrib

ll_num_provs_selected = 0
setpointer(hourglass!)

if not edit_calc_sample_count() then
	setmicrohelp(w_main,'Edit Error')
	return
end if

If iv_rand_samp.base_type = 'UB92' Then
	If iv_rand_samp.mode        = 'VIEW'	&
	Or iv_rand_samp.bJoinActive = TRUE 		Then

		ls_sub_src_type = 'SS'
	
		if iv_rand_samp.sjointabletype <> '' then
			ls_prefix = iv_rand_samp.sjointabletype + '.'
		else
			ls_prefix = iv_Rand_Samp.Table_id + '.'
		end if	
	
		lnv_cst_prefilter_attrib.is_where = ls_sub_src_type + "~~t" &
								+ ls_prefix 		+ "~~t" &
								+ iv_rand_samp.selected_subset_list
							
		openwithparm(w_prefilter_ub92,lnv_cst_prefilter_attrib)

		lnv_cst_prefilter_attrib = message.PowerObjectParm
		setnull(message.PowerObjectParm)

		if lnv_cst_prefilter_attrib.is_where = 'CANCEL' Then 
			RETURN
		End if

		// AJS 07/20/98 4.0 track #1524
		if lnv_cst_prefilter_attrib.is_where = 'IGNORE' Then 
			iv_rand_samp.subset_crit = ' '
		else
			li_filter_count = lnv_cst_prefilter_attrib.ii_filter_count
			iv_rand_samp.subset_crit = lnv_cst_prefilter_attrib.is_where
		end if
	End if
End if

if rb_across_providers.checked = TRUE then
	iv_rand_samp.across_provs = TRUE
else
	iv_rand_samp.across_provs = FALSE
end if

if not wf_BuildSelectDataWindow () then
	setmicrohelp(w_main,'wf_BuildSelectDataWindow error')
	return
end if

//FNC 06-12-96 added code to include filter table name in the from statement
//if filters were part of the criteria used to create the subset
if li_filter_count > 0 then
	
	for li_i = 1 to li_filter_count
		iv_rand_samp.sfilter_tables = ls_filter_table_name + ' FV' + string(li_i) + ', '  
	next

end if

setmicrohelp(w_main,'Prepare for Random Selection')

SelectRow(dw_1,0,FALSE)    //  Deselect all detail rows

ls_table_type = iv_Rand_Samp.table_id
ll_prov_rows = dw_2.RowCount()
ll_next_prov_selected = 0
lb_stop_work = false

ll_row = 1

// Obtain a random seed
//	Then randomize with the seed
//	so that the sequence can be repeated
//	If the method is seeded
//	then use the seed to randomize

dw_sample_method.AcceptText()
IF dw_sample_method.GetItemString( 1, "sample_method" ) = "1" THEN
	iv_rand_samp.sample_seed = Rand( 9999 )
ELSE
	iv_rand_samp.sample_seed = dw_sample_method.GetItemNumber( 1, "seed_id" )
END IF
Randomize( iv_rand_samp.sample_seed )

if iv_rand_samp.across_provs then
	
	// Loop until randomly selected the sample count
	DO WHILE (ll_hit_count < long(iv_sample_count))
		ll_rand_num = wf_rand(long(st_selected_count.text))	
      if ll_row > ii_rowcount then								
			ll_rc = dw_1.insertrow(ll_row)						
		end if															

		li_rc = dw_1.SetItem ( ll_row,'COMPUTE_0008',ll_rand_num )	
		// JasonS 07/31/02 Begin - Track 3199d uncommented this line to back out 3199d change
		// JasonS 07/26/02 Begin - Track 3199d
		ll_row++									
		// JasonS 07/26/02 End - Track 3199d
		// JasonS 07/31/02 End - Track 3199d
		
		if not dw_1.IsSelected(ll_rand_num) then
			setmicrohelp(w_main, &
				'Randomly selecting rows - Selected row # ' &
				+ string(ll_rand_num))
			dw_1.ScrollToRow(ll_rand_num)
			// FDG 02/07/02 - Select only if ll_rand_num > 0
			IF	ll_rand_num > 0	THEN
				SelectRow(dw_1,ll_rand_num,TRUE)
			END IF

			ll_hit_count = ll_hit_count + 1
		end if
	LOOP
else
	do while not lb_stop_work 
		ll_next_prov_selected = dw_2.GetSelectedRow(ll_next_prov_selected) 
		if ll_next_prov_selected = 0 then
			lb_stop_work = TRUE
		else
			ll_num_provs_selected = ll_num_provs_selected + 1
			ll_prov_sample_size = iv_lProviderSampleSize[ll_next_prov_selected]
			ll_prov_offset = iv_lProviderOffSet[ll_next_prov_selected]
			ll_prov_count = iv_lProviderCount[ll_next_prov_selected]
			ll_hit_count = 0
			iv_rand_samp.prov = dw_2.GetItemString(ll_next_prov_selected, 1)
			
			// Loop until randomly selected the sample count
			DO WHILE ll_hit_count < ll_prov_sample_size
				ll_rand_num = (wf_rand(ll_prov_count) + ll_prov_offset)  
      		
				if ll_row > ii_rowcount then								
					ll_rc = dw_1.insertrow(ll_row)						
				end if															
				
				li_rc = dw_1.SetItem ( ll_row,'COMPUTE_0008',ll_rand_num )	
				
				ll_row++									
				
				if not dw_1.IsSelected(ll_rand_num) then
					setmicrohelp(w_main, &
						'Randomly selecting rows - Selected row # ' &
						+ string(ll_rand_num))
					dw_1.ScrollToRow(ll_rand_num)
					// FDG 02/07/02 - Hilite row only if ll_rand_num > 0
					IF	ll_rand_num > 0  THEN
						dw_1.SelectRow(ll_rand_num, TRUE)
					END IF
					//	03/14/02	GaryR	Track 2870d
					ll_hit_count = ll_hit_count + 1
				end if
			LOOP
		end if
	Loop
end if


if ll_num_provs_selected > 1 then
	iv_rand_samp.prov = "" 
end if

//03-27-96 FNC Before inserting into the temp table delete any
//             rows that exist from a previous iteration

if not delete_from_temp() then return

//03-27-96 FNC End

if gc_debug_mode = TRUE then
	f_debug_box("Debug", "SQL To add subset data to temp table: " +  ls_sql)
end if

ls_col_value = ""

//Add sequence number to dw_1
for ll_row = 1 to ii_rowcount
	dw_1.SetItem(ll_row, 1, ll_row)
next

//11-21-96 FNC Added GetItemNumber for COMPUTE_0001
//08-21-97 FNC Get the prov id/upin from dw_1 instead of using and
//					in statement with all the prov ids

// SAH 01/15/01 - for debugging
ll_suba_rowcount = ii_rowcount

FOR ll_suba =  1 to ll_suba_rowcount   //ii_rowcount
	if dw_1.IsSelected(ll_suba) then
		
		ls_sql = "" 
		
		// SAH 01/14/01 Put into local variable for debugging
		li_subsets_selected = iv_rand_samp.subsets_selected 		
		FOR li_idx = 1 to li_subsets_selected
			
				   						
			If li_idx > 1 Then
				ls_sql	=	ls_sql + " UNION "
			End If
			
         ls_rand_nbr	=	string(dw_1.GetItemNumber(ll_suba, 'ID_NBR'))  // jsb 01/18/02
			
			ls_prov_id	=	dw_1.GetItemString(ll_suba, 3)
			
			ls_select_tables	=	iv_rand_samp.Subset_Table_Name[li_idx] &
									+	" "												&
									+	iv_rand_samp.table_id 
			ls_join_clause		=	" "

			If iv_rand_samp.sJoinTableType > "" Then
				if  Left(iv_sSelectedColumn, 3)  &
				 =	(RightTrim(iv_rand_samp.sJoinTableType) + ".") 	Then
				
					ls_select_tables	=	RightTrim(ls_select_tables) 				+ 	",  "		&
											+	iv_rand_samp.sJoinSubsetName[li_idx]	+ 	" " 		&
											+ 	iv_rand_samp.sJoinTableType 				+ 	" "
											
					ls_join_clause 	= 	" AND ( " 	+ iv_rand_samp.table_id						&
											+ 	"." 			+ iv_rand_samp.sJoinMainKey				&
											+ 	" = "			+ iv_rand_samp.sJoinTableType				&
											+ 	"." 			+ iv_rand_samp.sJoinDepnKey				&
											+	" ) "
				End if
			End if
	
			// FDG 01/18/98 - Convert date to mm/dd/yyyy format
			//	07-26-01	GaryR	Track 2381
			ls_sql	=	ls_sql &
						+	" SELECT DISTINCT "																	&
						+	"'" + gc_user_id 														+	"', "		&
						+ gnv_sql.of_get_to_date( string(iv_rand_samp.temp_datetime, 'mm/dd/yyyy hh:mm:ss') )	+	", "		&
						+	"'" + iv_rand_samp.case_subset_id[li_idx]						+	"', "		&
						+	ls_table_type + ".ICN"												+	", "		&
						+	ls_rand_nbr																				&
						+	" FROM "																					&
						+	ls_select_tables														+	" "		&
						+	" WHERE ( "
						
			If rb_within_prov.Checked Then
				ls_sql_where	=	ls_table_type 							+ 	"." 		&
									+ 	iv_rand_samp.prov_col_name			+	" = '" 	&
									+	Upper( ls_prov_id )					+ 	"' "	
			Else
				ls_sql_where	=	ls_table_type							+ 	"."		&
									+	iv_rand_samp.prov_col_name			+	" in ("	&
									+	Upper( iv_rand_samp.selected_prov_list )	+	") "
			End if
			
			ls_sql	=	ls_sql + ls_sql_where + ls_join_clause+ ") "
						
			CHOOSE CASE iv_lSelectedColumnType
				CASE 1
					ls_col_value		= 	String(dw_1.GetItemNumber(ll_suba, 'COMPUTE_0004'))
					//	10-23-01	GaryR	Track 2381d - Begin
					IF gnv_sql.of_is_date_data_type( iv_sselcoldatatype ) THEN
						IF NOT IsDate( ls_col_value ) THEN Return MessageBox( "Error", "Not a valid date - " + ls_col_value )
						ld_dummy = Date( ls_col_value )
						ls_col_value = gnv_sql.of_get_to_date( String( ld_dummy, "mm/dd/yyyy" ) )
					END IF
					//	10-23-01	GaryR	Track 2381d - End
					gnv_sql.of_TrimData( ls_col_value )
					ls_column_where 	= 	" and ( " + iv_sSelectedColumn  										&
											+	" = "	+ ls_col_value														&
											+ 	" ) "
				CASE 2
					ls_col_value 		= 	RightTrim(dw_1.GetItemString(ll_suba, 'COMPUTE_0005'))
					gnv_sql.of_TrimData( ls_col_value )
					ls_column_where 	=  " and ( " + iv_sSelectedColumn  										&
											+	" = '" + ls_col_value 													&
											+ "' ) "
					//	10-23-01	GaryR	Track 2381d - Begin
					IF gnv_sql.of_is_date_data_type( iv_sselcoldatatype ) THEN
						IF NOT IsDate( ls_col_value ) THEN Return MessageBox( "Error", "Not a valid date - " + ls_col_value )
						ld_dummy = Date( ls_col_value )
						ls_col_value = gnv_sql.of_get_to_date( String( ld_dummy, "mm/dd/yyyy" ) )
						ls_column_where 	=  " and ( " + iv_sSelectedColumn  										&
												+	" = " + ls_col_value 													&
												+ " ) "
					END IF
					//	10-23-01	GaryR	Track 2381d - End											
				CASE 3
					ls_col_value 		= 	Trim(dw_1.GetItemString(ll_suba, 'COMPUTE_0006'))
					gnv_sql.of_TrimData( ls_col_value )
					ls_column_where 	=  " and ( " + iv_sSelectedColumn 										&
											+	" = '"																		&
											+ 	Trim(dw_1.GetItemString(ll_suba, 'COMPUTE_0006'))				&
											+ 	"' ) "
					//	10-23-01	GaryR	Track 2381d - Begin
					IF gnv_sql.of_is_date_data_type( iv_sselcoldatatype ) THEN
						IF NOT IsDate( ls_col_value ) THEN Return MessageBox( "Error", "Not a valid date - " + ls_col_value )
						ld_dummy = Date( ls_col_value )
						ls_col_value = gnv_sql.of_get_to_date( String( ld_dummy, "mm/dd/yyyy" ) )
						gnv_sql.of_TrimData( ls_col_value )
						ls_column_where 	=  " and ( " + iv_sSelectedColumn 										&
											+	" = " + 	ls_col_value												&
											+ 	" ) "
					END IF
					//	10-23-01	GaryR	Track 2381d - End																	
				CASE 4
					ls_col_value 		= 	String(dw_1.GetItemNumber(ll_suba, 'COMPUTE_0007'))
					//	10-23-01	GaryR	Track 2381d - Begin
					IF gnv_sql.of_is_date_data_type( iv_sselcoldatatype ) THEN
						IF NOT IsDate( ls_col_value ) THEN Return MessageBox( "Error", "Not a valid date - " + ls_col_value )
						ld_dummy = Date( ls_col_value )
						ls_col_value = gnv_sql.of_get_to_date( String( ld_dummy, "mm/dd/yyyy" ) )
					END IF
					//	10-23-01	GaryR	Track 2381d - End
					gnv_sql.of_TrimData( ls_col_value )
					ls_column_where 	=  " and ( " + iv_sSelectedColumn 										&
											+ 	" = " + ls_col_value 													&
											+ " ) "
				CASE ELSE
					ls_column_where 	= 	" "
			END CHOOSE
			ls_sql = RightTrim(ls_sql) + ls_column_where					// FNC 09/02/98 

			NEXT
			
			li_idx = li_idx - 1
			
			IF IsValid( lds_ignore_dup_key ) THEN Destroy lds_ignore_dup_key
			//	GaryR	11/09/01	Track 2533d - End	
			
			lds_ignore_dup_key = Create n_ds
			lds_ignore_dup_key.dataobject = "d_ignore_dup_key"
			lds_ignore_dup_key.SetTransObject( Stars2ca)
			IF lds_ignore_dup_key.SetSQLSelect( ls_sql ) <> 1 THEN
				MessageBox( "Error", "Unable to set the following SQL: " + ls_sql )
				IF IsValid( lds_ignore_dup_key ) THEN Destroy lds_ignore_dup_key
				Return
			END IF
			ll_rowcount = lds_ignore_dup_key.Retrieve()
			
			FOR ll_row = 1 TO ll_rowcount
				ls_icn_value = lds_ignore_dup_key.GetItemString( ll_row, "icn" )
				ls_subset_id = lds_ignore_dup_key.GetItemString( ll_row, "subc_id" )
				
				ls_sql = "INSERT INTO USER_TEMP_RAND_SAMPLE VALUES ( '" + gc_user_id +	"', "		&
							+ gnv_sql.of_get_to_date( string(iv_rand_samp.temp_datetime, 'mm/dd/yyyy hh:mm:ss') )	+	", "		&
							+	"'" + ls_subset_id +	"', '" + ls_icn_value +	"', " + ls_rand_nbr + " )"
						
				if gc_debug_mode = TRUE then
					f_debug_box("Debug", "SQL To add subset data to temp table: " +  ls_sql)
				end if
		
				IF Stars2ca.of_insert( ls_sql ) <> 0 THEN
					Errorbox(stars2ca,'Unable to create temporary table of claim data from subset data')
					IF IsValid( lds_ignore_dup_key ) THEN Destroy lds_ignore_dup_key
					Stars2ca.of_RollBack()
					return
				End If
			NEXT
			
			// SAH 01/16/02 Track 2494 End

				setmicrohelp(w_main,'Inserting selected row -  ' + string(ll_suba)+ '  -  ' + ls_col_value) 

			//	ls_sql = RightTrim(ls_sql) + ls_column_where					// FNC 09/02/98

		dw_1.ScrollToRow(ll_suba)
	end if
NEXT

COMMIT using stars2ca;

setmicrohelp(w_main,'Random selection Complete ' + string(ll_rand_num))

//AJS 09-02-98 Use DDDW instead
//iv_rand_samp.sample_by = ddlb_columns.text
dw_3.getChild('as_columns',ldwc_columns)

//	02/25/02	GaryR	Track 3979c - Begin
ls_table_type_and_name = dw_3.object.as_columns[1]
ll_row = ldwc_columns.RowCount()
ll_row = ldwc_columns.Find( "elem_name = '" + ls_table_type_and_name + "'", 1, ll_row )
iv_rand_samp.sample_by = Trim( ldwc_columns.GetItemString( ll_row, "elem_table_and_desc" ) )
//	02/25/02	GaryR	Track 3979c - End

//AJS 09-02-98 end

// now update notes string with item counts
//	NLG Track #1405 - First, make sure string is empty
iv_rand_samp.file_list 	= ls_empty_string

//FNC 11/25/98 Start
if ls_sample_field = 'ICN' then
	ls_distinct_icns = st_selected_count.text
else
	ls_distinct_icns = string(wf_calc_count_prov_icns(iv_rand_samp.selected_provs))
end if

iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
								+ 	"~r~nTotal Claim Universe = "	&
								+ 	ls_distinct_icns					&
								+ "~r~n"								

//FNC 11/25/98 End

iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
								+ 	"Total Claim Line Univ = " 	&
								+ 	string(iv_line_univ)				&
								+ "~r~n"								 			


// FNC 11/25/98 - replace hard coded 'Tot Pat' with name of selected random sample field
ls_sample_field = trim(mid(iv_rand_samp.sample_by,4))
iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
								+  ls_sample_field					&
								+ 	" Universe Size = " 				&
								+ 	st_selected_count.text 			&
								+ 	"~r~n"

// FNC 11/25/98 - replace hard coded 'Pat Samp Count' with name of selected random sample field
iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
								+  ls_sample_field					&
								+ 	" Sample Size = " 				&
								+ 	iv_sample_count					&
								+ "~r~n"

dw_sample_size.AcceptText()
iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
								+ 	"Requested Sample Size = " 	&
								+ 	String( dw_sample_size.GetItemNumber( 1, "size_val" ) )	&
								+ "~r~n"			

IF dw_sample_method.GetItemString( 1, "sample_method" ) = "1" THEN
	iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
									+ 	"Seed Generation = System Generated"	&
									+ "~r~n"											
ELSE
	iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
									+ 	"Seed Generation = User Defined"	&
									+ "~r~n"	
END IF

iv_rand_samp.file_list 	= 	iv_rand_samp.file_list 			&
								+ 	"Sample Seed = " 	&
								+ 	string(iv_rand_samp.sample_seed)	&
								+ "~r~n"									

setmicrohelp(w_main,'Ready')

if isvalid(w_random_sampling_claims) then
   close(w_random_sampling_claims)
end if

if ii_sample_size	=	2 then
	iv_rand_samp.sample_type = 'By Number'
elseif ii_sample_size	=	3 then
	iv_rand_samp.sample_type = 'By Percent'	
else
	iv_rand_samp.sample_type = 'Statistical'
end if

iv_rand_samp.universesize = long(st_selected_count.text)		

if cbx_add_rpt.checked = TRUE then			
	wf_create_sampling_reports()
end if												

OpenSheetWithParm(w_random_sampling_claims,iv_rand_samp,MDI_Main_Frame,Help_Menu_Position,Layered!)

return
end event

type cb_1 from u_cb within w_random_sampling_unique_hics
string accessiblename = "Clear All"
string accessibledescription = "Clear All"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 475
integer y = 1720
integer width = 274
integer height = 96
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "C&lear All"
end type

on clicked;/*
 * 
 *  de-highlites all of the selected rows 
 *
 */
	dw_2.SelectRow(0 ,FALSE)
   st_selectedproviders.text = '0'

end on

type dw_2 from u_dw within w_random_sampling_unique_hics
string accessiblename = "Provider List"
string accessibledescription = "Provider List"
accessiblerole accessiblerole = clientrole!
integer x = 37
integer y = 156
integer width = 1586
integer height = 1468
integer taborder = 30
string dataobject = "d_random_sampling_provider_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;//********************************************************************
// 09/23/98	FNC Track 1742. Put edit back in to check for 75 providers 
//				because edit is not hit in ue_universe count once window is 
//				open.
//
// 07/03/96	STARS33 prob #8 Take out edit for number of providers. 
//				User receives a warning if greater than 75 in ue_universe_count
//
// 02-29-96 FNC Update selected count automatically as providers are
//              selected or deselected
//********************************************************************

/*Clicked for data window 2*/
int row_nbr
 

/*gets the row and makes sure a row was clicked*/
row_nbr = row
If row_nbr = 0 then
	return
end if

if st_providercount.text = '' then   //02-02-96 FNC Start
   st_providercount.text = '0'
end if                               //02-02-96 FNC End

/*Highlights / de-highlites the selected row*/
if dw_2.IsSelected(row_nbr) then
	SelectRow(dw_2,row_nbr,FALSE)
   st_selectedproviders.text = string(integer(st_selectedproviders.text) - 1) //02-29-96 FNC
else
   st_selectedproviders.text = string(integer(st_selectedproviders.text) + 1)  //02-29-96 FNC
   if integer(st_selectedproviders.text) > 75 then				// FNC 09/23/98, 07/02/96 Start	
     messagebox('WARNING','Selected 75 providers. May not select any more')
     st_selectedproviders.text = '75'
   else
	  SelectRow(dw_2,row_nbr,TRUE)
   end if																	// FNC 09/23/98, 07/02/96 Start	
end if

end event

type st_providercount from statictext within w_random_sampling_unique_hics
string accessiblename = "Total Provider Count"
string accessibledescription = "Total Provider Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 197
integer y = 1628
integer width = 315
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_random_sampling_unique_hics
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2615
integer y = 1724
integer width = 274
integer height = 96
integer taborder = 130
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

event clicked;// Trigger the close window event script.
// All special logic should be handled in that script.

close(parent)
end event

type gb_2 from groupbox within w_random_sampling_unique_hics
string accessiblename = "Selection"
string accessibledescription = "Selection"
accessiblerole accessiblerole = groupingrole!
integer x = 9
integer y = 12
integer width = 1650
integer height = 1832
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Selection"
end type

type dw_3 from u_dw within w_random_sampling_unique_hics
string accessiblename = "Sampling Selection Column"
string accessibledescription = "Sampling Selection Column"
accessiblerole accessiblerole = clientrole!
string tag = "NO SAVE"
integer x = 1742
integer y = 116
integer width = 1088
integer height = 92
integer taborder = 60
string dataobject = "d_rs_columns"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;//***************************************************************
//
//	FNC 09/23/98	Track 1694. The new column the user selected has not been 
//						applied to the datawindow before this event so need to
//						use the value in the data argument.
// AJS 09/02/98	Change code to use DDDW instead of listbox
//	FDG 09/18/97	Stars 3.6.  Call wf_getcolumntype instead
//						of fx_getcolumntype.
//
// Gary-R	 08/10/2000		2936C		Random Sample Revenue
//***************************************************************

String				sColumnSelected
datawindowchild	ldwc_columns
long ll_row
string ls_sSelectedColumnType

//iv_sSelectedColumn = data								// FNC 09/23/98	// Gary-R	 08/10/2000		2936C

This.getChild('as_columns',ldwc_columns)
ll_row = ldwc_columns.GetRow()
ls_sSelectedColumnType = ldwc_columns.GetItemString(ll_row,'elem_tbl_type')
iv_sSelectedColumn = Trim( ls_sSelectedColumnType ) + "." + Trim( data )	// Gary-R	 08/10/2000		2936C
//iv_lSelectedColumnType = wf_getcolumntype(ls_sSelectedColumnType,iv_sSelectedColumn)
iv_lSelectedColumnType = wf_getcolumntype(ls_sSelectedColumnType, data)	// Gary-R	 08/10/2000		2936C
if not iv_lSelectedColumnType > 0 then
	MessageBox("SelectionChanged for ddlb_Columns", "Bad Selected Column Type: " + String(iv_lSelectedColumnType))
  	cb_close.PostEvent(Clicked!)
	return
end if
end event

event itemerror;call super::itemerror;RETURN 2  //Allow all values
end event

type gb_1 from groupbox within w_random_sampling_unique_hics
string accessiblename = "Sample Selection"
string accessibledescription = "Sample Selection"
accessiblerole accessiblerole = groupingrole!
integer x = 1687
integer y = 32
integer width = 1211
integer height = 228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Sample Selection"
end type

type dw_sample_size from u_dw within w_random_sampling_unique_hics
string accessiblename = "Universe Size"
string accessibledescription = "Universe Size"
accessiblerole accessiblerole = clientrole!
string tag = "NO SAVE"
integer x = 1714
integer y = 348
integer width = 1152
integer height = 224
integer taborder = 70
string dataobject = "d_sample_size_external"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;///////////////////////////////////////////////////////////////////
//
// Post to the window's ue_sample_size event to mimic the
//	radiobutton's being clicked.  The event is posted to because
//	the data does not get applied to the d/w until this event
//	is finished
//
///////////////////////////////////////////////////////////////////
//
//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process
//
///////////////////////////////////////////////////////////////////

CHOOSE CASE dwo.name
	CASE "sample_size"
		Parent.Post	Event	ue_sample_size()
END CHOOSE

end event

event constructor;call super::constructor;// This datawindow is not updateable
This.of_SetUpdateable (FALSE)

end event

type gb_sample_size from groupbox within w_random_sampling_unique_hics
string accessiblename = "Sample Size"
string accessibledescription = "Sample Size"
accessiblerole accessiblerole = groupingrole!
integer x = 1687
integer y = 288
integer width = 1211
integer height = 328
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Sample Size"
end type

type dw_1 from u_dw within w_random_sampling_unique_hics
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Unique Patients"
boolean visible = false
integer x = 1701
integer y = 1352
integer width = 425
integer height = 276
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_random_sampling_random_selection"
end type

type gb_3 from groupbox within w_random_sampling_unique_hics
string accessiblename = "Seed Generation"
string accessibledescription = "Seed Generation"
accessiblerole accessiblerole = groupingrole!
integer x = 1687
integer y = 652
integer width = 1211
integer height = 328
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Seed Generation"
end type

