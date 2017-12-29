$PBExportHeader$w_period_cntl_list.srw
$PBExportComments$Period_cntl list window (inherited from w_master)
forward
global type w_period_cntl_list from w_master
end type
type ddlb_dw_ops from dropdownlistbox within w_period_cntl_list
end type
type st_1 from statictext within w_period_cntl_list
end type
type cb_list from u_cb within w_period_cntl_list
end type
type cb_delete from u_cb within w_period_cntl_list
end type
type cb_add from u_cb within w_period_cntl_list
end type
type cb_next_year from u_cb within w_period_cntl_list
end type
type cb_close from u_cb within w_period_cntl_list
end type
type cb_file from u_cb within w_period_cntl_list
end type
type cb_select from u_cb within w_period_cntl_list
end type
type dw_model from u_dw within w_period_cntl_list
end type
type dw_file_detail from u_dw within w_period_cntl_list
end type
type dw_file_purge from u_dw within w_period_cntl_list
end type
type sle_count from singlelineedit within w_period_cntl_list
end type
type st_2 from statictext within w_period_cntl_list
end type
type dw_list_summ_rel from u_dw within w_period_cntl_list
end type
type dw_copy_summ_rel from u_dw within w_period_cntl_list
end type
type dw_dates from u_dw within w_period_cntl_list
end type
type dw_period_cntl_list from u_dw within w_period_cntl_list
end type
type dw_invoice_desc from u_dw within w_period_cntl_list
end type
type dw_catg_proc from u_dw within w_period_cntl_list
end type
type sle_run_date from editmask within w_period_cntl_list
end type
end forward

global type w_period_cntl_list from w_master
long backcolor = 67108864
string accessiblename = "Period Control List"
string accessibledescription = "Period Control List"
accessiblerole accessiblerole = windowrole!
integer width = 2802
integer height = 1708
string title = "Period Control List"
event type boolean ue_check_if_pat_profile ( string inv_type,  long period,  string funct )
ddlb_dw_ops ddlb_dw_ops
st_1 st_1
cb_list cb_list
cb_delete cb_delete
cb_add cb_add
cb_next_year cb_next_year
cb_close cb_close
cb_file cb_file
cb_select cb_select
dw_model dw_model
dw_file_detail dw_file_detail
dw_file_purge dw_file_purge
sle_count sle_count
st_2 st_2
dw_list_summ_rel dw_list_summ_rel
dw_copy_summ_rel dw_copy_summ_rel
dw_dates dw_dates
dw_period_cntl_list dw_period_cntl_list
dw_invoice_desc dw_invoice_desc
dw_catg_proc dw_catg_proc
sle_run_date sle_run_date
end type
global w_period_cntl_list w_period_cntl_list

type variables
long il_period_id

string is_function
//string is_dw_control					//	09/10/02	GaryR	Track 3468d
string is_selected
//string is_dw_categ_proc_orig		//	09/10/02	GaryR	Track 3468d

// Ratio report indicator (Use billed or allowed amount)
String	is_use_bill_alwd

long il_period_key
long il_update
long il_row_selected

//w_uo_win iw_uo_win						//	09/10/02	GaryR	Track 3468d

sx_decode_structure iv_decode_struct

boolean ib_pat_profile
end variables

forward prototypes
public subroutine wf_select ()
public function long wf_get_new_key ()
public function string wf_padinteger (integer pad_number, integer num_chars)
public function string wf_padstring (string string_text, integer num_chars)
public function boolean wf_leap_year (string arg_year)
public function string wf_create_desc (integer arg_row, string arg_model)
public function string wf_share (string arg_function, string arg_share, string arg_use_catgproc)
public subroutine wf_set_table_name (u_dw arg_dw_name, string arg_invoice)
public function datetime wf_create_date (string arg_column, integer arg_row)
public function integer wf_delete ()
public function integer wf_model ()
public function integer wf_catg_proc (long arg_period, string arg_invoice)
public function integer wf_file ()
end prototypes

event ue_check_if_pat_profile;//ue_check_if_pat_profile
//
//Arguments:
//	1)	inv_type
//	2)	period
//	3)	funct
//
//Returns: boolean
//
//Description:
// This function reads sum_rel to determine if summary is a patient profile (sum_flag = 'B')
//
//History:
//	03-03-00	NLG	Created
////////////////////////////////////////////////////////////////////////////////////////////////

long		ll_rows,ll_period
string 	ls_inv_type,ls_function
int 		li_rc
n_ds		lds_sum_rel

ls_inv_type = inv_type
ll_period 	= period
ls_function = funct

lds_sum_rel = CREATE n_ds
lds_sum_rel.dataobject = 'd_sum_rel_table_name'
li_rc = lds_sum_rel.SetTransObject(stars2ca)

ll_rows = lds_sum_rel.Retrieve(ls_inv_type,ll_period,ls_function)
if ll_rows > 0 then
	return TRUE
else
	if ll_rows = 0 then
		return FALSE
	else
		Messagebox("ERROR","Error reading sum_rel to determine if function is a patient profile")
		return FALSE
	end if
end if
end event

public subroutine wf_select ();string ls_detail_parm

SetPointer(Hourglass!)

//**************************************************//
// open w_period_cntl_detail passing current period //
//**************************************************//

ls_detail_parm = string(il_period_key)

OpenSheetwithparm(w_period_cntl_detail,ls_detail_parm,mdi_main_frame,help_menu_position,Layered!)

end subroutine

public function long wf_get_new_key ();long ll_max_key
long ll_new_key

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

ll_new_key = ll_max_key + 1

Return ll_new_key
end function

public function string wf_padinteger (integer pad_number, integer num_chars);SetPointer(Hourglass!)

STRING ls_string1, ls_string2

ls_string1 = "0000000000000000" + String ( pad_number)
ls_string2 = Right ( ls_string1, num_chars )

RETURN ls_string2


end function

public function string wf_padstring (string string_text, integer num_chars);SetPointer(Hourglass!)

STRING ls_string1, ls_string2

IF IsNull(string_text) OR (string_text = " ") OR (string_text = "") THEN
	ls_string2 = Space(num_chars)
ELSE
	ls_string1 = string_text + Space ( num_chars )
	ls_string2 = Left ( ls_string1, num_chars )
END IF

RETURN ls_string2


end function

public function boolean wf_leap_year (string arg_year);//***********************************************************************
// f_leap_year
// 
// This function returns true if the specified year is a leap year
// and false if it's not a leap year or if it is an invalid year.
// 
// Usage: 
//   if (f_leap_year(Year)) then
//
// Where:
//   Year  = (String) Specifies the number of the year that you wish 
//                    to determine if it's a leap year.
//
// Usage Notes:
//   Year can be specified with or without the century.  If the 
//     century is not specified the current century is used.
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 09/23/94 JMS  Created
//***********************************************************************

SetPointer(Hourglass!)

integer li_year

if (Not IsNumber(arg_year)) or (Pos(arg_year,'.') <> 0) then return false

if (Len(arg_year) = 2)          then arg_year = Left(String(Today(),'yyyy'),2) + arg_year

li_year = Integer(arg_year)

if (Mod(li_year,4) = 0)			  then
   if (Mod(li_year,100) = 0) 	  then
      if (Mod(li_year,400) = 0) then 
			return true
      else
			return false
		end if
   else  
		return true
	end if
else 
	return false
end if


end function

public function string wf_create_desc (integer arg_row, string arg_model);////////////////////////////////////////////////////////////////////////
//
//	04/01/04	GaryR	Track 4927c	Increase all years by one.	Upto two years.
//
////////////////////////////////////////////////////////////////////////

String	ls_current_desc, ls_year
Integer	li_year, li_prior_year, li_current_year, li_pos

ls_current_desc = dw_period_cntl_list.GetItemString(arg_row, 'period_desc')

li_current_year  = Integer( arg_model )
li_prior_year = li_current_year - 2

FOR li_year = li_current_year TO li_prior_year STEP -1
	ls_year = String( li_year )
	li_pos = Pos( ls_current_desc, ls_year )
	DO WHILE li_pos > 0
		ls_current_desc = Replace( ls_current_desc, li_pos, Len( ls_year ), String( li_year + 1 ) )
		li_pos = Pos( ls_current_desc, ls_year, li_pos + 1 )
	LOOP
NEXT

Return ls_current_desc
end function

public function string wf_share (string arg_function, string arg_share, string arg_use_catgproc);////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	05/20/99	Track 1804c.  4.0 SP2.  Reduce the filler from 7 bytes
//						to 6 bytes and pass use_bill_alwd.
//	NLG	05/18/00	Patient profiles. If patient profiles exists for this
//						period, will write out 6 more bytes.  Lessen fill from
//						26 to 20.
//	GaryR	05/05/08	SPR 5293	Eliminate 6 extra spaces for SARS and Ratios.
//
////////////////////////////////////////////////////////////////////////

string ls_spaces, ls_return_share

//NLG 5/18/00 																Start****
IF ib_pat_profile THEN
	ls_spaces = Fill(' ', 20)
	arg_share = Left(arg_share + ls_spaces, 20)
ELSE
	ls_spaces = Fill(' ', 26)
	arg_share = Left(arg_share + ls_spaces, 26)
END IF

//NLG 5/18/00																Stop****

if arg_function = 'SUM' then
	ls_return_share = arg_share
else
	ls_return_share = Fill(' ', 20)
end if

//john_wo 8/97- Added the next if statement for spec 161 
//- add use_catgproc for ratio functions. rel 3.6- 
If arg_function = 'RATIO' then
	ls_return_share	=	Left(ls_spaces,18) + arg_use_catgproc + &
								wf_padstring(is_use_bill_alwd, 1)
End If

Return ls_return_share
end function

public subroutine wf_set_table_name (u_dw arg_dw_name, string arg_invoice);string ls_new_sql, ls_new_tbl_name
integer li_pos, li_pos_from

//*********************************//
// determine table name to be used //
//*********************************//

Select col_name
Into :ls_new_tbl_name
From Stars_win_parm
Where Win_id = 'W_CATEG_LIST_MAINTAIN' and tbl_type = Upper( :arg_invoice )
Using Stars2ca;

If stars2ca.of_check_status() = 100 Then
	Messagebox('EDIT','Column name not found where Win_id = w_categ_list_maintain and tbl_type = ' + arg_invoice,stopsign!)
	return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error reading Stars Win Parm Where Win_id = w_categ_list_maintain and tbl_type = ' + arg_invoice)
	Return
End If

ls_new_sql = arg_dw_name.Describe("Datawindow.Table.Select")

li_pos_from = pos(upper(ls_new_sql), 'FROM')

li_pos = pos(ls_new_sql,'CATG_PROC',li_pos_from+1)

ls_new_sql = replace(ls_new_sql,li_pos,len('CATG_PROC'),ls_new_tbl_name)

arg_dw_name.Modify('Datawindow.Table.Select="'+ls_new_sql+'"')

end subroutine

public function datetime wf_create_date (string arg_column, integer arg_row);//**********************************************************
// this function adds one year to the date passed 
//**********************************************************
//
//	10/25/01	GaryR	Track 2487d	Null dates are 1/1/1900
//
//**********************************************************

SetPointer(Hourglass!)

date     ld_date, ld_default	//	10/25/01	GaryR	Track 2487d
datetime ld_null
datetime ld_return_date

ld_date = date(dw_period_cntl_list.GetItemDatetime(arg_row, arg_column))

if IsNull(ld_date) then 
	SetNull(ld_null)
	Return ld_null
end if

//	10/25/01	GaryR	Track 2487d
IF ld_date = ld_default THEN	Return DateTime( ld_date )

ld_date = date(string(ld_date,"mm/dd/yyyy"))

ld_return_date = datetime(date(string(month(ld_date)) + '/' + string(day(ld_date)) + '/' + string(year(ld_date) + 1)))

Return ld_return_date
end function

public function integer wf_delete ();long ll_row, ll_period
string ls_function, ls_invoice

SetPointer(Hourglass!)

//****************************************************//
// delete the current row from the datawindow then do //
// an update of the datawindow and refresh the list   //
//****************************************************//

ll_row      = dw_period_cntl_list.GetRow()
ll_period   = dw_period_cntl_list.GetItemNumber(ll_row, 'period')
ls_function = dw_period_cntl_list.GetItemString(ll_row, 'FUNCTION_NAME')
ls_invoice  = dw_period_cntl_list.GetItemString(ll_row, 'invoice_type')

dw_period_cntl_list.SetFocus()
This.TriggerEvent('ue_delete')

This.TriggerEvent('ue_save')

dw_period_cntl_list.Event	ue_retrieve()

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

Return 1

end function

public function integer wf_model ();///////////////////////////////////////////////////////////////////
//
//	01/15/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	03/28/01	FDG	Stars 4.7.	Make the SQL Delete DBMS-independent
//	03/09/07	Katie	SPR 4942 Added support for CRIT_IND column in PERIOD_CNTL
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//
///////////////////////////////////////////////////////////////////

string ls_invoice_type,ls_function,ls_base_type,ls_use_bill_alwd
string ls_current_model,ls_period_desc,ls_new_model
string ls_model, ls_status, ls_copy_function, ls_copy_invoice
string ls_crit_ind

datetime	ld_effective_begin_date, ld_effective_end_date
datetime ld_function_run_date, ld_extract_date
datetime ld_from_date, ld_thru_date, ld_get_date, ld_max_date
datetime ld_payment_from_date, ld_payment_thru_date
long ll_period, ll_period_key, ll_setitem_row, ll_count
long ll_row, ll_row_count, ll_new_row, ll_copy_row, ll_next_row
long ll_copy_period

string ls_catg_proc
decimal ld_percent

string ls_use_pay_ind, ls_empty
int li_pat_rank_col_num, li_rc, li_crit_ind, li_run_by_opt

SetPointer(Hourglass!)

//************************************************************//
// refresh the list to be sure the data has not been filtered //
//************************************************************//

dw_period_cntl_list.Setfilter('')
dw_period_cntl_list.Filter()
sle_count.text = string(dw_period_cntl_list.RowCount())

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

inv_sys_cntl = CREATE u_nvo_sys_cntl_range
inv_sys_cntl.of_set_cntl_id( "SUM_CRIT")
li_crit_ind = inv_sys_cntl.of_get_cntl_no()

inv_sys_cntl.of_set_cntl_id( "SUM_RUN_BY")
li_run_by_opt = inv_sys_cntl.of_get_cntl_no()

//************************************//
// get current model from period_cntl //
//************************************//

SELECT distinct(max(model))
INTO   :ls_current_model
FROM   period_cntl
WHERE  model > ' ' and model < 'A'  //john-wo rel 3.6- fix problem found while testing 161
USING  stars2ca;

ls_new_model               = string(integer(ls_current_model) + 1) 

if MessageBox('Next Year', 'Create a new model for ' + ls_new_model + ' ?', Question!, YesNo!) = 2 then Return 1

//**************************************//
// delete rows from sum_rel where the   //
// period does not exist in period_cntl //
//**************************************//

DELETE FROM sum_rel
 WHERE period not in (SELECT period
                        FROM period_cntl) and
       period <> 999999
 USING stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Next Year', 'Error deleting rows from sum_rel', StopSign!)
	Return -1
else
	Commit using stars2ca;
end if

//*******************************************//
// create new sum_rel rows for the new model //
// using the 999999 model in sum_rel.        //
//*******************************************//

// retrieve from period_cntl where the model = max(model)

dw_dates.Reset()
dw_dates.SetTransObject(stars2ca)
dw_dates.Retrieve(ls_current_model)   

For ll_copy_row = 1 to dw_dates.RowCount()

	ll_copy_period   = dw_dates.GetItemNumber(ll_copy_row, 'period') + 1000
	ls_copy_function = dw_dates.GetItemString(ll_copy_row, 'FUNCTION_NAME')
	ls_copy_invoice  = dw_dates.GetItemString(ll_copy_row, 'invoice_type')

	// retrieve from sum_rel with 999999 period & this function/invoice

	dw_list_summ_rel.Reset()
	dw_list_summ_rel.SetTransObject(stars2ca)
	dw_list_summ_rel.Retrieve(ls_copy_function, ls_copy_invoice)
	dw_copy_summ_rel.Reset()
	dw_copy_summ_rel.SetTransObject(stars2ca)
	dw_model.SetTransObject(stars2ca)

	if dw_list_summ_rel.Rowcount() = 0 then Continue

	// copy sum_rel rows and update period for each row

	dw_list_summ_rel.RowsCopy(1, dw_list_summ_rel.RowCount(), Primary!, dw_copy_summ_rel, 1, Primary!)
  
	For ll_next_row = 1 to dw_copy_summ_rel.RowCount()
	
		dw_copy_summ_rel.SetItem(ll_next_row, 'period', ll_copy_period)
		dw_copy_summ_rel.SetItemStatus(ll_next_row, 0, Primary!, NewModified!)

	Next

	if dw_copy_summ_rel.EVENT ue_update(TRUE, FALSE) = -1 then
		Rollback using stars2ca;
		MessageBox('Error', 'Error copying sum_rel rows.  Next year process canceled.')
		Return -1
	end if

Next

//**************************************//
// Loop through each row in period_cntl //
//**************************************//

ll_row_count  = dw_period_cntl_list.RowCount()

ll_period_key = wf_get_new_key() 

if ll_period_key = -1 then Return -1

FOR ll_row = 1 to ll_row_count

	dw_period_cntl_list.SetRow(ll_row)
   ls_model = dw_period_cntl_list.GetItemString(ll_row, 'model')

   //***************************************//
   // if this row is part of the model      //
   // get info and process it for new model //
   //***************************************//

   if ls_model = ls_current_model then

      ls_status                  = 'FU' 
   	ls_period_desc             = wf_create_desc(ll_row, ls_current_model)
      ls_invoice_type            = dw_period_cntl_list.GetItemString(ll_row, 'invoice_type')
      ls_function                = dw_period_cntl_list.GetItemString(ll_row, 'FUNCTION_NAME')
		ls_base_type               = dw_period_cntl_list.GetItemString(ll_row, 'base_type')
      ls_use_bill_alwd           = dw_period_cntl_list.GetItemString(ll_row, 'use_bill_alwd')
	   ll_period                  = dw_period_cntl_list.GetItemNumber(ll_row, 'period') + 1000
		ld_from_date               = wf_create_date('from_date',ll_row)
		ld_thru_date               = wf_create_date('thru_date',ll_row)
		ld_payment_from_date       = wf_create_date('payment_from_date',ll_row)
		ld_payment_thru_date       = wf_create_date('payment_thru_date',ll_row)
		ld_effective_begin_date    = dw_period_cntl_list.GetItemDatetime(ll_row,'effective_begin_date')
		ld_effective_end_date      = dw_period_cntl_list.GetItemDatetime(ll_row, 'effective_end_date')
		ld_function_run_date       = wf_create_date('function_run_date',ll_row)
		ls_catg_proc = dw_period_cntl_list.GetItemString(ll_row,'use_catgproc')
		ld_percent = dw_period_cntl_list.GetItemDecimal(ll_row,'cutoff_percent_float')
		//NLG patient profiles begin
		ls_use_pay_ind 				= dw_period_cntl_list.GetItemString(ll_row,'use_pay_ind')
		li_pat_rank_col_num			= dw_period_cntl_list.GetItemNumber(ll_row,'pat_rank_col_num')
		//NLG patient profiles end
		ls_crit_ind = String(li_crit_ind)		
		
		ll_new_row = dw_model.InsertRow(0)

		if ll_new_row > 1 then
			ll_period_key = ll_period_key + 1
		end if
		
		//	01/15/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
		IF IsNull( ls_use_bill_alwd )	OR Trim( ls_use_bill_alwd )	= "" THEN ls_use_bill_alwd	= ls_empty
		IF IsNull( ls_catg_proc )		OR Trim( ls_catg_proc )			= "" THEN ls_catg_proc		= ls_empty
		IF IsNull( ls_use_pay_ind )	OR Trim( ls_use_pay_ind )		= "" THEN ls_use_pay_ind	= ls_empty
		//	01/15/01	GaryR	Stars 4.7 DataBase Port - END

      dw_model.SetItem(ll_new_row, 'period_key', ll_period_key)
     	dw_model.SetItem(ll_new_row, 'period', ll_period)
		dw_model.SetItem(ll_new_row, 'model', ls_new_model)
      dw_model.SetItem(ll_new_row, 'period_desc', ls_period_desc)
		dw_model.SetItem(ll_new_row, 'invoice_type', ls_invoice_type)
		dw_model.SetItem(ll_new_row, 'base_type', ls_base_type)
      dw_model.SetItem(ll_new_row, 'FUNCTION_NAME', ls_function)
		dw_model.SetItem(ll_new_row, 'use_bill_alwd', ls_use_bill_alwd)	
		dw_model.SetItem(ll_new_row, 'function_status', ls_status)
   	dw_model.SetItem(ll_new_row, 'from_date', ld_from_date)
   	dw_model.SetItem(ll_new_row, 'thru_date', ld_thru_date)
   	dw_model.SetItem(ll_new_row, 'payment_from_date', ld_payment_from_date)
   	dw_model.SetItem(ll_new_row, 'payment_thru_date', ld_payment_thru_date)
   	dw_model.SetItem(ll_new_row, 'effective_begin_date', ld_effective_begin_date)
   	dw_model.SetItem(ll_new_row, 'effective_end_date', ld_effective_end_date)
   	dw_model.SetItem(ll_new_row, 'function_run_date', ld_function_run_date)
		//NLG patient profiles            begin***
		dw_model.SetItem(ll_new_row, 'pat_rank_col_num', li_pat_rank_col_num)
   	dw_model.SetItem(ll_new_row, 'use_pay_ind', ls_use_pay_ind)
		//NLG patient profiles             end****

		dw_model.SetItem(ll_new_row,'use_catgproc',ls_catg_proc)
		dw_model.SetItem(ll_new_row,'cutoff_percent_float',ld_percent)
		dw_model.SetItem(ll_new_row,'crit_ind',ls_crit_ind)		
		dw_model.SetItem(ll_new_row,'run_by_options',li_run_by_opt)		
		
		dw_model.SetItemStatus(ll_new_row, 0, Primary!, NewModified!)
   end if

NEXT

If dw_model.EVENT ue_update( TRUE, FALSE ) = 1 then
	dw_copy_summ_rel.ResetUpdate()
	dw_model.ResetUpdate()
	Commit using stars2ca;
	MessageBox('Model', 'A new model has been created for ' + ls_new_model, Information!)
else
	Rollback using stars2ca;
	MessageBox('Model', 'Error creating new model')
	Return -1
end if

SetPointer(Hourglass!)

//*******************************//
// Delete inactives from sum_rel //
//*******************************//

// FDG 03/28/01 - Make this SQL Delete DBMS independent
Delete from sum_rel
Where		period in (
			Select	p.period
			From		period_cntl p,
						sum_rel s
			Where		p.period			=	s.period
			And		p.FUNCTION_NAME		=	s.FUNCTION_NAME
			And		p.invoice_type	=	s.inv_type
			And		p.function_status	=	'IN' )
Using		Stars2ca;

// FDG 03/28/01 end

if stars2ca.of_check_status() = -1 then
	Rollback using stars2ca;
	MessageBox('Model', 'Error deleting inactive periods from sum_rel')
	Return -1
else
	Commit using stars2ca;
end if

//***********************************//
// Delete inactives from period_cntl //
//***********************************//

DELETE from period_cntl
WHERE  function_status = 'IN'
USING  stars2ca;

if stars2ca.of_check_status() = -1 then
	Rollback using stars2ca;
	MessageBox('Model', 'Error deleting inactive periods from period_cntl')
	Return -1
else
	Commit using stars2ca;
end if

//*********************************************************//
// list must be reretrieved for additional updates to work //
//*********************************************************//

dw_period_cntl_list.Event	ue_retrieve()

//************************************//
// prompt to update description field //
//************************************//

MessageBox('Reminder', 'An attempt was made to update the description field of each new row created.  Please verify that these descriptions are valid.', Information!)

Return 1

end function

public function integer wf_catg_proc (long arg_period, string arg_invoice);////////////////////////////////////////////////////////////////////////////////////
//
// 07/11/00	GaryR	TS2262SD Windows Standard File Browser.
//	09/10/02	GaryR	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//
////////////////////////////////////////////////////////////////////////////////////

string  ls_file, ls_filename
string  ls_end, ls_record
string  ls_tilde, ls_period
string  ls_categ_id, ls_categ_proc
integer li_row, li_file_number
long    ll_catg_proc_count, ll_period

ll_period = arg_period

dw_catg_proc.Reset()

//	09/10/02	GaryR	Track 3468d - Begin
//dw_catg_proc.SetTransObject(stars1ca)
//dw_catg_proc.Modify("Datawindow.Table.Select = '" + is_dw_categ_proc_orig + "'")
dw_catg_proc.SetTransObject( Stars2ca )
//	09/10/02	GaryR	Track 3468d - End

wf_set_table_name(dw_catg_proc, arg_invoice)
dw_catg_proc.Retrieve(ll_period)
//john_wo 8/97 rel 3.6 spec 161 - modified the following messagebox
if dw_catg_proc.RowCount() = 0 then 
//	MessageBox('Produce File', 'Category/Procedure rows need to be created for period ' + string(ll_period) + '.', Information!)
	MessageBox('Produce File', &
		'Category/Procedure rows need to be created for period ' + string(ll_period) + '. '&
		+ ' Please note that ratio drill-down will come from the claims and ' &
		+ 'Ratios will be produced on individual categories.', Information!)
	Return 1
elseif dw_catg_proc.RowCount() < 0 then
	Return -1
end if

//*********************************************//
// error check the category procedure filename //
//*********************************************//

//Gary-R 7/11/2000 Begin

//ls_file = arg_invoice + string(arg_period) + '.txt' + 'Y'
//openwithparm(w_output_filename,ls_file)
//if Message.StringParm = 'NO' then Return -1
//ls_filename = Message.StringParm

ls_filename = arg_invoice + string(arg_period) + '.txt'

IF IsNull( ls_filename ) THEN
	MessageBox( "Produce File", "The file name is null", StopSign! )
	RETURN -1
END IF

IF GetFileSaveName( "Produce File", ls_filename, ls_file, "*.TXT", "Text Files, *.TXT, All Files, *.*" ) <> 1 THEN RETURN -1

IF FileExists( ls_filename ) THEN
   IF MessageBox( "Produce File", "File " + ls_filename + " already exists.~n~rWould you like to overwrite the existing file?", Question!, YesNo!, 2 ) = 2 THEN RETURN -1
END IF

//Gary-R 7/11/2000 End

//*****************************************//
// open the category procedure output file //
//*****************************************//

li_file_number = FileOpen(ls_filename, linemode!, write!, lockwrite!, replace!)

if li_file_number = -1 then
	MessageBox ('FILE OPEN ERROR','Category Procedure output file could not be opened',StopSign! )
	return -1
end if

//*******************//
// write out records //
//*******************//

SetPointer(Hourglass!)

ls_end   = '}'
ls_tilde = '~~'

FOR li_row = 1 TO dw_catg_proc.RowCount()

	ls_categ_id     = dw_catg_proc.GetItemString(li_row, 'catg_id')
	ls_categ_proc   = dw_catg_proc.GetItemString(li_row, 'catg_proc')
	ls_period       = Left(string(dw_catg_proc.GetItemNumber(li_row, 'period')) + '      ',6)
	
	ls_record       =   ls_period + &
                       ls_tilde + &
						     wf_padstring(ls_categ_id,2) + &
                       ls_tilde + &
            		     wf_padstring(ls_categ_proc,5) + &
                       ls_end

	FileWrite(li_file_number, ls_record)

NEXT

if FileClose(li_file_number) = - 1 then
	MessageBox('Produce Category Procedure File', 'Error creating file ' + ls_filename)
else
	MessageBox('Produce Category Procedure File', 'File ' + ls_filename + ' successfully created')
end if

Return 1
end function

public function integer wf_file ();//////////////////////////////////////////////////////////////////////////////////////
//
// john-wo	8/97		added the use_catgproc logic - spec 161 for rel 3.6
// Archana	4-12-99	Add an edit to check if the client uses catg_proc or not.
// FDG		05/20/99	Read use_bill_alwd from period_cntl so it can be added
//							to the file (in wf_share()).
//	NLG		3/9/00	Patient profiles.
// GaryR		7/11/00	TS2262SD Windows Standard File Browser.
//	GaryR		3/19/00	Stars 4.7 DataBase Port - Case Sensitivity
//	GaryR		10/25/01	Track 2487d	Null dates are 1/1/1900
//	GaryR		09/10/02	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//	GaryR		04/12/04	Track 6645c	Obtain the use_pay_ind value even if not patient profile
//
///////////////////////////////////////////////////////////////////////////////////////

string ls_filename, ls_file, ls_master_record, ls_purge_record
string ls_detail_record, ls_base_type, ls_invoice, ls_function
string ls_from_date, ls_thru_date, ls_model_check
string ls_compare_function, ls_compare_invoice, ls_null
string ls_overwrite_prompt, ls_sharing_function, ls_sql_table
string ls_use_catgproc, ls_descript, ls_table_name, ls_sql
date   ld_payment_from_date, ld_payment_thru_date, ld_max_date
integer li_months, li_file_number, li_purge_count, li_detail_count
integer li_purge_row, li_detail_row, li_future_count, li_row
integer li_file_count, li_mess_ret, li_period_count, li_message_box
long    ll_compare_row, ll_current_data, ll_period, ll_sharing_count
datetime ld_run_date
integer li_return
long ls_compare_period
datetime ldt_date_time
int li_pos,li_pat_rank_col
real lr_pat_cutoff
string ls_pat_use_payment,ls_dec,ls_int
string ls_pat_cutoff

//	GaryR	10/25/01	Track 2487d - Begin
Date		ld_default
String	ls_default
ls_default = String( ld_default, "yyyymmdd" )
//	GaryR	10/25/01	Track 2487d - End

n_ds lds_count
n_ds lds_table_name

SetPointer(Hourglass!)

ldt_date_time = gnv_app.of_get_server_date_time()//ts2020c

if NOT IsDate(sle_run_date.text) then
	MessageBox("Produce File", "Invalid Run Date")
	Return -1
end if

ld_run_date = datetime(date(sle_run_date.text))

ls_overwrite_prompt = 'Y'

//*****************************************//
// if a file has already been created with //
// this run date, prompt to reset status   //
//*****************************************//

SetNull(ls_null)

SELECT count(*)
INTO   :li_file_count
FROM   period_cntl
WHERE  function_status = 'GE' and
       function_run_date = :ld_run_date
USING  stars2ca;

if li_file_count > 0 then
	li_mess_ret = MessageBox('Produce File', 'Period Control rows with a run date of ' + string(date(ld_run_date)) + ' have already been written out to a file.  Reset the status of those records back to future so that they are included in this file?', Question!, YesNo!)
	if li_mess_ret = 1 then
		UPDATE period_cntl
		   SET function_status   = 'FU',
             extract_date      = :ls_null
       WHERE function_status   = 'GE' and
             function_run_date = :ld_run_date
       USING stars2ca;

	ls_overwrite_prompt = 'N'

	end if
end if

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Produce File', 'Error updating status in period_cntl', StopSign!)
	Return -1
else
	Commit using stars2ca;
	if ls_overwrite_prompt = 'N' then
		MessageBox('Produce File', 'All '+ string(date(ld_run_date)) + ' rows have been updated with a status of future.', Information!)
	end if
end if

//the following message box was added by john-wo on 8/97 for spec 161 - rel 3.6
li_return =	MessageBox('Produce File', &
	'Is the Ratio Cutoff Percentage Correct?', Question!,YesNo!)
If li_return = 1 Then
Else
	Return -1
End If

SetPointer(Hourglass!)

//*****************************//
// retrieve hidden datawindows //
//*****************************//

dw_file_detail.Reset()
dw_file_detail.SetTransObject(stars2ca)
dw_file_detail.Retrieve(ld_run_date)

dw_file_purge.Reset()
dw_file_purge.SetTransObject(stars2ca)
dw_file_purge.Retrieve()

//*****************************************************************//
// if a detail row exists with no invoice/function match in the    //
// purge records display an error and return without creating file //
//*****************************************************************//

For li_row = 1 to dw_file_detail.RowCount()

	ls_compare_function = dw_file_detail.GetItemString(li_row, 'FUNCTION_NAME')
	ls_compare_invoice  = dw_file_detail.GetItemString(li_row, 'invoice_type')
	ls_compare_period   = dw_file_detail.GetItemNumber(li_row, 'period')
	ls_descript 	     = dw_file_detail.GetItemString(li_row, 'period_desc')
	ls_use_catgproc	  = dw_file_detail.GetItemString(li_row, 'use_catgproc')
	
// 1/2/98 Archana Trk#199
// Get the correct table name.
If ls_compare_function = 'RATIO' then
	lds_table_name = create n_ds
	lds_table_name.DataObject = 'd_table_name'
	lds_table_name.SetTransObject(stars2ca)
	//	GaryR		3/19/00	Stars 4.7 DataBase Port
	ls_sql_table = 'SELECT distinct label from STARS_WIN_PARM WHERE Upper(label) LIKE ~'%CATG_PROC%~'' + &
						' and win_id = ~'W_RATIO_RPT~' and tbl_type = ~'' + Upper( ls_compare_invoice ) + '~''
	lds_table_name.SetSQLSelect(ls_sql_table)
	
	if lds_table_name.Retrieve() > 0 THEN
		ls_table_name = lds_table_name.Object.label[1]
	end if
	Destroy lds_table_name
	
	if stars2ca.of_check_status() <> 0 then
		Rollback using stars2ca;
		MessageBox('Error', 'Error selecting table name from STARS_WIN_PARM.', StopSign!)
		Return -1
	else 
		Commit using stars2ca;
	End if
// Check for Making sure that a Cat/Proc file has been set up for RATIOs.

	lds_count = create n_ds
	lds_count.DataObject = 'd_count'
	//lds_count.SetTransObject(stars1ca)
	lds_count.SetTransObject( Stars2ca )		//	GaryR	09/10/02	Track 3468d
//	ls_sql = lds_count.GetSQLSelect()
	ls_sql = 'SELECT count(*) from ' + ls_table_name + &
				' WHERE period = ' + string(ls_compare_period)
	lds_count.SetSQLSelect(ls_sql)
	if lds_count.Retrieve() > 0 then
	
	li_period_count = lds_count.Object.count[1]
	end if
	Destroy lds_count
	
	
	if stars1ca.sqlcode <> 0 then
		Rollback using stars1ca;
		MessageBox('Error', 'Error selecting period from catg_proc.', StopSign!)
		Return -1
	else 
		Commit using stars1ca;
	End if
	//Archana 4-12-99
	If ls_use_catgproc = 'Y' or ls_use_catgproc = 'y' then
		if li_period_count = 0 Then
			MessageBox('Edit', 'Category Procedure file for ' +string(ls_compare_period) + ' period has not yet been set up. ' + &
						  'Period control file can not be produced until either a Category Procedure file has been set up ' + &
						  'or the Use Category Procedure indicator in Period Control has been set to "N".', &
						  Information!)
			Return -1
		end if
	
		MessageBox('Information','Please make sure you have produced a Category Procedure File for ' + &
				      'Invoice Type = ' + ls_compare_invoice + ' and Period = ' + ls_descript +'.', &
						Information!)
	End if
End if
	SELECT count(*)
     INTO :ll_compare_row
     FROM purge_cntl
    WHERE FUNCTION_NAME = Upper( :ls_compare_function ) and
          invoice_type = Upper( :ls_compare_invoice )
    USING stars2ca;

	if stars2ca.of_check_status() <> 0 then
		Rollback using stars2ca;
		MessageBox('Error', 'Error selecting purge rows.', StopSign!)
		Return -1
	else
		Commit using stars2ca;
	end if

	if ll_compare_row = 0 then
		MessageBox("Contact the System Administrator", "Error creating file.  A purge row does not exist for function type " + ls_compare_function + ' and invoice type ' + ls_compare_invoice, StopSign!)
		Return -1
	end if

Next

//*****************************************//
// error check the period control filename //
//*****************************************//

ls_file = 'PC' + right('00' + string(month(date(ld_run_date))),2) + right('00' + string(day(date(ld_run_date))),2) + right(string(year(date(ld_run_date))),2) + '.txt'

//Gary-R 7/11/2000 Begin

//openwithparm(w_output_filename, ls_file)
//if Message.StringParm = 'NO' then Return -1
//ls_filename = Message.StringParm

ls_filename = ProfileString( gv_ini_path + "STARS.INI", "RandomSampling", "SelectFilePath", "" ) + ls_file

IF IsNull( ls_filename ) THEN
	MessageBox( "Produce File", "The file name is null", StopSign! )
	RETURN -1
END IF

IF GetFileSaveName( "Produce File", ls_filename, ls_file, "*.TXT", "Text Files, *.TXT, All Files, *.*" ) <> 1 THEN RETURN -1

IF ls_overwrite_prompt = "Y" THEN
	IF FileExists( ls_filename ) THEN
	   IF MessageBox( "Produce File", "File " + ls_filename + " already exists.~n~rWould you like to overwrite the existing file?", Question!, YesNo!, 2 ) = 2 THEN RETURN -1
	END IF
END IF

//Gary-R 7/11/2000 End

SetPointer(Hourglass!)

//*************************************//
// open the period control output file //
//*************************************//

li_file_number = FileOpen( ls_filename, linemode!, write!, lockwrite!, replace! )

if li_file_number = -1 then
	MessageBox ('FILE OPEN ERROR','Period Control output file could not be opened',StopSign! )
	return -1
end if

//*************************//
// write out master record //
//*************************//

ls_master_record =  'M' + &
                    string(date(ld_run_date),"yyyymm")  + &
                    space(73)

FileWrite(li_file_number, ls_master_record)

//*************************//
// write out purge records //
//*************************//

li_purge_count = dw_file_purge.RowCount()

if li_purge_count > 0 then

	dw_file_purge.SetRow(1)

	FOR li_purge_row = 1 TO li_purge_count

		ls_base_type = dw_file_purge.GetItemString(li_purge_row, 'base_type')
		ls_invoice   = dw_file_purge.GetItemString(li_purge_row, 'invoice_type')
		li_months    = dw_file_purge.GetItemNumber(li_purge_row, 'maximum_months')
	
		ls_purge_record =   'P' + &
							     wf_padstring(ls_base_type,4) + &
         	   		     wf_padstring(ls_invoice,2) + &
 							     wf_padinteger(li_months,3) + &
               	        space(70)

		FileWrite(li_file_number, ls_purge_record)

	NEXT

end if

//**************************//
// write out detail records //
//**************************//

li_detail_count = dw_file_detail.RowCount()

if li_detail_count > 0 then

	dw_file_detail.SetRow(1)

	FOR li_detail_row = 1 TO li_detail_count
		
		ls_base_type = dw_file_detail.GetItemString(li_detail_row, 'base_type')
		ls_invoice   = dw_file_detail.GetItemString(li_detail_row, 'invoice_type')
   	ls_function  = dw_file_detail.GetItemString(li_detail_row, 'FUNCTION_NAME')
		ll_period    = dw_file_detail.GetItemNumber(li_detail_row, 'period')
		ls_from_date = string(date(dw_file_detail.GetItemDateTime(li_detail_row, 'from_date')), "yyyymmdd")
		ls_thru_date = string(date(dw_file_detail.GetItemDateTime(li_detail_row, 'thru_date')), "yyyymmdd")
		ld_payment_from_date = date(dw_file_detail.GetItemDateTime(li_detail_row, 'payment_from_date'))
		ld_payment_thru_date = date(dw_file_detail.GetItemDateTime(li_detail_row, 'payment_thru_date'))
		ls_use_catgproc = dw_file_detail.GetItemString(li_detail_row, 'use_catgproc')
		is_use_bill_alwd = dw_file_detail.GetItemString(li_detail_row, 'use_bill_alwd')		// FDG 05/20/99
		ls_pat_use_payment = dw_file_detail.GetItemString(li_detail_row,'use_pay_ind')
		
		//NLG patient profiles 																					***START***
		ib_pat_profile = this.event ue_check_if_pat_profile(ls_invoice,ll_period,ls_function)
		if ib_pat_profile then
	   	li_pat_rank_col = dw_file_detail.GetItemNumber(li_detail_row,'pat_rank_col_num')
			lr_pat_cutoff = dw_file_detail.GetItemNumber(li_detail_row,'cutoff_percent_float')
			ls_pat_cutoff = string(round(lr_pat_cutoff,2))
			//edit patient profile cutoff percentage.  For patient profiles, this float will always
			//be between 0.01 and 1.00.
			li_pos = pos(ls_pat_cutoff, '.')
			ls_dec = mid(ls_pat_cutoff,pos(ls_pat_cutoff,'.')+1)
			ls_int = left(ls_pat_cutoff,li_pos - 1)
			ls_pat_cutoff = ls_int + ls_dec
		end if
		//nlg patient profiles 																						***STOP****
		
		
		//*********************************************//
      // If this row is sharing data with a sum row  //
      // don't write this record. The mainframe only //
      // wants the sum row.                          //
      //*********************************************//

		if ls_function <> 'SUM' then
			SELECT count(*)
          INTO  :ll_sharing_count
			 FROM  period_cntl
      	WHERE  function_run_date = :ld_run_date and
         	    function_status   = 'FU'         and
                invoice_type      = Upper( :ls_invoice )  and
                period            = :ll_period    and
                FUNCTION_NAME         <> Upper( :ls_function )
         USING  stars2ca;

			if stars2ca.of_check_status() <> 0 then
				Rollback using stars2ca;
            MessageBox('Error', 'Error checking for shared data.', StopSign!)
				Return -1
			else
				Commit using stars2ca;
			end if

			if ll_sharing_count > 0 then 

				ls_sharing_function = ls_sharing_function + wf_padstring(ls_function,6)

				//****************************************************//
      		// update status to Generate and skip remaining steps //
      		//****************************************************//

				dw_file_detail.SetItem(li_detail_row, 'function_status', 'GE')
				dw_file_detail.SetItemStatus(li_detail_row, 0, Primary!, DataModified!)

				Continue

			end if
		end if

//JOHN-WO 8/97 FOR REL 3.6 SPEC 161 - GIVE THE USERS A WARNING IF THEY AREN'T USING CATG_PROC
      If ls_function = 'Ratio' and ls_use_catgproc = 'N' Then
			li_return = MessageBox('Question', &
				'Do you wish to create a category procedure file for period = ' &
				+ String(ll_period) &
				+ ', invoice type = ' + ls_invoice + ' and function = ' + ls_function + '?' &
				+ '  If you click NO, you will produce a ratio on each individual Procedure Code.', &
				Question!,YesNo!)
			If li_return = 2 Then
			Else 
				UPDATE PERIOD_CNTL  
     			SET USE_CATGPROC = 'Y'  
   			WHERE ( PERIOD_CNTL.PERIOD = :ll_period ) AND  
         	( PERIOD_CNTL.INVOICE_TYPE = Upper( :ls_invoice ) ) AND  
         	( PERIOD_CNTL.FUNCTION_NAME = Upper( :ls_function ) )
	         USING  stars2ca;

				if stars2ca.of_check_status() <> 0 then
					Rollback using stars2ca;
            	MessageBox('Error', 'Error updating period control table.', StopSign!)
					Return -1
				else
					Commit using stars2ca;
					ls_use_catgproc = 'Y'
				end if
			End If
		End If
		// end jww update 8/97 - except for the 'and' in the following if
		if ls_function = 'RATIO' and ls_use_catgproc = 'Y' then
			wf_catg_proc(ll_period,ls_invoice)
		end if

		//**************//
      // build record //
      //**************//
		
		//	GaryR	10/25/01	Track 2487d - Begin		
//		if (IsNull(ls_from_date)) OR (ls_from_date = "") then
//			ls_from_date = '********'
//		end if
//		if (IsNull(ls_thru_date)) OR (ls_thru_date = "") then
//			ls_thru_date = '********'
//		end if
		IF IsNull( ls_from_date ) OR ls_from_date = "" OR ls_from_date = ls_default THEN	ls_from_date = '********'
		IF IsNull( ls_thru_date ) OR ls_thru_date = "" OR ls_thru_date = ls_default THEN	ls_thru_date = '********'
		//	GaryR	10/25/01	Track 2487d - End

		ls_detail_record = 'G' + &
						wf_padstring(ls_base_type,4) + &
         	      wf_padstring(ls_invoice,2) + &
                      '000' + &
            	   wf_padstring(ls_function,6) + &
               	wf_padstring(string(ll_period),6) + &
                  wf_padstring(ls_from_date,8) + &
                  wf_padstring(ls_thru_date,8) + &
                  wf_padstring(string(ld_payment_from_date,"yyyymmdd"),8) + &
	               wf_padstring(string(ld_payment_thru_date,"yyyymmdd"),8) + &
						wf_share(ls_function,ls_sharing_function,ls_use_catgproc) + &
						wf_padstring(ls_pat_use_payment,1)
						
						
		//NLG 3-3-00 Append patient profile info		START****
		if ib_pat_profile then
			ls_detail_record = ls_detail_record + &
						wf_padinteger(li_pat_rank_col,2) +&
						wf_padstring(ls_pat_cutoff,3)
		end if	//NLG 3-3-00 									STOP***

		//**************//
      // Write record //
      //**************//

		FileWrite(li_file_number, ls_detail_record)

		//***************************//
      // update status to Generate //
      //***************************//
   
		dw_file_detail.SetItem(li_detail_row, 'function_status', 'GE')
		//dw_file_detail.SetItem(li_detail_row, 'extract_date', datetime(today()))
		dw_file_detail.SetItem(li_detail_row, 'extract_date', ldt_date_time)
		dw_file_detail.SetItemStatus(li_detail_row, 0, Primary!, DataModified!)

		if ls_function = 'SUM' then
			ls_sharing_function = ''
		end if

	NEXT

end if

if FileClose(li_file_number) = - 1 then
	MessageBox('Produce File', 'Error creating period control file ' + ls_filename)
else
	MessageBox('Produce Period Control File', 'File ' + ls_filename + ' successfully created')
end if

//*****************************************//
// update detail rows with generate status //
//*****************************************//

dw_file_detail.EVENT ue_update( TRUE, TRUE )

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Period Control', 'Error updating period_cntl table')
	Return -1
else
	Commit using stars2ca;
end if

dw_period_cntl_list.Event	ue_retrieve()

//**********************************//
// if there are no future rows left //
// create the next model year       //
//**********************************//

	SELECT count(*)
	INTO   :li_future_count
	FROM   period_cntl
	WHERE  function_status = 'FU'
	USING  stars2ca;

	if stars2ca.of_check_status() <> 0 then
		Rollback using stars2ca;
		MessageBox('Produce File', 'Error selecting from period_cntl')
		Return -1
	else
		Commit using stars2ca;
	end if

	if li_future_count = 0 then
		cb_next_year.TriggerEvent(Clicked!)
	end if

Return 1
end function

event open;call super::open;////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	03/19/01	Stars 4.7.	Remove ros_directory and get the data from
//						claims_range_cntl instead.  Also, make the retrieval
//						DBMS independent.
//	GaryR	05/29/01	Stars 4.7	Rename table CLAIMS_RANGE_CNTL to CLAIMS_CNTL
//	GaryR	06/07/01	Stars 4.7	Move CLAIMS_CNTL from Stars2 to Stars1
//	GaryR	09/10/02	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//
////////////////////////////////////////////////////////////////////////

long		ll_current_data

Integer	li_month,				&
			li_year

string	ls_run_date,			&
			ls_month,				&
			ls_year

Datetime	ldtm_to_date

SetPointer(Hourglass!)

//	FDG 07/31/97 - Disable closequery processing
ib_disableclosequery	=	TRUE

//	GaryR	09/10/02	Track 3468d
//is_dw_categ_proc_orig = dw_catg_proc.Describe("Datawindow.Table.Select")

of_settransaction (Stars2ca)		// Register the transaction

This.of_SetUpdateDW(dw_period_cntl_list) // jw 08/97 for rel 3.6 

dw_period_cntl_list.Reset()
dw_period_cntl_list.SetTransObject(stars2ca)
dw_period_cntl_list.Event	ue_retrieve()

sle_count.text = string(dw_period_cntl_list.RowCount())

This.Event ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
ddlb_dw_ops.AddItem("")

//*********************************************************//
// add 1 to max loaded date to display the run date 		  //
//*********************************************************//

// FDG 03/19/01 begin
//SELECT distinct(max(yymm))
//INTO   :ll_current_data
//FROM   ros_directory
//WHERE  tbl_type = 'MC' and tbl_no = 1
//USING  stars1ca;
//
//if stars1ca.of_check_status() <> 0 then
//	Rollback using stars1ca;
//	MessageBox('Period Control', 'Error selecting from ros_directory')
//	Return
//else
//	Commit using stars1ca;
//end if

//	GaryR	05/29/01	Stars 4.7 - Begin
SELECT	Distinct (max(to_date))
INTO		:ldtm_to_date
FROM		claims_cntl
USING		Stars1ca ;	//	GaryR	06/07/01	Stars 4.7

//	GaryR	06/07/01	Stars 4.7 - Begin
IF	Stars1ca.of_check_status()	<	0		THEN
	Stars1ca.of_rollback()
	MessageBox('Period Control', 'Error selecting from claims_cntl.')
	Return
ELSE
	Stars1ca.of_commit()
END IF
//	GaryR	06/07/01	Stars 4.7 - End
//	GaryR	05/29/01	Stars 4.7 - End

li_month	=	Month ( Date(ldtm_to_date) )
li_year	=	Year ( Date(ldtm_to_date) )
ll_current_data	=	(li_year * 100)	+	li_month
// FDG 03/19/01 end

if Right(string(ll_current_data), 2) = '12' then
	ls_run_date = '02/01/' + string(integer(Left(string(ll_current_data), 4)) + 1)
elseif Right(string(ll_current_data), 2) = '11' then
	ls_run_date = '01/01/' + string(integer(Left(string(ll_current_data), 4)) + 1)
else
	ls_run_date = Right(string(ll_current_data + 2), 2) + '/01/' + Left(string(ll_current_data), 4)
end if

sle_run_date.text = ls_run_date
end event

event closequery;// Override the ancestor
end event

on w_period_cntl_list.create
int iCurrent
call super::create
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_1=create st_1
this.cb_list=create cb_list
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_next_year=create cb_next_year
this.cb_close=create cb_close
this.cb_file=create cb_file
this.cb_select=create cb_select
this.dw_model=create dw_model
this.dw_file_detail=create dw_file_detail
this.dw_file_purge=create dw_file_purge
this.sle_count=create sle_count
this.st_2=create st_2
this.dw_list_summ_rel=create dw_list_summ_rel
this.dw_copy_summ_rel=create dw_copy_summ_rel
this.dw_dates=create dw_dates
this.dw_period_cntl_list=create dw_period_cntl_list
this.dw_invoice_desc=create dw_invoice_desc
this.dw_catg_proc=create dw_catg_proc
this.sle_run_date=create sle_run_date
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_dw_ops
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_list
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_next_year
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_file
this.Control[iCurrent+9]=this.cb_select
this.Control[iCurrent+10]=this.dw_model
this.Control[iCurrent+11]=this.dw_file_detail
this.Control[iCurrent+12]=this.dw_file_purge
this.Control[iCurrent+13]=this.sle_count
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.dw_list_summ_rel
this.Control[iCurrent+16]=this.dw_copy_summ_rel
this.Control[iCurrent+17]=this.dw_dates
this.Control[iCurrent+18]=this.dw_period_cntl_list
this.Control[iCurrent+19]=this.dw_invoice_desc
this.Control[iCurrent+20]=this.dw_catg_proc
this.Control[iCurrent+21]=this.sle_run_date
end on

on w_period_cntl_list.destroy
call super::destroy
destroy(this.ddlb_dw_ops)
destroy(this.st_1)
destroy(this.cb_list)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_next_year)
destroy(this.cb_close)
destroy(this.cb_file)
destroy(this.cb_select)
destroy(this.dw_model)
destroy(this.dw_file_detail)
destroy(this.dw_file_purge)
destroy(this.sle_count)
destroy(this.st_2)
destroy(this.dw_list_summ_rel)
destroy(this.dw_copy_summ_rel)
destroy(this.dw_dates)
destroy(this.dw_period_cntl_list)
destroy(this.dw_invoice_desc)
destroy(this.dw_catg_proc)
destroy(this.sle_run_date)
end on

type ddlb_dw_ops from dropdownlistbox within w_period_cntl_list
string accessiblename = "Windows Operations"
string accessibledescription = "Windows Operations"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 23
integer y = 1220
integer width = 750
integer height = 300
integer taborder = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;//Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.
string ls_control_text

SetPointer(Hourglass!)

ls_control_text = ddlb_dw_ops.text 
if ls_control_text = "" then
	SetNull(is_dw_control)
	SetNull(is_selected)
	dw_period_cntl_list.Setfilter('')
	dw_period_cntl_list.Filter()
	dw_period_cntl_list.Event	ue_retrieve()
else
	is_selected = '1'
	is_dw_control = fx_uo_control(iw_uo_win,dw_period_cntl_list,ls_control_text,is_dw_control,sle_count, iv_decode_struct)
end if
end on

type st_1 from statictext within w_period_cntl_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1140
integer width = 608
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_list from u_cb within w_period_cntl_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 425
integer y = 1388
integer width = 201
integer height = 108
integer taborder = 50
string text = "&List"
boolean default = true
end type

on clicked;SetPointer(Hourglass!)

dw_period_cntl_list.Event	ue_retrieve()
end on

type cb_delete from u_cb within w_period_cntl_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1134
integer y = 1388
integer width = 247
integer height = 108
integer taborder = 100
string text = "&Delete"
end type

on clicked;if wf_delete() = -1 then Return


end on

type cb_add from u_cb within w_period_cntl_list
string accessiblename = "Add"
string accessibledescription = "Add"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 928
integer y = 1388
integer width = 178
integer height = 108
integer taborder = 80
string text = "&Add"
end type

event clicked;//john-wo 173 rel 3.6 8/97 - 
Long ll_period_key

SetPointer(Hourglass!)

  SELECT Max(PERIOD_CNTL.PERIOD_KEY)  
    INTO :ll_Period_key  
    FROM PERIOD_CNTL
   WHERE PERIOD_CNTL.PERIOD_KEY >= 0
   USING stars2ca;

If stars2ca.of_check_status() <> 0 then
	MessageBox('Add Period', 'Error selecting from period_cntl', StopSign!)
	Return
End If

If IsNull(ll_period_key) or ll_period_key = 0 Then
	il_period_key = 1
Else
	il_period_key = ll_period_key + 1
End If


//SetNull(il_period_key)

wf_select()

end event

type cb_next_year from u_cb within w_period_cntl_list
string accessiblename = "Add Next Model"
string accessibledescription = "Add Next Model"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1408
integer y = 1388
integer width = 498
integer height = 108
integer taborder = 120
string text = "Add &Next Model"
end type

on clicked;if wf_model() = -1 then Return
end on

type cb_close from u_cb within w_period_cntl_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2391
integer y = 1388
integer width = 247
integer height = 108
integer taborder = 160
string text = "&Close"
end type

on clicked;Close (Parent)
end on

type cb_file from u_cb within w_period_cntl_list
string accessiblename = "Produce File"
string accessibledescription = "Produce File"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1934
integer y = 1388
integer width = 430
integer height = 108
integer taborder = 140
string text = "&Produce File"
end type

on clicked;if wf_file() = -1 then Return
end on

type cb_select from u_cb within w_period_cntl_list
string accessiblename = "Select"
string accessibledescription = "Select"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 654
integer y = 1388
integer width = 247
integer height = 108
integer taborder = 60
string text = "&Select"
end type

event clicked;wf_select()

end event

type dw_model from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1888
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 170
string dataobject = "d_model"
end type

type dw_file_detail from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1198
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 30
string dataobject = "d_create_file"
end type

type dw_file_purge from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1335
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 10
string dataobject = "d_purge_cntl"
end type

type sle_count from singlelineedit within w_period_cntl_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 23
integer y = 1388
integer width = 293
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_period_cntl_list
string accessiblename = "Run Date"
string accessibledescription = "Run Date"
accessiblerole accessiblerole = statictextrole!
integer x = 2290
integer y = 1140
integer width = 302
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Run Date:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_list_summ_rel from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1609
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 110
string dataobject = "d_copy_summ_rel"
end type

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in the data.
This.of_SetTrim (TRUE)

end event

type dw_copy_summ_rel from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1472
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 130
string dataobject = "d_copy_summ_rel"
end type

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in the data.
This.of_SetTrim (TRUE)

end event

type dw_dates from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1746
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 150
string dataobject = "d_model_dates"
end type

type dw_period_cntl_list from u_dw within w_period_cntl_list
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
event type integer ue_get_pat_rank_col_name ( )
integer x = 32
integer y = 32
integer width = 2665
integer height = 1092
integer taborder = 20
string dataobject = "d_period_cntl_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event type integer ue_get_pat_rank_col_name();//*********************************************************************************
// Script Name:	dw_period_cntl.ue_get_pat_rank_col_name
//
//	Arguments:		N/A
//
// Returns:			integer
//
//	Description:	After the list dw has been retrieved, this script is called
//						to replace the pat_rank_col_num with the corresponding
//						dictionary.elem_desc. 
//
//*********************************************************************************
//	
// 03/22/00 NLG	Patient profiles.	Created.
// 11/22/00	GaryR	Stars 4.7 DataBase Port - Conversion of data types
//
//*********************************************************************************

int 					li_rc,	&
						li_pat_rank_col_num
string 				ls_find,	&
						ls_sql,	&
						ls_sort,	&
						ls_filter,&
						ls_inv_type,&
						ls_sum_tbl_type,&
						ls_rank_col_name
string  				ls_tbl_types[]
constant string 	ls_order_by = "ORDER BY"
long 					ll_rows, &
						li_idx,	&
						ll_period_cntl_rowcount,&
						ll_found_row
n_ds 					lds_sumrel, &
						lds_pat_rank_col_name

ls_sql = dw_period_cntl_list.getsqlselect()
IF len(trim(ls_sql)) < 1 THEN
	Messagebox("ERROR","Error getting datawindow sql in dw_period_cntl_list.ue_get_pat_rank_col_name")
	Return -1
END IF
//Save dw sort so that after filtering and unfiltering, can resort properly
ls_sort = mid(ls_sql,pos(ls_sql,ls_order_by) + len(ls_order_by) + 1)

//Filter dw_period_cntl_list to get only summary rows with a value in pat_rank_col_num
dw_period_cntl_list.SetRedraw(FALSE)
ls_filter = "FUNCTION_NAME = 'SUM' AND PAT_RANK_COL_NUM > 0"
dw_period_cntl_list.setFilter(ls_filter)
dw_period_cntl_list.Filter()
ll_period_cntl_rowcount = dw_period_cntl_list.RowCount()

//This datastore gets the invoice type and elem_tbl_type of all patient profile
//summary tables
lds_sumrel = CREATE n_ds
lds_sumrel.dataobject = 'd_sumrel_dict'
li_rc = lds_sumrel.SetTransObject(stars2ca)
IF li_rc < 1 THEN
	Messagebox("ERROR","Error setting transaction object in " +&
							"~rdw_period_cntl_list.ue_get_pat_rank_col_name()")
	IF IsValid(lds_sumrel) THEN destroy lds_sumrel
	return -1
END IF

ll_rows = lds_sumrel.Retrieve()
IF ll_rows < 1 THEN
	Messagebox("ERROR","Error retrieving rows from dictionary,sum_rel in " +&
							"~rdw_period_cntl_list.ue_get_pat_rank_col_name()")
	IF IsValid(lds_sumrel) THEN destroy lds_sumrel
	return -1
END IF

//loop thru the sum_rel/dictionary datastore to build an array of
//patient profile elem_tbl_types to use in retrieval of dictionary datastore
FOR li_idx = 1 TO ll_rows
	ls_tbl_types[li_idx] = lds_sumrel.GetItemString(li_idx,"dictionary_elem_tbl_type")
NEXT

//this datastore retrieves the summary table elem_tbl_type, dictionary value_n
//and elem_desc for the pat_rank_col_num
lds_pat_rank_col_name = CREATE n_ds
lds_pat_rank_col_name.dataobject = 'd_pat_rank_col_name'
li_rc = lds_pat_rank_col_name.SetTransObject(stars2ca)
IF li_rc < 1 THEN
	Messagebox("ERROR","Error setting transaction object in " +&
							"~rdw_period_cntl_list.ue_get_pat_rank_col_name()")
	IF IsValid(lds_pat_rank_col_name) THEN destroy lds_pat_rank_col_name
	return -1
END IF

// 11/22/00	GaryR	Stars 4.7 DataBase Port
gnv_sql.of_get_substring( lds_pat_rank_col_name )

ll_rows = lds_pat_rank_col_name.Retrieve(ls_tbl_types)
IF ll_rows < 1 THEN
	Messagebox("ERROR","Error retrieving rows from dictionary in " +&
							"~rdw_period_cntl_list.ue_get_pat_rank_col_name()")
	IF IsValid(lds_pat_rank_col_name) THEN destroy lds_pat_rank_col_name
	return -1
END IF

//Use the period_cntl invoice type to filter the rows in lds_sumrel
//Use the first row of lds_sumrel to get the patient profile summary table
//elem_tbl_type.  Use the elem_tbl_type to find the relevant row in 
//lds_pat_rank_col_name and use the period_cntl.pat_rank_col_num to
//find lds_pat_rank_col_name.value_n to get the elem_desc of the 
//patient profiles ranking column name.  Use setText so user sees
//column name rather than column number (value_n).
FOR li_idx = 1 TO ll_period_cntl_rowcount
	//Unfilter the datastore
	ls_filter = ""
	lds_sumrel.SetFilter(ls_filter)
	lds_sumrel.Filter()
	ls_inv_type = dw_period_cntl_list.GetItemString(li_idx,'invoice_type')
	ls_filter = "sum_rel_inv_type = '" + ls_inv_type + "'"
	li_rc = lds_sumrel.SetFilter(ls_filter)
	li_rc = lds_sumrel.Filter()
	ll_rows = lds_sumrel.RowCount()//debugging
	IF lds_sumrel.RowCount() > 0 THEN
		ls_sum_tbl_type = lds_sumrel.GetItemString(1,'dictionary_elem_tbl_type')
		//use tbl_type to filter lds_pat_rank_col_name
		ls_filter = ""
		lds_pat_rank_col_name.SetFilter(ls_filter)
		lds_pat_rank_col_name.Filter()
		ls_filter = "elem_tbl_type = '" + ls_sum_tbl_type + "'"
		li_rc = lds_pat_rank_col_name.SetFilter(ls_filter)
		li_rc = lds_pat_rank_col_name.Filter()
		ll_rows = lds_pat_rank_col_name.RowCount()//debugging
		li_pat_rank_col_num = dw_period_cntl_list.GetItemNumber(li_idx,'pat_rank_col_num')
		ll_found_row = lds_pat_rank_col_name.Find(&
			"value_n = " + string(li_pat_rank_col_num),1,lds_pat_rank_col_name.RowCount())
		IF ll_found_row > 0 THEN
			ls_rank_col_name = lds_pat_rank_col_name.GetItemString(ll_found_row,'pat_rank_col_name')
			li_rc = dw_period_cntl_list.SetItem(li_idx,"patient_profiles_rank_col_name",ls_rank_col_name)
			li_rc = dw_period_cntl_list.AcceptText()
		END IF
	END IF
		
NEXT

//Unfilter period_cntl List dw
ls_filter = ''
dw_period_cntl_list.setFilter(ls_filter)
dw_period_cntl_list.Filter()

li_rc = dw_period_cntl_list.SetSort(ls_sort)
li_rc = dw_period_cntl_list.Sort()

IF IsValid(lds_sumrel) THEN destroy lds_sumrel
IF IsValid(lds_pat_rank_col_name) THEN destroy lds_pat_rank_col_name

dw_period_cntl_list.SetRedraw(TRUE)

return 1

end event

event ue_retrieve;//***********************************************************//
// the ancestor script is overridden so that the current     //
// row number can be saved.  Then the ancestor scripts       //
// is called and the window scrolls back to the original row //
//***********************************************************//

Long		ll_row

il_row_selected = dw_period_cntl_list.GetRow()

call super::ue_retrieve

//NLG convert pat_rank_col_num to corresponding column name
int li_rc
li_rc = this.event ue_get_pat_rank_col_name()

ll_row	=	This.RowCount()
sle_count.text = string(This.RowCount())
dw_period_cntl_list.ScrollToRow(il_row_selected)

Return ll_row
end event

on retrievestart;call u_dw::retrievestart;long   ll_row
string ls_code_desc
string ls_code_value
string ls_description
string ls_setvalue

setpointer(hourglass!)

//  Reset "stop" switch at the start of the retrieve.
gv_cancel_but_clicked = FALSE

this.SetTransObject(stars2ca)

// added code to make invoice_type more descriptive ABO 9/6/96

dw_invoice_desc.Reset()
dw_invoice_desc.SetTransObject(stars2ca)
dw_invoice_desc.Retrieve()
dw_period_cntl_list.ClearValues('invoice_type')

For ll_row = 1 to dw_invoice_desc.Rowcount()

	ls_code_desc   = dw_invoice_desc.GetItemString(ll_row,'code_desc')
	ls_code_value  = dw_invoice_desc.GetItemString(ll_row,'code_value_a')
	ls_description = ls_code_value + ' - ' + ls_code_desc
	ls_setvalue    = ls_description+'~t'+ls_code_value

	dw_period_cntl_list.SetValue('invoice_type',ll_row,ls_setvalue)

Next

end on

event doubleclicked;int li_tabpos, li_rc
long li_row_nbr
string ls_col,ls_hold_object

setpointer(hourglass!)

if gv_cancel_but_clicked=TRUE Then

		ls_hold_object = Getobjectatpointer(dw_period_cntl_list)
	
		li_tabpos = pos (ls_hold_object,"~t")
		ls_col = left(ls_hold_object,(li_tabpos - 1))
		
		If right(ls_col,2) = '_t' and UPPER (ls_col) <> 'HEADER_T' Then	
			If is_selected <> '1' Then
				Messagebox('Information','You must select an option from Window Operations')
			Else
				ddlb_dw_ops.triggerevent(selectionchanged!)
			End If
			ddlb_dw_ops.triggerevent(selectionchanged!)
			li_rc = fx_dw_control(dw_period_cntl_list,ls_hold_object,is_dw_control,iw_uo_win,'',0,iv_decode_struct)
		ElseIf is_dw_control = 'FILTER' Then
			ddlb_dw_ops.triggerevent(selectionchanged!)
			li_row_nbr = row
			li_rc = fx_dw_control(dw_period_cntl_list,ls_hold_object,is_dw_control,iw_uo_win,'cell',li_row_nbr,iv_decode_struct)
		ElseIf is_dw_control = 'FIND' Then
			ddlb_dw_ops.triggerevent(selectionchanged!)
			li_row_nbr = row
			li_rc = fx_dw_control(dw_period_cntl_list,ls_hold_object,is_dw_control,iw_uo_win,'cell',li_row_nbr,iv_decode_struct)
		Else
			li_row_nbr = row
			If li_row_nbr = 0 then
				return
			end if
			This.triggerevent(rowfocuschanged!)
			SetPointer(Hourglass!)
			cb_select.Triggerevent(Clicked!)
		end if
end if

end event

event rowfocuschanged;call super::rowfocuschanged;// rowfocuschanged event for dw_period_cntl_list on w_period_cntl_list

int li_row_nbr,li_clicked_row, li_rc

int lv_row
lv_row = GetRow()
If IsNull(currentrow) or currentrow <> lv_row then
	currentrow = lv_row
end if
//==================================================================================


setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if gv_cancel_but_clicked Then

	li_row_nbr = currentrow
	// FDG 01/17/02 - Track 2699d.  If no rows exist, get out
	If li_row_nbr = 0				&
	or	This.RowCount()	<	1	then
   	cb_select.enabled = false
   	cb_select.enabled = false
		return
	else
		cb_select.enabled = true
	end if

	il_period_id  = dw_period_cntl_list.getitemnumber(li_row_nbr,'period')
   il_period_key = dw_period_cntl_list.getitemnumber(li_row_nbr,'period_key')
end if	


end event

event retrieveend;call super::retrieveend;//  Reset "stop" switch at the end of the retrieve.
gv_cancel_but_clicked = TRUE

//triggerevent(dw_period_cntl_list,rowfocuschanged!)
end event

event constructor;call super::constructor;This.of_SingleSelect (TRUE)		//	single select rows

end event

type dw_invoice_desc from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 2021
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 90
string dataobject = "d_invoice_descriptions"
end type

type dw_catg_proc from u_dw within w_period_cntl_list
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 2158
integer y = 1172
integer width = 105
integer height = 188
integer taborder = 70
string dataobject = "d_categ_proc"
end type

type sle_run_date from editmask within w_period_cntl_list
string accessiblename = "Run Date"
string accessibledescription = "Run Date"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 2263
integer y = 1220
integer width = 379
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/01/yyyy"
end type

