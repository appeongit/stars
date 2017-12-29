HA$PBExportHeader$w_enrollee_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_enrollee_list from w_master
end type
type st_dw_ops from statictext within w_enrollee_list
end type
type ddlb_dw_ops from dropdownlistbox within w_enrollee_list
end type
type st_1 from statictext within w_enrollee_list
end type
type sle_rid from singlelineedit within w_enrollee_list
end type
type st_row_count from statictext within w_enrollee_list
end type
type cb_add from u_cb within w_enrollee_list
end type
type cb_select from u_cb within w_enrollee_list
end type
type cb_list from u_cb within w_enrollee_list
end type
type dw_1 from u_dw within w_enrollee_list
end type
type sle_city from singlelineedit within w_enrollee_list
end type
type st_city from statictext within w_enrollee_list
end type
type sle_zip_code from singlelineedit within w_enrollee_list
end type
type sle_name from singlelineedit within w_enrollee_list
end type
type sle_gender from singlelineedit within w_enrollee_list
end type
type sle_id from singlelineedit within w_enrollee_list
end type
type st_zip from statictext within w_enrollee_list
end type
type st_name from statictext within w_enrollee_list
end type
type st_gender from statictext within w_enrollee_list
end type
type st_id from statictext within w_enrollee_list
end type
type cb_exit from u_cb within w_enrollee_list
end type
type gb_1 from groupbox within w_enrollee_list
end type
end forward

global type w_enrollee_list from w_master
string accessiblename = "Patient List"
string accessibledescription = "Patient List"
integer x = 82
integer y = 116
integer width = 2757
integer height = 1688
string title = "Patient List"
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
st_1 st_1
sle_rid sle_rid
st_row_count st_row_count
cb_add cb_add
cb_select cb_select
cb_list cb_list
dw_1 dw_1
sle_city sle_city
st_city st_city
sle_zip_code sle_zip_code
sle_name sle_name
sle_gender sle_gender
sle_id sle_id
st_zip st_zip
st_name st_name
st_gender st_gender
st_id st_id
cb_exit cb_exit
gb_1 gb_1
end type
global w_enrollee_list w_enrollee_list

type variables
string iv_recip_rid
long in_dw_limit,in_cnt
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct
n_cst_string in_cst_string
end variables

event open;call super::open;int lv_rc,lv_index
string lv_window_name

// Set the retrieve limit from the global
in_dw_limit = gc_dw_limit
in_cnt = 0

//	FDG 07/31/97 - Disable closequery processing
ib_disableclosequery	=	TRUE

//fx_set_window_colors(w_enrollee_list)
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')
/*Checks to see if comming from the menu*/
if gv_from = 'L' then
   cb_Select.enabled = false
//   cb_stop.enabled = false
end if
if gv_from = "lookup" then
	cb_add.visible = FALSE
   cb_Select.enabled = false
//   cb_stop.enabled = false
end if
if gv_from = "TRACK-MAINT" then   /* used to list for specific UPIN */
	cb_list.hide()
	cb_add.hide()
	sle_id.enabled = FALSE
	sle_gender.enabled=false
	sle_name.enabled = FALSE
	sle_zip_code.enabled = FALSE
	sle_rid.enabled=false
	sle_city.enabled=false
	cb_list.PostEvent(Clicked!)
end if

lv_window_name = UPPER(this.classname())

lv_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars2ca) 
If lv_rc = -5 Then
	lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(lv_index)
End If
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

SetMicroHelp(W_enrollee_List,'Ready')
end event

on w_enrollee_list.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_1=create st_1
this.sle_rid=create sle_rid
this.st_row_count=create st_row_count
this.cb_add=create cb_add
this.cb_select=create cb_select
this.cb_list=create cb_list
this.dw_1=create dw_1
this.sle_city=create sle_city
this.st_city=create st_city
this.sle_zip_code=create sle_zip_code
this.sle_name=create sle_name
this.sle_gender=create sle_gender
this.sle_id=create sle_id
this.st_zip=create st_zip
this.st_name=create st_name
this.st_gender=create st_gender
this.st_id=create st_id
this.cb_exit=create cb_exit
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
this.Control[iCurrent+2]=this.ddlb_dw_ops
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_rid
this.Control[iCurrent+5]=this.st_row_count
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_select
this.Control[iCurrent+8]=this.cb_list
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.sle_city
this.Control[iCurrent+11]=this.st_city
this.Control[iCurrent+12]=this.sle_zip_code
this.Control[iCurrent+13]=this.sle_name
this.Control[iCurrent+14]=this.sle_gender
this.Control[iCurrent+15]=this.sle_id
this.Control[iCurrent+16]=this.st_zip
this.Control[iCurrent+17]=this.st_name
this.Control[iCurrent+18]=this.st_gender
this.Control[iCurrent+19]=this.st_id
this.Control[iCurrent+20]=this.cb_exit
this.Control[iCurrent+21]=this.gb_1
end on

on w_enrollee_list.destroy
call super::destroy
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.st_1)
destroy(this.sle_rid)
destroy(this.st_row_count)
destroy(this.cb_add)
destroy(this.cb_select)
destroy(this.cb_list)
destroy(this.dw_1)
destroy(this.sle_city)
destroy(this.st_city)
destroy(this.sle_zip_code)
destroy(this.sle_name)
destroy(this.sle_gender)
destroy(this.sle_id)
destroy(this.st_zip)
destroy(this.st_name)
destroy(this.st_gender)
destroy(this.st_id)
destroy(this.cb_exit)
destroy(this.gb_1)
end on

type st_dw_ops from statictext within w_enrollee_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1240
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

type ddlb_dw_ops from dropdownlistbox within w_enrollee_list
string accessiblename = "Window Operations"
string accessibledescription = "-1"
accessiblerole accessiblerole = comboboxrole!
integer x = 64
integer y = 1316
integer width = 704
integer height = 260
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

event selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.
string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end event

type st_1 from statictext within w_enrollee_list
string accessiblename = "Patient ID"
string accessibledescription = "Patient ID"
accessiblerole accessiblerole = statictextrole!
integer x = 320
integer y = 240
integer width = 361
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Patient ID:"
end type

type sle_rid from singlelineedit within w_enrollee_list
string accessiblename = "Patient Alternate ID"
string accessibledescription = "Patient Alternate ID"
accessiblerole accessiblerole = textrole!
integer x = 320
integer y = 132
integer width = 718
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 25
borderstyle borderstyle = stylelowered!
end type

type st_row_count from statictext within w_enrollee_list
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 64
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

type cb_add from u_cb within w_enrollee_list
string accessiblename = "Add"
string accessibledescription = "Add..."
integer x = 1623
integer y = 1440
integer width = 329
integer height = 108
integer taborder = 110
integer weight = 400
string text = "&Add..."
end type

on clicked;string lv_table_type

SetPointer(hourglass!)
SetMicroHelp('Opening the Add Patient Screen')

/*Tells other screens it should be an Add screen*/
gv_from = 'A'
   

//OpenSheet(w_enrollee_maint,MDI_Main_Frame,Help_Menu_Position,Layered!)
//OpenSheet(w_generic_maint,MDI_Main_Frame,Help_Menu_Position,Layered!)

lv_table_type = 'EI'
OpenSheetWithParm(w_prov_enroll_maint,lv_table_type,mdi_main_frame,help_menu_position,Layered!)
SetMicroHelp(w_main,'Ready')
end on

on getfocus;//SetMicroHelp('Adds a New Enrollee')
end on

type cb_select from u_cb within w_enrollee_list
string accessiblename = "Select"
string accessibledescription = "Select..."
integer x = 1088
integer y = 1440
integer width = 329
integer height = 108
integer taborder = 100
integer weight = 400
string text = "&Select..."
end type

on clicked;string lv_table_type

SetPointer(hourglass!)
SetMicroHelp('Opening the Maintain Screen with the selected info')

/*Tells other windows that should be a maintain screen*/ 
if (gv_from <> "lookup") and (gv_from <> "TRACK-MAINT") then
	gv_from = 'M'
end if
gv_prov_id = iv_recip_rid
//gv_prov_upin = in_prov_upin


/*opens maintance screen*/
//OpenSheet(w_enrollee_maint,MDI_Main_Frame,Help_Menu_Position,Layered!)

lv_table_type = 'EI'
OpenSheetWithParm(w_prov_enroll_maint,lv_table_type,mdi_main_frame,help_menu_position,Layered!)
Setmicrohelp(w_main,'Ready')

end on

on getfocus;//SetMicroHelp("Selects the Highlighted Enrollee")
end on

type cb_list from u_cb within w_enrollee_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 549
integer y = 1440
integer width = 329
integer height = 108
integer taborder = 90
integer weight = 400
string text = "&List"
boolean default = true
end type

event clicked;//******************************************************************
//List enrollees based on selected criteria
//******************************************************************
// FNC 	03/24/99	TS1999C 4.0 Sp2 Create datawindow dynamically so user
//						can control the columns and the order that columns are
//						display.
//
// KTB 	01/12/00	FS/TS2685 Starcare Track #2685. Set the focus to 
//                the first row after the data retrieval.
// KTB 	09/26/00	TS2999C. Place a call to fx_dw_syntax after the
//                datawindow has been created.
//	GaryR	10/29/01	Track 2484d	Limit rows logic.
// MikeF	09/13/05	SPR4510d	Too many parms for datastore
//	HYL 	02/06/06 Track 4639d Prevent entered text from causing SQL failure when it includes apostrophe such as O'connor in sle_name.text.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
// 11/11/09 RickB LKP.650.5678.002 - Pointed row limit code to new functions of_SetRowLimitSQL.
//******************************************************************

setpointer(hourglass!)

string ls_id,ls_name,ls_gender,ls_zip_code,ls_city,ls_rid
string ls_select,ls_from,ls_where,ls_sql,ls_style,ls_syntax,ls_error
string ls_title,ls_blank_string[], ls_tbl_name
int li_rc
long ll_nbr_rows
int lv_rc
string lv_window_name
string s_sing_qt, s_2_sing_qt

IF Trim( sle_id.text ) = "" AND Trim( sle_name.text ) = "" &
AND Trim( sle_gender.text ) = "" AND Trim( sle_zip_code.text ) = "" &
AND Trim( sle_city.text ) = "" AND Trim( sle_rid.text ) = "" THEN
	IF MessageBox( 'WARNING','With no criteria, this query may take a while.' + &
									'~n~rContinue anyway?', Question!, YesNo!, 2 ) = 2 THEN Return
END IF
//	GaryR	10/29/01	Track 2484d - End

setpointer(hourglass!) 
SetMicroHelp('Listing Patient Entries...')	


// Re-set the retrieve limit from the global
in_cnt = 0
in_dw_limit = gc_dw_limit
GV_CANCEL_BUT_CLICKED = FALSE
st_row_count.text = ""


Reset(DW_1)

ls_id = sle_id.text
ls_gender = sle_gender.text
ls_name = sle_name.text
ls_zip_code = sle_zip_code.text
ls_city = sle_city.text
ls_rid = sle_rid.text

If ls_id = '' Then
	ls_id = '%'
End If
If ls_gender = '' Then
	ls_gender = '%'
End If
If ls_name = '' Then
	ls_name = '%'
ELSE // 02/06/06 HYL Track 4639d Prevent entered text from causing SQL failure when it includes apostrophe such as O'connor.
	s_sing_qt = "'"
	s_2_sing_qt = "''"
	ls_name = in_cst_string.of_globalreplace(ls_name, s_sing_qt, s_2_sing_qt)
End If
If ls_zip_code = '' Then
	ls_zip_code = '%'
End If
If ls_city = '' then
	ls_city = '%'
End If
If ls_rid = '' Then
	ls_rid = '%'
End If

//	Build the select clause
ls_tbl_name = gnv_dict.event ue_get_table_name( "EN" )
IF ls_tbl_name = gnv_dict.ics_error OR ls_tbl_name = gnv_dict.ics_not_found THEN Return
ls_select = gnv_dict.event ue_build_dict_sql_select( ls_tbl_name )
IF ls_select = gnv_dict.ics_error THEN Return

ls_from = ' FROM ENROLLEE'

ls_where = " where  enrollee.recip_id like '" + Upper( ls_id ) + "'" + &
" and enrollee.sex like '" + Upper( ls_gender ) + "'" + &
" and enrollee.patient_name like '" + Upper( ls_name ) + "'" + &
" and enrollee.zip like '" + Upper( ls_zip_code ) + "'" + &
" and enrollee.city like '" + Upper( ls_city )  + "'" + &
" and enrollee.recip_rid like '" + Upper( ls_rid ) + "'"

ls_sql = ls_select + ls_from + ls_where

//	GaryR	10/29/01	Track 2484d - Begin
IF gnv_sql.of_SetRowLimitSQL( ls_sql, 2500, Stars2ca ) < 1 THEN
	MessageBox( 'Database Error', 'Could not set the row count in patient code list' )
	Return -1
END IF
//	GaryR	10/29/01	Track 2484d - End

ls_style = " datawindow(units = 1 color = " + &
				string(stars_colors.datawindow_back)+ ") style(type = grid) " + &
				"text(font.face='System')  Column(font.Face='System')"

ls_syntax = stars2ca.syntaxfromsql(ls_sql,ls_style,ls_error)
if ls_syntax = '' then 
	messagebox('Error','Error creating syntax for report. Error = ' +	ls_error)
	gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca )
	return -1
end if

li_rc = dw_1.create(ls_syntax)
if li_rc = -1 then 
	messagebox('ERROR','Error creating datawindow for report')
	gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca )
	return 
end if

// KTB - 9/26/00 - Now that the datawindow has been created, call
// fx_dw_syntax to populate the in_decode_struct
lv_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars2ca)
if lv_rc = -1 then
	return   // fx_dw_syntax displays error message
end if
// End KTB

ls_title = 'ENROLLEE LIST'

fx_add_d_head(ls_title, dw_1,ls_blank_string[], '50', '65' , '125', '2', '350')
n_cst_labels lnvo_labels
lnvo_labels = create n_cst_labels

lnvo_labels.of_setdw(dw_1)
lnvo_labels.of_labels2('EN','95','40','50')

destroy(lnvo_labels)

SetTransObject(DW_1,stars2ca)

ll_nbr_rows = Retrieve(dw_1)
//lv_nbr_rows = Retrieve(dw_1,ls_id,ls_gender,ls_name,ls_zip_code,ls_city,ls_rid)
// FNC 03/24/99 End

//	GaryR	10/29/01	Track 2484d - Begin
IF gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca ) < 1 THEN
	MessageBox( 'Database Error', 'Could not set the row count in patient code list' )	
END IF

IF ll_nbr_rows >= 2500 THEN	MessageBox( "Warning", "The maximum number of rows limit was reached" + &
																	"~n~rMore rows match your query than are displayed", Exclamation! )
//	GaryR	10/29/01	Track 2484d - End

st_row_count.text = string(ll_nbr_rows)

/*Checks to see if there is no data in the table*/
If ll_nbr_rows = 0 Then
	SetMicroHelp('No data found...')
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
   setfocus(sle_rid)
	cb_select.enabled = false
	cb_list.default = true
	w_main.setmicrohelp('Ready')
	return
end if 


Setfocus(dw_1)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
SetMicroHelp('Ready')
dw_1.setsort("#1 A,#2 A")
dw_1.sort()

// KTB 1-12-00 Set the focus to the first row.
dw_1.SetRow(1)
dw_1.SelectRow(0,FALSE)
dw_1.SelectRow(1,TRUE)
TriggerEvent(dw_1,RowFocusChanged!)
// End KTB 1-12-00
end event

on getfocus;//setmicrohelp(w_main,'Lists all enrollees')

end on

type dw_1 from u_dw within w_enrollee_list
string tag = "CRYSTAL, title = Enrollee List"
string accessiblename = "Enrollee List"
string accessibledescription = "-1"
integer x = 55
integer y = 468
integer width = 2560
integer height = 760
integer taborder = 70
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;//Script for W_lead_list doubleclicked for dw_1
//////////////////////////////////////////////////////////////////////
int tabpos,rc,row_nbr,lv_indx,lv_found
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
	Else
		ddlb_dw_ops.triggerevent(selectionchanged!)
	End if      
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		row_nbr = row
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		row_nbr = row
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',row_nbr,in_decode_struct)
Else
	setmicrohelp(w_main,'Ready')
	row_nbr = row
	If row_nbr = 0 then
		return
	end if
	triggerevent(cb_select,Clicked!)
End If


end event

event rowfocuschanged;string test
int row_nbr,clicked_row

/*Sets select to enabled when clicked*/
cb_select.enabled = true
cb_select.default = true

/*gets the row and makes sure a row was clicked*/
row_nbr = getrow(dw_1)
// FDG 01/17/02 - Track 2699d.  If no rows exist, get out
If row_nbr = 0 				&
or	This.RowCount()	<	1	then
   cb_select.enabled = false
	return
end if

/*Loads the selected rows keys into the instance variables*/
iv_recip_rid = GetItemString(dw_1,row_nbr,'recip_rid')
//in_prov_upin = GetItemString(dw_1,row_nbr,2)

/*Highlights the selected row*/
SelectRow(dw_1,0,FALSE)
SelectRow(dw_1,row_nbr,TRUE)

end event

on rbuttondown;Setpointer(Hourglass!)
	
fx_lookup(dw_1,'EN')
end on

on losefocus;cb_list.default = true
end on

type sle_city from singlelineedit within w_enrollee_list
string accessiblename = "City"
string accessibledescription = "City"
accessiblerole accessiblerole = textrole!
integer x = 1573
integer y = 304
integer width = 617
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 32
borderstyle borderstyle = stylelowered!
end type

on getfocus;sle_city.selecttext(1, len(sle_city.text))
end on

type st_city from statictext within w_enrollee_list
string accessiblename = "City"
string accessibledescription = "City"
accessiblerole accessiblerole = statictextrole!
integer x = 1573
integer y = 240
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
string text = "City:"
end type

type sle_zip_code from singlelineedit within w_enrollee_list
string accessiblename = "Zip Code"
string accessibledescription = "Zip Code"
accessiblerole accessiblerole = textrole!
integer x = 1111
integer y = 304
integer width = 384
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 9
borderstyle borderstyle = stylelowered!
end type

on getfocus;sle_zip_code.selecttext(1, len(sle_zip_code.text))
end on

type sle_name from singlelineedit within w_enrollee_list
string accessiblename = "Name"
string accessibledescription = "Name"
accessiblerole accessiblerole = textrole!
integer x = 1573
integer y = 132
integer width = 914
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 32
borderstyle borderstyle = stylelowered!
end type

on getfocus;sle_name.selecttext(1, len(sle_name.text))
end on

type sle_gender from singlelineedit within w_enrollee_list
string accessiblename = "Sex"
string accessibledescription = "Gender"
accessiblerole accessiblerole = textrole!
integer x = 1111
integer y = 132
integer width = 233
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 1
borderstyle borderstyle = stylelowered!
end type

on getfocus;sle_gender.selecttext(1, len(sle_gender.text))
end on

type sle_id from singlelineedit within w_enrollee_list
string accessiblename = "Patient ID"
string accessibledescription = "-1"
accessiblerole accessiblerole = textrole!
integer x = 320
integer y = 304
integer width = 718
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 25
borderstyle borderstyle = stylelowered!
end type

on getfocus;//SetMicroHelp(w_main,"Press the Right Mouse Button to see a list of Procedure Codes")
sle_id.selecttext(1, len(sle_id.text))

end on

on rbuttondown;//                 ***RBUTTONCLICKED FOR SLE_SEL_RECIP***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 09/01/93  MH  Created 
// 10/03/93 SWD  Added line that calls the function split, to retrieve the
//					  proper lookup type for this sle.
//***********************************************************************

//***********************************************************************
//This script gets the lookup type and then passed that to w_code_lookup.
//When the application returns from the window it displays the code picked
//in the sle as long as it is not spaces
//***********************************************************************


end on

type st_zip from statictext within w_enrollee_list
string accessiblename = "Zip Code"
string accessibledescription = "Zip"
accessiblerole accessiblerole = statictextrole!
integer x = 1111
integer y = 240
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
string text = "Zip:"
end type

type st_name from statictext within w_enrollee_list
string accessiblename = "Name"
string accessibledescription = "Name"
accessiblerole accessiblerole = statictextrole!
integer x = 1573
integer y = 68
integer width = 233
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Name:"
end type

type st_gender from statictext within w_enrollee_list
string accessiblename = "Sex"
string accessibledescription = "Sex"
accessiblerole accessiblerole = statictextrole!
integer x = 1111
integer y = 68
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
string text = "Sex:"
end type

type st_id from statictext within w_enrollee_list
string accessiblename = "Patient Alternate ID"
string accessibledescription = "Patient RID"
accessiblerole accessiblerole = statictextrole!
integer x = 320
integer y = 68
integer width = 361
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Patient RID:"
end type

type cb_exit from u_cb within w_enrollee_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2167
integer y = 1440
integer width = 329
integer height = 108
integer taborder = 120
integer weight = 400
string text = "&Close"
end type

on clicked;setmicrohelp(w_main,'Ready')
close(parent)
end on

on getfocus;//setmicrohelp(w_main,'Exits Enrollee listing')

end on

type gb_1 from groupbox within w_enrollee_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 55
integer y = 12
integer width = 2560
integer height = 420
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

