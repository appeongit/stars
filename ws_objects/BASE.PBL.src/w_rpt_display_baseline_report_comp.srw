$PBExportHeader$w_rpt_display_baseline_report_comp.srw
$PBExportComments$Inherited from w_master
forward
global type w_rpt_display_baseline_report_comp from w_master
end type
type dw_period_list from u_dw within w_rpt_display_baseline_report_comp
end type
type st_row_count from statictext within w_rpt_display_baseline_report_comp
end type
type cb_1 from u_cb within w_rpt_display_baseline_report_comp
end type
type dw_1 from u_dw within w_rpt_display_baseline_report_comp
end type
end forward

global type w_rpt_display_baseline_report_comp from w_master
string accessiblename = "Standard Analysis Report"
string accessibledescription = "Standard Analysis Report"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 8
integer height = 1692
string title = "Standard Analysis Report"
long backcolor = 67108864
dw_period_list dw_period_list
st_row_count st_row_count
cb_1 cb_1
dw_1 dw_1
end type
global w_rpt_display_baseline_report_comp w_rpt_display_baseline_report_comp

type variables
sx_decode_structure in_decode_struct
string iv_invoice_type
w_uo_win iv_uo_win
string in_selected, in_dw_control
end variables

event open;call super::open;//*********************************************************************
//
//	08/02/95	FNC	SWAT effort to display win parm parameters 
//	04/20/00	KTB	DIsable graph functionality
//	02/06/02	FDG	Track 2799d.  Use column function_name instead of function
//	11/07/02	GaryR	SPR 4770c	Remove obsolete window operations
//
//*********************************************************************

int lv_nbr_rows,lv_pos,lv_pos2,lv_len,rc,lv_rc,lv_index
string lv_new_tbl_name,lv_old_sql,lv_new_sql
string lv_sel, lv_base_type,stringrc,temp_select
string lv_where,lv_fiscyear,lv_proc_year1,lv_proc_year2
int lv_rows
string lv_window_name, ls_desc, ls_prior_desc
long ll_min_days, ll_row_count, ll_row, ll_row_period, ll_days
datetime ld_row_date, ld_current_from

SELECT SYS_CNTL.CNTL_TEXT  
   INTO :lv_fiscyear  
   FROM SYS_CNTL  
   WHERE SYS_CNTL.CNTL_ID = 'FISCYEAR'   
Using Stars2ca;

Stars2ca.of_check_status()

Select col_name
Into :lv_new_tbl_name
From Stars_win_parm
Where cntl_id = Upper( :gv_report_id ) and tbl_type = Upper( :iv_invoice_type )
Using Stars2ca;


if stars2ca.of_check_status() = 100 then
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   lv_where = ' cntl_id = ' + gv_report_id + &
           ' and tbl_type = ' + iv_invoice_type
	messagebox('Error','Error retrieving table name from Stars Win Parm table.' + lv_where)
	return
elseif stars2ca.sqlcode <> 0 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   lv_where = ' cntl_id = ' + gv_report_id + &
           ' and tbl_type = ' + iv_invoice_type
	errorbox(stars2ca,'Error reading Stars Win Parm table.' + lv_where)
	return
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

//*******************************************************************//
// determine the current and prior period descriptions for the title //
//*******************************************************************//

// FDG 02/06/02 - Use function_name instead of function
SELECT period_desc,
       payment_from_date
INTO   :lv_proc_year1,
       :ld_current_from
FROM   period_cntl
WHERE  period = :gv_report_period and
       function_name = 'SARS' and
       invoice_type = Upper( :iv_invoice_type )
USING  stars2ca;

stars2ca.of_check_status()

dw_period_list.Reset()
dw_period_list.SetTransObject(stars2ca)
dw_period_list.Retrieve('SARS', iv_invoice_type, '%')

SetNull(ll_min_days)

ll_row_count = dw_period_list.RowCount()
FOR ll_row = 1 to ll_row_count
	ld_row_date   = dw_period_list.GetItemDatetime(ll_row, 'payment_from_date')
	ll_row_period = dw_period_list.GetItemNumber(ll_row, 'period')
	ls_desc       = dw_period_list.GetItemString(ll_row, 'period_desc')
	ll_days = DaysAfter(date(ld_row_date), date(ld_current_from))
	if (ll_row = 1) and (ll_row_period <> gv_report_period) and (ll_days > 0) then
		ll_min_days = ll_days
		ls_prior_desc = ls_desc
	elseif (ll_row_period <> gv_report_period) and (ll_days > 0) and ((ll_days < ll_min_days) or IsNull(ll_min_days)) then
		ll_min_days = ll_days
		ls_prior_desc = ls_desc
	end if
NEXT

if (ll_min_days <= 0) or IsNull(ll_min_days) then
	lv_proc_year2 = 'UNKNOWN'
else
	lv_proc_year2 = ls_prior_desc
end if

Reset(dw_1)
dw_1.dataobject = gv_report_id
//fx_set_window_colors(w_rpt_display_baseline_report_comp)

//KMM 7/11/95 Read invisible datawindow for base type 
lv_rc = w_main.dw_stars_rel_dict.Setfilter('')
lv_rc = w_main.dw_stars_rel_dict.Filter()
lv_sel = "rel_type = 'QT' and id_2 = '" + iv_invoice_type + "'" 
lv_rc = w_main.dw_stars_rel_dict.Setfilter(lv_sel)
lv_rc = w_main.dw_stars_rel_dict.filter()
lv_rows = w_main.dw_stars_rel_dict.rowcount()
if lv_rows > 1 then
	messagebox('Error','Retrieved more than one row from Stars Rel.')
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	return
elseif lv_rows <= 0 then
	messagebox('Error','Retrieved 0 rows from Stars Rel.')
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	return
else
	lv_base_type = w_main.dw_stars_rel_dict.getitemstring(1,'key6')
end if

SetTransObject(dw_1,stars1ca) 

lv_old_sql = dw_1.GetSQLSelect()
lv_pos = pos(lv_old_sql,'FROM')
lv_pos2 = pos(lv_old_sql,'WHERE')
lv_len = lv_pos2 - lv_pos
lv_new_tbl_name = 'FROM ' + lv_new_tbl_name + ' '
lv_new_sql = replace(lv_old_sql,lv_pos,lv_len,lv_new_tbl_name)
rc = dw_1.SetSQLSelect(lv_new_sql)
temp_select = "datawindow.table.select = ~"" + lv_new_sql + "~""
stringrc = dw_1.Modify(temp_select)

clipboard('')
clipboard(lv_new_sql)

SetTransObject(dw_1,stars1ca) 
lv_nbr_rows = Retrieve(dw_1,gv_report_period,lv_proc_year1,lv_proc_year2)
This.Event ue_set_window_colors(this.control)   //3-6-98 Archana

If lv_nbr_rows = 0 Then
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	SetMicroHelp(w_main,'Report Cancelled')
   messagebox('NO DATA','No data for the report specified',INFORMATION!,OK!)
   dw_1.taborder = 0
	cb_1.PostEvent(Clicked!)
   return
end if 
st_row_count.TEXT = STRING(lv_nbr_rows)

// KTB - Starcare Track 2494
m_stars_30.m_reporting.m_graph.Enabled = FALSE
// End KTB

SetMicroHelp(w_main,'Ready')

COMMIT using STARS1CA;
If stars1ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	


end event

on w_rpt_display_baseline_report_comp.create
int iCurrent
call super::create
this.dw_period_list=create dw_period_list
this.st_row_count=create st_row_count
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_period_list
this.Control[iCurrent+2]=this.st_row_count
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_rpt_display_baseline_report_comp.destroy
call super::destroy
destroy(this.dw_period_list)
destroy(this.st_row_count)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;
iv_invoice_type = Message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

event close;call super::close;// KTB - 04/20/00 - Starcare Track 2494 - Enable graph functionality
m_stars_30.m_reporting.m_graph.Enabled = TRUE
// ENd KTB

end event

event ue_postopen;call super::ue_postopen;//*********************************************************************************
// Script Name:	ue_postopen	
//
//	Arguments:		N/A
//
// Returns:			None
//
//	Description:	If the datawindow displays proc code descriptions, get the 
//						proc code descriptions using u_nvo_proc_code.  The code type
//						for procedure code can vary between different invoice types.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
//
//*********************************************************************************

CHOOSE CASE dw_1.DataObject
	CASE	'd_rpt_top_250_proc',					&
			'd_rpt_top_100_proc_spec',				&
			'd_rpt_top_40_proc_top_100_diag',	&
			'd_rpt_fiscal_year_by_proc_2000',	&
			'd_rpt_fiscal_year_by_proc'
		// The summary report has procedure code descriptions.  Call the scripts
		//	to recompute the descriptions since each invoice type can have different
		//	code types for proc_code
		u_nvo_proc_code		lnv_proc
		lnv_proc		=	CREATE	u_nvo_proc_code
		lnv_proc.uf_set_dw (dw_1)
		lnv_proc.uf_set_inv_type (iv_invoice_type)
		lnv_proc.uf_get_descriptions()
		Destroy	lnv_proc
END CHOOSE

end event

type dw_period_list from u_dw within w_rpt_display_baseline_report_comp
boolean visible = false
string accessiblename = "Period List"
string accessibledescription = "Period List"
accessiblerole accessiblerole = clientrole!
integer x = 517
integer y = 1488
integer width = 169
integer height = 80
integer taborder = 40
string dataobject = "d_period_list"
end type

type st_row_count from statictext within w_rpt_display_baseline_report_comp
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 5
integer y = 1488
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_rpt_display_baseline_report_comp
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2354
integer y = 1472
integer width = 338
integer height = 108
integer taborder = 20
string text = "&Close"
boolean default = true
end type

on clicked;Close(parent)
end on

type dw_1 from u_dw within w_rpt_display_baseline_report_comp
string accessiblename = "Baseline Report"
string accessibledescription = "Baseline Report"
accessiblerole accessiblerole = clientrole!
string tag = "listdatawindow,CRYSTAL, title = Baseline Report"
integer x = 5
integer y = 8
integer width = 2688
integer height = 1452
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
end type

on itemchanged;////Script for doubleclicked for dw_1
////////////////////////////////////////////////////////////////////////
//int tabpos,rc,lv_row_nbr,lv_indx,lv_found
//int lv_upper
//string lv_hold_object,lv_col,lv_tbl_type
//string lv_string_width,lv_hold_col_width,lv_col_name
//boolean lv_lookup,lv_found_flag,lv_join
//
//lv_join = FALSE
//
//setpointer(hourglass!)
//lv_hold_object = Getobjectatpointer(dw_1)
//If lv_hold_object = '' then
//	return
//end if
//tabpos = pos (lv_hold_object,"~t")
//lv_col = left(lv_hold_object,(tabpos - 1))
//If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
//	If isvalid(iv_uo_win) = FALSE Then
//		If in_selected <> '1' Then
//			Messagebox('Information','You must select an option from the dropdown Listbox')
//		Else
//			ddlb_dw_ops.triggerevent(selectionchanged!)
//		End If
//	End if      
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
//	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
//Else
//	If in_dw_control = 'FILTER' Then
//			ddlb_dw_ops.triggerevent(selectionchanged!)
//			lv_row_nbr = getclickedrow(dw_1)
//			lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
//			rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
//	ElseIf in_dw_control = 'FIND' Then
//			ddlb_dw_ops.triggerevent(selectionchanged!)
//			lv_row_nbr = getclickedrow(dw_1)
//			lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
//			rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
//	End If
//End If
end on

on rowfocuschanged;int row_nbr,clicked_row, rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
row_nbr = getrow(dw_1)
//Highlights the current row
rc = SelectRow(dw_1,0,FALSE)
rc = SelectRow(dw_1,row_nbr,TRUE)




end on

