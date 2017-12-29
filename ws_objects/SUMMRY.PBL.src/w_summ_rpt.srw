$PBExportHeader$w_summ_rpt.srw
$PBExportComments$Inherited from w_parent_rpt
forward
global type w_summ_rpt from w_parent_rpt
end type
type cb_summ from u_cb within w_summ_rpt
end type
type cb_trend_report from u_cb within w_summ_rpt
end type
type st_dw_ops from statictext within w_summ_rpt
end type
type dw_rel from u_dw within w_summ_rpt
end type
type dw_sum_select from u_dw within w_summ_rpt
end type
end forward

global type w_summ_rpt from w_parent_rpt
string accessiblename = "Summary Analysis Report"
string accessibledescription = "Summary Analysis Report - "
integer width = 3602
integer height = 2268
string title = "Summary Analysis Report - "
event type string ue_view_detail ( boolean ab_count )
cb_summ cb_summ
cb_trend_report cb_trend_report
st_dw_ops st_dw_ops
dw_rel dw_rel
dw_sum_select dw_sum_select
end type
global w_summ_rpt w_summ_rpt

type variables
boolean in_retrieve_end
boolean ib_fasttrack = FALSE
boolean iv_summ_but_pressed
boolean ib_view_detail_enabled = TRUE
//w_claim_rpt_mc in_w_claim_rpt_mc
int in_no_of_fields
string in_from, in_to, in_todp, in_summarize_by[],in_db_col_name[]
string iv_rept_title
string iv_sum_type
string iv_summary_type
string iv_crit
sx_field iv_fields[]
sx_summary_parm iv_parm

Long il_cnt
boolean in_open_event
//Long il_period_key					// FDG 03/18/01
datetime id_payment_from, id_payment_thru, id_from, id_thru
// u_nvo_summary  NVO
u_nvo_summary	inv_summ

constant string ics_drugcat = 'DRUG_CAT'//NLG 3-13-00

end variables

forward prototypes
public subroutine wf_move_buttons ()
public function string wf_make_trend_where ()
public function string wf_make_where (boolean ab_count)
end prototypes

event type string ue_view_detail(boolean ab_count);/////////////////////////////////////////////////////////////////////////
//	Script:	w_summ_rpt.ue_view_detail
//
//	Description:
//		This event is triggered from cb_view_detail and will open 
//		w_query_engine
//
/////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	01/12/98	This script was moved from cb_view_detail.clicked.
// JGG	03/04/98 Replace hard coded 'CR' with nvo function of_get_revenue
//	FDG	07/17/98	Track 1507.  Once ls_rev_tbl_type is set, don't try
//						to get it again.
// FNC	05/25/00 Use a function in the nvo to retrieve fasttrack invoice type
//	LahuS	01/29/02	Track 2552d	Predefined Report (PDR)
//	GaryR	02/04/05	Track 4269d	Use FastQuery instead of Header/Revenue on count
//	GaryR	03/29/06	Track 4532	Do not interpret BLANKS when performing a count
/////////////////////////////////////////////////////////////////////////

n_cst_revenue	lnv_revenue		// JGG 03/04/98

String	ls_rev_tbl_type		// JGG 03/04/98

String	ls_sel,			&
			ls_where,		&
			ls_inv_type
Long		ll_upperbound, &
			ll_index,		&
			ll_index2
			
String	ls_blank[]

//	Clear out the query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

//ABO 12/31/96 start  - Don't need join if revenue
//jww 10/10/97 Spec 199 for rel 3.6. Changes are to obtain the base type
//jww          for the current invoice type and enter the FastTrack logic
//jww          if the base type = UB92.  Also removed the hardcoding of 'Q1'
w_main.dw_stars_rel_dict.SetFilter("")	
w_main.dw_stars_rel_dict.Filter()	
ls_sel = "rel_type = 'QT' and id_2 = '" + iv_invoice_type + "'"	
w_main.dw_stars_rel_dict.SetFilter(ls_sel)	
w_main.dw_stars_rel_dict.Filter()

lnv_revenue	=	CREATE n_cst_revenue	// JGG 03/04/98

If w_main.dw_stars_rel_dict.GetItemString(1,'Key6') = 'UB92' Then	//jww 10/10/97
	ll_upperbound = UpperBound(iv_fields[])
	For ll_index = 1 to ll_upperbound
		
		// Get the Revenue table type
	
		IF	len(trim(ls_rev_tbl_type))	= 0 THEN						
			ls_rev_tbl_type = lnv_revenue.of_get_revenue(iv_fields[ll_index].tbl_type)
		END IF
		
		if iv_fields[ll_index].tbl_type = ls_rev_tbl_type then	// JGG 03/04/98

			ls_inv_type = lnv_revenue.of_get_fasttrack_invoice(iv_invoice_type)
			if ls_inv_type <> 'ERROR' then
				iv_invoice_type = ls_inv_type
			else
				return ls_inv_type
			end if

			ls_blank[1] = iv_invoice_type
			in_detail_struct.table_type = ls_blank
			For ll_index2 = 1 to ll_upperbound
				iv_fields[ll_index2].tbl_type = iv_invoice_type //john-wo 10/10/97
			Next
			ib_fasttrack = TRUE
			Exit
		else
			ib_fasttrack = FALSE
		end if
	Next
end if
//ABO 12/31/96 end

//	Save the invoice type, & source type so it can be passed to w_query_engine
inv_queryengine.uf_set_invoice_type (iv_invoice_type)
inv_queryengine.uf_set_tbl_type (iv_invoice_type)
inv_queryengine.uf_set_tbl_rel ('GP')
inv_queryengine.uf_set_src_type (in_detail_struct.src_type)
inv_queryengine.uf_set_rpt_title ('Claim Report - ' + iv_parm.header)

ls_where = wf_make_where(ab_count)
if ls_where = 'ERROR' then	Return ls_where

IF ab_count THEN Return ls_where

w_main.Setmicrohelp('Bringing up Query Engine.  Please Wait!')

//	01/29/02	Lahu S	Track 2552d
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Open the query engine window
inv_queryengine.uf_open_query_engine()

Return ""
end event

public subroutine wf_move_buttons ();//	FDG 03/11/98	Track 877. Stars 4.0 - Remove references to cb_subset.

cb_view_detail.x = (cb_trend_report.x - 27) - cb_view_detail.width
cb_query.x = (cb_view_detail.x - 27) - cb_query.width
end subroutine

public function string wf_make_trend_where ();//**************************************************
//	10/11/95 FNC	Take upperbound out of script
//
//	01/08/98 FDG	Replace fx_load_crit_globals() with 
//						inv_queryengine.uf_load_where().
//	08/03/98 ajs	Stars 4.0 - Track 1522.  Pass period key to QE if present.
//	05/12/03	GaryR	Track 5180c	Decoded columns improperly trimmed
// 06/12/03 MikeF 3606d	Period cursor was never being closed.
// 01/27/05 MikeF	SPR4256d Error trending after using "View Data"
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
// 09/29/05 Katie Track 4532d Removed code preventing BLANKS from being passed
// 03/03/06 Katie Track 4532d Re-added the code removed in September, but instead of throwing
// 						an error I made sure the value was passed as a single space.
//	09/13/06	GaryR	Track 4817	Replace Int with Long to prevent 32K limit
//**************************************************


string lv_where,lv_where_line,lv_col,lv_value,lv_line,lv_operator,ls_empty
string lv_tbl_type,lv_connector
Long 	selected_row,next_selected_row
Long	i,j,k,l,lv_pos,lv_upperbound
string lv_period,lv_temp
String ls_inv_type, ls_function

int					li_index, li_rows, lv_index
n_ds					lds_period
n_cst_stars_rel	lnv_rel
n_cst_decode		lnv_decode

lv_index = 1
do
	next_selected_row = GetSelectedRow(dw_1,selected_row)
	if next_selected_row = 0 then
		exit
	end if
	k = 1
   lv_upperbound = upperbound(iv_fields)  //10-11-95 FNC
	for i = 1 to lv_upperbound     //loop thru iv_fields cols
		for j = k to lv_upperbound  //loop thru dw cols, starting w/ last col
			lv_col = UPPER(dw_1.describe('#'+string(j)+'.name'))
			if lv_col <> 'PERIOD' then 
				lv_value = trim(dw_1.getitemstring(next_selected_row,j))
				//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
				IF lnv_decode.of_is_decoded( dw_1, lv_col ) THEN
					lnv_decode.of_remove_desc( lv_value )
				END IF
				if lv_value = '' or lv_value = ' ' or isnull(lv_value) then
					gnv_sql.of_TrimData (lv_value)
				end if
				if lv_col = iv_fields[i].col_name then
					if lv_col = 'TYPE_BILL' and len(lv_value) < 3 then
						lv_operator = ' like '
						lv_value = "'" + lv_value + "%'" 
					else
						lv_operator = ' = '						
						lv_value = "'" + lv_value + "'" 
					end if
					lv_line = lv_col + lv_operator + lv_value					
					k = j
					k++
					exit
				end if			
			end if
		next
		if lv_where_line = '' then 
			lv_where_line = lv_line
		else
			lv_where_line = lv_where_line + ' and ' + lv_line			
		end if				
		if lv_where = '' then
			lv_connector = ''
		else
			lv_connector = 'AND'
		end if
		inv_queryengine.uf_load_where('',iv_fields[i].tbl_type,lv_col,lv_operator, &
												lv_value,'',lv_connector,lv_index)		
	next
   lv_upperbound = upperbound(iv_parm.asterisk_cols)   //10-11-95 FNC
	for l = 1 to lv_upperbound                 //add col w/ *
		lv_line = iv_parm.asterisk_cols[l] + " = '*'" 
		if lv_where_line = '' then 
			lv_where_line = lv_line
		else
			lv_where_line = lv_where_line + ' and ' + lv_line
		end if			
	next
	selected_row = next_selected_row
	if lv_where = '' then
		lv_where = '(' + lv_where_line + ')'
	else
		lv_where = lv_where + ' or (' + lv_where_line + ')'
	end if	
	lv_where_line = ''
loop until next_selected_row = 0

// Get Active periods for Inv Type / Function
ls_inv_type = Upper( iv_invoice_type )
ls_function = Upper( iv_parm.function_nm )

// If UB92 Fatrtrack, get main invoice type for Period_cntl
IF lnv_rel.of_get_is_ft_rev(ls_inv_type) THEN
	ls_inv_type = lnv_rel.of_get_main_from_ft_rev(ls_inv_type)
END IF

// Create and retrieve datastore
lds_period = CREATE n_ds
lds_period.dataobject = 'd_period_list'
lds_period.settransobject(stars2ca)
li_rows = lds_period.retrieve(ls_function,ls_inv_type,"AC")

FOR li_index = 1 TO li_rows
	IF li_index > 1 THEN lv_period += ","
	lv_period += string(lds_period.GetItemNumber(li_index, "PERIOD"))
NEXT

if lv_period<>'' then lv_period=' and period in ('+lv_period+')'

lv_where = ' WHERE ' + '(' + lv_where + ')' +lv_period

DESTROY lds_period

return lv_where
end function

public function string wf_make_where (boolean ab_count);//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_summ_rpt.wf_make_where
//		Event Name:		N/A
//
//		create where for claim report
//		also fill criteria globals
//
//************************************************************************
//	01-08-98 FDG	Replace fx_load_crit_globals() with inv_queryengine.uf_load_where().
//						Replace embedded SQL of ros_directory to call
//						inv_queryengine.uf_get_min_max_date()
//	06/03/98 FDG	Track 1259.  The where criteria is incorrect when dealing
//						with multiple selected rows.
//	07/09/98 JGG	Track 1486.  Pass 4 digit years to Query Engine.
//	07/29/98 FDG	Track 1259.  Fix changes made on 6/3/98.
//	08/03/98 ajs	Stars 4.0 - Track 1522.  Pass period key to QE if present.
//	04/20/99 FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//	03/07/00 NLG 	Patient profiles. If col is DRUGCAT, change to appropriate claims column
//						and add '@' in front of its value so query engine
//						will treat as a filter.
//	01/08/01	GaryR	Stars 4.7 DataBase Port - Date Conversion
//	10/25/01	GaryR	Track 2487d Null dates are 1/1/1900
//	05/12/03	GaryR	Track 5180c	Decoded columns improperly trimmed
// 02/10/05 MikeF SPR4097d Account for computed columns
// 07/08/05 Katie Track 3661d Change blank value to BLANKS for Query Engine.
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	03/29/06	GaryR	Track 4532	Do not interpret BLANKS when performing a count
//	09/13/06	GaryR	Track 4817	Replace Int with Long to prevent 32K limit
//************************************************************************

string lv_where,lv_where_line,lv_col,lv_value,lv_line,lv_operator
string lv_tbl_type,lv_connector,lv_clear[]
string lv_dep_tables[],lv_year,lv_period,lv_join_line
string join_var1,join_var2
string lv_left_paren, lv_right_paren
Long selected_row,next_selected_row,lv_dep_num,lv_row
Long i,j,k,l,m,n,lv_num_fields,lv_upperbound_dep_tables
Integer	li_rc, lv_index
boolean lv_found
DateTime	ldt_default						//	10/25/01	GaryR	Track 2487d
String ls_month,ls_day
Long		ll_row							// FDG 11/20/95
Datetime ld_min_from, ld_max_thru
Long 		ll_row_count					//Archana 1/14/98
Long		ll_selected_count,	&
			ll_selected_rows,		&
			ll_rows
n_cst_decode	lnv_decode			

//*****************************************************//
// check to be sure claims data exists for this period //
//*****************************************************//

li_rc	=	inv_queryengine.uf_get_min_max_date (ld_min_from, ld_max_thru)

IF	li_rc	<	0	THEN
	MessageBox('Error', 'Error checking for claims data')
	Return	'ERROR'
END IF


if id_payment_from < ld_min_from or id_payment_thru > ld_max_thru then
	MessageBox('Claims Check', 'No claims data exists for payment dates ' + string(date(id_payment_from)) + ',' + string(date(id_payment_thru)), StopSign!)
	Return 'ERROR'
end if

next_selected_row		=	0

DO
	next_selected_row	=	dw_1.GetSelectedRow(next_selected_row)
	IF	next_selected_row	>	0		THEN
		ll_selected_count ++
	END IF
LOOP WHILE next_selected_row		>	0

next_selected_row		=	0

n = 2

lv_index = 1
l = 1
m = 1
lv_row = 1
ll_selected_rows	=	0					// FDG 06/03/98

do
	next_selected_row = GetSelectedRow(dw_1,selected_row)
	if next_selected_row = 0 then
		exit
	end if
	ll_selected_rows ++					// FDG 06/03/98
	k = 1
	lv_num_fields = upperbound(iv_fields)
	for i = 1 to lv_num_fields     //loop thru iv_fields cols
		for j = k to lv_num_fields  //loop thru dw cols, starting w/ last col
			if iv_parm.join then
				lv_col = mid(UPPER(dw_1.describe('#'+string(j)+'.dbname')),2)
			else
				lv_col = UPPER(dw_1.describe('#'+string(j)+'.dbname'))
			end if
			if lv_col <> 'PERIOD' then 
				lv_value = dw_1.getitemstring(next_selected_row,j)
				//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
				IF lnv_decode.of_is_decoded( dw_1, j ) THEN
					lnv_decode.of_remove_desc( lv_value )
				END IF
				
				IF NOT ab_count THEN
					if isnull(lv_value) OR Trim( lv_value ) = "" then
						lv_value = 'BLANKS'
					end if
					
					IF UPPER(lv_col) = ics_drugcat THEN
						lv_value = '@' + lv_value
						lv_col = 'NDC_CODE'
					END IF
				END IF
				
				//This is for Part B because Summ and Claim table names
				//are different.  If they ever become the same this can 	
				// be deleted.
				if lv_col = iv_fields[i].sum_col_name Then
					lv_col = iv_fields[i].col_name
				end if
				if lv_col = iv_fields[i].col_name then
					if lv_col = 'TYPE_BILL' and len(lv_value) < 3 then
						lv_operator = ' like '
						lv_value=lv_value+'%'
					else
						lv_operator = '='						
					end if
					
					// Check to see if it's a computed column
					IF gnv_dict.event ue_get_is_computed(iv_fields[i].tbl_type, lv_col) THEN
						lv_line = gnv_dict.event ue_get_formula(iv_fields[i].tbl_type, lv_col) + &
									 lv_operator + "'" + lv_value+"'"
					ELSE
						lv_line = iv_fields[i].tbl_type+'.'+lv_col + lv_operator +"'"+ lv_value+"'"					
					END IF

					k = j
					k++
					exit
				end if			
			end if
		next
		if lv_where_line = '' then 
			lv_where_line = lv_line
		else
			lv_where_line = lv_where_line + ' and ' + lv_line			
		end if				
		if lv_index = 1 					&
		and ll_selected_count = 1		THEN		// FDG 07/29/98
			lv_connector = ''
		else
			//HRB 7/13/95 - fix the fix for prob#449 
			// FDG 06/03/98 'OR' is to only used after the last column and if
			//	there is more than one selected row.
			if i = lv_num_fields									&
			and ll_selected_count	>	1						&
			and ll_selected_rows		<	ll_selected_count	then 
				//only when have more than one row selected, must or together
				//DJP 7/11/95 - Prob #449
				lv_connector	=	'OR'
			else
				lv_connector	=	'AND'
			end if
		end if
		// FDG 06/03/98 begin
		// Place a left paren before the 1st column
		IF	i	=	1		THEN
			// first column
			IF	ll_selected_rows	=	1		THEN
				// First selected row - use two left parens because of the 'OR' condition
				lv_left_paren	=	'(('
			ELSE
				lv_left_paren	=	'('
			END IF
		ELSE
			lv_left_paren	=	''
		END IF
		// Place a right paren after the last column
		IF	i	=	lv_num_fields		THEN
			// last column
			IF	ll_selected_rows	=	ll_selected_count		THEN
				// Last selected row - use two right parens because of the 'OR' condition
				lv_right_paren	=	'))'
			ELSE
				lv_right_paren	=	')'
			END IF
		ELSE
			lv_right_paren	=	''
		END IF
		dw_1.GetSelectedRow (next_selected_row)
		// FDG 05/18/98 begin
		IF	Trim (lv_connector)	<	' '		THEN
			lv_connector	=	'AND'
		END IF
		// FDG 05/18/98 end
		inv_queryengine.uf_load_where	(lv_left_paren,			&
												iv_fields[i].tbl_type,	&
												lv_col,						&
												lv_operator,				&
												lv_value,					&
												lv_right_paren,			&
												lv_connector,				&
												lv_index)		
		if iv_fields[i].tbl_type <> iv_invoice_type then
         lv_upperbound_dep_tables = upperbound(lv_dep_tables)  //10-11-95 FNC
			for l = 1 to lv_upperbound_dep_tables                 //10-11-95
				lv_found = false
				if lv_dep_tables[l] = iv_fields[i].tbl_type then
					lv_found = true
					exit
				end if
			next
			if not lv_found then
				lv_dep_tables[m] = iv_fields[i].tbl_type
				m++
			end if
		end if
	next
	selected_row = next_selected_row
	if lv_where = '' then
		lv_where = '(' + lv_where_line
	else
		lv_where = lv_where + ' or ' + lv_where_line
	end if	
	lv_where_line = ''
	lv_row ++
loop until next_selected_row = 0
lv_where = lv_where + ")"

//01/08/01	GaryR	Stars 4.7 DataBase Port - Begin
//	10/25/01	GaryR	Track 2487d
if ( IsNull(id_from) OR id_from = ldt_default ) AND ( IsNull(id_thru) OR id_thru = ldt_default ) then
	lv_period = ' AND ' + iv_invoice_type + '.PAYMENT_DATE BETWEEN ' + &
					gnv_sql.of_get_to_date( String( Date( id_payment_from ), "mm/dd/yyyy" ) ) + ' AND ' + &
					gnv_sql.of_get_to_date( String( Date( id_payment_thru ), "mm/dd/yyyy" ) )
else
	lv_period = ' AND ' + iv_invoice_type + '.FROM_DATE BETWEEN ' + &
					gnv_sql.of_get_to_date( String( Date( id_from ), "mm/dd/yyyy" ) ) + ' AND ' + &
					gnv_sql.of_get_to_date( String( Date( id_thru ), "mm/dd/yyyy" ) ) + ' AND ' + &
					iv_invoice_type + '.PAYMENT_DATE BETWEEN ' + &
					gnv_sql.of_get_to_date( String( Date( id_payment_from ), "mm/dd/yyyy" ) ) + ' AND ' + &
					gnv_sql.of_get_to_date( String( Date( id_payment_thru ), "mm/dd/yyyy" ) )
end if
//01/08/01	GaryR	Stars 4.7 DataBase Port - End

//This loads the criteria globals that will be used later

//ajs 4.0 08/03/98 Pass period key to QE if available
If iv_parm.period_key > 0 then
	//period will be passed to qe 
	inv_queryengine.uf_set_period_key(int(iv_parm.period_key))	//ajs 4.0 08/03/98 Pass period key to QE
	inv_queryengine.uf_set_period_function(iv_parm.function_nm)	//ajs 4.0 08/03/98 Pass period key to QE
Else
	//	10/25/01	GaryR	Track 2487d
	//if not (isnull(id_from) or isnull(id_thru)) then 
	if not ( ( IsNull(id_from) OR id_from = ldt_default ) AND ( IsNull(id_thru) OR id_thru = ldt_default ) ) then 
		inv_queryengine.uf_load_where	('(',					&
												iv_invoice_type,	&
												'FROM_DATE',		&
												'BETWEEN', 			&
												string(date(id_from), "mm/dd/yyyy") + ',' + &
												string(date(id_thru), "mm/dd/yyyy"), &
												')',					&
												'AND',				&
												lv_index)
	end If

	//This loads the criteria globals that will be used later
	//SKM changed paid_date to payment_date for HCFA
	inv_queryengine.uf_load_where	('(',						&
											iv_invoice_type,		&
											'PAYMENT_DATE',		&
											'BETWEEN',				&
											string(date(id_payment_from), "mm/dd/yyyy") + ',' + &
											string(date(id_payment_thru), "mm/dd/yyyy"), &
											')',						&
											'AND',					&
											lv_index)

End if
// 07-09-98 JGG: end

lv_where = lv_where + lv_period

lv_dep_num = upperbound(lv_dep_tables)
if lv_dep_num > 0 then
	if lv_dep_tables[lv_dep_num] = '' then lv_dep_num --
	if lv_dep_num > 0 then
		ll_row	=	fx_filter_stars_rel_1 ('JN', ' ', iv_invoice_type)
		IF	ll_row	<	1		THEN
		   errorbox(stars2ca,'error reading relationship table')
		   return 'ERROR'
		end if
		join_var1	=	w_main.dw_stars_rel_dict.GetItemString (1, "key1")
		join_var2	=	w_main.dw_stars_rel_dict.GetItemString (1, "key2")
		lv_upperbound_dep_tables = upperbound(lv_dep_tables)
		for i = 1 to lv_upperbound_dep_tables    //10-11-95 FNC
			lv_join_line = ' AND '+ iv_invoice_type + '.' + join_var1 + ' = ' + lv_dep_tables[i] + '.' + join_var2 
			lv_where = lv_where + lv_join_line
			inv_queryengine.uf_load_where	('J',					&
													iv_invoice_type,	&
													join_var1,			&
													'=',					&
													lv_dep_tables[i] + '.'+ join_var2, &
													'',					&
													'AND',				&
													lv_index)
			if NOT ib_fasttrack then  //ABO 1/2/97 if fasttrack tables were set in cb_view_detail
				in_detail_struct.table_type[n] = lv_dep_tables[i]
			end if
			n++
		next
	end if
end if

//======================================================
// mvr 3.6 01/09/98 -- Check if Revenue to be searched
//======================================================
string lv_invoice_type,lv_sel
int	lv_rc

lv_rc = w_main.dw_stars_rel_dict.SetFilter("")
lv_rc = w_main.dw_stars_rel_dict.Filter()
lv_sel = "rel_type = 'DP' and rel_id = '" + in_detail_struct.table_type[1] + "' and ID_3 <> '' and ID_3 <> '*'" 
lv_rc = w_main.dw_stars_rel_dict.SetFilter(lv_sel)
lv_rc = w_main.dw_stars_rel_dict.Filter()
ll_row_count = w_main.dw_stars_rel_dict.rowcount()
if ll_row_count = 1 then									//Archana 1-14-98
	lv_tbl_type = w_main.dw_stars_rel_dict.GetItemstring(1,"ID_3")
	SELECT min(code_code)
		INTO   :lv_invoice_type
		FROM   Code
		WHERE  code_type = 'IT'
		AND    code_value_a = Upper( :lv_tbl_type )
		using STARS2CA;
		
	if STARS2CA.of_check_status() = 100 then
		MessageBox('Not Found','No records found for the invoice type in the CODE table.')
		Return 'Error'
	elseif STARS2CA.SQLCODE = -1 then
		ErrorBox(STARS2CA, 'Error reading the CODE table')
		Return 'Error'  
	end if
	lv_where = lv_where + " AND "+in_detail_struct.table_type[1]+".INVOICE_TYPE = '"+lv_invoice_type+"'"	
	fx_load_crit_globals('',in_detail_struct.table_type[1]+".INVOICE_TYPE",'=',lv_invoice_type,'','AND',lv_index)
Else 
	if ll_row_count > 1 then
		MessageBox('Error','Error reading STARS_REL table in wf_make_where')
		Return 'ERROR'
	End if
END IF


//===================================
// mvr 3.6 01/09/98 -- End New Code
//===================================

if stars2ca.of_commit() <> 0 then
   errorbox(stars2ca,'Error performing commit in wf_make_where')
   return 'ERROR'
end if          //10-24-95 FNC End

lv_where = ' WHERE ' + lv_where 

return lv_where
end function

event open;//************************************************************************
//		Object Type:	Window
//		Object Name:	w_summ_rpt (inherited from w_parent_rpt)
//		Script Name:	Open	-	Override the ancestor
//
//************************************************************************
//	01/08/98 FDG	Create an instance of the query engine service.
//	01/15/98 JGG 	Replace labels2 global function with nvo service.
//	11/30/98 NLG 	implement Archana's ts356 changes
//	01/14/99 AJS 	FS2033c Y2K change mm/dd/yy to mm/dd/yyyy
//	01/19/99 JGG 	TS2061c correction to TS356 changes.
//	03/11/99 FNC 	TS2186C Define row count as a long.
//	04/20/99 FNC 	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//						Set lv_transaction data type n_tr (instead of type transaction)
//	03/18/01 FDG	Stars 4.7.  Store period key for future use.  Also,
//						don't call fx_get_specific_table because it is used
//						to access ros_directory.
//	09/17/01	GaryR	Track 2409d	Handle alias quotes
//	11/06/01	FDG	Track 2486d.  Migration to Oracle can cause some columns to be
//						decimal(0).  These columns are number fields and should be
//						formatted as such.
//	03/10/03	GaryR	Track 3449d	Treat numeric computed fields as monetary for formatiing
//	06/30/03	GaryR	Track 3593d	Remove the RowRetrieve logic
// 01/11/05 Katie Track 5431c Changed global references to instance.
//	09/19/06	GaryR	Track 4541	Perpetuate any calculated columns from Summary to Trending
//	09/20/06	GaryR	Track 4540	Set formats based on DICTIONARY setting
//	03/01/07 Katie	SPR 4540 Set formats of calculated fields based on disp_format in SUM_SELECT
//	04/10/07 Katie	SPR 4977 Added 50 to fx_add_d_head.
//	05/21/08	GaryR	SPR 5329	Set the main datawindow as the only printable datawindow
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//************************************************************************

string lv_syntax,lv_error,lv_table_type,lv_col_name[]
string lv_title,lv_sql_statement,lv_style,lv_errror
string lv_clear[]
string ls_col_name, ls_col_type, ls_desc, ls_col_label, ls_error
integer lv_index,lv_pos,lv_rc
Integer	li_rc, li_ctr, li_disp_ctr = 1
Long ll_nbr_rows, ll_pos
string lv_window_name,dwm_rc, ls_modify

Call	w_master::Open					//	FDG 07/17/97

dw_1.hide()

setpointer(hourglass!)
SetMicroHelp(w_main,'Creating summary report')

ib_view_detail_enabled = FALSE //NLG track #2281

//11-30-98 ts356 ***start****
integer li_upper, li_cols, li_pos
string  li_count[], ls_sql_right, ls_sql_left

If trim(iv_parm.group_by_flag) = 'G' then
	li_count[1] = ', SUM(' + iv_parm.sum_tbl_type + '.NBR_PAT)'
	li_count[2] = ', SUM(' + iv_parm.sum_tbl_type + '.UNIQUE_PROVIDERS)'
	li_count[3] = ', SUM(' + iv_parm.sum_tbl_type + '.NUMBER_OF_CLAIMS)'
	For li_cols = 1 to 3
		li_pos = pos(iv_parm.sql_statement,li_count[li_cols])
		If li_pos > 0 then
			li_upper = pos(iv_parm.sql_statement,'" ',li_pos)
			ls_sql_right = mid(iv_parm.sql_statement,li_upper + 1)
			ls_sql_left = left(iv_parm.sql_statement,li_pos - 1)
			iv_parm.sql_statement = ls_sql_left + ls_sql_right
		end if
	Next
// 01/19/99 ts2061c end

//	Do not add calculated columns
// When grouping the results
iv_parm.s_calc_cols = ""
end if

in_period = long(iv_parm.period)	// FNC 04/20/99

This.of_set_queryengine (TRUE)	//	FDG 01/08/98

inv_summ		=	CREATE	u_nvo_summary				

	//	Register iv_parm (sx_summary_parm passed from the previous
	//	window.
inv_summ.fuo_set_summary_parm (iv_parm)			

dw_rel.SetTransObject (Stars2ca)						
dw_rel.Retrieve (iv_parm.invoice_type)				

	// Register the DataWindow so it can be used by inv_summ
inv_summ.fuo_set_dw (dw_rel)							

	//	Filter the datawindow to only include the period & function passed.
inv_summ.fuo_filter_dw()
//FDG 07/29/96	End

iv_fields = iv_parm.group_fields
iv_invoice_type = iv_parm.invoice_type
il_period_key = iv_parm.period_key					// FDG 03/18/01
this.title = this.title + iv_parm.header
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

in_open_event = TRUE
in_detail_struct.src_type = 'SB'
//in_detail_struct.period = gv_period			// FNC 04/20/99
in_detail_struct.period = in_period				// FNC 04/20/99
in_detail_struct.table_type[1] = iv_invoice_type
in_current_sub_src_type = "SB"

SELECT period_desc,
       payment_from_date,
       payment_thru_date,
       from_date,
       thru_date
  INTO :ls_desc,
       :id_payment_from,
       :id_payment_thru,
       :id_from,
       :id_thru
  FROM period_cntl
 WHERE period_key = :il_period_key
 USING stars2ca;

if stars2ca.of_check_status() = -1 then
	Rollback using stars2ca;
	MessageBox('Error', 'Error selecting paid dates from period_cntl.', stopsign!)
	Return
else
	Commit using stars2ca;
end if

IF	iv_parm.provider_universe	=	TRUE		THEN
	cb_trend_report.visible		=	FALSE
ELSE
	cb_trend_report.visible		=	TRUE
END IF

lv_style="datawindow(units=1 )"&
  +"style(type=grid)"+"Column(font.Face='System' font.height =-10 font.weight =700)"&
  +"Text(font.Face='System' font.height =-10 font.weight =700 Border=4)"

lv_syntax = SyntaxFromSQL(Stars1ca,iv_parm.sql_statement,lv_style,lv_error)
if lv_error <> '' then
   messagebox('EDIT','Error building information for report. Error message = ' + lv_error,exclamation!)
	this.SetRedraw (TRUE)					// FDG 04/01/96
   return
end if

lv_sql_statement = iv_parm.sql_statement

li_rc = dw_1.Create(lv_syntax)
if li_rc = -1 Then
   messagebox('ERROR','Error building information for report:' + lv_error,exclamation!)
	this.SetRedraw (TRUE)					// FDG 04/01/96
   return
end if

This.Event	ue_set_window_colors (This.Control)

lv_pos = pos(lv_sql_statement,'FROM',1)
lv_sql_statement = mid(lv_sql_statement,1,lv_pos - 1)
lv_sql_statement = mid(lv_sql_statement,7)

lv_index = 1
lv_pos = pos(lv_sql_statement,',',1)
do while lv_pos > 0
   lv_col_name[lv_index] = mid(lv_sql_statement,1,lv_pos - 1)
   lv_sql_statement = mid(lv_sql_statement,lv_pos+1)
   lv_pos = pos(lv_sql_statement,',',1)
   lv_index ++
loop
//To get last column
lv_col_name[lv_index] = lv_sql_statement


in_header = 'Summary Analysis Report - ' + iv_parm.header + '~r'+ls_desc

	// Create the d/w and add header info
fx_add_d_head(in_header, dw_1, lv_col_name[],'50', '65', '125', '2', '400')

// JGG 01/15/98 Change labels2 to nvo service
dw_1.inv_labels.of_labels2(iv_parm.sum_tbl_type, '95', '40', '50')

setpointer(hourglass!)

in_dw_limit = gc_dw_limit

reset(dw_1)
SetTransObject(dw_1,stars1ca) 

//	Format calculated columns
IF iv_parm.s_calc_cols <> "" THEN
	li_cols = long(dw_1.Describe('datawindow.column.count'))
	
	for li_ctr = 1 to li_cols
		ls_col_name = dw_1.Describe('#'+string(li_ctr)+'.name')
		IF Upper( Left( ls_col_name, 8 ) )  = "COMPUTE_" THEN
			Setformat(dw_1,li_ctr,iv_parm.calc_disp_format[li_disp_ctr])
			ls_col_label = dw_1.Describe(ls_col_name + '_t.text')
			//Remove filler characters added to string to force COMPUTE column name
			ls_col_label = Left(ls_col_label, Len(ls_col_label)-5)  
			ls_error = dw_1.modify(string(ls_col_name) + '_t.text = "' + ls_col_label + '"')
			li_disp_ctr++		
		END IF
	next
END IF

lv_window_name = UPPER(this.classname())

lv_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,Stars1ca)
If lv_rc = -5 Then
	lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(lv_index)
End If


SetTransObject(dw_1,stars1ca)

lv_sql_statement = dw_1.GetSQLSelect()
gnv_sql.of_SetRowLimit( lv_sql_statement, iv_parm.rank, Stars1ca )
dw_1.SetSQLSelect( lv_sql_statement )

ll_nbr_rows = Retrieve(dw_1)					// FNC 03/11/99

gnv_sql.of_SetRowLimit( lv_sql_statement, 0, Stars1ca )

sle_count.text = string(ll_nbr_rows)

if ll_nbr_rows <=0 Then
  iv_crit = iv_crit + '@@' + in_header
	this.windowstate = minimized!
	OpenSheetwithParm(w_claim_rpt_no_data,iv_crit,MDI_main_frame,help_menu_position,original!)
	gv_rc = -1
   dw_1.taborder = 0
   COMMIT using stars1ca;
   if stars1ca.of_check_status() <> 0 then
      errorbox(stars1ca,'Error performing commit in open')
   end if          
	dw_1.SetRedraw(true)			
   cb_close.PostEvent(Clicked!)
	return
end if

COMMIT using stars1ca;
if stars1ca.of_check_status() <> 0 then
   errorbox(stars1ca,'Error performing commit in open')
end if

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
	this.SetRedraw (TRUE)					
	dw_1.SetRedraw(true)			
   errorbox(stars2ca,'Error performing commit in open')
   return
end if          


//load mle with sql
in_sql	=	iv_parm.sql_statement
wf_process_crit_for_display()

//allows user to see sql when press button or select option from menu
ib_allow_switch = TRUE

dw_1.show()
idw_print = dw_1

SetMicroHelp(w_main,'Ready')
end event

event activate;call super::activate;
dw_1.setredraw(false)

This.Event	ue_set_window_colors(This.Control)

cb_view_detail.enabled = ib_view_detail_enabled //NLG 5-12-00

dw_1.setredraw(true)
end event

on w_summ_rpt.create
int iCurrent
call super::create
this.cb_summ=create cb_summ
this.cb_trend_report=create cb_trend_report
this.st_dw_ops=create st_dw_ops
this.dw_rel=create dw_rel
this.dw_sum_select=create dw_sum_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_summ
this.Control[iCurrent+2]=this.cb_trend_report
this.Control[iCurrent+3]=this.st_dw_ops
this.Control[iCurrent+4]=this.dw_rel
this.Control[iCurrent+5]=this.dw_sum_select
end on

on w_summ_rpt.destroy
call super::destroy
destroy(this.cb_summ)
destroy(this.cb_trend_report)
destroy(this.st_dw_ops)
destroy(this.dw_rel)
destroy(this.dw_sum_select)
end on

event ue_preopen;call super::ue_preopen;
iv_parm = message.powerobjectparm

//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectParm)

end event

type ddlb_dw_ops from w_parent_rpt`ddlb_dw_ops within w_summ_rpt
integer x = 23
integer y = 1976
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
end type

event ddlb_dw_ops::selectionchanged;call super::selectionchanged;//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background

iv_uo_win.uo_decode.of_set_invoice_type(iv_invoice_type)
end event

type cb_clear from w_parent_rpt`cb_clear within w_summ_rpt
integer x = 2729
integer y = 1996
integer width = 370
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "C&lear"
end type

event cb_clear::clicked;call super::clicked;//************************************************************************
//	Object Name:	w_summ_rpt.cb_clear
//	Object Type:	CommandButton
//	Script Name:	Clicked
//************************************************************************
//FDG	07/29/96	STARS35 - Leave cb_subset disabled
//FDG 03/11/98 STARS 40 - Track 877 - Remove references to cb_subset.
//************************************************************************

cb_trend_report.enabled = FALSE
cb_summ.enabled = TRUE

end event

type st_1 from w_parent_rpt`st_1 within w_summ_rpt
integer x = 302
integer y = 2036
long backcolor = 83871462
end type

type cb_save_report from w_parent_rpt`cb_save_report within w_summ_rpt
integer x = 585
integer y = 2056
integer taborder = 0
end type

type sle_count from w_parent_rpt`sle_count within w_summ_rpt
integer x = 23
integer y = 2076
integer width = 279
integer height = 84
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
long textcolor = 0
end type

type cb_stop from w_parent_rpt`cb_stop within w_summ_rpt
integer x = 722
integer y = 2028
integer taborder = 0
integer textsize = -10
end type

type mle_crit from w_parent_rpt`mle_crit within w_summ_rpt
integer x = 37
integer width = 3483
integer textsize = -10
end type

type cb_query from w_parent_rpt`cb_query within w_summ_rpt
integer x = 1047
integer y = 1996
integer width = 370
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean default = true
end type

event cb_query::clicked;//******************************************************************
//DESCRIPTION  																	  
// OF SCRIPT:	  This script will do counts for a query for all 	  
//					  source types.  If it is Base it goes against 18	  
//					  tables.  The other two will go against one table
//***************************TITLE*********************************
//   Date   Init               Description of Changes Made         
// -------- ---- --------------------------------------------------
//	02/04/05	GaryR	Track 4269d	Use FastQuery instead of Header/Revenue on count
//	03/18/01	FDG	Call wf_count_data instead of fx_count_data since
//						ros_directory is no longer used.
//	01/12/98 FDG	Must clear out the query engine parms before calling
//						function wf_make_where.
// 11/20/95 FDG	Access Stars_rel via w_main.dw_stars_rel_dict
// 10/24/95 FNC  	Take out connects and disconnects
// 10/20/94 FNC  	Modified for Inpatient Summaries
// 05/25/94 SKM  	Created														  
//*******************************************************************


string tbl_directory[],lv_date_paid_operation,lv_date_paid_value
string lv_where,lv_table_types[]
long ll_rc2,ll_rc,lv_count,lv_temp_count   
long ll_row											// FDG 11/20/95

Setpointer(hourglass!)

//	Clear out the query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

in_detail_struct.prov_query_structure.do_prov_query = FALSE

//This builds the where statement for the criteria based on what the
//user entered.
in_detail_struct.where_statement = Parent.event ue_view_detail( TRUE )
if in_detail_struct.where_statement = 'ERROR' then return

w_main.Setmicrohelp('Retrieving count for the query')

//This if statement checks to see if the 'ALL' Selection was picked
if in_detail_struct.table_type[1] = 'MC' THEN
	ll_row	=	0
	DO UNTIL ll_row	<	0
		ll_row	=	fx_get_next_stars_rel (ll_row, 'GP', gv_sys_dflt, ' ')
		IF	ll_row	<	0		THEN
			exit
		END IF
		lv_table_types[1] = w_main.dw_stars_rel_dict.GetItemString (ll_row, "ID_2")
		if in_detail_struct.coming_from_eligibility_analysis then
			lv_table_types[2] = in_detail_struct.table_type[2]
		end if
		//This gets the count for the specific table type sent through
		// FDG 03/18/01 - use wf_count_data instead of fx_count_data
		//lv_temp_count = fx_count_data(lv_table_types,lv_num_tables,in_detail_struct.src_type,in_detail_struct.where_statement,in_detail_struct.tbl_directory,in_detail_struct.table_type,TRUE,0,in_detail_struct.prov_query_structure)
		lv_temp_count	=	wf_count_data (lv_table_types)
		if lv_temp_count = -1 then 
			return
		end if
		lv_count = lv_count + lv_temp_count
// FDG 11/20/95 end
	LOOP
	
else		
		//This does the count for any of the other invoice choices
		//	and it includes any joins
		// FDG 03/18/01 - use wf_count_data instead of fx_count_data
		//lv_count = fx_count_data(in_detail_struct.table_type,lv_num_tables,in_detail_struct.src_type,in_detail_struct.where_statement,in_detail_struct.tbl_directory,in_detail_struct.table_type,TRUE,0,in_detail_struct.prov_query_structure)
		lv_count	=	wf_count_data (in_detail_struct.table_type)
		if lv_count = -1 then return
end if

//This puts the final count in the count box
sle_count.text = string(lv_count)

w_main.Setmicrohelp('Ready')

end event

type cb_view_detail from w_parent_rpt`cb_view_detail within w_summ_rpt
event ue_view_detail ( )
integer x = 1888
integer y = 1996
integer width = 370
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&View Data..."
end type

event cb_view_detail::clicked;//	02/04/05	GaryR	Track 4269d	Use FastQuery instead of Header/Revenue on count
Parent.Event	ue_view_detail( FALSE )

end event

type cb_close from w_parent_rpt`cb_close within w_summ_rpt
integer x = 3150
integer y = 1996
integer width = 370
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
end type

type dw_1 from w_parent_rpt`dw_1 within w_summ_rpt
string tag = "CRYSTAL, title = Summary Report"
integer x = 37
integer y = 424
integer width = 3483
integer height = 1484
string dataobject = ""
end type

event dw_1::rbuttondown;//*************************************************************
// 10/24/95	FNC	Take out connects and disconnects
// 05/05/00	GaryR	SC 2883	Uncomment DB error on not found
// 03/19/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	04/11/01	GaryR	Stars 4.7 DataBase Port - Trimming the data
//	09/13/06	GaryR	Track 4817	Replace Int with Long to prevent 32K limit
//	03/28/07	Katie		SPR 4953 Instead of directly opening w_definition call fx_lookup to open it.
//*************************************************************

string lv_hold_object,lv_col_name,lv_cname, lv_tbl_type,lv_holdrow,lv_hold_cname
string lv_tmp_cname,lv_where_message
long lv_tabpos
int lv_pos, li_x

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
	else
		lv_col_name = Left(lower(lv_cname), len(lv_cname) - 2)
	end if



//This grabs the column name of the summarize field
	lv_hold_cname = lv_cname
//	lv_cname = dw_1.Describe('#'+string(counter)+'.name')
	lv_tmp_cname = dw_1.Describe(lv_cname+'.text')	
	lv_pos = pos(lv_tmp_cname,'~r')
	if lv_pos <> 0 then
		lv_tmp_cname = replace(lv_tmp_cname,lv_pos,1,'~~r')
	end if
	
	SELECT elem_name
	INTO :lv_cname
	FROM dictionary
	WHERE elem_type = 'CL' and
			elem_tbl_type = Upper( :iv_parm.sum_tbl_type ) and
			Upper(elem_elem_label) = Upper( :lv_tmp_cname )		// 03/19/01	GaryR	Stars 4.7 DataBase Port
	Using Stars2ca;
	if stars2ca.of_check_status() = 100 Then
		//HRB - 7/28/95 - swat
		//lv_where_message = 	"WHERE elem_type = 'CL' and elem_tbl_type = :"+iv_parm.sum_tbl_type+" and elem_elem_label = :"+lv_tmp_cname 
		//05/05/2000	Gary-R	SC 2883 Begin
		//errorbox(stars2ca,"Unable to find column in the Dictionary Table: "+lv_where_message)
		//sqlcmd('disconnect',stars2ca,'',5)   10-24-95 FNC Start
		//05/05/2000	Gary-R	SC 2883 End
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in dw_1')
      end if          //10-24-95 FNC End
		return 
	elseIf stars2ca.sqlcode <> 0 then
		//HRB - 7/28/95 - swat
		lv_where_message = 	"WHERE elem_type = 'CL' and elem_tbl_type = :"+iv_parm.sum_tbl_type+" and Upper(elem_elem_label) = :"+ Upper( lv_tmp_cname )
		errorbox(stars2ca,'Error reading from the Dictionary Table: '+lv_where_message)
		//sqlcmd('disconnect',stars2ca,'',5)   10-24-95 FNC Start
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in dw_1')
      end if          //10-24-95 FNC End
		return 
	end if

lv_tbl_type = iv_parm.sum_tbl_type

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
    errorbox(stars2ca,'Error performing commit in dw_1')
    return
 end if          //10-24-95 FNC End

	gv_element_table_type = lv_tbl_type
	gv_element_name = lv_cname
	lv_pos = pos(lv_hold_object,'_t')
	if lv_holdrow = string(1) and lv_pos <> 0 then
		open(w_dwlabel_definition)
	else

	Select ELEM_Lookup_Type into :gv_code_to_use
	From dictionary
	where ELEM_TBL_Type = Upper( :lv_tbl_type ) and
	ELEM_Name = Upper( :lv_cname )
	using stars2ca;
	
	//	04/11/01	GaryR	Stars 4.7 DataBase Port
	if (stars2ca.of_check_status()=100) or (Trim( gv_code_to_use ) = '') then
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in dw_1')
      end if          
		return	
	elseif (stars2ca.sqlcode<>0) Then
		//HRB - 7/28/95 - swat
		lv_where_message = 	"where ELEM_TBL_Type = :"+lv_tbl_type+" and ELEM_Name = :"+lv_cname
		errorbox(stars2ca,'Error Reading Dictionary Table: '+lv_where_message)
		return
	end if
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      errorbox(stars2ca,'Error performing commit in dw_1')
      return
   end if          //10-24-95 FNC End


//DJP - NDC Prod lookup
	if gv_code_to_use='LP' then
		gv_code_id_to_use=dw_1.getitemstring(Long(lv_holdrow),'NDC_LAB_CODE')+&
		  dw_1.GetItemString(Long(lv_holdrow),lv_col_name)
	else
		gv_code_id_to_use = dw_1.GetItemString(Long(lv_holdrow),lv_col_name)
	end if
	gv_win_x_pos = dw_1.x+10+li_x+this.x
	gv_win_y_pos = 315 + dw_1.y
end if

fx_lookup(dw_1, iv_parm.sum_tbl_type )

end event

event dw_1::clicked;// THIS SCRIPT HANDLES THE SELECTION OR DE-SELECTION OF ROWS
// IN THE DATAWINDOW.  VARIOUS BUTTONS ARE TURNED ON OR OFF BASED
// ON THE NUMBER OF SELECTED ROWS.  SELECTED ROWS ARE LIMITED TO 10.
//************************************************************************
//ajs 03-16-98 4.0 TS145 - Hard Coding Removal
//FDG	07/29/96	STARS35 - Leave cb_subset disabled.
//NLG	3-13-00	Patient profiles. For pharmacy summaries with DRUGCAT,
//					don't allow more than 1 row to be selected. Drugcat is
//					changed to NDC_Code filter for drilldown. QE does a join with
//					the filter table. If select multiple rows, too many joins
//					jam up the server 
//NLG 4-7-00	Instead of preventing more than 1 row being selected
//					when column has DRUGCAT, simply disable view data so that
//					can still trend on multiple rows
//NLG 5-12-00	Track #2281. Create an instance variable to determine
//					if cb_view_detail should be enabled. In activate,
//					will check boolean and set button accordingly.
//************************************************************************
boolean lb_is_drugcat
int li_idx, li_num_of_fields
long lv_row_nbr

Parent.setmicrohelp("Ready")//NLG 3-13-00 Clear out any previous microhelp

if in_retrieve_end = TRUE then
		lv_row_nbr = row
		
		if lv_row_nbr = 0 then return
		
		if lv_row_nbr = 0 and in_num_rows_sel = 0 Then
			cb_view_detail.enabled = FALSE
			cb_query.enabled = FALSE
			cb_trend_report.enabled = FALSE
			cb_clear.enabled = FALSE
			cb_summ.enabled = FALSE
		//	cb_summ.enabled = TRUE
			return
		else  //if iv_summary_type = 'FINANCIAL' then
		
			cb_trend_report.enabled = TRUE
		
			cb_clear.enabled = TRUE
			cb_summ.enabled = TRUE
				cb_view_detail.enabled = TRUE
				cb_query.enabled = TRUE
		end if
		
		if isSelected(dw_1,lv_row_nbr) Then
			Selectrow(dw_1,lv_row_nbr,FALSE)
			in_Num_rows_sel = in_Num_rows_sel - 1
		
			if in_num_rows_sel >= 1 then
				if in_num_rows_sel = 1 then
					cb_summ.enabled = TRUE
				else
					cb_summ.enabled = FALSE
				end if
			end if
		
		else
			if in_num_rows_sel >= 10 then
				Selectrow(dw_1,lv_row_nbr,FALSE)
				MessageBox("Selection Error","You Have Selected The Maximum Number Of Rows (10)")
				dw_1.Modify("datawindow.selected.mouse=no")
			else
				//NLG 3-13-00 If summary uses drug category, only allow 1 row to be selected
				//Loop thru the fields selected
				//NLG 3-13-00 Start
				li_num_of_Fields = upperbound(iv_fields)
				lb_is_drugcat = FALSE
				FOR li_idx = 1 to li_num_of_fields
					IF Upper(iv_fields[li_idx].col_name) = ics_drugcat THEN
						lb_is_drugcat = TRUE
					END if
				NEXT
				//NLG 3-13-00 Stop
				
				if in_num_rows_sel >= 1 then
					if in_num_rows_sel = 1 and lv_row_nbr = 0 then
						cb_summ.enabled = TRUE
					else
						cb_summ.enabled = FALSE
					end if
				end if
					
				if lv_row_nbr <> 0 then
					IF lb_is_drugcat AND in_num_rows_sel >= 1 THEN	//NLG 3-13-00
						//Parent.setmicrohelp("The NDC filter allows drilldown on only 1 row at a time")//NLG 3-13-00
						cb_view_detail.enabled = FALSE					//NLG 4-07-00
					ELSE
						cb_view_detail.enabled = TRUE						//NLG 4-07-00
					END IF														//NLG 4-07-00
					
									
					ib_view_detail_enabled = cb_view_detail.enabled//NLG 5-12-00 Track #2281
					
					//ELSE														//NLG 3-13-00
						Selectrow(dw_1,lv_row_nbr,TRUE)
						in_Num_rows_sel = in_Num_rows_sel + 1
					//END IF														//NLG 3-13-00
				end if

			end if//num of selected rows >= 10
		end if
		
				
		
		if in_num_rows_sel <= 0 Then
			in_num_rows_sel = 0
			cb_view_detail.enabled = FALSE
			cb_query.enabled = FALSE
			cb_clear.enabled = FALSE
		//	cb_summ.enabled = FALSE
			cb_summ.enabled = TRUE
			cb_trend_report.enabled = FALSE
		end if
end if
end event

event dw_1::doubleclicked;//BV 8/18/95 - Pulled the script from w_parent report that is necessary
// for window ops and put it here. Commented out only the piece that 
// was causing a problem.
//SWD Leave this comment here.  it is the only way the script from the 
//parent will be commented out.
// JasonS 10/02/02 Track 2273d dont check gv_cancel_but_clicked

int tabpos, li_rc
long row_nbr, lv_row_nbr
string lv_col,lv_col_name,lv_data_type,lv_hold_object,lv_sort_name
string lv_tbl_type
boolean lv_join


lv_join = FALSE
setpointer(hourglass!)
//if gv_cancel_but_clicked=TRUE Then	// JasonS 10/02/02 Track 2273d
			/*gets the row and makes sure a row was clicked*/
		setpointer(hourglass!)
		lv_hold_object = Getobjectatpointer(dw_1)
		if lv_hold_object = '' then
			return
		end if
//store the current row number and the column name
	
		tabpos = pos (lv_hold_object,"~t")
		lv_col = left(lv_hold_object,(tabpos - 1))
		
		If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
			If in_selected <> '1' Then
				Messagebox('Information','You must select an option from Window Operations')
			Else
				ddlb_dw_ops.triggerevent(selectionchanged!)
			End If
//			lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
			li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
		ElseIf in_dw_control = 'FILTER' Then
				ddlb_dw_ops.triggerevent(selectionchanged!)
				lv_row_nbr = row
//				lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
				li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
		ElseIf in_dw_control = 'FIND' Then
			ddlb_dw_ops.triggerevent(selectionchanged!)
			lv_row_nbr = row
//			lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
			li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
		Else
		end if
//end if	// JasonS 10/02/02 Track 2273d
end event

on dw_1::rowfocuschanged;//Commented this out SWD for prob 995.  This script should be overridden
//Always make sure at least one comment is always here.

	
end on

on dw_1::retrievestart;call w_parent_rpt`dw_1::retrievestart;setpointer(hourglass!)
end on

on dw_1::retrieveend;Setpointer(hourglass!)
in_button_not_modified[1] = cb_query
in_button_not_modified[2] = cb_view_detail
in_button_not_modified[3] = cb_clear
in_button_not_modified[4] = cb_trend_report
call w_parent_rpt `dw_1::retrieveend

in_retrieve_end = TRUE

w_main.SetMicroHelp('Ready')
end on

type cb_summ from u_cb within w_summ_rpt
string accessiblename = "Summary"
string accessibledescription = "Summ..."
integer x = 1467
integer y = 1996
integer width = 370
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Summ..."
end type

event clicked;//this event takes the row that has been selected and loads a 
//structure to be passed to the w_summary_financial window for further use.
//When more than one row is selected, this option is disabled.

//***************************************************************
//	10/11/95 FNC	Take upperbound out of script
//	05/12/03	GaryR	Track 5180c	Decoded columns improperly trimmed
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//  10/13/2005 Katie Track 4533d If value is blank change to BLANKS.
//***************************************************************

string lv_col,lv_value
long lv_selected_row
int i,j,lv_upperbound
sx_summary_parm lv_summ
n_cst_decode	lnv_decode

gv_summ_flg = TRUE
lv_summ = iv_parm
lv_selected_row = dw_1.GetSelectedRow(0)
if lv_selected_row <> 0 then
   lv_upperbound = upperbound(lv_summ.group_fields)  //10-11-95 FNC
	for i = 1 to lv_upperbound                        //10-11-95 FNC
		for j = 1 to lv_upperbound                     //10-11-95 FNC
			lv_col = UPPER(dw_1.describe('#'+string(j)+'.name'))
			if lv_col = iv_fields[i].col_name then
		 		lv_summ.group_fields[i].operator = '='
				lv_value = trim(dw_1.getitemstring(lv_selected_row,j))
				//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
				IF lnv_decode.of_is_decoded( dw_1, lv_col ) THEN
					lnv_decode.of_remove_desc( lv_value )
				END IF
				if lv_summ.group_fields[i].value = ' ' then 
					lv_summ.group_fields[i].value = 'BLANKS'
				else
					lv_summ.group_fields[i].value = lv_value
				end if
				exit
			end if
		next
	next
else
//	messagebox('DataWindow Error','Error selecting row.  Unable to return to Analysis window.')
//	return
end if

if isvalid(w_summary_financial) then
	close(w_summary_financial)
end if

OpenSheetwithparm(w_summary_financial,lv_summ,MDI_Main_Frame,help_menu_position,Layered!)

end event

type cb_trend_report from u_cb within w_summ_rpt
string accessiblename = "Trend"
string accessibledescription = "Trend..."
integer x = 2309
integer y = 1996
integer width = 370
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&Trend..."
end type

event clicked;//create where clause for trend report, then open trend report

SetMicroHelp(w_main,'Creating specifications for Trend Report. Please Wait!') 

//	Clear out the query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

iv_parm.sql_statement = wf_make_trend_where()
if iv_parm.sql_statement = 'ERROR' then
	SetMicroHelp(w_main,'Ready')	
	return
end if


if isvalid(w_trend_rpt) then
	close(w_trend_rpt)
end if


OpenSheetWithParm(w_trend_rpt,iv_parm,MDI_Main_Frame,help_menu_position,Layered!)
end event

type st_dw_ops from statictext within w_summ_rpt
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 1916
integer width = 658
integer height = 60
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

type dw_rel from u_dw within w_summ_rpt
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2830
integer y = 1816
integer width = 704
integer height = 188
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sum_rel"
end type

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in the data.
//This.of_SetTrim (TRUE)

end event

type dw_sum_select from u_dw within w_summ_rpt
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1024
integer y = 1184
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sum_select"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

