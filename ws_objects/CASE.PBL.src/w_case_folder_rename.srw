$PBExportHeader$w_case_folder_rename.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_folder_rename from w_master
end type
type sle_new_id from singlelineedit within w_case_folder_rename
end type
type st_2 from statictext within w_case_folder_rename
end type
type st_1 from statictext within w_case_folder_rename
end type
type cb_cancel from u_cb within w_case_folder_rename
end type
type cb_ok from u_cb within w_case_folder_rename
end type
end forward

global type w_case_folder_rename from w_master
string accessiblename = "Rename"
string accessibledescription = "Rename"
accessiblerole accessiblerole = windowrole!
integer y = 604
integer width = 1230
integer height = 648
string title = "Rename"
windowtype windowtype = response!
long backcolor = 67108864
sle_new_id sle_new_id
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_case_folder_rename w_case_folder_rename

type variables
sx_case_link_info istr_case_link_info
end variables

forward prototypes
public function integer wf_rename_case_criteria (string lv_old_id, string lv_new_id, string lv_link_type)
end prototypes

public function integer wf_rename_case_criteria (string lv_old_id, string lv_new_id, string lv_link_type);/////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	09/23/98	Track 1794.  Remove tables anal_crit_col,
//						anal_crit_from_tbls, anal_crit_grp, anal_crit_stack.
//
//
/////////////////////////////////////////////////////////////////////


If lv_link_type = 'CRA' then
   Update Anal_crit_cntl
   set crit_id = :lv_new_id
	where crit_id  = Upper( :lv_old_id )
   Using stars2ca;
   if Stars2ca.of_check_status() <> 0 then
	  Errorbox(Stars2ca,'Error Renaming Analysis Criteria Control Table')
	  RETURN -1
   End If

// FDG 09/23/98 begin
//   Update Anal_crit_col
//   set crit_id = :lv_new_id
//	where crit_id  = :lv_old_id
//   Using stars2ca;
//   if Stars2ca.of_check_status() <> 0 then
//      Errorbox(Stars2ca,'Error Renaming Analysis Criteria Col Table')
//		RETURN -1
//   End If
// FDG 09/23/98 end

   Update Anal_crit_line
   set crit_id = :lv_new_id
   where crit_id  = Upper( :lv_old_id )
   Using stars2ca;
   if Stars2ca.of_check_status() <> 0 then
		 Errorbox(Stars2ca,'Error Renaming Analysis Criteria Line Table')
		 RETURN -1
   End If

// FDG 09/23/98 begin
//   Update Anal_crit_grp
//   set crit_id = :lv_new_id
//	where crit_id  = :lv_old_id
//   Using stars2ca;
//   if Stars2ca.of_check_status() <> 0 then
//		Errorbox(Stars2ca,'Error Renaming Analysis Criteria Grp Table')
//		RETURN -1
//   End If
// FDG 09/23/98 end

   Update Anal_crit_sort
   set crit_id = :lv_new_id
   where crit_id  = Upper( :lv_old_id )
   Using stars2ca;
   if Stars2ca.of_check_status() <> 0 then
		 Errorbox(Stars2ca,'Error Renaming Analysis Criteria Sort Table')
		 RETURN -1
   End If
End if


If lv_link_type = 'CRC' then
	Update Criteria_Used
      set by_id = :lv_new_id
		where by_id = Upper( :lv_old_id ) and by_type = 'CRI'
	Using stars2ca;
	If Stars2ca.of_check_status() <> 0 then
		 Errorbox(Stars2ca,'Error Renaming Criteria Table')
		 RETURN -1
	End If
	Update Criteria_from_tbls_Used
      set by_id = :lv_new_id
		where by_id = Upper( :lv_old_id ) and by_type = 'CRI'
	Using stars2ca;
   if Stars2ca.of_check_status() <> 0 then
	   Errorbox(Stars2ca,'Error Renaming Criteria From Table')
		RETURN -1
	End If
	Update Criteria_Used_line
   set by_id = :lv_new_id
	where by_id = Upper( :lv_old_id ) and by_type = 'CRI'
	Using stars2ca;
	if Stars2ca.of_check_status() <> 0 then
		Errorbox(Stars2ca,'Error Renaming Criteria Line Table')
		RETURN -1
	End If
End If

setmicrohelp(w_main,'Link Has Been Removed')
Return 0

end function

event open;call super::open;//*********************************************************************************
//Modifications
//
//	01/09/98 NLG	4.0 	Subset Redesign ts145-rename.doc
//						New Id expanded to 20 positions for subsets and PDQs
//	07/13/98 AJS	4.0   Change to use structure passed in Track 1451
//	11/01/99 FDG	4.5	Include patterns
//	06/11/02	GaryR	Track 2552d	Predefined Report (PDR)
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//					
//**********************************************************************************

string lv_link_type
lv_link_type = upper(trim(istr_case_link_info.link_type))		//AJS 07-13-98 4.0

//	06/11/02	GaryR	Track 2552d
if lv_link_type = 'SUB' or lv_link_type = 'PDQ' &
or lv_link_type = 'PDR' or lv_link_type = 'PAT' &
or lv_link_type = 'RPT' or lv_link_type = 'RDM' &
or lv_link_type = 'MED' or lv_link_type = 'ATT' then
	st_2.text = '(up to 20 characters)'						//1-9-98 NLG 4.0 
	sle_new_id.limit = 20										//1-9-98 NLG 4.0 
else																	//1-9-98 NLG 4.0 
	st_2.text = '(up to 10 characters)'						//1-9-98 NLG 4.0 
	sle_new_id.limit = 10										//1-9-98 NLG 4.0 
end if																//1-9-98 NLG 4.0 

setfocus(sle_new_id)
end event

on w_case_folder_rename.create
int iCurrent
call super::create
this.sle_new_id=create sle_new_id
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_new_id
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
end on

on w_case_folder_rename.destroy
call super::destroy
destroy(this.sle_new_id)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event ue_preopen;call super::ue_preopen;
istr_case_link_info = message.PowerObjectParm
//KMM Clear out message parm (PB Bug)
setnull(message.PowerObjectParm)

end event

type sle_new_id from singlelineedit within w_case_folder_rename
string accessiblename = "New Case ID"
string accessibledescription = "New Case ID"
accessiblerole accessiblerole = textrole!
integer x = 69
integer y = 224
integer width = 1074
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_case_folder_rename
string accessiblename = "(up to 10 characters)"
string accessibledescription = "(up to 10 characters)"
accessiblerole accessiblerole = statictextrole!
integer x = 256
integer y = 112
integer width = 677
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "(up to 10 characters)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_case_folder_rename
string accessiblename = "Enter a new ID"
string accessibledescription = "Enter a new ID"
accessiblerole accessiblerole = statictextrole!
integer x = 201
integer y = 32
integer width = 786
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Enter a new ID"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from u_cb within w_case_folder_rename
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 805
integer y = 400
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Cancel"
end type

on clicked;close(parent)
end on

type cb_ok from u_cb within w_case_folder_rename
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 73
integer y = 408
integer width = 338
integer height = 108
integer taborder = 20
string text = "&OK"
boolean default = true
end type

event clicked;//******************************************************************
//Script for w_case_folder_rename - OK
//******************************************************************
//
//	FDG	11/01/99	Stars 4.5.  Inlude patterns.
// AJS   03-17-98 Track #1449, 4.0 Pass in struc & rename both id & name
//                for types other than SUB and PDQ.
// NLG	6-24-98	Track #1333,1413,1415 Allow to rename types other than SUB
//				
// NLG	1/9/98	4.0 Subset Redesign\ts145-rename.doc
// FNC	11/12/96	FS118 add RDM as a report type. RDM is created from 
//						w_random_sampling_unique_hics when user checks box for
//					   sampling report. Treat like RPT.
// 07-01-96 FNC	STARCARE Prob #907 Allow user to rename MED reports
// 04-25-96 FNC 	STARS31 Prob #269 Allow rename for ARC subsets
//	03/15/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
// 10/11/01	FDC   Stars 4.8.1.	Add case_log
// 01/24/02 SAH   Stars 4.8.1 Change wording of log entry to reflect type rebaned
// 05/03/02 SAH   Stars 5.0 Track 3011 Use seperate Case Log message for each different link type
//	06/11/02	GaryR	Track 2552d	Predefined Report (PDR)
// 07/23/02 MikeF	Change message from 'Renaming subset'
//	08/27/02	GaryR	Track 3197d	Redesign the logic
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
// 09/26/05	MikeF	Track 4522d	Renaming subset doesn't carry down to PDQ and PDRs
//	03/01/06	GaryR	Track	4487	Use link name in where clause to keep unique names
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//******************************************************************
string 	ls_old_name, ls_new_name, ls_message
string 	ls_case_id, ls_case_spl, ls_case_ver
int 		li_rc
string 	ls_link_type, ls_link_id

n_cst_case		lnv_case
nvo_subset_functions lnv_subset

SetPointer(HourGlass!)
setmicrohelp(w_main,"Renaming Link.  Please Wait . . .")

lnv_case = CREATE n_cst_case

ls_link_type	= Upper(istr_case_link_info.link_type)
ls_link_id 		= Upper(istr_case_link_info.link_id)
ls_old_name 	= Upper(istr_case_link_info.link_name)

If sle_new_id.text = '' Then
	Messagebox('Edit','Please enter a new Id.')
	setfocus(sle_new_id)
	Return
Elseif pos(sle_new_id.text,"'") > 0 then				//KMM 7/17/95 Prob#572 Added check for quotes
	Messagebox('Edit','Invalid Character entered, please enter a new Id.')
	setfocus(sle_new_id)
	Return
Elseif pos(sle_new_id.text,'"') > 0 then				//KMM 7/17/95 Prob#572 Added check for quotes
	Messagebox('Edit','Invalid Character entered, please enter a new Id.')
	setfocus(sle_new_id)
	Return
Else	   
	ls_new_name = Upper(Trim (sle_new_id.text))					
	ls_case_id  = Upper(Trim (istr_case_link_info.case_id))
	ls_case_spl = Upper(istr_case_link_info.case_spl)
	ls_case_ver = Upper(istr_case_link_info.case_ver)
End If

// Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)

// Check to see if link exists
IF lnv_case.uf_get_link_exists(ls_case_id, ls_case_spl, ls_case_ver, ls_link_type, ls_new_name) THEN
	MessageBox('Edit','Duplicate Link Name, please choose another name')
	RETURN
END IF

// Update Link Name
IF ls_link_type = 'SUB' OR ls_link_type = 'PDQ' OR ls_link_type = 'PDR'	&
OR ls_link_type = 'PAT' OR ls_link_type = 'RPT' OR ls_link_type = 'RDM' &
OR ls_link_type = 'MED' OR ls_link_type = 'ATT' THEN
	update case_link
	set 	link_name = :ls_new_name			
	where link_type = :ls_link_type
	and	link_name = :ls_old_name
	and	case_id   = :ls_case_id
	and   case_spl  = :ls_case_spl
	and   case_ver  = :ls_case_ver
	Using stars2ca;
else
	update case_link					
	set 	link_name = :ls_new_name,	
	    	link_key  = :ls_new_name
	where link_type = :ls_link_type
	and	link_key  = :ls_link_id
	and	case_id   = :ls_case_id
	and   case_spl  = :ls_case_spl
	and 	case_ver  = :ls_case_ver
	Using stars2ca;
End if

IF (stars2ca.of_check_status() <> 0) or (stars2ca.sqlcode = 100) THEN
   errorbox(stars2ca,'Error updating file in case_link')
END IF

// Prepare message and post process
CHOOSE CASE ls_link_type
	
	CASE 'CRA','CRC'
		ls_message = "Criteria "
   	wf_rename_case_criteria (ls_link_id, ls_new_name, ls_link_type)
		
	CASE 'RPT','MED','RDM'
		ls_message = "Report "
		
	CASE 'SUB'
		// Update all associated places for the new name
		lnv_subset = CREATE nvo_subset_functions	
		lnv_subset.uf_post_rename( ls_old_name, ls_new_name, ls_case_id, ls_case_spl, ls_case_ver)
		DESTROY lnv_subset

		gc_active_subset_name = ls_new_name		// Set active subset
		ls_message = "Subset "
		
	CASE 'ATT'
		ls_message = "Attachment "
		
	CASE ELSE
		ls_message = ls_link_type + " "

END CHOOSE

// Add Case Log entry
ls_message += ls_old_name + " renamed to " + ls_new_name

IF lnv_case.uf_audit_log ( ls_case_id, ls_case_spl, ls_case_ver, ls_message ) < 0 THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Error adding rename message to case log')
	Destroy	lnv_case
	Return
END IF

Destroy	lnv_case

If stars2ca.of_commit() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If

setmicrohelp(w_main,"Ready")
close(parent)
end event

