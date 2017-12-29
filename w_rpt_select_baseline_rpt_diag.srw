HA$PBExportHeader$w_rpt_select_baseline_rpt_diag.srw
$PBExportComments$Inherited from w_rpt_select_baseline_report_parent
forward
global type w_rpt_select_baseline_rpt_diag from w_rpt_select_baseline_report_parent
end type
type sle_diags from singlelineedit within w_rpt_select_baseline_rpt_diag
end type
type sle_diagcat from singlelineedit within w_rpt_select_baseline_rpt_diag
end type
type sle_procs from singlelineedit within w_rpt_select_baseline_rpt_diag
end type
type sle_procdiagcat from singlelineedit within w_rpt_select_baseline_rpt_diag
end type
type sle_proc_code from singlelineedit within w_rpt_select_baseline_rpt_diag
end type
type st_1 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_3 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_4 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_5 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_6 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_7 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_8 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_9 from statictext within w_rpt_select_baseline_rpt_diag
end type
type st_10 from statictext within w_rpt_select_baseline_rpt_diag
end type
end forward

global type w_rpt_select_baseline_rpt_diag from w_rpt_select_baseline_report_parent
string accessiblename = "Standard Analysis Report  - Diagnosis"
string accessibledescription = "Standard Analysis Report  - Diagnosis"
accessiblerole accessiblerole = windowrole!
string title = "Standard Analysis Report  - Diagnosis"
long backcolor = 67108864
sle_diags sle_diags
sle_diagcat sle_diagcat
sle_procs sle_procs
sle_procdiagcat sle_procdiagcat
sle_proc_code sle_proc_code
st_1 st_1
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
st_10 st_10
end type
global w_rpt_select_baseline_rpt_diag w_rpt_select_baseline_rpt_diag

type variables
string iv_invoice_type
int iv_maxdiag
end variables

event open;call super::open;if ib_need_to_close_down then   // jsb 01-28-02  Track 2469
	close(this)                  // jsb 01-28-02  Track 2469
	return                       // jsb 01-28-02  Track 2469
end if                          // jsb 01-28-02  Track 2469

SELECT cntl_no INTO :iv_maxdiag
	FROM SYS_CNTL
	WHERE cntl_id = 'MAXDIAG'
using stars2ca;

if stars2ca.of_check_status() = 100 Then
	iv_maxdiag = 10
elseif stars2ca.sqlcode <> 0 Then 
	errorbox(stars2ca,'Error reading the sys_cntl table')
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

sle_diags.text = string(iv_maxdiag)


end event

on w_rpt_select_baseline_rpt_diag.create
int iCurrent
call super::create
this.sle_diags=create sle_diags
this.sle_diagcat=create sle_diagcat
this.sle_procs=create sle_procs
this.sle_procdiagcat=create sle_procdiagcat
this.sle_proc_code=create sle_proc_code
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_diags
this.Control[iCurrent+2]=this.sle_diagcat
this.Control[iCurrent+3]=this.sle_procs
this.Control[iCurrent+4]=this.sle_procdiagcat
this.Control[iCurrent+5]=this.sle_proc_code
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.st_7
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_10
end on

on w_rpt_select_baseline_rpt_diag.destroy
call super::destroy
destroy(this.sle_diags)
destroy(this.sle_diagcat)
destroy(this.sle_procs)
destroy(this.sle_procdiagcat)
destroy(this.sle_proc_code)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
end on

event ue_preopen;call super::ue_preopen;
iv_invoice_type = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type st_period from w_rpt_select_baseline_report_parent`st_period within w_rpt_select_baseline_rpt_diag
long backcolor = 67108864
end type

type uo_1 from w_rpt_select_baseline_report_parent`uo_1 within w_rpt_select_baseline_rpt_diag
end type

type cb_reset from w_rpt_select_baseline_report_parent`cb_reset within w_rpt_select_baseline_rpt_diag
integer x = 1038
integer y = 1420
integer taborder = 130
string text = "Re&set"
end type

on cb_reset::clicked;call w_rpt_select_baseline_report_parent`cb_reset::clicked;sle_diagcat.text = '100'
sle_diags.text = string(iv_maxdiag)
sle_procs.text = '40'
sle_procdiagcat.text = '100'
sle_proc_code.text = ''
end on

type rb_6 from w_rpt_select_baseline_report_parent`rb_6 within w_rpt_select_baseline_rpt_diag
boolean visible = false
integer x = 155
integer y = 1200
end type

type rb_5 from w_rpt_select_baseline_report_parent`rb_5 within w_rpt_select_baseline_rpt_diag
integer x = 165
integer y = 1068
integer height = 96
integer taborder = 90
long backcolor = 67108864
string text = ""
end type

type rb_4 from w_rpt_select_baseline_report_parent`rb_4 within w_rpt_select_baseline_rpt_diag
integer x = 165
integer y = 880
integer height = 96
long backcolor = 67108864
string text = ""
end type

type rb_3 from w_rpt_select_baseline_report_parent`rb_3 within w_rpt_select_baseline_rpt_diag
integer x = 165
integer y = 704
integer height = 96
long backcolor = 67108864
string text = ""
end type

type rb_2 from w_rpt_select_baseline_report_parent`rb_2 within w_rpt_select_baseline_rpt_diag
integer x = 165
integer y = 528
integer height = 96
long backcolor = 67108864
string text = ""
end type

type rb_1 from w_rpt_select_baseline_report_parent`rb_1 within w_rpt_select_baseline_rpt_diag
integer x = 165
integer y = 372
long backcolor = 67108864
string text = ""
end type

type cb_close from w_rpt_select_baseline_report_parent`cb_close within w_rpt_select_baseline_rpt_diag
integer x = 1902
integer y = 1420
integer taborder = 140
end type

type cb_create_report from w_rpt_select_baseline_report_parent`cb_create_report within w_rpt_select_baseline_rpt_diag
integer x = 174
integer y = 1420
integer taborder = 120
string text = "Create &Report..."
end type

on cb_create_report::clicked;call w_rpt_select_baseline_report_parent`cb_create_report::clicked;//*******************************************************************
//05-04-94 FNC Add option for user to specify limit for report
//*******************************************************************

string lv_limit,lv_parm,lv_title,lv_proc_code
if parent_ok = false then
    return
end if

if rb_1.checked = true then
    gv_report_id = 'd_rpt_diagcat_cat'
//KMM 7/11/95 Prob#437-441 Set parm to be sent to report screen
	 lv_limit = ' '
	 lv_parm = lv_limit + "~t" + iv_invoice_type
elseif rb_2.checked = true then
    gv_report_id = 'd_rpt_diagcat_rank'
//KMM 7/11/95 Prob#437-441 Set parm to be sent to report screen
	 lv_limit = ''
	 lv_parm = lv_limit + "~t" + iv_invoice_type
elseif rb_3.checked = true then
    gv_report_id = 'd_rpt_diag_top_100_diagcat'
    if integer(sle_diagcat.text) > 100 then
     	 messagebox('ERROR','Cannot select more than 100 Diagnosis Categories for this report',stopsign!,OK!)
       return
    else
       lv_limit = " AND RANK1 <= " + sle_diagcat.text
    end if
    lv_title = "DIAGNOSES WITHIN THE TOP " + sle_diagcat.text + " DIAGNOSIS CATEGORIES"
    lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title 
elseif rb_4.checked = true then
    gv_report_id = 'd_rpt_top_40_proc_top_100_diag'
    if integer(sle_procs.text) > 40 then
     	 messagebox('ERROR','Cannot select more than 40 Procedures for this report',stopsign!,OK!)
       return
    else
       lv_limit = " AND RANK2 <= " + sle_procs.text
    end if
    if integer(sle_procdiagcat.text) > 100 then
     	 messagebox('ERROR','Cannot select more than 100 diagnosis categories for this report',stopsign!,OK!)
       return
    else
       lv_limit = lv_limit + " AND RANK1 <= " + sle_procdiagcat.text
    end if
    lv_title = "TOP " + sle_procs.text + " PROCEDURES WITHIN TOP " + &
           sle_procdiagcat.text + " DIAGNOSIS CATEGORIES"
    lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title
elseif rb_5.checked = true then
    if sle_diags.text = '' or sle_diags.text = ' ' then
       messagebox('ERROR','Must enter a value for diagnosis!',stopsign!,OK!)
       return    
    end if
    if integer(sle_diags.text) > 200 then
     	 messagebox('ERROR','Cannot select more than 200 Diagnoses for this report',stopsign!,OK!)
       return
    end if

    gv_report_id = 'd_rpt_top_200_diag_by_proc_code'
    lv_limit = " AND RANK <= " + sle_diags.text
    If sle_proc_code.text = '' or sle_proc_code.text = ' ' then
      // lv_parm = lv_limit + "~t" + iv_invoice_type + "~t" + lv_title
      MessageBox('EDIT','Please enter % to select all procedure codes')   
      Return
    else
       lv_proc_code =  sle_proc_code.text 
	    lv_title = "TOP " + sle_diags.text + " SORTED BY THE ALLOWED CHARGE"
       lv_parm = lv_limit  + "~t" + iv_invoice_type + "~t" + lv_title+ "~t" + lv_proc_code
    end if
else
    SetMicroHelp(w_rpt_select_baseline_rpt_diag,'List Cancelled')
	 messagebox('ERROR','Must Select a Report!',stopsign!,OK!)
	 return
end if

OpenSheetwithParm(w_rpt_display_baseline_report,lv_parm,MDI_Main_Frame,Help_Menu_Position,Layered!)

rb_6.visible = false
end on

type gb_1 from w_rpt_select_baseline_report_parent`gb_1 within w_rpt_select_baseline_rpt_diag
integer y = 248
integer height = 1088
long backcolor = 67108864
end type

type sle_diags from singlelineedit within w_rpt_select_baseline_rpt_diag
string accessiblename = "Number of Top Diagnoses"
string accessibledescription = "Number of Top Diagnoses"
accessiblerole accessiblerole = textrole!
integer x = 526
integer y = 1064
integer width = 155
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
string text = "200"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_5.checked = true
end on

type sle_diagcat from singlelineedit within w_rpt_select_baseline_rpt_diag
string accessiblename = "Number of Top Diagnosis Categories"
string accessibledescription = "Number of Top Diagnosis Categories"
accessiblerole accessiblerole = textrole!
integer x = 1042
integer y = 704
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

on getfocus;rb_3.checked = true
end on

type sle_procs from singlelineedit within w_rpt_select_baseline_rpt_diag
string accessiblename = "Number of Top Procedures"
string accessibledescription = "Number of Top Procedures"
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 876
integer width = 155
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
string text = "40"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_4.checked = true
end on

type sle_procdiagcat from singlelineedit within w_rpt_select_baseline_rpt_diag
string accessiblename = "Number of Top Diagnosis Categories"
string accessibledescription = "Number of Top Diagnosis Categories"
accessiblerole accessiblerole = textrole!
integer x = 1403
integer y = 876
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
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_4.checked = true
end on

type sle_proc_code from singlelineedit within w_rpt_select_baseline_rpt_diag
string accessiblename = "Procedure Code"
string accessibledescription = "Procedure Code"
accessiblerole accessiblerole = textrole!
integer x = 1627
integer y = 1064
integer width = 247
integer height = 88
integer taborder = 110
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

on getfocus;rb_5.checked = true
end on

type st_1 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Diagnosis Categories by Category"
string accessibledescription = "Diagnosis Categories by Category"
accessiblerole accessiblerole = statictextrole!
integer x = 347
integer y = 384
integer width = 1029
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
string text = "Diagnosis Categories by Category"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Diagnosis Categories by Allowed Charge"
string accessibledescription = "Diagnosis Categories by Allowed Charge"
accessiblerole accessiblerole = statictextrole!
integer x = 347
integer y = 544
integer width = 1289
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
string text = "Diagnosis Categories by Allowed Charge"
boolean focusrectangle = false
end type

type st_4 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Procedures Within Top"
string accessibledescription = "Procedures Within Top"
accessiblerole accessiblerole = statictextrole!
integer x = 690
integer y = 892
integer width = 690
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
string text = "Procedures Within Top"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Diagnosis Categories"
string accessibledescription = "Diagnosis Categories"
accessiblerole accessiblerole = statictextrole!
integer x = 1582
integer y = 892
integer width = 654
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
string text = "Diagnosis Categories"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 347
integer y = 892
integer width = 146
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

type st_7 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = statictextrole!
integer x = 347
integer y = 1080
integer width = 146
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

type st_8 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Diagnosis by Procedure Code"
string accessibledescription = "Diagnosis by Procedure Code"
accessiblerole accessiblerole = statictextrole!
integer x = 709
integer y = 1080
integer width = 896
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
string text = "Diagnosis by Procedure Code"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Diagnosis Within Top"
string accessibledescription = "Diagnosis Within Top"
accessiblerole accessiblerole = statictextrole!
integer x = 347
integer y = 720
integer width = 654
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
string text = "Diagnosis Within Top"
boolean focusrectangle = false
end type

type st_10 from statictext within w_rpt_select_baseline_rpt_diag
string accessiblename = "Diagnosis Categories"
string accessibledescription = "Diagnosis Categories"
accessiblerole accessiblerole = statictextrole!
integer x = 1221
integer y = 720
integer width = 654
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
string text = "Diagnosis Categories"
alignment alignment = right!
boolean focusrectangle = false
end type

