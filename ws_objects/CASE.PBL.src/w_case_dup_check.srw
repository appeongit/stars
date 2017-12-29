$PBExportHeader$w_case_dup_check.srw
$PBExportComments$Response Window - Displays Duplicate Tracks and associated Case (inherited from w_master)
forward
global type w_case_dup_check from w_master
end type
type cb_print from u_cb within w_case_dup_check
end type
type cb_save_rpt from u_cb within w_case_dup_check
end type
type cb_stop from u_cb within w_case_dup_check
end type
type cb_view from u_cb within w_case_dup_check
end type
type st_row_count from statictext within w_case_dup_check
end type
type st_4 from statictext within w_case_dup_check
end type
type sle_track_type from singlelineedit within w_case_dup_check
end type
type st_3 from statictext within w_case_dup_check
end type
type st_2 from statictext within w_case_dup_check
end type
type sle_target_name from singlelineedit within w_case_dup_check
end type
type sle_subset_id from singlelineedit within w_case_dup_check
end type
type sle_case_id from singlelineedit within w_case_dup_check
end type
type st_1 from statictext within w_case_dup_check
end type
type cb_close from u_cb within w_case_dup_check
end type
type cb_save from u_cb within w_case_dup_check
end type
type cb_delete from u_cb within w_case_dup_check
end type
type cb_override from u_cb within w_case_dup_check
end type
type dw_1 from u_dw within w_case_dup_check
end type
end forward

global type w_case_dup_check from w_master
string accessiblename = "Case Track Duplicate Check"
string accessibledescription = "Case Track Duplicate Check"
accessiblerole accessiblerole = windowrole!
integer x = 165
integer y = 148
integer height = 1688
string title = "Case Track Duplicate Check"
windowtype windowtype = response!
long backcolor = 67108864
event ue_edit_case_closed ( )
cb_print cb_print
cb_save_rpt cb_save_rpt
cb_stop cb_stop
cb_view cb_view
st_row_count st_row_count
st_4 st_4
sle_track_type sle_track_type
st_3 st_3
st_2 st_2
sle_target_name sle_target_name
sle_subset_id sle_subset_id
sle_case_id sle_case_id
st_1 st_1
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_override cb_override
dw_1 dw_1
end type
global w_case_dup_check w_case_dup_check

type variables
string in_case
Boolean In_cancel

// message.stringparm
String	is_message

// Stars 4.8 - Case NVO
n_cst_case	inv_case

end variables

event ue_edit_case_closed;//*******************************************************************
//	Script			ue_edit_case_closed
//
//
//	Description		Prevent updating this window if the case is closed
//						or deleted.
//
//
//*******************************************************************
//	09/21/01	FDG	Stars 4.8.	Created
//*******************************************************************
Boolean		lb_valid_case

lb_valid_case	=	inv_case.uf_edit_case_closed (gv_active_case)

IF	lb_valid_case	=	FALSE		THEN
	cb_delete.enabled			=	FALSE
	cb_override.enabled		=	FALSE
	cb_save.enabled			=	FALSE
	cb_save_rpt.enabled		=	FALSE
END IF

end event

event open;call super::open;//**********************************************************
//03-04-98 ajs 4.0 TS145 - globals
//01-22-98 NLG 4.0 Subset Redesign
//				1. Remove code for splitting tracks
//				2. Subset Id holds external subset id.  Use NVO to retrieve internal id
//10-20-95 FNC Take out connects and disconnects
//08-31-98 NLG FS362 convert case to case_cntl
//	09/21/01	FDG	Stars 4.8.1.	No updates can occur if the case is closed
// JasonS 10/24/02 Track 4055c call n_cst_labels
//**********************************************************
STRING lv_sql_statement,lv_split_sql_1
String lv_case_id,lv_case_Id_spl,lv_case_id_ver
int lv_pos
sx_subset_ids lstr_subset_ids
nvo_subset_functions lnv_subset_functions
long ll_rows
string ls_subset_id
n_cst_labels lnv_labels		// JasonS 10/24/02 Track 4055c


setmicrohelp(w_main,'Ready')
setpointer(hourglass!)
//fx_set_window_colors(w_case_dup_check)

// FDG 09/21/01
inv_case	=	CREATE	n_cst_case

//1-22-98 NLG 4.0 Remove code for split
////Coming in through Splitting Tracks
//If left(is_message,1) = '~~' then
//	is_message = mid(is_message,2)
//	cb_close.enabled = false
//	cb_delete.enabled = false
//End IF

If is_message = 'PV' or &
	is_message = 'PC' or &
	is_message = 'BE'  then
	sle_track_type.text = is_message
End IF


//sle_case_id.text   = gv_case_active		//ajs 4.0 03-04-98 globals
sle_case_id.text   = gv_active_case		//ajs 4.0 03-04-98 globals 
//sle_subset_id.text = gv_case_subset    01-22-98 NLG 4.0 display subset name rather than id
sle_target_name.text  = gv_case_target


lv_sql_statement = dw_1.getsqlselect()
//Messagebox('Info',lv_sql_statement)
lv_pos = pos(lv_sql_statement,'~'XXXYYYZZZ~'')
If lv_pos <= 0 then
	Messagebox('ERROR','Unable to Set Targets for Datawindow')
	cb_close.PostEvent(Clicked!)
	RETURN
End If

lv_split_sql_1 = left(lv_sql_statement,(lv_pos - 1))
lv_sql_statement = lv_split_sql_1 + gv_case_dup_ids + ') )'
//Messagebox('Info',lv_sql_statement)
lv_pos = dw_1.setsqlselect(lv_sql_statement)

//lv_case_id = left(gv_case_active,10)				//ajs 4.0 03-04-98
//lv_case_id_spl = mid(gv_case_active,11,2)		//ajs 4.0 03-04-98
//lv_case_id_ver = mid(gv_case_active,13,2)		//ajs 4.0 03-04-98
lv_case_id = left(gv_active_case,10)				//ajs 4.0 03-04-98
lv_case_id_spl = mid(gv_active_case,11,2)			//ajs 4.0 03-04-98
lv_case_id_ver = mid(gv_active_case,13,2)			//ajs 4.0 03-04-98

// FDG 09/21/01 - No updates can occur if the case is closed/deleted
This.Event	ue_edit_case_closed()

//NLG 6-29-98 Track #1450 If track attached to subset, lookup external subset id
if trim(gv_target_subset_id) <> "" then 
	//01-22-98 NLG 4.0 Call nvo to get external subset id
	//create the nonvisualobject
	lnv_subset_functions = create nvo_subset_functions
	//load the subset id structure
	//lstr_subset_ids.subset_id = gv_case_subset		//ajs 4.0 03-04-98
	lstr_subset_ids.subset_id = gv_target_subset_id		//ajs 4.0 03-04-98
	lstr_subset_ids.subset_case_id = lv_case_id
	lstr_subset_ids.subset_case_spl = lv_case_id_spl
	lstr_subset_ids.subset_case_ver = lv_case_id_ver
	//Pass the structure to the nvo
	lnv_subset_functions.uf_set_structure(lstr_subset_ids)
	LL_rows = Lnv_Subset_Functions.UF_Retrieve_Subset_name()
	If ll_rows = 1 then
		Lstr_subset_ids = LNV_Subset_Functions.UF_Get_Structure()
		sle_subset_id.text = lstr_Subset_ids.subset_name //01-22-98 NLG 4.0 display subset name
	Else
		Messagebox('ERROR','Cannot retrieve subset id.') 
	End if
End if//NLG 6-29-98 Track #1450	


Select case_trk_type into :sle_track_type.text 
	from case_cntl						//08-31-98 NLG FS362 convert case to case_cntl
  where case_id  = Upper( :lv_case_id ) and 
		  case_spl = Upper( :lv_case_id_spl ) and 
		  case_ver = Upper( :lv_case_id_ver )
using stars2ca;
If stars2ca.of_check_status() < 0 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in open')
   end if                             //10-20-95 FNC End
	Messagebox('ERROR','Dupes Exist - Unable to read Case Control Table')
	RETURN
End If

If SetTransObject(dw_1,stars2ca) < 0 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in open')
   end if                             //10-20-95 FNC End
	Messagebox('ERROR','Dupes Exist - Unable to Set Transaction Object')
	RETURN
End If
show(this)
st_row_count.text = string(RETRIEVE(DW_1))
If left(is_message,1) = '~~' then
	cb_close.enabled = false
	cb_delete.enabled = false
End IF

// JasonS 10/24/02 Begin - Track 4055c
lnv_labels = create n_cst_labels
lnv_labels.of_setdw(dw_1)
lnv_labels.of_trk_info_width( is_message )
// JasonS 10/24/02 End - Track 4055c

If long(st_row_count.text) <= 0 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in open')
   end if                             //10-20-95 FNC End
	Messagebox('ERROR','Dupes Exist - Unable to Retrieve from Database')
	RETURN
End If

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in open')
   return
end if                             //10-20-95 FNC End

destroy lnv_labels	// JasonS 10/24/02 Track 4055c
end event

event close;call super::close;//******************************************************************************
//	09/21/01	FDG	Stars 4.8.1.	Destroy inv_case
//******************************************************************************

If isvalid(w_case_maint_dup) then close(w_case_maint_dup)

// FDG 09/21/01
IF	IsValid (inv_case)		THEN
	destroy	inv_case
END IF

end event

on w_case_dup_check.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_save_rpt=create cb_save_rpt
this.cb_stop=create cb_stop
this.cb_view=create cb_view
this.st_row_count=create st_row_count
this.st_4=create st_4
this.sle_track_type=create sle_track_type
this.st_3=create st_3
this.st_2=create st_2
this.sle_target_name=create sle_target_name
this.sle_subset_id=create sle_subset_id
this.sle_case_id=create sle_case_id
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_override=create cb_override
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_save_rpt
this.Control[iCurrent+3]=this.cb_stop
this.Control[iCurrent+4]=this.cb_view
this.Control[iCurrent+5]=this.st_row_count
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.sle_track_type
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.sle_target_name
this.Control[iCurrent+11]=this.sle_subset_id
this.Control[iCurrent+12]=this.sle_case_id
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.cb_save
this.Control[iCurrent+16]=this.cb_delete
this.Control[iCurrent+17]=this.cb_override
this.Control[iCurrent+18]=this.dw_1
end on

on w_case_dup_check.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_save_rpt)
destroy(this.cb_stop)
destroy(this.cb_view)
destroy(this.st_row_count)
destroy(this.st_4)
destroy(this.sle_track_type)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_target_name)
destroy(this.sle_subset_id)
destroy(this.sle_case_id)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_override)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;is_message = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type cb_print from u_cb within w_case_dup_check
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2066
integer y = 1416
integer width = 306
integer height = 108
integer taborder = 70
string text = "&Print"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
print(dw_1)

end on

type cb_save_rpt from u_cb within w_case_dup_check
string accessiblename = "Save As Rpt"
string accessibledescription = "Save As Rpt"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1664
integer y = 1416
integer width = 384
integer height = 108
integer taborder = 60
string text = "Save As &Rpt"
end type

event clicked;///////////////////////////////////////////////////////////////////////
//
// AJS	03-04-98	4.0 TS145 - Globals
//	JGG	02/28/98	STARS 4.0 - added new case link columns
//	GaryR	01/09/01	Stars 4.7 DataBase Port - Empty String in SQL
//	GaryR	03/15/01	Stars 4.7 DataBase Port - Case Sensitivity
//	FDG	10/10/01	Stars 4.8.1.  Do not allow if case is closed.
//						Create a case_log entry.
//	GaryR	05/07/03	Track 3560d	Move save logic back to this caller
//	GaryR	05/04/04	Track 3544d	Redesign report save/view logic to improve performance
//	GaryR	06/17/04	Track 3544d	Do not save report if rowcount is 0
//
///////////////////////////////////////////////////////////////////////

String		ls_save_name
DateTime		ldtm_curr_datetime		// Track 2946d
String		ls_case_id
String		ls_case_spl
String		ls_case_ver
String		ls_case_link = "RPT"
String		ls_link_desc
String		ls_report			// Track 2946d
int			li_upper
int			li_control
int			li_rc
sx_query_save lsx_query_save 			// Track 2946d
n_cst_case	lnv_case
n_cst_report	lnv_report
String		ls_message
lnv_case		=	CREATE	n_cst_case

// Check if rows exist
IF dw_1.RowCount() < 1 THEN
	MessageBox( "Report Save", "Current report does not contain any data to save.", StopSign! )
	Return 1
END IF

// Save dw and link to active case
MDI_main_frame.SetMicroHelp('Saving Report to Database')
SetPointer(HourGlass!)

ls_save_name = fx_get_next_key_id('REPORT')
if (ls_save_name = 'ERROR') then ls_save_name = ''

// Begin - Track 2946d
lsx_query_save.query_id = ls_save_name
ls_report = ls_save_name
lsx_query_save.query_name = ls_report
ldtm_curr_datetime = gnv_app.of_get_server_date_time()

ls_case_link = "RPT"
lsx_query_save.query_desc = "Report saved on " + string(ldtm_curr_datetime) + " by " + gc_user_id

lsx_query_save.query_type = ls_case_link
lsx_query_save.link_type = ls_case_link
lsx_query_save.path = "R"

openwithparm(w_query_save, lsx_query_save)
lsx_query_save = message.powerobjectparm

ls_report = lsx_query_save.query_name
ls_link_desc = lsx_query_save.query_desc
ls_case_id = lsx_query_save.case_id
ls_case_spl  = Mid(ls_case_id,11,2)      
ls_case_ver  = Mid(ls_case_id,13,2)
  
if (lsx_query_save.path = "N") then
	MDI_main_frame.SetMicroHelp('Report save cancelled.')
	Return 0	// JasonS 08/09/02  Track 3220d
end if
// End - Track 2946d

IF lnv_report.of_save( dw_1, ls_save_name, ldtm_curr_datetime ) > 0 THEN  
  ls_message	=	"Report "	+	ls_report	+	" added to case."
  li_rc			=	lnv_case.uf_audit_log (ls_case_id, ls_message)
  // End - Track 2946d
  IF	li_rc		<	0		THEN
		Stars2ca.of_rollback()
		MessageBox ('Database Error', 'Could not insert case log for report '	+	ls_report	+	&
						'.  Case: ' + ls_case_id + '. Script: '		+	&
						'fx_m_save()')
		// End - Track 2946d
		IF IsValid(lnv_case)		THEN	Destroy	lnv_case		// FDG 12/21/01
		Return -1	// JasonS 08/09/02  Track 3220d
  END IF

	IF IsValid(lnv_case)		THEN	Destroy	lnv_case
	
	// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
	li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
	li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
	// FDG 04/16/01 - end
	
// JasonS 07/16/02 	Begin - Track 3198d
	ls_case_id   = Mid(gv_active_case,1,10)
	ls_case_spl  = Mid(gv_active_case,11,2)
	ls_case_ver  = Mid(gv_active_case,13,2)
// JasonS 07/16/02	End - Track 3198d		

  INSERT INTO CASE_LINK
	 (CASE_ID,     CASE_SPL,      CASE_VER,    LINK_TYPE,    LINK_KEY, &
	  LINK_NAME,   LINK_DESC,     USER_ID,     LINK_DATE,    LINK_STATUS)
  VALUES
	 (:ls_case_id,   :ls_case_spl,     :ls_case_ver,   :ls_case_link,    :ls_save_name,	&
	  Upper( :ls_report ), :ls_link_desc, :gc_user_id, :ldtm_curr_datetime, 'A')	// 01/11/01	GaryR	Stars 4.7 DataBase Port
  USING Stars2CA;																					// 03/15/01	GaryR	Stars 4.7 DataBase Port

  if (Stars2CA.of_check_status() <> 0) then
	  ErrorBox(Stars2CA,'Could NOT update case link information.')
	  lnv_report.of_delete( ls_save_name, "" )
	  return -1	// JasonS 08/09/02  Track 3220d
  end if

	Stars2CA.of_commit()

  //MDI_main_frame.SetMicroHelp('Report successfully saved to DataBase as ' + ls_save_name)    Track 2946d
  MDI_main_frame.SetMicroHelp('Report successfully saved to DataBase as ' + ls_report)		// Track 2946d
else
  MDI_main_frame.SetMicroHelp('Report save Cancelled as requested')
end if

return 1 // JasonS 08/09/02  Track 3220d
end event

on getfocus;setmicrohelp(w_main,'Saves the Datawindow as a Report')
end on

type cb_stop from u_cb within w_case_dup_check
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2414
integer y = 1512
integer width = 247
integer height = 104
integer taborder = 90
integer textsize = -16
boolean enabled = false
string text = "&Stop"
end type

type cb_view from u_cb within w_case_dup_check
string accessiblename = "View "
string accessibledescription = "View "
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1339
integer y = 1416
integer width = 306
integer height = 108
integer taborder = 50
integer textsize = -16
string text = "&View "
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If in_case = '' then 
	Messagebox('EDIT','Must Select the Case to View')
Else
	openwithparm(w_case_maint_dup,in_case)
//	w_case_maint_dup.x = 1
//	w_case_maint_dup.y = 1
End If
end on

on getfocus;setmicrohelp(w_main,'View the Highlighted Case')
end on

type st_row_count from statictext within w_case_dup_check
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 32
integer y = 1428
integer width = 274
integer height = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_case_dup_check
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = statictextrole!
integer x = 2016
integer y = 4
integer width = 352
integer height = 64
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Track Type"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_track_type from singlelineedit within w_case_dup_check
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 2057
integer y = 80
integer width = 215
integer height = 88
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_case_dup_check
string accessiblename = "Target ID"
string accessibledescription = "Target ID"
accessiblerole accessiblerole = statictextrole!
integer x = 645
integer y = 8
integer width = 302
integer height = 64
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Target ID"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_case_dup_check
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1193
integer y = 8
integer width = 329
integer height = 64
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_target_name from singlelineedit within w_case_dup_check
string accessiblename = "Target Name"
string accessibledescription = "Target Name"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 654
integer y = 80
integer width = 471
integer height = 88
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_subset_id from singlelineedit within w_case_dup_check
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 1193
integer y = 80
integer width = 800
integer height = 88
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
integer limit = 20
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_case_id from singlelineedit within w_case_dup_check
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 37
integer y = 80
integer width = 562
integer height = 88
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_case_dup_check
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 8
integer width = 256
integer height = 60
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Case ID"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_case_dup_check
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2391
integer y = 1416
integer width = 306
integer height = 108
integer taborder = 80
integer textsize = -16
string text = "&Close"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
gv_result = 0
close(W_CASE_DUP_CHECK)
end on

type cb_save from u_cb within w_case_dup_check
string accessiblename = "Save"
string accessibledescription = "Save"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1015
integer y = 1416
integer width = 306
integer height = 108
integer taborder = 40
integer textsize = -16
string text = "&Save"
end type

event clicked;//***************************************************************
//10-20-95 FNC Take out connects and disconnects
//***************************************************************
//A return of 999 says the tracks should be closed not the case
//A return of 900 says the tracks and case should be closed
//If there are any open tracks with the case then only the current tracks 
//   will be closed and the case is left open.  Otherwise everything is closed

Int  Lv_count
string lv_case_id,lv_case_spl,lv_case_ver

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

//This is a response window and a connection does exist at this point	
//to Stars2ca
gv_result = 999

Select count(*) into :lv_count
	from Track
	where case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver ) and
			status   <> 'CL'
Using Stars2ca;

If Stars2ca.of_check_status() <> 0 then
	Messagebox('EDIT','Unable to Check Open Tracks, Case will be left Open')
Elseif lv_count  = 0 then
		 gv_result = 900
End IF

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in cb_save')
end if                             //10-20-95 FNC End
close(W_CASE_DUP_CHECK)

end event

on getfocus;setmicrohelp(w_main,'Creates Tracking with a Closed Status')
end on

type cb_delete from u_cb within w_case_dup_check
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 690
integer y = 1416
integer width = 306
integer height = 108
integer taborder = 30
integer textsize = -16
string text = "&Delete"
end type

on clicked;Integer lv_ret

Setpointer(hourglass!)
setmicrohelp(w_main,'Everything Associated With Case Will Also Be Deleted')
lv_ret = Messagebox('CONFIRM','Proceed with Deleting This Case',Question!,YesNo!,2)
setmicrohelp(w_main,'Ready')
If lv_ret = 2 then Return

gv_result = 100
close(W_CASE_DUP_CHECK)
end on

on getfocus;setmicrohelp(w_main,'Deletes the Entire Case')
end on

type cb_override from u_cb within w_case_dup_check
string accessiblename = "Override"
string accessibledescription = "Override"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 366
integer y = 1416
integer width = 306
integer height = 108
integer taborder = 20
integer textsize = -16
string text = "&Override"
boolean default = true
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
gv_result = 102
close(W_CASE_DUP_CHECK)
end on

on getfocus;SETMICROHELP(W_MAIN,'Creates the tracking')
end on

type dw_1 from u_dw within w_case_dup_check
string accessiblename = "Case Duplicate Check"
string accessibledescription = "Case Duplicate Check"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title =Duplicate Tracking by Case"
integer x = 18
integer y = 184
integer width = 2674
integer height = 1208
integer taborder = 10
string dataobject = "d_case_dup_check_prov"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

on retrievestart;setmicrohelp(w_main,'Ready')
setpointer(hourglass!)

in_cancel = false
//Parent.controlmenu = False							//FDG 06/13/96
cb_stop.enabled = true
cb_override.enabled = false
cb_save.enabled = false
cb_delete.enabled = false
cb_close.enabled = false
cb_save_rpt.enabled = false
cb_print.enabled = false
cb_view.enabled = false






end on

event retrieverow;string last_row

setmicrohelp(w_main,'Ready')
setpointer(hourglass!)
last_row = Describe(dw_1,'datawindow.LastRowOnPage')
If dw_1.rowcount() <= integer(last_row) then
	dw_1.ScrollNextRow()
End If
If isvalid(cb_stop) then
	st_row_count.text = string(dw_1.rowcount())
End If
If in_cancel = true then
	Return 1
END IF



end event

on retrieveend;setmicrohelp(w_main,'Ready')
setpointer(hourglass!)

//If gv_from <> 'u' then								//FDG 06/13/96
//	Parent.controlmenu = true							//FDG 06/13/96
//End If														//FDG 06/13/96

cb_stop.enabled = false
cb_override.enabled = true
cb_save.enabled = true
cb_delete.enabled = true
cb_close.enabled = true
cb_save_rpt.enabled = true
cb_print.enabled = true
cb_view.enabled =  true

in_cancel = true
triggerevent(dw_1,rowfocuschanged!)




end on

on rowfocuschanged;long lv_row_nbr

setmicrohelp(w_main,'Ready')
setpointer(hourglass!)
If not in_cancel then RETURN 
lv_row_nbr = getrow(dw_1)
If lv_row_nbr = 0 then 
	 cb_view.enabled = false
	 in_case = ''
    RETURN
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

in_case =   getitemstring(dw_1,lv_row_nbr,3) + &
			   getitemstring(dw_1,lv_row_nbr,4) + &
				getitemstring(dw_1,lv_row_nbr,5)

end on

event doubleclicked;long lv_row_nbr

setmicrohelp(w_main,'Ready')
setpointer(hourglass!)
If not in_cancel then RETURN
lv_row_nbr = row
If lv_row_nbr = 0 then 
    selectrow(dw_1,0,false)
	 cb_view.enabled = false
	 in_case = ''
    RETURN
Else
	 cb_view.enabled = true
End If
selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)
in_case =   getitemstring(dw_1,lv_row_nbr,3) + &
			   getitemstring(dw_1,lv_row_nbr,4) + &
				getitemstring(dw_1,lv_row_nbr,5)

Triggerevent(cb_view,Clicked!)


end event

event constructor;call super::constructor;// FDG 11/27/00	Stars 4.7.  Get the DBMS-specific version of the d/w object
This.of_set_dw_dbms()

end event

