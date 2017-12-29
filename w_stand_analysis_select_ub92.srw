HA$PBExportHeader$w_stand_analysis_select_ub92.srw
$PBExportComments$Inherited from w_rpt_select_baseline_report_parent
forward
global type w_stand_analysis_select_ub92 from w_rpt_select_baseline_report_parent
end type
type ddlb_report_type from dropdownlistbox within w_stand_analysis_select_ub92
end type
type dw_1 from u_dw within w_stand_analysis_select_ub92
end type
type st_1 from statictext within w_stand_analysis_select_ub92
end type
end forward

global type w_stand_analysis_select_ub92 from w_rpt_select_baseline_report_parent
string accessiblename = "Standard Analysis Report Selection"
string accessibledescription = "Standard Analysis Report Selection"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
integer x = 91
integer y = 124
integer height = 1668
ddlb_report_type ddlb_report_type
dw_1 dw_1
st_1 st_1
end type
global w_stand_analysis_select_ub92 w_stand_analysis_select_ub92

type variables
int iv_maxpat, iv_maxprov, iv_maxrev
sx_baseln_rpt_ub92 out_parms

window	iv_temp_win		//DKG 04/12/96

end variables

forward prototypes
public function integer wf_patient ()
public function integer wf_provider ()
public function integer wf_revenue ()
public function integer wf_decode_tables_com (string arg_tbl_string, ref string tbl_array[])
end prototypes

public function integer wf_patient ();dw_1.DataObject = "d_patient_ub92"

//DKG 04/12/96 BEGIN
This.Event	ue_set_window_colors(This.Control)
//DKG 04/12/96 END

dw_1.InsertRow(0)

dw_1.SetItem(1,"patients","250")

Return 1



end function

public function integer wf_provider ();dw_1.DataObject = "d_provider_ub92"

//DKG 04/12/96 BEGIN
This.Event	ue_set_window_colors(This.Control)
//DKG 04/12/96 END

dw_1.InsertRow(0)

dw_1.SetItem(1,"rb_1","Provider1")
dw_1.SetItem(1,"providers1_sle","40")
dw_1.SetItem(1,"providers2_sle","250")
dw_1.SetItem(1,"hcpcs_sle","25")

Return 1
end function

public function integer wf_revenue ();dw_1.DataObject = "d_revenue_ub92"

//DKG 04/12/96 BEGIN
This.Event	ue_set_window_colors(This.Control)
//DKG 04/12/96 END

dw_1.InsertRow(0)

dw_1.SetItem(1,"rb_1","HCPCS")
dw_1.SetItem(1,"hcpcs_sle","100")
dw_1.SetItem(1,"revenue_sle","100")

Return 1
end function

public function integer wf_decode_tables_com (string arg_tbl_string, ref string tbl_array[]);// Script for wf_decode_tables_com
//**************************************************************
//Created 02-28-95 PLB This function will decode a string sent
//                 as a parm and place it into an array
// FNC	08/27/98	Track 1619. Make global function into a window function
//						because this is the only window using function and there is
//						a problem calling the function in the executable.
//**************************************************************

//04-24-95 EK - changed "+" - separator to ","

int lv_pos,lv_cnt
string lv_string,lv_tbl

setpointer(hourglass!)

lv_string = arg_tbl_string
Do While len(lv_string) > 0
	lv_cnt = lv_cnt + 1
	lv_pos = pos(lv_string,',')
	If lv_pos = 0 Then
		tbl_array[lv_cnt] = lv_string
		lv_string = ''
	Else
		lv_tbl = left(lv_string,lv_pos - 1)
		tbl_array[lv_cnt] = lv_tbl
	   lv_string = Mid(lv_string,lv_pos + 1)
	End If
Loop

Return 0
end function

event open;call super::open;int Parm_Separator
string lv_parm
string lv_invoice_type

if ib_need_to_close_down then   // jsb 01-28-02  Track 2469
	close(this)                  // jsb 01-28-02  Track 2469
	return                       // jsb 01-28-02  Track 2469
end if                          // jsb 01-28-02  Track 2469

//DKG 04/12/96 BEGIN
iv_temp_win = this
//DKG 04/12/96 END

ddlb_report_type.SelectItem(1)
ddlb_report_type.TriggerEvent(SelectionChanged!)

end event

on w_stand_analysis_select_ub92.create
int iCurrent
call super::create
this.ddlb_report_type=create ddlb_report_type
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_report_type
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_1
end on

on w_stand_analysis_select_ub92.destroy
call super::destroy
destroy(this.ddlb_report_type)
destroy(this.dw_1)
destroy(this.st_1)
end on

type st_period from w_rpt_select_baseline_report_parent`st_period within w_stand_analysis_select_ub92
end type

type uo_1 from w_rpt_select_baseline_report_parent`uo_1 within w_stand_analysis_select_ub92
end type

type cb_reset from w_rpt_select_baseline_report_parent`cb_reset within w_stand_analysis_select_ub92
integer x = 1088
integer y = 1408
integer taborder = 50
string text = "Re&set"
end type

on cb_reset::clicked;ddlb_report_type.TriggerEvent(SelectionChanged!)
end on

type rb_6 from w_rpt_select_baseline_report_parent`rb_6 within w_stand_analysis_select_ub92
boolean visible = false
integer taborder = 120
end type

type rb_5 from w_rpt_select_baseline_report_parent`rb_5 within w_stand_analysis_select_ub92
boolean visible = false
integer taborder = 100
end type

type rb_4 from w_rpt_select_baseline_report_parent`rb_4 within w_stand_analysis_select_ub92
boolean visible = false
integer taborder = 90
end type

type rb_3 from w_rpt_select_baseline_report_parent`rb_3 within w_stand_analysis_select_ub92
boolean visible = false
integer x = 114
integer taborder = 60
end type

type rb_2 from w_rpt_select_baseline_report_parent`rb_2 within w_stand_analysis_select_ub92
boolean visible = false
integer taborder = 50
end type

type rb_1 from w_rpt_select_baseline_report_parent`rb_1 within w_stand_analysis_select_ub92
boolean visible = false
integer taborder = 40
end type

type cb_close from w_rpt_select_baseline_report_parent`cb_close within w_stand_analysis_select_ub92
integer x = 2085
integer y = 1404
integer taborder = 60
end type

type cb_create_report from w_rpt_select_baseline_report_parent`cb_create_report within w_stand_analysis_select_ub92
integer x = 101
integer y = 1408
integer taborder = 40
string text = "Create &Report"
end type

event cb_create_report::clicked;//********************************************************************************
//
//		w_stand_analysis_select_ub92.cb_create_report
//
//********************************************************************************
// FNC	08/27/98	Track 1619. Make global function into a window function
//						because this is the only window using function and there is
//						a problem calling the function in the executable.
//	FDG	03/12/02	Track 2869d.  Oracle does not allow an empty string in the where clause.
//	FDG	03/22/02	Also allow for empty revenue codes (via server summaries) in the data.
//********************************************************************************
string lv_cal_04
string lv_tob,lv_exclrev
int    lv_rank1,lv_rank2
long   ll_period
int	 li_rc			// FDG 03/12/02

parent_ok = True
setpointer(hourglass!)
setmicrohelp(w_main,'Creating report...')

ll_period = uo_1.uf_return_period()
gv_report_period = ll_period

out_parms.period = ll_period

dw_1.AcceptText()

CHOOSE CASE dw_1.dataobject

 CASE "d_revenue_ub92"
    CHOOSE CASE dw_1.GetItemString(1,"rb_1")  

       CASE "HCPCS" 
         out_parms.report = 1
         lv_rank1 = Integer(dw_1.GetItemString(1,"hcpcs_sle"))          
         if lv_rank1 <= 100 AND lv_rank1 > 0 then 
           out_parms.rank1 = lv_rank1
         else
           MessageBox("EDIT","Rank of HCPCS should be > 0 and <= 100")       
           Return
         end if 
         lv_tob = Trim(dw_1.GetItemString(1,"tob1"))
         if lv_tob <> "" then 
           out_parms.tob = lv_tob
         else
           MessageBox("EDIT","Please enter %-sign for TOB if you want all TOBs")       
           Return
         end if 
         out_parms.dw = "d_100_hcpcs_wn_tob_by_billchg"

        CASE "Revenue"
         out_parms.report = 2
         lv_rank1 = Integer(dw_1.GetItemString(1,"revenue_sle"))          
         if lv_rank1 <= 100 AND lv_rank1 > 0 then 
           out_parms.rank1 = lv_rank1
         else
           MessageBox("EDIT","Rank of Revenue Codes should be > 0 and <= 100")       
           Return
         end if 
         lv_tob = Trim(dw_1.GetItemString(1,"tob2"))
         if lv_tob <> "" then 
           out_parms.tob = lv_tob
         else
           MessageBox("EDIT","Please enter %-sign for TOB if you want all TOBs")       
           Return
         end if 
         
         out_parms.dw = "d_100_revcodes_wn_tob_by_billchg"    
         lv_exclrev = Trim(dw_1.GetItemString(1,"revenue_exclrev_sle"))
         if lv_exclrev <> "" and lv_exclrev <> " " then
           wf_decode_tables_com(lv_exclrev,out_parms.revexcl)		// FNC 08/27/98
         else
				//	FDG 03/12/02 - Don't include an empty string for Oracle
				// FDG 03/22/02 - Give it a bogus value in case there are empty
				//						revenue codes in the data.
           out_parms.revexcl[1] = "$^"
			  li_rc	=	gnv_sql.of_TrimData (out_parms.revexcl[1])
			  // FDG 03/12/02 end
         end if

     END CHOOSE
     out_parms.tbl_type = 'U1'
CASE "d_provider_ub92"
    CHOOSE CASE dw_1.GetItemString(1,"rb_1")    
                  
      CASE "Provider1"
         out_parms.report = 3
         out_parms.tbl_type = 'U2'  
         lv_rank1 = Integer(dw_1.GetItemString(1,"providers1_sle"))          
         if lv_rank1 <= 100 AND lv_rank1 > 0 then 
           out_parms.rank1 = lv_rank1
         else
           MessageBox("EDIT","Rank of Providers should be > 0 and <= 100")       
           Return
         end if 
         lv_rank2 = Integer(dw_1.GetItemString(1,"hcpcs_sle"))          
         if lv_rank2 <= 25 AND lv_rank2 > 0 then 
           out_parms.rank2 = lv_rank2
         else
           MessageBox("EDIT","Rank of HCPCS should be > 0 and <= 25")       
           Return
         end if 
         lv_tob = Trim(dw_1.GetItemString(1,"tob1"))
         if lv_tob <> "" then 
           out_parms.tob = lv_tob
         else
           MessageBox("EDIT","Please enter %-sign for TOB if you want all TOBs")       
           Return
         end if 
         out_parms.dw = "d_40_provs_util_25_hcpcs_wn_tob"
       
      CASE "Provider2"
         out_parms.tbl_type = 'U4'
         out_parms.report = 5
         lv_rank1 = Integer(dw_1.GetItemString(1,"providers2_sle"))          
         if lv_rank1 <= 250 AND lv_rank1 > 0 then 
           out_parms.rank1 = lv_rank1
         else
           MessageBox("EDIT","Rank of Providers should be > 0 and <= 250")       
           Return
         end if 
         lv_tob = Trim(dw_1.GetItemString(1,"tob2"))
         if lv_tob <> "" then 
           out_parms.tob = lv_tob
         else
           MessageBox("EDIT","Please enter %-sign for TOB if you want all TOBs")       
           Return
         end if 
         out_parms.dw = "d_250_provs_wn_tob_by_billchg"     

    END CHOOSE 
 CASE "d_patient_ub92"
         out_parms.tbl_type = 'U3'   
         out_parms.report = 4
         lv_rank1 = Integer(dw_1.GetItemString(1,"patients"))          
         if lv_rank1 <= 250 AND lv_rank1 > 0 then 
           out_parms.rank1 = lv_rank1
         else
           MessageBox("EDIT","Rank of Patients should be > 0 and <= 250")       
           Return
         end if 
			// FDG 11/20/00 - This d/w object does not need to be changed because
			//	the open event of w_rpt_display_baseline_ub92 dynamically changes
			//	the SQL for this d/w
         out_parms.dw = "d_250_pats_by_billchg"      

END CHOOSE

OpenSheetWithParm(w_rpt_display_baseline_ub92,out_parms,MDI_Main_Frame,Help_Menu_Position,Layered!)
end event

type gb_1 from w_rpt_select_baseline_report_parent`gb_1 within w_stand_analysis_select_ub92
integer width = 2583
integer height = 1096
end type

type ddlb_report_type from dropdownlistbox within w_stand_analysis_select_ub92
string accessiblename = "Report Type"
string accessibledescription = "Report Type"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 1879
integer y = 92
integer width = 608
integer height = 240
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long backcolor = 1073741824
boolean vscrollbar = true
string item[] = {"Patient","Provider","Rev/HCPCS"}
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;if ddlb_report_type.Text = 'Patient'  then
 wf_patient()
end if

if ddlb_report_type.Text = 'Provider'  then
 wf_provider()
end if

if ddlb_report_type.Text = 'Rev/HCPCS'  then
 wf_revenue()
end if





end on

type dw_1 from u_dw within w_stand_analysis_select_ub92
string accessiblename = "Standard Analysis Report Criteria"
string accessibledescription = "Standard Analysis Report Criteria"
accessiblerole accessiblerole = clientrole!
integer x = 105
integer y = 340
integer width = 2510
integer height = 868
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_revenue_ub92"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;string column_name
int column_num


//column_num = dw_1.GetClickedColumn()
column_name = dw_1.GetColumnName()


dw_1.SetColumn(column_name)



CHOOSE CASE column_name

 CASE "hcpcs_sle","tob1","providers1_sle"
  w_main.SetMicroHelp("Ready")
  if ddlb_report_type.Text = "Provider" then
   dw_1.SetItem(1,"rb_1","Provider1")
  else 
   dw_1.SetItem(1,"rb_1","HCPCS")
  end if

 CASE "providers2_sle","tob2","revenue_sle","revenue_exclrev_sle"
  w_main.SetMicroHelp("Ready")
  if ddlb_report_type.Text = "Provider" then
   dw_1.SetItem(1,"rb_1","Provider2")
  else
   dw_1.SetItem(1,"rb_1","Revenue")
  end if

 CASE "revenue_exclrev_sle"
  w_main.SetMicroHelp("Enter Revenue Codes, separated by commas")
    
END CHOOSE
end event

type st_1 from statictext within w_stand_analysis_select_ub92
string accessiblename = "Report Type"
string accessibledescription = "Report Type"
accessiblerole accessiblerole = statictextrole!
integer x = 1440
integer y = 92
integer width = 393
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
string text = "Report Type:"
alignment alignment = center!
boolean focusrectangle = false
end type

