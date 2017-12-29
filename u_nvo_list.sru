HA$PBExportHeader$u_nvo_list.sru
$PBExportComments$Inherited from u_nvo_query. <logic>
forward
global type u_nvo_list from u_nvo_query
end type
end forward

global type u_nvo_list from u_nvo_query
event type integer ue_tabpage_list_construct ( ref string as_query_id )
event type integer ue_tabpage_list_create_list ( ref string as_query_id )
event type string ue_tabpage_list_get_selected_query_id ( )
event type integer ue_tabpage_list_query_save_info ( ref sx_query_save asx_query_save )
event ue_tabpage_list_notes ( )
event ue_tabpage_list_delete_query ( )
event type string ue_tabpage_list_get_selected_user_id ( )
event type string ue_tabpage_list_get_selected_case_id ( )
event type string ue_tabpage_list_get_selected_case_spl ( )
event type string ue_tabpage_list_get_selected_case_ver ( )
end type
global u_nvo_list u_nvo_list

type variables
CONSTANT	String	ics_use = 'USE'
string	is_query_engine_mode		//Lahu S
end variables

event type integer ue_tabpage_list_construct(ref string as_query_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_tabpage_list_construct				uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called from the ue_postopen of w_query_engine.  
// It will set dw_search and list dw_list with either the defaults 
// (user_id, business_type & date range) or the PDQ related to 
// query_id passed in or if query_id = 'USE' will set the list to 
// the defaults plus case_id = 'NONE' and common_ind = 'N' only will 
// list non-common independent queries since used to get query id 
// to link to a case.  The range for the 
// default must be retrieved from the SYS_CNTL table.  
// See spec misc-ts176.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//    Value			as_query_id	String				The query id.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success.	
//						-1				Error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/09/97		Created.
//	J.Mattis	02/04/98		Added "cl.link_type = 'PDQ'" to only display PDQ's.
//	FDG		02/10/98		When a query ID is passed to this window, change
//								the d/w object on idw_list instead of changing
//								the SQL.
//	FDG		04/30/98		Track 1095.  Remove references to common.  It
//								is no longer being used.
//	FDG		05/12/98		Track 1223.  Objects moved from window to tabpages.
//								Change li_rowcount to ll_rowcount
// FDG		06/12/98		Track ????.  Call methods in uo_query to set attributes.
// FNC		04/14/99		FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//								to prevent locking.
// Lahu S	12/21/02		Track 2552d - Retrieve Query type dddw with parameter if mode is PDR/PDCR
//								Prevent adding 'ML' query type for PDR/PDCR
//								Set PDR type Default
//	GaryR		02/22/02		Track 2552d	Predefined Report (PDR)
//	GaryR		05/10/04		Track 3756d	Streamline PDR deployment & security
//	GaryR		10/21/04		Track 4089d	Add third tier to PDR report selection
//	GaryR		09/12/05		Track 4444d	Redesign to mimic Master List GUI and functionality
//  RickB  	05/15/09		Added 'AA - All Query Types' to Query Type dropdown.  It wasn't showing
//								after initial load of values.  Also took out repeated ML in 'ML - ML - Multi-Level'.
/////////////////////////////////////////////////////////////////////////////


Long		ll_row, ll_rowcount, ll_scroll_check, ll_pdr_security
String	ls_pdr_cat, ls_sql, ls_qe_mode, ls_aa_check, ls_link_key, ls_link_name

SetPointer(HourGlass!)

datawindowchild ldwc_child  /* will get handle to child */

iuo_query.tabpage_list.uo_range.event ue_initialize()
iuo_query.of_enable_tabpage (ic_list, TRUE)		// FDG 06/12/98

is_query_engine_mode = iuo_query.is_query_engine_mode

IF iw_parent.of_is_pdr_mode() THEN
	idw_list.DataObject	=	"d_pdr_list"
	idw_list.SetTransObject (Stars2ca)	
	
	idw_search.dataobject = "d_pdr_search"
	idw_search.insertrow(0)
	
	// Setup PDR Categories
	idw_search.GetChild( "pdr_cat", ldwc_child )
	ldwc_child.SetTransObject(Stars2ca)
	ll_row = ldwc_child.retrieve()
	ll_row = ldwc_child.InsertRow(1)
	ldwc_child.SetItem(ll_row,1,'AA')		
	ldwc_child.SetItem(ll_row,2,'All PDR Categories')
	ll_row = ldwc_child.Find( "Upper(code_value_a) = 'CASERPT'", 0, ldwc_child.RowCount())
	IF ll_row > 0 THEN
		ls_pdr_cat = ldwc_child.GetItemString( ll_row, "code_code" )
	END IF
	
	// Setup PDR Types
	idw_search.GetChild( "pdr_type", ldwc_child )
	ldwc_child.SetTransObject(Stars2ca)
	
	// Setup PDR Version
	idw_search.GetChild( "pdr_version", ldwc_child )
	ldwc_child.SetTransObject(Stars2ca)
ELSE
	idw_search.insertrow(0)
	idw_search.getchild('query_type',ldwc_child)
	ldwc_child.SetTransObject(Stars2ca)
	ll_row = ldwc_child.retrieve()		
	
	ls_aa_check = ldwc_child.GetItemString(1,1)
	If Upper(Left(ls_aa_check,2)) <> 'AA' Then
		ll_row = ldwc_child.InsertRow(1)
		ldwc_child.SetItem(ll_row,1,'Multi-Level')
		ldwc_child.SetItem(ll_row,2,'ML')
		ll_row = ldwc_child.InsertRow(1)
		ldwc_child.SetItem(ll_row,1,'All Query Types')
		ldwc_child.SetItem(ll_row,2,'AA')
	End If
END IF

//	Initialize UserIds
idw_search.getchild('user_id',ldwc_child)
ldwc_child.SetTransObject(Stars2ca)
ll_row = ldwc_child.retrieve()
ll_row = ldwc_child.InsertRow(1)
ldwc_child.SetItem( ll_row, "cf_name", "< All Users >" )
ldwc_child.SetItem( ll_row, "user_id", "" )

if Not IsNull(as_query_id) &
and trim(as_query_id) <> '' &
and trim(as_query_id) <> ics_use then
	idw_list.DataObject	=	'd_list_query_id'		// FDG 02/10/98
	idw_list.SetTransObject (Stars2ca)				// FDG 02/10/98
	
	//	GaryR	02/22/02	Track 2552d - Begin
	IF iw_parent.of_is_pdr_mode() THEN
		ls_qe_mode = "PDR"
	ELSE
		ls_qe_mode = "PDQ"
	END IF
	
	ll_rowcount = idw_list.Retrieve( as_query_id, ls_qe_mode )
	//	GaryR	02/22/02	Track 2552d - End
	
	if ll_rowcount > 0 then								// FNC 04/14/99
		stars2ca.of_commit()								// FNC 04/14/99
	end if													// FNC 04/14/99
	
	IF iw_parent.of_is_pdr_mode() THEN
		inv_count = Create u_nvo_count
		FOR ll_row = 1 TO ll_rowcount
			//	Apply PDR Security
			ls_link_key = idw_list.object.case_link_link_key[ll_row]
			ls_link_name = idw_list.object.case_link_link_name[ll_row]
			SELECT pdr_cntl.pdr_security
			INTO	:ll_pdr_security
			FROM	pdq_tables, pdr_cntl
			WHERE	pdq_tables.predefined_report = pdr_cntl.pdr_name
			AND	pdq_tables.query_id = :ls_link_key
			USING	Stars2ca;
			
			IF Stars2ca.of_check_status() <> 0 THEN
				MessageBox( "ERROR", "Unable to identify PDR Security for report " + ls_link_name + &
								"~n~rThis report will be filtered from the list", StopSign! )
				idw_list.RowsDiscard (ll_row, ll_row, Primary!)
				ll_row --
				ll_rowcount --
			END IF
		
			IF This.uf_is_pdr_secured( ll_pdr_security ) THEN
				idw_list.RowsDiscard (ll_row, ll_row, Primary!)
				ll_row --
				ll_rowcount --
			END IF
		NEXT
		
		Destroy inv_count
	END IF

	iuo_query.Event	ue_set_count_list()			// FDG 05/12/98
	
	if ll_rowcount <> 1 then
		
		choose case ll_rowcount
			case 0
				//no match error
				RETURN -1
			case is < 0
				//db error
				RETURN -2
			case is > 1
				//logic error (should only have one unique id)
				RETURN -3
		end choose
		
		return 1
		
	end if
	
	/* select the one row */
	
else
	
	/* load with defaults (user_id,business_type,range*/
	if trim(gv_sys_dflt) = '' then  /* must check for business type */
		MessageBox("Error","Line of Business not set.",StopSign!)
		return -4
	end if

	/* set defaults into dw_search and call event to create list*/
	idw_search.object.user_id[1] = gc_user_id
	//Lahu S - begin
	if is_query_engine_mode = "PDQ" then	
		idw_search.object.query_type[1] = 'AA - All Query Types' //gv_sys_dflt
	elseif is_query_engine_mode = "PDR" then
		idw_search.SetColumn( "pdr_cat" )
		idw_search.SetText( "AA" )
	elseif is_query_engine_mode = "PDCR" then
		IF Trim( ls_pdr_cat ) <> "" THEN
			idw_search.SetColumn( "pdr_cat" )
			idw_search.SetText( ls_pdr_cat )
		ELSE
			idw_search.SetColumn( "pdr_cat" )
			idw_search.SetText( "AA" )
		END IF
	end if
	idw_search.AcceptText()
	//Lahu S - End		
		
	idw_list.settransobject(stars2ca)
	this.event ue_tabpage_list_create_list(as_query_id)
end if

RETURN 1
end event

event type integer ue_tabpage_list_create_list(ref string as_query_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_tabpage_list_create_list			uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event will be called by cb_list on 
//	w_query_engine or ue_tabpage_list_construct()
// to list pre-defined queries.  It will take 
//	the information entered into dw_search by 
// the user and create an SQL statement to set 
//	and retrieve dw_list.  The User ID, Query ID
// and Query Description will use a like and 
//	wildcard so will search by the beginning of 
// partial strings.  The query type will use 
//	the two character invoice type in the dddw
// unless it is 'AA' (All Query Types) then it 
//	won' use invoice type.  The date and range 
// will be used together to produce a range 
//	of dates for the creation date.  
// (Must check for valid date and number)  
//	If the common checkbox is checked then will
// only query for common queries.  Finally, 
//	if as_query_id = 'USE' must only list non-common
// independent queries since used to list queries 
//	to link to a case.  Return rowcount so 
// that it can be put into st_count.
//
//	NOTE: This code is very similar to 
//			w_report_template's ue_create_list 
//			event, so any changes made here 
//			should probably be incorporated in
//			that event.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//    Value			as_query_id	String				The query id.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				No match
//						> 0			the row count.				
//						-1				Error.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	12/09/97	Created.
//	J.Mattis	02/04/98	Added "cl.link_type = 'PDQ'" to only display PDQ's.
//	J.Mattis	02/05/98	Added guards against assigning NULLs to SQL string. 
//	J.Mattis	02/06/98	Reversed logic to correct error in guard into get date range f().
//	FDG		02/10/98	Access idw_search by current row
//	FDG		02/27/98	Reset idw_list before re-retrieving it to ensure that
//							the rowfocuschanged event sets the 1st row as current.
//	FDG		03/03/98	Do an Acceptext on every d/w (not just dw_source)
//	FDG		04/01/98	Track 999.  When query id is entered, include link_name
//							instead of link_id in the where clause.
//	FDG		04/07/98	Track 1056. PDQ_CNTL and CASE_LINK must also be joined
//							by user_id and pdq_type.
//	FDG		04/21/98	Track 1096.  Enable/disable the select button based on
//							the # of rows returned.
//	FDG		04/30/98	Track 1095.  Remove references to common_flg.  It
//							is no longer being used.
//	FDG		04/30/98	Track 1156.  Remove any PDQs that belong to a secured
//							case.  Since they can't select them, they shouldn't
//							see them.
//	FDG		05/12/98	Track 1223.  Set the count after retrieving
//	FDG		05/14/98	Track 1232.  Default the range to 0 if cleared out.
// FDG		05/22/98	Track 1267.  Sort the d/w by descending date sequence.
//	FDG		06/30/98	Track 1370.  Sort the d/w by acsending date sequence to
//							be consistant with the rest of Stars.
// FNC		10/28/98	Track 1754. If Description for search contains a
//							single quote put string in double quotes for sql and change
//							any double quotes in string to single quotes. Otherwise use
//							single quotes. Edit for quote in query id.
//	FDG		01/13/99	Track 2047c.  Y2K changes to allow a 4-digit date and range.
// FNC		04/14/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//							to prevent locking.
//	GaryR		01/05/01	Stars 4.7 DataBase Port - Date Conversion and single quotes
//							in the where clause.
//	GaryR		03/19/01	Stars 4.7 DataBase Port - Case Sensitivity
//	FDG		09/21/01	Stars 4.8.1.  Scroll to the 1st row
// Lahu S	12/21/02	Track 2552d Set link type for PDR/PDCR
//	GaryR		08/13/02	Track 3254d	Speed up the PDQ retrieval process
//	GaryR		05/10/04	Track 3756d	Streamline PDR deployment & security
//	GaryR		10/21/04	Track 4089d	Add third tier to PDR report selection
//	GaryR		09/12/05	Track 4444d	Redesign to mimic Master List GUI and functionality
// JasonS	01/08/06 Track 4319d Add message box to notify user that no rows meet criteria, to make
//								 		      it consistent with all other list windows
//	HYL 		01/17/06 Track 4589d Sort in descending order 
//	05/15/09	Katie	GNL.600.5633	Change the SQL for the d_list window to include the case id concatenation.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String	ls_sql, ls_user_id, ls_query_id, ls_query_desc
String	ls_query_type, ls_where, ls_link_key, ls_link_name
String	ls_pdr_cat, ls_pdr_type, ls_pdr_version
String	ls_case_id,	ls_case_spl,	ls_case_ver
string	ls_single_quote, ls_double_quote
Int		li_current_row, li_function_return, li_rc
Integer	li_space_position
Long		ll_row, ll_rowcount,ll_pdr_security
Date		ld_from, ld_thru

n_cst_string	lnvo_cst_string
n_cst_sqlattrib	lnv_sqlattrib[]

ls_single_quote = "'"; ls_double_quote = '"'

//	GaryR	08/13/02	Track 3254d - Begin
String		ls_msg
n_cst_case	lnv_case
//	GaryR	08/13/02	Track 3254d - End

iw_parent.Event	ue_accepttext (iw_parent.control, FALSE)	// FDG 03/03/98

ll_row	=	idw_search.GetRow()							// FDG 02/10/98
IF ll_row	<	1	THEN	Return	-1

ls_user_id = trim(idw_search.object.user_id[ll_row])

ls_query_id = trim(idw_search.object.query_id[ll_row])

ls_query_desc = trim(idw_search.object.description[ll_row])


/* if no criteria entered, give warning message or if only description 
is entered give another warning message  */
//verify that the user id has been populated
If Not(IsNull(ls_user_id)) AND Trim(ls_user_id) <> '' Then 
	// FNC 10/28/98 Start
	if match(ls_user_id,ls_single_quote) or match(ls_user_id,ls_double_quote) then
		Messagebox("Error","User ID cannot contain quotes",StopSign!,Ok!)
		return -1
	end if
	// FNC 10/28/98 End
	ls_where = ls_where + " and cl.user_id like '" + ls_user_id + "%'"
End If
	
//verify that the query id has been populated	
If Not(IsNull(ls_query_id)) AND Trim(ls_query_id) <> '' Then 
	// FNC 10/28/98 Start
	if match(ls_query_id,ls_single_quote) or match(ls_query_id,ls_double_quote) then
		Messagebox("Error","Query ID cannot contain quotes",StopSign!,Ok!)
		return -1
	end if
	// FNC 10/28/98 End
	ls_where = ls_where + " and cl.link_name like '" + ls_query_id + "%'"	// FDG 04/01/98
End If

//verify that the query description has been populated	
If Not(IsNull(ls_query_desc)) AND Trim(ls_query_desc) <> '' Then 	
	// FNC 10/28/98 Start
	if match(ls_query_desc,ls_single_quote) then													
		if match(ls_query_desc,ls_double_quote) then
			ls_query_desc = lnvo_cst_string.of_globalreplace(ls_query_desc,ls_double_quote,ls_single_quote)
		end if
	end if
	
	//	GaryR		03/19/01	Stars 4.7 DataBase Port
	IF ls_query_desc <> "" THEN
		ls_where = ls_where + " and Upper(cl.link_desc) like '%" + Upper(ls_query_desc) + "%'"
	END IF
	// FNC 10/28/98 End
End If

if as_query_id = ics_use then
	ls_where = ls_where + " and cl.case_id = 'NONE'"										// FDG 04/30/98
end if

IF iw_parent.of_is_pdr_mode() THEN
	// PDR specific parameters
	ls_pdr_cat = idw_search.object.pdr_cat[ll_row]
	IF NOT IsNull( ls_pdr_cat ) AND trim( ls_pdr_cat) <> "" AND ls_pdr_cat <> "AA" THEN
		ls_where += " and pdrc.code_code = '" + ls_pdr_cat + "'"
	END IF
	
	ls_pdr_type = idw_search.object.pdr_type[ll_row]
	IF NOT IsNull( ls_pdr_type ) AND trim( ls_pdr_type) <> "" AND ls_pdr_type <> "AA" THEN
		ls_where += " and pdrt.code_code = '" + ls_pdr_type + "'"
	END IF
	
	ls_pdr_version = idw_search.object.pdr_version[ll_row]
	IF NOT IsNull( ls_pdr_version ) AND trim( ls_pdr_version) <> "" AND ls_pdr_version <> "AA" THEN
		ls_where += " and pdr_cntl.pdr_name = '" + ls_pdr_version + "'"
	END IF
ELSE
	//verify that the query type has been populated	and <> 'AA'
	ls_query_type = idw_search.object.query_type[ll_row]
	ls_query_type = left(Upper(Trim(ls_query_type)),2)
	if ls_query_type <> 'AA' AND Not(IsNull(ls_query_type)) AND Trim(ls_query_type) <> '' Then 	
		ls_where = ls_where + " and pc.query_type = '" +ls_query_type+ "'"
	end if
END IF

IF iuo_query.tabpage_list.uo_range.of_get_range( ld_from, ld_thru ) < 0 THEN Return -1
//	GaryR		01/05/01	Stars 4.7 DataBase Port
ls_where = ls_where + " and (cl.link_date between " + &
gnv_sql.of_get_to_date( String( ld_from ) ) + " and " + &
gnv_sql.of_get_to_date( String( ld_thru ) ) + ")"

// Parse the SQL
IF iw_parent.of_is_pdr_mode() THEN
	lnv_sqlattrib[1].s_columns = "cl.user_id,     cl.link_name,      pc.query_type,       cl.link_desc,     cl.link_date,     cl.link_key,     cl.case_id,     cl.case_spl,     cl.case_ver,  cl.case_id||cl.case_spl||cl.case_ver,      pc.addl_query_type,     pdrc.code_desc as PDR_CATEGORY,     pdrt.code_desc as PDR_TYPE,     pdr_cntl.pdr_label"
	lnv_sqlattrib[1].s_tables = "case_link cl,      pdq_cntl pc,     pdq_tables,     pdr_cntl,     code pdrc,     code pdrt"
	lnv_sqlattrib[1].s_where = "cl.link_key = pc.query_id  AND  cl.link_type = 'PDR'   AND  cl.user_id = pc.user_id  AND  pc.pdq_type = 'Q'  AND  pc.query_id = pdq_tables.query_id  AND  pdq_tables.predefined_report = pdr_cntl.pdr_name    AND  pdrc.code_type = 'PDRC'  AND  pdrc.code_code = pc.query_type  AND  pdrt.code_type = 'PDRT'  AND  pdrt.code_code = pc.addl_query_type AND pdrt.code_value_a = pdrc.code_code" + ls_where
ELSE
	lnv_sqlattrib[1].s_columns = "cl.user_id,     cl.link_name,      pc.query_type,       cl.link_desc,     cl.link_date,     cl.link_key,     cl.case_id,     cl.case_spl,     cl.case_ver, cl.case_id||cl.case_spl||cl.case_ver"
	lnv_sqlattrib[1].s_tables = "case_link cl,      pdq_cntl pc"
	lnv_sqlattrib[1].s_where = "cl.link_key = pc.query_id  AND  cl.link_type = 'PDQ'   AND  cl.user_id = pc.user_id  AND  pc.pdq_type = 'Q'" + ls_where
END IF
lnv_sqlattrib[1].s_order = "cl.link_date Desc" //HYL 01/17/06 Track 4589d Sort in descending order
lnv_sqlattrib[1].s_verb = "SELECT"
ls_sql = gnv_sql.of_assemble( lnv_sqlattrib )

idw_list.setsqlselect(ls_sql)

idw_list.Reset()														//	FDG 02/27/98
ll_rowcount = idw_list.retrieve()

if ll_rowcount > 0 then												// FNC 04/14/99
	stars2ca.of_commit()												// FNC 04/14/99
end if																	// FNC 04/14/99

// FDG 04/30/98	begin

// Remove any PDQs that belong to a secured case

// Tell uo_query that a list retrieve is in progress
iuo_query.of_set_list_retrieve (TRUE)

//	GaryR	08/13/02	Track 3254d - Begin
inv_count = Create u_nvo_count
lnv_case	=	CREATE	n_cst_case

FOR	ll_row	=	1	TO	ll_rowcount
	ls_case_id	=	idw_list.object.case_link_case_id	[ll_row]
	ls_case_spl	=	idw_list.object.case_link_case_spl	[ll_row]
	ls_case_ver	=	idw_list.object.case_link_case_ver	[ll_row]
	ls_msg	=	lnv_case.uf_edit_case_security( ls_case_id, ls_case_spl, ls_case_ver )
	
	IF	Len (ls_msg)	>	0		THEN
		// The PDQ is linked to a secured case - remove it.
		idw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
	END IF

	IF NOT iw_parent.of_is_pdr_mode() THEN Continue
	
	//	Apply PDR Security
	ls_link_key = idw_list.object.case_link_link_key[ll_row]
	ls_link_name = idw_list.object.case_link_link_name[ll_row]
	SELECT pdr_cntl.pdr_security
	INTO	:ll_pdr_security
	FROM	pdq_tables, pdr_cntl
	WHERE	pdq_tables.predefined_report = pdr_cntl.pdr_name
	AND	pdq_tables.query_id = :ls_link_key
	USING	Stars2ca;
	
	IF Stars2ca.of_check_status() <> 0 THEN
		MessageBox( "ERROR", "Unable to identify PDR Security for report " + ls_link_name + &
						"~n~rThis report will be filtered from the list", StopSign! )
		idw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
	END IF

	IF This.uf_is_pdr_secured( ll_pdr_security ) THEN
		idw_list.RowsDiscard (ll_row, ll_row, Primary!)
		ll_row --
		ll_rowcount --
	END IF
NEXT

Destroy	lnv_case	
Destroy inv_count
//	GaryR	08/13/02	Track 3254d - End
	
iuo_query.Event	ue_set_count_list()			// FDG 05/12/98

iuo_query.of_set_list_retrieve (FALSE)

// FDG 04/30/98	end

if ll_rowcount = 0 then
	//error - No match.  disable the select button
	iw_parent.wf_enable_select (FALSE)		// FDG 04/21/98
	MessageBox(is_query_engine_mode + " List","No rows meeting criteria")
	return 0
elseif ll_rowcount < 0 then
	//error - database eror
	return -1
end if

//	Rows returned - enable the select button
iw_parent.wf_enable_select (TRUE)		// FDG 04/21/98

// FDG 09/21/01	Insure that the 1st row's rowfocuschanged event triggers
idw_list.ScrollToRow(0)
idw_list.ScrollToRow(1)
idw_list.Event RowFocusChanged (1)

return ll_rowcount
end event

event ue_tabpage_list_get_selected_query_id;call super::ue_tabpage_list_get_selected_query_id;/////////////////////////////////////////////////////////////////////////////
// Event/Function									Object				
//	--------------									------				
//	ue_tabpage_list_get_selected_query_id	u_nvo_list
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Return the link key (query id) from the query list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		String		link_key		The link key from the query list.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/09/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_SelectedRow
String ls_LinkKey

li_SelectedRow = idw_list.GetSelectedRow(0)

//make certain a row is selected
If li_SelectedRow > 0 THEN 
	ls_LinkKey = idw_list.GetItemString&
		(li_SelectedRow,'case_link_link_key')
Else
	MessageBox('Error','Please select a Pre-Defined Query')
	ls_LinkKey= 'Error'
End If
	
RETURN(ls_LinkKey)
end event

event ue_tabpage_list_query_save_info;call super::ue_tabpage_list_query_save_info;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_tabpage_list_query_save_info		uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by w_query_engine.ue_query_save() to get information for the 
// selected query.  First it checks to determine if the query belongs to the user when 
// coming from the save path.  If not gives error message and returns -1.  Then if it is
// a link will check to see make sure the query is independent (can only link independent 
// queries) and not common (cannot link common queries).  Finally it will load the query 
// information from the selected row in dw_list into the sx_query_save structure 
// (defined in ts144 - w_query_save).  This information is passed to w_query_save to 
// display.   
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    Reference	asx_query_save		sx_query_save		The query save structure.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Success.	
//						-1				Save Error - query belongs to another user.
//						-2				Case link dw cantains no data.
//						-3				Query cannot be linked to case.
//						-4				PDQ control table contains no data.
//						-5				Invalid case ID.
//						-6				List dw is empty.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/05/98	Created.
//
//	FDG		03/10/98	Track 914.  Just because there are no selected rows in 
//							idw_list doesn't mean that the query was not previously
//							saved.  All data must be accessed from the PDQ tables.
//							A selected row will have data in the PDQ tables.
//	FDG		04/21/98	Track 1097.  If the query does not belong to the user,
//							open the Save As window instead of displaying an error
//							message.
//	FDG		04/22/98	Track 1105.  The fix to track 1097 must also apply when
//							linking (asx_query_save.path = 'L') a query to a case.
//	FDG		04/30/98	Track 1095.  Remove references to common.  It
//							is no longer being used.
// FNC		07/14/98	Track 1264. Create a datastore to retrieve all case link 
//							records for a query. Now there can be a NONE entry for a
//							query id as well as a link to a case.
// FNC 		07/15/98 Track 1512. Allow user to link query to more than one case.
//							This change modifies the changes for Track 1264. Now all
//							of the case link entries for a query are not required just
//							the case link entry for the active case.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long		ll_Row,		&
			ll_rowcount
			
String	ls_case_link_user_id

n_ds	lds_case_link

ll_rowcount	=	idw_pdq_cntl.RowCount()

IF	ll_rowcount	<	1		THEN
	// No query selected or saved.  Assume 'Save As'
	asx_query_save.path	=	'A'
	Return 0
END IF

ll_rowcount	=	idw_pdq_case_link.RowCount()

IF	ll_rowcount	<	1		THEN
	// No query selected or saved.  Assume 'Save As'
	asx_query_save.path	=	'A'
	Return 0
END IF

ls_case_link_user_id	=	idw_pdq_case_link.object.user_id [1]
	
// FDG 04/21/98 begin - Check this for 'Save' and for 'Link'
//If asx_query_save.path	=	'S'		&
//And gc_user_id				<>	ls_case_link_user_id		Then
IF	gc_user_id				<>	ls_case_link_user_id		Then
	//MessageBox("Error","Unable to save changes to query, does not belong to you.",StopSign!)	
	//Return -1														
	asx_query_save.path	=	'A'
	Return 0
End If
// FDG 04/21/98 end

if asx_query_save.path = 'L' then
// FNC 07/14/98 Start
// FNC 07/15/98 Start
	if idw_pdq_case_link.object.case_id[1] <> 'NONE' then
		MessageBox("Error","May only link independent queries to a case.",StopSign!)
		return -3
	end if
	
// FNC 07/21/98 Start
//	lds_case_link = create n_ds
//	lds_case_link.dataobject = 'd_case_link'
//	lds_case_link.SetTransObject(stars2ca)
//	
//	/*Determine if case link entry for query id and active case exists */
//	ll_row = lds_case_link.retrieve(idw_pdq_case_link.object.link_key[1],ls_case_link_user_id,& 
//				left(gv_active_case,10),mid(gv_active_case,11,2),right(gv_active_case,2))
//	if ll_row = 1 then
//		MessageBox("Error","The query is already linked to the active case.",StopSign!)
//		return -3
//	elseif ll_row < 0 or ll_row > 1 then
//		Messagebox('ERROR','Error retrieving case link entry to determine if ' + &
//					'case already linked in U_NVO_List.UE_Tabpage_List_Query_Save_Info')
//		return -3
//	end if

// FNC 07/21/98
		
//	FNC 07/14/98 End
// FNC 07/15/98 End

// FDG 04/30/98 begin
//	if idw_pdq_cntl.object.common_ind[1] = 'Y' then
//		MessageBox("Error","This is a common query, cannot link to a case.",StopSign!)
//		return -3
//	end if
	// FDG 04/30/98 end
	
end if



//asx_query_save.common_flg	=	idw_pdq_cntl.object.common_ind[1]		// FDG 04/30/98
asx_query_save.query_id		=	idw_pdq_case_link.object.link_key[1]
asx_query_save.query_name	=	idw_pdq_case_link.object.link_name[1]
asx_query_save.query_desc	=	idw_pdq_case_link.object.link_desc[1]
asx_query_save.case_id		=	idw_pdq_case_link.object.case_id[1] + &
										idw_pdq_case_link.object.case_spl[1] + &
										idw_pdq_case_link.object.case_ver[1]

//check if any nulls exist 
If IsNull(asx_query_save.case_id) OR Trim(asx_query_save.case_id) = '' Then 
	MessageBox("Error","The case id is invalid.",StopSign!)
	RETURN -5
Else
	If Upper(Trim(asx_query_save.case_id)) = 'NONE' THEN
		asx_query_save.link = 'NONE'
	Else
		asx_query_save.link = 'CASE'
	End If
End If


Return 0
end event

event ue_tabpage_list_notes;call super::ue_tabpage_list_notes;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_tabpage_list_notes					uo_Query
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// This event is called by im_list.m_notes to open the Notes List window populated with 
// the PDQ information.  Must pass the PDQ id, PDQ create date and related_type (PQ), this 
// is old code so they put into globals.  Note:  Saving Notes related to PDQ's is new to 
// the system so changes need to be made to the Notes functionality.  Must add a new note 
// type (PQ) and reference it in the code.   See spec ts145 - Note List.doc.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	01/05/98		Created.
//
//	FDG		04/20/98		Track 1075.  Get globals from idw_pdq_case_link
//								if data exists.  It's possible to select a PDQ,
//								highlight another PDQ before RMM - Notes.
//
//	FDG		04/20/98		Track 1093.  Get link_key instead of link_name.
//								Link key is unique - not link name.
//
// NLG		05-12-98		1. Replace notes globals with notes nvo.  
//								2. Use link name rather than link key for note_rel_id
// NLG		05-18-98		1. If case-linked pdq, advise user note will be 
//									attached to case, not pdq
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long ll_Row
integer li_rc

ll_row	=	idw_pdq_case_link.RowCount()		// Should be one row

//IF	ll_row	>	0			THEN
//	gv_notes_from		=	'PQ'
//	gv_from				=	'A'
//	gv_notes_rel_name	=	idw_pdq_case_link.object.link_key [ll_row]
//	gv_notes_date		=	Date(idw_pdq_case_link.object.link_date [ll_row])
//	opensheet (w_notes_list, MDI_Main_frame, Help_menu_position, Layered!)
//ELSE
//	ll_row					=	idw_List.GetRow()
//	If ll_Row				>	0		Then
//		gv_notes_from 		=	'PQ'
//		gv_from				=	'A'
//		gv_notes_rel_name =	idw_list.object.case_link_link_key[ll_Row]
//		gv_notes_date		=	Date(idw_list.object.case_link_link_date[ll_Row])
//		opensheet (w_notes_list, MDI_Main_frame, Help_menu_position, Layered!)
//	End If
//END IF

n_cst_notes lnv_notes

IF	ll_row	>	0			THEN
	if idw_pdq_case_link.object.case_id [ll_row] = 'NONE' then		
		lnv_notes.is_notes_rel_id =	idw_pdq_case_link.object.link_name [ll_row]
		lnv_notes.idt_notes_date =	Date(idw_pdq_case_link.object.link_date [ll_row])
		lnv_notes.is_notes_rel_type = 'PQ'
	else
		li_rc = Messagebox("NOTES","Note will be attached to the case, not the query."+&
								"~rDo you want to view or add case notes?",exclamation!,YesNo!)
		if li_rc = 2 then return
		//NLG 6-3-98 																				start***
		//lnv_notes.is_notes_rel_id = idw_pdq_case_link.object.case_id [ll_row]
		string ls_case_id 
		ls_case_id = idw_pdq_case_link.object.case_id [ll_row] +&
									idw_pdq_case_link.object.case_spl [ll_row] +&
									idw_pdq_case_link.object.case_ver [ll_row]
		lnv_notes.is_notes_rel_id = ls_case_id
		//NLG 6-3-98																				stop*****
		
		lnv_notes.idt_notes_date = Date(idw_pdq_case_link.object.link_date [ll_row])
		lnv_notes.is_notes_rel_type = 'CA'
	end if
ELSE
		ll_row					=	idw_List.GetRow()
		If ll_Row				>	0		Then
			if idw_list.object.case_link_case_id[ll_Row] = 'NONE' then
				lnv_notes.is_notes_rel_id =	idw_list.object.case_link_link_name[ll_Row]
				lnv_notes.idt_notes_date	=	Date(idw_list.object.case_link_link_date[ll_Row])
				lnv_notes.is_notes_rel_type = 'PQ'
			else
				li_rc = Messagebox("NOTES","Note will be attached to the case, not the query."+&
								"~rDo you want to add a case note?",exclamation!,YesNo!)
				if li_rc = 2 then return
				//NLG 6-3-98																     start*******
				//lnv_notes.is_notes_rel_id =	idw_list.object.case_link_case_id[ll_Row]
				ls_case_id = idw_list.object.case_link_case_id[ll_Row] +&
									idw_list.object.case_link_case_spl[ll_Row] +&
									idw_list.object.case_link_case_ver[ll_Row]
				lnv_notes.is_notes_rel_id =	ls_case_id
				//NLG 6-3-98																		stop*******
				lnv_notes.idt_notes_date	=	Date(idw_list.object.case_link_link_date[ll_Row])
				lnv_notes.is_notes_rel_type = 'CA'
			end if	
		End If
END IF

gv_from	=	'A'
lnv_notes.is_notes_from	=	'PQ'
opensheetwithParm(w_notes_list,lnv_notes,MDI_Main_frame,Help_menu_position,Layered!)
end event

event ue_tabpage_list_delete_query();/////////////////////////////////////////////////////////////////////////////
// Event/Function					Object				
//	--------------					------				
//	ue_tabpage_list_delete		uo_query
//
//	Description
//	-----------
// This event is called by im_list.m_delete to delete a query from the system.  First 
// must determine if the user owns the query or if the user has Administrator privileges.
// If so, must delete any entries for that query id in the case link table and set the 
// delete indicator on the pdq_cntl table.  Then delete the entry from dw_list..
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			DataType			Description
//		---------	--------			--------			-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
// 	None.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	JTM		01/07/98		Created.
//	FDG		04/06/98		Track 967.  Change the security error message to make
//								it more user friendly.
//	FDG		04/22/98		Track 1104.  If the hi-lited row matches the current
//								PDQ, disable the other tabs.
//	FDG		05/28/98		Track 1246.  Commit not correct.  The 'Where' criteria
//								for case_link and pdq_cntl are incomplete.
// FDG		06/12/98		Track ????.  Call methods in uo_query to set attributes.
//
// FNC		06/16/98		Track 1316. Display pdq name in delete warning message.
//
// FNC		11/04/98		Track 1941. If pdq is independent delete any notes 
//								associated with query.
// FNC	04/14/99			FS/TS2162 Starcare track 2162. Move commit to end of 
//								script so it is after logical unit of work.
// Lahu s 2/22/02 		Track 2552d check mode for query delete
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long		ll_selectedrow,	&
			ll_rowcount
String	ls_query_id, 		&
			ls_sql,				&
			ls_select_userid,	&
			ls_query_desc,		&
			ls_query_name,		&
			ls_curr_queryid,	&
			ls_case_id
Integer	li_rc

ll_selectedrow = idw_list.GetSelectedRow(0)

IF ll_selectedrow <	1 Then
	Return
END IF
	
ls_select_userid	=	idw_list.object.case_link_user_id[ll_selectedrow]

if gc_user_id		=	ls_select_userid			&
OR gv_user_sl		=	'AD'							then
	
	ls_query_id = this.event ue_tabpage_list_get_selected_query_id()
	ls_curr_queryid	=	iw_parent.Event	ue_get_current_query_id()		// FDG 04/22/98
	ls_query_desc = Trim(idw_list.object.case_link_link_desc[ll_selectedrow])
	ls_query_name = Trim(idw_list.object.case_link_link_name[ll_selectedrow])	// FNC 06/16/98
	ls_case_id = Trim(idw_list.object.case_link_case_id[ll_selectedrow])	// FNC 11/04/98
	
	// FNC 06/16/98
	If MessageBox("Delete","Are you sure you want to delete ~r~nQuery ID =  " + &
			ls_query_name + '~r~nDescription = ' + ls_query_desc + "?",Question!,YesNo!) = 1 Then	
		
		//	FDG 05/28/98 - include pdq_type in the where clause.
		ls_sql = "update pdq_cntl set delete_ind = 'Y' where query_id = '" +&
					Upper( ls_query_id ) + "' and pdq_type = 'Q'"
					
		li_rc		=	Stars2ca.of_execute (ls_sql)
		IF	li_rc	<	0		THEN
			MessageBox ('Application Error', 'Could not update pdq_cntl in script ' + &
							'u_nvo_list.ue_tabpage_list_delete_query')
			Stars2ca.of_rollback()
			Return
		END IF
		
		if is_query_engine_mode = "PDQ" then
			ls_sql = "delete from case_link where link_key = '" + Upper( ls_query_id )  +&
						"' and link_type = 'PDQ'"
		//Lahu S 2/22/01 begin						
		else
			ls_sql = "delete from case_link where link_key = '" + Upper( ls_query_id )  +&
						"' and link_type = 'PDR'"
		end if
		//Lahu S 2/22/01 end		
		li_rc		=	Stars2ca.of_execute (ls_sql)
		IF	li_rc	<	0		THEN
			MessageBox ('Application Error', 'Could not delete case_link in script ' + &
							'u_nvo_list.ue_tabpage_list_delete_query')
			Stars2ca.of_rollback()			// FDG 05/28/98
			Return
//		ELSE										// FNC 04/14/99
//			Stars2ca.of_commit()				// FNC 04/14/99 FDG 05/28/98
		END IF
		
		// FNC 11/04/98 Start
		ls_sql = "delete from notes where note_rel_type = 'PQ' " + &
					"and note_rel_id = '" + Upper( ls_query_name ) + "'"
					
		li_rc		=	Stars2ca.of_execute (ls_sql)
		IF	li_rc	<	0		THEN
			MessageBox ('Application Error', 'Could not delete notes in script ' + &
							'u_nvo_list.ue_tabpage_list_delete_query')
			Stars2ca.of_rollback()
			Return
//		ELSE											// FNC 04/14/99
//			Stars2ca.of_commit()					// FNC 04/14/99
		END IF
		// FNC 11/04/98 End
		
		idw_list.deleterow(ll_selectedrow)
		
		// FDG 04/22/98 begin
		// If the selected PDQ = Current PDQ, then the current PDQ no longer
		//	exists.  Reset the window to reflect this.
		IF	ls_query_id		=	ls_curr_queryid		THEN
			iuo_query.of_enable_tabpage (ic_source, FALSE)		// FDG 06/12/98
			iuo_query.of_enable_tabpage (ic_search, FALSE)		// FDG 06/12/98
			iuo_query.of_enable_tabpage (ic_report, FALSE)		// FDG 06/12/98
			iuo_query.of_enable_tabpage (ic_view, FALSE)			// FDG 06/12/98
			//iuo_query.tabpage_source.enabled		=	FALSE
			//iuo_query.tabpage_search.enabled		=	FALSE
			//iuo_query.tabpage_report.enabled		=	FALSE
			//iuo_query.tabpage_view.enabled		=	FALSE
			iw_parent.wf_resettitle()
			ll_rowcount	=	idw_list.RowCount()
			IF	ll_rowcount	>	0				THEN
				idw_list.ScrollToRow (1)
				idw_list.SelectRow (0, FALSE)
				idw_list.SelectRow (1, TRUE)
			ELSE
				iw_parent.wf_enable_select (FALSE)
			END IF
		END IF
		//	FDG 04/22/98 end
		
	End If
	
	stars2ca.of_commit()						// FNC 04/14/99 
		
else
	//messagebox("Error","Query does not belong to you - cannot delete.",StopSign!)		// FDG 04/06/98
	messagebox("Error","This query cannot be deleted because it belongs to another user.",StopSign!)		// FDG 04/06/98
	Return
end if

end event

event ue_tabpage_list_get_selected_user_id;call super::ue_tabpage_list_get_selected_user_id;/////////////////////////////////////////////////////////////////////////////
// Event/Function									Object				
//	--------------									------				
//	ue_tabpage_list_get_selected_user_id	n_nvo_list
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Return the user id from the query list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		String		user id		The user id from the query list.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/19/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_SelectedRow
String ls_UserId

li_SelectedRow = idw_list.GetSelectedRow(0)

//make certain a row is selected
If li_SelectedRow > 0 THEN 
	ls_UserId = idw_list.GetItemString&
		(li_SelectedRow,'case_link_user_id')
Else
	MessageBox('Error','Please select a Pre-Defined Query')
	ls_UserId = 'Error'
End If
	
RETURN(ls_UserId)
end event

event ue_tabpage_list_get_selected_case_id;call super::ue_tabpage_list_get_selected_case_id;/////////////////////////////////////////////////////////////////////////////
// Event/Function									Object				
//	--------------									------				
//	ue_tabpage_list_get_selected_case_id	u_nvo_list
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Return the link key (case id) from the query list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		String		case id		The case id from the query list.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/19/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_SelectedRow
String ls_CaseId

li_SelectedRow = idw_list.GetSelectedRow(0)

//make certain a row is selected
If li_SelectedRow > 0 THEN 
	ls_CaseId = idw_list.GetItemString&
		(li_SelectedRow,'case_link_case_id')
Else
	MessageBox('Error','Please select a Pre-Defined Query')
	ls_CaseId= 'Error'
End If
	
RETURN(ls_CaseId)
end event

event ue_tabpage_list_get_selected_case_spl;call super::ue_tabpage_list_get_selected_case_spl;/////////////////////////////////////////////////////////////////////////////
// Event/Function									Object				
//	--------------									------				
//	ue_tabpage_list_get_selected_case_spl	u_nvo_list
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Return the case spl from the query list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		String		case spl		The case spl from the query list.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/20/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_SelectedRow
String ls_CaseSpl

li_SelectedRow = idw_list.GetSelectedRow(0)

//make certain a row is selected
If li_SelectedRow > 0 THEN 
	ls_CaseSpl = idw_list.GetItemString&
		(li_SelectedRow,'case_link_case_spl')
Else
	MessageBox('Error','Please select a Pre-Defined Query')
	ls_CaseSpl= 'Error'
End If
	
RETURN(ls_CaseSpl)
end event

event ue_tabpage_list_get_selected_case_ver;call super::ue_tabpage_list_get_selected_case_ver;/////////////////////////////////////////////////////////////////////////////
// Event/Function									Object				
//	--------------									------				
//	ue_tabpage_list_get_selected_case_ver	u_nvo_list
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Return the case ver from the query list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		String		case ver		The case ver from the query list.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/20/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer li_SelectedRow
String ls_CaseVer

li_SelectedRow = idw_list.GetSelectedRow(0)

//make certain a row is selected
If li_SelectedRow > 0 THEN 
	ls_CaseVer = idw_list.GetItemString&
		(li_SelectedRow,'case_link_case_ver')
Else
	MessageBox('Error','Please select a Pre-Defined Query')
	ls_CaseVer= 'Error'
End If
	
RETURN(ls_CaseVer)
end event

on u_nvo_list.create
call super::create
end on

on u_nvo_list.destroy
call super::destroy
end on

