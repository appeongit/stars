HA$PBExportHeader$w_case_maint_dup.srw
$PBExportComments$Inherited from w_case_maint
forward
global type w_case_maint_dup from w_case_maint
end type
end forward

global type w_case_maint_dup from w_case_maint
boolean visible = true
long backcolor = 67108864
string accessiblename = "Case Track Duplicate Check View "
string accessibledescription = "Case Track Duplicate Check View"
accessiblerole accessiblerole = windowrole!
integer x = 174
integer y = 148
integer width = 4512
integer height = 2636
string title = "Case Track Duplicate Check View"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_case_maint_dup w_case_maint_dup

type variables

end variables

event open;//***********************************************************************
//	Script:	w_case_maint_dup.Open - Override w_case_maint
//
//
//***********************************************************************
//   Date   Init               Description of Changes Made                
// ------- ---- -------------------------------------------------------- 
//	02/28/02	FDG	Track 2849d.  Read ids_code (like w_case_maint.open).
// 09/29/99 FNC  Change reference for case id to the datawindow field. Remove
//						ddlb loads since they are now dddws.
// 10/20/95 FNC  Take out connects and disconnects
// 07/26/95 FNC  Prob # 760 Stars30 disk load dept codes into ddlb
// 03/14/94 JMS  Modified to load case status with load_ddlb_values function.
// 11/18/93 JMS  Various changes for demo on 11/24/93
// JasonS 09/19/02 Track 3318d register dw_display_log with n_cst_case
//***********************************************************************

string 	ls_case,		&
			ls_case_id,	&
			ls_case_spl, &
			ls_case_ver
integer	li_row
long		ll_rows

setpointer(hourglass!)

in_from = gv_from

// FNC 09/29/99 Start
//sle_case_id.text = trim(Message.StringParm)

is_active_case = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

// FNC 09/29/99 End

ib_disableclosequery	=	TRUE		//	Don't perform closequery processing

inv_case = create n_cst_case

// JasonS 09/19/02 Begin - Track 3318d
inv_case.uf_set_case_log_display_dw(tab_case.tabpage_log.dw_display_log)		
// JasonS 09/19/02 End - Track 3318d


// FDG 02/28/02 - Register d/ws to inv_case
inv_case.uf_set_case_dw(tab_case.tabpage_general.dw_general)
inv_case.uf_set_track_dw (tab_case.tabpage_track.dw_track)		// FDG 09/12/01
inv_case.uf_set_case_log_dw (tab_case.tabpage_log.dw_log)		// FDG 09/12/01
// FDG 02/28/02 end

Call	w_master::Open		//	Execute w_master.open

// FDG 05/01/01 - Enable/Disable the PIMR tab and set its text
Integer	li_cntl_no

String	ls_cntl_text

Select	cntl_no
Into		:li_cntl_no
From		sys_cntl
Where		cntl_id	=	'USEPIMR'
Using		Stars2ca;

Stars2ca.of_check_status()

IF	li_cntl_no	=	0		THEN
	tab_case.tabpage_pimr.enabled	=	FALSE
ELSE
	tab_case.tabpage_pimr.enabled	=	TRUE
	IF	li_cntl_no	=	1		THEN
		ib_use_pimr	=	TRUE
	END IF
END IF

Select	cntl_text
Into		:ls_cntl_text
From		sys_cntl
Where		cntl_id	=	'PIMRTEXT'
Using		Stars2ca;

Stars2ca.of_check_status()

IF	Len (ls_cntl_text)	>	0		THEN
	tab_case.tabpage_pimr.text	=	ls_cntl_text
END IF
// FDG 05/01/01 end

// FDG 02/28/02 begin
// Store dept info in datastore
ids_code = CREATE n_ds
ids_code.DataObject = 'd_dddw_case_dept_2'
ids_code.SetTransObject( Stars2ca )
ll_rows = ids_code.Retrieve( )

IF ll_rows < 0 THEN
	MessageBox ("Error", "Error Retrieving Department Information in w_case_maint_dup.")
END IF

// FDG 02/28/02 end

this.event ue_retrieve()

//li_row = tab_case.tabpage_general.dw_general.getrow()
//
//tab_case.tabpage_general.dw_general.object.case_id[li_row] = ls_case_id
//09/29/99 End

cb_close.default = true
return

// JMS 11/18/93 rest of script removed for demo on 11/24/93


end event

event close;//	Override the ancestor (w_case_maint)

destroy(inv_case)
Call	w_master::close			//	FDG 1/2/98 (Destroy any created objects)
end event

on w_case_maint_dup.create
call super::create
end on

on w_case_maint_dup.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;//*******************************************************************
// 09/29/99 FNC	Stars 4.5 add to this event since this is where the 
//						retrieve is done. Replace references to ddlb's with
//						dddw's
// 07-25-95 FNC 	prob # 759 Disable ddlbs since they are not updateable
//*******************************************************************

// FNC 09/29/99 Start
//ddlb_case_type.enabled = false
//ddlb_case_cat.enabled = false
//ddlb_business.enabled = false
//ddlb_curr_status.enabled = false

tab_case.tabpage_general.dw_general.object.case_type.protect = 1
tab_case.tabpage_general.dw_general.object.case_cat.protect = 1
tab_case.tabpage_general.dw_general.object.case_business.protect = 1
tab_case.tabpage_current.dw_current.object.case_status.protect = 1

cb_select_track.enabled = FALSE
cb_select_track.visible = FALSE


// FNC 09/29/99 End
end event

event rbuttondown;/*This is a comment to override the ancestor script */
end event

event activate;/*This is a comment to override the ancestor script */
end event

event ue_set_update_availability;//  Overriding parent script
end event

event ue_open_rmm;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

//	Ancestor overridden
//	Do not allow popup menus on response windows.  (Section 508)
end event

type cb_track from w_case_maint`cb_track within w_case_maint_dup
integer x = 46
integer y = 1304
end type

on cb_track::clicked;call w_case_maint`cb_track::clicked;w_case_tracking.cb_track.visible = false
w_case_tracking.cb_createtrack.visible = false

end on

type cb_retrieve from w_case_maint`cb_retrieve within w_case_maint_dup
integer width = 338
integer height = 108
end type

type cb_update from w_case_maint`cb_update within w_case_maint_dup
integer width = 338
integer height = 108
end type

type cb_create from w_case_maint`cb_create within w_case_maint_dup
integer width = 338
integer height = 108
end type

type cb_delete from w_case_maint`cb_delete within w_case_maint_dup
integer width = 338
integer height = 108
end type

type cb_clear from w_case_maint`cb_clear within w_case_maint_dup
integer width = 338
integer height = 108
end type

type cb_more from w_case_maint`cb_more within w_case_maint_dup
integer width = 338
integer height = 108
integer taborder = 40
end type

type cb_close from w_case_maint`cb_close within w_case_maint_dup
integer width = 338
integer height = 108
integer taborder = 10
boolean default = true
end type

on cb_close::clicked;//DJP 2/6/96 prob#149 - no need for the uo
//close(w_case_maint_uo)
close(w_case_maint_dup)
end on

type cb_next from w_case_maint`cb_next within w_case_maint_dup
end type

type cb_prev from w_case_maint`cb_prev within w_case_maint_dup
end type

type tab_case from w_case_maint`tab_case within w_case_maint_dup
integer x = 18
integer width = 4471
integer height = 2148
end type

event tab_case::selectionchanged;call super::selectionchanged;//Disabled Select button
cb_select_track.visible = false
cb_select_track.enabled = false
end event

type tabpage_general from w_case_maint`tabpage_general within tab_case
integer width = 4434
integer height = 2032
end type

type uo_general from w_case_maint`uo_general within tabpage_general
integer width = 2843
integer height = 1372
end type

type dw_general from w_case_maint`dw_general within tabpage_general
integer x = 27
boolean enabled = false
end type

type tabpage_current from w_case_maint`tabpage_current within tab_case
integer width = 4434
integer height = 2032
end type

type uo_current from w_case_maint`uo_current within tabpage_current
end type

type dw_current from w_case_maint`dw_current within tabpage_current
boolean enabled = false
end type

type tabpage_savings from w_case_maint`tabpage_savings within tab_case
integer width = 4434
integer height = 2032
end type

type uo_savings from w_case_maint`uo_savings within tabpage_savings
end type

type st_savings from w_case_maint`st_savings within tabpage_savings
end type

type dw_savings from w_case_maint`dw_savings within tabpage_savings
boolean enabled = false
end type

type tabpage_pimr from w_case_maint`tabpage_pimr within tab_case
integer width = 4434
integer height = 2032
end type

type uo_1 from w_case_maint`uo_1 within tabpage_pimr
end type

type dw_pimr from w_case_maint`dw_pimr within tabpage_pimr
boolean enabled = false
end type

type tabpage_log from w_case_maint`tabpage_log within tab_case
integer width = 4434
integer height = 2032
end type

type dw_log from w_case_maint`dw_log within tabpage_log
boolean enabled = false
end type

type uo_log from w_case_maint`uo_log within tabpage_log
end type

type dw_display_log from w_case_maint`dw_display_log within tabpage_log
integer width = 4393
end type

type st_count from w_case_maint`st_count within tabpage_log
end type

type tabpage_track from w_case_maint`tabpage_track within tab_case
integer width = 4434
integer height = 2032
end type

type uo_track from w_case_maint`uo_track within tabpage_track
integer width = 2866
end type

type dw_track from w_case_maint`dw_track within tabpage_track
integer width = 4393
end type

event dw_track::doubleclicked;// JasonS 10/30/02 Track 2894d
// Override w_case_maint code so user cannot open track maint
end event

event dw_track::clicked;// Override the prents script for this functionality.
end event

type st_track_count from w_case_maint`st_track_count within tabpage_track
integer y = 1908
end type

type p_notes from w_case_maint`p_notes within w_case_maint_dup
integer x = 41
integer y = 2372
end type

type dw_headings from w_case_maint`dw_headings within w_case_maint_dup
end type

type cb_next_current from w_case_maint`cb_next_current within w_case_maint_dup
end type

type cb_close_current from w_case_maint`cb_close_current within w_case_maint_dup
end type

type cb_prev_current from w_case_maint`cb_prev_current within w_case_maint_dup
end type

type cb_select_track from w_case_maint`cb_select_track within w_case_maint_dup
integer y = 1904
end type

