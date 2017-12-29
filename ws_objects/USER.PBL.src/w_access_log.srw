$PBExportHeader$w_access_log.srw
$PBExportComments$This screen is used to display Stars access activity log - GR
forward
global type w_access_log from w_master
end type
type st_dw_ops from statictext within w_access_log
end type
type st_row_count from statictext within w_access_log
end type
type cb_close from u_cb within w_access_log
end type
type cb_refresh from u_cb within w_access_log
end type
type dw_1 from u_dw within w_access_log
end type
type ddlb_dw_ops from dropdownlistbox within w_access_log
end type
end forward

global type w_access_log from w_master
long backcolor = 67108864
string accessiblename = "Access Log"
string accessibledescription = "Access Log"
accessiblerole accessiblerole = windowrole!
integer width = 2683
integer height = 1764
string title = "Access Log"
st_dw_ops st_dw_ops
st_row_count st_row_count
cb_close cb_close
cb_refresh cb_refresh
dw_1 dw_1
ddlb_dw_ops ddlb_dw_ops
end type
global w_access_log w_access_log

type variables
String in_dw_control, in_selected
sx_decode_structure in_decode_struct
w_uo_win iv_uo_win
end variables

on w_access_log.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
this.st_row_count=create st_row_count
this.cb_close=create cb_close
this.cb_refresh=create cb_refresh
this.dw_1=create dw_1
this.ddlb_dw_ops=create ddlb_dw_ops
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
this.Control[iCurrent+2]=this.st_row_count
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_refresh
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.ddlb_dw_ops
end on

on w_access_log.destroy
call super::destroy
destroy(this.st_dw_ops)
destroy(this.st_row_count)
destroy(this.cb_close)
destroy(this.cb_refresh)
destroy(this.dw_1)
destroy(this.ddlb_dw_ops)
end on

event open;call super::open;THIS.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
THIS.PostEvent( "ue_retrieve" )
end event

event ue_retrieve();call super::ue_retrieve;SetPointer( HourGlass! )
w_main.SetMicroHelp( "Retrieving Access Log..." )
dw_1.SetFilter( "" )
dw_1.Filter()
dw_1.SetSort( "user_log_log_date D" )
dw_1.Sort()
st_row_count.Text = String( dw_1.Retrieve() )
w_main.SetMicroHelp( "Ready" )
end event

type st_dw_ops from statictext within w_access_log
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 1432
integer width = 613
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

type st_row_count from statictext within w_access_log
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 18
integer y = 1592
integer width = 274
integer height = 60
boolean bringtotop = true
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

type cb_close from u_cb within w_access_log
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2336
integer y = 1560
integer width = 279
integer height = 80
integer taborder = 20
string text = "&Close"
end type

event clicked;call super::clicked;Close( Parent )
end event

type cb_refresh from u_cb within w_access_log
string accessiblename = "Refresh"
string accessibledescription = "Refresh"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2034
integer y = 1560
integer width = 302
integer height = 80
integer taborder = 20
string text = "&Refresh"
end type

event clicked;call super::clicked;PARENT.TriggerEvent( "ue_retrieve" )
end event

type dw_1 from u_dw within w_access_log
string accessiblename = "Access Log Data"
string accessibledescription = "Access Log Data"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 16
integer width = 2597
integer height = 1416
integer taborder = 10
string dataobject = "d_access_log"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;THIS.SetTransObject( Stars2ca )
THIS.of_SetUpdateable( FALSE )
THIS.of_SingleSelect( TRUE )
end event

event doubleclicked;call super::doubleclicked;int tabpos,rc,lv_indx,lv_found
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
//anne-s 11-28-97
//	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
//	End If
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row //getclickedrow(dw_1)
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row //getclickedrow(dw_1)
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
End If

triggerevent(dw_1,rowfocuschanged!)
end event

type ddlb_dw_ops from dropdownlistbox within w_access_log
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 18
integer y = 1504
integer width = 599
integer height = 176
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long backcolor = 1073741824
string text = "Data Window Manipulations"
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

