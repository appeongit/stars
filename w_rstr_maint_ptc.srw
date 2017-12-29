HA$PBExportHeader$w_rstr_maint_ptc.srw
$PBExportComments$Inherited from w_master
forward
global type w_rstr_maint_ptc from w_master
end type
type cb_retrieve from u_cb within w_rstr_maint_ptc
end type
type cb_details from u_cb within w_rstr_maint_ptc
end type
type cb_model from u_cb within w_rstr_maint_ptc
end type
type cb_clear from u_cb within w_rstr_maint_ptc
end type
type cb_close from u_cb within w_rstr_maint_ptc
end type
type cb_add from u_cb within w_rstr_maint_ptc
end type
type cb_delete from u_cb within w_rstr_maint_ptc
end type
type cb_update from u_cb within w_rstr_maint_ptc
end type
type dw_rstr from u_dw within w_rstr_maint_ptc
end type
end forward

global type w_rstr_maint_ptc from w_master
string accessiblename = "STARS Archive Retrieval Maintenance"
string accessibledescription = "STARS Archive Retrieval Maintenance"
accessiblerole accessiblerole = windowrole!
integer x = 69
integer y = 124
integer width = 3182
integer height = 1720
string title = "STARS Archive Retrieval Maintenance"
long backcolor = 67108864
event type integer ue_retrieve_restore ( )
event ue_reset_restore ( )
event type integer ue_update_restore ( )
event type integer ue_general_edits ( )
event type integer ue_insert_null_cdw ( )
event type integer ue_filter_cdw ( string as_cdw_changed,  string as_cdw_new_value )
cb_retrieve cb_retrieve
cb_details cb_details
cb_model cb_model
cb_clear cb_clear
cb_close cb_close
cb_add cb_add
cb_delete cb_delete
cb_update cb_update
dw_rstr dw_rstr
end type
global w_rstr_maint_ptc w_rstr_maint_ptc

type variables
long 		lv_period
datetime iv_to_date, iv_from_date
date 		iv_rstr_to_date,iv_rstr_from_date
string 	iv_crit_field[], iv_crit_type
string 	iv_crit_value[], iv_crit_logic[], iv_crit_oper[]
string 	iv_crit_left_paren[], iv_crit_right_paren[]
string 	iv_crit_id, is_existing_crit
string 	is_type, is_sub_tbl_type
long 		iv_crit_line_count
string 	is_rstr_id //ajs 4.0 03-20-98
string 	is_hold_rstr_id //ajs 4.0 03-20-98
string 	is_empty		//FNC 01/09/02

sx_subset_options istr_subset_options //VAV 4.0 2/10/98
sx_subset_ids 		istr_subset_ids   //VAV 4.0 2/11/98

end variables

forward prototypes
public subroutine wf_disable_fields ()
public subroutine wf_enable_fields ()
public subroutine wf_protect_criteria_field (string as_type)
public function integer wf_delete_criteria ()
public function integer wf_get_existing_crit_id ()
public function integer wf_clear_fields ()
public function integer wf_write_criteria ()
public subroutine wf_load_criteria (string as_crit_field, string as_field1, string as_field2, string as_field3, string as_field4, string as_field5)
public subroutine push_over ()
public function integer wf_write_criteria_line ()
end prototypes

event type integer ue_retrieve_restore();datetime lv_from_date, lv_to_date, lv_restore_date
int hold_int, stat_e_count, stat_r_count, stat_l_count, li_rc, li_row
long ll_row
string ls_case_id, ls_type
sx_subset_ids lstr_subset_ids

	
SetPointer(hourglass!)
Close(w_rstr_details)
If trim(is_rstr_id) = '' then
	MessageBox("Restore Request","Please enter the restore request ID of the request you wish to retrieve")
	RETURN -1
End If
SetMicroHelp(w_main,'Retrieving record from Restore Request Table')	  

//retrieve datewindow fields
	
ll_row	=	dw_rstr.Retrieve(is_rstr_id)
//AJS 07-07-98 Correct TRACK #1438
If stars2ca.of_check_status() <> 0 or ll_row > 1 Then
	SetMicroHelp(w_main,'Ready')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		RETURN -1
	End If	
  	errorbox(stars2ca,'Error retrieving from Restore Request Table, Retrieve Cancelled')
	This.Event ue_reset_restore()
	dw_rstr.SetFocus()
	dw_rstr.SetColumn('rstr_id')
	RETURN -1
end If
	
If ll_row < 1 Then
	SetMicroHelp(w_main,'Ready')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		RETURN -1
	End If	
	This.Event ue_reset_restore()
	dw_rstr.SetFocus()
	dw_rstr.SetColumn('rstr_id')
	messagebox('Not Found','Selection not found, Cannot be retrieved',StopSign!)
	RETURN -1
end If
//AJS 07-07-98 Correct TRACK #1438 end
	
dw_rstr.SetRow(ll_row)
//Retrieve SUBSET NAME	
NVO_Subset_Functions lnv_Subset_Functions

//Create the subset functions user object with the following statement:
lnv_Subset_Functions = Create NVO_Subset_Functions

lstr_subset_ids.subset_id = dw_rstr.Object.Subc_id[ll_row]
lstr_subset_ids.subset_case_id = dw_rstr.Object.Case_id[ll_row]
lstr_subset_ids.subset_case_spl = dw_rstr.Object.Case_spl[ll_row]
lstr_subset_ids.subset_case_ver = dw_rstr.Object.Case_ver[ll_row]

ls_case_id = lstr_subset_ids.subset_case_id + lstr_subset_ids.subset_case_spl + lstr_subset_ids.subset_case_ver
dw_rstr.Object.entire_case_id[ll_row] = ls_case_id

li_rc = lnv_subset_functions.uf_set_structure(lstr_subset_ids)
If li_rc <> 1 then
	MessageBox('Edit','Error retrieving setting subset id')
	Destroy lnv_subset_functions
	RETURN -1
End If

li_rc = lnv_subset_functions.uf_retrieve_subset_name()

If li_rc <> 1 then
	Messagebox('Edit','Error retrieving subset name')
	Destroy lnv_subset_functions
	RETURN -1
End If

lstr_subset_ids = lnv_subset_functions.uf_get_structure()
Destroy lnv_subset_functions
	
dw_rstr.object.subc_name[ll_row] = lstr_subset_ids.subset_name

//If ls_type = 'M' then
//   rb_purged_history.Checked = true
//   rb_purged_history.PostEvent(Clicked!)
//Else
//   rb_stars_retrieval.Checked = true
//   rb_stars_retrieval.PostEvent(Clicked!)
//End If
//

hold_int = 0

Select SUM(RSTR_ROW_CNT)
  into :hold_int
From RESTORE_CNTL
Where RSTR_ID = Upper( :is_rstr_id )
Using stars2ca; 

If stars2ca.of_check_status() <> 0 Then               //VAV 4.0 2/11/98 - replaced 'sqlcode'
   errorbox(stars2ca,'Error retrieving row count')
	RETURN -1
End If	

Select Count(*)
	into :stat_e_count
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id ) and RSTR_STATUS = 'E'
	Using stars2ca;
Select Count(*)
	into :stat_r_count
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id ) and RSTR_STATUS = 'P'
	Using stars2ca;
Select Count(*)
	into :stat_l_count
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id )   // L or P indicate this month done
		and (RSTR_STATUS = 'C' or RSTR_STATUS = 'S')
	Using stars2ca;
Select min(rstr_paid_date)
	into :lv_from_date	
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id )
	Using stars2ca;
Select max(rstr_paid_date)
	into :lv_to_date
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id )
	Using stars2ca;
Select max(rstr_date)
	into :lv_restore_date
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id )
	Using stars2ca;

If stars2ca.of_check_status() <> 0 Then			//VAV 4.0 2/11/98 - replaced 'sqlcode'
  	errorbox(stars2ca,'Error retrieving from Restore CNTL Table, Retrieve Partially Successful')
	dw_rstr.SetFocus()
	dw_rstr.SetColumn('rstr_id')
	RETURN -1
end If 
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	RETURN -1
End If	

// load restore periods based on min and max dates in CNTL table
dw_rstr.object.ccyy_from[ll_row] = string(year(date(lv_from_date)))
dw_rstr.object.ccyy_to[ll_row] = string(year(date(lv_to_date)))
dw_rstr.object.mm_from[ll_row] = string(month(date(lv_from_date)))
dw_rstr.object.mm_to[ll_row] = string(month(date(lv_to_date)))

// Derive the summary status based on rows in CNTL table
If stat_e_count > 0 then
	dw_rstr.object.status[ll_row] = "E"
else
	If (stat_r_count > 0) and (stat_l_count = 0) then
		dw_rstr.object.status[ll_row] = "P" 
	else
		If stat_r_count > 0 and stat_l_count > 0 then
			dw_rstr.object.status[ll_row] = "S"  
		else
			dw_rstr.object.status[ll_row] = "C"
		end If
	end If
end If

//display status text message
dw_rstr.object.date_rstrd[ll_row] = ""
dw_rstr.object.rows_rstrd[ll_row] = ""

If (dw_rstr.object.status[ll_row] = "C") then
	dw_rstr.object.status_msg[ll_row] = "Restore Completed, You May Access Subset"   //12-05-95 FNC
	dw_rstr.object.date_rstrd[ll_row] = string(date(lv_restore_date))
	dw_rstr.object.rows_rstrd[ll_row] = string(hold_int)
else
	If (dw_rstr.object.status[ll_row] = "P") then
		dw_rstr.object.status_msg[ll_row] = "Restore Requested"   //12-05-95 FNC
	else
		If (dw_rstr.object.status[ll_row] = "S") then
			dw_rstr.object.status_msg[ll_row] = "Restore Is In Progress"   //12-05-95 FNC
		else
			If (dw_rstr.object.status[ll_row] = "E") then
				dw_rstr.object.status_msg[ll_row] = "An Error Occurred During Restore Processing"     //12-05-95 FNC
			else
				dw_rstr.object.status_msg[ll_row] = ""   //12-05-95 FNC
			end If
		end If
	end If
end If		  
//Place in ue_postopen
////Insert a blank value in the invoice type choices
//This.Event ue_insert_null_cdw()
//
//Filter out the used invoice types
This.Event ue_filter_cdw('','')


//Protect criteria field depending if it is an archive or legacy subset
ls_type = dw_rstr.object.Type[ll_row]
wf_protect_criteria_field(ls_type)
//dw_rstr.Object.Rstr_Id.Protect = 1
is_hold_rstr_id = is_rstr_id

//Enable/Disable fields
If (trim(dw_rstr.object.Status[ll_row]) = '' or dw_rstr.object.Status[ll_row] = 'P') and dw_rstr.Object.user_id[ll_row] = gc_user_id then
	wf_enable_fields()
End if

If dw_rstr.object.status[ll_row] = 'C' or dw_rstr.object.status[ll_row] = 'E' or dw_rstr.object.status[ll_row] = 'S' &
   or dw_rstr.Object.user_id[ll_row] <> gc_user_id then
   wf_disable_fields()
end If

If (dw_rstr.object.status[ll_row] = "C") or (dw_rstr.object.status[ll_row] = "S") or (dw_rstr.Object.user_id[ll_row]<>gc_user_id) then
	cb_update.enabled = FALSE
	cb_delete.enabled = FALSE
else
	cb_update.enabled = TRUE
	cb_Update.default = TRUE
	cb_delete.enabled = TRUE
end If

cb_details.enabled = TRUE
cb_details.visible = TRUE
cb_model.enabled = TRUE
cb_add.enabled = FALSE  

SetMicroHelp(w_main,'Ready')	 

Return 0
end event

event ue_reset_restore;call super::ue_reset_restore;long ll_row
string ls_type, ls_hold_
sx_subset_options lstr_sub_opt

If IsValid(W_rstr_details) then
	close(w_rstr_details)
End If

dw_rstr.Reset()
dw_rstr.InsertRow(0)
ll_row = dw_rstr.GetRow()
		
//cb_details.visible = true	//unsure of this

dw_rstr.Object.Rstr_id.protect = 0
is_rstr_id = ""
dw_rstr.Object.User_id[ll_row] = gc_user_id
//ajs 07-07-98 Track 1422
dw_rstr.Object.Rstr_desc[ll_row] = ""  
dw_rstr.Object.mm_from[ll_row] = "MM"
dw_rstr.Object.ccyy_from[ll_row] = "YEAR"
dw_rstr.Object.status[ll_row] = "P"
dw_rstr.Object.type[ll_row] = "S"

//Put in ue_postopen statement
////Insert a blank value in the invoice type choices
//This.Event ue_insert_null_cdw()

wf_enable_fields()  //04-03-96 FNC

//Protect criteria field depending if it is an archive or legacy subset
ls_type = dw_rstr.object.Type[ll_row]
wf_protect_criteria_field(ls_type)

istr_subset_options = lstr_sub_opt

cb_add.enabled = TRUE
cb_retrieve.enabled = True
cb_retrieve.default = True
cb_update.enabled = FALSE
cb_delete.enabled = FALSE
cb_details.enabled = FALSE
cb_model.enabled=false

dw_rstr.SetFocus()
SetMicroHelp(w_main,"Ready")
end event

event type integer ue_update_restore();//*******************************************************************
//	FDG 	12/05/00	Stars 4.7.  Make error checking DBMS-independent.
// GaryR	01/08/01	Stars 4.7 DataBase Port - Date Conversion.
// GaryR	01/17/01	Stars 4.7 DataBase Port - Empty String in SQL.
// FNC 	01/09/02 FNC track 2627. Ls_empty not used in this script.
//							It is also replaced by is_empty
//*******************************************************************

integer li_rc
long ll_row
string ls_restore_id, hold_mm, hold_ccyy
date ldt_paid_date, ld_dummy

// FDG 04/16/01 - Empty string = ' ' in Oracle
//li_rc	=	gnv_sql.of_TrimData (ls_empty)

ld_dummy = Date( "01/01/2001" )	// GaryR	01/08/01	Stars 4.7 DataBase Port
dw_rstr.EVENT ue_update( TRUE, TRUE )

// FDG 12/05/00 - Make error checking DBMS-independent
//If stars2ca.sqldbcode = gv_sql_dup or stars2ca.sqldbcode = gv_sql_dup2 then
IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		SetMicroHelp(w_main,'Ready')
		MessageBox("ERROR","You have attempted to add a duplicate restore request ID number") 
		dw_rstr.SetFocus()
		rollback using stars2ca;
		If stars2ca.of_check_status() <> 0 Then
			Messagebox('EDIT','Error Commiting to Stars2')
			Return -1
		End If	
		RETURN -1
Else
	if stars2ca.sqldbcode <> 0 then
		SetMicroHelp(w_main,'Ready') 
		errorbox(stars2ca,'Error inserting into the Restore Request Table')
				dw_rstr.Object.SetFocus()
		return -1
	end if
end if

ll_row = dw_rstr.GetRow()
ls_restore_id = dw_rstr.Object.Rstr_Id[ll_row]	

//remove all records first from control table
DELETE from RESTORE_CNTL
     Where (RSTR_ID = Upper( :ls_restore_id ) )
	  Using stars2ca;
IF stars2ca.of_check_status() < 0 Then
	SetMicroHelp(w_main,'Ready')
   errorbox(stars2ca,'Error deleting from the restore request control table')
	RETURN -1
end if 

// now add individual restore control rows
hold_mm = dw_rstr.object.mm_from[ll_row]
hold_ccyy = dw_rstr.object.ccyy_from[ll_row]
Do While ( (date(hold_mm + "/01/" + hold_ccyy)) <= iv_rstr_to_date) 
	ldt_paid_date = date(hold_mm + "/01/" + hold_ccyy) 
	INSERT INTO RESTORE_CNTL
	VALUES (:ls_restore_id,   
           :ldt_paid_date,
           'P',			// GaryR	01/17/01	Stars 4.7 DataBase Port
				0,
				' ',
				:ld_dummy
          ) Using stars2ca;
	hold_mm = string(integer(hold_mm) + 1)
	if integer(hold_mm) > 12 then
		hold_mm = "1"
		hold_ccyy = string(integer(hold_ccyy) + 1)
	end if
	//	Duplicate record is an error.
	// FDG 12/05/00 - Make error checking DBMS-independent
	//If stars2ca.sqldbcode = gv_sql_dup or stars2ca.sqldbcode = gv_sql_dup2 then
	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		SetMicroHelp(w_main,'Ready')
		MessageBox("ERROR","You have attempted to add a duplicate restore CNTL request ID number") 
		dw_rstr.SetFocus()
		rollback using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			Messagebox('EDIT','Error Commiting to Stars2')
			Return -1
		End If	
		RETURN -1
	Else
		if stars2ca.sqldbcode <> 0 then
			SetMicroHelp(w_main,'Ready') 
			errorbox(stars2ca,'Error inserting into the Restore CNTL Table')
			dw_rstr.SetFocus()
			return -1
		end if
	end if
LOOP     /* end of cntl row loop */

li_rc = wf_get_existing_crit_id() 
if li_rc <> 0 then
     messagebox('EDIT','Error getting existing criteria')
     return -1
end if

li_rc = wf_delete_criteria()
if li_rc <> 0 then
     messagebox('EDIT','Error deleting old criteria')
     return -1
end if

li_rc = wf_write_criteria()
if li_rc <> 0 then
     messagebox('EDIT','Error creating criteria')
     return -1
end if


COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return -1
End If	
SetMicroHelp(w_main,'Request has been added/updated')    //04-15-96 FNC

//dw_rstr.Object.Rstr_Id.Protect = 1
dw_rstr.object.status[ll_row] = "P"
dw_rstr.object.status_msg[ll_row] = "Restore Requested"     
cb_update.enabled = TRUE
cb_delete.enabled = TRUE
cb_clear.default = TRUE
cb_clear.setfocus()
if is_type = 'S' then           //12-05-95 FNC Start
   cb_details.enabled = TRUE
end if                          //12-05-95 FNC End
cb_add.enabled=false
cb_model.enabled=true

Return 0
end event

event type integer ue_general_edits();//**************************************************************************
// ue_general_edits  This script validate data entered by the user         
//**************************************************************************
// 09-08-98 AJS Track#387 Add windowing for to date edit                   
// 12-01-98 JGG Track#387 Comment out code that puts 19 into ccyy_to twice 
// 12-01-98 JGG Track#387 Force user to enter a 4 digit year     
//	10/30/01	FDG Track2471 (Stardev) - rstr_id could be ' '.
// 01/09/02 FNC Track 2627 Trim fields before comparing to ""
//**************************************************************************
datetime ldte_current_datetime
long ll_row
string ls_ccyy, ls_date, ls_invoice_type
String	ls_rstr_id							// FDG 10/30/01

ll_row = dw_rstr.GetRow()

ls_rstr_id	=	dw_rstr.Object.rstr_id [ll_row]		// FDG 10/30/01
ls_rstr_id	=	Trim (ls_rstr_id)							// FDG 10/30/01

if dw_rstr.Object.Type[ll_row] = 'M' then
   is_type = 'M' 
   wf_clear_fields()
else
   is_type = 'S'
end if

//Get server Date & time
ldte_current_datetime = gnv_app.of_get_server_date_time()
	
//Check date_required
If (trim(string(dw_rstr.Object.Required_Date[ll_row])) = '' or IsNull(dw_rstr.Object.Required_Date[ll_row])) then
	dw_rstr.Object.Required_Date[ll_row] = ldte_current_datetime
End If

If not (isdate(string(Date(dw_rstr.Object.Required_Date[ll_row])))) then
	dw_rstr.SetFocus()
	MessageBox("ERROR","Please Enter A Valid Date Required")
	Return -1
End If

//Set date requested
dw_rstr.Object.Req_Date[ll_row] = ldte_current_datetime

//Edit MM_FROM
if not (isnumber(dw_rstr.object.mm_from[ll_row])) then
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_from')
	MessageBox("ERROR","Please enter a valid month")
	return -1
end if
if (integer(dw_rstr.object.mm_from[ll_row]) < 1) or (integer(dw_rstr.object.mm_from[ll_row]) > 12) then
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_from')
	MessageBox("ERROR","Please enter a valid month")
	return -1
end if

//Edit CCYY_FROM
ls_ccyy = dw_rstr.object.ccyy_from[ll_row]
// 12-01-98 JGG - Accept 4 digit year only.
if (len(ls_ccyy) < 4) or not (isnumber(ls_ccyy)) then
	MessageBox("ERROR","Please Enter A Valid Four Digit Year from 1980 onward")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('ccyy_from')
	return -1
end if
	
if (dw_rstr.object.ccyy_from[ll_row] < '1980') or (dw_rstr.object.ccyy_from[ll_row] > '2099') then
	MessageBox("ERROR","Please Enter A Valid Year from 1980 onward")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('ccyy_from')
	return -1
end if

//Edit MM_TO
if trim(dw_rstr.object.mm_to[ll_row]) = "" then 	//01/09/02 FNC
elseif not (isnumber(dw_rstr.object.mm_to[ll_row])) then
	MessageBox("ERROR","Please enter a valid month")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_to')
	return -1
elseif (integer(dw_rstr.object.mm_to[ll_row]) < 1) or (integer(dw_rstr.object.mm_to[ll_row]) > 12) then
	MessageBox("ERROR","Please enter a valid month")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_to')
	return -1
end if

//Edit CCYY_TO
// 09-08-98 AJS Track#387
ls_ccyy = dw_rstr.object.ccyy_to[ll_row]
if (len(ls_ccyy) < 4) or not (isnumber(ls_ccyy)) then
	MessageBox("ERROR","Please Enter A Valid Four Digit Year from 1980 onward")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('ccyy_to')
	return -1
end if
	
if (dw_rstr.object.ccyy_to[ll_row] < '1980') or (dw_rstr.object.ccyy_to[ll_row] > '2099') then
	MessageBox("ERROR","Please Enter A Valid Year from 1980 onward")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('ccyy_to')
	return -1
end if

push_over()

 
//Edit to make sure at least one invoice type has been filled in
//FNC 01/09/02 Start
If (trim(dw_rstr.Object.rstr_invt_1[ll_row]) = ""	or IsNull(dw_rstr.Object.rstr_invt_1[ll_row]))	&
	and (trim(dw_rstr.Object.rstr_invt_2[ll_row]) = ""	or IsNull(dw_rstr.Object.rstr_invt_2[ll_row]))	&
	and (trim(dw_rstr.Object.rstr_invt_3[ll_row]) = ""	or IsNull(dw_rstr.Object.rstr_invt_3[ll_row]))	&
	and (trim(dw_rstr.Object.rstr_invt_4[ll_row]) = ""	or IsNull(dw_rstr.Object.rstr_invt_4[ll_row]))	&
	and (trim(dw_rstr.Object.rstr_invt_5[ll_row]) = ""	or IsNull(dw_rstr.Object.rstr_invt_5[ll_row]))	 then
   	messagebox("ERROR","Please enter at least one INVOICE TYPE")
      return -1
End If
//FNC 01/09/02 end

ls_invoice_type = trim(dw_rstr.Object.rstr_invt_2[ll_row])
If ls_invoice_type < " " then
		is_sub_tbl_type = dw_rstr.Object.rstr_invt_1[ll_row]
else
		is_sub_tbl_type = 'MC'
End If
	
//Edit to make sure at least one field has been filled in
if is_type = 'S' then															// 01/09/02 FNC Start
  if (trim(dw_rstr.Object.rstr_recp_1[ll_row]) = ""	or IsNull(dw_rstr.Object.rstr_recp_1[ll_row]))	&
   and (trim(dw_rstr.Object.rstr_prov_1[ll_row]) = "" or IsNull(dw_rstr.Object.rstr_prov_1[ll_row]))&	
	and (trim(dw_rstr.Object.rstr_icn_1[ll_row]) = "" or IsNull(dw_rstr.Object.rstr_icn_1[ll_row])) &
   and (trim(dw_rstr.Object.rstr_upin_1[ll_row]) = "" or IsNull(dw_rstr.Object.rstr_upin_1[ll_row])) then    //03-26-96 FNC
   	messagebox("ERROR","Please enter at least one ICN, PROV ID, UPIN, or PATIENT ID")
      return -1
  end if
end if

if is_type = 'M' then
  if (trim(dw_rstr.Object.rstr_recp_1[ll_row]) =  "" or IsNull(dw_rstr.Object.rstr_recp_1[ll_row]))				&
   and (trim(dw_rstr.Object.rstr_prov_1[ll_row]) = "" or IsNull(dw_rstr.Object.rstr_prov_1[ll_row]))	then
   	messagebox("ERROR","Please enter at least one PROV ID or PATIENT ID")
      return -1
  end if																				// 01/09/02 FNC End
end if                                      //03-20-96 FNC End


//Edit the periods entered
//Check from date
ls_date = dw_rstr.object.mm_from[ll_row] + "/01/" + dw_rstr.object.ccyy_from[ll_row]
if not isdate(ls_date) then
	messagebox("ERROR","Please Enter A Valid Paid Date To Restore")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_from')
	return -1
else
	iv_rstr_from_date = date(ls_date)
end if

//If to date empty set to from date
if (trim(dw_rstr.object.mm_to[ll_row]) < " ") and (TRIM(dw_rstr.object.ccyy_to[ll_row]) < " ") then
	dw_rstr.object.mm_to[ll_row] = dw_rstr.object.mm_from[ll_row]
	dw_rstr.object.ccyy_to[ll_row] = dw_rstr.object.ccyy_from[ll_row] 
end if

//check to date
ls_date = dw_rstr.object.mm_to[ll_row] + "/01/" + dw_rstr.object.ccyy_to[ll_row]
if not isdate(ls_date) then
	messagebox("ERROR","Please Enter A Valid Paid Date To Restore")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_to')
	return -1
else
	iv_rstr_to_date = date(ls_date)
end if 

//check that to date is not less than from date
if iv_rstr_to_date < iv_rstr_from_date then
	messagebox("ERROR","Please Enter A Valid Paid Date Period To Restore.  Ending date may not be less than beginning date!")
	dw_rstr.setfocus()
	dw_rstr.setcolumn('mm_from')
	return -1
end if 


//03-14-96 FNC Start
//If getting data from legacy system; check to ensure those periods are
//available.  The iv_from_date and iv_to_date are set on the open from
//the ROLL_CNTL table.
if is_type = 'S' then
  if (iv_rstr_from_date < date(iv_from_date)) 		&
	  OR (iv_rstr_to_date > date(iv_to_date)) then	
	  Messagebox("ERROR","The restore period date range requested is outside the range of available data.  The range available is " + string(date(iv_from_date))  + " to " + string(date(iv_to_date)) + ".")
	  return -1
  end if
end if
//03-14-96 FNC End

//Get next restore ID if empty
// FDG 10/30/01 - Account for " " in rstr_id
//if (dw_rstr.Object.Rstr_Id[ll_row] = "" or IsNull(dw_rstr.Object.Rstr_Id[ll_row])) then
if (Trim(ls_rstr_id) = "" or IsNull(ls_rstr_id)) then
	dw_rstr.Object.Rstr_Id[ll_row] = fx_get_next_key_id("RSTR")
	is_rstr_id = dw_rstr.Object.Rstr_Id[ll_row]
end if
Return 0
end event

event ue_insert_null_cdw;call super::ue_insert_null_cdw;DataWindowChild ldwc_invt_1
DataWindowChild ldwc_invt_2
DataWindowChild ldwc_invt_3
DataWindowChild ldwc_invt_4
DataWindowChild ldwc_invt_5

long ll_row

dw_rstr.GetChild('rstr_invt_1',ldwc_invt_1)
ll_row = ldwc_invt_1.InsertRow(1)
ldwc_invt_1.SetItem(ll_row, "ID_2", '') 
ldwc_invt_1.SetItem(ll_row, "description", '') 


dw_rstr.GetChild('rstr_invt_2',ldwc_invt_2)
ll_row = ldwc_invt_2.InsertRow(1)
ldwc_invt_2.SetItem(ll_row, "ID_2", '') 
ldwc_invt_2.SetItem(ll_row, "description", '') 

dw_rstr.GetChild('rstr_invt_3',ldwc_invt_3)
ll_row = ldwc_invt_3.InsertRow(1)
ldwc_invt_3.SetItem(ll_row, "ID_2", '') 
ldwc_invt_3.SetItem(ll_row, "description", '') 

dw_rstr.GetChild('rstr_invt_4',ldwc_invt_4)
ll_row = ldwc_invt_4.InsertRow(1)
ldwc_invt_4.SetItem(ll_row, "ID_2", '') 
ldwc_invt_4.SetItem(ll_row, "description", '') 

dw_rstr.GetChild('rstr_invt_5',ldwc_invt_5)
ll_row = ldwc_invt_5.InsertRow(1)
ldwc_invt_5.SetItem(ll_row, "ID_2", '') 
ldwc_invt_5.SetItem(ll_row, "description", '') 

Return 0
end event

event ue_filter_cdw;call super::ue_filter_cdw;DataWindowChild ldwc_invt[5]
integer li_inv_idx, li_dwc_index
string invoice[], ls_filter
long ll_row

//Get a handle to each of the dropdown datawindows
dw_rstr.GetChild('rstr_invt_1',ldwc_invt[1])
dw_rstr.GetChild('rstr_invt_2',ldwc_invt[2])
dw_rstr.GetChild('rstr_invt_3',ldwc_invt[3])
dw_rstr.GetChild('rstr_invt_4',ldwc_invt[4])
dw_rstr.GetChild('rstr_invt_5',ldwc_invt[5])

//Get the invoice type of each drop down
ll_row = dw_rstr.GetRow()
invoice[1] = dw_rstr.object.rstr_invt_1[ll_row]
invoice[2] = dw_rstr.object.rstr_invt_2[ll_row]
invoice[3] = dw_rstr.object.rstr_invt_3[ll_row]
invoice[4] = dw_rstr.object.rstr_invt_4[ll_row]
invoice[5] = dw_rstr.object.rstr_invt_5[ll_row]

If TRIM(as_cdw_changed) > '' then
	Choose case	as_cdw_changed
		Case 'rstr_invt_1'
			invoice[1] = as_cdw_new_value
		Case 'rstr_invt_2'
			invoice[2] = as_cdw_new_value
		Case 'rstr_invt_3'
			invoice[3] = as_cdw_new_value
		Case 'rstr_invt_4'
			invoice[4] = as_cdw_new_value
		Case 'rstr_invt_5'
			invoice[5] = as_cdw_new_value
	End Choose
End If
			

//	Filter out the used invoices
//	You want to remove all used invoices from the dddw except 
//	the one that specific childatawindow is using.

//	The outer for loop, spins thru each of the five child data windows
//		Clears out the filter, Sets the filter, and applys the filter.
// The inner for loop, spins thru each of the used invoices, if the used
//    invoice is from the childdatawindow you are on then don't filter
//    it out.  Also if the invoice is blank, don't filter it out.

For li_dwc_index = 1 to 5
//clear out the filter for the child datawindow
ldwc_invt[li_dwc_index].SetFilter('')
ldwc_invt[li_dwc_index].Filter()
ls_filter = ""
	//set up the filter for the child datawindow
	For li_inv_idx = 1 to 5 
		If li_inv_idx = li_dwc_index then continue
			If trim(invoice[li_inv_idx]) <> '' then
				ls_filter = ls_filter + " and ID_2 <> '" + invoice[li_inv_idx] + "'"
			End If
	Next
	ls_filter = mid(ls_filter,6)
//Apply the filter for the datawindow
ldwc_invt[li_dwc_index].SetFilter(ls_filter)
ldwc_invt[li_dwc_index].Filter()
Next


Return 0
end event

public subroutine wf_disable_fields ();////**************************************************************
//// 04-03-96 FNC Disable all fields if request has been run or if
////              the request was input by a different user
////**************************************************************

dw_rstr.Object.DataWindow.ReadOnly = true
end subroutine

public subroutine wf_enable_fields ();//**************************************************************
// 04-03-96 FNC Enable all fields that were disabled
//              if request has been run or if the request was 
//              input by a different user
//**************************************************************

dw_rstr.Object.DataWindow.ReadOnly = False








end subroutine

public subroutine wf_protect_criteria_field (string as_type);If as_type = 'S' then
      dw_rstr.object.rstr_icn_1.protect = 0
      dw_rstr.object.rstr_icn_2.protect = 0
      dw_rstr.object.rstr_icn_3.protect = 0
      dw_rstr.object.rstr_icn_4.protect = 0
      dw_rstr.object.rstr_icn_5.protect = 0
      dw_rstr.object.rstr_type_1.protect = 0
      dw_rstr.object.rstr_type_2.protect = 0
      dw_rstr.object.rstr_type_3.protect = 0
      dw_rstr.object.rstr_type_4.protect = 0
      dw_rstr.object.rstr_type_5.protect = 0
      dw_rstr.object.rstr_upin_1.protect = 0
      dw_rstr.object.rstr_upin_2.protect = 0
      dw_rstr.object.rstr_upin_3.protect = 0
      dw_rstr.object.rstr_upin_4.protect = 0
      dw_rstr.object.rstr_upin_5.protect = 0
      dw_rstr.object.rstr_proc_1.protect = 0
      dw_rstr.object.rstr_proc_2.protect = 0
      dw_rstr.object.rstr_proc_3.protect = 0
      dw_rstr.object.rstr_proc_4.protect = 0
      dw_rstr.object.rstr_proc_5.protect = 0
      dw_rstr.object.rstr_diag_1.protect = 0
      dw_rstr.object.rstr_diag_2.protect = 0
      dw_rstr.object.rstr_diag_3.protect = 0
      dw_rstr.object.rstr_diag_4.protect = 0
      dw_rstr.object.rstr_diag_5.protect = 0
      dw_rstr.object.rstr_area_1.protect = 0
      dw_rstr.object.rstr_area_2.protect = 0
      dw_rstr.object.rstr_area_3.protect = 0
      dw_rstr.object.rstr_area_4.protect = 0
      dw_rstr.object.rstr_area_5.protect = 0
else
      dw_rstr.object.rstr_icn_1.protect = 1
      dw_rstr.object.rstr_icn_2.protect = 1
      dw_rstr.object.rstr_icn_3.protect = 1
      dw_rstr.object.rstr_icn_4.protect = 1
      dw_rstr.object.rstr_icn_5.protect = 1
      dw_rstr.object.rstr_type_1.protect = 1
      dw_rstr.object.rstr_type_2.protect = 1
      dw_rstr.object.rstr_type_3.protect = 1
      dw_rstr.object.rstr_type_4.protect = 1
      dw_rstr.object.rstr_type_5.protect = 1
      dw_rstr.object.rstr_upin_1.protect = 1
      dw_rstr.object.rstr_upin_2.protect = 1
      dw_rstr.object.rstr_upin_3.protect = 1
      dw_rstr.object.rstr_upin_4.protect = 1
      dw_rstr.object.rstr_upin_5.protect = 1
      dw_rstr.object.rstr_proc_1.protect = 1
      dw_rstr.object.rstr_proc_2.protect = 1
      dw_rstr.object.rstr_proc_3.protect = 1
      dw_rstr.object.rstr_proc_4.protect = 1
      dw_rstr.object.rstr_proc_5.protect = 1
      dw_rstr.object.rstr_diag_1.protect = 1
      dw_rstr.object.rstr_diag_2.protect = 1
      dw_rstr.object.rstr_diag_3.protect = 1
      dw_rstr.object.rstr_diag_4.protect = 1
      dw_rstr.object.rstr_diag_5.protect = 1
      dw_rstr.object.rstr_area_1.protect = 1
      dw_rstr.object.rstr_area_2.protect = 1
      dw_rstr.object.rstr_area_3.protect = 1
      dw_rstr.object.rstr_area_4.protect = 1
      dw_rstr.object.rstr_area_5.protect = 1
End If
end subroutine

public function integer wf_delete_criteria ();//*****************************************************************
// 05-08-96 FNC Retrieve the original subset id to use for deleting
//              criteria
// 03-26-96 FNC STARS31 prob #223 
//              DELETE criteria from criteria table.
//*****************************************************************

string ls_by_id,ls_rstr_id
long ll_row

//05-08-96 FNC Start

SELECT by_id into :ls_by_id
from criteria_used 
where crit_id = Upper( :is_existing_crit )
using stars2ca;

If stars2ca.of_check_status() = 100 then
	//this is not a problem, we were only going to delete the criteria
ElseIf stars2ca.of_check_status() <> 0 Then  //VAV 4.0 2/11/98
   ErrorBox(stars2ca,'Error retrieving subset id from criteria used table while deleting criteria')
   RETURN -1
End if


//05-08-96 FNC End


DELETE from criteria_used 
where by_id = Upper( :ls_by_id )    //05-08-96 FNC
using stars2ca;

If stars2ca.of_check_status() <> 0 then
   ErrorBox(stars2ca,'Error deleting criteria from the criteria table')
   RETURN -1
End if

DELETE from criteria_used_line
where by_id = Upper( :ls_by_id )    //05-08-96 FNC
using stars2ca;

If stars2ca.of_check_status() <> 0 Then  //VAV 4.0 2/11/98
   ErrorBox(stars2ca,'Error deleting criteria from the criteria_used_line table')
   RETURN -1
End if

DELETE from criteria_from_tbls_used
where by_id = Upper( :ls_by_id )    //05-08-96 FNC
using stars2ca;

If stars2ca.of_check_status() <> 0 Then  //VAV 4.0 2/11/98
   ErrorBox(stars2ca,'Error deleting criteria from the criteria table')
   RETURN -1
End if

RETURN 0


end function

public function integer wf_get_existing_crit_id ();//*********************************************************
//	Script:	wf_get_subset_id
//
//	Description:
//			This function gets the subset id and places it in 
//			is_existing_crit.
//
//*********************************************************
//restore Id to instance variable
//
//	08/28/01	GaryR	Track 2397d	Fix buggy code
//
//*********************************************************

select crit_id into :is_existing_crit
from restore_request_part_c
where rstr_id = Upper( :is_rstr_id )
using stars2ca;

//	08/28/01	GaryR	Track 2397d
//if stars2ca.of_check_status() <> 0 then
if stars2ca.of_check_status() = -1 then	
   errorbox(stars2ca,'Error retrieving crit id from restore request table while deleting criteria')
else
	commit using stars2ca;
end if

Return	stars2ca.sqlcode
end function

public function integer wf_clear_fields ();////**************************************************************
//// 12-05-95 FNC Modifications to add retrieval from mainframe
////**************************************************************
long ll_row

ll_row = dw_rstr.GetRow()
dw_rstr.object.rstr_icn_1[ll_row] = ""
dw_rstr.object.rstr_icn_2[ll_row] = ""
dw_rstr.object.rstr_icn_3[ll_row] = ""
dw_rstr.object.rstr_icn_4[ll_row] = ""
dw_rstr.object.rstr_icn_5[ll_row] = ""

//ajs 4.0 now need invoice type for both
//dw_rstr.object.rstr_invt_1[ll_row] = ""
//dw_rstr.object.rstr_invt_2[ll_row] = ""
//dw_rstr.object.rstr_invt_3[ll_row] = ""
//dw_rstr.object.rstr_invt_4[ll_row] = ""
//dw_rstr.object.rstr_invt_5[ll_row] = ""
dw_rstr.object.rstr_type_1[ll_row] = ""
dw_rstr.object.rstr_type_2[ll_row] = ""
dw_rstr.object.rstr_type_3[ll_row] = ""
dw_rstr.object.rstr_type_4[ll_row] = ""
dw_rstr.object.rstr_type_5[ll_row] = ""
dw_rstr.object.rstr_upin_1[ll_row] = ""
dw_rstr.object.rstr_upin_2[ll_row] = ""
dw_rstr.object.rstr_upin_3[ll_row] = ""
dw_rstr.object.rstr_upin_4[ll_row] = ""
dw_rstr.object.rstr_upin_5[ll_row] = ""
dw_rstr.object.rstr_proc_1[ll_row] = ""
dw_rstr.object.rstr_proc_2[ll_row] = ""
dw_rstr.object.rstr_proc_3[ll_row] = ""
dw_rstr.object.rstr_proc_4[ll_row] = ""
dw_rstr.object.rstr_proc_5[ll_row] = ""
dw_rstr.object.rstr_diag_1[ll_row] = ""
dw_rstr.object.rstr_diag_2[ll_row] = ""
dw_rstr.object.rstr_diag_3[ll_row] = ""
dw_rstr.object.rstr_diag_4[ll_row] = ""
dw_rstr.object.rstr_diag_5[ll_row] = ""
dw_rstr.object.rstr_area_1[ll_row] = ""
dw_rstr.object.rstr_area_2[ll_row] = ""
dw_rstr.object.rstr_area_3[ll_row] = ""
dw_rstr.object.rstr_area_4[ll_row] = ""
dw_rstr.object.rstr_area_5[ll_row] = ""
return 0
end function

public function integer wf_write_criteria ();//***************************************************************
// 02-08-96 FNC Write to criteria tables for purged history
// 05-22-96 FNC Write to criteria table for stars retrieval requests
// 06-11-96 FNC Check to see if request is purged to determine crit type
// 06-27-96 FNC STAR31 Prob #286 Write out the month end day in the to date of the
//              to date of the criteria line
// 03-16-98 ajs 4.0 TS145 - Hard Coding Removal
// 03-20-98 ajs 4.0 changed sles's to DW ans restore id to instance var
// 01/09/02 FNC Track 2627. Put dates in quotes.
//***************************************************************

string lv_desc,ls_month,ls_subset_id
datetime lv_datetime
date ld_to_date
int rc,lv_index,lv_upperbound
long ll_row
real lr_result

ll_row = dw_rstr.Getrow()

iv_crit_type = 'SUB' //VAV 4.0 2/6/98 - replaced the previous script

//Get server Date & time
lv_datetime = gnv_app.of_get_server_date_time()

lv_desc = 'CRITERIA CREATED FOR RESTORE REQUEST ' + is_rstr_id	//ajs 4.0 03-20-98

ls_subset_id = dw_rstr.object.subc_id[ll_row]

INSERT INTO CRITERIA_USED  
         ( BY_TYPE,   
           BY_ID,   
           BY_LEVEL,   
           CRIT_ID,   
           CRIT_SUB_TBL_TYPE,   
           CRIT_FLTR_IND,   
           CRIT_DATETIME,   
           CRIT_DESC,
			  Step_id )  
  VALUES ( :iv_crit_type,   
           :ls_subset_id,
           1,
           :iv_crit_id,
           :is_sub_tbl_type,
           ' ',
           :lv_datetime,   
           :lv_desc,
			  '1')  
USING stars2ca;

if stars2ca.of_check_status() <> 0 then
 	  Errorbox(Stars2ca,'Error inserting to Criteria Used')
     return -1 
end if

  INSERT INTO CRITERIA_FROM_TBLS_USED  
         ( BY_TYPE,   
           BY_ID,   
           BY_LEVEL,   
           TBL_1,   
           TBL_2,
			  step_id)
  VALUES ( :iv_crit_type,   
           :ls_subset_id,
           1,   
           :is_sub_tbl_type,   
           ' ',
			  '1')  
  USING stars2ca;


if stars2ca.of_check_status() <> 0 then
 	  Errorbox(Stars2ca,'Error inserting to Criteria from tbls used')
     return -1 
end if

lv_upperbound = upperbound(iv_crit_value)

for lv_index = 1 to lv_upperbound
  iv_crit_value[lv_index] = is_empty
  iv_crit_field[lv_index] = is_empty
  iv_crit_logic[lv_index] = is_empty  
  iv_crit_right_paren[lv_index] = is_empty
  iv_crit_left_paren[lv_index] = is_empty
  iv_crit_oper[lv_index] = is_empty
next


//05-22-96 FNC start

iv_crit_line_count = 0


if dw_rstr.object.rstr_area_1[ll_row] <> is_empty then
//	wf_load_area_crit()
	wf_load_criteria('.PROV_AREA',dw_rstr.object.rstr_area_1[ll_row],dw_rstr.object.rstr_area_2[ll_row],dw_rstr.object.rstr_area_3[ll_row],dw_rstr.object.rstr_area_4[ll_row],dw_rstr.object.rstr_area_5[ll_row])
end if

if dw_rstr.object.rstr_recp_1[ll_row] <> is_empty then
//	wf_load_bene_crit()
	wf_load_criteria('.RECIP_ID',dw_rstr.object.rstr_recp_1[ll_row],dw_rstr.object.rstr_recp_2[ll_row],dw_rstr.object.rstr_recp_3[ll_row],dw_rstr.object.rstr_recp_4[ll_row],dw_rstr.object.rstr_recp_5[ll_row])
end if

if dw_rstr.object.rstr_diag_1[ll_row] <> is_empty then
//	wf_load_diag_crit()
	wf_load_criteria('.PRINCIPAL_DIAG',dw_rstr.object.rstr_diag_1[ll_row],dw_rstr.object.rstr_diag_2[ll_row],dw_rstr.object.rstr_diag_3[ll_row],dw_rstr.object.rstr_diag_4[ll_row],dw_rstr.object.rstr_diag_5[ll_row])
end if

if dw_rstr.object.rstr_icn_1[ll_row] <> is_empty then
//	wf_load_icn_crit()
	wf_load_criteria('.ICN',dw_rstr.object.rstr_icn_1[ll_row],dw_rstr.object.rstr_icn_2[ll_row],dw_rstr.object.rstr_icn_3[ll_row],dw_rstr.object.rstr_icn_4[ll_row],dw_rstr.object.rstr_icn_5[ll_row])
end if

if dw_rstr.object.rstr_invt_1[ll_row] <> is_empty then
//	wf_load_invt_crit()
	wf_load_criteria('.INVOICE_TYPE',dw_rstr.object.rstr_invt_1[ll_row],dw_rstr.object.rstr_invt_2[ll_row],dw_rstr.object.rstr_invt_3[ll_row],dw_rstr.object.rstr_invt_4[ll_row],dw_rstr.object.rstr_invt_5[ll_row])
end if

if dw_rstr.object.rstr_proc_1[ll_row] <> is_empty then
//	wf_load_proc_crit()
	wf_load_criteria('.PROC_CODE',dw_rstr.object.rstr_proc_1[ll_row],dw_rstr.object.rstr_proc_2[ll_row],dw_rstr.object.rstr_proc_3[ll_row],dw_rstr.object.rstr_proc_4[ll_row],dw_rstr.object.rstr_proc_5[ll_row])
end if

if dw_rstr.object.rstr_prov_1[ll_row] <> is_empty then
//	wf_load_prov_crit()
	wf_load_criteria('.PROV_ID',dw_rstr.object.rstr_prov_1[ll_row],dw_rstr.object.rstr_prov_2[ll_row],dw_rstr.object.rstr_prov_3[ll_row],dw_rstr.object.rstr_prov_4[ll_row],dw_rstr.object.rstr_prov_5[ll_row])
end if

if dw_rstr.object.rstr_type_1[ll_row] <> is_empty then
//	wf_load_type_crit()
	wf_load_criteria('.PROV_TYPE',dw_rstr.object.rstr_type_1[ll_row],dw_rstr.object.rstr_type_2[ll_row],dw_rstr.object.rstr_type_3[ll_row],dw_rstr.object.rstr_type_4[ll_row],dw_rstr.object.rstr_type_5[ll_row])
end if

if dw_rstr.object.rstr_upin_1[ll_row] <> is_empty then
//	wf_load_upin_crit()
	wf_load_criteria('.PROV_UPIN',dw_rstr.object.rstr_upin_1[ll_row],dw_rstr.object.rstr_upin_2[ll_row],dw_rstr.object.rstr_upin_3[ll_row],dw_rstr.object.rstr_upin_4[ll_row],dw_rstr.object.rstr_upin_5[ll_row])
end if


//05-22-96 FNC start
//06-27-96 FNC Start

if integer(dw_rstr.object.mm_to[ll_row]) > 9 then
	ls_month = dw_rstr.object.mm_to[ll_row]
else
	ls_month = '0' + right(dw_rstr.object.mm_to[ll_row],1)
end if

if pos('04060911',ls_month) > 0 then
	ld_to_date = date(ls_month + "/30/" + dw_rstr.object.ccyy_to[ll_row])
elseif pos('01030507081012',ls_month) > 0  then
	ld_to_date = date(ls_month + "/31/" + dw_rstr.object.ccyy_to[ll_row])
else
	lr_result = real(dw_rstr.object.ccyy_to[ll_row]) / 4
	if pos(string(lr_result), '.') = 0 then
		lr_result = real(dw_rstr.object.ccyy_to[ll_row]) / 100
		if pos(string(lr_result),'.') <> 0 then
			ld_to_date = date(ls_month + "/29/" + dw_rstr.object.ccyy_to[ll_row])
		else
			lr_result = real(dw_rstr.object.ccyy_to[ll_row]) / 400
			if pos(string(lr_result),'.') = 0 then
				ld_to_date = date(ls_month + "/29/" + dw_rstr.object.ccyy_to[ll_row])
			else
				ld_to_date = date(ls_month + "/28/" + dw_rstr.object.ccyy_to[ll_row])
			end if
		end if
	else
		lr_result = real(dw_rstr.object.ccyy_to[ll_row]) / 400
		if pos(string(lr_result),'.') = 0 then
			ld_to_date = date(ls_month + "/29/" + dw_rstr.object.ccyy_to[ll_row])
		else
			ld_to_date = date(ls_month + "/28/" + dw_rstr.object.ccyy_to[ll_row])
		end if
	end if
end if
//06-27-96 FNC Start

iv_crit_line_count++
if iv_crit_line_count > 1 then
   iv_crit_logic[iv_crit_line_count - 1] = 'AND'
end if
iv_crit_left_paren[iv_crit_line_count] = '('
iv_crit_right_paren[iv_crit_line_count] = ')'
iv_crit_field[iv_crit_line_count] = is_sub_tbl_type+ '.PAYMENT_DATE'
// FNC 01/09/02
iv_crit_value[iv_crit_line_count] = "'" + String(iv_rstr_from_date, "mm/dd/yyyy") + "'" + &
												",'" + String(ld_to_date, "mm/dd/yyyy") + "'"
iv_crit_oper[iv_crit_line_count] = 'BETWEEN'


rc = wf_write_criteria_line()
if rc <> 0 then
   return -1
end if

return 0

end function

public subroutine wf_load_criteria (string as_crit_field, string as_field1, string as_field2, string as_field3, string as_field4, string as_field5);//AJS 4.0 03-20-98 Changed sle's to a datatwindow
// FNC 01/09/02 Track 2627. Put values inside of parenthesis with quotes around each value

if as_field1 <> is_empty then
   iv_crit_line_count++
   iv_crit_left_paren[iv_crit_line_count] = '('
   iv_crit_value[iv_crit_line_count] = "('" + as_field1 + "'"
   iv_crit_field[iv_crit_line_count] = is_sub_tbl_type + as_crit_field
   iv_crit_oper[iv_crit_line_count] = 'IN'
   if iv_crit_line_count > 1 then
      iv_crit_logic[iv_crit_line_count - 1] = 'AND'
   end if
end if

if as_field2 <> is_empty then
   iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + &
													",'" + as_field2 + "'"
	if as_field3 <> is_empty then
   	iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + &
													",'" + as_field3 + "'"				
		if as_field4 <> is_empty then
		   iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + &
													",'" + as_field4 + "'"
			if as_field5 <> is_empty then
			   iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + &
													",'" + as_field5 + "')"													
			else		
				iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + ")"
			end if 
		else
			iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + ")"
		end if													
	else
		iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + ")"
	end if
else
	iv_crit_value[iv_crit_line_count] = iv_crit_value[iv_crit_line_count] + ")"
end if


if as_field1 <> is_empty then
   iv_crit_right_paren[iv_crit_line_count] = ')'
end if


if iv_crit_line_count > 1 then
   iv_crit_logic[iv_crit_line_count - 1] = 'AND'
end if
end subroutine

public subroutine push_over ();//////////////////////////////////////////////////////////////
//
//	03-20-98 ajs 4.0 change all sle's to datawindow fields
//	08/28/01	GaryR	Track 2397d	Using empty string in SQL
// 01/09/02 FNC 	Track 2627 trim value before checking if
//						should push over. Use is_empty instead of
//						ls_empty
//////////////////////////////////////////////////////////////

Int lv_loop_ctr
lv_loop_ctr = 0
long ll_row

//	08/28/01	GaryR	Track 2397d - Begin
//String	is_empty
//gnv_sql.of_TrimData( is_empty )
////	08/28/01	GaryR	Track 2397d - End

ll_row = dw_rstr.GetRow()

DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_icn_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_icn_1[ll_row] = dw_rstr.object.rstr_icn_2[ll_row]
   dw_rstr.object.rstr_icn_2[ll_row] = dw_rstr.object.rstr_icn_3[ll_row]
   dw_rstr.object.rstr_icn_3[ll_row] = dw_rstr.object.rstr_icn_4[ll_row]
   dw_rstr.object.rstr_icn_4[ll_row] = dw_rstr.object.rstr_icn_5[ll_row]
   dw_rstr.object.rstr_icn_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_icn_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_icn_2[ll_row] = dw_rstr.object.rstr_icn_3[ll_row]
      dw_rstr.object.rstr_icn_3[ll_row] = dw_rstr.object.rstr_icn_4[ll_row]
      dw_rstr.object.rstr_icn_4[ll_row] = dw_rstr.object.rstr_icn_5[ll_row]
      dw_rstr.object.rstr_icn_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_icn_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_icn_3[ll_row] = dw_rstr.object.rstr_icn_4[ll_row]
         dw_rstr.object.rstr_icn_4[ll_row] = dw_rstr.object.rstr_icn_5[ll_row]
         dw_rstr.object.rstr_icn_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_icn_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_icn_4[ll_row] = dw_rstr.object.rstr_icn_5[ll_row]
            dw_rstr.object.rstr_icn_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_invt_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_invt_1[ll_row] = dw_rstr.object.rstr_invt_2[ll_row]
   dw_rstr.object.rstr_invt_2[ll_row] = dw_rstr.object.rstr_invt_3[ll_row]
   dw_rstr.object.rstr_invt_3[ll_row] = dw_rstr.object.rstr_invt_4[ll_row]
   dw_rstr.object.rstr_invt_4[ll_row] = dw_rstr.object.rstr_invt_5[ll_row]
   dw_rstr.object.rstr_invt_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_invt_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_invt_2[ll_row] = dw_rstr.object.rstr_invt_3[ll_row]
      dw_rstr.object.rstr_invt_3[ll_row] = dw_rstr.object.rstr_invt_4[ll_row]
      dw_rstr.object.rstr_invt_4[ll_row] = dw_rstr.object.rstr_invt_5[ll_row]
      dw_rstr.object.rstr_invt_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_invt_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_invt_3[ll_row] = dw_rstr.object.rstr_invt_4[ll_row]
         dw_rstr.object.rstr_invt_4[ll_row] = dw_rstr.object.rstr_invt_5[ll_row]
         dw_rstr.object.rstr_invt_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_invt_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_invt_4[ll_row] = dw_rstr.object.rstr_invt_5[ll_row]
            dw_rstr.object.rstr_invt_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_prov_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_prov_1[ll_row] = dw_rstr.object.rstr_prov_2[ll_row]
   dw_rstr.object.rstr_prov_2[ll_row] = dw_rstr.object.rstr_prov_3[ll_row]
   dw_rstr.object.rstr_prov_3[ll_row] = dw_rstr.object.rstr_prov_4[ll_row]
   dw_rstr.object.rstr_prov_4[ll_row] = dw_rstr.object.rstr_prov_5[ll_row]
   dw_rstr.object.rstr_prov_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_prov_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_prov_2[ll_row] = dw_rstr.object.rstr_prov_3[ll_row]
      dw_rstr.object.rstr_prov_3[ll_row] = dw_rstr.object.rstr_prov_4[ll_row]
      dw_rstr.object.rstr_prov_4[ll_row] = dw_rstr.object.rstr_prov_5[ll_row]
      dw_rstr.object.rstr_prov_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_prov_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_prov_3[ll_row] = dw_rstr.object.rstr_prov_4[ll_row]
         dw_rstr.object.rstr_prov_4[ll_row] = dw_rstr.object.rstr_prov_5[ll_row]
         dw_rstr.object.rstr_prov_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_prov_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_prov_4[ll_row] = dw_rstr.object.rstr_prov_5[ll_row]
            dw_rstr.object.rstr_prov_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_type_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_type_1[ll_row] = dw_rstr.object.rstr_type_2[ll_row]
   dw_rstr.object.rstr_type_2[ll_row] = dw_rstr.object.rstr_type_3[ll_row]
   dw_rstr.object.rstr_type_3[ll_row] = dw_rstr.object.rstr_type_4[ll_row]
   dw_rstr.object.rstr_type_4[ll_row] = dw_rstr.object.rstr_type_5[ll_row]
   dw_rstr.object.rstr_type_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_type_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_type_2[ll_row] = dw_rstr.object.rstr_type_3[ll_row]
      dw_rstr.object.rstr_type_3[ll_row] = dw_rstr.object.rstr_type_4[ll_row]
      dw_rstr.object.rstr_type_4[ll_row] = dw_rstr.object.rstr_type_5[ll_row]
      dw_rstr.object.rstr_type_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_type_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_type_3[ll_row] = dw_rstr.object.rstr_type_4[ll_row]
         dw_rstr.object.rstr_type_4[ll_row] = dw_rstr.object.rstr_type_5[ll_row]
         dw_rstr.object.rstr_type_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_type_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_type_4[ll_row] = dw_rstr.object.rstr_type_5[ll_row]
            dw_rstr.object.rstr_type_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_upin_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_upin_1[ll_row] = dw_rstr.object.rstr_upin_2[ll_row]
   dw_rstr.object.rstr_upin_2[ll_row] = dw_rstr.object.rstr_upin_3[ll_row]
   dw_rstr.object.rstr_upin_3[ll_row] = dw_rstr.object.rstr_upin_4[ll_row]
   dw_rstr.object.rstr_upin_4[ll_row] = dw_rstr.object.rstr_upin_5[ll_row]
   dw_rstr.object.rstr_upin_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_upin_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_upin_2[ll_row] = dw_rstr.object.rstr_upin_3[ll_row]
      dw_rstr.object.rstr_upin_3[ll_row] = dw_rstr.object.rstr_upin_4[ll_row]
      dw_rstr.object.rstr_upin_4[ll_row] = dw_rstr.object.rstr_upin_5[ll_row]
      dw_rstr.object.rstr_upin_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_upin_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_upin_3[ll_row] = dw_rstr.object.rstr_upin_4[ll_row]
         dw_rstr.object.rstr_upin_4[ll_row] = dw_rstr.object.rstr_upin_5[ll_row]
         dw_rstr.object.rstr_upin_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_upin_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_upin_4[ll_row] = dw_rstr.object.rstr_upin_5[ll_row]
            dw_rstr.object.rstr_upin_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop


lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_recp_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_recp_1[ll_row] = dw_rstr.object.rstr_recp_2[ll_row]
   dw_rstr.object.rstr_recp_2[ll_row] = dw_rstr.object.rstr_recp_3[ll_row]
   dw_rstr.object.rstr_recp_3[ll_row] = dw_rstr.object.rstr_recp_4[ll_row]
   dw_rstr.object.rstr_recp_4[ll_row] = dw_rstr.object.rstr_recp_5[ll_row]
   dw_rstr.object.rstr_recp_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_recp_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_recp_2[ll_row] = dw_rstr.object.rstr_recp_3[ll_row]
      dw_rstr.object.rstr_recp_3[ll_row] = dw_rstr.object.rstr_recp_4[ll_row]
      dw_rstr.object.rstr_recp_4[ll_row] = dw_rstr.object.rstr_recp_5[ll_row]
      dw_rstr.object.rstr_recp_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_recp_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_recp_3[ll_row] = dw_rstr.object.rstr_recp_4[ll_row]
         dw_rstr.object.rstr_recp_4[ll_row] = dw_rstr.object.rstr_recp_5[ll_row]
         dw_rstr.object.rstr_recp_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_recp_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_recp_4[ll_row] = dw_rstr.object.rstr_recp_5[ll_row]
            dw_rstr.object.rstr_recp_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_proc_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_proc_1[ll_row] = dw_rstr.object.rstr_proc_2[ll_row]
   dw_rstr.object.rstr_proc_2[ll_row] = dw_rstr.object.rstr_proc_3[ll_row]
   dw_rstr.object.rstr_proc_3[ll_row] = dw_rstr.object.rstr_proc_4[ll_row]
   dw_rstr.object.rstr_proc_4[ll_row] = dw_rstr.object.rstr_proc_5[ll_row]
   dw_rstr.object.rstr_proc_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_proc_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_proc_2[ll_row] = dw_rstr.object.rstr_proc_3[ll_row]
      dw_rstr.object.rstr_proc_3[ll_row] = dw_rstr.object.rstr_proc_4[ll_row]
      dw_rstr.object.rstr_proc_4[ll_row] = dw_rstr.object.rstr_proc_5[ll_row]
      dw_rstr.object.rstr_proc_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_proc_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_proc_3[ll_row] = dw_rstr.object.rstr_proc_4[ll_row]
         dw_rstr.object.rstr_proc_4[ll_row] = dw_rstr.object.rstr_proc_5[ll_row]
         dw_rstr.object.rstr_proc_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_proc_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_proc_4[ll_row] = dw_rstr.object.rstr_proc_5[ll_row]
            dw_rstr.object.rstr_proc_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_diag_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_diag_1[ll_row] = dw_rstr.object.rstr_diag_2[ll_row]
   dw_rstr.object.rstr_diag_2[ll_row] = dw_rstr.object.rstr_diag_3[ll_row]
   dw_rstr.object.rstr_diag_3[ll_row] = dw_rstr.object.rstr_diag_4[ll_row]
   dw_rstr.object.rstr_diag_4[ll_row] = dw_rstr.object.rstr_diag_5[ll_row]
   dw_rstr.object.rstr_diag_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_diag_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_diag_2[ll_row] = dw_rstr.object.rstr_diag_3[ll_row]
      dw_rstr.object.rstr_diag_3[ll_row] = dw_rstr.object.rstr_diag_4[ll_row]
      dw_rstr.object.rstr_diag_4[ll_row] = dw_rstr.object.rstr_diag_5[ll_row]
      dw_rstr.object.rstr_diag_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_diag_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_diag_3[ll_row] = dw_rstr.object.rstr_diag_4[ll_row]
         dw_rstr.object.rstr_diag_4[ll_row] = dw_rstr.object.rstr_diag_5[ll_row]
         dw_rstr.object.rstr_diag_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_diag_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_diag_4[ll_row] = dw_rstr.object.rstr_diag_5[ll_row]
            dw_rstr.object.rstr_diag_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

lv_loop_ctr = 0
DO WHILE lv_loop_ctr <> 6

IF trim(dw_rstr.object.rstr_area_1[ll_row]) = "" THEN
   dw_rstr.object.rstr_area_1[ll_row] = dw_rstr.object.rstr_area_2[ll_row]
   dw_rstr.object.rstr_area_2[ll_row] = dw_rstr.object.rstr_area_3[ll_row]
   dw_rstr.object.rstr_area_3[ll_row] = dw_rstr.object.rstr_area_4[ll_row]
   dw_rstr.object.rstr_area_4[ll_row] = dw_rstr.object.rstr_area_5[ll_row]
   dw_rstr.object.rstr_area_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
ELSE
   IF trim(dw_rstr.object.rstr_area_2[ll_row]) = "" THEN
      dw_rstr.object.rstr_area_2[ll_row] = dw_rstr.object.rstr_area_3[ll_row]
      dw_rstr.object.rstr_area_3[ll_row] = dw_rstr.object.rstr_area_4[ll_row]
      dw_rstr.object.rstr_area_4[ll_row] = dw_rstr.object.rstr_area_5[ll_row]
      dw_rstr.object.rstr_area_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
   ELSE
      IF trim(dw_rstr.object.rstr_area_3[ll_row]) = "" THEN
         dw_rstr.object.rstr_area_3[ll_row] = dw_rstr.object.rstr_area_4[ll_row]
         dw_rstr.object.rstr_area_4[ll_row] = dw_rstr.object.rstr_area_5[ll_row]
         dw_rstr.object.rstr_area_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
      ELSE
         IF trim(dw_rstr.object.rstr_area_4[ll_row]) = "" THEN
            dw_rstr.object.rstr_area_4[ll_row] = dw_rstr.object.rstr_area_5[ll_row]
            dw_rstr.object.rstr_area_5[ll_row] = is_empty	//	08/28/01	GaryR	Track 2397d
         END IF
      END IF
   END IF
END IF
lv_loop_ctr++
loop

 
end subroutine

public function integer wf_write_criteria_line ();//****************************************************************
//
//	01/16/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	08/21/01	GaryR	Track 2410d	Convert Criteria_Used_Line to Upper case
//	08/28/01	GaryR	Track 2397d	Fix buggy code
// 01/09/02 FNC Track 2627 Replace ls_empty with is_empty
//****************************************************************

int lv_index
long ll_row
string ls_subset_id

//	01/16/01	GaryR	Stars 4.7 DataBase Port
String	ls_lp, ls_rp, ls_logic
//gnv_sql.of_TrimData( ls_empty )		//FNC 01/09/02

ll_row = dw_rstr.Getrow()
ls_subset_id = dw_rstr.object.subc_id[ll_row]

For lv_index = 1 to iv_crit_line_count

	//	01/16/01	GaryR	Stars 4.7 DataBase Port - Begin
	ls_lp		= iv_crit_left_paren[lv_index]
	ls_rp		= iv_crit_right_paren[lv_index]
	
	//	08/28/01	GaryR	Track 2397d - Begin
	IF lv_index = iv_crit_line_count THEN
		ls_logic = ""
	ELSE
		ls_logic	= iv_crit_logic[lv_index]
	END IF
	//	08/28/01	GaryR	Track 2397d - End
	
	IF Trim( ls_lp )		= "" THEN ls_lp		= is_empty
	IF Trim( ls_rp )		= "" THEN ls_rp		= is_empty
	IF Trim( ls_logic )	= "" THEN ls_logic	= is_empty

	 INSERT INTO CRITERIA_USED_LINE  
	  ( BY_TYPE,   
		 BY_ID,   
		 BY_LEVEL,   
		 CRIT_LINE,   
		 CRIT_LP,   
		 CRIT_EXP1,   
		 CRIT_DATA_TYPE,   
		 CRIT_OP,   
		 CRIT_EXP2,   
		 CRIT_RP,   
		 CRIT_LOGIC,
		 Step_id )  
	 VALUES (:iv_crit_type,   
		 :ls_subset_id,
		 1,   
		 :lv_index,   
		 :ls_lp,   
		 :iv_crit_field[lv_index],   
		 'CHAR',   
		 :iv_crit_oper[lv_index],   
		 Upper( :iv_crit_value[lv_index] ),		//	08/21/01	GaryR	Track 2410d
		 :ls_rp,   
		 :ls_logic,
		 '1' )  
   	USING stars2ca;
	//	01/16/01	GaryR	Stars 4.7 DataBase Port - End

   	if stars2ca.of_check_status() <> 0 then
      	Errorbox(Stars2ca,'Error inserting into Criteria Used Line')
      	return -1
   	end if

NEXT

return 0
end function

event open;call super::open;//******************************************************************
// 06/26/96 FNC	STARS31 Prob #284 Take case id out of description
// 06/25/95 FNC	STARS31 Prob #288 Set case id in legacy radio button
//              	since the open defaults to STARS retrieval
// 03/20/96 FNC	Change title of screen
// 12/05/95 FNC	Change screen to accomodate purged history retrieval
//	08/29/01	GaryR	Track 2423d	Set ICN limit dynamically
// 01/09/02 FNC	Track 2627 retrieve is_empty depending on database
// 05/06/02 LahuS Track 3002 Added subselect in sql to get elem_tbl_type
// 04/18/05 MikeF	Track 4356d Restore request not picking up correct date range.
//******************************************************************

//Note--The add and delete buttons are disabled and made visible.
//The only functions that can be done are update, and reteive

int		i, li_length
String	ls_column, ls_tbl_type

u_nvo_sys_cntl	lnv_sys_cntl

// Get archive data date available range
//sqlcmd('connect',stars1ca,'Error connecting to the database',1)     PLB 10/19/95
Select max(roll_to_date)
	into :iv_to_date
	from ROLL_CNTL
	Using stars1ca;
	
Stars1ca.of_check_status()

Select min(roll_FROM_date)
	into :iv_from_date
	from ROLL_CNTL
	Using stars1ca;
	
If stars1ca.of_check_status() = 100 Then
  	MessageBox("INFORMATION",'The ROLL CTRL table reports that no data is available to be restored.')
	setfocus(cb_close)
	cb_add.Enabled = FALSE
	cb_delete.Enabled = FALSE
	cb_update.Enabled = FALSE
	cb_details.Enabled = FALSE
	cb_model.Enabled = FALSE
	cb_clear.Enabled = FALSE
	RETURN
else
	If stars1ca.sqlcode <> 0 Then
  		ErrorBox(stars1ca,'Error retrieving Rolled Data Date Ranges from ROLL CNTL Table')
		SetFocus(cb_close)
		cb_add.Enabled = FALSE
		cb_delete.Enabled = FALSE
		cb_update.Enabled = FALSE
		cb_details.Enabled = FALSE
		cb_model.Enabled = FALSE
		cb_clear.Enabled = FALSE
		RETURN
	end if 
end if

lnv_sys_cntl = CREATE u_nvo_sys_cntl
lnv_sys_cntl.of_set_cntl_id( 'RESTORE' )

IF lnv_sys_cntl.of_get_cntl_no() = 0 THEN
	dw_rstr.Object.Type.Protect = 1
END IF

cb_close.Default=FALSE

//set fields that are always protected
dw_rstr.Object.User_Id.Protect = 1
dw_rstr.Object.Status.Protect = 1
dw_rstr.Object.Status_Msg.Protect = 1
dw_rstr.Object.Req_Date.Protect = 1
dw_rstr.Object.Date_Rstrd.Protect = 1
dw_rstr.Object.Rows_Rstrd.Protect = 1
dw_rstr.Object.Subc_name.Protect = 1
dw_rstr.Object.Entire_Case_Id.Protect = 1
dw_rstr.Object.rstr_desc.Protect = 1
dw_rstr.Object.Rstr_Id.Protect = 1

ls_tbl_type = gnv_dict.event ue_get_table_type( 'RESTORE_REQUEST' )

FOR i = 1 TO 5
	ls_column 	= "rstr_icn_" + String( i )
	li_length 	= gnv_dict.event ue_get_data_len( ls_tbl_type, ls_column )
	IF li_length < 1 THEN li_length = 15
	dw_rstr.Modify( ls_column + ".Edit.Limit = " + String( li_length ) )
NEXT

gnv_sql.of_TrimData( is_empty )
	
if gv_from = 'A' then   
 	w_rstr_maint_ptc.title = 'STARS Archive Retrieval Add'
	This.Event ue_reset_restore() 
else
	is_rstr_id = gv_rstr_id
  	w_rstr_maint_ptc.title = 'STARS Archive Retrieval Maintenance'
	This.Event ue_retrieve_restore() 
End If
	
SetMicroHelp(w_main,'Ready')	  
end event

on w_rstr_maint_ptc.create
int iCurrent
call super::create
this.cb_retrieve=create cb_retrieve
this.cb_details=create cb_details
this.cb_model=create cb_model
this.cb_clear=create cb_clear
this.cb_close=create cb_close
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.dw_rstr=create dw_rstr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_retrieve
this.Control[iCurrent+2]=this.cb_details
this.Control[iCurrent+3]=this.cb_model
this.Control[iCurrent+4]=this.cb_clear
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.cb_update
this.Control[iCurrent+9]=this.dw_rstr
end on

on w_rstr_maint_ptc.destroy
call super::destroy
destroy(this.cb_retrieve)
destroy(this.cb_details)
destroy(this.cb_model)
destroy(this.cb_clear)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.dw_rstr)
end on

event ue_postopen;call super::ue_postopen;//Insert a blank value in the invoice type choices
This.Event ue_insert_null_cdw()

end event

type cb_retrieve from u_cb within w_rstr_maint_ptc
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 87
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 30
integer textsize = -16
string text = "&Retrieve"
end type

event clicked;//**************************************************************
// 04-25-96 FNC STARS31 Prob #234 
//              Disable create button after a retrieve
//
// 04-09-96 FNC STARS31 Prob #221
//              Change status codes so that they match job status
// 04-03-96 FNC STARS31 Prob #220
//              Disable fields If request has been run or entered by
//              another user
// 12-05-95 FNC Change to an SLE so can do horizontal scroll
//              ModIfications to add retrieval from mainframe
// 02-11-98 VAV 4.0 
//					 The subset name will now be displayed instead 
//					 of the internal subset id. A function in NVO_Subset_Functions 
//					 must be called to convert  the subset id into the subset name.
//**************************************************************
long ll_row
ll_row = dw_rstr.GetRow()
is_rstr_id = dw_rstr.object.rstr_id[ll_row]

Parent.event ue_retrieve_restore()
end event

type cb_details from u_cb within w_rstr_maint_ptc
string accessiblename = "Details"
string accessibledescription = "Details..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2226
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 80
integer textsize = -16
string text = "De&tails..."
boolean cancel = true
end type

event clicked;// open details child windows with this window as parent
// ajs 4.0 03-20-98 change to open with instance variable
openwithparm(w_rstr_details,is_rstr_id,w_rstr_maint_ptc)

end event

type cb_model from u_cb within w_rstr_maint_ptc
string accessiblename = "Copy"
string accessibledescription = "Copy"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1513
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 60
string text = "Co&py"
end type

event clicked;//**************************************************************
// 05-08-96 FNC Default to the create button
//
// 04-03-96 FNC Enable all fields that were disabled
//              if request has been run or if the request was 
//              input by a different user
//
// 12-05-95 FNC Change to an SLE so can do horizontal scroll
//**************************************************************
sx_subset_options lstr_sub_opt
string ls_hold_mm_from,ls_hold_ccyy_from,ls_hold_mm_to,ls_hold_ccyy_to
string ls_hold_type
n_ds ds_rstr_maint

SetMicroHelp(w_main,"Clearing all fields")

close(w_rstr_details)

//sle_id.enabled = true
long ll_row
ll_row = dw_rstr.GetRow()

//Save data into a data store
ds_rstr_maint = CREATE n_Ds
ds_rstr_maint.DataObject = 'd_rstr_maint'
ds_rstr_maint.SetTransObject(stars2ca)
if ds_rstr_maint.Retrieve(is_rstr_id) < 1 then
	MessageBox("Error","Cannot save data for restore job",StopSign!)
	return 
END IF
ls_hold_mm_from	= dw_rstr.object.mm_from[ll_row]
ls_hold_ccyy_from	= dw_rstr.object.ccyy_from[ll_row]
ls_hold_mm_to		= dw_rstr.object.mm_to[ll_row]
ls_hold_ccyy_to	= dw_rstr.object.ccyy_to[ll_row]
ls_hold_type		= dw_rstr.object.type[ll_row]

//Clear the datawindow ans insert new row
Parent.Event ue_reset_restore()

//reset the new row in the data window with the old data
dw_rstr.Object.Data = ds_rstr_maint.Object.Data

//clear out what is not needed
dw_rstr.Object.Rstr_Id[ll_row] = "" 
dw_rstr.Object.Rstr_Id.Protect = 0
dw_rstr.Object.User_id[ll_row] = gc_user_id
dw_rstr.Object.req_date[ll_row] = gnv_app.of_get_server_date_time()
dw_rstr.Object.status[ll_row] = 'P'
dw_rstr.Object.status_msg[ll_row] = ""         
dw_rstr.Object.subc_id[ll_row] = ""
dw_rstr.Object.subc_name[ll_row] = ""
dw_rstr.Object.case_id[ll_row] = ""
dw_rstr.Object.case_spl[ll_row] = ""
dw_rstr.Object.case_ver[ll_row] = ""
dw_rstr.Object.entire_case_id[ll_row] = ""
dw_rstr.Object.crit_id[ll_row] = ""
is_rstr_id = ""
iv_crit_id = ""
dw_rstr.object.mm_from[ll_row] = ls_hold_mm_from	 
dw_rstr.object.ccyy_from[ll_row] = ls_hold_ccyy_from	 
dw_rstr.object.mm_to[ll_row] = ls_hold_mm_to		 
dw_rstr.object.ccyy_to[ll_row] = ls_hold_ccyy_to
dw_rstr.object.type[ll_row] = ls_hold_type
//ajs 07-07-98 Track 1422
dw_rstr.Object.Rstr_desc[ll_row] = ""  

cb_add.enabled=true
cb_add.default = true	
cb_update.enabled=false
istr_subset_options = lstr_sub_opt
wf_enable_fields()   
//Protect criteria field depending if it is an archive or legacy subset
ls_hold_type = dw_rstr.object.Type[ll_row]
wf_protect_criteria_field(ls_hold_type)
end event

type cb_clear from u_cb within w_rstr_maint_ptc
string accessiblename = "Clear"
string accessibledescription = "Clear"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1870
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 70
integer textsize = -16
string text = "C&lear"
end type

event clicked;//**************************************************************
// 03-20-98 AJS Change code to use reset user event
// 04-03-96 FNC Enable all fields that were disabled
//              if request has been run or if the request was 
//              input by a different user
//
// 12-05-95 FNC Change to an SLE so can do horizontal scroll
//              Modifications to restore from purged history
//**************************************************************

/*Clears all variables*/
SetMicroHelp(w_main,"Clearing all fields")

Parent.Event ue_reset_restore()

end event

type cb_close from u_cb within w_rstr_maint_ptc
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2583
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 90
integer textsize = -16
string text = "&Close"
boolean default = true
end type

on clicked;close(parent)
end on

type cb_add from u_cb within w_rstr_maint_ptc
string accessiblename = "Create"
string accessibledescription = "Create"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 800
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 20
integer textsize = -16
string text = "Cr&eate"
end type

event clicked;//**************************************************************
// 06-26-96 FNC STARS31 Prob #284 Take case id out of description
// 05-22-96 FNC Write criteria for both types of requests
// 05-07-96 FNC Add check for case subset and move subset checks
//           	 to window functions 
// 03-27-96 FNC2 Take out all commits so that just have one at the
//              end. This will solve duplicate criteria id problem.
// 03-27-96 FNC STARS31 Prob #224. Make sure that case exists.
// 03-26-96 FNC STARS31 Prob #235. Allow user to enter a stars
//              history request by just specifying a UPIN
// 03-20-96 FNC Move code from edit criteria into this script. 
//              If not stars retrieval only need a bene id or prov id
// 03-14-96 FNC Check sys cntl date range only for stars requests
// 02-08-96 FNC Add criteria to criteria tables for purged requests
// 12-05-95 FNC Modifications to add retrieval from mainframe
//          	 Change to an SLE so can do horizontal scroll
// 02-11-98 VAV 4.0 Currently, this window allows the user to enter a subset id. 
//					 With Subset Redesign the user will enter the subset name and case id 
//					 into the Subset Options window. The Subset Options window 
//					 will be displayed when the user clicks the create button. 
//					 Once the user enters the Subset Name and Case ID into the Subset Options 
//					 window and returns to the Archive Retrieval window the Subset Name 
//					 will be displayed in the Subset ID field and the Case ID will be 
//					 displayed in the Case ID field. These functional changes will require 
//					 the following changes in this button.
// 03-17-98 AJS 4.0 Track 861 correct error/cancel problem
// 03-23-98 AJS 4.0 Change code to use datawindow and user events
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	10/13/05 Katie Track 4559 Added SUB to criteria retrieving from Case_link.
//**************************************************************

integer li_rc
long ll_row, ll_case_link_count, ll_count
n_ds ds_case_link
string ls_case_id, ls_sql

SetPointer (hourglass!)
close(w_rstr_details)
SetMicroHelp(w_main,'Adding Restore Request')

li_rc = Parent.event ue_general_edits()
If li_rc < 0 then
	RETURN
End If

select count(*) into :ll_count
	from RESTORE_CNTL
	where RSTR_ID = Upper( :is_rstr_id )
	Using stars2ca;
	
If stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error Checking for existence of Restore ID')
	RETURN
Elseif ll_count > 0 then
	 COMMIT using STARS2CA;
	 If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
    End If	
    Messagebox('ERROR','Restore Id already exists.  Please choose a different ID ~nor leave blank for system generated id.')
	 dw_rstr.setfocus()
	 dw_rstr.Object.Rstr_id[1] = ""
	 dw_rstr.setcolumn('rstr_id')
	 RETURN
End If
	
Istr_subset_options.come_from = 'ARCHIVE'		
OpenWithParm(w_subset_options,istr_subset_options,Parent)

istr_subset_options = Message.PowerObjectParm
if istr_subset_options.status = 'ERROR' then
	SetMicroHelp(w_main,'Error, Request cancelled')
	RETURN
end if
	
if istr_subset_options.status = 'CANCEL' then
	SetMicroHelp(w_main,'Request cancelled')
	RETURN
end if

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (istr_subset_options.case_spl)
li_rc	=	gnv_sql.of_TrimData (istr_subset_options.case_ver)
// FDG 04/16/01 - end

ll_row = dw_rstr.GetRow()

dw_rstr.Object.subc_name[ll_row] = istr_subset_options.subset_name
//the subset id is not seen on the screen
dw_rstr.Object.Subc_Id[ll_row] = istr_subset_options.subset_id
ls_case_id = istr_subset_options.case_id + istr_subset_options.case_spl + istr_subset_options.case_ver
dw_rstr.Object.Entire_Case_Id[ll_row] = ls_case_id 
dw_rstr.Object.Case_Id[ll_row] = istr_subset_options.case_id
dw_rstr.Object.Case_SPL[ll_row] = istr_subset_options.case_spl 
dw_rstr.Object.Case_VER[ll_row] = istr_subset_options.case_ver

//ajs 07-07-98 Track 1422 Create DS to get description
ds_case_link = CREATE n_Ds
ds_case_link.DataObject = 'd_sub_opt_case_link'
ds_case_link.SetTransObject(stars2ca)
ds_case_link.of_SetTrim (TRUE)						// FDG 04/16/01
ls_sql = ds_case_link.GetSqlSelect()
ls_sql = ls_sql + "WHERE case_link.link_name = '" + Upper( istr_subset_options.subset_name ) + "'" + &
								" and case_link.case_id = '" + Upper( istr_subset_options.case_id ) + "'" + &
						" and case_link.link_type = 'SUB'"
If istr_subset_options.case_id <> 'NONE' then
	ls_sql = ls_sql +	" and case_link.case_spl = '" + Upper( istr_subset_options.case_spl ) + "'" + &
						" and case_link.case_ver = '" + Upper( istr_subset_options.case_ver ) + "'"  
End If
ds_case_link.SetSqlSelect(ls_Sql)
ll_case_link_count = ds_case_link.Retrieve() 
If ll_case_link_count <> 1 then
	MessageBox("Error","Cannot retrieve subset description",StopSign!)
	Return
	destroy ds_case_link
else
	dw_rstr.Object.rstr_desc[ll_row] = ds_case_link.Object.link_desc[1]
	destroy ds_case_link
END IF

iv_crit_id = fx_get_next_key_id("CRITERIA")
	COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
if (iv_crit_id = "ERROR") or (iv_crit_id = "") then
	Messagebox("ERROR","Function Get Next Crit ID Failed")
	return
end if
dw_rstr.Object.Crit_Id[ll_row] = iv_crit_id

li_rc = Parent.event ue_update_restore()
If li_rc < 0 then
	RETURN
End If

is_hold_rstr_id = is_rstr_id

SetMicroHelp(w_main,'Ready')



end event

type cb_delete from u_cb within w_rstr_maint_ptc
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1157
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 50
integer textsize = -16
string text = "&Delete"
end type

event clicked;//*****************************************************************
// 08/25/98	FNC	Track 1608. Row is deleted from datawindow but
//						need to update datawindow in order to delete
//						row from database.
// 03-23-98 AJS   Stars 4.0 change code to use datawindow
//	12-29-97	FDG	Stars 3.6 (prob 191)
//						Get the subset id and move it to is_existing_crit
//						before deleting from restore_request_part_c
//
// 04-25-96 FNC	STARS31 Prob #234 
//             	Disable create button after a retrieve
//
// 04-03-96 FNC	Enable all fields that were disabled
//             	if request has been run or if the request was 
//             	input by a different user
//
// 03-26-96 FNC	STARS31 prob #223 
//             	Delete criteria from criteria table.
//*****************************************************************

/*Declaration Section*/
int lv_message_nbr

close(w_rstr_details)
/*Prints a confirmation box and finds out what button was pressed*/
lv_message_nbr = MessageBox('CONFIRMATION!',"Delete Restore Request #" + is_rstr_id + " ?",Question!,OKCANCEL!,2)
If lv_message_nbr = 2 Then
	  SetMicroHelp(w_main,'Ready')	
     Return
end if

SetPointer(Hourglass!)
SetMicroHelp(w_main,'Deleting Restore Request Entry')
 
//	12/29/97 FDG Start - Place the subset id into is_existing_crit.
IF	wf_get_existing_crit_id()	<>	0		THEN
	SetMicroHelp(w_main,'Ready')
	Return
END IF
//	12/29/97 FDG end

dw_rstr.DeleteRow(0);
dw_rstr.EVENT ue_update( TRUE, TRUE )				// FNC 08/25/98
/*Checks to see there was a error in reading the database or*/
/*if there was no match in the database*/
If stars2ca.of_check_status() = 100 Then
	SetMicroHelp(w_main,'Ready')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	messagebox('Not Found','Selection not found, Cannot be Deleted',StopSign!)
	RETURN
elseIF stars2ca.sqlcode < 0 Then
	SetMicroHelp(w_main,'Ready')
   errorbox(stars2ca,'Error deleting from the restore request table')
	RETURN
end if 

DELETE from RESTORE_CNTL
     Where (RSTR_ID = Upper( :is_rstr_id ) )
	  Using stars2ca;
/*Checks to see there was a error in reading the database or*/
/*if there was no match in the database*/
IF stars2ca.of_check_status() < 0 Then
	SetMicroHelp(w_main,'Ready')
   errorbox(stars2ca,'Error deleting from the restore request table')
	RETURN
end if 

if wf_delete_criteria() < 0  then    //03-26-96 FNC start
   messagebox('WARNING','Errors found in deleting criteria ~rRequest not deleted')
	SetMicroHelp(w_main,'Ready')
   return
end if

COMMIT USING STARS2CA;

wf_enable_fields() 						//04-03-96 FNC
cb_add.enabled = true 					//04-25-96 FNC

SetMicroHelp(w_main,'Ready')
TriggerEvent(cb_clear,clicked!)
end event

type cb_update from u_cb within w_rstr_maint_ptc
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 443
integer y = 1472
integer width = 347
integer height = 112
integer taborder = 10
integer textsize = -16
string text = "&Update"
end type

event clicked;////*********************************************************************
//	12-29-97 FDG	Fix to 05-08-96 (Stars 3.6 - Prob 191).  Move the
//						retrieving of the subset id to a window's function
//						so is_existing_crit can be set from multiple locations.
// 05-22-96 FNC	Delete criteria for all types of requests
// 05-08-96 FNC	Retrieve the original subset id to use for deleting
//             	criteria
// 04-15-96 FNC	Delete criteria when request is updated because it is
//             	added in the create button
//*********************************************************************

int li_rc
long ll_row

SetPointer(Hourglass!)
close(w_rstr_details)
SetMicroHelp(w_main,'Updating Restore Request Entry')


If is_hold_rstr_id <> is_rstr_id then
	Messagebox("ERROR","This restore request can not be updated, It must be retrieve first.")
	SetMicroHelp(w_main,'Ready')
	Return
End If
 
/*Deletes the row from the table*/

li_rc = Parent.event ue_general_edits()
If li_rc < 0 then
	SetMicroHelp(w_main,'Unsuccesful update; did not pass edit check')
	RETURN
End If

ll_row = dw_rstr.GetRow()
iv_crit_id = dw_rstr.Object.Crit_Id[ll_row] 

li_rc = Parent.event ue_update_restore()
If li_rc < 0 then
	SetMicroHelp(w_main,'Unsuccesful update')
	RETURN
End If

SetMicroHelp(w_main,'Ready')


end event

type dw_rstr from u_dw within w_rstr_maint_ptc
string accessiblename = "Restore Maintenance Data"
string accessibledescription = "Restore Maintenance Data"
accessiblerole accessiblerole = clientrole!
integer width = 3136
integer height = 1468
integer taborder = 40
string dataobject = "d_rstr_maint"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event losefocus;call super::losefocus;dw_rstr.AcceptText()
end event

event constructor;call super::constructor;This.SetTransObject (Stars2ca)
This.of_setupdateable(false)
end event

event itemchanged;call super::itemchanged;string ls_type, ls_columnname,ls_new_value
DataWindowChild ldwc_invt[5]
If  this.getcolumnname() = 'type' then
	ls_type = string(data)
	if ls_type = 'M' then
   	is_type = 'M' 
   	wf_clear_fields()
		//Protect criteria field depending if it is an archive or legacy subset
		wf_protect_criteria_field(is_type)
	else
   	is_type = 'S'
		//Protect criteria field depending if it is an archive or legacy subset
		wf_protect_criteria_field(is_type)
	end if
End if



If  this.getcolumnname() = 'rstr_id' then
	is_rstr_id = string(data)
End If

ls_columnname = this.getcolumnname()

If ls_columnname = 'rstr_invt_1' or &
	ls_columnname = 'rstr_invt_2' or &
	ls_columnname = 'rstr_invt_3' or &
	ls_columnname = 'rstr_invt_4' or &
	ls_columnname = 'rstr_invt_5' then
	ls_new_value = string(data)
	Parent.Event ue_filter_cdw(ls_columnname,ls_new_value)
End If

	


end event

