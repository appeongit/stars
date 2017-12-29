HA$PBExportHeader$n_cst_case.sru
$PBExportComments$process business rules for a specific case <logic>
forward
global type n_cst_case from n_base
end type
end forward

global type n_cst_case from n_base
event type integer ue_refer_case ( string as_refer_dept,  string as_refer_user )
event type integer ue_reassign_case ( string as_assign_dept,  string as_assign_user,  string as_old_user )
end type
global n_cst_case n_cst_case

type variables
Public:

//string NVO - autoinstantiated
n_cst_string inv_string

//list of columns in case_cntl
n_ds ids_dictionary_case
n_ds ids_dictionary_track
n_ds ids_dictionary_custom

//datastore to edit for case security (code table)
n_ds ids_code

//Case datawindow for specific case.
u_dw idw_case

//list of tracks for a case
u_dw idw_track

// Stars 4.8 - List of case_log entries for a case
u_dw	idw_case_log

// Stars 4.8 - Refer to user_id and department
String	is_refer_user
String	is_refer_dept

// Stars 4.8 - Is the case being referred
Boolean	ib_referral

// Stars 4.8.1 - Audit log for case_log
n_ds	ids_case
n_ds	ids_case_log

// Stars 5.1 - Dictionary-ize case_log/ visible datawindow
u_dw  idw_display_log

end variables

forward prototypes
public function string uf_get_default_contractor ()
public function string uf_copy_analysis_criteria (string as_crit_id)
public function boolean uf_edit_case_closed (string as_link_key, string as_link_type)
public function boolean uf_edit_case_closed_subset (string as_subset_id)
public function integer uf_update_analysis_criteria (string as_crit_id)
public function integer uf_update_sub_cntl (string as_subc_id)
public function integer uf_audit_log (string as_case, string as_message)
public function integer uf_audit_log (string as_link_key, string as_link_type, string as_message)
public function string uf_edit_case_security (string as_case_cat)
public function string uf_edit_case_security (string as_case_id, string as_case_spl, string as_case_ver)
public function string uf_edit_case_security_user (string as_case_cat, string as_userid)
public subroutine uf_set_case_dw (datawindow adw)
public subroutine uf_set_track_dw (datawindow adw)
public subroutine uf_set_case_log_dw (datawindow adw)
public subroutine uf_set_case_log_display_dw (datawindow adw)
public function integer uf_format_elem_desc (datastore ads)
public function integer uf_undo_case_log_nulls ()
public function integer uf_update_pattern (string as_patt_id)
public function string uf_copy_criteria (string as_by_id)
public function string uf_get_modify_heading (datawindow adw, string as_column)
public subroutine uf_create_refer_case_log (long al_new_case_row, string as_link_type, string as_old_link_name, string as_new_link_name)
public function long uf_initialize_case_log (long al_case_row)
public function integer uf_update_pdq (string as_query_id)
public function boolean uf_edit_case_closed (string as_case_id)
public function boolean uf_edit_case_referred (string as_case_id, string as_case_spl, string as_case_ver)
public function boolean uf_edit_case_referred (string as_case_id, string as_case_spl, string as_case_ver, string as_link_type, string as_link_name)
public function long uf_retrieve_case ()
public function integer uf_valid_case (string as_case_id, string as_case_spl, string as_case_ver)
public function boolean uf_edit_case_closed (string as_case_id, string as_case_spl, string as_case_ver)
public function long uf_filter_sys_codes (ref datawindowchild adwc_requestor, readonly string as_input_code)
public function string uf_create_case (string as_case_id, boolean ab_lead)
public function long uf_create_case_log (long al_case_row, boolean ab_add_2nd_row)
public function integer uf_audit_log (string as_case_id, string as_case_spl, string as_case_ver, string as_message)
public subroutine uf_set_alignment (datawindow adw, string as_inv_type)
public function integer uf_compute_case_totals (string as_case_id, string as_case_spl, string as_case_ver)
public function string uf_get_custom_headings (datawindow adw, string as_column)
public function string uf_copy_pattern (string as_patt_id)
public function string uf_copy_pdq (string as_query_id)
public function integer uf_format_custom_headings (datawindow adw)
public function string uf_get_comp_upd_status (string as_comp_id, string as_case_id, string as_case_spl, string as_case_ver)
public function boolean uf_get_link_exists (string as_case_id, string as_case_spl, string as_case_ver, string as_link_type, string as_link_name)
public function boolean uf_edit_case_deleted (string as_case_id, string as_case_spl, string as_case_ver)
public function boolean uf_edit_case_deleted (string as_case_id)
public function string uf_get_comp_upd_status_lead (string as_comp_id, string as_case_id, string as_case_spl, string as_case_ver)
end prototypes

event type integer ue_refer_case(string as_refer_dept, string as_refer_user);/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Script:		ue_refer_case
//
//	Arguments:	as_refer_dept: The department that the case is being referred to.
//					as_refer_user: The user that the case is being assigned to.
//
//	Returns:		Integer
//					-1	=	Error
//					 1	=	Success
//
//	Description:
//		Refer the case to a new department.  In this version, all data for the
//		existing case will remain but will also be copied to the new case.
//
//	Notes:	1. All GUI edits must occur before calling this.
//				2.	idw_case must be registered (uf_set_case_dw).
//				3. idw_track must be registered (uf_set_track_dw).
//				4.	idw_case_log must be registered (uf_set_case_log_dw).
//				5. Since bg_step_cntl has case_id and jobs cannot be copied,
//					bg_step_cntl will not be copied.  Also, an edit must be
//					added to ensure that there are no pending jobs for this case.
//				6.	When retrieving note_text in 5.1, use gnv_sql.of_get_note_text()
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	08/28/01	FDG	Stars 4.8.1	Created
//	12/14/01	GaryR	Stars 4.8.1	WIC Changes
// 12/26/01 SAH   Stars 4.8.1 Uncheck pmr_ready_cd once case is referred 
// 01/25/02 SAH   Stars 4.8.1 When user_id is not specified when referring case, set referring user_id in 
//										User Messages to 'NONE'. Also when reassigning a case.
// 02/06/02 SAH	Stars 4.8.1 When case gets referred, reset pmr_ready_cd, _date, _user and pmr_created_cd,
//										_date and user on the new case and maintain pmr data on original case. Also, 
//										update Assign Date (case_asgn_date) in log for new case.
// 05/06/02 SAH   Stars 5.1 	Track 3022 The above note made for 02/06/02 changes is to apply only to those cases
//  								 	that were marked ready for PIMR and had a PIMR file already generated.  If the original case
//								    	was marked ready for PIMR, but the PIMR file had not yet been generated, the PIMR flag
//									 	is to remain set on the new case, also.
//	05/17/02	GaryR	Track 3010d	Link name in log does not match the referred link name.
//	05/21/02	GaryR	Track 3061d	Resolve user_id columns on case_log.
// 05/28/02	GaryR	Track 2552d Predefined Report (PDR)
//	06/14/02	GaryR	Track 3020d	Eliminate disposition SYSADDR
// 06/18/02 Jason	Track 3063d	Change case status to RC on referral
//	09/17/02	GaryR	SPR 4182c	Pass three unique key arguments for notes retrieval
// 10/29/02 Jason Track 2883d Insert note desc into notes on referral
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	04/06/05	GaryR	Track 4370d	Call UPDATEBLOB method instead of directly inserting note text
//	07/04/05	GaryR	Track 4361d	Add a renamed entry to Case Log for referred Notes
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	03/05/07	GaryR	Track 4932	Remove references to the obsolete MESSAGE_TEXT column
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

Boolean		lb_referral

String		ls_case_id,				&
				ls_case_spl,			&
				ls_case_ver,			&
				ls_case_newver,		&
				ls_oldcase,				&
				ls_olduser,				&
				ls_olddept,				&
				ls_newcase,				&
				ls_case_cat,			&
				ls_link_status,		&
				ls_link_type,			&
				ls_link_key,			&
				ls_link_name,			&
				ls_new_link_key,		&
				ls_status_desc,		&
				ls_note_text,			&
				ls_dept_id,				&
				ls_user_id,				&
				ls_note_rel_type,		&
				ls_note_sub_type,		&
				ls_note_rel_id,		&
				ls_note_id,				&
				ls_new_note_id,		&
				ls_rte_ind
String		ls_note_desc	// JasonS 10/29/02 Track 2883d

Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount,		&
				ll_case_row

Integer		li_rc,					&
				li_refer_rc

Date			ldt_init

DateTime		ldtm_refer,				&
				ldtm_current,			&
				ldtm_init,				&
				ldtm_note_datetime,	&
				ldtm_date
				
n_ds			lds_track,				&
				lds_track_log,			&
				lds_case_link,			&
				lds_lead,				&
				lds_target,				&
				lds_target_cntl,		&
				lds_restore_request,	&
				lds_notes

Constant	String	lcs_referred	=	'REFERRED'
Constant	String	lcs_sysrefer	=	'SYSREFER'		//	06/14/02	GaryR	Track 3020d

n_cst_attachments lnv_att

w_main.SetMicroHelp( 'Referring Case.  Please wait...' )

// Get the case ID
ll_case_row		=	idw_case.GetRow()

ls_case_id		=	idw_case.object.case_id [ll_case_row]
ls_case_spl		=	idw_case.object.case_spl [ll_case_row]
ls_case_ver		=	idw_case.object.case_ver [ll_case_row]
ls_oldcase		=	ls_case_id	+	ls_case_spl	+	ls_case_ver
ls_olduser		=	idw_case.object.case_asgn_id [ll_case_row]
ls_olddept		=	idw_case.object.dept_id [ll_case_row]

// SAH 01/25/02 -Begin
//ls_olduser		=	idw_case.object.case_asgn_id [ll_case_row]

IF idw_case.object.case_asgn_id[ll_case_row] = "" THEN
	ls_olduser = 'NONE'
ELSE
	ls_olduser = idw_case.object.case_asgn_id[ll_case_row]
END IF

// SAH 01/25/02 -End


//	Initialize data
ldtm_refer		=	gnv_app.of_get_server_date_time()
ldtm_current	=	gnv_app.of_get_server_date_time()
ldtm_init		=	DateTime( Date( 1900, 01, 01 ) )
ldt_init			=	Date( 1900, 01, 01 )
ls_status_desc	=	'CASE REFERRED'

as_refer_dept	=	Upper ( Trim(as_refer_dept) )

// Determine if the user ID was specified.
as_refer_user	=	Upper ( Trim(as_refer_user) )
is_refer_user	=	as_refer_user
is_refer_dept	=	as_refer_dept

// Compute the new case_ver (i.e. '00' will be changed to '01')
ls_case_newver	=	String( Integer(ls_case_ver) + 1, '00' )
ls_newcase		=	ls_case_id	+	ls_case_spl	+	ls_case_newver


// Create the datastores

lds_track	=	CREATE	n_ds
lds_track.DataObject = 'd_case_track_list'
li_rc = lds_track.SetTransObject(Stars2ca)

lds_track_log	=	CREATE	n_ds
lds_track_log.DataObject = 'd_case_track_log_list'
li_rc = lds_track_log.SetTransObject(Stars2ca)

lds_case_link	=	CREATE	n_ds
lds_case_link.DataObject = 'd_case_link_case'
li_rc = lds_case_link.SetTransObject(Stars2ca)

lds_lead		=	CREATE	n_ds
lds_lead.DataObject = 'd_case_lead_list'
li_rc = lds_lead.SetTransObject(Stars2ca)

lds_target	=	CREATE	n_ds
lds_target.DataObject = 'd_case_target_list'
li_rc = lds_target.SetTransObject(Stars2ca)

lds_target_cntl	=	CREATE	n_ds
lds_target_cntl.DataObject = 'd_case_target_cntl_list'
li_rc = lds_target_cntl.SetTransObject(Stars2ca)

lds_restore_request	=	CREATE	n_ds
lds_restore_request.DataObject = 'd_case_restore_request_part_c_list'
li_rc = lds_restore_request.SetTransObject(Stars2ca)

lds_notes	=	CREATE	n_ds
lds_notes.DataObject = 'd_notes'
li_rc = lds_notes.SetTransObject(Stars2ca)

// Insert a new case_cntl by copying the original case_cntl and initializing the data.
li_rc	=	idw_case.RowsCopy ( ll_case_row, ll_case_row, Primary!, idw_case, ll_case_row + 1, Primary! )

idw_case.object.case_ver [ll_case_row + 1]			=	ls_case_newver
idw_case.object.dept_id [ll_case_row + 1]				=	as_refer_dept
idw_case.object.user_id [ll_case_row + 1]				=	gc_user_id
idw_case.object.case_asgn_id [ll_case_row + 1]		=	as_refer_user
idw_case.object.case_asgn_date [ll_case_row + 1]	=	ldtm_current
idw_case.object.refer_from_dept [ll_case_row + 1]	=	gc_user_dept
idw_case.object.refer_to_dept [ll_case_row + 1]		=	' '
idw_case.object.refer_by_rep [ll_case_row + 1]		=	gc_user_id
idw_case.object.refer_date [ll_case_row + 1]			=	ldtm_init
//idw_case.object.case_cat [ll_case_row + 1]			=	'REF'		// Keep to the original value - per specs
idw_case.object.case_disp_hold [ll_case_row + 1]	=	' '
idw_case.object.case_status [ll_case_row + 1]		=	'OP'
idw_case.object.case_disp [ll_case_row + 1]			=	lcs_sysrefer	//	06/14/02	GaryR	Track 3020d
idw_case.object.case_updt_user [ll_case_row + 1]	=	gc_user_id
idw_case.object.case_status_date [ll_case_row + 1]	=	ldtm_current
idw_case.object.case_status_desc [ll_case_row + 1]	=	ls_status_desc
//idw_case.object.case_date_recv [ll_case_row + 1]	=	ldtm_current		// Leave alone per KayKay request (8/29/01)


// SAH 05/06/02 Track 3022 -Begin

// SAH 02/06/02 -Begin
//idw_case.object.pmr_created_cd [ll_case_row + 1]   =  ' '   				
//idw_case.object.pmr_created_date [ll_case_row + 1] =  ldtm_init
//idw_case.object.pmr_created_user [ll_case_row + 1] =  ' '
//idw_case.object.pmr_ready_cd [ll_case_row + 1]	  =  ' '
//idw_case.object.pmr_ready_date [ll_case_row + 1]   =  ldtm_init
//idw_case.object.pmr_ready_user [ll_case_row + 1]   =  ' '
// SAH 02/06/02 -End

// If PIMR Ready Flag is set to YES on the original (00) case
IF idw_case.object.pmr_ready_cd[ll_case_row]	= 'Y' THEN
	// Check if the PIMR file has actually been generated yet
	IF idw_case.object.pmr_created_cd[ll_case_row] = 'Y' THEN
		// IF the PIMR file was already generated, reset PIMR values
		idw_case.object.pmr_created_cd [ll_case_row + 1]   =  ' '   				
		idw_case.object.pmr_created_date [ll_case_row + 1] =  ldtm_init
		idw_case.object.pmr_created_user [ll_case_row + 1] =  ' '
		idw_case.object.pmr_ready_cd [ll_case_row + 1]		=  ' '
		idw_case.object.pmr_ready_date [ll_case_row + 1]   =  ldtm_init
		idw_case.object.pmr_ready_user [ll_case_row + 1]   =  ' '
	ELSE // PIMR file has not been generated
		  // KEEP PIMR settings on new (01) case
	END IF
END IF

// SAH 05/06/02 Track 3022 -End


// w_case_maint initializes all 1/1/1900 dates to nulls for display purposes.
// Reset these null dates back to 1/1/1900.
IF IsNull ( idw_case.object.case_datetime [ll_case_row + 1] )		THEN
	idw_case.object.case_datetime [ll_case_row + 1]	=	ldtm_init
END IF

IF IsNull ( idw_case.object.case_status_date [ll_case_row + 1] )		THEN
	idw_case.object.case_status_date [ll_case_row + 1]	=	ldtm_init
END IF

IF IsNull ( idw_case.object.case_from_period [ll_case_row + 1] )		THEN
	idw_case.object.case_from_period [ll_case_row + 1]	=	ldtm_init
END IF

IF IsNull ( idw_case.object.case_to_period [ll_case_row + 1] )		THEN
	idw_case.object.case_to_period [ll_case_row + 1]	=	ldtm_init
END IF

IF IsNull ( idw_case.object.pmr_custom1_date [ll_case_row + 1] )		THEN
	idw_case.object.pmr_custom1_date [ll_case_row + 1]	=	ldtm_init
END IF

IF IsNull ( idw_case.object.pmr_custom2_date [ll_case_row + 1] )		THEN
	idw_case.object.pmr_custom2_date [ll_case_row + 1]	=	ldtm_init
END IF

IF IsNull ( idw_case.object.pmr_custom3_date [ll_case_row + 1] )		THEN
	idw_case.object.pmr_custom3_date [ll_case_row + 1]	=	ldtm_init
END IF

// Update the existing case (after copying it)
// Begin - Track 3063d
//idw_case.object.case_status [ll_case_row]			=	'CL'
idw_case.object.case_status [ll_case_row]			=	'RC'
// End - Track 3063d
idw_case.object.case_disp [ll_case_row]			=	lcs_referred
idw_case.object.case_updt_user [ll_case_row]		=	gc_user_id
idw_case.object.case_status_date [ll_case_row]	=	ldtm_current
idw_case.object.case_status_desc [ll_case_row]	=	ls_status_desc
idw_case.object.refer_to_dept [ll_case_row]		=	as_refer_dept
idw_case.object.refer_date [ll_case_row]			=	ldtm_refer
idw_case.object.case_disp_hold [ll_case_row]		=	' '
gv_case_disp												=	''		// Case is no longer held until re-retrieved
//idw_case.object.pmr_ready_cd [ll_case_row]      =  ''    //Uncheck pmr_ready_cd on existing case



li_rc	=	idw_case.Event	ue_update( TRUE, FALSE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Copy the case_log rows.  For the newly inserted rows, change case_ver.
//	First remove any null data from the existing case_log data.  Some values
//	may have been initialized to nulls for display purposes.
li_rc			=	This.uf_undo_case_log_nulls()
ll_rowcount	=	idw_case_log.RowCount()

li_rc	=	idw_case_log.RowsCopy ( 1, ll_rowcount, Primary!, idw_case_log, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	idw_case_log.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	idw_case_log.object.case_ver [ll_row]	=	ls_case_newver
NEXT

// Insert new case_log entry for the changed disposition (original case)
ll_new_row	=	This.uf_initialize_case_log (ll_case_row)

//idw_case_log.object.user_id [ll_new_row]				=	gc_user_id		//	05/21/02	GaryR	Track 3061d
idw_case_log.object.disp [ll_new_row]						=	lcs_referred
idw_case_log.object.status_desc [ll_new_row]				=	"Case Referred to "	+	as_refer_user	+	&
																			" in "	+	as_refer_dept	+	&
																			".  New Case ID: "	+	ls_newcase
idw_case_log.object.status_datetime [ll_new_row]		=	ldtm_current
idw_case_log.object.sys_datetime [ll_new_row]			=	ldtm_current

// Insert new case_log entry for the opening of the new referred case. 
ll_new_row	=	This.uf_initialize_case_log (ll_case_row + 1)

idw_case_log.object.case_ver [ll_new_row]					=	ls_case_newver
idw_case_log.object.user_id [ll_new_row]					=	gc_user_id
idw_case_log.object.status [ll_new_row]					=	'OP'
//	06/14/02	GaryR	Track 3020d
//idw_case_log.object.disp [ll_new_row]						=	'SYSADDR'
idw_case_log.object.disp [ll_new_row]						=	lcs_sysrefer
idw_case_log.object.status_desc [ll_new_row]				=	"Case Referred from "	+	ls_olduser	+	&
																			" in "	+	ls_olddept	+	&
																			".  Old Case ID: "		+	ls_oldcase
idw_case_log.object.status_datetime [ll_new_row]		=	ldtm_current
idw_case_log.object.sys_datetime [ll_new_row]			=	ldtm_current
idw_case_log.object.dept_id [ll_new_row]					=	as_refer_dept
idw_case_log.object.case_asgn_id [ll_new_row]			=	as_refer_user
idw_case_log.object.case_asgn_date [ll_new_row]       =  ldtm_refer		// SAH 02/06/02

//	12/14/01	GaryR	Stars 4.8.1 - Begin
idw_case_log.object.pmr_subject_id [ll_new_row]			=	idw_case.object.pmr_subject_id [ll_case_row + 1]
idw_case_log.object.case_datetime [ll_new_row]			=	idw_case.object.case_datetime [ll_case_row + 1]
idw_case_log.object.case_type [ll_new_row]				=	idw_case.object.case_type [ll_case_row + 1]
idw_case_log.object.case_cat [ll_new_row]					=	idw_case.object.case_cat [ll_case_row + 1]
idw_case_log.object.case_business [ll_new_row]			=	idw_case.object.case_business [ll_case_row + 1]
idw_case_log.object.case_edit [ll_new_row]				=	idw_case.object.case_edit [ll_case_row + 1]
idw_case_log.object.case_from_period [ll_new_row]		=	idw_case.object.case_from_period [ll_case_row + 1]
idw_case_log.object.case_to_period [ll_new_row]			=	idw_case.object.case_to_period [ll_case_row + 1]
idw_case_log.object.case_desc [ll_new_row]				=	idw_case.object.case_desc [ll_case_row + 1]
idw_case_log.object.case_status_desc [ll_new_row]		=	idw_case.object.case_status_desc [ll_case_row + 1]
idw_case_log.object.case_date_recv [ll_new_row]			=	idw_case.object.case_date_recv [ll_case_row + 1]
idw_case_log.object.pmr_contractor_id [ll_new_row]		=	idw_case.object.pmr_contractor_id [ll_case_row + 1]
idw_case_log.object.pmr_ready_cd [ll_new_row]			=	idw_case.object.pmr_ready_cd [ll_case_row + 1]
idw_case_log.object.pmr_ready_date [ll_new_row]			=	idw_case.object.pmr_ready_date [ll_case_row + 1]
idw_case_log.object.pmr_created_cd [ll_new_row]			=	idw_case.object.pmr_created_cd [ll_case_row + 1]
idw_case_log.object.pmr_created_date [ll_new_row]		=	idw_case.object.pmr_created_date [ll_case_row + 1]
idw_case_log.object.pmr_prov_type_cd [ll_new_row]		=	idw_case.object.pmr_prov_type_cd [ll_case_row + 1]
idw_case_log.object.pmr_custom1_cd [ll_new_row]			=	idw_case.object.pmr_custom1_cd [ll_case_row + 1]
idw_case_log.object.pmr_custom1_char [ll_new_row]		=	idw_case.object.pmr_custom1_char [ll_case_row + 1]
idw_case_log.object.pmr_custom1_date [ll_new_row]		=	idw_case.object.pmr_custom1_date [ll_case_row + 1]
idw_case_log.object.pmr_custom2_cd [ll_new_row]			=	idw_case.object.pmr_custom2_cd [ll_case_row + 1]
idw_case_log.object.pmr_custom3_cd [ll_new_row]			=	idw_case.object.pmr_custom3_cd [ll_case_row + 1]
idw_case_log.object.pmr_frd_rfrl_cd [ll_new_row]		=	idw_case.object.pmr_frd_rfrl_cd [ll_case_row + 1]
idw_case_log.object.pmr_acpt_cd [ll_new_row]				=	idw_case.object.pmr_acpt_cd [ll_case_row + 1]
idw_case_log.object.case_prov_spec [ll_new_row]			=	idw_case.object.case_prov_spec [ll_case_row + 1]
idw_case_log.object.pmr_custom2_char [ll_new_row]		=	idw_case.object.pmr_custom2_char [ll_case_row + 1]
idw_case_log.object.pmr_custom4_cd [ll_new_row]			=	idw_case.object.pmr_custom4_cd [ll_case_row + 1]
idw_case_log.object.pmr_custom5_cd [ll_new_row]			=	idw_case.object.pmr_custom5_cd [ll_case_row + 1]
idw_case_log.object.pmr_custom2_date [ll_new_row]		=	idw_case.object.pmr_custom2_date [ll_case_row + 1]
idw_case_log.object.pmr_custom3_date [ll_new_row]		=	idw_case.object.pmr_custom3_date [ll_case_row + 1]
//	12/14/01	GaryR	Stars 4.8.1 - End

// Update case_link
ll_rowcount	=	lds_case_link.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

FOR ll_row	=	1	TO	ll_rowcount
	ls_link_status = lds_case_link.GetItemString( ll_row, 'link_status' )
	ls_link_type	= lds_case_link.GetItemString( ll_row, 'link_type' )
	ls_link_key		= lds_case_link.GetItemString( ll_row, 'link_key' )
	ls_link_name	= lds_case_link.GetItemString( ll_row, 'link_name' )
	ls_new_link_key = ""						//	05/17/02	GaryR	Track 3010d
	lds_case_link.setItem( ll_row, 'link_status', 'R' )		// Update link_status to referred
	// Insert row for new case_ver & copy the data from the original case_link
	ll_new_row	=	lds_case_link.InsertRow(0)
	lds_case_link.setItem( ll_new_row, 'case_id', ls_case_id )
	lds_case_link.setItem( ll_new_row, 'case_spl', ls_case_spl )
	lds_case_link.setItem( ll_new_row, 'case_ver', ls_case_newver )
	lds_case_link.setItem( ll_new_row, 'link_type', lds_case_link.GetItemString( ll_row, 'link_type' ) )
	lds_case_link.setItem( ll_new_row, 'link_key', lds_case_link.GetItemString( ll_row, 'link_key' ) )
	lds_case_link.setItem( ll_new_row, 'link_name', lds_case_link.GetItemString( ll_row, 'link_name' ) )
	lds_case_link.setItem( ll_new_row, 'link_desc', lds_case_link.GetItemString( ll_row, 'link_desc' ) )
	IF	is_refer_user	=	''		THEN
		lds_case_link.setItem( ll_new_row, 'user_id', lds_case_link.GetItemString( ll_row, 'user_id' ) )
	ELSE
		lds_case_link.setItem( ll_new_row, 'user_id', is_refer_user )
	END IF
	lds_case_link.setItem( ll_new_row, 'link_date', ldtm_refer )			// Set link_date to today
	lds_case_link.setItem( ll_new_row, 'link_status', ls_link_status )	// Set to original status
	// Copy the data associated with the case_link and set the new link_key value
	CHOOSE CASE Upper(ls_link_type)
		CASE 'TGT'
			// Target - Do nothing with Target links except change case_ver
		CASE 'SUB', 'ARC'
			// Subsets - Update sub_cntl data.  No data to copy.  
			li_rc	=	This.uf_update_sub_cntl(ls_link_key)
			IF	li_rc	<	0		THEN
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
				GoTo	exit_script
			END IF
			// Subsets - Do nothing with subset links except change case_ver
		CASE 'POL', 'LTR'
			// Policy/Letter - Do nothing with subset links except change case_ver
		CASE 'PDQ', 'PDR'							// 05/28/02	GaryR	Track 2552d
			// Pre Defined Query - Copy PDQ data (including notes) and set the new query ID.
			ls_new_link_key	=	This.uf_copy_pdq(ls_link_key)
			IF	Trim(ls_new_link_key)	=	''		THEN
				li_rc	=	-1
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
				GoTo	exit_script
			END IF
			lds_case_link.setItem( ll_new_row, 'link_key', ls_new_link_key )
			IF	ls_link_key		=	ls_link_name		THEN
				lds_case_link.setItem( ll_new_row, 'link_name', ls_new_link_key )
			END IF
		CASE 'PAT'
			// Patterns - Copy Patterns data (including notes) and set the new pattern ID.
			ls_new_link_key	=	This.uf_copy_pattern(ls_link_key)
			IF	Trim(ls_new_link_key)	=	''		THEN
				li_rc	=	-1
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
				GoTo	exit_script
			END IF
			lds_case_link.setItem( ll_new_row, 'link_key', ls_new_link_key )
			IF	ls_link_key		=	ls_link_name		THEN
				lds_case_link.setItem( ll_new_row, 'link_name', ls_new_link_key )
			END IF
		CASE 'RPT', 'MED', 'RDM'
			// Reports - Do nothing with report links except change case_ver
		CASE 'CRA'
			// Analysis criteria - Copy criteria data and set the new criteria ID.
			ls_new_link_key	=	This.uf_copy_analysis_criteria(ls_link_key)
			IF	Trim(ls_new_link_key)	=	''		THEN
				li_rc	=	-1
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
				GoTo	exit_script
			END IF
			lds_case_link.setItem( ll_new_row, 'link_key', ls_new_link_key )
			IF	ls_link_key		=	ls_link_name		THEN
				lds_case_link.setItem( ll_new_row, 'link_name', ls_new_link_key )
			END IF
		CASE 'CRC'
			// Criteria - Copy criteria data and set the new criteria ID.
			ls_new_link_key	=	This.uf_copy_criteria(ls_link_key)
			IF	Trim(ls_new_link_key)	=	''		THEN
				li_rc	=	-1
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
				GoTo	exit_script
			END IF
			lds_case_link.setItem( ll_new_row, 'link_key', ls_new_link_key )
			IF	ls_link_key		=	ls_link_name		THEN
				lds_case_link.setItem( ll_new_row, 'link_name', ls_new_link_key )
			END IF
		CASE "ATT"
			//	Attachments - Copy each attachment link.
			ls_new_link_key	=	lnv_att.of_copy_cntl( ls_link_key )
			IF	Trim( ls_new_link_key )	=	''		THEN
				li_rc	=	-1
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
				GoTo	exit_script
			END IF
			
			// Set new key & name ids
			lds_case_link.setItem( ll_new_row, 'link_key', ls_new_link_key )
			IF	ls_link_key		=	ls_link_name		THEN
				lds_case_link.setItem( ll_new_row, 'link_name', ls_new_link_key )
			END IF
	END CHOOSE
	
	//	05/17/02	GaryR	Track 3010d
	//	Create a log entry for the changed link name
	IF	ls_link_key	= ls_link_name AND Trim( ls_new_link_key ) <> ""	THEN &
		This.uf_create_refer_case_log( ll_case_row + 1, ls_link_type, ls_link_name, ls_new_link_key )
NEXT

li_rc	=	lds_case_link.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_case_id + ls_case_spl + ls_case_newver + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Copy the case notes.  For the newly inserted rows, change case_ver in note_rel_id.
ll_rowcount	=	lds_notes.Retrieve( 'CA', ls_oldcase )

FOR ll_row	=	1	TO	ll_rowcount
	ls_note_id				=	lds_notes.object.note_id [ll_row]
	// Retrieve the note_text separately
	//	09/17/02	GaryR	SPR 4182c - Begin
	//ls_note_text	=	gnv_sql.of_get_note_text( ls_note_id )
	ls_note_rel_type		=	lds_notes.object.note_rel_type [ll_row]
	ls_note_rel_id			=	lds_notes.object.note_rel_id [ll_row]
	ls_note_text	=	gnv_sql.of_get_note_text( ls_note_id, ls_note_rel_type, ls_note_rel_id )
	//	09/17/02	GaryR	SPR 4182c - End
	ls_note_desc = lds_notes.object.note_desc[ll_row]	// JasonS 10/29/02 Track 2883d
   gnv_sql.of_trimData(ls_note_desc)	// JasonS 10/29/02 Track 2883d
	ls_new_note_id				=	fx_get_next_key_id('NOTE')
	ls_dept_id				=	lds_notes.object.dept_id [ll_row]
	ls_user_id				=	lds_notes.object.user_id [ll_row]
	ls_note_sub_type		=	lds_notes.object.note_sub_type [ll_row]
	ls_note_rel_id			=	ls_newcase
	ldtm_note_datetime	=	lds_notes.object.note_datetime [ll_row]
	ls_rte_ind				=	lds_notes.object.rte_ind [ll_row]
	IF	is_refer_user		>	' '		THEN
		//ls_user_id			=	is_refer_user			// Change per KayKay's request (4.8.1.014)
	END IF
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
			note_desc)	// JasonS 10/29/02 Track 2883d add note_desc
	Values (:is_refer_dept,
			:ls_user_id,
	 		:ls_note_rel_type,
			:ls_note_sub_type,
			:ls_note_rel_id,
			:ls_new_note_id,
			:ldtm_note_datetime,
			' ',
			:ls_rte_ind,
			:ls_note_desc)
	Using stars2ca;
	IF	Stars2ca.of_check_status()	<>	0		THEN
		Stars2ca.of_rollback()
		w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
		GoTo	exit_script
	END IF
	
	IF gnv_sql.of_set_note_text( ls_note_text, ls_new_note_id, ls_note_rel_type, ls_note_rel_id ) < 0 THEN
		Stars2ca.of_rollback()
		w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
		GoTo	exit_script
	END IF
	
	//	Create a log entry for the changed link name
	This.uf_create_refer_case_log( ll_case_row + 1, "NOTE", ls_note_id, ls_new_note_id )
NEXT

//	05/17/02	GaryR	Track 3010d - Begin
// Moved here from above the loop
li_rc	=	idw_case_log.Event	ue_update( TRUE, FALSE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF
//	05/17/02	GaryR	Track 3010d - End

// Copy the target rows.  For the newly inserted rows, change case_ver.
ll_rowcount	=	lds_target.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

li_rc	=	lds_target.RowsCopy ( 1, ll_rowcount, Primary!, lds_target, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_target.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_target.object.case_ver [ll_row]	=	ls_case_newver
NEXT

li_rc	=	lds_target.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Copy the target_cntl rows.  For the newly inserted rows, change case_ver.
ll_rowcount	=	lds_target_cntl.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

li_rc	=	lds_target_cntl.RowsCopy ( 1, ll_rowcount, Primary!, lds_target_cntl, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_target_cntl.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_target_cntl.object.case_ver [ll_row]	=	ls_case_newver
	lds_target_cntl.object.dept_id [ll_row]	=	is_refer_dept
	IF	is_refer_user	>	' '		THEN
		lds_target_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_target_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Copy the track rows.  For the newly inserted rows, change case_ver.
ll_rowcount	=	lds_track.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

li_rc	=	lds_track.RowsCopy ( 1, ll_rowcount, Primary!, lds_track, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_track.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_track.object.case_ver [ll_row]	=	ls_case_newver
NEXT

li_rc	=	lds_track.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Copy the track_log rows.  For the newly inserted rows, change case_ver.
ll_rowcount	=	lds_track_log.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

li_rc	=	lds_track_log.RowsCopy ( 1, ll_rowcount, Primary!, lds_track_log, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_track_log.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_track_log.object.case_ver [ll_row]	=	ls_case_newver
NEXT

li_rc	=	lds_track_log.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Copy the lead rows.  For the newly inserted rows, change case_ver.
ll_rowcount	=	lds_lead.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

li_rc	=	lds_lead.RowsCopy ( 1, ll_rowcount, Primary!, lds_lead, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_lead.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_lead.object.case_ver [ll_row]	=	ls_case_newver
	lds_lead.object.dept_id [ll_row]		=	is_refer_dept
	IF	is_refer_user	>	' '		THEN
		//lds_lead.object.user_id [ll_row]	=	is_refer_user		// Change per KayKay's request (4.8.1.014)
	END IF
NEXT

li_rc	=	lds_lead.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Change case_ver on the restore_request_part_c rows.
ll_rowcount	=	lds_restore_request.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

FOR ll_row	=	1	TO	ll_rowcount
	lds_restore_request.object.case_ver [ll_row]	=	ls_case_newver
	IF	is_refer_user	>	' '		THEN
		lds_restore_request.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_restore_request.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

// Notify the user that the case was referred.
String	ls_user,			&
			ls_next_id,		&
			ls_message

Long		ll_next_id

ls_user	=	Trim (as_refer_user)

IF	IsNull (ls_user)					&
OR	Len (ls_user)		=	0			&
OR	Upper (ls_user)	=	'NONE'	THEN
ELSE
	// The case was referred to a valid user.  Notify this person.
	ls_next_id	=	fx_get_next_key_id( 'MESSAGEID' )
	ll_next_id	=	Long (ls_next_id)
	ls_message	=	ls_newcase	+	" - Case has been referred to you from user "	+	&
						ls_olduser	+	" by user "	+	gc_user_id
	INSERT INTO USER_MESSAGE  
			  ( USER_MESSAGE_ID,   
				 USER_ID,   
				 MESSAGE_SOURCE,   
				 RTE_IND,   
				 MESSAGE_DATETIME,   
				 MESSAGE_SHORT_DESC,   
				 MESSAGE_STATUS,   
				 MESSAGE_STATUS_DATETIME,   
				 ROW_NUM,   
				 SQLDBCODE,   
				 SQLERRTEXT,   
				 SQLSYNTAX,   
				 SQLRETURNDATA,   
				 WINDOWNAME,   
				 DATAOBJECT )  
	 VALUES ( :ll_next_id,   
				 :as_refer_user,   
				 :ls_status_desc,   
				 'N',   
				 :ldtm_current,   
				 :ls_message,   
				 'A',   
				 :ldtm_current,   
				 0,   
				 0,   
				 ' ',   
				 ' ',   
				 ' ',   
				 ' ',   
				 ' ' )
	USING Stars2ca ;			 
	IF	Stars2ca.of_check_status()	<	0		THEN
		Stars2ca.of_rollback()
		w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
		GoTo	exit_script
	END IF

END IF

// Remove the "Hold Lock" case from sys_cntl
Delete from sys_cntl
	where cntl_id  = :gc_user_id and
			cntl_case = :ls_oldcase
Using Stars2ca;

If stars2ca.of_check_status() <> 0  then
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
End If

// All updates were successful, commit the changes
li_rc	=	Stars2ca.of_commit()

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_newcase + ' was not referred.'	 )
	GoTo	exit_script
END IF

w_main.SetMicroHelp( 'Case ' + ls_newcase + ' successfully referred.'	 )


exit_script:

IF	IsValid(lds_track)				THEN	Destroy lds_track

IF	IsValid(lds_track_log)			THEN	Destroy lds_track_log

IF	IsValid(lds_case_link)			THEN	Destroy lds_case_link

IF	IsValid(lds_lead)					THEN	Destroy lds_lead

IF	IsValid(lds_target)				THEN	Destroy lds_target

IF	IsValid(lds_target_cntl)		THEN	Destroy lds_target_cntl

IF	IsValid(lds_restore_request)	THEN	Destroy lds_restore_request

IF	IsValid(lds_notes)				THEN	Destroy lds_notes

Return	li_rc
end event

event type integer ue_reassign_case(string as_assign_dept, string as_assign_user, string as_old_user);////////////////////////////////////////////////////////////////////////////////
//	Script:		ue_reassign_case
//
//	Arguments:	as_assign_dept: The department that the case is being assigned to.
//					as_assign_user: The user that the case is being assigned to.
//					as_old_user: The original user that the case was assigned to.
//
//	Returns:		Integer
//					-1	=	Error
//					 1	=	Success
//
//	Description:
//		Assign the case to a new user.  Update the User ID/Department
//		in all data associated with the case.
//
//	Notes:	1. All GUI edits must occur before calling this.
//				2.	idw_case must be registered (uf_set_case_dw).
//
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/21/01	FDG	Stars 4.8.  Created
// 01/25/02 SAH	Stars 4.8.1 When the id of the user reassigning the case is
//										not specified, set ls_olduser to 'NONE' so the
//										User Message window display's 'NONE', not blank.
// 05/28/02	GaryR	Track 2552d Predefined Report (PDR)
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	01/07/05	GaryR	Track 7184c	Remove obsolete code
//	03/05/07	GaryR	Track 4932	Remove references to the obsolete MESSAGE_TEXT column
//
////////////////////////////////////////////////////////////////////////////////

Boolean		lb_referral

String		ls_case_id,				&
				ls_case_spl,			&
				ls_case_ver,			&
				ls_case_newver,		&
				ls_oldcase,				&
				ls_olduser,				&
				ls_newcase,				&
				ls_case_cat,			&
				ls_link_status,		&
				ls_link_type,			&
				ls_link_key,			&
				ls_link_name,			&
				ls_new_link_key,		&
				ls_status_desc,		&
				ls_dept_id,				&
				ls_user_id,				&
				ls_note_id,				&
				ls_rte_ind

Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount,		&
				ll_case_row

Integer		li_rc,					&
				li_refer_rc

Date			ldt_init

DateTime		ldtm_refer,				&
				ldtm_current,			&
				ldtm_init,				&
				ldtm_note_datetime,	&
				ldtm_date
				
n_ds			lds_case_link,			&
				lds_target_cntl,		&
				lds_restore_request
				
Constant	String	lcs_referred	=	'REFERRED'

w_main.SetMicroHelp( 'Updating the Case.  Please wait...' )

// Get the case ID
ll_case_row		=	idw_case.GetRow()

ls_case_id		=	idw_case.object.case_id [ll_case_row]
ls_case_spl		=	idw_case.object.case_spl [ll_case_row]
ls_case_ver		=	idw_case.object.case_ver [ll_case_row]
ls_oldcase		=	ls_case_id	+	ls_case_spl	+	ls_case_ver
ls_olduser		=	idw_case.object.case_asgn_id [ll_case_row]

// SAH 02/25/02 -Begin
//ls_olduser		=	idw_case.object.case_asgn_id [ll_case_row]
IF idw_case.object.case_asgn_id[ll_case_row] = ' ' THEN
	ls_olduser = 'NONE' 
ELSE
	ls_olduser = idw_case.object.case_asgn_id[ll_case_row]
END IF

// SAH 01/25/02 -End

//	Initialize data
ldtm_refer		=	gnv_app.of_get_server_date_time()
ldtm_current	=	gnv_app.of_get_server_date_time()
ldtm_init		=	DateTime( Date( 1900, 01, 01 ) )
ldt_init			=	Date( 1900, 01, 01 )

as_assign_dept	=	Upper ( Trim(as_assign_dept) )

// Determine if the user ID was specified.
as_assign_user	=	Upper ( Trim(as_assign_user) )
as_old_user		=	Upper ( Trim(as_old_user) )

IF	IsNull(as_assign_user)		&
OR	as_assign_user	=	''			&
OR	as_assign_user	=	'NONE'	THEN
	as_assign_user	=	' '
END IF

IF	IsNull(as_old_user)		&
OR	as_old_user	=	''			&
OR	as_old_user	=	'NONE'	THEN
	as_old_user	=	' '
END IF

is_refer_user	=	as_assign_user
is_refer_dept	=	as_assign_dept

// Create the datastores

lds_case_link	=	CREATE	n_ds
lds_case_link.DataObject = 'd_case_link_case'
li_rc = lds_case_link.SetTransObject(Stars2ca)

lds_target_cntl	=	CREATE	n_ds
lds_target_cntl.DataObject = 'd_case_target_cntl_list'
li_rc = lds_target_cntl.SetTransObject(Stars2ca)

lds_restore_request	=	CREATE	n_ds
lds_restore_request.DataObject = 'd_case_restore_request_part_c_list'
li_rc = lds_restore_request.SetTransObject(Stars2ca)

// Update case_link
ll_rowcount	=	lds_case_link.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

FOR ll_row	=	1	TO	ll_rowcount
	ls_link_status = lds_case_link.GetItemString( ll_row, 'link_status' )
	ls_link_type	= lds_case_link.GetItemString( ll_row, 'link_type' )
	ls_link_key		= lds_case_link.GetItemString( ll_row, 'link_key' )
	ls_link_name	= lds_case_link.GetItemString( ll_row, 'link_name' )
	IF	is_refer_user	>	' '		THEN
		lds_case_link.setItem( ll_row, 'user_id', is_refer_user )
	END IF
	// Update the data associated with the case_link 
	CHOOSE CASE Upper(ls_link_type)
		CASE 'TGT'
			// Target - Do nothing with Target links 
		CASE 'SUB', 'ARC'
			// Subsets - Do nothing with subset links 
		CASE 'POL', 'LTR'
			// Policy/Letter - Do nothing with these links 
		CASE 'SUB', 'ARC'
			// Subsets - Update sub_cntl data  
			li_rc	=	This.uf_update_sub_cntl(ls_link_key)
			IF	li_rc	<	0		THEN
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.'	 )
				GoTo	exit_script
			END IF
		CASE 'PDQ', 'PDR'					// 05/28/02	GaryR	Track 2552d
			// Pre Defined Query - Update PDQ data (including notes) 
			li_rc	=	This.uf_update_pdq(ls_link_key)
			IF	li_rc	<	0		THEN
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.'	 )
				GoTo	exit_script
			END IF
		CASE 'PAT'
			// Patterns - Update Patterns data (including notes) 
			li_rc	=	This.uf_update_pattern(ls_link_key)
			IF	li_rc	<	0		THEN
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.'	 )
				GoTo	exit_script
			END IF
		CASE 'RPT', 'MED', 'RDM'
			// Reports - Do nothing with report links
		CASE 'CRA'
			// Analysis criteria - Update criteria data 
			li_rc	=	This.uf_update_analysis_criteria(ls_link_key)
			IF	li_rc	<	0		THEN
				Stars2ca.of_rollback()
				w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.'	 )
				GoTo	exit_script
			END IF
		CASE 'CRC'
			// Criteria - No data to update
	END CHOOSE
NEXT

li_rc	=	lds_case_link.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.'	 )
	GoTo	exit_script
END IF

// Update the target_cntl rows.  
ll_rowcount	=	lds_target_cntl.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

FOR ll_row	=	1	TO	ll_rowcount
	lds_target_cntl.object.dept_id [ll_row]	=	is_refer_dept
	IF	is_refer_user	>	' '		THEN
		lds_target_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_target_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.'	 )
	GoTo	exit_script
END IF

// Update the restore_request_part_c rows.
ll_rowcount	=	lds_restore_request.Retrieve( ls_case_id, ls_case_spl, ls_case_ver )

FOR ll_row	=	1	TO	ll_rowcount
	IF	is_refer_user	>	' '		THEN
		lds_restore_request.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_restore_request.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.' )
	GoTo	exit_script
END IF

// Notify the user that the user ID was changed.
String	ls_user,			&
			ls_next_id,		&
			ls_message

Long		ll_next_id

ls_user	=	Trim (as_assign_user)

IF	IsNull (ls_user)						&
OR	Len (ls_user)		=	0				&
OR	Upper (ls_user)	=	'NONE'		&
OR	as_assign_user		=	gc_user_id	THEN
ELSE
	// The case was referred to a valid user.  Notify this person.
	ls_next_id	=	fx_get_next_key_id( 'MESSAGEID' )
	ll_next_id	=	Long (ls_next_id)
	ls_message	=	ls_oldcase	+	" - Case has been assigned to you from user "	+	&
						as_old_user	+	" by user "	+	gc_user_id
	INSERT INTO USER_MESSAGE  
			  ( USER_MESSAGE_ID,   
				 USER_ID,   
				 MESSAGE_SOURCE,   
				 RTE_IND,   
				 MESSAGE_DATETIME,   
				 MESSAGE_SHORT_DESC,   
				 MESSAGE_STATUS,   
				 MESSAGE_STATUS_DATETIME,   
				 ROW_NUM,   
				 SQLDBCODE,   
				 SQLERRTEXT,   
				 SQLSYNTAX,   
				 SQLRETURNDATA,   
				 WINDOWNAME,   
				 DATAOBJECT )  
	 VALUES ( :ll_next_id,   
				 :as_assign_user,   
				 'CASE ASSIGNMENT',   
				 'N',   
				 :ldtm_current,   
				 :ls_message,   
				 'A',   
				 :ldtm_current,   
				 0,   
				 0,   
				 ' ',   
				 ' ',   
				 ' ',   
				 ' ',   
				 ' ' )
	USING Stars2ca ;			 
	IF	Stars2ca.of_check_status()	<	0		THEN
		Stars2ca.of_rollback()
		w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.' )
		GoTo	exit_script
	END IF

END IF


// All updates were successful, commit the changes
li_rc	=	Stars2ca.of_commit()

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( 'Case ' + ls_oldcase + ' was not updated.' )
	GoTo	exit_script
END IF

exit_script:
IF	IsValid(lds_case_link)			THEN	Destroy lds_case_link
IF	IsValid(lds_target_cntl)		THEN	Destroy lds_target_cntl
IF	IsValid(lds_restore_request)	THEN	Destroy lds_restore_request

Return	li_rc
end event

public function string uf_get_default_contractor ();//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_get_default_contractor
//
//	Arguments:	None
//
//	Returns:		String
//
//	Description:
//				This script gets the default contractor ID from sys_cntl.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	01/14/01	Stars 4.6 (PIMR).  Created.
//	GaryR	03/12/03	Track 3479d	Check for nulls and trim value
//
//////////////////////////////////////////////////////////////////

String	ls_contractor_id

Select	cntl_case
Into		:ls_contractor_id
From		sys_cntl
Where		cntl_id	=	'DFLTCTRR'
Using		Stars2ca;

Stars2ca.of_check_status()

IF IsNull( ls_contractor_id ) THEN	ls_contractor_id = ""
gnv_sql.of_trimdata( ls_contractor_id )

Return	ls_contractor_id

end function

public function string uf_copy_analysis_criteria (string as_crit_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_copy_analysis_criteria
//
//	Arguments:	as_crit_id: The original criteria id
//
//	Returns:		String - The new criteria ID
//					""	=	Error
//
//	Description:
//		This function is called when a case is being referred.
//		This function will copy an existing criteria to create a new criteria.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	08/28/01	FDG	Stars 4.8.1  Created
//
////////////////////////////////////////////////////////////////////////////////

String		ls_new_crit_id
				
Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount

Integer		li_rc

DateTime		ldtm_current
				
n_ds			lds_anal_crit_cntl,	&
				lds_anal_crit_line,	&
				lds_anal_crit_sort

//	Initialize data
ls_new_crit_id	=	fx_get_next_key_id('CRITERIA')

ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_anal_crit_cntl	=	CREATE	n_ds
lds_anal_crit_cntl.DataObject = 'd_anal_crit_cntl'
li_rc = lds_anal_crit_cntl.SetTransObject(Stars2ca)

lds_anal_crit_line	=	CREATE	n_ds
lds_anal_crit_line.DataObject = 'd_anal_crit_line'
li_rc = lds_anal_crit_line.SetTransObject(Stars2ca)

lds_anal_crit_sort	=	CREATE	n_ds
lds_anal_crit_sort.DataObject = 'd_anal_crit_sort'
li_rc = lds_anal_crit_sort.SetTransObject(Stars2ca)


// Copy the anal_crit_cntl rows.  For the newly inserted rows, change the rept_id.
ll_rowcount	=	lds_anal_crit_cntl.Retrieve( as_crit_id )

li_rc	=	lds_anal_crit_cntl.RowsCopy ( 1, ll_rowcount, Primary!, lds_anal_crit_cntl, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_anal_crit_cntl.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_anal_crit_cntl.object.crit_id [ll_row]	=	ls_new_crit_id
	lds_anal_crit_cntl.object.dept_id [ll_row]	=	is_refer_dept
	IF	is_refer_user	>	' '		THEN
		lds_anal_crit_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_anal_crit_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_crit_id	=	''
	GoTo	exit_script
END IF


// Copy the anal_crit_line rows.  For the newly inserted rows, change the crit_id.
ll_rowcount	=	lds_anal_crit_line.Retrieve( as_crit_id )

li_rc	=	lds_anal_crit_line.RowsCopy ( 1, ll_rowcount, Primary!, lds_anal_crit_line, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_anal_crit_line.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_anal_crit_line.object.crit_id [ll_row]	=	ls_new_crit_id
NEXT

li_rc	=	lds_anal_crit_line.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_crit_id	=	''
	GoTo	exit_script
END IF

// Copy the anal_crit_sort rows.  For the newly inserted rows, change the crit_id.
ll_rowcount	=	lds_anal_crit_sort.Retrieve( as_crit_id )

li_rc	=	lds_anal_crit_sort.RowsCopy ( 1, ll_rowcount, Primary!, lds_anal_crit_sort, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_anal_crit_sort.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_anal_crit_sort.object.crit_id [ll_row]	=	ls_new_crit_id
NEXT

li_rc	=	lds_anal_crit_sort.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_crit_id	=	''
	GoTo	exit_script
END IF



exit_script:

IF	IsValid(lds_anal_crit_cntl)		THEN	Destroy lds_anal_crit_cntl

IF	IsValid(lds_anal_crit_line)		THEN	Destroy lds_anal_crit_line

IF	IsValid(lds_anal_crit_sort)		THEN	Destroy lds_anal_crit_sort



Return	ls_new_crit_id
end function

public function boolean uf_edit_case_closed (string as_link_key, string as_link_type);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_closed
//
//	Arguments:	1.	as_link_key - Key to the table associated with the case_link
//					2. as_link_type
//						PDQ - Pre-Defined Query
//						PAT - Pattern
//						SUB/ARC - Subset
//						RPT/MED/RDM - Report
//						CRC/CRA - Criteria
//						TGT - Case Target
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not closed/deleted.
//					FALSE	=	Edit failed - case was closed/deleted.
//
//	Description:
//		This script determines if a case was closed or deleted based
//		on the case_link data passed.  To do this the following must
//		occur:
//		1. Retrieve all case_link rows associated with the parms.
//			Multiple rows could be retrieved if the case was referred.
//			Subsets can also be linked to multiple cases.
//		2. For each case_link, determine if the case is closed.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/20/01	Stars 4.8.1  Created.
//	09/14/07 Katie SPR 5174 Made adjustment for CA notes to call uf_edit_case_deleted function.
//
//////////////////////////////////////////////////////////////////

String	ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver

Long		ll_row,				&
			ll_rowcount

Boolean	lb_valid

n_ds	lds_case_link

lds_case_link	=	CREATE	n_ds
lds_case_link.DataObject	=	'd_case_link_link_type'
lds_case_link.SetTransobject (Stars2ca)


// Retrieve the case_link rows for this subset.
ll_rowcount	=	lds_case_link.Retrieve (as_link_key, as_link_type)

IF	ll_rowcount	<	1		THEN
	Destroy	lds_case_link
	Return	TRUE
END IF

// For each case, determine if it is closed or deleted.

FOR ll_row	=	1	TO	ll_rowcount
	ls_case_id	=	lds_case_link.object.case_id [ll_row]
	ls_case_spl	=	lds_case_link.object.case_spl [ll_row]
	ls_case_ver	=	lds_case_link.object.case_ver [ll_row]
	lb_valid		=	This.uf_edit_case_deleted( ls_case_id, ls_case_spl, ls_case_ver )
	IF	lb_valid	=	FALSE		THEN
		// Case is closed.  Return false.
		Destroy	lds_case_link
		Return	lb_valid
	END IF
NEXT

Destroy	lds_case_link

Return	TRUE



end function

public function boolean uf_edit_case_closed_subset (string as_subset_id);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_closed_subset
//
//	Arguments:	1.	as_subset_id
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not closed/deleted.
//					FALSE	=	Edit failed - case was closed/deleted.
//
//	Description:
//		This script determines if a case was closed or deleted based
//		on the subset ID passed.  To do this the following must
//		occur:
//		1. Retrieve all case_link rows associated with the subset.
//			Multiple rows could be retrieved if the case was referred.
//		2. For each case_link, determine if the case is closed.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/10/01	Stars 4.8.1  Created.
//
//////////////////////////////////////////////////////////////////

String	ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver

Long		ll_row,				&
			ll_rowcount

Boolean	lb_valid

n_ds	lds_case_link

lds_case_link	=	CREATE	n_ds
lds_case_link.DataObject	=	'd_case_link_subset'
lds_case_link.SetTransobject (Stars2ca)


// Retrieve the case_link rows for this subset.
ll_rowcount	=	lds_case_link.Retrieve (as_subset_id)

IF	ll_rowcount	<	1		THEN
	Destroy	lds_case_link
	Return	TRUE
END IF

// For each case, determine if it is closed or deleted.

FOR ll_row	=	1	TO	ll_rowcount
	ls_case_id	=	lds_case_link.object.case_id [ll_row]
	ls_case_spl	=	lds_case_link.object.case_spl [ll_row]
	ls_case_ver	=	lds_case_link.object.case_ver [ll_row]
	lb_valid		=	This.uf_edit_case_closed( ls_case_id, ls_case_spl, ls_case_ver )
	IF	lb_valid	=	FALSE		THEN
		// Case is closed.  Return false.
		Destroy	lds_case_link
		Return	lb_valid
	END IF
NEXT

Destroy	lds_case_link

Return	TRUE



end function

public function integer uf_update_analysis_criteria (string as_crit_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_update_analysis_criteria
//
//	Arguments:	as_crit_id - Criteria ID to update
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:
//		This function is called when a case is assigned to a new user.
//
//		This function will update anal_crit_cntl with the user_id/dept_id.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/21/01	FDG	Stars 4.8.1  Created
//
////////////////////////////////////////////////////////////////////////////////
				
Long			ll_row,					&
				ll_rowcount

Integer		li_rc

DateTime		ldtm_current
				
n_ds			lds_anal_crit_cntl

//	Initialize data
ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_anal_crit_cntl	=	CREATE	n_ds
lds_anal_crit_cntl.DataObject = 'd_anal_crit_cntl'
li_rc = lds_anal_crit_cntl.SetTransObject(Stars2ca)

// Retrieve the anal_crit_cntl rows.  
ll_rowcount	=	lds_anal_crit_cntl.Retrieve( as_crit_id )

FOR ll_row	=	1	TO	ll_rowcount
	lds_anal_crit_cntl.object.dept_id [ll_row]	=	is_refer_dept
	IF	is_refer_user	>	' '		THEN
		lds_anal_crit_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_anal_crit_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	li_rc	=	-1
	GoTo	exit_script
END IF


exit_script:

IF	IsValid(lds_anal_crit_cntl)		THEN	Destroy lds_anal_crit_cntl


Return	li_rc

end function

public function integer uf_update_sub_cntl (string as_subc_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_update_sub_cntl
//
//	Arguments:	as_subc_id: The original report id
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:
//		This function is called when a case is assigned to a new user.
//
//		This function will update sub_cntl with the user_id/dept_id.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/21/01	FDG	Stars 4.8.1  Created
//
////////////////////////////////////////////////////////////////////////////////
				
Long			ll_row,					&
				ll_rowcount

Integer		li_rc

DateTime		ldtm_current
				
n_ds			lds_sub_cntl

//	Initialize data
ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_sub_cntl	=	CREATE	n_ds
lds_sub_cntl.DataObject = 'd_case_sub_cntl'
li_rc = lds_sub_cntl.SetTransObject(Stars2ca)


// Copy the report_cntl rows.  For the newly inserted rows, change the rept_id.
ll_rowcount	=	lds_sub_cntl.Retrieve( as_subc_id )

FOR ll_row	=	1	TO	ll_rowcount
	lds_sub_cntl.object.dept_id [ll_row]	=	is_refer_dept
	IF	is_refer_user	>	' '		THEN
		lds_sub_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_sub_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	GoTo	exit_script
END IF


exit_script:

IF	IsValid(lds_sub_cntl)		THEN	Destroy lds_sub_cntl


Return	li_rc

end function

public function integer uf_audit_log (string as_case, string as_message);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_audit_log - Overloaded function
//
//	Arguments:	1.	as_case
//					2.	as_message
//
//	Returns:		Integer.	1 = success, -1 = error
//
//	Description:
//		This script will insert a case_log entry based on an event
//		that occurred.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	10/11/01	Stars 4.8.1.  Created.
//
//////////////////////////////////////////////////////////////////

String		ls_case_id,			&
				ls_case_spl,		&
				ls_case_ver

ls_case_id	=	Left (as_case, 10)
ls_case_spl	=	Mid  (as_case, 11, 2)
ls_case_ver	=	Mid  (as_case, 13, 2)


Return	This.uf_audit_log (ls_case_id, ls_case_spl, ls_case_ver, as_message)



end function

public function integer uf_audit_log (string as_link_key, string as_link_type, string as_message);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_audit_log
//
//	Arguments:	1.	as_link_key
//					2.	as_link_type
//					3.	as_message
//
//////////////////////////////////////////////////////////////////
//
//	FDG	10/11/01	Stars 4.8.1.	Created
//	Katie	03/05/07	SPR 4934 Added support for PQ type notes also being PDRs.
//
//////////////////////////////////////////////////////////////////


String	ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver

Long		ll_row,				&
			ll_rowcount

Boolean	lb_valid

Integer	li_rc

// Edit the input
IF	Trim (as_link_type)	=	''		THEN
	// Case link.  as_link_key is the case.
	Return	This.uf_audit_log ( as_link_key, as_message )
END IF


n_ds	lds_case_link

lds_case_link	=	CREATE	n_ds
lds_case_link.DataObject	=	'd_case_link_link_type'
lds_case_link.SetTransobject (Stars2ca)


// Retrieve the case_link rows for this subset.
ll_rowcount	=	lds_case_link.Retrieve (as_link_key, as_link_type)

IF	ll_rowcount	<	1	and as_link_type = 'PDQ'	THEN
	ll_rowcount	=	lds_case_link.Retrieve (as_link_key, 'PDR')	
end if

IF	ll_rowcount	<	1		THEN
	IF	as_link_type	=	'CA'		THEN
		li_rc			=	This.uf_audit_log ( as_link_key, as_message )
		IF	li_rc	<	0		THEN
			// Error occured
			Stars2ca.of_rollback()
			MessageBox ('Database error', 'Could not add a case log for case ' + as_link_key + &
							' with link type ' + as_link_type + '.  Script: n_cst_case.uf_audit_log.')
		END IF
		Destroy	lds_case_link
		Return	li_rc

	ELSE
		MessageBox ('Database error', 'Could not retrieve case_link ' + &
						' with link '	+	as_link_key + &
						' and link type ' + as_link_type + '.  Script: n_cst_case.uf_audit_log.')
		Destroy	lds_case_link
		Return	-1
	END IF
END IF

// For each case, determine if it is closed or deleted.

FOR ll_row	=	1	TO	ll_rowcount
	ls_case_id	=	lds_case_link.object.case_id [ll_row]
	ls_case_spl	=	lds_case_link.object.case_spl [ll_row]
	ls_case_ver	=	lds_case_link.object.case_ver [ll_row]
	li_rc			=	This.uf_audit_log ( ls_case_id, ls_case_spl, ls_case_ver, as_message )
	IF	li_rc	<	0		THEN
		// Error occured
		Stars2ca.of_rollback()
		MessageBox ('Database error', 'Could not add a case log for case ' + ls_case_id + &
						ls_case_spl + ls_case_ver + ' with link '	+	as_link_key + &
						' and link type ' + as_link_type + '.  Script: n_cst_case.uf_audit_log.')
		Destroy	lds_case_link
		Return	-1
	END IF
NEXT

Destroy	lds_case_link

Return	1



end function

public function string uf_edit_case_security (string as_case_cat);//n_cst_case::uf_edit_case_security()
//	Description:
//	This function uses the passed case category to determine 
//	if this user has security to process this case.  
//	This function will return an error message to the calling script.

int li_security
long ll_rowcount
long ll_row
string ls_msg
string ls_find
string ls_dept

IF Trim(as_case_cat) = '' OR IsNull(as_case_cat) THEN
	Ls_msg  =  'Case category not provided. Cannot verify case security'
	return ls_msg
END IF

// Find the case category in ids_code
ll_rowcount  =  ids_code.RowCount()
ls_find  =  "code_code = '"  +  as_case_cat  + "'"
ll_row  =  ids_code.Find (ls_find, 1, ll_rowcount)

IF ll_row  <  1  THEN
	Return 'Cannot find case category'  
END IF

// Get the department and security level for this case category.
Ls_dept  =  ids_code.object.code_value_a [ll_row]
Li_security  = ids_code.object.code_value_n [ll_row]

IF  ls_dept  <>  gc_user_dept  THEN
	IF li_security  =  1  THEN
		Ls_msg = 'This is a secure case. You have insufficient '+&
					'~rprivileges for this case'
	END IF
END IF

Return  ls_msg

end function

public function string uf_edit_case_security (string as_case_id, string as_case_spl, string as_case_ver);//n_cst_case::uf_edit_security
//	This overloaded function uses the passed case id 
//	to determine if this user has security to process this case.  
//	This function will return an error message to the calling script. 
/////////////////////////////////////////////////////////////////////

int li_check_status
string ls_msg
string ls_case_cat

// If case = 'None'  get out
IF Upper ( Trim(as_case_id))  =  'NONE'  THEN
	Return  ''
END IF

IF  Trim(as_case_id)  =  '' OR IsNull(as_case_id) THEN
	Ls_msg  =  'Case ID not provided.  Cannot verify case security'
	return ls_msg
END IF

// Get the case category for this case
Select case_cat
Into  :ls_case_cat
From case_cntl
Where case_id  =  Upper( :as_case_id )
And case_spl  =  Upper( :as_case_spl )
And case_ver  =  Upper( :as_case_ver )
Using  Stars2ca;

li_check_status = Stars2ca.of_check_status()  
IF li_check_status <> 0  THEN
	if li_check_status = 100 then
		return 'Invalid Case ID'
	else
		Return 'Cannot find case category'  
	end if
END IF

// Get the department and security level for this case category.  
//	The overloaded function is called
// for performance reasons in case security 
//	must be checked for multiple cases.

Return  This.uf_edit_case_security(ls_case_cat)

end function

public function string uf_edit_case_security_user (string as_case_cat, string as_userid);////////////////////////////////////////////////////////////////////////
//	Script:		n_cst_case.uf_edit_case_security_user
//
//	Arguments:	1.	as_case_cat
//					2.	as_userid
//
//	Returns:		String - Error message if an error occurs.
//
//	Description:
//	This function uses the passed case category & user to determine 
//	if the user has security to process this case.  
//	This function will return an error message to the calling script.
//
////////////////////////////////////////////////////////////////////////
//	History
//	
//	FDG	11/14/01	Stars 4.8.1.	Created.
// MikeF	07/09/02 SD3189	Altered message for secured case referral	
//
////////////////////////////////////////////////////////////////////////


int		li_security
long		ll_rowcount
long		ll_row
string	ls_msg
string	ls_find
string	ls_dept,				&
			ls_user_dept

IF Trim(as_case_cat) = '' OR IsNull(as_case_cat) THEN
	ls_msg  =  'Case category not provided. Cannot verify case security'
	return ls_msg
END IF

as_userid	=	Upper(as_userid)

IF Trim(as_userid) = '' OR IsNull(as_userid)	OR	Trim(as_userid) = 'NONE'  THEN
	// No user ID - get out (with success)
	return ''
END IF

// Find the case category in ids_code
ll_rowcount  =  ids_code.RowCount()
ls_find  =  "code_code = '"  +  as_case_cat  + "'"
ll_row  =  ids_code.Find (ls_find, 1, ll_rowcount)

IF ll_row  <  1  THEN
	Return 'Cannot find case category'  
END IF

// Get the department and security level for this case category.
ls_dept  	=  ids_code.object.code_value_a [ll_row]
li_security	=	ids_code.object.code_value_n [ll_row]

// Get the department of the user
Select	user_dept
  Into	:ls_user_dept
  From	users
 Where	user_id	=	:as_userid
 Using	Stars2ca;

If Stars2ca.of_check_status() = 100 then 
	Return	'User ID '	+	as_userid	+	'not found.'
Elseif stars2ca.sqlcode <> 0 then
	Return	'Error retrieving User ID '	+	as_userid	+	'.'
End If

// Have all needed data.  Check for security.
IF ls_dept  <>  ls_user_dept  THEN
	IF li_security  =  1  THEN
		// MikeFl 7/9/02 - Begin
		// ls_msg = 'This is a secure case. You have insufficient '	+	&
		//			'~rprivileges for this case'
		ls_msg = 'This case is secured and cannot be referred.'	+	&
					'~rTo refer this case, first change the case category to an unsecured '		+	&
					'category, then reprocess the referral.'
		// MikeFl 7/9/02 - End
	END IF
END IF

Return  ls_msg

end function

public subroutine uf_set_case_dw (datawindow adw);//This function will register the case_cntl datawindow to this NVO.  
//Even though this function declaration has adw 
//being passed by value, it will actually be passed by 
//reference because adw is a "complex" data type.  
//This means that any activities that are performed on idw_case 
//will actually occur on the actual datawindow displayed on the window.
//This datawindow assumes that d_case_general is the datawindow object

idw_case  =  adw

end subroutine

public subroutine uf_set_track_dw (datawindow adw);//This function will register the track datawindow to this NVO.  
//Even though this function declaration will have adw being passed by value, 
//it will actually be passed by reference because adw is a "complex" data type.  
//This means that any activities that are performed on idw_track will 
//actually occur on the actual datawindow displayed on the window.
//This datawindow assumes that d_case_track_list is the datawindow object.

idw_track  =  adw
end subroutine

public subroutine uf_set_case_log_dw (datawindow adw);// FDG	09/20/01	Stars 4.8.1.	Created

//This function will register the case_log datawindow to this NVO.  
//Even though this function declaration has adw 
//being passed by value, it will actually be passed by 
//reference because adw is a "complex" data type.  
//This means that any activities that are performed on idw_case_log 
//will actually occur on the actual datawindow displayed on the window.
//This datawindow assumes that d_case_log is the datawindow object

idw_case_log  =  adw

end subroutine

public subroutine uf_set_case_log_display_dw (datawindow adw);//////////////////////////////////////////////////////////////////////////////
//This function will register the case_log display datawindow to this NVO.  
//Even though this function declaration has adw 
//being passed by value, it will actually be passed by 
//reference because adw is a "complex" data type.  
//This means that any activities that are performed on idw_case_log 
//will actually occur on the actual datawindow displayed on the window.
//This datawindow assumes that the dynamic datawindow is the datawindow object
//
/////////////////////////////////////////////////////////////////////////////////
// History:
//
// SAH 03/04/02  Created
//
/////////////////////////////////////////////////////////////////////////////////


idw_display_log  =  adw
end subroutine

public function integer uf_format_elem_desc (datastore ads);//n_cst_case::uf_format_elem()
//Description:
//This function is called after the data is retrieved from datastore.
//Remove the '/' and everything to the right from elem_desc
///////////////////////////////////////////////////////////////

long ll_rowcount
long ll_row
string ls_desc
integer li_pos

ll_rowcount = ads.RowCount()

if ll_rowcount < 1 then
	return -1
end if

FOR ll_row = 1 TO ll_rowcount
   Ls_desc = ads.object.elem_desc [ll_row]
   Li_pos = Pos (ls_desc, '/')
   IF li_pos = 0  &
   OR li_pos > 16  THEN
      Li_pos = 16
   END IF
   // Get the description to left of '/' or the 1st 15 bytes
   Ls_desc = Left ((ls_desc), li_pos - 1)
   ads.object.elem_desc [ll_row] = ls_desc
NEXT

return 1
end function

public function integer uf_undo_case_log_nulls ();////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_undo_case_log_nulls
//
//	Arguments:	None
//
//	Returns:		Integer.		1=success, -1=error
//
//	Description:
//		This function is loop through every row in case_log.  If each column's
//		numeric/date value is null, set it to an initial value.
//
//	Note:	idw_case_log must be registered before invoking this function.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	10/15/01	FDG	Stars 4.8.1  Created
//
////////////////////////////////////////////////////////////////////////////////

Datetime		ldtm_null,		&
				ldtm_init,		&
				ldtm_value

Long			ll_null,			&
				ll_row,			&
				ll_rowcount,	&
				ll_value

Integer		li_col,			&
				li_colcount

Decimal		ldc_null,		&
				ldc_value

String		ls_coltype[],	&
				ls_colname[],	&
				ls_describe

ldtm_init	=	DateTime ( Date('1/1/1900') )

SetNull(ldtm_null)

SetNull(ll_null)

SetNull(ldc_null)

// Loop through each column to determine each column's datatype.
// Do this before looping through each row because Describe() is
// an expensive operation and there are many columns.

li_colcount	=	Integer ( idw_case_log.object.DataWindow.Column.Count )

IF	li_colcount	<	1		THEN
	Return	0
END IF

FOR li_col = 1 TO li_colcount
	// Get the column name
	ls_describe	=	"#"	+	String(li_col)	+	".Name"
	ls_colname [li_col]	=	idw_case_log.Describe (ls_describe)
	// Get the column's data type (1st 4 bytes) for this column
	ls_describe	=	ls_colname [li_col]	+	".ColType"
	ls_coltype [li_col]	=	Upper ( idw_case_log.Describe (ls_describe) )
	ls_coltype [li_col]	=	Left (ls_coltype [li_col], 4)
NEXT

// Loop through each row

ll_rowcount	=	idw_case_log.RowCount()

FOR ll_row	=	1 TO ll_rowcount
	FOR li_col = 1 TO li_colcount
		CHOOSE CASE	ls_coltype [li_col]
			CASE	'DATE'
				ldtm_value	=	idw_case_log.GetItemDateTime (ll_row, li_col)
				IF	IsNull (ldtm_value)	THEN
					idw_case_log.SetItem (ll_row, li_col, ldtm_init)
				END IF
			CASE	'DECI'
				ldc_value	=	idw_case_log.GetItemDecimal (ll_row, li_col)
				IF	IsNull (ldc_value)	THEN
					idw_case_log.SetItem (ll_row, li_col, 0)
				END IF
			CASE	'LONG'
				ll_value		=	idw_case_log.GetItemNumber (ll_row, li_col)
				IF	IsNull (ll_value)	THEN
					idw_case_log.SetItem (ll_row, li_col, 0)
				END IF
		END CHOOSE
		idw_case_log.SetItemStatus (ll_row, 0, Primary!, NotModified!)
	NEXT
NEXT

Return	1



end function

public function integer uf_update_pattern (string as_patt_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_update_pattern
//
//	Arguments:	as_patt_id - Pattern ID to update
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:
//		This function is called when a case is assigned to a new user.
//
//		This function will update the patterns notes with the user_id/dept_id.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/21/01	FDG	Stars 4.8.1  Created
//
////////////////////////////////////////////////////////////////////////////////

n_cst_string	lnv_string			// Autoinstantiated

String		ls_note_id

Long			ll_row,					&
				ll_rowcount

Integer		li_rc

DateTime		ldtm_current
				
n_ds			lds_notes

//	Initialize data
ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_notes	=	CREATE	n_ds
lds_notes.DataObject = 'd_notes'
li_rc = lds_notes.SetTransObject(Stars2ca)

// Update the pattern notes.  
// FDG 12/06/01 - Don't do Notes per KayKay
//ll_rowcount	=	lds_notes.Retrieve( 'PA', as_patt_id )
//
//FOR ll_row	=	1	TO	ll_rowcount
//	lds_notes.object.dept_id [ll_row]	=	is_refer_dept
//	IF	is_refer_user	>	' '		THEN
//		lds_notes.object.user_id [ll_row]	=	is_refer_user
//	END IF
//NEXT
//
//li_rc	=	lds_notes.Event	ue_update( TRUE, TRUE )	
//
//IF	li_rc	<	0		THEN
//	li_rc	=	-1
//	GoTo	exit_script
//END IF


//exit_script:

IF	IsValid(lds_notes)				THEN	Destroy lds_notes

Return	li_rc

end function

public function string uf_copy_criteria (string as_by_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_copy_criteria
//
//	Arguments:	as_by_id: The original criteria id
//
//	Returns:		String - The new criteria ID
//					""	=	Error
//
//	Description:
//		This function is called when a case is being referred.
//		This function will copy an existing criteria to create a new criteria.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	08/28/01	FDG	Stars 4.8.  Created
//
////////////////////////////////////////////////////////////////////////////////

String		ls_new_by_id
				
Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount

Integer		li_rc

DateTime		ldtm_current
				
n_ds			lds_criteria_used,				&
				lds_criteria_from_tbl_used,	&
				lds_criteria_used_line

//	Initialize data
ls_new_by_id	=	fx_get_next_key_id('CRITERIA')

ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_criteria_used	=	CREATE	n_ds
lds_criteria_used.DataObject = 'd_criteria_used_by_id'
li_rc = lds_criteria_used.SetTransObject(Stars2ca)

lds_criteria_from_tbl_used	=	CREATE	n_ds
lds_criteria_from_tbl_used.DataObject = 'd_criteria_from_tbls_used_by_id'
li_rc = lds_criteria_from_tbl_used.SetTransObject(Stars2ca)

lds_criteria_used_line	=	CREATE	n_ds
lds_criteria_used_line.DataObject = 'd_criteria_used_line_by_id'
li_rc = lds_criteria_used_line.SetTransObject(Stars2ca)


// Copy the anal_crit_cntl rows.  For the newly inserted rows, change the rept_id.
ll_rowcount	=	lds_criteria_used.Retrieve( as_by_id )

li_rc	=	lds_criteria_used.RowsCopy ( 1, ll_rowcount, Primary!, lds_criteria_used, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_criteria_used.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_criteria_used.object.by_id [ll_row]	=	ls_new_by_id
NEXT

li_rc	=	lds_criteria_used.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_by_id	=	''
	GoTo	exit_script
END IF


// Copy the anal_crit_line rows.  For the newly inserted rows, change the crit_id.
ll_rowcount	=	lds_criteria_from_tbl_used.Retrieve( as_by_id )

li_rc	=	lds_criteria_from_tbl_used.RowsCopy ( 1, ll_rowcount, Primary!, lds_criteria_from_tbl_used, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_criteria_from_tbl_used.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_criteria_from_tbl_used.object.by_id [ll_row]	=	ls_new_by_id
NEXT

li_rc	=	lds_criteria_from_tbl_used.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_by_id	=	''
	GoTo	exit_script
END IF

// Copy the anal_crit_sort rows.  For the newly inserted rows, change the crit_id.
ll_rowcount	=	lds_criteria_used_line.Retrieve( as_by_id )

li_rc	=	lds_criteria_used_line.RowsCopy ( 1, ll_rowcount, Primary!, lds_criteria_used_line, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_criteria_used_line.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_criteria_used_line.object.by_id [ll_row]	=	ls_new_by_id
NEXT

li_rc	=	lds_criteria_used_line.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_by_id	=	''
	GoTo	exit_script
END IF



exit_script:

IF	IsValid(lds_criteria_used)				THEN	Destroy lds_criteria_used

IF	IsValid(lds_criteria_from_tbl_used)	THEN	Destroy lds_criteria_from_tbl_used

IF	IsValid(lds_criteria_used_line)		THEN	Destroy lds_criteria_used_line



Return	ls_new_by_id

end function

public function string uf_get_modify_heading (datawindow adw, string as_column);//This function will create a modify string passed for the specified 
//custom heading.  

string 						ls_column,				&
								ls_old_heading,		&
								ls_modify
ls_column = as_column  +  "_t.Text"

// Get the existing heading for this column from the datawindow
ls_old_heading = Trim ( adw.Describe (ls_column) )

IF (Len (ls_old_heading)  >  0  and (ls_old_heading  <>  '!')) THEN
	// Get the heading text from dictionary
	ls_modify  =  Trim (This.uf_get_custom_headings (adw, as_column) )
END IF

Return  ls_modify

end function

public subroutine uf_create_refer_case_log (long al_new_case_row, string as_link_type, string as_old_link_name, string as_new_link_name);//////////////////////////////////////////////////////////////////////////////////////
//
//	This method will insert a new log entry
//	for any link names that were changed 
//	during the referral process
//
//////////////////////////////////////////////////////////////////////////////////////
//
//	05/17/02	GaryR	Track 3010d	Link name in log does not match the referred link name.
//
//////////////////////////////////////////////////////////////////////////////////////

Long ll_new_row
String	ls_message

as_link_type = Upper( as_link_type ) + " "

// Insert new case_log entry for the new referred case. 
ll_new_row	=	This.uf_initialize_case_log( al_new_case_row )

// Create the message
ls_message = "Referred item (" + as_link_type + String( as_old_link_name )  + &
											") has been changed to " + String( as_new_link_name )

idw_case_log.object.status_desc[ll_new_row] = ls_message

// As requested by the WIC team,
//	Set case_updt_user to SYSTEM
idw_case_log.object.case_updt_user[ll_new_row] = "SYSTEM"
end subroutine

public function long uf_initialize_case_log (long al_case_row);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_initialize_case_log
//
//	Arguments:	al_case_row - 	The row # in idw_case.  Required because of the
//										possibility of referrals.
//
//	Returns:		Long -	The row # inserted into idw_case_log
//
//	Description:
//		Insert a row into case log and initialize its values from idw_case.
//		Additional changes to the case_log can be made by the calling script.
//
//	Note:	Any changes to this script may also have to be applied to uf_audit_log().
//
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/20/01	FDG	Stars 4.8.  Created
//	05/17/02	GaryR	Track 3061d	Set the case_updt_user field.
//
////////////////////////////////////////////////////////////////////////////////

Long			ll_new_row

Integer		li_rc

Date			ldt_init

DateTime		ldtm_current,			&
				ldtm_init

//	Initialize data
ldtm_current	=	gnv_app.of_get_server_date_time()
ldtm_init		=	DateTime( Date( 1900, 01, 01 ) )
ldt_init			=	Date( 1900, 01, 01 )

// Insert new case_log entry for the opening of the new referred case. 
ll_new_row	=	idw_case_log.InsertRow(0)

idw_case_log.object.case_id [ll_new_row]					=	idw_case.object.case_id [al_case_row]
idw_case_log.object.case_spl [ll_new_row]					=	idw_case.object.case_spl [al_case_row]
idw_case_log.object.case_ver [ll_new_row]					=	idw_case.object.case_ver [al_case_row]
idw_case_log.object.case_updt_user[ll_new_row]			=	gc_user_id			//	05/17/02	GaryR	Track 3061d
//idw_case_log.object.user_id [ll_new_row]				=	gc_user_id		//	GaryR	05/17/02	Track 3061d
idw_case_log.object.sys_datetime [ll_new_row]			=	ldtm_current

// The following values in case_log must be set to what is in case because some of the case inventory
//	reports need these values.
idw_case_log.object.status [ll_new_row]					=	idw_case.object.case_status [al_case_row]
idw_case_log.object.status_datetime [ll_new_row]		=	idw_case.object.case_status_date [al_case_row]
idw_case_log.object.disp [ll_new_row]						=	idw_case.object.case_disp [al_case_row]
idw_case_log.object.case_custom1_amt [ll_new_row]		=	idw_case.object.case_custom1_amt [al_case_row]
idw_case_log.object.case_custom2_amt [ll_new_row]		=	idw_case.object.case_custom2_amt [al_case_row]
idw_case_log.object.case_custom3_amt [ll_new_row]		=	idw_case.object.case_custom3_amt [al_case_row]
idw_case_log.object.identified_amt [ll_new_row]			=	idw_case.object.identified_amt [al_case_row]
idw_case_log.object.future_savings_amt [ll_new_row]	=	idw_case.object.future_savings_amt [al_case_row]
idw_case_log.object.pmr_case_custom1_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom1_cnt [al_case_row]
idw_case_log.object.pmr_case_custom2_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom2_cnt [al_case_row]
idw_case_log.object.pmr_case_custom4_amt [ll_new_row]	=	idw_case.object.pmr_case_custom4_amt [al_case_row]
idw_case_log.object.pmr_case_custom5_amt [ll_new_row]	=	idw_case.object.pmr_case_custom5_amt [al_case_row]
idw_case_log.object.pmr_case_custom6_amt [ll_new_row]	=	idw_case.object.pmr_case_custom6_amt [al_case_row]
idw_case_log.object.pmr_case_custom3_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom3_cnt [al_case_row]
idw_case_log.object.pmr_case_custom4_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom4_cnt [al_case_row]
idw_case_log.object.pmr_case_custom5_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom5_cnt [al_case_row]
idw_case_log.object.pmr_case_custom7_amt [ll_new_row]	=	idw_case.object.pmr_case_custom7_amt [al_case_row]
idw_case_log.object.pmr_case_custom8_amt [ll_new_row]	=	idw_case.object.pmr_case_custom8_amt [al_case_row]
idw_case_log.object.pmr_case_custom9_amt [ll_new_row]	=	idw_case.object.pmr_case_custom9_amt [al_case_row]
idw_case_log.object.pmr_case_custom6_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom6_cnt [al_case_row]
idw_case_log.object.pmr_case_custom7_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom7_cnt [al_case_row]
idw_case_log.object.pmr_case_custom8_cnt [ll_new_row]	=	idw_case.object.pmr_case_custom8_cnt [al_case_row]



Return	ll_new_row

end function

public function integer uf_update_pdq (string as_query_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_update_pdq
//
//	Arguments:	as_query_id: The original query id
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:
//		This function is called when a case is assigned to a new user.
//
//		This function will update pdq_cntl and notes with the user_id/dept_id.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/21/01	FDG	Stars 4.8.1  Created
//
////////////////////////////////////////////////////////////////////////////////

String		ls_new_query_id,		&
				ls_note_text,			&
				ls_dept_id,				&
				ls_user_id,				&
				ls_note_rel_type,		&
				ls_note_sub_type,		&
				ls_note_rel_id,		&
				ls_note_id,				&
				ls_rte_ind

Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount,		&
				ll_case_row

Integer		li_rc,					&
				li_refer_rc

DateTime		ldtm_current,			&
				ldtm_note_datetime
				
n_ds			lds_pdq_cntl,			&
				lds_pdq_criteria,		&
				lds_pdq_tables,		&
				lds_pdq_columns,		&
				lds_notes

//	Initialize data
ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_pdq_cntl	=	CREATE	n_ds
lds_pdq_cntl.DataObject = 'd_pdq_cntl'
li_rc = lds_pdq_cntl.SetTransObject(Stars2ca)

lds_notes	=	CREATE	n_ds
lds_notes.DataObject = 'd_notes'
li_rc = lds_notes.SetTransObject(Stars2ca)


// Update the pdq_cntl rows.  
ll_rowcount	=	lds_pdq_cntl.Retrieve( as_query_id )

FOR ll_row	=	1	TO	ll_rowcount
	IF	is_refer_user	>	' '		THEN
		lds_pdq_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_pdq_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	GoTo	exit_script
END IF


// Update the PDQ notes.  
// FDG 12/06/01 - Don't do Notes per KayKay
//ll_rowcount	=	lds_notes.Retrieve( 'PQ', as_query_id )
//
//FOR ll_row	=	1	TO	ll_rowcount
//	lds_notes.object.dept_id [ll_row]	=	is_refer_dept
//	IF	is_refer_user	>	' '		THEN
//		lds_notes.object.user_id [ll_row]	=	is_refer_user
//	END IF
//NEXT
//
//li_rc	=	lds_notes.Event	ue_update( TRUE, TRUE )	
//
//IF	li_rc	<	0		THEN
//	GoTo	exit_script
//END IF


exit_script:

IF	IsValid(lds_pdq_cntl)			THEN	Destroy lds_pdq_cntl

IF	IsValid(lds_notes)				THEN	Destroy lds_notes


Return	li_rc

end function

public function boolean uf_edit_case_closed (string as_case_id);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_closed
//
//	Arguments:	1.	as_case_id
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not closed/deleted.
//					FALSE	=	Edit failed - case was closed/deleted.
//
//	Description:
//		This script determines if a case was closed or deleted.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/10/01	Stars 4.8.1  Created.
//
//////////////////////////////////////////////////////////////////

String	ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver

ls_case_id	=	Left( as_case_id, 10 )
ls_case_spl	=	Mid( as_case_id, 11, 2 )
ls_case_ver	=	Mid( as_case_id, 13, 2 )

Return	This.uf_edit_case_closed( ls_case_id, ls_case_spl, ls_case_ver )	



end function

public function boolean uf_edit_case_referred (string as_case_id, string as_case_spl, string as_case_ver);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_referred
//
//	Arguments:	1.	as_case_id
//					2.	as_case_spl
//					3.	as_case_ver
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not referred.
//					FALSE	=	Edit failed - case was referred.
//
//	Description:
//		This script determines if a case was referred.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/13/01	Stars 4.8.1  Created.
//
//////////////////////////////////////////////////////////////////

String	ls_case_disp

Constant	String	lcs_referred	=	'REFERRED'

Integer	li_rc

Select	case_disp
Into		:ls_case_disp
From		case_cntl
Where		case_id		=	:as_case_id
  and		case_spl		=	:as_case_spl
  and		case_ver		=	:as_case_ver
Using		Stars2ca;

li_rc	=	Stars2ca.of_check_status()

IF	li_rc	>	0		THEN
	// Row not found, return true
	Return	TRUE
END IF

IF	Upper(ls_case_disp)	=	lcs_referred		THEN
	Return	FALSE
ELSE
	Return	TRUE
END IF
	

end function

public function boolean uf_edit_case_referred (string as_case_id, string as_case_spl, string as_case_ver, string as_link_type, string as_link_name);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_referred
//
//	Arguments:	1.	as_case_id
//					2.	as_case_spl
//					3.	as_case_ver
//					4.	as_link_type
//					5.	as_link_name
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not referred
//					FALSE	=	Edit failed - case was referred.
//
//	Description:
//		This script determines if a case was referred.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	05/28/01	Stars 4.8.1  Created.
//
//////////////////////////////////////////////////////////////////

String	ls_link_status

Integer	li_rc

Select	link_status
Into		:ls_link_status
From		case_link
Where		case_id		=	:as_case_id
  and		case_spl		=	:as_case_spl
  and		case_ver		=	:as_case_ver
  and		link_type	=	:as_link_type
  and		link_name	=	:as_link_name
Using		Stars2ca;

li_rc	=	Stars2ca.of_check_status()

IF	li_rc	>	0		THEN
	// Row not found, return true
	Return	TRUE
END IF

IF	Upper(ls_link_status)	=	'R'		THEN
	Return	FALSE
ELSE
	Return	TRUE
END IF
	

end function

public function long uf_retrieve_case ();//This function will retrieve the case data based on the data 
//in the track datawindow.  

long ll_rowcount,ll_row
string ls_case_id,ls_case_spl,ls_case_ver

Ll_rowcount = idw_track.RowCount()

IF ll_rowcount  < 1  THEN
	Return -1
END IF

Ls_case_id = idw_track.object.case_id [1]
Ls_case_spl = idw_track.object.case_spl [1]
Ls_case_ver = idw_track.object.case_ver [1]
Ll_row = idw_track.Retrieve (ls_case_id, ls_case_spl, ls_case_ver)


Return  ll_row




end function

public function integer uf_valid_case (string as_case_id, string as_case_spl, string as_case_ver);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// uf_valid_case								n_cst_case
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will verify if a case exists and if it has been marked as
//	for deletion or closed.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype	
//		---------	--------			--------	
//		Value			as_case_id		String	
//		Value			as_case_spl		String
//		Value			as_case_ver		String
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Case is available, or case is 'NONE' 
//						-1				Case is not found
//						-2				Case marked for deletion
//						-3				Case is closed
//						-4				SQL Error
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
// 08/13/99	NLG	Function copied from u_nvo_case_functions.ue_valid_case
// 06/18/02	Jason	Change case status to RC on referral
//	01/04/05	GaryR	Track 5651c	Trim active case
/////////////////////////////////////////////////////////////////////////////

n_ds lds_case
string ls_status
long ll_row

if Trim( as_case_id ) = 'NONE' then
	return 0
end if

lds_case = create n_ds
lds_case.dataobject = 'd_case'
lds_case.SetTransObject(stars2ca)

/*Determine if case link entry for query id and active case exists */
ll_row = lds_case.retrieve(as_case_id,as_case_spl,as_case_ver)
if ll_row = 1 then
	ls_status = lds_case.Object.case_status[1]
	// Begin - Track 3063d
	//if ls_status = 'CL' then
	if ls_status = 'CL' or ls_status = 'RC' then
	// End - Track 3063d
		if IsValid(lds_case) then destroy lds_case
		return -3
	elseif ls_status = 'DL' then
		if IsValid(lds_case) then destroy lds_case
		return -2
	else
		if IsValid(lds_case) then destroy lds_case
		return 0
	end if
elseif  ll_row = 0 then 
	if IsValid(lds_case) then destroy lds_case
	return -1
else
	if IsValid(lds_case) then destroy lds_case
	return -4
end if
end function

public function boolean uf_edit_case_closed (string as_case_id, string as_case_spl, string as_case_ver);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_closed
//
//	Arguments:	1.	as_case_id
//					2.	as_case_spl
//					3.	as_case_ver
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not closed/deleted.
//					FALSE	=	Edit failed - case was closed/deleted.
//
//	Description:
//		This script determines if a case was closed or deleted.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/10/01	Stars 4.8.  Created.
// JasonS 06/18/02  Track 3063d Change case status to RC on referral
//////////////////////////////////////////////////////////////////

String	ls_case_status

Constant	String	lcs_closed	=	'CL'
Constant	String	lcs_deleted	=	'DL'
Constant String   lcs_referred = 'RC'		// JasonS Track 3063d


Integer	li_rc

IF	IsNull (as_case_id)							&
OR	Trim(as_case_id)				=	''			&
OR	Upper ( Trim(as_case_id) )	=	'NONE'	THEN
	Return	TRUE
END IF

Select	case_status
Into		:ls_case_status
From		case_cntl
Where		case_id		=	:as_case_id
  and		case_spl		=	:as_case_spl
  and		case_ver		=	:as_case_ver
Using		Stars2ca;

li_rc	=	Stars2ca.of_check_status()

IF	li_rc	>	0		THEN
	// Row not found, return true
	Return	TRUE
END IF

IF	Upper(ls_case_status)	=	lcs_closed		&
OR	Upper(ls_case_status)	=	lcs_deleted		&
OR Upper(ls_case_status)   =  lcs_referred   THEN  // Added lcs_referred line  JasonS Track 3063d
	Return	FALSE
ELSE
	Return	TRUE
END IF
	

end function

public function long uf_filter_sys_codes (ref datawindowchild adwc_requestor, readonly string as_input_code);//*********************************************************************************
// Script Name:	uf_filter_sys_codes
//
//	Arguments:		DataWindowChild - adwc_requestor (By Ref)
//												The drop-down datawindow requesting filter.
//
// Returns:			Long - Post filter row count, -1 if error occurs.
//
//	Description:	This method will filter out any codes displayed in adwc_requestor
//						marked as SYSTEM in the code table. (CODE_VALUE_N <> 0)
//
//*********************************************************************************
//
//	06/17/02	GaryR	Track 2962	Created
// 07/25/02 JasonS Track 3190d Also display current input code if it is not blank
//*********************************************************************************

//	Validate argument
IF NOT IsValid( adwc_requestor ) OR IsNull( adwc_requestor ) THEN Return -1

// JasonS 07/25/02 Begin - Track 3190d
if as_input_code = '' then
	// Add the restricting filter
	adwc_requestor.SetFilter( "code_value_n = 0" )
	adwc_requestor.Filter()
else
	// Add the restricting filter
	adwc_requestor.SetFilter( "code_value_n = 0 OR code_code = '" + as_input_code + "'" )
	adwc_requestor.Filter()
end if


//// Add the restricting filter
//adwc_requestor.SetFilter( "code_value_n = 0" )
//adwc_requestor.Filter()
// JasonS 07/25/02 End - Track 3190d

Return adwc_requestor.RowCount()
end function

public function string uf_create_case (string as_case_id, boolean ab_lead);//*******************************************************************
//	02/07/01	FDG	Stars 4.6 - Add new PIMR data to insert
//	12/05/00 FDG	Stars 4.7.  Make error checking DBMS-independent.
// 03/16/00 FNC	Track 2146 - Update for case money fields and change 
//						period from and period to to datetime fields	
// 08-31-98 NLG	FS362 convert case to case_cntl
// 01/31/96 DKG	Added arg_lead parameter to function to set case 
//             	category to COM if adding from Lead List.
//             	PROB 93 Stars 3.1 Release. (True) from Lead List.
//             	(False) from Case Active.
//	07/27/01	GaryR	Track 2382d	Use of empty string in sql.
//	10/12/01	FDG	Stars 4.8.1.  Use n_cst_case to create a case_log.
// 07/11/02 JasonS Track 3176d  Only append 0000 to case id if case id length is = 10
//	07/29/02	GaryR	Track 3215d	Invalid case log generated from System case.
//										Also, moved script here from fx_create_new_case.
// 01/23/03 JasonS Track 3302d increment case_cnt
// 03/14/03 JasonS Track 3302d added an _ to table name
//	05/23/07 Katie	SPR 2015 Evaluate CASE_ID to make sure it isn't going to be a dup - 
//							if it is get the next CASE_ID from SYS_CNTL
//******************************************************************* 

Date   	lv_assigned_date,lv_init_date
Time   	lv_init_time
Datetime lv_assign_datetime
Datetime lv_created_date,lv_current_datetime
datetime ldt_init_datetime
String 	lv_case_type,lv_case_cat
String 	lv_track_type,lv_case_business
string   lv_case_status,lv_case_disposition
String	lv_case_desc
String 	lv_case_id,lv_case_id_spl,lv_case_id_ver
Decimal  ldec_initial = 0.00
int 		lv_len,lv_index, lv_count
string 	lv_char
boolean lb_valid_case

date	ld_userstatsdate	// JasonS 01/23/03 Track 3302d

//	07/27/01	GaryR	Track 2382d - Begin
string	ls_empty
gnv_sql.of_TrimData( ls_empty )
//	07/27/01	GaryR	Track 2382d - End

//	07/29/02	GaryR	Track 3215d - Begin
Integer	li_row, li_rc

lv_init_date = date(1900,01,01)
lv_init_time = time(00,00,01)
ldt_init_datetime = datetime(lv_init_date,lv_init_time)		// FNC 03/16/00
lv_created_date     = gnv_app.of_get_server_date_time() //datetime(today(),now())  ts2020c use server date
lv_assign_datetime  = datetime(date(lv_created_date))
lv_case_type        = 'PV'

//DKG 01/31/96 BEGIN
//lv_case_cat         = 'CA?'
IF ab_lead THEN 
   lv_case_cat = 'COM' 
ELSE
	lv_case_cat = 'CA?'
END IF   
//DKG 01/31/96 END

lv_track_type       = lv_case_type
lv_case_status 	  = 'OP'
lv_case_disposition = 'SYSADD'

lv_current_datetime = gnv_app.of_get_server_date_time()//datetime(today(), now()) //ts2020c use server date
lv_case_desc = 'Potential Case Created on ' + string(lv_current_datetime,"mm/dd/yyyy hh:mm:ss")


  SELECT USERS.BUS_DFLT  
    INTO :lv_case_business  
    FROM USERS  
   WHERE USERS.USER_ID = Upper( :gc_user_id )
  Using Stars2ca  ;

If stars2ca.of_check_status() <> 0  then
	Errorbox(stars2ca,'Error retrieving user business default')
	RETURN 'ERROR'
else
	COMMIT USING STARS2CA;
End If

if lv_case_business = '' then
	COMMIT using Stars2ca;
	if Stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error performing commit in n_cst_case::uf_create_case.')
	end if		
   Messagebox('ERROR','Must have a business default on User Table to continue processing',Stopsign!)
   return 'ERROR'
end if

if as_case_id = '' then
	lb_valid_case = false
	do while lb_valid_case = false and as_case_id <> 'ERROR'
		as_case_id = fx_get_next_key_id('CASE')
		
		Select count(*) 
		into :lv_count
		from CASE_CNTL
		where CASE_ID = Upper( :as_case_id )
		using stars2ca;

		if lv_count > 0 then
		else
			lb_valid_case = true
		end if

	loop
	If as_case_id = 'ERROR' then
		COMMIT using Stars2ca;
		if Stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error performing commit in n_cst_case::uf_create_case.')
		end if		
		RETURN 'ERROR'
	Else 
		as_case_id = upper(as_case_id) + '0000'
	End IF
else
	lv_len = len(as_case_id)
	For lv_index = 1 to lv_len
		lv_char = mid(as_case_id,lv_index,1)
		If Asc(lv_char) > 47 and Asc(lv_char) < 58 Then
			Continue
		ElseIf Asc(lv_char) > 64 and Asc(lv_char) < 91 Then
			Continue
		ElseIf Asc(lv_char) > 96 and Asc(lv_char) < 122 Then
			continue
		Else
			//sqlcmd('DISCONNECT',stars2ca,'',1) HRB
			Messagebox('EDIT','Case Id contains an invalid character.  Please Re-Key')
			RETURN 'EXISTS'
		End If
	Next
	// Begin - Track 3176d  
	//arg_case_id = upper(arg_case_id) + '0000'
	if (len(as_case_id) = 10) then
		as_case_id = upper(as_case_id) + '0000'
	end if
	// End - Track 3176d
end if

//KMM 1/23/96 Added upper to following 3 lines
lv_case_id 		= upper(left(as_case_id,10))
lv_case_id_spl = upper(mid(as_case_id,11,2))
lv_case_id_ver = upper(mid(as_case_id,13,2))

//	Setup idw_case
li_rc = w_main.OpenUserObject( idw_case )
idw_case.visible = FALSE
idw_case.DataObject = "d_case_general"
li_rc = idw_case.SetTransObject( Stars2ca )
li_row = idw_case.InsertRow( 0 )

//	Insert the data
idw_case.object.dept_id[li_row]						=	gc_user_dept
idw_case.object.user_id[li_row]						=	gc_user_id
idw_case.object.case_id[li_row]						=	lv_case_id
idw_case.object.case_spl[li_row]						=	lv_case_id_spl
idw_case.object.case_ver[li_row]						=	lv_case_id_ver
idw_case.object.case_asgn_id[li_row]				=	gc_user_id
idw_case.object.case_asgn_prio[li_row]				=	ls_empty
idw_case.object.case_asgn_date[li_row]				=	lv_assign_datetime
idw_case.object.refer_from_dept[li_row]			=	ls_empty
idw_case.object.refer_to_dept[li_row]				=	ls_empty
idw_case.object.refer_by_rep[li_row]				=	ls_empty
idw_case.object.refer_date[li_row]					=	ldt_init_datetime
idw_case.object.case_datetime[li_row]				=	lv_created_date
idw_case.object.case_type[li_row]					=	lv_case_type
idw_case.object.case_cat[li_row]						=	lv_case_cat
idw_case.object.case_business[li_row]				=	lv_case_business
idw_case.object.case_line_b[li_row]					=	ls_empty
idw_case.object.case_plan[li_row]					=	ls_empty
idw_case.object.case_trk_type[li_row]				=	lv_track_type
idw_case.object.case_edit[li_row]					=	ls_empty
idw_case.object.case_disp_hold[li_row]				=	ls_empty
idw_case.object.case_from_period[li_row]			=	ldt_init_datetime
idw_case.object.case_to_period[li_row]				=	ldt_init_datetime
idw_case.object.case_status[li_row]					=	lv_case_status
idw_case.object.case_disp[li_row]					=	lv_case_disposition
idw_case.object.case_updt_user[li_row]				=	gc_user_id
idw_case.object.case_status_date[li_row]			=	lv_current_datetime
idw_case.object.case_desc[li_row]					=	lv_case_desc
idw_case.object.case_status_desc[li_row]			=	'New Case Added'
idw_case.object.case_date_recv[li_row]				=	lv_created_date
idw_case.object.identified_amt[li_row]				=	ldec_initial
idw_case.object.op_amt[li_row]						=	ldec_initial
idw_case.object.amt_recv[li_row]						=	ldec_initial
idw_case.object.recovered_addtl_amt[li_row]		=	ldec_initial
idw_case.object.future_savings_amt[li_row]		=	ldec_initial
idw_case.object.referred_amt[li_row]				=	ldec_initial
idw_case.object.amt_writeoff[li_row]				=	ldec_initial
idw_case.object.balance_remaining_amt[li_row]	=	ldec_initial
idw_case.object.case_custom1_amt[li_row]			=	ldec_initial
idw_case.object.case_custom2_amt[li_row]			=	ldec_initial
idw_case.object.case_custom3_amt[li_row]			=	ldec_initial
idw_case.object.custom1_amt[li_row]					=	ldec_initial
idw_case.object.custom2_amt[li_row]					=	ldec_initial
idw_case.object.custom3_amt[li_row]					=	ldec_initial
idw_case.object.custom4_amt[li_row]					=	ldec_initial
idw_case.object.custom5_amt[li_row]					=	ldec_initial
idw_case.object.custom6_amt[li_row]					=	ldec_initial
idw_case.object.pmr_contractor_id[li_row]			=	ls_empty
idw_case.object.pmr_ready_cd[li_row]				=	'N'
idw_case.object.pmr_created_cd[li_row]				=	'N'
idw_case.object.pmr_ready_date[li_row]				=	ldt_init_datetime
idw_case.object.pmr_created_date[li_row]			=	ldt_init_datetime
idw_case.object.pmr_prov_type_cd[li_row]			=	ls_empty
idw_case.object.pmr_custom1_cd[li_row]				=	ls_empty
idw_case.object.pmr_custom1_char[li_row]			=	ls_empty
idw_case.object.pmr_case_custom1_cnt[li_row]		=	0
idw_case.object.pmr_case_custom2_cnt[li_row]		=	0
idw_case.object.pmr_case_custom4_amt[li_row]		=	ldec_initial
idw_case.object.pmr_case_custom5_amt[li_row]		=	ldec_initial
idw_case.object.pmr_case_custom6_amt[li_row]		=	ldec_initial
idw_case.object.pmr_case_custom3_cnt[li_row]		=	0
idw_case.object.pmr_case_custom4_cnt[li_row]		=	0
idw_case.object.pmr_case_custom5_cnt[li_row]		=	0
idw_case.object.pmr_case_custom7_amt[li_row]		=	ldec_initial
idw_case.object.pmr_custom1_date[li_row]			=	ldt_init_datetime
idw_case.object.pmr_custom2_cd[li_row]				=	ls_empty
idw_case.object.pmr_custom3_cd[li_row]				=	ls_empty
idw_case.object.pmr_frd_rfrl_cd[li_row]			=	ls_empty
idw_case.object.pmr_acpt_cd[li_row]					=	ls_empty
idw_case.object.pmr_ready_user[li_row]				=	ls_empty
idw_case.object.pmr_created_user[li_row]			=	ls_empty
idw_case.object.case_prov_spec[li_row]				=	ls_empty
idw_case.object.pmr_case_custom8_amt[li_row]		=	ldec_initial
idw_case.object.pmr_case_custom9_amt[li_row]		=	ldec_initial
idw_case.object.pmr_case_custom6_cnt[li_row]		=	0
idw_case.object.pmr_case_custom7_cnt[li_row]		=	0
idw_case.object.pmr_case_custom8_cnt[li_row]		=	0
idw_case.object.pmr_custom2_char[li_row]			=	ls_empty
idw_case.object.pmr_custom4_cd[li_row]				=	ls_empty
idw_case.object.pmr_custom5_cd[li_row]				=	ls_empty
idw_case.object.pmr_custom2_date[li_row]			=	ldt_init_datetime
idw_case.object.pmr_custom3_date[li_row]			=	ldt_init_datetime
idw_case.object.pmr_subject_id[li_row]				=	ls_empty
li_rc = idw_case.Event ue_update( TRUE, TRUE )

//If stars2ca.of_check_status() <> 0  then
If li_rc < 0 OR stars2ca.of_check_status() <> 0  then
	// FDG 12/05/00 - Make error checking DBMS-independent
	//If stars2ca.sqldbcode = gv_sql_dup or stars2ca.sqldbcode = gv_sql_dup2 then
	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		//sqlcmd('DISCONNECT',stars2ca,'Disconnect from Table',1) HRB
		li_rc = w_main.CloseUserObject( idw_case )
		messagebox('Information','Case Already Exists')
		setmicrohelp(w_main,'Case Already Exists - Reenter Name')
		RETURN 'EXISTS'
	Else
		li_rc = w_main.CloseUserObject( idw_case )
		Errorbox(stars2ca,'Error Inserting into CASE_CNTL')
		RETURN 'ERROR'
	End If
End If
//COMMIT USING STARS2CA;
stars2ca.of_commit()

// 03/16/00 FNC add case money fields
// 02/07/01 FDG Add new PIMR data

// FDG 10/12/01 - Use n_cst_case to insert a case_log
//n_cst_case	lnv_case
//
//lnv_case	=	CREATE	n_cst_case
//
//li_rc	=	lnv_case.uf_audit_log (lv_case_id, lv_case_id_spl, lv_case_id_ver, 'New Case Added')
//
//Destroy	lnv_case

//	Setup idw_case_log
li_rc = w_main.OpenUserObject( idw_case_log )
idw_case_log.visible = FALSE
idw_case_log.DataObject = "d_case_log"
idw_case_log.SetTransObject( Stars2ca )

This.uf_create_case_log( li_row, FALSE )
li_rc = idw_case_log.Event ue_update( TRUE, TRUE )

li_rc = w_main.CloseUserObject( idw_case )
li_rc = w_main.CloseUserObject( idw_case_log )

IF li_rc < 0 OR Stars2ca.of_check_status() <> 0  THEN
	MessageBox( "Create Case", "Error inserting into CASE_LOG" )
	Return 'ERROR'
END IF
//	07/29/02	GaryR	Track 3215d - End

//// 02/07/01 FDG Add new PIMR data
//Insert into Case_log
//			(case_id,case_spl,case_ver,
//			 status,disp,
//			 status_desc,status_datetime,
//			 User_id,sys_datetime,case_custom1_amt,
//			 case_custom2_amt,case_custom3_amt,
//			 identified_amt,future_savings_amt,
//			 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//			 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//			 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//			 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//			 pmr_case_custom4_amt,pmr_case_custom5_amt,
//			 pmr_case_custom6_amt,pmr_case_custom7_amt,
//			 pmr_case_custom8_amt,pmr_case_custom9_amt)
//	Values
//			(:lv_case_id,:lv_case_id_spl,:lv_case_id_ver,
//			 :LV_CASE_STATUS,:LV_CASE_DISPOSITION,'New Case Added',:lv_created_date,
//			 :gc_user_id,:lv_created_date,:ldec_initial,
//			 :ldec_initial,:ldec_initial,
//			 :ldec_initial,:ldec_initial,
//			 0,0,
//			 0,0,
//			 0,0,
//			 0,0,
//			 :ldec_initial,:ldec_initial,
//			 :ldec_initial,:ldec_initial,
//			 :ldec_initial,:ldec_initial)
//Using stars2ca;
//If stars2ca.of_check_status() <> 0 then 
//		Errorbox(stars2ca,'Error Inserting Case Log')
//		Rollback Using Stars2ca;		// FDG 02/07/01
//		RETURN 'ERROR'
//End If
// FDG 10/12/01 end

STARS2CA.of_commit()

// JasonS 1/23/03 Begin - Track 3302d
ld_userstatsdate = date(left(string(today()),2) + '/01/' + right(string(today()), 2))
update User_Stats		// JasonS 03/14/03 Track 3302d
set case_cnt = case_cnt + 1
where stats_date = :ld_userstatsdate
using stars2ca;
stars2ca.of_commit()
// JasonS 1/23/03 End - Track 3302d

setmicrohelp(w_main,'Case Created')

if isvalid(w_case_active) then
	w_case_active.sle_desc.text = lv_case_desc
	w_case_active.sle_line_of_business.text = lv_case_business
end if

as_case_id = upper(as_case_id)

Return as_case_id
end function

public function long uf_create_case_log (long al_case_row, boolean ab_add_2nd_row);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_create_case_log
//
//	Arguments:	al_case_row - The row in case_cntl
//
//	Returns:		Long - The row inserted into case_log
//				Boolean - Is this create a user or a system process?
//
//	Description:
//		This function is called when a case is being created.
//		This function will create a case_log entry and set the initial values
//		from case_cntl.
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	10/03/01	FDG	Stars 4.8.1  Created
//	05/21/02	GaryR	Track 3061d	Resolve user_id columns on case_log
//	07/25/02	GaryR	Track 3210d	Create a second log entry for
//										the user selected disposition
//	07/29/02	GaryR	Track 3215d	Invalid case log generated from System case
//	08/01/02	GaryR	Track	3231d	Add a second to the second log entry
//
////////////////////////////////////////////////////////////////////////////////



Long		ll_row_log, &
			ll_row_log2				//	08/01/02	GaryR	Track	3231d

DateTime	ldtm_current
n_cst_datetime	lnv_datetime	//	08/01/02	GaryR	Track	3231d

ldtm_current	=	gnv_app.of_get_server_date_time()

ll_row_log	=	This.uf_initialize_case_log (al_case_row)

// All money fields are set (from case_cntl) in uf_initialize_case_log.
// Initialize the other columns from case_cntl.
idw_case_log.object.user_id [ll_row_log]					=	gc_user_id		//	05/21/02	GaryR	Track 3061d
idw_case_log.object.dept_id [ll_row_log]					=	idw_case.object.dept_id [al_case_row]
idw_case_log.object.case_asgn_id [ll_row_log]			=	idw_case.object.case_asgn_id [al_case_row]
idw_case_log.object.case_asgn_prio [ll_row_log]			=	idw_case.object.case_asgn_prio [al_case_row]
idw_case_log.object.case_asgn_date [ll_row_log]			=	idw_case.object.case_asgn_date [al_case_row]
idw_case_log.object.refer_from_dept [ll_row_log]		=	idw_case.object.refer_from_dept [al_case_row]
idw_case_log.object.refer_to_dept [ll_row_log]			=	idw_case.object.refer_to_dept [al_case_row]
idw_case_log.object.refer_by_rep [ll_row_log]			=	idw_case.object.refer_by_rep [al_case_row]
idw_case_log.object.refer_date [ll_row_log]				=	idw_case.object.refer_date [al_case_row]
idw_case_log.object.case_datetime [ll_row_log]			=	idw_case.object.case_datetime [al_case_row]
idw_case_log.object.case_type [ll_row_log]				=	idw_case.object.case_type [al_case_row]
idw_case_log.object.case_cat [ll_row_log]					=	idw_case.object.case_cat [al_case_row]
idw_case_log.object.case_business [ll_row_log]			=	idw_case.object.case_business [al_case_row]
idw_case_log.object.case_line_b [ll_row_log]				=	idw_case.object.case_line_b [al_case_row]
idw_case_log.object.case_plan [ll_row_log]				=	idw_case.object.case_plan [al_case_row]
idw_case_log.object.case_trk_type [ll_row_log]			=	idw_case.object.case_trk_type [al_case_row]
idw_case_log.object.case_edit [ll_row_log]				=	idw_case.object.case_edit [al_case_row]
idw_case_log.object.case_disp_hold [ll_row_log]			=	idw_case.object.case_disp_hold [al_case_row]
idw_case_log.object.case_from_period [ll_row_log]		=	idw_case.object.case_from_period [al_case_row]
idw_case_log.object.case_to_period [ll_row_log]			=	idw_case.object.case_to_period [al_case_row]
idw_case_log.object.case_updt_user [ll_row_log]			=	idw_case.object.case_updt_user [al_case_row]
idw_case_log.object.case_desc [ll_row_log]				=	idw_case.object.case_desc [al_case_row]
idw_case_log.object.case_status_desc [ll_row_log]		=	idw_case.object.case_status_desc [al_case_row]
idw_case_log.object.case_date_recv [ll_row_log]			=	idw_case.object.case_date_recv [al_case_row]
idw_case_log.object.pmr_contractor_id [ll_row_log]		=	idw_case.object.pmr_contractor_id [al_case_row]
idw_case_log.object.pmr_ready_cd [ll_row_log]			=	idw_case.object.pmr_ready_cd [al_case_row]
idw_case_log.object.pmr_created_cd [ll_row_log]			=	idw_case.object.pmr_created_cd [al_case_row]
idw_case_log.object.pmr_ready_date [ll_row_log]			=	idw_case.object.pmr_ready_date [al_case_row]
idw_case_log.object.pmr_created_date [ll_row_log]		=	idw_case.object.pmr_created_date [al_case_row]
idw_case_log.object.pmr_prov_type_cd [ll_row_log]		=	idw_case.object.pmr_prov_type_cd [al_case_row]
idw_case_log.object.pmr_custom1_cd [ll_row_log]			=	idw_case.object.pmr_custom1_cd [al_case_row]
idw_case_log.object.pmr_custom1_char [ll_row_log]		=	idw_case.object.pmr_custom1_char [al_case_row]
idw_case_log.object.pmr_custom1_date [ll_row_log]		=	idw_case.object.pmr_custom1_date [al_case_row]
idw_case_log.object.pmr_custom2_cd [ll_row_log]			=	idw_case.object.pmr_custom2_cd [al_case_row]
idw_case_log.object.pmr_custom3_cd [ll_row_log]			=	idw_case.object.pmr_custom3_cd [al_case_row]
idw_case_log.object.pmr_frd_rfrl_cd [ll_row_log]		=	idw_case.object.pmr_frd_rfrl_cd [al_case_row]
idw_case_log.object.pmr_acpt_cd [ll_row_log]				=	idw_case.object.pmr_acpt_cd [al_case_row]
idw_case_log.object.pmr_ready_user [ll_row_log]			=	idw_case.object.pmr_ready_user [al_case_row]
idw_case_log.object.pmr_created_user [ll_row_log]		=	idw_case.object.pmr_created_user [al_case_row]
idw_case_log.object.case_prov_spec [ll_row_log]			=	idw_case.object.case_prov_spec [al_case_row]
idw_case_log.object.pmr_custom2_char [ll_row_log]		=	idw_case.object.pmr_custom2_char [al_case_row]
idw_case_log.object.pmr_custom4_cd [ll_row_log]			=	idw_case.object.pmr_custom4_cd [al_case_row]
idw_case_log.object.pmr_custom5_cd [ll_row_log]			=	idw_case.object.pmr_custom5_cd [al_case_row]
idw_case_log.object.pmr_custom2_date [ll_row_log]		=	idw_case.object.pmr_custom2_date [al_case_row]
idw_case_log.object.pmr_custom3_date [ll_row_log]		=	idw_case.object.pmr_custom3_date [al_case_row]
idw_case_log.object.pmr_subject_id [ll_row_log]			=	idw_case.object.pmr_subject_id [al_case_row]
// FDG 09/20/01 end
idw_case_log.object.status[ll_row_log]						=	'OP'
idw_case_log.object.disp[ll_row_log]						=	'SYSADD'
idw_case_log.object.status_desc[ll_row_log]				=	'New Case Added'
idw_case_log.object.status_datetime[ll_row_log]			=	ldtm_current
idw_case_log.object.sys_datetime[ll_row_log]				=	ldtm_current

//	07/25/02	GaryR	Track 3210d
//	07/29/02	GaryR	Track 3215d
//	Insert the second log entry for the user selected disposition
IF ab_add_2nd_row THEN
	//	08/01/02	GaryR	Track	3231d - Begin
	ll_row_log2 = This.uf_initialize_case_log( al_case_row )
	idw_case_log.object.status_desc[ll_row_log2]	= 'Disposition selected when creating case'
	//	Add an additional second to the 2nd log entry for sorting
	ldtm_current = lnv_datetime.of_RelativeDateTime( ldtm_current, 1 )
	idw_case_log.object.status_datetime[ll_row_log2] = ldtm_current
	idw_case_log.object.sys_datetime[ll_row_log2] = ldtm_current
	//	08/01/02	GaryR	Track	3231d - End
END IF
Return	ll_row_log
end function

public function integer uf_audit_log (string as_case_id, string as_case_spl, string as_case_ver, string as_message);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_audit_log
//
//	Arguments:	1.	as_case_id
//					2.	as_case_spl
//					3.	as_case_ver
//					4. as_message
//
//	Returns:		Integer.	1 = success, -1 = error
//
//	Description:
//		This script will insert a case_log entry based on an event
//		that occurred.
//
//	Note:	Any changes to this script may also need to be applied to
//			uf_initialize_case_log()
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	10/11/01	Stars 4.8.1.  Created.
//	GaryR	05/17/02	Track 3061d	Set the case_updt_user field.
// JasonS 06/25/02 Track 3158d  Dept_id and case_asgn_id not being set in log
// JasonS 07/08/02 Track 3133d  Case From Period and To Period are not getting logged
// JasonS 08/02/02 Track 3221d  Back out previous change don't want on every row
// JasonS 08/02/02 Track 3133d  Back out the addition of case from and to dates
// JasonS 11/21/02 Track 3374d  Call ue_re_retrieve_log for performance
//////////////////////////////////////////////////////////////////

Long			ll_row,			&
				ll_rowcount,	&
				ll_case_row,	&
				ll_new_row

Integer		li_rc

Date			ldt_init

DateTime		ldtm_current,			&
				ldtm_init

// Edit input
IF	IsNull (as_case_id)				&
OR	Trim (as_case_id)		=	''		&
OR	Upper ( Trim (as_case_id) )	=	'NONE'	THEN
	Return	0
END IF

//	Initialize data
ldtm_current	=	gnv_app.of_get_server_date_time()
ldtm_init		=	DateTime( Date( 1900, 01, 01 ) )
ldt_init			=	Date( 1900, 01, 01 )

// Get the case data
ids_case.Reset()
ll_case_row	=	ids_case.Retrieve (as_case_id, as_case_spl, as_case_ver)

// Insert new case_log entry. 
ll_new_row	=	ids_case_log.InsertRow(0)

ids_case_log.object.case_id [ll_new_row]					=	ids_case.object.case_id [ll_case_row]
ids_case_log.object.case_spl [ll_new_row]					=	ids_case.object.case_spl [ll_case_row]
ids_case_log.object.case_ver [ll_new_row]					=	ids_case.object.case_ver [ll_case_row]
ids_case_log.object.case_updt_user[ll_new_row]			=	gc_user_id			//	GaryR	05/17/02	Track 3061d
//ids_case_log.object.user_id [ll_new_row]				=	gc_user_id		//	GaryR	05/17/02	Track 3061d
ids_case_log.object.sys_datetime [ll_new_row]			=	ldtm_current

ids_case_log.object.status_desc [ll_new_row]				=	as_message

// The following values in case_log must be set to what is in case because some of the case inventory
//	reports need these values.

// JasonS 08/02/02 Begin - Track 3221d  Back out change
//// Begin - Track 3158d
//ids_case_log.object.dept_id [ll_new_row]					=	ids_case.object.dept_id [ll_case_row]
//ids_case_log.object.case_asgn_id [ll_new_row]			=	ids_case.object.case_asgn_id [ll_case_row]
//// End - Track 3158d
// JasonS 08/02/02 End - Track 3221d

// JasonS 08/02/02 Begin - Track 3133d  Back out addition of case from and case to
//// Begin - Track 3133d
//ids_case_log.object.case_from_period[ll_new_row] 		=	ids_case.object.case_from_period [ll_case_row]
//ids_case_log.object.case_to_period[ll_new_row] 			=	ids_case.object.case_to_period [ll_case_row]
//// End - Track 3133d
// JasonS 08/02/02 End - Track 3133d
ids_case_log.object.status [ll_new_row]					=	ids_case.object.case_status [ll_case_row]
ids_case_log.object.status_datetime [ll_new_row]		=	ids_case.object.case_status_date [ll_case_row]
ids_case_log.object.disp [ll_new_row]						=	ids_case.object.case_disp [ll_case_row]
ids_case_log.object.case_custom1_amt [ll_new_row]		=	ids_case.object.case_custom1_amt [ll_case_row]
ids_case_log.object.case_custom2_amt [ll_new_row]		=	ids_case.object.case_custom2_amt [ll_case_row]
ids_case_log.object.case_custom3_amt [ll_new_row]		=	ids_case.object.case_custom3_amt [ll_case_row]
ids_case_log.object.identified_amt [ll_new_row]			=	ids_case.object.identified_amt [ll_case_row]
ids_case_log.object.future_savings_amt [ll_new_row]	=	ids_case.object.future_savings_amt [ll_case_row]
ids_case_log.object.pmr_case_custom1_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom1_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom2_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom2_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom4_amt [ll_new_row]	=	ids_case.object.pmr_case_custom4_amt [ll_case_row]
ids_case_log.object.pmr_case_custom5_amt [ll_new_row]	=	ids_case.object.pmr_case_custom5_amt [ll_case_row]
ids_case_log.object.pmr_case_custom6_amt [ll_new_row]	=	ids_case.object.pmr_case_custom6_amt [ll_case_row]
ids_case_log.object.pmr_case_custom3_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom3_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom4_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom4_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom5_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom5_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom7_amt [ll_new_row]	=	ids_case.object.pmr_case_custom7_amt [ll_case_row]
ids_case_log.object.pmr_case_custom8_amt [ll_new_row]	=	ids_case.object.pmr_case_custom8_amt [ll_case_row]
ids_case_log.object.pmr_case_custom9_amt [ll_new_row]	=	ids_case.object.pmr_case_custom9_amt [ll_case_row]
ids_case_log.object.pmr_case_custom6_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom6_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom7_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom7_cnt [ll_case_row]
ids_case_log.object.pmr_case_custom8_cnt [ll_new_row]	=	ids_case.object.pmr_case_custom8_cnt [ll_case_row]

li_rc	=	ids_case_log.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'An audit log entry could not be created for case '	+	&
					as_case_id	+	as_case_spl	+	as_case_ver	+	'.  Script: n_cst_case.uf_audit_log()')
	Return	-1
END IF

IF	IsValid (w_case_maint)		THEN
	// Post this event to insure the updates get committed
	w_case_maint.Post	Event	ue_re_retrieve_log()	// JasonS 11/21/02 Track 3374d
END IF


Return	1


end function

public subroutine uf_set_alignment (datawindow adw, string as_inv_type);///////////////////////////////////////////////////////////////////////////////
// n_cst_case.uf_set_alignment
// 
// Args:  adw			- The datawindow containing the columns you want modified
//			 as_inv_typ	- String; The table type associated with the columns to
//							  be changed.
// 
// Description:  This function loops through all the columns in a datawindow
//               and sets the text alignment of the column's data.
//					  
//						0 - Left Alignment
//						1 - Right Alignment
//						2 - Center Alignment
//
////////////////////////////////////////////////////////////////////////////////
// History:
//
// 03/05/02 SAH 	???			Created
// 10/15/04	MikeF	SPR 3650d	Change to use Dictionary method
////////////////////////////////////////////////////////////////////////////////
Long	ll_num_cols

Integer	li_n

String ls_col_name, ls_mod, ls_modify_rc, ls_datatype


// Prevent screen flicker
adw.SetRedraw(FALSE)

// Get the number of columns on the datawindow
ll_num_cols = long(adw.Describe('datawindow.column.count'))

For li_n = 1 to ll_num_cols
	
	// Get the column name
	ls_col_name = adw.Describe('#' + string(li_n) + '.name')
	
	ls_datatype = gnv_dict.event ue_get_elem_data_type( as_inv_type, ls_col_name)
	
	IF ls_datatype = gnv_dict.ics_error THEN
		MessageBox('Database Error', 'Error retrieving from Dictionary: elem_tbl_type = ' + as_inv_type + &
					  ' elem_name = ' + ls_col_name)
		Return
	ELSE
		IF gnv_sql.of_is_money_data_type(ls_datatype) OR gnv_sql.of_is_number_data_type(ls_datatype) THEN
			// Money and Numbers get Right Alignment
			ls_mod = ls_mod + " " + ls_col_name + ".alignment ='1'"
			
		ELSEIF gnv_sql.of_is_character_data_type(ls_datatype) THEN
		   // Strings get Left Alignment
			ls_mod = ls_mod + " " + ls_col_name + ".alignment='0'"
			
		ELSEIF gnv_sql.of_is_date_data_type(ls_datatype) THEN
			// Dates get Center Alignment
			ls_mod = ls_mod + " " + ls_col_name + ".alignment='2'"
		END IF
		

		// Case_id must appear on exported log, but not on online version
		// Set header and column to invisible
		IF ls_col_name = 'case_id' OR ls_col_name = 'case_spl' OR ls_col_name = 'case_ver' THEN
			ls_mod = ls_mod + " " + ls_col_name + "_t.Visible='0'"
			ls_mod = ls_mod + " " + ls_col_name + ".Visible='0'"
		END IF
		
		// The following column header labels have special alignement due to their extreme length.  All
		// others are centered.
		IF ls_col_name = 'status_desc' OR ls_col_name = 'case_desc'	&
		OR ls_col_name = 'case_status_desc' OR ls_col_name = 'pmr_custom2_char' THEN
			// Set alignment to Left Justified
			ls_mod = ls_mod + " " + ls_col_name + "_t.alignment='0'"
		END IF
		
		// JasonS 08/06/02 Begin - Track 3232d  don't Hardcode widths use n_cst_labels::of_labels2()
		// Some columns need width to be hardcoded
		//IF ls_col_name = 'disp' THEN
		//	ls_mod = ls_mod + " " + ls_col_name + ".width='426'"
		//ELSEIF ls_col_name = 'sys_datetime' THEN 
		//	ls_mod = ls_mod + " " + ls_col_name + ".width='136'"
		//END IF
		// JasonS 08/06/02 End - Track 3232d
	
	END IF
NEXT

IF len(ls_mod) > 0 THEN
	ls_modify_rc = adw.Modify(ls_mod)
END IF

adw.SetRedraw(TRUE)
			
			
			
			
			
			
			
			
			
end subroutine

public function integer uf_compute_case_totals (string as_case_id, string as_case_spl, string as_case_ver);////////////////////////////////////////////////////////////////////////////////////////////////
//This function takes the money totals for all tracks associated with 
//a case and updates the case.  
////////////////////////////////////////////////////////////////////////////////////////////////
//		Change History	
//
//	JasonS 08/08/02  Track 3244d	Correctly compute case financial totals from tracks
// JasonS 08/26/02  Track 4157c  Add sql error checking
////////////////////////////////////////////////////////////////////////////////////////////////
Decimal	ldc_identified_amt,  &
			ldc_op_amt, 			&
			ldc_amt_recv, 			&
			ldc_balance_remaining_amt,		&
			ldc_recovered_addtl_amt,		&
			ldc_referred_amt,		&
			ldc_amt_writeoff,		&
			ldc_custom1_amt,		&
			ldc_custom2_amt,		&
			ldc_custom3_amt,		&
			ldc_custom4_amt,		&
			ldc_custom5_amt,		&
			ldc_custom6_amt
			
long 		ll_rowcount, 			&
			ll_row
			
long ll_error_code		// JasonS 08/26/02 Track 4157c
string ls_error_desc		// JasonS 08/26/02 Track 4157c

string ls_case_id, ls_case_spl, ls_case_ver		// JasonS 08/08/02 Track 3244d

// JasonS 08/08/02 Begin - Track 3244d
//ll_rowcount = idw_track.RowCount()
//IF ll_rowcount < 1  THEN
//   Return -1
//END IF
//
//FOR ll_row = 1 TO ll_rowcount
//	ldc_op_amt = ldc_op_amt + idw_track.object.op_amt [ll_row]
//	ldc_amt_recv = ldc_amt_recv + idw_track.object.amt_recv [ll_row]
//	ldc_balance_remaining_amt = ldc_balance_remaining_amt + idw_track.object.balance_remaining_amt [ll_row]
//	ldc_recovered_addtl_amt = ldc_recovered_addtl_amt + idw_track.object.recovered_addtl_amt [ll_row]
//	ldc_referred_amt = ldc_referred_amt + idw_track.object.referred_amt [ll_row]
//	ldc_amt_writeoff = ldc_amt_writeoff + idw_track.object.amt_writeoff [ll_row]
//	ldc_custom1_amt = ldc_custom1_amt + idw_track.object.custom1_amt [ll_row]
//	ldc_custom2_amt = ldc_custom2_amt + idw_track.object.custom2_amt [ll_row]
//	ldc_custom3_amt = ldc_custom3_amt + idw_track.object.custom3_amt [ll_row]
//	ldc_custom4_amt = ldc_custom4_amt + idw_track.object.custom4_amt [ll_row]
//	ldc_custom5_amt = ldc_custom5_amt + idw_track.object.custom5_amt [ll_row]
//	ldc_custom6_amt = ldc_custom6_amt + idw_track.object.custom6_amt [ll_row]
//NEXT
// JasonS 08/08/02 End - Track 3244d

// Make sure there exists a row of data in idw_case
//Ll_row = idw_case.RowCount()
//
//IF ll_row = 0  THEN
//	Ll_row  = This.uf_retrieve_case()
//	IF  ll_row < 1  THEN
//		Return -1
//	END IF
//END IF

// JasonS 08/08/02 Begin - Track 3244d
ls_case_id = trim(as_case_id)
ls_case_spl = trim(as_case_spl)
ls_case_ver = trim(as_case_ver)

select sum(op_amt), sum(amt_recv), sum(balance_remaining_amt), sum(recovered_addtl_amt), sum(referred_amt), sum(amt_writeoff), sum(custom1_amt), sum(custom2_amt), sum(custom3_amt), sum(custom4_amt), sum(custom5_amt), sum(custom6_amt)
into :ldc_op_amt, :ldc_amt_recv, :ldc_balance_remaining_amt, :ldc_recovered_addtl_amt, :ldc_referred_amt, :ldc_amt_writeoff, :ldc_custom1_amt, :ldc_custom2_amt, :ldc_custom3_amt, :ldc_custom4_amt, :ldc_custom5_amt, :ldc_custom6_amt
from track
where case_id = :ls_case_id AND
case_spl = :ls_case_spl AND
case_ver = :ls_case_ver
using stars2ca;

// JasonS 08/26/02 Begin - Track 4157c
ll_error_code = stars2ca.of_check_status()

if isnull(ldc_op_amt) then
	ldc_op_amt = 0
end if

if isnull(ldc_amt_recv) then
	ldc_amt_recv = 0
end if

if isnull(ldc_balance_remaining_amt) then
	ldc_balance_remaining_amt = 0
end if

if isnull(ldc_recovered_addtl_amt) then
	ldc_recovered_addtl_amt = 0
end if

if isnull(ldc_referred_amt) then
	ldc_referred_amt = 0
end if

if isnull(ldc_amt_writeoff) then
	ldc_amt_writeoff = 0
end if

if isnull(ldc_custom1_amt) then
	ldc_custom1_amt = 0
end if

if isnull(ldc_custom2_amt) then
	ldc_custom2_amt = 0
end if

if isnull(ldc_custom3_amt) then
	ldc_custom3_amt = 0
end if

if isnull(ldc_custom4_amt) then
	ldc_custom4_amt = 0
end if

if isnull(ldc_custom5_amt) then
	ldc_custom5_amt = 0
end if

if isnull(ldc_custom6_amt) then
	ldc_custom6_amt = 0
end if
// JasonS 08/26/02 End - Track 4157c

update case_cntl
set op_amt = :ldc_op_amt, amt_recv = :ldc_amt_recv, balance_remaining_amt = :ldc_balance_remaining_amt, recovered_addtl_amt = :ldc_recovered_addtl_amt, referred_amt = :ldc_referred_amt, amt_writeoff = :ldc_amt_writeoff, custom1_amt = :ldc_custom1_amt, custom2_amt = :ldc_custom2_amt, custom3_amt = :ldc_custom3_amt, custom4_amt = :ldc_custom4_amt, custom5_amt = :ldc_custom5_amt, custom6_amt = :ldc_custom6_amt
where case_id = :ls_case_id and
case_spl = :ls_case_spl and
case_ver = :ls_case_ver
using stars2ca;

// JasonS 08/26/02 Begin - Track 4157c
ll_error_code = stars2ca.of_check_status()
// JasonS 08/26/02 End - Track 4157c

stars2ca.of_commit()

//// Modify the totals in idw_case
//idw_case.object.op_amt [ll_row] = ldc_op_amt
//idw_case.object.amt_recv [ll_row] = ldc_amt_recv
//idw_case.object.balance_remaining_amt [ll_row] = ldc_balance_remaining_amt
//idw_case.object.recovered_addtl_amt [ll_row] = ldc_recovered_addtl_amt
//idw_case.object.referred_amt [ll_row] = ldc_referred_amt
//idw_case.object.amt_writeoff [ll_row] = ldc_amt_writeoff
//idw_case.object.custom1_amt [ll_row] = ldc_custom1_amt
//idw_case.object.custom2_amt [ll_row] = ldc_custom2_amt
//idw_case.object.custom3_amt [ll_row] = ldc_custom3_amt
//idw_case.object.custom4_amt [ll_row] = ldc_custom4_amt
//idw_case.object.custom5_amt [ll_row] = ldc_custom5_amt
//idw_case.object.custom6_amt [ll_row] = ldc_custom6_amt

// JasonS 08/08/02 End - Track 3244d

Return 0

end function

public function string uf_get_custom_headings (datawindow adw, string as_column);//This function will determine if column as_column is being used by the system 
//and if so, return its label or heading depending on the dw type.  A column 
//that is used is has a display sequence greater than zero in the dictionary.  
//Column width will be set for grid datawindows.  If the column is not being used, 
//the column will be set invisible.  
//
/////////////////////////////////////////////////////////////////////////////////////
//	Modification History.
//
//	FDG		05/02/00	Track 2252d	Use crit_seq and elem_elem_label to determine
//											if a custom amount will be displayed.
//	FDG		12/14/00	Stars 4.7	Make checking of data types DBMS-independent
//	FDG		02/05/01	Stars 4.6 - PIMR.  Append a ":" at the end of each label.
//	FDG		10/15/01	Stars 4.8.1	"Dictionaryize" all money fields.
// GaryR		05/16/02	Track 3066d	Enable the visibility setting for columns.
// JasonS 	07/15/02 Track 3066d	Enable the visibility setting for case_datetime
// JasonS 	01/08/03 Track 3365d Set limit on char fields
//	GaryR		03/04/03	Track 3462d	Resize character columns based on disp_format
//	GaryR		04/06/04	Track 5675c	Enable case_status_desc and case_edit for relabeling
// Katie    12/29/04 Track 4186d Added code to determine if column is one that does not exist in TRACK.  If it
//				doesn't then pull new labels from TRACK_LOG.
// Katie		01/27/06 Track 4209d Changed calculation for date column width.
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
/////////////////////////////////////////////////////////////////////////////////////

string 						ls_find,					&
								ls_sql, 					&
								ls_table,				&
								ls_invoice,				&
								ls_column,				&
								ls_old_heading,		&
 								ls_heading,				&
								ls_label,				&
 								ls_modify				
string 	ls_text, ls_text1, ls_text2, ls_text_len, ls_hold_data_type
int 							li_db_col_len,			&
								li_len, 					&
								li_position, 			&
								li_text_len,			&
								li_pos,					&
								li_display
long							ll_find
								
//******** LOCAL CONSTANTS

decimal 						ldc_number_pixels 	=   8.9

// Avg pixels set at 11 for Capital letters in System 10 font;	8 for numbers
int  							lic_cap_char_pixels 	=   11
								
// -10 is font height in points; positive number is in window units.  Always use points.
long 							llc_font_height 		= -10

long 							llc_font_weight 		= 700,	&
	 							llc_max_col_hgt 		=  50, 	&
								llc_max_hdr_hgt 		= 900, 	&
								llc_min_col_hgt 		=  20,	&
								llc_min_hdr_hgt 		=  50

string	ls_edit_type, ls_col_type, ls_rc	// JasonS 1/8/03 Track 3365d
Long		ll_limit	// JasonS 1/8/03 Track 3365d
String	ls_disp_format

IF IsNull (as_column)  &
OR Len (as_column) = 0  THEN
	Return ''
else
	ls_column = as_column
END IF

//get table name from dw
ls_sql = Upper( adw.Object.DataWindow.Table.SQLSelect )
li_pos = pos(ls_sql, "FROM ") + 5
ls_table = mid(ls_sql, li_pos)
li_pos = pos(ls_table, " ") - 1
ls_table = left(ls_table, li_pos)
li_pos = pos(ls_table, ",") - 1
if li_pos > 0 then
	ls_table = left(ls_table, li_pos)
end if

if (adw.DataObject = "d_track_savings") then
	if ((UPPER(ls_column) = "PAYMENT_AMT") or (UPPER(ls_column) = "PAYMENT_TYPE") &
	or (UPPER(ls_column) = "CHECK_NO")) then
		ls_table = "TRACK_LOG"
	end if
end if //Katie Track 4186d

//get table type with this.get invoivce
ls_invoice = gnv_dict.event ue_get_inv_type(ls_table)
//add tbl_type to find condition

// Find the column in ids_dictionary_case and determine if the label exists.
ls_find = UPPER("elem_tbl_type = '" + ls_invoice +  "'" + " and elem_name = '"  +  ls_column  +  "'")
ll_find = ids_dictionary_custom.Find (ls_find,1,ids_dictionary_custom.rowcount())

IF ll_find = 0  THEN
	Return ''
END IF

// JasonS 1/8/03 Begin - Track 3365d
ls_edit_type = adw.describe (ls_column + ".Edit.Style")
ls_col_type = adw.describe (ls_column + ".ColType")

if (upper(ls_edit_type) = 'EDIT') AND (gnv_sql.of_is_character_data_type( ls_col_type ) ) then
	ll_limit = ids_dictionary_custom.object.src_len[ll_find]
	ls_rc = adw.modify (ls_column + ".Edit.Limit = " + string(ll_limit))	
end if
// JasonS 1/8/03 End - Track 3365d

// FDG 10/15/01 - end
		ls_label	=	Trim (ids_dictionary_custom.object.elem_elem_label [ll_find])	// FDG 05/02/00
		//check style 
		If adw.Object.DataWindow.Processing = '1' then
			// grid use the elem_label 
			ls_heading = Trim (ids_dictionary_custom.object.elem_elem_label [ll_find])
		Else
			ls_heading = Trim (ids_dictionary_custom.object.elem_desc [ll_find])	+	":"	// FDG 02/05/01
		End If
		//Do not use elem label; Use dictionary disp_seq instead
		
		// FDG 05/02/00 - Use elem label & crit_seq instead of disp_seq
		li_display = ids_dictionary_custom.object.crit_seq [ll_find]
		If li_display	>	0		&
	  	And ls_label	<>	''		then
		  // GaryR	05/16/02	Track 3066d - Begin

			IF ls_column = "case_spl" OR ls_column = "case_datetime" OR ls_column = "case_ver"  &
			OR ls_column = "status_datetime" OR ls_column = "case_asgn_date" OR ls_column = "sys_datetime" &
			OR ls_column = "case_updt_user" OR ls_column = "pmr_created_cd" or ls_column = 'case_to_period' THEN
				ls_modify = " "
			ELSE
				ls_modify  = " " + ls_column +  "_t.Text" + " = '" +  ls_heading + "' "
				
				//	Set Accessibility Properties
				ls_heading = inv_string.of_clean_string_acc( ls_heading )
				ls_heading = '"' + ls_heading + '"~t"' + ls_heading + '"'
				ls_modify += " " + ls_column + ".AccessibleName='" + ls_heading + "'"
				ls_modify += " " + ls_column + ".AccessibleDescription='" + ls_heading + "'"
				ls_modify += " " + ls_column + "_t.AccessibleName='" + ls_heading + "'"
				ls_modify += " " + ls_column + "_t.AccessibleDescription='" + ls_heading + "'"
			END IF
			// JasonS 07/15/02 Track 3066d - End
			// GaryR	05/16/02	Track 3066d - End

			ls_modify  = ls_modify + " " + ls_column + "_t.Visible='1'"
			ls_modify  = ls_modify + " " + ls_column + ".Visible='1'"
 		Else
			ls_modify  = " " + ls_column + ".Visible='0'"
			If adw.Object.DataWindow.Processing = '1' then
			else
				//if free form you must hide both label and field
				ls_modify  = ls_modify + " " + ls_column + "_t.Visible='0'"
			End If
			return ls_modify
		End If
//end if					// FDG 10/15/01

//If grid dw resize column for new label
If adw.Object.DataWindow.Processing = '1' then

	li_len = ids_dictionary_custom.object.elem_data_len [ll_find]
	ls_hold_data_type = Trim (ids_dictionary_custom.object.elem_data_type [ll_find])
	ls_text = ls_label

	// Look for control characters within the label and determine the 
	// largest number of characters to appear in the column header
	if match(ls_text, '~n') then
		li_position 	= 	pos(ls_text, '~n')
		ls_text1 		= 	left(ls_text, li_position - 1)
		ls_text2 		= 	mid(ls_text, li_position + 1)
		
		if len(ls_text1) >= len(ls_text2) then
			li_text_len	=	len(ls_text1)
		elseif len(ls_text2) > len(ls_text1) then
			li_text_len = 	len(ls_text2)
		end if
	elseif match(ls_text, '~r') then
		li_position 	= 	pos(ls_text, '~r')
		ls_text1 		= 	left(ls_text, li_position - 1)
		ls_text2 		= 	mid(ls_text, li_position + 1)

		if len(ls_text1) >= len(ls_text2) then
			li_text_len	=	len(ls_text1)
		elseif len(ls_text2) > len(ls_text1) then
			li_text_len = 	len(ls_text2)
		end if
	else
		li_text_len 	= 	len(ls_text)
	end if
	
	// Calculate the size of the column header in pixels by datatype.
	// 10 is the avg # of pixels per character, (for BOLD, SYSTEM 10 font). 
	if li_text_len >= 5 Then
		li_text_len = li_text_len * 8
	else
		li_text_len = li_text_len * lic_cap_char_pixels
	end if

	IF	gnv_sql.of_is_numeric_data_type (ls_hold_data_type)	THEN
		li_db_col_len	= 	round(li_len * ldc_number_pixels,0)
	ELSEIF gnv_sql.of_is_date_data_type (ls_hold_data_type)	THEN
		ls_disp_format = Trim(adw.getFormat(as_column))
		IF	trim(ls_disp_format)	>	' '	THEN
			li_len = Len( ls_disp_format )
		end if
		li_db_col_len	= 	round(li_len * ldc_number_pixels,0)
	ELSE
		//	Set the width based on display format for strings
		ls_disp_format = Trim( ids_dictionary_custom.object.disp_format[ll_find] )
		IF	trim(ls_disp_format)	>	' '	THEN
			IF IsNumber( ls_disp_format ) THEN li_len = Long( ls_disp_format )
		END IF
		
		li_db_col_len	= 	round(li_len * lic_cap_char_pixels,0)
	END IF
	
	// SAH 05/03/02 - Track 3013 - Begin
	// For the following datatypes, li_db_col_len = 0.   
	IF li_db_col_len = 0 THEN
		IF gnv_sql.of_is_number_data_type(ls_hold_data_type) THEN
			li_db_col_len = Round(8 * ldc_number_pixels, 0)
		ELSEIF gnv_sql.of_is_date_data_type(ls_hold_data_type)THEN
			li_db_col_len = Round(2 * ldc_number_pixels, 0)
		ELSEIF gnv_sql.of_is_money_data_type(ls_hold_data_type) THEN
			li_db_col_len = Round(11 * ldc_number_pixels, 0)
		ELSE
			li_db_col_len = Round(15 * ldc_number_pixels, 0)
		END IF
	END IF
	// SAH 05/03/02 - Track 3013 - END
	
	// Set the col length to the longest of the col hdr label width 
	// or the chars of data in the dictionary.
	if li_text_len > li_db_col_len then
		ls_text_len	= 	string(li_text_len)
	else	
		ls_text_len = 	string(li_db_col_len)
	end if
	
	// Modify column hdr font height and weight; and col data font 
	//	height and weight.
	// Set standard font face and column header underlining.
	ls_modify	= 	ls_modify + " " + ls_column + '.width= ~'' + ls_text_len + '~' '
End If

return ls_modify
end function

public function string uf_copy_pattern (string as_patt_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_copy_pattern
//
//	Arguments:	as_patt_id: The original pattern id
//
//	Returns:		String - The new pattern ID
//					""	=	Error
//
//	Description:
//		This function is called when a case is being referred.
//		This function will copy an existing pattern to create a new pattern.
//
//	Notes:	1.	When retrieving note_text in 5.1, use gnv_sql.of_get_note_text()
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	08/28/01	FDG	Stars 4.8.1  Created
//	09/17/02	GaryR	Track 4182c	Pass three unique key arguments for notes retrieval
//	04/06/05	GaryR	Track 4370d	Call UPDATEBLOB method instead of directly inserting
//										note text.  Also include NOTE_DESC in the Insert statement.
//
////////////////////////////////////////////////////////////////////////////////

n_cst_string	lnv_string			// Autoinstantiated

String		ls_new_patt_id,		&
				ls_note_text,			&
				ls_dept_id,				&
				ls_user_id,				&
				ls_note_rel_type,		&
				ls_note_sub_type,		&
				ls_note_rel_id,		&
				ls_note_id,				&
				ls_rte_ind,				&
				ls_note_desc

Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount,		&
				ll_case_row

Integer		li_rc,					&
				li_refer_rc

DateTime		ldtm_current,			&
				ldtm_note_datetime
				
n_ds			lds_patt_rel,			&
				lds_patt_cntl,			&
				lds_patt_criteria,	&
				lds_patt_options,		&
				lds_patt_columns,		&
				lds_notes

//	Initialize data
ls_new_patt_id	=	fx_get_next_key_id('PATTERNID')
ls_new_patt_id	=	'USER'	+	lnv_string.of_padnumber (ls_new_patt_id, 6)

ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_patt_rel	=	CREATE	n_ds
lds_patt_rel.DataObject = 'd_patt_rel'
li_rc = lds_patt_rel.SetTransObject(Stars2ca)

lds_patt_cntl	=	CREATE	n_ds
lds_patt_cntl.DataObject = 'd_patt_cntl_patt_id'
li_rc = lds_patt_cntl.SetTransObject(Stars2ca)

lds_patt_criteria	=	CREATE	n_ds
lds_patt_criteria.DataObject = 'd_patt_criteria_patt_id'
li_rc = lds_patt_criteria.SetTransObject(Stars2ca)

lds_patt_options		=	CREATE	n_ds
lds_patt_options.DataObject = 'd_patt_options'
li_rc = lds_patt_options.SetTransObject(Stars2ca)

lds_patt_columns	=	CREATE	n_ds
lds_patt_columns.DataObject = 'd_patt_columns'
li_rc = lds_patt_columns.SetTransObject(Stars2ca)

lds_notes	=	CREATE	n_ds
lds_notes.DataObject = 'd_notes'
li_rc = lds_notes.SetTransObject(Stars2ca)


// Copy the patt_rel rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_patt_rel.Retrieve( as_patt_id )

li_rc	=	lds_patt_rel.RowsCopy ( 1, ll_rowcount, Primary!, lds_patt_rel, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_patt_rel.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_patt_rel.object.patt_id [ll_row]	=	ls_new_patt_id
NEXT

li_rc	=	lds_patt_rel.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_patt_id	=	''
	GoTo	exit_script
END IF


// Copy the patt_cntl rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_patt_cntl.Retrieve( as_patt_id )

li_rc	=	lds_patt_cntl.RowsCopy ( 1, ll_rowcount, Primary!, lds_patt_cntl, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_patt_cntl.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_patt_cntl.object.patt_id [ll_row]	=	ls_new_patt_id
NEXT

li_rc	=	lds_patt_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_patt_id	=	''
	GoTo	exit_script
END IF


// Copy the patt_criteria rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_patt_criteria.Retrieve( as_patt_id )

li_rc	=	lds_patt_criteria.RowsCopy ( 1, ll_rowcount, Primary!, lds_patt_criteria, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_patt_criteria.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_patt_criteria.object.patt_id [ll_row]	=	ls_new_patt_id
NEXT

li_rc	=	lds_patt_criteria.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_patt_id	=	''
	GoTo	exit_script
END IF


// Copy the patt_options rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_patt_options.Retrieve( as_patt_id )

li_rc	=	lds_patt_options.RowsCopy ( 1, ll_rowcount, Primary!, lds_patt_options, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_patt_options.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_patt_options.object.patt_id [ll_row]	=	ls_new_patt_id
NEXT

li_rc	=	lds_patt_options.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_patt_id	=	''
	GoTo	exit_script
END IF


// Copy the patt_columns rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_patt_columns.Retrieve( as_patt_id )

li_rc	=	lds_patt_columns.RowsCopy ( 1, ll_rowcount, Primary!, lds_patt_columns, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_patt_columns.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_patt_columns.object.patt_id [ll_row]	=	ls_new_patt_id
NEXT

li_rc	=	lds_patt_columns.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_patt_id	=	''
	GoTo	exit_script
END IF


// Copy the pattern notes.  For the newly inserted rows, change pattern ID in note_rel_id.
ll_rowcount	=	lds_notes.Retrieve( 'PA', as_patt_id )

FOR ll_row	=	1	TO	ll_rowcount
	ls_note_id				=	lds_notes.object.note_id [ll_row]
	// Retrieve the note_text separately
	//	09/17/02	GaryR	SPR 4182c - Begin
	ls_note_rel_type		=	lds_notes.object.note_rel_type [ll_row]
	ls_note_rel_id			=	lds_notes.object.note_rel_id [ll_row]
	ls_note_text	=	gnv_sql.of_get_note_text( ls_note_id, ls_note_rel_type, ls_note_rel_id )
	//	09/17/02	GaryR	SPR 4182c - End
	ls_note_id				=	fx_get_next_key_id('NOTE')
	ls_dept_id				=	lds_notes.object.dept_id [ll_row]
	ls_user_id				=	lds_notes.object.user_id [ll_row]
	ls_note_sub_type		=	lds_notes.object.note_sub_type [ll_row]
	ls_note_rel_id			=	ls_new_patt_id
	ldtm_note_datetime	=	lds_notes.object.note_datetime [ll_row]
	ls_rte_ind				=	lds_notes.object.rte_ind [ll_row]
	ls_note_desc 			=	lds_notes.object.note_desc[ll_row]
	
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
			note_desc)
	Values (:is_refer_dept,
			:ls_user_id,
	 		:ls_note_rel_type,
			:ls_note_sub_type,
			:ls_note_rel_id,
			:ls_note_id,
			:ldtm_note_datetime,
			' ',
			:ls_rte_ind,
			:ls_note_desc)
	Using stars2ca;
	IF	Stars2ca.of_check_status()	<>	0		THEN
		ls_new_patt_id	=	''
		Stars2ca.of_rollback()
		GoTo	exit_script
	END IF
	
	IF gnv_sql.of_set_note_text( ls_note_text, ls_note_id, ls_note_rel_type, ls_note_rel_id ) < 0 THEN
		ls_new_patt_id	=	''
		Stars2ca.of_rollback()
		GoTo	exit_script
	END IF
NEXT

exit_script:

IF	IsValid(lds_patt_rel)			THEN	Destroy lds_patt_rel
IF	IsValid(lds_patt_cntl)			THEN	Destroy lds_patt_cntl
IF	IsValid(lds_patt_criteria)		THEN	Destroy lds_patt_criteria
IF	IsValid(lds_patt_options)		THEN	Destroy lds_patt_options
IF	IsValid(lds_patt_columns)		THEN	Destroy lds_patt_columns
IF	IsValid(lds_notes)				THEN	Destroy lds_notes

Return	ls_new_patt_id
end function

public function string uf_copy_pdq (string as_query_id);////////////////////////////////////////////////////////////////////////////////
//	Script:		uf_copy_pdq
//
//	Arguments:	as_query_id: The original query id
//
//	Returns:		String - The new query ID
//					""	=	Error
//
//	Description:
//		This function is called when a case is being referred.
//		This function will copy an existing pre-defined query (PDQ) to 
//		create a new PDQ.
//
//	Notes:	1.	When retrieving note_text in 5.1, use gnv_sql.of_get_note_text()
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	08/28/01	FDG	Stars 4.8.1	Created
// 05/28/02	GaryR	Track 2552d Predefined Report (PDR)
//	09/17/02	GaryR	Track 4182c	Pass three unique key arguments for notes retrieval
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	04/06/05	GaryR	Track 4370d	Call UPDATEBLOB method instead of directly inserting
//										note text.  Also include NOTE_DESC in the Insert statement.
//
////////////////////////////////////////////////////////////////////////////////

String		ls_new_query_id,		&
				ls_note_text,			&
				ls_dept_id,				&
				ls_user_id,				&
				ls_note_rel_type,		&
				ls_note_sub_type,		&
				ls_note_rel_id,		&
				ls_note_id,				&
				ls_rte_ind,				&
				ls_note_desc

Long			ll_row,					&
				ll_rowcount,			&
				ll_new_row,				&
				ll_new_rowcount,		&
				ll_case_row

Integer		li_rc,					&
				li_refer_rc

DateTime		ldtm_current,			&
				ldtm_note_datetime
				
n_ds			lds_pdq_cntl,			&
				lds_pdq_criteria,		&
				lds_pdq_tables,		&
				lds_pdq_columns,		&
				lds_notes,				&
				lds_pdr_sources

//	Initialize data
ls_new_query_id	=	fx_get_next_key_id('PDQ_TMP_ID')

ldtm_current	=	gnv_app.of_get_server_date_time()

// Create the datastores
lds_pdq_cntl	=	CREATE	n_ds
lds_pdq_cntl.DataObject = 'd_pdq_cntl'
li_rc = lds_pdq_cntl.SetTransObject(Stars2ca)

lds_pdq_criteria	=	CREATE	n_ds
lds_pdq_criteria.DataObject = 'd_pdq_criteria'
li_rc = lds_pdq_criteria.SetTransObject(Stars2ca)

lds_pdq_tables		=	CREATE	n_ds
lds_pdq_tables.DataObject = 'd_pdq_tables'
li_rc = lds_pdq_tables.SetTransObject(Stars2ca)

lds_pdq_columns	=	CREATE	n_ds
lds_pdq_columns.DataObject = 'd_pdq_columns'
li_rc = lds_pdq_columns.SetTransObject(Stars2ca)

lds_notes	=	CREATE	n_ds
lds_notes.DataObject = 'd_notes'
li_rc = lds_notes.SetTransObject(Stars2ca)

lds_pdr_sources	=	CREATE	n_ds
lds_pdr_sources.DataObject = 'd_pdr_sources'
li_rc = lds_pdr_sources.SetTransObject(Stars2ca)

// Copy the pdq_cntl rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_pdq_cntl.Retrieve( as_query_id )

li_rc	=	lds_pdq_cntl.RowsCopy ( 1, ll_rowcount, Primary!, lds_pdq_cntl, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_pdq_cntl.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_pdq_cntl.object.query_id [ll_row]	=	ls_new_query_id
	IF	is_refer_user	>	' '		THEN
		lds_pdq_cntl.object.user_id [ll_row]	=	is_refer_user
	END IF
NEXT

li_rc	=	lds_pdq_cntl.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_query_id	=	''
	GoTo	exit_script
END IF


// Copy the pdq_criteria rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_pdq_criteria.Retrieve( as_query_id )

li_rc	=	lds_pdq_criteria.RowsCopy ( 1, ll_rowcount, Primary!, lds_pdq_criteria, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_pdq_criteria.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_pdq_criteria.object.query_id [ll_row]	=	ls_new_query_id
NEXT

li_rc	=	lds_pdq_criteria.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_query_id	=	''
	GoTo	exit_script
END IF


// Copy the pdq_tables rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_pdq_tables.Retrieve( as_query_id )

li_rc	=	lds_pdq_tables.RowsCopy ( 1, ll_rowcount, Primary!, lds_pdq_tables, ll_rowcount + 1, Primary! )

ll_new_rowcount	=	lds_pdq_tables.RowCount()

FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
	lds_pdq_tables.object.query_id [ll_row]	=	ls_new_query_id
NEXT

li_rc	=	lds_pdq_tables.Event	ue_update( TRUE, TRUE )	

IF	li_rc	<	0		THEN
	ls_new_query_id	=	''
	GoTo	exit_script
END IF


// Copy the pdq_columns rows.  For the newly inserted rows, change the pattern ID.
ll_rowcount	=	lds_pdq_columns.Retrieve( as_query_id )

// 05/28/02	GaryR	Track 2552d - Begin
IF ll_rowcount > 0 THEN
	li_rc	=	lds_pdq_columns.RowsCopy ( 1, ll_rowcount, Primary!, lds_pdq_columns, ll_rowcount + 1, Primary! )
	
	ll_new_rowcount	=	lds_pdq_columns.RowCount()
	
	FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
		lds_pdq_columns.object.query_id [ll_row]	=	ls_new_query_id
	NEXT
	
	li_rc	=	lds_pdq_columns.Event	ue_update( TRUE, TRUE )	
	
	IF	li_rc	<	0		THEN
		ls_new_query_id	=	''
		GoTo	exit_script
	END IF
END IF
// 05/28/02	GaryR	Track 2552d - End

// Copy the pdr_sources rows.  For the newly inserted rows, change the ID.
ll_rowcount	=	lds_pdr_sources.Retrieve( Double( as_query_id ) )

// 05/28/02	GaryR	Track 2552d - Begin
IF ll_rowcount > 0 THEN
	li_rc	=	lds_pdr_sources.RowsCopy ( 1, ll_rowcount, Primary!, lds_pdr_sources, ll_rowcount + 1, Primary! )
	
	ll_new_rowcount	=	lds_pdr_sources.RowCount()
	
	FOR ll_row	=	ll_rowcount + 1	TO	ll_new_rowcount
		lds_pdr_sources.object.pdr_link [ll_row]	=	Double( ls_new_query_id )
	NEXT
	
	li_rc	=	lds_pdr_sources.Event	ue_update( TRUE, TRUE )	
	
	IF	li_rc	<	0		THEN
		ls_new_query_id	=	''
		GoTo	exit_script
	END IF
END IF

// Copy the PDQ notes.  For the newly inserted rows, change query ID in note_rel_id.
ll_rowcount	=	lds_notes.Retrieve( 'PQ', as_query_id )

FOR ll_row	=	1	TO	ll_rowcount
	ls_note_id				=	lds_notes.object.note_id [ll_row]
	// Retrieve the note_text separately
	//	09/17/02	GaryR	SPR 4182c - Begin
	//ls_note_text	=	gnv_sql.of_get_note_text( ls_note_id )
	ls_note_rel_type		=	lds_notes.object.note_rel_type [ll_row]
	ls_note_rel_id			=	lds_notes.object.note_rel_id [ll_row]
	ls_note_text	=	gnv_sql.of_get_note_text( ls_note_id, ls_note_rel_type, ls_note_rel_id )
	//	09/17/02	GaryR	SPR 4182c - End

	ls_note_id				=	fx_get_next_key_id('NOTE')
	ls_dept_id				=	lds_notes.object.dept_id [ll_row]
	ls_user_id				=	lds_notes.object.user_id [ll_row]
	ls_note_sub_type		=	lds_notes.object.note_sub_type [ll_row]
	ls_note_rel_id			=	ls_new_query_id
	ldtm_note_datetime	=	lds_notes.object.note_datetime [ll_row]
	ls_rte_ind				=	lds_notes.object.rte_ind [ll_row]
	ls_note_desc 			=	lds_notes.object.note_desc[ll_row]
	IF	is_refer_user	>	' '		THEN
		//ls_user_id			=	is_refer_user				// Change per KayKay's request (4.8.1.014)
	END IF
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
			note_desc)
	Values (:is_refer_dept,
			:ls_user_id,
	 		:ls_note_rel_type,
			:ls_note_sub_type,
			:ls_note_rel_id,
			:ls_note_id,
			:ldtm_note_datetime,
			' ',
			:ls_rte_ind,
			:ls_note_desc)
	Using stars2ca;
	IF	Stars2ca.of_check_status()	<>	0		THEN
		ls_new_query_id	=	''
		Stars2ca.of_rollback()
		GoTo	exit_script
	END IF
	
	IF gnv_sql.of_set_note_text( ls_note_text, ls_note_id, ls_note_rel_type, ls_note_rel_id ) < 0 THEN
		ls_new_query_id	=	''
		Stars2ca.of_rollback()
		GoTo	exit_script
	END IF
NEXT

exit_script:

IF	IsValid(lds_pdq_cntl)			THEN	Destroy lds_pdq_cntl
IF	IsValid(lds_pdq_criteria)		THEN	Destroy lds_pdq_criteria
IF	IsValid(lds_pdq_tables)			THEN	Destroy lds_pdq_tables
IF	IsValid(lds_pdq_columns)		THEN	Destroy lds_pdq_columns
IF	IsValid(lds_notes)				THEN	Destroy lds_notes

Return	ls_new_query_id
end function

public function integer uf_format_custom_headings (datawindow adw);///////////////////////////////////////////////////////////////////////////////////////
//
//This function will dynamically modify the headings for all of the custom columns.
//
///////////////////////////////////////////////////////////////////////////////////////
// Change History:
//
// FDG	01/14/01	Stars 4.6 (PIMR) - Add PIMR data
// FDG	10/15/01	Stars 4.8.1.  Include all displayable case columns.
// SAH	02/06/02   Stars 4.8.1   Add d_case_log columns previously omitted
// SAH	03/18/02   Stars 5.1     Case Log is now completely mapped to Dictionary table, 
//										  n_cst_labels.of_labels2() handles all formatting for log
// GaryR	05/16/02	Track 3066d	Enable the visibility setting for columns.
// JasonS 07/15/02 Track 3066d Added case_datetime to list of fields
// JasonS 10/31/02 Track 3287d Removed changes made in track 3287d and added
//						 fields in that were added after track 3287d
// JasonS 11/21/02 Fix pb8 bug
// Katie	 12/29/05 Track 4186d Added new columns for the Track Payment Entry.
// Katie	11/20/06	SPR 4763 Added prov_id_type column.
//
///////////////////////////////////////////////////////////////////////////////////////

string ls_rc
string ls_modify

// JasonS 11/21/02 Bug with pb8, have to use DataWindow.Table.SQLSelect in 
// uf_get_custom_headings, we need to set trans object or this will return
// the PBSELECT
adw.settransobject(stars2ca)	

// JasonS 10/31/02 Track 3287d  
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'alert_ind')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'create_datetime')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'date_req')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'date_rev')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'disp')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'from_period')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'op_type')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'status')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'status_desc')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'to_period')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_desc')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_key')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_key_alt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_name')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_rel_key')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_rel_type')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'trk_type')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'prov_id_type')
// JasonS 10/31/02 Track 3287d


//only change customizeable fields
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'identified_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'op_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'amt_recv')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'balance_remaining_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'recovered_addtl_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'future_savings_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'referred_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'amt_writeoff')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_custom1_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_custom2_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_custom3_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'custom1_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'custom2_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'custom3_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'custom4_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'custom5_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'custom6_amt')

// FDG 01/14/01	Add PIMR data
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_contractor_id')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_ready_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_ready_date')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_created_date')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_prov_type_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom1_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom1_char')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom1_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom2_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom4_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom5_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom6_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom3_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom4_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom5_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom7_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom1_date')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom2_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom3_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_frd_rfrl_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_acpt_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_ready_user')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_created_user')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_prov_spec')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom8_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom9_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom6_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom7_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_case_custom8_cnt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom2_char')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom4_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom5_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom2_date')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_custom3_date')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_subject_id')
// FDG 01/14/01 - end

// FDG 10/15/01.	Include all columns that headings need to be dynamic.
//						Columns commented out should remain hard-coded
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_id')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_spl')				// GaryR	05/16/02	Track 3066d
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_ver')				// GaryR	05/16/02	Track 3066d
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_desc')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_type')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_cat')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'dept_id')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_business')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_asgn_date')		// GaryR	05/16/02	Track 3066d
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_date_recv')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_asgn_id')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'user_id')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_from_period')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_to_period')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_disp')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_status')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_status_date')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_status_desc')	// GaryR	05/16/02	Track 3066d
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_datetime')	// JasonS 07/15/02 Track 3066d
// FDG 10/15/01 end

// SAH 02/06/02 -Begin
// GaryR	05/16/02	Track 3066d - Begin
// These columns need to be processed in case the 
// users don't want to see them on the screen.
//	However, the labels will need to remain hardcoded on the datawindow.
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_updt_user')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'sys_datetime')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'case_edit')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'pmr_created_cd')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'status_datetime')
// GaryR	05/16/02	Track 3066d - End

//Katie 12/23/04 Track 4186
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'payment_amt')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'payment_type')
ls_modify = ls_modify + " " + This.uf_get_modify_heading (adw, 'check_no')

// If anything exists in ls_modify, modify adw.
IF  Len (ls_modify)  > 0  THEN
	ls_rc = adw.Modify (ls_modify)
END IF

return 1
end function

public function string uf_get_comp_upd_status (string as_comp_id, string as_case_id, string as_case_spl, string as_case_ver);//*********************************************************************************
// Script Name:	uf_get_comp_upd_status
//
//	Arguments:		string - as_comp_id - component id
//						string - as_case_id - case_id
//						string - as_case_spl - case spl
//						string - as_case_ver - case version
//
// Returns:			String - AO, RO, or AL
//
//	Description:	This method will check the component status code and the case status
//						to return the appropriate status of Add Only (AO), Read Only (RO), or ALL (AL)
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
// 09/16/05 MikeF	SPR4512d	Can't add subset notes when attached to a case.
//*********************************************************************************
int 				li_comp_status
string 			ls_case_status
u_nvo_sys_cntl	lnv_sys_cntl

lnv_sys_cntl = CREATE u_nvo_sys_cntl
lnv_sys_cntl.of_set_cntl_id( as_comp_id )
li_comp_status = lnv_sys_cntl.of_get_cntl_no( )

select a.case_status 
into :ls_case_status
from case_cntl a, code b
where a.case_status = b.code_code
and b.code_type = 'SA'
and UPPER(b.code_value_a) = UPPER('CLOSED')
and a.case_id = :as_case_id
and a.case_spl = :as_case_spl
and a.case_ver = :as_case_ver
using stars2ca;

CHOOSE CASE li_comp_status
	CASE 1 
		return 'AO' 		// Add Only
	CASE 2 
		IF isnull(ls_case_status) OR trim(ls_case_status) = '' then
			RETURN 'AL'		// Case Open - Add / Update / Delete
		ELSE
			RETURN 'RO'		// Case Closed - Read Only
		END IF
	CASE 3 
		return 'AL'			// Add / Update / Delete for any status w/o closed message
END CHOOSE

RETURN ''

end function

public function boolean uf_get_link_exists (string as_case_id, string as_case_spl, string as_case_ver, string as_link_type, string as_link_name);//======================================================================================//
// Object:		n_cst_case
//	Script:		uf_get_link_exists
//	Arguments:	String	as_case_id
//					String	as_case_spl
//					String	as_case_ver
//					String	as_link_type
//					String	as_link_name
//	Returns:		Boolean	TRUE if a row exists in CASE_LINK
//======================================================================================//
//	Determines if a case link row exists
//======================================================================================//
//	Maintenance
// -------- ----- -------- -------------------------------------------------------------
// 06/07/05	MikeF	SPR4319d	Created
//======================================================================================//
string		ls_sql
int			li_count
u_nvo_count	lnv_count

lnv_count = CREATE u_nvo_count
lnv_count.uf_set_transaction(stars2ca)

ls_sql = "SELECT COUNT(*) FROM CASE_LINK " + &
			"WHERE LINK_TYPE = '" 	+ trim(Upper(as_link_type))	+ "' " + &
			"AND LINK_NAME = '" 		+ trim(Upper(as_link_name))	+ "' " + &
			"AND CASE_ID = '" 		+ trim(Upper(as_case_id))		+ "' "

IF trim(as_case_id) <> "NONE" THEN
	ls_sql	+=	"AND CASE_SPL = '"	+ trim(Upper(as_case_spl))		+ "' " + &
					"AND CASE_VER = '"	+ trim(Upper(as_case_ver))		+ "'"
END IF

lnv_count.uf_set_sql(ls_sql)
li_count = lnv_count.uf_get_count()

RETURN li_count <> 0 



end function

public function boolean uf_edit_case_deleted (string as_case_id, string as_case_spl, string as_case_ver);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_deleted
//
//	Arguments:	1.	as_case_id
//					2.	as_case_spl
//					3.	as_case_ver
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not deleted.
//					FALSE	=	Edit failed - case was deleted.
//
//	Description:
//		This script determines if a case was deleted.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	09/12/06  Katie		SPR 4726 Created
//////////////////////////////////////////////////////////////////

String	ls_case_status

Constant	String	lcs_deleted	=	'DL'
Constant String   lcs_referred = 'RC'


Integer	li_rc

IF	IsNull (as_case_id)							&
OR	Trim(as_case_id)				=	''			&
OR	Upper ( Trim(as_case_id) )	=	'NONE'	THEN
	Return	TRUE
END IF

Select	case_status
Into		:ls_case_status
From		case_cntl
Where		case_id		=	:as_case_id
  and		case_spl		=	:as_case_spl
  and		case_ver		=	:as_case_ver
Using		Stars2ca;

li_rc	=	Stars2ca.of_check_status()

IF	li_rc	>	0		THEN
	// Row not found, return true
	Return	TRUE
END IF

IF	Upper(ls_case_status)	=	lcs_deleted		&
OR Upper(ls_case_status)   =  lcs_referred   THEN
	Return	FALSE
ELSE
	Return	TRUE
END IF
	

end function

public function boolean uf_edit_case_deleted (string as_case_id);//////////////////////////////////////////////////////////////////
//
//	Script:		n_cst_case.uf_edit_case_deleted
//
//	Arguments:	1.	as_case_id
//
//	Returns:		Boolean
//					TRUE	=	Edit passed - case not deleted or referred closed.
//					FALSE	=	Edit failed - case wasdeleted or referred closed.
//
//	Description:
//		This script determines if a case was deleted or referred closed.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	09/12/2006  Katie		SPR 4726 Created
//
//////////////////////////////////////////////////////////////////

String	ls_case_id,			&
			ls_case_spl,		&
			ls_case_ver

ls_case_id	=	Left( as_case_id, 10 )
ls_case_spl	=	Mid( as_case_id, 11, 2 )
ls_case_ver	=	Mid( as_case_id, 13, 2 )

Return	This.uf_edit_case_deleted( ls_case_id, ls_case_spl, ls_case_ver )	



end function

public function string uf_get_comp_upd_status_lead (string as_comp_id, string as_case_id, string as_case_spl, string as_case_ver);//*********************************************************************************
// Script Name:	uf_get_comp_upd_status_lead
//
//	Arguments:		string - as_comp_id - component id
//						string - as_case_id - case_id
//						string - as_case_spl - case spl
//						string - as_case_ver - case version
//
// Returns:			String - AO, RO, or AL
//
//	Description:	This method will check the component status code and the case status
//						to return the appropriate status of Add Only (AO), Read Only (RO), or ALL (AL)
//					This was created to handle some issues with RC and DEL cases when the sys_cntl = 1
//
//*********************************************************************************
//
//	12/06/04	Katie 	Track 4726	Created.
//*********************************************************************************
int 				li_comp_status
string 			ls_case_status
u_nvo_sys_cntl	lnv_sys_cntl

lnv_sys_cntl = CREATE u_nvo_sys_cntl
lnv_sys_cntl.of_set_cntl_id( as_comp_id )
li_comp_status = lnv_sys_cntl.of_get_cntl_no( )

select a.case_status 
into :ls_case_status
from case_cntl a, code b
where a.case_status = b.code_code
and b.code_type = 'SA'
and UPPER(b.code_value_a) = UPPER('CLOSED')
and a.case_id = :as_case_id
and a.case_spl = :as_case_spl
and a.case_ver = :as_case_ver
using stars2ca;

CHOOSE CASE li_comp_status
	CASE 1 
		IF isnull(ls_case_status) OR trim(ls_case_status) = '' then
			RETURN 'AO'		// Case Open - Add Only
		ELSE
			RETURN 'RO'		// Case Closed - Read Only
		END IF
	CASE 2 
		IF isnull(ls_case_status) OR trim(ls_case_status) = '' then
			RETURN 'AL'		// Case Open - Add / Update / Delete
		ELSE
			RETURN 'RO'		// Case Closed - Read Only
		END IF
	CASE 3 
		return 'AL'			// Add / Update / Delete for any status w/o closed message
END CHOOSE

RETURN ''

end function

on n_cst_case.create
call super::create
end on

on n_cst_case.destroy
call super::destroy
end on

event constructor;//n_cst_case::constructor()
//	Description:
//	1.	Create the instance datastore that will be used to
//		retrieve the column data for Case_cntl, Case_log
//    Track, and Track_Log
//		This datastore will use 'd_dictionary_custom'
// 2.	After the retrieve, format the datastore column
//		by removing the '/' and everything to the right
//	3.	Create the datastore for case security
/////////////////////////////////////////////////////////
// Modification History
//
//	FDG	10/11/01	Stars 4.8.1.	Create ids_case, ids_case_log
//	GaryR	05/21/02	Track 3061d	Resolve user_id columns on case_log
//
/////////////////////////////////////////////////////////

integer li_rc
long ll_rows
string ls_inv_type
string ls_invoice[4]

// FDG 10/11/01	begin
ids_case		=	CREATE	n_ds
ids_case.DataObject	=	'd_case_general'
li_rc = ids_case.SetTransObject (Stars2ca)

ids_case_log		=	CREATE	n_ds
ids_case_log.DataObject	=	'd_case_log'
li_rc = ids_case_log.SetTransObject (Stars2ca)
li_rc = ids_case_log.of_SetTrim( TRUE )			//	GaryR	05/21/02	Track 3061d
// FDG 10/11/01 end

//get the invoice type for Tables
ls_invoice[1] = gnv_dict.event ue_get_inv_type('CASE_CNTL')
ls_invoice[2] = gnv_dict.event ue_get_inv_type('CASE_LOG')
ls_invoice[3] = gnv_dict.event ue_get_inv_type('TRACK')
ls_invoice[4] = gnv_dict.event ue_get_inv_type('TRACK_LOG')


ids_dictionary_custom = CREATE n_ds
ids_dictionary_custom.dataobject = 'd_dictionary_tbl_types'
li_rc = ids_dictionary_custom.setTransObject(stars2ca)
if li_rc <> 1 then
	Messagebox('STARS','Error in SetTransObject for ids_dictionary_custom'+&
						'~rin n_cst_case::constructor()')
	return -1
end if

//retrieve elem_desc from dictionary
ll_rows = ids_dictionary_custom.retrieve(ls_invoice[])
if ll_rows < 1 then
	Messagebox('STARS','Error retrieving from '+&
						'Dictionary for ids_dictionary_custom' +&
						'~rin n_cst_case::constructor()')
	return -1
end if

//format by removing the '/' and everything to the right
li_rc = this.uf_format_elem_desc(ids_dictionary_custom)


//create the datastore for case security
ids_code = CREATE n_ds
ids_code.dataobject = 'd_code_case_cat'
li_rc = ids_code.SetTransObject(stars2ca)
if li_rc <> 1 then
	Messagebox('STARS','Error in SetTransObject for ids_code'+&
						'~rin n_cst_case::constructor()')
	return -1
end if

ll_rows = ids_code.retrieve()



end event

event destructor;call super::destructor;/////////////////////////////////////////////////////////
// Modification History
//
//	FDG	10/11/01	Stars 4.8.1.	Destroy objects created
//						in constructor.
//
/////////////////////////////////////////////////////////

IF	IsValid (ids_case)		THEN
	Destroy	ids_case
END IF

IF	IsValid (ids_case_log)		THEN
	Destroy	ids_case_log
END IF

IF	IsValid (ids_dictionary_custom)		THEN
	Destroy	ids_dictionary_custom
END IF

IF	IsValid (ids_code)		THEN
	Destroy	ids_code
END IF

end event

