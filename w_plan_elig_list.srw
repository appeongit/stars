HA$PBExportHeader$w_plan_elig_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_plan_elig_list from w_master
end type
type st_dw_ops from statictext within w_plan_elig_list
end type
type ddlb_dw_ops from dropdownlistbox within w_plan_elig_list
end type
type cb_close from u_cb within w_plan_elig_list
end type
type st_row_count from statictext within w_plan_elig_list
end type
type cb_select from u_cb within w_plan_elig_list
end type
type cb_list from u_cb within w_plan_elig_list
end type
type dw_1 from u_dw within w_plan_elig_list
end type
type st_5 from statictext within w_plan_elig_list
end type
type st_4 from statictext within w_plan_elig_list
end type
type st_3 from statictext within w_plan_elig_list
end type
type mle_desc from multilineedit within w_plan_elig_list
end type
type sle_ein from singlelineedit within w_plan_elig_list
end type
type sle_id from singlelineedit within w_plan_elig_list
end type
type gb_1 from groupbox within w_plan_elig_list
end type
end forward

global type w_plan_elig_list from w_master
string accessiblename = "Plan Eligibility List"
string accessibledescription = "Plan Eligibility List"
accessiblerole accessiblerole = windowrole!
integer x = 87
integer y = 116
integer width = 2752
integer height = 1684
string title = "Plan Eligibility List"
long backcolor = 67108864
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
cb_close cb_close
st_row_count st_row_count
cb_select cb_select
cb_list cb_list
dw_1 dw_1
st_5 st_5
st_4 st_4
st_3 st_3
mle_desc mle_desc
sle_ein sle_ein
sle_id sle_id
gb_1 gb_1
end type
global w_plan_elig_list w_plan_elig_list

type variables
string iv_plan_elig
int row_nbr
sx_plan_elig iv_struct
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct

end variables

event open;call super::open;
//fx_set_window_colors(w_plan_elig_list)
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
//*Checks to see if coming from the menu*/
if gv_from = 'L' then
   cb_Select.enabled = false
//   cb_stop.enabled = false
end if


end event

on w_plan_elig_list.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.cb_close=create cb_close
this.st_row_count=create st_row_count
this.cb_select=create cb_select
this.cb_list=create cb_list
this.dw_1=create dw_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.mle_desc=create mle_desc
this.sle_ein=create sle_ein
this.sle_id=create sle_id
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
this.Control[iCurrent+2]=this.ddlb_dw_ops
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.st_row_count
this.Control[iCurrent+5]=this.cb_select
this.Control[iCurrent+6]=this.cb_list
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.mle_desc
this.Control[iCurrent+12]=this.sle_ein
this.Control[iCurrent+13]=this.sle_id
this.Control[iCurrent+14]=this.gb_1
end on

on w_plan_elig_list.destroy
call super::destroy
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.cb_close)
destroy(this.st_row_count)
destroy(this.cb_select)
destroy(this.cb_list)
destroy(this.dw_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.mle_desc)
destroy(this.sle_ein)
destroy(this.sle_id)
destroy(this.gb_1)
end on

type st_dw_ops from statictext within w_plan_elig_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 73
integer y = 1272
integer width = 741
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

type ddlb_dw_ops from dropdownlistbox within w_plan_elig_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 73
integer y = 1348
integer width = 713
integer height = 312
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
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

type cb_close from u_cb within w_plan_elig_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2295
integer y = 1448
integer width = 293
integer height = 108
integer taborder = 80
string text = "&Close"
end type

on clicked;setmicrohelp(w_main,'Ready')
close(parent)
end on

on getfocus;//setmicrohelp(w_main,'Exits Plan Eligibility listing')

end on

type st_row_count from statictext within w_plan_elig_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 73
integer y = 1448
integer width = 311
integer height = 108
integer textsize = -10
integer weight = 700
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

type cb_select from u_cb within w_plan_elig_list
string accessiblename = "SELECT"
string accessibledescription = "SELECT"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1253
integer y = 1448
integer width = 343
integer height = 108
integer taborder = 70
string text = "&Select..."
end type

on clicked;
SetPointer(hourglass!)


SetMicroHelp('Opening the Maintain Screen with the selected info')

/*opens maintance screen*/
If isvalid(w_plan_elig) then close(w_plan_elig)

OpenSheetwithParm(w_plan_elig,iv_struct,MDI_Main_Frame,Help_Menu_Position,Layered!)
end on

on getfocus;//SetMicroHelp("Selects the Highlighted Plan Eligibility")
end on

type cb_list from u_cb within w_plan_elig_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 864
integer y = 1448
integer width = 293
integer height = 108
integer taborder = 60
string text = "&List"
boolean default = true
end type

on clicked;//******************************************************************
//List plan eligibility based on selected criteria
//******************************************************************

Long lv_nbr_rows
string lv_prov_type,lv_select_stmt,stringrc,lv_modify_select
int rc,lv_pos

if (sle_id.text = '') and (sle_ein.text = '') &
	and (mle_desc.text = '') then
	if (messagebox('WARNING','With no criteria, this query may take a while. &
	  Continue anyway?',question!,OKCancel!) = 2) then
		return
	SetMicroHelp('Plan Eligibility List Canceled By User')	
	end if	
end if		
   
setpointer(hourglass!) 
SetMicroHelp('Listing Plan Eligibility Entries...')	


Reset(DW_1)
SetTransObject(DW_1,stars2ca)
lv_select_stmt = UPPER(dw_1.getsqlselect())
lv_modify_select = "datawindow.table.select = '" + lv_select_stmt +  "'"
stringrc = dw_1.Modify(lv_modify_select)

lv_nbr_rows = Retrieve(dw_1,sle_id.text+'%',sle_ein.text+'%', &
              '%'+mle_desc.text+'%')

st_row_count.text = string(lv_nbr_rows)

/*Checks to see if there is no data in the table*/
If lv_nbr_rows = 0 Then
	SetMicroHelp('No data found...')
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
   setfocus(sle_id)
	CB_Select.enabled = false
	dw_1.taborder = 0
	return
end if 


dw_1.taborder = 50
Setfocus(dw_1)

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

SetMicroHelp('Ready')
end on

on getfocus;//setmicrohelp(w_main,'Lists all Plan Eligibility')

end on

type dw_1 from u_dw within w_plan_elig_list
string accessiblename = "Plan Eligibility List"
string accessibledescription = "Plan Eligibility List"
accessiblerole accessiblerole = clientrole!
integer x = 73
integer y = 556
integer width = 2583
integer height = 704
integer taborder = 40
string dataobject = "d_plan_elig_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;//////////////////////////////////////////////////////////////////////
string test
long clicked_row
long lv_row_nbr
int tabpos,rc,lv_indx,lv_found
int lv_upper
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
	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
	else
		ddlb_dw_ops.triggerevent(selectionchanged!)  // MVR 3.6 01/13/97 Added to match other routines
	End if      
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row 
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row 
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
Else

	/*gets the row and makes sure a row was clicked*/
	row_nbr = row 
	If row_nbr = 0 then
		return
	end if

	iv_struct.id = getitemstring(dw_1,row_nbr,'plan_id')
	iv_struct.ein = getitemstring(dw_1,row_nbr,'ein')
	iv_struct.desc = getitemstring(dw_1,row_nbr,'plan_desc')
	
	triggerevent(cb_select,Clicked!)
end if
end event

event rowfocuschanged;
	/*Sets select to enabled when clicked*/
	cb_select.enabled = true
	cb_select.default = true

	/*gets the row and makes sure a row was clicked*/
	row_nbr = getrow(dw_1)
	// FDG 01/17/02 Track 2699d.  If no rows exist, get out
	If row_nbr = 0 			&
	or	This.RowCount()	<	1	then 
	   cb_select.enabled = false
		return
	end if

	/*Highlights the selected row*/
	SelectRow(dw_1,0,FALSE)
	SelectRow(dw_1,row_nbr,TRUE)

	/*Loads the selected rows keys into the structure variables*/
	iv_struct.id = getitemstring(dw_1,row_nbr,'plan_id')
	iv_struct.ein = getitemstring(dw_1,row_nbr,'ein')
	iv_struct.desc = getitemstring(dw_1,row_nbr,'plan_desc')


end event

on retrievestart;//setpointer(hourglass!)
//string lv_select_stmt
//lv_select_stmt = UPPER(dw_1.getsqlselect())
//
//w_provider_list.controlmenu = FALSE
//
//gv_cancel_but_clicked = FALSE
//cb_stop.enabled = TRUE
//
////cb_exit.enabled = FALSE
////cb_list.enabled = FALSE	
////cb_new.enabled = FALSE
////cb_select.enabled = FALSE
end on

on losefocus;cb_list.default = true
end on

on retrieveend;//w_provider_list.controlmenu = TRUE
//cb_stop.enabled = FALSE
//
////cb_exit.enabled = TRUE
////cb_new.enabled = TRUE
////cb_list.enabled = TRUE
////cb_select.enabled = TRUE
//gv_cancel_but_clicked = TRUE
//triggerevent(dw_1,rowfocuschanged!)
end on

type st_5 from statictext within w_plan_elig_list
string accessiblename = "Plan Description"
string accessibledescription = "Plan Description"
accessiblerole accessiblerole = statictextrole!
integer x = 114
integer y = 164
integer width = 535
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Plan Description:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_plan_elig_list
string accessiblename = "EMPLOYEE IDENTIFICATION NUMBER"
string accessibledescription = "EMPLOYEE IDENTIFICATION NUMBER"
accessiblerole accessiblerole = statictextrole!
integer x = 1490
integer y = 56
integer width = 151
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "EIN:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_plan_elig_list
string accessiblename = "Plan ID"
string accessibledescription = "Plan ID"
accessiblerole accessiblerole = statictextrole!
integer x = 805
integer y = 56
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Plan ID:"
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_desc from multilineedit within w_plan_elig_list
string accessiblename = "Plan Description"
string accessibledescription = "Plan Description"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 114
integer y = 236
integer width = 2505
integer height = 264
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
integer limit = 250
borderstyle borderstyle = stylelowered!
end type

on getfocus;mle_desc.selecttext(1, len(mle_desc.text))

end on

type sle_ein from singlelineedit within w_plan_elig_list
string accessiblename = "EMPLOYEE IDENTIFICATION NUMBER"
string accessibledescription = "EMPLOYEE IDENTIFICATION NUMBER"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 1490
integer y = 128
integer width = 402
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

on getfocus;sle_ein.selecttext(1, len(sle_ein.text))
end on

type sle_id from singlelineedit within w_plan_elig_list
string accessiblename = "Plan ID"
string accessibledescription = "Plan ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 805
integer y = 128
integer width = 585
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

on getfocus;//SetMicroHelp(w_main,"Press the Right Mouse Button to see a list of Procedure Codes")
sle_id.selecttext(1, len(sle_id.text))

end on

type gb_1 from groupbox within w_plan_elig_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 73
integer y = 8
integer width = 2583
integer height = 520
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By:"
borderstyle borderstyle = stylelowered!
end type

