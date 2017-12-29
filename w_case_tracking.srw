HA$PBExportHeader$w_case_tracking.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_tracking from w_master
end type
type cb_update from u_cb within w_case_tracking
end type
type cb_createtrack from u_cb within w_case_tracking
end type
type cb_close from u_cb within w_case_tracking
end type
type cb_track from u_cb within w_case_tracking
end type
type ddlb_track_type from dropdownlistbox within w_case_tracking
end type
type sle_track_name from singlelineedit within w_case_tracking
end type
type sle_track_key from singlelineedit within w_case_tracking
end type
type st_3 from statictext within w_case_tracking
end type
type st_2 from statictext within w_case_tracking
end type
type st_1 from statictext within w_case_tracking
end type
end forward

global type w_case_tracking from w_master
string accessiblename = "Case Track Information"
string accessibledescription = "Case Track Information"
accessiblerole accessiblerole = windowrole!
integer x = 562
integer y = 596
integer width = 1787
integer height = 724
string title = "Case Track Information"
windowtype windowtype = response!
long backcolor = 67108864
cb_update cb_update
cb_createtrack cb_createtrack
cb_close cb_close
cb_track cb_track
ddlb_track_type ddlb_track_type
sle_track_name sle_track_name
sle_track_key sle_track_key
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_case_tracking w_case_tracking

forward prototypes
public function integer wf_track_exists (ref sx_track_data arg_track_data)
public function integer fw_close_track_lead (boolean in_dupe_close)
public function integer wf_insert_target (ref string lv_target_id, string target_type, boolean create_link, string target_desc)
end prototypes

public function integer wf_track_exists (ref sx_track_data arg_track_data);//This function checks if the track exists on the tables

arg_track_data.track_name = ''
arg_track_data.track_number = ''
arg_track_data.track_lob = ''

If arg_track_data.track_key = '' then
	Messagebox('EDIT','Error Retrieving Target Key')
	RETURN -1
End If

If arg_track_data.track_type = 'PV' then
	Select prov_name,prov_upin,prov_type
		 into :arg_track_data.track_name,:arg_track_data.track_number,
				:arg_track_data.track_lob
		from providers
	  where Prov_id = Upper( :arg_track_data.track_key )
	Using stars2ca;
	If stars2ca.of_check_status() < 0 then	
	   Messagebox('ERROR','Error Reading Provider Table')
		Return -1
	Elseif stars2ca.sqlcode = 100 then
		//check if the provider id is a UPIN
		Select max(prov_name)
			 into :arg_track_data.track_name
			from providers
		  where Prov_upin = Upper( :arg_track_data.track_key )
		Using stars2ca;
		If stars2ca.of_check_status() < 0 then	
	   	Messagebox('ERROR','Error Reading Provider Table')
			Return -1 
		Elseif stars2ca.sqlcode = 100 then
			 Messagebox('EDIT','Provider Information not Available.')
			 RETURN -1 
		End If
		arg_track_data.track_number = arg_track_data.track_key
	End IF
End If
	
Return 0
end function

public function integer fw_close_track_lead (boolean in_dupe_close);//ALABAMA4  PAT-D   ADDED THIS ENTIRE FUNCTION
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//	FDG	04/16/01	Stars 4.7.	Properly trim the data.
Integer lv_count,	li_rc
String Lv_track_key,lv_track_type,lv_track_status,lv_track_disp
String lv_case_id,lv_case_spl,lv_case_ver
String 	lv_status = 'CL',lv_disp = 'SYSORCLS'
Datetime lv_date_time

//lv_case_id = left(gv_case_active,10)		//ajs 4.0 03-11-98
//lv_case_spl = mid(gv_case_active,11,2)	//ajs 4.0 03-11-98
//lv_case_ver = mid(gv_case_active,13,2)	//ajs 4.0 03-11-98
lv_case_id = Trim (left(gv_active_case,10))	//ajs 4.0 03-11-98	// FDG 04/16/01
lv_case_spl = mid(gv_active_case,11,2)		//ajs 4.0 03-11-98
lv_case_ver = mid(gv_active_case,13,2)		//ajs 4.0 03-11-98	
lv_date_time = datetime(today(),now())		 

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 end

If in_dupe_close = true then
	goto close_leads
End IF

n_tr STARS2CA1
STARS2CA1 = CREATE n_tr 
STARS2CA1.DBMS = STARS2CA.DBMS
STARS2CA1.DATABASE = STARS2CA.DATABASE
STARS2CA1.LOGID = STARS2CA.LOGID
STARS2CA1.LOGPASS = STARS2CA.LOGPASS
STARS2CA1.SERVERNAME = STARS2CA.SERVERNAME
STARS2CA1.USERID = STARS2CA.USERID
STARS2CA1.DBPASS = STARS2CA.DBPASS
STARS2CA1.LOCK = STARS2CA.LOCK
STARS2CA1.DBPARM = STARS2CA.DBPARM

//sqlcmd('CONNECT',stars2ca1,'',2)				// FDG 02/20/01
stars2ca1.of_connect()								// FDG 02/20/01
Declare trk_c cursor for
		Select trk_key,trk_type,status,disp
			from Track
			where Case_id  = Upper( :lv_case_id ) and
					case_spl = Upper( :lv_case_spl ) and
					case_ver = Upper( :lv_case_ver )
Using stars2ca1;

Open trk_c;
If stars2ca1.of_check_status() <> 0 then
		//sqlcmd('Rollback',stars2ca,'Error Opening track Cursor',1)
		Stars2ca.of_rollback()	
		stars2ca1.of_disconnect()								// FDG 02/20/01
		Errorbox(stars2ca1,'Error Opening Track Cursor')
		Destroy stars2ca1;
		RETURN -1 
End If

Do while stars2ca1.sqlcode = 0
	Fetch trk_c into
			:lv_track_key,:lv_track_type,:lv_track_status,:lv_track_disp;
	If stars2ca1.of_check_status() = 100 then exit

	If stars2ca1.sqlcode <> 0 then
			//sqlcmd('Rollback',stars2ca,'Error fetching Track Cursor',1)
			Stars2ca.of_rollback()	
			close trk_c; 
			//sqlcmd('DISCONNECT',stars2ca1,'Error fetching Track Cursor',1)	// FDG 02/20/01		
			stars2ca1.of_disconnect()								// FDG 02/20/01
			Destroy stars2ca1;
			RETURN  -1
	End If
	// FDG 04/16/01 - Empty string in Oracle is null
	li_rc	=	gnv_sql.of_TrimData (lv_track_key)
	li_rc	=	gnv_sql.of_TrimData (lv_track_type)
	li_rc	=	gnv_sql.of_TrimData (lv_track_status)
	li_rc	=	gnv_sql.of_TrimData (lv_track_disp)
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
		 //sqlcmd('DISCONNECT',stars2ca1,'Error Reading Track Log',1)		// FDG 02/20/01
		 stars2ca1.of_disconnect()								// FDG 02/20/01
		 Destroy stars2ca1;
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
		 status_desc)
	Values
		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
		  :lv_track_type,:lv_track_key,:gc_user_id,
		  :lv_status,:lv_track_disp,:LV_DATE_TIME,
			'Case Closed - Track Status Closed')
	Using Stars2ca;

	If stars2ca.of_check_status() <> 0 then
		 stars2ca.of_rollback()					// FDG 02/20/01
		 //sqlcmd('DISCONNECT',stars2ca1,'Error Inserting into Track Log',1)		// FDG 02/20/01
		 stars2ca1.of_disconnect()								// FDG 02/20/01
		 Destroy stars2ca1;
		 Errorbox(stars2ca,'Error Inserting Closed Entry to track log')
		 RETURN -1
	End If

	//write log entry for system closed status & disposition
	Insert into track_log
		(CASE_ID,CASE_SPL,case_ver,
		 trk_type,trk_key,user_id,
		 status,disp,status_datetime,
		 status_desc)
	Values
		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
		  :lv_track_type,:lv_track_key,:gc_user_id,
		  :lv_status,:lv_disp,:LV_DATE_TIME,
			'Case Closed - Track is also being Closed')
	Using Stars2ca;

	If stars2ca.of_check_status() <> 0 then
		 stars2ca.of_rollback()					// FDG 02/20/01
		 //sqlcmd('DISCONNECT',stars2ca1,'Error Inserting into Track Log',1)		// FDG 02/20/01
		 stars2ca1.of_disconnect()								// FDG 02/20/01
		 Destroy stars2ca1;
		 Errorbox(stars2ca,'Error Inserting Closed Entry to track log')
		 RETURN -1
	End If
Loop

close trk_c; 
If stars2ca1.sqlcode <> 0 then
		//sqlcmd('Rollback',stars2ca,'Error closing Target  Cursor',1)
		stars2ca.of_rollback()					// FDG 02/20/01
		Errorbox(stars2ca1,'Error closing Target  Cursor')
		stars2ca1.of_disconnect()								// FDG 02/20/01
		Destroy stars2ca1;
		RETURN -1
End If

//sqlcmd('DISCONNECT',stars2ca1,'Closing Target  Cursor',1)			// FDG 02/20/01
Destroy stars2ca1;

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

close_leads:
//Update Status to closed for all Leads in this case
Update Lead
		 set  Status = :lv_status,
				disp_date = :lv_date_time
	where Case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using stars2ca;
If Stars2ca.of_check_status() <> 0 then
	 stars2ca.of_rollback()					// FDG 02/20/01
	 Errorbox(Stars2ca,'Error Updating Leads to Closed Status')
	 RETURN -1
End IF

RETURN 0

end function

public function integer wf_insert_target (ref string lv_target_id, string target_type, boolean create_link, string target_desc);//
//This function Inserts into the Target Control table
//
//Maintenance log:
//	By:	Date:			Description:
//	----	--------		----------------------------------------
//	JGG	02-28-98		Added new columns to case link table
// ajs   03-11-98    4.0 TS145-fix global variables
//	FDG	01/18/99		Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
//							Track 2020c.  Get server date
//	GaryR	01/11/01		Stars 4.7 DataBase Port - Empty String in SQL
//	GaryR	03/15/01		Stars 4.7 DataBase Port - Case Sensitivity
//	FDG	04/16/01		Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//-----------------------------------------------------------

String lv_case_id,lv_case_spl,lv_case_ver, ls_empty
double lv_next_target
string lv_SUBC_id
int    lv_pos,	li_rc
Datetime lv_date_time,lv_init_date
String	ls_date_time		// 02-28-98 JGG

setpointer(hourglass!)

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

//lv_date_time = datetime(today(),now())		// FDG 01/18/99
lv_date_time = gnv_app.of_get_server_date_time()		// FDG 01/18/99

//lv_case_id  = left(gv_case_active,10)//ajs 4.0 03-11-98 TS145-fix globals
//lv_case_spl = mid(gv_case_active,11,2)//ajs 4.0 03-11-98 TS145-fix globals
//lv_case_ver = mid(gv_case_active,13,2)//ajs 4.0 03-11-98 TS145-fix globals
lv_case_id = Trim(left(gv_active_case,10))	//ajs 4.0 03-11-98	// FDG 04/16/01
lv_case_spl = mid(gv_active_case,11,2)	//ajs 4.0 03-11-98 TS145-fix globals
lv_case_ver = mid(gv_active_case,13,2)	//ajs 4.0 03-11-98 TS145-fix globals

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 - end

lv_init_date = datetime(date(1900,01,01))

//ls_date_time = String(lv_date_time)		// 02-28-98 JGG	// FDG 01/18/99
ls_date_time = String(lv_date_time, 'mm/dd/yyyy')		// FDG 01/18/99

Select cntl_no into :lv_next_target
	from sys_cntl
  where cntl_id = 'TARGET'
using stars2ca;		
If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'ERROR Getting TARGET Id')
	RETURN -1
Else
	lv_next_target = lv_next_target + 1
	lv_target_id = string(lv_next_target)
	Update Sys_cntl
			set cntl_no = :lv_next_target
		 where cntl_id = 'TARGET'
	using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error Updating System Control Table')
		RETURN -1
	End If
End If

If Create_link then
	// 02-28-98 JGG - add new case link columns
	
//	Insert into case_link
//		(case_id,case_spl,case_ver,
//		 link_type,link_key)
//		Values
//		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
//		  'TGT',:lv_target_id)	

	Insert into case_link
		(case_id,case_spl,case_ver,
		 link_type,link_key, link_name,
		 link_desc, user_id, link_date, link_status)
		Values
		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
		  'TGT',:lv_target_id, Upper(:lv_target_id),	//	03/15/01	GaryR	Stars 4.7 DataBase Port
		  'TARGET', :gc_user_id, :ls_date_time, 'A')

	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error Inserting target to Case Link')
		RETURN -1
	End If
End If

//	GaryR	01/11/01		Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( target_desc ) = "" THEN target_desc = ls_empty

//Insert into Target/target Cntl
Insert into Target_cntl 
	(case_id,case_spl,case_ver,
	 dept_id,user_id,trgt_id,
	 trgt_type,subc_id,
	 trgt_datetime,trgt_desc)
	Values
	 (:lv_case_id,:lv_case_spl,:lv_case_ver,
	  :gc_user_dept,:gc_user_id,:lv_target_id,
	  :target_type,' ',
	  :lv_date_time,:target_desc)
Using Stars2ca;

If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'Error Inserting into Target Control')
	RETURN -1
End If


return 0
end function

event open;call super::open;//***************************************************************
//02-05-95 DKG Changed ddlb_track_type Revenue Code from RC to RV.
//             PROB 111 Stars 3.1 Release disk.
//08-29-95 FNC Start If case cat is referral can change track type 
//             but can't add a track until change case cat
//08-15-95 FNC Prob #643 Add cb_update and disable when ddlb is disabled
//06-20-95 FNC Set proc track code to track type for fx_track_exists
//***************************************************************
String lv_case_id,lv_case_id_spl,lv_case_id_ver
String lv_tgt_key,lv_track_type
Int    lv_count
Sx_track_data lv_track_data

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//fx_set_window_colors(w_case_tracking)
lv_case_id = left(gv_active_case,10)
lv_case_id_spl = mid(gv_active_case,11,2)
lv_case_id_ver = mid(gv_active_case,13,2)


ddlb_track_type.text = w_case_maint.iv_track_type  

//08-29-95 FNC Start
if w_case_maint.in_case_cat = 'REF' then
   sle_track_key.text  = ''
	sle_track_name.text  = ''
   sle_track_key.enabled = false
   sle_track_name.enabled = false
   cb_track.enabled = false
   cb_createtrack.enabled = false
	RETURN
end if
//08-29-95 FNC Start

If w_case_maint.in_track_exists = false  then
	sle_track_key.text  = ''
	sle_track_name.text  = ''
   cb_track.enabled = false
	cb_createtrack.default = true
	RETURN
Else
	ddlb_track_type.enabled = false		
   cb_update.enabled = false         //08-15-95 FNC
	select count(*), min(trk_key) into :lv_count,:lv_tgt_key
		from  track
		where  case_id  = Upper( :lv_case_id ) and 
				 case_spl = Upper( :lv_case_id_spl ) and
				 case_ver = Upper( :lv_case_id_ver ) // and
//				 alert_ind = 'Y'
	Using  stars2ca;
	If stars2ca.of_check_status() <> 0 then 
		Errorbox(stars2ca,'ERROR reading Track Table')
		cb_close.postevent(clicked!)
		return
	End If

	If lv_count <= 0 then
		sle_track_key.text = ''
		sle_track_name.text = ''
		cb_track.enabled = false
		cb_createtrack.default = true
	Elseif lv_count = 1 then
		cb_track.default = true
		cb_createtrack.enabled = false
		sle_track_key.text = lv_tgt_key
//		fx_track_exists(lv_track_data)
//this window function can be deleted when the PIN/UPIN issue is resolved
//currently fx_track_exists goes against PIN only 
		lv_track_data.track_key  = lv_tgt_key
		lv_track_data.track_type = left(ddlb_track_type.text,2)
      if lv_track_data.track_type = 'PC' then
         lv_track_data.proc_track_code = lv_track_data.track_type //06-20-95 FNC
      end if
		iF left(ddlb_track_type.text,2) = 'PV' THEN
			wf_track_exists(lv_track_data)	
		ELSE
			fx_track_exists(lv_track_data)
		END IF
		If trim(lv_track_data.track_name)  = ''  then
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return
			End If	
			RETURN
		Else
			 sle_track_name.text = lv_track_data.track_name
		End If
			 sle_track_key.displayonly  = true
			 sle_track_name.displayonly = true
//          ddlb_track_type.enabled = false //08-15-95 FNC
//          cb_update.enabled = false       //08-15-95 FNC
// Display the Count if more than one track in TGT for Case
	ElseIf lv_count > 1  then
			 cb_createtrack.enabled = false
			 cb_track.default = true
			 sle_track_key.text = string(lv_count)
			 st_1.text = 'Count:'
			 sle_track_name.text = ''
			 sle_track_key.displayonly  = true
			 sle_track_name.displayonly = true
//			 ddlb_track_type.enabled = false //08-15-95 FNC
//          cb_update.enabled = false     //08-15-95 FNC
	End If
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	


end event

on w_case_tracking.create
int iCurrent
call super::create
this.cb_update=create cb_update
this.cb_createtrack=create cb_createtrack
this.cb_close=create cb_close
this.cb_track=create cb_track
this.ddlb_track_type=create ddlb_track_type
this.sle_track_name=create sle_track_name
this.sle_track_key=create sle_track_key
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_update
this.Control[iCurrent+2]=this.cb_createtrack
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_track
this.Control[iCurrent+5]=this.ddlb_track_type
this.Control[iCurrent+6]=this.sle_track_name
this.Control[iCurrent+7]=this.sle_track_key
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_1
end on

on w_case_tracking.destroy
call super::destroy
destroy(this.cb_update)
destroy(this.cb_createtrack)
destroy(this.cb_close)
destroy(this.cb_track)
destroy(this.ddlb_track_type)
destroy(this.sle_track_name)
destroy(this.sle_track_key)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_update from u_cb within w_case_tracking
boolean visible = false
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 658
integer y = 448
integer width = 416
integer height = 108
integer taborder = 70
string text = "&Update"
end type

event clicked;//********************************************************************
//08-15-95 FNC Prob #643 Add cb_update and disable when ddlb is disabled
//03-13-98 JGG STARS 4.0 - track folder view is now obsolete
//09/01/98 AJS FS362 convert case to case_cntl  
//********************************************************************

string lv_case_id,lv_case_id_spl,lv_case_id_ver

lv_case_id = left(gv_active_case,10)
lv_case_id_spl = mid(gv_active_case,11,2)
lv_case_id_ver = mid(gv_active_case,13,2)

// 09/01/98 AJS   FS362 convert case to case_cntl
Update Case_CNTL
		 set case_trk_type = :ddlb_track_type.text
		 where case_id  = Upper( :lv_case_id ) and
				 case_spl = Upper( :lv_case_id_spl ) and
				 case_ver = Upper( :lv_case_id_ver )
Using Stars2ca;

If Stars2ca.of_check_status() <> 0 then
	Errorbox(Stars2ca,'Case could not be updated with the Track type')
	RETURN
else
   w_case_maint.iv_track_type = ddlb_track_type.text
   if isvalid(w_case_folder_view) then
      close(w_case_folder_view)
   end if
   if isvalid(w_target_list) then
      close(w_target_list)
   end if
   if isvalid(w_target_maintain) then
      close(w_target_maintain)
   end if
   if isvalid(w_target_subset_maintain) then
      close(w_target_subset_maintain)
   end if
   if isvalid(w_target_view) then
      close(w_target_view)
   end if
	
//	JGG 03/13/98 - track folder view window now obsolete
// if isvalid(w_track_folder_view) then
//    close(w_track_folder_view)
// end if

//NLG 9-15-99 ts2363c w_track_log is now a tabpage on w_track_maint 
//   if isvalid(w_track_log) then
//      close(w_track_log)
//   end if

   if isvalid(w_track_maint) then
      close(w_track_maint)
   end if
   if isvalid(w_tracking_list) then
      close(w_tracking_list)
   end if
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
end event

type cb_createtrack from u_cb within w_case_tracking
string accessiblename = "Create Track"
string accessibledescription = "Create Track"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 494
integer y = 448
integer width = 466
integer height = 108
integer taborder = 60
string text = "&Create Track"
end type

event clicked;//*******************************************************************
//08-15-95 FNC Prob #643 Add cb_update and disable when ddlb is disabled
//06-20-95 FNC Set value in structure for FX_TRACK_EXISTS
//12-13-94 FNC Move sle_track_key.text to gv_case_target so that the
//             target id is displayed on the target id on the dup
//             check window.
//09/01/98 AJS FS362 convert case to case_cntl
//09-15-99 NLG ts2363c Reference objects on tabpage in w_case_maint
//	FDG	02/20/01	Stars 4.7 - remove SQLCMD
// JasonS 06/18/02 Track 3063d  Change case status on referral
//*******************************************************************

String         lv_case_id,lv_case_id_spl,lv_case_id_ver
sx_track_data	lv_track_data
string			lv_track_type
int				lv_return
string			lv_target_id
boolean			lv_create_link = true
string			lv_status
datetime			lv_current_datetime
boolean			lv_dupe_close
string			lv_case_cat
int				lv_pos
long				ll_row

// stolen code from cb_update.clicked in w_case_maint
// change all the 'in_track_settings' to be the actual controls
// some information will need to be passed (anything which is
// not declared explicitly in the procedure will need to be
// passed - anything which is declared explicitly in the procedure
// will need to be set (if its setting occurs outside the code
// stolen...)

If trim(sle_track_key.text) = '' then	
	Messagebox('EDIT','Please Enter a Track Key')
	RETURN
End IF

lv_case_id = left(gv_active_case,10)
lv_case_id_spl = mid(gv_active_case,11,2)
lv_case_id_ver = mid(gv_active_case,13,2)

//NLG 9-15-99       ***Start***
//// setting of lv_status stolen from cb_update.clicked
//lv_pos             = pos(w_case_maint.ddlb_curr_status.text,'-')         
//If lv_pos > 0 then
//	lv_status 	  = trim(left(w_case_maint.ddlb_curr_status.text,lv_pos - 1)) 
//Else
//	lv_status          = left(w_case_maint.ddlb_curr_status.text,2)
//End IF
// setting of lv_status stolen from cb_update.clicked
ll_row = w_case_maint.tab_case.tabpage_current.dw_current.GetRow()
lv_status = w_case_maint.tab_case.tabpage_current.dw_current.GetItemString(ll_row,"case_status")
//NLG 9-15-99       *** Stop***

lv_track_type      = left(ddlb_track_type.text,2)


//    need to write to target and track tables

		lv_track_data.track_key = trim(sle_track_key.text)
		lv_track_data.track_type = lv_track_type
     
      if lv_track_type = 'PC' then              //06-20-95 FNC Start
         lv_track_data.proc_track_code = 'PC' 
      end if                                    //06-20-95 FNC End

		fx_track_exists(lv_track_data)
		If trim(lv_track_data.track_name)  = '' and  &
			 (lv_track_type <> 'BE' ) then
			sle_track_key.text = ''
			sle_track_name.text = ''
		   //sqlcmd('ROLLBACK',stars2ca,'Dupe Track Rollback Case',1) 
			STARS2CA.of_rollback()																// FDG 02/20/01
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			RETURN
		Else
			 sle_track_name.text = lv_track_data.track_name
		End If
		gv_result = 0
		lv_return = fx_dup_check(sle_track_key.text,lv_track_type)
		If lv_return = -1  then
			sle_track_key.text = ''
			sle_track_name.text = ''
		   //sqlcmd('ROLLBACK',stars2ca,'Dupe Track Rollback Case',1) 
			STARS2CA.of_rollback()																// FDG 02/20/01
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Committing to Stars2')
				Return
			End If	
			RETURN
		Elseif lv_return = 0 then
				 gv_case_dup_ids = '~'' + sle_track_key.text + '~''
				COMMIT using STARS2CA;
				If stars2ca.of_check_status() <> 0 Then
					errorbox(stars2ca,'Error Committing to Stars2')
					Return
				End If	
             gv_case_target = sle_track_key.text      //12-13-94 FNC
				 openwithparm(w_case_dup_check,lv_track_type)
			    If gv_result = 100 then		
					 closewithreturn(parent,'Delete')
					 //w_case_maint.cb_delete.postevent(clicked!) 
					 w_case_maint.postevent("ue_delete") 
					 setmicrohelp(w_main,'Case Deleted')
				  	 RETURN
			 	 Elseif gv_result <> 0 then 
			  		   lv_return = wf_insert_target(lv_target_id, &
								lv_track_type,lv_create_link,'')
				  		If lv_return = -1 then
							sle_track_key.text = ''
							sle_track_name.text = ''
					  		RETURN
					   End If
			  		   lv_return = fx_Insert_track &
							(lv_track_data,'A',lv_target_id,'Y')
				  		If lv_return = -1 then
							sle_track_key.text = ''
							sle_track_name.text = ''
					  		RETURN
					   End If
						w_case_maint.in_track_exists            = true
						cb_track.enabled = true
						If gv_result = 900 then
							lv_status             = 'CL'
							lv_dupe_close = true
							lv_current_datetime = gnv_app.of_get_server_date_time()//datetime(today(),now())
							//w_case_maint.ddlb_curr_status.text = 'CL'
							//w_case_maint.sle_current_desc.text = 'Case Closed from Dupe Check'
							//w_case_maint.sle_current_date.text = inv_sys_cntl.of_get_default_date//string(today())
							w_case_maint.tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_status",lv_status)
							w_case_maint.tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_status_desc","Case Closed from Dupe Check")
							w_case_maint.tab_case.tabpage_current.dw_current.SetItem(ll_row,"case_status_date",lv_current_datetime)
						End If
				 Else 
						sle_track_key.text = ''
						sle_track_name.text = ''
						setmicrohelp(w_main,'Track Has Not been Created')
						RETURN
			 	 End If
		Elseif lv_return = 100 then
	  		    lv_return = wf_insert_target(lv_target_id, &
								lv_track_type,lv_create_link,'')
		  		 If lv_return = -1 then
					 sle_track_key.text = ''
					 sle_track_name.text = ''
			  		 RETURN
			    End If
	    		 lv_return = fx_Insert_track &
					(lv_track_data,'A',lv_target_id,'Y')
				 If lv_return = -1 then
					 sle_track_key.text = ''
					 sle_track_name.text = ''
					 RETURN
				 End If
				 w_case_maint.in_track_exists            = true
				 cb_track.enabled = true
		End If

// extra stuff to handle dupes
// Begin - Track 3063d
//If w_case_maint.in_case_status  <> lv_status and lv_status = 'CL' then
If w_case_maint.in_case_status  <> lv_status and (lv_status = 'CL' OR lv_status = 'RC' )then
// End - Track 3063d
	lv_return =	fw_close_track_lead(lv_dupe_close)      
	If lv_return <> 0 then	                 
		cb_close.default = true              
		RETURN                                
	End IF                                  
end if

// and set all the other junk...
// 09/01/98 AJS   FS362 convert case to case_cntl
Update Case_CNTL
		 set case_trk_type = :lv_track_type
		 where case_id = Upper( :lv_case_id ) and
				 case_spl = Upper( :lv_case_id_spl ) and
				 case_ver = Upper( :lv_case_id_ver )
Using Stars2ca;

If Stars2ca.of_check_status() <> 0 then
	Errorbox(Stars2ca,'Case could not be updated with the Track type')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

If w_case_maint.in_track_exists = true then
	ddlb_track_type.enabled = false
   cb_update.enabled = false              //08-15-95 FNC 
	sle_track_key.enabled = false
	sle_track_name.enabled = false
	this.enabled = false
	w_case_maint.iv_track_type = lv_track_type
End If


end event

type cb_close from u_cb within w_case_tracking
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1216
integer y = 448
integer width = 466
integer height = 108
integer taborder = 50
string text = "&Close"
end type

on clicked;Close(parent)



//// we need to send the message back...
//sx_track_settings lv_track_settings
//
//lv_track_settings.track_key_enabled = not (sle_track_key.displayonly)
//lv_track_settings.track_key_visible = sle_track_key.visible
//lv_track_settings.track_key = sle_track_key.text
//lv_track_settings.track_name_enabled = not (sle_track_name.displayonly)
//lv_track_settings.track_name_visible = sle_track_name.visible
//lv_track_settings.track_name = sle_track_name.text
//lv_track_settings.track_type_visible = ddlb_track_type.visible
//lv_track_settings.track_type_enabled = ddlb_track_type.enabled
//lv_track_settings.track_type = ddlb_track_type.text
//
//lv_track_settings.cb_track_enabled = cb_track.enabled 
//lv_track_settings.cb_track_visible = cb_track.visible
//
//if st_1.text = 'Count:' Then
//	// we really had a count in the key field...
//	lv_track_settings.track_name = 'Count:'
//end if
//CloseWithReturn (parent, lv_track_settings)
//
end on

type cb_track from u_cb within w_case_tracking
boolean visible = false
string accessiblename = "Tracking"
string accessibledescription = "Tracking..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 901
integer y = 448
integer width = 416
integer height = 108
integer taborder = 40
string text = "&Tracking..."
end type

event clicked;//Modifications:
//NLG 9-15-99 Do not reference sle's on w_case_maint
////////////////////////////////////////////////////////////////////////////
long ll_row

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//If trim(w_case_maint.sle_case_id.text) = '' then
If trim(w_case_maint.is_active_case) = '' then
	Messagebox('EDIT','No case ID has been provided.')
	RETURN
End IF
setmicrohelp(w_main,'Opening Tracking List')


//gv_active_case = w_case_maint.sle_case_id.text		//ajs 4.0 03-11-98 globals
ll_row = w_case_maint.tab_case.tabpage_general.dw_general.GetRow()
gv_active_case = w_case_maint.is_active_case

closewithreturn(parent,'Y')
//cb_close.postevent(clicked!)
//opensheet (w_tracking_list,MDI_Main_Frame,Help_Menu_Position,Layered!)
//
end event

type ddlb_track_type from dropdownlistbox within w_case_tracking
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 393
integer y = 172
integer width = 690
integer height = 352
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
long backcolor = 1073741824
string text = "PV - Provider"
boolean vscrollbar = true
string item[] = {"PV - Provider","PC - Procedure","BE - Patient","RV - Revenue Code"}
borderstyle borderstyle = stylelowered!
end type

type sle_track_name from singlelineedit within w_case_tracking
string accessiblename = "Name"
string accessibledescription = "Name"
accessiblerole accessiblerole = textrole!
integer x = 393
integer y = 300
integer width = 1317
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_track_key from singlelineedit within w_case_tracking
string accessiblename = "Key"
string accessibledescription = "Key"
accessiblerole accessiblerole = textrole!
integer x = 393
integer y = 44
integer width = 695
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_case_tracking
string accessiblename = "Name"
string accessibledescription = "Name"
accessiblerole accessiblerole = statictextrole!
integer x = 114
integer y = 304
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_case_tracking
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = statictextrole!
integer y = 176
integer width = 357
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Track Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_case_tracking
string accessiblename = "Key"
string accessibledescription = "Key"
accessiblerole accessiblerole = statictextrole!
integer x = 114
integer y = 56
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Key:"
alignment alignment = right!
boolean focusrectangle = false
end type

