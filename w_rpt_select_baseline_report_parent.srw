HA$PBExportHeader$w_rpt_select_baseline_report_parent.srw
$PBExportComments$Inherited from w_master
forward
global type w_rpt_select_baseline_report_parent from w_master
end type
type st_period from statictext within w_rpt_select_baseline_report_parent
end type
type uo_1 from u_display_period within w_rpt_select_baseline_report_parent
end type
type cb_reset from u_cb within w_rpt_select_baseline_report_parent
end type
type rb_6 from radiobutton within w_rpt_select_baseline_report_parent
end type
type rb_5 from radiobutton within w_rpt_select_baseline_report_parent
end type
type rb_4 from radiobutton within w_rpt_select_baseline_report_parent
end type
type rb_3 from radiobutton within w_rpt_select_baseline_report_parent
end type
type rb_2 from radiobutton within w_rpt_select_baseline_report_parent
end type
type rb_1 from radiobutton within w_rpt_select_baseline_report_parent
end type
type cb_close from u_cb within w_rpt_select_baseline_report_parent
end type
type cb_create_report from u_cb within w_rpt_select_baseline_report_parent
end type
type gb_1 from groupbox within w_rpt_select_baseline_report_parent
end type
end forward

global type w_rpt_select_baseline_report_parent from w_master
string accessiblename = "Standard Analysis Report Selection"
string accessibledescription = "Standard Analysis Report Selection"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 24
integer width = 2738
integer height = 1876
string title = "Standard Analysis Report Selection"
long backcolor = 67108864
st_period st_period
uo_1 uo_1
cb_reset cb_reset
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_close cb_close
cb_create_report cb_create_report
gb_1 gb_1
end type
global w_rpt_select_baseline_report_parent w_rpt_select_baseline_report_parent

type variables
boolean parent_ok
boolean ib_need_to_close_down //jsb 1-28-02  Track 2469
end variables

event open;call super::open;//ajs 4.0 07-21-98 4.0 Track #1296 Correct Open of empty window
//jsb     01-28-02     Track #2469 Set boolean to allow descendants to close window.
string lv_parm
integer Parm_Separator
string lv_invoice_type
long ll_check_for_periods

SetMicroHelp('Ready')

lv_parm = w_main.iv_test
Parm_Separator = Pos(lv_parm,'~t')
if Parm_Separator <> 0 then
    lv_parm = Mid(lv_parm,parm_separator + 1)
end if
Parm_Separator = Pos(lv_parm,'~t')
If Parm_separator = 0 then
	lv_invoice_type = lv_parm				
Else
	lv_invoice_type = Mid(lv_parm,1,parm_separator - 1)
end if

uo_1.uf_load_dddw('SARS', lv_invoice_type, 'AC', 'FALSE')

ll_check_for_periods = uo_1.uf_return_key()		//ajs 4.0 07-21-98 4.0 Track #1296
ib_need_to_close_down = false                   //jsb     1-28-02      Track #2469
if ll_check_for_periods = 0 then						//ajs 4.0 07-21-98 4.0 Track #1296
   ib_need_to_close_down = true                 //jsb     1-28-02      Track #2469
//	close(this)												//ajs 4.0 07-21-98 4.0 Track #1296
//	Return
else                                            //jsb     1-28-02      Track #2469
	rb_1.SetFocus()
end if														//ajs 4.0 07-21-98 4.0 Track #1296
end event

on w_rpt_select_baseline_report_parent.create
int iCurrent
call super::create
this.st_period=create st_period
this.uo_1=create uo_1
this.cb_reset=create cb_reset
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_close=create cb_close
this.cb_create_report=create cb_create_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_period
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.cb_reset
this.Control[iCurrent+4]=this.rb_6
this.Control[iCurrent+5]=this.rb_5
this.Control[iCurrent+6]=this.rb_4
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.rb_1
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.cb_create_report
this.Control[iCurrent+12]=this.gb_1
end on

on w_rpt_select_baseline_report_parent.destroy
call super::destroy
destroy(this.st_period)
destroy(this.uo_1)
destroy(this.cb_reset)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_close)
destroy(this.cb_create_report)
destroy(this.gb_1)
end on

type st_period from statictext within w_rpt_select_baseline_report_parent
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = statictextrole!
integer x = 73
integer y = 72
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
string text = "Period:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from u_display_period within w_rpt_select_baseline_report_parent
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = clientrole!
integer x = 338
integer y = 60
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_reset from u_cb within w_rpt_select_baseline_report_parent
string accessiblename = "Reset"
string accessibledescription = "Reset"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1056
integer y = 1528
integer width = 590
integer height = 108
integer taborder = 90
string text = "&Reset"
end type

type rb_6 from radiobutton within w_rpt_select_baseline_report_parent
string accessiblename = "Radio Button 6"
string accessibledescription = "Radio Button 6"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 201
integer y = 1060
integer width = 59
integer height = 72
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "                                                                                              "
end type

on clicked;cb_create_report.default = true
end on

type rb_5 from radiobutton within w_rpt_select_baseline_report_parent
string accessiblename = "Radio Button 5"
string accessibledescription = "Radio Button 5"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 201
integer y = 904
integer width = 59
integer height = 72
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "                                                                                             "
end type

on clicked;cb_create_report.default = true
end on

type rb_4 from radiobutton within w_rpt_select_baseline_report_parent
string accessiblename = "Radio Button 4"
string accessibledescription = "Radio Button 4"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 201
integer y = 764
integer width = 59
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "                                                                                              "
end type

on clicked;cb_create_report.default = true
end on

type rb_3 from radiobutton within w_rpt_select_baseline_report_parent
string accessiblename = "Radio Button 3"
string accessibledescription = "Radio Button 3"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 201
integer y = 624
integer width = 59
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "                                                                                              "
end type

on clicked;cb_create_report.default = true
end on

type rb_2 from radiobutton within w_rpt_select_baseline_report_parent
string accessiblename = "Radio Button 2"
string accessibledescription = "Radio Button 2"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 201
integer y = 492
integer width = 59
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "                                                                                           "
end type

on clicked;cb_create_report.default = true
end on

type rb_1 from radiobutton within w_rpt_select_baseline_report_parent
string accessiblename = "Radio Button 1"
string accessibledescription = "Radio Button 1"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 201
integer y = 340
integer width = 59
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "                                                                               "
boolean checked = true
end type

on clicked;cb_create_report.default = true
end on

type cb_close from u_cb within w_rpt_select_baseline_report_parent
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1920
integer y = 1528
integer width = 590
integer height = 112
integer taborder = 100
string text = "&Close"
end type

on clicked;close(parent)
end on

type cb_create_report from u_cb within w_rpt_select_baseline_report_parent
string accessiblename = "Create Report"
string accessibledescription = "Create Report"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 192
integer y = 1528
integer width = 590
integer height = 108
integer taborder = 80
string text = "Create Report"
boolean default = true
end type

on clicked;long ll_period

parent_ok = True
setpointer(hourglass!)
setmicrohelp(w_main,'Creating report...')

ll_period = uo_1.uf_return_period()
gv_report_period = ll_period



end on

type gb_1 from groupbox within w_rpt_select_baseline_report_parent
string accessiblename = "Select One Report"
string accessibledescription = "Select One Report"
accessiblerole accessiblerole = groupingrole!
integer x = 73
integer y = 244
integer width = 2533
integer height = 992
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Select One Report:"
end type

