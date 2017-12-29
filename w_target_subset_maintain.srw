HA$PBExportHeader$w_target_subset_maintain.srw
$PBExportComments$Targets within Subsets (Inherited from w_target_view)
forward
global type w_target_subset_maintain from w_target_view
end type
type cb_create from u_cb within w_target_subset_maintain
end type
type cb_remove from u_cb within w_target_subset_maintain
end type
type cb_split from u_cb within w_target_subset_maintain
end type
type ddlb_track_by from dropdownlistbox within w_target_subset_maintain
end type
type st_5 from statictext within w_target_subset_maintain
end type
end forward

global type w_target_subset_maintain from w_target_view
string accessiblename = "Case Target Subset Create"
string accessibledescription = "Case Target Subset Create"
integer width = 3223
string title = "Case Target Subset Create"
boolean controlmenu = false
event ue_edit_case_closed ( )
cb_create cb_create
cb_remove cb_remove
cb_split cb_split
ddlb_track_by ddlb_track_by
st_5 st_5
end type
global w_target_subset_maintain w_target_subset_maintain

type variables
Boolean in_track_created,in_datawindow_created
String in_case_disp_hold
String in_original_status
String in_case_business,in_subset_business
String in_table_type,in_subc_tables
String in_target_name,in_target_name2
String in_col_num1, in_col_num2
String in_subset_table_type[],in_subset_table_name[]
Integer in_highlighted_rows, ii_xref
sx_subset_ids istr_subset_ids                       //NLG 4.0
nvo_subset_functions inv_subset_functions//NLG 4.0
String is_empty
end variables

forward prototypes
public function integer fx_rewrite_case00_case01 (ref string lv_target_id)
public function integer wf_read_relationship_dw (string arg_rel_type, string arg_base_type)
public function boolean wf_search_for_hospital (string arg_tables[])
public function integer wf_retrieve_dependent_tables (ref string lv_depend_table_name[])
public function integer wf_search_update_dependents (string lv_case_id, string lv_case_spl, string lv_case_ver)
public function integer fx_close_case ()
public function integer fx_delete_case (string split_case)
public function boolean wf_create_datawindow ()
end prototypes

event ue_edit_case_closed();//*******************************************************************
//	Script			ue_edit_case_closed
//
//
//	Description		Prevent updating this window if the case is closed
//						or deleted.
//
//
//*******************************************************************
//	09/21/01	FDG	Stars 4.8.1.	Created
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//*******************************************************************
Boolean		lb_valid_case

n_cst_case		lnv_case					// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case		// FDG 12/21/01

lb_valid_case	=	lnv_case.uf_edit_case_closed (sle_case_id.text)

Destroy	lnv_case							// FDG 12/21/01

IF	lb_valid_case	=	FALSE		THEN
	cb_create.enabled = false
	cb_split.enabled  = false
	cb_remove.enabled = false
	sle_target_id.enabled = false
	sle_subset_id.enabled = false
	sle_description.enabled = false
	cb_close.default = true
END IF


end event

public function integer fx_rewrite_case00_case01 (ref string lv_target_id);
Return 0

end function

public function integer wf_read_relationship_dw (string arg_rel_type, string arg_base_type);//******************************************************************
//06-29-95 FNC Created
//This function reads the datawindow in w_main that was loaded with
//the relationship table.
//******************************************************************
String DWfilter1
int lv_nbr_rows,lv_index

//HRB 2/11/96 - remove FastTrack invoice types for array of tables
string lv_inv_type,lc_fasttrack_inv_type = 'Q'

w_main.dw_stars_rel_dict.SetFilter('')
if arg_base_type = '' then
   DWfilter1 = 'rel_type = ~'' + arg_rel_type + '~' and Rel_id = ~'' + in_table_type + '~''
else
   DWfilter1 = 'rel_type = ~'' + arg_rel_type + '~' and Rel_id = ~'' + gv_sys_dflt + '~' and key6 = ~'' + arg_base_type + '~''
end if

w_main.dw_stars_rel_dict.SetFilter(DWfilter1)
w_main.dw_stars_rel_dict.filter()

lv_nbr_rows = w_main.dw_stars_rel_dict.rowcount()

if lv_nbr_rows = 0 then
   messagebox('INFO','Relationship data not available. Please contact your system administrator')
   return -1
end if

For lv_index = 1 to lv_nbr_rows
	//HRB 2/11/96 - remove FastTrack inv types
	lv_inv_type = w_main.dw_stars_rel_dict.GetItemString (lv_index, 'id_2')
	if upper(left(lv_inv_type,1)) <> lc_fasttrack_inv_type then
   	in_subset_table_type[lv_index] = lv_inv_type
	end if
Next

Return 0
end function

public function boolean wf_search_for_hospital (string arg_tables[]);//****************************************************************
//This function checks to see if an ML subset has any UB92 base 
//type subsets and then eliminates the table types that are not of
//UB92 base.
//
// Arg_tables are the tables in the subset
// in_subset_table_type are the UB92 table types.
//****************************************************************

boolean lv_response
long lv_pos
int lv_index, lv_count,lv_nbr_ub92_tables,lv_nbr_ml_tables
string lv_ub92,lv_tables[]

lv_nbr_ub92_tables = upperbound(in_subset_table_type)

lv_ub92 = in_subset_table_type[1]

For lv_index = 2 to lv_nbr_ub92_tables
    lv_ub92 = lv_ub92 + ',' + in_subset_table_type[lv_index]
Next

lv_nbr_ml_tables = upperbound(arg_tables)

lv_count = 0
For lv_index = 1 to lv_nbr_ml_tables
    lv_pos = pos(lv_ub92,arg_tables[lv_index])
    if lv_pos > 0 then
       lv_response = true
       lv_count = lv_count + 1 
       lv_tables[lv_count] = arg_tables[lv_index]   
    end if
Next

in_subset_table_type[] = lv_tables[]

return lv_response
end function

public function integer wf_retrieve_dependent_tables (ref string lv_depend_table_name[]);//*****************************************************************
//07-27-95 FNC SWAT effort display parameters for dictionary read
//             when there is a bad return code
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//*****************************************************************
Integer lv_count
String lv_sqlerrmsg,lv_where
n_tr lv_transaction

n_tr STARS2CA3
STARS2CA3 = CREATE n_tr 
STARS2CA3.DBMS = STARS2CA.DBMS
STARS2CA3.DATABASE = STARS2CA.DATABASE
STARS2CA3.LOGID = STARS2CA.LOGID
STARS2CA3.LOGPASS = STARS2CA.LOGPASS
STARS2CA3.SERVERNAME = STARS2CA.SERVERNAME
STARS2CA3.USERID = STARS2CA.USERID
STARS2CA3.DBPASS = STARS2CA.DBPASS
STARS2CA3.LOCK = STARS2CA.LOCK
STARS2CA3.DBPARM = STARS2CA.DBPARM

//sqlcmd('CONNECT',stars2ca3,'Error connecting to database',2)			// FDG 02/20/01
stars2ca3.of_connect()																// FDG 02/20/01

Declare d_elem cursor for
	Select distinct elem_name  
			from Stars_rel a,stars_rel b,dictionary
   where a.rel_type = 'DP' and
			a.rel_id  = b.id_2 and
 			b.rel_type = 'GP' and
			b.rel_id   = Upper( :gv_sys_dflt ) and
         elem_type = 'TB' and
 			elem_tbl_type = a.id_2
   Using Stars2ca3;
Open d_elem;

//07-27-95 FNC
lv_where = ' a.rel_type = DP and ' + &
		     'b.rel_type = GP and ' + &
 			  'b.rel_id   = ' + Upper( gv_sys_dflt ) + ' and ' + &
           'elem_type = TB and ' 

If Stars2ca3.of_check_status() <> 0 then
	//sqlcmd('DISCONNECT',Stars2ca3,'',1)					// FDG 02/20/01
	stars2ca3.of_disconnect()									// FDG 02/20/01
	Destroy Stars2ca3;
	Messagebox('ERROR','Retrieving dependent tables for ' + gv_sys_dflt + lv_where)
	Return -1
End IF

lv_count = 0
Do while stars2ca3.sqlcode = 0
   lv_count = lv_count + 1
   Fetch d_elem into :lv_depend_table_name[lv_count];
	
	If stars2ca.of_check_status() <> 0 then
		Messagebox('ERROR','Retrieving dependent table names for Table type ' + gv_sys_dflt + lv_where)
	End If
Loop

Close d_elem;

If stars2ca3.of_check_status() <> 0 then
	//sqlcmd('DISCONNECT',Stars2ca3,'',1)					// FDG 02/20/01
	stars2ca3.of_disconnect()									// FDG 02/20/01
	Destroy Stars2ca3;
	Messagebox('ERROR','Retrieving subset for Table type ' + gv_sys_dflt + lv_where)
End IF

//sqlcmd('DISCONNECT',Stars2ca3,'',1)						// FDG 02/20/01
stars2ca3.of_disconnect()										// FDG 02/20/01
Destroy Stars2ca3;

RETURN 0

end function

public function integer wf_search_update_dependents (string lv_case_id, string lv_case_spl, string lv_case_ver);//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_target_subset_maintain.wf_search_update_dependents
//		Event Name:		N/A
//
// Read STARS relation table to Determine if table type has dependents. 
// If it is does, load all of dependent table types into an array. 
// If it does not have dependents stop processing and move to next
// table type
//
//************************************************************************
//
//	FDG 11/09/95	1.	Rename the subset table (thru fx_open_server_table)
//							to account for open server.
//						2. Remove upperbound from loop
// JGG 01/14/98   1. Change parms passed to fx_open_server_table.
// NLG 01/20/98	1. Change references to sle_subset_id.text to is_subset_id
//
//************************************************************************


String lv_hold_dependent_table_type[],lv_hold_dependent_table_name[]
String lv_sql_update,lv_dependent_table_type[],lv_dependent_table_name[]
String lv_subset_table_type

int lv_Y,lv_X,lv_relationship_rc
boolean lv_dependent_found
string lv_not_used[]
int	li_max, li_max2											

li_max	=	upperbound(in_subset_table_type)				

For lv_Y = 1 to li_max											
  lv_subset_table_type = in_subset_table_type[lv_Y]
  lv_relationship_rc =fx_retrieve_relationship(lv_subset_table_type, &
                         'DP',lv_hold_dependent_table_type[],lv_hold_dependent_table_name[],lv_not_used[])
  if lv_relationship_rc <> 0 then return -1

	li_max2 = upperbound(lv_hold_dependent_table_name)	 

   For lv_X = 1 to li_max2										 
      lv_dependent_table_type[lv_X] = lv_hold_dependent_table_type[lv_X]

		// JGG 01/14/98 - Change parms passed to invoice type and subset id.
		// lv_dependent_table_name[lv_X] = fx_open_server_table (lv_hold_dependent_table_name[lv_X], TRUE) 
		lv_dependent_table_type[lv_X]	=	fx_build_subset_table_name(lv_dependent_table_type[lv_X], is_subset_id)

      lv_sql_update = 'Update ' + lv_dependent_table_name[lv_X] &
                  + ' set case_spl = ~'01~'' &
                  + 'where  case_id  = ~'' + Upper( lv_case_id ) + '~' and ' & 
	      	      + 'case_spl = ~''  + Upper( lv_case_spl ) +  '~' and ' &
		            + 'case_ver = ~''+ Upper( lv_case_ver ) +'~'' 
	   If gc_debug_mode = TRUE then
		 	clipboard(lv_sql_update)
			MESSAGEBOX('Split Update ' + lv_dependent_table_name[lv_X],lv_sql_update)
		End If
		EXECUTE IMMEDIATE	:lv_SQL_update USING Stars2ca;

      If stars2ca.of_check_status() = 0 then 
         lv_dependent_found = TRUE 
      End If
   NEXT

   if lv_dependent_found = FALSE then
	   Errorbox(stars2ca,'Case cannot be split. Error updating dependent table to Split 01, Split Cancelled')
      RETURN -1 
   end if
NEXT

return 0
end function

public function integer fx_close_case ();//Save button on the Dupe Check screen returns 900 when there are no open
//tracks for the case.  In such an instance the case and leads will be closed

//Modifications:
//08-31-98 NLG FS362 convert case to case_cntl
//02/09/01	FDG	Stars 4.6 - PIMR - Add PIMR data.
//	FDG	02/20/01	Stars 4.7 - remove SQLCMD
// FDG	10/11/01	Stars 4.8.1.	Use n_cst_case to add case_log.
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//______________________________________________________________________________

int lv_count
string lv_case_id,lv_case_spl,lv_case_ver
Datetime lv_datetime
String lv_disp, lv_close_disp = 'SYSORCLS'

lv_case_id = left(gv_active_case,10)		//ajs 4.0 03-11-98 TS-145 fix globals
lv_case_spl = mid(gv_active_case,11,2)		//ajs 4.0 03-11-98 TS-145 fix globals
lv_case_ver = mid(gv_active_case,13,2)		//ajs 4.0 03-11-98 TS-145 fix globals
	
//Checks if the case has ever been closed before
Select count(*) into :lv_count
	from case_log
	where case_id = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver ) and
			disp     = 'SYSORCLS'
Using Stars2ca;

If Stars2ca.of_check_status() <> 0 then
	Messagebox('EDIT','Error obtaining Close Disposition, Case will be closed with log Disposition ~'SYSORCLS~'')
Elseif lv_count > 0 then
		 lv_close_disp = 'SYSRECLS'
End If

//08-31-98 NLG FS362 convert case to case_cntl
// FDG 10/11/01 - Update case_disp also
//08-31-98 NLG FS362 convert case to case_cntl
Update Case_cntl
	set case_status = 'CL', case_disp = :lv_close_disp
	where case_id  = :lv_case_id and
			case_spl = :lv_case_spl and
			case_ver = :lv_case_ver 
Using Stars2ca;
// FDG 10/11/01 end

If Stars2ca.of_check_status() <> 0 then
	Messagebox('EDIT','Unable to Close Case, Tracks have been closed')
	RETURN 0
End If

//08-31-98 NLG FS362 convert case to case_cntl
//Get the present Disposition for the case to write entry in case log
Select case_disp into :lv_disp
	from case_cntl
	where case_id = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using Stars2ca;

If Stars2ca.of_check_status() <> 0 then
	//Sqlcmd('ROLLBACK',Stars2ca,'',1)
	Messagebox('ERROR','Tracks have been closed.  Error Reading Current Case Disposition. ' &
		+ ' Case will not be closed.  Sqlcode is ' + string(Stars2ca.sqlcode))
	STARS2CA.of_rollback()																// FDG 02/20/01
	RETURN 0
End If

//lv_datetime = datetime(today(),now())
lv_datetime = gnv_app.of_get_server_date_time()//ts2020c use server date not pc date
//write log entry for closed status with present disposition
// FDG 02/09/01 - Add PIMR data

// FDG 10/11/01 - Use n_cst_case to insert case_log entries.

String	ls_message
Integer	li_rc

ls_message	=	'Case Closed from Dupe Check'

n_cst_case		lnv_case					// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case		// FDG 12/21/01

li_rc			=	lnv_case.uf_audit_log ( lv_case_id, lv_case_spl, lv_Case_ver, ls_message )

Destroy	lnv_case							// FDG 12/21/01

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for closed case.'	+	&
					'  Case: ' + lv_case_id + lv_case_spl + lv_Case_ver + '. Script: '		+	&
					'w_target_subset_maintain.fx_close_case()')
	Return	0
END IF

//// FDG 02/09/01 - Add PIMR data
//Insert into Case_log
//	(case_id,case_spl,case_ver,
//	 user_id,status,disp,
//	 status_desc,status_datetime,sys_datetime,case_custom1_amt,case_custom2_amt,
//		 case_custom3_amt,identified_amt,future_savings_amt,
//		 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//		 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//		 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//		 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//		 pmr_case_custom4_amt,pmr_case_custom5_amt,
//		 pmr_case_custom6_amt,pmr_case_custom7_amt,
//		 pmr_case_custom8_amt,pmr_case_custom9_amt)
//	Values
//	(:lv_case_id,:lv_case_spl,:lv_case_ver,
//	 :gc_user_id,'CL',:lv_disp,
//	 'Case Closed from Dupe Check',:lv_datetime,:lv_datetime,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
//Using Stars2ca;
//If Stars2ca.of_check_status() <> 0 then
//	Sqlcmd('ROLLBACK',Stars2ca,'',1)
//	Messagebox('ERROR','Tracks have been closed.  Error Writing Case Log. ' &
//		+ ' Case will not be closed.  Sqlcode is ' + string(Stars2ca.sqlcode))
//	RETURN 0
//End If
//
////This is the system created closed disposition
//// FDG 02/09/01 - Add PIMR data
//Insert into Case_log
//	(case_id,case_spl,case_ver,
//	 user_id,status,disp,
//	 status_desc,status_datetime,sys_datetime,case_custom1_amt,case_custom2_amt,
//		 case_custom3_amt,identified_amt,future_savings_amt,
//		 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//		 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//		 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//		 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//		 pmr_case_custom4_amt,pmr_case_custom5_amt,
//		 pmr_case_custom6_amt,pmr_case_custom7_amt,
//		 pmr_case_custom8_amt,pmr_case_custom9_amt)
//	Values
//	(:lv_case_id,:lv_case_spl,:lv_case_ver,
//	 :gc_user_id,'CL',:lv_close_disp,
//	 'Case Closed from Dupe Check',:lv_datetime,:lv_datetime,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
//Using Stars2ca;
//If Stars2ca.of_check_status() <> 0 then
//	Sqlcmd('ROLLBACK',Stars2ca,'',1)
//	Messagebox('ERROR','Tracks have been closed.  Error Writing Case Log. ' &
//		+ ' Case will not be closed.  Sqlcode is ' + string(Stars2ca.sqlcode))
//	RETURN 0
//End If
// FDG 10/11/01 end

//close Leads 
Update Lead
	set status = 'CL'
	where case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using Stars2ca;

If Stars2ca.of_check_status() <> 0 and stars2ca.sqlcode <> 100 then
	//Sqlcmd('ROLLBACK',Stars2ca,'',1)
	Messagebox('ERROR','Tracks have been closed.  Error Closing Leads. ' &
		+ ' Case will not be closed.  Sqlcode is ' + string(Stars2ca.sqlcode))
	STARS2CA.of_rollback()																// FDG 02/20/01
	RETURN 0
End If

Return 0

end function

public function integer fx_delete_case (string split_case);//*******************************************************************
//	03/16/00 FNC	Track 2159 Add case money fields to case log insert
//	08-31-98 NLG	FS362 convert case to case_cntl
//	01-20-98 NLG	4.0 Subset Redesign -- replace call to fx_delete_case_subset
//						with call to nvo_subset_functions
//	06-24-97 FNC	FS/TS169 Uncomment connect that was mistakenly commented
//	10-20-95 FNC	Take out connects and disconnects
//	01/17/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 02/09/01	FDG	Stars 4.6 - PIMR - Add PIMR data.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
// 10/12/01	FDG	Stars 4.8.1.  Use n_cst_case to insert case_log.
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
// 07/30/02 JasonS Track 3188d Fix GPF
//*******************************************************************
//This function is called by Buttons Create and Split
String    lv_subset_crit_id,lv_subset_id
string    lv_case_active
string    lv_case_cat, lv_case_dept, lv_case_id,lv_case_spl,lv_case_ver, ls_empty
int       lv_msg,lv_count
Datetime  lv_todays_date
Boolean   lv_reset_subset
int 		 li_rc
decimal	 ldec_initial = 0.00


// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

setpointer(hourglass!)
//lv_todays_date = datetime(today(),now())
lv_todays_date = gnv_app.of_get_server_date_time()//ts2020c use server date, not pc date
lv_case_active = gv_active_case			//ajs 4.0 03-11-98
lv_case_id	= Trim(left(sle_case_id.text,10) )		// FDG 04/16/01
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 - end

//08-31-98 NLG FS362 convert case to case_cntl
If split_case = 'Y' then
	Delete from  case_cntl
		where  case_id  = Upper( :lv_case_id ) and 
				 case_spl = Upper( :lv_case_spl ) and
				 case_ver = Upper( :lv_case_ver )
	Using  stars2ca;
Else
	Update Case_cntl
		set case_status = 'DL',
			 case_disp = 'SYSDELET',
			 case_updt_user   = :gc_user_id,
			 case_status_desc = 'Case Is Deleted',
			 case_status_date = :lv_todays_date,
			 CASE_DISP_HOLD   = :ls_empty					//	01/17/01	GaryR	Stars 4.7 DataBase Port
		where  case_id  = Upper( :lv_case_id ) and 
				 case_spl = Upper( :lv_case_spl ) and
				 case_ver = Upper( :lv_case_ver )
	Using  stars2ca;
End If
If stars2ca.of_check_status() = 100 then 
	//SQLCMD('ROLLBACK',Stars2ca,'',1)				// FDG 02/20/01
	Stars2ca.of_rollback()								// FDG 02/20/01
   //10-20-95 FNC Start
	Messagebox('ERROR','Case Not Found')
	return 100
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Deleting From Case Id')
	RETURN -1
End If

//Delete Case Log
Delete	from  case_log
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_spl ) and
			 case_ver = Upper( :lv_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Case Log Table')
	return -1
End If

If split_case <> 'Y' then
	// FDG 10/12/01 - Use inv_case to insert a case_log
	n_cst_case		lnv_case					// FDG 12/21/01
	lnv_case	=	CREATE	n_cst_case		// FDG 12/21/01
	lnv_case.uf_audit_log ( lv_case_id, lv_case_spl, lv_case_ver, 'Case Is Deleted' )
	Destroy	lnv_case							// FDG 12/21/01
	//// FDG 02/09/01 - Add PIMR data
	//Insert into case_log
	//		(case_id,case_spl,case_ver,
	//		 status,disp,
	//		 status_desc,status_datetime,
	//		 User_id,sys_datetime,
	//		 case_custom1_amt,case_custom2_amt,
	//		 case_custom3_amt,identified_amt,
	//		 future_savings_amt,
	//		 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
	//		 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
	//		 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
	//		 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
	//		 pmr_case_custom4_amt,pmr_case_custom5_amt,
	//		 pmr_case_custom6_amt,pmr_case_custom7_amt,
	//		 pmr_case_custom8_amt,pmr_case_custom9_amt)
	//	Values
	//		(:lv_case_id,:lv_case_spl,:lv_case_ver,
	//		 'DL','SYSDELET','Case Is Deleted',:lv_todays_date,
	//		 :gc_user_id,:lv_todays_date,
	//		 :ldec_initial,:ldec_initial,
	//		 :ldec_initial,:ldec_initial,
	//		 :ldec_initial,0,0,0,0,0,0,0,0,
	//		 :ldec_initial,:ldec_initial,
	//		 :ldec_initial,:ldec_initial,
	//		 :ldec_initial,:ldec_initial)
	//Using stars2ca;
	//If stars2ca.of_check_status() <> 0 then 
	//	Errorbox(stars2ca,'Error Inserting Case Log')
	//	RETURN -1
	//End If
	// FDG 10/12/01 end
End IF

//If trim(gv_active_subset) <> '' then		//ajs 4.0 03-11-98 TS145-fix globals
If trim(gc_active_subset_id) <> '' then	//ajs 4.0 03-11-98 Ts145-fix globals
	Select count(*) into :lv_count
		from case_link
		where  case_id  = Upper( :lv_case_id ) and 
				 case_spl = Upper( :lv_case_spl ) and
				 case_ver = Upper( :lv_case_ver ) and
				 link_type = 'SUB' and
				 link_key = Upper( :gc_active_subset_id )
	Using  stars2ca;
	If stars2ca.of_check_status() < 0 then 
		Errorbox(stars2ca,'ERROR Reading Case Link for active Subset')
		return -1
	Elseif lv_count > 0 then
			 lv_reset_subset = true
	End If
End If

// Delete Targets
Delete from Target_cntl
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_spl ) and
			 case_ver = Upper( :lv_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Target Control Table')
	return -1
End If

Delete from Target
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_spl ) and
			 case_ver = Upper( :lv_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Target Table')
	return -1
End If

//Delete Tracks
Delete from Track
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_spl ) and
			 case_ver = Upper( :lv_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Track Table')
	return -1
End If

Delete from Track_log
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_spl ) and
			 case_ver = Upper( :lv_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Track Log Table')
	return -1
End If

//Delete Case Leads
Delete from Lead
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_spl ) and
			 case_ver = Upper( :lv_case_ver )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Leads from Table')
	return -1
End If

Delete from Notes
	where  note_rel_type  = 'CA' and
			 note_rel_id    = Upper( :lv_case_active )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Notes Table')
	return -1
End If

//Delete all Subsets For This Case
n_tr STARS2CA1
stars2ca1 = CREATE n_tr 
stars2ca1.DBMS = STARS2CA.DBMS
stars2ca1.DATABASE = STARS2CA.DATABASE
stars2ca1.LOGID = STARS2CA.LOGID
stars2ca1.LOGPASS = STARS2CA.LOGPASS
stars2ca1.SERVERNAME = STARS2CA.SERVERNAME
stars2ca1.USERID = STARS2CA.USERID
stars2ca1.DBPASS = STARS2CA.DBPASS
stars2ca1.LOCK = STARS2CA.LOCK
stars2ca1.DBPARM = STARS2CA.DBPARM

//sqlcmd('CONNECT',stars2ca1,'',1)   //06-25-97 FNC		// FDG 02/20/01
stars2ca1.of_connect()												// FDG 02/20/01
	
Declare link_c cursor for
	Select link_key
		from case_link
		where  case_id  = Upper( :lv_case_id ) and 
				 case_spl = Upper( :lv_case_spl ) and
				 case_ver = Upper( :lv_case_ver ) and
				 link_type = 'SUB'
Using stars2ca1;

Open link_c;
If stars2ca1.of_check_status() <> 0 then
	//sqlcmd('Rollback',stars2ca,'Error Opening Criteria Cursor',1)
	stars2ca.of_rollback()
	//sqlcmd('DISCONNECT',stars2ca1,'',1)						// FDG 02/20/01
	stars2ca1.of_disconnect()										// FDG 02/20/01
	Destroy stars2ca1;
	Messagebox('EDIT','Error Opening Cursor for Subsets')
	RETURN -1
End If

Do while stars2ca1.sqlcode = 0
	Fetch link_c into :lv_subset_id;
	If stars2ca1.of_check_status() = 100 then exit

	If stars2ca1.sqlcode <> 0 then
		//sqlcmd('Rollback',stars2ca,'Error fetching Subset Cursor',1)
		stars2ca.of_rollback()
		close link_c; 
		//sqlcmd('DISCONNECT',stars2ca1,'Error fetching Subset Cursor',1)		// FDG 02/20/01
		stars2ca1.of_disconnect()															// FDG 02/20/01
		Destroy stars2ca1;
		Messagebox('ERROR','Error Fetching Subset Cursor')
		RETURN  -1
	End If

	// JasonS 07/30/02 Begin - Track 3188d
	istr_subset_ids.subset_id = lv_subset_id
	// JasonS 07/30/02 End - Track 3188d

	li_rc = inv_subset_functions.uf_set_structure(istr_subset_ids)
	if li_rc <> 1 then
		close link_c; 
		//sqlcmd('DISCONNECT',stars2ca1,'Error fetching Subset Cursor',1)		// FDG 02/20/01
		stars2ca1.of_disconnect()															// FDG 02/20/01
		Destroy stars2ca1;
		RETURN  -1
	end if
	lv_msg = inv_subset_functions.uf_delete_subset()
	if lv_msg < 1 then
		close link_c; 
		//sqlcmd('DISCONNECT',stars2ca1,'Error fetching Subset Cursor',1)		// FDG 02/20/01
		stars2ca1.of_disconnect()															// FDG 02/20/01
		Destroy stars2ca1;
		Messagebox('ERROR','Error deleting subset')
		RETURN  -1
	End If
Loop

close Link_c; 
If stars2ca1.of_check_status() <> 0 then
	//sqlcmd('Rollback',stars2ca,'Error closing Subset Cursor',1)
	stars2ca.of_rollback()
//	sqlcmd('DISCONNECT',stars2ca,'Error closing Subset Cursor',1)
	stars2ca1.of_disconnect()																// FDG 02/20/01
	Errorbox(stars2ca1,'Error closing Subset Cursor')
	Destroy stars2ca1;
	Messagebox('ERROR','Error Closing Subset Cursor')
	RETURN -1
End If
//sqlcmd('DISCONNECT',stars2ca1,'Closing Criteria Cursor',1)					// FDG 02/20/01
stars2ca1.of_disconnect()																	// FDG 02/20/01
Destroy stars2ca1;

If sle_case_id.text <> '' then
	Delete from sys_cntl
		where cntl_case = Upper( :sle_case_id.text )
	Using  stars2ca;
	If stars2ca.of_check_status() < 0 then 
		Errorbox(stars2ca,'ERROR Deleting System Control Case Hold Record')
		return -1
	End If
End IF
Commit using stars2ca;
if stars2ca.of_check_status() <> 0 then    //10-20-95 FNC Start
   errorbox(stars2ca,'Error performing commit in fx_delete_case')
   return -1
end if                          //10-20-95 FNC End
gv_active_case = ''
gv_target_subset_id = ''
GV_CASE_TARGET = ''
If lv_reset_subset = true then
	gc_active_subset_id = ''
End If

RETURN 0
end function

public function boolean wf_create_datawindow ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_target_subset_maintain.wf_create_datawindow
//		Event Name:		N/A
//
//   CREATED 7-13-94 FNC
// This function creates the appropriate sql statement and constructs
// a data window listing targets. The SQL varies based on tracking 
// type and business type
//
// Modifications:
//	11/27/00	FDG	Stars 4.7.	Make the SQL DBMS independent as it relates to 
//						outer joins.  Also, make the column alias names have double
//						quotes instead of single quotes.
// 01-20-98 NLG	4.0	1.	comment wherever cb_split.enabled=true. Change in_subset_business
//									to gv_sys_dflt
//								2. Replace all instances of sle_subset_id.text with is_subset_id
//								3. When building select statements, remove case and subset id conditions in
//									WHERE clause
// 01/14/98 JGG	Change parms passed to fx_open_server_table.  
//	12/31/97	FDG	Remove the color from the d/w syntax
// 05/14/96 FNC	If ENROLLEE view contains a join do not retrieve the 
//             	patient name.
// 03/19/00	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	04/04/01	FDG	Stars 4.7.	Place a double-quote around the column aliases.
//	09/25/02	GaryR	SPR 3324d	Centralize the logic to format labels
// 10/13/04	MikeF	SPR3650d	Changed lookup logic
// 09/27/05 Katie SPR3308d Added functionality to allow user to prefilter RV track types before creating target
// 12/20/05 JasonS 4591d  call gnv_sql.of_trimdata on track type prior to executing query.
// 03/16/06 HYL	4591d	Added addional clause in where clause for STARS_WIN_PARM table
// 03/25/06 JasonS 4591d  Changed logic to add additional where clause to STARS_WIN_PARM query only if it is returning 
//									multiple rows
// 11/10/06 Katie	SPR 4763 Added logic to use the new ddlb_track_by and access the 
//							PROV_NPI_XREF for the PROV_NPI fields.
// 06/06/07	GaryR	SPR 5060	Remove references to UB92
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//************************************************************************

string lv_sql_statement,lv_syntax, lv_style,lv_not_used1[],lv_not_used2[], ls_describe
string lv_target_name, lv_target_name2, lv_tables[], lv_where, lv_proc_code_lookup
STRING LV_COL_NUM1,LV_COL_NUM2, lv_case_id, lv_case_spl, lv_case_ver,lv_col_name[]
string lv_error,lv_prov_id_label_rev_tbl_type,lv_dict_table_type,lv_col_label_name[]
string lv_hold_table_type,lv_track_type,lv_string_rc,lv_col_label_name_new[],lv_title
string lv_prov_src_table, lv_prov_name_col
String	ls_outer_from,				&
			ls_outer_where, ls_outer_rv_where

int lv_result,li_x,li_y,nbr_of_claim_types,lv_relationship_rc
int lv_i,lv_rc, li_upper, li_rev_pos

long	ll_pos	
long  ll_query_cnt

boolean lv_hospital, lb_case	=	FALSE, lb_prov

n_cst_labels	lnv_labels			//	09/25/02	GaryR	SPR 3324d
n_cst_prefilter_attrib lnv_cst_prefilter_attrib //09/28/05 Katie SPR 3308d

lv_case_id = left(gv_active_case,10)		//ajs 4.0 03-11-98 TS-145 fix globals
lv_case_spl = mid(gv_active_case,11,2)		//ajs 4.0 03-11-98 TS-145 fix globals
lv_case_ver = mid(gv_active_case,13,2)		//ajs 4.0 03-11-98 TS-145 fix globals

// Read STARS relation table to Determine if table type is a group. 
// If it is a group load all of individual table types into an array. 
// If it is not a group load the table type into the first occurence 
// of the array

//if subset business is equal to the table type the subset is a 
//group subset

if gv_sys_dflt = in_table_type then					//ts145-case target list.doc comment#2
	if left(ddlb_track_type.text,2) <> 'RV' then   
      // load in_subset_table_type with individual tables   
      lv_relationship_rc = wf_read_relationship_dw('GP','')
   else
      lv_relationship_rc = wf_read_relationship_dw('QT','UB92')
   end if
	if lv_relationship_rc <> 0 then return false        
elseif in_table_type = 'ML' Then
   if left(ddlb_track_type.text,2) = 'RV' then    
      lv_relationship_rc = wf_read_relationship_dw('QT','UB92')
	   if lv_relationship_rc <> 0 then return false 
	 	fx_decode_tables(in_subc_tables,lv_tables[])
		//This function will reset in_subset_table_type[] to contain only
		//UB92 table types that are in the subset
      lv_hospital = wf_search_for_hospital(lv_tables[])	
      if lv_hospital = false then
         setmicrohelp(w_main,'Cannot track by revenue code. Subset does not contain any facility claims')
         return false
      end if
	else		
   	fx_decode_tables(in_subc_tables,in_subset_table_type[])		
   end if
else
  in_subset_table_type[1] = in_table_type
end if

//Set lv_track_type based on the selection in the track by drop-down list box
if left(ddlb_track_type.text,2) = 'PV' and & 
   trim(ddlb_track_by.text) = trim('PROV_UPIN') then
     lv_track_type = 'UP'              
elseif left(ddlb_track_type.text,2) = 'PV' and & 
   trim(ddlb_track_by.text) = trim('PROV_NPI') and &
	gv_npi_cntl > 0 then
     lv_track_type = 'NPI'              
else
   lv_track_type = left(ddlb_track_type.text,2)
end if

//Loop is executed once for each table within a group. If not a
//group it is only executed once since there is only one occurence

li_upper	=	UpperBound(in_subset_table_type)		

FOR li_y = 1 TO li_upper									

	gnv_sql.of_TrimData(lv_track_type) // 12/20/05 JasonS Track 4591d
// 1-20-98 NLG 4.0 remove in_subset_table_name from SELECT and replace :in_subset_business with gv_sys_dflt

	select count(*)
	into :ll_query_cnt
	FROM STARS_WIN_PARM  
  	 WHERE ( STARS_WIN_PARM.SYS_ID = Upper( :gv_sys_dflt ) ) AND  	  
     ( Upper(STARS_WIN_PARM.LABEL) = Upper( :lv_track_type ) ) AND	
     ( STARS_WIN_PARM.TBL_TYPE = Upper( :in_subset_table_type[li_y] ) )
	using stars2ca;
		  
   	If stars2ca.of_check_status() <> 0 then
      		lv_where = ' STARS_WIN_PARM.SYS_ID = ' + in_subset_business + &  
              ' and Upper(STARS_WIN_PARM.LABEL) = ' + Upper( lv_track_type ) + &
              ' and STARS_WIN_PARM.TBL_TYPE = ' + Upper( in_subset_table_type[li_y] )
	   		Errorbox(stars2ca,'Error reading STARS WIN PARMS table' + lv_where)
	   		cb_close.Postevent(clicked!)
	   		RETURN FALSE
	end if
	
	IF ll_query_cnt > 1 then
		SELECT STARS_WIN_PARM.COL_NAME,
				 STARS_WIN_PARM.A_DFLT  
		INTO  :lv_target_name,
			  :lv_prov_id_label_rev_tbl_type  
		FROM STARS_WIN_PARM  
		WHERE ( STARS_WIN_PARM.SYS_ID = Upper( :gv_sys_dflt ) ) AND  	  
				( Upper(STARS_WIN_PARM.LABEL) = Upper( :lv_track_type ) ) AND	// 03/19/00	GaryR	Stars 4.7 DataBase Port
				( STARS_WIN_PARM.TBL_TYPE = Upper( :in_subset_table_type[li_y] ) ) AND 
			(STARS_WIN_PARM.WIN_ID = 'W_PARENT_DETAIL_ANALYSIS') // 03/16/06 HYL Track 4591d
		USING STARS2CA ;
	ELSE
		SELECT STARS_WIN_PARM.COL_NAME,
				 STARS_WIN_PARM.A_DFLT  
			INTO  :lv_target_name,
			  :lv_prov_id_label_rev_tbl_type  
		FROM STARS_WIN_PARM  
		WHERE ( STARS_WIN_PARM.SYS_ID = Upper( :gv_sys_dflt ) ) AND  	  
				( Upper(STARS_WIN_PARM.LABEL) = Upper( :lv_track_type ) ) AND	// 03/19/00	GaryR	Stars 4.7 DataBase Port
				( STARS_WIN_PARM.TBL_TYPE = Upper( :in_subset_table_type[li_y] ) ) 
		USING STARS2CA ;
	END IF

 	If stars2ca.of_check_status() <> 0 then
			lv_where = ' STARS_WIN_PARM.SYS_ID = ' + in_subset_business + &  
					  ' and Upper(STARS_WIN_PARM.LABEL) = ' + Upper( lv_track_type ) + &
					  ' and STARS_WIN_PARM.TBL_TYPE = ' + Upper( in_subset_table_type[li_y] )
			Errorbox(stars2ca,'Error reading STARS WIN PARMS table' + lv_where)
			cb_close.Postevent(clicked!)
			RETURN FALSE
	End If
   
	Stars2ca.of_commit()
// JGG 01/1/4/98 Change parms passed to invoice type and subset id.	
// in_subset_table_name[li_y]	=	fx_open_server_table (in_subset_table_name[li_y], lb_case)
// Katie 09/27/05 Track 3308d If track_type is 'RV' then use rev_tbl_type for creating Target
// open w_prefilter_ub92 before track add window to see if the user wants to use the revenue criteria or not
		if (left(ddlb_track_type.text,2) = 'RV') then
			in_subset_table_name[li_y]	= fx_build_subset_table_name(lv_prov_id_label_rev_tbl_type, is_subset_id )
			lnv_cst_prefilter_attrib.is_where = "SS~~t" + in_subset_table_name[li_y] + ".~~t" + is_subset_id
			openwithparm(w_prefilter_ub92,lnv_cst_prefilter_attrib)
			lnv_cst_prefilter_attrib = message.PowerObjectParm
		else 
			in_subset_table_name[li_y]	= fx_build_subset_table_name(in_subset_table_type[li_y], is_subset_id )
		end if
		if in_subset_table_name[li_y] = 'ERROR' then
			MessageBox("ERROR","Error building subset table name")
			cb_close.Postevent(clicked!)
			return false
		end if

SELECT CNTL_NO 
INTO :ii_xref
FROM SYS_CNTL
WHERE CNTL_ID = 'EN_XREF'
USING stars2ca;

if stars2ca.of_check_status() <> 0 then
	messagebox('WARNING','Unable to determine status of ENROLLEE view.~r Enrollee name will not be displayed.')
	rollback using stars2ca;
   ii_xref = 1
else
	Stars2ca.of_commit()
end if   

//Check tracking type and business type to construct the sql statement 
//and datawindow.

CHOOSE CASE left(ddlb_track_type.text,2)
   CASE 'PV' 
		if (lv_track_type = 'NPI' and gv_npi_cntl > 0) then
			lv_prov_src_table = 'PROV_NPI_XREF'
			lv_prov_name_col = 'PROV_NPI_NAME'
		else
			lv_prov_src_table = 'PROVIDERS'
			lv_prov_name_col = 'PROV_NAME'
		end if	
		lb_prov = TRUE

		ls_outer_where	=	gnv_sql.of_left_outer_join_where (in_subset_table_name[li_y] + '.' + lv_target_name,	&
																				lv_prov_src_table + '.'	+	lv_prov_id_label_rev_tbl_type)
		ls_outer_from	=	in_subset_table_name[li_y]	+	', ' + lv_prov_src_table

		gnv_sql.of_trimdata(is_empty)
		IF	Trim (ls_outer_where)	>	' '			THEN
				ls_outer_where	=	' WHERE ('	+	ls_outer_where &
					+ ' AND ' +   in_subset_table_name[li_y]+ '.'+ lv_target_name &
					+ ' <> ~''  + is_empty &
					+	'~' )'


		END IF																				
   	   lv_sql_statement = 'SELECT DISTINCT ' &
                  +   in_subset_table_name[li_y] + '.' + lv_target_name &
                  +   ', ~'A~' "Status", ' + lv_prov_name_col + ' ' &
						+	 ' FROM ' + ls_outer_from &
						+	 ls_outer_where &
						+ ' ORDER BY '  + in_subset_table_name[li_y] + '.' + lv_target_name  
		lv_col_name[1] = in_subset_table_name[li_y] + '.' + lv_target_name
    		lv_col_name[2] = 'A'
     	lv_col_name[3] = lv_prov_src_table + '.' + lv_prov_name_col
	CASE 'PC','RV'
// Start Use lv_proc_code_lookup instead of 
// sle_track_type.text in the where statement
   	if left(ddlb_track_type.text,2) = 'PC' then
			
			lv_proc_code_lookup = gnv_dict.event ue_get_lookup_type( Upper(in_subset_table_type[li_y]), "PROC_CODE")
			
         IF lv_proc_code_lookup=gnv_dict.ics_error THEN
	         cb_close.Postevent(clicked!)
	         RETURN FALSE
         END IF
      else
        lv_proc_code_lookup = 'RV'
      end if   
		//	FDG	11/27/00	Begin
		ls_outer_where	=	gnv_sql.of_left_outer_join_where (in_subset_table_name[li_y] + '.' + lv_target_name,	&
																			"CODE.CODE_CODE")
		ls_outer_from	=	in_subset_table_name[li_y]	+	', CODE '

		IF	Trim (ls_outer_where)	>	' '			THEN
			ls_outer_where	=	' WHERE ('	+	ls_outer_where	+	' ) AND'
		ELSE
			ls_outer_where	=	' WHERE '
		END IF
		// FDG	11/27/00	End

		//1-20-98 NLG 4.0 remove subset and case conditions as each subset now has own table
		// FDG 04/04/01 - Place double-quote around Status.
	IF ((Trim(lnv_cst_prefilter_attrib.is_where) = 'IGNORE') OR (Trim(lnv_cst_prefilter_attrib.is_where) = 'CANCEL')) THEN
		ls_outer_rv_where = ''
	else
		ls_outer_rv_where = Trim(lnv_cst_prefilter_attrib.is_where) 
 	end IF	
      lv_sql_statement = 'SELECT DISTINCT ' &
                  +   in_subset_table_name[li_y] + '.' + lv_target_name &
                  +   ',~'A~' "Status", CODE.CODE_DESC , CODE.CODE_TYPE' & 
						+	 ' FROM ' + ls_outer_from &
						+	 ls_outer_where &
						+	 ' ( CODE.CODE_TYPE = ~'' + Upper( lv_proc_code_lookup ) + '~') ' &
						+  ls_outer_rv_where &
 					   +   ' ORDER BY ' + in_subset_table_name[li_y] + '.' + lv_target_name					 
      lv_col_name[1] = in_subset_table_name[li_y] + '.' + lv_target_name
      lv_col_name[2] = 'A'
      lv_col_name[3] = 'CODE.CODE_DESC'
      lv_col_name[4] = 'CODE.CODE_TYPE'
	CASE 'BE'        

	 	if ii_xref = 0 then	
			//	FDG	11/27/00	Begin
			ls_outer_where	=	gnv_sql.of_left_outer_join_where (in_subset_table_name[li_y] + '.' + lv_target_name,	&
																				"ENROLLEE.RECIP_ID")
			ls_outer_from	=	in_subset_table_name[li_y]	+	', ENROLLEE '

			IF	Trim (ls_outer_where)	>	' '			THEN
				ls_outer_where	=	' WHERE ('	+	ls_outer_where	+	' )'
			END IF
			// FDG	11/27/00	End
			
			// FDG 04/04/01 - Place double-quote around Status.
	   	lv_sql_statement = 'SELECT DISTINCT ' &
                  +   in_subset_table_name[li_y] + '.' + lv_target_name + ' "Patient ID"' &   
                  +   ',~'A~' "Status", ENROLLEE.PATIENT_NAME "Name"' &
						+	 ' FROM ' + ls_outer_from &
						+	 ls_outer_where &
 					   +   ' ORDER BY ' + in_subset_table_name[li_y] + '.' + lv_target_name
   	  	lv_col_name[1] = in_subset_table_name[li_y] + '.' + lv_target_name
    	 	lv_col_name[2] = 'A'
     		lv_col_name[3] = 'ENROLLEE.PATIENT_NAME'
		else   //05-13-96 FNC Start - If ENROLLEE view contains a join
			//1-20-98 NLG 4.0 remove subset and case conditions as each subset now has own table
			// FDG	11/27/00 - Make column alias have double-quotes
			// FDG 04/04/01 - Place double-quote around Status.
	   	lv_sql_statement = 'SELECT DISTINCT ' &
                  +   in_subset_table_name[li_y] + '.' + lv_target_name + ' "Patient ID"' &   
                  +   ',~'A~' "Status"' &
						+	 ' FROM ' + in_subset_table_name[li_y] &
    				   +   ' ORDER BY ' + in_subset_table_name[li_y] + '.' + lv_target_name
   	  	lv_col_name[1] = in_subset_table_name[li_y] + '.' + lv_target_name
    	 	lv_col_name[2] = 'A'
		end if 		
   CASE ELSE    
		// FDG 04/04/01 - Place double-quote around Status.
		IF lv_target_name <> '*' THEN // 03/16/06 HYL Track 4591d
			lv_sql_statement = 'SELECT DISTINCT ' &            
         						+   in_subset_table_name[li_y] + '.' + lv_target_name &
							+   ', ~'A~' "Status" ' &
							+	 ' FROM ' + in_subset_table_name[li_y] &
							+   ' ORDER BY '  + in_subset_table_name[li_y] + '.' + lv_target_name
		ELSE
			lv_sql_statement = 'SELECT DISTINCT ' &            
         						+   in_subset_table_name[li_y] + '.' + lv_target_name &
							+   ', ~'A~' "Status" ' &
							+	 ' FROM ' + in_subset_table_name[li_y] 
		END IF
     lv_col_name[1] = in_subset_table_name[li_y] + '.' + lv_target_name
     lv_col_name[2] = 'A'
   END CHOOSE

   if gc_debug_mode = true then
      MESSAGEBOX ('INFORMATION',lv_sql_statement)
   end if
	//Create Datawindow
   lv_style = 'datawindow(units=1 )' &
     + 'style(type = grid)'  +  'Column(font.Face=~'System~') ' &
     +  'Text(font.Face=~'System~') '

   lv_syntax = SyntaxFromSQL(stars2ca,lv_sql_statement,lv_style,lv_error)
   CLIPBOARD(LV_SYNTAX)

	//  Test for successful Create.
   If lv_error <> '' then
	   if stars2ca.of_commit() <> 0 then
         messagebox('ERROR','Error performing commit in wf_create_datawindow')
      end if                            
  	   messagebox('Error',lv_error)
	   cb_close.Postevent(clicked!)
    	return FALSE 
   End if

   if lv_result = 0 then
      lv_result = Create(dw_1,lv_syntax)
		if lb_prov = TRUE then
			dw_1.modify("cprov_id_t.width = 135")      //11-10-97 AJS 
			dw_1.modify("cprov_id.width = 135")	      
			dw_1.modify("cprov_upin_t.width = 135")
			dw_1.modify("cprov_upin.width = 135")
		end if

      if lv_result < 0 then
         if stars2ca.of_commit() <> 0 then
            messagebox('ERROR','Error performing commit in wf_create_datawindow')
         end if
         messagebox('ERROR','Cannot Create DataWindow',stopsign!)
	      cb_close.Postevent(clicked!)
	      return FALSE
      end if
      if settransobject(dw_1,stars2ca) < 0 then
         errorbox(stars2ca,'Error Setting Transaction Object')
	      cb_close.Postevent(clicked!)
  	      return false
      end if
   end if

   dw_1.setsqlselect(lv_sql_statement)
   retrieve(dw_1)
NEXT

st_row_count.text = string(dw_1.rowcount())

if integer(st_row_count.text) < 0 then
   if stars2ca.of_commit() <> 0 then
      messagebox('ERROR','Error performing commit in wf_create_datawindow')
   end if                          
   setmicrohelp(w_main,'Error creating target list for the data window')
	cb_close.Postevent(clicked!)
   return false
Elseif integer(st_row_count.text) = 0 then
       if stars2ca.of_commit() <> 0 then
          errorbox(stars2ca,'Error performing commit in wf_create_datawindow')
          return false
       end if                           
		 show(this)
		 If left(ddlb_track_type.text,2) = 'PC' then
			 Messagebox('CONTACT YOUR SYSTEM ADMINISTRATOR', &	
		       'No Active Procedure Codes Exist on the Code Table for the linked Subset')
		 ElseIf left(ddlb_track_type.text,2) = 'RV' then   
			 Messagebox('CONTACT YOUR SYSTEM ADMINISTRATOR', &	
		       'No Active Revenue Codes Exist on the Code Table for the linked Subset')
		 ElseIf left(ddlb_track_type.text,2) = 'BE' then
			 Messagebox('CONTACT YOUR SYSTEM ADMINISTRATOR', &	
		       'No Active Patients Exist on the Patient Table for the linked Subset')
		 Else
			if (lv_track_type = 'NPI') then 
				Messagebox('CONTACT YOUR SYSTEM ADMINISTRATOR', &	
		       'No Active Providers Exist on the Prov NPI Cross Reference Table for the linked Subset')
			else
				Messagebox('INFORMATION', &	
		       'No Active Providers Exist on the Provider Table for the linked Subset')
			end if
			 
		 End IF
		 cb_create.enabled = false
		 cb_remove.enabled = false
		 cb_split.enabled  = false
		 cb_close.default  = true
		 ST_ROW_COUNT.TEXT = ''
		 RETURN false
ElseIf integer(st_row_count.text) > 0 then
		 cb_create.enabled = true
		 cb_remove.enabled = true
		 cb_close.default  = true
End if

//Cannot use regular table type for revenue code tracking because 
//actually reading the revenue code subset table so need to use the
//table type for revenue code or will not find label on dictionary

if left(ddlb_track_type.text,2) = 'RV' then
	lv_dict_table_type = lv_prov_id_label_rev_tbl_type  
else
   lv_dict_table_type = in_subset_table_type[1]
end if   

lnv_labels = Create n_cst_labels
lnv_labels.of_SetDW( dw_1 )
lnv_labels.of_labels2( lv_dict_table_type )
Destroy lnv_labels
//	09/25/02	GaryR	SPR 3324d - End

return TRUE
end function

event open;//Script for W_Target_Subset_maintain - open (Override w_target_view)
//********************************************************************
//	08-31-98 NLG FS362 convert case to case_cntl
// 03-12-98 JGG STARS 4.0 - TS145 - Executable changes.
//					 wf_write_new_case never invoked, deleted.
// 01-20-98 NLG 4.0 Subset Redesign - sle_subset_id holds external subset id.
//							Must use nvo_subset_functions to determine internal subset id
//                   when accessing database
// 10-20-95 FNC Take out connects and disconnects
// 09-23-94 FNC Display Pin/Upin radio buttons for any case tracking by PV
// 07-08-94 FNC Add multi claim to creating targets. Read STARS_WIN_PARMS
//              to obtain subset table, target field and table type
// 06-16-94 FNC Add check for business type. Set element name based on
//              business type.
// 11-04-99 AJS Case Money allow user to choose track type
//	09/21/01	FDG	No updates can occur if the case is closed
//	11/13/01	GaryR	Track 2537d	Attempt to insert null into sys_cntl
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
// 10/29/02 JasonS Track 4055c Call ue_retrieve, not cb_retrieve
// 08/24/2005 Katie  Track 4449d - Removed reference to case_trk_type so that the window does not get a 
//				blank track type when being opened by case_folder for custom case types
// 12/17/05 JasonS Track 4552d - Disable pin/upin selection if not a provider track type
// 11/10/06 Katie SPR 4763 - Populate the Track By drop-down based on gv_npi_cntl.  
//				Duplicated EXEMPT logic for systems replacing PROV_ID with NPI.
//	02/21/07 Katie	SPR 4763 Fixed issue with enabling disabling ddlb_track_by
//	03/15/07	Katie SPR 4946 Fixed issue with populating the Subset ID/Link Name
//	03/16/07	Katie	SPR 4946 Disabled border on the link name box.
//	03/22/07	Katie	SPR 4946 Corrected the subset id vs subset name issue with the st_subset_id box.
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//********************************************************************

String 	lv_subset,lv_target,lv_case_cat, lv_sql_statement
Long 		lv_target_id
String 	lv_case_id,lv_case_spl,lv_case_ver, lv_case_prev_ver
Boolean 	lv_targets_exist
String  	lv_error,lv_style,lv_syntax
int	  	lv_result,lv_row,lv_dwrow
String 	lv_track_key,lv_track_type,lv_hold_track_key
Datetime lv_cntl_date
integer	li_rc 		
u_nvo_subset lnv_subset

Setpointer(Hourglass!)

//	Execute the open in w_master
Call	w_master::Open
this.of_set_sys_cntl_range(TRUE)

inv_subset_functions = create nvo_subset_functions

SETMICROHELP(w_main,'Opening Targets Screen')
in_from = gv_from
sle_case_id.text = trim(gv_active_case)
sle_target_id.text = trim(gv_case_target)

//inv_case	=	CREATE	n_cst_case				// FDG 09/21/01		// FDG 12/21/01

If sle_case_id.text = '' then
	Messagebox('EDIT','No active Case exists')
	cb_close.Postevent(clicked!)
	RETURN
End If

lv_case_id = left(gv_active_case,10)		
lv_case_spl = mid(gv_active_case,11,2)	
lv_case_ver = mid(gv_active_case,13,2)	

is_subset_id = gv_target_subset_id
istr_subset_ids.subset_id = is_subset_id
istr_subset_ids.subset_case_id = lv_case_id
istr_subset_ids.subset_case_spl = lv_case_spl
istr_subset_ids.subset_case_ver = lv_case_ver
inv_subset_functions.uf_set_structure(istr_subset_ids)
li_rc = inv_subset_functions.uf_retrieve_subset_name()
if li_rc = 1 then
	SetMicroHelp("Retrieving external subset id ...")
	istr_subset_ids = inv_subset_functions.uf_get_structure()
	is_subset_name = istr_subset_ids.subset_name
	st_subset_id.text = istr_subset_ids.subset_id
else
	//Unable to get subset name
	MessageBox("ERROR","Error retrieving external subset id.")
end if
lnv_subset.event ue_construct(is_subset_id)
sle_subset_id.text = lnv_subset.uf_get_link_name(lv_case_id, lv_case_spl, lv_case_ver)
//AJS 11/04/99

//Katie 08/24/2005 Track 4449d - Removed reference to case_trk_type so that the window does not get a 
//blank track type when being opened by case_folder for custom case types
String ls_track_type
Select case_type, case_disp_hold,case_business
		into :ls_track_type,:in_case_disp_hold,
			  :in_case_business
	from case_cntl
	where case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in open')
      end if         
		setmicrohelp(w_main,'Case Does Not Exist')
		cb_close.Postevent(clicked!)
		RETURN
Elseif stars2ca.sqlcode <> 0 then
		Errorbox(stars2ca,'Error Reading Case Control Table')
		cb_close.Postevent(clicked!)
		RETURN
End If
ddlb_track_type.SelectItem(ls_track_type,0)

//Coming in from View Folder ADD/SELECT unsure whether targets/track exist
//Either gv_case_subset or gv_case_target will have data, won't be in both
If gv_target_subset_id <> '' then	
	Select trgt_id,trgt_datetime,trgt_desc,trgt_type
		into :sle_target_id.text,:sle_datetime.text,:sle_description.text,:ls_track_type
		from target_cntl
		where subc_id  = Upper( :is_subset_id ) and
				case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
	Using stars2ca;
	If stars2ca.of_check_status() = 100 then
			Goto Create_targets
	Elseif stars2ca.sqlcode <> 0 then
		Errorbox(stars2ca,'Error Reading Target Table')
		cb_close.Postevent(clicked!)
		RETURN
	Else
		lv_targets_exist = true
		ddlb_track_type.SelectItem(ls_track_type,0)
	End If
Else
		setmicrohelp(w_main,'Subset Id not linked to Case')
		cb_close.Postevent(clicked!)
		RETURN
End If


If lv_targets_exist then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      errorbox(stars2ca,'Error performing commit in open')
      return
   end if                  
	triggerevent("ue_retrieve")	// JasonS 10/29/02 Track 4055c
	in_track_created = true
	cb_create.enabled = false
	cb_split.enabled  = false
	cb_remove.enabled = false
	sle_target_id.enabled = false
	sle_description.enabled = false
	cb_close.default = true
	THIS.TITLE = 'Case Target Subset Details'
	// FDG 09/21/01 - No updates can occur if the case is closed/deleted
	This.Event	ue_edit_case_closed()
	RETURN
End If

// *********************  CREATING TARGETS  *********************
//Coming in to Add Targets and Tracks they do not exist and 
//a subset has been linked 
Setmicrohelp(w_main,'Creating Datawindow Targets')
Create_Targets:
//Cannot create targets if case is being worked on by another user
If in_case_disp_hold = 'HOLD' then
	If gv_case_disp <> 'MYHOLD' then 
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in open')
      end if                       
		Messagebox('EDIT','Case is being actively worked on by another User, Please Try Again Later')
		cb_close.Postevent(clicked!)
		RETURN
	End If
Elseif gv_case_disp <> 'MYHOLD' then
	gv_case_disp = 'MYHOLD'
	Update Case_cntl	 
		set
			case_disp_hold	  = 'HOLD'
		Where		case_id	  = Upper( :lv_case_id ) AND
					case_spl   = Upper( :lv_case_spl ) AND
					case_ver   = Upper( :lv_case_ver )
	Using  stars2ca;
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error Writing Case with Hold Disposition')
		cb_close.Postevent(clicked!)
		RETURN
	End If

	lv_cntl_date = gnv_app.of_get_server_date_time()
	//	11/13/01	GaryR	Track 2537d - Begin
//	Insert into Sys_Cntl
//		(Cntl_id,Cntl_no,Cntl_date,Cntl_case)
//	  Values
//		(:gc_user_id,0,:lv_cntl_date,:gv_active_case)
//	Using  stars2ca;
	Insert into Sys_Cntl
		(Cntl_id,Cntl_no,Cntl_date,Cntl_case,cntl_text)
	  Values
		(:gc_user_id,0,:lv_cntl_date,:gv_active_case,' ')
	Using  stars2ca;
	//	11/13/01	GaryR	Track 2537d - End
	If stars2ca.of_check_status() <> 0  then
		Errorbox(stars2ca,'Error Writing System Control Table to Hold Case ')
		cb_close.Postevent(clicked!)
		RETURN
	End If
End If


sle_datetime.TEXT = inv_sys_cntl.of_get_default_date()
SETFOCUS(SLE_DESCRIPTION)
sle_description.displayonly = false					
//Disable the track_type dropdown listbox ajs 11-04-99
ddlb_track_type.borderstyle = StyleRaised!
ddlb_track_type.enabled = false


// Get Target ID from Sys Control
Select cntl_no into :lv_target_id 
		from sys_cntl
	  where cntl_id = 'TARGET'
using stars2ca;		
If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'ERROR Getting System Target Id')
	cb_close.Postevent(clicked!)
	RETURN
Else
	lv_target_id = lv_target_id + 1
	sle_target_id.text = string(lv_target_id)
	Update Sys_cntl
			set cntl_no = :lv_target_id
				 where cntl_id = 'TARGET'
	using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error Updating System Control Table')
		cb_close.Postevent(clicked!)
		RETURN
	End If
End If
Commit using stars2ca;

SELECT SUBC_SUB_TBL_TYPE, SUBC_TABLES        
    INTO :in_table_type, :in_subc_tables 
    FROM SUB_CNTL  
   WHERE ( SUB_CNTL.SUBC_ID = Upper( :is_subset_id ) ) 
USING STARS2CA  ;

If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'Error reading SUB CNTL table')
	cb_close.Postevent(clicked!)
	RETURN
End If
Commit using stars2ca;

if gv_npi_cntl = 0 then 
	ddlb_track_by.InsertItem('PROV_ID',1)
	ddlb_track_by.InsertItem('PROV_UPIN',2)
	ddlb_track_by.SelectItem('PROV_ID',1)
elseif gv_npi_cntl = 1 then 	
	ddlb_track_by.InsertItem('PROV_ID',1)
	ddlb_track_by.InsertItem('PROV_UPIN',2)
	ddlb_track_by.InsertItem('PROV_NPI',3)
	ddlb_track_by.SelectItem('PROV_ID',1)
end if

in_datawindow_created = wf_create_datawindow()
if in_datawindow_created = false then
	RETURN
end if 

CB_CREATE.DEFAULT = TRUE

//A Case can be split only once
If lv_case_spl <> '00' then
	cb_split.enabled = false
End IF

setsort(dw_1,'1A')
sort(dw_1)

lv_dwrow = integer(st_row_count.text)

For lv_row = 1 to lv_dwrow 
	lv_track_key = getitemstring(dw_1,lv_row,1)
   if lv_track_key = lv_hold_track_key then
       deleterow(dw_1,lv_row)
	    lv_dwrow = rowcount(dw_1)
       lv_row = lv_row - 1
       continue
   else
       lv_hold_track_key = lv_track_key
   end if
Next

st_row_count.text =  string(rowcount(dw_1))
//AJS 11/04/99
If left(ddlb_track_type.text,2) = 'PV' then
	For lv_row = 1 to integer(st_row_count.text)
		lv_track_key = getitemstring(dw_1,lv_row,2)
	 	If trim(lv_track_key) = ''  or lv_track_key = 'EXEMPT' then
			Messagebox('EDIT','UPIN~'s have values of SPACES/EXEMPT, Target will be Created by PIN')
			if (ddlb_track_by.finditem( 'PROV_ID',1) > -1) then 
				ddlb_track_by.SelectItem('PROV_ID',1)
			else
				ddlb_track_by.SelectItem('PROV_NPI',1)
			end if
			triggerevent(ddlb_track_by,selectionchanged!)
			ddlb_track_by.DeleteItem(ddlb_track_by.FindItem('PROV_UPIN',1))
			Exit
		End If
	Next
End If

// FDG 09/21/01 - No updates can occur if the case is closed/deleted
This.Event	ue_edit_case_closed()

// Disable Pin/Upin selection if this is not a provider track type
If left(ddlb_track_type.text,2) <> 'PV' then
	ddlb_track_by.enabled = false
else 
	ddlb_track_by.enabled = true
End IF


setpointer(arrow!)
setmicrohelp(w_main,'Ready')
end event

event close;call super::close;//****************************************************************
//	10-20-95	FNC	Take out connects and disconnects
//	08-31-98	NLG	FS362 convert case to case_cntl
//	01/17/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//09/21/01	FDG	Stars 4.8.	Destroy inv_case
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//****************************************************************
String lv_case_id,lv_case_spl,lv_case_ver, ls_empty

Integer	li_rc

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

If	THIS.TITLE = 'Case Target Subset Create' then			
	Setpointer(hourglass!)	
	lv_case_id = left(sle_case_id.text,10)
	lv_case_spl = mid(sle_case_id.text,11,2)
	lv_case_ver = mid(sle_case_id.text,13,2)
	If gv_case_disp = 'MYHOLD' then
		If not isvalid(w_case_maint) then

			Delete from Sys_cntl
				where cntl_id = Upper( :gc_user_id ) and
						cntl_case = Upper( :sle_case_id.text )
			Using Stars2ca;
			If Stars2ca.of_check_status() <> 0 then
				Errorbox(Stars2ca,'Unable to Release Hold Lock on Case, Call Systems Administrator')
			End If

			Update Case_cntl
				set case_disp_hold = :ls_empty	//	01/17/01	GaryR	Stars 4.7 DataBase Port
				where case_id = Upper( :lv_case_id ) and
						case_spl = Upper( :lv_case_spl ) and
						case_ver = Upper( :lv_case_ver )
			Using Stars2ca;
			GV_CASE_DISP = ''
			If Stars2ca.of_check_status() <> 0 then
				Errorbox(Stars2ca,'Unable to Release Hold Lock on Case, Call Systems Administrator')
			Else 
            Commit using stars2ca;
            if stars2ca.of_check_status() <> 0 then  
               messagebox('ERROR','Error performing commit in close')
            end if 
			End If
		End IF
	End If
End If

if isvalid(inv_subset_functions) then
	destroy inv_subset_functions
end if

// FDG 09/21/01
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//IF	IsValid (inv_case)		THEN
//	destroy	inv_case
//END IF

end event

on w_target_subset_maintain.create
int iCurrent
call super::create
this.cb_create=create cb_create
this.cb_remove=create cb_remove
this.cb_split=create cb_split
this.ddlb_track_by=create ddlb_track_by
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_create
this.Control[iCurrent+2]=this.cb_remove
this.Control[iCurrent+3]=this.cb_split
this.Control[iCurrent+4]=this.ddlb_track_by
this.Control[iCurrent+5]=this.st_5
end on

on w_target_subset_maintain.destroy
call super::destroy
destroy(this.cb_create)
destroy(this.cb_remove)
destroy(this.cb_split)
destroy(this.ddlb_track_by)
destroy(this.st_5)
end on

type cb_retrieve from w_target_view`cb_retrieve within w_target_subset_maintain
end type

type sle_case_id from w_target_view`sle_case_id within w_target_subset_maintain
integer x = 393
integer height = 80
string text = "None"
end type

type st_subset_id from w_target_view`st_subset_id within w_target_subset_maintain
integer x = 1426
integer y = 236
integer height = 80
end type

type st_3 from w_target_view`st_3 within w_target_subset_maintain
integer y = 236
end type

type st_datetime from w_target_view`st_datetime within w_target_subset_maintain
integer y = 128
end type

type sle_datetime from w_target_view`sle_datetime within w_target_subset_maintain
integer x = 1426
integer y = 128
integer width = 521
integer height = 80
end type

type sle_description from w_target_view`sle_description within w_target_subset_maintain
integer x = 393
integer y = 344
integer width = 2336
integer taborder = 50
long backcolor = 16777215
boolean border = true
integer limit = 80
borderstyle borderstyle = stylelowered!
end type

type st_desc from w_target_view`st_desc within w_target_subset_maintain
integer x = 23
integer y = 344
end type

type st_row_count from w_target_view`st_row_count within w_target_subset_maintain
integer height = 72
end type

type cb_stop from w_target_view`cb_stop within w_target_subset_maintain
integer x = 645
end type

type cb_close from w_target_view`cb_close within w_target_subset_maintain
integer x = 2606
integer taborder = 120
end type

event cb_close::clicked;//****************************************************************************
//* Maintenance Log:
// ajs 01-12-99 anne-s  4.1 TS2016c correct return to case folder
//****************************************************************************
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
//gv_case_active = sle_case_id.text	//ajs 4.0 03-11-98 TS145-fix globals
gv_active_case = sle_case_id.text	//ajs 4.0 03-11-98 TS145-fix globals
If in_track_created = false then
	If isvalid(w_case_folder_view) then
		close(parent)
//		triggerevent(w_case_folder_view.cb_remove,clicked!)	//ajs 4.1 01-12-99 
		RETURN
	End IF
End IF

Close(parent)
end event

type st_link_name from w_target_view`st_link_name within w_target_subset_maintain
integer x = 23
integer y = 236
end type

type st_4 from w_target_view`st_4 within w_target_subset_maintain
end type

type cb_list_targets from w_target_view`cb_list_targets within w_target_subset_maintain
boolean visible = false
integer x = 183
integer taborder = 0
end type

on cb_list_targets::clicked;setpointer (hourglass!)
SETMICROHELP(W_MAIN,'')
triggerevent(cb_close,clicked!)
openSheet (w_target_list,MDI_Main_Frame,Help_Menu_Position,Layered!)

end on

type st_2 from w_target_view`st_2 within w_target_subset_maintain
integer x = 23
integer y = 128
end type

type sle_subset_id from w_target_view`sle_subset_id within w_target_subset_maintain
integer x = 393
integer y = 236
integer height = 80
integer weight = 700
long backcolor = 67108864
boolean border = false
boolean displayonly = true
end type

type cb_notes from w_target_view`cb_notes within w_target_subset_maintain
integer x = 2226
integer taborder = 110
end type

type dw_1 from w_target_view`dw_1 within w_target_subset_maintain
integer x = 41
integer y = 488
integer width = 3099
integer height = 1328
integer taborder = 70
boolean hscrollbar = false
boolean hsplitscroll = false
end type

event dw_1::retrievestart;call super::retrievestart;Return 2

end event

on dw_1::rowfocuschanged;// This script from ancestor should not execute for this window
end on

event dw_1::clicked;call super::clicked;int lv_cur_row
boolean lv_result

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
lv_cur_row = row

If lv_cur_row > 0 Then
  If dw_1.IsSelected(lv_cur_row) = True Then
	 dw_1.selectrow(lv_cur_row,FALSE)
    in_target_key = ''
	 in_target_status = ''
    in_highlighted_rows = in_highlighted_rows - 1
  Else
    dw_1.selectrow(lv_cur_row,TRUE)
    in_highlighted_rows = in_highlighted_rows + 1
    in_target_status = getitemstring(dw_1,lv_cur_row,2)
	 If in_target_status = 'R' then
		in_target_key = ''
		in_target_status = ''
		RETURN
	 End If
  End If
End If

If lv_cur_row < 0 then
	setmicrohelp(w_main,'Select a Valid Row')
	RETURN
End IF

setpointer(arrow!)
end event

on dw_1::doubleclicked;//This script from ancestor should not execute here
end on

type sle_target_id from w_target_view`sle_target_id within w_target_subset_maintain
integer x = 1426
integer width = 521
integer height = 80
integer taborder = 40
integer weight = 700
long textcolor = 0
long backcolor = 67108864
boolean border = false
textcase textcase = upper!
boolean displayonly = true
end type

type st_1 from w_target_view`st_1 within w_target_subset_maintain
integer x = 23
end type

type ddlb_track_type from w_target_view`ddlb_track_type within w_target_subset_maintain
integer x = 393
integer y = 128
boolean enabled = true
string text = "w"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type gb_main from w_target_view`gb_main within w_target_subset_maintain
integer width = 2926
end type

type cb_create from u_cb within w_target_subset_maintain
string accessiblename = "Create Track"
string accessibledescription = "Create Track"
integer x = 1399
integer y = 1848
integer width = 407
integer height = 108
integer taborder = 80
integer textsize = -16
string text = "Create &Track"
end type

event clicked;//*********************************************************************
//	Object Type:	CommandButton
//	Object Name:	w_target_subset_maintain.cb_create
//	Event Name:		Clicked
//*********************************************************************
//	08/07/02	GaryR	Track 3240d	Default target description if none entered
//	01/25/02	FDG	Track 2731d. When setting lv_track_data.track_name from
//						the d/w, it could be null.
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//	10/11/01	FDG	Stars 4.8.1.	Insert case_log entries for each activity
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	03/15/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	02/20/01	FDG	Stars 4.7 - remove SQLCMD
//	01/17/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	12/05/00	FDG 	Stars 4.7.  Make error checking DBMS-independent.
//					 	Also, include rte_ind when inserting into table notes.
// 03/21/00	FNC 	Track 2159 Stardev. Return code of 100 indicates that
//					 	there are duplicates.
// 11-04-99 AJS 	Case Money allow user to choose track type
// 01-12-99 AJS	FS2016c 4.1 Correct messagebox.
// 08-31-98 NLG 	FS362 convert case to case_cntl
// 01-20-98 NLG 	1. External subset ID will be displayed, but internal subset
//					 	ID will be used in database access
// 10-31-96 FNC 	Check to make sure track type is BE before if statement
//					 	that checks if ENROLLEE view contains a join.
// 05/14/96 FNC 	If ENROLLEE view contains a join do not retrieve the 
//              	patient name.
//
//	04-03-96 FDG 	Prob 205 - When inserting to TARGET, getting a 
//					 	"TRGT_NAME does not allow null values" error.  Changed
//					 	the loop from dw_1 to ensure that all rows (and no
//					 	additional rows) are processed in dw_1.
// 10-20-95 FNC 	Take out connects and disconnects
// 06-29-95 FNC 	Take out edit requiring user to click on a target in 
//              	order to track if track type <> PV
// 06-20-95 FNC 	Set the proc code type for Procedure Code tracking
//              	Proc Code type varies depending on claim type. It is
//              	retrieved in wf_create_data_window in the open script
// 11-11-94 FNC 	Get track name for all types of tracking
// 07-12-94 FNC 	Change to accomodate mulitiple claim types
// 01/23/03 JasonS Track 3302d decrement case_cnt for user stats
// 03/14/03 JasonS Track 3302d added an _ to table name
// 03/18/03 JasonS Track 2945d removed call to make the refresh button invisble
//	02/21/07	Katie	SPR 4763 Ensured space being passed for PROV_ID_TYPE for NON-PV Tracks
//*********************************************************************

string  lv_note_id
Long	  lv_next_note,lv_row,	ll_rowcount,ll_row
String  lv_target_id,lv_target_alert, lv_case_id,lv_case_spl,lv_case_ver
string ls_case_id, ls_case_spl, ls_case_ver, ls_empty
Integer lv_result
Boolean create_link,lv_select
Datetime lv_datetime
SX_track_data lv_track_data
string ls_link_status = 'A'	
integer li_rc				
string ls_tbl_type
integer li_len

date ld_userstatsdate	// JasonS 1/23/03 Track 3302d

setpointer(hourglass!)

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

If long(st_row_count.text) <= 0 then
	Messagebox('EDIT','No Targets Exist to Create Tracking')
	RETURN
End If
lv_row = Getselectedrow(dw_1,0)

If left(ddlb_track_type.text,2) = 'PV' then
	If ddlb_track_by.SelectedLength() = 0 then
		Messagebox('EDIT','Must Select Track By of PIN, UPIN or NPI')   
		RETURN
	End If
End If
setmicrohelp(w_main,'Creating Tracking')	

//Only hilited rows go through Dupe Check
gv_result = 0
gv_case_dup_ids = ''
gv_active_case = Trim (sle_case_id.text)			// FDG 04/16/01
lv_case_id = left(gv_active_case,10)	
lv_case_spl = mid(gv_active_case,11,2)	
lv_case_ver = mid(gv_active_case,13,2)	

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 - end


lv_datetime = gnv_app.of_get_server_date_time()
If trim(sle_subset_id.text) <> '' then    
	istr_subset_ids.subset_name = trim(sle_subset_id.text)
	istr_subset_ids.subset_case_id = lv_case_id
	istr_subset_ids.subset_case_spl = lv_case_spl
	istr_subset_ids.subset_case_ver = lv_case_ver
	inv_subset_functions.uf_set_structure(istr_subset_ids)
	SetMicroHelp("Retrieving internal subset id ...")
	li_rc = inv_subset_functions.uf_retrieve_subset_id()
	if li_rc = 1 then
		istr_subset_ids = inv_subset_functions.uf_get_structure()
		is_subset_id = istr_subset_ids.subset_id
	else
		MessageBox("ERROR","Unable to retrieve internal subset id. ")
		return
	end if

	
	Select count(*) into :lv_result
		from Target_cntl 
		where case_id = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and 
				case_ver = Upper( :lv_case_ver ) and
				subc_id  = Upper( :is_subset_id )	
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error Reading Target Control')
		RETURN 
	Elseif lv_result > 0 then
          COMMIT using stars2ca;
          if stars2ca.of_check_status() <> 0 then
             messagebox('ERROR','Error performing commit in cb_create')
          end if                  
			 Messagebox('EDIT','Targets have already been created for this Case')
			 RETURN
	End If
End IF     

ll_rowcount	=	dw_1.RowCount()		

For lv_row = 1 to ll_rowcount					
	in_target_status = getitemstring(dw_1,lv_row,2)
	in_target_key = getitemstring(dw_1,lv_row,1)
	lv_select = dw_1.IsSelected(lv_row)
	If lv_select = true or &
		(left(ddlb_track_type.text,2) = 'PV' and in_target_status <> 'R') then
		lv_result = fx_dup_check(in_target_key,left(ddlb_track_type.text,2))
		If lv_result = 0 then			// FNC 03/21/00
  	    		gv_case_dup_ids = gv_case_dup_ids + ',~'' + in_target_key + '~''
		ElseIf lv_result = -1  then
				STARS2CA.of_rollback()																// FDG 02/20/01
				RETURN
		Else
				Continue
		End IF
	Else
			Continue
	End IF
Next

//Dupes Exists for the tracks
If gv_case_dup_ids <> '' then
	gv_case_dup_ids = mid(gv_case_dup_ids,2)
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      errorbox(stars2ca,'Error performing commit in cb_create')
      return
   end if  
	gv_case_target = sle_target_id.text 
	openwithparm(w_case_dup_check,left(ddlb_track_type.text,2))
//Result 100 - delete Case
	If gv_result = 100 then
		If fx_delete_case('N') = -1 then
	   	Messagebox('EDIT','Error Deleting Case')
			cb_close.default = true
   		RETURN
		Else
			// JasonS 1/23/03 Begin - Track 3302d
			ld_userstatsdate = date(left(string(today()),2) + '/01/' + right(string(today()), 2))
			update User_Stats			// JasonS 03/14/03 Track 3302d
			set case_cnt = case_cnt - 1
			where stats_date = :ld_userstatsdate
			using stars2ca;
			stars2ca.of_commit()
			// JasonS 1/23/03 End - Track 3302d
			
	   	setmicrohelp(w_main,'Case Deleted')
			gv_case_disp = ''
			Close(parent)
			If isvalid(w_case_maint) then
				w_case_maint.in_track_exists = true
				triggerevent(w_case_maint.cb_close,clicked!)  
			End If
			If isvalid(w_case_folder_view) then
				w_case_folder_view.in_tracks_required = false
				w_case_folder_view.in_from = ''
				triggerevent(w_case_folder_view.cb_close,clicked!) 
			End If
			gv_active_case = ''
			RETURN
		End If

// Result 0 - Returned from Dupe Check without any positive action
	Elseif gv_result = 0 then
				sle_target_id.setfocus()
				cb_remove.default = true
				RETURN
// Result 102 - Save Tracks override dupes, 999 - save tracks w/close Status
	Else
	End If
End IF

//Insert into target Cntl
lv_target_id = sle_target_id.text
string lv_track_type
lv_track_type = left(ddlb_track_type.text,2)

//	01/17/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( is_subset_id )				= "" THEN is_subset_id				= ls_empty

//	08/07/02	GaryR	Track 3240d - Begin
//IF Trim( sle_description.text )	= "" THEN sle_description.text	= ls_empty
IF IsNull( sle_description.text ) OR Trim( sle_description.text )	= "" THEN
	sle_description.text = "Target saved on " + &
						String( lv_datetime, "m/d/yyyy hh:mm:ss" ) + " by " + gc_user_id
END IF
//	08/07/02	GaryR	Track 3240d - End

Insert into Target_cntl 
	(case_id,case_spl,case_ver,
	 dept_id,user_id,trgt_id,
	 trgt_type,subc_id,
	 trgt_datetime,trgt_desc)
	Values
	 (:lv_case_id,:lv_case_spl,:lv_case_ver,
	  :gc_user_dept,:gc_user_id,:lv_target_id,
	  :lv_track_type,:is_subset_id,
	  :lv_datetime,:sle_description.text)
Using Stars2ca;
If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'Error Inserting into Target Control')
	RETURN 
End If

// FDG 10/11/01 begin
String	ls_message

ls_message	=	"Target "	+	lv_target_id	+	" added to case."

n_cst_case		lnv_case					// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case		// FDG 12/21/01

li_rc			=	lnv_case.uf_audit_log ( lv_case_id, lv_case_spl, lv_Case_ver, ls_message )

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for target '	+	lv_target_id	+	&
					'.  Case: ' + lv_case_id + lv_case_spl + lv_case_ver + '. Script: '		+	&
					'w_target_subset_maintain.cb_create.clicked')
	IF	IsValid (lnv_case)	THEN	Destroy lnv_case			// FDG 12/21/01
	Return
END IF
// FDG 10/11/01 end

lv_track_data.track_type = left(ddlb_track_type.text,2)
ll_rowcount	=	dw_1.RowCount()

For lv_row = 1 to ll_rowcount									// FDG 04/03/96
	in_target_key = getitemstring(dw_1,lv_row,1)
	lv_track_data.track_key = in_target_key
	in_target_status = getitemstring(dw_1,lv_row,2)

   if left(ddlb_track_type.text,2) = 'PC' then   //06-20-95 FNC Start
      lv_track_data.proc_track_code = getitemstring(dw_1,lv_row,4)
   else
      lv_track_data.proc_track_code = left(ddlb_track_type.text,2)
   end if                               //06-20-95 FNC End

	if left(ddlb_track_type.text,2) = 'BE' then			//10-31-96 FNC
		if ii_xref = 0 then 							//05-14-96 FNC Start
		   lv_track_data.track_name = getitemstring(dw_1,lv_row,3)
		else
			lv_track_data.track_name = ' '
		end if											//05-14-96 FNC End
	else													//10-31-96 FNC
	   lv_track_data.track_name = getitemstring(dw_1,lv_row,3)	//10-31-96 FNC
	end if												//10-31-96 FNC 					
			
	If in_target_status = 'R' then

		ls_tbl_type = gnv_dict.event ue_get_table_type	("TARGET")
		li_len	   = gnv_dict.event ue_get_data_len		(ls_tbl_type, "TRGT_NAME")
	
		IF li_len = -1 THEN 
			li_len = 32
		END IF
	
		lv_track_data.track_name = Left( lv_track_data.track_name, li_len )
		//	01/17/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
		// 01/25/02 FDG - Check for nulls
		IF Trim( lv_track_data.track_name ) = ""	&
		OR	IsNull( lv_track_data.track_name )		THEN 
			lv_track_data.track_name = ls_empty
		END IF
		
		Insert into Target
			(case_id,case_spl,case_ver,
			 trgt_id,trgt_key,
			 trgt_status,trgt_name)
			Values
			(:lv_case_id,:lv_case_spl,:lv_case_ver,
			 :lv_target_id,:lv_track_data.track_key,
			 :in_target_status,:lv_track_data.track_name)
		Using Stars2ca;
		If stars2ca.of_check_status() <> 0 then
			Errorbox(stars2ca,'Error Inserting Removed Target ' + in_target_key)
			IF	IsValid (lnv_case)	THEN	Destroy lnv_case			// FDG 12/21/01
			RETURN
		Else 	
			Continue
		End If
	End If
	lv_select = dw_1.IsSelected(lv_row)
	if ( left(ddlb_track_type.text,2) = 'PV') then 
		lv_track_data.prov_id_type = ddlb_track_by.text
	else 
		lv_track_data.prov_id_type = ' '
	end if
	If left(ddlb_track_type.text,2) = 'PV' then
		lv_target_alert = 'Y'
		If lv_track_data.prov_id_type = 'PROV_UPIN' then
			lv_track_data.track_number = in_target_key
		Else
			lv_track_data.track_number = ''
		End IF
	ElseIf lv_select = true then
		lv_target_alert = 'Y'
	Else
		lv_target_alert = 'N'
	End IF
	lv_result = fx_Insert_track(lv_track_data,in_target_status, &
										 lv_target_id,lv_target_alert)
   If lv_result = -1 then
		IF	IsValid (lnv_case)	THEN	Destroy lnv_case			// FDG 12/21/01
	   RETURN
	End If
Next

//Write notes
in_targets_removed = mid(trim(in_targets_removed),2)
If in_targets_removed <> '' then
	Select cntl_no into :lv_next_note
		from sys_cntl
	  where cntl_id = 'NOTE'
	using stars2ca;		
	If stars2ca.of_check_status() <> 0 then
		Messagebox('EDIT','Tracking Created No notes Written for Removed Targets')
	Else
		lv_next_note = lv_next_note + 1
		lv_note_id = string(lv_next_note)
		Update Sys_cntl
				set cntl_no = :lv_next_note
			 where cntl_id = 'NOTE'	
		using stars2ca;
		If stars2ca.of_check_status() <> 0 then
			Messagebox('EDIT','Tracking Created No notes Written for Removed Targets')
		ELSE
			in_targets_removed = in_targets_removed + &
			 ' HAVE BEEN REMOVED FROM TRACKING SUBSET ' + SLE_SUBSET_ID.TEXT
			Insert into notes
				(dept_id,user_id,note_rel_type,
				 note_rel_id,note_id,
				 note_datetime,note_text,note_sub_type,rte_ind, note_desc)
				VALUES
				(:Gc_user_dept,:gc_user_id,'CA',
				 :gv_active_case,:lv_note_id,
				 :lv_datetime,:in_targets_removed,'RM', ' ', ' ')
			Using stars2ca;	
			If stars2ca.of_check_status() <> 0 then
				Messagebox('EDIT','Tracking Created No notes Written for Removed Targets')
			End If
			// FDG 10/11/01 begin
			ls_message	=	"Note "	+	lv_note_id	+	" added to case."
			li_rc			=	lnv_case.uf_audit_log ( gv_active_case, ls_message )		// FDG 12/21/01
			IF	li_rc		<	0		THEN
				Stars2ca.of_rollback()
				MessageBox ('Database Error', 'Could not insert case log for note '	+	lv_note_id	+	&
								'.  Case: ' + gv_active_case + '. Script: '		+	&
								'w_target_subset_maintain.cb_create.clicked')
				IF	IsValid (lnv_case)	THEN	Destroy lnv_case			// FDG 12/21/01
				Return
			END IF
			// FDG 10/11/01 end
		End IF
	End If
End IF

IF	IsValid (lnv_case)	THEN	Destroy lnv_case			// FDG 12/21/01

//Following Code Will be Used in the script of w_target_maintain 
//which is inherited from this window.  Need to link the target Id 
//to the case will be coming into the window with a gv_from = 'MENU'
//If in_from = 'MENU' then	//AJS 07-16-98 TESTING TARGET FOR SUBSETS

//	01/17/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
//	01/25/02 FDG - check for nulls
IF Trim( sle_description.text ) = ""	&
OR	IsNull( sle_description.text )	THEN 
	sle_description.text = ls_empty
END IF

	Insert into Case_link 
		(case_id,case_spl,case_ver,
		 link_type,link_key,link_name,
		 link_desc,user_id,
		 link_date,link_status)
		Values
		(:lv_case_id,:lv_case_spl,:lv_case_ver,
		 'TGT',:sle_target_id.text,Upper(:sle_target_id.text),	//	03/15/01	GaryR	Stars 4.7 DataBase Port
		 :sle_description.text,:gc_user_id,
		 :lv_datetime,:ls_link_status)
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		// FDG 12/05/00 - Make error checking DBMS-independent
		//If stars2ca.sqldbcode = gv_sql_dup or stars2ca.sqldbcode = gv_sql_dup2 then
		IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
			//sqlcmd('ROLLBACK',stars2ca,'',1)
			STARS2CA.of_rollback()																// FDG 02/20/01
			setfocus(sle_target_id)
			cb_close.default = true
			Messagebox('EDIT','Target Id has been Linked to this Case')
			RETURN
		Else
			Errorbox(stars2ca,'Error Writing Case Link')
			RETURN
		End If
	End If
in_track_created = true

//Save button on the Dupe Check screen returns 900 when there are no open
//tracks for the case.  In such an instance the case and leads will be closed
If gv_result = 900 then
	fx_close_case()
End IF

Commit using stars2ca;

setmicrohelp(w_main,'Target and Tracking Entries Created')


If gv_case_disp = 'MYHOLD' then
	If isvalid(w_case_maint) THEN
		ll_row = w_case_maint.tab_case.tabpage_general.dw_general.GetRow()
		ls_case_id = w_case_maint.tab_case.tabpage_general.dw_general.object.case_id[ll_row]
		ls_case_spl = w_case_maint.tab_case.tabpage_general.dw_general.object.case_spl[ll_row]
		ls_case_ver = w_case_maint.tab_case.tabpage_general.dw_general.object.case_ver[ll_row]
		IF ls_case_id + ls_case_spl + ls_case_ver = sle_case_id.text then
          COMMIT using stars2ca;
          if stars2ca.of_check_status() <> 0 then
             errorbox(stars2ca,'Error performing commit in cb_create')
             return
          end if  
		END IF
	Else
		Delete from Sys_Cntl
			where cntl_id = Upper( :gc_user_id ) and 
					cntl_case = Upper( :sle_case_id.text )
		Using Stars2ca;
		If stars2ca.of_check_status() <> 0 then
			Messagebox('ERROR','Unable to Release Hold on the Case from the System Control Table')
		End If
		//08-31-98 NLG FS362 convert case to case_cntl
		Update Case_cntl
				set case_disp_hold = :ls_empty	//	01/17/01	GaryR	Stars 4.7 DataBase Port
				where case_id = Upper( :lv_case_id ) and
						case_spl = Upper( :lv_case_spl ) and
						case_ver = Upper( :lv_case_ver )
		Using Stars2ca;
		gv_case_disp = ''
		If Stars2ca.of_check_status() <> 0 then
			Errorbox(Stars2ca,'Unable to Release Hold Lock on Case, Call Systems Administrator')
		Else 
          COMMIT using stars2ca;
          if stars2ca.of_check_status() <> 0 then
             errorbox(stars2ca,'Error performing commit in cb_create')
             return
          end if                          //   10-20-95 FNC End
		End If
	End If
Else 
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      errorbox(stars2ca,'Error performing commit in cb_create')
      return
   end if                //  10-20-95 FNC End
End If

If isvalid(w_case_folder_view) then
	w_case_folder_view.in_tracks_required = false
	w_case_folder_view.TriggerEvent(open!)
End If
If isvalid(w_case_maint) then
	w_case_maint.in_track_exists = true
End If

close(parent)
end event

type cb_remove from u_cb within w_target_subset_maintain
string accessiblename = "Remove "
string accessibledescription = "Remove "
integer x = 1842
integer y = 1848
integer width = 338
integer height = 108
integer taborder = 90
integer textsize = -16
string text = "&Remove "
end type

event clicked;//Script for W_Target_Subset_Maintain - cb_remove
//********************************************************************
// 09-23-98 FNC Require Pin/Upin radio buttons for any case tracking by PV
// 01-12-99 AJS FS2016c 4.1 Correct messagebox
// 11-04-99 AJS Case Money Allow user to choose track type
//********************************************************************

integer lv_rc,lv_row,lv_dw_row_cnt,lv_row_nbr
string lv_target_status,lv_target_key,lv_targets_removed

//  Force a note for every removed target id
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')


if left(ddlb_track_type.text,2) = 'PV' then
	If ddlb_track_by.SelectedLength() = 0 then
		Messagebox('EDIT','Must Select Track By of PIN or UPIN')	// 01-12-99 AJS 
		RETURN
	End If
End If
//09-23-94 FNC

lv_dw_row_cnt = dw_1.RowCount()
If in_highlighted_rows = 0 then
   Messagebox('EDIT','Must Select a Target Key to be Removed from Tracking')
   Setfocus(dw_1)
   Return
Else
   If in_highlighted_rows = 1 Then
     If in_target_status = 'A' then
       lv_rc = Messagebox('CONFIRM',in_target_key + ' Will be Removed from Tracking',Question!,YesNo!,2)
       If lv_rc = 2 Then
           Return
       End If
       setitem(dw_1,getrow(dw_1),2,'R')
       selectrow(dw_1,0,False)
       in_target_status = 'R'
       in_targets_removed = in_targets_removed + ',' + in_target_key
     Else
       setmicrohelp(w_main,'Target has already been Removed')
       RETURN
     End If
   Else
	   lv_rc = Messagebox('EDIT','All highlighted rows will be removed from Tracking.  Do you wish to continue?',Question!,YesNo!,2)
 	   If lv_rc = 2 then
	      RETURN 
	    End If

	   Setpointer(Hourglass!)
	   For lv_row_nbr = lv_dw_row_cnt to 1 Step -1
 	    If dw_1.IsSelected(lv_row_nbr) = True Then
  	     lv_target_key = dw_1.GetItemString(lv_row_nbr,1)    
  	     lv_target_status = dw_1.GetItemString(lv_row_nbr,2)
 	      If lv_target_status = 'A' then
   	      Setmicrohelp(lv_target_key + ' Will be Removed from Tracking')
   	      lv_targets_removed = lv_targets_removed + ',' + lv_target_key 
   	      lv_target_status = 'R'
   	      setitem(dw_1,lv_row_nbr,2,'R')
    	     setmicrohelp(w_main,'Target ' + lv_target_key + ' is currently being removed from tracking.') 
	       Else
	         setmicrohelp(w_main,'Target has already been Removed')
	         continue 
	       End If
	     End If
      Next
   End If
End If

dw_1.SelectRow(0,FALSE)
setmicrohelp(w_main,'Ready')

end event

type cb_split from u_cb within w_target_subset_maintain
boolean visible = false
string accessiblename = "Split"
string accessibledescription = "Split"
integer x = 1280
integer y = 1448
integer width = 393
integer height = 108
integer taborder = 130
integer textsize = -16
boolean enabled = false
string text = "&Split"
end type

event clicked;////Script for W_target_subset_maint - cb_split
////This script is also inherited by window w_target_maintain
//
////Split Creates a Separate Record for each line in the dw.  Each additional line with status 'A' 
////creates a  new case, case log, one track entry for the line, targets 
////will be written for each case for all the keys in the dw only one
////target will have status 'A', rest will be 'R', Link entries will be 
////created for each additional line the same as the original case link
////
////********************************************************************
//// 10-20-95 FNC Take out connects and disconnects
//// 09-23-04 FNC Require Pin/Upin radio buttons for any case tracking 
////					 by PV
////	05-03-96	FDG Prob 131 - Do not allow the splitting of an already
////					 split case.
////********************************************************************
//
//String  lv_target_id,lv_target_alert
//String  lv_case_id,lv_case_spl,lv_case_ver
//String  ls_case_id,ls_case_spl,ls_case_ver			// FDG 05/03/96
//Integer lv_case_row,lv_screen_row,lv_return,lv_count,index
//string  lv_track_type,lv_target_status
//Datetime lv_datetime
//String  lv_old_case
//String  lv_note_id
//Long    lv_next_note,lv_len
//sx_track_data lv_track_data
//
//setpointer(hourglass!)
//setmicrohelp(w_main,'Splitting the Case')
//
//gv_case_active = sle_case_id.text
//lv_old_case   = gv_case_active
//lv_track_type = sle_track_type.text
//lv_track_data.track_type = sle_track_type.text
//lv_target_id  = sle_target_id.text
//lv_datetime = datetime(today(),now())
//
//ls_case_id	=	left(gv_case_active,10)				// FDG 05/03/96
//ls_case_spl	=	mid(gv_case_active,11,2)			// FDG 05/03/96
//ls_case_ver	=	mid(gv_case_active,13,2)			// FDG 05/03/96
//
//	//	FDG 05/03/96 - Add edit to prevent splitting of already split cases
//IF	ls_case_spl	<>	'00'		THEN
//	Messagebox('EDIT','You cannot split an already split case.')
//	RETURN
//END IF	
//
//If integer(st_row_count.text) <= 0 then
//	Messagebox('EDIT','No Targets Exist to Split Tracking')
//	RETURN
//elseif integer(st_row_count.text) > 25 then
//	For index = 1 to integer(st_row_count.text)
//		lv_target_status = getitemstring(dw_1,index,2)
//		If lv_target_status <> 'R' Then
//			lv_count = lv_count + 1
//		End If
//	Next
//	If lv_count > 25 Then
//		Messagebox('EDIT','Targets > 25 Must Further Subset the Subset')
//		RETURN
//	End If
//End If
// 
////09-23-94 FNC Start
////If sle_track_type.text = 'PV' and in_case_business = 'MB' then
////	If rb_UPIN.checked = False and rb_pin.checked = false then
////		Messagebox('EDIT','Must Select Target Type of PIN or UPIN')
////		RETURN
////	End If
////End If
//
//If sle_track_type.text = 'PV' then
//	If rb_UPIN.checked = False and rb_pin.checked = false then
//		Messagebox('EDIT','Must Select Target Type of PIN or UPIN')
//		RETURN
//	End If
//End If
////09-23-94 FNC End
//
//If Messagebox('CONFIRMATION','Each of the Targets Will be Split into Individual Cases.  Would you like to Proceed?',Question!,YesNo!,2) = 2 then
//	RETURN
//End IF
//
//selectrow(dw_1,0,false)
//
////If Current Case is a refer then it cannot have REMOVED Targets
//If mid(sle_case_id.text,11,2) <> '00' then
//  For lv_screen_row = 1 to integer(st_row_count.text)
//	If getitemstring(dw_1,lv_screen_row,2) = 'R' then
//		selectrow(dw_1,lv_screen_row,true)
//		Messagebox('EDIT','Cannot Split, Tracks have Status ~'R~'' &
//				+ ' Must Narrow down the Subset')
//		cb_close.default = true
//		RETURN
//	End IF
//  Next
//End IF
//
//Setmicrohelp(w_main,'Started to Create Split Cases for Active Status')
////Sqlcmd('CONNECT',Stars2ca,'',2)
//ole_meter.visible = true
//ole_meter.object.value=0
//For lv_screen_row = 1 to integer(st_row_count.text)
//   in_target_status = getitemstring(dw_1,lv_screen_row,2)
//	If in_target_status = 'R' then
//		Continue
//	End IF
//	lv_case_spl = mid(gv_case_active,11,2)
//	If  lv_case_spl = '00' then
//		lv_return = fx_rewrite_case00_case01(lv_target_id)
//	Else
//		lv_return =	fx_write_new_case(lv_target_id)
//	End IF
//	If lv_return = -1 then
//		RETURN
//	End IF
//	lv_case_id = left(gv_case_active,10)
//	lv_case_spl = mid(gv_case_active,11,2)
//	lv_case_ver = mid(gv_case_active,13,2)
//	in_target_key = getitemstring(dw_1,lv_screen_row,1)
//	lv_track_data.track_key = in_target_key
//	gv_result = 102
//	lv_return = fx_dup_check(in_target_key,lv_track_type)
//	If lv_return = -1  then
//   	sqlcmd('ROLLBACK',stars2ca,'Dupe Check Rollback Case',1) 
//      if stars2ca.of_check_status() <> 0 then   //   10-20-95 FNC Start
//         messagebox('ERROR','Error performing rollback in cb_split')
//      end if                            // 10-20-95 FNC End       
//	   //sqlcmd('DISCONNECT',stars2ca,'Disconnecting from database',1) 
//		RETURN
//	Elseif lv_return = 0 then
//			 gv_case_dup_ids = '~'' + in_target_key + '~''
//	   	 //sqlcmd('DISCONNECT',stars2ca,'',1)    10-20-95 FNC Start
//          COMMIT using stars2ca;
//          if stars2ca.of_check_status() <> 0 then
//             errorbox(stars2ca,'Error performing commit in cb_split')
//             return
//          end if                           //  10-20-95 FNC End
//			 gv_case_target = lv_target_id
//			 openwithparm(w_case_dup_check,'~~' + lv_track_type)
//		    If gv_result = 100  or gv_result = 0 then		
//				  gv_result = 999
//				  setmicrohelp(w_main,'Creating Case & Tracking with Disposition Closed')
//				  Messagebox('EDIT','New Case and Tracking Entry will be Created' &
//									+ 'with a Closed Disposition')
//			 End If
//			 //sqlcmd('CONNECT',stars2ca,'',2) 
//	End IF
//
//	Insert into Target_cntl 
//		(case_id,case_spl,case_ver,
//		 dept_id,user_id,trgt_id,
//		 trgt_type,subc_id,
//		 trgt_datetime,trgt_desc)
//		Values
//		 (:lv_case_id,:lv_case_spl,:lv_case_ver,
//		  :gc_user_dept,:gc_user_id,:lv_target_id,
//		  :sle_track_type.text,:sle_subset_id.text,
//		  :lv_datetime,:sle_description.text)
//	Using Stars2ca;
//	If stars2ca.of_check_status() <> 0 then
//		Errorbox(stars2ca,'Error Inserting into Target Control')
//		RETURN 
//	End If
//
//	In_targets_removed = ''
//	For lv_case_row = 1 to integer(st_row_count.text)
//		in_target_key = getitemstring(dw_1,lv_case_row,1)
//		lv_track_data.track_key = in_target_key
//		If sle_track_type.text = 'PV' or sle_track_type.text = 'PC' then
//			lv_track_data.track_name = getitemstring(dw_1,lv_case_row,3)
//		End IF
//		If sle_track_type.text = 'PV' then
//			If rb_UPIN.checked = true then
//				lv_track_data.track_number =  in_target_key
//			Else
//				lv_track_data.track_number =  ''
//			End IF
//		End If
//		If lv_case_row = lv_screen_row then
//			in_target_status = 'A'
//		Else
//			in_target_status = 'R'
//			in_targets_removed = in_targets_removed + ',' + in_target_key
//		End If	
//		lv_return = fx_Insert_track (lv_track_data,in_target_status, &
//												lv_target_id,'Y')
//		If lv_return = -1 then
//		   RETURN
//		End If
//
//      ole_meter.object.value=(lv_screen_row / integer(st_row_count.text) * 100)
//      ole_meter.show()
//	Next
//   
////Write notes for removed targets.  Each case has only one active and the rest are removed
//	in_targets_removed = mid(trim(in_targets_removed),2)
//	If in_targets_removed <> '' then
//		Select cntl_no into :lv_next_note
//			from sys_cntl
//		  where cntl_id = 'NOTE'
//		using stars2ca;		
//		If stars2ca.of_check_status() <> 0 then
//			Messagebox('EDIT','Tracking Created No notes Written for Removed Targets')
//		Else
//			lv_next_note = lv_next_note + 1
//			lv_note_id = string(lv_next_note)
//			Update Sys_cntl
//					set cntl_no = :lv_next_note
//				 where cntl_id = 'NOTE'	
//			using stars2ca;
//			If stars2ca.of_check_status() <> 0 then
//				Messagebox('EDIT','Tracking Created No notes Written for Removed Targets')
//			ELSE
//				in_targets_removed = 'SPLIT CASE ' + in_targets_removed + &
//				 ' HAVE BEEN REMOVED FROM TRACKING FOR SUBSET ' + SLE_SUBSET_ID.TEXT
////KMM 7/28/95 Prob#822 Quick Fix - if in_targets_removed is too large a string  
//			lv_len = len(in_targets_removed)
//			if lv_len > 254 then
//				in_targets_removed = 'Too many providers removed.  Refer to target ' + lv_target_id
//			end if
////KMM END	
//			Insert into notes
//					(dept_id,user_id,note_rel_type,
//					 note_rel_id,note_id,
//					 note_datetime,note_text,note_sub_type)
//					VALUES
//					(:Gc_user_dept,:gc_user_id,'CA',
//					 :gv_case_active,:lv_note_id,
//					 :lv_datetime,:in_targets_removed,'RM')
//				Using stars2ca;	
//				If stars2ca.of_check_status() <> 0 then
//					Messagebox('EDIT','Tracking Created No notes Written for Removed Targets')
//				End If
//			End IF
//		End If
//	End IF
//  Setmicrohelp(w_main,'Case ' + gv_case_active + ' Created for Row ' + string(lv_screen_row))
//  selectrow(dw_1,lv_screen_row,true)
////  Sqlcmd('COMMIT',Stars2ca,'',1)
//    Commit using stars2ca;
//  //900 code says the case and leads and tracks should be closed	
//  If gv_result = 900 then
//		fx_close_case()
//  End IF	
//Next
//ole_meter.visible = false
//
////gv_case_active	= lv_old_case 
//gv_case_active = lv_case_id + '01' + lv_case_ver
//gv_active_case = gv_case_active
//
////Sqlcmd('COMMIT',Stars2ca,'',1)
//Commit using stars2ca;
//
//If gv_case_disp = 'MYHOLD' then
//		Delete from Sys_Cntl
//			where cntl_id = :gc_user_id and 
//					cntl_case = :lv_old_case
//		Using Stars2ca;
//		If stars2ca.of_check_status() <> 0 then
//			Messagebox('ERROR','Unable to Release Hold on the Case from the System Control Table')
//		End If
//		Update Case
//				set   case_disp_hold = ''
//				where case_id = :lv_case_id and
//						case_spl = '01' and
//						case_ver = :lv_case_ver
//		Using Stars2ca;
//
//		gv_case_disp = ''
//		If Stars2ca.of_check_status() <> 0 then
//			Errorbox(Stars2ca,'Unable to Release Hold Lock on Case, Call Systems Administrator')
//		Else 
//			//Sqlcmd('DISCONNECT',Stars2ca,'',1)	10/20/95 FNC Start
//          COMMIT using stars2ca;
//          if stars2ca.of_check_status() <> 0 then
//             errorbox(stars2ca,'Error performing commit in cb_split')
//             return
//          end if                           //  10-20-95 FNC End
//		End If
//Else 
//	//Sqlcmd('DISCONNECT',Stars2ca,'',1)	10-20-95 FNC Start
//   COMMIT using stars2ca;
//   if stars2ca.of_check_status() <> 0 then
//      errorbox(stars2ca,'Error performing commit in cb_split')
//      return
//   end if                           //  10-20-95 FNC End
//End If
//
////Sqlcmd('DISCONNECT',Stars2ca,'',1)
//in_track_created = true
//setmicrohelp(w_main,'Split Cases, Target and Tracking Entries Created')
////If fx_delete_case('Y') = -1 then
////	Messagebox('EDIT','Split Cases Created, However Original Case was not Deleted')
////End IF
//
//close(parent)
//
//If isvalid(w_case_maint) then
//	w_case_maint.in_track_exists = true
//	triggerevent(w_case_maint.cb_close,clicked!)  
//End If
//
//If isvalid(w_case_folder_view) then
//	w_case_folder_view.in_tracks_required = false
//	w_case_folder_view.in_from = ''
//	triggerevent(w_case_folder_view.cb_close,clicked!) 
//End If
//
//
//
end event

type ddlb_track_by from dropdownlistbox within w_target_subset_maintain
string accessiblename = "Track By"
string accessibledescription = "Track By"
accessiblerole accessiblerole = comboboxrole!
integer x = 2377
integer y = 20
integer width = 549
integer height = 400
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//11-04-99 AJS Case Money allow user to choose track type
//12/17/05 JasonS Track 4552  Removed code that makes radio buttons disappear
String 	lv_track_key,lv_hold_track_key
int lv_row

Setpointer(hourglass!)
//setmicrohelp(w_main,'Recreating Datawindow targets Using PIN')

in_datawindow_created = wf_create_datawindow()

For lv_row = 1 to integer(st_row_count.text)
	lv_track_key = getitemstring(dw_1,lv_row,1)
   if lv_track_key = lv_hold_track_key then
       deleterow(dw_1,lv_row)
       st_row_count.text = string(rowcount(dw_1)) //12-20-94 FNC
       lv_row = lv_row - 1
       continue
   else
       lv_hold_track_key = lv_track_key
   end if
Next

setpointer(arrow!)

end event

type st_5 from statictext within w_target_subset_maintain
string accessiblename = "Track By"
string accessibledescription = "Track By"
accessiblerole accessiblerole = statictextrole!
integer x = 2011
integer y = 20
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Track By:"
boolean focusrectangle = false
end type

