$PBExportHeader$w_rpt_selection.srw
$PBExportComments$Inherited from w_master
forward
global type w_rpt_selection from w_master
end type
type cb_close from u_cb within w_rpt_selection
end type
type rb_comp_rpt from radiobutton within w_rpt_selection
end type
type rb_prov_rpt from radiobutton within w_rpt_selection
end type
type rb_proc_rpt from radiobutton within w_rpt_selection
end type
type rb_diag_rpt from radiobutton within w_rpt_selection
end type
type gb_diagnosis_rpts from groupbox within w_rpt_selection
end type
end forward

global type w_rpt_selection from w_master
string accessiblename = "Standard Analysis Report Selection"
string accessibledescription = "Standard Analysis Report Selection"
accessiblerole accessiblerole = windowrole!
integer x = 901
integer y = 536
integer width = 1381
integer height = 844
string title = "Standard Analysis Report Selection"
long backcolor = 67108864
cb_close cb_close
rb_comp_rpt rb_comp_rpt
rb_prov_rpt rb_prov_rpt
rb_proc_rpt rb_proc_rpt
rb_diag_rpt rb_diag_rpt
gb_diagnosis_rpts gb_diagnosis_rpts
end type
global w_rpt_selection w_rpt_selection

type variables
string iv_invoice_type
end variables

event open;call super::open;String lv_invoice_type

lv_invoice_type = w_main.iv_invoice_type
//lv_invoice_type = message.stringparm
////KMM Clear out message parm (PB Bug)
//SetNull(message.stringParm)
iv_invoice_type = lv_invoice_type
this.x = 801
this.y = 437

// these three lines of code will set the windows color after window is opened
// by w_invoice_selection
//window temp_win
//temp_win = this
//fx_set_window_colors(temp_win)
end event

on w_rpt_selection.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.rb_comp_rpt=create rb_comp_rpt
this.rb_prov_rpt=create rb_prov_rpt
this.rb_proc_rpt=create rb_proc_rpt
this.rb_diag_rpt=create rb_diag_rpt
this.gb_diagnosis_rpts=create gb_diagnosis_rpts
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.rb_comp_rpt
this.Control[iCurrent+3]=this.rb_prov_rpt
this.Control[iCurrent+4]=this.rb_proc_rpt
this.Control[iCurrent+5]=this.rb_diag_rpt
this.Control[iCurrent+6]=this.gb_diagnosis_rpts
end on

on w_rpt_selection.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.rb_comp_rpt)
destroy(this.rb_prov_rpt)
destroy(this.rb_proc_rpt)
destroy(this.rb_diag_rpt)
destroy(this.gb_diagnosis_rpts)
end on

type cb_close from u_cb within w_rpt_selection
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 965
integer y = 588
integer width = 338
integer height = 108
integer taborder = 20
string text = "&Close"
boolean default = true
end type

on clicked;setmicrohelp("Ready")
close(parent)
end on

type rb_comp_rpt from radiobutton within w_rpt_selection
string accessiblename = "Comparison Report"
string accessibledescription = "Comparison Report"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 283
integer y = 392
integer width = 754
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Comparison Report"
end type

on clicked;SetPointer(HourGlass!)

OpenSheetWithParm(w_rpt_select_baseline_rpt_comp,iv_invoice_type,MDI_Main_Frame,Help_Menu_Position,Layered!)
end on

type rb_prov_rpt from radiobutton within w_rpt_selection
string accessiblename = "Provider Reports"
string accessibledescription = "Provider Reports"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 283
integer y = 304
integer width = 754
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Provider Reports"
end type

on clicked;SetPointer(HourGlass!)

OpenSheetWithParm(w_rpt_select_baseline_rpt_prov,iv_invoice_type,MDI_Main_Frame,Help_Menu_Position,Layered!)
end on

type rb_proc_rpt from radiobutton within w_rpt_selection
string accessiblename = "Procedure Report"
string accessibledescription = "Procedure Report"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 283
integer y = 216
integer width = 754
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Procedure Report"
end type

on clicked;SetPointer(HourGlass!)

OpenSheetWithParm(w_rpt_select_baseline_rpt_proc,iv_invoice_type,MDI_Main_Frame,Help_Menu_Position,Layered!)

end on

type rb_diag_rpt from radiobutton within w_rpt_selection
string accessiblename = "Diagnosis Report"
string accessibledescription = "Diagnosis Report"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 283
integer y = 128
integer width = 754
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Diagnosis Report"
end type

on clicked;SetPointer(HourGlass!)

OpenSheetWithParm(w_rpt_select_baseline_rpt_diag,iv_invoice_type,MDI_Main_Frame,help_menu_position,Layered!)





end on

type gb_diagnosis_rpts from groupbox within w_rpt_selection
string accessiblename = "Diagnosis Reports"
string accessibledescription = "Diagnosis Reports"
long textcolor = 134217741
accessiblerole accessiblerole = groupingrole!
integer x = 183
integer y = 48
integer width = 882
integer height = 456
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
end type

