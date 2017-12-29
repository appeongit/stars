$PBExportHeader$n_cst_sql.sru
$PBExportComments$Inherited from n_base <logic>
forward
global type n_cst_sql from n_base
end type
end forward

global type n_cst_sql from n_base
end type
global n_cst_sql n_cst_sql

type variables
// DBMS variables
Constant	String	ics_ase = 'ASE'
Constant	String	ics_oracle = 'ORA'
Constant	String	ics_udb = 'UDB'

Protected	String	is_dbms = 'ASE'

// Tag value for a DDDW that has transact-SQL
Constant	String	ics_dddwsql = ';DDDWSQL;'

// Tag value for a column to be coverted to upper case
Constant	String	ics_upper = ';UPPER;'

// Indicates which value to use for "substring"
Protected	String	is_substring = "substring"

// Indicates which value to use for empty string
Protected	String	is_empty = ""

// Outer join relational operator
Protected	String	is_outer_rel_op	=	" *= "
Protected	String	is_outer_exp2		=	""

// Schema name (for Oracle) so that can connect to the
// database with the actual user ID & password
Protected	String	is_schema

// Subset name prefix - old clients = 'SUB_MEDC', new clients = 'S'
Protected	String	is_subset_prefix

//	07/21/03	GaryR	Track	5273c	Oracle limits string literals to 2000 bytes
//	DBMS error code when inserting illegal characters
Protected	Long		il_bad_char	= 99999

//	12/17/04	GaryR	Track 4142d	Identify individual user sessions in the database
Protected	String	is_app_userid

//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
String	is_concat = "||"
end variables

forward prototypes
public function string of_get_days_diff (string as_column1, string as_column2)
public function string of_get_days_diff (string as_sql)
public subroutine of_set_dbms (string as_value)
public function string of_get_dbms ()
public function string of_get_to_number (string as_column)
public function long of_get_dup1_insert ()
public function long of_get_dup2_insert ()
public function integer of_table_exists (string as_table)
public function string of_get_to_money (string as_column)
public function string of_left_outer_join_where (string as_column1, string as_column2)
public function string of_left_outer_join_where (string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2)
public function string of_get_to_char (string as_column)
public function string of_get_outer_rel_op ()
public function string of_get_outer_exp2 ()
public function integer of_get_substring (n_ds ands_datastore)
public function integer of_get_substring (datawindowchild adwc_datawindowchild)
public function integer of_setup_transactions (string as_userid, string as_password)
public function boolean of_is_bad_connection (integer ai_rc)
public function string of_get_to_date (string as_date)
public function integer of_get_substring (u_dw audw_datawindow)
public function integer of_get_current_datetime (u_dw adw)
public function boolean of_is_duplicate_insert (integer ai_rc)
public function string of_get_current_datetime_name ()
public function integer of_get_current_datetime (ref string as_sql)
public function datetime of_get_current_datetime ()
public function string of_get_database_prefix (string as_prefix)
public function integer of_get_substring (ref string as_sql)
public function integer of_get_current_datetime (n_ds ads)
public function string of_get_dw_object (string as_dwobject_name)
public subroutine of_set_schema (string as_schema)
public function string of_get_schema_sql ()
public function string of_get_schema ()
public function string of_get_subset_prefix ()
public function boolean of_is_character_data_type (string as_data_type)
public function boolean of_is_date_data_type (string as_data_type)
public function boolean of_is_numeric_data_type (string as_data_type)
public function integer of_setupper (powerobject apo_requestor)
public function boolean of_is_money_data_type (string as_data_type)
public function boolean of_is_number_data_type (string as_data_type)
public function integer of_setrowlimit (ref string as_sql, long al_limit, n_tr ltr_use)
public function integer of_trimdata (ref string as_data)
public function integer of_get_alias (ref string as_select)
public function integer of_parse (string as_sql, ref n_cst_sqlattrib astr_sql[])
public function string of_assemble (n_cst_sqlattrib astr_sql[])
public function string of_left_outer_join_on (string as_where[])
public function string of_get_note_text (string as_note_id, string as_rel_type, string as_rel_id)
public function string of_get_to_upper (string as_column)
public function integer of_remove_time (ref string as_column)
public function boolean of_is_multiple_select (n_tr atr_check)
public function integer of_set_note_text (string as_note_text, string as_note_id, string as_rel_type, string as_rel_id)
public function boolean of_get_allow_view_loj (string as_inv_type)
public function string of_get_count_sql (boolean ab_main_view, boolean ab_dep_view, string as_main_type, string as_dep_type, ref boolean ab_use_ds_count)
public function string of_get_session_sql ()
public subroutine of_set_userid (string as_user_id)
public function string of_get_to_date_no_time (string as_date, boolean as_field_ind)
public function string of_get_database_name (n_tr atr_trans)
public function string of_full_outer_join (string as_select, string as_where, string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2)
public function integer of_setrowlimitmultitable (ref string as_sql, long al_limit, n_tr ltr_use)
public function string of_get_norm_case ()
public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2, string as_where3)
public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2)
public function string of_get_days_add (string as_date, string as_days)
public function string of_get_days_add (string as_sql)
public function string of_get_textsize ()
public function string of_left_outer_join_from (string as_table1, string as_alias1, string as_table2, string as_alias2)
public function integer of_setrowlimitsql (ref string as_sql, long al_limit, n_tr ltr_use)
end prototypes

public function string of_get_days_diff (string as_column1, string as_column2);//*********************************************************************************
// Script Name:	of_get_days_diff
//
//	Arguments:		1.	as_column1
//						2.	as_column2
//
// Returns:			String
//
//	Description:	This function will get the SQL to determine the difference 
//						(in days) between two dates.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''


end function

public function string of_get_days_diff (string as_sql);//*********************************************************************************
// Script Name:	of_get_days_diff
//
//	Arguments:		as_sql - formatted '@DAYSDIFF(as_column1,as_column2)'
//
// Returns:			String
//
//	Description:	This is an overloaded function.  This function will parse 
//						as_sql and call of_get_days_diff(as_column1, as_column2).
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Integer		li_pos,				&
				li_pos2

String		ls_column1,			&
				ls_column2
				

// Edit the input

IF	IsNull(as_sql)				&
OR	Trim (as_sql)	=	''		THEN
	Return	''
END IF


//	Get the 1st column - between '(' and ','
li_pos	=	Pos (as_sql, '(')
li_pos2	=	Pos (as_sql, ',')

IF	li_pos	=	0		&
OR	li_pos2	=	0		THEN
	Return	''
END IF

ls_column1	=	Trim (Mid (as_sql, li_pos + 1,  li_pos2 - li_pos - 1) )

//	Get the 2nd column - between ',' and ')'
li_pos	=	Pos (as_sql, ',')
li_pos2	=	Pos (as_sql, ')')

IF	li_pos	=	0		&
OR	li_pos2	=	0		THEN
	Return	''
END IF

ls_column2	=	Trim (Mid (as_sql, li_pos + 1,  li_pos2 - li_pos - 1) )

Return	This.of_get_days_diff(ls_column1, ls_column2)


end function

public subroutine of_set_dbms (string as_value);//*********************************************************************************
// Script Name:	of_set_dbms
//
//	Arguments:		as_value - DBMS value from Stars.ini
//
// Returns:			None
//
//	Description:	Store the DBMS value (from STARS.ini).  This function will
//						only reside in n_cst_sql.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************


// Edit input - default to 'ASE'
IF	IsNull (as_value)			&
OR	Trim (as_value)	=	''		THEN
	is_dbms	=	ics_ase
	Return
END IF

is_dbms	=	as_value

end subroutine

public function string of_get_dbms ();//*********************************************************************************
// Script Name:	of_get_dbms
//
//	Arguments:		None
//
// Returns:			String - 'ASE', 'ORA' or 'UDB'
//
//	Description:	Return the DBMS string used.  This function will only
//						reside in n_cst_sql.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	is_dbms

end function

public function string of_get_to_number (string as_column);//*********************************************************************************
// Script Name:	of_get_to_number
//
//	Arguments:		as_column - Number column name
//
// Returns:			String.
//						ASE -	Convert(Int, as_column) or Convert(Money, as_column)
//						ORA - To_Number(as_column)
//						UDB - Dec(as_column)
//
//	Description:	This function converts a string to a number in SQL.
//						
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function long of_get_dup1_insert ();//*********************************************************************************
// Script Name:	of_get_dup1_insert
//
//	Arguments:		None
//
// Returns:			Long
//
//	Description:	This function will return the 1st database return code
//						for a duplicate key insert.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	99999

end function

public function long of_get_dup2_insert ();//*********************************************************************************
// Script Name:	of_get_dup2_insert
//
//	Arguments:		None
//
// Returns:			Long
//
//	Description:	This function will return the 2nd database return code
//						for a duplicate key insert.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	99999

end function

public function integer of_table_exists (string as_table);//*********************************************************************************
// Script Name:	of_table_exists
//
//	Arguments:		as_table - Table name
//
// Returns:			Integer
//						-1 -	Database error
//						 0	-	Table does not exist
//						 1	-	Table exists
//
//	Description:	Determine if the table name passed to this function exists
//						by reading the appropriate system table.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	-1



end function

public function string of_get_to_money (string as_column);//*********************************************************************************
// Script Name:	of_get_to_money
//
//	Arguments:		as_column - Number column name
//
// Returns:			String.
//						ASE -	Convert(Money, as_column)
//						ORA - To_Number(as_column)
//						UDB - Dec(as_column)
//
//	Description:	This function converts a string to a 'Money' in SQL.
//						
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function string of_left_outer_join_where (string as_column1, string as_column2);//*********************************************************************************
// Script Name:	of_get_left_outer_join_where
//
//	Arguments:		as_column1 - includes table1name.column1name
//						as_column2 - includes table2name.column2name
//
// Returns:			String
//						ASE - 'as_column1 *= as_column2'
//						ORA - 'as_column1 = as_column2(+)'
//						UDB - ''
//
//	Description:	This function will create the SQL 'Where' clause for a left
//						outer join.  
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function string of_left_outer_join_where (string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2);//*********************************************************************************
// Script Name:	of_get_left_outer_join_where
//
//	Arguments:		as_table1	1st table name
//						as_column1	1st column name
//						as_alias1	1st alias name (i.e. 'PV' or 'C2')
//						as_table2	2nd table name
//						as_column2	2nd column name
//						as_alias2	2nd alias name (i.e. 'PV' or 'C2')
//
// Returns:			String
//						ASE - 'as_alias1.as_column1 *= as_alias1.as_column2'
//						ORA - 'as_alias1.as_column1 = as_alias2.as_column2(+)'
//						UDB - ''
//
//	Description:	This function will create the SQL 'Where' clause for a left
//						outer join.  
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function string of_get_to_char (string as_column);//*********************************************************************************
// Script Name:	of_get_to_char
//
//	Arguments:		as_column = A valid ASE convert syntax which includes:
//										1 - The data type and number of characters Ex: VARCHAR(20)
//										2 - The name of the column to be converted Ex: patient_id
//										3 - (Optional)The date display format Ex: 101 = mm/dd/yyyy
//											 See the ASE date format table for valid values
//
//						Valid Examples: as_column = "CHAR(12), getdate(), 3"
//											 as_column = "CHAR(20),rid_id"
//
// Returns:			String
//
//	Description:	This function generates the SQL to convert to a string.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function string of_get_outer_rel_op ();
//*********************************************************************************
// Script Name:	of_get_outer_rel_op
//
//	Arguments:		None
//
// Returns:			is_outer_rel_op
//
//	Description:	This function will return the value of is_outer_rel_op which
//						is set in the Constructor event of all descendants.  This
//						function does not reside in the descendants.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	is_outer_rel_op

end function

public function string of_get_outer_exp2 ();//*********************************************************************************
// Script Name:	of_get_outer_exp2
//
//	Arguments:		None
//
// Returns:			is_outer_exp2
//
//	Description:	This function will return the value of is_outer_exp2 which
//						is set in the Constructor event of all descendants.  This
//						function does not reside in the descendants.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	is_outer_exp2

end function

public function integer of_get_substring (n_ds ands_datastore);//*********************************************************************************
// Script Name:	of_get_substring
//
//	Arguments:		ands_datastore 	= The DataStore of type n_ds that needs
//												  to be checked for use of substring.
//
// Returns:			Integer 				= 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						substring function in the sql, with the appropriate function
//						name stored in is_substring in each of the descendants.
//
//	Usage:			Call this function after setting the Transaction Object
//                to the passed DataStore, but prior to retrieval.
//						The SQL may not contain double quotes (") as Modify will fail.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

String	ls_sql

// Validate the argument
IF IsNull( ands_datastore ) OR NOT IsValid( ands_datastore ) THEN Return -1

// Get the SQL of datastore
ls_sql = ands_datastore.GetSQLSelect()

// Parse the SQL to be converted
If of_get_substring( ls_sql ) = -1 THEN Return -1

// Reset the converted SQL back to the control
IF ands_datastore.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' ) <> "" THEN Return -1

RETURN 1
end function

public function integer of_get_substring (datawindowchild adwc_datawindowchild);//*********************************************************************************
// Script Name:	of_get_substring
//
//	Arguments:		adwc_datawindowchild	= The child datawindow of type datawindowchild
//													  that needs to be checked for use of substring.
//
// Returns:			Integer 				   = 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						substring function in the sql, with the appropriate function
//						name stored in is_substring in each of the descendants.
//
//	Usage:			Call this function after setting the Transaction Object
//                to the passed child DataWindow, but prior to retrieval.
//						The SQL may not contain double quotes (") as Modify will fail.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

String	ls_sql

// Validate the argument
IF IsNull( adwc_datawindowchild ) OR NOT IsValid( adwc_datawindowchild ) THEN Return -1

// Get the SQL of child datawindow
ls_sql = adwc_datawindowchild.GetSQLSelect()

// Parse the SQL to be converted
If of_get_substring( ls_sql ) = -1 THEN Return -1

// Reset the converted SQL back to the control
IF adwc_datawindowchild.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' ) <> "" THEN Return -1

RETURN 1
end function

public function integer of_setup_transactions (string as_userid, string as_password);//*********************************************************************************
// Script Name:	of_setup_transactions
//
//	Arguments:		1.	as_userid
//						2.	as_password
//
// Returns:			Integer
//						 1	-	Success
//						-1	-	Error
//
//	Description:	This function will setup the global transactions based on the userid
//						and password passed.  ASE uses the ID and password passed whereas
//						the other DBMSs uses a fixed userid and password read from
//						Stars Server.
//
//*********************************************************************************
//	
// 12/04/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	1

end function

public function boolean of_is_bad_connection (integer ai_rc);//*********************************************************************************
// Script Name:	of_is_bad_connection
//
//	Arguments:		ai_rc - Return code originally returned from the DBMS
//
// Returns:			Boolean
//						TRUE	-	Can't connect because of a User ID or password.
//						FALSE	-	Can't connect because of of other reasons.
//
//	Description:	This function will determine if the user cannot connect to
//						the database because of an invalid database ID or password.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************


Return	FALSE

end function

public function string of_get_to_date (string as_date);//*********************************************************************************
// Script Name:	of_get_to_date
//
//	Arguments:		as_date - Datetime column name
//
// Returns:			String.
//						ASE -	Convert(DateTime, as_date)
//						ORA - To_Date(as_date,'MM/DD/YYYY')
//						UDB - TimeStamp(as_date)
//
//	Description:	This function converts a string to a datetime in SQL.
//
// Alert:			For Oracle, as_date must be in the 'MM/DD/YYYY' format.
//						Also, if as_date is a literal, then parse (')
//						single quotes with the string. Ex. ('01/01/1900')
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************


Return	''


end function

public function integer of_get_substring (u_dw audw_datawindow);//*********************************************************************************
// Script Name:	of_get_substring
//
//	Arguments:		audw_datawindow 	= The DataWindow of type u_dw that needs
//												  to be checked for use of substring.
//
// Returns:			Integer 				= 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						substring function in the sql, with the appropriate function
//						name stored in is_substring in each of the descendants.
//
//	Usage:			Call this function after setting the Transaction Object
//                to the passed DataWindow, but prior to retrieval.
//						The SQL may not contain double quotes (") as Modify will fail.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

String	ls_sql

// Validate the argument
IF IsNull( audw_datawindow ) OR NOT IsValid( audw_datawindow ) THEN Return -1

// Get the SQL of datawindow
ls_sql = audw_datawindow.GetSQLSelect()

// Parse the SQL to be converted
If of_get_substring( ls_sql ) = -1 THEN Return -1

// Reset the converted SQL back to the control
IF audw_datawindow.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' ) <> "" THEN Return -1

RETURN 1
end function

public function integer of_get_current_datetime (u_dw adw);//*********************************************************************************
// Script Name:	of_get_current_datetime
//
//	Arguments:		adw = The d/w that contains the ASE 'Getdate()' method.
//
// Returns:			Integer = 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						'Getdate()' function in as_sql, with the appropriate DBMS-specific
//						server date function.
//
//*********************************************************************************
//	
// 12/13/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

String	ls_sql

// Validate the argument
IF IsNull( adw ) OR NOT IsValid( adw ) THEN Return -1

// Get the SQL of datawindow
ls_sql = adw.GetSQLSelect()

// Parse the SQL to be converted
If This.of_get_current_datetime( ls_sql ) = -1 THEN Return -1

// Reset the converted SQL back to the control
IF adw.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' ) <> "" THEN Return -1

RETURN 1
end function

public function boolean of_is_duplicate_insert (integer ai_rc);//*********************************************************************************
// Script Name:	of_is_duplicate_insert
//
//	Arguments:		ai_rc - Return code originally returned from the DBMS
//
// Returns:			Boolean
//						TRUE	-	ai_rc is a duplicate insert return code.
//						FALSE	-	ai_rc is not a duplicate insert return code.
//
//	Description:	This function will determine if ai_rc is a return code 
//						associated with a duplicate insert.
//
//	Note:				This function calls of_get_dup1_insert() and of_get_dup2_insert()
//						which are overloaded in the descendant objects.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Integer	li_rc1,				&
			li_rc2
			
li_rc1	=	This.of_get_dup1_insert()
li_rc2	=	This.of_get_dup2_insert()

IF	ai_rc	=	li_rc1			&
OR	ai_rc	=	li_rc2			THEN
	Return	TRUE
ELSE
	Return	FALSE
END IF


end function

public function string of_get_current_datetime_name ();//*********************************************************************************
// Script Name:	of_get_current_datetime_name
//
//	Arguments:		None
//
// Returns:			String
//						ASE - 'GetDate()'
//						ORA - 'Sysdate'
//						UDB - 'CURRENT TIMESTAMP'
//
//	Description:	This function gets the current datetime column name to be used
//						in SQL.
//
//*********************************************************************************
//	
// 12/13/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function integer of_get_current_datetime (ref string as_sql);//*********************************************************************************
// Script Name:	of_get_current_datetime
//
//	Arguments:		as_sql(By Ref) = The sql that contains the ASE 'Getdate()' method.
//
// Returns:			Integer = 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						'Getdate()' function in as_sql, with the appropriate DBMS-specific
//						server date function.
//
//*********************************************************************************
//	
// 12/13/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

String	ls_getdate

n_cst_string	lnv_string		// Autoinstatiated

// Validate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" THEN
	as_sql	=	""
	Return	-1
END IF

// Convert SQL to upper case
as_sql	=	Upper (as_sql)

// Get the DBMS-specific function name for the current server datetime
ls_getdate	=	This.of_get_current_datetime_name()

// Replace all occurences of "GETDATE()" with is_substring
as_sql = lnv_string.of_GlobalReplace( as_sql, "GETDATE()", ls_getdate )

// Revalidate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" THEN
	as_sql	=	""
	Return	-1
END IF

Return	1
end function

public function datetime of_get_current_datetime ();//*********************************************************************************
// Script Name:	of_get_current_datetime
//
//	Arguments:		None
//
// Returns:			DateTime
//
//	Description:	This function gets the current datetime from the server.
//						The DBMS specific SQL is processed in the descendants.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return	DateTime (Today(), Now())

end function

public function string of_get_database_prefix (string as_prefix);//*********************************************************************************
// Script Name:	of_get_database_prefix
//
//	Arguments:		as_prefix - Database name
//
// Returns:			String
//						ASE - as_prefix + '..'
//						ORA - ''
//						UDB - ''
//
//	Description:	Attach the database name to '..' so it can attached to the
//						table name.
//						
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''

end function

public function integer of_get_substring (ref string as_sql);//*********************************************************************************
// Script Name:	of_get_substring
//
//	Arguments:		as_sql(By Ref) = The sql that contains the ASE substring method.
//
// Returns:			Integer = 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						substring function in as_sql, with the appropriate function
//						name stored in is_substring.  is_substring is initialized in
//						the Constructor event in each of the descendants.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

n_cst_string	lnv_string		// Autoinstatiated

// Validate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" THEN
	as_sql = ""
	Return -1
END IF

// Replace all occurences of 'substring' with is_substring
as_sql = lnv_string.of_GlobalReplace( as_sql, "substring", is_substring )

// Revalidate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" THEN
	as_sql = ""
	Return -1
END IF

RETURN 1
end function

public function integer of_get_current_datetime (n_ds ads);//*********************************************************************************
// Script Name:	of_get_current_datetime
//
//	Arguments:		ads = The datastore that contains the ASE 'Getdate()' method.
//
// Returns:			Integer = 1 Success, -1 Error
//
//	Description:	This function replaces one or more occurrences of the ASE
//						'Getdate()' function in as_sql, with the appropriate DBMS-specific
//						server date function.
//
//*********************************************************************************
//	
// 12/13/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

String	ls_sql

// Validate the argument
IF IsNull( ads ) OR NOT IsValid( ads ) THEN Return -1

// Get the SQL of datawindow
ls_sql = ads.GetSQLSelect()

// Parse the SQL to be converted
If This.of_get_current_datetime( ls_sql ) = -1 THEN Return -1

// Reset the converted SQL back to the control
IF ads.Modify( 'DataWindow.Table.Select="' + ls_sql + '"' ) <> "" THEN Return -1

RETURN 1
end function

public function string of_get_dw_object (string as_dwobject_name);//*********************************************************************************
// Script Name:	of_get_dw_object
//
//	Arguments:		as_dwobject_name - Datawindow object name
//
// Returns:			String
//						ASE - as_dwobject_name
//						ORA - as_dwobject_name + '_ora'
//						UDB - as_dwobject_name + '_udb'
//
//	Description:	This function will take the datawindow object name as input
//						and return the dbms-specific datawindow object name.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	as_dwobject_name

end function

public subroutine of_set_schema (string as_schema);//*********************************************************************************
// Script Name:	of_set_schema
//
//	Arguments:		as_schema - The schema name returned from Stars Server
//
// Returns:			None
//
//	Description:	This function stores the passed schema name for future use.
//						The schema name is the owner name of the database.  This is primarily
//						used for Oracle because the user will connect to the database using
//						the user's ID and password (DB2 will have to connect using the
//						database owner name and password).  As soon as Oracle connects,
//						a "alter session set current_schema = as_schema" SQL command
//						will be immediately issued to allow the application to access
//						tables without appending the owner name.
//
//*********************************************************************************
//	
// 02/21/01 FDG	Stars 4.7	Created
//
//*********************************************************************************

is_schema	=	as_schema

end subroutine

public function string of_get_schema_sql ();//*********************************************************************************
// Script Name:	of_get_schema_sql
//
//	Arguments:		None
//
// Returns:			String - The SQL to set the schema name in the database.
//
//	Description:	This function returns the SQL to change the owner 
//						name of the database.  This is primarily used for Oracle
//						because the user will connect to the database using the user's ID
//						and password (DB2 will have to connect using the database owner name
//						and password).  As soon as Oracle connects this function will return
//						a "alter session set current_schema = as_schema" SQL command.
//						The other DBMS's will return the empty string because it's not needed.
//						This command (in Oracle) will allow the application to access
//						tables without appending the owner name.
//
//*********************************************************************************
//	
// 02/21/01 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	''


end function

public function string of_get_schema ();//*********************************************************************************
// Script Name:	of_get_schema
//
//	Arguments:		None
//
// Returns:			is_schema - The schema name returned from Stars Server
//
//	Description:	This function returns is_schema.
//						The schema name is the owner name of the database.  This is primarily
//						used for Oracle because the user will connect to the database using
//						the user's ID and password (DB2 will have to connect using the
//						database owner name and password).  As soon as Oracle connects,
//						a "alter session set current_schema = as_schema" SQL command
//						will be immediately issued to allow the application to access
//						tables without appending the owner name.
//
//*********************************************************************************
//	
// 02/21/01 FDG	Stars 4.7	Created
//
//*********************************************************************************

Return	is_schema

end function

public function string of_get_subset_prefix ();//*********************************************************************************
// Script Name:	of_get_subset_prefix
//
//	Arguments:		None
//
// Returns:			String
//
//	Description:	This function gets the prefix for a subset name. 
//						Existing clients = 'SUB_MEDC_'
//						New clients = 'S_'
//
//*********************************************************************************
//	
// 03/12/01 FDG	Stars 4.7	Created
//	04/03/03	GaryR	Track 3505d	The subset row has changed in the dictionary
//
//*********************************************************************************

Integer	li_rc

IF	Len (is_subset_prefix)	>	0		THEN
	Return	is_subset_prefix
END IF

// Get the prefix from dictionary
Select	elem_name
  Into	:is_subset_prefix
  From	dictionary
 Where	elem_type		=	'UT'
   and	elem_tbl_type	=	'SS'
Using		Stars2ca ;

li_rc	=	Stars2ca.of_check_status()

IF	li_rc	<>	0		THEN
	is_subset_prefix	=	'ERROR'
	MessageBox ('Database Error', 'In n_cst_sql.of_get_subset_prefix(), could not retrieve elem_name from ' + &
					'dictionary where elem_type = UT and elem_tbl_type = SS.')
END IF

is_subset_prefix	=	Upper (is_subset_prefix)

Return	is_subset_prefix


end function

public function boolean of_is_character_data_type (string as_data_type);//*********************************************************************************
// Script Name:	of_is_character_data_type
//
//	Arguments:		as_data_type
//
// Returns:			Boolean
//						TRUE	-	as_data_type is a character data type
//						FALSE	-	as_data_type is not a character data type
//
//	Description:	This function will determine if as_data_type is a character data
//						type.
//
//*********************************************************************************
//	
// 12/14/00 FDG	Stars 4.7	Created
//	11/13/02	GaryR	SPR 3370d	Add TEXT
//
//*********************************************************************************

String	ls_data_type

Integer	li_pos

ls_data_type	=	Upper (as_data_type)

// It's possible to have 'char(17)' passed.  If so, remove '(17)'.

li_pos	=	Pos (ls_data_type, '(')

IF	li_pos	>	0		THEN
	ls_data_type	=	Left (ls_data_type, li_pos - 1)
END IF

CHOOSE CASE	ls_data_type
	CASE	'CHAR', 'VARCHAR', 'VARCHAR2', 'STRING', 'TEXT'
		Return	TRUE
	CASE	ELSE
		Return	FALSE
END CHOOSE

end function

public function boolean of_is_date_data_type (string as_data_type);//*********************************************************************************
// Script Name:	of_is_date_data_type
//
//	Arguments:		as_data_type
//
// Returns:			Boolean
//						TRUE	-	as_data_type is a date data type
//						FALSE	-	as_data_type is not a date data type
//
//	Description:	This function will determine if as_data_type is a date data
//						type.
//
//*********************************************************************************
//	
// 12/14/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

as_data_type	=	Upper (as_data_type)

CHOOSE CASE	as_data_type
	CASE	'DATE', 'DATETIME', 'SMALLDATETIME', 'TIMESTAMP'
		Return	TRUE
	CASE	ELSE
		Return	FALSE
END CHOOSE

end function

public function boolean of_is_numeric_data_type (string as_data_type);//*********************************************************************************
// Script Name:	of_is_numeric_data_type
//
//	Arguments:		as_data_type
//
// Returns:			Boolean
//						TRUE	-	as_data_type is a numeric data type
//						FALSE	-	as_data_type is not a numeric data type
//
//	Description:	This function will determine if as_data_type is a numeric data
//						type.
//
//*********************************************************************************
//	
// 12/14/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

IF	This.of_is_money_data_type (as_data_type)	=	TRUE		&
OR	This.of_is_number_data_type (as_data_type)	=	TRUE		THEN
	Return	TRUE
ELSE
	Return	FALSE
END IF

//as_data_type	=	Upper (as_data_type)
//
//CHOOSE CASE	as_data_type
//	CASE	'MONEY', 'SMALLMONEY', 'SMALLINT', 'INT', 'INTEGER', 'LONG', 'NUMBER(19,4)',  &
//			'NUMBER(10,4)', 'DECIMAL(19,4)', 'DECIMAL(10,4)', 'NUMBER', 'NUMBER(10)',		&
//			'NUMBER(6)', 'NUMBER(3)', 'DECIMAL', 'FLOAT', 'DEC', 'REAL', 'DOUBLE', 'SMALLMON'
//		Return	TRUE
//	CASE	ELSE
//		Return	FALSE
//END CHOOSE


end function

public function integer of_setupper (powerobject apo_requestor);//*********************************************************************************
// Script Name:	of_SetUpper
//
//	Arguments:		apo_requestor = DataWindow (u_dw) or DataStore (n_ds)
//
// Returns:			Integer = 1 Success, -1 Error
//
//	Description:	This method converts specified character data fields to be updated 
//						where the tag = ;UPPER; in the datawindow/datastore to upper case.
//						See additional comments in the constructor event of u_dw or n_ds.
//
//*********************************************************************************
//	
// 02/14/01 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Long		ll_mod_row, ll_col_cnt, ll_col_ctr
String	ls_coltype, ls_colname, ls_coltag, ls_colvalue

// Validate the argument
IF IsNull( apo_requestor ) OR NOT IsValid( apo_requestor ) THEN Return -1
IF apo_requestor.TypeOf() <> DataWindow! &
AND apo_requestor.TypeOf() <> DataStore! THEN Return -1

// Get next modified row
ll_mod_row = apo_requestor.Dynamic GetNextModified( ll_mod_row, Primary! )

// Loop through each modified row
DO WHILE ll_mod_row <> 0	
	// Obtain the column count
	ll_col_cnt = Long( apo_requestor.Dynamic Describe( "DataWindow.Column.Count" ) )
	
	// Loop through each column
	FOR ll_col_ctr = 1 TO ll_col_cnt		
		// Check if this column is modified
		IF apo_requestor.Dynamic GetItemStatus( ll_mod_row, ll_col_ctr, Primary! ) <> DataModified! THEN Continue
		
		// Obtain the name of current column
		ls_colname = apo_requestor.Dynamic Describe( "#" + String( ll_col_ctr ) + ".Name" )
		
		// Validate the column's tag value
		ls_coltag = apo_requestor.Dynamic Describe( ls_colname + ".Tag" )
		IF Pos( Upper( ls_coltag ), ics_upper ) = 0 THEN Continue
		
		// Check if this is character field
		ls_coltype = apo_requestor.Dynamic Describe( ls_colname + ".ColType" )
		IF Upper( Left( Trim( ls_coltype ), 4 ) ) <> "CHAR" THEN Continue
				
		// Convert the value in current row/column to UPPER CASE
		ls_colvalue = apo_requestor.Dynamic GetItemString( ll_mod_row, ll_col_ctr )
		IF IsNull( ls_colvalue ) OR Trim( ls_colvalue ) = "" THEN Continue
		apo_requestor.Dynamic SetItem( ll_mod_row, ll_col_ctr, Upper( ls_colvalue ) )
	NEXT
	
	// Get next modified row
	ll_mod_row = apo_requestor.Dynamic GetNextModified( ll_mod_row, Primary! )
LOOP

Return 1
end function

public function boolean of_is_money_data_type (string as_data_type);//*********************************************************************************
// Script Name:	of_is_money_data_type
//
//	Arguments:		as_data_type
//
// Returns:			Boolean
//						TRUE	-	as_data_type is a numeric data type
//						FALSE	-	as_data_type is not a numeric data type
//
//	Description:	This function will determine if as_data_type is a money data
//						type.
//
//*********************************************************************************
//	
// 12/14/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

String	ls_data_type

Integer	li_pos,				&
			li_pos2

ls_data_type	=	Upper (as_data_type)

// If a precision and scale is passed (i.e. '(19,4)'), then it's a money data type).
//	If a precision is passed without a scale (i.e. '(10)'), then it's not a money data type

li_pos	=	Pos (ls_data_type, '(')

IF	li_pos	>	0		THEN
	li_pos2	=	Pos (ls_data_type, ',', li_pos + 1)
	IF	li_pos2	>	0		THEN
		// Precision and scale was passed.
		Return	TRUE
	ELSE
		// Precision with no scale is passed.
		Return	FALSE
	END IF
END IF

CHOOSE CASE	ls_data_type
	CASE	'MONEY', 'SMALLMONEY', 'DECIMAL', 'FLOAT', 	&
			'DEC', 'REAL', 'DOUBLE', 'SMALLMON'
		Return	TRUE
	CASE	ELSE
		Return	FALSE
END CHOOSE

end function

public function boolean of_is_number_data_type (string as_data_type);//*********************************************************************************
// Script Name:	of_is_number_data_type
//
//	Arguments:		as_data_type
//
// Returns:			Boolean
//						TRUE	-	as_data_type is a numeric data type
//						FALSE	-	as_data_type is not a numeric data type
//
//	Description:	This function will determine if as_data_type is a number 
//						(non-money) data type.
//
//*********************************************************************************
//	
// 12/14/00 FDG	Stars 4.7	Created
//	11/13/02	GaryR	SPR 3370d	Resolve data types
//	11/13/02	GaryR	SPR 3370d	Long needs to remain here because PB's long is numeric
//
//*********************************************************************************

String	ls_data_type

Integer	li_pos,				&
			li_pos2

ls_data_type	=	Upper (as_data_type)

// If a precision and scale is passed (i.e. '(19,4)'), then it's not a number data type).

li_pos	=	Pos (ls_data_type, '(')

IF	li_pos	>	0		THEN
	li_pos2	=	Pos (ls_data_type, ',', li_pos + 1)
	IF	li_pos2	>	0		THEN
		// Precision and scale was passed.
		Return	FALSE
	ELSE
		// Precision was passed without a scale.  Remove the precision.
		ls_data_type	=	Left (ls_data_type, li_pos - 1)
	END IF
END IF

CHOOSE CASE	ls_data_type
	CASE	'SMALLINT', 'INT', 'INTEGER', 'NUMBER', 'TINYINT', 'LONG'
		Return	TRUE
	CASE	ELSE
		Return	FALSE
END CHOOSE
end function

public function integer of_setrowlimit (ref string as_sql, long al_limit, n_tr ltr_use);//*********************************************************************************
// Script Name:	of_SetRowLimit
//
//	Arguments:		String	=	(Ref)	as_sql
//						Long		=	al_limit
//						n_tr		=	ltr_use
//
// Returns:			Integer	=	1 Success, -1 Error
//
//	Description:	This method limits the retrieval of rows to the 
//						specified number for the specified transaction object.
//
//*********************************************************************************
//	
// 10/29/01 GaryR	Stars 5.0.0	Created
//
//*********************************************************************************

RETURN 1
end function

public function integer of_trimdata (ref string as_data);//*********************************************************************************
// Script Name:	of_TrimData
//
//	Arguments:		String	=	(Ref)	as_data
//
// Returns:			Integer	=	1 Success, -1 Error
//
//	Description:	This method trims the data (as_data) and, if neccessary,
//						converts the empty string to be DBMS independent (is_empty).
//						DATABASE		Empty
//						--------		-------
//						ASE			"" 
//						Oracle		" "
//						UDB			" "
//
//*********************************************************************************
//	
// 04/12/01 GaryR	Stars 4.7	Created
//	09/02/05	GaryR	Track 4492d	Accomodate trailing spaces in data
//
//*********************************************************************************

// Validate the argument
IF IsNull( as_data ) THEN Return -1

// Trim the data
as_data = RightTrim( as_data )

// If data is an empty string, then
// set the DBMS specific empty string
IF as_data = "" THEN as_data = is_empty

RETURN 1
end function

public function integer of_get_alias (ref string as_select);//*********************************************************************************
// Script Name:	of_get_alias
//
//	Arguments:		as_select(By Ref) = The portion of the select clause that contains
//												  the ASE specific method for assigning aliases.
//												  Ex: FREQUENCY_AMT = SUM(UNITS_ALLOWED)*1
//
// Returns:			Integer = 1 Success, -1 Error
//
//	Description:	This function parses as_select so that it is DBMS independent.
//
//*********************************************************************************
//	
// 01/25/01 GaryR	Stars 4.7	Created
//
//*********************************************************************************

String	ls_col_alias, ls_col_name, &
			ls_l_comma, ls_r_comma
Integer	li_pos, li_pos_equal

// Validate the argument
IF IsNull( as_select ) OR Trim( as_select ) = "" THEN Return -1

// Make sure that at least one "=" sign is part
// of the string, it is this is the separator.
li_pos = Pos( as_select, "=" )
IF li_pos = 0 THEN Return -1

// Locate the very last instance of "="
DO WHILE li_pos > 0
	li_pos_equal = li_pos
	li_pos = Pos( as_select, "=", li_pos + 1 )
LOOP

// Break out the two portions of the string
ls_col_alias	= Trim( Left( as_select, li_pos_equal - 1 ) )
ls_col_name		= Trim( Mid( as_select, li_pos_equal + 1 ) )

// Strip commas from the beginning and end
IF Left( ls_col_alias, 1 ) = "," THEN
	ls_col_alias = Trim( Right( ls_col_alias, Len( ls_col_alias ) - 1 ) )
	ls_l_comma = ", "
END IF

IF Right( ls_col_name, 1 ) = "," THEN
	ls_col_name = Trim( Left( ls_col_name, Len( ls_col_name ) - 1 ) )
	ls_r_comma = ", "
END IF

// Check if the alias already contains double or single quotes
IF		( Left(	ls_col_alias, 1 )		= '"'		&
AND	Right( ls_col_alias, 1 )		= '"' )	&
OR		( Left( ls_col_alias, 1 ) 		= "'"		&
AND	Right( ls_col_alias, 1 )		= "'" )	THEN
	ls_col_alias = Trim( Mid( ls_col_alias, 2, Len( ls_col_alias ) - 2 ) )	
END IF

ls_col_alias = '"' + ls_col_alias + '"'

// Replace the new converted string with the one originally parsed.
as_select = ls_l_comma + ls_col_name + " " + ls_col_alias + ls_r_comma

RETURN 1
end function

public function integer of_parse (string as_sql, ref n_cst_sqlattrib astr_sql[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Parse
//
//	Access: 			public
//
//	Arguments:
//	as_SQL			The SQL statement to parse.
//	astr_sql[]		An array of sql attributes, passed by
//						reference, to be filled with the parsed SQL.
//
//	Returns:  		integer
//						The number of elements in the array.
//
//	Description:	Parse a SQL statement into its component parts.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Lahu S Stars 5.1   Created	Track 2552d
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_Pos, li_KWNum, li_NumStats, li_Cnt
String	ls_UpperSQL, ls_Keyword[7], ls_Clause[7], ls_SQL[]

// Function requires the string service
n_cst_string  lnv_string

// Separate the statement into multiple statements separated by UNIONs
li_NumStats = lnv_string.of_ParseToArray(as_SQL, "UNION", ls_SQL)

For li_Cnt = 1 to li_NumStats
	// Remove Carriage returns, Newlines, and Tabs
	ls_SQL[li_Cnt] = lnv_string.of_GlobalReplace(ls_SQL[li_Cnt], "~r", " ")
	ls_SQL[li_Cnt] = lnv_string.of_GlobalReplace(ls_SQL[li_Cnt], "~n", " ")
	ls_SQL[li_Cnt] = lnv_string.of_GlobalReplace(ls_SQL[li_Cnt], "~t", " ")

	// Remove leading and trailing spaces
	ls_SQL[li_Cnt] = Trim(ls_SQL[li_Cnt])

	// Convet to upper case
	ls_UpperSQL = Upper(ls_SQL[li_Cnt])

	// Determine what type of SQL this is
	// and assign the appropriate kewords
	// for the corresponding type
	If Left(ls_UpperSQL, 7) = "SELECT " Then
		// Parse the SELECT statement
		ls_Keyword[1] = "SELECT "
		ls_Keyword[2] = " FROM "
		ls_Keyword[3] = " WHERE "
		ls_Keyword[4] = " GROUP BY "
		ls_Keyword[5] = " HAVING "
		ls_Keyword[6] = " ORDER BY "

	Elseif Left(ls_UpperSQL, 7) = "UPDATE " Then
		// Parse the UPDATE statement
		ls_Keyword[1] = "UPDATE "
		ls_Keyword[2] = " SET "
		ls_Keyword[3] = " WHERE "
		ls_Keyword[6] = " ORDER BY "

	Elseif Left(ls_UpperSQL, 12) = "INSERT INTO " Then
		// Parse the INSERT statement (test before 'insert')
		ls_Keyword[1] = "INSERT INTO "
		ls_Keyword[7] = " VALUES "
		
	Elseif Left(ls_UpperSQL, 7) = "INSERT " Then
		// Parse the INSERT statement (test after 'insert to')
		ls_Keyword[1] = "INSERT "
		ls_Keyword[7] = " VALUES "		

	Elseif Left(ls_UpperSQL, 12) = "DELETE FROM " Then
		// Parse the DELETE statement (test before 'delete')
		ls_Keyword[1] = "DELETE FROM "
		ls_Keyword[3] = " WHERE "

	Elseif Left(ls_UpperSQL, 7) = "DELETE " Then
		// Parse the DELETE statement (test after 'delete from')
		ls_Keyword[1] = "DELETE "
		ls_Keyword[3] = " WHERE "
		
	End if

	// There is a maximum of 7 keywords
	For li_KWNum = 7 To 1 Step -1
		If ls_Keyword[li_KWNum] <> "" Then
			// Find the position of the Keyword
			li_Pos = Pos(ls_UpperSQL, ls_Keyword[li_KWNum]) - 1

			If li_Pos >= 0 Then
				ls_Clause[li_KWNum] = Right(ls_SQL[li_Cnt], &
													(Len(ls_SQL[li_Cnt]) - &
														(li_Pos + Len(ls_Keyword[li_KWNum]))))
				ls_SQL[li_Cnt] = Left(ls_SQL[li_Cnt], li_Pos)
			Else
				ls_Clause[li_KWNum] = ""
			End if
		End if
	Next

	astr_sql[li_Cnt].s_Verb = Trim(ls_Keyword[1])

	If Pos(astr_sql[li_Cnt].s_Verb, "SELECT") > 0 Then
		astr_sql[li_Cnt].s_Columns = Trim(ls_Clause[1])
		astr_sql[li_Cnt].s_Tables 	= Trim(ls_Clause[2])
	Else
		astr_sql[li_Cnt].s_Tables = Trim(ls_Clause[1])

		If Pos(astr_sql[li_Cnt].s_Verb, "INSERT") > 0 Then
			li_Pos = Pos(astr_sql[li_Cnt].s_Tables, " ")
			If li_Pos > 0 Then
				astr_sql[li_Cnt].s_Columns = Trim(Right(astr_sql[li_Cnt].s_Tables, &
											(Len(astr_sql[li_Cnt].s_Tables) - li_Pos)))
				astr_sql[li_Cnt].s_Tables = Left(astr_sql[li_Cnt].s_Tables, (li_Pos - 1))
			End if
		Else
			astr_sql[li_Cnt].s_Columns = Trim(ls_Clause[2])
		End if
	End if

	astr_sql[li_Cnt].s_Where 	= Trim(ls_Clause[3])
	astr_sql[li_Cnt].s_Group 	= Trim(ls_Clause[4])
	astr_sql[li_Cnt].s_Having 	= Trim(ls_Clause[5])
	astr_sql[li_Cnt].s_Order 	= Trim(ls_Clause[6])
	astr_sql[li_Cnt].s_Values 	= Trim(ls_Clause[7])
Next

Return li_NumStats


end function

public function string of_assemble (n_cst_sqlattrib astr_sql[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Assemble
//
//	Access: 			public
//
//	Arguments:
//	astr_sql[]		Array of sql attributes, each element containing a
//						SQL statement that will be joined with an UNION.
//
//	Returns:  		String
//						The function returns an empty string if an error
//						was encountered.
//
//	Description:	Build a SQL statement from its component parts.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Lahu S Stars 5.1   Created	Track 2552d
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_NumStats, li_Cnt
String	ls_SQL

li_NumStats = UpperBound(astr_sql[])

For li_Cnt = 1 to li_NumStats

	// Check for valid data
	If Trim(astr_sql[li_Cnt].s_Verb) = "" Or &
		Trim(astr_sql[li_Cnt].s_Tables) = "" Then
		Return ""
	End if

	// If there is more than one statement in the array, they are SELECTs that
	// should be joined by a UNION
	If li_Cnt > 1 Then
		ls_SQL = ls_SQL + " UNION "
	End if

	ls_SQL = ls_SQL + astr_sql[li_Cnt].s_Verb

	If astr_sql[li_Cnt].s_Verb = "SELECT" Then
		If Trim(astr_sql[li_Cnt].s_Columns) = "" Then
			Return ""
		Else
			ls_SQL = ls_SQL + " " + astr_sql[li_Cnt].s_Columns + &
						" FROM " + astr_sql[li_Cnt].s_Tables
		End if

	Else
		ls_SQL = ls_SQL + " " + astr_sql[li_Cnt].s_Tables

		If astr_sql[li_Cnt].s_Verb = "UPDATE" Then
			ls_SQL = ls_SQL + " SET " + astr_sql[li_Cnt].s_Columns
		Elseif Trim(astr_sql[li_Cnt].s_Columns) <> "" Then
			ls_SQL = ls_SQL + " " + astr_sql[li_Cnt].s_Columns
		End if
	End if

	If Trim(astr_sql[li_Cnt].s_Values) <> "" Then
		ls_SQL = ls_SQL + " VALUES " + astr_sql[li_Cnt].s_Values
	End if

	If Trim(astr_sql[li_Cnt].s_Where) <> "" Then
		ls_SQL = ls_SQL + " WHERE " + astr_sql[li_Cnt].s_Where
	End if

	If Trim(astr_sql[li_Cnt].s_Group) <> "" Then
		ls_SQL = ls_SQL + " GROUP BY " + astr_sql[li_Cnt].s_Group
	End if

	If Trim(astr_sql[li_Cnt].s_Having) <> "" Then
		ls_SQL = ls_SQL + " HAVING " + astr_sql[li_Cnt].s_Having
	End if

	If Trim(astr_sql[li_Cnt].s_Order) <> "" Then
		ls_SQL = ls_SQL + " ORDER BY " + astr_sql[li_Cnt].s_Order
	End if
Next

Return ls_SQL

end function

public function string of_left_outer_join_on (string as_where[]);//*********************************************************************************
// Script Name:	of_left_outer_join_on
//
//	Arguments:		as_where - The string array that contains the where criteria
//
// Returns:			String
//						ASE -	The reorganized array
//						ORA - ''
//						UDB -	''
//
//	Description:	This function will reorganize the original where array into a single 
//						string for Sybase only. It moves the join criteria to the 'top'
//						to create ANSI 92 compliant SQL due to a Sybase issue with doing a 
//						left outer join with 'OR' criteria on the 'right' table.
//
//*********************************************************************************
//	
// 6/24/02 MikeFl	Track 3495c. Wrote function.
//
//*********************************************************************************

RETURN ' '
end function

public function string of_get_note_text (string as_note_id, string as_rel_type, string as_rel_id);//*********************************************************************************
// Script Name:	of_get_note_text
//
//	Arguments:		1.	as_note_id
//						2.	as_rel_type 
//						3.	as_rel_id
//
// Returns:			String
//
//	Description:	This function will return the note_text from table notes.
//
//*********************************************************************************
//	
// 12/12/00 FDG	Stars 4.7	Created
//	09/17/02	GaryR	Track 4182c	Pass three unique key arguments for notes retrieval
//	07/21/03	GaryR	Track	5273c	Oracle limits string literals to 2000 bytes
//
//*********************************************************************************

String	ls_text
Blob		lbl_text

// Edit the input
IF	IsNull (as_note_id)			&
OR	Trim (as_note_id)	=	''	&
OR	IsNull (as_rel_type)			&
OR	Trim (as_rel_type)	=	''	&
OR	IsNull (as_rel_id)			&
OR	Trim (as_rel_id)		=	''	THEN
	Return	''
END IF

SELECTBLOB	note_text
INTO			:lbl_text
FROM			notes
WHERE			note_id  =  Upper( :as_note_id )
AND			note_rel_type  =  Upper( :as_rel_type )
AND			note_rel_id		=	Upper( :as_rel_id )
USING			Stars2ca ;

IF	Stars2ca.of_check_status()	<	0		THEN
	Return	''
END IF

ls_text	=	String (lbl_text)

Return	ls_text
end function

public function string of_get_to_upper (string as_column);//*********************************************************************************
// Script Name:	of_get_to_upper
//
//	Arguments:		as_column = The name of the column to be converted Ex: code_desc
//
// Returns:			String
//
//	Description:	This function generates the SQL to convert a string column to upper
//						case.  This is generally used for Oracle to convert the left side 
//						of	the where clause to upper case.  Sybase is case insensitive.
//
//*********************************************************************************
//	
// 03/11/03	GaryR	Track 3445d	Created
//
//*********************************************************************************

Return	as_column

end function

public function integer of_remove_time (ref string as_column);//***********************************************************************************
// Script Name:	of_remove_time
//
//	Arguments:		as_column (ref)
//						The name of the date column for which you want to remove the time
//
// Returns:			Integer
//
//	Description:	This function generates the SQL to remove the time from a date column
//
//***********************************************************************************
//	
//	05/14/03	GaryR	Track 3546d	Created
//
//***********************************************************************************

Return	1

end function

public function boolean of_is_multiple_select (n_tr atr_check);//*********************************************************************************
// Script Name:	of_is_multiple_select
//
//	Arguments:		atr_check - The transaction object to check
//
// Returns:			Boolean
//						TRUE	-	The subquery or into failed due to multiple results.
//						FALSE	-	The subquery or into did not return multiple results.
//
//	Description:	This function will determine if SQL failed due to multiple
//						results being returned from a subquery or an into clause.
//
//	Example:			select col1 from tbl1 where col2 = (select col2 from tbl2)
//						If the subquery returns more than one row, the SQL fails.
//
//						select col1 into :var1
//						If select returns more than one row, the SQL fails.
//
//*********************************************************************************
//	
//	06/03/03	GaryR	Track 5497c	Created
//
//*********************************************************************************

Return atr_check.SQLErrText = "Select returned more than one row"
end function

public function integer of_set_note_text (string as_note_text, string as_note_id, string as_rel_type, string as_rel_id);//*********************************************************************************
// Script Name:	of_get_note_text
//
//	Arguments:		1.	as_note_text
//						2.	as_note_id
//						3.	as_rel_type 
//						4.	as_rel_id
//
// Returns:			Integer:	1 - Success, -1 - Error, 0 - No Action
//
//	Description:	This function will update the note_text to table notes.
//						Note that there is no commit statement. Commit should be done
//						from the calling script and in the same transaction.
//
//*********************************************************************************
//	
//	07/21/03	GaryR	Track	5273c	Oracle limits string literals to 2000 bytes
//
//*********************************************************************************

Blob		lbl_text

// Edit the input
IF	IsNull (as_note_id)			&
OR	Trim (as_note_id)	=	''	&
OR	IsNull (as_rel_type)			&
OR	Trim (as_rel_type)	=	''	&
OR	IsNull (as_rel_id)			&
OR	Trim (as_rel_id)		=	''	THEN
	Return	-1
END IF

//	If text is empty do not update
IF IsNull( as_note_text ) OR Trim( as_note_text ) = "" THEN Return 0

lbl_text = Blob( as_note_text )

UPDATEBLOB notes
SET	note_text = :lbl_text
WHERE note_id = Upper( :as_note_id )
AND	note_rel_type = Upper( :as_rel_type )
AND	note_rel_id = Upper( :as_rel_id )
USING	Stars2ca;

IF	stars2ca.sqldbcode	=	il_bad_char	THEN
	MessageBox ('Save Error', 'Some of the characters in this note caused the save process to fail.'	+	&
					'~n~rIf this note was imported from a file saved in MS Word, try saving it in WordPad before importing.'	+	&
					'~n~rAlso, this note does not support formatted tables, drawing objects and double-underlines.', StopSign! )
	Return -1
END IF

Return	1
end function

public function boolean of_get_allow_view_loj (string as_inv_type);
RETURN TRUE
end function

public function string of_get_count_sql (boolean ab_main_view, boolean ab_dep_view, string as_main_type, string as_dep_type, ref boolean ab_use_ds_count);//-----------------------------------------------------------------------------------//
// Object		n_cst_sql
// Function		of_get_count_sql
// Parms			ab_main_view 		boolean	If main table is a view 
//					ab_dep_view 		boolean	If dependent table is a view
//					as_main_type		string	Main table's Invoice Type
//					as_dep_type			string	Dependent table's Invoice Type
//					ab_use_ds_count	boolean	Sets flag to use ds return code as count
// Returns  	string
//-----------------------------------------------------------------------------------// 
// 03/04/04 MikeF SPR 3909d/3921d Added to resolve Sybase performance issue w/ View counts
// 03/22/04 MikeF SPR 3951d Added Main table type to parameters
//-----------------------------------------------------------------------------------// 
ab_use_ds_count = FALSE
RETURN "SELECT COUNT(*) "
end function

public function string of_get_session_sql ();//*********************************************************************************
// Script Name:	of_get_session_sql
//
//	Arguments:		None
//
// Returns:			String - The SQL to set the CLIENT_IDENTIFIER in the database.
//
//	Description:	This function returns the SQL to set the CLIENT_IDENTIFIER  
//						to the current application user.  This is primarily used for Oracle.
//						The other DBMS's will return the empty string because it's not needed.
//						This command (in Oracle) will uniquely identify a process in the database.
//						For more information refer to the following webpage:
//						http://www.databasejournal.com/features/oracle/article.php/3435431
//
//*********************************************************************************
//	
//	12/17/04	GaryR	Track 4142d	Identify individual user sessions in the database
//
//*********************************************************************************

Return	''


end function

public subroutine of_set_userid (string as_user_id);////////////////////////////////////////////////////////////////////////////////
//
//	12/17/04	GaryR	Track 4142d	Identify individual user sessions in the database
//
////////////////////////////////////////////////////////////////////////////////

is_app_userid = as_user_id
end subroutine

public function string of_get_to_date_no_time (string as_date, boolean as_field_ind);//*********************************************************************************
// Script Name:	of_get_to_date_no_time
//
//	Arguments:		as_date - Datetime column name
//						as_field_ind - Indicates that this is a field and does not need the To_date because
//								it is already properly formatted.  
//
// Returns:			String.
//						ASE -	Convert(Date, as_date)
//						ORA - To_Date(as_date,'MM/DD/YYYY')
//						UDB - TimeStamp(as_date)
//
//	Description:	This function converts a string to a date without a time stamp in SQL.
//
// Alert:			For Oracle, as_date must be in the 'MM/DD/YYYY' format.
//						Also, if as_date is a literal, then parse (')
//						single quotes with the string. Ex. ('01/01/1900')
//
//*********************************************************************************
//	
// 01/16/07	SPR 4869 Starfix 4
//
//*********************************************************************************


Return	''

end function

public function string of_get_database_name (n_tr atr_trans);//*********************************************************************************
// Script Name:		of_get_database_name
//
//	Arguments:		as_prefix - Database name
//
// Returns:			String
//						ASE - atr_trans.database
//						ORA - atr_trans.ServerName
//						UDB - atr_trans.database
//
//	Description:		Get the DB name of the passed in transaction object
//						
//
//*********************************************************************************
//	
//	09/18/06	GaryR	Track 4683	Dynamically set the transaction of ENROLLEE_XREF table
//
//*********************************************************************************

Return	Upper( Trim( atr_trans.database ) )
end function

public function string of_full_outer_join (string as_select, string as_where, string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2);//*********************************************************************************
// Script Name:	of_full_outer_join
//
//	Arguments:		as_select select statement 
//						as_where criteria statement
//						as_table1 first table in join
//						as_column1 first table join column name
//						as_alias1 first table alias
//						as_table2 second table in join
//						as_column2 second table join column name
//						as_alias2 second table alias
//
// Returns:			String
//						ASE - sql statement with union of a left outer join to a right outer join
//						ORA - sql statement with full outer join
//						SQL - sql statement with full outer join
//
//	Description:	This function will create the a complete SQL statement with a full outer join.
//
//*********************************************************************************
//	
// 12/06/06 Katie SPR 4758 Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

String lv_sql_statement

lv_sql_statement = 'SELECT ' + as_select + ' FROM ' + &
				as_table1 + ' ' + as_alias1  + ' FULL OUTER JOIN ' +  as_table2 + ' ' + as_alias2 + &
				' ON ' +  as_alias1 + '.' + as_column1 + '=' +  as_alias2 + '.' + as_column2
				
if (trim(as_where) <> "") then 
	lv_sql_statement = lv_sql_statement + ' WHERE ' + as_where
end if

Return	lv_sql_statement
end function

public function integer of_setrowlimitmultitable (ref string as_sql, long al_limit, n_tr ltr_use);//*********************************************************************************
// Script Name:	of_SetRowLimitMultiTable
//
//	Arguments:		String	=	(Ref)	as_sql
//						Long		=	al_limit
//						n_tr		=	ltr_use
//
// Returns:			Integer	=	1 Success, -1 Error
//
//	Description:	This method limits the retrieval of rows to the 
//						specified number for the specified transaction object.
//
//*********************************************************************************
//	
// 10/29/01 GaryR	Stars 5.0.0	Created
//
//*********************************************************************************

RETURN 1
end function

public function string of_get_norm_case ();//*********************************************************************************
// Script Name:	of_get_norm_case
//
//	Arguments:		None
//
// Returns:			String
//
//	Description:	This function will return the Sybase Case or Oracle Decode 
//						statement for the Norm Analysis Report by Percent Changed
//
//*********************************************************************************
//	
//	05/17/07	GaryR	Track 5026	Prevent divide-by-zero
//
//*********************************************************************************

Return	""
end function

public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2, string as_where3);//*********************************************************************************
// Script Name:	of_full_outer_join
//
//	Arguments:		as_select select statement 
//						as_where1 criteria statement
//						as_table1 first table in join
//						as_column1 first table join column name
//						as_alias1 first table alias
//						as_where2 criteria statement
//						as_table2 second table in join
//						as_column2 second table join column name
//						as_alias2 second table alias
//						as_where3 criteria statement for both tables
//
// Returns:			String
//						ASE - sql statement with union of a left outer join to a right outer join
//						ORA - sql statement with full outer join
//						SQL - sql statement with full outer join
//
//	Description:	This function takes in two arguments for the where, but since 
//						we are using a full outer join they should be combined.
//
//*********************************************************************************
//	
// 08/14/07 Katie SPR 5135 Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

return of_full_outer_join(as_select, "((" + as_where1 + ") or (" + as_where2 + ")) and " + &
			as_where3, as_table1, as_column1, as_alias1, as_table2, as_column2, as_alias2)
end function

public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2);//*********************************************************************************
// Script Name:	of_full_outer_join
//
//	Arguments:		as_select select statement 
//						as_where1 criteria statement
//						as_table1 first table in join
//						as_column1 first table join column name
//						as_alias1 first table alias
//						as_where2 criteria statement
//						as_table2 second table in join
//						as_column2 second table join column name
//						as_alias2 second table alias
//
// Returns:			String
//						ASE - sql statement with union of a left outer join to a right outer join
//						ORA - sql statement with full outer join
//						SQL - sql statement with full outer join
//
//	Description:	This function takes in two arguments for the where, but since 
//						we are using a full outer join they should be combined.
//
//*********************************************************************************
//	
// 08/14/07 Katie SPR 5135 Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

return of_full_outer_join(as_select, "((" + as_where1 + ") or (" + as_where2 + ")) ", &
				as_table1, as_column1, as_alias1, as_table2, as_column2, as_alias2)
end function

public function string of_get_days_add (string as_date, string as_days);//*********************************************************************************
// Script Name:	of_get_days_add
//
//	Arguments:		1.	as_date
//						2.	as_days
//
// Returns:			String
//
//	Description:	This function will get the DBMS specific SQL to add
//						the specified number of days to the provided date.
//
//*********************************************************************************
//	
//	04/11/08	GaryR	SPR 5249	Resolve DBMS dependent logic to increment days
//
//*********************************************************************************

Return	''


end function

public function string of_get_days_add (string as_sql);//*********************************************************************************
// Script Name:	of_get_days_add
//
//	Arguments:		as_sql - formatted '@DAYSADD(as_date,as_days)'
//
// Returns:			String
//
//	Description:	This is an overloaded function.  This function will parse 
//						as_sql and call of_get_days_add(as_date, as_days).
//
//*********************************************************************************
//	
//	04/11/08	GaryR	SPR 5249	Resolve DBMS dependent logic to increment days
//
//*********************************************************************************

Integer		li_pos,			&
				li_pos2
String		ls_date,			&
				ls_days			

// Edit the input
IF	IsNull(as_sql)				&
OR	Trim (as_sql)	=	''		THEN
	Return	''
END IF

//	Get the date - between '(' and ','
li_pos	=	Pos (as_sql, '(')
li_pos2	=	Pos (as_sql, ',')

IF	li_pos	=	0		&
OR	li_pos2	=	0		THEN
	Return	''
END IF

ls_date	=	Trim (Mid (as_sql, li_pos + 1,  li_pos2 - li_pos - 1) )

//	Get the 2nd column - between ',' and ')'
li_pos	=	Pos (as_sql, ',')
li_pos2	=	Pos (as_sql, ')')

IF	li_pos	=	0		&
OR	li_pos2	=	0		THEN
	Return	''
END IF

ls_days	=	Trim (Mid (as_sql, li_pos + 1,  li_pos2 - li_pos - 1) )

Return	This.of_get_days_add(ls_date, ls_days)
end function

public function string of_get_textsize ();//*********************************************************************************
// Script Name:	of_get_textsize
//
//	Arguments:		al_length - Length of the maximum text size
//
// Returns:			String - SQL statement
//						ASE - 'Set textsize 2000000'
//						ORA - ''
//						MSS - 'Set textsize 2147483647'
//
//	Description:	This function will return the SQL required to set the maximum
//						text size for a text/LOB column.
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

Return	''
end function

public function string of_left_outer_join_from (string as_table1, string as_alias1, string as_table2, string as_alias2);//*********************************************************************************
// Script Name:	of_get_left_outer_join_from
//
//	Arguments:		as_table1	1st table name
//						as_alias1	1st alias name (i.e. 'PV' or 'EN')
//						as_table2	2nd table name
//						as_alias2	2nd alias name (i.e. 'PV' or 'EN')
//
// Returns:			String (as_table1 left outer join as_table2)
//
//	Description:	This function will create the SQL 'From' clause for a left outer join
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

Return as_table1 + " " + as_alias1 + " LEFT OUTER JOIN " + as_table2 + " " + as_alias2
end function

public function integer of_setrowlimitsql (ref string as_sql, long al_limit, n_tr ltr_use);//*********************************************************************************
// Script Name:	of_SetRowLimitSQL
//
//	Arguments:		String	=	(Ref)	as_sql
//						Long		=	al_limit
//						n_tr		=	ltr_use
//
// Returns:			Integer	=	1 Success, -1 Error
//
//	Description:	This method limits the retrieval of rows to the 
//						specified number for the specified transaction object.
//
//*********************************************************************************
//	
// 11/10/09 RickB STARS 6.5.0  Created
//
//*********************************************************************************

RETURN 1
end function

on n_cst_sql.create
call super::create
end on

on n_cst_sql.destroy
call super::destroy
end on

event documentation;call super::documentation;/*

These objects will be used to convert SQL to the appropriate DBMS format.  
Object n_cst_sql is the ancestor object and the other objects are descendants 
of n_cst_sql.  For example, n_cst_sql_ora and n_cst_sql_ase are inherited 
from n_cst_sql.  Each function will exist in every object including n_cst_sql.  
The functions that exist in n_cst_sql are used as an "interface" (similar to 
Java) only where they exist, but provide no functionality.  

Inheritance structure:

										n_cst_sql
										    |
		----------------------------------------------------------
		|									 |										|
n_cst_sql_ase					n_cst_sql_ora						n_cst_sql_udb


Global variable gnv_sql is declared of type n_cst_sql.  However, one of its
descendants will be instantiated depending on which DBMS is being used.


*/

end event

