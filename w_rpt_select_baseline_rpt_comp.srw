HA$PBExportHeader$w_rpt_select_baseline_rpt_comp.srw
$PBExportComments$Inherited from w_rpt_select_baseline_report_parent
forward
global type w_rpt_select_baseline_rpt_comp from w_rpt_select_baseline_report_parent
end type
type st_1 from statictext within w_rpt_select_baseline_rpt_comp
end type
type st_3 from statictext within w_rpt_select_baseline_rpt_comp
end type
type st_4 from statictext within w_rpt_select_baseline_rpt_comp
end type
type st_5 from statictext within w_rpt_select_baseline_rpt_comp
end type
type st_6 from statictext within w_rpt_select_baseline_rpt_comp
end type
type st_7 from statictext within w_rpt_select_baseline_rpt_comp
end type
end forward

global type w_rpt_select_baseline_rpt_comp from w_rpt_select_baseline_report_parent
long backcolor = 67108864
string accessiblename = "Standard Analysis Report - Comparison"
string accessibledescription = "Standard Analysis Report - Comparison"
accessiblerole accessiblerole = windowrole!
string title = "Standard Analysis Report - Comparison"
st_1 st_1
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
end type
global w_rpt_select_baseline_rpt_comp w_rpt_select_baseline_rpt_comp

type variables
string iv_invoice_type
end variables

event open;call super::open;if ib_need_to_close_down then   // jsb 01-28-02  Track 2469
	close(this)                  // jsb 01-28-02  Track 2469
	return                       // jsb 01-28-02  Track 2469
end if                          // jsb 01-28-02  Track 2469

//fx_set_window_colors(w_rpt_select_baseline_rpt_comp)

end event

on w_rpt_select_baseline_rpt_comp.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.st_7
end on

on w_rpt_select_baseline_rpt_comp.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
end on

event ue_preopen;call super::ue_preopen;iv_invoice_type = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type st_period from w_rpt_select_baseline_report_parent`st_period within w_rpt_select_baseline_rpt_comp
end type

type uo_1 from w_rpt_select_baseline_report_parent`uo_1 within w_rpt_select_baseline_rpt_comp
end type

type cb_reset from w_rpt_select_baseline_report_parent`cb_reset within w_rpt_select_baseline_rpt_comp
boolean visible = false
integer taborder = 0
end type

type rb_6 from w_rpt_select_baseline_report_parent`rb_6 within w_rpt_select_baseline_rpt_comp
integer x = 174
integer y = 1040
integer height = 96
string text = ""
end type

type rb_5 from w_rpt_select_baseline_report_parent`rb_5 within w_rpt_select_baseline_rpt_comp
integer x = 174
integer height = 96
string text = ""
end type

type rb_4 from w_rpt_select_baseline_report_parent`rb_4 within w_rpt_select_baseline_rpt_comp
integer x = 174
integer y = 760
integer height = 96
string text = ""
end type

type rb_3 from w_rpt_select_baseline_report_parent`rb_3 within w_rpt_select_baseline_rpt_comp
integer x = 174
integer y = 616
integer height = 96
string text = ""
end type

type rb_2 from w_rpt_select_baseline_report_parent`rb_2 within w_rpt_select_baseline_rpt_comp
integer x = 174
integer y = 472
integer height = 96
string text = ""
end type

type rb_1 from w_rpt_select_baseline_report_parent`rb_1 within w_rpt_select_baseline_rpt_comp
integer x = 174
integer y = 328
string text = ""
end type

type cb_close from w_rpt_select_baseline_report_parent`cb_close within w_rpt_select_baseline_rpt_comp
integer x = 1943
integer y = 1432
integer taborder = 90
end type

type cb_create_report from w_rpt_select_baseline_report_parent`cb_create_report within w_rpt_select_baseline_rpt_comp
integer x = 1170
integer y = 1440
string text = "Create &Report..."
end type

on cb_create_report::clicked;call w_rpt_select_baseline_report_parent`cb_create_report::clicked;if parent_ok = False then
   return
end if

if rb_1.checked = true then
    gv_report_id = 'd_rpt_fiscal_year_by_proc'
elseif rb_2.checked = true then
    gv_report_id = 'd_rpt_fiscal_year_by_proc_2000'
elseif rb_3.checked = true then
    gv_report_id = 'd_rpt_fiscal_year_by_spec'
elseif rb_4.checked = true then
    gv_report_id = 'd_rpt_fiscal_year_by_spec_2000'
elseif rb_5.checked = true then
    gv_report_id = 'd_rpt_top_100_upins_specialty'
elseif rb_6.checked = true then
    gv_report_id = 'd_rpt_top_100_upins'
else
    SetMicroHelp(w_rpt_select_baseline_rpt_comp,'List Cancelled')
	 messagebox('ERROR','Must Select a Report!',stopsign!,OK!)
	 return
end if

OpenSheetWithParm(w_rpt_display_baseline_report_comp,iv_invoice_type,MDI_Main_Frame,Help_Menu_Position,Layered!)
end on

type gb_1 from w_rpt_select_baseline_report_parent`gb_1 within w_rpt_select_baseline_rpt_comp
integer x = 59
integer y = 236
end type

type st_1 from statictext within w_rpt_select_baseline_rpt_comp
string accessiblename = "Procedures Sorted by Procedure Code"
string accessibledescription = "Procedures Sorted by Procedure Code"
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 348
integer width = 1152
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Procedures Sorted by Procedure Code"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rpt_select_baseline_rpt_comp
string accessiblename = "Procedures Sorted by Difference in Allowed Charge"
string accessibledescription = "Procedures Sorted by Difference in Allowed Charge"
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 496
integer width = 1527
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Procedures Sorted by Difference in Allowed Charge"
boolean focusrectangle = false
end type

type st_4 from statictext within w_rpt_select_baseline_rpt_comp
string accessiblename = "Specialty Sorted by Specialty Code"
string accessibledescription = "Specialty Sorted by Specialty Code "
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 636
integer width = 1061
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Specialty Sorted by Specialty Code"
boolean focusrectangle = false
end type

type st_5 from statictext within w_rpt_select_baseline_rpt_comp
string accessiblename = "Specialty Sorted by Difference in Allowed Charge"
string accessibledescription = "Specialty Sorted by Difference in Allowed Charge"
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 780
integer width = 1467
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Specialty Sorted by Difference in Allowed Charge"
boolean focusrectangle = false
end type

type st_6 from statictext within w_rpt_select_baseline_rpt_comp
string accessiblename = "Top 100 Provider UPINS Within Spec by Difference in Allowed Charge"
string accessibledescription = "Top 100 Provider UPINS Within Spec by Difference in Allowed Charge"
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 924
integer width = 2066
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Top 100 Provider UPINS Within Spec by Difference in Allowed Charge"
boolean focusrectangle = false
end type

type st_7 from statictext within w_rpt_select_baseline_rpt_comp
string accessiblename = "Top 100 Provider UPINS Sorted by Difference in Allowed Charge"
string accessibledescription = "Top 100 Provider UPINS Sorted by Difference in Allowed Charge"
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 1060
integer width = 1925
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Top 100 Provider UPINS Sorted by Difference in Allowed Charge"
boolean focusrectangle = false
end type

