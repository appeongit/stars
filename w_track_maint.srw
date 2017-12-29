HA$PBExportHeader$w_track_maint.srw
$PBExportComments$Inherited from w_master
forward
global type w_track_maint from w_master
end type
type dw_case from u_dw within w_track_maint
end type
type dw_case_track from u_dw within w_track_maint
end type
type dw_track_headings from u_dw within w_track_maint
end type
type tab_track from tab within w_track_maint
end type
type tabpage_general from userobject within tab_track
end type
type cb_close_general from u_cb within tabpage_general
end type
type cb_next_general from u_cb within tabpage_general
end type
type cb_next_track_general from u_cb within tabpage_general
end type
type cb_prev_track_general from u_cb within tabpage_general
end type
type dw_general from u_dw within tabpage_general
end type
type tabpage_general from userobject within tab_track
cb_close_general cb_close_general
cb_next_general cb_next_general
cb_next_track_general cb_next_track_general
cb_prev_track_general cb_prev_track_general
dw_general dw_general
end type
type tabpage_current from userobject within tab_track
end type
type uo_tabpage_rmm_current from uo_tabpage_rmm within tabpage_current
end type
type cb_close_current from u_cb within tabpage_current
end type
type cb_next_current from u_cb within tabpage_current
end type
type cb_prev_current from u_cb within tabpage_current
end type
type cb_next_track_current from u_cb within tabpage_current
end type
type cb_prev_track_current from u_cb within tabpage_current
end type
type dw_current from u_dw within tabpage_current
end type
type tabpage_current from userobject within tab_track
uo_tabpage_rmm_current uo_tabpage_rmm_current
cb_close_current cb_close_current
cb_next_current cb_next_current
cb_prev_current cb_prev_current
cb_next_track_current cb_next_track_current
cb_prev_track_current cb_prev_track_current
dw_current dw_current
end type
type tabpage_savings from userobject within tab_track
end type
type cb_prev_track_savings from u_cb within tabpage_savings
end type
type cb_next_track_savings from u_cb within tabpage_savings
end type
type cb_prev_savings from u_cb within tabpage_savings
end type
type cb_next_savings from u_cb within tabpage_savings
end type
type cb_close_savings from u_cb within tabpage_savings
end type
type dw_savings from u_dw within tabpage_savings
end type
type tabpage_savings from userobject within tab_track
cb_prev_track_savings cb_prev_track_savings
cb_next_track_savings cb_next_track_savings
cb_prev_savings cb_prev_savings
cb_next_savings cb_next_savings
cb_close_savings cb_close_savings
dw_savings dw_savings
end type
type tabpage_log from userobject within tab_track
end type
type uo_tabpage_rmm_log from uo_tabpage_rmm within tabpage_log
end type
type dw_log from u_dw within tabpage_log
end type
type cb_prev_track_log from u_cb within tabpage_log
end type
type cb_next_track_log from u_cb within tabpage_log
end type
type cb_prev_log from u_cb within tabpage_log
end type
type cb_close_log from u_cb within tabpage_log
end type
type st_count from statictext within tabpage_log
end type
type tabpage_log from userobject within tab_track
uo_tabpage_rmm_log uo_tabpage_rmm_log
dw_log dw_log
cb_prev_track_log cb_prev_track_log
cb_next_track_log cb_next_track_log
cb_prev_log cb_prev_log
cb_close_log cb_close_log
st_count st_count
end type
type tab_track from tab within w_track_maint
tabpage_general tabpage_general
tabpage_current tabpage_current
tabpage_savings tabpage_savings
tabpage_log tabpage_log
end type
end forward

global type w_track_maint from w_master
long backcolor = 67108864
string accessiblename = "Track Details"
string accessibledescription = "Track Details"
accessiblerole accessiblerole = windowrole!
integer width = 3694
integer height = 2304
string title = "Track Details"
boolean maxbox = false
boolean ib_popup_menu = true
event ue_retrieve_log ( )
event ue_retrieve_track ( )
event ue_scroll_tracks ( integer ai_scrollrow )
event ue_edits ( long as_row,  dwobject as_dwo,  string as_data )
event ue_scroll_tab ( ref tab at_tab,  integer ai_scroll_value )
event ue_reset_dates ( )
event ue_update_balance ( )
event ue_open_menu ( )
event ue_set_track_buttons ( long al_row_count,  long al_current_row )
event type integer ue_validate_case ( )
event ue_payment_type ( ref datawindowchild dwo )
event ue_populate_headings ( )
event ue_enable_details ( boolean ab_switch )
event ue_set_update_availability ( )
dw_case dw_case
dw_case_track dw_case_track
dw_track_headings dw_track_headings
tab_track tab_track
end type
global w_track_maint w_track_maint

type variables
// Katie	11/09/2004	Track 3741 Added is_target_id variable to hold target_id
// active case
String		is_active_case
String		is_trk_type
String		is_trk_key
String		is_target_id
n_cst_case	inv_case
n_ds inv_payment
int		ii_tp_general = 1
int		ii_tp_current = 2
int		ii_tp_savings = 3
int		ii_tp_log = 4
datawindowchild	idwc_disp
datawindowchild	idwc_status
datawindowchild	idwc_payment
m_track_general	im_general
m_track_current	im_current
m_track_savings	im_savings
m_track_log	im_log
n_ds ids_all_tracks	// JasonS 08/16/02 Track 3244d

boolean ib_updated = false // JasonS 11/21/02 Track 3374d

end variables

event ue_retrieve_log();//*********************************************************************************
// Script Name: ue_retrieve_log	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will retrieve the log data for the track.
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//	04/16/01	FDG	Stars 4.7.	Properly trim the data.
// 10/28/02	Jason	Track 4055c call n_cst_labels
// 11/04/04	Jason	Track 3573 Add counts box for track log tab
//	12/27/04	GaryR	Track 4190d	Add Code/Decode to Track Log
//*********************************************************************************


String	ls_case,				&
			ls_case_ver,		&
			ls_case_spl

Long		ll_rowcount

Integer	li_rc

n_cst_labels lnv_labels		// JasonS 10/24/02 Track 4055c

ls_case		=	Trim (Left (is_active_case, 10) )		// FDG 04/16/01
ls_case_spl	=	Mid (is_active_case, 11, 2)
ls_case_ver	=	Mid (is_active_case, 13, 2)

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
li_rc	=	gnv_sql.of_TrimData (is_trk_type)
li_rc	=	gnv_sql.of_TrimData (is_trk_key)
li_rc	=	gnv_sql.of_TrimData (is_target_id)
// FDG 04/16/01 end

fx_dw_syntax( is_window_name, tab_track.tabpage_log.dw_log, istr_decode_struct, stars2ca)

tab_track.tabpage_log.dw_log.SetTransobject( Stars2ca )
ll_rowcount		=	tab_track.tabpage_log.dw_log.Retrieve &
                  (ls_case, ls_case_spl, ls_case_ver, is_trk_type, is_trk_key, is_target_id)

IF	ll_rowcount	>	0		THEN
	tab_track.tabpage_log.enabled	=	TRUE
	tab_track.tabpage_log.dw_log.bringtotop = TRUE
ELSE
	tab_track.tabpage_log.enabled	=	FALSE
END IF
String ls_desc, ls_column
Int i

tab_track.tabpage_log.dw_log.SetRedraw(False)
// Set the money headings for each of the money columns 
inv_case.uf_format_custom_headings (tab_track.tabpage_log.dw_log)
// JasonS 10/24/02 Begin - Track 4055c
lnv_labels = create n_cst_labels
lnv_labels.of_setdw(tab_track.tabpage_log.dw_log)
lnv_labels.of_trk_info_width(tab_track.tabpage_general.dw_general.object.trk_type[1] )
// JasonS 10/24/02 End - Track 4055c
tab_track.tabpage_log.dw_log.SetRedraw(True)	

tab_track.tabpage_log.st_count.text = string(tab_track.tabpage_log.dw_log.rowcount())

destroy lnv_labels	// JasonS 10/24/02 Track 4055c
end event

event ue_scroll_tracks(integer ai_scrollrow);//*********************************************************************************
// Script Name: ue_scroll_tracks	
//
//	Arguments: ai_scrollrow - determines scroll direction
//						
//
// Returns:	none		
//
//	Description: This event will scroll forward or backward between tracks in a case. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
// JasonS 08/16/02 Track 3244d  use datastore to scroll to different row
//*********************************************************************************

// JasonS 08/16/02 Begin - Track 3244d
long 	ll_current_row,			&
			ll_case_row,				&
			ll_row_count, ll_scroll_row

ll_current_row = ids_all_tracks.getrow()
ll_scroll_row = ll_current_row + ai_scrollrow

is_trk_type = ids_all_tracks.object.trk_type[ll_scroll_row]
is_trk_key = ids_all_tracks.object.trk_key[ll_scroll_row]
is_target_id = ids_all_tracks.object.target_id[ll_scroll_row]

this.event ue_retrieve()
			
tab_track.tabpage_savings.dw_savings.SetReDraw(true)
SetMicroHelp(w_main, 'Ready')
end event

event ue_edits(long as_row, dwobject as_dwo, string as_data);//*********************************************************************************
// Script Name: ue_edits	
//
//	Arguments: as_row - dw row
//				  as_dwo - dw column object reference
//				  as_data - new data user entered
//				  This event is called in the item changed event of the datawindows.
//				  The itemchanged event arguments are passed to this event for processing.
//						
//
// Returns:	none		
//
//	Description: This event will edit entry data to ensure the user changes the system 
//              disposition before any updates take effect.  If the status, disposition,
//              or any money amount change - update the track status datetime field.
//					 This event will also calculate balance remaining if the overpayment
//              recoupment or referred amount change.
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Check if changing disposition first; do not allow changes if new disp = 'SYS'
Integer	li_rc
string 	ls_columnname
string 	ls_column_verbiage
long 		ll_current_row

//		tab_track.tabpage_savings.dw_savings.SetReDraw(false)
ls_columnname = as_dwo.name
ll_current_row = dw_case_track.GetRow ()

If  ((ls_columnname = 'date_rev') and IsNull(string(as_data))) then
	return
end if
If  ((ls_columnname = 'date_req') and IsNull(string(as_data))) then
	return
end if

//Edit the changing columns
boolean lb_valid_date


CHOOSE CASE ls_columnname
		
CASE	'disp','status'
		tab_track.tabpage_current.dw_current.Object.status_datetime[ll_current_row] = gnv_app.of_get_server_date_time()

		//calculate balance remaining
CASE "op_amt"
		decimal ldc_bal_remain
		decimal ldc_op_amt
		decimal ldc_amt_recv
		decimal ldc_amt_writeoff
	
		tab_track.tabpage_current.dw_current.Object.status_datetime[ll_current_row] = gnv_app.of_get_server_date_time()
		ldc_op_amt = tab_track.tabpage_savings.dw_savings.Object.op_amt [ll_current_row]
		ldc_amt_recv = tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row]
		ldc_amt_writeoff = tab_track.tabpage_savings.dw_savings.Object.amt_writeoff [ll_current_row]
		
		
		If Isnull(ldc_op_amt) then
				ldc_op_amt = 0
		End If
		
		
		If 		ls_columnname = "op_amt" then
							ldc_op_amt = dec(as_data)
		End if

		ldc_bal_remain = ldc_op_amt - ldc_amt_recv - ldc_amt_writeoff
		tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row] = ldc_amt_recv
		tab_track.tabpage_savings.dw_savings.Object.balance_remaining_amt [ll_current_row] = ldc_bal_remain

CASE "payment_amt", "payment_type", "check_no", "amt_recv","amt_writeoff", "recovered_addtl_amt", "referred_amt", "custom1_amt", "custom2_amt", "custom3_amt", "custom4_amt", "custom5_amt", "custom6_amt"
		tab_track.tabpage_current.dw_current.Object.status_datetime[ll_current_row] = gnv_app.of_get_server_date_time()

CASE ELSE

END CHOOSE


If  (ls_columnname = 'disp' and left(string(as_data),3) = 'SYS') then
		SetMicroHelp(w_main, 'Update Cancelled')
		Messagebox('EDIT', 'System created Disposition may not be used')
		tab_track.SelectTab("tabpage_current")
		tab_track.tabpage_current.dw_current.SetColumn('disp')
		tab_track.tabpage_current.dw_current.SetFocus()
ElseIf (ls_columnname = 'disp') then
	//continue disp is changing out of sys 
ElseIf left(string(tab_track.tabpage_current.dw_current.Object.disp[ll_current_row]),3) = 'SYS' then
		SetMicroHelp(w_main, 'Update Cancelled')
		Messagebox('EDIT', 'Must Update System created Disposition')
		tab_track.SelectTab("tabpage_current")
		tab_track.tabpage_current.dw_current.SetColumn('disp')
		tab_track.tabpage_current.dw_current.SetFocus()
		Return
End If
tab_track.tabpage_current.dw_current.SetReDraw(true)
tab_track.tabpage_savings.dw_savings.SetReDraw(true)

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
// 09/29/99 AJS	Created Rls 4.5 TS2363
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
// 09/29/99 AJS	Created Rls 4.5 TS2363
// 10/08/04	Katie	Track 4054 Removed if so that date_rev always reset to 00/00/0000
//	08/31/05	GaryR	Track 4501d	PB10 bug - use blank to set date to 00/00/0000
//
//*********************************************************************************

date  ldt_default_datetime
ldt_default_datetime = date('01/01/1900')
long ll_current_row

ll_current_row = tab_track.tabpage_savings.dw_savings.GetRow()
//Hide null dates
if date(tab_track.tabpage_savings.dw_savings.Object.date_req[ll_current_row]) = ldt_default_datetime then
	tab_track.tabpage_savings.dw_savings.SetColumn("date_req")
	tab_track.tabpage_savings.dw_savings.Settext("")
	tab_track.tabpage_savings.dw_savings.Accepttext()
	tab_track.tabpage_savings.dw_savings.SetItemStatus ( ll_current_row, "date_req", Primary!, NotModified!)
end if

//Hide null dates
//if date(tab_track.tabpage_savings.dw_savings.Object.date_rev[ll_current_row]) = ldt_default_datetime then
	tab_track.tabpage_savings.dw_savings.SetColumn("date_rev")
	tab_track.tabpage_savings.dw_savings.Settext("")
	tab_track.tabpage_savings.dw_savings.Accepttext()
	tab_track.tabpage_savings.dw_savings.SetItemStatus ( ll_current_row, "date_rev", Primary!, NotModified!)
//end if Katie 10/08/2004 Removed for Track 4054
end event

event ue_update_balance();// Katie		09/29/2004	Added code to calculate all dollar amounts taking payment_amt and payment_type into account
long ll_current_row
string ls_labelname

ll_current_row = tab_track.tabpage_current.dw_current.GetRow()

tab_track.tabpage_current.dw_current.Object.status_datetime[ll_current_row] = gnv_app.of_get_server_date_time()

If Isnull(tab_track.tabpage_savings.dw_savings.Object.op_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.op_amt [ll_current_row] = 0
End If
If Isnull(tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row] = 0
End If
If Isnull(tab_track.tabpage_savings.dw_savings.Object.amt_writeoff [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.amt_writeoff [ll_current_row] = 0
End If
If Isnull(tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.recovered_addtl_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.recovered_addtl_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.referred_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.referred_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.custom1_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.custom1_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.custom2_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.custom2_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.custom3_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.custom3_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.custom4_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.custom4_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.custom5_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.custom5_amt [ll_current_row] = 0
End If 
If Isnull(tab_track.tabpage_savings.dw_savings.Object.custom6_amt [ll_current_row]) then
		tab_track.tabpage_savings.dw_savings.Object.custom6_amt [ll_current_row] = 0
End If  //Katie 09/27/2004 Track 4054
		
tab_track.tabpage_savings.dw_savings.Object.balance_remaining_amt [ll_current_row] = &
			tab_track.tabpage_savings.dw_savings.Object.op_amt [ll_current_row] - &
			tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row] - &
			tab_track.tabpage_savings.dw_savings.Object.amt_writeoff [ll_current_row]

end event

event ue_set_track_buttons(long al_row_count, long al_current_row);//*********************************************************************************
// Script Name: ue_set_track_buttons
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will Enable or Disabled next & prev track buttons 
//              depending on number of tracks.
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
long ll_row_count, ll_current_row
ll_row_count = al_row_count
ll_current_row = al_current_row

If ll_row_count > 1 then
	If ll_current_row = 1 then
			tab_track.tabpage_general.cb_prev_track_general.enabled = false
			tab_track.tabpage_current.cb_prev_track_current.enabled = false
			tab_track.tabpage_savings.cb_prev_track_savings.enabled = false
			tab_track.tabpage_log.cb_prev_track_log.enabled = false
			im_general.m_menu.m_previoustrack.enabled = false
			im_current.m_menu.m_previoustrack.enabled = false
			im_savings.m_menu.m_previoustrack.enabled = false
			im_log.m_menu.m_previoustrack.enabled = false
			
			tab_track.tabpage_general.cb_next_track_general.enabled = true
			tab_track.tabpage_current.cb_next_track_current.enabled = true
			tab_track.tabpage_savings.cb_next_track_savings.enabled = true
			tab_track.tabpage_log.cb_next_track_log.enabled = true
			im_general.m_menu.m_nexttrack.enabled = true
			im_current.m_menu.m_nexttrack.enabled = true
			im_savings.m_menu.m_nexttrack.enabled = true
			im_log.m_menu.m_nexttrack.enabled = true
			
	Elseif ll_current_row = ll_row_count then
			tab_track.tabpage_general.cb_prev_track_general.enabled = true
			tab_track.tabpage_current.cb_prev_track_current.enabled = true
			tab_track.tabpage_savings.cb_prev_track_savings.enabled = true
			tab_track.tabpage_log.cb_prev_track_log.enabled = true
			im_general.m_menu.m_previoustrack.enabled = true
			im_current.m_menu.m_previoustrack.enabled = true
			im_savings.m_menu.m_previoustrack.enabled = true
			im_log.m_menu.m_previoustrack.enabled = true
			
			tab_track.tabpage_general.cb_next_track_general.enabled = false
			tab_track.tabpage_current.cb_next_track_current.enabled = false
			tab_track.tabpage_savings.cb_next_track_savings.enabled = false
			tab_track.tabpage_log.cb_next_track_log.enabled = false
			im_general.m_menu.m_nexttrack.enabled = false
			im_current.m_menu.m_nexttrack.enabled = false
			im_savings.m_menu.m_nexttrack.enabled = false
			im_log.m_menu.m_nexttrack.enabled = false
	Else
			tab_track.tabpage_general.cb_prev_track_general.enabled = true
			tab_track.tabpage_current.cb_prev_track_current.enabled = true
			tab_track.tabpage_savings.cb_prev_track_savings.enabled = true
			tab_track.tabpage_log.cb_prev_track_log.enabled = true
			im_general.m_menu.m_previoustrack.enabled = true
			im_current.m_menu.m_previoustrack.enabled = true
			im_savings.m_menu.m_previoustrack.enabled = true
			im_log.m_menu.m_previoustrack.enabled = true
			
			tab_track.tabpage_general.cb_next_track_general.enabled = true
			tab_track.tabpage_current.cb_next_track_current.enabled = true
			tab_track.tabpage_savings.cb_next_track_savings.enabled = true
			tab_track.tabpage_log.cb_next_track_log.enabled = true
			im_general.m_menu.m_nexttrack.enabled = true
			im_current.m_menu.m_nexttrack.enabled = true
			im_savings.m_menu.m_nexttrack.enabled = true
			im_log.m_menu.m_nexttrack.enabled = true
	End If
Else
	tab_track.tabpage_general.cb_prev_track_general.enabled = false
	tab_track.tabpage_current.cb_prev_track_current.enabled = false
	tab_track.tabpage_savings.cb_prev_track_savings.enabled = false
	tab_track.tabpage_log.cb_prev_track_log.enabled = false
	im_general.m_menu.m_previoustrack.enabled = false
	im_current.m_menu.m_previoustrack.enabled = false
	im_savings.m_menu.m_previoustrack.enabled = false
	im_log.m_menu.m_previoustrack.enabled = false
			
	tab_track.tabpage_general.cb_next_track_general.enabled = false
	tab_track.tabpage_current.cb_next_track_current.enabled = false
	tab_track.tabpage_savings.cb_next_track_savings.enabled = false
	tab_track.tabpage_log.cb_next_track_log.enabled = false
	im_general.m_menu.m_nexttrack.enabled = false
	im_current.m_menu.m_nexttrack.enabled = false
	im_savings.m_menu.m_nexttrack.enabled = false
	im_log.m_menu.m_nexttrack.enabled = false
End if

end event

event type integer ue_validate_case();//*******************************************************************
//	Script			ue_validate_case
//
//
//	Description		Prevent updating this window if the case is refered,
//						deleted, or locked
//
//	Returns			1 = Allow update
//						0 = Disable update
//					  -1 = Close window
//
//*******************************************************************
//	09/21/01	FDG	Stars 4.8.	Created
//	02/03/05	GaryR	Track 4267d	Validate for REFERRED, DELETED, or LOCKED Cases
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//*******************************************************************

String	ls_disp, ls_hold, ls_case_id, ls_case_spl, ls_case_ver

ls_case_id = tab_track.tabpage_general.dw_general.object.case_id[1]
ls_case_spl = tab_track.tabpage_general.dw_general.object.case_spl[1]
ls_case_ver = tab_track.tabpage_general.dw_general.object.case_ver[1]

//	Validate case
SELECT CASE_DISP, CASE_DISP_HOLD
INTO :ls_disp, :ls_hold
FROM CASE_CNTL
WHERE CASE_ID = :ls_case_id
AND CASE_SPL = :ls_case_spl
AND CASE_VER = :ls_case_ver
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "ERROR", "Unable to validate Case~n~rAccess to Tracks is denied and the window will close",StopSign! )
	Return -1
END IF

IF ls_hold = 'HOLD' THEN
	IF gv_case_disp <> 'MYHOLD' THEN
		gv_case_disp = 'HOLD'
		IF Messagebox('EDIT','Case is Actively being Worked on by Another User, Proceed to View the Tracks?',Question!,YesNo!,2) = 2 THEN					
			Return -1
		END iF
	END IF
ELSE
	gv_case_disp = ""
END IF

IF ls_disp <> 'SYSDELET' AND ls_disp <> 'REFERRED' AND gv_case_disp <> 'HOLD' THEN Return 1

//	If condition is met, lock tracks
tab_track.tabpage_general.dw_general.Object.DataWindow.ReadOnly	=	'Yes'
tab_track.tabpage_current.dw_current.Object.DataWindow.ReadOnly	=	'Yes'
tab_track.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly	=	'Yes'
tab_track.tabpage_log.dw_log.Object.DataWindow.ReadOnly				=	'Yes'
im_general.m_menu.m_update.enabled		=	FALSE
im_general.m_menu.m_undo.enabled			=	FALSE
im_current.m_menu.m_update.enabled		=	FALSE
im_current.m_menu.m_undo.enabled			=	FALSE
im_savings.m_menu.m_update.enabled		=	FALSE
im_savings.m_menu.m_undo.enabled			=	FALSE

Return 0
end event

event ue_populate_headings();//JasonS 10/26/04 Track 3573 
DataWindowChild ldwc
Long ll_track_row 
String ls_track_type

ll_track_row = tab_track.tabpage_general.dw_general.getrow()


dw_track_headings.setitem(1, "description", dw_case.getItemstring(1, "case_desc"))	
dw_track_headings.setitem(1, "subject_id", dw_case.getItemstring(1, "pmr_subject_id"))		
dw_track_headings.setitem(1, "case_id",  dw_case.getItemstring(1, "case_id") + " " + dw_case.getItemstring(1, "case_spl") + " " + dw_case.getItemstring(1, "case_ver"))
dw_track_headings.setitem(1, "track_key", tab_track.tabpage_general.dw_general.getitemstring(ll_track_row, "trk_key"))
dw_track_headings.setitem(1, "track_name", tab_track.tabpage_general.dw_general.getitemstring(ll_track_row, "trk_name"))
dw_track_headings.setitem(1, "create_date", String(tab_track.tabpage_general.dw_general.getitemdatetime(ll_track_row, "create_datetime")))

Choose Case Upper(tab_track.tabpage_general.dw_general.getitemstring(ll_track_row, "trk_type"))
	Case "PV"
		ls_track_type = "PV - Provider"
	Case "BE"
		ls_track_type = "BE - Beneficiary"
	Case "RV"
		ls_track_type = "RV - Revenue"
	Case "PC"
		ls_track_type = "PC - Procedure"
	Case Else
		ls_track_type = ""
End Choose

dw_track_headings.setitem(1, "track_type", ls_track_type)
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
	tab_track.tabpage_general.dw_general.Object.DataWindow.ReadOnly="No"
	tab_track.tabpage_current.dw_current.Object.DataWindow.ReadOnly="No"
	tab_track.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly="No"
else
	tab_track.tabpage_general.dw_general.Object.DataWindow.ReadOnly="Yes"
	tab_track.tabpage_current.dw_current.Object.DataWindow.ReadOnly="Yes"
	tab_track.tabpage_savings.dw_savings.Object.DataWindow.ReadOnly="Yes"
end if



end event

event ue_set_update_availability();//*********************************************************************************
// Script Name:	ue_set_update_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the detail
//						based on the update status returned from n_cst_case.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************


String ls_case_id
String ls_case_spl
String ls_case_ver
String ls_comp_upd_status

ls_case_id = tab_track.tabpage_general.dw_general.object.case_id[1]
ls_case_spl = tab_track.tabpage_general.dw_general.object.case_spl[1]
ls_case_ver = tab_track.tabpage_general.dw_general.object.case_ver[1]

ls_comp_upd_status = inv_case.uf_get_comp_upd_status('CASETRACK', ls_case_id , ls_case_spl, ls_case_ver)

choose case ls_comp_upd_status 
	case 'AO'
			this.event ue_enable_details(false)
	case 'RO'
		this.event ue_enable_details(false)
	case 'AL'
		this.event ue_enable_details(true)
end choose


end event

on w_track_maint.create
int iCurrent
call super::create
this.dw_case=create dw_case
this.dw_case_track=create dw_case_track
this.dw_track_headings=create dw_track_headings
this.tab_track=create tab_track
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_case
this.Control[iCurrent+2]=this.dw_case_track
this.Control[iCurrent+3]=this.dw_track_headings
this.Control[iCurrent+4]=this.tab_track
end on

on w_track_maint.destroy
call super::destroy
destroy(this.dw_case)
destroy(this.dw_case_track)
destroy(this.dw_track_headings)
destroy(this.tab_track)
end on

event ue_retrieve;//*********************************************************************************
// Script Name: ue_retrieve
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will retrieve invisible datawindows to populate the 
// 				 various viewable datawindows on the tabpages by using ShareData.
//					 The log data will also be retrieved.
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//	09/21/01	FDG	Stars 4.8.1.	No updates can occur if the case is closed
// 08/07/02 JasonS Track 3244d Retrieve only the track row needed
// 08/16/02 JasonS Track 3244d Retrieve all tracks into a data store for scrolling purposes only
// JasonS 09/30/02 Track 3314d call uf_format_custom_headings
// JasonS 10/39/04 Track 3573  Populate track headings
// Katie	 11/09/2004 Track 3741 Added code to handle target_id as additional retrieval argument for track.
// JasonS 12/9/04 Track 3664 Case Component Update
//*********************************************************************************


String	ls_case,				&
			ls_case_ver,		&
			ls_case_spl,		&
			ls_find

Long		ll_rowcount,		&
			ll_case_row,		&
			ll_find_row,      &
			ll_ds_find_row,  ll_ds_row_count		// JasonS 08/16/02 Track 3244d
			

ls_case		=	Left (is_active_case, 10)
ls_case_spl	=	Mid (is_active_case, 11, 2)
ls_case_ver	=	Mid (is_active_case, 13, 2)

ll_case_row		=	dw_case.Retrieve (ls_case,			&
												ls_case_spl,	&
												ls_case_ver)


ll_rowcount		=	dw_case_track.Retrieve (ls_case,	ls_case_spl, ls_case_ver, is_trk_type, is_trk_key, is_target_id)														

// JasonS 08/16/02  Begin - Track 3244d												
ids_all_tracks = create n_ds

ids_all_tracks.dataobject = 'd_track_info_all'
ids_all_tracks.settransobject(stars2ca)
ll_ds_row_count = ids_all_tracks.retrieve(ls_case, ls_case_spl, ls_case_ver)
ls_find = "trk_key = '" + is_trk_key + "' and target_id = '" + is_target_id + "'"
ll_ds_find_row = ids_all_tracks.find (ls_find, 1, ll_ds_row_count)
ids_all_tracks.setrow(ll_ds_find_row)

// Share the data between dw_general and the other tabs.
dw_case_track.ShareData (tab_track.tabpage_general.dw_general)
dw_case_track.ShareData (tab_track.tabpage_current.dw_current)
dw_case_track.ShareData (tab_track.tabpage_savings.dw_savings)
This.event ue_set_track_buttons(ll_ds_row_count, ll_ds_find_row)
// JasonS 08/07/02 End - Track 3244d

String ls_desc, ls_column
Int i
tab_track.tabpage_savings.dw_savings.SetRedraw(False)
inv_case.uf_format_custom_headings (tab_track.tabpage_savings.dw_savings)
tab_track.tabpage_savings.dw_savings.object.case_id.visible = 0
tab_track.tabpage_savings.dw_savings.object.case_id_t.visible = 0
tab_track.tabpage_savings.dw_savings.object.trk_type.visible = 0
tab_track.tabpage_savings.dw_savings.object.trk_type_t.visible = 0
tab_track.tabpage_savings.dw_savings.object.trk_key.visible = 0
tab_track.tabpage_savings.dw_savings.object.trk_key_t.visible = 0
tab_track.tabpage_savings.dw_savings.SetRedraw(True)	

// JasonS 09/30/02 Begin - Track 3314d
tab_track.tabpage_general.dw_general.SetRedraw(False)
inv_case.uf_format_custom_headings (tab_track.tabpage_general.dw_general)
tab_track.tabpage_general.dw_general.object.case_id.visible = 0
tab_track.tabpage_general.dw_general.object.case_id_t.visible = 0
tab_track.tabpage_general.dw_general.object.case_ver.visible = 0
tab_track.tabpage_general.dw_general.object.case_ver_t.visible = 0
tab_track.tabpage_general.dw_general.object.case_spl.visible = 0
tab_track.tabpage_general.dw_general.object.case_spl_t.visible = 0
tab_track.tabpage_general.dw_general.object.trk_name.visible = 0
tab_track.tabpage_general.dw_general.object.trk_name_t.visible = 0
tab_track.tabpage_general.dw_general.object.trk_key.visible = 0
tab_track.tabpage_general.dw_general.object.trk_key_t.visible = 0
tab_track.tabpage_general.dw_general.object.trk_type.visible = 0
tab_track.tabpage_general.dw_general.object.trk_type_t.visible = 0
tab_track.tabpage_general.dw_general.SetRedraw(True)	

tab_track.tabpage_current.dw_current.SetRedraw(False)
inv_case.uf_format_custom_headings (tab_track.tabpage_current.dw_current)
tab_track.tabpage_current.dw_current.object.case_id.visible = 0
tab_track.tabpage_current.dw_current.object.case_id_t.visible = 0
tab_track.tabpage_current.dw_current.object.trk_type.visible = 0
tab_track.tabpage_current.dw_current.object.trk_type_t.visible = 0
tab_track.tabpage_current.dw_current.object.trk_key.visible = 0
tab_track.tabpage_current.dw_current.object.trk_key_t.visible = 0
tab_track.tabpage_current.dw_current.SetRedraw(True)	
// JasonS 09/30/02 End - Track 3314d

// Move the case_asgn_id from dw_case to dw_current.  In dw_current, case_asgn_id is
//	a computed field.
// JasonS 08/07/02 Begin - Track 3244d
//tab_track.tabpage_current.dw_current.object.case_asgn_id [ll_find_row]	=	dw_case.object.case_asgn_id [ll_case_row]
tab_track.tabpage_current.dw_current.object.case_asgn_id [1]	=	dw_case.object.case_asgn_id [ll_case_row]
// JasonS 08/07/02 End - Track 3244d
//tab_track.tabpage_current.dw_current.SetItemStatus ( ll_find_row, "case_asgn_id", Primary!, NotModified!)
tab_track.tabpage_current.dw_current.SetItemStatus ( 1, "case_asgn_id", Primary!, NotModified!)
// JasonS 08/07/02 End - Track 3244d

// Reset 01/01/1900 to show 00/00/0000 to the user
This.Event ue_reset_dates()

//Retrieve child datawindows on the current tab
tab_track.tabpage_current.dw_current.getchild('disp',idwc_disp)
idwc_disp.settransobject(stars2ca)
ll_rowcount = idwc_disp.retrieve()
		
tab_track.tabpage_current.dw_current.getchild('status',idwc_status)
idwc_status.settransobject(stars2ca)
ll_rowcount = idwc_status.retrieve()

tab_track.tabpage_savings.dw_savings.getchild('payment_type',idwc_payment)
idwc_payment.settransobject(stars2ca)
ll_rowcount = idwc_payment.retrieve()

long ll_index
ll_index = 1
string ls_invoice_type
ls_invoice_type = gnv_dict.event ue_get_inv_type('TRACK')
do 
	ls_column = idwc_payment.getitemstring(ll_index, "elem_name")
	ls_desc = gnv_dict.event ue_get_col_desc( ls_invoice_type, ls_column)
	idwc_payment.setitem(ll_index, "elem_elem_label", ls_desc)
	ll_index = ll_index + 1
loop while ll_index < ll_rowcount+1

//
//	Retrive the track_log data for this case.
This.Event	ue_retrieve_log()

// Populate track headings dw
This.Event ue_populate_headings()

// FDG 09/21/01 - No updates can occur if the case is closed/deleted
//This.Event	ue_edit_case_closed()



end event

event open;call super::open;//*********************************************************************************
// Script Name: open	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event create and registers datawindow for necessary processing.	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
// 10/14/04 Katie	Track 4054 Create payment data store.
//
//*********************************************************************************
//ajs 09/03/99 rel 4.5
long ll_row
inv_case = CREATE n_cst_case
inv_case.uf_set_case_dw(dw_case)
inv_case.uf_set_track_dw(dw_case_track)
inv_payment = CREATE n_ds
inv_payment.DataObject  =  'd_track_log'
inv_payment.SetTransObject (Stars2ca)
inv_payment.Retrieve()

This.of_set_sys_cntl_range(TRUE)
SetMicrohelp(w_main, 'Ready')



end event

event ue_postopen;call super::ue_postopen;//*********************************************************************************
// Script Name: ue_postopen
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will retrieve the selected track.	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
// 12/09/04 Jason Track 3664 Case Component Update
//	02/03/05	GaryR	Track 4267d	Validate for REFERRED, DELETED, or LOCKED Cases
// 11/20/06 Katie SPR 4763 Added logic to enable and disable prov_id_type on General tab.
//*********************************************************************************

Integer	li_rt

this.SetRedraw(true)
This.Event	ue_retrieve()

li_rt = This.event ue_validate_case()

CHOOSE CASE li_rt
	CASE -1
		Close( THIS )
	CASE 1
		This.event ue_set_update_availability()
	CASE 0
		w_main.SetMicroHelp ('Track cannot be changed because the Case is deleted, referred, or locked.')
END CHOOSE

if (trim(tab_track.tabpage_general.dw_general.object.trk_type[1]) <> 'PV') then
	tab_track.tabpage_general.dw_general.object.prov_id_type.visible = false
	tab_track.tabpage_general.dw_general.object.prov_id_type_t.visible = false
end if

end event

event ue_initialize_window;call super::ue_initialize_window;//*********************************************************************************
// Script Name: ue_initialize_window	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will set the title for the window	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
String		ls_title

ls_title	=	This.of_get_title()

IF	Len (is_active_case)	>	0		THEN
	This.Title	=	ls_title	+	' - '	+	is_active_case
END IF
end event

event ue_postsave;call super::ue_postsave;//*********************************************************************************
// Script Name: ue_postsave	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will call reset dates and retrieve log	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
// JasonS 08/08/02 Track 3244d  Call uf_compute_case_totals	
// JasonS 11/21/02 Track 3374d  Set ib_updated to true
// Katie	 10/14/04 Track 4054	  Reset Payment data store.
//*********************************************************************************

string ls_case_id, ls_case_spl, ls_case_ver 		// JasonS 08/08/02 Track 3244d

// JasonS 08/08/02 Begin - Track 3244d
ls_case_id = dw_case.object.case_id[1]
ls_case_spl = dw_case.object.case_spl[1]
ls_case_ver = dw_case.object.case_ver[1]

inv_case.uf_compute_case_totals(ls_case_id, ls_case_spl, ls_case_ver)
// JasonS 08/08/02 End - Track 3244d

inv_payment.reset( )
// Katie 10/14/04 Track 4054 - Reset Payment data store

// Reset 01/01/1900 to show 00/00/0000 to the user
This.Event ue_reset_dates()

//	Re-retrieve the track_log data for this track because the 
//	update process could have created new track logs.
This.Event	ue_retrieve_log()

// JasonS 11/21/02 Track 3374d
ib_updated = true

Return 1

end event

event ue_preopen;//*********************************************************************************
// Script Name: ue_preopen	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will set resizing for the tab control on and process
//    			 The message passed to the window by placing the information in
//				    instance variables.
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
// 11/09/2004	Katie	Track 3741 Added code to handle target_id as additional track
//					retrieval argument
//
//*********************************************************************************

// resize the controls within a tab
ib_ResizeTabControls	=	TRUE
sx_case_track lstr_case_track

//ajs 09-09-99 Rls 4.5 TS2363 - pass structure
lstr_case_track = message.PowerObjectParm
SetNull(message.PowerObjectParm)

is_active_case = lstr_case_track.case_id
is_trk_type = lstr_case_track.trk_type
is_trk_key = lstr_case_track.trk_key
is_target_id = lstr_case_track.target_id
this.SetRedraw(false)

//create 4 menus
im_general = create m_track_general
im_current = create m_track_current
im_savings = create m_track_savings
im_log = create m_track_log 

end event

event close;call super::close;//*********************************************************************************
// Script Name: close	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will destroy the n_cst_case nvo. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//	09/21/01	FDG	Stars 4.8.1	Destroy inv_case instead of n_cst_case
// 11/21/02 JasonS Track 3374d  Change to call ue_refresh_case
// 10/14/04	Katie	Track 4054 Add code to destroy payment data store
//*********************************************************************************
// JasonS 11/21/02 Begin - Track 3374d added check for ib_updated
if ib_updated then
	if isvalid(w_case_maint) then
		w_case_maint.triggerevent("ue_refresh_case") // JasonS 11/21/02 Track 3374d
	end if
end if
// JasonS 11/21/02 End - Track 3374d

// FDG 09/21/01
//if isvalid(n_cst_case) then Destroy (n_cst_case)
if isvalid(inv_case) then Destroy (inv_case)
if isvalid(inv_payment) then Destroy (inv_payment)

//destroy 4 menus
if isvalid(im_general) then Destroy im_general 
if isvalid(im_current) then Destroy im_current 
if isvalid(im_savings) then Destroy im_savings
if isvalid(im_log) then Destroy im_log 

end event

event ue_presave;call super::ue_presave;//*********************************************************************************
// Script Name: ue_presave	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will set null date back to the 01/01/1900 format so a 
//				    database error will not occur.  It will edit user entered dates.
//					 Roll up money changes to the case record.  It will also add a log
//					 record when the status, disp, or any money amount changes.
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
// 04/04/00	FNC	Track 2177 Stardev release 4.5. Display error message when user
//						can't update the track because of system disposition.
// 01/09/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	10/11/01	FDG	Stars 4.8.1.	Create a case_log that track was changed
//	07/02/02	Jason	Track 3170d  Display Status tab when asking user to change system 
//											 created disposition
// 08/08/02	Jason	Track 3244d  Call uf_compute_case_totals on postsave
// 09/29/04	Katie	Track 5054d Added code to check the data store for payments and
// 					if there are payments add them to the track_log.
//	12/27/04	GaryR	Track 4190d	Remove decoded codes from Track Log to prevent DB errors
// 01/04/05 Katie	Track 4211d Added lb_extra_row flag to determine if changes were made to log fields
//						after the last payment was applied.  Set to true if current field values differ from those
//						that were last applied to the log.  Removed if statement looking for status on fields.
// 02/21/05 Katie Track 4309d Moved code from inside if statment for writing to log to outside when 
//						needed for both the log and track saves.
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	08/31/05	GaryR	Track 4501d	PB10 bug - use blank to set date to 00/00/0000
//
//*********************************************************************************
//If any rows changed
//all track dws are n the same row
		
long ll_insert_row, ll_current_row
integer li_rc
n_cst_datetime lnvo_cst_datetime
boolean lb_valid_date, lb_extra_row = true
date ldt_default_datetime

String	ls_status_desc, ls_trk_rel_key, ls_trk_desc
String	ls_db_col
Integer	li_ctr, li_cols
n_cst_decode	lnv_decode

ll_current_row = dw_case_track.GetRow ()
ldt_default_datetime = date('01/01/1900')

tab_track.tabpage_current.dw_current.AcceptText()
tab_track.tabpage_savings.dw_savings.AcceptText()
tab_track.tabpage_general.dw_general.AcceptText()

If (dw_case_track.GetItemStatus(ll_current_row, 0, Primary!) = NotModified!) then
	//	Set log unmodified
	if (inv_payment.rowcount() < 1) then 
		tab_track.tabpage_log.dw_log.ResetUpdate()
	
		//Return out because no changes were made
		Return 0
	end if
End If
//prevent 2 log records
If left(string(tab_track.tabpage_current.dw_current.Object.disp[ll_current_row]),3) = 'SYS' then
		Messagebox("EDIT","Must change the System Created Track Dispostion")	// FNC 04/04/00
		// Begin - Track 3170d
		tab_track.SelectTab("tabpage_current")
		tab_track.tabpage_current.dw_current.setfocus()
		tab_track.tabpage_current.dw_current.setcolumn("disp")
		// End - Track 3170d
		Return -1
End If

//Edit dates
lb_valid_date = lnvo_cst_datetime.of_isvalid(date(tab_track.tabpage_savings.dw_savings.Object.date_req[ll_current_row]))

if 	lb_valid_date then
	//continue
elseif IsNull(tab_track.tabpage_savings.dw_savings.Object.date_req[ll_current_row]) then 
		tab_track.tabpage_savings.dw_savings.Object.date_req[ll_current_row] = date('01/01/1900')
else
	Messagebox("EDIT","Please enter a valid Date Requested")
	tab_track.SelectTab("tabpage_savings")
	tab_track.tabpage_savings.dw_savings.SetColumn("date_req")
	tab_track.tabpage_savings.dw_savings.SetFocus()
	return -1
end if

This.Event ue_update_balance()

// FDG 10/11/01 begin
String	ls_message,			&
			ls_track_key

ls_track_key	=	tab_track.tabpage_general.dw_general.Object.TRK_KEY[ll_current_row]
ls_message		=	"Track "	+	ls_track_key	+	" updated."

li_rc			=	inv_case.uf_audit_log ( is_active_case, ls_message )

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for track '	+	ls_track_key	+	&
					'.  Case: ' + is_active_case + '. Script: '		+	&
					'w_track_maint.ue_presave')
	Return	-1
END IF
// FDG 10/11/01 end

// 01/09/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
ls_status_desc	=	tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row]
IF Trim( tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row] ) = "" THEN
	li_rc	=	gnv_sql.of_TrimData (ls_status_desc)
	tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row]	=	ls_status_desc
END IF
ls_trk_rel_key	=	tab_track.tabpage_current.dw_current.Object.TRK_REL_KEY[ll_current_row]
IF Trim( tab_track.tabpage_current.dw_current.Object.TRK_REL_KEY[ll_current_row] ) = "" THEN
	li_rc	=	gnv_sql.of_TrimData (ls_trk_rel_key)
	tab_track.tabpage_current.dw_current.Object.TRK_REL_KEY[ll_current_row]	=	ls_trk_rel_key
END IF
ls_trk_desc	=	tab_track.tabpage_current.dw_current.Object.TRK_DESC[ll_current_row]
IF Trim( tab_track.tabpage_current.dw_current.Object.TRK_DESC[ll_current_row] ) = "" THEN
	li_rc	=	gnv_sql.of_TrimData (ls_trk_desc)
	tab_track.tabpage_current.dw_current.Object.TRK_DESC[ll_current_row]	=	ls_trk_desc
END IF

//Roll up the totals
// JasonS 08/08/02 Begin - Track 3244d call in post save
//li_rc = inv_case.uf_compute_case_totals()
// JasonS 08/08/02 End - Track 3244d
If (tab_track.tabpage_current.dw_current.GetItemStatus(ll_current_row, "status", Primary!) = DataModified!)  OR &
	(tab_track.tabpage_current.dw_current.GetItemStatus(ll_current_row, "disp", Primary!) = DataModified!)  OR &
	(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "op_amt", Primary!) = DataModified!)  OR &
	(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "date_rev", Primary!) = DataModified!)	OR &
	inv_payment.rowcount() > 0 then

		//10/14/2004 Katie Track 4054 store server date for log entries.
		datetime ld_logdate 
		ld_logdate = gnv_app.of_get_server_date_time()
		int li_dsrow, li_maxrow, li_len
		li_maxrow = inv_payment.rowcount() + 1
		li_len = len(string(ld_logdate))
		//10/14/2004 Katie Track 4054 if datastore has rows move them to the track_log
		if (inv_payment.rowcount() > 0) then 
			li_dsrow = 1
			do 
				ll_insert_row = tab_track.tabpage_log.dw_log.InsertRow(0)
				tab_track.tabpage_log.dw_log.Object.STATUS[ll_insert_row] = inv_payment.Object.STATUS[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.DISP[ll_insert_row] =  inv_payment.Object.DISP[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.STATUS_DESC[ll_insert_row] = inv_payment.Object.STATUS_DESC[li_dsrow] 
				ld_logdate = Datetime((Date(ld_logdate)), RelativeTime(Time(ld_logdate), li_dsrow))
				tab_track.tabpage_log.dw_log.Object.STATUS_DATETIME[ll_insert_row] = ld_logdate
				tab_track.tabpage_log.dw_log.Object.USER_ID[ll_insert_row] = inv_payment.Object.USER_ID[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.OP_AMT[ll_insert_row] = inv_payment.Object.OP_AMT[li_dsrow]    
				tab_track.tabpage_log.dw_log.Object.AMT_RECV[ll_insert_row] = inv_payment.Object.AMT_RECV[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.BALANCE_REMAINING_AMT[ll_insert_row] = inv_payment.Object.BALANCE_REMAINING_AMT[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.RECOVERED_ADDTL_AMT[ll_insert_row] = inv_payment.Object.RECOVERED_ADDTL_AMT[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.AMT_WRITEOFF[ll_insert_row] = inv_payment.Object.AMT_WRITEOFF[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.REFERRED_AMT[ll_insert_row] = inv_payment.Object.REFERRED_AMT[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.CUSTOM1_AMT[ll_insert_row] = inv_payment.Object.CUSTOM1_AMT[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.CUSTOM2_AMT[ll_insert_row] = inv_payment.Object.CUSTOM2_AMT[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.CUSTOM3_AMT[ll_insert_row] = inv_payment.Object.CUSTOM3_AMT[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.CUSTOM4_AMT[ll_insert_row] = inv_payment.Object.CUSTOM4_AMT[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.CUSTOM5_AMT[ll_insert_row] = inv_payment.Object.CUSTOM5_AMT[li_dsrow]  
				tab_track.tabpage_log.dw_log.Object.CUSTOM6_AMT[ll_insert_row] = inv_payment.Object.CUSTOM6_AMT[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.PAYMENT_AMT[ll_insert_row] = inv_payment.Object.PAYMENT_AMT[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.DATE_REV[ll_insert_row] = inv_payment.Object.DATE_REV[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.CASE_ID[ll_insert_row] = inv_payment.Object.CASE_ID[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.CASE_SPL[ll_insert_row] = inv_payment.Object.CASE_SPL[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.CASE_VER[ll_insert_row] = inv_payment.Object.CASE_VER[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.TRK_TYPE[ll_insert_row] = inv_payment.Object.TRK_TYPE[li_dsrow]   
				tab_track.tabpage_log.dw_log.Object.TRK_KEY[ll_insert_row] =  inv_payment.Object.TRK_KEY[li_dsrow]
				tab_track.tabpage_log.dw_log.Object.CHECK_NO[ll_insert_row] =  inv_payment.Object.CHECK_NO[li_dsrow]
				tab_track.tabpage_log.dw_log.Object.PAYMENT_TYPE[ll_insert_row] =  inv_payment.Object.PAYMENT_TYPE[li_dsrow]
				tab_track.tabpage_log.dw_log.Object.TARGET_ID[ll_insert_row] =  inv_payment.Object.TARGET_ID[li_dsrow]
				li_dsrow = li_dsrow + 1
			loop while li_dsrow < li_maxrow
			if (string(tab_track.tabpage_log.dw_log.Object.STATUS[ll_insert_row]) <> string(tab_track.tabpage_current.dw_current.Object.STATUS[ll_current_row])) OR &
				(string(tab_track.tabpage_log.dw_log.Object.DISP[ll_insert_row]) <> string(tab_track.tabpage_current.dw_current.Object.DISP[ll_current_row])) OR &
				(tab_track.tabpage_log.dw_log.Object.OP_AMT[ll_insert_row] <> tab_track.tabpage_savings.dw_savings.Object.OP_AMT[ll_current_row]) then
				lb_extra_row = true	
			else
				lb_extra_row = false
			end if
		end if 
		if (lb_extra_row) then
			ll_insert_row = tab_track.tabpage_log.dw_log.InsertRow(0)

			tab_track.tabpage_log.dw_log.Object.STATUS[ll_insert_row] = tab_track.tabpage_current.dw_current.Object.STATUS[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.DISP[ll_insert_row] =  tab_track.tabpage_current.dw_current.Object.DISP[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.STATUS_DESC[ll_insert_row] = tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row]   
			//10/14/2004 Katie Track 4054 Increment ld_logdate to allow log entries to sort properly
			ld_logdate = Datetime(Date(ld_logdate), RelativeTime(Time(ld_logdate), li_maxrow))
			tab_track.tabpage_log.dw_log.Object.STATUS_DATETIME[ll_insert_row] = ld_logdate 
			tab_track.tabpage_log.dw_log.Object.USER_ID[ll_insert_row] = gc_user_id 
			tab_track.tabpage_log.dw_log.Object.OP_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.OP_AMT[ll_current_row]    
			tab_track.tabpage_log.dw_log.Object.AMT_RECV[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.AMT_RECV[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.BALANCE_REMAINING_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.BALANCE_REMAINING_AMT[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.RECOVERED_ADDTL_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.RECOVERED_ADDTL_AMT[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.AMT_WRITEOFF[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.AMT_WRITEOFF[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.REFERRED_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.REFERRED_AMT[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.CUSTOM1_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.CUSTOM1_AMT[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.CUSTOM2_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.CUSTOM2_AMT[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.CUSTOM3_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.CUSTOM3_AMT[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.CUSTOM4_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.CUSTOM4_AMT[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.CUSTOM5_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.CUSTOM5_AMT[ll_current_row]  
			tab_track.tabpage_log.dw_log.Object.CUSTOM6_AMT[ll_insert_row] = tab_track.tabpage_savings.dw_savings.Object.CUSTOM6_AMT[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.CASE_ID[ll_insert_row] = tab_track.tabpage_general.dw_general.Object.CASE_ID[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.CASE_SPL[ll_insert_row] = tab_track.tabpage_general.dw_general.Object.CASE_SPL[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.CASE_VER[ll_insert_row] = tab_track.tabpage_general.dw_general.Object.CASE_VER[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.TRK_TYPE[ll_insert_row] = tab_track.tabpage_general.dw_general.Object.TRK_TYPE[ll_current_row]   
			tab_track.tabpage_log.dw_log.Object.TRK_KEY[ll_insert_row] =  tab_track.tabpage_general.dw_general.Object.TRK_KEY[ll_current_row]
			tab_track.tabpage_log.dw_log.Object.TARGET_ID[ll_insert_row] =  tab_track.tabpage_general.dw_general.Object.TARGET_ID[ll_current_row]
		end if
End If

//Katie 09/27/04 Track 4054 Reset payment fields.
tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row] = 0	
tab_track.tabpage_savings.dw_savings.Object.check_no [ll_current_row] = ''
tab_track.tabpage_savings.dw_savings.SetColumn("date_rev")
tab_track.tabpage_savings.dw_savings.Settext("")
tab_track.tabpage_savings.dw_savings.Accepttext()
tab_track.tabpage_savings.dw_savings.SetItemStatus ( ll_current_row, "date_rev", Primary!, NotModified!)
tab_track.tabpage_savings.dw_savings.SetItemStatus ( ll_current_row, "payment_amt", Primary!, NotModified!)

// Remove decoding in Log
li_cols = Long( tab_track.tabpage_log.dw_log.Describe( "datawindow.column.count" ) )
FOR li_ctr = 1 TO li_cols
	ls_db_col = tab_track.tabpage_log.dw_log.Describe( "#" + String( li_ctr ) + ".Name" )
	lnv_decode.of_remove_desc( tab_track.tabpage_log.dw_log, ls_db_col )
NEXT

Return 0
end event

event ue_open_rmm;//*********************************************************************************
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
// 10/21/99 AJS	Created
//
//*********************************************************************************
Integer li_tab

li_tab = tab_track.selectedtab

choose case li_tab
	case ii_tp_general
		If IsValid(im_general) Then im_general.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_current
		If IsValid(im_current) Then im_current.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_savings
		If IsValid(im_savings) Then im_savings.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
	case ii_tp_log
		If IsValid(im_log) Then im_log.m_menu.popmenu (This.pointerx() + 5, This.pointery() + 20)
end choose

end event

type dw_case from u_dw within w_track_maint
boolean visible = false
string accessiblename = "Case General"
string accessibledescription = "Case General"
accessiblerole accessiblerole = clientrole!
integer x = 704
integer y = 1340
integer width = 293
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_case_general"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;
This.SetTransObject (Stars2ca)

// DataWindow is not updateable
This.of_SetUpdateable (TRUE)

end event

type dw_case_track from u_dw within w_track_maint
boolean visible = false
string accessiblename = "Track Information"
string accessibledescription = "Track Information"
accessiblerole accessiblerole = clientrole!
integer x = 1609
integer y = 1336
integer width = 233
integer height = 80
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_track_info"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;
This.SetTransObject (Stars2ca)

//	This is the updateable datawindow
idw_update	=	This

end event

type dw_track_headings from u_dw within w_track_maint
string accessiblename = "Track Headings"
string accessibledescription = "Track Headings"
accessiblerole accessiblerole = clientrole!
integer x = 27
integer y = 16
integer width = 3602
integer taborder = 20
string dataobject = "d_track_headings"
boolean border = false
end type

event constructor;call super::constructor;// JasonS 10/29/04 Track 3573 Case/Track Headings
This.insertrow(0)

end event

type tab_track from tab within w_track_maint
string accessiblename = "Case Track Tab"
string accessibledescription = "Case Track Tab"
accessiblerole accessiblerole = clientrole!
event rbuttonup pbm_rbuttonup
integer x = 5
integer y = 388
integer width = 3634
integer height = 1804
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
tabpage_log tabpage_log
end type

on tab_track.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_current)
destroy(this.tabpage_savings)
destroy(this.tabpage_log)
end on

event selectionchanged;if oldindex = ii_tp_savings then
	tab_track.tabpage_savings.dw_savings.AcceptText()
end if
CHOOSE CASE newindex

CASE ii_tp_general
	Parent.of_SetPrintDW(tab_track.tabpage_general.dw_general)

CASE ii_tp_current
	Parent.of_SetPrintDW(tab_track.tabpage_current.dw_current)

CASE ii_tp_savings
	Parent.of_SetPrintDW(tab_track.tabpage_savings.dw_savings)
	
CASE ii_tp_log
	Parent.of_SetPrintDW(tab_track.tabpage_log.dw_log)

END CHOOSE

//Parent.Event ue_update_balance()

Int num_tabs, tabs, i

num_tabs = upperbound(tab_track.Control[])
tabs = upperbound(tab_track.Control[])
for i = tabs to 1 step -1
	if tab_track.Control[i].enabled = TRUE then
		num_tabs = i
		exit
	end if
next
end event

on tab_track.create
this.tabpage_general=create tabpage_general
this.tabpage_current=create tabpage_current
this.tabpage_savings=create tabpage_savings
this.tabpage_log=create tabpage_log
this.Control[]={this.tabpage_general,&
this.tabpage_current,&
this.tabpage_savings,&
this.tabpage_log}
end on

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
// 10/22/99 AJS	Created
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
// 10/22/99 AJS	Created
//
//	Note: Whenever rbuttonup is used, always Return 1 to prevent the windows
//			Cut/Copy/Paste RMM from displaying
//
//*********************************************************************************
Parent.Post Event ue_open_rmm()

Return 1
end event

type tabpage_general from userobject within tab_track
long textcolor = 33554432
string accessiblename = "General"
string accessibledescription = "General"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3598
integer height = 1688
long backcolor = 67108864
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_close_general cb_close_general
cb_next_general cb_next_general
cb_next_track_general cb_next_track_general
cb_prev_track_general cb_prev_track_general
dw_general dw_general
end type

on tabpage_general.create
this.cb_close_general=create cb_close_general
this.cb_next_general=create cb_next_general
this.cb_next_track_general=create cb_next_track_general
this.cb_prev_track_general=create cb_prev_track_general
this.dw_general=create dw_general
this.Control[]={this.cb_close_general,&
this.cb_next_general,&
this.cb_next_track_general,&
this.cb_prev_track_general,&
this.dw_general}
end on

on tabpage_general.destroy
destroy(this.cb_close_general)
destroy(this.cb_next_general)
destroy(this.cb_next_track_general)
destroy(this.cb_prev_track_general)
destroy(this.dw_general)
end on

type cb_close_general from u_cb within tabpage_general
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3186
integer y = 1548
integer width = 357
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name: close_general	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event close the track detail window. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
w_master	lw_parent
Integer		li_rc

li_rc = This.of_GetParentWindow(lw_parent)
Close (lw_parent)
end event

type cb_next_general from u_cb within tabpage_general
string accessiblename = "Next"
string accessibledescription = "Next"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2816
integer y = 1548
integer width = 357
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "&Next"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will scroll forward one tab. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event	ue_scroll_tab(tab_track,+1)
end event

type cb_next_track_general from u_cb within tabpage_general
string accessiblename = "Next Track"
string accessibledescription = "Next Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 448
integer y = 1548
integer width = 357
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "N&ext Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next_track	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll forward one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll forward one row
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(+1)

end event

type cb_prev_track_general from u_cb within tabpage_general
string accessiblename = "Prev Track"
string accessibledescription = "Prev Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 73
integer y = 1548
integer width = 357
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "P&rev Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev_track
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll back one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back one track record
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(-1)

end event

type dw_general from u_dw within tabpage_general
string accessiblename = "Track General"
string accessibledescription = "Track General"
accessiblerole accessiblerole = clientrole!
integer x = 69
integer y = 84
integer width = 3991
integer height = 864
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_track_general"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
// This datawindow will not update the database
This.of_SetUpdateable (FALSE)

// Perform the update at the same time the delete occurs
This.of_SetSingleRow (TRUE)

end event

type tabpage_current from userobject within tab_track
long textcolor = 33554432
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3598
integer height = 1688
long backcolor = 67108864
string text = "Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_tabpage_rmm_current uo_tabpage_rmm_current
cb_close_current cb_close_current
cb_next_current cb_next_current
cb_prev_current cb_prev_current
cb_next_track_current cb_next_track_current
cb_prev_track_current cb_prev_track_current
dw_current dw_current
end type

on tabpage_current.create
this.uo_tabpage_rmm_current=create uo_tabpage_rmm_current
this.cb_close_current=create cb_close_current
this.cb_next_current=create cb_next_current
this.cb_prev_current=create cb_prev_current
this.cb_next_track_current=create cb_next_track_current
this.cb_prev_track_current=create cb_prev_track_current
this.dw_current=create dw_current
this.Control[]={this.uo_tabpage_rmm_current,&
this.cb_close_current,&
this.cb_next_current,&
this.cb_prev_current,&
this.cb_next_track_current,&
this.cb_prev_track_current,&
this.dw_current}
end on

on tabpage_current.destroy
destroy(this.uo_tabpage_rmm_current)
destroy(this.cb_close_current)
destroy(this.cb_next_current)
destroy(this.cb_prev_current)
destroy(this.cb_next_track_current)
destroy(this.cb_prev_track_current)
destroy(this.dw_current)
end on

type uo_tabpage_rmm_current from uo_tabpage_rmm within tabpage_current
string accessiblename = "Case Status Tab Page"
string accessibledescription = "Case Status Tab Page"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
integer x = 9
integer y = 4
integer width = 3479
integer height = 1672
boolean bringtotop = true
end type

on uo_tabpage_rmm_current.destroy
call uo_tabpage_rmm::destroy
end on

type cb_close_current from u_cb within tabpage_current
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3186
integer y = 1548
integer width = 357
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name: close_general	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event close the track detail window. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
Close (lw_parent)
end event

type cb_next_current from u_cb within tabpage_current
string accessiblename = "Next"
string accessibledescription = "Next"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2816
integer y = 1548
integer width = 357
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Next"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will scroll forward one tab. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event	ue_scroll_tab(tab_track,+1)
end event

type cb_prev_current from u_cb within tabpage_current
string accessiblename = "Prev"
string accessibledescription = "Prev"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2446
integer y = 1548
integer width = 357
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Prev"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will scroll back one tab. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************

//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event	ue_scroll_tab(tab_track,-1)

end event

type cb_next_track_current from u_cb within tabpage_current
string accessiblename = "Next Track"
string accessibledescription = "Next Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 453
integer y = 1548
integer width = 357
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "N&ext Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next_track	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll forward one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll forward one row
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(+1)

end event

type cb_prev_track_current from u_cb within tabpage_current
string accessiblename = "Prev Track"
string accessibledescription = "Prev Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 78
integer y = 1548
integer width = 357
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "P&rev Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev_track
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll back one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back one track record
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(-1)

end event

type dw_current from u_dw within tabpage_current
string accessiblename = "Track Current"
string accessibledescription = "Track Current"
accessiblerole accessiblerole = clientrole!
integer x = 41
integer y = 132
integer width = 4361
integer height = 944
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_track_current"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)

end event

event itemchanged;w_master	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event Dynamic ue_edits(row, dwo, data)

end event

type tabpage_savings from userobject within tab_track
long textcolor = 33554432
string accessiblename = "Financial Data"
string accessibledescription = "Financial Data"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3598
integer height = 1688
long backcolor = 67108864
string text = "Financial Data"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_prev_track_savings cb_prev_track_savings
cb_next_track_savings cb_next_track_savings
cb_prev_savings cb_prev_savings
cb_next_savings cb_next_savings
cb_close_savings cb_close_savings
dw_savings dw_savings
end type

on tabpage_savings.create
this.cb_prev_track_savings=create cb_prev_track_savings
this.cb_next_track_savings=create cb_next_track_savings
this.cb_prev_savings=create cb_prev_savings
this.cb_next_savings=create cb_next_savings
this.cb_close_savings=create cb_close_savings
this.dw_savings=create dw_savings
this.Control[]={this.cb_prev_track_savings,&
this.cb_next_track_savings,&
this.cb_prev_savings,&
this.cb_next_savings,&
this.cb_close_savings,&
this.dw_savings}
end on

on tabpage_savings.destroy
destroy(this.cb_prev_track_savings)
destroy(this.cb_next_track_savings)
destroy(this.cb_prev_savings)
destroy(this.cb_next_savings)
destroy(this.cb_close_savings)
destroy(this.dw_savings)
end on

type cb_prev_track_savings from u_cb within tabpage_savings
string accessiblename = "Prev Track"
string accessibledescription = "Prev Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 78
integer y = 1548
integer width = 357
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "P&rev Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev_track
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll back one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back one track record
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(-1)

end event

type cb_next_track_savings from u_cb within tabpage_savings
string accessiblename = "Next Track"
string accessibledescription = "Next Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 453
integer y = 1548
integer width = 357
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "N&ext Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next_track	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll forward one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll forward one row
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(+1)

end event

type cb_prev_savings from u_cb within tabpage_savings
string accessiblename = "Prev"
string accessibledescription = "Prev"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2441
integer y = 1548
integer width = 357
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "&Prev"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will scroll back one tab. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************

//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event	ue_scroll_tab(tab_track,-1)

end event

type cb_next_savings from u_cb within tabpage_savings
string accessiblename = "Next"
string accessibledescription = "Next"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2811
integer y = 1548
integer width = 357
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "&Next"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will scroll forward one tab. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event	ue_scroll_tab(tab_track,+1)
end event

type cb_close_savings from u_cb within tabpage_savings
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3182
integer y = 1548
integer width = 357
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name: close_savings
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event close the track detail window. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
w_master	lw_parent
Integer		li_rc

li_rc = This.of_GetParentWindow(lw_parent)
Close (lw_parent)
end event

type dw_savings from u_dw within tabpage_savings
string accessiblename = "Track Savings"
string accessibledescription = "Track Savings"
accessiblerole accessiblerole = clientrole!
integer x = 14
integer width = 4352
integer height = 1480
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_track_savings"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateable (FALSE)
end event

event itemchanged;w_master	lw_parent
Integer		li_rc
li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event Dynamic ue_edits(row, dwo, data)


end event

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////
//
//	10/14/04	Katie	Track 4054 Added code to determine if the Apply button was clicked.
//				If Apply was clicked the payment data is verified then applied to the data store
//				and the screen values are reset.
//	12/29/04	Katie Track 4189 Reset update on three tabpages because changes already saved in 
//				payment entries into the log.
//	01/04/05	Katie	Track 4211d Removed resetupdates added for Track 4189 and added AccepText for remaining
//				data windows.
//	08/31/05	GaryR	Track 4501d	PB10 bug - use blank to set date to 00/00/0000
//
///////////////////////////////////////////////////////////////////////////////////////////////////

tab_track.tabpage_savings.dw_savings.accepttext( )
tab_track.tabpage_current.dw_current.accepttext( )
tab_track.tabpage_general.dw_general.accepttext( )
if (dwo.Name = 'b_apply') then
	if (dwo.text = 'Apply') then
		Integer	li_rc
		string 	ls_columnname, ls_column_verbiage, ls_invoice_type, ls_column, ls_desc 
		long 		ll_insert_row,ll_current_row

		n_cst_datetime lnvo_cst_datetime
		boolean lb_valid_date
		
		ll_current_row = dw_case_track.GetRow ()
	
		decimal ldc_pay_amt
		decimal ldc_bal_remain
		decimal ldc_op_amt
		decimal ldc_amt_recv
		decimal ldc_amt_writeoff
		decimal ldc_recovered_addtl_amt
		decimal ldc_referred_amt
		decimal ldc_custom1_amt
		decimal ldc_custom2_amt
		decimal ldc_custom3_amt
		decimal ldc_custom4_amt
		decimal ldc_custom5_amt
		decimal ldc_custom6_amt
		string ls_labelname, ls_status_desc

		ldc_pay_amt = tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row]
		
		if 	IsNull(ldc_pay_amt) or ldc_pay_amt = 0 then
			Messagebox("EDIT","Please enter a payment amount.")
			tab_track.SelectTab("tabpage_savings")
			tab_track.tabpage_savings.dw_savings.SetColumn("payment_amt")
			tab_track.tabpage_savings.dw_savings.SetFocus()
			return 0
		end if
		
		ls_labelname = tab_track.tabpage_savings.dw_savings.Object.payment_type[ll_current_row] 
		
		if 	IsNull(trim(ls_labelname)) or trim(ls_labelname) = "" then
			Messagebox("EDIT","Please select an 'Apply to' field.")
			tab_track.SelectTab("tabpage_savings")
			tab_track.tabpage_savings.dw_savings.SetColumn("payment_type")
			tab_track.tabpage_savings.dw_savings.SetFocus()
			return 0
		end if
		
		lb_valid_date = lnvo_cst_datetime.of_isvalid(date(tab_track.tabpage_savings.dw_savings.Object.date_rev[ll_current_row]))
		if 	lb_valid_date then
			//continue
		elseif IsNull(tab_track.tabpage_savings.dw_savings.Object.date_rev[ll_current_row]) and &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "payment_amt", Primary!) = NotModified!)	then
				tab_track.tabpage_savings.dw_savings.Object.date_rev[ll_current_row] = date('01/01/1900')
		else
			Messagebox("EDIT","Please enter a valid Effective Date.")
			tab_track.SelectTab("tabpage_savings")
			tab_track.tabpage_savings.dw_savings.SetColumn("date_rev")
			tab_track.tabpage_savings.dw_savings.SetFocus()
			return 0
		end if
		
		if (tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row] < 0) = true then
			if (MessageBox('Payment Amount', 'You have entered a negative payment amount.  Do you wish to continue?', &
				StopSign!, YesNo!) = 2) then
					tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row] = 0
					tab_track.tabpage_savings.dw_savings.SetItemStatus(ll_current_row, 'payment_amt', Primary!, NotModified!)
					tab_track.tabpage_savings.dw_savings.SetReDraw(true)
					Return -1
			end if
		end if

		tab_track.tabpage_current.dw_current.Object.status_datetime[ll_current_row] = gnv_app.of_get_server_date_time()
		ldc_op_amt = tab_track.tabpage_savings.dw_savings.Object.op_amt [ll_current_row]
		ldc_amt_recv = tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row]
		ldc_amt_writeoff = tab_track.tabpage_savings.dw_savings.Object.amt_writeoff [ll_current_row]
		ldc_recovered_addtl_amt = tab_track.tabpage_savings.dw_savings.Object.recovered_addtl_amt [ll_current_row]
		ldc_referred_amt = tab_track.tabpage_savings.dw_savings.Object.referred_amt [ll_current_row]
		ldc_custom1_amt = tab_track.tabpage_savings.dw_savings.Object.custom1_amt [ll_current_row]
		ldc_custom2_amt = tab_track.tabpage_savings.dw_savings.Object.custom2_amt [ll_current_row]
		ldc_custom3_amt = tab_track.tabpage_savings.dw_savings.Object.custom3_amt [ll_current_row]
		ldc_custom4_amt = tab_track.tabpage_savings.dw_savings.Object.custom4_amt [ll_current_row]
		ldc_custom5_amt = tab_track.tabpage_savings.dw_savings.Object.custom5_amt [ll_current_row]
		ldc_custom6_amt = tab_track.tabpage_savings.dw_savings.Object.custom6_amt [ll_current_row]

		if Isnull(ldc_pay_amt) then
				ldc_pay_amt = 0
		end if
		
		If Isnull(ldc_op_amt) then
				ldc_op_amt = 0
		End If

		choose case UPPER(ls_labelname)
			case UPPER("AMT_RECV")
				ldc_amt_recv = ldc_amt_recv + ldc_pay_amt
				ldc_bal_remain = ldc_op_amt - ldc_amt_recv - ldc_amt_writeoff
				tab_track.tabpage_savings.dw_savings.Object.amt_recv [ll_current_row] = ldc_amt_recv 
				tab_track.tabpage_savings.dw_savings.Object.balance_remaining_amt [ll_current_row] = ldc_bal_remain
			case UPPER("AMT_WRITEOFF")
				ldc_amt_writeoff = ldc_amt_writeoff + ldc_pay_amt
				ldc_bal_remain = ldc_op_amt - ldc_amt_recv - ldc_amt_writeoff
				tab_track.tabpage_savings.dw_savings.Object.amt_writeoff [ll_current_row] = ldc_amt_writeoff 
				tab_track.tabpage_savings.dw_savings.Object.balance_remaining_amt [ll_current_row] = ldc_bal_remain
			case UPPER("RECOVERED_ADDTL_AMT")
				ldc_recovered_addtl_amt = ldc_recovered_addtl_amt + ldc_pay_amt
				tab_track.tabpage_savings.dw_savings.Object.recovered_addtl_amt [ll_current_row] = ldc_recovered_addtl_amt 
			case UPPER("REFERRED_AMT")
				ldc_referred_amt = ldc_referred_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.referred_amt [ll_current_row] = ldc_referred_amt
			case UPPER("CUSTOM1_AMT")
				ldc_custom1_amt = ldc_custom1_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.custom1_amt [ll_current_row] = ldc_custom1_amt
			case UPPER('CUSTOM2_AMT')
				ldc_custom2_amt = ldc_custom2_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.custom2_amt [ll_current_row] = ldc_custom2_amt
			case UPPER('CUSTOM3_AMT')
				ldc_custom3_amt = ldc_custom3_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.custom3_amt [ll_current_row] = ldc_custom3_amt
			case UPPER('CUSTOM4_AMT')
				ldc_custom4_amt = ldc_custom4_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.custom4_amt [ll_current_row] = ldc_custom4_amt
			case UPPER('CUSTOM5_AMT')
				ldc_custom5_amt = ldc_custom5_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.custom5_amt [ll_current_row] = ldc_custom5_amt
			case UPPER('CUSTOM6_AMT')
				ldc_custom6_amt = ldc_custom6_amt + ldc_pay_amt 
				tab_track.tabpage_savings.dw_savings.Object.custom6_amt [ll_current_row] = ldc_custom6_amt
		end choose
		
		w_master	lw_parent
		li_rc = This.of_GetParentWindow(lw_parent)

		If (tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "op_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "amt_recv", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "balance_remaining_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "recovered_addtl_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "amt_writeoff", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "referred_amt", Primary!) = DataModified!)  OR & 
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "custom1_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "custom2_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "custom3_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "custom4_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "custom5_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "custom6_amt", Primary!) = DataModified!)  OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "payment_amt", Primary!) = DataModified!)	OR &
			(tab_track.tabpage_savings.dw_savings.GetItemStatus(ll_current_row, "date_rev", Primary!) = DataModified!)	then
				// 01/09/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
				ls_status_desc	=	tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row]
				IF Trim( tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row] ) = "" THEN
					//tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row] = " "
					li_rc	=	gnv_sql.of_TrimData (ls_status_desc)
					tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row]	=	ls_status_desc
				END IF
				
				ll_insert_row = inv_payment.InsertRow(0)
				
				inv_payment.SetItem(ll_insert_row, "STATUS", tab_track.tabpage_current.dw_current.Object.STATUS[ll_current_row])  
				inv_payment.SetItem(ll_insert_row, "DISP", tab_track.tabpage_current.dw_current.Object.DISP[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "STATUS_DESC",tab_track.tabpage_current.dw_current.Object.STATUS_DESC[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "STATUS_DATETIME", gnv_app.of_get_server_date_time())
				inv_payment.SetItem(ll_insert_row, "USER_ID", gc_user_id)
				inv_payment.SetItem(ll_insert_row, "OP_AMT",tab_track.tabpage_savings.dw_savings.Object.OP_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "AMT_RECV",tab_track.tabpage_savings.dw_savings.Object.AMT_RECV[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "BALANCE_REMAINING_AMT",tab_track.tabpage_savings.dw_savings.Object.BALANCE_REMAINING_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "RECOVERED_ADDTL_AMT",tab_track.tabpage_savings.dw_savings.Object.RECOVERED_ADDTL_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "AMT_WRITEOFF",tab_track.tabpage_savings.dw_savings.Object.AMT_WRITEOFF[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "REFERRED_AMT",tab_track.tabpage_savings.dw_savings.Object.REFERRED_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CUSTOM1_AMT",tab_track.tabpage_savings.dw_savings.Object.CUSTOM1_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CUSTOM2_AMT",tab_track.tabpage_savings.dw_savings.Object.CUSTOM2_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CUSTOM3_AMT",tab_track.tabpage_savings.dw_savings.Object.CUSTOM3_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CUSTOM4_AMT",tab_track.tabpage_savings.dw_savings.Object.CUSTOM4_AMT[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CUSTOM5_AMT",tab_track.tabpage_savings.dw_savings.Object.CUSTOM5_AMT[ll_current_row])  
				inv_payment.SetItem(ll_insert_row, "CUSTOM6_AMT",tab_track.tabpage_savings.dw_savings.Object.CUSTOM6_AMT[ll_current_row])   
				inv_payment.SetItem(ll_insert_row, "PAYMENT_AMT",tab_track.tabpage_savings.dw_savings.Object.PAYMENT_AMT[ll_current_row])   
				inv_payment.SetItem(ll_insert_row, "DATE_REV",tab_track.tabpage_savings.dw_savings.Object.DATE_REV[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CASE_ID",tab_track.tabpage_general.dw_general.Object.CASE_ID[ll_current_row])   
				inv_payment.SetItem(ll_insert_row, "CASE_SPL",tab_track.tabpage_general.dw_general.Object.CASE_SPL[ll_current_row])   
				inv_payment.SetItem(ll_insert_row, "CASE_VER",tab_track.tabpage_general.dw_general.Object.CASE_VER[ll_current_row])   
				inv_payment.SetItem(ll_insert_row, "TRK_TYPE",tab_track.tabpage_general.dw_general.Object.TRK_TYPE[ll_current_row])   
				inv_payment.SetItem(ll_insert_row, "TRK_KEY",tab_track.tabpage_general.dw_general.Object.TRK_KEY[ll_current_row])
				inv_payment.SetItem(ll_insert_row, "CHECK_NO",tab_track.tabpage_general.dw_general.Object.CHECK_NO[ll_current_row])
				ls_invoice_type = gnv_dict.event ue_get_inv_type('TRACK')
				ls_column = tab_track.tabpage_general.dw_general.Object.PAYMENT_TYPE[ll_current_row]
				ls_desc = gnv_dict.event ue_get_col_desc( ls_invoice_type, ls_column)
				inv_payment.SetItem(ll_insert_row, "PAYMENT_TYPE",ls_desc)
				inv_payment.SetItem(ll_insert_row, "TARGET_ID",tab_track.tabpage_general.dw_general.Object.TARGET_ID[ll_current_row])
		End If
			
		tab_track.tabpage_savings.dw_savings.Object.payment_amt [ll_current_row] = 0	
		tab_track.tabpage_savings.dw_savings.Object.check_no [ll_current_row] = ''
		tab_track.tabpage_savings.dw_savings.SetColumn("date_rev")
		tab_track.tabpage_savings.dw_savings.Settext("")
		tab_track.tabpage_savings.dw_savings.Accepttext()

		tab_track.tabpage_current.dw_current.SetReDraw(true)
		tab_track.tabpage_savings.dw_savings.SetReDraw(true)
	end if
end if
return 0

end event

type tabpage_log from userobject within tab_track
long textcolor = 33554432
string accessiblename = "Log"
string accessibledescription = "Log"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 3598
integer height = 1688
long backcolor = 67108864
string text = "Log"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_tabpage_rmm_log uo_tabpage_rmm_log
dw_log dw_log
cb_prev_track_log cb_prev_track_log
cb_next_track_log cb_next_track_log
cb_prev_log cb_prev_log
cb_close_log cb_close_log
st_count st_count
end type

on tabpage_log.create
this.uo_tabpage_rmm_log=create uo_tabpage_rmm_log
this.dw_log=create dw_log
this.cb_prev_track_log=create cb_prev_track_log
this.cb_next_track_log=create cb_next_track_log
this.cb_prev_log=create cb_prev_log
this.cb_close_log=create cb_close_log
this.st_count=create st_count
this.Control[]={this.uo_tabpage_rmm_log,&
this.dw_log,&
this.cb_prev_track_log,&
this.cb_next_track_log,&
this.cb_prev_log,&
this.cb_close_log,&
this.st_count}
end on

on tabpage_log.destroy
destroy(this.uo_tabpage_rmm_log)
destroy(this.dw_log)
destroy(this.cb_prev_track_log)
destroy(this.cb_next_track_log)
destroy(this.cb_prev_log)
destroy(this.cb_close_log)
destroy(this.st_count)
end on

type uo_tabpage_rmm_log from uo_tabpage_rmm within tabpage_log
string accessiblename = "Case Log Tab Page"
string accessibledescription = "Case Log Tab Page"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
integer x = 9
integer y = 4
integer width = 3227
integer height = 1672
boolean bringtotop = true
end type

on uo_tabpage_rmm_log.destroy
call uo_tabpage_rmm::destroy
end on

type dw_log from u_dw within tabpage_log
string accessiblename = "Track Log"
string accessibledescription = "Track Log"
accessiblerole accessiblerole = clientrole!
integer x = 14
integer y = 24
integer width = 3557
integer height = 1492
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_track_log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;
This.SetTransObject (Stars2ca)

// Single select rows
This.of_SingleSelect (TRUE)

// DataWindow is not updateable
This.of_SetUpdateable (TRUE)

//	FDG	04/16/01	Stars 4.7.	Properly trim the data.
This.of_SetTrim (TRUE)

end event

event doubleclicked;call super::doubleclicked;//*********************************************************************************
// Script Name:	dw_track_log.DoubleClicked
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
// 11/4/04  JasonS	Track 3573 Enable windows ops on track log window
//
//*********************************************************************************

w_track_maint	lw_parent

Integer		li_rc

li_rc	=	This.of_GetParentWindow (lw_parent)
lw_parent.of_window_operations (This, row, dwo)


end event

type cb_prev_track_log from u_cb within tabpage_log
string accessiblename = "Prev Track"
string accessibledescription = "Prev Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 78
integer y = 1548
integer width = 357
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "P&rev Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev_track
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll back one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll back one track record
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(-1)

end event

type cb_next_track_log from u_cb within tabpage_log
string accessiblename = "Next Track"
string accessibledescription = "Next Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 453
integer y = 1548
integer width = 357
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "N&ext Track"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_next_track	
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will save the current track and scroll forward one record. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
//Scroll forward one row
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)

lw_parent.Event	ue_save()
lw_parent.Event	ue_scroll_tracks(+1)

end event

type cb_prev_log from u_cb within tabpage_log
string accessiblename = "Prev"
string accessibledescription = "Prev"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2811
integer y = 1548
integer width = 357
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Prev"
end type

event clicked;//*********************************************************************************
// Script Name: clicked for cb_prev
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event will scroll back one tab. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************

//Scroll back to tabs until an enabled tab is reached
//The first argument is the name of the tab to be scrolled
w_track_maint	lw_parent
Integer			li_rc

li_rc = This.of_GetParentWindow(lw_parent)
lw_parent.Event	ue_scroll_tab(tab_track,-1)

end event

type cb_close_log from u_cb within tabpage_log
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3182
integer y = 1548
integer width = 357
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name: close_savings
//
//	Arguments: none		
//						
//
// Returns:	none		
//
//	Description: This event close the track detail window. 	
//		
//
//*********************************************************************************
//	
// 09/29/99 AJS	Created Rls 4.5 TS2363
//
//*********************************************************************************
w_master	lw_parent
Integer		li_rc

li_rc = This.of_GetParentWindow(lw_parent)
Close (lw_parent)
end event

type st_count from statictext within tabpage_log
string accessiblename = "Case Log Count"
string accessibledescription = "Case Log Count"
accessiblerole accessiblerole = statictextrole!
integer x = 2107
integer y = 1548
integer width = 279
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

