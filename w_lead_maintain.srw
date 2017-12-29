HA$PBExportHeader$w_lead_maintain.srw
$PBExportComments$Inherited from w_master
forward
global type w_lead_maintain from w_master
end type
type sle_disposition from u_sle within w_lead_maintain
end type
type sle_case_id from u_sle within w_lead_maintain
end type
type em_reason_code from editmask within w_lead_maintain
end type
type sle_date_created from singlelineedit within w_lead_maintain
end type
type em_phone_no from editmask within w_lead_maintain
end type
type st_22 from statictext within w_lead_maintain
end type
type ddlb_lead_type from dropdownlistbox within w_lead_maintain
end type
type st_description from statictext within w_lead_maintain
end type
type st_12 from statictext within w_lead_maintain
end type
type cb_clear from u_cb within w_lead_maintain
end type
type cb_model from u_cb within w_lead_maintain
end type
type mle_comments from multilineedit within w_lead_maintain
end type
type sle_track_type from singlelineedit within w_lead_maintain
end type
type sle_category from singlelineedit within w_lead_maintain
end type
type sle_lead_id from singlelineedit within w_lead_maintain
end type
type ddlb_nature from dropdownlistbox within w_lead_maintain
end type
type st_21 from statictext within w_lead_maintain
end type
type st_20 from statictext within w_lead_maintain
end type
type st_19 from statictext within w_lead_maintain
end type
type sle_ack_date from singlelineedit within w_lead_maintain
end type
type st_16 from statictext within w_lead_maintain
end type
type ddlb_contact_type from dropdownlistbox within w_lead_maintain
end type
type st_15 from statictext within w_lead_maintain
end type
type sle_letterdue_date from singlelineedit within w_lead_maintain
end type
type st_14 from statictext within w_lead_maintain
end type
type st_13 from statictext within w_lead_maintain
end type
type ddlb_status from dropdownlistbox within w_lead_maintain
end type
type st_8 from statictext within w_lead_maintain
end type
type sle_last_name from singlelineedit within w_lead_maintain
end type
type sle_first_name from singlelineedit within w_lead_maintain
end type
type sle_contact_bene from singlelineedit within w_lead_maintain
end type
type st_29 from statictext within w_lead_maintain
end type
type st_25 from statictext within w_lead_maintain
end type
type st_24 from statictext within w_lead_maintain
end type
type cb_notes from u_cb within w_lead_maintain
end type
type cb_close from u_cb within w_lead_maintain
end type
type cb_delete from u_cb within w_lead_maintain
end type
type cb_add from u_cb within w_lead_maintain
end type
type cb_retrieve from u_cb within w_lead_maintain
end type
type st_18 from statictext within w_lead_maintain
end type
type sle_disp_date from singlelineedit within w_lead_maintain
end type
type st_17 from statictext within w_lead_maintain
end type
type st_11 from statictext within w_lead_maintain
end type
type st_10 from statictext within w_lead_maintain
end type
type sle_dept from singlelineedit within w_lead_maintain
end type
type sle_rep from singlelineedit within w_lead_maintain
end type
type sle_receipt_date from singlelineedit within w_lead_maintain
end type
type sle_contact_desc from singlelineedit within w_lead_maintain
end type
type st_7 from statictext within w_lead_maintain
end type
type st_6 from statictext within w_lead_maintain
end type
type st_5 from statictext within w_lead_maintain
end type
type st_4 from statictext within w_lead_maintain
end type
type st_3 from statictext within w_lead_maintain
end type
type st_2 from statictext within w_lead_maintain
end type
type gb_4 from groupbox within w_lead_maintain
end type
type gb_3 from groupbox within w_lead_maintain
end type
type gb_2 from groupbox within w_lead_maintain
end type
type gb_1 from groupbox within w_lead_maintain
end type
type cb_update from u_cb within w_lead_maintain
end type
end forward

global type w_lead_maintain from w_master
string accessiblename = "Case Lead Details"
string accessibledescription = "Case Lead Details"
integer x = 169
integer y = 0
integer width = 2725
integer height = 1704
string title = "Case Lead Details"
event type integer ue_edit_dates ( )
event ue_edit_case_closed ( )
event type boolean ue_edit_case_referred ( string as_case_id,  string as_case_spl,  string as_case_ver )
event ue_set_mod_availability ( boolean ab_switch )
event ue_set_create_availability ( boolean ab_switch )
event ue_set_update_availability ( boolean ab_new_lead )
event ue_set_field_availability ( boolean ab_switch )
event type integer ue_modified ( )
sle_disposition sle_disposition
sle_case_id sle_case_id
em_reason_code em_reason_code
sle_date_created sle_date_created
em_phone_no em_phone_no
st_22 st_22
ddlb_lead_type ddlb_lead_type
st_description st_description
st_12 st_12
cb_clear cb_clear
cb_model cb_model
mle_comments mle_comments
sle_track_type sle_track_type
sle_category sle_category
sle_lead_id sle_lead_id
ddlb_nature ddlb_nature
st_21 st_21
st_20 st_20
st_19 st_19
sle_ack_date sle_ack_date
st_16 st_16
ddlb_contact_type ddlb_contact_type
st_15 st_15
sle_letterdue_date sle_letterdue_date
st_14 st_14
st_13 st_13
ddlb_status ddlb_status
st_8 st_8
sle_last_name sle_last_name
sle_first_name sle_first_name
sle_contact_bene sle_contact_bene
st_29 st_29
st_25 st_25
st_24 st_24
cb_notes cb_notes
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
cb_retrieve cb_retrieve
st_18 st_18
sle_disp_date sle_disp_date
st_17 st_17
st_11 st_11
st_10 st_10
sle_dept sle_dept
sle_rep sle_rep
sle_receipt_date sle_receipt_date
sle_contact_desc sle_contact_desc
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
cb_update cb_update
end type
global w_lead_maintain w_lead_maintain

type variables
string in_from
String in_case_id,in_case_spl,In_case_ver
String in_lead_id
string is_from_menu = 'FALSE'

// Message.Stringparm
String	is_parm

datetime idt_receipt_datetime
DateTime	idt_disp_datetime		
DateTime	idt_letter_due_datetime
DateTime idt_ack_datetime			

// Stars 4.8 - Case NVO
n_cst_case	inv_case

// 12/9/04 JasonS Track 3664 Case Component Update
string is_comp_upd_status
boolean ib_new_lead

boolean ib_modified
end variables

forward prototypes
public function boolean wf_lead_exists ()
end prototypes

event ue_edit_dates;//*********************************************************************************
// 01/13/99 FNC	TS2040C Stars 4.0 SP1. Created.
//						Require user to input 4 digit year. Replace edits in cb_update and
//						cb_add with one event
//*********************************************************************************
integer li_rc

If trim(sle_receipt_date.text) <> '' then
	N_cst_datetime lnvo_cst_datetime
	Li_rc = lnvo_cst_datetime.of_isvaliddate(sle_receipt_date.text)
	Choose Case li_rc 
		Case -1
			Messagebox('EDIT','Receipt Date is not Valid')
			setfocus(sle_receipt_date)
			RETURN -1
		Case -2 
			MessageBox('Error', 'Accurate lead update requires a four digit year in the contact date field.')
			setfocus(sle_receipt_date)
			Return	-1
		Case -3
			Setfocus(sle_receipt_date)
			MessageBox('Error', 'Contact date must be between' + lnvo_cst_datetime.of_getminimumstringdate() + &
			' and ' + lnvo_cst_datetime.of_getmaximumstringdate())
			Return -1
		Case Else
			idt_receipt_datetime = datetime(date(sle_receipt_date.text))
	End Choose
End If

If trim(sle_disp_date.text) <> '' then
	Li_rc = lnvo_cst_datetime.of_isvaliddate(sle_disp_date.text)
	Choose Case li_rc 
		Case -1
			Messagebox('EDIT','Status Date Is not Valid. Reset to Today~'s date')
			idt_disp_datetime = gnv_app.of_get_server_date_time()
			sle_disp_date.text = string(idt_disp_datetime)
			setfocus(sle_disp_date)
			RETURN -1
		Case -2 
			MessageBox('Error', 'Accurate lead update requires a four digit year in the status date field.')
			setfocus(sle_disp_date)
			Return	-1
		Case -3
			Setfocus(sle_disp_date)
			MessageBox('Error', 'Status date must be between' + lnvo_cst_datetime.of_getminimumstringdate() + &
			' and ' + lnvo_cst_datetime.of_getmaximumstringdate())
			Return -1
		Case Else
			idt_disp_datetime =  datetime(date(sle_disp_date.text))
	End Choose
End If

If  trim(sle_letterdue_date.text) <> '' then
	Li_rc = lnvo_cst_datetime.of_isvaliddate(sle_letterdue_date.text)
	Choose Case li_rc 
		Case -1
			Messagebox('EDIT','Letter Due Date is not Valid')
			setfocus(sle_letterdue_date)
			Return -1
		Case -2 
			MessageBox('Error', 'Accurate lead update requires a four digit year in the letter due date field.')
			Return -1
		Case -3
			Setfocus(sle_letterdue_date)
			MessageBox('Error', 'Letter due date must be between' + lnvo_cst_datetime.of_getminimumstringdate() + &
			' and ' + lnvo_cst_datetime.of_getmaximumstringdate())
			Return -1
		Case Else
			idt_letter_due_datetime = datetime(date(sle_letterdue_date.text))
	End Choose
End if

If  trim(sle_ack_date.text) <> '' then
	Li_rc = lnvo_cst_datetime.of_isvaliddate(sle_ack_date.text)
	Choose Case li_rc 
		Case -1
			Messagebox('EDIT','Date Acknowledged is not Valid')
			setfocus(sle_ack_date)
			RETURN -1
		Case -2 
			MessageBox('Error', 'Accurate lead update requires a four digit year in the acknowledgement date field.')
			setfocus(sle_ack_date)
			Return -1
		Case -3
			Setfocus(sle_ack_date)
			MessageBox('Error', 'Acknowledgement date date must be between' + lnvo_cst_datetime.of_getminimumstringdate() + &
			' and ' + lnvo_cst_datetime.of_getmaximumstringdate())
			Return -1
		Case Else
			idt_ack_datetime = datetime(date(sle_ack_date.text))
	End Choose
End If

Return 0

end event

event ue_edit_case_closed();//*******************************************************************
//	Script			ue_edit_case_closed
//
//
//	Description		Prevent updating this window if the case is closed
//						or deleted.
//
//
//*******************************************************************
//	09/21/01	FDG	Stars 4.8.	Created
//	05/17/07 Katie	SPR 4989 Removed cb_clear, cb_model from the logic
//*******************************************************************
Boolean		lb_valid_case

lb_valid_case	=	inv_case.uf_edit_case_closed (sle_case_id.text)

IF	lb_valid_case	=	FALSE		THEN
	cb_add.enabled					=	FALSE
	cb_delete.enabled				=	FALSE
	cb_update.enabled				=	FALSE
	ddlb_contact_type.enabled	=	FALSE
	ddlb_lead_type.enabled		=	FALSE
	ddlb_nature.enabled			=	FALSE
	ddlb_status.enabled			=	FALSE
	em_phone_no.enabled			=	FALSE
	em_reason_code.enabled		=	FALSE
	mle_comments.enabled			=	FALSE
	sle_ack_date.enabled			=	FALSE
	sle_category.enabled			=	FALSE
	sle_contact_bene.enabled	=	FALSE
	sle_contact_desc.enabled	=	FALSE
	sle_date_created.enabled	=	FALSE
	sle_dept.enabled				=	FALSE
	sle_disp_date.enabled		=	FALSE
	sle_disposition.enabled		=	FALSE
	sle_first_name.enabled		=	FALSE
	sle_last_name.enabled		=	FALSE
	sle_lead_id.enabled			=	FALSE
	sle_letterdue_date.enabled	=	FALSE
	sle_receipt_date.enabled	=	FALSE
	sle_rep.enabled				=	FALSE
	sle_track_type.enabled		=	FALSE
END IF

end event

event type boolean ue_edit_case_referred(string as_case_id, string as_case_spl, string as_case_ver);/////////////////////////////////////////////////////////////////////////////////
//
// Description:   Places call to n_cst_case.uf_edit_case_referred(), passing case_id,
//						case_spl and case_ver, to check if the case has been referred.  If
//						it has, cb_delete is disabled to prevent user from deleting leads
//						from referred cases.
//
/////////////////////////////////////////////////////////////////////////////////
// History:
//
// SAH 05/08/02 Stars 5.1 Track 2996 Created
// Katie 09/12/06 SPR 4726 Changed to check for referred or deleted cases
//	05/17/07 Katie	SPR 4989 Removed cb_clear, cb_model  from the logic
//	05/18/07 Katie SPR 5016 Disable Case_ID if the Case is RC/DL
//
////////////////////////////////////////////////////////////////////////////////
Boolean lb_valid_case

lb_valid_case = inv_case.uf_edit_case_deleted(as_case_id, as_case_spl, as_case_ver)

IF lb_valid_case = FALSE THEN
	cb_add.enabled					=	FALSE
	cb_delete.enabled				=	FALSE
	cb_update.enabled				=	FALSE
	cb_retrieve.enabled				=	FALSE
	ddlb_contact_type.enabled	=	FALSE
	ddlb_lead_type.enabled		=	FALSE
	ddlb_nature.enabled			=	FALSE
	ddlb_status.enabled			=	FALSE
	em_phone_no.enabled			=	FALSE
	em_reason_code.enabled		=	FALSE
	mle_comments.enabled			=	FALSE
	sle_ack_date.enabled			=	FALSE
	sle_category.enabled			=	FALSE
	sle_contact_bene.enabled	=	FALSE
	sle_contact_desc.enabled	=	FALSE
	sle_date_created.enabled	=	FALSE
	sle_dept.enabled				=	FALSE
	sle_disp_date.enabled		=	FALSE
	sle_disposition.enabled		=	FALSE
	sle_first_name.enabled		=	FALSE
	sle_last_name.enabled		=	FALSE
	sle_case_id.enabled			=	FALSE
	sle_lead_id.enabled			=	FALSE
	sle_letterdue_date.enabled	=	FALSE
	sle_receipt_date.enabled	=	FALSE
	sle_rep.enabled				=	FALSE
	sle_track_type.enabled		=	FALSE
END IF



Return lb_valid_case
end event

event ue_set_mod_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_mod_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for modifying 
//						the case lead component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//	05/17/07 Katie		SPR 4806 Removed logic for cb_notes
//	05/23/07	Katie		Add Client Admin requirement for deleting
//*********************************************************************************

cb_update.enabled = ab_switch
if (gv_user_sl = "AD") then
	cb_delete.enabled = ab_switch
else
	cb_delete.enabled = false
end if
end event

event ue_set_create_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_create_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for creating 
//						the case lead component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//  09/11/06 Katie		Track 4726  Added the case and lead id fields.
//*********************************************************************************
cb_add.enabled = ab_switch
sle_case_id.enabled = ab_switch
sle_lead_id.enabled = ab_switch

end event

event ue_set_update_availability(boolean ab_new_lead);//*********************************************************************************
// Script Name:	ue_set_update_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the case
//						lead component base on the update status returned from
//						n_cst_case.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//	05/18/07 Katie		SPR 5017 Disable cb_retrieve unless Clear is clicked
//*********************************************************************************


String ls_case_id
String ls_case_spl
String ls_case_ver


ls_case_id	=	Left (sle_case_id.text, 10)
ls_case_spl	=	Mid (sle_case_id.text, 11, 2)
ls_case_ver	=	Mid (sle_case_id.text, 13, 2)


is_comp_upd_status = inv_case.uf_get_comp_upd_status_lead('CASELEADS', ls_case_id , ls_case_spl, ls_case_ver)
if ib_new_lead then 
	choose case is_comp_upd_status 
		case 'AO'
			this.event ue_set_mod_availability(false)
			this.event ue_set_create_availability(true)
			this.event ue_set_field_availability(true)
		case 'RO'
			this.event ue_set_mod_availability(false)
			this.event ue_set_create_availability(false)
			this.event ue_set_field_availability(false)
		case 'AL'
			this.event ue_set_mod_availability(false)
			this.event ue_set_create_availability(true)
			this.event ue_set_field_availability(true)
	end choose
else
	choose case is_comp_upd_status 
		case 'AO'
			this.event ue_set_mod_availability(false)
			this.event ue_set_create_availability(false)
			this.event ue_set_field_availability(false)
			cb_notes.enabled = true
		case 'RO'
			this.event ue_set_mod_availability(false)
			this.event ue_set_create_availability(false)
			this.event ue_set_field_availability(false)
		case 'AL'
			this.event ue_set_mod_availability(true)
			this.event ue_set_create_availability(false)
			this.event ue_set_field_availability(true)
	end choose
	cb_model.enabled = true
	cb_notes.enabled = true
end if
cb_retrieve.enabled = false


end event

event ue_set_field_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_field_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for modifying 
//						the case lead component.
//
//*********************************************************************************
//
//	09/11/06	Katie	Track 4726	Created.
//	03/16/07	Katie	SPR 4948 Removed security depedance for cb_clear and cb_model.
//	05/17/07 Katie	SPR 5017 Removed cb_retrieve from this logic
//*********************************************************************************

ddlb_lead_type.enabled = ab_switch
ddlb_nature.enabled = ab_switch
em_reason_code.enabled = ab_switch
sle_contact_desc.enabled = ab_switch
ddlb_contact_type.enabled = ab_switch
sle_receipt_date.enabled = ab_switch
sle_contact_bene.enabled = ab_switch
sle_first_name.enabled = ab_switch
sle_last_name.enabled = ab_switch
em_phone_no.enabled = ab_switch
ddlb_status.enabled = ab_switch
sle_disp_date.enabled = ab_switch
sle_disposition.enabled = ab_switch
sle_letterdue_date.enabled = ab_switch
sle_ack_date.enabled = ab_switch
mle_comments.enabled = ab_switch
end event

event type integer ue_modified();//	05/21/07 Katie SPR 4806 Added logic to ask user if they wish to save their changes.
Integer	li_rt

IF ib_modified THEN
	li_rt = MessageBox( "Save Changes", "Do you want to save changes to lead?", &
																				Exclamation!, YesNoCancel!, 1 )
	CHOOSE CASE li_rt
		CASE 1	//Save
			IF cb_add.enabled THEN
				IF cb_add.Event Clicked() < 0 THEN Return -1
			ELSE
				IF cb_update.Event Clicked() < 0 THEN Return -1
			END IF
		CASE 2	//Don't Save
		CASE ELSE	//Cancel
			Return 0
	END CHOOSE
END IF

Return 1
end event

public function boolean wf_lead_exists ();//wf_lead_exists()
//Checks to see if the lead exists before changing the update availability
//*******************************************************
//	Katie	03/16/07	SPR 4726
long ll_count

select count(*)
into :ll_count
from lead
where lead_id = :in_lead_id
using stars2ca;

If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Reading Lead table for current lead')
	return false
Elseif ll_count > 0 then
	return true
End If

return false
end function

event open;call super::open;//*******************************************************************

// 01/31/96 DKG Modified to allow user to add a lead for a
//              non-existent case by adding case. PROB 93 STARS
//              3.1 Realease.
//
// 02/07/96 DKG Removed sle_reason_code and replaced with
//              em_reason_code to shorten length to 2 characters.
//              PROB 45 Stars Release 3.1 disk.
// 03/04/98 AJS 4.0 TS145-globals case id
// 09/01/98 AJS FS362 convert case to case_cntl
// 01/14/99	FNC TS2020C Display the server date in mm/dd/yyyy format
//	09/21/01	FDG	Stars 4.8.1	No updates can occur if the case is closed
// 05/07/02 SAH Stars 5.1 Track 2996 Prohibit user from deleting lead 
//					      from original version of referred case.
// 12/9/04 JasonS Track 3664 Case Component Update
// 01/22/05 Katie Track 5171c Changed ddlb_contact_type to be dynamic.
//	05/18/07	Katie	SPR 5015 Added check to make sle_case_id = '' 
//						if gv_active_case = 'NONE'
//	05/23/07 Katie Trim sle_case_id to make sure it doesn't = ' '
//*******************************************************************

String lv_case_id,lv_case_spl,lv_case_ver, lv_status
Long lv_next_lead, lv_count
Int lv_pos
boolean lb_valid_lead
u_nvo_sys_cntl lnvo_sys_cntl

setpointer(hourglass!)
//fx_set_window_colors(w_lead_maintain)
setmicrohelp(w_main,'Ready')
in_from = gv_from

load_ddlb_values(ddlb_status,'LS','B',2)
ddlb_status.AddItem(' ')                  //11-29-94 FNC

load_ddlb_values(ddlb_lead_type,'LR','B',3)
ddlb_lead_type.AddItem(' ')                  //11-29-94 FNC

load_ddlb_values(ddlb_nature,'LN','B',3)
ddlb_nature.AddItem(' ')                  //11-29-94 FNC

load_ddlb_values(ddlb_contact_type,'LEADC','B',2)
ddlb_contact_type.AddItem(' ')                  //01/22/05 Katie

inv_sys_cntl = create u_nvo_sys_cntl		// FNC 01/14/99 

inv_case	=	CREATE	n_cst_case				// FDG 09/21/01

ib_new_lead = TRUE

If In_from = 'N' then
//	sle_case_id.text = is_parm		//KMM 9/25/95
	lv_pos = pos(is_parm,'~~')
	if (left(is_parm,(lv_pos)) <> 'NONE~~') then
		sle_case_id.text = left(is_parm,(lv_pos - 1))
		is_from_menu = mid(is_parm,(lv_pos + 1))
	end if
Elseif in_from = 'M' then
	ib_new_lead = FALSE
	lv_pos = pos(is_parm,'~~')
	sle_case_id.text = left(is_parm,(lv_pos - 1))
	sle_lead_id.text = mid(is_parm,(lv_pos + 1))
	sle_lead_id.enabled = false
	triggerevent(cb_retrieve,clicked!)
	RETURN
Else
	if (trim(upper(gv_active_case)) = trim(upper('NONE'))) then
		sle_case_id.text = ''
	else
		sle_case_id.text = gv_active_case
	end if
End IF
sle_case_id.text = trim(sle_case_id.text)

this.title		 = 'Case Lead Add'
sle_rep.text    = gc_user_id


sle_date_created.text = inv_sys_cntl.of_get_default_date()	// FNC 01/14/99
sle_receipt_date.text = sle_date_created.text
lb_valid_lead = false
do while lb_valid_lead = false and sle_lead_id.text <> 'ERROR'
	sle_lead_id.text = fx_get_next_key_id('LEAD')
	
	Select count(*) 
	into :lv_count
	from LEAD
	where LEAD_ID = Upper( :sle_lead_id.text )
	using stars2ca;

	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error Reading Lead Table: where lead id = ' + sle_lead_id.text)  
		return -1
	end if

	if lv_count > 0 then
	else
		lb_valid_lead = true
	end if

loop
If sle_lead_id.text = 'ERROR' then
	Messagebox('EDIT','Unable to get System Controlled Lead Id, Please enter a Lead ID')
	setfocus(sle_lead_id)
End IF

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

// 09/01/98 AJS   FS362 convert case to case_cntl
Select case_trk_type,case_cat,dept_id
		into :sle_track_type.text,:sle_category.text,:sle_dept.text
		from Case_CNTL
		where Case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
Using stars2ca;
If stars2ca.of_check_status() <> 0 then
		
   IF stars2ca.sqlcode = 100 THEN
      in_from = 'MENU'
      sle_category.text = 'COM'
      sle_dept.text = gc_user_dept
	else
		Errorbox(stars2ca,'Error Reading Case Table')
		cb_close.PostEvent(Clicked!)
		RETURN
	end if
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	

setfocus(sle_lead_id)

// FDG 09/21/01 - No updates can occur if the case is closed/deleted
//This.Event	ue_edit_case_closed()
this.event ue_set_update_availability(true)  //SPR 4726
this.Event ue_edit_case_referred(lv_case_id, lv_case_spl, lv_case_ver)

setpointer(arrow!)
end event

on w_lead_maintain.create
int iCurrent
call super::create
this.sle_disposition=create sle_disposition
this.sle_case_id=create sle_case_id
this.em_reason_code=create em_reason_code
this.sle_date_created=create sle_date_created
this.em_phone_no=create em_phone_no
this.st_22=create st_22
this.ddlb_lead_type=create ddlb_lead_type
this.st_description=create st_description
this.st_12=create st_12
this.cb_clear=create cb_clear
this.cb_model=create cb_model
this.mle_comments=create mle_comments
this.sle_track_type=create sle_track_type
this.sle_category=create sle_category
this.sle_lead_id=create sle_lead_id
this.ddlb_nature=create ddlb_nature
this.st_21=create st_21
this.st_20=create st_20
this.st_19=create st_19
this.sle_ack_date=create sle_ack_date
this.st_16=create st_16
this.ddlb_contact_type=create ddlb_contact_type
this.st_15=create st_15
this.sle_letterdue_date=create sle_letterdue_date
this.st_14=create st_14
this.st_13=create st_13
this.ddlb_status=create ddlb_status
this.st_8=create st_8
this.sle_last_name=create sle_last_name
this.sle_first_name=create sle_first_name
this.sle_contact_bene=create sle_contact_bene
this.st_29=create st_29
this.st_25=create st_25
this.st_24=create st_24
this.cb_notes=create cb_notes
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_retrieve=create cb_retrieve
this.st_18=create st_18
this.sle_disp_date=create sle_disp_date
this.st_17=create st_17
this.st_11=create st_11
this.st_10=create st_10
this.sle_dept=create sle_dept
this.sle_rep=create sle_rep
this.sle_receipt_date=create sle_receipt_date
this.sle_contact_desc=create sle_contact_desc
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_update=create cb_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_disposition
this.Control[iCurrent+2]=this.sle_case_id
this.Control[iCurrent+3]=this.em_reason_code
this.Control[iCurrent+4]=this.sle_date_created
this.Control[iCurrent+5]=this.em_phone_no
this.Control[iCurrent+6]=this.st_22
this.Control[iCurrent+7]=this.ddlb_lead_type
this.Control[iCurrent+8]=this.st_description
this.Control[iCurrent+9]=this.st_12
this.Control[iCurrent+10]=this.cb_clear
this.Control[iCurrent+11]=this.cb_model
this.Control[iCurrent+12]=this.mle_comments
this.Control[iCurrent+13]=this.sle_track_type
this.Control[iCurrent+14]=this.sle_category
this.Control[iCurrent+15]=this.sle_lead_id
this.Control[iCurrent+16]=this.ddlb_nature
this.Control[iCurrent+17]=this.st_21
this.Control[iCurrent+18]=this.st_20
this.Control[iCurrent+19]=this.st_19
this.Control[iCurrent+20]=this.sle_ack_date
this.Control[iCurrent+21]=this.st_16
this.Control[iCurrent+22]=this.ddlb_contact_type
this.Control[iCurrent+23]=this.st_15
this.Control[iCurrent+24]=this.sle_letterdue_date
this.Control[iCurrent+25]=this.st_14
this.Control[iCurrent+26]=this.st_13
this.Control[iCurrent+27]=this.ddlb_status
this.Control[iCurrent+28]=this.st_8
this.Control[iCurrent+29]=this.sle_last_name
this.Control[iCurrent+30]=this.sle_first_name
this.Control[iCurrent+31]=this.sle_contact_bene
this.Control[iCurrent+32]=this.st_29
this.Control[iCurrent+33]=this.st_25
this.Control[iCurrent+34]=this.st_24
this.Control[iCurrent+35]=this.cb_notes
this.Control[iCurrent+36]=this.cb_close
this.Control[iCurrent+37]=this.cb_delete
this.Control[iCurrent+38]=this.cb_add
this.Control[iCurrent+39]=this.cb_retrieve
this.Control[iCurrent+40]=this.st_18
this.Control[iCurrent+41]=this.sle_disp_date
this.Control[iCurrent+42]=this.st_17
this.Control[iCurrent+43]=this.st_11
this.Control[iCurrent+44]=this.st_10
this.Control[iCurrent+45]=this.sle_dept
this.Control[iCurrent+46]=this.sle_rep
this.Control[iCurrent+47]=this.sle_receipt_date
this.Control[iCurrent+48]=this.sle_contact_desc
this.Control[iCurrent+49]=this.st_7
this.Control[iCurrent+50]=this.st_6
this.Control[iCurrent+51]=this.st_5
this.Control[iCurrent+52]=this.st_4
this.Control[iCurrent+53]=this.st_3
this.Control[iCurrent+54]=this.st_2
this.Control[iCurrent+55]=this.gb_4
this.Control[iCurrent+56]=this.gb_3
this.Control[iCurrent+57]=this.gb_2
this.Control[iCurrent+58]=this.gb_1
this.Control[iCurrent+59]=this.cb_update
end on

on w_lead_maintain.destroy
call super::destroy
destroy(this.sle_disposition)
destroy(this.sle_case_id)
destroy(this.em_reason_code)
destroy(this.sle_date_created)
destroy(this.em_phone_no)
destroy(this.st_22)
destroy(this.ddlb_lead_type)
destroy(this.st_description)
destroy(this.st_12)
destroy(this.cb_clear)
destroy(this.cb_model)
destroy(this.mle_comments)
destroy(this.sle_track_type)
destroy(this.sle_category)
destroy(this.sle_lead_id)
destroy(this.ddlb_nature)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.sle_ack_date)
destroy(this.st_16)
destroy(this.ddlb_contact_type)
destroy(this.st_15)
destroy(this.sle_letterdue_date)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.ddlb_status)
destroy(this.st_8)
destroy(this.sle_last_name)
destroy(this.sle_first_name)
destroy(this.sle_contact_bene)
destroy(this.st_29)
destroy(this.st_25)
destroy(this.st_24)
destroy(this.cb_notes)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_retrieve)
destroy(this.st_18)
destroy(this.sle_disp_date)
destroy(this.st_17)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.sle_dept)
destroy(this.sle_rep)
destroy(this.sle_receipt_date)
destroy(this.sle_contact_desc)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_update)
end on

event ue_preopen;call super::ue_preopen;is_parm	=	Message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

end event

event close;call super::close;//******************************************************************************
// 01/14/99 FNC 	TS2040C Stars 4.0 Sp1
//						Destroy NVO added to open script to retrieve sever date
//	09/21/01	FDG	Stars 4.8.	Destroy inv_case
//	05/21/07 Katie SPR 4806 Added logic to ask user if they wish to save their changes.
//******************************************************************************

destroy inv_sys_cntl			// FNC 01/14/99

// FDG 09/21/01
IF	IsValid (inv_case)		THEN
	destroy	inv_case
END IF

end event

event ue_postopen;call super::ue_postopen;// 12/9/04 JasonS Track 3664d Case Component Update
//	05/21/07 Katie 	SPR4806 Set modified boolean to false
ib_modified = false






end event

type sle_disposition from u_sle within w_lead_maintain
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Disposition"
string accessibledescription = "Lookup Field - Disposition"
integer x = 471
integer y = 1104
integer width = 443
integer height = 88
integer taborder = 150
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 15
end type

event modified;call super::modified;//*******************************************************************
// 01/14/99 FNC TS202C Stars 4.0 SP1. Use server date rather than PC date.
//	05/21/07 Katie 	SPR4806 Set modified boolean to true
//*******************************************************************

parent.ib_modified = true

//KMM 9/21/95 PROB#964

sle_disp_date.displayonly = false   
sle_disp_date.taborder    = 140
//sle_disp_date.text = string(today())							// FNC 01/14/99 
sle_disp_date.text = inv_sys_cntl.of_get_default_date()	// FNC 01/14/99
end event

event ue_lookup;call super::ue_lookup;//	02/05/07	GaryR	Track 4846	Trigger the modified event when value changes
//  rbuttondown for sle_disposition
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

String	ls_disp

gv_which_dw = 'LD'
ls_disp = sle_disposition.text

OPEN(W_SELECT_BOX)
If gv_selection1 <> '' and ls_disp <> gv_selection1 then
	sle_disposition.text = gv_selection1
	st_description.text = gv_selection2
	This.event modified()
End If
end event

type sle_case_id from u_sle within w_lead_maintain
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Case ID"
string accessibledescription = "Lookup Field - Case ID"
integer x = 279
integer y = 64
integer width = 645
integer height = 88
long textcolor = 134217747
long backcolor = 134217731
boolean autohscroll = true
textcase textcase = upper!
integer limit = 14
end type

event ue_lookup;call super::ue_lookup;// 05/18/07Katie SPR 5016 Added right-mouse lookup to the allow user to search for CASE ID
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

gv_from = 'AC'
Open(w_case_list_response)
if (upper(trim(gv_active_case)) <> 'NONE') then 
	This.text = gv_active_case
end if
end event

event modified;call super::modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type em_reason_code from editmask within w_lead_maintain
string accessiblename = "Reason Code"
string accessibledescription = "Reason Code"
accessiblerole accessiblerole = textrole!
integer x = 521
integer y = 428
integer width = 187
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XX"
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type sle_date_created from singlelineedit within w_lead_maintain
string accessiblename = "Date Created"
string accessibledescription = "Date Created"
accessiblerole accessiblerole = textrole!
integer x = 521
integer y = 332
integer width = 512
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type em_phone_no from editmask within w_lead_maintain
string accessiblename = "Phone Number"
string accessibledescription = "Phone Number"
accessiblerole accessiblerole = textrole!
integer x = 457
integer y = 824
integer width = 622
integer height = 96
integer taborder = 120
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###-###-####"
end type

type st_22 from statictext within w_lead_maintain
string accessiblename = "ID"
string accessibledescription = "ID"
accessiblerole accessiblerole = statictextrole!
integer x = 155
integer y = 68
integer width = 114
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_lead_type from dropdownlistbox within w_lead_maintain
string accessiblename = "Lead Type"
string accessibledescription = "Lead Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 1650
integer y = 236
integer width = 969
integer height = 588
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
string text = " "
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_description from statictext within w_lead_maintain
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 923
integer y = 1104
integer width = 1682
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_12 from statictext within w_lead_maintain
string accessiblename = "ID"
string accessibledescription = "ID"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 240
integer width = 105
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_clear from u_cb within w_lead_maintain
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1673
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 240
integer weight = 400
string text = "C&lear"
end type

event clicked;//*******************************************************************
// 02/05/95 DKG Changed sle to display mm/dd/yy. PROB 126 Stars 3.1
//              Release disk.
// 01/14/99 FNC	TS2020C Stars 4.0 SP1. Change to use server date rather 
//						than PC date.
//	05/17/07	Katie SPR 4948 Enabled cb_model when clear is clicked
//	05/21/07 Katie 	SPR4806 Set modified boolean to false
//	05/21/07 Katie SPR 4806 Added logic to ask user if they wish to save their changes.
//*******************************************************************

Int lv_index
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if Parent.event ue_modified() < 1 THEN Return

ib_modified = false

SLE_CASE_ID.TEXT		  = ''
SLE_LEAD_ID.TEXT		  = ''
sle_dept.text			  = GC_USER_DEPT
sle_rep.text			  = GC_USER_ID
selectitem(ddlb_lead_type,0)
selectitem(ddlb_nature,0)

//sle_receipt_date.text  = STRING(TODAY())
sle_receipt_date.text = inv_sys_cntl.of_get_default_date()

selectitem(ddlb_contact_type,0) 
sle_contact_bene.text  = ''
em_reason_code.text   = ''
sle_first_name.text	  = ''
Sle_last_name.text	  = ''
em_phone_no.text		  = ''
sle_disposition.text   = ''					//KMM 8/4/95 Prob#911
st_description.text     = ''					//KMM 8/4/95 Prob#911
selectitem(ddlb_status,0)

sle_disposition.text   = ''
sle_disp_date.text	  = ''
sle_letterdue_date.text = ''
sle_ack_date.text		  = ''
mle_comments.text		  = ''
sle_contact_desc.text  = ''
//DKG 02/05/95 BEGIN
// FNC 01/14/99 Start
//SLE_DATE_CREATED.TEXT  = STRING(DATETIME(TODAY(),NOW()))
//SLE_DATE_CREATED.TEXT  = string(today())
SLE_DATE_CREATED.TEXT = inv_sys_cntl.of_get_default_date()
// FNC 01/14/99 End
//DKG 02/05/95 END
in_case_id             = ''
in_case_spl            = ''
in_case_ver            = ''
in_LEAD_ID				  = ''

setfocus(sle_case_id)
Parent.event ue_set_mod_availability(false)
Parent.event ue_set_create_availability(true)
Parent.event ue_set_field_availability(true)
cb_retrieve.enabled = true
cb_model.enabled = false
cb_notes.enabled = false
setpointer(arrow!)
end event

type cb_model from u_cb within w_lead_maintain
string accessiblename = "Copy"
string accessibledescription = "Copy"
integer x = 1349
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 230
integer weight = 400
boolean enabled = false
string text = "Co&py"
end type

event clicked;//*******************************************************************
// 02/05/95 DKG Changed sle to display mm/dd/yy. PROB 126 Stars 3.1
//              Release disk.
// 01/14/99 FNC TS202C Stars 4.0 SP1. Use server date rather than PC date.
//	05/17/07 Katie SPR 5017 Removed enable cb_retrieve from this logic
//	05/18/07	Katie	SPR 5016 Properly enable the data window
//	05/21/07 Katie 	SPR4806 Set modified boolean to false
//*******************************************************************

LONG lv_next_LEAD
int lv_count
boolean lb_valid_lead

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if Parent.event ue_modified() < 1 THEN Return

ib_modified = false

SLE_LEAD_ID.TEXT		  = ''
sle_dept.text			  = GC_USER_DEPT
sle_rep.text			  = GC_USER_ID
sle_receipt_date.text = inv_sys_cntl.of_get_default_date()	// 01/14/99 FNC

SLE_DATE_CREATED.TEXt = inv_sys_cntl.of_get_default_date()	// 01/14/99 FNC

in_LEAD_ID				  = ''
Parent.event ue_set_mod_availability(false)
Parent.event ue_set_create_availability(true)
Parent.event ue_set_field_availability(true)
cb_model.enabled = false
cb_notes.enabled = false
setfocus(sle_LEAD_id)

lb_valid_lead = false
do while lb_valid_lead = false and sle_lead_id.text <> 'ERROR'
	sle_lead_id.text = fx_get_next_key_id('LEAD')
	
	Select count(*) 
	into :lv_count
	from LEAD
	where LEAD_ID = Upper( :sle_lead_id.text )
	using stars2ca;

	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error Reading Lead Table: where lead id = ' + sle_lead_id.text)  
		return -1
	end if

	if lv_count > 0 then
	else
		lb_valid_lead = true
	end if

loop
If sle_lead_id.text = 'ERROR' then
	Messagebox('EDIT','Unable to get System Controlled Lead Id, Please enter a Lead ID')
	setfocus(sle_lead_id)
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
setpointer(arrow!)

end event

type mle_comments from multilineedit within w_lead_maintain
string accessiblename = "Comments"
string accessibledescription = "Comments"
accessiblerole accessiblerole = textrole!
integer x = 471
integer y = 1304
integer width = 2139
integer height = 104
integer taborder = 180
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autovscroll = true
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type sle_track_type from singlelineedit within w_lead_maintain
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = textrole!
integer x = 1938
integer y = 64
integer width = 178
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_category from singlelineedit within w_lead_maintain
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = textrole!
integer x = 1239
integer y = 64
integer width = 343
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_lead_id from singlelineedit within w_lead_maintain
string accessiblename = "Lead ID"
string accessibledescription = "Lead ID"
accessiblerole accessiblerole = textrole!
integer x = 192
integer y = 232
integer width = 635
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type ddlb_nature from dropdownlistbox within w_lead_maintain
string accessiblename = "Nature"
string accessibledescription = "Nature"
accessiblerole accessiblerole = comboboxrole!
integer x = 1307
integer y = 336
integer width = 1312
integer height = 692
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_21 from statictext within w_lead_maintain
string accessiblename = "Nature"
string accessibledescription = "Nature"
accessiblerole accessiblerole = statictextrole!
integer x = 1061
integer y = 336
integer width = 229
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Nature:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_20 from statictext within w_lead_maintain
string accessiblename = "Reason/Disc"
string accessibledescription = "Reason/Disc"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 436
integer width = 443
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Reason/Disc:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_19 from statictext within w_lead_maintain
string accessiblename = "Comments"
string accessibledescription = "Comments"
accessiblerole accessiblerole = statictextrole!
integer x = 105
integer y = 1316
integer width = 329
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Comments:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ack_date from singlelineedit within w_lead_maintain
string accessiblename = "Date Acknowledged"
string accessibledescription = "Date Acknowledged"
accessiblerole accessiblerole = textrole!
integer x = 2021
integer y = 1200
integer width = 590
integer height = 88
integer taborder = 170
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_16 from statictext within w_lead_maintain
string accessiblename = "Date Acknowledged"
string accessibledescription = "Date Acknowledged"
accessiblerole accessiblerole = statictextrole!
integer x = 1408
integer y = 1216
integer width = 594
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Date Acknowledged:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_contact_type from dropdownlistbox within w_lead_maintain
string accessiblename = "Contact Type"
string accessibledescription = "Contact Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 457
integer y = 604
integer width = 626
integer height = 232
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_15 from statictext within w_lead_maintain
string accessiblename = "Type"
string accessibledescription = "Type"
accessiblerole accessiblerole = statictextrole!
integer x = 274
integer y = 608
integer width = 165
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_letterdue_date from singlelineedit within w_lead_maintain
string accessiblename = "Letter Due Date"
string accessibledescription = "Letter Due Date"
accessiblerole accessiblerole = textrole!
integer x = 471
integer y = 1200
integer width = 590
integer height = 88
integer taborder = 160
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_14 from statictext within w_lead_maintain
string accessiblename = "Letter Due"
string accessibledescription = "Letter Due"
accessiblerole accessiblerole = statictextrole!
integer x = 110
integer y = 1216
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Letter Due:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within w_lead_maintain
string accessiblename = "Disposition"
string accessibledescription = "Disposition"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 1108
integer width = 370
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Disposition:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_status from dropdownlistbox within w_lead_maintain
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = comboboxrole!
integer x = 471
integer y = 1008
integer width = 1042
integer height = 428
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//*******************************************************************
// 01/14/99 FNC TS202C Stars 4.0 SP1. Use server date rather than PC date.
//	05/21/07 Katie 	SPR4806 Set modified boolean to true
//*******************************************************************

parent.ib_modified = true
//KMM 9/21/95 PROB#964
sle_disp_date.displayonly = false   
sle_disp_date.taborder    = 140    
//sle_disp_date.text = string(today())								// FNC 01/14/99
sle_disp_date.text = inv_sys_cntl.of_get_default_date()		// FNC 01/14/99
end event

type st_8 from statictext within w_lead_maintain
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = statictextrole!
integer x = 201
integer y = 1012
integer width = 247
integer height = 56
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Status:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_last_name from singlelineedit within w_lead_maintain
string accessiblename = "Last Name"
string accessibledescription = "Last Name"
accessiblerole accessiblerole = textrole!
integer x = 1481
integer y = 700
integer width = 1129
integer height = 96
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type sle_first_name from singlelineedit within w_lead_maintain
string accessiblename = "First Name"
string accessibledescription = "First Name"
accessiblerole accessiblerole = textrole!
integer x = 457
integer y = 700
integer width = 626
integer height = 96
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type sle_contact_bene from singlelineedit within w_lead_maintain
string accessiblename = "Patient ID"
string accessibledescription = "-1"
accessiblerole accessiblerole = textrole!
integer x = 2002
integer y = 592
integer width = 613
integer height = 88
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_29 from statictext within w_lead_maintain
string accessiblename = "Patient ID"
string accessibledescription = "Patient ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1746
integer y = 600
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Pat ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_25 from statictext within w_lead_maintain
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = statictextrole!
integer x = 1623
integer y = 68
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Trk Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_24 from statictext within w_lead_maintain
string accessiblename = "Phone"
string accessibledescription = "Phone"
accessiblerole accessiblerole = statictextrole!
integer x = 219
integer y = 836
integer width = 219
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Phone:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_notes from u_cb within w_lead_maintain
string accessiblename = "Notes..."
string accessibledescription = "Notes..."
integer x = 1998
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 250
integer weight = 400
boolean enabled = false
string text = "&Notes..."
end type

event clicked;//===================================================================================
//w_lead_maintain::cb_notes
//Modifications:
//05-12-98	NLG	1. replace notes globals with notes nvo
//09/01/98  AJS   FS362 convert case to case_cntl
//===================================================================================
datetime lv_datetime
string lv_case_id,lv_case_spl,lv_case_ver

Setpointer(Hourglass!)
setmicrohelp(w_main,'Ready')
If trim(sle_case_id.text) = '' then
	Messagebox('EDIT','Enter Case Id')
	setfocus(sle_case_id)
	RETURN
End IF

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

//09/01/98 AJS   FS362 convert case to case_cntl
select case_datetime into :lv_datetime
		from case_CNTL
		where case_id = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox ('EDIT','Case Must exist on Database to add a NOTE')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
			Errorbox(stars2ca,'Error Reading Case Database')
			RETURN
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
n_cst_notes lnv_notes
lnv_notes.is_notes_from = 'CA'
lnv_notes.is_notes_rel_id = sle_case_id.text
lnv_notes.idt_notes_date   = date(lv_datetime)
OpenSheetWithParm(W_NOTES_LIST,lnv_notes,MDI_Main_Frame,Help_Menu_Position,Layered!)

Setpointer(arrow!)
end event

type cb_close from u_cb within w_lead_maintain
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2322
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 260
integer weight = 400
string text = "&Close"
end type

event clicked;Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if Parent.event ue_modified() < 1 THEN Return

close(parent)
setpointer(arrow!)
end event

type cb_delete from u_cb within w_lead_maintain
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1024
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 220
integer weight = 400
string text = "&Delete"
end type

event clicked;// FDG  10/11/01	Stars 4.8.1.	Add case_log entry.
// SAH  05/07/02  Stars 5.1 Track 2996 Prohibit user from deleting leads if case has 
//													been referred.

String lv_case_ACTIVE
int lv_button_nbr, lv_count_cases,lv_row
Boolean lb_valid_case

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//  Edit to insure a retrieve was done before delete.
//If ((gv_user_sl<>'AD') or (gv_user_sl<>'SA')) then  
If((gv_user_sl = 'AD') or (gv_user_sl = 'SA')) then
	setfocus(sle_contact_desc)
Else
   Messagebox ('EDIT','No Authority to Delete a Lead')
	this.enabled = false
	cb_close.default = true
	RETURN
End If 

// SAH 05/07/02 Track 2996 -Begin
lb_valid_case = Parent.Event ue_edit_case_referred(in_case_id, in_case_spl, in_case_ver)
IF lb_valid_case = FALSE THEN
	// Case has been referred, cannot delete leads
	MessageBox('EDIT', 'This Case Has Been Referred.  No Leads May Be Deleted.')
	Return
END IF


If trim(sle_case_id.text) = '' then
	Messagebox('EDIT','Enter Case Id')
	setfocus(sle_case_id)
	RETURN
End If

If sle_LEAD_ID.text = '' then
	setfocus(sle_lead_id)
   Messagebox ('EDIT','Lead Id is required for Delete')
	Return
End If 

lv_case_active = in_case_id + in_case_spl + in_case_ver
If sle_case_id.text <> lv_case_active OR &
	sle_lead_id.text <> in_lead_id then
	Messagebox ('EDIT','Must First Retrieve Case Lead Before updating')
	this.enabled = false
	RETURN
End If

lv_button_nbr = MessageBox ('CONFIRMATION!', 'Proceed with Deleting Lead', &
                   Question!,YesNo!,2)
If lv_button_nbr = 2 then
	setfocus(SLE_LEAD_ID)
  	Return
End If

Delete from Lead
       where	lead_id		= Upper( :in_lead_id ) and
					case_id	 	= Upper( :IN_case_id ) and	
					case_spl		= Upper( :IN_case_spl ) and
					case_ver		= Upper( :IN_Case_ver )
using stars2ca;
If stars2ca.of_check_status() = 100 Then
	Errorbox(stars2ca,'Lead has already been deleted')
	Setfocus(SLE_LEAD_ID)
	RETURN	
ElseIf stars2ca.sqlcode <> 0 Then
		Errorbox(stars2ca,'Error Deleting from Lead Table')
		Setfocus(SLE_LEAD_ID)
		RETURN	
End If

// FDG 10/11/01 begin
String	ls_message
Integer	li_rc

ls_message	=	"Lead "	+	in_lead_id	+	" removed from case."

li_rc			=	inv_case.uf_audit_log ( in_case_id, in_case_spl, in_Case_ver, ls_message )

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for lead '	+	in_lead_id	+	&
					'.  Case: ' + in_case_id + in_case_spl + in_Case_ver + '. Script: '		+	&
					'w_lead_maintain.cb_delete.clicked')
	Return
END IF
// FDG 10/11/01 end

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
Setmicrohelp(w_main,'Lead Deleted')

TRIGGEREVENT(CB_CLEAR,CLICKED!)

end event

type cb_add from u_cb within w_lead_maintain
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 699
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 210
integer weight = 400
string text = "Crea&te"
end type

event clicked;//***************************************************************************************
// DKG 01/30/96 Added check to disallow the user to enter leads for 
//              a potential case. PROB 69 Stars 3.1 Release disk.
//
// DKG 01/31/96 Added argument for fx_create_new_case to set category
//              to COM for cases created from Lead List.
//
// FNC 06/18/97 FS/TS154 Check security before opening detail window
//				   	This will make sure all case security is consistent
// 09/01/98 AJS FS362 convert case to case_cntl
// 01/13/99 FNC	TS2040C Stars 4.0 SP1
//						Require user to input 4 digit year. Replace edits in cb_update and
//						cb_add with one event
//	12/05/00	FDG	Stars 4.7.  Make error checking DBMS-independent
// 01/09/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 10/12/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	10/11/01	FDG   Stars 4.8.1.	Add case_log entry.
// 05/07/02 SAH   Stars 5.1 Track 2996 Disable cb_delete if case has been referred
//	07/29/02	GaryR	Track 3215d	Invalid case log generated from System case.
// 12/09/04	Jason Track 3664d Case Component Update
//	01/07/05	GaryR	Track 7184c	Trim excess spaces from codes
//	05/18/07	Katie		SPR 5015 Added check to verify Lead doesn't already exist
//							before inserting into lead table.
//							SPR 5018 Added script to determine if case is Referred Closed or Deleted before
//							adding a lead
//	05/23/07 Katie		SPR 5016 Altered the edits and processing of Case ID based on length
//	05/31/07 Katie		SPR 5018 Ensured that existing cases were evaluated for Case Component Security
//							when they were entered as a 10 character case_id.
//***************************************************************************************

String 	lv_case_id,lv_case_spl,lv_case_ver, lv_max_ver
Date     lv_init_DATE
TIME		lv_init_time
Datetime lv_created_datetime
String	lv_nature,lv_lead_type,lv_contact_type
String	lv_status,lv_disposition
Int		lv_pos
String   lv_phone
int      lv_rc, lv_count
string   lv_case
boolean  lv_create_case = false, lb_valid_case, lb_valid_lead
string   lv_check_case,lv_check_case_spl,lv_check_case_ver
int 		lv_len
string	ls_dept_code,	ls_empty
int		li_code_sec
int 		li_rc

String	ls_rsn_cd, ls_fname, ls_lname, ls_comments, ls_contact	// 10/12/01	GaryR	Stars 4.7 DataBase Port

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

lv_init_date = date(1900,01,01)
lv_init_time = time(00,00,01)
cb_add.default = true
setfocus(sle_lead_id)

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

Li_rc = parent.event ue_edit_dates()
If li_rc = -1 then return -1

lv_created_datetime = gnv_app.of_get_server_date_Time()

lv_nature  = left(ddlb_nature.text,3)
lv_contact_type = left(ddlb_contact_type.text,3)
If trim(lv_contact_type) = '' then
	selectitem(ddlb_contact_type,1)
	Messagebox('EDIT','Must Select Contact type')
	setfocus(ddlb_contact_type)
	RETURN -1
End IF

lv_status    = left(ddlb_status.text,2)
lv_disposition = trim(sle_disposition.text)
lv_phone = left(em_phone_no.text,3) + mid(em_phone_no.text,5,3) + mid(em_phone_no.text,9,4)

lv_lead_type = left(ddlb_lead_type.text,3)
If trim(lv_lead_type) = '' then
	Messagebox('EDIT','Must Select Lead Source')    //Alabama4 pat-d
	setfocus(ddlb_lead_type)
	RETURN -1
End IF

If trim(sle_contact_bene.text) <> '' then                 //ALABAMA2 PAT-D
	if len(trim(sle_contact_bene.text)) < 10 then          //ALABAMA2 PAT-D
		Messagebox('EDIT','Patient Id field length must be greater than or equal to 10')                 //ALABAMA2 PAT-D
		setfocus(sle_contact_bene)                  //ALABAMA2 PAT-D
		RETURN  -1                                //ALABAMA2 PAT-D
	End IF                                        //ALABAMA2 PAT-D
Else
	sle_contact_bene.text = ls_empty					// 01/09/01	GaryR	Stars 4.7 DataBase Port
End IF                                          //ALABAMA2 PAT-D

If lv_disposition <> '' then
	Select code_desc into :st_description.text
			from code
			where code_type = 'LD' and
					code_code = Upper( :sle_disposition.text )
	Using Stars2ca;
	If Stars2ca.of_check_status() = 100 then
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return -1
		End If	
		Messagebox('EDIT','Disposition Code is not valid')
		st_description.text = ''
		setfocus(sle_disposition)
		RETURN -1
	Elseif stars2ca.sqlcode <> 0 then
			 Errorbox(stars2ca,'Error getting Disposition Code')
			 st_description.text = ''
			 setfocus(sle_disposition)
			 RETURN -1
	End If		
End If

// 01/09/01	GaryR	Stars 4.7 DataBase Port - Begin			// FDG 04/16/01
ls_rsn_cd	= Trim( em_reason_code.text )
ls_fname		= Trim( sle_first_name.text )
ls_lname		= Trim( sle_last_name.text )
ls_comments	= Trim( mle_comments.text )
ls_contact	= Trim( sle_contact_desc.text )
IF ls_rsn_cd	= "" THEN ls_rsn_cd		= ls_empty
IF ls_fname		= "" THEN ls_fname		= ls_empty
IF ls_lname		= "" THEN ls_lname		= ls_empty
IF ls_comments	= "" THEN ls_comments	= ls_empty
IF ls_contact	= "" THEN ls_contact		= ls_empty
IF Trim( lv_phone )					= "" THEN lv_phone					= ls_empty
IF Trim( lv_disposition )			= "" THEN lv_disposition			= ls_empty
// 01/09/01	GaryR	Stars 4.7 DataBase Port - End

if (len(sle_case_id.text) = 10) then
		lv_check_case = left(sle_case_id.text,10)	
		lv_check_case_spl = '00'
		Select max(case_ver), count(*)
		into :lv_max_ver, :lv_count
		From Case_CNTL
		Where Case_ID = Upper( :lv_check_case )
		Using Stars2ca;
		if stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error Reading Case Table: where case id = ' + lv_check_case)  
			return -1
		end if
		if (lv_count = 0) then //New Case
			lv_check_case_ver = '00'
			lv_case = lv_check_case + lv_check_case_spl + lv_check_case_ver
			sle_case_id.text = lv_case
			if inv_case.uf_get_comp_upd_status_lead( "CASELEADS", lv_check_case, lv_check_case_spl, lv_check_case_ver) = 'RO' &
				or NOT inv_case.uf_edit_case_deleted(lv_check_case, lv_check_case_spl, lv_check_case_ver)then
				messagebox("Error", "Cannot create case lead because this case is Closed, Deleted or Referred Closed")
				Return -1
			end if
			lv_rc = messagebox('Information','A new case will be created for this lead.  Do you want to continue?',Information!,OKCancel!,2)
			if lv_rc = 2 then	return -1
			lv_create_case = true
		else // Case Exists
			lv_check_case_ver = lv_max_ver
			lv_case = lv_check_case + lv_check_case_spl  + lv_check_case_ver
			sle_case_id.text = lv_case
			if inv_case.uf_get_comp_upd_status_lead( "CASELEADS", lv_check_case, lv_check_case_spl, lv_check_case_ver) = 'RO' &
				or NOT inv_case.uf_edit_case_deleted(lv_check_case, lv_check_case_spl, lv_check_case_ver)then
				messagebox("Error", "Cannot create case lead because this case is Closed, Deleted or Referred Closed")
				Return -1
			end if
			lv_rc = messagebox('Information','New lead will be added to case ' + lv_case + '~r Do you want to continue?',Information!,OKCancel!,2)
			if lv_rc = 2 then	return -1
		end if
elseif (len(sle_case_id.text) = 14) then
		lv_case = sle_case_id.text
		lv_check_case = left(lv_case,10)	
		lv_check_case_spl = mid(lv_case, 11,2)
		lv_check_case_ver = mid(lv_case, 13,2)
		Select count(*)
		into :lv_count
		From Case_CNTL
		Where Case_ID = Upper( :lv_check_case )
		And   Case_SPL = Upper( :lv_check_case_spl )
		And   Case_VER = Upper( :lv_check_case_ver )
		Using Stars2ca;
		if stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error Reading Case Table: where case id = ' + lv_case)  
			return -1
		end if
		if lv_count = 0 then
			Messagebox('EDIT','Case does not exist.')
			setmicrohelp(w_main,'Ready')
			Setfocus(sle_case_id)
			RETURN -1
		end if
		if inv_case.uf_get_comp_upd_status_lead( "CASELEADS", lv_check_case, lv_check_case_spl, lv_check_case_ver) = 'RO' &
			or NOT inv_case.uf_edit_case_deleted(lv_check_case, lv_check_case_spl, lv_check_case_ver)then
			messagebox("Error", "Cannot create case lead because this case is Closed, Deleted or Referred Closed")
			Return -1
		end if

elseif trim(sle_case_id.text) = '' then
		lv_rc = messagebox('Information','A new case will be created for this lead.  Do you want to continue?',Information!,OKCancel!,2)
		if lv_rc = 2 then	return -1
		lv_create_case = true
else	
		messagebox('EDIT','Case ID Must Be 10 Characters for a New Case and 10 or 14 Characters for an Existing Case',Exclamation!)
		setfocus(sle_case_id)
		return -1
end if


If trim(sle_lead_id.text) = '' then
	lb_valid_lead = false
	do while lb_valid_lead = false and sle_lead_id.text <> 'ERROR'
		sle_lead_id.text = fx_get_next_key_id('LEAD')
		
		Select count(*) 
		into :lv_count
		from LEAD
		where LEAD_ID = Upper( :sle_lead_id.text )
		using stars2ca;

		if stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error Reading Lead Table: where lead id = ' + sle_lead_id.text)  
			return -1
		end if

		if lv_count > 0 then
		else
			lb_valid_lead = true
		end if

	loop
	If sle_lead_id.text = 'ERROR' then
		Messagebox('EDIT','Unable to get System Controlled Lead Id, Please enter a Lead ID')
		setfocus(sle_lead_id)
		RETURN -1
	End IF
End If

Select count(*) 
into :lv_count
from LEAD
where LEAD_ID = Upper( :sle_lead_id.text )
using stars2ca;

if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error Reading Lead Table: where lead id = ' + sle_lead_id.text)  
	return -1
end if

if lv_count > 0 then
	Messagebox('EDIT','Lead Exists with Lead ID ' + sle_lead_id.text + '.')
	setmicrohelp(w_main,'Ready')
	Setfocus(sle_lead_id)
	RETURN -1
end if

if lv_create_case = true then
	lv_case = inv_case.uf_create_case( lv_case, TRUE )
	if lv_case = 'ERROR' then 
		return -1
	elseif lv_case = 'EXISTS' then
		setfocus(sle_case_id)
		return -1
	end if
	sle_case_id.text = lv_case
end if

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)
// 09/01/98 AJS   FS362 convert case to case_cntl
Select case_trk_type,case_cat
		into :sle_track_type.text,:sle_category.text
		from Case_CNTL
		where Case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return -1
	End If	
	Messagebox('EDIT','Case Does Not Exist')
	sle_case_id.setfocus()
	RETURN
Elseif	stars2ca.sqlcode <> 0 then
			Errorbox(stars2ca,'Error Reading Case Table')
			RETURN -1
End If

COMMIT USING STARS2CA;

If TRIM(sle_category.text) = 'CA?' THEN
	Messagebox('EDIT','Leads cannot be created for a Potential Case,'  + &
				  ' Update Case Category ')
	sle_case_id.setfocus()
   RETURN -1
End If

Select code_value_a,code_value_n
	into :ls_dept_code, :li_code_sec
	from CODE
	where  code.code_code = Upper( :sle_category.text ) and
			code.code_type = 'CA' 
	using stars2ca;
	If stars2ca.of_check_status() = 100 then
		Errorbox(stars2ca,'Case Category Code not found')
		return -1
	Elseif stars2ca.sqlcode <> 0 Then
		Errorbox(stars2ca,'Error Reading code Table for Category Code')
		return -1
	End If

If ls_dept_code <> gc_user_dept then
	If li_code_sec = 1 Then
		Messagebox('EDIT','This is a Secured Case you have insufficient privileges for adding leads')
		return - 1
	End If
End If

// FDG 10/11/01 add case_log
String	ls_message

ls_message	=	"Lead "	+	sle_lead_id.text	+	" added to case."

li_rc			=	inv_case.uf_audit_log ( lv_case_id, lv_case_spl, lv_Case_ver, ls_message )

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for lead '	+	sle_lead_id.text	+	&
					'.  Case: ' + lv_case_id + lv_case_spl + lv_Case_ver + '. Script: '		+	&
					'w_lead_maintain.cb_add.clicked')
	Return -1
END IF
// FDG 10/11/01 end

// Trim codes to remove any exess spaces
gnv_sql.of_trimdata( lv_nature )
gnv_sql.of_trimdata( lv_contact_type )
gnv_sql.of_trimdata( lv_status )
gnv_sql.of_trimdata( lv_lead_type )

// 10/12/01	GaryR	Stars 4.7 DataBase Port - Begin
Insert into Lead
		 (DEPT_ID, USER_ID,
		  CASE_ID, CASE_SPL, CASE_VER,
		  LEAD_ID, LEAD_TYPE,
		  NATURE,  
		  RECV_DATE, CONTACT_TYPE,
		  SOURCE_ID,
		  REASON_CODE,
		  FIRST_NAME, LAST_NAME, PHONE,
		  STATUS, DISP, DISP_DATE,
		  LTR_DUE_DATE, DATE_AK,
		  FOLLOW_UP_CMT, LEAD_DESC,
		  DATE_CREATED)
	Values
		 (:gc_user_dept,:gc_user_id,
		  :lv_case_id,:lv_case_spl,:lv_case_ver,
		  :sle_lead_id.text,:lv_lead_type,
		  :lv_nature,
		  :idt_receipt_datetime,:lv_contact_type,
		  :sle_contact_bene.text,
		  :ls_rsn_cd,	//:em_reason_code.text,
		  :ls_fname, :ls_lname, :lv_phone,	//:sle_first_name.text,:sle_last_name.text,
		  :lv_status,:lv_disposition,
		  :idt_disp_datetime,
		  :idt_letter_due_datetime,
		  :idt_ack_datetime,
		  :ls_comments, :ls_contact,	//:mle_comments.text,:sle_contact_desc.text,
		  :lv_CREATED_datetime)
Using Stars2ca;
// 10/12/01	GaryR	Stars 4.7 DataBase Port - End

If stars2ca.of_check_status() <> 0 then
	// FDG 12/05/00 - Make SQL error checking DBMS independent
	//If stars2ca.sqldbcode = gv_sql_dup or stars2ca.sqldbcode = gv_sql_dup2 then 
	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return -1
		End If	
		Messagebox('ERROR','Lead Already Exists for this Case')
		RETURN -1
	Else
		Errorbox(stars2ca,'Error Writing to Lead')
		RETURN -1
	End If
End If

setmicrohelp(w_main,'Lead Added')

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return -1
End If	
in_lead_id = sle_LEAD_ID.TEXT
in_case_id        = LV_CASE_ID
in_case_spl       = lv_case_spl
in_case_ver       = lv_case_ver
setfocus(sle_contact_desc)

ib_new_lead = FALSE

this.enabled = false
setpointer(arrow!)

// SAH 05/07/02 Track 2996 -Begin
// Disable cb_delete if case has been referred
Parent.event ue_set_update_availability(false) //SPR 4726
Parent.Event ue_edit_case_referred(lv_case_id, lv_case_spl, lv_case_ver)

ib_modified = false
end event

type cb_retrieve from u_cb within w_lead_maintain
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 55
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 190
integer weight = 400
boolean enabled = false
string text = "&Retrieve"
boolean default = true
end type

event clicked;//**********************************************************************************
// DKG 02/05/96	Changed date to display as mm/dd/yy. PROB 126 Stars
//             	3.1 Release disk.
// FNC 06/18/97	FS/TS154 Check security before opening detail window
//				   	This will make sure all case security is consistent
// 09/01/98 AJS	FS362 convert case to case_cntl
// 01/14/99 FNC	TS2040C Stars 4.0 SP1. Must display four digit date so will
//						pass edits in ue_edit_dates
//	01/19/99	FDG	Track 2055c.  Use 4 digit year in comparisons.
//	09/21/01	FDG	Stars 4.8.1  Prevent updates if the case is closed or deleted
// 05/07/02 SAH   Stars 5.1 Track 2996 Disable cb_delete if case has been referred
// 12/9/04 JasonS Track 3664 Case Component Update
//**********************************************************************************


string   lv_case_id,lv_case_spl,lv_case_ver
string ls_dept_code
int li_code_sec
Datetime	lv_ack_date,lv_letterdue_date,lv_receipt_date,lv_disp_date

datetime lv_hold					//DKG 02/05/96



setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

setfocus(sle_case_id)
If sle_case_id.text = '' then
	Messagebox('EDIT','Case ID is required')
	RETURN
End If

//06-18-97 FNC Start
if len(sle_case_id.text) <> 14 then
	messagebox('EDIT','Case ID must be 14 positions')
	return
end if
//06-18-97 FNC End 

If sle_lead_id.text = '' then
	Messagebox('EDIT','Lead ID is required')
	RETURN
End If

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

//06-18-97 FNC Start
//09/01/98 AJS   FS362 convert case to case_cntl
Select code_value_a,code_value_n
	into :ls_dept_code, :li_code_sec
	from CODE,CASE_CNTL
	where case_cntl.case_id = Upper( :lv_case_id ) and
			case_cntl.case_spl = Upper( :lv_case_spl ) and
			case_cntl.case_ver = Upper( :lv_case_ver ) and
			case_cntl.case_cat = code.code_code and
			code.code_type = 'CA' 
	using stars2ca;
	If stars2ca.of_check_status() = 100 then
		Errorbox(stars2ca,'Case Category Code not found')
		return
	Elseif stars2ca.sqlcode <> 0 Then
		Errorbox(stars2ca,'Error Reading code Table for Category Code')
		return
	End If

If ls_dept_code <> gc_user_dept then
	If li_code_sec = 1 Then
		Messagebox('EDIT','This is a Secured Case you have insufficient privileges for retrieving leads')
		return
	End If
End If
//06-18-97 FNC End

Select case_trk_type,case_cat
		into :sle_track_type.text,:sle_category.text
		from Case_CNTL
		where Case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
Using stars2ca;

If stars2ca.of_check_status() = 100 then       //11-29-94 FNC Start
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox('ERROR','Case not Found')
	return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Reading Case Table')
	RETURN
End If                               //11-29-94 FNC End

If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'Error Reading Case Table')
	RETURN
End If

COMMIT USING STARS2CA;

SELECT  DEPT_ID, USER_ID,
		  CASE_ID, CASE_SPL, CASE_VER,
		  LEAD_ID, LEAD_TYPE,
		  NATURE,  
		  RECV_DATE, CONTACT_TYPE,
		  SOURCE_ID,
		  REASON_CODE,
		  FIRST_NAME, LAST_NAME, PHONE,
		  STATUS, DISP, DISP_DATE,
		  LTR_DUE_DATE, DATE_AK,
		  FOLLOW_UP_CMT, LEAD_DESC,
		  DATE_CREATED
	INTO
		  :sle_dept.text,:sle_rep.text,
		  :in_case_id,:in_case_spl,:in_case_ver,
		  :In_lead_id,:ddlb_lead_type.text,
		  :ddlb_nature.text,
		  :lV_receipt_date,:ddlb_contact_type.text,
		  :sle_contact_bene.text,
		  :em_reason_code.text,
		  :sle_first_name.text,:sle_last_name.text,:em_phone_no.text,
		  :ddlb_status.text,:sle_disposition.text,
		  :lv_disp_date,
		  :lv_letterdue_date,
		  :lv_ack_date,
		  :mle_comments.text,:sle_contact_desc.text,
		  :lv_hold
	From Lead
	where CASE_ID  = Upper( :lv_case_id ) and
			CASE_SPL = Upper( :lv_case_spl ) and
			CASE_VER = Upper( :lv_case_ver ) and
			lead_id  = Upper( :sle_lead_id.text )
Using Stars2ca;

//DKG 02/05/96 BEGIN
SLE_DATE_CREATED.TEXT = STRING(DATE(lv_hold),'mm/dd/yyyy')
//DKG 02/05/96 END

If stars2ca.of_check_status() = 100 then 
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox('ERROR','Lead not Found')
	return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Reading Lead')
	RETURN
End If

If trim(sle_disposition.text) <> '' then
	Select code_desc into :st_description.text
		from code
		where code_type = 'LD' and
				code_code = Upper( :sle_disposition.text )
	Using Stars2ca;
	If Stars2ca.of_check_status() <> 0 then
		Messagebox('EDIT','Unable to read Disposition Code.  Database Error is ' + string(stars2ca.sqlcode))
	End If
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	

//If string(date(lV_receipt_date)) = '1/1/00' then		// FDG 01/19/99
If string(date(lV_receipt_date), 'mm/dd/yyyy') = '01/01/1900' then		// FDG 01/19/99
	sle_RECEIPT_date.text = ''
Else
	sle_RECEIPT_date.text = string(date(lv_receipt_date),'mm/dd/yyyy')
End If

//If string(date(lV_disp_date)) = '1/1/00' then		// FDG 01/19/99
If string(date(lV_disp_date), 'mm/dd/yyyy') = '01/01/1900' then		// FDG 01/19/99
	sle_disp_date.text = ''
Else
	sle_disp_date.text = string(date(lv_disp_date),'mm/dd/yyyy')
End If

//KMM 9/21/95 PROB#964
sle_disp_date.displayonly = true   //alabama4 pat-d
sle_disp_date.taborder    = 0      //alabama4 pat-d
//KMM END

//If string(date(lV_letterdue_date)) = '1/1/00' then		// FDG 01/19/99
If string(date(lV_letterdue_date), 'mm/dd/yyyy') = '01/01/1900' then		// FDG 01/19/99
	sle_letterdue_date.text = ''
Else
	sle_letterdue_date.text = string(date(lv_letterdue_date),'mm/dd/yyyy')
End If

//If string(date(lV_ack_date)) = '1/1/00' then		// FDG 01/19/99
If string(date(lV_ack_date), 'mm/dd/yyyy') = '01/01/1900' then		// FDG 01/19/99
	sle_ack_date.text = ''
Else
	sle_ack_date.text = string(date(lv_ack_date),'mm/dd/yyyy')
End If

sle_lead_id.text       = in_lead_id

// FDG 09/21/01 - Prevent updates if the case is closed or deleted
parent.event ue_set_update_availability(false)
//Parent.Event	ue_edit_case_closed()

// SAH 05/07/02 Track 2996 -Begin
// Disable cb_delete if case has been referred
Parent.Event ue_edit_case_referred(lv_case_id, lv_case_spl, lv_case_ver)

cb_retrieve.enabled = false

ib_modified = false

setpointer(arrow!)

end event

type st_18 from statictext within w_lead_maintain
string accessiblename = "Created"
string accessibledescription = "Created"
accessiblerole accessiblerole = statictextrole!
integer x = 96
integer y = 336
integer width = 411
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Created:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_disp_date from singlelineedit within w_lead_maintain
string accessiblename = "Disposition Date"
string accessibledescription = "Disposition Date"
accessiblerole accessiblerole = textrole!
integer x = 2021
integer y = 1004
integer width = 590
integer height = 88
integer taborder = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_17 from statictext within w_lead_maintain
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = statictextrole!
integer x = 1691
integer y = 1004
integer width = 311
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_lead_maintain
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 919
integer y = 448
integer width = 370
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within w_lead_maintain
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = statictextrole!
integer x = 1129
integer y = 600
integer width = 165
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_dept from singlelineedit within w_lead_maintain
string accessiblename = "Department"
string accessibledescription = "Department"
accessiblerole accessiblerole = textrole!
integer x = 2359
integer y = 64
integer width = 229
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
integer limit = 1
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_rep from singlelineedit within w_lead_maintain
string accessiblename = "Rep"
string accessibledescription = "Rep"
accessiblerole accessiblerole = textrole!
integer x = 978
integer y = 232
integer width = 425
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_receipt_date from singlelineedit within w_lead_maintain
string accessiblename = "Receipt Date"
string accessibledescription = "Receipt Date"
accessiblerole accessiblerole = textrole!
integer x = 1303
integer y = 596
integer width = 398
integer height = 88
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type sle_contact_desc from singlelineedit within w_lead_maintain
string accessiblename = "Contact Description"
string accessibledescription = "Contact Description"
accessiblerole accessiblerole = textrole!
integer x = 1307
integer y = 428
integer width = 1129
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 60
borderstyle borderstyle = stylelowered!
end type

event modified;//	05/21/07 Katie 	SPR4806 Set modified boolean to true
parent.ib_modified = true
end event

type st_7 from statictext within w_lead_maintain
string accessiblename = "Last Name"
string accessibledescription = "Last Name"
accessiblerole accessiblerole = statictextrole!
integer x = 1102
integer y = 720
integer width = 361
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Last Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_lead_maintain
string accessiblename = "First Name"
string accessibledescription = "First Name"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 716
integer width = 361
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "First Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_lead_maintain
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = statictextrole!
integer x = 942
integer y = 68
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Category:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_lead_maintain
string accessiblename = "Rep"
string accessibledescription = "Rep"
accessiblerole accessiblerole = statictextrole!
integer x = 837
integer y = 240
integer width = 137
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Rep:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_lead_maintain
string accessiblename = "Department"
string accessibledescription = "Department"
accessiblerole accessiblerole = statictextrole!
integer x = 2176
integer y = 68
integer width = 155
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Dept:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_lead_maintain
string accessiblename = "Source"
string accessibledescription = "Source"
accessiblerole accessiblerole = statictextrole!
integer x = 1408
integer y = 240
integer width = 238
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Source:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_lead_maintain
string accessiblename = "Follow Up"
string accessibledescription = "Follow Up"
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer y = 944
integer width = 2592
integer height = 476
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Follow Up"
end type

type gb_3 from groupbox within w_lead_maintain
string accessiblename = "Contact"
string accessibledescription = "Contact"
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer y = 540
integer width = 2592
integer height = 404
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Contact"
end type

type gb_2 from groupbox within w_lead_maintain
string accessiblename = "Lead"
string accessibledescription = "Lead"
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer y = 168
integer width = 2592
integer height = 372
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Lead"
end type

type gb_1 from groupbox within w_lead_maintain
string accessiblename = "Case"
string accessibledescription = "Case"
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer width = 2592
integer height = 168
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Case"
end type

type cb_update from u_cb within w_lead_maintain
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 384
integer y = 1444
integer width = 311
integer height = 108
integer taborder = 200
integer weight = 400
string text = "&Update"
end type

event clicked;//*********************************************************************************
// 01/13/99 FNC	TS2040C Stars 4.0 SP1. Created.
//						Require user to input 4 digit year. Replace edits in cb_update and
//						cb_add with one event
// 01/09/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 10/12/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	10/11/01	FDG	Stars 4.8.1.	Add case_log
//	01/07/05	GaryR	Track 7184c	Trim excess spaces from codes
//*********************************************************************************

String 	lv_case_id,lv_case_spl,lv_case_ver
String	lv_case_active
Date     lv_init_DATE
TIME		lv_init_time
Datetime lv_created_datetime
String	lv_nature,lv_lead_type,lv_contact_type
String	lv_status,lv_disposition
Int		lv_pos,li_rc
String   lv_phone, ls_empty
n_cst_datetime lnvo_cst_datetime

String	ls_rsn_cd, ls_fname, ls_lname, ls_comments, ls_contact	// 10/12/01	GaryR	Stars 4.7 DataBase Port

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
//lv_init_date = date(1900,01,01)
lv_init_date = lnvo_cst_datetime.of_getminimumdate()	// FNC 01/13/99
lv_init_time = time(00,00,01)
cb_add.default = true
setfocus(sle_lead_id)

If trim(sle_case_id.text) = '' then
	Messagebox('EDIT','Enter Case Id')
	setfocus(sle_case_id)
	RETURN
End If

If trim(sle_lead_id.text) = '' then
	Messagebox('EDIT','Enter Lead Id')
	RETURN
End If

lv_case_active = in_case_id + in_case_spl + in_case_ver
If sle_case_id.text <> lv_case_active OR &
	sle_lead_id.text <> in_lead_id then
	Messagebox ('EDIT','Must First Retrieve Case Lead Before updating')
	this.enabled = false
	RETURN
End If

Li_rc = parent.event ue_edit_dates()
If li_rc = -1 then return
// FNC 01/14/99 End

lv_nature  = left(ddlb_nature.text,3)
lv_lead_type = left(ddlb_lead_type.text,3)
If trim(lv_lead_type) = '' then
	selectitem(ddlb_lead_type,1)
	Messagebox('EDIT','Must Select Lead Source')     //Alabama4 pat-d
	setfocus(ddlb_lead_type)
	RETURN
End IF

lv_contact_type = left(ddlb_contact_type.text,3)
If trim(lv_contact_type) = '' then
	selectitem(ddlb_contact_type,1)
	Messagebox('EDIT','Must Select Contact type')
	setfocus(ddlb_contact_type)
	RETURN
End IF

If trim(sle_contact_bene.text) <> '' then                //ALABAMA2 PAT-D
	if len(trim(sle_contact_bene.text)) < 10 then         //ALABAMA2 PAT-D
		Messagebox('EDIT','Bene Id field length must be greater than or equal to 10')                //ALABAMA2 PAT-D
		setfocus(sle_contact_bene)                //ALABAMA2 PAT-D
		RETURN                                    //ALABAMA2 PAT-D
	End IF                                      //ALABAMA2 PAT-D
Else
	sle_contact_bene.text = " "
End IF                                         //ALABAMA2 PAT-D

lv_status    = left(ddlb_status.text,2)
lv_disposition = trim(sle_disposition.text)
lv_phone = left(em_phone_no.text,3) + mid(em_phone_no.text,5,3) + mid(em_phone_no.text,9,4)

If lv_disposition <> '' then
	Select code_desc into :st_description.text
		from code
		where code_type = 'LD' and
				code_code = Upper( :sle_disposition.text )
	Using Stars2ca;
	If Stars2ca.of_check_status() =  100 then
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return
		End If	
		st_description.text = ''
		setfocus(sle_disposition)
		Messagebox('EDIT','Invalid Disposition Code')
		RETURN
	ElseIf Stars2ca.sqlcode <> 0 then
		st_description.text = ''
		setfocus(sle_disposition)
		Errorbox(Stars2ca,'Error getting Disposition Code')
		RETURN
	End If
End IF

// 01/09/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
ls_rsn_cd	= Trim( em_reason_code.text )
ls_fname		= Trim( sle_first_name.text )
ls_lname		= Trim( sle_last_name.text )
ls_comments	= Trim( mle_comments.text )
ls_contact	= Trim( sle_contact_desc.text )
IF ls_rsn_cd	= "" THEN ls_rsn_cd		= ls_empty
IF ls_fname		= "" THEN ls_fname		= ls_empty
IF ls_lname		= "" THEN ls_lname		= ls_empty
IF ls_comments	= "" THEN ls_comments	= ls_empty
IF ls_contact	= "" THEN ls_contact		= ls_empty
IF Trim( lv_phone )					= "" THEN lv_phone					= ls_empty
IF Trim( lv_disposition )			= "" THEN lv_disposition			= ls_empty
// 01/09/01	GaryR	Stars 4.7 DataBase Port - End

// FDG 10/11/01 add case_log
String	ls_message

ls_message	=	"Lead "	+	in_lead_id	+	" changed."

li_rc			=	inv_case.uf_audit_log ( in_case_id, in_case_spl, in_Case_ver, ls_message )

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for lead '	+	in_lead_id	+	&
					'.  Case: ' + in_case_id + in_case_spl + in_Case_ver + '. Script: '		+	&
					'w_lead_maintain.cb_update.clicked')
	Return
END IF
// FDG 10/11/01 end

// Trim codes to remove any exess spaces
gnv_sql.of_trimdata( lv_nature )
gnv_sql.of_trimdata( lv_contact_type )
gnv_sql.of_trimdata( lv_status )
gnv_sql.of_trimdata( lv_lead_type )

// 10/12/01	GaryR	Stars 4.7 DataBase Port - Begin
Update Lead
	Set   DEPT_ID		=	:gc_user_dept,
			USER_ID		=	:gc_user_id,
			LEAD_TYPE	=	:lv_lead_type,
		   NATURE		=	:lv_nature,  
		   RECV_DATE	=	:idt_receipt_datetime,
			CONTACT_TYPE = :lv_contact_type,
		   SOURCE_ID	=	:sle_contact_bene.text,
		   REASON_CODE =  :ls_rsn_cd, 	//:em_reason_code.text,
		   FIRST_NAME	=	:ls_fname,		//:sle_first_name.text,
			LAST_NAME	=	:ls_lname,		//:sle_last_name.text,
			PHONE			=	:lv_phone,
		   STATUS		=	:lv_status,
			DISP			=	:lv_disposition,
			DISP_DATE	=	:idt_disp_datetime,
		   LTR_DUE_DATE=	:idt_letter_due_datetime,
			DATE_AK		=	:idt_ack_datetime,					//Archana 4-15-99 Uncommented this line  Fs/Ts2203c
		   FOLLOW_UP_CMT = :ls_comments,	//:mle_comments.text,
			LEAD_DESC	=	:ls_contact		//:sle_contact_desc.text
	Where case_id		=	Upper( :in_case_id ) AND
			case_spl		=	Upper( :in_case_spl ) AND
			case_ver		=  Upper( :in_case_ver ) AND
			Lead_id		=  Upper( :in_lead_id )
Using Stars2ca;
// 10/12/01	GaryR	Stars 4.7 DataBase Port - End

If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox('ERROR','Lead Does Not Exist for this Case')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
		Errorbox(stars2ca,'Error Writing to Lead')
		RETURN
End If

setmicrohelp(w_main,'Lead Updated')

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	

sle_case_id.enabled = false
Sle_lead_id.enabled = false
setfocus(sle_contact_desc)
cb_close.default  = true
setpointer(arrow!)

ib_modified = false
end event

