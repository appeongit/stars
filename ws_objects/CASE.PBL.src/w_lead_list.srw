$PBExportHeader$w_lead_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_lead_list from w_master
end type
type sle_case_id from u_sle within w_lead_list
end type
type dw_1 from u_dw within w_lead_list
end type
type st_5 from statictext within w_lead_list
end type
type sle_contact_bene from singlelineedit within w_lead_list
end type
type sle_user_id from singlelineedit within w_lead_list
end type
type st_7 from statictext within w_lead_list
end type
type st_6 from statictext within w_lead_list
end type
type ddlb_type from dropdownlistbox within w_lead_list
end type
type st_4 from statictext within w_lead_list
end type
type sle_date from singlelineedit within w_lead_list
end type
type st_3 from statictext within w_lead_list
end type
type st_1 from statictext within w_lead_list
end type
type st_dw_ops from statictext within w_lead_list
end type
type ddlb_dw_ops from dropdownlistbox within w_lead_list
end type
type cb_new from u_cb within w_lead_list
end type
type cb_delete from u_cb within w_lead_list
end type
type st_row_count from statictext within w_lead_list
end type
type cb_stop from u_cb within w_lead_list
end type
type cb_close from u_cb within w_lead_list
end type
type cb_select from u_cb within w_lead_list
end type
type cb_list from u_cb within w_lead_list
end type
type gb_1 from groupbox within w_lead_list
end type
type sle_range from editmask within w_lead_list
end type
end forward

global type w_lead_list from w_master
string accessiblename = "Case Lead List"
string accessibledescription = "Case Lead List"
integer x = 169
integer y = 0
integer width = 2775
integer height = 1692
string title = "Case Lead List"
event type integer ue_edit_case_closed ( string as_case_id,  string as_case_spl,  string as_case_ver )
event type boolean ue_edit_case_referred ( string as_case_id,  string as_case_spl,  string as_case_ver )
sle_case_id sle_case_id
dw_1 dw_1
st_5 st_5
sle_contact_bene sle_contact_bene
sle_user_id sle_user_id
st_7 st_7
st_6 st_6
ddlb_type ddlb_type
st_4 st_4
sle_date sle_date
st_3 st_3
st_1 st_1
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
cb_new cb_new
cb_delete cb_delete
st_row_count st_row_count
cb_stop cb_stop
cb_close cb_close
cb_select cb_select
cb_list cb_list
gb_1 gb_1
sle_range sle_range
end type
global w_lead_list w_lead_list

type variables
// 01/10/05 Katie Track 5431c Removed local variable declaration.
n_cst_case inv_case	//NLG 8-11-99
boolean in_cancel
String    in_from
String    in_lead_id,in_case_id
String in_dw_control
string in_code
string in_selected
String in_col_array[]
w_uo_win iv_uo_win
sx_decode_structure in_decode_struct
string iv_case_id,iv_case_spl,iv_case_ver
string is_from_menu = 'FALSE'
boolean ib_open

// Dimensions of gb_1 and dw_1 when the window
// opens
Long	il_gb_x,		&
	il_gb_y,		&
	il_gb_height,	&
	il_gb_width,	&
	il_dw_x,		&
	il_dw_y,		&
	il_dw_height,	&
	il_dw_width

end variables

forward prototypes
public subroutine wf_visibility (boolean ab_visibility)
end prototypes

event ue_edit_case_closed;/////////////////////////////////////////////////////////////////////////
//	Script			ue_edit_case_closed
//
//	Arguments		1. as_case_id
//						2. as_case_spl
//						3. as_case_ver
//
//	Returns			1
//
//	Description		Don't allow the deletion of leads if the case is
//						closed or deleted
//
/////////////////////////////////////////////////////////////////////////
//
//	FDG	09/21/01	Stars 4.8.	Created.
//
/////////////////////////////////////////////////////////////////////////


Boolean	lb_valid_case

lb_valid_case	=	inv_case.uf_edit_case_closed (as_case_id, as_case_spl, as_case_ver)

IF	lb_valid_case	=	FALSE		THEN
	cb_delete.enabled	=	FALSE
ELSE
	cb_delete.enabled	=	TRUE
END IF

Return	1

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
//
////////////////////////////////////////////////////////////////////////////////
Boolean lb_valid_case

lb_valid_case = inv_case.uf_edit_case_referred(as_case_id, as_case_spl, as_case_ver)

IF lb_valid_case = FALSE THEN
	cb_delete.enabled = FALSE
ELSE 
	cb_delete.enabled = TRUE
END IF



Return lb_valid_case
end event

public subroutine wf_visibility (boolean ab_visibility);//************************************************************************
//	Object Name:	w_lead.test.wf_visibility
//	Object Type:	Window function
//	Script Name:	N/A
//
//			This function was created thru Prob #157 (Stars31) and will 
//			make the controls on top of the window visible or invisible
//			depending on the parm.  This is used for the 'SQL' toolbar
//			item.
//
//			Parms:
//			1.	ab_visibility - Sets the visible attribute to this value
//
//************************************************************************

ddlb_type.visible				=	ab_visibility
sle_case_id.visible			=	ab_visibility
sle_contact_bene.visible	=	ab_visibility
sle_user_id.visible			=	ab_visibility
sle_date.visible				=	ab_visibility
sle_range.visible				=	ab_visibility
st_1.visible					=	ab_visibility
st_3.visible					=	ab_visibility
st_4.visible					=	ab_visibility
st_5.visible					=	ab_visibility
st_6.visible					=	ab_visibility
st_7.visible					=	ab_visibility
//gb_1.visible					=	ab_visibility

end subroutine

event activate;//************************************************************************
//	Object Name:	w_lead_list
//	Object Type:	Window
//	Script Name:	Activate
//
//************************************************************************
//
//	05/01/96	FDG	Prob 157 (stars31) - Add logic to enlarge the d/w when
//						the SQL toolbar item is clicked.
//
//	FDG	07/29/97	When resizing the window, the resized dimensions of
//						dw_1 & gb_1 must be used in the computations.
// Katie 01/11/05 Track 5431c Added call to restore menu to settings for this window.
//
//************************************************************************

This.SetRedraw (FALSE)

IF	ib_show_sql		=	FALSE		THEN
	//	Hide everything inside gb_1
	dw_1.X			=	il_gb_x	-	5
	dw_1.Y			=	1
	dw_1.Height		=	il_gb_height	+	il_dw_height	+	10
	wf_visibility (FALSE)
	dw_1.show ()
ELSE									
	//	Reset the d/w to its original location
	dw_1.X			=	il_dw_x
	dw_1.Y			=	il_dw_y
	dw_1.Height		=	il_dw_height
	wf_visibility (TRUE)
	dw_1.show ()
END IF

m_stars_30.m_file.m_showsql.event ue_restore_win_settings() 

This.SetRedraw (TRUE)

end event

event open;call super::open;//************************************************************************
//	Object Name:	w_lead_list
//	Object Type:	Window
//	Script Name:	Open
//
//************************************************************************
//
//	08/31/94 FNC	Set range default to 7
//	05/01/96 FDG	Prob 157 (Stars31) - disable the 'SQL' toolbar item
//						until data is displayed.
//	03/04/98 AJS	4.0 TS145 - global case id
//	06/11/98 NLG	replace hardcoded date/range with nvo-sys-cntl
//	08/11/99 NLG	create the case nvo to be used for case security
//	09/21/01 FDG	Stars 4.8.  Don't allow adding new leads for a closed case.
//	04/02/04	GaryR	Track 5992c	Do not default User ID
//  01/10/05 Katie	Track 5431c Changed global references to instance refernces.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//************************************************************************

String lv_case_id,lv_case_ver,lv_case_spl,lv_window_name
int lv_rc,lv_index
Datetime lv_datetime

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

inv_case = CREATE n_cst_case

in_from = gv_from
This.of_set_sys_cntl_range (TRUE)//NLG 6-11-98
ib_open = TRUE							//NLG Track #1236
	// 05/01/96 FDG - Disable the SQL toolbar item until the data is
	//						retrieved.  Save the SQL switch from the previous
	//						window.
ib_allow_switch		=	FALSE
ib_show_sql				=	TRUE

if in_from = 'MENU' then
	sle_case_id.enabled = true
	is_from_menu = 'TRUE'
else
	sle_case_id.enabled = false
end if	

il_gb_x			=	gb_1.x
il_gb_y			=	gb_1.y
il_gb_height	=	gb_1.height
il_gb_width		=	gb_1.width
il_dw_x			=	dw_1.x
il_dw_y			=	dw_1.y
il_dw_height	=	dw_1.height
il_dw_width		=	dw_1.width

in_selected = '0'
cb_list.default   = true
cb_select.enabled = false
cb_delete.enabled = false

sle_case_id.text = gv_active_case			
lv_case_id  = left(gv_active_case,10)		
lv_case_spl = mid(gv_active_case,11,2)		
lv_case_ver = mid(gv_active_case,13,2)		

load_ddlb_values (ddlb_type,"LR","B",3)

ddlb_type.AddItem('All - All Types          ')		
ddlb_type.SelectItem('All - All Types          ',1)	


sle_date.text = inv_sys_cntl.of_get_default_date()//string(today())  ts2020c use server date, not pc date
sle_range.text = string(inv_sys_cntl.of_get_cntl_no())//NLG 6-11-98
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

lv_window_name = upper(this.classname())
lv_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars2ca)
If lv_rc = -5 Then
	lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(lv_index)
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

if len(trim(lv_case_id)) > 0 then
	triggerevent(cb_list,clicked!)
end if

ib_open = FALSE	//NLG Track #1236
end event

event close;call super::close;	// 05/01/96 FDG - Reset the SQL toolbar item that was saved during
	//						the open event.
	// 01/10/05 Katie Track 5431c Removed reference to global variable. Added code to reset menu.

m_stars_30.m_file.m_showsql.event ue_reset()

if isvalid(w_lead_maintain) then
	if w_lead_maintain.in_from <> 'MENU' then
		close(w_lead_maintain)			
	end if
end if

if IsValid(inv_case) then DESTROY inv_case
end event

on w_lead_list.create
int iCurrent
call super::create
this.sle_case_id=create sle_case_id
this.dw_1=create dw_1
this.st_5=create st_5
this.sle_contact_bene=create sle_contact_bene
this.sle_user_id=create sle_user_id
this.st_7=create st_7
this.st_6=create st_6
this.ddlb_type=create ddlb_type
this.st_4=create st_4
this.sle_date=create sle_date
this.st_3=create st_3
this.st_1=create st_1
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.cb_new=create cb_new
this.cb_delete=create cb_delete
this.st_row_count=create st_row_count
this.cb_stop=create cb_stop
this.cb_close=create cb_close
this.cb_select=create cb_select
this.cb_list=create cb_list
this.gb_1=create gb_1
this.sle_range=create sle_range
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_case_id
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.sle_contact_bene
this.Control[iCurrent+5]=this.sle_user_id
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.ddlb_type
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.sle_date
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_dw_ops
this.Control[iCurrent+14]=this.ddlb_dw_ops
this.Control[iCurrent+15]=this.cb_new
this.Control[iCurrent+16]=this.cb_delete
this.Control[iCurrent+17]=this.st_row_count
this.Control[iCurrent+18]=this.cb_stop
this.Control[iCurrent+19]=this.cb_close
this.Control[iCurrent+20]=this.cb_select
this.Control[iCurrent+21]=this.cb_list
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.sle_range
end on

on w_lead_list.destroy
call super::destroy
destroy(this.sle_case_id)
destroy(this.dw_1)
destroy(this.st_5)
destroy(this.sle_contact_bene)
destroy(this.sle_user_id)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.ddlb_type)
destroy(this.st_4)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.cb_new)
destroy(this.cb_delete)
destroy(this.st_row_count)
destroy(this.cb_stop)
destroy(this.cb_close)
destroy(this.cb_select)
destroy(this.cb_list)
destroy(this.gb_1)
destroy(this.sle_range)
end on

event resize;call super::resize;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_lead_list
//		Event Name:		Resize - Extend the ancestor
//
//************************************************************************
//
//	FDG	07/29/97	When resizing the window, the resized dimensions of
//						dw_1 & gb_1 must be computed for the activate event.
//
//************************************************************************

il_gb_x			=	gb_1.x
il_gb_y			=	gb_1.y
il_gb_height	=	gb_1.height
il_gb_width		=	gb_1.width
il_dw_x			=	dw_1.x
il_dw_y			=	dw_1.y
il_dw_height	=	dw_1.height
il_dw_width		=	dw_1.width


end event

event deactivate;call super::deactivate;// Katie 01/11/05 Track 5431c Added code to reset menu.

m_stars_30.m_file.m_showsql.event ue_reset()
end event

type sle_case_id from u_sle within w_lead_list
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Case ID"
string accessibledescription = "Lookup Field - Case ID"
integer x = 517
integer y = 88
integer width = 690
integer height = 96
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
//
//*********************************************************************************

if in_from = 'MENU' then
	gv_from = 'AC'
	Open(w_case_list_response)
	if (upper(trim(gv_active_case)) <> 'NONE') then 
		if len(trim(gv_active_case)) > 0 then
			This.text = gv_active_case
		end if
	end if
end if
end event

type dw_1 from u_dw within w_lead_list
string tag = "CRYSTAL, title = Leads List"
string accessiblename = "Case Lead List"
string accessibledescription = "Case Lead List"
integer x = 23
integer y = 480
integer width = 2697
integer height = 760
integer taborder = 70
string dataobject = "d_leads_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

on retrieveend;//Parent.controlmenu = true								//FDG 06/13/96
cb_stop.enabled = false
in_cancel = true
triggerevent(dw_1,rowfocuschanged!)
end on

event doubleclicked;//Script for W_lead_list doubleclicked for dw_1
//****************************************************************
//Modifications
//11-28-97 TS242 AJS Rel 3.6
//07/15/97 FS#171 NLG replace GetClickedRow(dw_1) with argument row
//////////////////////////////////////////////////////////////////////
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
	//anne-s 11-28-97 TS242 Rel 3.6
//	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
//	End if      
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
Else
	setmicrohelp(w_main,'Ready')
	If not In_cancel then
		RETURN
	End If
	lv_row_nbr = row

	If lv_row_nbr = 0 then 
	   selectrow(dw_1,0,false)
		Cb_Select.enabled = false
		Cb_Delete.enabled = false
	   RETURN
	End If
	iv_case_id = getitemstring(dw_1,lv_row_nbr,'case_id')		//KMM 9/20/95
	iv_case_spl = getitemstring(dw_1,lv_row_nbr,'case_spl')	//KMM 9/20/95
	iv_case_ver = getitemstring(dw_1,lv_row_nbr,'case_ver')	//KMM 9/20/95
	in_case_id = iv_case_id + iv_case_spl + iv_case_ver
	in_lead_id = getitemstring(dw_1,lv_row_nbr,'lead_id')
	Triggerevent(cb_select,Clicked!)
End If
end event

event rowfocuschanged;/////////////////////////////////////////////////////////////////////////////////////////////
// History:
//
// SAH 05/07/02 Stars 5.1 Track 2996  Prohibit user from deleting leads from original version
//												  of referred case.
//
////////////////////////////////////////////////////////////////////////////////////////////
long lv_row_nbr


If not in_cancel then 
	RETURN
End If

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

lv_row_nbr = getrow(dw_1)
// FDG 01/17/02 Track 2699d.  If no rows exist, get out
If lv_row_nbr = 0 			&
or	This.RowCount()	<	1	then 
   selectrow(dw_1,0,false)
	Cb_Select.enabled = false
	Cb_Delete.enabled = false
   RETURN
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

in_lead_id        = getitemstring(dw_1,lv_row_nbr,'lead_id')
iv_case_id        = getitemstring(dw_1,lv_row_nbr,'case_id')			
iv_case_spl       = getitemstring(dw_1,lv_row_nbr,'case_spl')
iv_case_ver	      = getitemstring(dw_1,lv_row_nbr,'case_ver')
in_case_id        = iv_case_id + iv_case_spl + iv_case_ver

// FDG 09/21/01 - Stars 4.8.1.	Enable/disable cb_delete based on if the case is closed/deleted
Parent.Event	ue_edit_case_closed (iv_case_id, iv_case_spl, iv_case_ver)

// SAH 05/07/02 Track 2996  -Begin
// Disable cb_delete if case has been referred
Parent.Event ue_edit_case_referred(iv_case_id, iv_case_spl, iv_case_ver)
end event

on retrievestart;Setpointer(hourglass!)

In_cancel = false
//Parent.controlmenu = False								//FDG 06/13/96
cb_stop.enabled = true
end on

type st_5 from statictext within w_lead_list
string accessiblename = "Patient ID"
string accessibledescription = "Patient ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1248
integer y = 88
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

type sle_contact_bene from singlelineedit within w_lead_list
string accessiblename = "Patient ID"
string accessibledescription = "Patient ID"
accessiblerole accessiblerole = textrole!
integer x = 1541
integer y = 88
integer width = 658
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

type sle_user_id from singlelineedit within w_lead_list
string accessiblename = "Used ID"
string accessibledescription = "Used ID"
accessiblerole accessiblerole = textrole!
integer x = 517
integer y = 216
integer width = 416
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_lead_list
string accessiblename = "Rep"
string accessibledescription = "Rep"
accessiblerole accessiblerole = statictextrole!
integer x = 279
integer y = 216
integer width = 201
integer height = 64
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

type st_6 from statictext within w_lead_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = statictextrole!
integer x = 2107
integer y = 220
integer width = 219
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Range:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_lead_list
string accessiblename = "Lead Source"
string accessibledescription = "Lead Source"
accessiblerole accessiblerole = comboboxrole!
integer x = 517
integer y = 352
integer width = 1344
integer height = 716
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
string text = "All - All Types"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;setpointer(Hourglass!)

if in_From <> 'MENU' then       //KMM 9/14/95 
	reset(dw_1)		
	st_row_count.text = '0'
end if
cb_list.default = true
cb_Select.enabled = false
cb_delete.enabled = false
setpointer(arrow!)
end on

type st_4 from statictext within w_lead_list
string accessiblename = "Lead  Source"
string accessibledescription = "Lead  Source"
accessiblerole accessiblerole = statictextrole!
integer x = 46
integer y = 352
integer width = 434
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Lead  Source:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_lead_list
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = textrole!
integer x = 1541
integer y = 216
integer width = 553
integer height = 96
integer taborder = 40
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

type st_3 from statictext within w_lead_list
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = statictextrole!
integer x = 1307
integer y = 216
integer width = 215
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Date:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_lead_list
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 206
integer y = 100
integer width = 274
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Case ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_dw_ops from statictext within w_lead_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 1256
integer width = 613
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type ddlb_dw_ops from dropdownlistbox within w_lead_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 32
integer y = 1332
integer width = 713
integer height = 312
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
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

type cb_new from u_cb within w_lead_list
string accessiblename = "Add"
string accessibledescription = "Add..."
integer x = 1275
integer y = 1436
integer width = 338
integer height = 104
integer taborder = 110
integer weight = 400
string text = "&Add..."
end type

event clicked;//NLG 8-11-99 TS2363c.  Use new case nvo for security check

// FDG 09/21/01	Stars 4.8.  Leads cannot be added to a closed/deleted case
// 12/29/04 JasonS Track 4204 Remove check for closed case.

int lv_nbr_rows 
string lv_parm
string ls_msg
string ls_case_id,ls_case_spl,ls_case_ver

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')


gv_from ='N'
gv_user_id = gc_user_id

if sle_case_id.text = '' then
	lv_parm = gv_active_case + '~~' + is_from_menu
else	
	lv_parm = sle_case_id.text + '~~' + is_from_menu
end if

//NLG 8-11-99 START**
ls_case_id = left(sle_case_id.text,10)
ls_case_spl = mid(sle_case_id.text,11,2)
ls_case_ver = mid(sle_case_id.text,13,2)

// FDG 09/21/01 begin
Boolean	lb_valid_case

lb_valid_case	=	inv_case.uf_edit_case_closed (ls_case_id, ls_case_spl, ls_case_ver)

// FDG 09/21/01 end

Ls_msg  =  inv_case.uf_edit_case_security(ls_case_id, ls_case_spl, ls_case_ver)
IF  Len (ls_msg)  >  0   THEN
	MessageBox ('Security Error', ls_msg)
	Return
ELSE
	OpenSheetWithParm(w_lead_maintain,lv_parm, &
								MDI_main_frame,help_menu_position,Layered!)
END IF

end event

type cb_delete from u_cb within w_lead_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1669
integer y = 1436
integer width = 338
integer height = 104
integer taborder = 120
integer weight = 400
string text = "&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// History:
//
// FDG 10/11/01	Stars 4.8.1.	Add case_log entry.
// SAH 05/07/02   Stars 5.1 Track 2996  Prohibit user from deleting lead from referred case 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

String lv_case_id, lv_case_spl, lv_case_ver
int lv_button_nbr, lv_count_cases,lv_row
boolean lb_valid_case



Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

//2-4-00 FS/TS2326 - Archana - User security level must be either AD or SA to delete leads.
//  Edit to insure a retrieve was done before delete.
//If ((gv_user_sl<>'AD') or (gv_user_sl<>'SA')) then 
if ((gv_user_sl = 'AD') or (gv_user_sl = 'SA')) then
	setfocus(sle_user_id)
else
   Messagebox ('EDIT','No Authority to Delete a Lead')
	cb_close.default = true
	RETURN
End If 


// SAH 05/07/02 Track 2996 -Begin
lb_valid_case = Parent.Event ue_edit_case_referred(iv_case_id, iv_case_spl, iv_case_ver)
IF lb_valid_case = FALSE THEN
	// Case has been referred, don't allow delete of lead
	MessageBox('EDIT', 'Case has been referred.  Leads cannot be deleted from referred cases.')
	Return
END IF
// SAH 05/07/02 -End


If IN_CASE_ID = '' then
	setfocus(DW_1)
   Messagebox ('EDIT','Case Id is required for Delete')
	Return
End If 

If IN_LEAD_ID = '' then
	setfocus(DW_1)
   Messagebox ('EDIT','Lead Id is required for Delete')
	Return
End If 


lv_button_nbr = MessageBox ('CONFIRMATION!', 'Proceed with Deleting Lead', &
                   Question!,YesNo!,2)
If lv_button_nbr = 2 then
	setfocus(dw_1)
  	Return
End If

Delete from Lead
       where	lead_id		= Upper( :in_lead_id ) and
					case_id	 	= Upper( :iv_case_id ) and	
					case_spl		= Upper( :iv_case_spl ) and
					case_ver		= Upper( :iv_Case_ver )
using stars2ca;
If stars2ca.of_check_status() = 100 Then
	Errorbox(stars2ca,'Lead has already been deleted')
	Setfocus(dw_1)
	RETURN	
ElseIf stars2ca.sqlcode <> 0 Then
		Errorbox(stars2ca,'Error Deleting from Lead Table')
		Setfocus(dw_1)
		RETURN	
End If

// FDG 10/11/01 begin
String	ls_message
Integer	li_rc

ls_message	=	"Lead "	+	in_lead_id	+	" removed from case."

li_rc			=	inv_case.uf_audit_log ( iv_case_id, iv_case_spl, iv_Case_ver, ls_message )

IF	li_rc		<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for lead '	+	in_lead_id	+	&
					'.  Case: ' + iv_case_id + iv_case_spl + iv_Case_ver + '. Script: '		+	&
					'w_lead_list.cb_delete.clicked')
	Return
END IF
// FDG 10/11/01 end

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
Setmicrohelp(w_main,'Lead Deleted')

//Delete current row from data window, but not from db.  Modify row count.
deleterow(dw_1,0)
st_row_count.text = string(integer(st_row_count.text) - 1)
If integer(st_row_count.text) > 0 then
	lv_row = getrow(dw_1)
	selectrow(dw_1,lv_row,true)
	setrow(dw_1,lv_row)
	in_lead_id        = getitemstring(dw_1,lv_row,'lead_id')
	iv_case_id        = getitemstring(dw_1,lv_row,'case_id')			
	iv_case_spl       = getitemstring(dw_1,lv_row,'case_spl')
	iv_case_ver	      = getitemstring(dw_1,lv_row,'case_ver')
	in_case_id        = iv_case_id + iv_case_spl + iv_case_ver
	cb_select.default = true
Else
	IN_LEAD_id = ''
	iv_case_id = ''
	iv_case_spl = ''
	iv_case_ver = ''
	in_case_id = ''
	gv_user_id = ''
	cb_delete.enabled = false
	cb_select.enabled = false
	cb_list.default = true
End If
end event

type st_row_count from statictext within w_lead_list
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 1452
integer width = 274
integer height = 80
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

type cb_stop from u_cb within w_lead_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
integer x = 1975
integer y = 1304
integer width = 338
integer height = 108
integer taborder = 0
integer weight = 400
boolean enabled = false
string text = "&Stop"
end type

on clicked;in_cancel = true
end on

type cb_close from u_cb within w_lead_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2272
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 130
integer weight = 400
string text = "&Close"
end type

on clicked;Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
close(parent)

end on

type cb_select from u_cb within w_lead_list
string accessiblename = "Select"
string accessibledescription = "Select..."
integer x = 882
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 100
integer weight = 400
string text = "&Select..."
end type

event clicked;//***************************************************************
//06-18-97 FNC FS/TS154 Check security before opening detail window
//					This will make sure all case security is consistent
//09/01/98 AJS FS362 convert case to case_cntl
//08-11-99 NLG ts2363c. Use new case nvo for case security
//***************************************************************

String lv_parm
string ls_dept_code	//06-18-97 FNC
integer li_code_sec	//06-18-97 FNC
string ls_msg
string ls_case_id,ls_case_spl,ls_case_ver //NLG 8-11-99
long ll_row

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
//lv_parm = sle_case_id.text + '~~' + in_lead_id
lv_parm = in_case_id + '~~' + in_lead_id
gv_from = 'M'
If in_lead_id = '' then
	setmicrohelp(w_main,'Select Lead Id to be Maintained')
End If
ll_row = dw_1.GetRow()
ls_case_id = dw_1.GetItemString(ll_row,'case_id')
ls_case_spl = dw_1.GetItemString(ll_row,'case_spl')
ls_case_ver = dw_1.GetItemString(ll_row,'case_ver')

Ls_msg  =  inv_case.uf_edit_case_security(ls_case_id, ls_case_spl, ls_case_ver)

IF  Len (ls_msg)  >  0   THEN
	MessageBox ('Security Error', ls_msg)
	Return
ELSE
	OpenSheetwithParm(w_lead_maintain,lv_parm, &
			MDI_main_frame,help_menu_position,Layered!)
END IF
end event

type cb_list from u_cb within w_lead_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 489
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 90
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&List"
boolean default = true
end type

event clicked;//----------------------------------------------------------------------------
//
//	06/11/98	NLG	Change hardcoded date range to use nvo_sys_cntl instead
//	01/12/99 FDG	Track 2047c.  Y2K changes to allow a 4-digit date & range.
//	05/07/02	SAH	Stars 5.1 Track 2996  Prohibit user from deleting lead from referred case 
//  07/29/08	GaryR	SPR 5481	Trim the lead source codes
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//----------------------------------------------------------------------------

String lv_case_id,lv_case_spl,lv_case_ver
String lv_type
long lv_nbr_rows
long lv_range
date lv_from_date
date lv_to_date 
datetime lv_from_date_time
datetime lv_to_date_time
string lv_source_id, lv_sql
int li_rc

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

gv_user_id 		= trim(sle_user_id.text) + '%'
lv_case_id      	= trim(left(sle_case_id.text,10)) + '%'
lv_case_spl     	= mid(sle_case_id.text,11,2) + '%'
lv_case_ver     	= mid(sle_case_id.text,13,2) + '%'
n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate (sle_date.text)

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		sle_date.SetFocus()
		Return
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		sle_date.SetFocus()
		Return
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		sle_date.SetFocus()
		Return	-1
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.
lv_from_date_time	=	lnv_datetime.of_GetFromDateTime (sle_date.text, sle_range.text)
lv_to_date			=	Date (sle_date.text)
lv_to_date_time	=	DateTime (lv_to_date, 23:59:59)

lv_type				  = Trim( left(ddlb_type.text,3) )
lv_source_id = sle_contact_bene.text + '%'			//KMM 9/15/95 Added for Lead list from Menu

// Should never have this situation - default should always be set.
IF lv_type = "" OR lv_type = 'All' THEN lv_type = '%'

If dw_1.SetTransObject(stars2ca) < 0 then
   Errorbox(stars2ca,'Error Setting Transaction Object')
   RETURN
End If

Reset(dw_1)	
//list arguments in order of dw argument list
lv_nbr_rows = Retrieve (dw_1,lv_case_id,lv_case_spl,lv_case_ver,lv_type, &
								lv_source_id,gv_user_id,lv_from_date_time,lv_to_date_time, gc_user_dept)

If stars2ca.of_commit() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

If lv_nbr_rows <= 0 then
	ib_allow_switch		=	FALSE				// FDG 05/01/96
	cb_delete.enabled = FALSE
	cb_select.enabled = FALSE
	setfocus(ddlb_type)
	//NLG Track #1236                                                   ***START***
	//11-29-94 FNC add messagebox if no leads found
	if ib_open then
		SetMicrohelp(w_main,'No Leads Match the Search By Criteria')
	else
		messagebox('WARNING','No Leads Match the Search By Criteria',Exclamation!)
	end if
	
	//NLG Track #1236 																	***STOP***
  	st_row_count.text = '0'
	RETURN
End If

ib_allow_switch		=	TRUE				// FDG 05/01/96
st_row_count.text = string(lv_nbr_rows)
//setfocus(dw_1)
dw_1.taborder = 50

cb_select.enabled = true
cb_select.default = true
cb_delete.enabled = true

// SAH 05/07/02 Track 2996 -Begin
// Disable cb_delete if case has been referred
Parent.Event ue_edit_case_referred(lv_case_id, lv_case_spl, lv_case_ver)
end event

type gb_1 from groupbox within w_lead_list
string accessiblename = "Search by"
string accessibledescription = "Search by"
accessiblerole accessiblerole = groupingrole!
integer x = 23
integer width = 2697
integer height = 460
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search by"
end type

type sle_range from editmask within w_lead_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = textrole!
integer x = 2354
integer y = 216
integer width = 279
integer height = 96
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
maskdatatype maskdatatype = stringmask!
string mask = "####"
end type

