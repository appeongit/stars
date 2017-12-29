$PBExportHeader$w_random_sampling_selection.srw
$PBExportComments$Select info for applying random sampling algorithm (Inherited from w_master)
forward
global type w_random_sampling_selection from w_master
end type
type st_3 from statictext within w_random_sampling_selection
end type
type ddlb_pit from dropdownlistbox within w_random_sampling_selection
end type
type st_subsets_selected from statictext within w_random_sampling_selection
end type
type st_row_count from statictext within w_random_sampling_selection
end type
type st_2 from statictext within w_random_sampling_selection
end type
type st_1 from statictext within w_random_sampling_selection
end type
type sle_case_id from singlelineedit within w_random_sampling_selection
end type
type st_case_id from statictext within w_random_sampling_selection
end type
type cb_create from u_cb within w_random_sampling_selection
end type
type cb_close from u_cb within w_random_sampling_selection
end type
type dw_1 from u_dw within w_random_sampling_selection
end type
type cbx_revenue from checkbox within w_random_sampling_selection
end type
end forward

global type w_random_sampling_selection from w_master
string accessiblename = "Random Sampling Selection"
string accessibledescription = "Random Sampling Selection"
accessiblerole accessiblerole = windowrole!
integer x = 128
integer y = 140
integer width = 2889
integer height = 2024
string title = "Random Sampling Selection"
long backcolor = 67108864
st_3 st_3
ddlb_pit ddlb_pit
st_subsets_selected st_subsets_selected
st_row_count st_row_count
st_2 st_2
st_1 st_1
sle_case_id sle_case_id
st_case_id st_case_id
cb_create cb_create
cb_close cb_close
dw_1 dw_1
cbx_revenue cbx_revenue
end type
global w_random_sampling_selection w_random_sampling_selection

type variables
s_rand_samp		iv_rand_samp

String			is_ml_subset_id

Long 			il_pit_selected
end variables

forward prototypes
public function integer wf_getjointables ()
public subroutine wf_verify_active_case ()
public function integer wf_compare_case_id ()
public subroutine wf_get_active_case ()
public function integer wf_verify_case_id (string as_case_id)
public function boolean get_pin_upin ()
public function integer wf_build_temp_table ()
public function boolean delete_from_temp ()
end prototypes

public function integer wf_getjointables ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_random_sampling_selection.wf_getjointables
//		Event Name:		N/A
//
//  Check for "Join" table information. 
//  If none, prepare for single table processing.
//
//************************************************************************
//
// JGG 01/28/98   STARS 4.0 - TS145 Random Sampling Selection Changes.
//
//************************************************************************

// Define local variables

long			ll_join_rows

n_ds			lds_datastore	

// Initialize the Join Fields in the random sample structure

iv_rand_samp.sJoinTableType 	= 	""
iv_rand_samp.sJoinTableName	= 	""
iv_rand_samp.sJoinMainKey		= 	""
iv_rand_samp.sJoinDepnKey 		= 	""

// See if there is a JOIN condition defined in STARS_WIN_PARM for this
// invoice type:
// 	COL_NAME contains the invoice type to join to
// 	A_DFLT	contains the main table join column name
// 	LABEL		contains the dependent table join column name

lds_datastore					=	CREATE n_ds

lds_datastore.DataObject	=	'd_rand_samp_join_table'

lds_datastore.SetTransObject(Stars2ca)

ll_join_rows 					=	lds_datastore.Retrieve(iv_Rand_Samp.table_id)

//						Store join condition parameters in iv_rand_samp

If ll_join_rows > 0 Then
	iv_rand_samp.sJoinTableType 	= 	lds_datastore.GetItemString(ll_join_rows, 'COL_NAME')
	iv_rand_samp.sJoinMainKey		= 	lds_datastore.GetItemString(ll_join_rows, 'A_DFLT')
	iv_rand_samp.sJoinDepnKey 		= 	lds_datastore.GetItemString(ll_join_rows, 'LABEL')

	If gc_debug_mode Then
		messagebox("Table to use ", iv_rand_samp.sJoinTableType)
	End if
End if

DESTROY lds_datastore

RETURN 1
end function

public subroutine wf_verify_active_case ();//************************************************************************
//		Object Type:	Window Function
//		Object Name:	w_random_sampling_selection::wf_verify_active_case
//
//		Description:	Controls the environment of random sampling 
//							when triggered by the subset screen
//		Returns:			None
//		Arguments:		None
//
//************************************************************************
//
//04/14/2000 Gary Rubalsky STARS 4.5 TS1741c - Subset Random Sample
//
//************************************************************************

// Determine if the subset case matches the current case
IF	wf_compare_case_id()	<	0 THEN	
	// A valid case could not be determined, close the window
	MessageBox ( 'Error', 'A valid case was not selected.~n~rThis window will be closed.' )
	ib_disableclosequery	=	TRUE
	Close( THIS )
	RETURN
END IF

end subroutine

public function integer wf_compare_case_id ();//************************************************************************
//		Object Type:	Window Function
//		Object Name:	w_random_sampling_selection::wf_compare_case_id
//
//		Description:	This script will compare the case associated with
//							the subset to the active case.  If the subset's case = 'NONE', 
//							change it to the active case.  If the cases' do not match,
//							prompt the user to see if the he/she wants the case subset to
//							become the active case.
//
//		Returns:			Integer	( 1	=	Success  /  -1	=	Failure )
//		Arguments:		None
//
//************************************************************************
//
//	04/14/00 GaryR	STARS 4.5 TS1741c - Subset Random Sample
//	02/16/04	GaryR	Track 3837d	Do not reset Case in array if source Case is NONE
//
//************************************************************************

Boolean	lb_found
Integer	li_rc
String	ls_case

// Obtain the current case
ls_case	=	Trim( iv_rand_samp.case_id + iv_rand_samp.case_spl + iv_rand_samp.case_ver )

// Compare the current case VS the active case
IF	ls_case <> gv_active_case THEN
	IF Upper( ls_case ) = "NONE" OR Trim( ls_case ) = "" THEN
//		iv_rand_samp.case_id	= Left(gv_active_case, 10)
//		iv_rand_samp.case_spl = Mid (gv_active_case, 11, 2)
//		iv_rand_samp.case_ver = Mid (gv_active_case, 13, 2)
	ELSE
		li_rc	=	MessageBox ('Active Case', 'The case associated with the subset is '	+	&
						ls_case	+	'.  The active case is '	+	gv_active_case	+	&
						'.  Would you like to make '				+	ls_case			+	&
						' the active case?',	Question!,	YesNo!,	1)
		IF	li_rc	=	1		THEN
			gv_active_case	=	ls_case
		ELSE
			sle_case_id.Text = gv_active_case			
		END IF
	END IF
END IF

DO UNTIL lb_found
	li_rc	=	wf_verify_case_id (ls_case)
	IF	li_rc	<	0		THEN
		// Invalid case.  Force the user to select another case
		wf_get_active_case()
		IF	gv_result	=	100		THEN
			// The user cancelled from seelcted a new case
			Return	-1
		END IF
		// Reset the case ID based on the selected case
		ls_case		=	gv_active_case
		iv_rand_samp.case_id	=	Left(gv_active_case, 10)
		iv_rand_samp.case_spl	=	Mid (gv_active_case, 11, 2)
		iv_rand_samp.case_ver	=	Mid (gv_active_case, 13, 2)				
	ELSE
		// The case is valid
		lb_found		=	TRUE
		Exit
	END IF
LOOP

Return	1

end function

public subroutine wf_get_active_case ();//************************************************************************
//		Object Type:	Window Function
//		Object Name:	w_random_sampling_selection::wf_get_active_case
//
//		Description:	This routine is triggered by the wf_compare_case_id
//							when the subset is associated with an invalid case.
//
//		Returns:			None
//		Arguments:		None
//
//************************************************************************
//
//04/14/2000 Gary Rubalsky STARS 4.5 TS1741c - Subset Random Sample
//
//************************************************************************

String		ls_active_case

// save the original active case to determine if it changed
ls_active_case	=	gv_active_case

gv_from			=	'AC'
gv_result		=	0

Open( w_case_list_response )

// Close any related windows with the old active case
IF	gv_active_case	<>	ls_active_case		THEN
	// Active case changed
	IF	IsValid (w_case_folder_view)		THEN
		Close (w_case_folder_view)
	END IF
	IF	IsValid (w_case_maint)		THEN
		Close (w_case_maint)
	END IF
	IF	IsValid (w_target_list)		THEN
		Close (w_target_list)
	END IF
	IF	IsValid (w_target_maintain)		THEN
		Close (w_target_maintain)
	END IF
	IF	IsValid (w_target_subset_maintain)		THEN
		Close (w_target_subset_maintain)
	END IF
END IF

end subroutine

public function integer wf_verify_case_id (string as_case_id);//************************************************************************
//		Object Type:	Window Function
//		Object Name:	w_random_sampling_selection::wf_verify_case_id
//
//		Description:	Verifies the validity of the case.
//
//		Returns:			Integer
//		Arguments:		String( as_case_id )
//
//************************************************************************
//
//04/14/2000 Gary Rubalsky STARS 4.5 TS1741c - Subset Random Sample
// 12/21/01	FDG	Track 2497.	Prevent memory leaks
//
//************************************************************************

Integer		li_rc
String		ls_case_id,	ls_case_spl, ls_case_ver, ls_msg
n_cst_case	lnv_case

//Initialize locals
ls_case_id	=	Left( as_case_id, 10 )
ls_case_spl =	Mid( as_case_id, 11, 2 )
ls_case_ver =	Mid( as_case_id, 13, 2 )
lnv_case	= CREATE n_cst_case

// Validate Case
li_rc		=	lnv_case.uf_valid_case (ls_case_id, ls_case_spl, ls_case_ver )

CHOOSE CASE li_rc
	CASE 0
		ls_msg	=	lnv_case.uf_edit_case_security( ls_case_id, ls_case_spl,	ls_case_ver )
		
		IF Len( ls_msg ) > 0	THEN
			MessageBox( "Security Error", ls_msg )
			IF	IsValid( lnv_case ) THEN DESTROY lnv_case		// FDG 12/21/01
			li_rc = -1
		END IF
	CASE -1
		MessageBox( 'Error', 'Case '	+	as_case_id	+	' not found. Select another case' )
	CASE -2
		MessageBox( 'Error', 'Case '	+	as_case_id	+	' has been deleted. Select another case' )
	CASE -3
		MessageBox( 'Error', 'Case '	+	as_case_id	+	' has been closed. Select another case' )
	CASE -4
		MessageBox( 'Error', 'Error verifying case ID.' )
END CHOOSE

IF	IsValid( lnv_case ) THEN DESTROY lnv_case

RETURN li_rc

end function

public function boolean get_pin_upin ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_random_sampling_selection.get_pin_upin
//		Event Name:		N/A
//
//   This function counts the number of Providers in the Subsets
//   Selected by the User.
//   If the Subsets selected contain data for 1, only 1, provider 
//   the structure variable "iv_rand_samp.prov" is set to the 
//   Providers PIN or UPIN (PIN or UPIN depending on the users
//   selection)
//   This function returns FALSE if an error occurs
//
//************************************************************************
//
//	10-06-95 FNC	Take rowcount out of loop
//	03-12-96 FNC	Check to see if UPIN is EXEMPT, NEW or spaces
//	12-05-96 FNC	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
//	01/26/98 JGG	STARS 4.0 TS145 - Subset Redesign changes
//	11/01/01 FDG	Track 2494d.  If multiple subsets are selected, then
//						UNION the Selects to remove duplicate rows.
//	03/18/02	GaryR	Track 2843d	Allow Random Sampling skipping invalid UPINs.
//	03/22/02	GaryR	Track 2870d	Eliminate duplicate UPINs.
//	02/19/03	GaryR	Track 2944d	Do not do special processing for one UPIN.
//	03/07/03	GaryR	Track 3453d	Fix selected subsets list.
//	06/24/03	GaryR	Track 2944d	Change message not to count the invalid UPINs
//	02/09/07 Katie		SPR 4754 Handle NPI as prov_col_name and evaluate to see if the 
//							NPIs are blank
//	04/22/08	GaryR	SPR 5103	Resolve dup providers and centralize logic
//
//************************************************************************

Integer							li_idx
Integer							li_rc
Integer							li_rowcount
Integer							li_subsets	= 0
									
Long								ll_invalid_keys
Long								ll_unique_keys

String							ls_link_key
String							ls_link_name
String							ls_sql
String							ls_insert_sql					// FDG 11/01/01
String							ls_table_name
String							ls_unique_cnt_table
String							ls_subset_list
String							ls_pit_label
u_nvo_count						lnv_count

//	Default PROV NAME column and table
iv_rand_samp.prov_name_tbl = "PROVIDERS"
iv_rand_samp.prov_name_col_name = "PROV_NAME"

// Get the UPIN column name for this table type from the win parm table
If il_pit_selected = 2 Then
	SELECT A_DFLT 
	INTO   :iv_rand_samp.prov_col_name
	FROM   STARS_WIN_PARM
	WHERE  WIN_ID  = 'W_RANDOM_SAMPLING_SELECTION' 
	AND    TBL_TYPE = Upper( :iv_rand_samp.table_id )
	USING  stars2ca;
	
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error retrieving upin col name. Problem with STARS.WIN.PARM')
		RETURN FALSE
	End if
	
	//	If PROV_ID, then use it because it is larger in data type then UPIN
	IF iv_rand_samp.prov_col_name = "PROV_ID" THEN
		iv_rand_samp.prov_orig_name = iv_rand_samp.prov_col_name
	ELSE
		iv_rand_samp.prov_orig_name = "PROV_UPIN"
	END IF
Elseif il_pit_selected = 3 and gv_npi_cntl > 0 then
	iv_rand_samp.prov_col_name = 'PROV_NPI'
	iv_rand_samp.prov_name_tbl = "PROV_NPI_XREF"
	iv_rand_samp.prov_name_col_name = "PROV_NPI_NAME"
	iv_rand_samp.prov_orig_name = iv_rand_samp.prov_col_name
Else
	iv_rand_samp.prov_col_name = 'PROV_ID'
	iv_rand_samp.prov_orig_name = iv_rand_samp.prov_col_name
End if

ls_pit_label = ddlb_pit.text

// Build a temporary table and save its name by invoking a window function.
li_rc	=	wf_build_temp_table()

If li_rc < 1 Then	RETURN FALSE

// Since each subset is now its own table, the way we get the number of
// distinct keys has to be changed.  The old way was to select the distinct
// count, then values from the one table.  The new way is to build a union 
// statement selecting the distinct column values from all the selected 
// subset tables and store the values in the previously built temporary
// table.  Then select the count of distinct values from the temporary table.

// Initialize the number of selected subsets
li_subsets			=	0

// Set up the maximum number of times to loop
li_rowcount			=	dw_1.RowCount()

// Now get all selected subsets within the datawindow 
// and append to the SQL statement.

// Also create a list of the selected subset ids, separated by commas
// and store the list in the random sample structure.  This list is used
// later on by other random sampling windows.

// li_idx points to the row in the datawindow

For li_idx = 1 To li_rowcount
	
	// Test for a selected subset
	If dw_1.IsSelected(li_idx) Then
		
		// Initialize the SQL statement to insert the key values into the 
		// temporary table
		// FDG 11/01/01 - Save the insert port separately
		ls_insert_sql		=	"INSERT INTO "										+	&
									iv_rand_samp.unique_cnt_temp_table_name	+	&
									" "
							
		// Increment count of selected subsets
		li_subsets++
		
		// Get the subset key (10 byte internal name stored in LINK_KEY)
		// from the datawindow
		ls_link_key		=	dw_1.GetItemString(li_idx, "LINK_KEY")
		
		// Get the subset name (20 byte external name stored in LINK_NAME)
		// from the datawindow
		ls_link_name	=	dw_1.GetItemString(li_idx, "LINK_NAME")
		
		// Build the subset table name using global function
		ls_table_name	=	fx_build_subset_table_name(iv_rand_samp.table_id, &
																	ls_link_key)
																	
		// If a join has been defined in STARS_WIN_PARM, 
		//	build the join to subset table name.
		If iv_rand_samp.sJoinTableType > " " Then
			iv_rand_samp.sJoinSubsetName[li_subsets]	=	fx_build_subset_table_name			&
																			(iv_rand_samp.sJoinTableType,	&
																			ls_link_key)
		End if
		
		// Store info in the random sample structure
		iv_rand_samp.case_subset_id[li_subsets]		=	ls_link_key
		iv_rand_samp.case_subset_name[li_subsets]		=	ls_link_name
		iv_rand_samp.subset_table_name[li_subsets]	=	ls_table_name
		ls_subset_list 										+=	"," + ls_link_key
		iv_rand_samp.subsets_selected						=	li_subsets
		
		// FDG 11/01/01 - If more than one subset is selected, append a "UNION" clause
		IF	li_subsets	>	1		THEN
			ls_sql		=	ls_sql	+	" UNION "
		END IF
		// FDG 11/01/01 end
		
		// Append to the SQL statement.  The column to sample by is always the first column.
		ls_sql += "SELECT A." + iv_rand_samp.prov_col_name + ", "
		
		//	 The second column is the prov name. Decode to blank if null
		ls_sql += "Coalesce(Max(B." + iv_rand_samp.prov_name_col_name + "), ' ') "
		
		// If random sampling by upin, select the provider id from the subset tables into  
		// the second column in the temporary table.  When the join against the temporary
		// table and the provider table takes place, it is always by prov id.
		ls_sql += "FROM " + iv_rand_samp.subset_table_name[li_subsets] + " A "
		
		//	Create an LOJ on the appropriate table to decode the provider identifier
		ls_sql += "LEFT OUTER JOIN " + iv_rand_samp.prov_name_tbl + " B " + &
					"ON A." + iv_rand_samp.prov_col_name + " = B." + iv_rand_samp.prov_orig_name
						
		//	Finally add a group by to only get unique providers
		ls_sql += " GROUP BY A." + iv_rand_samp.prov_col_name + " "
	End if
Next

iv_rand_samp.selected_subset_list =	Mid( ls_subset_list, 2 )

// FDG 11/01/01 - Execute this once outside of the loop
IF	li_subsets	>	0		THEN
	ls_sql		=	ls_insert_sql	+	ls_sql
	IF	gc_debug_mode	=	TRUE		THEN
		f_debug_box("Debug", " ")
		f_debug_box("Debug", "SQL To Load Unique PIN, UPIN, or NPIs into temp table: "	+ ls_sql)
		f_debug_box("Debug", " ")
	END IF
	li_rc			=	Stars2ca.of_execute(ls_sql)
	If li_rc <> 0 Then
		Errorbox(stars2ca,'Unable to load ' + iv_rand_samp.prov_col_name  + ' in selected subsets')
		RETURN FALSE
	End If
END IF
// FDG 11/01/01 end

// So far so good.  Now count the number of unique keys in the temp table
lnv_count = Create u_nvo_count
ls_sql		=	"SELECT COUNT(*) FROM "				+	&
					iv_rand_samp.unique_cnt_temp_table_name	

if gc_debug_mode = TRUE then
	f_debug_box("Debug", " ")
	f_debug_box("Debug", "SQL To Count Unique PIN, UPIN, or NPIs in temp table: "	+ ls_sql)
	f_debug_box("Debug", " ")
end if

ll_unique_keys = lnv_count.uf_get_count( ls_sql )

// Now check the status of the SQL call
If stars2ca.of_check_status() <> 0 Then
	Errorbox(stars2ca,'Unable to count unique keys in selected subsets')
	Destroy lnv_count
	RETURN FALSE
End If

CHOOSE CASE ll_unique_keys 
	CASE IS < 1 
		// No unique values, so we can't perform random sampling
		Messagebox("Random Sampling Error","The data selected contains no PINs, UPIN or NPIs")

		If stars2ca.of_commit() <> 0 Then
			Messagebox('EDIT','Error Commiting to Stars2')
		End If
		
		Destroy lnv_count
		RETURN FALSE
		
	CASE ELSE
		iv_rand_samp.prov		=	""
		
		If (il_pit_selected = 2 or il_pit_selected = 3) Then
			ls_sql		=	" SELECT COUNT(*) FROM "							&
							+	iv_rand_samp.unique_cnt_temp_table_name		&
							+	" WHERE "												&
							+	iv_rand_samp.prov_orig_name						&
							+	" in ('EXEMPT','NEW',' ')"

			if gc_debug_mode = TRUE then
				f_debug_box("Debug", " ")
				f_debug_box("Debug", "SQL To Count invalid " + ls_pit_label + "s in temp table: "	+ ls_sql)
				f_debug_box("Debug", " ")
			end if
			
			ll_invalid_keys = lnv_count.uf_get_count( ls_sql )

			If stars2ca.of_check_status() <> 0 Then
				Errorbox(stars2ca,'Unable to count unique keys in selected subsets')
				Destroy lnv_count
				RETURN FALSE
			End If
		
			//	03/18/02	GaryR	Track 2843d - Begin			
			//	Allow Random Sampling on the valid UPINs
			If ll_invalid_keys > 0 THEN
				IF ll_invalid_keys = ll_unique_keys THEN
					MessageBox('Random Sampling','Cannot run random sampling because all ' + ls_pit_label + 's contain SPACES/EXEMPT/NEW.')
					Stars2ca.of_commit()
					Destroy lnv_count
					RETURN FALSE
				ELSE
					IF MessageBox( "Random Sampling", "Some of the " + ls_pit_label + "s contain invalid values (SPACES/EXEMPT/NEW)" + &
										"~n~rWould you like to exclude the invalid " + ls_pit_label + "s and continue with Random Sampling?", Exclamation!, YesNoCancel! ) <> 1 THEN
						Stars2ca.of_commit()
						Destroy lnv_count
						RETURN FALSE
					END IF
					
					ls_sql =	" DELETE FROM "							&
							+	iv_rand_samp.unique_cnt_temp_table_name		&
							+	" WHERE "												&
							+	iv_rand_samp.prov_orig_name							&
							+	" in ('EXEMPT','NEW',' ')"
							
					IF	gc_debug_mode	=	TRUE		THEN
						f_debug_box("Debug", " ")
						f_debug_box("Debug", "SQL To delete invalid " + ls_pit_label + "s from temp table: "	+ ls_sql)
						f_debug_box("Debug", " ")
					END IF
					
					li_rc			=	Stars2ca.of_execute(ls_sql)
					If li_rc <> 0 Then
						Errorbox(stars2ca,'Unable to delete invalid ' + ls_pit_label + 's from temp table')
						Stars2ca.of_commit()
						Destroy lnv_count
						RETURN FALSE
					End If
				END IF
			End If
			//	03/18/02	GaryR	Track 2843d - End
			
		End if
							
End Choose

Destroy lnv_count

// Everything worked successfully, so return a good status code
Stars2ca.of_commit();
RETURN TRUE
end function

public function integer wf_build_temp_table ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_random_sampling_selection.wf_build_temp_table
//		Event Name:		N/A
//
//		This function builds a temporary table using the temp table NVO.
//		Returns:			Integer	(1 = Successful, 0 = Unsuccessful)
//
//************************************************************************
//
//	JGG	01/26/98		STARS 4.0 TS145 - Subset Redesign changes
//	FDG	06/26/00		Track 2934c. Get data type from dictionary instead of
//							hard-coding it.
//	FDG	03/20/01		Stars 4.7.  Pass the invoice type when creating a temp table.
//	GaryR	03/22/02		Track 2870d	Eliminate duplicate UPINs.
// MikeF 10/19/04 	SPR 3650d	Replaced local n_cst_dict with global
//	GaryR	04/22/08		SPR 5103	Resolve dup providers and centralize logic
//
//************************************************************************

Integer							li_rc
String							ls_data_type, ls_inv_type
n_cst_temp_table_attrib		lnv_init_structure
									
// Initialize the structure in case this is not the first time the user
// selects to random sample after the selection window is opened.

inv_temp_attrib			=	lnv_init_structure

// Build a temporary table and save its name.
// Define provider identifier column
ls_data_type	=	gnv_dict.Event	ue_get_data_type (iv_rand_samp.table_id, 		&
																			iv_rand_samp.prov_col_name)		// FDG 06/26/00
inv_temp_attrib.istr_cols[1].is_col_name				=	iv_rand_samp.prov_orig_name
inv_temp_attrib.istr_cols[1].is_data_type				=	ls_data_type								// FDG 06/26/00
inv_temp_attrib.istr_index_cols[1].is_index_col[1]	=	iv_rand_samp.prov_orig_name
inv_temp_attrib.istr_index_cols[1].is_index_type	=	'I'

//	Define provider name column
ls_inv_type = gnv_dict.Event ue_get_inv_type( iv_rand_samp.prov_name_tbl )
ls_data_type	=	gnv_dict.Event	ue_get_data_type ( ls_inv_type, &
																			iv_rand_samp.prov_name_col_name )
inv_temp_attrib.istr_cols[2].is_col_name				=	iv_rand_samp.prov_name_col_name
inv_temp_attrib.istr_cols[2].is_data_type				=	ls_data_type								// FDG 06/26/00

inv_temp_attrib.is_function								=	'CREATE'
inv_temp_attrib.is_inv_type								=	ls_inv_type
inv_temp_attrib.ii_request									=	inv_temp_attrib.ici_temp_table			// FDG 03/20/01

li_rc	=	inv_temp_table.of_execute_sql(inv_temp_attrib)

If li_rc >=	0		Then
	iv_rand_samp.unique_cnt_temp_table_name	=	inv_temp_table.of_get_table_name()

	// Commit the changes made to the database.
	If Stars2ca.of_commit() = 0 Then
		li_rc	=	1
	Else
		errorbox(stars2ca,'Unable to commit after building temp table.')
		li_rc	=	0
	End if
Else
	errorbox(stars2ca,'Error building temporary unique count table.')
	li_rc	=	0
End if

RETURN li_rc
end function

public function boolean delete_from_temp ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_random_sampling_selection.delete_from_temp
//		Event Name:		N/A
//
//************************************************************************
//
// 01/27/98 JGG STARS 4.0 - TS145 changes
//
//09-04-96 FNC Delete any rows left in USER_TEMP_RAND_SAMPLE
//					from previous executions. Used to only delete if an		
//					external file was specified in lb_file_select. Delete
//					all rows for user. Do not specify date time.
// 03-27-96 FNC Change gv_user_id to gc_user_id
//******************************************************************

DELETE from USER_TEMP_RAND_SAMPLE
	where USER_ID = Upper( :gc_user_id ) 						//09-04-96 FNC
	using stars2ca;
	
If stars2ca.of_check_status() < 0  then
	Errorbox(stars2ca,'Error deleting rows from temp table (USER_TEMP_RAND_SAMPLE)')
	return(FALSE)
End If

Commit using stars2ca;

Return(TRUE)


end function

event open;call super::open;//************************************************************************
//		Object Type:	Window 
//		Object Name:	w_random_sampling_selection
//		Event Name:		Open
//
//
//************************************************************************
//
// FNC	10/06/95	Take upperbound out of loop.
//
//	FDG	11/10/95	Rename the subset table (thru fx_open_server_table)
//						to account for open server.
//
// DKG	12/14/95	Access dictionary (elem_type = 'TB') thru
//						w_main.dw_stars_rel_dict.
//
// FNC	03/20/96	Vary the iv_correct_format according to invoice type
//
// FNC	12/05/96	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
//
// JGG	01/26/98	STARS 4.0 TS145 Subset Redesign changes
// ajs	03/11/98	4.0 TS145-fix globals
// ajs	01/13/99	FS1876 4.1 Allow to random sample on ML subset
//	gr		04/14/00	Ts1741c 4.5 Moved some code to ue_preopen 
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	GaryR	09/23/03	Track 2592d	Select the subset that entered from
//	Katie	02/09/07	SPR 4754 Populate ddlb_pit with the appropriate labels for the Subset's 
//				invoice type.
//************************************************************************

String			ls_table_name	
String 			ls_subset_id, ls_table_id		//ajs 01-13-99
String 		ls_pin_label

Integer			li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Loading Random Sampling Window')

ls_table_name 					=	fx_get_stars_rel_elem_name (IV_rand_samp.TABLE_ID)

IF ls_table_name = '' THEN
   messagebox("RANDOM SAMPLING PROGRAM ERROR",	&
				  "Error determining table to use for sampling analysis.  Table type " + &
				  IV_rand_samp.TABLE_ID + " not found in dictionary")
 	cb_close.PostEvent(Clicked!)
	RETURN
END IF

if wf_GetJoinTables () < 1 then
  	cb_close.PostEvent(Clicked!)
	return
end if

if gc_debug_mode then
	messagebox("Table Type to use ",ls_table_name)
end if

//						If a join condition was defined, display and enable the
//						revenue checkbox.

If iv_rand_samp.sjointabletype > "" Then
	cbx_revenue.Visible 		= 	TRUE
	cbx_revenue.Enabled		=	TRUE
Else
	cbx_revenue.Visible 		= 	FALSE
	cbx_revenue.Enabled		=	FALSE
End if
	
cbx_revenue.Checked			=	FALSE
iv_rand_samp.bJoinActive	=	FALSE

dw_1.reset()
If settransobject(dw_1,Stars2ca) < 0 then	
	COMMIT using STARS2CA;
	
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If
	
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_close.default = true
	RETURN
End If

//ajs 01-13-99 begin
if is_ml_subset_id > ' ' then
	ls_subset_id = is_ml_subset_id + '%'
	ls_table_id = 'ML'
else
	ls_subset_id = '%'
	ls_table_id = iv_rand_samp.table_id
end if

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
iv_rand_samp.case_id	=	Trim (iv_rand_samp.case_id)
li_rc	=	gnv_sql.of_TrimData (iv_rand_samp.case_spl)
li_rc	=	gnv_sql.of_TrimData (iv_rand_samp.case_ver)
// FDG 04/16/01 - end

st_row_count.text = string(dw_1.Retrieve(iv_rand_samp.case_id,		&
													  iv_rand_samp.case_spl,	&
													  iv_rand_samp.case_ver,	&
													  ls_table_id,	&
													  ls_subset_id))			//ajs 01-13-99 end

COMMIT using STARS2CA;

If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
   
CHOOSE CASE long(st_row_count.text)
	CASE IS < 0 
	   Messagebox('EDIT','Error Retrieving Data from Case Subset Control')
	   RETURN
	CASE 0 
	   setmicrohelp(w_main,'No ' + iv_rand_samp.table_id + ' Subsets Have Been Linked To This Case')
		cb_create.enabled = FALSE
	CASE IS > 0 
		SETMICROHELP("Ready")
		selectrow(dw_1,0,FALSE)   // deselect default 1st row
	   cb_create.enabled = TRUE
		
		li_rc = dw_1.find( "link_name = '" + gc_active_subset_name + "'", 0, dw_1.RowCount() )
		IF li_rc	 > 0 THEN
			dw_1.SetRow( li_rc )
			dw_1.ScrollToRow( li_rc )
			dw_1.SelectRow( li_rc, TRUE )
			st_subsets_selected.text = '1'
		ELSE
			st_subsets_selected.text = '0'
		END IF
		
END CHOOSE

// Populate drop-down list
ls_pin_label = gnv_dict.event ue_get_elem_label(IV_rand_samp.TABLE_ID, "PROV_ID")
if pos (ls_pin_label,"~~r") > 0 then
	ls_pin_label 		=	fx_convert_label(ls_pin_label)		
End if
ddlb_pit.InsertItem(ls_pin_label,1)
ls_pin_label = gnv_dict.event ue_get_elem_label(IV_rand_samp.TABLE_ID, "PROV_UPIN")
if pos (ls_pin_label,"~~r") > 0 then
	ls_pin_label 		=	fx_convert_label(ls_pin_label)		
End if
ddlb_pit.InsertItem(ls_pin_label,2)
if gv_npi_cntl > 0 then 
	ls_pin_label = gnv_dict.event ue_get_elem_label(IV_rand_samp.TABLE_ID, "PROV_NPI")
	if pos (ls_pin_label,"~~r") > 0 then
		ls_pin_label 		=	fx_convert_label(ls_pin_label)		
	End if
	ddlb_pit.InsertItem(ls_pin_label,3)
end if

// Create an instance of the temp table non visual object.

This.of_set_temp_table(TRUE)
end event

on w_random_sampling_selection.create
int iCurrent
call super::create
this.st_3=create st_3
this.ddlb_pit=create ddlb_pit
this.st_subsets_selected=create st_subsets_selected
this.st_row_count=create st_row_count
this.st_2=create st_2
this.st_1=create st_1
this.sle_case_id=create sle_case_id
this.st_case_id=create st_case_id
this.cb_create=create cb_create
this.cb_close=create cb_close
this.dw_1=create dw_1
this.cbx_revenue=create cbx_revenue
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.ddlb_pit
this.Control[iCurrent+3]=this.st_subsets_selected
this.Control[iCurrent+4]=this.st_row_count
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_case_id
this.Control[iCurrent+8]=this.st_case_id
this.Control[iCurrent+9]=this.cb_create
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cbx_revenue
end on

on w_random_sampling_selection.destroy
call super::destroy
destroy(this.st_3)
destroy(this.ddlb_pit)
destroy(this.st_subsets_selected)
destroy(this.st_row_count)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_case_id)
destroy(this.st_case_id)
destroy(this.cb_create)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.cbx_revenue)
end on

event ue_preopen();///////////////////////////////////////////////////////////////////////////////////////////////
// Window:		w_random_sampling_selection
//	Event:		Window Preopen 
//
///////////////////////////////////////////////////////////////////////////////////////////////
// Maintenance Log:
//
// Date:      By:    Description
// --------   ----   ----------------------------------------------------------
// 01/26/98    JGG   STARS 4.0 TS145
// 04/14/00		GR		TS1741c 4.5	
//	03/05/02		FDG	Track 2855d.  Some databases have user_temp_rand_sample.temp_datetime
//							defined as smalldatetime.  Must trim seconds from the date to
//							accomodate this.
//
///////////////////////////////////////////////////////////////////////////////////////////////

// Local variables
Integer						li_rc
Long							ll_row
String						ls_sel
Sx_Rand_Samp_Selection 	lsx_rand_samp_selection								 //ajs 01-13-99

// Initialize instance variables using arguments passed into window.
// Table_id is the invoice type selected by the user.
//ajs 01-13-99 begin
//iv_rand_samp.table_id = message.stringparm
lsx_rand_samp_selection = Message.PowerObjectParm
iv_rand_samp.table_id = lsx_rand_samp_selection.invoice_type

if len(iv_rand_samp.table_id) < 2 then
	messagebox("PROGRAM ERROR","Parm sent to w_random_sampling_selection is invalid")
	return
end if

/******* GR Begin TS1741 ************/
iv_rand_samp.temp_datetime = gnv_app.of_get_server_date_time() //ts2020c use server date

//	03/05/02 FDG Track 2855d - Trim seconds to accomodate smalldatetime
String	ls_temp_date, ls_temp_time
DateTime	ldt_temp_date

ls_temp_date = String( iv_rand_samp.temp_datetime, 'mm/dd/yyyy' )
ls_temp_time = String( iv_rand_samp.temp_datetime, 'hh:mm' )
ldt_temp_date = DateTime( Date( ls_temp_date ), Time( ls_temp_time ) )
iv_rand_samp.temp_datetime	=	ldt_temp_date
// FDG 03/05/02 end

is_ml_subset_id = lsx_rand_samp_selection.subc_id

// If case data is not passed via the structure
// then populate variables from globals
IF Trim( lsx_rand_samp_selection.case_id ) = "" OR IsNull( lsx_rand_samp_selection.case_id ) THEN
	iv_rand_samp.case_id			= 	left(gv_active_case,10) 	//ajs 4.0 03-11-98 fix globals
	iv_rand_samp.case_spl 		= 	mid(gv_active_case,11,2)	//ajs 4.0 03-11-98 fix globals
	iv_rand_samp.case_ver 		= 	mid(gv_active_case,13,2)	//ajs 4.0 03-11-98 fix globals
ELSE
	iv_rand_samp.case_id = lsx_rand_samp_selection.case_id
	iv_rand_samp.case_spl = lsx_rand_samp_selection.case_spl
	iv_rand_samp.case_ver = lsx_rand_samp_selection.case_ver
END IF

//sle_case_id.text = gv_active_case					//ajs 4.0 03-11-98 fix globals
sle_case_id.text = iv_rand_samp.case_id + iv_rand_samp.case_spl + iv_rand_samp.case_ver	//gr 4.5 04/14/2000 ts1741c

//is_ml_case_id = lsx_rand_samp_selection.case_id
//is_ml_case_spl = lsx_rand_samp_selection.case_spl
//is_ml_case_ver = lsx_rand_samp_selection.case_ver
//ajs 01-13-99 case_id, case_spl, case_ver are not used at this time
//placed them in structure in case we want to random sample from subset list.
//ajs 01-13-99
/******* GR END TS1741 ************/

SetNull(message.stringparm)

// Determine the base type for this invoice type.

ll_row		=	fx_filter_stars_rel_1( 'QT',				&
													gv_sys_dflt,	&
													iv_rand_samp.table_id )
												
If ll_row 	= 	-1 Then
	Errorbox(Stars2ca, 'Error determining base type from STARS Rel table.')
	RETURN
End if

if ll_row	<>	0 Then
	iv_rand_samp.base_type	=	w_main.dw_stars_rel_dict.GetItemString(1, "KEY6")
End if

// JGG 01/26/98 - end


end event

event close;call super::close;// Close the window
//
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		--------------------------------------------
//	JGG	03/04/98		STARS 4.0 - Random Sampling Selection changes

setpointer(hourglass!)

// Only delete temp table if user is not still processing another
// random sampling window
If  (not IsValid(w_random_sampling_claims) ) &
And (not IsValid(w_random_sampling_unique_hics)) then
	delete_from_temp()
End if

setmicrohelp(w_main,'Ready')
end event

type st_3 from statictext within w_random_sampling_selection
string accessiblename = "Sample By"
string accessibledescription = "Sample By"
accessiblerole accessiblerole = statictextrole!
integer x = 1024
integer y = 48
integer width = 357
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Sample By:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_pit from dropdownlistbox within w_random_sampling_selection
string accessiblename = "Sample By"
string accessibledescription = "Sample By"
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 1390
integer y = 36
integer width = 549
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Katie SPR 4754 Store the index of the PIT selected in ddlb_pit
il_pit_selected = index
end event

type st_subsets_selected from statictext within w_random_sampling_selection
string accessiblename = "Subsets Selected"
string accessibledescription = "Subsets Selected"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 1381
integer y = 1812
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 700
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

type st_row_count from statictext within w_random_sampling_selection
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 466
integer y = 1812
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 700
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

type st_2 from statictext within w_random_sampling_selection
string accessiblename = "Subsets Selected"
string accessibledescription = "Subsets Selected"
accessiblerole accessiblerole = statictextrole!
integer x = 805
integer y = 1816
integer width = 549
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subsets Selected:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_random_sampling_selection
string accessiblename = "Total Subsets"
string accessibledescription = "Total Subsets"
accessiblerole accessiblerole = statictextrole!
integer x = 5
integer y = 1816
integer width = 439
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Total Subsets:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_case_id from singlelineedit within w_random_sampling_selection
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = textrole!
integer x = 320
integer y = 36
integer width = 667
integer height = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
integer limit = 14
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_case_id from statictext within w_random_sampling_selection
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 48
integer width = 265
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Case ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_create from u_cb within w_random_sampling_selection
string accessiblename = "Create"
string accessibledescription = "Create..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2153
integer y = 1800
integer width = 338
integer height = 108
integer taborder = 20
string text = "Cr&eate..."
boolean default = true
end type

event clicked;// Script for create button on Random Sample Selection

//*********************************************************
//09-04-96 FNC Delete any rows left in USER_TEMP_RAND_SAMPLE
//					from previous executions. Used to only delete if an		
//					external file was specified in lb_file_select.
//10-06-95 FNC Take rowcount out of loop
//
// 01/26/98 JGG 	STARS 4.0 - TS145 Changes
// 07/10/98 JGG 	Place link name in iv_rand_samp.file_list 
//              	for med report note.
//	03/08/02	FDG	Track 2494d.  Since only one subset can be
//						selected, change text of error message.
//	02/09/07 Katie	SPR 4754 Changed references to rb_pin and rb_upin 
//						to use the new ddlb_pit
//	04/22/08	GaryR	SPR 5103	Resolve dup providers and centralize logic
//
//*********************************************************

Boolean		lb_subsets_selected

iv_Rand_Samp.SubSets_Selected = 	0
iv_rand_samp.temp_subc_id 		= 	""

lb_subsets_selected = False

SetMicrohelp(w_main,"Processing Subset Selections")

// EDIT DATA ENTERED
if dw_1.GetSelectedRow(0) = 0 then
	lb_subsets_selected = False
else
	lb_subsets_selected = True
end if 	

if  (trim(ddlb_pit.text) = "") then
	MessageBox("Random Sampling Error","Please select field to Sample By")
	return
end if

If lb_subsets_selected then
	If parent.get_pin_upin() = FALSE Then
		RETURN
	End if
Else
	MessageBox("Random Sampling Error","You must select a subset in order to continue.")	// FDG 03/08/02
	RETURN
End if

If not delete_from_temp() Then 
	RETURN			
End if

if il_pit_selected = 1 then
	iv_rand_samp.pin_ind = "P"
elseif il_pit_selected = 2 then
	iv_rand_samp.pin_ind = "U"
elseif il_pit_selected = 3 then
	iv_rand_samp.pin_ind = "N"	
else 
	MessageBox("Random Sampling Error","Invalid Provider Identifier Type")
	return
end if
iv_rand_samp.pit_label = ddlb_pit.text

iv_rand_samp.mode = "RANDSAMP"

// close old occurances of later windows if open

If isvalid(w_random_sampling_claims) Then
	close(w_random_sampling_claims)
End if

If isvalid(w_random_sampling_unique_hics) Then
	close(w_random_sampling_unique_hics)
End if

setmicrohelp(w_main,'Ready')
OpenSheetWithParm(w_random_sampling_unique_hics,iv_rand_samp,MDI_Main_Frame,Help_Menu_Position,Layered!)
end event

type cb_close from u_cb within w_random_sampling_selection
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2491
integer y = 1800
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Close"
boolean cancel = true
end type

event clicked;// Trigger the close window event script.
// All logic should be placed within that script, not this one
close(parent)
end event

type dw_1 from u_dw within w_random_sampling_selection
string accessiblename = "Random Sampling Selection List"
string accessibledescription = "Random Sampling Selection List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Subset List"
integer x = 9
integer y = 156
integer width = 2821
integer height = 1632
integer taborder = 10
string dataobject = "d_random_sampling_sel_subsets"
boolean vscrollbar = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
//
//	Clicked for data window 1
//
//////////////////////////////////////////////////////////////////////
//
//	02/11/02	GaryR	Track 2802d	For v5.0 disable multiple row selection
//	03/22/02	GaryR	Track 2802d	For v5.1 enable muliple row selection
//	06/19/02	GaryR	Track 2934d	For v5.1 disable multiple row selection
//	12/24/02	GaryR	Track 2934d	For v5.2	Fixed multilpe subset logic
//										Allow selection of multiple rows
//
//////////////////////////////////////////////////////////////////////

int row_nbr

/*gets the row and makes sure a row was clicked*/
row_nbr = row
If row_nbr = 0 then
	return
end if

if dw_1.IsSelected(row_nbr) then
	SelectRow(dw_1,row_nbr,FALSE)
	st_subsets_selected.text = string(long(st_subsets_selected.text) - 1)
else
	SelectRow(dw_1,row_nbr,TRUE)
	st_subsets_selected.text = string(long(st_subsets_selected.text) + 1)
end if
end event

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

type cbx_revenue from checkbox within w_random_sampling_selection
boolean visible = false
string accessiblename = "Include Revenue"
string accessibledescription = "Include Revenue"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 2011
integer y = 36
integer width = 594
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Include Revenue"
end type

event clicked;// The include revenue check box is initially invisible.  The window preopen
// event gets the base type of the invoice type (iv_rand_samp.table_id) passed
// into the window.  If the base type is UB92 - Facility, this check box is
// enabled and made visible.
//
// If the user clicks the check box, random sampling has to be performed 
// against the Hospital subset tables joined to the Revenue subset tables.
//
// The clicked event sets the instance variable to indicate that the status
// of the check box.
//
// Maintenance Log:
//
//   Date    By    Description
// --------  ----  -----------------------------------------------------------
// 01/28/98  JGG   Created check box and script
//
//

If cbx_revenue.Checked = TRUE Then
	iv_rand_samp.bJoinActive	=	TRUE
Else
	iv_rand_samp.bJoinActive	=	FALSE
End if

// If check box clicked, test for a Random Sampling JOIN row in STARS_WIN_PARM

If iv_rand_samp.bJoinActive = TRUE Then
	If wf_GetJoinTables() < 1 Then
  		cb_close.PostEvent(Clicked!)
		RETURN
	End if
End if



end event

