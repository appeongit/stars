HA$PBExportHeader$u_nvo_search.sru
$PBExportComments$Inherited from u_nvo_query <logic>
forward
global type u_nvo_search from u_nvo_query
end type
end forward

global type u_nvo_search from u_nvo_query
event type integer ue_tabpage_search_set_authorization ( string as_auth_id )
event type integer ue_tabpage_search_set_dates ( )
event type integer ue_tabpage_search_set_period ( )
event type integer ue_tabpage_search_set_columns ( string as_inv_type,  string as_dep_type,  character ac_claim_type )
event type integer ue_tabpage_search_load ( integer ai_level_num )
event type integer ue_tabpage_search_code_lookup ( string as_value,  integer ai_row )
event type integer ue_tabpage_search_add_row ( )
event type integer ue_tabpage_search_insert_row ( )
event type integer ue_tabpage_search_delete_row ( )
event type integer ue_tabpage_search_ml_filter_check ( string as_come_from )
event type integer ue_tabpage_search_save ( integer ai_level,  string as_query_id )
event type integer ue_tabpage_search_clear ( )
event type integer ue_tabpage_search_get_prov_choices ( boolean ab_npi )
event type integer ue_tabpage_search_set_period_visibility ( )
event type integer ue_tabpage_search_edit_report_dates ( )
event ue_count ( )
event ue_criteria_save ( )
event type integer ue_format_where_criteria ( string as_type,  boolean ab_add_payment_date,  ref string as_where[],  ref sx_criteria astr_criteria[] )
event type integer ue_format_where_criteria_add_clauses ( string as_type,  ref string as_where[],  ref sx_criteria astr_criteria[] )
event ue_string_sql_statement ( ref string as_sql_statement[] )
event type integer ue_subsetting ( ref sx_subsetting_info asx_subsetting_info )
event type integer ue_subsetting_set_filter_create ( ref sx_all_filter_info asx_all_filter_info )
event ue_tabpage_search_no_period_dates ( )
event type integer ue_subsetting_clear_filter_copy ( )
event type string ue_compute_payment_date ( ref string as_payment_date )
event type integer ue_set_payment_date ( )
event type integer ue_tabpage_search_set_pd_opt_visibility ( )
end type
global u_nvo_search u_nvo_search

type variables
string is_last_filter_used
Boolean	ib_return		//	10/23/02	GaryR	SPR 3354d

end variables

event type integer ue_tabpage_search_set_authorization(string as_auth_id);/////////////////////////////////////////////////////////////////////
//	Script:	uo_tabpage_search_set_authorization(string as_auth_id)
//
//	Arguments:
//				as_auth_id - The authorization ID
//
//	Description:
//		This event is caled by w_query_engine.ue_postopen event to load 
//		the authorization data into the criteria.  The as_auth_id consists 
//		of a flag to determine if id is provider or patient ('P' or 'R'), 
//		table type (2nd and 3rd characters) and finally the data value.  
//		Must add a row, select the column, set the rel_op to '=' and 
//		load the data value.
//
/////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created
//
//	FDG	02/02/98	1. If there are no rows in the 'expression_one' DDDW,
//						then trigger ue_tabpage_search_set_columns to	
//						retrieve its data.
//						2. Search for elem_name instead of col_name.
//						3. Since the DDDW for expression_one displays col_desc
//						but stores col_name, the setitem for expression_one
//						must be to col_name.
//	FDG	11/09/01	Stars 5.0.  Each time expression_one is changed,
//						filter the entries in expression_two
//
/////////////////////////////////////////////////////////////////////

string ls_find, ls_table_type, ls_col
integer li_exp1_count, li_row
long ll_count

ls_table_type = Mid(as_auth_id,2,2)

datawindowchild ldwc_exp1
idw_criteria.insertrow(0)
ll_count = idw_criteria.rowcount()
idw_criteria.getchild('expression_one',ldwc_exp1)

li_exp1_count = ldwc_exp1.rowcount()

//	If no rows in the DDDW, then retrieve them.
IF	li_exp1_count	<	1		THEN
	This.Event	ue_tabpage_search_set_columns (ls_table_type, ls_table_type, 'M')
	idw_criteria.getchild('expression_one',ldwc_exp1)
	li_exp1_count = ldwc_exp1.rowcount()
END IF

li_exp1_count = li_exp1_count + 1

/* hardcoded prov_id and recip_id below, use until find a better way */
if left(as_auth_id,1) = 'P' then
	ls_find = "elem_name = 'PROV_ID'"			//	FDG 02/02/98
else
	ls_find = "elem_name = 'RECIP_ID'"			//	FDG 02/02/98
End If

li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)
If li_row < 1 Then
	MessageBox('Error - Tabpage Search',&
		'The following column name was not found in the criteria ' &
		+ 'datawindow:  ' + ls_find ,StopSign!,Ok!)
	Return -1
End If

/* set prov_id row using li_row*/	
/* set recip_id row using li_row*/
ls_col = ldwc_exp1.GetItemString(li_row,'col_name')		// FDG 02/02/98
idw_criteria.SetItem(ll_count,'expression_one',ls_col)
idw_criteria.Dynamic	Event	ue_filter_exp2 ("", ls_col)	// FDG 11/09/01

idw_criteria.object.relational_op[ll_count] = '='
idw_criteria.object.expression_two[ll_count] = mid(as_auth_id,4)

Return 1
end event

event type integer ue_tabpage_search_set_dates();///////////////////////////////////////////////////////////////////////
//	Script:	uo_tabpage_search_set_dates()
//
//	Description:
//		This event is called to set the dates corresponding to the 
//		period selected in uo_period into dw_criteria.  
//		But only do this if there are no payment or from_dates already set.  
//		First must get the period selected.  
//		Then select payment and from date field in dw_criteria and set 
//		their relational operators to between.  
//		(example in w_parent_detail_analysis.uo_1.selectionchanged)  
//
//	NOTE:
// 	Protect_row_sw is a new column.  The Protect attribute 
// 	expression looks at the contents of this column.  In
//		the d/w object, if protect_row_sw = Y, then each column
//		is protected.
//	
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created
//	FDG	02/11/98	1. After adding rows for payment date and from date, go 
//							back and add "AND" to logical_op.  
//						2. When adding new date rows, add them to the beginning.
// FNC	02/12/98	Convert the datetime to date and take out the space in 
//						between the from and thru dates.
//	FDG	04/13/98	Track 973.  When changing the Period, do NOT display
//						the messagebox asking if you want the dates reset.
//	FDG	05/01/98	Track 1170.  Replace '><' with 'BETWEEN' to keep
//						the GUI consistant.
//	FDG	05/07/98	Track 1207.  Ancillary invoice types (i.e. EN, PV)
//						do not require payment dates and from dates.
//	FDG	05/12/98	Track 1223.  Set the count after adding a row.
//	FDG	06/30/98	Track 1351.  Use a 4-digit date.
// AJS   08-03-98 Track 1522. Pass period key and function to load dates.
//	FDG	08/05/98	Track 1235, 1248.  When drilling down (i.e. from C2
//						to CG), it is possible that either the payment_date
//						or the from_date may not be found.  If so, don't
//						insert new criteria and don't display a message.
// NLG	08-11-98	Track #1565 If changing periods after inserting
//						line of criteria, was losing the inserted criteria's value
//						Added AcceptText() before deleterow.
//	FDG	08/19/98	Track 1560.  On a multi-level query, set the dates
//						from the previous level and set the period to 'NONE'.
//	FDG	10/14/98	Track 1832.  Make sure there's at least 1 line of 
//						criteria.
// FNC	04/13/00 Track 2856. When searching for payment date include invoice
//						type to insure that main invoice type is selected.
// FNC 	05/16/00 Track 2185. Allow users to change period on levels > 1. 
//						This change reverses the change from 8/19/98 Track 1560.
//	GaryR	04/19/01	Fix bug to select the FROM_DATE of main invoice type.
//	GaryR	09/17/02	SPR 3986c	Default PAYMENT_DATE in criteria.
//	GaryR	10/23/02	SPR 3354d	Prevent duplicate paid dates in ML
//	GaryR	01/23/03	Track 2353d	Encapsulate user criteria with parenthesis
///////////////////////////////////////////////////////////////////////


String	ls_exp1,					&
			ls_find,					&
			ls_prev_find,			&
			ls_col,					&
			ls_logical_op
Integer	li_exp1_count,			&
			li_idx,					&
			li_rowcount,			&
			li_row,					&
			li_pay_row,				&
			li_from_row,			&
			li_new_row,				&
			li_prev_row,			&
			li_prev_rowcount,		&
			li_messagebox_return
datawindowchild	ldwc_exp1,	&
						ldwc_exp2
Datetime	ld_from_date,			&
			ld_thru,					&
			ld_payment_from,		&
			ld_payment_thru
Boolean	lb_found				//	GaryR	04/19/01

idw_criteria.getchild('expression_one',ldwc_exp1)
li_exp1_count = ldwc_exp1.rowcount()
li_rowcount = idw_criteria.rowcount()

//John_wo 1/12/98	- commented out the following lines. This condition
//                  is possible.
//If li_rowcount > 0 or ib_query_loaded_flag = False Then
//Else
//	MessageBox('Error - ue_tabpage_search_set_dates for u_nvo_search.',&
//	'The criteria datawindow does not contain any ' &
//		+ 'rows.  Please report this problem to VIPS',StopSign!,Ok!)
//	Return -1
//End If

For li_idx = 1 to li_rowcount

	ls_exp1 =trim(idw_criteria.object.expression_one[li_idx])
	if mid(ls_exp1,4) = 'PAYMENT_DATE' then
		li_pay_row = li_idx
	end if
	if mid(ls_exp1,4) = 'FROM_DATE' then
		li_from_row = li_idx
	end if
next
idw_criteria.AcceptText()//NLG Track #1565
if li_pay_row > 0 or li_from_row > 0 then
	// FDG 04/13/98 begin - remove the messagebox and its response
	
//	li_messagebox_return = MessageBox('Message',&
//		'The current search criteria has payment and/or from dates set.' &
//		+ '  Do you want to reset the dates?', Question!,YesNo!,2) 
	
//	if li_messagebox_return = 1 then

		// clear out current rows 
		if li_pay_row > 0 then
			idw_criteria.deleterow(li_pay_row)
			If li_pay_row < li_from_row Then
				li_from_row = li_from_row - 1
			End If
		end if
		if li_from_row > 0 then
			idw_criteria.deleterow(li_from_row)
		end if
		li_rowcount = idw_criteria.rowcount()
//	else
//		return 1
//	end if
	// FDG 04/13/98 end
end if

// FDG 10/14/98 begin
// always make sure there is at least on line of criteria
IF	li_rowcount		=	0		THEN
	li_rowcount	=	idw_criteria.InsertRow(0)
	idw_criteria.ScrollToRow (li_rowcount)
END IF
// FDG 10/14/98 end

	/* insert new rows */
	
If iu_period.uf_return_desc() = 'NONE' Then
	// Determine if any dates need to be carried over from the prior level
	This.Event	ue_tabpage_search_no_period_dates()
	
	IF ib_return THEN Return 1		//	GaryR	10/23/02	SPR 3354d
End If

iu_period.&
	uf_return_dates(ld_from_date,ld_thru,ld_payment_from,ld_payment_thru)


// FDG 05/07/98 begin
IF	iuo_query.of_get_ancillary_inv_type()	=	TRUE &
OR	Upper( iuo_query.of_get_data_type() )	=	"SUBSET"	THEN		//	GaryR	10/18/02	SPR 3986c
	Return 1
END IF
// FDG 05/07/98 end

// FDG 08/19/98 begin
// Determine if any criteria exists from the prior level
IF	IsValid (idw_prev_criteria)		THEN
	li_prev_rowcount	=	idw_prev_criteria.RowCount()
ELSE
	li_prev_rowcount	=	0
END IF
// FDG 08/19/98 end

//ls_find = "mid(col_name,4) = 'PAYMENT_DATE'"						// FNC 04/13/00 
ls_find = "col_name = '" + is_inv_type + ".PAYMENT_DATE'"		// FNC 04/13/00
li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)

If li_row > 0 Then
	// FDG 08/05/98 begin
	//If the first row is empty, overwrite the first row.
	If IsNull(ls_exp1) and li_rowcount = 1 Then	
		li_new_row = 1
	Else
		// FDG 02/11/98 - Insert at the beginning
		li_new_row = idw_criteria.insertrow(1)		
	End If
	ls_col = ldwc_exp1.getitemstring(li_row,'col_name')
	idw_criteria.setitem(li_new_row,'expression_one',ls_col)
	idw_criteria.object.relational_op[li_new_row] = 'BETWEEN'						// FDG 05/01/98
	idw_criteria.object.expression_two[li_new_row] = &
		String(date(ld_payment_from), "mm/dd/yyyy") + "," + &
		String(date(ld_payment_thru), "mm/dd/yyyy")		//02-12-98 FNC		// FDG 06/30/98
	idw_criteria.setitem(li_new_row,'left_paren','(')
	idw_criteria.setitem(li_new_row,'right_paren',')')
	idw_criteria.setitem(li_new_row,'logical_op','AND')
	// Protect_row_sw is a new column.  The Protect attribute 
	// expression looks at the contents of this column.  In
	//	the d/w object, if protect_row_sw = Y, then each column
	//	is protected.
	idw_criteria.setitem(li_new_row,'protect_row_sw','Y')
	// FDG 08/19/98 begin
	// For a multi-level query, find "payment_date" from the previous
	//	level (by search idw_prev_criteria).  If found use these
	//	dates
	// FNC 05/16/00 Start
//	IF	li_prev_rowcount	>	0		THEN
//		// dw_criteria exists on the prior level with criteria
////		ls_prev_find	=	"mid(expression_one,4) = 'PAYMENT_DATE'"			// FNC 04/13/00 
//		ls_prev_find	=	"expression_one = '" + is_inv_type + ".PAYMENT_DATE'"	// FNC 04/13/00
//		li_prev_row		=	idw_prev_criteria.Find (ls_prev_find, 1, li_prev_rowcount)
//		IF	li_prev_row	>	0		THEN
//			// Found payment date from the prior level.  Set the value on this level
//			//	to the date value found on the prior level
//			idw_criteria.object.expression_two [li_new_row]	=		&
//								idw_prev_criteria.object.expression_two [li_prev_row]
//			idw_criteria.object.relational_op [li_new_row]	=		&
//								idw_prev_criteria.object.relational_op [li_prev_row]
//			// Reset the period to 'NONE'
//			iuo_query.of_date_change()
//		ELSE
//			// Could not find payment date from the prior level.  Remove payment date from
//			//	the current level
//			idw_criteria.DeleteRow(li_new_row)
//		END IF
//	END IF
	// FDG 08/19/98 end
	// FNC 05/16/00 End
	
Else
	//MessageBox('Error',&
	//	'The Payment_Date field was not found in the Query.' &
	//	+ ' Please specify a period.',StopSign!,Ok!)
	//Return -1
	// FDG 08/05/98 end
End If

//	GaryR	09/17/02	SPR 3986c - Begin
IF iu_period.uf_return_desc() = 'NONE' THEN
	IF li_new_row > 0 THEN idw_criteria.object.expression_two[li_new_row] = ""
	Return 1
END IF
//	GaryR	09/17/02	SPR 3986c - End

If IsNull(ld_from_date) and IsNull(ld_thru) then						//AJS 08-03-98 Track #1522
	//Do not add from dates if they are not supplied in period 		//AJS 08-03-98 Track #1522
else
	// FDG 02/11/98 - Insert at the beginning
	//	GaryR	04/19/01 - Begin
	ls_find = "col_name = '" + is_inv_type + ".FROM_DATE'"
	li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)
	
	IF li_row > 0 THEN	
		lb_found = TRUE
	ELSE
		ls_find = "mid(col_name,4) = 'FROM_DATE'"
		li_row = ldwc_exp1.find(ls_find,1,li_exp1_count)
		IF li_row > 0 THEN lb_found = TRUE
	END IF
	
	//	GaryR	04/19/01 - End
	IF lb_found Then
		li_new_row ++
		li_new_row = idw_criteria.insertrow(li_new_row)
		ls_col = ldwc_exp1.getitemstring(li_row,'col_name')
		idw_criteria.setitem(li_new_row,'expression_one',ls_col)
		idw_criteria.object.relational_op[li_new_row] = 'BETWEEN'		// FDG 05/01/98
		idw_criteria.object.expression_two[li_new_row] = & 
			String(date(ld_from_date), "mm/dd/yyyy") + "," + &
			String(date(ld_thru), "mm/dd/yyyy")			//02-12-98 FNC		// FDG 06/30/98
		idw_criteria.setitem(li_new_row,'left_paren','(')
		idw_criteria.setitem(li_new_row,'right_paren',')')
		idw_criteria.setitem(li_new_row,'logical_op','AND')
		idw_criteria.setitem(li_new_row,'protect_row_sw','Y')	
	
		//	Add an "AND" in the logical operator where needed and
		//	unprotect the logical operator of the last row so that
		//	new criteria can be entered.
		// FDG 08/19/98 begin
		// For a multi-level query, find "payment_date" from the previous
		//	level (by search idw_prev_criteria).  If found use these
		//	dates
// FNC 05/16/00 Start
//		IF	li_prev_rowcount	>	0		THEN
//			// dw_criteria exists on the prior level with criteria
//			ls_prev_find	=	"mid(expression_one,4) = 'FROM_DATE'"
//			li_prev_row		=	idw_prev_criteria.Find (ls_prev_find, 1, li_prev_rowcount)
//			IF	li_prev_row	>	0		THEN
//				// Found from date from the prior level.  Set the value on this level
//				//	to the date value found on the prior level
//				idw_criteria.object.expression_two [li_new_row]	=		&
//									idw_prev_criteria.object.expression_two [li_prev_row]
//				idw_criteria.object.relational_op [li_new_row]	=		&
//									idw_prev_criteria.object.relational_op [li_prev_row]
//				// Reset the period to 'NONE'
//				iuo_query.of_date_change()
//			ELSE
//				// Could not find from date from the prior level.  Remove from date from
//				//	the current level
//				idw_criteria.DeleteRow(li_new_row)
//			END IF
//		END IF
// FNC 05/16/00 End
		// FDG 08/19/98 end
	Else
		//MessageBox('Error',&
		//	'The From_Date field was not found in the Query.' &
		//	+ ' Please specify a period.',StopSign!,Ok!)
		//Return -1
		// FDG 08/05/98 end
	End If
End If																				//AJS 08-03-98 Track#1522

li_rowcount = idw_criteria.rowcount()

For li_idx = 1 to li_rowcount
	ls_logical_op	=	idw_criteria.object.logical_op [li_idx]
	IF	li_idx	=	li_rowcount		THEN
		// Last row, remove any "AND" in logical_op
		IF	Trim (ls_logical_op)	>	'  '		THEN
			idw_criteria.object.logical_op [li_idx]	=	''
		END IF
	ELSE
		// Not the last row in the d/w, if there is no logical_op,
		//	then add one ('AND').
		IF	IsNull (ls_logical_op)				&
		OR	Trim (ls_logical_op)		<	'  '	THEN
			idw_criteria.object.logical_op [li_idx]	=	'AND'
		END IF
	END IF
Next

// Set the count.
iuo_query.Event	ue_set_count_search()				// FDG 05/12/98

Return 1
end event

event ue_tabpage_search_set_period;///////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_search_set_period
//
//	Arguments:	None
//
//	Returns:		Integer
//
//	Description:
//	This event is called by the itemchanged event of  tabpage_source.dw_source. 
//	It will load the period user object with periods for the invoice type selected
//	and set the most current period.  Then set the dates in dw_criteria and disable 
//	those rows.
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????		Created
//
//	FNC	4/14/98 FNC Track 1005. Must convert the fast track invoice into its
//							corresponding main table before loading periods since the 
//							period control table only has periods for the main table, not
//							the fasttrack table.
// FNC 	06/11/98		Access UO_Query variables directly in this NVO rather than in 
//							UO_Query
// AJS   07/31/98		Load period keys by function if passed in.
// FNC	09/08/98		Track 1611. Move global function fx_fasttrack_invoice_type to 
//							appropriate NVO.
///////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

string ls_main_tbl_type

n_cst_revenue lnvo_revenue

//FNC 04/14/98 Start
if left(is_inv_type,1) = 'Q' then
	/* must get main inv_type for the fasttrack inv_type and use that to load the
		period dddw */
	lnvo_revenue = create n_cst_revenue										// FNC 09/08/98
	ls_main_tbl_type = lnvo_revenue.of_get_main_table(is_inv_type)	// FNC 09/08/98
	destroy(lnvo_revenue)														// FNC 09/08/98
//	ls_main_tbl_type = fx_fasttrack_invoice_type(is_inv_type)		// FNC 09/08/98
else
	ls_main_tbl_type = is_inv_type
end if
//FNC 04/14/98 End

//AJS 07/31/98 Load period keys according to function
if trim(is_period_function) > '' then									
	iu_period.uf_load_dddw(is_period_function,ls_main_tbl_type,'AC','TRUE')
else
	iu_period.uf_load_dddw('SUM',ls_main_tbl_type,'AC','TRUE')	//FNC 04/14/98
end if
//ajs 07/31/98 end

//RETURN this.event ue_tabpage_search_set_dates() 
//John_wo 1/7/98- commented out the above line to keep ue_tabpage_search_set_dates
//						from being executed multiple times.  Uf_load_dddw will
//						cause ue_tabpage_search_set_dates to execute.
Return 1
end event

event type integer ue_tabpage_search_set_columns(string as_inv_type, string as_dep_type, character ac_claim_type);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_tabpage_search_set_columns			uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by the itemchanged event of tabpage_source.dw_source
//	and is also triggered by this.ue_tabpage_search_set_authorization.  It will 
// load dw_criteria with columns from the dictionary for the invoice types selected,
// whether it is the data source ('M' for main) or additional data source 
// ('A' for additional data source). Also must clean up the description in expression_one
// (15 characters or till '/').  Cleanup code from stances.w_drilldown_parent.wf_load_dddw().
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			as_inv_type		String				The Invoice type.
//						as_claim_type	String 				The claim type.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date	Description
// ------		----	-----------
//	J.Mattis	12/04/97	Created.
//
// FNC		01/14/98	Third argument must be the dependent table, if it this
//							this event has been triggered because a dependent table
//							has been selected. Otherwise it will be null.
//
//	J.Mattis	12/24/97	Added third argument to ldwc_exp_one.retrieve.
//
//	FDG		02/03/98	Change i to ll_row, li_row to ll_rowcount
//							changed column numbers to names.
//
//	FDG		02/12/98	When inserting a "superpv" row in the DDDW,
//							set the col_name and un-hilite all rows in the
//							DDDW.
//
//	FDG		03/06/98	Track 902.  When inserting superpv, also insert
//							'PV' as the lookup type for this field.
//
//	FDG		05/04/98	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'
//
//	FDG		06/15/98	Track ????.  Don't directly access uo_query attributes.
//
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//							to prevent locking.
//	NLG		10/16/01 Stars 5.0.	TS79 col to col comparison. Load exp2 dddw
//	GaryR		09/12/02	SPR 3070d	Preserve case of description
//	GaryR		09/25/02	SPR 2893d	Text sensitive search in DropDowns
// MikeF		10/15/04 Track 3650d	Replace Dictionary SQL with gnv_dict
//	GaryR		05/19/05	Track 4403d	Do not remove SUPER PROVIDER with dependant and sort
//	GaryR		08/17/05	Track 4403d	Remove SUPER PROVIDER for FastTrack invoices and in drilldown mode
//	GaryR		03/11/08	SPR 4896	Add Super NPI Provider
//	GaryR		06/25/08	SPR 5403	DO not resort the criteria datawindow
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

datawindowchild ldwc_exp_one
Boolean	lb_ft_inv
String	ls_datatype
Long		ll_row
n_cst_stars_rel	lnv_stars_rel

if ac_claim_type = 'M' then    /* reset datawindow */
	idw_criteria.reset()
	idw_criteria.insertrow(0)
end if

idw_criteria.getchild('expression_one',ldwc_exp_one)

ldwc_exp_one.SetTransObject(stars2ca)

ll_row = ldwc_exp_one.retrieve(as_inv_type,as_dep_type)	//01-14-98 FNC

//	Add super provider query if non ancillary, not FastTrack, and not in drilldown mode
lb_ft_inv = lnv_stars_rel.of_get_is_ft_rev( as_inv_type )
if is_source_type <> 'AN' and NOT lb_ft_inv and NOT ib_drilldown then	// FDG 06/15/98
	ll_row	=	ldwc_exp_one.insertrow(0)
	ldwc_exp_one.setitem( ll_row, "elem_tbl_type", as_inv_type )
	ldwc_exp_one.setitem( ll_row, "elem_desc", "SUPER PROVIDER" )
	ldwc_exp_one.setitem( ll_row, "elem_name", "SUPER PROVIDER" )
	ldwc_exp_one.setitem( ll_row, "elem_lookup_type", "PV" )				// FDG 03/06/98
	
	ls_datatype = gnv_dict.event ue_get_elem_data_type(as_inv_type, "ICN")
	ldwc_exp_one.setitem( ll_row, "elem_data_type", ls_datatype )
	
	//	Add Super NPI Provider
	IF gv_npi_cntl > 0 THEN
		ll_row	=	ldwc_exp_one.insertrow(0)
		ldwc_exp_one.setitem( ll_row, "elem_tbl_type", as_inv_type )
		ldwc_exp_one.setitem( ll_row, "elem_desc", "SUPER NPI PROVIDER" )
		ldwc_exp_one.setitem( ll_row, "elem_name", "SUPER NPI PROVIDER" )
		ldwc_exp_one.setitem( ll_row, "elem_lookup_type", "NPI" )				// FDG 03/06/98
		
		ls_datatype = gnv_dict.event ue_get_elem_data_type(as_inv_type, "PROV_NPI")
		ldwc_exp_one.setitem( ll_row, "elem_data_type", ls_datatype )
	END IF
	
	ldwc_exp_one.SelectRow (0, FALSE)
end if

idw_criteria.Dynamic	Event	ue_load_exp2_dddw()

RETURN 1
end event

event type integer ue_tabpage_search_load(integer ai_level_num);//ue_tabpage_search_load(int ai_level_num)
//This event is called by w_query_engine.ue_load_query when a 
//pre-defined query is loaded.  It will take the information out of 
//dw_pdq_tables (per level_num) and load it into this tabpage.  
//It will set the uo_period to blank and for each row in the 
//PDQ_CRITERIA table it will insert a row into dw_criteria 
//and populate the row with the criteria.  If a Super Provider 
//column is part of the query must load the super provider structure 
//with the columns and not allow the trigger of the itemchanged 
//event open the prov choices window.

//***********************************************************************************
//12-29-97 FNC Concatenate table type to column name when criteria is loaded into the			
//					datawindow. The other script is expecting the table type to come before 
//					the column name
//	JTM	01/23/98	Added code to set and remove the level filter for PDQ_CRITERIA table.	
//	FDG	03/09/98	Track 902.  Changed i to ll_row, li_rowcount to ll_rowcount.  
//						Do a "Pos" to find 'SuperPv'.
//	FDG	05/04/98	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'.
//	FDG	05/04/98	Track 1185.  Get the Super Provider data (when applicable) from
//						a retrieved datastore.
//	FDG	05/04/98	Track 1184.  Load the lookup column for each row retrieved.
//	FDG	05/12/98	Track 1223.  'Count' now on the tabpage.
//	FNC	06/11/98	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
// FNC	07/15/98 Track 1284. If idw_pdq_criteria.object.tbl_type is blank then 
//						don't load the '.' in it. Just load ''.
// AJS   08-03-98 Track 1522. Pass period key and function to load dates.
//	FDG	10/14/98	Track 1832.  Remove the 1st line of criteria if multiple lines
//						exist and there's nothing in the 1st line.
//	FDG	10/21/98	Track 1928.  After the dates are filled in, the additional
//						criteria is overlaying these dates.  Load the criteria, then fill
//						in the dates.
//	FDG	10/28/98	Track 1936.  Fix bug from track 1928.  When filling in the dates,
//						do not reset the date criteria.  Setting ib_criteria_date_change
//						will prevent this.
//	FDG	10/30/98	Track 1938.  Fix bug to track 1936.  This script can occur when
//						selecting a PDQ (set ib_criteria_date_change) or when coming
//						from another window (ii_period_key > 0 & don't set
//						ib_criteria_date_change).
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
//	NLG	10-28-99	ts2463c Fraud PDQ. Recompute payment date associated
//						with payment date options ddlb.  This must occur after the criteria 
//						is loaded. ddlb_pd_options has already been loaded
//						from ue_tabpage_source_load.
// FNC	12/30/99	Disable next level for super provider queries.
// FDG	11/09/01 Stars 5.0. Set exp2colname based on whether or not expression_two 
//						contains a selected column instead of a value.
//	GaryR	04/29/02	Track 2552d	Predefined Report (PDR)
//	GaryR	01/23/03	Track 2353d	Encapsulate user criteria with parenthesis
//	GaryR	08/06/04	Track 4049d	Provide drilldown from Subset Summary
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//***********************************************************************************

integer	li_return,			&
			li_idx,				&
			li_rc
long		ll_count,			&
			ll_row,				&
			ll_rowcount,      &
			ll_orig_rowcount
String	ls_col_name,		&
			ls_tbl_type,		&
			ls_query_id,		&
			ls_expression_one
n_ds		lds_spq

iw_parent.wf_SetLevelfilter(ai_level_num,'SEARCH')
	
ll_rowcount = idw_pdq_criteria.rowcount()
if ll_rowcount < 1 then
	//	GaryR	04/29/02	Track 2552d - Begin
	IF iw_parent.of_is_pdr_mode() THEN
		iuo_query.Post SelectTab( ic_report )
		Return 0
	ELSE
		MessageBox('Error','Predefined Query instance datawindow is empty.',StopSign!,Ok!)
		return -1
	END IF
	//	GaryR	04/29/02	Track 2552d - End
end if

ib_query_loaded_flag = False //John_wo 1/12/98	
idw_criteria.Reset() 	//John_wo 1/12/98 - Clear the datawindow before loading.

ll_orig_rowcount = idw_criteria.rowcount()		// FDG 10/21/98 (Moved from above)

//Check for null in last row of date criteria before adding rest of criteria		//AJS 08-03-98
//The following code is necessary because the and is stripped off for normal
//queries in the ue_tabpage_search_set_dates
If ll_orig_rowcount > 0 then
	If Trim(idw_criteria.getitemstring(ll_orig_rowcount,'logical_op')) = '' then
		idw_criteria.setitem(ll_orig_rowcount,'logical_op','AND')
	End if
End if

for ll_row = 1 to ll_rowcount
	ll_orig_rowcount++
	idw_criteria.object.left_paren[ll_orig_rowcount] = idw_pdq_criteria.object.left_paren[ll_row]
	ls_col_name	=	idw_pdq_criteria.object.col_name[ll_row]		// FDG 03/09/98
	
	// Check for Super Provider
	IF Match( ls_col_name, 'SUPER PROVIDER' ) THEN istr_prov_query.do_prov_query = TRUE
		
	// Check for Super NPI Provider
	IF Match( ls_col_name, 'SUPER NPI PROVIDER' ) THEN istr_npi_prov_query.do_prov_query = TRUE
	
	// FNC 07/15/98 Start
	if trim(idw_pdq_criteria.object.tbl_type[ll_row]) = '' then
		//	GaryR	04/29/02	Track 2552d - Begin
		IF iw_parent.of_is_pdr_mode() THEN
			idw_criteria.object.expression_one[ll_orig_rowcount] = idw_pdq_criteria.object.col_name[ll_row]
		ELSE
			idw_criteria.object.expression_one[ll_orig_rowcount] = ''
		END IF
		//	GaryR	04/29/02	Track 2552d - End
	else
		//12-29-97 FNC 
		idw_criteria.object.expression_one[ll_orig_rowcount] = &
			idw_pdq_criteria.object.tbl_type[ll_row] + '.' + idw_pdq_criteria.object.col_name[ll_row]
	end if		
	// FNC 07/15/98 End
	
	idw_criteria.object.relational_op[ll_orig_rowcount] = idw_pdq_criteria.object.rel_op[ll_row]
	idw_criteria.object.expression_two[ll_orig_rowcount] = idw_pdq_criteria.object.col_value[ll_row]
	idw_criteria.object.right_paren[ll_orig_rowcount] = idw_pdq_criteria.object.right_paren[ll_row]
	idw_criteria.object.logical_op[ll_orig_rowcount] = idw_pdq_criteria.object.logic_op[ll_row]
	idw_criteria.object.protect_row_sw[ll_orig_rowcount] = ''

	// load the lookup column
	idw_criteria.Dynamic	Event	ue_set_lookup( ll_orig_rowcount, idw_criteria.object.expression_one[ll_row] )	// FDG 05/04/98

// The insert into logical_op should trigger the itemchanged event 
//	which will insert the next row - also the lookup field will be 
//	populated when the itemchanged event is triggered by 
//	expression_one 

next

//	Set payment date as first row and disabled
IF Upper( iuo_query.of_get_data_type() ) = "BASE" THEN
	ll_rowcount = idw_criteria.RowCount()
	FOR ll_row = 1 TO ll_rowcount
		ls_col_name = idw_criteria.object.expression_one[ll_row]
		IF Match( ls_col_name, "PAYMENT_DATE" ) THEN
			idw_criteria.object.protect_row_sw[ll_row] = "Y"
			IF ll_row <> 1 THEN
				idw_criteria.RowsMove ( ll_row, ll_row, Primary!, idw_criteria, 1, Primary! )
			END IF
			idw_criteria.SetColumn( "expression_two" )
			EXIT
		END IF
	NEXT
END IF

//ajs 07/30/98 - Track #1522. Pass period id.

//	GaryR	04/29/02	Track 2552d
IF NOT iw_parent.of_is_pdr_mode() THEN iuo_query.SelectTab( ic_search )

if ii_period_key > 0 then
	// Period ID was passed from another window.
	//	Get description and place in period
	//	Set description to NONE first, then set to actual period key so that 
	//	the itemchanged event occurs and the dates are loaded into the criteria
	
	li_return = iu_period.uf_scroll_to_row('NONE')
	li_return = iu_period.uf_scroll_to_row_by_period_key(ii_period_key)
	// Oncel loaded, ii_period_key is no longer needed.
	ii_period_key	=	0										// FDG 10/30/98
else
	iuo_query.ib_criteria_date_change	=	TRUE			// FDG 10/28/98
	li_return = iu_period.uf_scroll_to_row('NONE')
end if

iuo_query.ib_criteria_date_change	=	FALSE			// FDG 10/28/98

//ajs 07/30/98 - Track #1522. end.

If li_return = -1 Then
	Return -1
End If

lds_spq	=	CREATE	n_ds
lds_spq.DataObject	=	'd_pdq_columns_spq'
lds_spq.SetTransobject (Stars2ca)

if istr_prov_query.do_prov_query = TRUE then
	iw_parent.Post Event ue_set_menus_super_provider_query(FALSE)	// FNC 12/30/99
	// FDG 05/04/98 begin
	ls_query_id	=	iw_parent.wf_get_query_id()	
	li_idx		=	0										// FDG 03/09/98
	ll_rowcount	=	lds_spq.Retrieve(ls_query_id, "SPQ")
	if ll_rowcount > 0 then											// FNC 04/14/99		
		for ll_row = 1 to ll_rowcount
			ls_tbl_type	=	lds_spq.object.tbl_type[ll_row]	//	FDG 03/09/98
			ls_col_name	=	lds_spq.object.col_name[ll_row]	//	FDG 03/09/98
			li_idx++
			istr_prov_query.prov_fields[li_idx].selected			=	TRUE
			istr_prov_query.prov_fields[li_idx].table_type		=	ls_tbl_type
			istr_prov_query.prov_fields[li_idx].prov_col_name	=	ls_col_name
		next
	end if																// FNC 04/14/99	
	
	iuo_query.of_set_istr_prov_query (istr_prov_query, FALSE)
	// FDG 05/04/98 end
end if

if istr_npi_prov_query.do_prov_query = TRUE then
	iw_parent.Post Event ue_set_menus_super_provider_query(FALSE)	// FNC 12/30/99
	// FDG 05/04/98 begin
	ls_query_id	=	iw_parent.wf_get_query_id()	
	li_idx		=	0										// FDG 03/09/98
	ll_rowcount	=	lds_spq.Retrieve(ls_query_id, "NPQ")
	if ll_rowcount > 0 then											// FNC 04/14/99		
		for ll_row = 1 to ll_rowcount
			ls_tbl_type	=	lds_spq.object.tbl_type[ll_row]	//	FDG 03/09/98
			ls_col_name	=	lds_spq.object.col_name[ll_row]	//	FDG 03/09/98
			li_idx++
			istr_npi_prov_query.prov_fields[li_idx].selected			=	TRUE
			istr_npi_prov_query.prov_fields[li_idx].table_type		=	ls_tbl_type
			istr_npi_prov_query.prov_fields[li_idx].prov_col_name	=	ls_col_name
		next
	end if																// FNC 04/14/99	
	
	iuo_query.of_set_istr_prov_query (istr_npi_prov_query, TRUE)
	// FDG 05/04/98 end
end if

stars2ca.of_commit()											// FNC 04/14/99
DESTROY	lds_spq

// FDG 10/14/98 end
// If multiple lines of criteria exist and there's nothing in the 1st line,
//	remove it.
ll_rowcount	=	idw_criteria.RowCount()

IF	ll_rowcount	>	1			THEN
	ls_expression_one	=	Trim ( idw_criteria.object.expression_one [1] )
	IF	ls_expression_one	=	''			THEN
		idw_criteria.RowsDiscard (1, 1, Primary!)
	END IF
END IF
// FDG 10/14/98 end

// FDG 11/09/01 - Set exp2colname based on whether or not expression_two contains
//	a selected column instead of a value
idw_criteria.Dynamic	Event	ue_set_exp2colname(0)

//	GaryR	04/29/02	Track 2552d - Begin
IF iw_parent.of_is_pdr_mode() THEN
	li_rc = iuo_query.Event ue_tabpage_pdr_load_search( FALSE )
	IF li_rc < 0 THEN	Return -1
	IF li_rc = 0 THEN	iuo_query.Post SelectTab( ic_report )
END IF
//	GaryR	04/29/02	Track 2552d - End

ib_query_loaded_flag = True //John_wo 1/12/98	

//turn off the PDQ_CRITERIA filter
iw_parent.wf_SetLevelfilter(0,'SEARCH')

// change the row status to New!
this.uf_SetStatus(idw_criteria,NotModified!)

// Set the count.
iuo_query.Event	ue_set_count_search()				// FDG 05/12/98

//NLG 10-28-99 Recompute payment date associated with payment date options ddlb
//	GaryR	04/29/02	Track 2552d
IF NOT iw_parent.of_is_pdr_mode() THEN this.event ue_set_payment_date()

// unselect all rows
idw_criteria.SelectRow(0,FALSE)

Return 1
end event

event type integer ue_tabpage_search_code_lookup(string as_value, integer ai_row);////////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_search_code_lookup(string as_value, int ai_row)
//
//	Arguments:
//				as_value (String)
//				ai_row (Integer)
//
//	Returns:	Integer
//
//	Description:
//		This event is called by dw_criteria.rbuttondown when there 
//		is no filter indicator in dw_criteria.expression_two.  
//		It will set the global (gv_code_to_use) with the lookup type 
//		found in the lookup field and open the code lookup window to 
//		allow the user to select a value for that lookup type.  
//		The value selected by the user will be placed into expression_two.  
//		(Code from stances.w_drilldown_parent.dw_1.rbuttondown event)
////////////////////////////////////////////////////////////////////////
//
//	GaryR	04/11/01	Stars 4.7 DataBase Port - Trimming the data
// FDG	11/09/01 Stars 5.0. Set exp2colname based on whether or not expression_two 
//						contains a selected column instead of a value.
//	GaryR	12/27/04	Track 4195d	Look for two asterisk to see if value is a message
//  RickB 9/22/09 LKP.650.5678.001 - Added TRIM to as_value to get rid of default space 
//												from expression_two.
//	RickB 10/1/09 LKP.650.5678.001 (LKP.650.5678.GARY) - replace global variable with parm
//		to turn on multiselect in w_code_lookup if relational operator is "IN" or "NOT IN".
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////

String	ls_rel_op, ls_parm

//	04/11/01	GaryR	Stars 4.7 DataBase Port
gv_code_to_use = Trim( idw_criteria.object.lookup[ai_row] )

if gv_code_to_use = '' then
	MessageBox('Error','Lookup is not available on this field.',&
		+ StopSign!,Ok!)
else
	//	Check the Rel Op and enable multi code select
	ls_rel_op = Trim( idw_criteria.object.relational_op[ai_row] )
	IF ls_rel_op = "IN" OR ls_rel_op = "NOT IN" THEN ls_parm = "1" + as_value
	OpenWithParm( w_code_lookup, ls_parm )
	//	04/11/01	GaryR	Stars 4.7 DataBase Port
	if Trim( gv_code_to_use ) <> '' then
		if trim(as_value) = '' or isnull(as_value) then
			idw_criteria.object.expression_two[ai_row] = gv_code_to_use
		else
			//	If message then overwrite
			IF Left( as_value, 2 ) = "**" THEN
				idw_criteria.object.expression_two[ai_row] = gv_code_to_use
			ELSE
				//	Check Rel Op
				IF ls_rel_op = "BETWEEN" THEN
					idw_criteria.object.expression_two[ai_row] = &
					idw_criteria.object.expression_two[ai_row] + "," + gv_code_to_use
				ELSE
					idw_criteria.object.expression_two[ai_row] = gv_code_to_use
				END IF
			END IF
		end if
		idw_criteria.Dynamic	Event	ue_set_exp2colname (ai_row)		// FDG 11/09/01
	end if
end if

Return 1
end event

event ue_tabpage_search_add_row;////////////////////////////////////////////////////////////////////////
//ue_tabpage_search_add_row()
//This event is called by dw_criteria.itemchanged when logical_op 
//is changed and it is the last row.  It will add a row to end.  
//The code for this taken from stances.w_drilldown_parent.insertrow 
//event.
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	05/12/98	Track 1223.  Set the count after adding a row.
// AJS   08/24/98 TS144 - Report On Enhancements.  Scroll dw to current row
//
////////////////////////////////////////////////////////////////////////


Integer li_last_row

idw_criteria.setredraw(FALSE)
li_last_row = idw_criteria.insertrow(0)	// JTM 1/19/98	- assign li_last_row the inserted row
If li_last_row > 0 then							// JTM 1/19/98	- check for sucessful insert
	idw_criteria.setrow(li_last_row)
	idw_criteria.scrolltorow(li_last_row)	// AJS 08/24/98 - TS144 - Report On Enhancements
End If
idw_criteria.setcolumn(1)
idw_criteria.setredraw(TRUE)

// Set the count.
iuo_query.Event	ue_set_count_search()				// FDG 05/12/98

RETURN 1
end event

event type integer ue_tabpage_search_insert_row();///////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_search_insert_row()
//
//	Description:
//		This event is called by im_search.m_row.m_insert to insert a 
//		row above the selected row.  Only insert a row if the selected 
//		row contains data (don't allow multiple blank rows). 
//		The code for this taken from 
//		stances.w_drilldown_parent.pb_insert.clicked event.
//
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
// J.Mattis	1/19/98	Added logic to verify LAST row if none is current, 
//							and to prevent null object reference.
//
//	FDG		05/12/98	Track 1223.  Set the count after adding a row.
//	FDG		07/10/98	Track 1356.  When an error occurs, set redraw back to
//							TRUE.
//	GaryR		04/24/02	Track 2552d	Predefined Report (PDR)
//	GaryR		01/23/03	Track 2353d	Encapsulate user criteria with parenthesis
//	GaryR		12/05/05	Track 4402d	Moved RowCount out of IF statement so that AND
//							gets properly added to newly inserted row after locked row
//	Katie		02/20/08	SPR 5304.  Added logic to getitemnumber for space_warned column of
//					idw_criteria.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(Hourglass!)

string ls_data, ls_logic
long ll_row, ll_col_count, ll_inserted_row, ll_rowcount
integer i
Boolean lb_data_exists

idw_criteria.setredraw(FALSE)
ll_row = idw_criteria.getrow()

// added JTM 1/19/98	4.0 - to verify LAST row if none is current
If ll_Row < 1 Then
	ll_row = idw_Criteria.RowCount()
End If
// JTM 1/19/97	- end of new code

ll_col_count = integer(idw_criteria.&
	describe("datawindow.column.count"))

/* check for blank row */
for i = 1 to ll_col_count
	If ll_Row > 0 and i < 12 Then		// JTM 1/19/98 - to prevent null object reference
		ls_data = idw_criteria.GetItemString(ll_row,i)
	ElseIF ll_Row > 0 Then
		ls_data = String(idw_criteria.GetItemnumber(ll_row,i ))
	Else
		ls_Data = ' '			// JTM 1/19/98 - to set lb_data_exists so insert
									//						will happen when no rows are present	
	End If
	If IsNull(ls_data) or ls_data = '' Then
	Else
		lb_data_exists = TRUE
		exit
	end if
next

if not lb_data_exists then
	MessageBox('Error - Tabpage Search',&
		'Cannot insert another row above a blank row.',StopSign!,Ok!)
	idw_criteria.setredraw(TRUE)			// FDG 07/10/98
	return -1
end if

//Lahu S 4/30/02 Track 2552d begin
DataWindowChild		ldwc
idw_criteria.getchild('expression_one', ldwc)
//Lahu S 4/30/02 Track 2552d end

//	GaryR	04/24/02	Track 2552d - Begin
//	Do not allow insertion of row
//	above a retrieval argument
IF ll_row > 0 THEN
	IF idw_criteria.GetItemString( ll_row, "pdr_protect" ) = "A" THEN
		//Lahu S 4/30/02 Track 2552d begin
		if ldwc.rowcount() > 0 then
			This.event ue_tabpage_search_add_row()
			Return 1
		end if
		//Lahu S 4/30/02 Track 2552d end

		MessageBox( "ERROR", "Cannot insert another row above a required row", StopSign!, Ok! )
		idw_criteria.SetRedraw( TRUE )
		Return -1
	END IF
END IF
//	GaryR	04/24/02	Track 2552d - End

/* insert AND into new row */
IF idw_criteria.GetItemString( ll_row, "protect_row_sw" ) = "Y" &
AND Match( idw_criteria.GetItemString( ll_row, "expression_one" ), "PAYMENT_DATE" ) THEN
	ll_inserted_row = idw_criteria.insertrow(ll_row + 1)
ELSE
	ll_inserted_row = idw_criteria.insertrow(ll_row)
END IF

ll_rowcount = idw_criteria.RowCount()
If ll_rowcount > ll_inserted_row Then
	idw_criteria.object.logical_op[ll_inserted_row] = 'AND'
End If	

///* insert AND into row above the new row */
//if idw_criteria.object.logical_op[ll_row] = '' then
//	idw_criteria.object.logical_op[ll_row] = 'AND'
//end if
If ll_inserted_row > 1 Then
	ls_logic = trim(idw_criteria.&
		getitemstring((ll_inserted_row - 1),'logical_op') )
	If isnull(ls_logic) or ls_logic = '' then
		idw_criteria.setitem((ll_inserted_row - 1),&
			'logical_op','AND')
	End IF
End If

// Set the count.
iuo_query.Event	ue_set_count_search()				// FDG 05/12/98

idw_criteria.setredraw(TRUE)

Return 1
end event

event type integer ue_tabpage_search_delete_row();//ue_tabpage_search_delete_row()
//This event is called by im_search.m_row.m_delete to delete 
//selected row. The code for this taken from 
//stances.w_drilldown_parent.pb_delete.clicked event.
////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	04/02/98	Track 1003.  Tell the window that a row in this d/w
//						has been deleted.
//
//	FDG	05/12/98	Track 1223.  Set the count after adding a row.
//
// FNC	07/21/98	Track 1397. Reset the logical operator in the last remaining
//										row if the last row was just deleted.
//	FDG	10/14/98	Track 1832.  If deleting the only row, insert a blank
//						row.  Also, see if deleting a super provider query row
//						and if so, reset it data.
//	NLG	11/15/99	Fraud PDQ changes.  If delete payment_date row,
//						set Payment Date Options ddlb to ' '.
//	GaryR	04/24/02	Track 2552d	Predefined Report (PDR)
//	GaryR	01/23/03	Track 2353d	Encapsulate user criteria with parenthesis
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
////////////////////////////////////////////////////////////////////////

long ll_row,	ll_rowcount
String	ls_expression_one, ls_protect_row
sx_prov_query_structure		lstr_prov_query

idw_criteria.setredraw(FALSE)
ll_row = idw_criteria.getrow()

If ll_row > 0 Then
Else
	MessageBox('Error - Tabpage Search',&
		'No row is currently selected for delete.',StopSign!,Ok!)

	idw_criteria.setredraw(TRUE)
	Return -1
End If

// FDG 10/14/98 begin
ls_expression_one		=	idw_criteria.object.expression_one [ll_row]
ls_protect_row			=	idw_criteria.object.protect_row_sw [ll_row]

IF	Mid (ls_expression_one,4)	=	'SUPER PROVIDER'		THEN
	istr_prov_query	=	lstr_prov_query
	iuo_query.of_reset_super_provider( 1 )
END IF
//	FDG 10/14/98 end

//	Reset SUPER NPI PROVIDER
IF	Mid (ls_expression_one,4)	=	'SUPER NPI PROVIDER'		THEN
	istr_npi_prov_query	=	lstr_prov_query
	iuo_query.of_reset_super_provider( 2 )
END IF

//	Do not allow deletion of required Payment Date row.
IF match(ls_expression_one,'PAYMENT_DATE') AND Trim( ls_protect_row ) = "Y" THEN
	MessageBox( "ERROR", "Cannot delete required row", StopSign!, Ok! )
	idw_criteria.SetRedraw( TRUE )
	Return -1
END IF

//	GaryR	04/24/02	Track 2552d - Begin
//	Do not delete required criteria fields or retrieval arguments in PDR
IF Trim( idw_criteria.GetItemString( ll_row, "pdr_protect" ) ) <> "" THEN
	MessageBox( "ERROR", "Cannot delete required row", StopSign!, Ok! )
	idw_criteria.SetRedraw( TRUE )
	Return -1
END IF
//	GaryR	04/24/02	Track 2552d - End

idw_criteria.deleterow(ll_row)

// FDG 10/14/98 begin
// always make sure there is at least on line of criteria
ll_rowcount	=	idw_criteria.RowCount()

IF	ll_rowcount		=	0		THEN
	ll_rowcount	=	idw_criteria.InsertRow(0)
	idw_criteria.ScrollToRow (ll_rowcount)
END IF
// FDG 10/14/98 end

// Set the count.
iuo_query.Event	ue_set_count_search()				// FDG 05/12/98

// 07/21/98 FNC Start
ll_row = idw_criteria.getrow()
If ll_row = idw_criteria.rowcount() 		&
AND ll_row	>	0									then
	idw_criteria.Object.logical_op[ll_row] = ''
end if
// 07/21/98 End

idw_criteria.setrow(ll_row)								
idw_criteria.setredraw(TRUE)


// FDG 04/02/98 begin
IF	IsValid (iw_parent)		THEN
	iw_parent.wf_SetRowDelete (TRUE)
END IF
//	FDG 04/02/98 end

Return 1
end event

event ue_tabpage_search_ml_filter_check;////////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_search_ml_filter_check
//
//	Arguments:
//				as_filter_id (String)
//				ai_row (Integer)
//				as_type (String
//
//	Returns:	Integer
//
//	Description:
//		This event is called by tabpage_search.dw_search.itemchanged 
//		if the user puts a filter in expression_two or it filters from 
//		previous levels had been put into expression_two for 
//		that row (as_type = 'CHECK').  If a filter is put into 
//		expression_two (as_type = 'NEW') then this event must check to 
//		see if the filter used was created in a previous level.  If this 
//		is true the user must be forced down the subset path.  Cannot 
//		create the report since the filter used has not actually be created.  
//		Give the user a message and disable the Report On and 
//		View Report tabpages.  Return -1 if user does not want to 
//		use the filter else return 0 (either the user wants to use it 
//		or no match).   If the user selects a filter created in a level 
//		after this level, must not allow them to use it since it will not 
//		be created until after this step is performed. 
//
////////////////////////////////////////////////////////////////////////
//	History:
//
//	???	????????	Created
//
//	FDG	02/12/98	1. Event ue_get_filter_info was passing the wrong # of
//						parms andit was being triggered on the wrong object.
//						2. Changed i to li_i, j to li_j
//
//	FDG	03/03/98	Track 880.  After enabling/disabling tabs, see if the
//						Next button is to be enabled.
//
// FNC	05/20/98 Track 1107. Don't disable tabs if new filter is used
//						in criteria. If user doesn't change filter id they
//						will receive an error when they try to create the
//						report.
//						Add code so that this event loops through the criteria 
//						datawindow. Original changes before modification is 
//						commented out below. 
//						In addition changed the check that compared level numbers
//						so that now can't use filters created in greater than OR 
//						equal to levels. It used to just check for greater than.
//
// FNC	05/21/98	Track 1262. If called from subset check if the filter is 
//						already exists or if it is created in a previous level.
//
// FNC	06/11/98	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	GaryR	04/20/01	Stars 4.7 DataBase Port - Case Sensitivity
////////////////////////////////////////////////////////////////////////
integer	li_rc,	&
			li_level_num,	&
			li_upper,	&
			li_rowcount,	&
			li_i,			&
			li_exp2_row
string	ls_exp2,	&
			ls_filter_id
sx_filter_info lstr_filter_info[] /* defined in ts144 - Filter Windows */
datawindowchild ldwc_exp2

li_rc = iw_parent.event ue_get_filter_info('ALL', lstr_filter_info)
li_level_num = iw_parent.event ue_get_active_level_num()
li_upper = upperbound(lstr_filter_info)

idw_criteria.GetChild ('expression_two',ldwc_exp2)		// FNC 05/20/98
li_rowcount		=	idw_criteria.RowCount()

for li_i = 1 to li_upper
	for li_exp2_row = 1 to li_rowcount
		ls_exp2 =trim(idw_criteria.object.expression_two[li_exp2_row])
		if left(ls_exp2,1) = '@' then
			ls_filter_id = Upper( mid(ls_exp2,2) )	//	GaryR	04/20/01	Stars 4.7 DataBase Port
			if ls_filter_id = lstr_filter_info[li_i].filter_id then
				if lstr_filter_info[li_i].level_num >= li_level_num then
					MessageBox('Error','A filter is being used in the level in which it is '  + &
					'being created or in a level prior to the level in which is is created. ',StopSign!,Ok!)
					iuo_query.Event	ue_selecttab(0)							
					return -1
				elseif as_come_from = 'SUBSET' then				// FNC 05/21/98
					return 0												// FNC 05/21/98
				end if								
				MessageBox('Filter','A filter specified in this report can only be used if creating a subset.' )
				iuo_query.Event	ue_selecttab(0)			//	FDG 03/03/98
				ii_ml_filter_rows[upperbound(ii_ml_filter_rows) &
					+ 1] = li_exp2_row
					 return -1
			end if
		end if
	Next
Next

return 0

end event

event type integer ue_tabpage_search_save(integer ai_level, string as_query_id);//ue_tabpage_search_save(int ai_level, string as_query_id)
//This event is called by w_query_engine.ue_save_query() to load 
//the information from the tabpage to the pdq_criteria datawindow.  
//If Super Provider Query is selected then must save the 
//provider columns to the pdq_columns table.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis 01/20/98	Added Mid() to parse tbl_type from col_name to prevent
//							tbl_type error (ie. C2.C2.DATE_PAID) in criteria 
//							(search tabpage).
//	J.Mattis	01/21/98	Added guard against inserting into an update datawindows to
//							prevent SQL insert duplicate key errors. Also, added assignment
//							to prevent null DB error for PDQ_CRITERIA.LOGIC_OP. 
//	FDG		03/09/98	Track 902.  When inserting for 'SuperPv', include the
//							row # in the setting of the columns for idw_pdq_columns.
//	FDG		05/04/98	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'
// FNC		06/11/98	Access UO_Query variables directly in this NVO rather than in 
//							UO_Query
//	GaryR		04/29/02	Track 2552d Predefined Report (PDR)
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

long ll_pdq_row, ll_crit_count, ll_inserted_row, ll_prov_count
long ll_inserted_row_pdq_col
integer i, j
Boolean lb_Newquery
String	ls_empty, ls_find		//	GaryR	04/29/02	Track 2552d

iw_parent.wf_SetLevelfilter(ai_level,'SEARCH')
gnv_sql.of_TrimData( ls_empty )				//	GaryR	04/29/02	Track 2552d

ll_pdq_row = idw_pdq_criteria.rowcount()

ll_crit_count = idw_criteria.rowcount()			//06/11/98 FNC

//Messagebox("PDQ Criteria",idw_pdq_criteria.describe("datawindow.data"))

for i = 1 to ll_crit_count
	If i > ll_pdq_row Then 												//JTM - 1/21/98
		ll_inserted_row = idw_pdq_criteria.insertrow(0)
	End If
	idw_pdq_criteria.object.query_id[i] = as_query_id
	idw_pdq_criteria.object.level_num[i] = ai_level
	idw_pdq_criteria.object.seq_num[i] = i
	idw_pdq_criteria.object.left_paren[i] = idw_criteria.object.left_paren[i]
	
	//	GaryR	04/29/02	Track 2552d - Begin	
	IF iw_parent.of_is_pdr_mode() THEN
		//	Check for Retrieval Argument
		IF Trim( idw_criteria.object.pdr_protect[i] ) = "A" THEN
			//	PDR Retrieval Arguments do not have table names
			idw_pdq_criteria.object.tbl_type[i] = ls_empty
			idw_pdq_criteria.object.col_name[i] = idw_criteria.object.expression_one[i]
		ELSE
			idw_pdq_criteria.object.tbl_type[i] = left(idw_criteria.object.expression_one[i],2)
			idw_pdq_criteria.object.col_name[i] = Mid(idw_criteria.object.expression_one[i],4)
		END IF
	ELSE
		idw_pdq_criteria.object.tbl_type[i] = &
			left(idw_criteria.object.expression_one[i],2)
		idw_pdq_criteria.object.col_name[i] = &
				Mid(idw_criteria.object.expression_one[i],4)		// JTM - 1/20/98 Added Mid() to
																				//	parse tbl_type from col_name.
	END IF
	//	GaryR	04/29/02	Track 2552d - End
	
		/* if SPQ must put prov columns into column table */
	if mid(idw_criteria.object.expression_one[i],4) = 'SUPER PROVIDER' then		// FDG 05/04/98
		istr_prov_query	=	iuo_query.of_get_istr_prov_query()						// FDG 05/04/98
		ll_prov_count = upperbound(istr_prov_query.prov_fields)
		for j = 1 to ll_prov_count
			if istr_prov_query.prov_fields[j].selected then
				//MUST SEARCH FOR SPQ row before doing an insert!
				ls_find = "tbl_type = '" + istr_prov_query.prov_fields[j].table_type + &
					"' AND col_name = '" + istr_prov_query.prov_fields[j].prov_col_name + "'"
				ll_inserted_row_pdq_col = idw_pdq_columns.Find(ls_find,1,idw_pdq_columns.RowCount())
				If ll_inserted_row_pdq_col < 1 Then
					ll_inserted_row_pdq_col = idw_pdq_columns.insertrow(0)
					idw_pdq_columns.SetRow (ll_inserted_row_pdq_col)			// FDG 03/09/98
				End If
				idw_pdq_columns.object.query_id[ll_inserted_row_pdq_col] = &
					as_query_id
				idw_pdq_columns.object.level_num [ll_inserted_row_pdq_col] = &
					ai_level
				idw_pdq_columns.object.seq_num [ll_inserted_row_pdq_col] = ll_inserted_row_pdq_col
				idw_pdq_columns.object.tbl_type [ll_inserted_row_pdq_col] = &
					istr_prov_query.prov_fields[j].table_type
				idw_pdq_columns.object.col_name [ll_inserted_row_pdq_col] = &
					istr_prov_query.prov_fields[j].prov_col_name
				idw_pdq_columns.object.col_type [ll_inserted_row_pdq_col] = 'SPQ'
			end if
		next
	end if
	
	/* if NPI SPQ must put prov columns into column table */
	if mid(idw_criteria.object.expression_one[i],4) = 'SUPER NPI PROVIDER' then
		istr_npi_prov_query	=	iuo_query.of_get_istr_npi_prov_query()
		ll_prov_count = upperbound(istr_npi_prov_query.prov_fields)
		for j = 1 to ll_prov_count
			if istr_npi_prov_query.prov_fields[j].selected then
				//MUST SEARCH FOR SPQ row before doing an insert!
				ls_find = "tbl_type = '" + istr_npi_prov_query.prov_fields[j].table_type + &
					"' AND col_name = '" + istr_npi_prov_query.prov_fields[j].prov_col_name + "'"
				ll_inserted_row_pdq_col = idw_pdq_columns.Find(ls_find,1,idw_pdq_columns.RowCount())
				If ll_inserted_row_pdq_col < 1 Then
					ll_inserted_row_pdq_col = idw_pdq_columns.insertrow(0)
					idw_pdq_columns.SetRow (ll_inserted_row_pdq_col)			// FDG 03/09/98
				End If
				idw_pdq_columns.object.query_id[ll_inserted_row_pdq_col] = &
					as_query_id
				idw_pdq_columns.object.level_num [ll_inserted_row_pdq_col] = &
					ai_level
				idw_pdq_columns.object.seq_num [ll_inserted_row_pdq_col] = ll_inserted_row_pdq_col
				idw_pdq_columns.object.tbl_type [ll_inserted_row_pdq_col] = &
					istr_npi_prov_query.prov_fields[j].table_type
				idw_pdq_columns.object.col_name [ll_inserted_row_pdq_col] = &
					istr_npi_prov_query.prov_fields[j].prov_col_name
				idw_pdq_columns.object.col_type [ll_inserted_row_pdq_col] = 'NPQ'
			end if
		next
	end if
	
	idw_pdq_criteria.object.rel_op[i] = idw_criteria.object.relational_op[i]
	idw_pdq_criteria.object.col_value[i] = idw_criteria.object.expression_two[i]
	idw_pdq_criteria.object.right_paren[i] = idw_criteria.object.right_paren[i]
	
	//check if this is the last row	JTM - 1/21/98 
	IF i = ll_crit_count	THEN
		// pad logical op with spaces since the last portion of WHERE will not
		//	have a logical operator.
		idw_pdq_criteria.object.logic_op[i] = ' '
	ELSE
		idw_pdq_criteria.object.logic_op[i] = &
		idw_criteria.object.logical_op[i]	
	END IF
	// end of JTM - 1/21/98 add
	//Messagebox("PDQ Criteria "+String(i),idw_pdq_criteria.describe("datawindow.data"))
next

//MUST check if any PDQ rows need to be deleted!
If ll_pdq_row > ll_crit_count Then
	Long ll_Start
	ll_Start = ll_pdq_row - (ll_pdq_row - ll_crit_count) + 1
	FOR i = ll_Start TO ll_pdq_row
		idw_pdq_criteria.DeleteRow(i)
	NEXT
End If

iw_parent.wf_SetLevelfilter(0,'SEARCH')

Return 1
end event

event type integer ue_tabpage_search_clear();//ue_tabpage_search_clear()
//This event is called by im_search.m_clear to clear out the tabpage.
//Will clear out dw_criteria and set uo_period to the default (max date).
////////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	11/06/98	Track 1832.  Clear out super provider data.
//	NLG	10/26/99	Track 2463c. Fraud PDQ changes - Clear out payment date
//						options dropdown listbox.
//	LahuS	01/14/02	Track 2552d Added label 'search_clear' for PDR/PDCR
//	GaryR	04/24/02	Track 2552d	Predefined Report (PDR)
//	GaryR	11/19/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR	09/19/05	Track 4514d	Reset the criteria count
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
////////////////////////////////////////////////////////////////////////

Long		ll_rowcount
datawindowchild ldwc_period

// Lahu S 1/14/02
IF iw_parent.of_is_pdr_mode() THEN GOTO search_clear

idw_criteria.setredraw(FALSE)

idw_criteria.reset()

// FDG 11/06/98 begin
sx_prov_query_structure		lstr_prov_query
istr_prov_query	=	lstr_prov_query
istr_npi_prov_query	=	lstr_prov_query

iuo_query.of_reset_super_provider( 0 )
// FDG 11/06/98 end

iu_period.getchild('period_key',ldwc_period)

//iu_period.uf_scroll_to_max_period(ldwc_period)
iu_period.uf_scroll_to_row("NONE")

this.event ue_tabpage_search_set_dates()

//NLG 10-26-99 Start**
iuo_query.of_set_pd_opt_desc('')
iuo_query.of_set_run_frequency(0)
//NLG 		   Stop **

// Set the count.
iuo_query.Event	ue_set_count_search()
idw_criteria.setredraw(TRUE)

Return 1

// Lahu S 1/14/02	Begin  Track 2552d
search_clear:
idw_criteria.setredraw(FALSE)
idw_criteria.reset()
iuo_query.ib_pdr_inv_changed = TRUE
iuo_query.Event ue_tabpage_pdr_load_search( TRUE )	//	GaryR	04/24/02	Track 2552d
iuo_query.of_set_pd_opt_desc('')
// Set the count.
iuo_query.Event	ue_set_count_search()
idw_criteria.setredraw(TRUE)

Return 1

// Lahu S 1/14/02	End
end event

event type integer ue_tabpage_search_get_prov_choices(boolean ab_npi);///////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_search_get_prov_choices
//
//	Arguments:	Boolean	ab_npi (NPI Super Provider?)
//
//	Returns:		Integer
//
//	Description:
//		This event is called by tabpage_search.dw_criteria.itemchanged 
//		event when Super Provider Query is selected.  
//		This will get the allowed provider columns (STARS_WIN_PARM) 
//		and open w_prov_choices to allow the user to select 
//		which provider columns will be included in the query.  
//		The Super Provider Query information is stored in 
//		istr_prov_query. The code for this was taken from 
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created
//
//	FDG	03/06/98	Track 902.  When returning from w_prov_choices,
//						store the results in iuo_query.istr_prov_query.
//						Also, reinitialize istr_prov_query in case it
//						was previously set.
//
//	FDG	03/19/98	Track 944.  Destroy any created objects.
//
// FNC	06/11/98	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//
//	FDG	08/19/98	Track 1501.  Once istr_prov_query is set, store it in
//						uo_query.
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL 
//						to prevent locking.
//	FDG	11/08/01	Stars 5.0.	For each Super Provider column selected, remove
//						the column from the expression_two drop-down.  Also,
//						filter out expression_two based on the data type of the
//						1st selected field.
//	FDG	12/06/01	Track 2497, 2561.  Prevent memory leaks.
// MikeF	10/15/04 Track 3650d	Replace Dictionary SQL with gnv_dict
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
///////////////////////////////////////////////////////////////////////

Long		ll_row,		&
			ll_rowcount
Integer	li_upper,			&
			li_idx,				&
			li_selected
String	ls_data_type,		&
			ls_column,			&
			ls_tbl_type,		&
			ls_where,			&
			ls_cntl_id[]
n_ds lds_provs

sx_prov_query_structure		lstr_prov_query

IF ab_npi THEN
	ls_cntl_id = {'NPI_PROVIDER_FIELD'}
ELSE
	ls_cntl_id = {'PROVIDER_ENTERABLE_FIELD','PROVIDER_FIELD'}
END IF

lds_provs = Create n_ds
lds_provs.DataObject = 'd_tabpage_search_get_prov_choices'
lds_provs.SetTransObject(Stars2ca)
ll_rowcount = lds_provs.Retrieve(is_inv_type, ls_cntl_id)		// FNC 04/14/99
stars2ca.of_commit()

for ll_row = 1 to ll_rowcount
	lstr_prov_query.prov_fields[ll_row].table_type = is_inv_type
	lstr_prov_query.prov_fields[ll_row].prov_col_name = lds_provs.object.col_name[ll_row]
next

openwithparm(w_prov_choices,lstr_prov_query)

//	FDG 03/06/98 begin
lstr_prov_query	=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

IF	lstr_prov_query.do_prov_query	=	FALSE		THEN
	// Cancelled out of w_prov_choices.  
	//	Reset SuperPv on the	criteria d/w.	
	ll_row	=	idw_criteria.GetRow()
	idw_criteria.object.expression_one [ll_row]	=	''
	// FDG 11/08/01 - Remove all entries from expression_two drop-down
	idw_criteria.Dynamic	Event	ue_filter_exp2 ("", "")	
END IF
// FDG 03/06/98 end	

// FDG 11/08/01 begin
// Loop through each selected column.  For the 1st selected column, filter
//	the expression_two drop-down based on the column's data type.  For all
//	selected columns, remove the corresponding expression_two drop-down entry.
li_upper	=	UpperBound (lstr_prov_query.prov_fields[])

FOR	li_idx	=	1	TO	li_upper
	IF	lstr_prov_query.prov_fields[li_idx].selected	=	TRUE	THEN
		ls_column		=	lstr_prov_query.prov_fields[li_idx].prov_col_name
		ls_tbl_type		=	lstr_prov_query.prov_fields[li_idx].table_type
		li_selected	++
		IF	li_selected	=	1		THEN
			// 1st selected column.  Get its data type and filter the expression_two	DDDW.
			ls_data_type = gnv_dict.event ue_get_elem_data_type( ls_tbl_type, ls_column)
			
			IF ls_data_type = gnv_dict.ics_error THEN
				MessageBox ("Application Error", "Error reading dictionary in u_nvo_search."	+	&
								"ue_tabpage_search_get_prov_choices.  Dictionary Where = "			+	&
								"elem_type IN ('CL','CC') & elem_tbl_type = "	+	Upper(ls_tbl_type)			+	&
								" & elem_name = "	+	Upper(ls_column)	+	".")
				Destroy	lds_provs						// FDG 12/06/01
				Return	-1
			END IF
			idw_criteria.Dynamic	Event	ue_filter_exp2 (ls_data_type, ls_tbl_type +	'.' + ls_column)
		END IF
		// Remove the column from the expression_two DDDW to prevent this Super Provider
		//	column from being compared against itself
		idw_criteria.Dynamic	Event	ue_remove_exp2_column (ls_tbl_type + '.' + ls_column)
	END IF
NEXT

// FDG 11/08/01 end

IF ab_npi THEN
	gv_code_to_use = 'NPI'
	istr_npi_prov_query = lstr_prov_query
	iuo_query.of_set_istr_prov_query (istr_npi_prov_query, ab_npi)
ELSE
	gv_code_to_use = 'PV'
	istr_prov_query = lstr_prov_query
	iuo_query.of_set_istr_prov_query (istr_prov_query, ab_npi)
END IF

Destroy	lds_provs			// FDG 03/19/98 - Track 944

Return 1
end event

event type integer ue_tabpage_search_set_period_visibility();/////////////////////////////////////////////////////////////////////////////
// Event/Function												Object				
//	--------------												------				
//	ue_tabpage_search_set_period_visibility			uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//uo_tabpage_search_set_period_visibility()
//This event is called by the itemchanged event of 
//tabpage_source.dw_source.  It set the uo_period to be visible for 
//claim queries and invisible for patient or provider queries.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		12/04/97		Created.
//	FDG			05/27/98		Track 1091.  Make the heading visible/invisible.
// FNC			06/11/98		Access UO_Query variables directly in this NVO rather 
//									than in UO_Query
//	FDG			06/15/98		Track ????.  Don't directly access uo_query attributes
// FNC			10/24/01		Track 3683 Starcare. Make the data ddlb's invisible if
//									source of query is a subset.
/////////////////////////////////////////////////////////////////////////////
//john_wo 1/7/98 - placed the correct code in this event
SetPointer(HourGlass!)

If is_source_type = 'AN'  or is_data_type = 'SUBSET' then	//FNC 10/24/01
	iuo_query.of_set_period_visibility (FALSE)				// FDG 06/15/98
	//iu_period.visible = false
	//iuo_query.tabpage_search.st_period.visible = false		// FDG 05/27/98
Else
	iuo_query.of_set_period_visibility (TRUE)				// FDG 06/15/98
	//iu_period.visible = true
	//iuo_query.tabpage_search.st_period.visible = true		// FDG 05/27/98
End If

Return 1
end event

event type integer ue_tabpage_search_edit_report_dates();///////////////////////////////////////////////////////////////////////
//	Script:	uo_tabpage_search_edit_report_dates()
//
//	Arguments:	None
//
//	Returns:		Integer - 1=success
//
//	Description:
//		This event is called when the view report tab is clicked.  This
//		script will determine if a from date exists without a paid date.
//		If this condition occurs, then a paid date will be automatically  
//		added to the 1st line of criteria.  Paid date is needed to
//		determine which month(s) in table ros_directory to report on.
//
//	NOTE:
// 	If the from date has a "<" in the relational operator, then
// 	the paid date criteria canot be added.
//	
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	FDG	04/17/98	Track 1083.  Created.
//	FDG	04/22/98	Track 1106.  Do not perform the paid date edits on
//						ancillary invoice types.
//	FDG	04/22/98	Track 1111.  Set the focus on dw_criteria when an
//						error occurs.
//	FDG	05/12/98	Track 1223.  Set the count after adding a row.
//	FDG	06/15/98	Track ????.  Don't directly access uo_query attributes.
//	
///////////////////////////////////////////////////////////////////////

String	ls_exp1,				&
			ls_find,				&
			ls_col,				&
			ls_rel_op,			&
			ls_from_date,		&
			ls_paid_date,		&
			ls_source
			
Integer	li_exp1_count,		&
			li_idx,				&
			li_rowcount,		&
			li_row,				&
			li_pay_row,			&
			li_from_row,		&
			li_new_row,			&
			li_rc,				&
			li_pos
			
Boolean	lb_ancillary_inv_type
			
datawindowchild ldwc_exp1

idw_criteria.GetChild ('expression_one',ldwc_exp1)

li_row	=	idw_source.GetRow()

IF	li_row	<	1		THEN
	MessageBox ('Error', 'u_nvo_search.ue_tabpage_search_edit_report_dates error.  No rows in idw_source')
	Return -1
END IF

ls_source	=	Upper ( idw_source.object.rb_source [li_row] )

IF	ls_source	<>	'BASE'		THEN
	// Subset data type - no edits
	Return 1
END IF

//	FDG 04/22/98 begin
// ancillary data types do not have paid date edits.
lb_ancillary_inv_type	=	iuo_query.of_get_ancillary_inv_type()

IF	lb_ancillary_inv_type	=	TRUE		THEN
	Return 1
END IF
// FDG 04/22/98 end

li_exp1_count	=	ldwc_exp1.RowCount()
li_rowcount		=	idw_criteria.RowCount()

// Find the 'From date' and 'Paid date' rows

FOR li_idx = 1 TO li_rowcount

	ls_exp1 =trim(idw_criteria.object.expression_one[li_idx])
	
	IF mid(ls_exp1,4) =	'PAYMENT_DATE'		THEN
		li_pay_row		=	li_idx
	END IF
	
	IF mid(ls_exp1,4) =	'FROM_DATE'			THEN
		li_from_row		=	li_idx
		ls_from_date	=	idw_criteria.object.expression_two [li_from_row]
		// Get the date to the left of the ','
		li_pos			=	Pos (ls_from_date, ',')
		IF	li_pos		>	0				THEN
			// Multiple from dates entered.
			ls_paid_date	=	Left (ls_from_date, li_pos - 1)
		ELSE
			// Onlt one from date entered.
			ls_paid_date	=	ls_from_date
		END IF
	END IF
	
NEXT

IF	li_pay_row		=	0			&
AND li_from_row	=	0			THEN
	MessageBox ("Error", "Please enter a 'paid date' or 'from date'")
	iuo_query.Event	ue_selecttab(IC_SEARCH)					// FDG 06/15/98
	Return -1
END IF

IF li_pay_row		=	0			&
AND li_from_row	>	0			THEN
	// Found a 'From Date' but no 'Paid Date'.  Determine if its okay
	// to create a new payment date row of criteria.
	
	ls_rel_op	=	idw_criteria.object.relational_op [li_from_row]
	
	CHOOSE CASE Upper ( Trim(ls_rel_op) )
		CASE '=', '><', '>', '>=', 'BETWEEN'
			// Insert a row at the top and format 'Paid Date' data
			li_rc	=	MessageBox ("Warning", "No 'paid date' was entered but a 'paid date' " + &
										"will automatically be created.  Do you want to continue " + &
										"the query?", Question!, OKCancel!)
			IF	li_rc	=	2			THEN
				iuo_query.Event	ue_selecttab(IC_SEARCH)			// FDG 06/15/98
				Return -1
			END IF
			li_new_row	=	idw_criteria.InsertRow (1)
			ls_find		=	"mid(col_name,4) = 'PAYMENT_DATE'"
			li_row		=	ldwc_exp1.Find (ls_find, 1, li_exp1_count)
			IF	li_row	<	1			THEN
				MessageBox ('Error', 'The payment date was not found in the drop-down ' + &
								'in u_nvo_search.ue_tabpage_search_edit_report_dates.  ' + &
								'Find = ' + ls_find)
				iuo_query.Event	ue_selecttab(IC_SEARCH)			// FDG 06/15/98
				Return -1
			END IF
			ls_col	=	ldwc_exp1.GetItemString (li_row, 'col_name')
			idw_criteria.object.expression_one	[li_new_row]	=	ls_col	
			idw_criteria.object.relational_op	[li_new_row]	= '>='
			idw_criteria.object.expression_two	[li_new_row]	=	ls_paid_date
			idw_criteria.object.left_paren		[li_new_row]	=	'('
			idw_criteria.object.right_paren		[li_new_row]	=	')'
			idw_criteria.object.logical_op		[li_new_row]	=	'AND'
			iuo_query.Event	ue_set_count_search()				// FDG 05/12/98
		CASE ELSE
			MessageBox ("Error", "Please either correct the relational operator of the 'from date'" + &
							" or enter a 'paid date'")
			iuo_query.Event	ue_selecttab(IC_SEARCH)			// FDG 06/15/98
			Return -1

	END CHOOSE

END IF

Return 1

end event

event ue_count();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	u_nvo_search				ue_Count
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by im_search.m_count to get the count produced by the query.  
// The count will be loaded into st_count.text.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
// Date		Author	Description
// ------	--------	-----------
//	01/06/98	J.Mattis	Created.
// 03/05/98	FNC		Track 867.
//							Accept criteria datawindow before performing count
//	03/06/98	FDG		Track 920. If an error occurred in ue_create_sql, do
//							not continue.
//	03/19/98	FDG		Track 944.  Always destroy all created objects.
//	04/17/98	FDG		Track 1083. Determine if payment date criteria
//							will be automatically created.  This will occur
//							when a from date was entered, but no paid date.
//	05/12/98	FDG		Track 1223.  Set the count on the search & view tabs.
//	05/20/98	FNC		Track 1107. Prior to performing the count verify that
//							any filters in criteria exists.
//	05/27/98	FDG		Track 1286.  Move script from uo_query.
// 06/11/98	FNC		1.Access UO_Query variables directly in this NVO rather than in 
//							UO_Query
//							2. Call uf_set_nvo_create_sql to create and call 
//							U_NVO_Create_SQL rather than doing it directly in the script
//	06/15/98	FDG		Track ????.  Don't directly access uo_query attributes.
//							u_nvo_query will now invoke ue_create_sql.
//	06/18/98	FDG		Track yyyy.  Set ib_count in this script.
// 07/28/98	FNC		Track 1502. Set count to 0 if receive a bad return code
//							any where in the script and return before count is set.
//	10/13/98	NLG		Track #1746.  Add microhelp.
//	03/27/01	FDG		Stars 4.7.	Display the SQL if in debug mode.
//	11/20/02	GaryR		SPR 3376d	Rest ib_subsetting variable when counting
// 03/02/04 MikeF		SPR 3909d 	Issue with Getting counts w/ Views + Addtl table
// 03/04/04 MikeF		SPR 3921d 	Using a LOJ with a UNION ALL View gives DB error
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long 			ll_sql_count,		&
				ll_idx, 					&
				ll_total_count,	&
				ll_count
String 		ls_sql[],			&
				ls_Select,			&
				ls_tbl_type[]
Integer		li_rc, 				&
				li_rows

u_nvo_count lu_nvo_count
u_nvo_create_sql lu_nvo_create_sql
n_cst_string ln_cst_string

//03-05-98 FNC Start
if iw_parent.event ue_accepttext(iw_parent.control, FALSE) < 0 then
	messagebox('ERROR','Error processing criteria. Cannot compute count')
	ll_total_count = 0															// FNC 07/28/98
	iuo_query.of_set_count_text ( String(ll_total_count) )			// FNC 07/28/98
	return
end if
//03-05-98 FNC End

//	FDG 04/17/98 - Determine if a payment date is to be created.
li_rc	=	This.Event	ue_tabpage_search_edit_report_dates()

IF	li_rc	<	0		THEN
	ll_total_count = 0															// FNC 07/28/98
	iuo_query.of_set_count_text ( String(ll_total_count) )			// FNC 07/28/98
	Return
END IF

// FNC 05/20/98 Start
li_rc	=	This.Event	ue_tabpage_search_ml_filter_check('COUNT')

IF	li_rc	<	0		THEN
	ll_total_count = 0															// FNC 07/28/98
	iuo_query.of_set_count_text ( String(ll_total_count) )			// FNC 07/28/98	
	Return
END IF
// FNC 05/20/98 End

lu_nvo_count = CREATE u_nvo_count

//replace the select column(s) with count(*) (see u_nvo_create_sql::ue_create_sql).
ib_count = TRUE 														// FDG 06/18/98	

Setmicrohelp(w_main,'Retrieving count ...')

ib_subsetting = FALSE					//	GaryR	11/20/02	SPR 3376d

this.uf_set_nvo_create_sql(TRUE)

// Create SQL statement
li_rc = This.event ue_create_sql()  // creates istr_sql_statement 	// FDG 06/15/98
if li_rc < 0 then 
	ll_total_count = 0															// FNC 07/28/98
	iuo_query.of_set_count_text ( String(ll_total_count) )			// FNC 07/28/98
	return 
End If

// Set boolean in u_nvo_count
lu_nvo_count.uf_set_ds_count(	iuo_nvo_create_sql.uf_get_use_ds_counts() )

this.uf_set_nvo_create_sql(FALSE)

// FNC 06/11/98 End

this.event ue_string_sql_statement(ls_sql[])

ll_sql_count = upperbound(ls_sql)

// FDG 03/27/01 begin
IF	gc_debug_mode		THEN
	f_debug_box ('Debug', ' ')
END IF
// FDG 03/27/01 end

for ll_idx = 1 to ll_sql_count
	// FDG 03/27/01 begin
	IF	gc_debug_mode		THEN
		f_debug_box ('Debug', 'Count SQL = '	+	ls_sql[ll_idx])
	END IF
	// FDG 03/27/01 end
	
	ll_count = lu_nvo_count.uf_get_count(ls_sql[ll_idx])
	IF ll_count > 0 THEN
		ll_total_count = ll_total_count + ll_count
	ELSE
		CONTINUE
	END IF
	
next

//replace count(*) with the select column(s) (see u_nvo_create_sql::ue_create_sql).
ib_count = FALSE														// FDG 06/18/98	

iuo_query.of_set_count_text ( String(ll_total_count) )

// FDG 03/29/01 - Commit the queries
Stars1ca.of_commit()
Stars2ca.of_commit()

Setmicrohelp(w_main,'Ready')

DESTROY lu_nvo_create_sql 
DESTROY lu_nvo_count

end event

event ue_criteria_save();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	u_nvo_search				ue_CriteriaSave
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by im_view.m_save.m_criteriasave or im_search.m_save.m_criteriasave
// to load the criteria into the ANAL_CRIT tables.  They will be stored in the tables with
// a win_type of 'CRA'.  This code is to replace two places in current code that saves
// criteria (Detail Analysis and Claim Report).  Currently it writes it two different tables,
// the Detail Analysis path as described above and the Claim Report writes to the 
// CRITERIA_USED tables with by_type of 'CRC'.  This is being removed from the system.  
// The majority of this code is taken from w_parent_detail_analysis.cb_save1.clicked.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	JTM	01/08/98		Created.
// FNC   02/26/98		Track 867.
//							Accept criteria datawindow before creating subset
//	FDG	05/27/98		Track 1286.  Move script from uo_query
// FNC	06/11/98		Access UO_Query variables directly in this NVO rather than in 
//							UO_Query
//	GaryR	06/15/01		Stars 4.7 Make sure saved SQL is DBMS independent.
//	GaryR	04/26/02	Track 2552d	Predefined Report (PDR)
//	GaryR	10/21/04	Track 4089d	Add third tier to PDR report selection
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long		ll_count, ll_idx
String 	lv_crit_lines[50,4], lv_sorts[25,4], lv_group[25,2], ls_tbl_type[1], ls_blank_array[]
String	ls_crit_exp2		//	GaryR	06/15/01		Stars 4.7
sx_criteria lsx_criteria[]

//lsx_Criteria[1] = istr_criteria
//	GaryR	04/26/02	Track 2552d
//lsx_Criteria[1] = iuo_query.of_get_istr_criteria()			// FDG 05/27/98

//02-28-98 FNC Start
if iw_parent.event ue_accepttext(iw_parent.control, FALSE) < 0 then
	messagebox('ERROR','Error processing criteria. Cannot create subset')
	return
end if
//02-28-98 FNC End

/* load criteria structure with criteria for current level */
this.event ue_format_where_criteria("CRITERIA",TRUE,ls_blank_array,lsx_Criteria)

//	GaryR	04/26/02	Track 2552d	Predefined Report (PDR)
IF NOT iw_parent.of_is_pdr_mode() THEN this.event ue_format_where_criteria_add_clauses("CRITERIA",ls_blank_array,lsx_Criteria)

/* load info into two dimensional array for global function */
ll_count = upperbound(lsx_Criteria)

if ll_count = 0 then 
	messageBox("Error","No criteria exists.",StopSign!)
	return
end if

for ll_idx = 1 to ll_count
	//	GaryR	06/15/01		Stars 4.7 - Begin
	ls_crit_exp2 = lsx_Criteria[ll_idx].orig_expression
	IF IsNull( ls_crit_exp2 ) OR Trim( ls_crit_exp2 ) = "" THEN
		ls_crit_exp2 = lsx_Criteria[ll_idx].expression_two
	END IF
	//	GaryR	06/15/01		Stars 4.7 - End
	
	lv_crit_lines[ll_idx,1] = lsx_Criteria[ll_idx].expression_one
	lv_crit_lines[ll_idx,2] = lsx_Criteria[ll_idx].rel_operator
	lv_crit_lines[ll_idx,3] = ls_crit_exp2		//	GaryR	06/15/01		Stars 4.7
	//	GaryR	04/26/02	Track 2552d - Begin
	IF iw_parent.of_is_pdr_mode() THEN
		IF Trim( lsx_Criteria[ll_idx].pdr_protect ) = "A" THEN
			lv_crit_lines[ll_idx,4] = lsx_Criteria[ll_idx].data_type
		ELSE
			lv_crit_lines[ll_idx,4] = lsx_Criteria[ll_idx].logical_operator
		END IF
	ELSE
		lv_crit_lines[ll_idx,4] = lsx_Criteria[ll_idx].logical_operator
	END IF
	//	GaryR	04/26/02	Track 2552d - End
next

//	GaryR	04/26/02	Track 2552d - Begin
IF iw_parent.of_is_pdr_mode() THEN
	IF idw_pdr.RowCount() > 0 THEN ls_tbl_type[1] = Left( idw_pdr.object.pdr_cat[1], 2 )
ELSE
	IF idw_source.RowCount() > 0 THEN ls_tbl_type[1] = Left( idw_source.object.data_source[1], 2 )
END IF
//	GaryR	04/26/02	Track 2552d - End

save_anal_crit("ANL",ls_tbl_type,'',0,lv_crit_lines,lv_sorts,lv_group)
end event

event ue_format_where_criteria;call super::ue_format_where_criteria;//*********************************************************************************
// Event Name:	u_nvo_search.ue_Format_Where_Criteria
//
//	Arguments:	String	as_type
//					Boolean	ab_add_payment_date
//					String	as_where[]  (by reference)
//					Sx_Criteria	astr_criteria[]  (by reference)
//
// Returns:		None
//
//	Description:
//	This is an overloaded event that will either 
//	format and create a WHERE clause or
//	format criteria and place it into the criteria 
//	structure.  This is determined by
//	the argument, as_type which can contain 'WHERE' 
//	or 'CRITERIA'.  If contains 
//	'WHERE' will format and load a WHERE clause into 
//	as_where.  If contains 'CRITERIA' 
//	it will load asx_criteria[].
//
//	If ab_add_payment_date is TRUE the where statement 
//	will include PAYMENT_DATE. When  
//	as_type = 'CRITERIA', ab_add_payment_date will 
//	always be TRUE.  
//	This event will be used to create the where 
//	clause, get criteria 
//	for criteria save and subset criteria.
//	Will loop thru, formatting each row into a clause.  
//	If the column is "SUPER PROVIDER" and as_type = "CRITERIA" must load 
//	the provider columns selected by the user (stored in isx_prov_query ) 
//	into the criteria using "OR" as logical operator.  
//	This does not get included in the WHERE clause since the SQL used 
//	to produce a Super Provider Query creates a separate SQL statement 
//	for each Provider column and strings them together using a UNION.  
//	This will be done during the execution of the SQL.
// 
//	This will also perform the edit checks.  This code is taken 
//	from w_drilldown_parent.wf_format_sql() which calls global functions 
//	format_where, format_where_d and format_where_n.  Will have to 
//	change wf_format_sql(), but not the global functions.  One thing 
//	added is when a filter is used in the criteria and if building the 
//	where for a subset, the filter id must be put into the subset 
//	structure (isx_subsetting_info).  
//
//	Also added are the edit checks for LIKE and Filters with Super 
//	Provider Queries.  Neither are allowed currently in the system.  
//	(Currently in Detail Analysis it allows you to enter a filter, 
//	it just does not resolve it and uses it as a literal ie 
//	prov_id = @provtest)
//	Returns 0 if successful, else returns -1.  
//	Note:  all checks for blanks should also check for NULLs 
//
//*********************************************************************************
// 12-10-97 FNC	Created
//	12-29-97 FNC	Changed column name in find to col_name instead of col_desc
//	01-30-98	FDG	1. Move the create of lds_dictionary to the beginning of the
//							script.
//						2. Changed j to li_j, k to li_k
//						3. Fixed a bug where if payment_date is removed from the last
//							where clause, 'AND' must be removed from the prior where
//							clause.
//	01/30/98	JTM	Added logic to correct array boundry error.
// 02/12/98 FNC	Add check to make sure that 1 row of criteria has been entered prior
//						to determining if exp2 for the first row has been entered.
//	02/26/98	FDG	When editing to see if criteria was entered, check 
//						for IsNull of expression_two.
//	03/02/98	FDG	Track 876.  Select the tab via an event
//	03/06/98	FDG	Track 920.  Get data from lds_dictionary before calling
//						fx_error_check_fields_for_dw.  For SuperPv, append the table_type
//						from istr_prov_query.
// 03/11/98	FNC	Test the find command to make sure that a row was located.
//	03/17/98	FDG	Track 871.  When deleting from dw_criteria, subtract 1 from
//						li_rowcount
//	03/19/98	FDG	Track 920.  Don't return -1 if no as_where[] occurences.
// 04/08/98 FNC	Track 993.	Remove blank line from criteria datawindow. When the 
//						search by tab is displayed a blank line is always added to the 
//						datawindow. This must be removed if the user does not enter anything
//						into it.
// 04/09/98 HRB	Track 987.  1.Add edit check not allowing multiple values for '='
//                2.formatting date values - the code taken from
//						w_drilldown_parent.wf_format_sql() is incorrect when it uses
//                format_where_d for date values, should use format_where instead.
//	04/10/98	FDG	Track 987.  When an error occurs, setfocus to the row/column
//						in error.
//	04/16/98	FDG	Track 971.  See if the filter exists by triggering 
//						w_query_engine.ue_check_filter_data_type instead of
//						fx_check_filter_datatype.  This new script will first check
//						the filter structure before reading filter_cntl.
//	05/04/98	FDG	Track 1177.  Change 'SuperPv' to 'SUPER PROVIDER'
//	05/07/98	FDG	Track 1209.  If a filter is used, then the relational operator
//						must be '='.
//	05/20/98	FDG	Track 1244.  Perform an accepttext on dw_criteria because
//						w_query_engine's ue_accepttext does not handle the control
//						array for a drilldown uo_query.
//	05/22/98	FDG	Track 1272.  If you have a 'Like'/'Not Like' without a '%',
//						automatically add the '%' in expression_two.
//	05/27/98	FDG	Track 1286.  Move script from uo_query.
// 06/11/98 FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	06/15/98	FDG	Track ????.  Script moved to u_nvo_create_sql.
//*********************************************************************************
 			
Integer 		li_rc

IF	IsValid (iuo_nvo_create_sql)		THEN
	li_rc		=	iuo_nvo_create_sql.Event	ue_format_where_criteria ( as_type,			&
																				ab_add_payment_date,		&
																				as_where,					&
																				astr_criteria )
ELSE
	This.uf_set_nvo_create_sql (TRUE)
	li_rc		=	iuo_nvo_create_sql.Event	ue_format_where_criteria ( as_type,			&
																				ab_add_payment_date,		&
																				as_where,					&
																				astr_criteria )
	This.uf_set_nvo_create_sql (FALSE)
END IF

//	If an error occurred, return to the proper location
This.Event	ue_check_status (li_rc)

Return	li_rc

end event

event type integer ue_format_where_criteria_add_clauses(string as_type, ref string as_where[], ref sx_criteria astr_criteria[]);//*********************************************************************************
// Event Name:	u_nvo_search.UE_Format_Where_Criteria_Add_Clauses
//
//	Arguments:	String	as_type
//					String	as_where[]   (by reference)
//					Sx_Criteria	astr_criteria[]	(by reference)
//
// Returns:		Integer
//
//	Description:
//	This event is called to either
//	1. Create a where clause and add to as_where OR
//	2. Create criteria and add to astr_criteria 
//	depending on as_type (either 'WHERE' or 'CRITERIA'). 
//
//	If dependent join or drilldown will add clauses for dependent join 
//	and/or temp table join.
//
//	To determine dependent join, use tabpage_source (data source and additional data 
//	source) then get join fields from STARS_REL using key1 and key2 .  
//
//	To determine if drilldown using ib_drilldown. Join field is_drilldown_join_fields.
//	If Fasttrack will add clauses for invoice_type.  
// 
//	Fasttrack is found in tabpage_source (data source like 'Q%') and must get inv_type 
//	from the code table.
//
//*********************************************************************************
// 12-10-97 FNC	Created
//	01-28-98	FNC	Move inv type to an array before retrieving hidden dictionary.
//						Use global function to retrieve dictionary datawindow.
//						Add dependent join only if not drilldown
//	01-30-98	FDG	1. Call of_check_status() after each embedded SQL
//						2. Change variable i to li_idx
//						3. When accessing index li_rowcount - 1, make sure that
//							li_rowcount is > 1.
// 04/15/98 FNC	Track 962.  Join dependent and main table with an outer join if 
//						the where or criteria does not contain any columns from the 
//						dependent table
//	05/27/98	FDG	Track 1286.  Move script from uo_query.
//	05/27/98	FDG	Track 1091.  For drilldown, as_where gets the drilldown
//						invoice type, not the original invoice type.
// 06/11/98 FNC	Access UO_Query variables directly in this NVO rather than in 
//						UO_Query
//	06/15/98	FDG	Track ????.  Script moved to u_nvo_create_sql.
//*********************************************************************************
 			
Integer 		li_rc

IF	IsValid (iuo_nvo_create_sql)		THEN
	li_rc		=	iuo_nvo_create_sql.Event	ue_format_where_criteria_add_clauses ( as_type,			&
																				as_where,					&
																				astr_criteria )
ELSE
	This.uf_set_nvo_create_sql (TRUE)
	li_rc		=	iuo_nvo_create_sql.Event	ue_format_where_criteria_add_clauses ( as_type,			&
																				as_where,					&
																				astr_criteria )
	This.uf_set_nvo_create_sql (FALSE)
END IF

//	If an error occurred, return to the proper location
This.Event	ue_check_status (li_rc)

Return	li_rc

end event

event ue_string_sql_statement(ref string as_sql_statement[]);/////////////////////////////////////////////////////////////////////////////
//	u_nvo_search.UE_String_SQL_Statement
//
//	This event will be called by ue_tabpage_view_create_report() and subsetting 
//	process to string together the SQL.  This is a simple process unless Super Provider 
//	Query is selected.  If Super Prov then must use the SQL in istr_sql_statement to 
//	create one SQL statement using unions.  Will take the SQL, add one of the provider 
//	columns to the where clause and union that statement with the next using the next 
//	provider column, and so forth.  If no Super Prov then just string the SQL together.
//	Finally return an array of SQL statements.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	???	????????	Created.
//
// FDG	03/09/98	Track 920.  For SuperPv, 
//
//	JTM  	02/13/98	Added code to prevent source construct from occurring multiple
//						times.
//	JTM	02/20/97	Removed source construct code because errors could occur if
//						method code impacted and object which had not yet been constructed.
//	FDG	05/27/98	Track 1286.  Move script from uo_query.
//						
// FNC	09/10/98	Track 1683. Prefix super provider where statement with table 
//						type stored in sql structure. It was moved there in U_NVO_Create_Sql.
//						ue_create_sql
// GaryR	11/22/00	3035c System Error while doing Q1 - Fasttrack query
//	GaryR	11/08/01	3549c	Using Super Provider field in Query Engine causes SQL error
//	FDG	03/05/02	Track 2857d.  Column-to-column comparison with Super Provider
//						must account for 'MC' in expression two.
//	FDG	03/06/02	Track 2852d.  When combining Break with totals with 'Super Provider'
//						the last where clause must contain the order by.
//	03/11/08	GaryR	SPR 4896	Add Super NPI Provider
//
/////////////////////////////////////////////////////////////////////////////


integer				li_sql_count,		&
						li_idx1,						&
						li_idx2,						&
						li_where_count
						
string				ls_sql_statement[],			&
						ls_where									// GaryR	11/22/00	3035c
						
sx_sql_statement_container	lstr_container
sx_sql_statement				lstr_sql_statement[]

// Get instance variables from uo_query
lstr_container			=	iuo_query.of_get_istr_sql_statement()	// FDG 05/27/98
lstr_sql_statement	=	lstr_container.lsx_sql_statement[]		// FDG 05/27/98

/* first string each SQL together (max length of string = 60,000) */
li_sql_count = upperbound(lstr_sql_statement)

for li_idx1 = 1 to li_sql_count
	ls_sql_statement[li_idx1] = upper(lstr_sql_statement[li_idx1].select_clause) + " " + &
	upper(lstr_sql_statement[li_idx1].from_clause) + " "
	li_where_count = upperbound(lstr_sql_statement[li_idx1].where_clause)
	for li_idx2 = 1 to li_where_count
		// GaryR	11/22/00	3035c Begin
		ls_where = upper(lstr_sql_statement[li_idx1].where_clause[li_idx2])
		IF IsNull( ls_where ) THEN ls_where = ""
		ls_sql_statement[li_idx1] = ls_sql_statement[li_idx1] + " " + ls_where	
		// GaryR	11/22/00	3035c End
	next
next

as_sql_statement = ls_sql_statement
end event

event ue_subsetting;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	u_nvo_search					ue_Subsetting
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by w_query_engine.ue_create_sql() 
//	to load an array of structures 
// (isx_subsetting_info[]) to pass to Subset Options.  
//	This structure contains sql statements,
// criteria and filter information.   This 
//	event returns isx_subsetting_info.
// First it sets a flag to tell ue_create_sql() 
//	that the sql is to be used to create a 
// subset, not a report.  Also if this flag is set, 
//	part of the structure will be loaded in 
// the event as it creates the sql.  The subset sql 
//	contains a select clause to select all 
// columns and instead of creating a s step for each 
//	table number, must create one step with
// an '@' symbol instead of a table number (the 
//	middleware piece will resolve the '@').
// Then call the create sql event to create the 
//	sql and then call the event to string the sql
// statement together.  Then must load the criteria 
//	into the structure for Supset Options to 
// load into the criteria tables. If the user selected 
//	to have filters created from this 
// subset, the filter create part of the structure 
//	will be filled at the time they select 
// them.  If the user uses filters in the criteria, 
//	the filter ids must be put into the 
// filter copy array part of the struct during the 
// create of the where clause (ue_format_where_criteria).
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/08/98	Created.
// FNC		02/19/98	1.Reset ib_subsetting back to false so that other
//							reports can be created and uo_query wont think it is
//							subsetting.
//							2. Track 841. Set the sx_subsetting_info structure
//							that is passed to this event as an argument equal to the 
//							structure that was filled in in ue_create_sql.
// FNC		03/04/98	Track 890.
//							Check return code from create sql. Cancel if bad return
//	FDG		03/19/98	Track 890.
//							03/04/98 change did not cancel out of script.
// FNC		05/21/98	Track 1262. If called from subset check if the filter is 
//							already exists or if it is created in a previous level.
//	FDG		05/27/98	Track 1286.  Move script from uo_query.
// FNC		06/11/98	Call uf_set_nvo_create_sql to create and call 
//							U_NVO_Create_SQL rather than doing it directly in the script
//	FDG		06/15/98	Track ????.  u_nvo_query will now invoke ue_create_sql.
//	FDG		06/18/98	Track 1377.  No data was placed in asx_subsetting_info.subset_step
//							because the upperbound was not performed on ls_sql.
//	FDG		12/09/98	Track 1973.  Reset 'Break with totals' data before creating
//							a subset.  When done, reset it back to its original value.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String 	ls_sql[],				&
			ls_blank_array[],		&
			ls_subset_id,			&
			ls_source_subset_id,	&
			ls_data_type,			&
			ls_subset_type
Long 		ll_num_sql, 			&
			ll_num_steps,			&
			li_idx
integer	li_rc

sx_subsetting_info	lstr_subsetting_info

sx_break_info			lstr_break_info,		&
							lstr_prev_break_info

//u_nvo_create_sql lu_nvo_create_sql				// FNC 06/11/98

ls_data_type	=	iuo_query.of_get_data_type()	// FDG 05/28/98

// FNC 05/21/98 Start
li_rc	=	This.Event	ue_tabpage_search_ml_filter_check('SUBSET')
IF	li_rc	<	0		THEN
	Return -1
END IF
// FNC 05/21/98 End

// FDG 12/09/98 begin
// Save the current break with totals data and reset it just for creating a subset.
lstr_prev_break_info	=	istr_break_info
istr_break_info		=	lstr_break_info
iuo_query.uf_set_sxbreakinfo (lstr_break_info)
// FDG 12/09/98 end

//lu_nvo_create_sql = CREATE u_nvo_create_sql	// FNC 06/11/98

ib_subsetting = TRUE										// FDG 06/19/98
//iuo_query.of_set_ib_subsetting (TRUE)			// FDG 05/27/98		// FDG 06/19/98

// FNC 06/11/98 Start
this.uf_set_nvo_create_sql(TRUE)
li_rc = This.event ue_create_sql()  // creates istr_sql_statement 	// FDG 06/15/98
if li_rc <> 0 then
	istr_break_info	=	lstr_prev_break_info			// FDG 12/09/98
	iuo_query.uf_set_sxbreakinfo (istr_break_info)	// FDG 12/09/98
	return -1
End If

this.uf_set_nvo_create_sql(FALSE)

// ue_create_sql returns istr_subsetting_info
asx_subsetting_info	=	istr_subsetting_info			// FDG 06/19/98

// FNC 06/11/98 End

//lu_nvo_create_sql.uf_Set_uo_query(iuo_query)
//lu_nvo_create_sql.uf_Set_Report_dw_Selected(iuo_query.tabpage_report.dw_selected)
//lu_nvo_create_sql.uf_Set_Search_dw_Criteria(iuo_query.tabpage_search.dw_criteria)
//lu_nvo_create_sql.uf_Set_Source_dw_source(iuo_query.tabpage_source.dw_source)
//
//li_rc = lu_nvo_create_sql.event ue_create_sql()
//
//DESTROY lu_nvo_create_sql

//	FDG 03/19/98 begin
IF	li_rc	<	0		THEN
	ib_subsetting	=	FALSE									// FDG 06/19/98
	//iuo_query.of_set_ib_subsetting (FALSE)			// FDG 05/27/98
	istr_break_info	=	lstr_prev_break_info			// FDG 12/09/98
	iuo_query.uf_set_sxbreakinfo (istr_break_info)	// FDG 12/09/98
	Return li_rc
END IF
// FDG 03/19/98 end

this.event ue_string_sql_statement(ls_sql[])
ll_num_sql = upperbound(ls_sql)

///asx_subsetting_info	=	iuo_query.of_get_istr_subsetting_info()	// FDG 05/27/98

ll_num_steps = upperbound(asx_subsetting_info.subset_step)		// FDG 06/18/98
//ll_num_steps = upperbound(ls_sql)											// FDG 06/18/98

for li_idx = 1 to ll_num_steps
	asx_subsetting_info.subset_step[li_idx].sql_statement = ls_sql[li_idx]
next

/* if sorce is subset, put subset id into structure */
if ls_data_type = "SUBSET" then
	ls_source_subset_id	=	iuo_query.of_get_source_subset_id()		// FDG 05/27/98
	asx_subsetting_info.source_subset_id = ls_source_subset_id
end if

/* load criteria structure with criteria for current level */
li_rc	= this.event ue_format_where_criteria	("CRITERIA",		&
															TRUE, 				&
															ls_blank_array,	&
															asx_subsetting_info.criteria)

//	FDG 03/19/98 begin
IF	li_rc	<	0			THEN
	ib_subsetting	=	FALSE									// FDG 06/19/98
	//iuo_query.of_set_ib_subsetting (FALSE)			// FDG 05/27/98
	istr_break_info	=	lstr_prev_break_info			// FDG 12/09/98
	iuo_query.uf_set_sxbreakinfo (istr_break_info)	// FDG 12/09/98
	Return li_rc
END IF
// FDG 03/19/98 end

li_rc = this.event ue_format_where_criteria_add_clauses	("CRITERIA",	 &
																			ls_blank_array, &
																			asx_subsetting_info.criteria)

//	FDG 03/19/98 begin
IF	li_rc	<	0			THEN
	ib_subsetting	=	FALSE									// FDG 06/19/98
	//iuo_query.of_set_ib_subsetting (FALSE)			// FDG 05/27/98
	istr_break_info	=	lstr_prev_break_info			// FDG 12/09/98
	iuo_query.uf_set_sxbreakinfo (istr_break_info)	// FDG 12/09/98
	Return li_rc
END IF
// FDG 03/19/98 end

ib_subsetting	=	FALSE									// FDG 06/19/98
//iuo_query.of_set_ib_subsetting (FALSE)			// FDG 05/27/98		// FDG 06/19/98

// Reset the break with totals to the values at the beginning of the script
istr_break_info	=	lstr_prev_break_info			// FDG 12/09/98
iuo_query.uf_set_sxbreakinfo (istr_break_info)	// FDG 12/09/98

return 1

end event

event ue_subsetting_set_filter_create;///////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_subsetting_set_filter_create		u_nvo_search
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_open_filter_window() to take the filters 
// selected by the user a put them into the filter_create structure in the subsetting 
// structure. (sx_filter_info is defined in ts144 - Filter Windows)
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument					Datatype					Description
//		---------	--------					--------					-----------
//		Value			asx_all_filter_info	sx_all_filter_info	The filter info.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/07/98		Created.
//
//	FDG			03/18/98		Track 937.  Set the filter_id also.
//									Change names to conform to standards.
// FNC			07/29/98 	Track 1530. Clear out filter create structure. Null 
//									argument is passed when filter is to be cleared.
//	FNC			09/08/98		Track 1570. Save last filter id before clearing out
//									structure. When user double clicks this id will be
//									filled in.
//	Archana		01/24/01		Track ????. Pass flter info to uo_query so that it can
//									be accessed for ML subsets/queries when the user
//									goes to the next level from the view report tab 
//									(not just the search criteria tab)
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_count, li_idx, li_filter_create_count
sx_filter_create lsx_filter_clear[]


li_count = upperbound(asx_all_filter_info.filters[])

if li_count = 0 then															// FNC 07/29/98 
	li_idx = upperbound(istr_subsetting_info.filter_create)		// FNC 09/08/98
	if li_idx > 0 then//NLG 09/16/98
		gv_active_filter = istr_subsetting_info.filter_create[li_idx].filter_id // FNC 09/08/98
	end if
	istr_subsetting_info.filter_create = lsx_filter_clear			// FNC 07/29/98 
else																				// FNC 07/29/98 					
	For li_idx = 1 to li_count
		istr_subsetting_info.filter_create[li_idx].tbl_type = asx_all_filter_info.filters[li_idx].tbl_type
		istr_subsetting_info.filter_create[li_idx].col_name = asx_all_filter_info.filters[li_idx].col_name
		istr_subsetting_info.filter_create[li_idx].filter_id = asx_all_filter_info.filters[li_idx].filter_id // FDG 03/18/98
	
	Next
end if																			 // FNC 07/29/98 

iuo_query.of_set_istr_subsetting_info(istr_subsetting_info)		// Archana 01/24/01

RETURN 1

end event

event ue_tabpage_search_no_period_dates();///////////////////////////////////////////////////////////////////////
//	Script:	uo_tabpage_search_no_period_dates()
//
//	Description:
//		This event is triggered from ue_tabpage_search_set_dates when
//		the period is 'NONE'.
//		This event will determine if the 'FROM_DATE' and/or 'PAYMENT_DATE'
//		is being carried over from the previous level in a multi-level
//		query.  If so, carry these dates. 
//
///////////////////////////////////////////////////////////////////////
//	History
//
//	09/02/98	FDG	Track 1560.  Created
//	10/23/02	GaryR	Track 3354d	Prevent duplicate paid dates in ML
//	01/23/03	GaryR	Track 2353d	Encapsulate user criteria with parenthesis
//	04/09/03	GaryR	Track 3513d	Fix paid date logic in new level
//	03/11/04	GaryR	Track 3945d	Search for the main table's PAYMENT_DATE
//	03/12/04	GaryR	Track 3950d	If in drilldown mode, get the first PAYMENT_DATE
///////////////////////////////////////////////////////////////////////


String	ls_exp1,					&
			ls_find,					&
			ls_prev_find,			&
			ls_col,					&
			ls_logical_op
Integer	li_exp1_count,			&
			li_idx,					&
			li_pay_row,				&
			li_from_row,			&
			li_new_row,				&
			li_prev_row,			&
			li_prev_rowcount,		&
			li_messagebox_return

Long		ll_rowcount,			&
			ll_row

datawindowchild	ldwc_exp1,	&
						ldwc_exp2
Datetime	ld_from_date,			&
			ld_thru,					&
			ld_payment_from,		&
			ld_payment_thru

// Determine if any criteria exists from the prior level

IF	IsValid (idw_prev_criteria)		THEN
	li_prev_rowcount	=	idw_prev_criteria.RowCount()
ELSE
	li_prev_rowcount	=	0
END IF

IF	li_prev_rowcount	=	0		THEN
	// No dates exist from the prior level - get out.
	ib_return = FALSE	//	10/23/02	GaryR	SPR 3354d
	Return
END IF

ib_return = TRUE	//	10/23/02	GaryR	SPR 3354d

idw_criteria.getchild('expression_one',ldwc_exp1)
li_exp1_count = ldwc_exp1.rowcount()
ll_rowcount = idw_criteria.rowcount()

For li_idx = 1 to ll_rowcount
	ls_exp1 =trim(idw_criteria.object.expression_one[li_idx])
	if mid(ls_exp1,4) = 'PAYMENT_DATE' then
		li_pay_row = li_idx
	end if
	if mid(ls_exp1,4) = 'FROM_DATE' then
		li_from_row = li_idx
	end if
next

if li_pay_row > 0 or li_from_row > 0 then
	// clear out current rows 
	if li_pay_row > 0 then
		idw_criteria.deleterow(li_pay_row)
		If li_pay_row < li_from_row Then
			li_from_row = li_from_row - 1
		End If
	end if
	if li_from_row > 0 then
		idw_criteria.deleterow(li_from_row)
	end if
	ll_rowcount = idw_criteria.rowcount()
end if

//IF	iuo_query.of_get_ancillary_inv_type()	=	TRUE		THEN
//	Return 1
//END IF
// FDG 08/19/98 end

// Get the 'PAYMENT_DATE' from the prior level of a 'ML' query.

IF iuo_query.of_get_ib_drilldown() THEN
	ls_find = "mid(col_name,4) = 'PAYMENT_DATE'"
ELSE
	ls_find = "col_name = '" + is_inv_type + ".PAYMENT_DATE'"
END IF

ll_row = ldwc_exp1.find(ls_find,1,li_exp1_count)

// For a multi-level query, find "payment_date" from the previous
//	level (by search idw_prev_criteria).  If found use these
//	dates
// dw_criteria exists on the prior level with criteria
ls_prev_find	=	"mid(expression_one,4) = 'PAYMENT_DATE'"
li_prev_row		=	idw_prev_criteria.Find (ls_prev_find, 1, li_prev_rowcount)

If ll_row			>	0		&
And li_prev_row	>	0		Then
	// FDG 08/05/98 begin
	//If the first row is empty, overwrite the first row.
	If IsNull(ls_exp1) and ll_rowcount = 1 Then	
		li_new_row = 1
	Else
		// FDG 02/11/98 - Insert at the beginning
		li_new_row = idw_criteria.insertrow(1)		
	End If
	ls_col = ldwc_exp1.getitemstring(ll_row,'col_name')
	idw_criteria.setitem(li_new_row,'expression_one',ls_col)
	idw_criteria.object.expression_two [li_new_row]	=		&
						idw_prev_criteria.object.expression_two [li_prev_row]
	idw_criteria.object.relational_op [li_new_row]	=		&
						idw_prev_criteria.object.relational_op [li_prev_row]
	idw_criteria.setitem(li_new_row,'left_paren','(')
	idw_criteria.setitem(li_new_row,'right_paren',')')
	idw_criteria.setitem(li_new_row,'logical_op','AND')
	idw_criteria.setitem(li_new_row,'protect_row_sw','Y')	
	// Protect_row_sw is a new column.  The Protect attribute 
	// expression looks at the contents of this column.  In
	//	the d/w object, if protect_row_sw = Y, then each column
	//	is protected.
	// Reset the period to 'NONE'
	iuo_query.of_date_change()
Else
	IF ll_row > 0 AND Upper( is_data_type ) <> "SUBSET" THEN
		li_new_row = idw_criteria.insertrow(1)
		ls_col = ldwc_exp1.getitemstring(ll_row,'col_name')
		idw_criteria.setitem(li_new_row,'expression_one',ls_col)
		idw_criteria.object.expression_two [li_new_row]	=	""
		idw_criteria.object.relational_op [li_new_row]	=	"BETWEEN"
		idw_criteria.setitem(li_new_row,'left_paren','(')
		idw_criteria.setitem(li_new_row,'right_paren',')')
		idw_criteria.setitem(li_new_row,'logical_op','AND')
		idw_criteria.setitem(li_new_row,'protect_row_sw','Y')	
	END IF
End If

// Get the 'FROM_DATE' from the prior level of a 'ML' query.

ls_find = "mid(col_name,4) = 'FROM_DATE'"
ll_row = ldwc_exp1.find(ls_find,1,li_exp1_count)

// For a multi-level query, find "payment_date" from the previous
//	level (by search idw_prev_criteria).  If found use these
//	dates
// dw_criteria exists on the prior level with criteria
ls_prev_find	=	"mid(expression_one,4) = 'FROM_DATE'"
li_prev_row		=	idw_prev_criteria.Find (ls_prev_find, 1, li_prev_rowcount)

If ll_row			>	0		&
And li_prev_row	>	0		Then
	li_new_row ++
	li_new_row = idw_criteria.insertrow(li_new_row)
	ls_col = ldwc_exp1.getitemstring(ll_row,'col_name')
	idw_criteria.setitem(li_new_row,'expression_one',ls_col)
	idw_criteria.object.expression_two [li_new_row]	=		&
						idw_prev_criteria.object.expression_two [li_prev_row]
	idw_criteria.object.relational_op [li_new_row]	=		&
						idw_prev_criteria.object.relational_op [li_prev_row]
	idw_criteria.setitem(li_new_row,'left_paren','(')
	idw_criteria.setitem(li_new_row,'right_paren',')')
	idw_criteria.setitem(li_new_row,'logical_op','AND')
	idw_criteria.setitem(li_new_row,'protect_row_sw','Y')	

	// Reset the period to 'NONE'
	iuo_query.of_date_change()

End If

ll_rowcount = idw_criteria.rowcount()

For li_idx = 1 to ll_rowcount
	ls_logical_op	=	idw_criteria.object.logical_op [li_idx]
	IF	li_idx	=	ll_rowcount		THEN
		// Last row, remove any "AND" in logical_op
		IF	Trim (ls_logical_op)	>	'  '		THEN
			idw_criteria.object.logical_op [li_idx]	=	''
		END IF
	ELSE
		// Not the last row in the d/w, if there is no logical_op,
		//	then add one ('AND').
		IF	IsNull (ls_logical_op)				&
		OR	Trim (ls_logical_op)		<	'  '	THEN
			idw_criteria.object.logical_op [li_idx]	=	'AND'
		END IF
	END IF
Next


// Set the count.
iuo_query.Event	ue_set_count_search()

end event

event ue_subsetting_clear_filter_copy;///////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_subsetting_clear_filter_copy		u_nvo_search
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_create_subset to clear out the 
//	filter copy information in istr_subsetting.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument					Datatype					Description
//		---------	--------					--------					-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	FNC			11/25/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_filters, li_idx
string ls_clear_array[]

istr_subsetting_info.filter_copy = ls_clear_array


RETURN 1

end event

event type string ue_compute_payment_date(ref string as_payment_date);/* u_nvo_search.ue_compute_payment_date

	Arguments:	1) as_payment_date (passed by reference)

	Returns:	String - any error message that may have occurred
	
	Description:
	This event is triggered by ddlb_run_frequency.selectionchanged and when a query is loaded.  
	This script computes the payment_date value entered in the criteria.  
	The left 2 bytes of the run frequency description can have the following values:
	'nn' = PDQ that is for the most current number of nn months.
	' M' = Create a subset each month
	' Q' = Create a subset every quarter
	'Qn' = PDQ that runs for quarter n (n = 1,2,3,4)
	' S' = Create a subset every six months
	' A' = Create a subset once a year.
	
*/
///////////////////////////////////////////////////////////////////////////////////
//History:
//	??/??/??	NLG	Created.
//	12/01/99	NLG	Add Q1,Q2,Q3,Q4,S1,S2 logic modified. Must be based on a
//						rolling year; i.e. Q1 will be most recent-loaded first quarter,
//						etc. Add variable ld_end_curr_date.
// 03/22/00 FNC	Track 2156 Stardev. future recurring period should start at 
//						beginning of next month that WILL be loaded.
//	03/15/01	FDG	Stars 4.7.  ros_directory is no longer used.  Use gnv_server instead.
// 07/11/02	GaryR	Track	3194d	Get range based on invoice type.
//	11/26/02	GaryR	SPR 3275d	Validate range of dependant
///////////////////////////////////////////////////////////////////////////////////



date		ld_begin_date,		&
			ld_end_date,		&
			ld_curr_date,		&
			ld_end_curr_date
			
datetime	ldt_curr_date,		&
			ldt_end_date
			
Int		li_begin_month,	&
			li_curr_month,		&
			li_curr_year,		&
			li_begin_day,		&
			li_begin_year,		&
			li_quarter,			&
			li_months,			&
			li_rc

long		ll_rowcount

string 	ls_frequency,		&
			ls_begin_date,		&
			ls_end_date,		&
			ls_quarter,			&
			ls_months
			
n_cst_datetime lnv_date // this nvo is autoinstantiated
ii_run_frequency  =  0	// Initialize the run frequency (NLG 12-22-99 Moved from below)

//Determine if the payment date must be computed.
ls_frequency =  Trim (iuo_query.of_get_pd_opt_desc() )
IF Len(ls_frequency)  =  0 THEN
	Return ''
END IF

//Subsets cannot be scheduled against a subset data source.  
ls_frequency  =  trim(Left (ls_frequency, 2))
CHOOSE CASE  ls_frequency
	CASE 'M','S','Q','A'
		IF is_data_type = 'SUBSET'  THEN
			Return 'You cannot schedule a subset against another subset'
		END IF
END CHOOSE

//	11/26/02	GaryR	SPR 3275d - Begin
IF gnv_server.of_GetLoadedRange( is_inv_type, iuo_query.of_get_add_inv_type(), &
															ldt_curr_date, ldt_end_date ) < 0 THEN
	Return "Error calculating most recent month"
END IF
//	11/26/02	GaryR	SPR 3275d - End

Select cntl_no
Into  :li_begin_month
From  sys_cntl
Where cntl_id  =  'CALENDAR' 
USING STARS2CA;
if Stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'Error retrieving calendar from sys_cntl in u_nvo_query::ue_compute_payment_date() ')
	return 'Sys_cntl Error'
end if

//Ldt_curr_date  =  ids_ros_dir.object.from_date [1]			// FDG 03/15/01
ld_curr_date = Date (ldt_curr_date)			//Most current month in ros directory
ld_curr_date = lnv_date.of_FirstDayOfMonth( Date( ldt_end_date ) )		//	11/26/02	GaryR	SPR 3275d
//Ldt_end_date  =  ids_ros_dir.object.to_date [1]				// FDG 03/15/01
Ld_end_date  =  Date (ldt_end_date)
ld_end_curr_date = ld_end_date				//NLG 12-1-99

Li_curr_month = Month(ld_curr_date)
Li_curr_year  =  Year (ld_curr_date)
Li_begin_day  =  1

IF li_begin_month  >  li_curr_month  THEN
	Li_begin_year =  li_curr_year  -  1
ELSE
	Li_begin_year  =  li_curr_year
END IF
//NLG 12-01-99 Change to month/day/year Format
//Ls_begin_date = String(li_begin_day, "00") + "/" + String(li_begin_month, "00") + "/" + String(li_begin_year, "0000")
Ls_begin_date = String(li_begin_month, "00") + "/" + String(li_begin_day, "00") + "/" + String(li_begin_year, "0000")
Ld_begin_date = Date (ls_begin_date)

//Edit the frequency.
//12-22-99 NLG Initialize the frequency at the beginning of script, so that if return before
//getting here, ii_run_frequency is set to 0
//ii_run_frequency  =  0	// Initialize the run frequency
CHOOSE CASE  ls_frequency
	CASE  'M'
		// Create the subset monthly
		ii_run_frequency  =  1
//		Ld_begin_date = ld_curr_date 											// FNC 03/22/00
		Ld_begin_date = lnv_date.of_relativemonth (ld_curr_date, 1) // FNC 03/22/00
		Ld_end_date = lnv_date.of_lastdayofmonth(ld_begin_date)
	CASE  'Q'
		// Create the subset quarterly
		// Get the current quarter (current date is already set to the 1st day of the month)
		ii_run_frequency  =  3
		Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 2)
		Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		DO WHILE  ld_curr_date  >  ld_end_date  
			Ld_begin_date = lnv_date.of_relativemonth (ld_begin_date, 3)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 2)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		LOOP
		
		// FNC 03/22/00 Start
		if lnv_date.of_lastdayofmonth(ld_curr_date) = ld_end_date then
			Ld_begin_date = lnv_date.of_relativemonth (ld_begin_date, 3)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 2)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		end if
		// FNC 03/22/00 End
		
	CASE  'S'
		// Create the subset semi-annually
		// Get the current semi-annual period (current date is already set to the 1st day of the month)
		ii_run_frequency  =  6
		Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 5)
		Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		IF  ld_curr_date  >  ld_end_date  THEN
			Ld_begin_date = lnv_date.of_relativemonth (ld_begin_date, 6)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 5)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		END IF
		
		// FNC 03/22/00 Start
		if lnv_date.of_lastdayofmonth(ld_curr_date) = ld_end_date then
			Ld_begin_date = lnv_date.of_relativemonth (ld_begin_date, 6)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 5)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		end if
		// FNC 03/22/00 End
		
	CASE  'A'
		// Create the subset annually
		ii_run_frequency  =  12
		Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 11)
		Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		
		// FNC 03/22/00 Start
		if lnv_date.of_lastdayofmonth(ld_curr_date) = ld_end_date then
			Ld_begin_date = lnv_date.of_relativemonth (ld_begin_date, 12)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 11)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		end if
		// FNC 03/22/00 End
		
	CASE  'Q1','Q2','Q3','Q4'
		// Run PDQ for a specified quarter
		Ls_quarter = Mid (ls_frequency, 2, 1)
		IF IsNumber (ls_quarter) = FALSE  THEN
		   Return 'The quarterly period (if entered) must be 1, 2, 3 or 4'
		END IF
		Li_quarter = Integer (ls_quarter)
		If  li_quarter < 1  &
		Or li_quarter > 4  THEN
		   Return 'The quarterly period (if entered) must be 1, 2, 3 or 4'
		END IF
		CHOOSE CASE  li_quarter
		  CASE  2
			// 2nd quarter
			Ld_begin_date =  lnv_date.of_relativemonth (ld_begin_date, 3)
		  CASE  3
			// 3rd quarter
			Ld_begin_date =  lnv_date.of_relativemonth (ld_begin_date, 6)
		  CASE  4
			// 4th quarter
			Ld_begin_date =  lnv_date.of_relativemonth (ld_begin_date, 9)
		END CHOOSE
		// Make sure you're going against a prior quarter
		IF  ld_begin_date  >  ld_curr_date  THEN
			Ld_begin_date  = lnv_date.of_relativemonth (ld_begin_date, -12)
		END IF
		Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 2)
		Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		IF  ld_end_date  >  ld_end_curr_date THEN // ld_curr_date  THEN //NLG 12-1-99
			Ld_begin_date  = lnv_date.of_relativemonth (ld_begin_date, -12)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 2)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		END IF
	CASE  'S1','S2'
		// Run PDQ for the specified semi-annual period
		Ls_months = Mid (ls_frequency, 2, 1)
		IF IsNumber (ls_months) = FALSE  THEN
		   Return 'The semi-annual period (if entered) must be 1 or 2'
		END IF
		Li_months = Integer (ls_months)
		If  li_months = 1  Or li_months = 2  THEN
		ELSE
		   Return 'The semi-annual period (if entered) must be 1 or 2'
		END IF
		IF li_months = 2  THEN
			// 2nd semi-annual period only
			Ld_begin_date =  lnv_date.of_relativemonth (ld_begin_date, 6)
		END IF
		// Make sure you're going against a prior semi-annual period
		IF  ld_begin_date  >  ld_curr_date  THEN
			Ld_begin_date  = lnv_date.of_relativemonth (ld_begin_date, -12)
		END IF
		Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 5)
		Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		IF  ld_end_date  >  ld_end_curr_date THEN //ld_curr_date  THEN //NLG 12-1-99
			Ld_begin_date  = lnv_date.of_relativemonth (ld_begin_date, -12)
			Ld_end_date = lnv_date.of_relativemonth (ld_begin_date, 5)
			Ld_end_date = lnv_date.of_lastdayofmonth(ld_end_date)
		END IF
	CASE  ELSE
		// PDQ that is for the most current number of nn months.  Get the dates from ros_directory.
		Ls_months  =  Trim (ls_frequency)
		IF IsNull (ls_months) OR Not IsNumber(ls_months)  THEN
		   Return 'You can only enter a number in the run frequency'
		END IF
		// FDG 03/15/01 - remove ros_directory
		li_months  =  Integer (ls_months)
		//Ll_rowcount  =  ids_ros_dir.rowcount()
		//IF  li_months  < 1  OR li_months > ll_rowcount	THEN
		//    Return 'The months must be between 1 and ' + string (ll_rowcount)
		//END IF
		// Get the dates from ros_directory
		//Ld_begin_date  =  Date (ids_ros_dir.object.from_date [li_months])
		ld_begin_date	=	lnv_date.of_relativemonth (ld_curr_date, (li_months * -1) + 1)
		// FDG 03/15/01 end
		
		//NLG 11-5-99 Want last day of month
		//Ld_end_date = Date (ids_ros_dir.object.from_date [1])
		Ld_end_date = lnv_date.of_lastdayofmonth(Ld_curr_date)

END CHOOSE

Ls_begin_date = String (ld_begin_date, "mm/dd/yyyy")
Ls_end_date = String (ld_end_date, "mm/dd/yyyy")
As_payment_date = ls_begin_date + ","  +  ls_end_date

Return ''

end event

event type integer ue_set_payment_date();//	u_nvo_search.ue_set_payment_date
//
//	Arguments: 	none
//	Returns:		integer
//
//	This event sets the payment date in the criteria based on the 
//	value in ddlb_run_frequency.  
//
//	NLG	11-08-99	Created.
//	NLG	11-23-99	1) Reset the flag for the date paid row so that
//						Save messagebox is not erroneously triggered.
//						2)	Set protect_row_sw to 'Y' so that if user
//						changes date paid after payment date options was
//						set, will reset payment date options.
//	NLG	12-01-99	The from_date criteria will also be removed when
//						the payment date criteria is changed (or added).
// FNC	02/17/00	Remove last and from criteria when the from date
//						is removed from the criteria.
//	GaryR	01/05/05	Track 4215d Do not automatically remove the from date
////////////////////////////////////////////////////////////////////////

boolean		lb_found = FALSE		//NLG 11-18-99

int			li_rc

long			ll_rowcount,		&
				ll_row

string 		ls_msg,				&
				ls_payment_date,	&
				ls_column

Ls_msg  =  This.Event  ue_compute_payment_date (ls_payment_date)

IF  Len (ls_msg)  >  0   THEN
	MessageBox ('Error', ls_msg)
	Return  -1
END IF

IF  Len ( Trim(ls_payment_date) )  =  0  THEN
	// No payment date computed, get out
	Return 0
END IF

//NLG 11-15-99 moved this line from beginning of script
// Store the run frequency in uo_query so it can eventually be sent to subset options.
Iuo_query.of_set_run_frequency (ii_run_frequency)

// Find the payment date in the criteria and change the expression_two value.
Ll_rowcount  =  idw_criteria.RowCount()
FOR  ll_row  =  1  TO  ll_rowcount
	Ls_column  =  Mid (idw_criteria.object.expression_one [ll_row], 4)
	IF  ls_column  =  'PAYMENT_DATE'  THEN
		idw_criteria.object.expression_two [ll_row] = ls_payment_date
		idw_criteria.object.relational_op [ll_row] = "BETWEEN"
		idw_criteria.object.protect_row_sw [ll_row] = "Y"//NLG 11-23-99
		idw_criteria.SetItemStatus(ll_row,0,Primary!,NotModified!)//NLG 11-23-99
		lb_found = TRUE //NLG 11-18-99
		Exit
	END IF
NEXT

//NLG 11-18-99 If payment_date is not in criteria, add it
IF NOT(lb_found) THEN
	
	//First, check if the last row is blank. If not, insert another line and add 'AND'
	ls_column = Mid (idw_criteria.object.expression_one [ll_rowcount], 4)
	
	if len(ls_column) > 0 then 
		//last row contains criteria. Add 'AND' & insert row
		ll_row = ll_rowcount
		idw_criteria.object.logical_op [ll_row] = 'AND'
		ll_row = idw_criteria.InsertRow(0)
	else
		if ll_rowcount = 1 then
			//Last line is a blank line. If it's the only line, don't insert row, don't add 'AND'
			ll_row = ll_rowcount
		else
			//Last line is blank line. It's not the only line. Add 'AND' to previous row
			//but don't insert another line
			ll_row = ll_rowcount - 1
			idw_criteria.object.logical_op [ll_row] = 'AND'
			ll_row++
		end if
	end if
	
	//Now populate payment date according to listbox selection
	idw_criteria.object.left_paren [ll_row] = '('
	idw_criteria.object.expression_one [ll_row] = is_inv_type + '.' + 'PAYMENT_DATE'
	idw_criteria.object.relational_op [ll_row] = "BETWEEN"
	idw_criteria.object.expression_two [ll_row] = ls_payment_date
	idw_criteria.object.right_paren [ll_row] = ')'
	idw_criteria.object.protect_row_sw [ll_row] = 'Y'
	idw_criteria.SetItemStatus(ll_row,0,Primary!,NotModified!)//NLG 11-23-99
END IF

return 1
end event

event type integer ue_tabpage_search_set_pd_opt_visibility();/////////////////////////////////////////////////////////////////////////////
// Event/Function												Object				
//	--------------												------				
//	ue_tabpage_search_set_pd_opt_visibility			u_nvo_search
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//uo_tabpage_search_set_pd_opt_visibility()
//This event is called by uo_query.ue_tabpage_search_set_pd_opt_visibility,  
//which is called by the itemchanged event of 
//tabpage_source.dw_source.  It sets payment_date_options listbox to be visible for 
//claim queries and invisible for ancillary table queries.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		integer
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	NLG		11/22/99		Created.
// FNC		10/24/01		Track 3683 Starcare. Make the data ddlb's invisible if
//								source of query is a subset.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

If is_source_type = 'AN' or is_data_type = 'SUBSET' then	//FNC 10/24/01
	iuo_query.of_set_pd_opt_visibility (FALSE)
Else
	iuo_query.of_set_pd_opt_visibility (TRUE)	
End If

Return 1
end event

on u_nvo_search.create
call super::create
end on

on u_nvo_search.destroy
call super::destroy
end on

