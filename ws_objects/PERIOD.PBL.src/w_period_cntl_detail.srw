$PBExportHeader$w_period_cntl_detail.srw
$PBExportComments$Period_cntl detail d/w (inherited from w_master)
forward
global type w_period_cntl_detail from w_master
end type
type dw_detail from u_dw within w_period_cntl_detail
end type
type cb_update from u_cb within w_period_cntl_detail
end type
type cb_add from u_cb within w_period_cntl_detail
end type
type cb_delete from u_cb within w_period_cntl_detail
end type
type cb_close from u_cb within w_period_cntl_detail
end type
type dw_list_summ_rel from u_dw within w_period_cntl_detail
end type
type dw_copy_summ_rel from u_dw within w_period_cntl_detail
end type
type cb_updateadd from u_cb within w_period_cntl_detail
end type
end forward

global type w_period_cntl_detail from w_master
long backcolor = 67108864
string accessiblename = "Period Control Detail"
string accessibledescription = "Period Control Detail"
accessiblerole accessiblerole = windowrole!
integer width = 2757
integer height = 1640
string title = "Period Control Detail"
string is_save_unsuccessful_msg = ""
string is_save_successful_msg = ""
string is_save_no_data_msg = ""
string is_closequery_msg = ""
string is_closequery_error_msg = ""
event type integer ue_set_pat_prof_groupbox ( boolean ab_switch )
dw_detail dw_detail
cb_update cb_update
cb_add cb_add
cb_delete cb_delete
cb_close cb_close
dw_list_summ_rel dw_list_summ_rel
dw_copy_summ_rel dw_copy_summ_rel
cb_updateadd cb_updateadd
end type
global w_period_cntl_detail w_period_cntl_detail

type variables
boolean ib_error = FALSE
long il_period_key
boolean ib_new = FALSE
datetime id_orig_payment_from, id_orig_payment_thru
datetime id_orig_srvc_from, id_orig_srvc_thru
datetime id_orig_run_date
string is_orig_model
boolean ib_patient_profile
string is_patient_profile_table_name

end variables

forward prototypes
public function integer wf_get_new_key ()
public function integer wf_delete ()
public function integer wf_add ()
public function integer wf_update ()
public function integer wf_validate_dw ()
end prototypes

event type integer ue_set_pat_prof_groupbox(boolean ab_switch);//Script:		ue_set_pat_prof_groupbox
//Arguments:	boolean - ab_switch
//Description:
// This event sets the patient profile groupbox and the objects inside
// visible or invisible, according to the argument passed in.
//	The column 'use_pay_ind' is only relevant to professional
//
//History
//	02/25/00	NLG	created.
///////////////////////////////////////////////////////////////////////

long 		ll_row
string 	ls_base_type

ll_row      = dw_detail.GetRow()
ls_base_type  = trim(dw_detail.GetItemString(ll_row, 'base_type'))

if ab_switch then
	dw_detail.object.gb_patient_sum.visible 		= 1
	dw_detail.object.pat_rank_col_num_t.visible	= 1
	dw_detail.object.pat_rank_col_num.visible 	= 1
	if ls_base_type = '1500' then
		dw_detail.object.use_pay_ind_t.visible		= 1
		dw_detail.object.use_pay_ind.visible		= 1
	else
		dw_detail.object.use_pay_ind_t.visible		= 0
		dw_detail.object.use_pay_ind.visible		= 0
	end if
	
	dw_detail.object.pat_sum_cutoff_t.visible		= 1
	dw_detail.object.pat_sum_cutoff.visible		= 1
else
	dw_detail.object.gb_patient_sum.visible		= 0
	dw_detail.object.pat_rank_col_num_t.visible	= 0
	dw_detail.object.pat_rank_col_num.visible 	= 0
	dw_detail.object.use_pay_ind_t.visible			= 0
	dw_detail.object.use_pay_ind.visible			= 0
	dw_detail.object.pat_sum_cutoff_t.visible		= 0
	dw_detail.object.pat_sum_cutoff.visible		= 0
end if

return 1
	
end event

public function integer wf_get_new_key ();long ll_max_key

ib_new = TRUE

SetPointer(Hourglass!)

//******************************//
// get max key from period_cntl //
//******************************//

SELECT max(period_key)
INTO   :ll_max_key
FROM   period_cntl
USING  stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Period Control', 'Error selecting key from period_cntl')
	Return -1
else
	Commit using stars2ca;
end if

//****************************************//
// insert the new key into the datawindow //
//****************************************//

il_period_key = ll_max_key + 1
//Message.StringParm = string(il_period_key)

dw_detail.SetItem(dw_detail.GetRow(), 'period_key', il_period_key)

Return -1
end function

public function integer wf_delete ();long ll_row, ll_period
string ls_function, ls_invoice

SetPointer(Hourglass!)

ll_row      = dw_detail.GetRow()
ll_period   = dw_detail.GetItemNumber(ll_row, 'period')
ls_function = dw_detail.GetItemString(ll_row, 'FUNCTION_NAME')
ls_invoice  = dw_detail.GetItemString(ll_row, 'invoice_type')

//*************************************************************//
// delete row from datawindow then update the datawindow to DB //
//*************************************************************//

dw_detail.DeleteRow (0)
dw_detail.EVENT ue_update( True,False )
if stars2ca.of_check_status() <> 0  then
	Rollback using stars2ca;
	MessageBox('Update', 'Error updating period control table', StopSign!)
	Return -1
else
	Commit using stars2ca;
	dw_detail.ResetUpdate()
end if

//*************************//
// delete row from sum_rel //
//*************************//

DELETE FROM sum_rel
 WHERE period = :ll_period and
       FUNCTION_NAME = Upper( :ls_function ) and
       inv_type = Upper( :ls_invoice )
 USING stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Update', 'Error updating sum_rel table', StopSign!)
	Return -1
else
	Commit using stars2ca;
end if

//******************************//

// return to w_period_cntl_list //
//******************************//

cb_close.triggerevent(Clicked!)

Return 1
end function

public function integer wf_add ();long    ll_current_row
integer li_continue
datetime ld_default_begin, ld_default_end

SetPointer(Hourglass!)

ld_default_begin = datetime(date('01/01/1900'))
ld_default_end   = datetime(date('06/06/2079'))

//*******************************************************//
// if the current period has not been saved prompt user. //
// if they are working on a new row but don't want to    //
// save it delete that row from the dw and and a new one //
//*******************************************************//

if dw_detail.ModifiedCount() > 0 then 
	li_continue = MessageBox('Add', 'Do you want to save the current ' + &
  	                       'period before adding a new one?', Question!, YesNo!)
	if li_continue = 1 then 
		if (wf_update() = -1) then Return -1
	elseif ib_new then
		dw_detail.DeleteRow(dw_detail.GetRow())
	end if
end if

dw_detail.SetTabOrder("period",10)
dw_detail.SetTabOrder("base_type",20)
dw_detail.SetTabOrder("FUNCTION_NAME",30)
dw_detail.SetTabOrder("invoice_type",40)

//****************************************//
// retrieve a blank row in the datawindow //
//****************************************//

ll_current_row	=	dw_detail.InsertRow(0)
dw_detail.ScrollToRow (ll_current_row)

//ll_current_row = dw_detail.GetRow()
dw_detail.SetItem(ll_current_row, 'effective_begin_date', ld_default_begin)
dw_detail.SetItem(ll_current_row, 'effective_end_date', ld_default_end)

dw_detail.SetColumn(1)

Return 1
end function

public function integer wf_update ();//2-3-00  Archana  Retrieve the data window after successful update to the database.
// 03/09/07	Katie SPR4942 Added call to ensure that objects were hidden/populated appropriately after the call to re-retrieve the window

string ls_current_function, ls_current_invoice
long ll_current_row, ll_current_period, ll_sumrel_count, ll_next_row

SetPointer(Hourglass!)

if (wf_validate_dw() = -1) then 
	Return -1
end if

dw_detail.EVENT ue_update( True, False )
if stars2ca.of_check_status() <> 0  then
	Rollback using stars2ca;
	MessageBox('Update', 'Error updating period control table', StopSign!)
	Return -1
else
	Commit using stars2ca;
	dw_detail.ResetUpdate()
end if

SetPointer(Hourglass!)

This.TriggerEvent("ue_retrieve")			//2-3-00 Archana

//*********************************************************//
// add rows to sum rel if they don't exist for this period //
//*********************************************************//

ll_current_row      = dw_detail.GetRow()
ll_current_period   = dw_detail.GetItemNumber(ll_current_row, 'period')
ls_current_function = dw_detail.GetItemString(ll_current_row, 'FUNCTION_NAME')
ls_current_invoice  = dw_detail.GetItemString(ll_current_row, 'invoice_type')

SELECT count(*)
  INTO :ll_sumrel_count
  FROM sum_rel
 WHERE period   = :ll_current_period and
       FUNCTION_NAME = Upper( :ls_current_function ) and
       inv_type = Upper( :ls_current_invoice )
 USING stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Update', 'Error selecting from sum_rel', StopSign!)
	Return -1
else
	Commit using stars2ca;
end if

if ll_sumrel_count = 0 then

	// retrieve from sum_rel with 999999 period & this function/invoice

	dw_list_summ_rel.Reset()
	dw_list_summ_rel.SetTransObject(stars2ca)
	dw_list_summ_rel.Retrieve(ls_current_function, ls_current_invoice)
	dw_copy_summ_rel.Reset()
	dw_copy_summ_rel.SetTransObject(stars2ca)

	if dw_list_summ_rel.Rowcount() > 0 then

		// copy sum_rel rows and update period for each row

		dw_list_summ_rel.RowsCopy(1, dw_list_summ_rel.RowCount(), Primary!, dw_copy_summ_rel, 1, Primary!)
  
		For ll_next_row = 1 to dw_copy_summ_rel.RowCount()
	
			dw_copy_summ_rel.SetItem(ll_next_row, 'period', ll_current_period)
			dw_copy_summ_rel.SetItemStatus(ll_next_row, 0, Primary!, NewModified!)

		Next

		dw_copy_summ_rel.EVENT ue_update( TRUE, TRUE )

	end if
end if

Commit using stars2ca;

//********************************//
// don't allow edit of key fields //
//********************************//

dw_detail.SetTabOrder("period",0)
dw_detail.SetTabOrder("base_type",0)
dw_detail.SetTabOrder("FUNCTION_NAME",0)
dw_detail.SetTabOrder("invoice_type",0)

dw_detail.event ue_retrieve_groupbox(ls_current_function, ls_current_invoice, ll_current_period)

setmicrohelp(w_main,'Ready')

Return 1
end function

public function integer wf_validate_dw ();////////////////////////////////////////////////////////////////////////
//
// 02/03/99	Archana	Fs/Ts 2459c	Updating period generates system errors.  
//											Added ll_row.  ll_row = dw_detail.GetRow().  
//											Replaced dw_detail.GetRow() with ll_row.
//	04/28/00	NLG	Patient Profiles. Column 21 (use_pay_ind) 
//						is relevant only to 1500.  If not 1500, set to space
// 05/05/00	GaryR	SC2862	Out of range dates trigger DB error
// 09/27/02	Jason	Track 2756d	Allow 0 cutoff percentage
//	02/07/03	GaryR	Track 3435d	Do not validate year of service dates
//
////////////////////////////////////////////////////////////////////////

long    ll_period
long    ll_return
integer li_column_count
integer li_column
integer li_dup
integer li_test
integer li_run_dup
string  ls_period
string  ls_period_desc
string  ls_model
string  ls_invoice_type
string  ls_function
string  ls_base_type
string  ls_function_status
string  ls_run_date
datetime ld_run_date
datetime ld_payment_from, ld_payment_thru, ld_srvc_from, ld_srvc_thru
datetime ld_eff_from, ld_eff_thru
DateTime	ldt_eff_begin, ldt_eff_end	//05/05/2000	Gary-R	SC2862
real    lr_cutoff_percent
string  ls_use_catproc
long ll_row
real		lr_patient_cutoff_percent
int		li_rc,li_pat_rank_col_num
string	ls_use_pay_ind

//05/05/2000	Gary-R	SC2862 Begin
n_cst_datetime	lnv_datetime
lnv_datetime.of_SetMinimumDateTime( "01/01/1900" )
//05/05/2000	Gary-R	SC2862 End

SetPointer(Hourglass!)

//************************************************//
// Force check of validation rules on each column //
//************************************************//

li_column_count = integer(dw_detail.Describe("Datawindow.Column.Count"))
dw_detail.AcceptText()
ll_row = dw_detail.GetRow()						//2-3-99 Archana

For li_column = 1 to li_column_count

	li_test = dw_detail.SetColumn(li_column)

	if ib_error  then
		ib_error = FALSE
		Return -1
	end if

	if li_column = 1 then
		ls_period         = String(dw_detail.GetItemNumber(ll_row,1))
		if ls_period      = '' or IsNull(ls_period) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid Period.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1 //jw 8/97 rel 3.6
		end if
	elseif li_column = 7 then
		ls_invoice_type = trim(dw_detail.GetItemString(ll_row,7))
		if ls_invoice_type = '' or IsNull(ls_invoice_type) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid invoice type.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if
	elseif li_column = 8 then
		ls_function = trim(dw_detail.GetItemString(ll_row,8))
		if ls_function = '' or IsNull(ls_function) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid function.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if
	elseif li_column = 9 then 
		ls_base_type = trim(dw_detail.GetItemString(ll_row,9))
		if ls_base_type = '' or IsNull(ls_base_type) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid base type.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1

		end if
	elseif li_column = 10 then
		ls_function_status = trim(dw_detail.GetItemString(ll_row,10))
		if ls_function_status = '' or IsNull(ls_function_status) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid function status.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if
	//05/05/2000	Gary-R	SC2862 Begin
	elseif li_column = 11 then
		IF NOT lnv_datetime.of_IsValid( dw_detail.GetItemDateTime( ll_row, 11 ) ) THEN
			MessageBox('Error', 'Please enter a valid effective begin date.', StopSign!)
			ib_error = TRUE
			dw_detail.SetColumn( 11 )
			dw_detail.SetFocus()
			RETURN -1
		END IF
	elseif li_column = 12 then
		IF NOT lnv_datetime.of_IsValid( dw_detail.GetItemDateTime( ll_row, 12 ) ) THEN
			MessageBox('Error', 'Please enter a valid effective end date.', StopSign!)
			ib_error = TRUE
			dw_detail.SetColumn( 12 )
			dw_detail.SetFocus()
			RETURN -1
		END IF
	//05/05/2000	Gary-R	SC2862 End
	elseif li_column = 13 then
		ls_model    = trim(dw_detail.GetItemString(ll_row,13))
		if ls_model = '' or IsNull(ls_model) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid model.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if
	elseif li_column = 14 then
		ls_run_date    = trim(string(date(dw_detail.GetItemDatetime(ll_row,14))))
		if ls_run_date = '' or IsNull(ls_run_date) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a valid function run date.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if
	elseif li_column = 15 then
		ls_period_desc    = trim(dw_detail.GetItemString(ll_row,15))
		if ls_period_desc = '' or IsNull(ls_period_desc) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a period description.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if

//john_wo 8/97 for 161 - edit for cutoff percent
	elseif li_column = 19  and ls_function = 'RATIO' then
   lr_cutoff_percent = dw_detail.GetItemNumber(ll_row,19)
		if (lr_cutoff_percent < 0) or IsNull(lr_cutoff_percent) or (lr_cutoff_percent > 1 ) then 
//			dw_detail.TriggerEvent('ItemError')
			MessageBox('Error', 'Please enter a cutoff percent between 0 and 1.', StopSign!) //jw 8/97 rel 3.6
			ib_error = True //jw 8/97 rel 3.6
			Return -1
		end if
	
	//NLG 3-1-00 	Column 19 shared between ratios and patient profiles												***START***
	//					Will never have patient profile that is a ratio report
	elseif li_column = 19 and ib_patient_profile then
		//pat_sum_cutoff - cutoff percentage for patient summaries. Must be between 1 and 100.
		lr_patient_cutoff_percent = dw_detail.GetItemNumber(ll_row,19)
// JasonS 09/27/02 Begin - Track 2756d
		if IsNull(lr_patient_cutoff_percent) or (lr_patient_cutoff_percent < 0) or (lr_patient_cutoff_percent >= 1 ) then 
			if lr_patient_cutoff_percent = 1 then
				li_rc = Messagebox('EDIT','The volume of data loaded into the '+&
							'~rpatient summary tables may be extremely high.' +&
							'~rDo you want to modify the Patient Summaries Cutoff Percent?',Question!,YesNo!)
				if li_rc = 1 then
					//let user change datawindow
					dw_detail.SetColumn("pat_sum_cutoff")
					dw_detail.SetFocus()
					ib_error = TRUE
					return -1
				end if
			else
				MessageBox('Error', 'Cutoff percent must be between 0 and 1.', StopSign!) 
				dw_detail.SetColumn("pat_sum_cutoff")
				dw_detail.SetFocus()
				ib_error = True
				Return -1
			end if
		end if
		
//		if IsNull(lr_patient_cutoff_percent) or (lr_patient_cutoff_percent < 0.01) or (lr_patient_cutoff_percent >= 1 ) then 
//			if lr_patient_cutoff_percent = 1 then
//				li_rc = Messagebox('EDIT','The volume of data loaded into the '+&
//							'~rpatient summary tables may be extremely high.' +&
//							'~rDo you want to modify the Patient Summaries Cutoff Percent?',Question!,YesNo!)
//				if li_rc = 1 then
//					//let user change datawindow
//					dw_detail.SetColumn("pat_sum_cutoff")
//					dw_detail.SetFocus()
//					ib_error = TRUE
//					return -1
//				end if
//			else
//				MessageBox('Error', 'Cutoff percent must be between .01 and 1.', StopSign!) 
//				dw_detail.SetColumn("pat_sum_cutoff")
//				dw_detail.SetFocus()
//				ib_error = True
//				Return -1
//			end if
//		end if
// JasonS 09/27/02 End - Track 2756d

	elseif li_column = 20 and ib_patient_profile then
		//pat_rank_col_num - the patient profile ranking column
		li_pat_rank_col_num = dw_detail.GetItemNumber(ll_row,20)
		if (li_pat_rank_col_num < 1) or IsNull(li_pat_rank_col_num) then
			MessageBox('Error', 'Please select a column to rank patient summaries on.', StopSign!)
			dw_detail.SetColumn("pat_rank_col_num")
			dw_detail.SetFocus()
			ib_error = True 
			Return -1
		end if
	elseif li_column = 21 and ib_patient_profile then
		//use_pay_ind - Populate-Payment-indicator. Yes means Payment Amount should be
		//aggregated for specific summary period.  If No, Payment Amount will be populated in
		//the summary master over time, instead of rebuilding it from detail bcp files.
		ls_use_pay_ind = dw_detail.GetItemString(ll_row,21)
		ls_base_type = trim(dw_detail.GetItemString(ll_row,9))
		if ((ls_use_pay_ind <> 'N') AND (ls_use_pay_ind <> 'Y')) OR IsNull(ls_use_pay_ind) then
			IF ls_base_type = '1500' THEN					//NLG 4-28-00
				MessageBox('Error', 'Please choose whether to Compute Payment Amount.', StopSign!)
				dw_detail.SetColumn("use_pay_ind")
				dw_detail.SetFocus()
				ib_error = True 
				Return -1
			ELSE													//NLG 4-28-00
				dw_detail.SetItem(ll_row,21,'')			//NLG 4-28-00
				dw_detail.AcceptText()						//NLG 4-28-00
			END IF//base_type = 1500						//NLG 4-28-00
		end if
		//NLG   patient profiles																			****STOP
		
	end if
	
	If ls_function = 'RATIO' then			//1-6-98 Archana Trk#199
		ls_use_catproc = trim(dw_detail.GetItemString(ll_row,18))
		If IsNull(ls_use_catproc) or (ls_use_catproc <> 'Y' and ls_use_catproc <> 'N') then
			MessageBox('Error','Use Category Procedure must be either "Y" or "N" for Ratio.', StopSign!)
			ib_error = True
			Return -1
		end if
		lr_cutoff_percent = dw_detail.GetItemNumber(ll_row,19)
// JasonS 09/27/02 Begin - Track 2756d		
		If (lr_cutoff_percent < 0 or lr_cutoff_percent > 1) & 
		    or IsNull(lr_cutoff_percent) then 
			MessageBox('Error', 'Please enter a cutoff percent between 0 and 1.', StopSign!) 
			ib_error = True
			Return -1
		end if
//		If (lr_cutoff_percent <= 0 or lr_cutoff_percent > 1) & 
//		    or IsNull(lr_cutoff_percent) then 
//			MessageBox('Error', 'Please enter a cutoff percent between 0 and 1.', StopSign!) 
//			ib_error = True
//			Return -1
//		end if
//	JasonS 09/27/02 End - Track 2756d
	end if
Next

//******************//
// edit date fields //
//******************//

ld_run_date     = dw_detail.GetItemDatetime(ll_row,14)
ld_payment_from = dw_detail.GetItemDatetime(ll_row,5)
ld_payment_thru = dw_detail.GetItemDatetime(ll_row,6)
ld_srvc_from    = dw_detail.GetItemDatetime(ll_row,3)
ld_srvc_thru    = dw_detail.GetItemDatetime(ll_row,4)
ld_eff_from     = dw_detail.GetItemDatetime(ll_row,11)
ld_eff_thru     = dw_detail.GetItemDatetime(ll_row,12)

//jw 8/97 testing for rel 3.6 - the following fields cannot contain a null value on the db.
//This next if statement will prevent a powerbuilder generated messagebox from displaying. 
If IsNull(ld_payment_from) Then
	MessageBox('Error', 'Invalid payment from date', StopSign!)
	Return -1
ElseIf IsNull(ld_payment_thru) Then
	MessageBox('Error', 'Invalid payment thru date', StopSign!)
	Return -1
ElseIf IsNull(ld_eff_from) Then
	MessageBox('Error', 'Invalid effective begin date', StopSign!)
	Return -1
ElseIf IsNull(ld_eff_thru) Then
	MessageBox('Error', 'Invalid effective end date', StopSign!)
	Return -1
End IF

if year(date(ld_payment_from)) < 1980 then
	MessageBox('Error', 'Invalid payment from date', StopSign!)
	Return -1
elseif year(date(ld_payment_thru)) < 1980 then
	MessageBox('Error', 'Invalid payment thru date', StopSign!)
	Return -1
elseif year(date(ld_run_date)) < 1980 then
	MessageBox('Error', 'Invalid run date', StopSign!)
	Return -1
end if

IF NOT lnv_datetime.of_IsValid( ld_srvc_from ) THEN
	MessageBox('Error', 'Invalid service from date', StopSign!)
	Return -1
END IF

IF NOT lnv_datetime.of_IsValid( ld_srvc_thru ) THEN
	MessageBox('Error', 'Invalid service thru date', StopSign!)
	Return -1
END IF

if DaysAfter(date(ld_payment_from), date(ld_payment_thru)) < 0 then
	MessageBox('Error', 'The payment thru date must come after the payment from date.', StopSign!)
	Return -1
end if

if DaysAfter(date(ld_srvc_from), date(ld_srvc_thru)) < 0 then
	MessageBox('Error', 'The service thru date must come after the service from date.', StopSign!)
	Return -1
end if

if DaysAfter(date(ld_eff_from), date(ld_eff_thru)) < 0 then
	MessageBox('Error', 'The effective end date must come after the effective begin date.', StopSign!)
	Return -1
end if

if dw_detail.GetItemStatus(ll_row, 5, Primary!) <> NotModified! and (ls_function_status = 'AC' or ls_function_status = 'GE') then
	dw_detail.SetItem(ll_row, 5, id_orig_payment_from)
	dw_detail.SetItemStatus(ll_row, 5, Primary!, NotModified!)
	MessageBox('Error', 'You can not change the payment from date of an active period.', StopSign!)
	Return -1
elseif dw_detail.GetItemStatus(ll_row, 6, Primary!) <> NotModified! and (ls_function_status = 'AC' or ls_function_status = 'GE') then
	dw_detail.SetItem(ll_row, 6, id_orig_payment_thru)
	dw_detail.SetItemStatus(ll_row, 6, Primary!, NotModified!)
	MessageBox('Error', 'You can not change the payment thru date of an active period.', StopSign!)
	Return -1
elseif dw_detail.GetItemStatus(ll_row, 3, Primary!) <> NotModified! and (ls_function_status = 'AC' or ls_function_status = 'GE') then
	dw_detail.SetItem(ll_row, 3, id_orig_srvc_from)
	dw_detail.SetItemStatus(ll_row, 3, Primary!, NotModified!)
	MessageBox('Error', 'You can not change the service from date of an active period.', StopSign!)
	Return -1
elseif dw_detail.GetItemStatus(ll_row, 4, Primary!) <> NotModified! and (ls_function_status = 'AC' or ls_function_status = 'GE') then
	dw_detail.SetItem(ll_row, 4, id_orig_srvc_thru)
	dw_detail.SetItemStatus(ll_row, 4, Primary!, NotModified!)
	MessageBox('Error', 'You can not change the service thru date of an active period.', StopSign!)
	Return -1
elseif dw_detail.GetItemStatus(ll_row, 13, Primary!) <> NotModified! and (ls_function_status = 'AC' or ls_function_status = 'GE') then
	dw_detail.SetItem(ll_row, 13, is_orig_model)
	dw_detail.SetItemStatus(ll_row, 13, Primary!, NotModified!)
	MessageBox('Error', 'You can not change the model of an active period.', StopSign!)
	Return -1
elseif dw_detail.GetItemStatus(ll_row, 14, Primary!) <> NotModified! and (ls_function_status = 'AC' or ls_function_status = 'GE') then
	dw_detail.SetItem(ll_row, 14, id_orig_run_date)
	dw_detail.SetItemStatus(ll_row, 14, Primary!, NotModified!)
	MessageBox('Error', 'You can not change the run date of an active period.', StopSign!)
	Return -1
end if

if NOT IsNumber(ls_model) then
	MessageBox('Error', 'Invalid Model Year')
	Return -1
end if

//******************************************//
// don't all duplicates if adding a new row //
//******************************************//

ll_period = long(ls_period)

if ib_new then
	SELECT count(*)
	INTO   :li_dup
	FROM   period_cntl
	WHERE  period       = :ll_period and
   	    invoice_type = Upper( :ls_invoice_type ) and
      	 function_name   = Upper( :ls_function )
	USING  stars2ca;

	if stars2ca.of_check_status() = -1 then
		Rollback using stars2ca;
		MessageBox('Error', 'Error selecting from period_cntl')
		Return -1
	else
		Commit using stars2ca;
	end if

	if li_dup > 0 then
		MessageBox('Error', 'A row already exists with the same period, invoice type, and function.')
		Return -1
	end if
end if

//***********************************************//
// don't allow a row to be added if a row exists //
// with the same function/ivoice/run date        //
//***********************************************//

SELECT count(*)
  INTO :li_run_dup
  FROM period_cntl
 WHERE period            <> :ll_period and
 	    invoice_type      = Upper( :ls_invoice_type ) and
    	 FUNCTION_NAME          = Upper( :ls_function ) and
       function_run_date = :ld_run_date
USING  stars2ca;

if stars2ca.of_check_status() = -1 then
	Rollback using stars2ca;
	MessageBox('Error', 'Error selecting from period_cntl')
	Return -1
else
	Commit using stars2ca;
end if

if li_run_dup > 0 then
	MessageBox('Error', 'A row already exists with the same invoice type, function, and run date.')
	Return -1
end if

//*************//
// edit period //
//*************//

if dw_detail.GetItemStatus(ll_row, 'period', Primary!) <> NotModified! OR dw_detail.GetItemStatus(ll_row, 'model', Primary!) <> NotModified! then 
	if mid(ls_period,2,2) <> right(ls_model,2) then
		ll_return = MessageBox('Warning', 'The period does not match the model year.  Continue with update?', Exclamation!, YesNo!)
		if ll_return = 2 then 
			MessageBox('Update', 'Update Canceled', Information!)
			Return -1
		end if
	end if
end if

//*******************************************************//
// if it gets this far the datawindow is valid, return 1 //
//*******************************************************//

Return 1
end function

event open;call super::open;//2-3-00 Archana  Move retrieve datawindow to ue_retrieve event

long ll_key, ll_current_row
datetime ld_default_begin, ld_default_end
long ll_count //jww 8/97 rel 3.6
SetPointer(Hourglass!)

//	FDG 07/31/97 - Disable closequery processing
ib_disableclosequery	=	TRUE

ld_default_begin = datetime(date('01/01/1900'))
ld_default_end   = datetime(date('06/06/2079'))

This.of_SetTransaction (STARS2CA)	// Register this transaction

This.TriggerEvent("ue_retrieve")

end event

event closequery;/////////////////////////////////////////////////////////////////////////////////////
//
//	Gary-R 05/23/2000	TS2288 Dev	Skips validation. Also GPF if parent is closed
//
/////////////////////////////////////////////////////////////////////////////////////

SetPointer(Hourglass!)

//*************************************************************//
// if changes have been made to the current row prompt to save //
//*************************************************************//
dw_detail.AcceptText()						// Gary-R 05/23/2000	TS2288 Dev
if dw_detail.ModifiedCount() > 0 then
	if MessageBox('Close', 'Save changes to the current period before closing?', Question!, YesNo!) = 1 then
		ib_error = FALSE						// Gary-R 05/23/2000	TS2288 Dev
		if wf_update() = - 1 then
			Return 1
		end if
	end if
end if

//*************************//
// refresh the list window //
//*************************//
IF IsValid( w_period_cntl_list ) THEN						// Gary-R 05/23/2000	TS2288 Dev
	w_period_cntl_list.cb_list.TriggerEvent(Clicked!)
	w_period_cntl_list.dw_period_cntl_list.TriggerEvent(rowfocuschanged!)
END IF

end event

on w_period_cntl_detail.create
int iCurrent
call super::create
this.dw_detail=create dw_detail
this.cb_update=create cb_update
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.dw_list_summ_rel=create dw_list_summ_rel
this.dw_copy_summ_rel=create dw_copy_summ_rel
this.cb_updateadd=create cb_updateadd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.cb_update
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_list_summ_rel
this.Control[iCurrent+7]=this.dw_copy_summ_rel
this.Control[iCurrent+8]=this.cb_updateadd
end on

on w_period_cntl_detail.destroy
call super::destroy
destroy(this.dw_detail)
destroy(this.cb_update)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.dw_list_summ_rel)
destroy(this.dw_copy_summ_rel)
destroy(this.cb_updateadd)
end on

event ue_preopen;call super::ue_preopen;// Get the parm passed to this window

il_period_key = Long(Message.StringParm)

end event

event ue_retrieve;//w_period_cntl_detail.ue_retrieve()
//
//	3-9-00	NLG	Patient profile changes.  3 columns added to period_cntl_detail: 
//						1) pat_sum_rank_col - the summary column mainframe uses to sort/rank the summary
//						2)	pat_sum_cutoff - this is actually cutoff
//						3)	use_pay_ind - for 1500 patient summaries, indicates whether to use payment_amt on extract
//
// 1-25-02 JSB    Track 2756.  Initialize USE_PAY_IND.
// JasonS 09/27/02 Track 2756 Set itemstatus to not modified when changing an item
//	03/09/07	Katie	SPR 4942 Add crit_ind, Moved population of pat_rank_col_num to dw_detail.ue_retrieve_groupbox
//	05/24/07	Katie	SPR 4942 Moved updating the CRIT_IND to the SYS_CNTL entry into the area where it would
//						only be changed if we are adding a new row.
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 2-3-00 Archana Moving code from the open event to here..

int li_rc, li_crit_id, li_run_by_opt
long ll_key, ll_current_row, ll_count, ll_row
datetime ld_default_begin, ld_default_end

ld_default_begin = datetime(date('01/01/1900'))
ld_default_end = datetime(date('06/06/2079'))

datawindowchild ldwc
li_rc = dw_detail.GetChild("pat_rank_col_num",ldwc)
ldwc.InsertRow(0)

ll_count = dw_detail.Retrieve (il_period_key)
dw_detail.ScrollToRow(ll_count)						//2-3-00 Archana
If ll_count = 1 Then
	ll_key = dw_detail.GetItemNumber(1,'period')
	if Not IsNull(ll_key) then
		dw_detail.SetTabOrder("period",0)
		dw_detail.SetTabOrder("base_type",0)
		dw_detail.SetTabOrder("FUNCTION_NAME",0)
		dw_detail.SetTabOrder("invoice_type",0)
	else
		dw_detail.SetTabOrder("period",10)
		dw_detail.SetTabOrder("base_type",20)
		dw_detail.SetTabOrder("FUNCTION_NAME",30)
		dw_detail.SetTabOrder("invoice_type",40)
		ll_current_row = dw_detail.GetRow()
		dw_detail.SetItem(ll_current_row, 'effective_begin_date', ld_default_begin)
		dw_detail.SetItem(ll_current_row, 'effective_end_date', ld_default_end)
		// JasonS 09/27/02 Begin - Track 2756d
		dw_detail.setitemstatus(ll_current_row, 'effective_begin_date', Primary!, NotModified!)
		dw_detail.setitemstatus(ll_current_row, 'effective_end_date', Primary!, NotModified!)
		// JasonS 09/27/02 End - Track 2756d
	end if
Else
	ll_current_row = dw_detail.InsertRow(0)
	dw_detail.SetItem(ll_current_row, 'effective_begin_date', ld_default_begin)
	dw_detail.SetItem(ll_current_row, 'effective_end_date', ld_default_end)
	dw_detail.SetItem(ll_current_row, 'period_key', il_period_key)
	// JasonS 09/27/02 Begin - Track 2756d
	dw_detail.setitemstatus(ll_current_row, 'effective_begin_date', Primary!, NotModified!)
	dw_detail.setitemstatus(ll_current_row, 'effective_end_date', Primary!, NotModified!)
	dw_detail.setitemstatus(ll_current_row, 'period_key', Primary!, NotModified!)	
	// JasonS 09/27/02 End - Track 2756d
	
	inv_sys_cntl = CREATE u_nvo_sys_cntl_range
	inv_sys_cntl.of_set_cntl_id( "SUM_CRIT")
	li_crit_id = inv_sys_cntl.of_get_cntl_no()
	dw_detail.setitem( 1, 'crit_ind', String(li_crit_id))
	
	inv_sys_cntl.of_set_cntl_id( "SUM_RUN_BY")
	li_run_by_opt = inv_sys_cntl.of_get_cntl_no()
	dw_detail.setitem( 1, 'run_by_options', li_run_by_opt)
	
	dw_detail.ScrollToRow(ll_current_row)
End If

//3-9-00 NLG Patient profiles
//Get summary table_name & sum_flag from sum_rel. Determine if patient profile.
//If summary is a patient profile, get the dictionary.elem_tbl_type
//for this table.  If a column has 'RANK' in value_a, it's a column that can
//be used to rank the summary file on the mainframe.  Value_n is the column number
//that the mainframe program will use to determine the summary extract column name.
int li_col, li_pos 
long ll_period,ll_rowcount
string ls_function,ls_invoice
n_ds lds_sum_rel_table_name

//get the arguments to pass to datastore
ll_row      = dw_detail.GetRow()
ll_period   = dw_detail.GetItemNumber(ll_row, 'period')
ls_function = dw_detail.GetItemString(ll_row, 'FUNCTION_NAME')
ls_invoice  = dw_detail.GetItemString(ll_row, 'invoice_type')

dw_detail.event ue_retrieve_groupbox(ls_function,ls_invoice,ll_period)

if IsNULL(dw_detail.getitemstring(1,'use_pay_ind')) &
or (trim(dw_detail.getitemstring(1,'use_pay_ind'))) = '' THEN
	dw_detail.setItem(1,'use_pay_ind','N')
	dw_detail.setitemstatus(1, 'use_pay_ind', Primary!, NotModified!)	
end if

end event

type dw_detail from u_dw within w_period_cntl_detail
string accessiblename = "Period Detail"
string accessibledescription = "Period Detail"
accessiblerole accessiblerole = clientrole!
event ue_retrieve_groupbox ( string as_function,  string as_invoice_type,  long al_period )
integer x = 37
integer y = 24
integer width = 2651
integer height = 1272
integer taborder = 10
string dataobject = "d_period_cntl_detail"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_retrieve_groupbox(string as_function, string as_invoice_type, long al_period);//Populate the pant_rank_col_num drop-down with appropriate fields and turn the group box on or off based on whether this is a pat
//profile or not.
//********************************
// Katie 03/09/07	SPR 4942 Created

datawindowchild ldwc
int li_rc, li_col, li_pos
long ll_rowcount
n_ds lds_sum_rel_table_name

li_rc = this.GetChild('pat_rank_col_num',ldwc)
ldwc.InsertRow(0)

ib_patient_profile = false
lds_sum_rel_table_name = CREATE n_ds
lds_sum_rel_table_name.dataobject = 'd_sum_rel_table_name'
lds_sum_rel_table_name.SetTransObject(stars2ca)
ll_rowcount = lds_sum_rel_table_name.retrieve(as_invoice_type,al_period, as_function )

if (ll_rowcount > 0) then
	is_patient_profile_table_name = lds_sum_rel_table_name.GetItemString(1,'table_name')
	ib_patient_profile = TRUE
else
	if (ll_rowcount = 0) then
		ib_patient_profile = FALSE
	else
		ib_patient_profile = FALSE
		messagebox('ERROR','Error reading sum_rel for: ' + as_invoice_type + '~period: ' + string(al_period) + '~rfunction' + as_function)
	end if
end if

if isValid(lds_sum_rel_table_name) then destroy lds_sum_rel_table_name

if (ib_patient_profile) then
	li_rc = ldwc.SetTransObject(stars2ca)
	ll_rowcount = ldwc.retrieve(is_patient_profile_table_name)
	for li_col = 1 to ll_rowcount
		li_pos = Pos(ldwc.GetItemString(li_col,'elem_desc'),'/')
		If li_pos > 0 then
			ldwc.SetItem(li_col,'elem_desc',left(ldwc.GetItemString(li_col,'elem_desc'),min(18,li_pos - 1)))
			ldwc.setitemstatus(li_col,0,Primary!,NotModified!)
		end if
	next
	parent.event ue_set_pat_prof_groupbox(TRUE)
else
	parent.event ue_set_pat_prof_groupbox(FALSE)
end if
end event

on retrieveend;call u_dw::retrieveend;if dw_detail.GetRow() > 0 then
	id_orig_payment_from = dw_detail.GetItemDatetime(dw_detail.GetRow(),5)
	id_orig_payment_thru = dw_detail.GetItemDatetime(dw_detail.GetRow(),6)
	id_orig_srvc_from    = dw_detail.GetItemDatetime(dw_detail.GetRow(),3)
	id_orig_srvc_thru    = dw_detail.GetItemDatetime(dw_detail.GetRow(),4)
	id_orig_run_date     = dw_detail.GetItemDatetime(dw_detail.GetRow(),14)
	is_orig_model        = dw_detail.GetItemString(dw_detail.GetRow(),13)
end if
end on

on itemerror;call u_dw::itemerror;ib_error = TRUE
end on

on retrievestart;call u_dw::retrievestart;this.SetTransObject(stars2ca)
end on

on ue_insert;call u_dw::ue_insert;if wf_get_new_key() = -1 then Return
end on

on rowfocuschanged;call u_dw::rowfocuschanged;this.ScrollToRow(this.GetRow())
end on

event itemchanged;//*********************************************************************************
// Script Name:	dw_details.itemchanged()
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	If FUNCTION_NAME = SUM Check to see if patient profiles loaded for this period
//						If so, make the patient profiles groupbox visible.
//
//*********************************************************************************
//	
// 3-20-00 NLG	Stars 4.5 Patient Profiles.	Created
//	5-11-00 NLG When there are no summary rows for most recent period,
//					caused error.  Add check for most recent period for
//					invoice type and FUNCTION_NAME = SUM
//	03/09/07	Katie	SPR 4942 Added call to ue_retrieve_groupbox function to 
//
//*********************************************************************************


Integer			li_rc
long				ll_period,			&
					ll_rows,				&
					ll_sum_rel_rows
String			ls_data,				&
					ls_function, 		&
					ls_invoice_type,	&
					ls_base_type,		&
					ls_model

ll_sum_rel_rows = 0 //initialize 

CHOOSE CASE dwo.name
	CASE 'function_name'
		//user has changed Function
		ls_function = data		
		ls_invoice_type 	= trim(this.object.invoice_type [row])
		ls_base_type 		= trim(this.object.base_type [row])
	CASE 'base_type'
		//base_type has changed
		ls_base_type 		= 	data
		ls_function 		=	trim(dw_detail.GetItemString(row,'function_name'))
		ls_invoice_type 	= 	trim(this.object.invoice_type [row])
	CASE 'invoice_type'
		//invoice type has changed
		ls_invoice_type 	= 	data
		ls_base_type 		= 	trim(this.object.base_type [row])
		ls_function 		= trim(dw_detail.GetItemString(row,'function_name'))
	CASE ELSE
		//exit 
		return 0
END CHOOSE

IF match(ls_function, 'SUM') THEN//Will either be 'SUM' or 'SUMM'
	//If there are values for base_type & invoice_type, get the most
	//recent period for the invoice type
	IF NOT(ls_invoice_type = '' OR IsNull(ls_invoice_type)) THEN
		select max(model) into :ls_model
		from period_cntl
		where model <> 'NONE' 
		and FUNCTION_NAME = 'SUM'						//NLG 5-11-00
		and invoice_type = Upper( :ls_invoice_type )	//NLG 5-11-00
		using stars2ca;
		if stars2ca.of_check_status() <> 0 then
			Rollback using stars2ca;
			MessageBox('ERROR', 'Error getting max Model from period_cntl' +&
							'~rin dw_detail.itemchanged()',StopSign!)
			Return -1
		else
			stars2ca.of_commit()
		end if
		n_ds lds_period
		lds_period = CREATE n_ds
		lds_period.dataobject = 'd_period_list_max_period'
		//this datastore uses the model + invoice type to get most current period
		//for function = 'SUM'
		li_rc = lds_period.SetTransObject(STARS2CA)
		ll_rows = lds_period.Retrieve(ls_model,ls_invoice_type)
		IF ll_rows > 0 THEN
			ll_period = lds_period.object.period[1]//The 1st row is the most current period
		ELSE
			MessageBox('ERROR', 'Error getting most current Period from period_cntl' +&
							'~rin dw_detail.itemchanged()',StopSign!)
			IF IsValid(lds_period) THEN destroy lds_period
			Return -1
		END IF
		IF IsValid(lds_period) THEN destroy lds_period
	END IF//An invoice type has been selected
END IF//Function is SUM

this.event ue_retrieve_groupbox(ls_function, ls_invoice_type, ll_period)


end event

type cb_update from u_cb within w_period_cntl_detail
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 443
integer y = 1352
integer width = 320
integer height = 120
integer taborder = 20
string text = "&Update"
boolean default = true
end type

on clicked;SetPointer(Hourglass!)

ib_error = FALSE

if (wf_update() = - 1) then
	Return
end if

ib_new = FALSE


end on

type cb_add from u_cb within w_period_cntl_detail
string accessiblename = "Next Add"
string accessibledescription = "Next Add"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1207
integer y = 1352
integer width = 320
integer height = 120
integer taborder = 50
string text = "&Next Add"
end type

on clicked;if wf_add() = -1 then Return 



end on

type cb_delete from u_cb within w_period_cntl_detail
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1582
integer y = 1352
integer width = 320
integer height = 120
integer taborder = 60
string text = "&Delete"
end type

on clicked;dw_detail.SetFocus()
if wf_delete() = -1 then Return


end on

type cb_close from u_cb within w_period_cntl_detail
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1961
integer y = 1352
integer width = 320
integer height = 120
integer taborder = 70
string text = "&Close"
end type

on clicked;close(parent)
end on

type dw_list_summ_rel from u_dw within w_period_cntl_detail
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 73
integer y = 1312
integer width = 183
integer height = 192
integer taborder = 30
string dataobject = "d_copy_summ_rel"
end type

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in the data.
This.of_SetTrim (TRUE)

end event

type dw_copy_summ_rel from u_dw within w_period_cntl_detail
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 293
integer y = 1312
integer width = 183
integer height = 192
integer taborder = 80
string dataobject = "d_copy_summ_rel"
end type

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in the data.
This.of_SetTrim (TRUE)

end event

type cb_updateadd from u_cb within w_period_cntl_detail
string accessiblename = "Add"
string accessibledescription = "Add"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 823
integer y = 1352
integer width = 320
integer height = 120
integer taborder = 40
string text = "&Add"
end type

on clicked;//*****************************************************//
// this does the same thing as the update button, but  //
// to keep in synch with the way stars works in other  //
// windows I added this button for updates of new rows //
//*****************************************************//

SetPointer(Hourglass!)

ib_error = FALSE

if (wf_update() = - 1) then
	Return
end if

ib_new = FALSE
end on

