HA$PBExportHeader$w_ratio_rpt.srw
$PBExportComments$Inherited from w_master
forward
global type w_ratio_rpt from w_master
end type
type dw_period_list from u_dw within w_ratio_rpt
end type
type st_dw_ops from statictext within w_ratio_rpt
end type
type ddlb_dw_ops from dropdownlistbox within w_ratio_rpt
end type
type rb_2 from radiobutton within w_ratio_rpt
end type
type rb_1 from radiobutton within w_ratio_rpt
end type
type dw_1 from u_dw within w_ratio_rpt
end type
type cb_query from u_cb within w_ratio_rpt
end type
type mle_crit from multilineedit within w_ratio_rpt
end type
type st_row_count from statictext within w_ratio_rpt
end type
type cb_close from u_cb within w_ratio_rpt
end type
type cb_view from u_cb within w_ratio_rpt
end type
type gb_1 from groupbox within w_ratio_rpt
end type
end forward

global type w_ratio_rpt from w_master
string accessiblename = "Ratio Reports"
string accessibledescription = "Ratio Reports"
integer x = 169
integer y = 264
integer width = 3401
integer height = 2288
string title = "Ratio Reports"
dw_period_list dw_period_list
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
cb_query cb_query
mle_crit mle_crit
st_row_count st_row_count
cb_close cb_close
cb_view cb_view
gb_1 gb_1
end type
global w_ratio_rpt w_ratio_rpt

type variables
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI 
//	06/13/08	GaryR	SPR 5378	Hide the Query button Ratios run by Proc Code

long in_period
w_uo_win iv_uo_win

string iv_full_sql //, in_sql  FS#171
string iv_rpt_type, iv_rpt_ver
string iv_invoice_type
string in_selected
string in_dw_control
sx_decode_structure in_decode_struct
string	iv_table_name

// Dimensions of mle_crit and dw_1 when the window
// opens
Long	il_mle_x,		&
	il_mle_y,		&
	il_mle_height,	&
	il_mle_width,	&
	il_dw_x,		&
	il_dw_y,		&
	il_dw_height,	&
	il_dw_width

string	is_perform_query_sw
String	is_use_catgproc

sx_ratio_rpt_parms isx_ratio_rpt_parms
sx_ratio_select_parms isx_ratio_select_parms

// FNC Starcare track 1804 4.0 SP2
Boolean		ib_use_bill 

// FNC 03/30/00 Starcare 2664
Boolean ib_prior_period
end variables

forward prototypes
private function integer wf_build_proc_sum_sql (string arg_sql_type)
public subroutine wf_process_crit_for_display (string in_sql)
public function integer wf_hide_npi (integer ai_rpt_type)
end prototypes

private function integer wf_build_proc_sum_sql (string arg_sql_type);//********************************************************************************
// wf_build_proc_sum_sql
// Builds the count or SQL for w_ratio1_proc_list, while still in w_ratio1_rpt
//********************************************************************************
// 10/3/94  SG  		Modified to read STARS_WIN_PARM to get tables
// 10/29/97 john_wo 	spec 127 3.6 release. Added new sql if we are not using
//		        			the catg_proc file.
//	01/09/98 Archana 	TRK # 204 Ver 3.6
// 						The hard coded table alias have been replaced by inv_type[] so 
//							that this code can be used by multiple invoice types.
// 						NOTE:  This change is only for 3.6.  This code needs to be 
//							re-written for 4.0 Release 
//	01/19/98	FDG		TRK235
//							1. Fix 1/9/98 bug.  In sub select, table CATG_PROC should
//							point to inv_type[3] instead of inv_type[1].
//							2. Fix 10/29/97 bug.  SD.CATG_proc should be CP.CATG_PROC.
//							3. Fix 1/9/98 bug. P1.PIN_IND should be SD.PIN_IND
//							4. Fix 1/9/98 bug. SD.CATG_ID should be CP.CATG_ID
//05/04/99	FNC		FS/TS1804c Starcare track 1804. Add sum of total_srvc and 
//							sub_chrg to Ratio 3 report if billed amount displayed on
//							on report instead of allowed amount.
//	05/24/99	FDG		1804c.  Apply same changes to Ratio 1 & 2 reports.
// 03/30/00	FNC		Track 2664 Starcare FS/TS2664c Stars 4.5. Apply the 
//							prior period to the sum_ratio_detail table only. Not to
// 						the prov_ratio_detail_table
//	06/04/01	GaryR		Do not include the CATG_PROC table if
//							the use_catgproc indicator is set to 'N'
// 1/15/02 FNC 		Track #2653 Move sum and group by fields inside of if/else for
//							catg_proc. If don't use catg_proc don't need to sum and group by
//							because the other tables in the from have already been grouped in the
//							middleware.
//							If use catg proc need to sum fields and group because the catg proc
//							table repeats the cat of serv. 
//	03/14/02	FDG		Track 2876d.  Use '||' instead of '+' to concatenate columns.
//	09/10/02	GaryR		Track 3468d	Eliminate CATG_PROC view reference in Stars1
//	07/29/05	GaryR		Track 4432d	Allow multi-column decode in background
//	02/19/07	Katie		SPR 4831 Adjusted Ratio 2 Criteria to select correct Period source table.
//	04/14/08	GaryR		SPR 4435	Accommodate Ratios by NPI 
// 05/29/08	GaryR		SPR 5368	Use both the NPI and Prov ID criteria for NPI ratios
// 06/05/08	GaryR		SPR 4979 Remove trimming of values and use proper empty string
// 06/20/08	Katie		SPR 5394 Fixed issue with critieria for Ratio 3 Ver 2.
//	06/23/08	GaryR		SPR 5382	If prov_id = MULTIPLE and run by Proc Cat, join only on NPI
//	06/25/08	GaryR		SPR 5401	Fix Ratio Report 3 Version 2 where clause
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//********************************************************************************

string lv_sel, lv_cols,lv_from, lv_where, lv_where_clause, lv_final_where
string lv_sub_sel, lv_sub_where, lv_subquery
string lv_group_by, lv_order_by, lv_having, lv_final_having
long   next_selected_row,selected_row = 0, ll_length
int    lv_num_of_tables, lv_table_num, i
string lv_tables[4,2], inv_type[]
String	ls_pin_ind, ls_prov, ls_prov_where, ls_win_id = "W_RATIO_RPT"
String	ls_npi, ls_spec, ls_area, ls_cat, ls_empty
n_cst_decode	lnv_decode
n_ds	lds_tables

IF isx_ratio_select_parms.b_npi THEN ls_win_id = "W_RATIO_RPT_NPI"
lds_tables = Create n_ds
lds_tables.dataobject = "d_ratio_proc_sum_tables"
lds_tables.SetTransObject( Stars2ca )
lv_table_num = lds_tables.Retrieve( ls_win_id, iv_invoice_type, iv_rpt_type )

IF lv_table_num < 1 THEN
	MessageBox( "ERROR", "Unable to identify STARS_WIN_PARM rows for invoice type: " + iv_invoice_type )
	Return -1
END IF

FOR i = 1 to lv_table_num
	lv_tables[i,1] = lds_tables.GetItemString( i, "col_name" )
	lv_tables[i,2] = lds_tables.GetItemString( i, "label" )
	
	//1-9-98 Archana TRK#204
	IF match(lv_tables[i,2],'PROV_RATIO') = TRUE THEN
		inv_type[1] = lv_tables[i,1]	
	ELSEIF match(lv_tables[i,2],'RATIO_DETAIL') = TRUE THEN
		inv_type[2] = lv_tables[i,1]		
	ELSEIF match(lv_tables[i,2],'CATG_PROC') = TRUE THEN
		inv_type[3] = lv_tables[i,1]
	END IF
NEXT

Destroy lds_tables
If stars2ca.of_commit() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return -1
End If	

if iv_rpt_type = 'R3' Then
   lv_num_of_tables = 2
else
   lv_num_of_tables = 3
end if

//john_wo 10/29/97 3.6 spec 127 - remove catg_proc from the 'FROM' clause
//                     if the use_catgproc switch = 'n'.   
For lv_table_num = 1 to lv_num_of_tables
	//	09/10/02	GaryR	Track 3468d - Begin
	//	06/04/01	GaryR
	IF Match( Upper( lv_tables[lv_table_num,2] ), 'CATG_PROC' ) THEN
		IF is_use_catgproc = 'N' THEN
			Continue
		ELSE
			lv_tables[lv_table_num,2] = gnv_sql.of_get_database_prefix( Stars2ca.database ) + lv_tables[lv_table_num,2]
		END IF
	END IF
	//	09/10/02	GaryR	Track 3468d - End
	
	lv_from = lv_from + lv_tables[lv_table_num,2] + ' ' + lv_tables[lv_table_num,1] + ', '
Next
//john_wo 3.6 spec 127 - strip the last comma from lv_from
ll_length = Len(lv_from)
If ll_length > 0 Then
	If Mid(lv_from,ll_length - 1,2) = ', ' Then
		lv_from = Left(lv_from,ll_length - 2)
	End If
End If
lv_from = ' FROM ' + lv_from

IF iv_rpt_type = 'R1' THEN
	//  RATIO 1 REPORT
	If is_use_catgproc = 'N' Then
		//1/8/98 Archana Trk#209  P1 changed to inv_type[1] SD changed to inv_type[2] CP changed to inv_type[3]
		// FDG 05/24/99 begin
		lv_cols =	' ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + &
						inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + inv_type[1] + '.CAT_of_serv, ' + &
					 	inv_type[1] + '.CAT_of_serv, ' + inv_type[2] + '.ALW_SRVC, ' + inv_type[2] + '.ALW_CHRG, '
		// FDG 05/24/99 end
		// FNC 01/15/02 begin move inside of if/else
		IF ib_use_bill  THEN		
			lv_cols = lv_cols +  + inv_type[2] + '.TOTAL_SRVC, ' + inv_type[2] + '.SUB_CHRG, '
		ELSE
			lv_cols = lv_cols + '0, 0.0, '
		END IF
		// FNC 01/15/02 End
	Else
		// FDG 05/24/99 begin
   	lv_cols =	' ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + &
						inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + inv_type[1] + '.CAT_of_serv, ' + &
						inv_type[3] + '.CATG_PROC,  SUM(' + inv_type[2] + '.ALW_SRVC), SUM(' + inv_type[2] + '.ALW_CHRG), '
		// FNC 01/15/02 Begin - move this code inside of if/else
		IF ib_use_bill  THEN		
			lv_cols = lv_cols + 'SUM(' + inv_type[2] + '.TOTAL_SRVC), ' + &
			'SUM(' + inv_type[2] + '.SUB_CHRG), '
		ELSE
			lv_cols = lv_cols + '0, 0.0, '
		END IF
		// FNC 01/15/02 End
	// FDG 05/24/99 end
	
		//	Set NPI values
		IF isx_ratio_select_parms.b_npi THEN
			lv_group_by = ' GROUP BY ' + inv_type[1] + '.PROV_NPI, ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + inv_type[1] + '.CAT_of_serv, ' + inv_type[3] + '.CATG_PROC, ' + inv_type[2] + '.PIN_IND '
			lv_order_by = ' ORDER BY ' + inv_type[1] + '.PROV_ID ASC, ' + inv_type[1] + '.Prov_SPEC ASC, ' + inv_type[1] + '.Prov_AREA ASC, ' + inv_type[1] + '.CAT_of_Serv ASC, ' + inv_type[3] + '.CATG_PROC ASC '
		ELSE
			lv_group_by = ' GROUP BY ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + inv_type[1] + '.CAT_of_serv, ' + inv_type[3] + '.CATG_PROC, ' + inv_type[2] + '.PIN_IND '
			lv_order_by = ' ORDER BY ' + inv_type[1] + '.PROV_ID ASC, ' + inv_type[1] + '.Prov_SPEC ASC, ' + inv_type[1] + '.Prov_AREA ASC, ' + inv_type[1] + '.CAT_of_Serv ASC, ' + inv_type[3] + '.CATG_PROC ASC '
		END IF
	End If
	lv_cols = lv_cols + ls_pin_ind
ELSE
   IF iv_rpt_type = 'R2' THEN
	   //  RATIO 2 REPORT
		If is_use_catgproc = 'N' Then
			// FDG 05/24/99 begin
			lv_cols =	' ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + &
							inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + & 
							inv_type[1] + '.CAT_of_serv, ' + inv_type[2] + '.PROC_CODE,  ' + &
							inv_type[2] + '.ALW_SRVC, ' + inv_type[2] + '.ALW_CHRG, '
			// FDG 05/24/99 end
			// FNC 01/15/02 begin move inside of if/else
			IF ib_use_bill  THEN		
				lv_cols = lv_cols +  + inv_type[2] + '.TOTAL_SRVC, ' + inv_type[2] + '.SUB_CHRG, '
			ELSE
				lv_cols = lv_cols + '0, 0.0, '
			END IF
			// FNC 01/15/02 End	
		Else
			// FDG 05/24/99 begin
			lv_cols =	' ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + &
							inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + & 
		  			   	inv_type[1] + '.CAT_of_serv, ' + inv_type[3] + '.CATG_PROC,  SUM(' + &
							inv_type[2] + '.ALW_SRVC), SUM('+ inv_type[2]+'.ALW_CHRG), ' 
			// FDG 05/24/99 end
			// FDG 05/24/99 begin
			IF ib_use_bill  THEN
				lv_cols = lv_cols + 'SUM(' + inv_type[2] + '.TOTAL_SRVC), ' + &
				'SUM(' + inv_type[2] + '.SUB_CHRG), '
			ELSE
				lv_cols = lv_cols + '0, 0.0, '
			END IF
			// FDG 05/24/99 end			
			
			//	Set NPI values
			IF isx_ratio_select_parms.b_npi THEN
				lv_group_by = ' GROUP BY ' + inv_type[1] + '.PROV_NPI, ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + inv_type[1] + '.CAT_of_serv, ' + inv_type[3] + '.CATG_PROC, ' + inv_type[2] + '.PIN_IND ' 		  
				lv_order_by = ' ORDER BY ' + inv_type[1] + '.PROV_NPI ASC, ' + inv_type[1] + '.PROV_ID ASC, ' + inv_type[1] + '.Prov_SPEC ASC, ' + inv_type[1] + '.Prov_AREA ASC, ' + inv_type[1] + '.CAT_of_Serv ASC, ' + inv_type[3] + '.CATG_PROC ASC '
			ELSE
				lv_group_by = ' GROUP BY ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + inv_type[1] + '.Prov_SPEC, ' + inv_type[1] + '.Prov_AREA, ' + inv_type[1] + '.CAT_of_serv, ' + inv_type[3] + '.CATG_PROC, ' + inv_type[2] + '.PIN_IND ' 		  
				lv_order_by = ' ORDER BY ' + inv_type[1] + '.PROV_ID ASC, ' + inv_type[1] + '.Prov_SPEC ASC, ' + inv_type[1] + '.Prov_AREA ASC, ' + inv_type[1] + '.CAT_of_Serv ASC, ' + inv_type[3] + '.CATG_PROC ASC '
			END IF
		End If
		lv_cols = lv_cols + ls_pin_ind	
   ELSE
	   //  RATIO 3 REPORT
		// FNC 05/04/99 Start
		lv_cols = ' ' + inv_type[1] + '.PROV_ID, ' + inv_type[1] + '.PROV_NAME, ' + &
						inv_type[1] + '.prov_SPEC, ' + inv_type[1] + ".PROV_AREA,' ', " + &
						inv_type[2] + '.PROC_CODE, SUM(' + inv_type[2] + '.ALW_SRVC), SUM(' + inv_type[2] + '.ALW_CHRG), ' 
		IF ib_use_bill  THEN
		   lv_cols = lv_cols + 'SUM(' + inv_type[2] + '.TOTAL_SRVC), ' + &
			'SUM(' + inv_type[2] + '.SUB_CHRG), '
		ELSE
			lv_cols = lv_cols + '0, 0.0, '
		END IF
		lv_cols = lv_cols + ls_pin_ind
		// FNC 05/04/99 end

		//	Set NPI values
		IF isx_ratio_select_parms.b_npi THEN
			lv_group_by = ' GROUP BY ' + inv_type[1] + '.PROV_NPI, '+ inv_type[1] + '.PROV_ID, '+ inv_type[1] + '.PROV_NAME, ' + inv_type[1] + '.prov_SPEC, ' + inv_type[1] + '.prov_AREA, ' + inv_type[2] + '.proc_code, ' + inv_type[2] + '.PIN_IND '
			lv_order_by = ' ORDER BY ' + inv_type[1] + '.PROV_NPI ASC, ' + inv_type[1] + '.PROV_ID ASC, ' + inv_type[1] + '.prov_SPEC ASC, ' + inv_type[1] + '.prov_AREA ASC '
		ELSE
			lv_group_by = ' GROUP BY ' + inv_type[1] + '.PROV_ID, '+ inv_type[1] + '.PROV_NAME, ' + inv_type[1] + '.prov_SPEC, ' + inv_type[1] + '.prov_AREA, ' + inv_type[2] + '.proc_code, ' + inv_type[2] + '.PIN_IND '
			lv_order_by = ' ORDER BY ' + inv_type[1] + '.PROV_ID ASC, ' + inv_type[1] + '.prov_SPEC ASC, ' + inv_type[1] + '.prov_AREA ASC '		
		END IF
   END IF
END IF

//	Add NPI column and PIN_IND
IF isx_ratio_select_parms.b_npi THEN
	lv_cols = " " + inv_type[1] + ".PROV_NPI, " + lv_cols + inv_type[2] + ".PIN_IND "
ELSE
	lv_cols = " ' ' PROV_NPI, " + lv_cols + inv_type[2] + ".PIN_IND "
END IF

If arg_sql_type = 'count' OR arg_sql_type = 'COUNT' then
	// FDG 03/14/02 - on each 'SELECT COUNT',  concatenate columns
	IF iv_rpt_type = 'R1' THEN
		//  RATIO 1 REPORT
		lv_sel = inv_type[1] + '.PROV_ID' + gnv_sql.is_concat + inv_type[1] + &
				'.PROV_NAME ' + gnv_sql.is_concat + inv_type[1] + '.prov_SPEC' + &
				gnv_sql.is_concat + inv_type[1] + '.prov_AREA' + gnv_sql.is_concat + &
				inv_type[1] + '.CAT_of_serv' + gnv_sql.is_concat + inv_type[3] + '.CATG_PROC) '
	ELSE
	   IF iv_rpt_type = 'R2' THEN
	      // RATIO 2 REPORT
			lv_sel = inv_type[1] + '.PROV_ID' + gnv_sql.is_concat + inv_type[1] + &
				'.PROV_NAME' + gnv_sql.is_concat + inv_type[1] + '.prov_SPEC' + &
				gnv_sql.is_concat + inv_type[1] + '.prov_AREA' + gnv_sql.is_concat + &
				inv_type[1] + '.CAT_of_serv' + gnv_sql.is_concat + inv_type[3] + '.CATG_PROC) '
 		ELSE
	      //  ASSUME RATIO 3 REPORT
			lv_sel = inv_type[1] + '.PROV_ID' + gnv_sql.is_concat + inv_type[1] + &
			'.PROV_NAME' + gnv_sql.is_concat + inv_type[1] + '.prov_SPEC' + &
			gnv_sql.is_concat + inv_type[1] + '.prov_AREA' + gnv_sql.is_concat + &
			inv_type[2] + '.Proc_code) '
      END IF
	END IF
	
	//	Set NPI values
	IF isx_ratio_select_parms.b_npi THEN
		lv_sel = 'SELECT COUNT (DISTINCT ' + inv_type[1] + '.PROV_NPI' + gnv_sql.is_concat + lv_sel
	ELSE
		lv_sel = 'SELECT COUNT (DISTINCT ' + lv_sel
	END IF
	
else
	lv_sel = 'SELECT ' + lv_cols
end if

If iv_rpt_type <> 'R3' then
	lv_sub_sel = ' ( SELECT ' + inv_type[3] + '.CATG_PROC  FROM CATG_PROC ' + inv_type[3] 
elseif iv_rpt_type = 'R3' then
	lv_sub_sel = ' '
End if

//------This logic limits processing to the selection of only 1 row from the DW.-----------------------
next_selected_row = GetSelectedRow(dw_1,selected_row)
if next_selected_row = 0 then 
	return -1
end if

// Initialize empty string
gnv_sql.of_trimdata( ls_empty )

//  logic to get selected fields and put into variables.
If iv_rpt_type = 'R3' Then
	//  Ratio Rpt 3
   If left(iv_rpt_ver,1) = '2' Then
	   ls_spec = getitemstring(dw_1,next_selected_row,"prov_spec")
	   ls_area = getitemstring(dw_1,next_selected_row,"prov_area")
	   ls_cat  = ls_empty
		ls_npi = ls_empty
   Else
		ls_npi = getitemstring(dw_1,next_selected_row,"prov_npi")
	   ls_prov = getitemstring(dw_1,next_selected_row,"prov_id")
	   ls_spec = getitemstring(dw_1,next_selected_row,"prov_spec")
	   ls_area = getitemstring(dw_1,next_selected_row,"prov_area")
	   ls_cat  = ls_empty
   End If
Else
	//  Ratio Rpt 1 & 2
	ls_npi = getitemstring(dw_1,next_selected_row,"prov_npi")
	ls_prov = getitemstring(dw_1,next_selected_row,"prov_id")
	ls_spec = getitemstring(dw_1,next_selected_row,"prov_spec")
	ls_area = getitemstring(dw_1,next_selected_row,"prov_area")
	ls_cat  = getitemstring(dw_1,next_selected_row,"cat_of_serv")
End If

//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
if Trim( ls_npi ) <> '' then
	IF lnv_decode.of_is_decoded( dw_1, "prov_npi" ) THEN
		lnv_decode.of_remove_desc( ls_npi )
	END IF
end if
if Trim( ls_prov ) <> '' then
	IF lnv_decode.of_is_decoded( dw_1, "prov_id" ) THEN
		lnv_decode.of_remove_desc( ls_prov )
	END IF
end if
if Trim( ls_spec ) <> '' then
	IF lnv_decode.of_is_decoded( dw_1, "prov_spec" ) THEN
		lnv_decode.of_remove_desc( ls_spec )
	END IF
end if
if Trim( ls_area ) <> '' then
	IF lnv_decode.of_is_decoded( dw_1, "prov_area" ) THEN
		lnv_decode.of_remove_desc( ls_area )
	END IF
end if
if Trim( ls_cat ) <> '' then
	IF lnv_decode.of_is_decoded( dw_1, "cat_of_serv" ) THEN
		lnv_decode.of_remove_desc( ls_cat )
	END IF
end if

//  logic to build the subquery to select based on procedure codes.
// 1-12-98 Archana TRK#209  added the if condition
If iv_rpt_type <> 'R3' then
	lv_sub_where = ' WHERE ' + inv_type[3] + '.PERIOD = ' + string(in_period) + &
	' AND ' + inv_type[3] + '.CATG_ID = ~'' + Upper( ls_cat ) + '~' ) ' 
	lv_subquery = lv_sub_sel + lv_sub_where
End if

//	Set NPI values
IF isx_ratio_select_parms.b_npi THEN
	//	If prov_id = MULTIPLE do not join on prov_id only on NPI. See SPR 5382
	IF Upper( ls_prov ) = "MULTIPLE" AND is_use_catgproc <> 'N' THEN
		ls_prov_where = " and ( " + inv_type[2] + ".PROV_NPI = '" + ls_npi + "' ) " + &
		" and ( " + inv_type[1] + ".PROV_NPI = " + inv_type[2] + ".PROV_NPI ) "
	ELSE
		ls_prov_where = " and ( " + inv_type[2] + ".PROV_NPI = '" + ls_npi + "' ) " + &
		" and ( " + inv_type[1] + ".PROV_NPI = " + inv_type[2] + ".PROV_NPI ) " + &
		" and ( " + inv_type[2] + ".PROV_ID = '" + ls_prov + "' ) " + &
		" and ( " + inv_type[1] + ".PROV_ID = " + inv_type[2] + ".PROV_ID ) "
	END IF
ELSE
	ls_prov_where = " and ( " + inv_type[2] + ".PROV_ID = '" + ls_prov + "' ) " + &
	" and ( " + inv_type[1] + ".PROV_ID = " + inv_type[2] + ".PROV_ID ) "
END IF

//JOHN_WO 3.6 SPEC 127 Modify where clause when use_catgproc = n.
//  logic to create 1 "where" clause for each report line selected
IF iv_rpt_type = 'R1' THEN
	//  RATIO 1 REPORT
	If is_use_catgproc = 'N' Then
		lv_where_clause = ' ( ' + inv_type[1] + '.cat_of_serv  = ~'' + Upper( ls_cat ) + '~' ) ' + & 
		' and ( ' + inv_type[2] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
		' and ( ' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
		ls_prov_where + &
		' and ( ' + inv_type[2] + '.PERIOD = ' + string(in_period) + ' ) ' + &
		' and ( ' + inv_type[2] + '.PERIOD = ' + inv_type[1] + '.PERIOD ) ' + &
		' and ( ' + inv_type[2] + '.PROC_CODE = ~'' + Upper( ls_cat ) + '~' ) '
		if (isx_ratio_rpt_parms.b_alw_chrg) then
			lv_where_clause = lv_where_clause + 	' and ( ' + inv_type[2] + '.ALW_CHRG > 0 ) ' 
		end if
	Else
		lv_where_clause = '( ' + inv_type[3] + '.CATG_ID = ~'' + Upper( ls_cat ) + '~' ) ' + & 
		' and ( ' + inv_type[1] + '.cat_of_serv  = ~'' + Upper( ls_cat ) + '~' ) ' + & 
		' and ( ' + inv_type[1] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
		' and ( ' + inv_type[2] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
		' and ( ' + inv_type[1] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
		' and ( ' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
		ls_prov_where + &
		' and ( ' + inv_type[1] + '.PERIOD = ' + string(in_period) + ' ) ' + &
		' and ( ' + inv_type[3] + '.PERIOD = ' + string(in_period) + ' ) ' + &
		' and ( ' + inv_type[2] + '.PERIOD = ' + string(in_period) + ' ) ' + &
		' and ( ' + inv_type[2] + '.PROC_CODE IN ' + lv_subquery + ' ) ' + &
		' and ( ' + inv_type[3] + '.CATG_PROC = ' + inv_type[2] + '.PROC_CODE ) '
		if (isx_ratio_rpt_parms.b_alw_chrg) then
			lv_where_clause = lv_where_clause + 	' and ( ' + inv_type[2] + '.ALW_CHRG > 0 ) ' 
		end if
	End If
ELSE
   IF iv_rpt_type = 'R2' THEN
	   //  RATIO 2 REPORT
		If is_use_catgproc = 'N' Then
			lv_where_clause = ' ( ' + inv_type[1] + '.cat_of_serv  = ~'' + Upper( ls_cat ) + '~' ) ' + & 
			' and ( ' + inv_type[2] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
			' and ( ' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
			ls_prov_where + &
			' and ( ' + inv_type[2] + '.PERIOD = ' + string(in_period) + ' ) ' + &
			' and ( ' + inv_type[2] + '.PERIOD = ' + inv_type[1] + '.PERIOD ) ' + &
			' and ( ' + inv_type[2] + '.PROC_CODE = ~'' + Upper( ls_cat ) + '~' ) '
			if (isx_ratio_rpt_parms.b_alw_chrg) then
				lv_where_clause = lv_where_clause + 	' and ( ' + inv_type[2] + '.ALW_CHRG > 0 ) ' 
			end if
		Else
		   lv_where_clause = '( ' + inv_type[3] + '.CATG_ID = ~'' + Upper( ls_cat ) + '~' ) ' + & 
		   ' and ( ' + inv_type[1] + '.cat_of_serv  = ~'' + Upper( ls_cat ) + '~' ) ' + & 
	   	' and ( ' + inv_type[1] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
		   ' and ( ' + inv_type[2] + '.PRov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
		   ' and ( ' + inv_type[1] + '.PRov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
	   	' and ( ' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
		   ls_prov_where + &
		   ' and ( ' + inv_type[1] + '.PERIOD = ' + string(in_period) + ' ) ' + &
		   ' and ( ' + inv_type[3] + '.PERIOD = ' + string(in_period) + ' ) ' + &
	   	' and ( ' + inv_type[2] + '.PERIOD = ' + string(in_period) + ' ) ' + &
		   ' and ( ' + inv_type[2] + '.PROC_CODE IN ' + lv_subquery + ' ) ' + &
		   ' and ( ' + inv_type[3] + '.CATG_PROC = ' + inv_type[2] + '.PROC_CODE ) '
		if (isx_ratio_rpt_parms.b_alw_chrg) then
			lv_where_clause = lv_where_clause + 	' and ( ' + inv_type[2] + '.ALW_CHRG > 0 ) ' 
		end if
		End If
   ELSE
   	//  RATIO 3 REPORT
		//Prob 966--SWD-- Got rid of Alw_chrg > 0 for Ratio 3
		
	// FNC 03/30/00 Start
		If left(iv_rpt_ver,1) = '2' Then
			if isx_ratio_select_parms.b_npi  then 
				lv_where_clause = '(' + inv_type[1]+'.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' )'+ &
					' and (' + inv_type[2] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' )' + &
					' and (' + inv_type[1] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' )' + &
					' and (' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' )' + &
					' and ( ' + inv_type[1] + '.PROV_ID = ' + inv_type[2] + '.PROV_ID )' + &
					' and ( ' + inv_type[1] + '.PROV_NPI = ' + inv_type[2] + '.PROV_NPI )'
			else
				lv_where_clause = '(' + inv_type[1]+'.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' )'+ &
					' and (' + inv_type[2] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' )' + &
					' and (' + inv_type[1] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' )' + &
					' and (' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' )' + &
					' and ( ' + inv_type[1] + '.PROV_ID = ' + inv_type[2] + '.PROV_ID )'
			end if
		ELSE 
		  lv_where_clause ='('+ inv_type[1] +'.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
					' and ( ' + inv_type[2] + '.Prov_SPEC = ~'' + Upper( ls_spec ) + '~' ) ' + &
					' and ( ' + inv_type[1] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
					' and ( ' + inv_type[2] + '.Prov_AREA = ~'' + Upper( ls_area ) + '~' ) ' + &
					ls_prov_where
		END IF
		
		If ib_prior_period then
			lv_where_clause = lv_where_clause + &
			' and ( ' + inv_type[1] +'.PERIOD = ' + string(in_period)+' )' + &
			' and ( ' + inv_type[2] + '.PERIOD = ' + string(isx_ratio_rpt_parms.ll_prior_period)+' )' 
		else
			lv_where_clause = lv_where_clause + &
			' and ( ' + inv_type[1] +'.PERIOD = ' + string(in_period)+' )' + &
			' and ( ' + inv_type[2] + '.PERIOD = ' + string(in_period) + ' ) '
		
		END IF
	END IF
END IF

lv_final_where = lv_where_clause

//  the full "where" clause without the "where" word.
gv_stack1 = lv_final_where
lv_final_where = ' where ' + lv_final_where

If arg_sql_type = 'count' OR arg_sql_type = 'COUNT' then
	iv_full_sql = UPPER(lv_sel + lv_from + lv_final_where )
else
	iv_full_sql = UPPER(lv_sel + lv_from + lv_final_where + lv_group_by + lv_order_by)
end if

RETURN 1
end function

public subroutine wf_process_crit_for_display (string in_sql);//This function will take the in_sql and create the criteria output
//for both the MLE in the window and the Datawindow
//    ARGUMENTS:	STRING IN_SQL - SQL used for select
//						STRING IN_HEADER - Header of report
//This function is a duplicate of the same function in W_PARENT_RPT
/////////////////////////////////////////////////////////////////////
//
//	05/01/01	GaryR	Stars 4.7 DataBase Port - Eliminate view CODE_DESC
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI 
//
/////////////////////////////////////////////////////////////////////


string crit, criteria_string
long position

SetPointer(HourGlass!)
//These statements fill the mle with all information after the WHERE
//in the SQL Statement
position = pos (in_sql,'WHERE')+6
crit = mid(in_sql,position)
position = pos(crit,'ORDER')
if position <> 0 then
	crit = left(crit,position - 1) 
end if

//These statements change all likes back to equal signs//
position = pos(crit,'LIKE')

if position <> 0 then
	criteria_string = left(crit,position - 1) + '='+mid(crit,position+4)
else
	criteria_string = crit
end if
mle_crit.text = criteria_string     // LOAD MLE
end subroutine

public function integer wf_hide_npi (integer ai_rpt_type);/////////////////////////////////////////////////////////////////////////////
//
//	Argument		Integer - ai_rpt_type:	1 = d_ratio_rpt 
//													2 = d_ratio_rpt_3_ver_1 
//													3 = d_ratio_rpt_3_ver_2
//
//	Returns		Integer - 1 = Success 2 = Error
//
/////////////////////////////////////////////////////////////////////////////
//
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//
/////////////////////////////////////////////////////////////////////////////

CHOOSE CASE ai_rpt_type
	CASE 1	//d_ratio_rpt
		IF isx_ratio_select_parms.b_npi THEN
			dw_1.Object.prov_id_t.text = "Prov ID"
			dw_1.Object.nbr_prov_t.text = "Nbr~n~rNPI"
		ELSE
			dw_1.Object.prov_npi.Visible = "0"
			dw_1.Object.prov_npi_t.Visible = "0"
			dw_1.Object.prov_npi.Width = "0"
			dw_1.Object.prov_npi_t.Width = "0"
		END IF
	CASE 2	// d_ratio_rpt_3_ver_1
		IF isx_ratio_select_parms.b_npi THEN
			dw_1.Object.prov_id_t.text = "Prov ID"
			dw_1.Object.prov_ratio_3_t.text = "%Chg NPI Allwd Chrgs"
			dw_1.Object.nbr_prov_prev_t.text = "# NPI~n~rPrior"
			dw_1.Object.nbr_prov_cur_t.text = "# NPI~n~rCurrent"
			dw_1.Object.rank_t.text = "Total NPI~n~rRank"
		ELSE
			dw_1.Object.prov_npi.Visible = "0"
			dw_1.Object.prov_npi_t.Visible = "0"
			dw_1.Object.prov_npi.Width = "0"
			dw_1.Object.prov_npi_t.Width = "0"
		END IF
	CASE 3	// d_ratio_rpt_3_ver_2
		IF isx_ratio_select_parms.b_npi THEN
			dw_1.Object.ratio_3_t.text = "%Chg NPI Allwd Chrgs"
			dw_1.Object.nbr_prov_prev_t.text = "# NPI~n~rPrior"
			dw_1.Object.nbr_prov_cur_t.text = "# NPI~n~rCurrent"
		END IF
	CASE ELSE
		MessageBox( "ERROR", "Invalid argument passed to wf_hide_npi" )
		Return -1
END CHOOSE

Return 1
end function

event open;call super::open;//***********************************************************************
//  OPEN EVENT FOR W_RATIO_RPT - Extend the ancestor
//  TO BUILD SQL THAT RETRIEVES DATA AND CREATES RATIO REPORTS
//
//***********************************************************************
// FNC	05/04/99	FS/TS1804c Starcare track 1804. Determine if ratio 3 report
//						will display allowed amount or billed amount.
//	NLG	04/20/99	TS2239. Remove references to gv_period and gv_period_key.
//						Structure passed to each ratio window instead of string.
// FNC	2/24/99	Test for PVCS
// FNC	01/12/99 TS1809D Stars 4.0 (SP1). Call set colors after setting the
//						dataobject.
// AJS   07/20/98 4.0 Track #1517 Replace header names to correct cde/decde
//                hdr1,hdr2,hdr3 _t to _h;     rpt_period_t to rpt_period;
//                rpt_cutoff_percent_t to rpt_cutoff_percent;
//	FDG	1/20/98	Rel 3.6 prob 173 - When using proc_code instead of
//						category, change the lookup table type & column name
// AO    1/23/97  stars35 prob#231 use base_type instead of invoice_type
//                for dental
// FDG	04/11/96	Prob 190 - Get message.stringparm immediately
//	SB		9/10/96	Changed the lv_sql_for_rat_3 to allow dental ratios to be
//						used.  I added ls_sqlprt1, ls_sqlprt2 to the variable
//						list to be used when parsing the statement.  The statement
//						is then put back together with the dental table name
// FNC	03/30/00	Track 2664 Starcare FS/TS2664c Stars 4.5. Apply the 
//						prior period to the sum_ratio_detail table only. Not to
// 					the prov_ratio_detail_table
//	FDG	09/13/00	Track 2986 (Stars 4.5 SP1).  When displaying Ratio 
//						Report 3 Specialty/Area Statistics (d_ratio_rpt_3_ver_1),
//						a system error occurs with prov_allw_chg_prev_t.
// FDG	02/20/01	Stars 4.7.  Use of_connect() in case an alter session command is needed
//	GaryR	01/09/02	Track 2641D	Column function changed to function_name
// MikeF	10/03/02	Track 2804d	Code Decode not working for tables with Prefixes
//	GaryR	11/08/02	SPR 4770c	Do not hard-code the lookup code
// JasonS 1/14/03 Track 2403d Close cursor if there are no results
// Katie  01/11/05 Track 5431c Changed global references to instance.
// MikeF	09/28/05	SPR4523d	Wouldn't retrieve more than 32K rows.
// HYL 	01/19/06 Track 4608d Change report header
//	GaryR	04/14/08	SPR 4435	Accommodate Ratios by NPI
// GaryR	05/01/08	SPR 4435	Remove obsolete dental logic
//	GaryR	06/13/08	SPR 5378	Unhide the Query button Ratios run by Proc Code
//	Katie	06/19/08	SPR 5397	Changed labels for ratio_3 and prov_ratio_3 when ib_use_bill true
//	Katie	06/20/08 SPR 5399		Added code to update header for Ratio 3 Version 2.
//***********************************************************************

BOOLEAN EOF,  lv_first_rec
string lv_sql_stmt, SRC, lv_sql_for_rat_3, ls_cutoff_percent, ls_return
LONG sqldbrc, tabpos, ll_row_count, ll_row, ll_days, ll_row_period
string lv_ccyy, lv_per, lv_temp, lv_order_by,lv_group_by
long 	lv_pos,lv_end_str
string crit,lv_crit,lv_sql,lv_window_name,left_side, right_side,ls_period, ls_desc
iNT li_cnt,li_rc,lv_start,lv_index, ll_min_days,li_upper, li_idx
integer li_p3_pos, li_table_pos, li_where_pos, li_cutoff_percent

datetime ld_pay_from, ld_row_date
Decimal  ld_cutoff_percent_float
integer	li_row_period_key
String	ls_crit_ind, ls_npi, ls_heading, ls_where

setpointer(hourglass!)
setmicrohelp(w_main,'Retrieving rows...')

This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

lv_sql_stmt = isx_ratio_select_parms.s_sql_statement
ls_where = isx_ratio_select_parms.s_sql_where
iv_rpt_type = isx_ratio_select_parms.s_rpt_type
iv_rpt_ver = isx_ratio_select_parms.s_rpt_ver
iv_invoice_type = isx_ratio_select_parms.s_invoice_type
//NLG TS2239																			***STOP*******

//AJS 2/10/98 Get the correct dataobjects for Report type of R3
IF iv_rpt_type = 'R3' then
	if left(iv_rpt_ver,1) = '2' then
		dw_1.dataobject = 'd_ratio_rpt_3_ver_2'
	Else
		dw_1.dataobject = 'd_ratio_rpt_3_ver_1'
	end if
END IF
	
// FNC 05/04/99 Start
ib_use_bill  =  isx_ratio_select_parms.b_use_bill
// FNC 05/04/99 End

This.Event	ue_set_window_colors (This.Control)

//KMM 7/17/95 Prob#554 Get table name to get table type for lookup
lv_sql = upper(lv_sql_stmt)
lv_pos = pos(lv_sql,'FROM')
if lv_pos > 0 then
	lv_sql = mid(lv_sql,lv_pos + 5)
end if
lv_pos = pos(lv_sql,'WHERE')
if lv_pos > 0 then
	lv_sql = left(lv_sql,lv_pos - 1)
end if
lv_pos = pos(lv_sql,' ')
if lv_pos > 0 then
	lv_sql = left(lv_sql,lv_pos - 1)
end if
iv_table_name = lv_sql

lv_first_rec = TRUE

//in_period = gv_period
in_period = isx_ratio_select_parms.l_period//NLG TS2239 Don't use globals for period
setpointer(hourglass!)

lv_window_name = UPPER(this.classname())

il_mle_x			=	mle_crit.x
il_mle_y			=	mle_crit.y
il_mle_height	=	mle_crit.height
il_mle_width	=	mle_crit.width
il_dw_x			=	dw_1.x
il_dw_y			=	dw_1.y
il_dw_height	=	dw_1.height
il_dw_width		=	dw_1.width


//*******************************************//
// select the payment dates from period_cntl //
//*******************************************//
//john-wo 8/97 for rel 3.6 spec 161 - added lf_cutoff_percent_float to the following sql 
//statement and added the dw_modify to add the text to the report.
SELECT period_desc,
		 payment_from_date,
		 cutoff_percent_float,
		 use_catgproc,
		 crit_ind
INTO   :ls_desc,
		 :ld_pay_from,
		 :ld_cutoff_percent_float,  //john-wo 3.6
		 :is_use_catgproc,  //john-wo 3.6 spec 127
		 :ls_crit_ind
FROM   period_cntl
WHERE  function_name = 'RATIO' and						//	GaryR	01/09/02	Track 2641D
       invoice_type = Upper( :iv_invoice_type ) and
       period = :in_period
USING  stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Ratio Report', 'Error selecting from period_cntl')
	Return
else
	Commit using stars2ca;
end if
//john_wo added the next 4 lines for rel 3.6 8/97 spec 161.
ld_cutoff_percent_float = Round(ld_cutoff_percent_float,2)
li_cutoff_percent = ld_cutoff_percent_float * 100
ls_cutoff_percent = String(li_cutoff_percent)
ls_return = dw_1.Modify('rpt_period.text = ' + '~'' + ls_desc + '~'')
ls_return = dw_1.Modify('rpt_cutoff_percent.text = ' + '~'' + ls_cutoff_percent + '~'')
ls_return = dw_1.Modify('rpt_cutoff_percent.text = ' +  ls_cutoff_percent )
ls_return = dw_1.Modify('rpt_cutoff_percent.text = ' + '~'' + ls_cutoff_percent + '~'')
if (left(ls_crit_ind,1) = '1') then
	isx_ratio_rpt_parms.b_alw_chrg = True
else 
	isx_ratio_rpt_parms.b_alw_chrg = False
end if

//	FDG 12/18/97 for rel 3.6 prob 173
IF	Upper (is_use_catgproc)	=	'N'		THEN
	//	Using procedure code instead of category
	ls_return = dw_1.Modify('cat_of_serv_t.text = ' + '~'' + 'Proc~rCode' + '~'')
END IF

// Check NPI
IF isx_ratio_select_parms.b_npi THEN
	ls_npi = "NPI "
	This.title = "Ratio Reports by NPI"
END IF

//**********************************************//
// if it is report 3 determine the prior period //
//**********************************************//

IF iv_rpt_type = 'R3' then

   gb_1.Visible = true
   rb_1.Visible = true
   rb_2.Visible = true

	dw_period_list.Reset()
	dw_period_list.SetTransObject(stars2ca)
	dw_period_list.Retrieve('RATIO', iv_invoice_type, 'AC')

	SetNull(ll_min_days)

	ll_row_count = dw_period_list.RowCount()
	
	// FNC 03/30/00 Start
	FOR ll_row = 1 to ll_row_count
		ld_row_date = dw_period_list.GetItemDatetime(ll_row, 'payment_from_date')
		ll_row_period = dw_period_list.GetItemNumber(ll_row, 'period')
		li_row_period_key = dw_period_list.GetItemNumber(ll_row, 'period_key')
		ll_days = DaysAfter(date(ld_row_date), date(ld_pay_from))
	
		if (ll_row = 1) and (ll_row_period <> in_period) and (ll_days > 0) then
				ll_min_days = ll_days
				isx_ratio_rpt_parms.ll_prior_period = ll_row_period
				isx_ratio_rpt_parms.li_prior_period_key = li_row_period_key
		elseif (ll_row_period <> in_period) and (ll_days > 0) and ((ll_days < ll_min_days) or IsNull(ll_min_days)) then
					ll_min_days = ll_days
					isx_ratio_rpt_parms.ll_prior_period = ll_row_period
					isx_ratio_rpt_parms.li_prior_period_key = li_row_period_key
		end if
	NEXT
	
	if (ll_min_days <= 0) or IsNull(ll_min_days) then
		rb_2.enabled = FALSE
	end if
	
   if left(iv_rpt_ver,1) = '2' then
		dw_1.dataobject = 'd_ratio_rpt_3_ver_2'
		This.wf_hide_npi(3)
      lv_order_by = ' ORDER BY Prov_SPEC, Prov_AREA'
		//This was added for prob 907//
		lv_group_by = ' GROUP BY PROV_RATIO_3_RPT.Prov_SPEC, PROV_RATIO_3_RPT.Prov_AREA'
		dw_1.Modify('hdr1_h.text = ~'' + ls_npi + 'RATIO 3 REPORT~'')
		// FNC 05/04/99 Start
		IF ib_use_bill  THEN
			dw_1.object.total_allw_chg_prev_t.text = 'Bill Chrg Prior'
			dw_1.object.total_allw_chg_cur_t.text = 'Bill Chrg Current'
			dw_1.object.avg_allw_chg_prev_t.text = 'Avg Bill Chrg Prior'
			dw_1.object.avg_allw_chg_cur_t.text = 'Avg Bill Chrg Current'
			dw_1.object.ratio_3_t.text = '% Chg Prov Bill Chrgs'
		END IF
		// FNC 05/04/99 End
   else
      dw_1.dataobject = 'd_ratio_rpt_3_ver_1'
		This.wf_hide_npi(2)
      if left(iv_rpt_ver,1) = '1' then
         dw_1.Modify('hdr1_h.text = ~'' + ls_npi + 'RATIO 3 REPORT~'')
         lv_order_by = ' ORDER BY PROV_RATIO_3 DESC'
      else
         dw_1.Modify('hdr1_h.text = ~'' + ls_npi + 'RATIO 3 REPORT WITHIN SPECIALTY / AREA~'')
         lv_order_by = ' ORDER BY Prov_SPEC, Prov_AREA, PROV_RATIO_3 DESC'	
      end if
		// FDG 09/13/00 - Move "IF ib_use_bill" under this "else" so it is
		//						associated with 'd_ratio_rpt_3_ver_1'
		// FNC 05/04/99 Start
		IF ib_use_bill  THEN
			dw_1.object.prov_allw_chg_prev_t.text = 'Bill Chrg Prior'
			dw_1.object.prov_allw_chg_cur_t.text = 'Bill Chrg Current'
			dw_1.object.avg_allw_chg_prev_t.text = 'Avg Bill Chrg Prior'
			dw_1.object.avg_allw_chg_cur_t.text = 'Avg Bill Chrg Current'
			dw_1.object.prov_ratio_3_t.text = '% Chg Prov Bill Chrgs'
			dw_1.object.ratio_3_t.text = '% Chg Tot Bill Chrgs'
			dw_1.Modify('hdr2_h.text = ~'' + ls_npi + 'PROVIDERS BY PERCENT INCREASE IN BILL CHARGES~'') // HYL 01/19/06 Track 4608d Change report header
		END IF
		// FNC 05/04/99 End
   end if
 
   dw_1.Modify('rpt_period.text = ' + '~'' + ls_desc + '~'')
   dw_1.settransobject(stars1ca)
   lv_sql_for_rat_3 = UPPER(dw_1.GetSqlSelect())
	
	// Replace NPI
	IF NOT isx_ratio_select_parms.b_npi THEN
		li_p3_pos = Pos( lv_sql_for_rat_3, "PROV_NPI" )
		IF li_p3_pos > 0 THEN
			lv_sql_for_rat_3 = Replace( lv_sql_for_rat_3, li_p3_pos, 8, "' '" )
		END IF
	END IF

	//1-9-98 Archana
	li_p3_pos = pos(lv_sql_for_rat_3,"FROM")
	left_side = left(lv_sql_for_rat_3, li_p3_pos - 1)
	li_table_pos = pos(lv_sql_stmt, "FROM")
	
	right_side = mid(lv_sql_stmt, li_table_pos)
	li_where_pos = pos(right_side, "WHERE")
	right_side = left(right_side, li_where_pos - 1)
	lv_sql_for_rat_3 = left_side + right_side
	
	//This was added for prob 907
	//Version 2 needs everything grouped together.
   if left(iv_rpt_ver,1) = '2' then
		lv_group_by = "GROUP BY "+REPLACE(UPPER(lv_sql_for_rat_3),1,7,"")	
		lv_start = pos(UPPER(lv_group_by),"FROM")
		lv_end_str = len(lv_group_by)
		lv_group_by = REPLACE(UPPER(lv_group_by),lv_start,lv_end_str,"")
	end if

   lv_sql_for_rat_3 = lv_sql_for_rat_3 + ' WHERE ' + ls_where + lv_group_by+lv_order_by
	dw_1.SetSQLSelect(lv_sql_for_rat_3)
	
	// MikeF 10/3/02 - Track 2804 - Begin
	li_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars1ca)
	
	If li_rc = -5 Then
		lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
		ddlb_dw_ops.deleteitem(lv_index)
	End If
	
	if gc_debug_mode = true then
      MessageBox("SQL for Ratio 3 Report Open OF Report", lv_sql_for_rat_3)
   end if
ELSE
	// MikeF 10/3/02 - Track 2804 - Begin
	// Set the datawindow SQL 
	dw_1.SetSQLSelect(lv_sql_stmt)
	This.wf_hide_npi(1)

	li_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars1ca)
	
	If li_rc = -5 Then
		lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
		ddlb_dw_ops.deleteitem(lv_index)
	End If
	// MikeF 10/3/02 - Track 2804 - End
	
	// FNC 05/04/99 Start
	IF ib_use_bill  THEN
		Dw_1.object.nbr_srvc_t.text = 'Bill Srvcs'
	END IF
	// FNC 05/04/99 End

	//  Set the reporting period and title into the Ratio 1 report header
	dw_1.Modify('rpt_period.text = ' + '~'' + ls_desc + '~'')
	IF iv_rpt_type = 'R1' THEN
		CHOOSE CASE left(iv_rpt_ver,1)
			CASE '1'
				ls_heading = ls_npi + 'PROVIDER RATIO 1 - BY # CATEGORIES, AVG. RANK'
				SRC = dw_1.Modify('hdr2_h.text = ~''+ ls_heading + '~'')		//KMM 7/12/95 Prob#407 Changed name 
				
			CASE '2'
				ls_heading = ls_npi + 'PROVIDER RATIO 1 - BY SPECIALITY'
				SRC = dw_1.Modify('hdr2_h.text = ~''+ ls_heading + '~'')		//KMM 7/12/95 Prob#407 Changed name 

			CASE ELSE
				ls_heading = ls_npi + 'PROVIDER RATIO 1 - BY TOP PROVIDERS'
				SRC = dw_1.Modify('hdr2_h.text = ~''+ ls_heading + '~'')		//KMM 7/12/95 Prob#407 Changed name 
		END CHOOSE
	ELSE
   	IF iv_rpt_type = 'R2' THEN
		//  Ratio 2 report.
			CHOOSE CASE left(iv_rpt_ver,1)
		   	CASE '1'
					ls_heading = ls_npi + 'PROVIDER RATIO 2 - BY # CATEGORIES, AVG. RANK'
					SRC = dw_1.Modify('hdr2_h.text = ~''+ ls_heading + '~'')		//KMM 7/12/95 Prob#407 Changed name 
		   	CASE '2'
					ls_heading = ls_npi + 'PROVIDER RATIO 2 - BY SPECIALITY'
					SRC = dw_1.Modify('hdr2_h.text = ~''+ ls_heading + '~'')		//KMM 7/12/95 Prob#407 Changed name 
		   	CASE ELSE
					ls_heading = ls_npi + 'PROVIDER RATIO 2 - BY TOP PROVIDERS'
					SRC = dw_1.Modify('hdr2_h.text = ~''+ ls_heading + '~'')		//KMM 7/12/95 Prob#407 Changed name
	   	END CHOOSE
		ELSE
  			//  Assume Ratio 3 report.
		END IF
	END IF

	if ls_where <> '' then
		ls_where = ' and ' + ls_where
		wf_process_crit_for_display(ls_where)
	end if
END IF

//	Retrieve
dw_1.SetTransObject(Stars1ca)
dw_1.retrieve()

If stars1ca.of_commit() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars1')
	Return
End If	

//KMM 7/10/95 Prob#408 Added code to open no data window when dw rowcount = 0
ll_row_count = dw_1.rowcount()
if ll_row_count <=  0 then 
	lv_crit = lv_crit + '@@' + ls_heading
	this.windowstate = minimized!
	OpenSheetwithParm(w_claim_rpt_no_data,lv_crit,MDI_main_frame,help_menu_position,original!)
	cb_close.Postevent(clicked!)
	SETMICROHELP(w_main,'Ready')
	return
else
	st_row_count.text = String( ll_row_count )
	dw_1.triggerevent(rowfocuschanged!)
	SetMicroHelp(w_main,'Ready')
	Setfocus(dw_1)
end if
end event

event activate;// Katie 01/11/05 Track 5431c Changed global reference to instance and added event to restore menu to window
//						settings.
//	GaryR	06/13/08	SPR 5378	Hide the Query button Ratios run by Proc Code

if ib_show_sql = FALSE THEN
   dw_1.X      = il_mle_x	-	5
   dw_1.Y      = 17
	dw_1.Height = st_dw_ops.y  -  20
   mle_crit.HIDE ()  
else
   dw_1.X      = il_dw_x
   dw_1.Y      = il_dw_y
   dw_1.Height = il_dw_height
   mle_crit.Show ()         
end if

m_stars_30.m_file.m_showsql.event ue_restore_win_settings()
end event

event close;call super::close;// Katie 01/11/05 Track 5431c Added code to reset menu settings.

m_stars_30.m_file.m_showsql.event ue_reset()

if isvalid( iv_uo_win ) Then
	close(iv_uo_win)
end if

end event

on w_ratio_rpt.create
int iCurrent
call super::create
this.dw_period_list=create dw_period_list
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.cb_query=create cb_query
this.mle_crit=create mle_crit
this.st_row_count=create st_row_count
this.cb_close=create cb_close
this.cb_view=create cb_view
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_period_list
this.Control[iCurrent+2]=this.st_dw_ops
this.Control[iCurrent+3]=this.ddlb_dw_ops
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_query
this.Control[iCurrent+8]=this.mle_crit
this.Control[iCurrent+9]=this.st_row_count
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.cb_view
this.Control[iCurrent+12]=this.gb_1
end on

on w_ratio_rpt.destroy
call super::destroy
destroy(this.dw_period_list)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.cb_query)
destroy(this.mle_crit)
destroy(this.st_row_count)
destroy(this.cb_close)
destroy(this.cb_view)
destroy(this.gb_1)
end on

event ue_preopen;//04-20-99 NLG TS2239.  Structure passed instead of string. Passing period and period key as part of structure.
//is_stringparm	=	Message.StringParm		// FDG 04/11/96
////KMM Clear out message parm (PB Bug)
//SetNull(message.stringparm)					
isx_ratio_select_parms = message.PowerObjectParm
setNull(message.PowerObjectParm)

end event

event resize;call super::resize;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_ratio_rpt
//		Event Name:		Resize - Extend the ancestor
//
//************************************************************************
//
//	FDG	07/29/97	When resizing the window, the resized dimensions of
//						dw_1 & mle_crit must be computed for the activate event.
//
//************************************************************************


il_mle_x			=	mle_crit.x
il_mle_y			=	mle_crit.y
il_mle_height	=	mle_crit.height
il_mle_width	=	mle_crit.width
il_dw_x			=	dw_1.x
il_dw_y			=	dw_1.y
il_dw_height	=	dw_1.height
il_dw_width		=	dw_1.width


end event

event deactivate;call super::deactivate;// Katie 01/11/05 Track 5431c Added code to reset menu settings.
m_stars_30.m_file.m_showsql.event ue_reset()
end event

type dw_period_list from u_dw within w_ratio_rpt
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control "
integer x = 1920
integer y = 2012
integer width = 87
integer height = 92
integer taborder = 20
string dataobject = "d_period_list"
end type

type st_dw_ops from statictext within w_ratio_rpt
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 9
integer y = 1908
integer width = 704
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type ddlb_dw_ops from dropdownlistbox within w_ratio_rpt
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 9
integer y = 1984
integer width = 713
integer height = 196
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.

string lv_control_text

setpointer(hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)


end event

type rb_2 from radiobutton within w_ratio_rpt
boolean visible = false
string accessiblename = "Prior"
string accessibledescription = "Prior"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1093
integer y = 2056
integer width = 251
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Prior"
end type

event clicked;//***********************************************************************
// FNC	03/30/00	Track 2664 Starcare FS/TS2664c Stars 4.5. Apply the 
//						prior period to the sum_ratio_detail table only. Not to
// 					the prov_ratio_detail_table
//***********************************************************************
// FNC 03/30/00 Start
//in_period = il_prior_period

ib_prior_period = TRUE

// FNC 03/30/00 End

end event

type rb_1 from radiobutton within w_ratio_rpt
boolean visible = false
string accessiblename = "Current"
string accessibledescription = "Current"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1093
integer y = 1984
integer width = 352
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Current"
boolean checked = true
end type

event clicked;//***********************************************************************
// FNC	03/30/00	Track 2664 Starcare FS/TS2664c Stars 4.5. Apply the 
//						prior period to the sum_ratio_detail table only. Not to
// 					the prov_ratio_detail_table
//***********************************************************************

//string lv_ccyy, lv_per
//
//lv_ccyy = mid(string(in_period),1,4)
//lv_per = '05'
//in_period = long(lv_ccyy + lv_per)
//

//in_period = gv_period

// FNC 03/30/00 Start
//in_period = isx_ratio_select_parms.l_period	//NLG TS2239 don't use globals for period

ib_prior_period = FALSE

// FNC 03/30/00 End
end event

type dw_1 from u_dw within w_ratio_rpt
string tag = "CRYSTAL, title = Ratio Report"
string accessiblename = "Ratio Report"
string accessibledescription = "Ratio Report"
integer x = 5
integer y = 196
integer width = 3346
integer height = 1720
string dataobject = "d_ratio_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;//  Doubleclicked event for dw_1, w_ratio_rpt
//*******************************************************************
//	FDG	01/20/98	Rel 3.6 prob 173 - If using proc_code instead of category,
//					 	change the clicked column to proc_code for code lookup.
// AJS	11/28/97	TS242 Rel 3.6
// DKG	02/21/96	Added code to force Prov_Spec into the window 
//             	operations sort box. No matter what column is
//             	chosen, Prov_Spec will be first. PROB 813 StarCare
//             	disk.
//	GaryR	11/08/02	SPR 4770c	Do not hard-code the lookup code
//	HYL		02/06/06 Track 4641d	Get the first column which is Char type instead of 3rd column(char type in d_ratio_rpt_3_ver_1 and long type in d_ratio_rpt_3_ver_2) to match PB's getitemstring function.
//  Katie		09/14/06 SPR 4818  Removed line of code HYL edditted in SPR 4641d.
//  Katie		09/15/06	SPR 4818 Removed unused variable per Gary's Request.
//	GaryR	06/13/08	SPR 5378	Hide the Query button Ratios run by Proc Code
//*******************************************************************

long row_nbr,ll_rc
int li_pos
string lv_hold_object,lv_col

STRING	lv_default_sort = 'prov_spec_t	1'

/*gets the row and makes sure a row was clicked*/
setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_1)
//store the current row number and the column name
If lv_hold_object = '' then
	return
end if
li_pos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(li_pos - 1))
	
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
	IF dw_1.dataobject = 'd_ratio_rpt_3_ver_2' AND &
		lv_hold_object <> lv_default_sort THEN
		ll_rc = fx_dw_control(dw_1,lv_default_sort,in_dw_control,iv_uo_win,'',0,in_decode_struct)
	END IF
	ll_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	row_nbr = row
	ll_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	row_nbr = row
	ll_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',row_nbr,in_decode_struct)
Else
	if row > 0 Then cb_view.triggerevent(clicked!)
end if
end event

event rbuttondown;/////////////////////////////////////////////////////////////////
//
//	GaryR	11/08/02	SPR 4770c	Do not hard-code the lookup code
//
/////////////////////////////////////////////////////////////////

string lv_table_type, lv_where_message

String	ls_hold_object				//	FDG 12/22/97
String	ls_hold_col					//	FDG 12/22/97
String	ls_hold_row					//	FDG 12/22/97
Integer	li_pos						//	FDG 12/22/97

setpointer(hourglass!)
//KMM 7/17/95 Prob#554 Added to get table type for lookup
Select elem_tbl_type 
into :lv_table_type
from dictionary 
where elem_type = 'TB' 
and elem_name = Upper( :iv_table_name )
and elem_tbl_type not like 'O%' //DKK 1/6/96 - added to filter out FastTrack invoice types
and elem_tbl_type not like 'Q%' //DKG 1/6/96 - added to filter out FastTrack invoice types
using stars2ca;
if stars2ca.of_check_status() <> 0 then
	lv_where_message = 'elem_type = TB and elem_name = ' + iv_table_name 
	errorbox(stars2ca,'Error reading dictionary: ' + lv_where_message)
	return
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

//	FDG 12/22/97	Stars 3.6 (prob 173) - If right-clicking on "cat_of_serv"
//						and procedure code is being displayed, bypass fx_lookup
//						and do a lookup on procedure code ('PC')
ls_hold_object		=	This.GetObjectAtPointer()

IF	Trim (ls_hold_object)	>	' '		THEN
	//	A column was clicked.  The column name is left of "~t"
	li_pos		=	Pos (ls_hold_object, "~t")
	IF	li_pos	>	0							THEN
		ls_hold_col				=	Left (ls_hold_object, (li_pos - 1) )
		ls_hold_row				=	Mid  (ls_hold_object, (li_pos + 1) )
	END IF
END IF

fx_lookup(dw_1,lv_table_type)
end event

event rowfocuschanged;//  ROWFOCUSCHANGED FOR DW1 IN W_RATIO_RPT
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//	06/13/08	GaryR	SPR 5378	Hide the Query button Ratios run by Proc Code

Long	ll_row

/*gets the row and makes sure a row was clicked*/
ll_row = dw_1.getrow()
If ll_row = 0 then return

/*Highlights the selected row*/
SelectRow ( dw_1, 0, FALSE )
SelectRow ( dw_1, ll_row, TRUE )
end event

type cb_query from u_cb within w_ratio_rpt
string accessiblename = "Query"
string accessibledescription = "Query"
integer x = 2167
integer y = 1992
integer width = 393
integer height = 108
integer taborder = 60
integer weight = 400
string text = "&Query"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////
//
//  Clicked event for CB_QUERY, in W_ratio_RPT
//  John_wo 10/31/97 spec 127 - added code to perform the query on
//             w_ratio_proc_sum when we are not using the catgproc
//             file.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
// FNC test for PVCS
//
//////////////////////////////////////////////////////////////////////////////////////////
//
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
// 06/09/08	GaryR	SPR 5380	Use Stars1 for Report 3 count
//
//////////////////////////////////////////////////////////////////////////////////////////

u_nvo_count	lnv_count

//john_wo 10/31/97 - added the following statement.
If is_use_catgproc = 'N' Then
	If iv_rpt_type = 'R1' or iv_rpt_type = 'R2' Then
		is_perform_query_sw = 'Y'
		cb_view.TriggerEvent(clicked!)
		is_perform_query_sw = ''
		Return
	End If
End If

gv_active_invoice = iv_invoice_type

IF dw_1.getrow() < 1 THEN
	MessageBox("INVALID ROW","You must select a row with valid data in order to view details.  Please select a row that contains data.")
	Return
end if

st_row_count.text = "0"

IF iv_rpt_type = 'R1' THEN
	SetMicroHelp(w_main,"Now counting records for the Ratio 1 Procedure Summary")
ELSE
   IF iv_rpt_type = 'R2' THEN
   	SetMicroHelp(w_main,"Now counting records for the Ratio 2 Procedure Summary")
   ELSE
   	SetMicroHelp(w_main,"Now counting records for the Ratio 3 Procedure Summary")
   END IF
END IF

wf_build_proc_sum_sql( "count" )

if GC_DEBUG_MODE then
	clipboard('')
	clipboard(iv_full_sql)
	messagebox('SQL STATEMENT FOR COUNT OF PROC LIST REPORT ROWS.',iv_full_sql)
end if

//Get Count
lnv_count = CREATE u_nvo_count
lnv_count.uf_set_transaction( Stars1ca )
st_row_count.text = String( lnv_count.uf_get_count( iv_full_sql ) )
Destroy lnv_count

SetMicroHelp(w_main,"Ready")
end event

type mle_crit from multilineedit within w_ratio_rpt
string accessiblename = "Report Criteria"
string accessibledescription = "Report Criteria"
accessiblerole accessiblerole = textrole!
integer x = 5
integer y = 8
integer width = 3342
integer height = 184
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_row_count from statictext within w_ratio_rpt
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 9
integer y = 2088
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

type cb_close from u_cb within w_ratio_rpt
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2953
integer y = 1992
integer width = 393
integer height = 108
integer taborder = 80
integer weight = 400
string text = "&Close"
end type

on clicked;close(parent)
//close(w_ratio1_rpt)
//close(w_ratio1_proc_list)
//
//close(w_claim_rpt)
//close(w_header_rpt)
//close(w_line_rpt)
//close(w_claim_view)

end on

type cb_view from u_cb within w_ratio_rpt
string accessiblename = "View Data..."
string accessibledescription = "View Data..."
integer x = 2560
integer y = 1992
integer width = 393
integer height = 108
integer taborder = 70
integer weight = 400
string text = "&View Data..."
end type

event clicked;//  W_RATIO_RPT - CLICKED EVENT FOR CB_VIEW
//  Displays procedures for selected lines
//  test if selected columns are blank prior to executing the logic.
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	01/18/99	FDG	Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
//	04/20/99	NLG	TS2205c. Passing structures from ratio window to window.  Don't
//							use globals gv_period, gv_period_key
//	05/20/99	FDG	Track 1804c.  4.0 SP2.  Pass b_use_bill to w_ratio_proc_sum.
// FNC	03/30/00	Track 2664 Starcare FS/TS2664c Stars 4.5. Apply the 
//						prior period to the sum_ratio_detail table only. Not to
// 					the prov_ratio_detail_table
//	Katie	03/16/07	SPR 4942 Added ALW_CHRG to criteria where appropriate.
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//
//////////////////////////////////////////////////////////////////////////////

setmicrohelp(w_main,'Opening Details...') 
gv_active_invoice = iv_invoice_type

IF dw_1.getrow() < 1 THEN
	MessageBox("INVALID ROW","You must select a row with valid data in order to view details.  Please select a row that contains data.")
	Return
end if

//john_wo 10/31/97 - added the perform query switch
If is_perform_query_sw = 'Y' Then
	SetMicroHelp(w_main,"Query in process")
Else
	IF iv_rpt_type = 'R1' THEN
		SetMicroHelp(w_main,"Now generating the Ratio 1 Procedure Summary Report")
	ELSE
   	IF iv_rpt_type = 'R2' THEN
   		SetMicroHelp(w_main,"Now generating the Ratio 2 Procedure Summary Report")
	   ELSE
   		SetMicroHelp(w_main,"Now generating the Ratio 3 Procedure Summary Report")
   	END IF
	END IF
End If

IF wf_build_proc_sum_sql( "" ) = -1 THEN
	Messagebox("INVALID SELECTION OF DATA.","Please select a valid line from the Ratio 1 Report.")
	return
end if

if GC_DEBUG_MODE then
	clipboard('')
	clipboard(iv_full_sql)
	messagebox('SQL STATEMENT FOR RETRIEVE OF PROC LIST REPORT ROWS.',iv_full_sql)
end if 

if isvalid(w_ratio_proc_sum) Then
	close(w_ratio_proc_sum)
end if

//NLG TS2239c. Passing structure instead of string.								***START***
isx_ratio_rpt_parms.s_full_sql = iv_full_sql
isx_ratio_rpt_parms.s_rpt_type = iv_rpt_type
isx_ratio_rpt_parms.s_invoice_type = iv_invoice_type
isx_ratio_rpt_parms.s_use_catgproc = is_use_catgproc
isx_ratio_rpt_parms.s_perform_query_sw = is_perform_query_sw
isx_ratio_rpt_parms.b_use_bill = isx_ratio_select_parms.b_use_bill		// FDG 05/20/99
isx_ratio_rpt_parms.b_npi = isx_ratio_select_parms.b_npi

// 03/30/00 FNC Start
If ib_prior_period then
	isx_ratio_rpt_parms.l_period = 	isx_ratio_rpt_parms.ll_prior_period			
	isx_ratio_rpt_parms.l_period_key = isx_ratio_rpt_parms.li_prior_period_key 
else 
	isx_ratio_rpt_parms.l_period = isx_ratio_select_parms.l_period
	isx_ratio_rpt_parms.l_period_key = isx_ratio_select_parms.l_period_key
end if
// 03/30/00 FNC End

opensheetwithparm(w_ratio_proc_sum,isx_ratio_rpt_parms,MDI_Main_Frame,&
Help_menu_position,Layered!)
setmicrohelp(w_main,'Ready')
end event

type gb_1 from groupbox within w_ratio_rpt
boolean visible = false
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = groupingrole!
integer x = 1047
integer y = 1908
integer width = 713
integer height = 256
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Period"
end type

