$PBExportHeader$uo_cst_queryengine.sru
$PBExportComments$Builds the structure to be passed to w_query_engine (inherited from n_base). <logic>
forward
global type uo_cst_queryengine from n_base
end type
end forward

global type uo_cst_queryengine from n_base
end type
global uo_cst_queryengine uo_cst_queryengine

type variables
Protected	sx_query_engine_parms  istr_query_parms
Protected	String	is_invoice_type
Protected	String	is_src_type
Protected	String	is_tbl_type
Protected String	is_tbl_rel
Protected String	is_rpt_title

Protected Integer	ii_level_num = 1

Constant	String	ics_use = 'USE'





end variables

forward prototypes
public subroutine uf_clear_query_parms ()
public subroutine uf_set_invoice_type (ref string as_invoice_type)
public function string uf_get_invoice_type ()
public subroutine uf_set_src_type (string as_src_type)
public function string uf_get_src_type ()
public subroutine uf_set_subset_id (string as_subset_id)
public function string uf_get_subset_id ()
public function string uf_get_query_id ()
public subroutine uf_set_authorization_id (ref string as_authorization_id)
public function string uf_get_authorization_id ()
public subroutine uf_load_where (string as_left_paren, string as_tbl_type, string as_variable, string as_operator, string as_value, string as_right_paren, string as_connect, ref integer ai_index)
public subroutine uf_set_tbl_type (string as_tbl_type)
public subroutine uf_set_tbl_rel (string as_tbl_rel)
public subroutine uf_set_level (integer ai_level_num)
public subroutine uf_set_rpt_title (string as_rpt_title)
public subroutine uf_set_subset_name (string as_subset_name)
public function integer uf_set_sxqueryengineparms (readonly sx_query_engine_parms asx_query_engine_parms)
public function sx_query_engine_parms uf_get_sx_query_engine_parms ()
public function integer uf_get_period_key ()
public subroutine uf_set_query_key (integer ai_period_key)
public subroutine uf_set_period_key (integer ai_period_key)
public function string uf_get_period_function ()
public subroutine uf_set_period_function (string as_period_function)
public function integer uf_get_min_max_date (ref datetime adt_min_dt, ref datetime adt_max_dt)
public subroutine uf_set_query_id (string as_query_id)
public function string uf_get_query_engine_mode ()
public subroutine uf_set_query_engine_mode (string as_query_engine_mode)
public subroutine uf_open_query_engine ()
end prototypes

public subroutine uf_clear_query_parms ();//////////////////////////////////////////////////////////////////
//	Script:	uf_clear_query_parms
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function clears istr_query_parms in case w_query_engine
//		gets invoked multiple times from the same window.
//////////////////////////////////////////////////////////////////
//	History:
//
//	???	01/08/98	Created
//
//////////////////////////////////////////////////////////////////

sx_query_engine_parms	lstr_query_parms

istr_query_parms	  =  lstr_query_parms

// Clear the global criteria variables
clear_crit_globals()


end subroutine

public subroutine uf_set_invoice_type (ref string as_invoice_type);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_invoice_type
//
//	Arguments:	as_invoice_type
//
//	Returns:		None
//
//	Description:
//		This function saves the invoice type so it can be eventually passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

is_invoice_type = as_invoice_type
end subroutine

public function string uf_get_invoice_type ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_invoice_type
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function returns the invoice type previously saved in
//		uf_set_invoice_type.
//////////////////////////////////////////////////////////////////
//	History:
//
//	???	01/08/98	Created
//
//////////////////////////////////////////////////////////////////

Return is_invoice_type
end function

public subroutine uf_set_src_type (string as_src_type);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_src_type
//
//	Arguments:	as_src_type
//
//	Returns:		None
//
//	Description:
//		This function saves the src type so it can be eventually passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

is_src_type = as_src_type
end subroutine

public function string uf_get_src_type ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_src_type
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function returns the src type previouisly saved by
//		uf_set_src_type.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

Return is_src_type
end function

public subroutine uf_set_subset_id (string as_subset_id);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_subset_id
//
//	Arguments:	as_subset_id
//
//	Returns:		None
//
//	Description:
//		This function saves the subset ID so it can be passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

istr_query_parms.subset_id = as_subset_id
end subroutine

public function string uf_get_subset_id ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_subset_id
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function returns the subset ID previouisly saved by
//		uf_set_subset_id.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

Return istr_query_parms.subset_id
end function

public function string uf_get_query_id ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_query_id
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function returns the query ID previouisly saved by
//		uf_set_query_id.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

Return	istr_query_parms.query_id
end function

public subroutine uf_set_authorization_id (ref string as_authorization_id);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_authorization_id
//
//	Arguments:	as_authorization_id
//
//	Returns:		None
//
//	Description:
//		This function saves the authorization ID so it can be passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

istr_query_parms.authorization_id	=	as_authorization_id
end subroutine

public function string uf_get_authorization_id ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_authorization_id
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function returns the subset id previously saved in
//		uf_set_authorization_id.
//////////////////////////////////////////////////////////////////
//	History:
//
//	???	01/08/98	Created
//
//////////////////////////////////////////////////////////////////


Return	istr_query_parms.authorization_id
end function

public subroutine uf_load_where (string as_left_paren, string as_tbl_type, string as_variable, string as_operator, string as_value, string as_right_paren, string as_connect, ref integer ai_index);//////////////////////////////////////////////////////////////////
//	Script:	uf_load_where
//
//	Arguments:	as_left_paren
//					as_tbl_type
//					as_variable
//					as_operator
//					as_value
//					as_right_paren
//					as_connect
//					ai_index  (by reference)
//
//	Returns:		None
//
//	Description:
//		This function replaces global function fx_load_crit_globals()
//		and will parse a section of a "WHERE" clause into
//		istr_query_parms.criteria.  The WHERE clause passed to this
//		function will be broken up into its components.
//
//	Note:
//		This function sets global variables gv_left_paren, gv_exp1,
//		gv_op, gv_exp2, gv_right_paren.  After the 4.0 changes are
//		made, the use of the globals should be evaluated.  If this
//		is the only script that uses these globals, then they can
//		be removed from this function and from the list of globals.
//
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//	FDG	02/10/98	When parsing as_variable, as_tbl_type is set
//						to the 1st 2 positions (not the 1st 3)
//
//	FDG	05/01/98	Track 1173.  The 2nd to last criteria is not
//						getting an 'AND' in the logical_op.  The last
//						'AND' will be removed when opening
//						w_query_engine
//
//////////////////////////////////////////////////////////////////

String	ls_single_entry,  &
			ls_tbl_type,   &
			ls_col_name
Int 		li_position
Boolean	lb_first_time = TRUE

if as_operator = 'LIKE' &
or as_operator = 'NOT LIKE' then
	//  Strip off the % from 'LIKE' operations, because the 'WHERE' function puts it on later.
	if match(as_value,',') = TRUE then
		do while match(as_value,',') OR as_value <> ''
			//Grabs each part separated by the comma//
			li_position = pos(as_value,',')
			if li_position = 0 and as_value <> '' Then
				ls_single_entry = as_value
				as_value = ''
			else
				ls_single_entry = left(as_value,li_position - 1)
				if right(ls_single_entry,1) = '%' then
				    ls_single_entry = mid(ls_single_entry,1,len(ls_single_entry) -1)
				end if
				as_value = mid(as_value,li_position + 1)
			end if
			if lb_first_time = TRUE then
				istr_query_parms.criteria[ai_index].col_value = upper(ls_single_entry)
				gv_exp2[ai_index] = upper(ls_single_entry)
				lb_first_time = FALSE
			else
				istr_query_parms.criteria[ai_index].col_value =  &
				istr_query_parms.criteria[ai_index].col_value +  &
				',' + upper(ls_single_entry)
				gv_exp2[ai_index] = gv_exp2[ai_index] + ',' + upper(ls_single_entry)
			end if

		LOOP	
		as_value = istr_query_parms.criteria[ai_index].col_value
	end if

end if

// If the table type was not passed, attempt to "unattach" it from as_variable
IF IsNull(as_tbl_type) &
OR Trim(as_tbl_type)  < ' '   THEN
	// table type was not passed.  See if it can be unattached
	li_position  =  Pos (as_variable, '.')  // Find the '.'
	IF  li_position  >  0  THEN
		// Period found, unattach the table type from the variable
		//as_tbl_type  =  Left (as_variable, li_position)		// FDG 02/10/98
		as_tbl_type  =  Left (as_variable, li_position - 1)	// FDG 02/10/98
		as_variable  =  Mid  (as_variable, li_position + 1)
	END IF
END IF

istr_query_parms.criteria[ai_index].query_id		=  This.uf_get_query_id()
istr_query_parms.criteria[ai_index].level_num	=  ii_level_num
istr_query_parms.criteria[ai_index].seq_num		=  ai_index
istr_query_parms.criteria[ai_index].tbl_type		=  upper(as_tbl_type)
istr_query_parms.criteria[ai_index].left_paren	=	as_left_paren
istr_query_parms.criteria[ai_index].col_name		=	upper(as_variable)
istr_query_parms.criteria[ai_index].rel_op		=	upper(as_operator)
istr_query_parms.criteria[ai_index].col_value	=	upper(as_value)
istr_query_parms.criteria[ai_index].right_paren	=	as_right_paren
istr_query_parms.criteria[ai_index].logic_op		=	as_connect				// FDG 05/01/98

gv_left_paren[ai_index]		=	as_left_paren
gv_op[ai_index]				=	upper(as_operator)
gv_exp2[ai_index]				=	upper(as_value)
gv_right_paren[ai_index]	=	as_right_paren
gv_logic[ai_index]			= 	as_connect											// FDG 05/01/98
// If the table type was passed, attach it to the variable (gv_exp1)
IF Trim(as_tbl_type)  > ' '   THEN
	gv_exp1[ai_index] = upper(as_tbl_type)  + '.'  + upper(as_variable)
ELSE
	gv_exp1[ai_index] = upper(as_variable)
END IF

// FDG 05/01/98 - remove
//  Do Not add connector operator to prior clause if 1st clause of the where.
//if as_connect <> '' &
//and (ai_index - 1) > 0 Then
//	istr_query_parms.criteria[ai_index - 1].logic_op = upper(as_connect)
//	gv_logic[ai_index - 1] = upper(as_connect)
//end if 

//istr_query_parms.criteria[ai_index].logic_op = ''		// FDG 05/01/98
//gv_logic[ai_index] = ''											// FDG 05/01/98

//  local variable in the calling script is updated by adding 1. (by reference)
ai_index++

end subroutine

public subroutine uf_set_tbl_type (string as_tbl_type);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_tbl_type
//
//	Arguments:	as_tbl_type
//
//	Returns:		None

//
//	Description:
//		This function saves the tbl type so it can be eventually passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FDG	01/28/98	Created
//
//////////////////////////////////////////////////////////////////


is_tbl_type	=	as_tbl_type
end subroutine

public subroutine uf_set_tbl_rel (string as_tbl_rel);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_tbl_rel
//
//	Arguments:	as_tbl_type
//
//	Returns:		None
//
//	Description:
//		This function saves the tbl rel so it can be eventually passed
//		w_query_engine.  Most of the time, either 'GP' or '' will
//		be passed.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FDG	01/28/98	Created
//
//////////////////////////////////////////////////////////////////


is_tbl_rel	=	as_tbl_rel
end subroutine

public subroutine uf_set_level (integer ai_level_num);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_level
//
//	Arguments:	ai_level_num
//
//	Returns:		None
//
//	Description:
//		This function saves the level # so it can be eventually passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FDG	01/29/98	Created
//
//////////////////////////////////////////////////////////////////


ii_level_num	=	ai_level_num

end subroutine

public subroutine uf_set_rpt_title (string as_rpt_title);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_rpt_title
//
//	Arguments:	as_rpt_title
//
//	Returns:		None
//
//	Description:
//		This function saves the report title so it can be eventually passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FDG	01/29/98	Created
//
//////////////////////////////////////////////////////////////////


is_rpt_title	=	as_rpt_title
end subroutine

public subroutine uf_set_subset_name (string as_subset_name);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_subset_name
//
//	Arguments:	as_subset_name
//
//	Returns:		None
//
//	Description:
//		This function saves the subset name so it can be passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

istr_query_parms.subset_name = as_subset_name

end subroutine

public function integer uf_set_sxqueryengineparms (readonly sx_query_engine_parms asx_query_engine_parms);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function					Access	
// ------						--------------					------	
//	uo_cst_queryengine		uf_Set_SxQueryEngineParms	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Assign the structure to be passed into w_query_engine.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument						Datatype						Description
//	---------	--------						--------						-----------
//	ReadOnly		asx_query_engine_parms	sx_query_engine_parms	Query engine parameters.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/11/98		Created.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

istr_query_parms = asx_query_engine_parms

RETURN 1
end function

public function sx_query_engine_parms uf_get_sx_query_engine_parms ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function					Access	
// ------						--------------					------	
//	uo_cst_queryengine		uf_Get_SxQueryEngineParms	Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Return the structure passed into w_query_engine.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument						Datatype						Description
//	---------	--------						--------						-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype						Value			Description
//	--------						-----			-----------
//	sx_query_engine_parms					The current value of the query engine parms. structure.			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/11/98		Created.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

RETURN istr_query_parms
end function

public function integer uf_get_period_key ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_period_key
//
//	Arguments:	None
//
//	Returns:		period key
//
//	Description:
//		This function returns the period key previously saved by
//		uf_set_period_key.
//////////////////////////////////////////////////////////////////
//	History:
//
//	AJS	07/29/98	Created
//
//////////////////////////////////////////////////////////////////

Return istr_query_parms.period_key
end function

public subroutine uf_set_query_key (integer ai_period_key);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_period_key
//
//	Arguments:	ai_period_key
//
//	Returns:		None
//
//	Description:
//		This function saves the period key so it can be passed
//		w_period_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	AJS	07/29/98	Created
//
//////////////////////////////////////////////////////////////////

istr_query_parms.period_key	=	ai_period_key
end subroutine

public subroutine uf_set_period_key (integer ai_period_key);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_period_key
//
//	Arguments:	ai_period_key
//
//	Returns:		None
//
//	Description:
//		This function saves the period key so it can be passed
//		w_period_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	AJS	07/29/98	Created
//
//////////////////////////////////////////////////////////////////
istr_query_parms.period_key	=	ai_period_key
end subroutine

public function string uf_get_period_function ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_period_function
//
//	Arguments:	None
//
//	Returns:		period function 
//
//	Description:
//		This function returns the period function previously saved by
//		uf_set_period_function.
//////////////////////////////////////////////////////////////////
//	History:
//
//	AJS	07/29/98	Created
//
//////////////////////////////////////////////////////////////////

Return istr_query_parms.period_function
//
end function

public subroutine uf_set_period_function (string as_period_function);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_period_function
//
//	Arguments:	as_period_function
//
//	Returns:		None
//
//	Description:
//		This function saves the period function so it can be passed
//		w_period_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	AJS	07/29/98	Created
//
//////////////////////////////////////////////////////////////////
istr_query_parms.period_function	=	as_period_function
end subroutine

public function integer uf_get_min_max_date (ref datetime adt_min_dt, ref datetime adt_max_dt);//////////////////////////////////////////////////////////////////
//	Script:	uf_get_min_max_date
//
//	Arguments:	adt_min_dt - Passed by reference
//					adt_max_dt - Passed by reference
//
//	Returns:		None
//
//	Description:
//		This function retrieves the min and max date from the Ros_Directory
//		utilizing a datastore. It is called from the query engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//	FDG	03/19/98	Track 944.  Destroy all created objects.
// FNC	04/15/99	FS/TS2162 Starcare track 2162. Add commits after executing SQL  
//						to prevent locking.
//	FDG	03/13/01	Stars 4.7.  Remove ros_directory and retrieve from
//						claims_range_cntl	instead.
//	GaryR	05/29/01	Stars 4.7	Rename table CLAIMS_RANGE_CNTL to CLAIMS_CNTL
//	GaryR	06/07/01	Stars 4.7	Move CLAIMS_CNTL from Stars2 to Stars1
//
//////////////////////////////////////////////////////////////////

Integer li_rc, li_rows

// FDG 03/13/01 begin
//n_ds	lds_get_min_max_date
//
//lds_get_min_max_date = create n_ds
//
//lds_get_min_max_date.dataobject = 'D_Get_Min_Max_Date'
//li_rc = lds_get_min_max_date.SetTransObject(Stars1ca)
//
//if li_rc <> 1 then
//	messagebox('Error','Cannot retrieve min/max claim date. Error in SetTransObject')
//	Destroy	lds_get_min_max_date					// FDG 03/19/98
//	return -1
//end if
//
//li_rows = lds_get_min_max_date.Retrieve()
//
//if li_rows < 0 then
//	MessageBox('Error', 'Error retrieving subset name')
//	Destroy	lds_get_min_max_date					// FDG 03/19/98
//	Return -1
//else
//	stars1ca.of_commit()								// FNC 04/15/99
//	adt_min_dt = lds_get_min_max_date.GetItemDateTime(1,'min_from_date')
//	adt_max_dt = lds_get_min_max_date.GetItemDateTime(1,'max_to_date')
//	Destroy	lds_get_min_max_date					// FDG 03/19/98
//	return 1
//end if

//	GaryR	05/29/01	Stars 4.7
Select	min(from_date),
			max(to_date)
  Into	:adt_min_dt,
  			:adt_max_dt
  From	claims_cntl
 Using	Stars1ca;		//	GaryR	06/07/01	Stars 4.7
 
li_rc	=	Stars1ca.of_check_status()		//	GaryR	06/07/01	Stars 4.7

IF	li_rc	<	0		THEN
	Stars1ca.of_rollback()			//	GaryR	06/07/01	Stars 4.7
	Return	li_rc
END IF

Stars1ca.of_commit()			//	GaryR	06/07/01	Stars 4.7

Return	1


end function

public subroutine uf_set_query_id (string as_query_id);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_query_id
//
//	Arguments:	as_query_id
//
//	Returns:		None
//
//	Description:
//		This function saves the query ID so it can be passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

istr_query_parms.query_id	=	as_query_id


end subroutine

public function string uf_get_query_engine_mode ();//////////////////////////////////////////////////////////////////
//	Script:	uf_get_query_engine_mode
//
//	Arguments:	None
//
//	Returns:		String (query engine mode)
//
//	Description:
//		This function returns the query engine mode previouisly saved by
//		uf_set_query_engine_mode.
//////////////////////////////////////////////////////////////////
//	History:
//
//	LS		12/21/01	Created	Track 2552d
//
//////////////////////////////////////////////////////////////////

Return	istr_query_parms.query_engine_mode
end function

public subroutine uf_set_query_engine_mode (string as_query_engine_mode);//////////////////////////////////////////////////////////////////
//	Script:	uf_set_query_engine_mode
//
//	Arguments:	as_query_engine_mode
//
//	Returns:		None
//
//	Description:
//		This function saves the query engine mode so it can be passed
//		w_query_engine.
//////////////////////////////////////////////////////////////////
//	History:
//
//	LS		12/21/01	Created	Track 2552d
//
//////////////////////////////////////////////////////////////////

istr_query_parms.query_engine_mode	=	as_query_engine_mode


end subroutine

public subroutine uf_open_query_engine ();//////////////////////////////////////////////////////////////////
//	Script:	uf_open_query_engine
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function opens w_query_engine passing structure
//		istr_query_parms.
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//	FDG	02/10/98	If the query ID is 'USE' then open query engine
//						as a response window because the calling
//						script needs to get the query ID selected
//						from w_query_engine.
//
//	FDG	03/03/98	Track 951.  Open w_query_engine as a local
//						variable to allow multiple occurences of
//						query engine to open.
//
//	FDG	05/01/98	Track 1173.  remove the last 'AND' in the criteria.
//
//	FDG	07/17/00	Track 2465c.  Stars 4.5 SP1.  Allow for fast query.
//	LS		12/21/01	Track 2552d Populate structure to set query engine mode
//
//////////////////////////////////////////////////////////////////

w_query_engine	lw_query_engine

//	See if tbl-rel, tbl_type & src_type were set.  If so, fill in
//	the tables[] array within istr_query_parms
IF	Trim (is_tbl_rel)		>	'  '		THEN
	//	Fill in the tables[] array
	Integer	li_upper
	li_upper	=	UpperBound (istr_query_parms.tables)
	li_upper++
	istr_query_parms.tables[li_upper].tbl_type					=	is_tbl_type
	istr_query_parms.tables[li_upper].tbl_rel						=	is_tbl_rel
	istr_query_parms.tables[li_upper].src_type					=	is_src_type
	istr_query_parms.tables[li_upper].rpt_title					=	is_rpt_title
	istr_query_parms.tables[li_upper].level_num					=	ii_level_num
	// FDG 07/17/00 begin
	istr_query_parms.tables[li_upper].fastquery_ind				=	''
	istr_query_parms.tables[li_upper].fastquery_rows			=	0
	istr_query_parms.tables[li_upper].payment_date_options	=	''
	// FDG 07/17/00 end
END IF

// Lahu S 12/21/01 begin Track 2552d
// set query engine mode
istr_query_parms.query_engine_mode=This.uf_get_query_engine_mode()
// Lahu S 12/21/01 end

// FDG 05/01/98 begin

li_upper	=	Upperbound (istr_query_parms.criteria)

IF	li_upper	>	0		THEN
	istr_query_parms.criteria [li_upper].logic_op	=	''
	gv_logic [li_upper]										=	''
END IF

// FDG 05/01/98 end

// If query ID = 'USE' then open w_query_engine as a response window.

IF	This.uf_get_query_id()	=	ics_use		THEN
	OpenWithParm (w_query_engine_response, istr_query_parms)
ELSE
	OpenSheetWithParm (lw_query_engine, istr_query_parms, mdi_main_frame, help_menu_position, Layered!)
END IF


end subroutine

event constructor;//////////////////////////////////////////////////////////////////
//	Script:	uo_cst_queryengine.Constructor
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This script calls the function to initialize istr_query_parms.
//		
//////////////////////////////////////////////////////////////////
//	History:
//
//	FNC	11/24/97	Created
//
//////////////////////////////////////////////////////////////////

This.uf_clear_query_parms()
end event

on uo_cst_queryengine.create
call super::create
end on

on uo_cst_queryengine.destroy
call super::destroy
end on

