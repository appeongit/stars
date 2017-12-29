HA$PBExportHeader$w_rpt_display_baseline_report.srw
$PBExportComments$Inherited from w_master
forward
global type w_rpt_display_baseline_report from w_master
end type
type st_row_count from statictext within w_rpt_display_baseline_report
end type
type cb_1 from u_cb within w_rpt_display_baseline_report
end type
type dw_1 from u_dw within w_rpt_display_baseline_report
end type
end forward

global type w_rpt_display_baseline_report from w_master
string accessiblename = "Standard Analysis Report"
string accessibledescription = "Standard Analysis Report"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 8
integer width = 2725
integer height = 1696
string title = "Standard Analysis Report"
long backcolor = 67108864
st_row_count st_row_count
cb_1 cb_1
dw_1 dw_1
end type
global w_rpt_display_baseline_report w_rpt_display_baseline_report

type variables
string in_limit,in_select,in_specialty
string iv_invoice_type
string iv_new_table_name
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct
String parms
end variables

forward prototypes
public function integer update_where_specialty ()
public function integer update_where_limit ()
end prototypes

public function integer update_where_specialty ();//***********************************************************************************
// 04/06/99 FNC	FS/TS 1839D Stardev track 1839
//						Allow user to enter a portion of a speciality followed by a % sign.
// 04/15/99 Archana FS/TS 2096C
//***********************************************************************************

string lv_select,lv_select_stmt,lv_in,spec[20],lv_order_by
string ls_last_value
integer spec_nbr,lv_pos,index,rc,li_spec_len

lv_select_stmt = UPPER(dw_1.getsqlselect()) 
lv_pos = pos(lv_select_stmt,"ORDER")
if lv_pos > 0 then
    lv_select  = Mid(lv_select_stmt,1,lv_pos - 1)
    lv_order_by  = Mid(lv_select_stmt,lv_pos)
else
    lv_select = lv_select_stmt
end if

//if in_specialty = '%' then				// FNC 04/06/99 Start
li_spec_len = len(in_specialty)
ls_last_value = mid(in_specialty,li_spec_len,1)
if ls_last_value = '%' then				// FNC 04/06/99 End
//    in_select = lv_select + " AND " +  iv_new_table_name + ".CODE1 like '" + in_specialty + &
//                "'" + lv_order_by
    in_select = lv_select + " AND " +  iv_new_table_name + ".CODE1 like '" + in_specialty + &
                "' " + lv_order_by

    return 0
end if 

lv_pos = pos(in_specialty,",")

//If only one specialty
if lv_pos = 0 then
//    in_select = lv_select + " AND " +  iv_new_table_name + ".CODE1 = '" + in_specialty + &
//                "'" + lv_order_by
    in_select = lv_select + " AND " +  iv_new_table_name + ".CODE1 = '" + in_specialty + &
                "' " + lv_order_by

    return 0
end if

//If multiple specialties must construct IN clause
spec_nbr = 1
Do until in_specialty = ''
    if spec_nbr > 20 then
       exit
    end if
    if (lv_pos <> 0) then
       spec[spec_nbr] = Mid(in_specialty,1,lv_pos - 1)
       in_specialty = Mid(in_specialty,lv_pos + 1)
       lv_pos = pos(in_specialty,",")
       spec_nbr = spec_nbr + 1
   else
       spec[spec_nbr] = in_specialty
       in_specialty = ''
   end if   
Loop

index = 1
lv_in =  " AND " + iv_new_table_name + ".CODE1 IN ('" + spec[index] + "'"
index = 2 
do while index <= spec_nbr
   lv_in =  lv_in + ",'" + spec[index] + "'"
   index = index + 1
loop
 
//in_select = lv_select + lv_in + ")" + lv_order_by
in_select = lv_select + lv_in + ") " + lv_order_by
return 0   
end function

public function integer update_where_limit ();string lv_select,lv_select_stmt,lv_order_by
integer lv_pos
//Archana 4-15-99 FS/TS2096c

lv_select_stmt = UPPER(dw_1.getsqlselect())
lv_pos = pos(lv_select_stmt,"ORDER")
if lv_pos > 0 then
    lv_select  = Mid(lv_select_stmt,1,lv_pos - 1)
    lv_order_by  = Mid(lv_select_stmt,lv_pos)
else
    lv_select = lv_select_stmt
end if

//in_select = lv_select + in_limit + lv_order_by   Archana
in_select = lv_select + in_limit + ' ' + lv_order_by

return 0   
end function

event open;call super::open;//*************************************************************
//
//	08/02/95	FNC	SWAT effort to display win parm parameters 
//	05/20/94	FNC	Add specialty parameter for top 40 top 25 report
//	05/03/94	FNC	Add parameters for ranking 
//	04/20/00	KTB	Disable graph functionality
//	11/07/02	GaryR	SPR 4770c	Remove obsolete window operations
//	
//*************************************************************

int rc,parm_separator,lv_pos,lv_pos2,lv_len,lv_rc,lv_index
string lv_old_sql, lv_new_sql,lv_old_tbl_name,lv_new_tbl_name
string temp_select,stringrc,lv_rank,lv_title
string lv_sel,lv_base_type,lv_fiscyear,lv_proc_year
string lv_where, lv_window_name
int lv_rows
long lv_nbr_rows

//User can specify a limit so must adjust title of report to reflect
//limit in addition If user running report Top 40 Providers Utilizing Top 25 Procedures
// can specify specialty and a limit so must separate them

Parm_Separator = Pos(parms,'~t')
if Parm_Separator = 0 then
    in_limit = parms
else
    in_limit = Mid(parms,1,parm_separator - 1)
    parms = Mid(parms,parm_separator   + 1)
end if

Parm_Separator = Pos(parms,'~t')
If Parm_separator = 0 then
	iv_invoice_type = parms
Else
	iv_invoice_type = Mid(parms,1,parm_separator - 1)
   parms = Mid(parms,parm_separator +1)
end if

Parm_Separator = Pos(parms,'~t')
if Parm_Separator = 0 then
    lv_title = parms
else
    lv_title = Mid(parms,1,parm_separator - 1)
    in_specialty = Mid(parms,parm_separator   + 1)
end if

//sqlcmd('Connect',stars1ca,'Error Connecting to the database',5)     PLB 10/20/95
//sqlcmd('Connect',stars2ca,'Error Connecting to the database',5)   PLB 10/20/95

SELECT SYS_CNTL.CNTL_TEXT  
  INTO :lv_fiscyear  
  FROM SYS_CNTL  
  WHERE SYS_CNTL.CNTL_ID = 'FISCYEAR'   
Using Stars2ca;

Select col_name
Into :lv_new_tbl_name
From Stars_win_parm
Where cntl_id = Upper( :gv_report_id ) and tbl_type = Upper( :iv_invoice_type )
Using Stars2ca;

//08-02-95 FNC


if stars2ca.of_check_status() = 100 then
//	sqlcmd('DisConnect',stars1ca,'Error DisConnecting to the database',5)     PLB 10/20/95
COMMIT using STARS1CA;
If stars1ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
//	sqlcmd('DisConnect',stars2ca,'Error DisConnecting to the database',5)     PLB 10/20/95
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
//	sqlcmd('DisConnect',stars1ca,'Error DisConnecting to the database',5)     PLBb 10/20/95
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   lv_where = ' cntl_id = ' + gv_report_id + &
              ' and tbl_type = ' + iv_invoice_type
	errorbox(stars2ca,'Error reading Stars Win Parm table.' + lv_where)
	return
end if

//sqlcmd('DisConnect',stars2ca,'Error DisConnecting to the database',5)     PLB 10/20/95
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

//*****************************************************************//
// select the description of the period to add to the report title //
//*****************************************************************//

SELECT period_desc
INTO   :lv_proc_year
FROM   period_cntl
WHERE  period = :gv_report_period and
       FUNCTION_NAME = 'SARS' and
       invoice_type = Upper( :iv_invoice_type )
USING  stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Error', 'Error selecting description from period_cntl')
	Return
else
	Commit using stars2ca;
end if

Reset(dw_1)

/*Connects to datawindow and retrieves number of rows*/

dw_1.dataobject = gv_report_id
SetTransObject(dw_1,stars1ca) 
//fx_set_window_colors(w_rpt_display_baseline_report)

//KMM 7/11/95 Read invisible datawindow for base type 
lv_rc = w_main.dw_stars_rel_dict.Setfilter('')
lv_rc = w_main.dw_stars_rel_dict.Filter()
lv_sel = "rel_type = 'QT' and id_2 = '" + iv_invoice_type + "'" 
lv_rc = w_main.dw_stars_rel_dict.Setfilter(lv_sel)
lv_rc = w_main.dw_stars_rel_dict.filter()
lv_rows = w_main.dw_stars_rel_dict.rowcount()
if lv_rows > 1 then
	messagebox('Error','Retrieved more than one row from Stars Rel.')
//	sqlcmd('DisConnect',stars1ca,'Error DisConnecting to the database',5)    PLB 010/20/95
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	return
elseif lv_rows <= 0 then
	messagebox('Error','Retrieved 0 rows from Stars Rel.')
//	sqlcmd('DisConnect',stars1ca,'Error DisConnecting to the database',5)     PLB 10/20/95
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	return
else
	lv_base_type = w_main.dw_stars_rel_dict.getitemstring(1,'key6')
end if
//KMM END

SetTransObject(dw_1,stars1ca) 
lv_old_sql = dw_1.GetSQLSelect()
lv_pos = pos(lv_old_sql,'FROM')
lv_pos2 = pos(lv_old_sql,'WHERE')
lv_len = lv_pos2 - lv_pos
iv_new_table_name = lv_new_tbl_name //EK 04-20-95
lv_new_tbl_name = 'FROM ' + lv_new_tbl_name + ' '
lv_new_sql = replace(lv_old_sql,lv_pos,lv_len,lv_new_tbl_name)
//lv_rc = dw_1.SetSQLSelect(lv_new_sql)
temp_select = "datawindow.table.select = ~"" + lv_new_sql + "~""
stringrc = dw_1.Modify(temp_select)

clipboard('')
clipboard(lv_new_sql)

if in_specialty <> '' then
    update_where_specialty()
    temp_select = "datawindow.table.select = ~"" + in_select + "~""
    stringrc = dw_1.Modify(temp_select)
end if

if trim(in_limit) <> '' then 
   update_where_limit()
   temp_select = "datawindow.table.select = ~"" + in_select + "~""
   stringrc = dw_1.Modify(temp_select)
   stringrc = dw_1.Modify('title1.text = ~'' + lv_title + '~'')
end if

SetTransObject(dw_1,stars1ca) 
lv_nbr_rows = Retrieve(dw_1,gv_report_year,gv_prev_year,gv_report_period,lv_proc_year)

This.Event	ue_set_window_colors (This.Control)		//	3-6-98 Archana

If lv_nbr_rows = 0 Then
//	sqlcmd('disconnect',stars1ca,'Error disconnecting from the database',1)     PLB 10/20/95
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

st_row_count.TEXT = string(lv_nbr_rows)

in_specialty = ''
SetMicroHelp(w_main,'Ready')

// KTB 04-20-00 - Starcare Track 2494
m_stars_30.m_reporting.m_graph.Enabled = FALSE
// End KTB

//sqlcmd('disconnect',stars1ca,'Error disconnecting from the database',1)     PLB 10/20/95
COMMIT using STARS1CA;
If stars1ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	


end event

on w_rpt_display_baseline_report.create
int iCurrent
call super::create
this.st_row_count=create st_row_count
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_row_count
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_rpt_display_baseline_report.destroy
call super::destroy
destroy(this.st_row_count)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;parms = message.Stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

event close;call super::close;// KTB - 04/20/00 - Starcare Track 2494 - Enable graph functionality
m_stars_30.m_reporting.m_graph.Enabled = TRUE
// End KTB

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

type st_row_count from statictext within w_rpt_display_baseline_report
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 5
integer y = 1488
integer width = 274
integer height = 80
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

type cb_1 from u_cb within w_rpt_display_baseline_report
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2336
integer y = 1476
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Close"
boolean default = true
end type

on clicked;Close(parent)
end on

type dw_1 from u_dw within w_rpt_display_baseline_report
string accessiblename = "Baseline Report"
string accessibledescription = "Baseline Report"
accessiblerole accessiblerole = clientrole!
string tag = "listdatawindow,CRYSTAL, title = Baseline Report"
integer x = 5
integer y = 4
integer width = 2670
integer height = 1464
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
end type

on doubleclicked;//////Script for W_case_list doubleclicked for dw_1
//////////////////////////////////////////////////////////////////////////
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
//		If in_dw_control = 'FILTER' Then
//				ddlb_dw_ops.triggerevent(selectionchanged!)
//				lv_row_nbr = getclickedrow(dw_1)
//				lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
//				rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
//		ElseIf in_dw_control = 'FIND' Then
//				ddlb_dw_ops.triggerevent(selectionchanged!)
//				lv_row_nbr = getclickedrow(dw_1)
//				lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
//				rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
//		End If
//End If
end on

event rowfocuschanged;long row_nbr,clicked_row, rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
row_nbr = getrow(dw_1)
//Highlights the current row
rc = SelectRow(dw_1,0,FALSE)
rc = SelectRow(dw_1,row_nbr,TRUE)




end event

