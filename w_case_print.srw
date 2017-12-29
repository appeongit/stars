HA$PBExportHeader$w_case_print.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_print from w_master
end type
type st_1 from statictext within w_case_print
end type
type dw_1 from u_dw within w_case_print
end type
type rb_selected from radiobutton within w_case_print
end type
type rb_all from radiobutton within w_case_print
end type
type cb_close from u_cb within w_case_print
end type
type st_row_count1 from statictext within w_case_print
end type
type cb_print from u_cb within w_case_print
end type
type cbx_criteria from checkbox within w_case_print
end type
type cbx_leads from checkbox within w_case_print
end type
type cbx_notes from checkbox within w_case_print
end type
type cbx_target from checkbox within w_case_print
end type
type cbx_track_log from checkbox within w_case_print
end type
type cbx_track from checkbox within w_case_print
end type
type cbx_case_link from checkbox within w_case_print
end type
type cbx_case_log from checkbox within w_case_print
end type
type cbx_case from checkbox within w_case_print
end type
type st_case_id from statictext within w_case_print
end type
type sle_case_id from singlelineedit within w_case_print
end type
type dw_3 from u_dw within w_case_print
end type
type dw_4 from u_dw within w_case_print
end type
type gb_1 from groupbox within w_case_print
end type
type rte_text from u_rte within w_case_print
end type
end forward

global type w_case_print from w_master
boolean visible = false
string accessiblename = "Print Case"
string accessibledescription = "Print Case"
accessiblerole accessiblerole = windowrole!
integer x = 169
integer y = 0
integer width = 2757
integer height = 1672
string title = "Print Case"
long backcolor = 67108864
st_1 st_1
dw_1 dw_1
rb_selected rb_selected
rb_all rb_all
cb_close cb_close
st_row_count1 st_row_count1
cb_print cb_print
cbx_criteria cbx_criteria
cbx_leads cbx_leads
cbx_notes cbx_notes
cbx_target cbx_target
cbx_track_log cbx_track_log
cbx_track cbx_track
cbx_case_link cbx_case_link
cbx_case_log cbx_case_log
cbx_case cbx_case
st_case_id st_case_id
sle_case_id sle_case_id
dw_3 dw_3
dw_4 dw_4
gb_1 gb_1
rte_text rte_text
end type
global w_case_print w_case_print

type variables
integer iv_print
string  is_case_id,is_case_spl,is_case_ver
n_cst_case inv_case
end variables

forward prototypes
protected subroutine fx_reset_cbx ()
public function integer fx_print_case ()
public function int fx_print_case_log ()
public function int fx_print_leads ()
public function int fx_print_target ()
public function int fx_print_track ()
public function integer fx_print_track_link_details (long job_num)
public function integer fx_print_notes ()
public function integer wf_retrieve_depend_tbls (ref string lv_tbl_type, ref string lv_rel_table_type[], ref string lv_rel_table_name[])
public function integer wf_retrieve_relationship (string lv_table_type, ref string lv_relationship_table_type[], ref string lv_relationship_table_name[])
public function integer fx_print_track_log ()
public function integer fw_case_security ()
public function integer wf_print_case_link (long job_num)
end prototypes

protected subroutine fx_reset_cbx ();setpointer(hourglass!)

cbx_case.checked			 = false
cbx_case_link.checked    = false
cbx_case_log.checked     = false
cbx_criteria.checked     = false
cbx_criteria.visible     = false
cbx_leads.checked        = false
cbx_notes.checked        = false
cbx_target.checked       = false
cbx_track.checked        = false
//cbx_track_link.checked   = false  //VAV 4.0 2/17/98
cbx_track_log.checked    = false
RESET(DW_1)
//RESET(DW_2)								//VAV 4.0 2/17/98
Reset(dw_3)
ST_ROW_COUNT1.TEXT = ''
//ST_ROW_COUNT2.TEXT = ''				//VAV 4.0 2/17/98

end subroutine

public function integer fx_print_case ();string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_case_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Object for Case Print')
	RETURN -1
End If

If retrieve(dw_3,lv_case_id,lv_case_spl,lv_case_ver) <= 0 then
	RETURN -1
End IF

//NLG 9-15-99 ts2363c.  Determine which custom columns will be displayed, and
//								format them
dw_3.SetRedraw(False)
inv_case.uf_format_custom_headings(dw_3)
dw_3.SetRedraw(True)


setmicrohelp(w_main,'Printing Case Data')
//print(dw_3)
return 0 
end function

public function int fx_print_case_log ();string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)


reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_case_log_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Objectfor Case Log')
	RETURN -1
End If

If retrieve(dw_3,lv_case_id,lv_case_spl,lv_case_ver) <= 0 then
	RETURN -1
End IF

setmicrohelp(w_main,'Printing Case Log Data')
//print(dw_3)
return 0 
end function

public function int fx_print_leads ();string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)


reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_lead_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Objectfor Case Lead')
	RETURN -1
End If

If retrieve(dw_3,lv_case_id,lv_case_spl,lv_case_ver) <= 0 then
	RETURN -1
End IF

setmicrohelp(w_main,'Printing Case Leads')
//print(dw_3)
return 0 
end function

public function int fx_print_target ();string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_target_by_case_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Objectfor Case Targets')
	RETURN -1
End If

If retrieve(dw_3,lv_case_id,lv_case_spl,lv_case_ver) <= 0 then
	RETURN -1
End IF

setmicrohelp(w_main,'Printing Case Targets')
//print(dw_3)
return 0 
end function

public function int fx_print_track ();string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)


reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_track_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Objectfor Case Tracks')
	RETURN -1
End If

If retrieve(dw_3,lv_case_id,lv_case_spl,lv_case_ver) <= 0 then
	RETURN -1
End IF

setmicrohelp(w_main,'Printing Case Tracking Data')
//print(dw_3)
return 0 
end function

public function integer fx_print_track_link_details (long job_num);// fx_print_track_link_details
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
//***********************************************************************

//string lv_case_id,lv_case_spl,lv_case_ver
//Int lv_sub,lv_rows
//Blob    sql_syntax,sql_data
//String  dwsave_file        = 'C:\DWSAVE.TXT'
//Integer file_number
//String  file_line
//Integer Rc
//String  Create_error_msg
//String  sql_statement
//String  rpt_info_type
//Integer rpt_info_length    =   255
//Integer max_write_length   = 32765
//String  table_name = 'Report_line'
//n_tr sql_trans_name
//String save_name
//String Lv_save_type
//Boolean dw_data_imported
//String  lv_sql,LV_RPT_NUM
//string  lv_sel,lv_table
//string  lv_foot_ht
//STRING  lv_foot_set
//
//setpointer(hourglass!)
//lv_case_id = left(sle_case_id.text,10)
//lv_case_spl = mid(sle_case_id.text,11,2)
//lv_case_ver = mid(sle_case_id.text,13,2)
//sql_trans_name = Stars2ca
//
//For lv_sub = 1 to integer(st_row_count2.text)
//	If dw_2.Isselected(lv_sub) = False then
//		Continue
//	Else
//		save_name = getitemstring(dw_2,lv_sub,5)
//		lv_save_type = getitemstring(dw_2,lv_sub,4)
//		reset(dw_3)
//		setpointer(hourglass!)
//		If lv_save_type = 'CPR' then
//				sql_syntax = blob('')
//				sql_data   = blob('')
//				File_line = ''
////Following logic is similar to function SaveDataWindow 
//// Verify saved datawindow exists and retrieve dw syntax and data
//				sql_statement = 'SELECT RPT_INFO FROM ' + table_name + ' WHERE RPT_NAME = ? and RPT_INFO_TYPE = ? ORDER BY RPT_INFO_SEQ_NO';
//				DECLARE report_info_cursor DYNAMIC CURSOR FOR SQLSA;
//				PREPARE SQLSA FROM :sql_statement Using sql_trans_name;
//				If (sql_trans_name.of_check_status() <> 0) then
//				   Messagebox('ERROR','Could NOT determine if a saved datawindow exists with the specified name.')
//					Continue
//				End if
//				rpt_info_type = 'SY'
//				OPEN  DYNAMIC report_info_cursor Using :save_name,:rpt_info_type;
//				Do while (sql_trans_name.SqlCode = 0)
//				   FETCH report_info_cursor INTO :file_line;
//				   If (sql_trans_name.of_check_status() = 0) then 
//      				file_line  = Left(file_line + Fill(' ',rpt_info_length),rpt_info_length)
//				      sql_syntax = sql_syntax + Blob(Mid(file_line,1,rpt_info_length))
//				   End if
//				loop 
//				If (sql_trans_name.of_check_status() = 100) then
//				   CLOSE report_info_cursor;
//				End if
//				If (sql_trans_name.of_check_status() <>  0) then
//				   Messagebox('EDIT','Could NOT read saved syntax for datawindow.')
//					Continue
//				End if
//				If (Len(sql_syntax) = 0) then
//					COMMIT USING SQL_TRANS_NAME;
////				   SqlCmd('COMMIT',sql_trans_name,'',1)
//				   MessageBox('View Data Window','No datawindow has been saved~nunder the name "' + save_name + '".',StopSign!)
//					Continue
//				End if
//
//				rpt_info_type = 'DA'
//				OPEN  DYNAMIC report_info_cursor Using :save_name,:rpt_info_type;
//				Do while (sql_trans_name.SqlCode = 0)
//				   FETCH report_info_cursor INTO :file_line;
//				   If (sql_trans_name.of_check_status() = 0) then 
//			   	   file_line = Left(file_line + Fill(' ',rpt_info_length),rpt_info_length)
//   	   			sql_data  = sql_data + Blob(Mid(file_line,1,rpt_info_length))
//				   End if
//				loop 
//				If (sql_trans_name.of_check_status() = 100) then
//		   		CLOSE report_info_cursor;
//				End if
//				If (sql_trans_name.of_check_status() <>  0) then
//				   Messagebox('EDIT','Could NOT read saved data for datawindow.')
//					Continue
//				End if
//				COMMIT USING SQL_TRANS_NAME;
////				SqlCmd('COMMIT',sql_trans_name,'',1)
//
//// Write data to temp save file for importing
//				file_number = FileOpen(dwsave_file,LineMode!,Write!,Shared!,Replace!)
//				if (file_number = -1) then
//				   MessageBox('View Data Window','Could NOT open temp save file.',StopSign!)
//					Continue
//				end if
//				Do while (Len(sql_data) <> 0)
//				   if (Len(sql_data) > max_write_length) then
//   		   		file_line = RightTrim(String(BlobMid(sql_data,1,max_write_length)))
//				      sql_data  = BlobMid(sql_data,max_write_length + 1)
//				   else
//	   	   		file_line = RightTrim(String(sql_data))
//		   	   	sql_data  = Blob('')
//				   end if
//				   rc = FileWrite(file_number,file_line)
//				   if (rc = -1) then
//				      MessageBox('View Data Window','Could NOT write temp save file',StopSign!)
//      				if (FileClose(file_number) <> 1) then 
//							MessageBox('View Data Window','Could NOT close temp save file',StopSign!)
//						End If
//						Continue
//			   	End if
//				Loop
//				if (FileClose(file_number) = -1) then
//	   			MessageBox('View Data Window','Could NOT close temp save file',StopSign!)
//					Continue
//				end if
//	
//// Open dw viewer and display saved datawindow
//				dw_3.Title = 'View of ' + save_name + ' Report'
//				if (dw_3.Create(String(sql_syntax),Create_error_msg) = -1) then
//				   MessageBox('View Data Window','Could NOT recreate original data window'+Create_error_msg,StopSign!)
//					If (FileDelete(dwsave_file) = False) then
//						MessageBox('View Data Window','Could NOT delete temp save file',StopSign!)
//					End If
//					Continue
//				end if
//
//				dw_data_imported = False
//				if (dw_3.ImportFile(dwsave_file) >= 0) then
//				   if (dw_3.GroupCalc()         = 1) then 
//						dw_data_imported = True
//					End If
//				end if
//				if (dw_data_imported = False) or (FileDelete(dwsave_file) = False) then
//				   MessageBox('View Data Window','Could NOT redisplay saved data window information',StopSign!)
//					Continue
//				End if
//				lv_sel = dw_3.getsqlselect()
//				If match(lv_sel,'ROS_DETAIL') = TRUE OR match(lv_sel,'SUB_ROS_DETAIL') = TRUE THEN
//					lv_table = 'DETAIL'
//				ElseIf match(lv_sel,'ROS_HEADER') = TRUE OR match(lv_sel,'SUB_ROS_HEADER') = TRUE THEN
//					lv_table = 'HEADER'
//				ELSE
//					LV_TABLE = ''
//				END IF
//
//// Add the Report Number to the Datawindow
//				LV_RPT_NUM = '~'RPT #:' + SAVE_NAME + '~''
//				LV_SQL = DW_3.Modify("create text(band=Foreground" + &
//					" color='0' alignment='0' border='0' " + &
//					" moveable=0 resizeable=1 x='1' y='1' height='22' width='200' text="+ LV_RPT_NUM + &
//					" name=rpt_num font.face='System' font.height='-6' font.weight='400' font.family='2' font.pitch='2' font.charset='0'" + &
//					" font.italic='0' font.strikethrough='0' font.underline='0' background.mode='0' background.color='1073741824')")
//					//dw_3.visible = true
//				   setmicrohelp(w_main,'Printing Case Report ' + save_name)
//					PrintDataWindow(job_num,dw_3)
//				This.Event ue_set_window_colors(This.Control)
//		end if
//	End If
//Next
//
RETURN 0
//
end function

public function integer fx_print_notes ();//	10/06/99	NLG	TS2443c Make notes_text rich text edit
//						Must print separately from main job
//	12/12/00	FDG	Stars 4.7.  Make retrieval of note_text
//						DBMS-independent.
//	09/17/02	GaryR	SPR 4182c	Pass three unique key
//										arguments for notes retrieval
//	06/23/05	GaryR Track 4438d	Use ReplaceText instead of the ClipBoard method.
//										Citrix is having issues with Paste & ClipBoard.
//										Also, add note desc to the header.
//
////////////////////////////////////////////////////////

int li_rc
string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)

reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_case_note_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Object for Case Notes')
	RETURN -1
End If

If retrieve(dw_3,sle_case_id.text) <= 0 then
	RETURN -1
End IF

//NLG ts2443c begin
long ll_rowcount, ll_row,ll_rc
string 	ls_desc, &
			ls_rte_ind, &
			ls_user_id, &
			ls_dept_id, &
			ls_note_id, &
			ls_sub_type, &
			ls_note_desc, &
			ls_note_datetime, &
			ls_rte_string

setmicrohelp(w_main,'Printing Case Notes')

ll_rowcount = dw_3.rowcount()
FOR ll_row = 1 to ll_rowcount
	ls_user_id = dw_3.object.user_id[ll_row]
	ls_dept_id = dw_3.object.dept_id[ll_row]
	ls_note_id = dw_3.object.note_id[ll_row]
	ls_sub_type = dw_3.object.note_sub_type[ll_row]
	ls_note_datetime = string(dw_3.object.note_datetime[ll_row])
	ls_note_desc = dw_3.object.note_desc[ll_row]
	
	//concatenate string and paste to rte control
	ls_rte_string =  "~r~nUser ID: ~t" + ls_user_id + &
							"~r~nDept ID: ~t" + ls_dept_id + &
							"~r~nNote ID: ~t" + ls_note_id + &
							"~r~nSub Type:~t" + ls_sub_type + &
							"~r~nDescription:~t" + ls_note_desc + &
							"~r~nNote Datetime: ~t" + ls_note_datetime + &
							"~r~n~r~n"
	
	rte_text.Replacetext( ls_rte_string )
		
	//	09/17/02	GaryR	SPR 4182c
	ls_desc	=	gnv_sql.of_get_note_text( ls_note_id, "CA", sle_case_id.text)
	// FDG 12/12/00 end
	
	ls_rte_ind = dw_3.object.rte_ind[ll_row]
	
	//If rte indicator is set, it's rich text
	IF ls_rte_ind = 'Y' THEN
		ll_rc = rte_text.PasteRTF(ls_desc,Detail!)
	ELSE
		rte_text.Replacetext( ls_desc )
	END IF
	li_rc = rte_text.Print(1,"",FALSE,FALSE)
	rte_text.of_clear( )
NEXT

return 0
end function

public function integer wf_retrieve_depend_tbls (ref string lv_tbl_type, ref string lv_rel_table_type[], ref string lv_rel_table_name[]);//********************************************************************
// 7/25/95   FNC SWAT effort to display parameters for dictionary read
//               if receive a bad return code
//
// 12/06/95	 DKG Access dictionary (elem_type = 'TB') thru
//					  w_main.dw_stars_rel_dict.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//********************************************************************

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

//sqlcmd('CONNECT',stars2ca3,'Error connecting to database',2)		// FDG 02/20/01
stars2ca3.of_connect()															// FDG 02/20/01

Declare d_elem cursor for
	Select distinct a.Id_2 
			from Stars_rel a,stars_rel b
where a.rel_type = 'DP' and
			a.rel_id  = b.id_2 and
 			b.rel_type = 'GP' and
			b.rel_id   = Upper( :LV_TBL_TYPE )
Using Stars2ca3;
Open d_elem;

If Stars2ca3.of_check_status() <> 0 then
	//sqlcmd('ROLLBACK',Stars2ca3,'',1)
	//sqlcmd('DISCONNECT',Stars2ca3,'',1)			// FDG 02/20/01
	stars2ca3.of_disconnect()							// FDG 02/20/01
	Destroy Stars2ca3;
	Messagebox('ERROR','Retrieving dependent tables for ' + lv_TBL_TYPE)
	Return -1
End IF

lv_count = 0
Do while stars2ca3.sqlcode = 0
   lv_count = lv_count + 1
  	Fetch d_elem into :lv_rel_table_type[lv_count] ;
	
	If stars2ca3.of_check_status() = 100 then
		Continue
	End If

   If trim(lv_rel_table_type[lv_count]) <> '' Then   
		lv_rel_table_name[lv_count]	=	fx_get_stars_rel_elem_name (lv_rel_table_type[lv_count])
   End If

    IF lv_rel_table_name[lv_count] = '' THEN
		 lv_where = "WHERE ELEM_TYPE = 'TB' AND ELEM_TBL_TYPE = :"+lv_rel_table_type[lv_count]
       MessageBox('ERROR','Retrieving subset for Table type '+ lv_rel_table_type[lv_count] + lv_where)
    END IF	
Loop

Close d_elem;

If stars2ca3.of_check_status() <> 0 then
	//sqlcmd('ROLLBACK',Stars2ca3,'',1)
	//sqlcmd('DISCONNECT',Stars2ca3,'',1)			// FDG 02/20/01
	stars2ca3.of_disconnect()							// FDG 02/20/01
	Destroy Stars2ca3;
	Messagebox('ERROR','Retrieving subset for Table type ' + lv_tbl_type)
End IF

//sqlcmd('DISCONNECT',Stars2ca3,'',1)				// FDG 02/20/01
stars2ca3.of_disconnect()								// FDG 02/20/01
Destroy Stars2ca3;

RETURN 0

end function

public function integer wf_retrieve_relationship (string lv_table_type, ref string lv_relationship_table_type[], ref string lv_relationship_table_name[]);//******************************************************************
// Aug18, 1994 - Youxiong Pang
// This function reads the STARS Relationship table and dictionary
// table, and retrieves the table type, table name and  for all of 
// the values in the relationship specified
//
// Arguments passed to function:
//
// lv_table_Type - The type of group for which the relationship will
//                 be retrieved. Ex. MA, MB, MC
//
// Arguments sent back to script:
//
// lv_relationship_table_type[] - An array containing all of the table
//       types in the relationship.
// lv_relationship_table_name[] - An array containing all of the table
//       names in the relationship.

//******************************************************************
//07-27-95 FNC SWAT effort display parameters for dictionary and 
//             stars rel if get bad return code
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//******************************************************************
int li_x
string lv_hold_relationship_table_type,lv_hold_relationship_table_name
string lv_hold_tbl_join
string lv_where

sqlca.dbms        = stars2ca.dbms
sqlca.database    = stars2ca.database
sqlca.logid       = stars2ca.logid
sqlca.logpass     = stars2ca.logpass
sqlca.servername  = stars2ca.servername
sqlca.userid      = stars2ca.userid
sqlca.dbpass      = stars2ca.dbpass
sqlca.lock        = stars2ca.lock
sqlca.dbparm      = stars2ca.dbparm

//sqlcmd('connect',sqlca,'',3)			// FDG 02/20/01
SQLCA.of_connect()							// FDG 02/20/01

DECLARE Retrieve_Relationship_Table CURSOR FOR  
    SELECT distinct STARS_REL.ID_2,DICTIONARY.ELEM_NAME
    FROM STARS_REL, DICTIONARY
    where (   (    stars_rel.rel_type = 'GP'
               and stars_rel.rel_id = Upper( :lv_table_type ) )
           or (    stars_rel.rel_type = 'DP'
               and stars_rel.rel_id in (select distinct id_2
                                        from stars_rel
                                        where rel_type = 'GP'
                                        and rel_id = Upper( :lv_table_type ) )
          ))
    and DICTIONARY.ELEM_TYPE = 'TB'
    AND DICTIONARY.ELEM_TBL_TYPE = STARS_REL.ID_2
    USING sqlca  ;

  //07-27-95 FNC 
  lv_where  = '(stars_rel.rel_type = GP ' + &
              ' and stars_rel.rel_id =  ' + Upper( lv_table_type ) + ')' + &
              ' or (stars_rel.rel_type = DP ' + &
              ' and stars_rel.rel_id in (select distinct id_2 ' + &
              ' from stars_rel where rel_type = GP' + &
              ' and rel_id = ' + Upper( lv_table_type ) + '))' + & 
              ' and DICTIONARY.ELEM_TYPE = TB' + &
              ' AND DICTIONARY.ELEM_TBL_TYPE =  STARS_REL.ID_2'

  OPEN Retrieve_Relationship_Table;
  
   If sqlca.of_check_status() <> 0 then
	  Errorbox(sqlca,'Error reading STARS RELATIONSHIP table' + lv_where)
	  RETURN -1
   End If
  
   li_x = 0
   Do while sqlca.sqlcode = 0
	   Fetch Retrieve_Relationship_Table 
         into :lv_hold_relationship_table_type,
              :lv_hold_relationship_table_name;
      If sqlca.of_check_status() = 100 then exit

      If sqlca.sqlcode <> 0 then
	      Errorbox(sqlca,'Error retrieving claim types from relationship table' + lv_where)
	      RETURN  -1
	   End If
      li_x = li_x + 1
      lv_relationship_table_type[li_x] = lv_hold_relationship_table_type
      lv_relationship_table_name[li_x] = lv_hold_relationship_table_name

   Loop

SQLCA.of_commit()										// FDG 02/20/01

//sqlcmd('disconnect',sqlca,'',1)				// FDG 02/20/01
SQLCA.of_disconnect()								// FDG 02/20/01

Return 0
end function

public function integer fx_print_track_log ();string lv_case_id,lv_case_spl,lv_case_ver

Integer	li_rc

setpointer(hourglass!)
lv_case_id = Trim (left(sle_case_id.text,10) )		// FDG 04/16/01
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 end


reset(dw_3)
setpointer(hourglass!)
dw_3.dataobject = 'd_track_log_print'
This.Event ue_set_window_colors(This.Control)
If settransobject(dw_3,stars2ca) < 1 then
	Messagebox('EDIT','Unable to Set Tranaction Objectfor Track Log')
	RETURN -1
End If

If retrieve(dw_3,lv_case_id,lv_case_spl,lv_case_ver) <= 0 then
	RETURN -1
End IF

setmicrohelp(w_main,'Printing Track Log Data')
//print(dw_3)
return 0 
end function

public function integer fw_case_security ();// Modifications:
// 08-31-98 NLG 	FS362 convert case to case_cntl
//	08-11-99	NLG	ts2363 Use case nvo for case security


string ls_msg

//Alabama 2 pat-d
String lv_case_id,lv_case_spl,lv_case_ver 
String lv_case_cat 
String lv_code_dept
Int    lv_code_sec

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

Ls_msg  =  inv_case.uf_edit_case_security(lv_case_id, lv_case_spl, lv_case_ver)
IF  Len (ls_msg)  >  0   THEN
	MessageBox ('Security Error', ls_msg)
	Return -1
END IF

return 0
end function

public function integer wf_print_case_link (long job_num);//			w_case_print.wf_print_case_link()
//------------------------------------------------------------------
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		-----------------------------------------------
// AJS   07-20-98    4.0 fix case print track #1418
//	JGG	03-12-98		STARS 4.0 - TS145 Executable changes, remove
//							obsolete code and functions.
//	GaryR	11/01/00		2920c	Standardize windows colors
//	FDG	04/16/01		Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	GaryR	11/03/01		Track 2528d	"Save As" subsets appear more than once.
//	FDG	02/20/02		Track 2827d. Remove link_name from criteria
//	GaryR	05/04/04		Track 3544d	Redesign report save/view logic to improve performance
//	GaryR	12/22/04		Track 4182d	Apply modify/update security
//	GaryR	07/02/07		Track 5089	When modifing saved PDR, update date and create log
//
//------------------------------------------------------------------

String	ls_save_name, ls_save_link_name, ls_delete_ind, ls_save_type
Integer	li_rc, li_sub, li_rowcount, lv_rows
n_cst_report	lnv_report

SetPointer(Hourglass!)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (is_case_spl)
li_rc	=	gnv_sql.of_TrimData (is_case_ver)
// FDG 04/16/01 - end

li_rowcount = dw_1.RowCount()	
FOR li_sub = 1 to li_rowcount 
	If dw_1.Isselected(li_sub) = FALSE then
		CONTINUE
	Else
		ls_save_type = GetItemString(dw_1,li_sub,4)
		If ls_save_type = 'SUB' then
 			ls_save_name =	GetItemString(dw_1, li_sub, 'Link_Key')
 			ls_save_link_name = GetItemString(dw_1, li_sub, 'Link_Name')
 		Else
 			ls_save_name = GetItemString(dw_1, li_sub, 'Link_Key')
 			ls_save_link_name = ls_save_name
 		End if 

      Reset(dw_4)
		SetPointer(Hourglass!)

		If ls_save_type = 'SUB' or ls_save_type = 'ARC'  then

		If cbx_criteria.checked = FALSE then
				CONTINUE
			End if
			Reset(dw_3)
			SetPointer(Hourglass!)
			dw_3.dataobject = 'd_criteria_used_print'
			dw_3.of_SetTrim (TRUE)								// FDG 04/16/01
			If SetTransObject(dw_3,stars2ca) < 1 then
				MessageBox('EDIT','Unable to Set Transaction Object for Subset Criteria ')
				CONTINUE
			End if
			//	GaryR	11/03/01	Track 2528d
			If retrieve(dw_3,is_case_id,is_case_spl,is_case_ver,ls_save_name) <= 0 then
				setmicrohelp(w_main,'Error Printing Criteria Details')
				Continue
			End IF

			SetMicroHelp(w_main,'Printing Criteria for Case Subset ' + ls_save_link_name)    
         SetPointer(Hourglass!)
			li_rc = PrintDataWindow(job_num,dw_3)
			If li_rc <> 1 Then
				 MessageBox('INFORMATION','Error Printing Criteria for Case Subset')
			End if
			//Added to print filters If they exist in the criteria
			Reset(dw_3)
			SetPointer(Hourglass!)
			dw_3.DataObject = 'd_case_filter_display'
			If SetTransObject(dw_3,stars2ca) < 1 then
				MessageBox('EDIT','Unable to Set Transaction Object for Subset Criteria ')
				CONTINUE
			End if
			If Retrieve(dw_3,is_case_id,is_case_spl,is_case_ver,ls_save_name) <= 0 then	
				SetMicroHelp(w_main,'Error Printing Filter Details, Subset Printed')
				CONTINUE
			End if           
			If dw_3.RowCount() <= 0 then
			//don't print
			Else
				SetMicroHelp(w_main,'Printing Filters for Case Subset ' + ls_save_link_name)
         	SetPointer(Hourglass!)
				li_rc = PrintDataWindow(job_num,dw_3)
				If li_rc <> 1 Then  
	 			   MessageBox('INForMATION','Error Printing filters for Case Subset'+ ls_save_link_name)
				End if
  			End if

		Elseif ls_save_type = 'RPT' or ls_save_type = 'MED' or ls_save_type = 'RDM' then
			// Check if Report is BG Pattern and viewed
			SELECT delete_ind
			INTO	:ls_delete_ind
			FROM	bg_rpt_cntl
			WHERE	rpt_id = Upper( :ls_save_name )
			USING	Stars2ca;
			
			Stars2ca.of_check_status()
			IF Stars2ca.sqlcode = 100 THEN
				//rpt not generated and 'ML' from back end
				Stars2ca.of_commit()
				IF lnv_report.of_view( gv_active_case, ls_save_name, ls_save_link_name, FALSE ) < 0 THEN Continue
			ELSEIF Stars2ca.sqlcode = 0 THEN
				IF ls_delete_ind = 'Y' THEN
					//Rpt has already been viewed and saved as stars report
					Stars2ca.of_commit()
					IF lnv_report.of_view( gv_active_case, ls_save_name, ls_save_link_name, FALSE ) < 0 THEN Continue
				ELSE
					IF lnv_report.of_view_patt_rpt( gv_active_case, ls_save_name, ls_save_link_name ) < 0 THEN Continue
				END IF
			Else				
				Messagebox('Database error','Unable to read the Background Report Control Table')
				Continue
			End If
			
			IF NOT IsValid( w_dw_viewer.dw_1 ) THEN
				MessageBox( "Report Error", "Unable to recreate report", StopSign! )
				Continue
			END IF

			w_main.SetMicroHelp('Printing Case Report ' + ls_save_link_name)
			IF PrintDataWindow(job_num,w_dw_viewer.dw_1) <> 1 THEN
				MessageBox('INFORMATION','Error Printing Case Report ' + ls_save_link_name)
			END IF
			Close( w_dw_viewer )
		Elseif ls_save_type = 'CRC' or ls_save_type = 'CRA' then
				If cbx_criteria.checked = FALSE then
					CONTINUE
				End if
				Reset(dw_3)
				SetPointer(Hourglass!)
				If ls_save_type = 'CRA' then
					DW_3.dataobject = 'd_anal_crit'
					dw_3.of_SetTrim (TRUE)										// FDG 04/16/01
				Elseif ls_save_type = 'CRC' then
					DW_3.dataobject = 'd_criteria_clm_rpt_detail'
				End if
				This.Event ue_set_window_colors(This.Control)
				If SetTransObject(dw_3,stars2ca) < 1 then
					MessageBox('EDIT','Unable to Set Transaction Object for Subset Criteria ')
					CONTINUE
				End if

				If ls_save_type = 'CRC' then
					lv_rows = retrieve(dw_3,is_case_id,is_case_spl,is_case_ver,ls_save_name,'CRC')
				Elseif ls_save_type = 'CRA' then
					lv_rows = retrieve(dw_3,is_case_id,is_case_ver,is_case_spl,ls_save_name)
				End if
				If lv_rows <= 0 then
					SetMicroHelp(w_main,'Error Printing Criteria Details')
					CONTINUE
				End if
				SetMicroHelp(w_main,'Printing Criteria ' + ls_save_link_name)
            SetPointer(Hourglass!)
				li_rc = PrintDataWindow(job_num,dw_3)
				If li_rc <> 1 Then
			   	 MessageBox('INForMATION','Error Printing Criteria ' + ls_save_link_name)
				End if
			End if
	End if
NEXT

RETURN 0
end function

event open;call super::open;//NLG 8-11-99 Create the case nvo 
//FDG 2/16/01 Move CREATE before the IF 

sle_case_id.Text = gv_active_case

inv_case = CREATE n_cst_case			// FDG 2/16/01

If sle_case_id.Text = '' then RETURN

is_case_id = left(sle_case_id.text,10)
is_case_spl = mid(sle_case_id.text,11,2)
is_case_ver = mid(sle_case_id.text,13,2)

rb_selected.Checked = True
If fw_case_security() <> 0 then RETURN   //alabama2 pat-d
cbx_case_link.Checked = true
TriggerEvent(cbx_case_link,Clicked!)

end event

on w_case_print.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.rb_selected=create rb_selected
this.rb_all=create rb_all
this.cb_close=create cb_close
this.st_row_count1=create st_row_count1
this.cb_print=create cb_print
this.cbx_criteria=create cbx_criteria
this.cbx_leads=create cbx_leads
this.cbx_notes=create cbx_notes
this.cbx_target=create cbx_target
this.cbx_track_log=create cbx_track_log
this.cbx_track=create cbx_track
this.cbx_case_link=create cbx_case_link
this.cbx_case_log=create cbx_case_log
this.cbx_case=create cbx_case
this.st_case_id=create st_case_id
this.sle_case_id=create sle_case_id
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_1=create gb_1
this.rte_text=create rte_text
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.rb_selected
this.Control[iCurrent+4]=this.rb_all
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.st_row_count1
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.cbx_criteria
this.Control[iCurrent+9]=this.cbx_leads
this.Control[iCurrent+10]=this.cbx_notes
this.Control[iCurrent+11]=this.cbx_target
this.Control[iCurrent+12]=this.cbx_track_log
this.Control[iCurrent+13]=this.cbx_track
this.Control[iCurrent+14]=this.cbx_case_link
this.Control[iCurrent+15]=this.cbx_case_log
this.Control[iCurrent+16]=this.cbx_case
this.Control[iCurrent+17]=this.st_case_id
this.Control[iCurrent+18]=this.sle_case_id
this.Control[iCurrent+19]=this.dw_3
this.Control[iCurrent+20]=this.dw_4
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.rte_text
end on

on w_case_print.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.rb_selected)
destroy(this.rb_all)
destroy(this.cb_close)
destroy(this.st_row_count1)
destroy(this.cb_print)
destroy(this.cbx_criteria)
destroy(this.cbx_leads)
destroy(this.cbx_notes)
destroy(this.cbx_target)
destroy(this.cbx_track_log)
destroy(this.cbx_track)
destroy(this.cbx_case_link)
destroy(this.cbx_case_log)
destroy(this.cbx_case)
destroy(this.st_case_id)
destroy(this.sle_case_id)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_1)
destroy(this.rte_text)
end on

event close;call super::close;if IsValid(inv_case) then Destroy inv_case
end event

type st_1 from statictext within w_case_print
string accessiblename = "Case Link"
string accessibledescription = "Case Link"
accessiblerole accessiblerole = statictextrole!
integer x = 174
integer y = 468
integer width = 425
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Case Link"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_case_print
string accessiblename = "Case Link List"
string accessibledescription = "Case Link List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Case Link List"
integer x = 128
integer y = 580
integer width = 2482
integer height = 840
integer taborder = 140
string dataobject = "d_case_folder_print"
boolean vscrollbar = true
end type

event clicked;int lv_cur_row
boolean lv_result

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//remove reference to getclickedrow
//lv_cur_row = dw_1.getclickedrow()
lv_cur_row = row


If lv_cur_row <= 0 then
	setmicrohelp(w_main,'Select a Valid Row')
	RETURN
End IF

lv_result = dw_1.IsSelected(lv_cur_row)
If lv_result = true then
	dw_1.selectrow(lv_cur_row,false)
Else
	dw_1.selectrow(lv_cur_row,true)
End If

setpointer(arrow!)
end event

event retrievestart;SetPointer(Hourglass!)
end event

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

type rb_selected from radiobutton within w_case_print
boolean visible = false
string accessiblename = "Selected"
string accessibledescription = "Selected"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 750
integer y = 1456
integer width = 370
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Selected"
end type

event clicked;integer li_num

li_num = &
Messagebox('Information','Only those items that are clicked and highlighted will be printed',Information!,OKCancel!)
If li_num = 2 Then
  Return
End If

setmicrohelp(w_main,'Ready')





end event

type rb_all from radiobutton within w_case_print
boolean visible = false
string accessiblename = "All"
string accessibledescription = "All"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 462
integer y = 1456
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "All"
end type

event clicked;integer li_num

li_num = Messagebox('Information','This will print all the associated data which may take a while.  Are you sure want everything printed?',Question!,YesNO!,2)
If li_num = 2 Then
	rb_selected.checked=true
	Return
End If
iv_print = 1

end event

type cb_close from u_cb within w_case_print
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2277
integer y = 1440
integer width = 334
integer height = 108
integer taborder = 170
string text = "&Close"
end type

on clicked;Setpointer(hourglass!)
SETMICROHELP(w_MAIN,'')
close(parent)
SETPOINTER(ARROW!)

end on

type st_row_count1 from statictext within w_case_print
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 128
integer y = 1452
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_print from u_cb within w_case_print
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1851
integer y = 1440
integer width = 334
integer height = 108
integer taborder = 150
string text = "&Print"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//
//	Modifications:
//
// 08-31-98 NLG FS362 convert case to case_cntl
//
/* VAV 4.0 2/18/98 - Modified the script behind the Print command button, as follows:
							Remove the declaration of the lv_case_id, lv_case_spl, lv_case_ver
							local variables. Any reference to these local variables 
							within the script should be changed to reference the corresponding 
							instance variables instead.
							Invoked the wf_print_case_link window function instead of the 
							wf_print_case_link_all window function if the case link 
							check box is checked.
							Removed all reference to dw_2 within the script. 
*/ 
// GaryR	 10/27/2000	2315d	Conforming STARS to the HIPAA Act
// HYL	 01/30/06 Track 4548d 	Removed the message which keeps popping up when ever PRINT button is pressed. 
/////////////////////////////////////////////////////////////////////////////////////////

//String lv_case_id,lv_case_spl,lv_case_ver  //VAV 4.0 2/17/98
Int li_count,li_num, li_rc
String ls_case_business
Boolean lb_Checked
long ll_job   //NLG 11-06-97a

SetMicroHelp(w_main,'Ready')
SetPointer(Hourglass!)
SetFocus(sle_case_id)
cb_close.Default = true
If sle_case_id.Text = '' then
	fx_reset_cbx()
	MessageBox('EDIT','Enter Case Id')
	RETURN
End IF

If fw_case_security() <> 0 then Return    //alabama2 pat-d

If cbx_case.Checked			= False and &
	cbx_case_link.Checked 	= False and &
	cbx_case_log.Checked 	= False and &
	cbx_leads.Checked 		= False and &
	cbx_notes.Checked	 		= False and &
	cbx_target.Checked 		= False and &
	cbx_track.Checked 		= False and &
	cbx_track_log.Checked 	= False		    then
//	cbx_track_link.Checked	= False and &
	MessageBox('EDIT','No Selection Made')
	RETURN
End If

is_case_id = left(sle_case_id.text,10)
is_case_spl = mid(sle_case_id.text,11,2)
is_case_ver = mid(sle_case_id.text,13,2)

/*  01/30/06 HYL Track 4548d Removed the message which keeps popping up when ever PRINT button is pressed. 
This is because user may have already set up printer to landscape mode and, when individual note is printed, the Rich Text Edit control does not print in landscape mode.
li_num = MessageBox('Warning','For the best printing results, your printer setup for windows should be set to Landscape, Do you wish to continue?',Information!,YesNo!,2)
If li_num = 2 Then
   RETURN
End If */

SetPointer(Hourglass!)

// 08-31-98 NLG FS362 convert case to case_cntl
Select count(*) into :li_count
	from Case_cntl
   Where case_id = Upper( :is_case_id ) and
			case_spl = Upper( :is_case_spl ) and
			case_ver = Upper( :is_case_ver )
Using Stars2ca;
If Stars2ca.of_check_status() <> 0 then
	Errorbox(Stars2ca,'Error Verifying Case')
	RETURN
Elseif li_count = 0 then
	COMMIT using Stars2ca;
	If stars2ca.of_check_status() <> 0 Then
		MessageBox('EDIT','Error Commiting to Stars2')
		RETURN
	End If	
	MessageBox('EDIT','Case does not Exist')
	RETURN
End IF

IF fx_disclaimer() <> 1 THEN Return	// GaryR	 10/27/2000	2315d

SetMicroHelp(w_main,'Starting Print Job')

ll_job = PrintOpen()

If cbx_case.Checked = true then 
	SetPointer(Hourglass!)
	li_count =	fx_print_case()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Data')
	Else
		PrintDataWindow(ll_job,dw_3)
	End If
End If

If cbx_case_log.Checked = true then 
	SetPointer(Hourglass!)
	li_count =	fx_print_case_log()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Log Data')
	Else
		PrintDataWindow(ll_job,dw_3)
	End If
End If

If cbx_case_link.Checked = true then
	SetPointer(Hourglass!)
	SetMicroHelp(w_main,'Printing Case Link')
	PrintDataWindow(ll_job,dw_1)
   wf_print_case_link(ll_job)
End If

If cbx_leads.Checked = true then
	SetPointer(hourglass!)
	li_count =	fx_print_leads()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Lead Data')
	Else
		PrintDataWindow(ll_job,dw_3)
	End If
End If

If cbx_target.Checked = true then
	SetPointer(Hourglass!)
	li_count =	fx_print_target()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Target Data')
	Else
		PrintDataWindow(ll_job,dw_3)
	End If
End If

If cbx_track.Checked = true then
	SetPointer(Hourglass!)
	li_count = 	fx_print_track()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Track Data')
	Else
		PrintDataWindow(ll_job,dw_3)
	End If
End If

If cbx_track_log.Checked = true then
	SetPointer(Hourglass!)
	li_count =	fx_print_track_log()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Track Log Data')
	Else
		PrintDataWindow(ll_job,dw_3)
	End If
End If

COMMIT using Stars2ca;
If stars2ca.of_check_status() <> 0 Then  //VAV 4.0 2/17/98
	MessageBox('EDIT','Error Commiting to Stars2')
	Return
End If	
PrintClose(ll_job)

//NLG 10-06-99 Moved from above
If cbx_notes.Checked = true then
	SetPointer(hourglass!)
	li_count =	fx_print_notes()
	If li_count = -1 then
		SetMicroHelp(w_main,'Error Printing Case Notes Data')
	END IF
	//nlg ts2443c stop                         ************
End If

SetMicroHelp(w_main,'Print Completed')
end event

type cbx_criteria from checkbox within w_case_print
boolean visible = false
string accessiblename = "Criteria Used"
string accessibledescription = "Criteria Used"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 2016
integer y = 320
integer width = 485
integer height = 80
integer taborder = 130
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Criteria Used"
end type

type cbx_leads from checkbox within w_case_print
string accessiblename = "Leads"
string accessibledescription = "Leads"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1111
integer y = 236
integer width = 375
integer height = 72
integer taborder = 90
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Leads"
end type

event clicked;//String lv_case_id,lv_case_spl,lv_case_ver  //VAV 4.0 2/18/98
int li_count
 
SetPointer(hourglass!)
SetMicroHelp(w_main,'Ready')
If this.Checked = False then
	RETURN
End If

SetFocus(sle_case_id)
If sle_case_id.Text = '' then
	this.Checked     = false
	MessageBox('EDIT','Enter Case Id')
	RETURN
End IF

//VAV 4.0 2/18/98 - using instance variables now
//lv_case_id = left(sle_case_id.text,10)
//lv_case_spl = mid(sle_case_id.text,11,2)
//lv_case_ver = mid(sle_case_id.text,13,2)

select count(*) into :li_count
	from lead
	where case_id =  Upper( :is_case_id ) and
			case_spl = Upper( :is_case_spl ) and
			case_ver = Upper( :is_case_ver )
Using Stars2ca;

If stars2ca.of_check_status() <> 0 then
	this.checked = false
	Errorbox(stars2ca,'Error Reading Lead Table')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	MessageBox('EDIT','Error Commiting to Stars2')
	RETURN
End If	
If li_count <= 0 then
	this.Checked = false
	SetMicroHelp(w_main,'No Leads for this Case')
	RETURN
End If


end event

type cbx_notes from checkbox within w_case_print
string accessiblename = "Notes"
string accessibledescription = "Notes"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1111
integer y = 144
integer width = 375
integer height = 72
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Notes"
end type

event clicked;String lv_case_id,lv_case_spl,lv_case_ver
int lv_count

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If this.checked = False then
	RETURN
End If

setfocus(sle_case_id)
If sle_case_id.text = '' then
	this.checked     = false
	Messagebox('EDIT','Enter Case Id')
	RETURN
End IF

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

select count(*) into :lv_count
	from Notes
	where Note_rel_type = 'CA' and note_rel_id = Upper( :sle_case_id.text )
Using Stars2ca;

If stars2ca.of_check_status() <> 0 then
	this.checked = false
	Errorbox(stars2ca,'Error Reading Notes Table')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
If lv_count <= 0 then
	this.checked = false
	setmicrohelp(w_main,'No Notes for this Case')
	RETURN
End If


end event

type cbx_target from checkbox within w_case_print
string accessiblename = "Target"
string accessibledescription = "Target"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1111
integer y = 324
integer width = 393
integer height = 76
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Target"
end type

event clicked;String lv_case_id,lv_case_spl,lv_case_ver
int lv_count

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If this.checked = False then
	RETURN
End If

setfocus(sle_case_id)
If sle_case_id.text = '' then
	this.checked     = false
	Messagebox('EDIT','Enter Case Id')
	RETURN
End IF

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

select count(*) into :lv_count
	from target
	where case_id = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using Stars2ca;

If stars2ca.of_check_status() <> 0 then
	this.checked = false
	Errorbox(stars2ca,'Error Reading Target Table')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
If lv_count <= 0 then
	this.checked = false
	cbx_track.checked = false
	cbx_track_log.checked = false
//	cbx_track_link.checked = false    //VAV 4.0 2/17/98
	setmicrohelp(w_main,'No Targets for this Case')
	RETURN
End If


end event

type cbx_track_log from checkbox within w_case_print
string accessiblename = "Track Log"
string accessibledescription = "Track Log"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 2016
integer y = 236
integer width = 411
integer height = 72
integer taborder = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Track Log"
end type

event clicked;String lv_case_id,lv_case_spl,lv_case_ver
int lv_count

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If this.checked = False then
	RETURN
End If

setfocus(sle_case_id)
If sle_case_id.text = '' then
	this.checked     = false
	Messagebox('EDIT','Enter Case Id')
	RETURN
End IF

//reset(dw_2)								//VAV 4.0 2/17/98
//ST_row_count2.text = ''   			//VAV 4.0 2/17/98
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

select count(*) into :lv_count
	from track
	where case_id = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using Stars2ca;

If stars2ca.of_check_status() <> 0 then
	this.checked = false
	Errorbox(stars2ca,'Error Reading Track Table')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
If lv_count <= 0 then
	this.checked = false
	cbx_track.checked = false
//	cbx_track_link.checked = false			//VAV 4.0 2/17/98
	setmicrohelp(w_main,'No Tracks for this Case')
	RETURN
End If


end event

type cbx_track from checkbox within w_case_print
string accessiblename = "Track"
string accessibledescription = "Track"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 2016
integer y = 144
integer width = 375
integer height = 72
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Track"
end type

event clicked;String lv_case_id,lv_case_spl,lv_case_ver
int lv_count

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If this.checked = False then
	RETURN
End If

setfocus(sle_case_id)
If sle_case_id.text = '' then
	this.checked     = false
	Messagebox('EDIT','Enter Case Id')
	RETURN
End IF

//reset(dw_2)						//VAV 4.0 2/17/98
//ST_row_count2.text = ''		//VAV 4.0 2/17/98
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

select count(*) into :lv_count
	from track
	where case_id = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using Stars2ca;

If stars2ca.of_check_status() <> 0 then
	this.checked = false
	Errorbox(stars2ca,'Error Reading Track Table')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
If lv_count <= 0 then
	this.checked = false
	cbx_track_log.checked = false
//	cbx_track_link.checked = false		//VAV 4.0 2/17/98
	setmicrohelp(w_main,'No Tracks for this Case')
	RETURN
End If


end event

type cbx_case_link from checkbox within w_case_print
string accessiblename = "Case Link"
string accessibledescription = "Case Link"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 128
integer y = 324
integer width = 416
integer height = 72
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Case Link"
end type

event clicked;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.

String lv_case_id,lv_case_spl,lv_case_ver
String lv_value
Int	 lv_sub,	li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

Setfocus(sle_case_id)
CBX_CRITERIA.CHECKED = FALSE
CBX_CRITERIA.VISIBLE = FALSE
reset(dw_1)
ST_row_count1.text = ''

If this.checked = False then
	RETURN
End If

If sle_case_id.text = '' then
	this.checked     = false
	Messagebox('EDIT','Enter Case Id')
	RETURN
End IF

If fw_case_security() <> 0 then     //alabama2 pat-d
	this.checked = false             //alabama2 pat-d
	return                           //alabama2 pat-d 
End IF                              //alabama2 pat-d

lv_case_id  = Trim (left(sle_case_id.text,10) )		// FDG 04/16/01
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 - end

If Settransobject(dw_1,Stars2ca) < 0 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	Messagebox('EDIT','Error Setting Transaction Object for Case Link')
	RETURN
End IF

St_row_count1.text = string(retrieve(dw_1,lv_case_id,lv_case_spl,lv_case_ver))

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
If integer(st_row_count1.text) < 0 then
	ST_ROW_COUNT1.TEXT = ''
	this.checked = false
	Messagebox('EDIT','Error Retrieving Data for Case Link')
	RETURN
Elseif integer(st_row_count1.text) = 0 then
		 ST_ROW_COUNT1.TEXT = ''
		 this.checked = false
		 setmicrohelp(w_main,'Nothing Has Been linked to this Case')
		 RETURN
End IF

For lv_sub = 1 to integer(st_row_count1.text)
	 LV_VALUE = getitemstring(dw_1,lv_sub,4)
	 If LV_VALUE  = 'SUB'  or lv_value = 'CRC' OR LV_VALUE = 'CRI' OR &
			LV_VALUE = 'ARC' OR LV_VALUE = 'CRA' then //OR LV_VALUE = 'SMP' //VAV 4.0 2/17/98
		 cbx_criteria.visible = true
		 EXIT
	 End If
Next
setpointer(arrow!)
end event

type cbx_case_log from checkbox within w_case_print
string accessiblename = "Case Log"
string accessibledescription = "Case Log"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 128
integer y = 236
integer width = 398
integer height = 72
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Case Log"
end type

type cbx_case from checkbox within w_case_print
string accessiblename = "Case"
string accessibledescription = "Case"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 128
integer y = 144
integer width = 251
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Case"
end type

on clicked;If cbx_case.checked then
	If sle_case_id.text = '' then
		fx_reset_cbx()
		Messagebox('EDIT','Enter Case Id')
		RETURN
	End IF
End If

end on

type st_case_id from statictext within w_case_print
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 178
integer y = 52
integer width = 265
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Case ID:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_case_id from singlelineedit within w_case_print
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = textrole!
integer x = 489
integer y = 40
integer width = 736
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 14
borderstyle borderstyle = stylelowered!
end type

on modified;Setpointer(hourglass!)
setmicrohelp(w_main,'')
fx_reset_cbx()
If sle_case_id.text <> '' then         //alabama2 pat-d
	If fw_case_security() <> 0 then     //alabama2 pat-d
		return                           //alabama2 pat-d 
	End IF                              //alabama2 pat-d
End IF                                 //alabama2 pat-d
setpointer(arrow!)
end on

type dw_3 from u_dw within w_case_print
boolean visible = false
string accessiblename = "Case List"
string accessibledescription = "Case List"
accessiblerole accessiblerole = clientrole!
integer x = 110
integer y = 324
integer width = 2542
integer height = 504
integer taborder = 10
string dataobject = "d_case_print"
boolean hscrollbar = true
boolean vscrollbar = true
end type

on retrieveend;setpointer(hourglass!)
end on

on retrievestart;setpointer(hourglass!)
end on

type dw_4 from u_dw within w_case_print
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer y = 688
integer width = 2610
integer height = 288
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

on retrievestart;setpointer(hourglass!)
end on

on retrieveend;setpointer(hourglass!)
end on

type gb_1 from groupbox within w_case_print
boolean visible = false
string accessiblename = "Selection Options"
string accessibledescription = "Selection Options"
accessiblerole accessiblerole = groupingrole!
integer x = 434
integer y = 1424
integer width = 768
integer height = 128
integer taborder = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
end type

type rte_text from u_rte within w_case_print
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
long backcolor = 1073741824
accessiblerole accessiblerole = textrole!
integer x = 750
integer y = 1448
integer width = 498
integer height = 96
integer taborder = 30
boolean bringtotop = true
long init_backcolor = 1090519039
boolean init_wordwrap = true
long init_leftmargin = 1000
long init_topmargin = 1000
long init_rightmargin = 1000
long init_bottommargin = 1000
end type

on rte_text.create
call super::create
BackColor=1090519039
end on

