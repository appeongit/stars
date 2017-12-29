$PBExportHeader$w_code_type_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_code_type_list from w_master
end type
type st_row_count from statictext within w_code_type_list
end type
type st_3 from statictext within w_code_type_list
end type
type st_2 from statictext within w_code_type_list
end type
type cb_stop from u_cb within w_code_type_list
end type
type sle_name from singlelineedit within w_code_type_list
end type
type sle_code_id from singlelineedit within w_code_type_list
end type
type cb_new from u_cb within w_code_type_list
end type
type cb_list_codes from u_cb within w_code_type_list
end type
type dw_1 from u_dw within w_code_type_list
end type
type cb_list from u_cb within w_code_type_list
end type
type cb_select from u_cb within w_code_type_list
end type
type cb_delete from u_cb within w_code_type_list
end type
type cb_exit from u_cb within w_code_type_list
end type
type gb_1 from groupbox within w_code_type_list
end type
end forward

global type w_code_type_list from w_master
string accessiblename = "Code Type List"
string accessibledescription = "Code Type List"
accessiblerole accessiblerole = windowrole!
integer x = 73
integer y = 0
integer width = 2766
integer height = 1660
string title = "Code Type List"
long backcolor = 67108864
st_row_count st_row_count
st_3 st_3
st_2 st_2
cb_stop cb_stop
sle_name sle_name
sle_code_id sle_code_id
cb_new cb_new
cb_list_codes cb_list_codes
dw_1 dw_1
cb_list cb_list
cb_select cb_select
cb_delete cb_delete
cb_exit cb_exit
gb_1 gb_1
end type
global w_code_type_list w_code_type_list

type variables
int in_nbr_rows
string in_code_type,in_code_code

end variables

event open;call super::open;//               ***Script for open w_code_type_list***/

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

//********************************************************************
//This disables the proper buttons if the user is coming from the menu
//********************************************************************

dw_1.taborder = 0

/*Checks to see if coming from the menu*/
cb_list_codes.enabled = FALSE
CB_Select.enabled = false
CB_Delete.enabled = false

cb_stop.enabled = false

setfocus(sle_code_id)
SetMicroHelp(W_code_type_list,"Ready")
//fx_set_window_colors(w_code_type_list)

end event

on w_code_type_list.create
int iCurrent
call super::create
this.st_row_count=create st_row_count
this.st_3=create st_3
this.st_2=create st_2
this.cb_stop=create cb_stop
this.sle_name=create sle_name
this.sle_code_id=create sle_code_id
this.cb_new=create cb_new
this.cb_list_codes=create cb_list_codes
this.dw_1=create dw_1
this.cb_list=create cb_list
this.cb_select=create cb_select
this.cb_delete=create cb_delete
this.cb_exit=create cb_exit
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_row_count
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_stop
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.sle_code_id
this.Control[iCurrent+7]=this.cb_new
this.Control[iCurrent+8]=this.cb_list_codes
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.cb_list
this.Control[iCurrent+11]=this.cb_select
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.cb_exit
this.Control[iCurrent+14]=this.gb_1
end on

on w_code_type_list.destroy
call super::destroy
destroy(this.st_row_count)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_stop)
destroy(this.sle_name)
destroy(this.sle_code_id)
destroy(this.cb_new)
destroy(this.cb_list_codes)
destroy(this.dw_1)
destroy(this.cb_list)
destroy(this.cb_select)
destroy(this.cb_delete)
destroy(this.cb_exit)
destroy(this.gb_1)
end on

type st_row_count from statictext within w_code_type_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 32
integer y = 1384
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

type st_3 from statictext within w_code_type_list
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 919
integer y = 100
integer width = 370
integer height = 72
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

type st_2 from statictext within w_code_type_list
string accessiblename = "Code Type"
string accessibledescription = "Code Type"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 100
integer width = 379
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code Type:"
boolean focusrectangle = false
end type

type cb_stop from u_cb within w_code_type_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1303
integer y = 1472
integer width = 338
integer height = 108
integer textsize = -16
string text = "Stop"
end type

on clicked;gv_cancel_but_clicked = TRUE
end on

type sle_name from singlelineedit within w_code_type_list
string accessiblename = "Name"
string accessibledescription = "Name"
accessiblerole accessiblerole = textrole!
integer x = 1312
integer y = 84
integer width = 1161
integer height = 104
integer taborder = 30
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
integer limit = 32
borderstyle borderstyle = stylelowered!
end type

type sle_code_id from singlelineedit within w_code_type_list
string accessiblename = "Code ID"
string accessibledescription = "Code Id"
accessiblerole accessiblerole = textrole!
integer x = 462
integer y = 84
integer width = 375
integer height = 104
integer taborder = 20
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

type cb_new from u_cb within w_code_type_list
string accessiblename = "Add"
string accessibledescription = "Add..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1106
integer y = 1368
integer width = 338
integer height = 108
integer taborder = 70
string text = "&Add..."
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
gv_from = 'A'
SetMicroHelp(W_Main,'Opening the Codes Type Add')

OpenSheet(w_code_type_maint,MDI_main_frame,help_menu_position,Layered!)
end on

type cb_list_codes from u_cb within w_code_type_list
string accessiblename = "List Codes"
string accessibledescription = "List Codes..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1865
integer y = 1368
integer width = 416
integer height = 108
integer taborder = 100
string text = "L&ist Codes..."
end type

on clicked;gv_from = 'LC'
gv_code_type = in_code_code 
OpenSheet(w_code_list,MDI_main_frame,help_menu_position,Layered!)
end on

type dw_1 from u_dw within w_code_type_list
string accessiblename = "Code List"
string accessibledescription = "Code List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Code List"
integer x = 18
integer y = 260
integer width = 2688
integer height = 1048
integer taborder = 40
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

//w_code_type_list.controlmenu = TRUE					//FDG 06/13/96

SetMicroHelp(W_Main,"Ready")	
gv_cancel_but_clicked = TRUE
triggerevent(dw_1,rowfocuschanged!)
end on

event rowfocuschanged;//                  ***ROWFOCUSCHANGED FOR DW_1***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************


string test
int row_nbr,clicked_row

//This event will only function if the stop button has been clicked//

if gv_cancel_but_clicked Then

	cb_select.enabled = true
	cb_select.default = true
	cb_delete.enabled = true
	cb_list_codes.enabled = true
	
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

//Stores the clicked row's keys into instance variables
	in_code_code = GetItemString(dw_1,row_nbr,1)
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
// 07/18/97 NLG  Replace GetClickedRow(dw_1) with argument row
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

on losefocus;//                        ***LOSEFOCUS DW_1***

	cb_list.default = true

end on

type cb_list from u_cb within w_code_type_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 347
integer y = 1368
integer width = 338
integer height = 108
integer taborder = 50
string text = "&List"
boolean default = true
end type

event clicked;//                          ***CLICKED FOR CB_LIST***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//	03/07/02	FDG	Track 2861d.  Trim sle_code_id, sle_name.
//***********************************************************************

Long lv_nbr_rows
int rc

setpointer(hourglass!) 
SetMicroHelp(W_Main,'Listing All Code Types Based On The Criteria')	

// FDG 03/07/02 - trim data
sle_name.text		=	Trim (sle_name.text)
sle_code_id.text	=	Trim (sle_code_id.text)


//**************************RETRIEVE FOR DW_1 SECTION***************************
//This Section connects to the transection object and then retrieves the
//data to be put in the datawindow.  If there is an error during either
//of these an error box is shown.
//*************************************************************************\

Reset(DW_1)

rc = SetTransObject(DW_1,stars2ca)
if rc = -1 Then
	errorbox(stars2ca,'Error connecting to the datawindow')
	return
end if

lv_nbr_rows = Retrieve(dw_1,'CD',sle_code_id.text+'%','%'+sle_name.text+'%')
if lv_nbr_rows = -1 Then
	errorbox(stars2ca,'Error retrieving data for the datawindow')
	return
end if


//************************ERROR CHECKING SECTION*************************
//This section checks to see if there
//was just one row retrieved.  If there is non found a error message is
//shown and it returns to the window.  If there is one row it loads the
//w_maintain window
//*********************************************************************
/*Checks to see if there is no data in the table*/
gv_cancel_but_clicked = TRUE
If lv_nbr_rows = 0 Then
	COMMIT Using Stars2ca;							// FDG 10/20/95
	SetMicroHelp(w_main,'Search Cancelled')
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
   setfocus(sle_code_id)
	dw_1.taborder = 0	
   return
end if 

dw_1.taborder = 50
SetMicroHelp(w_main,'Ready')
Setfocus(dw_1)

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

st_row_count.text = string(lv_nbr_rows)


end event

type cb_select from u_cb within w_code_type_list
string accessiblename = "Select"
string accessibledescription = "Select..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 727
integer y = 1368
integer width = 338
integer height = 108
integer taborder = 60
string text = "&Select..."
end type

on clicked;//                  ***CLICKED FOR CB_SELECT***

//***********************************************************************
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
gv_from = 'M'
gv_code_type = in_code_type
gv_code_code = in_code_code

SetMicroHelp(W_Main,'Opening the Detail Screen with the selected info')
/*opens maintance screen*/
OpenSheet(w_code_type_maint,MDI_main_frame,help_menu_position,Layered!)
end on

type cb_delete from u_cb within w_code_type_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1486
integer y = 1368
integer width = 338
integer height = 108
integer taborder = 90
string text = "&Delete"
end type

event clicked;//                ***Clicked for cb_Delete****


/*Declaration Section*/
int lv_message_nbr
string temp_str

/*Prints a confirmation box and finds out what button was pressed*/
lv_message_nbr = MessageBox('CONFIRMATION!','Delete Record',Question!,OKCANCEL!)
If lv_message_nbr = 2 Then
	  SetMicroHelp(w_main,'Deletion of Code type Cancelled')
     Return
end if

/* Check to see if there are any code of this type on file */
SELECT CODE_CODE
	INTO :temp_str 	
	FROM CODE
	WHERE CODE_TYPE = Upper( :in_code_code )
		and CODE_CODE = (SELECT MAX(CODE_CODE) FROM CODE 
								WHERE CODE_TYPE = Upper( :in_code_code ) )
	USING stars2ca;

if stars2ca.of_check_status() = 0 Then
	if (messagebox("WARNING","If you continue, all codes of type " + in_code_code  + " will be deleted!",QUESTION!,OKCancel!) = 2) then
		SetMicroHelp(w_main,'Deletion Cancelled')	
		return
	end if
elseif stars2ca.sqlcode <> 100 Then
	errorbox(stars2ca,'Error reading from the CODE Table')
	return
end if

SetMicroHelp(W_Main,'Deleting the Code from the Code Table')


SetPointer(Hourglass!)
/*Checks to see there was a error in reading the database or*/
/*if there was no match in the database*/
/*Deletes the row from the data window*/


DELETE FROM Code 
	WHERE CODE_TYPE = 'CD' and
			CODE_CODE = Upper( :in_code_code )
	using Stars2ca;

if stars2ca.of_check_status() = 100 Then
	messagebox('Error','Record Not Found,Deletion cancelled',stopsign!)
	setfocus(sle_code_id)
	return
elseif stars2ca.sqlcode <> 0 Then
	errorbox(stars2ca,'Error deleting from the Dictionary Table where Code Type = CD and Code Code = ' + in_code_code)
	setfocus(sle_code_id)
	return
end if

COMMIT Using Stars2ca;

DELETE FROM code 
	WHERE Code_type = Upper( :in_code_code  )
	USING Stars2ca;

if (stars2ca.of_check_status() <> 100) and (stars2ca.sqlcode <> 0) Then
	errorbox(stars2ca,'Error deleting from the CODE Table')
	return
end if

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

DeleteRow(dw_1,0)
Setfocus(dw_1)


/*Decreases the row count by one*/ 

st_row_count.text = string(integer(st_row_count.text) -1)
SetMicroHelp(w_main,'Ready')
end event

type cb_exit from u_cb within w_code_type_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2322
integer y = 1368
integer width = 338
integer height = 108
integer taborder = 110
string text = "&Close"
end type

on clicked;close(parent)
end on

type gb_1 from groupbox within w_code_type_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer y = 8
integer width = 2688
integer height = 224
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

