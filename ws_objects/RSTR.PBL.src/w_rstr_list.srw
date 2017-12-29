$PBExportHeader$w_rstr_list.srw
$PBExportComments$list restore control (Inherited from w_master)
forward
global type w_rstr_list from w_master
end type
type sle_req_date from singlelineedit within w_rstr_list
end type
type st_5 from statictext within w_rstr_list
end type
type sle_restore_id from singlelineedit within w_rstr_list
end type
type st_2 from statictext within w_rstr_list
end type
type ddlb_request_type from dropdownlistbox within w_rstr_list
end type
type st_1 from statictext within w_rstr_list
end type
type rb_medc from radiobutton within w_rstr_list
end type
type rb_medb from radiobutton within w_rstr_list
end type
type st_row_count from statictext within w_rstr_list
end type
type ddlb_status from dropdownlistbox within w_rstr_list
end type
type st_4 from statictext within w_rstr_list
end type
type cb_new from u_cb within w_rstr_list
end type
type cb_close from u_cb within w_rstr_list
end type
type cb_delete from u_cb within w_rstr_list
end type
type cb_select from u_cb within w_rstr_list
end type
type cb_list from u_cb within w_rstr_list
end type
type dw_1 from u_dw within w_rstr_list
end type
type sle_user_id from singlelineedit within w_rstr_list
end type
type st_3 from statictext within w_rstr_list
end type
type gb_2 from groupbox within w_rstr_list
end type
type gb_1 from groupbox within w_rstr_list
end type
type st_6 from statictext within w_rstr_list
end type
type sle_range from editmask within w_rstr_list
end type
end forward

global type w_rstr_list from w_master
string accessiblename = "History Retrieval Request List"
string accessibledescription = "History Retrieval Request List"
accessiblerole accessiblerole = windowrole!
integer x = 32
integer y = 0
integer width = 2779
integer height = 1680
string title = "History Retrieval Request List"
long backcolor = 67108864
event type integer ue_edit_case_closed ( string as_case_id,  string as_case_spl,  string as_case_ver )
sle_req_date sle_req_date
st_5 st_5
sle_restore_id sle_restore_id
st_2 st_2
ddlb_request_type ddlb_request_type
st_1 st_1
rb_medc rb_medc
rb_medb rb_medb
st_row_count st_row_count
ddlb_status ddlb_status
st_4 st_4
cb_new cb_new
cb_close cb_close
cb_delete cb_delete
cb_select cb_select
cb_list cb_list
dw_1 dw_1
sle_user_id sle_user_id
st_3 st_3
gb_2 gb_2
gb_1 gb_1
st_6 st_6
sle_range sle_range
end type
global w_rstr_list w_rstr_list

type variables
string iv_subset_id
sx_subset_options istr_subset_options //VAV 4.0 2/10/98

// Stars 4.8 - Case NVO
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//n_cst_case	inv_case

end variables

forward prototypes
public function integer wf_delete_criteria ()
end prototypes

event type integer ue_edit_case_closed(string as_case_id, string as_case_spl, string as_case_ver);/////////////////////////////////////////////////////////////////////////
//	Script			ue_edit_case_closed
//
//	Arguments		1. as_case_id
//						2. as_case_spl
//						3. as_case_ver
//
//	Returns			1
//
//	Description		Don't allow the deletion of requests if the case is
//						closed or deleted
//
/////////////////////////////////////////////////////////////////////////
//
//	FDG	09/21/01	Stars 4.8.	Created.
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//
/////////////////////////////////////////////////////////////////////////


Boolean	lb_valid_case

n_cst_case		lnv_case					// FDG 12/21/01
lnv_case	=	CREATE	n_cst_case		// FDG 12/21/01

lb_valid_case	=	lnv_case.uf_edit_case_closed (as_case_id, as_case_spl, as_case_ver)

Destroy	lnv_case							// FDG 12/21/01

IF	lb_valid_case	=	FALSE		THEN
	cb_delete.enabled	=	FALSE
ELSE
	cb_delete.enabled	=	TRUE
END IF

Return	1

end event

public function integer wf_delete_criteria ();//*****************************************************************
// 03-26-96 FNC STARS31 prob #223 
//               Delete criteria from criteria table.
//*****************************************************************

delete from criteria_used 
where by_id = Upper( :iv_subset_id )
using stars2ca;

if stars2ca.of_check_status() < 0 then
   errorbox(stars2ca,'Error deleting criteria from the criteria table')
   return -1
end if

delete from criteria_used_line
where by_id = Upper( :iv_subset_id )
using stars2ca;

if stars2ca.of_check_status() < 0 then
   errorbox(stars2ca,'Error deleting criteria from the criteria_used_line table')
   return -1
end if

delete from criteria_from_tbls_used
where by_id = Upper( :iv_subset_id )
using stars2ca;

if stars2ca.of_check_status() < 0 then
   errorbox(stars2ca,'Error deleting criteria from the criteria table')
   return -1
end if

return 0


end function

event open;call super::open;/*********************************************************/
// W_rstr_list Open
/*********************************************************/
//06-08-98 AJS correct date range Track #1444
//	09/21/01	FDG	Stars 4.8.1.	No deletes can occur if the case is closed
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
/*********************************************************/
string lv_bus_dflt
//Note that the delete and new buttons are invisible and disabled//

setpointer(hourglass!)
dw_1.taborder =0

//fx_set_window_colors(w_rstr_list)
/*Checks to see if comming from the menu*/
if gv_from = 'L' then
   CB_Select.enabled = false
	CB_Delete.enabled = false
end if

//inv_case = CREATE n_cst_case		// FDG 09/21/01		// FDG 12/21/01

if sle_user_id.text = "" then
	sle_user_id.text = gc_user_id
end if

This.of_set_sys_cntl_range (TRUE)

sle_range.text  = String ( inv_sys_cntl.of_get_cntl_no() )
sle_req_date.text  =   inv_sys_cntl.of_get_default_date() 
SetMicroHelp(W_rstr_List,'Ready')


end event

on w_rstr_list.create
int iCurrent
call super::create
this.sle_req_date=create sle_req_date
this.st_5=create st_5
this.sle_restore_id=create sle_restore_id
this.st_2=create st_2
this.ddlb_request_type=create ddlb_request_type
this.st_1=create st_1
this.rb_medc=create rb_medc
this.rb_medb=create rb_medb
this.st_row_count=create st_row_count
this.ddlb_status=create ddlb_status
this.st_4=create st_4
this.cb_new=create cb_new
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_select=create cb_select
this.cb_list=create cb_list
this.dw_1=create dw_1
this.sle_user_id=create sle_user_id
this.st_3=create st_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_6=create st_6
this.sle_range=create sle_range
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_req_date
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.sle_restore_id
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.ddlb_request_type
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_medc
this.Control[iCurrent+8]=this.rb_medb
this.Control[iCurrent+9]=this.st_row_count
this.Control[iCurrent+10]=this.ddlb_status
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_new
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.cb_delete
this.Control[iCurrent+15]=this.cb_select
this.Control[iCurrent+16]=this.cb_list
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.sle_user_id
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.sle_range
end on

on w_rstr_list.destroy
call super::destroy
destroy(this.sle_req_date)
destroy(this.st_5)
destroy(this.sle_restore_id)
destroy(this.st_2)
destroy(this.ddlb_request_type)
destroy(this.st_1)
destroy(this.rb_medc)
destroy(this.rb_medb)
destroy(this.st_row_count)
destroy(this.ddlb_status)
destroy(this.st_4)
destroy(this.cb_new)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_select)
destroy(this.cb_list)
destroy(this.dw_1)
destroy(this.sle_user_id)
destroy(this.st_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_6)
destroy(this.sle_range)
end on

event close;call super::close;// FDG 09/21/01	Stars 4.8.	Destroy inv_case
//	12/21/01	FDG	Track 2497.  Make n_cst_case local to prevent memory leaks.
//if IsValid(inv_case) then DESTROY inv_case			// FDG 12/21/01

end event

type sle_req_date from singlelineedit within w_rstr_list
string accessiblename = "Request Date"
string accessibledescription = "Request Date"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 1838
integer y = 92
integer width = 530
integer height = 88
integer taborder = 70
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_rstr_list
string accessiblename = "Request Date"
string accessibledescription = "Request Date"
accessiblerole accessiblerole = statictextrole!
integer x = 1367
integer y = 92
integer width = 453
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Request Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_restore_id from singlelineedit within w_rstr_list
string accessiblename = "Restore ID"
string accessibledescription = "Restore ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 526
integer y = 92
integer width = 622
integer height = 96
integer taborder = 40
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_rstr_list
string accessiblename = "Restore ID"
string accessibledescription = "Restore ID"
accessiblerole accessiblerole = statictextrole!
integer x = 151
integer y = 92
integer width = 347
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Restore ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_request_type from dropdownlistbox within w_rstr_list
string accessiblename = "Request Type Search Options"
string accessibledescription = "All"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 526
integer y = 320
integer width = 978
integer height = 268
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long backcolor = 1073741824
string text = "A - All"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"A - All","S - Stars Archive Retrieval","M - Legacy History Retrieval"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rstr_list
string accessiblename = "Request Type"
string accessibledescription = "Request Type"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 320
integer width = 443
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Request Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_medc from radiobutton within w_rstr_list
boolean visible = false
string accessiblename = "Multi Claim"
string accessibledescription = "Multi Claim"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1175
integer y = 232
integer width = 457
integer height = 80
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Multi Claim"
borderstyle borderstyle = stylelowered!
end type

event clicked;//dw_1.dwmodify("title.text = 'RESTORE LIST - PART C'")
setpointer(Hourglass!)
dw_1.dataobject = 'd_rstr_list_ptc'
dw_1.of_SetTrim (TRUE)								// FDG 04/16/01
Parent.Event	ue_set_window_colors(Parent.Control)
cb_select.ENABLED = FALSE
cb_delete.ENABLED = FALSE
cb_new.default=false
cb_list.default=true
st_row_count.text = ''
end event

type rb_medb from radiobutton within w_rstr_list
boolean visible = false
string accessiblename = "Professional"
string accessibledescription = "Professional"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1175
integer y = 156
integer width = 494
integer height = 84
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Professional"
borderstyle borderstyle = stylelowered!
end type

event clicked;//dw_1.dwmodify("title.text = 'RESTORE LIST - PART B'")
setpointer(Hourglass!)
dw_1.dataobject = 'd_rstr_list'
dw_1.of_SetTrim (FALSE)								// FDG 04/16/01
Parent.Event	ue_set_window_colors(Parent.Control)
cb_select.ENABLED = FALSE
cb_DELETE.ENABLED = FALSE
cb_new.default=false
cb_list.default=true
st_row_count.text = ''
end event

type st_row_count from statictext within w_rstr_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 37
integer y = 1460
integer width = 261
integer height = 80
integer textsize = -16
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

type ddlb_status from dropdownlistbox within w_rstr_list
string accessiblename = "Request Status Search Options"
string accessibledescription = "All"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 1838
integer y = 320
integer width = 832
integer height = 328
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long backcolor = 1073741824
string text = "A - All"
boolean vscrollbar = true
string item[] = {"A - All","C - Completed","E - Error","P - Pending","S - Started"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_rstr_list
string accessiblename = "Status"
string accessibledescription = "Status"
accessiblerole accessiblerole = statictextrole!
integer x = 1559
integer y = 320
integer width = 261
integer height = 72
integer textsize = -10
integer weight = 700
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

type cb_new from u_cb within w_rstr_list
string accessiblename = "Add"
string accessibledescription = "Add..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1399
integer y = 1444
integer width = 338
integer height = 108
integer taborder = 110
integer textsize = -16
string text = "&Add..."
end type

event clicked;setpointer(hourglass!)
SetMicroHelp(W_Main,'Opening Add Request screen...')
gv_from = 'A'
gv_rstr_id = ''
	OpenSheet(w_rstr_maint_ptc,MDI_main_frame,help_menu_position,layered!)

end event

type cb_close from u_cb within w_rstr_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2304
integer y = 1444
integer width = 338
integer height = 108
integer taborder = 130
integer textsize = -16
string text = "&Close"
end type

on clicked;close(parent)
end on

type cb_delete from u_cb within w_rstr_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1856
integer y = 1444
integer width = 338
integer height = 108
integer taborder = 120
integer textsize = -16
string text = "&Delete"
end type

event clicked;//*****************************************************************
// 03-26-96 FNC STARS31 prob #223 
//               Delete criteria from criteria table.
//*****************************************************************
/*Clicked event for the Delete Button*/

/*Declaration Section*/
int lv_message_nbr

dw_1.triggerevent(rowfocuschanged!)
/*Prints a confirmation box and finds out what button was pressed*/
lv_message_nbr = MessageBox('CONFIRMATION!',"Delete Restore Request #" + gv_rstr_id + " ?",Question!,OKCANCEL!,2)
If lv_message_nbr = 2 Then
	  SetMicroHelp(w_main,'Ready')
     Return
end if

SetMicroHelp(W_Main,'Deleting the Entry from the Restore Request Table')

/*Deletes the row from the table*/

SetPointer(Hourglass!)

	DELETE from restore_request_part_c
        Where rstr_id = Upper( :gv_rstr_id )
	     Using stars2ca;
//END IF

/*Checks to see there was a error in reading the database or*/
/*if there was no match in the database*/
If stars2ca.of_check_status() = 100 Then
	SetMicroHelp(w_main,'Ready')
 	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	messagebox('Not Found','Selection not found, Cannot be Deleted',StopSign!)
	RETURN
elseIF stars2ca.sqlcode < 0 Then
	SetMicroHelp(w_main,'Ready')
   errorbox(stars2ca,'Error deleting from the restore request table')
	RETURN
end if 


/*Deletes the row from the data window*/
DELETE from restore_cntl
     Where rstr_id = Upper( :gv_rstr_id )
	  Using stars2ca;

/*Checks to see there was a error in reading the database or*/
/*if there was no match in the database*/
If stars2ca.of_check_status() = 100 Then
	SetMicroHelp(w_main,'Ready')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	messagebox('Not Found','Selection not found, Cannot be Deleted',StopSign!)
	RETURN
elseIF stars2ca.sqlcode < 0 Then
	SetMicroHelp(w_main,'Ready')
   errorbox(stars2ca,'Error deleting from the restore request table')
	RETURN
end if 

//DeleteRow(dw_1,0)

if wf_delete_criteria() < 0  then    //03-26-96 FNC start
   messagebox('WARNING','Errors found in deleting criteria ~rRequest not deleted')
	SetMicroHelp(w_main,'Ready')
   return
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
Setfocus(dw_1)
/*Decreases the row count by one*/ 
triggerevent(cb_list,clicked!)

//sle_row_count.text = string(integer(sle_row_count.text) -1)
SetMicroHelp(w_main,'Ready')
end event

type cb_select from u_cb within w_rstr_list
string accessiblename = "Select"
string accessibledescription = "Select..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 946
integer y = 1444
integer width = 338
integer height = 108
integer taborder = 100
integer textsize = -16
string text = "&Select..."
end type

event clicked;
SetPointer(hourglass!)

/*Tells other windows that should be a maintain screen*/ 
gv_from = 'L'

SetMicroHelp(W_Main,'Opening the Maintain Screen with the selected info')
	if isvalid(w_rstr_maint_ptc) then close(w_rstr_maint_ptc)
   OpenSheet(w_rstr_maint_ptc,MDI_main_frame,help_menu_position,Layered!)


end event

type cb_list from u_cb within w_rstr_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 494
integer y = 1440
integer width = 347
integer height = 108
integer taborder = 90
integer textsize = -16
string text = "&List"
boolean default = true
end type

event clicked;//****************************************************************
//1/12/99  FDG	Track 2047c.  Y2K changes to allow a 4-digit 
//					date & range.
//07-08-98 AJS Track #1444; fix date/range box
//06-26-96 FNC STARS31 Prob #285 Add request date to the search by
//             criteria
//02-21-96 FNC Take off paid date and row count from datawindow so that
//             only 1 row for each request is listed. Add type and
//             restore id as search by parameters.
//08-30-95 FNC Change % to an A in status ddlb
//****************************************************************

Long lv_nbr_rows
int li_rc
string by_status,lv_request_type, lv_restore_id, ls_date
Date ld_req_date
Date ld_start_date = date('01/01/1900'),ld_end_date = date('12/31/1999')
 
Time lt_start_time= time('00:00:00'),lt_end_time= time('23:59:29')
datetime ld_beg_req_date,ld_end_req_date


setpointer(hourglass!) 
SetMicroHelp(W_Main,'Listing All Restore Request Entries Based On The Criteria')	

by_status = left(ddlb_status.text,1)

if by_status = 'A' then    //08-31-95 FNC Start
   by_status = '%'
end if                     //08-31-95 FNC ENd

lv_request_type = left(ddlb_request_type.text,1)
if lv_request_type = 'A' then
   lv_request_type = '%'
end if

lv_restore_id = sle_restore_id.text
if lv_restore_id = '' then
   lv_restore_id = '%'
end if

n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate (sle_req_date.text)

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		sle_req_date.SetFocus()
		Return
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		sle_req_date.SetFocus()
		Return
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		sle_req_date.SetFocus()
		Return	-1
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.
ld_beg_req_date	=	lnv_datetime.of_GetFromDateTime (sle_req_date.text, sle_range.text)
ld_end_date			=	Date (sle_req_date.text)
ld_end_req_date	=	DateTime (ld_end_date, 23:59:59)



// FDG 1/12/99 end

Reset(DW_1)

/*Connects to datawindow and retrieves number of rows*/

SetTransObject(DW_1,stars2ca)

lv_nbr_rows = Retrieve(dw_1,sle_user_id.text +'%',by_status, &
	lv_request_type,lv_restore_id + '%',ld_beg_req_date,	&
	ld_end_req_date)

st_row_count.text = string(lv_nbr_rows)
cb_list.default=false

/*Checks to see if there is no data in the table*/
If lv_nbr_rows = 0 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	SetMicroHelp(w_main,'Ready')
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
	CB_Select.enabled = false
	CB_Delete.enabled = false
	cb_new.default=true
	dw_1.taborder = 0
	return
end if 

/*Checks to see if there is just one row in table*/
if lv_nbr_rows = 1 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   return
end if   

cb_select.default=true
dw_1.taborder = 50
SetMicroHelp(w_main,'Ready')
Setfocus(dw_1)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

end event

type dw_1 from u_dw within w_rstr_list
string accessiblename = "Restore List Data"
string accessibledescription = "Restore List Data"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Request List"
integer x = 27
integer y = 452
integer width = 2629
integer height = 968
integer taborder = 10
string dataobject = "d_rstr_list_ptc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;//*****************************************************************
// 03-26-96 FNC STARS31 prob #223 
//               Delete criteria from criteria table.
// FDG 09/21/01	Stars 4.8.1. Enable/disable cb_delete based on 
//						if the case is closed/deleted
//*****************************************************************

/*Clicked for data window 1*/
string test
int row_nbr,clicked_row
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
/*Sets select and delete to enabled when clicked*/
cb_select.enabled = true
cb_select.default = true

/*gets the row and makes sure a row was clicked*/
row_nbr = getrow(dw_1)
If row_nbr = 0 then
   cb_select.enabled = false
	cb_delete.enabled = false
//This is uncommented when the delete button is made visible

	return
end if
if dw_1.getitemstring(row_nbr,'user_id')<>gc_user_id then
	cb_delete.enabled=false
else
	cb_delete.enabled=true
end if

/*Highlights the selected row*/
SelectRow(dw_1,0,FALSE)
SelectRow(dw_1,row_nbr,TRUE)
/*Loads the selected rows keys into the global variables*/

// FDG 09/21/01 - Enable/disable cb_delete based on if the case is closed/deleted
String	ls_case_id,		&
			ls_case_spl,	&
			ls_case_ver

ls_case_id	=	This.object.case_id [row_nbr]
ls_case_spl	=	This.object.case_spl [row_nbr]
ls_case_ver	=	This.object.case_ver [row_nbr]
			
Parent.Event	ue_edit_case_closed (ls_case_id, ls_case_spl, ls_case_ver)
// FDG 09/21/01 end

gv_rstr_id = GetItemString(dw_1,row_nbr,1)
iv_subset_id = GetItemString(dw_1,row_nbr,"case_link_link_name")  //03-23-96 FNC //VAV 4.0 2/10/98
setpointer(arrow!)

end event

event doubleclicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
//cb_list.default = true

int row_nbr

/*gets the row and makes sure a row was clicked*/
row_nbr = row
If row_nbr = 0 then
	return
end if
triggerevent(cb_select,Clicked!)
end event

on losefocus;cb_list.default = true
end on

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

type sle_user_id from singlelineedit within w_rstr_list
string accessiblename = "User ID"
string accessibledescription = "User ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 526
integer y = 208
integer width = 622
integer height = 96
integer taborder = 50
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_rstr_list
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = statictextrole!
integer x = 242
integer y = 208
integer width = 256
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "User ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_rstr_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer y = 16
integer width = 2679
integer height = 408
integer taborder = 20
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By:"
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rstr_list
boolean visible = false
string accessiblename = "Business"
string accessibledescription = "Business"
accessiblerole accessiblerole = groupingrole!
integer x = 1915
integer y = 24
integer width = 654
integer height = 320
integer taborder = 30
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Business:"
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_rstr_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = statictextrole!
integer x = 1573
integer y = 208
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -16
integer weight = 700
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

type sle_range from editmask within w_rstr_list
string accessiblename = "Range"
string accessibledescription = "Range"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 1838
integer y = 200
integer width = 530
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####"
end type

