HA$PBExportHeader$n_cst_sql_ora.sru
$PBExportComments$Inherited from n_cst_sql <logic>
forward
global type n_cst_sql_ora from n_cst_sql
end type
end forward

global type n_cst_sql_ora from n_cst_sql
string is_substring = "substr"
long il_bad_char = 1704
end type
global n_cst_sql_ora n_cst_sql_ora

type variables

end variables

forward prototypes
public function datetime of_get_current_datetime ()
public function long of_get_dup1_insert ()
public function long of_get_dup2_insert ()
public function string of_get_dw_object (string as_dwobject_name)
public function string of_get_to_number (string as_column)
public function string of_get_to_money (string as_column)
public function string of_get_to_char (string as_column)
public function string of_left_outer_join_where (string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2)
public function string of_left_outer_join_where (string as_column1, string as_column2)
public function boolean of_is_bad_connection (integer ai_rc)
public function integer of_table_exists (string as_table)
public function string of_get_database_prefix (string as_prefix)
public function string of_get_current_datetime_name ()
public function string of_get_to_date (string as_date)
public function string of_get_schema_sql ()
public function integer of_setup_transactions (string as_userid, string as_password)
public function integer of_setrowlimit (ref string as_sql, long al_limit, n_tr ltr_use)
public function string of_get_days_diff (string as_column1, string as_column2)
public function string of_get_to_upper (string as_column)
public function integer of_remove_time (ref string as_column)
public function string of_get_session_sql ()
public function string of_get_to_date_no_time (string as_date, boolean as_field_ind)
public function string of_get_database_name (n_tr atr_trans)
public function integer of_setrowlimitmultitable (ref string as_sql, long al_limit, n_tr ltr_use)
public function string of_get_norm_case ()
public function string of_get_days_add (string as_date, string as_days)
public function string of_left_outer_join_from (string as_table1, string as_alias1, string as_table2, string as_alias2)
public function integer of_setrowlimitsql (ref string as_sql, long al_limit, n_tr ltr_use)
end prototypes

public function datetime of_get_current_datetime ();//*********************************************************************************
// Script Name:	of_get_current_datetime
//
//	Arguments:		None
//
// Returns:			DateTime
//
//	Description:	This function gets the current datetime from the server.
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

DateTime		ldtm_date,						&
				ldtm_server_date_time

Integer		li_rc
 
Select sysdate
Into	:ldtm_date 
From	dual
Using Stars2ca;

li_rc = Stars2ca.of_check_status()

IF li_rc	<>	0		THEN
	ldtm_server_date_time	=	DateTime (Today(), Now())
ELSE
	ldtm_server_date_time	=	ldtm_date
END IF

Return	ldtm_server_date_time

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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return	1

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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return	2261

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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return	as_dwobject_name + "_ora"

end function

public function string of_get_to_number (string as_column);//*********************************************************************************
// Script Name:	of_get_to_number
//
//	Arguments:		as_column - Column to be converted to a number
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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

// Edit the input
IF	IsNull(as_column)				&
OR	Trim (as_column)	=	''		THEN
	Return	''
END IF

Return	"TO_NUMBER(" + as_column + ")"
end function

public function string of_get_to_money (string as_column);//*********************************************************************************
// Script Name:	of_get_to_money
//
//	Arguments:		as_column - Column name to be converted to a number
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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return of_get_to_number( as_column )
end function

public function string of_get_to_char (string as_column);//*********************************************************************************
// Script Name:	of_get_to_char
//
//	Arguments:		as_column = A valid ASE convert syntax which includes:
//										1 - The data type and number of characters Ex: VARCHAR(20)
//										2 - The name of the column to be converted Ex: patient_id
//										3 - (Optional)The date display format Ex: 101 = mm/dd/yyyy
//											 See the ASE date format table for valid values
//											 All dates will be formatted to a 4-digit year
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

String	ls_check, ls_column, ls_format
Integer	li_pos


// Edit the input
IF	IsNull(as_column) OR	Trim (as_column)	=	""	THEN RETURN ""

// Extract the column name
li_pos = Pos( as_column, "," )

IF	li_pos = 0 THEN RETURN ""
ls_check = Trim( Mid( as_column, li_pos + 1 ) )

// Extract the format
li_pos = Pos( ls_check, "," )

IF	li_pos = 0 THEN
	ls_column = ls_check
	ls_format = ""
ELSE
	ls_column = Trim( Left( ls_check, li_pos - 1 ) )
	ls_format = Trim( Mid( ls_check, li_pos + 1 ) )
	
	// Format the string
	CHOOSE CASE ls_format
		CASE "0", "100"
			ls_format = ",'MON DD YYYY HH:MIPM'"
		CASE "1", "101"
			ls_format = ",'MM/DD/YYYY'"
		CASE "2", "102"
			ls_format = ",'YYYY.MM.DD'"
		CASE "3", "103"
			ls_format = ",'DD/MM/YYYY'"
		CASE "4", "104"
			ls_format = ",'DD.MM.YYYY'"
		CASE "5", "105"
			ls_format = ",'DD-MM-YYYY'"
		CASE "6", "106"
			ls_format = ",'DD MON YYYY'"
		CASE "7", "107"
			ls_format = ",'MON DD, YYYY'"
		CASE "8", "108"
			ls_format = ",'HH:MI:SS'"
		CASE "9", "109"
			ls_format = ",'MON DD YYYY HH:MI:SSPM'"
		CASE "10", "110"
			ls_format = ",'MM-DD-YYYY'"
		CASE "11", "111"
			ls_format = ",'YYYY/MM/DD'"
		CASE "12", "112"
			ls_format = ",'YYYYMMDD'"
	END CHOOSE
END IF

// Return the valid syntax
RETURN	"TO_CHAR(" + ls_column + ls_format + ")"

end function

public function string of_left_outer_join_where (string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2);//*********************************************************************************
// Script Name:	of_left_outer_join_where
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

String	ls_where

// Edit the input
IF	IsNull (as_alias1)	OR	Trim (as_alias1) = ''		THEN
	IF	IsNull (as_table1)	OR	Trim (as_table1) = ''	THEN
		ls_where	=	as_column1	+	' = '	+	as_column2	+	'(+)'
	ELSE
		ls_where	=	as_table1	+	'.'	+	as_column1	+	' = '	+	&
						as_table2	+	'.'	+	as_column2	+	'(+)'
	END IF
ELSE
	ls_where	=	as_alias1	+	'.'	+	as_column1	+	' = '	+	&
					as_alias2	+	'.'	+	as_column2	+	'(+)'
END IF

Return	ls_where


end function

public function string of_left_outer_join_where (string as_column1, string as_column2);//*********************************************************************************
// Script Name:	of_left_outer_join_where
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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

// Validate the arguments
IF	IsNull(as_column1)				&
OR	Trim (as_column1)	=	''			&
OR	Pos (as_column1, '.') = 0	THEN
	Return	''
END IF

IF	IsNull(as_column2)				&
OR	Trim (as_column2)	=	''			&
OR Pos (as_column2, '.') = 0	THEN
	Return	''
END IF

// Return the new where clause
Return	as_column1 + ' = ' + as_column2 + "(+)"
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

CHOOSE CASE	ai_rc
	CASE	1017, 1435
		Return	TRUE
	CASE	ELSE
		Return	FALSE
END CHOOSE

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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Long		ll_count
as_table = Upper(as_table)	

// See if the table name exists in the user_table system table
SELECT 	 count(*)
INTO		:ll_count
FROM		 user_tables
WHERE		 table_name = :as_table
USING		 Stars2ca;

// Check the SQL status

CHOOSE CASE Stars2ca.of_check_status()
	CASE IS < 0
		// Bad return code from SQL
		Return	-1
	CASE 100
		// Table name does not exist
		Return	0
	CASE ELSE		
		// Check if the table name does not
		// currently exist so it can be used.
		If IsNull(ll_count)	&
		Or ll_count < 1		Then Return 0		
END CHOOSE

// Table name found
Return	1

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
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Return	""

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

Return	'Sysdate'

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
//	Description:	This function converts a string to a datetime in SQL.  This
//						function must account for multiple date values.
//
// Alert:			For Oracle, as_date must be in the 'MM/DD/YYYY' format.
//						also, if as_date is a literal, then parse (')
//						single quotes with the string. Ex. ("'01/01/1900'")
//						If parsing time, then it must be in military format
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Constant	String	lcs_convert	=	"TO_DATE("

String		ls_date,			&
				ls_string,		&
				ls_format

Integer		li_pos,			&
				li_pos2,			&
				li_length

// Edit the input
IF	IsNull(as_date)				&
OR	Trim (as_date)	=	''		THEN
	Return	''
END IF

ls_format	=	",'MM/DD/YYYY')"

// If the SQL was already converted, get out.
li_pos		=	Pos (as_date, lcs_convert)

IF	li_pos	>	0		THEN
	Return	as_date
END IF

n_cst_string		lnv_string		// Autoinstantiated

// Hard-coded dates may or may not have quotes surrounding it.
// Make sure all hard-coded dates include only one single-quote.
ls_date		=	Trim (as_date)

li_pos		=	Pos (ls_date, "'")

IF	li_pos	>	0		THEN
	// Remove the quotes passed to this function
	ls_date	=	lnv_string.of_globalreplace (ls_date, "'", "")
END IF

// If the date is hard-coded, surround it with quotes
li_pos		=	Pos (ls_date, "/")

IF	li_pos	>	0		THEN
	// Hard-coded date.  Surround it with quotes.
	// Also, handle the possibility of multiple dates and with a time.
	// Determine if a time was also passed
	li_pos	=	Pos (ls_date, ' ', li_pos + 1)
	IF	li_pos	>	0		THEN
		ls_format	=	",'MM/DD/YYYY HH24:MI:SS')"
	END IF
	// Determine if multiple dates were passed.
	li_pos	=	Pos (ls_date, ",")
	IF	li_pos	=	0		THEN
		// Only one date
		ls_date	=	"'"	+	ls_date	+	"'"
		Return	lcs_convert	+	ls_date	+	ls_format
	ELSE
		// Multiple dates exist
		li_pos2	=	1
		DO WHILE	li_pos	>	0
			li_length	=	li_pos	-	li_pos2
			ls_string	=	ls_string	+	","						+	&
								lcs_convert	+	"'"						+	&
								Mid (ls_date, li_pos2, li_length)	+	&
								"'"	+	ls_format
			li_pos2	=	li_pos	+	1
			li_pos	=	Pos (ls_date, ",", li_pos2)
		LOOP
		// Add the last date and remove the leading ","
		ls_string	=	ls_string	+	","		+	&
							lcs_convert	+	"'"		+	&
							Mid (ls_date, li_pos2)	+	&
							"'"	+	ls_format
		ls_string	=	Mid (ls_string, 2)
		Return	ls_string
	END IF
ELSE
	// Date is not hard-coded
	Return	lcs_convert	+	ls_date	+	ls_format
END IF


end function

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

String	ls_sql

IF	IsNull (is_schema)				&
OR	Trim (is_schema)	<	' '		THEN
	Return	''
END IF

ls_sql	=	"alter session set current_schema = "	+	is_schema

Return	ls_sql

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
//						Oracle will be connected to with the user's ID and password
//						immediately after connecting of_set_schema will be issued.
//
//*********************************************************************************
//	
// 12/04/00 FDG	Stars 4.7	Created
//	09/20/01	GaryR	Stars 4.7	Centralize all connection parms
//
//*********************************************************************************

String		ls_dbparm

SQLCA.DBMS       			=	ProfileString(gv_ini_path + 'STARS.INI','Database','DBMS',             ' ')

//	To prevent confusion, the ServerName will use the DataBase namw parm from the Stars.ini
SQLCA.Database   			=	ProfileString(gv_ini_path + 'STARS.INI','Database','ServerName',       ' ')
SQLCA.ServerName 			=	ProfileString(gv_ini_path + 'STARS.INI','Database','DataBase',         ' ')
SQLCA.Lock       			=	ProfileString(gv_ini_path + 'STARS.INI','Database','Lock',             ' ')

ls_dbparm				=	Trim( ProfileString(gv_ini_path + 'STARS.INI','Database','DbParm',        ' ') )

IF	ls_dbparm			>	' '		THEN
	ls_dbparm			=	ls_dbparm	+	','
END IF

// DisableBind=0 - will cache SQL (More efficient - but can't see values in dberror)
//	DisableBind=1 - Can see values in dberror (Less efficient)

//ls_dbparm				=	ls_dbparm	+	"DelimitIdentifier='No'"								
ls_dbparm				=	ls_dbparm	+	"DelimitIdentifier='No',DisableBind=1"

SQLCA.DbParm     				=	ls_dbparm
SQLCA.LogID						=	as_userid
SQLCA.LogPass					=	as_password
SQLCA.UserId					=	as_userid
SQLCA.DBPass					=	as_password

STARS1CA.DBMS      			=	SQLCA.DBMS
STARS1CA.Database  			=	SQLCA.Database
STARS1CA.ServerName			=	SQLCA.ServerName
STARS1CA.Lock      			=	SQLCA.Lock
STARS1CA.DbParm    			=	SQLCA.DbParm
STARS1CA.LogID     			=	SQLCA.LogID
STARS1CA.LogPass   			=	SQLCA.LogPass
STARS1CA.UserID    			=	SQLCA.UserID
STARS1CA.DBPass    			=	SQLCA.DBPass

STARS2CA.DBMS      			=	SQLCA.DBMS
STARS2CA.Database  			=	SQLCA.Database
STARS2CA.ServerName			=	SQLCA.ServerName
STARS2CA.Lock      			=	SQLCA.Lock
STARS2CA.DbParm    			=	SQLCA.DbParm
STARS2CA.LogID     			=	SQLCA.LogID
STARS2CA.LogPass   			=	SQLCA.LogPass
STARS2CA.UserID    			=	SQLCA.UserID
STARS2CA.DBPass    			=	SQLCA.DBPass

STARSUSERMSG.DBMS      		=	SQLCA.DBMS
STARSUSERMSG.Database  		=	SQLCA.Database
STARSUSERMSG.ServerName		=	SQLCA.ServerName
STARSUSERMSG.Lock      		=	SQLCA.Lock
STARSUSERMSG.DbParm    		=	SQLCA.DbParm
STARSUSERMSG.LogID     		=	SQLCA.LogID
STARSUSERMSG.LogPass   		=	SQLCA.LogPass
STARSUSERMSG.UserID    		=	SQLCA.UserID
STARSUSERMSG.DBPass    		=	SQLCA.DBPass

Return	1
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
//	06/30/03	GaryR	Track 3593d	Rewrite logic to include ordering
//
//*********************************************************************************

// Check if there is a need to alter the sql
IF al_limit < 1 THEN Return 1

// Validate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" OR IsNull( al_limit ) THEN Return -1

as_sql = "SELECT * FROM (" + as_sql + ") WHERE ROWNUM <= " + String( al_limit )

RETURN 1
end function

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
// 12/01/00 GaryR	Stars 4.7	Created
//	01/11/02	GaryR	Track 2670	Dates are in reverse order causing invalid results
//
//*********************************************************************************

// Edit the input
IF	IsNull (as_column1)			&
OR	Trim (as_column1)	=	''		THEN
	Return	''
END IF

IF	IsNull (as_column2)			&
OR	Trim (as_column2)	=	''		THEN
	Return	''
END IF

//	01/11/02	GaryR	Track 2670
//Return	"Trunc(" + as_column1 + ")-Trunc(" + as_column2 + ")"
Return	"Trunc(" + as_column2 + ")-Trunc(" + as_column1 + ")"


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

Return	"Upper(" + as_column + ")"
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

IF IsNull( as_column ) OR Trim( as_column ) = "" THEN Return -1

as_column = "Trunc(" + as_column + ")"

Return	1
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

Return "begin dbms_session.set_identifier('" + is_app_userid + "'); end;"
end function

public function string of_get_to_date_no_time (string as_date, boolean as_field_ind);//*********************************************************************************
// Script Name:	of_get_to_date_no_time
//
//	Arguments:		as_date - Datetime column name
//						as_field_ind - Indicates that this is a field and does not need the To_date because
//								it is already properly formatted.  
// Returns:			String.
//						ASE -	Convert(DateTime, as_date)
//						ORA - Trunc(as_date)
//						UDB - as_date
//
//	Description:	This function removes the time from a datetime field.
//
//
//*********************************************************************************
//	
// 01/18/07	Katie Stars5.3.1 Starfix 4 SPR 4869
// 01/30/07 Katie SPR 4869 Added logic to handle multiple dates seperated by comas.
//
//*********************************************************************************
String	lcs_convert = "TRUNC("
String	lcs_convert_right = ")"
String lcs_precision = ""

if not as_field_ind then
	lcs_convert = "TRUNC(TO_DATE("
	lcs_convert_right = "))"
	lcs_precision = ",'MM/DD/YYYY'"
end if

String		ls_date,			&
				ls_string,		&
				ls_format

Integer		li_pos,			&
				li_pos2,			&
				li_length

// Edit the input
IF	IsNull(as_date)				&
OR	Trim (as_date)	=	''		THEN
	Return	''
END IF

ls_format	=	lcs_precision + lcs_convert_right

// If the SQL was already converted, get out.
li_pos		=	Pos (as_date, lcs_convert)

IF	li_pos	>	0		THEN
	Return	as_date
END IF

n_cst_string		lnv_string		// Autoinstantiated

// Hard-coded dates may or may not have quotes surrounding it.
// Make sure all hard-coded dates include only one single-quote.
ls_date		=	Trim (as_date)

li_pos		=	Pos (ls_date, "'")

IF	li_pos	>	0		THEN
	// Remove the quotes passed to this function
	ls_date	=	lnv_string.of_globalreplace (ls_date, "'", "")
END IF

// If the date is hard-coded, surround it with quotes
li_pos		=	Pos (ls_date, "/")

IF	li_pos	>	0		THEN
	// Hard-coded date.  Surround it with quotes.
	// Also, handle the possibility of multiple dates and with a time.
	// Determine if a time was also passed
	li_pos	=	Pos (ls_date, ' ', li_pos + 1)
	IF	li_pos	>	0		THEN
		IF lcs_precision <> "" then
			ls_format	=	",'MM/DD/YYYY HH24:MI:SS'" + lcs_convert_right
		else 
			ls_format	=	lcs_convert_right
		end if
	END IF
	// Determine if multiple dates were passed.
	li_pos	=	Pos (ls_date, ",")
	IF	li_pos	=	0		THEN
		// Only one date
		ls_date	=	"'"	+	ls_date	+	"'"
		Return	lcs_convert	+	ls_date	+	ls_format
	ELSE
		// Multiple dates exist
		li_pos2	=	1
		DO WHILE	li_pos	>	0
			li_length	=	li_pos	-	li_pos2
			ls_string	=	ls_string	+	","						+	&
								lcs_convert	+	"'"						+	&
								Mid (ls_date, li_pos2, li_length)	+	&
								"'"	+	ls_format
			li_pos2	=	li_pos	+	1
			li_pos	=	Pos (ls_date, ",", li_pos2)
		LOOP
		// Add the last date and remove the leading ","
		ls_string	=	ls_string	+	","		+	&
							lcs_convert	+	"'"		+	&
							Mid (ls_date, li_pos2)	+	&
							"'"	+	ls_format
		ls_string	=	Mid (ls_string, 2)
		Return	ls_string
	END IF
ELSE
	// Date is not hard-coded
	Return	lcs_convert	+	ls_date	+	ls_format
END IF
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

Return	Upper( Trim( atr_trans.ServerName ) )
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
//						specified number for the specified transaction object
//
//*********************************************************************************
//	
// 12/20/06 Katie Stars 5.4.0	Created
//
//*********************************************************************************
long il_pos


// Check if there is a need to alter the sql
IF al_limit < 1 THEN Return 1

// Validate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" OR IsNull( al_limit ) THEN Return -1

il_pos = Pos(as_sql,"WHERE")
if (il_pos > 0) then
	as_sql = as_sql + " AND ROWNUM <= " + String( al_limit )
	RETURN 1
end if

as_sql = as_sql + " WHERE ROWNUM <= " + String( al_limit )
RETURN 1
end function

public function string of_get_norm_case ();//*********************************************************************************
// Script Name:	of_get_norm_case
//
//	Arguments:		None
//
// Returns:			String
//
//	Description:	This function will return the Oracle Decode statement
//						for the Norm Analysis Report by Percent Changed
//
//*********************************************************************************
//	
//	05/17/07	GaryR	Track 5026	Prevent divide-by-zero
//
//*********************************************************************************

Return	"Decode( CARR_PYR_ALW_CHRG, 0, Decode( CARR_ALLOW_CHRG, 0, -100, 500" + &
			"), ((CARR_ALLOW_CHRG - CARR_PYR_ALW_CHRG)/CARR_PYR_ALW_CHRG)*100 )"
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

// Edit the input
IF	IsNull (as_date)			&
OR	Trim (as_date)	=	''		THEN
	Return	''
END IF

IF	IsNull (as_days)			&
OR	Trim (as_days)	=	''		THEN
	Return	''
END IF

Return as_date + " + " + as_days
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
// 07/10/02 MikeF	SD3495	Fix for Left outer join
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

Return as_table1 + " " + as_alias1 + ", " + as_table2  + " " + as_alias2
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
//	Description:	This method appends the row limit in the WHERE clause for Oracle only.
//
// 11/10/09 RickB LKP.650.5678.002 Created this function as an alternative to of_SetRowLimit that
//				creates a subquery to set the row limit.  The SQL parser doesn't handle Oracle 
//				subqueries properly.
//
//*********************************************************************************

// Check if there is a need to alter the sql
IF al_limit < 1 THEN Return 1

// Validate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" OR IsNull( al_limit ) THEN Return -1

as_sql = as_sql + " AND ROWNUM <= " + String( al_limit )

RETURN 1
end function

on n_cst_sql_ora.create
call super::create
end on

on n_cst_sql_ora.destroy
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

event constructor;call super::constructor;// Set the relational operator for a left outer join
// Example: 'column1 = column2(+)'
is_outer_rel_op	=	' = '
is_outer_exp2		=	'(+)'

// Set the substring identifier
is_substring		=	'substr'

// Set the empty string
is_empty = " "
end event

