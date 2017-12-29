$PBExportHeader$u_nvo_report.sru
$PBExportComments$Inherited from u_nvo_query <logic>
forward
global type u_nvo_report from u_nvo_query
end type
end forward

global type u_nvo_report from u_nvo_query
event type integer ue_tabpage_report_set_columns ( string as_inv_types[],  character ac_claim_type )
event type string ue_tabpage_report_get_ub92_base_type ( string as_inv_types )
event type integer ue_tabpage_report_load ( integer ai_level_num )
event type integer ue_tabpage_report_add ( )
event type integer ue_tabpage_report_remove ( )
event type integer ue_tabpage_report_move_col ( string as_direction )
event type integer ue_tabpage_report_drilldown_load_cols ( sx_rpt_cols astr_cols[] )
event type integer ue_tabpage_report_save ( integer ai_level,  string as_query_id )
event type integer ue_tabpage_report_get_template_info ( ref sx_report_template_save asx_report_template_save )
event type string ue_tabpage_report_get_title ( )
event type integer ue_tabpage_report_save_template ( sx_report_template_save asx_report_template_save )
event type boolean ue_tabpage_report_get_new_flag ( )
event type integer ue_tabpage_report_load_template ( string as_template_id )
event type integer ue_tabpage_report_get_selected_columns ( ref sx_col_desc asx_col_desc[] )
event ue_tabpage_report_get_selected_col_names ( ref sx_selected_cols as_selected_cols[] )
event type integer ue_tabpage_report_clear ( boolean arg_keep_title )
event ue_tabpage_report_sort_dw_available ( )
event ue_edit_tabpage_view ( )
event type string ue_tabpage_report_create_system_template ( string arg_tbl_type1,  string arg_tbl_type2 )
event type long ue_tabpage_report_get_selected ( )
event type integer ue_tabpage_report_load_user_template ( )
event type integer ue_tabpage_report_load_system_template ( )
end type
global u_nvo_report u_nvo_report

type variables
Protected:

sx_break_info isx_break_info

// Revenue invoice types
String	is_ub92_types[]
end variables

event type integer ue_tabpage_report_set_columns(string as_inv_types[], character ac_claim_type);//ue_tabpage_report_set_columns(string as_inv_types[],char ac_claim_type)
//This event is called by the itemchanged event of 
//tabpage_source.dw_source.  It will load dw_available with columns 
//from the dictionary for the invoice types selected, whether it is 
//the data source ('M' for main) or additional data source 
//('A' for additional data source).    
//
//If the array has multiple invoice types then this is an 
//ML subset (only can select ML when viewing a subset) so must 
//first load non MC columns, then load MC columns.  A little 
//hitch to the ML subsets is if there are columns that are common 
//to the invoice types in the subset but not considered COMMON they 
//must be portrayed as MC.  So after loading the datawindow with 
//non MC columns, must compare the columns and if a column is 
//duplicated for all invoice types in the subset, the duplicated 
//must be removed and an MC column must be added.  Also, must add 
//revenue columns if UB92 invoice type is part of the subset.
//
//If have non claim table types (Patient & Provider) will fall 
//thru and just load single invoice type.

//Also must clean up the description in expression_one 
//(15 characters or till '/') and sort by elem_desc.

//******************************************************************************
//Modification History
//--------------------
//
// 12/24/97	JTM	Added call to idw_Available.SetSQLSelect() and
//						added crit_seq to selected columns. Also, changed
//						refs. from elem_desc to compute_0001.
// 02-03-98	FNC	If drilldown and the drildown report will include 
//						previously displayed columns do not reset idw_selected 
//						because it  clear out the previously selected cols
//	02/13/98	FDG	Un-hilite all rows after retrieving idw_available.
//	02/20/98	FDG	Trigger an event to sort & un-hilite idw_available
//	03/04/98	FDG	Track 884.  In creating the 'ML' SQL and a UNION
//						to get all of the MC rows.
//	03/11/98	FDG	Track 884.  In determining any revenue columns (UB92),
//						pass a retrieval argument to lds_ub92_table_types.
//						Then if any are found, then append the SQL as a Union
//						to the end of the existing SQL.
// 03/26/98 FNC	Track 912. 1. Add elem_data_type to sql for data window so that
//						U_NVO_Create_SQL.UE_Create_SQL can determine the data type 
//						of columns in ML subset.
//						2. Remove sort of dw_available. It is performed in 
//						ue_tabpage_report_sort_dw_available()
//						3. Correct call to ue_make_common in uo_query.tabpage_report.
//						dw_available and move it to end of script so that it executes
//						after the datawindow is loaded.
//						4. Store dependent join tables in an array so the variable
//						holding the number of invoices can be bumped up for the 
//						number of dependent join tables.
//	04/14/98	FDG	Track 1007.  When additional data source is being added,
//						remove everything from idw_available except the original
//						invoice type (data_source).
// 04/28/96 FNC	Track 1146. If ac_claim_type = 'A' do not reset the selected
//						datawindow. Remove the cols from the selected datawindow that
//						do not match the main table.
//	FDG	05/12/98	Track 1223.  Set the count after adding a row.
//	FDG	05/21/98	Track 1248.  For drilldown, if the user wants the columns
//						in the original report to be included in this report, move
//						those columns to dw_selected.
//	FDG	05/29/98	Track 1248.  For drilldown, place the columns in dw_selected
//						in the same order as it was stored in lstr_drilldown.columns.
// FNC	06/04/98	Track 1110. Enable/disable break with totals depending on
//						whether or not cols are selected for report.
//	FDG	06/15/98	Track ????.  Do not reference attributes from uo_query.
//	FDG	07/31/98	Track 1248.  For drilldown, trigger another script to load
//						dw_selected.
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
//	GaryR	09/12/02	SPR 3070d	Preserve case of description
// 11/16/04 MikeF	SPR 3650d	Remove all references to W_SUBSET_COLS_JOIN in Win Parm
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//******************************************************************************

n_ds 		lds_ub92_table_types
long  	ll_rowcount,			&
			ll_retrieve_return,	&
			ll_row,					&
			ll_sel_row
integer 	li_num_inv,				&
			li_pos,					&
			li_inv,					&
			li_col,					&
			li_row,					&
			li_depend_joins,		&
			li_counter,				&
			li_upper,				&
			li_idx
string	ls_inv_types,			&
			ls_sql,					&
			ls_ub92_invoices,		&
			ls_tbl_types,			&
			ls_temp[],				&
			ls_curr_inv_type,		&
			ls_find,					&
			ls_tbl_type

idw_available.SetRedraw(FALSE)

//FNC 04/28/98 Start

if ac_claim_type = 'M' then
	idw_selected.reset()
elseif ib_drilldown 	 then													// FDG 05/21/98	// FDG 06/15/98
	idw_selected.reset()
end if

//FNC 04/28/98 End

if ac_claim_type = 'M' then    /* reset datawindow if main data source*/
	idw_available.reset()
end if

// FDG 04/21/98 begin
// Edit the input invoice types for null values - convert to empty string

li_upper		=	UpperBound (as_inv_types)

FOR li_idx	=	1	TO	li_upper
	IF	IsNull ( as_inv_types[li_idx] )		THEN
		as_inv_types[li_idx]	=	''
	END IF
NEXT
// FDG 04/21/98 end

// FDG 04/15/98 begin
IF	ac_claim_type	=	'A'	THEN
	// Additional data source.  Remove all invoice types except the
	// original invoice type.
	ls_curr_inv_type	=	iuo_query.of_getinvoicetype()
	ll_rowcount	=	idw_available.RowCount()
	FOR ll_row	=	1	TO	ll_rowcount
		ls_tbl_type	=	idw_available.object.elem_tbl_type [ll_row]
		IF	ls_curr_inv_type	<>	ls_tbl_type			THEN
			idw_available.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row --
			ll_rowcount --
		END IF
	NEXT
	
	//FNC 04/28/98 Start 
	// Remove all invoice types from selected datawindow except the
	// original invoice type.
	ll_rowcount	=	idw_selected.RowCount()
	FOR ll_row	=	1	TO	ll_rowcount
		ls_tbl_type	=	idw_selected.object.elem_tbl_type [ll_row]
		IF	ls_curr_inv_type	<>	ls_tbl_type			THEN
			idw_selected.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row --
			ll_rowcount --
		END IF
	NEXT
	//FNC 04/28/98 End
END IF
// FDG 04/15/98 end

li_num_inv = upperbound(as_inv_types)

If li_num_inv > 1 then /* ML - get non MC, remove dups, get MC */
	For li_inv =1 to li_num_inv
		IF	Trim ( as_inv_types[li_inv] )		>	' '		THEN
			ls_inv_types = ls_inv_types + ",'" + as_inv_types[li_inv] + "'"
		END IF
	Next

	ls_inv_types = mid(ls_inv_types,2)  /* remove first "," */
	ls_sql = "select distinct elem_desc, "+ &
				"elem_tbl_type, elem_name, crit_seq, elem_col_number, elem_data_type, " + &
				"DISP_SEQ, ELEM_DATA_LEN, ELEM_DATA_SCALE, DISP_FORMAT,ELEM_TYPE " +&
				"from dictionary " + &
				" where elem_type IN ('CL','CC') and elem_tbl_type in (" + &
				Upper( ls_inv_types ) + ") and crit_seq <> 0 and elem_name not " + &
				" in (select elem_name from dictionary where " + &
				"elem_tbl_type = 'MC' and elem_type IN ('CL','CC') and " + &
				" crit_seq <> 0)"											+ &
				" UNION select distinct elem_desc, "	+ &
				" elem_tbl_type, elem_name, crit_seq, elem_col_number, elem_data_type," + &
				" DISP_SEQ, ELEM_DATA_LEN, ELEM_DATA_SCALE, DISP_FORMAT,ELEM_TYPE " +&
				"FROM DICTIONARY " + &
				" where elem_type IN ('CL','CC') and elem_tbl_type = '" + &
				Upper( gv_sys_dflt )	+ "' and crit_seq <> 0"
				
	// The following event fills in is_ub92_types[]
	ls_UB92_invoices = This.Event ue_tabpage_report_get_UB92_base_type(ls_inv_types) 
	if ls_UB92_invoices <> '' then
		/* must get join field/dep table (CR) from stars_win_parm table */
		lds_ub92_table_types = Create n_ds
		lds_ub92_table_types.DataObject = 'd_ub92_table_types'
		lds_ub92_table_types.SetTransObject(Stars2ca)
		ll_rowcount	=	lds_ub92_table_types.Retrieve(is_ub92_types)			// FDG 3/11/98
		If ll_rowcount > 0 then
			stars2ca.of_commit()												
			For li_row = 1 to ll_rowcount
				ls_temp[li_row] = lds_ub92_table_types.GetItemString(li_row, 'ID_2')	
				ls_tbl_types = ls_tbl_types + ",'" + ls_temp[li_row] + "'"	
			Next

			ls_tbl_types = mid(ls_tbl_types,2)  /* remove first "," */

			ls_sql = ls_sql + " Union select distinct elem_desc, " + &
						"elem_tbl_type, elem_name, crit_seq, elem_col_number, elem_data_type," + &
						" DISP_SEQ, ELEM_DATA_LEN, ELEM_DATA_SCALE, DISP_FORMAT,ELEM_TYPE " +&
						" from dictionary " + &
						" where elem_type IN ('CL','CC') and elem_tbl_type in (" + Upper( ls_tbl_types ) + ")" + &
						" and crit_seq <> 0 and elem_name not in " + &
						" (select elem_name from dictionary where " + &
						" elem_tbl_type in (" + Upper( ls_ub92_invoices ) + ") and " + &
						" elem_type IN ('CL','CC') and  crit_seq <> 0)"	
		End If
		Destroy lds_ub92_table_types
	end if
else /* single inv type so just load*/
	ls_sql = "select distinct elem_desc, " + &		
				"elem_tbl_type, elem_name, crit_seq, elem_col_number, elem_data_type, " + &
				" DISP_SEQ, ELEM_DATA_LEN, ELEM_DATA_SCALE, DISP_FORMAT,ELEM_TYPE" +&
				" FROM dictionary " + &
				" where elem_type IN ('CL','CC') and elem_tbl_type = '" + &
				Upper( as_inv_types[1] ) + "' and crit_seq <> 0"
end if

If Trim(ls_Sql) <> '' Then
	idw_available.setsqlselect(ls_sql)			
End If

ll_rowcount = idw_available.retrieve()

/* finally have dw loaded, now must clean up the description column and sort by 
description */

If ll_rowcount < 1 Then
	idw_available.SetRedraw(TRUE)
	Return ll_rowcount
End If

//	Un-hilite and sort idw_available
This.Event	ue_tabpage_report_sort_dw_available()

//03-26-98 FNC start
/* if MC is one of the invoice types then subtract 1 from li_num_inv before passing*/

If li_num_inv > 1 then /* ML - remove duplicate columns */
	for li_inv = 1 to li_num_inv
		if as_inv_types[li_inv] = 'MC' then
			li_num_inv --
			exit
		end if
	next
	
	/* Add dependent join cols, if any, to the invoice array that is passed to 
	ue_make_common */
	idw_available.Dynamic	Event ue_make_common(li_num_inv)			// FDG 06/15/98
	/*resort after common columns are consolidated */
	This.Event	ue_tabpage_report_sort_dw_available()
	
end if
//03-26-98 FNC end

// FDG 05/21/98, 05/29/98 begin
//	For drilldown, if the user wants the columns from the original report to
//	be included in this report, move the columns to dw_selected.

ll_rowcount	=	idw_available.RowCount()

IF	istr_drilldown.column_flag	=	TRUE		THEN				// FDG 06/15/98
	This.Event	ue_tabpage_report_drilldown_load_cols (istr_drilldown.columns)	// FDG 07/31/98
END IF

// FDG 05/21/98, 05/29/98 end

// Set the count.
iuo_query.Event	ue_set_count_report()				// FDG 05/12/98

this.event ue_edit_tabpage_view()	// FNC 06/04/98 
	
idw_available.SetRedraw(TRUE)

Return 1
end event

event ue_tabpage_report_get_ub92_base_type;////////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_report_get_UB92_base_type(string as_inv_types)
//
//	Arguments:	as_inv_types
//
//	Returns:		String
//
//	Description:
//		This event is called by ue_tabpage_report_set_columns() 
//		to determine if there is a UB92 invoice type in the subset.  
//		Using the string of comma delimited invoice types will select 
//		from get base types from stars_rel and determine if there is 
//		a UB92.  (use invisible datawindow on w_main which is loaded 
//		with stars_rel/dictionary info)  If there is will return a 
//		comma delimeted string of the UB92 invoice types enclosed 
//		in single quotes, else return empty string.
////////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created
//
//	FDG	03/04/98	Track 884.
//						1. Filter dw_stars_rel_dict instead of sort it.
//						2. Unfilter the previous filter
//						3. Remove the quote in ls_inv_types
//						4. Change i to li_idx
//						5. Fill in is_ub92_types[]
//	FNC	04/01/98	Track 912
//						1.	Put quotes back into ls_inv_types
////////////////////////////////////////////////////////////////////////


string ls_filter, ls_inv_types, ls_ub92_types[]
long ll_rowcount
integer li_idx

is_ub92_types	=	ls_ub92_types		// Initialize is_ub92_types[] array

ls_filter = "rel_type = 'QT' and id_2 in (" + as_inv_types + &
	") and " + " key6 = 'UB92'"
	
w_main.dw_stars_rel_dict.SetFilter('')					// FDG 03/04/98
w_main.dw_stars_rel_dict.Filter()						// FDG 03/04/98

w_main.dw_stars_rel_dict.setfilter(ls_filter)
//w_main.dw_stars_rel_dict.sort()						// FDG 03/04/98
w_main.dw_stars_rel_dict.Filter()						// FDG 03/04/98

ll_rowcount = w_main.dw_stars_rel_dict.rowcount()

if ll_rowcount > 0 then
	for li_idx = 1 to ll_rowcount
		is_ub92_types[li_idx]	=	Upper( w_main.dw_stars_rel_dict.object.id_2 [li_idx] )
		ls_inv_types = ls_inv_types + ",'" + &
			w_main.dw_stars_rel_dict.object.id_2[li_idx]	+ "'"	//04-01-98 FNC 
	next
	return mid(ls_inv_types,2)
else
	return ''
end if
end event

event type integer ue_tabpage_report_load(integer ai_level_num);/////////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_report_load
//
//	Arguments:	ai_level_num - The level #
//
//	Returns:		Integer
//
//	Description:
//		This event is called by w_query_engine.ue_load_query when a 
//		pre-defined query is loaded.  It will take the information out 
//		of dw_pdq_tables (per level_num) and load it into this tabpage.  
//		It will load the selected fields datawindow with columns found in 
//		the PDQ_COLUMNS table that have col_type of 'RPT' 
//		(not 'SPQ' - Super Provider Query). 
//		It will use the col_name in the table to determine the row 
//		in the Available Fields datawindow and select it.  Once all 
//		are selected, the add event (ue_tapbage_report_add()) will 
//		be triggered to move the columns into the Selected Fields 
//		datawindow.  Also must insert the report title into the report mle.
//		The report title is found on PDQ_CNTL.
//
/////////////////////////////////////////////////////////////////////////
//
//Modification History
//--------------------
//
//	12/24/97	J.Mattis	Assigned li_AvailableRows (to idw_available's 
//							rowcount) instead of using li_rowcount. This permits 
//							find to search the entire data set of 
//							idw_available. 
// 01/22/98	J.Mattis	Removed report title assignment due to multi-level 
//							error.  Also, added code to set the PDQ filter for 
//							the current query level.
//	03/09/98	FDG		Track 902.  Do not include any non-RPT columns (i.e. 
//							SPQ - super provider query).  Change i to ll_row.
//	03/26/98	FDG		Track 983.  idw_selected must be loaded in the same
//							sequence that exists in iuo_Query.id_pdq_columns.  To
//							do this, ue_tabpage_report_add cannot be triggered.
//							Instead, the data must be manually moved and
//							unhighlighted.
//	03/26/98	FNC		Track 912.  Elem_Data_Type has been added to the available
//							and selected datawindows so it must be moved from the available 
//						   to the selected datawindow/
//	04/13/98	FDG		Track 1057.  If there are no rows, disable the View
//							Report tab.
//	04/15/98	FDG		Track 1074.  For each row in idw_selected, get its
//							elem_desc from dictionary and format the description.
//	04/17/98	FDG		Track 1026.  Because duplicate rows (by elem_name) are
//							being eliminated in idw_available, an additional 'find'
//							of idw_available may be needed.
//	FDG	05/12/98		Track 1223.  Set the count after adding a row.
//	FDG	06/15/98		Track ????.  Do not reference attributes from uo_query.
//	FDG	06/19/98		Track 1301.  Change 'RPT' to 'PDQ' to be consistant.
//	FDG	07/24/98		Track 1533.  Do not insert into dw_selected unless
//							the column is found in dw_available.  This fixes the 
//							condition where there are duplicate entries in 
//							PDQ_COLUMNS.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////

Long		ll_rowcount, 		&
			ll_found, 			&
			ll_AvailableRows,	&
			ll_SelectRow,		&
			ll_row
String	ls_find,				&
			ls_test,				&
			ls_tbl_type,		&
			ls_col_name,		&
			ls_col_type,		&
			ls_filter

//	Filter dw_pdq_columns by this level #
iw_parent.wf_SetLevelFilter(ai_level_num,'REPORT')

//	Narrow the filter to only get 'PDQ' columns for this level
ls_filter	=	"level_num = "	+	String(ai_level_num)	+	&
					"and col_type = 'PDQ'"									// FDG 06/19/98

iw_parent.wf_setfilter	(idw_pdq_columns,				&
								ai_level_num,					&
								ls_filter)

ll_rowcount = idw_pdq_columns.rowcount()				// FDG 06/15/98

if ll_rowcount < 1 then
	This.Event	ue_edit_tabpage_view()					// FDG 04/13/98
	return -1
end if

//	Prevent screen flicker.
idw_available.SetRedraw (FALSE)							// FDG 04/09/98
idw_selected.SetRedraw (FALSE)							// FDG 04/09/98
	
idw_selected.Reset()		// FDG 03/26/98 - Reset the selected d/w

ll_AvailableRows = idw_available.RowCount()

for ll_row = 1 to ll_rowcount
	ls_tbl_type 	=	idw_pdq_columns.object.tbl_type[ll_row]				// FDG 06/15/98
	ls_col_name 	=	idw_pdq_columns.object.col_name[ll_row]				// FDG 06/15/98
	ls_col_type 	=	idw_pdq_columns.object.col_type[ll_row]				// FDG 06/15/98
	
	// Get crit_seq & elem_col_number from idw_available.
	// While we're getting this, remove that row from idw_available
	
	ls_find = "elem_tbl_type = '" + ls_tbl_type + &
		"' and elem_name = '" + ls_col_name + "'"

	ll_found = idw_available.find(ls_find,1,ll_AvailableRows)
	
	// FDG 04/17/98 begin
	IF	ll_found	<	1		THEN
		// Row not found.  Set the 'find' to not include elem_tbl_type
		ls_find	=	"elem_name = '" + ls_col_name + "'"
		ll_found = idw_available.find(ls_find,1,ll_AvailableRows)
	END IF
	// FDG 04/17/98 end
	
	IF ll_found > 0 then
		//	Found the data in idw_available.  Move the data to idw_selected.
		//	Then remove the row from idw_available.
		//	FDG 03/26/98 begin		// FDG 07/24/98 - move insert of idw_selected here.
		idw_available.rowsmove( ll_found, ll_found, Primary!, idw_selected, idw_selected.rowcount() + 1, Primary!)
	END IF
	// FDG 03/26/98 end
NEXT

//	Reset the filter to dw_pdq_columns
iw_parent.wf_SetLevelFilter(0,'REPORT')

// change the row status to New!
this.uf_SetStatus(idw_selected,NotModified!)

// FDG 03/26/98 - Unhighlight all rows in idw_available & idw_selected
idw_available.SelectRow (0, FALSE)
idw_selected.SelectRow (0, FALSE)

idw_available.SetRedraw (TRUE)				// FDG 04/09/98
idw_selected.SetRedraw (TRUE)					// FDG 04/09/98

// Set the count.
iuo_query.Event	ue_set_count_report()				// FDG 05/12/98

// FDG 03/26/98 - Determine if tabpage view is to be enabled.
This.Event	ue_edit_tabpage_view()

RETURN 1
end event

event type integer ue_tabpage_report_add();/////////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_report_add()
//
//	Arguments:	None
//
//	Returns:		Integer - 1=Successful
//
//	Description:
//		This event is called by multiple events and controls in
//		tabpage_report to move the highlighted rows in dw_available 
//		to dw_selected.   If columns are put into dw_selected then 
//		items on the right mouse menu must be visible and the tabpage_view 
//		must be enabled.  
//
/////////////////////////////////////////////////////////////////////////
//	Modification History
//	--------------------
//
//	12/24/97	J.Mattis	Changed parent reference to iw_Parent. 
//	03/02/98	FDG		Enable the Next button when enabling the
//							view data tab.
//	03/26/98	FDG		Track 982.  Edit the enabling of tabpage view via
//							an event
//	FDG	05/12/98		Track 1223.  Set the count after adding a row.
//	NLG	08/19/98		fs144 Report on Enhancements -
//								1. turn ib_load_template switch off
//								2. allow user to determine where inserted row will go in dw_selected
// AJS   08/25/98    ts144. Report on enhancemenst. Add drag-drop capability
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////

dragobject ldrg_object
long ll_upperbound_return
long ll_rowcount, ll_row, ll_num_selected, li_highlighted_row = 1
string ls_highlighted_items[]
integer li_idx, li_rc, li_selected_row, li_row_increment, li_insert_at

integer li_idx_selected
integer li_highlighted_row_selected = 1
long ll_row_selected
string ls_highlighted_items_selected[]
long ll_upperbound_return_selected

iuo_query.of_set_ib_load_template(false)//NLG 8/19/98

// AJS 08/25/98 ts144
If IsValid(DraggedObject()) then
	ldrg_object = DraggedObject( )

	// Make sure you're not dropping this object on itself!.
	IF TypeOf ( ldrg_object ) = DataWindow! THEN
		IF ldrg_object.ClassName ( ) = "dw_selected" THEN 

			//Get the first selected row and rowcount
			li_selected_row = idw_selected.GetSelectedRow(0)
			ll_rowcount = idw_selected.rowcount() 

			//Set up row increment for moving mutiple rows and dw insertion point
			li_row_increment = 0
			li_insert_at = iuo_query.of_get_drop_row()
			
			//If the insertion point is 0 (you want to move them to the end) use rowcount + 1
			If li_insert_at = 0 then
				li_insert_at = ll_rowcount + 1
			End If
			
			//Add code for users with slippery mice
			if idw_selected.IsSelected(li_insert_at) = TRUE Then
				//getout the user dropped onto itself
				Return 1
			end if
			
			idw_selected.of_multiselect(FALSE)

			Do While li_selected_row > 0

					//	Deselect the row; move; and increment the number of rows moved
					idw_selected.SelectRow(li_selected_row, FALSE)
					idw_selected.RowsMove(li_selected_row,li_selected_row,Primary!,idw_selected,li_insert_at + li_row_increment, Primary!)
					
					//	Only increment when you get lower than the insertion point
					If li_insert_at < li_selected_row then
						li_row_increment++
					End If
					
					//Get next selected row to move
					li_selected_row = idw_selected.GetSelectedRow(0)

			Loop
			idw_selected.of_multiselect(TRUE)
			Return 1
		END IF
	END IF
End If
// AJS 08/25/98 end

ll_rowcount = idw_available.rowcount()

Do until li_highlighted_row = 0
	li_highlighted_row = idw_available.getselectedrow(ll_row)
	If li_highlighted_row > 0 Then
		ll_row = li_highlighted_row
		li_idx = li_idx + 1
		ls_highlighted_items[li_idx] = &
			idw_available.GetItemString(li_highlighted_row,"compute_0001")
	End If
Loop

ll_upperbound_return = UpperBound(ls_highlighted_items)	

If ll_upperbound_return > 0 Then
	For li_idx = 1 to ll_upperbound_return
		ll_row = idw_available.Find &
			("compute_0001 = '"+ ls_highlighted_items[li_idx] +"'",1,ll_rowcount)
		
		
		//NLG ts144 Report on enhancements										 	START****
		//Count # of highlighted rows in selected box	
		Do until li_highlighted_row_selected = 0
			li_highlighted_row_selected = idw_selected.getselectedrow(ll_row_selected)
			If li_highlighted_row_selected > 0 Then
				ll_row_selected = li_highlighted_row_selected
				li_idx_selected = li_idx_selected + 1
				ls_highlighted_items_selected[li_idx_selected] = &
					idw_selected.GetItemString(li_highlighted_row_selected,1)
			End If
		Loop
		ll_upperbound_return_selected = UpperBound(ls_highlighted_items_selected)
		//NLG 																					 STOP********
		
		If ll_row > 0 Then
			//NLG ts144																		START***********
			if ll_upperbound_return_selected = 1 then
				ll_num_selected = ll_row_selected - 1
			else
				ll_num_selected = idw_selected.rowcount()
			end if
			//NLG ts144																		STOP************

			idw_available.rowsmove(ll_row,ll_row,Primary!,&
				idw_selected, ll_num_selected + 1,Primary!)
		End If
	Next
	idw_available.SetRow(0)
	idw_available.SelectRow(0,False)

End If

idw_available.Drag ( End! ) 					// AJS 08/25/98 

iuo_query.Event	ue_set_count_report()	// FDG 05/12/98

This.Event	ue_edit_tabpage_view()			// FDG 03/26/98

RETURN 1
end event

event type integer ue_tabpage_report_remove();////////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_report_remove()
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This event is called by multiple events and controls in 
//		tabpage_report to move the highlighted rows in dw_selected to 
//		dw_available.  If no columns are put into dw_selected then items 
//		on the right mouse menu must be invisible and the tabpage_view 
//		must be disabled.
////////////////////////////////////////////////////////////////////////
//	History
//
//	JWO	01/13/98 Made major modifications.
//	FDG	02/20/98	1. Re-sorted dw_available
//						2. Changed variable i to li_idx
//	FDG	03/02/98	Disable the Next button when disabling the
//						view data tab.
//	FDG	04/13/98	Track 1057.  Determine the disabling of the View Report
//						tab via an event.
//	FDG	05/12/98	Track 1223.  Set the count after removing data.
//	FDG	06/15/98	Track ????.  Do not reference attributes from uo_query.
//	NLG	08/18/98	ts144. Report on enhancements.  Set ib_load_template.
// AJS   08/25/98 ts144. Report on enhancemenst. Add drag-drop capability
//	FNC	10/16/01	Track 3712 Starcare. If removed column was also a break 
//						column then remove column from the break info structure.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////

dragobject ldrg_object
long ll_rowcount, ll_row, ll_num_available, ll_upperbound_return
integer li_idx, li_highlighted_row = 1, li_rc
string ls_highlighted_items[]

boolean lb_break_removed
integer li_break_idx,li_new_break_idx,li_upperbound_break_cols
sx_break_info lstr_break_info, lstr_new_break_info


// AJS 08/25/98 TS144-Report On Enhancements
If IsValid(DraggedObject()) then
	ldrg_object = DraggedObject( )

	// Make sure you're not dropping this object on itself!.
	IF TypeOf ( ldrg_object ) = DataWindow! THEN
		IF ldrg_object.ClassName ( ) = "dw_available" THEN 
			li_rc = idw_available.Drag ( Cancel! ) 
			Return -1
		END IF
	END IF
End If
// AJS 08/25/98 end

ll_rowcount = idw_selected.rowcount()

Do until li_highlighted_row = 0
	li_highlighted_row = idw_selected.getselectedrow(ll_row)
	If li_highlighted_row > 0 Then
		ll_row = li_highlighted_row
		li_idx = li_idx + 1
		ls_highlighted_items[li_idx] = &
			idw_selected.GetItemString(li_highlighted_row,"compute_0001")
	End If
Loop

ll_upperbound_return = UpperBound(ls_highlighted_items)	

If ll_upperbound_return > 0 Then
	For li_idx = 1 to ll_upperbound_return
		ll_row = idw_selected.Find &
			("compute_0001 = '"+ ls_highlighted_items[li_idx] +"'",1,ll_rowcount)
		If ll_row > 0 Then
			ll_num_available = idw_available.rowcount()

			idw_selected.rowsmove(ll_row,ll_row,Primary!,&
				idw_available, ll_num_available + 1,Primary!)
		End If
	Next
	
	//FNC 10/16/01 Start
	lstr_break_info = iuo_query.uf_get_sxbreakinfo()
	
	li_upperbound_break_cols = upperbound(lstr_break_info.cols)
	if li_upperbound_break_cols > 0 then
		for li_break_idx = 1 to li_upperbound_break_cols
			lb_break_removed = false
			for li_idx = 1 to ll_upperbound_return
				if ls_highlighted_items[li_idx] = lstr_break_info.cols[li_break_idx].col_desc then
					lb_break_removed = true
				end if
			next
			if lb_break_removed = false then
				li_new_break_idx++
				lstr_new_break_info.cols[li_new_break_idx] = lstr_break_info.cols[li_break_idx]
			end if
		next

		if upperbound(lstr_new_break_info.cols) > 0 then
			lstr_new_break_info.counts = lstr_break_info.counts
			lstr_new_break_info.totals = lstr_break_info.totals
		end if
		
		iuo_query.uf_set_sxbreakinfo(lstr_new_break_info)
		
	end if
	//FNC 10/16/01 End

	idw_selected.SelectRow(0,False)

	
End If

idw_selected.Drag ( End! ) 								// AJS 08/25/98

//	Un-hilite and sort idw_available
This.Event	ue_tabpage_report_sort_dw_available()

//	Determine if the View Report tab is to be disabled.
This.Event	ue_edit_tabpage_view()						// FDG 04/13/98

iuo_query.Event	ue_set_count_report()				// FDG 05/12/98

//NLG ts144 - report on enhancements                   START*****
//if rows remain in dw_selected, pdq columns will be saved
if this.event ue_tabpage_report_get_selected() > 0 then
	iuo_query.of_set_ib_load_template(false)
else
	iuo_query.of_set_ib_load_template(true)
end if
//NLG ts144 - report on enhancements				STOP*******
RETURN 1
end event

event ue_tabpage_report_move_col;call super::ue_tabpage_report_move_col;//ue_tabpage_report_move_col(string as_direction)
//This event is called by the up and down buttons to move a 
//field up or down one field in the Selected Fields datawindow.
long ll_rowcount, ll_row
integer li_new_position

ll_rowcount = idw_selected.rowcount()
ll_row = idw_selected.GetSelectedRow(0)
if ll_row = 0 then
	MessageBox('Error',&
		'Please select a row to move.',StopSign!,Ok!)
	return -1
end if

if ll_row = ll_rowcount and as_direction = 'DOWN' then
	MessageBox('Error',&
		'Down is not valid. Selected field is at the bottom.',StopSign!,Ok!)
	return -1
end if
if ll_row = 1 and as_direction = 'UP' then
	MessageBox('Error',&
		'Top is not valid. Selected field is at the top.',StopSign!,Ok!)
	return -1
end if
//john_wo 1/13/98 changed - 2 to -1 below and + 1 to +2.
if ll_row > 0 then
	if as_direction = 'UP' then
	/* if this doesn't work, move to another buffer then back */
		idw_selected.rowsmove(ll_row,ll_row,Primary!,&
			idw_selected,ll_row - 1,Primary!)
		li_new_position = ll_row - 1
	else
		idw_selected.rowsmove(ll_row,ll_row,Primary!,&
			idw_selected,ll_row + 2,Primary!)
		li_new_position = ll_row + 1
	end if
	idw_selected.SelectRow(0,False)
	idw_selected.ScrollToRow(li_new_position)
	idw_selected.SelectRow(li_new_position,True)
else
	MessageBox('Error',&
		'No row was selected for move.',StopSign!,Ok!)
end if

Return 1
end event

event type integer ue_tabpage_report_drilldown_load_cols(sx_rpt_cols astr_cols[]);//*********************************************************************************
// Event Name:	U_NVO_Report.UE_Tabpage_Report_Drilldown_Load_Cols
//	Arguments:	SX_Rpt_Cols Astr_Cols
// Returns:		Integer
//
//*********************************************************************************
//	This event is called by uo_query.ue_drilldown_load_new_query() 
//	to load the report tabpage with the temp table columns 
//	from the temp table created in the previous uo_query.  
//	The prefix for the columns will be IC_TEMP_ALIAS.
//*********************************************************************************
// 02-03-98 FNC 	If column width is 0 do not add to col list since column is not
//						displayed on report
//	FDG	05/12/98	Track 1223.  Set the count after adding a row.
//	FDG	06/15/98	Track ????.  Do not reference attributes from uo_query.
// FDG	07/29/98	Track 1248.  Load all columns from astr_cols into
//						idw_selected.  With this change, this event can also be
//						called from ue_tabpage_report_set_columns.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

integer	li_col_count,	&
			li_row_count,	&
			li_row,	&
			li_col
string	ls_describe,	&
			ls_width

idw_selected.SetRedraw (FALSE)	// Prevent screen flicker
idw_selected.Reset()

li_col_count = upperbound(astr_cols[])

for li_col = 1 to li_col_count
	
	//02-03-98 FNC start
	ls_describe = '#' + string(li_col) + '.Width'
	ls_width = idw_report.Describe(ls_describe)			// FDG 06/15/98
	
	if ls_width = '0' then
		continue
	end if
		//02-03-98 FNC End
		
	
	li_row = idw_selected.insertrow(0)
	
	// FDG 07/29/98 begin
	idw_selected.SetItem(li_row, 'elem_desc', astr_cols[li_col].label)
	idw_selected.SetItem(li_row, 'elem_tbl_type', astr_cols[li_col].tbl_type)
	idw_selected.SetItem(li_row, 'elem_name', astr_cols[li_col].name)
	idw_selected.SetItem(li_row, 'crit_seq', astr_cols[li_col].crit_seq)
	idw_selected.SetItem(li_row, 'elem_col_number', astr_cols[li_col].col_number)
	idw_selected.SetItem(li_row, 'elem_data_type', astr_cols[li_col].data_type)
next

// Set the count.
iuo_query.Event	ue_set_count_report()				// FDG 05/12/98
idw_selected.SetRedraw (TRUE)		

Return 1
end event

event ue_tabpage_report_save;call super::ue_tabpage_report_save;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	u_nvo_report				ue_tabpage_report_save
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by w_query_engine.ue_save_query() to load the information from 
// the tabpage to the pdq_column datawindow.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype		Description
//	---------	--------			--------		-----------
// Value			ai_level			Integer		The query level.
//	Value			as_query_id		String		The query id.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer		1				Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/09/97	Created.
//	J.Mattis	01/21/98	Added guard against inserting into an update datawindows to
//							prevent SQL insert duplicate key errors.
//	FDG		03/09/98	Track 902.  Make sure that all inserts into dw_pdq_columns
//							occur at the end of the d/w.  Change i to ll_row.  Also,
//							do not delete any rows in dw_pdq_columns because the d/w
//							is already reset prior to this event and rows could have
//							been legitimately inserted for 'SPQ' (super provider query)
//							in u_nvo_search.ue_tabpage_search_save().
//	FDG		06/19/98	Track 1301.  Change 'RPT' to 'PDQ' to be consistant.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_pdq_row = 1, ll_rept_count, ll_row, ll_PDQ_Count
Integer li_return

iw_parent.wf_SetLevelFilter(ai_level,'REPORT')

ll_PDQ_Count = idw_pdq_columns.RowCount()

//Messagebox("PDQ Columns",idw_pdq_columns.describe("datawindow.data"))

ll_rept_count = idw_selected.rowcount()

// FDG 03/09/98 begin - Always insert at end of d/w
for ll_row = 1 to ll_rept_count
	//check if row exists in PDQ
	ll_pdq_row = idw_pdq_columns.insertrow(0)
	idw_pdq_columns.SetRow (ll_pdq_row)
	idw_pdq_columns.object.query_id[ll_pdq_row] = as_query_id
	idw_pdq_columns.object.level_num[ll_pdq_row] = ai_level
	idw_pdq_columns.object.seq_num[ll_pdq_row] = ll_pdq_row
	idw_pdq_columns.object.tbl_type[ll_pdq_row] = idw_selected.object.elem_tbl_type[ll_row]
	idw_pdq_columns.object.col_name[ll_pdq_row] = idw_selected.object.elem_name[ll_row]
	idw_pdq_columns.object.col_type[ll_pdq_row] = 'PDQ'					// FDG 06/19/98
	// The report title is stored in PDQ_TABLES during u_nvo_source's
	//	ue_tabpage_source_save event.
	//Messagebox("PDQ Columns "+String(i),idw_pdq_columns.describe("datawindow.data"))
next

// Do NOT remove any inserted rows.  This is not the
//	only script that inserts data into idw_pdq_columns!
//If ll_PDQ_Count > ll_rept_count Then
//	Long ll_Start
//	ll_Start = ll_PDQ_Count - (ll_PDQ_Count - ll_rept_count) + 1
//	FOR i = ll_Start TO ll_PDQ_Count
//		li_return = idw_pdq_columns.DeleteRow(i)
//	NEXT
//End If
//	FDG 03/09/98 end

iw_parent.wf_SetLevelFilter(0,'REPORT')

Return 1
end event

event ue_tabpage_report_get_template_info;call super::ue_tabpage_report_get_template_info;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	u_nvo_report				ue_tabpage_report_get_template_info
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by w_query_engine.ue_save_report_template() to get template 
// information of the template currently loaded into this tabpage.  First it make sure 
// the template belongs to the user, then  it gets information that had been loaded into 
// datastores when a report template is used.  
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument							Datatype			
//	---------	--------							--------			
// Reference	asx_report_template_save	sx_report_template_save	
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			0			Success			
//						-1			Template is not current user's
//						-2			Cannot retrieve template info from case link
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	???				???				
//														
/////////////////////////////////////////////////////////////////////////////

Long l_row 

l_row = ids_report_template_case_link.GetRow()

If l_Row > 0 Then
	
	if ids_report_template_case_link.Object.user_id[l_row] <> gc_user_id then
		MessageBox("Error","Cannot update, does not belong to you.",StopSign!)
		return -1
	end if
	
	asx_report_template_save.report_template_id = &
		ids_report_template_case_link.Object.link_key[l_row]
	asx_report_template_save.report_template_name = &
		ids_report_template_case_link.Object.link_name[l_row]
	asx_report_template_save.report_template_type = is_inv_type
	asx_report_template_save.report_template_desc = &
		ids_report_template_case_link.Object.link_desc[l_row]
	
	return 0
Else
	MessageBox("Error","Cannot obtain report template case link.",StopSign!)
	Return -2
End If

end event

event ue_tabpage_report_get_title;call super::ue_tabpage_report_get_title;If IsValid(iuo_query) then
	Return iuo_query.of_GetReportTitle()
Else
	Return ''
End If
end event

event ue_tabpage_report_save_template;///////////////////////////////////////////////////////////////////////
//ue_tabpage_report_save_template(sx_report_template_save asx_report_template_save)
//This event is called by w_query_engine.ue_save_report_template() to 
//save a report template into the case_link, pdq_cntl and pdq_columns 
//tables.  If the Path is Save As (A) then must create the 
//datastores (n_ds) to hold this info else clean out the datastores 
//before loading the new information.  Finally update the datastores.  
//Note:  Report Templates are unique by USER_ID and TEMPLATE_NAME.  
//To keep this relationship unique in the case_link table put user_id 
//into the case_id column.
///////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created.
//
//	FDG	04/03/98	Track 1032.
//						1. To commit & rollback, called functions.
//						2. Reorganized the inserts into ids_report_template_pdq_columns
//						3. Template ID gets moved to link_name.
//	FDG	04/08/98	Track 1056.  Report templates & PDQs have separate
//						sequence #'s but both are stored in the same tables.
//						This can cause duplicate data.
// FNC	04/23/98	Track 1109. 1. Reset datawindows if path is 'A' (new). If updating
//						an existing template should not reset datawindow.
//						3. Only perform settransobject and insert rows if the template 
//						is new.
//	FDG	04/23/98	Track 1131.  Fix track 1109.  If there is no current row, 
//						get out.  Also, pdq_columns does not have case_id.
//	FDG	06/15/98	Track ????.  Do not reference attributes from uo_query.
//
// FNC	07/09/98	Track 1329 Set status to an 'A' instead of 'C'
//	NLG	8/18/98	ts144  Report On Enhancements:
//						1)	If not ML template, 	store value of additional data source in pdq_cntl
//						2)	store default template indicator
// FNC	11/03/98	Track 1939. Change link type to TMP. Change pdq_type to T.	
//	GaryR	07/03/01	Track 2350D - Trim data prior to updating.
///////////////////////////////////////////////////////////////////////

string 	ls_title,		&
			ls_table_type,	&
			ls_elem_name
datetime ld_datetime
integer 	li_return,		&
			li_index,		&
			li_rowcount,	&
			li_row,			&
			li_rc
long 		ll_curr_case_link_row,	&
			ll_curr_pdq_cntl_row,	&
			ll_curr_pdq_columns_row,	&
			ll_selected_count

w_main.SetMicroHelp ('Saving the report template.  Please wait.')

if asx_report_template_save.path = 'A' then		//FNC 04/23/98
	ids_report_template_case_link.dataObject = 'd_case_link_rpt_template'		// FDG 04/08/98
	li_return = ids_report_template_case_link.SetTransObject(Stars2ca)
	
	ids_report_template_pdq_cntl.dataObject = 'd_pdq_cntl_rpt_template'			// FDG 04/08/98
	li_return = ids_report_template_pdq_cntl.SetTransObject(Stars2ca)	
	
	ids_report_template_pdq_columns.dataObject = 'd_pdq_columns_rpt_template'	// FDG 04/08/98
	li_return = ids_report_template_pdq_columns.SetTransObject(Stars2ca)		

	ids_report_template_case_link.reset()
	ids_report_template_pdq_cntl.reset()
	ids_report_template_pdq_columns.reset()
	ll_curr_case_link_row = ids_report_template_case_link.insertrow(0)	//FNC 04/23/98
	ll_curr_pdq_cntl_row = ids_report_template_pdq_cntl.insertrow(0)		//FNC 04/23/98
else
	ll_curr_case_link_row = ids_report_template_case_link.getrow()			//FNC 04/23/98
	ll_curr_pdq_cntl_row = ids_report_template_pdq_cntl.GetRow()			//FDG 04/27/98
end if

//ld_datetime = datetime(today(), now())
ld_datetime = gnv_app.of_get_server_date_time()//ts2020c use server date, not pc date

// FDG 04/27/98 begin
IF	ll_curr_case_link_row	<	1			THEN
	// No rows in ids_report_template_case_link.  Get out.
	MessageBox ('Error', 'No rows exist in ids_report_template_case_link.  Script: ' + &
					'u_nvo_report.ue_tabpage_report_save_template.  Path = ' + &
					asx_report_template_save.path + '.')
	Return	-1
END IF
// FDG 04/27/98 end


//ll_curr_pdq_columns_row = ids_report_template_pdq_columns.insertrow(0)		// FDG 04/03/98

/* load case link */
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'case_id',gc_user_id)	//FNC 04/23/98
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'case_spl','00')
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'case_ver','00')
//ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_type','RPT')		// FNC 11/03/98
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_type','TMP')		// FNC 11/03/98
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_key',& 
	asx_report_template_save.report_template_id)
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_name',& 
	asx_report_template_save.report_template_name)
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_desc',& 
	asx_report_template_save.report_template_desc)
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'user_id',gc_user_id)
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_date',ld_datetime)
ids_report_template_case_link.SetItem(ll_curr_case_link_row,'link_status','A')	// FNC 07/09/98

/* load pdq_cntl */
ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'user_id',gc_user_id)
ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'query_id',& 
	asx_report_template_save.report_template_id)
	
if match(asx_report_template_save.report_template_type,',') then 
/*more than 1 inv_type then ML*/
	ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'query_type','ML')
else
	ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'query_type',& 
		asx_report_template_save.report_template_type)
	ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'addl_query_type',&
		asx_report_template_save.report_template_addl_type)						//NLG 8-18-98 ts144
end if

ls_title = imle_title.text									// FDG 06/15/98

ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'create_date',ld_datetime)
ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'pdq_type','T')	// FNC 11/03/98
ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'rpt_title',ls_title) 
ids_report_template_pdq_cntl.SetItem(ll_curr_pdq_cntl_row,'default_template',&
	asx_report_template_save.report_template_default)						//NLG 8-18-98 ts144


/* load pdq_columns */

//ll_curr_pdq_columns_row = ids_report_template_pdq_columns.rowcount()			// FDG 04/03/98
if asx_report_template_save.path = 'S' then
	// FDG 04/27/98 begin

	Delete from pdq_columns
	where col_type = 'TMP' and 
			query_id = Upper( :asx_report_template_save.report_template_id )
	using stars2ca;

	// FDG 04/27/98 end
	
	if stars2ca.of_check_status() <> 0 then
		messagebox('ERROR','Error updating columns. Template cannot be updated')
		return -1
	else
		//stars2ca.of_commit()				// FDG 04/27/98 - Do not commit until the end
	end if
end if

ll_selected_count = idw_selected.rowcount()

for li_index = 1 to ll_selected_count
	ll_curr_pdq_columns_row = ids_report_template_pdq_columns.insertrow(0)	// FDG 04/03/98
	ids_report_template_pdq_columns.SetItem(ll_curr_pdq_columns_row,'query_id',& 
		asx_report_template_save.report_template_id)
	ids_report_template_pdq_columns.SetItem(ll_curr_pdq_columns_row,'level_num',1)
	ids_report_template_pdq_columns.SetItem(ll_curr_pdq_columns_row,'seq_num',li_index)
	
	ls_table_type = idw_selected.GetItemString(li_index,'elem_tbl_type')
	ids_report_template_pdq_columns.SetItem(ll_curr_pdq_columns_row,'tbl_type',ls_table_type) 
	
	ls_elem_name = idw_selected.GetItemString(li_index,'elem_name')
	ids_report_template_pdq_columns.SetItem(ll_curr_pdq_columns_row,'col_name',ls_elem_name) 
	ids_report_template_pdq_columns.SetItem(ll_curr_pdq_columns_row,'col_type','TMP')
next

// save info to tables 

//	GaryR	07/03/01	Track 2350D
ids_report_template_case_link.of_SetTrim( TRUE )
li_return = ids_report_template_case_link.EVENT ue_update( TRUE, TRUE )

If li_return < 0 then
	Stars2ca.of_rollback()
	MessageBox('Error Saving Template',&
		'Error updating the case link table.', StopSign!, Ok!)
	Return -1
End If

//	GaryR	07/03/01	Track 2350D
ids_report_template_pdq_cntl.of_SetTrim( TRUE )
li_return = ids_report_template_pdq_cntl.EVENT ue_update( TRUE, TRUE )

If li_return < 0 then
	Stars2ca.of_rollback()
	MessageBox('Error Saving Template',&
		'Error updating the pdq cntl table.', StopSign!, Ok!)
	Return -1
End If

//	GaryR	07/03/01	Track 2350D
ids_report_template_pdq_columns.of_SetTrim( TRUE )
li_return = ids_report_template_pdq_columns.EVENT ue_update( TRUE, TRUE )

If li_return < 0 then
	Stars2ca.of_rollback()
	MessageBox('Error Saving Template',&
		'Error updating the pdq columns table.', StopSign!, Ok!)
	Return -1
End If

stars2ca.of_commit()

w_main.SetMicroHelp ('Report template ' + asx_report_template_save.report_template_name + &
							' saved successfully.')

Return 1
end event

event ue_tabpage_report_get_new_flag;call super::ue_tabpage_report_get_new_flag;/////////////////////////////////////////////////////////////////////////
//	Script:		ue_tabpage_report_get_new_flag()
//
//	Arguments:	None
//
//	Returns:		Boolean
//
//	Description:
//		Called by im_report.reporttemplatesave to determine if this is the 
//		first time a template is being saved or if just being updated.  
//		Return true if this is a new template else return false.
//
/////////////////////////////////////////////////////////////////////////
//	Modification History
//	--------------------
//
// 11/03/98	FNC	Track 1802 Allow user to save a system template under their own
//						name. Return TRUE if it is a system template
///////////////////////////////////////////////////////////////////////////////////

string ls_case_id
long ll_current_row
If isvalid(ids_report_template_case_link) Then
	ll_current_row = ids_report_template_case_link.GetRow()
	If IsNull(ll_current_row) or ll_current_row < 1 Then
		Return True
	End If
	ls_case_id = ids_report_template_case_link.GetItemString(ll_current_row,'case_id')
	If ls_case_id <> '' and	ls_case_id <> 'SYSTEM' then		// FNC 11/03/98
		return FALSE
	End If
end if

return TRUE


end event

event type integer ue_tabpage_report_load_template(string as_template_id);//john_wo 1/27/98 - add code
//ue_tabpage_report_load_template (string as_template_id)
//This event is called by w_query_engine.ue_list_report_template() to load a report 
//template into instance datastores of the case_link, pdq_cntl and pdq_columns tables.  
//Then the columns will be loaded into dw_selected on tabpage report.  
//The datastores are instances since they need to be available if the user should 
//resave this template.
//ue_tabpage_report_load_template 
////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	john_wo	01/27/98	Created
//	FDG		04/08/98	Track 1056.  Report templates & PDQs have separate
//							sequence #'s but both are stored in the same tables.
//							This can cause duplicate data.
//	FDG		04/08/96	Track 1058.  Load dw_selected in the same sequence
//							as the report template.
//	FDG		04/09/98	Track 1032.  When loading, if data doesn't exist
//							in idw_available, then remove the data from
//							idw_selected and display a messge.
//	FDG		04/13/98	Track 1068.  After loading the report template,
//							enable the View tab.
//	FDG		04/15/98	Track 1074.  For each row in idw_selected, get its
//							elem_desc from dictionary and format the description.
//	FDG		04/17/98	Track 1026.  Because duplicate rows (by elem_name) are
//							being eliminated in idw_available, an additional 'find'
//							of idw_available may be needed.
// FNC		04/23/98	Track 1109. Add user id to argument list for retrieval of
//							ids_report_template_case_link. The data window requires 
//							user id.
//	FDG		05/12/98	Track 1223.  Set the count after adding a row.
//	FDG		06/15/98	Track ????.  Do not reference attributes from uo_query.
//	FDG		07/24/98	Track 1533.  Do not insert into dw_selected unless
//							the column is found in dw_available.  This fixes the 
//							condition where there are duplicate entries in 
//							PDQ_COLUMNS.
//	NLG		08/25/98	ts144 if loading system template, user id will be SYSTEM
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//							to prevent locking.	
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
////////////////////////////////////////////////////////////////////////

integer li_return
string ls_sql, ls_tmp_columns_tbl_type, ls_tmp_columns_col_name
string ls_available, ls_title, ls_avail_tbl_type, ls_avail_name
string ls_user_id 									
long ll_rows_retrieved, ll_template_pdq_columns_rowcount, ll_selected_rowcount
long ll_available_rowcount

Long		ll_row,				&
			ll_selectrow,		&
			ll_found,			&
			ll_availablerows
		
String	ls_find

Boolean	lb_error

ids_report_template_case_link.dataObject = 'd_case_link_rpt_template'		// FDG 04/08/98
li_return = ids_report_template_case_link.SetTransObject(Stars2ca)

if UPPER(left(as_template_id,4)) = 'DFLT' then
	ls_user_id = 'SYSTEM'
else
	ls_user_id = gc_user_id
end if

ll_rows_retrieved = ids_report_template_case_link.retrieve(as_template_id,ls_user_id)	//NLG 08/25/98

ids_report_template_pdq_cntl.dataObject = 'd_pdq_cntl_rpt_template'			// FDG 04/08/98
li_return = ids_report_template_pdq_cntl.SetTransObject(Stars2ca)
li_return = ids_report_template_pdq_cntl.retrieve(as_template_id)

ids_report_template_pdq_columns.dataObject = 'd_pdq_columns_rpt_template'	// FDG 04/08/98
li_return = ids_report_template_pdq_columns.SetTransObject(Stars2ca)
li_return = ids_report_template_pdq_columns.retrieve(as_template_id)


ll_template_pdq_columns_rowcount = ids_report_template_pdq_columns.rowcount()

stars2ca.of_commit()									// FNC 04/14/99

If ll_template_pdq_columns_rowcount < 1 Then
	MessageBox('Error','The current template does not have any columns.',StopSign!,Ok!)
	Return -1
End If

idw_available.SetRedraw (FALSE)				// FDG 04/09/98
idw_selected.SetRedraw (FALSE)				// FDG 04/09/98

ll_selected_rowcount = idw_selected.RowCount()

If ll_selected_rowcount > 0 Then
	li_return = &
		idw_selected.RowsMove(1,ll_selected_rowcount,Primary!,idw_available,1,Primary!)
	idw_available.setsort('compute_0001 A')
	idw_available.Sort()
End If

idw_available.SelectRow(0,False)

ll_AvailableRows	=	idw_available.Rowcount()

For ll_row = 1 to ll_template_pdq_columns_rowcount
	ls_tmp_columns_tbl_type = ids_report_template_pdq_columns.GetItemString(ll_row,'tbl_type')
	ls_tmp_columns_col_name = ids_report_template_pdq_columns.GetItemString(ll_row,'col_name')
	
	// Get crit_seq & elem_col_number from idw_available.
	// While we're getting this, remove that row from idw_available
	
	ls_find = "elem_tbl_type = '" + ls_tmp_columns_tbl_type + &
		"' and elem_name = '" + ls_tmp_columns_col_name + "'"

	ll_found = idw_available.find(ls_find,1,ll_AvailableRows)
	
	// FDG 04/17/98 begin
	IF	ll_found	<	1		THEN
		// Row not found.  Set the 'find' to not include elem_tbl_type
		ls_find	=	"elem_name = '" + ls_tmp_columns_col_name + "'"
		ll_found = idw_available.find(ls_find,1,ll_AvailableRows)
	END IF
	// FDG 04/17/98 end
	
	IF ll_found > 0 then
		//	Found the data in idw_available.  Move the data to idw_selected.
		//	Then remove the row from idw_available.		
		idw_available.rowsmove( ll_found, ll_found, Primary!, idw_selected, idw_selected.rowcount() + 1, Primary!)
	ELSE
		// The data wasn't found in idw_available.  This can occur if the template has multiple 
		// invoice types (i.e. aditional data source or ML subset) and this query does not.
		lb_error		=	TRUE												// FDG 04/09/98
		idw_selected.RowsDiscard (ll_row, ll_row, Primary!)	// FDG 04/09/98
		ll_row --															// FDG 04/09/98
		ll_template_pdq_columns_rowcount --							// FDG 04/09/98
	END IF
	// FDG 03/26/98 end
NEXT

IF	lb_error				THEN
	// FDG 04/09/98
	MessageBox ('Warning', 'There were one or more records in the report template that could ' + &
					'not be loaded.')
END IF

idw_selected.SelectRow(0,False)
idw_available.SelectRow(0,False)

ls_title = ids_report_template_pdq_cntl.GetItemString(1,'rpt_title')

if trim(ls_title) <> '' then		//NLG 9-3-98 track #1657
	imle_title.text = ls_title						// FDG 06/15/98
end if									//NLG 9-3-98 track #1657

// FDG 04/13/98 - Determine if tabpage view is to be enabled.
This.Event	ue_edit_tabpage_view()

idw_available.SetRedraw (TRUE)				// FDG 04/09/98
idw_selected.SetRedraw (TRUE)					// FDG 04/09/98

// Set the count.
iuo_query.Event	ue_set_count_report()				// FDG 05/12/98

w_main.SetMicroHelp ('Ready')

Return 1
end event

event type integer ue_tabpage_report_get_selected_columns(ref sx_col_desc asx_col_desc[]);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function									Access	
// ------						--------------									------	
//	u_nvo_report				ue_tabpage_report_get_selected_columns	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by w_query_engine.ue_break_with_totals() to get the selected 
// column descriptions and their data types to pass to w_subset_sort so the user can 
// determine which columns to break with totals.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument			Datatype			Description
//	---------	--------			--------			-----------
//	Reference	asx_col_desc[]	sx_col_desc		Structure to contain the column desc. and type.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success	
/////////////////////////////////////////////////////////////////////////////////
//
//	02/12/98	J. Mattis	Created.
// 09/09/98	FNC	Track 1672. If the selected dw contains no rows no cols have been 
//										selected so return.
// 04/14/99	FNC	FS/TS2162 	Starcare track 2162. Add commits after executing SQL  
//										to prevent locking.	
// 10/08/01	FNC	Track 2444d Enable break with totals for ML queries.
//										Use separate count to load break structure because only MC cols
//										are available for breaking. Don't want any blank lines to display
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks.
// 10/15/04 MikeF Track 3650d	Use Global Dictionary service instead of local datastore
// 12/15/04 Katie	Track 4121d Added col_name and col_number for break with totals.
//	03/22/06	GaryR	Track 4592	Accomodate computed columns for PDQ import/export
//
//////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_count, ll_Index, ll_row
String ls_data_type, ls_filter, ls_Type[]

ll_count = idw_selected.rowcount()

if ll_count <= 0 then 			// FNC 09/09/98 Start
	messagebox('WARNING','Cannot select Break with Totals until report cols are selected')
	return -1
End if								// FNC 09/09/98 End

//get the table types
if is_inv_type = 'ML' then			// FNC 10/8/01 Start
	ls_type[1]  = 'MC'
else 									// FNC 10/8/01 End
	for ll_Index = 1 to ll_count
		ls_type[ll_Index] = Upper( idw_selected.object.elem_tbl_type[ll_Index] )
	next
end if								// FNC 10/8/01

// get the data type for each selected column 
long ll_break_count			

FOR ll_Index = 1 to ll_count
	
	IF gnv_dict.event ue_get_col_exists(idw_selected.object.elem_tbl_type[ll_Index], &
													idw_selected.object.elem_name		[ll_Index]) THEN
		ls_data_type = gnv_dict.event ue_get_elem_data_type( &
													idw_selected.object.elem_tbl_type[ll_Index], &
													idw_selected.object.elem_name		[ll_Index]) 
	ELSE
		// skip the column since its definition is ambigious in dictionary
		Continue
	End If
	ll_break_count++				//FNC 10/08/01 Start
	asx_col_desc[ll_break_count].col_desc  = idw_selected.object.compute_0001[ll_Index]
	asx_col_desc[ll_break_count].data_type = ls_data_type		//FNC 10/08/01 End
	asx_col_desc[ll_break_count].col_name = idw_selected.object.elem_name[ll_Index]
	asx_col_desc[ll_break_count].col_number = string(ll_Index)
NEXT
 
 
RETURN 1
end event

event ue_tabpage_report_get_selected_col_names;call super::ue_tabpage_report_get_selected_col_names; /*This event is called by tabpage_view_break_with_totals to get the selected column 
 names and table_types if totalling is required in the report.*/  

integer li_count, i

li_count = idw_selected.rowcount()

for i = 1 to li_count
	as_selected_cols[i].col_name =  idw_selected.getitemstring(i,3)
	as_selected_cols[i].tbl_type =  idw_selected.getitemstring(i,2)
next

return 

end event

event type integer ue_tabpage_report_clear(boolean arg_keep_title);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function					Access	
// ------						--------------					------	
//	u_nvo_report				ue_tabpage_report_clear		Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by im_report.m_clear to clear the selected fields datawindow 
// and report title.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	02/03/98		Created.
//	NLG		11/17/98		Track 1805. If this script called to clear dw_selected because
//								not saving pdq cols (default template), don't clear title.
//	FDG		07/17/00		Track 2465c.  Stars 4.5 SP1.  Initialize dw_fastquery.
//	FDG		09/25/00		Track 2465c.  Only initialize fastquest if 'FALSE' is passed
//								to this script.
// LS			1/14/02		Track 2552d - 	Added report_clear label to 
//								handle clear if mode is PDR or PDCR
//	GaryR		12/11/04		Track 4108d	Dynamic Report Options
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_count, ll_row

//Lahu S 1/14/02	Track 2552d
// Jump to 'Report_Clear' label if mode is PDR/PDCR
IF iw_parent.of_is_pdr_mode() THEN GOTO report_clear

ll_count = idw_selected.rowcount()

// Select all rows in dw_selected so can be removed by ue_tabpage_report_remove
for ll_row = 1 to ll_count
	idw_selected.selectrow(ll_row,TRUE)
next
 
this.event ue_tabpage_report_remove()

If IsValid(iuo_query) Then
	// clear the report title 
	If NOT(arg_keep_title) then			//track #1805 
		iuo_query.of_SetReportTitle('')
		// FDG 07/17/00 - Re-initialize dw_fastquery	// FDG 09/25/00 - Move to within the IF
		iuo_query.Event	ue_initialize_dw_fastquery()
	End if										//track #1805
End If

RETURN 1


//Lahu S 1/14/02	Begin Track 2552d
report_clear:
If IsValid(iuo_query) Then	
	// clear report options
	iuo_query.tabpage_report.uo_report_options.of_clear()
End If

RETURN 1
//Lahu S 1/14/02	End
end event

event ue_tabpage_report_sort_dw_available;///////////////////////////////////////////////////////////////////////
//	Script:	ue_tabpage_report_sort_dw_available
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This event sort dw_available.  This event is invoked after the
//		data is retrieved (ue_tabpage_report_set_columns) and when
//		the columns are removed from dw_selected (ue_tabpage_report_remove)
//
///////////////////////////////////////////////////////////////////////
//	History:
//
//	FDG	02/20/98	Created
//
//	FDG	04/17/98	Track 1026.  Before performing the sort, eliminate
//						any rows that are duplicates.  This also includes
//						any rows that also exist in idw_selected.
// FNC	04/13/00	Track 2856 Starcare Stars 4.5. If find a duplicate column
//						eliminate the dependent column.
// FNC	10/22/01	Track 3631 Starcare. Check to see if invoice type equals 
//						the dependent invoice type before removing a duplicate column.
///////////////////////////////////////////////////////////////////////

Long		ll_row,					&
			ll_rowcount,			&
			ll_sel_rowcount,		&
			ll_found
String	ls_elem_name,			&
			ls_prev_elem_name,	&
			ls_find,					&
			ls_tbl_type,			&
			ls_additional_tbl_type

// FDG 04/17/98 begin

// Eliminate any duplicate rows

// Before eliminating, sort to compare data.
idw_available.SetSort ('elem_name A, elem_tbl_type A')
idw_available.Sort()

ll_rowcount			=	idw_available.RowCount()
ll_sel_rowcount	=	idw_selected.RowCount()

ls_additional_tbl_type = iuo_query.of_get_add_inv_type()		//FNC 10/22/01

FOR ll_row			=	1	TO	ll_rowcount
	
	ls_elem_name	=	idw_available.object.elem_name [ll_row]
	ls_tbl_type		=  idw_available.object.elem_tbl_type [ll_row]		// FNC 04/13/00
	ls_find			=	"elem_name = '"	+	ls_elem_name	+	"'"
	ll_found			=	idw_selected.Find (ls_find, 1, ll_sel_rowcount)
	
	IF	ll_found		>	0			THEN
		idw_available.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
		Continue
	END IF
	
	IF	ll_row	>	1		THEN
		// Get the previous elem_name
		ls_prev_elem_name		=	idw_available.object.elem_name [ll_row - 1]
	END IF
	
	IF	ls_elem_name	=	ls_prev_elem_name			THEN
		// Duplicate elem_name.  Remove the current one from dw_available.
      //idw_available.RowsDiscard (ll_row, ll_row, Primary!)			// FNC 04/13/00
		if ls_tbl_type = is_inv_type then					// FNC 04/13/00 Start
			idw_available.RowsDiscard (ll_row - 1, ll_row - 1, Primary!)
			ll_row --
			ll_rowcount --
			Continue			
		elseif ls_tbl_type = ls_additional_tbl_type	THEN					// FNC 10/22/01
			idw_available.RowsDiscard (ll_row, ll_row, Primary!)
			ll_row --
			ll_rowcount --
			Continue				
		end if																	// FNC 04/13/00 End

	END IF
	
NEXT

// FDG 04/17/98 end

// Re-sort idw_available in the correct sequence

idw_available.SetSort ('crit_seq A, compute_0001 A')
idw_available.Sort()

//	Because idw_available was resorted, un-highlight all rows
idw_available.SelectRow (0, FALSE)

end event

event ue_edit_tabpage_view;/////////////////////////////////////////////////////////////////////////
//	Script:	ue_edit_tabpage_view
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This event is triggered from ue_tabpage_report_add and
//		ue_tabpage_report_load.  This event will determine if the
//		tabpage view can be enabled.
//
/////////////////////////////////////////////////////////////////////////
//
//Modification History
//
//	FDG	03/26/98	Track 982.  Created.
//	FDG	04/13/98	Track 1057.  If there are no rows, disable everything
//						about the view data tab.  Event will also be triggered
//						from ue_tabpage_report_remove and ... _load_template.
//	FDG	06/15/98	Track ????.  Do not reference attributes from uo_query.
//	NLG	08/19/98	ts144 (Report on Enhancements)
//						Enable view report tab all the time	
// FNC	09/09/98	Track 1672. Disable report menu items if cols are not selected.
//	FDG	12/04/98	Track 2004.  Pass a true/false argument to
//						ue_enable_next_button.
/////////////////////////////////////////////////////////////////////////

Long	ll_rowcount														//NLG 8/19/98

ll_rowcount	=	idw_selected.RowCount()							// FNC 09/09/98 Start

if ll_rowcount	>	0						THEN							
	iw_parent.Event	ue_set_menus_report(TRUE)
else
	iw_parent.Event	ue_set_menus_report(FALSE)
end if																	// FNC 09/09/98 End

//   iw_parent.Event	ue_set_menus_report(TRUE)

iuo_query.of_enable_tabpage (ic_view, TRUE)					// FDG 06/15/98

iw_parent.Event	ue_enable_next_button(TRUE)				// FDG 12/04/98

//ELSE																	//NLG 8/19/98
//	iw_parent.Event	ue_set_menus_report(FALSE)				//NLG 8/19/98
//	iuo_query.of_enable_tabpage (ic_view, FALSE)				// FDG 06/15/98 //NLG 8/19/98
//	iw_parent.Event	ue_enable_next_button(FALSE)			//NLG 8/19/98
//END IF																	//NLG 8/19/98

end event

event type string ue_tabpage_report_create_system_template(string arg_tbl_type1, string arg_tbl_type2);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_tabpage_report_create_system_template
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Arguments:
//arg_tbl_type1 - Data Source
//arg_tbl_type2 - Additional Data Source
//Returns string:  the columns for this data source/additional data source combination
//						(or empty string if 0 columns returned from dictionary)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//This event is called by u_nvo_report::ue_tabpage_report_load_system_template()
//to select all Data Source/Additional Data Source fields defined in the dictionary with
//a non-zero display sequence value and sort them in ascending Display Sequence 
//order.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//History
//
//	NLG	08/18/98	Created.
//	FNC	11/03/98	Track 1939. Change link type to TMP. Change pdq_type to T.
//	NLG	01/27/99	Don't include duplicates in template	
//	FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
//	GaryR	01/15/01	Stars 4.7 DataBase Port - Empty String in SQL
//	FDG	12/06/01	Track 2497, 2561.  Prevent memory leaks.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

n_ds lds_dict_display, lds_dict_disp2, lds_report_template_case_link
long ll_rows, ll_row, ll_idx
string ls_link_key,ls_link_name,ls_link_desc, ls_empty, ls_tbl_name
datetime ldt_current_date 
int li_rc
string ls_prev_elem_name,ls_elem_name,ls_find
long ll_found, ll_rowcount,ll_row_index

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ls_link_key = 'DFLT;' + arg_tbl_type1
ls_link_name = 'DEFAULT;' + arg_tbl_type1
ls_link_desc = 'SYSTEM REPORT TEMPLATE FOR ' + ARG_TBL_TYPE1

//retrieve all rows from dictionary where display sequence, criteria sequence > 0
lds_dict_display = create n_ds
lds_dict_display.dataobject = 'd_build_dict_sql_select'
lds_dict_display.SetTransObject(stars2ca)

ls_tbl_name = gnv_dict.event ue_get_table_name( arg_tbl_type1 )
IF ls_tbl_name = gnv_dict.ics_error OR ls_tbl_name = gnv_dict.ics_not_found THEN
	IF IsValid( lds_dict_display ) THEN Destroy lds_dict_display
	Return " "
END IF

ll_rows = lds_dict_display.Retrieve( ls_tbl_name )

if ll_rows < 1 then
	if isValid(lds_dict_display) then destroy lds_dict_display
	return ' '
else											// FNC 04/14/99
	stars2ca.of_commit()					// FNC 04/14/99
end if 

IF Trim( arg_tbl_type2 ) <> "" THEN
	ls_link_key = ls_link_key + ';' + arg_tbl_type2
	ls_link_name = ls_link_name + ';' + arg_tbl_type2
	ls_link_desc = ls_link_desc + ';' + arg_tbl_type2
	
	lds_dict_disp2 = create n_ds
	lds_dict_disp2.dataobject = 'd_build_dict_sql_select'
	lds_dict_disp2.SetTransObject(stars2ca)
	
	ls_tbl_name = gnv_dict.event ue_get_table_name( arg_tbl_type2 )
	IF ls_tbl_name = gnv_dict.ics_error OR ls_tbl_name = gnv_dict.ics_not_found THEN
		IF IsValid( lds_dict_display ) THEN Destroy lds_dict_display
		IF IsValid( lds_dict_disp2 ) THEN Destroy lds_dict_disp2
		Return " "
	END IF
	
	ll_rows += lds_dict_disp2.Retrieve( ls_tbl_name )
	lds_dict_disp2.RowsCopy( 1, lds_dict_disp2.RowCount(), Primary!, &
				lds_dict_display, lds_dict_display.RowCount() + 1, Primary! )
				
	IF IsValid( lds_dict_disp2 ) THEN Destroy lds_dict_disp2
	
	// Track #2082 begin **********************************************
	// Eliminate any duplicate rows
	// Before eliminating, sort to compare data.
	lds_dict_display.SetSort ('elem_name A, elem_tbl_type A')
	lds_dict_display.Sort()
	ll_rowcount			=	lds_dict_display.RowCount()
	
	FOR ll_row_index	=	1	TO	ll_rowcount
		ls_elem_name	=	lds_dict_display.object.elem_name [ll_row_index]
	
		IF	ll_row_index	>	1		THEN
			// Get the previous elem_name
			ls_prev_elem_name		=	lds_dict_display.object.elem_name [ll_row_index - 1]
		END IF
		
		IF	ls_elem_name	=	ls_prev_elem_name			THEN
			// remove Duplicate elem_name.  
			lds_dict_display.RowsDiscard (ll_row_index, ll_row_index, Primary!)
			ll_row_index --
			ll_rowcount --
			ll_rows -- 
			Continue
		END IF
	NEXT
	// Track #2082 end ********************************************
ELSE
	arg_tbl_type2 = ls_empty	//	GaryR	01/15/01	Stars 4.7 DataBase Port		// FDG 04/16/01
END IF

//Re-sort in disp_seq order
lds_dict_display.setSort('disp_seq,A')
lds_dict_display.sort()

ldt_current_date =  gnv_app.of_get_server_date_time()

//Insert into case link template datastore
ids_report_template_case_link.dataobject = 'd_case_link_rpt_template'
li_rc = ids_report_template_case_link.SetTransObject(Stars2ca)
ids_report_template_case_link.reset()

ll_row = ids_report_template_case_link.insertRow(0)
ids_report_template_case_link.setItem(ll_row,'case_id','SYSTEM')
ids_report_template_case_link.setItem(ll_row,'case_spl','00')
ids_report_template_case_link.setItem(ll_row,'case_ver','00')
ids_report_template_case_link.setItem(ll_row,'link_type','TMP')			// FNC 11/03/98
ids_report_template_case_link.setItem(ll_row,'link_key',ls_link_key)
ids_report_template_case_link.setItem(ll_row,'link_name',ls_link_name)
ids_report_template_case_link.setItem(ll_row,'link_desc',ls_link_desc)
ids_report_template_case_link.setItem(ll_row,'user_id','SYSTEM')
ids_report_template_case_link.setItem(ll_row,'link_date',ldt_current_date)
ids_report_template_case_link.setItem(ll_row,'link_status','A')

//Insert into pdq control template datastore
ids_report_template_pdq_cntl.dataobject = 'd_pdq_cntl_rpt_template'
li_rc = ids_report_template_pdq_cntl.SetTransObject(Stars2ca)
ids_report_template_pdq_cntl.reset()

ll_row = ids_report_template_pdq_cntl.insertRow(0)
ids_report_template_pdq_cntl.setItem(ll_row,'user_id','SYSTEM')
ids_report_template_pdq_cntl.setItem(ll_row,'query_id',ls_link_key)
ids_report_template_pdq_cntl.setItem(ll_row,'query_type',arg_tbl_type1)
ids_report_template_pdq_cntl.setItem(ll_row,'create_date',ldt_current_date)
ids_report_template_pdq_cntl.setItem(ll_row,'pdq_type','T')						// 11/03/98 FNC
ids_report_template_pdq_cntl.setItem(ll_row,'rpt_title',' ')
ids_report_template_pdq_cntl.setItem(ll_row,'delete_ind',' ')
ids_report_template_pdq_cntl.setItem(ll_row,'addl_query_type',arg_tbl_type2)
ids_report_template_pdq_cntl.setItem(ll_row,'default_template','Y')

//Insert into pdq columns template datastore
ids_report_template_pdq_columns.dataobject = 'd_pdq_columns_rpt_template'
li_rc = ids_report_template_pdq_columns.SetTransObject(Stars2ca)
ids_report_template_pdq_columns.reset()

for ll_idx = 1 to ll_rows 
	ll_row = ids_report_template_pdq_columns.insertRow(0)
	ids_report_template_pdq_columns.setItem(ll_row,'query_id',ls_link_key)
	ids_report_template_pdq_columns.setItem(ll_row,'level_num',1)
	ids_report_template_pdq_columns.setItem(ll_row,'seq_num',ll_idx)
	ids_report_template_pdq_columns.setItem(ll_row,'tbl_type',lds_dict_display.GetItemString(ll_idx,'elem_tbl_type'))
	ids_report_template_pdq_columns.setItem(ll_row,'col_name',lds_dict_display.GetItemString(ll_idx,'elem_name'))
	ids_report_template_pdq_columns.setItem(ll_row,'col_type','TMP')
Next

if isValid(lds_dict_display) then destroy lds_dict_display

//Update the datastores
li_rc = ids_report_template_case_link.EVENT ue_update( TRUE, TRUE )

if li_rc < 0 then
	stars2ca.of_rollback()
	Messagebox('Error Saving Template','Error updating case link table in ~r'+&
			'in u_nvo_report:ue_tabpage_report_create_system_template.',StopSign!,Ok!)
	Return ' '
end if

li_rc = ids_report_template_pdq_cntl.EVENT ue_update( TRUE, TRUE )
if li_rc < 0 then
	stars2ca.of_rollback()
	Messagebox('Error Saving Template','Error updating pdq cntl table in ~r'+&
			'in u_nvo_report:ue_tabpage_report_create_system_template.',StopSign!,Ok!)
	Return ' '
end if

li_rc = ids_report_template_pdq_columns.EVENT ue_update( TRUE, TRUE )
if li_rc < 0 then
	stars2ca.of_rollback()
	Messagebox('Error Saving Template','Error updating pdq columns table in ~r'+&
			'in u_nvo_report:ue_tabpage_report_create_system_template.',StopSign!,Ok!)
	Return ' '
end if

//commit
stars2ca.of_commit()

if ll_rows > 0 then return ls_link_key

Return ' '
end event

event ue_tabpage_report_get_selected;call super::ue_tabpage_report_get_selected;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	ue_tabpage_report_get_selected
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Arguments:  None
//	Returns: long -  the number of rows in the selected fields list box
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	History
//
//	NLG	08/18/98		Created.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_rowcount

ll_rowcount = idw_selected.RowCount()

return ll_rowcount
end event

event type integer ue_tabpage_report_load_user_template();/////////////////////////////////////////////////////////////////////////
//Script:	ue_tabpage_report_load_user_template
//
//Arguments:	None
//
//Returns:	integer 	1) 0 if default template doesn't exist
//							2) number of rows in selected fields listbox if default template exists
//
//Description:
//		Determine if default template exists for this user-dataSource-additional 
//		datasource combination.  If not, return 0, else load user template	
//		datastore and return the number of rows in the selected fields box.
//
/////////////////////////////////////////////////////////////////////////
//
//Modification History
//
//	NLG	08/21/98	ts144 Report On enhancements.  Created.
// AJS   08-28-98 Load 'MC" columns for 'ML' subset
//	FDG	12/09/98	Track 1841.  When coming in from outside sources, it's
//						possible that 'data_source' is null.
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
// FNC 	03/08/00 Set query type to spaces if drilling down on a dependent 
//						because only additional data source is set and system must
//						use a default template that contains only the dependent columns.
// 03/03/05 MikeF SPR4340d Error retrieving template when drilldown to same inv type
/////////////////////////////////////////////////////////////////////////


n_ds lds_pdq_cntl_default_template
long ll_rows
string ls_query_type, ls_addl_query_type, ls_query_id


ls_query_type = left(idw_source.getitemstring(1,'data_source'),2)

if trim(idw_source.getitemstring(1,'add_data_source')) <> '' then
	ls_addl_query_type = left(idw_source.getitemstring(1,'add_data_source'),2)
else
	ls_addl_query_type = ' '
end if

IF	IsNull (ls_query_type) OR	Trim (ls_query_type)	=	''		THEN
	
	if ib_drilldown and istr_drilldown.path = 'AD' then			// FNC 04/06/99 Start
		IF len(trim(ls_addl_query_type)) > 0 THEN
			// Get the default template from the main
			ls_query_type 		 = ls_addl_query_type
			ls_addl_query_type = ' '
		ELSE
			ls_query_type = ' '
		END IF
	else
		ls_query_type = is_inv_type
	end if	

END IF

//AJS 08-28-98 Load 'MC" columns for 'ML' subset
If ls_query_type = 'ML' then
	ls_query_type = 'MC'
	ls_addl_query_type = ' '
End IF

lds_pdq_cntl_default_template = create n_ds
lds_pdq_cntl_default_template.dataobject = 'd_pdq_cntl_default_template'
lds_pdq_cntl_default_template.SetTransObject(stars2ca)
ll_rows = lds_pdq_cntl_default_template.retrieve(gc_user_id, ls_query_type,ls_addl_query_type)

if ll_rows > 0 then						// FNC 04/14/99
	stars2ca.of_commit()					// FNC 04/14/99
end if										// FNC 04/14/99

if ll_rows = 1 then
	ls_query_id = lds_pdq_cntl_default_template.GetItemString(1,'query_id')
	this.event ue_tabpage_report_load_template(ls_query_id)
else 
	if isValid(lds_pdq_cntl_default_template) then destroy lds_pdq_cntl_default_template
	return 0
end if

if isValid(lds_pdq_cntl_default_template) then destroy lds_pdq_cntl_default_template
return this.event ue_tabpage_report_get_selected()		

end event

event type integer ue_tabpage_report_load_system_template();/////////////////////////////////////////////////////////////////////////
//Script:	ue_tabpage_report_load_system_template
//
//Arguments:	None
//
//Returns:	integer 	1) -1 if system template query id not valid
//							2) number of rows in selected fields listbox if system template query id valid
//
//Description:
//		Determine if system template exists for this data source, additional data source
//		combination.  If not, build one, passing data source and additional data source arguments.
//		If the system template query id is valid, call event to load the system template.  Return
//		the number of rows in the Selected Fields listbox.
//
/////////////////////////////////////////////////////////////////////////
//
//Modification History
//
//	NLG	08/21/98	ts144 Report On enhancements.  Created.
// AJS   08-28-98 Load 'MC" columns for 'ML' subset
//	FDG	12/09/98	Track 1841.  When coming in from outside sources, it's
//						possible that 'data_source' is null.
// FNC	04/06/99 FS/TS2098C Starcare Track 2098. Set query type to spaces
//						if drilling down on a dependent because only additional data 
//						source is set and system must use a default template that 
//						contains only the	dependent columns.
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
// 03/03/05 MikeF SPR4340d Error retrieving template when drilldown to same inv type
/////////////////////////////////////////////////////////////////////////


n_ds lds_pdq_cntl_default_template
long ll_rows
string ls_query_type, ls_addl_query_type
string ls_query_id
integer li_return

ls_query_type = left(idw_source.getitemstring(1,'data_source'),2)

if trim(idw_source.getitemstring(1,'add_data_source')) <> '' then
	ls_addl_query_type = left(idw_source.getitemstring(1,'add_data_source'),2)
else
	ls_addl_query_type = ' '
end if

// FDG 12/09/98 begin
IF	IsNull (ls_query_type) OR	Trim (ls_query_type)	=	''		THEN
	if ib_drilldown and istr_drilldown.path = 'AD' then			// FNC 04/06/99 Start
		IF len(trim(ls_addl_query_type)) > 0 THEN
			// Get the default template from the main
			ls_query_type 		 = ls_addl_query_type
			ls_addl_query_type = ' '
		ELSE
			ls_query_type = ' '
		END IF
	else
		ls_query_type = is_inv_type
	end if																		// FNC 04/06/99 Start
END IF
// FDG 12/09/98 end

//AJS 08-28-98 Load 'MC" columns for 'ML' subset
If ls_query_type = 'ML' then
	ls_query_type = 'MC'
	ls_addl_query_type = ' '
End IF

lds_pdq_cntl_default_template = create n_ds
lds_pdq_cntl_default_template.dataobject = 'd_pdq_cntl_default_template'
lds_pdq_cntl_default_template.SetTransObject(stars2ca)
ll_rows = lds_pdq_cntl_default_template.retrieve('SYSTEM',ls_query_type,ls_addl_query_type)

if ll_rows = 0 then	/*system default template does not exist, then build one*/
	ls_query_id = this.event ue_tabpage_report_create_system_template(ls_query_type,ls_addl_query_type)
	if ls_query_id = ' ' then 
		if isValid(lds_pdq_cntl_default_template) then destroy lds_pdq_cntl_default_template
		return -1
	end if 
elseif ll_rows > 0	then						// FNC 04/14/99
	stars2ca.of_commit()							// FNC 04/14/99
	ls_query_id = lds_pdq_cntl_default_template.Object.query_id[1]				
end if

li_return = this.event ue_tabpage_report_load_template(ls_query_id)

if isValid(lds_pdq_cntl_default_template) then destroy lds_pdq_cntl_default_template

/*return the number of rows in the Selected fields listbox*/
return this.event ue_tabpage_report_get_selected()

end event

on u_nvo_report.create
call super::create
end on

on u_nvo_report.destroy
call super::destroy
end on

