HA$PBExportHeader$w_code_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_code_list from w_master
end type
type sle_type from u_sle within w_code_list
end type
type st_row_count from statictext within w_code_list
end type
type sle_type_desc from singlelineedit within w_code_list
end type
type st_1 from statictext within w_code_list
end type
type sle_text from singlelineedit within w_code_list
end type
type cb_stop from u_cb within w_code_list
end type
type cb_new from u_cb within w_code_list
end type
type st_code from statictext within w_code_list
end type
type sle_id from singlelineedit within w_code_list
end type
type dw_1 from u_dw within w_code_list
end type
type st_code_type from statictext within w_code_list
end type
type cb_list from u_cb within w_code_list
end type
type cb_select from u_cb within w_code_list
end type
type cb_delete from u_cb within w_code_list
end type
type cb_exit from u_cb within w_code_list
end type
type gb_1 from groupbox within w_code_list
end type
end forward

global type w_code_list from w_master
string accessiblename = "Code List"
string accessibledescription = "Code List"
integer x = 73
integer y = 0
integer width = 2784
integer height = 1660
string title = "Code List"
sle_type sle_type
st_row_count st_row_count
sle_type_desc sle_type_desc
st_1 st_1
sle_text sle_text
cb_stop cb_stop
cb_new cb_new
st_code st_code
sle_id sle_id
dw_1 dw_1
st_code_type st_code_type
cb_list cb_list
cb_select cb_select
cb_delete cb_delete
cb_exit cb_exit
gb_1 gb_1
end type
global w_code_list w_code_list

type variables
int in_nbr_rows
string in_code_type,in_code_code
boolean in_sf

int		ii_value_n // MikeFl 7/29/02 Track 2962

end variables

event open;call super::open;//*********************************************************************************
// Script Name:	cb_list.clicked()
//
// Arguments: n/a
//
// Returns:		long
//
// Description:	Refresh the list when cb_list clicked.
//
//***********************************************************************
//
// 10/19/93 SWD  Created
//	05/27/09	Katie	GNL.600.5633	Remove programmtic set of the dw_1 taborder.
//  07/30/09 RickB RTO.650.5712  Added TRIM to gv_cod_dflt.  QC Defect #134.
//***********************************************************************
CB_Select.enabled = false
CB_Delete.enabled = false

cb_stop.enabled = false
//********************************************************************
//This disables the proper buttons if the user is coming from the menu
//********************************************************************

IF gv_from = "L" Then
/*Checks to see if coming from the menu*/
	sle_type.text = trim(gv_cod_dflt)
	SetMicroHelp(W_main,"Ready")
else 
	sle_type.text = gv_code_type
	cb_list.triggerevent(clicked!)
end if
end event

on w_code_list.create
int iCurrent
call super::create
this.sle_type=create sle_type
this.st_row_count=create st_row_count
this.sle_type_desc=create sle_type_desc
this.st_1=create st_1
this.sle_text=create sle_text
this.cb_stop=create cb_stop
this.cb_new=create cb_new
this.st_code=create st_code
this.sle_id=create sle_id
this.dw_1=create dw_1
this.st_code_type=create st_code_type
this.cb_list=create cb_list
this.cb_select=create cb_select
this.cb_delete=create cb_delete
this.cb_exit=create cb_exit
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_type
this.Control[iCurrent+2]=this.st_row_count
this.Control[iCurrent+3]=this.sle_type_desc
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_text
this.Control[iCurrent+6]=this.cb_stop
this.Control[iCurrent+7]=this.cb_new
this.Control[iCurrent+8]=this.st_code
this.Control[iCurrent+9]=this.sle_id
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.st_code_type
this.Control[iCurrent+12]=this.cb_list
this.Control[iCurrent+13]=this.cb_select
this.Control[iCurrent+14]=this.cb_delete
this.Control[iCurrent+15]=this.cb_exit
this.Control[iCurrent+16]=this.gb_1
end on

on w_code_list.destroy
call super::destroy
destroy(this.sle_type)
destroy(this.st_row_count)
destroy(this.sle_type_desc)
destroy(this.st_1)
destroy(this.sle_text)
destroy(this.cb_stop)
destroy(this.cb_new)
destroy(this.st_code)
destroy(this.sle_id)
destroy(this.dw_1)
destroy(this.st_code_type)
destroy(this.cb_list)
destroy(this.cb_select)
destroy(this.cb_delete)
destroy(this.cb_exit)
destroy(this.gb_1)
end on

type sle_type from u_sle within w_code_list
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Code Type"
string accessibledescription = "Lookup Field - Code Type"
integer x = 1065
integer y = 100
integer width = 247
integer height = 88
integer taborder = 20
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 5
end type

event losefocus;call super::losefocus;SetMicroHelp(w_main,"Ready")
end event

event modified;call super::modified;//This function edits for code types CA - Category, DE - Department and PC - Procedure
//to ensure the lengths entered are valid in the other places used in the database
/*
================================================================================
History
================================================================================
JasonS  	12/11/02 Track 3368d  check dictionary for max length
RickB  07/30/09  RTO.650.5712 - Changed SQL to select the MAX elem_data_len instead of MIN
						to match the SQL in w_code_maint.
================================================================================
*/

// JasonS 11/4/02 Begin - Track 3368d
long ll_size = 0

select max(elem_data_len)
into :ll_size
from dictionary
where elem_lookup_type = :sle_type.text
using stars2ca;

if ll_size > 0 then
	sle_id.limit = ll_size
end if
// JasonS 11/4/02 End - Track 3368d


// FDG 03/14/02	Track 2861d.  Trim the data for Oracle.
sle_type.text	=	Trim(sle_type.text)

if sle_type.text <> gv_selection1 then	
	sle_type_desc.text = ""
end if
if sle_type.text<>'' then
	select code_desc into :sle_type_desc.text
	from code where code_type='CD'
	and code_code = Upper( :sle_type.text )
	using stars2ca;
	if stars2ca.of_check_status()<>0 then
		//errorbox(stars2ca,'Error reading description for code') // Gary-R 08/22/2000 change to user friendly error.
		MessageBox( "Code Error", "Error reading description for code!", StopSign! )
	else
		in_code_type=sle_type.text
	end if
	COMMIT Using Stars2ca;							// FDG 11/01/95
	IF Stars2ca.of_check_status()	<	0		THEN			// FDG 11/01/95
		ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 11/01/95
	END IF												// FDG 11/01/95
else
	sle_type_desc.text=''
end if

end event

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

gv_code_type = "CD"
gv_which_dw = "CL"
open(w_select_box)
If gv_selection1 <> '' then
   This.text = gv_selection1
	sle_type_desc.text = gv_selection2
End If

This.PostEvent ("Modified")
end event

type st_row_count from statictext within w_code_list
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1404
integer width = 274
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

type sle_type_desc from singlelineedit within w_code_list
string accessiblename = "Code Description"
string accessibledescription = "Code Description"
accessiblerole accessiblerole = textrole!
integer x = 1481
integer y = 100
integer width = 1079
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
end type

type st_1 from statictext within w_code_list
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 608
integer y = 360
integer width = 411
integer height = 68
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_text from singlelineedit within w_code_list
string accessiblename = "Code Type Description"
string accessibledescription = "Code Type Description"
accessiblerole accessiblerole = textrole!
integer x = 1065
integer y = 344
integer width = 1019
integer height = 88
integer taborder = 40
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_stop from u_cb within w_code_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
integer x = 1390
integer y = 1480
integer width = 338
integer height = 108
integer taborder = 10
integer textsize = -16
string text = "Stop"
end type

on clicked;gv_cancel_but_clicked = TRUE
end on

type cb_new from u_cb within w_code_list
string accessiblename = "Add"
string accessibledescription = "Add"
integer x = 1317
integer y = 1388
integer width = 338
integer height = 108
integer taborder = 80
string text = "&Add"
end type

on clicked;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

//********************************************************************
//This screen will load up the maintain screen and allow them to add
//********************************************************************

SetPointer(hourglass!)

/*Tells other screens it should be an Add screen*/
gv_from = "A"
gv_code_type = in_code_type
SetMicroHelp(W_Main,"Opening the Codes Add Screen")

OpenSheet(w_code_maint,MDI_main_frame,help_menu_position,Layered!)
setmicrohelp(w_main,'Ready')
end on

type st_code from statictext within w_code_list
string accessiblename = "Code ID"
string accessibledescription = "Code ID"
accessiblerole accessiblerole = statictextrole!
integer x = 704
integer y = 244
integer width = 315
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code ID:"
alignment alignment = center!
end type

type sle_id from singlelineedit within w_code_list
string accessiblename = "Code ID"
string accessibledescription = "Code Id"
accessiblerole accessiblerole = textrole!
integer x = 1065
integer y = 228
integer width = 594
integer height = 88
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_1 from u_dw within w_code_list
string tag = "CRYSTAL, title = Code List"
string accessiblename = "Code List"
string accessibledescription = "Code List"
integer x = 18
integer y = 492
integer width = 2693
integer height = 840
integer taborder = 50
string dataobject = "d_code_type_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

on retrieveend;//                     ***RETRIEVEEND FOR DW_1***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

//********************************************************************
//This section enables all buttons except the stop as long as the rowcount is 
//greater than zero.  If it is zero it displays a error message, certain buttons are
//left disabled and control is returned back to the window
//**********************************************************************

SetMicroHelp(W_Main,"Ready")	

gv_cancel_but_clicked = TRUE
dw_1.triggerevent(rowfocuschanged!)


end on

event rowfocuschanged;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
// MikeF	7/29/02	Track 2962. Retrieve CODE_VALUE_N for System Dispositions
//***********************************************************************

string test
int row_nbr,clicked_row

//This event will only function if the stop button has been clicked//

if gv_cancel_but_clicked Then
	
	cb_select.enabled = true
	cb_select.default = true
	cb_delete.enabled = true
	row_nbr = getrow(dw_1)
	// FDG 01/17/02 Track 2699d.  If no rows exist, get out
	If row_nbr = 0 			&
	or	This.RowCount()	<	1	then 
   	cb_select.enabled = false
		cb_delete.enabled = false
		return
	end if

//Highlights the current row
	SelectRow(dw_1,0,FALSE)
	SelectRow(dw_1,row_nbr,TRUE)
	in_code_type = sle_type.text
	in_code_code = GetItemString(dw_1,row_nbr,1)
	ii_value_n	 = GetItemNumber(dw_1,row_nbr,"code_value_n")  // MikeFl 7/29/02 - Track 2962
end if	
end event

on retrievestart;//                ***RETRIEVESTART FOR DW_1***
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

gv_cancel_but_clicked = FALSE
cb_stop.enabled = TRUE
SetPointer(HourGlass!)
end on

event doubleclicked;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
// 07/18/97 NLG  Replace GetClickedRow with argument row
//***********************************************************************

//**********************************************************************
//As long as the stop button has been clicked or the retrieve finished
//then it select the row that was doubleclicked on
//******************************************************************** 

int row_nbr

/*gets the row and makes sure a row was clicked*/

if gv_cancel_but_clicked Then
	row_nbr = row
	If row_nbr = 0 then
		return
	end if
	triggerevent(cb_select,Clicked!)
end if
end event

on losefocus;	cb_list.default = TRUE
	
end on

type st_code_type from statictext within w_code_list
string accessiblename = "Code Type"
string accessibledescription = "Code Type"
accessiblerole accessiblerole = statictextrole!
integer x = 631
integer y = 116
integer width = 389
integer height = 88
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code Type:"
alignment alignment = center!
end type

type cb_list from u_cb within w_code_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 411
integer y = 1388
integer width = 338
integer height = 108
integer taborder = 60
string text = "&List"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_list.clicked()
//
// Arguments: n/a
//
// Returns:		long
//
// Description:	Refresh the list when cb_list clicked.
//
//***********************************************************************
//
// 10/19/93 SWD	Created
// 06/28/95 FNC	Change the way chkcode is called
//	12/08/97 FDG	Stars 3.6, Prob 158.  When only 1 row exists, do not
//						display the detail window
//	02/09/01	FDG	Stars 4.6 - PIMR.  Allow '#' in code type.
//	03/07/02	FDG	Track 2861d.  Trim sle_type, sle_id, sle_text.
//	05/27/09	Katie	GNL.600.5633 Remove programmtic set of the dw_1 taborder.
//
//***********************************************************************

Long lv_nbr_rows
int rc
string lv_null_arg

setpointer(hourglass!) 
SetMicroHelp(W_Main,"Listing All Codes Based On The Criteria")	

// FDG 03/07/02 - trim data
sle_type.text	=	Trim (sle_type.text)
sle_id.text		=	Trim (sle_id.text)
sle_text.text	=	Trim (sle_text.text)


if (sle_type.text = "") then
	messagebox("Error","Please Enter A Code Type" ,stopsign!,ok!)
	SetFocus(sle_type)
	return
end if
rc = chkcode("CD",sle_type.text,lv_null_arg)

if rc = -1 Then
	// FDG 02/09/01 - Allow for # to be 1st digit
	String	ls_code_type
	ls_code_type	=	Mid (sle_type.text, 1, 1)
	IF	ls_code_type	<>	'#'		THEN
		messagebox('Error','An Invalid Code Type was entered.~r'+&
								 'Please enter or choose a valid one'&
					  ,stopsign!,ok!)
		SetFocus(sle_type)
		setmicrohelp(w_main,'Ready')
		return
	END IF
	// FDG 02/09/01 - end
end if

if rc = -2 Then           //06-28-95 FNC Start
	messagebox("Error","Error Reading the Code table to verify code type.~r"+&
   						 "Please contact the system administrator. "&
				  ,stopsign!,ok!)
	SetFocus(sle_type)
	return
end if                   //06-28-95 FNC End

//**************************RETRIEVE FOR DW_1 SECTION***************************
//This Section connects to the transection object and then retrieves the
//data to be put in the datawindow.  If there is an error during either
//of these an error box is shown.
//*************************************************************************\

Reset(DW_1)

rc = SetTransObject(DW_1,stars2ca)
if rc = -1 Then
	errorbox(stars2ca,"Error connecting to the datawindow in w_code_list.cb_list.clicked.")
	return
end if

lv_nbr_rows = Retrieve(dw_1,sle_type.text,sle_id.text+"%","%"+sle_text.text+"%")

if lv_nbr_rows = -1 Then
	errorbox(stars2ca,"Error retrieving codes for the datawindow in w_code_list.cb_list.clicked.")
	return
end if

//************************ERROR CHECKING SECTION*************************
//This section checks to see if there
//was just one row retrieved.  If there is none found a error message is
//shown and it returns to the window.  If there is one row it loads the
//w_maintain window
//*********************************************************************
/*Checks to see if there is no data in the table*/
If lv_nbr_rows = 0 Then
	COMMIT Using Stars2ca;							// FDG 10/20/95
	SetMicroHelp(w_main,"Search Cancelled")
   messagebox("NO DATA","No data for that search criteria",INFORMATION!,OK!)
	return
end if
/*Checks to see if there is just one row in table*/

SetMicroHelp(w_main,"Ready")

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

cb_select.enabled = TRUE
cb_delete.enabled = TRUE

string mod_str

mod_str = "st_code_type.text=~'(Type: " + sle_type.text + ")~'"
dw_1.Modify(mod_str)
st_row_count.text = string(lv_nbr_rows)
end event

type cb_select from u_cb within w_code_list
string accessiblename = "Select"
string accessibledescription = "Select..."
integer x = 864
integer y = 1388
integer width = 338
integer height = 108
integer taborder = 70
string text = "&Select..."
end type

event clicked;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

//********************************************************************
//This loads the instances into the globals and then calls the maintain
//window which will load the rest of the elements using the globals
//*********************************************************************

SetPointer(hourglass!)

/*Tells other windows that should be a maintain screen*/ 
gv_from = "M"
gv_code_type = in_code_type
gv_code_code = in_code_code

SetMicroHelp(W_Main,"Opening the Codes Details Screen with the selected info")
/*opens maintance screen*/

OpenSheet(w_code_maint,MDI_main_frame,help_menu_position,Layered!)
setfocus(w_code_maint)
setmicrohelp(w_main,'Ready')
end event

type cb_delete from u_cb within w_code_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1769
integer y = 1388
integer width = 338
integer height = 108
integer taborder = 90
string text = "&Delete"
end type

event clicked;
//========================================================================================================
// Name		Date			Track		Description
// ------	--------  	-----		-----------------------------------------------------------------------
// MikeFl	07/23/02		2962d		Remove the ability to delete system Dispositions
// MikeFl	08/05/02		3228d		Remove the ability to delete system Status'
//	GaryR		06/24/03		3228d		Fire the RowFocusChanged event to refresh instance variables
//========================================================================================================
int lv_message_nbr
Long	ll_row, ll_rowcount

SETPOINTER(HOURGLASS!)

// MikeFl 8/5/02 - Track 3228 - Begin

// MikeFl 7/29/02 - Track 2962 - Begin
//If  in_code_type = 'DP' and  &
//	(in_code_code = 'SYSADD' OR in_code_code = 'SYSORCLS' OR &
//	 in_code_code = 'SYSRECLS' OR in_code_code = 'SYSDELET') THEN
//IF  in_code_type = 'DP' &
//AND ii_value_n > 0 THEN	
//// MikeFl 7/29/02 - Track 2962 - End
//	Messagebox('EDIT','Cannot Delete System Dispositions')
//	RETURN
//End IF

IF  (in_code_type = 'DP' OR in_code_type = 'SA') &
AND ii_value_n > 0 THEN	
	Messagebox('EDIT','Cannot Delete System Codes')
	RETURN
End IF
// MikeFl 8/5/02 - Track 3228 - End

/*Prints a confirmation box and finds out what button was pressed*/
lv_message_nbr = MessageBox("CONFIRMATION!","Delete Record?",Question!,OKCANCEL!)
If lv_message_nbr = 2 Then
	  SetMicroHelp(w_main,"Deletion of Code type Cancelled")
     Return
end if

SetMicroHelp(W_Main,"Deleting the Code from the Code Table")

SetPointer(Hourglass!)
/*Checks to see there was a error in reading the database or*/
/*if there was no match in the database*/
/*Deletes the row from the data window*/

DELETE FROM code 
	WHERE 
		Code_type = Upper( :in_code_type ) and
		code_code = Upper( :in_code_code )
	USING Stars2ca;

if stars2ca.of_check_status() = 100 Then
	messagebox("Error","Record Not Found,Deletion cancelled",stopsign!)
	setfocus(sle_type)
	setmicrohelp(w_main,'Deletion Cancelled')
	return
elseif stars2ca.sqlcode <> 0 Then
	errorbox(stars2ca,"Error deleting from the Dictionary Table where Code Type = " + in_code_type + " and Code Code = " + in_code_code)

	setmicrohelp(w_main,'Deletion Cancelled')
	return
end if

COMMIT Using Stars2ca;

ll_row = dw_1.GetRow()
DeleteRow(dw_1,0)
Setfocus(dw_1)
ll_rowcount = dw_1.RowCount()
IF ll_rowcount > 0 THEN
	IF ll_row > ll_rowcount THEN ll_row = ll_rowcount
	dw_1.Event RowFocusChanged( ll_row )
END IF

/*Decreases the row count by one*/ 

st_row_count.text = string(integer(st_row_count.text) -1)
SetMicroHelp(w_main,"Deletion Complete")
end event

type cb_exit from u_cb within w_code_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2222
integer y = 1388
integer width = 338
integer height = 108
integer taborder = 100
string text = "&Close"
end type

on clicked;SetMicroHelp(W_MAIN,"Ready")
close(parent)
end on

type gb_1 from groupbox within w_code_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 14
integer y = 32
integer width = 2697
integer height = 432
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

