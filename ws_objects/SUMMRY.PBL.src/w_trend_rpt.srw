$PBExportHeader$w_trend_rpt.srw
$PBExportComments$Inherited from w_parent_rpt
forward
global type w_trend_rpt from w_parent_rpt
end type
type cb_more from u_cb within w_trend_rpt
end type
type st_dw_ops from statictext within w_trend_rpt
end type
type dw_period_desc from u_dw within w_trend_rpt
end type
end forward

global type w_trend_rpt from w_parent_rpt
string accessiblename = "Trend Report"
string accessibledescription = "Trend Report"
integer width = 3328
integer height = 2200
string title = "Trend Report - "
cb_more cb_more
st_dw_ops st_dw_ops
dw_period_desc dw_period_desc
end type
global w_trend_rpt w_trend_rpt

type variables
string in_selection,in_proc_code,in_spec,in_gr_where
string in_graph_choice
boolean iv_process_done
long iv_next_group_ct, iv_dw2_row_ct
string iv_sum_type
string iv_sum_tbl_name
string iv_no_of_fields


sx_field iv_fields[]
int iv_var_col[]
int iv_group_col_num
int iv_item_col_num
//w_uo_win iv_uo_win
//string in_selected, in_dw_control
//u_nvo_summary	inv_summ
string is_function
sx_summary_parm istr_parm
string is_group_flg //NLG patient profiles
constant string ics_drugcat = 'DRUG_CAT'
string is_detail_inv_type   // FNC 05/25/00
end variables

forward prototypes
public function int wf_divide_by_zero_check (decimal value_1, decimal value_2, int counter, int col_number)
public function string wf_add_dw_title (ref datawindow dw, string ls_title)
end prototypes

public function int wf_divide_by_zero_check (decimal value_1, decimal value_2, int counter, int col_number);//this function calculates the variances.  If an attempt to divide
//by zero occurs, the variance defaults to 999

decimal lv_var,lv_var_round

if value_1 <> 0 then 
	lv_var = (((value_2 - value_1) * 100)/value_1)
   lv_var_round = round(lv_var,2)
	dw_1.setitem(counter - 1,col_number,lv_var_round)
else
	dw_1.setitem(counter - 1,col_number,999)
end if
return 0
end function

public function string wf_add_dw_title (ref datawindow dw, string ls_title);//*********************************************************************************
// Script Name:	wf_add_dw_title
//
// Arguments:	DataWindow	ref	dw
//					String		value	ls_title
//
// Returns:		String
//
// Description:	Creates the title for the requesting datawindow
//
//*********************************************************************************
//
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

string describe_str, mod_string, dwrc
int font_weight = 700, col_num, i           

setpointer(hourglass!)

mod_string = "datawindow.header.height = 300"
dwrc = dw.Modify(mod_string)
if dwrc <> '' then return dwrc
dw.modify('DataWindow.units = 1')
//  Report Title
mod_string = "create text(band=Header color='" + String( stars_colors.window_text ) + "' alignment='2' border='0'" + &
	"  x='0' y='0' height='16' width= '480' text=~'" + ls_title + "~' " + &
	" name=rpt_hdr_t font.face='System' font.height= '-10' font.weight=~'" + string(font_weight) + &
	"~' font.family='2' font.pitch='2' font.charset='0' font.italic='0' " + &
	" font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + &
	String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Report Title~~"~~t~~"Report Title~~"" accessiblename="~~"Report Title~~"~~t~~"Report Title~~"" accessiblerole=42 ) '
dwrc = dw.Modify(mod_string)
if dwrc <> '' then return dwrc

mod_string = "create text(band=Foreground color='" + String( stars_colors.window_text ) + "' alignment='1' border='0'" + &
	"  x='300' y='0' height='16' width= '480' text=~'" + string(datetime(today(),now())) + "~' " + &
	" name=rpt_hdr_t font.face='System' font.height= '-10' font.weight=~'" + string(font_weight) + &
	"~' font.family='2' font.pitch='2' font.charset='0' font.italic='0' " + &
	" font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + &
	String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Current date and time~~"~~t~~"Current date and time~~"" accessiblename="~~"Current date and time~~"~~t~~"Current date and time~~"" accessiblerole=42 ) '
dwrc = dw.Modify(mod_string)
if dwrc <> '' then return dwrc

return dwrc
end function

event open;//******************************************************************************
//	Override the ancestor
// the open event takes care of parsing the parms passed from the
// summary report and assigning the instance variables used in the
// parent report. This event determines what the table type is
// and determines the variable part of the labels.  Finally it calls
// the open event of the parent report
//******************************************************************************
// 07-17-97 FDG	Since this script overrides w_parent_rpt.open then
//	   				call w_master.open.  Move getting the parm to
//						ue_preopen.  Parm placed into istr_parm
// 04-25-97 MSS 	FS #134 Sort by period instead of billed charges
// 03-20-97 FNC 	Prob #1020 STARCARE Sort by period. It was originally
//						there but then it was commented out. 
// 09-12-96 FNC 	Convert period id into description using an invisible
//						datawindow containing periods and period descriptions
// 08-21-96 FNC 	Call user object function to obtain trend fields
//						instead of global function. Function retrieves an 
//						invisible datawindow on this window.
// 10-20-95 FNC 	Take out connects and disconnects
// 10-11-95 FNC 	Take upperbound out of script
// 10-16-95 FDG 	Connect to Stars2ca before calling labels2
// 01-12-98 JGG 	Replace labels and labels2 global functions with
//             	labels nvo functions.
// 03-12/98 FDG 	Use the query engine service
// 11-30-98 NLG	Implement Archana's ts341
// 01-06-99 NLG	TS341a Fix labels for computed columns for dynamic group by
// 11/01/00	GaryR	2920c	Standardize windows colors
// 11/17/00	GaryR	Stars 4.7 DataBase Port - Conversion of data types
// 03/18/01 FDG	Stars 4.7.  Store period key for future use.  Event ue_query
//						may need il_period_key.
// 04/04/01	GaryR	Stars 4.7 DataBase Port - Conversion of table SUM_SELECT
//	10/24/01	GaryR	Track 2513d	Check for a " instead of a 0.
//	09/25/02	GaryR	SPR 3324d	Centralize the logic to format labels
// 12/19/02 JasonS Track 2880d dynamically generate trend reports
// 4/14/03  JasonS Track 2880d Fix error in dynamic generation for ase.
// 06/09/03 MikeF SPR 3603d	Code/Decode structure not set.
// 06/12/03 MikeF SPR 3607d	Specify invoice_type from PERIOD_CNTL.
// 12/30/03 MikeF SPR 3737d	Specify FUNCTION_NAME from PERIOD_CNTL.
// 11/30/04 MikeF SPR 4128d	Add filter for DISP_SEQ > 0
// 02/07/06	GaryR	Track 4643d	Change character '0' place holders to numeric 0 fields
//	09/19/06	GaryR	Track 4541	Perpetuate any calculated columns from Summary to Trending
//	09/20/06	GaryR	Track 4540	Set formats based on DICTIONARY setting
//	03/01/07 Katie		SPR 4540 Set formats of calculated fields based on disp_format in SUM_SELECT
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//******************************************************************************

string ls_sql, ls_select_clause, ls_from_clause, ls_where_clause, ls_group_clause, &
			ls_order_clause, ls_style, ls_error, ls_syntax, ls_title, ls_blank_string[], &
			ls_col_label, ls_prev_col_label, ls_var_label, ls_calc, ls_col_name, ls_col_type
long ll_upperbound, ll_counter, ll_counter2, ll_rows, ll_pos
decimal ldc_value_1, ldc_value_2, ldc_variance
boolean lb_add_col, lb_number
String ls_sum_dbname	// JasonS 4/14/03 Track 2880d
string ls_pc_dbname // JasonS 4/14/03 Track 2880d
string	ls_window_name
int		li_rc, li_index, li_disp_ctr = 1

n_ds lds_dict_cols
n_cst_labels	lnv_labels
n_cst_string	lnv_string

CONSTANT int li_height_constant  =  21
int li_line_count, li_hdr_height, li_y_pos, li_column_count, li_cntr

setpointer(hourglass!)
SetMicroHelp(w_main,'Retrieving Trend Report. Please Wait!') 

istr_parm = message.powerobjectparm

// JasonS 4/14/03 Begin - Track 2880d
is_function=istr_parm.function_nm
iv_fields = istr_parm.group_fields
in_table_type = istr_parm.sum_tbl_type
iv_sum_tbl_name = istr_parm.sum_tbl_name
il_period_key	=	istr_parm.period_key			
iv_invoice_type = istr_parm.invoice_type
// JasonS 4/14/03 End - Track 2880d

//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectParm)

Call	w_master::Open			// FDG 07/17/97

This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

This.of_set_queryengine (TRUE)		//	FDG 03/11/98

select db into :ls_sum_dbname
from dictionary
where elem_type = 'TB' and elem_name = :istr_parm.sum_tbl_name
using stars2ca;

ls_sum_dbname = gnv_sql.of_get_database_prefix(ls_sum_dbname)

select db into :ls_pc_dbname
from dictionary
where elem_type = 'TB' and elem_name = 'PERIOD_CNTL'
using stars2ca;

ls_pc_dbname = gnv_sql.of_get_database_prefix(ls_pc_dbname)

// JasonS 12/19/02 Begin - Track 2880d
iv_fields = istr_parm.group_fields
ll_upperbound = upperbound(iv_fields)
ls_select_clause = 'SELECT '
ls_from_clause = 'FROM ' + ls_sum_dbname + istr_parm.sum_tbl_name  + ' ST, ' + ls_pc_dbname + 'PERIOD_CNTL PC '
ls_where_clause = istr_parm.sql_statement + " and ST.period = PC.period " + &
						" AND PC.FUNCTION_NAME = '" + is_function + "'" + &
						" AND PC.INVOICE_TYPE = '" + iv_invoice_type + "'"
ll_pos = Pos(UPPER(ls_where_clause), 'PERIOD IN')
ls_where_clause = Replace(ls_where_clause, ll_pos, 9, + 'ST.PERIOD IN')
ls_order_clause = 'ORDER BY '

for ll_counter = 1 to ll_upperbound
	ls_select_clause += 'ST.' + iv_fields[ll_counter].col_name + ', '
	ls_order_clause += 'ST.' + iv_fields[ll_counter].col_name + ' ASC, '
next

ls_select_clause += 'PC.PAYMENT_THRU_DATE, PC.PERIOD_DESC, '
ls_order_clause += 'PC.PAYMENT_THRU_DATE DESC, '
if istr_parm.group_by_flag = 'G' then
	ls_group_clause = 'GROUP BY' + mid(ls_select_clause, 7)
else
	ls_group_clause = ''
end if

lds_dict_cols = create n_ds
lds_dict_cols.dataobject = 'd_dict_cols'
lds_dict_cols.settransobject(stars2ca)
ll_rows = lds_dict_cols.retrieve( istr_parm.sum_tbl_type )

// Filter out rows where disp_seq = 0 (Key fiends, period ID, etc...)
li_rc 	= lds_dict_cols.SetFilter("DISP_SEQ > 0")
li_rc 	= lds_dict_cols.Filter()
ll_rows 	= lds_dict_cols.RowCount()

for ll_counter = 1 to ll_rows
	lb_add_col = true
	for ll_counter2 = 1 to ll_upperbound
		if trim(upper(lds_dict_cols.object.elem_name[ll_counter])) = trim(upper(iv_fields[ll_counter2].col_name)) then
			lb_add_col = false			
		end if
	next
	
	if lb_add_col then
		if istr_parm.group_by_flag = 'G' then
			if gnv_sql.of_is_money_data_type(lds_dict_cols.object.elem_data_type[ll_counter]) then
				ls_select_clause += "SUM(ST." + lds_dict_cols.object.elem_name[ll_counter] + ") as " + lds_dict_cols.object.elem_name[ll_counter] + ", 0.00 as " + lds_dict_cols.object.elem_name[ll_counter] + "_VAR, "			
			end if
		else
			ls_select_clause += 'ST.' + lds_dict_cols.object.elem_name[ll_counter] + ", 0.00 as " + lds_dict_cols.object.elem_name[ll_counter] + "_VAR, "
		end if
	end if
next

destroy lds_dict_cols

if ls_select_clause > '' then
	ls_select_clause = left(ls_select_clause, len(ls_select_clause) - 2)
	
	//	Append any calculated columns
	ls_calc = istr_parm.s_calc_cols
	IF ls_calc <> "" THEN
		// Replace the inv_types
		ls_calc = lnv_string.of_globalreplace( ls_calc, in_table_type + ".", "ST." )
		ls_select_clause += ", " + ls_calc
	END IF
end if
if ls_group_clause > '' then
	ls_group_clause = left(ls_group_clause, len(ls_group_clause) - 2)
end if
if ls_order_clause > '' then
	ls_order_clause = left(ls_order_clause, len(ls_order_clause) - 2)
end if

ls_sql = ls_select_clause + ' ' + ls_from_clause + ' ' + ls_where_clause + ' ' + ls_group_clause + ' ' + ls_order_clause
ls_style   =  "datawindow(units=1 color=" + string(stars_colors.window_background ) + ") style(type=grid)"
ls_syntax  =  Stars2ca.SyntaxFromSQL(ls_sql, ls_style, ls_error)

// JasonS 4/14/03 Begin - Track 2880d
if ls_error <> '' then
   messagebox('EDIT','Error building datawindow for report. Error message = ' + ls_error,exclamation!)
   return
end if
// JasonS 4/14/03 End - Track 2880d

dw_1.CREATE(ls_syntax, ls_error)

// JasonS 4/14/03 Begin - Track 2880d
if ls_error <> '' then
   messagebox('EDIT','Error creating datawindow for report. Error message = ' + ls_error,exclamation!)
   return
end if
// JasonS 4/14/03 End - Track 2880d

dw_1.settransobject(stars2ca)
ll_rows = dw_1.retrieve()

dw_1.object.payment_thru_date.visible = 0

// Include one line to make space for the title
li_line_count = 2

// Calculate the header height (title + column headings)
li_hdr_height  =  (li_line_count + 2) * li_height_constant	

// Calculate the starting height for column heading text
li_y_pos  =  (li_line_count * li_height_constant)				

// Add title to datawindow
ls_title = 'Trend Report - ' + istr_parm.header
this.title = ls_title

// Pass the title, dw, header height, x and y coordinates for title, title alignment (2), and title width
//wf_add_datawindow_title( ls_title, dw_1, string(li_hdr_height), '536', '2', '568')
wf_add_dw_title(dw_1, ls_title)


dw_1.setredraw(false)

// Dictionaryize the labels
lnv_labels  =  CREATE n_cst_labels
lnv_labels.of_setdw(dw_1)
lnv_labels.of_labels2( istr_parm.sum_tbl_type, string(li_hdr_height), '40', string(li_y_pos)  )

DESTROY lnv_labels

li_column_count = Integer ( dw_1.Object.DataWindow.Column.Count )

for li_cntr = 1 to li_column_count
	ls_col_label = dw_1.describe("#" + string(li_cntr) + ".dbname")
	if upper(right(ls_col_label, 3)) = 'VAR' then
		ls_prev_col_label = dw_1.describe("#" + string(li_cntr - 1) + ".dbname")
		ls_var_label = dw_1.describe(ls_prev_col_label + "_t.text")
		ls_error = dw_1.modify(ls_col_label + "_t.text='" + ls_var_label + " Var %'")
		
		ls_error = dw_1.modify("#" + string(li_cntr) + ".alignment = 1")
		ls_error = dw_1.modify("#" + string(li_cntr) + ".width= '" + string(len(ls_var_label) * 8.9) + "'")
		
		for ll_counter = 1 to ll_rows
			if (ll_counter + 1) <= ll_rows then
				if dw_1.object.payment_thru_date[ll_counter + 1]  < dw_1.object.payment_thru_date[ll_counter] then
					if (ll_counter + 1) <= ll_rows then
						ldc_value_1 = dw_1.getitemdecimal( ll_counter, li_cntr - 1)
						ldc_value_2 = dw_1.getitemdecimal( ll_counter + 1, li_cntr - 1)
						if ldc_value_2 = 0 Then
							ldc_variance = 100
						else
							ldc_variance = Round(((ldc_value_1 - ldc_value_2) / ldc_value_2) * 100, 2)
						end if
						dw_1.setitem(ll_counter, li_cntr, ldc_variance)
					end if
				end if
			end if
		next
	else
		//	Format calculated columns
		IF istr_parm.s_calc_cols <> "" THEN		
			ls_col_name = dw_1.Describe('#'+string(li_cntr)+'.name')
			IF Upper( Left( ls_col_name, 8 ) )  = "COMPUTE_" THEN
				Setformat(dw_1,li_cntr,istr_parm.calc_disp_format[li_disp_ctr])
				ls_col_label = dw_1.Describe(ls_col_name + '_t.text')
				//Remove filler characters added to string to force COMPUTE column name
				ls_col_label = Left(ls_col_label, Len(ls_col_label)-5)  
				ls_error = dw_1.modify(ls_col_name + '_t.text = "' + ls_col_label + '"')
				li_disp_ctr++		
			END IF
		END IF
	end if
next

dw_1.setredraw(true)

// JasonS 12/19/02 End - Track 2880d

ls_window_name = UPPER(this.classname())
li_rc = fx_dw_syntax(ls_window_name,dw_1,in_decode_struct,stars1ca)
If li_rc = -5 Then
	li_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(li_index)
End If

sle_count.text = string(dw_1.RowCount())

SetMicroHelp(w_main,'Ready')

end event

on w_trend_rpt.create
int iCurrent
call super::create
this.cb_more=create cb_more
this.st_dw_ops=create st_dw_ops
this.dw_period_desc=create dw_period_desc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_more
this.Control[iCurrent+2]=this.st_dw_ops
this.Control[iCurrent+3]=this.dw_period_desc
end on

on w_trend_rpt.destroy
call super::destroy
destroy(this.cb_more)
destroy(this.st_dw_ops)
destroy(this.dw_period_desc)
end on

type ddlb_dw_ops from w_parent_rpt`ddlb_dw_ops within w_trend_rpt
integer x = 27
integer y = 1884
integer height = 216
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
end type

type cb_clear from w_parent_rpt`cb_clear within w_trend_rpt
boolean visible = false
integer x = 1879
integer y = 1876
integer taborder = 0
end type

type st_1 from w_parent_rpt`st_1 within w_trend_rpt
integer x = 942
integer y = 1940
long backcolor = 83871462
end type

type cb_save_report from w_parent_rpt`cb_save_report within w_trend_rpt
integer x = 1678
integer y = 1840
integer taborder = 0
end type

type sle_count from w_parent_rpt`sle_count within w_trend_rpt
integer x = 763
integer y = 1868
integer width = 247
integer height = 100
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
long textcolor = 0
end type

type cb_stop from w_parent_rpt`cb_stop within w_trend_rpt
integer x = 1737
integer y = 1808
integer taborder = 0
end type

type mle_crit from w_parent_rpt`mle_crit within w_trend_rpt
integer x = 37
integer width = 3209
integer height = 160
end type

type cb_query from w_parent_rpt`cb_query within w_trend_rpt
boolean visible = false
integer x = 773
integer y = 1844
integer taborder = 0
end type

type cb_view_detail from w_parent_rpt`cb_view_detail within w_trend_rpt
boolean visible = false
integer x = 1234
integer y = 1844
integer taborder = 0
end type

type cb_close from w_parent_rpt`cb_close within w_trend_rpt
integer x = 2866
integer y = 1856
integer width = 379
integer taborder = 60
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
end type

type dw_1 from w_parent_rpt`dw_1 within w_trend_rpt
string tag = "CRYSTAL, title = Trends Report"
integer x = 37
integer y = 224
integer width = 3214
integer height = 1580
boolean ib_singleselect = true
end type

event dw_1::retrieveend;/*******************************************************************/
/* The variences are calculated for each of the %var fields here   */
/* it calls the function wf_divide_by_zero_check						 */
/* with the value of the current line and the line before it,      */
/* the field that the resulting variance is to be placed and the   */
/* counter indicating the row that is current                      */
/* if there is an attempt to divide by zero, the varience defaults */
/* to 999																			 */
/* The three possible datawindow objects are checked because the   */
/* fields to be calculated are in different positions depending on */
/* how many fields are in the datawindow									 */										 
/*******************************************************************/

//***************************************************************
//05-22-95 FNC Add another upperbound variable because have two 
//             upperbounds in DO loop.
//
//10-11-95 FNC Take upperbound out of script
//03-11/98 FDG Stars 4.0 Track 877 - Remove references to cb_subset
//***************************************************************

long lv_rowcount, counter, ll_row_count, ll_row, ll_period
decimal lv_value1, lv_value2, lv_var
string lv_col_name, lv_type_bill1,lv_prov_type1,lv_bedsize_range1
string lv_tmp_type_bill,lv_tmp_prov_type,lv_tmp_bedsize_range
string lv_fixed_fields1,lv_tmp_fixed_fields, ls_period
string lv_tmp_current,lv_tmp_next, ls_desc
string lv_tmp2,lv_next_tmp2,lv_tmp3,lv_next_tmp3,  rs
int i,j,lv_rc,lv_upperbound,lv_upperbound_field


//djp
ib_win_busy=false
if this.rowcount()=0 then return

//wf_binary_sort()
//rs = dw_1.modify('#'+string(iv_group_col_num)+".width='0'")
//rs = dw_1.modify('#'+string(iv_item_col_num)+".width='0'")

w_main.setmicrohelp('Performing Calculations, Please Wait!')
setpointer(hourglass!)

lv_rowcount = dw_1.rowcount()

counter = lv_rowcount

lv_fixed_fields1 = ''
lv_upperbound_field = upperbound(iv_fields)	 //05-22-96 FNC
for j =1 to lv_upperbound_field               //05-22-96 FNC
	lv_fixed_fields1 = lv_fixed_fields1+dw_1.GetItemString(counter,j)
next


DO WHILE counter >= 1
	lv_fixed_fields1 = ''
	for j =1 to lv_upperbound_field            //05-22-96 FNC
		lv_fixed_fields1 = lv_fixed_fields1+dw_1.GetItemString(counter,j)
	next
	//determine if the preceeding tob is different
	counter = counter - 1
	if counter <> 0 then
		lv_tmp_fixed_fields = ''
		for j =1 to lv_upperbound_field            //05-22-96 FNC
			lv_tmp_fixed_fields = lv_tmp_fixed_fields+dw_1.GetItemString(counter,j)
		next
		if lv_tmp_fixed_fields <> lv_fixed_fields1 then
			counter ++
			//variance should be 0
			goto skip
		else
			counter++
		end if
	else  //if counter = 0
		counter++
		//variance should be 0
		goto skip
	end if

   lv_upperbound = upperbound(iv_var_col)   //10-11-95 FNC
	for i = 1 to lv_upperbound               //10-15-95 FNC
		lv_value1 = dw_1.getitemdecimal(counter,iv_var_col[i] - 1)
		lv_value2 = dw_1.getitemdecimal(counter - 1,iv_var_col[i] - 1)
   	wf_divide_by_zero_check(lv_value1,lv_value2,counter,iv_var_col[i])
	next


	skip:
	counter --
LOOP

dw_1.setredraw(TRUE)

setpointer(arrow!)
w_main.setmicrohelp('Ready')

if gv_cancel_but_clicked = FALSE Then
	gv_cancel_but_clicked = TRUE
	dw_1.triggerevent(rowfocuschanged!)
end if 

cb_close.enabled = TRUE

fx_set_button_status(TRUE,in_button_not_modified[],mdi_main_frame.GetActiveSheet())

setfocus(dw_1)	
//dw_2.visible = true	

   
end event

event dw_1::rbuttondown;//*************************************************************
// 10/20/95	FNC	Take out connects and disconnects
// 05/05/00	GaryR	SC 2883	Uncomment DB error on not found
// 03/19/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	04/11/01	GaryR	Stars 4.7 DataBase Port - Trimming the data
//	09/13/06	GaryR	Track 4817	Replace Int with Long to prevent 32K limit
//*************************************************************

string lv_hold_object,lv_col_name,lv_cname, lv_tbl_type,lv_holdrow,lv_hold_cname
string lv_tmp_cname,lv_where_message
long lv_tabpos
int lv_pos

Setpointer(hourglass!)
lv_hold_object = this.Getobjectatpointer()

if lv_hold_object = '' Then
	return 
end if

lv_tabpos = pos (lv_hold_object,"~t")
lv_cname = left(lv_hold_object,(lv_tabpos - 1))
lv_holdrow = mid(lv_hold_object,(lv_tabpos + 1))


	if right(lv_cname,2) <> '_t' Then
		lv_col_name = dw_1.Describe(lv_cname+'.dbname')
		lv_col_name = lower(lv_cname)
		lv_cname = lv_cname + '_t'	
	end if

//This grabs the column name of the summarize field
	lv_hold_cname = lv_cname
	lv_tmp_cname = dw_1.Describe(lv_cname+'.text')	
	lv_pos = pos(lv_tmp_cname,'~r')
	if lv_pos <> 0 then
		lv_tmp_cname = replace(lv_tmp_cname,lv_pos,1,'~~r')
	end if
	
	SELECT elem_name
	INTO :lv_cname
	FROM dictionary
	WHERE elem_type = 'CL' and
			elem_tbl_type = Upper( :in_table_type ) and
			Upper(elem_elem_label) = Upper( :lv_tmp_cname )		// 03/19/01	GaryR	Stars 4.7 DataBase Port
	Using Stars2ca;
	if stars2ca.of_check_status() = 100 Then
		//05/05/2000	Gary-R	SC 2883	Begin
		//lv_where_message = "WHERE elem_type = 'CL' and elem_tbl_type = :"+in_table_type+" and elem_elem_label = :"+lv_tmp_cname 
		//errorbox(stars2ca,lv_tmp_cname+' cannot be found in the Dictionary Table: '+lv_where_message)
		//05/05/2000	Gary-R	SC 2883	End
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in dw_1')
      end if                            // 10-20-95 FNC End
		return 
	elseIf stars2ca.sqlcode <> 0 then
		lv_where_message = "WHERE elem_type = 'CL' and elem_tbl_type = :"+in_table_type+" and Upper(elem_elem_label) = :"+ Upper( lv_tmp_cname )
		errorbox(stars2ca,'Error reading from the Dictionary Table: '+lv_where_message)
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in dw_1')
      end if                            // 10-20-95 FNC End
		return 
	end if
		

//if lv_cname = 'DRG_CODE' then
//   lv_tbl_type = 'S2' 
//else
//   lv_tbl_type = 'S1' 
//end if
//sqlcmd('disconnect',stars2ca,'',5)    10-20-95 FNC Start
COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in dw_1') 
   return
end if                            // 10-20-95 FNC End


	gv_element_table_type = lv_tbl_type
//	gv_element_table_type2 = lv_tbl_type
	gv_element_name = lv_cname
	lv_pos = pos(lv_hold_object,'_t')
	if lv_holdrow = string(1) and lv_pos <> 0 then
		open(w_dwlabel_definition)
	else

	Select ELEM_Lookup_Type into :gv_code_to_use
	From dictionary
	where ELEM_TBL_Type = Upper( :in_table_type ) and
	ELEM_Name = Upper( :lv_cname )
	using stars2ca;

	//	04/11/01	GaryR	Stars 4.7 DataBase Port
	if (stars2ca.sqlcode=100) or (Trim( gv_code_to_use ) = '') then
      COMMIT using stars2ca;
      if stars2ca.sqlcode <> 0 then
         messagebox('ERROR','Error performing commit in dw_1')
      end if                            // 10-20-95 FNC End
		return	
	elseif (stars2ca.sqlcode<>0) Then
		lv_where_message = "where ELEM_TBL_Type = "+in_table_type+" and	ELEM_Name = "+lv_cname
		errorbox(stars2ca,'Error Reading Dictionary Table: '+lv_where_message)
		return
	end if
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      errorbox(stars2ca,'Error performing commit in dw_1')
      return
   end if                            // 10-20-95 FNC End


	gv_code_id_to_use = dw_1.GetItemString(Long(lv_holdrow),lv_col_name)
	gv_win_x_pos = dw_1.x+10+this.x
	gv_win_y_pos = 315 + dw_1.y

	open(w_definition)
end if

end event

on dw_1::retrievestart;call w_parent_rpt`dw_1::retrievestart;//ABO 8/16/96  Commented out code that uses hardcoded dates.
//             We need to find a new way of showing the description. 

//this fills the code table of the period column in order to
//display the period in a more meaningful manner.  It determines
//what the three periods for Part A are, parses them and
//sets the values of the code table

//string lv_mo, lv_year, lv_value
//int lv_rc
//
//dw_1.setactioncode(0)
//
//lv_mo = right(string(gc_cal_01),2)
//lv_year = left(string(gc_cal_01),4)
//if lv_mo = '06' then
//	lv_value = 'Jan-Jun ' + lv_year + '~t' + lv_year + '01'
//else
//	lv_value = 'Jul-Dec ' + lv_year + '~t' + lv_year + '02'
//end if
//lv_rc = dw_1.setvalue('period',1,lv_value)
//if lv_rc = -1 then
//	return
//end if
//
//lv_mo = right(string(gc_cal_02),2)
//lv_year = left(string(gc_cal_02),4)
//if lv_mo = '06' then
//	lv_value = 'Jan-Jun ' + lv_year + '~t' + lv_year + '01'
//else
//	lv_value = 'Jul-Dec ' + lv_year + '~t' + lv_year + '02'
//end if
//lv_rc = dw_1.setvalue('period',2,lv_value)
//if lv_rc = -1 then
//	return
//end if
//
//lv_mo = right(string(gc_cal_A3),2)
//lv_year = left(string(gc_cal_A3),4)
//if lv_mo = '06' then
//	lv_value = 'Jan-Jun ' + lv_year + '~t' + lv_year + '01'
//else
//	lv_value = 'Jul-Dec ' + lv_year + '~t' + lv_year + '02'
//end if
//lv_rc = dw_1.setvalue('period',3,lv_value)
//if lv_rc = -1 then
//	return
//end if
end on

event dw_1::constructor;call super::constructor;//	TS144		STARS 4.0	Subset Redesign
//
// Log:		
//				JGG	01/12/98		Register the datawindow to the labels service (nvo)
//

This.of_SetLabels (TRUE)


end event

type cb_more from u_cb within w_trend_rpt
string accessiblename = "View Data"
string accessibledescription = "View Data"
integer x = 2432
integer y = 1856
integer width = 379
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&View Data..."
boolean default = true
end type

event clicked;////////////////////////////////////////////////////////////////////////
//	Script:	cb_more.clicked
//
//	Description:
//		Open Query Engine to enter more criteria.
//
//	NOTE:
//		This script was rewritten for STARS 4.0 to open w_query_engine
//		instead of w_detail_analysis_mc.
//
////////////////////////////////////////////////////////////////////////
// 08/03/98 ajs   Stars 4.0 - Track 1522.  Pass period key to QE if present.
// 01-12-99 AJS   FS1498d change comma back to and so display filter works
//	03-10-00	NLG	Patient profiles. Check for DRUGCAT - a PHAR summary column
//						that is not on claims table. Must be converted to appropriate
//						NDC column elem_name and value must be prefixed with @
//						so that query engine will treat as filter
//	04-05-00	NLG	Track 2472. If TOB length was < 2, was getting query
//						engine '%' error.  Change operator to 'LIKE'.
// 05/25/00 FNC	Track 2303 Starsdev. If a revenue field is included in 
//						the criteria all of the table types must be converted
//						to the fasttrack invoice type.\
//	01/29/02	LahuS	Track 2552d	Predefined Report (PDR)
// 04/14/03	Jason Track 2880d changed from period to period_desc
// 02/01/05 MikeF	SPR4256d	Resolve issue with multiple "view data"s
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
// 09/29/05 Katie Track 4532 Added BLANKS functionality
////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long		ll_row,				&
			ll_num_period_rows,&
			ll_rows
Integer	li_upper,			&
			li_pos,				&
			li_load_idx,		&
			li_idx,				&
			li_period_row,		&
			li_period,			&
			li_rc,				&
			li_upperbound,		&
			li_index1,			&
			li_index2
String	ls_left_paren,		&
			ls_tbl_type,		&
			ls_col_name,		&
			ls_operator,		&
			ls_value,			&
			ls_right_paren,	&
			ls_connector,     &
			ls_period,			&
			ls_base_type,		&
			ls_rev_tbl_type,	&
			ls_period_compare

n_cst_revenue	lnv_revenue
sx_field 	lsx_fields[]
n_cst_decode	lnv_decode

ll_row	=	dw_1.GetSelectedRow(0)

If ll_row	<	1	Then
  MessageBox('Error','Please select a row before attempting to enter more criteria.')
  RETURN
End If

// Clear out the query engine parms from previous attempts
inv_queryengine.uf_clear_query_parms()

//Get correct period #Track 1499
ls_period = string(dw_1.object.period_desc[ll_row])	// JasonS 4/14/03 Track 2880d

n_cst_string lnvo_cst_string
ls_period = lnvo_cst_string.of_globalreplace(ls_period,' and',',')	//ajs 01-12-99

dw_period_desc.SetTransObject(stars2ca)
ll_num_period_rows = dw_period_desc.retrieve(iv_invoice_type,is_function)

if ll_num_period_rows < 0 then
	messagebox('WARNING','Cannot convert period id. ~r Error Retrieving Period Descriptions')
	return
elseif ll_num_period_rows = 0 then
	messagebox('WARNING','Cannot convert period id. ~r Period Control entries not found')
	return
end if

For li_period_row = 1 to ll_num_period_rows
	ls_period_compare = dw_period_desc.getitemstring(li_period_row,'PERIOD_DESC')
	if ls_period = string(ls_period_compare) then
		li_period = dw_period_desc.getitemnumber(li_period_row,'PERIOD_KEY')
		Exit
	end if
Next

//ajs 4.0 08/03/98 Pass period key to QE if available
If li_period > 0 then
	//period will be passed to qe 
	inv_queryengine.uf_set_period_key(int(li_period))					//ajs 4.0 08/03/98 Pass period key to QE
	inv_queryengine.uf_set_period_function(istr_parm.function_nm)	//ajs 4.0 08/03/98 Pass period key to QE
End If

// FNC 05/25/00 Start
lnv_revenue	=	CREATE n_cst_revenue	
ls_base_type = lnv_revenue.of_get_base_type(iv_invoice_type)

// Create local copy to resolve issue with multiple "view data"s - SPR4256d
lsx_fields = iv_fields 

If ls_base_type = 'UB92' Then
	li_upperbound = UpperBound(iv_fields[])
	For li_index1 = 1 to li_upperbound
		IF	Trim (ls_rev_tbl_type)	<	' '	THEN
			ls_rev_tbl_type = lnv_revenue.of_get_revenue(iv_fields[li_index1].tbl_type)
		END IF
		
		if iv_fields[li_index1].tbl_type = ls_rev_tbl_type then
			is_detail_inv_type = lnv_revenue.of_get_fasttrack_invoice(iv_invoice_type)
			if is_detail_inv_type = 'ERROR' then return
			in_detail_struct.table_type[1] = is_detail_inv_type
			in_detail_struct.table_type[2] = ''
			For li_index2 = 1 to li_upperbound
				lsx_fields[li_index2].tbl_type = is_detail_inv_type
			Next
			Exit
		else
			is_detail_inv_type = iv_invoice_type
		end if
	Next
else
	is_detail_inv_type = iv_invoice_type
end if
// FNC 05/25/00 End

inv_queryengine.uf_set_invoice_type (is_detail_inv_type)
inv_queryengine.uf_set_tbl_type (is_detail_inv_type)
inv_queryengine.uf_set_tbl_rel ('GP')
inv_queryengine.uf_set_rpt_title ('Claim Report - ' + istr_parm.header)

li_load_idx	=	1
li_upper		=	UpperBound (iv_fields)


FOR li_idx	=	1	TO	li_upper
	ls_left_paren	=	''
	ls_tbl_type		=	lsx_fields[li_idx].tbl_type
	ls_col_name		=	lsx_fields[li_idx].col_name
	ls_operator		=	'='
	ls_value			=	Trim ( dw_1.GetItemString(ll_row, li_idx) )

	// Check for DRUGCAT 
	IF UPPER(ls_col_name) = ics_drugcat THEN
		ls_value = '@' + ls_value
		ls_col_name = 'NDC_CODE'
	END IF

	IF	ls_value		=	'*'	 THEN
		ls_value		=	''
	ELSEIF ls_value = '' or ls_value = ' ' or isnull(ls_value) THEN
		ls_value = 'BLANKS'
	ELSE
		// If field is decoded, then strip off the description
		IF lnv_decode.of_is_decoded( dw_1, li_idx ) THEN
			lnv_decode.of_remove_desc( ls_value )
		END IF
	END IF
	ls_right_paren	=	''
	IF	li_idx	=	li_upper		THEN
		// Last criteria - No 'AND' is necessary
		ls_connector	=	''
	ELSE
		ls_connector	=	'AND'
	END IF

	// Trend report only reports on 2 digits whereas 'Detail Analysis'
	//	requires 3 digits.  So add '%' to the end of ls_value.
	IF	Upper (iv_fields[li_idx].col_name)	=	'TYPE_BILL'		THEN
		IF	Len (ls_value)		<	3		&
		AND Len(ls_value)		>	0		THEN
			ls_value		=	ls_value	+	'%'
			ls_operator = 'LIKE'//NLG 4-05-00 Track #2472
		END IF
	END IF
	inv_queryengine.uf_load_where	(ls_left_paren,	&
											ls_tbl_type,		&
											ls_col_name,		&
											ls_operator,		&
											ls_value,			&
											ls_right_paren,	&
											ls_connector,		&
											li_load_idx)
NEXT

w_main.SetMicroHelp ('Bringing up Query Engine.  Please Wait')

//	01/29/02	Lahu S	Track 2552d
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

inv_queryengine.uf_open_query_engine()


end event

type st_dw_ops from statictext within w_trend_rpt
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 1820
integer width = 672
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type dw_period_desc from u_dw within w_trend_rpt
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 1943
integer y = 700
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_period_desc"
end type

