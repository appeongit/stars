HA$PBExportHeader$u_nvo_source.sru
$PBExportComments$Inherited from u_nvo_query <logic>
forward
global type u_nvo_source from u_nvo_query
end type
end forward

global type u_nvo_source from u_nvo_query
event type integer ue_tabpage_source_construct ( string as_subset_id,  string as_auth_id )
event type integer ue_tabpage_source_get_source_sub_tables ( string as_subset_id,  ref string as_inv_type[] )
event type integer ue_tabpage_source_set_data_type ( string as_data_type,  string as_subset_name,  string as_case_id )
event type integer ue_tabpage_source_load ( integer ai_level_num )
event type integer ue_tabpage_source_load_additional_data ( string as_inv_type,  string as_subset_id )
event ue_tabpage_source_determine_source_type ( )
event type integer ue_tabpage_source_match_type_and_source ( )
event type string ue_tabpage_source_get_inv_type ( )
event type integer ue_tabpage_source_get_both_data_sources ( ref string as_inv_types[] )
event type integer ue_tabpage_source_save ( integer ai_level,  string as_query_id )
event type integer ue_tabpage_source_clear ( string as_path )
event type integer ue_tabpage_source_set_subset_id ( integer ai_row,  string as_subset_name )
event type integer ue_tabpage_source_set_subset_data_source ( string as_subset_id )
event type integer ue_tabpage_source_set_base_data_source ( boolean ab_new_level )
event ue_tabpage_source_retrieve_base_source ( )
event type integer ue_tabpage_source_filter_data_source ( )
event type integer ue_add_data_source_change ( string as_add_data_source )
event type integer ue_drilldown_load_new_query ( )
event type integer ue_tabpage_source_enable_cat ( boolean ab_switch,  string as_inv_type )
event ue_tabpage_source_get_desc ( )
end type
global u_nvo_source u_nvo_source

type variables
Boolean		ib_load_data
end variables

forward prototypes
public function string of_get_mc_desc ()
end prototypes

event type integer ue_tabpage_source_construct(string as_subset_id, string as_auth_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_tabpage_source_construct			uo_query
//
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//This event will be called in the constructor event of uo_query , 
//open of w_query_engine if entering from Subset View or 
//Subset Details window, w_query_engine.ue_new_level when Next 
//Level is selected from a menu or uo_query.ue_new_query() 
//if selected New from im_list to create a new query.  It will 
//retrieve the datawindow containing the controls on the window.  
//If entering from Subset View or Subset Details window must only 
//populated d_data_source with invoice type(s) in subset 
//(and the 'ML - Multi-Level' entry if an ML subset) and disable 
//the data source group box.  If single invoice type, select the 
//invoice type in the data source dddw.  If ML, select ML.  
//If as_auth_id contains data will load the authorization data source 
//using the table type passed in.  Else if not any of the above will 
//load all invoice types and ancillary tables (New Query).
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			as_subset_id	String				The subset id.
//		Value			as_auth_id		String				The authorization id.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
//						-1				Data error.
//						-2				no datawindow child
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/08/97	Created.
//
//	FDG		02/03/98	When as_auth_id not '', the SQL must have
//							rel_type = 'AN' (not 'QT').  Also, reset
//							and insert a row into idw_source.
//
//	J.Mattis	02/11/98	Added assignments to case_id and subset_name.
//
//	J.Mattis	02/24/98	Added logic to set the default invoice type
//							to the system default.
//
// FNC		03/03/98 Track 868.  Set is_data_type at same time
//							that rb_source is set. This will insure that the 
//							instance variable is set even if the user does 
//							not click on the source radio button.
//
//	FDG		03/03/98	Track 884.  When coming in from an
//							outside window and the subset is an 'ML' 
//							subset, default the data_source to 'ML'.  This
//							should cause the report on fields to include
//							all invoice types and 'MC' (= gv_sys_dflt).
//
// FNC		03/11/98	Track 920.  Set lb_initialcontruct to TRUE
//							if coming in through subset view
//
//	FNC		03/12/98	Added split and ver to the displayed case id
//
//	FDG		03/13/98	Track 912.  When coming in to display an ML subset,
//							set the data source to ML.
//
// FNC		03/18/98	Scroll to current row so that the get row in other 
//							events will return a 1 instead of 0.
//
//	FDG		04/02/98	Track 1010.  Reset the SQL to ldwc_data_source for a
//							base data type (in case the previous query had a
//							subset data type).
//
//	FDG		04/03/98	Track 1037.  Include ancillary tables with the SQL.
//
//	FDG		04/09/98	Track 1063.  For a new level, set rb_source to 'Base'
//
//	FDG		04/13/98	Track 1037.  For a ML query, ancillary tables are not
//							retrieved.
//
//	FDG		04/14/98	Track 975, 1063.  Trigger an event to set rb_source
//							to 'Base'.
// FNC		05/14/98	Track 1091 Call to ue_tabpage_source_set_data_type to set 
//							the data type to base should not pass a subset name.
//							Removed the subset name.
// FNC		06/03/98	Track 1166. If as_subset_id =  new level set lb_new_level =
//							TRUE so can reference it later in the script. Call
//							UE_Tabpage_Source_Set_Base_Data_Source in order to set the
//							datasource dddw.
// FNC		06/17/98	Track 1311. The new level logic from 6/3/98 is no longer 
//							necessary because the events 
//							ue_tabpage_source_set_subset_data_source and 
//							ue_tabpage_source_retrieve_base_source were modified to 
//							remove MC if the level is greater than 1.
// FNC		09/08/98	Track 1611. Add fastttrack invoice type if subset is UB92.
//	FDG		10/23/98	Track 1933. When loading an existing query, set ib_load_data
//							to true for ue_tabpage_source_set_base_data_source.
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//							to prevent locking.
//	GaryR		03/04/03	Track 3385d	Disable Claim Detail when ML
//	GaryR		08/06/04	Track 4049d	Provide drilldown from Subset Summary
//	GaryR		10/12/05	Track 4527d	Set the active Subset's Case ID to prevent XREF window
//	GaryR		09/08/06	Track 4816	Set proper inv type when drilling down from ML FT Subset Summary
//	GaryR		12/20/07	SPR 5199	Add the facility to categorize and sort data sources
//	GaryR		12/21/07	SPR 5234	Add descriptions to selected data sources
//	GaryR		05/02/08	SPR 5346	Set the description when adding MC or ML artificially
//	GaryR		07/23/08	SPR 5409	Accommodate column concatenation in MSS
//	K. Riley	08/21/08	SPR 5516 Ensured that drop-down being pre-populated with inv and desc
//										when viewing a subset.
//	GaryR		11/19/08	SPR 5516	When viewing a UB92 subset get the data source description for dependent
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

integer	li_idx,				&
			li_rc
long		ll_num_rows,		&
			ll_num_tables,		&
			ll_row,				&
			ll_dddw_row
string	ls_sql,				&
			ls_sub_inv_types[], &
			ls_inv_types,		&
			ls_auth_tbl_type,	&
			ls_table,			&
			ls_data_source,	&
			ls_sel,				&
			ls_ft_inv_type,	&
			ls_ft_desc,			&
			ls_ft_rel_desc,	&
			ls_fasttrack,		&
			ls_cat
			
n_cst_revenue lnvo_revenue

Constant String LS_INITIAL			=	"INITIAL_LEVEL"
Constant String LS_MULTI_LEVEL	=	"ML - Multi Level"
Constant String LS_NEW_LEVEL		=	"NEW_LEVEL"				// FDG 04/09/98
Constant	String LS_SUBSET_DETAILS = "*SUBSET_DETAILS*"

Boolean 	lb_InitialConstruct,	&
			lb_NewLevel, 			&
			lb_SubsetDetails

//	FDG 04/09/98 - Add 'NEW_LEVEL' to this IF statement
IF Upper(Trim(as_subset_id))	=	LS_INITIAL	THEN
	as_subset_id = ''
	lb_InitialConstruct = TRUE
ELSEIF Upper(Trim(as_subset_id))	=	LS_NEW_LEVEL	THEN	// FNC 06/03/98
	as_subset_id = ''													// FNC 06/03/98
	lb_NewLevel = TRUE												// FNC 06/03/98
ELSEIF as_subset_id = LS_SUBSET_DETAILS THEN
	as_subset_id = ''
	lb_SubsetDetails = TRUE
ELSEIF as_subset_id <> '' THEN	//03-11-98 FNC
	lb_InitialConstruct = TRUE		//03-11-98 FNC
END IF

datawindowchild ldwc_data_source

idw_source.Reset()
				
ll_row =	idw_source.InsertRow(0)
idw_source.ScrollToRow(0)		//03-18-98	FNC

idw_source.getchild('data_source',ldwc_data_source)

ldwc_data_source.SetTransObject(Stars2ca)

// FDG 10/23/98	begin
IF	as_subset_id	<>	''		&
OR	as_auth_id		<>	''		THEN
	ib_load_data	=	TRUE
END IF
// FDG 10/23/98	end

IF NOT IsValid( ldwc_data_source ) THEN
	// invalid data source dwc
	ib_load_data	=	FALSE				// FDG 10/23/98
	RETURN -2
END IF

this.event UE_Tabpage_Source_Set_Base_Data_Source(LB_NewLevel)	// FNC 06/03/98 

if as_subset_id <> '' then  /* subset view */
	
	// populate the subset structure
	sx_subset_ids lsx_Subset
	lsx_Subset = iw_parent.wf_Get_SxSubset()	//Added 2/11/98 JTM
	
	this.event ue_tabpage_source_get_source_sub_tables(as_subset_id,ls_sub_inv_types)
	ll_num_tables = upperbound(ls_sub_inv_types)
	if (ll_num_tables < 1) then
		ib_load_data	=	FALSE				// FDG 10/23/98
		return -1
	end if
	
	for li_idx = 1 to ll_num_tables  /* build value for IN statement */
		ls_inv_types = ls_inv_types + ",'" + ls_sub_inv_types[li_idx] + "'"
	next
	
	This.Event	ue_tabpage_source_enable_cat( FALSE, "" )
	
	ls_inv_types = mid(ls_inv_types,2)  /* remove first ',' */
	//	FDG 03/03/98 - Include 'MC' with the invoice types
	ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
				+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
				+ "from stars_rel sr, dictionary dt " &
				+ "where sr.id_2 = dt.elem_tbl_type " &
				+ "and sr.rel_type in ('QT','AN') " &
				+ "and dt.elem_type = 'TB' " &
				+ "and sr.id_2 in (" + Upper( ls_inv_types ) + ")"
				
	ldwc_data_source.setsqlselect(ls_sql)
	
	ll_num_rows = ldwc_data_source.retrieve()
	
	if ll_num_rows > 0 then								// FNC 04/14/99
		stars2ca.of_commit()								// FNC 04/14/99
	end if													// FNC 04/14/99
				
	if ll_num_tables > 1 then
		//	FDG 03/03/98 - Insert 'ML - MultiLevel" at the top of the DDDW
		ls_data_source = This.of_get_mc_desc()
		ll_dddw_row	=	ldwc_data_source.InsertRow(1)			//	Insert at the top
		ldwc_data_source.SetItem (ll_dddw_row, 'stars_rel_id_2', "ML")
		ldwc_data_source.SetItem (ll_dddw_row, 'dictionary_elem_desc', "Multi Level")
		ldwc_data_source.SetItem (ll_dddw_row, "stars_rel_rel_desc", ls_data_source)
		ldwc_data_source.SelectRow (ll_dddw_row, TRUE)
		idw_source.SetColumn('data_source')			//	FDG 03/13/98
		idw_source.SetText(LS_MULTI_LEVEL)			//	FDG 03/13/98
		idw_source.AcceptText()							//	FDG 03/13/98
		//	FDG 03/03/98 end
	else
		ldwc_data_source.selectrow(1,True)
		ls_data_source = 	ldwc_data_source.GetItemString(ll_Row,'stars_rel_id_2')
		// FNC 09/08/98 Start
		lnvo_revenue = create n_cst_revenue
		ls_fasttrack = lnvo_revenue.of_get_base_type(ls_data_source)
		destroy(lnvo_revenue)
		
		if ls_fasttrack = 'UB92' then
				li_rc = w_main.dw_stars_rel_dict.SetFilter("")
				li_rc = w_main.dw_stars_rel_dict.Filter()
				ls_sel = "rel_type = 'DP' and id_3 = '" + left(ls_data_source,2) + "'"
				li_rc = w_main.dw_stars_rel_dict.SetFilter(ls_sel)
				li_rc = w_main.dw_stars_rel_dict.Filter()
				
				IF li_rc > 0 THEN
					ls_ft_inv_type = w_main.dw_stars_rel_dict.GetItemString(1,'REL_ID') 
					ls_ft_desc = w_main.dw_stars_rel_dict.GetItemString(1,'dictionary_elem_desc')
					
					SELECT REL_DESC
					INTO :ls_ft_rel_desc
					FROM STARS_REL
					WHERE REL_TYPE = 'QT'
					AND REL_ID = 'MC'
					AND ID_2 = :ls_ft_inv_type
					USING Stars2ca;
					
					IF Stars2ca.of_check_status() < 0 OR IsNull( ls_ft_rel_desc ) THEN
						ls_ft_rel_desc = w_main.dw_stars_rel_dict.GetItemString(1,'rel_desc')
					END IF
				
					ll_dddw_row	=	ldwc_data_source.InsertRow(0)			//	Insert at the bottm
					ldwc_data_source.SetItem (ll_dddw_row, 'stars_rel_id_2', ls_ft_inv_type)
					ldwc_data_source.SetItem (ll_dddw_row, 'dictionary_elem_desc', ls_ft_desc)
					ldwc_data_source.SetItem (ll_dddw_row, "stars_rel_rel_desc", ls_ft_rel_desc)
				END IF
		end if
		// FNC 09/08/98
		//03-11-98 FNC
		IF Trim(ls_data_source) <> '' AND Not(IsNull(ls_data_source)) THEN
			ls_data_source = 	ldwc_data_source.GetItemString(ll_Row,'compute_0001')
			ldwc_data_source.SelectRow (ll_Row, TRUE)
			idw_source.SetColumn('data_source')
			idw_source.SetText(ls_data_source)
			idw_source.AcceptText()
		END IF
		//03-11-98 FNC
	end if
	
	IF ll_row > 0 THEN
		/* set rb_source to subset and disable data type group box */
		idw_source.SetItem(ll_row,'rb_source','Subset')
		idw_source.object.rb_source.protect = 1
		// set the case id & subset name?? Added 2/11/98 JTM
		idw_source.object.subset_name[ll_Row] = lsx_Subset.subset_name
		idw_source.object.case_id[ll_Row] = &
			lsx_Subset.subset_case_id + lsx_Subset.subset_case_spl + &
				lsx_Subset.subset_case_ver					//03-12-98 FNC

		idw_source.object.subset_name.Protect = 1
		is_data_type = 'SUBSET'					//03-03-98 FNC
		//set the title
		IF IsValid(iw_Parent) THEN iw_Parent.title = 'Subset View for ' + idw_source.GetItemString(ll_row,'subset_name')					
	END IF
else 
	
	if as_auth_id <> '' then	
		// authorization view - Insert a row into idw_source
		
		ls_auth_tbl_type = mid(as_auth_id,2,2)
		
		ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
			+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
			+ "from stars_rel sr, dictionary dt " &
			+ "where sr.id_2 = dt.elem_tbl_type " &
			+ "and sr.rel_type = 'AN' " &
			+ "and dt.elem_type = 'TB' " &
			+ "and sr.id_2 = '" + Upper( ls_auth_tbl_type ) + "'" 
		
		ldwc_data_source.setsqlselect(ls_sql)
		
		ll_num_rows = ldwc_data_source.retrieve()
		
		if ll_num_rows > 0 then								// FNC 04/14/99
			stars2ca.of_commit()								// FNC 04/14/99
		end if													// FNC 04/14/99
		
	else	 
		// regular query - real construct
		//	Reset the SQL for ldwc_data_source in case the previous query was
		//	a subset based query.
		
		// Drilldown from subset summary or subset PDQ
		IF lb_SubsetDetails THEN
			idw_source.SetItem(ll_row,'rb_source','Subset')
			iuo_query.is_data_type = 'SUBSET'
			This.Event	ue_tabpage_source_set_data_type ('Subset',gc_active_subset_name,gc_active_subset_case)

			//	Add FastTrack type
			IF iw_parent.ib_sumbyrev THEN
				li_rc = w_main.dw_stars_rel_dict.SetFilter("")
				li_rc = w_main.dw_stars_rel_dict.Filter()
				ls_sel = "rel_type = 'DP' and id_3 = '" + iw_parent.istr_parms.ft_main_inv_type + "'"
				li_rc = w_main.dw_stars_rel_dict.SetFilter(ls_sel)
				li_rc = w_main.dw_stars_rel_dict.Filter()
				ls_ft_inv_type = w_main.dw_stars_rel_dict.GetItemString(1,'REL_ID') 
				ll_dddw_row = ldwc_data_source.Find( "stars_rel_id_2 = '" + &
					ls_ft_inv_type + "'", 0, ldwc_data_source.RowCount() )
				ls_data_source = 	ldwc_data_source.GetItemString(ll_dddw_row,'compute_0001')
				ldwc_data_source.SelectRow (ll_dddw_row, TRUE)
				idw_source.SetColumn('data_source')
				idw_source.SetText(ls_data_source)
				idw_source.AcceptText()
			ELSE
				IF iw_parent.is_subset_inv_type > "" &
				AND iuo_query.is_inv_type = gv_sys_dflt THEN
					ll_dddw_row = ldwc_data_source.Find( "stars_rel_id_2 = '" + &
							iw_parent.is_subset_inv_type + "'", 0, ldwc_data_source.RowCount() )
					ls_data_source = 	ldwc_data_source.GetItemString(ll_dddw_row,'compute_0001')
					ldwc_data_source.SelectRow (ll_dddw_row, TRUE)
					idw_source.SetColumn('data_source')
					idw_source.SetText(ls_data_source)
					idw_source.AcceptText()
				END IF
			END IF
		ELSE
			//	FDG 04/14/98 begin
			This.Event	ue_tabpage_source_set_data_type ('Base','','')	// 05/14/98 FNC
		END IF
	end if	// authorization view if
	
End If	// subset view if	
	
ll_num_rows = ldwc_data_source.RowCount()	
iuo_query.of_set_data_type(is_data_type)			//03-03-98 FNC
ib_load_data	=	FALSE				// FDG 10/23/98
Return 1
end event

event type integer ue_tabpage_source_get_source_sub_tables(string as_subset_id, ref string as_inv_type[]);/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_source_get_source_sub_tables	uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	This event will be called by u_nvo_source.ue_tabpage_source_contruct(),
// u_nvo_source.ue_tabpage_source_set_subset_data_source and 
// w_query_engine.ue_create_subset() to determine the invoice types of the source subset,
// whether it is subset view or a data type of subset.  Must select the invoice types 
// from the sub_step_cntl table where num_rows > 0.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			as_subset_id	String				The subset id.
//		reference	as_inv_type[]	String				The invoice types.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success
//						-2				transaction error.
//						-1				Data error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		---------------
//	JTM		12/08/97	Created.
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//							to prevent locking.
//	FDG		12/06/01	Track 2497, 2561.  Prevent memory leaks.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

/* must go to SUB_STEP_CNTL table to determine tables in subset to put into 
ldwc_data_source */

/* ds_inv_type = create datastore (n_ds) for invoice types
	select inv_type
	from sub_step_cntl
	where subc_id = is_source_subset_id 
	and num_rows > 0 */
n_Ds lds_inv_type

String s_Null[]
Integer li_rowcount, i

as_inv_type[] = s_Null

lds_inv_type = Create n_Ds

lds_inv_type.dataobject = "d_subset_invoice_type"

IF lds_inv_type.SetTransObject(stars2ca) <> 1 THEN
	MessageBox("Error","Could not assign transaction to obtain subset invoice type.",StopSign!)
	Destroy lds_inv_type							// FDG 12/06/01
	return -2
END IF

li_rowcount = lds_inv_type.Retrieve(as_subset_id)

If li_RowCount < 0 THEN
	MessageBox("Error","Error retrieving subset invoice type from SUB_STEP_CNTL table. " + &
	"Please contact your database administrator.",StopSign!,Ok!)
	Destroy lds_inv_type							// FDG 12/06/01
	return -1
else
	stars2ca.of_commit()							// FNC 04/14/99
End If

for i = 1 to li_rowcount
	as_inv_type[i] = lds_inv_type.object.inv_type[i]
next

Destroy lds_inv_type

RETURN 1
end event

event type integer ue_tabpage_source_set_data_type(string as_data_type, string as_subset_name, string as_case_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	UE_Tabpage_Source_Set_Data_Type		U_NVO_Source
//
//	Description
//	-----------
// If the data type is 'Subset' this event will load the active subset into subset_name
// and case_id and make visible or if the data type is base will make them invisible.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			DataType			Description
//		---------	--------			--------			-----------
//		Value			as_data_type	String			The data type.
//						as_subset_name						The subset name.
//						as_case_id							The case ID.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Sucess.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date		Description
// ------		----		-----------
//	J.Mattis		12/04/97	Created.
//	F.Chernak	12/30/97	Set is_data_type to as_data_type so that when PDQ is loaded
//								the data type instance variable is also loaded.
//	J.Mattis		02/26/98	Moved setting the visible property of subset items to datawindow
//								object.
// F.Chernak	03/11/98 Set appropriate instance variable when subset id is 
//								set.
// F.Chernak	03/19/98	Track 931.  If source is base reload the data source dddw
//								with the base invoice types.
// F.Chernak	04/07/98	Track 975 1. Blank out iuo_query.is_source_subset_id and
//								iuo_query.is_subset_id if data source is base.
//								2. If no subset id is active then datasource dddw's should
//								be empty if source is subset.
// F. Chernak	04/08/98	Track 1062 Disable the search by and report on tabs if
//								source is subset but no subset id is entered.
//	FDG			04/13/98	Track 975.  When changing from Base to subset, clear
//								out the additional data source.
//	FDG			05/11/98	Track 1178.  When setting additional data source,
//								invoke a script to reset everything.
// FNC			06/03/98	Track 1166. Pass an argument to ue_tabpage_source_set_base_
//								data_source so that the event will know if it is a new level.
//	FDG 			06/15/98	Track ????.  Don't directly access uo_query attributes.
// FNC			06/23/98	Track 1396. Set is_data_type in UO_Query. 
//	FDG			07/15/98	Track 1509.  When the data type changes (base/subset)
//								and the data source does not change, there's a
//								change that the criteria will get wiped out.  If so,
//								insert a blank row.
//	FDG			10/14/98	Track 1820.  Set is_subset_id & is_source_subset_id
//								in uo_query to keep it in sync with this NVO.
//	GaryR			03/26/03	Track 3490d	Clean up payment date logic
//	GaryR			11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR			07/07/08	Track 5452	Disable Category when no active subset
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

integer li_rc

long		ll_row

datawindowchild	ldwc_data_source,	&
						ldwc_add_data_source

is_data_type = upper(as_data_type)							//12-30-97 FNC		// FDG 06/15/98

idw_source.object.subset_name[1] = as_subset_name
idw_source.object.case_id[1] = as_case_id

if Upper (is_data_type) = 'SUBSET' then					//03-19-98 FNC 	// FDG 06/15/98
	// Data type (rb_source) = 'Subset'
	if as_subset_name <> '' then											//03-11-98 FNC Start
		li_rc = this.event ue_tabpage_source_set_subset_id( 1, as_subset_name )
		if li_rc < 0 then return -1										//03-11-98 FNC End
		idw_source.setitem(idw_source.getrow(),'add_data_source','')	//	FDG 04/13/98
		iuo_query.Event	ue_add_data_source_change('')			// FDG 05/11/98
	else
		
		//04-07-98 FNC Start
		iuo_query.of_enable_tabpage (ic_search, FALSE)				// FNC 04/08/98	// FDG 06/15/98
		iuo_query.of_enable_tabpage (ic_report, FALSE)				// FNC 04/08/98	// FDG 06/15/98
		idw_source.getchild('data_source',ldwc_data_source)
		ldwc_data_source.reset()
		idw_source.setitem(idw_source.getrow(),'data_source','')
		idw_source.getchild('add_data_source',ldwc_add_data_source)
		ldwc_add_data_source.reset()		
		idw_source.setitem(idw_source.getrow(),'add_data_source','')	//04-07-98 FNC End
		iuo_query.Event	ue_add_data_source_change('')			// FDG 05/11/98
		This.event ue_tabpage_source_enable_cat( FALSE, "")
	end if
else																		 		//03-19-98 FNC Start
	// Data type (rb_source) = 'Base'
	is_source_subset_id = '' 									//04-07-98 FNC		// FDG 06/15/98
	is_subset_id = ''												//04-07-98 FNC		// FDG 06/15/98
	li_rc = this.event UE_Tabpage_Source_Set_Base_Data_Source(FALSE)	// FNC 06/03/98 
end if																			//03-19-98 FNC End

iuo_query.of_set_data_type(is_data_type)			// FNC 06/23/98

// FDG 07/15/98 begin

ll_row	=	idw_criteria.RowCount()

IF	ll_row	=	0		THEN
	ll_row	=	idw_criteria.InsertRow(0)
	idw_criteria.ScrollToRow (ll_row)
END IF
	
// FDG 07/15/98 end

// FDG 10/14/98 begin
iuo_query.of_set_source_subset_id (is_source_subset_id)
iuo_query.of_set_subset_id (is_subset_id)
// FDG 10/14/98 end

RETURN 1
end event

event type integer ue_tabpage_source_load(integer ai_level_num);///////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_source_load							uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_load_query 
//	when a pre-defined query is loaded.
// It will take the information out of dw_pdq_tables 
//	(per level_num) and load it into this 
// tabpage.  When the datawindow is loaded it should 
//	trigger the itemchanged event which 
// will prepare the next tabs to be loaded.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype			Description
//		---------	--------			--------			-----------
//		Value			ai_level_num	Integer			The level.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
//						-1				no data
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/05/97	Created.
//	J.Mattis	01/22/98	Added call to set the report title.	
//	FDG		01/27/98	Changed variable i to li_idx
//	J.Mattis	01/27/98	Moved rowcount of additional data source inside loop 
//							to prevent dependent column error.
//	J.Mattis	02/05/98	Added method of_SetStatus() to change the row status to 
//							notmodified on initial load. This will prevent closequery 
//							error. 
//	FDG		03/03/98	Track 880.  After disabling tabs, see if the Next
//							button is to be disabled.
//	FDG		03/20/98	Track 948.  Fix a bug from track 107.  Do not trigger
//							ue_tabpage_source_set_data_type because it reloads
//							the DDDW for data_source (which in turn, could change
//							the invoice type).
//	FDG		03/24/98	Track	929.  Reset idw_source by triggering event
//							ue_tabpage_source_construct.
//	FDG		04/14/98	Track 975, 1063.  Set a boolean stating that a PDQ is being
//							loaded.  This will prevent the data source from being
//							set to the default invoice type.
//	FDG		05/07/98	Track 1207.  Set a flag stating if the data source is
//							an ancillary data source (i.e. EN, PV).
//	FDG 		06/15/98	Track ????.  Don't directly access uo_query attributes.
//	NLG		10/20/99	ts2463c. Fraud PDQ library enhancements. Set payment date
//							options description for ddlb_pd_opt
//	FDG		07/17/00	Track 2465c.  Stars 4.5 SP1.  Load Fastquery data.
// FNC		10/25/01	Track 3683 Starcare. Make period and payment date options ddlb's
//							invisible when the source of the query is a subset.
//	GaryR		04/08/03	Track 3251d	ItemChanged event not triggering with AcceptText
//	GaryR		12/20/07	SPR 5199	Add the facility to categorize and sort data sources
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//  Katie 01/05/08	SPR 5616 Accomidate larger source categories 
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

datawindowchild ldwc_data_source, ldwc_add_data_source

Integer li_rowcount, li_idx, li_current_row, li_find_return, li_rc
Integer li_rowcount_ldwc_data_source, li_rowcount_ldwc_add_data_source
Integer li_dddw_row

string ls_table_typestring, ls_table_type, ls_data_source, ls_add_data_source
string ls_query_type,ls_added_type
string ls_pd_opt_desc 
string ls_fastquery_ind

Boolean	lb_base

Long		ll_fastquery_rows
DWObject	ldwo_object

ib_load_data	=	TRUE					// FDG 04/14/98

li_rc	=	This.Event	ue_tabpage_source_construct ('INITIAL_LEVEL', '')		// FDG 03/24/98

//FNC 10/25/01 Start
if trim(idw_pdq_tables.object.src_type[1] ) = 'SS' then		
	iuo_query.of_set_data_type('SUBSET')
	this.Event ue_tabpage_source_set_data_type('SUBSET', &
	idw_pdq_tables.object.src_subset_name[1],idw_pdq_tables.object.src_case_id[1] + &
		idw_pdq_tables.object.src_case_spl[1] + idw_pdq_tables.object.src_case_ver[1])
	idw_source.object.rb_source[1] = 'Subset'
	lb_base = FALSE
else
	//this.Event ue_tabpage_source_set_data_type('BASE','','')	// FDG 03/20/98
	idw_source.object.rb_source[1] = 'Base'
	lb_base = TRUE
end if
//FNC 10/25/01 End

idw_source.getchild('data_source',ldwc_data_source)
idw_source.getchild('add_data_source',ldwc_add_data_source)

If Not(IsValid(ldwc_data_source)) Then RETURN -2
If Not(IsValid(ldwc_add_data_source)) Then RETURN -3

iw_parent.wf_SetLevelfilter(ai_level_num,'SOURCE')

li_rowcount = idw_pdq_tables.rowcount()

if li_rowcount < 1 then
	//error
	ib_load_data	=	FALSE					// FDG 04/14/98
	return -1
end if
	li_rowcount_ldwc_data_source = ldwc_data_source.rowcount() 
for li_idx = 1 to li_rowcount
	// MUST obtain rowcount of additional data source dwc in loop since itemchanged 
	//	of dw_source is the event in which the additional data source dwc is populated, and
	//	since the itemchanged event is triggered via the AcceptText() below.
	li_rowcount_ldwc_add_data_source = ldwc_add_data_source.rowcount()	
	If IsValid(iuo_query) Then													
		iuo_query.of_SetReportTitle(idw_pdq_tables.object.rpt_title[li_idx])
		//NLG 11-23-99 Move this below
		//NLG 10-20-99 Load the payment date options ddlb
		//ls_pd_opt_desc = idw_pdq_tables.object.payment_date_options[li_idx]
		//iuo_query.of_set_pd_opt_desc(ls_pd_opt_desc)
		// FDG 07/17/00 begin
		ll_fastquery_rows	=	idw_pdq_tables.object.fastquery_rows[li_idx]
		ls_fastquery_ind	=	Upper (idw_pdq_tables.object.fastquery_ind[li_idx])
		iuo_query.of_set_fastquery_ind (ls_fastquery_ind)
		iuo_query.of_set_fastquery_rows (ll_fastquery_rows)
		IF	 ls_fastquery_ind		=	'Y'		&
		AND ll_fastquery_rows	>	0			THEN
			iuo_query.of_SetDWLimit (ll_fastquery_rows)
			iuo_query.Event	ue_edit_enable_fastquery()
		END IF
		// FDG 07/17/00 end
	End If													
	// check if main data source table
	if idw_pdq_tables.object.tbl_rel[li_idx] = 'GP' then
		
		//NLG 11-23-99 moved this from above.  Only get the description
		//					if it's not a dependent table.  Will populate the listbox
		//					after the For loop b/c idw_criteria.acceptText resets the listbox.
		If IsValid(iuo_query) Then													
			//NLG 10-20-99 Load the payment date options ddlb
			ls_pd_opt_desc = idw_pdq_tables.object.payment_date_options[li_idx]
		End If
		
		ls_table_type = idw_pdq_tables.object.tbl_type[li_idx]
		
		//	Filter the Category
		IF lb_base THEN
			IF This.event ue_tabpage_source_enable_cat( TRUE, ls_table_type ) < 0 THEN Return -1
		END IF

		li_rowcount_ldwc_data_source = ldwc_data_source.rowcount() 

	
		li_find_return = ldwc_data_source.Find(" stars_rel_id_2 = '" + &
								ls_table_type + "'",1,li_rowcount_ldwc_data_source)
		If li_find_return > 0 Then
			// The following code is used to trigger the itemchanged event 
			//	of dw_source. The itemchanged event is CRITICAL for the query 
			//	load process to complete successfully!
			// NOTE: the main data source row MUST BE PRIOR to the dependent data source 
			//	row (if any) OR the query load will fail!
			ls_data_source = ldwc_data_source.GetItemString(li_find_return,'compute_0001')
			idw_source.SetItem( 1, "data_source", ls_data_source )
			ldwo_object = idw_source.object.data_source
			idw_source.Event ItemChanged( 1, ldwo_object, ls_data_source )
			ldwc_data_source.ScrollToRow(li_find_return)
		Else
			MessageBox('Error','Table type not found in Dictionary')
			ib_load_data	=	FALSE					// FDG 04/14/98
			Return -1
		End If
	else
		// data source is dependent table
		//01-13-98 FNC Start
		//ldwc_add_data_source.selectrow(idw_pdq_tables.object.tbl_type[i],TRUE)	
		ls_table_type = idw_pdq_tables.object.tbl_type[li_idx]
		li_find_return = ldwc_add_data_source.&
			Find(" stars_rel_id_2 = '" + ls_table_type + "'",&
				1,li_rowcount_ldwc_add_data_source)
		If li_find_return > 0 Then
			// The following code is used to trigger the itemchanged event 
			//	of dw_source. The itemchanged event is CRITICAL for the query 
			//	load process to complete successfully!
			// NOTE: the main data source row MUST BE PRIOR to the dependent data source 
			//	row (if any) OR the query load will fail!
		 	ls_add_data_source = ldwc_add_data_source.GetItemString(li_find_return,'compute_0001')
			idw_source.SetItem( 1, "add_data_source", ls_add_data_source )
			ldwo_object = idw_source.object.add_data_source
			idw_source.Event ItemChanged( 1, ldwo_object, ls_add_data_source )
			ldwc_add_data_source.ScrollToRow(li_find_return)
		Else
			MessageBox('Error','Dependent table type not found in Dictionary')
			ib_load_data	=	FALSE					// FDG 04/14/98
			Return -1
		End If
	end if
next

iuo_query.of_enable_tabpage (ic_source, TRUE)	//john_wo 1/2/98		// FDG 06/15/98
iuo_query.Event	ue_SelectTab(0)			// FDG 03/03/98

iw_parent.wf_SetLevelfilter(0,'SOURCE')

// change the row status to New!
this.uf_SetStatus(idw_source,NotModified!)

iuo_query.Event	ue_set_ancillary_inv_type (ls_data_source)		// FDG 05/07/98

ib_load_data	=	FALSE					// FDG 04/14/98

//NLG 11-23-99 moved this from above
If IsValid(iuo_query) Then
	iuo_query.of_set_pd_opt_desc(ls_pd_opt_desc)
End If
//NLG END

Return 1
end event

event type integer ue_tabpage_source_load_additional_data(string as_inv_type, string as_subset_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_source_load_additional_data		uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//If not subset view this event will load the Additional Data Source 
//datawindow with the dependent invoice types based on the invoice 
//type passed in.  If subset view, then must only load the dependents 
//in the subset.  If ib_drilldown is set (this is a drilldown uo_query) 
//then must add the selected invoice type to the additional drop down.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		as_inv_type	- Invoice type
//		as_subset_id - Subset ID
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
//						-1				no datawindowchild 
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/05/97	Created.
//
//	FDG		1/26/98	If # of rows retrieved is 0, set it to null
//							and protect it.
//	J.Mattis	01/27/98	Commented setting of the add. data source in idw_source
//							to the 1st row's value to prevent column error 
//							on report tabpage.
//	FDG		02/26/98	Remove ib_drilldown logic - Its not needed here.		
//
// FNC		03/18/98	Track 931.  Set ll_curr_row to 1 if it is 0. For some reason 
//							when this event is triggered from ue_tabpage_source_set_subset_
//							data_source the current row is 1 but it comes up as 0.
//	FNC		03/19/98	1. Track 946.  Use value returned from 
//							n_cst_string.globalreplace
//							2. Correct the where clause to select the dependent
//							tables when a subset id is specified.
//							3. Put quotes around each dependent in the "in clause". Quotes
//							were being put at the beginning and end of the all the tables.
//	FDG		04/21/98	Track 1099.  When additional data is loaded, add a "blank"
//							row.  This will enable the user to undo a previously
//							selected additional data source.
//	FDG		05/01/98	Track 1163.  Insert the additional row even if a
//							subset data type is used.
// AJS      01-12-99 FS1711d 4.1 Disable RMM claim detail when no additional invoice
//	FDG		01/26/99	Track 2078c.  When inserting a 'blank row' in additional
//							data source, do it to ldwc_add_data.
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//							to prevent locking.
//	GaryR		12/21/07	SPR 5234	Add descriptions to selected data sources
//	GaryR		07/07/08	Track 5452	Disable Category when no active subset
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
Constant String LS_SINGLEQUOTE = "'"
Constant String LS_DELIMITER = ","
Constant String LS_SUBDELIMITER = "+"	// the SUB_STEP_CNTL.DEP_TBLS delimiter 

Long			ll_curr_row,	&
				ll_find_row,	&
				ll_rows,			&
				ll_pos,			&
				ll_start_pos,	&
				ll_ldwc_row
Integer		li_rc,			&
				li_Index,		&
				li_DependentTableCount
String		ls_null,			&
				ls_add_source,	&
				ls_dep_tbls,	&
				ls_Rel,			&
				ls_sql,			&
				ls_replace_tbl_type,	&
				ls_rel_part1,	&
				ls_rel_part2,	&
				ls_comma,		&
				ls_tbl_type

n_ds lds_DependentTables
datawindowchild ldwc_add_data

ll_curr_row	=	idw_source.GetRow()

if ll_curr_row = 0 then		//03-18-98 FNC Start
	ll_curr_row = 1
end if							//03-18-98 FNC End
	
SetNull (ls_null)

idw_source.getchild('add_data_source',ldwc_add_data)

if Not IsValid(ldwc_add_data) then
	// additional data source DDDW is invalid - Get out
	Return -1
end if

if Trim(as_subset_id) <> '' then 
	// create datastore (n_ds) to get dependent tbl_types 
	
	lds_DependentTables = Create n_Ds
	lds_DependentTables.DataObject = "d_source_load_addtl_data"
	lds_DependentTables.SetTransObject(Stars2ca)
	li_DependentTableCount = lds_DependentTables.Retrieve(as_subset_id,as_inv_type)
	
	/* loop thru ls_dep_tbls and pull out table types and put into a 
	string with single quotes around the table type and delimited by 
	commas to use in an in statement */
			
	FOR li_Index=1 TO li_DependentTableCount
		// get the table type
		ls_tbl_type = Trim( lds_DependentTables.GetItemString(li_Index,1) )
		
		If Not(IsNull(ls_tbl_type)) AND ls_tbl_type <> '' Then
			n_cst_string n_String
			//translate the SUB_STEP_CNTL delimiter to commas for IN clause
			//03-18-98 FNC Start
			ls_replace_tbl_type = n_String.of_GlobalReplace &
										(ls_tbl_type,LS_SUBDELIMITER,LS_DELIMITER)
			ls_Rel = LS_DELIMITER + ls_Rel + LS_SINGLEQUOTE + ls_replace_tbl_type + &
						+ LS_SINGLEQUOTE 
			/*Set ll_start_pos to 2 because want to skip the first quote */
			ll_start_pos = 2
			ll_pos = pos(ls_rel,',',ll_start_pos)
			do while ll_pos > 0 
				ls_rel_part1 = left(ls_rel,(ll_pos - 1))
				ls_comma = mid(ls_rel,ll_pos,1)
				ls_rel_part2 = mid(ls_rel,(ll_pos + 1))
				ls_rel = ls_rel_part1 + LS_SINGLEQUOTE + ls_comma + LS_SINGLEQUOTE + ls_rel_part2
				ll_start_pos = ll_pos + 2
				ll_pos = pos(ls_rel,',', ll_start_pos)					
			loop
			
			
			//03-18-98 FNC End
		End If
		
	NEXT
	
	If Trim(ls_Rel) <> '' Then
		// remove first comma
		ls_Rel = Mid(ls_Rel,2)
		//03-19-98 FNC Start
		ls_rel = "and sr.rel_id = '" + as_inv_type + "'" + &
					"and sr.id_2 in (" + ls_rel + ")"
		//03-19-98 FNC End
	End If
		
	Destroy lds_DependentTables
	
else
	
	// non subset view query
	ls_rel = "and sr.rel_id = '" + as_inv_type + "'"
	
end if

IF Trim(ls_rel) <> '' THEN
	ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_desc, sr.rel_id " + & 
				"from stars_rel sr, dictionary dt " + &
				"where sr.id_2 = dt.elem_tbl_type " + &
				"and sr.rel_type = 'DP' " + &
				"and dt.elem_type = 'TB' " +	Upper( ls_rel )
			
	ldwc_add_data.setsqlselect(ls_sql)
	ldwc_add_data.SetTransObject(Stars2ca)
	ll_rows = ldwc_add_data.retrieve()
END IF

//	FDG 1/26/98 begin

// Reset additional data source
iuo_query.of_set_add_inv_type('')

IF	ll_rows	<	1		THEN
	// No rows found
	idw_source.object.add_data_source [ll_curr_row]	=	ls_null
	idw_source.object.add_data_source.protect	=	1
	iw_parent.event ue_set_menus_dependent_info_menu(False)	 // AJS 01-12-99
ELSE
	// Rows found - Hilite the 1st row & set the data in idw_source
	//	to the 1st row's value.
	// FDG 04/21/98 begin
	IF	as_inv_type				>	' '		THEN				// FDG 05/01/98
		// Insert a blank row at the beginning
		ll_ldwc_row		=	ldwc_add_data.InsertRow (1)
		idw_source.object.add_data_source [ll_curr_row]	=	' '			// FDG 01/26/99
	END IF
	// FDG 04/21/98 end
	idw_source.object.add_data_source.protect	=	0	
	iw_parent.event ue_set_menus_dependent_info_menu(True)	 // AJS 01-12-99
END IF
//	FDG	1/26/98 end

stars2ca.of_commit()										// FNC 04/14/99

Return 1
end event

event ue_tabpage_source_determine_source_type();/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_source_determine_source_type	uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will get the source type from the data source selected.  It will also set 
// the data type group box to be visible if claims or invisible if the other.  This is 
// called in the itemchanged event of dw_source.  The possible source types are:
// C		= single claim types
// FT		= FastTrack
// MC		= Common
// ML		= Multi-Level
// AN		= Ancillary
// The source type will be checked by multiple areas in the Query Engine.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		NONE.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		NONE.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/05/97		Created.
//	FDG		04/14/98		Track 975, 1063.  There is no need to set the data
//								type (rb_source) for ancillary data ('AN').  It has
//								been already set.
//	FDG 		06/15/98		Track ????.  Don't directly access uo_query attributes.
// HYL 		01/12/06 	Track 4613d	rb_source needs to be visible
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

datawindowchild ldwc_source
String ls_tbl_type, ls_rel_type

idw_source.getchild('data_source',ldwc_source)

if IsValid(ldwc_source) then
	
	ls_tbl_type = Upper(Trim(ldwc_source.getitemstring(ldwc_source.getrow(),"stars_rel_id_2")))
	
	if ls_tbl_type = "MC" then
		is_source_type = "MC"				// FDG 06/15/98
	elseif ls_tbl_type = "ML" then
		is_source_type = "ML"				// FDG 06/15/98
	elseif left(ls_tbl_type,1) = 'Q' then
		is_source_type = "FT"				// FDG 06/15/98
	else  /* not one of the easy ones */
		ls_rel_type = Upper(trim(ldwc_source.getitemstring(ldwc_source.getrow(),"stars_rel_rel_type")))
		if ls_rel_type = "GP" or ls_rel_type = "QT" then
			is_source_type = "C"				// FDG 06/15/98
		else
			is_source_type = "AN"			// FDG 06/15/98
		end if
	end if
	
	idw_source.modify('rb_source.visible = 1')
end if
end event

event type integer ue_tabpage_source_match_type_and_source();/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object							
//	--------------										------							
// ue_tabpage_source_match_type_and_source	uo_Query	
//
//	Description
//	-----------
// This event will be called by the losefocus event of dw_source if the data type is SUBSET.
// This event will determine if the data type matches the data source.  This info is needed
// in ue_create_sql to determine whether to query against base or subset tables.  If  there
// is a match will use the subset tables and if not will use the base tables.  First it must
// get the invoice type(s) of the source subset and then compare it to the data source.  
// Also, must check for the exception.  If data source is MC, can only have MC subset as 
// data type.  If MC and no MC subset return -1, else return 0.  For future reference 
// if match set is_data_type = "SUBSET" else "BASE".
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		DataType		Description
//		---------	--------		--------		-----------
//		NONE.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Success.
//						-1				Error, MC and no MC subset.
//						-2				Transaction error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/04/97		Created.
//	J.Mattis	12/08/97		Added datastore logic to assign datawindow, set trans. object, 
//								error	check, and retrieve.
//	FDG 		06/15/98		Track ????.  Don't directly access uo_query attributes.
// FNC		06/23/98		Track 1396. Set is_data_type in UO_Query. 
// FNC		04/14/99		FS/TS2162 Starcare track 2162. Add commits after executing 
//								SQL to prevent locking.
//	FDG		12/06/01		Track 2497, 2561.  Prevent memory leaks.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

n_Ds lds_subset

lds_subset = Create n_Ds

sx_subset_ids lsx_subset_ids /* defined in ts145 - sx_subset_id */

lsx_subset_ids.subset_name = idw_source.object.subset_name[1]
lsx_subset_ids.subset_case_id = left(idw_source.object.case_id[1],10)
lsx_subset_ids.subset_case_spl = mid(idw_source.object.case_id[1],11,12)
lsx_subset_ids.subset_case_ver = mid(idw_source.object.case_id[1],13,14)
//iuo_Query.invo_subset_functions.uf_set_structure(lsx_subset_ids)
//is_source_subset_id = iuo_Query.invo_subset_functions.uf_retrieve_subset_id()

if idw_source.object.data_source[1] = "MC" then
	/* ds_inv_type = create datastore (n_ds)for table type
		select subc_sub_tbl_type
		from sub_cntl
		where subc_id = is_source_subset_id */
	lds_subset.dataobject = "d_subset_table_type"
	
	IF lds_subset.SetTransObject(stars2ca) <> 1 THEN
		MessageBox("Error","Could not assign transaction to obtain subset table type(s).")
		Destroy lds_subset							// FDG 12/06/01
		return -2
	END IF
	
	If lds_subset.Retrieve(is_source_subset_id) > 0 THEN			// FDG 06/15/98
		stars2ca.of_commit()													// FNC 04/14/99
		if lds_subset.object.subc_sub_tbl_type[1] = "MC" then
			is_data_type = "SUBSET"				// FDG 06/15/98
			iuo_query.of_set_data_type(is_data_type)			// FNC 06/23/98
			Destroy lds_subset							// FDG 12/06/01
			return 0
		else
			is_data_type = "BASE"											// FDG 06/15/98
			iuo_query.of_set_data_type(is_data_type)			// FNC 06/23/98
			messagebox("Error", "Data Source of MC must use MC subset.")
			Destroy lds_subset							// FDG 12/06/01
			return -1
		end if
		
	End If
	
else
	/* ds_inv_type = create datastore (n_ds) for invoice types
	select inv_type
	from sub_step_cntl
	where subc_id = is_source_subset_id 
	and num_rows > 0 */
	lds_subset.dataobject = "d_subset_invoice_type"
	
	IF lds_subset.SetTransObject(stars2ca) <> 1 THEN
		MessageBox("Error","Could not assign transaction to obtain subset invoice type.")
		Destroy lds_subset							// FDG 12/06/01
		return -2
	END IF
	
	Integer li_rowcount, i
	
	li_rowcount = lds_subset.Retrieve(is_source_subset_id)	// FDG 06/15/98
	if li_rowcount > 0 then												// FNC 04/14/99
		stars2ca.of_commit()												// FNC 04/14/99
		for i = 1 to li_rowcount
			if idw_source.object.data_source[1] = &
				lds_subset.object.inv_type[i] then
				is_data_type = "SUBSET"									// FDG 06/15/98
				iuo_query.of_set_data_type(is_data_type)			// FNC 06/23/98
				Destroy lds_subset							// FDG 12/06/01
				return 0
			end if															
		next
	end if																	// FNC 04/14/99
end if

is_data_type = "BASE"													// FDG 06/15/98

iuo_query.of_set_data_type(is_data_type)			// FNC 06/23/98

IF IsValid(lds_subset)	THEN	Destroy lds_subset				// FDG 12/06/01

return 0
end event

event ue_tabpage_source_get_inv_type;call super::ue_tabpage_source_get_inv_type;/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_source_get_inv_type				uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by w_query_engine.ue_query_save() to get the selected
// invoice type for the query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value								Description
//		--------		-----								-----------
//		String		iuo_Query.is_inv_type		The invoice type from uo_Query.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/08/97		Created.
//	FDG 		06/15/98		Track ????.  Don't directly access uo_query attributes.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

return is_inv_type			// FDG 06/15/98
end event

event type integer ue_tabpage_source_get_both_data_sources(ref string as_inv_types[]);/////////////////////////////////////////////////////////////////////////////
// Event/Function										Object				
//	--------------										------				
//	ue_tabpage_source_get_both_data_sources	uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	This event will be called by w_query_engine.ue_open_filter_window() to get the selected 
// data sources to pass to the filter create window so it can list the columns to create 
// filters on.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Reference	as_inv_types[]	String				The invoice types.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success			
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/08/97		Created.
//	FDG 		06/15/98		Track ????.  Don't directly access uo_query attributes.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

as_inv_types[1] = is_inv_type						// FDG 06/15/98
as_inv_types[2] = left(idw_source.object.add_data_source[1],2)

return 1
end event

event type integer ue_tabpage_source_save(integer ai_level, string as_query_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function					Object				
//	--------------					------				
//	ue_tabpage_source_save		uo_query
//
//	Description
//	-----------
//	This event will be called by w_query_engine.ue_query_save() to load the pdq_tables 
//	datawidows with data from the tabpage.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			DataType			Description
//		---------	--------			--------			-----------
//		Value			ai_level			Integer			The query level.
//						as_query_id		String			The query ID.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Sucess.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/04/97	Created.
//	J.Mattis	01/21/98	Added guard against inserting into an update datawindows to
//							prevent SQL insert duplicate key errors.
//	J.Mattis	01/23/98	Added code to save the report title(s).
//	FDG		04/01/98	Track 996.  Column name is subset_name (not subset_id).
//	FDG 		06/15/98	Track ????.  Don't directly access uo_query attributes.
//	NLG		11/15/99	Ts2463c Fraud PDQ changes. Save payment date options desc
//	FDG		07/17/00	Track 2565c.  Stars 4.5 SP1.  Save fastquery data.
//	GaryR		01/15/01	Stars 4.7 DataBase Port - Empty String in SQL
//	GaryR		06/13/01	Track 3470c	Inserting NULL into PDQ_TABLES when saving 
//											PDQ with additional data source
//	FDG		01/17/02	Track 2703d The 2nd parm for Mid() should return the length,
//							not the last position (i.e. Mid(case_id,11,2) instead of Mid(case_id,11,12))
//	GaryR		04/29/02	Track 2552d	Predefined Report (PDR)
//	GaryR		10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR		12/11/04	Track 4108d	Dynamic Report Options
// GaryR		12/28/04	Track 4196d	Reset update flag on save
// HYLee		01/05/06 TRACK 4592d Trim() function added for ls_add_data
//	GaryR		03/24/06	Track 4522	Trim case NONE to reflect renamed Subsets in PDQs
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String	ls_add_data,			&
			ls_ReportTitle,		&
			ls_fastquery_ind

//	GaryR		01/15/01	Stars 4.7 DataBase Port
String	ls_src_case_id,		&
			ls_src_case_spl,		&
			ls_src_case_ver,		&
			ls_subset_name,		&
			ls_empty,				&
			ls_payment_date_options

//	GaryR	04/29/02	Track 2552d - Begin
String	ls_pdr_report, &
			ls_desc, &
			ls_client_name, &
			ls_cust_stmt,	&
			ls_sub_title1, &
			ls_sub_title2, &
			ls_sub_title3, &
			ls_sub_title4
			
DatawindowChild	ldwc_pdr_report
//	GaryR	04/29/02	Track 2552d - End			

Long		ll_row,					&
			ll_findrow,				&
			ll_fastquery_rows

Integer	li_rc, li_rpt_opt
sx_dw_format	lsx_report_options

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

iw_parent.wf_SetLevelfilter(ai_level,'SOURCE')

ll_findrow = idw_pdq_tables.Find("tbl_rel = 'GP'",1,idw_pdq_tables.RowCount())

IF ll_findrow = 0 Then															// JTM - 1/21/98
	ll_row = idw_pdq_tables.insertrow(0)
ELSE
	ll_row = ll_findrow
END IF

// FDG 07/17/00 - Get fastquery data.
ls_fastquery_ind	=	idw_fastquery.object.fastquery_ind [1]
ll_fastquery_rows	=	idw_fastquery.object.fastquery_rows [1]
//	GaryR		01/15/01	Stars 4.7
li_rc	=	gnv_sql.of_TrimData (ls_fastquery_ind)

// save the main data source
idw_pdq_tables.object.query_id[ll_row] = as_query_id
idw_pdq_tables.object.level_num[ll_row] = ai_level
idw_pdq_tables.object.tbl_type[ll_row] = is_inv_type				// FDG 06/15/98
idw_pdq_tables.object.tbl_rel[ll_row] = 'GP'

// FDG 07/17/00 - Save the fastquery data
idw_pdq_tables.object.fastquery_ind [ll_row]		=	ls_fastquery_ind
idw_pdq_tables.object.fastquery_rows [ll_row]	=	ll_fastquery_rows

//	GaryR	04/29/02	Track 2552d - Begin
//	Save PDR specific fields
IF iw_parent.of_is_pdr_mode() THEN
	idw_pdr.GetChild( "pdr_report", ldwc_pdr_report )
	li_rc = ldwc_pdr_report.GetSelectedRow(0)
	IF li_rc > 0 THEN
		ls_pdr_report = ldwc_pdr_report.GetItemString( li_rc, "pdr_name" )
	END IF
	
	IF iuo_report_options.of_get( lsx_report_options ) < 0 THEN Return -1
	ls_ReportTitle = lsx_report_options.title
	ls_sub_title1 = lsx_report_options.subtitle1
	ls_sub_title2 = lsx_report_options.subtitle2
	ls_sub_title3 = lsx_report_options.subtitle3
	ls_sub_title4 = lsx_report_options.subtitle4
	ls_desc = lsx_report_options.description
	ls_client_name = lsx_report_options.client_code
	ls_cust_stmt = lsx_report_options.stmt_code
	li_rpt_opt = lsx_report_options.report_options
	
	//	Reset update flag
	iuo_report_options.of_resetupdates()
ELSE
	ls_ReportTitle = iuo_query.of_GetReportTitle()
END IF

// Report title is stored in PDQ_TABLES.
//	GaryR		01/15/01	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( ls_ReportTitle )  = "" THEN ls_ReportTitle = ls_empty
IF Trim( ls_sub_title1 )  = "" THEN ls_sub_title1 = ls_empty
IF Trim( ls_sub_title2 )  = "" THEN ls_sub_title2 = ls_empty
IF Trim( ls_sub_title3 )  = "" THEN ls_sub_title3 = ls_empty
IF Trim( ls_sub_title4 )  = "" THEN ls_sub_title4 = ls_empty
IF Trim( ls_pdr_report )  = "" THEN ls_pdr_report = ls_empty
IF Trim( ls_desc )  = "" THEN ls_desc = ls_empty
IF Trim( ls_client_name )  = "" THEN ls_client_name = ls_empty
IF Trim( ls_cust_stmt )  = "" THEN ls_cust_stmt = ls_empty

idw_pdq_tables.object.rpt_title[ll_row] = ls_ReportTitle
idw_pdq_tables.object.sub_title1[ll_row] = ls_sub_title1
idw_pdq_tables.object.sub_title2[ll_row] = ls_sub_title2
idw_pdq_tables.object.sub_title3[ll_row] = ls_sub_title3
idw_pdq_tables.object.sub_title4[ll_row] = ls_sub_title4
idw_pdq_tables.object.predefined_report[ll_row] = ls_pdr_report
idw_pdq_tables.object.rpt_desc[ll_row] = ls_desc
idw_pdq_tables.object.client_name[ll_row] = ls_client_name
idw_pdq_tables.object.custom_statement[ll_row] = ls_cust_stmt
idw_pdq_tables.object.report_options[ll_row] = li_rpt_opt
//	GaryR	04/29/02	Track 2552d - End

//NLG 11-15-99 Save the description from the payment date options ddlb
ls_payment_date_options = iuo_query.of_get_pd_opt_desc()
li_rc	=	gnv_sql.of_TrimData (ls_payment_date_options)
idw_pdq_tables.object.payment_date_options[ll_row] = ls_payment_date_options

if is_data_type = 'SUBSET' then											// FDG 06/15/98		
	//	GaryR		01/15/01	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
	ls_src_case_id = left(idw_source.object.case_id[1],10)
	ls_src_case_spl = mid(idw_source.object.case_id[1],11,2)	// FDG 01/17/02
	ls_src_case_ver = mid(idw_source.object.case_id[1],13,2)	// FDG 01/17/02
	ls_subset_name = idw_source.object.subset_name[1]			// FDG 4/1/98
	
	gnv_sql.of_trimdata( ls_src_case_id	)
	gnv_sql.of_trimdata( ls_subset_name	)
	IF Trim( ls_src_case_spl )	= "" THEN ls_src_case_spl	= ls_empty
	IF Trim( ls_src_case_ver )	= "" THEN ls_src_case_ver	= ls_empty
	
	
	idw_pdq_tables.object.src_type[ll_row] = 'SS'
	idw_pdq_tables.object.src_case_id[ll_row] = ls_src_case_id
	idw_pdq_tables.object.src_case_spl[ll_row] = ls_src_case_spl
	idw_pdq_tables.object.src_case_ver[ll_row] =	ls_src_case_ver
	idw_pdq_tables.object.src_subset_name[ll_row] = ls_subset_name
	//	GaryR		01/15/01	Stars 4.7 DataBase Port - End
else
	idw_pdq_tables.object.src_type[ll_row] = 'SB'
end if

//	GaryR	04/29/02	Track 2552d - Begin
IF iw_parent.of_is_pdr_mode() THEN
	ls_add_data = ""
ELSE
	ls_add_data = left(idw_source.object.add_data_source[1],2)
END IF
//	GaryR	04/29/02	Track 2552d - End

if Trim(ls_add_data) <> '' then  /* if additional data selected */  /* HYL 1/5/06; added Trim() function; TRACK 4592d */
	//check if additional data source already saved				//JTM - 1/21/98
	
	ll_findrow = idw_pdq_tables.Find("tbl_rel = 'DP'",1,idw_pdq_tables.RowCount())
	
	IF ll_findrow = 0 THEN			
		ll_row = idw_pdq_tables.insertrow(ll_row)
	ELSE
		ll_Row = ll_findrow
	END IF																	//end JTM - 1/21/98
	
	//save the additional (dependent) data source
	idw_pdq_tables.object.query_id[ll_row] = as_query_id
	idw_pdq_tables.object.level_num[ll_row] = ai_level
	idw_pdq_tables.object.tbl_type[ll_row] = ls_add_data
	idw_pdq_tables.object.tbl_rel[ll_row] = 'DP'
	// Report title is stored in PDQ_TABLES.
	idw_pdq_tables.object.rpt_title[ll_row] = ls_ReportTitle	
	
	//	GaryR		06/13/01	Track 3470c - Begin
	idw_pdq_tables.object.fastquery_ind [ll_row]			=	ls_fastquery_ind
	idw_pdq_tables.object.fastquery_rows [ll_row]		=	ll_fastquery_rows
	idw_pdq_tables.object.payment_date_options[ll_row] = ls_payment_date_options
	//	GaryR		06/13/01	Track 3470c - End	
	
	//	GaryR		04/29/02	Track 2552d - Begin
	idw_pdq_tables.object.predefined_report[ll_row] = ls_pdr_report
	idw_pdq_tables.object.rpt_desc[ll_row] = ls_desc
	idw_pdq_tables.object.client_name[ll_row] = ls_client_name
	idw_pdq_tables.object.custom_statement[ll_row] = ls_cust_stmt
	//	GaryR		04/29/02	Track 2552d - End
	
	if is_data_type = 'SUBSET' then 									// FDG 06/15/98
		//	GaryR		01/15/01	Stars 4.7 DataBase Port - Begin	// FDG 04/16/01
		ls_src_case_id = left(idw_source.object.case_id[1],10)
		ls_src_case_spl = mid(idw_source.object.case_id[1],11,2)	// FDG 01/17/02
		ls_src_case_ver = mid(idw_source.object.case_id[1],13,2)	// FDG 01/17/02
		ls_subset_name = idw_source.object.subset_name[1]			// FDG 4/1/98
		
		gnv_sql.of_trimdata( ls_src_case_id	)
		gnv_sql.of_trimdata( ls_subset_name	)
		IF Trim( ls_src_case_spl )	= "" THEN ls_src_case_spl	= ls_empty
		IF Trim( ls_src_case_ver )	= "" THEN ls_src_case_ver	= ls_empty
				
		idw_pdq_tables.object.src_type[ll_row] = 'SS'
		idw_pdq_tables.object.src_case_id[ll_row] = ls_src_case_id
		idw_pdq_tables.object.src_case_spl[ll_row] = ls_src_case_spl
		idw_pdq_tables.object.src_case_ver[ll_row] =	ls_src_case_ver
		idw_pdq_tables.object.src_subset_name[ll_row] = ls_subset_name
		//	GaryR		01/15/01	Stars 4.7 DataBase Port - End	
	else
		idw_pdq_tables.object.src_type[ll_row] = 'SB'
	end if
	
else
	//make sure any previous save did not have an additional data source
	ll_findrow = idw_pdq_tables.Find("tbl_rel = 'DP'",1,idw_pdq_tables.RowCount())
	If ll_findRow > 0 Then 
		idw_pdq_tables.DeleteRow(ll_FindRow)
	End If
end If
iw_parent.wf_SetLevelfilter(0,'SOURCE')

RETURN 1
end event

event type integer ue_tabpage_source_clear(string as_path);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_tabpage_source_clear					uo_query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by dw_source.itemchanged event and im_source.m_clear to clear 
// the tabpage and disable the rest of the tabpages.  Must clear out data source and
// additional data source, disable additional data source, set the data type to base and
// disable the Search By, Report On and View tab.  If as_path is from m_clear then must 
// reset is_inv_type and data source else this has already been done.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		Value			as_path		String				The path.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success		
//						-1				no datawindow child
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/05/97	Created.
//	FDG		1/26/98	Set add_data_source to null.
//	FDG		03/03/98	Track 880.  After disabling tabs, see if the Next
//							button is to be disabled.
//	FDG		04/13/98	Track 966, 1063.  Set the data type to 'Base' via a
//							script.  Reset and disable all the tabs outside of the
//							if statement.
//	FDG		05/15/98	Track 1241?  Prompt the user before clearing.
//	FDG 		06/15/98	Track ????.  Don't directly access uo_query attributes.
//	FDG		01/27/99	Track 2078c.  Reset the instance variables in uo_query
//							for additional data source.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

datawindowchild	ldwc_add_data
Integer				li_rc
Long					ll_row
String				ls_null
Constant String 	LS_INITIAL			=	"INITIAL_LEVEL"

SetNull (ls_null)

if UPPER(TRIM(as_path)) = 'CLEAR' then
	// Prompt the user that changes will be lost.
	li_rc		=	MessageBox ('Warning', 'You will lose all data associated with this query.' + &
									'  Do you want to continue?', Question!, OkCancel!, 1)
	IF	li_rc		=	2		THEN
		// Cancel clicked.  Get out.
		Return 0
	END IF
	iuo_query.Event	ue_reset_query()				// FDG 04/13/98
	//iuo_Query.is_inv_type = ''  					// FDG 04/13/98
	idw_source.object.data_source[1] = ''		
else
	iuo_query.of_set_add_inv_type('')				// FDG 01/27/99
end if

idw_source.getchild('add_data_source',ldwc_add_data)

if IsValid(ldwc_add_data) then
	ldwc_add_data.reset()
	iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98
	iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98
	iuo_query.of_enable_tabpage (ic_view, FALSE)			// FDG 06/15/98
	this.event ue_tabpage_source_set_data_type('BASE','','')		// FDG 04/13/98
	//This.Event	ue_tabpage_source_retrieve_base_source()				// FDG 04/13/98
	ll_row	=	idw_source.GetRow()
	idw_source.object.add_data_source [ll_row]	=	ls_null
	iuo_query.Event	ue_selecttab(0)					//	FDG 03/03/98
	idw_source.SetColumn ('data_source')				// FDG 04/13/98
	RETURN 1
else
	RETURN -1
end if
end event

event type integer ue_tabpage_source_set_subset_id(integer ai_row, string as_subset_name);//*********************************************************************************
// Event Name:	U_NVO_Source.UE_Tabpage_Source_Set_Source_Subset_ID
//	Arguments:	Data Type	Name						Passed As
//					Integer		ai_row					Value
//					String		as_subset_name			Value
// Returns:		Integer
//
//Track 930.
//This event is called by U_NVO_Source.UE_Tabpage_Source_Set_Data_Type and 
//UO_Query.Tabpage_Source.DW_Source.Itemchanged
//*********************************************************************************
// 03-11-98	FNC	Created
//*********************************************************************************
// 04-02-98 FNC   Track 1012 If cancel is clicked on the subset cross reference 
//                the case id and subset id information is not filled in so must 
//                exit.
// 04-07-98 FNC  Track 1053 1.If a case id is entered do not need to display the
//						subset cross reference window.
//						2. Use the set and get functions in NVO_Subset_Functions to set
//						the variables in NVO_Subset_Functions.
//						3. Disable search and report tabs if subset id is invalid
// 04/08/98	FNC	Track 1062 1. Reset the data source and additional data source if
//						the subset id fails editing. Disable the search by and report on
//						tabs
//	FDG 	06/15/98	Track ????.  Don't directly access uo_query attributes.
//	NLG	06/17/98	Track #1364 - If Subset Cross Reference window is called,
//						check for empty string rather than null structure
// FNC	06/23/98 Track 1396. 1.Set is_source_subset_id and is_source_subset_id instead
//						of arguments since pointers to variables have changed.
//						2.Call iuo_query.of_set_subset_id and iuo_query.of_set_source_subset_id
//						to set these values in uo_query.
// FNC	07/16/98	Track 1328. If cannot access subset because of security disable 
//						search and report on tasks and reset datasource dddws.
// FNC	11/04/98	Track 1822. Blank out the case id and subset  id if the security 
//						check is not passed.
// FNC	03/21/00	Track 2097 Stardev. Change message issued when subset is not found.
//	FDG	12/06/01	Track 2497, 2561.  Prevent memory leaks.
//	FDG	01/11/02	Track 2505d.  If the subset is invalid, reset the globals so it
//						doesn't get used again.
//	GaryR	11/16/04	Track 4115d	STARS Reporting - Claims PDRs
//	GaryR	12/30/04	Track 4212d Beefed up subset validation and improve control flow
//	GaryR	02/01/05	Track 4212d	Revalidate the info after cross-reference popup
//	GaryR	02/23/05	Track 4314d	Improved error messages and handling for subsets 
//										that fail or are created with 0 rows
//*********************************************************************************

Integer 			li_rows,		&
					li_rc
String 			ls_old_col,	&
					ls_case_id, &
					ls_sub_inv_types[], &
					ls_inv_type,	&
					ls_find
Boolean			lb_found
sx_subset_ids	lstr_subset_ids 

datawindowchild	ldwc_data_source,	&
						ldwc_add_data_source

NVO_Subset_Functions LNVO_Subset_Functions
LNVO_Subset_Functions = Create NVO_Subset_Functions

// Validate parameters in PDR mode
IF iw_parent.of_is_pdr_mode() THEN
	IF IsNull( ai_row ) OR ai_row < 1 THEN	Return -1
	IF IsNull( as_subset_name ) OR Trim( as_subset_name ) = "" THEN
		idw_source.SetItem( ai_row, 'case_id', '' )
		idw_source.SetItem( ai_row, 'subset_desc', '' )
		idw_source.SetItem( ai_row, 'subset_name', '' )
		Return -1
	END IF
END IF

/* populate the subset structure from w_query_engine parameters */
lstr_subset_ids = iw_parent.wf_Get_SxSubset()	//Added 2/12/98 JTM

/* check if this is a subset view */
IF lstr_subset_ids.subset_id = '' OR IsNull(lstr_subset_ids.subset_id) THEN
	/*Not subset view */
	//04-07-98 FNC Start
	ls_case_id = Trim( idw_source.getitemstring(ai_row,'case_id') )
	/*if have a case id do not need to open subset cross reference*/
	if ls_case_id <> '' then
		lstr_subset_ids.Subset_Name = as_subset_name
		lstr_subset_ids.subset_Case_ID = left(ls_case_id,10)
		lstr_subset_ids.subset_Case_Spl = mid(ls_case_id,11,2)
		lstr_subset_ids.subset_Case_Ver = mid(ls_case_id,13,2)
		lnvo_subset_functions.uf_set_structure(lstr_subset_ids)
		li_rc = lnvo_subset_functions.uf_retrieve_subset_id()
		if li_rc = 1 then
			lstr_subset_ids = lnvo_subset_functions.uf_get_structure()
			IF iw_parent.of_is_pdr_mode() THEN
				idw_source.SetItem( ai_row, 'subset_id', lstr_subset_ids.subset_id )
				idw_source.SetItem( ai_row, 'subset_desc', lstr_subset_ids.subset_desc )
			ELSE
				is_source_subset_id = lstr_subset_ids.subset_id
			END IF
		elseif li_rc = 0 then
			lstr_subset_ids.subset_name = as_subset_name
			lnvo_subset_functions.uf_set_structure(lstr_subset_ids)	
			li_rows = lnvo_subset_functions.uf_select_links_using_subset_name()
			if li_rows > 1 then
				openwithparm(w_subset_cross_reference_list,lstr_subset_ids)
				lstr_subset_ids = message.PowerObjectParm

				if trim(lstr_subset_ids.subset_id) = '' then				//NLG 6-17-98 Track #1364
					IF iw_parent.of_is_pdr_mode() THEN
						idw_source.SetItem( ai_row, 'subset_name', '' )
						idw_source.SetItem( ai_row, 'case_id', '' )
						idw_source.SetItem( ai_row, 'subset_desc', '' )
						iuo_query.Post Event ue_tabpage_pdr_validate_source()
					ELSE
						messagebox('WARNING','Subset not selected. Cannot continue to process request.')
						// FNC 04/08/98	Start
						iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98				
						iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98				
						idw_source.getchild('data_source',ldwc_data_source)
						ldwc_data_source.reset()
						idw_source.setitem(ai_row,'data_source','')
						idw_source.getchild('add_data_source',ldwc_add_data_source)
						ldwc_add_data_source.reset()		
						idw_source.setitem(ai_row,'add_data_source','')	
						// FNC 04/08/98	End
					END IF
					
					IF IsValid(lnvo_subset_functions)	THEN	Destroy	lnvo_subset_functions	// FDG 12/06/01
					// FDG 01/11/02 - reset active subset globals
					gc_active_subset_name	=	''
					gc_active_subset_case	=	''
					gc_active_subset_id		=	''
					// FDG 01/11/02 - end
					return -1
				else
					IF iw_parent.of_is_pdr_mode() THEN
						idw_source.SetItem( ai_row, 'subset_id', lstr_subset_ids.subset_id )
						idw_source.SetItem( ai_row, 'subset_desc', lstr_subset_ids.subset_desc )
					ELSE
						is_source_subset_id = lstr_subset_ids.subset_id
					END IF
				end if
				idw_source.object.case_id[ai_row] = lstr_subset_ids.subset_case_id + &
					lstr_subset_ids.subset_case_spl + lstr_subset_ids.subset_case_ver		
			elseif li_rows = 1 then
				lstr_subset_ids = lnvo_subset_functions.uf_get_structure()
				IF iw_parent.of_is_pdr_mode() THEN
					idw_source.SetItem( ai_row, 'subset_id', lstr_subset_ids.subset_id )
					idw_source.SetItem( ai_row, 'subset_desc', lstr_subset_ids.subset_desc )
				ELSE
					is_source_subset_id = lstr_subset_ids.subset_id
				END IF
			else
				IF iw_parent.of_is_pdr_mode() THEN
					idw_source.SetItem( ai_row, 'subset_name', '' )
					idw_source.SetItem( ai_row, 'case_id', '' )
					idw_source.SetItem( ai_row, 'subset_desc', '' )
					MessageBox( "Invalid Subset", "Invalid subset '" + as_subset_name + &
								"' specified for Data Source #" + String( ai_row ), StopSign! )
				ELSE
					// FNC 03/21/00
					messagebox('Invalid Subset', "Subset '" + as_subset_name + &
									"' does not exist.  Please select another subset.", StopSign! )
					// FNC 04/08/98	Start
					iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98				
					iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98				
					iuo_query.of_enable_tabpage (ic_view, FALSE)
					idw_source.getchild('data_source',ldwc_data_source)
					ldwc_data_source.reset()
					idw_source.setitem(ai_row,'data_source','')
					idw_source.getchild('add_data_source',ldwc_add_data_source)
					ldwc_add_data_source.reset()		
					idw_source.setitem(ai_row,'add_data_source','')
					idw_source.setitem(ai_row,'subset_name','')
					idw_source.setitem(ai_row,'case_id','')
				END IF
				
				IF IsValid(lnvo_subset_functions)	THEN	Destroy	lnvo_subset_functions	// FDG 12/06/01
				// FDG 01/11/02 - reset active subset globals
				gc_active_subset_name	=	''
				gc_active_subset_case	=	''
				gc_active_subset_id		=	''
				// FDG 01/11/02 - end
				return -1	
			end if
		end if
	//04-07-98 FNC End
	else /*no case id must call subset cross reference */
		lstr_subset_ids.subset_name = as_subset_name
		lnvo_subset_functions.uf_set_structure(lstr_subset_ids)	//04-07-98 FNC
		li_rows = lnvo_subset_functions.uf_select_links_using_subset_name()
		if li_rows > 1 then
			openwithparm(w_subset_cross_reference_list,lstr_subset_ids)
			lstr_subset_ids = message.PowerObjectParm
			//04-02-98 FNC Start
			if trim(lstr_subset_ids.subset_id) = '' then				//NLG 06/17/98 Track #1364
				IF iw_parent.of_is_pdr_mode() THEN
					idw_source.SetItem( ai_row, 'subset_name', '' )
					idw_source.SetItem( ai_row, 'case_id', '' )
					idw_source.SetItem( ai_row, 'subset_desc', '' )
					iuo_query.Post Event ue_tabpage_pdr_validate_source()
				ELSE
					messagebox('WARNING','Subset not selected. Cannot continue to process request.')
					// FNC 04/08/98	Start
					iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98				
					iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98				
					idw_source.getchild('data_source',ldwc_data_source)
					ldwc_data_source.reset()
					idw_source.setitem(ai_row,'data_source','')
					idw_source.getchild('add_data_source',ldwc_add_data_source)
					ldwc_add_data_source.reset()		
					idw_source.setitem(ai_row,'add_data_source','')	
				END IF
				
				IF IsValid(lnvo_subset_functions)	THEN	Destroy	lnvo_subset_functions	// FDG 12/06/01
				// FDG 01/11/02 - reset active subset globals
				gc_active_subset_name	=	''
				gc_active_subset_case	=	''
				gc_active_subset_id		=	''
				// FDG 01/11/02 - end
				return -1
			else
				IF iw_parent.of_is_pdr_mode() THEN
					idw_source.SetItem( ai_row, 'subset_id', lstr_subset_ids.subset_id )
					idw_source.SetItem( ai_row, 'subset_desc', lstr_subset_ids.subset_desc )
				ELSE
					is_source_subset_id = lstr_subset_ids.subset_id
				END IF
			end if
			//04-02-98 FNC End
			idw_source.object.case_id[ai_row] = lstr_subset_ids.subset_case_id + &
				lstr_subset_ids.subset_case_spl + lstr_subset_ids.subset_case_ver		
		elseif li_rows = 1 then
				lstr_subset_ids = lnvo_subset_functions.uf_get_structure()
				IF iw_parent.of_is_pdr_mode() THEN
					idw_source.SetItem( ai_row, 'subset_id', lstr_subset_ids.subset_id )
					idw_source.SetItem( ai_row, 'subset_desc', lstr_subset_ids.subset_desc )
				ELSE
					is_source_subset_id = lstr_subset_ids.subset_id
				END IF
		else
			IF iw_parent.of_is_pdr_mode() THEN
				idw_source.SetItem( ai_row, 'subset_name', '' )
				idw_source.SetItem( ai_row, 'case_id', '' )
				idw_source.SetItem( ai_row, 'subset_desc', '' )
				MessageBox( "Invalid Subset", "Invalid subset '" + as_subset_name + &
								"' specified for Data Source #" + String( ai_row ), StopSign! )
			ELSE
				messagebox('Invalid Subset', "Subset '" + as_subset_name + &
								"' does not exist.  Please select another subset.", StopSign! )
				// FNC 04/08/98	Start
				iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98				
				iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98				
				iuo_query.of_enable_tabpage (ic_view, FALSE)
				idw_source.getchild('data_source',ldwc_data_source)
				ldwc_data_source.reset()
				idw_source.setitem(ai_row,'data_source','')
				idw_source.getchild('add_data_source',ldwc_add_data_source)
				ldwc_add_data_source.reset()		
				idw_source.setitem(ai_row,'add_data_source','')
				idw_source.setitem(ai_row,'subset_name','')
				idw_source.setitem(ai_row,'case_id','')
			END IF
			
			IF IsValid(lnvo_subset_functions)	THEN	Destroy	lnvo_subset_functions	// FDG 12/06/01
			// FDG 01/11/02 - reset active subset globals
			gc_active_subset_name	=	''
			gc_active_subset_case	=	''
			gc_active_subset_id		=	''
			// FDG 01/11/02 - end
			return -1	
		end if
	end if
	IF iuo_query.of_GetCaseSecurity( ai_row, lstr_subset_ids ) < 0 THEN
		IF iw_parent.of_is_pdr_mode() THEN
			idw_source.SetItem( ai_row, 'subset_name', '' )
			idw_source.SetItem( ai_row, 'case_id', '' )
			idw_source.SetItem( ai_row, 'subset_desc', '' )
		ELSE
			// FNC 07/16/98 Start
			iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98				
			iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98				
			idw_source.getchild('data_source',ldwc_data_source)
			ldwc_data_source.reset()
			idw_source.setitem(ai_row,'data_source','')
			idw_source.getchild('add_data_source',ldwc_add_data_source)
			ldwc_add_data_source.reset()		
			idw_source.setitem(ai_row,'add_data_source','')
			idw_source.setitem(ai_row,'case_id','')			// FNC  11/04/98
			idw_source.setitem(ai_row,'subset_name','')		// FNC  11/04/98
			// FNC 07/16/98 End			
		END IF
		Destroy(LNVO_Subset_Functions)
		Return 1
	END IF
	IF NOT iw_parent.of_is_pdr_mode() THEN iuo_query.event ue_tabpage_source_set_subset_data_source(is_source_subset_id)	
else
	/* subset view*/
	/* check the case security of selected (in subset list window) subset id*/
	is_subset_id = lstr_subset_ids.subset_id
	IF iuo_query.of_GetCaseSecurity( ai_row, lstr_subset_ids ) < 0 THEN
		IF iw_parent.of_is_pdr_mode() THEN
			idw_source.SetItem( ai_row, 'subset_name', '' )
			idw_source.SetItem( ai_row, 'case_id', '' )
			idw_source.SetItem( ai_row, 'subset_desc', '' )
		ELSE
			// FNC 07/16/98 Start
			iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/15/98				
			iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/15/98				
			idw_source.getchild('data_source',ldwc_data_source)
			ldwc_data_source.reset()
			idw_source.setitem(ai_row,'data_source','')
			idw_source.getchild('add_data_source',ldwc_add_data_source)
			ldwc_add_data_source.reset()		
			idw_source.setitem(ai_row,'add_data_source','')	
			idw_source.setitem(ai_row,'case_id','')			// FNC  11/04/98
			idw_source.setitem(ai_row,'subset_name','')		// FNC  11/04/98
			// FNC 07/16/98 End	
		END IF
		Destroy(LNVO_Subset_Functions)
		Return 1
	END IF
end if

IF iw_parent.of_is_pdr_mode() THEN
	// Verify that subset belongs to selected invoice type	
	this.event ue_tabpage_source_get_source_sub_tables(lstr_subset_ids.subset_id,ls_sub_inv_types)
	li_rows = UpperBound(ls_sub_inv_types)
	IF li_rows < 1 THEN
		MessageBox('ERROR','Cannot determine invoice types included in subset. Please select another')
		
		idw_source.SetItem( ai_row, 'subset_name', '' )
		idw_source.SetItem( ai_row, 'case_id', '' )
		idw_source.SetItem( ai_row, 'subset_desc', '' )
		gc_active_subset_name	=	''
		gc_active_subset_case	=	''
		gc_active_subset_id		=	''

		Return -1
	END IF
	
	//	Get the required invoice type(s)
	ls_inv_type = Left( idw_source.GetItemString( ai_row, "inv_type" ), 2 )
	IF IsNull( ls_inv_type ) OR Trim( ls_inv_type ) = "" THEN
		ls_inv_type = idw_source.GetItemString( ai_row, "inv_types" )
	END IF
	
	FOR li_rc = 1 TO li_rows
		IF Pos( ls_inv_type, ls_sub_inv_types[li_rc] ) > 0 THEN
			lb_found = TRUE
			EXIT
		END IF
	NEXT
	
	IF NOT lb_found THEN
		idw_source.SetItem( ai_row, 'subset_name', '' )
		idw_source.SetItem( ai_row, 'case_id', '' )
		idw_source.SetItem( ai_row, 'subset_desc', '' )
		MessageBox( "Invalid Subset", "Subset '" + as_subset_name + &
					"' specified for Data Source #" + String( ai_row ) + &
					" does not contain required invoice type (" + ls_inv_type + ")", StopSign! )
		gc_active_subset_name	=	''
		gc_active_subset_case	=	''
		gc_active_subset_id		=	''
		Return -1
	END IF
	
	//	If an invoice type is not selected, select it
	ls_inv_type = idw_source.GetItemString( ai_row, "inv_type" )
	IF IsNull( ls_inv_type ) OR Trim( ls_inv_type ) = "" THEN
		li_rc = idw_source.GetChild( "inv_type", ldwc_data_source )
		
		ls_find = "stars_rel_rel_type='" + ls_sub_inv_types[li_rc] + "'"
		li_rc = ldwc_data_source.Find( ls_find, &
													0, ldwc_data_source.RowCount() )
		IF li_rc > 0 THEN
			ls_inv_type = ldwc_data_source.GetItemString( li_rc, "compute_0001" )
			idw_source.SetItem( ai_row, "inv_type", ls_inv_type )
		END IF
	END IF
ELSE
	iuo_query.of_set_subset_id(is_subset_id)						// FNC 06/23/98
	iuo_query.of_set_source_subset_id(is_source_subset_id)	// FNC 06/23/98
END IF

Destroy(LNVO_Subset_Functions)
Return 0
end event

event type integer ue_tabpage_source_set_subset_data_source(string as_subset_id);/////////////////////////////////////////////////////////////////////////////
// 	Event/Function										Object				
//	--------------										------				
//	UE_Tabpage_Source_Set_Subset_Data_Source		U_NVO_Source
//
//	Description
//	-----------
// 	If the data type is 'Subset' this event will determine the invoice types in the
//	subset and load the datasource dddw with these invoice types. 
/////////////////////////////////////////////////////////////////////////////
//	 PARAMETERS
//		Passed by	Argument			DataType			Description
//		---------	--------			--------			-----------
//		Value			as_subset_id	string			The subset id.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Sucess.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
// FNC	03/18/98		Created.
// FNC	05/15/98		Track 1167 If query is being loaded do not do an 
//							accepttext when MC is added to the data source dddw
// FNC	06/17/98		Track 1311. If level is 2 or greater do not add
//							MC if source is ML Subset.
// FNC	04/14/99		FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//							to prevent locking.
//	FDG	01/11/02		Track 2505d.  If the subset is invalid, reset the globals so it
//							doesn't get used again.
//	FDG	04/03/02		Stars 5.1.  Account for ancillary subsets.
//	GaryR	08/06/04		Track 4049d	Provide drilldown from Subset Summary
// GaryR	01/06/05		Track 4217d	Trigger user event instead of AcceptText
// Katie 09/08/06		Track 4764d Used invoice type to select correct row in data_source.
//	GaryR	09/08/06		Track 4816	Set proper inv type when drilling down from ML FT Subset Summary
//	GaryR	12/20/07		SPR 5199	Add the facility to categorize and sort data sources
//	GaryR	12/21/07		SPR 5234	Add descriptions to selected data sources
//	GaryR	05/02/08		SPR 5346	Set the description when adding MC or ML artificially
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

long 		ll_row,			&
			ll_num_rows,	&
			ll_num_tables,	&
			ll_dddw_row
integer	li_idx,			&
			li_find_return,	&
			li_rc,			&
			li_max_level
string	ls_sql,			&
			ls_sub_inv_types[],	&
			ls_inv_types,	&
			ls_data_source, &
			ls_added_type
n_cst_revenue		lnv_revenue
datawindowchild ldwc_data_source

n_Ds lds_subset

ll_row =	idw_source.GetRow()

idw_source.getchild('data_source',ldwc_data_source)

ldwc_data_source.reset()

ldwc_data_source.SetTransObject(Stars2ca)

//	Disable categories
This.Event	ue_tabpage_source_enable_cat( FALSE, "" )

if IsValid(ldwc_data_source) then
	this.event ue_tabpage_source_get_source_sub_tables(as_subset_id,ls_sub_inv_types)
	ll_num_tables = upperbound(ls_sub_inv_types)
	if (ll_num_tables < 1) then
		messagebox('ERROR','Cannot determine invoice types included in subset. Please select another')
		// FDG 01/11/02 - reset active subset globals
		gc_active_subset_name	=	''
		gc_active_subset_case	=	''
		gc_active_subset_id		=	''
		// FDG 01/11/02 - end
		return -1
	end if
	
	lnv_revenue = Create n_cst_revenue
	
	for li_idx = 1 to ll_num_tables  /* build value for IN statement */
		ls_inv_types = ls_inv_types + ",'" + ls_sub_inv_types[li_idx] + "'"
		
		//	Add FastTrack
		IF iw_parent.ib_sumbyrev THEN
			IF lnv_revenue.of_get_base_type( ls_sub_inv_types[li_idx] ) = "UB92" THEN
				ls_inv_types += ", '" + &
					lnv_revenue.of_get_fasttrack_invoice( ls_sub_inv_types[li_idx] ) + "'"
			END IF
		ELSE
			IF ll_num_tables = 1 THEN
				IF lnv_revenue.of_get_base_type( ls_sub_inv_types[li_idx] ) = "UB92" THEN
					ls_inv_types += ", '" + &
						lnv_revenue.of_get_fasttrack_invoice( ls_sub_inv_types[li_idx] ) + "'"
				END IF
			END IF
		END IF
	next
	
	Destroy lnv_revenue
	
	ls_inv_types = mid(ls_inv_types,2)  /* remove first ',' */
	ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
				+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
				+ "from stars_rel sr, dictionary dt " &
				+ "where sr.id_2 = dt.elem_tbl_type " &
				+ "and (sr.rel_type = 'QT' or sr.rel_type = 'AN') " &
				+ "and dt.elem_type = 'TB' " &
				+ "and sr.id_2 in (" + Upper( ls_inv_types ) + ")"
				
	ldwc_data_source.setsqlselect(ls_sql)
	
	ll_num_rows = ldwc_data_source.retrieve()
	
	if ll_num_rows < 1 then 
		messagebox('ERROR','Cannot retrieve table names included in subset')
		// FDG 01/11/02 - reset active subset globals
		gc_active_subset_name	=	''
		gc_active_subset_case	=	''
		gc_active_subset_id		=	''
		// FDG 01/11/02 - end
		return -1
	else																			// FNC 04/14/99
		stars2ca.of_commit()													// FNC 04/14/99
	end if
	
	if ll_num_tables > 1 then
		li_max_level = iw_parent.wf_get_max_uo_query()				// FNC 06/17/98
		if li_max_level <= 1 then											// FNC 06/17/98
			ls_data_source = This.of_get_mc_desc()
			ls_added_type = 'MC - Common'
			//FNC 05/15/98 Start 
			ll_dddw_row	=	ldwc_data_source.InsertRow(1)			//	Insert at the top
			li_rc = ldwc_data_source.SetItem (ll_dddw_row, 'stars_rel_id_2', "MC")
			li_rc = ldwc_data_source.SetItem (ll_dddw_row, 'dictionary_elem_desc', "Common")
			li_rc = ldwc_data_source.SetItem (ll_dddw_row, "stars_rel_rel_type", 'QT')
			li_rc = ldwc_data_source.SetItem (ll_dddw_row, "stars_rel_rel_desc", ls_data_source)
			if not ib_load_data then	// FNC 05/15/98 End
				ldwc_data_source.SelectRow (ll_dddw_row, TRUE)
				idw_source.SetItem( 1, "data_source", ls_added_type )
				iuo_query.event ue_tabpage_source_itemchanged( ls_added_type )
			end if
		end if																	// FNC 06/17/98
	else
		ll_Row = ldwc_data_source.Find( "stars_rel_id_2 = '" + ls_sub_inv_types[1] + "'", &
	        1, ldwc_data_source.RowCount()) //KKR SPR4764
		ls_data_source = 	ldwc_data_source.GetItemString(ll_Row,'compute_0001')
		if Trim(ls_data_source) <> '' AND Not(IsNull(ls_data_source)) THEN
			idw_source.SetItem( 1, "data_source", ls_data_source )
			iuo_query.event ue_tabpage_source_itemchanged( ls_data_source )
		end if
	end if
end if
	
return 0
end event

event type integer ue_tabpage_source_set_base_data_source(boolean ab_new_level);/////////////////////////////////////////////////////////////////////////////
//
//	Script:		UE_Tabpage_Source_Set_Base_Data_Source
//
//	Arguments:	None
//
//	Returns:		Integer - 1=success
//
//	Description:
// 	This script will set the data type on the Source Tab to 'Base'.
//	
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
// FNC		3/19/98	Created.
//	FDG		04/02/98	Track 1010.  Retrieve ldwc_data_source from an
//							an event script.
//	FDG		04/14/98	Track 975, 1063.  Set the data type to 'Base' here
//							so it won't have to be done in multiple locations.
// FNC		06/03/98	Track 1166. If calling from new level don't retrieve 
//							datasource dddw. It has already been retrieved.
// FNC		06/23/98	Track 1396. Set is_data_type in UO_Query. 
//	GaryR		03/26/03	Track 3490d	Clean up payment date logic
//	GaryR		12/20/07	SPR 5199	Add the facility to categorize and sort data sources
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

Long 		ll_row,				&
			ll_num_rows,		&
			ll_source_row
String	ls_sql,				&
			ls_data_source,	&
			ls_find,				&
			ls_inv_type

datawindowchild ldwc_data_source

ll_source_row = idw_source.getrow()

if not ab_new_level then													// FNC 06/03/98 
	This.Event	ue_tabpage_source_retrieve_base_source()			// FDG 04/02/98
end if																			// FNC 06/03/98 

idw_source.Object.rb_source[ll_source_row] = 'Base'			// FDG 04/14/98
is_data_type = 'BASE'													//	FDG 04/14/98
iuo_query.of_set_data_type(is_data_type)							// FNC 06/23/98

idw_source.getchild('data_source',ldwc_data_source)

//	FDG 04/14/98 - Only perform the if statement if not loading an existing PDQ.
if IsValid(ldwc_data_source) 			&
and ib_load_data	=	FALSE				then
	// Get the last invoice type used by this user.  This is set in
	//	uo_query.dw_source.itemchanged.
	ls_inv_type	=	gnv_app.of_get_default_inv_type()
	ls_find	=	"stars_rel_id_2 = '"	+	ls_inv_type	+	"'"
	
	ll_row	=	ldwc_data_source.Find (ls_find, 1, ldwc_data_source.Rowcount() )
	
	IF	ll_row	<	1		THEN
		// Default invoice type not found - get the 1st row
		ll_row	=	1
	END IF
	
	// ll_row should always = 1 (the current row of idw_source)
	ls_data_source = ldwc_data_source.GetItemString(ll_Row,'compute_0001')
		
	if Trim(ls_data_source) <> '' and Not(IsNull(ls_data_source)) then
		idw_source.SetColumn('data_source')
		idw_source.SetText(ls_data_source)
		idw_source.AcceptText()
	end if
		
end if

//	Set categories
This.Event	ue_tabpage_source_enable_cat( TRUE, "" )

return 0

end event

event ue_tabpage_source_retrieve_base_source();/////////////////////////////////////////////////////////////////////////////
//	Script:	ue_Tabpage_Source_Retrieve_Base_Source	
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
// 	If the data type is 'Subset' this event will load the datasource dddw with the
//		the base invoice types.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
// FDG	04/02/98	Track 1010.  Created.
//
//	FDG	04/03/98	Track 1037.  Include ancillary tables with the SQL.
//
// FNC	06/17/98	Track 1311. If level is greater than 1 then do not retrieve
//						ancillary tables or MC.
//
// FNC	04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL to 
//						to prevent locking.
//	GaryR	12/20/07	SPR 5199	Add the facility to categorize and sort data sources
//	GaryR	12/21/07	SPR 5234	Add descriptions to selected data sources
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

Long 		ll_row,			&
			ll_num_rows
Integer	li_max_level
String	ls_sql,			&
			ls_data_source

DatawindowChild	ldwc_data_source

ll_row	=	idw_source.GetRow()

idw_source.GetChild ('data_source',ldwc_data_source)

ldwc_data_source.Reset()
ldwc_data_source.SetTransObject(Stars2ca)

IF IsValid (ldwc_data_source)			THEN
	li_max_level = iw_parent.wf_get_max_uo_query()				// FNC 06/17/98
	if li_max_level = 1 then											// FNC 06/17/98
		// must go to STARS_REL to get claim invoice types 
		ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " & 
					+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
					+ 'from stars_rel sr, dictionary dt ' &
					+ 'where sr.id_2 = dt.elem_tbl_type ' &
					+	"and sr.rel_type in ('QT','AN') " &
					+	"and dt.elem_type = 'TB' "
	else																		// FNC 06/17/98 Start
		ls_sql ="select sr.id_2, dt.elem_desc, sr.rel_type, " & 
				+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
				+ 'from stars_rel sr, dictionary dt ' &
				+ 'where sr.id_2 = dt.elem_tbl_type ' &
				+	"and sr.rel_type in ('QT') " &
				+	"and sr.id_2 <> 'MC' " &
				+	"and dt.elem_type = 'TB' "						// FNC 06/17/98 End
	end if
	ldwc_data_source.SetSQLSelect (ls_sql)
	ll_num_rows	=	ldwc_data_source.Retrieve()
	IF ll_num_rows < 0					THEN
		MessageBox('Error',				&
				'Error retrieving from the Stars_Rel and Dictionary Table. '	+	& 
				'Please contact your database administrator.',StopSign!,Ok!)
		Return
	ELSE																	// FNC 04/14/99
		stars2ca.of_commit()											// FNC 04/14/99
	END IF	
END IF

end event

event type integer ue_tabpage_source_filter_data_source();/////////////////////////////////////////////////////////////////////////////
//
//	Script:			UE_Tabpage_Source_Filter_Data_Source
//
//	Arguments:		None
//
//	Returns:			Integer 1=success, -1=failure
//
//	Description:	This script will filter the invoice 
//						types based on the selected category
//	
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
// FDG		04/14/98		Track 975, 1063.  Created.
//	GaryR		12/20/07		SPR 5199	Add the facility to categorize and sort data sources
//
/////////////////////////////////////////////////////////////////////////////

Long					ll_row, ll_rows, ll_cat_val, ll_inv_cat
String				ls_filter, ls_data_sources
n_cst_numerical	lnv_numerical		// Auto instantiated
datawindowchild	ldwc_data_source, ldwc_category

idw_source.getchild('data_source',ldwc_data_source)
IF NOT IsValid(ldwc_data_source) THEN Return -1

// Unfilter any filtered data.
ldwc_data_source.SetFilter( "" )
ldwc_data_source.Filter()

// Filter data sources for the current category
idw_source.GetChild( "category", ldwc_category )
IF ldwc_category.RowCount() = 0 THEN GOTO BYPASS

ll_row = ldwc_category.GetRow()
IF ll_row > 0 THEN
	ll_cat_val = ldwc_category.GetItemNumber( ll_row, "value_n" )
	
	ll_rows = ldwc_data_source.RowCount()
	FOR ll_row = 1 TO ll_rows
		//	Compare each invoice type's category setting
		ll_inv_cat = ldwc_data_source.GetItemNumber( ll_row, "stars_rel_value_n" )
		IF ll_inv_cat = 0 OR NOT lnv_numerical.of_is_bitwise( ll_cat_val, ll_inv_cat ) THEN
			//	If invoice is not part of category then filter it out
			ls_data_sources += "," + String( ll_inv_cat )
		END IF		
	NEXT
	
	IF ls_data_sources <> "" THEN &
			ls_filter = "stars_rel_value_n not in (" + Mid( ls_data_sources, 2 ) + ")"
END IF

BYPASS:

ldwc_data_source.SetFilter(ls_filter)
ldwc_data_source.Filter()

//	Make sure that category has invoices
IF ldwc_data_source.RowCount() = 0 THEN Return -1

// Re-sort the data in case unfiltering moves data to the end of the DDDW.
ldwc_data_source.SetSort("stars_rel_rel_seq A, compute_0001 A")
ldwc_data_source.Sort()

//	Set the first data source
ls_data_sources =	ldwc_data_source.GetItemString( 1, 'compute_0001')
ldwc_data_source.SelectRow( 0, FALSE )
ldwc_data_source.SelectRow( 1, TRUE )
ldwc_data_source.SetRow( 1 )
idw_source.object.data_source[1] = ls_data_sources
iuo_query.event ue_tabpage_source_itemchanged( ls_data_sources )

Return 1
end event

event type integer ue_add_data_source_change(string as_add_data_source);/////////////////////////////////////////////////////////////////////////////
// Script:		u_nvo_source.ue_add_data_source_change
//	
//	Arguments:	as_add_data_source - The new additional data source
//
//	Returns:		None
//
//	Description:	
//		This script is triggered from dw_source.itemchanged and from 
//		u_nvo_source.ue_tabpage_source_set_data_type when the additional
//		data source changes.
//
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	FDG	05/11/98	Track 1178.  Created.
//	FDG	05/18/98	Track 1235.  For additional data drilldowns, load the period
//						on the search tab with the original description so that
//						the from and paid dates get set in the criteria.
//	FDG	05/26/98	Track 1286.  Script moved from uo_query.
//	FDG 	06/15/98	Track ????.  Don't directly access uo_query attributes.
//	FDG	01/26/99	Track 2078c.  If the additional data source is null, set
//						it to the empty string.
//	FNC	10/22/01	Track 3631 Starcare. Set add inv type before calling 
//						ue_tabpage_report_set_columns so the add inv type is available for
//						an event caled by set_columns.
//	GaryR	11/26/02	SPR 3275d	Validate range of dependant
/////////////////////////////////////////////////////////////////////////////

Boolean	lb_criteria_changed,		&
			lb_drilldown

Integer	li_rc

Long		ll_selected_rowcount,	&
			ll_row,						&
			ll_rowcount

String	ls_invoice,					&
			ls_inv_types[],			&
			ls_period_desc,			&
			ls_inv_type,				&
			ls_add_inv_type
			
sx_drilldown	lstr_drilldown

// FDG 01/26/99 begin
IF	IsNull (as_add_data_source)	THEN
	as_add_data_source	=	''
END IF
// FDG 01/26/99 end
			
ls_add_inv_type			=	iuo_query.of_get_add_inv_type()		// FDG 05/26/98
lb_drilldown				=	iuo_query.of_get_ib_drilldown()		// FDG 05/26/98
lstr_drilldown				=	iuo_query.of_get_istr_drilldown()	// FDG 05/26/98
ls_period_desc				=	iuo_query.of_get_period_desc()		// FDG 05/26/98
ls_inv_type					=	iuo_query.of_getinvoicetype()			// FDG 05/28/98
ll_selected_rowcount		=	iuo_query.tabpage_report.dw_selected.RowCount()
lb_criteria_changed		=	iuo_query.of_edit_criteria_changed()

//	GaryR	11/26/02	SPR 3275d - Begin
ls_invoice	=	Upper (Left (Trim(as_add_data_source), 2) )
ls_inv_types[1]	=	ls_invoice
iuo_query.of_set_add_inv_type (ls_invoice)

if (trim(ls_add_inv_type) <> '') then
	idw_criteria.Reset()
	iuo_query.Event	ue_edit_initial_search_by_data()
end if
//	GaryR	11/26/02	SPR 3275d - End

IF lb_drilldown 				&
AND lstr_drilldown.path 	= 	'AD'		THEN					//01-28-98 FNC
	iuo_query.Event ue_tabpage_search_set_columns ('', ls_invoice, 'A')	//01-28-98 FNC
	lstr_drilldown.inv_type = ls_invoice				//01-29-98 FNC
	iuo_query.of_enable_tabpage (ic_search, TRUE)	//02-11-98 FNC			// FDG 06/15/98
	iuo_query.of_enable_tabpage (ic_report, TRUE)	//02-11-98 FNC			// FDG 06/15/98
	iu_period.uf_scroll_to_row (ls_period_desc)		// FDG 05/18/98		// FDG 06/15/98
ELSE
	iuo_query.Event ue_tabpage_search_set_columns(ls_inv_type, ls_invoice, 'A')	//01-14-98 FNC
END IF

iuo_query.Event ue_tabpage_report_set_columns (ls_inv_types[], 'A')

iuo_query.of_set_istr_drilldown (lstr_drilldown)					// FDG 05/26/98
	
Return 1
end event

event type integer ue_drilldown_load_new_query();//*********************************************************************************
// Event Name:	u_nvo_source.ue_Drilldown_Load_New_Query
//	Arguments:	None
// Returns:		Integer
//	Description:
// This event is called by w_query_engine.ue_parent_drilldown.  It will use 
// astr_drilldown to populate the data source tabpage.  Also set 
// is_drilldown_previous_temp_table_name to the table in the parm so that 
// ue_format_where_criteria() knows to join the temp table to the criteria and if user
// has selected to display temp table columns in the new report, must populate 
// tabpage_report with the temp columns.  Then disable the list tabpage and select the
// source tabpage.
//
//	There are three different types of drilldown paths.  The first is Additional Data 
//	(AD) where you are drilling down to the dependents of a claim.  The second is Claims
//	(MC) which is drilling down to claim data from an Ancillary table.  The third path 
//	is an Ancillary drilldown.  This is drilling down to an Ancillary table from either 
//	claims or another Ancillary table.  This path is denoted by the table invoice type. 
//
//*********************************************************************************
// 01-07-98 FNC 	Created
//*********************************************************************************
//	Modifications
// 01-28-98 FNC	Comment out reset of source datawindow so that datawindow is not
//						blank. Default source to base
// 02-09-98 FNC	1. Change istr_drilldown.inv_type to is_inv_type because 
//							istr_drilldown.inv_type is set when the user selects the drilldown
//							invoice type in the source tab.
// 					2. Change istr_drilldown.inv_type to istr_drilldown.path
// 					3. Change rtrim(STARS_REL.REL_ID) to STARS_REL.ID_2 in order to 
//							retrieve ancillary tables correctly.
// 02-10-98 FNC	1. Add main table type if drilldown on additional data source
// 				  	Blank out data source and then select 1st entry for drilldown 
//						path <> 'AD'
//						2.Disable the search, report and view tabs
//	02-24-98 FNC	Set transobject for the data source dddw
//	02/24/98	FDG	1. Enable the source tab
//						2. Reset dw_available
//	02/26/98	FDG	Get the data source value from the DDDW.
//	03/02/98	FDG	Track 876.  Select the tab via an event.
//	03/17/98	FDG	Track 871.  Set the data_source column so the user can see its
//						value.  Also, set istr_drilldown.inv_type.
// 05/20/98	FDG	Track 1235.  Reset dw_criteria.
//	05/21/98	FDG	Track 1248.  Add microhelp when drilling down.
//	05/26/98	FDG	Track 1286.  Move from uo_query.
//	05/28/98	FDG	Track 1271.  The logic to initialize the period to 'NONE' had
//						to be moved up in the script so that the correct dates get
//						displayed in the Search By tab.
//	06/15/98	FDG	Track ????.  Don't directly access uo_query attributes.
// 01/12/99	AJS	FS1872d 4.1.  Correct if drilldown entry not in stars_win_parm tbl
// 04/14/99	FNC	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
// 12/22/99	FNC	Fraud PDQ's set the payment options ddlb on the search tab to
//						invisible for drilldown.
// 03/07/00	FNC	Remove the "QT" from the where statement when drilldown path is
//						"AD" and table type is an ancillary table. "QT" refers only to 
//						claims tables.
//	11/21/02	GaryR	SPR 3187d	Read description from dictionary
//	02/25/03	GaryR	Track 3452d	Account for drilldown with subset as base
//	08/17/05	GaryR	Track 4490d	Prevent setting subset as base for Patient/Provider drilldowns
//	01/11/06  HYL 		Track 4562d	Force users to select period when 'drilldown' leads to open Data Source tab
//	12/20/07	GaryR	SPR 5199	Add the facility to categorize and sort data sources
//	12/21/07	GaryR	SPR 5234	Add descriptions to selected data sources
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//*********************************************************************************

String				ls_sql,					&
						ls_inv_type,			&
						ls_data_source,		&
						ls_period_desc,		&
						ls_microhelp,			&
						ls_find
Integer 				li_num_rows,			&
						li_rc,					&
						li_row
Long					ll_row,					&
						ll_source_row,			&
						ll_criteria_row,		&
						ll_rowcount
datawindowchild	ldwc_data_source,		&
						ldwc_add_data_source
sx_drilldown		lstr_drilldown
n_cst_stars_rel	ln_cst_stars_rel

ls_inv_type			=	iuo_query.of_getinvoicetype()			// FDG 05/26/98
lstr_drilldown		=	iuo_query.of_get_istr_drilldown()	// FDG 05/26/98
ll_source_row		=	iuo_query.tabpage_source.dw_source.GetRow()

//	Disable categories
This.Event	ue_tabpage_source_enable_cat( FALSE, "" )

/* populate data type on data source */
if lstr_drilldown.data_type = "SUBSET" and lstr_drilldown.path <> 'EN' and lstr_drilldown.path <> 'PV'  AND &
	IsValid(ln_cst_stars_rel) AND NOT ln_cst_stars_rel.of_is_ancillary_type(lstr_drilldown.main_inv_type) then // HYL 01/11/06 TRACK 4562d
	idw_source.setitem( ll_source_row, "rb_source", "Subset" )
	This.Event ue_tabpage_source_set_data_type( lstr_drilldown.data_type, lstr_drilldown.subset_id, lstr_drilldown.case_id )
else
	/* setting this should trigger the itemchanged event to set the visiblity of 
	case and subset */
	li_rc = idw_source.setitem(ll_source_row,'rb_source','Base')
end if

idw_source.Object.rb_source.Protect = 1
idw_source.Object.subset_name.Protect = 1

idw_source.getchild('data_source',ldwc_data_source)					// FDG 06/15/98

idw_source.object.data_source [ll_source_row]	=	''					// FDG 06/15/98

idw_available.Reset()															// FDG 06/15/98

/* populate data source in data source dddw */
if lstr_drilldown.path = "AD" then
	/* only load data source with single invoice type unless MC, then load all */
	if ls_inv_type = "MC" then				//02-09-98 FNC
		ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
					+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
					+ "from stars_rel sr, dictionary dt " &
					+ "where sr.id_2 = dt.elem_tbl_type " &
					+ "and sr.rel_type = 'QT' " &
					+ "and dt.elem_type = 'TB'"
	else 
// FNC 03/07/00 Start
		ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
					+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
					+ "from stars_rel sr, dictionary dt " &
					+ "where sr.id_2 = dt.elem_tbl_type	and " &
					+	"sr.id_2 = '" +	Upper( ls_inv_type ) + "' and " &
					+	"dt.elem_type = 'TB'"
// FNC 03/07/00 End
	end if
elseif lstr_drilldown.path = "MC" then
		/* load with all claim types */
		ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
					+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
					+ "from stars_rel sr, dictionary dt " &
					+ "where sr.id_2 = dt.elem_tbl_type	and " &
					+ "sr.rel_type = 'QT' and " &
					+ "dt.elem_type = 'TB'"
else
	/* load single ancillary table */
	//	GaryR	11/21/02	SPR 3187d
	ls_sql = "select sr.id_2, dt.elem_desc, sr.rel_type, " &
				+ "sr.rel_seq, sr.value_n, sr.rel_desc " &
				+ "from stars_rel sr, dictionary dt " &
				+ "where sr.id_2 = dt.elem_tbl_type	and " &
				+ "sr.rel_type = 'AN' and " &
				+ "sr.id_2 = '" + Upper( lstr_drilldown.path ) + "' and " &
				+ "dt.elem_type = 'TB'"
end if
 
ldwc_data_source.reset()
ldwc_data_source.setsqlselect(ls_sql)
li_num_rows = ldwc_data_source.retrieve()

//if li_num_rows < 0 then	//ajs 01/12/99
if li_num_rows <= 0 then	
	MessageBox('Error',&
		'Error retrieving from the Stars_Rel and Dictionary Table in ' &
		+ '~"nu_nvo_source.ue_drilldown_load_new_query"' & 
		+ '~nPlease contact your database administrator.',StopSign!,Ok!)
	return -1
else																// FNC 04/14/99 
	stars2ca.of_commit()										// FNC 04/14/99
end if

idw_source.getchild('add_data_source',ldwc_add_data_source)		// FDG 06/15/98

iuo_query.of_enable_tabpage (ic_list, FALSE)							// FDG 06/15/98
iuo_query.of_enable_tabpage (ic_search, FALSE)						// FDG 06/15/98
iuo_query.of_enable_tabpage (ic_report, FALSE)						// FDG 06/15/98
iuo_query.of_enable_tabpage (ic_view, FALSE)							// FDG 06/15/98
iuo_query.of_enable_tabpage (ic_source, TRUE)						// FDG 06/15/98

iuo_query.Event ue_SelectTab(IC_SOURCE)								//03/02/98 FDG

// FDG 05/20/98 begin
idw_criteria.Reset()															// FDG 06/15/98
ll_criteria_row	=	idw_criteria.InsertRow(0)						// FDG 06/15/98
ls_period_desc		=	iu_period.uf_return_desc()						// FDG 06/15/98
iuo_query.of_set_period_desc (ls_period_desc)						// FDG 05/26/98
iu_period.uf_scroll_to_row ('NONE')										// FDG 06/15/98
// FDG 05/20/98 end

iuo_query.of_set_pd_opt_visibility(FALSE)								// FNC 12/22/99

if lstr_drilldown.path = 'AD' then
	// FDG 02/26/98 begin
	// Find the invoice type in the data source DDDW
	ls_find	=	"stars_rel_id_2 = '"	+	ls_inv_type	+	"'"
	ll_rowcount	=	ldwc_data_source.RowCount()
	ll_row	=	ldwc_data_source.Find (ls_find, 1, ll_rowcount)
	IF	ll_row	<	1		THEN
		ll_row	=	1
	END IF
	ls_data_source	=	ldwc_data_source.GetItemString (ll_row,'compute_0001')
	// 02-24-98 FNC Retrieve additional data source 
	This.event ue_tabpage_source_load_additional_data (ls_inv_type,'')	//	FDG 02/26/98
	idw_source.object.data_source.protect=1		// Protect data source	// FDG 06/15/98
	ldwc_data_source.selectrow(1, True)
	// insert main table into add datasource so can select it for drilldown
	li_row = ldwc_add_data_source.insertrow(0)	
	li_rc =	ldwc_add_data_source.setitem(li_row,'stars_rel_id_2', Left( ls_data_source, 2 ))
	li_rc =	ldwc_add_data_source.setitem(li_row,'dictionary_elem_desc', Trim( Mid( ls_data_source, 5 )))
	idw_source.object.add_data_source.protect=0						// FDG 06/15/98
	ls_microhelp	=	'Please select an additional data source for ' + ls_data_source	// FDG 05/21/98
	w_main.SetMicrohelp (ls_microhelp)		// FDG 05/21/98
else
	// set datasource to 1st row in dddw
	ldwc_add_data_source.reset()
	ldwc_data_source.selectrow(1,True)	
	idw_source.object.data_source.protect=0							// FDG 06/15/98
	ll_row	=	idw_source.GetRow()										// FDG 06/15/98
	//	FDG 03/17/98 begin
	ls_data_source	=	ldwc_data_source.GetItemString (1,'compute_0001')
	idw_source.SetColumn('data_source')									// FDG 06/15/98
	idw_source.SetText(ls_data_source)									// FDG 06/15/98
	idw_source.AcceptText()													// FDG 06/15/98
	// FDG 03/17/98 end
end if
//02-10-98 FNC End

lstr_drilldown.inv_type = ls_inv_type		// FDG 03/17/98

// use the select to load data source dddw on tabpage_source.dw_source
if lstr_drilldown.column_flag then
	iuo_query.event ue_tabpage_report_drilldown_load_cols(lstr_drilldown.columns[])
end if

iuo_query.of_set_istr_drilldown (lstr_drilldown)								// FDG 05/26/98
iuo_query.of_set_drilldown_prev_table (lstr_drilldown.temp_table_name)	// FDG 05/26/98

RETURN 1
end event

event type integer ue_tabpage_source_enable_cat(boolean ab_switch, string as_inv_type);////////////////////////////////////////////////////////////////////////////////////
//
//	This event will either enable or disable the Category drop down.
//	If an invoice type is passed in the default the first matching
//	Category to that data source.
//
////////////////////////////////////////////////////////////////////////////////////
//
//	GaryR		12/20/07	SPR 5199	Add the facility to categorize and sort data sources
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
////////////////////////////////////////////////////////////////////////////////////

Long					ll_rows, ll_row, ll_cat_val, ll_inv_cat
String				ls_cat
DataWindowChild	ldwc_category, ldwc_data_source
n_cst_numerical	lnv_numerical	//Auto instantiated

idw_source.GetChild( "category", ldwc_category )
IF NOT IsValid( ldwc_category ) THEN Return -1

idw_source.GetChild( "data_source", ldwc_data_source )
IF NOT IsValid(ldwc_data_source) THEN Return -1

// Unfilter any filtered data.
ldwc_data_source.SetFilter( "" )
ldwc_data_source.Filter()

//	Remove any rows
ldwc_category.Reset()

IF ab_switch THEN
	// Set the category
	idw_source.object.category.protect = 0
	ldwc_category.SetTransObject( Stars2ca )
	IF ldwc_category.Retrieve() > 0 THEN
		IF Trim( as_inv_type ) > "" THEN
			//	Select the first matching category
			//	for the loaded argument invoice type
			ll_row = ldwc_data_source.Find( "stars_rel_id_2 = '" + &
											as_inv_type + "'", 0, ldwc_data_source.RowCount() )
											
			IF ll_row < 1 THEN
				MessageBox( "ERROR", "Unable to find the Category for invoice type: " &
									+ as_inv_type, StopSign! )
				Return -1
			END IF
			
			//	Get the invoice's category
			ll_inv_cat = ldwc_data_source.GetItemNumber( ll_row, "stars_rel_value_n" )
			
			ll_rows = ldwc_category.RowCount()
			FOR ll_row = 1 TO ll_rows
				//	Match the first Category
				ll_cat_val = ldwc_category.GetItemNumber( ll_row, "value_n" )
				IF lnv_numerical.of_is_bitwise( ll_cat_val, ll_inv_cat ) THEN
					//	Match found, exit
					ls_cat = ldwc_category.GetItemString( ll_row, "rel_desc" )
					ldwc_category.SelectRow( ll_row, TRUE )
					ldwc_category.SetRow( ll_row )
					EXIT
				END IF		
			NEXT
			
			IF IsNull( ls_cat ) OR Trim( ls_cat ) = "" THEN
				MessageBox( "ERROR", "Unable to find the Category description for invoice type: " &
								+ as_inv_type, StopSign! )
				Return -1
			END IF
				
		ELSE
			ls_cat = ldwc_category.GetItemString( 1, "rel_desc" )
			ldwc_category.SelectRow( 1, TRUE )
			ldwc_category.SetRow( 1 )
		END IF
		
		idw_source.object.category[1] = ls_cat
		IF This.event ue_tabpage_source_filter_data_source() < 0 THEN Return -1
		idw_source.object.category.Background.Color = "16777215"
		
		Return 1
	END IF
END IF

//	Disable the Category
idw_source.object.category[1] = "All"
idw_source.object.category.Background.Color = "67108864"
idw_source.object.category.protect = 1

IF This.event ue_tabpage_source_filter_data_source() < 0 THEN Return -1

Return 1
end event

event ue_tabpage_source_get_desc();///////////////////////////////////////////////////////////////////////////////////
//
//	This method will set the description for both the 
//	main and additional data sources as they are selected
//
///////////////////////////////////////////////////////////////////////////////////
//
//	12/21/07	GaryR	SPR 5234	Add descriptions to selected data sources
//
///////////////////////////////////////////////////////////////////////////////////

String				ls_data_source, ls_desc
Integer				li_row, li_find
DataWindowChild	ldwc_data_source, ldwc_add_data_source

idw_source.GetChild( "data_source", ldwc_data_source )
IF NOT IsValid( ldwc_data_source ) THEN Return

idw_source.GetChild( "add_data_source", ldwc_add_data_source )
IF NOT IsValid( ldwc_add_data_source ) THEN Return

li_row = idw_source.GetRow()
IF li_row < 1 THEN Return

// Get the main data source
ls_data_source = idw_source.object.data_source[1]
IF NOT IsNull( ls_data_source ) AND Trim( ls_data_source ) <> "" THEN
	li_find = ldwc_data_source.Find( "compute_0001 = '" + &
											ls_data_source + "'", 0, ldwc_data_source.RowCount() )
	IF li_find > 0 THEN ls_desc = "Data Source: " + &
		ldwc_data_source.GetItemString( li_find, "stars_rel_rel_desc" )
END IF

// Get the additional data source
ls_data_source = idw_source.object.add_data_source[1]
IF NOT IsNull( ls_data_source ) AND Trim( ls_data_source ) <> "" THEN
	li_find = ldwc_add_data_source.Find( "compute_0001 = '" + &
											ls_data_source + "'", 0, ldwc_add_data_source.RowCount() )
	IF li_find > 0 THEN ls_desc += "~n~r~n~rAdditional Data Source: " + &
			ldwc_add_data_source.GetItemString( li_find, "stars_rel_rel_desc" )
END IF

//	Get the Claims Range
IF Upper(Trim(is_source_type)) <> 'AN' AND is_data_type = 'BASE' THEN
	ls_desc += "~n~r~n~rClaims Range: " + iuo_query.tabpage_search.gb_available_claims.text
END IF

idw_source.object.source_desc[1] = ls_desc
idw_source.ResetUpdate()
end event

public function string of_get_mc_desc ();//	GaryR		05/02/08	SPR 5346	Set the description when adding MC or ML artificially

String	ls_desc

SELECT REL_DESC
INTO :ls_desc
FROM STARS_REL
WHERE REL_TYPE = 'QT'
AND ID_2 = 'MC'
USING Stars2ca;

IF Stars2ca.of_check_status() < 0 OR IsNull( ls_desc) THEN ls_desc = ""

Return ls_desc
end function

on u_nvo_source.create
call super::create
end on

on u_nvo_source.destroy
call super::destroy
end on

