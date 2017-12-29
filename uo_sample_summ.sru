HA$PBExportHeader$uo_sample_summ.sru
$PBExportComments$(inherited from u_base) <gui>
forward
global type uo_sample_summ from u_base
end type
type pb_2 from picturebutton within uo_sample_summ
end type
type pb_1 from picturebutton within uo_sample_summ
end type
end forward

global type uo_sample_summ from u_base
string accessiblename = "Sample Summary"
string accessibledescription = "Sample Summary"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
integer width = 768
integer height = 144
pb_2 pb_2
pb_1 pb_1
end type
global uo_sample_summ uo_sample_summ

type variables
window uo_win
end variables

forward prototypes
public subroutine uo_setwin (window win_parm)
end prototypes

public subroutine uo_setwin (window win_parm); uo_win = win_parm
end subroutine

on uo_sample_summ.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
end on

on uo_sample_summ.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.pb_1)
end on

type pb_2 from picturebutton within uo_sample_summ
string accessiblename = "Summary Report"
string accessibledescription = "Summary Report"
long textcolor = 33554432
long backcolor = 67108864
accessiblerole accessiblerole = pushbuttonrole!
integer x = 329
integer y = 12
integer width = 398
integer height = 116
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Summ Rpt"
end type

type pb_1 from picturebutton within uo_sample_summ
string accessiblename = "Patterns"
string accessibledescription = "Patterns"
long textcolor = 33554432
long backcolor = 67108864
accessiblerole accessiblerole = pushbuttonrole!
integer x = 9
integer y = 8
integer width = 311
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Patterns"
end type

