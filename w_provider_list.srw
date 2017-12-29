HA$PBExportHeader$w_provider_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_provider_list from w_master_list
end type
end forward

global type w_provider_list from w_master_list
string accessiblename = "Provider List"
string accessibledescription = "Provider  List"
integer width = 4110
integer height = 3980
string title = "Provider List"
boolean ib_display_details = true
end type
global w_provider_list w_provider_list

type variables
// 07/10/07	Katie SPR 5108 Added new decode structure
// 08/01/07 Katie SPR 5132 Added variables for the lookup codes for prov_spec and prov_type


String is_pv_tbl_type, is_np_tbl_type
String is_prov_id, is_prov_upin, is_prov_npi
String is_sql_columns
String is_prov_type_code = '', is_prov_spec_code = ''
sx_decode_structure iv_decode_struct
n_cst_decode inv_decode
long  il_decode_idx = 0
end variables

forward prototypes
public function string of_get_list_select ()
public function string wf_format_search_criteria (string as_field_value, string as_field_name, string as_tbl_type)
public function integer of_set_decode_struct (string as_inv_type, string as_db_col_name)
public function any uf_get_select_all_sort (string as_tbl_type, boolean ab_prefix, boolean ab_disp_seq_sort)
end prototypes

public function string of_get_list_select ();// 07/10/07 Katie SPR5108d Added logic to populate the Decode Structure

String ls_sql, ls_columns[], ls_desc
long ll_tot_col_num, ll_row, ll_pos
n_cst_string inv_string
int li_crit_seq

ls_desc = gnv_dict.event ue_get_col_desc(is_pv_tbl_type,  "PROV_ID")
ls_sql =  is_pv_tbl_type + ".PROV_ID as ~"" + is_pv_tbl_type  + " " + ls_desc + "~""
of_set_decode_struct(is_pv_tbl_type,  "PROV_ID")
li_crit_seq = gnv_dict.event ue_get_crit_seq (is_pv_tbl_type, "PROV_UPIN")
if (li_crit_seq > 0) then 
	ls_desc = gnv_dict.event ue_get_col_desc(is_pv_tbl_type,  "PROV_UPIN")
	ls_sql =  ls_sql + "," + is_pv_tbl_type + ".PROV_UPIN as ~"" + is_pv_tbl_type  + " " + ls_desc + "~""
	of_set_decode_struct(is_pv_tbl_type,  "PROV_UPIN")
end if
li_crit_seq = gnv_dict.event ue_get_crit_seq (is_np_tbl_type, "PROV_NPI")
if (gv_npi_cntl > 0 and li_crit_seq > 0) then 
	ls_desc = gnv_dict.event ue_get_col_desc(is_np_tbl_type,  "PROV_NPI")	
	ls_sql = ls_sql + "," + is_np_tbl_type + ".PROV_NPI as ~"" + is_np_tbl_type  + " " + ls_desc + "~""
	of_set_decode_struct(is_np_tbl_type,  "PROV_NPI")
end if 

if (gv_from <> 'NPI') then 
	ls_columns = gnv_dict.uf_get_col_array( is_pv_tbl_type, TRUE)
	ll_tot_col_num = upperbound(ls_columns)
	FOR  ll_row  =  1  TO  ll_tot_col_num		
		if (ls_columns[ll_row] <> is_pv_tbl_type +'.PROV_ID' and ls_columns[ll_row] <> is_pv_tbl_type +'.PROV_UPIN') then
			ll_pos = Pos(ls_columns[ll_row], ".")
			ls_desc = gnv_dict.event ue_get_col_desc(Left(ls_columns[ll_row],2), Mid(ls_columns[ll_row], ll_pos + 1))
			ls_sql = ls_sql + "," + ls_columns[ll_row] + " as ~"" + is_pv_tbl_type  + " " + ls_desc + "~""
			of_set_decode_struct(is_pv_tbl_type, mid(ls_columns[ll_row], 4))
		end if
	Next
end if

if (gv_npi_cntl > 0) then 
	ls_columns = gnv_dict.uf_get_col_array( is_np_tbl_type, TRUE)
	ll_tot_col_num = upperbound(ls_columns)
	FOR  ll_row  =  1  TO  ll_tot_col_num		
		if (ls_columns[ll_row] <> is_np_tbl_type +'.PROV_ID' and ls_columns[ll_row] <> is_np_tbl_type +'.PROV_NPI') then
			ll_pos = Pos(ls_columns[ll_row], ".")
			ls_desc = gnv_dict.event ue_get_col_desc(Left(ls_columns[ll_row],2), Mid(ls_columns[ll_row], ll_pos + 1))
			ls_sql = ls_sql + "," + ls_columns[ll_row] + " as ~"" + is_np_tbl_type  + " " + ls_desc + "~""
			of_set_decode_struct(is_np_tbl_type, mid(ls_columns[ll_row], 4))
		end if
	Next
end if 

if (gv_from = 'NPI') then 
	ls_columns = gnv_dict.uf_get_col_array( is_pv_tbl_type, TRUE)
	ll_tot_col_num = upperbound(ls_columns)
	FOR  ll_row  =  1  TO  ll_tot_col_num		
		if (ls_columns[ll_row] <> is_pv_tbl_type +'.PROV_ID' and ls_columns[ll_row] <> is_pv_tbl_type +'.PROV_UPIN') then
			ll_pos = Pos(ls_columns[ll_row], ".")
			ls_desc = gnv_dict.event ue_get_col_desc(Left(ls_columns[ll_row],2), Mid(ls_columns[ll_row], ll_pos + 1))
			ls_sql = ls_sql + "," + ls_columns[ll_row] + " as ~"" + is_pv_tbl_type  + " " + ls_desc + "~""
			of_set_decode_struct(is_pv_tbl_type, mid(ls_columns[ll_row], 4))
		end if
	Next
end if

is_sql_columns = ls_sql
return ls_sql
end function

public function string wf_format_search_criteria (string as_field_value, string as_field_name, string as_tbl_type);//
// wf_format_search_criteria
//	arguments:
//		as_field_value - value retrieved from dw_search
//		as_field_name - field name in the provider table
//	returns:
//		formated string to be used in the where clause
//
//************************************************************\
//	Katie	03/23/07	SPR 4961


If as_field_value <> "" then
	if (Pos(as_field_value,'%') > 0) then
		return " and " + as_tbl_type + "." + as_field_name +  " like '" + as_field_value + "' "
	else
		return " and " + as_tbl_type + "." + as_field_name + " = '" + as_field_value + "' "
	end if
End if	

return ''
end function

public function integer of_set_decode_struct (string as_inv_type, string as_db_col_name);// 07/10/07 Katie SPR5108d Populate tbe Decode structure for the given column

String ls_col_name = 'COMPUTE_0000'

il_decode_idx = il_decode_idx+1

ls_col_name = left(ls_col_name, 12 - len(string(il_decode_idx))) + string(il_decode_idx)

iv_decode_struct.col_name			[il_decode_idx] = ls_col_name
iv_decode_struct.col_lookup_type	[il_decode_idx] = gnv_dict.event ue_get_lookup_type		(as_inv_type, as_db_col_name)
iv_decode_struct.col_len			[il_decode_idx] = string(gnv_dict.event ue_get_data_len	(as_inv_type, as_db_col_name))
iv_decode_struct.data_type			[il_decode_idx] = gnv_dict.event ue_get_elem_data_type	(as_inv_type, as_db_col_name)

iv_decode_struct.db_col_name[il_decode_idx] = as_db_col_name

return 1
end function

public function any uf_get_select_all_sort (string as_tbl_type, boolean ab_prefix, boolean ab_disp_seq_sort);return ''
end function

on w_provider_list.create
int iCurrent
call super::create
end on

on w_provider_list.destroy
call super::destroy
end on

event ue_set_list_sql;call super::ue_set_list_sql;//=======================================================================================//
//	Object:			w_provider_list
//	Event:			ue_set_list_sql
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Creates list SQL based on values on dw_search
//---------------------------------------------------------------------------------------//
//	* Creates
//=======================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------
//	12/07/06 Katie Created
//	08/14/07 Katie SPR 5135 Added more intelligence into the SQL generation in order to increase efficiency.
//	08/15/07	Katie SPR 5135 Adjusted logic for non-NPI environments.
//	05/28/2010	Katie SPR 5518	Added logic to include tax_id in the search criteria.  
//=======================================================================================//

Boolean lb_is_crit_valid, lb_full = false, lb_left_a = false /*PROVIDERS*/, lb_left_b = false/*NPI*/
String ls_sql, ls_case_id, ls_case_spl, ls_case_ver, ls_order, ls_dict_ordered_columns, ls_field_value
String ls_full_where_a, ls_full_where_b, ls_where
long ll_search_row, ll_pos

dw_search.accepttext( )
if (is_sql_columns <> "") then
	ls_sql = "SELECT " + is_sql_columns
else 
	ls_sql = "SELECT " + of_get_list_select()
end if

lb_is_crit_valid = event ue_validate_criteria()

ll_search_row = dw_search.getrow()

ls_where = ""

if lb_is_crit_valid then
	//	PROV_ID - FULL JOIN
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_id"))
	If  (gv_npi_cntl > 0) then
		if ls_field_value <> "" then
			lb_full = true
			if (Pos(ls_field_value,'%') > 0) then
				ls_full_where_a = ls_full_where_a + " and " + is_pv_tbl_type + ".PROV_ID like '" + ls_field_value  + "' "
				ls_full_where_b = ls_full_where_b + " and " + is_np_tbl_type + ".PROV_ID like '" + ls_field_value  + "' " 
			else 
				ls_full_where_a = ls_full_where_a + " and " + is_pv_tbl_type + ".PROV_ID = '" + ls_field_value  + "' "
				ls_full_where_b = ls_full_where_b + " and " + is_np_tbl_type + ".PROV_ID = '" + ls_field_value  + "' " 
			end if
		end if
	else // NO JOIN - ADD TO GENERAL WHERE FOR PROVIDERS
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value,"PROV_ID", is_pv_tbl_type)
	End if
	// PROV_NAME - FULL JOIN
	ls_field_value =  trim(dw_search.GetItemString(ll_search_row, "prov_name"))
	if (gv_npi_cntl > 0) then
		If ls_field_value <> "" then
			lb_full = true
			if (Pos(ls_field_value,'%') > 0) then
				ls_full_where_a = ls_full_where_a + " and " + is_pv_tbl_type + ".PROV_NAME like '" + ls_field_value  + "' "
				ls_full_where_b = ls_full_where_b + " and " + is_np_tbl_type + ".PROV_NPI_NAME like '" + ls_field_value  + "' " 
			else
				ls_full_where_a = ls_full_where_a + " and " + is_pv_tbl_type + ".PROV_NAME = '" + ls_field_value  + "' "
				ls_full_where_b = ls_full_where_b + " and " + is_np_tbl_type + ".PROV_NPI_NAME = '" + ls_field_value  + "' " 
			end if
		end if
	else // NO JOIN - ADD TO GENERAL WHERE FOR PROVIDERS	
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_NAME", is_pv_tbl_type)
	End if
	// PROV_NPI - LEFT ON PROV_NPI_XREF
	if (gv_npi_cntl > 0) then 
		ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_npi"))
		if (ls_field_value <> "") then 
			lb_left_b = true
			ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_NPI", is_np_tbl_type)
		end if
	end if
	// PROV_UPIN - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_upin"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_UPIN", is_pv_tbl_type)
	end if
	// PROV_CITY - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_city"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_CITY", is_pv_tbl_type)
	end if
	// PROV_STATE - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_state"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_STATE", is_pv_tbl_type)
	end if
	// PROV_ZIP - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_zip"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_ZIP", is_pv_tbl_type)
	end if
	// PROV_COUNTY - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_county"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_COUNTY", is_pv_tbl_type)
	end if
	// PROV_LOCALITY - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_locality"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_LOCALITY", is_pv_tbl_type)
	end if
	// PROV_FACI_IND - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_faci_ind"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_FACI_IND", is_pv_tbl_type)
	end if
	// PROV_TYPE - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_type"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value, "PROV_TYPE", is_pv_tbl_type)
	end if
	// PROV_SPEC - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "prov_spec"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value,"PROV_SPEC", is_pv_tbl_type)
	end if
	// TAX_ID - LEFT ON PROVIDERS
	ls_field_value = trim(dw_search.GetItemString(ll_search_row, "tax_id"))
	if (ls_field_value <> "") then 
		lb_left_a = true
		ls_where = ls_where + wf_format_Search_criteria(ls_field_value,"TAX_ID", is_pv_tbl_type)
	end if
if (gv_npi_cntl > 0) then	
	if (lb_full and not (lb_left_a or lb_left_b)) then //FULL W/O GENERAL CRITERIA
		ll_pos = Pos (ls_full_where_a, "and")
		if (ll_pos > 0) then ls_full_where_a = Trim(Mid(ls_full_where_a, ll_pos + 3))
		ll_pos = Pos (ls_full_where_b, "and")
		if (ll_pos > 0) then ls_full_where_b = Trim(Mid(ls_full_where_b, ll_pos + 3))
		ls_sql = gnv_sql.of_full_outer_join( is_sql_columns,ls_full_where_a,"PROVIDERS", "PROV_ID", is_pv_tbl_type,ls_full_where_b,"PROV_NPI_XREF","PROV_ID",is_np_tbl_type)
	elseif (lb_full) then //FULL W GENERAL CRITERIA
		ll_pos = Pos (ls_full_where_a, "and")
		if (ll_pos > 0) then ls_full_where_a = Trim(Mid(ls_full_where_a, ll_pos + 3))
		ll_pos = Pos (ls_full_where_b, "and")
		if (ll_pos > 0) then ls_full_where_b = Trim(Mid(ls_full_where_b, ll_pos + 3))
		ll_pos = Pos (ls_where, "and")
		if (ll_pos > 0) then ls_where = Trim(Mid(ls_where, ll_pos + 3))		
		ls_sql = gnv_sql.of_full_outer_join( is_sql_columns,ls_full_where_a,"PROVIDERS", "PROV_ID", is_pv_tbl_type,ls_full_where_b,"PROV_NPI_XREF","PROV_ID",is_np_tbl_type, ls_where)
	elseif (lb_left_a and lb_left_b) then //GENERAL CRITERIA ON BOTH TABLES
		ll_pos = Pos (ls_where, "and")
		if (ll_pos > 0) then ls_where = Trim(Mid(ls_where, ll_pos + 3))
		ls_sql = gnv_sql.of_full_outer_join( is_sql_columns,ls_where,"PROVIDERS", "PROV_ID", is_pv_tbl_type,"PROV_NPI_XREF","PROV_ID",is_np_tbl_type)
	elseif (lb_left_a) then //GENERAL CRITERIA ON PROVIDERS ONLY
		ll_pos = Pos (ls_where, "and")
		if (ll_pos > 0) then ls_where = Trim(Mid(ls_where, ll_pos + 3))
		ls_sql = ls_sql + " FROM PROVIDERS " + is_pv_tbl_type  + " LEFT OUTER JOIN PROV_NPI_XREF " + is_np_tbl_type + &
			" ON " + is_pv_tbl_type + ".PROV_ID = " + is_np_tbl_type + ".PROV_ID WHERE " + ls_where
	elseif(lb_left_b) then //GENERAL CRITERIA ON PROV_NPI_XREF
		ll_pos = Pos (ls_where, "and")
		if (ll_pos > 0) then ls_where = Trim(Mid(ls_where, ll_pos + 3))
		ls_sql = ls_sql + " FROM PROV_NPI_XREF " + is_np_tbl_type  + " LEFT OUTER JOIN PROVIDERS " + is_pv_tbl_type + &
			" ON " + is_pv_tbl_type + ".PROV_ID = " + is_np_tbl_type + ".PROV_ID WHERE " + ls_where
	else 
		ls_sql = is_orig_list_sql
	end if
else
	if (trim(ls_where) <> "") then
		ll_pos = Pos (ls_where, "and")
		if (ll_pos > 0) then ls_where = Trim(Mid(ls_where, ll_pos + 3))
		ls_sql = ls_sql + " FROM PROVIDERS " + is_pv_tbl_type +  " WHERE " + ls_where
	else
		ls_sql = ls_sql + " FROM PROVIDERS " + is_pv_tbl_type
	end if
end if	

	IF gnv_sql.of_SetRowLimitMultiTable( ls_sql, 2500, Stars2ca ) < 1 THEN
		MessageBox( 'Database Error', 'Could not set the row count in provider code list' )	
		Return false
	END IF
	
	dw_list.SETSQLSelect(ls_sql)
	return true
else
	return false
end if
end event

event open;call super::open;//=======================================================================================//
//	Object:			w_provider_list
//	Event:			open
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Open event for List windows
//---------------------------------------------------------------------------------------//
//	* Retrieves List window
//=======================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------
//	12/07/06 Katie Created
//	02/05/07	GaryR	Track 4888	Add row count and formatting
//	04/06/07	Katie	SPR 4972 Added close call if the ue_retrieve for search 
//						criteria passed to the window returns 0 rows.
//  07/10/07 Katie SPR 5108 Override the decode structure with one generated during SQL creation
//						Populate the iv_decode_structure with the table_types.
//	08/01/07 Katie SPR 5132 Get lookup values for PT and SP from DICTIONARY.
//	08/03/07	Katie	SPR 5108 Converted dw_list units to pixels and adjusted the header, detail and footer heights.
//	10/20/09	GaryR	ACC.650.5786.001	Provide alternative color scheme for lookup and indexed fields
//	05/28/2010	Katie	SPR 5815	Added code to check to see if tax_id is included in this instance.  If it is not then adjust
//						the search and detail datawindows to remove the tax_id.
//
//=======================================================================================//

int	li_rc, li_cnt, li_ret_cnt
String lv_syntax, lv_style, lv_error, ls_col_name, ls_mod
String ls_prov_type_code, ls_prov_spec_code

is_orig_list_sql = ""

// Get table types from dictionary and store in decode structure
is_pv_tbl_type = gnv_dict.event ue_get_table_type("PROVIDERS")
iv_decode_struct.table_type[1] = is_pv_tbl_type
if (gv_npi_cntl > 0) then 
	is_np_tbl_type = gnv_dict.event ue_get_table_type("PROV_NPI_XREF")
	iv_decode_struct.table_type[2] = is_np_tbl_type
end if
// List
lv_style = 'datawindow(units=1 )' &
     + 'style(type = grid)'  +  'Column(font.Face=~'Microsoft Sans Serif~') ' &
     +  'Text(font.Face=~'Microsoft Sans Serif~') '
is_orig_list_sql = of_get_list_select()
if (gv_npi_cntl > 0) then 
	is_orig_list_sql = gnv_sql.of_full_outer_join( is_orig_list_sql,"","PROVIDERS", "PROV_ID", is_pv_tbl_type,"PROV_NPI_XREF","PROV_ID",is_np_tbl_type)
else
	is_orig_list_sql = "SELECT " + 	is_orig_list_sql + " FROM PROVIDERS " + is_pv_tbl_type
end if
lv_syntax = SyntaxFromSQL(Stars2ca,is_orig_list_sql,lv_style,lv_error)
if lv_error <> '' then
   messagebox('EDIT','Error building information for report. Error message = ' + lv_error,exclamation!)
	this.SetRedraw (TRUE)					// FDG 04/01/96
   return
end if

li_rc = dw_list.Create(lv_syntax)

//	Set column/text properties
li_cnt = Integer( dw_list.Object.DataWindow.Column.Count )
FOR li_rc = 1 TO li_cnt
	// Get the object name from the datawindow
	ls_col_name 	= 	dw_list.Describe('#' + string(li_rc) + '.name')
	ls_mod += ls_col_name + ".Font.Height='-8' " + ls_col_name + "_t.Height='40' " + &
				ls_col_name + "_t.Border='4' " + ls_col_name + "_t.Color='" + String( stars_colors.highlight ) + "' " + &
				ls_col_name + "_t.Font.Height='-8' " + ls_col_name + "_t.Font.Weight='700' "
NEXT

//	Set band heights
dw_list.Object.DataWindow.Header.Height= "40"
dw_list.Object.DataWindow.Detail.Height= "20"
dw_list.Object.DataWindow.Footer.Height= "20"

//	Add row counter to footer
ls_mod += 'create compute(band=footer alignment="0" expression="rowcount() ' + &
					'+ ~' rows~'" border="0" color="' + String( stars_colors.window_text ) + '" x="9" y="4" height="52" ' + &
					'width="293" format="[GENERAL]" html.valueishtml="0" ' + &
					'name=compute_ctr visible="1"  font.face="Microsoft Sans Serif" ' + &
					'font.height="-8" font.weight="700"  font.family="2" font.pitch="2" ' + &
					'font.charset="0" background.mode="2" background.color="' + String( stars_colors.window_background ) + '" )'
					
dw_list.Modify( ls_mod )			

li_rc = fx_dw_syntax(this.classname(), dw_list, istr_decode_struct, stars2ca) 
dw_list.SetTransObject( Stars2ca )
dw_list.of_SetUpdateable( FALSE )

//Override default Decode Structure
istr_decode_struct = iv_decode_struct
inv_decode.of_set_decode_struct(istr_decode_struct)

// Set print dw
idw_print = dw_list

//Determine if table definition includes TAX_ID, if not hide boxes/labels in search and details
if not (Pos(is_orig_list_sql,".TAX_ID as") > 0) then
	dw_search.Modify("tax_id.Visible=0 tax_id_t.Visible=0 ")
	dw_details.Modify("tax_id.Visible=0 tax_id_t.Visible=0 ")
	dw_details.Modify("DataWindow.Table.Select='SELECT providers.prov_id, providers.prov_upin, :as_prov_npi, providers.prov_name, providers.prov_address1, "  &
		+ "providers.prov_city, providers.prov_state, providers.prov_zip, providers.prov_county, " &
		+ "providers.prov_locality, providers.prov_faci_ind, providers.prov_spec, providers.prov_type, null as tax_id " &
		+ "FROM providers " &
		+ "where providers.prov_id = :as_prov_id'")
end if


// Retrieve SP and PT lookup types from DICTIONARY.  If not available then turn boxes back to white.
if (is_prov_type_code = '') then 
	ls_prov_type_code = gnv_dict.event ue_get_lookup_type(is_pv_tbl_type, 'PROV_TYPE')
	if (trim(ls_prov_type_code) <> '') then
		is_prov_type_code = ls_prov_type_code  
	else //Not defined in DICTIONARY remove LOOKUP color
		dw_search.Modify("prov_type.Background.Color=" + String( stars_colors.window_background ))
	end if
end if
if (is_prov_spec_code = '') then 
	ls_prov_spec_code = gnv_dict.event ue_get_lookup_type(is_pv_tbl_type, 'PROV_SPEC')
	if (trim(ls_prov_spec_code) <> '') then
		is_prov_spec_code = ls_prov_spec_code
	else //Not defined in DICTIONARY remove LOOKUP color
		dw_search.Modify("prov_spec.Background.Color=" + String( stars_colors.window_background ))
	end if
end if
	
if (gv_from = 'PV') or (gv_from = 'NPI') or (gv_from = 'UP') then
	if (this.event ue_retrieve_list() = 0) then
		cb_close.event clicked( )
	end if
end if
end event

event ue_retrieve_detail;call super::ue_retrieve_detail;//=============================================================================================//
// Object		w_provider_list
// Event			ue_retrieve_detail
// Parameters	al_row (long) - Selected row in dw_list
// Returns		None
//=============================================================================================//
// Sets instance variables then Retrieves dw_details 
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 12/07/06 Katie SPR4758d	Created
// 07/10/07 Katie SPR5108d Trim the NPI and PROV ID in case they happen to be decoded.
//	08/03/07	Katie	SPR 5108d Return 1 instead of dw_detail.clear() to prevent error message popping up when no prov_id provided.
//=============================================================================================//

int li_pos
is_prov_id 		= dw_list.getitemstring(al_row, 1)
li_pos = Pos(is_prov_id, '-')
if (li_pos > 0) then
	is_prov_id = trim(left(is_prov_id,li_pos - 1))
end if

if (gv_npi_cntl > 0) then
	is_prov_npi	= dw_list.getitemstring(al_row, 3)
	li_pos = Pos(is_prov_npi, '-')
	if (li_pos > 0) then
		is_prov_npi = trim(left(is_prov_npi,li_pos - 1))
	end if
end if

if (is_prov_id = '' or IsNull(is_prov_id)) then 
	dw_details.clear()
	return 1
else 
	RETURN dw_details.Retrieve( is_prov_id, is_prov_npi)
end if

RETURN 1
end event

event ue_retrieve_search;call super::ue_retrieve_search;// Prepares dw_search
// * Add Provider ID, UPIN or NPI
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 12/26/	2006 Katie	SPR4319d	Created
//=============================================================================================//
DataWindowChild 	ldwc_search
int					i

//Populate search criteria
CHOOSE CASE gv_from
	
	CASE 'PV'
		
		dw_search.GetChild( "prov_id", ldwc_search )
		i = ldwc_search.InsertRow( 1 )
		dw_search.SetItem( 1, "prov_id", gv_prov_id )
		
	CASE 'UP'
		
		dw_search.GetChild( "prov_upin", ldwc_search )
		i = ldwc_search.InsertRow( 1 )
		dw_search.SetItem( 1, "prov_upin", gv_prov_upin )
		
	CASE 'NPI'
		
		dw_search.GetChild( "prov_npi", ldwc_search )
		i = ldwc_search.InsertRow( 1 )
		dw_search.SetItem( 1, "prov_npi", gv_prov_npi )
		
END CHOOSE
end event

event ue_postopen;call super::ue_postopen;//	Katie	SPR 4961	Removed option to decode in Provider List.
// 07/10/07 Katie SPR 5108 Readded ability to decode this window

//Turn off Prov_NPI in Search Window
if gv_npi_cntl = 0 then
	dw_details.Object.prov_npi.visible = "0"
	dw_details.Object.prov_npi_t.visible = "0"
	dw_search.Object.prov_npi.visible = "0"
	dw_search.Object.prov_npi_t.visible = "0"
end if
end event

type cb_close from w_master_list`cb_close within w_provider_list
integer y = 1516
integer taborder = 50
end type

type uo_range from w_master_list`uo_range within w_provider_list
end type

type st_dw_ops from w_master_list`st_dw_ops within w_provider_list
integer y = 1532
end type

type cb_delete from w_master_list`cb_delete within w_provider_list
boolean visible = false
integer taborder = 90
end type

type cb_reset from w_master_list`cb_reset within w_provider_list
boolean visible = false
integer taborder = 70
end type

type cb_add from w_master_list`cb_add within w_provider_list
boolean visible = false
integer taborder = 60
end type

type dw_details from w_master_list`dw_details within w_provider_list
integer x = 37
integer y = 1696
integer width = 3291
integer height = 416
integer taborder = 0
string dataobject = "d_provider_detail"
end type

type st_rows from w_master_list`st_rows within w_provider_list
end type

type cb_update from w_master_list`cb_update within w_provider_list
boolean visible = false
integer taborder = 80
end type

type cb_list from w_master_list`cb_list within w_provider_list
end type

type dw_list from w_master_list`dw_list within w_provider_list
integer x = 0
integer y = 544
integer width = 3365
integer height = 960
string title = "Provider List"
string dataobject = "d_initial"
boolean hsplitscroll = true
end type

event dw_list::ue_retrieve;call super::ue_retrieve;//	05/11/07	GaryR	Track 5008	Remove obsolete logic

int		li_rc

li_rc = dw_list.retrieve()
	
IF gnv_sql.of_SetRowLimitMultiTable( is_sql_columns, 0, Stars2ca ) < 1 THEN
	MessageBox( 'Database Error', 'Could not set the row count in provider code list' )	
END IF
	
IF li_rc >= 2500 THEN	MessageBox( "Warning", "The maximum number of rows limit was reached" + &
																	"~n~rMore rows match your query than are displayed", Exclamation! )
return li_rc
end event

event dw_list::rowfocuschanged;call super::rowfocuschanged;///////////////////////////////////////////////////////////////////////////
//
//	12/27/2006	Katie Created
// 	07/11/07	 	Katie	SPR 5108 Extended ancestor script to handle row focus changes
///////////////////////////////////////////////////////////////////////////

Long		ll_row


ll_row = dw_list.GetRow()

IF ll_row < 1 THEN Return

IF ib_display_details THEN	
	dw_details.SetRedraw(FALSE)	
	parent.event ue_retrieve_detail( ll_row )
	dw_details.SetRedraw(TRUE)
END IF	
	
// Enable update / add stuff.
parent.event ue_row_access( )
end event

event dw_list::rbuttondown;call super::rbuttondown;// Katie	07/11/07	SPR 5108 Add logic for RMM on dw_list

Setpointer(Hourglass!)

inv_decode.of_display_rm_lookup(dw_list)


end event

type dw_search from w_master_list`dw_search within w_provider_list
integer width = 2981
integer height = 352
string dataobject = "d_provider_search"
end type

event dw_search::ue_lookup;call super::ue_lookup;// Katie	03/23/07 SPR 4954	Set gv_from = '' to prevent w_code_lookup.cb_use from being disabled.
// Katie	08/01/07 SPR 5136	Retrieve PROV_TYPE and PROV_SPEC lookup types from dictionary.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

String ls_prov_type_code, ls_prov_spec_code

gv_from = ''

CHOOSE CASE Lower( as_col )
	CASE 'prov_type'
		if (is_prov_type_code <> '') then 
			setpointer(hourglass!)
			gv_code_to_use = is_prov_type_code
			open(w_code_lookup)
		end if
		if gv_code_to_use <> '' Then
			This.object.prov_type[1] = gv_code_to_use
		end if
	CASE 'prov_spec'
		if (is_prov_spec_code <> '') then 
			setpointer(hourglass!)
			gv_code_to_use = is_prov_spec_code
			open(w_code_lookup)
		end if
		if gv_code_to_use <> '' Then
			This.object.prov_spec[1] = gv_code_to_use
		end if
END CHOOSE
end event

type gb_details from w_master_list`gb_details within w_provider_list
integer x = 0
integer y = 1632
integer width = 3365
integer height = 492
end type

type ddlb_dw_ops from w_master_list`ddlb_dw_ops within w_provider_list
integer y = 1516
integer taborder = 40
end type

event ddlb_dw_ops::selectionchanged;call super::selectionchanged;// 07/10/07 Katie SPR 5108 Set invoice type for decode

iw_uo_win.uo_decode.of_set_invoice_type( "PV")
end event

type gb_2 from w_master_list`gb_2 within w_provider_list
integer width = 3031
end type

