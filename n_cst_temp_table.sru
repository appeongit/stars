HA$PBExportHeader$n_cst_temp_table.sru
$PBExportComments$NVO to either create or drop a temporary table (inherited from n_base) <logic>
forward
global type n_cst_temp_table from n_base
end type
end forward

global type n_cst_temp_table from n_base
end type
global n_cst_temp_table n_cst_temp_table

type variables
// Instance variables defined in NVO n_cst_temp_table_attrib

Protected	  n_cst_temp_table_attrib	inv_temp_attrib

Protected  String 	is_command = 'exec stars_open_server...build_sql'

Boolean		ib_got_server_info

String		is_os_login,	&
		is_os_password,	&
		is_os_server_name,	&
		is_ss_login,	&
		is_ss_password,	&
		is_ss_server_name

// Database name
Protected String	is_database

// Holds the server job id		//GaryR	08/08/01
Protected Long il_server_job_id

// Datastore to parse sql into bg_sql_line table

n_ds		ids_sql_line





end variables

forward prototypes
public subroutine of_set_attrib (ref n_cst_temp_table_attrib anv_temp_table)
public function string of_get_database ()
public function string of_get_table_name ()
public subroutine of_set_database (string as_database)
public function n_cst_temp_table_attrib of_get_temp_table ()
public function integer of_drop_table ()
public function integer of_execute_sql (n_cst_temp_table_attrib anv_temp_table)
public function long of_get_server_job_id ()
public function string of_compute_new_table_name ()
public function integer of_drop_table (string as_table_name)
end prototypes

public subroutine of_set_attrib (ref n_cst_temp_table_attrib anv_temp_table);//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_set_attrib
//
// Purpose:					Set the pointer to the instance variable of type n_cst_temp_table_attrib
//								to the address of the variable passed as an argument.
//
// Input:					n_cst_temp_table_attrib	-	anv_temp_table
//
// Returns:					None.
//
//***************************************************************************************
// Maintenance Log:		01/15/98		JGG	Created function from TS145, Subset Redesign.
//
//***************************************************************************************

// Save the address of the structure for future use

inv_temp_attrib	=	anv_temp_table

RETURN

end subroutine

public function string of_get_database ();//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_get_database
//
// Purpose:					Return the name of the database to the calling script.  If the 
//								database name has not been previously set, return
//								Stars2ca.Database.
//
// Input:					None
//
// Returns:					String -	Either the database name previously saved in function
//								of_set_database() or Stars2ca.Database
//
//***************************************************************************************
// Maintenance Log:		02/05/98		FDG	Created.
//
//***************************************************************************************

IF	Trim (is_database)	<	" "		THEN
	//	No database name previously set.  Default to
	//	Stars2ca.Database.
	RETURN	Stars2ca.Database
ELSE
	RETURN	is_database
END IF

end function

public function string of_get_table_name ();//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_get_table_name
//
// Purpose:					This function returns the name of the temporary table that was
//								just created.
//
// Input:					None
//
// Returns:					string			- The name of the temporary table created.
//
//***************************************************************************************
// Maintenance Log:		01/15/98		JGG	Created function from TS145, Subset Redesign.
//
//***************************************************************************************

// Return the instance variable string containing the table name.

RETURN		inv_temp_attrib.is_table_name

end function

public subroutine of_set_database (string as_database);//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_set_database
//
// Purpose:					Set the name of the database to the name passed to 
//								this function.
//
// Input:					as_database	-	The name of the database.  Usually passed from
//													Stars1ca.Database or Stars2ca.Database
//
// Returns:					None
//
//***************************************************************************************
// Maintenance Log:		02/05/98		FDG	Created.
//
//***************************************************************************************

is_database	=	as_database


end subroutine

public function n_cst_temp_table_attrib of_get_temp_table ();//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_get_temp_table
//
// Purpose:					This function returns the temporary table instance variable structure.
//
// Input:					None
//
// Returns:					n_cst_temp_table_attrib		- The temporary table structure.
//
//***************************************************************************************
// Maintenance Log:		01/15/98		JGG	Created function from TS145, Subset Redesign.
//
//***************************************************************************************

// Return the instance variable structure.

RETURN		inv_temp_attrib

end function

public function integer of_drop_table ();//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_drop_table
//
// Purpose:					Drop the table named in inv_temp_attrib.
//
// Notes:					This is an overloaded function.
//
// Returns:					integer	(1 = Successful; -1 = Unsuccessful)
//
//***************************************************************************************
// Maintenance Log:		01/15/98		JGG	Created function from TS145, Subset Redesign.
//
//***************************************************************************************

// Call the NVO function to execute the command

RETURN	This.of_drop_table(inv_temp_attrib.is_table_name)

end function

public function integer of_execute_sql (n_cst_temp_table_attrib anv_temp_table);//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_execute_sql
//
// Purpose:					Format and execute the DDL needed to CREATE or DROP a temporary
//								table using the structure passed as an argument.
//
// Input:					n_cst_temp_table_attrib	-	anv_temp_table
//
// Returns:					integer	(1 = Successful; -1 = Unsuccessful, 0 = No DDL to generate)
//
//***************************************************************************************
// Maintenance Log:		
//
//	01/15/98	JGG	Created function from TS145, Subset Redesign.
//	03/21/01	FDG	Stars 4.7.  Call Stars Server to create the temp table.  All of the
//										SQL to create the temp table will generated on Stars
//										Server.
// 08/07/01	GaryR	Track 2396d	Handle return code
// 08/08/01	GaryR	Track 2396d	Functional flaw creating subsets
//
//***************************************************************************************

// Local Variables

Integer						li_rc

Long							ll_rc,				&
								ll_job_id

String						ls_table_name

// Save the structure for future use

inv_temp_attrib	=	anv_temp_table

// If processing a DROP statement, execute it and return its status

If Upper(inv_temp_attrib.is_function) = 'DROP' Then
	RETURN	This.of_drop_table(inv_temp_attrib.is_table_name)
End if

// If the table name has been created, try to drop it
ls_table_name	=	This.of_get_table_name()

If Trim(ls_table_name) > " "	Then
	// If the table already exists, drop it and ignore the return code
	li_rc				=	This.of_drop_table(ls_table_name)
End if

// FDG 03/21/01 - All SQL will be gernated on Stars Server
// Now build the SQL to create, index and grant permissions

//ls_create_sql	=	This.of_get_create_sql(ls_table_name)
//If IsNull(ls_create_sql) 	&
//Or Trim(ls_create_sql) < " "	Then
//	RETURN -1
//End if
//
//ls_index_sql	=	This.of_get_index_sql(ls_table_name)
//If IsNull(ls_index_sql)		&
//Or Trim(ls_index_sql) < " "	Then
//	RETURN -1
//End if
//
//ls_grant_sql	=	This.of_get_grant_sql(ls_table_name)
//If IsNull(ls_grant_sql)		&
//Or Trim(ls_grant_sql) < " "	Then
//	RETURN -1
//End if

//// Execute the SQL and return its status

//RETURN	This.of_execute_sql(ls_create_sql,	&
//									  ls_index_sql,	&
//									  ls_grant_sql)

CHOOSE CASE	inv_temp_attrib.ii_request
	CASE	inv_temp_attrib.ici_icn_table
		// Create the ICN table
		ll_rc		=	gnv_server.of_JobCreate ( ll_job_id )
		IF	ll_rc	<	0		THEN	Return ll_rc
		ll_rc		=	gnv_server.of_CreateICNTable ( ll_job_id,		&
																inv_temp_attrib.is_inv_type,		&
																inv_temp_attrib.is_table_name )
		IF	ll_rc	<	0		THEN	Return ll_rc
		// 08/08/01	GaryR	Track 2396d - Begin
		//ll_rc		=	gnv_server.of_JobDelete ( ll_job_id )
		//IF	ll_rc	<	0		THEN	Return ll_rc		
		// 08/08/01	GaryR	Track 2396d - End
	CASE	inv_temp_attrib.ici_key_table
		// Create the unique key table
		ll_rc		=	gnv_server.of_JobCreate ( ll_job_id )
		IF	ll_rc	<	0		THEN	Return ll_rc
		ll_rc		=	gnv_server.of_CreateKeyTable ( ll_job_id,		&
																inv_temp_attrib.is_inv_type,		&
																inv_temp_attrib.is_table_name )
		IF	ll_rc	<	0		THEN	Return ll_rc
		// 08/08/01	GaryR	Track 2396d - Begin
		//ll_rc		=	gnv_server.of_JobDelete ( ll_job_id )
		//IF	ll_rc	<	0		THEN	Return ll_rc
		// 08/08/01	GaryR	Track 2396d - End
	CASE	ELSE
		// Create the temp table
		// If the table name has not been previously set, compute the new name.
		If IsNull(ls_table_name)		&
		Or Trim(ls_table_name) < " "	Then
			ls_table_name	=	This.of_compute_new_table_name()
			// Make sure table name was generated successfully
			If IsNull(ls_table_name)		&
			Or Trim(ls_table_name) < " "	Then
				RETURN -1
			End if
		End if
		ll_rc	=	gnv_server.of_CreateTempTable ( inv_temp_attrib )
END CHOOSE

// 08/08/01	GaryR	Track 2396d
il_server_job_id = ll_job_id

// 08/07/01	GaryR
IF	ll_rc	=	0		THEN	ll_rc = 1

Return	ll_rc

end function

public function long of_get_server_job_id ();///////////////////////////////////////////////////////////////
//
//	This method returns the server job id
//	obtained via of_execute_sql
//
///////////////////////////////////////////////////////////////
//
// 08/08/01	GaryR	Track 2396d	Functional flaw creating subsets
//
///////////////////////////////////////////////////////////////

RETURN il_server_job_id
end function

public function string of_compute_new_table_name ();//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_compute_new_table_name
//
// Purpose:					Create the name of the new table, ensuring that it is unique.
//								The new table name will be comprised of:
//								1) User ID.
//								2)	Time in HHMM format.
//								3)	Sequence number in 999 format.
//
// Input:					None
//
// Returns:					string			- The name of the new temporary table.
//
//***************************************************************************************
// Maintenance Log:
// 01/15/98	JGG	Created function from TS145, Subset Redesign.
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Retrieval of meta data.
//	03/20/01	FDG	Stars 4.7.  
//	10/04/01	GaryR	Track 2434D	Eliminate the chance of creating duplicate temp tables
//
//***************************************************************************************

// Local variables

//	10/04/01	GaryR	Track 2434D - Begin
//Boolean						lb_done			=	FALSE
//Integer						li_sequence		=	0
//Long							ll_count, ll_rtn	//	12/04/00	GaryR
//String						ls_table_name,	&
//								ls_time
//								
//// Get the time stamp
//
//ls_time		=	String(Hour(Now()), '00') + String(Minute(Now()), '00')
//
//// Get the sequence number of the last temporary table built for this user
//// and increment it by one for the new table.
//
//Do Until lb_done	=	TRUE
//	// Increment the sequence counter
//	li_sequence++
//	// Format the table name
//	// FDG 03/21/01 begin
//	//ls_table_name	=	'TT_' 		&
//	//					+ 	gc_user_id 	&
//	//					+ 	'_T' 			&
//	//					+ 	ls_time 		&
//	//					+ 	'_' 			&
//	//					+ 	String(li_sequence, '000')
//	ls_table_name	=	'TT_' 		&
//						+ 	ls_time 		&
//						+ 	String(li_sequence, '000')		&
//						+	'_'			&
//						+	Left (gc_user_id, 3)
//	
//	// See if the table name exists in the sysobjects table
//	//	12/04/00	GaryR Begin	
//	//	SELECT 	 count(*)
//	//	INTO		:ll_count
//	//	FROM		 sysobjects
//	//	WHERE		 name	=	:ls_table_name
//	//	USING		 Stars2ca;
//
//	ll_rtn = gnv_sql.of_table_exists( ls_table_name )
//
//	// Check the SQL status	
//	//	CHOOSE CASE Stars2ca.of_check_status()
//	// Check the return from method.
//	CHOOSE CASE ll_rtn
//		CASE -1
//			// Bad return code
//			RETURN ""
//		CASE 0
//			// Table name does not exist
//			lb_done	=	TRUE
//		CASE ELSE
////			If IsNull(ll_count)	&
////			Or ll_count < 1		Then
////				// The table name does not currently exist, so it can be used.
////				lb_done	=	TRUE
////			End if
//	END CHOOSE
//		//	12/04/00	GaryR End
//	// The table name already exists, so loop one more time
//LOOP

String	ls_table_name, ls_key_id

ls_key_id = fx_get_next_key_id( "CRITERIA" )
IF ls_key_id = "ERROR" THEN
	MessageBox( "ERROR","Error getting next key id for criteria in n_cst_temp_table::of_compute_new_table_name" )
	Return ""
END IF

ls_table_name = "TT_" + ls_key_id
IF gnv_sql.of_table_exists( ls_table_name ) <> 0 THEN Return ""
//	10/04/01	GaryR	Track 2434D - End

inv_temp_attrib.is_table_name	=	ls_table_name

RETURN	ls_table_name

end function

public function integer of_drop_table (string as_table_name);//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				of_drop_table
//
// Purpose:					Drop the table named in the passed argument.
//
// Notes:					This is an overloaded function.
//
// Input:					as_table_name	-	the name of the temporary table to drop.
//
// Returns:					integer	(1 = Successful; -1 = Unsuccessful)
//
//***************************************************************************************
// Maintenance Log:	
//	01/15/98	JGG	Created function from TS145, Subset Redesign.
//	02/05/98	FDG	If the table name does not begin with the	userid, then don't allow the 
//						drop of the	table.  This is to prevent the accidental	dropping of 
//						"non-temporary" tables.
//	02/18/98	JGG	Allow drop of tables named ICN_{subc_id}
//	03/20/00	FDG	Allow for the beginning of the temp table name to also begin with 'KEY_'.
//	04/14/00	FDG	Track 2789c.  Determine if the table exists before dropping it.
//	03/21/01	FDG	Stars 4.7.  Call Stars Server to drop a temp table.
//	01/15/02	FDG	Track 2679d.  ASE temp tables are prefixed with the database name.
//	04/24/06	GaryR	SPR 4718	Do not pass db prefix to the server.
//***************************************************************************************

// Verify input string received
If Trim(as_table_name) < ' '	Then
	RETURN -1
End if

// Declare local variables
Integer						li_pos
String						ls_sql

//	Verify that the table is a temporary table.
// FDG 03/20/00.  Allow the beginning of the table name to begin with 'KEY_'
// FDG 03/20/01.  Allow the beginning of the table name to begin with 'TT_'
// FDG 01/15/02 - ASE temp tables are prefixed with the database name
IF	Pos( Upper(as_table_name), 'ICN_' )	>	0		&
OR	Pos( Upper(as_table_name), 'KEY_' )	>	0		&
OR	Pos( Upper(as_table_name), 'TT_' )	>	0		THEN
	// Okay to drop this table
Else
	// now verify that table name begins with the user's user id.
	li_pos	=	Pos (as_table_name, gc_user_id)

	IF	li_pos	<	1		THEN
		MessageBox ('Drop Table Error', 'You are not authorized to drop ' +	&
					'table: '	+	as_table_name	+	'.  You may be '		+	&
					'attempting to drop a permanent table.')
		RETURN -1
	END IF
End if

// FDG 04/14/00 - begin.
// If the table does not exist, don't drop it.
ls_sql		=	"Select count(*) from "	+	as_table_name
Execute	Immediate	:ls_sql	Using	Stars2ca;
IF	Stars2ca.SQLCode	<>	0		THEN	Return	1
// FDG 04/14/00 - end

// Remove the database prefix
li_pos = Pos( as_table_name, ".." )
IF li_pos > 0 THEN as_table_name = Mid( as_table_name, li_pos + 2 )

Return gnv_server.of_DropTempTable ( as_table_name )
end function

on n_cst_temp_table.create
call super::create
end on

on n_cst_temp_table.destroy
call super::destroy
end on

event constructor;//***************************************************************************************
// Non Visual Object:	n_cst_temp_table
//
// Function:				constructor event
//
// Purpose:					Initialize instance variables used by the user object functions. 
//
// Parms:					None
//
// Returns:					None
//
//***************************************************************************************
// Maintenance Log:		01/15/98		JGG	Created function from TS145, Subset Redesign.
//
//***************************************************************************************

// Initialize instance variables

ib_got_server_info	=	FALSE

is_os_login				=	""
is_os_password			=	""
is_os_server_name		=	""

is_ss_login				=	""
is_ss_password			=	""
is_ss_server_name		=	""

end event

