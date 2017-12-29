$PBExportHeader$w_subset_options.srw
$PBExportComments$Inherited from w_master
forward
global type w_subset_options from w_master
end type
type dw_bg_step_cntl from u_dw within w_subset_options
end type
type dw_bg_sql_line from u_dw within w_subset_options
end type
type dw_sub_opt_case_link from u_dw within w_subset_options
end type
type dw_criteria_used from u_dw within w_subset_options
end type
type dw_criteria_from_tbls_used from u_dw within w_subset_options
end type
type dw_criteria_used_line from u_dw within w_subset_options
end type
type cb_ok from u_cb within w_subset_options
end type
type cb_pattern from u_cb within w_subset_options
end type
type cb_cancel from u_cb within w_subset_options
end type
type dw_subset_options from u_dw within w_subset_options
end type
end forward

global type w_subset_options from w_master
string accessiblename = "Subset Options"
string accessibledescription = "Subset Options"
integer x = 187
integer y = 176
integer width = 2021
integer height = 1476
string title = "Subset Options"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type integer ue_general_edits ( )
event ue_get_default_sched_time ( )
event type integer ue_insert_case_link ( string arg_status )
event type integer ue_write_subset_request ( )
event ue_insert_criteria ( )
event type integer ue_write_bg_step_cntl ( )
event type integer ue_check_job_id ( )
event type integer ue_call_rpc_create_subset ( )
event ue_copy_notes ( )
event type integer ue_verify_case_id ( string as_case_id )
event type integer ue_verify_date ( )
event ue_sched_change ( integer ai_schedule )
event ue_compute_schedule_date ( )
event type integer ue_verify_active_case ( )
event type integer ue_validateclaimsrange ( )
dw_bg_step_cntl dw_bg_step_cntl
dw_bg_sql_line dw_bg_sql_line
dw_sub_opt_case_link dw_sub_opt_case_link
dw_criteria_used dw_criteria_used
dw_criteria_from_tbls_used dw_criteria_from_tbls_used
dw_criteria_used_line dw_criteria_used_line
cb_ok cb_ok
cb_pattern cb_pattern
cb_cancel cb_cancel
dw_subset_options dw_subset_options
end type
global w_subset_options w_subset_options

type variables
boolean ib_pattern_button
datetime idt_default_sched_datetime
datetime idt_default_datetime
datetime idt_current_datetime

integer ii_crit_level, ii_max_level, ii_level, ii_total_steps, ii_run_frequency

Long il_job_id		// 03/23/01	GaryR	Stars Server
long il_bg_step_cntl_count
long il_bg_sql_line_count

string is_job_id
string is_prev_subsets[]
string is_step_level

nvo_subset_functions inv_subset_functions
u_nvo_subset iu_nvo_subset // 02/15/06 HYL Track 4651

sx_subset_options istr_sub_opt 
sx_subset_ids istr_subset_ids

//NLG 6-4-98
integer ii_from_date_rule, ii_thru_date_rule
string is_orig_subset_name
string is_orig_subset_case_id
end variables

forward prototypes
public function integer wf_retrieve_case_desc (string as_case_id)
public function integer wf_get_previous_crit (sx_source_subset arg_subset_src_name[], string arg_prev_sub_src_type, string arg_crit_used_type, ref string arg_step_id)
public function integer of_getdependants (string as_main_invoice, ref string as_dependants[])
public function string of_getdescription (string as_inv_type)
end prototypes

event type integer ue_general_edits();/////////////////////////////////////////////////////////////////////////////////
// Script:		ue_general_edits
//
// Returns:		Integer
//
// Description:
// 	Checks job id, subset name and description, and case id
//
/////////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
// AJS      07-13-98    4.0 Add logic to prevent duplicate subset 
//                      in case or duplicate independent subsets.
//	NLG		06-25-98		Track #1340 - check security of case
// AJS   	03-11-98 	4.0 fix split of case id
//	AJS		01/01/98		Created.
//	FNC		09/01/98		Track 1340 - Check if case exists, is not closed and not 
//								deleted before checking for security
// FNC		10/29/98		Track 1772. If case is not valid clear out case id
//								and case description fields.Track 1772. If case is not valid clear out case id
//								and case description fields.
//	FDG		01/19/99		Track 2055c.  Display 4 digit year.
// AJS 		01/21/99    FS2065c.  Validate date. Show date & desc to user
//	NLG		08/16/99		ts2363c. Remove references to nvo_case_functions,
//								nvo_subset_functions.
// FNC		02/10/00		Fraud PDQ's set default message to include word recurring
//								for recurring subsets
//	FDG		03/27/00		Track 2160d.  Remove SetText and do a SetItem instead.
//	GaryR		03/22/01		Stars 4.7 Implement Stars Server Functionality
//	GaryR		06/14/01		Track	3472c	Unable to SavaAs subset from subset maintenance
//	GaryR		08/10/01		Track 2390d	Redesign the immediate subset scheduling logic
//	FDG		01/31/02		Track 2759d, 2443d, 2589d.  Prevent a 'Save As' ('COPY') 
//								when the combination of Subset ID and Case ID already exists.
//	GaryR		04/25/03		Track 3464d	Validate the recurrence schedule of source subset
//	GaryR		05/13/03		Track 3464d	Do not allow changing recurrence on pattern subset
/////////////////////////////////////////////////////////////////////////////////
long ll_rows, ll_row, ll_count
integer li_rc
integer li_return
string ls_name, ls_case_id, ls_desc_date_time, ls_desc
string ls_active_case_id, ls_active_case_spl, ls_active_case_ver
string ls_single_quote, ls_double_quote, ls_sched_date
String	ls_job_id	//	GaryR		03/22/01		Stars 4.7
//u_nvo_case_functions luo_case_functions
//nvo_subset_functions luo_subset_functions

ls_single_quote = "'"; ls_double_quote = '"'

//get the row number
ll_row = dw_subset_options.GetRow()

//	GaryR		03/22/01		Stars 4.7 - Begin
// Validate the job id
ls_job_id = dw_subset_options.getitemstring(1, "job_id" )
IF IsNull( ls_job_id ) OR Trim( ls_job_id ) = "" THEN
	dw_subset_options.SetItem( 1, "job_id", is_job_id )
END IF
//	GaryR		03/22/01		Stars 4.7 - End


//The subset name field is checked to determine if the user entered a subset name. 
//If the subset name was not entered it is defaulted to the subset id.

ls_name = dw_subset_options.getitemstring(ll_row,'subc_name')
If ls_name = '' or IsNull(ls_name) then
	istr_sub_opt.subset_name = istr_sub_opt.subset_id
	dw_subset_options.Setitem(ll_row,'subc_name', istr_sub_opt.subset_id)
Else
	// FNC 11/25/98 Start
	if match(ls_name,ls_single_quote) or match(ls_name,ls_double_quote) then
		//Messagebox("WARNING","Subset ID cannot contain quotes",StopSign!,Ok!)
		MessageBox('EDIT', 'Quotation Marks Found in Subset Name.  Subset Name Cannot Contain Quotes.  Please remove.', &
						StopSign!, Ok!)
		return -1
	end if
	// FNC 11/25/98 End
	Istr_sub_opt.subset_name = ls_name
End if



//If subset is scheduled, verify that valid schedule date has been entered. Check 
//only when a subset is created.
Choose Case istr_sub_opt.come_from
		Case 'QUERY','PATTERN','PATTSUB','REPSUB'	
			if Long(dw_subset_options.getitemnumber(1,'sched')) > 0 then
//				AJS 01-21-99 begin
//				if not isdate(string(date(dw_subset_options.getitemdatetime(1,'sched_date')))) &			
//					or IsNull(dw_subset_options.getitemdatetime(1,'sched_date')) then
				li_rc = w_subset_options.event ue_verify_date()
				if li_rc <> 1 then
//				AJS 01-21-99 end
					li_rc = Messagebox("WARNING","Schedule date is not valid. " +&
											"Would you like to use the default schedule date?",Question!,YesNo!)	

					if li_rc = 1 then
						dw_subset_options.setitem(1,'sched_date', idt_default_sched_datetime)
					else
						return 100
					end if
				end if
			else
				dw_subset_options.setitem(1,'sched_date', idt_default_datetime)
			end if
		Case else
			dw_subset_options.setitem(1,'sched_date', idt_default_datetime)
End Choose

//Determine if subset description is entered if not, set a default description.
If Len(dw_subset_options.getitemstring(ll_row,'subc_desc')) = 0 or &
	IsNull(Len(dw_subset_options.getitemstring(1,'subc_desc'))) then
	if Long(dw_subset_options.getitemnumber(1,'sched')) > 0 then
		//ls_desc_date_time = String(dw_subset_options.getitemdatetime(1,'sched_date'))	// FDG 01/19/99
		ls_desc_date_time = String(dw_subset_options.getitemdatetime(1,'sched_date'), 'm/d/yyyy hh:mm')	// FDG 01/19/99
	else
		//ls_desc_date_time = String(idt_current_datetime)	// FDG 01/19/99
		ls_desc_date_time = String(idt_current_datetime, 'm/d/yyyy hh:mm')	// FDG 01/19/99
	end if
	Choose Case istr_sub_opt.come_from
		Case 'COPY','LINK'
			dw_subset_options.setitem(ll_row,'subc_desc', 'Subset copied on ' &
			 + ls_desc_date_time )
		Case 'ARCHIVE'
			dw_subset_options.setitem(ll_row,'subc_desc', 'Subset archive request created on ' &
			 + ls_desc_date_time )
		Case else
			if Long(dw_subset_options.getitemnumber(1,'sched')) > 0 then
				if dw_subset_options.getitemnumber(1,'run_frequency') > 0 then					// FNC 02/10/00 Start
					/*recurring subset */
					dw_subset_options.setitem(ll_row,'subc_desc', 'Recurring subset ' + &
						istr_sub_opt.subset_name + ' orig sched ' + ls_desc_date_time )
				else
					dw_subset_options.setitem(ll_row,'subc_desc', 'Subset scheduled for creation on ' &
						 + ls_desc_date_time )
				end if															// FNC 02/10/00 End
			else
				//	GaryR		08/10/01		Track 2390d
				//dw_subset_options.setitem(ll_row,'subc_desc', 'Subset created on ' &
				dw_subset_options.setitem(ll_row,'subc_desc', 'Subset scheduled for immediate creation on ' &
				 + ls_desc_date_time )
			end if
	End choose
else
	ls_desc = dw_subset_options.getitemstring(1,'subc_desc')
	if pos(ls_desc,'"') > 0 then
		//messagebox('WARNING','May not have a quote in the job description.')
		MessageBox('EDIT', 'Subset Description May Not Contain Quotation Marks.')
		return -1
	end if
	if pos(ls_desc,"'") > 0 then
		//messagebox('WARNING','May not have a quote in the job description.')
		MessageBox('EDIT', 'Subset Description May Not Contain Quotation Marks.')
		return -1
	end if
end if

// FDG 03/27/00 Begin - Unnecessary code since itemchanged event does nothing with subc_desc
//ls_desc	=	dw_subset_options.getitemstring(1,'subc_desc')
//dw_subset_options.SetColumn('subc_desc')									
//dw_subset_options.SetText(ls_desc)									
//dw_subset_options.AcceptText()	
// FDG 03/27/00 End

//The case id field is interrogated  so that it is split into the case_id, case_spl  and case_ver correctly.
If dw_subset_options.getitemnumber(ll_row,'link') = 0 then
	istr_sub_opt.case_id = 'NONE'
	istr_sub_opt.case_spl = ''
	istr_sub_opt.case_ver = ''
Else
	ls_case_id = dw_subset_options.getitemstring(ll_row,'case_id')
// FNC 09/01/98 Start
//	//NLG Track #1340 - check case security 
//	Li_rc = Inv_Subset_Functions.UF_Determine_Case_Security(ls_case_id)	//NLG Track #1340
//	if li_rc = 0 then																		//NLG Track #1340
//		istr_sub_opt.case_id = left(ls_case_id,10)
//		istr_sub_opt.case_spl = mid(ls_case_id,11,2)
//		istr_sub_opt.case_ver = mid(ls_case_id,13,2)	// AJS   03-11-98 4.0 fix split of case id
//	elseif li_rc = 100 then																//NLG Track #1340
//		Messagebox('EDIT ERROR','This is a Secured Case. ~rYou have insufficient privileges to work with this case.')
//		return -1
//	else																						//NLG Track #1340
//		Messagebox('EDIT ERROR','Unable determine case security for this case.  Cannot proceed')
//		return -1
//	end if																					//NLG Track #1340
	li_return = this.event ue_verify_case_id(ls_case_id)
	if li_return = 0 then
		istr_sub_opt.case_id = left(ls_case_id,10)
		istr_sub_opt.case_spl = mid(ls_case_id,11,2)
		istr_sub_opt.case_ver = mid(ls_case_id,13,2)
	else
		dw_Subset_Options.Object.case_id[1] = '' 				// FNC 10/29/98 
		dw_Subset_Options.Object.case_desc[1] = '' 			// FNC 10/29/98 
		return -1
	end if
End if
// FNC 09/01/98 Start

//Next, the subset name field is checked to make sure it is not a duplicate.
	istr_subset_ids.subset_case_id = istr_sub_opt.case_id
	istr_subset_ids.subset_case_spl = istr_sub_opt.case_spl
	istr_subset_ids.subset_case_ver = istr_sub_opt.case_ver
	istr_subset_ids.subset_name = istr_sub_opt.subset_name
	inv_subset_functions.uf_set_structure(istr_Subset_ids)
 	ll_rows = inv_subset_functions.uf_Retrieve_Subset_ID()
	if ll_rows < 0 then
		messagebox('Error','Error when searching for duplicate subset name')
		return -1
	elseif ll_rows = 0 then
		//OK to continue; the subset id not found; the subset name is not a duplicate
	else
		//messagebox('Error','Error duplicate subset name.  Please use a different subset name.')
		MessageBox('Error','Duplicate Subset Name.  Please Enter Another Subset Name.')
		return -1
	end if

//AJS 07-13-98 4.0 
//Next, Check to ensure subset is not already in this case or an indepedent subset.
// FDG 01/31/02 - Track 2759 - Prevent a duplicate subsetID/Case ID from being created.
//IF istr_sub_opt.come_from <> "COPY" THEN	//	GaryR		06/14/01		Track	3472c		// FDG 01/31/02
	istr_subset_ids.subset_case_id = istr_sub_opt.case_id
	istr_subset_ids.subset_case_spl = istr_sub_opt.case_spl
	istr_subset_ids.subset_case_ver = istr_sub_opt.case_ver
	istr_subset_ids.subset_id = istr_sub_opt.subset_id
	inv_subset_functions.uf_set_structure(istr_Subset_ids)
 	ll_rows = inv_subset_functions.uf_Retrieve_Subset_Name()
	if ll_rows < 0 then
		messagebox('Error','Error when searching for duplicate subset in case')
		return -1
	elseif ll_rows = 0 then
		//OK to continue; the subset id not found; the subset name is not a duplicate
	else
		IF istr_sub_opt.come_from = "COPY" THEN
			messagebox('Error','Cannot Copy Subset to This Case.  Change the Case ID to a Case that Is Unique to this Subset.')
		ELSE
			messagebox('Error','Attempt to create duplicate subset.  Subset already exists in case or is an independent subset.')
		END IF
		return -1
	end if
//END IF

// FDG 03/27/00 - Redraw dw_subset_options to reflect the changed data.
dw_subset_options.SetRedraw (TRUE)
//AJS 07-13-98 4.0 end
RETURN 0
end event

event ue_get_default_sched_time();//This user event will read the stars_win_parm table to obtain the default schedule time. 
//If the value in the table is 0 the current time will be retrieved from the server.
// 02/15/2006 HYL Track 4651d Prevent invalid default schedule date for Ancillary subset
//                                                 Moved the previous code to u_nvo_subset.of_get_default_sched_time()
integer i_rtn
i_rtn = iu_nvo_subset.of_get_default_sched_time(idt_current_datetime, idt_default_sched_datetime)
IF i_rtn = 0 THEN 
	idt_default_datetime = datetime(date('01/01/1900'))
ELSEIF i_rtn = -1 THEN
	Messagebox('Warning', 'Error retrieving default start time. Start time will be set to current server time')
ELSEIF i_rtn = -2 THEN	
	messagebox('Warning', 'Default time in Stars Win Parms is not in correct format. Start time will be set to current server time')
END IF
Return 
end event

event type integer ue_insert_case_link(string arg_status);///////////////////////////////////////////////////////////////////////
//	Arguments - arg_status - Contains the status to be
//									 written to the case link table.
///////////////////////////////////////////////////////////////////////
//
//	01/17/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// FDG	10/15/01	Stars 4.8.1.	Add case_log
// SAH	01/24/02 Stars 4.8.1 Track 2717, reword log entry to say subset
//										ia scheduled for creation.
//	GaryR	06/14/02	Track 3120d	Allow the server to add case log entry for new subsets.
//
///////////////////////////////////////////////////////////////////////

//	01/17/01	GaryR	Stars 4.7 DataBase Port
String	ls_case_spl, ls_case_ver,	ls_empty

Integer	li_rc

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

dw_sub_opt_case_link.reset()
dw_sub_opt_case_link.insertrow(0)

//	01/17/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
ls_case_spl = istr_sub_opt.case_spl
ls_case_ver = istr_sub_opt.case_ver
//IF Trim( ls_case_spl ) = "" THEN ls_case_spl = ls_empty
//IF Trim( ls_case_ver ) = "" THEN ls_case_ver = ls_empty

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
// FDG 04/16/01 - end

dw_sub_opt_case_link.Setitem(1,'case_id',istr_sub_opt.case_id)
dw_sub_opt_case_link.Setitem(1,'case_spl',ls_case_spl)
dw_sub_opt_case_link.Setitem(1,'case_ver',ls_case_ver)
dw_sub_opt_case_link.Setitem(1,'link_type','SUB')
dw_sub_opt_case_link.Setitem(1,'link_key',Istr_sub_opt.subset_id)
dw_sub_opt_case_link.Setitem(1,'link_name',Istr_sub_opt.subset_name)
dw_sub_opt_case_link.Setitem(1,'link_desc',dw_subset_options.GetItemString(1,'Subc_Desc'))
dw_sub_opt_case_link.Setitem(1,'user_id',gc_user_id)
dw_sub_opt_case_link.Setitem(1,'link_date',idt_current_datetime)
dw_sub_opt_case_link.Setitem(1,'link_status',arg_status)
//	01/17/01	GaryR	Stars 4.7 DataBase Port - End

// FDG 10/15/01 begin
String		ls_message
n_cst_case	lnv_case

//	GaryR	06/14/02	Track 3120d - Begin
IF istr_sub_opt.come_from = "COPY" OR istr_sub_opt.come_from = "ARCHIVE" THEN
	lnv_case		=	CREATE	n_cst_case
	
	// SAH 01/24/02 Track 2717
	//ls_message	=	"Subset "	+	Istr_sub_opt.subset_name	+	" added to case."
	//ls_message	=	"Subset "	+	Istr_sub_opt.subset_name	+	" scheduled for creation."
	ls_message	=	"Subset "	+	Istr_sub_opt.subset_name	+	" added to case."
	
	li_rc			=	lnv_case.uf_audit_log ( istr_sub_opt.case_id,	&
														istr_sub_opt.case_spl,	&
														istr_sub_opt.case_ver,	&
														ls_message )
	
	IF	li_rc		<	0		THEN
		Stars2ca.of_rollback()
		MessageBox ('Database Error', 'Could not insert case log for subset '	+	Istr_sub_opt.subset_name	+	&
						'.  Case: ' + istr_sub_opt.case_id + istr_sub_opt.case_spl + &
						istr_sub_opt.case_ver + '. Script: '		+	&
						'w_subset_options.ue_insert_case_link')
		Destroy	lnv_case
		Return	-1
	END IF
	
	Destroy	lnv_case
END IF
//	GaryR	06/14/02	Track 3120d - End	
// FDG 10/15/01 end

Return 0


end event

event type integer ue_write_subset_request();//////////////////////////////////////////////////////////////////
// Script:		ue_write_subset_request
//
// Returns:		Integer
//
// Description:
// If the window was opened by through any path other than patterns, 
// determine if the job id was entered by the user. If job id was 
// not entered it will be assigned. The job id will always be 
// assigned for subsets created in the foreground because the 
// user is not allowed to enter a job id.
//////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	AJS		01/01/98		Created.
//
//	NLG		11/04/99		ts2463c. Set run_frequency in dw_bg_cntl
//	GaryR		03-22-01		Stars 4.7 DataBase Port - Implement Stars Server Functionality
//////////////////////////////////////////////////////////////////
integer li_rc, i_RowCount, li_level, li_num_src_sub, li_num_filters, li_filter
string ls_sql, ls_subset_id, ls_return, ls_cmd, ls_site_id
n_ds	lds_sub_filter_cntl

If istr_sub_opt.come_from <> 'PATTSUB' and istr_sub_opt.come_from <> 'PATTERN' then
	li_rc = w_subset_options.Event ue_check_job_id()
	if li_rc <> 0 then
		istr_sub_opt.status = 'ERROR'
		return -1
	end if
else
	is_job_id = istr_sub_opt.patt_struc.job_id
end if

//Next entries must be written to the criteria tables.


w_subset_options.Event ue_Insert_Criteria()

//	GaryR		03-22-01		Stars 4.7 DataBase Port - Begin
//Lastly, data must be written to the BG control tables.

//Initialize the bg cntl datawindow. 
//Dw_bg_cntl.reset()
//dw_Bg_Cntl.insertrow(0)

//Insert data into the bg cntl datawindow. Don't need to insert to BG_CNTL table if 
//come_from = 'PATTSUB' because bg cntl entry made for the orginal subset.

//if istr_sub_opt.come_from <> 'PATTSUB' then
//	dw_Bg_Cntl.Setitem(1,'job_id',is_job_id)
// 	dw_Bg_Cntl.Setitem(1,'dept_id',gc_user_dept)
//	dw_Bg_Cntl.Setitem(1,'user_id',gc_user_id)
//	dw_Bg_Cntl.Setitem(1,'req_date',idt_current_datetime)
//	dw_Bg_Cntl.Setitem(1,'start_date',idt_default_datetime)
//	dw_Bg_Cntl.Setitem(1,'end_date',idt_default_datetime)
//	dw_Bg_Cntl.Setitem(1,'priority',dw_subset_options.getitemnumber(1,'priority'))
//	dw_Bg_Cntl.Setitem(1,'job_status','P')
//	dw_Bg_Cntl.Setitem(1,'sched_date',dw_subset_options.getitemdatetime(1,'sched_date'))
//	dw_Bg_Cntl.Setitem(1,'delete_date',datetime(date('06/06/2079')))
//	dw_Bg_Cntl.Setitem(1,'job_error',' ')
//	dw_Bg_Cntl.SetItem(1,'run_frequency',ii_run_frequency)
//end if

//Next if the subset is created from a pattern report or random sample the Sub_Filter_Cntl 
//table must be read to determine if any of the criteria for the input subset include a 
//filter. If so, the filter id is move to the istr_sub_opt structure so that a FilterCo 
//step is written out in, Wf_BG_Step_Cntl, to copy the filter for the new subset.
//	GaryR		03-22-01		Stars 4.7 DataBase Port - End

IF istr_sub_opt.come_from = 'REPSUB' THEN
	lds_sub_filter_cntl = create n_ds
	li_num_src_sub = upperbound(istr_sub_opt.sub_info)
	For li_level = 1 to li_num_src_sub
	 	ls_subset_id = istr_sub_opt.sub_info[li_level].source_subset_id

		ls_sql = "select filter_id from sub_filter_cntl " + &
					"where subc_id = '" + Upper( ls_subset_id )
		lds_sub_filter_cntl.DataObject = 'd_filters'

		IF lds_sub_filter_cntl.SetTransObject(stars2ca) <> 1 THEN
			MessageBox("Error","Transaction error attempting to obtain filter for case.",StopSign!)
			Destroy(lds_sub_filter_cntl)
			RETURN -1
		END IF

		//set the SQL select stmt., and check for success before continuing.
		IF lds_sub_filter_cntl.SetSQLSelect(ls_Sql) = 1 THEN
			i_RowCount = lds_sub_filter_cntl.retrieve()
		
			if i_RowCount > 0 then
				   For li_filter = 1 to li_num_filters
          			istr_sub_opt.sub_info[li_level].filter_copy[li_filter] = &
						 			lds_sub_filter_cntl.Object.filter_id[li_filter]
					Next
			end if	
		END IF
	Next
END IF

Destroy lds_sub_filter_cntl

li_rc =  w_subset_options.Event ue_write_bg_step_cntl() 
if li_rc <> 0 then
		return -1
else
		return 0
End If


end event

event ue_insert_criteria();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_insert_criteria						w_subset_options
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//This function will insert criteria into the criteria tables.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	AJS	01/09/98	Created.
// AJS   04/30/98 Correct Track#1165; when a subset had mixed
//                base and subset levels
// NLG	05/20/98	Track #1138 - Automatically increment criteria id 
//	NLG	06/09/98	Track #1165 - add another arg to wf_get_previous_crit
// FNC	04/25/00	Track #2198 Stardev Stars 4.5. Remove 'AND' on last criteria
//						line.
// GaryR	11/06/00	3030c	Fill in additional data source in criteria table
//	GaryR	01/17/01	Stars 4.7 DataBase Port - Empty String in SQL
//	GaryR	06/15/01	Stars 4.7 Make sure saved SQL is DBMS independent.
//	GaryR	08/21/01	Track 2410d Convert Criteria_Used_Line Updates to Upper case
// FNC	11/06/01	Track 2523 Stardev. Create an array containing the table types 
//						used in the criteria. Make sure a data source is in this array
//						before writing it to the criteria_from_tbls_used table. This will
//						make sure that the additional data source table is only written out
//						if it is used in a criteria.
/////////////////////////////////////////////////////////////////////////////
boolean lb_found
boolean lb_crit_tbl_found		//FNC 11/06/01
integer li_sub1, li_sub2, li_sub3, li_num_src_sub, li_crit_line, li_upperbound, li_line
integer li_num_prev_subsets, li_rc, li_level_nbr
integer	li_crit_tbl, li_max_crit_tbls		//FNC 11/06/01
datetime ldt_current_datetime
string ls_prev_subsets[], ls_subset_id, ls_table_type, lv_desc, lv_filter_ind, ls_empty
int li_by_level
String	ls_tbl2, ls_crit_lp, ls_crit_rp, ls_crit_logic	//	01/17/01	GaryR	Stars 4.7
String	ls_crit_exp2					//	GaryR	06/15/01	Stars 4.7
String	ls_crit_tbl, ls_crit_tbl_types[], ls_clear_array[]		//FNC 11/06/01
sx_source_subset lsx_source_subset[]

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

//The next available criteria id must be obtained from the sys_cntl table.
//if trim(gv_crit_name) = '' then //NLG 5-20-98 #1138
	gv_crit_name = fx_get_next_key_id('CRITERIA')
	If gv_crit_name = 'ERROR' then
		messagebox('ERROR','Error getting next key id')
	Return 
	End IF
//end if									//NLG 5-20-98 #1138

//Determine if the subset is created from another subset. If so, write the
//previous criteria to the criteria tables with the new subset id.

Li_sub3 = 0//used to count levels using another subset as source
//If trim(istr_sub_opt.sub_info[1].source_subset_id) <> '' then	Track #1165
	li_num_src_sub = upperbound(istr_sub_opt.sub_info)
	For li_sub1 = 1 to li_num_src_sub
	 	ls_subset_id = istr_sub_opt.sub_info[li_sub1].source_subset_id
		//li_num_prev_subsets = upperbound(is_prev_subsets)
		li_num_prev_subsets = upperbound(lsx_source_subset)
		lb_found = FALSE

		//Determine if subset id is already in array
		for li_sub2 = 1 to li_num_prev_subsets
			//if ls_subset_id = is_prev_subsets[li_sub2] then
			if ls_subset_id = lsx_source_subset[li_sub2].source_subset_id then
				lb_found = TRUE
				exit
			end if
		next
		
		//If subset not in the array then add it to the array. 
		if not lb_found then
			if IsNull(ls_subset_id) or trim(ls_subset_id) = "" then	// Track #1165
				lsx_source_subset[li_sub1].source_subset_id = "BASE"
				lsx_source_subset[li_sub1].level_num = li_sub1
			else																			// Track #1165
				li_sub3++
				//is_prev_subsets[li_sub3]= ls_subset_id
				lsx_source_subset[li_sub1].source_subset_id= ls_subset_id
				lsx_source_subset[li_sub1].level_num = li_sub1
				//NLG 6-8-98 									Track #1165  ****START***** 
//				li_by_level = li_sub1
				//NLG 7-9-98 Track #1490 change li_sub1 to li_sub3 to prevent exceeding array
				// boundary in ML sub when level 1 is base, level 2 is source
//				li_rc = wf_get_previous_crit(is_prev_subsets[li_sub1],'SUB','SUB',+&
//														is_step_level, li_by_level)
//NLG testing 10-2-98  comment and remove li_by_level as an argument
//				li_rc = wf_get_previous_crit(is_prev_subsets[li_sub3],'SUB','SUB',+&
//														is_step_level, li_by_level)

//10-09-98 NLG comment call to function.  Call after loop
//				li_rc = wf_get_previous_crit(is_prev_subsets[li_sub3],'SUB','SUB',is_step_level)
//				If li_rc = 100 or isnull(li_rc) then
//					messagebox('ERROR','Error obtaining previous criteria')
//					return 
//				End IF

				//NLG 6-8-98 									Track #1165  ****STOP******
			end if																		// Track #1165
		else /*if subset is already in array, put a placeholder for this level */ //NLG 10-09-98
			lsx_source_subset[li_sub1].source_subset_id = 'DUPLICATE'
			lsx_source_subset[li_sub1].level_num = li_sub1
		end if
	next

//Now, use the array with the subset ids to copy the previous criteria
li_rc = wf_get_previous_crit(lsx_source_subset,'SUB','SUB',is_step_level)

//NLG #1165 - Comment next 8 lines.  Move logic above, inside loop
//	li_num_prev_subsets = upperbound(is_prev_subsets)
//	For li_sub1 = 1 to li_num_prev_subsets
//			li_rc = wf_get_previous_crit(is_prev_subsets[li_sub1],'SUB','SUB',is_step_level)
//			If li_rc = 100 or isnull(li_rc) then
//				messagebox('ERROR','Error obtaining previous criteria')
//				return 
//			End IF
//	Next

//end if				Track #1165
//
//Set the criteria level and step 

ii_crit_level = 1
If trim(is_step_level) = '' or isnull(is_step_level) then
	is_step_level = '1'
Else
	is_step_level = string(integer(is_step_level) + 1)
End IF
	
//Insert a row into the criteria table.

ldt_current_datetime = idt_current_datetime
lv_desc = 'CRITERIA USED IN BACKGROUND SUBSET ' + gv_subset_id
ii_max_level = upperbound(istr_sub_opt.sub_info)

for li_level_nbr = 1 to ii_max_level
	if upperbound(istr_sub_opt.sub_info[li_level_nbr].filter_copy) > 0 then
	lv_filter_ind = '@'
	continue
end if
next

dw_criteria_used.reset()
dw_criteria_used.insertrow(0)

//	01/17/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( lv_filter_ind ) = "" THEN lv_filter_ind = ls_empty

dw_Criteria_Used.SetItem(1,'BY_TYPE','SUB')   
dw_Criteria_Used.SetItem(1,'BY_ID',gv_subset_id) 
dw_Criteria_Used.SetItem(1,'BY_LEVEL',ii_crit_level)   //not really ii_crit_level always 1 
dw_Criteria_Used.SetItem(1,'CRIT_ID',gv_crit_name)
dw_Criteria_Used.SetItem(1,'CRIT_SUB_TBL_TYPE',istr_sub_opt.sub_info[1]. subset_step[1].subset_type)
dw_Criteria_Used.SetItem(1,'CRIT_FLTR_IND',lv_filter_ind)
dw_Criteria_Used.SetItem(1,'CRIT_DATETIME',ldt_current_datetime)
dw_Criteria_Used.SetItem(1,'CRIT_DESC',lv_desc)
dw_Criteria_Used.SetItem(1,'Step_id',is_step_level)  

//Write the criteria to the Criteria_From_Tbls_Used and Criteria_Used_Line tables.

//Initialize criteria from tables datawindow.
dw_Criteria_From_Tbls_Used.reset()

//Initialize criteria line datawindow. 
dw_Criteria_Used_Line.reset()

li_crit_line = 0

For ii_level = 1 To ii_max_level
	li_upperbound = upperbound(istr_sub_opt.sub_info[ii_level].criteria)	 
	li_line = 1
	ls_crit_tbl_types[] = ls_clear_array
	Do until li_line > li_upperbound 
			If istr_sub_opt.sub_info[ii_level].criteria[li_line].expression_one = '' then Exit
			
			//	01/17/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
			ls_crit_lp		= istr_sub_opt.sub_info[ii_level].criteria[li_line].left_paren
			ls_crit_rp		= istr_sub_opt.sub_info[ii_level].criteria[li_line].right_paren
			ls_crit_logic	= istr_sub_opt.sub_info[ii_level].criteria[li_line].logical_operator
			
			IF Trim( ls_crit_lp )	 = "" THEN ls_crit_lp 		= ls_empty
			IF Trim( ls_crit_rp )	 = "" THEN ls_crit_rp		= ls_empty
			IF Trim( ls_crit_logic ) = "" THEN ls_crit_logic	= ls_empty
						
			//	GaryR	06/15/01	Stars 4.7 - Begin
			//	GaryR	08/21/01	Track 2410d
			ls_crit_exp2 = Upper( istr_sub_opt.sub_info[ii_level].criteria[li_line].orig_expression )
			IF IsNull( ls_crit_exp2 ) OR Trim( ls_crit_exp2 ) = "" THEN
				//	GaryR	08/21/01	Track 2410d
				ls_crit_exp2 = Upper( istr_sub_opt.sub_info[ii_level].criteria[li_line].expression_two )
			END IF
			//	GaryR	06/15/01	Stars 4.7 - End
			
			li_crit_line++
			dw_Criteria_Used_Line.Insertrow(0)
			dw_Criteria_Used_Line.SetItem(li_crit_line, 'By_Type','SUB')
			dw_Criteria_Used_Line.SetItem(li_crit_line, 'By_Id', gv_subset_id)
			dw_Criteria_Used_Line.SetItem(li_crit_line, 'By_Level', ii_crit_level)
			dw_Criteria_Used_Line.SetItem(li_crit_line, 'Crit_Line', li_line)
			dw_Criteria_Used_Line.SetItem(li_crit_line, 'Crit_Lp', ls_crit_lp )
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Exp1', &
					istr_sub_opt.sub_info[ii_level].criteria[li_line].expression_one)
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Op', &
					istr_sub_opt.sub_info[ii_level].criteria[li_line].rel_operator)
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Exp2', ls_crit_exp2 ) //	GaryR	06/15/01	Stars 4.7
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Rp', ls_crit_rp)
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Logic', ls_crit_logic) 
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Data_Type', &
					istr_sub_opt.sub_info[ii_level].criteria[li_line].data_type)
					//afstest check the following line
			dw_Criteria_Used_Line.SetItem(li_crit_line,'Step_Id', is_step_level )
			//	01/17/01	GaryR	Stars 4.7 DataBase Port - End
			//FNC 11/06/01 Start
			//Create an array of the table types used in the criteria for this level. Since
			//can only have two data sources the max number of criteria tables is 2
			ls_crit_tbl = left(& 
				istr_sub_opt.sub_info[ii_level].criteria[li_line].expression_one,2)  //FNC 11/06/01
			li_max_crit_tbls = upperbound(ls_crit_tbl_types)
			lb_crit_tbl_found = FALSE
			for li_crit_tbl = 1 to li_max_crit_tbls
				if ls_crit_tbl = ls_crit_tbl_types[li_crit_tbl] then
					lb_crit_tbl_found = TRUE
				end if
			next
			if not lb_crit_tbl_found then
				ls_crit_tbl_types[li_max_crit_tbls + 1] = ls_crit_tbl
			end if
			//FNC 11/06/01 End				
			li_line++		
	Loop
	
	if li_crit_line> 0 then													// FNC 04/25/00 Start
		dw_Criteria_Used_Line.SetItem(li_crit_line,'Crit_Logic', ls_empty)	//	GaryR	01/17/01	Stars 4.7 DataBase Port
	end if																		// FNC 04/25/00 End
	
	//will only write the first step info on the criteria_from_tbls Used
	//need loop for max ---Upperbound(istr_sub_opt.sub_info[ii_level].subset_step)
	if istr_sub_opt.sub_info[ii_level].subset_step[1].subset_type = 'MC' then
		ls_table_type = 'MC'
	else
		ls_table_type = istr_sub_opt.sub_info[ii_level].subset_step[1].inv_type
	end if
	
	//	01/17/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
	ls_tbl2 = istr_sub_opt.sub_info[ii_level].subset_step[1].addtl_data_source // 11/06/2000	GaryR	3030c
	IF Trim( ls_tbl2 ) = "" THEN 
		ls_tbl2 = ls_empty
	else
		//FNC 11/06/01 Start
		//Only set tbl_2 to additional datasouce value if it is used in criteria
		lb_crit_tbl_found = FALSE
		li_max_crit_tbls = upperbound(ls_crit_tbl_types)		
		for li_crit_tbl = 1 to li_max_crit_tbls
			if ls_tbl2 = ls_crit_tbl_types[li_crit_tbl] then
				lb_crit_tbl_found = TRUE
			end if
		next
		
		if not lb_crit_tbl_found then
			ls_tbl2 = ls_empty
		end if
		//FNC 11/06/01 End
	end if
	
	
	DW_Criteria_From_Tbls_Used.InsertRow(0)
	DW_Criteria_From_Tbls_Used.SetItem(ii_level,'By_Type','SUB')
	DW_Criteria_From_Tbls_Used.SetItem(ii_level,'By_Id', gv_subset_id)
	DW_Criteria_From_Tbls_Used.SetItem(ii_level,'By_Level', ii_crit_level)
	DW_Criteria_From_Tbls_Used.SetItem(ii_level,'Tbl_1',ls_table_type)
	DW_Criteria_From_Tbls_Used.SetItem(ii_level,'Tbl_2',ls_tbl2 )
	DW_Criteria_From_Tbls_Used.SetItem(ii_level,'Step_id',is_step_level)
	
	ii_crit_level++
	
	//table type is the only thing that change
	//loop ends here
	
	
	
Next


//This function will loop through all of the criteria for each level and 
//write each line to the Criteria_Used_Line table.

//If this is the first row for the subset do not increment row count.


end event

event type integer ue_write_bg_step_cntl();//***************************************************************************
//This function loops through each step in each level of the subset and 
//writes out one record to BG_Step_Cntl for each step in the job.
//***************************************************************************
//History
// 07/07/98 FNC	Track 1319. Use level index to determine max steps for each level.
//						If don't use index then the number of steps is always determined
//						by the first level.
//
//	07-15-98 NLG	Track #1176 Comment out FILTERCO step that occurs if using
//						subset with filter as source.  This filterco step happens
//						automatically because middleware checks sub_cntl.subc_place_id
//
// 07/23/98 AJS   4.0 Correct Track #1532; Must bring entire invoice for invoices
//                in an ML subset that are not used.
//
//	08/27/98	FNC	Track 1616. If the same	filter id is used in the criteria for 
//						two different levels only create one filter copy step. Ignore
//						the filter id the second time.
//	12/15/99	NLG	Populate new columns on bg_step_cntl: from_date_rule, thru_date_rule
//	01/17/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	05/07/01	FDG	Track 2343d.  If the subset name cannot be accessed using the case ID,
//						then retry with case ID = 'NONE'.
//	03/19/02	FDG	Stars 5.1.  Allow subsetting of ancillary invoice types.			
// 08/02/02 JasonS Track 3089d populate src case_id into structure if blank
//***************************************************************************
integer li_row, li_sql_row, li_step_num, li_max_step, li_step, li_index, li_len, li_rc
integer li_max_sql_lines, li_max_filtercr_step, li_prev_subsets, li_rows
integer li_max_filtercopy_step, li_prev_sub, li_filter_row
integer li_test
integer li_unique_filters,li_unique_idx
string ls_filters[]
string ls_delete_sub_ind, ls_use_temp_ind, ls_select[], ls_select_statement, ls_string
string ls_filter_id, ls_subset_name, ls_clear_select[], ls_case_id
boolean lb_found
string ls_test
string	ls_inv_type				// FDG 03/19/02
long		ll_stars_rel_row		// FDG 03/19/02


//	01/17/01	GaryR	Stars 4.7 DataBase Port
String	ls_input_id, ls_src_subc_name, ls_case_spl, ls_case_ver, ls_empty

sx_subset_ids lstr_subset_ids
nvo_subset_functions lnv_subset_functions

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)


li_row = 0
li_sql_row = 0
dw_bg_step_cntl.reset()

dw_bg_sql_line.reset()

Choose Case istr_sub_opt.come_from
	Case 'QUERY'
		ls_use_temp_ind = 'N'
		ls_delete_sub_ind = 'N'
		li_step_num = 0
	Case 'REPSUB'
		ls_use_temp_ind = 'Y'
		ls_delete_sub_ind = 'N'
		li_step_num = 0
	Case 'PATTSUB'
		ls_use_temp_ind = 'Y'
		ls_delete_sub_ind = 'Y'
		li_step_num = istr_sub_opt.patt_struc.total_steps
	Case 'PATTERN'
		ls_use_temp_ind = 'Y'
		ls_delete_sub_ind = 'N'
		li_step_num = istr_sub_opt.patt_struc.total_steps
End Choose

li_unique_filters = 0	
For ii_level = 1 to ii_max_level
		li_max_step = upperbound(istr_sub_opt.sub_info[ii_level].subset_step)	// FNC 07/07/98
		for li_step = 1 to li_max_step
			li_row++
			li_step_num++
			dw_bg_step_cntl.insertrow(0)
			dw_bg_step_cntl.setitem(li_row,'job_id',is_job_id)
			dw_bg_step_cntl.setitem(li_row,'step_num',li_step_num)
			dw_bg_step_cntl.setitem(li_row,'step_type','SUBSET')
			dw_bg_step_cntl.setitem(li_row,'error_msg',' ')
			dw_bg_step_cntl.setitem(li_row,'start_date', idt_default_datetime)
			dw_bg_step_cntl.setitem(li_row,'end_date', idt_default_datetime)
			dw_bg_step_cntl.setitem(li_row,'rows_affected',0)
			dw_bg_step_cntl.setitem(li_row,'step_status',' ')
			
					
//       ajs 4.0 02-23-98 Indicator should be Y do not place temp table name in here
//			if trim(istr_sub_opt.sub_info[ii_level].temp_table_name) <> '' then
//				ls_use_temp_ind = istr_sub_opt.sub_info[ii_level].temp_table_name
//			end if
			//AJS 07-23-98 4.0 Correct Track #1532
			//Must bring entire invoice subset for portion of ML subset not being used 
			If istr_sub_opt.sub_info[ii_level].subset_step[li_step].Input_type = 'SUBSET' then
				dw_bg_step_cntl.setitem(li_row,'use_temp_table_ind', 'N')
			else
				dw_bg_step_cntl.setitem(li_row,'use_temp_table_ind', ls_use_temp_ind)
			end if
			//AJS 07-23-98 4.0 Correct Track #1532 end
			
			//	01/17/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
			ls_input_id = istr_sub_opt.sub_info[ii_level].subset_step[li_step].Input_id
			IF Trim( ls_input_id ) = "" THEN ls_input_id = ls_empty
						
			dw_bg_step_cntl.setitem(li_row,'Delete_Source_Ind', ls_delete_sub_ind)
			dw_bg_step_cntl.setitem(li_row,'paid_from_date', istr_sub_opt.sub_info[ii_level].subset_step[li_step].Paid_from_date)
			dw_bg_step_cntl.setitem(li_row,'paid_thru_date', istr_sub_opt.sub_info[ii_level].subset_step[li_step].Paid_thru_date)
			dw_bg_step_cntl.setitem(li_row,'inv_type', istr_sub_opt.sub_info[ii_level].subset_step[li_step].Inv_type)
			dw_bg_step_cntl.setitem(li_row,'subset_type', istr_sub_opt.sub_info[ii_level].subset_step[li_step].Subset_type)
			dw_bg_step_cntl.setitem(li_row,'subc_sub_src_type', istr_sub_opt.sub_info[ii_level].subset_step[li_step].Subc_sub_src_type)
			dw_bg_step_cntl.setitem(li_row,'subc_crit_id',gv_crit_name)
			dw_bg_step_cntl.setitem(li_row,'input_type', istr_sub_opt.sub_info[ii_level].subset_step[li_step].Input_type)
			dw_bg_step_cntl.setitem(li_row,'input_id', ls_input_id)
			// FDG 03/19/02 - Allow for ancillary invoice types
			IF	Trim (istr_sub_opt.sub_info[ii_level].subset_step[li_step].inv_type) > ' '	THEN
				ls_inv_type	=	istr_sub_opt.sub_info[ii_level].subset_step[li_step].inv_type
				ll_stars_rel_row	=	fx_filter_stars_rel_1 ('AN', ls_inv_type, ls_inv_type)
				IF	ll_stars_rel_row	>	0		THEN
					dw_bg_step_cntl.setitem (li_row, 'subset_type', 'AN')
				END IF
			END IF
			// FDG 03/19/02 end
			if istr_sub_opt.sub_info[ii_level].subset_step[li_step].Input_type = 'BASE' then
					dw_bg_step_cntl.setitem(li_row,'src_case_id', ' ')
					dw_bg_step_cntl.setitem(li_row,'src_subc_name', ' ')
			else
					lnv_subset_functions = Create nvo_subset_functions	
					
					dw_bg_step_cntl.setitem(li_row,'src_case_id', istr_sub_opt.sub_info[ii_level].subset_step[li_step].subc_sub_src_case_id)
					lstr_subset_ids.subset_case_id = left(istr_sub_opt.sub_info[ii_level].subset_step[li_step].subc_sub_src_case_id,10)
					lstr_subset_ids.subset_case_spl = mid(istr_sub_opt.sub_info[ii_level].subset_step[li_step].subc_sub_src_case_id,11,2)
					lstr_subset_ids.subset_case_ver = mid(istr_sub_opt.sub_info[ii_level].subset_step[li_step].subc_sub_src_case_id,13,2) // AJS   03-11-98 4.0 fix split of case id
					lstr_subset_ids.subset_id = istr_sub_opt.sub_info[ii_level].source_subset_id
					
					// JasonS 08/02/02 Begin - Track 3089d
					if lstr_subset_ids.subset_case_id = '' and lstr_subset_ids.subset_id <> '' then
						select case_id
						into :ls_case_id
						from case_link
						where link_type = 'SUB'
						and  link_key = :lstr_subset_ids.subset_id
						using stars2ca;
						
						lstr_subset_ids.subset_case_id = trim(left(ls_case_id,10))
						lstr_subset_ids.subset_case_spl = trim(mid(ls_case_id,11,2))
						lstr_subset_ids.subset_case_ver = trim(mid(ls_case_id,13,2))
					end if
					// JasonS 08/02/02 End - Track 3089d
					
					lnv_subset_functions.uf_set_structure(lstr_Subset_ids)
 					li_rc = lnv_subset_functions.uf_Retrieve_Subset_Name()
					if li_rc < 1 then
						// FDG 05/07/01 - Track 2343d.  If case_link not found, try again for case ID = 'NONE'
						lstr_subset_ids.subset_case_id = 'NONE'
						lstr_subset_ids.subset_case_spl = ''
						lstr_subset_ids.subset_case_ver = ''
						lnv_subset_functions.uf_set_structure(lstr_subset_ids)
						li_rc = lnv_subset_functions.uf_Retrieve_Subset_Name()
						if li_rc < 1 then
							messagebox('Error','Unable to retrieve source subset name. Cannot create subset')
							Destroy(lnv_subset_functions)
							return -1
						end if
						// FDG 05/07/01 end
					end if
					lstr_subset_ids = lnv_Subset_Functions.UF_Get_Structure()
					
					//	01/17/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
					ls_src_subc_name = lstr_Subset_ids.subset_name
					IF Trim( ls_src_subc_name ) = "" THEN ls_src_subc_name = ls_empty					
					dw_bg_step_cntl.setitem(li_row,'src_subc_name', ls_src_subc_name)
					//	01/17/01	GaryR	Stars 4.7 DataBase Port - End
					Destroy(lnv_subset_functions)
			end if
			//dw_bg_step_cntl.setitem(li_row,'src_subset_name', istr_Subset_ids.subset_name)
			dw_bg_step_cntl.setitem(li_row,'output_id', gv_subset_id)
			dw_bg_step_cntl.setitem(li_row,'subc_name', dw_subset_options.getitemstring(1,'subc_name'))
			dw_bg_step_cntl.setitem(li_row,'subc_desc', dw_subset_options.getitemstring(1,'subc_desc'))
			dw_bg_step_cntl.setitem(li_row,'case_id',Istr_sub_opt.case_id)
			
			//	01/17/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
			ls_case_spl = Istr_sub_opt.case_spl
			ls_case_ver = Istr_sub_opt.case_ver
			IF Trim( ls_case_spl ) = "" THEN ls_case_spl = ls_empty
			IF Trim( ls_case_ver ) = "" THEN ls_case_ver = ls_empty
								
			dw_bg_step_cntl.setitem(li_row,'case_spl',ls_case_spl)
			dw_bg_step_cntl.setitem(li_row,'case_ver',ls_case_ver)
			//	01/17/01	GaryR	Stars 4.7 DataBase Port - End
			
//Break up sql statement into 80 pieces.
			ls_select[] = ls_clear_select[]			//03-04-98 ajs 4.0 03-04-98 clear sql array
			if len(istr_sub_opt.sub_info[ii_level].subset_step[li_step].Sql_statement) <= 80 then
				ls_select[1] = istr_sub_opt.sub_info[ii_level].subset_step[li_step].Sql_statement
			else
				ls_select_statement = istr_sub_opt. sub_info[ii_level].subset_step[li_step].Sql_statement
   			li_index = 1
				DO
					ls_select[li_index] = mid(ls_select_statement,1,80)
					ls_select_statement = mid(ls_select_statement,81)  
      			li_len = len(trim(ls_select_statement))
      			li_index++
   			LOOP UNTIL li_len = 0
			end if

//Insert SQL into Bg_Sql_Line table		

			li_max_sql_lines = upperbound(ls_select)
			for li_index = 1 to li_max_sql_lines
					li_sql_row++
					dw_bg_sql_line.insertrow(0)
					ls_string = ls_select[li_index]
					dw_bg_sql_line.setitem(li_sql_row,'job_id',is_job_id)
					dw_bg_sql_line.setitem(li_sql_row,'step_num', li_step_num)
					dw_bg_sql_line.setitem(li_sql_row,'line_num',li_index)
					dw_bg_sql_line.setitem(li_sql_row,'sql_line', ls_select[li_index])
			Next
	Next
	//NLG 4.0 Subset Redesign -- if background pattern, don't rewrite the filter steps
	//										to bg_step_cntl
	If istr_sub_opt.come_from = 'PATTSUB' then
		ii_total_steps = li_step_num
	//	Return 0 //NLG 6-24-98 In background ML patt sub, this return was preventing 
				//					more than 1 invoice type being written out to bg tables
	//End If		//NLG 6-24-98
	ELSE
	//filter create step
	  li_max_filtercr_step = upperbound(istr_sub_opt.sub_info[ii_level].filter_create)
	  for li_step = 1 to  li_max_filtercr_step
				li_step_num++				//NLG 4-30-98
				li_row++
				//li_step_num = li_row //NLG 4-16-98
				dw_bg_step_cntl.insertrow(0)
				dw_bg_step_cntl.setitem(li_row,'job_id',is_job_id)
				dw_bg_step_cntl.setitem(li_row,'step_num',li_step_num)
				dw_bg_step_cntl.setitem(li_row,'step_type','FILTERCR')
				dw_bg_step_cntl.setitem(li_row,'error_msg',' ')
				dw_bg_step_cntl.setitem(li_row,'start_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'end_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'rows_affected',0)
				dw_bg_step_cntl.setitem(li_row,'step_status',' ') 
				dw_bg_step_cntl.setitem(li_row,'use_temp_table_ind',' ')
				dw_bg_step_cntl.setitem(li_row,'Delete_Source_Ind',' ')
				dw_bg_step_cntl.setitem(li_row,'paid_from_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'paid_thru_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'inv_type', istr_sub_opt.sub_info[ii_level].filter_create[li_step].tbl_type)
				dw_bg_step_cntl.setitem(li_row,'subset_type',' ')
				dw_bg_step_cntl.setitem(li_row,'subc_sub_src_type','SS')
				dw_bg_step_cntl.setitem(li_row,'subc_crit_id',' ')				
				dw_bg_step_cntl.setitem(li_row,'input_type','SUBSET')
				dw_bg_step_cntl.setitem(li_row,'input_id',gv_subset_id)
				ls_filter_id = istr_sub_opt.sub_info[ii_level].filter_create[li_step].filter_id 
				If trim(ls_filter_id) = '' then
					ls_filter_id = fx_get_next_key_id('FILTER')
					if ls_filter_id = 'ERROR' then
						messagebox('ERROR','Error getting filter id, Subset cancelled')
					return -1
					end if
				End If
				dw_bg_step_cntl.setitem(li_row,'src_case_id', ' ')		//ajs 4.0 03-04-98
				dw_bg_step_cntl.setitem(li_row,'src_subc_name', ' ')	//ajs 4.0 03-04-98
				dw_bg_step_cntl.setitem(li_row,'output_id',ls_filter_id)
				dw_bg_step_cntl.setitem(li_row,'subc_name', dw_subset_options.getitemstring(1,'subc_name'))
				dw_bg_step_cntl.setitem(li_row,'subc_desc',' ')
//				dw_bg_step_cntl.setitem(li_row,'secure_lvl',' ')
				//NLG 7-10-98 must write out case info also 
//				dw_bg_step_cntl.setitem(li_row,'case_id',' ')
//				dw_bg_step_cntl.setitem(li_row,'case_spl',' ')
//				dw_bg_step_cntl.setitem(li_row,'case_ver',' ')
				dw_bg_step_cntl.setitem(li_row,'case_id',Istr_sub_opt.case_id)
				
				//	01/17/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
				ls_case_spl = Istr_sub_opt.case_spl
				ls_case_ver = Istr_sub_opt.case_ver
				IF Trim( ls_case_spl ) = "" THEN ls_case_spl = ls_empty
				IF Trim( ls_case_ver ) = "" THEN ls_case_ver = ls_empty
									
				dw_bg_step_cntl.setitem(li_row,'case_spl',ls_case_spl)
				dw_bg_step_cntl.setitem(li_row,'case_ver',ls_case_ver)
				//	01/17/01	GaryR	Stars 4.7 DataBase Port - End
								
				dw_bg_sql_line.insertrow(0)		//ajs 4.0 03-05-98 fix sql overlay
				li_sql_row++							//ajs 4.0 03-05-98 fix sql overlay
				dw_bg_sql_line.setitem(li_sql_row,'job_id',is_job_id)
				dw_bg_sql_line.setitem(li_sql_row,'step_num',li_step_num)
				dw_bg_sql_line.setitem(li_sql_row,'line_num',1)
				dw_bg_sql_line.setitem(li_sql_row,'sql_line', istr_sub_opt.sub_info[ii_level].filter_create[li_step].Col_name)
		Next

		li_max_filtercopy_step = upperbound(istr_sub_opt.sub_info[ii_level].filter_copy)
		for li_step = 1 to li_max_filtercopy_step
				// FNC 08/27/98 Start
				lb_found = FALSE
				for li_unique_idx = 1 to li_unique_filters
					if istr_sub_opt.sub_info[ii_level].filter_copy[li_step] = &
						ls_filters[li_unique_idx] then
						lb_found = TRUE
						exit
					end if
				next
				if lb_found then
					/*Don't write out a filter copy step. Already have filter copy for this filter id */
					continue
				else					
					li_unique_filters++
					ls_filters[li_unique_filters] = &
						istr_sub_opt.sub_info[ii_level].filter_copy[li_step]
				end if
				// FNC 08/27/98 End				
				li_row++
				li_step_num++				//NLG 4-30-98
				//li_step_num = li_row //NLG 4-16-98
				dw_bg_step_cntl.insertrow(0)
				dw_bg_step_cntl.setitem(li_row,'job_id',is_job_id)
				dw_bg_step_cntl.setitem(li_row,'step_num',li_step_num)
				dw_bg_step_cntl.setitem(li_row,'step_type','FILTERCO')
				dw_bg_step_cntl.setitem(li_row,'error_msg',' ')
				dw_bg_step_cntl.setitem(li_row,'start_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'end_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'rows_affected',0)
				dw_bg_step_cntl.setitem(li_row,'step_status',' ') 
				dw_bg_step_cntl.setitem(li_row,'use_temp_table_ind',' ')
				dw_bg_step_cntl.setitem(li_row,'Delete_Source_Ind',' ')
				dw_bg_step_cntl.setitem(li_row,'paid_from_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'paid_thru_date', idt_default_datetime)
				dw_bg_step_cntl.setitem(li_row,'inv_type',' ') 
				dw_bg_step_cntl.setitem(li_row,'subset_type',' ')
				dw_bg_step_cntl.setitem(li_row,'subc_sub_src_type',' ')
				dw_bg_step_cntl.setitem(li_row,'subc_crit_id',' ')
				dw_bg_step_cntl.setitem(li_row,'input_type',' ')
				dw_bg_step_cntl.setitem(li_row,'input_id', istr_sub_opt.sub_info[ii_level].filter_copy[li_step])
				dw_bg_step_cntl.setitem(li_row,'src_case_id', ' ')		//ajs 4.0 03-04-98
				dw_bg_step_cntl.setitem(li_row,'src_subc_name', ' ')	//ajs 4.0 03-04-98
				dw_bg_step_cntl.setitem(li_row,'output_id',gv_subset_id)
				dw_bg_step_cntl.setitem(li_row,'subc_name',' ')
				dw_bg_step_cntl.setitem(li_row,'subc_desc',' ')
//				dw_bg_step_cntl.setitem(li_row,'secure_lvl',' ')
				dw_bg_step_cntl.setitem(li_row,'case_id',' ')
				dw_bg_step_cntl.setitem(li_row,'case_spl',' ')
				dw_bg_step_cntl.setitem(li_row,'case_ver',' ')


			Next
	end if//IF come_from = 'PATTSUB'
Next

//	07-15-98 NLG	Track #1176                     						Comment START*****
////If the subset uses another subset as a source, the Sub_Filter_Cntl table must be read 
////to determine if any of the criteria for the input subset include a filter. If so, a 
////FilterCo step is written in order to copy the filter for the new subset.
//If upperbound(is_prev_subsets) = 0 Then
//Else	
//	If trim(is_prev_subsets[1]) <> '' then
//		li_prev_subsets = upperbound(is_prev_subsets)
//		for li_prev_sub = 1 to li_prev_subsets
//				li_rows = dw_filters.retrieve(is_prev_subsets[li_prev_sub])
//				if li_rows < 0 then
//						messagebox('ERROR','Error obtaining filters for filter copy. Cannot create subset')
//						return -1
//				end if
//
//				for li_filter_row = 1 to li_rows
//						li_row++
//						li_step_num++				//NLG 4-30-98
//						//li_step_num = li_row //NLG 4-16-98
//						dw_bg_step_cntl.insertrow(0)
//						dw_bg_step_cntl.setitem(li_row,'job_id',is_job_id)
//						dw_bg_step_cntl.setitem(li_row,'step_num',li_step_num)
//						dw_bg_step_cntl.setitem(li_row,'step_type','FILTERCO')
//						dw_bg_step_cntl.setitem(li_row,'error_msg',' ')
//						dw_bg_step_cntl.setitem(li_row,'start_date', idt_default_datetime)
//						dw_bg_step_cntl.setitem(li_row,'end_date',idt_default_datetime)
//						dw_bg_step_cntl.setitem(li_row,'rows_affected',0)
//						dw_bg_step_cntl.setitem(li_row,'step_status',' ') 
//						dw_bg_step_cntl.setitem(li_row,'use_temp_table_ind',' ')
//						dw_bg_step_cntl.setitem(li_row,'Delete_Source_Ind',' ')
//						dw_bg_step_cntl.setitem(li_row,'paid_from_date', idt_default_datetime)
//						dw_bg_step_cntl.setitem(li_row,'paid_thru_date', idt_default_datetime)
//						dw_bg_step_cntl.setitem(li_row,'inv_type',' ') 
//						dw_bg_step_cntl.setitem(li_row,'subset_type',' ')
//						dw_bg_step_cntl.setitem(li_row,'subc_sub_src_type',' ')
//						dw_bg_step_cntl.setitem(li_row,'subc_crit_id',' ')
//						dw_bg_step_cntl.setitem(li_row,'input_type',' ')//'SUB') //NLG 5-1-98
//						dw_bg_step_cntl.setitem(li_row,'input_id',dw_filters.getitemstring(li_filter_row,'Filter_Id'))
//						dw_bg_step_cntl.setitem(li_row,'src_case_id', ' ')			//ajs 4.0 03-04-98
//						dw_bg_step_cntl.setitem(li_row,'src_subc_name', ' ')		//ajs 4.0 03-04-98
//						dw_bg_step_cntl.setitem(li_row,'output_id',gv_subset_id)
//						dw_bg_step_cntl.setitem(li_row,'subc_name',' ')
//						dw_bg_step_cntl.setitem(li_row,'subc_desc',' ')
////						dw_bg_step_cntl.setitem(li_row,'secure_lvl',' ')
//						dw_bg_step_cntl.setitem(li_row,'case_id',' ')
//						dw_bg_step_cntl.setitem(li_row,'case_spl',' ')
//						dw_bg_step_cntl.setitem(li_row,'case_ver',' ')
//				Next
//		Next
//
//End If
//	07-15-98 NLG	Track #1176                     						Comment STOP*****
ii_total_steps = li_step_num
Return 0
end event

event type integer ue_check_job_id();//**********************************************************************
// Script: ue_check_job_id
// This script will edit the user entered job id.  I get a system 
// assigned date , if none has been entered.  If the user enters a job
// id the job will be checked to ensure it is not a duplicate.
//**********************************************************************
// ajs 	04-10-98 add check for duplicate job id
//	nlg 	04-04-00 Track 2676 - Don't allow spaces or other special characters
//	GaryR	03-22-01	Stars 4.7 DataBase Port - Obtain the Job Id from Stars Server
// FDG	01-15-02	Track 2644d.  Duplicate jobs are being submitted.  Trim ls_job_id.
//**********************************************************************

boolean lb_job_id_found
integer li_job_id_count
string ls_job_id

ls_job_id = Trim (dw_subset_options.getitemstring(1,'job_id') )		// FDG 01/15/02

//No Job Id supplied
If ls_job_id = '' or IsNull(ls_job_id) then	
	
//	GaryR	03-22-01	Stars 4.7 DataBase Port - Begin
	//is_job_id = fx_get_next_key_id('JOB_ID')
	IF gnv_server.of_JobCreate( il_job_id ) < 0 THEN Return -1

	//	if is_job_id = 'ERROR' then
	//		messagebox('ERROR','Error getting next job id key id')
	//		Return -1
	//	else
	is_job_id = String( il_job_id )

	dw_subset_options.setitem(1,'job_id',is_job_id)
	ls_job_id = is_job_id		
	//	end if
End If

//Check for Duplicate ID
Select count(*)
into :li_job_id_count
from server_jobs
where job_desc = Upper( :ls_job_id )
using stars2ca;
//	GaryR	03-22-01	Stars 4.7 DataBase Port - End

If stars2ca.of_check_status() <> 0 then
	messagebox ('ERROR','Error reading SERVER_JOBS table to verify job id')
	Return -1
End If
	
If li_job_id_count <> 0 then
	dw_subset_options.Setfocus()
	dw_subset_options.SetColumn('job_id')
	// FDG 01/25/02 - If a duplicate job ID is entered, generate a new unique job ID.  This situation
	//	can occur if the user previously entered this job ID.
	Messagebox ('EDIT','Job ID ' + ls_job_id + ' already exists.' +  &
	'~n~rPlease enter a different job ID.',stopsign!)
	IF gnv_server.of_JobCreate( il_job_id ) < 0 THEN Return -1

	is_job_id = String( il_job_id )

	dw_subset_options.setitem(1,'job_id',is_job_id)
	dw_subset_options.SetRedraw(TRUE)
	ls_job_id = is_job_id	
	// FDG 01/25/02 end
	Return -1
End If
//NLG 04-04-00 Track 2676 Don't allow special characters
//if pos(ls_job_id,"'") > 0 then
//	messagebox('WARNING','May not have a quote in the job id')
//	return -1
//end if
//
//if pos(ls_job_id,'"') > 0 then
//	messagebox('WARNING','May not have a quote in the job id')
//	return -1
//end if
int li_len, li_idx
char ls_char
li_len = len(ls_job_id)
for li_idx = 1 to li_len
	ls_char = mid(ls_job_id,li_idx,1)
	if asc(ls_char) > 47 and asc(ls_char) < 58 then
	//numerals
		continue
	elseif Asc(ls_char) > 64 and Asc(ls_char) < 91 Then
	//uppercase letters
		Continue
	ElseIf Asc(ls_char) > 96 and Asc(ls_char) < 122 Then
	//lowercase letters
		continue
	Elseif Asc(ls_char) = 95 THEN  
	//underscore
		continue
	Else
		Messagebox("JOB ID","Invalid character in job id")
		dw_subset_options.setColumn("job_id")
		return -1
	End If
next
//NLG 04-04-00 							END

is_job_id = ls_job_id
Return 0
end event

event ue_call_rpc_create_subset;//**********************************************************************************
//Once all of the tables have been written the appropriate RPC call must be performed. 
//The procedure called will depend on whether the subset will be created immediately or 
//it will be scheduled.
//
//get cmd for RPC call
//**********************************************************************************
// AJS	03/30/98 4.0 Add code to change microhelp for subsets with no rows
//	NLG	05/03/00 4.5 To keep front end consistent with openserver, no rows
//						will be considered a warning instead of error
//	GaryR	03/22/01	Stars 4.7 DataBase Port - Implement Stars Server Functionality
//	GaryR	08/10/01	Track 2390d	Redesign the immediate subset scheduling logic
//**********************************************************************************

//	GaryR	03-22-01	Stars 4.7 DataBase Port - Begin
//string ls_os_login, ls_os_password, ls_os_name, ls_sql_login, ls_sql_password, ls_sql_name
//string ls_database, ls_dictionary, ls_cmd, ls_site_id, ls_return, ls_run_date, ls_priority
integer 	li_rc, li_priority, li_run_frequency
DateTime	ldtm_sched_date

//setmicrohelp(w_main,'Accessing OpenServer')
setmicrohelp(w_main,'Accessing StarsServer')

//If dw_subset_options.getitemnumber(1,'sched') = 0 Then
//		ls_cmd = 'cmd'
//		ls_run_date = ''
//		ls_priority = ''
//Else
//		ls_cmd = 'back'
//		ls_run_date = string(dw_subset_options.getitemdatetime(1,'sched_date'),"YYYYMMDDHHMM")
//		ls_priority = string(dw_subset_options.getitemnumber(1,'priority'))
//End if

////get site id from stars.ini
//ls_site_id=ProfileString(gv_ini_path + 'STARS.INI','carrier','SITEID', ' ')
//If trim(ls_site_id) = '' then
//		MessageBox("ERROR","Unable to find Site Id in Stars.Ini file. "+&
//						"~rPlease advise your system administrator."+&
//						"~rSubset can not be created.",StopSign!)
//		return -1
//end if

//get open server and sql server name
//li_rc = inv_temp_table.of_get_server_info(ls_os_login, ls_os_password, ls_os_name, &
//						 ls_sql_login, ls_sql_password, ls_sql_name)

//if li_rc<>1 then
//		Messagebox("Error", "Error retrieving OpenServer server info and sql server info. " +&
//						"Can not create subset.",StopSign!)
//		return -1
//end if

////get database and dictionary name
//select db, elem_name
//into :ls_database, :ls_dictionary
//from DICTIONARY
//where elem_name = 'DICTIONARY'
//Using stars2ca;
//
//li_rc = stars2ca.of_check_status()
//if li_rc<>0 then
//		Messagebox("Error", "Error retrieving database and dictionary name. " +&
//						"Can not create subset.",StopSign!)
//		return -1
//end if
//ls_database = UPPER(ls_database)
//ls_dictionary = UPPER(ls_dictionary)

//ls_return = gapi.osconn(ls_cmd, ls_os_name, ls_os_login, ls_os_password,  &
//	ls_sql_name, ls_sql_login, ls_sql_password, ls_site_id, is_job_id, gc_user_id, &
//	ls_database, ls_dictionary, ls_run_date, ls_priority)

li_priority = dw_subset_options.GetItemNumber( 1, 'priority' )
ldtm_sched_date = dw_subset_options.GetItemDatetime( 1, 'sched_date' )

IF dw_subset_options.GetItemNumber( 1, 'sched' ) > 0 THEN
	li_run_frequency = dw_subset_options.GetItemNumber( 1, 'run_frequency' )
	IF li_run_frequency = 0 THEN li_run_frequency = 1
END IF

li_rc = gnv_server.of_JobSubmit( il_job_id, is_job_id, li_priority, li_run_frequency, ldtm_sched_date )

IF li_rc < 0 THEN
	MessageBox( "ERROR", "Unable to create Subset", StopSign! )
	Return -1
//If ls_return <> "SUCCESS" then
//	if dw_subset_options.getitemnumber(1,'sched') = 0 Then
//		Messagebox("ERROR ", "Unable to create Foreground Subset: " + ls_return,StopSign!)
//	  	return -1
//	else
//		Messagebox("ERROR ", "Unable to schedule Background Subset: " + ls_return,StopSign!)
//	  	return -1
//	end if
Else
	gc_active_subset_name = dw_subset_options.getitemstring(1,'subc_name')
	gc_active_subset_id = gv_subset_id
	gc_active_subset_case = Istr_sub_opt.case_id + Istr_sub_opt.case_spl + Istr_sub_opt.case_ver
End if
//	GaryR	03-22-01	Stars 4.7 DataBase Port - End

// AJS 03/30/98 begin
//	GaryR	08/10/01	Track 2390d - Begin
If dw_subset_options.getitemnumber(1,'sched') = 0 Then	
//	//	Subset was successfully created.  Display the # of rows
//	//	in the Microhelp.
//	String	ls_err_msg
//	Long 		ll_count,			&
//				ll_sub_count		
//	ls_err_msg	=	'The subset was not created because there was no data for the subset'
//	n_ds	lds_sub_cntl
//	lds_sub_cntl	=	CREATE	n_ds
//	lds_sub_cntl.DataObject	=	'd_qe_sub_cntl'
//	lds_sub_cntl.SetTransObject (Stars2ca)
//	ll_count	=	lds_sub_cntl.Retrieve (gc_active_subset_id)
//	IF	ll_count	>	0		THEN
//			ll_sub_count	=	lds_sub_cntl.object.subc_no_rows [ll_count]
//			IF	ll_sub_count	>	0		THEN
//				w_main.SetMicroHelp ('Request successful.  ' + &
//											String (ll_sub_count)	+ &
//											' rows exist in subset ' + &
//											gc_active_subset_name	+ '.')
//			ELSE
//				MessageBox ('Warning', ls_err_msg)//('Subset Error', ls_err_msg)
//				w_main.SetMicroHelp (ls_err_msg)
//			END IF
//	ELSE
//		// No rows in subset
//		MessageBox ('Warning', ls_err_msg)//('Subset Error', ls_err_msg)
//		w_main.SetMicroHelp (ls_err_msg)
//	END IF
//	Destroy	lds_sub_cntl
	w_main.SetMicroHelp ('Request successful.  ' + &
								gc_active_subset_name	+ &
								' is scheduled for immediate creation on ' + &
								String(idt_current_datetime, 'm/d/yyyy') + '.')
Else	
	w_main.SetMicroHelp ('Request successful.  ' + &
								gc_active_subset_name	+ &
								' is scheduled for creation on ' + &
								String(dw_subset_options.getitemdatetime(1,'sched_date'), 'm/d/yyyy') + '.')
END IF
//	GaryR	08/10/01	Track 2390d - End

Return 0	
// AJS 03/30/98 end
end event

event ue_copy_notes();// ue_copy_notes for w_subset_options
//--------------------------------------------------------------------------------
// description:
//	this event is called when an independent subset or a case_linked subset is being
//	saved-as.  If case_linked subset, notes don't get copied over with subset. 
// First, the notes table is checked for any notes attached to the subset being
//	linked/saved and are copied over to the active case (or independent subset).
// The notes_rel_type, notes_sub_type and note_id are changed accordingly.
//---------------------------------------------------------------------------------
//	History:
// 06/04/98 NLG	created
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks.
// 10/17/02	Jason	Track 2883d  populate structure with note_desc
//	08/16/05	GaryR	Track 4361d	Add log entry for new notes
//----------------------------------------------------------------------------------

//NLG 6-2-98 If linking independent subset bring along the notes
//10/06/99 AJS TS2443 - Rls 4.5 Enhanced notes
string ls_rel_type, ls_rel_id, ls_new_sub_type, ls_dept_id, ls_user_id, ls_desc, ls_note_id
string ls_new_rel_type, ls_new_rel_id, ls_rte_ind
datetime ldt_datetime
long ll_rows, ll_row_num, ll_new_row
integer li_rc 

n_cst_notes lnvo_notes				// FDG 12/06/01

ldt_datetime = gnv_app.of_get_server_date_time()

ls_rel_type = 'SS'
ls_rel_id = is_orig_subset_name

if istr_sub_opt.case_id = 'NONE' then
	ls_new_rel_type = 'SS'
	ls_new_sub_type = 'GI'
	ls_new_rel_id = istr_sub_opt.subset_name
else
	ls_new_rel_type = 'CA'
	ls_new_sub_type = 'SB'
	ls_new_rel_id = istr_sub_opt.case_id+istr_sub_opt.case_spl+istr_sub_opt.case_ver
end if

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
		//if notes exist for SS, copy rows for new subset
		if ll_rows > 0 then
			for ll_row_num = 1 to ll_rows
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
				lnvo_notes.is_notes_desc = ds_notes.GetItemString(ll_row_num, 'note_desc')					
				// JasonS 10/17/02 End - Track 2883d					
				li_rc = lnvo_notes.uf_copy_note()
				if li_rc <> 1 then
					messagebox('NOTES','Error copying notes')
				end if
			next
			//li_rc = ds_notes.update()
			//NLG 7-28-98 Commit if update successful   **START**
			//if li_rc <> 1 then
			//	ErrorBox(Stars2ca,'Error copying attached Notes.')
			//end if
			if stars2ca.of_check_status() <> 0 then
				messagebox('ERROR','Error copying attached Notes')
			else
				stars2ca.of_commit()
			end if
			//NLG 7-28-98								 			***STOP**
		end if //ll_rows > 0
	end if //ll_rows < 0
end if //li_rc <> 1
	
if isValid(ds_notes) then destroy(ds_notes)

end event

event type integer ue_verify_case_id(string as_case_id);//Modifications:
//	08-16-99	NLG	1. Change u_nvo_case_functions to n_cst_case
//						2.	change nvo_subset_functions to n_cst_case
//////////////////////////////////////////////////////////////////////////////

//integer li_return
//
//U_NVO_Case_Functions	luo_case_functions
//NVO_Subset_Functions	luo_subset_functions
//
//luo_case_functions = Create U_NVO_Case_Functions
//li_return = luo_case_functions.event ue_valid_case(left(as_case_id,10),&
//			mid(as_case_id,11,2),mid(as_case_id,13,2))
//Choose Case li_return
//	case 0
//		luo_subset_functions = create NVO_Subset_Functions
//		li_Return =	luo_subset_functions.uf_determine_case_security(as_case_id)	// FNC 07/21/98
//		if li_return = 100 then 
//			MessageBox("Secure case","You have insufficient privileges to save a query to this case",StopSign!)
//		elseif li_return < 0 then
//			Messagebox('EDIT ERROR','Unable determine case security for this case.  Cannot proceed')
//		End If
//	case -1
//		messagebox('ERROR','Case not found. Select another case')
//	case -2
//		messagebox('ERROR','Case has been deleted. Select another case')
//	case -3
//		messagebox('ERROR','Case has been closed. Select another case')
//	case -4
//		messagebox('ERROR','Error verifying case id.')
//End Choose
//
//return li_return

n_cst_case	lnv_case
integer li_return
string ls_case_id,ls_case_spl,ls_case_ver
string ls_msg

ls_case_id = left(as_case_id,10)
ls_case_spl = mid(as_case_id,11,2)
ls_case_ver = mid(as_case_id,13,2)

lnv_case = Create n_cst_case
li_return = lnv_case.uf_valid_case(ls_case_id,ls_case_spl,ls_case_ver)

Choose Case li_return
	case 0
		ls_msg =	lnv_case.uf_edit_case_security(ls_case_id,ls_case_spl,ls_case_ver)
		IF LEN(ls_msg) > 0 THEN
			messagebox("SECURITY ERROR",ls_msg)
			li_return = -1
		END IF
	case -1
		messagebox('ERROR','Case not found. Select another case')
	case -2
		messagebox('ERROR','Case has been deleted. Select another case')
	case -3
		messagebox('ERROR','Case has been closed. Select another case')
	case -4
		messagebox('ERROR','Error verifying case id.')
End Choose

if IsValid(lnv_case) then destroy lnv_case

return li_return

end event

event ue_verify_date;integer li_rc
n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate(string(date(dw_subset_options.getitemdatetime(1,'sched_date')),'mm/dd/yyyy'))

CHOOSE CASE li_rc
	CASE  0
		MessageBox ('Error', 'No date entered')
		dw_subset_options.SetColumn('sched_date')
		Return -1
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		dw_subset_options.SetColumn('sched_date')
		Return -1
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		dw_subset_options.SetColumn('sched_date')
		Return -1
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		dw_subset_options.SetColumn('sched_date')
		Return -1
END CHOOSE
Return 1
end event

event ue_sched_change(integer ai_schedule);///////////////////////////////////////////////////////////////////////////////////
//
//Script:  w_subset_options.ue_sched_change
//
//This event will be posted to by the itemchanged event in dw_subset_options 
//when column sched changes.  The logic when column sched changes 
//in dw_subset_options.itemchanged will be moved to this script.  
//	
//	Arguments:	1) integer ai_schedule
//
///////////////////////////////////////////////////////////////////////////////////
//	Modifications:
//
//	11/03/99	NLG	Created.
//	11/15/99	NLG	If schedule protected, protect Recurs After
//	03/27/00	FDG	Track 2160d.  Column sched_date already set when coming
//						from patterns
//	08/21/01	GaryR	Track 2407d	Fix background color for "Recuring" field
//	03/19/02	FDG	Stars 5.1.  In this release, disable patterns button for
//						ancillary subsets
// 05/01/02	SAH	Stars 5.1   Array boundary exceeded 
//	03/05/03	GaryR	Track 3464d	Clean up the enabling/disabling of options
//
///////////////////////////////////////////////////////////////////////////////////


datetime ldt_null_datetime

Long		ll_row				// FDG 03/19/02
String	ls_inv_type			// FDG 03/19/02
Integer	li_upper				// FDG 03/19/02
Integer	li_upper2			// FDG 03/19/02
Integer	li_idx				// FDG 03/19/02
Integer	li_idx2				// FDG 03/19/02

if ai_schedule = 0 then		// Run immediately
	dw_subset_options.object.job_id.protect = 1
	dw_subset_options.object.sched_date.protect = 1
	dw_subset_options.object.priority.protect = 1
	dw_Subset_Options.Object.Run_Frequency.protect = 1	//NLG 11-15-99
	SetNull(ldt_null_datetime)
	dw_subset_options.SetItem(1,'Sched_Date', ldt_null_datetime)
	dw_Subset_Options.Object.sched_date_t.Color = stars_colors.protected_text
	dw_Subset_Options.Object.sched_date.Color = dw_Subset_Options.Object.sched_date.Background.Color
	dw_Subset_Options.SetItem(1,'Run_Frequency', 0)//NLG 11-15-99 
	dw_Subset_Options.Object.run_frequency.Color = dw_Subset_Options.Object.sched_date.Background.Color//NLG 11-15-99
	dw_Subset_Options.Object.recurs_after_t.Color = stars_colors.protected_text	//	08/21/01	GaryR	Track 2407d
	dw_Subset_Options.Object.priority_t.Color = 	 stars_colors.protected_text
	dw_Subset_Options.Object.priority.Color =		 stars_colors.protected_text
	dw_Subset_Options.Object.job_id_t.Color = 	 stars_colors.protected_text 
	dw_Subset_Options.Object.job_id.Color = 	 	 stars_colors.protected_text
	dw_Subset_Options.Object.run_frequency.Color= stars_colors.protected_text//NLG 11-15-99
	Cb_pattern.enabled = false
Else			// Schedule the subset
	IF istr_sub_opt.come_from	<>	'PATTERN'		THEN
		dw_subset_options.object.job_id.protect	=	0
		dw_Subset_Options.Object.job_id_t.Color	=	stars_colors.label_text
		dw_Subset_Options.Object.job_id.Color 		=	stars_colors.input_text
		IF istr_sub_opt.come_from	<>	'REPSUB'		THEN
			dw_Subset_Options.Object.Run_Frequency.protect	=	0	//NLG 11-15-99
			dw_Subset_Options.Object.Run_Frequency.Color		=	stars_colors.input_text
			dw_Subset_Options.Object.recurs_after_t.Color	=	stars_colors.label_text	//	08/21/01	GaryR	Track 2407d
		ELSE
			dw_Subset_Options.Object.Run_Frequency.protect	=	1
			dw_Subset_Options.Object.Run_Frequency.Color		=	stars_colors.protected_text
			dw_Subset_Options.Object.recurs_after_t.Color	=	stars_colors.protected_text			
		END IF
	END IF
	
	dw_subset_options.object.sched_date.protect	=	0
	dw_Subset_Options.Object.sched_date_t.Color	=	stars_colors.label_text
	dw_Subset_Options.Object.sched_date.Color		=	stars_colors.input_text
	dw_subset_options.object.priority.protect		=	0
	dw_Subset_Options.Object.priority_t.Color		=	stars_colors.label_text
	dw_Subset_Options.Object.priority.Color		=	stars_colors.label_text

	//	FDG 03/27/00
	IF	istr_sub_opt.come_from	<>	'PATTSUB'		THEN
		dw_subset_options.SetItem(1,'Sched_Date', idt_default_sched_datetime)
	END IF
	if ib_pattern_button then
		Cb_pattern.enabled = true
		// FDG 03/19/02 - For 5.1 only, disable cb_pattern for ancillary subsets
		li_upper	=	UpperBound (istr_sub_opt.sub_info)
		FOR	li_idx	=	1	TO	li_upper
			li_upper2	=	UpperBound (istr_sub_opt.sub_info[li_idx].subset_step)
			 //FOR	li_idx2	=	1	TO	li_idx2			
			  FOR li_idx2  =  1  TO li_upper2				// SAH 05/01/02
				IF Trim (istr_sub_opt.sub_info[li_idx].subset_step[li_idx2].inv_type)	> ' '		THEN
					ls_inv_type	=	istr_sub_opt.sub_info[li_idx].subset_step[li_idx2].inv_type
					ll_row		=	fx_filter_stars_rel_1 ('AN', ls_inv_type, ls_inv_type)
					IF	ll_row	>	0		THEN
						// Ancillary invoice type - disable cb_pattern
						cb_pattern.enabled	=	FALSE
						Exit
					END IF
				END IF
			NEXT
		NEXT
		// FDG 03/19/02 - end
	end if
End if

end event

event ue_compute_schedule_date();//	w_subset_options.ue_compute_schedule_date()
//
//	This event computes the schedule date when run_frequency is greater than 0.  
//	When this occurs, the schedule date is set to the first day after the last payment_date.  
//
//	Arguments: 	none
//	Returns:		none
//
//	History
//	11-3-99	NLG	Created.
//	12-09-99	NLG	Change the way schedule date is computed for future dated subsets.  
//						Take the latest date (if ml) and schedule subset for the 1st of the
//						following month.
//	03-27-00	FDG	Track 2160d.  Don't compute the date when coming from patterns.
//	04-19-00	NLG	Only change the schedule date if data not loaded
//	03/15/01	FDG	Stars 4.7.	Use gnv_server instead of accessing ros_directory.
// 07/11/02	GaryR	Track	3194d	Get range based on invoice type.
//////////////////////////////////////////////////////////////////////////////////////////////

datetime ldtm_end_date  
datetime ldtm_sched_date
datetime ldtm_curr_date
datetime	ldtm_from_date				// FDG 03/15/01
int		li_rc
long 		ll_rows

IF  ii_run_frequency  =  0  THEN
	Return
END IF

// FDG 03/27/00 Begin
IF	istr_sub_opt.come_from	=	'PATTSUB'	THEN
	Return
END IF
// FDG 03/27/00 End

n_cst_datetime	lnv_datetime	// Autoinstantiated
//ldtm_end_date  =  istr_sub_opt.sub_info[1].subset_step[1].paid_thru_date//NLG 12-09-99 recalculate below

//NLG 12-09-99 START*****
date ldt_end_date
integer li_levels, li_steps
integer li_1, li_2
li_levels = upperbound(istr_sub_opt.sub_info)
for li_1 = 1 to li_levels
	li_steps = upperbound(istr_sub_opt.sub_info[li_1].subset_step)
	for li_2 = 1 to li_steps
		if ldtm_end_date < istr_sub_opt.sub_info[li_1].subset_step[li_2].paid_thru_date	then
			ldtm_end_date = istr_sub_opt.sub_info[li_1].subset_step[li_2].paid_thru_date	
		end if
	next
next
// FDG 03/15/01 - remove ros_directory
//NLG 04-19-00 START****
//n_ds lds_ros_dir
//lds_ros_dir = CREATE n_ds
//lds_ros_dir.dataobject = 'd_ros_directory'//same dataobject used in query engine
//li_rc = lds_ros_dir.SetTransObject(Stars1ca)
//IF li_rc <> 1 THEN
//	Messagebox("ERROR","Error setting transaction object in " +&
//				"w_subset_options.ue_compute_schedule_date")
//	return
//END IF
//ll_rows = lds_ros_dir.retrieve()
//li_rc = lds_ros_dir.SetSort("to_date D")
//li_rc = lds_ros_dir.Sort()
//ldtm_curr_date = lds_ros_dir.Object.to_date[1]//the most current date in ros directory

// 07/11/02	GaryR	Track	3194d
//li_rc	=	gnv_server.of_GetMostRecentMonth (ldtm_from_date, ldtm_curr_date)
//li_rc	=	gnv_server.of_GetMostRecentMonth( istr_sub_opt.sub_info[1]. subset_step[1].subset_type, ldtm_from_date, ldtm_curr_date )

// FDG 03/15/01 end

IF ldtm_curr_date > ldtm_end_date THEN
	//data is loaded for this subset
	return
END IF
//NLG 04-19-00 STOP*****

ldt_end_date = date(ldtm_end_date)//change datetime to date for next function
ldt_end_date = lnv_datetime.of_getnextmonth(ldt_end_date)//get the next month
ldt_end_date = lnv_datetime.of_firstdayofmonth(ldt_end_date)//use first of the month 
ldtm_end_date = datetime(ldt_end_date)//change back to datetime
//NLG 12-09-99 STOP******

ldtm_sched_date  =  lnv_datetime.of_relativedatetime (ldtm_end_date, 1)
dw_subset_options.object.sched_date [1] = ldtm_sched_date
// dw_subset_options.object.sched_date.protect = 1  // Leave schedule date unprotected

end event

event type integer ue_verify_active_case();//*********************************************************************************
// Script Name:	ue_verify_active_case
//
//	Arguments:		N/A
//
// Returns:			Integer
//						-1	=	Error
//						 1	=	Success
//
//	Description:	This event is triggered when the Patterns button is clicked and
//						the Case is 'NONE'.  Patterns always requires a valid case ID
//						in order to function.  This means that when 'NONE' is passed to
//						Patterns, it uses the Active Case instead.  As a result, the
//						active case must be valid
//
//*********************************************************************************
//	
// 06/02/00 FDG	Track 2209c.  Created for Stars 4.5 SP1.
//	08/28/02	GaryR	Track 2904d	Change message
//
//*********************************************************************************

Integer		li_rc

n_cst_case	lnv_case

String		ls_case_id,			&
				ls_case_spl,		&
				ls_case_ver,		&
				ls_msg

ls_case_id	=	Left (gv_active_case, 10)
ls_case_spl =	Mid (gv_active_case, 11, 2)
ls_case_ver =	Mid (gv_active_case, 13, 2)

lnv_case		=	Create n_cst_case

li_rc			=	lnv_case.uf_valid_case (ls_case_id, ls_case_spl, ls_case_ver)

Choose Case li_rc
	Case 0
		ls_msg	=	lnv_case.uf_edit_case_security (ls_case_id, ls_case_spl, ls_case_ver)
		IF Len (ls_msg)	>	0	THEN
			MessageBox ("SECURITY ERROR", ls_msg)
			li_rc = -1
		END IF
	Case -1
		//	08/28/02	GaryR	Track 2904d
		//MessageBox ('ERROR', 'Active case not found.  Select another active case.')
		MessageBox ('ERROR', 'Active case not found.  Select an active case.')
	Case -2
		MessageBox ('ERROR', 'Active case has been deleted.  Select another active case.')
	Case -3
		MessageBox ('ERROR', 'Active case has been closed.  Select another active case.')
	Case -4
		MessageBox ('ERROR', 'Error verifying the active case.')
End Choose

IF IsValid(lnv_case)		THEN
	Destroy lnv_case
END IF

Return li_rc


end event

event type integer ue_validateclaimsrange();//////////////////////////////////////////////////////////////////
//
//	11/26/02	GaryR	Track 3275d	Validate that dependants are in sync
//	04/02/04	GaryR	Track 6004c	Do not validate future recurring subsets
//
//////////////////////////////////////////////////////////////////

Long ll_row
String	ls_inv_type, ls_dependants[], ls_err, ls_dep
Integer	li_level, li_step, li_dep, li_ctr
Datetime	ldtm_from_date, ldtm_thru_date, ldtm_load_from, ldtm_load_thru
sx_subsetting_info	lstr_sub_info[]

IF istr_sub_opt.come_from = 'QUERY' THEN
	lstr_sub_info = istr_sub_opt.sub_info
ELSEIF istr_sub_opt.come_from = 'PATTSUB' THEN
	lstr_sub_info = istr_sub_opt.sub_info_copy
ELSE
	Return 1
END IF

FOR li_level = 1 TO UpperBound( lstr_sub_info )
	FOR li_step  =  1 TO UpperBound( lstr_sub_info[li_level].subset_step )
		//	Do not process future recurring
		IF lstr_sub_info[li_level].run_frequency > 0 THEN Continue
		
		//	Do not process subsets
		IF lstr_sub_info[li_level].subset_step[li_step].input_type <> "BASE" THEN Continue
		
		//	Obtain parameters
		ls_inv_type	=	lstr_sub_info[li_level].subset_step[li_step].inv_type
		IF IsNull( ls_inv_type ) OR Trim( ls_inv_type )	= "" THEN Continue
		
		//	Do not process ancillary
		IF fx_filter_stars_rel_1( 'AN', ls_inv_type, ls_inv_type ) > 0 THEN Continue

		//	Obtain all dependants
		IF This.of_GetDependants( ls_inv_type, ls_dependants[] ) < 1 THEN Continue
		
		//	Validate that dependants are 
		//	within the range of the main
		FOR li_dep = 1 TO UpperBound( ls_dependants )
			ldtm_from_date = lstr_sub_info[li_level].subset_step[li_step].paid_from_date
			ldtm_thru_date = lstr_sub_info[li_level].subset_step[li_step].paid_thru_date
			IF NOT gnv_server.of_AreDatesInRange( ls_dependants[li_dep], ldtm_from_date, ldtm_thru_date ) THEN
				//Get the loaded range for the current dependant
				gnv_server.of_GetLoadedRange( ls_dependants[li_dep], "", ldtm_load_from, ldtm_load_thru )
				
				//	Scenario 1 - The loaded range is completely 
				//	outside of the query range. (Less Than)
				IF ldtm_from_date > ldtm_load_thru THEN GOTO MESSAGE
				
				//	Scenario 2 - The loaded range is partially 
				//	within the query range. (Less Than)
				IF ldtm_thru_date > ldtm_load_thru THEN
					ldtm_from_date = Datetime( RelativeDate( Date( ldtm_load_thru ), +1 ) )
					GOTO MESSAGE
				END IF
				
				//	Scenario 3 - The loaded range is completely 
				//	outside of the query range. (Greater Than)
				IF ldtm_thru_date < ldtm_load_from THEN GOTO MESSAGE
				
				//	Scenario 4 - The loaded range is partially 
				//	within the query range. (Greater Than)
				IF ldtm_from_date < ldtm_load_from THEN
					ldtm_thru_date = Datetime( RelativeDate( Date( ldtm_load_from ), -1 ) )
					GOTO MESSAGE
				END IF
				
				MESSAGE:
				li_ctr++
				ls_dep += " (" + String( li_ctr ) + ") Missing Claims Data: " + ls_dependants[li_dep] + &
								" - " + This.of_GetDescription( ls_dependants[li_dep] ) + &
								"~tMissing Payment Range: " + String( ldtm_from_date, "mm/dd/yyyy" ) + &
								" - " + String( ldtm_thru_date, "mm/dd/yyyy" ) + "~n~r"
			END IF
		NEXT
		
		//	Build error message
		IF Trim( ls_dep ) <> "" THEN
			ls_err += "~n~rMain Data Source: " + ls_inv_type + " - " + This.of_GetDescription( ls_inv_type ) + &
							"~tSpecified Payment Range: " + String( lstr_sub_info[li_level].subset_step[li_step].paid_from_date, "mm/dd/yyyy" ) + &
								" - " + String( lstr_sub_info[li_level].subset_step[li_step].paid_thru_date, "mm/dd/yyyy" ) + "~n~r" + ls_dep
			ls_dep = ""
			li_ctr = 0
		END IF
	NEXT
NEXT

//	Warn the user of range mismatch
IF Trim( ls_err ) <> "" THEN
	Return MessageBox( "Warning", "The following claims data is not loaded and will not " + &
									"be available in your subset:~n~r" + ls_err + "~n~r" + &
									"Do you still wish to continue creating the subset?", &
									Exclamation!, YesNo!, 2 )
END IF

Return 1
end event

public function integer wf_retrieve_case_desc (string as_case_id);//Modifications:
//	08/31/98 NLG 	FS362 convert case to case_cntl
//	02/11/05	GaryR	Track 4279d	Issues when active Case is NONE
//************************************************************************
string ls_case_id, ls_case_spl, ls_case_ver, ls_case_desc

If Trim( as_case_id ) = 'NONE' then
		Dw_Subset_Options.Object.Case_Desc[1] = ''
	Else
		ls_case_id  = Left(as_case_id,10)
		ls_case_spl  = Mid(as_case_id,11,2)
		ls_case_ver  = Mid(as_case_id,13,2)
		
		//08-31-98 NLG FS362 convert case to case_cntl
		Select case_desc into :ls_case_desc							
			from Case_cntl
			where case_id  = Upper( :ls_case_id ) and					
					case_spl = Upper( :ls_case_spl ) and					
					case_ver   = Upper( :ls_case_ver )						
			Using Stars2ca;											
																	
		If stars2ca.of_check_status() <> 0 then
				Messagebox('Error','Error Reading Case to get desc')
				RETURN -1
		End If
		Dw_Subset_Options.Object.Case_Desc[1] = ls_case_desc
End If
Return 1
end function

public function integer wf_get_previous_crit (sx_source_subset arg_subset_src_name[], string arg_prev_sub_src_type, string arg_crit_used_type, ref string arg_step_id);//wf_get_previous_crit
//  Assumes connection to STARS2ca no disconnect done in this function. 
//****************************************************************************************
//	08/31/94	FNC	Change to retrieve only one table type
//	06/10/98	NLG	1)	Change function to use datastores rather than embedded sql
//						2)	add argument arg_by_level
//						3)	increment crit_line instead of copying from previous subset criteria
// 01/11/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks.
//	12/12/01	FDG	Track 2527d.  Prevent Oracle from inserting empty string.
//	03/21/03	GaryR	Track 3264d	Incerement the level to prevent dups
//	08/14/03	GaryR	Track 3264d	Revert back to the above change
//****************************************************************************************
int lv_crit_level

int li_rc
int ll_new_row, ll_row_num, ll_row
string ls_step_id, ls_prev_step, ls_empty
int li_by_level, li_crit_line //NLG 10-02-98 
int li_temp_level = 1 
int li_prev_level = 1//NLG 10-14-98
int li_idx,li_total_subsets
string ls_temp_max_step,ls_max_step
int li_temp_max_level, li_max_level
string ls_base ='BASE'
string ls_duplicate = 'DUPLICATE'


setpointer(hourglass!)
setmicrohelp(w_main,'Updating criteria tables ...')

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

/*loop thru array and get largest step for source subsets*/

li_total_subsets = upperbound(arg_subset_src_name[])
FOR li_idx = 1 to li_total_subsets
	if (arg_subset_src_name[li_idx].source_subset_id <> ls_base) AND (arg_subset_src_name[li_idx].source_subset_id) <> ls_duplicate then
		select max(step_id), max(by_level)
			into :ls_temp_max_step, :li_temp_max_level
			from criteria_from_tbls_used
			where by_id = Upper( :arg_subset_src_name[li_idx].source_subset_id ) and 
					by_type = Upper( :arg_prev_sub_src_type )
			using stars2ca;
			
			If stars2ca.of_check_status() <> 0 then
				Errorbox(Stars2ca,'Error Obtaining Previous Criteria Level')
				RETURN -1
			End If
			
			if ls_temp_max_step > ls_max_step then
				ls_max_step = ls_temp_max_step
			end if 
			
			if li_temp_max_level > li_max_level then
				li_max_level = li_temp_max_level
			end if
			
	end if

NEXT

arg_step_id = ls_max_step
//retrieve criteria_used_line info
string ls_crit_lp,ls_crit_exp1,ls_crit_data_type,ls_crit_op
string ls_crit_exp2, ls_crit_rp, ls_crit_logic
n_ds ds_criteria_used_line
ds_criteria_used_line = create n_ds
ds_criteria_used_line.dataobject = 'd_criteria_used_line1'

li_rc = ds_criteria_used_line.SetTransObject(STARS2CA)

ds_criteria_used_line.of_SetTrim(TRUE)			// FDG 12/12/01

if li_rc <> 1 then
	ErrorBox(Stars2ca,'Error in SetTransObject for criteria_used_line.')
	if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line
	return -1
end if

ds_criteria_used_line.reset()
li_crit_line = 0		/*counter for crit_line */
ls_prev_step = '1'

//for each source subset in array, copy criteria_used_line rows to new subset id
FOR li_idx = 1 to li_total_subsets
	if arg_subset_src_name[li_idx].source_subset_id <> ls_base AND arg_subset_src_name[li_idx].source_subset_id <> ls_duplicate then
		ll_row = ds_criteria_used_line.retrieve(arg_subset_src_name[li_idx].source_subset_id, arg_prev_sub_src_type)
		if ll_row < 0 then
		 	ErrorBox(Stars2ca,'Error retrieving criteria_used_line.')
			if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line
			return -1
		end if

		if ll_row > 0 then
			ll_new_row = 0
			for ll_row_num = 1 to ll_row
				li_temp_level = arg_subset_src_name[li_idx].level_num//NLG  10-14-98
				ls_crit_lp = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_lp')
				ls_crit_exp1 = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_exp1')
				ls_crit_data_type = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_data_type')
				ls_crit_op = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_op')
				ls_crit_exp2 = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_exp2')
				ls_crit_rp = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_rp')
				ls_crit_logic = ds_criteria_used_line.GetItemString(ll_row_num, 'crit_logic')
				ls_step_id = ds_criteria_used_line.GetItemString(ll_row_num, 'step_id')

				//if step_id or by_level change, set crit line counter back to 1
				if (ls_step_id > ls_prev_step) OR (li_temp_level > li_prev_level) then 
					li_crit_line = 1
					li_prev_level = li_temp_level
				else
					li_crit_line++
				end if
				ls_prev_step = ls_step_id
				ll_new_row = ll_row_num + ll_row
				
				// 01/11/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
				IF Trim( ls_crit_lp )		= "" THEN ls_crit_lp		= ls_empty
				IF Trim( ls_crit_rp )		= "" THEN ls_crit_rp		= ls_empty
				IF Trim( ls_crit_logic )	= "" THEN ls_crit_logic	= ls_empty
				// 01/11/01	GaryR	Stars 4.7 DataBase Port - End
				
				//insert criteria rows for new subset
				ds_criteria_used_line.InsertRow(ll_new_row)
				ds_criteria_used_line.setItem(ll_new_row,'by_type',arg_crit_used_type)
				ds_criteria_used_line.setItem(ll_new_row,'by_id',gv_subset_id)
				li_by_level++
				ds_criteria_used_line.setItem(ll_new_row,'by_level',li_by_level)

				ds_criteria_used_line.setItem(ll_new_row,'crit_line',li_crit_line)
				//ds_criteria_used_line.setItem(ll_new_row,'crit_line',ll_row_num)
				ds_criteria_used_line.setItem(ll_new_row,'crit_lp',ls_crit_lp)
				ds_criteria_used_line.setItem(ll_new_row,'crit_exp1',ls_crit_exp1)
				ds_criteria_used_line.setItem(ll_new_row,'crit_data_type',ls_crit_data_type)
				ds_criteria_used_line.setItem(ll_new_row,'crit_op',ls_crit_op)
				ds_criteria_used_line.setItem(ll_new_row,'crit_exp2',ls_crit_exp2)
				ds_criteria_used_line.setItem(ll_new_row,'crit_rp',ls_crit_rp)
				ds_criteria_used_line.setItem(ll_new_row,'crit_logic',ls_crit_logic)
				ds_criteria_used_line.setItem(ll_new_row,'step_id',ls_step_id)
			next

			li_prev_level = arg_subset_src_name[li_idx].level_num//NLG  10-14-98
			li_rc = ds_criteria_used_line.EVENT ue_update( TRUE, TRUE )
			if li_rc <> 1 then
				ErrorBox(Stars2ca,'Error updating criteria_used_line.')
				if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line
			end if
			
		end if //ll_row >0
	end if//if working with source subset
next

//retrieve criteria_used info
string 	ls_crit_id,ls_crit_sub_tbl_type,ls_crit_fltr_ind
datetime ldt_crit_datetime 
string 	ls_crit_desc
n_ds ds_criteria_used
ds_criteria_used = create n_ds
ds_criteria_used.dataobject = 'd_criteria_used1'
	
li_rc = ds_criteria_used.SetTransObject(STARS2CA)
if li_rc <> 1 then
	ErrorBox(Stars2ca,'Error in SetTransObject for criteria_used.')
	if isValid(ds_criteria_used) then destroy ds_criteria_used
	if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line			// FDG 12/06/01
	return -1
end if

li_by_level = 0
ds_criteria_used.reset()
FOR li_idx = 1 to li_total_subsets
	if arg_subset_src_name[li_idx].source_subset_id <> ls_base AND arg_subset_src_name[li_idx].source_subset_id <> ls_duplicate then
		ll_row = ds_criteria_used.retrieve(arg_subset_src_name[li_idx].source_subset_id, arg_prev_sub_src_type)
		if ll_row < 0 then
			ErrorBox(Stars2ca,'Error retrieving criteria_used.')
			if isValid(ds_criteria_used) then destroy ds_criteria_used
			if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line			// FDG 12/06/01
			return -1
		end if
	
		if ll_row > 0 then
				ll_new_row = 0
				for ll_row_num = 1 to ll_row
					ls_crit_id = ds_criteria_used.GetItemString(ll_row_num,'crit_id')
					ls_crit_sub_tbl_type = ds_criteria_used.GetItemString(ll_row_num, 'crit_sub_tbl_type')
					ls_crit_fltr_ind = ds_criteria_used.GetItemString(ll_row_num, 'crit_fltr_ind')
					ldt_crit_datetime = ds_criteria_used.GetItemDateTime(ll_row_num, 'crit_datetime')
					ls_crit_desc = ds_criteria_used.GetItemString(ll_row_num, 'crit_desc')
					ls_step_id = ds_criteria_used.GetItemString(ll_row_num, 'step_id')
					ll_new_row = ll_row_num + ll_row
					
					// 01/11/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
					IF Trim( ls_crit_fltr_ind ) = "" THEN ls_crit_fltr_ind = ls_empty
					
					//insert criteria rows for new subset
					ds_criteria_used.InsertRow(ll_new_row)
					ds_criteria_used.setItem(ll_new_row,'by_type',arg_crit_used_type)
					ds_criteria_used.setItem(ll_new_row,'by_id',gv_subset_id)
					li_by_level++
					ds_criteria_used.setItem(ll_new_row,'by_level',li_by_level)
					ds_criteria_used.setItem(ll_new_row,'crit_id',ls_crit_id)
					ds_criteria_used.setItem(ll_new_row,'crit_sub_tbl_type',ls_crit_sub_tbl_type)
					ds_criteria_used.setItem(ll_new_row,'crit_fltr_ind',ls_crit_fltr_ind)
					ds_criteria_used.setItem(ll_new_row,'crit_datetime',ldt_crit_datetime)
					ds_criteria_used.setItem(ll_new_row,'crit_desc',ls_crit_desc)
					ds_criteria_used.setItem(ll_new_row,'step_id',ls_step_id)
				next
				
			li_rc = ds_criteria_used.EVENT ue_update( TRUE, TRUE )
			if li_rc <> 1 then
				ErrorBox(Stars2ca,'Error updating criteria_used.')
				if isValid(ds_criteria_used) then destroy ds_criteria_used
				if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line			// FDG 12/06/01
				return -1
			end if
	
		end if //ll_row >0
	end if//if working with source subset
NEXT
	
//retrieve criteria_from_tbls_used info
string ls_tbl_1, ls_tbl_2
string ls_prev_tbl1, ls_prev_tbl2,ls_prev_step_id//NLG 11-06-98 
n_ds ds_criteria_from_tbls_used
ds_criteria_from_tbls_used = create n_ds
ds_criteria_from_tbls_used.dataobject = 'd_criteria_from_tbls_used1'
	
li_rc = ds_criteria_from_tbls_used.SetTransObject(STARS2CA)
if li_rc <> 1 then
	ErrorBox(Stars2ca,'Error in SetTransObject for criteria_from_tbls_used.')
	if isValid(ds_criteria_from_tbls_used) then destroy ds_criteria_from_tbls_used
	if isValid(ds_criteria_used) then destroy ds_criteria_used						// FDG 12/06/01
	if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line			// FDG 12/06/01
	return -1
end if

li_by_level = 0
ds_criteria_from_tbls_used.reset()
FOR li_idx = 1 to li_total_subsets
	if arg_subset_src_name[li_idx].source_subset_id <> ls_base AND arg_subset_src_name[li_idx].source_subset_id <> ls_duplicate then
		ll_row = ds_criteria_from_tbls_used.retrieve(arg_subset_src_name[li_idx].source_subset_id, arg_prev_sub_src_type)
		if ll_row < 0 then
			ErrorBox(Stars2ca,'Error retrieving criteria_from_tbls_used.')
			if isValid(ds_criteria_from_tbls_used) then destroy ds_criteria_from_tbls_used
			if isValid(ds_criteria_used) then destroy ds_criteria_used						// FDG 12/06/01
			if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line			// FDG 12/06/01
			return -1
		end if
	
		if ll_row > 0 then
				ll_new_row = 0
				for ll_row_num = 1 to ll_row
					ls_prev_tbl1 = ls_tbl_1; ls_prev_tbl2 = ls_tbl_2; ls_prev_step_id = ls_step_id//NLG 11-06-98
					ls_tbl_1 = ds_criteria_from_tbls_used.GetItemString(ll_row_num, 'tbl_1')
					ls_tbl_2 = ds_criteria_from_tbls_used.GetItemString(ll_row_num, 'tbl_2')
					ls_step_id = ds_criteria_from_tbls_used.GetItemString(ll_row_num, 'step_id')
					if (ls_tbl_1 = ls_prev_tbl1) and (ls_tbl_2 = ls_prev_tbl2) and (ls_prev_step_id = ls_step_id) then continue //
					ll_new_row = ll_row_num + ll_row
					//insert criteria rows for new subset
					ds_criteria_from_tbls_used.InsertRow(ll_new_row)
					ds_criteria_from_tbls_used.setItem(ll_new_row,'by_type',arg_crit_used_type)
					ds_criteria_from_tbls_used.setItem(ll_new_row,'by_id',gv_subset_id)
					li_by_level++
					ds_criteria_from_tbls_used.setItem(ll_new_row,'by_level',li_by_level)
					ds_criteria_from_tbls_used.setItem(ll_new_row,'tbl_1',ls_tbl_1)
					ds_criteria_from_tbls_used.setItem(ll_new_row,'tbl_2',ls_tbl_2)
					ds_criteria_from_tbls_used.setItem(ll_new_row,'step_id',ls_step_id)
				next
				li_rc = ds_criteria_from_tbls_used.EVENT ue_update( TRUE, TRUE )
				if li_rc <> 1 then
				ErrorBox(Stars2ca,'Error updating criteria_from_tbls_used.')
					if isValid(ds_criteria_from_tbls_used) then destroy ds_criteria_from_tbls_used
					if isValid(ds_criteria_used) then destroy ds_criteria_used						// FDG 12/06/01
					if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line			// FDG 12/06/01
					return -1
				end if
		end if //ll_row >0
	end if //working with source subset
NEXT

COMMIT USING STARS2CA;
li_rc = STARS2CA.of_check_status()
if  li_rc >= 0 then
	STARS2CA.of_commit()
else
	Errorbox(STARS2CA,'Error performing Commit ~rin w_subset_options.wf_get_previous_crit')
end if

setmicrohelp(w_main,'Ready')

if isValid(ds_criteria_used_line) then destroy ds_criteria_used_line
if isValid(ds_criteria_used_line) then destroy ds_criteria_used
if isValid(ds_criteria_from_tbls_used) then destroy ds_criteria_from_tbls_used

RETURN lv_crit_level
end function

public function integer of_getdependants (string as_main_invoice, ref string as_dependants[]);/////////////////////////////////////////////////////////////////
//
//	This method will populate as_dependants with 
//	dependant invoices for the passed in main (as_main_invoice)
//
/////////////////////////////////////////////////////////////////
//
//	11/26/02	GaryR	SPR 3275d	Validate that dependants are in sync
//
/////////////////////////////////////////////////////////////////

String	ls_empty[]
Integer	i

as_dependants = ls_empty
w_main.dw_stars_rel_dict.SetFilter( "" )
w_main.dw_stars_rel_dict.Filter()
w_main.dw_stars_rel_dict.SetFilter( "rel_type = 'DP' and  rel_id = '" + as_main_invoice + "'" )
w_main.dw_stars_rel_dict.Filter()
FOR i = 1 TO w_main.dw_stars_rel_dict.RowCount()
	as_dependants[i] = w_main.dw_stars_rel_dict.object.id_2[i]
NEXT

Return UpperBound( as_dependants )
end function

public function string of_getdescription (string as_inv_type);/////////////////////////////////////////////////////////////////
//
//	11/26/02	GaryR	SPR 3275d	Validate that dependants are in sync
//
/////////////////////////////////////////////////////////////////

String	ls_desc
Integer	li_pos

select elem_desc
into :ls_desc
from dictionary
where elem_type = 'TB'
and elem_tbl_type = :as_inv_type
using Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN Return "No Description"

li_pos = Pos( ls_desc, "/" )
IF li_pos > 0 THEN ls_desc = Left( ls_desc, li_pos - 1 )

Return Trim( ls_desc )
end function

on w_subset_options.create
int iCurrent
call super::create
this.dw_bg_step_cntl=create dw_bg_step_cntl
this.dw_bg_sql_line=create dw_bg_sql_line
this.dw_sub_opt_case_link=create dw_sub_opt_case_link
this.dw_criteria_used=create dw_criteria_used
this.dw_criteria_from_tbls_used=create dw_criteria_from_tbls_used
this.dw_criteria_used_line=create dw_criteria_used_line
this.cb_ok=create cb_ok
this.cb_pattern=create cb_pattern
this.cb_cancel=create cb_cancel
this.dw_subset_options=create dw_subset_options
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bg_step_cntl
this.Control[iCurrent+2]=this.dw_bg_sql_line
this.Control[iCurrent+3]=this.dw_sub_opt_case_link
this.Control[iCurrent+4]=this.dw_criteria_used
this.Control[iCurrent+5]=this.dw_criteria_from_tbls_used
this.Control[iCurrent+6]=this.dw_criteria_used_line
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.cb_pattern
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.dw_subset_options
end on

on w_subset_options.destroy
call super::destroy
destroy(this.dw_bg_step_cntl)
destroy(this.dw_bg_sql_line)
destroy(this.dw_sub_opt_case_link)
destroy(this.dw_criteria_used)
destroy(this.dw_criteria_from_tbls_used)
destroy(this.dw_criteria_used_line)
destroy(this.cb_ok)
destroy(this.cb_pattern)
destroy(this.cb_cancel)
destroy(this.dw_subset_options)
end on

event ue_preopen;call super::ue_preopen;Istr_sub_opt = message.PowerObjectParm
end event

event open;call super::open;/////////////////////////////////////////////////////////////////////////////////
// Script:		open
//
// Returns:		None
//
// Description:
// 	Open the subset options Window; set various fields in 			
//    datawindow that were passed in thru a istr_sub_opt struct.
//
/////////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	AJS		01/01/98		Created.
//
//	FDG		03/05/98		inv_temp_table is now defined in w_master.
//								Use a method to create it.  It will be
//								automatically destroyed.
//
// HRB      03/11/98    spec ts147 - ICN Table Name Change
//                      now that the temp table used to create a
//                      subset is named using job_id, the job_id 
//                      is passed in when REPSUB
// AJS      05/11/98    Changed code to take job id from
//                      sub_opt.job_id instead of sub_opt.patt_struc_job_id 
//	NLG		06/04/98		if subset copy/link, get case id and subset name of
//								originating subset
//	NLG		06/11/98		Track #1314 - prepopulate job id
// AJS      07/09/98    Track #1490 - make sure local variable set on re-enter
// FNC		09/01/98		Track #1639 - If gv_active case is blank default to 
//								independent subset.
//	NLG		11/04/99		Ts2463c - The run frequency passed to this window will determine
//								if the job is to be automatically scheduled. If so, specify 
//								on window that subset is scheduled, compute sched date, disable
//								run freq col, disable cb_Pattern.
//	FDG		03/27/00		Track 2160 - If coming from Query Engine, protect/unprotect
//								the patterns button based in if the subset is being
//								scheduled.
//	GaryR		03/22/01		Stars 4.7 - Eliminate Obsolete functionality (Job Restart)
//	GaryR		03/26/01		Stars 4.7 - Implement Stars Server Functionality
//	GaryR		06/20/01		Stars 4.7 - Disable some fields for recurring jobs
//	GaryR		08/21/01		Track 2407d	Do not default to "Run Now"
//	FDG		01/15/02		Track 2644d.  Trim job id to avoid duplicate jobs.
//	GaryR		01/18/02		Track 2664d	Allow "Run Now" for patterns.
//	GaryR		03/05/03		Track 3464d	Clean up the enabling/disabling of options
//	GaryR		04/25/03		Track 3464d	Validate the recurrence schedule of source subset
//	GaryR		05/13/03		Track 3464d	Do not allow changing recurrence on pattern subset
//	GaryR		06/24/03		Track 3464d	Do not map recurring options for pattern subset
//	GaryR		02/11/05		Track 4279d	Issues when active Case is NONE
/////////////////////////////////////////////////////////////////////////////////

int li_sched, li_rc
string ls_name, ls_subset_id, ls_case_id, ls_case_spl, ls_case_ver, ls_case_desc
long ll_setting
boolean lb_no_active_case

w_subset_options.Event ue_get_default_sched_time()

dw_Subset_Options.reset()
dw_Subset_Options.insertrow(0)

dw_Subset_Options.Setitem(1,'User_Id',gc_user_id)
dw_Subset_Options.Setitem(1,'Priority',2)
dw_Subset_Options.Setitem(1,'Sched',0)

dw_Subset_Options.Object.user_id.Color		=	stars_colors.protected_text
dw_Subset_Options.Object.user_id_t.Color	= 	stars_colors.protected_text
dw_Subset_Options.Object.subc_name.Color	=  stars_colors.input_text
dw_Subset_Options.Object.subc_desc.Color	=  stars_colors.input_text
dw_Subset_Options.Object.link.Color			=  stars_colors.label_text
dw_Subset_Options.Object.Case_id.Color 	=	stars_colors.lookup_text
Dw_Subset_Options.object.case_desc.Color	=	stars_colors.protected_text

IF istr_sub_opt.server_job_id > 0 THEN
	il_job_id = istr_sub_opt.server_job_id
	istr_sub_opt.job_id = String( il_job_id )
ELSE
	li_rc = w_subset_options.Event ue_check_job_id()
	if li_rc = 0 then 
		istr_sub_opt.job_id = is_job_id
	else
		istr_sub_opt.status = 'ERROR'		
	end if
END IF
//	GaryR		03/26/01		Stars 4.7 - End

// FNC 09/01/98 Start
if trim(gv_active_case) = '' OR Trim( gv_active_case ) = 'NONE' then
	lb_no_active_case = TRUE
end if
// FNC 09/01/98 End

Choose Case Istr_sub_opt.Come_From
		Case 'QUERY','REPSUB'
				Dw_Subset_Options.Setitem(1,'Job_Id', Trim(istr_sub_opt.job_id) ) //HRB 3/11/98	//ajs 5/11/98	// FDG 01/15/02
				if lb_no_active_case then									// FNC 09/01/98 Start
					dw_Subset_Options.Setitem(1,'link',0)
					dw_Subset_Options.Setitem(1,'Case_Id','NONE')
				else
					dw_Subset_Options.Setitem(1,'Case_Id',gv_active_case)
					dw_Subset_Options.Setitem(1,'link',1)
				end if															// FNC 09/01/98 End
				dw_Subset_Options.object.job_id.protect = 1
				dw_Subset_Options.object.sched_date.protect = 1
				dw_Subset_Options.object.priority.protect = 1
				IF istr_sub_opt.come_from = "QUERY" THEN
					dw_Subset_Options.Object.run_frequency.Color = 	stars_colors.input_text
				END IF
		Case 'PATTERN'
				Dw_Subset_Options.Setitem(1,'Job_Id',Trim(istr_sub_opt.patt_struc.job_id))		// FDG 01/15/02
				if lb_no_active_case then									// FNC 09/01/98 Start
					dw_Subset_Options.Setitem(1,'link',0)
					dw_Subset_Options.Setitem(1,'Case_Id','NONE')
				else
					dw_Subset_Options.Setitem(1,'Case_Id',gv_active_case)
					dw_Subset_Options.Setitem(1,'link',1)
				end if															// FNC 09/01/98 End
				Dw_Subset_Options.Setitem(1,'Sched',1)
				Dw_Subset_Options.object.job_id.protect = 1

				Dw_Subset_Options.SetItem(1,'sched_date',idt_default_sched_datetime)//NLG 5-18-98 use default date
		Case 'PATTSUB'
				Dw_Subset_Options.Setitem(1,'Job_Id',Trim(istr_sub_opt.patt_struc.job_id))		// FDG 01/15/02
				Dw_Subset_Options.Setitem(1,'Sched',1)
				Dw_Subset_Options.Setitem(1,'Sched_date', istr_sub_opt.pattern_sched_date)
				Dw_Subset_Options.Setitem(1,'Priority', istr_sub_opt.pattern_priority)
				if lb_no_active_case then
					Dw_Subset_Options.Setitem(1,'Link',0)
					Dw_Subset_Options.Setitem(1,'Case_Id','NONE')					
				else
					Dw_Subset_Options.Setitem(1,'Link',1)
					Dw_Subset_Options.Setitem(1,'Case_Id',gv_active_case)					
				end if
				istr_sub_opt.case_id = left(dw_subset_options.getitemstring( 1, "CASE_ID") ,10)
				istr_sub_opt.case_spl = mid(dw_subset_options.getitemstring(1,"CASE_ID"),11,2)
				istr_sub_opt.case_ver = mid(dw_subset_options.getitemstring(1,"CASE_ID"),13,2)
				Dw_Subset_Options.object.job_id.protect = 1
				Dw_Subset_Options.object.sched.protect = 1
				Dw_Subset_Options.object.sched_date.protect = 1
				Dw_Subset_Options.object.sched_date.Color = stars_colors.protected_text
				Dw_Subset_Options.object.priority.protect = 1	

		Case 'COPY','ARCHIVE'
				Dw_Subset_Options.Setitem(1,'User_Id',gc_user_id)
				if lb_no_active_case then									// FNC 09/01/98 Start
					dw_Subset_Options.Setitem(1,'link',0)
					dw_Subset_Options.Setitem(1,'Case_Id','NONE')
				else
					dw_Subset_Options.Setitem(1,'Case_Id',gv_active_case)
					dw_Subset_Options.Setitem(1,'link',1)
				end if															// FNC 09/01/98 End
				Dw_Subset_Options.object.job_id.protect = 1
				Dw_Subset_Options.object.sched.protect = 1
				Dw_Subset_Options.object.sched_date.protect = 1
				Dw_Subset_Options.object.priority.protect = 1	
		Case 'LINK'
				Dw_Subset_Options.Setitem(1,'User_Id',gc_user_id)
				if lb_no_active_case then									// FNC 09/01/98 Start
					dw_Subset_Options.Setitem(1,'link',0)
					dw_Subset_Options.Setitem(1,'Case_Id','NONE')
				else
					dw_Subset_Options.Setitem(1,'Case_Id',gv_active_case)
					dw_Subset_Options.Setitem(1,'link',1)
				end if															// FNC 09/01/98 End
				Dw_Subset_Options.SetItem(1,'Subc_Name',istr_sub_opt.subset_name)
				Dw_Subset_Options.object.subc_name.protect = 1
				Dw_Subset_Options.object.sched.protect = 1
				Dw_Subset_Options.object.sched_date.protect = 1
				Dw_Subset_Options.object.priority.protect = 1	
				Dw_Subset_Options.object.link.protect = 1
				dw_Subset_Options.Object.link.Color = 		 stars_colors.protected_text
End Choose

li_sched = Dw_Subset_Options.getitemnumber(1,'Sched')
if li_sched = 0  or Istr_sub_opt.Come_FROM = 'PATTSUB' then		//HRB 3/11/98
		dw_Subset_Options.Object.sched_date_t.Color = stars_colors.protected_text
		dw_Subset_Options.Object.priority_t.Color = 	 stars_colors.protected_text
		dw_Subset_Options.Object.job_id_t.Color =     stars_colors.protected_text
		dw_Subset_Options.Object.job_id.Color =     	stars_colors.protected_text
		dw_Subset_Options.Object.priority.Color = 	 stars_colors.protected_text
		//NLG 11-4-99 begin
		dw_Subset_Options.Object.recurs_after_t.Color = stars_colors.protected_text
		dw_Subset_Options.Object.run_frequency.Color = 	stars_colors.protected_text
		//NLG 11-4-99 end
else
		//show fields
		dw_Subset_Options.Object.sched_date_t.Color = stars_colors.label_text
		dw_Subset_Options.Object.priority_t.Color =   stars_colors.label_text
		dw_Subset_Options.Object.job_id_t.Color =     stars_colors.label_text
		dw_Subset_Options.Object.job_id.Color =       stars_colors.input_text
		dw_Subset_Options.Object.priority.Color = 	 stars_colors.label_text
		//NLG 11-4-99 begin
		dw_Subset_Options.Object.recurs_after_t.Color = stars_colors.label_text
		dw_Subset_Options.Object.run_frequency.Color = 	stars_colors.input_text
		//NLG 11-4-99 end
end if

//grey job if come from pattern because a step has already been written
if Istr_sub_opt.Come_FROM = 'PATTERN' then
	dw_Subset_Options.Object.job_id_t.Color =     stars_colors.protected_text
	dw_Subset_Options.Object.job_id.Color 	=      stars_colors.protected_text
	dw_Subset_Options.Object.recurs_after_t.Color = stars_colors.protected_text
	dw_Subset_Options.Object.run_frequency.Color = 	stars_colors.protected_text
end if


if li_sched = 0 then
		//If schedule immediately hide schedule date
		dw_Subset_Options.Object.sched_date.Color = 	&
		dw_Subset_Options.Object.sched_date.Background.Color
else
		//show schedule date
		IF istr_sub_opt.come_from <> "PATTSUB" THEN
			dw_Subset_Options.Object.sched_date.Color = 	 stars_colors.input_text
		END IF
end if

if Long(Dw_Subset_Options.object.sched.protect) = 1 then
		dw_Subset_Options.Object.sched.Color = 		 stars_colors.protected_text
else
		dw_Subset_Options.Object.sched.Color = 		 stars_colors.label_text
end if
		
if Istr_sub_opt.Come_From = 'QUERY' then
	ib_pattern_button = TRUE
else
	ib_pattern_button = FALSE
end if
Cb_pattern.enabled = FALSE
		
//First the next unique subset id must be obtained from the sys_cntl_table.
If trim(istr_sub_opt.subset_id) = '' or Istr_sub_opt.Come_From = 'COPY' then
	ls_subset_id = fx_get_next_key_id("SUBSET")
else
	//ajs 4.0 07-08-98 Track 1490
	ls_subset_id = istr_sub_opt.subset_id
end if

If ls_subset_id = 'ERROR' then
	messagebox('ERROR','Error getting next key id')
	Return -1
End IF

//NLG 6-4-98 If subset copy/link, must get originating subset's case id, subset name
//					then clear them out
If Istr_sub_opt.Come_From = 'COPY' or Istr_sub_opt.Come_From = 'LINK' then
	is_orig_subset_name = istr_sub_opt.subset_name
	is_orig_subset_case_id = istr_sub_opt.case_id
	istr_sub_opt.subset_name = ''
	istr_sub_opt.case_id = ''
	istr_sub_opt.case_spl = ''
	istr_sub_opt.case_ver = ''
End IF

//Use the new subset id for all cases except copy; it needs to use
//the old subset id to create a link instead of a true copy
If Istr_sub_opt.Come_From <> 'COPY' then
	gv_subset_id = ls_subset_id
	istr_sub_opt.subset_id = ls_subset_id
End IF

//The subset name field is checked to determine if a subset name was passed in. 
//If the subset name was passed it is defaulted to the subset id.
//the new subset id for copy
ls_name = dw_subset_options.getitemstring(1,'subc_name')
If ls_name = '' or IsNull(ls_name) then
	istr_sub_opt.subset_name = ls_subset_id
	dw_subset_options.Setitem(1,'subc_name', ls_subset_id)
Else
	Istr_sub_opt.subset_name = ls_name
End if

//Get Case description				
//ajs 07-17-98 4.0 Track #1479
dw_Subset_Options.Object.Case_id.BackGround.Color = stars_colors.lookup_back
ls_case_id  = Dw_Subset_Options.Object.Case_Id[1]
if trim(ls_case_id) <> '' then				// FNC 09/01/98
	wf_retrieve_case_desc(ls_case_id)
end if												// FNC 09/01/98
//ajs 07-17-98 4.0 Track #1479 end

inv_subset_functions = Create nvo_subset_functions		
//inv_temp_table = Create n_cst_temp_table			// FDG 03/05/98
This.of_set_temp_table (TRUE)								// FDG 03/05/98

cb_ok.default = true

if isvalid(dw_Subset_Options) then
	dw_Subset_Options.SetFocus()
	dw_Subset_options.SetColumn('subc_name')
End If

//NLG 11-4-99 ts2463c.
ii_run_frequency = istr_sub_opt.run_frequency

//	GaryR		03/26/01		Stars 4.7 - Begin
IF istr_sub_opt.come_from <> 'PATTSUB' THEN
	IF ii_run_frequency = 1 THEN
		ii_run_frequency = 4
	ELSEIF ii_run_frequency = 3 THEN
		ii_run_frequency = 7
	ELSEIF ii_run_frequency = 6 THEN
		ii_run_frequency = 8
	ELSEIF ii_run_frequency = 12 THEN
		ii_run_frequency = 9
	END IF
END IF
//	GaryR		03/26/01		Stars 4.7 - End	

//move the run frequency to the datawindow
dw_subset_options.object.run_frequency[1] = ii_run_frequency
IF ii_run_frequency > 0 THEN
	//job is to be scheduled
	dw_subset_options.object.sched[1] = 1
	dw_subset_options.object.sched.protect = 1
	dw_subset_options.object.sched.Color = stars_colors.protected_text
	//disable the run_frequency column
	// FDG 03/27/00.  Protect/unprotect cb_pattern based on column 'sched'
	This.Event	ue_sched_change (1)
	// Set the schedule date to the payment_date's end date plus 1 day & protect it.
	// Must be performed after ue_sched_change(1)
	this.event ue_compute_schedule_date()
	dw_subset_options.object.sched_date.protect = 1
	//	GaryR		06/20/01		Stars 4.7 - Begin
	dw_subset_options.object.sched_date.Color = stars_colors.protected_text
	dw_subset_options.object.sched_date_t.Color = stars_colors.protected_text

	dw_subset_options.object.run_frequency.protect = 1
	dw_subset_options.object.run_frequency.Color = stars_colors.protected_text
	dw_subset_options.object.recurs_after_t.Color = stars_colors.protected_text
ELSE
	//	GaryR		08/21/01		Track 2407d - Begin
	// Do not default the scheduler to run now.
	CHOOSE CASE Istr_sub_opt.Come_From
		CASE 'QUERY','REPSUB'
			dw_Subset_Options.Setitem(1,'Sched',1)
			THIS.EVENT ue_sched_change( 1 )
		CASE ELSE
			//Protect run_frequency b/c Sched defaults to Immediate
			dw_subset_options.object.run_frequency.protect = 1
	END CHOOSE
	//	GaryR		08/21/01		Track 2407d - End	
END IF
end event

event close;call super::close;// FDG 04/14/00 - Track 2147d.  Remove any possibility of memory leaks.

IF	IsValid (inv_subset_functions)	THEN
	DESTROY inv_subset_functions
END IF
end event

event ue_presave;call super::ue_presave;/////////////////////////////////////////////////////////////////////////
//
// 04/30/01	GaryR	Stars 4.7 - Duplicate rows inserted into bg_step_cntl.
//
/////////////////////////////////////////////////////////////////////////

IF String( il_job_id ) <> is_job_id THEN
	IF gnv_server.of_JobUpdateDesc( il_job_id, is_job_id ) < 0 THEN Return -1
END IF

RETURN AncestorReturnValue
end event

type dw_bg_step_cntl from u_dw within w_subset_options
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 46
integer y = 1236
integer width = 78
integer height = 88
integer taborder = 0
string dataobject = "d_bg_step_cntl"
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
end event

type dw_bg_sql_line from u_dw within w_subset_options
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 123
integer y = 1236
integer width = 78
integer height = 88
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_bg_sql_line"
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
end event

type dw_sub_opt_case_link from u_dw within w_subset_options
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 434
integer y = 1236
integer width = 78
integer height = 88
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_sub_opt_case_link"
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 

//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

type dw_criteria_used from u_dw within w_subset_options
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 357
integer y = 1236
integer width = 78
integer height = 88
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_criteria_used"
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
end event

type dw_criteria_from_tbls_used from u_dw within w_subset_options
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 279
integer y = 1236
integer width = 78
integer height = 88
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_criteria_from_tbls_used"
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 
end event

type dw_criteria_used_line from u_dw within w_subset_options
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 201
integer y = 1236
integer width = 78
integer height = 88
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_criteria_used_line"
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca) 

//	12/12/01	FDG	Track 2527d.  Prevent Oracle from inserting empty string.
This.of_SetTrim(TRUE)

end event

type cb_ok from u_cb within w_subset_options
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 773
integer y = 1256
integer height = 108
integer taborder = 20
boolean bringtotop = true
string text = "OK"
boolean default = true
end type

event clicked;//History:
// 07-10-98 NLG	Track#1424-Give warning if user changes case id after pattern step 
//						has been written to bg_step_cntl
//	06-04-98	NLG 	If copy/linking independent subsets, check for attached notes Track#1155
//	03/22/01	GaryR	Stars 4.7 - Eliminate Obsolete functionality (Job Restart)
//	03/26/01	GaryR	Stars 4.7 - Implement Stars Server Functionality
//	03/15/02	GaryR	Track 2902d	Lookup on empty case freezes STARS
//	11/26/02	GaryR	Track 3275d	Validate that dependants are in sync
//	02/14/05	GaryR	Track 4287d	Add logic for new subset background patterns missed with 5651c
//										Also trim case values for Oracle
//
//----------------------------------------------------------------------------------
integer li_rc
String ls_case_id, ls_case_spl, ls_case_ver

//	03/15/02	GaryR	Track 2902d
IF dw_subset_options.AcceptText() < 0 THEN Return

//	03/22/01	GaryR	Stars 4.7
If Parent.Event ue_general_edits() <> 0 then
	Istr_sub_opt.status = 'ERROR'
	setmicrohelp(w_main,'Error processing request. Request cancelled')
	Return 
End if

CHOOSE CASE istr_sub_opt.come_from
	CASE 'PATTERN','PATTSUB'
			ls_case_id = dw_subset_options.getitemstring( dw_subset_options.getrow(), "case_id")
			ls_case_spl = Trim( mid(ls_case_id, 11,2) )
			ls_case_ver = Trim( mid(ls_case_id, 13, 2) )
			ls_case_id = Trim( left(ls_case_id, 10) )
			gnv_sql.of_trimdata( ls_case_spl )
			gnv_sql.of_trimdata( ls_case_ver )
			w_sampling_analysis_new.ids_bg_step_cntl.SetItem (1,'case_id',ls_case_id )
			w_sampling_analysis_new.ids_bg_step_cntl.SetItem (1,'case_spl',ls_case_spl)
			w_sampling_analysis_new.ids_bg_step_cntl.SetItem (1,'case_ver',ls_case_ver)
			
			IF w_sampling_analysis_new.ids_bg_step_cntl.EVENT ue_update( TRUE, TRUE ) <> 1 THEN
				MessageBox ('ERROR', 'Could not Update case id on pattern.~r'	+	&
								'Error updating bg_step_cntl')
				Stars2ca.of_rollback()
				istr_sub_opt.status = 'ERROR'
				GOTO CLEANUP
			END IF
			
			IF w_sampling_analysis_new.ids_bg_sql_line.EVENT ue_update( TRUE, TRUE ) <> 1 THEN
				MessageBox ('ERROR', 'Pattern could not be scheduled.~r'	+	&
								'Error updating bg_sql_line')
				Stars2ca.of_rollback()
				istr_sub_opt.status = 'ERROR'
				GOTO CLEANUP
			END IF
			
			IF istr_sub_opt.come_from = "PATTSUB" THEN
				//	Bump up the step count
				istr_sub_opt.patt_struc.total_steps++
			ELSE
				istr_sub_opt.patt_struc.total_steps = 1
			END IF
END CHOOSE

Choose Case istr_sub_opt.come_from
	Case 'ARCHIVE'
			Li_rc = Parent.Event ue_insert_case_link('P')
	Case 'COPY','LINK'
			Li_rc = Parent.Event ue_insert_case_link('A')
	Case 'QUERY','PATTERN','PATTSUB','REPSUB'
		//	11/26/02	GaryR	SPR 3275d
		IF Parent.Event ue_ValidateClaimsRange() = 2 THEN
			istr_sub_opt.status = 'ERROR'
			w_main.SetMicroHelp( 'Error processing request. Request cancelled' )
			Return 
		END IF
		Li_rc = Parent.Event ue_insert_case_link('P')
		if li_rc = 0 then
				Li_rc = Parent.Event ue_Write_Subset_Request()
		else
				Istr_sub_opt.status = 'ERROR'
				setmicrohelp(w_main,'Error can not insert into case link table. Request cancelled')
				return
		end if
END CHOOSE

If li_rc = 0 then
		li_rc = Parent.Event ue_save()//Saves datawindows
elseif li_rc = 100 then			//invalid schedule date
		return 
else
		Istr_sub_opt.status = 'ERROR'
		setmicrohelp(w_main,'Error processing request. Request cancelled')
		return
End If

Choose Case istr_sub_opt.come_from
		Case 'QUERY','PATTERN','PATTSUB','REPSUB'//,'RESTART'	//	03/22/01	GaryR	Stars 4.7
				If li_rc = 1 then
						li_rc = Parent.Event ue_call_rpc_create_subset()
						If li_rc < 0 then
								Istr_sub_opt.status = 'ERROR'
						Else
								Istr_sub_opt.status = 'COMPLETE'
						End if
				else	
						Istr_sub_opt.status = 'ERROR'
						setmicrohelp(w_main,'Error processing request. Can not save tables. Request cancelled')
						Return 
				End if
		Case 'ARCHIVE','COPY','LINK'
				If li_rc = 1 then
						//NLG 6-4-98 check independent subsets for attached notes
						if is_orig_subset_case_id = 'NONE' then
							Parent.event ue_copy_notes()
						end if
						Istr_sub_opt.status = 'COMPLETE'
						setmicrohelp(w_main,'Request processed successfully.')
				else
						Istr_sub_opt.status = 'ERROR'
						setmicrohelp(w_main,'Error processing request. Can not save tables. Request cancelled')
				End if
End Choose

//	03/26/01	GaryR	Stars 4.7
istr_sub_opt.job_sched = 0
IF istr_sub_opt.status = 'ERROR' THEN gnv_server.of_JobDelete( il_job_id )

CLEANUP:
CloseWithReturn(Parent,istr_sub_opt)
end event

type cb_pattern from u_cb within w_subset_options
string accessiblename = "Pattern"
string accessibledescription = "Pattern..."
integer x = 1161
integer y = 1256
integer height = 108
integer taborder = 30
boolean bringtotop = true
string text = "Pattern..."
end type

event clicked;//*************************************************************************************
// cb_pattern                                                                        *
//*************************************************************************************
// 04-14-98 AJS	4.0 Correct reset of subset id for 2nd pattern step                  *
//             	Do not call rpc until pattern step is complete   
// 04-05-99 FNC	FS/TS2151C Starcare track 2151. Reset fast track invoice to main
//						invoice type before patterns window is opened since the 
//						pattern drop downs are based on main invoice type.
//	03-27-00	FDG	Track 2160.  Pass run frequency and perform an AcceptText
//	06-02-00	FDG	Track 2309.  If the case is 'NONE', Patterns uses the active case.
//						If this happens, edit the active case.
//	03/26/01	GaryR	Stars 4.7 - Implement Stars Server Functionality
//	11/26/02	GaryR	SPR 3275d	Validate that dependants are in sync
//*************************************************************************************
integer li_rc, li_step, li_max_step, li_table_type_index
integer li_nbr_tables,li_tbl
boolean lb_revenue_nvo_created
n_cst_revenue lnvo_revenue
string ls_case_id

// FDG 03/27/00 - Perform an accepttext first.
li_rc	=	dw_subset_options.AcceptText()

IF	li_rc	<	0		THEN
	Return
END IF
// FDG 03/27/00 End


ls_case_id = left(dw_subset_options.getitemstring(1,'case_id'),10) + &
				 mid(dw_subset_options.getitemstring(1,'case_id'),11,2) +&
				 mid(dw_subset_options.getitemstring(1,'case_id'),13,2)

//If istr_sub_opt.come_from = 'QUERY' then
//		if left(dw_subset_options.getitemstring(1,'case_id'),4) = 'NONE' then
//				li_rc = messagebox('WARNING','The pattern report you will be creating will be saved to the active case. ~r'+&
//													  'Do you still want this input subset to be independent? ~r'+&
//													  'Click Yes to continue. Click No to change the link option ~r'+&
//													  'for the input subset that will be used as the source for the pattern report' ,Question!, YesNo!)
//
//				If li_rc = 2 then 
//						return
//				end if
//				// FDG 06/02/00	Begin
//				li_rc		=	Parent.Event	ue_verify_active_case()
//				IF	li_rc	<	0		THEN
//					Return
//				END IF
//				//	FDG 06/02/00	End
//		elseif left(dw_subset_options.getitemstring(1,'case_id'),4) = 'NONE' then
//				li_rc = messagebox('WARNING','The pattern report you will be creating will be saved to the active case. ~r'+&
//													  'The case id entered for this subset is different than the active case id.  ~r'+&
//													  'Do you still want this input subset to be linked to the case id entered?~r'+&
//													  'Click Yes to continue. Click No to change the link option ~r'+&
//													  'for the input subset that will be used as the source for the pattern report' ,Question!, YesNo!)
//
//				If li_rc = 2 then 
//						return
//				end if
//				// FDG 06/02/00	Begin
//				li_rc		=	Parent.Event	ue_verify_active_case()
//				IF	li_rc	<	0		THEN
//					Return
//				END IF
//				//	FDG 06/02/00	End
//		end if
//end if

If Parent.Event ue_general_edits() <> 0 then
	Istr_sub_opt.status = 'ERROR'
	setmicrohelp(w_main,'Error processing request. Request cancelled')
	Return 
End if

Li_rc = Parent.Event ue_insert_case_link('P')

If li_rc = 0 then
		Li_rc = Parent.Event ue_Write_Subset_Request()
else
		Istr_sub_opt.status = 'ERROR'
		setmicrohelp(w_main,'Error can not insert into case link table. Request cancelled')
		return
End if

If li_rc = 0 then
		li_rc = Parent.Event ue_save()//Saves datawindows
elseif li_rc = 100 then			//invalid schedule date
		return 
else
		Istr_sub_opt.status = 'ERROR'
		setmicrohelp(w_main,'Error processing request. Request cancelled')
		return
End If

//Do not RPC until the pattern step is complete//
If li_rc = 1 then
//		li_rc = Parent.Event ue_call_rpc_create_subset()
//		If li_rc < 0 then
//				Istr_sub_opt.status = 'ERROR'
//				setmicrohelp(w_main,'Error processing rpc request. Request cancelled')
//		Else
//				Istr_sub_opt.status = 'COMPLETE'
//				setmicrohelp(w_main,'Request processed successfully.')
//		End if
else	
		Istr_sub_opt.status = 'ERROR'
		setmicrohelp(w_main,'Error processing request. Can not save tables. Request cancelled')
		Return 
End if


istr_sub_opt.patt_struc.come_from = 'SUB_OPT'
istr_sub_opt.patt_struc.job_id = is_job_id
istr_sub_opt.patt_struc.subset_id = istr_sub_opt.subset_id	//ajs 4.0 03-02-98
istr_sub_opt.subset_id = '' //ajs 4.0 04-14-98
istr_sub_opt.patt_struc.case_id = istr_sub_opt.case_id + istr_sub_opt.case_spl + istr_sub_opt.case_ver	//ajs 4.0 03-02-98
istr_sub_opt.patt_struc.total_steps = ii_total_steps
istr_sub_opt.patt_struc.subset_table_type = istr_sub_opt.sub_info[1].subset_step[1].subset_type	//ajs 4.0 04-16-98
istr_sub_opt.pattern_case = istr_sub_opt.case_id + istr_sub_opt.case_spl + istr_sub_opt.case_ver
istr_sub_opt.pattern_case_link = dw_subset_options.GetitemNumber(1,'link')
istr_sub_opt.pattern_priority = dw_subset_options.GetitemNumber (1,'priority')
istr_sub_opt.pattern_sched_date = dw_subset_options.GetitemDatetime(1,'sched_date')

//Track#2034 use a local structure instead of using the instance variable
sx_subset_options lstr_sub_opt
lstr_sub_opt.come_from = istr_sub_opt.come_from 
lstr_sub_opt.status = istr_sub_opt.status
lstr_sub_opt.job_id = is_job_id
lstr_sub_opt.server_job_id = il_job_id		//	03/26/01	GaryR	Stars 4.7
lstr_sub_opt.subset_name = istr_sub_opt.subset_name
lstr_sub_opt.subset_id = istr_sub_opt.subset_id
lstr_sub_opt.case_id = istr_sub_opt.case_id
lstr_sub_opt.case_spl = istr_sub_opt.case_spl
lstr_sub_opt.case_ver = istr_sub_opt.case_ver
lstr_sub_opt.pattern_case_link = istr_sub_opt.pattern_case_link
lstr_sub_opt.pattern_priority = istr_sub_opt.pattern_priority
lstr_sub_opt.pattern_sched_date = istr_sub_opt.pattern_sched_date
lstr_sub_opt.patt_struc.come_from = 'SUB_OPT'
lstr_sub_opt.patt_struc.job_id = is_job_id
lstr_sub_opt.patt_struc.subset_id = istr_sub_opt.patt_struc.subset_id	
lstr_sub_opt.subset_id = '' 
lstr_sub_opt.patt_struc.case_id = istr_sub_opt.case_id + istr_sub_opt.case_spl + istr_sub_opt.case_ver
lstr_sub_opt.patt_struc.total_steps = ii_total_steps
lstr_sub_opt.patt_struc.subset_table_type = istr_sub_opt.sub_info[1].subset_step[1].subset_type
lstr_sub_opt.pattern_case = istr_sub_opt.case_id + istr_sub_opt.case_spl + istr_sub_opt.case_ver
lstr_sub_opt.pattern_case_link = dw_subset_options.GetitemNumber(1,'link')
lstr_sub_opt.pattern_priority = dw_subset_options.GetitemNumber (1,'priority')
lstr_sub_opt.pattern_sched_date = dw_subset_options.GetitemDatetime(1,'sched_date')
lstr_sub_opt.run_frequency = ii_run_frequency					// FDG 03/27/00

//	11/26/02	GaryR	SPR 3275d
//	Copy subset info for background patterns
lstr_sub_opt.sub_info_copy = istr_sub_opt.sub_info

//ajs 4.0 03-02-98
li_table_type_index = 0
if lstr_sub_opt.patt_struc.subset_table_type = 'ML' then	//ts2040d
	For ii_level = 1 to ii_max_level
			li_max_step = upperbound(istr_sub_opt.sub_info[1].subset_step)
			for li_step = 1 to li_max_step
				li_table_type_index++
				//istr_sub_opt.patt_struc.table_type[li_table_type_index] = istr_sub_opt.sub_info[ii_level].subset_step[li_step].Inv_type
				lstr_sub_opt.patt_struc.table_type[li_table_type_index] = istr_sub_opt.sub_info[ii_level].subset_step[li_step].Inv_type
			next
	Next
	//ajs 4.0 end
else																		//ts2040d
	lstr_sub_opt.patt_struc.table_type[1] = lstr_sub_opt.patt_struc.subset_table_type//ts2040d
end if																	//ts2040d

// FNC 04/05/99 Start
Li_nbr_tables = upperbound(lstr_sub_opt.patt_struc.table_type)

For li_tbl = 1 to li_nbr_tables
	if left(upper(lstr_sub_opt.patt_struc.table_type[li_tbl]),1) = 'Q' then
		if not lb_revenue_nvo_created then
			lnvo_revenue = create n_cst_revenue
			lb_revenue_nvo_created = TRUE
		end if
		lstr_sub_opt.patt_struc.table_type[li_tbl] = &
			lnvo_revenue.of_get_main_table(lstr_sub_opt.patt_struc.table_type[li_tbl])
	end if
Next

If lb_revenue_nvo_created then
	Destroy(lnvo_revenue)
End if
// FNC 04/05/99 End

//	03/26/01	GaryR	Stars 4.7
lstr_sub_opt.job_sched = 1

OpenSheetwithParm(w_sampling_analysis_new,lstr_sub_opt,mdi_main_frame, help_menu_position,Layered!)


//close(parent)							//NLG Track #1669
closewithreturn(parent,istr_sub_opt)//NLG track #1669


end event

type cb_cancel from u_cb within w_subset_options
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 1655
integer y = 1256
integer height = 108
integer taborder = 40
boolean bringtotop = true
string text = "Cancel"
end type

event clicked;////////////////////////////////////////////////////////////////////
//
//	03/23/01	GaryR	Stars 4.7 - Implement Stars Server Functionality
//	10/31/02	GaryR	SPR 3266d	Do not delete job from here if PATTSUB
//										That logic will be hadled in the close
//										event of the pattern window
//
////////////////////////////////////////////////////////////////////

ib_disableclosequery = TRUE
Istr_sub_opt.status = 'CANCEL'
setmicrohelp(w_main,'Request cancelled')

//	10/31/02	GaryR	SPR 3266d
IF istr_sub_opt.come_from <> "PATTSUB" THEN
	//	03/23/01	GaryR	Stars 4.7
	IF il_job_id > 0 THEN	gnv_server.of_JobDelete( il_job_id )
END IF

CloseWithReturn(Parent,istr_sub_opt)
end event

type dw_subset_options from u_dw within w_subset_options
string accessiblename = "Subset Options"
string accessibledescription = "Subset Options"
integer width = 2011
integer height = 1216
integer taborder = 10
string dataobject = "d_subset_options"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;///////////////////////////////////////////////////////////////////////////
// 09/01/98		FNC		Track 1639. Determine if case id is valid
// 10/29/98		FNC		Track 1772. If case is not valid clear out case id
//								and case description fields.
//	11/3/99		NLG		Ts2463c. Post ue_sched_change when column sched changes.
//	03/27/00		FDG		Track 2160d.  Trigger instead of post events.
//	04/25/03		GaryR		Track 3464d	Validate the recurrence schedule of source subset
// 10/06/04    JasonS   Track 5651c - allow case id of none for pattsub
/////////////////////////////////////////////////////////////////////////////////

boolean lb_change_case
integer li_schedule, li_case_link, li_priority
integer li_return
datetime null_datetime
string ls_case_id, ls_case_spl, ls_case_ver, ls_case_desc, ls_entire_case_id

If  this.getcolumnname() = 'sched' then
	li_schedule = Integer(data)
	Parent.Event ue_sched_change(li_schedule)		// FDG 03/27/00 - Trigger instead of post
End if

//NLG 04-18-00 Move this to editChanged() so that user
//will see date change as soon as it occurs
////NLG 11-4-99 ts2436c. Set ii_run_frequency if run_frequency column changed
IF this.getcolumnname() = 'run_frequency' THEN
	ii_run_frequency = Integer(data)
	//recompute the schedule date
	Parent.Event ue_compute_schedule_date()
END IF

If  this.getcolumnname() = 'priority' then
	li_priority = Integer(data)
	if li_priority = 2 then
		setitem(1,'priority',2)
	Else
		setitem(1,'priority',5)
	end if
End if

// FNC 09/01/98 Start
If  this.getcolumnname() = 'case_id' then
	ls_case_id = Trim(data)
	if trim(ls_case_id) <> 'NONE' then
		li_return = parent.event ue_verify_case_id(ls_case_id)
		if li_return <> 0 then 
			dw_Subset_Options.Object.case_id[1] = '' 				// FNC 10/29/98 
			dw_Subset_Options.Object.case_desc[1] = '' 			// FNC 10/29/98 
			return 2
		end if
	end if
end if																	
// FNC 09/01/98 End

lb_change_case = false

If this.getcolumnname() = 'link' then
	li_case_link = Integer(data)
	if li_case_link = 0 then
		setitem(1,'Case_Id','NONE')
		lb_change_case = true
	else
		setitem(1,'Case_Id',gv_active_case)
	end if
	lb_change_case = true
end if


//Get Case description				
//ajs 07-17-98 4.0 Track #1479

If  this.getcolumnname() = 'case_id' or lb_change_case then
	If lb_change_case then
		ls_entire_case_id = Dw_Subset_Options.Object.Case_ID[1]
	Else
		ls_entire_case_id  = string(data)
	End If
	if trim(ls_entire_case_id) <> '' then					// FNC 09/01/98
		wf_retrieve_case_desc(ls_entire_case_id)
	end if															// FNC 09/01/98
End If
//ajs 07-17-98 4.0 Track #1479 end
end event

event constructor;call super::constructor;This.of_setupdateable(false)

end event

event losefocus;call super::losefocus;//	03/15/02	GaryR	Track 2902d	Lookup on empty case freezes STARS
//dw_subset_options.accepttext()
end event

event ue_lookup;call super::ue_lookup;/////////////////////////////////////////////////////////////////////////////
// Object							Event/Function		Access	
// ------							--------------		------	
//	dw_subset_options				ue_lookup			Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Lookup the case id.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
// A.Sola			04/24/98			Created.
//	GaryR				03/05/03			Track 3464d	Clean up the enabling/disabling of options
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

// make sure only the case id provides lookup
IF Lower(as_col) = 'case_id' THEN
	// Do not process if protected
	IF dw_subset_options.object.case_id.protect = "1" THEN Return
	gv_from = 'AC'	/* 'message' w_case_list to enable the use commandbutton, 
						   and retrieve the case list. */
	Open(w_case_list_response)
	dw_subset_options.object.case_id[1] = gv_active_case	// get 'message' case id
	wf_retrieve_case_desc(gv_active_case)
END IF
end event

