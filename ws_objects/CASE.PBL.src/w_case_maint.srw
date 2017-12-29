$PBExportHeader$w_case_maint.srw
$PBExportComments$Case Maintenance
forward
global type w_case_maint from w_master
end type
type cb_track from u_cb within w_case_maint
end type
type cb_retrieve from u_cb within w_case_maint
end type
type cb_update from u_cb within w_case_maint
end type
type cb_create from u_cb within w_case_maint
end type
type cb_delete from u_cb within w_case_maint
end type
type cb_clear from u_cb within w_case_maint
end type
type cb_more from u_cb within w_case_maint
end type
type cb_close from u_cb within w_case_maint
end type
type cb_next from u_cb within w_case_maint
end type
type cb_prev from u_cb within w_case_maint
end type
type tab_case from tab within w_case_maint
end type
type tabpage_general from userobject within tab_case
end type
type uo_general from uo_tabpage_rmm within tabpage_general
end type
type dw_general from u_dw within tabpage_general
end type
type tabpage_general from userobject within tab_case
uo_general uo_general
dw_general dw_general
end type
type tabpage_current from userobject within tab_case
end type
type uo_current from uo_tabpage_rmm within tabpage_current
end type
type dw_current from u_dw within tabpage_current
end type
type tabpage_current from userobject within tab_case
uo_current uo_current
dw_current dw_current
end type
type tabpage_savings from userobject within tab_case
end type
type uo_savings from uo_tabpage_rmm within tabpage_savings
end type
type st_savings from statictext within tabpage_savings
end type
type dw_savings from u_dw within tabpage_savings
end type
type tabpage_savings from userobject within tab_case
uo_savings uo_savings
st_savings st_savings
dw_savings dw_savings
end type
type tabpage_pimr from userobject within tab_case
end type
type uo_1 from uo_tabpage_rmm within tabpage_pimr
end type
type dw_pimr from u_dw within tabpage_pimr
end type
type tabpage_pimr from userobject within tab_case
uo_1 uo_1
dw_pimr dw_pimr
end type
type tabpage_log from userobject within tab_case
end type
type dw_log from u_dw within tabpage_log
end type
type uo_log from uo_tabpage_rmm within tabpage_log
end type
type dw_display_log from u_dw within tabpage_log
end type
type st_count from statictext within tabpage_log
end type
type tabpage_log from userobject within tab_case
dw_log dw_log
uo_log uo_log
dw_display_log dw_display_log
st_count st_count
end type
type tabpage_track from userobject within tab_case
end type
type uo_track from uo_tabpage_rmm within tabpage_track
end type
type dw_track from u_dw within tabpage_track
end type
type st_track_count from statictext within tabpage_track
end type
type tabpage_track from userobject within tab_case
uo_track uo_track
dw_track dw_track
st_track_count st_track_count
end type
type tab_case from tab within w_case_maint
tabpage_general tabpage_general
tabpage_current tabpage_current
tabpage_savings tabpage_savings
tabpage_pimr tabpage_pimr
tabpage_log tabpage_log
tabpage_track tabpage_track
end type
type p_notes from u_pb within w_case_maint
end type
type dw_headings from u_dw within w_case_maint
end type
type cb_next_current from u_cb within w_case_maint
end type
type cb_close_current from u_cb within w_case_maint
end type
type cb_prev_current from u_cb within w_case_maint
end type
type cb_select_track from u_cb within w_case_maint
end type
end forward

global type w_case_maint from w_master
boolean visible = false
string accessiblename = "Case Details"
string accessibledescription = "Case Details"
integer width = 3648
integer height = 2364
string title = "Case Details"
boolean ib_popup_menu = true
event ue_retrieve_log ( )
event ue_retrieve_track ( )
event type integer ue_check_bg_step_cntl_case_id ( )
event type integer ue_delete_anal_criteria ( )
event type integer ue_delete_pdqs ( )
event type integer ue_delete_reports ( string as_link_type )
event type integer ue_delete_subsets ( )
event type integer ue_delete_targets_tracks ( )
event ue_get_track_type ( )
event ue_clear_case ( )
event ue_open_track_maint ( )
event ue_test ( )
event type integer ue_edit_assigned_date ( datetime adte_asgn_date )
event type integer ue_edit_receipt_date ( string as_come_from )
event type integer ue_edits ( long al_row,  dwobject ad_dwo,  string as_data )
event type integer ue_edit_case ( )
event type integer ue_edit_period_dates ( )
event type integer ue_open_case_folder ( )
event ue_scroll_tab ( tab at_tab,  integer ai_scroll_value )
event ue_delete_case ( )
event ue_reset_dates ( )
event ue_post_activate ( )
event ue_tracking ( )
event ue_refer_case ( )
event ue_copy_case ( )
event ue_initialize_case ( )
event ue_more ( )
event type integer ue_set_menu_more ( boolean ab_state )
event type integer ue_set_menu_refer ( boolean ab_state )
event type integer ue_set_menu_track ( boolean ab_state )
event type integer ue_set_menu_update ( boolean ab_state )
event type integer ue_set_menu_create ( boolean ab_state )
event ue_close ( )
event ue_postclose ( )
event ue_set_window_title ( )
event ue_notes ( )
event type integer ue_edit_pimr ( )
event ue_display_help_buttons ( )
event ue_display_ready_cd ( )
event ue_enable_ready_for_pimr ( boolean ab_switch )
event ue_reassign_case ( )
event type integer ue_edit_case_log ( )
event ue_enable_update ( boolean ab_switch )
event type boolean ue_edit_enable_update ( )
event ue_set_instance ( )
event type string ue_edit_case_log_pimr ( long al_row_log )
event ue_filter_userid ( string as_dept_id )
event ue_window_operation ( string as_operation )
event ue_create_pimr_file ( )
event ue_get_dw_syntax ( )
event ue_re_retrieve_log ( )
event ue_refresh_case ( )
event ue_populate_headings ( )
event ue_enable_details ( boolean ab_switch )
event ue_set_update_availability ( )
event ue_enable_financials ( boolean ab_switch )
cb_track cb_track
cb_retrieve cb_retrieve
cb_update cb_update
cb_create cb_create
cb_delete cb_delete
cb_clear cb_clear
cb_more cb_more
cb_close cb_close
cb_next cb_next
cb_prev cb_prev
tab_case tab_case
p_notes p_notes
dw_headings dw_headings
cb_next_current cb_next_current
cb_close_current cb_close_current
cb_prev_current cb_prev_current
cb_select_track cb_select_track
end type
global w_case_maint w_case_maint

type variables
// active case

boolean in_track_exists
boolean sv_referEnabled
boolean in_bad_retrieve
boolean ib_close

date in_case_status_date
datetime idt_assign_datetime
datetime idt_current_datetime
datetime idt_receipt_date
datetime idt_create_date

datawindowchild idwc_case_disp
datawindowchild idwc_case_status
datawindowchild idwc_case_business

// FDG 01/20/01 - PIMR
datawindowchild idwc_custom1_cd
datawindowchild idwc_custom2_cd
datawindowchild idwc_custom3_cd
datawindowchild idwc_custom4_cd
datawindowchild idwc_custom5_cd


int ii_tp_general  = 1
int ii_tp_current  = 2
int ii_tp_savings = 3
int ii_tp_pimr      = 4   // FDG 01/14/01
int ii_tp_log        = 5  // FDG 01/14/01
int ii_tp_track     = 6  // FDG 01/14/01

Boolean	ib_use_pimr	// FDG 01/14/01
Boolean	ib_open_track	// FDG 01/14/01
Boolean	ib_reassign		//	09/05/01	GaryR

String	is_prev_save_msg	// FDG 01/14/01

n_ds	ids_win_parm	// FDG 01/14/01

m_case_general im_general
m_case_current im_current
m_case_savings im_savings
m_case_pimr im_pimr	// FDG 01/14/01
m_case_log im_log
m_case_track im_track

n_cst_case inv_case
n_cst_case inv_log

String is_active_case
string in_case_cat
string in_case_refer_to
string in_case_status
string in_case_disposition
string in_case_status_user
string in_case_status_desc
string in_case_id
string in_case_spl
string in_case_ver
string iv_track_type
string iv_bus_dflt
string in_from
string is_title
String is_asgn_to, is_reasgn_to	// 09/05/01 GaryR

boolean	ib_refer		// FDG 09/13/01 - Stars 4.8.1


n_ds ids_code     // SAH 01/07/02

// SAH 03/20/02 Window Operations
Boolean ib_selected
String is_dw_cntl
sx_decode_structure istr_decode



end variables

forward prototypes
public subroutine wf_contact ()
public subroutine wf_folder ()
public subroutine wf_notes ()
public function string wf_remove_colon (string as_text)
public function integer wf_close_track_lead (boolean in_dupe_close)
public subroutine wf_add_datawindow_title (string as_title, ref datawindow adw, string as_hdr_hgt, string as_title_x_pos, string as_title_align, string as_title_width)
public subroutine of_set_is_operation (string as_operation)
public function integer wf_validate_case_id (string arg_case_id)
public function string wf_display_help_button (ref u_dw adw, string as_column)
public subroutine wf_target ()
public subroutine of_update_last_update_header ()
end prototypes

event ue_retrieve_log();///////////////////////////////////////////////////////////////////////////
//	Event:	ue_retrieve_log
//
//	Description:
//				Retrieve the log data for this case.
//
////////////////////////////////////////////////////////////////////////////
//	History:
//
//
//	4-25-00	NLG		Track #2232 If no logs, disable cb_next on tab current
//	01/21/01	FDG		Stars 4.6 - PIMR.  The PIMR tab is now before the Log tab.
//	10/03/01	FDG		Stars 4.8.1.	Hide any zero or 1/1/1900 data values.
// 02/25/02 SAH		Track #2437  Dynamic Case Log-Map d_case_log col sequence to DICTIONARY
// 04/02/02 MikeFl	Track #2741  Change SQL to put code descriptions on the report data window
// 05/23/02 SAH      Stars 5.1	 Select error with Oracle 
// 06/12/02	JasonS	Track 3082d - Code/Decode is not working properly on the Case Log Screen
// 06/14/02	JasonS	Track 3082d		Changed sql select build to use new ue in n_cst_dict
// 06/27/02 JasonS	Track 3009d		Moved a block of code down to bottom to fix datetime issue
// 07/24/02 JasonS	Track 3190d    Display disposition code - disposition description in case log
// 09/26/02 JasonS	Track 3325d call fx_set_default_dw_date( )
// 10/7/02 	JasonS	Track 3325d remove the call to uf_edit_case_log
// 11/14/03	MikeF		Track 3703d	Change visible to width 0 for export purposes
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
/////////////////////////////////////////////////////////////////////////////////////////////

String	ls_case,				&
			ls_case_ver,		&
			ls_case_spl

Long		ll_rowcount			

Integer	li_rc					// FDG 10/03/01


// SAH 02/25/02 Track #2437 -Begin

String	ls_sql,				&
			ls_select,			&
			ls_from,				&
			ls_where,			&
			ls_invoice_type,	&
			ls_style,			&
			ls_syntax,			&
			ls_error,			&
			ls_title,			&
			ls_order, 			&
			ls_mod, 				&
			ls_col,				&
			ls_type,				&
			ls_rc
			
Long		ll_row

Integer	li_idx,				&
			li_line_count,		&
			li_hdr_height,		&
			li_y_pos,			&
			li_len,		&
			li_pos, 		&
			li_index, 	&
			li_cols


// MikeFl 4/2/02 - Track 2741 - Variables 
string	ls_elem_name, ls_code_type

Constant Integer 	li_height_constant  =  21

n_cst_labels	lnv_labels

ls_case		=	Left (is_active_case, 10)
ls_case_spl	=	Mid (is_active_case, 11, 2)
ls_case_ver	=	Mid (is_active_case, 13, 2)

// Begin - Track 3082d
// Get the table type for CASE_LOG from DICTIONARY
ls_invoice_type = gnv_dict.event ue_get_inv_type( 'CASE_LOG' ) 
ls_select = gnv_dict.EVENT ue_build_dict_sql_select( 'CASE_LOG' )
// Search and replace CASE_LOG.DISP with its CODE_DESC from CODE table
li_pos = pos(ls_select, 'CASE_LOG.DISP')
IF (li_pos > 0) THEN
	// JasonS 07/24/02 Begin - Track 3190d
	ls_select = replace(ls_select, li_pos, 13, "CODE.CODE_CODE " + &
				gnv_sql.is_concat + " ' - ' " + gnv_sql.is_concat + " CODE.CODE_DESC AS DISP")
	// JasonS 07/24/02 End - Track 3190d
END IF

// Format the FROM and WHERE statements
ls_code_type = gnv_dict.event ue_get_lookup_type( ls_invoice_type, 'DISP')

ls_from = 'FROM CASE_LOG, CODE'		// JasonS  Track 3082d

ls_where  =  "WHERE CASE_LOG.case_id = '" 	 	+ ls_case     	+ "' AND " + &
						 "CASE_LOG.case_spl = '"  	+ ls_case_spl 	+ "' AND " + & 
						 "CASE_LOG.case_ver = '"  	+ ls_case_ver 	+ "' AND " + &
						 "CODE.code_type = '"	+ ls_code_type + "' AND " + &
						 "CODE.code_code = CASE_LOG.DISP"


// SAH 05/23/02 -End
					  
ls_order  =  "ORDER BY sys_datetime DESC"

// String entire SQL Statement together
ls_sql  =  ls_select  +  " "  +  ls_from  +  " "  +  ls_where + " " + ls_order

// Set the style of the datawindow to grid, color to current background color
ls_style   =  "datawindow(units=1 color=" + string(stars_colors.datawindow_back) + ") style(type=grid)"

// Get the syntax needed to build the datawindow
ls_syntax  =  Stars2ca.SyntaxFromSQL(ls_sql, ls_style, ls_error)

IF ls_error <> "" THEN
	MessageBox('ERROR', 'Incorrect syntax. Error = ' + ls_error + " " + 'SQL = '  + ls_sql)
	RETURN
END IF
	
// Create the datawindow
li_rc = tab_case.tabpage_log.dw_display_log.CREATE(ls_syntax, ls_error)

// Begin - Track 3082d
this.triggerevent("ue_get_dw_syntax")
// End - Track 3082d

tab_case.tabpage_log.dw_display_log.Object.Datawindow.ReadOnly = 'YES'

IF li_rc < 0 THEN
	MessageBox('ERROR', 'Error encountered while Creating datawindow in w_case_maint.ue_retrieve_log() Error = ' + &
					+ ls_error  +  'SQL = '   +  ls_sql)
	RETURN
END IF
	
// Calculate values needed to format the datawindow header 
//			***li_height_constant  =  21***

// Include one line to make space for the title
li_line_count = 1

// Add a blank line beneath the title
li_line_count++

// Calculate the header height (title + column headings)
li_hdr_height  =  (li_line_count + 2) * li_height_constant	

// Calculate the starting height for column heading text
li_y_pos  =  (li_line_count * li_height_constant)				

// Add title to datawindow
ls_title = 'CASE LOG'

// Pass the title, dw, header height, x and y coordinates for title, title alignment (2), and title width
wf_add_datawindow_title( ls_title, tab_case.tabpage_log.dw_display_log, string(li_hdr_height), '536', '2', '568')

tab_case.tabpage_log.dw_display_log.SetTransObject(Stars2ca)
ll_rowcount		=	tab_case.tabpage_log.dw_display_log.Retrieve (ls_case, ls_case_spl, ls_case_ver)

IF	ll_rowcount	>	0		THEN
	tab_case.tabpage_log.st_count.text = String(ll_rowcount)
	tab_case.tabpage_log.enabled	=	TRUE
ELSE
	tab_case.tabpage_log.enabled	=	FALSE
END IF

// still need this here or case add will fail
tab_case.tabpage_log.dw_log.SetTransObject(Stars2ca)
tab_case.tabpage_log.dw_log.Retrieve(ls_case, ls_case_spl, ls_case_ver)

// Begin - Track 3009d  Moved this block of code down from above

// Format height of header band and column headings
lnv_labels  =  CREATE n_cst_labels

// Register datawindow with n_cst_labels
lnv_labels.of_setdw(tab_case.tabpage_log.dw_display_log)

// Dictionaryize the labels
lnv_labels.of_labels2( ls_invoice_type, string(li_hdr_height), '40', string(li_y_pos) )

DESTROY(lnv_labels)

// JasonS 11/25/02 Begin - Track 3374
tab_case.tabpage_log.dw_display_log.object.case_id.width = 0
tab_case.tabpage_log.dw_display_log.object.case_spl.width = 0
tab_case.tabpage_log.dw_display_log.object.case_ver.width = 0
// JasonS 11/25/02 End - Track 3374

// JasonS 09/26/02 Begin - Track 3325d
fx_set_default_dw_date( tab_case.tabpage_log.dw_display_log )
// JasonS 09/26/02 End - Track 3325d

li_cols = INTEGER(tab_case.tabpage_log.dw_display_log.Object.DataWindow.Column.Count)

// Modify columns
FOR li_index = 1 to li_cols

	ls_col    = tab_case.tabpage_log.dw_display_log.Describe('#'+string(li_index)+'.name')
	
	// Get column's data type
	ls_type = trim(tab_case.tabpage_log.dw_display_log.Describe('#'+string(li_index)+'.ColType'))
	li_pos    = pos(ls_type,"(")
	
	IF li_pos > 0 THEN 
		li_len     = len(ls_type)
		li_len     = integer(mid(ls_type,li_pos + 1, li_len - li_pos - 1))
		ls_type = left(ls_type,li_pos - 1)
	ELSE
		li_len     = 0
	END IF
	
	// Modify headers
	ls_mod += ls_col + "_t.y = 60 "
	ls_mod += ls_col + '_t.font.face="Microsoft Sans Serif" '
	ls_mod += ls_col + '_t.font.height="-8" ' 
	ls_mod += ls_col + '_t.font.weight="700" '
	ls_mod += ls_col + '_t.font.family="2" '
	ls_mod += ls_col + '_t.font.pitch="2" '
	ls_mod += ls_col + '_t.font.charset="0" '
	ls_mod += ls_col + '_t.border="4" '
	ls_mod += ls_col + '_t.height="40" '
	ls_mod += ls_col + '_t.alignment="2" '
	ls_rc  = tab_case.tabpage_log.dw_display_log.Modify (ls_mod)
	
	ls_mod = ""
	
	// Modify columns
	ls_mod += ls_col + '.font.face="Microsoft Sans Serif" '
	ls_mod += ls_col + '.font.height="-8" ' 
	ls_mod += ls_col + '.font.weight="400" '
	ls_mod += ls_col + '.font.family="2" '
	ls_mod += ls_col + '.font.pitch="2" '
	ls_mod += ls_col + '.font.charset="0" '
	ls_rc  = tab_case.tabpage_log.dw_display_log.Modify (ls_mod)
NEXT
end event

event ue_retrieve_track();///////////////////////////////////////////////////////////////////////////
//	Event:	ue_retrieve_track
//
//	Description:
//				Retrieve the tracks for this case.
//
///////////////////////////////////////////////////////////////////////////
//	History:
//
//	4/25/00	NLG	Track 2232 Disable Next button on log tab if no tracks
// JasonS 09/30/02 Track 3314d call uf_format_custom_headings
// JasonS 10/26/04 Track 3573 Update track count
///////////////////////////////////////////////////////////////////////////

String	ls_case,				&
			ls_case_ver,		&
			ls_case_spl

Long		ll_rowcount

ls_case		=	Left (is_active_case, 10)
ls_case_spl	=	Mid (is_active_case, 11, 2)
ls_case_ver	=	Mid (is_active_case, 13, 2)

ll_rowcount		=	tab_case.tabpage_track.dw_track.Retrieve (ls_case, ls_case_spl, ls_case_ver)
inv_case.uf_format_custom_headings(tab_case.tabpage_track.dw_track)	// JasonS 09/30/02 Track 3314d

IF	ll_rowcount	>	0		THEN
	tab_case.tabpage_track.enabled	=	TRUE
	//tab_case.tabpage_log.cb_next_log.enabled = TRUE //NLG 4-25-00
	//tab_case.tabpage_savings.enabled = FALSE
ELSE
	tab_case.tabpage_track.enabled	=	FALSE
//	cb_next_log.enabled = FALSE //NLG 4-25-00
//	tab_case.tabpage_log.cb_next_log.enabled = FALSE//NLG 4-25-00
END IF

// Set the text on this tab.
tab_case.tabpage_savings.st_savings.text	=	'Some of the savings data cannot be changed '	+	&
															'on this tab.~r~nUse the Case  '	+	&
															'Tracks Detail window to enter this '	+	&
															'data.'
															
tab_case.tabpage_track.st_track_count.text = string(tab_case.tabpage_track.dw_track.rowcount())															

																										


end event

event ue_check_bg_step_cntl_case_id;///////////////////////////////////////////////////////////////////////////////////
// AJS	01/12/99		FS1983d 4.1. Created.
//							Check if jobs pending that will be inserted into case 
//
///////////////////////////////////////////////////////////////////////////////////
integer li_rc
long ll_num_links
string ls_subc_name, ls_start_date, ls_job_id
n_ds lds_bg_cases
lds_bg_cases = create n_ds

lds_bg_cases.dataobject = 'd_bg_step_cntl_list_by_case_id'
li_rc = lds_bg_cases.setTransObject(stars2ca)
ll_num_links = lds_bg_cases.retrieve(in_case_id,in_case_spl,in_case_ver)

if ll_num_links  = 0 then
	return 0
elseif ll_num_links  < 0 then
	messagebox('Error','Error retrieving Step Cntl using case_id. Cannot delete case.')
	Return -1
else 
	ls_job_id = lds_bg_cases.object.bg_step_cntl_job_id[1]		
	ls_start_date = string(lds_bg_cases.object.server_jobs_sched_next_date[1],'mm/dd/yyyy hh:mm:ss')
	ls_subc_name = lds_bg_cases.object.bg_step_cntl_subc_name[1]
	Messagebox('CASE DELETE ERROR','Subset  '+ls_subc_name+' is a subset that is scheduled to be added to this case. ~nThis case cannot be deleted until Job Id ' + ls_job_id + '~nscheduled for ' + ls_start_date + ' completes.',Stopsign!)
	Return 	1
End if

end event

event ue_delete_anal_criteria;///////////////////////////////////////////////////////////////////////////////////
// FNC	11/12/98		Track 1942. Created.
//							Delete anal crit linked to case
//	AJS   02-15-98    Remove reference to obsolete table
//	FDG	04/16/01		Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//
///////////////////////////////////////////////////////////////////////////////////

integer	li_rc
long 		ll_num_crits,	&
			ll_idx,				&
			ll_msg
string	ls_crit_id

n_ds lds_crit
lds_crit = create n_ds

lds_crit.dataobject = 'd_case_links'
li_rc = lds_crit.setTransObject(stars2ca)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 - end

ll_num_crits = lds_crit.retrieve(in_case_id,in_case_spl,in_case_ver,'CRA')
for ll_idx = 1 to ll_num_crits
	ls_crit_id = lds_crit.GetItemString(ll_idx,'link_key')
	
	delete from ANAL_CRIT_CNTL
	where crit_id = Upper( :ls_crit_id )
	using stars2ca;
	
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error deleting from anal_crit_cntl')
		RETURN -1
	End If

	delete from ANAL_CRIT_LINE
	where crit_id = Upper( :ls_crit_id )
	using stars2ca;
	
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error deleting from anal_crit_line')
		RETURN -1
	End If
	
next

return 0
end event

event ue_delete_pdqs;///////////////////////////////////////////////////////////////////////////////////
// FNC	11/12/98	Track 1942. Created.
//						Delete case link PDQ's
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//
///////////////////////////////////////////////////////////////////////////////////

integer	li_rc
long 		ll_num_pdqs,	&
			ll_idx,				&
			ll_msg
string	ls_query_id

n_ds lds_pdqs
lds_pdqs = create n_ds

lds_pdqs.dataobject = 'd_case_links'
li_rc = lds_pdqs.setTransObject(stars2ca)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 - end

ll_num_pdqs = lds_pdqs.retrieve(in_case_id,in_case_spl,in_case_ver,'PDQ')
for ll_idx = 1 to ll_num_pdqs
	ls_query_id = lds_pdqs.GetItemString(ll_idx,'link_key')
	
	update PDQ_CNTL 
	set DELETE_IND = 'Y'
	where query_id = Upper( :ls_query_id )
	using stars2ca;
	
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error deleting case-linked PDQ')
		RETURN -1
	End If
	
next

if IsValid(lds_pdqs) then destroy lds_pdqs 

return 0
end event

event type integer ue_delete_reports(string as_link_type);///////////////////////////////////////////////////////////////////////////////////
// 11/12/98	FNC	Track 1942. Created.
//						Delete case link reports
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//
///////////////////////////////////////////////////////////////////////////////////

integer	li_rc
long 		ll_num_pdqs,	&
			ll_idx,				&
			ll_msg
string	ls_rpt_id
n_cst_report	lnv_report
n_ds lds_pdqs
lds_pdqs = create n_ds

lds_pdqs.dataobject = 'd_case_links'
li_rc = lds_pdqs.setTransObject(stars2ca)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 - end

ll_num_pdqs = lds_pdqs.retrieve(in_case_id,in_case_spl,in_case_ver,as_link_type)

for ll_idx = 1 to ll_num_pdqs
	ls_rpt_id = lds_pdqs.GetItemString(ll_idx,'link_key')
	IF lnv_report.of_delete( ls_rpt_id, as_link_type ) < 0 THEN Return -1
next

Destroy lds_pdqs

return 0
end event

event ue_delete_subsets;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.

integer	li_rc
long 		ll_num_subsets,	&
			ll_idx,				&
			ll_msg
string	ls_subset_id,		&
			ls_subset_name

nvo_subset_functions lnv_subset_functions
sx_subset_ids lstr_subset_ids

n_ds lds_subsets
lds_subsets = create n_ds
lnv_subset_functions = create nvo_subset_functions

lds_subsets.dataobject = 'd_case_links'
li_rc = lds_subsets.setTransObject(stars2ca)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 - end

ll_num_subsets = lds_subsets.retrieve(in_case_id,in_case_spl,in_case_ver,'SUB')

for ll_idx = 1 to ll_num_subsets
	ls_subset_id = lds_subsets.GetItemString(ll_idx,'link_key')
	ls_subset_name = lds_subsets.GetItemString(ll_idx,'link_name')
	lstr_subset_ids.subset_id = ls_subset_id
	lstr_subset_ids.subset_name = ls_subset_name
	lstr_subset_ids.subset_case_id = in_case_id
	lstr_subset_ids.subset_case_spl = in_case_spl
	lstr_subset_ids.subset_case_ver = in_case_ver
	li_rc = lnv_subset_functions.uf_set_structure(lstr_subset_ids)
	ll_msg = lnv_subset_functions.uf_delete_subset()
	If ll_msg  <> 1 then
		stars2ca.of_rollback()
		If ll_msg = -1 then
			MessageBox('Error','Error deleting subset ' + ls_subset_name +&
							'~rCase will not be deleted')
		else
			Messagebox('Case Delete','Case will not be deleted')					
		end if
		if isValid(lds_subsets) then destroy lds_subsets
		if IsValid(lnv_subset_functions) then destroy lnv_subset_functions
		RETURN -1
	End If
Next
if isValid(lds_subsets) then destroy lds_subsets

return 0
end event

event ue_delete_targets_tracks;/////////////////////////////////////////////////////////////////////////////////////////
// FNC	11/12/98		Track 1942. 
//							1.Move code from delete button. 
//	FDG	04/16/01		Stars 4.7.	Account for empty string or space in key data.
//
/////////////////////////////////////////////////////////////////////////////////////////

Integer	li_rc

// FDG 04/16/01 - Empty string in Oracle is null
in_case_id	=	Trim(in_case_id)
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 end

// Delete Targets
Delete from Target_cntl
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Target Control Table')
	return -1
End If

Delete from Target
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Target Table')
	return -1
End If

//Delete Tracks
Delete from Track
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Track Table')
	return -1
End If

Delete from Track_log
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Track Log Table')
	return -1
End If

return 0
end event

event ue_get_track_type;long ll_row

ll_row = tab_case.tabpage_general.dw_general.GetRow()
if ll_row < 1 then return

If in_from = 'A' or &
	in_from = 'N' or &
	in_case_cat = 'REF' or &
	in_case_cat = 'CA?' or &
	(NOT(in_track_exists)) then
	iv_track_type = tab_case.tabpage_general.dw_general.getItemString(ll_row,"case_type")
End If


end event

event ue_clear_case;If gv_case_disp = 'MYHOLD' then
	Update Case_CNTL
		set
			case_disp_hold	  = ' '
		Where		case_id	  = Upper( :in_case_id ) AND
					case_spl   = Upper( :in_case_spl ) AND
					case_ver   = Upper( :in_case_ver )
	Using  stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error Writing Case with Original Disposition')
		RETURN
	End If
	Delete from sys_cntl
		where cntl_id  = Upper( :gc_user_id ) and
				cntl_case = Upper( :is_active_case )
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error Releasing Hold Lock on Case')
		RETURN
	End If
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	//Need to close the subset target maintain window so that hold locks get released
	If isvalid(w_target_subset_maintain) then
		close(w_target_subset_maintain)
	End IF
End IF
gv_case_disp           = ''
in_from = 'N'

tab_case.tabpage_general.dw_general.SetRedraw(FALSE)

this.triggerevent("ue_initialize_case")

this.event ue_set_window_title()

tab_case.tabpage_general.dw_general.SetRedraw(TRUE)

end event

event ue_open_track_maint();//AJS 09-28-99 populate structure instead of using globals
// FDG 02/13/01	Stars 4.6 - PIMR.  If anything was entered on the case, show a
//						warning message.
//Katie	11/09/2004 Track 3741 Added target_id to track retrieval arguments.

Integer	li_rc

long ll_row
sx_case_track lstr_case_track

ll_row = tab_case.tabpage_track.dw_track.getRow()
lstr_case_track.trk_key = tab_case.tabpage_track.dw_track.GetItemString(ll_row,"trk_key")
lstr_case_track.trk_type = tab_case.tabpage_track.dw_track.GetItemString(ll_row,"trk_type")
lstr_case_track.target_id = tab_case.tabpage_track.dw_track.GetItemString(ll_row,"target_id")
lstr_case_track.case_id = is_active_case

// FDG 02/13/01 - Determine if any data was changed
// Apply the contents of the edit controls to all datawindows.
li_rc	=	This.Event ue_accepttext (This.control, TRUE)
IF li_rc	<	0	THEN
	Return
END IF

IF tab_case.tabpage_general.dw_general.GetItemStatus(ll_row,0,Primary!) = NewModified!		&
OR	tab_case.tabpage_general.dw_general.GetItemStatus(ll_row,0,Primary!) = DataModified!	THEN
	li_rc	=	MessageBox ("Question", "Data was changed for this case.  Would you like to "		+	&
								"save this data before proceeding to the Track Details window?  "		+	&
								"If you select No, then any changes made to this case will be lost.",	&
								Question!, YesNoCancel!, 1)
	CHOOSE CASE	li_rc
		CASE	1
			//	Save before opening track details
			ib_open_track	=	TRUE
			li_rc	=	This.Event	ue_save()
			ib_open_track	=	FALSE
			IF	li_rc	<	0		THEN
				Return
			END IF
		CASE	3
			// Cancel from opening track details
			Return
	END CHOOSE
END IF
// FDG 02/13/01 - end

OpensheetWithParm (w_track_maint, lstr_case_track, MDI_MAIN_FRAME, HELP_MENU_POSITION, LAYERED!)

end event

event ue_edit_assigned_date;//*********************************************************************************
//
//*********************************************************************************



//Choose Case li_rc 
//	Case -1
//		idt_assign_datetime = gnv_app.of_get_server_date_time()	
//		tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_asgn_date",idt_assign_datetime)
//		tab_case.tabpage_general.dw_general.AcceptText()
//	Case -2 
//		MessageBox('Error', 'Accurate update of assigned to date requires a four digit year in the assigned to date field.')
//		Return -1
//	Case -3
//		Setfocus(sle_assigned_date)
//		MessageBox('Error', 'Assigned Date must be between' + lnvo_cst_datetime.of_getminimumstringdate() + &
//		' and ' + lnvo_cst_datetime.of_getmaximumstringdate())
//		Return -1
//	Case Else
//		idt_assign_datetime = datetime(date(sle_assigned_date.text))
//End Choose


Return 0
end event

event ue_edit_receipt_date;//*********************************************************************************
// 01/13/99 FNC	TS2040C Stars 4.0 SP1. Created.
//						Require user to input 4 digit year. Replace edits in cb_update and
//						cb_add with one event
// 09/22/99	NLG	ts2363c. Changes for tab controls
//*********************************************************************************

//If trim(sle_receipt_date.text) = '' then
//	sle_receipt_date.text = inv_sys_cntl.of_get_default_date() 
//	idt_receipt_date  = gnv_app.of_get_server_date_time()
//Else 
//	N_cst_datetime lnvo_cst_datetime
//	Li_rc = lnvo_cst_datetime.of_isvaliddate(sle_receipt_date.text)
//	Choose Case li_rc 
//		Case -1
//			Setfocus(sle_receipt_date)
//			Messagebox('EDIT','Receipt Date Is not Valid')
//			RETURN -1
//		Case -2 
//			Setfocus(sle_receipt_date)
//			MessageBox('Error', 'Accurate update of receipt date requires a four digit year in the receipt date field.')
//			Return -1
//		Case -3
//			Setfocus(sle_receipt_date)
//			MessageBox('Error', 'Receipt Date must be between' + lnvo_cst_datetime.of_getminimumstringdate() + &
//			' and ' + lnvo_cst_datetime.of_getmaximumstringdate())
//			Return -1
//		Case Else
//			if arg_come_from = 'UPDATE' then
//				idt_receipt_date = datetime(date(sle_receipt_date.text))	 
//				ld_receipt = date(idt_receipt_date)                             
//				li_pos  = pos(sle_created_date.text,' ')		 
//				If li_pos > 0 then			 
//					ld_created = date(left(sle_created_date.text,li_pos - 1))	 
//				Else                                                            
//					ld_created = date(sle_created_date.text)		 
//				End IF 
//	
//				IF (in_case_spl > '00') OR (in_case_ver > '00')	THEN
//				ELSE				// Case not split or referred
//					If ld_receipt > ld_created then
//						Messagebox('EDIT','Receipt Date cannot be greater than the Case Create date')
//						Setfocus(sle_receipt_date)				 
//						RETURN -1
//					End If
//				END IF
//			Else
//				ld_today = date(gnv_app.of_get_server_date_time())
//				ld_receipt = date(sle_receipt_date.text)
//				If ld_receipt > ld_today then
//					Messagebox("EDIT","Receipt date must not be greater than today's date")
//					Setfocus(sle_receipt_date)
//					Return -1
//				else
//					idt_receipt_date = datetime(date(sle_receipt_date.text))	
//				End if
//			end if
//	End Choose
//End if
boolean lb_rc
long ll_row
datetime ldte_receipt_date
date ld_receipt, ld_create, ld_today

ll_row = tab_case.tabpage_general.dw_general.GetRow()
ldte_receipt_date = tab_case.tabpage_general.dw_general.object.case_date_recv[ll_row]

If IsNull(ldte_receipt_date) then
	idt_receipt_date  = gnv_app.of_get_server_date_time()
	tab_case.tabpage_general.dw_general.object.case_date_recv[ll_row] = idt_receipt_date
Else 
	N_cst_datetime lnvo_cst_datetime
	lb_rc = lnvo_cst_datetime.of_isvalid(ldte_receipt_date)
	if NOT lb_rc then
		Messagebox("EDIT","Receipt date is not valid")
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetColumn("case_date_recv")
		tab_case.tabpage_general.dw_general.SetFocus()
		return -1
	end if
	
	if as_come_from = 'UPDATE' then
		idt_receipt_date = ldte_receipt_date	 
		ld_receipt = date(idt_receipt_date)
		ld_create = date(tab_case.tabpage_general.dw_general.object.case_datetime[ll_row])
		
		IF (in_case_spl > '00') OR (in_case_ver > '00')	THEN
		ELSE				// Case not split or referred
				If ld_receipt > ld_create then
					Messagebox('EDIT','Receipt Date cannot be greater than the Case Create date')
					tab_case.SelectTab("tabpage_general")
					tab_case.tabpage_general.dw_general.SetColumn("case_date_recv")
					tab_case.tabpage_general.dw_general.SetFocus()				 
					RETURN -1
				End If
		END IF
	Else//'CREATE'
		ld_today = date(gnv_app.of_get_server_date_time())
		ld_receipt = date(tab_case.tabpage_general.dw_general.object.case_date_recv[ll_row])
		If ld_receipt > ld_today then
			Messagebox("EDIT","Receipt date must not be greater than today's date")
			tab_case.SelectTab("tabpage_general")
			tab_case.tabpage_general.dw_general.SetColumn("case_date_recv")
			tab_case.tabpage_general.dw_general.SetFocus()
			Return -1
		else
			idt_receipt_date = tab_case.tabpage_general.dw_general.object.case_date_recv[ll_row]
		End if
	end if
	
	
End if

Return 0

end event

event type integer ue_edits(long al_row, dwobject ad_dwo, string as_data);///////////////////////////////////////////////////////////////////////////////
//script:	ue_edits
//	Description
//		Called from dw_general.itemchanged()
//		Update appropriate date when assign to, status or disposition change.
//		If case type changes, update iv_track_type
///////////////////////////////////////////////////////////////////////////////
//
//	FDG	02/04/01	Stars 4.6 - PIMR.  If pmr_ready_cd changes, change pmr_ready_date
//	FDG	05/14/01	Stars 4.6 (SP1).  Only change the pmr_ready_user if 
//						pmr_ready_cd is changed to 'Y'
//	FDG	11/06/01	Stars 4.8.1.	If dept_id was changed, filter user_id.
// JasonS 07/25/02 Track 3190d call filter again to filter out system dispositions 
//										 after the user changes from a system disposition
///////////////////////////////////////////////////////////////////////////////

Integer	li_rc
string 	ls_columnname, ls_assign_to

long 		ll_current_row, ll_count
datawindowchild ldwc

ls_columnname = ad_dwo.name
ll_current_row = tab_case.tabpage_general.dw_general.GetRow ()

CHOOSE CASE ls_columnname
	CASE 'case_asgn_id'
		ls_assign_to 		= as_data
		select count(*) into :ll_count
			from Users
			where user_id = Upper( :ls_assign_to )
		Using Stars2ca;
		If stars2ca.of_check_status() <> 0 then
			Errorbox(stars2ca,'Error Reading User Table')
			RETURN -1
		Elseif ll_count <= 0 then
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Committing to Stars2')
				Return -1
			End If	
			Messagebox('EDIT','Assigned User Does Not Exist')
			tab_case.SelectTab("tabpage_general")
			tab_case.tabpage_general.dw_general.SetColumn("case_asgn_id")
			tab_case.tabpage_general.dw_general.SetFocus()
			RETURN -1
		End If
		tab_case.tabpage_general.dw_general.Object.case_asgn_date[ll_current_row] = gnv_app.of_get_server_date_time()
		tab_case.tabpage_general.dw_general.getchild( "case_asgn_id", ldwc)	
		dw_headings.setitem(1, "assigned", ldwc.getitemstring( ldwc.find("user_id='" + as_data + "'",1, ldwc.rowcount( ) ), "cf_name"))				
	CASE 'case_status'
		tab_case.tabpage_general.dw_general.Object.case_status_date[ll_current_row] = gnv_app.of_get_server_date_time()
		tab_case.tabpage_current.dw_current.getchild( "case_status", ldwc)	
		dw_headings.setitem(1, "status", ldwc.getitemstring( ldwc.find("CODE_CODE='" + as_data + "'",1, ldwc.rowcount( ) ), "code_description"))				
	CASE 'case_disp'

		inv_case.uf_filter_sys_codes( idwc_case_disp, '' )

		tab_case.tabpage_current.dw_current.getchild( "case_disp", ldwc)	 
		dw_headings.setitem(1, "disposition", ldwc.getitemstring( ldwc.find("CODE_CODE='" + as_data + "'",1, ldwc.rowcount( ) ), "code_description"))				
		
	// FDG 11/06/01 begin
	CASE 'dept_id'
		This.Post	Event	ue_filter_userid (as_data)
		tab_case.tabpage_general.dw_general.getchild( "dept_id", ldwc)	 
		dw_headings.setitem(1, "department", ldwc.getitemstring( ldwc.find("CODE_CODE='" + as_data + "'",1, ldwc.rowcount( ) ), "code_description"))				
	// FDG 11/06/01 end
   CASE 'case_type'
		iv_track_type = as_data
	// FDG 02/04/01 - begin	
   CASE 'pmr_ready_cd'
		IF	as_data	=	'Y'		THEN
			tab_case.tabpage_general.dw_general.Object.pmr_ready_date[ll_current_row] = gnv_app.of_get_server_date_time()
			tab_case.tabpage_general.dw_general.object.pmr_ready_user[ll_current_row]	=	gc_user_id		// FDG 05/14/01
		ELSE
			tab_case.tabpage_general.dw_general.Object.pmr_ready_date[ll_current_row] = DateTime(Date('1/1/1900'))
			tab_case.tabpage_general.dw_general.object.pmr_ready_user[ll_current_row]	=	' '				// FDG 05/14/01
		END IF
		// Hide/display pmr_ready_date and pmr_created_date
		This.Post	Event	ue_display_ready_cd()
	// FDG 02/04/01 - end
	CASE 'case_desc'
		dw_headings.setitem(1, "description", as_data)	
	CASE 'pmr_subject_id'
		dw_headings.setitem(1, "subject_id", as_data)		
	CASE 'case_id'
		dw_headings.setitem(1, "case_id", as_data + " " + tab_case.tabpage_general.dw_general.getItemstring(1, "case_spl") + " " +tab_case.tabpage_general.dw_general.getItemstring(1, "case_ver"))

END CHOOSE

return 1
end event

event type integer ue_edit_case();//////////////////////////////////////////////////////////////////////////////////////////////////////	
//	w_case_maint.ue_edit_case
//	This script is called when case is created or updated.
//
//	History
//	NLG	Created.
//	NLG	11-08-99	Because Assign_To will be set to NONE when case
//			is referred (see Track 2066c), if user tries to update
//			case with NONE in assign_to, must give edit message.
//	FDG	01/14/01	Stars 4.6 - PIMR.  Add new PIMR data.
//						Also, fix case_log where incorrect sys_datetime
//						value was inserted.
//	FDG	01/14/01	Track 3047 - User should delete a secured case if the
//						departments match
// GaryR	01/09/01	Stars 4.7 DataBase Port - Empty String in SQL
//	FDG	03/01/01	Stars 4.6 - PIMR.  Don't edit disposition if the case
//						is referred.
//	GaryR 07/24/01	Track 2373d	DB Error inserting null into SYS_CNTL
//	FDG	08/23/01	Stars 4.8. Don't default a new case to CA?-Potential
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//	FDG	09/20/01	Stars 4.8.1.	Any changes to the case gets placed in
//						case_log.
// SAH   05/20/02 Stars 5.1  Track 2967 Oracle returns 01/01/1900 00:00:01, causing error messages on 
//									  columns that were not changed.
//	GaryR	05/21/02	Track 3061d	Resolve user_id columns on case_log
//	GaryR	05/29/02	Track 3103d	Similar case id assigned to multiple users.
// JasonS 06/05/02 Track 3033d When updating Case to & from dates, getting db error on null values
//						 changed code to update dw instead of local variables
// JasonS 06/12/02 Track 3128d When createing a case using null from and to date, getting db error on null dates
// JasonS 06/12/02 Track 3133d When editing a case that has a from or to date of 0's the log reflects that
//										 the date was changed when it really wasn't
//	GaryR	07/29/02	Track 3215d	Invalid case log generated from System case.
// JasonS 01/23/03 Track 3302d Increment case counter in user stats
// JasonS 03/14/02 Track 3302d added an _ to table name
//	GaryR	03/03/05	Track 4337d	Do not open Case Folder when referring case
 // Katie 05/29/07 SPR 5043 made sure gv_from was set to Case before opening w_lead_maintain
///////////////////////////////////////////////////////////////////////////////////////////////////////	

boolean 		lb_valid_date,			&
				lb_update,				&
				lb_create,				&
				lb_update_log,			&
				lb_log_created					// FDG 09/20/01

// FDG 1/14/01 - Add new PIMR data
datetime		ldte_to_period,			&
				ldte_from_period,			&
				ldte_recv_date,			&
				ldte_status_date,			&
				ldte_assign_date,			&
				ldte_datetime,				&
				ldte_default_datetime,	&
				ldte_system_datetime,	&
				ldte_custom1_date,		&
				ldte_custom2_date,		&
				ldte_custom3_date
				
				

// FDG 1/14/01 - Add new PIMR data
dec{2}		ld_custom1,				&
				ld_custom2,				&
				ld_custom3,				&
				ld_custom4,				&
				ld_custom5,				&
				ld_custom6,				&
				ld_custom7,				&
				ld_custom8,				&
				ld_custom9,				&
				ld_identified_amt,	&
				ld_amt_recv,			&
				ld_proj_amt
				
double 		li_case_no		

int			li_rc,					&
				li_dept_sl

// FDG 1/14/01 - Add new PIMR data
long 			ll_row_log,				&
				ll_row,					&
				ll_insert_row,			&
				ll_custom1,				&
				ll_custom2,				&
				ll_custom3,				&
				ll_custom4,				&
				ll_custom5,				&
				ll_custom6,				&
				ll_custom7,				&
				ll_custom8,				&
				ll_count

// FDG 01/14/01 - Add new PIMR data.
string		ls_case_id,				&
				ls_case_spl,			&
				ls_case_ver,			&
				ls_case_desc,			&
				ls_case_type,			&
				ls_case_cat,			&
				ls_dept_id,				&
				ls_case_business,		&
				ls_assign_to,			&
				ls_edit,					&
				ls_user_id,				&
				ls_case_disp,			&
				ls_update_user,		&
				ls_case_status,		&
				ls_status_desc,		&				
				ls_assign_date,		&
				ls_validate_case_id,	&
				ls_code_dept,			&
				ls_ready_cd,			&
				ls_created_cd,			&
				ls_old_ready_cd,		&
				ls_close_disp,			&
				ls_empty
				
date ld_userstatsdate  // JasonS 1/23/03 Track 3302d				
				
n_cst_datetime lnvo_cst_datetime

SetPointer(hourglass!)
SetMicroHelp(w_main,'Ready')

is_save_successful_msg	=	is_prev_save_msg		// FDG 01/14/01

ll_row = tab_case.tabpage_general.dw_general.GetRow()

if (tab_case.tabpage_general.dw_general.GetItemStatus(ll_row,0,Primary!) = NewModified!) OR +&
	in_from = 'N' Then
	//inserting new case  --  case log will be updated
	//if coming from cb_model, datawindow will be modified, but in_from is
	//		set back to 'N' to mimic new case
	lb_create = TRUE
	lb_update_log = TRUE
Elseif tab_case.tabpage_general.dw_general.GetItemStatus(ll_row,0,Primary!) = DataModified! Then
	//updating case -- check if Money amounts have changed or 
	//disposition has changed.  If so, case log will be updated
	lb_update_log	=	TRUE
	lb_update = TRUE
else
	//nothing being updated or inserted -- do nothing
	lb_update_log = FALSE
end if

//get today's date
ldte_datetime = gnv_app.of_get_server_date_time()

//local variable for default datetime
ldte_default_datetime = datetime(date('01/01/1900'))

ls_case_id 			= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_id')
ls_case_spl 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_spl')
ls_case_ver 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_ver')
ls_case_type 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_type')
ls_case_cat 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_cat')
ls_case_business 	= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_business')	
ls_case_desc 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_desc')		
ls_assign_to 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_asgn_id')
ls_edit 				= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_edit')
ls_user_id 			= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'user_id')
ls_dept_id 			= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'dept_id')
ldte_assign_date 	= tab_case.tabpage_general.dw_general.GetItemDateTime(ll_row,'case_asgn_date')
ldte_recv_date 	= tab_case.tabpage_general.dw_general.GetItemDateTime(ll_row,'case_date_recv')
ldte_from_period	= tab_case.tabpage_general.dw_general.object.case_from_period[ll_row]
ldte_to_period		=	tab_case.tabpage_general.dw_general.object.case_to_period [ll_row]
ls_case_disp		= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'case_disp')
ls_update_user 	= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'case_updt_user')
ls_case_status 	= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'case_status')
ls_status_desc 	= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'case_status_desc')
ldte_status_date 	= tab_case.tabpage_current.dw_current.GetItemDateTime(ll_row,'case_status_date')		
ld_identified_amt = tab_case.tabpage_savings.dw_savings.GetItemNumber(ll_row,'identified_amt')		
ld_proj_amt			= tab_case.tabpage_savings.dw_savings.GetItemNumber(ll_row,'future_savings_amt')	
ld_custom1 			= tab_case.tabpage_savings.dw_savings.GetItemNumber(ll_row,'case_custom1_amt')
ld_custom2 			= tab_case.tabpage_savings.dw_savings.GetItemNumber(ll_row,'case_custom2_amt')
ld_custom3 			= tab_case.tabpage_savings.dw_savings.GetItemNumber(ll_row,'case_custom3_amt')
// FDG 1/14/01 - Add new PIMR data
ld_amt_recv			= tab_case.tabpage_savings.dw_savings.GetItemNumber(ll_row,'amt_recv')	
ls_ready_cd		 	= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'pmr_ready_cd')
ls_old_ready_cd 	= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'pmr_ready_cd', Primary!, True)
ls_created_cd		= tab_case.tabpage_current.dw_current.GetItemString(ll_row,'pmr_created_cd')
ld_custom4 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom4_amt')
ld_custom5 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom5_amt')
ld_custom6 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom6_amt')
ld_custom7 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom7_amt')
ld_custom8 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom8_amt')
ld_custom9 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom9_amt')
ll_custom1 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom1_cnt')
ll_custom2 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom2_cnt')
ll_custom3 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom3_cnt')
ll_custom4 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom4_cnt')
ll_custom5 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom5_cnt')
ll_custom6 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom6_cnt')
ll_custom7 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom7_cnt')
ll_custom8 			= tab_case.tabpage_pimr.dw_pimr.GetItemNumber(ll_row,'pmr_case_custom8_cnt')
ldte_custom1_date = tab_case.tabpage_current.dw_current.GetItemDateTime(ll_row,'pmr_custom1_date')		
ldte_custom2_date = tab_case.tabpage_current.dw_current.GetItemDateTime(ll_row,'pmr_custom2_date')		
ldte_custom3_date = tab_case.tabpage_current.dw_current.GetItemDateTime(ll_row,'pmr_custom3_date')		

// FDG 04/27/01 - Change circumvents a PB 7.0 bug when inserting a new case
ls_case_status		=	Left (ls_case_status, 2)
tab_case.tabpage_general.dw_general.object.case_status [ll_row]	=	ls_case_status
// FDG 04/27/01 end

if IsNull(ld_custom1) then ld_custom1 = 0
if IsNull(ld_custom2) then ld_custom2 = 0
if IsNull(ld_custom3) then ld_custom3 = 0

if lb_create then
	gv_result = 0//this switch is used in dupe checking, depending on the action selected
elseif lb_update then
	if (in_case_id <> ls_case_id) OR (in_case_spl <> ls_case_spl) or (in_case_ver <> ls_case_ver) then
		Messagebox('EDIT','Must first retrieve case before updating')
		this.event ue_set_menu_update(FALSE)
		return -1
	end if
end if

//set track type according to case_type
iv_track_type = ls_case_type

//NLG 08/13/01 No longer defaulting Case category to Potential. (WIC)
if trim(ls_case_cat) = '' then 
	Messagebox("EDIT","Case Category field is required")
	tab_case.SelectTab("tabpage_general")
	tab_case.tabpage_general.dw_general.SetColumn("case_cat")
	tab_case.tabpage_general.dw_general.SetFocus()
	return -1
end if

//case_status edits
CHOOSE CASE ls_case_status
	CASE ''
		Messagebox("EDIT","Status field is required")
		tab_case.SelectTab("tabpage_current")
		tab_case.tabpage_current.dw_current.SetColumn("case_status")
		tab_case.tabpage_current.dw_current.SetFocus()
		return -1
	CASE 'CL'
		IF lb_create THEN
			Messagebox("EDIT","Cannot create case with closed status")
			tab_case.SelectTab("tabpage_current")
			tab_case.tabpage_current.dw_current.SetColumn("case_status")
			tab_case.tabpage_current.dw_current.SetFocus()
			return -1
		END IF
	CASE 'DL'
		IF lb_update or lb_create THEN
			Messagebox("EDIT","Invalid Status - ~'DL~' is put by the System for a Delete Case")
			tab_case.SelectTab("tabpage_current")
			tab_case.tabpage_current.dw_current.SetColumn("case_status")
			tab_case.tabpage_current.dw_current.SetFocus()
			return -1
		END IF
END CHOOSE

//get the case security level.  It will be compared to the user security level
//											if the case is being closed
Select  code_value_a,code_value_n
	into :ls_code_dept,:li_dept_sl
	from  code
	where code_type = 'CA' and
			code_code = Upper( :ls_case_cat )
using stars2ca;
If stars2ca.of_check_status() = 100 then 
	Errorbox(stars2ca,'Case Category Code not Found')
	RETURN -1
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Reading Code Table for Category Codes')
	RETURN -1
End If

//For case update, if case status being changed to closed and disposition not 
//		being changed, check if user wants to change disp
gv_user_sl = trim(gv_user_sl)
IF lb_update THEN
	IF (ls_case_status <> in_case_status) AND (ls_case_status = 'CL') THEN
		if ls_case_disp = in_case_disposition then
			If Messagebox('EDIT','Would you like to change the Disposition on this Closed Case?',Question!,YesNO!,1) = 1 then
				tab_case.SelectTab("tabpage_current")
				tab_case.tabpage_current.dw_current.SetColumn("case_disp")
				tab_case.tabpage_current.dw_current.SetFocus()
				RETURN -1
			end if
		END IF//10-04-99
		if li_dept_sl = 1 then
			//it's a secured case
			if ls_code_dept = gc_user_dept then
				//the user is in the right dept, but if the case category is 'COM'
				//only AD or SA or 1 can close it
				If (NOT((gv_user_sl='SA') or (gv_user_sl='AD') or (gv_user_sl='1'))) and ls_case_cat = 'COM' then
					COMMIT using STARS2CA;																							
					If stars2ca.of_check_status() <> 0 Then
						errorbox(stars2ca,'Error Committing to Stars2')
						Return -1
					End If		//then don't allow close
					Messagebox('EDIT','Not Authorized to Close this Case. Ask your Supervisor to close this case ')
					RETURN -1
				End If
			End If//if ls_code_dept = gc_user_dept
		end if//if li_dept_sl = 1
	END IF//if changing status

	//Now check if either status or disposition are changed...
	IF (ls_case_status <> in_case_status) OR (in_case_disposition <> ls_case_disp) THEN
		
		tab_case.tabpage_current.dw_current.object.case_updt_user[ll_row] = gc_user_id
	END IF	
END IF //if lb_update

//case category edits
If (ls_case_cat = 'REF') AND (in_case_cat  <> ls_case_cat) then
	Messagebox('EDIT','REF Category is set only when case is Referred')
	tab_case.SelectTab("tabpage_general")
	tab_case.tabpage_general.dw_general.SetColumn("case_cat")
	tab_case.tabpage_general.dw_general.SetFocus()
	RETURN -1
	// FDG 08/23/01 - Allow the original case category to be empty
Elseif (in_case_cat <> 'CA?' and trim(in_case_cat) <> '') and (ls_case_cat = 'CA?') then
	if lb_update then
		Messagebox('EDIT','Case cannot be reverted to Potential')
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetColumn("case_cat")
		tab_case.tabpage_general.dw_general.SetFocus()
		RETURN -1
	end if
End IF

//case_disp edits
if trim(ls_case_disp) = '' then
	Messagebox("EDIT","Disposition field is required")
	tab_case.SelectTab("tabpage_current")
	tab_case.tabpage_current.dw_current.SetColumn("case_disp")
	tab_case.tabpage_current.dw_current.SetFocus()
	return -1
else
	if lb_update then
		// FDG 03/01/01 - Don't edit this if the case is referred.
		//if left(ls_case_disp,3) = 'SYS' or left(ls_case_disp,3) = 'REF' then
		if left(ls_case_disp,3) = 'SYS'  then
			messagebox('EDIT','Must change the System Created Disposition')
			tab_case.SelectTab("tabpage_current")
			tab_case.tabpage_current.dw_current.SetColumn("case_disp")
			tab_case.tabpage_current.dw_current.SetFocus()
			return -1
		end if
	elseif lb_create then
		if left(ls_case_disp,3) = 'SYS' then
			Messagebox('EDIT','SYSTEM Dispositions Cannot be entered by Operator')
			tab_case.SelectTab("tabpage_current")
			tab_case.tabpage_current.dw_current.SetColumn("case_disp")
			tab_case.tabpage_current.dw_current.SetFocus()
			return -1
		end if
	end if
end if

//case_business edits
if trim(ls_case_business) = '' then
	Messagebox("EDIT","Case Business field is required")
	tab_case.SelectTab("tabpage_general")
	tab_case.tabpage_general.dw_general.SetColumn("case_business")
	tab_case.tabpage_general.dw_general.SetFocus()
	return -1
end if

//Date edits
//Edit the period dates
li_rc = this.event ue_edit_period_dates()
if li_rc = -1 then 
	return li_rc
end if
if IsNull(ldte_to_period) then
	// Begin - Track 3033d Update dw instead of local variable
	// Begin - Track 3128d Need to update local variable for create (updating both now)
	ldte_to_period = ldte_default_datetime
	// End - Track 3128d
	// Begin - Track 3133d  only update dw if the date is 00/00/0000 and the field was marked as changed	
	IF (tab_case.tabpage_general.dw_general.getitemstatus(ll_row, 'case_to_period', Primary!) = DataModified!) THEN
		tab_case.tabpage_general.dw_general.object.case_to_period[ll_row] = ldte_default_datetime
	END IF
	// End - Track 3133d
	// End - Track 3033d
end if
if IsNull(ldte_from_period) then
	// Begin - Track 3033d Update dw instead of local variable
	// Begin - Track 3128d Need to update local variable for create (updating both now)
	ldte_from_period = ldte_default_datetime
	// End - Track 3128d
	// Begin - Track 3133d  only update dw if the date is 00/00/0000 and the field was marked as changed
	IF (tab_case.tabpage_general.dw_general.getitemstatus(ll_row, 'case_from_period', Primary!) = DataModified!) THEN
		tab_case.tabpage_general.dw_general.object.case_from_period[ll_row]	= ldte_default_datetime
	END IF
	// End - Track 3133d
	// End - Track 3033d
end if

//case status date edit 
lb_valid_date = lnvo_cst_datetime.of_isvalid(ldte_status_date)
if NOT(lb_valid_date) then
	Messagebox("EDIT","Please enter a valid Status Date")
	tab_case.tabpage_current.dw_current.object.case_status_desc.protect = 0
	tab_case.tabpage_current.dw_current.object.case_status_date.protect = 0
	tab_case.SelectTab("tabpage_current")
	tab_case.tabpage_current.dw_current.SetColumn("case_status_date")
	tab_case.tabpage_current.dw_current.SetFocus()
	return -1
end if
if idt_current_datetime <> ldte_status_date then
	//the user has changed the status date. Use entered value
else	
	//date has not been changed.  Use today's date
	ldte_status_date = ldte_datetime
end if
idt_current_datetime = ldte_status_date

//receipt date edit 
if lb_update then
	li_rc = this.event ue_edit_receipt_date('UPDATE')
else
	li_rc = this.event ue_edit_receipt_date('CREATE')
end if 
if li_rc = -1 then return -1

// FDG 01/14/01 begin
IF	IsNull (ldte_custom1_date)		THEN
	ldte_custom1_date	=	ldte_default_datetime
	tab_case.tabpage_current.dw_current.object.pmr_custom1_date	[ll_row]	=	ldte_default_datetime
END IF

IF	IsNull (ldte_custom2_date)		THEN
	ldte_custom2_date	=	ldte_default_datetime
	tab_case.tabpage_current.dw_current.object.pmr_custom2_date	[ll_row]	=	ldte_default_datetime
END IF

IF	IsNull (ldte_custom3_date)		THEN
	ldte_custom3_date	=	ldte_default_datetime
	tab_case.tabpage_current.dw_current.object.pmr_custom3_date	[ll_row]	=	ldte_default_datetime
END IF

// SAH 05/20/02 Track 2967 -Begin
//IF	ldte_custom1_date	<>	ldte_default_datetime	THEN
IF NOT (IsNull(ldte_custom1_date)) AND ((Date(ldte_custom1_date) <> Date("01/01/1900"))) THEN
	lb_valid_date = lnvo_cst_datetime.of_isvalid(ldte_custom1_date)
	if NOT(lb_valid_date) then
		Messagebox("EDIT","Please enter a valid date")
		tab_case.SelectTab("tabpage_current")
		tab_case.tabpage_current.dw_current.SetColumn("pmr_custom1_date")
		tab_case.tabpage_current.dw_current.SetFocus()
		return -1
	end if
END IF

IF NOT (IsNull(ldte_custom2_date)) AND ((Date(ldte_custom2_date) <> Date("01/01/1900"))) THEN
	lb_valid_date = lnvo_cst_datetime.of_isvalid(ldte_custom2_date)
	if NOT(lb_valid_date) then
		Messagebox("EDIT","Please enter a valid date")
		tab_case.SelectTab("tabpage_current")
		tab_case.tabpage_current.dw_current.SetColumn("pmr_custom2_date")
		tab_case.tabpage_current.dw_current.SetFocus()
		return -1
	end if
END IF

IF NOT (IsNull(ldte_custom3_date)) AND ((Date(ldte_custom3_date) <> Date("01/01/1900"))) THEN
	lb_valid_date = lnvo_cst_datetime.of_isvalid(ldte_custom3_date)
	if NOT(lb_valid_date) then
		Messagebox("EDIT","Please enter a valid date")
		tab_case.SelectTab("tabpage_current")
		tab_case.tabpage_current.dw_current.SetColumn("pmr_custom3_date")
		tab_case.tabpage_current.dw_current.SetFocus()
		return -1
	end if
END IF
// FDG 01/14/01 end
// SAH 05/20/02 Track 2967 -End

//assign_to_user edits
ls_assign_to = trim(ls_assign_to)
If ls_assign_to = '' then
	SetNull(ldte_assign_date)
	ls_assign_date	=	string(ldte_assign_date,'mm/dd/yyyy')
	tab_case.tabpage_general.dw_general.SetColumn('case_asgn_date')
	tab_case.tabpage_general.dw_general.SetText(ls_assign_date)
	tab_case.tabpage_general.dw_general.acceptText()
Elseif Upper(ls_assign_to) = 'NONE' then
	MessageBox("EDIT","Please update the Assigned To edit box to a valid user")
	tab_case.SelectTab("tabpage_general")
	tab_case.tabpage_general.dw_general.SetColumn("case_asgn_id")
	tab_case.tabpage_general.dw_general.SetFocus()
	return -1
Else
  select count(*) into :ll_count
		from Users
		where user_id = Upper( :ls_assign_to )
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error Reading User Table')
		RETURN -1
	Elseif ll_count <= 0 then
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Committing to Stars2')
			Return -1
		End If	
		Messagebox('EDIT','Assigned User Does Not Exist')
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetColumn("case_asgn_id")
		tab_case.tabpage_general.dw_general.SetFocus()
		RETURN -1
	End If
	
	if IsNull(ldte_assign_date) or (ldte_assign_date = datetime('1/1/00 00:00:00')) then
		idt_assign_datetime = ldte_datetime
		ldte_assign_date = idt_assign_datetime
		tab_case.tabpage_general.dw_general.object.case_asgn_date[ll_row] = idt_assign_datetime
	else
		lb_valid_date = lnvo_cst_datetime.of_isvalid(ldte_assign_date)
		if NOT(lb_valid_date) then
			Messagebox("EDIT","Please enter a valid Assigned-To Date")
			tab_case.SelectTab("tabpage_general")
			tab_case.tabpage_general.dw_general.SetColumn("case_asgn_date")
			tab_case.tabpage_general.dw_general.SetFocus()
			return -1
		end if
	End If
	
	//	GaryR	09/05/01	Stars 4.8 - Begin
	IF ls_assign_to <> gc_user_id AND ls_assign_to <> is_asgn_to THEN
		ib_reassign = TRUE
		is_reasgn_to = ls_assign_to
		idt_assign_datetime = ldte_datetime
	ELSE
		ib_reassign = FALSE
	END IF
	//	GaryR	09/05/01	Stars 4.8 - End		
	
End If


//case_id edits
if lb_create then
	If trim(ls_case_id) = '' then
		
		//	GaryR	05/29/02	Track 3103d - Begin
		//	Obtain the next case_id value
		ls_case_id = fx_get_next_key_id( "CASE" )
		
		IF IsNull( ls_case_id ) OR Trim( ls_case_id ) = "" OR ls_case_id = "ERROR" THEN
			Messagebox('EDIT','Must Enter Case Id, Unable to Obtain System Number')
			tab_case.SelectTab("tabpage_general")
			tab_case.tabpage_general.dw_general.SetColumn("case_id")
			tab_case.tabpage_general.dw_general.SetFocus()
			gv_active_case = ''
			is_active_case = '' //NLG 4-25-00 keep is_active_case in sync with gv_active_case
			RETURN -1
		Else
			ls_case_spl = '00'
			ls_case_ver = '00'
			gv_active_case = ls_case_id + ls_case_spl + ls_case_ver
			is_active_case = gv_active_case //NLG 4-25-00 keep is_active_case in sync with gv_active_case
			tab_case.tabpage_general.dw_general.SetItem(ll_row,'case_id',ls_case_id)
			tab_case.tabpage_general.dw_general.SetItem(ll_row,'case_spl',ls_case_spl)
			tab_case.tabpage_general.dw_general.SetItem(ll_row,'case_ver',ls_case_ver)
		End If
		//	GaryR	05/29/02	Track 3103d - End
		
	Else//case_id not blank
			IF LEN(ls_case_id) >= 10 THEN
				ls_validate_case_id = ls_case_id
				li_rc = wf_validate_case_id(ls_validate_case_id)
				If li_rc <> 0 Then
					COMMIT using STARS2CA;
					If stars2ca.of_check_status() <> 0 Then
						errorbox(stars2ca,'Error Committing to Stars2')
						Return -1
					End If	
					Messagebox('EDIT','Case Id contains an invalid character.  Please Re-Key')
					tab_case.SelectTab("tabpage_general")
					tab_case.tabpage_general.dw_general.SetColumn("case_id")
					tab_case.tabpage_general.dw_general.SetFocus()
					gv_active_case = ''
					is_active_case = '' //NLG 4-25-00 keep is_active_case in sync with gv_active_case
					RETURN -1
				Else
					ls_case_spl = '00'
					ls_case_ver = '00'
					tab_case.tabpage_general.dw_general.SetItem(ll_row,'case_id',ls_case_id)
					tab_case.tabpage_general.dw_general.SetItem(ll_row,'case_spl',ls_case_spl)
					tab_case.tabpage_general.dw_general.SetItem(ll_row,'case_ver',ls_case_ver)
					gv_active_case = ls_case_id + ls_case_spl + ls_case_ver
					is_active_case = gv_active_case //NLG 4-25-00 keep is_active_case in sync with gv_active_case
				End If
			Else//len(case_id < 10)
				COMMIT using STARS2CA;
				If stars2ca.of_check_status() <> 0 Then
					errorbox(stars2ca,'Error Committing to Stars2')
					Return -1
				End If	
				Messagebox('EDIT','Case ID Must be 10 Positions')
				tab_case.SelectTab("tabpage_general")
				tab_case.tabpage_general.dw_general.SetColumn("case_id")
				tab_case.tabpage_general.dw_general.SetFocus()
				gv_active_case = ''
				is_active_case = '' //NLG 4-25-00 keep is_active_case in sync with gv_active_case
				RETURN -1
			End If//checking case_id length
	End If//checking if case_id is blank
end if//if lb_create

in_case_id = left(is_active_case,10)
in_case_spl = mid(is_active_case,11,2)
in_case_ver = mid(is_active_case,13,2)

if lb_create then
	//check case_cntl to see if case already exists
	Select  count(*) into :ll_count
		from  case_cntl
		where case_id = Upper( :in_case_id ) AND
				case_spl = Upper( :in_case_spl ) AND
				Case_ver = Upper( :in_case_ver )
	using stars2ca;
	If stars2ca.of_check_status() <> 0 then 
		Errorbox(stars2ca,'Cannot read case_cntl to verify existence')
		RETURN -1
	Elseif ll_count > 0 then
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Committing to Stars2')
			Return -1
		End If	
		Messagebox('ERROR','Case already exists. Please change case id.')
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetColumn("case_id")
		tab_case.tabpage_general.dw_general.SetFocus()
		gv_active_case = ''
		is_active_case = '' //NLG 4-25-00 keep is_active_case in sync with gv_active_case
		return -1
	End If
end if

// FDG 01/14/01 - Add 'Ready for PIMR' edits
IF	 ls_ready_cd		=	'Y'		THEN
	li_rc	=	This.Event	ue_edit_pimr()
	IF	li_rc	<	0			THEN
		This.Event	ue_reset_dates()
		Return	li_rc
	END IF
END IF

//insert default values into case_cntl datawindow for case create
if lb_create then
	tab_case.tabpage_general.dw_general.object.user_id[ll_row] = gc_user_id
	tab_case.tabpage_general.dw_general.object.case_datetime[ll_row] = idt_create_date//ldte_created_date
	tab_case.tabpage_general.dw_general.object.case_asgn_prio[ll_row] = ' '
	tab_case.tabpage_general.dw_general.object.refer_from_dept[ll_row] = ' '

	tab_case.tabpage_general.dw_general.object.refer_to_dept[ll_row] = ' '
	tab_case.tabpage_general.dw_general.object.refer_by_rep[ll_row] = ' '
	tab_case.tabpage_general.dw_general.object.refer_date[ll_row] = ldte_default_datetime
	tab_case.tabpage_general.dw_general.object.case_line_b[ll_row] = ' '
	tab_case.tabpage_general.dw_general.object.case_plan[ll_row] = ' '
	tab_case.tabpage_general.dw_general.object.case_trk_type[ll_row] = iv_track_type
	tab_case.tabpage_general.dw_general.object.case_disp_hold[ll_row] = 'HOLD'
	tab_case.tabpage_general.dw_general.object.op_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.amt_recv[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.balance_remaining_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.recovered_addtl_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.referred_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.amt_writeoff[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.custom1_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.custom2_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.custom3_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.custom4_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.custom5_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.custom6_amt[ll_row] = 0
	tab_case.tabpage_general.dw_general.object.case_from_period[ll_row] = ldte_from_period
	tab_case.tabpage_general.dw_general.object.case_to_period[ll_row] = ldte_to_period

	lb_log_created	=	TRUE													// FDG 09/20/01
	//	GaryR	07/29/02	Track 3215d
	ll_row_log	=	inv_case.uf_create_case_log( ll_row, TRUE )
	tab_case.tabpage_log.dw_log.object.case_id[ll_row_log] = in_case_id
	tab_case.tabpage_log.dw_log.object.case_spl[ll_row_log] = in_case_spl
	tab_case.tabpage_log.dw_log.object.case_ver[ll_row_log] = in_case_ver
	// FDG 09/20/01 end
end if

if lb_update then
	if in_case_status <> ls_case_status and ls_case_status = 'CL' then
		//Closing a case. First, check if this is first time case was closed.
		//If so, write additional case_log record for SYSORCLS.
		ll_count = 0
		select count(*) into :ll_count
		from Case_log
		where status 	= 'CL' and
				disp 		= 'SYSORCLS' and
				case_id 	= Upper( :in_case_id ) and
				case_spl = Upper( :in_case_spl ) and
				case_ver = Upper( :in_case_ver )
		using STARS2CA;
		if stars2ca.of_check_status() <> 0 then
			Errorbox(stars2ca,'Error Reading Case Log')
			RETURN -1
		End If
		
		if ll_count > 0 then
			ls_close_disp = 'SYSRECLS'
		else
			ls_close_disp = 'SYSORCLS'
		end if
		// FDG 09/20/01 begin - use inv_case to insert the default values into case_log
		lb_log_created	=	TRUE													// FDG 09/20/01
		ll_row_log	=	inv_case.uf_initialize_case_log (ll_row)		// FDG 09/20/01
		tab_case.tabpage_log.dw_log.object.case_id[ll_row_log] = in_case_id
		tab_case.tabpage_log.dw_log.object.case_spl[ll_row_log] = in_case_spl
		tab_case.tabpage_log.dw_log.object.case_ver[ll_row_log] = in_case_ver
		// FDG 09/20/01 end
		tab_case.tabpage_log.dw_log.object.status[ll_row_log] = ls_case_status
		tab_case.tabpage_log.dw_log.object.disp[ll_row_log] = ls_close_disp
		tab_case.tabpage_log.dw_log.object.status_desc[ll_row_log] = 'CASE CLOSED'
		tab_case.tabpage_log.dw_log.object.status_datetime[ll_row_log] = ldte_status_date
		tab_case.tabpage_log.dw_log.object.sys_datetime[ll_row_log] = ldte_status_date//ldte_created_date
	end if//if changing status to close the case

	li_rc	=	This.Event	ue_edit_case_log()
	// FDG 09/20/01 end

end if//if lb_update

// GaryR	01/09/01	Stars 4.7 DataBase Port			// FDG 04/16/01
IF Trim( ls_status_desc )  = "" THEN 
	li_rc	=	gnv_sql.of_TrimData (ls_status_desc)
END IF

if lb_create then
	//put a hold on this case
	gv_case_disp = 'MYHOLD'
	//	GaryR 07/24/01	Track 2373d - Begin
	gnv_sql.of_TrimData( ls_empty )
	Insert into Sys_Cntl
		(cntl_id,cntl_no,cntl_date,cntl_case,cntl_text)
 	Values
		(:gc_user_id,0,:ldte_status_date,:is_active_case,:ls_empty)
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(Stars2ca,'Unable to Update HOLD Status on Case')
		RETURN -1
	End If
	//	GaryR 07/24/01	Track 2373d - End
end if//lb_create

if lb_update then
	setMicrohelp(w_main,'Case Updated')
elseif lb_create then
	// JasonS 1/23/03 Begin - Track 3302d
	ld_userstatsdate = date(left(string(today()),2) + '/01/' + right(string(today()), 2))
	update User_Stats		// JasonS 03/14/03 Track 3302d
	set case_cnt = case_cnt + 1
	where stats_date = :ld_userstatsdate
	using stars2ca;
	stars2ca.of_commit()
	// JasonS 1/23/03 End - Track 3302d
	setMicrohelp(w_main,'Case Created')
end if

tab_case.tabpage_general.dw_general.object.case_id.protect = 1
tab_case.tabpage_current.dw_current.object.case_status_date.protect = 1
tab_case.tabpage_general.dw_general.object.dept_id.protect = 1
tab_case.tabpage_general.dw_general.object.case_business.protect = 0

tab_case.SelectTab("tabpage_general")
tab_case.tabpage_general.dw_general.SetColumn("case_desc")
tab_case.tabpage_general.dw_general.SetFocus()

//set instance variables
in_from = 'M'
in_case_cat = ls_case_cat
in_case_status = ls_case_status
in_case_disposition = ls_case_disp
in_case_status_user = gc_user_id
in_case_status_desc = ls_status_desc
in_case_status_date = date(ldte_status_date)
in_case_refer_to = ''

sv_referEnabled = TRUE

this.event ue_set_menu_refer(TRUE)

if ls_case_cat <> 'CA?' then
	this.event ue_set_menu_track(TRUE)
else
	this.event ue_set_menu_track(FALSE)
	this.event ue_set_menu_refer(FALSE)
end if

this.event ue_set_menu_create(FALSE)
this.event ue_set_menu_update(TRUE)
this.event ue_set_menu_more(TRUE)

If ls_case_cat = 'COM' and ls_case_status <> 'CL' then
	gv_from = 'CASE'
	opensheet(w_lead_maintain,MDI_Main_Frame,Help_Menu_Position,Layered!)
	this.event ue_set_menu_track(TRUE)
ElseIf ls_case_cat <> 'CA?' and ls_case_status <> 'CL' then
	gv_from = 'CASE'
	// FDG 02/14/01 - If opening Track Details, do not open Case Folder
	IF	NOT ib_open_track AND NOT ib_refer	THEN
		this.postevent("ue_open_case_folder")
	END IF
	// FDG 02/14/01 end
	this.event ue_set_menu_track(TRUE)
End If

setPointer(arrow!)
return 1
end event

event type integer ue_edit_period_dates();


boolean lb_rc
datetime	ldte_from, ldte_to
integer li_rc
string	ls_month,	&
			ls_day,		&
			ls_from,		&
			ls_to
long		ll_row


ll_row = tab_case.tabpage_general.dw_general.GetRow()
ldte_from = tab_case.tabpage_general.dw_general.GetItemDatetime(ll_row,"case_from_period")
ldte_to = tab_case.tabpage_general.dw_general.GetItemDatetime(ll_row,"case_to_period")


//'01/01/1900' is the default non-null date; will be edited below
IF NOT(IsNull(ldte_from)) AND ((date(ldte_from) <> date("01/01/1900"))) then
	N_cst_datetime lnvo_cst_datetime
	Lb_rc = lnvo_cst_datetime.of_isvalid(ldte_from)
	if NOT lb_rc then
		MessageBox("Error","Period From is not a valid date")
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetFocus()
		tab_case.tabpage_general.dw_general.SetColumn("case_from_period")
		return -1
	end if
End If

If NOT(IsNull(ldte_to)) AND ((date(ldte_to) <> date("01/01/1900"))) then
	lb_rc = lnvo_cst_datetime.of_isvalid(ldte_to)
	if NOT lb_rc then
		MessageBox("Error","Period To is not a valid date")
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetFocus()
		tab_case.tabpage_general.dw_general.SetColumn("case_to_period")
		return -1
	end if
End if

//if one of the dates is 'null', the other must be also
if ((date(ldte_from) = date("01/01/1900")) AND (date(ldte_to) <> date("01/01/1900"))) or &
	((date(ldte_to) = date("01/01/1900")) AND (date(ldte_from) <> date("01/01/1900")))  then 
		Messagebox('EDIT','You must specify both Period From and Period To')    
		tab_case.SelectTab("tabpage_general")
		tab_case.tabpage_general.dw_general.SetFocus()
		tab_case.tabpage_general.dw_general.SetColumn("case_from_period")
		RETURN -1
end if 
  
If ldte_from > ldte_to then
	Messagebox('EDIT','Period To must be greater than Period From')
	tab_case.SelectTab("tabpage_general")
	tab_case.tabpage_general.dw_general.SetFocus()
	tab_case.tabpage_general.dw_general.SetColumn("case_to_period")
	RETURN -1
End IF


return 0
end event

event ue_open_case_folder;// FDG 02/14/01	Stars 4.6 - PIMR.  If the window is saved while opening
//						Track Details window, do not open Case Folder

// FDG 02/14/01 begin
IF	ib_open_track		THEN
	Return	0
END IF
// FDG 02/14/01 end

opensheet(w_case_folder_view,MDI_Main_Frame,Help_Menu_Position,Layered!)
return 1
end event

event ue_scroll_tab;//*********************************************************************************
// Script Name: ue_scroll_tab	
//
//	Arguments: at_tab	- tab to be scrolled
//				  ai_scroll_value - argument to determine whether to scroll direction.
//						
//
// Returns:	none		
//
//	Description: This event will scroll the tab page forward or backward. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 NLG	Created Rls 4.5 TS2363
//
//*********************************************************************************

int li_tabpage
int num_tabs
int i
boolean b_test

li_tabpage	=	at_tab.SelectedTab


num_tabs = upperbound(at_tab.Control[])

//Add loop to handle multiple disabled tabs
for i = 1 to num_tabs
	li_tabpage  = li_tabpage + ai_scroll_value
	
	//go to beginning or end of tabs
	if li_tabpage = 0 then
		li_tabpage = num_tabs
	end if
	if li_tabpage > num_tabs then
		li_tabpage = 1
	end if
	
	at_tab.SelectTab (li_tabpage)
	If at_tab.Control[li_tabpage].enabled = TRUE then
		EXIT
	End if
next

end event

event ue_delete_case();//******************************************************************
//Script for W_Case_Maint - ue_delete_case
//******************************************************************
//Modifications:
//01-27-98 NLG 	4.0 subset redesign
//						1.	Before deleting, check if any subsets in case are being
//						used in any bg jobs
//						2.	Delete from PDQ tables if link_type = PDQ
//						3.	When deleting case subsets, call nvo_subset_functions.uf_delete_subset
// 09/01/98 AJS   FS362 convert case to case_cntl
// 11/12/98 FNC	Track 1942
//						1.Move delete of links to user events 
//						2.Delete case linked pdqs, rdms, rpts, med and cra's
//	01/12/99 NLG	TS2001c Stars 4.1 use server date, not pc date
//	01-12-99	AJS   FS1983d Stars 4.1 Do not delete case with pending jobs
// 01/09/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	01/14/01	FDG	Stars 4.6 - PIMR.  Add new PIMR data to case_log.
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	11/19/01	FDG	Stars 4.8.1.	Use inv_case to insert into case_log
// 1/23/03 JasonS Track 3302d update case_cnt in user stats
// 03/14/03 JasonS Track 3302d added an _ to table name
// 04/04/06 JasonS Track 4712d  Call ue_refresh_case() after deletion.....do not clear case out 
//******************************************************************
Datetime  lv_todays_date
Boolean   lv_reset_subset
int       lv_msg,lv_count
int		 li_rc 
long		 ll_rows, ll_idx
long		 ll_row
String    lv_subset_crit_id,lv_subset_id,lv_subset_name
string    lv_case_active
string    lv_case_cat
string    lv_case_dept
string	 ls_subset_id, ls_subset_name
string	 ls_case_id,ls_case_spl,ls_case_ver, ls_empty

date ld_userstatsdate	// JasonS 1/23/03 Track 3302d

n_ds ids_1

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ll_row = tab_case.tabpage_general.dw_general.GetRow()
ls_case_id	= Trim(tab_case.tabpage_general.dw_general.object.case_id[ll_row])	// FDG 04/16/01
ls_case_spl = tab_case.tabpage_general.dw_general.object.case_spl[ll_row]
ls_case_ver = tab_case.tabpage_general.dw_general.object.case_ver[ll_row]

gv_active_case = ls_case_id + ls_case_spl + ls_case_ver//trim(sle_case_id.text)
//setfocus(sle_case_id)
//cb_retrieve.default = true

lv_todays_date = gnv_app.of_get_server_date_time()

If gv_active_case = '' or len(gv_active_case) < 14 then	
	Messagebox('EDIT','Case ID is required')
	RETURN
End If

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 - end

lv_case_active = in_case_id + in_case_spl + in_case_ver
If gv_active_case <> lv_case_active then
	Messagebox('EDIT','Must First Retrieve Record before Deleting')
	//cb_delete.enabled = false
	im_general.m_menu.m_delete.enabled = FALSE
	RETURN
End If

lv_case_cat = tab_case.tabpage_general.dw_general.object.case_cat[ll_row]//left(ddlb_case_cat.text,3)

If	Not ((trim(gv_user_sl) = 'AD') or (trim(gv_user_sl) = 'SA')) then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	Messagebox('EDIT','Only Supervisor Of the Department ' & 
					+ 'Can Delete Case')
	//cb_delete.enabled = false
	im_general.m_menu.m_delete.enabled = FALSE
	RETURN
End If
	
//NLG 02-29-00 Message.StringParm is set to NULL in ue_preopen.  Prevented lv_msg from occurring.
//If message.stringparm <> 'DELETE' then						//NLG -- 02-29-00
	//KMM Clear out message parm (PB Bug)
//	SetNull(message.stringparm)									//NLG	-- 02-29-00
	lv_msg = Messagebox('CONFIRMATION','Delete This Case?',Question!,YesNO!)
	If lv_msg = 2 then 
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Committing to Stars2')
			Return
		End If	
 		Setmicrohelp(W_MAIN,'Delete Cancelled')
		RETURN
	End If
//Else																	//NLG -- 02-29-00
//	message.stringparm = ''											//NLG -- 02-29-00
//End If																	//NLG -- 02-29-00


//Need to clear the value in global active subset 
If trim(gc_active_subset_id) <> '' then	 
	Select count(*) into :lv_count
		from case_link
		where  case_id  = Upper( :in_case_id ) and 
				 case_spl = Upper( :in_case_spl ) and
				 case_ver = Upper( :in_case_ver ) and
				 link_type = 'SUB' and
				 link_key = Upper( :gc_active_subset_id )
	Using  stars2ca;
	If stars2ca.of_check_status() < 0 then 
		Errorbox(stars2ca,'ERROR Reading Case Link for active Subset')
		return
	Elseif lv_count > 0 then
			 lv_reset_subset = true
	End If
End If

li_rc = this.event ue_delete_subsets()
if li_rc <> 0 then return

li_rc = this.event ue_delete_pdqs()
if li_rc <> 0 then return

li_rc = this.event ue_delete_anal_criteria()
if li_rc <> 0 then return

li_rc = this.event ue_delete_reports('RPT')
if li_rc <> 0 then return

li_rc = this.event ue_delete_reports('MED')
if li_rc <> 0 then return

li_rc = this.event ue_delete_reports('RDM')
if li_rc <> 0 then return


Li_rc = this.event UE_Check_Bg_Step_Cntl_Case_Id()
If li_rc <> 0 then return

Update Case_CNTL
	set case_status = 'DL',
		 case_disp = 'SYSDELET',
		 case_updt_user   = :gc_user_id,
		 case_status_desc = 'Case Is Deleted',
		 case_status_date = :lv_todays_date,
		 CASE_DISP_HOLD   = :ls_empty							// 01/09/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;

If stars2ca.of_check_status() = 100 then 
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	Messagebox('ERROR','Case Not Found')
	//triggerevent(cb_clear,clicked!)

	//cb_delete.enabled = false
	im_general.m_menu.m_delete.enabled = FALSE
	return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Deleting From Case Id')
	RETURN
ElseIf isvalid(w_target_subset_maintain) then
		close(w_target_subset_maintain)
End If

// FDG 11/19/01 - Don't delete old case_log entries
////Delete Case Log
//Delete	from  case_log
//	where  case_id  = :in_case_id and 
//			 case_spl = :in_case_spl and
//			 case_ver = :in_case_ver 
//Using  stars2ca;
//If stars2ca.of_check_status() < 0 then 
//	Errorbox(stars2ca,'ERROR Deleting Case Log Table')
//	return
//End If

// FDG 01/14/01 - Add new PIMR data to Insert
// FDG 11/19/01 - Use inv_case to insert case_log.
//Insert into case_log
//		(case_id,case_spl,case_ver,
//		 status,disp,
//		 status_desc,status_datetime,
//		 User_id,sys_datetime,case_custom1_amt,case_custom2_amt,
//		 case_custom3_amt,identified_amt,future_savings_amt,
//		 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//		 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//		 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//		 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//		 pmr_case_custom4_amt,pmr_case_custom5_amt,
//		 pmr_case_custom6_amt,pmr_case_custom7_amt,
//		 pmr_case_custom8_amt,pmr_case_custom9_amt)
//	Values
//		(:in_case_id,:in_case_spl,:in_case_ver,
//		 'DL','SYSDELET','Case Is Deleted',:lv_todays_date,
//		 :gc_user_id,:lv_todays_date,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
//Using stars2ca;
//If stars2ca.of_check_status() <> 0 then 
//	//cb_close.default = true
//	Errorbox(stars2ca,'Error Inserting Case Log')
//	RETURN
//End If
li_rc	=	inv_case.uf_audit_log (in_case_id, in_case_spl, in_case_ver, 'Case Is Deleted')
// FDG 11/19/01 end


li_rc = this.event ue_delete_targets_tracks()
if li_rc <> 0 then return


//Delete Case Leads
Delete from Lead
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Leads from Table')
	return
End If

Delete from Notes
	where  note_rel_type  = 'CA' and
			 note_rel_id    = Upper( :lv_case_active )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Notes Table')
	return
End If
p_notes.visible = false
p_notes.enabled = false

Delete from Case_link
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Case Link Table')
	return
End If

If gv_case_disp = 'MYHOLD' and gv_active_case <> '' then//sle_case_id.text <> '' then
	Delete from Sys_Cntl
		where cntl_case = Upper( :gv_active_case )	//:sle_case_id.text
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(Stars2ca,'Unable to Update Retrieval Status on Case')
		RETURN
	End If
End IF
gv_case_disp = ''

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

//triggerevent(cb_clear,clicked!)
// Un-filter system codes
 idwc_case_disp.setfilter( "")
 idwc_case_disp.filter()
 idwc_case_status.setfilter( "")
 idwc_case_status.filter()
 // call refresh case to redisplay data and refresh headers
this.event ue_refresh_case()
//NLG 5-3-00 Track #2255 Don't retrieve log -- case window should be cleared
////	Re-retrieve the case_log data for this case because the 
////	delete process creates a log
//This.Event	ue_retrieve_log()
//tab_case.tabpage_log.enabled = TRUE


gv_target_subset_id = ''
gv_active_case = ''
is_active_case = gv_active_case
If lv_reset_SUBSET = true then
	gc_active_subset_id = ''
	gc_active_subset_name = ''
	gc_active_subset_case = ''
End IF

// JasonS 1/23/03 Begin - Track 3302d
ld_userstatsdate = date(left(string(today()),2) + '/01/' + right(string(today()), 2))
update User_Stats		// JasonS 03/14/03 Track 3302d
set case_cnt = case_cnt - 1
where stats_date = :ld_userstatsdate
using stars2ca;
stars2ca.of_commit()
// JasonS 1/23/03 End - Track 3302d

// disable updates
this.event ue_enable_update (FALSE)

setmicrohelp(w_main,'Case Deleted')

If isvalid(w_case_folder_view) then close(w_case_folder_view)
If isvalid(w_target_list) then close(w_target_list)
If isvalid(w_target_subset_maintain) then close(w_target_subset_maintain)
If isvalid(w_target_maintain) then close(w_target_maintain)
end event

event ue_reset_dates();//*********************************************************************************
// Script Name: ue_reset_dates	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event is called from ue_retrieve and ue_postopen.  It will reset 
//  				 the database acceptable value of 01/01/1900 back to 00/00/0000 for
//					 the user to view.
//		
//
//*********************************************************************************
//	
// 09/29/99 NLG	Created Rls 4.5 TS2363. Copy from w_track_maint
//	02/13/01	FDG	Stars 4.6 - PIMR.  Include PIMR dates
//	01/03/03	GaryR	Track 4816c	PB bug sets value to next visible field
//	08/31/05	GaryR	Track 4501d	PB10 bug - use blank to set date to 00/00/0000
//
//*********************************************************************************
date  ldt_default_datetime
ldt_default_datetime = date('01/01/1900')
long ll_current_row

ll_current_row = tab_case.tabpage_general.dw_general.GetRow()
//Hide null dates for created datetime
IF tab_case.tabpage_general.dw_general.Object.case_datetime.visible = "1" THEN
	if  date(tab_case.tabpage_general.dw_general.Object.case_datetime[ll_current_row]) = ldt_default_datetime then
				tab_case.tabpage_general.dw_general.SetColumn("case_datetime")
				tab_case.tabpage_general.dw_general.Settext("")
				tab_case.tabpage_general.dw_general.Accepttext()
				tab_case.tabpage_general.dw_general.SetItemStatus ( ll_current_row, "case_datetime", Primary!, NotModified!)
	end if
END IF

//Hide null dates for status datetime
IF tab_case.tabpage_current.dw_current.Object.case_status_date.visible = "1" THEN
	if date(tab_case.tabpage_current.dw_current.Object.case_status_date[ll_current_row]) = ldt_default_datetime then
		tab_case.tabpage_current.dw_current.SetColumn("case_status_date")
		tab_case.tabpage_current.dw_current.Settext("")
		tab_case.tabpage_current.dw_current.Accepttext()
		tab_case.tabpage_current.dw_current.SetItemStatus ( ll_current_row, "case_status_date", Primary!, NotModified!)
	end if
END IF

//Hide null dates for period from datetime
IF tab_case.tabpage_general.dw_general.Object.case_from_period.visible = "1" THEN
	if  date(tab_case.tabpage_general.dw_general.Object.case_from_period[ll_current_row]) = ldt_default_datetime then
				tab_case.tabpage_general.dw_general.SetColumn("case_from_period")
				tab_case.tabpage_general.dw_general.Settext("")
				tab_case.tabpage_general.dw_general.Accepttext()
				tab_case.tabpage_general.dw_general.SetItemStatus ( ll_current_row, "case_from_period", Primary!, NotModified!)
	end if
END IF

//Hide null dates for period to datetime
IF tab_case.tabpage_general.dw_general.Object.case_to_period.visible = "1" THEN
	if  date(tab_case.tabpage_general.dw_general.Object.case_to_period[ll_current_row]) = ldt_default_datetime then
				tab_case.tabpage_general.dw_general.SetColumn("case_to_period")
				tab_case.tabpage_general.dw_general.Settext("")
				tab_case.tabpage_general.dw_general.Accepttext()
				tab_case.tabpage_general.dw_general.SetItemStatus ( ll_current_row, "case_to_period", Primary!, NotModified!)
	end if
END IF

// FDG 02/13/01 begin
//Hide null dates for PIMR dates
IF tab_case.tabpage_current.dw_current.Object.pmr_custom1_date.visible = "1" THEN
	if date(tab_case.tabpage_current.dw_current.Object.pmr_custom1_date[ll_current_row]) = ldt_default_datetime then
		tab_case.tabpage_current.dw_current.SetColumn("pmr_custom1_date")
		tab_case.tabpage_current.dw_current.Settext("")
		tab_case.tabpage_current.dw_current.Accepttext()
		tab_case.tabpage_current.dw_current.SetItemStatus ( ll_current_row, "pmr_custom1_date", Primary!, NotModified!)
	end if
END IF

IF tab_case.tabpage_current.dw_current.Object.pmr_custom2_date.visible = "1" THEN
	if date(tab_case.tabpage_current.dw_current.Object.pmr_custom2_date[ll_current_row]) = ldt_default_datetime then
		tab_case.tabpage_current.dw_current.SetColumn("pmr_custom2_date")
		tab_case.tabpage_current.dw_current.Settext("")
		tab_case.tabpage_current.dw_current.Accepttext()
		tab_case.tabpage_current.dw_current.SetItemStatus ( ll_current_row, "pmr_custom2_date", Primary!, NotModified!)
	end if
END IF

IF tab_case.tabpage_current.dw_current.Object.pmr_custom3_date.visible = "1" THEN
	if date(tab_case.tabpage_current.dw_current.Object.pmr_custom3_date[ll_current_row]) = ldt_default_datetime then
		tab_case.tabpage_current.dw_current.SetColumn("pmr_custom3_date")
		tab_case.tabpage_current.dw_current.Settext("")
		tab_case.tabpage_current.dw_current.Accepttext()
		tab_case.tabpage_current.dw_current.SetItemStatus ( ll_current_row, "pmr_custom3_date", Primary!, NotModified!)
	end if
END IF
// FDG 02/13/01 end
end event

event ue_tracking;long ll_row

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Tracking Info Screen')

gv_active_case = is_active_case

ll_row = tab_case.tabpage_general.dw_general.GetRow()
iv_track_type = tab_case.tabpage_general.dw_general.object.case_type[ll_row]

Open (w_case_tracking)

If message.stringparm = 'Y' then
	//KMM Clear out message parm (PB Bug)
	SetNull(message.stringparm)
	opensheet (w_tracking_list,MDI_Main_Frame,Help_Menu_Position,Layered!)
End If

tab_case.tabpage_track.enabled = true
this.Event	ue_retrieve_track()

end event

event ue_refer_case();//////////////////////////////////////////////////////////////////////////////
//
// Pass info to the response window which deals with referral information...
//
//////////////////////////////////////////////////////////////////////////////
//
// FDG 02/09/01	Stars 4.6 - PIMR.  If the case is referred and the update RMM is
//						disabled, then don't allow any data entry
//	FDG 09/13/01	Stars 4.8.1.	Referral enhancements.  Use n_cst_case to copy the
//						data from the original case to the new case
//
// JasonS 07/11/02 Track 3143d ask user to save changes before referring case
//	GaryR	03/03/05	Track 4337d	Do not open Case Folder when referring case
//	GaryR	11/10/06	Track 4516	Do not refer Case that is flagged Ready for PIMR
//
//////////////////////////////////////////////////////////////////////////////

string lv_parameter,		ls_case_cat,	ls_msg, ls_case_id, ls_case_spl, ls_case_ver
Integer	li_rc				// FDG 09/13/01
Long		ll_row, &
			ll_button_response		// Track 3143d

ib_refer = TRUE

// Begin - Track 3143d
// If changes were made to current dw, check if they want to save them before referring
tab_case.tabpage_current.dw_current.accepttext()
tab_case.tabpage_general.dw_general.accepttext()

IF (tab_case.tabpage_current.dw_current.modifiedcount() > 0) OR (tab_case.tabpage_general.dw_general.modifiedcount() > 0) THEN
	ll_button_response = Messagebox("Save?", "Would you like to save changes to~r~nthe case before you refer it?", Question!, YesNo!)
	IF (ll_button_response = 1) THEN
		IF this.event ue_save() < 0 THEN Return
	else
		ll_row				= tab_case.tabpage_general.dw_general.getrow()
		ls_case_id 			= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_id')
		ls_case_spl 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_spl')
		ls_case_ver 		= tab_case.tabpage_general.dw_general.GetItemString(ll_row,'case_ver')

		tab_case.tabpage_current.dw_current.retrieve(ls_case_id, ls_case_spl, ls_case_ver)
		tab_case.tabpage_general.dw_general.retrieve(ls_case_id, ls_case_spl, ls_case_ver)
	END IF
END IF
// End - Track 3143d

ib_refer = FALSE

// Validate PIMR flag
ll_row = tab_case.tabpage_current.dw_current.GetRow()
IF tab_case.tabpage_current.dw_current.GetItemString( ll_row, "pmr_ready_cd" ) = "Y" THEN
	MessageBox( "Case Referral", "This Case can not be referred while it is flagged Ready for PIMR" + &
											"~n~r~n~rIf you need to conduct further analysis on this Case~n~r" + &
											"Please remove the Ready for PIMR flag on the Status tab.", Exclamation! )
	Return											
END IF

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Referral Info Screen')

ll_row				=	tab_case.tabpage_general.dw_general.GetRow()
ls_case_cat 		=	tab_case.tabpage_general.dw_general.GetItemString (ll_row, 'case_cat')

If sv_ReferEnabled Then
  lv_parameter = 'Enable'
Else
  lv_parameter = 'Disable'
End If

OpenWithParm (w_case_referral, lv_parameter)

sx_case_refer		lstr_case_refer
lstr_case_refer	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

IF	lstr_case_refer.b_case_referred	=	FALSE		THEN
	// Cancel clicked.  Get out
	Return
END IF

// Edit the User ID and case category to make sure the case isn't being referred to a 
//	secured department.
ls_msg	=	inv_case.uf_edit_case_security_user (ls_case_cat, lstr_case_refer.s_user_id)

IF	Trim(ls_msg)	>	' '		THEN
// Mike Fl 4/1/02 - Track 2933 - Begin
	MessageBox ('Referral Error', ls_msg)
// Mike Fl 4/1/02 - Track 2933 - End
	w_main.SetMicroHelp ('Case not referred.')
	Return
END IF

sv_ReferEnabled	=	TRUE

// Copy the data from the original case to the referred case
w_main.SetMicroHelp ('Copying the data to the referred case.  Please wait...')

li_rc		=	inv_case.Event	ue_refer_case (lstr_case_refer.s_dept_id,		&
														lstr_case_refer.s_user_id)
														
IF	li_rc	<	0		THEN
	w_main.SetMicroHelp ('Case not referred.')
	Return
END IF

MessageBox ('Case Referral', 'Case successfully referred.')

ib_disableclosequery	=	TRUE

// SAH 03/13/02 Track 2862
This.Event ue_edit_case_log()

Close (this) // FDG 09/13/01 end
end event

event ue_copy_case();datetime 	ldt_date_now
long 			ll_row,			&
				ll_rowcount

 
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

ldt_date_now = gnv_app.of_get_server_date_time()

//release hold on case
If gv_case_disp = 'MYHOLD' then
	Update Case_CNTL 
		set
			case_disp_hold	  = ' '
		Where		case_id	  = Upper( :in_case_id ) AND
					case_spl   = Upper( :in_case_spl ) AND
					case_ver   = Upper( :in_case_ver )
	Using  stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error writing case with original disposition')
		RETURN
	End If
	Delete from sys_cntl
		where cntl_id  = Upper( :gc_user_id ) and
				cntl_case = Upper( :is_active_case )
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error releasing hold lock on case')
		RETURN
	End If
	COMMIT USING STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error committing to Stars2')
		Return
	End If	
	//Need to close the subset target maintain window so that hold locks get released
	If isvalid(w_target_subset_maintain) then
		close(w_target_subset_maintain)
	End IF
End IF

tab_case.tabpage_general.dw_general.SetRedraw(FALSE)
ll_row = tab_case.tabpage_general.dw_general.GetRow()

tab_case.SelectTab("tabpage_general")
tab_case.tabpage_general.dw_general.SetColumn("case_id")
tab_case.tabpage_general.SetFocus()
tab_case.tabpage_general.dw_general.object.case_id.protect = 0


tab_case.tabpage_general.dw_general.setItem(ll_row,"case_id",'')
tab_case.tabpage_general.dw_general.setItem(ll_row,"case_spl",'00')
tab_case.tabpage_general.dw_general.setItem(ll_row,"case_ver",'00')
tab_case.tabpage_general.dw_general.setItem(ll_row,"user_id",gc_user_id)
tab_case.tabpage_current.dw_current.setItem(ll_row,"case_updt_user",gc_user_id)
tab_case.tabpage_current.dw_current.setItem(ll_row,"case_status_date",ldt_date_now)
tab_case.tabpage_general.dw_general.setItem(ll_row,"case_datetime",ldt_date_now)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"dept_id",gc_user_dept)
tab_case.tabpage_general.dw_general.object.dept_id.protect = 0
tab_case.tabpage_current.dw_current.object.case_status_desc.protect = 0
tab_case.tabpage_current.dw_current.object.case_status_date.protect = 0

//Set the datawindow flag to NewModified!, which triggers an insert of the 
//datawindow rather than an update.  This prevents copying over
//the case originally retrieved
tab_case.tabpage_general.dw_general.SetItemStatus(ll_row,0,Primary!,NewModified!)



gv_active_case = ''
gv_target_subset_id = ''
gv_case_target = ''
gv_case_disp = ''
is_active_case = ''
in_case_id             = ''
in_case_spl            = ''
in_case_ver            = ''
in_case_status         = ''
in_case_disposition    = ''
in_case_status_user    = ''
in_case_status_desc    = ''  
in_case_status_date    = date(ldt_date_now)
in_case_refer_to       = ''
in_track_exists        = false
iv_track_type          = ''
in_from 					  = 'N'

this.event ue_set_menu_create(TRUE)
this.event ue_set_menu_update(FALSE)
this.event ue_set_menu_track(FALSE)
this.event ue_set_menu_refer(FALSE)
this.event ue_set_menu_more(FALSE)
im_general.m_menu.m_retrieve.enabled = FALSE
im_general.m_menu.m_delete.enabled = FALSE

sv_ReferEnabled 	= false

p_notes.visible = false	
p_notes.enabled = false	

tab_case.SelectTab('tabpage_general')
tab_case.tabpage_general.dw_general.SetColumn('case_id')
tab_case.tabpage_general.dw_general.SetFocus()

tab_case.tabpage_general.dw_general.SetRedraw(TRUE)

setmicrohelp(W_main,'Ready')
setpointer(arrow!)
end event

event ue_initialize_case();//	AJS 	10/13/99	Disable retrieve for adding/new case
//	FDG	01/14/01	Stars 4.6 - PIMR.  Add new PIMR data.
// FDG	11/06/01	Stars 4.8.1.  Filter case_asgn_id based on default dept.

datetime ldte_default_date

int		li_rc

long 		ll_row,					&
			ll_rows

string	ls_default_date,		&
			ls_contractor_id,		&
			ls_empty


setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//li_rc = this.event closequery ()
//if li_rc = 1 then return

ls_empty						=	''											// FDG 04/16/01
li_rc							=	gnv_sql.of_trimdata(ls_empty)		// FDG 04/16/01

in_case_id             = ''
in_case_spl            = ''
in_case_ver            = ''
in_case_status         = ''
in_case_disposition    = ''
in_case_status_user    = ''
in_case_status_desc    = '' 
in_case_status_date    = gnv_app.of_get_server_date()
in_case_refer_to       = ''
in_track_exists        = false
iv_track_type          = ''
gv_active_case			  = ''
is_active_case = gv_active_case
gv_target_subset_id	  = ''			
GV_CASE_TARGET         = ''
// make the system think we've chosen to add a new case
//in_from = 'N'

ldte_default_date	=	DateTime (Date('1/1/1900'))		// FDG 01/14/01

this.event ue_set_menu_create(TRUE)
this.event ue_set_menu_update(FALSE)
this.event ue_set_menu_track(FALSE)
this.event ue_set_menu_refer(FALSE)
im_general.m_menu.m_delete.enabled = FALSE
im_general.m_menu.m_retrieve.enabled = TRUE

sv_ReferEnabled        	= false

//AJS 10/13/99 Disable retrieve for adding/new case
If in_from = 'A'  then
		//cb_create.default = true 
		//cb_retrieve.enabled=false
		im_general.m_menu.m_retrieve.enabled = FALSE
End If

li_rc = tab_case.tabpage_general.dw_general.reset()
ll_row = tab_case.tabpage_general.dw_general.InsertRow(0)
tab_case.tabpage_general.dw_general.ScrollToRow(ll_row)
tab_case.tabpage_general.dw_general.SetColumn("case_id")

tab_case.tabpage_general.dw_general.Object.dept_id.protect = 0
tab_case.tabpage_general.dw_general.object.case_id.protect = 0
tab_case.tabpage_general.dw_general.object.case_spl.protect = 0
tab_case.tabpage_general.dw_general.object.case_ver.protect = 0
tab_case.tabpage_general.dw_general.object.case_business.protect = 0
tab_case.tabpage_current.dw_current.object.case_status_desc.protect = 0
tab_case.tabpage_current.dw_current.object.case_status_date.protect = 0
tab_case.tabpage_current.dw_current.object.case_status.protect = 0

// FDG 04/16/01 - Empty string in SQL.  Use dw_general instead of dw_current & dw_savings
//						because of sharedata.
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_id",ls_empty)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_spl",ls_empty)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_ver",ls_empty)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_desc",ls_empty)
// FDG 08/24/01 - initialize case_cat to a space
//tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_cat",'CA?')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_cat",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_type",'PV')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_edit",ls_empty)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_datetime",in_case_status_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_asgn_date",in_case_status_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"user_id",gc_user_id)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"dept_id",gc_user_dept)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_asgn_id",gc_user_id)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_asgn_date",in_case_status_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_business",iv_bus_dflt)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_status",'OP')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_disp",'')
//tab_case.tabpage_current.dw_current.setItem(ll_row,"case_status_date",in_case_status_date)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_updt_user",gc_user_id)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_status_desc",'')
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"identified_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"future_savings_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"op_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"amt_recv",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"balance_remaining_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"recovered_addtl_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"referred_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"amt_writeoff",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"case_custom1_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"case_custom2_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"case_custom3_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"custom1_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"custom2_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"custom3_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"custom4_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"custom5_amt",0)
//tab_case.tabpage_savings.dw_savings.SetItem(ll_row,"custom6_amt",0)
//tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_status",'OP')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_disp",ls_empty)
tab_case.tabpage_general.dw_general.setItem(ll_row,"case_status_date",in_case_status_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_updt_user",gc_user_id)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_status_desc",ls_empty)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"identified_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"future_savings_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"op_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"amt_recv",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"balance_remaining_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"recovered_addtl_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"referred_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"amt_writeoff",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_custom1_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_custom2_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_custom3_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"custom1_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"custom2_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"custom3_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"custom4_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"custom5_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"custom6_amt",0)

// FDG 01/14/01 - Add PIMR Data
//tab_case.tabpage_general.dw_general.object.pmr_contractor_id [ll_row]	=	inv_case.uf_get_default_contractor()
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_ready_cd",'N')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_created_cd",'N')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_ready_date",ldte_default_date)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_created_date",ldte_default_date)
//tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_prov_type_cd",'1')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom1_cd",' ')
//tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom1_char",' ')
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom1_cnt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom2_cnt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom4_amt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom5_amt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom6_amt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom3_cnt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom4_cnt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom5_cnt",0)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom1_date",ldte_default_date)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom2_cd",' ')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom3_cd",' ')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_frd_rfrl_cd",'0')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_acpt_cd",'0')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_ready_user",' ')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_created_user",' ')
//tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_subject_id",' ')
//tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_prov_spec",' ')
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom7_amt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom8_amt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom9_amt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom6_cnt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom7_cnt",0)
//tab_case.tabpage_pimr.dw_pimr.SetItem(ll_row,"pmr_case_custom8_cnt",0)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom2_char",' ')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom4_cd",' ')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom5_cd",' ')
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom2_date",ldte_default_date)
//tab_case.tabpage_current.dw_current.SetItem(ll_row,"pmr_custom3_date",ldte_default_date)
tab_case.tabpage_general.dw_general.object.pmr_contractor_id [ll_row]	=	inv_case.uf_get_default_contractor()
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_ready_cd",'N')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_created_cd",'N')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_ready_date",ldte_default_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_created_date",ldte_default_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_prov_type_cd",'1')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom1_cd",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom1_char",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom1_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom2_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom4_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom5_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom6_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom3_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom4_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom5_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom1_date",ldte_default_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom2_cd",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom3_cd",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_frd_rfrl_cd",'0')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_acpt_cd",'0')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_ready_user",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_created_user",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_subject_id",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"case_prov_spec",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom7_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom8_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom9_amt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom6_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom7_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_case_custom8_cnt",0)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom2_char",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom4_cd",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom5_cd",' ')
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom2_date",ldte_default_date)
tab_case.tabpage_general.dw_general.SetItem(ll_row,"pmr_custom3_date",ldte_default_date)
// FDG 01/14/01 - end	

this.event ue_reset_dates()

This.Event	ue_filter_userid (gc_user_dept)			// FDG 11/06/01

tab_case.tabpage_general.dw_general.AcceptText()
tab_case.tabpage_current.dw_current.AcceptText()
tab_case.tabpage_savings.dw_savings.AcceptText()
tab_case.tabpage_pimr.dw_pimr.AcceptText()			// FDG 01/14/01

tab_case.tabpage_general.dw_general.SetItemStatus(ll_row,0,Primary!,NotModified!)
tab_case.tabpage_current.dw_current.SetItemStatus(ll_row,0,Primary!,NotModified!)
tab_case.tabpage_savings.dw_savings.SetItemStatus(ll_row,0,Primary!,NotModified!)
tab_case.tabpage_pimr.dw_pimr.SetItemStatus(ll_row,0,Primary!,NotModified!)			// FDG 01/14/01

// FDG 01/14/01 - Hide/display pmr_ready_date and pmr_created_date
This.Event	ue_display_ready_cd()

p_notes.visible = false 
p_notes.enabled = false 

this.event ue_set_menu_more(FALSE)

tab_case.tabpage_log.enabled	=	FALSE
tab_case.tabpage_track.enabled	=	FALSE
tab_case.tabpage_savings.enabled	=	TRUE

tab_case.SelectTab('tabpage_general')
tab_case.tabpage_general.dw_general.SetColumn('case_id')
tab_case.tabpage_general.dw_general.SetFocus()

setpointer(arrow!)
end event

event ue_set_menu_more;
im_general.m_menu.m_more.enabled = ab_state
im_current.m_menu.m_more.enabled = ab_state
im_savings.m_menu.m_more.enabled = ab_state
im_pimr.m_menu.m_more.enabled = ab_state		// FDG 02/16/01
im_log.m_menu.m_more.enabled = ab_state
im_track.m_menu.m_more.enabled = ab_state

return 1
end event

event ue_set_menu_refer;

im_general.m_menu.m_refercase.enabled = ab_state
im_current.m_menu.m_refercase.enabled = ab_state
im_savings.m_menu.m_refercase.enabled = ab_state
im_pimr.m_menu.m_refercase.enabled = ab_state		// FDG 02/16/01
im_log.m_menu.m_refercase.enabled = ab_state
im_track.m_menu.m_refercase.enabled = ab_state

return 1
end event

event ue_set_menu_track;
im_general.m_menu.m_createtrack.enabled = ab_state
im_current.m_menu.m_createtrack.enabled = ab_state
im_savings.m_menu.m_createtrack.enabled = ab_state
im_pimr.m_menu.m_createtrack.enabled = ab_state		// FDG 02/16/01
im_log.m_menu.m_createtrack.enabled = ab_state
im_track.m_menu.m_createtrack.enabled = ab_state

RETURN 1
end event

event ue_set_menu_update;im_general.m_menu.m_update.enabled = ab_state
im_savings.m_menu.m_update.enabled = ab_state
im_pimr.m_menu.m_update.enabled = ab_state		// FDG 02/16/01
im_current.m_menu.m_update.enabled = ab_state

return 1
end event

event ue_set_menu_create;im_general.m_menu.m_create.enabled = ab_state
im_current.m_menu.m_create.enabled = ab_state
im_savings.m_menu.m_create.enabled = ab_state
im_pimr.m_menu.m_create.enabled = ab_state		// FDG 02/16/01

return 1
end event

event ue_close;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

gv_from = ''
close(this)
end event

event ue_postclose;//destroy the 6 menus
if isvalid(im_general) then Destroy im_general 
if isvalid(im_current) then Destroy im_current 
if isvalid(im_savings) then Destroy im_savings
if isvalid(im_pimr) then Destroy im_pimr		// FDG 02/16/01
if isvalid(im_log) then Destroy im_log
if isValid(im_track) then Destroy im_track

//destroy the nvos
if IsValid(inv_case) then destroy inv_case
if IsValid(inv_log) then destroy inv_log

if IsValid(inv_sys_cntl) then Destroy(inv_sys_cntl)	
end event

event ue_set_window_title;this.title = is_title + " " +  is_active_case
end event

event ue_notes;//======================================================================================
//w_case_maint::ue_notes
//Modifications:
//05-12-98	NLG	1.	replace notes globals with notes nvo
//09/01/98  AJS   FS362 convert case to case_cntl
//======================================================================================

datetime lv_datetime
string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Case Notes')
If trim(is_active_case) = '' then
	Messagebox('EDIT','Enter Case Id')
	//setfocus(w_case_maint.sle_case_id)
	RETURN
End IF

lv_case_id = left(is_active_case,10)
lv_case_spl = mid(is_active_case,11,2)
lv_case_ver = mid(is_active_case,13,2)

// 09/01/98 AJS   FS362 convert case to case_cntl
select case_datetime into :lv_datetime
		from case_CNTL
		where case_id = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	Messagebox ('EDIT','Case must exist on Database to add a NOTE')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
			Errorbox(stars2ca,'Error Reading Case_cntl')
			RETURN
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

n_cst_notes lnv_notes

lnv_notes.is_notes_from = 'CA'
lnv_notes.is_notes_rel_id = is_active_case
lnv_notes.idt_notes_date   = date(lv_datetime)
OPENSheetwithParm(W_NOTES_LIST,lnv_notes,MDI_Main_Frame,Help_Menu_Position,Layered!)

end event

event type integer ue_edit_pimr();//////////////////////////////////////////////////////////////////
//
//	Script:		w_case_maint.ue_edit_pimr
//
//	Arguments:	None
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Edit error
//
//	Description:
//				This script is triggered when pmr_ready_cd is changed to
//				"Ready for PIMR".  This script will perform the edits
//				required in order to create the PIMR file.
//
//				All edits will be performed and the error message will
//				include the text for all errors.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	01/14/01	Stars 4.6 (PIMR).  Created.
//	FDG	05/14/01	Stars 4.6 (SP1).  Only change the pmr_ready_date if 
//						pmr_ready_cd is changed to 'Y'
// SAH   01/02/02 Stars 4.8.1. Removed edit on referral reason Track 2726
//	GaryR	05/02/05	Track 4357d	Update PIMR file layout per CMS specifications
//	GaryR 08/31/06	Track 4746	Change error to warning when Paid Amt > Billed Amt
//	GaryR	03/13/07	Track 4746	Allow user to cancel the update with warnings
//////////////////////////////////////////////////////////////////

Datetime	ldtm_custom1_date

Long		ll_row,						&
			ll_case_custom1_cnt,		&
			ll_case_custom2_cnt,		&
			ll_case_custom3_cnt,		&
			ll_case_custom4_cnt,		&
			ll_case_custom5_cnt,		&
			ll_case_custom7_cnt

String	ls_msg,						&
			ls_header,					&
			ls_header2,					&
			ls_contractor_id,			&
			ls_prov_type_cd,			&
			ls_frd_rfrl_cd,			&
			ls_case_cat,				&
			ls_custom1_cd,				&
			ls_custom2_cd,				&
			ls_custom3_cd
			
Decimal	ldc_case_custom4_amt,	&
			ldc_case_custom5_amt,	&
			ldc_case_custom6_amt,	&
			ldc_case_custom7_amt,	&
			ldc_case_custom8_amt,	&
			ldc_identified_amt,		&
			ldc_future_savings_amt,	&
			ldc_op_amt,					&
			ldc_amt_recv

Boolean	lb_error

ll_row	=	tab_case.tabpage_general.dw_general.GetRow()

ll_case_custom1_cnt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom1_cnt [ll_row]
ll_case_custom2_cnt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom2_cnt [ll_row]
ll_case_custom3_cnt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom3_cnt [ll_row]
ll_case_custom4_cnt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom4_cnt [ll_row]
ll_case_custom5_cnt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom5_cnt [ll_row]
ll_case_custom7_cnt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom7_cnt [ll_row]
ldtm_custom1_date			=	tab_case.tabpage_current.dw_current.object.pmr_custom1_date [ll_row]
ls_contractor_id			=	tab_case.tabpage_general.dw_general.object.pmr_contractor_id [ll_row]
ls_case_cat					=	tab_case.tabpage_general.dw_general.object.case_cat [ll_row]
ls_prov_type_cd			=	tab_case.tabpage_general.dw_general.object.pmr_prov_type_cd [ll_row]
ls_custom1_cd				=	tab_case.tabpage_current.dw_current.object.pmr_custom1_cd [ll_row]
ls_custom2_cd				=	tab_case.tabpage_pimr.dw_pimr.object.pmr_custom2_cd [ll_row]
ls_custom3_cd				=	tab_case.tabpage_current.dw_current.object.pmr_custom3_cd [ll_row]
ls_frd_rfrl_cd				=	tab_case.tabpage_current.dw_current.object.pmr_frd_rfrl_cd [ll_row]
ldc_case_custom4_amt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom4_amt [ll_row]
ldc_case_custom5_amt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom5_amt [ll_row]
ldc_case_custom6_amt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom6_amt [ll_row]
ldc_case_custom7_amt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom7_amt [ll_row]
ldc_case_custom8_amt		=	tab_case.tabpage_pimr.dw_pimr.object.pmr_case_custom8_amt [ll_row]
ldc_identified_amt		=	tab_case.tabpage_savings.dw_savings.object.identified_amt [ll_row]
ldc_future_savings_amt	=	tab_case.tabpage_savings.dw_savings.object.future_savings_amt [ll_row]
ldc_op_amt					=	tab_case.tabpage_savings.dw_savings.object.op_amt [ll_row]
ldc_amt_recv				=	tab_case.tabpage_savings.dw_savings.object.amt_recv [ll_row]

// amt_recv	must be <= op_amt
IF	 ldc_amt_recv	<=	ldc_op_amt		THEN
ELSE
	ls_header	=	tab_case.tabpage_savings.dw_savings.Describe('amt_recv_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_savings.dw_savings.Describe('op_amt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be < "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_savings')
		tab_case.tabpage_savings.dw_savings.SetColumn ('op_amt')
		tab_case.tabpage_savings.dw_savings.SetFocus()
	END IF
	lb_error	=	TRUE
	MessageBox ('Ready for PIMR Error', ls_msg + 'Please correct this error for the track(s) '	+	&
					'before proceeding to make this case Ready for PIMR.')
	Return	-1
END IF

// Contractor ID is required
IF	IsNull (ls_contractor_id)					&
OR	Trim (ls_contractor_id)		<=	' '		THEN
	ls_header	=	tab_case.tabpage_general.dw_general.Describe('pmr_contractor_id_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" is required."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_general')
		tab_case.tabpage_general.dw_general.SetColumn ('pmr_contractor_id')
		tab_case.tabpage_general.dw_general.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

//	case_cat (category) is required
IF	IsNull( ls_case_cat ) OR Trim( ls_case_cat ) = "" THEN
	ls_header	=	tab_case.tabpage_general.dw_general.Describe('case_cat_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" is required."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_general')
		tab_case.tabpage_general.dw_general.SetColumn ('case_cat')
		tab_case.tabpage_general.dw_general.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// Prov Type is required
IF	IsNull (ls_prov_type_cd)					&
OR	Trim (ls_prov_type_cd)		<=	' '		THEN
	ls_header	=	tab_case.tabpage_general.dw_general.Describe('pmr_prov_type_cd_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" is required."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_general')
		tab_case.tabpage_general.dw_general.SetColumn ('pmr_prov_type_cd')
		tab_case.tabpage_general.dw_general.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// Date Rec Reqst is required
IF	IsNull (ldtm_custom1_date)									&
OR	Date (ldtm_custom1_date)	<=	Date ('1/1/1900')		THEN
	ls_header	=	tab_case.tabpage_current.dw_current.Describe('pmr_custom1_date_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" is required."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_current')
		tab_case.tabpage_current.dw_current.SetColumn ('pmr_custom1_date')
		tab_case.tabpage_current.dw_current.SetFocus()
	END IF
	lb_error	=	TRUE
ELSE
	// Date Rec Reqst cannot be future dated
	IF	ldtm_custom1_date	>	gnv_app.of_get_server_date_time()	THEN
		ls_header	=	tab_case.tabpage_current.dw_current.Describe('pmr_custom1_date_t.text')
		ls_header	=	This.wf_remove_colon (ls_header)
		ls_msg		=	ls_msg	+	ls_header	+	" cannot be a future date."	+	"~r~n"
		IF	lb_error	=	FALSE		THEN
			tab_case.SelectTab ('tabpage_current')
			tab_case.tabpage_current.dw_current.SetColumn ('pmr_custom1_date')
			tab_case.tabpage_current.dw_current.SetFocus()
		END IF
		lb_error	=	TRUE
	END IF
END IF

// Activity Type is required
IF	IsNull (ls_custom1_cd)						&
OR	Trim (ls_custom1_cd)		<=	' '			THEN
	ls_header	=	tab_case.tabpage_current.dw_current.Describe('pmr_custom1_cd_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" is required."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_current')
		tab_case.tabpage_current.dw_current.SetColumn ('pmr_custom1_cd')
		tab_case.tabpage_current.dw_current.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

//	identified_amt (identified amount) must be > 0
IF	ldc_identified_amt	>	0		THEN
ELSE
	ls_header	=	tab_case.tabpage_savings.dw_savings.Describe('identified_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" must be > 0."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_savings')
		tab_case.tabpage_savings.dw_savings.SetColumn ('identified_amt')
		tab_case.tabpage_savings.dw_savings.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom1_cnt (# claims reviewed) must be > 0
IF	ll_case_custom1_cnt	>	0		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom1_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" must be > 0."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom1_cnt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom2_cnt (# lines reviewed) must be >= pmr_case_custom1_cnt (# claims reviewed)
IF	 ll_case_custom2_cnt	>=	ll_case_custom1_cnt		&
AND ll_case_custom1_cnt	>	0								THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom2_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom1_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be >= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom2_cnt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom4_amt (total billed amt) must be > 0
IF	ldc_case_custom4_amt	>	0		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" must be > 0."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom4_amt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom5_amt (total allowed amt) must be > 0
IF	ldc_case_custom5_amt	>	0		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	ls_header	+	" must be > 0."	+	"~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom5_amt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// Warning pmr_case_custom5_amt (total allowed amt) must be <= pmr_case_custom4_amt (total billed amt)
IF	 ldc_case_custom5_amt	<=	ldc_case_custom4_amt		&
AND ldc_case_custom4_amt	>	0								THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_amt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	"Warning: "	+	ls_header	+	" should be <= "	+	ls_header2	+	" on Part B claims.~r~n"
END IF

//	pmr_case_custom5_amt (total allowed amt) must be >= pmr_case_custom6_amt (total amount paid)
IF ldc_case_custom5_amt >= ldc_case_custom6_amt THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom6_amt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be >= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom5_amt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom3_cnt (# lines denied) must be <= pmr_case_custom2_cnt (# lines reviewed)
IF	 ll_case_custom3_cnt	<=	ll_case_custom2_cnt		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom3_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom2_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be <= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom3_cnt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom8_amt (amount denied) must be <= pmr_case_custom5_amt (ttl billed amt)
IF	 ldc_case_custom8_amt	<=	ldc_case_custom5_amt		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom8_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_amt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be <= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom8_amt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// If pmr_case_custom8_amt (amount denied) > 0, then op_amt must be <= pmr_case_custom8_amt
//	and pmr_case_custom4_amt (total paid amount) must be > 0
IF	ldc_case_custom8_amt	>	0			THEN
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom8_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_savings.dw_savings.Describe('op_amt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	IF	ldc_op_amt		<=	ldc_case_custom8_amt		THEN
		// If pmr_case_custom8_amt (amount denied) > 0, then op_amt should be > 0 (Display warning)
		IF	ldc_op_amt	=	0								THEN
			ls_msg		=	ls_msg	+	"Warning: Since "	+	ls_header	+	" > 0, then "	+	ls_header2	+	&
								" should be > 0.  You may need to go to the Track Details window to enter "	+	&
								ls_header2	+	".~r~n"
		END IF
	END IF
	//	pmr_case_custom4_amt (total paid amount) must be > 0
	IF	ldc_case_custom4_amt	=	0			THEN
		ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_amt_t.text')
		ls_header2	=	This.wf_remove_colon (ls_header2)
		ls_msg		=	ls_msg	+	"Since "	+	ls_header	+	" > 0, then "	+	ls_header2	+	&	
							" must be > 0"	+	".~r~n"
		IF	lb_error	=	FALSE		THEN
			tab_case.SelectTab ('tabpage_pimr')
			tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom4_amt')
			tab_case.tabpage_pimr.dw_pimr.SetFocus()
		END IF
		lb_error	=	TRUE
	END IF
END IF

// If pmr_case_custom3_cnt (# lines denied) > 0, then pmr_case_custom8_amt (amt denied) should be > 0
// This is a warning message.
IF	 ll_case_custom3_cnt		>	0				&
AND ldc_case_custom8_amt	=	0				THEN
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom8_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom3_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	"Warning: "	+	ls_header	+	" should be > 0 since "	+	ls_header2	+	" is > 0.~r~n"
END IF

// pmr_case_custom4_cnt (# claims reversed) must be <= pmr_case_custom1_cnt (# claims reviewed)
IF	 ll_case_custom4_cnt	<=	ll_case_custom1_cnt		THEN
	// If pmr_case_custom4_cnt > 0, then display a warning message
	IF	ll_case_custom4_cnt	>	0			THEN
		ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_cnt_t.text')
		ls_header	=	This.wf_remove_colon (ls_header)
		ls_msg		=	ls_msg	+	"Warning: "	+	ls_header	+	" is > 0"	+	".~r~n"
	END IF
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom1_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be <= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom4_cnt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom5_cnt (# lines reversed) must be <= pmr_case_custom3_cnt (# lines denied)
IF	 ll_case_custom5_cnt	<=	ll_case_custom3_cnt		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom3_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be <= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom5_cnt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

//	pmr_case_custom7_cnt is required and must be > 0
IF IsNull( ll_case_custom7_cnt ) THEN
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom7_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_msg		=	ls_msg	+	"Warning: "	+	ls_header	+	" is required"	+	".~r~n"
ELSE
	IF ll_case_custom7_cnt < 1 THEN
		ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom7_cnt_t.text')
		ls_header	=	This.wf_remove_colon (ls_header)
		ls_msg		=	ls_msg	+	ls_header	+	" must be > 0"	+	".~r~n"
		IF	lb_error	=	FALSE		THEN
			tab_case.SelectTab ('tabpage_pimr')
			tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom7_cnt')
			tab_case.tabpage_pimr.dw_pimr.SetFocus()
		END IF
		lb_error	=	TRUE
	END IF
END IF

// pmr_case_custom5_cnt (# lines reversed) must be >= pmr_case_custom4_cnt (# claims reversed)
IF	 ll_case_custom5_cnt	>=	ll_case_custom4_cnt		THEN
	// If pmr_case_custom5_cnt > 0, then display a warning message
	IF	ll_case_custom5_cnt	>	0			THEN
		ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_cnt_t.text')
		ls_header	=	This.wf_remove_colon (ls_header)
		ls_msg		=	ls_msg	+	"Warning: "	+	ls_header	+	" is > 0"	+	".~r~n"
	END IF
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_cnt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be >= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom5_cnt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// pmr_case_custom7_amt (amount reversed) must be <= pmr_case_custom5_amt (total allowed amount)
IF	 ldc_case_custom7_amt	<=	ldc_case_custom5_amt		THEN
ELSE
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom7_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom5_amt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be <= "	+	ls_header2	+	".~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom7_amt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

// If pmr_case_custom4_cnt (# claims reversed) > 0, then pmr_case_custom7_amt (amount reversed) must be > 0
IF	 ll_case_custom4_cnt		>	0				&
AND ldc_case_custom7_amt	=	0				THEN
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom7_amt_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom4_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" must be > 0 since "	+	ls_header2	+	" is > 0.~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_case_custom7_amt')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
ELSE
	// If pmr_case_custom7_amt (amount reversed) > 0, then display a warning message
	IF	ldc_case_custom7_amt	>	0			THEN
		ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom7_amt_t.text')
		ls_header	=	This.wf_remove_colon (ls_header)
		ls_msg		=	ls_msg	+	"Warning: "	+	ls_header	+	" is > 0"	+	".~r~n"
	END IF
END IF

// If pmr_case_custom3_cnt (# lines denied) > 0, then pmr_custom2_cd (resaon denied) must be entered
IF	 ll_case_custom3_cnt		>	0											&
AND (IsNull(ls_custom2_cd)  OR  Trim(ls_custom2_cd) < ' ')		THEN
	ls_header	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_custom2_cd_t.text')
	ls_header	=	This.wf_remove_colon (ls_header)
	ls_header2	=	tab_case.tabpage_pimr.dw_pimr.Describe('pmr_case_custom3_cnt_t.text')
	ls_header2	=	This.wf_remove_colon (ls_header2)
	ls_msg		=	ls_msg	+	ls_header	+	" is required since "	+	ls_header2	+	" is > 0.~r~n"
	IF	lb_error	=	FALSE		THEN
		tab_case.SelectTab ('tabpage_pimr')
		tab_case.tabpage_pimr.dw_pimr.SetColumn ('pmr_custom2_cd')
		tab_case.tabpage_pimr.dw_pimr.SetFocus()
	END IF
	lb_error	=	TRUE
END IF

//	If pmr_frd_rfrl_cd = 1, then pmr_custom3_cd (referral reason) is required
IF ls_frd_rfrl_cd = "1" THEN
	IF IsNull( ls_custom3_cd ) OR Trim( ls_custom3_cd ) = "" THEN
		ls_header	=	tab_case.tabpage_current.dw_current.Describe('pmr_custom3_cd_t.text')
		ls_header	=	This.wf_remove_colon (ls_header)
		ls_header2	=	tab_case.tabpage_current.dw_current.Describe('pmr_frd_rfrl_cd_t.text')
		ls_header2	=	This.wf_remove_colon (ls_header2)
		ls_msg		=	ls_msg	+	ls_header	+	" is required since "	+	ls_header2	+	" is checked.~r~n"
		IF	lb_error	=	FALSE		THEN
			tab_case.SelectTab ('tabpage_current')
			tab_case.tabpage_current.dw_current.SetColumn ('pmr_frd_rfrl_cd')
			tab_case.tabpage_current.dw_current.SetFocus()
		END IF
		lb_error	=	TRUE
	END IF
END IF

//	Display message
IF	Trim (ls_msg)	>	' '		THEN
	IF	lb_error		THEN
		MessageBox ('Ready for PIMR Error(s) - Each error is listed', ls_msg)
		Return	-1
	ELSE
		//	Allow user to cancel
		IF MessageBox ('Warning', ls_msg + "~n~rPress OK to ignore the warning(s) and " + &
								"update the Case.~n~rPress Cancel to make changes before " + &
								"updating the Case.", Exclamation!, OkCancel! ) <> 1 THEN Return -1
	END IF
END IF

is_save_successful_msg	=	'Case saved successfully.  This case will be added to the next PIMR file.'
Return	1
end event

event ue_display_help_buttons();//*********************************************************************************
// Script Name:	ue_display_help_buttons
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event will determine which help buttons will be displayed
//						on each of the datawindows.
//
//*********************************************************************************
//	
// 01/18/01	FDG	Stars 4.6 (PIMR) - Created
//	05/02/01	FDG	Stars 4.7.	Let wf_display_help_button return a modify
//						string for efficiency.
//
//*********************************************************************************
Long		ll_rowcount

String	ls_rc,			&
			ls_temp_mod,	&
			ls_modify

// Retrieve the data from stars_win_parm
ids_win_parm	=	CREATE	n_ds
ids_win_parm.DataObject	=	'd_case_stars_win_parm'
ids_win_parm.SetTransObject (Stars2ca)
ll_rowcount	=	ids_win_parm.Retrieve()

// Process dw_general
ls_modify	=	''
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_id')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_desc')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'pmr_custom1_char')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'pmr_subject_id')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'pmr_contractor_id')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_type')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_cat')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'dept_id')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_business')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_date_recv')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_asgn_id')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_edit')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_from_period')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'case_prov_spec')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_general.dw_general, 'pmr_prov_type_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_modify	=	Trim (ls_modify)

IF	Len (ls_modify)	>	0		THEN
	ls_rc	=	tab_case.tabpage_general.dw_general.Modify (ls_modify)
END IF

// Process dw_current
ls_modify	=	''
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'case_disp')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'case_status')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'case_status_desc')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'case_status_date')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom1_date')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_frd_rfrl_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_created_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_ready_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_ready_date')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_acpt_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom3_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom1_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom2_char')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom4_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom5_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom2_date')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_current.dw_current, 'pmr_custom3_date')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_modify	=	Trim (ls_modify)

IF	Len (ls_modify)	>	0		THEN
	ls_rc	=	tab_case.tabpage_current.dw_current.Modify (ls_modify)
END IF

// Process dw_savings
ls_modify	=	''
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'identified_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'future_savings_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'op_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'amt_recv')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'balance_remaining_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'recovered_addtl_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'referred_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'amt_writeoff')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'case_custom1_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'case_custom2_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'case_custom3_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'custom1_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'custom2_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'custom3_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'custom4_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'custom5_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_savings.dw_savings, 'custom6_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_modify	=	Trim (ls_modify)

IF	Len (ls_modify)	>	0		THEN
	ls_rc	=	tab_case.tabpage_savings.dw_savings.Modify (ls_modify)
END IF

// Process dw_pimr
ls_modify	=	''
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom4_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom5_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom6_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom7_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom8_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom9_amt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom1_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom2_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom3_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom4_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom5_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom6_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom7_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_case_custom8_cnt')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_temp_mod	=	This.wf_display_help_button (tab_case.tabpage_pimr.dw_pimr, 'pmr_custom2_cd')
ls_modify	=	ls_modify	+	ls_temp_mod
ls_modify	=	Trim (ls_modify)

IF	Len (ls_modify)	>	0		THEN
	ls_rc	=	tab_case.tabpage_pimr.dw_pimr.Modify (ls_modify)
END IF


Destroy	ids_win_parm
end event

event ue_display_ready_cd();//////////////////////////////////////////////////////////////////
//
//	Script:		w_case_maint.ue_display_ready_cd
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//				This script is triggered when pmr_ready_cd is changed to
//				"Ready for PIMR" and when the data is retrieved or
//				initially displayed.
//
//				This event will hide/display pmr_ready_date and
//				pmr_created_date.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	02/06/01	Stars 4.6 (PIMR).  Created.
//	JAS	06/04/02	Track 3096d - Changed function to trigger ue_display_help_buttons  
//						at end so it correctly displays help buttons
//
//////////////////////////////////////////////////////////////////

Datetime	ldtm_custom1_date

Long		ll_row,					&
			ll_custom1_cnt,		&
			ll_custom2_cnt

String	ls_pmr_ready_cd,		&
			ls_pmr_created_cd,	&
			ls_visible

Boolean	lb_error

ll_row	=	tab_case.tabpage_general.dw_general.GetRow()

ls_pmr_ready_cd	=	tab_case.tabpage_current.dw_current.object.pmr_ready_cd [ll_row]
ls_pmr_created_cd	=	tab_case.tabpage_current.dw_current.object.pmr_created_cd [ll_row]
ls_visible			=	tab_case.tabpage_current.dw_current.Describe ("pmr_ready_cd.Visible")

// If pmr_ready_cd is invisible, then the remaining fields are already invisible.
IF	ls_visible		<>	'1'	THEN
	Return
END IF

IF	ls_pmr_ready_cd	=	'Y'		THEN
	tab_case.tabpage_current.dw_current.Modify ("pmr_ready_date.Visible=1")
	// Begin - Track 3096d - calling ue_display_help_buttons at end of function
	//tab_case.tabpage_current.dw_current.Modify ("cb_pmr_ready_date.Visible=1")
	// End - Track 3096d
ELSE
	tab_case.tabpage_current.dw_current.Modify ("pmr_ready_date.Visible=0")
	// Begin - Track 3096d - calling ue_display_help_buttons at end of function
	//tab_case.tabpage_current.dw_current.Modify ("cb_pmr_ready_date.Visible=0")
	// End - Track 3096d
END IF

IF	ls_pmr_created_cd	=	'Y'		THEN
	tab_case.tabpage_current.dw_current.Modify ("pmr_created_date_t.Visible=1")
	tab_case.tabpage_current.dw_current.Modify ("pmr_created_date.Visible=1")
	// Begin - Track 3096d - calling ue_display_help_buttons at end of function
	//tab_case.tabpage_current.dw_current.Modify ("cb_pmr_created_date.Visible=1")
	// End - Track 3096d
	
	// file is created, user can no longer modify the ready code
	tab_case.tabpage_current.dw_current.Modify ("pmr_ready_cd.Protect=1")
ELSE
	tab_case.tabpage_current.dw_current.Modify ("pmr_created_date_t.Visible=0")
	tab_case.tabpage_current.dw_current.Modify ("pmr_created_date.Visible=0")
	// Begin - Track 3096d - calling ue_display_help_buttons at end of function
	//tab_case.tabpage_current.dw_current.Modify ("cb_pmr_created_date.Visible=0")
	// End - Track 3096d
END IF

// Begin - Track 3096d - call event to correctly display help buttons.
TriggerEvent('ue_display_help_buttons')

// End - Track 3096d



end event

event ue_enable_ready_for_pimr;//////////////////////////////////////////////////////////////////
//
//	Script:		w_case_maint.ue_enable_ready_for_pimr
//
//	Arguments:	ab_switch
//					TRUE	=	enable Ready for PIMR
//					FALSE	=	disable Ready for PIMR
//
//	Returns:		None
//
//	Description:
//				Enable/disable the 'Ready for PIMR' flag.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	02/13/01	Stars 4.6 (PIMR).  Created.
//
//////////////////////////////////////////////////////////////////

Long		ll_row

String	ls_describe

ll_row	=	tab_case.tabpage_general.dw_general.GetRow()

ls_describe	=	tab_case.tabpage_current.dw_current.object.pmr_ready_cd.Visible

IF	ls_describe	<>	'1'		THEN
	// Column is invisible - get out
	Return
END IF

IF	ab_switch	=	TRUE		THEN
	tab_case.tabpage_current.dw_current.object.pmr_ready_cd.Protect	=	0
ELSE
	tab_case.tabpage_current.dw_current.object.pmr_ready_cd.Protect	=	1
END IF


end event

event ue_reassign_case;//////////////////////////////////////////////////////////////////////////	
//
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//	GaryR	09/05/01	DataBase Port	Empty String in SQL
//	FDG	09/21/01	Stars 4.8.1	Case referrals.  Update the user ID for all
//						data associated with the case
//
//////////////////////////////////////////////////////////////////////////	

Long		ll_next_id
String	ls_next_id, ls_desc
DateTime	ldt_status

IF NOT ib_reassign THEN Return

// FDG 09/21/01 begin - Redirect to inv_case
//ls_next_id = fx_get_next_key_id( 'MESSAGEID' )
//IF Upper( ls_next_id ) = "ERROR" OR IsNull( ls_next_id ) OR NOT IsNumber( ls_next_id ) THEN
//	MessageBox( "Error", "Unable to obtain the next 'Message ID' in fx_get_next_key_id()" + &
//								"~n~rThe user to whom this case has been assigned will not be notified!", StopSign! )
//	Return
//END IF
//
//ll_next_id = Long( ls_next_id )
//ls_desc = in_case_id + in_case_spl + in_case_ver + " - Case has been assigned to you from user " + &
//																									is_asgn_to + " by user " + gc_user_id
//ldt_status = gnv_app.of_get_server_date_time()
//
//INSERT INTO USER_MESSAGE  
//        ( USER_MESSAGE_ID,   
//          USER_ID,   
//          MESSAGE_SOURCE,   
//          RTE_IND,   
//          MESSAGE_DATETIME,   
//          MESSAGE_SHORT_DESC,   
//          MESSAGE_TEXT,   
//          MESSAGE_STATUS,   
//          MESSAGE_STATUS_DATETIME,   
//          ROW_NUM,   
//          SQLDBCODE,   
//          SQLERRTEXT,   
//          SQLSYNTAX,   
//          SQLRETURNDATA,   
//          WINDOWNAME,   
//          DATAOBJECT )  
// VALUES ( :ll_next_id,   
//          :is_reasgn_to,   
//          'CASE ASSIGNMENT',   
//          'N',   
//          :idt_assign_datetime,   
//   	    :ls_desc,   
//          '',   
//          'A',   
//          :ldt_status,   
//          0,   
//          0,   
//          '',   
//          '',   
//          '',   
//          '',   
//	       '' )
//USING Stars2ca ;			 
//
//IF Stars2ca.of_check_status() <> 0 THEN
//	Stars2ca.of_RollBack()
//ELSE
//	Stars2ca.of_Commit()
//END IF

Long		ll_row
Integer	li_rc
String	ls_dept_id

ll_row	=	tab_case.tabpage_general.dw_general.GetRow()

ls_dept_id 			= tab_case.tabpage_general.dw_general.object.dept_id [ll_row]

li_rc	=	inv_case.Event	ue_reassign_case (ls_dept_id, is_reasgn_to, is_asgn_to)


end event

event type integer ue_edit_case_log();//////////////////////////////////////////////////////////////////////////	
//	Script:			w_case_maint.ue_edit_case_log
//
//	Arguments:		None
//
//	Returns:			Integer
//
//	Description:
//		This script is called when case is being updated (not created).
//		This script will determine which case_cntl columns changed and
//		insert the appropriate data into case_log.
//
//////////////////////////////////////////////////////////////////////////
//
//	History
//	FDG	10/03/01	Stars 4.8.1	Created
// SAH	12/26/01 Stars 5.0	Included asng_to_date in log
//	SAH	01/25/02 Stars 5.0	Compare dates with nulls to catch date
//										changes from initial date. Track 2721
//	GaryR	05/21/02	Track 3080d	Do not validate the update user column
//	GaryR	08/22/02	Track 3272d	Invalid log message for case business
//
//////////////////////////////////////////////////////////////////////////	

Long			ll_row,				&
				ll_row_log

DateTime		ldtm_datetime,		&
				ldtm_default

String		ls_status_desc,	&
				ls_pimr_desc,		&
				ls_col_desc,		&
				ls_orig_date,		&
				ls_new_date
				
n_cst_datetime lnvo_cst_datetime

SetPointer(hourglass!)

//get today's date
ldtm_datetime	=	gnv_app.of_get_server_date_time()

//local variable for default datetime
ldtm_default	=	Datetime( Date('01/01/1900') )

ll_row			=	tab_case.tabpage_general.dw_general.GetRow()

// Insert a new case_log and initialize some of it's data (including the numerical columns.
ll_row_log		=	inv_case.uf_initialize_case_log (ll_row)

// Compare dept_id
IF	tab_case.tabpage_general.dw_general.object.dept_id.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.dept_id[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("dept_id_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.dept_id[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.dept_id[ll_row]
END IF

// Compare case_asgn_id
IF	tab_case.tabpage_general.dw_general.object.case_asgn_id.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_asgn_id[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_asgn_id_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_asgn_id[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_asgn_id[ll_row]
END IF

// Compare case_asgn_prio
IF	tab_case.tabpage_general.dw_general.object.case_asgn_prio.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_asgn_prio[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_asgn_prio_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_asgn_prio[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_asgn_prio[ll_row]
END IF

// Compare case_asgn_date
IF	tab_case.tabpage_general.dw_general.object.case_asgn_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_asgn_date[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_asgn_date_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	// SAH 12/26/01 begin
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	//tab_case.tabpage_log.dw_log.object.case_asgn_date[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_asgn_date[ll_row]
   ls_status_desc	=	ls_status_desc	+	", "	+ "Assign Date" 
	tab_case.tabpage_log.dw_log.object.case_asgn_date[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_asgn_date[ll_row]
END IF
// SAH end

// Compare refer_from_dept
IF	tab_case.tabpage_general.dw_general.object.refer_from_dept.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.refer_from_dept[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("refer_from_dept_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.refer_from_dept[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.refer_from_dept[ll_row]
END IF

// Compare refer_to_dept
IF	tab_case.tabpage_general.dw_general.object.refer_to_dept.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.refer_to_dept[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("refer_to_dept_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.refer_to_dept[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.refer_to_dept[ll_row]
END IF

// Compare refer_by_rep
IF	tab_case.tabpage_general.dw_general.object.refer_by_rep.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.refer_by_rep[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("refer_by_rep_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.refer_by_rep[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.refer_by_rep[ll_row]
END IF

// Compare refer_date
IF	tab_case.tabpage_general.dw_general.object.refer_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.refer_date[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("refer_date_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.refer_date[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.refer_date[ll_row]
END IF

// Compare case_datetime
IF	tab_case.tabpage_general.dw_general.object.case_datetime.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_datetime[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_datetime_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_datetime[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_datetime[ll_row]
END IF

// Compare case_type
IF	tab_case.tabpage_general.dw_general.object.case_type.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_type[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_type_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_type[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_type[ll_row]
END IF

// Compare case_cat
IF	tab_case.tabpage_general.dw_general.object.case_cat.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_cat[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_cat_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_cat[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_cat[ll_row]
END IF

// Compare case_business
IF	tab_case.tabpage_general.dw_general.object.case_business.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_business[ll_row]	THEN
	//	GaryR	08/22/02	Track 3272d
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_cat_t.text")
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_business_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_business[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_business[ll_row]
END IF

// Compare case_line_b
IF	tab_case.tabpage_general.dw_general.object.case_line_b.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_line_b[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_line_b_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	"Line of Business"		// FDG 12/06/01
	tab_case.tabpage_log.dw_log.object.case_line_b[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_line_b[ll_row]
END IF

// Compare case_plan
IF	tab_case.tabpage_general.dw_general.object.case_plan.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_plan[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_plan_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	"Case Plan"					// FDG 12/06/01
	tab_case.tabpage_log.dw_log.object.case_plan[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_plan[ll_row]
END IF

// Compare case_trk_type
IF	tab_case.tabpage_general.dw_general.object.case_trk_type.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_trk_type[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_trk_type_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_trk_type[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_trk_type[ll_row]
END IF

// Compare case_edit
IF	tab_case.tabpage_general.dw_general.object.case_edit.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_edit[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_edit_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_edit[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_edit[ll_row]
END IF

// Compare case_disp_hold
IF	tab_case.tabpage_general.dw_general.object.case_disp_hold.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_disp_hold[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_disp_hold_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_disp_hold[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_disp_hold[ll_row]
END IF

// SAH 01/23/02 -Begin

// Compare case_from_period, also compare with null to find first change
ls_orig_date = String(tab_case.tabpage_general.dw_general.object.case_from_period.Primary.Original[ll_row])
ls_new_date = String(tab_case.tabpage_general.dw_general.object.case_from_period[ll_row])
IF NOT IsNull(ls_orig_date) and NOT IsNull(ls_new_date) and ls_orig_date <> ls_new_date OR IsNull(ls_orig_date) and NOT IsNull(ls_new_date) THEN
	ls_col_desc = tab_case.tabpage_general.dw_general.Describe("case_from_period_t.text")
	// Remove the ":"
	IF Right(ls_col_desc, 1) = ":" THEN
		ls_col_desc = Left(ls_col_desc, Len(ls_col_desc) -1)
	END IF
	ls_status_desc = ls_status_desc + "," + "Period From"
	tab_case.tabpage_log.dw_log.object.case_from_period[ll_row_log] = tab_case.tabpage_general.dw_general.object.case_from_period[ll_row]
END IF

// Compare case_from_period
//IF	tab_case.tabpage_general.dw_general.object.case_from_period.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_from_period[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_from_period_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
//	tab_case.tabpage_log.dw_log.object.case_from_period[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_from_period[ll_row]
//END IF

// Compare case_to_period, also compare with null to find first change
ls_orig_date = String(tab_case.tabpage_general.dw_general.object.case_to_period.Primary.Original[ll_row])
ls_new_date = String(tab_case.tabpage_general.dw_general.object.case_to_period[ll_row])
IF NOT IsNull(ls_orig_date) and NOT IsNull(ls_new_date) and ls_orig_date <> ls_new_date OR IsNull(ls_orig_date) and NOT IsNull(ls_new_date) THEN
	ls_col_desc = tab_case.tabpage_general.dw_general.Describe("case_to_period_t.text")
	// Remove the ":"
	IF Right(ls_col_desc, 1) = ":" THEN
		ls_col_desc = Left(ls_col_desc, Len(ls_col_desc) -1)
	END IF
	ls_status_desc = ls_status_desc + "," + "Period To"
	tab_case.tabpage_log.dw_log.object.case_to_period[ll_row_log] = tab_case.tabpage_general.dw_general.object.case_to_period[ll_row]
END IF

// Compare case_to_period
//IF	tab_case.tabpage_general.dw_general.object.case_to_period.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_to_period[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_to_period_t.text")
//	// Remove the ":"
//	//IF	Right (ls_col_desc, 1)	=	":"		THEN
//	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	//END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	"Period To"				// FDG 12/06/01
//	tab_case.tabpage_log.dw_log.object.case_to_period[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_to_period[ll_row]
//END IF

// Compare case_updt_user
//	GaryR	05/21/02	Track 3080d - Begin
//IF	tab_case.tabpage_general.dw_general.object.case_updt_user.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_updt_user[ll_row]	THEN
//	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_updt_user_t.text")
//	//// Remove the ":"
//	//IF	Right (ls_col_desc, 1)	=	":"		THEN
//	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	//END IF
//	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
//	tab_case.tabpage_log.dw_log.object.case_updt_user[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_updt_user[ll_row]
//END IF
//	GaryR	05/21/02	Track 3080d - End

// Compare case_desc
IF	tab_case.tabpage_general.dw_general.object.case_desc.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_desc[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_desc_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_desc[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_desc[ll_row]
END IF

// Compare case_status_desc
IF	tab_case.tabpage_general.dw_general.object.case_status_desc.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_status_desc[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("case_status_desc_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_status_desc[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_status_desc[ll_row]
END IF

// Compare case_status
IF	tab_case.tabpage_general.dw_general.object.case_status.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_status[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("case_status_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.status[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_status[ll_row]
END IF

// Compare case_disp
IF	tab_case.tabpage_general.dw_general.object.case_disp.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_disp[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("case_disp_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.disp[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_disp[ll_row]
END IF

// Compare case_date_recv
IF	tab_case.tabpage_general.dw_general.object.case_date_recv.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_date_recv[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_date_recv_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_date_recv[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_date_recv[ll_row]
END IF

// Compare identified_amt
IF	tab_case.tabpage_general.dw_general.object.identified_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.identified_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_savings.dw_savings.Describe ("identified_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.identified_amt[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.identified_amt[ll_row]
END IF

// Compare future_savings_amt
IF	tab_case.tabpage_general.dw_general.object.future_savings_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.future_savings_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_savings.dw_savings.Describe ("future_savings_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.future_savings_amt[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.future_savings_amt[ll_row]
END IF

// Compare case_custom1_amt
IF	tab_case.tabpage_general.dw_general.object.case_custom1_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_custom1_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_savings.dw_savings.Describe ("case_custom1_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_custom1_amt[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_custom1_amt[ll_row]
END IF

// Compare case_custom2_amt
IF	tab_case.tabpage_general.dw_general.object.case_custom2_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_custom2_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_savings.dw_savings.Describe ("case_custom2_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_custom2_amt[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_custom2_amt[ll_row]
END IF

// Compare case_custom3_amt
IF	tab_case.tabpage_general.dw_general.object.case_custom3_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_custom3_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_savings.dw_savings.Describe ("case_custom3_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_custom3_amt[ll_row_log]	=	tab_case.tabpage_general.dw_general.object.case_custom3_amt[ll_row]
END IF

ls_pimr_desc	=	This.Event	ue_edit_case_log_pimr (ll_row_log)

ls_status_desc	=	ls_status_desc	+	ls_pimr_desc



IF	Trim (ls_status_desc)	<	' '	THEN
	// No data updated.  Remove the case_log row
	tab_case.tabpage_log.dw_log.RowsDiscard (ll_row_log, ll_row_log, Primary!)
	Return	0
END IF

// Remove the leading ',' and set the status description.
ls_status_desc	=	"Changed: "	+	Mid ( ls_status_desc, 2 )
ls_status_desc	=	Left (ls_status_desc, 255)			// Only 255 bytes is stored

tab_case.tabpage_log.dw_log.object.status_desc[ll_row_log]	=	ls_status_desc

Return	1

end event

event ue_enable_update(boolean ab_switch);///////////////////////////////////////////////////////////////////////////
//	Event:		ue_enable_update
//
//	Argument:	ab_switch
//					TRUE	-	Allow updates on the window
//					FALSE	-	Do not allow updates on this window
//
//	Description:
//				Allow/disallow updates on this window. 
//
///////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/13/01	FDG	Stars 4.8.	Created.
//
///////////////////////////////////////////////////////////////////////////

//this.event ue_set_menu_more(ab_switch)				// FDG 12/06/01 - per KayKay

im_general.m_menu.m_retrieve.enabled	=	ab_switch
im_general.m_menu.m_delete.enabled		=	ab_switch
im_general.m_menu.m_copy.enabled			=	ab_switch
im_general.m_menu.m_clear.enabled		=	ab_switch
this.event ue_set_menu_create (ab_switch)
this.event ue_set_menu_update (ab_switch)
this.event ue_set_menu_refer (ab_switch)
this.event ue_set_menu_track (ab_switch)

IF	ab_switch		THEN
	tab_case.tabpage_general.dw_general.Object.DataWindow.ReadOnly="No"
	tab_case.tabpage_current.dw_current.Object.DataWindow.ReadOnly="No"
	tab_case.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly="No"
	tab_case.tabpage_pimr.dw_pimr.Object.DataWindow.ReadOnly="No"			// FDG 01/14/00
	tab_case.tabpage_log.dw_log.Object.DataWindow.ReadOnly="No"
	tab_case.tabpage_track.dw_track.Object.DataWindow.ReadOnly="No"
ELSE
	tab_case.tabpage_general.dw_general.Object.DataWindow.ReadOnly="Yes"
	tab_case.tabpage_current.dw_current.Object.DataWindow.ReadOnly="Yes"
	tab_case.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly="Yes"
	tab_case.tabpage_pimr.dw_pimr.Object.DataWindow.ReadOnly="Yes"			// FDG 01/14/00
	tab_case.tabpage_log.dw_log.Object.DataWindow.ReadOnly="Yes"
	tab_case.tabpage_track.dw_track.Object.DataWindow.ReadOnly="Yes"
END IF
				

end event

event ue_edit_enable_update;///////////////////////////////////////////////////////////////////////////
//	Event:	ue_edit_enable_update
//
//	Description:
//				Do not allow updates on this window if the case is deleted
//				or referred.
//
///////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/13/01	FDG	Stars 4.8.	Don't allow any updates if the case is referred.
//						Move edits from ue_retrieve
//
///////////////////////////////////////////////////////////////////////////

// FDG 09/13/01 - If case is referred, do not allow any updates
IF in_case_disposition =	'SYSDELET'		&
OR	in_case_disposition = 	'REFERRED'		then
	// FDG 09/13/01 - Display message on microhelp
	w_main.SetMicroHelp ('Case cannot be changed because it is deleted or referred.')
	
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		in_bad_retrieve = TRUE
		Return	FALSE
	End If	
	
	This.Event	ue_enable_update (FALSE)
	Return	FALSE
ELSE
	Return	TRUE
END IF



end event

event ue_set_instance();///////////////////////////////////////////////////////////////////////////
//	Event:	ue_set_instance
//
//	Description:
//		This script is triggered when the data is retrieved and when the
//		data is updated.  This script will set any instance variables based
//		on the data stored in the datawindows.
//
//	Note:	This script is needed in case multiple consecutive updates
//			occur.
//
///////////////////////////////////////////////////////////////////////////
//	History:
//
//	09/21/01	FDG	Stars 4.8.1	Created.
//
///////////////////////////////////////////////////////////////////////////

Long		ll_rows

ll_rows = tab_case.tabpage_general.dw_general.GetRow()

IF	ll_rows	<	1		THEN
	Return
END IF

in_case_id = tab_case.tabpage_general.dw_general.object.case_id[ll_rows]
in_case_spl = tab_case.tabpage_general.dw_general.object.case_spl[ll_rows]
in_case_ver = tab_case.tabpage_general.dw_general.object.case_ver[ll_rows]
in_case_cat = tab_case.tabpage_general.dw_general.object.case_cat[ll_rows]
in_case_refer_to = tab_case.tabpage_general.dw_general.object.refer_to_dept[ll_rows]
in_case_status = tab_case.tabpage_general.dw_general.object.case_status[ll_rows]
in_case_disposition = tab_case.tabpage_general.dw_general.object.case_disp[ll_rows]
in_case_status_user = tab_case.tabpage_general.dw_general.object.case_updt_user[ll_rows]
in_case_status_desc = tab_case.tabpage_general.dw_general.object.case_status_desc[ll_rows]
in_case_status_date = date(tab_case.tabpage_general.dw_general.object.case_status_date[ll_rows])
idt_current_datetime = tab_case.tabpage_general.dw_general.object.case_status_date[ll_rows]
is_asgn_to = tab_case.tabpage_general.dw_general.object.case_asgn_id[ll_rows]				//	09/05/01	GaryR	Stars 4.8


end event

event type string ue_edit_case_log_pimr(long al_row_log);//////////////////////////////////////////////////////////////////////////	
//	Script:			w_case_maint.ue_edit_case_log_pimr
//
//	Arguments:		None
//
//	Returns:			Integer
//
//	Description:
//		This script is called when case is being updated (not created).
//		This script will determine which case_cntl columns changed and
//		insert the appropriate data into case_log.
//
//	Note:	This event was created because the script for ue_edit_case_log
//			was too large.
//
//////////////////////////////////////////////////////////////////////////
//
//	History
//	FDG	10/03/01	Stars 4.8.1.	Created
//	GaryR	12/18/01	Stars 4.8.1	Reason Denied shows up as ! in description
// SAH	01/23/02 Stars 4.8.1 Compare pmr_custom1_date, _custom2_date, custom3_date
//										with null also to catch change from 00/00/0000 to first
//										change and post it to the log	 Track 2726
//	GaryR	07/23/04	Track 4046d	pmr_custom3_date erroneously used pmr_custom2_date label
//
//////////////////////////////////////////////////////////////////////////	

Long			ll_row

DateTime		ldtm_datetime,		&
				ldtm_default,		&
				ldtm_orig_dt,		&
				ldtm_new_dt

String		ls_status_desc,	&
				ls_col_desc,		&
				ls_orig_date,		&
				ls_new_date
				
n_cst_datetime lnvo_cst_datetime

SetPointer(hourglass!)

//get today's date
ldtm_datetime	=	gnv_app.of_get_server_date_time()

//local variable for default datetime
ldtm_default	=	Datetime( Date('01/01/1900') )

ll_row			=	tab_case.tabpage_general.dw_general.GetRow()

// Compare pmr_contractor_id
IF	tab_case.tabpage_general.dw_general.object.pmr_contractor_id.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_contractor_id[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_contractor_id_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_contractor_id[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_contractor_id[ll_row]
END IF

// Compare pmr_subject_id
IF	tab_case.tabpage_general.dw_general.object.pmr_subject_id.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_subject_id[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_subject_id_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_subject_id[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_subject_id[ll_row]
END IF

// Compare pmr_custom1_char
IF	tab_case.tabpage_general.dw_general.object.pmr_custom1_char.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom1_char[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_custom1_char_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom1_char[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom1_char[ll_row]
END IF

// Compare pmr_ready_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_ready_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_ready_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_ready_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_ready_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_ready_cd[ll_row]
END IF

// Compare pmr_created_cd  --This column doesn't appear on the Case tab
IF	tab_case.tabpage_general.dw_general.object.pmr_created_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_created_cd[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_created_cd_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_created_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_created_cd[ll_row]
END IF

// SAH 01/22/02 Begin
// Compare pmr_ready_date
IF	tab_case.tabpage_general.dw_general.object.pmr_ready_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_ready_date[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_ready_date_t.text")
	//ls_col_desc = tab_case.tabpage_current.dw_current.Describe("pmr_ready_date_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	// pmr_ready_date_t not populated because the label is not used on tab_case.tabpage_general.  Returns '!' 
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc 
	ls_status_desc = ls_status_desc + ", " + "PIMR Ready Date"
	tab_case.tabpage_log.dw_log.object.pmr_ready_date[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_ready_date[ll_row]
END IF

// SAH 01/22/02 End

// Compare pmr_created_date
IF	tab_case.tabpage_general.dw_general.object.pmr_created_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_created_date[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_created_date_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_created_date[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_created_date[ll_row]
END IF

// Compare case_prov_spec
IF	tab_case.tabpage_general.dw_general.object.case_prov_spec.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.case_prov_spec[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("case_prov_spec_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.case_prov_spec[al_row_log]	=	tab_case.tabpage_general.dw_general.object.case_prov_spec[ll_row]
END IF

// Compare pmr_prov_type_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_prov_type_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_prov_type_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_general.dw_general.Describe ("pmr_prov_type_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_prov_type_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_prov_type_cd[ll_row]
END IF

// Compare pmr_custom1_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_custom1_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom1_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom1_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom1_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom1_cd[ll_row]
END IF

// SAH 02/23/02  -Begin

// Compare pmr_custom1_date, also compare with null to find first change
ldtm_orig_dt = tab_case.tabpage_general.dw_general.object.pmr_custom1_date.Primary.Original[ll_row]
ldtm_new_dt = tab_case.tabpage_general.dw_general.object.pmr_custom1_date[ll_row]
IF NOT IsNull(ldtm_orig_dt) and NOT IsNull(ldtm_new_dt) and ldtm_orig_dt <> ldtm_new_dt OR IsNull(ldtm_orig_dt) &
  and ldtm_new_dt <> ldtm_default THEN
	ls_col_desc = tab_case.tabpage_current.dw_current.Describe("pmr_custom1_date_t.text")
	// Remove the ":"
	IF Right(ls_col_desc, 1) = ":" THEN
		ls_col_desc = Left(ls_col_desc, Len(ls_col_desc) -1)
	END IF
	ls_status_desc = ls_status_desc + ", " + ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom1_date[al_row_log] = tab_case.tabpage_general.dw_general.object.pmr_custom1_date[ll_row]
END IF

// Compare pmr_custom1_date
//IF	tab_case.tabpage_general.dw_general.object.pmr_custom1_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom1_date[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom1_date_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
//	tab_case.tabpage_log.dw_log.object.pmr_custom1_date[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom1_date[ll_row]
//END IF

// SAH 01/23/02 -End

// Compare pmr_custom2_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_custom2_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom2_cd[ll_row]	THEN
	//	GaryR	12/18/01	Stars 4.8.1
	//ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom2_cd_t.text")
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_custom2_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom2_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom2_cd[ll_row]
END IF

// Compare pmr_custom3_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_custom3_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom3_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom3_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom3_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom3_cd[ll_row]
END IF

// Compare pmr_frd_rfrl_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_frd_rfrl_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_frd_rfrl_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_frd_rfrl_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_frd_rfrl_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_frd_rfrl_cd[ll_row]
END IF

// Compare pmr_acpt_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_acpt_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_acpt_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_acpt_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_acpt_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_acpt_cd[ll_row]
END IF

// Compare pmr_ready_user
IF	tab_case.tabpage_general.dw_general.object.pmr_ready_user.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_ready_user[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_ready_user_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_ready_user[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_ready_user[ll_row]
END IF

// Compare pmr_created_user
IF	tab_case.tabpage_general.dw_general.object.pmr_created_user.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_created_user[ll_row]	THEN
	//ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_created_user_t.text")
	//// Remove the ":"
	//IF	Right (ls_col_desc, 1)	=	":"		THEN
	//	ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	//END IF
	//ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_created_user[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_created_user[ll_row]
END IF

// Compare pmr_custom2_char
IF	tab_case.tabpage_general.dw_general.object.pmr_custom2_char.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom2_char[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom2_char_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom2_char[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom2_char[ll_row]
END IF

// Compare pmr_custom4_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_custom4_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom4_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom4_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom4_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom4_cd[ll_row]
END IF

// Compare pmr_custom5_cd
IF	tab_case.tabpage_general.dw_general.object.pmr_custom5_cd.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom5_cd[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom5_cd_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom5_cd[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom5_cd[ll_row]
END IF

// SAH 02/23/02  -Begin

// Compare pmr_custom2_date, also compare with null to find first change
ldtm_orig_dt = tab_case.tabpage_general.dw_general.object.pmr_custom2_date.Primary.Original[ll_row]
ldtm_new_dt = tab_case.tabpage_general.dw_general.object.pmr_custom2_date[ll_row]
IF NOT IsNull(ldtm_orig_dt) and NOT IsNull(ldtm_new_dt) and ldtm_orig_dt <> ldtm_new_dt OR IsNull(ldtm_orig_dt) &
  and ldtm_new_dt <> ldtm_default THEN
	ls_col_desc = tab_case.tabpage_current.dw_current.Describe("pmr_custom2_date_t.text")
	// Remove the ":"
	IF Right(ls_col_desc, 1) = ":" THEN
		ls_col_desc = Left(ls_col_desc, Len(ls_col_desc) -1)
	END IF
	ls_status_desc = ls_status_desc + ", " + ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom2_date[al_row_log] = tab_case.tabpage_general.dw_general.object.pmr_custom2_date[ll_row]
END IF

// Compare pmr_custom2_date
//IF	tab_case.tabpage_general.dw_general.object.pmr_custom2_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom2_date[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom2_date_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
//	tab_case.tabpage_log.dw_log.object.pmr_custom2_date[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom2_date[ll_row]
//END IF

// Compare pmr_custom3_date, also compare with null to find first change
ldtm_orig_dt = tab_case.tabpage_general.dw_general.object.pmr_custom3_date.Primary.Original[ll_row]
ldtm_new_dt = tab_case.tabpage_general.dw_general.object.pmr_custom3_date[ll_row]
IF NOT IsNull(ldtm_orig_dt) and NOT IsNull(ldtm_new_dt) and ldtm_orig_dt <> ldtm_new_dt OR IsNull(ldtm_orig_dt) &
  and ldtm_new_dt <> ldtm_default THEN
	ls_col_desc = tab_case.tabpage_current.dw_current.Describe("pmr_custom3_date_t.text")
	// Remove the ":"
	IF Right(ls_col_desc, 1) = ":" THEN
		ls_col_desc = Left(ls_col_desc, Len(ls_col_desc) -1)
	END IF
	ls_status_desc = ls_status_desc + ", " + ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_custom3_date[al_row_log] = tab_case.tabpage_general.dw_general.object.pmr_custom3_date[ll_row]
END IF




// Compare pmr_custom3_date
//IF	tab_case.tabpage_general.dw_general.object.pmr_custom3_date.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_custom3_date[ll_row]	THEN
//	ls_col_desc	=	tab_case.tabpage_current.dw_current.Describe ("pmr_custom3_date_t.text")
//	// Remove the ":"
//	IF	Right (ls_col_desc, 1)	=	":"		THEN
//		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
//	END IF
//	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
//	tab_case.tabpage_log.dw_log.object.pmr_custom3_date[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_custom3_date[ll_row]
//END IF

// SAH 02/23/01 -End

// Compare pmr_case_custom4_amt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom4_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom4_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom4_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom4_amt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom4_amt[ll_row]
END IF

// Compare pmr_case_custom5_amt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom5_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom5_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom5_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom5_amt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom5_amt[ll_row]
END IF

// Compare pmr_case_custom6_amt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom6_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom6_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom6_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom6_amt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom6_amt[ll_row]
END IF

// Compare pmr_case_custom7_amt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom7_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom7_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom7_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom7_amt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom7_amt[ll_row]
END IF

// Compare pmr_case_custom8_amt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom8_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom8_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom8_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom8_amt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom8_amt[ll_row]
END IF

// Compare pmr_case_custom9_amt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom9_amt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom9_amt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom9_amt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom9_amt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom9_amt[ll_row]
END IF

// Compare pmr_case_custom1_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom1_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom1_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom1_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom1_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom1_cnt[ll_row]
END IF

// Compare pmr_case_custom2_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom2_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom2_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom2_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom2_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom2_cnt[ll_row]
END IF

// Compare pmr_case_custom3_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom3_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom3_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom3_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom3_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom3_cnt[ll_row]
END IF

// Compare pmr_case_custom4_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom4_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom4_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom4_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom4_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom4_cnt[ll_row]
END IF

// Compare pmr_case_custom5_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom5_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom5_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom5_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom5_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom5_cnt[ll_row]
END IF

// Compare pmr_case_custom6_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom6_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom6_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom6_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom6_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom6_cnt[ll_row]
END IF

// Compare pmr_case_custom7_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom7_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom7_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom7_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom7_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom7_cnt[ll_row]
END IF

// Compare pmr_case_custom8_cnt
IF	tab_case.tabpage_general.dw_general.object.pmr_case_custom8_cnt.Primary.Original[ll_row]	<>	tab_case.tabpage_general.dw_general.object.pmr_case_custom8_cnt[ll_row]	THEN
	ls_col_desc	=	tab_case.tabpage_pimr.dw_pimr.Describe ("pmr_case_custom8_cnt_t.text")
	// Remove the ":"
	IF	Right (ls_col_desc, 1)	=	":"		THEN
		ls_col_desc	=	Left (ls_col_desc, Len(ls_col_desc) - 1)
	END IF
	ls_status_desc	=	ls_status_desc	+	", "	+	ls_col_desc
	tab_case.tabpage_log.dw_log.object.pmr_case_custom8_cnt[al_row_log]	=	tab_case.tabpage_general.dw_general.object.pmr_case_custom8_cnt[ll_row]
END IF


Return	ls_status_desc

end event

event ue_filter_userid(string as_dept_id);//////////////////////////////////////////////////////////////////
//
//	Script:		ue_filter_userid
//
//	Arguments:	as_dept_id - Department to filter
//
//	Returns:		None
//
//	Description:
//			Filter the list of users based on the passed department ID
//
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	11/06/01	Stars 4.8.1.  Created.
// SAH	01/07/02 Stars 5.0 	Allow those cases with code_value_n > 0
//										to be assigned to multiple depts, so
//										remove the filter in those cases.
//	GaryR	09/10/02	Track 3046d	Prevent GPF when dept_id not in code
//	GaryR	01/13/05	Track 4208d	Filter deleted users in Case Maintenance only
//
//////////////////////////////////////////////////////////////////

String	ls_filter,			&
			ls_dept_id,			&
			ls_find,				&
			ls_active = "status <> 'DELETED'"

Long		ll_rowcount,		&
			ll_row

Integer	li_rc,				&
			li_code_val_n
			
DataWindowChild	ldwc

ls_dept_id	=	Trim (as_dept_id)                               

// SAH 01/07/02 begin
ls_find = "code_code = '" + ls_dept_id + "'"

ll_row = ids_code.Find(ls_find, 1, ids_code.RowCount() )
IF ll_row < 1 THEN
	//	GaryR	09/10/02	SPR 3046d - Begin
	MessageBox( "Error", "Unable to find Department " + ls_dept_id + &
													" in the Code table.", Exclamation! )
	Return
	//	GaryR	09/10/02	SPR 3046d - End
END IF

li_code_val_n = ids_code.object.code_value_n[ll_row]
// SAH 01/07/02 end

// Get the child d/w to filter
tab_case.tabpage_general.dw_general.GetChild ('case_asgn_id', ldwc)

ls_filter	=	"user_dept = '" + ls_dept_id + "' and " + ls_active

IF	IsNull (ls_dept_id)		&
OR	Len (ls_dept_id)	=	0	THEN
	ls_filter	=	ls_active
END IF

// SAH 01/07/02 begin
 IF li_code_val_n > 0 THEN
	 li_rc	=	ldwc.SetFilter('')
	 li_rc	=	ldwc.Filter()
	 li_rc	=	ldwc.SetFilter(ls_active)
	 li_rc	=	ldwc.Filter()
ELSE
	 li_rc	=	ldwc.SetFilter('')
	 li_rc	=	ldwc.Filter()
	 li_rc	=	ldwc.SetFilter(ls_filter)
	 li_rc	=	ldwc.Filter()
END IF

li_rc	=	ldwc.SetSort("cf_name A")
 li_rc	=	ldwc.Sort()
// SAH 01/07/02 end
end event

event ue_get_dw_syntax();// 06/12/02  JasonS	Track 3082d - Code/Decode is not working properly on the Case Log screen

// Begin - Track 3082d

fx_dw_syntax('w_case_maint', tab_case.tabpage_log.dw_display_log, istr_decode_struct, stars2ca)

// End - Track 3082d

end event

event ue_re_retrieve_log();///////////////////////////////////////////////////////////////////////////
//	Event:	ue_re_retrieve_log
//
//	Description:
//				Re-retrieve the log data for this case.
//
////////////////////////////////////////////////////////////////////////////
//	History:
////////////////////////////////////////////////////////////////////////////
//	JasonS	11/21/02		Created.
/////////////////////////////////////////////////////////////////////////////////////////////

String	ls_case,				&
			ls_case_ver,		&
			ls_case_spl

Long		ll_rowcount			

ls_case		=	Left (is_active_case, 10)
ls_case_spl	=	Mid (is_active_case, 11, 2)
ls_case_ver	=	Mid (is_active_case, 13, 2)

tab_case.tabpage_log.dw_display_log.SetTransObject(Stars2ca)
ll_rowcount		=	tab_case.tabpage_log.dw_display_log.Retrieve (ls_case, ls_case_spl, ls_case_ver)

IF	ll_rowcount	>	0		THEN
	tab_case.tabpage_log.enabled	=	TRUE
	//tab_case.tabpage_savings.cb_next_savings.enabled = TRUE //NLG 4-25-00
	//tab_case.tabpage_pimr.cb_next_pimr.enabled = TRUE 			//FDG 01/21/01
ELSE
	tab_case.tabpage_log.enabled	=	FALSE
	//tab_case.tabpage_savings.cb_next_savings.enabled = FALSE //NLG 4-25-00
//	tab_case.tabpage_pimr.cb_next_pimr.enabled = FALSE			//FDG 01/21/01
END IF

// still need this here or case add will fail
tab_case.tabpage_log.dw_log.SetTransObject(Stars2ca)
tab_case.tabpage_log.dw_log.Retrieve(ls_case, ls_case_spl, ls_case_ver)

// JasonS 09/26/02 Begin - Track 3325d
fx_set_default_dw_date( tab_case.tabpage_log.dw_display_log )
// JasonS 09/26/02 End - Track 3325d

// update case log counter
tab_case.tabpage_log.dw_display_log.accepttext( )
tab_case.tabpage_log.st_count.text = String(tab_case.tabpage_log.dw_display_log.rowcount())

tab_case.tabpage_track.st_track_count.text = string(tab_case.tabpage_track.dw_track.rowcount())		

// JasonS Track 3573 Case Headings
this.event ue_populate_headings()

end event

event ue_refresh_case();/*================================================================================
==================================================================================
Change History
==================================================================================
//
//	11/21/02	Jason	Track 3374d	Created.
//	10/04/05	GaryR	Track 4501d	Reset dates after retrieving Case details
//   04/04/06 JasonS  Track 4712d  Add ue_populate_heading()
================================================================================*/
long ll_rows
string ls_case, ls_case_spl, ls_case_ver

ls_case		=	Left (is_active_case, 10)
ls_case_spl	=	Mid (is_active_case, 11, 2)
ls_case_ver	=	Mid (is_active_case, 13, 2)

//retrieve for General tab
ll_rows = tab_case.tabpage_general.dw_general.Retrieve (ls_case, ls_case_spl, ls_case_ver)
// Share the data between dw_general and the other tabs.
tab_case.tabpage_general.dw_general.ShareData (tab_case.tabpage_current.dw_current)
tab_case.tabpage_general.dw_general.ShareData (tab_case.tabpage_savings.dw_savings)
tab_case.tabpage_general.dw_general.ShareData (tab_case.tabpage_pimr.dw_pimr)				// FDG 01/14/01
this.event ue_reset_dates()

ll_rows = tab_case.tabpage_track.dw_track.Retrieve (ls_case, ls_case_spl, ls_case_ver)

IF	ll_rows	>	0		THEN
	tab_case.tabpage_track.enabled	=	TRUE
ELSE
	tab_case.tabpage_track.enabled	=	FALSE
END IF

this.event ue_re_retrieve_log( )
this.event ue_populate_headings()

end event

event ue_populate_headings();// 10/26/04	Jason	Track 3573d	Created
// 01/13/05	GaryR	Track 4208d	Make SQL DBMS independent
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

String ls_user_id, ls_user_f_name, ls_user_l_name
DataWindowChild ldwc
Long ll_find_row

ls_user_id = tab_case.tabpage_general.dw_general.getitemstring(1, "case_asgn_id")
select user_f_name, user_l_name
into :ls_user_f_name, :ls_user_l_name
from users
where user_id = :ls_user_id
using stars2ca;

dw_headings.setitem(1, "assigned", ls_user_id + " - " + ls_user_f_name + " " + ls_user_l_name)				

tab_case.tabpage_current.dw_current.getchild( "case_status", ldwc)	
If in_from = 'A' then
	dw_headings.setitem(1, "status", tab_case.tabpage_current.dw_current.getitemstring(1, "case_status"))						
else
	ll_find_row = ldwc.find("CODE_CODE='" + tab_case.tabpage_current.dw_current.getitemstring(1, "case_status") + "'",1, ldwc.rowcount( ) )
	if ll_find_row > 0 then
		dw_headings.setitem(1, "status", ldwc.getitemstring( ll_find_row, "code_description"))				
	end if
End if

tab_case.tabpage_current.dw_current.getchild( "case_disp", ldwc)	 
if in_from = 'A' then
	dw_headings.setitem(1, "disposition", tab_case.tabpage_current.dw_current.getitemstring(1, "case_disp"))						
else
	ll_find_row = ldwc.find("CODE_CODE='" + tab_case.tabpage_current.dw_current.getitemstring(1, "case_disp") + "'",1, ldwc.rowcount( ) )
	if ll_find_row > 0 then
		dw_headings.setitem(1, "disposition", ldwc.getitemstring( ll_find_row, "code_description"))
	end if
end if

tab_case.tabpage_general.dw_general.getchild( "dept_id", ldwc)	

ll_find_row = ldwc.find("CODE_CODE='" + tab_case.tabpage_general.dw_general.getitemstring(1, "dept_id") + "'",1, ldwc.rowcount( ) )
if ll_find_row > 0 then
	dw_headings.setitem(1, "department", ldwc.getitemstring( ll_find_row, "code_description"))
end if

dw_headings.setitem(1, "description", tab_case.tabpage_general.dw_general.getItemstring(1, "case_desc"))	
dw_headings.setitem(1, "subject_id", tab_case.tabpage_general.dw_general.getItemstring(1, "pmr_subject_id"))		
dw_headings.setitem(1, "case_id",  tab_case.tabpage_general.dw_general.getItemstring(1, "case_id") + " " + tab_case.tabpage_general.dw_general.getItemstring(1, "case_spl") + " " +tab_case.tabpage_general.dw_general.getItemstring(1, "case_ver"))

of_update_last_update_header()
end event

event ue_enable_details(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_enable_details
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the detail
//						component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************

if ab_switch then
	tab_case.tabpage_general.dw_general.Object.DataWindow.ReadOnly="No"
else
	tab_case.tabpage_general.dw_general.Object.DataWindow.ReadOnly="Yes"
end if
	

tab_case.tabpage_current.dw_current.object.case_disp.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.case_status_desc.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom1_date.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_frd_rfrl_cd.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_acpt_cd.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom3_cd.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom1_cd.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_ready_cd.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom2_char.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom4_cd.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom2_date.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom3_date.protect = NOT ab_switch
tab_case.tabpage_current.dw_current.object.pmr_custom5_cd.protect = NOT ab_switch
end event

event ue_set_update_availability();//*********************************************************************************
// Script Name:	ue_set_update_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the detail
//						and financial components base on the update status returned from
//						n_cst_case.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************


String ls_case_id
String ls_case_spl
String ls_case_ver
String ls_comp_upd_status

ls_case_id = w_case_maint.tab_case.tabpage_general.dw_general.object.case_id[1]
ls_case_spl = w_case_maint.tab_case.tabpage_general.dw_general.object.case_spl[1]
ls_case_ver = w_case_maint.tab_case.tabpage_general.dw_general.object.case_ver[1]

ls_comp_upd_status = inv_case.uf_get_comp_upd_status('CASEDETAIL', ls_case_id , ls_case_spl, ls_case_ver)

choose case ls_comp_upd_status 
	case 'AO'
		if in_from <> 'A' then
			this.event ue_enable_details(false)
		else
			this.event ue_enable_details(true)
		end if
	case 'RO'
		this.event ue_enable_details(false)
	case 'AL'
		this.event ue_enable_details(true)
end choose


ls_comp_upd_status = inv_case.uf_get_comp_upd_status('CASEFIN', ls_case_id , ls_case_spl, ls_case_ver)

choose case ls_comp_upd_status 
	case 'AO'
		if in_from <> 'A' then
			this.event ue_enable_financials(false)
		else
			this.event ue_enable_financials(true)
		end if
	case 'RO'
		this.event ue_enable_financials(false)
	case 'AL'
		this.event ue_enable_financials(true)
end choose
end event

event ue_enable_financials(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_enable_financials
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the financial
//						component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************

if ab_switch then
	tab_case.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly="No"
	tab_case.tabpage_pimr.dw_pimr.Object.DataWindow.ReadOnly="No"	
else
	tab_case.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly="Yes"
	tab_case.tabpage_pimr.dw_pimr.Object.DataWindow.ReadOnly="Yes"	
end if
end event

public subroutine wf_contact ();// Katie  05/29/07  SPR 5043 made sure gv_from was set to Case before opening w_lead_maintain
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If trim(is_active_case) = '' then
	Messagebox('EDIT','Enter Case Id')
	tab_case.tabpage_general.dw_general.SetColumn("case_id")
	RETURN
End IF
setmicrohelp(w_main,'Opening Case Leads List')

gv_active_case = is_active_case
gv_from = 'CASE'
If in_case_cat <> 'CA?' then
	opensheet (w_lead_list,MDI_Main_Frame,Help_Menu_Position,Layered!)
Else
	Messagebox('EDIT','Leads cannot be created for a Potential Case,'  + &
				' Update Case Category ')
End If
end subroutine

public subroutine wf_folder ();setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If trim(is_active_case) = '' then
	Messagebox('EDIT','Enter Case Id')
	//setfocus(w_case_maint.sle_case_id)
	RETURN
End IF
setmicrohelp(w_main,'Opening Case Folder')

gv_active_case = is_active_case
gv_from = 'CASE'
opensheet (w_case_folder_view,MDI_Main_Frame,Help_Menu_Position,Layered!)
end subroutine

public subroutine wf_notes ();//*NLG 12-02-99 Use ue_notes() instead.*//

////======================================================================================
////w_case_maint::wf_notes
////Modifications:
////05-12-98	NLG	1.	replace notes globals with notes nvo
////09/01/98  AJS   FS362 convert case to case_cntl
////======================================================================================
//
//datetime lv_datetime
//string lv_case_id,lv_case_spl,lv_case_ver
//
//setpointer(hourglass!)
//setmicrohelp(w_main,'Opening Case Notes')
//If trim(is_active_case) = '' then
//	Messagebox('EDIT','Enter Case Id')
//	//setfocus(w_case_maint.sle_case_id)
//	RETURN
//End IF
//
//lv_case_id = left(is_active_case,10)
//lv_case_spl = mid(is_active_case,11,2)
//lv_case_ver = mid(is_active_case,13,2)
//
//// 09/01/98 AJS   FS362 convert case to case_cntl
//select case_datetime into :lv_datetime
//		from case_CNTL
//		where case_id = :lv_case_id and
//				case_spl = :lv_case_spl and
//				case_ver = :lv_case_ver
//using stars2ca;
//If stars2ca.of_check_status() = 100 then
//	COMMIT using STARS2CA;
//	If stars2ca.of_check_status() <> 0 Then
//		errorbox(stars2ca,'Error Committing to Stars2')
//		Return
//	End If	
//	Messagebox ('EDIT','Case must exist on Database to add a NOTE')
//	RETURN
//Elseif stars2ca.sqlcode <> 0 then
//			Errorbox(stars2ca,'Error Reading Case_cntl')
//			RETURN
//End If
//
//COMMIT using STARS2CA;
//If stars2ca.of_check_status() <> 0 Then
//	errorbox(stars2ca,'Error Committing to Stars2')
//	Return
//End If	
//
//n_cst_notes lnv_notes
//
//lnv_notes.is_notes_from = 'CA'
//lnv_notes.is_notes_rel_id = is_active_case
//lnv_notes.idt_notes_date   = date(lv_datetime)
//OPENSheetwithParm(W_NOTES_LIST,lnv_notes,MDI_Main_Frame,Help_Menu_Position,Layered!)
//
end subroutine

public function string wf_remove_colon (string as_text);//////////////////////////////////////////////////////////////////
//
//	Script:		w_case_maint.wf_remove_colon
//
//	Arguments:	as_text - Column text with the colon (':') at the end
//
//	Returns:		String
//
//	Description:
//				This script will remove the colon at the end of the parm
//				passed to this script.
//
//////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	02/06/01	Stars 4.6 (PIMR).  Created.
//
//////////////////////////////////////////////////////////////////

Integer	li_len,		&
			li_pos

String	ls_text

// Edit input
IF	IsNull (as_text)		THEN
	Return	''
END IF

li_len	=	Len (as_text)
li_pos	=	Pos (as_text, ':')

IF	 li_pos	<	li_len		&
AND li_pos	>	0				THEN
	// A colon was found before the end, find it at the end
	li_pos	=	Pos (as_text, ':', li_pos + 1)
END IF

IF	li_pos	=	li_len		THEN
	ls_text	=	Mid (as_text, 1, li_len - 1)
	Return	ls_text
ELSE
	Return	as_text
END IF


end function

public function integer wf_close_track_lead (boolean in_dupe_close);//***********************************************************************
//	wf_close_track_lead()
//
//***********************************************************************
//	PAT-D	00/00/00	ALABAMA4 ADDED THIS ENTIRE FUNCTION
//	FNC	09/05/96	Retrieve tracks for case into an invisible datawindow
//	NLG	10/22/97	If closing case w/only 1 open track, go ahead and close it
//	NLG	01/12/98	ts2001c - get date from server, not PC
//	GaryR	01/09/01	Stars 4.7 DataBase Port - Empty String in SQL
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in key data.
//	GaryR	01/02/03	Track 4809c	Close leads and fix tracks logic
//	GaryR	01/02/04	Track 3625d	Fix datawindow and code to match expected columns
//***********************************************************************

Integer lv_count,li_rc
long ll_no_rows,ll_row_num
String Lv_track_key,lv_track_type,lv_track_status,lv_track_disp
String lv_case_id,lv_case_spl,lv_case_ver
String 	lv_status = 'CL',lv_disp = 'SYSORCLS'
Datetime lv_date_time

n_ds lds_case_track_delete

lds_case_track_delete = CREATE n_ds

lv_case_id	= Trim(left(gv_active_case,10) )		// FDG 04/16/01
lv_case_spl = mid(gv_active_case,11,2)	
lv_case_ver = mid(gv_active_case,13,2)

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 end

lv_date_time = gnv_app.of_get_server_date_time()

//Update Status to closed for all Leads in this case
Update Lead
		 set  Status = :lv_status,
				disp_date = :lv_date_time
	where Case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using stars2ca;

If Stars2ca.of_check_status() <> 0 then
	 Errorbox(Stars2ca,'Error Updating Leads to Closed Status')
	 RETURN -1
End IF

Stars2ca.of_commit()

If in_dupe_close = true then RETURN 0

lds_case_track_delete.dataobject = "d_case_track_delete"
lds_case_track_delete.SetTransObject(Stars2ca)

ll_no_rows = lds_case_track_delete.retrieve(lv_case_id,lv_case_spl,lv_case_ver)
if ll_no_rows = -1 then 
	messagebox('WARNING','Error retrieving case tracks')
	return -1
end if
if ll_no_rows = 0 then 
	return 0
	if IsValid(lds_case_track_delete) then DESTROY(lds_case_track_delete)
end if

if ll_no_rows > 1 then 
	li_rc = messagebox('QUESTION','Case currently has ' + string(ll_no_rows) + ' tracks that must be closed. ~nDo you wish to continue closing this case?',Question!,YesNo!)
	if li_rc = 2 then 
		return 100 
		if IsValid(lds_case_track_delete) then DESTROY(lds_case_track_delete)
	end if
end if    

For ll_row_num = 1 to ll_no_rows
	lv_track_key =    getitemstring(lds_case_track_delete,ll_row_num,"trk_key")
	lv_track_type =   getitemstring(lds_case_track_delete,ll_row_num,"trk_type")
	lv_track_status = getitemstring(lds_case_track_delete,ll_row_num,"status")
	lv_track_disp =   getitemstring(lds_case_track_delete,ll_row_num,"disp")
	// FDG 04/16/01 - Empty string in Oracle is null
	li_rc	=	gnv_sql.of_TrimData (lv_track_key)
	li_rc	=	gnv_sql.of_TrimData (lv_track_type)
	// FDG 04/16/01 end

	//Write a track log closing the track
	If lv_track_status = 'CL' then
		Continue
	End IF
	Select Count(*) into :lv_count
		From Track_log
			where Case_id  = Upper( :lv_case_id ) and
					case_spl = Upper( :lv_case_spl ) and
					case_ver = Upper( :lv_case_ver ) and
					trk_key  = Upper( :lv_track_key ) and
					trk_type = Upper( :lv_track_type ) and
					disp     = 'SYSORCLS'
	Using stars2ca;
	If Stars2ca.of_check_status() <> 0 then
		 Errorbox(Stars2ca,'Error Reading Track Log')
		 RETURN -1
	Elseif lv_count = 0 then
			 lv_disp  = 'SYSORCLS'
	Else   
			 lv_disp  = 'SYSRECLS'
	End If

	//write log entry for system closed and current track disposition
	Insert into track_log
		(CASE_ID,CASE_SPL,case_ver,
		 trk_type,trk_key,user_id,
		 status,disp,status_datetime,
		 status_desc,OP_AMT,AMT_RECV,
		 AMT_WRITEOFF,RECOVERED_ADDTL_AMT,
       BALANCE_REMAINING_AMT,REFERRED_AMT,
       CUSTOM1_AMT,CUSTOM2_AMT,CUSTOM3_AMT,
       CUSTOM4_AMT,CUSTOM5_AMT,CUSTOM6_AMT )
	Values
		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
		  :lv_track_type,:lv_track_key,:gc_user_id,
			:lv_status,:lv_track_disp,:LV_DATE_TIME,
			'Case Closed - Track Status Closed',
			0,0,0,0,0,0,0,0,0,0,0,0 )
			  Using Stars2ca;

	If stars2ca.of_check_status() <> 0 then
		 Errorbox(stars2ca,'Error Inserting Closed Entry to track log')
		 RETURN -1
	End If

	//write log entry for system closed status & disposition
	Insert into track_log
		(CASE_ID,CASE_SPL,case_ver,
		 trk_type,trk_key,user_id,
		 status,disp,status_datetime,
		 status_desc,OP_AMT,AMT_RECV,
		 AMT_WRITEOFF,RECOVERED_ADDTL_AMT,
       BALANCE_REMAINING_AMT,REFERRED_AMT,
       CUSTOM1_AMT,CUSTOM2_AMT,CUSTOM3_AMT,
       CUSTOM4_AMT,CUSTOM5_AMT,CUSTOM6_AMT)
	Values
		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
		  :lv_track_type,:lv_track_key,:gc_user_id,
		  :lv_status,:lv_disp,:LV_DATE_TIME,
			'Case Closed - Track is also being Closed',
			0,0,0,0,0,0,0,0,0,0,0,0 )
	Using Stars2ca;

	If stars2ca.of_check_status() <> 0 then
		 Errorbox(stars2ca,'Error Inserting Closed Entry to track log')
		 RETURN -1
	End If
Next


//Update Status to closed for all tracks in this case
Update track
		 set  Status = :lv_status,
				status_datetime = :lv_date_time,
				status_desc     = 'Case Closed - Track is being Closed'
	where Case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using stars2ca;

If Stars2ca.of_check_status() <> 0 then
	 Errorbox(Stars2ca,'Error Updating Tracks to Closed Status')
	 RETURN -1
End IF

stars2ca.of_commit()

RETURN 0

end function

public subroutine wf_add_datawindow_title (string as_title, ref datawindow adw, string as_hdr_hgt, string as_title_x_pos, string as_title_align, string as_title_width);///////////////////////////////////////////////////////////////////////////////////////////////
//
//	Script:		w_case_maint.wf_add_datawindow_title
//
//	Arguments:	as_title			-	String containg the title of the datawindow
//					adw				-  The datawindow to be altered (passed by reference)
//					as_hdr_hgt		-  String containing the height of the header band, including
//											a line for the title
//					as_title_x_pos	-  String containing the x coordinate for the title
//					as_title_align	-  Alignment for title 
//												(0) - Left Alignment
//												(1) - Right Alignment
//												(2) - Center Alignment
//					as_title_width	-	Width of the title text
//
//	Returns:		None
//
//	Description:
//				This script will add the title passed in as a string (as_title) to the datawindow
//
//////////////////////////////////////////////////////////////////////////////////////////////
//	Modification History:
//
//	SAH	02/25/02	Stars 5.0	Track #2437 Created. Dictionary-ize d_case_log
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//////////////////////////////////////////////////////////////////////////////////////////////

String ls_hdr_hgt, ls_title_x_pos, ls_title_align, ls_title_width, ls_rc, ls_modstring
String ls_describe, ls_err
Integer li_rc
n_cst_string	lnv_string

// Prevent screen flicker
adw.SetRedraw(FALSE)

ls_hdr_hgt		=  as_hdr_hgt
ls_title_x_pos	=  as_title_x_pos
ls_title_align =  as_title_align
ls_title_width =  as_title_width

ls_modstring = "datawindow.header.height="  +  ls_hdr_hgt
ls_rc = adw.Modify(ls_modstring)

IF ls_rc <> "" THEN
	MessageBox('Datawindow Error', 'Error modifying datawindow in w_case_maint.wf_add_datawindow_title')
	Return
END IF

ls_modstring = " create text(band=foreground color='" + String( stars_colors.window_text ) + "' alignment='"  + ls_title_align + "'border='0' x='"  + &
			 ls_title_x_pos + "' y='2' height='36' width='" + ls_title_width + "' text=~'" +  as_title + "~'" + &
			 "name=header_t font.face='System' font.height='-10' font.weight='700' font.family='2' font.pitch='2'" + &
			 " font.charset='0' font.italic='0' font.strikethrough='0' font.underline='0' background.mode='1'" + &
			 " background.color='"  + String( stars_colors.window_background ) +  "' "
			 
//	Set Accessibility Properties
as_title = lnv_string.of_clean_string_acc( as_title )
ls_modstring += 'accessibledescription="~~"' + as_title + '~~"~~t~~"' + as_title + '~~"" accessiblename="~~"' + as_title + '~~"~~t~~"' + as_title + '~~"" accessiblerole=42 ) '
			 

ls_rc  =  adw.Modify(ls_modstring)
IF ls_rc <> "" THEN
	MessageBox('Datawindow Error', 'Error modifying datawindow in w_case_maint.wf_add_datawindow_title.')
	Return
END IF
	
	
ls_describe = adw.Describe("datawindow.syntax")
li_rc = adw.Create(ls_describe, ls_err)
	
IF li_rc = -1 THEN
	MessageBox('DataWindow Error', 'Error creating Dynamic DataWindow in w_case_maint.wf_add_datwindow_title.' + ls_err)
	Return
END IF

adw.SetRedraw(TRUE)
	
	
	
	
end subroutine

public subroutine of_set_is_operation (string as_operation);is_operation = as_operation
end subroutine

public function integer wf_validate_case_id (string arg_case_id);//wf_validate_case_id for w_case_maintain
//
//This window function will pull each character from the case id
//and validate that it is 0-9, A-Z, or a-z.
//Arguments: arg_case_id
//Returns: integer - 0 or -1	
//04-28-95 PLB Created
////////////////////////////////////////////////////////////////////
int lv_len,lv_index
string lv_char

lv_len = len(arg_case_id)
For lv_index = 1 to lv_len
	lv_char = mid(arg_case_id,lv_index,1)
	If Asc(lv_char) > 47 and Asc(lv_char) < 58 Then
		Continue
	ElseIf Asc(lv_char) > 64 and Asc(lv_char) < 91 Then
			Continue
		ElseIf Asc(lv_char) > 96 and Asc(lv_char) < 122 Then
				continue
			 Else
				Return -1
	End If
Next

return 0
end function

public function string wf_display_help_button (ref u_dw adw, string as_column);//*********************************************************************************
// Script Name:	wf_display_help_button
//
//	Arguments:		1.	adw - D/W to modify
//						2. as_column
//
// Returns:			None
//
//	Description:	This event will determine which help buttons will be displayed
//						on each of the datawindows.
//
//*********************************************************************************
//	
// 01/18/01	FDG	Stars 4.6 (PIMR) - Created
//	05/02/01	FDG	Stars 4.7.	Return a modify string so that only one Modify is
//						performed.
// 06/05/02 JAS	Track 3096d - moved the ls_modify definition into if statement to handle 
//						turning on buttons
//*********************************************************************************

String	ls_find,			&
			ls_modify,		&
			ls_describe,	&
			ls_rc

Long		ll_row,			&
			ll_rowcount

// Find the column in stars_win_parm
ls_find		=	"col_name = '"	+	Upper(as_column)	+	"'"

ll_rowcount	=	ids_win_parm.RowCount()
ll_row		=	ids_win_parm.Find (ls_find, 1, ll_rowcount)
// Begin - Track 3096d  Commented out and added in if statement below
//ls_modify	=	"cb_"	+	as_column	+	".Visible=0 "
// End - Track 3096d

IF	ll_row	<	1		THEN
	// FDG 05/02/01 - Return a modify string
	//ls_rc	=	adw.Modify (ls_modify)
	// Begin - Track 3096  if not found in help list disable it
	ls_modify	=	"cb_"	+	as_column	+	".Visible=0 "
	// End - Track 3096
	Return	ls_modify
ELSE
	// If the column is invisible, make its button invisible
	ls_describe	=	as_column	+	".Visible"
	ls_describe	=	adw.Describe (ls_describe)
	IF	ls_describe				=	'0'		&
	OR	Upper(ls_describe)	=	'NO'		THEN
		// FDG 05/02/01 - Return a modify string
		//ls_rc	=	adw.Modify (ls_modify)
		// Begin - Track 3096d Moved ls_modify definition within if statement and added else so 
		// that if button is invisible and needs to be made visible it will work (ie cb_pmr_ready_date)
		ls_modify	=	"cb_"	+	as_column	+	".Visible=0 "
		Return	ls_modify
	ELSE
		ls_modify	=	"cb_"	+	as_column	+	".Visible=1 "
		Return ls_modify
		// End - Track 3096d
	END IF
END IF

Return	''
end function

public subroutine wf_target ();//*******************************************************************
//
//	Script for W_Case_maint - Target
//
//*******************************************************************
// Modifications
//*******************************************************************
//
// 07/24/02	Jason	Track 3188d	Comment out all code, run same function
//										m_stars30/case/target/add is running
//	09/12/03	GaryR	Track 5678c	Display the Target List screen not Add
//										as indicated above
//
//*******************************************************************

fx_m_listtargetlists()
end subroutine

public subroutine of_update_last_update_header ();////////////////////////////////////////////////////////////////////////////
//
//	08/31/05	GaryR	Track 4501d	Convert string dates to dates and set initial value
//
////////////////////////////////////////////////////////////////////////////

datetime dt_log_change, dt_track_change, ldt_default
string ls_case_id, ls_case_spl, ls_case_ver

ldt_default = Datetime(Date("01/01/1900"))
ls_case_id = tab_case.tabpage_general.dw_general.getItemstring(1, "case_id")
ls_case_spl = tab_case.tabpage_general.dw_general.getItemstring(1, "case_spl")
ls_case_ver = tab_case.tabpage_general.dw_general.getItemstring(1, "case_ver")


Select max(sys_datetime)
into :dt_log_change
from case_log
where case_id = :ls_case_id
and case_spl = :ls_case_spl
and case_ver = :ls_case_ver
using stars2ca;


Select max(status_datetime)
into :dt_track_change
from track_log
where case_id = :ls_case_id
and case_spl = :ls_case_spl
and case_ver = :ls_case_ver
using stars2ca;

if isnull(dt_track_change) then
	dt_track_change = ldt_default
end if

if isnull(dt_log_change) then
	dt_log_change = ldt_default
end if

IF dt_log_change = ldt_default AND dt_track_change = ldt_default THEN
	dw_headings.setitem(1, "last_update", string(DateTime(Today(),Now()), "mm/dd/yyyy HH:MM:SS"))
ELSE
	If dt_log_change > dt_track_change then
		dw_headings.setitem(1, "last_update", string(dt_log_change, "mm/dd/yyyy HH:MM:SS"))		
	else
		dw_headings.setitem(1, "last_update", string(dt_track_change, "mm/dd/yyyy HH:MM:SS"))		
	end if
END IF
end subroutine

on w_case_maint.create
int iCurrent
call super::create
this.cb_track=create cb_track
this.cb_retrieve=create cb_retrieve
this.cb_update=create cb_update
this.cb_create=create cb_create
this.cb_delete=create cb_delete
this.cb_clear=create cb_clear
this.cb_more=create cb_more
this.cb_close=create cb_close
this.cb_next=create cb_next
this.cb_prev=create cb_prev
this.tab_case=create tab_case
this.p_notes=create p_notes
this.dw_headings=create dw_headings
this.cb_next_current=create cb_next_current
this.cb_close_current=create cb_close_current
this.cb_prev_current=create cb_prev_current
this.cb_select_track=create cb_select_track
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_track
this.Control[iCurrent+2]=this.cb_retrieve
this.Control[iCurrent+3]=this.cb_update
this.Control[iCurrent+4]=this.cb_create
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_clear
this.Control[iCurrent+7]=this.cb_more
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_next
this.Control[iCurrent+10]=this.cb_prev
this.Control[iCurrent+11]=this.tab_case
this.Control[iCurrent+12]=this.p_notes
this.Control[iCurrent+13]=this.dw_headings
this.Control[iCurrent+14]=this.cb_next_current
this.Control[iCurrent+15]=this.cb_close_current
this.Control[iCurrent+16]=this.cb_prev_current
this.Control[iCurrent+17]=this.cb_select_track
end on

on w_case_maint.destroy
call super::destroy
destroy(this.cb_track)
destroy(this.cb_retrieve)
destroy(this.cb_update)
destroy(this.cb_create)
destroy(this.cb_delete)
destroy(this.cb_clear)
destroy(this.cb_more)
destroy(this.cb_close)
destroy(this.cb_next)
destroy(this.cb_prev)
destroy(this.tab_case)
destroy(this.p_notes)
destroy(this.dw_headings)
destroy(this.cb_next_current)
destroy(this.cb_close_current)
destroy(this.cb_prev_current)
destroy(this.cb_select_track)
end on

event ue_retrieve;///////////////////////////////////////////////////////////////////////////////////////////
//	Event:	ue_retrieve
//
//	Description:
//				Retrieve the case_cntl data for this window.
//
///////////////////////////////////////////////////////////////////////////////////////////
//	History:
//
// 05/30/00	FNC	The initial retrieve of the case_business dddw was set to 
//						retrieve case_status. This has now been corrected.
//	01/14/01	FDG	Stars 4.6 - PIMR.  Add new PIMR data.
//	07/24/01	GaryR	Track 2373d	DB Error inserting null into SYS_CNTL
//	09/05/01	GaryR	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//	09/13/01	FDG	Stars 4.8.	Don't allow any updates if the case is referred.
//	11/06/01	FDG	Stars 4.8.1	Filter case_asgn_id based on dept_id.
// 03/14/02 SAH   Track 2862  Dictionary-ize case log; dw_display_log now calls
//										n_case_labels.of_labels2 for column formatting and
//										dw_log now hidden dw.
//	06/17/02	GaryR	Track 2962	Do not display SYSTEM dispositions in dropdown.
// 07/25/02 Jason	Track 3190d Call uf_filter_sys_code with in_case_dispostion 
//	08/06/02 Jason	Track 3029d Add blanks to dddw's so user can set field back to nothing
//	05/21/03	GaryR	Track 3591d Move the reset date logic before locking fields on closed cases
// 10/26/04 Jason Track 3573 Case Headings
// 02/14/05 MikeF	Track 4290d	Missing Case headings - moved call
//	03/03/05	GaryR	Track 4337d	Do not open Case Folder when referring case
///////////////////////////////////////////////////////////////////////////////////////////

String	ls_case,				&
			ls_case_spl,		&
			ls_case_ver,		&
			ls_period_from,	&
			ls_period_to,		&
			ls_cust_field[],	&
			ls_modify,			&
			ls_error,			&
			ls_desc,				&
			ls_default_status,&
			ls_msg,				&
			ls_note_rel_id,	&
			ls_disp_hold,		&
			ls_contractor_id,	&
			ls_created_cd,		&
			ls_find,				&
			ls_deptid,			&
			ls_empty
			
Integer	li_nbr_cust_fields,&
			li_field,			&
			li_rc,				&
			li_count
			
datetime	ldte_today

Long		ll_rows_disp,		&
			ll_rows_status,	&
			ll_rows,				&
			ll_row_general,	&
			ll_found,			&
			ll_cntl_no,			&
			ll_rows_business
			
// JasonS 08/06/02 Begin - Track 3029d
datawindowchild dw_contractor
datawindowchild dw_specialty
// JasonS 08/06/02 End - Track 3029d
			
		
SetPointer(Hourglass!)		
setMicroHelp(w_main,'Ready')

ldte_today = gnv_app.of_get_server_date_time()

//If there's a row before we do a retrieve, cb_clear was clicked and we're
// either doing a new retrieve or creating a new case
// in_from = M is new retrieve/in_from = A or N is create new case
ll_rows = tab_case.tabpage_general.dw_general.GetRow()
// FDG 09/13/01 - include edit for referred case
if ll_rows > 0 then
	IF in_from <> 'A' then
		tab_case.tabpage_general.dw_general.AcceptText()
		ls_case		= tab_case.tabpage_general.dw_general.object.case_id[ll_rows]
		ls_case_spl	= tab_case.tabpage_general.dw_general.object.case_spl[ll_rows]
		ls_case_ver	= tab_case.tabpage_general.dw_general.object.case_ver[ll_rows]
		if trim(ls_case) = '' then
			MessageBox('Edit','Case ID, SPL and VER are required')
			tab_case.SelectTab('tabpage_general')
			tab_case.tabpage_general.dw_general.SetColumn('case_id')
			tab_case.tabpage_general.dw_general.SetFocus()
			in_bad_retrieve = TRUE
			return
		elseif trim(ls_case_spl) = '' then
			MessageBox('Edit','Case ID, SPL and VER are required')
			tab_case.SelectTab('tabpage_general')
			tab_case.tabpage_general.dw_general.SetColumn('case_spl')
			tab_case.tabpage_general.dw_general.SetFocus()
			in_bad_retrieve = TRUE
			return
		elseif trim(ls_case_ver) = '' then
			MessageBox('Edit','Case ID, SPL and VER are required')
			tab_case.SelectTab('tabpage_general')
			tab_case.tabpage_general.dw_general.SetColumn('case_ver')
			tab_case.tabpage_general.dw_general.SetFocus()
			in_bad_retrieve = TRUE
			return
		end if
	END IF
else
	ls_case		=	Left (is_active_case, 10)
	ls_case_spl	=	Mid (is_active_case, 11, 2)
	ls_case_ver	=	Mid (is_active_case, 13, 2)
end if

//security check
//if A=Add Case, N=Copy case (coming from cb_Create)
if in_from <> 'A' AND in_from <> 'N' then
	ls_msg = inv_case.uf_edit_case_security(ls_case,ls_case_spl,ls_case_ver)
	IF len(ls_msg) > 0 THEN
		MessageBox('ERROR',ls_msg)
		this.event ue_initialize_case()
		in_bad_retrieve = TRUE
		return
	end if
end if


//retrieve for General tab
ll_rows		=	tab_case.tabpage_general.dw_general.Retrieve (ls_case, ls_case_spl, ls_case_ver)

//get handle for dropdowns on dw_current on Savings tab
tab_case.tabpage_current.dw_current.getchild('case_disp',idwc_case_disp)
idwc_case_disp.settransobject(stars2ca)
ll_rows_disp = idwc_case_disp.retrieve()

tab_case.tabpage_current.dw_current.getchild('case_status',idwc_case_status)
idwc_case_status.settransobject(stars2ca)
ll_rows_status = idwc_case_status.retrieve()

tab_case.tabpage_general.dw_general.getchild('case_business',idwc_case_business)
idwc_case_business.settransobject(stars2ca)
ll_rows_business = idwc_case_business.retrieve()		// FNC 05/30/00
		
// FDG 01/14/01 - begin
tab_case.tabpage_current.dw_current.getchild('pmr_custom3_cd',idwc_custom3_cd)
idwc_custom3_cd.settransobject(stars2ca)
ll_rows_status = idwc_custom3_cd.retrieve()


tab_case.tabpage_current.dw_current.getchild('pmr_custom1_cd',idwc_custom1_cd)
idwc_custom1_cd.settransobject(stars2ca)
ll_rows_status = idwc_custom1_cd.retrieve()


tab_case.tabpage_current.dw_current.getchild('pmr_custom4_cd',idwc_custom4_cd)
idwc_custom4_cd.settransobject(stars2ca)
ll_rows_status = idwc_custom4_cd.retrieve()


tab_case.tabpage_current.dw_current.getchild('pmr_custom5_cd',idwc_custom5_cd)
idwc_custom5_cd.settransobject(stars2ca)
ll_rows_status = idwc_custom5_cd.retrieve()


tab_case.tabpage_pimr.dw_pimr.getchild('pmr_custom2_cd',idwc_custom2_cd)
idwc_custom2_cd.settransobject(stars2ca)
ll_rows_status = idwc_custom2_cd.retrieve()
// FDG 01/14/01 - end

// JasonS 08/06/02 Begin - Track 3029d
tab_case.tabpage_general.dw_general.getchild('pmr_contractor_id', dw_contractor)
tab_case.tabpage_general.dw_general.getchild('case_prov_spec', dw_specialty)
idwc_custom3_cd.insertrow(1)	
idwc_custom1_cd.insertrow(1)	
idwc_custom4_cd.insertrow(1)	
idwc_custom5_cd.insertrow(1)	
dw_contractor.insertrow(1)
dw_specialty.insertrow(1)
dw_contractor.setitem(1,'code_description', ' ')
dw_contractor.setitem(1,'code_code', ' ')
dw_specialty.setitem(1,'code_description', ' ')
dw_specialty.setitem(1,'code_code', ' ')
idwc_custom3_cd.setitem(1,'code_description', ' ')
idwc_custom3_cd.setitem(1,'code_code', ' ')
idwc_custom1_cd.setitem(1,'code_description', ' ')
idwc_custom1_cd.setitem(1,'code_code', ' ')
idwc_custom4_cd.setitem(1,'code_description', ' ')
idwc_custom4_cd.setitem(1,'code_code', ' ')
idwc_custom5_cd.setitem(1,'code_description', ' ')
idwc_custom5_cd.setitem(1,'code_code', ' ')
// JasonS 08/06/02 End - Track 3029d

//iv_bus_dflt was set in open().  Will be used to prepopulate case_business dropdown
//											but if not found, set to empty
ls_find = "code_code = '" + iv_bus_dflt + "'"
ll_found = idwc_case_business.find(ls_find,1,idwc_case_business.RowCount())
if ll_found < 1 then
	iv_bus_dflt = ''
end if

// Share the data between dw_general and the other tabs.
tab_case.tabpage_general.dw_general.ShareData (tab_case.tabpage_current.dw_current)
tab_case.tabpage_general.dw_general.ShareData (tab_case.tabpage_savings.dw_savings)
tab_case.tabpage_general.dw_general.ShareData (tab_case.tabpage_pimr.dw_pimr)				// FDG 01/14/01

if ll_rows > 0 then
		//populate instance variables 
		// FDG 09/21/01 - save instance variables in ue_set_instance
		This.Event	ue_set_instance()
		ls_deptid		= tab_case.tabpage_general.dw_general.object.dept_id[ll_rows]		// FDG 11/06/01
		ls_disp_hold	= tab_case.tabpage_general.dw_general.object.case_disp_hold[ll_rows]
		ls_created_cd	=	tab_case.tabpage_general.dw_general.object.pmr_created_cd[ll_rows]	// FDG 01/14/01 //FDG 04/25/01
		// FDG 09/21/01 end
		//Set the gv_case_disp to MYHOLD if I'm holding the case otherwise
		//set it to HOLD if another user has it
		If ls_disp_hold = 'HOLD' then
			If gv_case_disp <> 'MYHOLD' then
				gv_case_disp = 'HOLD'
				IF Messagebox('EDIT','Case is Actively being Worked on by Another User, Proceed to View the Case',Question!,YesNo!,2) = 2 then					
					COMMIT using STARS2CA;
					If stars2ca.of_check_status() <> 0 Then
						errorbox(stars2ca,'Error Committing to Stars2')
						Return
					End If	
					ib_close = true
					RETURN
				End If
			END iF
		End If
		this.event ue_set_menu_refer(TRUE)
		this.event ue_set_menu_track(TRUE)
		this.event ue_set_menu_more(TRUE)
		in_from = 'M'
		tab_case.tabpage_general.dw_general.object.case_id.protect = 1
		tab_case.tabpage_general.dw_general.object.case_spl.protect = 1
		tab_case.tabpage_general.dw_general.object.case_ver.protect = 1
		tab_case.tabpage_general.dw_general.object.dept_id.Protect = 1
		This.Event	ue_filter_userid (ls_deptid)						// FDG 11/06/01
		if match(this.title,'Case Details') or match(this.title,'Case Add') then
			gv_active_case = in_case_id + in_case_spl + in_case_ver
			is_active_case = gv_active_case
		end if
		
		// FDG 01/14/01 - If file sent to PIMR, proted Ready for PIMR code
		IF	ls_created_cd	=	'Y'		THEN
			tab_case.tabpage_current.dw_current.object.pmr_ready_cd.Protect	=	1
		END IF
		if in_from = 'M' then
			tab_case.selectTab("tabpage_general")
			tab_case.tabpage_general.dw_general.SetColumn("case_desc")
			this.event ue_set_menu_create(FALSE)
			this.event ue_set_menu_update(TRUE)
			
			If trim(gv_user_sl) <> '' then
				im_general.m_menu.m_delete.enabled = TRUE
			Else
				im_general.m_menu.m_delete.enabled = FALSE
			End If
			
			// Reset 01/01/1900 to show 00/00/0000 to the user
			This.Event ue_reset_dates()
			
			// FDG 09/13/01 begin  - If case is referred, do not allow any updates
			IF	This.Event	ue_edit_enable_update()	=	FALSE		THEN
			ELSE 
				// FDG 09/13/01 - end
				If gv_case_disp = 'HOLD' then
					// FDG 09/13/01 - disable via ue_enable_update
					w_main.SetMicroHelp ("Case cannot be changed since it's held by another user")
					This.Event	ue_enable_update (FALSE)
				Elseif gv_case_disp <> 'MYHOLD' then
					gv_case_disp = 'MYHOLD'
					Update Case_CNTL
						set case_disp_hold = 'HOLD'
						where  case_id  = Upper( :in_case_id ) and 
								 case_spl = Upper( :in_case_spl ) and
								 case_ver = Upper( :in_case_ver )
					Using  stars2ca;
					If stars2ca.of_check_status() <> 0 then
						in_case_id             = ''
						in_case_spl            = ''
						in_case_ver            = ''
						in_bad_retrieve        = true
						Errorbox(Stars2ca,'Unable to Update Retrieval Status on Case')
						in_bad_retrieve = TRUE
						RETURN
					End If
					
					//	07/24/01	GaryR	Track 2373d - Begin
					gnv_sql.of_TrimData( ls_empty )
					Insert into Sys_Cntl
						(cntl_id,cntl_no,cntl_date,cntl_case,cntl_text)
					  Values
						(:gc_user_id,0,:ldte_today,:is_active_case,:ls_empty)
					Using Stars2ca;
					//	07/24/01	GaryR	Track 2373d - End
					If stars2ca.of_check_status() <> 0 then
						in_case_id             = ''
						in_case_spl            = ''
						in_case_ver            = ''
						in_bad_retrieve        = true
						Errorbox(Stars2ca,'Unable to Update Retrieval Status on Case')
						in_bad_retrieve = TRUE
						RETURN
					End If
				End If
			END IF//case_disp = SYSDEL -- NLG 02-29-00
		end if//if in_from = M
Elseif ll_rows = 0 then

		ll_rows = tab_case.tabpage_general.dw_general.InsertRow(0)	

		//get handle for 2 dropdowns on dw_current on Current tab
		li_rc = tab_case.tabpage_current.dw_current.getchild('case_disp',idwc_case_disp)
		li_rc = idwc_case_disp.settransobject(stars2ca)
		ll_rows_disp = idwc_case_disp.retrieve()

		li_rc = tab_case.tabpage_current.dw_current.getchild('case_status',idwc_case_status)
		li_rc = idwc_case_status.settransobject(stars2ca)
		ll_rows_status = idwc_case_status.retrieve()
		
		this.triggerevent("ue_initialize_case")
		
		tab_case.tabpage_general.dw_general.object.case_spl.protect = 1
		tab_case.tabpage_general.dw_general.object.case_ver.protect = 1
		tab_case.tabpage_current.dw_current.object.case_status_date.protect = 1
		
		ll_found = 0
		ll_found = idwc_case_status.find("code_code = 'OP'",1,ll_rows_status)
		if ll_found > 0 then
			ls_default_status = idwc_case_status.GetItemString(ll_found,'code_description')
		else
			ls_default_status = ' '
		end if 
	
		tab_case.tabpage_general.dw_general.setItem(ll_rows,'case_status',ls_default_status)
		tab_case.tabpage_general.dw_general.setItem(ll_rows,"case_updt_user",gc_user_id)
ELSE
	in_bad_retrieve = TRUE
	return
End if

//	06/17/02	GaryR	Track 2962 - Begin
//	Filter out system codes from DDDWs
// If datawindow is marked as Read-Only
// then allow codes for decoding.
IF in_case_disposition <> "SYSDELET" AND in_case_disposition <> "REFERRED" THEN
	// JasonS 07/25/02 Begin - Track 3190d
	ll_rows_disp = inv_case.uf_filter_sys_codes( idwc_case_disp, in_case_disposition )
	ll_rows_status = inv_case.uf_filter_sys_codes( idwc_case_status, '' )
	// JasonS 07/25/02 Begin - Track 3190d
END IF
//	06/17/02	GaryR	Track 2962 - End

tab_case.tabpage_general.dw_general.SetColumn("case_id")

//Determine whether using custom money fields 
inv_case.uf_format_custom_headings(tab_case.tabpage_savings.dw_savings)
inv_case.uf_format_custom_headings(tab_case.tabpage_general.dw_general)		// FDG 01/14/01
inv_case.uf_format_custom_headings(tab_case.tabpage_current.dw_current)		// FDG 01/14/01
inv_case.uf_format_custom_headings(tab_case.tabpage_pimr.dw_pimr)				// FDG 01/14/01
inv_case.uf_format_custom_headings(tab_case.tabpage_track.dw_track)

// SAH 03/14/02 Track 2862

// FDG 01/18/01 - PIMR: Hide the buttons not being used.  Perform after calling inv_case.uf_format_custom_headings.
This.Event	ue_display_help_buttons()

//NLG get tab order working -- must set focus on description
tab_case.SelectTab('tabpage_general')
tab_case.tabpage_general.dw_general.SetColumn('case_desc')
tab_case.tabpage_general.dw_general.SetFocus()

COMMIT USING STARS2CA;

// FDG 01/14/01 - Hide/display pmr_ready_date and pmr_created_date
This.Event	ue_display_ready_cd()

//read to see if notes exist for case
ls_note_rel_id = in_case_id + in_case_spl + in_case_ver
Select count(*) into :li_count
From Notes
Where note_rel_type = 'CA' 
and note_rel_id = Upper( :ls_note_rel_id )
using stars2ca;
if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error reading Notes table: Note_rel_type = CA and note_rel_id = ' + ls_note_rel_id)
	return
end if

if li_count > 0 then
	p_notes.visible = true
	p_notes.enabled = true
else
	p_notes.visible = false
	p_notes.enabled = false
end if

//NLg 11-1-99
//	Retrieve the case_log data for this case.
This.Event	ue_retrieve_log()

//	Retrieve the tracks for this case.
This.Event	ue_retrieve_track()

//NLG 10-26-99 
this.event ue_set_window_title()

// Track 3573 case headings
event ue_populate_headings()

//Enable these fields so if the category is changed they can be updated
If in_case_cat = 'REF' or in_case_cat = 'CA?' then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	

	//cb_track.enabled = false
	this.event ue_set_menu_track(FALSE)
	in_track_exists  = false
	
	//if in_case_cat='CA?' then cb_refer.enabled = false
	if in_case_cat='CA?' then 
		this.event ue_set_menu_refer(FALSE)
	end if
		
   setpointer(arrow!)
	RETURN
End If

select count(*) into :li_count
	from  track
	where  case_id  = Upper( :in_case_id ) and 
			 case_spl = Upper( :in_case_spl ) and
			 case_ver = Upper( :in_case_ver )
Using  stars2ca;

If stars2ca.of_check_status() <> 0 then 
	Errorbox(stars2ca,'ERROR reading track Table')
	return
End If

If li_count > 0 then
	in_track_exists            = true
Else
	in_track_exists            = false
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

//Disable refer fields if there is a case link or track created
If trim(in_case_refer_to) <>  '' then
	sv_ReferEnabled  = false
Else
  	sv_ReferEnabled  = true
End If

setpointer(arrow!)
end event

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////
//
//	Script:		w_case_maint.open
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//
//
//////////////////////////////////////////////////////////////////////////////////////
//	Modification History:
//
//	GaryR 06/27/00 Ts 2310D	Uncomment return statement and add Else 
//						and End If to accomodate Florence's changes.
//	FDG	01/18/01	Stars 4.6 (PIMR) - Set the PIMR tab. 
//	FDG	09/12/01	Stars 4.8.  Register dw_track & dw_log to inv_case.
// SAH	01/07/02 Stars 5.0   Save dept_id dddw info in ds to avoid
//										multiple retrieves.
// 
//	JasonS 08/29/02 Track 3287d  Re-arrange/comment misc code for performance									
//									  
//
//////////////////////////////////////////////////////////////////////////////////////

integer 	li_rc,			&
			li_row,			&
			li_rowcount,	&
			li_cntl_no,		&
			li_idx

long ll_found,     	&
     ll_rowcount,		&
	  ll_row,			&
	  ll_rows

string 	ls_case_cat,		&
			ls_return,			&
			ls_cntl_text

datawindowchild ldwc_case_status,ldwc_case_disp
datawindowchild ldwc_case_cat			// FNC 06/07/00

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

is_prev_save_msg	=	is_save_successful_msg		// FDG 01/18/01

inv_case = create n_cst_case
//inv_log = create n_cst_case 		// JasonS 08/29/02 Track 3287d

//Register dw_general to inv_case
inv_case.uf_set_case_dw(tab_case.tabpage_general.dw_general)
inv_case.uf_set_track_dw (tab_case.tabpage_track.dw_track)		// FDG 09/12/01
inv_case.uf_set_case_log_dw (tab_case.tabpage_log.dw_log)		// FDG 09/12/01
inv_case.uf_set_case_log_display_dw(tab_case.tabpage_log.dw_display_log)		// SAH 03/04/02

//Register dw_log to inv_case
//inv_log.uf_set_case_dw(tab_case.tabpage_log.dw_log)	// JasonS 08/29/02 Track 3287d

//is_active_case	=	gv_active_case

li_row =	tab_case.tabpage_current.dw_current.InsertRow(0)
li_rc 	= 	tab_case.tabpage_current.dw_current.ScrollToRow (li_row)


//This.of_set_sys_cntl_range (TRUE)	// JasonS 08/29/02 Track 3287d
//open (w_case_maint_uo)




// set the tracking type for startup
  SELECT USERS.BUS_DFLT  
    INTO :iv_bus_dflt  
    FROM USERS  
   WHERE USERS.USER_ID = Upper( :gc_user_id )
   USING stars2ca  ;

If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'ERROR retrieving business default from user table')
   return
End If

im_general.m_menu.m_retrieve.enabled = FALSE

idt_create_date = datetime(gnv_app.of_get_server_date())

If in_from = 'A' or in_from = 'N' then
		// JasonS 08/29/02 Begin - Track 3287d
		//COMMIT using STARS2CA;
		//If stars2ca.of_check_status() <> 0 Then
		//	errorbox(stars2ca,'Error Committing to Stars2')
		//	Return
		//End If	
		// JasonS 08/29/02 End - Track 3287d
		
		//this.title = 'Case Add'
		is_title = 'Case Add'
		
		//NLG 02-29-00 Set the window title right away Track #2139
		this.event ue_set_window_title()

		gv_active_case = ''		

   	sv_ReferEnabled  = false
		
		this.event ue_set_menu_create(TRUE)
		this.event ue_set_menu_refer(FALSE)
		this.event ue_set_menu_track(FALSE)
		this.event ue_set_menu_update(FALSE)
		this.event ue_set_menu_more(FALSE)
		
		im_general.m_menu.m_delete.enabled = FALSE
		
		p_notes.visible = false	//make Notes picture invisible (notes don't exist)
		p_notes.enabled = false	//make Notes picture invisible (notes don't exist)
		
		//	FDG 01/18/01 - Disable ready for pimr
		This.Event	ue_enable_ready_for_pimr (FALSE)

		//return  Gary-R 06/27/2000 Ts 2310D
ELSE	// Gary-R 06/27/2000 Ts 2310D

		//Coming in from List screen
		// JasonS 08/29/02 Begin - Track 3287d
		//COMMIT using STARS2CA;
		//If stars2ca.of_check_status() <> 0 Then
		//	errorbox(stars2ca,'Error Committing to Stars2')
		//	Return
		//End If	
		// JasonS 08/29/02 End - Track 3287d		
		 
		is_active_case = trim(gv_active_case)
		If is_active_case = '' then
			tab_case.SelectTab("tabpage_general")
			tab_case.tabpage_general.dw_general.SetColumn("case_id")
			tab_case.tabpage_general.dw_general.SetFocus()
			setmicrohelp(w_main,'Enter Case Id')
		Else
		end if
		
		
		is_title = this.of_get_title()
		
		this.event ue_set_menu_more(TRUE)
		this.event ue_set_menu_create(FALSE)
		
		//	FDG 01/18/01 - Enable ready for pimr
		This.Event	ue_enable_ready_for_pimr (TRUE)
	
END IF	// Gary-R 06/27/2000 Ts 2310D

// FNC 06/07/00 Start
tab_case.tabpage_general.dw_general.getchild('case_cat',ldwc_case_cat)
li_RowCount = ldwc_case_cat.rowcount()
for li_row = 1 to li_rowcount
	ls_case_cat = ldwc_case_cat.getitemstring(li_row,1)
	ls_return = inv_case.uf_edit_case_security(ls_case_cat)
	if len(ls_return) > 0 then
		ldwc_case_cat.deleterow(li_row)
		li_row --
		li_rowcount --
	end if
next
// FNC 06/07/00 End

// FDG 01/18/01 - Enable/Disable the PIMR tab and set its text
Select	cntl_no
Into		:li_cntl_no
From		sys_cntl
Where		cntl_id	=	'USEPIMR'
Using		Stars2ca;

Stars2ca.of_check_status()

IF	li_cntl_no	=	0		THEN
	tab_case.tabpage_pimr.enabled	=	FALSE
ELSE
	tab_case.tabpage_pimr.enabled	=	TRUE
	IF	li_cntl_no	=	1		THEN
		ib_use_pimr	=	TRUE
	END IF
END IF

Select	cntl_text
Into		:ls_cntl_text
From		sys_cntl
Where		cntl_id	=	'PIMRTEXT'
Using		Stars2ca;

Stars2ca.of_check_status()

IF	Len (ls_cntl_text)	>	0		THEN
	tab_case.tabpage_pimr.text	=	ls_cntl_text
END IF
// FDG 01/18/01 end


// SAH 01/07/02 begin
// Store dept info in datastore
ids_code = CREATE n_ds
ids_code.DataObject = 'd_dddw_case_dept_2'
ids_code.SetTransObject( Stars2ca )
ll_rows = ids_code.Retrieve( )

IF ll_rows = -1 THEN
	MessageBox("Error", "Error Retrieving Department Information")
	Return -1
END IF

// SAH 01/07/02 end



end event

event ue_postopen;call super::ue_postopen;//****************************************************************************
// FNC	05/01/00	Set redraw without referencing window name because this script
//						is run by descendents of this window.
// Jason 11/26/02 Track 3374d Case Performance
// Jason 12/06/04 Track 3664d Case Component Update
// Katie 01/12/05 Track 4237 Adjusted if-then's to not call  ue_set_update_availability if ue_close is called.
//	GaryR	02/01/05	Track 4267d	Add check for locked cases
//****************************************************************************

//ue_get_case calls ue_retrieve. A bad retrieve sets this boolean to true
in_bad_retrieve = FALSE

// JasonS 11/26/02 Begin - Track 3374d
this.event ue_retrieve()
this.SetRedraw(True)
// JasonS 11/26/02 End - Track 3374d

If (in_bad_retrieve = true) or (ib_close = TRUE) then
	this.event ue_close()
elseIF in_case_disposition <> 'SYSDELET' AND in_case_disposition <> 'REFERRED' AND gv_case_disp <> 'HOLD' then
	this.event ue_set_update_availability()
end if




end event

event ue_initialize_window;call super::ue_initialize_window;//NLG 10-26-99 Created new function: ue_set_window_title
//					which will be called here and after every retrieve
//					and every time window is cleared
//					Comment following code:
//String		ls_title
//
//ls_title	=	This.of_get_title()
//
//IF	Len (is_active_case)	>	0		THEN
//	This.Title	=	ls_title	+	' - '	+	is_active_case
//END IF

this.event ue_set_window_title()
end event

event ue_postsave;call super::ue_postsave;/*===============================================================================
Change History:
=================================================================================
//	11/21/02	Jason	Track 3374d Call re-retrieve for performance
//	12/06/04	Jason	Track 3664d Case Component Update
//	08/31/05	GaryR	Track 4501d	Refresh the header after update
================================================================================*/

// Reset 01/01/1900 to show 00/00/0000 to the user
This.Event ue_reset_dates()

//	09/05/01	GaryR	Stars 4.8	WIC #6 FS50-001	Case Reassignment
This.Event ue_reassign_case()

//	FDG 01/18/01 - Enable ready for pimr
This.Event	ue_enable_ready_for_pimr (TRUE)

// FDG	09/13/01	Stars 4.8.1 - Redetermine if updates are allowed
Boolean	lb_updateable
lb_updateable	=	This.Event	ue_edit_enable_update()
// FDG	09/13/01 Stars 4.8.1 - Reset any previously set instance variables
This.Event	ue_set_instance()

//	Re-retrive the case_log data for this case because the 
//	update process could have created new case logs.
// JasonS 11/21/02 Track 3374d
if tab_case.tabpage_log.enabled = true then
	This.Event	ue_re_retrieve_log()
else
	This.Event	ue_retrieve_log()
end if

this.event ue_set_update_availability()
this.event ue_populate_headings()

if isvalid(w_case_folder_view) then
	w_case_folder_view.event ue_set_update_availability()
end if

if isvalid(w_track_maint) then
	w_track_maint.event ue_set_update_availability()
end if

if isvalid(w_notes_maint) then
	w_notes_maint.event ue_set_update_availability()
end if

if isvalid(w_lead_maintain) then	
	w_lead_maintain.event ue_set_update_availability(true)
end if

if isvalid(w_target_maintain) then
	w_target_maintain.event ue_set_update_availability()
end if

Return 1

end event

event ue_preopen;//****************************************************************************
// FNC 05/01/00 	Set redraw without referencing window name because this script
//						is run by descendents of this window.
//****************************************************************************

in_from = Message.StringParm
SetNull(Message.StringParm)

// resize the controls within a tab
ib_ResizeTabControls	=	TRUE


//w_case_maint.SetRedraw(FALSE)	// FNC 05/01/00
this.setredraw(FALSE)				// FNC 05/01/00

//create the 6 menus
im_general = create m_case_general
im_current = create m_case_current
im_savings = create m_case_savings
im_pimr = create m_case_pimr		// FDG 02/16/01
im_log = create m_case_log
im_track = create m_case_track

end event

event rbuttondown;call super::rbuttondown;//NLG 10-22-99 More has been moved to menu

end event

event close;call super::close;//History
//	04-25-00	NLG	Use is_active_case instead of in_case_id, etc.
////////////////////////////////////////////////////////////////////

//4-25-00 NLG Start***
string ls_case_id, ls_case_spl, ls_case_ver
ls_case_id = left(is_active_case,10)
ls_case_spl = mid(is_active_case,11,2)
ls_case_ver = mid(is_active_case,13,2)
//4-25-00 NLG Stop***

//copied from w_case_maint::close() (pre-tab code)
//String lv_case
gv_from = ''

If gv_case_disp = 'MYHOLD'  then
	// 09/01/98 AJS   FS362 convert case to case_cntl
	//	04-25-00 NLG 	replace occurrences of in_case_id with ls_case_id
	//						replace occurrences of ls_case with is_active_case
	Update Case_CNTL 
		set
			case_disp_hold   = ' '
		Where		case_id	  = Upper( :ls_case_id ) AND
					case_spl   = Upper( :ls_case_spl ) AND
					case_ver   = Upper( :ls_case_ver )
	Using  stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error Writing Case with Original Disposition')
		RETURN
	End If
//	lv_case = in_case_id + in_case_spl + in_case_ver

	Delete from sys_cntl
		where cntl_id  = Upper( :gc_user_id ) and
				cntl_case = Upper( :is_active_case )	//lv_case
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error Releasing Hold Lock on Case')
		RETURN
	End If
	COMMIT USING STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	//Need to close the subset target maintain window so that hold locks get released
	If isvalid(w_target_subset_maintain) then
		close(w_target_subset_maintain)
	End IF
End IF

gv_case_disp = ''     //alabama2 pat-d

If isvalid(w_lead_list) then
	close(w_lead_list)
End IF

If isvalid(w_lead_maintain) then
	close(w_lead_maintain)
End IF

this.postevent("ue_postclose")
end event

event ue_presave;call super::ue_presave;///////////////////////////////////////////////////////////////////////////
//
//This event is automatically triggered from ue_save().  If this event
//returns -1, database will be rolled back and the updates will not occur.
//
///////////////////////////////////////////////////////////////////////////
//
// 12/09/04 Jason Track 3664d	Case Component update
//	10/04/05	GaryR	Track 4501d	Reset dates if validation fails.
//
///////////////////////////////////////////////////////////////////////////

int li_comp_upd_status
int li_num_open_tracks
string ls_case_id, ls_case_spl, ls_case_ver, ls_case_status
int li_button

ls_case_status = tab_case.tabpage_current.dw_current.GetItemString(1,'case_status')

if in_case_status <> ls_case_status AND ls_case_status = "CL" then

	ls_case_id = tab_case.tabpage_general.dw_general.object.case_id[1]
	ls_case_spl = tab_case.tabpage_general.dw_general.object.case_spl[1]
	ls_case_ver = tab_case.tabpage_general.dw_general.object.case_ver[1]
	
	select count(*)
	into :li_num_open_tracks
	from track
	where case_id = :ls_case_id
	and case_spl = :ls_case_spl
	and case_ver = :ls_case_ver
	and status <> 'CL'
	using stars2ca;
	
	select cntl_no
	into :li_comp_upd_status
	from sys_cntl
	where cntl_id = 'CASETRACK'
	using stars2ca;

	if li_comp_upd_status = 3 then
		if li_num_open_tracks > 0 then
			li_button = Messagebox("Warning", "There are " + string(li_num_open_tracks) + " open tracks for this case.~r~nDo you want to continue closing the case?", Question!, YesNo!)
			if li_button = 2 then
				return -1
			end if
		end if
	else
		if li_num_open_tracks > 0 then
			Messagebox("Error", "There are " + string(li_num_open_tracks) + " open tracks for this case.~r~nSTARS does not allow a case to be closed with ~r~n open tracks.  Please close the tracks, then close the case.")
			return -1
		end if
	end if
end if
//string ls_message
int li_rc
li_rc = this.event ue_edit_case()
if li_rc < 0 then
	stars2ca.of_rollback()
	This.event ue_reset_dates()
	return -1
end if 

return 1
end event

event activate;call super::activate;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

//NLG 11-1-99
//read to see if notes exist for case
string ls_note_rel_id
integer li_count,	li_rc
ls_note_rel_id = in_case_id + in_case_spl + in_case_ver
li_rc	=	gnv_sql.of_TrimData (ls_note_rel_id)			// FDG 04/16/01
Select count(*) into :li_count
From Notes
Where note_rel_type = 'CA' 
and note_rel_id = Upper( :ls_note_rel_id )
using stars2ca;
if stars2ca.of_check_status() <> 0 then
	//errorbox(stars2ca,'Error reading Notes table: Note_rel_type = CA and note_rel_id = ' + ls_note_rel_id)
	return
end if

if li_count > 0 then
	p_notes.visible = true
	p_notes.enabled = true
else
	p_notes.visible = false
	p_notes.enabled = false
end if
end event

event ue_open_rmm;call super::ue_open_rmm;//*********************************************************************************
// Script Name:	ue_open_rmm
//
//	Arguments:		none
//						
//
// Returns:			none
//
//	Description:	open right mouse menu depending on which tabpage is selected
//		
//
//*********************************************************************************
//	
// 10/21/99 NLG	Created
//	01/18/01	FDG	Stars 4.6 (PIMR) - Account for PIMR tab
//
//*********************************************************************************
Integer li_tab

li_tab = tab_case.selectedtab

choose case li_tab
	case ii_tp_general
		If IsValid(im_general) 	Then im_general.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_current
		If IsValid(im_current) 	Then im_current.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_savings
		If IsValid(im_savings) 	Then im_savings.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_pimr		// FDG 02/16/01
		If IsValid(im_pimr) 		Then im_pimr.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_log
		If IsValid(im_log) 		Then im_log.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_track
		If IsValid(im_track) 	Then im_track.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
end choose


end event

type cb_track from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Tracking Info..."
string accessibledescription = "Tracking Info..."
integer x = 55
integer y = 1144
integer width = 539
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Trac&king Info..."
end type

event clicked;//long ll_row
//
//setpointer(hourglass!)
//setmicrohelp(w_main,'Opening Tracking Info Screen')
//
//gv_active_case = is_active_case
//
//ll_row = tab_case.tabpage_general.dw_general.GetRow()
//iv_track_type = tab_case.tabpage_general.dw_general.object.case_type[ll_row]
//
//Open (w_case_tracking)
//
//If message.stringparm = 'Y' then
//	//KMM Clear out message parm (PB Bug)
//	SetNull(message.stringparm)
//	opensheet (w_tracking_list,MDI_Main_Frame,Help_Menu_Position,Layered!)
//End If
//
//tab_case.tabpage_track.enabled = true
//parent.Event	ue_retrieve_track()
//

parent.triggerevent("ue_tracking")
end event

type cb_retrieve from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 50
integer y = 1248
integer width = 357
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Retrie&ve"
end type

event clicked;in_from = 'M'
parent.event ue_retrieve()


end event

type cb_update from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 434
integer y = 1252
integer width = 306
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Update"
end type

event clicked;Parent.Event	ue_save()


end event

type cb_create from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 773
integer y = 1248
integer width = 306
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Cr&eate"
end type

event clicked;int li_rc


li_rc = Parent.Event	ue_save()


end event

type cb_delete from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1111
integer y = 1248
integer width = 306
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Delete"
end type

event clicked;Parent.Event	ue_delete_case()
end event

type cb_clear from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1801
integer y = 1248
integer width = 306
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "C&lear"
end type

event clicked;//If gv_case_disp = 'MYHOLD' then
//	Update Case_CNTL
//		set
//			case_disp_hold	  = ''
//		Where		case_id	  = :in_case_id AND
//					case_spl   = :in_case_spl AND
//					case_ver   = :in_case_ver
//	Using  stars2ca;
//	If stars2ca.of_check_status() <> 0  then
//		Errorbox(stars2ca,'Error Writing Case with Original Disposition')
//		RETURN
//	End If
//	Delete from sys_cntl
//		where cntl_id  = :gc_user_id and
//				cntl_case = :is_active_case
//	Using Stars2ca;
//	If stars2ca.of_check_status() <> 0  then
//		Errorbox(stars2ca,'Error Releasing Hold Lock on Case')
//		RETURN
//	End If
//	COMMIT using STARS2CA;
//	If stars2ca.of_check_status() <> 0 Then
//		errorbox(stars2ca,'Error Committing to Stars2')
//		Return
//	End If	
//	//Need to close the subset target maintain window so that hold locks get released
//	If isvalid(w_target_subset_maintain) then
//		close(w_target_subset_maintain)
//	End IF
//End IF
//gv_case_disp           = ''
//in_from = 'N'
//
//tab_case.tabpage_general.dw_general.SetRedraw(FALSE)
//
//parent.triggerevent("ue_initialize_case")
//
//tab_case.tabpage_general.dw_general.SetRedraw(TRUE)
//

parent.triggerevent("ue_clear_case")
end event

type cb_more from u_cb within w_case_maint
boolean visible = false
string accessiblename = "More..."
string accessibledescription = "More..."
integer x = 2139
integer y = 1248
integer width = 311
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&More..."
end type

event clicked;//parent.triggerevent (rbuttondown!)
parent.event ue_more()
end event

type cb_close from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2459
integer y = 1256
integer width = 357
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Close"
end type

event clicked;
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

gv_from = ''
close(parent)
end event

type cb_next from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2071
integer y = 1256
integer width = 357
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Next"
end type

event clicked;//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
Parent.Event	ue_scroll_tab(tab_case,+1)
end event

type cb_prev from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 1682
integer y = 1256
integer width = 357
integer taborder = 0
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&Prev"
end type

event clicked;//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
Parent.Event	ue_scroll_tab(tab_case,-1)
end event

type tab_case from tab within w_case_maint
event rbuttonup pbm_dwnrbuttonup
string accessiblename = "Case Tabs"
string accessibledescription = "Case Tabs"
accessiblerole accessiblerole = clientrole!
integer x = 27
integer y = 392
integer width = 3575
integer height = 1860
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_current tabpage_current
tabpage_savings tabpage_savings
tabpage_pimr tabpage_pimr
tabpage_log tabpage_log
tabpage_track tabpage_track
end type

on tab_case.create
this.tabpage_general=create tabpage_general
this.tabpage_current=create tabpage_current
this.tabpage_savings=create tabpage_savings
this.tabpage_pimr=create tabpage_pimr
this.tabpage_log=create tabpage_log
this.tabpage_track=create tabpage_track
this.Control[]={this.tabpage_general,&
this.tabpage_current,&
this.tabpage_savings,&
this.tabpage_pimr,&
this.tabpage_log,&
this.tabpage_track}
end on

on tab_case.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_current)
destroy(this.tabpage_savings)
destroy(this.tabpage_pimr)
destroy(this.tabpage_log)
destroy(this.tabpage_track)
end on

event selectionchanged;// FDG 01/14/01 - Stars 4.6 (PIMR) - Add PIMR tab
// SAH 03/13/02 - Stars 5.1 Track 2862 Remove d_case_log, add d_initial

cb_select_track.visible = FALSE

CHOOSE CASE newindex

CASE ii_tp_general
	Parent.of_SetPrintDW(tab_case.tabpage_general.dw_general)

CASE ii_tp_current
	Parent.of_SetPrintDW(tab_case.tabpage_current.dw_current)

CASE ii_tp_savings
	Parent.of_SetPrintDW(tab_case.tabpage_savings.dw_savings)
	
// FDG 01/14/01 begin	
CASE ii_tp_pimr
	Parent.of_SetPrintDW(tab_case.tabpage_pimr.dw_pimr)
// FDG 01/14/01 end
	
CASE ii_tp_log
	//Parent.of_SetPrintDW(tab_case.tabpage_log.dw_log)
	Parent.of_SetPrintDW(tab_case.tabpage_log.dw_display_log)
	
CASE ii_tp_track
	Parent.of_SetPrintDW(tab_case.tabpage_track.dw_track)
	cb_select_track.visible = TRUE

END CHOOSE

//Int num_tabs
//
//num_tabs = upperbound(tab_case.Control[])
Int num_tabs, tabs, i

num_tabs = upperbound(tab_case.Control[])
tabs = upperbound(tab_case.Control[])
for i = tabs to 1 step -1
	if tab_case.Control[i].enabled = TRUE then
		num_tabs = i
		exit
	end if
next

If newindex = 1 then
	cb_prev.enabled = false
Else
	cb_prev.enabled = true
End If

If newindex = num_tabs then
	cb_next.enabled = false
Else
	cb_next.enabled = true
End If
end event

event rightclicked;//*********************************************************************************
// Script Name:	rightclicked
//
//	Arguments:		none
//						
//
// Returns:			none
//
//	Description:	display right mouse menu
//		
//
//*********************************************************************************
//	
// 10/22/99 NLG	Created
//
//	Note: Whenever rbuttonup is used, always Return 1 to prevent the windows
//			Cut/Copy/Paste RMM from displaying
//
//*********************************************************************************
Parent.Post Event ue_open_rmm()

Return 1
end event

event key;//*********************************************************************************
// Script Name:	key
//
//	Arguments:		none
//						
//
// Returns:			none
//
//	Description:	display right mouse menu
//		
//
//*********************************************************************************
//	
// 10/22/99 NLG	Created
//
//	Note: Whenever rbuttonup is used, always Return 1 to prevent the windows
//			Cut/Copy/Paste RMM from displaying
//
//*********************************************************************************
IF	KeyDown (KeyF12!)		THEN
	Parent.Post Event ue_open_rmm()
END IF
Return 1


end event

type tabpage_general from userobject within tab_case
string accessiblename = "General"
string accessibledescription = "General"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3538
integer height = 1744
long backcolor = 67108864
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
uo_general uo_general
dw_general dw_general
end type

on tabpage_general.create
this.uo_general=create uo_general
this.dw_general=create dw_general
this.Control[]={this.uo_general,&
this.dw_general}
end on

on tabpage_general.destroy
destroy(this.uo_general)
destroy(this.dw_general)
end on

type uo_general from uo_tabpage_rmm within tabpage_general
string accessiblename = "Case General Info"
string accessibledescription = "Case General Info"
integer x = 9
integer y = 16
integer width = 3529
integer height = 1724
end type

on uo_general.destroy
call uo_tabpage_rmm::destroy
end on

type dw_general from u_dw within tabpage_general
string accessiblename = "Case General Info"
string accessibledescription = "Case General Info"
integer x = 14
integer y = 72
integer width = 3447
integer height = 1268
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_case_general"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
This.SetTransObject (Stars2ca)

// Perform the update at the same time the delete occurs
This.of_SetSingleRow (TRUE)

//	This is the updateable datawindow
idw_update	=	This

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
This.of_SetTrim (TRUE)

end event

event itemchanged;
w_case_maint	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event ue_edits(row, dwo, data)


lw_parent.triggerevent("ue_get_track_type")


end event

event buttonclicked;//*********************************************************************************
// Script Name:	buttonclicked
//
//	Arguments:		1.	row
//						2.	actionreturncode
//						3.	dwo
//
// Returns:			Long
//
//	Description:	This event is triggered when any button is clicked in the
//						d/w object.  This script will remove the "cb_" name in front
//						of the button name.  This will give the name of the associated
//						column.  This name is passed to of_help() to display help for
//						this column.
//
//*********************************************************************************
//	
// 01/18/01	FDG	Stars 4.6 (PIMR) - Created
//
//*********************************************************************************

Integer	li_rc

String	ls_column

w_master	lw_parent


// Get the column name by removing the leading 'cb_'
ls_column	=	dwo.name
ls_column	=	Mid (ls_column, 4)

// Call help for this column
li_rc			=	This.of_GetParentWindow (lw_parent)

lw_parent.of_help ('W_CASE_MAINT', ls_column)

end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************************
// Script Name:	ue_dwnkey
//
//	Arguments:		1.	key
//						2.	keyflags
//
// Returns:			Long
//
//	Description:	This script will get the name of the active column when F1 is pressed.
//						This name is passed to of_help() to display help for this column.
//
//*********************************************************************************
//	
//	04/16/09	GaryR	GNL.600.5633.012	Section 508 Compliance
//
//*********************************************************************************

String	ls_column
w_master	lw_parent

IF  KeyDown (KeyF1!)  THEN
	// Get the column name
	ls_column = This.GetColumnName()
	
	IF NOT IsNull( ls_column ) AND Trim( ls_column ) <> "" THEN
		// Call help for this column
		This.of_GetParentWindow (lw_parent)
		lw_parent.of_help ('W_CASE_MAINT', ls_column)
	END IF
END IF
end event

type tabpage_current from userobject within tab_case
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3538
integer height = 1744
long backcolor = 67108864
string text = "Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_current uo_current
dw_current dw_current
end type

on tabpage_current.create
this.uo_current=create uo_current
this.dw_current=create dw_current
this.Control[]={this.uo_current,&
this.dw_current}
end on

on tabpage_current.destroy
destroy(this.uo_current)
destroy(this.dw_current)
end on

type uo_current from uo_tabpage_rmm within tabpage_current
string accessiblename = "Case Status"
string accessibledescription = "Case Status"
integer x = 9
integer y = 16
integer width = 3529
integer height = 1724
end type

on uo_current.destroy
call uo_tabpage_rmm::destroy
end on

type dw_current from u_dw within tabpage_current
string accessiblename = "Case Status"
string accessibledescription = "Case Status"
integer x = 123
integer y = 60
integer width = 3314
integer height = 1320
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_case_current"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
This.of_SetTrim (TRUE)

end event

event itemchanged;w_case_maint	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event ue_edits(row, dwo, data)

//if this.getitemstatus(row,"case_type",Primary!)=NewModified! then
//	tab_case.tabpage_current.dw_current.SetColumn("case_trk_type")
//end if




//datetime ldte_status_date
//
//tab_case.tabpage_current.dw_current.object.case_status_desc.protect = 0
//tab_case.tabpage_current.dw_current.object.case_status_date.protect = 0
//
//ldte_status_date = gnv_app.of_get_server_date_time()	
//
//this.setItem(row,"case_status_date",ldte_status_date)


end event

event buttonclicked;//*********************************************************************************
// Script Name:	buttonclicked
//
//	Arguments:		1.	row
//						2.	actionreturncode
//						3.	dwo
//
// Returns:			Long
//
//	Description:	This event is triggered when any button is clicked in the
//						d/w object.  This script will remove the "cb_" name in front
//						of the button name.  This will give the name of the associated
//						column.  This name is passed to of_help() to display help for
//						this column.
//
//*********************************************************************************
//	
// 01/18/01	FDG	Stars 4.6 (PIMR) - Created
//
//*********************************************************************************

Integer	li_rc

String	ls_column

w_master	lw_parent


// Get the column name by removing the leading 'cb_'
ls_column	=	dwo.name
ls_column	=	Mid (ls_column, 4)

// Call help for this column
li_rc			=	This.of_GetParentWindow (lw_parent)

lw_parent.of_help ('W_CASE_MAINT', ls_column)

end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************************
// Script Name:	ue_dwnkey
//
//	Arguments:		1.	key
//						2.	keyflags
//
// Returns:			Long
//
//	Description:	This script will get the name of the active column when F1 is pressed.
//						This name is passed to of_help() to display help for this column.
//
//*********************************************************************************
//	
//	04/16/09	GaryR	GNL.600.5633.012	Section 508 Compliance
//
//*********************************************************************************

String	ls_column
w_master	lw_parent

IF  KeyDown (KeyF1!)  THEN
	// Get the column name
	ls_column = This.GetColumnName()
	
	IF NOT IsNull( ls_column ) AND Trim( ls_column ) <> "" THEN
		// Call help for this column
		This.of_GetParentWindow (lw_parent)
		lw_parent.of_help ('W_CASE_MAINT', ls_column)
	END IF
END IF
end event

type tabpage_savings from userobject within tab_case
string accessiblename = "Financial Data"
string accessibledescription = "Financial Data"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3538
integer height = 1744
long backcolor = 67108864
string text = "Financial Data"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_savings uo_savings
st_savings st_savings
dw_savings dw_savings
end type

on tabpage_savings.create
this.uo_savings=create uo_savings
this.st_savings=create st_savings
this.dw_savings=create dw_savings
this.Control[]={this.uo_savings,&
this.st_savings,&
this.dw_savings}
end on

on tabpage_savings.destroy
destroy(this.uo_savings)
destroy(this.st_savings)
destroy(this.dw_savings)
end on

type uo_savings from uo_tabpage_rmm within tabpage_savings
string accessiblename = "Case Savings"
string accessibledescription = "Case Savings"
integer x = 9
integer y = 16
integer width = 3529
integer height = 1724
end type

on uo_savings.destroy
call uo_tabpage_rmm::destroy
end on

type st_savings from statictext within tabpage_savings
string accessiblename = "Savings"
string accessibledescription = "Savings"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 1112
integer width = 2720
integer height = 144
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_savings from u_dw within tabpage_savings
string accessiblename = "Case Savings"
string accessibledescription = "Case Savings"
integer x = 82
integer y = 12
integer width = 3438
integer height = 1044
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_case_savings"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
This.of_SetTrim (TRUE)

end event

event buttonclicked;//*********************************************************************************
// Script Name:	buttonclicked
//
//	Arguments:		1.	row
//						2.	actionreturncode
//						3.	dwo
//
// Returns:			Long
//
//	Description:	This event is triggered when any button is clicked in the
//						d/w object.  This script will remove the "cb_" name in front
//						of the button name.  This will give the name of the associated
//						column.  This name is passed to of_help() to display help for
//						this column.
//
//*********************************************************************************
//	
// 01/18/01	FDG	Stars 4.6 (PIMR) - Created
//
//*********************************************************************************

Integer	li_rc

String	ls_column


w_master	lw_parent


// Get the column name by removing the leading 'cb_'
ls_column	=	dwo.name
ls_column	=	Mid (ls_column, 4)

// Call help for this column
li_rc			=	This.of_GetParentWindow (lw_parent)

lw_parent.of_help ('W_CASE_MAINT', ls_column)

end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************************
// Script Name:	ue_dwnkey
//
//	Arguments:		1.	key
//						2.	keyflags
//
// Returns:			Long
//
//	Description:	This script will get the name of the active column when F1 is pressed.
//						This name is passed to of_help() to display help for this column.
//
//*********************************************************************************
//	
//	04/16/09	GaryR	GNL.600.5633.012	Section 508 Compliance
//
//*********************************************************************************

String	ls_column
w_master	lw_parent

IF  KeyDown (KeyF1!)  THEN
	// Get the column name
	ls_column = This.GetColumnName()
	
	IF NOT IsNull( ls_column ) AND Trim( ls_column ) <> "" THEN
		// Call help for this column
		This.of_GetParentWindow (lw_parent)
		lw_parent.of_help ('W_CASE_MAINT', ls_column)
	END IF
END IF
end event

type tabpage_pimr from userobject within tab_case
string accessiblename = "PIMR Data"
string accessibledescription = "PIMR Data"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3538
integer height = 1744
long backcolor = 67108864
string text = "PIMR Data"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
uo_1 uo_1
dw_pimr dw_pimr
end type

on tabpage_pimr.create
this.uo_1=create uo_1
this.dw_pimr=create dw_pimr
this.Control[]={this.uo_1,&
this.dw_pimr}
end on

on tabpage_pimr.destroy
destroy(this.uo_1)
destroy(this.dw_pimr)
end on

type uo_1 from uo_tabpage_rmm within tabpage_pimr
string accessiblename = "Case PIMR Data"
string accessibledescription = "Case PIMR Data"
integer x = 9
integer y = 16
integer width = 3529
integer height = 1724
integer taborder = 21
end type

on uo_1.destroy
call uo_tabpage_rmm::destroy
end on

type dw_pimr from u_dw within tabpage_pimr
string accessiblename = "PIMR Data"
string accessibledescription = "PIMR Data"
integer x = 27
integer y = 20
integer width = 2683
integer height = 1192
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_case_pimr"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;//*********************************************************************************
// Script Name:	buttonclicked
//
//	Arguments:		1.	row
//						2.	actionreturncode
//						3.	dwo
//
// Returns:			Long
//
//	Description:	This event is triggered when any button is clicked in the
//						d/w object.  This script will remove the "cb_" name in front
//						of the button name.  This will give the name of the associated
//						column.  This name is passed to of_help() to display help for
//						this column.
//
//*********************************************************************************
//	
// 01/18/01	FDG	Stars 4.6 (PIMR) - Created
//
//*********************************************************************************

Integer	li_rc

String	ls_column

w_master	lw_parent


// Get the column name by removing the leading 'cb_'
ls_column	=	dwo.name
ls_column	=	Mid (ls_column, 4)

// Call help for this column
li_rc			=	This.of_GetParentWindow (lw_parent)

lw_parent.of_help ('W_CASE_MAINT', ls_column)

end event

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
This.of_SetTrim (TRUE)

end event

event itemfocuschanged;call super::itemfocuschanged;//*********************************************************************************
// Script Name:	ItemfocusChanged
//
//	Arguments:		1.	row
//						2.	dwo
//
// Returns:			Long
//
//	Description:	This event is triggered when a column receives focus.  If a 
//						"count" column receives focus, hilite its text.  If this wasn't
//						hilited, then any data entry of it's data will have a 0 digit 
//						appended to it.  For example, if the value is 0 and the user enters
//						5, then it will display 50.
//
//*********************************************************************************
//	
// 02/13/01	FDG	Stars 4.6 (PIMR) - Created
//
//*********************************************************************************

CHOOSE CASE	dwo.name
	CASE	'pmr_case_custom1_cnt', 'pmr_case_custom2_cnt', 'pmr_case_custom3_cnt', 'pmr_case_custom4_cnt', 'pmr_case_custom5_cnt', 'pmr_case_custom6_cnt', 'pmr_case_custom7_cnt', 'pmr_case_custom8_cnt'
		Integer	li_rc
		li_rc	=	SelectText (1, 32767)
END CHOOSE

end event

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************************
// Script Name:	ue_dwnkey
//
//	Arguments:		1.	key
//						2.	keyflags
//
// Returns:			Long
//
//	Description:	This script will get the name of the active column when F1 is pressed.
//						This name is passed to of_help() to display help for this column.
//
//*********************************************************************************
//	
//	04/16/09	GaryR	GNL.600.5633.012	Section 508 Compliance
//
//*********************************************************************************

String	ls_column
w_master	lw_parent

IF  KeyDown (KeyF1!)  THEN
	// Get the column name
	ls_column = This.GetColumnName()
	
	IF NOT IsNull( ls_column ) AND Trim( ls_column ) <> "" THEN
		// Call help for this column
		This.of_GetParentWindow (lw_parent)
		lw_parent.of_help ('W_CASE_MAINT', ls_column)
	END IF
END IF
end event

type tabpage_log from userobject within tab_case
string accessiblename = "Log"
string accessibledescription = "Log"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3538
integer height = 1744
long backcolor = 67108864
string text = "Log"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_log dw_log
uo_log uo_log
dw_display_log dw_display_log
st_count st_count
end type

on tabpage_log.create
this.dw_log=create dw_log
this.uo_log=create uo_log
this.dw_display_log=create dw_display_log
this.st_count=create st_count
this.Control[]={this.dw_log,&
this.uo_log,&
this.dw_display_log,&
this.st_count}
end on

on tabpage_log.destroy
destroy(this.dw_log)
destroy(this.uo_log)
destroy(this.dw_display_log)
destroy(this.st_count)
end on

type dw_log from u_dw within tabpage_log
boolean visible = false
string accessiblename = "Case Log"
string accessibledescription = "Case Log"
integer x = 2569
integer y = 28
integer width = 160
integer height = 124
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_case_log"
end type

event itemchanged;call super::itemchanged;This.SetTransObject (Stars2ca)

// Single select rows
This.of_SingleSelect (TRUE)

This.of_SetUpdateable (TRUE)

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
This.of_SetTrim (TRUE)
end event

type uo_log from uo_tabpage_rmm within tabpage_log
boolean visible = false
string accessiblename = "Case Log"
string accessibledescription = "Case Log"
integer x = 9
integer y = 16
integer width = 3529
integer height = 1724
integer taborder = 10
end type

on uo_log.destroy
call uo_tabpage_rmm::destroy
end on

type dw_display_log from u_dw within tabpage_log
string tag = "Case Log"
string accessiblename = "Case Log"
string accessibledescription = "Case Log"
integer y = 8
integer width = 3502
integer height = 1560
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;This.SetTransObject (Stars2ca)

// Single select rows
This.of_SingleSelect (TRUE)

This.of_SetUpdateable (FALSE)

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
// JasonS 11/25/02 Begin - Track 3374 - case performance
//This.of_SetTrim (TRUE)
// JasonS 11/25/02 End - Track 3374d





end event

event doubleclicked;call super::doubleclicked;//*********************************************************************************
// Script Name:	dw_display_log.DoubleClicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Invoke the Window Operations.
//		
//
//*********************************************************************************
//	
// 04/01/02  SAH	Stars 5.1	Created
//
//*********************************************************************************

w_case_maint	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)
lw_parent.of_window_operations (This, row, dwo)


end event

event rbuttonup;// JasonS	07/11/02	Created - Track 2738d
String ls_add_source,ls_main_table

w_case_maint	lw_parent	

String	ls_hold_object,		&
			ls_inv_type,			&
			ls_lookup_table
Integer	li_rc,					&
			li_row,					&
			li_status

li_rc	=	This.of_getparentwindow ( lw_parent )


Setpointer(Hourglass!)

select elem_tbl_type
into :ls_lookup_table
from dictionary
where elem_name = 'CASE_LOG'
using stars2ca;

ls_hold_object	=	This.GetObjectAtPointer()

IF	Trim (ls_hold_object)	<	'  '		THEN
	// Display RMM
	lw_parent.Event	ue_open_rmm()
	Return 1
END IF

fx_lookup(dw_display_log,ls_lookup_table)

stars2ca.of_commit()						// FNC 04/14/99

Return 	1

end event

type st_count from statictext within tabpage_log
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 297
integer y = 1600
integer width = 357
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
string text = "    "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

type tabpage_track from userobject within tab_case
string accessiblename = "Tracks"
string accessibledescription = "Tracks"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3538
integer height = 1744
long backcolor = 67108864
string text = "Tracks"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_track uo_track
dw_track dw_track
st_track_count st_track_count
end type

on tabpage_track.create
this.uo_track=create uo_track
this.dw_track=create dw_track
this.st_track_count=create st_track_count
this.Control[]={this.uo_track,&
this.dw_track,&
this.st_track_count}
end on

on tabpage_track.destroy
destroy(this.uo_track)
destroy(this.dw_track)
destroy(this.st_track_count)
end on

type uo_track from uo_tabpage_rmm within tabpage_track
string accessiblename = "Case Tracks"
string accessibledescription = "Case Tracks"
integer x = 9
integer y = 16
integer width = 3529
integer height = 1724
end type

on uo_track.destroy
call uo_tabpage_rmm::destroy
end on

type dw_track from u_dw within tabpage_track
string accessiblename = "Case Tracks"
string accessibledescription = "Case Tracks"
integer x = 18
integer y = 16
integer width = 3502
integer height = 1552
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_case_track_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;
This.SetTransObject (Stars2ca)

// Single select rows
This.of_SingleSelect (TRUE)

// DataWindow is not updateable
This.of_SetUpdateable (FALSE)

// FDG 01/17/02 - Oracle port
// To trim Oracle spaces to empty string (when retrieving) and to convert
//	the empty string to a space (when inserting/updating).
//This.of_SetTrim (TRUE)	// JasonS 11/26/02 Track 3374d


end event

event doubleclicked;
w_case_maint.triggerEvent("ue_open_track_maint")
end event

event rowfocuschanged;call super::rowfocuschanged;// 10/26/2004	JasonS 	Track 3573 - enable/disable select track button
if currentrow > 0 then
	cb_select_track.enabled = true
else
	cb_select_track.enabled = false
end if
end event

type st_track_count from statictext within tabpage_track
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 297
integer y = 1600
integer width = 357
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type p_notes from u_pb within w_case_maint
boolean visible = false
string accessiblename = "Notes"
string accessibledescription = "Notes"
integer x = 69
integer y = 2068
integer width = 160
integer height = 148
integer taborder = 20
boolean bringtotop = true
string facename = "System"
string picturename = "script1.bmp"
alignment htextalign = center!
vtextalign vtextalign = vcenter!
end type

event clicked;//w_case_maint.wf_notes()

w_master	lw_parent
Integer			li_rc
li_rc = 	This.of_GetParentWindow(lw_parent)
lw_parent.dynamic event ue_notes()
end event

type dw_headings from u_dw within w_case_maint
string accessiblename = "Case Headings"
string accessibledescription = "Case Headings"
integer x = 5
integer y = 8
integer width = 3598
integer height = 368
integer taborder = 21
string dataobject = "d_case_headings"
boolean border = false
end type

event constructor;call super::constructor;this.insertrow(0)
this.of_setupdateable( false )
end event

type cb_next_current from u_cb within w_case_maint
string accessiblename = "Next"
string accessibledescription = "Next"
integer x = 2811
integer y = 2084
integer width = 357
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Next"
end type

event clicked;//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
//Parent.Event	ue_scroll_tab(tab_case,+1)

w_master	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event Dynamic ue_scroll_tab(tab_case,+1)
end event

type cb_close_current from u_cb within w_case_maint
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 3186
integer y = 2084
integer width = 357
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;w_case_maint	lw_parent
Integer		li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

gv_from = ''
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.event dynamic ue_close()


end event

type cb_prev_current from u_cb within w_case_maint
string accessiblename = "Prev"
string accessibledescription = "Prev"
integer x = 2437
integer y = 2084
integer width = 357
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Prev"
end type

event clicked;//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
//Parent.Event	ue_scroll_tab(tab_case,-1)

w_master	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event Dynamic ue_scroll_tab(tab_case,-1)

end event

type cb_select_track from u_cb within w_case_maint
boolean visible = false
string accessiblename = "Select"
string accessibledescription = "Select"
integer x = 2062
integer y = 2084
integer width = 357
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Select"
end type

event clicked;call super::clicked;parent.triggerEvent("ue_open_track_maint")
end event

