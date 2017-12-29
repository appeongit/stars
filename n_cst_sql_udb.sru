HA$PBExportHeader$n_cst_sql_udb.sru
$PBExportComments$Inherited from n_cst_sql <logic>
forward
global type n_cst_sql_udb from n_cst_sql
end type
end forward

global type n_cst_sql_udb from n_cst_sql
string is_substring = "substr"
end type
global n_cst_sql_udb n_cst_sql_udb

type variables

end variables

forward prototypes
public function string of_get_dw_object (string as_dwobject_name)
public function integer of_table_exists (string as_table)
public function string of_get_to_number (string as_column)
public function string of_get_to_money (string as_column)
public function string of_get_to_char (string as_column)
public function string of_left_outer_join_where (string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2)
public function string of_left_outer_join_where (string as_column1, string as_column2)
public function boolean of_is_bad_connection (integer ai_rc)
public function long of_get_dup1_insert ()
public function long of_get_dup2_insert ()
public function string of_get_database_prefix (string as_prefix)
public function datetime of_get_current_datetime ()
public function string of_get_current_datetime_name ()
public function string of_get_to_date (string as_date)
public function integer of_setup_transactions (string as_userid, string as_password)
public function integer of_setrowlimit (ref string as_sql, long al_limit, n_tr ltr_use)
public function string of_get_days_diff (string as_column1, string as_column2)
end prototypes

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

Return	as_dwobject_name + "_udb"

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

Return -1
end function

public function string of_get_to_number (string as_column);//*********************************************************************************
// Script Name:	of_get_to_number
//
//	Arguments:		as_column - Column name to be converted to number
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

Return	"Dec(" + as_column + ")"

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
RETURN	"CHAR(" + ls_column + ls_format + ")"
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

Return	''

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

// Return the new where clause
Return	''
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
	CASE	4, 1060, 1093
		Return	TRUE
	CASE	ELSE
		Return	FALSE
END CHOOSE

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

Return	803

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

Return	803

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
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

DateTime		ldtm_date,						&
				ldtm_server_date_time

Integer		li_rc
 
Select CURRENT TIMESTAMP
Into	:ldtm_date 
From	sys_cntl
Using Stars2ca;

li_rc = Stars2ca.of_check_status()

IF li_rc	<>	0		THEN
	ldtm_server_date_time	=	DateTime (Today(), Now())
ELSE
	ldtm_server_date_time	=	ldtm_date
END IF

Return	ldtm_server_date_time

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

Return	'CURRENT TIMESTAMP'

end function

public function string of_get_to_date (string as_date);//*********************************************************************************
// Script Name:	of_get_to_date
//
//	Arguments:		as_date - Datetime column name
//
// Returns:			String.
//						ASE -	Convert(DateTime, as_date)
//						ORA - To_Date(as_date)
//						UDB - TimeStamp(as_date)
//
//	Description:	This function converts a string to a datetime in SQL.
//						
//
//*********************************************************************************
//	
// 12/01/00 GaryR	Stars 4.7	Created
//
//*********************************************************************************

Constant	String	lcs_convert	=	"TimeStamp("

String		ls_date,				&
				ls_time,				&
				ls_string,			&
				ls_temp_date

Integer		li_pos,				&
				li_pos2,				&
				li_pos3,				&
				li_length

// Edit the input
IF	IsNull(as_date)				&
OR	Trim (as_date)	=	''		THEN
	Return	''
END IF

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

// If a time was passed, convert ':' to '.' 
ls_date	=	lnv_string.of_globalreplace (ls_date, ':', '.')

// If the date is hard-coded, surround it with quotes
li_pos		=	Pos (ls_date, "/")

IF	li_pos	>	0		THEN
	// Hard-coded date.  Surround it with quotes.
	// Also, handle the possibility of multiple dates and times.
	li_pos	=	Pos (ls_date, ",")
	IF	li_pos	=	0		THEN
		// Only one date
		// Determine if a time was also passed
		li_pos	=	Pos (ls_date, ' ')
		IF	li_pos	>	0		THEN
			// Time was also passed
			ls_time	=	Trim (Mid (ls_date, li_pos + 1) )
			ls_date	=	Trim (Left (ls_date, li_pos) )
		ELSE
			// Time was not passed
			ls_time	=	"00.00.00"
		END IF
		Return	lcs_convert	+	"'"	+	ls_date	+	"', '"	+	ls_time	+	"')"
	ELSE
		// Multiple dates exist
		li_pos2	=	1
		DO WHILE	li_pos	>	0
			li_length		=	li_pos	-	li_pos2
			ls_temp_date	=	Mid (ls_date, li_pos2, li_length)
			// Determine if a time was also passed
			li_pos3			=	Pos (ls_temp_date, ' ')
			IF	li_pos3		>	0			THEN
				// Time was also passed
				ls_time			=	Trim (Mid (ls_temp_date, li_pos3 + 1) )
				ls_temp_date	=	Trim (Left (ls_temp_date, li_pos3) )
			ELSE
				// Time was not passed
				ls_time	=	"00.00.00"
			END IF
			ls_string		=	ls_string	+	","						+	&
									lcs_convert	+	"'"						+	&
									ls_temp_date	+	"', '"				+	&
									ls_time	+	"')"
			li_pos2			=	li_pos	+	1
			li_pos			=	Pos (ls_date, ",", li_pos2)
		LOOP
		// Add the last date and remove the leading ","
		// Determine if a time was also passed in the last date
		ls_temp_date	=	Mid (ls_date, li_pos2)
		li_pos3			=	Pos (ls_temp_date, ' ')
		IF	li_pos3		>	0			THEN
			// Time was also passed
			ls_time			=	Trim (Mid (ls_temp_date, li_pos3 + 1) )
			ls_temp_date	=	Trim (Left (ls_temp_date, li_pos3) )
		ELSE
			// Time was not passed
			ls_time	=	"00.00.00"
		END IF
		ls_string		=	ls_string	+	","						+	&
								lcs_convert	+	"'"						+	&
								ls_temp_date	+	"', '"				+	&
								ls_time	+	"')"
		ls_string			=	Mid (ls_string, 2)
		Return	ls_string
	END IF
ELSE
	// Date not hard-coded
	ls_string	=	lcs_convert	+	ls_date	+	", '00.00.00')"
	Return	ls_string
END IF


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
//	09/20/01	GaryR	Stars 4.7	Centralize all connection parms
//
//*********************************************************************************

String		ls_dbparm,			&
				ls_database
				
// Setup the DBParm
ls_database				=	ProfileString(gv_ini_path + 'STARS.INI','Database','DataBase', ' ')
ls_dbparm				=	"ConnectString='DSN="	+	ls_database		+	&
								";UID="	+	as_userid	+	";PWD="			+	&
								as_password	+	"'"

SQLCA.DBParm			=	ls_dbparm
STARS1CA.DBParm		=	SQLCA.DBParm
STARS2CA.DBParm		=	SQLCA.DBParm
STARSUSERMSG.DBParm	=	SQLCA.DBParm

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
//
//*********************************************************************************

// Check if there is a need to alter the sql
IF al_limit < 1 THEN Return 1

// Validate the argument
IF IsNull( as_sql ) OR Trim( as_sql ) = "" OR IsNull( al_limit ) THEN Return -1

// Append the fetch condition
as_sql += " FETCH FIRST " + String( al_limit ) + " ROWS"

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


Return	"Days(" + as_column2 + ")-Days(" + as_column1 + ")"


end function

on n_cst_sql_udb.create
call super::create
end on

on n_cst_sql_udb.destroy
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
is_outer_rel_op	=	''
is_outer_exp2		=	''

// Set the substring identifier
is_substring		=	'substr'

// Set the empty string
is_empty = " "

end event

