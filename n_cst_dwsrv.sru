HA$PBExportHeader$n_cst_dwsrv.sru
$PBExportComments$PFC DataWindow service (inherited from n_base) <logic>
forward
global type n_cst_dwsrv from n_base
end type
end forward

global type n_cst_dwsrv from n_base
end type
global n_cst_dwsrv n_cst_dwsrv

type variables
Protected:
integer	ii_source
string	is_defaultheadersuffix = "_t"
string	is_displayunits = "rows"
string	is_displayitem = "this row"
u_dw	idw_requestor

end variables

forward prototypes
public subroutine of_SetRequestor (u_dw adw_requestor)
public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_getcolumnnamesource ()
public function string of_getheadername (string as_column)
public function string of_GetItem (long al_row, string as_column)
public function string of_GetItem (long al_row, integer ai_column)
public function string of_GetItem (long al_row, integer ai_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function string of_getitem (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function integer of_setitem (long al_row, integer ai_column, string as_value)
public function integer of_getobjects (ref string as_objlist[])
public function string of_Modify (string as_attribute, string as_value, string as_col)
public function string of_modify (string as_attribute, string as_value, string as_objtype, string as_band, boolean ab_visible_only)
public function string of_Modify (string as_attribute, string as_value)
public function string of_getheadername (string as_column, string as_suffix)
public function integer of_setitem (long al_row, string as_column, string as_value)
public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function any of_GetItemany (long al_row, integer ai_column)
public function any of_GetItemany (long al_row, integer ai_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function any of_GetItemany (long al_row, string as_column)
public function long of_getheight ()
public function long of_getwidth ()
public function integer of_describe (ref n_cst_dwobjectattrib a_dwobject_attrib[], string as_attribute, string as_objtype, string as_band, boolean ab_visible_only)
public function integer of_describe (ref n_cst_dwobjectattrib a_dwobject_attrib[], string as_attribute, string as_col)
public function string of_getdefaultheadersuffix ()
public function integer of_setdefaultheadersuffix (string as_suffix)
public function integer of_SetDisplayUnits (string as_displayunits)
public function integer of_SetDisplayItem (string as_displayitem)
public function string of_GetDisplayItem ()
public function string of_GetDisplayUnits ()
public function integer of_setcolumnnamesource (integer ai_colsource)
public function integer of_dwarguments (ref string as_argnames[], ref string as_argdatatypes[])
public function integer of_dwarguments (datawindowchild adwc_obj, ref string as_argnames[], ref string as_argdatatypes[])
public function integer of_describe (ref n_cst_dwobjectattrib a_dwobject_attrib[], string as_attribute)
public function integer of_refreshdddws ()
end prototypes

public subroutine of_SetRequestor (u_dw adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor
//
//	Access:    Public
//
//	Arguments:
//   adw_Requestor   The datawindow requesting the service
//
//	Returns:  None
//
//	Description:  Associates a datawindow control with a datawindow service NVO
//			        by setting the idw_Requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////

idw_Requestor = adw_Requestor
end subroutine

public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 2)
//
//	Access:    		Public
//
//	Arguments:
//   as_objlist[]:	A string array to hold objects (passed by reference)
//   as_objtype:  	The type of objects to get (* for all, others defined
//							by the object .TYPE attribute)
//   as_band:  		The dw band to get objects from (* for all) 
//							Valid bands: header, detail, footer, summary
//							header.#, trailer.#
//   ab_visibleonly: TRUE  - get only the visible objects,
//							 FALSE - get visible and non-visible objects
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//	Description:	The following function will parse the list of objects 
//						contained in the datawindow control associated with this service,
//						returning their names into a string array passed by reference, 
//						and returning the number of names in the array as the return value 
//						of the function.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_ObjString, ls_ObjHolder
integer	li_ObjCount, li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = idw_Requestor.Describe("Datawindow.Objects")

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))

	// Determine if object is the right type and in the right band
	If (idw_Requestor.Describe(ls_ObjHolder + ".type") = as_ObjType Or as_ObjType = "*") And &
		(idw_Requestor.Describe(ls_ObjHolder + ".band") = as_Band Or as_Band = "*") And &
		(idw_Requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = Mid(ls_ObjString, li_Start, Len(ls_ObjString))

// Determine if object is the right type and in the right band
If (idw_Requestor.Describe(ls_ObjHolder + ".type") = as_ObjType or as_ObjType = "*") And &
	(idw_Requestor.Describe(ls_ObjHolder + ".band") = as_Band or as_Band = "*") And &
	(idw_Requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count
end function

public function integer of_getcolumnnamesource ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_GetColumnnameSource
//
//	Access:    	Public
//
//	Arguments: 	None
//
//	Returns:   	Integer
//   				0 = Use Datawindow Column Names (Default)
//				   1 = Use DataBase Column Names
//  				2 = Use Column Header Names 
//
//	Description:	To determine the source of column names to be used in 
//					 	Sort/Filter and QueryMode dialogs
//					  	This is set in of_SetColumnNameSource
//
//////////////////////////////////////////////////////////////////////////////

Return ii_source
end function

public function string of_getheadername (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetHeaderName (FORMAT 1) 
//
//	Access:    		Public
//
//	Arguments:
//   as_column   	A datawindow columnname
//
//	Returns:  		String
//   					The formatted column header for the column specified
//
//	Description:  	Extracts a formatted (underscores, carraige return/line
//					  	feeds and quotes removed) column header.
//					  	If no column header found, then the column name is
//					  	formatted (no underscores and Word Capped).
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0    Initial version
//	5.0.02   Fixed function to use the default header suffix property
//		when determining which text object to use for the the column header.
//
//////////////////////////////////////////////////////////////////////////////

Return of_GetHeaderName ( as_column, is_defaultheadersuffix) 
end function

public function string of_GetItem (long al_row, string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItem (FORMAT 3) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//
//	Returns:  String
//	  The formatted string value of the item
//
//	Description:  Returns the formatted (including formats, editmasks and display
//					  values) text of any column on a datawindow, regardless of the 
//					  column's datatype.  
//
//////////////////////////////////////////////////////////////////////////////

Return of_GetItem ( al_row, as_column, Primary!, FALSE )
end function

public function string of_GetItem (long al_row, integer ai_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItem (FORMAT 1) 
//
//	Access:    Public
//
//	Arguments:
//   al_row		: The row reference
//   ai_column : The column number reference
//
//	Returns:  String
//	  The formatted string value of the item
//
//	Description:  Returns the formatted (including formats, editmasks and display
//					  values) text of any column on a datawindow, regardless of the 
//					  column's datatype.  
//
//////////////////////////////////////////////////////////////////////////////

string ls_columnname 

ls_columnname = idw_Requestor.Describe ( "#" + String( ai_column ) + ".name" )

Return of_GetItem ( al_row, ls_columnname, Primary!, FALSE )
end function

public function string of_GetItem (long al_row, integer ai_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItem (FORMAT 2) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   ai_column    	: The column number reference
//   adw_buffer   	: The dw buffer from which to get the column's data value.
//   ab_orig_value	: When True, returns the original values that were 
//							  retrieved from the database.
//
//	Returns:  String
//	  The formatted string value of the item
//
//	Description:  Returns the formatted (including formats, editmasks and display
//					  values) text of any column on a datawindow, regardless of the 
//					  column's datatype.  
//
//////////////////////////////////////////////////////////////////////////////

string ls_columnname 

ls_columnname = idw_Requestor.Describe ( "#" + String( ai_column ) + ".name" )

Return of_GetItem ( al_row, ls_columnname, adw_buffer, ab_orig_value )
end function

public function string of_getitem (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItem (FORMAT 4) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//   adw_buffer   	: The dw buffer from which to get the column's data value.
//   ab_orig_value	: When True, returns the original values that were 
//							  retrieved from the database.
//
//	Returns:  String
//	  The formatted string value of the item
//
//	Description:  Returns the formatted (including formats, editmasks and display
//					  values) text of any column on a datawindow, regardless of the 
//					  column's datatype.  
//
//////////////////////////////////////////////////////////////////////////////

string ls_col_format, ls_col_mask, ls_string_format, ls_string, ls_compute_exp
boolean lb_editmask_used=False
n_cst_string	lnv_string

ls_col_format = idw_Requestor.Describe ( as_column + ".format" )
ls_col_mask   = idw_Requestor.Describe ( as_column + ".editmask.mask") 

IF ls_col_mask = "!" or ls_col_mask = "?" THEN
	ls_string_format = ls_col_format
ELSE 
	ls_string_format = ls_col_mask
	lb_editmask_used = TRUE
END IF 
 
IF ls_string_format = "!" or ls_string_format = "?" THEN 
	ls_string_format = ""
END IF  

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and format the returned value */
CHOOSE CASE Lower ( Left ( idw_Requestor.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char("				//  CHARACTER DATATYPE
			IF lb_editmask_used = TRUE THEN 
				/*  Need to replace 'EditMask' characters with 'Format' characters */
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "^", "@" ) //Lowercase
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "!", "@")	//Uppercase
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "#", "@" ) //Number
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "a", "@" ) //Aplhanumeric
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "x", "@" ) //Any Character
			END IF 
			ls_string = idw_Requestor.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
			ls_string = String ( ls_string, ls_string_format ) 
	
		CASE "date"					//  DATE DATATYPE
			date ld_date
			ld_date = idw_Requestor.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ld_date, ls_string_format ) 
			else
				ls_string = String (ld_date)
			end if

		CASE "datet"				//  DATETIME DATATYPE
			datetime ldtm_datetime
			ldtm_datetime = idw_Requestor.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ldtm_datetime, ls_string_format ) 
			else
				ls_string = String (ldtm_datetime)
			end if

		CASE "decim"				//  DECIMAL DATATYPE
			decimal ldec_decimal
			ldec_decimal = idw_Requestor.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ldec_decimal, ls_string_format ) 
			else
				ls_string = String (ldec_decimal)
			end if	
	
		CASE "numbe", "long", "ulong", "real"				//  NUMBER DATATYPE	
			long ll_long
			ll_long = idw_Requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ll_long, ls_string_format ) 
			else
				ls_string = String (ll_long)
			end if
	
		CASE "time", "times"		//  TIME DATATYPE
			time ltm_time
			ltm_time = idw_Requestor.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ltm_time, ls_string_format ) 
			else
				ls_string = String (ltm_time)
			end if

		CASE ELSE 					//  MUST BE A COMPUTED COLUMN
			IF idw_Requestor.Describe ( as_column + ".Type" ) = "compute" THEN 
				ls_compute_exp = idw_Requestor.Describe ( as_column + ".Expression" )
				ls_string = idw_Requestor.Describe( "Evaluate('" + ls_compute_exp + "', " + string (al_row) + ")" )
				ls_string = String (ls_string, ls_string_format ) 
				Return ls_string
			ELSE
				Return ""
			END IF 

END CHOOSE

IF adw_buffer = Primary! THEN 
	IF Lower ( idw_Requestor.Describe ( as_column + ".Edit.CodeTable" ) ) = "yes"	& 
	OR Lower ( idw_Requestor.Describe ( as_column + ".EditMask.CodeTable" ) ) = "yes"	& 
	OR	idw_Requestor.Describe ( as_column + ".RadioButtons.Columns" ) <> "0"		&
	OR	idw_Requestor.Describe ( as_column + ".DDDW.DataColumn" ) > "?" THEN
		ls_string = idw_Requestor.Describe ( &
			"Evaluate('LookUpDisplay(" + as_column + ")', " + String(al_row) + ")" ) 
	ELSEIF idw_Requestor.Describe ( as_column + ".CheckBox.On" ) <> "?"	THEN
		ls_string = ls_string + "~t" + idw_Requestor.Describe ( &
			"Evaluate('LookUpDisplay(" + as_column + ")', " + String(al_row) + ")" ) 
	END IF
END IF

Return ls_string
end function

public function integer of_setitem (long al_row, integer ai_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetItem (FORMAT 1)
//
//	Access:    		Public
//
//	Arguments:
//   al_row		:  The row reference for the value to be set
//   ai_column :  The column number reference
//   as_value  :  The value of the column in string format
//
//	Returns:  		Integer
//  					 1 = if it succeeds 
//  					-1 = if an error occurs
//
//	Description:  Sets the specified row/column to the passed value.
//
//////////////////////////////////////////////////////////////////////////////

string ls_columnname

/* Get the Column Name from the Column Number. */
ls_columnname = idw_Requestor.Describe ( "#" + String ( ai_column) + ".Name" ) 

Return of_SetItem ( al_row, ls_columnname, as_value ) 
end function

public function integer of_getobjects (ref string as_objlist[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 1)
//
//	Access:    		Public
//
//	Arguments:
//   as_objlist[]:	A string array to hold objects (passed by reference)
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//	Description:	The following function will parse the list of objects 
//						contained in the datawindow control associated with this service,
//						returning their names into a string array passed by reference, 
//						and returning the number of names in the array as the return value 
//						of the function.
//
//////////////////////////////////////////////////////////////////////////////

Return of_GetObjects ( as_objlist, "*", "*", FALSE ) 

end function

public function string of_Modify (string as_attribute, string as_value, string as_col);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Modify (FORMAT 2)
//
//	Access:    Public 
//
//	Arguments:
//   as_attribute  :  The name of the datawindow attribute to be modified
//   as_value		 :  The new value of the datawindow attribute
//   as_col		 	 :  The columnname to be modified
//
//	Returns:  String
//	  The return string of Modify.  When empty, indicates success.
//
//	Description:  Modifies the specified attribute for the specified column
//
//////////////////////////////////////////////////////////////////////////////

Return of_Modify ( as_attribute, as_value, as_col, "*", FALSE ) 
end function

public function string of_modify (string as_attribute, string as_value, string as_objtype, string as_band, boolean ab_visible_only);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Modify (FORMAT 3)
//
//	Access:    Public 
//
//	Arguments:
//   as_attribute 	:  The name of the datawindow attribute to be modified
//   as_value		 	:  The new value of the datawindow attribute
//   as_objtype	  	:  The type of objects to modify (* for all, others defined
//							   by the object .TYPE attribute)
//   as_band 			:  The dw band to modify objects in (* for all) 
//								 Valid bands: header, detail, footer, summary
//								 header.#, trailer.#
//   ab_visibleonly	:  TRUE  - modify only the visible objects,
//							   FALSE - modify visible and non-visible objects
//
//	Returns:  String
//	  The return string of Modify.  When empty, indicates success.
//
//	Description:  Modifies the specified attribute for all columns
//
//////////////////////////////////////////////////////////////////////////////

string ls_modify, ls_rc, ls_objects[]
integer	li_cnt
integer	li_col_count

/* Get the count and names of columns on the datawindow */
li_col_count = of_GetObjects (ls_objects, as_objtype, as_band, ab_visible_only )

IF li_col_count > 0 THEN

	/*  Modify all columns on the datawindow */
	FOR li_cnt = 1 to li_col_count
		ls_modify = ls_modify + ls_objects[li_cnt] + "." + as_attribute + "= " + as_value + " " 
	NEXT 

	IF idw_Requestor.Modify ( ls_modify ) <> "" THEN 
		/*  If Modify fails, then try quoting the attribute value */ 
		as_value = "'" + as_value + "'"
		ls_modify = ""
		FOR li_cnt = 1 to li_col_count
			ls_modify = ls_modify + ls_objects[li_cnt] + "." + as_attribute + "= " + as_value + " " 
		NEXT 
		ls_rc = idw_Requestor.Modify ( ls_modify ) 
	END IF 

ELSE /* Single column to Modify */
	ls_modify = as_objtype + "." + as_attribute + "= " + as_value 
	IF idw_Requestor.Modify ( ls_modify ) <> "" THEN 
		as_value = "'" + as_value + "'"
		ls_modify = as_objtype + "." + as_attribute + "= " + as_value 
		ls_rc = idw_Requestor.Modify ( ls_modify ) 
	END IF 

END IF

Return ls_rc
end function

public function string of_Modify (string as_attribute, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Modify (FORMAT 1)
//
//	Access:    Public 
//
//	Arguments:
//   as_attribute  :  The name of the datawindow attribute to be modified
//   as_value		 :  The new value of the datawindow attribute
//
//	Returns:  String
//	  The return string of Modify.  When empty, indicates success.
//
//	Description:  Modifies the specified attribute for all columns
//
//////////////////////////////////////////////////////////////////////////////

Return of_Modify ( as_attribute, as_value, "*", "*", FALSE ) 
end function

public function string of_getheadername (string as_column, string as_suffix);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetHeaderName (FORMAT 2) 
//
//	Access:    Public
//
//	Arguments:
//   as_column   A datawindow columnname
//	  as_suffix   The suffix used on column header text
//
//	Returns:  String
//	  The formatted column header for the column specified
//
//	Description:  Extracts a formatted (underscores, carriage return/line
//					  feeds and quotes removed) column header.
//					  If no column header found, then the column name is
//					  formatted (no underscores and Word Capped).
//
//  *NOTE: Use this format when column header text does NOT
//	  use the default header suffix
//
//////////////////////////////////////////////////////////////////////////////

string ls_colhead
n_cst_string	lnv_string

//Try using the column header.
ls_colhead = idw_Requestor.Describe ( as_column + as_suffix + ".Text" )
If ls_colhead = "!" Then
	//No valid column header, use column name.
	ls_colhead = as_column
End If	

//Remove undesired characters.
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~r~n", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~t", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~r", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~n", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "_", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~"", "" ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~'", "" ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~~", "" )

//WordCap string.
ls_colhead = idw_Requestor.Describe ( "Evaluate('WordCap(~"" + ls_colhead + "~")',0)" )

Return ls_colhead
end function

public function integer of_setitem (long al_row, string as_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetItem (FORMAT 2) 
//
//	Access:    		Public
//
//	Arguments:
//   al_row		:  The row reference for the value to be set
//   as_column :  The column name reference
//   as_value  :  The value of the column in string format
//
//	Returns:  		Integer
//   					 1 = if it succeeds 
// 					-1 = if an error occurs
//
//	Description:  	Sets the specified row/column to the passed value.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
date		ld_val
decimal	ldc_val
long		ll_val
string		ls_string_value
time		ltm_val
n_cst_string	lnv_string
n_cst_conversion	lnv_conversion

// Check arguments
if IsNull (al_row) or IsNull (as_column) then
	return -1
end if

if IsNull (idw_requestor) or not IsValid (idw_requestor) then
	return -1
end if

/*  Determine the datatype of the column and then call the SetItem
	 with proper datatype */

CHOOSE CASE Lower ( Left ( idw_Requestor.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char("		//  CHARACTER DATATYPE
			li_rc = idw_Requestor.SetItem ( al_row, as_column, as_value ) 
	
		CASE "date"			//  DATE DATATYPE
			li_rc = idw_Requestor.SetItem ( al_row, as_column, Date (as_value) ) 

		CASE "datet"		//  DATETIME DATATYPE
			
			ld_val = lnv_conversion.of_Date (as_value)
			ltm_val = lnv_conversion.of_Time (as_value)
			li_rc = idw_Requestor.SetItem (al_row, as_column, DateTime (ld_val, ltm_val))	

		CASE "decim"		//  DECIMAL DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldc_val = Dec (ls_string_value) / 100
			else
				ldc_val = Dec (ls_string_value)
			end if

			li_rc = idw_Requestor.SetItem ( al_row, as_column, ldc_val) 
	
		CASE "numbe", "long", "ulong", "real"	//  NUMBER DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ll_val = Long (ls_string_value) / 100
			else
				ll_val = Long (ls_string_value)
			end if
						
			li_rc = idw_Requestor.SetItem ( al_row, as_column, ll_val) 
		
		CASE "time", "times"		//  TIME DATATYPE
			li_rc = idw_Requestor.SetItem ( al_row, as_column, Time ( as_value ) ) 


END CHOOSE

Return li_rc
end function

public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 4) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//   adw_buffer   	: The dw buffer from which to get the column's data value.
//   ab_orig_value	: When True, returns the original values that were 
//							  retrieved from the database.
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////

any 		la_value
string 	ls_computeexp

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and cast the returned value */
CHOOSE CASE Lower ( Left ( idw_Requestor.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char("				//  CHARACTER DATATYPE
			la_value = idw_Requestor.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = idw_Requestor.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = idw_Requestor.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "decim"				//  DECIMAL DATATYPE
			la_value = idw_Requestor.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "numbe", "long", "ulong", "real"				//  NUMBER DATATYPE	
			la_value = idw_Requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = idw_Requestor.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE ELSE 					//  MUST BE A COMPUTED COLUMN
			IF idw_Requestor.Describe ( as_column + ".Type" ) = "compute" THEN 
				ls_computeexp = idw_Requestor.Describe ( as_column + ".Expression" )
				la_value = idw_Requestor.Describe( "Evaluate('" + ls_computeexp + "', " + string (al_row) + ")" )
			ELSE
				SetNull ( la_value ) 
			END IF 

END CHOOSE

Return la_value
end function

public function any of_GetItemany (long al_row, integer ai_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 1) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   ai_column    	: The column number reference
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////

string ls_columnname 

ls_columnname = idw_Requestor.Describe ( "#" + String( ai_column ) + ".name" )

Return of_GetItemany ( al_row, ls_columnname, Primary!, FALSE )
end function

public function any of_GetItemany (long al_row, integer ai_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 2) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   ai_column    	: The column number reference
//   adw_buffer   	: The dw buffer from which to get the column's data value.
//   ab_orig_value	: When True, returns the original values that were 
//							  retrieved from the database.
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////

string ls_columnname 

ls_columnname = idw_Requestor.Describe ( "#" + String( ai_column ) + ".name" )

Return of_GetItemany ( al_row, ls_columnname, adw_buffer, ab_orig_value )
end function

public function any of_GetItemany (long al_row, string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 3) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////

Return of_GetItemany ( al_row, as_column, Primary!, FALSE )
end function

public function long of_getheight ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetHeight
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:  		long 
//   					The height of the datawindow
//
//	Description:  	Get the height of the datawindow associated with this service.
//					  	The	height is calculated by adding the height of all bands +
//					  	the height of the detail band * the number of rows.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_Bands, li_Cnt
long		ll_height
long		ll_detail
String	ls_DWBands, ls_Band[]
n_cst_string lnv_string

ls_DWBands = idw_Requestor.Describe("DataWindow.Bands")

li_Bands = lnv_string.of_ParseToArray (ls_DWBands, "~t", ls_Band)

For li_Cnt = 1 To li_Bands
	If ls_Band[li_Cnt] <> "detail" Then
		ll_Height += Integer(idw_Requestor.Describe("Datawindow." + &
							ls_Band[li_Cnt] + ".Height"))
	End if
Next

ll_Detail = idw_Requestor.RowCount() * &
			Integer(idw_Requestor.Describe("Datawindow.Detail.Height"))

ll_Height += ll_Detail

Return ll_Height
end function

public function long of_getwidth ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetWidth
//
//	Access:    Public
//
//	Arguments: None
//
//	Returns:   long
//   The width of the datawindow
//
//	Description:  Get the width (x position + width of the rightmost object) of the 
//				     datawindow associated with this service
//
//////////////////////////////////////////////////////////////////////////////

long	ll_Width
long	ll_Return
integer	li_NumObjects
integer	li_Count
long	ll_X
long	ll_ObjWidth
string	ls_Objects[]

// Get the names of all visible objects in the datawindow
li_NumObjects = of_GetObjects(ls_Objects, "*", "*", True)

ll_Return = 0

For li_Count = 1 To li_NumObjects
	// Calculate the x position + the width of each object
	ll_X = Integer(idw_Requestor.Describe(ls_Objects[li_Count] + ".x"))
	ll_ObjWidth = Integer(idw_Requestor.Describe(ls_Objects[li_Count] + ".width"))
	ll_Width = ll_X + ll_ObjWidth

	// Return the rightmost value
	If ll_Width > ll_Return Then
		ll_Return = ll_Width

	End if
Next

Return ll_Return
end function

public function integer of_describe (ref n_cst_dwobjectattrib a_dwobject_attrib[], string as_attribute, string as_objtype, string as_band, boolean ab_visible_only);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Describe (FORMAT 3)
//
//	Access:    		Public
//
//	Arguments:
//   a_dwobject_attrib	A NVO Class to hold the described attributes
//   as_attribute	      A string containing the name of the attribute 
//								to be described
//   as_objtype			The type of objects to describe (* for all)
//								( Must match the Type attribute )
//	  as_band			 	The band from which to get objects (* for all)
//									Valid bands:
//									header
//									detail
//									footer
//									summary
//									header.#
//									trailer.#
//	  ab_visible_only		True - get only the visible objects,
//								False - get all objects
//
//	Returns:  		integer
//   					 1 = success
//						-1 = an error occurred describing one or more of the attributes
//
//	Description:  	Describes the specified attribute for all
//					  	datawindow columns.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_cnt, li_col_count
integer	li_rc = 1
string	ls_objects[]

/* Get the count and names of columns on the datawindow */
li_col_count = of_GetObjects (ls_objects, as_objtype, as_band, ab_visible_only )

/* Describe the columns returned */ 
IF li_col_count > 0 THEN

	/* Loop around all columns */
	FOR li_cnt = 1 to li_col_count

		/*  Describe the column name */
		a_dwobject_attrib[li_cnt].is_column = idw_Requestor.Describe ( ls_objects[li_cnt] + ".Name" ) 
		IF Pos (a_dwobject_attrib[li_cnt].is_column, "!", 1) > 0 THEN 
			a_dwobject_attrib[li_cnt].is_column = "Error describing Name attribute of Column #" + String(li_cnt)
			li_rc = -1
		end if

		/*  Describe the column datatype */
		a_dwobject_attrib[li_cnt].is_datatype = idw_Requestor.Describe ( ls_objects[li_cnt] + ".ColType" ) 
		IF Pos (a_dwobject_attrib[li_cnt].is_datatype, "!", 1) > 0 THEN
			a_dwobject_attrib[li_cnt].is_datatype = 	"Error describing ColType attribute of Column #" + String(li_cnt)
			li_rc = -1
		end if

		/*  Describe the passed attribute */
		a_dwobject_attrib[li_cnt].is_value = idw_Requestor.Describe ( ls_objects[li_cnt] + "." + as_attribute ) 
		IF Pos (a_dwobject_attrib[li_cnt].is_value, "!", 1) > 0 THEN
			a_dwobject_attrib[li_cnt].is_value = 	"Error describing " + as_attribute + " attribute of Column #" + String(li_cnt)
			li_rc = -1
		end if

	NEXT 

ELSE	
	/*  Single column to describe */
	
	/*  Describe the column name */	
	a_dwobject_attrib[1].is_column = as_objtype
	
	/*  Describe the column datatype */	
	a_dwobject_attrib[1].is_datatype = idw_Requestor.Describe ( as_objtype + ".ColType" ) 
	IF Pos (a_dwobject_attrib[1].is_datatype, "!", 1) > 0 THEN
		a_dwobject_attrib[1].is_datatype = "Error describing ColType attribute of " + as_objtype
		li_rc = -1
	end if

	/*  Describe the passed attribute */
	a_dwobject_attrib[1].is_value = idw_Requestor.Describe ( as_objtype + "." + as_attribute ) 
	IF Pos (a_dwobject_attrib[1].is_value, "!", 1) > 0 THEN
		a_dwobject_attrib[1].is_value = "Error describing " + as_attribute + " attribute of " + as_objtype
		li_rc = -1
	end if

END IF 

/* If any script failed, the Return Value will be -1 since li_rc is never reset. */
Return li_rc
end function

public function integer of_describe (ref n_cst_dwobjectattrib a_dwobject_attrib[], string as_attribute, string as_col);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Describe (FORMAT 2)
//
//	Access:   		Public
//
//	Arguments:
//   a_dwobject_attrib	A NVO Class to hold the described attribute
//   as_attribute	      A string containing the name of the attribute 
//								to be described
//   as_col 		      A string containing the name of a specific
//								column to be described
//
//	Returns:  		integer
// 					 1 = success
//						-1 = an error occurred describing one or more of the attributes
//
//	Description:  	Describes the specified attribute for the specified
//					  	datawindow column.
//
//////////////////////////////////////////////////////////////////////////////

Return of_Describe ( a_dwobject_attrib, as_attribute, as_col, "*", FALSE ) 
end function

public function string of_getdefaultheadersuffix ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetDefaultHeaderSuffix
//
//	Access:  		public
//
//	Arguments:  	none
//
//	Returns:  		string
//
//	Description:  	Returns the suffix used for column labels/headers
//
//////////////////////////////////////////////////////////////////////////////


return is_defaultheadersuffix
end function

public function integer of_setdefaultheadersuffix (string as_suffix);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetDefaultHeaderSuffix
//
//	Access:  public
//
//	Arguments:  as_suffix
//
//	Returns:  integer
//	1 = success
//
//	Description:  Sets the suffix characters that are used for
//	column labels/headers
//
//////////////////////////////////////////////////////////////////////////////


is_defaultheadersuffix = as_suffix
return 1
end function

public function integer of_SetDisplayUnits (string as_displayunits);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetDisplayUnits
//
//	Access:  public
//
//	Arguments:
//	as_displayunits:  display name of the units (rows)
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the display name of the units (rows) of the DW.
//
//////////////////////////////////////////////////////////////////////////////

// Validate argument
if IsNull (as_displayunits) then
	return -1
end if

is_displayunits = as_displayunits
return 1
end function

public function integer of_SetDisplayItem (string as_displayitem);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetDisplayItem
//
//	Access:  public
//
//	Arguments:
//	as_displayitem:  display name of the item (row)
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the display name of the item (row) of the DW
//
//////////////////////////////////////////////////////////////////////////////

// Validate argument
if IsNull (as_displayitem) then
	return -1
end if

is_displayitem = as_displayitem
return 1
end function

public function string of_GetDisplayItem ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDisplayItem
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  string
//
//	Description:
//	Gets the display name of the item (row) of the DW
//
//////////////////////////////////////////////////////////////////////////////

return is_displayitem
end function

public function string of_GetDisplayUnits ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDisplayUnits
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  string
//
//	Description:
//	Gets the display name of the units (rows) of the DW.
//
//////////////////////////////////////////////////////////////////////////////

return is_displayunits
end function

public function integer of_setcolumnnamesource (integer ai_colsource);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetColumnNameSource
//
//	Access:  Public
//
//	Arguments:
//	ai_colsource   source of column display names
//	Choices:
//	0 = Use standard Datawindow column names (default)
//	1 = Use dataBase column names
//	2 = Use column header names 
//
//	Returns:  Integer
//	  1 = The columnsource was successfully set
//	 -1 = The specified source option is not available
//
//	Description:
//	Specifies how column names will be displayed to the user
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc = 1

if IsNull (ai_colsource) then
	return -1
end if

if (ai_colsource > 2 or ai_colsource < 0) then
	li_rc = -1
else
	ii_source = ai_colsource
end if

return li_rc
end function

public function integer of_dwarguments (ref string as_argnames[], ref string as_argdatatypes[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DWArguments (Format 2)
//
//	Access:  Public
//
//	Arguments:
//	as_argnames[]:  A string array (by reference) to hold the argument names
//	as_argdatatypes[]:  A string array (by reference) to hold argument datatypes
//
//	Returns:  Integer
//	The number of arguments found
//	-1 = error
//
//	Description:  To determine if the requesting datawindow has arguments and 
//		what they are
//
//		Note: This function has a (Format 1) which is very similar.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.01 Fixed bug so that reference arguments are populated correctly
//	5.0.01 Function returns -1 if DW requestor is not valid
// 5.0.02 Added Stored Procedures support.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_currpos=1
integer	li_namestartpos
integer	li_nameendpos
integer	li_typestartpos
integer	li_typeendpos
integer	li_numargs=0
string	ls_syntax
string	ls_args[]
string	ls_types[]
string	ls_workstring
n_cst_string lnv_string

// Clear reference values.
as_argnames = ls_args
as_argdatatypes = ls_types

// Check DW requestor
if IsNull(idw_requestor) or not IsValid(idw_requestor) then
	return -1
end if

// Get the Requestor datawindow syntax.
ls_syntax = Lower (idw_requestor.Describe ("DataWindow.Syntax")) 

// Look for the ARGUMENTS keyword.
li_currpos = Pos (ls_syntax, "arguments=((", 1)

If li_currpos > 0 Then
	// Loop until all the arguments have been found.
	do while (Mid(ls_syntax, li_currpos, 1) <> ")") And (li_currpos < Len(ls_syntax))
		// Reset values.
		li_namestartpos = 0
		li_nameendpos = 0
		li_typestartpos = 0
		li_typeendpos = 0

		// New argument has been found.
		li_numargs++

		// Get the column NAME.
		li_namestartpos = Pos (ls_syntax, "~"", li_currpos) + 1
		li_nameendpos = Pos (ls_syntax, "~"", li_namestartpos)
		If li_namestartpos <=0 or li_nameendpos <=0 Then Return -1		
		ls_args[li_numargs] = Trim (Mid (ls_syntax, li_namestartpos, li_nameendpos - li_namestartpos))

		// Get the column TYPE.
		li_typestartpos = li_nameendpos + 3
		li_typeendpos = Pos (ls_syntax, ")", li_typestartpos)
		If li_typestartpos <=0 or li_typeendpos <=0 Then Return -1		
		ls_types[li_numargs] = Trim (Mid (ls_syntax, li_typestartpos, li_typeendpos - li_typestartpos))
		
		// Update the current position past the current argument.
		li_currpos = li_typeendpos		
	loop
Else
	// This will find Arguments that have been defined on the datawindow object.
	// They are not necesarily being used by the datawindow SQL statement.
	
	// Look for the ARG( keyword.
	li_currpos = Pos (ls_syntax, "arg(", 1)

	// Loop until all the arguments have been found (if any).
	do while li_currpos > 0 

		// Reset values.
		li_namestartpos = 0
		li_nameendpos = 0
		li_typestartpos = 0
		li_typeendpos = 0
		
		// New argument has been found.
		li_numargs++

		// Get the column NAME.
		li_namestartpos = Pos (ls_syntax, "name", li_currpos)
		li_nameendpos = Pos (ls_syntax, "type", li_namestartpos)
		If li_namestartpos <=0 or li_nameendpos <=0 Then Return -1				
		ls_workstring = Mid (ls_syntax, li_namestartpos, li_nameendpos - li_namestartpos) 
		ls_workstring = lnv_string.of_GlobalReplace (ls_workstring, "~~~"", "") 
		ls_args[li_numargs] = Trim (lnv_string.of_GetKeyValue (ls_workstring, "name", "=" ))

		// Get the column TYPE.
		li_typestartpos = li_nameendpos
		li_typeendpos = Pos (ls_syntax, ")", li_nameendpos) 
		If li_typestartpos <=0 or li_typeendpos <=0 Then Return -1		
		ls_workstring = Mid (ls_syntax, li_typestartpos, li_typeendpos - li_typestartpos) 
		ls_types[li_numargs] = Trim (lnv_string.of_GetKeyValue (ls_workstring, "type", "=" ))
		
		// Look for the next ARG( keyword.
		li_currpos = Pos (ls_syntax, "arg(", li_typeendpos)		
	loop
End If

// Return arguments found
as_argnames = ls_args
as_argdatatypes = ls_types
return li_numargs
end function

public function integer of_dwarguments (datawindowchild adwc_obj, ref string as_argnames[], ref string as_argdatatypes[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DWArguments (Format 1)
//
//	Access:  Public
//
//	Arguments:
//	adwc_obj:  DataWindow child to determine if there are arguments
//	as_argnames[]:  A string array (by reference) to hold the argument names
//	as_argdatatypes[]:  A string array (by reference) to hold argument datatypes
//
//	Returns:  Integer
//	The number of arguments found
//	-1 = error
//
//	Description:  Determines if a DataWindowChild has arguments and 
//		what they are.
//
//		Note: This function has a (Format 2) which is very similar.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0  Initial version
//	5.0.01 Fixed bug so that reference arguments are populated correctly
//	5.0.01 Function returns -1 if DataWindowChild reference is not valid
// 5.0.02 Added Stored Procedures support.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_currpos=1
integer	li_namestartpos
integer	li_nameendpos
integer	li_typestartpos
integer	li_typeendpos
integer	li_numargs=0
string	ls_syntax
string	ls_args[]
string	ls_types[]
string	ls_workstring
n_cst_string lnv_string

// Clear reference values.
as_argnames = ls_args
as_argdatatypes = ls_types

// Check arguments
if IsNull (adwc_obj) or not IsValid (adwc_obj) then
	return -1
end if

// Get the Child datawindow syntax.
ls_syntax = Lower (adwc_obj.Describe ("DataWindow.Syntax")) 

// Look for the ARGUMENTS keyword.
li_currpos = Pos (ls_syntax, "arguments=((", 1)

If li_currpos > 0 Then
	// Loop until all the arguments have been found.
	do while (Mid(ls_syntax, li_currpos, 1) <> ")") And (li_currpos < Len(ls_syntax))
		// Reset values.
		li_namestartpos = 0
		li_nameendpos = 0
		li_typestartpos = 0
		li_typeendpos = 0

		// New argument has been found.
		li_numargs++

		// Get the column NAME.
		li_namestartpos = Pos (ls_syntax, "~"", li_currpos) + 1
		li_nameendpos = Pos (ls_syntax, "~"", li_namestartpos)
		If li_namestartpos <=0 or li_nameendpos <=0 Then Return -1		
		ls_args[li_numargs] = Trim (Mid (ls_syntax, li_namestartpos, li_nameendpos - li_namestartpos))

		// Get the column TYPE.
		li_typestartpos = li_nameendpos + 3
		li_typeendpos = Pos (ls_syntax, ")", li_typestartpos)
		If li_typestartpos <=0 or li_typeendpos <=0 Then Return -1		
		ls_types[li_numargs] = Trim (Mid (ls_syntax, li_typestartpos, li_typeendpos - li_typestartpos))
		
		// Update the current position past the current argument.
		li_currpos = li_typeendpos		
	loop
Else
	// This will find Arguments that have been defined on the datawindow object.
	// They are not necesarily being used by the datawindow SQL statement.
	
	// Look for the ARG( keyword.
	li_currpos = Pos (ls_syntax, "arg(", 1)

	// Loop until all the arguments have been found (if any).
	do while li_currpos > 0 

		// Reset values.
		li_namestartpos = 0
		li_nameendpos = 0
		li_typestartpos = 0
		li_typeendpos = 0
		
		// New argument has been found.
		li_numargs++

		// Get the column NAME.
		li_namestartpos = Pos (ls_syntax, "name", li_currpos)
		li_nameendpos = Pos (ls_syntax, "type", li_namestartpos)
		If li_namestartpos <=0 or li_nameendpos <=0 Then Return -1				
		ls_workstring = Mid (ls_syntax, li_namestartpos, li_nameendpos - li_namestartpos) 
		ls_workstring = lnv_string.of_GlobalReplace (ls_workstring, "~~~"", "") 
		ls_args[li_numargs] = Trim (lnv_string.of_GetKeyValue (ls_workstring, "name", "=" ))

		// Get the column TYPE.
		li_typestartpos = li_nameendpos
		li_typeendpos = Pos (ls_syntax, ")", li_nameendpos) 
		If li_typestartpos <=0 or li_typeendpos <=0 Then Return -1		
		ls_workstring = Mid (ls_syntax, li_typestartpos, li_typeendpos - li_typestartpos) 
		ls_types[li_numargs] = Trim (lnv_string.of_GetKeyValue (ls_workstring, "type", "=" ))
		
		// Look for the next ARG( keyword.
		li_currpos = Pos (ls_syntax, "arg(", li_typeendpos)		
	loop
End If

// Return arguments found
as_argnames = ls_args
as_argdatatypes = ls_types
return li_numargs
end function

public function integer of_describe (ref n_cst_dwobjectattrib a_dwobject_attrib[], string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Describe (FORMAT 1)
//
//	Access:   		Public
//
//	Arguments:
//   a_dwobject_attrib   A NVO Class to hold the described attributes
//   as_attribute	          A string containing the name of the attribute 
//								    to be described
//
//	Returns:  		integer
//					   1 = success
//						-1 = an error occurred describing one or more of the attributes.
//
//	Description:  	Describes the specified attribute for all
//					  	datawindow columns.
//
//////////////////////////////////////////////////////////////////////////////

Return of_Describe ( a_dwobject_attrib, as_attribute, "*", "*", FALSE ) 
end function

public function integer of_refreshdddws ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RefreshDDDWs
//
//	Access:    Public
//
//	Arguments:  None
//
//	Returns:   Integer
//	  The number of dddw-style columns found and refreshed.
//		-1 if an error occurs.
//
//	Description:  To determine what columns have a DropDownDataWindow style 
//					  and to refresh the dddw. 
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_rc
Long 		ll_cnt
Long		ll_columncount
Long		ll_dddwcount
String 	ls_colname
String	ls_dddwdatacolumn
String 	ls_args[]
String	ls_types[]
boolean	lb_dddwrefreshed=False
DataWindowChild ldwc_obj

// Check required references.
If IsNull(idw_Requestor) or Not IsValid(idw_Requestor) Then Return -1

// Get the number of columns on the datawindow.
ll_columncount = Long (idw_Requestor.Describe("DataWindow.Column.Count")) 

// Loop around all columns.
FOR ll_cnt=1 TO ll_columncount
	// Reset boolean which states if dddw is refreshed.
	lb_dddwrefreshed=False
	
	// Get the current column name.
	ls_colname = idw_Requestor.Describe ( "#" + String ( ll_cnt ) + ".Name" )
	// Determine if the current column is a DropDownDataWindow.
	ls_dddwdatacolumn = idw_Requestor.Describe ( ls_colname + ".DDDW.DataColumn" )
	IF ls_dddwdatacolumn = "" OR ls_dddwdatacolumn = "?" THEN
		// Not a DropDownDataWindow.
		CONTINUE
	ELSE
		// Get the Child reference.
		ll_rc = idw_Requestor.GetChild (ls_colname, ldwc_obj) 
		If ll_rc > 0 Then
			// A DropDownDataWindow has been found.			
			IF of_DWArguments ( ldwc_obj, ls_args, ls_types ) > 0 THEN 
				// DropDownDataWindow has arguments, call event which will handle this case.
				ll_rc = idw_Requestor.Event ue_retrievedddw(ls_colname)
				If ll_rc < 0 Then Return -1
				lb_dddwrefreshed = True
			ELSE 
				// DropDownDataWindow does not have arguments, refresh the data.
				If IsValid(idw_Requestor.itr_object) Then
					ll_rc = ldwc_obj.SetTransObject(idw_Requestor.itr_object) 
					If ll_rc < 0 Then Return -1					
					ll_rc = ldwc_obj.Retrieve() 
					If ll_rc < 0 Then Return -1
					lb_dddwrefreshed = True				
				End If
			END IF
			If lb_dddwrefreshed Then
				// Increment the DropDownDataWindow count.
				ll_dddwcount++			
			End If
		End If
	END IF 
NEXT 
 
Return ll_dddwcount
end function

on n_cst_dwsrv.create
call super::create
end on

on n_cst_dwsrv.destroy
call super::destroy
end on

