HA$PBExportHeader$w_subset_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_subset_list from w_master_list
end type
type gb_1 from groupbox within w_subset_list
end type
type cb_view from u_cb within w_subset_list
end type
type cb_criteria from u_cb within w_subset_list
end type
type cb_summary from u_cb within w_subset_list
end type
type cb_query from u_cb within w_subset_list
end type
type cb_patterns from u_cb within w_subset_list
end type
type cb_sample from u_cb within w_subset_list
end type
type pb_notes from picturebutton within w_subset_list
end type
type cb_notes from u_cb within w_subset_list
end type
end forward

global type w_subset_list from w_master_list
string accessiblename = "Subset List"
string accessibledescription = "Subset List"
integer width = 3790
integer height = 2528
string title = "Subset List"
boolean ib_popup_menu = true
boolean ib_display_details = true
boolean ib_display_update = true
boolean ib_display_daterange = true
boolean ib_case_security = true
string is_case_field = "case_key"
event ue_view ( )
event ue_criteria ( )
event ue_subset_summary ( )
event ue_query ( )
event ue_random_sample ( )
event ue_pattern ( )
event ue_notes ( )
gb_1 gb_1
cb_view cb_view
cb_criteria cb_criteria
cb_summary cb_summary
cb_query cb_query
cb_patterns cb_patterns
cb_sample cb_sample
pb_notes pb_notes
cb_notes cb_notes
end type
global w_subset_list w_subset_list

type variables
//	11/09/06	GaryR	Track 4460	Accomodate Subset reassign functionality

string	is_subset_id, is_subset_name, is_user_id, is_desc
string	is_case_key, is_case_id, is_case_spl, is_case_ver
string	is_tables[], is_subset_type, is_ml_tables
string	is_object_id, is_case_status
int		ii_delete_access
boolean ib_ancillary

n_cst_case					inv_case
m_subset_rmm				im_rmm
sx_query_engine_parms 	isx_query
sx_display_criteria  	isx_criteria
sx_subset_ids 				isx_subset_ids

nvo_subset_functions		inv_subset

n_cst_stars_rel	in_cst_stars_rel // 01/26/06 HYL Track 4627d
			
end variables

forward prototypes
public subroutine wf_select_subset ()
public subroutine wf_set_row_parms (long al_row)
public subroutine wf_saveas ()
end prototypes

event ue_view();//====================================================================================================//
// Script:  w_subset_list cb_view
// Arguments:	none
// Returns:	none
//====================================================================================================//
// This script will open the query engine for a specific subset
//-----------------------------------------------------------------------------
// Maintenance 
// -------- -----	--------	---------------------------------------------------
// 05/13/05	MikeF	SPR4319d	Created
//====================================================================================================//
this.wf_select_subset()

//	Set the query engine parms
inv_queryengine.uf_clear_query_parms()
isx_query.pdq_subset = FALSE
inv_queryengine.uf_set_sxQueryEngineParms (isx_query)	
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Open the query engine window
inv_queryengine.uf_open_query_engine()

end event

event ue_criteria();//=============================================================================================//
// Object		w_subset_list
// Event			ue_criteria
// Parameters	None
// Returns		None
// Call stack	Called from cb_criteria and m_subset_rmm
//=============================================================================================//
// Opens criteria window
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
//=============================================================================================//
this.wf_select_subset()

OpenSheetwithParm(w_case_display_criteria,isx_criteria, MDI_Main_Frame,Help_Menu_Position,Layered!)
	
end event

event ue_subset_summary();//====================================================================================================//
// Script:  w_subset_list cb_view
// Arguments:	none
// Returns:	none
//====================================================================================================//
// This script will open the query engine for a specific subset
//-----------------------------------------------------------------------------
// Maintenance 
// -------- -----	--------	---------------------------------------------------
// 05/13/05	MikeF	SPR4319d	Created
//====================================================================================================//
this.wf_select_subset()

OpenSheetwithParm(w_subset_summary_analysis,isx_subset_ids,MDI_main_frame,help_menu_position,Layered!)
end event

event ue_query();//====================================================================================================//
// Script:  w_subset_list cb_view
// Arguments:	none
// Returns:	none
//====================================================================================================//
// This script will open the query engine for a specific subset
//---------------------------------------------------------------------------------------------------
// Maintenance 
// -------- -----	--------	--------------------------------------------------------------------------
// 05/13/05	MikeF	SPR4319d	Created
// 08/04/05 MikeF SPR4471d Query not working. Opens view.
// 09/30/05 MikeF SPR4527d	Query from subset list takes you defaults to wrong invoice type
//						SPR4528d Can't selecting Subset from Subset Use after Query
//====================================================================================================//
this.wf_select_subset()

// Unset Query parms
isx_query.subset_id 		= ''
isx_query.subset_name	= ''
isx_query.sub_inv_type	= ''
isx_query.case_id 		= ''
isx_query.case_spl 		= ''
isx_query.case_ver 		= ''

//	Set the query engine parms
inv_queryengine.uf_clear_query_parms()
isx_query.pdq_subset = TRUE
inv_queryengine.uf_set_sxQueryEngineParms (isx_query)	
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Open the query engine window
inv_queryengine.uf_open_query_engine()

end event

event ue_random_sample();//=============================================================================================//
// Object		w_subset_list
// Event			ue_random_sample
// Parameters	None
// Returns		None
//=============================================================================================//
// Opens Random Sample interface
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
//=============================================================================================//
sx_rand_samp_selection 	lsx_sample
this.wf_select_subset()

IF NOT inv_case.uf_edit_case_referred (is_case_id, is_case_spl, is_case_ver) THEN
	MessageBox( "Invalid Case", "This subset is linked to a version of a case, " + &
										 + is_case_id + " " + is_case_spl + is_case_ver + &
										 ", which has been referred.~n~rTo run the random sample," + &
										 " select this subset from the open version of the case.", StopSign! )
	Return
END IF

IF NOT inv_case.uf_edit_case_closed (is_case_id, is_case_spl, is_case_ver) THEN
	MessageBox( "Invalid Case", "This subset is linked to a closed or deleted case, " + &
										 + is_case_id + " " + is_case_spl + is_case_ver + &
										 ",  so a random sample cannot be created.", StopSign! )
	Return
END IF

// Open the random sampling screen according to the subset type
IF is_subset_type = 'ML' THEN		
	setpointer(hourglass!)
	OpenWithParm(w_invoice_selections,"W_RANDOM_SAMPLING_SELECTION" + "," + is_ml_tables)
ELSE 
	lsx_sample.invoice_type = is_subset_type
	lsx_sample.subc_id 		= ""
	lsx_sample.case_id 		= is_case_id
	lsx_sample.case_spl 		= is_case_spl
	lsx_sample.case_ver 		= is_case_ver
	OpenSheetwithParm( w_random_sampling_selection, lsx_sample, MDI_Main_Frame, Help_Menu_Position, Layered! )	
End If

// Post the routine that will verify the active case
IF IsValid( w_random_sampling_selection ) AND NOT IsNull( w_random_sampling_selection ) THEN
	w_random_sampling_selection.POST wf_verify_active_case()
	SetMicroHelp( w_main, "Random Sample will be linked to Active Case" )
END IF
end event

event ue_pattern();string				ls_subc_tables, ls_tables[]
n_cst_string		lnv_string
sx_subset_options lsx_options

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

this.wf_select_subset()

lsx_options.patt_struc.come_from 	= 'SUB_MAINT'
lsx_options.patt_struc.sub_src_type = 'SS'
lsx_options.patt_struc.subset_id 	= is_subset_id
lsx_options.patt_struc.case_id 		= is_case_id + is_case_spl + is_case_ver
lsx_options.patt_struc.subset_table_type = is_subset_type
lsx_options.patt_struc.table_type 	= is_tables

OpenSheetWithParm(w_sampling_analysis_new,lsx_options,MDI_Main_Frame,Help_Menu_Position,Layered!)	
end event

event ue_notes();// 08/12/05 MikeF	SPR4479d Call wf_select_subset to set global variable for active subset case

datetime 	ld_datetime
int			li_rc
n_cst_notes lnv_notes

ld_datetime = dw_list.getitemdatetime(dw_list.GetSelectedrow(0), "subc_run_time")    

this.wf_select_subset()

lnv_notes.is_notes_from = 'SS'
lnv_notes.idt_notes_date = date(ld_datetime)

IF is_case_id = 'NONE' then
	lnv_notes.is_notes_rel_id 		= is_subset_name
	lnv_notes.is_notes_rel_type 	= 'SS'
	lnv_notes.is_notes_sub_type	= 'GI'
ELSE
	li_rc = MessageBox("NOTES","Notes will be attached to the case, not the subset."+&
								"~rDo you want to view or add case notes?",exclamation!,YesNo!)
	IF li_rc = 2 THEN RETURN
	lnv_notes.is_notes_rel_id 		= is_case_key
	lnv_notes.is_notes_rel_type 	= 'CA'
	lnv_notes.is_notes_sub_type 	= 'SB'
	lnv_notes.is_notes_subset_id 	= is_subset_name
END IF

OpenSheetWithParm(w_notes_list,lnv_notes,MDI_main_frame,help_menu_position,Layered!)
end event

public subroutine wf_select_subset ();/////////////////////////////////////////////////////////////////////////////////////
//
// HYL	03/14/06		Track 4535d	When User ID is decoded, truncate 
//							description part of the instance variable is_user_id, 
//							since is_user_id is compared later with gc_user_id.
//	GaryR	04/13/07		Track 4885	Identify unique claim based on datasource settings
//
/////////////////////////////////////////////////////////////////////////////////////

Integer li_pos
String	ls_empty[]

n_cst_string			lnv_string

is_subset_id 	= dw_details.getitemstring(1, "link_key")
is_subset_name = dw_details.getitemstring(1, "link_name")
is_case_id 		= dw_details.getitemstring(1, "case_id") 
is_case_spl 	= dw_details.getitemstring(1, "case_spl") 
is_case_ver 	= dw_details.getitemstring(1, "case_ver") 
is_user_id		= dw_details.getitemstring(1, "link_user_id")

li_pos = Pos(is_user_id, ' - ')
IF li_pos > 0 THEN // HYL 03/14/06 Track 4535d
	is_user_id = Mid(is_user_id, 1, li_pos - 1)
END IF
is_subset_type	= dw_details.getitemstring(1, "subset_tbl_type")
is_desc			= dw_details.getitemstring(1, "link_desc")

is_tables = ls_empty
IF is_subset_type = 'ML' THEN
	is_ml_tables	= dw_details.getitemstring(1, "subc_tables")
	is_tables		= lnv_string.of_stringtoarray( is_ml_tables, "+" )
ELSE
	is_ml_tables	= ''
	is_tables[1] 	= is_subset_type
END IF

gc_active_subset_id  = is_subset_id
gv_subset_tbl_type  	= is_subset_type
gc_active_subset_case= trim(is_case_id + is_case_spl + is_case_ver)
gc_active_subset_name= is_subset_name

isx_query.subset_id 		= gc_active_subset_id
isx_query.subset_name	= gc_active_subset_name 
isx_query.sub_inv_type	= is_subset_type
isx_query.case_id 		= is_case_id 
isx_query.case_spl 		= is_case_spl
isx_query.case_ver 		= is_case_ver

isx_criteria.Parm = 'SUB'
isx_criteria.subset_ids.subset_id 			= is_subset_id
isx_criteria.subset_ids.subset_case_id		= is_case_id 		
isx_criteria.subset_ids.subset_case_spl	= is_case_spl		
Isx_criteria.subset_ids.subset_case_ver	= is_case_ver 		

isx_subset_ids.subset_id 			= is_subset_id
isx_subset_ids.subset_name			= is_subset_name
isx_subset_ids.subset_case_id 	= is_case_id 
isx_subset_ids.subset_case_spl 	= is_case_spl 
isx_subset_ids.subset_case_ver 	= is_case_ver
end subroutine

public subroutine wf_set_row_parms (long al_row);// 03/14/06	HYL	Track 4535d	When User ID is decoded, truncate description part of the instance variable is_user_id, since is_user_id is compared later with gc_user_id.
//	03/24/06	GaryR	Track 4522	Trim case NONE to reflect renamed Subsets in PDQs
//	11/09/06	GaryR	Track 4460	Accomodate Subset reassign functionality
// 06/13/08	GaryR	SPR5390	Convert Integers to Longs to prevent overflow
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

Integer li_pos

is_subset_id 		= dw_list.getitemstring(al_row, "link_key")
is_subset_name 	= dw_list.getitemstring(al_row, "link_name")
is_case_key			= trim(dw_list.getitemstring(al_row, "case_key"))
is_case_status		= dw_list.GetItemString(al_row, "case_status")

IF IsNull( is_case_status ) THEN is_case_status = ""

IF is_case_key = 'NONE' THEN
	is_case_id 		= is_case_key
	is_case_spl 	= ''
	is_case_ver 	= ''
ELSE
	is_case_id		= left(is_case_key,10) 
	is_case_spl 	= mid(is_case_key,11,2) 
	is_case_ver 	= mid(is_case_key,13,2) 
END IF

//Trim data
gnv_sql.of_trimdata( is_case_id )
gnv_sql.of_trimdata( is_case_spl )
gnv_sql.of_trimdata( is_case_ver )

is_user_id			= dw_list.getitemstring(al_row, "link_user_id")
li_pos = Pos(is_user_id, ' - ')
IF li_pos > 0 THEN // HYL 03/14/06 Track 4535d
	is_user_id = Mid(is_user_id, 1, li_pos - 1)
END IF

is_subset_type		= dw_list.getitemstring(al_row, "subc_sub_tbl_type")
is_desc		 		= dw_list.getitemstring(al_row, "link_desc")
ii_delete_access	= dw_list.getitemNumber(al_row, "delete_access")
is_object_id 		= dw_list.getitemstring(al_row, "object_id")

isx_subset_ids.subset_id 			= is_subset_id
isx_subset_ids.subset_name			= is_subset_name
isx_subset_ids.subset_case_id 	= is_case_id 
isx_subset_ids.subset_case_spl 	= is_case_spl 
isx_subset_ids.subset_case_ver 	= is_case_ver
end subroutine

public subroutine wf_saveas ();boolean		lb_valid_case
sx_subset_options lstr_subset_options

lstr_subset_options.come_from 	= "COPY"
lstr_subset_options.subset_name 	= is_subset_name	
lstr_subset_options.case_id 		= is_case_id
lstr_subset_options.case_spl 		= is_case_spl
lstr_subset_options.case_ver 		= is_case_ver
lstr_subset_options.subset_id 	= is_subset_id

OpenWithParm(w_subset_options,lstr_subset_options)	
end subroutine

on w_subset_list.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_view=create cb_view
this.cb_criteria=create cb_criteria
this.cb_summary=create cb_summary
this.cb_query=create cb_query
this.cb_patterns=create cb_patterns
this.cb_sample=create cb_sample
this.pb_notes=create pb_notes
this.cb_notes=create cb_notes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_view
this.Control[iCurrent+3]=this.cb_criteria
this.Control[iCurrent+4]=this.cb_summary
this.Control[iCurrent+5]=this.cb_query
this.Control[iCurrent+6]=this.cb_patterns
this.Control[iCurrent+7]=this.cb_sample
this.Control[iCurrent+8]=this.pb_notes
this.Control[iCurrent+9]=this.cb_notes
end on

on w_subset_list.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_view)
destroy(this.cb_criteria)
destroy(this.cb_summary)
destroy(this.cb_query)
destroy(this.cb_patterns)
destroy(this.cb_sample)
destroy(this.pb_notes)
destroy(this.cb_notes)
end on

event ue_retrieve_search;call super::ue_retrieve_search;//=============================================================================================//
// Object		w_subset_list
// Event			ue_retrieve_search
// Parameters	None
// Returns		None
// Call stack	Called from open event (w_master_list)
//=============================================================================================//
// Prepares dw_search
// * Adds "All users" and "All Subset Types"
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
//=============================================================================================//
DataWindowChild 	ldwc_search
int					i

// Add "  <All Users>"
dw_search.GetChild( "user_id", ldwc_search )
i = ldwc_search.InsertRow( 1 )
ldwc_search.SetItem( i, "cf_name", "< All Users >" )
ldwc_search.SetItem( i, "user_id", "" )
dw_search.SetItem( 1, "user_id", gc_user_id )

// Add "AA - All SUbset types"
dw_search.GetChild( "subset_type", ldwc_search )
i = ldwc_search.InsertRow( 1 )
ldwc_search.SetItem( i, "sub_cntl_subc_sub_tbl_type", "AA" )
ldwc_search.SetItem( i, "dictionary_elem_desc", "All Subset Types" )
dw_search.SetItem( 1, "subset_type", "AA" )
end event

event ue_retrieve_detail;call super::ue_retrieve_detail;//=============================================================================================//
// Object		w_subset_list
// Event			ue_retrieve_detail
// Parameters	al_row (long) - Selected row in dw_list
// Returns		None
//=============================================================================================//
// Sets instance variables then Retrieves dw_details 
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
// 08/17/05 MikeF	SPR4487d Changed to search by Name rather than ID
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//=============================================================================================//

this.wf_set_row_parms( al_row )
RETURN dw_details.Retrieve( is_subset_name, is_case_id, is_case_spl, is_case_ver )
end event

event ue_row_access;call super::ue_row_access;//=============================================================================================//
// Object		w_subset_list
// Event			ue_row_access
// Parameters	None
// Returns		None
//=============================================================================================//
// Updates Controls based on selected row
// * Enables / disables Update and Delete buttons
// * Toggles the ML tables visible in dw_details
// * Populates the Access message in dw_details
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
// 08/04/05 MikeF SPR4470d Get PDQ ID of first linked PDQ that isn't deleted
// 08/05/05 MikeF SPR4476d Check for BG job (moved PDQ logic to ue_postretrieve)
// 08/12/05 MikeF	SPR4481d Search for notes based on Subset Name rather than ID
// 09/13/05 MikeF	SPR4509d Enable Reset button when valid
// 02/07/06 HYL	SPR4627d	Moved the button disable logic from dw_list.RowFocusChanged
//									event to ue_row_access event.
// 03/03/06	HYL	SPR4627d	Disable three menu items from popup menu which appears when 
//									RMB is clicked on a subset row. Those are Subset Summary, 
//									Random Sample, and Patterns buttons.
//	04/06/06	GaryR	SPR4688	Do not disable the Delete button at row level
//	11/09/06	GaryR	SPR4460	Accomodate Subset reassign functionality
// 06/13/08	GaryR	SPR5390	Convert Integers to Longs to prevent overflow
//=============================================================================================//

string		ls_flag, ls_message, ls_sql
Long		ll_row
u_nvo_count	lnv_count

// Enable or disable the update and delete buttons
cb_update.enabled = is_user_id = gc_user_id
cb_reset.enabled  = cb_update.enabled

// Toggle name and description fields editable
IF is_user_id = gc_user_id THEN
	// Enable
	dw_details.Object.link_name.border = 5
	dw_details.Object.link_name.tabsequence = 10
	dw_details.Object.link_name.background.color = icl_white
	
	dw_details.Object.link_desc.border = 5
	dw_details.Object.link_desc.tabsequence = 20
	dw_details.Object.link_desc.background.color = icl_white
ELSE
	// Disable 
	dw_details.Object.link_name.border = 0
	dw_details.Object.link_name.tabsequence = 0
	dw_details.Object.link_name.background.color = icl_grey
	
	dw_details.Object.link_desc.border = 0
	dw_details.Object.link_desc.tabsequence = 0
	dw_details.Object.link_desc.background.color = icl_grey
END IF

//	Subset Reassign
IF ib_admin_user AND is_case_status <> "CL" AND is_case_status <> "RC" THEN
	dw_details.Object.link_user_id.border = 5
	dw_details.Object.link_user_id.tabsequence = 30
	dw_details.Object.link_user_id.DDDW.UseAsBorder = "Yes"
	dw_details.Object.link_user_id.background.color = icl_white
	cb_update.enabled = TRUE
	cb_reset.enabled = TRUE
ELSE
	dw_details.Object.link_user_id.border = 0
	dw_details.Object.link_user_id.tabsequence = 0
	dw_details.Object.link_user_id.DDDW.UseAsBorder = "No"
	dw_details.Object.link_user_id.background.color = icl_grey
END IF

// Show / Hide the ML table types
IF dw_details.GetItemString(1, "subset_tbl_type") = "ML" THEN
	ls_flag = "1"
ELSE
	ls_flag = "0"
END IF

dw_details.modify( "subc_tables.Visible=" + ls_flag) 

// Set the text for the access column
IF ii_delete_access = inv_subset.ici_allow THEN
	ls_message = "Yes: "
	IF is_user_id = gc_user_id THEN
		ls_message += "Subset owner"
	ELSE
		ls_message += "Admin User"
	END IF
ELSE
	// If denied, get reason
	ls_message = "No: " + inv_subset.isi_access_msg[ii_delete_access] + is_object_id
END IF

dw_details.SetItem(1, "access_reason", ls_message)

dw_details.ResetUpdate()

// Check for NOTES
lnv_count = CREATE u_nvo_count
lnv_count.uf_set_transaction( stars2ca )
ls_sql = "SELECT COUNT(*) FROM NOTES "

IF is_case_id = 'NONE' THEN			
	ls_sql += 	"WHERE NOTE_REL_TYPE = 'SS' " + &
					"AND NOTE_REL_ID = '" 			+ is_subset_name + "'"
ELSE
	ls_sql +=	"WHERE NOTE_REL_TYPE = 'CA' " + &
					"AND NOTE_SUB_TYPE = 'SB' "	+ &
					"AND NOTE_REL_ID = '" 			+ is_case_key 	+ "'"
END IF

lnv_count.uf_set_sql( ls_sql )

pb_notes.visible = lnv_count.uf_get_count() > 0

// 02/07/06 HYL Track 4627d Starts
ll_row = dw_list.GetRow()

IF ll_row < 1 THEN 
	ll_row = 1
	dw_list.Event ue_singleselect(ll_row)
END IF

// 01/26/06 HYL Track 4627d ; 03/03/06 HYL modified for popup menu issue
ib_ancillary = in_cst_stars_rel.of_is_ancillary_type(dw_list.Object.subc_sub_tbl_type[ll_row])
IF ib_ancillary THEN
	cb_summary.Enabled = FALSE
	cb_patterns.Enabled = FALSE
	cb_sample.Enabled = FALSE
ELSE
	cb_summary.Enabled = TRUE
	cb_patterns.Enabled = TRUE
	cb_sample.Enabled = TRUE
END IF
// 02/07/06 HYL Track 4627d Ends
end event

event open;call super::open;//=============================================================================================//
// Object		w_subset_list
// Event			open()
// Parameters	None
// Returns		None
//=============================================================================================//
// Open event
// * Creates RMM
// * Instantiates inv_case
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
//=============================================================================================//

im_rmm = CREATE m_subset_rmm
This.of_set_queryengine (TRUE)			
inv_case 	= CREATE n_cst_case
inv_subset 	= CREATE nvo_subset_functions
end event

event ue_delete;//=============================================================================================//
// Object		w_subset_list
// Event			ue_delete
// Parameters	None
// Returns		None
// Call stack	Called from cb_delete and m_subset_rmm
//=============================================================================================//
// Deletes subsets
// * Loops through and grabs all subsets marked for deletion
// * Prompts user with subset info conformation
// * Calls delete function
// * Removes subset from list and displays success message
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
// 03/15/06	HYL	SPR4688d	Do not allow user to delete any subset whose Delete Indicator is not checked.
//	04/06/06	GaryR	SPR4719	Refresh the list instead of re-retrieving to keep window ops
//	04/06/06	GaryR	SPR4688	Change the 0 row delete warning
//	06/06/06	GaryR	SPR4757	Perform housekeeping on detail functionality when 0 rows
// 06/13/08	GaryR	SPR5390	Convert Integers to Longs to prevent overflow
//=============================================================================================//

int			li_rc
long			ll_row, ll_rows, ll_current_row, ll_index
string		ls_message, ls_find

nvo_subset_functions		lnv_subset
sx_subset_ids 				lsx_subset_ids[]

// Get the currently selected row and row count
ll_current_row = dw_list.GetRow()
ll_rows = dw_list.RowCount()

// Loop through and compile list of subsets marked for deletion
FOR ll_row = 1 TO ll_rows
	
	IF dw_list.getitemnumber(ll_row, "delete_flag") = 1 THEN		
		this.wf_set_row_parms(ll_row)
		ll_index++
		lsx_subset_ids[ll_index] = isx_subset_ids
		ls_message += is_subset_name + ": " + is_subset_type + " " + is_desc + "~r~n"				
	END IF
	
NEXT

// If no boxes checked, inform user to check on Delete Indicator box for subset to delete. 03/15/06 HYL Track 4688d
IF ll_index = 0 THEN
	MessageBox("Delete Subset","Please check the Delete Indicator for the subset(s) you wish to delete.")
	RETURN
END IF

// Prompt user with list of subsets that will be deleted
li_rc	=	MessageBox( "Confirm Delete", &
							"The following subsets will be deleted:~r~r" + ls_message + &
							"~rContinue?", &
							Exclamation!, YesNo!)

IF li_rc = 2 THEN RETURN

// Loop through and delete based on structures
lnv_subset	=	CREATE	nvo_subset_functions

dw_list.SetRedraw( FALSE )
FOR ll_index = 1 TO UpperBound(lsx_subset_ids)
	lnv_subset.uf_set_structure(lsx_subset_ids[ll_index])	
	li_rc = lnv_subset.uf_delete_subset()		
	
	IF li_rc <> 1 THEN
		DESTROY lnv_subset
		Stars2ca.of_rollback()
		dw_list.SetRedraw( TRUE )
		RETURN
	END IF
	
	//Delete the row from the window
	ls_find = "Trim(case_key) = '" + Trim(lsx_subset_ids[ll_index].subset_case_id + &
						lsx_subset_ids[ll_index].subset_case_spl + &
						lsx_subset_ids[ll_index].subset_case_ver) + "' " + &
						"and link_key = '" + lsx_subset_ids[ll_index].subset_id + "'"
	ll_row = dw_list.find( ls_find, 0, dw_list.RowCount() )
	IF ll_row > 0 THEN dw_list.DeleteRow( ll_row )

NEXT
dw_list.SetRedraw( TRUE )

DESTROY lnv_subset

// Now set the seleted row
ll_rows = dw_list.RowCount()
IF ll_rows > 0 THEN
	IF ll_current_row > ll_rows THEN ll_current_row = ll_rows
	IF ll_current_row < 1 THEN ll_current_row = 1
	dw_list.Event RowFocusChanged(ll_current_row)
ELSE
	This.Event ue_disable_details()
END IF

MessageBox("Subset(s) Deleted",string(UpperBound(lsx_subset_ids)) + " subset(s) successfully deleted.") 
end event

event close;call super::close;IF IsValid(inv_case) THEN DESTROY inv_case
end event

event ue_postretrieve;call super::ue_postretrieve;//=============================================================================================//
// Object		w_subset_list
// Event			ue_postretrieve
// Parameters	None
// Returns		None
// Call stack	Called from ue_retrieve_list (w_master_list) after retrieving dw_list
//=============================================================================================//
// Loops through all rows in dw_list and determines and sets subset delete rights
//=============================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------
// 05/27/05	MikeF	SPR4319d	Created
// 08/04/05 MikeF SPR4470d Check linked PDQ deleted indicator
// 08/05/05 MikeF SPR4476d See if subset is linked to scheduled BG job
// 08/11/05 MikeF SPR4458d Added code to disable buttons if the list is empty.
// 08/19/05 MikeF SPR4489d Check for Subset as part of saved PDR PDQ
// 09/30/05 MikeF	SPR4521d	Performance issue. Retrieve datastores once rather than per row.
//	04/06/06	GaryR	SPR4688	Do not disable the Delete button at row level
// 06/13/08	GaryR	SPR5390	Convert Integers to Longs to prevent overflow
//=============================================================================================//

string	ls_status, ls_user, ls_name, ls_subset_id, ls_object_id, ls_case_key 
string 	ls_sql, ls_data_type, ls_tbl_type
int		li_access
boolean	lb_pdq, lb_enable
long		ll_row, ll_rowcount

// Retrieve datastores for delete checking
ll_rowcount = dw_list.rowcount()
IF ll_rowcount > 0 THEN
	inv_subset.uf_retrieve_datastores()
END IF

// Loop through all displayed rows to determine if each can be deleted
FOR ll_row = 1 to ll_rowcount
	li_access 		= inv_subset.ici_allow
	ls_name	 		= dw_list.GetItemString(ll_row, "link_name")
	ls_status 		= dw_list.GetItemString(ll_row, "case_status")
	ls_user	 		= dw_list.GetItemString(ll_row, "link_user_id")
	ls_subset_id 	= dw_list.GetItemString(ll_row, "link_key")
	ls_case_key		= trim(dw_list.GetItemString(ll_row, "case_key"))
	ls_object_id 	= " "
		
	// Check Case status and user Ids
	IF ls_status = 'CL' THEN 
		li_access = inv_subset.ici_case_closed
	ELSEIF ls_status = 'RC' THEN 
		li_access = inv_subset.ici_case_referred
	ELSEIF ls_user <> gc_user_id AND NOT ib_admin_user THEN
		li_access = inv_subset.ici_not_owner
	END IF
	
	// Check to see if subset is linked to PDQ OR PDR Query
	IF li_access = inv_subset.ici_allow THEN
		li_access = inv_subset.uf_get_delete_access(ls_name, ls_case_key, ls_object_id)
	END IF
		
	// Update list data
	IF li_access > 0 THEN
		dw_list.SetItem(ll_row, "delete_access", li_access)
		dw_list.SetItem(ll_row, "object_id", ls_object_id)
	END IF
	
NEXT

// Enable / Disable buttons
lb_enable = dw_list.getrow() > 0
cb_view.enabled  		= lb_enable
cb_query.enabled 		= lb_enable
cb_criteria.enabled 	= lb_enable
cb_sample.enabled 	= lb_enable
cb_patterns.enabled 	= lb_enable
cb_summary.enabled 	= lb_enable
cb_notes.enabled 		= lb_enable
cb_delete.enabled 	= lb_enable


end event

event ue_presave;call super::ue_presave;//==========================================================================================//
// Object:  	w_subset_list 
// Script:		ue_presave
// Arguments:	none
// Returns:		Integer	0 if successful, -1 if there is an issue
//==========================================================================================//
// Performs pre-update edits and logs changes to case log.
//-----------------------------------------------------------------------------
// Maintenance 
// -------- -----	--------	---------------------------------------------------
// 06/08/05	MikeF	SPR4319d	Created
//	11/09/06	GaryR	SPR4460	Accomodate Subset reassign functionality
//==========================================================================================//
string		ls_name, ls_message, ls_user_id

ls_name = trim(dw_details.GetItemstring( 1, "link_name" ))
ls_user_id = dw_details.GetitemString( 1, "link_user_id" )

IF ls_name = "" THEN
	MessageBox('Edit','Subset ID cannot be blank, please enter a new ID.', StopSign! )
	Return -1
ELSEIF Pos( ls_name, "'" ) > 0 OR Pos( ls_name, '"' ) > 0 THEN
	Messagebox('Edit','Subset ID cannot contain quotes, please enter a new ID.', StopSign! )
	Return -1
END IF

IF ls_name <> is_subset_name THEN

	// Check to see if link exists
	IF inv_case.uf_get_link_exists(is_case_id, is_case_spl, is_case_ver, "SUB", ls_name) THEN
		MessageBox('Edit','Duplicate Subset ID, please choose another ID', StopSign! )
		RETURN -1
	END IF

	// Change all subset name references
	inv_subset.uf_post_rename( is_subset_name, ls_name, is_case_id, is_case_spl, is_case_ver)

	// Write to audit log
	IF is_case_id <> 'NONE' THEN
		ls_message   = "Subset " + is_subset_name + " renamed to " + ls_name

		IF	inv_case.uf_audit_log ( is_case_id, is_case_spl, is_case_ver, ls_message )	< 0 THEN
			Stars2ca.of_rollback()
			MessageBox ('Database Error', 'Could not insert new Subset name into case log', StopSign! )
			Return -1
		END IF
	END IF
	
END IF

// Process User ID
IF ls_user_id <> is_user_id THEN
	//	Validate user id
	IF IsNull( ls_user_id ) OR Trim( ls_user_id ) = "" THEN
		MessageBox('Edit','User ID cannot be blank, please select a valid User ID.', StopSign! )
		Return -1
	END IF
	
	// Case Log for User ID
	IF is_case_id <> 'NONE' THEN
		ls_message   = "Subset " + is_subset_name + " reassigned from User ID: " + &
									is_user_id + " to User ID: " + ls_user_id

		IF	inv_case.uf_audit_log ( is_case_id, is_case_spl, is_case_ver, ls_message )	< 0 THEN
			Stars2ca.of_rollback()
			MessageBox ('Database Error', 'Could not insert Subset reassign action into CASE_LOG', StopSign! )
			Return -1
		END IF
	END IF
	
END IF

RETURN AncestorReturnValue
end event

event ue_disable_details;call super::ue_disable_details;////////////////////////////////////////////////////////////////////////////////////
//
//	06/06/06	GaryR	SPR4757	Perform housekeeping on detail functionality when 0 rows
//
////////////////////////////////////////////////////////////////////////////////////

pb_notes.visible = false
end event

event ue_open_rmm;call super::ue_open_rmm;// 03/03/06	HYL	Track	4627d	Disable three menu items from popup menu which appears when RMB is clicked on a subset row.
//											Those are Subset Summary, Random Sample, and Patterns buttons.
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

Long		ll_row
String	ls_subset

//	MikeFl 8/4/05 - SPR 4475
// If the right-mouse click was not on a column, get out.
ll_row = dw_list.GetSelectedRow( 0 )
IF	ll_row < 1 THEN Return

ls_subset = dw_list.getitemstring(ll_row, "link_key")
im_rmm.m_subset.m_activesubset.checked = gc_active_subset_id = ls_subset
// 03/06/06 HYL Track 4627d 
IF ib_ancillary THEN // ib_ancillary is set in Parent.ue_row_access event
	im_rmm.m_subset.m_subsetsummary.Enabled = FALSE
	im_rmm.m_subset.m_randomsample.Enabled = FALSE
	im_rmm.m_subset.m_patterns.Enabled = FALSE
ELSE
	im_rmm.m_subset.m_subsetsummary.Enabled = TRUE
	im_rmm.m_subset.m_randomsample.Enabled = TRUE
	im_rmm.m_subset.m_patterns.Enabled = TRUE
END IF
im_rmm.m_subset.popmenu (This.pointerx() + 5, This.pointery() + 20)
end event

type cb_close from w_master_list`cb_close within w_subset_list
integer x = 3406
integer y = 1808
integer width = 320
integer taborder = 180
end type

type uo_range from w_master_list`uo_range within w_subset_list
boolean visible = true
integer x = 2386
integer y = 92
integer width = 937
integer height = 256
end type

type st_dw_ops from w_master_list`st_dw_ops within w_subset_list
integer x = 41
integer y = 1776
integer width = 603
integer height = 60
end type

type cb_delete from w_master_list`cb_delete within w_subset_list
integer x = 1691
integer y = 1808
integer width = 320
integer taborder = 90
end type

type cb_reset from w_master_list`cb_reset within w_subset_list
integer x = 3342
integer y = 2124
integer width = 320
integer taborder = 160
end type

type cb_add from w_master_list`cb_add within w_subset_list
boolean visible = false
integer x = 41
integer y = 1780
integer taborder = 0
end type

type dw_details from w_master_list`dw_details within w_subset_list
integer x = 50
integer y = 1976
integer width = 3168
integer height = 424
integer taborder = 140
string dataobject = "d_subset_detail"
end type

type st_rows from w_master_list`st_rows within w_subset_list
integer x = 1111
integer y = 1856
end type

type cb_update from w_master_list`cb_update within w_subset_list
integer x = 3342
integer y = 1980
integer width = 320
integer taborder = 150
end type

event cb_update::clicked;// override the ancestor script
// 03/09/06	HYL	Track 4535d	Ancestor script runs ue_retrieve_list  event script. Instead set the changed value directly onto dw_list datawindow.

int	li_rc

dw_details.AcceptText()

li_rc = Parent.Event ue_save()

ll_update_row = dw_list.Getselectedrow( 0 )

IF li_rc = 1 THEN
	dw_list.SetItem( ll_update_row, "link_name", dw_details.GetItemString( 1, "link_name") )
	dw_list.SetItem( ll_update_row, "link_desc", dw_details.GetItemString( 1, "link_desc") )
	dw_list.SetItem( ll_update_row, "link_user_id", dw_details.GetItemString( 1, "link_user_id") )
END IF
end event

type cb_list from w_master_list`cb_list within w_subset_list
integer x = 3346
integer y = 168
end type

type dw_list from w_master_list`dw_list within w_subset_list
integer y = 416
integer width = 3707
integer height = 1348
string title = "Subset List"
string dataobject = "d_subset_list"
boolean hsplitscroll = true
end type

event dw_list::ue_retrieve;// 08/15/05 MikeF	SPR4477d	Removed all references to Subset ID
// 08/17/05 MikeF	SPR4488d	Include valid ML subsets when selecting invoice type
// 06/13/08	GaryR	SPR5390	Convert Integers to Longs to prevent overflow
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

String	ls_user, ls_subset_id, ls_subset_name, ls_tbl_type, ls_desc
String	ls_case_id, ls_case_spl, ls_case_ver
Integer	li_len
Date		ld_from, ld_thru

IF dw_search.AcceptText() <> 1 THEN RETURN 0

ls_user 			= Trim(dw_search.GetItemString( 1, "user_id" 	 )	)
ls_subset_name	= Trim(dw_search.GetItemString( 1, "subset_name" ) ) 	+ "%"
ls_case_id 		= Trim(dw_search.GetItemString( 1, "case_id" 	 )	)
ls_desc	 		= Trim(dw_search.GetItemString( 1, "description" ) ) 	+ "%"
ls_tbl_type		= dw_search.GetItemString( 1, "subset_type" )

// Set values for searches
IF len(ls_user) = 0 	 THEN ls_user = "%"
IF len(ls_desc) > 1 	 THEN ls_desc = "%" + ls_desc

// Check table types
CHOOSE CASE ls_tbl_type
	CASE 'AA' 
		// All subsets
		ls_tbl_type = '%'
	CASE 'ML' 
		// Multi-level - leave as is
	CASE ELSE 
		// Selected invoice type - wrap in quotes to get ML subsets too
		ls_tbl_type = '%' + ls_tbl_type + '%'
END CHOOSE

li_len = Len( ls_case_id )
IF li_len > 10 THEN
	ls_case_spl = Trim( Mid( ls_case_id, 11, 2 )) + "%"
	ls_case_ver = Trim( Mid( ls_case_id, 13, 2 )) + "%"
	ls_case_id = Trim( Left( ls_case_id, 10 )) + "%"
ELSE
	ls_case_id += "%"
	ls_case_spl = "%"
	ls_case_ver = "%"
END IF

RETURN dw_list.retrieve(ls_user, ls_tbl_type, id_from, id_thru, ls_subset_name, &
								ls_case_id, ls_case_spl, ls_case_ver, ls_desc)
end event

event dw_list::clicked;call super::clicked;//================================================================================================//
// Maintenance
// -------- ----- -------- ---------------------------------------------------------------------- //
// 08/12/05 MikeF SPR4478d Moved all check/un-check logic to code ratherthan dw
//================================================================================================//
int 		li_pos
string 	ls_object, ls_col_name

ls_object = Getobjectatpointer(dw_list)

li_pos 	= pos (ls_object,"~t")
ls_object= left(ls_object,(li_pos - 1))

IF ls_object <> 'delete_flag' THEN RETURN

IF dw_list.GetItemNumber( row, 'delete_flag') = 0 THEN
	dw_list.SetItem( row, 'delete_flag', 1)
ELSE
	dw_list.SetItem( row, 'delete_flag', 0)
END IF 

end event

event dw_list::rowfocuschanged;call super::rowfocuschanged;// 01/26/06 HYL 	Track 4627d Disable Summary, Patterns, and Sample buttons when a row with ancillary invoice type is clicked.

Long		ll_row

ll_row = dw_list.GetRow()

IF ll_row < 1 THEN Return


end event

event dw_list::ue_dwnkey;call super::ue_dwnkey;//	05/29/09	GaryR	GNL.600.5633.012	Provide keyboard equivalent

Long	ll_row

IF key = KeySpaceBar! THEN
	ll_row = This.GetRow()
	IF This.GetItemNumber( ll_row, 'delete_access') = 0 THEN
		IF This.GetItemNumber( ll_row, 'delete_flag') = 0 THEN
			This.SetItem( ll_row, 'delete_flag', 1)
		ELSE
			This.SetItem( ll_row, 'delete_flag', 0)
		END IF
	END IF
END IF
end event

type dw_search from w_master_list`dw_search within w_subset_list
integer x = 55
integer y = 72
integer width = 2254
integer height = 312
string dataobject = "d_subset_search"
end type

event dw_search::ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

IF Lower(as_col) = 'case_id' THEN
	gv_from = 'AC'
	Open(w_case_list_response)
	This.object.case_id[1] = gv_active_case
END IF
end event

type gb_details from w_master_list`gb_details within w_subset_list
integer x = 27
integer y = 1924
integer width = 3707
integer height = 488
end type

type ddlb_dw_ops from w_master_list`ddlb_dw_ops within w_subset_list
integer x = 37
integer y = 1836
integer width = 603
integer height = 420
end type

type gb_2 from w_master_list`gb_2 within w_subset_list
integer x = 32
integer y = 16
integer width = 2313
integer height = 376
end type

type gb_1 from groupbox within w_subset_list
string accessiblename = "Create Date"
string accessibledescription = "Create  Date"
accessiblerole accessiblerole = groupingrole!
integer x = 2363
integer y = 16
integer width = 1371
integer height = 376
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Create Date"
end type

type cb_view from u_cb within w_subset_list
string accessiblename = "View"
string accessibledescription = "View"
integer x = 2720
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "View"
end type

event clicked;parent.event ue_view()
end event

type cb_criteria from u_cb within w_subset_list
string accessiblename = "Criteria"
string accessibledescription = "Criteria"
integer x = 2034
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Criteria"
end type

event clicked;parent.event ue_criteria()
end event

type cb_summary from u_cb within w_subset_list
string accessiblename = "Summary"
string accessibledescription = "Summary"
integer x = 663
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Summary"
end type

event clicked;call super::clicked;parent.event ue_subset_summary( )
end event

type cb_query from u_cb within w_subset_list
string accessiblename = "Query"
string accessibledescription = "Query"
integer x = 2377
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Query"
end type

event clicked;call super::clicked;parent.event ue_query( )
end event

type cb_patterns from u_cb within w_subset_list
string accessiblename = "Patterns"
string accessibledescription = "Patterns"
integer x = 1006
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Patterns"
end type

event clicked;call super::clicked;parent.event ue_pattern( )
end event

type cb_sample from u_cb within w_subset_list
string accessiblename = "Sample"
string accessibledescription = "Sample"
integer x = 1349
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Sample"
end type

event clicked;call super::clicked;parent.event ue_random_sample( )
end event

type pb_notes from picturebutton within w_subset_list
boolean visible = false
string accessiblename = "Notes"
string accessibledescription = "Notes"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3433
integer y = 2272
integer width = 155
integer height = 108
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "SCRIPT1.BMP"
alignment htextalign = left!
boolean map3dcolors = true
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;// Rick-b  SPR 5534 - Fixed the subset list Notes icon to point to script1.bmp and to be consistent
//                             with the other Notes bitmaps throughout STARS.

parent.event ue_notes( )
end event

type cb_notes from u_cb within w_subset_list
string accessiblename = "Notes"
string accessibledescription = "Notes"
integer x = 3063
integer y = 1808
integer width = 320
integer height = 108
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Notes"
end type

event clicked;call super::clicked;parent.event ue_notes( )
end event

