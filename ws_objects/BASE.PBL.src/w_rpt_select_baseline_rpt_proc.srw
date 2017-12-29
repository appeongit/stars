$PBExportHeader$w_rpt_select_baseline_rpt_proc.srw
$PBExportComments$Inherited from w_rpt_select_baseline_report_parent
forward
global type w_rpt_select_baseline_rpt_proc from w_rpt_select_baseline_report_parent
end type
type sle_nbr_procs from singlelineedit within w_rpt_select_baseline_rpt_proc
end type
type sle_nbr_procspec from singlelineedit within w_rpt_select_baseline_rpt_proc
end type
type sle_specialty from singlelineedit within w_rpt_select_baseline_rpt_proc
end type
type st_1 from statictext within w_rpt_select_baseline_rpt_proc
end type
type st_3 from statictext within w_rpt_select_baseline_rpt_proc
end type
type st_4 from statictext within w_rpt_select_baseline_rpt_proc
end type
type st_5 from statictext within w_rpt_select_baseline_rpt_proc
end type
end forward

global type w_rpt_select_baseline_rpt_proc from w_rpt_select_baseline_report_parent
boolean visible = false
long backcolor = 67108864
string accessiblename = "Standard Analysis Report - Procedure"
string accessibledescription = "Standard Analysis Report - Procedure"
accessiblerole accessiblerole = windowrole!
string title = "Standard Analysis Report - Procedure"
sle_nbr_procs sle_nbr_procs
sle_nbr_procspec sle_nbr_procspec
sle_specialty sle_specialty
st_1 st_1
st_3 st_3
st_4 st_4
st_5 st_5
end type
global w_rpt_select_baseline_rpt_proc w_rpt_select_baseline_rpt_proc

type variables
string iv_invoice_type
end variables

event open;call super::open;if ib_need_to_close_down then   // jsb 01-28-02  Track 2469
	close(this)                  // jsb 01-28-02  Track 2469
	return                       // jsb 01-28-02  Track 2469
end if                          // jsb 01-28-02  Track 2469

//fx_set_window_colors(w_rpt_select_baseline_rpt_proc)

end event

on w_rpt_select_baseline_rpt_proc.create
int iCurrent
call super::create
this.sle_nbr_procs=create sle_nbr_procs
this.sle_nbr_procspec=create sle_nbr_procspec
this.sle_specialty=create sle_specialty
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_nbr_procs
this.Control[iCurrent+2]=this.sle_nbr_procspec
this.Control[iCurrent+3]=this.sle_specialty
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
end on

on w_rpt_select_baseline_rpt_proc.destroy
call super::destroy
destroy(this.sle_nbr_procs)
destroy(this.sle_nbr_procspec)
destroy(this.sle_specialty)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
end on

event ue_preopen;call super::ue_preopen;iv_invoice_type = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type st_period from w_rpt_select_baseline_report_parent`st_period within w_rpt_select_baseline_rpt_proc
end type

type uo_1 from w_rpt_select_baseline_report_parent`uo_1 within w_rpt_select_baseline_rpt_proc
end type

type cb_reset from w_rpt_select_baseline_report_parent`cb_reset within w_rpt_select_baseline_rpt_proc
integer x = 1019
integer y = 1392
string text = "Re&set"
end type

on cb_reset::clicked;call w_rpt_select_baseline_report_parent`cb_reset::clicked;sle_nbr_procspec.text = '100'
sle_nbr_procs.text = '250'
sle_specialty.text = ''
end on

type rb_6 from w_rpt_select_baseline_report_parent`rb_6 within w_rpt_select_baseline_rpt_proc
boolean visible = false
integer x = 151
integer y = 1148
integer taborder = 110
end type

type rb_5 from w_rpt_select_baseline_report_parent`rb_5 within w_rpt_select_baseline_rpt_proc
boolean visible = false
integer x = 151
integer y = 888
integer width = 2030
integer taborder = 130
string text = "National Procedure Comparison Sorted in Procedure Code Order"
end type

type rb_4 from w_rpt_select_baseline_report_parent`rb_4 within w_rpt_select_baseline_rpt_proc
boolean visible = false
integer x = 151
integer y = 772
integer width = 1618
integer taborder = 100
string text = "Top 200 Procedures With Least Potential Savings"
end type

type rb_3 from w_rpt_select_baseline_report_parent`rb_3 within w_rpt_select_baseline_rpt_proc
boolean visible = false
integer x = 151
integer y = 976
integer width = 1728
integer taborder = 60
string text = "Top            Procedures With Greatest Potential Savings"
end type

type rb_2 from w_rpt_select_baseline_report_parent`rb_2 within w_rpt_select_baseline_rpt_proc
integer x = 151
integer y = 660
integer taborder = 50
string text = ""
end type

type rb_1 from w_rpt_select_baseline_report_parent`rb_1 within w_rpt_select_baseline_rpt_proc
integer x = 151
integer y = 520
integer height = 72
string text = ""
end type

type cb_close from w_rpt_select_baseline_report_parent`cb_close within w_rpt_select_baseline_rpt_proc
integer x = 1970
integer y = 1388
integer taborder = 120
end type

type cb_create_report from w_rpt_select_baseline_report_parent`cb_create_report within w_rpt_select_baseline_rpt_proc
integer x = 69
integer y = 1392
string text = "Create &Report..."
end type

on cb_create_report::clicked;call w_rpt_select_baseline_report_parent`cb_create_report::clicked;//*******************************************************************
//05-04-94 FNC Add option for user to specify limit for report
//*******************************************************************

string lv_limit,lv_parm,lv_title,lv_specialty
if parent_ok = false then
    return
end if

if rb_1.checked = true then
    gv_report_id = 'd_rpt_top_100_proc_spec'
    if sle_nbr_procspec.text = '' then
        lv_limit = " AND RANK2 < = 100"
    else
        if integer(sle_nbr_procspec.text) > 100 then
          	 messagebox('ERROR','Cannot select more than 100 procedures for this report',stopsign!,OK!)
             return
        else
           lv_limit = " AND RANK2 <= " + sle_nbr_procspec.text
        end if
    end if
    lv_title = "TOP " + sle_nbr_procspec.text + " PROCEDURES WITHIN SPECIALTY" 
    if sle_specialty.text = ''  or sle_specialty.text = ' ' then
	     messagebox('EDIT','Must enter a % to select all specialties',stopsign!,OK!)
        return
    else
        lv_specialty = sle_specialty.text 
    end if
      lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title + "~t" + lv_specialty
elseif rb_2.checked = true then
    gv_report_id = 'd_rpt_top_250_proc'
    if sle_nbr_procs.text = '' then
        lv_limit = "AND RANK_ALW_CHRG < = 250"
    else
        if integer(sle_nbr_procs.text) > 250 then
          	 messagebox('ERROR','Cannot select more than 250 procedures for this report',stopsign!,OK!)
             return
        else
           lv_limit = "AND RANK_ALW_CHRG <= " + sle_nbr_procs.text 
        end if
    end if
    lv_title = "TOP " + sle_nbr_procs.text + " PROCEDURES"
    lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title

// These radio buttons are invisible and are not being used
//elseif rb_3.checked = true then
//    gv_report_id = 'd_rpt_top_200_proc_code_great_pot'
//elseif rb_4.checked = true then
//    gv_report_id = 'd_rpt_top_200_proc_code_least_pot'
//elseif rb_5.checked = true then
//    gv_report_id = 'd_rpt_proc_code_order'

else
    SetMicroHelp(w_rpt_select_baseline_rpt_proc,'List Cancelled')
	 messagebox('ERROR','Must Select a Report!',stopsign!,OK!)
	 return
end if

OpenSheetwithParm(w_rpt_display_baseline_report,lv_parm,MDI_Main_Frame,Help_Menu_Position,Layered!)

rb_3.visible = false
rb_4.visible = false
rb_5.visible = false
rb_6.visible = false
end on

type gb_1 from w_rpt_select_baseline_report_parent`gb_1 within w_rpt_select_baseline_rpt_proc
integer x = 82
integer y = 304
integer height = 1012
end type

type sle_nbr_procs from singlelineedit within w_rpt_select_baseline_rpt_proc
string accessiblename = "Number of Top Procedure Codes"
string accessibledescription = "Number of Top Procedure Codes"
accessiblerole accessiblerole = textrole!
integer x = 544
integer y = 632
integer width = 183
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
string text = "250"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_2.checked = true
end on

type sle_nbr_procspec from singlelineedit within w_rpt_select_baseline_rpt_proc
string accessiblename = "Number of Top Procedure Codes"
string accessibledescription = "Number of Top Procedure Codes"
accessiblerole accessiblerole = textrole!
integer x = 544
integer y = 504
integer width = 183
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_1.checked = true
end on

type sle_specialty from singlelineedit within w_rpt_select_baseline_rpt_proc
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = textrole!
integer x = 1815
integer y = 504
integer width = 247
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_1.checked = true
end on

type st_1 from statictext within w_rpt_select_baseline_rpt_proc
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 357
integer y = 520
integer width = 128
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
string text = "Top"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_rpt_select_baseline_rpt_proc
string accessiblename = "Procedure Codes Within Specialty"
string accessibledescription = "Procedure Codes Within Specialty"
accessiblerole accessiblerole = statictextrole!
integer x = 759
integer y = 520
integer width = 1024
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
string text = "Procedure Codes Within Specialty"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rpt_select_baseline_rpt_proc
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 357
integer y = 648
integer width = 128
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
string text = "Top"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_rpt_select_baseline_rpt_proc
string accessiblename = "Procedure Codes"
string accessibledescription = "Procedure Codes"
accessiblerole accessiblerole = statictextrole!
integer x = 759
integer y = 648
integer width = 521
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
string text = "Procedure Codes"
alignment alignment = right!
boolean focusrectangle = false
end type

