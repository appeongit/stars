HA$PBExportHeader$w_tracking_list.srw
$PBExportComments$List of Tracking Entries; displayed by Search By (inherited from w_master)
forward
global type w_tracking_list from w_master
end type
type sle_disp from u_sle within w_tracking_list
end type
type st_2 from statictext within w_tracking_list
end type
type st_dw_ops from statictext within w_tracking_list
end type
type ddlb_dw_ops from dropdownlistbox within w_tracking_list
end type
type st_description from statictext within w_tracking_list
end type
type st_11 from statictext within w_tracking_list
end type
type ddlb_type from dropdownlistbox within w_tracking_list
end type
type st_10 from statictext within w_tracking_list
end type
type st_row_count from statictext within w_tracking_list
end type
type cb_exit from u_cb within w_tracking_list
end type
type cb_stop from u_cb within w_tracking_list
end type
type dw_1 from u_dw within w_tracking_list
end type
type rb_dup_check_only from radiobutton within w_tracking_list
end type
type rb_all_trk_ent from radiobutton within w_tracking_list
end type
type ddlb_status from dropdownlistbox within w_tracking_list
end type
type sle_disp_date from singlelineedit within w_tracking_list
end type
type st_8 from statictext within w_tracking_list
end type
type st_7 from statictext within w_tracking_list
end type
type st_6 from statictext within w_tracking_list
end type
type sle_upin from singlelineedit within w_tracking_list
end type
type st_5 from statictext within w_tracking_list
end type
type sle_track_key from singlelineedit within w_tracking_list
end type
type st_4 from statictext within w_tracking_list
end type
type cb_select from u_cb within w_tracking_list
end type
type cb_list from u_cb within w_tracking_list
end type
type sle_case_id from singlelineedit within w_tracking_list
end type
type st_1 from statictext within w_tracking_list
end type
type gb_1 from groupbox within w_tracking_list
end type
type sle_range from editmask within w_tracking_list
end type
type sle_assigned_to from singlelineedit within w_tracking_list
end type
type st_3 from statictext within w_tracking_list
end type
end forward

global type w_tracking_list from w_master
string accessiblename = "Case Track List"
string accessibledescription = "Case Track List"
integer x = 169
integer y = 56
integer width = 2702
integer height = 1720
string title = "Case Track List"
sle_disp sle_disp
st_2 st_2
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
st_description st_description
st_11 st_11
ddlb_type ddlb_type
st_10 st_10
st_row_count st_row_count
cb_exit cb_exit
cb_stop cb_stop
dw_1 dw_1
rb_dup_check_only rb_dup_check_only
rb_all_trk_ent rb_all_trk_ent
ddlb_status ddlb_status
sle_disp_date sle_disp_date
st_8 st_8
st_7 st_7
st_6 st_6
sle_upin sle_upin
st_5 st_5
sle_track_key sle_track_key
st_4 st_4
cb_select cb_select
cb_list cb_list
sle_case_id sle_case_id
st_1 st_1
gb_1 gb_1
sle_range sle_range
sle_assigned_to sle_assigned_to
st_3 st_3
end type
global w_tracking_list w_tracking_list

type variables
// Katie	11/09/2004 Track 3741 Added target_id as addition variable
int in_nbr_rows
string in_TrackTypeHC,in_TrackTypeHB,in_TrackTypePV
string in_TrackTypePC,in_TrackTypeBE
string in_case_id,in_trk_type,in_trk_key,in_target_id,in_sel
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct

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
//Nvo for Case mgmt rel 4.5 AJS 09/03/99
n_cst_case	inv_case

end variables

forward prototypes
public subroutine wf_visibility (boolean arg_visibile)
end prototypes

public subroutine wf_visibility (boolean arg_visibile);ddlb_status.visible = arg_visibile
ddlb_type.visible = arg_visibile
sle_case_id.visible = arg_visibile
sle_disp.visible = arg_visibile
sle_disp_date.visible = arg_visibile
sle_range.visible = arg_visibile
sle_track_key.visible = arg_visibile
sle_upin.visible = arg_visibile


end subroutine

event open;call super::open;//********************************************************************
// 10-20-95 FNC Take out connects and disconnects
// 09-23-94 FNC Vary menu name depending on gv_sys_dflt
//	04-01-96	FDG Add SetRedraw(TRUE) when exiting the script
//	04-16-96	FDG Always default the range to 7 days (even if there's a
//					 case).
//	06-11-98	NLG Change hardcoded date range to call to nvo_sys_cntl
// 03-24-99 FNC Rls 4.0 SP2/TS2195C
// 09-02-99 AJS Rls 4.5 TS2363
// 01/11/05 Katie Track 5431c Changed global references to instance references.
//********************************************************************
string xcode,xdesc,lv_add_item,lv_window_name
int n,lv_rc,lv_index
//make sure the d_tracking list's data source is in sql syntax mode
//not graphics.  For further explanation contact Scott-D

ib_allow_switch		=	TRUE
ib_show_sql				=	TRUE

This.of_set_sys_cntl_range (TRUE)//NLG 6-11-98

SetPointer(hourglass!)
//fx_set_window_colors(w_tracking_list)
SetMicroHelp(w_main,'Ready')

//ajs 09/03/99 rel 4.5
inv_case = CREATE n_cst_case

sle_case_id.text = gv_active_case	//03-24-99 FNC 7-2-98 /NLG Track #1391 Don't default case id
cb_select.enabled = FALSE 				//7-2-98 NLG Track #1391 Don't default case id
in_sel = dw_1.getsqlSelect()
additem(ddlb_type,"")
additem(ddlb_status,"")
cb_list.default = TRUE

rb_all_trk_ent.checked = TRUE
rb_all_trk_ent.triggerevent(clicked!)

il_gb_x			=	gb_1.x
il_gb_y			=	gb_1.y
il_gb_height	=	gb_1.height
il_gb_width		=	gb_1.width
il_dw_x			=	dw_1.x
il_dw_y			=	dw_1.y
il_dw_height	=	dw_1.height
il_dw_width		=	dw_1.width

load_ddlb_values(ddlb_status,'SA','B',2)
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

this.setredraw(false)
show(this)

lv_window_name = UPPER(this.classname())
lv_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars2ca) 
If lv_rc = -5 Then
	lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(lv_index)
End If
COMMIT using stars2ca;
If stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in open')
	this.setredraw(true)								//	FDG 04/01/96
   return
end if                            // 10-20-95 FNC End

If trim(sle_case_id.text) <> '' then
	//sle_range.text     = '7'						// FDG 04/16/96
	sle_range.text  = String ( inv_sys_cntl.of_get_cntl_no() )
	triggerevent(cb_list,clicked!)
Else
	//sle_disp_date.text = string(today())
	sle_disp_date.text = inv_sys_cntl.of_get_default_date()//ts2020c
	//sle_range.text     = '7'
	sle_range.text  = String ( inv_sys_cntl.of_get_cntl_no() )
End If



this.setredraw(true)


end event

event activate;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_tracking_list
//		Event Name:		Activate
//
//************************************************************************
//
//	FDG	07/29/97	When resizing the window, the resized dimensions of
//						dw_1 & gb_1 must be used in the computations.
// Katie 01/11/05 Track 5431c Added code to reset menu to instance settings
//						and changed global references to instance references.
//
//
//************************************************************************


this.SetRedraw(FALSE)

if ib_show_sql = FALSE THEN
	//	Hide gb_1 and everything in it
   dw_1.X      = il_gb_x	-	5
   dw_1.Y      = 1
   dw_1.Height = il_gb_height	+	il_dw_height	+	10
   wf_visibility(FALSE)
   dw_1.Show ()
else
	//	Show gb_1 and everything in it
   dw_1.X      = il_dw_x
   dw_1.Y      = il_dw_y
   dw_1.Height = il_dw_height
   wf_visibility(TRUE)
   dw_1.Show ()         
end if

m_stars_30.m_file.m_showsql.event ue_restore_win_settings() 

this.SetRedraw(TRUE)



//if isvalid( iv_uo_win ) Then
//	iv_uo_win.show()
//end if
end event

event close;call super::close;// Katie 01/11/05 Track 5431c Removed reference to gv_allow_switch and added event call
//						to reset menu.

m_stars_30.m_file.m_showsql.event ue_reset()

//ajs 09/03/99 add destroy of nvo TS2363
destroy(inv_case)
if isvalid( iv_uo_win ) Then
close(iv_uo_win)
end if
end event

on w_tracking_list.create
int iCurrent
call super::create
this.sle_disp=create sle_disp
this.st_2=create st_2
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_description=create st_description
this.st_11=create st_11
this.ddlb_type=create ddlb_type
this.st_10=create st_10
this.st_row_count=create st_row_count
this.cb_exit=create cb_exit
this.cb_stop=create cb_stop
this.dw_1=create dw_1
this.rb_dup_check_only=create rb_dup_check_only
this.rb_all_trk_ent=create rb_all_trk_ent
this.ddlb_status=create ddlb_status
this.sle_disp_date=create sle_disp_date
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.sle_upin=create sle_upin
this.st_5=create st_5
this.sle_track_key=create sle_track_key
this.st_4=create st_4
this.cb_select=create cb_select
this.cb_list=create cb_list
this.sle_case_id=create sle_case_id
this.st_1=create st_1
this.gb_1=create gb_1
this.sle_range=create sle_range
this.sle_assigned_to=create sle_assigned_to
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_disp
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_dw_ops
this.Control[iCurrent+4]=this.ddlb_dw_ops
this.Control[iCurrent+5]=this.st_description
this.Control[iCurrent+6]=this.st_11
this.Control[iCurrent+7]=this.ddlb_type
this.Control[iCurrent+8]=this.st_10
this.Control[iCurrent+9]=this.st_row_count
this.Control[iCurrent+10]=this.cb_exit
this.Control[iCurrent+11]=this.cb_stop
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.rb_dup_check_only
this.Control[iCurrent+14]=this.rb_all_trk_ent
this.Control[iCurrent+15]=this.ddlb_status
this.Control[iCurrent+16]=this.sle_disp_date
this.Control[iCurrent+17]=this.st_8
this.Control[iCurrent+18]=this.st_7
this.Control[iCurrent+19]=this.st_6
this.Control[iCurrent+20]=this.sle_upin
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.sle_track_key
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.cb_select
this.Control[iCurrent+25]=this.cb_list
this.Control[iCurrent+26]=this.sle_case_id
this.Control[iCurrent+27]=this.st_1
this.Control[iCurrent+28]=this.gb_1
this.Control[iCurrent+29]=this.sle_range
this.Control[iCurrent+30]=this.sle_assigned_to
this.Control[iCurrent+31]=this.st_3
end on

on w_tracking_list.destroy
call super::destroy
destroy(this.sle_disp)
destroy(this.st_2)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.st_description)
destroy(this.st_11)
destroy(this.ddlb_type)
destroy(this.st_10)
destroy(this.st_row_count)
destroy(this.cb_exit)
destroy(this.cb_stop)
destroy(this.dw_1)
destroy(this.rb_dup_check_only)
destroy(this.rb_all_trk_ent)
destroy(this.ddlb_status)
destroy(this.sle_disp_date)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.sle_upin)
destroy(this.st_5)
destroy(this.sle_track_key)
destroy(this.st_4)
destroy(this.cb_select)
destroy(this.cb_list)
destroy(this.sle_case_id)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.sle_range)
destroy(this.sle_assigned_to)
destroy(this.st_3)
end on

event resize;call super::resize;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_tracking_list
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

event ue_postopen;call super::ue_postopen;    
//*******************************************************************
//* ajs 09-07-99 Rls 4.5 TS2363 - make custom fields visible & fix headings
//*       
//*******************************************************************
String ls_desc, ls_column
Int i
dw_1.SetRedraw(False)
//For i = 1 to 6
//	ls_column = 'custom' + string(i) + '_amt'
//	ls_desc  =  inv_case.uf_get_track_amt_heading(ls_column)
//	IF Len(ls_desc) > 0  THEN
//		dw_1.Modify(ls_column + ".Visible='1'")
//	ELSE
//		dw_1.Modify(ls_column + ".Visible='0'")
//	END IF
//Next
	
// Set the money headings for each of the money columns 
inv_case.uf_format_custom_headings (dw_1)
dw_1.SetRedraw(True)	



	
end event

event deactivate;call super::deactivate;// Katie 01/11/05 Track 5431c Added code to reset menu.

m_stars_30.m_file.m_showsql.event ue_reset()
end event

type sle_disp from u_sle within w_tracking_list
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Disposition"
string accessibledescription = "Lookup Field - Disposition"
integer x = 544
integer y = 616
integer width = 370
integer height = 88
integer taborder = 110
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event modified;call super::modified;st_description.text = ''
end event

event ue_lookup;call super::ue_lookup;// 06/25/07 SPR 5086 Changed code for Track Disposition
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

Setpointer(hourglass!)

gv_which_dw = 'CL'
gv_code_type = 'TKDS9'
open (w_select_box)

if gv_selection1 <> "" or gv_selection2 <> "" Then
	sle_disp.text = gv_selection1 
	st_description.text = gv_selection2
end if
end event

type st_2 from statictext within w_tracking_list
string accessiblename = "Display"
string accessibledescription = "Display"
accessiblerole accessiblerole = statictextrole!
integer x = 1518
integer y = 252
integer width = 261
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Display:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_dw_ops from statictext within w_tracking_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 1288
integer width = 640
integer height = 64
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

type ddlb_dw_ops from dropdownlistbox within w_tracking_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 27
integer y = 1360
integer width = 713
integer height = 312
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

event selectionchanged;//	Katie	04/10/09	GNL.600.5633	Added decode structure to fx_uo_control call.

string lv_control_text

lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end event

type st_description from statictext within w_tracking_list
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 946
integer y = 616
integer width = 1627
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_11 from statictext within w_tracking_list
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = statictextrole!
integer x = 174
integer y = 428
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
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

type ddlb_type from dropdownlistbox within w_tracking_list
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 544
integer y = 424
integer width = 818
integer height = 332
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"BE - Patient","PV - Provider","PC - Procedure","RV - Revenue Code"}
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within w_tracking_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = statictextrole!
integer x = 2327
integer y = 436
integer width = 219
integer height = 76
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

type st_row_count from statictext within w_tracking_list
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 1460
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

type cb_exit from u_cb within w_tracking_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2231
integer y = 1444
integer width = 343
integer height = 108
integer taborder = 170
integer weight = 400
string text = "&Close"
end type

on clicked;Setpointer(hourglass!)

close (parent)
end on

type cb_stop from u_cb within w_tracking_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
integer x = 1847
integer y = 1444
integer width = 338
integer height = 108
integer taborder = 160
integer weight = 400
string text = "S&top"
end type

on clicked;gv_cancel_but_clicked = TRUE

end on

type dw_1 from u_dw within w_tracking_list
string tag = "CRYSTAL, title = Tracking Entries"
string accessiblename = "Tracking List"
string accessibledescription = "Tracking List"
integer x = 32
integer y = 736
integer width = 2574
integer height = 544
integer taborder = 120
string dataobject = "d_tracking_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

on retrieveend;//w_tracking_list.controlmenu = TRUE						//FDG 06/13/96
cb_stop.enabled = FALSE
cb_exit.enabled = TRUE
cb_list.enabled = TRUE

gv_cancel_but_clicked = TRUE

triggerevent(dw_1,rowfocuschanged!)
end on

event doubleclicked;//Script for W_Track_list doubleclicked for dw_1
//////////////////////////////////////////////////////////////////////
//anne-s 11-28-97 TS242 Rel 3.6
int tabpos,rc,lv_indx,lv_found
int lv_upper
long row_nbr
string lv_hold_object,lv_col,lv_tbl_type
boolean lv_lookup,lv_found_flag,lv_join

lv_join = FALSE

Setpointer(Hourglass!)
//store the current row number and the column name
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
		row_nbr = row
//		lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',row_nbr,in_decode_struct)
Else
     Setpointer(hourglass!)
     row_nbr = row
     if row_nbr > 0 then
       triggerevent(cb_select,Clicked!)
       return
     end if 
End If		





end event

event rowfocuschanged;string test
int row_nbr,clicked_row
string lv_case_id, lv_case_spl, lv_case_ver

//This event will only function if the stop button has been clicked//

if gv_cancel_but_clicked = TRUE Then 

	cb_select.enabled = true

	
	row_nbr = getrow(dw_1)
	// FDG 01/17/02 Track 2699d.  If no rows exist, get out
	If row_nbr = 0 			&
	or	This.RowCount()	<	1	then 
   	cb_select.enabled = false
		return
	end if
	cb_list.default = false            //KMM 1/12/95
	cb_select.default = true
//Highlights the current row
	SelectRow(dw_1,0,FALSE)
	SelectRow(dw_1,row_nbr,TRUE)
	lv_case_id= getitemstring(dw_1,row_nbr,1)
	in_trk_type=getitemstring(dw_1,row_nbr,4)
	in_trk_key = getitemstring(dw_1,row_nbr,5)
	in_target_id = getitemstring(dw_1,row_nbr,30)
	lv_case_spl = getitemstring(dw_1,row_nbr,2) 
	lv_case_ver = getitemstring(dw_1,row_nbr,3)
	in_case_id = lv_case_id + lv_case_spl + lv_case_ver

//Stores the clicked row's keys into instance variables
	
end if


end event

on retrievestart;Setpointer(hourglass!)
gv_cancel_but_clicked = FALSE
cb_stop.enabled = TRUE
end on

type rb_dup_check_only from radiobutton within w_tracking_list
string accessiblename = "Dup Check Only"
string accessibledescription = "Dup Check Only"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1851
integer y = 340
integer width = 590
integer height = 68
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Dup Check Only"
boolean automatic = false
end type

event clicked;//in_tracktypehc = "HC"
//in_tracktypehb = "HB"
//  this code is only retained in case it is changed back to use hb, hc
THIS.Checked = TRUE
rb_all_trk_ent.Checked = FALSE
in_tracktypepv = "PV"
in_tracktypebe = ""
in_tracktypepc = ""

in_tracktypepv = "PV"
in_tracktypebe = "BE"
in_tracktypepc = "PC"
end event

type rb_all_trk_ent from radiobutton within w_tracking_list
string accessiblename = "All Track Entries"
string accessibledescription = "All Track Entries"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1851
integer y = 240
integer width = 590
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "All Track Entries"
boolean automatic = false
end type

event clicked;//in_tracktypehc = "HC"
//in_tracktypehb = "HB"
//  this code is only retained in case it is changed back to HB, HC
THIS.Checked = TRUE
rb_dup_check_only.Checked = FALSE
in_tracktypepv = "PV"
in_tracktypebe = "BE"
in_tracktypepc = "PC"
end event

type ddlb_status from dropdownlistbox within w_tracking_list
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = comboboxrole!
integer x = 544
integer y = 524
integer width = 1280
integer height = 376
integer taborder = 80
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

type sle_disp_date from singlelineedit within w_tracking_list
string accessiblename = "Dispositon Date"
string accessibledescription = "Dispositon Date"
accessiblerole accessiblerole = textrole!
integer x = 1851
integer y = 520
integer width = 448
integer height = 88
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_tracking_list
string accessiblename = "Disposition"
string accessibledescription = "Disposition"
accessiblerole accessiblerole = statictextrole!
integer x = 146
integer y = 628
integer width = 370
integer height = 72
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

type st_7 from statictext within w_tracking_list
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = statictextrole!
integer x = 270
integer y = 536
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
string text = "Status:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_tracking_list
string accessiblename = "Status/Disp Date"
string accessibledescription = "Status/Disp Date"
accessiblerole accessiblerole = statictextrole!
integer x = 1792
integer y = 436
integer width = 517
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Status/Disp Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_upin from singlelineedit within w_tracking_list
string accessiblename = "UPIN"
string accessibledescription = "UPIN"
accessiblerole accessiblerole = textrole!
integer x = 544
integer y = 196
integer width = 704
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
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_tracking_list
string accessiblename = "UPIN"
string accessibledescription = "UPIN"
accessiblerole accessiblerole = statictextrole!
integer x = 270
integer y = 208
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
string text = "UPIN:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_track_key from singlelineedit within w_tracking_list
string accessiblename = "Track Key"
string accessibledescription = "Track Key"
accessiblerole accessiblerole = textrole!
integer x = 544
integer y = 304
integer width = 704
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

type st_4 from statictext within w_tracking_list
string accessiblename = "Track Key"
string accessibledescription = "Track Key"
accessiblerole accessiblerole = statictextrole!
integer x = 192
integer y = 312
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Track Key:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_select from u_cb within w_tracking_list
string accessiblename = "Select..."
string accessibledescription = "Select..."
integer x = 1266
integer y = 1444
integer width = 343
integer height = 108
integer taborder = 150
integer weight = 400
string text = "&Select..."
end type

event clicked;//***************************************************************
// AJS   03-11-98 4.0 fix split of case id
//06-18-97 FNC FS/TS154 Check security before opening detail window
//					This will make sure all case security is consistent
//08-31-98 NLG FS362 convert case to case_cntl
// 11/09/2004 Katie	Track 3741 added target_id as additional retrieveal argument for track
//***************************************************************
string ls_case_id,ls_case_spl,ls_case_ver,ls_dept_code	//06-18-97 FNC
integer li_code_sec													//06-18-97 FNC
sx_case_track lstr_case_track

SetMicroHelp(W_Main,'Opening the Maintain Screen with the selected info')
/*opens maintance screen*/
Setpointer(hourglass!)
//gv_case_id  = in_case_id	//ajs 4.0 02-25-98 globals
//06-18-97 FNC Start

ls_case_id = left(in_case_id,10)
ls_case_spl = mid(in_case_id,11,2)
ls_case_ver = mid(in_case_id,13,2)	// AJS   03-11-98 4.0 fix split of case id


//AJS 09-08-99 populate structure instead of using globals
lstr_case_track.case_id = in_case_id
lstr_case_track.trk_type = in_trk_type
lstr_case_track.trk_key = in_trk_key
lstr_case_track.target_id = in_target_id

//08-31-98 NLG FS362 convert case to case_cntl
Select code_value_a,code_value_n
	into :ls_dept_code, :li_code_sec
	from CODE CD,CASE_CNTL CC	
	where CC.case_id = Upper( :ls_case_id ) and
			CC.case_spl = Upper( :ls_case_spl ) and
			CC.case_ver = Upper( :ls_case_ver ) and
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
		OpensheetWithParm (w_track_maint,lstr_case_track,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)	//ajs 4.0 02-25-98 globals
	End If
Else
	OpensheetWithParm (w_track_maint,lstr_case_track,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)		//ajs 4.0 02-25-98 globals
End If

//06-18-97 FNC Start


end event

type cb_list from u_cb within w_tracking_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 855
integer y = 1444
integer width = 343
integer height = 108
integer taborder = 140
integer weight = 400
string text = "&List"
end type

event clicked;//***************************************************
//05/04/00	FDG	Track 2266.  If no rows are returned, do not display
//						an error message.
//01/12/99	FDG	Track 2047c.  Add Y2K edits for 4-digit year
//						and date range.
//08-31-98	NLG 	FS362 convert case to case_cntl
//06-11-98	NLG 	Change hardcoded date range to call to nvo_sys_cntl
//09-05-96	FNC	STARS35 Prob #17. Default sle_disp_date to the current
//						date even if there is a case id.  
//04-16-96	FDG 	Always default the range to 7 days 
//					 	(even if there's a case).
//10-20-95	FNC 	Take out connects and disconnects
//06-29-95	FNC 	Correct dup check logic 
//09/03/99	ajs 	4.5 add security check & display of new headings
//01/04/01	GaryR	Stars 4.7 DataBase Port - Date Conversion
//06/27/01	GaryR	Track 3383C - Refresh the rowcount after removing secured cases
// JasonS 09/30/02 Track 3314d call uf_format_custom_headings
// Katie	 01/11/05 Track 5431c Changed global reference to instance.
// 06/25/07 SPR 5086 Changed code for Track Disposition
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//***************************************************
//  Clicked event for CB_LIST on W_TRACKING_LIST

Long lv_nbr_rows, ll_rowcount, ll_row
int li_rc,lv_range
date lv_from_date,lv_to_date
datetime lv_from_date_time,lv_to_date_time,lv_case_datetime
string lv_status,lv_type, lv_alert,sort,sel,where
string lv_case_id,lv_case_id_spl,lv_case_id_ver,sql
string lv_trk_key,lv_upin,lv_disp,lv_disp_date,dup_check,lv_display,all_entries
String lv_case,lv_spl,lv_ver
String ls_assigned_to, ls_case_cat, ls_msg

// JasonS 09/30/02 Begin - Track 3314d
n_cst_case lnv_case
lnv_case = create n_cst_case
// JasonS 09/30/02 End - Track 3314d

Setpointer(hourglass!)
lv_case_id = format_where(left(sle_case_id.text,10),'LIKE','')
if mid(lv_case_id,1,1) = '!' then
   lv_case_id = '~''+'%'+'~''
end if
lv_case_id_spl = format_where(mid(sle_case_id.text,11,2),'LIKE','')
if mid(lv_case_id_spl,1,1) = '!' then
   lv_case_id_spl = '~''+'%'+'~''
end if
lv_case_id_ver = format_where(mid(sle_case_id.text,13,2),'LIKE','')
if mid(lv_case_id_ver,1,1) = '!' then
   lv_case_id_ver = '~''+'%'+'~''
end if
lv_status = format_where(left(ddlb_status.text,2),'LIKE','')
if mid(lv_status,1,1) = '!' then
   lv_status = '~''+'%'+'~''
end if
lv_type = format_where(left(ddlb_type.text,2),'LIKE','')
if mid(lv_type,1,1) = '!' then
   lv_type = '~''+'%'+'~''
end if
lv_trk_key = format_where(sle_track_key.text,'LIKE','')
if mid(lv_trk_key,1,1) = '!' then
   lv_trk_key = '~''+'%'+'~''
end if
lv_upin = format_where(sle_upin.text,'LIKE','')
if mid(lv_upin,1,1) = '!' then
   lv_upin = '~''+'%'+'~''
end if
lv_disp = format_where(sle_disp.text,'LIKE','')
if mid(lv_disp,1,1) = '!' then
   lv_disp = '~''+'%'+'~''
end if
//ajs 09/03/99 Rls 4.5 TS2363
ls_assigned_to = format_where(sle_assigned_to.text,'LIKE','')
if mid(ls_assigned_to,1,1) = '!' then
   ls_assigned_to = '~''+'%'+'~''
end if


setpointer(hourglass!) 
SetMicroHelp(W_Main,'Listing All Code Types Based On The Criteria')	

n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate (sle_disp_date.text)

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		sle_disp_date.SetFocus()
		Return	-1
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		sle_disp_date.SetFocus()
		Return	-1
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		sle_disp_date.SetFocus()
		Return	-1
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.
lv_from_date_time	=	lnv_datetime.of_GetFromDateTime (sle_disp_date.text, sle_range.text)
lv_to_date			=	Date (sle_disp_date.text)
lv_to_date_time	=	DateTime (lv_to_date, 23:59:59)



// FDG 1/12/99 end

IF rb_dup_check_only.checked = true  THEN
		lv_alert = format_where('Y','LIKE','')
ELSE
	//  Default to all entries.
	lv_alert = '~''+'%'+ '~''
END IF

If sle_disp.text <> '' then
	Select code_desc into :st_description.text
		from code
		Where code_type = 'TKDS9' and
				Code_code = Upper( :sle_disp.text )
	Using Stars2ca;
	If Stars2ca.of_check_status() = 100 then
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in open')
      end if                            // 10-20-95 FNC End
		Messagebox('EDIT','Invalid Disposition Code')
		RETURN
	Elseif Stars2ca.sqlcode <> 0 then
			Errorbox(Stars2ca,'Error getting Code Description from the Table')
			RETURN
	End IF
Else
	St_description.text = ''
End IF

lv_disp_date = gnv_sql.of_get_to_date( String( lv_from_date_time, 'mm/dd/yyyy hh:mm:ss' ) ) + &
		' AND ' + gnv_sql.of_get_to_date( String( lv_to_date_time, 'mm/dd/yyyy hh:mm:ss' ) )
// FDG 1/12/99 end

//**************************RETRIEVE FOR DW_1 SECTION***************************
//This Section connects to the transection object and then retrieves the
//data to be put in the datawindow.  If there is an error during either
//of these an error box is shown.
//*************************************************************************\

Reset(DW_1)
//w_tracking_list.controlmenu = FALSE				//FDG 06/13/96
cb_list.enabled = FALSE
cb_exit.enabled = FALSE

li_rc = SetTransObject(DW_1,stars2ca)
if li_rc = -1 Then
	errorbox(stars2ca,'Error Setting Transaction Object')
	cb_list.enabled = TRUE
	cb_exit.enabled = TRUE
	return
end if

where = ' WHERE CASE_CNTL.CASE_ID = TRACK.CASE_ID and CASE_CNTL.CASE_SPL = TRACK.CASE_SPL and CASE_CNTL.CASE_VER = TRACK.CASE_VER AND TRACK.CASE_ID LIKE '+ Upper( lv_case_id ) + ' AND TRACK.CASE_SPL LIKE '+ Upper( lv_case_id_spl ) + ' AND TRACK.CASE_VER LIKE ' + Upper( lv_case_id_ver ) + ' AND TRK_TYPE LIKE ' + Upper( lv_type ) + ' AND TRK_KEY LIKE ' + Upper( lv_trk_key ) + ' AND TRK_KEY_ALT LIKE ' + Upper( lv_upin ) + ' AND STATUS LIKE ' + Upper( lv_status ) +' AND DISP LIKE ' + Upper( lv_disp ) + ' AND STATUS_DATETIME BETWEEN '+lv_disp_date+ lv_display+' AND ALERT_IND LIKE ' + Upper( lv_alert ) + ' AND CASE_ASGN_ID LIKE ' + Upper( ls_assigned_to )
sql = in_sel+where+sort
dw_1.setsqlselect(sql)

lv_nbr_rows = Retrieve(dw_1)

if lv_nbr_rows = -1 Then
	errorbox(stars2ca,'Error retrieving data for the datawindow')
//	w_tracking_list.controlmenu = TRUE					//FDG 06/13/96
	cb_list.enabled = TRUE
	cb_exit.enabled = TRUE
	return
end if
//************************CASE SECURITY SECTION*************************
//This section invokes case security checks.  Remove rows which the
//user should not be able to view.
//*********************************************************************
//ajs 4.5 09/03/99 add security check
dw_1.SetRedraw (FALSE)
ll_rowcount  =  dw_1.RowCount()
FOR  ll_row  =  1  TO  ll_rowcount
	ls_case_cat  = dw_1.object.case_cat [ll_row]	
	ls_msg  =  inv_case.uf_edit_case_security (ls_case_cat)
	IF  len (ls_msg)  >  0   THEN
		Dw_1.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row -- 
		ll_rowcount --
	END IF
NEXT
dw_1.SetRedraw (TRUE)

//************************ERROR CHECKING SECTION*************************
//This section checks to see if there
//was just one row retrieved.  If there is non found a error message is
//shown and it returns to the window.  If there is one row it loads the
//w_maintain window
//*********************************************************************
/*Checks to see if there is no data in the table*/
gv_cancel_but_clicked = TRUE

//06/27/01	GaryR
lv_nbr_rows = dw_1.RowCount()
st_row_count.text = string(lv_nbr_rows)
If lv_nbr_rows = 0 Then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in open')
   end if                            // 10-20-95 FNC End
	SetMicroHelp(w_main,'Search Cancelled')
	// FDG 05/04/00 - If no rows returns do not show an error message
   setfocus(sle_case_id)
	dw_1.taborder = 0	
   return
end if 
	
if stars2ca.of_commit() <> 0 then
   errorbox(stars2ca,'Error performing commit in open')
   return
end if                            // 10-20-95 FNC End
cb_select.enabled = TRUE

ib_allow_switch = TRUE

dw_1.taborder = 150

// JasonS 09/30/02 Begin - Track 3314d
lnv_case.uf_format_custom_headings(dw_1)
destroy lnv_case
// JasonS 09/30/02 End - Track 3314d

SetMicroHelp(w_main,'Ready')
Setfocus(dw_1)
end event

type sle_case_id from singlelineedit within w_tracking_list
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = textrole!
integer x = 544
integer y = 88
integer width = 704
integer height = 96
integer taborder = 10
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

event modified;//NLG	6-11-98	Change hardcoded date range to nvo_sys_cntl
//--------------------------------------------------------------------------------
If sle_case_id.text = '' then
   if sle_disp_date.text = '' then
  	  //sle_disp_date.text = string(today())
		 sle_disp_date.text = inv_sys_cntl.of_get_default_date()
   end if
   if sle_range.text = '' then
//	  sle_range.text     = '7'
		sle_range.text = string(inv_sys_cntl.of_get_cntl_no())
   end if
Else
	  sle_disp_date.text = ''
	  sle_range.text     = ''
End IF
end event

type st_1 from statictext within w_tracking_list
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 210
integer y = 108
integer width = 306
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

type gb_1 from groupbox within w_tracking_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 41
integer y = 4
integer width = 2574
integer height = 716
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

type sle_range from editmask within w_tracking_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = textrole!
integer x = 2327
integer y = 520
integer width = 247
integer height = 88
integer taborder = 100
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

type sle_assigned_to from singlelineedit within w_tracking_list
string accessiblename = "Assigned To"
string accessibledescription = "Assigned To"
accessiblerole accessiblerole = textrole!
integer x = 1851
integer y = 88
integer width = 677
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_tracking_list
string accessiblename = "Assigned To"
string accessibledescription = "Assigned To"
accessiblerole accessiblerole = statictextrole!
integer x = 1381
integer y = 104
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Assigned To:"
alignment alignment = right!
boolean focusrectangle = false
end type

