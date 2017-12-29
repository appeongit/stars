$PBExportHeader$n_cst_sql_ase.sru
$PBExportComments$Inherited from n_cst_sql <logic>
forward
global type n_cst_sql_ase from n_cst_sql
end type
end forward

global type n_cst_sql_ase from n_cst_sql
long il_bad_char = 2402
end type
global n_cst_sql_ase n_cst_sql_ase

type variables

end variables

forward prototypes
public function string of_get_days_diff (string as_column1, string as_column2)
public function long of_get_dup1_insert ()
public function long of_get_dup2_insert ()
public function string of_get_dw_object (string as_dwobject_name)
public function string of_get_to_number (string as_column)
public function string of_get_to_money (string as_column)
public function string of_get_to_char (string as_column)
public function string of_get_database_prefix (string as_prefix)
public function boolean of_is_bad_connection (integer ai_rc)
public function string of_get_current_datetime_name ()
public function string of_get_to_date (string as_date)
public function integer of_table_exists (string as_table)
public function datetime of_get_current_datetime ()
public function integer of_setup_transactions (string as_userid, string as_password)
public function integer of_setrowlimit (ref string as_sql, long al_limit, n_tr ltr_use)
public function string of_left_outer_join_where (string as_column1, string as_column2)
public function string of_left_outer_join_where (string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2)
public function string of_left_outer_join_on (string as_where[])
public function integer of_remove_time (ref string as_column)
public function boolean of_get_allow_view_loj (string as_inv_type)
public function string of_get_count_sql (boolean ab_main_view, boolean ab_dep_view, string as_main_type, string as_dep_type, ref boolean ab_use_ds_count)
public function string of_get_to_date_no_time (string as_date, boolean as_field_ind)
public function string of_full_outer_join (string as_select, string as_where, string as_table1, string as_column1, string as_alias1, string as_table2, string as_column2, string as_alias2)
public function integer of_setrowlimitmultitable (ref string as_sql, long al_limit, n_tr ltr_use)
public function string of_get_norm_case ()
public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2, string as_where3)
public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2)
public function string of_get_days_add (string as_date, string as_days)
public function string of_get_textsize ()
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

// Edit the input
IF	IsNull (as_column1)			&
OR	Trim (as_column1)	=	''		THEN
	Return	''
END IF

IF	IsNull (as_column2)			&
OR	Trim (as_column2)	=	''		THEN
	Return	''
END IF


Return	'DateDiff(DAY,'	+	as_column1	+	','	+	as_column2	+	')'


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

Return	2601

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

Return	3621

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

public function string of_get_to_number (string as_column);//*********************************************************************************
// Script Name:	of_get_to_number
//
//	Arguments:		as_column - Column name to be converted to a number
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

Return	'Convert(Int,'	+	as_column	+	')'

end function

public function string of_get_to_money (string as_column);//*********************************************************************************
// Script Name:	of_get_to_money
//
//	Arguments:		as_column - Column name to be converted to a money
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

// Edit the input
IF	IsNull(as_column)				&
OR	Trim (as_column)	=	''		THEN
	Return	''
END IF

Return	'Convert(Money,'	+	as_column	+	')'

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

// Edit the argument
IF	IsNull( as_column )			&
OR	Trim ( as_column ) = ""		THEN
	Return	""
END IF

// Return the Covert syntax
Return "Convert(" + as_column + ")"
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

Return	as_prefix	+	'..'

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

IF	ai_rc	=	4002		THEN
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

Return	'GetDate()'

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
//	Description:	This function converts a string to a datetime in SQL.  This function
//						must account for multiple date values.
//						
//
//*********************************************************************************
//	
// 12/01/00 FDG	Stars 4.7	Created
//
//*********************************************************************************

Constant	String	lcs_convert	=	"Convert(DateTime,"

String	ls_date,			&
			ls_string

Integer	li_pos,			&
			li_pos2,			&
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

// If the date is hard-coded, surround it with quotes
li_pos		=	Pos (ls_date, "/")

IF	li_pos	>	0		THEN
	// Hard-coded date.  Surround it with quotes.
	// Also, handle the possibility of multiple dates.
	li_pos	=	Pos (ls_date, ",")
	IF	li_pos	=	0		THEN
		// Only one date
		ls_date	=	"'"	+	ls_date	+	"'"
		Return	lcs_convert	+	ls_date	+	")"
	ELSE
		// Multiple dates exist
		li_pos2	=	1
		DO WHILE	li_pos	>	0
			li_length	=	li_pos	-	li_pos2
			ls_string	=	ls_string	+	","						+	&
								lcs_convert	+	"'"						+	&
								Mid (ls_date, li_pos2, li_length)	+	&
								"')"
			li_pos2	=	li_pos	+	1
			li_pos	=	Pos (ls_date, ",", li_pos2)
		LOOP
		// Add the last date and remove the leading ","
		ls_string	=	ls_string	+	","		+	&
							lcs_convert	+	"'"		+	&
							Mid (ls_date, li_pos2)	+	"')"
		ls_string	=	Mid (ls_string, 2)
		Return	ls_string
	END IF
ELSE
	// Date not hard-coded
	Return	lcs_convert	+	ls_date	+	")"
END IF


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

Long		ll_count
as_table = Upper( as_table )	

// See if the table name exists in the sysobjects table
SELECT 	 count(*)
INTO		:ll_count
FROM		 sysobjects
WHERE		 name	=	:as_table
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
 
Select Distinct getdate() 
Into	:ldtm_date 
From	stars_win_parm 
Using Stars2ca;

li_rc = Stars2ca.of_check_status()

IF li_rc	<>	0		THEN
	ldtm_server_date_time	=	DateTime (Today(), Now())
ELSE
	ldtm_server_date_time	=	ldtm_date
END IF

Return	ldtm_server_date_time

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
//	12/17/04	GaryR	Track 4142d	Identify individual user sessions in the database
//
//*********************************************************************************

String	ls_dbparm

SQLCA.DBMS       			=	ProfileString(gv_ini_path + 'STARS.INI','Database','DBMS',             ' ') 
SQLCA.Database   			=	ProfileString(gv_ini_path + 'STARS.INI','Database','DataBase',         ' ') 
SQLCA.ServerName 			=	ProfileString(gv_ini_path + 'STARS.INI','Database','ServerName',       ' ') 
SQLCA.Lock       			=	ProfileString(gv_ini_path + 'STARS.INI','Database','Lock',             ' ') 

ls_dbparm				=	Trim( ProfileString(gv_ini_path + 'STARS.INI','Database','DbParm',        ' ') )

IF	ls_dbparm			>	' '		THEN
	ls_dbparm			=	ls_dbparm	+	','
END IF

//	Set the unique session
ls_dbparm				=	ls_dbparm	+	"Host='" + is_app_userid + "',AppName='Stars'"
SQLCA.DbParm     				=	ls_dbparm
SQLCA.LogID					=	as_userid
SQLCA.LogPass				=	as_password
SQLCA.UserId				=	as_userid
SQLCA.DBPass				=	as_password

STARS1CA.DBMS      		=	SQLCA.DBMS
STARS1CA.Database  		=	SQLCA.Database
STARS1CA.ServerName		=	SQLCA.ServerName
STARS1CA.Lock      		=	SQLCA.Lock
STARS1CA.DbParm    		=	SQLCA.DbParm
STARS1CA.LogID     		=	SQLCA.LogID
STARS1CA.LogPass   		=	SQLCA.LogPass
STARS1CA.UserID    		=	SQLCA.UserID
STARS1CA.DBPass    		=	SQLCA.DBPass

STARS2CA.DBMS       		=	ProfileString(gv_ini_path + 'STARS.INI','stars2','DBMS',             ' ') 
STARS2CA.Database   		=	ProfileString(gv_ini_path + 'STARS.INI','stars2','DataBase',         ' ') 
STARS2CA.ServerName 		=	ProfileString(gv_ini_path + 'STARS.INI','stars2','ServerName',       ' ') 
STARS2CA.Lock       		=	ProfileString(gv_ini_path + 'STARS.INI','stars2','Lock',             ' ') 

ls_dbparm				=	Trim( ProfileString(gv_ini_path + 'STARS.INI','stars2','DbParm',        ' ') )

IF	ls_dbparm			>	' '		THEN
	ls_dbparm			=	ls_dbparm	+	','
END IF

//	Set the unique session
ls_dbparm				=	ls_dbparm	+	"Host='" + is_app_userid + "',AppName='Stars'"
STARS2CA.DbParm     		=	ls_dbparm
STARS2CA.LogID				=	as_userid
STARS2CA.LogPass			=	as_password
STARS2CA.UserId			=	as_userid
STARS2CA.DBPass			=	as_password

STARSUSERMSG.DBMS 	   =	STARS2CA.DBMS
STARSUSERMSG.Database	=	STARS2CA.Database
STARSUSERMSG.ServerName	=	STARS2CA.ServerName
STARSUSERMSG.Lock      	=	STARS2CA.Lock
STARSUSERMSG.DbParm    	=	STARS2CA.DbParm
STARSUSERMSG.LogID     	=	STARS2CA.LogID
STARSUSERMSG.LogPass   	=	STARS2CA.LogPass
STARSUSERMSG.UserID    	=	STARS2CA.UserID
STARSUSERMSG.DBPass    	=	STARS2CA.DBPass

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

String	ls_limitsql

// Validate the argument
IF IsNull( al_limit ) OR IsNull( ltr_use ) OR NOT IsValid( ltr_use ) THEN Return -1

// Set the row limit
ls_limitsql = "set rowcount " + String( al_limit )
IF ltr_use.of_execute( ls_limitsql ) <> 0 THEN Return -1

Return 1
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
// 12/01/00 FDG	Stars 4.7	Created
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
Return	as_column1	+	'*='	+	as_column2

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
		ls_where	=	as_column1	+	' *= '	+	as_column2
	ELSE
		ls_where	=	as_table1	+	'.'	+	as_column1	+	' *= '	+	&
						as_table2	+	'.'	+	as_column2
	END IF
ELSE
	ls_where	=	as_alias1	+	'.'	+	as_column1	+	' *= '	+	&
					as_alias2	+	'.'	+	as_column2
END IF

Return	ls_where



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
// 8/20/02 MikeFl Track 3267d. Remove 'WHERE' from 1st line.
// 08/30/02 MikeFl	Track 3288d. Remove 'AND' from first WHERE line.
//
//*********************************************************************************
string  	ls_on[],ls_where[], ls_sql
int		li_upper, li_loop, li_pos, li_on, li_where, li_len

// MikeFl 8/20/02 - Track 3267 Begin - Remove 'WHERE' from the 1st line if it exists
IF left(trim(as_where[1]),6) = 'WHERE ' THEN
	as_where[1] = mid(trim(as_where[1]), 7)
END IF
// MikeFl 8/20/02 - Track 3267 End

// Seperate the ON clauses from the WHERE
li_upper = UpperBound(as_where)

FOR li_loop = 1 TO li_upper
	li_pos = pos(as_where[li_loop],"*=")
	
	IF li_pos > 0 THEN
		li_on++
		li_len = len(as_where[li_loop])
		ls_on[li_on] = left(as_where[li_loop],li_pos - 1) + mid(as_where[li_loop],li_pos + 1,li_len)
		
		IF li_on = 1 THEN
			IF left(ls_on[li_on],5) = ' AND ' THEN
				li_len = len(ls_on[li_on])
				ls_on[li_on] = ' ON ' 	+ mid(ls_on[li_on],6,li_len)
			ELSE
				ls_on[li_on] = ' ON ' 	+ ls_on[li_on]
			END IF
		END IF
		
	ELSE
		li_where++
		ls_where[li_where] = as_where[li_loop]
	END IF
	
NEXT

// Process ON portion
li_upper = UpperBound(ls_on)

FOR li_loop = 1 to li_upper
	ls_sql = ls_sql + ls_on[li_loop]
NEXT

// Process WHERE portion
li_upper = UpperBound(ls_where)

ls_sql = ls_sql + " "

FOR li_loop = 1 to li_upper
	
	// MikeFl 8/21/02 Track 3267 - Begin
	IF li_loop = 1 THEN
		
		// MikeFl 8/30/02 Track 3288 - Begin
		IF left(ls_where[li_loop],5) = ' AND ' &
		OR left(ls_where[li_loop],4) = 'AND ' THEN
			ls_where[li_loop] = mid(ls_where[li_loop],5)
		END IF
		// MikeFl 8/30/02 Track 3288 - End	
		
		ls_sql = ls_sql + "WHERE"
	END IF
	// MikeFl 8/21/02 Track 3267 - END
	
	ls_sql = ls_sql + " " + ls_where[li_loop]
NEXT

RETURN ls_sql
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

as_column = "Convert(Char(10)," + as_column + ",101)"

Return	1
end function

public function boolean of_get_allow_view_loj (string as_inv_type);//-----------------------------------------------------------------------------------//
// Object		n_cst_sql_syb
// Function		of_get_allow_view_loj
// Parms			as_inv_type 		string	Main table's Invoice Type
// Returns  							boolean  Whether or not to allow query to execute
//-------------------------------------------------------------------------------------//
// Don't allow query to execute under the following conditions due to Sybase issue:
//
// Handled here:
// * DBMS is Sybase
// * Main Table is a UNION ALL view
// * There isn't a VIEWLOJ row in SYS_CNTL whith CNTL_CASE='Y' 
//	  - Added in case Sybase fixes issue with EBF or release
// Or these (handled in u_nvo_create_sql)
// * Query is an Outer join 
// * Query is select or select count(*)
// * Query is against base data (NOT Subset)
//-------------------------------------------------------------------------------------//
// 03/04/04 MikeF	3921d	Sybase issue not allowing LOJ w/ UNION ALL views
//-------------------------------------------------------------------------------------//
int				li_unions
String			ls_sql, ls_cntl_id
u_nvo_sys_cntl lu_nvo_sys_cntl

// Get max number 
SELECT MAX(UNION_LEVEL)
INTO :li_unions
FROM VIEW_SOURCES
WHERE INV_TYPE=:as_inv_type
USING stars2ca;

// If there is only one UNION_LEVEL, the view is not a UNION_ALL. Allow LOJ.
IF li_unions = 1 THEN
	RETURN TRUE
END IF
	
lu_nvo_sys_cntl = CREATE u_nvo_sys_cntl
lu_nvo_sys_cntl.of_set_cntl_id( "VIEWLOJ")

IF lu_nvo_sys_cntl.il_sys_cntl_row > 0 THEN
	ls_cntl_id = lu_nvo_sys_cntl.of_get_cntl_case()
END IF

DESTROY lu_nvo_sys_cntl

IF trim(ls_cntl_id) = "Y" THEN
	RETURN TRUE
END IF

RETURN FALSE
end function

public function string of_get_count_sql (boolean ab_main_view, boolean ab_dep_view, string as_main_type, string as_dep_type, ref boolean ab_use_ds_count);//-----------------------------------------------------------------------------------//
// Object		n_cst_sql_syb
// Function		of_get_count_sql 
// Parms			ab_main_view 		boolean	If main table is a view 
//					ab_dep_view 		boolean	If dependent table is a view
//					as_main_type		string	Main table's Invoice Type
//					as_dep_type			string	Dependent table's Invoice Type
//					ab_use_ds_count	boolean	Sets flag to use ds return code as count
// Returns  	string
//-----------------------------------------------------------------------------------// 
// If either Main or dependent table is a view AND UNION_LEVEL > 1
//	* return "SELECT 1 " to have query return a value (causes query to use indexes)
//	* set boolean in u_nvo_count to use datastore return code as count
// Else
// * return standard "SELECT COUNT(*) "
// * set boolean in u_nvo_count to use value in datastore as count
//-----------------------------------------------------------------------------------// 
// 03/04/04 MikeF SPR 3909d/3921d Added to resolve Sybase performance issue w/ View counts
// 03/22/04 MikeF SPR 3951d Changed logic (IF either UNION ALL VIEW, SELECT 1)
//-----------------------------------------------------------------------------------// 
int				li_unions

IF (ab_main_view 	OR ab_dep_view) THEN

	// Get max number 
	SELECT MAX(UNION_LEVEL)
	INTO :li_unions
	FROM VIEW_SOURCES
	WHERE INV_TYPE IN (:as_main_type,:as_dep_type)
	USING stars2ca;
	
	// If there is only one UNION_LEVEL, the view is not a UNION_ALL. 
	IF li_unions > 1 THEN
		ab_use_ds_count = TRUE
		RETURN "SELECT 1 "
	END IF
	
END IF

ab_use_ds_count = FALSE
RETURN "SELECT COUNT(*) "
end function

public function string of_get_to_date_no_time (string as_date, boolean as_field_ind);//*********************************************************************************
// Script Name:	of_get_to_date_no_time
//
//	Arguments:		as_date - Datetime column name
//						as_field_ind - Indicates that this is a field and does not need the To_date because
//								it is already properly formatted.  
// Returns:			String.
//						ASE -	Convert(Date, as_date)
//						ORA - To_Date(as_date)
//						UDB - TimeStamp(as_date)
//
//	Description:	This function converts a string to a date with no time stamp in SQL.  This function
//						must account for multiple date values.
//						
//
//*********************************************************************************
//	
// 01/16/07 SPR 4869 5.3.1 Starfix 4
//
//*********************************************************************************

Constant	String	lcs_convert	=	"Convert(Date,"

String	ls_date,			&
			ls_string

Integer	li_pos,			&
			li_pos2,			&
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

// If the date is hard-coded, surround it with quotes
li_pos		=	Pos (ls_date, "/")

IF	li_pos	>	0		THEN
	// Hard-coded date.  Surround it with quotes.
	// Also, handle the possibility of multiple dates.
	li_pos	=	Pos (ls_date, ",")
	IF	li_pos	=	0		THEN
		// Only one date
		ls_date	=	"'"	+	ls_date	+	"'"
		Return	lcs_convert	+	ls_date	+	")"
	ELSE
		// Multiple dates exist
		li_pos2	=	1
		DO WHILE	li_pos	>	0
			li_length	=	li_pos	-	li_pos2
			ls_string	=	ls_string	+	","						+	&
								lcs_convert	+	"'"						+	&
								Mid (ls_date, li_pos2, li_length)	+	&
								"')"
			li_pos2	=	li_pos	+	1
			li_pos	=	Pos (ls_date, ",", li_pos2)
		LOOP
		// Add the last date and remove the leading ","
		ls_string	=	ls_string	+	","		+	&
							lcs_convert	+	"'"		+	&
							Mid (ls_date, li_pos2)	+	"')"
		ls_string	=	Mid (ls_string, 2)
		Return	ls_string
	END IF
ELSE
	// Date not hard-coded
	Return	lcs_convert	+	ls_date	+	")"
END IF


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
//						UDB - ''
//
//	Description:	This function will create the a complete SQL statement with a full outer join.
//
//*********************************************************************************
//	
// 12/06/06 Katie SPR 4758 Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

String lv_sql_statement, lv_right_outer_sql, lv_left_outer_sql

lv_right_outer_sql = 'SELECT ' + as_select + ' FROM ' + &
as_table1 + " " + as_alias1 + " RIGHT OUTER JOIN " + as_table2 + " " + as_alias2 + &
' on ' + as_alias1 + '.' + as_column1 + '=' + as_alias2 + '.' + as_column2

lv_left_outer_sql = 'SELECT ' + as_select + ' FROM ' + &
of_left_outer_join_from(as_table1, as_alias1 , as_table2, as_alias2)+ &
' on ' + as_alias1 + '.' + as_column1 + '=' + as_alias2 + '.' + as_column2

if (trim(as_where) <> "") then 
	lv_right_outer_sql = lv_right_outer_sql + ' WHERE ' + as_where
	lv_left_outer_sql = lv_left_outer_sql + ' WHERE ' + as_where
end if

lv_sql_statement = lv_right_outer_sql + ' UNION ' + lv_left_outer_sql

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

return of_SetRowLimit(as_sql, al_limit, ltr_use)
end function

public function string of_get_norm_case ();//*********************************************************************************
// Script Name:	of_get_norm_case
//
//	Arguments:		None
//
// Returns:			String
//
//	Description:	This function will return the Sybase Case statement 
//						for the Norm Analysis Report by Percent Changed
//
//*********************************************************************************
//	
//	05/17/07	GaryR	Track 5026	Prevent divide-by-zero
//
//*********************************************************************************

Return "(Case When CARR_PYR_ALW_CHRG = 0 THEN (Case When CARR_ALLOW_CHRG = " + &
			"0 THEN -100 ELSE 500 END) ELSE ((CARR_ALLOW_CHRG - " + &
			"CARR_PYR_ALW_CHRG)/CARR_PYR_ALW_CHRG)*100 END)"
end function

public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2, string as_where3);//*********************************************************************************
// Script Name:	of_full_outer_join
//
//	Arguments:		as_select select statement 
//						as_where1 first table criteria statement
//						as_table1 first table in join
//						as_column1 first table join column name
//						as_alias1 first table alias
//						as_where2 second table criteria statement
//						as_table2 second table in join
//						as_column2 second table join column name
//						as_alias2 second table alias
//						as_where3 critieria statement for both tables
//
// Returns:			String
//						ASE - sql statement with union of a left outer join to a right outer join
//						ORA - sql statement with full outer join
//						UDB - ''
//
//	Description:	This function will create the a complete SQL statement with a full outer join.
//
//*********************************************************************************
//	
// 08/14/07 Katie SPR 5135 Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

String lv_sql_statement, lv_right_outer_sql, lv_left_outer_sql

lv_right_outer_sql = 'SELECT ' + as_select + ' FROM ' + &
as_table1 + " " + as_alias1 + " RIGHT OUTER JOIN " + as_table2 + " " + as_alias2 + &
' on ' + as_alias1 + '.' + as_column1 + '=' + as_alias2 + '.' + as_column2

lv_left_outer_sql = 'SELECT ' + as_select + ' FROM ' + &
of_left_outer_join_from(as_table1, as_alias1 , as_table2, as_alias2)+ &
' on ' + as_alias1 + '.' + as_column1 + '=' + as_alias2 + '.' + as_column2

if (trim(as_where2) <> "") then 
	lv_right_outer_sql = lv_right_outer_sql + ' WHERE ' + as_where2
	if (trim(as_where3) <> "") then
		lv_right_outer_sql = lv_right_outer_sql + ' AND ' + as_where3
	end if
end if
if (trim(as_where1) <> "") then 
	lv_left_outer_sql = lv_left_outer_sql + ' WHERE ' + as_where1
	if (trim(as_where3) <> "") then
		lv_left_outer_sql = lv_left_outer_sql + ' AND ' + as_where3
	end if
end if

lv_sql_statement = lv_right_outer_sql + ' UNION ' + lv_left_outer_sql

Return	lv_sql_statement
end function

public function string of_full_outer_join (string as_select, string as_where1, string as_table1, string as_column1, string as_alias1, string as_where2, string as_table2, string as_column2, string as_alias2);//*********************************************************************************
// Script Name:	of_full_outer_join
//
//	Arguments:		as_select select statement 
//						as_where1 first table criteria statement
//						as_table1 first table in join
//						as_column1 first table join column name
//						as_alias1 first table alias
//						as_where2 second table criteria statement
//						as_table2 second table in join
//						as_column2 second table join column name
//						as_alias2 second table alias
//
// Returns:			String
//						ASE - sql statement with union of a left outer join to a right outer join
//						ORA - sql statement with full outer join
//						UDB - ''
//
//	Description:	This function will create the a complete SQL statement with a full outer join.
//
//*********************************************************************************
//	
// 08/14/07 Katie SPR 5135 Created
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//
//*********************************************************************************

String lv_sql_statement, lv_right_outer_sql, lv_left_outer_sql

lv_right_outer_sql = 'SELECT ' + as_select + ' FROM ' + &
as_table1 + " " + as_alias1 + " RIGHT OUTER JOIN " + as_table2 + " " + as_alias2 + &
' on ' + as_alias1 + '.' + as_column1 + '=' + as_alias2 + '.' + as_column2

lv_left_outer_sql = 'SELECT ' + as_select + ' FROM ' + &
of_left_outer_join_from(as_table1, as_alias1 , as_table2, as_alias2)+ &
' on ' + as_alias1 + '.' + as_column1 + '=' + as_alias2 + '.' + as_column2

if (trim(as_where2) <> "") then 
	lv_right_outer_sql = lv_right_outer_sql + ' WHERE ' + as_where2
end if
if (trim(as_where1) <> "") then 
	lv_left_outer_sql = lv_left_outer_sql + ' WHERE ' + as_where1
end if

lv_sql_statement = lv_right_outer_sql + ' UNION ' + lv_left_outer_sql

Return	lv_sql_statement
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

Return	'DateAdd(DAY,' + as_days + ',' + as_date + ')'
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

Return "Set textsize 2000000"
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
//	Description:	This method was created for an *ORACLE-ONLY* alternative to of_SetRowLimit. 
//					which, for Oracle, creates a subquery to set the max row limit.  
//					The code that parses the FROM clause doesn't handle subqueries correctly (two "FROM"s).  
//					Sybase does not use a subquery to set the row limit so passing to of_SetRowLimit.
//
// 11/10/09 RickB LKP.650.5678.002 Method created for Oracle (see Description above).  
//						of_SetRowLimit still works fine for Sybase.
//
//*********************************************************************************

return of_setrowlimit( as_sql, al_limit, ltr_use)
end function

on n_cst_sql_ase.create
call super::create
end on

on n_cst_sql_ase.destroy
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
is_outer_rel_op	=	' *= '
is_outer_exp2		=	''

// Set the empty string
is_empty = ""
end event

