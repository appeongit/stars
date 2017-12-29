HA$PBExportHeader$w_target_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_target_list from w_master
end type
type sle_dept_id from singlelineedit within w_target_list
end type
type st_2 from statictext within w_target_list
end type
type sle_date from singlelineedit within w_target_list
end type
type sle_target_id from singlelineedit within w_target_list
end type
type sle_subset_id from singlelineedit within w_target_list
end type
type st_6 from statictext within w_target_list
end type
type st_5 from statictext within w_target_list
end type
type st_4 from statictext within w_target_list
end type
type st_3 from statictext within w_target_list
end type
type cb_list from u_cb within w_target_list
end type
type st_dw_ops from statictext within w_target_list
end type
type ddlb_dw_ops from dropdownlistbox within w_target_list
end type
type st_row_count from statictext within w_target_list
end type
type cb_close from u_cb within w_target_list
end type
type cb_stop from u_cb within w_target_list
end type
type cb_select from u_cb within w_target_list
end type
type dw_1 from u_dw within w_target_list
end type
type sle_case_id from singlelineedit within w_target_list
end type
type st_1 from statictext within w_target_list
end type
type gb_1 from groupbox within w_target_list
end type
type sle_range from editmask within w_target_list
end type
end forward

global type w_target_list from w_master
string accessiblename = "Case Target List"
string accessibledescription = "Case Target List"
accessiblerole accessiblerole = windowrole!
integer x = 169
integer y = 0
integer width = 2743
integer height = 1700
string title = "Case Target List"
long backcolor = 67108864
sle_dept_id sle_dept_id
st_2 st_2
sle_date sle_date
sle_target_id sle_target_id
sle_subset_id sle_subset_id
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
cb_list cb_list
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
st_row_count st_row_count
cb_close cb_close
cb_stop cb_stop
cb_select cb_select
dw_1 dw_1
sle_case_id sle_case_id
st_1 st_1
gb_1 gb_1
sle_range sle_range
end type
global w_target_list w_target_list

type variables
Boolean in_cancel
String in_target_id,in_subset_id
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct
string is_case_id,is_case_ver,is_case_spl,in_case_id
nvo_subset_functions inv_subset_functions //nlg 4.0
sx_subset_ids istr_subset_ids //nlg 4.0
string in_subset_name            //nlg 4.0
string in_dept_id                     //nlg 4.0
boolean ib_open
end variables

event open;call super::open;//***********************************************************
//01-15-98 NLG 4.0 Subset Redesign	1) user will enter subset name (external id)
//                                   	Internal id used to search case_link
//												2)	Use sys_cntl service for date range defaults	
//
//10-20-95 FNC Take out connects and disconnects
//***********************************************************
String lv_case_id,lv_case_spl,lv_case_ver
string lv_window_name

setpointer(hourglass!)

ib_open = TRUE //NLG Track #1236

inv_subset_functions = create nvo_subset_functions	//01-15-98 NLG 4.0
this.of_set_sys_cntl_range(TRUE)							//01-15-98 NLG 4.0 Subset Redesign
//fx_set_window_colors(w_target_list)
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
setmicrohelp(w_main,'Ready')
//sle_case_id.text = gv_case_active		//ajs 4.0 03-11-98 ajs 4.0 fix globals
sle_case_id.text = gv_active_case		//ajs 4.0 03-11-98 ajs 4.0 fix globals
cb_select.enabled = false

If trim(sle_case_id.text) = '' then
	Messagebox('EDIT','There is no Active Case Selected')
   cb_close.PostEvent(Clicked!)
   return 
End If

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)
If settransobject(dw_1,stars2ca) < 0 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in open')
   end if                             //10-20-95 FNC End
	Messagebox('EDIT','Error Setting Transaction Object')
	 cb_close.PostEvent(Clicked!)
    return
End If

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in open')
   return
end if                             //10-20-95 FNC End
cb_list.triggerevent(clicked!)
ib_open = FALSE //NLG Track #1236

Setpointer(arrow!)

end event

on activate;//DJP-Bos added this to correct bleeding problems
w_main.postevent('redraw')

end on

event close;call super::close;if isValid(inv_subset_functions) then destroy inv_subset_functions //1-16-98 NLG 4.0

close(w_target_view)
end event

on w_target_list.create
int iCurrent
call super::create
this.sle_dept_id=create sle_dept_id
this.st_2=create st_2
this.sle_date=create sle_date
this.sle_target_id=create sle_target_id
this.sle_subset_id=create sle_subset_id
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.cb_list=create cb_list
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_row_count=create st_row_count
this.cb_close=create cb_close
this.cb_stop=create cb_stop
this.cb_select=create cb_select
this.dw_1=create dw_1
this.sle_case_id=create sle_case_id
this.st_1=create st_1
this.gb_1=create gb_1
this.sle_range=create sle_range
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_dept_id
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_date
this.Control[iCurrent+4]=this.sle_target_id
this.Control[iCurrent+5]=this.sle_subset_id
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.cb_list
this.Control[iCurrent+11]=this.st_dw_ops
this.Control[iCurrent+12]=this.ddlb_dw_ops
this.Control[iCurrent+13]=this.st_row_count
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.cb_stop
this.Control[iCurrent+16]=this.cb_select
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.sle_case_id
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.sle_range
end on

on w_target_list.destroy
call super::destroy
destroy(this.sle_dept_id)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.sle_target_id)
destroy(this.sle_subset_id)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_list)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.st_row_count)
destroy(this.cb_close)
destroy(this.cb_stop)
destroy(this.cb_select)
destroy(this.dw_1)
destroy(this.sle_case_id)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.sle_range)
end on

type sle_dept_id from singlelineedit within w_target_list
string accessiblename = "Department ID"
string accessibledescription = "Department ID"
accessiblerole accessiblerole = textrole!
integer x = 1211
integer y = 228
integer width = 247
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_target_list
string accessiblename = "Department"
string accessibledescription = "Department"
accessiblerole accessiblerole = statictextrole!
integer x = 827
integer y = 236
integer width = 375
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Department:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_target_list
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = textrole!
integer x = 2231
integer y = 228
integer width = 421
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_target_id from singlelineedit within w_target_list
string accessiblename = "Target ID"
string accessibledescription = "Target ID"
accessiblerole accessiblerole = textrole!
integer x = 389
integer y = 228
integer width = 421
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type sle_subset_id from singlelineedit within w_target_list
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = textrole!
integer x = 1778
integer y = 104
integer width = 809
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
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

type st_6 from statictext within w_target_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = statictextrole!
integer x = 1495
integer y = 236
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
string text = "Range:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_target_list
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = statictextrole!
integer x = 2053
integer y = 236
integer width = 174
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_target_list
string accessiblename = "Target ID"
string accessibledescription = "Target ID"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 236
integer width = 302
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Target ID:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_target_list
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1312
integer y = 112
integer width = 430
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_list from u_cb within w_target_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 768
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 100
integer weight = 400
string text = "&List"
end type

event clicked;//***************************************************************
//	07/05/07	SPR 4945 Remove rows with null subset id if the search is being done using subset id.
//04/16/01 FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//01/12/99 FDG	Track 2047c.  Add Y2K edits for 4 digit year & edit range.
//06-29-98 NLG Track #1380 dw_1 should select on subset name rather than subset id
//01-15-98 NLG 4.0 Subset Redesign - user will enter subset name (external id)
//                                   Will search case_link for internal id
//
//10-20-95 FNC Take out connects and disconnects
//***************************************************************

string ls_case_id, ls_case_ver, ls_case_spl
string ls_subset_id, ls_target_id, ls_dept_id, ls_sub_name
date ld_from_date, ld_to_date
datetime ld_from_date_time, ld_to_date_time
int li_range,	li_rc
long ll_rows, ll_index

ls_case_id 	= Trim(left(sle_case_id.text,10) ) + '%'		// FDG 04/16/01
ls_case_spl = Trim(mid(sle_case_id.text,11,2) ) + '%'		// FDG 04/16/01
ls_case_ver = Trim(mid(sle_case_id.text,13,2) ) + '%' 	// FDG 04/16/01

//ls_subset_id = sle_subset_id.text + '%'       1-16-98 NLG 4.0
ls_target_id = sle_target_id.text + '%'
ls_dept_id = sle_dept_id.text + '%'


// FDG 1/12/99 begin

n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate (sle_date.text)

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		sle_date.SetFocus()
		Return	-1
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		sle_date.SetFocus()
		Return	-1
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		sle_date.SetFocus()
		Return	-1
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.
ld_from_date_time	=	lnv_datetime.of_GetFromDateTime (sle_date.text, sle_range.text)
ld_to_date			=	Date (sle_date.text)
ld_to_date_time	=	DateTime (ld_to_date, 23:59:59)


// FDG 1/12/99 end


If settransobject(dw_1,stars2ca) < 0 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in cb_list')
   end if                             //10-20-95 FNC End
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_close.PostEvent(Clicked!)
   return
End If

//NLG Track #1380 														**START**
//use subset name rather than subset id to retrieve datawindow.
string ls_subset_name
ls_subset_name = trim(sle_subset_id.text)+ '%'
st_row_count.text = string(retrieve(dw_1,LS_CASE_ID,LS_CASE_SPL,LS_CASE_VER,ls_subset_name,ls_target_id,ld_from_date_time,ld_to_date_time,ls_dept_id))
//NLG Track #1380 														**STOP**
COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in cb_list')
   return
end if                             //10-20-95 FNC End
If long(st_row_count.text) < 0 then
	st_row_count.text = '0'
	Messagebox('EDIT','Error Retrieving Data for this Case')
	cb_close.default = true
	RETURN
Elseif long(st_row_count.text) = 0 then
	//NLG Track #1236      										***START***
	//setmicrohelp(w_main,'No Targets for this Case')
	if ib_open then 
		setmicrohelp(w_main,'No Targets meet search criteria')
	else
	end if
	//NLG Track #1236      										***START***
	cb_list.default = true
	cb_select.enabled = false
	setfocus(sle_case_id)
	RETURN
Else
	dw_1.setredraw( false)
	if trim(sle_subset_id.text) <> '' then
		For ll_index = 1 to rowcount(dw_1)
			ls_sub_name = getitemstring(dw_1,ll_index,'CASE_LINK_LINK_NAME')
			if ((trim(ls_sub_name) = '') or IsNull(ls_sub_name)) then
				deleterow( dw_1, ll_index)
				ll_index = ll_index - 1
			end if
		Next
	end if
	dw_1.setredraw( true)
	cb_select.enabled = true
	cb_select.default = true	
End If

Setpointer(arrow!)

end event

type st_dw_ops from statictext within w_target_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 1244
integer width = 626
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

type ddlb_dw_ops from dropdownlistbox within w_target_list
string accessiblename = "Windows Operations"
string accessibledescription = "Windows Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 27
integer y = 1324
integer width = 713
integer height = 312
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.
string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end on

type st_row_count from statictext within w_target_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 27
integer y = 1452
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 400
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

type cb_close from u_cb within w_target_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2281
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 120
integer weight = 400
string text = "&Close"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
close(parent)
end on

type cb_stop from u_cb within w_target_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1783
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 10
integer weight = 400
boolean enabled = false
string text = "S&top"
end type

type cb_select from u_cb within w_target_list
string accessiblename = "Select"
string accessibledescription = "Select..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1239
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 110
integer weight = 400
string text = "&Select..."
boolean default = true
end type

event clicked;//***************************************************************
//06-18-97 FNC FS/TS154 Check security before opening detail window
//					This will make sure all case security is consistent
//08-31-98 NLG FS362 convert case to case_cntl
//***************************************************************
string ls_dept_code	//06-18-97 FNC
integer li_code_sec //06-18-97 FNC

string ls_parm
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If in_target_id  = '' then
	Messagebox('EDIT','Must Select a Target from Window')
	this.enabled = false
	RETURN
End If

GV_CASE_target = in_target_id
//gv_case_subset = in_subset_id		//ajs 4.0 03-11-98 4.0 TS145-fix globals
gv_target_subset_id = in_subset_id			//ajs 4.0 03-11-98 4.0 TS145-fix globals
ls_parm = in_case_id + '~~' + in_target_id			//KMM 9/25/95 Prob#1102
gv_from = 'M'

//06-18-97 FNC Start

//08-31-98 NLG FS362 convert case to case_cntl
Select code_value_a,code_value_n
	into :ls_dept_code, :li_code_sec
	from CODE CD,CASE_CNTL CC
	where CC.case_id = Upper( :is_case_id ) and
			CC.case_spl = Upper( :is_case_spl ) and
			CC.case_ver = Upper( :is_case_ver ) and
			CC.case_cat = CD.code_code and
			CD.code_type = 'CA' 
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
		Messagebox('EDIT','This is a Secured Case you have insufficient privileges for viewing')
	Else
		OpenSheetwithparm(w_target_view,ls_parm,MDI_main_frame,help_menu_position,Layered!)
	End If
Else
	OpenSheetwithparm(w_target_view,ls_parm,MDI_main_frame,help_menu_position,Layered!)
End If

//06-18-97 FNC End
end event

type dw_1 from u_dw within w_target_list
string accessiblename = "Case Target List"
string accessibledescription = "Case Target List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Target List"
integer x = 32
integer y = 428
integer width = 2661
integer height = 812
integer taborder = 80
string dataobject = "d_target_list_by_case"
boolean hscrollbar = true
boolean vscrollbar = true
end type

on retrievestart;setpointer(hourglass!)
In_cancel = false
//Parent.controlmenu = False						//FDG 06/13/96
cb_stop.enabled = true
end on

event doubleclicked;//////////////////////////////////////////////////////////////////////
//Script for W_Target_list doubleclicked for dw_1
//////////////////////////////////////////////////////////////////////
// 11-28-97 AJS		TS242 Rel 3.6
// 11/11/98	FNC		Track 1961 - If there is no subset id in the row then don't attempt 
//							to retrieve its subset name
// MikeFl 8/8/02 		Track 3239	Commented out un-needed code. The double click and cb_select.clicked should be the same.
//////////////////////////////////////////////////////////////////////
int tabpos,rc,lv_indx,lv_found
int lv_upper
long lv_row_nbr
string lv_hold_object,lv_col,lv_tbl_type
string lv_string_width,lv_hold_col_width,lv_col_name
boolean lv_lookup,lv_found_flag,lv_join
long ll_rows

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
//		lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
Else
	If not In_cancel then
		RETURN
	End If
	setpointer(hourglass!)
	setmicrohelp(w_main,'Ready')
	lv_row_nbr = row

	If lv_row_nbr = 0 then 
	   selectrow(dw_1,0,false)
		Cb_Select.enabled = false
		in_target_id = ''
		in_subset_id = ''
		cb_select.enabled = false
	   RETURN
	Else
		cb_select.enabled = true
		cb_select.default = true
	End If

	selectrow(dw_1,0,false)
	selectrow(dw_1,lv_row_nbr,true)
	setrow(dw_1,lv_row_nbr)
                                      
	in_target_id = getitemstring(dw_1,lv_row_nbr,"trgt_id")
	//use nvo_subset_functions to retrieve internal subset id

// MikeFl 8/8/02 Track 3239- Begin
//	in_subset_name = getitemstring(dw_1,lv_row_nbr,'case_link_link_name') 
//	if trim(in_subset_name) = '' or isnull(in_subset_name) then										// FNC 11/11/98
//		in_subset_id = ''															// FNC 11/11/98
//	else																				// FNC 11/11/98
//		istr_subset_ids.subset_name = in_subset_name
//		istr_subset_ids.subset_case_id = is_case_id
//		istr_subset_ids.subset_case_spl = is_case_spl
//		istr_subset_ids.subset_case_ver = is_case_ver
//		// Retrieve internal subset id by call to nvo
//		inv_subset_functions.uf_set_structure(istr_subset_ids)
//		ll_rows = inv_subset_functions.uf_retrieve_subset_id()
//		if ll_rows < 1 then
//			MessageBox('ERROR','Unable to retrieve subset id~r'+&
//							'Cannot retrieve targets')
//			return
//		end if		
//		istr_subset_ids = inv_subset_functions.uf_get_structure()
//		in_subset_id = istr_subset_ids.subset_id
//	end if																			// FNC 11/11/98
//1-19-98 NLG 4.0                                                           ***STOP
//
//	in_subset_name = getitemstring(dw_1,lv_row_nbr,'subc_id') 
//	if trim(in_subset_name) = '' or isnull(in_subset_name) then										// FNC 11/11/98
//		in_subset_id = ''															// FNC 11/11/98
//	else																				// FNC 11/11/98
//		istr_subset_ids.subset_name = in_subset_name
//		istr_subset_ids.subset_case_id = is_case_id
//		istr_subset_ids.subset_case_spl = is_case_spl
//		istr_subset_ids.subset_case_ver = is_case_ver
//		// Retrieve internal subset id by call to nvo
//		inv_subset_functions.uf_set_structure(istr_subset_ids)
//		ll_rows = inv_subset_functions.uf_retrieve_subset_id()
//		if ll_rows < 1 then
//			MessageBox('ERROR','Unable to retrieve subset id~r'+&
//							'Cannot retrieve targets')
//			return
//		end if		
//		istr_subset_ids = inv_subset_functions.uf_get_structure()
//		in_subset_id = istr_subset_ids.subset_id
//	end if	
// MikeFl 8/8/02 Track 3239- End

	triggerevent(cb_select,clicked!)
End If
end event

event rowfocuschanged;////////////////////////////////////////////////////////////////////////////////////////
// 11/11/98	FNC	Track 1961 - If there is no subset id in the row then don't attempt 
//						to retrieve its subset name
//	01/17/02	FDG	Track 2699d.  If no rows exist, get out.
//	01/31/02	FDG	Track 2772d.  Get subc_id (not case_link_link_name) to get the subset ID.
//	03/05/02	FDG	Track 2848d.  Subset ID is retrieved (not subset name) in this d/w.
////////////////////////////////////////////////////////////////////////////////////////

long lv_row_nbr, ll_rows

If not in_cancel then 
	RETURN
End If

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
lv_row_nbr = getrow(dw_1)
// FDG 01/17/02 - If no rows exist, get out
If lv_row_nbr = 0 	&
or	This.RowCount()	<	1	then 
   selectrow(dw_1,0,false)
	in_target_id = ''
	in_subset_id = ''
	cb_select.enabled = false
   RETURN
Else
	cb_select.enabled = true
	cb_select.default = true
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

in_target_id = getitemstring(dw_1,lv_row_nbr,'trgt_id')
//in_subset_id = getitemstring(dw_1,lv_row_nbr,'subc_id')      1-19-98 NLG 4.0     
is_case_id   = getitemstring(dw_1,lv_row_nbr,'case_id')			//KMM 9/26/95 Prob#1102	
is_case_spl  = getitemstring(dw_1,lv_row_nbr,'case_spl')			//KMM 9/26/95
is_case_ver	 = getitemstring(dw_1,lv_row_nbr,'case_ver')			//KMM 9/26/95
in_case_id   = is_case_id + is_case_spl + is_case_ver				//KMM 9/26/95
//1-19-98 NLG 4.0                                                           ***START
//use nvo_subset_functions to retrieve internal subset id
// FDG 03/05/02 - Use subset ID to get the subset name
//in_subset_name = getitemstring(dw_1,lv_row_nbr,'subc_id') 
//if trim(in_subset_name) = '' or isnull(in_subset_name) then										// FNC 11/11/98
//	in_subset_id = ''															// FNC 11/11/98
//else																				// FNC 11/11/98
//	istr_subset_ids.subset_name = in_subset_name
//	istr_subset_ids.subset_case_id = is_case_id
//	istr_subset_ids.subset_case_spl = is_case_spl
//	istr_subset_ids.subset_case_ver = is_case_ver
//	// Retrieve internal subset id by call to nvo
//	inv_subset_functions.uf_set_structure(istr_subset_ids)
//	ll_rows = inv_subset_functions.uf_retrieve_subset_id()
//	if ll_rows < 1 then
//		MessageBox('ERROR',"Unable to retrieve subset id")
//		return
//	end if
//	istr_subset_ids = inv_subset_functions.uf_get_structure()
//	in_subset_id = istr_subset_ids.subset_id
//	in_dept_id = getitemstring(dw_1,lv_row_nbr,'target_cntl_dept_id')
//end if
in_subset_id = getitemstring(dw_1,lv_row_nbr,'subc_id') 
if trim(in_subset_id) = '' or isnull(in_subset_id) then			
	in_subset_name =	''	
	in_subset_id	=	''
else																		
	istr_subset_ids.subset_id = in_subset_id
	istr_subset_ids.subset_case_id = is_case_id
	istr_subset_ids.subset_case_spl = is_case_spl
	istr_subset_ids.subset_case_ver = is_case_ver
	// Retrieve internal subset id by call to nvo
	inv_subset_functions.uf_set_structure(istr_subset_ids)
	ll_rows = inv_subset_functions.uf_retrieve_subset_name()
	if ll_rows < 1 then
		MessageBox('ERROR',"Unable to retrieve subset id")
		return
	end if
	istr_subset_ids = inv_subset_functions.uf_get_structure()
	in_subset_name = istr_subset_ids.subset_name
	in_dept_id = getitemstring(dw_1,lv_row_nbr,'target_cntl_dept_id')
end if
// FDG 03/05/02 end


end event

on retrieveend;//Parent.controlmenu = true							//FDG 06/13/96
cb_stop.enabled = false
in_cancel = true
st_row_count.text = string(rowcount())

triggerevent(dw_1,rowfocuschanged!)
end on

type sle_case_id from singlelineedit within w_target_list
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = textrole!
integer x = 384
integer y = 104
integer width = 818
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
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

type st_1 from statictext within w_target_list
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 112
integer width = 270
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
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_target_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer y = 20
integer width = 2661
integer height = 360
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

type sle_range from editmask within w_target_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = textrole!
integer x = 1778
integer y = 228
integer width = 247
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####"
end type

