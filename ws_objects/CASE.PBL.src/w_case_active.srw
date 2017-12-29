$PBExportHeader$w_case_active.srw
$PBExportComments$Set up active case (Inherited from w_master)
forward
global type w_case_active from w_master
end type
type sle_case_id from u_sle within w_case_active
end type
type sle_user_id from singlelineedit within w_case_active
end type
type st_user_id from statictext within w_case_active
end type
type sle_dept from singlelineedit within w_case_active
end type
type st_dept from statictext within w_case_active
end type
type sle_line_of_business from singlelineedit within w_case_active
end type
type st_line_of_business from statictext within w_case_active
end type
type cb_subset from u_cb within w_case_active
end type
type cb_return_from_case_list from u_cb within w_case_active
end type
type cb_ok from u_cb within w_case_active
end type
type st_case_id from statictext within w_case_active
end type
type sle_category from singlelineedit within w_case_active
end type
type st_category from statictext within w_case_active
end type
type cb_create from u_cb within w_case_active
end type
type sle_desc from singlelineedit within w_case_active
end type
type st_desc from statictext within w_case_active
end type
type cb_reset from u_cb within w_case_active
end type
type sle_active_case from singlelineedit within w_case_active
end type
type st_active_case from statictext within w_case_active
end type
type cb_close from u_cb within w_case_active
end type
end forward

global type w_case_active from w_master
string accessiblename = "Case Active"
string accessibledescription = "Case Active"
integer x = 0
integer y = 0
integer width = 2903
integer height = 668
string title = "Case Active"
sle_case_id sle_case_id
sle_user_id sle_user_id
st_user_id st_user_id
sle_dept sle_dept
st_dept st_dept
sle_line_of_business sle_line_of_business
st_line_of_business st_line_of_business
cb_subset cb_subset
cb_return_from_case_list cb_return_from_case_list
cb_ok cb_ok
st_case_id st_case_id
sle_category sle_category
st_category st_category
cb_create cb_create
sle_desc sle_desc
st_desc st_desc
cb_reset cb_reset
sle_active_case sle_active_case
st_active_case st_active_case
cb_close cb_close
end type
global w_case_active w_case_active

type variables
boolean in_close_again
string in_case_cat
boolean iv_is_window_being_opened
end variables

forward prototypes
public function integer fw_retrieve_case ()
end prototypes

public function integer fw_retrieve_case ();//***************************************************************
// 03/11/93	PRD	added code to prevent Secured cases being active case of others
// 03/11/93	FNC	Retrieve case_disp_hold to determine if case on hold
// 09/01/98	AJS	FS362 convert case to case_cntl
// 06/18/02	Jason	Track 3063d  Change case status on referral
//	01/05/03	GaryR	Track 5676c	Decode Case codes and accommodate GUI
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//  04/25/09 Rick B GNL.600.5633.001 - trim lv_case_id to eliminate space being
//		populated in case id field.  If lv_case_id blank, skipping 'case does not exist' message.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//***************************************************************

string lv_case_id,lv_case_spl,lv_case_ver,lv_case_desc,lv_case_disp_hold
string lv_code_desc,lv_case_business,lv_case_dept,lv_case_user_id
string lv_case_cat
String lv_case_status
int lv_count
String lv_code_dept     //alabama2 pat-d
Int    lv_code_sec      //alabama2 pat-d

n_cst_decode	lnv_decode

lv_case_id = left(trim(sle_case_id.text),10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

// 08/31/98 AJS   FS362 convert case to case_cntl
Select dept_id, user_id, case_cat, case_desc,
		 case_business,
		 case_status, case_disp_hold 
  into :lv_case_dept, :lv_case_user_id, :lv_case_cat, :lv_case_desc,
		 :lv_case_business,
		 :lv_case_status, :lv_case_disp_hold
	from Case_cntl 
		where case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )

Using stars2ca;
If stars2ca.of_check_status() = 100 then
	If lv_case_id = '' then
		RETURN -1
	else
		Messagebox('EDIT','Case Does Not Exist')
		Return -1
	end if
	
	If stars2ca.sqlcode <> 0  then
		Errorbox(stars2ca,'Unable to Read Case Table')
		RETURN -1
	end if
End If

If lv_case_status = 'DL' then             
	Messagebox('EDIT','Case has been Deleted')
	setfocus(sle_case_id)                    
	RETURN -1                                
End If                                      

// Decode the values
lnv_decode.of_initialize_add()
sle_line_of_business.text = Upper( lv_case_business ) + " - " + &
					lnv_decode.of_get_description( "LB", Upper( lv_case_business ) )
sle_dept.text = Upper( lv_case_dept ) + " - " + &
					lnv_decode.of_get_description( "DE", Upper( lv_case_dept ) )
sle_user_id.text = Upper( lv_case_user_id ) + " - " + &
					lnv_decode.of_get_description( "USERS", Upper( lv_case_user_id ) )

Stars2ca.of_commit()

sle_desc.text = lv_case_desc

in_case_cat = lv_case_cat

Select  code_desc,code_value_a,code_value_n      //alabama2 pat-d
		into :lv_code_desc,:lv_code_dept,:lv_code_sec   //alabama2 pat-d
		from  code
		where code_type = 'CA' and
				code_code = Upper( :lv_case_cat )
	using stars2ca;
	If stars2ca.of_check_status() = 100 then 
		Errorbox(stars2ca,'Case Category Code not Found')
		RETURN -1
	Elseif stars2ca.sqlcode <> 0 then
		Errorbox(stars2ca,'Error Reading Code Table for Category Codes')
		RETURN -1
	End If
	sle_category.text = lv_case_cat + " - " + lv_code_desc


	//Fraud and abuse has security value and only those dept folks can view
	// those cases
	If lv_code_dept <> gc_user_dept then   //alabama2 pat-d
		If lv_code_sec = 1 then             //alabama2 pat-d
//			sqlcmd('DISCONNECT',stars2ca,'Disconnect After Retrieve',1)      //alabama2 pat-d
			Messagebox('EDIT','Secured Case Can be viewed only by ' &        
							+ lv_code_dept)               //alabama2 pat-d
			setfocus(sle_case_id)                     //alabama2 pat-d
			RETURN -1                                 //alabama2 pat-d
		End If                                       //alabama2 pat-d 
	End If	                                       //alabama2 pat-d

RETURN 0
end function

event activate;// History:
//
// 05/31/02	SAH	Changed width/height to match the changes to w_subset_active,
//						made for Track 2945.  Also changed button width to match 
//						w_subset_active and take up the extra space.
//	01/05/03	GaryR	Track 5676c	Decode Case codes and accommodate GUI
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//						
////////////////////////////////////////////////////////////////////////////////

int rc

setpointer(hourglass!)

If iv_is_window_being_opened = TRUE Then
	iv_is_window_being_opened = FALSE
	w_case_active.x = 1
	w_case_active.y = 1
	w_case_active.width = 2903
	w_case_active.height = 668
	setfocus(sle_case_id)

	If gv_active_case <> '' then
		sle_active_case.text = gv_active_case
		sle_case_id.text = gv_active_case
		This.SetRedraw( FALSE )
		rc = fw_retrieve_case()
		This.SetRedraw( TRUE )
		
		If rc <> 0 Then
			cb_reset.event clicked()
			RETURN
		End If
	Else
		cb_reset.event clicked()
	End If

	setpointer(arrow!)
	setfocus(sle_case_id)
	sle_case_id.selecttext(1,20)
End If
end event

event close;call super::close;int lv_yesno

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//SKM - check instance variable so that it will not prompt the user two time
If sle_active_case.text <> sle_case_id.text and in_close_again = FALSE Then
	lv_yesno = Messagebox('WARNING','You have not updated Active Case. Continue?', &
									Exclamation!,YesNo!,1)
	If lv_yesno = 2 Then
		setfocus(sle_case_id)
		RETURN
	End if
	 //SKM - set this instance variable so that it will not prompt user two times
	 in_close_again = TRUE
End If

If isvalid(w_case_subset_list) Then
	close(w_case_subset_list)
End If

If isvalid(w_subset_active) Then
	close(w_subset_active)
End If

close (w_case_active)
end event

on w_case_active.create
int iCurrent
call super::create
this.sle_case_id=create sle_case_id
this.sle_user_id=create sle_user_id
this.st_user_id=create st_user_id
this.sle_dept=create sle_dept
this.st_dept=create st_dept
this.sle_line_of_business=create sle_line_of_business
this.st_line_of_business=create st_line_of_business
this.cb_subset=create cb_subset
this.cb_return_from_case_list=create cb_return_from_case_list
this.cb_ok=create cb_ok
this.st_case_id=create st_case_id
this.sle_category=create sle_category
this.st_category=create st_category
this.cb_create=create cb_create
this.sle_desc=create sle_desc
this.st_desc=create st_desc
this.cb_reset=create cb_reset
this.sle_active_case=create sle_active_case
this.st_active_case=create st_active_case
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_case_id
this.Control[iCurrent+2]=this.sle_user_id
this.Control[iCurrent+3]=this.st_user_id
this.Control[iCurrent+4]=this.sle_dept
this.Control[iCurrent+5]=this.st_dept
this.Control[iCurrent+6]=this.sle_line_of_business
this.Control[iCurrent+7]=this.st_line_of_business
this.Control[iCurrent+8]=this.cb_subset
this.Control[iCurrent+9]=this.cb_return_from_case_list
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.st_case_id
this.Control[iCurrent+12]=this.sle_category
this.Control[iCurrent+13]=this.st_category
this.Control[iCurrent+14]=this.cb_create
this.Control[iCurrent+15]=this.sle_desc
this.Control[iCurrent+16]=this.st_desc
this.Control[iCurrent+17]=this.cb_reset
this.Control[iCurrent+18]=this.sle_active_case
this.Control[iCurrent+19]=this.st_active_case
this.Control[iCurrent+20]=this.cb_close
end on

on w_case_active.destroy
call super::destroy
destroy(this.sle_case_id)
destroy(this.sle_user_id)
destroy(this.st_user_id)
destroy(this.sle_dept)
destroy(this.st_dept)
destroy(this.sle_line_of_business)
destroy(this.st_line_of_business)
destroy(this.cb_subset)
destroy(this.cb_return_from_case_list)
destroy(this.cb_ok)
destroy(this.st_case_id)
destroy(this.sle_category)
destroy(this.st_category)
destroy(this.cb_create)
destroy(this.sle_desc)
destroy(this.st_desc)
destroy(this.cb_reset)
destroy(this.sle_active_case)
destroy(this.st_active_case)
destroy(this.cb_close)
end on

event open;call super::open;iv_is_window_being_opened = TRUE

end event

type sle_case_id from u_sle within w_case_active
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Case ID"
string accessibledescription = "Lookup Field - Case ID"
integer x = 1778
integer y = 8
integer width = 722
integer height = 80
integer textsize = -8
string facename = "Microsoft Sans Serif"
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 14
end type

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/13/09	GaryR	GNL.600.5633.005	Do not set focus after calling Case List
//
//*********************************************************************************

SetPointer( HourGlass! )
gv_from = 'AC'
OpenSheet(w_case_list,MDI_main_frame,help_menu_position,Layered!)

end event

event getfocus;call super::getfocus;this.selecttext(1,20)
end event

type sle_user_id from singlelineedit within w_case_active
string accessiblename = "User"
string accessibledescription = "User"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 192
integer width = 2126
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_user_id from statictext within w_case_active
string accessiblename = "User"
string accessibledescription = "User"
accessiblerole accessiblerole = statictextrole!
integer x = 210
integer y = 200
integer width = 160
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_dept from singlelineedit within w_case_active
string accessiblename = "Department"
string accessibledescription = "Department"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 284
integer width = 2126
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_dept from statictext within w_case_active
string accessiblename = "Department"
string accessibledescription = "Department"
accessiblerole accessiblerole = statictextrole!
integer x = 9
integer y = 292
integer width = 361
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Department:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_line_of_business from singlelineedit within w_case_active
string accessiblename = "Business"
string accessibledescription = "Business"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 376
integer width = 2126
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_line_of_business from statictext within w_case_active
string accessiblename = "Business"
string accessibledescription = "Business"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 384
integer width = 315
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Business:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_subset from u_cb within w_case_active
event doubleclicked pbm_cbndblclk
string accessiblename = "A/Sub"
string accessibledescription = "A/Sub"
integer x = 2514
integer y = 444
integer width = 338
integer height = 104
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&A/Sub"
end type

on doubleclicked;triggerevent(cb_subset,clicked!)
//OpenSheet(w_subset_active,MDI_main_frame,help_menu_position,Original!)
OpenSheet(w_case_subset_list,MDI_main_frame,help_menu_position,Original!)
end on

on rbuttondown;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
triggerevent(cb_subset,clicked!)
//OpenSheet(w_subset_active,MDI_main_frame,help_menu_position,Original!)
OpenSheet(w_case_subset_list,MDI_main_frame,help_menu_position,Original!)
end on

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
OpenSheet(w_subset_active,MDI_main_frame,help_menu_position,Original!)
end on

type cb_return_from_case_list from u_cb within w_case_active
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 59
integer y = 200
integer width = 64
integer height = 68
integer taborder = 0
integer textsize = -16
string text = "r"
end type

event clicked;int rc
setpointer(hourglass!)
// Load global from Case List (set in rowfocuschanged).  This is NOT the 
//   key global for GV_ACTIVE_CASE.
//ajs the above is not true, gv_active case is used because it is already
//set in case list, This must happen to make a case active thru case list
sle_case_id.text = gv_active_case			//ajs 4.0 02-28-98 globals

//the function below uses the single line edit to retrieve case info
//if it fails the active case variable will be set back to the previous
//active case
rc = fw_retrieve_case()
Setfocus(sle_case_id)
If rc <> 0 Then
	gv_active_case = sle_active_case.text		//ajs 4.0 02-28-98 globals
	RETURN
End If

end event

type cb_ok from u_cb within w_case_active
event doubleclicked pbm_cbndblclk
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 2514
integer y = 4
integer width = 338
integer height = 108
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;// 03-16-98 ajs 4.0 TS145 - Hard Coding Removal
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
string lv_case_id,lv_case_spl,lv_case_ver,lv_link_key
string lv_subset_in_what_table,lv_subset_tables
string ls_link_name
int lv_count,rc, li_rc

If sle_active_case.text = sle_case_id.text Then
	close(parent)
	RETURN
End If

If sle_case_id.text = '' then
	setfocus(sle_case_id)
	messagebox('EDIT','Case Id Must Be Selected',Exclamation!)
	RETURN
End If
If len(sle_case_id.text) <14 then
	setfocus(sle_case_id)
	messagebox('EDIT','Case Id Must Be 14 Characters',Exclamation!)
	RETURN
End If

rc = fw_retrieve_case()
If rc <> 0 Then
	RETURN
Else
	setmicrohelp(w_main,'Valid Case')
End If

//  SET  ACTIVE CASE AND ACTIVE CATEGORY
gv_active_case = upper(sle_case_id.text)
//gc_active_subset_case = gv_active_case	//NLG 1-7-98 SUBSET REDESIGN ts145-active case.doc//ajs 4.0 02-11-98
sle_active_case.text = sle_case_id.text
gv_active_category = in_case_cat
//Close any related open windows with the old active case
If isvalid(w_case_folder_view) then close(w_case_folder_view)
If isvalid(w_case_maint) then close(w_case_maint)
If isvalid(w_target_list) then close(w_target_list)
If isvalid(w_target_maintain) then close(w_target_maintain)
If isvalid(w_target_subset_maintain) then close(w_target_subset_maintain)

gv_case_disp = ''
lv_case_id 	= Trim (left(sle_case_id.text,10) )		// FDG 04/16/01
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 - end

Select count(*) into :lv_count
	from Case_link
	where case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver ) and 
			link_type = 'SUB'
Using stars2ca;
If stars2ca.of_check_status() <> 0  then
	Errorbox(stars2ca,'Unable to Read Case Link Table')
	RETURN
End If


If lv_count = 0 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	setmicrohelp(w_main,'No Subsets Linked to Case - No Active Subset Created')
Elseif lv_count > 1 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	setmicrohelp(w_main,'More Than One Subset Linked to Case - No Active Subset Created')

End If
end event

type st_case_id from statictext within w_case_active
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1504
integer y = 12
integer width = 265
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Case ID:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_category from singlelineedit within w_case_active
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 100
integer width = 2126
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_category from statictext within w_case_active
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 108
integer width = 293
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Category:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_create from u_cb within w_case_active
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 2514
integer y = 116
integer width = 338
integer height = 104
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "Crea&te"
end type

event clicked;//*********************************************************************
// 09-13-94 FNC 	Retrieve case business from business default field on
//              	User Table.
// 01-31-96 DKG 	Added argument for call of fx_create_new_case.
//              	PROB 93 Stars 3.1 Release.
// 07-29-98 AJS 	4.0 Track #1529 - OK needs 14, create wants 10, if more
//              	than 10 digits are provided for case id strip off
// 08/31/98 AJS 	FS362 convert case to case_cntl
// 01/12/98 AJS 	FS2030c 4.1 Correct 10 vs 14 digit error
//	07/29/02	GaryR	Track 3215d	Invalid case log generated from System case.
//*********************************************************************

string 	lv_case, lv_spl, lv_ver
int 	lv_rc, lv_count

//	07/29/02	GaryR	Track 3215d - Begin
n_cst_case	lnv_case
lnv_case = Create n_cst_case
//	07/29/02	GaryR	Track 3215d - End
  
setpointer(hourglass!)
setmicrohelp(w_main,'Creating New Case')

if trim(sle_case_id.text) <> '' then
	lv_case = Upper(Mid(sle_case_id.text,1,10))
		
	if len(lv_case) > 0 and len(lv_case) < 10 then
		messagebox('EDIT','Case ID Must Be 10 Characters',Exclamation!)
		setfocus(sle_case_id)
		return
	end if
	
	//check if case exists
	Select count(*) 
	Into :lv_count
	From Case_CNTL
	Where Case_ID = Upper( :lv_case )
	Using Stars2ca;
	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error Reading Case Table: Case ID = ' + lv_case)
		return
	end if
	if lv_count > 0 then
		lv_rc = messagebox('Information','Case Already Exists. Do you want to make case ' + lv_case + ' your active case?',Question!,OKCancel!,2) 
		if lv_rc = 2 then return
			cb_ok.postevent(clicked!)
		return
	else
		//	07/29/02	GaryR	Track 3215d
		//lv_case = fx_create_new_case(lv_case + '0000', FALSE)
		lv_case = lnv_case.uf_create_case( lv_case + '0000', FALSE )
	end if
	if stars2ca.of_commit() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	end If	
else
	//	07/29/02	GaryR	Track 3215d
   //lv_case = fx_create_new_case(trim(sle_case_id.text), FALSE)
	lv_case = lnv_case.uf_create_case( Trim( sle_case_id.text ), FALSE )
	if lv_case = 'ERROR' or lv_case = 'EXISTS' then
		setfocus(sle_case_id)
		return
	end if
end if

//	07/29/02	GaryR	Track 3215d
IF IsValid( lnv_case ) THEN Destroy lnv_case

sle_case_id.text = lv_case
sle_category.text = 'Potential Case'
setfocus(sle_case_id)
end event

type sle_desc from singlelineedit within w_case_active
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 468
integer width = 2126
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_desc from statictext within w_case_active
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 476
integer width = 352
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_reset from u_cb within w_case_active
string accessiblename = "Reset"
string accessibledescription = "Reset"
integer x = 2514
integer y = 224
integer width = 338
integer height = 104
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Reset"
end type

event clicked;//  deactivate active case by blanking out gv
//***********************************************************
//07-25-95 FNC prob # 717
//             Blank out "ON HOLD" when screen is reset
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//***********************************************************

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
gv_active_case = ''
sle_desc.text = ''
sle_active_case.text = ''
sle_case_id.text = ''
sle_category.text = ''
sle_line_of_business.text = ''
sle_dept.text = ''
sle_user_id.text = ''
setfocus(sle_case_id)
end event

type sle_active_case from singlelineedit within w_case_active
string tag = "colorfixed"
string accessiblename = "Active Case"
string accessibledescription = "Active Case"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 8
integer width = 722
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean autohscroll = false
integer limit = 14
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_active_case from statictext within w_case_active
string tag = " colorfixed"
string accessiblename = "Active Case"
string accessibledescription = "Active Case"
accessiblerole accessiblerole = statictextrole!
integer y = 16
integer width = 370
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Active Case:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_case_active
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 332
integer width = 338
integer height = 108
integer taborder = 60
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

event clicked;
w_case_active.TriggerEvent(Close!)
end event

