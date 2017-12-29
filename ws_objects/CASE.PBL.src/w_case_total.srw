$PBExportHeader$w_case_total.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_total from w_master
end type
type cb_close from u_cb within w_case_total
end type
type cb_count from u_cb within w_case_total
end type
type dw_case_totals from u_dw within w_case_total
end type
type gb_2 from groupbox within w_case_total
end type
end forward

global type w_case_total from w_master
string accessiblename = "Case Total By"
string accessibledescription = "Case Total By"
accessiblerole accessiblerole = windowrole!
integer x = 1061
integer y = 668
integer width = 914
integer height = 1092
string title = "Case Total By"
boolean controlmenu = false
windowtype windowtype = response!
long backcolor = 67108864
cb_close cb_close
cb_count cb_count
dw_case_totals dw_case_totals
gb_2 gb_2
end type
global w_case_total w_case_total

event open;call super::open;//*****************************************************************************
// 10/16/98 FNC	Track 1579. PB 6.5 Move radio buttons to a datawindow because
//						PB 6.5 cannot determine which radio button is checked.
//
// 11-25-96 FNC Prob #173 STARS35 Call colors function
//*****************************************************************************

long ll_row

ll_row	=	dw_case_totals.InsertRow (0)
dw_case_totals.ScrollToRow (ll_row)

// FNC 10/16/98 End

end event

on w_case_total.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_count=create cb_count
this.dw_case_totals=create dw_case_totals
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_count
this.Control[iCurrent+3]=this.dw_case_totals
this.Control[iCurrent+4]=this.gb_2
end on

on w_case_total.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_count)
destroy(this.dw_case_totals)
destroy(this.gb_2)
end on

type cb_close from u_cb within w_case_total
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 485
integer y = 848
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Close"
end type

on clicked;closewithreturn (w_case_total, 'Close')
end on

type cb_count from u_cb within w_case_total
string accessiblename = "Count "
string accessibledescription = "Count "
accessiblerole accessiblerole = pushbuttonrole!
integer x = 78
integer y = 848
integer width = 338
integer height = 108
integer taborder = 20
string text = "Coun&t "
boolean default = true
end type

event clicked;//*****************************************************************************
// 10/16/98 FNC	Track 1579. PB 6.5 Move radio buttons to a datawindow because
//						PB 6.5 cannot determine which radio button is checked.
//
//*****************************************************************************

// FNC 10/16/98 Start

long ll_row
string ls_retval

ll_row	=	dw_case_totals.GetRow()

ls_retval	=	dw_case_totals.object.total_by [ll_row]

closewithreturn (w_case_total,ls_retval)

// FNC 10/16/98 End
end event

type dw_case_totals from u_dw within w_case_total
string accessiblename = "Case Totals"
string accessibledescription = "Case Totals"
accessiblerole accessiblerole = clientrole!
integer x = 114
integer y = 96
integer width = 599
integer height = 684
integer taborder = 10
string dataobject = "d_case_totals"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;// This datawindow is not updateable
This.of_SetUpdateable (FALSE)
end event

type gb_2 from groupbox within w_case_total
string accessiblename = "Totals By"
string accessibledescription = "Totals By"
accessiblerole accessiblerole = groupingrole!
integer x = 87
integer y = 12
integer width = 699
integer height = 800
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Totals By"
end type

