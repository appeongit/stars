$PBExportHeader$w_rpt_select_baseline_rpt_prov.srw
$PBExportComments$Inherited from w_rpt_select_baseline_report_parent
forward
global type w_rpt_select_baseline_rpt_prov from w_rpt_select_baseline_report_parent
end type
type sle_specialty from singlelineedit within w_rpt_select_baseline_rpt_prov
end type
type sle_upins from singlelineedit within w_rpt_select_baseline_rpt_prov
end type
type sle_provspec from singlelineedit within w_rpt_select_baseline_rpt_prov
end type
type sle_provs from singlelineedit within w_rpt_select_baseline_rpt_prov
end type
type sle_procs from singlelineedit within w_rpt_select_baseline_rpt_prov
end type
type st_4 from statictext within w_rpt_select_baseline_rpt_prov
end type
type sle_specialty2 from singlelineedit within w_rpt_select_baseline_rpt_prov
end type
type st_3 from statictext within w_rpt_select_baseline_rpt_prov
end type
type st_1 from statictext within w_rpt_select_baseline_rpt_prov
end type
type st_5 from statictext within w_rpt_select_baseline_rpt_prov
end type
type st_6 from statictext within w_rpt_select_baseline_rpt_prov
end type
type st_7 from statictext within w_rpt_select_baseline_rpt_prov
end type
type st_8 from statictext within w_rpt_select_baseline_rpt_prov
end type
type st_9 from statictext within w_rpt_select_baseline_rpt_prov
end type
end forward

global type w_rpt_select_baseline_rpt_prov from w_rpt_select_baseline_report_parent
long backcolor = 67108864
string accessiblename = "Standard Analysis Report - Provider "
string accessibledescription = "Standard Analysis Report - Provider "
accessiblerole accessiblerole = windowrole!
string title = "Standard Analysis Report - Provider "
sle_specialty sle_specialty
sle_upins sle_upins
sle_provspec sle_provspec
sle_provs sle_provs
sle_procs sle_procs
st_4 st_4
sle_specialty2 sle_specialty2
st_3 st_3
st_1 st_1
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
end type
global w_rpt_select_baseline_rpt_prov w_rpt_select_baseline_rpt_prov

type variables
string iv_invoice_type
end variables

event open;call super::open;if ib_need_to_close_down then   // jsb 01-28-02  Track 2469
	close(this)                  // jsb 01-28-02  Track 2469
	return                       // jsb 01-28-02  Track 2469
end if                          // jsb 01-28-02  Track 2469

//fx_set_window_colors(w_rpt_select_baseline_rpt_prov)

end event

on w_rpt_select_baseline_rpt_prov.create
int iCurrent
call super::create
this.sle_specialty=create sle_specialty
this.sle_upins=create sle_upins
this.sle_provspec=create sle_provspec
this.sle_provs=create sle_provs
this.sle_procs=create sle_procs
this.st_4=create st_4
this.sle_specialty2=create sle_specialty2
this.st_3=create st_3
this.st_1=create st_1
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_specialty
this.Control[iCurrent+2]=this.sle_upins
this.Control[iCurrent+3]=this.sle_provspec
this.Control[iCurrent+4]=this.sle_provs
this.Control[iCurrent+5]=this.sle_procs
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.sle_specialty2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_7
this.Control[iCurrent+13]=this.st_8
this.Control[iCurrent+14]=this.st_9
end on

on w_rpt_select_baseline_rpt_prov.destroy
call super::destroy
destroy(this.sle_specialty)
destroy(this.sle_upins)
destroy(this.sle_provspec)
destroy(this.sle_provs)
destroy(this.sle_procs)
destroy(this.st_4)
destroy(this.sle_specialty2)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
end on

event ue_preopen;call super::ue_preopen;iv_invoice_type = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type st_period from w_rpt_select_baseline_report_parent`st_period within w_rpt_select_baseline_rpt_prov
end type

type uo_1 from w_rpt_select_baseline_report_parent`uo_1 within w_rpt_select_baseline_rpt_prov
end type

type cb_reset from w_rpt_select_baseline_report_parent`cb_reset within w_rpt_select_baseline_rpt_prov
integer x = 1033
integer y = 1396
integer taborder = 120
string text = "Re&set"
end type

on cb_reset::clicked;call w_rpt_select_baseline_report_parent`cb_reset::clicked;sle_upins.text = '250'
sle_provspec.text = '100'
sle_provs.text = '40'
sle_procs.text = '25'
sle_specialty.text = ''
sle_specialty2.text = ''

end on

type rb_6 from w_rpt_select_baseline_report_parent`rb_6 within w_rpt_select_baseline_rpt_prov
boolean visible = false
integer y = 1048
boolean enabled = false
end type

type rb_5 from w_rpt_select_baseline_report_parent`rb_5 within w_rpt_select_baseline_rpt_prov
boolean visible = false
integer x = 174
integer y = 1160
boolean enabled = false
end type

type rb_4 from w_rpt_select_baseline_report_parent`rb_4 within w_rpt_select_baseline_rpt_prov
boolean visible = false
integer y = 948
boolean enabled = false
end type

type rb_3 from w_rpt_select_baseline_report_parent`rb_3 within w_rpt_select_baseline_rpt_prov
integer x = 155
integer y = 816
integer height = 84
integer taborder = 70
string text = ""
end type

on rb_3::clicked;call w_rpt_select_baseline_report_parent`rb_3::clicked;//sle_specialty.visible = true
//sle_specialty.enabled = true
end on

type rb_2 from w_rpt_select_baseline_report_parent`rb_2 within w_rpt_select_baseline_rpt_prov
integer x = 155
integer y = 632
integer height = 84
string text = ""
end type

on rb_2::clicked;call w_rpt_select_baseline_report_parent`rb_2::clicked;//sle_specialty.visible = false  //01-12-95 FNC
//sle_specialty.enabled = false  //01-12-95 FNC

end on

type rb_1 from w_rpt_select_baseline_report_parent`rb_1 within w_rpt_select_baseline_rpt_prov
integer x = 155
integer y = 448
integer height = 84
string text = ""
end type

on rb_1::clicked;call w_rpt_select_baseline_report_parent`rb_1::clicked;//sle_specialty.visible = false  //01-12-95 FNC
//sle_specialty.enabled = false  //01-12-95 FNC
end on

type cb_close from w_rpt_select_baseline_report_parent`cb_close within w_rpt_select_baseline_rpt_prov
integer x = 1966
integer y = 1392
integer taborder = 130
end type

type cb_create_report from w_rpt_select_baseline_report_parent`cb_create_report within w_rpt_select_baseline_rpt_prov
integer x = 101
integer y = 1396
integer taborder = 110
string text = "Create &Report..."
end type

on cb_create_report::clicked;call w_rpt_select_baseline_report_parent`cb_create_report::clicked;//*******************************************************************
//05-04-94 FNC Add option for user to specify limit for report
//*******************************************************************

string lv_limit,lv_parm,lv_title,lv_specialty = ''


if parent_ok = false then
    return
end if

if rb_1.checked = true then
    gv_report_id = 'd_rpt_top_250_prov_upins'
    if integer(sle_upins.text) > 250 then
     	 messagebox('ERROR','Cannot select more than 250 Provider UPINS for this report',stopsign!,OK!)
       return
    else
       lv_limit = " AND RANK <= " + sle_upins.text
    end if
    lv_title = "TOP " + sle_upins.text + " PROVIDER UPINS"
    lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title
elseif rb_2.checked = true then
    gv_report_id = 'd_rpt_top_100_provs_upin_spec'
    if integer(sle_provspec.text) > 100 then
     	 messagebox('ERROR','Cannot select more than 100 Provider UPINS for this report',stopsign!,OK!)
       return
    else
       lv_limit = " AND RANK <= " + sle_provspec.text
    end if
    lv_title = "TOP " + sle_provspec.text + " PROVIDER UPINS WITHIN SPECIALTY, SORTED BY SPECIALTY" 
    if sle_specialty2.text = ''  or sle_specialty2.text = ' ' then
	     messagebox('EDIT','Must enter a % to select all specialties')
        return
    else
        lv_specialty = sle_specialty2.text 
    end if
    lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title + "~t" + lv_specialty
elseif rb_3.checked = true then
    gv_report_id = 'd_rpt_top_40_prov_top_25_proc'
    if integer(sle_provs.text) > 40 then
     	 messagebox('ERROR','Cannot select more than 40 Providers for this report',stopsign!,OK!)
       return
    else
       lv_limit = " AND RANK3 <= " + sle_provs.text
    end if
    if integer(sle_procs.text) > 25 then
     	 messagebox('ERROR','Cannot select more than 25 Procedures for this report',stopsign!,OK!)
       return
    else
       lv_limit = lv_limit + " AND RANK2 <= " + sle_procs.text
    end if
    lv_title = "TOP " +sle_provs.text + " PROVIDER UPINS UTILIZING THE TOP " + &
          sle_procs.text + " PROCEDURES WITHIN SPECIALTY"
    if sle_specialty.text = ''  or sle_specialty.text = ' ' then
	     messagebox('ERROR','Must enter a % to select all specialties')
        return
    else
        lv_specialty = sle_specialty.text 
    end if
    lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title + "~t" + lv_specialty
else
    SetMicroHelp(w_rpt_select_baseline_rpt_prov,'List Cancelled')
	 messagebox('ERROR','Must Select a Report!',stopsign!,OK!)
	 return
end if

OpenSheetwithparm(w_rpt_display_baseline_report,lv_parm,MDI_Main_Frame,Help_Menu_Position,Layered!)

rb_4.visible = false
rb_5.visible = false
rb_6.visible = false
end on

type gb_1 from w_rpt_select_baseline_report_parent`gb_1 within w_rpt_select_baseline_rpt_prov
integer x = 110
integer height = 1044
end type

type sle_specialty from singlelineedit within w_rpt_select_baseline_rpt_prov
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = textrole!
integer x = 2405
integer y = 812
integer width = 197
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_3.checked = true
end on

type sle_upins from singlelineedit within w_rpt_select_baseline_rpt_prov
string accessiblename = "Number of Top UPINs"
string accessibledescription = "Number of Top UPINs"
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 440
integer width = 155
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
string text = "250"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_1.checked = true
end on

type sle_provspec from singlelineedit within w_rpt_select_baseline_rpt_prov
string accessiblename = "Provider Specialty"
string accessibledescription = "Provider Specialty"
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 628
integer width = 155
integer height = 88
integer taborder = 50
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

on getfocus;rb_2.checked = true
end on

type sle_provs from singlelineedit within w_rpt_select_baseline_rpt_prov
string accessiblename = "Number of Top Providers"
string accessibledescription = "Number of Top Providers"
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 812
integer width = 155
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
string text = "40"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_3.checked = true
end on

type sle_procs from singlelineedit within w_rpt_select_baseline_rpt_prov
string accessiblename = "Procedures"
string accessibledescription = "Procedures"
accessiblerole accessiblerole = textrole!
integer x = 1385
integer y = 812
integer width = 137
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
string text = "25"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_3.checked = true
end on

type st_4 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Procedures Within Specialty"
string accessibledescription = "Procedures Within Specialty"
accessiblerole accessiblerole = statictextrole!
integer x = 1541
integer y = 828
integer width = 841
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
string text = "Procedures Within Specialty"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_specialty2 from singlelineedit within w_rpt_select_baseline_rpt_prov
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = textrole!
integer x = 1495
integer y = 628
integer width = 247
integer height = 88
integer taborder = 60
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

on getfocus;rb_2.checked = true
end on

type st_3 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Sorted by Specialty"
string accessibledescription = "Sorted by Specialty"
accessiblerole accessiblerole = statictextrole!
integer x = 1769
integer y = 644
integer width = 608
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
string text = "Sorted by Specialty"
boolean focusrectangle = false
end type

type st_1 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Provider UPINS"
string accessibledescription = "Provider UPINS"
accessiblerole accessiblerole = statictextrole!
integer x = 677
integer y = 456
integer width = 475
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
string text = "Provider UPINS"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 334
integer y = 456
integer width = 133
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
boolean focusrectangle = false
end type

type st_6 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Providers Within Specialty"
string accessibledescription = "Providers Within Specialty"
accessiblerole accessiblerole = statictextrole!
integer x = 677
integer y = 644
integer width = 805
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
string text = "Providers Within Specialty"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 334
integer y = 644
integer width = 133
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
boolean focusrectangle = false
end type

type st_8 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Providers Utilizing Top"
string accessibledescription = "Providers Utilizing Top"
accessiblerole accessiblerole = statictextrole!
integer x = 677
integer y = 828
integer width = 695
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
string text = "Providers Utilizing Top"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_rpt_select_baseline_rpt_prov
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 334
integer y = 828
integer width = 133
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
boolean focusrectangle = false
end type

