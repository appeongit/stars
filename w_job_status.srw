HA$PBExportHeader$w_job_status.srw
$PBExportComments$Inherited from w_master
forward
global type w_job_status from w_master
end type
type cb_delete from u_cb within w_job_status
end type
type dw_search from u_dw within w_job_status
end type
type st_job_cnt_box from statictext within w_job_status
end type
type st_row_cnt from statictext within w_job_status
end type
type st_dw_ops from statictext within w_job_status
end type
type ddlb_dw_ops from dropdownlistbox within w_job_status
end type
type st_row_count from statictext within w_job_status
end type
type cb_exit from u_cb within w_job_status
end type
type cb_list from u_cb within w_job_status
end type
type dw_1 from u_dw within w_job_status
end type
type gb_search from groupbox within w_job_status
end type
end forward

global type w_job_status from w_master
string accessiblename = "Job Status Query "
string accessibledescription = "Job Status Query "
integer x = 151
integer y = 0
integer width = 3790
integer height = 2308
string title = "Job Status Query "
cb_delete cb_delete
dw_search dw_search
st_job_cnt_box st_job_cnt_box
st_row_cnt st_row_cnt
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
st_row_count st_row_count
cb_exit cb_exit
cb_list cb_list
dw_1 dw_1
gb_search gb_search
end type
global w_job_status w_job_status

type variables
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct
//int in_row		// GaryR		03/27/01	Stars 4.7
//boolean ib_open//NLG 8-1-98 // GaryR		06/19/01

// GaryR		03/27/01	Stars 4.7
String	is_user_id
Long		il_status[]
DateTime	idtm_from_date, idtm_to_date, idtm_sched_date
end variables

forward prototypes
public function integer wf_retrieve_data ()
public subroutine wf_post_retrieve ()
end prototypes

public function integer wf_retrieve_data ();//  wf_retrieve_data for w_job_status
//*************************************************************************************
//Modifications:
//	1-13-98 NLG 4.0 Subset Redesign--use sys_cntl service to get range and date defaults
// 3-19-98 AJS 4.0 Use local instead of global user id in code.  this was putting
//                 a % in the global variable
// 5-18-98 NLG 4.0 Change the where statement for the distinct job id count box
//	1/12/99 FDG	4.0(SP1).  Track 2047c.  Y2K changes to allow a 4-digit date.
//	1/20/99 FDG 4.0(SP1).  Track 2064c.  Fix 5-18-98 bug to get the job_id count.
//	12/13/00	GaryR	Stars 4.7 DataBase Port - Date Conversion.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
// 03/27/01	GaryR	Stars 4.7 - Implement Stars Server Functionality.
//	06/20/01	GaryR	2345D	Redesign the logical flow.
// 08/02/02 JasonS 3032d Dictionaryize column display widths
//	08/01/03	GaryR	Track 3619d	Change Waiting Status from 4 to 5
// 01/31/06 JasonS Track 4600d rework multi deletes - set redraw to false for performance
// 02/19/06 JasonS Track 4653d Make user id a ddlb - make search criteria to a dw
//	02/23/06	GaryR	Track 4670	Trigger AcceptText to get latest criteria
//*************************************************************************************

n_cst_labels	lnv_labels  //JasonS 08/02/02 Track 3032d
string ls_tbl_type  //JasonS 08/02/02 Track 3032d
int 		  li_rc, lv_range
long 		  lv_nbr_rows, ll_status[]
long       lv_pos
long		  ll_count, ll_row_count,	ll_row
string	  ls_prev_job_id,	ls_job_id, lv_user_id, ls_job_status
date       lv_from_date, lv_to_date
datetime   lv_from_date_time, lv_to_date_time, ldt_sched_dte	//	12/13/2000	GaryR	Stars 4.7 DataBase Port

setpointer(hourglass!)
setmicrohelp(w_main,'Retrieving Job List')

dw_search.Accepttext()

n_cst_datetime		lnv_datetime
li_rc		=	lnv_datetime.of_IsValidDate (string(dw_search.getitemdate( 1, "job_date") ))

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		Return	-1

	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		Return	-1
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		Return	-1
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.
lv_from_date_time	=	lnv_datetime.of_GetFromDateTime (dw_search.getitemdate(1, "job_date"), dw_search.getitemnumber( 1, "range") )
lv_to_date			=	Date (dw_search.getitemdate(1, "job_date"))
lv_to_date_time	=	DateTime (lv_to_date, 23:59:59)


// 03/27/01	GaryR	Stars 4.7 - Begin
// 01/09/02 LMC Stars 5.0 - Track #2643 - Remove deleted jobs from Job Status Window
CHOOSE CASE dw_search.getitemstring(1, "job_status")
	CASE "Cancelled"
		ll_status = {-2}
	CASE "Error"
		ll_status = {-1}
	CASE "Complete"
		ll_status = {0}
	CASE "Executing"
		ll_status = {1}
	CASE "Created"
		ll_status = {2}
	CASE "Waiting"
		ll_status = {5}
	CASE ELSE	// All
		ll_status = {-2, -1, 0, 1, 2, 5}
END CHOOSE		

lv_user_id = trim(dw_search.getitemstring(1, "user_id")) + '%'	//ajs 4.0 03-19-98 Fix user id

st_job_cnt_box.text = ''
st_row_count.text = ''
reset(dw_1)

//  Retrieve the data
// 03/27/01	GaryR	Stars 4.7
//	12/13/2000	GaryR	Stars 4.7 DataBase Port
// 01/09/02 LMC Stars 5.0 - Track #2643 - Remove deleted jobs from Job Status Window
dw_1.setredraw(false)
lv_nbr_rows = dw_1.Retrieve( lv_user_id,ll_status, lv_from_date_time, lv_to_date_time, ldt_sched_dte)

is_user_id = lv_user_id
il_status = ll_status
idtm_from_date = lv_from_date_time
idtm_to_date = lv_to_date_time
idtm_sched_date = ldt_sched_dte

if lv_nbr_rows = -1 Then
	cb_exit.default = TRUE
	st_job_cnt_box.text = '0'
	st_row_count.text = '0'
	dw_1.setredraw( true)
	return -1
end if

If lv_nbr_rows = 0 Then
  	MessageBox('Search Result','No jobs with selected search criteria',INFORMATION!,OK!)
end if

//	06/20/01	GaryR	2345D - Begin
wf_post_retrieve()

return 0
end function

public subroutine wf_post_retrieve ();///////////////////////////////////////////////////////////////
//
//	GaryR	06/20/01	2345D	Redesign the logical flow.
// MikeF 09/04/02	3713C Disable the delete button if there are no rows in the datawindow.
// JasonS 01/31/06 4600d Multi-Job Deletes
//	GaryR	08/27/08	SPR 5519	PB11 button background color issue
//
///////////////////////////////////////////////////////////////

Long		ll_rowcnt, ll_row, ll_count, ll_delete_cnt
String	ls_job_id, ls_prev_job_id

ll_rowcnt	=	dw_1.RowCount()

dw_1.setredraw(false)
FOR ll_row	=	1	TO	ll_rowcnt	
	ls_job_id	=	dw_1.GetItemString (ll_row, 'server_jobs_job_desc')
	
	// if User Admin or SA you can delete any job
	If gv_user_sl <> 'AD' and dw_1.GetItemString(ll_row, 'server_jobs_user_id') <> gc_user_id then
		// Not your job, you cannot delete
		dw_1.SetItem( ll_row, 'delete_access', 1)				
	end if
		
	IF	ls_job_id	<>	ls_prev_job_id		THEN
		ll_count	++
		ls_prev_job_id	=	ls_job_id
	else
		// This job id is the same as the last rows (Multi-Step Job), only show check box for 
		// first row
		if (dw_1.GetItemNumber(ll_row, 'delete_access') = 0) then
			dw_1.SetItem( ll_row, 'delete_access', 2)
		end if
	END IF
	
	if (dw_1.getitemnumber(ll_row, 'delete_access') = 0) then
		ll_delete_cnt ++
	end if
NEXT

dw_1.setredraw(true)

st_job_cnt_box.Text	= String( ll_count )
st_row_count.Text 	= String( ll_rowcnt )

if ll_rowcnt > 0 then
	dw_1.EVENT RowFocusChanged(1)
end if

// MikeFl 9/4/02 - Track 3713c
IF ll_delete_cnt = 0 THEN
	cb_delete.enabled = FALSE
ELSE
	cb_delete.enabled = TRUE
END IF
end subroutine

event open;call super::open;//*******************************************************************
//
// 04/12/96	DKG	Added to set user defined window colors.
// 01-12-98	NLG	4.0 SubsetRedesign ts176.doc - Range default date will
//                be retrieved from sys_cntl
//	06/20/01	GaryR	2345D	Redesign the logical flow.
//	01/24/02	GaryR	Track 2713d	Retain timestamp in date columns.
//	02/19/06	Jason	Track 4653d	Make user_id a ddlb  - made search criteria a dw
//	02/23/06	GaryR	Track 4670	Add blank to user id to prevent null
//	03/06/06	GaryR	Track 4537	Set the list datawindow for printing/saving
//*******************************************************************
int rc, lv_index
//string lv_window_name			//	01/24/02	GaryR	Track 2713d
integer li_rc						//NLG 1-13-98
DataWindowChild ldwc_code
setpointer(hourglass!)
setmicrohelp(w_main,'Opening Job Status')

//ib_open = TRUE//NLG 8-1-98 Track #1236	//	06/20/01	GaryR	2345D
//NLG 1-12-98 4.0 Instantiate sys_cntl service to process 'range' row
li_rc = Super::of_set_sys_cntl_range(TRUE)

dw_search.settransobject( stars2ca)
dw_search.insertrow(1)

dw_search.GetChild( "user_id", ldwc_code )
ldwc_code.InsertRow( 1 )
ldwc_code.SetItem( 1, "cf_name", "" )
ldwc_code.SetItem( 1, "user_id", "" )

dw_search.setitem(1, "user_id", gc_user_id)
dw_search.setitem( 1, "job_status", "All")
dw_search.setitem( 1, "job_date", date( inv_sys_cntl.of_get_default_date()))
dw_search.setitem( 1, "range", inv_sys_cntl.of_get_cntl_no())

gv_user_id = gc_user_id
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
This.of_setprintdw( dw_1 )

IF Stars2ca.of_commit()	<	0		THEN			// FDG 10/19/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/19/95
END IF												// FDG 10/19/95

//	06/20/01	GaryR	2345D - Begin
// Retrieve the data
dw_1.SetTransObject(stars2ca)
POST wf_retrieve_data()
end event

on w_job_status.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.dw_search=create dw_search
this.st_job_cnt_box=create st_job_cnt_box
this.st_row_cnt=create st_row_cnt
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_row_count=create st_row_count
this.cb_exit=create cb_exit
this.cb_list=create cb_list
this.dw_1=create dw_1
this.gb_search=create gb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.dw_search
this.Control[iCurrent+3]=this.st_job_cnt_box
this.Control[iCurrent+4]=this.st_row_cnt
this.Control[iCurrent+5]=this.st_dw_ops
this.Control[iCurrent+6]=this.ddlb_dw_ops
this.Control[iCurrent+7]=this.st_row_count
this.Control[iCurrent+8]=this.cb_exit
this.Control[iCurrent+9]=this.cb_list
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_search
end on

on w_job_status.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.dw_search)
destroy(this.st_job_cnt_box)
destroy(this.st_row_cnt)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.st_row_count)
destroy(this.cb_exit)
destroy(this.cb_list)
destroy(this.dw_1)
destroy(this.gb_search)
end on

type cb_delete from u_cb within w_job_status
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 3026
integer y = 2076
integer width = 338
integer height = 108
integer taborder = 100
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Delete"
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
// Event/Function						Object				
//	--------------						------				
//	clicked for pb_delete			w_job_status
/////////////////////////////////////////////////////////////////////////////
// DESCRIPTION
//	If job_status is 'P' calls rpc to schedule job for deletion.  If 'E', 
// updates bg_cntl with today's date.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		long
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	Naomi		1/8/98	Modified for 4.0 Subset Redesign ts145-job status query.doc
//							Previous code replaced.
// Anne-S   3/20/98  Modified code so the deleted row is not removed
//                   from the datawindow.
// Naomi		5/15/98	Change job_status of deleted row to "D" in bg_cntl and
//							on datawindow, then filter datawindow so row doesn't show
// GaryR		03/27/01	Stars 4.7 - Implement Stars Server Functionality.
//	GaryR		06/20/01	2345D	Redesign the logical flow.
//	GaryR		01/25/02	Track 2714d	1)	Synchronize the status.  
//											2)	Prevent deletion of Waiting jobs.
//	FDG		03/22/02	Track 2669d.  No primary key on server jobs.  Use a
//							datastore instead of embedded SQL.
//	GaryR		08/01/03	Track 3619d	Change Waiting Status from 4 to 5
// Katie 		08/25/05 Track 3663d Checked ib_multiselect property for dw_1 
//				and added ability for deletion of multiple jobs at once.  Allow Client
//				Admins to delete jobs for other
// JasonS 	01/31/06 Track 4600d Multi-job delete modifications
// JasonS	02/15/06 track 4654d  display job status on confirmation box
// JasonS	02/19/06 track 4564d  removed headings from confirmation box
//	GaryR		08/27/08	SPR 5519	PB11 button background color issue
//
/////////////////////////////////////////////////////////////////////////////

String		ls_user_id, ls_job_id, ls_confirm_msg
Long		ll_status, ll_job_id, ll_row, ll_new_status, ll_rowcount
Long		llx_job_ids[]
String		lsx_job_statuses[]
String ls_status_desc = ''
Integer 	arraylen, li_row, li_index, li_nonown_index

setpointer(hourglass!)


FOR ll_row = 1 TO dw_1.RowCount()
	IF (dw_1.GetItemNumber(ll_row, 'delete_ind') = 1) THEN
	
		// obtain values
		ls_user_id	= dw_1.GetItemString(ll_row,'server_jobs_user_id')
		ll_status	= dw_1.GetItemNumber(ll_row,'server_jobs_status')
		ll_job_id 	= dw_1.GetItemNumber(ll_row,'server_jobs_job_id')
		ls_job_id 	= dw_1.GetItemString(ll_row,'server_jobs_job_desc')

		n_ds	lds_serverjobs
		lds_serverjobs		=	CREATE	n_ds
		lds_serverjobs.DataObject	=	'd_server_jobs'
		lds_serverjobs.SetTransObject (Stars2ca)
		
		ll_rowcount	=	lds_serverjobs.Retrieve (ll_job_id)
		ll_new_status	=	lds_serverjobs.object.status [1]
		
		DESTROY	lds_serverjobs
		// FDG 03/22/02 end
		
		IF ll_new_status <> ll_status THEN
			dw_1.SetItem( ll_row, 'server_jobs_status', ll_new_status )
			ll_status = ll_new_status
		END IF
		//	GaryR		01/25/02	Track 2714d - End
		
		IF ll_status = -1024 THEN		//Deleted
			MessageBox( 'Job Delete','You may not Delete Job ' + ls_job_id + ' it is already deleted!', Exclamation! )
			Return
		END IF
		li_index++
		llx_job_ids[li_index] = ll_job_id
		lsx_job_statuses[li_index] = String(ll_new_status)
	END IF
NEXT

IF li_index > 0 THEN
	//Confirm user wishes to delete the selected jobs

		ls_confirm_msg = "The following Job(s) will be deleted: ~r"
		FOR li_row=1 TO li_index
			choose case lsx_job_statuses[li_row]
				case '2'		
					ls_status_desc = 'Created'
				case '5'
					ls_status_desc = 'Waiting'
				case '1'
					ls_status_desc = 'Executing'
				case else 
					ls_status_desc = ''
			end choose
			ls_confirm_msg = ls_confirm_msg + String(llx_job_ids[li_row]) + "~t" + ls_status_desc + "~r"
		NEXT
			ls_confirm_msg = ls_confirm_msg + "Continue?~r"	
		IF MessageBox( "Job Delete", ls_confirm_msg, Question!, YesNo! ) <> 1 THEN Return
ELSE
	//No rows selected
	MessageBox( 'Job Delete','Please select job(s) to delete!', Exclamation! )
	Return
END IF

//Delete jobs
FOR li_row=1 TO li_index
	gnv_server.of_JobDelete( llx_job_ids[li_row] )
NEXT

IF dw_1.Retrieve( is_user_id, il_status, idtm_from_date, idtm_to_date, idtm_sched_date ) = -1 THEN
	cb_exit.default = TRUE
	st_job_cnt_box.text = '0'
	st_row_count.text = '0'
	return -1
END IF

wf_post_retrieve()
dw_1.EVENT RowFocusChanged( ll_row )
end event

type dw_search from u_dw within w_job_status
string accessiblename = "Job Status Search Criteria"
string accessibledescription = "Job Status Search Criteria"
integer x = 73
integer y = 96
integer width = 2519
integer height = 264
integer taborder = 20
string dataobject = "d_job_status_search"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;THIS.of_SetUpdateable( FALSE )
THIS.of_SetDropDownCalendar( TRUE )
THIS.iuo_calendar.of_Register( "job_date", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_SetDateFormat( "mm/dd/yyyy" )
end event

type st_job_cnt_box from statictext within w_job_status
string tag = "colorfixed"
string accessiblename = "Job Count"
string accessibledescription = "Job Count"
accessiblerole accessiblerole = statictextrole!
integer x = 878
integer y = 2092
integer width = 261
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_row_cnt from statictext within w_job_status
string accessiblename = "Job Count"
string accessibledescription = "Job Count"
accessiblerole accessiblerole = statictextrole!
integer x = 864
integer y = 2012
integer width = 306
integer height = 56
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Job Count"
boolean focusrectangle = false
end type

type st_dw_ops from statictext within w_job_status
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 50
integer y = 2012
integer width = 631
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type ddlb_dw_ops from dropdownlistbox within w_job_status
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 41
integer y = 2092
integer width = 713
integer height = 312
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.

string lv_control_text

lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end event

type st_row_count from statictext within w_job_status
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 46
integer y = 2208
integer width = 261
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_exit from u_cb within w_job_status
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 3392
integer y = 2076
integer width = 338
integer height = 108
integer taborder = 100
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean cancel = true
end type

on clicked;close (parent)
end on

type cb_list from u_cb within w_job_status
string accessiblename = "List"
string accessibledescription = "List"
integer x = 2661
integer y = 152
integer width = 338
integer height = 108
integer taborder = 80
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&List"
boolean default = true
end type

on clicked;//  CLICKED EVENT FOR CB_LIST, W_JOB_status

integer rc



rc = wf_retrieve_data()


end on

type dw_1 from u_dw within w_job_status
string accessiblename = "Job Status Data"
string accessibledescription = "Job Status Data"
integer x = 32
integer y = 400
integer width = 3694
integer height = 1588
integer taborder = 50
string dataobject = "d_job_status"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_singleselect = true
boolean ib_isupdateable = false
boolean ib_singlerow = true
end type

event doubleclicked;//Script for W_case_list doubleclicked for dw_1
//////////////////////////////////////////////////////////////////////
//anne-s 11-28-97 TS242 Rel 3.6
int tabpos,rc,lv_indx,lv_found
int lv_upper
long lv_row_nbr
string lv_hold_object,lv_col,lv_tbl_type
string lv_string_width,lv_hold_col_width,lv_col_name
boolean lv_lookup,lv_found_flag,lv_join

lv_join = FALSE

setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_1)
If lv_hold_object = '' then
	return
end if
tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
	//anne-s 11-28-97 TS242 Rel 3.6
//	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
//	End if      
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
Else
	If in_dw_control = 'FILTER' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		lv_row_nbr = row
//		lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
	ElseIf in_dw_control = 'FIND' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		lv_row_nbr = row
//		lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
	End If
End If
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////
//
//	07/05/02	GaryR	Track 2754d	Trim data.
//
//////////////////////////////////////////////////////////

THIS.of_SetTrim( TRUE )
end event

event clicked;call super::clicked;//================================================================================================//
// Maintenance
// -------- ----- -------- ---------------------------------------------------------------------- //
// 01/22/06 JasonS Track 4600d check mark for deletion ind
//================================================================================================//
int 		li_pos, li_rc
string 	ls_object, ls_col_name
SetFocus(this)
ls_object = dw_1.Getobjectatpointer()

li_pos 	= pos (ls_object,"~t")
ls_object= left(ls_object,(li_pos - 1))

IF ls_object <> 'delete_ind' THEN RETURN

IF dw_1.GetItemNumber( row, 'delete_ind') = 0 THEN
	dw_1.SetItem( row, 'delete_ind', 1)
ELSE
	dw_1.SetItem( row, 'delete_ind', 0)
END IF 

end event

event ue_dwnkey;call super::ue_dwnkey;//	05/29/09	GaryR	GNL.600.5633.012	Provide keyboard equivalent

Long	ll_row

IF key = KeySpaceBar! THEN
	ll_row = This.GetRow()
	IF This.GetItemNumber( ll_row, 'delete_access') = 0 THEN
		IF This.GetItemNumber( ll_row, 'delete_ind') = 0 THEN
			This.SetItem( ll_row, 'delete_ind', 1)
		ELSE
			This.SetItem( ll_row, 'delete_ind', 0)
		END IF
	END IF
END IF
end event

type gb_search from groupbox within w_job_status
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 37
integer y = 24
integer width = 3689
integer height = 356
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

