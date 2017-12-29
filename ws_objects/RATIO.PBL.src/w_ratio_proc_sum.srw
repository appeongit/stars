$PBExportHeader$w_ratio_proc_sum.srw
$PBExportComments$Inherited from w_parent_rpt
forward
global type w_ratio_proc_sum from w_parent_rpt
end type
type st_dw_ops from statictext within w_ratio_proc_sum
end type
end forward

global type w_ratio_proc_sum from w_parent_rpt
long backcolor = 67108864
string accessiblename = "Ratio Report Procedure Summary"
string accessibledescription = "Ratio Report Procedure Summary"
accessiblerole accessiblerole = windowrole!
integer width = 3241
integer height = 2004
string title = "Ratio Report Procedure Summary"
event ue_go_to_next_window ( )
event ue_view_data ( )
event ue_close ( )
event ue_view_detail ( )
st_dw_ops st_dw_ops
end type
global w_ratio_proc_sum w_ratio_proc_sum

type variables
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI 

string iv_rpt_type
datetime id_payment_from, id_payment_thru, id_from_from, id_from_thru

sx_ratio_rpt_parms isx_ratio_rpt_parms
end variables

forward prototypes
private function integer wf_build_sql_for_claim (string arg_sql)
end prototypes

event ue_go_to_next_window();//ue_go_to_next_window for w_ratio_proc_sum - 
//john_wo rel 3.6 spec 127 - if is_use_catgproc = n, trigger cb_view_detail
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI 

this.visible = false

dw_1.SelectRow(1,True)
If isx_ratio_rpt_parms.s_perform_query_sw = 'Y' Then
	this.event ue_query()
	If IsValid(w_ratio_rpt) Then
		w_ratio_rpt.st_row_count.text = sle_count.text
	Else
		MessageBox('Query Error',&
			'Window w_ratio_rpt could not be found. Please contact Vips.')
	End If
Else
	this.event ue_view_data()
End If



end event

event ue_view_data();//  triggered from CB_VIEW_DETAIL,  FOR W_RATIO1_PROC_LIST
//
//john_wo 11/5/97 spec 127 3.6 Move all code from cb_view_detail and
//    created this user event.  This was done to keep the window
//    invisible when bypassing this window.
//
//	FDG	01/12/98	Stars 4.0 - Display the query engine window
//						instead of w_claim_rpt_ratio1
//	01/29/02	LahuS	Track 2552d	Predefined Report (PDR)
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI 

String	ls_rpt_title, ls_table_desc, ls_npi

gv_active_invoice = iv_invoice_type

SetMicroHelp(w_main,'Now generating the report.')

//	Clear out the query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

//	Save the invoice type, tbl_type & src type for query engine
inv_queryengine.uf_set_invoice_type(iv_invoice_type)
inv_queryengine.uf_set_tbl_type(iv_invoice_type)
inv_queryengine.uf_set_tbl_rel('GP')
inv_queryengine.uf_set_src_type(in_detail_struct.src_type)

CHOOSE CASE iv_rpt_type
	CASE 'R1'
		ls_rpt_title	=	'Ratio 1 Report'
	CASE 'R2'
		ls_rpt_title	=	'Ratio 2 Report'
	CASE 'R3'
		ls_rpt_title	=	'Ratio 3 Report'
END CHOOSE

select elem_desc into :ls_table_desc
from dictionary 
where elem_tbl_type = Upper( :iv_invoice_type ) and
		elem_type = 'TB' 
using stars2ca;

Stars2ca.of_check_status()

IF isx_ratio_rpt_parms.b_npi THEN ls_npi = "NPI "
inv_queryengine.uf_set_rpt_title(ls_npi + ls_rpt_title + ' - ' + ls_table_desc)

// This function will create the SQL necessary to retrieve the records 
if wf_build_sql_for_claim('') = -1 then Return

//	01/29/02	Lahu S	Track 2552d Predefined Report (PDR)
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Open the query engine window
inv_queryengine.uf_open_query_engine()

//  gv_cancel_but_clicked must be false going into w_claim_rpt open
//  event.  If not, that script will terminate after the retrieval of
//  the first table.   tpb  2-25-94
//gv_cancel_but_clicked = false

SetMicroHelp(w_main,'Ready')
end event

event ue_close;call super::ue_close;//john_wo spec 127 3.6 This is called from the open script.  It closes
//     the window successfully when performing a query from w_ratio_rpt
//     and you want this window to remain invisible.  
cb_close.TriggerEvent(clicked!)

end event

private function integer wf_build_sql_for_claim (string arg_sql);////////////////////////////////////////////////////////////////////
//  wf_build_sql_for_claim  function in w_ratio1_proc_list
////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	01/12/98	Stars 4.0 - Load SQL for query engine window
// JGG	07/09/98 Stars 4.0 - Track 1486, send 4 digit years to query engine
// AJS   08/03/98 Stars 4.0 - Track 1522.  Pass period key to QE if present.
//	NLG	04/20/99	Stars 4.0 SP2 - TS2239c. Don't use globals for period, period_key.
//											Pass structure instead of string to open this window.
// FNC	03/30/00 FS/TS2614 Stars 4.5. Retrieve data from data window using the 
//						column name rather than the column number
//	GaryR	01/05/01	Stars 4.7 DataBase Port - Date Conversion
//	GaryR	07/29/05	Track 4432d	Allow multi-column decode in background
//	Katie		03/14/07	SPR 4942 Added logic for allowed amount.  Added logic to include the from_date
//					in the query sql.
//	GaryR	04/14/08	SPR 4435	Accommodate Ratios by NPI 
// GaryR	06/05/08	SPR 4979 Remove trimming of values and use proper empty string
// GaryR	06/16/08 SPR 5378	Fix SQL when counting Ratios by Proc Code
//
////////////////////////////////////////////////////////////////////

string lv_cols, lv_where, lv_where_clause, lv_final_where
string lv_in_proc_clause, lv_load_global_procs, ls_procs, lv_allow_clause
Long		ll_row
Integer	li_index = 1, li_ctr = 1
datetime ld_min_from, ld_max_thru
String	ls_pin_ind, ls_prov, ls_spec, ls_area, ls_proc
String	ls_npi, ls_blank = "BLANKS", ls_empty

n_cst_decode	lnv_decode
n_cst_datetime lnv_datetime

//*****************************************************//
// check to be sure claims data exists for th is period //
//*****************************************************//

IF inv_queryengine.uf_get_min_max_date (ld_min_from, ld_max_thru)	<	0 THEN
	MessageBox('Error', 'Error checking for claims data')
	Return -1
END IF

//	Clear out the query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

if id_payment_from < ld_min_from or id_payment_thru > ld_max_thru then
// 07/09/98 JGG:
	MessageBox('Claims Check', 'No claims data exists for payment dates ' + &
					string(date(id_payment_from), "mm/dd/yyyy") + ',' + &
					string(date(id_payment_thru), "mm/dd/yyyy"), StopSign!)
// 07/09/98 JGG: end

	Return -1
end if

//***********//
// build sql //
//***********//

gnv_sql.of_trimdata( ls_empty )

//------Loop to build a separate SQL select for each row selected----------
do
	ll_row = dw_1.GetSelectedRow( ll_row )
	if ll_row = 0 then exit

	ls_proc = Trim( dw_1.GetItemString( ll_row, "proc_code" ) )
	if li_index = 1 then
		//  logic to use selected fields to build the SQL clauses
		//  Complete 1st part of the where clause
		
		ls_npi = dw_1.GetItemString( ll_row, "prov_npi" )
		ls_prov  = dw_1.GetItemString( ll_row, "prov_id" )
		ls_spec  = dw_1.GetItemString( ll_row, "prov_spec" )
		ls_area  = dw_1.GetItemString( ll_row, "prov_area" )
		ls_pin_ind  = dw_1.GetItemString( ll_row, "pin_ind" )
		// FNc 03/30/00 End
		
		//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
		//npi
		IF lnv_decode.of_is_decoded( dw_1, "prov_npi" ) THEN
			lnv_decode.of_remove_desc( ls_npi )
		END IF
		
		//prov
		IF lnv_decode.of_is_decoded( dw_1, "prov_id" ) THEN
			lnv_decode.of_remove_desc( ls_prov )
		END IF
		
		//spec
		IF lnv_decode.of_is_decoded( dw_1, "prov_spec" ) THEN
			lnv_decode.of_remove_desc( ls_spec )
		END IF
		
		//area
		IF lnv_decode.of_is_decoded( dw_1, "prov_area" ) THEN
			lnv_decode.of_remove_desc( ls_area )
		END IF
		
		//proc
		IF lnv_decode.of_is_decoded( dw_1, "proc_code" ) THEN
			lnv_decode.of_remove_desc( ls_proc )
		END IF

		IF isx_ratio_rpt_parms.b_npi THEN
			
			//	Check NPI value
			IF Upper( ls_npi ) = "NO NPI" THEN
				ls_npi = ls_blank
				lv_where_clause = " (( PROV_NPI = '" + ls_empty + "' ) "
			ELSE
				lv_where_clause = " (( PROV_NPI = '" + ls_npi + "' ) "
			END IF

			gv_exp1[li_ctr]  = 'PROV_NPI'
			gv_op[li_ctr]    = '='
			gv_exp2[li_ctr]  = ls_npi
			gv_logic[li_ctr] = 'AND'
			
			inv_queryengine.uf_load_where( "", in_detail_struct.table_type[1], &
													'PROV_NPI', '=', ls_npi, '', 'AND', li_index)

			//	Add PROV_ID if not multiple
			IF Upper( ls_prov ) <> "MULTIPLE" THEN
				
				//	Check PROV_ID value
				IF Upper( ls_prov ) = "BLANK" OR Trim( ls_prov ) = "" THEN
					ls_prov = ls_blank
					lv_where_clause += " AND ( PROV_ID = '" + ls_empty + "' ) "
				ELSE
					lv_where_clause += " AND ( PROV_ID = '" + ls_prov + "' ) "
				END IF
				
				li_ctr ++
				gv_exp1[li_ctr]  = 'PROV_ID'  // SG Nov 94
				gv_op[li_ctr]    = '='
				gv_exp2[li_ctr]  = ls_prov
				gv_logic[li_ctr] = 'AND'
				
				inv_queryengine.uf_load_where( "", in_detail_struct.table_type[1], &
													'PROV_ID', '=', ls_prov, '', 'AND', li_index)
			END IF
		ELSE
			if upper(ls_pin_ind) = 'P' then

				//	Check PROV_ID value
				IF Trim( ls_prov ) = "" THEN
					ls_prov = ls_blank
					lv_where_clause = " (( PROV_ID = '" + ls_empty + "' ) "
				ELSE
					lv_where_clause = " (( PROV_ID = '" + ls_prov + "' ) "
				END IF
				
				gv_exp1[li_ctr]  = 'PROV_ID'  // SG Nov 94
				gv_op[li_ctr]    = '='
				gv_exp2[li_ctr]  = ls_prov
				gv_logic[li_ctr] = 'AND'

				inv_queryengine.uf_load_where( "", in_detail_struct.table_type[1], &
													'PROV_ID', '=', ls_prov, '', 'AND', li_index)
				
			else
								
				//	Check PROV_ID value
				IF Trim( ls_prov ) = "" THEN
					ls_prov = ls_blank
					lv_where_clause = " (( PROV_UPIN = '" + ls_empty + "' ) "
				ELSE
					lv_where_clause = " (( PROV_UPIN = '" + ls_prov + "' ) "
				END IF
				
				gv_exp1[li_ctr]  = 'PROV_UPIN'  // SG Nov 94
				gv_op[li_ctr]    = '='
				gv_exp2[li_ctr]  = ls_prov
				gv_logic[li_ctr] = 'AND'

				inv_queryengine.uf_load_where( "", in_detail_struct.table_type[1], &
													'PROV_UPIN', '=', ls_prov, '', 'AND', li_index)
			end if
		END IF
		
		lv_where = ' and ' + in_detail_struct.table_type[1] + &
						'.prov_area = ~'' + ls_area + '~'' + &
						' and ' + in_detail_struct.table_type[1] + &
						'.prov_spec = ~'' + ls_spec + '~'' + &
						' and ' + in_detail_struct.table_type[1] + &
						'.payment_date between ' + &
						gnv_sql.of_get_to_date( String( Date( id_payment_from ), "mm/dd/yyyy" ) ) + ' and ' + &
						gnv_sql.of_get_to_date( String( Date( id_payment_thru ), "mm/dd/yyyy" ) )

		if (lnv_datetime.of_isvalid(id_from_from) and lnv_datetime.of_isvalid( id_from_thru) ) then
			lv_where += ' and ' + in_detail_struct.table_type[1] + '.from_date between ' + &
						gnv_sql.of_get_to_date( String( Date( id_from_from ), "mm/dd/yyyy" ) ) + ' and ' + &
						gnv_sql.of_get_to_date( String( Date( id_from_thru ), "mm/dd/yyyy" ) ) 
		end if
		
		//	Check SPEC value
		IF Trim( ls_spec ) = "" THEN ls_spec = ls_blank
		
		li_ctr ++
		gv_exp1[li_ctr]  = 'PROV_SPEC'  // SG Nov 94
		gv_op[li_ctr]    = '='
		gv_exp2[li_ctr]  = ls_spec
		gv_logic[li_ctr] = 'AND'
		
		//	Check AREA value
		IF Trim( ls_area ) = "" THEN ls_area = ls_blank
		
		li_ctr ++
		gv_exp1[li_ctr]  = 'PROV_AREA'  // SG Nov 94
		gv_op[li_ctr]    = '='
		gv_exp2[li_ctr]  = ls_area
		gv_logic[li_ctr] = 'AND'
		
		li_ctr ++
		gv_exp1[li_ctr]  = 'PAYMENT_DATE'  // SG Nov 94
		gv_op[li_ctr]    = 'BETWEEN'
		gv_exp2[li_ctr]  = string(date(id_payment_from), 'mm/dd/yyyy') + ',' + string(date(id_payment_thru), 'mm/dd/yyyy')		// FDG 01/18/99
		gv_logic[li_ctr] = 'AND'
						
		inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], &
												'PROV_AREA', '=', ls_area, '', 'AND', li_index)
		inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], &
												'PROV_SPEC', '=', ls_spec, '', 'AND', li_index)

		If isx_ratio_rpt_parms.l_period_key > 0 then
			//period will be passed to qe 
			inv_queryengine.uf_set_period_key(int(isx_ratio_rpt_parms.l_period_key))			//ajs 4.0 08/03/98 Pass period key to QE
			inv_queryengine.uf_set_period_function('RATIO')					//ajs 4.0 08/03/98 Pass period key to QE
		else
			//	GaryR	01/05/01	Stars 4.7 DataBase Port - The dates passed to Query Engine
			// will be made DBMS-independent	within Query Engine
			inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], &
													'PAYMENT_DATE', 'BETWEEN', &
													String(Date(id_payment_from), "mm/dd/yyyy") + ',' + &
													String(Date(id_payment_thru), "mm/dd/yyyy"), &
													'', 'AND', li_index)
		end if

// 07/09/98 JGG: end

		lv_where_clause += lv_where
		ls_procs = "'" + ls_proc + "'"
		lv_load_global_procs = ls_proc
		li_index ++
	else
		lv_load_global_procs += ',' + ls_proc	
		ls_procs += ",'" + ls_proc + "'"
	end if
	
loop until ll_row = 0

if (isx_ratio_rpt_parms.b_alw_chrg) then
	li_ctr ++
	gv_exp1[li_ctr]  = 'ALLOWED_AMT'  // SG Nov 94
	gv_op[li_ctr]    = '>'
	gv_exp2[li_ctr]  = '0'
	gv_logic[li_ctr] = 'AND'
	
	inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], &
										'ALLOWED_AMT', '>', '0', '', 'AND', li_index)
	lv_allow_clause = ' and ' +  in_detail_struct.table_type[1] + '.allowed_amt > 0'
end if

lv_in_proc_clause = ' and ( '+in_detail_struct.table_type[1]+'.proc_code IN ( ' + ls_procs + ' ))) ' 
lv_final_where = lv_final_where + lv_where_clause + lv_in_proc_clause + lv_allow_clause

//	Check PROC_CODE value
li_ctr ++
IF Trim( lv_load_global_procs ) = "" THEN
	gv_exp1[li_ctr]  = in_detail_struct.table_type[1]+'.PROC_CODE' // SG Nov 94
	gv_op[li_ctr]    = '='
	gv_exp2[li_ctr]  = ls_blank
	gv_logic[li_ctr] = ''
	
	inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], &
										'PROC_CODE', '=', ls_blank, '', '', li_index)
ELSE
	gv_exp1[li_ctr]  = in_detail_struct.table_type[1]+'.PROC_CODE' // SG Nov 94
	gv_op[li_ctr]    = 'IN'
	gv_exp2[li_ctr]  = lv_load_global_procs
	gv_logic[li_ctr] = ''
	
	inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], &
										'PROC_CODE', 'IN', lv_load_global_procs, '', '', li_index)
END IF

gv_stack1 = lv_final_where
lv_final_where = ' where ' + lv_final_where
in_crit = lv_final_where
in_detail_struct.where_statement = lv_final_where

RETURN 1

end function

event open;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_ratio_proc_sum
//		Event Name:		Open - Override the ancestor
//
//************************************************************************
//
//	FDG	10/06/95	1.	Changed headings for the datawindow to conform
//							to STARS standards.
//						2.	Change dwmodify to Modify
//
// JWW   10/30/97 1. Removed the call to w_master::open.  This code will
//                   be executed when the call to w_parent_rpt::open is
//                   performed.  This was found while test spec 127 (3.6)
//                   The code needed for w_parent_rpt 
//                   was moved to the beginning of the script.
//
//                2. Added ue_go_to_next_window.  This was done                
//                   for spec 127 (3.6).  This change will prevent
//                   this window from being visible when going directly
//                   to the third ratio report screen from w_ratio_rpt.
//
//	FDG	01/12/98	1.	Incorporate the query engine service
//
//	FDG	02/06/98	Fixed a 3.6 bug where if there is no data to display,
//						then do no go to the next window when is_use_catgproc = 'N'.
//
//	FDG	03/11/98	Stars 4.0 Track 877.  Remove references to cb_subset.
//
// JGG	03/12/98 STARS 4.0 - TS145 Executable changes.  Remove code in close
//						window script (closed w_claim_view if valid).
//
// FNC	11/24/98	Track 1989. Replace hardcoded tables.
//
// FNC	01/12/99 TS1809D Stars 4.0 (SP1). Trigger ue_close instead of posting
//	NLG	04/20/99	TS2239. 	Passing structures instead of string from ratio window to window.
//									Don't use globals gv_period, gv_period_key
//	FNC	05/04/99	FS/TS1804c Starcare track 1804. Add sum of total_srvc and 
//						sub_chrg to Ratio 3 report if billed amount displayed on
//						on report instead of allowed amount. Modify in_columns_selected
//						string to reflect the addition of report columns. 
//						col width of two new columns to zero if using allwd charge
// FNC	03/30/00 FS/TS2614 Stars 4.5 Comment out obsolete code
//	FDG	03/18/01	Stars 4.7.	Comment out fx_get_specific_table() since the
//						function is obsolete and its output (tbl_directory) isn't used.
//						Store period key for future use.
//	GaryR	07/10/06	Track 4387d	Remove obsolete decode structure key
//	GaryR	04/14/08	SPR 4435	Accommodate Ratios by NPI 
// GaryR 06/05/08	SPR 5376 Move the logic that hides the NPI column after the retrieve
//	GaryR	06/25/08	SPR 5401	Hide Cat column when Ratio run by Proc Code
//************************************************************************

string	ls_npi, ls_win_id = "W_RATIO_RPT"
integer	li_row, li_rowcount
n_ds		lds_ratio_proc_sum_tables

isx_ratio_rpt_parms = message.powerObjectParm
in_sql = isx_ratio_rpt_parms.s_full_sql
iv_rpt_type = isx_ratio_rpt_parms.s_rpt_type
iv_invoice_type = isx_ratio_rpt_parms.s_invoice_type
il_period_key	=	isx_ratio_rpt_parms.l_period_key		// FDG 03/18/01
//NLG 4-20-99																****STOP**********

//john_wo rel 3.6 spec 127 - if is_use_catgproc = n, trigger cb_view_detail
If isx_ratio_rpt_parms.s_use_catgproc = 'N' Then
	If iv_rpt_type = 'R1' or iv_rpt_type = 'R2' Then
		is_show_window = 'N'
	End If
End If
//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

//	Use the query engine service
This.of_set_queryengine (TRUE)

//in_period = gv_period							//NLG TS2239c
in_period = isx_ratio_rpt_parms.l_period	//NLG TS2239c

//in_detail_struct.table_type[1] = 'RD'		//KMM 7/13/95 MOved to line 66, to load with invoice type
in_detail_struct.src_type = 'SB'
in_detail_struct.period = in_period

//	FDG	03/18/01	-	Comment out fx_get_specific_table() since the function is obsolete and
//							its output (tbl_directory) isn't used.

in_transaction_object = stars1ca

SELECT payment_from_date,
       payment_thru_date, from_date, thru_date
  INTO :id_payment_from,
       :id_payment_thru,
	  :id_from_from,
	  :id_from_thru
  FROM period_cntl
 WHERE period_key = :isx_ratio_rpt_parms.l_period_key//:gv_period_key
 USING stars2ca;

if stars2ca.of_check_status() = -1 then
	Stars2ca.of_rollback()
	MessageBox('Error', 'Error selecting description from period_cntl')
	Return
else
	stars2ca.of_commit()
end if

in_detail_struct.invoice_type = iv_invoice_type
in_detail_struct.table_type[1] = iv_invoice_type

if gc_debug_mode then
	messagebox("Full SQL in w_ratio_proc_sum open event.",in_sql)
	clipboard('')
	clipboard(in_sql)
end if

in_create = FALSE

IF isx_ratio_rpt_parms.b_npi THEN
	ls_win_id = "W_RATIO_RPT_NPI"
	This.title = "Ratio Report Procedure Summary by NPI"
	ls_npi = "NPI "
	
	dw_1.Object.prov_id_t.text = "Prov ID"
END IF

lds_ratio_proc_sum_tables	=	CREATE	n_ds
lds_ratio_proc_sum_tables.DataObject	=	'd_ratio_proc_sum_tables'
lds_ratio_proc_sum_tables.SetTransobject (Stars2ca)
li_rowcount	=	lds_ratio_proc_sum_tables.Retrieve( ls_win_id, iv_invoice_type,iv_rpt_type )
if li_rowcount > 3 then 
	messagebox('ERROR', 'Error retrieving table types for lookup.' + & 
					'Report lookup will not work correctly')
else
	for li_row = 1 to li_rowcount
		if li_row = 1 then
			in_table_type = lds_ratio_proc_sum_tables.object.col_name[li_row]
		elseif li_row = 2 then
			gv_element_table_type2 = lds_ratio_proc_sum_tables.object.col_name[li_row]
		else
			gv_element_table_type3 = lds_ratio_proc_sum_tables.object.col_name[li_row]
		end if
	next
end if

destroy(lds_ratio_proc_sum_tables)
// FNC 11/24/98 End

gv_rc = 0
IF iv_rpt_type = 'R1' THEN
	in_header = "~'" + ls_npi + "RATIO 1 - PROCEDURE SUMMARY~'"
ELSE
   IF iv_rpt_type = 'R2' THEN
	  in_header = "~'" + ls_npi + "RATIO 2 - PROCEDURE SUMMARY~'"
   ELSE
   	in_header = "~'" + ls_npi + "RATIO 3 - PROCEDURE SUMMARY~'"
	END IF
END IF

//  The parent window does the SQL read.
call w_parent_rpt::open 

//  Test if retrieve of data failed (in Parent window).
if gv_rc <> -1 then
	cb_clear.triggerevent(clicked!)

	//  Good retrieve of data, therefore, put up the row count.
	w_ratio_proc_sum.sle_count.text = string(in_row_count)
	
	IF NOT isx_ratio_rpt_parms.b_npi THEN
		dw_1.Object.prov_npi.Visible = "0"
		dw_1.Object.prov_npi_t.Visible = "0"
		dw_1.Object.prov_npi.Width = "0"
		dw_1.Object.prov_npi_t.Width = "0"
	END IF
	
	// Hide the Cat column
	IF isx_ratio_rpt_parms.s_use_catgproc = "N" &
	AND iv_rpt_type = "R3" THEN
		dw_1.Object.cat_of_serv.Visible = "0"
		dw_1.Object.cat_of_serv_t.Visible = "0"
		dw_1.Object.cat_of_serv.Width = "0"
		dw_1.Object.cat_of_serv_t.Width = "0"
	END IF
	
	// FNC 05/04/99 Start
	if not isx_ratio_rpt_parms.b_use_bill then
		dw_1.Modify("total_srvc.width='0'")
		dw_1.Modify("total_srvc_t.width='0'")
		dw_1.Modify("total_srvc.visible='0'")
		dw_1.Modify("total_srvc_t.visible='0'")
		dw_1.Modify("sub_chrg.width='0'")
		dw_1.Modify("sub_chrg_t.width='0'")
		dw_1.Modify("sub_chrg.visible='0'")
		dw_1.Modify("sub_chrg_t.visible='0'")
	end if
	// FNC 05/04/99 End
end if

//	This must be here to prevent decode from dropping the first letter 
//	of the column name  PLB 7-25-95
If isx_ratio_rpt_parms.s_use_catgproc = 'N' &
and (iv_rpt_type = 'R1' or iv_rpt_type = 'R2')	&
and gv_rc <> -1			Then
		This.Event ue_go_to_next_window ()
		This.Event ue_close()					// FNC 01/12/99
Else
	SetMicroHelp(w_main,'Ready')
End If
end event

on w_ratio_proc_sum.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
end on

on w_ratio_proc_sum.destroy
call super::destroy
destroy(this.st_dw_ops)
end on

event ue_query;//  triggered from CB_QUERY,  FOR W_RATIO1_PROC_SUM
//john_wo 11/5/97 spec 127 3.6 Move all code from cb_view_detail and
//    created this user event.  This was done to keep the window
//    invisible when bypassing this window.

string lv_prov,select_prov,lv_from,lv_to,lv_todp,lv_period,lv_year
integer li_rc

SetMicroHelp(w_main,'Now counting records for the Detail Claim Report')
in_going_to_claim = true
SetPointer(HourGlass!)

li_rc = wf_build_sql_for_claim('count')
if li_rc = -1 then Return

if gc_debug_mode then
	clipboard ('')
	clipboard (GV_STACK1)
	messagebox('Full SQL Statement.',GV_STACK1)
end if

//john_wo 11/5/97 - spec 127 3.6 had to change the call to a Triggerevent
//                  when moving the code to this user event.
//w_parent_rpt.cb_query.TriggerEvent(clicked!)
//call w_parent_rpt`cb_query::clicked
call super::ue_query
SetMicroHelp(w_main,'Ready')
end event

type ddlb_dw_ops from w_parent_rpt`ddlb_dw_ops within w_ratio_proc_sum
integer x = 14
integer y = 1696
integer height = 184
integer taborder = 20
end type

type cb_clear from w_parent_rpt`cb_clear within w_ratio_proc_sum
integer x = 2510
integer y = 1776
integer width = 338
string text = "C&lear"
end type

type st_1 from w_parent_rpt`st_1 within w_ratio_proc_sum
integer x = 919
integer y = 1768
end type

type cb_save_report from w_parent_rpt`cb_save_report within w_ratio_proc_sum
integer x = 1349
integer y = 1784
integer taborder = 70
end type

on cb_save_report::clicked;in_save_name = 'norm provider list dw'
call w_parent_rpt`cb_save_report::clicked
end on

type sle_count from w_parent_rpt`sle_count within w_ratio_proc_sum
integer x = 14
integer y = 1796
integer taborder = 0
integer weight = 400
end type

type cb_stop from w_parent_rpt`cb_stop within w_ratio_proc_sum
integer x = 1417
integer y = 1744
integer taborder = 90
end type

type mle_crit from w_parent_rpt`mle_crit within w_ratio_proc_sum
integer x = 5
integer y = 8
integer width = 3182
integer height = 152
integer textsize = -10
integer weight = 400
end type

type cb_query from w_parent_rpt`cb_query within w_ratio_proc_sum
integer x = 1783
integer y = 1776
integer width = 338
integer textsize = -10
integer weight = 400
boolean default = true
end type

event cb_query::clicked;call super::clicked;//john_wo spec 127 3.6 moved code to user event to keep the window hidden
//        when going from w_ratio_rpt to the claim rpt screen. 11/5/97
parent.event ue_query()


end event

type cb_view_detail from w_parent_rpt`cb_view_detail within w_ratio_proc_sum
integer x = 2121
integer y = 1776
integer width = 384
integer taborder = 50
integer textsize = -10
integer weight = 400
string text = "&View Data..."
end type

event cb_view_detail::clicked;call super::clicked;//john_wo spec 127 3.6 moved code to user event to keep the window hidden
//        when going from w_ratio_rpt to the claim rpt screen. 11/5/97
parent.event ue_view_data()
end event

type cb_close from w_parent_rpt`cb_close within w_ratio_proc_sum
integer x = 2848
integer y = 1776
integer width = 338
integer taborder = 100
integer weight = 400
end type

event cb_close::clicked;call super::clicked;//	Extends the ancestor script
//
//john_wo 11/5/97 spec 127 3.6 - move the following line to the window's
// close event. This was done to keep the window from being visible.  
//close(w_claim_view)

//close(w_header_rpt)
//close(w_line_rpt)

end event

type dw_1 from w_parent_rpt`dw_1 within w_ratio_proc_sum
string tag = "CRYSTAL, title = Procedure Summary"
integer x = 5
integer y = 160
integer width = 3182
integer height = 1452
string dataobject = "d_ratio_proc_sum_rat_3"
end type

event dw_1::clicked;call super::clicked;// clicked event for dw_1, w_ratio1_proc_list
// THIS SCRIPT HANDLES THE SELECTION OR DE-SELECTION OF ROWS
// IN THE DATAWINDOW.  VARIOUS BUTTONS ARE TURNED ON OR OFF BASED
// ON THE NUMBER OF SELECTED ROWS.  SELECTED ROWS ARE LIMITED TO 10.


long row_nbr, tot_rows
boolean result_row
setpointer(hourglass!)

row_nbr = row
tot_rows = rowcount(dw_1)

cb_view_detail.enabled = TRUE
cb_query.enabled = TRUE
cb_clear.enabled = TRUE

result_row = isSelected(dw_1,row_nbr)
if result_row Then
	Selectrow(dw_1,row_nbr,FALSE)
	in_Num_rows_sel = in_Num_rows_sel - 1
else 
	if row_nbr > 0 and row_nbr <= tot_rows then
		if in_num_rows_sel >= 10 then
         Selectrow(dw_1,row_nbr,FALSE)
         MessageBox("Selection Error","You Have Selected The Maximum Number Of Rows (10)")
         // the following line to corrrect mouse error after popup window
         dw_1.Modify("datawindow.selected.mouse=no")
      else   
      	Selectrow(dw_1,row_nbr,TRUE)
	      in_Num_rows_sel = in_Num_rows_sel + 1
      end if
	end if
end if

if in_num_rows_sel <= 0 Then
	in_num_rows_sel = 0
	cb_view_detail.enabled = FALSE
	cb_query.enabled = FALSE
	cb_clear.enabled = FALSE
end if


end event

on dw_1::retrieveend;in_button_not_modified[1] = cb_query
in_button_not_modified[2] = cb_view_detail
in_button_not_modified[3] = cb_clear
call w_parent_rpt `dw_1::retrieveend
end on

on dw_1::rowfocuschanged;//  This is a dummy statement to force the execution of retrievestart
//  event in dw_1 of w_parent_rpt.  This will set gv_cancel_but_clicked
//  to false and allow the full retrieve in w_claim_rpt.

//  Otherwise, gv_cancel_but_clicked is set to 'true' when it goes
//  into the open event of w_claim_rpt.  When gv_cancel_but_clicked
//  is true, it cancels out of the 18 table retrieve.



end on

type st_dw_ops from statictext within w_ratio_proc_sum
string accessiblename = "Window Operations"
string accessibledescription = " Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 1620
integer width = 658
integer height = 72
boolean bringtotop = true
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

