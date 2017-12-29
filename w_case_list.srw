HA$PBExportHeader$w_case_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_list from w_master
end type
type dw_search from u_dw within w_case_list
end type
type st_dw_ops from statictext within w_case_list
end type
type ddlb_dw_ops from dropdownlistbox within w_case_list
end type
type cb_use from u_cb within w_case_list
end type
type cb_total from u_cb within w_case_list
end type
type cb_log from u_cb within w_case_list
end type
type cb_list from u_cb within w_case_list
end type
type cb_close from u_cb within w_case_list
end type
type cb_stop from u_cb within w_case_list
end type
type cb_select from u_cb within w_case_list
end type
type gb_1 from groupbox within w_case_list
end type
type dw_1 from u_dw within w_case_list
end type
type st_row_count from statictext within w_case_list
end type
end forward

global type w_case_list from w_master
string accessiblename = "Case List"
string accessibledescription = "Case List"
integer x = 169
integer y = 8
integer width = 3483
integer height = 1972
string title = "Case List"
event ue_list ( )
dw_search dw_search
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
cb_use cb_use
cb_total cb_total
cb_log cb_log
cb_list cb_list
cb_close cb_close
cb_stop cb_stop
cb_select cb_select
gb_1 gb_1
dw_1 dw_1
st_row_count st_row_count
end type
global w_case_list w_case_list

type variables
// Katie 01/11/05 Track 5431c Removed ib_allow_switch.
n_cst_case inv_case
int in_nbr_rows
int in_win_nbr
int in_sort_by
string in_from, in_sql
string in_dw_control
string in_tbl_type
string in_selected
W_case_count win1[ ]
Long in_dw_ht,in_dw_wt,in_dw_x,in_dw_y
w_uo_win iv_uo_win
string in_dept_code
long in_code_sec
string in_case_cat
sx_decode_structure in_decode_struct
long il_row_nbr //NLG 7-2-98
end variables

forward prototypes
public function int wf_sort_list ()
public function integer wf_goto_row1 ()
end prototypes

event ue_list();//*******************************************************************************************
//		Object Type:	CommandButton
//		Object Name:	w_case_list
//		Event Name:		ue_list
//
//*******************************************************************************************
//
//	NLG	08/31/99	Ts2363c. 
//						1)Copied and modified from cb_list.clicked()
//						2)Make sql more efficient by removing unnecessary 
//						'Likes' -- Check if field filled in, 
//						if not don't use in select.
//	FDG	04/06/99	Track 2848c. When the 'Use' button is enabled, filter out
//						closed and deleted cases.  Also, don't enable the Select
//						button.
//
// GR		04/17/00 Track 2192d  invalid row range fix
//	FDG	05/01/00	Track 2246d. If in debug mode, use f_debug_box instead
//						of MessageBox.  The window was hanging when in debug mode
//						and this window was used as a lookup.
// GaryR	01/04/01	Stars 4.7 DataBase Port - Date Conversion
//	FDG	02/09/01	Stars 4.6 - PIMR.  Include PIMR data in the select
//	GaryR	10/17/01	Stars 4.8.1	WIC Request to redesign screen.
// SAH   12/21/01 Stars 5.0   Request concatonation of case_id, spl and ver
//										and search on subject_id
// Lahu S 5/9/02 - Track 3053 added distinct to sql
// SAH   05/13/02 Track 2795  14-digit case_id returns cases with matching case_spl _ver, 
//										not just _ver
// MikeFl 5/20/02 Track 3081  Changed case_spl and ver code
// MikeFl 5/23/02 Track 3021  Changed the operands to use '=' rather than 'LIKE'
// JasonS 6/5/2002	Track 3123  Fixed the case type search, after selecting a case type and searching, then 
//											selecting no case type, search returned nothing.
// JasonS 6/18/02	Track 3063d  Change case status on referral
// JasonS 07/24/02 Track 3174d don't show 1/1/1900 for dates in case_list
// JasonS 09/04/02 Track 3069d Trim case_id and subject_id
//	GaryR	05/15/03	Track 3469d	Subject id is case-insensitive
//	GaryR	05/16/03	Track 3585d	Do not require reciept dates when searching for closed cases
//	GaryR	12/08/03	Track 3726d	Database error in Case Totals window when joining to CASE_LOG
//******************************************************************************************

//	GaryR	10/17/01	Stars 4.8.1 - Begin
boolean lv_nothing_found
int rc,lv_range
int li_idx1,li_idx2
int li_pos
long lv_nbr_rows, sqldbrc, lv_new_row
long ll_x
string lv_case_id, lv_case_spl, lv_case_ver, lv_user_id, lv_dept_id
string lv_case_business, lv_case_cat, lv_case_type,lv_business
string lv_case_status, lv_case_disp, lv_asgn_id
string ls_where, ls_select, ls_from, ls_sql, ls_sub_id
string sql_array[3,13]   //SAH Expand array to handle subject_id
string ls_msg
string ls_case_cat
string ls_from_period,ls_to_period
string ls_case_status, ls_and

String				ls_from_date_received, ls_to_date_received,	&
						ls_from_date_closed, ls_to_date_closed
n_cst_datetime		lnv_datetime
//	GaryR	10/17/01	Stars 4.8.1 - End

setpointer(hourglass!) 
SetMicroHelp(W_Main,'Listing All Cases Based On Selection Criteria')	

in_sql = ''
in_nbr_rows = 0
st_row_count.text = ''

//DJP 2/6/96 prob#136 - reset the dw filter
dw_1.setfilter('')

//	GaryR	10/17/01	Stars 4.8.1 - Begin
IF dw_search.AcceptText() <> 1 THEN Return

ls_from_date_closed = String( dw_search.GetItemDate( 1, "from_date_closed" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_from_date_closed ) AND Trim( ls_from_date_closed ) <> "" THEN
	rc		=	lnv_datetime.of_IsValidDate (ls_from_date_closed)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_closed" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_closed" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_closed" )
			Return
	END CHOOSE
ELSE
	ls_from_date_closed = ""
END IF

ls_to_date_closed = String( dw_search.GetItemDate( 1, "to_date_closed" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_to_date_closed ) AND Trim( ls_to_date_closed ) <> "" THEN
	rc		=	lnv_datetime.of_IsValidDate (ls_to_date_closed)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_closed" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_closed" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_closed" )
			Return
	END CHOOSE
	IF ls_from_date_closed = "" THEN
		MessageBox ('Error', 'Please enter a valid from date for the closed period')
		dw_search.SetFocus()
		dw_search.SetColumn( "from_date_closed" )
		Return
	ELSE
		IF Date( ls_to_date_closed ) < Date( ls_from_date_closed ) THEN
			MessageBox ('Error', 'from date for the closed period should be less than the thru date')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_closed" )
			Return
		END IF
	END IF
ELSE
	IF ls_from_date_closed <> "" THEN
		MessageBox ('Error', 'Please enter a valid thru date for the closed period')
		dw_search.SetFocus()
		dw_search.SetColumn( "to_date_closed" )
		Return
	END IF
	ls_to_date_closed = ""
END IF

ls_from_date_received = String( dw_search.GetItemDate( 1, "from_date_received" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_from_date_received ) AND Trim( ls_from_date_received ) <> "" THEN
	rc		=	lnv_datetime.of_IsValidDate (ls_from_date_received)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
	END CHOOSE
ELSE
	IF ls_from_date_closed = "" THEN
		MessageBox ('Error', 'Please enter a valid from date for the receipt period')
		dw_search.SetFocus()
		dw_search.SetColumn( "from_date_received" )
		Return
	ELSE
		ls_from_date_received = ""
	END IF
END IF

ls_to_date_received = String( dw_search.GetItemDate( 1, "to_date_received" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_to_date_received ) AND Trim( ls_to_date_received ) <> "" THEN
	rc		=	lnv_datetime.of_IsValidDate (ls_to_date_received)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
	END CHOOSE
	IF Date( ls_to_date_received ) < Date( ls_from_date_received ) THEN
		MessageBox ('Error', 'from date for the receipt period should be less than the thru date')
		dw_search.SetFocus()
		dw_search.SetColumn( "from_date_received" )
		Return
	END IF
ELSE
	IF ls_from_date_closed = "" OR ls_from_date_received <> "" THEN
		MessageBox ('Error', 'Please enter a valid thru date for the receipt period')
		dw_search.SetFocus()
		dw_search.SetColumn( "to_date_received" )
		Return
	ELSE
		ls_to_date_received = ""
	END IF
END IF

ls_from_period = String( dw_search.GetItemDate( 1, "from_period" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_from_period ) AND Trim( ls_from_period ) <> "" THEN
	rc		=	lnv_datetime.of_IsValidDate (ls_from_period)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_period" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_period" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "from_period" )
			Return
	END CHOOSE
ELSE
	ls_from_period = ""
END IF

ls_to_period = String( dw_search.GetItemDate( 1, "to_period" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_to_period ) AND Trim( ls_to_period ) <> "" THEN
	rc		=	lnv_datetime.of_IsValidDate (ls_to_period)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_period" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_period" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "to_period" )
			Return
	END CHOOSE
ELSE
	ls_to_period = ""
END IF

//lv_case_business = trim(left(ddlb_business.text,2))
lv_case_business = dw_search.GetItemString( 1, "business" )
//if len(lv_case_business) > 0 then lv_case_business = lv_case_business + '%'		MikeFl 5/23/02 - Track 3021

//lv_case_type = left(ddlb_case_type.text,2)
lv_case_type = trim(left( dw_search.GetItemString( 1, "case_type" ), 2 ))	// MikeFl 5/23/02 - Track 3021
//lv_case_type = left( dw_search.GetItemString( 1, "case_type" ), 2 )		// MikeFl 5/23/02 - Track 3021
// Begin - Track 3123  the len function is not returning a correct value due to the left function
//							  trim the output to get the correct count, it was still placing the % in the query 
//							  even though the field is no longer being used
//if len(trim(lv_case_type)) > 0 then lv_case_type = lv_case_type + '%'
//if len(trim(lv_case_type)) > 0 then lv_case_type = lv_case_type + '%' 		MikeFl 5/23/02 - Track 3021
// End - Track 3123

//lv_case_cat = left(ddlb_case_cat.text,3)
lv_case_cat = dw_search.GetItemString( 1, "case_cat" )
//if len(lv_case_cat) > 0 then lv_case_cat = lv_case_cat + '%'						MikeFl 5/23/02 - Track 3021

//lv_case_status = sle_status.text
lv_case_status = dw_search.GetItemString( 1, "status" )
//if len(lv_case_status) > 0 then lv_case_status = lv_case_status + '%'			MikeFl 5/23/02 - Track 3021

//lv_case_disp   = sle_disposition.text
lv_case_disp = dw_search.GetItemString( 1, "disposition" )
//if len(lv_case_disp) > 0 then lv_case_disp = lv_case_disp + '%'					MikeFl 5/23/02 - Track 3021

String lv_case_id_spl_ver

// MikeFl - 5/21/2002 - Track 3081 - Begin
// JasonS 09/04/02 Begin - Track 3069d - trim case_id
//lv_case_id_spl_ver = dw_search.GetItemString( 1, "case_id" )
lv_case_id_spl_ver = trim(dw_search.GetItemString( 1, "case_id" ))
// JasonS 09/04/02 End - Track 3069d - trim case_id
lv_case_id = Left(lv_case_id_spl_ver, 10)
IF len(lv_case_id) > 0 THEN 
	lv_case_id = lv_case_id + '%'
END IF

IF Len(lv_case_id_spl_ver) > 10 THEN
   lv_case_spl = trim(Mid(lv_case_id_spl_ver, 11, 2)) + '%'
//	IF Len(lv_case_spl) > 0 THEN lv_case_spl = lv_case_spl + '%' 
END IF

IF Len(lv_case_id_spl_ver) > 12 THEN
   lv_case_ver = trim(Mid(lv_case_id_spl_ver, 13, 2)) + '%'
// lv_case_ver = Mid(lv_case_ver, 13, 2) 
//	IF Len(lv_case_ver) > 0 THEN lv_case_ver = lv_case_ver + '%'
END IF
// MikeFl - 5/21/2002 - Track 3081 - End

// JasonS 09/04/02 Begin - Track 3069d - trim subject id
//ls_sub_id = dw_search.GetItemString( 1, "pmr_subject_id")
ls_sub_id = trim(dw_search.GetItemString( 1, "pmr_subject_id"))
// JasonS 09/04/02 Begin - Track 3069d - trim subject id
IF Len(ls_sub_id) > 0 THEN ls_sub_id = ls_sub_id + '%'

// SAH 12/21/01 end

//lv_dept_id     = sle_dept_id.text
lv_dept_id = dw_search.GetItemString( 1, "dept_id" )
//if len(lv_dept_id) > 0 then lv_dept_id = lv_dept_id + '%'			MikeFl 5/23/02 - Track 3021

//lv_asgn_id     = sle_asgn_id.text
lv_asgn_id = dw_search.GetItemString( 1, "asgn_id" )
//if len(lv_asgn_id) > 0 then lv_asgn_id = lv_asgn_id + '%'			MikeFl 5/23/02 - Track 3021

Reset(DW_1)

rc = SetTransObject(DW_1,stars2ca)
if rc = -1 Then
	errorbox(stars2ca,'Error connecting to the datawindow')
	return
end if

sql_array[1,1]  = lv_dept_id
sql_array[1,2]  = lv_case_id
sql_array[1,3]  = lv_case_spl
sql_array[1,4]  = lv_case_ver
sql_array[1,5]  = lv_case_type
sql_array[1,6]  = lv_case_cat
sql_array[1,7]  = lv_asgn_id
sql_array[1,8]  = lv_case_status
sql_array[1,9]  = lv_case_disp
sql_array[1,10] = lv_case_business
sql_array[1,11] = ls_from_period
sql_array[1,12] = ls_to_period
sql_array[1,13] = ls_sub_id	// SAH 12/21/01
		
sql_array[2,1]  = 'CASE_CNTL.DEPT_ID'
sql_array[2,2]  = 'CASE_CNTL.CASE_ID'
sql_array[2,3]  = 'CASE_CNTL.CASE_SPL'
sql_array[2,4]  = 'CASE_CNTL.CASE_VER'
sql_array[2,5]  = 'CASE_CNTL.CASE_TYPE'
sql_array[2,6]  = 'CASE_CNTL.CASE_CAT'
sql_array[2,7]  = 'CASE_CNTL.CASE_ASGN_ID'
sql_array[2,8]  = 'CASE_CNTL.CASE_STATUS'
sql_array[2,9]  = 'CASE_CNTL.CASE_DISP'
sql_array[2,10] = 'CASE_CNTL.CASE_BUSINESS'
sql_array[2,11] = 'CASE_CNTL.CASE_FROM_PERIOD'
sql_array[2,12] = 'CASE_CNTL.CASE_TO_PERIOD'
sql_array[2,13] = 'Upper(CASE_CNTL.PMR_SUBJECT_ID)'	// SAH 12/21/01

// MikeFl 5/23/02 -Track 3021 - Begin
sql_array[3,1]  = '='
sql_array[3,2]  = 'LIKE'
sql_array[3,3]  = 'LIKE'
sql_array[3,4]  = 'LIKE'
sql_array[3,5]  = '='
sql_array[3,6]  = '='
sql_array[3,7]  = '='
sql_array[3,8]  = '='
sql_array[3,9]  = '='
sql_array[3,10] = '='
sql_array[3,11] = 'DATE'
sql_array[3,12] = 'DATE'
sql_array[3,13] = 'LIKE'	

//Loop thru the array and only append to Where if there's something in the sle
//Do a LIKE in case user only typed part of input
ls_where = ' WHERE '

FOR li_idx2 = 1 TO 13

	IF trim(sql_array[1,li_idx2]) <> '' THEN
		
		ls_where = ls_where + sql_array[2,li_idx2]
		
		IF sql_array[3,li_idx2] = 'DATE' THEN
			ls_where = ls_where + ' = ' + gnv_sql.of_get_to_date( sql_array[1,li_idx2] ) + ' AND '	
		ELSE
			ls_where = ls_where + ' ' + sql_array[3,li_idx2] + ' ~'' + Upper( sql_array[1,li_idx2] ) + '~' AND '
		END IF
		
	END IF
	
NEXT 

IF ls_from_date_received <> "" THEN
	ls_where = ls_where + '( CASE_CNTL.CASE_DATE_RECV between ' + &
		gnv_sql.of_get_to_date( ls_from_date_received ) + ' and ' +  &
		gnv_sql.of_get_to_date( ls_to_date_received + " 23:59:59" ) + ' ) '
END IF

ls_select = 'SELECT distinct CASE_CNTL.DEPT_ID,CASE_CNTL.USER_ID, CASE_CNTL.CASE_ID, ' +&
'CASE_CNTL.CASE_SPL, CASE_CNTL.CASE_VER, CASE_CNTL.IDENTIFIED_AMT, CASE_CNTL.OP_AMT, '+&
'CASE_CNTL.AMT_RECV, CASE_CNTL.BALANCE_REMAINING_AMT, CASE_CNTL.RECOVERED_ADDTL_AMT, '+&
'CASE_CNTL.FUTURE_SAVINGS_AMT, CASE_CNTL.AMT_WRITEOFF, CASE_CNTL.REFERRED_AMT, ' +&
'CASE_CNTL.CASE_CUSTOM1_AMT, CASE_CNTL.CASE_CUSTOM2_AMT, CASE_CNTL.CASE_CUSTOM3_AMT, ' +&
'CASE_CNTL.CUSTOM1_AMT, CASE_CNTL.CUSTOM2_AMT, CASE_CNTL.CUSTOM3_AMT, CASE_CNTL.CUSTOM4_AMT, ' +&
'CASE_CNTL.CUSTOM5_AMT, CASE_CNTL.CUSTOM6_AMT, CASE_CNTL.CASE_TYPE, CASE_CNTL.CASE_CAT, CASE_CNTL.CASE_ASGN_ID, '+&
'CASE_CNTL.CASE_ASGN_PRIO, CASE_CNTL.CASE_ASGN_DATE, CASE_CNTL.REFER_FROM_DEPT, CASE_CNTL.REFER_TO_DEPT, '+&
'CASE_CNTL.REFER_BY_REP, CASE_CNTL.REFER_DATE, CASE_CNTL.CASE_DATETIME, CASE_CNTL.CASE_BUSINESS, '+&
'CASE_CNTL.CASE_LINE_B, CASE_CNTL.CASE_TRK_TYPE, CASE_CNTL.CASE_EDIT, CASE_CNTL.CASE_FROM_PERIOD, '+&
'CASE_CNTL.CASE_TO_PERIOD, CASE_CNTL.CASE_STATUS, CASE_CNTL.CASE_DISP, CASE_CNTL.CASE_UPDT_USER, '+&
'CASE_CNTL.CASE_STATUS_DATE, CASE_CNTL.CASE_DESC, CASE_CNTL.CASE_STATUS_DESC, CASE_CNTL.CASE_DATE_RECV, CASE_CNTL.PMR_SUBJECT_ID '
// Lahu S 5/9/02 - Track 3053 end
//if searching closed cases, join to case_log to get close dates
//If em_date_closed.text <> ''  then
//	GaryR	10/17/01	Stars 4.8.1 - Begin
//IF (em_date_closed.text <> '') AND (em_date_closed.text <> "00/00/0000") THEN
IF Trim( ls_from_date_closed ) <> "" AND Trim( ls_to_date_closed ) <> "" THEN
	ls_from = ' FROM CASE_CNTL, CASE_LOG L  '
	
	IF ls_from_date_received <> "" THEN
		ls_and = " AND "
	ELSE
		ls_and = " "
	END IF
	ls_where += ls_and + '( L.STATUS_DATETIME between ' + &
		gnv_sql.of_get_to_date( ls_from_date_closed ) + ' and ' + &
		gnv_sql.of_get_to_date( ls_to_date_closed + " 23:59:59" ) + ' ) AND ' + &
		'( CASE_CNTL.CASE_ID  =  L.CASE_ID ) '   + &
		'AND ( CASE_CNTL.CASE_SPL =  L.CASE_SPL ) AND ( CASE_CNTL.CASE_VER =  L.CASE_VER ) ' +&
		"AND (	L.SYS_DATETIME = ( SELECT min( CASE_LOG.SYS_DATETIME ) "		+ &
		"									FROM CASE_LOG"										+ &
		"									WHERE ( L.CASE_ID = CASE_LOG.CASE_ID )"	+ &
		"									and ( L.CASE_SPL = CASE_LOG.CASE_SPL )"	+ &
		"									and ( L.CASE_VER = CASE_LOG.CASE_VER ) ) )"		+ &
		"AND ( CASE_CNTL.CASE_STATUS = 'CL' OR CASE_CNTL.CASE_STATUS = 'RC' ) " 				// SAH 01/25/02 Finding cases closed between dates	
		// Begin - Track 3063d
		//"AND ( CC.CASE_STATUS = 'CL' ) " 				// SAH 01/25/02 Finding cases closed between dates	
		// End - Track 3063d
		//'AND ( L.DISP = ~'SYSORCLS~' ) AND '
else
	ls_from = ' FROM CASE_CNTL '
end if
//	GaryR	10/17/01	Stars 4.8.1 - End

ls_sql = ls_select + ls_from + ls_where

rc = dw_1.SetSQLSelect(ls_sql)
in_sql = ls_sql
if gc_debug_mode then
	// FDG 05/01/00 - If in debug mode, use f_debug_box.  If this window is a response
	//	window, then MessageBox will hang the system
	f_debug_box("Debug",ls_sql)
end if

rc = Retrieve(dw_1)
if rc = -1 Then
	errorbox(stars2ca,'Error retrieving data for the datawindow')
	cb_list.enabled = TRUE
	cb_close.enabled = TRUE
	return
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	


dw_1.SetRedraw(False)
//Case Security check
FOR ll_x = 1 to rc
	ls_case_cat = dw_1.object.case_cat[ll_x]
	ls_msg = inv_case.uf_edit_case_security(ls_case_cat)
	IF len(ls_msg) > 0 THEN
		dw_1.RowsDiscard (ll_x, ll_x, Primary!)
		ll_x --
		rc --
	END IF
	// FDG 04/06/00 begin - If the response window is used, remove any
	//								closed or deleted cases.
	
	IF	in_from	=	'AC' AND ll_x > 0	THEN	/* GR 04/17/2000 4.5 2192  invalid row range fix */
		ls_case_status	=	dw_1.object.case_status [ll_x]
		// Track 3063d  added (OR ls_case_status = 'RC') below
		IF	ls_case_status	=	'CL'		&  
		OR ls_case_status =  'RC'     &		
		OR	ls_case_status	=	'DL'		THEN
			dw_1.RowsDiscard (ll_x, ll_x, Primary!)
			ll_x --
			rc --
		END IF
	END IF
	// FDG 04/06/00 end
NEXT

inv_case.uf_format_custom_headings(dw_1)
dw_1.SetRedraw(True)

st_row_count.text = string(DW_1.ROWCOUNT())
IF DW_1.ROWCOUNT() <= 0 THEN

//	AJS 12-11-98 Fix track Stardev 2032
	SetMicroHelp(W_Main,'No Cases match the specific search criteria')
   lv_nothing_found = TRUE  
   //	GaryR	10/17/01	Stars 4.8.1
   //setfocus(sle_case_id)
	dw_search.SetFocus()
	dw_search.SetColumn( "case_id" )
   //ib_allow_switch = FALSE
	// FDG 04/06/00 begin
	If in_from = 'AC' Then
  		cb_use.enabled = FALSE
	END IF
	// FDG 04/06/00 end
	SetPointer(Arrow!)
	Return
ELSE
	wf_sort_list()
   //ib_allow_switch = TRUE
	// FDG 04/06/00 begin
	If in_from = 'AC' Then
		cb_use.enabled		=	TRUE
	ELSE
		cb_select.enabled	=	TRUE
   	cb_select.default	=	TRUE 
	END IF
	// FDG 04/06/00 end
END IF


wf_goto_row1()

cb_list.enabled = TRUE
If lv_nothing_found Then   
   cb_list.default = TRUE  
End If                     
cb_close.enabled = TRUE
dw_1.taborder = 250
SetMicroHelp(w_main,'Ready')
Setfocus(dw_1)

// JasonS 07/24/02 Begin - Track 3174d
fx_set_default_dw_date(dw_1)
// JasonS 07/24/02 End - Track 3174d

SetPointer(Arrow!)

end event

public function int wf_sort_list ();//  W_Sort_list  Sorts the cases displayed in dw_1

CHOOSE CASE in_sort_by
CASE 1
	//  Descending Case Id, SPL, Ver  
	setsort(dw_1,'3D,4D,5D')
CASE 2
	// case type
	setsort(dw_1,'6A')
CASE 3 
	// case category
	setsort(dw_1,'7A')
CASE 4
	// dept id
	setsort(dw_1,'1A')
CASE 5
	// rep or assignee id
	setsort(dw_1,'8A')
CASE 6
	// date received
	setsort(dw_1,'28A')
CASE 7
	// status code
	setsort(dw_1,'22A')
CASE 8
	// case disposition
	setsort(dw_1,'23A')
END CHOOSE
sort(dw_1)

wf_goto_row1()

return 1
end function

public function integer wf_goto_row1 ();//  wf_goto_row1     a function to highlight row 1 and set focus there

int rc
long row_nbr

row_nbr = 1
rc = SelectRow(dw_1,0,FALSE)
rc = SelectRow(dw_1,row_nbr,TRUE)
rc = dw_1.setrow(row_nbr)
//  RowFocusChanged must be forced to gets the current row information
//  under the followinging condition:  Cursor is on row 1;  a sort causes
//  row 1 information to be moved to another row; new information is in
//  row 1 but rowfocus has not changed.
dw_1.TriggerEvent(RowFocusChanged!)
return rc
end function

event close;call super::close;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_case_list
//		Event Name:		Close
//
//************************************************************************
//
//	FDG	05/01/95	Prob 157 - Restore gv_allow_switch (enables the 'SQL'
//						toolbar item) from the open event.  This is only
//						a temporary fix.  Each window needs a separate
//						gv_allow_switch which operates independently of all
//						other windows.
//
//************************************************************************
//If isvalid(w_case_count) then close(w_case_count)
int lv_nbr

For lv_nbr = 1 to in_win_nbr
	close(win1[lv_nbr]) 
Next

if isvalid( iv_uo_win ) Then
	close(iv_uo_win)
end if

if IsValid(inv_case) then Destroy inv_case
end event

event open;call super::open;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_case_list
//		Event Name:		Open
//
//************************************************************************
//
//	FDG	10/12/95	Make sure Stars2ca is connected before function labels()
//						is called.
//	FDG	05/01/95	Prob 157 - Save gv_allow_switch (enables the 'SQL'
//						toolbar item) from the previous window.  This is only
//						a temporary fix.  Each window needs a separate
//						gv_allow_switch which operates independently of all
//						other windows.
//	JGG	01/12/98	TS144 - STARS 4.0 Subset Redesign
//						Call labels nvo service in place of global function.
//	NLG	08/31/99	Ts2363c. 1)  Create the case nvo which will be used 
//						in cb_select for security.  2) Place gc_user_id in the
//						Asgn_to field. This also fixes tracks 2273c, 2291c.
//	FDG	04/06/00	Track 2848c.  When in_from = 'AC', this is a response window
//						and disable cb_select, cb_log, cb_total.
//	GaryR	10/17/01	Stars 4.8.1	WIC Request to redesign screen
//	GaryR	01/07/05	Track 4222d	Set list datawindow as the print dw for saving
// Katie 01/11/05 Track 5431c Changed references to global variables to instance variables.
// JasonS 12/17/2005  Track 4591d  Added blank line to top  of case type dddw
//************************************************************************

integer lv_rc,lv_index

//	GaryR	10/17/01	Stars 4.8.1 - Begin
DataWindowChild	ldwc_code
n_cst_datetime		lnv_datetime
Date					ld_receipt_date
//	GaryR	10/17/01	Stars 4.8.1 - End

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

inv_case = create n_cst_case
This.of_set_sys_cntl_range (TRUE)

This.of_setprintdw( dw_1 )

lv_rc = fx_dw_syntax(Upper(is_window_name),dw_1,in_decode_struct,stars2ca)
If lv_rc = -5 Then
	lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(lv_index)
End If

If stars2ca.of_commit() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')
//ib_show_sql     = TRUE

cb_list.default = TRUE

//  set sort for descending by case id, spl, ver
in_sort_by = 1

//	GaryR	10/17/01	Stars 4.8.1 - Begin
dw_search.SetTransObject( Stars2ca )
dw_search.InsertRow( 1 )

//	Add empty values to dropdowns
dw_search.GetChild( "asgn_id", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "cf_name", "" )

dw_search.GetChild( "dept_id", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "code_description", "" )

dw_search.GetChild( "case_cat", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "code_description", "" )

dw_search.GetChild( "status", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "code_description", "" )

dw_search.GetChild( "business", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "code_description", "" )

dw_search.GetChild( "disposition", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "code_description", "" )
//	GaryR	10/17/01	Stars 4.8.1 - End

dw_search.GetChild( "case_type", ldwc_code )
ldwc_code.SetItem( ldwc_code.InsertRow( 1 ), "code_description", "" )

in_from = gv_from

//	GaryR	10/17/01	Stars 4.8.1 - Begin
dw_search.SetItem( 1, "dept_id", gc_user_dept )
dw_search.SetItem( 1, "asgn_id", gc_user_id )

ld_receipt_date = Date( lnv_datetime.of_GetFromDateTime( Today(), inv_sys_cntl.of_get_cntl_no() ) )
dw_search.SetItem( 1, "from_date_received", ld_receipt_date )

If in_from = 'AC' Then
	cb_use.enabled = true
	triggerevent(cb_list,clicked!)
	cb_use.default = true  // SG Nov 94
	cb_select.enabled	=	false			// FDG 04/06/00
	cb_log.enabled		=	false			// FDG 04/06/00
	cb_total.enabled	=	false			// FDG 04/06/00
End If
//	GaryR	10/17/01	Stars 4.8.1 - End
end event

on w_case_list.create
int iCurrent
call super::create
this.dw_search=create dw_search
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.cb_use=create cb_use
this.cb_total=create cb_total
this.cb_log=create cb_log
this.cb_list=create cb_list
this.cb_close=create cb_close
this.cb_stop=create cb_stop
this.cb_select=create cb_select
this.gb_1=create gb_1
this.dw_1=create dw_1
this.st_row_count=create st_row_count
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_search
this.Control[iCurrent+2]=this.st_dw_ops
this.Control[iCurrent+3]=this.ddlb_dw_ops
this.Control[iCurrent+4]=this.cb_use
this.Control[iCurrent+5]=this.cb_total
this.Control[iCurrent+6]=this.cb_log
this.Control[iCurrent+7]=this.cb_list
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_stop
this.Control[iCurrent+10]=this.cb_select
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.st_row_count
end on

on w_case_list.destroy
call super::destroy
destroy(this.dw_search)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.cb_use)
destroy(this.cb_total)
destroy(this.cb_log)
destroy(this.cb_list)
destroy(this.cb_close)
destroy(this.cb_stop)
destroy(this.cb_select)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.st_row_count)
end on

type dw_search from u_dw within w_case_list
string tag = "NO SAVE"
string accessiblename = "Case Search"
string accessibledescription = "Case Search"
integer x = 32
integer y = 64
integer width = 3374
integer height = 536
integer taborder = 20
string dataobject = "d_case_search"
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//	GaryR	10/17/01	Stars 4.8.1	WIC Request to redesign screen.
THIS.of_SetUpdateable( FALSE )
THIS.of_SetDropDownCalendar( TRUE )
THIS.iuo_calendar.of_Register( "from_period", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "to_period", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "from_date_received", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "to_date_received", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "from_date_closed", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "to_date_closed", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_SetDateFormat( "mm/dd/yyyy" )
end event

type st_dw_ops from statictext within w_case_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 1708
integer width = 549
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type ddlb_dw_ops from dropdownlistbox within w_case_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 23
integer y = 1776
integer width = 713
integer height = 208
integer taborder = 190
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Data Window Manipulations"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.

string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end event

type cb_use from u_cb within w_case_list
string accessiblename = "Use"
string accessibledescription = "Use"
integer x = 2839
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 250
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Use"
end type

event clicked;//Modifications:
// 7-2-98 NLG	Track #1420 Do security check before assigning active case
//	4-6-00 FDG	Track 2848c.  If no row is selected, get out.  Change ll_row_nbr 
//					from an int to a long.
//**********************************************************************************
long		ll_row_nbr				// FDG 04/06/00 
string	ls_case_id,		&
			ls_case_spl,	&
			ls_case_ver

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

// FDG 04/06/00 begin
ll_row_nbr = dw_1.RowCount()

IF	ll_row_nbr	<	1		THEN
	Return
END IF
// FDG 04/06/00 end

ll_row_nbr = getrow(dw_1)

// FDG 04/06/00 begin
IF	ll_row_nbr	<	1		THEN
	Return
END IF
// FDG 04/06/00 end

gv_result = 0

ls_case_id  = dw_1.getitemstring(ll_row_nbr,3)
ls_case_spl = dw_1.getitemstring(ll_row_nbr,4)
ls_case_ver = dw_1.getitemstring(ll_row_nbr,5)

//NLG 7-2-98 Track #1420 																	 START***
////gv_case_active = ls_case_id + ls_case_spl + ls_case_ver	//ajs 4.0 02-28-98 globals 
//gv_active_case = ls_case_id + ls_case_spl + ls_case_ver		//ajs 4.0 02-28-98 globals
Select code_value_a,code_value_n
	into :in_dept_code, :in_code_sec
	from CODE
	where code_type = 'CA' and
			code_code = Upper( :in_case_cat )
	using stars2ca;
	If stars2ca.of_check_status() = 100 then
		Errorbox(stars2ca,'Case Category Code not found')
	Elseif stars2ca.sqlcode <> 0 Then
		Errorbox(stars2ca,'Error Reading code Table for Category Code')
	End If

If in_dept_code <> gc_user_dept then
	If in_code_sec = 1 Then
		Messagebox('EDIT','This is a Secured Case. You have insufficient privileges')
		return
	Else
		gv_active_case = ls_case_id + ls_case_spl + ls_case_ver
	End If
Else
	gv_active_case = ls_case_id + ls_case_spl + ls_case_ver
End If
//NLG 7-2-98 track #1420 																	STOP ***

close(parent)
If isvalid(w_case_active) Then
	triggerevent(w_case_active.cb_return_from_case_list,clicked!)
End If

end event

type cb_total from u_cb within w_case_list
string accessiblename = "Totals..."
string accessibledescription = "Totals..."
integer x = 2546
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 240
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Totals..."
end type

event clicked;//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

string lv_parm

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

open (w_case_total)
If message.stringparm = "Case" then
    in_sort_by = 1
    wf_sort_list ()
    If trim(st_row_count.text) <> '' then 
		Messagebox('EDIT','Case Counts are Shown in the Totals' + &
								' Box on this Screen - ' + st_row_count.text)
	 Else
		Messagebox('EDIT','Click the List Button to obtain Case totals ' &
					+ 'in the shaded box')
		cb_list.default = true
    end if 
    RETURN
elseif message.stringparm = "Status" then
       in_sort_by = 7
       wf_sort_list ()
		 lv_parm = 'CASE_STATUS~~Status'
		 setmicrohelp(w_main,'Obtaining Counts by Status')
ELSEIF message.stringparm = "Disposition" then
       in_sort_by = 8
       wf_sort_list () 
		 lv_parm = 'CASE_DISP~~Disposition'
		 setmicrohelp(w_main,'Obtaining Counts by Disposition')
ELSEIF message.stringparm = "Case Type" then
       in_sort_by = 2
       wf_sort_list ()  
		 lv_parm = 'CASE_TYPE~~Case Types'
		 setmicrohelp(w_main,'Obtaining Counts by Case Type')
ELSEIF message.stringparm = "Dept Id" then
       in_sort_by = 4
       wf_sort_list () 
		 lv_parm = 'DEPT_ID~~Department'
		 setmicrohelp(w_main,'Obtaining Counts by Department Id')
ELSEIF message.stringparm = "Assign Id" then
       in_sort_by = 5
       wf_sort_list ()  
		 lv_parm = 'CASE_ASGN_ID~~Assign ID'
		 setmicrohelp(w_main,'Obtaining Counts by Assign Id')
ELSEIF message.stringparm = "Date Received" then
       in_sort_by = 6
       wf_sort_list () 
		 setmicrohelp(w_main,'Obtaining Counts by Receipt Date')
		 lv_parm = 'CASE_DATE_RECV~~Receipt Date'
ElseIf message.stringparm = "Category" then
       in_sort_by = 3
       wf_sort_list () 
		 setmicrohelp(w_main,'Obtaining Counts by Case Category')
		 lv_parm = 'CASE_CAT~~Case Category'
ElseIf message.stringparm = "Close" then 
       RETURN
END IF

//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

lv_parm += "~~" + in_sql
in_win_nbr = in_win_nbr + 1
openwithparm(win1[in_win_nbr],lv_parm)
setpointer(arrow!)
 
end event

type cb_log from u_cb within w_case_list
string accessiblename = "History"
string accessibledescription = "History"
integer x = 2254
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 230
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&History"
end type

event clicked;//  CLICKED EVENT FOR CB_LOG BUTTON  ON W_CASE_LIST WINDOW
//*******************************************************************
// DKG	01/26/96	Set in_sql so HISTORY criteria would be passed to
//						case counts window. PROB 0054 Stars 3.1 Release
//               	disk.
//	NLG	06/11/98	Use sys_cntl nvo to set date range
// AJS	09/01/98	FS362 convert case to case_cntl
// FNC	01/13/99	TS2040C Stars 4.0 SP1 Require entry of 4 digit year
//	NLG	08/31/99	Add new money columns to sql
//	GaryR	02/06/01	Stars 4.7 DataBase Port - Conversion of Dates.
//	GaryR	04/16/01	Track#: SD2328	- PIMR Problem.
//	GaryR 10/17/01	Stars 4.8.1	WIC Request to redesign screen.
// SAH   05/17/02 Stars 5.0.1 Track 3021 Change required fields on History function
// MikeF 05/20/02 Track 3075 - Pull date recieved from CASE_CNTL rather than CASE_LOG
// MikeF 05/23/02 Track 3021 - Change SQL to use '=' rather than 'LIKE'
// MikeF 06/06/02 Track 3074 - Select button available when no rows displayed
// JasonS 09/04/02 Track 3069d - check from & thru dates
// GaryR	07/17/08	SPR 5457	 Use joins instead of the subselect to take advantage of indices
//*******************************************************************

//	GaryR 10/17/01	Stars 4.8.1 - Begin
string sql_closed, sql_all, lv_sort_seq
string lv_dept_id, lv_case_disp, ls_case_cat
string ls_msg
string ls_from_date_received, ls_to_date_received	// JasonS 09/04/02 Track 3069d

n_cst_datetime lnv_datetime

integer  rc,lv_range
long ll_x

datetime lv_case_close_start, lv_case_close_end
String	ls_from_date_closed, ls_to_date_closed

// SAH 05/17/02 Track 3021
String   ls_from_date_rcv, ls_to_date_rcv
DateTime lv_case_rcv_start, lv_case_rcv_end

IF dw_search.AcceptText() <> 1 THEN Return
//	GaryR 10/17/01	Stars 4.8.1 - End

// JasonS 09/04/02 Begin - Track 3069d
ls_from_date_received = Trim(String( dw_search.GetItemDate( 1, "from_date_received" ), "mm/dd/yyyy" ))
ls_to_date_received = Trim(String( dw_search.GetItemDate( 1, "to_date_received" ), "mm/dd/yyyy" ))

If (ls_from_date_received <> "" ) AND (ls_to_date_received = "") Then
	MessageBox ('Error', 'Please enter a valid thru date for the receipt period')
	dw_search.SetFocus()
	dw_search.SetColumn( "to_date_received" )
	Return	
Else
	rc		=	lnv_datetime.of_IsValidDate (ls_from_date_received)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
	END CHOOSE	
End If	

IF (ls_to_date_received <> "") AND (ls_from_date_received = "") THEN
	MessageBox ('Error', 'Please enter a valid from date for the receipt period')
	dw_search.SetFocus()
	dw_search.SetColumn( "from_date_received" )
	Return	

ELSE
	rc		=	lnv_datetime.of_IsValidDate (ls_to_date_received)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnv_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
	END CHOOSE
END IF

If (ls_to_date_received <> "") and (ls_from_date_received <> "") Then
	IF Date( ls_to_date_received ) < Date( ls_from_date_received ) THEN
		MessageBox ('Error', 'from date for the receipt period should be less than the thru date')
		dw_search.SetFocus()
		dw_search.SetColumn( "from_date_received" )
		Return
	END IF
End if
// JasonS 09/04/02 End - Track 3069d


setpointer(hourglass!) 
SetMicroHelp(W_Main,'Listing All Cases that ever had the Selected Disposition.')	

IN_SQL = ''
in_nbr_rows = 0
st_row_count.text = ' '

//	GaryR 10/17/01	Stars 4.8.1 - Begin
lv_case_disp = dw_search.GetItemString( 1, "disposition" )
IF IsNull( lv_case_disp ) OR Trim( lv_case_disp ) = "" THEN
	MessageBox( "Error", "Please select a valid disposition" )
	dw_search.SetFocus()
	dw_search.SetColumn( "disposition" )
	Return
END IF

// MikeFl - 5/20/02 - Track 3075 - Begin 1
// Only the Disposition and case_recv (between) can be used for History
string	lv_case, lv_subject, lv_assign
date		lv_nulldate

lv_case 		= trim(dw_search.GetItemString( 1, "case_id" ))
lv_subject 	= trim(dw_search.GetItemString( 1, "pmr_subject_id" ))
SetNull (lv_nulldate)

IF len(lv_case) 		> 0		&
OR len(lv_subject) 	> 0		&
OR len(trim(dw_search.GetItemString( 1, "asgn_id" ))) 	> 0	&
OR len(trim(dw_search.GetItemString( 1, "dept_id" ))) 	> 0	&
OR len(trim(dw_search.GetItemString( 1, "case_cat" ))) 	> 0	&
OR len(trim(dw_search.GetItemString( 1, "status" ))) 		> 0	&
OR len(trim(dw_search.GetItemString( 1, "business" ))) 	> 0	&
OR len(trim(dw_search.GetItemString( 1, "case_type" ))) 	> 0	&
OR len(trim(string(dw_search.GetItemDate(1, "from_period"))))	> 0	&
OR len(trim(string(dw_search.GetItemDate(1, "to_period")))) 	> 0	&
OR len(trim(string(dw_search.GetItemDate(1, "from_date_closed"))))	> 0	&
OR len(trim(string(dw_search.GetItemDate(1, "to_date_closed")))) 		> 0	THEN

	rc = MessageBox('Warning', &
					'Only Disposition and Case Rcv Between dates can be used with the History function.'  + &
					'~r~rClick OK to clear the additional criteria and continue', & 
					Exclamation!, OKCancel!, 1)

	IF rc = 1 THEN
		// JasonS 09/04/02 Begin - Track 3069d
		dw_search.SetItem(1, 'case_id', '')
	   dw_search.SetItem(1, 'pmr_subject_id', '')
		// JasonS 09/04/02 End - Track 3069d
	   dw_search.SetItem(1, 'asgn_id', ' ')
	  	dw_search.SetItem(1, 'dept_id', ' ')
		dw_search.SetItem(1, 'case_cat', ' ')
	   dw_search.SetItem(1, 'status', ' ')
		dw_search.SetItem(1, 'business', ' ')
		dw_search.SetItem(1, 'case_type', ' ')
		dw_search.SetItem(1, 'from_period',lv_nulldate)
		dw_search.SetItem(1, 'to_period',lv_nulldate)
		dw_search.SetItem(1, 'from_date_closed',lv_nulldate)
		dw_search.SetItem(1, 'to_date_closed',lv_nulldate)
	ELSE
		RETURN
	END IF

END IF

n_cst_datetime lnvo_cst_datetime
// Allow user to use Case Rcv Between instead of Date Closed Between (but it's not required)

// Get the From Date Received and validate
ls_from_date_rcv = String(dw_search.object.from_date_received[1])
IF NOT IsNull( ls_from_date_rcv ) AND Trim( ls_from_date_rcv ) <> "" THEN
	rc		=	lnvo_cst_datetime.of_IsValidDate (ls_from_date_rcv)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnvo_cst_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnvo_cst_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "from_date_received" )
			Return
	END CHOOSE 
END IF

// Get the To Date Received and validate
ls_to_date_rcv = String( dw_search.GetItemDate( 1, "to_date_received" ), "mm/dd/yyyy" )
IF NOT IsNull( ls_to_date_rcv ) AND Trim( ls_to_date_rcv ) <> "" THEN
	rc		=	lnvo_cst_datetime.of_IsValidDate (ls_to_date_rcv)
	
	CHOOSE CASE rc
		CASE	-1
			MessageBox ('Error', 'Invalid date entered')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
		CASE	-2
			MessageBox ('Error', 'The year entered must be a 4 digit year')
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
		CASE	-3
			MessageBox ('Error', 'The date must be between '	+	&
							lnvo_cst_datetime.of_GetMinimumStringDate()	+	' and '	+	&
							lnvo_cst_datetime.of_GetMaximumStringDate()	)
			dw_search.SetFocus()
			dw_search.SetColumn( "to_date_received" )
			Return
	END CHOOSE
	IF Date( ls_to_date_rcv ) < Date( ls_from_date_rcv ) THEN
		MessageBox ('Error', 'From Date for the Received Period should be less than the Thru Date')
		dw_search.SetFocus()
		dw_search.SetColumn( "from_date_received" )
		Return
	END IF	
END IF

lv_case_rcv_start	= DateTime( Date( ls_from_date_rcv ) )
lv_case_rcv_end 	= DateTime( Date( ls_to_date_rcv ), Time( "23:59:59" ) )

// MikeFl - 5/20/2002
IF  NOT IsNull( ls_from_date_rcv ) AND Trim( ls_from_date_rcv ) <> "" &
AND NOT IsNull( ls_to_date_rcv ) AND Trim( ls_to_date_rcv ) <> "" THEN
	MessageBox(	'Note', &
				'Cases with the specified Disposition during the given timeframe will be listed.',  &
				Information!, OK!)
END IF

Reset(DW_1)

cb_list.enabled = FALSE
cb_close.enabled = FALSE
cb_select.enabled = FALSE

rc = SetTransObject(DW_1,stars2ca)
if rc = -1 Then
	errorbox(stars2ca,'Error connecting to the datawindow')
	cb_select.enabled = TRUE

	cb_list.enabled = TRUE
	cb_close.enabled = TRUE
	return
end if

// SAH 05/17/02 Track 3021 -Begin 2

//8-31-99 NLG Add custom money fields to sql
//	GaryR	04/16/01	Track#: SD2328	- PIMR Problem.
sql_all = 'SELECT DISTINCT CASE_CNTL.DEPT_ID, CASE_CNTL.USER_ID, CASE_CNTL.CASE_ID,  CASE_CNTL.CASE_SPL, ' + &
	' CASE_CNTL.CASE_VER, CASE_CNTL.IDENTIFIED_AMT, CASE_CNTL.OP_AMT, '+&
	'CASE_CNTL.AMT_RECV, CASE_CNTL.BALANCE_REMAINING_AMT, CASE_CNTL.RECOVERED_ADDTL_AMT, '+&
	'CASE_CNTL.FUTURE_SAVINGS_AMT, CASE_CNTL.AMT_WRITEOFF, CASE_CNTL.REFERRED_AMT, ' +&
	'CASE_CNTL.CASE_CUSTOM1_AMT, CASE_CNTL.CASE_CUSTOM2_AMT, CASE_CNTL.CASE_CUSTOM3_AMT, ' +&
	'CASE_CNTL.CUSTOM1_AMT, CASE_CNTL.CUSTOM2_AMT, CASE_CNTL.CUSTOM3_AMT, CASE_CNTL.CUSTOM4_AMT, ' +&
	'CASE_CNTL.CUSTOM5_AMT, CASE_CNTL.CUSTOM6_AMT, CASE_CNTL.CASE_TYPE, CASE_CNTL.CASE_CAT, CASE_CNTL.CASE_ASGN_ID,  ' + &
	' CASE_CNTL.CASE_ASGN_PRIO, CASE_CNTL.CASE_ASGN_DATE, CASE_CNTL.REFER_FROM_DEPT, CASE_CNTL.REFER_TO_DEPT, ' + & 
	' CASE_CNTL.REFER_BY_REP, CASE_CNTL.REFER_DATE, CASE_CNTL.CASE_DATETIME, CASE_CNTL.CASE_BUSINESS, ' + &
	' CASE_CNTL.CASE_LINE_B, CASE_CNTL.CASE_TRK_TYPE, CASE_CNTL.CASE_EDIT, CASE_CNTL.CASE_FROM_PERIOD, ' + &
	' CASE_CNTL.CASE_TO_PERIOD, CASE_CNTL.CASE_STATUS, CASE_CNTL.CASE_DISP, CASE_CNTL.CASE_UPDT_USER, CASE_CNTL.CASE_STATUS_DATE, ' + &
	' CASE_CNTL.CASE_DESC, CASE_CNTL.CASE_STATUS_DESC, CASE_CNTL.CASE_DATE_RECV, CASE_CNTL.PMR_SUBJECT_ID ' + &
	' FROM case_cntl, case_log ' + &
	' WHERE CASE_CNTL.CASE_ID = CASE_LOG.CASE_ID' + &
	' AND CASE_CNTL.CASE_SPL = CASE_LOG.CASE_SPL' + &
	' AND CASE_CNTL.CASE_VER = CASE_LOG.CASE_VER' + &
	' AND case_log.disp = ~'' + Upper( lv_case_disp ) + '~'' 

IF String(lv_case_rcv_start) <> " " AND String(lv_case_rcv_end) <> " " THEN
	// MikeFl - 5/20/2002 - Track 3075 - Begin
	sql_all += ' AND (case_log.STATUS_DATETIME BETWEEN ' + &
	gnv_sql.of_get_to_date( String( lv_case_rcv_start, 'MM/DD/YYYY HH:MM:SS' ) ) + ' AND ' + &
	gnv_sql.of_get_to_date( String( lv_case_rcv_end, 'MM/DD/YYYY HH:MM:SS' ) ) + ' )'
	// MikeFl - 5/20/2002 - Track 3075 - End
END IF
	
in_sql = sql_all

rc = dw_1.SetSQLSelect(sql_all)
if rc = -1 Then
	errorbox(stars2ca,'Error creating the SQL for the datawindow')
	cb_list.enabled = TRUE
	cb_close.enabled = TRUE
	return
end if
if gc_debug_mode then
	clipboard('')
	clipboard(sql_all)
	MessageBox("",sql_all)
end if

rc = Retrieve(dw_1)
if rc = -1 Then
	cb_list.enabled = TRUE
	cb_close.enabled = TRUE
	return
end if

If stars2ca.of_commit() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

dw_1.SetRedraw(False)
//Case Security check
FOR ll_x = 1 to rc
	ls_case_cat = dw_1.object.case_cat[ll_x]
	ls_msg = inv_case.uf_edit_case_security(ls_case_cat)
	IF len(ls_msg) > 0 THEN
		dw_1.RowsDiscard(ll_x,ll_x,Primary!)
		ll_x --
		rc --
	END IF
NEXT

inv_case.uf_format_custom_headings(dw_1)

dw_1.SetRedraw(True)

st_row_count.text = string(DW_1.ROWCOUNT())
IF DW_1.ROWCOUNT() <= 0 THEN
   messagebox('NO DATA','No Cases match the specific search criteria.',INFORMATION!,OK!)
   //	GaryR 10/17/01	Stars 4.8.1
	dw_search.SetFocus()
	dw_search.SetColumn( "case_id" )	
ELSE
	wf_sort_list()
// MikeFl - 6/6/2002 - Begin
	cb_select.enabled = TRUE
END IF

cb_list.enabled = TRUE
cb_close.enabled = TRUE
dw_1.taborder = 250
SetMicroHelp(w_main,'Ready')
Setfocus(dw_1)
end event

type cb_list from u_cb within w_case_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 1669
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 210
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&List"
boolean default = true
end type

event clicked;parent.triggerevent("ue_list")
end event

type cb_close from u_cb within w_case_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 3131
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 260
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

If in_from = 'AC' Then
	gv_result = 100
//	If isvalid(w_case_active) Then
//		triggerevent(w_case_active.cb_return_from_case_list,clicked!)
//	End If
End If
close (parent)
end on

type cb_stop from u_cb within w_case_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
integer x = 1376
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 10
boolean dragauto = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "S&top"
end type

on clicked;//  Clicked event for CB_STOP on W_CASE_LIST

//  Set the switch to tell PB that stop button was pushed.
gv_cancel_but_clicked = TRUE

end on

type cb_select from u_cb within w_case_list
string accessiblename = "Select..."
string accessibledescription = "Select..."
integer x = 1961
integer y = 1740
integer width = 274
integer height = 96
integer taborder = 220
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Select..."
end type

event clicked;//  CLICKED EVENT ON CB_SELECT BUTTON FOR W_CASE_LIST
//Modifications:
//	08-31-99	NLG	1) Replace hardcoded edits for security with call to 
//						nvo_case. ts2363c.
//						2)	Pass parm to case maint instead of global gv_from
///////////////////////////////////////////////////////////////////////

SetMicroHelp(W_Main,'Opening the Case Screen with the selected Case.')
SetPointer(HourGlass!)
string ls_message
string lv_case_id, lv_case_spl, lv_case_ver

//7-2-98 NLG Track #1420                 	START***
lv_case_id  = dw_1.getitemstring(il_row_nbr,'case_id')
lv_case_spl = dw_1.getitemstring(il_row_nbr,'case_spl')
lv_case_ver = dw_1.getitemstring(il_row_nbr,'case_ver')
//7-2-98 NLG Track #1420            		STOP***

ls_message = inv_case.uf_edit_case_security(lv_case_id,lv_case_spl,lv_case_ver)

if Len(ls_message) > 0 then
	MessageBox('SECURITY', ls_message)
	return
end if

gv_active_case = lv_case_id + lv_case_spl + lv_case_ver
//OPENSHEET (w_case_maint,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
OpenSheetWithParm(w_case_maint,'L',MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
//8-31-99	NLG																		***STOP***
end event

type gb_1 from groupbox within w_case_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer width = 3410
integer height = 612
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

type dw_1 from u_dw within w_case_list
string accessiblename = "List of Cases"
string accessibledescription = "List of Cases"
integer x = 23
integer y = 636
integer width = 3406
integer height = 1060
integer taborder = 200
string dataobject = "d_case_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
end type

event retrieveend;//  Retrieveend event for DW_1 on W_CASE_LIST

//  Enable the control, list and close keys.
//  The stop button is not valid unless a retrieve is in process. This
//  event is triggered at the end of the retrieve.

//w_case_list.controlmenu = TRUE							//FDG 06/13/96
If in_from = 'AC' Then
	cb_use.enabled = true
End IF

cb_stop.enabled = FALSE

//  Set the switch to allow execution of the code in rowfocuschanged.
gv_cancel_but_clicked = TRUE
triggerevent(dw_1,rowfocuschanged!)

dw_1.setRedraw(TRUE)//NLG 8-31-99
end event

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
//anne-s 11-28-97
//	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
//	End If
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row //getclickedrow(dw_1)
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row //getclickedrow(dw_1)
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
Else
	lv_row_nbr = row //getclickedrow(dw_1)
	If lv_row_nbr > 0 Then
		cb_select.Triggerevent(Clicked!)
	Else
		Messagebox('Edit','Invalid selection.')
	End If
End If

triggerevent(dw_1,rowfocuschanged!)
end event

event retrievestart;//  retrievestart event for DW_1 on W_CASE_LIST

setpointer(hourglass!)
//  Reset "stop" switch at the start of the retrieve.
gv_cancel_but_clicked = FALSE
//  Open up the "STOP" button.
cb_stop.enabled = TRUE

dw_1.setRedraw(False)//NLG 8-31-99




end event

event rowfocuschanged;//  rowfocuschanged event for DW_1  on W_CASE_LIST
//Modifications:
//	07/02/98	NLG	Track #1420 Replace local row_nbr with instance il_row_nbr
//	04/06/99	FDG	Track 2848c. When the 'Use' button is enabled, don't enable
//						the Select button.
//	01/17/02	FDG	Track 2699d.  If 0 rows exist, currentrow could still = 1.
//	05/17/04	GaryR	Track 3918d	Disable Totals button when 0 rows
//****************************************************************************************
string test
int row_nbr,clicked_row, rc
string lv_case_id, lv_case_spl, lv_case_ver 


//  This event will only function if the stop button has been clicked, 
//  or the end of the initial retrieve has been reached.

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if gv_cancel_but_clicked Then
	il_row_nbr = getrow(dw_1) 	//NLG  replace row_nbr with il_row_nbr
	// FDG 01/17/02 - Check rowcount
	//If il_row_nbr = 0 then		//NLG  replace row_nbr with il_row_nbr
	IF	il_row_nbr	=	0		&
	OR	This.RowCount()	<	1		THEN
		// FDG 04/06/00 - If 'Use' then enable/disable cb_use
		IF	in_from	=	'AC'		THEN
			cb_use.enabled		=	false
		ELSE
   		cb_select.enabled =	false
		END IF
		cb_total.enabled = FALSE
		return
	else
		// FDG 04/06/00 - If 'Use' then enable/disable cb_use
		IF	in_from	=	'AC'		THEN
			cb_use.enabled		=	true
		ELSE
			cb_select.enabled =	true
		END IF
		cb_total.enabled = TRUE
	end if
   //Highlights the current row
	rc = SelectRow(dw_1,0,FALSE)
	rc = SelectRow(dw_1,il_row_nbr,TRUE)				//NLG 7-2-98 replace row_nbr with il_row_nbr
	lv_case_id  = dw_1.getitemstring(il_row_nbr,'case_id')	//NLG 7-2-98 replace row_nbr with il_row_nbr
	lv_case_spl = dw_1.getitemstring(il_row_nbr,'case_spl')	//NLG 7-2-98 replace row_nbr with il_row_nbr
	lv_case_ver = dw_1.getitemstring(il_row_nbr,'case_ver')	//NLG 7-2-98 replace row_nbr with il_row_nbr
	in_case_cat = dw_1.getitemstring(il_row_nbr,'case_cat')	//NLG 7-2-98 replace row_nbr with il_row_nbr
end if
end event

event constructor;call super::constructor;//	TS144		STARS 4.0	Subset Redesign
//
// Log:		
//				JGG	01/12/98		Register the datawindow to the labels service (nvo)
//

//This.of_SetLabels (TRUE)


end event

type st_row_count from statictext within w_case_list
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 773
integer y = 1740
integer width = 274
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
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

