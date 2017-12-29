HA$PBExportHeader$u_nvo_view.sru
$PBExportComments$Inherited from u_nvo_query <logic>
forward
global type u_nvo_view from u_nvo_query
end type
end forward

global type u_nvo_view from u_nvo_query
event type string ue_tabpage_view_translate_invoice_type ( ref string as_inv_type )
event ue_tabpage_view_view_claim ( )
event type integer ue_tabpage_view_get_key_columns ( )
event type string ue_tabpage_view_create_ml_dw_sql ( )
event type string ue_tabpage_view_break_with_totals ( ref n_tr at_trans,  ref string as_sql,  ref string as_style )
event type integer ue_tabpage_view_break_get_total_columns ( readonly string as_type,  readonly sx_selected_cols astr_cols[],  ref sx_total_cols astr_total_cols[] )
event type sx_break_col_info ue_tabpage_view_break_get_col_info ( ref string as_syntax,  ref string as_col_name,  ref string as_data_type,  sx_selected_cols astr_selected_cols[] )
event type integer ue_tabpage_view_create_report ( )
event ue_tabpage_view_list ( string as_type )
event type long ue_tabpage_view_unique_count ( string as_type )
event ue_tabpage_view_mapping ( )
event type long ue_tabpage_view_unique_counts_rev ( )
event ue_tabpage_view_detail ( )
event type string ue_tabpage_view_prov_pat_drilldown ( string as_tag_value )
event type integer ue_drilldown_build_temp_table ( ref sx_drilldown atr_drilldown )
event type integer ue_tabpage_view_stats ( )
end type
global u_nvo_view u_nvo_view

type variables
// Constants
Constant	String	ics_report = 'REPORT',	&
		ics_find = 'Find',		&
		ics_save = 'S',		&
		ics_saveas = 'A',		&
		ics_providers = 'PROVIDERS', &
		ics_enrollee = 'ENROLLEE',	&
		ics_patients = 'PATIENTS',	&
		ics_icn = 'ICN',		&
		ics_revenue = 'REVENUE',	&
		ics_patsrvc = 'PATSRVC',	&
		ics_create = 'CREATE',	&
		ics_subset = 'SUBSET',	&
		ics_id = 'id',		&
		ics_ignore_dup_key = 'I',	&
		ics_prov_id = 'prov_id',	&
		ics_revenue_code = 'revenue_code', &
		ics_recip_id = 'recip_id'

// Dictionary datastore
n_ds		ids_dictionary

// Previous invoice type used to retrieve dictionary
String		is_prev_inv_type

//Table types in ML subset
string is_tbl_types[]

// FDG 03/14/01 - NVO containing the base table names used in a query (N/A for subsets
//						and ancillary tables)
n_cst_tableinfo_attrib	inv_base
end variables

forward prototypes
public function integer uf_find_column_number (string as_col_name)
public function integer uf_add_column_headings ()
public function integer uf_get_excluded_totals_columns (ref string as_cols[])
public function string uf_get_inv_type ()
public function boolean uf_check_unique_key (string as_unique_col_name)
public function integer uf_getmaxcolumnlengths ()
public subroutine uf_add_title ()
end prototypes

event ue_tabpage_view_translate_invoice_type;//*********************************************************************************
// Event Name:	UE_Tabpage_View_Translate_Invoice_Type
//	Arguments:	String	as_inv_type
// Returns:		String
//
//This event will be called by multiple tabpage_view events to resolve the table 
//type using invoice type.  If the data source is "MC" and if want to perform some 
//functionality (view claim, details) on one claim must get the invoice type from 
//the datawindow and go against the code table to determine table type.
//*********************************************************************************
// 12-03-97 FNC	Created
//	02/04/98	FDG	Check the status using of_check_status()
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
//*********************************************************************************
string ls_inv_type

Select code_value_a
Into :ls_inv_type
From Code
Where Code_Type = 'IT' and Code_Code = Upper( :as_inv_type )
Using Stars2ca;

if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Cannot retrieve invoice type for claim')
	return 'ERROR'
else												// FNC 04/14/99
	stars2ca.of_commit()						// FNC 04/14/99
end if

return ls_inv_type
end event

event ue_tabpage_view_view_claim;//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_View_Claim
//	Arguments:	None
// Returns:		None
//
//*********************************************************************************
// 12-24-97 FNC Created
//*********************************************************************************

/*This event will be called by im_view.m_claimoperations.m_viewclaim to 
allow the user to view the entire claim of the selected row in the 
data window.  
The code for this will be taken from w_claim_rpt_parent.wf_viewclaim().  
It must load a structure (sx_details_structure) with certain fields and 
open w_view_claim with the structure as a parm.*/

//*************************************************************************
//
//	FNC	11/26/97	Adapted from W_Claim_Rpt_Parent.WF_View_Claim
//	FDG	06/15/97	Track ????.  Don't directly access uo_query attributes.
// AJS	09/03/98	Track 1575. Need to resolve invoice type for ML subsets.
// FNC	02/08/00	Track 2072 - Unique key. Provide users with flexibility
//						to specify their own claim keys.
//	FDG	03/14/01	Stars 4.7.	Remove table_no since that depends on ros_directory.
//										ros_directory no longer exists in this release.
//	FDG	04/10/01	Stars 4.7.	If w_view_claim is already open, close it.  This will
//						avoid confusion in case the user forgets to close out w_view_claim.
//	GaryR	07/09/01	Track 2359D Add payment date to where clause 
//						to avoid full table scan on partitioned tables.
//	GaryR	08/30/01	Track 2335D	Refresh the kes structure so that when
//										a row changes in dw_report, it will be reflected
//*************************************************************************

//DECLARATION SECTION//

sx_details_structure lstr_details

n_cst_tableinfo_attrib	lnv_table		// FDG 03/14/01

integer	li_table_no,				&
			li_rc

setpointer(hourglass!)
setmicrohelp(w_main,"Preparing to View Claim. Please Wait.")

istr_key_columns = iuo_query.of_get_istr_key_columns()	//	GaryR	08/30/01	Track 2335D

lstr_details.title = 'Claim Information'
//lstr_details.line_no = integer(istr_key_columns.icn_line_no.col_value)	//FDG 06/15/98


//If the claim rpt is displaying all claims then
//ue_tabpage_view_translate_invoice_type 
//is called which will translate the invoice type to the correct table 
//type.  Otherwise the table type is set to whatever is in the instance.

if is_inv_type = "MC" or is_inv_type = "ML" then								// AJS 09/03/98
	/* resolve table type using code table */
	lstr_details.tbl_type = this.event &
		ue_tabpage_view_translate_invoice_type(istr_key_columns.invoice_type.col_value)	// FDG 06/15/98
	if lstr_details.tbl_type = 'ERROR' then return
else
	lstr_details.tbl_type = is_inv_type					// FDG 06/15/98
end if

if upper(is_data_type) = "BASE" or Trim(is_source_subset_id) = '' then	// AJS 09/03/98
	// Base data
	lstr_details.src_type = "SB"
	// FDG 03/14/01 - ue_tabpage_view_get_table_no reads ros_directory.  Remove it for 4.7.
	// Get the table name from gnv_server
	//li_table_no = this.event ue_tabpage_view_get_table_no &
	//				(istr_key_columns.date_paid.col_value)		// FDG 06/15/98
	//if li_table_no = -1 then
	//	return
	//else
	//	lstr_details.table_no = li_table_no
	//end if
	lnv_table.is_inv_type		=	lstr_details.tbl_type
	lnv_table.is_operand			=	'='
	lnv_table.is_paid_date		=	istr_key_columns.date_paid.col_value
	lnv_table.il_period_key		=	0
	li_rc								=	gnv_server.of_GetClaimsTableNames (lnv_table)
	IF	lnv_table.il_rc			<	0			THEN
		MessageBox ('Error', lnv_table.is_message)
		Return
	END IF
	IF	UpperBound (lnv_table.is_base_table)	<	1		THEN
		MessageBox ('Application Error', 'Could not retrieve table name in u_nvo_view.ue_tabpage_view_view_claim.'	+	&
						'  paid_date = '	+	istr_key_columns.date_paid.col_value	+	'.')
		Return
	END IF
	lstr_details.table_name	=	lnv_table.is_base_table[1]
else
	// Subset data
	lstr_details.src_type = "SS"
	lstr_details.subset_id = is_source_subset_id			// FDG 06/15/98
end if

//FNC 02/08/00 Start - fill in sx_details with key information

lstr_details.key1_name = istr_key_columns.icn.col_name
lstr_details.key1_value = istr_key_columns.icn.col_value
lstr_details.key1_data_type = istr_key_columns.icn.data_type

lstr_details.key2_name = istr_key_columns.icn_key2.col_name
lstr_details.key2_value = istr_key_columns.icn_key2.col_value
lstr_details.key2_data_type = istr_key_columns.icn_key2.data_type

lstr_details.key3_name = istr_key_columns.icn_key3.col_name
lstr_details.key3_value = istr_key_columns.icn_key3.col_value
lstr_details.key3_data_type = istr_key_columns.icn_key3.data_type

lstr_details.key4_name = istr_key_columns.icn_key4.col_name
lstr_details.key4_value = istr_key_columns.icn_key4.col_value
lstr_details.key4_data_type = istr_key_columns.icn_key4.data_type

lstr_details.key5_name = istr_key_columns.icn_key5.col_name
lstr_details.key5_value = istr_key_columns.icn_key5.col_value
lstr_details.key5_data_type = istr_key_columns.icn_key5.data_type

lstr_details.key6_name = istr_key_columns.icn_key6.col_name
lstr_details.key6_value = istr_key_columns.icn_key6.col_value
lstr_details.key6_data_type = istr_key_columns.icn_key6.data_type

// FNC 02/08/00 End

//	GaryR	07/09/01 - Begin
//lstr_details.where = "WHERE " + lstr_details.tbl_type + "." + &
//				istr_key_columns.icn.col_name + " = '" + &
//				Upper( istr_key_columns.icn.col_value ) + "'"
				
lstr_details.where = "WHERE " + lstr_details.tbl_type + "." + &
				istr_key_columns.icn.col_name + " = '" + &
				Upper( istr_key_columns.icn.col_value ) + "' AND " + &
				lstr_details.tbl_type + "." + istr_key_columns.date_paid.col_name + &
				" = " + gnv_sql.of_get_to_date( istr_key_columns.date_paid.col_value )
//	GaryR	07/09/01 - End

// FDG 04/10/01 - Close out w_view_claim if already open.
IF	IsValid (w_view_claim)		THEN
	Close (w_view_claim)
END IF
// FDG 04/10/01 - end

opensheetwithparm(w_view_claim,lstr_details,MDI_main_frame,help_menu_position,layered!)

end event

event type integer ue_tabpage_view_get_key_columns();//*********************************************************************************
// Event Name:	UE_Tabpage_View_Get_Key_Columns
//	Arguments:	None
// Returns:		Integer
//
//This event will be called by ue_tabpage_view_create_report() to determine what 
//the key columns are for the invoice type and their column numbers in the 
//datawindow. Will determine what are key columns from the stars_win_parm table 
//then will loop thru the datawindow getting their column numbers.  If the column
//is not found in the datawindow must be added to the select statement but made 
//invisible in the datawindow.  Do this by setting the column to be invisible in 
//istr_key_columns and giving it a column number at end of list.  When build the 
//select clause (ue_create_select()) will put these columns on the end of the 
//select clause and once the datawindow has been loaded 
//(ue_tabpage_view_create_report()) will set these columns to a width of zero.  
//*********************************************************************************
// 12-03-97 FNC Created
//*********************************************************************************
// Modifications
// 01-29-98 FNC	If drilldown use the invoice type in the drilldown structure.
//						Initialize columns structure
//	02/04/98	FDG	Check the embedded SQL status using of_check_status()
// 02/05-98 FNC	Reverse change from 1/29/98. If drilldown still want to use
//						main invoice type so that key columns are included on drilldown
//						report.
// 02/09/98 FNC	Change exit to continue so that code does not completely fall out
//						of for next loop.
//
//	02/24/98	FNC	Initialize istr_key_columns
// 04/13/98 HRB	track 1006 - comment out REVENUE CODE Case clause since not needed                
//	06/15/97	FDG	Track ????.  Don't directly access uo_query attributes.
//	08/07/98	FDG	Track 1235, 1248.  When drilldown, use the invoice type in the
//						drilldown structure to get the key columns.
//	08/21/98	FDG	Track 1235, 1248.  If coming from drilldown (additional data)
//						then don't add the key columns to the select.  These key
//						columns come from the original invoice type.
//	09/04/98	FDG	Track 1671.  Addition change to 8/21/98.  Ignore the 
//						istr_drilldown.path when checking for drilldown.
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
// 05/09/00	FNC	If fasttrack must retrieve main invoice type before retrieving the
//						key fields.
// 05/24/00 KTB   Starcare Track 2888. Uncommented "REV_CODE_DEF" case for revenue
//                code.
//	07/16/01	GaryR	Track 2367d	Using payment_date as an index for partitioned tables.
//	08/10/01	GaryR	Track 2392d	Using prov_id as an index for provider queries
//	01/10/02	FDG	Track 2635d	Using recip_id as an index (coll_indx_key) for enrollee queries
//*********************************************************************************

n_ds  	lds_key_cols, lds_key_add_cols
string	ls_inv_type,	&
			ls_main_tbl_type
integer  li_rc,		&
			li_col_count
Long		ll_rowcount,	&
			ll_row
boolean	lb_duplicate
sx_keys	lstr_keys
n_cst_revenue lnvo_revenue
	

//if ib_drilldown then									//01-29-98 FNC
//	ls_inv_type = istr_drilldown.inv_type			//01-29-98 FNC
///* ML will use MC columns since all key columns are MC */
//elseif is_inv_type = 'ML' then  
//	ls_inv_type = 'MC'
//else
//	ls_inv_type = is_inv_type
//end if

istr_key_columns = lstr_keys					//02-24-98 FNC 

// FDG 08/07/98 begin	- Get the invoice type
ls_inv_type	=	This.uf_get_inv_type()
// FDG 08/07/98 end

lds_key_cols = Create n_ds
lds_key_cols.dataobject = 'd_key_cols'
li_rc = lds_key_cols.settransobject(stars2ca)

if li_rc = -1 then 
	messagebox('ERROR','Error setting trans object in ue_tabpage_view_get_key_columns')
	destroy(lds_key_cols)
	return -1
end if

ll_rowcount = lds_key_cols.retrieve(ls_inv_type)

if ll_rowcount < 0 then
	destroy(lds_key_cols)
	return -1
end if

if ll_rowcount < 1 then 
	destroy(lds_key_cols)	
	return 0
end if

stars2ca.of_commit()	

lds_key_cols.setsort('cntl_id A')
lds_key_cols.sort()

for ll_row = 1 to ll_rowcount
	choose case upper(lds_key_cols.getitemstring(ll_row,'cntl_id'))
		case 'ALLOWED_SRVC_DEF'
			istr_key_columns.allowed_srvc.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
		case 'BENE_DEF'
			istr_key_columns.recip_id.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
		case 'DATE_PAID_DEF'
			istr_key_columns.date_paid.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
		case 'FROM_DATE_DEF'  /* may not be needed - not used in specs */
			istr_key_columns.from_date.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
//		case 'ICN_DEF'														// FNC 02/08/00
//			istr_key_columns.icn.col_name = &						// FNC 02/08/00
//				lds_key_cols.getitemstring(ll_row,'col_name')	// FNC 02/08/00
		case 'ICN_DEF'
			istr_key_columns.icn.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
		case 'INV_TYPE_DEF'  /* MC only */
			istr_key_columns.invoice_type.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
		case 'PROV_DEF'
			istr_key_columns.prov_id.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
// KTB UnCommented - Track2888 - Starcare
// HRB 4/13/98
		case 'REV_CODE_DEF'  /* Revenue only */
			istr_key_columns.rev_code.col_name = &
				lds_key_cols.getitemstring(ll_row,'col_name')
// END KTB
	end choose
next

Select a_dflt
into :istr_key_columns.rev_tbl_type
From stars_win_parm
Where cntl_id = 'REV_COUNT' and tbl_type = Upper( :ls_inv_type )
Using stars2ca;

if stars2ca.of_check_status() < 0 then
	errorbox(stars2ca,'Error determining revenue table type')
	destroy lds_key_cols
	return -1
else												// FNC 04/14/99
	stars2ca.of_commit()						// FNC 04/14/99
end if

// FNC 02/08/00 Start

/*Retrieve unique key columns from coll_index_key */

if left(ls_inv_type,1) = 'Q' then							// FNC 05/09/00 Start
	lnvo_revenue = create n_cst_revenue
	ls_main_tbl_type = lnvo_revenue.of_get_main_table(ls_inv_type)
	destroy lnvo_revenue
else
	ls_main_tbl_type = ls_inv_type
end if																// FNC 05/09/00 End

lds_key_cols.dataobject = 'd_table_indexes'
li_rc = lds_key_cols.settransobject(stars2ca)

if li_rc = -1 then 
	messagebox('ERROR','Error setting trans object in ue_tabpage_view_get_key_columns')
	destroy(lds_key_cols)	
	return -1
end if

ll_rowcount = lds_key_cols.retrieve(ls_main_tbl_type)

if ll_rowcount < 0 then 
	destroy(lds_key_cols)
	return -1
end if

stars2ca.of_commit()							// FNC 04/14/99

ll_row = 0

//	07/16/01	GaryR	Track 2367d - Begin
IF ll_rowcount > 0 THEN
	CHOOSE CASE Upper(lds_key_cols.getitemstring(1,'elem_name'))
		CASE "PAYMENT_DATE"	//	Check if the first key field is payment_date
			if ll_rowcount >= 1 then
				ll_row++
				istr_key_columns.date_paid.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.date_paid.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
				
			if ll_rowcount >= 2 then
				ll_row++
				istr_key_columns.icn.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 3 then
				ll_row++
				istr_key_columns.icn_key2.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key2.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 4 then
				ll_row++
				istr_key_columns.icn_key3.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key3.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 5 then
				ll_row++
				istr_key_columns.icn_key4.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key4.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 6 then
				ll_row++
				istr_key_columns.icn_key5.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key5.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 7 then
				ll_row++
				istr_key_columns.icn_key6.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key6.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
		//	08/10/01	GaryR	Track 2392d - Begin
		CASE "PROV_ID"
			if ll_rowcount >= 1 then
				ll_row++
				istr_key_columns.prov_id.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.prov_id.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 2 then
				ll_row++
				istr_key_columns.icn_key2.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key2.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 3 then
				ll_row++
				istr_key_columns.icn_key3.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key3.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 4 then
				ll_row++
				istr_key_columns.icn_key4.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key4.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 5 then
				ll_row++
				istr_key_columns.icn_key5.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key5.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 6 then
				ll_row++
				istr_key_columns.icn_key6.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key6.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
		//	08/10/01	GaryR	Track 2392d - End	
		//	01/10/02	FDG	Track 2635d - Begin
		CASE "RECIP_ID"
			if ll_rowcount >= 1 then
				ll_row++
				istr_key_columns.recip_id.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.prov_id.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 2 then
				ll_row++
				istr_key_columns.icn_key2.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key2.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 3 then
				ll_row++
				istr_key_columns.icn_key3.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key3.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 4 then
				ll_row++
				istr_key_columns.icn_key4.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key4.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 5 then
				ll_row++
				istr_key_columns.icn_key5.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key5.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 6 then
				ll_row++
				istr_key_columns.icn_key6.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key6.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
		//	01/10/02	FDG	Track 2635d - end	
		CASE ELSE
			if ll_rowcount >= 1 then
				ll_row++
				istr_key_columns.icn.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 2 then
				ll_row++
				istr_key_columns.icn_key2.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key2.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 3 then
				ll_row++
				istr_key_columns.icn_key3.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key3.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount >= 4 then
				ll_row++
				istr_key_columns.icn_key4.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key4.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 5 then
				ll_row++
				istr_key_columns.icn_key5.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key5.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if
			
			if ll_rowcount = 6 then
				ll_row++
				istr_key_columns.icn_key6.col_name = &
					lds_key_cols.getitemstring(ll_row,'elem_name')
				istr_key_columns.icn_key6.data_type = &
					lds_key_cols.getitemstring(ll_row,'elem_data_type')
			end if		
	END CHOOSE
END IF
//	07/16/01	GaryR	Track 2367d - End

/*Determine if any of the client specific keys are already included as a key column.
If so,blank out the client specific key since the column is already included.*/

lb_duplicate = uf_check_unique_key(istr_key_columns.icn_key2.col_name)
if lb_duplicate then
	istr_key_columns.icn_key2.col_name = ''
end if

lb_duplicate = uf_check_unique_key(istr_key_columns.icn_key3.col_name)
if lb_duplicate then
	istr_key_columns.icn_key3.col_name = ''
end if

lb_duplicate = uf_check_unique_key(istr_key_columns.icn_key4.col_name)
if lb_duplicate then
	istr_key_columns.icn_key4.col_name = ''
end if

lb_duplicate = uf_check_unique_key(istr_key_columns.icn_key5.col_name)
if lb_duplicate then
	istr_key_columns.icn_key5.col_name = ''
end if

lb_duplicate = uf_check_unique_key(istr_key_columns.icn_key6.col_name)
if lb_duplicate then
	istr_key_columns.icn_key6.col_name = ''
end if

// 02/08/00 FNC End

/* loop thru tabpage_view.dw_report to get column numbers of keys and set to visible*/
ll_rowcount = idw_selected.rowcount()
for ll_row = 1 to ll_rowcount
	string ls_test
	ls_test = idw_selected.getitemstring(ll_row,'elem_name')
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.icn.col_name then
			istr_key_columns.icn.col_number = ll_row
			istr_key_columns.icn.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	// 02/08/00 FNC Start
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.icn_key2.col_name then						
			istr_key_columns.icn_key2.col_number = ll_row
			istr_key_columns.icn_key2.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.icn_key3.col_name then
			istr_key_columns.icn_key3.col_number = ll_row
			istr_key_columns.icn_key3.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.icn_key4.col_name then
			istr_key_columns.icn_key4.col_number = ll_row
			istr_key_columns.icn_key4.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.icn_key5.col_name then
			istr_key_columns.icn_key5.col_number = ll_row
			istr_key_columns.icn_key5.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.icn_key6.col_name then
			istr_key_columns.icn_key6.col_number = ll_row
			istr_key_columns.icn_key6.visible = TRUE
			Continue																//02-09-98 FNC 
	end if	
	// FNC 02/08/00 End
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.date_paid.col_name then
			istr_key_columns.date_paid.col_number = ll_row
			istr_key_columns.date_paid.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.from_date.col_name then
			istr_key_columns.from_date.col_number = ll_row
			istr_key_columns.from_date.visible = TRUE
			Continue																//02-09-98 FNC 
	end if

	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.recip_id.col_name then
			istr_key_columns.recip_id.col_number = ll_row
			istr_key_columns.recip_id.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.prov_id.col_name then
			istr_key_columns.prov_id.col_number = ll_row
			istr_key_columns.prov_id.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.allowed_srvc.col_name then
			istr_key_columns.allowed_srvc.col_number = ll_row
			istr_key_columns.allowed_srvc.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') =  &
		istr_key_columns.invoice_type.col_name then
			istr_key_columns.invoice_type.col_number = ll_row
			istr_key_columns.invoice_type.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
	if idw_selected.getitemstring(ll_row,'elem_name') = &
		istr_key_columns.rev_code.col_name then
			istr_key_columns.rev_code.col_number = ll_row
			istr_key_columns.rev_code.visible = TRUE
			Continue																//02-09-98 FNC 
	end if
next

/*Loop through the col number for all columns to determine which key cols were
Not selected for the report.If a column was not selected give it a col number 
at the end and set it to invisible*/

li_col_count = ll_rowcount

if istr_key_columns.icn.col_number < 1 then
	if trim(istr_key_columns.icn.col_name) <>  '' then
		li_col_count++
		istr_key_columns.icn.col_number = li_col_count
		istr_key_columns.icn.visible = FALSE
	end if
end if
if istr_key_columns.icn_key2.col_number < 1 then							// FNC 02/08/00 Start
	if trim(istr_key_columns.icn_key2.col_name) <>  '' then
		li_col_count++
		istr_key_columns.icn_key2.col_number = li_col_count
		istr_key_columns.icn_key2.visible = FALSE
	end if
end if
if istr_key_columns.icn_key3.col_number < 1 then
	if trim(istr_key_columns.icn_key3.col_name) <>  '' then
		li_col_count++
		istr_key_columns.icn_key3.col_number = li_col_count
		istr_key_columns.icn_key3.visible = FALSE
	end if
end if
if istr_key_columns.icn_key4.col_number < 1 then
	if trim(istr_key_columns.icn_key4.col_name) <>  '' then
		li_col_count++
		istr_key_columns.icn_key4.col_number = li_col_count
		istr_key_columns.icn_key4.visible = FALSE
	end if
end if
if istr_key_columns.icn_key5.col_number < 1 then
	if trim(istr_key_columns.icn_key5.col_name) <>  '' then
		li_col_count++
		istr_key_columns.icn_key5.col_number = li_col_count
		istr_key_columns.icn_key5.visible = FALSE
	end if
end if
if istr_key_columns.icn_key6.col_number < 1 then
	if trim(istr_key_columns.icn_key6.col_name) <>  '' then
		li_col_count++
		istr_key_columns.icn_key6.col_number = li_col_count
		istr_key_columns.icn_key6.visible = FALSE
	end if
end if																				// FNC 02/08/00 End
if istr_key_columns.date_paid.col_number < 1 then
	if trim(istr_key_columns.date_paid.col_name) <>  '' then
		li_col_count++
		istr_key_columns.date_paid.col_number = li_col_count
		istr_key_columns.date_paid.visible = FALSE
	end if
end if
if istr_key_columns.from_date.col_number < 1 then
	if trim(istr_key_columns.from_date.col_name) <>  '' then
		li_col_count++
		istr_key_columns.from_date.col_number = li_col_count
		istr_key_columns.from_date.visible = FALSE
	end if
end if
if istr_key_columns.recip_id.col_number < 1 then
	if trim(istr_key_columns.recip_id.col_name) <>  '' then
		li_col_count++
		istr_key_columns.recip_id.col_number = li_col_count
		istr_key_columns.recip_id.visible = FALSE
	end if
end if
if istr_key_columns.prov_id.col_number < 1 then
	if trim(istr_key_columns.prov_id.col_name) <>  '' then
		li_col_count++
		istr_key_columns.prov_id.col_number = li_col_count
		istr_key_columns.prov_id.visible = FALSE
	end if
end if
if istr_key_columns.allowed_srvc.col_number < 1 then
	if trim(istr_key_columns.allowed_srvc.col_name) <>  '' then
		li_col_count++
		istr_key_columns.allowed_srvc.col_number = li_col_count
		istr_key_columns.allowed_srvc.visible = FALSE
	end if
end if
if istr_key_columns.invoice_type.col_number < 1 then
	if trim(istr_key_columns.invoice_type.col_name) <> '' then
		li_col_count++
		istr_key_columns.invoice_type.col_number = li_col_count
	end if
	istr_key_columns.invoice_type.visible = FALSE
end if
if istr_key_columns.rev_code.col_number < 1 then
	if trim(istr_key_columns.rev_code.col_name) <> '' then
		li_col_count++
		istr_key_columns.rev_code.col_number = li_col_count
	end if		
	istr_key_columns.rev_code.visible = FALSE
end if

destroy lds_key_cols

return 0


end event

event type string ue_tabpage_view_create_ml_dw_sql();//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_Create_ML_DW_SQL
//	Arguments:	String	None
// Returns:		String
//
//*********************************************************************************
// 12-24-97 FNC	Created
//	02/04/98	FDG	Check the embedded SQL status using of_check_status()
// 03-26-98 FNC	Track 912.  Must replace MC in sql statement. If tbl type is MC 
//						don't want to use it for the from statement
//	06/15/98	FDG	Track ????.  istr_sql_statement is already registered to this NVO.
//						Do not get it from iuo_query.
//	06/15/97	FDG	Track ????.  Don't directly access uo_query attributes.
//						Invoke ue_add_key_cols_to_select from u_nvo_create_sql.
// 07/23/98	FNC	Track 1468. Save table types in ML subset to instance variable
//						used in ub_tabpage_view_create_report when labels2 is called.
// 09/25/98	FDG	Track 1800. Modify where statement to retrieve subset database. 
//						select where elem_type = 'SS' instead of elem_type = 'TB' and
//						elem_name = 'SUBSET'
//	10/08/01	GaryR	Stars 4.7	Remove obsolete functionality.
//	10/08/01	GaryR	Track 2412d	Remove duplicate tables from the FROM Clause.
// 08/21/02 MikeF Track 3252d Rewrote the part of the code that checks for duplicate table names
//                           	to support LOJ
//	12/13/02	GaryR	Track 3388d	Carry the fix from 5.0.1
//	04/06/04	GaryR	Track 3843d	Get the valid invoice type for MC columns
// 11/16/04 MikeF	Track 3650d	Remove all references to W_SUBSET_COLS_JOIN in Win Parm
//	02/04/05	GaryR	Track 4276d Evaluate computed columns to their actual database expression
//*********************************************************************************

/*This event will create the sql to use to build the datawindow for an ML report.  Since 
an ML report will contain columns from multiple invoice_types the real SQL cannot be used
since it may contain NULLs in the select and each statement if FROM one invoice type at a
time.  Must create an SQL statement that will have all SELECT columns FROM all invoice 
types.  Must also add those non-selected key columns.*/

integer		li_rowcount,	&
				i,					&
				j,					&
				li_tbl_count,	&
				li_nbr_from_stmts,	&
				li_from
long			ll_pos
string		ls_elem_tbl_type,	&
				ls_elem_name,	&
				ls_elem_type,	&
				ls_select,		&
				ls_from,			&
				ls_main_tbl_types[]
boolean		lb_found
n_ds			lds_ub92_table_types

//	10/08/01	GaryR	Track 2412d - Begin
String	ls_table, ls_search
Integer	li_start = 1, li_len
//	10/08/01	GaryR	Track 2412d - End

idw_source.Dynamic	Event ue_get_inv_types(ls_main_tbl_types[])	//04-02-98 FNC		// FDG 06/15/98

//	Get dependent invoices
lds_ub92_table_types = Create n_ds
lds_ub92_table_types.DataObject = 'd_ub92_table_types'
lds_ub92_table_types.SetTransObject( Stars2ca )
li_rowcount	=	lds_ub92_table_types.Retrieve( ls_main_tbl_types )

FOR i = 1 TO li_rowcount
	li_tbl_count = UpperBound( ls_main_tbl_types ) + 1
	ls_main_tbl_types[li_tbl_count] = lds_ub92_table_types.GetItemString( i, "ID_2" )
NEXT

Destroy lds_ub92_table_types
this.uf_set_nvo_create_sql(TRUE)			// FDG 06/15/98

/* build select statement and at same time get tbl types to build from */
li_rowcount = idw_selected.rowcount()
for i = 1 to li_rowcount
	ls_elem_tbl_type = idw_selected.getitemstring(i,'elem_tbl_type')
	ls_elem_name = idw_selected.getitemstring(i,'elem_name')
	
	//	Get valid table_type for column
	IF ls_elem_tbl_type = "MC" THEN
		li_tbl_count = UpperBound( ls_main_tbl_types )
		FOR j = 1 TO li_tbl_count
			SELECT count(*) 
			INTO :li_len
			FROM DICTIONARY
			WHERE ELEM_TBL_TYPE = :ls_main_tbl_types[j]
			AND	ELEM_NAME = :ls_elem_name
			USING	Stars2ca;
			
			IF Stars2ca.of_check_status() <> 0 THEN Return "ERROR"

			IF li_len > 0 THEN
				ls_elem_tbl_type = ls_main_tbl_types[j]
				EXIT
			END IF
		NEXT
	END IF
	
	ls_elem_type = gnv_dict.uf_get_string( ls_elem_tbl_type, ls_elem_name, "ELEM_TYPE" )
	ls_select += "," + iuo_nvo_create_sql.uf_get_col_select( ls_elem_type, ls_elem_tbl_type, ls_elem_name )
	
	lb_found = FALSE
	li_tbl_count = upperbound(is_tbl_types)
	for j =1 to li_tbl_count
		if is_tbl_types[j] = ls_elem_tbl_type then
			lb_found = TRUE
			exit
		end if
	next
	if not lb_found then
		is_tbl_types[li_tbl_count+1] = ls_elem_tbl_type
	end if
next

/* now get invisible key columns */
integer li_zero = 0

ls_select = iuo_nvo_create_sql.event ue_add_key_cols_to_select(ls_select,li_zero,ls_main_tbl_types[1]) //04-02-98 FNC

this.uf_set_nvo_create_sql(FALSE)			// FDG 06/15/98

ls_select = " SELECT " + mid(ls_select,2) /* remove 1st ',' */

/* build from clause using subset tables since this will only occur for subset view*/

//04-02-98 FNC Start
li_nbr_from_stmts = upperbound(istr_sql_statement)							// FDG 06/15/98
ls_from = istr_sql_statement[1].from_clause									// FDG 06/15/98
for li_from = 2 to li_nbr_from_stmts
	ls_from = ls_from + ',' + mid(istr_sql_statement[li_from].from_clause,6)	// FDG 06/15/98
next

int		li_pos_loj, li_pos_on
int		li_array_index
int		li_loop
int		li_upper
int		li_begin
int		li_temp_len
boolean	lb_found1
boolean	lb_found2
boolean 	lb_done
string	ls_table1, ls_table2
string	ls_tables[]
string	ls_temp

ls_from 	= Trim(Mid( ls_from,5 ))
li_len 	= len(ls_from)
ll_pos 	= Pos(ls_from,",")
li_begin	= 1

IF ll_pos > 0 THEN
// Loop through the FROM clause to get all the tables
	DO WHILE ll_pos > 0
		
		ls_temp		= mid(ls_from,li_begin,ll_pos - li_begin)	
		li_temp_len	= len(ls_temp)
	
		// Check for LEFT OUTER JOIN
		li_pos_loj	= pos(ls_temp, " LEFT OUTER JOIN ")
				
		IF li_pos_loj > 0 THEN
			// There are 2 tables, Get 'em both.
			ls_table1 = left(ls_temp,li_pos_loj - 1)
			li_pos_on = pos(ls_temp," ON ")
			ls_table2 = mid(ls_temp, li_pos_loj + 17, li_pos_on - li_pos_loj - 17)
		ELSE
			ls_table1 = ls_temp
			ls_table2 = ''
		END IF
		
		// Check the current table names against the ones in the array. If they don't exist, add them.
		li_upper 	= Upperbound(ls_tables)
		lb_found1	= FALSE
		lb_found2	= FALSE
		
		FOR li_loop = 1 TO li_upper
			IF ls_table1 = ls_tables[li_loop] THEN 
				lb_found1 = TRUE
			END IF
			
			IF ls_table2 = ls_tables[li_loop] THEN
				lb_found2 = TRUE
			END IF
				
		NEXT
		
		IF NOT lb_found1 THEN
			li_array_index++
			ls_tables[li_array_index] = ls_table1
		END IF

		IF NOT lb_found2 &
		AND ls_table2 <> '' THEN 
			li_array_index++
			ls_tables[li_array_index] = ls_table2
		END IF
		
		// Set up for the next pass
		li_begin = li_begin + li_temp_len + 1
		ll_pos 	= Pos(ls_from,",",li_begin)
		
		// Need to get the last table
		IF ll_pos = 0 AND lb_done = FALSE THEN
			ll_pos = li_len + 1
			lb_done = TRUE
		END IF
		
	LOOP

	// Assemble the from statement from the table array
	ls_from =''
	
	FOR li_loop = 1  TO li_array_index
		ls_from = ls_from + " " + ls_tables[li_loop]
	
		IF li_loop <> li_array_index THEN
			ls_from = ls_from + ","
		END IF
	NEXT
	
END IF
//-------------------------------------------------------------------------------------------------//
// MikeFl 8/21/02 Track 3252 - END
//-------------------------------------------------------------------------------------------------//

//return ls_select + " " + ls_from
return ls_select + " FROM " + ls_from
//	10/08/01	GaryR	Track 2412d - End

end event

event type string ue_tabpage_view_break_with_totals(ref n_tr at_trans, ref string as_sql, ref string as_style);//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_Break_With_Totals
//	Arguments:	n_tr		at_trans
//					String	as_sql
//					String	as_style
// Returns:		String
//
//	Description:
//	This event is called by ue_tabpage_view_create_report() only if Breaking 
//	with Totals.  It must modify the datawindow syntax to add grouping sections(s) 
//	for each break and computed section(s) for the totals in the breaks or total 
//	columns. Most of the code is taken from w_display_subset_rows.wf_gen_ss_window() 
//	and this should be used as a reference when coding.  First get the datawindow 
//	syntax.  Then determine which columns are break columns and get the info needed 
//	to add a group section for each of the columns.  If totals are requested, 
//	then must add a compute section for each column.  This syntax is
//	taken directly from the current code.  Finally return the syntax string.
//
// The datawindow syntax is broken into sections.  
// The initial sections are as follows:
//
// release info			release 5;
// datawindow info		datawindow(units=1
// table info				table(column=(type=char(3)	/* one column for each column */
// sql						retrieve="SELECT
// header height			header(height=17)
// detail height			detail(height=20)
// column band info		column(band=detail id=1		/* one for each column */
// text band info			text(band = header text = "Type B	/* one for each column */
//
// Listed below are the new sections and the values that must be dynamically filled in:
// header info		header(height=82$$HEX2$$26202000$$ENDHEX$$color=	/* one if have Totals */
//						none
//	summary info	summary(height=21 color=	/* one if have Totals */
//						none
//	detail info		detail(height=24 color=	/* one if have Totals */		
//						none
//	group info		group(level=1			/* one for each break column */
//		level=
//		by=
//	trailer band col		compute(band=trailer.1	/* one for each break &/or total column */
//		trailer.	/*level #*/
//		x=
//		width=
//		format=
//		count(	/*col_name*/
//		group		/*level #*/
//	summary band col	compute(band=summary.1$$HEX2$$26200900$$ENDHEX$$/* one for each break &/or total column */
//		x=
//		width=
//		format=
//		count(	/*col_name*/
//
//	The basic logic is controlled by three factors.  The first is whether there 
//	are Break columns and the second is if there are Break columns are there 
//	counts.  The third is whether there are money or quantity totals.  Thus there 
//	are six possible conditions.  They are listed below with the sections that 
//	need to be added:
//
//	Break columns with Counts and Totals
//		header, summary, detail 
//		group - one for each break column
//		trailer band - one for each break column & one for each total column
//		summary band - one for each break column & one for each total column
//	Break columns with Counts and no Totals
//		group - one for each break column
//		trailer band - one for each break column
//		summary band - one for each break column
//	Break columns without Counts and Totals
//		header, summary, detail
//		group - one for each break column
//		trailer band - one for each total column
//		summary band - one for each total column
//	Break columns without Counts and no Totals
//		group - one for each break column
//	No Break columns and Totals
//		header, summary, detail
//		summary band - one for each total column
//	No Break columns and no Totals
//		don't touch the syntax (yeah)!!!!
//
//	Below is how the dynamic values will be populated:
//	 level=placement of column in istr_break_info.col array minus sort only columns
//	 by=istr_break_info.col[i].col_number
//	 trailer. placement of column in istr_break_info.col array minus sort only columns
//	 x=from syntax for text band info
//	 width= from syntax for text band info
//	 format=use istr_break_info.col[i].col_data_type to determine format (##,###,##0 or ##,###,##0.00)
//	 count(istr_break_info.col[i].col_name
//	 group placement of column in istr_break_info.col array minus sort only columns
//
//*********************************************************************************
// 12-24-97 FNC Created
//	02/12/98	JTM	Added method call to get the break info structure from query. 	
//	02/13/98	JTM	Removed header(height=82 color='0')... assignment to ls_Middle
//						since the header and detail height have already been set.
//	02/17/98	JTM	1 - Corrected calls to ue_tabpage_report_get_selected_col_names &
//							 ue_tabpage_view_break_get_total_columns.
//						2 - Corrected expression= syntax when adding total computed columns.
//							 and count comupted columns.
//	02/18/98	JTM	Added summary height syntax to display summary line.
// 06/24/98	FNC	Track 1357. Don't need to retrieve istr_break_info from UO_Query
//						since it has been set in U_NVO_Query.
//	09/23/98	FDG	Track ????.  background color must access stars_colors.
//	09/24/98	FNC	Track ????.  Quotes around color were missing in background 
//						color syntax.
//	10/02/98	FDG	Track 1847.  Pass lstr_selected_cols to 
//						ue_tabpage_view_break_get_col_info.
//	10/30/98	FDG	Track 1883.  Change height = '16' to height = '32' to ensure
//						that a blank line is inserted after each break.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//						Set at_trans data type n_tr (instead of type transaction)
//	10/16/01	GaryR	Track 3715c	Handle "DataWindow has incorrect release number" error while breaking with totals
// 09/16/03 MikeF	Track 3621d Multiple breaks weren't working. Only summarizing one field.
// 12/15/04	Katie	Track 4121d Added code for col_name and col_number in sx_break_info
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

string	ls_syntax,	&
			ls_error,	&
			ls_head,		&
			ls_tail,		&
			ls_middle,	&
			ls_trailer,	&
			ls_summary, &
			ls_text
integer	li_pos,		&
			i,				&
			j,				&
			li_col_count,	&
			li_break_count,	&
			li_total_count
boolean	lb_break

sx_break_col_info lstr_col_info
sx_selected_cols 	lstr_selected_cols[]
sx_total_cols		lstr_total_cols[]

n_cst_string	lnv_string

ls_syntax = at_trans.syntaxfromsql(as_sql,as_style,ls_error)
//	10/16/01	GaryR	Track 3715c - Begin
if ls_syntax = '' then 
	messagebox('Error','Error creating datawindow for report in u_nvo_view.ue_tabpage_view_break_with_totals. Error = ' + &
	ls_error	+	'~n~rSQL = '	+	as_sql)
	return "ERROR"
end if
//	10/16/01	GaryR	Track 3715c - End

// if have Totals then add header, summary and detail info before "table(" 
// in the syntax. Also store the sum/count columns into an array to be used 
// to build the compute columns

li_pos = pos(ls_syntax,"table(")
ls_head = left(ls_syntax,li_pos - 1)
ls_tail = mid(ls_syntax,li_pos)
ls_syntax = ls_head + ls_tail
	
// get the selected column names
iuo_Query.event ue_tabpage_report_get_selected_col_names(lstr_selected_cols)
	
// get the break with total columns based upon istr_break_info.totals:
//					'M' - Money 'type' columns
//					'Q' - Quantity 'type' columns
//					'A' - Both Money and Quantity 'type' columns
this.event ue_tabpage_view_break_get_total_columns (istr_break_info.totals, &
																	lstr_selected_cols, &
																	lstr_total_cols)

/* loop thru istr_break_info.col to get any Break columns and build a group section for 
each - the level number will be the sequence in the array - also set break flag*/
li_col_count = upperbound(istr_break_info.cols)

for i = 1 to li_col_count
	// check for break on column
	if istr_break_info.cols[i].options = 'B' then
		lb_break = TRUE
		li_break_count++
		ls_middle = ls_middle + " group(level=" + string(li_break_count) + &
						" header.height=0 trailer.height=19 by=(" + &
						string(istr_break_info.cols[i].col_number) + ")) "
		
	end if
next

ls_Middle = " summary(height=21)" + ls_Middle

li_pos = pos(ls_syntax,"column(")

// check if breaks exist
if lb_break then
	ls_head = left(ls_syntax,li_pos - 1)
	ls_tail = mid(ls_syntax,li_pos)
	ls_syntax = ls_head + ls_middle + ls_tail
else
	// get the column and text bands anyway so can use them when need to parse the 
	//	string to build the compute bands - just have a smaller string to parse
	ls_tail = mid(ls_syntax,li_pos)  
end if

// build the compute bands for Break columns - again loop thru the 
// istr_break_info.col array and for each Break column must get the x=, width= 
// and format= from the text band for that column and the format= from the 
// col_data_type - know looping thru the array twice but 
// since it is a small array it's worth it to keep the code clean

if lb_break and istr_break_info.counts then
	
	li_break_count = 0
	
	for i = 1 to li_col_count
		
		// check for break on column again
		if istr_break_info.cols[i].options = 'B' then			
			
			li_break_count++
			lstr_col_info = this.event ue_tabpage_view_break_get_col_info (ls_tail,	&
														istr_break_info.cols[i].col_name,		&
														istr_break_info.cols[i].col_data_type,	&
														lstr_selected_cols)
			
			ls_trailer = " compute(band=trailer." + string(li_break_count) + &
				" color='" + String( stars_colors.window_text ) + "' alignment='1' " + &
				" border='0' x='" + lstr_col_info.x + &
				"' y='2' height='32' width='" + &
				lstr_col_info.width + "' format='" + lstr_col_info.format + &
				"' expression='count(" + istr_break_info.cols[i].col_name + &
				" for group " + string(li_break_count) + &
				")' font.face='System' font.height='-10' "	+	&
				"font.weight='700' font.family='2' " + &
				"font.pitch='2' font.charset='0' background.mode='1' "	+	&
				"background.color='"	+	String(stars_colors.window_background)	+	"' "
			
			//	Set Accessibility Properties
			ls_text = lnv_string.of_clean_string_acc( istr_break_info.cols[i].col_desc ) + " Group Count"
			ls_trailer += 'accessibledescription="~~"' + ls_text + '~~"~~t~~"' + ls_text + &
							'~~"" accessiblename="~~"' + ls_text + '~~"~~t~~"' + ls_text + '~~"" accessiblerole=27 ) '
			
			ls_summary	=	" compute(band=summary color='" + String( stars_colors.window_text ) + "' alignment='1' "	+	&
								"border='0' x='" + &
				lstr_col_info.x + "' y='2' height='32' width='" + &
				lstr_col_info.width + &
				"' format='" + lstr_col_info.format + &
				"' expression='count(" + istr_break_info.cols[i].col_name + &
				" for all)' font.face='System' font.height='-10' "	+	&
				"font.weight='700' font.family='2'" + &
				"font.pitch='2' font.charset='0' background.mode='1' "	+	&
				"background.color='"	+	String(stars_colors.window_background)	+	"' "
			
			//	Set Accessibility Properties
			ls_text = lnv_string.of_clean_string_acc( istr_break_info.cols[i].col_desc ) + " Total Count"
			ls_summary += 'accessibledescription="~~"' + ls_text + '~~"~~t~~"' + ls_text + &
							'~~"" accessiblename="~~"' + ls_text + '~~"~~t~~"' + ls_text + '~~"" accessiblerole=27 ) '
			
			ls_syntax = ls_syntax + ls_trailer + ls_summary
		end if
		
	next
	
end if	

/* finally, add Total Columns - if have Break columns must create trailer for each group 
and a summary, else only summary */
li_total_count = upperbound(lstr_total_cols)
for i = 1 to li_total_count
	lstr_col_info = this.event ue_tabpage_view_break_get_col_info (ls_tail,	&
														lstr_total_cols[i].col_name,		&
														lstr_total_cols[i].data_type,		&
														lstr_selected_cols)

	for j = 1 to li_break_count
		ls_syntax += " compute(band=trailer." + string(j) + &
			" color='" + String( stars_colors.window_text ) + "' alignment='1' " + &
			" border='0' x='" + lstr_col_info.x + &
			"' y='2' height='32' width='" + &
			lstr_col_info.width + "' format='" + lstr_col_info.format + &
			"' expression='sum(" + lstr_total_cols[i].col_name + &
			" for group " + string(j) + &
			")' font.face='System' font.height='-10' "	+	&
			"font.weight='700' font.family='2' " + &
			"font.pitch='2' font.charset='0' background.mode='1' "	+	&
			"background.color='"	+	String(stars_colors.window_background)	+	"' "
			
		//	Set Accessibility Properties
		ls_text = lnv_string.of_clean_string_acc( lstr_total_cols[i].col_name ) + " Group Summary"
		ls_syntax += 'accessibledescription="~~"' + ls_text + '~~"~~t~~"' + ls_text + &
						'~~"" accessiblename="~~"' + ls_text + '~~"~~t~~"' + ls_text + '~~"" accessiblerole=27 ) '
	next
		
	ls_syntax += " compute(band=summary color='" + String( stars_colors.window_text ) + "' "	+	&
		"alignment='1' border='0' x='" + &
		lstr_col_info.x + "' y='2' height='32' width='" + &
		lstr_col_info.width + &
		"' format='" + lstr_col_info.format + &
		"' expression='sum(" + lstr_total_cols[i].col_name + &
		" for all)' font.face='System' font.height='-10' "	+	&
		"font.weight='700' font.family='2'" + &
		"font.pitch='2' font.charset='0' background.mode='1' "	+	&
		"background.color='"	+	String(stars_colors.window_background)	+	"' "
		
	//	Set Accessibility Properties
	ls_text = lnv_string.of_clean_string_acc( lstr_total_cols[i].col_name ) + " Total Summary"
	ls_syntax += 'accessibledescription="~~"' + ls_text + '~~"~~t~~"' + ls_text + &
					'~~"" accessiblename="~~"' + ls_text + '~~"~~t~~"' + ls_text + '~~"" accessiblerole=27 ) '
next
	
return ls_syntax
end event

event type integer ue_tabpage_view_break_get_total_columns(readonly string as_type, readonly sx_selected_cols astr_cols[], ref sx_total_cols astr_total_cols[]);//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_Break_Get_Total_Columns
//	Arguments:	String				as_type
//					SX_Selected_Cols	astr_cols[]
//					SX_total_cols		astr_total_cols[]
// Returns:		integer
//
//*********************************************************************************
// 12-24-97 FNC 	Created
// 09/15/98	FNC	Track 1732. If a field is excluded continue looping through other
//						fields on report instead of exiting.
//	09/18/98	FDG	Track 1723.  Get the list of excluded columns from table
//						dictionary (via function uf_get_excluded_columns).
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
// 09/27/00 KTB   STARCare Track 2990. Convert data types to uppercase in case
//                it is lower case in the dictionary.
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
// 10/15/04	MikeF	SPR3650d	Replace Hidden dictionary code with gnv_dict
//*********************************************************************************

/*This event is called by ue_tabpage_view_break_with_totals() to determine which of 
the selected report columns will be totaled.  There are two types of totaling, 
money and quantities.  If as_type = 'M' then only total money fields, if as_type = 
'Q' then only total quantity fields and if as_type = 'A' total both.  There are 
columns which will not be totaled, even if money or quantity fields.  They are 
hardcoded into an array to be checked.  The excluded columns were determined by 
current functionality, see w_subset_cols.wf_fill_total_array.  
Note: SRC_TBL_NO is removed since removed in 4.0. */

string 	ls_excluded_columns[],	&
			ls_data_type,				&
			ls_TableType[1]
			
integer	li_ex_count,				&
			li_count,					&
			i,								&
			j,								&
			k,								&
			li_rc,						&
			li_rowcount
boolean	lb_exclude

// FDG 09/18/98 begin
li_rc	=	This.uf_get_excluded_totals_columns (ls_excluded_columns)

//ls_excluded_columns[1] = 'ICN_LINE_NO'
//ls_excluded_columns[2] = 'ICN_VER'
//ls_excluded_columns[3] = 'GEO_COUNTY'
//ls_excluded_columns[4] = 'ADMIN_COUNTY'
//ls_excluded_columns[5] = 'AGE'
//ls_excluded_columns[6] = 'LINE_NOS'
//ls_excluded_columns[7] = 'PATIENT_ZIP'
// FDG 09/18/98 end

li_ex_count = upperbound(ls_excluded_columns)

li_count = upperbound(astr_cols)

for i = 1 to li_count
	ls_data_type = gnv_dict.event ue_get_elem_data_type(astr_cols[i].tbl_type, astr_cols[i].col_name)

	if as_type = 'M' or as_type = 'A' then

		IF gnv_sql.of_is_money_data_type (ls_data_type)		THEN
			j++
			astr_total_cols[j].col_name 	= astr_cols[i].col_name
			astr_total_cols[j].data_type 	= ls_data_type
		END IF

	end if
	
	if as_type = 'Q' or as_type = 'A' then
		// KTB 9-27-00 Track 2990, Convert data_type to Upper case just in case
		//                         in is in lower case in the dictionary
		// FDG 12/14/00 - Make the checking of data types DBMS-independent.
		//choose case UPPER(ls_data_type)
		//	case 'INT', 'SMALLINT', 'LONG'
		IF gnv_sql.of_is_number_data_type (ls_data_type)		THEN
			/* do not add excluded columns */
			lb_exclude = FALSE
			for k = 1 to li_ex_count
				if astr_cols[i].col_name = ls_excluded_columns[k] then
					lb_exclude = TRUE
					exit
				end if			
			next
			if lb_exclude then 
				continue								// FNC 09/15/98
			end if
			j++
			astr_total_cols[j].col_name = astr_cols[i].col_name
			astr_total_cols[j].data_type = ls_data_type
		//end choose
		END IF
		// FDG 12/14/00 end
	end if
next

return 0
end event

event ue_tabpage_view_break_get_col_info;//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_Break_Get_Col_Info
//
//	Arguments:	String				As_Syntax (by reference)
//					String				as_col_name (by reference)
//					String				as_data_type (by reference)
//					sx_selected_cols	astr_selected_cols[]
//
// Returns:		sx_break_col_info
//
//	Description:
//		This event is called by ue_tabpage_view_break_with_totals() to parse 
//		the datawindow syntax to determine the 'x' and 'width' values for the 
//		column.  Then using the data type will determine the format.  These values 
//		will be returned.
//
//		The following is example d/w syntax used to search for the "x" and "width":
//			column(band=detail id=1 x="3" y="2" height="16" width="40" ....
//
//*********************************************************************************
// 12-24-97 FNC	Created
//	02/18/98	JTM	Corrected position error since "x=" is BEFORE the column name.
// 10/02/98	FDG	Track 1847.  astr_selected_cols[] is now passed to this event
//						to help in finding the correct column name in the syntax.  The
//						occurence within this structure will determine the column #.
//						Also, remove the offset since it will no longer be needed.
// 09/27/00 KTB   STARCare Track 2990. Convert data types to uppercase in case
//                it is lower case in the dictionary.
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
//*********************************************************************************


Long		ll_pos,				&
			ll_x_pos,			&
			ll_end_x_pos,		&
			ll_width_pos,		&
			ll_end_width_pos

Integer	li_find,				&
			li_idx,				&
			li_upper

String	ls_find

sx_break_col_info lstr_break_col
			
Constant String LS_TEXTNAME = "_T"

// FDG 10/02/98 begin
// Determine the occurence within the structure that this column exists.
//	This will give you the column number.

li_upper	=	UpperBound (astr_selected_cols)

FOR li_find	=	1 TO	li_upper
	IF	as_col_name	=	astr_selected_cols[li_find].col_name		THEN
		li_idx	=	li_find
		Exit
	END IF
NEXT

IF	li_idx	=	0		THEN
	Return lstr_break_col
END IF

// Get the starting location to get the column name in case multiple columns
//	have similar names (i.e. PAYMENT & PAYMENT_DATE)
ls_find	=	"band=detail id="	+	String(li_idx)
ll_pos	=	Pos ( Upper(as_syntax), Upper(ls_find) )
// FDG 10/02/98

//ll_pos = pos( upper(as_syntax), upper(as_col_name), ll_pos)		// FDG 10/02/98 - Remove

// FDG 10/02/98 - The following IF is no longer necessary
//IF ll_pos > 0 THEN
//	// make sure this is not the column header
//	IF pos(upper(as_syntax)+LS_TEXTNAME,upper(as_col_name)) = ll_pos THEN
//		// get the next occurrence
//		ll_pos = pos(upper(as_syntax),upper(as_col_name),ll_pos)
//	END IF
//END IF

/* looking for 'x' value in string like: " x="3" height where 3 can be any 
number not just single digit */
ll_x_pos = pos(as_syntax,'x=',ll_pos)		// FDG 10/2/98 - remove offset

ll_end_x_pos = pos(as_syntax,'"',ll_x_pos+3) /* find end '"' */

lstr_break_col.x = mid(as_syntax,ll_x_pos+3,ll_end_x_pos - (ll_x_pos+3))

/* looking for 'width' value in string like: "Type Bill" x="3" height="13" width="40" 
font where 40 can be any number not just double digit */
ll_width_pos = pos(as_syntax,'width=',ll_pos)		// FDG 10/2/98 - remove offset

ll_end_width_pos= pos(as_syntax,'"',ll_width_pos+7) /* find end '"' */

lstr_break_col.width = mid(as_syntax,ll_width_pos+7,ll_end_width_pos - (ll_width_pos+7))

/* now determine format using data_type */
// KTB 9-27-00 Track 2990, Convert data_type to Upper case just in case
//                         in is in lower case in the dictionary
// FDG 12/14/00 - Make the checking of data types DBMS-independent.
//choose case UPPER(as_data_type)
//	case 'MONEY', 'SMALLMON', 'SMALLMONEY'
//		lstr_break_col.format = '##,###,##0.00'
//	case else
//		lstr_break_col.format = '##,###,##0'
//end choose
IF gnv_sql.of_is_money_data_type (as_data_type)		THEN
	lstr_break_col.format = '##,###,##0.00'
ELSE
	lstr_break_col.format = '##,###,##0'
END IF
// FDG 12/14/00 end
	
return lstr_break_col
end event

event type integer ue_tabpage_view_create_report();//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_Create_Report
//
//	Arguments:	None
//
// Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:
//	This event will actually create the report.  Most of the code for this will 
//	be taken from w_claim_rpt_parent.open.  First it must use the selected columns 
//	plus the required columns to create the datawindow.  Must determine the key 
//	columns and loop thru the datawindow to get their column numbers. Then the 
//	sql must be strung together (not forgetting super provider query) and the 
//	datawindow retrieved.  If rows are returned then must add title and labels 
//	(label function rewritten).  If no rows are returned, give message and select 
//	tabpage_search.  Also need to modify datawindow for window operations, get 
//	column numbers of required columns.  During the retrieve must allow user 
//	to cancel by clicking the cancel button on the toolbar.  If the user 
//	selected Break with Totals, the datawindow syntax must be modified before the 
//	datawindow is created.
//
//*********************************************************************************
// 12-24-97 FNC	Created
//	12-31-97 FNC	Take color out of dwcreate
//					 	Set ii_dw_limit = gc_dw_limit prior to retrieving data
//	02/23/98	JTM	Added logic to permit cancel of retrieve.
// 02/25/98 FNC   Track 849.  Set initial color of report dw to teal.
//	02/25/98	JTM	Added init. of the boolean telling app. that the cancel retrieve 
//						MENU/TOOLBAR item has been clicked.
//	03/13/98	FDG	Track 934.  After a successful retrieval, reset the window colors.
//	03/13/98	FDG	Track 866.  If no rows returned, get out to prevent a null
//						object reference.
//	03/23/98	FDG	Track 950.  Save lstr_decode_struct for later usage.
//	03/24/98	FDG	Track 956.  If the user cancels the retrieve, it's not an 
//						condition.  Therefore, do not immediately exit.
// 03-26-98 FNC	Track 912. 	If ML subset not putting NULL in sql anymore so always 
//										trigger event to generate the datawindow sql.
//	04/06/98	FDG	Track ???	Setting of the colors for the report had to be refined.
// 04/08/98	FNC	Track 993	When setredraw is attempted and report is not created
//										it cause a non recoverable error.
//	04/10/98	FDG	Track 849.	Initialize idw_report's background color to
//										stars_colors.datawindow_back.  Also, combine all
//										dw_report.modifys into 1.
//	04/17/98	FDG	Track 1083.	Trigger the script to determine if a payment date is
//										to be created.  This will occur when a from date is
//										entered as criteria, but no payment date is entered.
// 04/21/98 FNC	Track 962	Replace single quotes in title with double quotes so
//										the modify in fx_add_head works correctly.
//	04/28/98	FDG	Track 1114.	Reset the row # stored for numeric totals.
//	05/12/98	FDG	Track 1223.	1. Count moved from the window to the tabpage.
//										2. If the user cancelled the query, don't do the next
//										query.
// 05/20/98 FNC	Track 1107  Prior to creating the report check to make sure that
//										filters exist.
// 06/09/98	FNC	Track 1255	Uncheck the money/totals option on the view menu.
//	06/15/97	FDG	Track ????. Don't directly access uo_query attributes.
//										Invoke ue_create_sql from u_nvo_query.
// 06/16/98 FNC					Register istr_key_columns with UO_Query because
//										UO_Query is not recognizing the structure now that it
//										NVO_View is not directly accessing istr_key_columns.
// 07/23/98 FNC	Track 1468. If vieing an ML subset call labels2 for each invoice type
//						in the subset.
//	08/21/98	NLG	ts144 Report On enhancements.
//						1.	Set load template boolean to false.
//						2.	If Report On selected fields contains no data, load default template
//	08/28/98	FDG	Track 1235, 1248.  On a drilldown it is possible to select the same
//						column on different tables (i.e. tmp.prov_id & C1.prov_id).  When
//						this occurs, the datawindow CREATE will not generate a name for
//						the HEADER of the duplicate column.  This name must be added.
//	09/23/98	FDG	Track 1699.  Break with totals not working correctly.
//	09/30/98	FDG	Track 1732, 1847.  With break with totals, must sort data in the 
//						same order you're breaking on.
//	10/09/98	FDG	Track 1912.  Fix change on 9/30.  Append ls_sort to the d/w sort.
// 10/22/98 AJS 	Track 1710.  Fix header lines
// 11/03/98	FNC	Track 1735.  Change 4/21/98 change. Only allow single quotes in the
//						repor title. Modified fx_add_head_multi_line to accomodate this.
//	11/25/98	FDG	Track 2002.  ue_retrieve should return a 'long' instead of
//						an 'integer'.
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//	07/17/00	FDG	Track 2465c.  Stars 4.5 SP1.  If using Fastquery, retrieve the
//						data in a hidden d/w (idw_break) and copy the data to
//						idw_report.
// 12/06/00	GaryR	Stars 4.7 DataBase Port - ASE set statement
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//						Set lt_trans data type n_tr (instead of type transaction)
//	02/27/01	FDG	Stars 4.6.  If using fastquery and at least one of the months of
//						data reached its threshold, display a warning message.
//	03/06/01	FDG	Stars 4.6.  If using fastquery, the fastquery rows must be > 0.
//	03/14/01	FDG	Stars 4.7.	Get the base table names from u_nvo_create_sql so that
//						ros_directory doesn't have to used.
//	07/31/01	FDG	Track ???? (Stars 4.6 SP2).  Perform the function to get the
//						maximum width of each column.
//	11/06/01	GaryR	Track 2418d	Fix PB bug that incorrectly names the header.
// 08/06/02 MikeF Track 2913d. Make 2nd pass at of_labels2 for Additional data type
//	08/21/02	GaryR	Track 3265d	Continuation of Track 2418d.
//										Possibility of two or more columns with same name.
// 08/23/02 Jason Track 2982d Comment out change from track 3265d
// 08/26/02 MikeF Track 3282 Oracle requires Parenthesis when using an 'OR' and LOJ
//	06/30/03	GaryR	Track 3593d	Rewrite logic to include ordering
// 11/14/03 MikeF Track 3703d	Change added columns to visible=0 from width=0 so they won't export
//	02/16/04	GaryR	Track 6028c	Prevent the screen from redrawing while data is retrieved
//	02/20/04	GaryR	Track 3879d	Do not look for invoice type unless ML or MC when decoding
// 02/14/05 MikeF Track 4289d Set dw to read only.\
// 01/25/06 HYL	Track 4609d Let display header for Additional Data Source first so that main Data Source header overlays on top of it
// 02/17/06 HYL 	Track 4609d For multi level report, display header label not from individual table but from common table('MC')
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//	09/10/09	GaryR	QEN.650.5229.004	Remove obsolete money/unit totals logic and reset statistics menu
//
//*********************************************************************************

Integer	li_rc,					&
			li_sql_count,			&
			i,							&
			li_ml_inv_types,		&
			li_tbl,					&
			li_idx,					&
			li_upper
//AJS 10/22/98 Track Fix header lines
Integer 	li_line_count,			&
			li_y_pos, 				&
			li_header_height, 	&
			li_height_constant
			
Boolean	lb_subset_id

n_tr		lt_trans					// FDG 02/20/01

String	ls_sql_create_dw,		&
			ls_sql_statement[],	&
			ls_style,				&
			ls_syntax,				&
			ls_error,				&
			ls_modify,				&
			ls_rc,					&
			ls_subset_id,			&
			ls_subset_type,		&
			ls_sort,					&
			ls_single_quote,		&
			ls_double_quote,		&
			ls_fastquery_ind,		&
			ls_set_sql
			
Long		ll_rowcount,			&
			ll_pos,					&
			ll_rc,					&
			ll_fastquery_rows

Boolean	lb_fastquery_warning			// FDG 02/27/01

sx_decode_structure	lstr_decode_struct
n_cst_string lnvo_cst_string
m_view	lm_view

setpointer(hourglass!)

ls_single_quote = "'"; ls_double_quote = '"'

// Init. the boolean telling app. that the cancel retrieve MENU/TOOLBAR item 
//	has been clicked.
gv_cancel_but_clicked = FALSE

iuo_query.of_set_ib_load_template(FALSE)			//NLG 8/21/98

//NLG 8/21/98 														****START***
ll_rowcount = iuo_query.Event ue_tabpage_report_get_selected()
if ll_rowcount > 0 then

else
	ll_rowcount = iuo_query.Event ue_tabpage_report_load_user_template()
	
	if ll_rowcount <= 0 then 
		ll_rowcount = iuo_query.Event ue_tabpage_report_load_system_template()
	end if
	
	if ll_rowcount > 0 then
		iuo_query.of_set_ib_load_template(TRUE)
	else
		Messagebox('ERROR','Dictionary display sequences not defined properly. ')
		return -1
	end if
	
end if
//NLG 8/21/98 														****STOP***

// get key column names and numbers for all data source types, not just claims 
li_rc = this.event ue_tabpage_view_get_key_columns()	
if li_rc <> 0 then 
	return -1
End If

// FDG 04/17/98 - Determine if a payment date must be created
li_rc	=	iuo_query.Event	ue_tabpage_search_edit_report_dates()
IF	li_rc	<	0		THEN
	Return -1
END IF

// FNC 05/20/98 Start
li_rc	=	iuo_query.Event	ue_tabpage_search_ml_filter_check('REPORT')
IF	li_rc	<	0		THEN
	Return -1
END IF
// FNC 05/20/98 End

// FDG 07/17/00 - Get FastQuery data
ls_fastquery_ind		=	idw_fastquery.object.fastquery_ind [1]
ll_fastquery_rows		=	idw_fastquery.object.fastquery_rows [1]

// FDG 03/06/01 - Edit FastQuery data
IF	 ls_fastquery_ind		=	'Y'		&
AND ll_fastquery_rows	=	0			THEN
	MessageBox ('Error', 'The max # rows for FastQuery must be > 0.')
	iuo_query.Event	ue_selecttab (ic_report)
	idw_fastquery.SetFocus()
	idw_fastquery.SetColumn ('fastquery_rows')
	Return	-1
END IF
// FDG 03/06/01 end

// create SQL
ib_subsetting = FALSE		// clear out just in case 

this.uf_set_nvo_create_sql(TRUE)

li_rc = This.event ue_create_sql()  // creates istr_sql_statement 	// FDG 06/15/98
if li_rc <> 0 then 
	return -1
End If

// FDG 03/14/01 - Get the base table names for future use
inv_base		=	iuo_nvo_create_sql.uf_get_base_tables()
this.uf_set_nvo_create_sql(FALSE)

// string together, including Super Provider Query if necessary 
iuo_query.event ue_string_sql_statement(ls_sql_statement[])
if li_rc <> 0 then return -1

// if ML subset reporting on multiple table types, will have to rebuild SQL for 
// datawindow reate so that the SELECT contains all the columns - the where is not needed 
// for create
if is_inv_type = "ML" then				//03-26-98 FNC		// FDG 06/15/98
	ls_sql_create_dw = this.event ue_tabpage_view_create_ML_dw_sql()
	if ls_sql_create_dw = 'ERROR' then return -1
else
	ls_sql_create_dw = ls_sql_statement[1]
end if

ls_style	=	" datawindow(units = 1 color = "			+	&
				String(stars_colors.window_background )	+	&
				") style(type = grid))  "

if is_data_type = 'SUBSET' and iuo_query.is_source_type <> 'AN' then		// FDG 06/15/98
	lt_trans = stars2ca
else
	// maim claim tables and all ancillary tables are in stars1
	lt_trans = stars1ca
end if

if upperbound(istr_break_info.cols) > 0 then 
	// break with totals so modify syntax - only done if single retrieve
	ls_syntax = this.event ue_tabpage_view_break_with_totals(lt_trans,ls_sql_create_dw,ls_style)
	if ls_syntax = 'ERROR' then return -1
else
	ls_syntax = lt_trans.syntaxfromsql(ls_sql_create_dw,ls_style,ls_error)
	if ls_syntax = '' then 
		// MikeFl 8/26/02 - Track 3282 - Begin
		IF match(ls_error,"ORA-01719") THEN
			messagebox('Error',"Queries utilizing an 'OR' operand require parentheses.")
			iuo_query.Post selecttab( IC_SEARCH )
			idw_criteria.Post SetFocus()
			RETURN -2
		ELSE
			messagebox('Error','Error creating datawindow for report in U_NVO_View.UE_Tabpage_View_Create_Report. Error = ' + &
			ls_error	+	'  SQL = '	+	ls_sql_create_dw)
			return -1
		END IF
		// MikeFl 8/26/02 - Track 3282 - End
	end if
end if

li_rc = idw_report.create(ls_syntax)
if li_rc = -1 then return -1

//	Reset the stats menu
lm_view = iw_parent.wf_get_m_view()
lm_view.of_reset_stats()

li_rc	=	This.uf_GetMaxColumnLengths()							// FDG 07/31/01
li_rc	=	This.uf_add_column_headings()							// FDG 08/28/98

li_rc = fx_dw_syntax(upper(iw_parent.classname()),idw_report,lstr_decode_struct,stars2ca)
if li_rc <> 0 then return -1

lstr_decode_struct.is_ml_query = is_inv_type = "ML" OR is_inv_type = "MC"

//	Save this structure for code/decode
iuo_query.of_set_decode_struct (lstr_decode_struct)		// FDG 03/23/98

//FNC 11/03/98 Start
//FNC 04/21/98 Start
ll_pos = pos(imle_title.text,ls_double_quote)
if ll_pos > 0 then
	li_rc = messagebox('QUESTION','Double quotes in report title will be changed ' + &
							'to single quotes. Do you wish to continue?',Question!,YesNo!)
	if li_rc = 2 then return -1
	imle_title.text = lnvo_cst_string.of_globalreplace(imle_title.text,ls_double_quote,ls_single_quote)
end if
//FNC 04/21/98 End
// FNC 11/03/98 End
//AJS 10/22/98 Track Fix header lines
//Determine Height of Title
li_height_constant = 21
li_line_count = imle_title.LineCount()
If li_line_count = 0 then
	li_line_count = 1
end if
//Add blank line after title
li_line_count++

//Determine Height of Header (Title + column headings)
li_header_height = (li_line_count + 2) * li_height_constant

//Determine Y position for column headings
li_y_pos = (li_line_count * li_height_constant)
//AJS 10/22/98 Track Fix header lines end

n_cst_labels lnvo_labels
lnvo_labels = create n_cst_labels

lnvo_labels.of_setdw(idw_report)

// FNC 07/23/98 Start
if is_inv_type = 'ML' then
	li_ml_inv_types = upperbound(is_tbl_types)
	for li_tbl = 1 to li_ml_inv_types
			lnvo_labels.of_labels2(is_tbl_types[li_tbl],string(li_header_height),'40',string(li_y_pos))
	next
	lnvo_labels.of_labels2('MC',string(li_header_height),'40',string(li_y_pos)) // 02/17/06 HYL Track 4609d
else
	// MikeFl 8/6/02 - Track 2913 - Begin;   
	//	01/25/06 HYL	Track 4609d Let display header for Additional Data Source first so that main Data Source header overlays on top of it
	//                                                 Moved this <if> block which used to be run after 'lnvo_labels.of_labels2()'
	IF trim(iuo_query.is_add_inv_type) = '' THEN
	ELSE
		lnvo_labels.of_labels2(iuo_query.is_add_inv_type,string(li_header_height),'40',string(li_y_pos))
	END IF
	// MikeFl 8/6/02 - Track 2913 - End
	
	lnvo_labels.of_labels2(is_inv_type,string(li_header_height),'40',string(li_y_pos))
end if
// FNC 07/23/98 End
	
destroy(lnvo_labels)

//AJS 10/22/98 Track Fix header lines
This.uf_add_title()
//AJS 10/22/98 Track Fix line counts end

// need to go thru all istr_key_columns and set the columns and their headers in the 
// datawindow to invisible */
if not istr_key_columns.icn.visible then	
	IF	Len (istr_key_columns.icn.col_name)	>	0			THEN
		ls_modify	=	istr_key_columns.icn.col_name + ".visible='0' "	+	&
							istr_key_columns.icn.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.icn_key2.visible then							// FNC 02/08/00 Start
	IF	Len (istr_key_columns.icn_key2.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.icn_key2.col_name + ".visible='0' "	+	&
							istr_key_columns.icn_key2.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.icn_key3.visible then	
	IF	Len (istr_key_columns.icn_key3.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.icn_key3.col_name + ".visible='0' "	+	&
							istr_key_columns.icn_key3.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.icn_key4.visible then	
	IF	Len (istr_key_columns.icn_key4.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.icn_key4.col_name + ".visible='0' "	+	&
							istr_key_columns.icn_key4.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.icn_key5.visible then	
	IF	Len (istr_key_columns.icn_key5.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.icn_key5.col_name + ".visible='0' "	+	&
							istr_key_columns.icn_key5.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.icn_key6.visible then	
	IF	Len (istr_key_columns.icn_key6.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.icn_key6.col_name + ".visible='0' "	+	&
							istr_key_columns.icn_key6.col_name + "_t.visible='0'"
	END IF
end if																			// FNC 02/08/00 End

if not istr_key_columns.date_paid.visible then	
	IF	Len (istr_key_columns.date_paid.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.date_paid.col_name + ".visible='0' "	+	&
							istr_key_columns.date_paid.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.from_date.visible then	
	IF	Len (istr_key_columns.from_date.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.from_date.col_name + ".visible='0' "	+	&
							istr_key_columns.from_date.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.recip_id.visible then	
	IF	Len (istr_key_columns.recip_id.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.recip_id.col_name + ".visible='0' "	+	&
							istr_key_columns.recip_id.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.prov_id.visible then	
	IF	Len (istr_key_columns.prov_id.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.prov_id.col_name + ".visible='0' "		+	&
							istr_key_columns.prov_id.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.allowed_srvc.visible then	
	IF	Len (istr_key_columns.allowed_srvc.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.allowed_srvc.col_name + ".visible='0' "	+	&
							istr_key_columns.allowed_srvc.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.invoice_type.visible then	
	IF	Len (istr_key_columns.invoice_type.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.invoice_type.col_name + ".visible='0' "	+	&
							istr_key_columns.invoice_type.col_name + "_t.visible='0'"
	END IF
end if

if not istr_key_columns.rev_code.visible then	
	IF	Len (istr_key_columns.rev_code.col_name)	>	0			THEN
		ls_modify	+=	istr_key_columns.rev_code.col_name + ".visible='0' "	+	&
							istr_key_columns.rev_code.col_name + "_t.visible='0'"
	END IF
end if
IF	Len (ls_modify)	>	0		THEN
	ls_rc	=	idw_report.Modify (ls_modify)
END IF

// retrieve data 
iuo_query.of_SetDwLimit(gc_dw_limit)				//12-31-97 FNC

li_sql_count = upperbound(ls_sql_statement)

// FDG 07/17/00 Begin
IF	ls_fastquery_ind	=	'Y'		THEN
	ls_syntax	=	idw_report.object.datawindow.syntax
	li_rc			=	idw_break.Create (ls_syntax)
	li_rc			=	idw_break.SetTransObject (Stars2ca)
ELSE
	li_rc			=	idw_report.SetTransObject (Stars2ca)
END IF
// FDG 07/17/00 End

if li_rc = -1 then
	messagebox('ERROR','Error performing SetTransObject in U_NVO_View.UE_Tabpage_View_Create_Report')
	return -1
end if

idw_report.SetRedraw( FALSE )

for i =1 to li_sql_count
	// FDG 07/17/00 - Account for FastQuery
	IF	ls_fastquery_ind	=	'Y'		THEN
		// 12/06/2000	GaryR	Stars 4.7 DataBase Port
		gnv_sql.of_SetRowLimit( ls_sql_statement[i], ll_fastquery_rows, Stars2ca )
		li_rc		=	idw_break.SetSQLSelect (ls_sql_statement[i])
	ELSE
		li_rc		=	idw_report.SetSQLSelect (ls_sql_statement[i])
	END IF
	if li_rc = -1 then return -1

	IF	gv_cancel_but_clicked	=	TRUE		THEN
		ll_rc	=	-2																// FDG 11/25/98
	ELSE
		iuo_query.of_set_istr_key_columns(istr_key_columns)		// FNC 06/16/98
		// FDG 07/17/00 - Account for FastQuery
		IF	ls_fastquery_ind	=	'Y'		THEN
			ll_rc	=	idw_break.Event ue_Retrieve()
			// FDG 02/27/01 begin
			IF	ll_rc	>=	ll_fastquery_rows		THEN
				lb_fastquery_warning	=	TRUE
			END IF
			// FDG 02/27/01 end
		ELSE
			ll_rc	=	idw_report.Event ue_Retrieve()					// 02/23/98 JTM	// FDG 11/25/98
		END IF
		istr_key_columns = iuo_query.of_get_istr_key_columns()	// FNC 06/16/98
	END IF
	// FDG 11/25/98 - Check ll_rc instead of li_rc
	if ll_rc < 0 then 
		// FDG 03/24/98 begin
		CHOOSE CASE ll_rc
			CASE -2
				MessageBox('Cancel','Report cancelled!')
				ll_rowcount	=	idw_report.rowcount()
				iuo_query.Event	ue_set_count_view()					// FDG 05/12/98
				Exit
			CASE ELSE
				MessageBox('ERROR','Error retrieving report in u_nvo_view.ue_tabpage_view_create_report', StopSign!)
		END CHOOSE

		return ll_rc
		// FDG 03/24/98 end
	end if																		// 02/23/98 JTM end
next	

idw_report.SetRedraw( TRUE )
// FDG 03/29/01 - Commit the queries
Stars1ca.of_commit()
Stars2ca.of_commit()

// FDG 07/17/00 - Account for FastQuery
IF	ls_fastquery_ind	=	'Y'		THEN
	IF	idw_break.RowCount()	>	0	THEN
		idw_report.object.data	=	idw_break.object.data
	ELSE
		idw_report.Reset()
	END IF
	idw_break.Reset()
	
	// 12/06/2000	GaryR	Stars 4.7 DataBase Port
	gnv_sql.of_SetRowLimit( ls_sql_statement[1], 0, Stars2ca )
END IF

iuo_query.Event	ue_set_count_view()									// FDG 05/12/98
ll_rowcount	=	idw_report.rowcount()

if ll_rowcount = 0 then
	messagebox('INFORMATION','Your query has not returned any rows')
	iuo_query.Event	ue_selecttab(IC_SEARCH)							// FDG 06/15/98
	Return 0																		// FDG 3/13/98
end if

// FDG 09/23/98 begin
// Because multiple retrieves are performed on idw_report, break with totals
//	can get messed up.  Moving the data out and then back in will
//	resynchronize the break with totals.

li_upper	=	UpperBound (istr_break_info.cols)

IF	li_upper	>	0		THEN

	// FDG 07/17/00 - Account for FastQuery
	IF	ls_fastquery_ind	<>	'Y'		THEN
		ls_syntax	=	idw_report.object.datawindow.syntax
		li_rc = idw_break.create(ls_syntax)
		if li_rc = -1 then 
			return -1
		end if
	END IF
	idw_break.object.data	=	idw_report.object.data
	// FDG 09/30/98 begin
	// Sort the data in the same order as the breaks
	// FDG 09/30/98 begin
	// Sort the data in the same order as the breaks
	// LMC Track# 2626 
	// Sort the data in the order that the user specified (Ascending or Descending)
	FOR li_idx	=	1 TO li_upper
		string ls_order
		if upper(istr_break_info.cols[li_idx].sort) = 'ASC' then
			ls_order = ' A'
		else
			ls_order = ' D'
		end if
		ls_sort	=	ls_sort	+	', #'	+	istr_break_info.cols[li_idx].col_number	+	ls_order
	NEXT
	ls_sort	=	Mid (ls_sort, 2)	// Truncate leading ','
	idw_break.Setsort (ls_sort)
	idw_break.Sort()
	// FDG 09/30/98 end
	idw_report.Reset()
	idw_report.RowsDiscard (1, ll_rowcount, Primary!)
	idw_report.object.data	=	idw_break.object.data
END IF
// FDG 09/23/98 end

// FDG 02/27/01 begin
// If one or months reached the maximum row threshold for fastquery, then
//	display a warning message.
IF	lb_fastquery_warning	=	TRUE		THEN
	MessageBox ('Warning', 'The maximum # of rows limit was reached.  More rows match your query '	+	&
					'than are displayed.')
END IF
// FDG 02/27/01 end

idw_report.Object.DataWindow.ReadOnly='Yes'
setpointer(arrow!)

Return 0
end event

event ue_tabpage_view_list(string as_type);//*********************************************************************************
// Event Name:	u_nvo_view.ue_tabpage_view_list
//
//	Arguments:	as_type
//
// Returns:		None
//
//	Description:
//		This event is initially triggered from m_view.m_list.m_providers and
//		m_view.m_list.m_patients to open a window with a list of provider or
//		patient information for the id's in the report.
//
//*********************************************************************************
// 01-14-98 FDG	Created
//	03/04/98	FDG	Use temp table NVO as an instance variable
// 09/24/98	FNC	Track 1712. If money totals are on subtract 1 from rowcount because
//						the last row is not part of the report it just contains the totals.
//	12/08/00	FDG	Stars 4.7.  Use of_insert instead of of_execute to insert data
//						because duplicate inserts must be ignored.
// 03/21/01	FDG	Stars 4.7.	When creating a temp table, pass the invoice type and
//						the correct column name associated with the invoice type.
// 10/14/04 MikeF Track 3650d	Replace local n_cst_dict with global
//	09/10/09	GaryR	QEN.650.5229.004	Remove obsolete money/unit totals logic
//
//*********************************************************************************

sx_list_parms					lstr_list_parms
n_cst_temp_table_attrib		lnv_temp_parms		//	Temp table parms

Long			ll_row,					&
				ll_rowcount
Integer		li_rc,					&
				li_col
String		ls_id,					&
				ls_value,				&
				ls_sql,					&
				ls_temp_table_name

//	Get the column name for idw_report
IF	as_type	=	ics_providers		THEN
	ls_id		=	ics_prov_id
	lnv_temp_parms.is_inv_type		=	gnv_dict.Event	ue_get_inv_type (ics_providers)		// FDG 03/21/01
ELSE
	ls_id		=	ics_recip_id
	lnv_temp_parms.is_inv_type		=	gnv_dict.Event	ue_get_inv_type (ics_enrollee)		// FDG 03/21/01
END IF

//	Make sure the column exists in idw_report
li_col	=	This.uf_find_column_number (ls_id)

IF	li_col	<	1		THEN
	MessageBox ('Error', 'The ' + as_type + ' list cannot ' + &
					'be displayed because they do not exist ' + &
					'in the report.')
	Return
END IF

//	Create the temporary table
lnv_temp_parms.is_function						=	ics_create
lnv_temp_parms.istr_cols[1].is_col_name	=	ls_id						// FDG 03/21/01
lnv_temp_parms.istr_cols[1].is_data_type	=	'char(32)'
lnv_temp_parms.istr_index_cols[1].is_index_col[1]	=	ls_id			// FDG 03/21/01
lnv_temp_parms.istr_index_cols[1].is_index_type		=	ics_ignore_dup_key
lnv_temp_parms.ii_request						=	lnv_temp_parms.ici_temp_table		// FDG 03/21/01

inv_temp_table.of_execute_sql (lnv_temp_parms)
ls_temp_table_name	=	inv_temp_table.of_get_table_name()
ll_rowcount	=	idw_report.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_value		=	idw_report.GetItemString (ll_row, ls_id)
	// FDG 03/21/01 - Use actual column name instead of ics_id
	ls_sql		=	"Insert Into "	+	ls_temp_table_name	+	&
						" (" + ls_id + ") Values ('"		+	ls_value	+	"') "		// FDG 03/21/01
	//					" (" + ics_id + ") Values ('"		+	ls_value	+	"') "		// FDG 03/21/01
	// FDG 12/08/00 - of_insert ignores duplicate inserts.
	li_rc		=	Stars2ca.of_insert (ls_sql)
	IF	li_rc	<	0			THEN
		MessageBox ('Error', 'Insert into ' + ls_temp_table_name +	&
						' failed in u_nvo_view.ue_tabpage_view_list.~n~r' + &
						'  SQL =' + ls_sql + '.')
		Return
	END IF
NEXT

IF	Stars2ca.of_commit()	<	0	THEN
	MessageBox ('Error', 'Error commiting in u_nvo_view.ue_tabpage_view_list.')
	Return
END IF

//	Open w_prov_pat_list
lstr_list_parms.parm_type	=	as_type
lstr_list_parms.tmp_table	=	ls_temp_table_name

// The temp table will be dropped in the close event of w_pat_prov_list.
OpenSheetWithParm (w_prov_pat_list, lstr_list_parms, MDI_main_frame, help_menu_position, Layered!)
end event

event type long ue_tabpage_view_unique_count(string as_type);//*********************************************************************************
// Event Name:	u_nvo_view.ue_tabpage_view_unique_count
//
//	Arguments:	as_type-	Values:
//								ICN			unique count of ICNs
//								PROVIDERS	unique count of providers
//								PATIENTS		unique count of patients
//								REVENUE		unique count of revenue codes
//								PATSRVC		unique count of patients with allowed services
//												greater than zero.
//
// Returns:		Long
//
//	Description:
//		This event is initially triggered from m_view.m_uniquecounts to display
//		unique counts of the "as_type" passed in.
//
//	Note:
//		The logic for global function fx_unique_count is moved to this script.
//		However, a datawindow will be used to determine the unique counts instead
//		of inserting to user_temp_key.
//
//*********************************************************************************
//
// 01/14/98 FDG	Created
//	07/15/98	FDG	Track 1510.  Determine if Money/Units totals were generated. 
//						If so, the count could be off by 1.
//	04/01/99 FDG	Track 2111c.  Script rewritten to add performance improvements.
// 03/27/00 FNC	Track 2576 Starcare. Remove null from value field so it can be
//						accurately compared.
// 05/24/00 KTB   Track 2888 Starcare. Fixed a line of code delaing with revenue code.
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks.
//	09/10/09	GaryR	QEN.650.5229.004	Remove obsolete money/unit totals logic
//
//*********************************************************************************

Integer	li_col_number,			&
			li_srvc_col =	0,		&
			li_alw_srvc
String	ls_value,				&
			ls_prev_value = '',	&
			ls_sort
Long		ll_row,					&
			ll_rowcount,			&
			ll_count_row,			&
			ll_count

n_ds		lds_count

//	Create the datastore to store the unique count
lds_count		=	CREATE	n_ds
lds_count.DataObject	=	'd_user_temp_key'
lds_count.SetTransObject (Stars2ca)

ll_rowcount		=	idw_report.RowCount()

//	Get the column number to use in idw_report
CHOOSE CASE Upper (as_type)
	CASE ics_icn
		li_col_number	=	istr_key_columns.icn.col_number
		li_srvc_col		=	0
		IF li_col_number > 0  THEN
			lds_count.object.temp_key.current  =  idw_report.object.icn.current
		END IF
	CASE ics_providers
		li_col_number	=	istr_key_columns.prov_id.col_number
		li_srvc_col		=	0
		IF li_col_number > 0  THEN
			lds_count.object.temp_key.current  =  idw_report.object.prov_id.current
		END IF
	CASE ics_patients
		li_col_number	=	istr_key_columns.recip_id.col_number
		li_srvc_col		=	0
		IF li_col_number > 0  THEN
			lds_count.object.temp_key.current  =  idw_report.object.recip_id.current
		END IF
	CASE ics_revenue
		IF	istr_key_columns.rev_code.col_number	=	0		THEN
			ll_count		=	This.Event	ue_tabpage_view_unique_counts_rev()
			Return	ll_count
		ELSE
			li_col_number	=	istr_key_columns.rev_code.col_number
			li_srvc_col		=	0
			IF li_col_number > 0  THEN
			//KTB
				lds_count.object.temp_key.current  =  idw_report.object.revenue_code.current
			//End KTB
			END IF
		END IF
	CASE ics_patsrvc
		li_col_number	=	istr_key_columns.recip_id.col_number
		li_srvc_col		=	istr_key_columns.allowed_srvc.col_number
		IF li_col_number > 0  THEN
			IF	li_srvc_col >  0  THEN
				FOR ll_row = 1 TO ll_rowcount
					ls_value		=	idw_report.GetItemString (ll_row, li_col_number)
					li_alw_srvc	=	idw_report.GetItemNumber (ll_row, li_srvc_col)
					IF	li_alw_srvc	>	0		THEN
						ll_count_row	=	lds_count.InsertRow(0)
						lds_count.object.temp_key	[ll_count_row]		=	ls_value
					END IF
				NEXT
			ELSE
				lds_count.object.temp_key.current  =  idw_report.object.recip_id.current
			END IF
		END IF
	CASE ELSE
		MessageBox ('Logic Error', 'Invalid parm passed to u_nvo_view.' + &
						'ue_tabpage_view_unique_count.')
		Destroy	lds_count				// FDG 12/06/01
		Return -1
END CHOOSE

//	Sort lds_count in temp_key order
lds_count.SetSort ('temp_key A')
lds_count.Sort()

//	Eliminate any duplicate temp_key value so that temp_key is always	unique
ll_rowcount	=	lds_count.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_value		=	lds_count.object.temp_key [ll_row]
	if isnull(ls_value) then			// FNC 03/27/00 Start
		ls_value = ''
	end if									// FNC 03/27/00 End
	IF	ls_value	<>	ls_prev_value		THEN
		ll_count ++
	END IF
	ls_prev_value	=	ls_value
NEXT

Destroy	lds_count
Return ll_count
end event

event ue_tabpage_view_mapping;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	u_nvo_view					ue_tabpage_view_mapping
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event will be called by im_view.m_reporttools.m_map to open the Map Interface 
// window and eventually MapInfo.  First it will tag the columns in the datawindow that 
// can be used in the range from the map legend.  This is determined by entries in the
// stars_win_parm table.  Then open w_geo_interface passing it the datawindow and the
// data source invoice type.  The code for this is taken from w_claim_rpt_parent.wf_map 
// and w_claim_rpt_parent.wf_tag_mapping().
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
//	JTM		01/30/98	Created.
//
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//							to prevent locking.	
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer i_Return
Long ll_count, ll_index
sx_map_struct lsx_map  /* defined in stmap.pbl */
n_Ds ds_stars_win_parm
String ls_Select

ds_stars_win_parm = CREATE n_ds
ds_stars_win_parm.DataObject = "d_get_tag_cols"
ds_stars_win_parm.SetTransObject(stars2ca)

/* get tags columns and tag the columns in the report datawindow*/
ll_count = ds_stars_win_parm.Retrieve(is_inv_type,gv_sys_dflt)
	
if ll_count > 0 then							// FNC 04/14/99
	stars2ca.of_commit()						// FNC 04/14/99
	for ll_index = 1 to ll_count
		idw_report.modify(ds_stars_win_parm.object.col_name[ll_index] + &
		 ".tag = '" + ds_stars_win_parm.object.a_dflt[ll_index] + "'")
	next
end if											// FNC 04/14/99

DESTROY ds_stars_win_parm
	
//set parms.
lsx_map.dw = idw_report
lsx_map.table_type = is_inv_type

/* open window */
opensheetwithparm(w_geo_interface, lsx_map, MDI_main_frame, help_menu_position, layered!)
end event

event type long ue_tabpage_view_unique_counts_rev();//*********************************************************************************
// Event Name:	u_nvo_view.ue_tabpage_view_unique_counts_rev
//
//	Arguments:	None
//
// Returns:		Long
//
//	Description:
//		This event is initially triggered from event ue_tabpage_view_unique_count
//		to get the unique revenue codes when they are not in the datawindow.  This 
//		event resembles w_claim_rpt_parent.wf_revenue_count().  Only the basic 
//		logic is taken from this function.
//
//		If the data type is a subset, then just put the ICNs into a temp table and
//		join the temp table to the subset table to get the revenue codes.  
//
//		The situation is different if the data type is base.  Since the data may 
//		be found in multiple tables, you must determine which tables to search for
//		revenue codes.  You must first get the ICN's and payment date.  Then 
//		resolve the payment date to the table number and put the ICN and table 
//		number into the temp table.  As determining the table numbers, put them in 
//		a list.  Once the temp table is loaded, then loop thru the list of table 
//		numbers loading anothertemp table with revenue codes by joining the temp 
//		table to the revenue tables plus table numbers.
//
//		Finally, return a distinct count from the temp table.  Currently in the
//		system, USER_TEMP_KEY and USER_TEMP_CCN_LINE are used as the temp tables.
//
//*********************************************************************************
// 01-14-98 FDG	Created
//	03/04/98	FDG	Use the temp table service.
//	04/20/98	FDG	Track 1092.  
//						1.	The creation of the temporary tables should 
//							be done in Stars2ca because Stars1ca is static.
//						2. When an error occurs, drop the temp tables.
//	09/04/98	FDG	Track 1569.  Ignore the rows that are Money/Unit totals.
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
//	12/08/00	FDG	Stars 4.7.  Use of_insert instead of of_execute to insert data
//						because duplicate inserts must be ignored.
//	01/15/01	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase Name
//	03/12/01	FDG	Stars 4.7.  Dynamically get the subset prefix (instead of 'SUB_MEDC_')
//										Generate the SQL so that the table names for revenue codes
//										can be created.
//	03/20/01	FDG	Stars 4.7.  Pass the invoice type when creating a temp table.
//	11/20/01	GaryR	Track 2880c	Performing unique revenue count on a subset causes and error.
//	12/06/01	FDG	Track 2497, 2561.  Prevent memory leaks.
//	01/14/02	FDG	Track 2618d. Get the payment date info in order to resolve track 2880c.
//	02/18/02	FDG	Track 2771d. Selection of the distinct revenue codes must join against
//						the icn temp table.  Must also account for the payment date having or
//						not having surrounding parenthesis.
// 10/15/04	MikeF SPR 3650d Replaced refernce to uf_get_data_type with gnv_dict
//	09/10/09	GaryR	QEN.650.5229.004	Remove obsolete money/unit totals logic
//
//*********************************************************************************

n_cst_temp_table_attrib		lnv_temp_parms		//	Temp table parms
n_cst_tableinfo_attrib		lnv_revenue			// FDG 03/12/01

Long		ll_row,				&
			ll_rowcount,		&
			ll_ros_rowcount,	&
			ll_ros_row,			&
			ll_rev_count,		&
			ll_count
			
String	ls_sql,				&
			ls_rev_table,		&
			ls_icn_table,		&
			ls_subset_table,	&
			ls_claim_table,	&
			ls_datatype,		&
			ls_icn,				&
			ls_rev_tbl_type,	&
			ls_revenue_code,	&
			ls_rev_where,		&
			ls_base_db,			&
			ls_where
			
Integer	li_tbl_no,			&
			li_rc,				&
			li_upper,			&
			li_idx,				&
			li_pos,				&
			li_tbl_no_array[100]

DateTime	ldt_payment_date,		&
			ldt_ros_from_date,	&
			ldt_ros_to_date

ls_rev_tbl_type	=	'%'	+	istr_key_columns.rev_tbl_type	+	'%'

IF	is_data_type	=	ics_subset		THEN
//KTB
	Select	Count(*)		Into	:ll_count
	  From	sub_step_cntl
	 Where	subc_id	=	Upper( :is_subset_id )
	   and	inv_type	=	Upper( :is_inv_type )
		and	dep_tbls	Like	Upper( :ls_rev_tbl_type )
	 Using	Stars2ca ;
//END KTB
	IF	Stars2ca.of_check_status()	<	0 OR	ll_count	<	1 THEN
		MessageBox ('Error', 'No ' + is_inv_type + ' data for this subset.')
		Return -1
	else												// 04/14/99 FNC
		stars2ca.of_commit()						// 04/14/99 FNC
	END IF
END IF

// FDG 01/14/02. Track 2618d.  If there is no revenue invoice type, there will be no unique
//	revenue codes.
IF	IsNull( istr_key_columns.rev_tbl_type )		&
OR	Trim( istr_key_columns.rev_tbl_type )	= ''	THEN
	Return	0
END IF

//	Get the data type for 'ICN'
ls_datatype	=	gnv_dict.event ue_get_elem_data_type( is_inv_type, ics_icn)

// FDG 03/12/01 - Get the base table names and payment date info.  This is used to 
//						get the revenue table names.  The base table names were generated
//						within ue_tabpage_view_create_report

//	11/20/01	GaryR	Track 2880c - Begin
IF	is_data_type <> ics_subset		THEN
	lnv_revenue.is_inv_type				=	istr_key_columns.rev_tbl_type
	// FDG 01/14/02. Track 2618d.  Get the payment_date info.
	This.uf_set_nvo_create_sql( TRUE )
	li_rc		=	This.Event	ue_create_sql()
	inv_base	=	iuo_nvo_create_sql.uf_get_base_tables()
	lnv_revenue.is_operand				=	inv_base.is_operand
	lnv_revenue.is_paid_date			=	inv_base.is_paid_date
	This.uf_set_nvo_create_sql( FALSE )
	IF	li_rc	<	0		THEN
		Return	-1
	END IF
	// FDG 01/14/02 end
	lnv_revenue.il_period_key			=	inv_base.il_period_key
	lnv_revenue.is_where_paid_date	=	inv_base.is_where_paid_date
	
	li_rc								=	gnv_server.of_GetClaimsTableNames (lnv_revenue)
	
	IF	lnv_revenue.il_rc			<	0			THEN
		MessageBox ('Error', lnv_revenue.is_message)
		Return	-1
	END IF
	
	li_upper							=	UpperBound (lnv_revenue.is_base_table)
END IF
//	11/20/01	GaryR	Track 2880c - End
// FDG 03/12/01 end

// Build the revenue temp table - This will be the same for both subset
//	and base

lnv_temp_parms.is_function						=	ics_create
lnv_temp_parms.istr_cols[1].is_col_name	=	ics_revenue_code
lnv_temp_parms.istr_cols[1].is_data_type	=	ls_datatype
lnv_temp_parms.istr_index_cols[1].is_index_col[1]	=	ics_revenue_code
lnv_temp_parms.istr_index_cols[1].is_index_type		=	ics_ignore_dup_key
lnv_temp_parms.is_inv_type						=	istr_key_columns.rev_tbl_type		// FDG 03/20/01
lnv_temp_parms.ii_request						=	lnv_temp_parms.ici_temp_table		// FDG 03/20/01

li_rc	=	inv_temp_table.of_execute_sql (lnv_temp_parms)		//	Build the table

IF	li_rc	<	0		THEN
	Return -1
END IF

// FDG 03/14/01 - Get the database name for the revenue table
Select db 
into :ls_base_db
From dictionary 
Where elem_type = 'TB' and 
		elem_tbl_type = Upper( :istr_key_columns.rev_tbl_type ) 
Using stars2ca;

if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error reading dictionary to retrieve revenue database name in u_nvo_view.ue_tabpage_view_unique_counts_rev')
	return -1
elseif isnull(ls_base_db) then
	stars2ca.of_commit()						// FNC 04/13/99			
	messagebox('ERROR','The value for DB in the dictionary for Elem Type = "TB" and Elem tbl type = ' + &
					istr_key_columns.rev_tbl_type + ' is null. Report processing is cancelled')
	return -1
else												// FNC 04/13/99
	stars2ca.of_commit()						// FNC 04/13/99			
end if

ls_base_db = gnv_sql.of_get_database_prefix( ls_base_db )
// FDG 03/14/01 end

//	01/15/01	GaryR	Stars 4.7 DataBase Port
ls_rev_table	=	gnv_sql.of_get_database_prefix( Stars2ca.Database ) +	inv_temp_table.of_get_table_name()

ll_rowcount		=	idw_report.RowCount()

IF	is_data_type	=	ics_subset		THEN
	//	Create the ICN temp table
	lnv_temp_parms.is_function						=	ics_create
	lnv_temp_parms.istr_cols[1].is_col_name	=	ics_icn
	lnv_temp_parms.istr_cols[1].is_data_type	=	ls_datatype
	lnv_temp_parms.istr_index_cols[1].is_index_col[1]	=	ics_icn
	lnv_temp_parms.istr_index_cols[1].is_index_type		=	ics_ignore_dup_key
	li_rc	=	inv_temp_table.of_execute_sql (lnv_temp_parms)		//	Build the table
	IF	li_rc	<	0		THEN
		inv_temp_table.of_drop_table(ls_rev_table)					// FDG 04/20/98
		Return -1
	END IF
	//	01/15/01	GaryR	Stars 4.7 DataBase Port
	ls_icn_table	=	gnv_sql.of_get_database_prefix( Stars2ca.Database ) +	inv_temp_table.of_get_table_name()
	// FDG 04/20/98
	//	Load the ICN temp table with ICN's from the datawindow
	FOR ll_row	=	1	TO	ll_rowcount
		ls_icn	=	idw_report.GetItemString (ll_row, istr_key_columns.icn.col_number)
		ls_sql	=	"Insert Into " +	ls_icn_table + " (" + ics_icn + ") Values('" + &
						ls_icn + "')"

		IF	Stars2ca.of_insert (ls_sql)	<	0		THEN
			inv_temp_table.of_drop_table(ls_icn_table)			// FDG 04/20/98
			inv_temp_table.of_drop_table(ls_rev_table)			// FDG 04/20/98
			Return -1	
		END IF
	NEXT
	// Load the revenue code temp table joining the ICN temp table
	//	to the subset tables.
	ls_subset_table	=	" " + gnv_sql.of_get_database_prefix( Stars2ca.database ) + &
								gnv_sql.of_get_subset_prefix() + istr_key_columns.rev_tbl_type + "_" + is_subset_id
	Stars2ca.of_commit()				// FDG 02/18/02

	ls_sql	=	"Insert Into " + ls_rev_table + &
					" Select Distinct a.revenue_code From " + ls_subset_table + &
					" a, " + ls_icn_table + " b Where a.icn = b.icn "

	IF	Stars2ca.of_execute (ls_sql)	<	0		THEN
		inv_temp_table.of_drop_table(ls_icn_table)			// FDG 04/20/98
		inv_temp_table.of_drop_table(ls_rev_table)			// FDG 04/20/98
		Return -1
	END IF
ELSE
	// FDG 03/14/01 - Don't use tbl_no since lnv_revenue has the list of revenue tables.
	// Create the ICN temp table - Columns ICN and tbl_no
	lnv_temp_parms.is_function						=	ics_create
	lnv_temp_parms.istr_cols[1].is_col_name	=	ics_icn
	lnv_temp_parms.istr_cols[1].is_data_type	=	ls_datatype
	lnv_temp_parms.istr_index_cols[1].is_index_col[1]	=	ics_icn
	lnv_temp_parms.istr_index_cols[1].is_index_type		=	ics_ignore_dup_key
	li_rc	=	inv_temp_table.of_execute_sql (lnv_temp_parms)		//	Build the table	// FDG 01/14/02
	IF	li_rc	<	0		THEN
		inv_temp_table.of_drop_table(ls_rev_table)			// FDG 04/20/98
		Return -1
	END IF

	//	01/15/01	GaryR	Stars 4.7 DataBase Port
	ls_icn_table	=	gnv_sql.of_get_database_prefix( Stars2ca.Database ) +	inv_temp_table.of_get_table_name()
	// FDG 03/14/01 - Don't use ros_directory (tbl_no) since lnv_revenue has the list of revenue tables.
	FOR ll_row	=	1	TO	ll_rowcount
		ls_icn				=	idw_report.GetItemString (ll_row, istr_key_columns.icn.col_number)
		ldt_payment_date	=	idw_report.GetItemDateTime (ll_row, istr_key_columns.date_paid.col_number)

		ls_sql	=	"Insert Into " +	ls_icn_table + " (" + ics_icn + &
						") Values('" + ls_icn + "')"
		// FDG 12/08/00 - Allow for duplicate inserts
		IF	Stars2ca.of_insert (ls_sql)	<	0		THEN
			inv_temp_table.of_drop_table(ls_icn_table)			// FDG 04/20/98
			inv_temp_table.of_drop_table(ls_rev_table)			// FDG 04/20/98
			Return -1
		END IF
	NEXT
	// FDG 03/14/01 - Don't use ros_directory (tbl_no) since lnv_revenue has the list of revenue tables.
	//	Load the revenue code temp table joining the ICN temp table
	//	to the claim tables - using the tbl_no array to determine which
	//	claim table to join to.
	//	NOTE: The revenue table is in Stars1ca
	IF	li_upper	<	1		THEN
		// No revenue table - Cannot do revenue counts.
		inv_temp_table.of_drop_table(ls_icn_table)			// FDG 04/20/98
		inv_temp_table.of_drop_table(ls_rev_table)			// FDG 04/20/98
		Return 0															// FDG 04/20/98
	END IF

	Stars2ca.of_commit()				// FDG 02/18/02
	Stars1ca.of_commit()				// FDG 02/18/02
	n_ds		lds_revenue
	lds_revenue	=	CREATE	n_ds
	lds_revenue.DataObject	=	'd_distinct_revenue_code'
	lds_revenue.SetTransObject (Stars1ca)
	// FDG 01/14/02. Track 2618d. begin
	// Remove the original invoice type from lnv_revenue.is_where_paid_date
	li_pos	=	Pos( lnv_revenue.is_where_paid_date, '.' )
	IF	li_pos	>	0		THEN
		// FDG 03/21/02 - Payment date may or may not have parenthesis
		IF	Left (lnv_revenue.is_where_paid_date, 1)	=	'('		THEN
			// Parenthesis surrounds payment_date criteria
			lnv_revenue.is_where_paid_date	=	Left( lnv_revenue.is_where_paid_date, li_pos - 3 )	+	&
															Mid ( lnv_revenue.is_where_paid_date, li_pos + 1 )
			ls_where	=	"(A."	+	Mid(lnv_revenue.is_where_paid_date, 2)		// FDG 02/18/02
		ELSE
			lnv_revenue.is_where_paid_date	=	Mid ( lnv_revenue.is_where_paid_date, li_pos + 1 )
			ls_where	=	"A."	+	lnv_revenue.is_where_paid_date
		END IF
		// FDG 03/21/02 end	
	ELSE
		ls_where	=	""
	END IF
	// FDG 01/14/02 end
	FOR li_idx	=	1	TO	li_upper
		IF	Trim(ls_where)	>	" "	THEN
			ls_where	=	ls_where	+	" AND"
		END IF
		ls_where	=	ls_where	+	" A.ICN = B.ICN"
		ls_sql	=	"SELECT DISTINCT A.REVENUE_CODE FROM "		+	&
						ls_base_db	+	lnv_revenue.is_base_table [li_idx]	+	" A, "	+	&
						ls_icn_table	+	" B WHERE "	+	ls_where
		
		lds_revenue.SetSQLSelect (ls_sql)
		ll_rowcount	=	lds_revenue.Retrieve()
		FOR	ll_row	=	1	TO	ll_rowcount
			ls_revenue_code	=	lds_revenue.object.revenue_code [ll_row]
			ls_sql	=	"Insert Into " +	ls_rev_table + " (" + ics_revenue_code + ") Values('" + &
							ls_revenue_code + "')"
			// of_insert() ignores duplicate keys
			IF	Stars2ca.of_insert (ls_sql)	<	0		THEN
				inv_temp_table.of_drop_table(ls_icn_table)				// FDG 04/20/98
				inv_temp_table.of_drop_table(ls_rev_table)				// FDG 04/20/98
				IF	IsValid(lds_revenue)	THEN	Destroy	lds_revenue		// FDG 12/06/01
				Return -1
			END IF
		NEXT
	NEXT
END IF

IF	IsValid(lds_revenue)	THEN	Destroy	lds_revenue		// FDG 12/06/01

// Use the Select Count(*) service to get the count
This.uf_set_nvo_count (TRUE)		// Create the service

ls_sql	=	"Select Distinct Count(*) From "	+	ls_rev_table
ll_rev_count	=	inv_count.uf_get_count (ls_sql)

//	11/20/01	GaryR	Track 2880c
Stars2ca.of_commit()
Stars1ca.of_commit()

//	Drop the tables
inv_temp_table.of_drop_table(ls_icn_table)
inv_temp_table.of_drop_table(ls_rev_table)

Stars2ca.of_commit()
Stars1ca.of_commit()

Return ll_rev_count
end event

event ue_tabpage_view_detail();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	uo_query						ue_tabpage_view_detail
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event will be called by im_view.m_claimoperations.m_detail to allow the user to 
// view the dependent information related to a claim selected from the report datawindow. 
// The code for this will be taken from w_claim_rpt_parent.wf_detail().  It must load a 
// structure (sx_details_structure) with certain fields and open w_detail_main with the 
// structure as a parm.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	01/15/98		Created.
//	J.Mattis	02/09/98		Changed refs. from this to uo_Query for istr_key_columns to
//								test theory that uf_set_sx_keys is not working.
//	FNC		06/10/98		Track 1312. Open w_detail_main as original so it is
//								not resized.
//	FDG		06/15/98		Track ????. Don't directly access uo_query attributes.
// FNC		06/22/98		Track 1309. If is_source_subset_id is blank, set
//								lsx_details.subset_id = is_subset id. This means that it is
//								subset view.
// FNC		02/08/00		Unique Key TS2072 - Add flexiblity for client to select
//								custom claim key fields.
//	FDG 		03/14/01		Stars 4.7.	Remove table_no since that depends on ros_directory.
//								ros_directory no longer exists in this release.
//	GaryR		07/11/01		Track 2359D Add payment date to where clause 
//								to avoid full table scan on partitioned tables.
//	GaryR		10/04/01		Track 2335D	Refresh the key structure so that when
//								a row changes in dw_report, it will be reflected.
//	GaryR		10/30/01		Track 2341d	Claim Detail error from Query Engine.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer		li_rc

sx_details_structure lsx_details 					// appmgr.pbl

n_cst_tableinfo_attrib	lnv_table					// FDG 03/14/01

istr_key_columns = iuo_query.of_get_istr_key_columns()	//	GaryR	10/04/01	Track 2335D

lsx_details.key1_value = istr_key_columns.icn.col_value			// FDG 06/15/98
// FNC 02/08/00 Start
//lsx_details.key2_value = Integer(istr_key_columns.icn_line_no.col_value)		// FDG 06/15/98
lsx_details.key1_name = istr_key_columns.icn.col_name
lsx_details.key1_data_type = istr_key_columns.icn.data_type
lsx_details.key2_name = istr_key_columns.icn_key2.col_name
lsx_details.key2_value = istr_key_columns.icn_key2.col_value
lsx_details.key2_data_type = istr_key_columns.icn_key2.data_type
lsx_details.key3_name = istr_key_columns.icn_key3.col_name
lsx_details.key3_value = istr_key_columns.icn_key3.col_value
lsx_details.key3_data_type = istr_key_columns.icn_key3.data_type
lsx_details.key4_name = istr_key_columns.icn_key4.col_name
lsx_details.key4_value = istr_key_columns.icn_key4.col_value
lsx_details.key4_data_type = istr_key_columns.icn_key4.data_type
lsx_details.key5_name = istr_key_columns.icn_key5.col_name
lsx_details.key5_value = istr_key_columns.icn_key5.col_value
lsx_details.key5_data_type = istr_key_columns.icn_key5.data_type
lsx_details.key6_name = istr_key_columns.icn_key6.col_name
lsx_details.key6_value = istr_key_columns.icn_key6.col_value
lsx_details.key6_data_type = istr_key_columns.icn_key6.data_type
// FNC 02/08/00 End

lsx_details.paid_date		=	istr_key_columns.date_paid.col_value	// FDG 04/11/01
//	GaryR		10/30/01		Track 2341d
IF istr_key_columns.date_paid.data_type <> "" THEN lsx_details.paid_date_col	=	istr_key_columns.date_paid.col_name		//	GaryR		07/11/01		Track 2359D

if Upper(Trim(is_inv_type)) = "MC" then
	/* resolve table type using code table */
	lsx_details.tbl_type = this.Event ue_tabpage_view_translate_invoice_type(istr_key_columns.invoice_type.col_value)
else
	lsx_details.tbl_type = is_inv_type
end if

if Upper(Trim(is_data_type)) = "BASE" then
	// Base data
	lsx_details.src_type = "SB"
	// FDG 03/14/01 - ue_tabpage_view_get_table_no reads ros_directory.  Remove it for 4.7.
	//lsx_details.table_no = this.Event ue_tabpage_view_get_table_no(istr_key_columns.date_paid.col_value)
	lnv_table.is_inv_type		=	lsx_details.tbl_type
	lnv_table.is_operand			=	'='
	lnv_table.is_paid_date		=	istr_key_columns.date_paid.col_value
	lnv_table.il_period_key		=	0
	li_rc								=	gnv_server.of_GetClaimsTableNames (lnv_table)
	IF	lnv_table.il_rc			<	0			THEN
		MessageBox ('Error', lnv_table.is_message)
		Return
	END IF
	IF	UpperBound (lnv_table.is_base_table)	<	1		THEN
		MessageBox ('Application Error', 'Could not retrieve table name in u_nvo_view.ue_tabpage_view_detail.'	+	&
						'  paid_date = '	+	istr_key_columns.date_paid.col_value	+	'.')
		Return
	END IF
	lsx_details.table_name	=	lnv_table.is_base_table[1]
	// FDG 03/14/01 end
else
	// Subset data
	lsx_details.src_type = "SS"
	if trim(is_source_subset_id) = '' then							// FNC 06/22/98 Start
		lsx_details.subset_id = is_subset_id
	else
		lsx_details.subset_id = is_source_subset_id
	end if																	// FNC 06/22/98 End
end if

opensheetwithparm(w_detail_main,lsx_details,MDI_main_frame,help_menu_position,original!)	// FNC 06/10/98
end event

event type string ue_tabpage_view_prov_pat_drilldown(string as_tag_value);//*********************************************************************************
// Event Name:	U_NVO_View.UE_Tabpage_View_Create_Report
//	Arguments:	None
// Returns:		None
//
//*********************************************************************************
// FNC	01/11/98	Created
//	FDG	06/15/98	Track ????. Don't directly access uo_query attributes.
//	GaryR	10/04/01	Track 2335D	Refresh the key structure so that when
//						a row changes in dw_report, it will be reflected.
//*********************************************************************************

/*Retrieve the appropriate patient or provider key depending on the value of the tag
argument passed into the event and return the value to the calling routine. */

String ls_key_val

istr_key_columns = iuo_query.of_get_istr_key_columns()	//	GaryR	10/04/01	Track 2335D

Choose Case as_tag_value
  Case "PT"  
	ls_key_val = istr_key_columns.recip_id.col_value		// FDG 06/15/98
  Case "PR"
	ls_key_val = istr_key_columns.prov_id.col_value			// FDG 06/15/98
End Choose

Return ls_key_val

end event

event type integer ue_drilldown_build_temp_table(ref sx_drilldown atr_drilldown);//*********************************************************************************
// Event Name:	u_nvo_view.UE_Drilldown_Build_Temp_Table
//
//	Arguments:	SX_Drilldown Astr_Drilldown (by reference)
//
// Returns:		Integer
//
//	Description:
// This event is called by w_query_engine.ue_parent_drilldown.  In the 
// structure parm only the path and column_flag are passed in.  The rest 
// of the structure is filled in thisevent to be used by the event 
//	ue_drilldown_load_new_query of the new uo_query.  This event is used 
// to create a temp table for the  info found in the report of this 
// uo_query and load the data into the table. First it must determine 
// the join key(s) by the path passed in.  Then must determine if the 
//	user has selected to have the columns from the first report included 
// in the second (column_flag is set to TRUE) and then determine the 
// data type and use those to create the temp table. The name of the 
// temp table is placed in is_drilldown_new_temp_table_name.  Once created 
// will loop thru the datawindow and insert the keys into the table. 
//
//*********************************************************************************
// 01-07-98 FNC 	Created
//*********************************************************************************
// 01-29-98 FNC	Use the sx_drilldown structure instead of separate instance 
//						variables
//	02/04/98	FDG	Check the embedded SQL status using of_check_status()
// 02/05/98 FNC	Add key columns to temp table even if not including previous cols
// 02/09/98	FNC	Change istr_drilldown.inv_type to is_inv_type because 
//						istr_drilldown.inv_type is not set until the source tab is 
//						drilldown.
// 02/11/98 FNC	Change sql to retrieve join field for ancillary drilldown. Use 
//						cntl_id in where instead of a_dflt since data was moved in the 
//						table.
//	03/16/98	FDG	Track 871.  
//						1.	When drilling down for providers/patients, 
//							tbl_type = 'MC' (not is_inv_type) when selecting from 
//							STARS_WIN_PARM.
//						2.	Correct the Insert SQL into the temp table to include
//							the column names.
//	05/19/98	FDG	Track 1245.  For ancillary tables, set the tbl_type
//						from the source tab.
//	05/19/98	FDG	Track 1244.  If istr_drilldown.column_flag is false and
//						istr_key_columns is not filled in, set istr_cols to the
//						column name read from stars_win_parm.  An example of this
//						happening is a 'PA' invoice type drilling down to patients (EN).
//	05/27/98	FDG	Track 1286.  Move script from uo_query.
//	05/27/98	FDG	Track 1091.  Build the temp table index from ls_join.
//	05/28/98	FDG	Track 1271.  When istr_cols has to be filled from the d/w, use
//						a separate counter (instead of li_col).
//	05/29/98	FDG	Track 1248.  Add the columns to lstr_drilldown.columns from
//						dw_selected instead of the report. 
//	06/15/97	FDG	Track ????. Don't directly access uo_query attributes.
//	07/29/98	FDG	Track 1248. Move all data from dw_selected into
//						lstr_drilldown.columns.
// 04/05/99 FNC	FS/TS2097C Starcare Track 2097. Set value moved to temp table to
//						empty string if the value is null.
// 04/06/99 FNC	FS/TS2153C Starcare Track 2153. Set data type to date time if column
//						is birthdate.
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
// 04/06/99 KTB	FS/TS2582C Starcare Track 2582. Set data type to date time if column
//						is deathdate.
// 02/08/00 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//	12/08/00	FDG	Stars 4.7.  Make SQL DBMS-independent and account for the ASE
//						"Ignore Dup Key".
// 12/27/00 GaryR	Stars 4.7 DataBase Port
//	03/20/01	FDG	Stars 4.7.  Pass the invoice type when creating a temp table.
//						Also, convert the insert SQL to upper-case.
//	07/12/01	GaryR	Track 2349d	Handle single quotes in SQL strings.
//	09/24/01	GaryR	Track 2418d	Handle additional data source when creating Temp Tables
//	01/04/02	FDG	Track 2575d.  If the user cancels out the report, don't allow
//						drilldown (since there's no rows in the report and lstr_key_columns
//						is not set).
//	08/30/02	GaryR	Track 3294d	Remove the decoded description
//	02/25/03	GaryR	Track 3452d	Account for drilldown with subset as base
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************


String	ls_add_data_type,		&
			ls_col_type,			&
			ls_col_dbname,			&
			ls_col_name,			&
			ls_col_names,			&
			ls_col_type1,			&
			ls_col_type2,			&
			ls_col_value,			&
			ls_data_type,			&
			ls_data_type1,			&
			ls_data_type2,			&
			ls_describe,			&
			ls_find,					&
			ls_inv_type,			&
			ls_join[],				&
			ls_sql_statement,		&
			ls_tbl_type,			&
			ls_values,				&
			ls_width
			
Integer	li_col_count,			&
			li_col,					&
			i,							&
			li_join_col1,			&
			li_join_col2,			&
			li_rc,					&
			li_report_rowcount,	&
			li_pos,					&
			li_ctr,					&
			li_col_num[],			&
			li_join_idx,			&
			li_join_upperbound
Long		ll_row,					&
			ll_rowcount,			&
			ll_sel_rowcount
			
Boolean	lb_ancillary_inv_type

sx_drilldown	lstr_drilldown
sx_keys			lstr_key_columns
			
n_cst_temp_table_attrib lnvo_temp_parms
n_cst_string				lnv_string				//	07/12/01	GaryR	Track 2349d

// FDG 01/04/02 - If no rows were retrieved in the report, display an error message
ll_rowcount	=	idw_report.RowCount()

IF	ll_rowcount	<	1		THEN
	MessageBox ('Error', 'Drilldown is not available until data is retrieved in the report')
	Return	-1
END IF
// FDG 01/04/02 end

lstr_drilldown = atr_drilldown
iuo_query.of_set_istr_drilldown(lstr_drilldown)					// FDG 05/27/98

// Get the instance variables from uo_query
ls_inv_type				=	iuo_query.of_getinvoicetype()			// FDG 05/27/98
lstr_key_columns		=	iuo_query.of_get_istr_key_columns()	// FDG 05/27/98
lb_ancillary_inv_type =	iuo_query.of_get_ancillary_inv_type() // FDG 05/27/98
ls_add_data_type		=	iuo_query.of_get_add_inv_type() 		//	09/24/01	GaryR	Track 2418d

// Create the temporary table service
This.uf_set_temp_table (TRUE)											// FDG 05/27/98
// FNC 02/08/00 Start

if not lb_ancillary_inv_type then
	if lstr_drilldown.path = "AD" then 
		if trim(lstr_key_columns.icn.col_name) <> '' then
			li_join_idx++
			ls_join[li_join_idx] = lstr_key_columns.icn.col_name
		end if
			
		if trim(lstr_key_columns.icn_key2.col_name) <> '' then
			li_join_idx++
			ls_join[li_join_idx] = lstr_key_columns.icn_key2.col_name
		end if
	
		if trim(lstr_key_columns.icn_key3.col_name) <> '' then
			li_join_idx++
			ls_join[li_join_idx] = lstr_key_columns.icn_key3.col_name
		end if
	
		if trim(lstr_key_columns.icn_key4.col_name) <> '' then
			li_join_idx++
			ls_join[li_join_idx] = lstr_key_columns.icn_key4.col_name
		end if
	
		if trim(lstr_key_columns.icn_key5.col_name) <> '' then
			li_join_idx++
			ls_join[li_join_idx] = lstr_key_columns.icn_key5.col_name
		end if
	
		if trim(lstr_key_columns.icn_key6.col_name) <> '' then
			li_join_idx++
			ls_join[li_join_idx] = lstr_key_columns.icn_key6.col_name
		end if
	else
		select col_name 
		into	:ls_join[1]
		from 	stars_win_parm
		where tbl_type = 	Upper( :gv_sys_dflt )
		  and	cntl_id = Upper( :lstr_drilldown.path )
		  and	win_id = 'M_DRILLDOWN' 
		using stars2ca;	
	end if
else
	select col_name 
	into	:ls_join[1]
	from 	stars_win_parm
	where tbl_type = 	Upper( :ls_inv_type )
	  and	cntl_id = Upper( :lstr_drilldown.path )
	  and	win_id = 'M_DRILLDOWN' 
	using stars2ca;
end if		// FNC 02/08/00 End


if stars2ca.of_check_status() <> 0 then
	Messagebox('Database Error','Cannot retrieve join field in u_nvo_view.ue_drilldown_build_temp_table. ' + &
					'Invoice type = ' + ls_inv_type + ' Path = ' + lstr_drilldown.path)
	return -1
else												// FNC 04/14/99
	stars2ca.of_commit()						// FNC 04/14/99
end if

// get data type for join field 
if lstr_drilldown.column_flag then	
	// Existing columns will be displayed on drilldown report
	li_col_count = integer(idw_report.Object.DataWindow.Column.Count)		// FDG 06/15/98
	ll_sel_rowcount	=	idw_selected.RowCount()									// FDG 06/15/98
	for li_col = 1 to li_col_count
		
		ls_describe = '#' + string(li_col) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(li_col) + + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = li_col
	next
	// FDG 05/29/98 begin		// FDG 07/29/98 begin
	FOR	ll_row	=	1	TO	ll_sel_rowcount
		lstr_drilldown.columns[ll_row].label		=	idw_selected.object.elem_desc [ll_row]
		lstr_drilldown.columns[ll_row].name			=	idw_selected.object.elem_name [ll_row]
		lstr_drilldown.columns[ll_row].tbl_type	=	ic_temp_alias
		lstr_drilldown.columns[ll_row].crit_seq	=	idw_selected.object.crit_seq [ll_row]
		lstr_drilldown.columns[ll_row].col_number	=	idw_selected.object.elem_col_number [ll_row]
		lstr_drilldown.columns[ll_row].data_type	=	idw_selected.object.elem_data_type [ll_row]
	NEXT
	// FDG 05/29/98 end			// FDG 07/29/98 end
else
	//02-05-98 FNC Start
	if lstr_key_columns.icn.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.icn.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.icn.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.icn.col_number
	end if
	
	if lstr_key_columns.icn_key2.col_number > 0 then							// FNC 02/08/00 Start
		li_col++
		ls_describe = '#' + string(lstr_key_columns.icn_key2.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)
		ls_describe = '#' + string(lstr_key_columns.icn_key2.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.icn_key2.col_number
	end if
	if lstr_key_columns.icn_key3.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.icn_key3.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)
		ls_describe = '#' + string(lstr_key_columns.icn_key3.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)	
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.icn_key3.col_number
	end if
	
	if lstr_key_columns.icn_key4.col_number > 0 then	
		li_col++
		ls_describe = '#' + string(lstr_key_columns.icn_key4.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)		
		ls_describe = '#' + string(lstr_key_columns.icn_key4.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)	
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.icn_key4.col_number
	end if
	
	if lstr_key_columns.icn_key5.col_number > 0 then	
		li_col++
		ls_describe = '#' + string(lstr_key_columns.icn_key5.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)	
		ls_describe = '#' + string(lstr_key_columns.icn_key5.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.icn_key5.col_number
	end if	

	if lstr_key_columns.icn_key6.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.icn_key6.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)	
		ls_describe = '#' + string(lstr_key_columns.icn_key6.col_number) + '.coltype'			
		ls_data_type = idw_report.Describe(ls_describe)	
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.icn_key6.col_number
	end if																					// FNC 02/08/00 End

	if lstr_key_columns.date_paid.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.date_paid.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98	
		ls_describe = '#' + string(lstr_key_columns.date_paid.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.date_paid.col_number
	end if
		
	if lstr_key_columns.from_date.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.from_date.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.from_date.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.from_date.col_number
	end if
	
	if lstr_key_columns.recip_id.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.recip_id.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.recip_id.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.recip_id.col_number
	end if
	
	if lstr_key_columns.prov_id.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.prov_id.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.prov_id.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.prov_id.col_number
	end if
	
	if lstr_key_columns.allowed_srvc.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.allowed_srvc.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.allowed_srvc.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.allowed_srvc.col_number
	end if
	
	if lstr_key_columns.invoice_type.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.invoice_type.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.invoice_type.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.invoice_type.col_number
	end if
	
	if lstr_key_columns.rev_code.col_number > 0 then
		li_col++
		ls_describe = '#' + string(lstr_key_columns.rev_code.col_number) + '.name'
		lnvo_temp_parms.istr_cols[li_col].is_col_name = &
			idw_report.Describe(ls_describe)											// FDG 06/15/98
		ls_describe = '#' + string(lstr_key_columns.rev_code.col_number) + '.coltype'
		ls_data_type = idw_report.Describe(ls_describe)							// FDG 06/15/98
		lnvo_temp_parms.istr_cols[li_col].is_data_type = iuo_query.of_determine_data_type(ls_data_type)
		li_col_num[li_col] = lstr_key_columns.rev_code.col_number
	end if
	//02-05-98 FNC End
end if

// FDG 05/27/98 begin
// Get the index from ls_join

li_join_upperbound = upperbound(ls_join)				// FNC 02/08/00 Start
for li_join_idx = 1 to li_join_upperbound
	lnvo_temp_parms.istr_index_cols[1].is_index_col[li_join_idx]	=	ls_join [li_join_idx]
next
// FDG 05/27/98 end

// create temp table 
lnvo_temp_parms.is_function = 'CREATE'
if lstr_drilldown.column_flag  then

else
	//	FDG 05/19/98 begin
	li_col_count	=	UpperBound (lnvo_temp_parms.istr_cols)
	IF	li_col_count	>	0		THEN

	ELSE
		li_col_count = integer(idw_report.Object.DataWindow.Column.Count)		// FDG 06/15/98
		FOR li_col = 1 to li_col_count
			
			ls_describe = '#' + string(li_col) + '.coltype'
			ls_col_type = idw_report.Describe(ls_describe)							// FDG 06/15/98	
				
			choose case left(ls_col_type,4)
				case "char"
					ls_data_type = ls_col_type
				case "date","time" 
					ls_data_type = "datetime"                                  // KTB 7/21/00
				case "long"
					ls_data_type = "int"
				case "deci","numb"
					ls_data_type = "float"
			end choose
			
			// load structure with columns for temp table
			ls_describe = '#' + string(li_col) + '.name'
			ls_col_name = idw_report.Describe(ls_describe)							// FDG 06/15/98	
			IF	Upper (ls_col_name)	=	Upper (ls_join[1])	THEN
				// Column is found.  Load into temp table.
				// FDG 05/28/98 begin
				li_ctr ++
				lnvo_temp_parms.istr_cols[li_ctr].is_col_name = ls_col_name
				lnvo_temp_parms.istr_cols[li_ctr].is_data_type = ls_data_type
				li_col_num[li_ctr] = li_col
				// FDG 05/28/98 end
			
			END IF
		NEXT
	END IF
	// FDG 05/19/98 end
end if
lnvo_temp_parms.istr_index_cols[1].is_index_type = "I"				// Ignore Dup Key
lnvo_temp_parms.is_inv_type	=	ls_inv_type								// FDG 03/20/01
lnvo_temp_parms.is_add_inv_type	=	ls_add_data_type					//	09/24/01	GaryR	Track 2418d
lnvo_temp_parms.ii_request		=	lnvo_temp_parms.ici_temp_table	// FDG 03/20/01

li_rc	=	inv_temp_table.of_execute_sql(lnvo_temp_parms) 				// builds table 

// FDG 03/20/01 begin
IF	li_rc	<	0		THEN
	MessageBox ('Drilldown Application Error', 'Could not build the temp table in '	+	&
					'u_nvo_view.ue_drilldown_build_temp_table')
	Return	li_rc
END IF
// FDG 03/20/01 end

lstr_drilldown.temp_table_name = inv_temp_table.of_get_table_name()

ll_rowcount = idw_report.rowcount()						// FDG 06/15/98

li_col_count = upperbound(lnvo_temp_parms.istr_cols)
for ll_row = 1 to ll_rowcount
	//02-05-98 FNC Start
	for li_col = 1 to li_col_count	
		// 12/27/00 GaryR	Stars 4.7 DataBase Port - Begin
		IF gnv_sql.of_is_date_data_type( lnvo_temp_parms.istr_cols[li_col].is_data_type )		THEN
			ls_col_value = string(date (idw_report.object.data[ll_row,li_col_num[li_col]]) ,'mm/dd/yyyy hh:mm:ss')
			//	09/24/01	GaryR	Track 2418d - Begin
			IF IsNull( ls_col_value ) OR Trim( ls_col_value ) = "" THEN ls_col_value = "01/01/1900"

			// FDG 12/08/00 - Make datetime data DBMS-independent
			ls_col_value	=	gnv_sql.of_get_to_date (ls_col_value)				
			ls_col_value = ',' + ls_col_value
			//	09/24/01	GaryR	Track 2418d - End
		ELSEIF gnv_sql.of_is_character_data_type( lnvo_temp_parms.istr_cols[li_col].is_data_type )		THEN
			// FNC 04/06/99 Start
			ls_col_value =	string(idw_report.object.data[ll_row,li_col_num[li_col]])
			IF IsNull( ls_col_value ) THEN ls_col_value = ''	//	09/24/01	GaryR	Track 2418d
			//	07/12/01	GaryR	Track 2349d
			ls_col_value = lnv_string.of_GlobalReplace( ls_col_value, "'", "''" )
			
			//	08/30/02	GaryR	Track 3294d - Begin
			//	Strip the decoded description 
			//	from the original value.
			li_pos = Pos( ls_col_value, " - " )
			IF li_pos > 0 THEN ls_col_value = Trim( Left( ls_col_value, li_pos ) )
			//	08/30/02	GaryR	Track 3294d - End
			
			if ls_col_value = '' then
				ls_col_value = ",' '"
			else
				ls_col_value = ",'" + ls_col_value + "'"
			end if			
		ELSE
			ls_col_value = string(idw_report.object.data[ll_row,li_col_num[li_col]])
			IF IsNull( ls_col_value ) OR Trim( ls_col_value ) = "" THEN ls_col_value = '0'	//	09/24/01	GaryR	Track 2418d
			ls_col_value = ',' + ls_col_value		// FNC 04/06/99 End
		END IF
		// 12/27/00 GaryR	Stars 4.7 DataBase Port - End
		
		ls_values = ls_values + ls_col_value
		ls_col_names	=	ls_col_names	+	', '				+	&
								lstr_drilldown.temp_table_name	+	&
								'.'										+	&
								lnvo_temp_parms.istr_cols[li_col].is_col_name	// FDG 03/17/98
	next
	//02-05-98 FNC End
	ls_values = mid(ls_values,2)				// Remove the first ','
	// FDG 03/17/98 begin
	ls_col_names	=	Mid(ls_col_names,2)	// Remove the first ','
	ls_col_names	=	' ('	+	ls_col_names	+	') '
	ls_sql_statement	=	'Insert into '							+	&
								lstr_drilldown.temp_table_name	+	&
								ls_col_names							+	&
								' values  ('							+ 	&
								ls_values + ')'
	ls_sql_statement	=	Upper (ls_sql_statement)		// FDG 03/30/01
	// FDG 03/17/98 end
	// FDG 12/08/00 - of_insert() ingores a duplicate insert return code
	li_rc = stars2ca.of_insert(ls_sql_statement)
	if li_rc <> 0 then
		messagebox('ERROR','Error inserting into temp table for drilldown')
		return -1
	end if
	ls_values = ''
	ls_sql_statement = ''
	ls_col_names	=	''				// FDG 03/17/98
next

stars2ca.of_commit()					// FNC 04/14/99

// needed for next uo_query 
lstr_drilldown.join_fields = ls_join
lstr_drilldown.data_type = iuo_query.of_get_data_type()
lstr_drilldown.main_inv_type = iuo_query.of_getinvoicetype( )
lstr_drilldown.subset_id = iuo_query.tabpage_source.dw_source.GetItemString( 1, "subset_name" )
lstr_drilldown.case_id = iuo_query.tabpage_source.dw_source.GetItemString( 1, "case_id" )

// Set the instance variables in uo_query
iuo_query.of_set_istr_drilldown(lstr_drilldown)		// FDG 05/27/98

RETURN 1
end event

event type integer ue_tabpage_view_stats();//*********************************************************************************
// Event Name:	u_nvo_view.ue_tabpage_view_stats
//
//	Arguments:	None
//
// Returns:		1 = Success; -1 = Failure
//
//	Description:
//		This event is triggered from the m_view popup menu in order to
//		setup the computed fields that will hold the report statistics.
//
//*********************************************************************************
//
//	09/10/09	GaryR	QEN.650.5229.006	Add statistical and arithmetic functions to QE reports
//
//*********************************************************************************

Integer	li_col, li_colcount, li_pos, li_ctr, li_y, li_upper, li_cnt, li_width_idx// = 40
String	ls_coltype, ls_colname, ls_inv_type, ls_edit_mask, ls_colnum, ls_rtn, ls_acc, &
			ls_syntax, ls_rem_syntax, ls_exp, ls_format, ls_height, ls_width, ls_stats[]
Boolean	lb_resize

n_cst_string	lnv_string
m_view	lm_view
lm_view = iw_parent.wf_get_m_view()

SetPointer( Hourglass! )
idw_report.SetRedraw( FALSE )

//	Initialize the statistics array
ls_stats[1] = '~~"Sum= ~~" + String( sum([colname] for all), ~~"[format]~~" )'
ls_stats[2] = '~~"Avg= ~~" + String( avg([colname] for all), ~~"###,###,###,##0.00~~" )'
ls_stats[3] = '~~"Med= ~~" + String( median([colname] for all), ~~"[format]~~" )'
ls_stats[4] = '~~"Mode= ~~" + if( IsNull(mode([colname] for all)), ~~"N/A~~", String( mode([colname] for all), ~~"[format]~~" ))'
ls_stats[5] = '~~"Min= ~~" + String( min([colname] for all), ~~"[format]~~" )'
ls_stats[6] = '~~"Max= ~~" + String( max([colname] for all), ~~"[format]~~" )'
ls_stats[7] = '~~"Std= ~~" + String( stdev([colname] for all), ~~"###,###,###,##0.00~~" )'
ls_stats[8] = '~~"Var= ~~" + String( var([colname] for all), ~~"###,###,###,##0.00~~" )'

li_upper = UpperBound( ls_stats )
li_colcount		=	Integer (idw_report.object.datawindow.column.count)

FOR li_col	=	1	TO	li_colcount
	//	Check if this column is to be excluded from stats
	ls_colnum = "#" + String( li_col )
	ls_coltype = Upper( idw_report.Describe ( ls_colnum + '.coltype' ) )
	li_pos = Pos( ls_coltype, "(" )
	IF	li_pos > 0 THEN ls_coltype = Left( ls_coltype, li_pos - 1 )

	IF	ls_coltype <> "LONG"	AND ls_coltype <> "NUMBER" &
	AND ls_coltype	<> "DECIMAL" THEN Continue
	
	ls_colname	=	Upper( idw_report.Describe ( ls_colnum + '.name' ) )
	IF	ls_colname = "RANK" THEN Continue
	
	ls_inv_type	= This.uf_get_inv_type()
	ls_edit_mask = gnv_dict.event ue_get_edit_mask( ls_inv_type, ls_colname )
	IF ls_edit_mask = "NOTOT" THEN Continue
	
	//	All edits passed, delete any existing controls from previous operations
	ls_rem_syntax = ""
	FOR li_ctr = 1 TO li_upper
		IF idw_report.Describe ( ls_colname + "_scf" + String( li_ctr ) + ".visible" ) <> "1" THEN Continue
		ls_rem_syntax +=" destroy " + ls_colname + '_scf' + String( li_ctr )	
	NEXT
	
	IF Trim( ls_rem_syntax ) > "" THEN
		//	Reset column width
		ls_width = idw_report.Describe( ls_colnum + ".width" )
		ls_width = String( Long( ls_width ) - li_width_idx )
		ls_rem_syntax = ls_colnum + ".width = " + ls_width + ls_rem_syntax
		idw_report.Object.DataWindow.Summary.Height = "0"
		ls_rtn = idw_report.Modify( ls_rem_syntax )
		IF Trim( ls_rtn ) > "" THEN
			MessageBox( "Report Error", "Unable to destroy existing computed fields." + &
								"~n~rStatistics operations will not be available on report." )
			idw_report.SetRedraw( TRUE )
			Return -1
		END IF
	END IF

	// Create computed fields for each selected statistic for this column
	ls_format = idw_report.Describe ( ls_colnum + ".format" )
	ls_height = idw_report.Describe( ls_colnum + ".height" )
	ls_width = idw_report.Describe( ls_colnum + ".width" )
	ls_width = String( Long( ls_width ) + li_width_idx )
	li_y = 1
	
	FOR li_ctr = 1 TO li_upper
		//	Is stat selected in menu?
		IF NOT lm_view.m_menu.m_statistics.item[li_ctr].checked THEN Continue
		
		//	Set accessibility text
		ls_acc = lnv_string.of_clean_string_acc( m_view.m_menu.m_statistics.item[li_ctr].microhelp )
		
		//	Replace placeholders in stats formula
		ls_exp = lnv_string.of_globalreplace( ls_stats[li_ctr], "[colname]", ls_colname)
		ls_exp = lnv_string.of_globalreplace( ls_exp, "[format]", ls_format)

		ls_syntax += 'create compute(band=summary alignment="1" expression="' + ls_exp + &
					'" border="0" color="' + String( stars_colors.window_text ) + &
					'" x="' + idw_report.Describe( ls_colnum + ".X" ) + '" y="' + &
					String( li_y ) + '" height="' + ls_height + '" width="' + ls_width + &
					'" name=' + ls_colname + '_scf' + String( li_ctr ) + ' visible="1' + &
					'" font.face="' + idw_report.Describe( ls_colnum + ".font.face" ) + &
					'" font.height="' + idw_report.Describe( ls_colnum + ".font.height" ) + &
					'" font.weight="' + idw_report.Describe( ls_colnum + ".font.weight" ) + &
					'" font.family="' + idw_report.Describe( ls_colnum + ".font.family" ) + &
					'" font.pitch="' + idw_report.Describe( ls_colnum + ".font.pitch" ) + &
					'" font.charset="' + idw_report.Describe( ls_colnum + ".font.charset" ) + &
					'" background.mode="1" background.color="' + String( stars_colors.window_background ) + &
					'" accessibledescription="~~"' + ls_acc +'~~"~~t~~"' + ls_acc + &
					'~~"" accessiblename="~~"' + ls_acc + '~~"~~t~~"' + ls_acc + '~~"" accessiblerole=27 ) '
					
		li_y += Long( ls_height )
		lb_resize = TRUE
	NEXT
	
	//	Resize the column width
	IF lb_resize THEN
		lb_resize = FALSE
		ls_syntax = ls_colnum + ".width = " + ls_width + " " + ls_syntax
	END IF
NEXT

IF Trim( ls_syntax ) > "" THEN
	ls_rtn = idw_report.Modify( ls_syntax )
	IF Trim( ls_rtn ) > "" THEN
		MessageBox( "Report Error", "Unable to initialize blank computed fields." + &
							"~n~rStatistics operations will not be available on report." )
		idw_report.Object.DataWindow.Summary.Height = "0"
		idw_report.SetRedraw( TRUE )
		Return -1
	END IF
	ls_height = String( li_y )
	idw_report.Object.DataWindow.Summary.Height = ls_height
END IF

idw_report.SetRedraw( TRUE )
Return 1
end event

public function integer uf_find_column_number (string as_col_name);//*********************************************************************************
// Event Name:	u_nvo_view.ue_find_column_number
//
//	Arguments:	as_col_name - the name of the column to find
//
// Returns:		Integer - -1 if not found, the column 3 if found.
//
//	Description:
//		This function will find as_col_name in idw_report.
//
//*********************************************************************************
//
// 01-23-98 FDG	Created
//
//*********************************************************************************

Integer	li_col,				&
			li_idx

String	ls_col_name,		&
			ls_col
			
ls_col	=	idw_report.Object.DataWindow.Column.Count
li_col	=	Integer (ls_col)

FOR	li_idx	=	1	TO	li_col
	ls_col_name	=	idw_report.Describe("#" + String(li_idx) + ".Name")
	IF	Upper (as_col_name)	=	Upper (ls_col_name)		THEN
		// Column found
		Return li_idx
	END IF
NEXT

// Column not found
Return	-1

end function

public function integer uf_add_column_headings ();////////////////////////////////////////////////////////////////////////////////////
// Script:		u_nvo_view.uf_add_column_headings
//	Arguments:	None
// Returns:		Integer
//					-1	=	Error
//					0	=	Nothing was changed
//					1	=	Datawindow syntax was changed
//
//	Description:
//		When a user is drilling down, it is possible to select the same column
//		name from two different tables (i.e. TMP.prov_id & C1.prov_id).  When the
//		datawindow syntax is generated via SyntaxFromSQL(), the column headings
//		for the duplicate column does not get assigned a name.
//
//		This function will scan thru the datawindow syntax and assign a column name
//		for the duplicate column.
//
////////////////////////////////////////////////////////////////////////////////////
// 08/28/98	FDG	Track 1235, 1248.  Created.
//
////////////////////////////////////////////////////////////////////////////////////

Long			ll_pos,						&
				ll_beg_pos,					&
				ll_end_pos,					&
				ll_prev_pos,				&
				ll_column
				
String		ls_syntax,					&
				ls_column_name,			&
				ls_error

Constant	String	cs_column_find = 'text('
Constant	String	cs_no_header_find = '(band=header'

Boolean		lb_finished = FALSE,		&
				lb_found = FALSE

ls_syntax	=	idw_report.object.DataWindow.Syntax

ll_prev_pos	=	1

DO WHILE lb_finished = FALSE
	// get the column #
	ll_column ++
	// Get the position of the next column
	ll_beg_pos	=	Pos (ls_syntax, cs_column_find, ll_prev_pos)
	IF	ll_beg_pos	<	1		THEN
		// Next column not found.  Get out.
		lb_finished	=	TRUE
		Exit
	END IF
	ll_prev_pos	=	ll_beg_pos	+	1
	// Get the end of this column by getting the beginning position
	//	of the next column
	ll_end_pos	=	Pos (ls_syntax, cs_column_find, ll_beg_pos + 1)
	IF	ll_end_pos	<	1		THEN
		// Reached the last column
		ll_end_pos	=	9999999
	END IF
	// Determine if this column's header has a name
	ll_pos		=	Pos (ls_syntax, cs_no_header_find, ll_beg_pos + 1)
	IF	ll_pos	>	0					&
	AND ll_pos	<	ll_end_pos		THEN
		// This column's header has no name.  Assign a name to it.
		lb_found	=	TRUE
		//	Get the name of the column
		ls_column_name	=	idw_report.Describe ("#"	+	String (ll_column)	+	".Name")
		//	Insert the column header name in the datawindow syntax
		ls_syntax		=	Left (ls_syntax, ll_pos)					+	&
								"name="	+	ls_column_name	+	"_t "		+	&
								Mid (ls_syntax, ll_pos + 1)
		
	END IF
LOOP

IF	lb_found	=	TRUE		THEN
	idw_report.Create (ls_syntax, ls_error)
	Return	1
ELSE
	Return	0
END IF

end function

public function integer uf_get_excluded_totals_columns (ref string as_cols[]);//*********************************************************************************
// Script Name:	u_nvo_view.uf_get_excluded_totals_columns
//
//	Arguments:	as_cols[] - by reference
//
// Returns:		Integer
//
//	Description:
//		This function will find all numeric columns for this invoice type that
//		will not be included in the break with totals or with the unit/money totals.
//
//*********************************************************************************
//
// 09/18/98 FDG	Track 1723.  Created
//
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.	
//*********************************************************************************

Long		ll_rowcount,		&
			ll_row,				&
			ll_ctr
			
String	ls_inv_type,		&
			ls_edit_mask

// Get the invoice type (in case if in drilldown)
ls_inv_type			=	This.uf_get_inv_type()

// Retrieve the dictionary data (if not previously retrieved)

IF	ls_inv_type		=	is_prev_inv_type		THEN
	// Dictionary data was already retrieved for this invoice type
	ll_rowcount		=	ids_dictionary.RowCount()
ELSE
	ll_rowcount		=	ids_dictionary.Retrieve (ls_inv_type)
END IF

if ll_rowcount > 0 then					// FNC 04/14/99
	stars2ca.of_commit()					// FNC 04/14/99
end if										// FNC 04/14/99

is_prev_inv_type	=	ls_inv_type

// Dictionary column edit_mask = 'NOTOT' will specify that totals 
//	will not be generated for a numeric column.

FOR ll_row	=	1	TO	ll_rowcount
	ls_edit_mask	=	Upper ( ids_dictionary.object.edit_mask [ll_row] )
	IF	ls_edit_mask	=	'NOTOT'		THEN
		// Do not total this column
		ll_ctr ++
		as_cols [ll_ctr]	=	ids_dictionary.object.elem_name [ll_row]
	END IF
NEXT

Return 1

end function

public function string uf_get_inv_type ();/////////////////////////////////////////////////////////////////////
//	Script:		uf_get_inv_type
//
//	Arguments:	None
//
//	Returns:		String - The invoice type
//
//	Description:
//		Determine the invoice type based on if you're in drilldown or not.
//
/////////////////////////////////////////////////////////////////////
//
//	04/18/03	GaryR	Track 3522d	Get the key columns from the main query
//
/////////////////////////////////////////////////////////////////////

String	ls_inv_type

IF	ib_drilldown						THEN
	// Only get the invoice type from istr_drilldown when
	//	drilling on additional data.
	IF	istr_drilldown.path	=	'AD'		THEN
		ls_inv_type		=	istr_drilldown.main_inv_type
	ELSE
		ls_inv_type		=	is_inv_type
	END IF
ELSE
	IF is_inv_type = 'ML'			THEN
		ls_inv_type = 'MC'
	ELSE
		ls_inv_type = is_inv_type
	END IF
END IF

Return	ls_inv_type
end function

public function boolean uf_check_unique_key (string as_unique_col_name);// Script:		u_nvo_view.uf_check_unique_key
//	Arguments:	as_unique_col_name
// Returns:		Boolean
//					TRUE - Unique key already included as a key column
//	Description:
//		If the unique client specified key is already included as a Query Engine
//		key column, do not include it as a report column for a second time.
//
////////////////////////////////////////////////////////////////////////////////////
// 02/08/00 FNC Created
//
////////////////////////////////////////////////////////////////////////////////////

CHOOSE CASE as_unique_col_name
	Case istr_key_columns.allowed_srvc.col_name 
		return TRUE
	case istr_key_columns.recip_id.col_name
		return TRUE
	case istr_key_columns.date_paid.col_name
		return TRUE		
	case istr_key_columns.from_date.col_name 
		return TRUE
	case istr_key_columns.icn.col_name 
		return TRUE
	case istr_key_columns.invoice_type.col_name 
		return TRUE
	case istr_key_columns.prov_id.col_name
		return TRUE
END CHOOSE

Return FALSE


end function

public function integer uf_getmaxcolumnlengths ();////////////////////////////////////////////////////////////////////////////////////
// Script:		u_nvo_view.uf_getmaxcolumnlengths
//
//	Arguments:	None
//
// Returns:		Integer
//					-1	=	Error
//					0	=	Nothing was changed
//					1	=	Datawindow syntax was changed
//
//	Description:
//		Determine the maximum column lengths for idw_report.  This is necessary
//		when multiple invoice types are read.  For example, the length of C1.ICN = 15
//		and the length of C2.ICN = 23.  When this occurs, the column in the d/w
//		must contain the larger length.
//
//	Note: ColType is a read-only datawindow attribute.  As a result, a Modify()
//			cannot be issued.  The datawindow must be re-created.
//
////////////////////////////////////////////////////////////////////////////////////
//
// 07/31/01	FDG	Track ???? (Stars 4.6 SP1).  Created.
// 10/15/04	MikeF	SPR3650d Computed columns
////////////////////////////////////////////////////////////////////////////////////

Integer	li_pos,				&
			li_pos2,				&
			li_pos3,				&
			li_orig_length,	&
			li_max_length,		&
			li_max_columns,	&
			li_col,				&
			li_len,				&
			li_rc
			
String	ls_modify,			&
			ls_syntax,			&
			ls_colname,			&
			ls_dbname,			&
			ls_dwdbname,		&
			ls_coltype,			&
			ls_newcoltype,		&
			ls_error
			
// Determine if multiple invoice types are being retrieved
if	(is_data_type = ics_subset		and	is_inv_type = 'ML')	&
or (is_inv_type  = 'MC')												then
else
	Return	0
end if

ls_syntax		=	idw_report.object.Datawindow.Syntax
li_pos2			=	1

li_max_columns	=	Integer ( idw_report.Describe ( 'datawindow.column.count' ) )

FOR li_col	= 1 TO li_max_columns
	// Get the column name and type
	ls_colname	=	idw_report.Describe ( '#' + String(li_col) + '.Name' )
	ls_coltype	=	idw_report.Describe ( ls_colname + '.ColType' )
	li_len					=	Len ( ls_coltype )
	// Get the location in the d/w syntax for this column
	li_pos2					=	Pos ( ls_syntax, 'column=(', li_pos2 + 2 )
	// Only character columns will be processed
	if	Lower ( Left ( ls_coltype, 4 ) )	<>	'char'		then
		Continue
	end if
	// Find the column type in the syntax
	li_pos3			=	Pos ( ls_syntax, ls_coltype, li_pos2 )
	// Get the original and maximum column lengths
	ls_dwdbname		=	idw_report.Describe ( ls_colname + '.dbName' )
	li_pos			=	Pos ( ls_coltype, ')' )
	li_orig_length	=	Integer ( Mid ( ls_coltype, 6, li_pos - 6 ) )
	ls_dbname		=	is_select_column[li_col]
	Select	max(elem_data_len)
	  Into	:li_max_length
	  From	dictionary
	 Where	elem_name	=	:ls_dbname
	   and	elem_type	IN	('CL','CC')
	 Using	Stars2ca;
	if	Stars2ca.of_check_status()	<>	0		then
		MessageBox ('Database Error', 'Could not retrieve the max column for '	+	&
						'column = '	+	ls_dbname	+	'.')
		Return	-1
	end if
	// If there's a difference in the column lengths, modify the datawindow syntax.
	if li_max_length	>	li_orig_length		then
		// Mismatch in length.  Modify the d/w to reflect the max length
		ls_newcoltype	=	'char('	+	String(li_max_length)	+	')'
		// ls_modify is for debugging purposes only since ColType is a read-only d/w attribute
		ls_modify		=	ls_modify	+	" "	+	ls_colname	+	&
								".ColType = '"	+	ls_newcoltype	+	"' "
		// Modify the datawindow syntax to reflect the new length.
		ls_syntax	=	Left ( ls_syntax, li_pos3 - 1 )	+	ls_newcoltype	+	&
							Mid  ( ls_syntax, li_pos3 + li_len)
	end if
NEXT

ls_modify	=	Trim (ls_modify)

if	Len (ls_modify)	>	0		then
	// The length of at least one column was changed.  Re-create the d/w.
	li_rc	=	idw_report.Create (ls_syntax, ls_error)
	Return	1
else
	Return	0
end if




end function

public subroutine uf_add_title ();//***********************************************************************
//10/22/98 AJS Anne Sola This function will search through a multi-string
//                       and place it as a title in a datawindow.
//                       It also adds date and page number.
//
//11/03/98 FNC	Track 1735. Change double quotes to single quotes in the first
//					mod_String so that single quotes can be in the heading text.
//07/25/00 FDG	Track 2141. Stars 4.5 SP1.  The date and page #'s are too
//					far to the right when printing.
//GaryR	11/01/2000	2920c	Standardize windows colors
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//***********************************************************************
  
string describe_str, mod_string, cname
int font_weight = 700, col_num, i   
string date_x_pos
string page_x_pos
int date_x_int
string lv_string_rc
int lv_int_rc
int li_height_constant, li_width_constant

string ls_title
int li_line_length, li_width, li_char_index,li_line_width, li_temp_width, li_length_cntr
int li_height, li_header_height, li_title_height, li_y_pos, li_x_pos, li_line_count
setpointer(hourglass!)

//Loop through to find the line with the greatest width
ls_title = trim( imle_title.text )
li_line_length = Len(ls_title) 
li_line_count = 0
li_height_constant = 21
//li_width_constant = 12		// FDG 07/25/00
li_width_constant = 8			// FDG 07/25/00
	
For li_char_index = 1 to li_line_length
	If mid(ls_title,li_char_index,1) = '~n' or &
		mid(ls_title,li_char_index,1) = '~r' or li_char_index = li_line_length then
		if li_char_index = li_line_length then
			li_length_cntr++
		end if
		li_temp_width = li_length_cntr
		li_length_cntr = 0
		li_line_count++
		if li_temp_width > li_line_width then
				li_line_width = li_temp_width
		end if
		//skip over "~n"
		li_char_index = li_char_index + 1
	Else
		li_length_cntr++
	End If
Next

//Change number of letters to length in units
li_line_width = li_line_width * li_width_constant

//determine the x_pos
// FDG 07/25/00 - Move title further to the left
li_width = idw_report.width
li_width = UnitsToPixels(li_width, XUnitsToPixels!)
IF	li_line_width	>	li_width		THEN
	li_x_pos	=	10
ELSE
	//li_x_pos = (dw_width - li_line_width) / 4
	li_x_pos = 10
END IF
// FDG 07/25/00 End

//If no title allow line for date & page
If li_line_count = 0 then
	li_line_count = 1
End If

//Add extra blank line between title & column headings
li_line_count++

//Calculate heights & x/y positions
li_title_height = (li_line_count) * li_height_constant
li_y_pos = (li_line_count * li_height_constant)
li_header_height = (li_line_count + 2) * li_height_constant

// FDG 07/25/00 - Compute the x position of date and page base on the location
//						of the title.
IF	li_line_length	=	0		THEN
	date_x_pos = string (li_width/2)
	page_x_pos = string (li_width/2 + 95)
ELSE
	date_x_pos = string (li_x_pos + li_line_width + 5)
	page_x_pos = string (li_x_pos + li_line_width + 5 + 95)
END IF
// FDG 07/25/00 End

mod_string = "datawindow.header.height = " + string(li_header_height)
lv_string_rc = idw_report.Modify(mod_string)

mod_string = 'create text(band=foreground color="' + String( stars_colors.window_text ) + '" alignment= "2" border="0"' + &
	'  x="'+string(li_x_pos)+'" y="2" height="'+string(li_title_height)+ '"' + &
	' width= "' +string(li_line_width)+ '"' + 'text= "'+ ls_title + '"' + &
	' name=header_t font.face="System" font.height= "-10" font.weight="' + string(font_weight) + '"' + &
	' font.family="2" font.pitch="2" font.charset="0" font.italic="0" ' + &
	' font.strikethrough="0" font.underline="0" background.mode="1" background.color="' + String( stars_colors.window_background ) + '" ' + &
	' accessibledescription="~~"Report Title~~"~~t~~"Report Title~~"" accessiblename="~~"Report Title~~"~~t~~"Report Title~~"" accessiblerole=42 ) '
lv_string_rc = idw_report.Modify(mod_string)

// MikeFl - Track 2947 - Begin
mod_string = "create text(band=foreground color='" + String( stars_colors.window_text ) + "' alignment= '0' border='0'" + &
	" x='"+date_x_pos+"' y='2' height='"+string(li_title_height)+"' width='114' text= '" + string(datetime(today(),now())) + "'" + &
	" name=st_report_date font.face='System' font.height='-10' font.weight=~'" + string(font_weight) + "~' font.family='2'" + &
	" font.pitch='2' font.charset='1' font.italic='0' font.strikethrough='0' font.underline='0' " + &
	" background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	' accessibledescription="~~"Current Date and time~~"~~t~~"Current Date and time~~"" accessiblename="~~"Current Date and time~~"~~t~~"Current Date and time~~"" accessiblerole=42 ) '
// MikeFl - Track 2947 - End
lv_string_rc = idw_report.Modify(mod_string)

mod_string = " create compute(band=foreground color='" + String( stars_colors.window_text ) + "' alignment='0' border='0' " + &
	" x='"+page_x_pos+"' y='2' height='"+string(li_title_height)+"' width='95' format='[GENERAL]' " + &
	" expression=~'~~~'    Page ~~~' + page()~' font.face='System' font.height='-10' " + &
	" font.weight=~'" + string(font_weight) + "~' font.family='2' font.pitch='2' font.charset='1' font.italic='0' font.strikethrough='0' font.underline='0' " + &
	" background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	' accessibledescription="~~"Page Count~~"~~t~~"Page Count~~"" accessiblename="~~"Page Count~~"~~t~~"Page Count~~"" accessiblerole=42 ) '
lv_string_rc = idw_report.Modify(mod_string)

col_num = integer(idw_report.Describe ("datawindow.column.count") )
for i = 1 to col_num	
	cname = 	idw_report.Describe('#'+string(i)+'.name')
	 mod_string = cname + "_t.y = " + string(li_y_pos)
	 lv_string_rc = idw_report.Modify (mod_string)
next 

describe_str = idw_report.Describe ("datawindow.syntax")
lv_int_rc = idw_report.Create (describe_str)
if lv_int_rc = -1 Then
	messagebox("ERROR","Error creating datawinow")
	return
end if
end subroutine

on u_nvo_view.create
call super::create
end on

on u_nvo_view.destroy
call super::destroy
end on

event constructor;call super::constructor;//*************************************************************************
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
//	03/12/01	FDG	Stars 4.7.  Remove ros_directory.
//*************************************************************************

This.of_set_temp_table (TRUE)	// FDG 03/04/98 - Use temp table as an NVO

uf_set_nvo_report(TRUE)	/* JTM 2/17/98 - This instance will cause null object ref. errors
														in report NVO. A better approach would
														be to call iuo_query.of_SetQueryNvo(). 
														and map the event through iuo_Query*/

// FDG 03/13/01 - Remove ros_directory
//	Get the data in ros_directory (18 rows - 1 for each month)
//ids_ros_directory	=	CREATE	n_ds
//ids_ros_directory.DataObject	=	'd_ros_directory'
//ids_ros_directory.SetTransObject (Stars1ca)
//ids_ros_directory.Retrieve()
//stars1ca.of_commit()						// FNC 04/14/99
// FDG 03/13/01 end

ids_dictionary	=	CREATE	n_ds
ids_dictionary.DataObject	=	'd_dictionary_tbl_type'
ids_dictionary.SetTransObject (Stars2ca)


end event

event destructor;call super::destructor;uf_set_nvo_report(FALSE)

// FDG 03/13/01 - Stars 4.7.  Remove ros_directory.
//IF	IsValid (ids_ros_directory)		THEN
//	DESTROY	ids_ros_directory
//END IF

IF	IsValid (ids_dictionary)		THEN
	DESTROY	ids_dictionary
END IF

end event

