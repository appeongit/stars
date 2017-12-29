$PBExportHeader$u_display_period.sru
$PBExportComments$Inherited from u_dw <gui>
forward
global type u_display_period from u_dw
end type
end forward

global type u_display_period from u_dw
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = clientrole!
integer width = 1280
integer height = 120
string dataobject = "d_display_period"
boolean livescroll = false
end type
global u_display_period u_display_period

type variables
long il_period_key
datetime id_from_date
datetime id_thru_date
datetime id_payment_from_date
datetime id_payment_thru_date
long il_period
string is_period_desc
long il_row_count

// For ratio reporting
String	is_use_bill_alwd
end variables

forward prototypes
public subroutine uf_return_dates (ref datetime ad_from_date, ref datetime ad_thru_date, ref datetime ad_payment_from_date, ref datetime ad_payment_thru_date)
public function string uf_return_desc ()
public function long uf_return_key ()
public function long uf_return_period ()
public function datetime uf_return_payment_from ()
public function boolean uf_find_key (long al_find_key)
public function integer uf_scroll_to_row_by_period_key (integer ai_period)
public function boolean uf_get_use_bill ()
public subroutine uf_scroll_to_max_period (datawindowchild adw_child)
public function integer uf_check_for_claim_data ()
public subroutine uf_load_dddw (string as_function, string as_invoice, string as_status, string as_none)
public function integer uf_scroll_to_row (string as_period_desc)
end prototypes

public subroutine uf_return_dates (ref datetime ad_from_date, ref datetime ad_thru_date, ref datetime ad_payment_from_date, ref datetime ad_payment_thru_date);ad_from_date         = id_from_date
ad_thru_date         = id_thru_date
ad_payment_from_date = id_payment_from_date
ad_payment_thru_date = id_payment_thru_date
end subroutine

public function string uf_return_desc ();Return is_period_desc
end function

public function long uf_return_key ();RETURN il_period_key
end function

public function long uf_return_period ();Return il_period
end function

public function datetime uf_return_payment_from ();RETURN id_payment_from_date
end function

public function boolean uf_find_key (long al_find_key);//********************************************//
// if the period key passed is in the child   //
// list return true otherwise return false    //
//********************************************//

datawindowchild ldw_child
string ls_find
long ll_child_row
long ll_row_count

this.GetChild('period_key',ldw_child)
ll_row_count = ldw_child.RowCount()

If ll_row_count > 0 then

   ls_find = "period_key=" + string(al_find_key)
   ll_child_row = ldw_child.Find(ls_find, 1, ll_row_count)

   if ll_child_row > 0 then
		RETURN TRUE
	else
		RETURN FALSE
	end if

else
	RETURN FALSE

end if
end function

public function integer uf_scroll_to_row_by_period_key (integer ai_period);//uf_scroll_to_row will scroll to the row with the period id
//passed to it.
//anne-s 07/30/98 Track #1522 scroll to row by period Id
boolean lb_found
datawindowchild ldw_child
integer li_row
int li_period_key
long ll_row_count
//string ls_period_desc

lb_found = false
//***************************//
// scroll to the desired row //
//***************************//

this.GetChild('period_key',ldw_child)

ll_row_count = ldw_child.RowCount()

if ll_row_count < 1 then Return 1

For li_row = 1 to ll_row_count
	
	li_period_key = ldw_child.GetItemNumber(li_row, 'period_key')
	
	if li_period_key = ai_period then
//   	ll_period_desc = ldw_child.GetItemString(li_row, 'period_desc')
		lb_found = true
		Exit
	end if 
Next

If lb_found Then
Else
	MessageBox('Error','The following period key was not found: ' &
		+ string(ai_period),StopSign!,OK!)
	Return -1
End If

//this.SetRow(li_row, 'period_key', ai_period)
//this.SetRow(li_row)
this.SetItem(1, 'period_key', ai_period)

this.TriggerEvent(ItemChanged!)
Return 1
end function

public function boolean uf_get_use_bill ();///////////////////////////////////////////////////////////////////
//	Track 1804c.  4.0 SP2.  This function returns use_bill_alwd.
//	This column is used in the ratio reports.
//
///////////////////////////////////////////////////////////////////

IF	is_use_bill_alwd	=	'B'		THEN
	Return	TRUE
ELSE
	Return	FALSE
END IF


end function

public subroutine uf_scroll_to_max_period (datawindowchild adw_child);datawindowchild ldw_child
integer li_row
integer li_max_row
long ll_period_key
long ll_insert_row
long ll_row_count
datetime ld_payment_from
datetime ld_max_date

//***************************//
// default to the max period //
//***************************//

this.GetChild('period_key',ldw_child)
ll_row_count = ldw_child.RowCount()

if ll_row_count < 1 then
	Return
end if

For li_row = 1 to ll_row_count
	ld_payment_from = adw_child.GetItemDateTime(li_row, 'payment_from_date')
	if (ld_payment_from > ld_max_date) OR (li_row = 1) then
   	ll_period_key = adw_child.GetItemNumber(li_row, 'period_key')
		ld_max_date = ld_payment_from
		li_max_row = li_row
	end if 
Next

this.SetItem(1, 'period_key', ll_period_key)

this.TriggerEvent(ItemChanged!)

end subroutine

public function integer uf_check_for_claim_data ();//////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	03/06/01	Stars 4.7.  ros_directory is no longer being used.
//
//////////////////////////////////////////////////////////////////////////


datawindowchild ldw_child
datetime ld_payment_from
datetime ld_payment_thru
datetime ld_min_from
datetime ld_max_thru
string ls_desc
string ls_inv_type				// FDG 03/06/01
Boolean	lb_dates_in_range		// FDG 03/06/01
long ll_data_count
long ll_row_count
long ll_rows_deleted
long ll_row

this.getchild('period_key', ldw_child)
il_row_count = ldw_child.RowCount()

if il_row_count < 1 then Return 0

For ll_row = 1 to il_row_count
	
	ld_payment_from = ldw_child.GetItemDatetime(ll_row, 'payment_from_date')
	ld_payment_thru = ldw_child.GetItemDatetime(ll_row, 'payment_thru_date')
	ls_desc         = ldw_child.GetItemString(ll_row, 'period_desc')
	ls_inv_type     = ldw_child.GetItemString(ll_row, 'invoice_type')		// FDG 03/06/01

	if ls_desc = 'NONE' then Continue

	// FDG 03/06/01 - ros_directory is no longer used
	//SELECT min(from_date),
   //       max(to_date)
   //  INTO :ld_min_from,
   //       :ld_max_thru
   //  FROM ros_directory
   // WHERE tbl_type = 'MC'
   // USING stars1ca;
	
	//if stars1ca.of_check_status() <> 0 then
	//	Rollback using stars1ca;
	//	MessageBox('Error', 'Error checking for claims data')
	//	Return -1
	//else
	//	Commit using stars1ca;
	//	Stars1ca.of_check_status()
	//end if
	
	lb_dates_in_range	=	gnv_server.of_AreDatesInRange (ls_inv_type,		&
																		ld_payment_from,	&
																		ld_payment_thru)

   //if ld_payment_from < ld_min_from or ld_payment_thru > ld_max_thru then
	IF	lb_dates_in_range	=	FALSE		THEN
		ldw_child.DeleteRow(ll_row)
		il_row_count = ldw_child.RowCount()
		ll_row = ll_row -1
		//JGG - 8/15/97: keep count of rows deleted
		ll_rows_deleted++
	end if
	// FDG 03/06/01 end

Next

il_row_count = ldw_child.RowCount()

//JGG - 8/15/97: Scroll to new max period only if a row has been deleted.

IF ll_rows_deleted > 0 THEN
   uf_scroll_to_max_period(ldw_child)
END IF

//JGG - 8/15/97: uf_scroll_to_max_period triggers itemchanged event.  Don't do
//               it here as well.

//this.TriggerEvent(ItemChanged!)

Return 0

end function

public subroutine uf_load_dddw (string as_function, string as_invoice, string as_status, string as_none);//*****************************************************************//
//  uf_load_dddw                                                   //
//                                                                 //
//  description:  loads the dddw period with the periods from the  //
//                period_cntl table with the FUNCTION_NAME, ivoice, and //
//                status specified                                 //
//                                                                 //
//  arguments:  as_function (string)                               //
//              as_invoice  (string)                               //
//              as_status   (string)                               //
//              as_none     (string) - TRUE or FALSE, if TRUE      //
//                                     'NONE' will be added to     //
//                                     the dddw along with periods //
//                                                                 //
//*****************************************************************//
//
//	01/12/01	GaryR	Stars 4.7 DataBase Port - Single Quotes
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//
//*****************************************************************//

datawindowchild ldw_child
string  ls_original_select, ls_new_select
string  ls_add_where, ls_add_sort
long    ll_insert_row,ll_row_count, ll_pos

this.Reset()
ll_insert_row = this.InsertRow(0)
this.GetChild('period_key',ldw_child)
ldw_child.Reset()
ldw_child.SetTransObject(stars2ca)

//******************************************//
// if none is already included strip it off //
//******************************************//

ls_original_select = ldw_child.Describe("DataWindow.Table.Select")
ll_pos = pos(ls_original_select, 'OR ( period_cntl.FUNCTION_NAME =', 1)
if ll_pos > 0 then
	ls_new_select = Left(ls_original_select, ll_pos -1)
	ldw_child.Modify("DataWindow.Table.Select = '" + ls_new_select + "'" )
end if

// if NPI is already included strip it off
ls_original_select = ldw_child.Describe("DataWindow.Table.Select")
ll_pos = pos(ls_original_select, 'AND ( period_cntl.RUN_BY_OPTIONS = 1) ', 1)
if ll_pos > 0 then
	ls_new_select = Left(ls_original_select, ll_pos -1)
	ldw_child.Modify("DataWindow.Table.Select = '" + ls_new_select + "'" )
end if

//********************************************************//
// if none should be included add it as part of the where //
//********************************************************//

if as_none = 'TRUE' then

	ls_original_select = ldw_child.Describe("DataWindow.Table.Select")
	//	01/12/01	GaryR	Stars 4.7 DataBase Port - Begin
	ls_add_where       = " OR ( period_cntl.FUNCTION_NAME = 'NONE') "
	ldw_child.Modify('DataWindow.Table.Select = "' + ls_original_select + ls_add_where + '"' )
	//	01/12/01	GaryR	Stars 4.7 DataBase Port - End
end if

//	NPI Ratios
IF as_none = "NPI" THEN
	ls_original_select = ldw_child.Describe("DataWindow.Table.Select")
	ls_original_select += " AND ( period_cntl.RUN_BY_OPTIONS = 1) "
	ldw_child.Modify('DataWindow.Table.Select = "' + ls_original_select + '"' )
END IF

//********************//
// retrieve the child //
//********************//

ll_row_count = ldw_child.Retrieve(as_function,as_invoice,as_status)

//*********************//
// sort the datawindow //
//*********************//

ldw_child.setsort("payment_from_date D")
ldw_child.sort()

//djp 9/9/96 - prob#22
if ll_row_count=0 then
	messagebox('Error','No periods available for the '+as_function+' function.',stopsign!)
	return
end if 

uf_scroll_to_max_period(ldw_child)

end subroutine

public function integer uf_scroll_to_row (string as_period_desc);//uf_scroll_to_row will scroll to the row with the period description
//passed to it.
//john_wo 1/9/98

//********************************************************************************
// 11/24/98 FNC	Track 1974 Allow period key to be equal to 0. Set period key = -1 
//						prior to search and then test if still = -1
// 08/07/02 MikeF	Track 3246 Bounce descriptions to uppercase.
//********************************************************************************

datawindowchild ldw_child
integer li_row, li_rc
long ll_period_key
long ll_row_count
string ls_period_desc

//***************************//
// scroll to the desired row //
//***************************//

this.GetChild('period_key',ldw_child)

ll_row_count = ldw_child.RowCount()

if ll_row_count < 1 then Return 1

ll_period_key = -1				// FNC 11/24/98

For li_row = 1 to ll_row_count
	
	ls_period_desc = ldw_child.GetItemString(li_row, 'period_desc')
	
	// MikeFl - 8/7/02 - Track 3246 - Begin
	//if (ls_period_desc = as_period_desc) then
	if (Upper(ls_period_desc) = Upper(as_period_desc)) then 
	// MikeFl - 8/7/02 - Track 3246 - End
   	ll_period_key = ldw_child.GetItemNumber(li_row, 'period_key')
		Exit
	end if 
Next


If ll_period_key >= 0 Then		// FNC 11/24/98				
Else
	MessageBox('Error','The following period was not found: ' &
		+ ls_period_desc,StopSign!,OK!)
	Return -1
End If

this.SetItem(1, 'period_key', ll_period_key)



this.TriggerEvent(ItemChanged!)
Return 1
end function

event itemchanged;///////////////////////////////////////////////////////////////////
//	History
//
//	FDG	05/20/99	Track 1804c.  4.0 SP2.  Save use_bill_alwd for
//						future access.  This column is used in the
//						ratio reports.
//	GaryR	10/25/01	Track 2487d	Null dates are 1/1/1900
//
///////////////////////////////////////////////////////////////////

long ll_current_child_row
datawindowchild ldw_child
DateTime	ldt_default			//	GaryR	10/25/01	Track 2487d

//*********************************************************//
// Highlights the current row and assigns column data from //
// that row to instance variables.  The return functions   //
// can be called to retrieve those variables.              //
//*********************************************************//

this.GetChild('period_key',ldw_child)
ll_current_child_row = ldw_child.GetRow()
   
if ll_current_child_row > 0 then
		il_period_key        = ldw_child.getitemnumber(ll_current_child_row, 'period_key')
      il_period            = ldw_child.getitemnumber(ll_current_child_row, 'period')
		id_from_date         = ldw_child.getitemdatetime(ll_current_child_row, 'from_date')
		id_thru_date         = ldw_child.getitemdatetime(ll_current_child_row, 'thru_date')
		//	GaryR	10/25/01	Track 2487d - Begin
		IF ( IsNull( id_from_date ) OR id_from_date = ldt_default ) &
		AND ( IsNull( id_thru_date ) OR id_thru_date = ldt_default ) THEN
			SetNull( id_from_date )
			SetNull( id_thru_date )
		END IF
		//	GaryR	10/25/01	Track 2487d - End
   	id_payment_from_date = ldw_child.getitemdatetime(ll_current_child_row, 'payment_from_date')
   	id_payment_thru_date = ldw_child.getitemdatetime(ll_current_child_row, 'payment_thru_date')
      is_period_desc       = ldw_child.getitemstring(ll_current_child_row, 'period_desc')
      is_use_bill_alwd     = ldw_child.getitemstring(ll_current_child_row, 'use_bill_alwd')	// FDG 05/20/99
		//gv_period_key        = il_period_key	//NLG TS2239 - Get rid of globals for period key
else
	return
end if


end event

event losefocus;//JGG 08/12/97: This code caused the itemchanged event to be triggered a second time
//              when the selection within the data window was changed.
//              On the second execution, the description ended up being correct, 
//              but internally the period id was incorrect, always being the first
//              value in the ddlb.

//this.TriggerEvent(itemchanged!)
end event

on u_display_period.create
call super::create
end on

on u_display_period.destroy
call super::destroy
end on

