$PBExportHeader$w_dw_print_what_rows.srw
$PBExportComments$stars selective row print (inherited from w_master)
forward
global type w_dw_print_what_rows from w_master
end type
type dw_print from u_dw within w_dw_print_what_rows
end type
type st_2 from statictext within w_dw_print_what_rows
end type
type st_count from statictext within w_dw_print_what_rows
end type
type st_1 from statictext within w_dw_print_what_rows
end type
type cb_print from u_cb within w_dw_print_what_rows
end type
type cb_close from u_cb within w_dw_print_what_rows
end type
type dw_rows from u_dw within w_dw_print_what_rows
end type
end forward

global type w_dw_print_what_rows from w_master
string accessiblename = "Print Row Selection"
string accessibledescription = "Print Row Selection"
accessiblerole accessiblerole = windowrole!
integer x = 137
integer y = 92
integer width = 2642
integer height = 1744
string title = "Print Row Selection"
windowtype windowtype = response!
long backcolor = 67108864
dw_print dw_print
st_2 st_2
st_count st_count
st_1 st_1
cb_print cb_print
cb_close cb_close
dw_rows dw_rows
end type
global w_dw_print_what_rows w_dw_print_what_rows

type variables
private long selected_row_count = 0
end variables

event open;///////////////////////////////////////////////////////////////////////////
// OPEN SCRIPT for W_DW_PRINT_WHAT_ROWS
///////////////////////////////////////////////////////////////////////////
//
// 10/12/2000 GaryR 3020c When selecting specific rows to be printed
//								  retain the zoom percantage
//
///////////////////////////////////////////////////////////////////////////
integer rc

setpointer(HourGlass!)
// this window requires window w_dw_print_what_cols
if not isvalid(w_dw_print_what_cols) then
	MessageBox("ERROR","Selective column window was closed - Can not continue",StopSign!)
	cb_print.enabled = FALSE
	return
end if

// make a copy of the other dw into this window
setmicrohelp(w_main,"Creating row selection window - Please wait....")

string lv_syntax //EK debugging

lv_syntax = w_dw_print_what_cols.dw_name.Describe("datawindow.Syntax")
rc = dw_rows.Create(w_dw_print_what_cols.dw_name.Describe("datawindow.Syntax"))
if rc = -1 Then 
	messagebox("ERROR","Error creating datawindow")
	return
end if

//fx_set_window_colors(w_dw_print_what_rows)
//PERFORMANCE IMPROVEMENT --- Scott-d  
//The sharedata command is put in to replace commented code below.

//FileDelete("c:\dwrowprt.txt")
//if w_dw_print_what_cols.dw_name.saveas("c:\dwrowprt.txt",Text!,FALSE) < 1 then
//	MessageBox("ERROR","Unable to create datawindow export file")
//	close(w_dw_print_what_rows)
//	return
//end if
//if dw_rows.ImportFile("c:\dwrowprt.txt") < 1 then
//	Messagebox("ERROR","Unable to import datawindow export file")
//	close(w_dw_print_what_rows)
//	return
//end if

w_dw_print_what_cols.dw_name.sharedata(dw_rows)

dw_rows.scrolltorow(long(w_dw_print_what_cols.dw_name.Describe("datawindow.LastRowOnPage")))
dw_rows.Modify("datawindow.selected.mouse=no")
dw_rows.Modify( "DataWindow.Zoom=" + w_dw_print_what_cols.dw_name.Describe( "DataWindow.Zoom" ) ) // 10/12/2000 GaryR 3020c
// de-select all rows
SelectRow(dw_rows,0,FALSE)
setmicrohelp(w_main,"Ready - Please select rows to be printed")

end event

event close;call super::close;Setmicrohelp(w_main,"Ready")
end event

on w_dw_print_what_rows.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.st_2=create st_2
this.st_count=create st_count
this.st_1=create st_1
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_rows=create dw_rows
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_count
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_rows
end on

on w_dw_print_what_rows.destroy
call super::destroy
destroy(this.dw_print)
destroy(this.st_2)
destroy(this.st_count)
destroy(this.st_1)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_rows)
end on

type dw_print from u_dw within w_dw_print_what_rows
boolean visible = false
string accessiblename = "Print Rows"
string accessibledescription = "Print Rows"
accessiblerole accessiblerole = clientrole!
integer x = 901
integer y = 388
integer taborder = 20
boolean enabled = false
boolean titlebar = true
end type

type st_2 from statictext within w_dw_print_what_rows
string accessiblename = "Rows Selected"
string accessibledescription = "Rows Selected"
accessiblerole accessiblerole = statictextrole!
integer x = 50
integer y = 1524
integer width = 453
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Rows Selected"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_count from statictext within w_dw_print_what_rows
string accessiblename = "Count"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 526
integer y = 1528
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_dw_print_what_rows
string accessiblename = "Highlight Rows To Be Printed"
string accessibledescription = "Highlight Rows To Be Printed"
accessiblerole accessiblerole = statictextrole!
integer x = 818
integer y = 12
integer width = 928
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Highlight Rows To Be Printed"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_print from u_cb within w_dw_print_what_rows
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1632
integer y = 1512
integer width = 338
integer height = 108
integer taborder = 40
string text = "&Print"
end type

event clicked;//************************************************************************
//	Object Name:	w_dw_print_what_rows.cb_print
//	Object Type:	CommandButton
//	Event Name:		Clicked
//
//************************************************************************
//	FDG	04/09/96	Prob 42 - When selecting individual rows to print, the
//						unprinted rows get deleted.  Replace the deleting of
//						rows to copying the selected rows into a print d/w.
// 10/12/2000 GaryR 3020c When selecting specific rows to be printed
//								  retain the zoom percantage
//
//************************************************************************

long		ll_suba
Long		ll_filter_row[]		// FDG 04/09/96
Long		ll_filter_max			// FDG 04/09/96
Long		ll_rowcount				// FDG 04/09/96
Long		ll_row					// FDG 04/09/96
String	ls_describe				// FDG 04/09/96
DataWindow	ldw_print			// FDG 04/09/96
Integer	li_rc						// FDG 04/09/96

ll_filter_max	=	0				// FDG 04/09/96

if selected_row_count < 1 then
	messagebox("ERROR","Please select at least one row to print")
	return
end if

setpointer(HourGlass!)
setmicrohelp(w_main,'Removing non selected rows and columns - Please Wait')
cb_close.enabled = FALSE  //HRB - 8/1/95 - prob#882
cb_print.enabled = FALSE  //HRB - 8/1/95 - prob#882
dw_rows.SetRedraw(FALSE)
ll_rowcount	=	dw_rows.RowCount()		// FDG 04/09/96

	// FDG 04/09/96 - Create dw_print using the syntax of dw_rows.  Once
	//						created, the selected rows will be copied to
	//						dw_print.  dw_print will then be printed.
ls_describe	=	dw_rows.Describe("DataWindow.Syntax")
li_rc			=	dw_print.Create(ls_describe)
dw_print.Modify( "DataWindow.Zoom=" + dw_rows.Describe( "DataWindow.Zoom" ) ) // 10/12/2000 GaryR 3020c

FOR ll_suba = 1 to ll_rowcount 			// FDG 04/09/96
 if dw_rows.IsSelected(ll_suba) then	// FDG 04/09/96
//      setmicrohelp(w_main,'Removing non selected rows - Removing row # ' + string(ll_suba))
//      dw_rows.ScrollToRow(ll_suba)
//	dw_rows.DeleteRow(ll_suba)				// FDG 04/09/96
	ll_filter_max++
	dw_rows.RowsCopy (ll_suba, ll_suba, Primary!, dw_print, ll_filter_max, Primary!)
 end if
NEXT


//w_dw_print_what_cols.process_done = w_dw_print_what_cols.wf_print_dw(dw_rows)
w_dw_print_what_cols.wf_shr_unshr_print(dw_print)		// FDG 04/09/96


dw_rows.SetRedraw(TRUE)					// FDG 04/09/96

setPointer(HourGlass!)
setmicrohelp(w_main,"Closing print window....")
close(w_dw_print_what_cols)
close(w_dw_print_what_rows)
//cb_close.PostEvent(Clicked!)
end event

type cb_close from u_cb within w_dw_print_what_rows
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2153
integer y = 1512
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Cancel"
end type

on clicked;close(w_dw_print_what_rows)
end on

type dw_rows from u_dw within w_dw_print_what_rows
string accessiblename = "Selected Rows"
string accessibledescription = "Selected Rows"
accessiblerole accessiblerole = clientrole!
integer x = 50
integer y = 100
integer width = 2510
integer height = 1360
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
end type

on dragenter;///*Drag Enter for data window 1*/
//string test
//int row_nbr,clicked_row
//setpointer(hourglass!)
//
//
///*gets the row and makes sure a row was clicked*/
//
//row_nbr = getclickedrow(dw_rows)
//If row_nbr = 0 then
//      return
//end if
//
///*Highlights the selected row*/
////SelectRow(dw_rows,0,FALSE)
//if dw_rows.isselected(row_nbr) = TRUE then
//      Selectrow(dw_rows,row_nbr,FALSE)
//      selected_row_count --
//else
//      SelectRow(dw_rows,row_nbr,TRUE)
//      selected_row_count ++
//end if
//st_count.text = string(selected_row_count)
//
end on

event clicked;/*Clicked for data window 1*/
string test
int row_nbr,clicked_row
setpointer(hourglass!)
/*gets the row and makes sure a row was clicked*/
row_nbr = row //getclickedrow(dw_rows)
If row_nbr = 0 then
	return
end if

/*Highlights the selected row*/
//SelectRow(dw_rows,0,FALSE)
if dw_rows.isselected(row_nbr) = TRUE then
	Selectrow(dw_rows,row_nbr,FALSE)
	selected_row_count --
else
	SelectRow(dw_rows,row_nbr,TRUE)
	selected_row_count ++
end if
st_count.text = string(selected_row_count)

end event

