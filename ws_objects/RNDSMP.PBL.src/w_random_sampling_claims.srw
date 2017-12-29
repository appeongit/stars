$PBExportHeader$w_random_sampling_claims.srw
$PBExportComments$List of randomly selected claims (inherited from w_dw_viewer)
forward
global type w_random_sampling_claims from w_dw_viewer
end type
type cb_project_op from u_cb within w_random_sampling_claims
end type
type rb_allowed_amt from radiobutton within w_random_sampling_claims
end type
type rb_paid_amt from radiobutton within w_random_sampling_claims
end type
type gb_icn from groupbox within w_random_sampling_claims
end type
type gb_project_on from groupbox within w_random_sampling_claims
end type
type cb_create_med_recs_list from u_cb within w_random_sampling_claims
end type
type st_1 from statictext within w_random_sampling_claims
end type
type st_icn from statictext within w_random_sampling_claims
end type
type cb_icn from u_cb within w_random_sampling_claims
end type
type gb_2 from groupbox within w_random_sampling_claims
end type
type sle_output_file_name from singlelineedit within w_random_sampling_claims
end type
type cb_save_file from u_cb within w_random_sampling_claims
end type
type cb_subset from u_cb within w_random_sampling_claims
end type
end forward

global type w_random_sampling_claims from w_dw_viewer
string accessiblename = "Random Sampling Claim List"
string accessibledescription = "Random Sampling Claim List"
string title = "Random Sampling Claim List"
event ue_reportbuild pbm_custom11
cb_project_op cb_project_op
rb_allowed_amt rb_allowed_amt
rb_paid_amt rb_paid_amt
gb_icn gb_icn
gb_project_on gb_project_on
cb_create_med_recs_list cb_create_med_recs_list
st_1 st_1
st_icn st_icn
cb_icn cb_icn
gb_2 gb_2
sle_output_file_name sle_output_file_name
cb_save_file cb_save_file
cb_subset cb_subset
end type
global w_random_sampling_claims w_random_sampling_claims

type variables
boolean 			iv_notes_added = FALSE
boolean			iv_one_provider = TRUE
boolean 			ib_subset_created

datetime			id_date_key

integer 			ii_num_of_cols
integer			ii_num_of_rows
integer 			ii_num_subsets

n_ds			ids_1

string			is_business_type
string			is_icn_table_name
//string			is_job_id			//	GaryR	03/26/01		Stars 4.7
string			iv_PROV_ID_name

s_rand_samp 		iv_rand_samp
sx_subset_options		istr_subset_options
end variables

forward prototypes
public function integer wf_insert_temp_ccn (string as_ccn_col_name, string as_subset_id)
public function boolean create_op_file_name ()
public function boolean wf_buildhospsel ()
public function boolean wf_buildpharsel ()
public function boolean wf_buildprofsel ()
end prototypes

event ue_reportbuild;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_random_sampling_claims
//		Event Name:		ue_reportbuild
//
// 	If first Parm (usually prov ID = VIEW then we are in from viewer
//
//************************************************************************
//
//	09/22/94	FNC	If provider name not on prov_name table send out
//             	messagebox and continue to process
//	11/16/95	FDG	Access Stars_rel via w_main.dw_stars_rel_dict
//	03/26/96	FNC	Change gv_user_id to gc_user_id
//	05/01/96	FNC	If join is in the ENROLLEE view do not display patient
//                name and birthdate in datawindow. Use code/decode to 
//                obtain patient name.
// 08/28/96	FNC	Remove integer function and replace with long so large
//						numbers can be handled.
// 09/17/96	FNC	Prob #29 STARS35 Set title depending on whether 
//						sample was within providers or across providers
// 11/25/96	FNC	Prob #173 STARS35 move call to fx_set_window_colors
//						to this script from open script. The datawindow color
//						became overlaid when this script set the dataobject
// 12/05/96	FNC	Prob #949 STARS30 Allow random sampling by UPIN for
//						all claim types.
// 11/17/97	FDG	Prob #1 STARS36 If this window is opened for the purpose
//						of viewing a report, then disable the subset button.  
//						Two additional windows are required to be displayed in
//						order to create a subset.
//	02/19/98	JGG	STARS 4.0 - TS145 RandomSampling Claims changes.
//	09/24/01	GaryR	Track 2422d	ASE adds milliseconds to the timestamp.
// 08/27/02	MikeF	Track 3278d Only enable Save and Subset buttons if report returns rows.
// 09/04/02	Jason	Track 3091d Remove 'XF' invoice type from structure array
// 04/01/03	Jason	Track 3091d Fix code to dynamically get tbl type for USER_TEMP_RAND_SAMPLE
//	09/23/03	GaryR	Track 3598d	Post-DCG changes
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
// 10/19/04 MikeF	SPR 3650d	Replaced local n_cst_dict with global
//************************************************************************

// Declare local variables

int					li_index
int 					li_rc

string 				ls_window_name
string				ls_title
string				ls_inv_type	// JasonS 04/01/03
int	ll_array_cnt, ll_array_index, ll_inner_array_index	// JasonS 09/04/02 Track 3091d

SetPointer(Hourglass!)
setmicrohelp(W_MAIN,"Build the Report")

// Populate the report depending on base type

setmicrohelp(W_MAIN,"Build the Report: Creating SQL")

CHOOSE CASE iv_rand_samp.base_type
	CASE 'UB92'
		wf_BuildHospSel()
	CASE '1500'
		wf_buildprofsel()
	CASE 'PHAR' 
		wf_BuildPharSel()
END CHOOSE

// access ini file for default save file names

setmicrohelp(W_MAIN,"Build the Report: Retrieving Overpayment path")

IF FileExists ( gv_ini_path + "STARS.INI" ) THEN
	sle_output_file_name.text 	= 	ProfileString(gv_ini_path 	&
										+ 	"STARS.INI",					&
										+	"RandomSampling",				&
										+	"SaveOverPayPath"," ") 
ELSE
	MessageBox ("Missing STARS.INI", 														&
					"You are missing the STARS.INI file.  "							+	&
					"Random Sampling requires this file." 								+ 	&
               "Please contact your System Administrator for assistance.", 	&
					StopSign! )
END IF

// Create instances of the temp table non visual object and a datastore
// for subsequent use by all scripts

This.of_set_temp_table(TRUE)

ids_1					=	Create n_ds

setmicrohelp(W_MAIN,"Build the Report: Loading Report")

// now load the main datawindow
If settransobject(dw_1,Stars2ca) < 0 then       
   Messagebox('EDIT','Error Setting Transaction Object')
   cb_project_op.enabled = FALSE
   cb_close.default = true
   RETURN
End If

ls_window_name = UPPER(this.classname())
li_rc 			= fx_dw_syntax(ls_window_name,dw_1,in_decode_struct,stars2ca)

If li_rc = -5 Then
	li_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(li_index)
End If

// JasonS 09/04/02 Begin - Track 3091d
ll_array_cnt = Upperbound(in_decode_struct.table_type)
ll_array_index = 1

// JasonS 04/01/03	Begin - Track 3091d
ls_inv_type = gnv_dict.event ue_get_inv_type("USER_TEMP_RAND_SAMPLE")
// JasonS 04/01/03	End	- Track 3091d

do while (ll_array_index <= ll_array_cnt) 
	if in_decode_struct.table_type[ll_array_index] = ls_inv_type then
		ll_inner_array_index = ll_array_index
		do while (ll_inner_array_index <= ll_array_cnt)
			if not ((ll_inner_array_index + 1) > ll_array_cnt) then
				in_decode_struct.table_type[ll_inner_array_index] = in_decode_struct.table_type[ll_inner_array_index + 1]
			else 
				in_decode_struct.table_type[ll_inner_array_index] = ''
			end if
			ll_inner_array_index++
		loop
	else
		ll_array_index++
	end if
loop
// JasonS 09/04/02 End - Track 3091d

// Found that fx_dw_syntax disconnects from stars2ca.  So for now,
// reconnect to stars2ca until fx_dw_syntax can be checked.

setTransObject(dw_1,stars2ca)

setmicrohelp(W_MAIN,"Build the Report: Retrieving Report")

//	GaryR	09/24/01	Track 2422d - Begin
String	ls_date
Date		ldt_date
Time 		ltm_date
Datetime	ldtm_date

ls_date = String( iv_rand_samp.temp_datetime, "mm/dd/yyyy" )
ldt_date = Date( ls_date )
ls_date = String( iv_rand_samp.temp_datetime, "hh:mm:ss" )
ltm_date = Time( ls_date )
ldtm_date = DateTime( ldt_date, ltm_date )

st_count.text = string(dw_1.retrieve(gc_user_id, ldtm_date,iv_rand_samp.pit_label))

commit using stars2ca;

CHOOSE CASE long(st_count.text)
	CASE is > 0 		
		// Report contains data, so we can continue
		st_icn.text = string(dw_1.GetItemNumber(1,"distinct_icn"))
		cb_subset.enabled 					= TRUE
		cb_create_med_recs_list.enabled 	= TRUE
	CASE is < 0 
		// Unexpected error, so terminate
 		This.Event	ue_set_window_colors (This.Control)
      Messagebox('ERROR','Error Retrieving Data from Temp Random Sampling Table')
      cb_project_op.enabled = FALSE
      RETURN
	CASE 0 
		// Report does not contain data, so we cannot continue
		This.Event	ue_set_window_colors (This.Control)
		messagebox("ERROR","Row count is zero")
		cb_project_op.enabled = FALSE
		RETURN
End Choose

if iv_rand_samp.across_provs then
	ls_title = 'Random Sampling Claims List - Across Selection'
else
	ls_title = 'Random Sampling Claims List - Within Selection'
end if

ls_title += " - Case: "	+ 	iv_rand_samp.case_id		&
									+	iv_rand_samp.case_spl	&
									+	iv_rand_samp.case_ver

this.title = ls_title

create_op_file_name()

This.Event	ue_set_window_colors (This.Control)

This.Show ()

setmicrohelp(W_MAIN,"Ready")



end event

public function integer wf_insert_temp_ccn (string as_ccn_col_name, string as_subset_id);//***************************************************************************
//
// This function stores all the ICNs from the random sample report
// into a temporary table.  This is required to build the random sample subset.
// 
// Arguments:	as_ccn_col_name	:	The name of the column containing ICN in
//												the datawindow.
//					as_subset_id		:	The subset id,	the internal 10 byte id.
//
//***************************************************************************
// Maintenance Log:
//	By:	Date:			Description
//	----	--------		--------------------------------------------------------
//	JGG	02/20/98		STARS 4.0 - TS145 Random Sampling Claims changes
//	FDG	01/18/99		Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
//	FDG	03/22/00		Stars 4.5.  For unique key changes, change temp table
//							name from 'ICN_...' to 'KEY_...'.  Change column from
//							'ICN' to 'C1_ICN'.  Also, get ICN declaration from
//							dictionary.
//	FDG	06/26/00		Track 2934c. Get data type from dictionary instead of
//							hard-coding it.
//	FDG	12/11/00		Stars 4.7.
//							1. Issue an Insert-Select Distict to account for duplicates
//							2. Make the inserting of datetime values DBMS-independent
//	FDG	03/20/01		Stars 4.7.  Pass the invoice type when creating a temp table.
//	GaryR	03/26/01		Stars 4.7 - Move Stars Server Functionality to w_subset_options.
// GaryR	08/08/01		Track 2396d	Functional flaw creating subsets
//	GaryR	02/14/02		Track 2802d	Do not create multiple key tables
// 10/19/04 MikeF		SPR 3650d		Replaced local n_cst_dict with global
//***************************************************************************

// Declare local variables

Integer							li_ccn
Integer							li_idx
Integer							li_num_rows
Integer							li_return_code

Long								ll_job_id,	ll_rc			// FDG 03/21/01

String							ls_col_name
String							ls_data_type
String							ls_datetime
String							ls_ds_style
String							ls_error
String 							ls_insert_CCN
String							ls_sql_string
String							ls_syntax

// Get the ICN column or LINE Number column.

If gc_debug_mode = TRUE Then 
   f_debug_box('INFO','Date Time = '+string(id_date_key, 'mm/dd/yyyy'))
End if

li_ccn = 0

FOR li_idx = 1 TO ii_num_of_cols
	If upper(dw_1.Describe('#'+string(li_idx)+'.name')) = upper(as_ccn_col_name) Then
		li_ccn = li_idx
	End if
NEXT

If li_ccn = 0  Then
	messagebox("Random Sampling Program Error",	&
				  "Unable to locate the column containing the CCN or LINE number")
	RETURN -1
End if

// Get the next available job id
// FDG 03/21/01 - Get next Job ID from Stars Server.
//is_job_id	=	fx_get_next_key_id('JOB_ID')

//If is_job_id = 'ERROR' Then
//	messagebox("Random Sampling Program Error",	&
//				  "Error occurred getting the next job id key")
//	RETURN -1
//End if

//	GaryR	03/26/01		Stars 4.7 - Begin
//ll_rc			=	gnv_server.of_jobcreate (ll_job_id)
//
//If ll_rc	<	0		Then
//	messagebox("Random Sampling Program Error",	&
//				  "Error occurred getting the next job id key")
//	RETURN -1
//End if
//
//is_job_id	=	String (ll_job_id)
//	GaryR	03/26/01		Stars 4.7 - End
// FDG 03/21/01 end


// Load the ICNs from the datawindow into the temporary table
// FDG 03/20/01 - Column name is now ICN
//ls_col_name		=	iv_rand_samp.table_id	+	"_ICN"										// FDG 03/22/00	// FDG 03/20/01
ls_col_name		=	'ICN'
ls_data_type	=	gnv_dict.Event	ue_get_data_type (iv_rand_samp.table_id, 'ICN')		// FDG 06/26/00

inv_temp_attrib.is_function								=	"CREATE"
//inv_temp_attrib.is_table_name								=	"KEY_"	+	is_job_id		// FDG 03/22/00	// FDG 03/20/01
inv_temp_attrib.is_table_name								=	''									// FDG 03/20/01
inv_temp_attrib.istr_cols[1].is_col_name				=	ls_col_name						// FDG 03/22/00
inv_temp_attrib.istr_cols[1].is_data_type				=	ls_data_type					// FDG 06/26/00
inv_temp_attrib.istr_index_cols[1].is_index_col[1]	=	ls_col_name						// FDG 03/22/00
inv_temp_attrib.istr_index_cols[1].is_index_type	=	"I"
inv_temp_attrib.is_inv_type								=	iv_rand_samp.table_id		// FDG 03/20/01
inv_temp_attrib.ii_request									=	inv_temp_attrib.ici_icn_table	// FDG 03/20/01

// Create the temp table using the temp table non visual object

li_return_code		=	inv_temp_table.of_execute_sql(inv_temp_attrib)

If li_return_code = 1 Then
	is_icn_table_name	=	inv_temp_table.of_get_table_name()
	// GaryR	08/08/01		Track 2396d
	istr_subset_options.server_job_id = inv_temp_table.of_get_server_job_id()
Else
	Messagebox("Random Sample Subset Creation:",	&
				  "Error creating temporary table for ICNs")
	RETURN  -1
End if
	
// Create the dataobject for the local datastore

ids_1.dataobject	=	"d_random_sampling_unique_icns"

ids_1.SetTransObject(Stars2ca)

// FDG 01/18/98 - Add 'mm/dd/yyyy' when stringing a date.	//NLG 03/11/99 - add hh:mm:ss Track #2179c
// FDG 12/11/00 - Use Select-Distinct to avoid duplicate inserts and make temp_datetime
//						DBMS-independent.

//ls_sql_string		=	" INSERT INTO " 																	&
//						+ 	  is_icn_table_name																&
//						+	" SELECT ICN "																		&
//						+	" FROM USER_TEMP_RAND_SAMPLE "												&
//						+	" WHERE USER_ID = "																&
//						+	" '" + gc_user_id	+ "'"															&
//						+	" AND TEMP_DATETIME = " 														&
//						+	" '" + String(iv_rand_samp.temp_datetime, 'mm/dd/yyyy hh:mm:ss') + "'"		&
//						+	" AND SUBC_ID = "																	&
//						+	" '" + as_subset_id + "'"
ls_datetime			=	String (iv_rand_samp.temp_datetime, 'mm/dd/yyyy hh:mm:ss')
ls_datetime			=	gnv_sql.of_get_to_date (ls_datetime)
//	GaryR	02/14/02	Track 2802d - Begin
//ls_sql_string		=	" INSERT INTO " 																	&
//						+ 	  is_icn_table_name																&
//						+	" SELECT DISTINCT ICN "															&
//						+	" FROM USER_TEMP_RAND_SAMPLE "												&
//						+	" WHERE USER_ID = "																&
//						+	" '" + Upper( gc_user_id )	+ "'"												&
//						+	" AND TEMP_DATETIME = " 														&
//						+	ls_datetime																			&
//						+	" AND SUBC_ID = "																	&
//						+	" '" + Upper( as_subset_id ) + "'"
ls_sql_string		=	" INSERT INTO " 																	&
						+ 	  is_icn_table_name																&
						+	" SELECT DISTINCT ICN "															&
						+	" FROM USER_TEMP_RAND_SAMPLE "												&
						+	" WHERE USER_ID = "																&
						+	" '" + Upper( gc_user_id )	+ "'"												&
						+	" AND TEMP_DATETIME = " 														&
						+	ls_datetime
//	GaryR	02/14/02	Track 2802d - End						
						
EXECUTE IMMEDIATE :ls_sql_string	USING	STARS2CA;

If  Stars2ca.of_check_status() = 0 Then
	COMMIT USING STARS2CA;
	RETURN 0
Else
	ROLLBACK USING STARS2CA;
	MessageBox("Random Sample Subset Creation:",	&
				  "Error inserting claim numbers in temporary table.")
	RETURN  -1
End if


end function

public function boolean create_op_file_name ();////////////////////////////////////////////////////////////////////////////////
//
// This function will attempt to create a unique filename based	
// on the PROV_ID id in the datwindow.  Its is a little long winded
// in order to compensate for PIN or UPIN being in the string
//
////////////////////////////////////////////////////////////////////////////////
//
// Maintenance log:
// By:	Date:			Description
//	JGG	02/19/98		STARS 4.0 - TS145 Random Sampling Claims changes
//	Katie	02/09/07		SPR 4754 Handle NPI as possible column name
//	GaryR	04/22/08		SPR 5103	Resolve dup providers and centralize logic
//
////////////////////////////////////////////////////////////////////////////////

boolean 					lb_work_done = FALSE
integer 					li_idx = 1
string 					ls_prov_string

// Build the Overpayment file name
ls_prov_string 				= 	iv_rand_samp.prov

sle_output_file_name.text 	= 	trim(sle_output_file_name.text)

if (ls_prov_string = "") 	&
or (ls_prov_string = '?') 	&
or (ls_prov_string = '!') 	then
   iv_one_provider = FALSE
	RETURN(FALSE)
else
   iv_one_provider = TRUE
end if

// add backslash if not present

if mid(sle_output_file_name.text,len(sle_output_file_name.text),1) <> '\' then
	sle_output_file_name.text = sle_output_file_name.text + '\'
end if

// extract prov id from string returned
  
if pos(ls_prov_string,' ') > 1 then
	ls_prov_string = mid(ls_prov_string,1,pos(ls_prov_string,' ') - 1)
end if 

// remove leading zeroes in the case of PIN with leading zeroes

if isnumber(ls_prov_string) then
	ls_prov_string = string(dec(ls_prov_string),"#########0")
end if

// truncate to 6 digits

ls_prov_string = mid(ls_prov_string,1,6)  

// create file name based on first 6 of provid and sequential two 
// digit number
DO while (not lb_work_done) and (li_idx < 100)
	if not fileExists(sle_output_file_name.text 		+ 	&
							ls_prov_string 					+ 	&
							string(li_idx,"00") 	+ 	".OP") 	then
		sle_output_file_name.text 	= 	sle_output_file_name.text 	&
											+ 	ls_prov_string 				&
											+ 	string(li_idx,"00") 			&
											+ 	".OP"
		lb_work_done = TRUE
	end if
	li_idx = li_idx + 1	
LOOP

if not lb_work_done then
   // unable to assign file name
	sle_output_file_name.text 		= 	sle_output_file_name.text 	&
											+ 	ls_prov_string 				&
											+ 	"XX.OP"
end if

return(TRUE)
end function

public function boolean wf_buildhospsel ();//******************************************************************
// 03-28-96 FNC 	STARS31 Prob #118 Add ICN to sort order
// 05/01/96	FNC 	If join is in the ENROLLEE view do not display patient
//                name and birthdate in datawindow. Use code/decode to 
//                obtain patient name.
// 06-19-96	FNC   Prob #6 Stars33 Move the claim table to the first 
//						table in the from statement because decode expects 
//						it to be first.
// 10-16-96	FNC 	Prob 176 Stars35 Add variable with filter table 
//						name into the sql	Statment is created in the "Else" 
//						condition of the xref if statement.
//	11-21-96	FNC 	Select Id Nbr from user_temp_rand_sample so user
//						can correlate this report to the RDM reports written
//						to the case folder
//	02/29/97	JGG 	STARS 4.0 - TS145 Random Sampling Claims changes
// 03-26-97 FNC	Track #12 Use column name for upin or prov that is 
//						in the structure to insure that the correct name is
//						used.
// 08-20-97	FNC	Track #616 Starcare Join to providers for prov name
//						must be on prov id since there may be multiple upin
//						entries and it would cause duplicate rows to be retrieved
// 08-05-98 AJS	Stars 4.0 Track #1412.  Move ORDER BY outside of loop.
// 09/02/98 FNC	Track 1579. Add recip id to order by. It is in order by
//						in 3.6.
// 11/19/98	FNC	Track 1579 - Don't increment counter, for loop is 
//						already incrementing it.
//	11/27/00	FDG	Stars 4.7.  Make the SQL DBMS independent relating
//						to the outer join.
//	11/14/01	FDG	Stars 4.7.	Remove Order By from SQL because of "Union"
// 07/03/02	Jason	Track 3173 	Fix revenue field names
// 07/23/02 MikeF	Track 3495c Left Outer Join fix for Sybase.
// 02/25/03 MikeF	Track 3454d	Issue with Revenue Pre-Filter and Revenue split (Hard coded CR)
//	03/31/03	GaryR	Track 3492d	Issues with select clause for multiple subsets
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	02/09/07 Katie		SPR 4754 Modified pin_label_t on datawindow to reflect prov column,
//							handled name a column changes to support NPI
//	06/29/07 Katie 		SPR 5091 Removed logic adding the subset filter tables to the from clause.
//	07/09/07 Katie		SPR 5091 Added logic to ensure that the subset filter criteria was only added to the where for the subset
//							it applies to.
//	04/22/08	GaryR	SPR 5103	Resolve dup providers and centralize logic
//
//******************************************************************

Long						ll_idx
Long						ll_pos
Integer					li_rc					// FDG 11/14/01

// Hospital/Revenue join fields
String					ls_join_depn_cols
String					ls_join_depn_table
String					ls_join_hcpcs_code
String					ls_join_rev_amt
String					ls_join_rev_code
String					ls_join_sort_key

// SQL statement fields
String					ls_mod_string
String					ls_return_string
String					ls_from		// FDG 11/27/00
String					ls_where		// FDG 11/27/00
String					ls_sort				// FDG 11/14/01
String					ls_icn_line_no
String					ls_pin_label
String 					ls_subset_id

// Set up the datawindow object based on UB92 table type

dw_1.dataobject		=	"d_random_sampling_claims_ub92_pin_xref"

// Set datawindow object and join variables based on the user's
// selection to include the revenue table.  If coming from the Case
// Folder, default to a join to display revenue information.

If iv_rand_samp.bJoinActive = TRUE 		Then
	ls_join_rev_code		=	" " + iv_rand_samp.sJoinTableType + ".REVENUE_CODE, "
	ls_join_hcpcs_code	=	" " + iv_rand_samp.sJoinTableType + ".HCPCS_CODE, "
	ls_join_rev_amt		=	" " + iv_rand_samp.sJoinTableType + ".REV_AMT, "
	ls_join_depn_cols		=	" AND ( CH." 									&
								+ 	iv_rand_samp.sJoinMainKey 		+ " = "	&
								+  iv_rand_samp.sJoinTableType 	+ "."		&
								+	iv_rand_samp.sJoinDepnKey		+ ") "
	ls_join_sort_key		=	", " + iv_rand_samp.sJoinTableType + ".REVENUE_CODE ASC "
	ls_icn_line_no			=	iv_rand_samp.sJoinTableType + ".ICN_LINE_NO"
Else
	ls_join_rev_code		=	"'NONE', "
	ls_join_hcpcs_code	=	"'NONE', "
	ls_join_rev_amt		=	"'0.00', "
	ls_join_depn_cols		=	" "
	ls_join_sort_key		=	" "
	ls_icn_line_no			=	"CH.ICN_LINE_NO"
End if	

// Initialize the modified datawindow SQL statements

ls_mod_string				=	"DataWindow.Table.Select=~""

if (trim(iv_rand_samp.subset_crit) <> '') then
	ll_pos = Pos(iv_rand_samp.subset_crit, 'SUB_FILTER_VALS_')
	ls_subset_id = mid(iv_rand_samp.subset_crit,ll_pos+16,10)
end if

// Now loop through the list of selected subsets and build the
// appropriate SQL to select the column values

FOR ll_idx = 1 to iv_rand_samp.subsets_selected
	
	// Add union statement if more than 1 subset table selected by 
	// the user.
	If ll_idx > 1 THEN
		ls_mod_string	=	ls_mod_string + " UNION "
	End if
	
	// Build the join table name, if necessary
	
	If iv_rand_samp.bJoinActive = TRUE 		Then
		ls_join_depn_table	= 	iv_Rand_Samp.sJoinSubsetName[ll_idx] + " " + iv_rand_samp.sJoinTableType + ", "	 	 
	Else
		ls_join_depn_table	=	" "
	End if	

	ls_from		=	"USER_TEMP_RAND_SAMPLE UT, "	+ ls_join_depn_table + &
							iv_rand_samp.subset_table_name[ll_idx] + " CH, " + &
							iv_rand_samp.unique_cnt_temp_table_name + " PR"
							
	ls_where		=	"AND (CH." + iv_rand_samp.prov_col_name + " = " + &
							"PR." + iv_rand_samp.prov_orig_name + ")"

	// Build the SQL to retrieve from the next selected subset table. 
	
	ls_mod_string		=	ls_mod_string															&
							+ 	" SELECT " 																&
							+ 	" UT.ID_NBR, " 														&
							+ 	" CH.RECIP_ID, " 														&
							+ 	" CH.ICN, " 															&
							+ 	" CH.FROM_DATE, " 													&
							+ 	" CH.PAYMENT_DATE, " 												&
							+ 	" CH.PROC_CODE, " 													&
							+ 	  ls_join_rev_code	 												&						
							+ 	  ls_join_hcpcs_code	 												&
							+ 	  ls_join_rev_amt														&
							+ 	" CH.BILLED_CHARGES, "												&
							+ 	" CH.ALLOWED_AMT, " 													&
							+ 	" CH.PAYMENT, " 														&
							+ 	" CH." +	iv_rand_samp.prov_col_name + ", " 					&
							+ 	" PR." + iv_rand_samp.prov_name_col_name + ", "				&
							+	  ls_icn_line_no														&
							+ 	" FROM " 	+	ls_from												&
							+ 	" WHERE (( UT.USER_ID = Upper(:arg_UserId) )  "				&
							+ 	" AND ( UT.TEMP_DATETIME = :arg_TempDateTime )  "			&
							+ 	" AND ( UT.SUBC_ID = '"												&
							+	  Upper(iv_rand_samp.case_subset_id[ll_idx]) + "')) "		&
							+ 	" AND ( UT.ICN = CH.ICN )  "										&
							+ 	  ls_join_depn_cols								 					&
							+	  ls_where							 							
							
				if (upper(iv_Rand_Samp.case_subset_id[ll_idx]) = upper(ls_subset_id)) then 
						ls_mod_string = ls_mod_string +    iv_Rand_Samp.subset_crit 		
				end if
NEXT

ls_mod_string			=	ls_mod_string	+	'"'
ls_return_string 		= 	dw_1.Modify(ls_mod_string)

IF ls_return_string <> "" THEN
	MessageBox(This.Title, "Modify SQL Failed:~r~n " + ls_return_string)
END IF

// FDG 11/14/01	Remove Order By from SQL & sort d/w instead
ls_sort		=	"#13 A, #2 A, #3 A"
li_rc			=	dw_1.SetSort (ls_sort)
li_rc			=	dw_1.Sort()
// FDG 11/14/01 end

// If the join to the Revenue table is not active,
// set the width of the 3 revenue columns to zero.
// The user will not be able to see them in this case.

If iv_rand_samp.bJoinActive = TRUE Then
Else
	// Begin - Track 3173
	ls_mod_string		=	' revenue_code.Width="0" '	
	// End - Track 3173
	ls_return_string	=	dw_1.Modify(ls_mod_string)
	
	If ls_return_string <> "" Then
		MessageBox(This.Title, "Resetting width on Revenue Code failed:~r~n " + ls_return_string)
	End if
	// Begin - Track 3173
	ls_mod_string		=	' hcpcs_code.Width="0" '		
	// End - Track 3173
	ls_return_string	=	dw_1.Modify(ls_mod_string)
	
	If ls_return_string <> "" Then
		MessageBox(This.Title, "Resetting width on HCPCS Code failed:~r~n " + ls_return_string)
	End if
	// Begin - Track 3173	
	ls_mod_string		=	' rev_amt.Width="0" '
	// End - Track 3173
	ls_return_string	=	dw_1.Modify(ls_mod_string)
	
	If ls_return_string <> "" Then
		MessageBox(This.Title, "Resetting width on Revenue Amount failed:~r~n " + ls_return_string)
	End if
End if

ls_pin_label = dw_1.Describe('pin_label_t.Expression')
ls_pin_label = Replace (ls_pin_label, 2, 3, iv_rand_samp.pit_label)
ls_mod_string = 'pin_label_t.Expression = "' + ls_pin_label + '"'
ls_return_string	=	dw_1.Modify(ls_mod_string)
	
If ls_return_string <> "" Then
	MessageBox(This.Title, "Altering Provider Identifier Type Label failed:~r~n " + ls_return_string)
End if

RETURN True
end function

public function boolean wf_buildpharsel ();/////////////////////////////////////////////////////////////////////////////
//
//	03/28/96	FNC	STARS31 Prob #118 Add ICN to sort order
//	05/01/96	FNC	If join is in the ENROLLEE view do not display patient
//                name and birthdate in datawindow. Use code/decode to 
//                obtain patient name.
//	06/19/96	FNC	Prob #6 Stars33 Move the claim table to the first 
//						table in the from statement because decode expects 
//						it to be first.
//	11/21/96	FNC	Select Id Nbr from user_temp_rand_sample so user
//						can correlate this report to the RDM reports written
//						to the case folder
//	03/26/97	FNC	Track #12 Use column name for upin or prov that is 
//						in the structure to insure that the correct name is
//						used.
//	08/20/97	FNC	Track #616 Starcare Join to providers for prov name
//						must be on prov id since there may be multiple upin
//						entries and it would cause duplicate rows to be retrieved
//	02/19/98	JGG	STARS 4.0 - TS145 Random Sampling Claims changes
//	08/05/98	AJS	Stars 4.0 Track #1412.  Move ORDER BY outside of loop.
//	09/02/98	FNC	Track 1579. Add recip id to order by. It is in order by
//						in 3.6.
// 11/19/98	FNC	Track 1579 - Don't increment counter, for loop is 
//						already incrementing it.
//	11/27/00	FDG	Stars 4.7.  Make the SQL DBMS independent relating
//						to the outer join.
//	11/14/01	FDG	Stars 4.7.	Remove Order By from SQL because of "Union"
// 07/23/02 MikeF	Track 3495c. Left Outer Join fix for Sybase.
//	03/31/03	GaryR	Track 3492d	Issues with select clause for multiple subsets
//	02/09/07 Katie		SPR 4754 Modified pin_label_t on datawindow to reflect prov column,
//							handled name a column changes to support NPI
//	04/22/08	GaryR	SPR 5103	Resolve dup providers and centralize logic
//
/////////////////////////////////////////////////////////////////////////////

Long					ll_idx
Integer				li_rc					// FDG 11/14/01

// SQL statement fields
String				ls_mod_string
String				ls_return_string
String				ls_from		// FDG 11/27/00
String				ls_where		// FDG 11/27/00
String				ls_sort				// FDG 11/14/01
String				ls_pin_label

// Set up the datawindow object based on PHAR table type

dw_1.dataobject			=	"d_random_sampling_claims_phar_pin_xref"

// Initialize the modified datawindow SQL statements

ls_mod_string				=	"DataWindow.Table.Select=~""

// Now loop through the list of selected subsets and build the
// appropriate SQL to select the column values

FOR ll_idx = 1 to iv_rand_samp.subsets_selected
	
	// Add union statement if more than 1 subset table selected by 
	// the user.
	If ll_idx > 1 THEN
		ls_mod_string	=	ls_mod_string + " UNION "
	End if

	// FDG 11/27/00 - Get the Outer Join SQL for the Where and From clauses
	ls_from		=	"USER_TEMP_RAND_SAMPLE UT, " + &
							iv_rand_samp.subset_table_name[ll_idx] + " CP, " + &
							iv_rand_samp.unique_cnt_temp_table_name + " PR"

	ls_where		=	"AND (CP." + iv_rand_samp.prov_col_name + " = " + &
							"PR." + iv_rand_samp.prov_orig_name + ")"

	// Build the SQL to retrieve from the next selected subset table
	
	ls_mod_string		=	ls_mod_string															&
							+  " SELECT " 																&
							+  " UT.ID_NBR, "	 														&
							+  " CP.RECIP_ID, "  													&
							+  " CP.ICN, "  															&
							+  " CP.FROM_DATE, "  													&
							+  " CP.PAYMENT_DATE, "  												&
							+  " CP.RX_NO, "  														&
							+  " CP.BILLED_CHARGES, "  											&
							+  " CP.ALLOWED_AMT, "  												&
							+  " CP.PAYMENT, "  														&
							+  " CP.PRESC_PHYS, "  													&
							+  " CP.NDC_CODE, "  													&
							+  " PR." + iv_rand_samp.prov_name_col_name + ", "				&
							+  " CP." + iv_rand_samp.prov_col_name 		  					&
							+	", CP.ICN_LINE_NO "													&
							+  " FROM " 	+	ls_from												&
							+  " WHERE (( UT.USER_ID = Upper(:arg_UserId) ) "				&
							+  " AND ( UT.TEMP_DATETIME = :arg_TempDateTime ) " 			&
							+ 	" AND ( UT.SUBC_ID = '"												&
							+	  Upper(iv_rand_samp.case_subset_id[ll_idx]) + "')) " 	&
							+  " AND ( UT.ICN = CP.ICN )  "  									&
							+  ls_where
NEXT

ls_mod_string			=	ls_mod_string		+	'"'
ls_return_string 		= 	dw_1.Modify(ls_mod_string)

IF ls_return_string <> "" THEN
	MessageBox(This.Title, "Modify Failed:~r~n " + ls_return_string)
END IF

ls_pin_label = dw_1.Describe('pin_label_t.Expression')
ls_pin_label = Replace (ls_pin_label, 2, 3, iv_rand_samp.pit_label)
ls_mod_string = 'pin_label_t.Expression = "' + ls_pin_label + '"'
ls_return_string	=	dw_1.Modify(ls_mod_string)
	
If ls_return_string <> "" Then
	MessageBox(This.Title, "Altering Provider Identifier Type Label failed:~r~n " + ls_return_string)
End if

// FDG 11/14/01	Remove Order By from SQL & sort d/w instead
ls_sort		=	"#13 A, #2 A, #3 A"
li_rc			=	dw_1.SetSort (ls_sort)
li_rc			=	dw_1.Sort()
// FDG 11/14/01 end

RETURN True
end function

public function boolean wf_buildprofsel ();///////////////////////////////////////////////////////////////////////////
//
//	03/28/96	FNC	STARS31 Prob #118 Add ICN to sort order
// 05/01/96	FNC	If join is in the ENROLLEE view do not display patient
//                name and birthdate in datawindow. Use code/decode to 
//                obtain patient name.
// 06/19/96	FNC	Prob #6 Stars33 Move the claim table to the first 
//						table in the from statement because decode expects 
//						it to be first.
//	11/21/96	FNC	Select Id Nbr from user_temp_rand_sample so user
//						can correlate this report to the RDM reports written
//						to the case folder
// 03-26-97	FNC	Track #12 Use column name for upin or prov that is 
//						in the structure to insure that the correct name is
//						used.
// 08/20/97	FNC	Track #616 Starcare Join to providers for prov name
//						must be on prov id since there may be multiple upin
//						entries and it would cause duplicate rows to be retrieved
//	02/19/97	JGG	STARS 4.0 - TS145 Random Sampling Clains changes
//	08/05/98	AJS	Stars 4.0 Track #1412.  Move ORDER BY outside of loop.
// 09/02/98 FNC	Track 1579. Add recip id to order by. It is in order by
//						in 3.6.
// 11/19/98	FNC	Track 1579 - Don't increment counter, for loop is 
//						already incrementing it.
//	11/27/00	FDG	Stars 4.7.  Make the SQL DBMS independent relating
//						to the outer join.
//	11/14/01	FDG	Stars 4.7.	Remove Order By from SQL because of "Union"
// 07/23/02 MikeF	Track 3495c. Left Outer Join fix for Sybase.
//	03/31/03	GaryR	Track 3492d	Issues with select clause for multiple subsets
//	02/09/07 Katie		SPR 4754 Modified pin_label_t on datawindow to reflect prov column,
//							handled name a column changes to support NPI
//	04/22/08	GaryR	SPR 5103	Resolve dup providers and centralize logic
//
///////////////////////////////////////////////////////////////////////////

Long					ll_idx
Integer				li_rc					// FDG 11/14/01

// SQL statement fields
String				ls_mod_string
String				ls_return_string
String				ls_from		// FDG 11/27/00
String				ls_where		// FDG 11/27/00
String				ls_sort				// FDG 11/14/01
String				ls_pin_label

// Set up the datawindow object based on the 1500 table type

dw_1.dataobject		=	"d_random_sampling_claims_1500_pin_xref"

// Initialize the modified datawindow SQL statements

ls_mod_string				=	"DataWindow.Table.Select=~""

// Now loop through the list of selected subsets and build the
// appropriate SQL to select the column values

FOR ll_idx = 1 to iv_rand_samp.subsets_selected
	
	// Add union statement if more than 1 subset table selected by 
	// the user.
	If ll_idx > 1 THEN
		ls_mod_string	=	ls_mod_string + " UNION "
	End if

	// FDG 11/27/00 - Get the Outer Join SQL for the Where and From clauses
	ls_from		=	"USER_TEMP_RAND_SAMPLE UT, " + &
							iv_rand_samp.subset_table_name[ll_idx] + " CF, " + &
							iv_rand_samp.unique_cnt_temp_table_name + " PR"

	ls_where		=	"AND (CF." + iv_rand_samp.prov_col_name + " = " + &
							"PR." + iv_rand_samp.prov_orig_name + ")"
							
	// Build the SQL to retrieve from the next selected subset table
	
	ls_mod_string		=	ls_mod_string															&
							+ 	" SELECT "			 													&
							+ 	" UT.ID_NBR, " 														&
							+ 	" CF.RECIP_ID, " 														&
							+ 	" CF.ICN, " 															&
							+ 	" CF.FROM_DATE, " 													&
							+ 	" CF.PAYMENT_DATE, " 												&
							+ 	" CF.PROC_CODE, " 													&
							+ 	" CF.BILLED_CHARGES, " 												&
							+ 	" CF.ALLOWED_AMT, " 													&
							+ 	" CF.DEDUCT_AMT, " 													&
							+ 	" CF.PAYMENT, " 														&
							+ 	" CF." + iv_rand_samp.prov_col_name + ", " 					&
							+ 	" PR." + iv_rand_samp.prov_name_col_name + ", "				&
							+	" CF.ICN_LINE_NO "													&
							+ 	" FROM " + ls_from										 			&
							+ 	" WHERE (( UT.USER_ID = Upper(:arg_UserId) ) "				&
							+ 	" AND ( UT.TEMP_DATETIME = :arg_TempDateTime ) "			&
							+ 	" AND ( UT.SUBC_ID = '"												&
							+	Upper(iv_rand_samp.case_subset_id[ll_idx])	+ "')) "		&
							+ 	" AND ( UT.ICN = CF.ICN  ) " 										&
							+ 	ls_where 
NEXT

ls_mod_string			=	ls_mod_string	+	'"'
ls_return_string 		= 	dw_1.Modify(ls_mod_string)

IF ls_return_string <> "" THEN
	MessageBox(This.Title, "Modify Failed:~r~n " + ls_return_string)
END IF

ls_pin_label = dw_1.Describe('pin_label_t.Expression')
ls_pin_label = Replace (ls_pin_label, 2, 3, iv_rand_samp.pit_label)
ls_mod_string = 'pin_label_t.Expression = "' + ls_pin_label + '"'
ls_return_string	=	dw_1.Modify(ls_mod_string)
	
If ls_return_string <> "" Then
	MessageBox(This.Title, "Altering Provider Identifier Type Label failed:~r~n " + ls_return_string)
End if

// FDG 11/14/01	Remove Order By from SQL & sort d/w instead
ls_sort		=	"#11 A, #2 A, #3 A"
li_rc			=	dw_1.SetSort (ls_sort)
li_rc			=	dw_1.Sort()
// FDG 11/14/01 end

RETURN True
end function

event open;//	Overrides the ancestor
//
//*******************************************************************
//
//	09/22/94	FNC	If provider name not on prov_name table send out
//             	messagebox and continue to process
//	11/25/96	FNC	Prob #173 STARS35 move call to fx_set_window_colors
//						to this script from open script. The datawindow color
//						became overlaid when this script set the dataobject
// 					If first Parm (usually prov ID = VIEW then we are in from viewer
//	07/17/97	FDG	Since this script overrides w_dw_viewer.open, then
//						call w_master.open
//	03/11/98	AJS	Fix global variables
//	09/23/03	GaryR	Track 3598d	Post-DCG changes
//
//*******************************************************************

SetPointer(Hourglass!)
setmicrohelp(W_MAIN,"Open the Report Window")

iv_rand_samp = message.powerobjectparm
Setnull(message.Powerobjectparm)

Call	w_master::Open

This.event ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

PostEvent ('ue_ReportBuild')
end event

event close;call super::close;// close notes maint window if opened to add a file list
if isValid(w_notes_maint) and (iv_notes_added) then
	w_notes_maint.cb_exit.TriggerEvent(Clicked!)
end if

// Destroy instances of non visual objects

DESTROY	ids_1

SetPointer(Hourglass!)

SetMicroHelp(w_main,"Ready")

close(This)

end event

on w_random_sampling_claims.create
int iCurrent
call super::create
this.cb_project_op=create cb_project_op
this.rb_allowed_amt=create rb_allowed_amt
this.rb_paid_amt=create rb_paid_amt
this.gb_icn=create gb_icn
this.gb_project_on=create gb_project_on
this.cb_create_med_recs_list=create cb_create_med_recs_list
this.st_1=create st_1
this.st_icn=create st_icn
this.cb_icn=create cb_icn
this.gb_2=create gb_2
this.sle_output_file_name=create sle_output_file_name
this.cb_save_file=create cb_save_file
this.cb_subset=create cb_subset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_project_op
this.Control[iCurrent+2]=this.rb_allowed_amt
this.Control[iCurrent+3]=this.rb_paid_amt
this.Control[iCurrent+4]=this.gb_icn
this.Control[iCurrent+5]=this.gb_project_on
this.Control[iCurrent+6]=this.cb_create_med_recs_list
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_icn
this.Control[iCurrent+9]=this.cb_icn
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.sle_output_file_name
this.Control[iCurrent+12]=this.cb_save_file
this.Control[iCurrent+13]=this.cb_subset
end on

on w_random_sampling_claims.destroy
call super::destroy
destroy(this.cb_project_op)
destroy(this.rb_allowed_amt)
destroy(this.rb_paid_amt)
destroy(this.gb_icn)
destroy(this.gb_project_on)
destroy(this.cb_create_med_recs_list)
destroy(this.st_1)
destroy(this.st_icn)
destroy(this.cb_icn)
destroy(this.gb_2)
destroy(this.sle_output_file_name)
destroy(this.cb_save_file)
destroy(this.cb_subset)
end on

type cb_save from w_dw_viewer`cb_save within w_random_sampling_claims
boolean visible = false
integer x = 1125
integer y = 1540
end type

type cb_report_options from w_dw_viewer`cb_report_options within w_random_sampling_claims
integer x = 1079
integer y = 1776
end type

type cb_calendar from w_dw_viewer`cb_calendar within w_random_sampling_claims
integer x = 1143
integer y = 1660
end type

type st_count from w_dw_viewer`st_count within w_random_sampling_claims
integer x = 23
integer y = 1884
integer width = 270
integer height = 72
integer textsize = -8
string facename = "Microsoft Sans Serif"
end type

type ddlb_dw_ops from w_dw_viewer`ddlb_dw_ops within w_random_sampling_claims
integer x = 5
integer y = 1544
integer width = 672
integer height = 368
end type

type st_dw_ops from w_dw_viewer`st_dw_ops within w_random_sampling_claims
integer x = 5
integer y = 1472
end type

type dw_1 from w_dw_viewer`dw_1 within w_random_sampling_claims
string tag = "CRYSTAL, title = Sample Claims"
integer x = 5
integer y = 4
integer width = 3058
integer height = 1468
end type

event dw_1::rbuttondown;call super::rbuttondown;// JasonS 09/05/02 Begin - Track 3091d
fx_lookup(dw_1, in_decode_struct.table_type[1])
//fx_lookup(dw_1,'RD')
// JasonS 09/05/02 End - Track 3091d

end event

type cb_close from w_dw_viewer`cb_close within w_random_sampling_claims
integer x = 2697
integer y = 1860
integer width = 347
integer height = 100
integer taborder = 120
boolean cancel = true
boolean default = false
end type

type cb_project_op from u_cb within w_random_sampling_claims
string accessiblename = "Project OP"
string accessibledescription = "Project OP"
integer x = 2688
integer y = 1716
integer width = 347
integer height = 100
integer taborder = 90
integer textsize = -8
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Project OP"
end type

event clicked;//  Clicked for Project OP, button - (RATSTATS)

//*********************************************************
//03-12-96 FNC Change col name allowed_amount to allowed_amt
//10-06-95 FNC Take rowcount out of loop
//*********************************************************

int filenbr, suba, lv_rowcount
string out_rec


// make sure projection on amount was selected
if (rb_allowed_amt.checked = FALSE) and (rb_paid_amt.checked = FALSE) then
        MessageBox("ERROR","Please select the amount to do the projection on.")
        return
end if

// Write OP Projection file
SetMicrohelp(W_MAIN,"Writing Over Payment Projection Output File") 

// output file must not currently exist
if fileexists(sle_output_file_name.text) then
	if (MessageBox("QUESTION","The overpayment projection file specified already exists.  Do you wish to reuse this file name and destroy the prior data?",Question!,YesNo!,2)) = 2 then
		SetMicroHelp(W_main,"Ready")
		return
	end if
end if
SetPointer(Hourglass!)
filenbr = FileOpen(sle_output_file_name.text,LineMode!,Write!,LockReadWrite!,Replace!)
if (filenbr = -1) then
	MessageBox("ERROR","Error opening Overpayment Projection output file.~r~nProbable causes for error are: ~r~n~tFile locked by another user~r~n~tInsufficient rights to the file")     
	SetMicroHelp(w_main,"Error")
	return
end if

lv_rowcount = dw_1.rowcount()        //10-06-95 FNC
FOR suba = 1 to lv_rowcount          //10-06-95 FNC
//	out_rec = dw_1.GetItemString(suba,"CCN") 								&
//				+ string(dw_1.GetItemNumber(suba,"LINE"),"00") + ' '
	string cname
	out_rec = dw_1.GetItemString(suba,"icn") + ' ' 								
	if rb_allowed_amt.checked = TRUE then   
		out_rec = out_rec + String(dw_1.Getitemdecimal(suba,"allowed_amt"),"########0.00")  //03-12-96 FNC
	else
		out_rec = out_rec + String(dw_1.Getitemdecimal(suba,"payment"),"########0.00")
	end if
	if FileWrite(filenbr, out_rec) = -1 then
		Messagebox("ERROR","Error writing to the Overpayment output file.  File may now be corrupted.")
		return
	end if
NEXT

if FileClose(filenbr) = -1 then      // Close the file 
	MessageBox("ERROR","Error closing the Overpayment output file.  Check file for accuracy.")
	SetMicroHelp(w_main,"Error")
	return
end if

SetMicrohelp(w_main,"Ready")
cb_project_op.enabled = FALSE    // you can only do this once


end event

type rb_allowed_amt from radiobutton within w_random_sampling_claims
string accessiblename = "Allowed Amt"
string accessibledescription = "Allowed Amt"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1760
integer y = 1740
integer width = 453
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Allowed Amt"
end type

type rb_paid_amt from radiobutton within w_random_sampling_claims
string accessiblename = "Paid Amt"
string accessibledescription = "Paid Amt"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 2240
integer y = 1740
integer width = 357
integer height = 72
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Paid Amt"
end type

type gb_icn from groupbox within w_random_sampling_claims
string accessiblename = "Unique ICNs"
string accessibledescription = "Unique ICNs"
accessiblerole accessiblerole = groupingrole!
integer x = 5
integer y = 1624
integer width = 677
integer height = 200
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Unique ICNs"
end type

type gb_project_on from groupbox within w_random_sampling_claims
string accessiblename = "Projection On"
string accessibledescription = "Projection On"
accessiblerole accessiblerole = groupingrole!
integer x = 1723
integer y = 1660
integer width = 1335
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Projection On"
end type

type cb_create_med_recs_list from u_cb within w_random_sampling_claims
string accessiblename = "Save Report"
string accessibledescription = "Save Report"
integer x = 1934
integer y = 1860
integer width = 347
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Save &Report"
end type

event clicked;//******************************************************************
//
//	03/27/96	FNC	Change gv_user_ls_notes_descid to gc_user_id
//	05/12/98	NLG	replace notes globals with notes nvo
//	11/25/98	FNC	Track 1406. Add Total claims to note.
//	08/09/02	Jason	Track 3220d  Capture return from report save window
//	08/14/02	Jason	Track 3220d  Create note in background
//	12/19/02	Jason	Track 2883d add note desc
//	09/23/03	GaryR	Track 3598d	Post-DCG changes
//	02/03/04	GaryR	Track 3836d	Start provider loop at one and remove extra break
//	08/16/05	GaryR	Track 4361d	Add log entry for new notes
//	04/09/07	Katie	SPR 4964 Update text in Notes to include PIT Label and Run by details.
//
//******************************************************************

n_cst_notes lnvo_notes	// JasonS 08/14/02 Track 3220d
string ls_subsets, ls_notes_desc, ls_providers	// JasonS 08/14/02 Track 3220d
int li_idx, li_num_provs	// JasonS 08/14/02 Track 3220d

// clicked for Create medical records button
int filenbr, suba
int li_retval		// JasonS 08/09/02  Track 3220d
// Write out med rec file (append or create if not exist)
SetPointer(Hourglass!)
setmicrohelp(W_MAIN,"Writing Medical Records File")

// JasonS 08/09/02 Begin - Track 3220d
li_retval = fx_m_save()

if li_retval <> 1 then 
	return
end if
// JasonS 08/09/02 End - Track 3220d

// JasonS 08/14/02 Begin - Track 3220d
setmicrohelp(W_MAIN,"Creating Case Notes")
for li_idx = 1 to iv_rand_samp.subsets_selected 
	ls_subsets = ls_subsets + iv_rand_samp.case_subset_name[li_idx] + "~r~n"
next

lnvo_notes.is_user_id = gc_user_id
lnvo_notes.is_dept_id = gc_user_dept
lnvo_notes.is_notes_rel_type = 'CA'
lnvo_notes.is_notes_sub_type = 'RS'
lnvo_notes.is_notes_rel_id = gv_active_case
lnvo_notes.is_notes_id = fx_get_next_key_id('NOTE')
lnvo_notes.is_note_text = "Subsets:~r~n" +&
									ls_subsets + iv_rand_samp.file_list +&
									"~r~nTotal Claims in Sample = " + st_icn.text + &
									"~r~nTotal Claim Lines in Sample = " + st_count.text

if iv_rand_samp.across_provs then
	lnvo_notes.is_note_text += '~r~n~r~nAcross Selection '
else
	lnvo_notes.is_note_text += '~r~n~r~nWithin Selection '
end if

li_num_provs = upperbound(iv_rand_samp.selected_provs)
FOR li_idx = 1 TO li_num_provs
	ls_providers = ls_providers + '~r~n' + iv_rand_samp.selected_provs[li_idx]
NEXT

lnvo_notes.is_note_text += '~r~n~r~n' + iv_rand_samp.pit_label +'s in sample:' +	ls_providers
									
lnvo_notes.is_rte_ind = 'N'
lnvo_notes.idt_datetime = gnv_app.of_get_server_date_time()
gnv_sql.of_trimdata(lnvo_notes.is_notes_desc) // JasonS 12/19/02 Track 2883d

lnvo_notes.uf_create_note()

// JasonS 08/14/02  End - Track 3220d

// if all OK disable this button and enable the OP button
// EK  Per Pat-D it supposed to be enabled always
if iv_one_provider then
	cb_project_op.enabled = TRUE
	gb_project_on.enabled = TRUE
	rb_allowed_amt.enabled = TRUE
	rb_paid_amt.enabled = TRUE
end if

cb_create_med_recs_list.enabled = FALSE
SetMicroHelp(w_main,"Ready")
end event

type st_1 from statictext within w_random_sampling_claims
boolean visible = false
string accessiblename = "# of rows"
string accessibledescription = "# rows"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1824
integer width = 270
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "# rows"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_icn from statictext within w_random_sampling_claims
string accessiblename = "Unique ICN Count"
string accessibledescription = "Unique ICN Count"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1692
integer width = 270
integer height = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

type cb_icn from u_cb within w_random_sampling_claims
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 306
integer y = 1692
integer width = 347
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Update"
end type

on clicked;//**********************************************************************
// FNC 08-28-96	Remove integer function and replace with long so large
//						numbers can be handled.
//
//**********************************************************************
if st_icn.text <> "" and dw_1.RowCount() <> 0 then
 st_icn.text = string(dw_1.GetItemNumber(1,"distinct_icn"))
end if

if long(st_count.text) = 0 then			//08-28-96 FNC
 st_icn.text = string(0)
end if 
end on

type gb_2 from groupbox within w_random_sampling_claims
string accessiblename = "Overpayment Sample File"
string accessibledescription = "Overpayment Sample File"
accessiblerole accessiblerole = groupingrole!
integer x = 1723
integer y = 1472
integer width = 1335
integer height = 184
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Overpayment Sample File:"
end type

type sle_output_file_name from singlelineedit within w_random_sampling_claims
string accessiblename = "Output File name"
string accessibledescription = "Output File name"
accessiblerole accessiblerole = textrole!
integer x = 1746
integer y = 1544
integer width = 919
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_save_file from u_cb within w_random_sampling_claims
string accessiblename = "Modify"
string accessibledescription = "Modify"
integer x = 2688
integer y = 1532
integer width = 347
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "Mo&dify"
end type

event clicked;//********************************************************************************
// 09/25/98 FNC	Track 1743. Remove default extension
//********************************************************************************

string temp_str

//getfilesavename("Save Data In File:",sle_output_file_name.text,temp_str,"*.out")
getfilesavename("Save Data In File:",sle_output_file_name.text,temp_str)	// FNC 09/25/98
end event

type cb_subset from u_cb within w_random_sampling_claims
string accessiblename = "Subset"
string accessibledescription = "Subset..."
integer x = 2318
integer y = 1860
integer width = 347
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Subset..."
boolean cancel = true
end type

event clicked;//*******************************************************************
//		Object Type:	CommandButton
//		Object Name:	w_random_sampling.cb_subset
//		Event Name:		N/A
//
//*******************************************************************
//
//	08-06-96	FNC	Created
//						Modeled from w_sampling_analysis_detail.cb_subset
// 
// 02/20/98 JGG	STARS 4.0 - TS145 Random Sampling Claims changes
// 10/06/99 AJS   TS2443 - Rls 4.5 Enhanced notes
//	03/22/00	FDG	Stars 4.5.  For unique key changes, change temp table
//						name from 'ICN_...' to 'KEY_...'.  Change column from
//						'ICN' to 'C1_ICN'.
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
//	03/21/01	FDG	Stars 4.7.  The column name of the temp table = 'ICN'.
//	03/26/01	GaryR	Stars 4.7 - Move Stars Server Functionality to w_subset_options.
// 08/08/01	GaryR	Stars 4.7	Empty String in SQL
//	02/14/02	GaryR	Track 2802d	Do not create multiple key tables
// 10/18/02	Jason	Track 2883d  added note_desc to sql
//	09/05/03	GaryR	Track 3598d	Add seed logic to sampling process
//	09/23/03	GaryR	Track 3598d	Post-DCG changes
//	02/03/04	GaryR	Track 3836d	Start provider loop at one and remove extra break
//	02/01/07 Katie SPR 4891 Removed code dropping the temporary tables.
//	04/09/07	Katie	SPR 4964 Update text in Notes to include PIT Label.
//*******************************************************************

// Declare local variables

Datetime				ldt_default_date

Integer				li_rc
Integer				li_idx						
Integer				li_num_provs

String				ls_across
String				ls_col_name
String				ls_empty_string[]
String 				ls_new_note_id
String 				ls_note_id
String				ls_note_text
String				ls_providers
String				ls_subsets
String				ls_empty		//GaryR 08/08/01

// Verify it is okay to create the subset

setpointer(hourglass!)
SetMicroHelp(W_Main,'Creating subset from random sample')	

ii_num_of_cols 	= 	integer(dw_1.Describe('datawindow.column.count'))

If ii_num_of_cols < 1 Then
	MessageBox("Error","Unable to create subset, nothing displayed in window..")
	RETURN
End if

ii_num_of_rows 	= 	dw_1.rowcount() 

//id_date_key 		= 	datetime(today(),now())
id_date_key 		=	gnv_app.of_get_server_date_time()

// Make sure active case is set

li_rc 				=  fx_active_case_edit() 

If li_rc <> 0 Then
	COMMIT using Stars2ca;
	If Stars2ca.of_check_status() <> 0 then
		messagebox('Warning','Error performing commit in cb_subset.')
	End if	
	RETURN
End If

// Set up the subsetting structures with the appropriate information
// and open the subset options window to actually create the subset.

// FDG 03/21/01 - Temp table column name = 'ICN'
//ls_col_name			=	iv_rand_samp.table_id	+	"_ICN"		// FDG 03/22/00
ls_col_name			=	'ICN'
// FDG 03/21/01 end

ldt_default_date	=	datetime(date('01/01/01'))

iv_rand_samp.icn_table_name[]		=	ls_empty_string[]

istr_subset_options.come_from		=	'REPSUB'

// Loop through each selected subset and store its information
// in the subset options structure.
// Also create a temp table containing the ICNs in each subset.
//	02/14/02	GaryR	Track 2802d
IF wf_insert_temp_ccn( "ICN", iv_rand_samp.case_subset_id[iv_rand_samp.subsets_selected] ) <> 0 THEN Return

FOR li_idx = 1 TO iv_rand_samp.subsets_selected
	
	//	02/14/02	GaryR	Track 2802d - Begin
//	// Store the ICNs from this subset in a unique temporary table.
//	li_rc					= 	wf_insert_temp_ccn('ICN',										&
//														 iv_rand_samp.case_subset_id[li_idx])
//	
//	If li_rc <> 0 Then 
//		RETURN
//	End if
	//	02/14/02	GaryR	Track 2802d - End
	
	// ICN table name
	iv_rand_samp.icn_table_name[li_idx]														&
							=	is_icn_table_name
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - Begin
//	istr_subset_options.sub_info[li_idx].temp_table_name								&
//							=	Stars2ca.Database													&
//							+	'..'																	&
//							+	is_icn_table_name
	istr_subset_options.sub_info[li_idx].temp_table_name								&
							=	gnv_sql.of_get_database_prefix( Stars2ca.Database )	&
							+	is_icn_table_name
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - End
							
	// Subset table name
	istr_subset_options.sub_info[li_idx].source_subset_id								&
							=	iv_rand_samp.case_subset_id[li_idx]
	
	// Paid From date
	istr_subset_options.sub_info[li_idx].subset_step[1].paid_from_date			&
							=	ldt_default_date
							
	// Paid Thru date
	istr_subset_options.sub_info[li_idx].subset_step[1].paid_thru_date			&
							=	ldt_default_date
							
	// Invoice type
	istr_subset_options.sub_info[li_idx].subset_step[1].inv_type					&
							=	iv_rand_samp.table_id
	
	// Subset type
	istr_subset_options.sub_info[li_idx].subset_step[1].subset_type				&
							=	iv_rand_samp.table_id
	
	// Subset Source type
	istr_subset_options.sub_info[li_idx].subset_step[1].subc_sub_src_type		&
							=	'SS'
							
	// Input type
	istr_subset_options.sub_info[li_idx].subset_step[1].input_type					&
							=	'ICN'

	// Input id
	istr_subset_options.sub_info[li_idx].subset_step[1].input_id					&
							=	iv_rand_samp.case_subset_id[li_idx]
	
	// Subset Source Case id
	istr_subset_options.sub_info[li_idx].subset_step[1].subc_sub_src_case_id	&
							=	iv_rand_samp.case_id												&
							+	iv_rand_samp.case_spl											&
							+	iv_rand_samp.case_ver
	
	// SQL Statement to create subset
	// FDG 03/22/00 - Change 'I.ICN' to 'I.C1_ICN'
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - Begin
//	istr_subset_options.sub_info[li_idx].subset_step[1].sql_statement				&
//							=	" SELECT S.* FROM "												&
//							+	Upper(Stars2ca.Database)										&
//							+	".."																	&
//							+	Upper(is_icn_table_name)										&
//							+	" I, "																&
//							+	Upper(Stars2ca.Database)										&
//							+	".."																	&
//							+	Upper(iv_rand_samp.subset_table_name[li_idx])			&
//							+	" S WHERE I."														&
//							+	ls_col_name															&
//							+	" = S.ICN "
	istr_subset_options.sub_info[li_idx].subset_step[1].sql_statement						&
							=	" SELECT S.* FROM "														&
							+	Upper(gnv_sql.of_get_database_prefix( Stars2ca.Database ))	&
							+	Upper(is_icn_table_name) +	" I, "									&
							+	Upper(gnv_sql.of_get_database_prefix( Stars2ca.Database ))	&
							+	Upper(iv_rand_samp.subset_table_name[li_idx]) +	" S WHERE I." &
							+	ls_col_name	+ " = S.ICN "
	//	12/04/00	GaryR	Stars 4.7 DataBase Port - End

	// Criteria line info
	istr_subset_options.sub_info[li_idx].criteria[1].left_paren						&
							=	" "
	istr_subset_options.sub_info[li_idx].criteria[1].expression_one				&
							=	"RANDOM SAMPLE"
	istr_subset_options.sub_info[li_idx].criteria[1].rel_operator					&
							=	"="
	istr_subset_options.sub_info[li_idx].criteria[1].expression_two				&
							=	Upper(iv_rand_samp.sample_by)
	istr_subset_options.sub_info[li_idx].criteria[1].right_paren					&
							= " "
	istr_subset_options.sub_info[li_idx].criteria[1].logical_operator				&
							= " "
	istr_subset_options.sub_info[li_idx].criteria[1].data_type						&
							=	"CHAR"

NEXT	// Subset

//	GaryR	03/26/01		Stars 4.7	
//istr_subset_options.job_id			=	is_job_id

// Open the subset options window, passing the newly completed structure
// as its input argument

//OpenSheetWithParm(w_subset_options, 	&
//					 istr_subset_options,	&
//					 w_main,						&
//					 help_menu_position,		&
//					 layered!)

OpenWithParm(w_subset_options, 	&
				 istr_subset_options)
						
// Check the subset options window status

istr_subset_options	=	Message.PowerObjectParm
SetNull(Message.PowerObjectParm)

CHOOSE CASE Upper(istr_subset_options.status)
	CASE "ERROR" 
		SetMicroHelp(w_main, "Error creating Random Sample Subset")
		Return		//	02/14/02	GaryR	Track 2802d
	CASE "CANCEL"
		SetMicroHelp(w_main, "Random Sample Subset Creation Cancelled!")
		Return		//	02/14/02	GaryR	Track 2802d
	CASE ELSE
		SetMicroHelp(w_main, 'Random Sample Subset request successfully processed')
		
END CHOOSE

this.enabled = FALSE //NLG Track #1897		//	02/14/02	GaryR	Track 2802d

// Now start adding notes, etc

ls_new_note_id = fx_get_next_key_id('NOTE')

If ls_new_note_id = 'ERROR' Then
	COMMIT using Stars2ca;
	If Stars2ca.of_check_status() <> 0 Then
		MessageBox('Warning','Error performing commit in cb_subset.')
	End if	
	RETURN
Else
	ls_note_id = ls_new_note_id
End If

ls_subsets = iv_rand_samp.case_subset_name[1]

If iv_rand_samp.subsets_selected > 1 Then
	FOR li_idx = 2 to iv_rand_samp.subsets_selected 
		ls_subsets = ls_subsets + ',' + iv_rand_samp.case_subset_name[li_idx]
	NEXT
End if

if iv_rand_samp.across_provs then
	ls_across = 'Across Selection ' 
else
	ls_across = 'Within Selection '
end if

ls_note_text = 'New Sub id - '						+ &
					istr_subset_options.subset_name	+ &
					'~r~n' 									+ & 
					'Subset included - ' 				+ &
					ls_subsets  							+ &
					'~r~n' 									+ &
					'Sampled by - ' 						+ &
					iv_rand_samp.sample_by 				+ &
					'~r~n' 									+ &
					'Sample type - ' 						+ &
					iv_rand_samp.sample_type 			+ &
					'~r~n' 									+ &
					iv_rand_samp.file_list				+ &
					'~r~n' 									+ &
					ls_across

li_num_provs = upperbound(iv_rand_samp.selected_provs)
FOR li_idx = 1 TO li_num_provs
	ls_providers = ls_providers + '~r~n' + iv_rand_samp.selected_provs[li_idx]
NEXT

//ajs 09-06-99 notes
ls_note_text = ls_note_text + '~r~n~r~n' + iv_rand_samp.pit_label +'s in sample:' + ls_providers
					
//Add rte_ind to sql; insert empty string
//	GaryR	08/08/01
gnv_sql.of_TrimData( ls_empty )

INSERT INTO NOTES  
         ( DEPT_ID,   
           USER_ID,   
           NOTE_REL_TYPE,   
           NOTE_SUB_TYPE,   
           NOTE_REL_ID,   
           NOTE_ID,   
           NOTE_DATETIME,   
           NOTE_TEXT,
			  RTE_IND,
			  NOTE_DESC)  	// JasonS 10/18/02 Track 2883d
VALUES   (:gc_user_dept, 
			 :gc_user_id,
			 'CA',
			 'RS',
			 :gv_active_case,
			 :ls_note_id,
			 :id_date_key,
          :ls_note_text,
			 :ls_empty,	//	GaryR	08/08/01
			 :ls_empty)  	//	JasonS 10/18/02 Track 2883d
USING 	 stars2ca ;

If stars2ca.of_check_status() <> 0 then
	Errorbox(Stars2ca,'Error inserting note')
	Return
End If

COMMIT USING Stars2ca;

If Stars2ca.of_check_status() <> 0 Then
	ErrorBox(stars2ca,'Error performing commit in cb_subset.')
End if	

RETURN

end event

