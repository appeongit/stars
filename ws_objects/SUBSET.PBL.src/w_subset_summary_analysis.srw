$PBExportHeader$w_subset_summary_analysis.srw
$PBExportComments$Inherited from w_master
forward
global type w_subset_summary_analysis from w_master
end type
type cb_remove from u_cb within w_subset_summary_analysis
end type
type cb_add from u_cb within w_subset_summary_analysis
end type
type st_4 from statictext within w_subset_summary_analysis
end type
type st_2 from statictext within w_subset_summary_analysis
end type
type st_label3 from statictext within w_subset_summary_analysis
end type
type st_available from statictext within w_subset_summary_analysis
end type
type ddlb_ranking from dropdownlistbox within w_subset_summary_analysis
end type
type st_3 from statictext within w_subset_summary_analysis
end type
type ddlb_report_id from dropdownlistbox within w_subset_summary_analysis
end type
type cb_clear from u_cb within w_subset_summary_analysis
end type
type st_ddlb from statictext within w_subset_summary_analysis
end type
type st_selected from statictext within w_subset_summary_analysis
end type
type ddlb_invoice from dropdownlistbox within w_subset_summary_analysis
end type
type st_view_subset from statictext within w_subset_summary_analysis
end type
type cb_view_report from u_cb within w_subset_summary_analysis
end type
type dw_1 from u_dw within w_subset_summary_analysis
end type
type dw_2 from u_dw within w_subset_summary_analysis
end type
type cb_close from u_cb within w_subset_summary_analysis
end type
type st_1 from statictext within w_subset_summary_analysis
end type
type gb_1 from groupbox within w_subset_summary_analysis
end type
type gb_2 from groupbox within w_subset_summary_analysis
end type
type ws_table_info from structure within w_subset_summary_analysis
end type
end forward

type ws_table_info from structure
    string iv_table_type_name[20, 2]
    long iv_table_ct
    string iv_orig_table_type
end type

shared variables
string sv_sel_col_name
string sv_sel_col_type
long   sv_from_row
int      sv_sel_col_len
int      sv_sel_col_number

end variables

global type w_subset_summary_analysis from w_master
string accessiblename = "Subset Summary Analysis"
string accessibledescription = "Subset Summary Analysis"
accessiblerole accessiblerole = windowrole!
integer x = 110
integer y = 116
integer width = 3163
integer height = 2240
string title = "Subset Summary Analysis"
long backcolor = 67108864
event refresh_dws pbm_custom02
cb_remove cb_remove
cb_add cb_add
st_4 st_4
st_2 st_2
st_label3 st_label3
st_available st_available
ddlb_ranking ddlb_ranking
st_3 st_3
ddlb_report_id ddlb_report_id
cb_clear cb_clear
st_ddlb st_ddlb
st_selected st_selected
ddlb_invoice ddlb_invoice
st_view_subset st_view_subset
cb_view_report cb_view_report
dw_1 dw_1
dw_2 dw_2
cb_close cb_close
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_subset_summary_analysis w_subset_summary_analysis

type variables
string	is_summary_select
string	is_inv_type, is_rev_type, is_alias, is_rpt_type, is_base_type
string	is_rept_id, is_from, is_where, is_subset_id, is_subset_name, is_subset_desc

n_cst_stars_rel	inv_rel
sx_subset_summary isx_summary
sx_subset_ids 		istr_subset_ids

Long	il_droprow

//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
String	is_line_text[]
Integer	ii_selected_rank
n_ds	ids_defined_query_line
end variables

forward prototypes
public subroutine wf_reset_counts ()
public subroutine wf_set_ranking_ddlb ()
public function string wf_create_sql ()
public function string wf_add_rank (string as_sql)
private subroutine wf_add_row ()
private subroutine wf_remove_row ()
public function integer wf_get_drop_row ()
end prototypes

event refresh_dws;//=======================================================================================//
//	Window:		w_subset_summary_analysis
//	Event:		refreh_dws
//=======================================================================================//
// Refreshes datawindows
//
//	1. Sets report invoice type based on dropdowns
// 2. Retrieves dw_1
// 3. Alters the descriptions for dw_1
// 4. Sets the counters
//=======================================================================================//
//
// 08/02/95 FNC	Add return code checking for defined query groups
// 10/19/04	MikeF	SPR3650d	Computed columns. Rewrote.
// 05/19/06	GaryR	SPR 4743	Do not initially select any rows
//
//=======================================================================================//
int		li_rc, li_index, li_pos
string	ls_desc, ls_inv_type

// Reset both datawindows
dw_1.Reset()
dw_2.Reset()

// Determine which invoice type to summarize
IF is_rept_id = "SUMBYREV" THEN
	is_rpt_type = 	is_rev_type
	is_alias 	=  inv_rel.of_get_ft_revenue( is_inv_type )
ELSE
	is_rpt_type = is_inv_type
	is_alias		= is_inv_type
END IF

li_rc = dw_1.retrieve( is_alias )
dw_1.SelectRow( 0, FALSE )	// Do not initially select any rows

IF li_rc < 0 THEN
	MessageBox("Error","Error retrieving Dictionary rows for invoice type " + is_rpt_type)
	RETURN
END IF

// Remove Description past "/"
FOR li_index = 1 TO li_rc
	ls_desc = dw_1.GetItemString(li_index,"ELEM_DESC")
	li_pos = pos(ls_desc,"/")
	
	IF li_pos > 0 THEN
		ls_desc = is_alias + "." + left(ls_desc,li_pos - 1)
	END IF
	
	dw_1.setitem( li_index, "ELEM_DESC", ls_desc)
NEXT

dw_1.accepttext()
li_rc = dw_1.SetSort("CRIT_SEQ, ELEM_DESC")
li_rc = dw_1.Sort()

// Reset counters
this.wf_reset_counts()

SetMicroHelp(w_main,"Ready")

end event

public subroutine wf_reset_counts ();//==============================================================================//
//	Window		w_subset_summary_analysis
// Function		wf_reset_counts
//==============================================================================//
// Sets text counters based on current datawindow counts
//==============================================================================//
// Maintenance
// -------- ----- --------------------------------------------------------------
// 10/18/04	MikeF	SPR3650d	Created
//==============================================================================//
st_available.text = String(dw_1.RowCount()) + ' rows available'
st_selected.text 	= String(dw_2.RowCount()) + ' rows selected'
end subroutine

public subroutine wf_set_ranking_ddlb ();//==============================================================================//
//	Window		w_subset_summary_analysis
// Function		wf_set_sort_ddlb
//==============================================================================//
// Populates ddlb_ranking
//==============================================================================//
// Maintenance
// -------- ----- --------------------------------------------------------------
// 10/18/04	MikeF	SPR3650d
//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
//	05/06/07	GaryR	Track 4355	Refresh ranking values when invoice or summary type changes
//
//==============================================================================//

int		li_rc, li_index, li_pos
string	ls_text, ls_null[]
n_cst_string	lnv_string

// Set Rank Dropdown
ddlb_ranking.reset()
is_line_text = ls_null
ii_selected_rank = 0
ddlb_ranking.AddItem('None')

li_rc = ids_defined_query_line.Retrieve( is_base_type, gv_sys_dflt, is_rept_id )
			  
IF li_rc <= 0 THEN
	MessageBox( "ERROR", "Unable to identify rows in DEFINED_QUERY_LINE" )
END IF

FOR li_index = 1 TO li_rc
	ls_text = ids_defined_query_line.GetItemString( li_index, "line_text" )
	is_line_text[li_index] = ls_text
	// Format the label
	li_pos = Pos( ls_text, "=" )
	IF li_pos > 0 THEN
		ls_text = Trim( Left( ls_text, li_pos - 1 ) )
	END IF
	
	// Replace quotes and underscores
	ls_text = lnv_string.of_globalreplace( ls_text, '"', " ")
	ls_text = lnv_string.of_globalreplace( ls_text, "_", " ")
	ddlb_ranking.AddItem( Trim( ls_text ) )
NEXT

ddlb_ranking.SelectItem(1)
end subroutine

public function string wf_create_sql ();//==============================================================================//
//	Window		w_subset_summary_analysis
// Function		wf_create_sql
//==============================================================================//
// Creates complete Subset Summary SQL string
//==============================================================================//
// Maintenance
// -------- ----- --------------------------------------------------------------
// 10/18/04	MikeF	SPR3650d	Created
// 01/24/06 Katie SPR4610d Added Lookup in Code before creating where statement to get correct Invoice Type.
//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
//==============================================================================//
string		ls_select, ls_where, ls_group_by
string		ls_col_name, ls_col_type, ls_formula, ls_inv_type
int			li_keys, li_totals, li_index, li_rc
string		ls_line

n_cst_string	lnv_string
n_cst_prefilter_attrib 	lnv_prefilter

li_keys = dw_2.rowcount()

IF li_keys > 0 then
 	ls_select 	= 'SELECT '
 	ls_group_by = ' GROUP BY '
else
	MessageBox('EDIT','Please, select columns first!')
	Return "ERROR"
end if

setpointer(hourglass!)

// Get the Key columns
FOR li_index = 1 TO li_keys
	ls_col_type	= dw_2.GetItemString(li_index,"ELEM_TYPE")
	ls_col_name = dw_2.GetItemString(li_index,"ELEM_NAME")

	IF li_index > 1 THEN
		ls_group_by += ", "
	END IF

	IF ls_col_type = 'CC' THEN
		ls_formula		=  gnv_dict.event ue_get_formula(is_alias, ls_col_name) 
		ls_select 		+= ls_formula 	+ " " + ls_col_name + ", "
		ls_group_by		+= ls_formula
	ELSE
		ls_select 		+= is_alias + "." + ls_col_name + ", "
		ls_group_by		+= is_alias + "." + ls_col_name
	END IF
	
	isx_summary.selected_columns[li_index] = ls_col_name
	
NEXT

// Create calculated fields SELECT
li_rc = ids_defined_query_line.Retrieve( is_base_type, gv_sys_dflt, is_rept_id )
			  
IF li_rc <= 0 THEN
	MessageBox( "ERROR", "Unable to identify rows in DEFINED_QUERY_LINE" )
	cb_close.Post Event Clicked()
END IF

li_totals = ids_defined_query_line.RowCount()
			
for li_index = 1 to li_totals
	ls_line = ids_defined_query_line.object.line_text[li_index]
	IF gnv_sql.of_get_alias( ls_line ) < 0 THEN
		MessageBox( "Edit Error", "Error modifying SQL in w_subset_summary_analysis" + &
									"::wf_load_select!", StopSign! )
		Return "ERROR"
	END IF	
	ls_select   += ls_line
next

// Replace all @INV refernces with actual invoice type
ls_select = lnv_string.of_globalreplace( ls_select, "@INV", is_alias)

// Set FROM clause
is_from = ' FROM ' + fx_build_subset_table_name(is_rpt_type,is_subset_id) + " " + is_alias

// Set WHERE clause
is_where = ''

IF  is_base_type = 'UB92' &
AND is_rept_id = 'SUMBYREV' THEN
	SELECT CODE_CODE
  	  INTO :ls_inv_type
     FROM CODE
	 WHERE (CODE_TYPE = 'IT') AND
	  		 (CODE_VALUE_A = Upper( :is_inv_type ) )
	 USING STARS2CA;
		
	if stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error retrieving main invoice type (uo_query.dw_report.rbuttondown). Cannot perform lookup' + is_alias)
		return 'ERROR'
	end if
	is_where = " WHERE " + is_alias + ".INVOICE_TYPE = '" + ls_inv_type + "'"
	// Check for Revenue Pre-filter
	lnv_prefilter.is_where = "~~t" + is_rpt_type + ".~~t" + is_subset_id
	openwithparm(w_prefilter_ub92,lnv_prefilter)

	lnv_prefilter = message.PowerObjectParm
	setnull(message.PowerObjectParm)
	
	// If cancelled, Do not execute
	IF lnv_prefilter.is_where = 'CANCEL' THEN
		RETURN "ERROR"
	END IF
	
	IF lnv_prefilter.is_where = 'IGNORE' THEN
		//do not add filter criteria to sql
	else		
		is_where += ' AND ' + lnv_string.of_globalreplace( mid(lnv_prefilter.is_where,6), is_rpt_type + ".", is_alias + ".")
		isx_summary.selected_rows 	= lnv_prefilter.ii_selected_rows
		isx_summary.is_boolean 		= lnv_prefilter.is_boolean
	end if
END IF

RETURN ls_select + is_from + is_where + ls_group_by
end function

public function string wf_add_rank (string as_sql);//==============================================================================//
//	Window		w_subset_summary_analysis
// Function		wf_add_rank
//==============================================================================//
// Adds placeholder for RANK
//==============================================================================//
// Maintenance
// -------- ----- --------------------------------------------------------------
// 10/19/04	MikeF	SPR3650d	Created
//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
//	03/15/07	GaryR	Track 4355	Use proper alias for SUMBYREV
//==============================================================================//
string	ls_filter, ls_pre_rank, ls_post_rank, ls_sql
int		li_rc, li_pos

n_cst_string	lnv_string

IF ii_selected_rank < 2 THEN RETURN as_sql

// Get formula from Defined Query Groups
ls_pre_rank = lnv_string.of_globalreplace( is_line_text[ii_selected_rank - 1] , "@INV", is_alias )

gnv_sql.of_get_alias(ls_pre_rank)

IF Right(Trim(ls_pre_rank),1) = ',' THEN
 	ls_post_rank = ls_pre_rank + "0 RANK, "
ELSE
 	ls_post_rank = ls_pre_rank + ", 0 RANK"
END IF

// Add the rank placeholder
ls_sql = lnv_string.of_globalreplace( as_sql, ls_pre_rank, ls_post_rank)
RETURN ls_sql
end function

private subroutine wf_add_row ();//==============================================================================//
//	Window		w_subset_summary_analysis
// Function		wf_add_row
//==============================================================================//
// Moves selected rows from dw_1 to dw_2
//==============================================================================//
// Maintenance
// -------- ----- --------------------------------------------------------------
// 10/18/04	MikeF	SPR3650d	Created
// 01/31/06	HYL	Track 4339	Move multiple rows selected
//==============================================================================//
/*long		ll_row

ll_row = dw_1.getselectedrow(0)

IF ll_row = 0 THEN RETURN

dw_1.RowsMove(ll_row,ll_row,Primary!,dw_2,dw_2.RowCount() + 1, Primary!)
this.wf_reset_counts()*/

dragobject ldrg_object
long ll_upperbound_return
long ll_rowcount, ll_row, ll_num_selected, li_highlighted_row = 1
string ls_highlighted_items[]
integer li_idx, li_rc, li_selected_row, li_row_increment, li_insert_at

If IsValid(DraggedObject()) then
	ldrg_object = DraggedObject( )

	// Make sure you're not dropping this object on itself!.
	IF TypeOf ( ldrg_object ) = DataWindow! THEN
		IF ldrg_object.ClassName ( ) = "dw_2" THEN 
//			li_rc = dw_2.Drag ( Cancel! ) 

			//Get the first selected row and rowcount
			li_selected_row = dw_2.GetSelectedRow(0)
			ll_rowcount = dw_2.rowcount() 

			//Set up row increment for moving mutiple rows and dw insertion point
			li_row_increment = 0
			li_insert_at = wf_get_drop_row()
			
			//If the insertion point is 0 (you want to move them to the end) use rowcount + 1
			If li_insert_at = 0 then
				li_insert_at = ll_rowcount + 1
			End If
			
			//Add code for users with slippery mice
			if dw_2.IsSelected(li_insert_at) = TRUE Then
				//getout the user dropped onto itself
				Return
			end if
			
			dw_2.of_multiselect(FALSE)

			Do While li_selected_row > 0

					//	Deselect the row; move; and increment the number of rows moved
					dw_2.SelectRow(li_selected_row, FALSE)
					dw_2.RowsMove(li_selected_row,li_selected_row,Primary!,dw_2,li_insert_at + li_row_increment, Primary!)
					
					//	Only increment when you get lower than the insertion point
					If li_insert_at < li_selected_row then
						li_row_increment++
					End If
					
					//Get next selected row to move
					li_selected_row = dw_2.GetSelectedRow(0)

			Loop
			dw_2.of_multiselect(TRUE)
			Return
		END IF
	END IF
End If

ll_rowcount = dw_1.rowcount()

Do until li_highlighted_row = 0
	li_highlighted_row = dw_1.getselectedrow(ll_row)
	If li_highlighted_row > 0 Then
		ll_row = li_highlighted_row
		li_idx = li_idx + 1
		ls_highlighted_items[li_idx] = &
			dw_1.GetItemString(li_highlighted_row,1)
	End If
Loop

ll_upperbound_return = UpperBound(ls_highlighted_items)	

If ll_upperbound_return > 0 Then
	For li_idx = 1 to ll_upperbound_return
		ll_row = dw_1.Find &
			("elem_desc = '"+ ls_highlighted_items[li_idx] +"'",1,ll_rowcount)
		
		//Count # of highlighted rows in selected box
		integer li_idx_selected
		integer li_highlighted_row_selected = 1
		long ll_row_selected
		string ls_highlighted_items_selected[]
		long ll_upperbound_return_selected
		
		Do until li_highlighted_row_selected = 0
			li_highlighted_row_selected = dw_2.getselectedrow(ll_row_selected)
			If li_highlighted_row_selected > 0 Then
				ll_row_selected = li_highlighted_row_selected
				li_idx_selected = li_idx_selected + 1
				ls_highlighted_items_selected[li_idx_selected] = &
					dw_2.GetItemString(li_highlighted_row_selected,1)
			End If
		Loop
		ll_upperbound_return_selected = UpperBound(ls_highlighted_items_selected)
		
		If ll_row > 0 Then
			//ll_num_selected = dw_2.rowcount() 
			if ll_upperbound_return_selected = 1 then
				ll_num_selected = ll_row_selected - 1
			else
				ll_num_selected = dw_2.rowcount()
			end if
			dw_1.rowsmove(ll_row,ll_row,Primary!,&
				dw_2, ll_num_selected + 1,Primary!)
		End If
	Next
	dw_1.SetRow(0)
	dw_1.SelectRow(0,False)

End If

dw_1.Drag ( End! )

this.wf_reset_counts()
end subroutine

private subroutine wf_remove_row ();//==============================================================================//
//	Window		w_subset_summary_analysis
// Function		wf_add_row
//==============================================================================//
// Moves selected row from dw_1 to dw_2
//==============================================================================//
// Maintenance
// -------- ----- --------------------------------------------------------------
// 10/18/04	MikeF	SPR3650d	Created
// 01/31/06	HYL	Track 4339	Move multiple rows selected
//==============================================================================//
/*long		ll_row

ll_row = dw_2.getselectedrow(0)

IF ll_row = 0 THEN RETURN

dw_2.RowsMove(ll_row,ll_row,Primary!,dw_1,1,Primary!)
dw_1.Sort()
this.wf_reset_counts()*/

dragobject ldrg_object
long ll_rowcount, ll_row, ll_num_available, ll_upperbound_return
integer li_idx, li_highlighted_row = 1, li_rc
string ls_highlighted_items[]

If IsValid(DraggedObject()) then
	ldrg_object = DraggedObject( )

	// Make sure you're not dropping this object on itself!.
	IF TypeOf ( ldrg_object ) = DataWindow! THEN
		IF ldrg_object.ClassName ( ) = "dw_1" THEN 
			li_rc = dw_1.Drag ( Cancel! ) 
			Return
		END IF
	END IF
End If

ll_rowcount = dw_2.rowcount()

Do until li_highlighted_row = 0
	li_highlighted_row = dw_2.getselectedrow(ll_row)
	If li_highlighted_row > 0 Then
		ll_row = li_highlighted_row
		li_idx = li_idx + 1
		ls_highlighted_items[li_idx] = &
			dw_2.GetItemString(li_highlighted_row,1)
	End If
Loop

ll_upperbound_return = UpperBound(ls_highlighted_items)	

If ll_upperbound_return > 0 Then
	For li_idx = 1 to ll_upperbound_return
		ll_row = dw_2.Find ("elem_desc = '"+ ls_highlighted_items[li_idx] +"'",1,ll_rowcount)
		If ll_row > 0 Then
			ll_num_available = dw_1.rowcount()

			dw_2.rowsmove(ll_row,ll_row,Primary!,&
				dw_1, ll_num_available + 1,Primary!)
		End If
	Next

	dw_2.SelectRow(0,False)
	
End If

dw_2.Drag ( End! )

dw_1.SetSort ('crit_seq A, elem_desc A')
dw_1.Sort()

this.wf_reset_counts()
end subroutine

public function integer wf_get_drop_row ();RETURN il_droprow
end function

event open;call super::open;//=======================================================================================//
//	Window:		w_subset_summary_analysis
//	Event:		Open
//=======================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------
// 03-22-00 FDG	4.5.  	Use inv_pattern_sql to get the unique keys in the SQL
// 07-16-98 AJS 4.0 TRACK#1465 Fix so only invoices in MC are shown in ddlb
// 02-18-98 AJS 4.0 TS145 - Subset Summary Analysis
// 12-13-95 FNC 				Access Stars_rel via w_main.dw_stars_rel_dict
// 10-23-95 FNC 				Remove connects and disconnects for generic trans
// 08-02-95 FNC 				SWAT effort to display parameters for dictionary read
// 10/19/04	MikeF	SPR3650d	Computed columns. Rewrote.
// 02/21/05 MikeF	SPR4307d Subset name not on title of Subset summary
// 02/25/05 MikeF	SPR4325d Subset description should come from CASE_LINK not SUB_CNTL
// 03/03/05 MikeF	SPR4325d Account for multiple links for same subset
// 04/07/05 MikeF	SPR4348d	Subset ID getting cutoff
//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
//	05/06/07	GaryR	Track 4355	Refresh ranking values when invoice or summary type changes
//
//=======================================================================================//

string				ls_inv_types[]
string				ls_inv_desc
int					li_index, li_inv_types
u_nvo_subset		lnv_subset
n_cst_stars_rel	lnv_rel
n_cst_string		lnv_string

// Build n_cst_subset
lnv_subset.event ue_construct( is_subset_id )
is_subset_desc 		= 	lnv_subset.uf_get_link_desc(istr_subset_ids.subset_case_id, &
								istr_subset_ids.subset_case_spl, istr_subset_ids.subset_case_ver)
st_view_subset.text  = 	is_subset_name + ' - ' + is_subset_desc

// Populate Invoice type dropdown
ls_inv_types	= lnv_subset.of_get_inv_types()
li_inv_types	= UpperBound(ls_inv_types)

FOR li_index = 1 TO li_inv_types
	IF	fx_filter_stars_rel_id_2 (ls_inv_types[li_index]) < 1 THEN
		Errorbox(Stars2ca,'Error getting Table Desc')
		Return
	End IF
   ls_inv_desc 	= w_main.dw_stars_rel_dict.GetItemString (1, "dictionary_elem_desc")	

	IF  left(ls_inv_types[li_index],1) <> 'Q' &
	AND left(ls_inv_types[li_index],1) <> 'O' THEN
		ddlb_invoice.AddItem(ls_inv_types[li_index] + '-' + ls_inv_desc) 
	end if
NEXT

ddlb_invoice.SelectItem(1)

IF li_inv_types > 1 THEN
 	ddlb_invoice.Enabled = TRUE
END IF 

dw_1.SetTransObject(stars2ca)

ddlb_invoice.Triggerevent( "selectionchanged" )

//	Retrieve the defined_query_line setup rows,
// which will be used for ranking and computing
ids_defined_query_line = Create n_ds
ids_defined_query_line.dataobject = 'd_defined_query_line'
ids_defined_query_line.SetTransobject( Stars2ca )
end event

on w_subset_summary_analysis.create
int iCurrent
call super::create
this.cb_remove=create cb_remove
this.cb_add=create cb_add
this.st_4=create st_4
this.st_2=create st_2
this.st_label3=create st_label3
this.st_available=create st_available
this.ddlb_ranking=create ddlb_ranking
this.st_3=create st_3
this.ddlb_report_id=create ddlb_report_id
this.cb_clear=create cb_clear
this.st_ddlb=create st_ddlb
this.st_selected=create st_selected
this.ddlb_invoice=create ddlb_invoice
this.st_view_subset=create st_view_subset
this.cb_view_report=create cb_view_report
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_close=create cb_close
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_remove
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_label3
this.Control[iCurrent+6]=this.st_available
this.Control[iCurrent+7]=this.ddlb_ranking
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.ddlb_report_id
this.Control[iCurrent+10]=this.cb_clear
this.Control[iCurrent+11]=this.st_ddlb
this.Control[iCurrent+12]=this.st_selected
this.Control[iCurrent+13]=this.ddlb_invoice
this.Control[iCurrent+14]=this.st_view_subset
this.Control[iCurrent+15]=this.cb_view_report
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.dw_2
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.gb_2
end on

on w_subset_summary_analysis.destroy
call super::destroy
destroy(this.cb_remove)
destroy(this.cb_add)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_label3)
destroy(this.st_available)
destroy(this.ddlb_ranking)
destroy(this.st_3)
destroy(this.ddlb_report_id)
destroy(this.cb_clear)
destroy(this.st_ddlb)
destroy(this.st_selected)
destroy(this.ddlb_invoice)
destroy(this.st_view_subset)
destroy(this.cb_view_report)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;//ajs 4.0 02-18-98 the subset id will now be passed to this window
// 03/03/05 MikeF	SPR4325d Account for multiple links for same subset

istr_subset_ids = message.PowerObjectParm
is_subset_id	 = istr_subset_ids.subset_id
is_subset_name	 = istr_subset_ids.subset_name

SetNull(message.PowerObjectParm)

end event

event close;call super::close;//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.

IF IsValid( ids_defined_query_line ) THEN Destroy ids_defined_query_line
end event

type cb_remove from u_cb within w_subset_summary_analysis
string accessiblename = "Move Field from Selected List to Available List"
string accessibledescription = "¬"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1499
integer y = 1216
integer width = 146
integer height = 96
integer taborder = 60
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "¬"
end type

event clicked;call super::clicked;//	11/08/06	GaryR	Track 4821	Make buttons consistent
parent.wf_remove_row()
end event

type cb_add from u_cb within w_subset_summary_analysis
string accessiblename = "Move Field from Available List to Selected List"
string accessibledescription = "®"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1499
integer y = 1056
integer width = 146
integer height = 96
integer taborder = 60
fontfamily fontfamily = roman!
string facename = "Symbol"
string text = "®"
end type

event clicked;call super::clicked;//	11/08/06	GaryR	Track 4821	Make buttons consistent
parent.wf_add_row()
end event

type st_4 from statictext within w_subset_summary_analysis
string accessiblename = "Selected"
string accessibledescription = "Selected"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 1669
integer y = 508
integer width = 402
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Selected"
boolean focusrectangle = false
end type

type st_2 from statictext within w_subset_summary_analysis
string accessiblename = "Available"
string accessibledescription = "Available"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 504
integer width = 402
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Available"
boolean focusrectangle = false
end type

type st_label3 from statictext within w_subset_summary_analysis
string accessiblename = "Summarize By"
string accessibledescription = "Summarize By"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 73
integer y = 252
integer width = 434
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Summarize By:"
boolean focusrectangle = false
end type

type st_available from statictext within w_subset_summary_analysis
string accessiblename = "Number of rows available"
string accessibledescription = "0 rows available"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 73
integer y = 1888
integer width = 827
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0 rows available"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_ranking from dropdownlistbox within w_subset_summary_analysis
string accessiblename = "Ranking Options"
string accessibledescription = "Ranking Options"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 526
integer y = 328
integer width = 955
integer height = 356
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 1073741824
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
ii_selected_rank = index
end event

type st_3 from statictext within w_subset_summary_analysis
string accessiblename = "Ranking"
string accessibledescription = "Ranking"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 73
integer y = 336
integer width = 288
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Ranking:"
boolean focusrectangle = false
end type

type ddlb_report_id from dropdownlistbox within w_subset_summary_analysis
string accessiblename = "Summarize By Options"
string accessibledescription = "Summarize By Options"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 526
integer y = 240
integer width = 955
integer height = 328
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//==============================================================================//
//	Window	w_subset_summary_analysis
// Object	ddlb_report_id
// Event		selectionchanged
//==============================================================================//
//
//==============================================================================//
// Maintenance
// -------- ----- -------- -----------------------------------------------------
// 09/29/97 JohnW Spec 195 Changed ls_ft_inv_type to is_ft_inv_type
// 12-24-96 FNC 	FS121 	If rept id = SUMBYREV go against revenue record 
// 08-02-95 FNC 				Add return code checking for defined query groups
// 10/18/04	MikeF	SPR3650d	Rewrote.
//	09/26/06	GaryR	Track 4355	Centralize and fix Ranking and Computed columns and labels.
//==============================================================================//
int li_rc

is_rept_id = this.text
parent.POST wf_set_ranking_ddlb( )
parent.TriggerEvent("Refresh_dws")

end event

type cb_clear from u_cb within w_subset_summary_analysis
string accessiblename = "Clear"
string accessibledescription = "Clear"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2267
integer y = 2004
integer width = 384
integer height = 108
integer taborder = 110
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "C&lear"
end type

event clicked;

int	li_index

SetPointer(HourGlass!)	

FOR li_index = dw_2.RowCount() TO 1 STEP -1
	dw_2.Selectrow( li_index, TRUE)
	parent.wf_remove_row()
NEXT






end event

type st_ddlb from statictext within w_subset_summary_analysis
string accessiblename = "Invoice Type"
string accessibledescription = "Invoice Type"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 160
integer width = 434
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Invoice Type:"
boolean focusrectangle = false
end type

type st_selected from statictext within w_subset_summary_analysis
string accessiblename = "Number of rows selected"
string accessibledescription = "0 rows selected"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 1669
integer y = 1888
integer width = 827
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0 rows selected"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_invoice from dropdownlistbox within w_subset_summary_analysis
string accessiblename = "Invoice Type Selection"
string accessibledescription = "Invoice Type Selection"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 526
integer y = 148
integer width = 955
integer height = 428
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 1073741824
boolean enabled = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//==============================================================================//
//	Window	w_subset_summary_analysis
// Object	ddlb_invoice
// Event		selectionchanged
//==============================================================================//
// Selectionchanged for ddlb_invoice
//==============================================================================//
// Maintenance
// -------- ----- -------- -----------------------------------------------------
// 10/18/04	MikeF	SPR3650d	Rewrote.
//==============================================================================//
SetPointer(HourGlass!)

is_inv_type 	= Left(this.text,2)
is_base_type	= inv_rel.of_get_base_type( is_inv_type )

// Set report Type dropdown
ddlb_report_id.Reset()
ddlb_report_id.AddItem("SUMBYCLM")

// Add SumByRev if UB92
IF inv_rel.of_get_is_ub92(is_inv_type) THEN
	ddlb_report_id.AddItem("SUMBYREV")
	is_rev_type 	= inv_rel.of_get_revenue( is_inv_type )
ELSE
	is_rev_type 	= ' '
END IF

ddlb_report_id.SelectItem(1)

// Retrieve dw_1
ddlb_report_id.TriggerEvent("selectionchanged")
end event

type st_view_subset from statictext within w_subset_summary_analysis
string accessiblename = "Subset ID"
string accessibledescription = "1234567890"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 526
integer y = 72
integer width = 2565
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "1234567890"
borderstyle borderstyle = styleraised!
end type

type cb_view_report from u_cb within w_subset_summary_analysis
string accessiblename = "View Report"
string accessibledescription = "View Report"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1824
integer y = 2004
integer width = 384
integer height = 108
integer taborder = 100
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&View Report"
end type

event clicked;//************************************************************************
//		Object Type:	CommandButton
//		Object Name:	w_subset_summary_analysis.cb_view_report
//		Event Name:		N/A
//
//
//************************************************************************
//	FDG 03/22/00	4.5. 
//						1.	Use inv_pattern_sql to edit the sql for any 
//							unique key placeholders.
// FNC 11/30/98	Track 2008. Dynamically determine the rank column number.
// ajs 07/20/98   4.0 Track #1524 - fix sql when applying pre-filter
// ajs 02/18/98   4.0 TS145-Subset summary analysis; make changes for change	
//						in structure of the ubset user subset table name for OpenServer
//	FNC 08/02/95	Add error code checking for defined query groups read
//
//	FDG 11/09/95	Rename the subset table (thru fx_open_server_table)
//						to account for open server.
//
// FNC 06/11/96   Call generic prefilter window instead of specialized 
//						subset summary prefilter window.
//
// FNC 06/12/96	Allow user to cancel report in prefilter window
//
// FNC 08/21/96	Prob #927 STARCARE
//					   Make sure the revenue table type is passed to the
//                prefilter window.
//
// FNC 09/11/96 	Prob 27 STARS35
//						Upper mystring so that all strings are found even if
//						they are enter in the database in lower case
//
// FNC 10/17/96	Prob #202 Stars35 Use iv_subset_id_hold so don't pass
//						quoutes that are tacked onto iv_subset_id at the end
//						of this script.
//
//	FNC  12-24-96	FS121 If rept id = SUMBYREV go against revenue 
//						record to eliminate join between hospital and 
//						revenue
// 
// KTB 04-10-00   STARCare Track #2782. If using a filter in a subset,
//                query against FILTER_VALS table instead of
//                SUB_FILTER_VALS_<subset Id>
// GaryR 01/23/01	Eliminate global gv_subset_summary_select
// GaryR 01/25/01	Stars 4.7 DataBase Port - Column Aliases
//	GaryR	03/15/01	Stars 4.7 DataBase Port - Case Sensitivity
//	FDG	11/01/01	Track 2509d.  The rank column # passed to 
//						w_subset_summary_report is computed incorrectly.
// CSL   01/14/02 Track Starsdev 2595 multiple invoice-types per base-type problem.
// FNC	01/17/02	Track 2684. Error when apply pre-filter.
//	GaryR	12/16/02	Track 3393d	Reset the where clause after pre-filter
//	GaryR	08/15/03	Track 5218c	Do not join to filter table on prefilter
//	GaryR	01/15/04	Track 6147c	Obtain the ranking column fron the built DW
//	GaryR	08/06/04	Track 4049d	Provide drilldown from Subset Summary
// MikeF 10/21/04 Track 3650d	Rewrote.
// MikeF 02/15/05 Track 4291d Changed calendar button logic for report
// MikeF	04/07/05	Track 4348d	Subset ID getting cutoff
//	GaryR	09/08/06	Track 4816	Set proper inv type when drilling down from ML FT Subset Summary
//	GaryR	09/26/06	Track 4355	Centralize and fix Ranking and Computed columns and labels.
//************************************************************************
int					li_rc
string				ls_sql 
sx_subset_summary	lsx_summary
u_nvo_pattern_sql	lnv_pattern_sql

// Reset the structure to blank
isx_summary = lsx_summary 

// Create SQL
ls_sql 	= parent.wf_create_sql( ) 

IF ls_sql = "ERROR" THEN RETURN

// Add ranking placeholder
ls_sql = parent.wf_add_rank( ls_sql)

lnv_pattern_sql	=	CREATE	u_nvo_pattern_sql
li_rc	 = lnv_pattern_sql.uf_set_tbl_type (is_rpt_type, is_rpt_type)
lnv_pattern_sql.uf_set_sql (ls_sql)
li_rc	 = lnv_pattern_sql.uf_edit_sql()
ls_sql =	lnv_pattern_sql.uf_get_sql()
DESTROY lnv_pattern_sql

w_main.SetMicroHelp("Opening Subset Summary Report. Please wait.")
isx_summary.subset_id 		= is_subset_id
isx_summary.subset_name		= is_subset_name
isx_summary.subset_desc		= is_subset_desc
isx_summary.report_id 		= is_rept_id
isx_summary.invoice_type	= is_alias
isx_summary.is_main_inv_type = is_inv_type
isx_summary.subset_summary_select = ls_sql

isx_summary.enable_calendar = FALSE
IF dw_2.rowcount() = 1 THEN
	IF gnv_sql.of_is_date_data_type(dw_2.GetItemString(1,"ELEM_DATA_TYPE")) THEN
		isx_summary.enable_calendar = TRUE
	END IF
END IF

OpenSheetwithParm(w_subset_summary_report,isx_summary,MDI_main_frame,help_menu_position,Layered!)
end event

type dw_1 from u_dw within w_subset_summary_analysis
string accessiblename = "Available Fields List"
string accessibledescription = "Available Fields List"
accessiblerole accessiblerole = clientrole!
event drag_it pbm_mousemove
string tag = "title = Available Fields"
integer x = 73
integer y = 572
integer width = 1399
integer height = 1304
integer taborder = 70
string dragicon = "ROWS.ICO"
string dataobject = "d_avail_columns"
boolean vscrollbar = true
boolean ib_singleselect = true
boolean ib_isupdateable = false
boolean ib_singlerow = true
end type

on drag_it;If Message.WordParm = 1 Then
 If GetSelectedRow(this,0) > 0 Then
  Drag(This, Begin!)
 End If
End If
//KMM Clear out message parm (PB Bug)
SetNull(message.wordparm)
end on

event dragdrop;parent.wf_remove_row()
end event

event rowfocuschanged;//  Rowfocuschanged for dw_1
// 01/31/06 HYL Track 4339d Call ancestor script of rowfocuschanged event so that multiple rows can be selected

long lv_row

lv_row = dw_1.getrow()
//  This logic insures that a row is highlighted after another row is deleted from the dw.
if lv_row > dw_1.rowcount() then
	lv_row = dw_1.rowcount()
   parent.wf_reset_counts()
end if

Super::EVENT RowFocusChanged(currentrow) // 01/31/06 HYL Track 4339d
end event

event doubleclicked;parent.wf_add_row()
	
end event

on retrieveend;int rc

rc = setrow(1)

end on

event retrievestart;//  retrievestart event for DW_1 on W_SUBSET_COLS

setpointer(hourglass!)
//  Reset "stop" switch at the start of the retrieve.
gv_cancel_but_clicked = FALSE

//  Do not reset DW and dw buffers prior to retrieving from the DB.
//  This allows retrieval from multiple tables into the same dw.
Return 2

end event

event constructor;call super::constructor;// 01/31/06 	HYL	Track 4339d	Allow user to select more than a row
This.of_multiselect(TRUE)
This.of_singleselect(FALSE)
end event

type dw_2 from u_dw within w_subset_summary_analysis
string accessiblename = "Selected Fields List"
string accessibledescription = "Selected Fields List"
accessiblerole accessiblerole = clientrole!
event drag_it pbm_mousemove
string tag = "title = Selected Fields"
integer x = 1669
integer y = 572
integer width = 1399
integer height = 1304
integer taborder = 90
string dragicon = "ROWS.ICO"
string dataobject = "d_avail_columns"
boolean vscrollbar = true
boolean ib_singleselect = true
boolean ib_isupdateable = false
boolean ib_singlerow = true
end type

on drag_it;If Message.WordParm = 1 Then
 If GetSelectedRow(this,0) > 0 Then
  Drag(This, Begin!)
 End If
End If
//KMM Clear out message parm (PB Bug)
SetNull(message.wordparm)
end on

event dragdrop;
il_droprow = row // 01/31/06 HYL Track 4339d Locate where to drop dragged rows.
parent.wf_add_row()


end event

on getfocus;dw_1.SelectRow(0,FALSE)
end on

event rowfocuschanged;//  Rowfocuschanged for dw_1
// // 01/31/06 HYL Track 4339d Call ancestor script of rowfocuschanged event so that multiple rows can be selected

long lv_row

lv_row = dw_1.getrow()
//  This logic insures that a row is highlighted after another row is deleted from the dw.
if lv_row > dw_2.rowcount() then
	lv_row = dw_2.rowcount()
   st_selected.text = String(lv_row)
end if

Super::EVENT RowFocusChanged(currentrow) // 01/31/06 HYL Track 4339d

end event

event doubleclicked;parent.wf_remove_row()
end event

event constructor;call super::constructor;// 01/31/06 	HYL	Track 4339d	Allow user to select more than a row
This.of_multiselect(TRUE)
This.of_singleselect(FALSE)
end event

type cb_close from u_cb within w_subset_summary_analysis
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2706
integer y = 2004
integer width = 384
integer height = 108
integer taborder = 120
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "Cl&ose"
end type

on clicked;
close(parent)
end on

type st_1 from statictext within w_subset_summary_analysis
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 72
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID:"
end type

type gb_1 from groupbox within w_subset_summary_analysis
string accessiblename = "Choose Summary Fields"
string accessibledescription = "Choose Summary Fields"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer y = 444
integer width = 3081
integer height = 1528
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Choose Summary Fields"
end type

type gb_2 from groupbox within w_subset_summary_analysis
string accessiblename = "Summary Options"
string accessibledescription = "Summary Options"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer width = 3081
integer height = 432
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Summary Options"
end type

