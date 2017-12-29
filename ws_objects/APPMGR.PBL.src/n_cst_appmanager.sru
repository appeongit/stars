$PBExportHeader$n_cst_appmanager.sru
$PBExportComments$Application manager object for STARS (inherited from n_base) <logic>
forward
global type n_cst_appmanager from n_base
end type
end forward

global type n_cst_appmanager from n_base
event ue_opensheetwithparm ( string as_window,  any aa_parm )
event ue_opensheet ( string as_window )
event documentation ( )
end type
global n_cst_appmanager n_cst_appmanager

type prototypes
// DLL for Stars Server
Function	long	DllRegisterServer()	Library	"StarsCom.dll"
end prototypes

type variables
// Are the windows going to be resized?
Protected		Boolean	ib_resize

// Directory for the INI file
Protected		String	is_directory

// INI file name
Protected		String	is_ini_file

// Version String for the application
Protected		String	is_version

// Application Name
Protected		String	is_appname

// Encryption counter
Protected		Integer	ii_encrypt = 15

// User ID and Password
Protected		String	is_userid
Protected		Integer	ii_security_level

// The style in which to open a sheet
// Values = 'ORIGINAL', 'LAYERED', 'CASCADED'
Protected		String	is_window_style

// The user's INI file
Protected		String	is_user_ini_file

// Does the user have read only authority
Protected		Boolean	ib_read_only = FALSE

// Frame window
Protected		w_master	iw_frame

// Help file name
Protected		String	is_helpfile

// Logo file name
Protected		String	is_logo

// Saved query ID
Protected		String	is_query_id

// User's default invoice type
Protected		String	is_default_inv_type

// FDG 2/19/01 - Object Factory Stars Server object to
//	connect to Stars Server
Protected		OleObject	iole_factory
Protected		String		is_server_name
Protected		String		is_server_userid
Protected		String		is_server_password
Protected		String		is_server_dbname
Protected		String		is_new_password
// FDG 2/19/01 - end

//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
// Should the idle event occur
Protected		Boolean	ib_idle

//	04/13/04	GaryR	Track 6717c	Use Idle with PB9 to prevent double logon
Protected		Long	il_idle_sec

//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
Protected		Boolean	ib_lock

//	12/19/08	GaryR	Track 5617	Streamline automated build process
Protected constant String ics_build = "1." + String( ProfileInt( + &
				"build.ini", "version_control", "build", 1 ), "000" )
Protected	Integer ii_dummy = SetProfileString( "build.ini", "version_control", &
				"build", String( ProfileInt( "build.ini", "version_control", "build", 1 ) +1 ) )
end variables

forward prototypes
public subroutine of_set_directory (string as_directory)
public function string of_get_directory ()
public subroutine of_set_ini_file (string as_ini_file)
public function string of_get_ini_file ()
public subroutine of_set_version (string as_version)
public subroutine of_set_appname (string as_appname)
public function string of_get_version ()
public function integer of_encrypt_string (ref string as_string)
public subroutine of_set_userid (string as_userid)
public function integer of_get_security_level ()
public subroutine of_set_security_level (integer ai_security_level)
public function string of_get_open_style ()
public subroutine of_set_open_style (string as_style)
public function string of_get_user_ini_file ()
public subroutine of_set_user_ini_file (string as_user_ini_file)
public subroutine of_set_read_only (boolean ab_switch)
public function boolean of_get_read_only ()
public subroutine of_set_logo (string as_logo_file)
public function string of_get_logo ()
public subroutine of_set_frame (w_master aw_frame)
public function w_master of_get_frame ()
public subroutine of_set_resize (boolean ab_switch)
public function boolean of_get_resize ()
public subroutine of_set_query_id (string as_query_id)
public function string of_get_query_id ()
public function date of_get_server_date ()
public function datetime of_get_server_date_time ()
public function string of_get_helpfile ()
public subroutine of_set_helpfile (string as_helpfile)
public subroutine of_set_server_dbname (string as_server_dbname)
public subroutine of_set_server_userid (string as_server_userid)
public subroutine of_set_server_password (string as_server_password)
public subroutine of_set_new_password (string as_new_password)
public function string of_get_userid ()
public function string of_get_server_password ()
public function string of_get_server_name ()
public subroutine of_set_server_name (string as_server_name)
public function integer of_shutdown_server ()
public function boolean of_edit_version ()
public function string of_get_appname ()
public function integer of_killusersession ()
public function integer of_killusersession (string as_server, string as_user, string as_password, string as_database)
public function boolean of_is_previous_logon (string as_message)
public subroutine of_set_default_inv_type (string as_inv_type)
public function string of_get_default_inv_type ()
public subroutine of_set_user_messages (boolean ab_switch)
public function boolean of_get_idle ()
public function integer of_logon_to_server (string as_server_userid, string as_server_password)
public subroutine of_set_idle (boolean ab_switch)
public function boolean of_is_multiple_logon (string as_message)
public function integer of_logon_and_change_password (string as_server_userid, string as_server_password, string as_new_password)
public function integer of_logon_to_server ()
public function long of_registerserver ()
public function integer of_logon_and_change_password ()
public function integer of_decrypt_string (ref string as_string)
public function boolean of_is_filter_name (string as_value)
public function string of_get_filter_type (string as_filter_name)
public subroutine of_set_lock (boolean ab_lock)
public function boolean of_get_lock ()
public subroutine of_set_idle_time (long al_idle_minutes)
public function string of_get_build ()
public function boolean of_is_password_expired (ref string as_message)
public subroutine of_npi_cntl ()
public function string of_get_server_url ()
public subroutine of_set_colors ()
public function integer of_set_yellow_lookup (boolean ab_switch)
end prototypes

event ue_opensheetwithparm;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_OpenSheetWithParm
//
//	Arguments:		
//		as_window  (String) - Name of the window to open
//		aa_parm (Any) - The parm to pass to the new window.
//
//	Returns:  N/A
//
//	Description:	Open the specified window with the parm passed to
//						this function.  The style in which to open the
//						window is dependent on the user INI file setting.
//
//////////////////////////////////////////////////////////////////////////////


Window		lw_win
String		ls_parm
Double		ld_parm
PowerObject	lpo_parm

CHOOSE CASE ClassName (aa_parm)
	CASE 'integer', 'decimal', 'double', 'long', 'real', 'unsignedinteger', 'unsignedlong'
		ld_parm	=	aa_parm

		CHOOSE CASE Upper ( of_get_open_style () )
			CASE 'ORIGINAL'
				OpenSheetWithParm (lw_win, ld_parm, as_window, this.of_get_frame(), 0, Original!)
			CASE 'LAYERED'
				OpenSheetWithParm (lw_win, ld_parm, as_window, this.of_get_frame(), 0, Layered!)
			CASE 'CASCADED'
				OpenSheetWithParm (lw_win, ld_parm, as_window, this.of_get_frame(), 0, Cascaded!)
			CASE ELSE
				OpenSheetWithParm (lw_win, ld_parm, as_window, this.of_get_frame(), 0, Original!)
		END CHOOSE
		
	CASE 'string', 'character'
		ls_parm	=	aa_parm

		CHOOSE CASE Upper ( of_get_open_style () )
			CASE 'ORIGINAL'
				OpenSheetWithParm (lw_win, ls_parm, as_window, this.of_get_frame(), 0, Original!)
			CASE 'LAYERED'
				OpenSheetWithParm (lw_win, ls_parm, as_window, this.of_get_frame(), 0, Layered!)
			CASE 'CASCADED'
				OpenSheetWithParm (lw_win, ls_parm, as_window, this.of_get_frame(), 0, Cascaded!)
			CASE ELSE
				OpenSheetWithParm (lw_win, ls_parm, as_window, this.of_get_frame(), 0, Original!)
		END CHOOSE

	CASE ELSE
		lpo_parm	=	aa_parm

		CHOOSE CASE Upper ( of_get_open_style () )
			CASE 'ORIGINAL'
				OpenSheetWithParm (lw_win, lpo_parm, as_window, this.of_get_frame(), 0, Original!)
			CASE 'LAYERED'
				OpenSheetWithParm (lw_win, lpo_parm, as_window, this.of_get_frame(), 0, Layered!)
			CASE 'CASCADED'
				OpenSheetWithParm (lw_win, lpo_parm, as_window, this.of_get_frame(), 0, Cascaded!)
			CASE ELSE
				OpenSheetWithParm (lw_win, lpo_parm, as_window, this.of_get_frame(), 0, Original!)
		END CHOOSE

END CHOOSE

end event

event ue_opensheet;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_OpenSheet
//
//	Arguments:		
//		as_window  (String) - Name of the window to open
//
//	Returns:  N/A
//
//	Description:	Open the specified window.
//
//////////////////////////////////////////////////////////////////////////////

w_master	lw_win

CHOOSE CASE Upper ( of_get_open_style () )
	CASE 'ORIGINAL'
		OpenSheet (lw_win, as_window, this.of_get_frame(), 0, Original!)
	CASE 'LAYERED'
		OpenSheet (lw_win, as_window, this.of_get_frame(), 0, Layered!)
	CASE 'CASCADED'
		OpenSheet (lw_win, as_window, this.of_get_frame(), 0, Cascaded!)
	CASE ELSE
		OpenSheet (lw_win, as_window, this.of_get_frame(), 0, Original!)
END CHOOSE

end event

event documentation;/*
Release notes will be placed here


Version/User	Description
------------	-----------
3.6 				Added the ability to resize all windows



*/

end event

public subroutine of_set_directory (string as_directory);//************************************************************
//	Script:	of_set_directory
//
//	Arguments:
//			as_directory - The name of the directory to store
//
//	Description:
//			This function will save the name of the directory 
//			for future use.  This directory name should include
//			the "\" at the end of the path.
//************************************************************

is_directory	=	as_directory

end subroutine

public function string of_get_directory ();//************************************************************
//	Script:	of_get_directory
//
//	Arguments:
//			as_directory - The name of the directory to store
//	Returns	-	String: The name of the directory
//
//	Description:
//			This function will return the name of the directory
//			previously saved by of_set_directory.
//************************************************************

Return	is_directory

end function

public subroutine of_set_ini_file (string as_ini_file);//************************************************************
//	Script:	of_set_ini_file
//
//	Arguments:	as_directory - The name of the ini file
//
//	Returns:		None
//
//	Description:
//			This function will save the name of the ini file
//			for future use.
//************************************************************

is_ini_file	=	as_ini_file


end subroutine

public function string of_get_ini_file ();//************************************************************
//	Script:	of_get_ini_file
//
//	Arguments:	None
//
//	Returns:	String - The name of the ini file
//
//	Description:
//			This function will return the name of the ini file
//			previously saved by of_set_ini_file
//************************************************************

Return	is_ini_file


end function

public subroutine of_set_version (string as_version);//************************************************************
//	Script:	of_set_version
//
//	Arguments:
//			as_version - A string containing the version of
//								the system
//
//	Description:
//			This function will save the version for
//			future use.
//************************************************************

is_version	=	as_version


end subroutine

public subroutine of_set_appname (string as_appname);//************************************************************
//	Script:	of_set_version
//
//	Arguments:
//			as_version - A string containing the name of
//								the application
//
//	Description:
//			This function will save the version for
//			future use.
//************************************************************

is_appname	=	as_appname


end subroutine

public function string of_get_version ();//************************************************************
//	Script:	of_get_version
//
//	Arguments: - None
//			
//	Returns	-	String: The name of the version
//
//	Description:
//			This function will return the name of the application
//			version previously saved by of_set_version.
//************************************************************

Return	is_version

end function

public function integer of_encrypt_string (ref string as_string);//*********************************************************
//	Script:	of_encrypt_string
//
//	Arguments:
//		as_string (Reference) - String to encrypt
//
//	Returns:
//		Integer:	1=successful, -1=error
//
//	Description:
//		This function will encrypt the argument string.
//		
//
//*********************************************************

Char	lc_from[],		&
		lc_to[]
		
Integer	li_ctr,			&
			li_max,			&
			li_ascii,		&
			li_encrypt

IF	IsNull (as_string)		THEN
	Return -1
END IF

lc_from		=	as_string

li_max	=	UpperBound (lc_from)

FOR li_ctr	=	1	TO	li_max
	// Change the encryption for even characters
	IF	li_ctr	=	2		&
	OR	li_ctr	=	4		&
	OR	li_ctr	=	6		THEN
		li_encrypt	=	ii_encrypt	*	2
	ELSE
		li_encrypt	=	ii_encrypt
	END IF
	li_ascii	=	Asc ( lc_from[li_ctr] )
	li_ascii	=	li_ascii	+	li_encrypt
	lc_to [li_ctr]	=	Char (li_ascii)
NEXT

as_string	=	lc_to

Return 1

end function

public subroutine of_set_userid (string as_userid);//************************************************************
//	Script:	of_set_userid
//
//	Arguments:
//			as_userid - A string containing the user ID
//
//	Description:
//			This function will save the User ID for
//			future use.
//************************************************************

is_userid	=	as_userid



end subroutine

public function integer of_get_security_level ();//************************************************************
//	Script:	of_get_security_level
//
//	Arguments:
//			None
//
//	Description:
//			This function will return the Security Level saved by
//			of_set_security_level.
//************************************************************

Return	ii_security_level




end function

public subroutine of_set_security_level (integer ai_security_level);//************************************************************
//	Script:	of_set_security_level
//
//	Arguments:
//			ai_security_level - An integer containing the
//										security level.
//
//	Description:
//			This function will save the Security Level for
//			future use.
//************************************************************

ii_security_level	=	ai_security_level



end subroutine

public function string of_get_open_style ();//************************************************************
//	Script:	of_get_open_style
//
//	Arguments:	None
//			
//	Returns	-	String: The way in which to open a sheet window
//
//	Description:
//			From the user's INI file, get the style in which
//			to open a sheet window.  is_window_style is set
//			from of_set_open_style.
//
//************************************************************

String	ls_window_style
String	ls_user

IF	Trim (is_window_style)	>	' '	THEN
	Return is_window_style
END IF

ls_user	=	This.of_get_userid()

ls_window_style	=	ProfileString (is_user_ini_file, 'Window', 'Style', '' )

IF	Trim (ls_window_style)	>	' '		THEN
	is_window_style	=	ls_window_style
ELSE
	IF	Trim (is_window_style)	<	' '	THEN
		is_window_style	=	'ORIGINAL'
	END IF
END IF

Return	is_window_style

end function

public subroutine of_set_open_style (string as_style);//************************************************************
//	Script:	of_set_open_style
//
//	Arguments:	as_style - The way in which to open a window
//			
//	Returns	-	N/A
//
//	Description:
//			Set the user's INI file with the style in which to 
//			open a sheet window
//
//************************************************************

String	ls_user

is_window_style	=	as_style

ls_user	=	This.of_get_userid()

//UPDATE	employee_list
//SET		open_style	=	:is_window_style
//WHERE		email_id		=	:ls_user
//USING		SQLCA		;
//
//SQLCA.of_check_status()

//SetProfileString ( is_user_ini_file, 'Window', 'Style', as_style )

Return

end subroutine

public function string of_get_user_ini_file ();//===================================================================================================//
// Object		n_cst_appmanager
// Function		of_get_user_ini_file public
// Arguments	
// Returns		String path to the user ini file
// ------------------------------------------------------------------------------------------------- //
// Retrieves the path for the user ini file.  Verifies that it exists, if it does not then it creates the file.
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	05/24/10	Katie Track 5803 Add check to see if file exists and create it if it is missing.
//
//===================================================================================================//

int li_fileNumber

IF	Trim (is_user_ini_file)	>	' '		THEN
	Return	is_user_ini_file
END IF

String	ls_path,		&
			ls_userid
			
ls_userid	=	This.of_get_userid()

IF	Trim ( ls_userid )		<	' '		THEN
	// No user id set.  Cannot get the user's ini file without the userid
	Return ''
END IF

ls_path	=	ProfileString ( This.of_get_ini_file(), 'carrier', 'UserINIPath', '')
is_user_ini_file	=	ls_path	+	ls_userid	+	'.INI'


//Check to see if file exists - if it does not then create it.
if not (FileExists(is_user_ini_file)) then
	li_fileNumber = FileOpen(is_user_ini_file,LineMode!,Write!)
	FileClose(li_fileNumber)
end if

Return is_user_ini_file


end function

public subroutine of_set_user_ini_file (string as_user_ini_file);//************************************************************
//	Script:	of_set_user_ini_file
//
//	Arguments:
//			as_user_ini_file - The name of the user's ini file
//
//	Description:
//			This function will save the name of the user's ini file
//			for future use.
//************************************************************

is_user_ini_file	=	as_user_ini_file


end subroutine

public subroutine of_set_read_only (boolean ab_switch);//************************************************************
//	Script:	of_set_read_only
//
//	Arguments:	ab_switch 
//						TRUE - Set read-only to true
//						FALSE- Set read-only to false
//			
//	Returns	-	N/A
//
//	Description:
//			Set the user's security so that the user does (or
//			does not) have read-only authority.  Read-only
//			authority will not allow the user to update the
//			data on a window.
//
//************************************************************

ib_read_only	=	ab_switch
end subroutine

public function boolean of_get_read_only ();//************************************************************
//	Script:	of_get_read_only
//
//	Arguments:	None
//			
//	Returns	-	Boolean
//						TRUE - Set read-only to true
//						FALSE- Set read-only to false
//
//	Description:
//			Return the user's security so that the user does (or
//			does not) have read-only authority.  Read-only
//			authority will not allow the user to update the
//			data on a window.
//
//************************************************************

Return	ib_read_only

end function

public subroutine of_set_logo (string as_logo_file);//************************************************************
//	Script:	of_set_logo
//
//	Arguments:
//			as_logo_file - The name of the logo file
//
//	Description:
//			This function will save the name of the logo file
//			for future use.
//************************************************************

is_logo	=	as_logo_file

end subroutine

public function string of_get_logo ();//************************************************************
//	Script:	of_get_logo
//
//	Arguments:	None
//
//	Returns:	String - The name of the logo file
//
//	Description:
//			This function will return the name of the logo file
//			previously saved by of_set_logo.
//************************************************************

Return	is_logo

end function

public subroutine of_set_frame (w_master aw_frame);//************************************************************
//	Script:	of_set_frame
//
//	Arguments:
//			aw_frame - The frame window
//
//	Description:
//			This function will save the frame window
//			for future use.
//************************************************************

iw_frame	=	aw_frame

end subroutine

public function w_master of_get_frame ();//************************************************************
//	Script:	of_get_frame
//
//	Arguments:	None
//
//	Returns:	w_master - The frame window
//
//	Description:
//			This function will return the frame window
//			previously saved by of_set_frame
//************************************************************

Return	iw_frame

end function

public subroutine of_set_resize (boolean ab_switch);//************************************************************
//	Script:	of_set_resize
//
//	Arguments:	ab_switch 
//						TRUE - Set resize to true
//						FALSE- Set resize to false
//			
//	Returns	-	N/A
//
//	Description:
//			Set the user's preferences so that all sheets within
//			STARS will or will not resize when opening.
//
//************************************************************

Integer	li_rc

ib_resize	=	ab_switch

m_stars_30.m_window.m_resize.checked	=	ab_switch

IF	ab_switch	=	TRUE		THEN
	li_rc	=	SetProfileString (This.of_get_user_ini_file(), 'Resize', 'Resize', 'TRUE')
ELSE
	li_rc	=	SetProfileString (This.of_get_user_ini_file(), 'Resize', 'Resize', 'FALSE')
END IF

end subroutine

public function boolean of_get_resize ();//************************************************************
//	Script:	of_get_resize
//
//	Arguments:	N/A
//			
//	Returns	-	Boolean
//						TRUE - Set resize to true
//						FALSE- Set resize to false
//
//	Description:
//			Return whether or not all sheets within
//			STARS will or will not resize when opening.
//
//************************************************************

IF	ib_resize	=	TRUE		&
OR	ib_resize	=	FALSE		THEN
	Return	ib_resize
END IF

String	ls_resize,			&
			ls_userinifile

//	Get the resize setting from the user's ini file (default
//	to true).

ls_userinifile	=	This.of_get_user_ini_file()

IF	Trim (ls_userinifile)	<	' '		THEN
	// Cannot get the user's ini file.  Return true, but don't set the
	//	switch until later
	Return TRUE
END IF

ls_resize	=	ProfileString (ls_userinifile, 'Resize', 'Resize', 'TRUE')

IF	ls_resize	=	'TRUE'		THEN
	This.of_set_resize (TRUE)
ELSE
	This.of_set_resize (FALSE)
END IF

Return	ib_resize


end function

public subroutine of_set_query_id (string as_query_id);//************************************************************
//	Script:	of_set_query_id
//
//	Arguments:	as_query_id - The name of the query ID
//
//	Returns:		None
//
//	Description:
//			This function will save the query ID for future use.
//			
//************************************************************

is_query_id		=	as_query_id

end subroutine

public function string of_get_query_id ();//************************************************************
//	Script:	of_get_query_id
//
//	Arguments:	None
//
//	Returns:		String - The name of the query ID
//
//	Description:
//			This function will return the name of the query ID
//			previously saved by of_set_query_id
//************************************************************

Return	is_query_id


end function

public function date of_get_server_date ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// of_get_server_date 						n_cst_appmanager
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//This function will get the server date.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    None	
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Date							Current server date in mm/dd/yy format
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
// NLG		01/11/99		Created (copied logic from of_get_server_date_time())
//	FDG		01/12/99		Get the date from one function and reformat.
//
/////////////////////////////////////////////////////////////////////////////

Datetime		ldtm_server_date_time
Date			ldt_server_date

ldtm_server_date_time	=	This.of_get_server_date_time()

ldt_server_date			=	Date (ldtm_server_date_time)

Return		ldt_server_date

end function

public function datetime of_get_server_date_time ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// of_get_server_date 						n_cst_appmanager
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//This function will get the server date.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    None	
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Datetime						Current server date in mm/dd/yy format
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	A.Sola	01/09/98		Created.
//	FDG		12/13/00		Stars 4.7.  Make the system date DBMS-independent.
//
/////////////////////////////////////////////////////////////////////////////
datetime ldte_date, ldte_server_date_time
integer li_rc

// FDG 12/13/00 Begin
//Select Distinct getdate() into :ldte_date from stars_win_parm using stars2ca;
//
//li_rc = stars2ca.of_check_status()
//
//if li_rc<>0 then
//	ldte_server_date_time = datetime(Today(),Now())
//else
//	ldte_server_date_time = ldte_date
//end if
ldte_server_date_time	=	gnv_sql.of_get_current_datetime()
// FDG 12/13/00 End

Return	ldte_server_date_time

end function

public function string of_get_helpfile ();//************************************************************
//	Script:	of_get_help_file
//
//	Arguments:	None
//
//	Returns:	String - The name of the help file
//
//	Description:
//			This function will return the name of the help file
//			previously saved by of_set_helpfile
//************************************************************

Return	is_helpfile

end function

public subroutine of_set_helpfile (string as_helpfile);//************************************************************
//	Script:	of_set_helpfile
//
//	Arguments:
//			as_helpfile - The name of the help file
//
//	Description:
//			This function will save the name of the help file
//			for future use.
//************************************************************

is_helpfile	=	as_helpfile

end subroutine

public subroutine of_set_server_dbname (string as_server_dbname);//************************************************************
//	Script:	of_set_server_dbname
//
//	Arguments:
//			as_server_dbname - The Stars Server database name
//
//	Description:
//			This function will save the name of the Stars Server
//			database name for future use.
//************************************************************

is_server_dbname	=	as_server_dbname

end subroutine

public subroutine of_set_server_userid (string as_server_userid);//************************************************************
//	Script:	of_set_server_userid
//
//	Arguments:
//			as_server_userid - The Stars Server User ID
//
//	Description:
//			This function will save the name of the Stars Server
//			User ID for future use.
//************************************************************

is_server_userid	=	as_server_userid

end subroutine

public subroutine of_set_server_password (string as_server_password);//************************************************************
//	Script:	of_set_server_password
//
//	Arguments:
//			as_server_password - The Stars Server password
//
//	Description:
//			This function will save the name of the Stars Server
//			password for future use.
//************************************************************

is_server_password	=	as_server_password

end subroutine

public subroutine of_set_new_password (string as_new_password);//************************************************************
//	Script:	of_set_new_password
//
//	Arguments:
//			as_new_password - The Stars Server new password
//
//	Description:
//			This function will save the name of the Stars Server
//			new password for future use.
//************************************************************

is_new_password	=	as_new_password

end subroutine

public function string of_get_userid ();//************************************************************
//	Script:	of_get_userid
//
//	Arguments:
//			None
//
//	Description:
//			This function will return the User ID saved by
//			of_set_userid.
//************************************************************

Return	is_userid



end function

public function string of_get_server_password ();//************************************************************
//	Script:	of_get_server_password
//
//	Arguments:
//			None
//
//	Description:
//			This function will return the server password saved by
//			of_set_server_password.
//************************************************************

Return	is_server_password


end function

public function string of_get_server_name ();//************************************************************
//	Script:	of_get_server_name
//
//	Arguments:
//			None
//
//	Description:
//			This function will return the server name saved by
//			of_set_server_name.
//************************************************************

Return	is_server_name


end function

public subroutine of_set_server_name (string as_server_name);//************************************************************
//	Script:	of_set_server_name
//
//	Arguments:
//			as_server_name - The Stars Server name
//
//	Description:
//			This function will save the name of the Stars Server
//			name for future use.
//************************************************************

is_server_name	=	as_server_name

end subroutine

public function integer of_shutdown_server ();//************************************************************
//	Script:	of_shutdown_server
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will issue a shutdown call to Stars Server.
//			This call will notify Stars Server that this user is no
//			longer connected.
//
//	Note:	This function is called when the user is gracefully leaving
//			Stars.  Destroying object gole_server, which occurs in the
//			application's close event, will automatically diconnect the
//			user from Stars Server.  As a result, no logic in this script
//			is required.
//
//			However, when a user times out of Stars or if the user did
//			not gracefully exit Stars, function of_killusersession will
//			notify Stars Server to disconnect the user.
//
//************************************************************

//Long		ll_rc
//
//String	ls_error

// iole_factory.Shutdown shuts down Stars Server for all users.  We need to shut down
//	Stars Server for one user.
//ll_rc	=	iole_factory.KillUserSession (is_server_name, is_server_userid, is_server_password, is_server_dbname)

//IF	ll_rc	<	0		THEN
//	ls_error	=	iole_factory.GetLastError()
//	MessageBox ("Error", "Error in n_cst_appmanager.of_shutdown_server.  "	+	ls_error)
//	Return	-1
//ELSE
//	Return	1
//END IF

Return	1



end function

public function boolean of_edit_version ();///////////////////////////////////////////////////////////////////
//
//n_cst_appmanager::of_edit_version()
//	checks sys_cntl for app version
//
///////////////////////////////////////////////////////////////////
//
//	08/09/99	NLG	Created
//	01/27/05	GaryR	Remove obsolete logic
//	10/05/05	GaryR	Track 4542d	Do not perform an exact match of versions, do a like
//
///////////////////////////////////////////////////////////////////

string ls_database_version
integer li_rc

select cntl_text
into :ls_database_version
from sys_cntl
where cntl_id = 'VERSION'
USING STARS2CA;

li_rc = stars2ca.of_check_status()

if li_rc <> 0 then
	Return FALSE
end if

IF Pos( Upper (ls_database_version), Upper (is_version) ) > 0 THEN
	Return  TRUE
ELSE
	Return  FALSE
END IF
end function

public function string of_get_appname ();//************************************************************
//	Script:	of_get_appname
//
//	Arguments: - None
//			
//	Returns	-	String: The name of the application
//
//	Description:
//			This function will return the name of the application
//			previously saved by of_set_appname.
//************************************************************

Return	is_appname

end function

public function integer of_killusersession ();//************************************************************
//	Script:	of_KillUserSession - Overloaded function
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This overloaded function will call Stars Server to Kill a user session
//			on Stars Server and on possibly the database.
//
//			This function is called when a user attempts to logon, is already
//			logged on, and want to Kill any prior User sessions.
//
//************************************************************
//
//	FDG	03/22/01	Stars 4.7.  Created.
//
//************************************************************

Return	This.of_KillUserSession (is_server_name,		&
											is_server_userid,		&
											is_server_password,	&
											is_server_dbname)


end function

public function integer of_killusersession (string as_server, string as_user, string as_password, string as_database);//************************************************************
//	Script:	of_KillUserSession
//
//	Arguments:	1.	as_server
//					2.	as_user
//					3.	as_password
//					4.	as_database
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call Stars Server to Kill a user session
//			on Stars Server and on possibly the database.
//
//			This function is called when a user attempts to logon, is already
//			logged on, and want to Kill any prior User sessions.
//
//************************************************************
//
//	FDG	03/22/01	Stars 4.7.  Created.
//
//************************************************************

Long		ll_rc

String	ls_error

//f_debug_box ('Debug', ' ')
//f_debug_box ('Debug', 'Killing session on Stars Server.')
//f_debug_box ('Debug', '   Stars Server Server name = '		+	as_server )
//f_debug_box ('Debug', '   Stars Server Server user ID = '	+	as_user )
//f_debug_box ('Debug', '   Stars Server Server password = '	+	as_password )
//f_debug_box ('Debug', '   Stars Server Server dbname = '		+	as_database )
//f_debug_box ('Debug', ' ')

// Logon via the COM Object

ll_rc	=	iole_factory.KillUserSession	(as_server,		&
													as_user,			&
													as_password,	&
													as_database )

//f_debug_box ('Debug', 'Return code from Stars Server KillUserSession = '	+	String(ll_rc) )
//f_debug_box ('Debug', ' ')

IF	ll_rc	<	0		THEN
	ls_error	=	iole_factory.GetLastError()
	MessageBox ("Stars Server KillUserSession Error", ls_error)
	Return	-1
END IF

Return	1


end function

public function boolean of_is_previous_logon (string as_message);//************************************************************
//	Script:	of_is_previous_logon
//
//	Arguments:	as_message - The message returned from Stars Server
//
//	Returns:		Boolean
//					TRUE	=	User was previously logged on to Stars Server
//					FALSE	=	User was not previously logged on to Stars Server
//
//	Description:
//			This function is called by of_logon_to_server() and
//			of_logon_and_change_password().  This function will determine
//			if the user was already logged on to Stars Server.  This
//			is determined by deciphering the text of the message.
//
//************************************************************
//
//	FDG	02/21/01	Stars 4.7.  Created.
//	GayrR	06/28/01	The message has changed on the server.
//	GaryR	10/14/04	Track 3699d	Accomodate message changes for UserAdmin
//
//************************************************************

Return Match( Upper( as_message ), 'MAXIMUM SESSIONS ALLOWED' )
end function

public subroutine of_set_default_inv_type (string as_inv_type);//************************************************************
//	Script:	of_set_default_inv_type
//
//	Arguments:
//			as_inv_type - The base invoice type.
//
//	Description:
//			This function will save the base invoice type for this
//			user.
//************************************************************
//	GaryR	07/17/01	Stars 4.7	Cleanup Stars.ini file
//************************************************************

// Validate the input
IF IsNull (as_inv_type)						&
OR	as_inv_type	=	is_default_inv_type	THEN
	Return
END IF

//	GaryR	07/17/01	Stars 4.7 - Begin
//String	ls_userid
//Integer	li_rc
//			
//ls_userid	=	This.of_get_userid()
//
//IF	Trim ( ls_userid )		<	' '		THEN
//	// No user id set.  Cannot get the data without the userid
//	Return 
//END IF
//
//li_rc	=	SetProfileString ( This.of_get_ini_file(), ls_userid, 'InvoiceType', as_inv_type)
//	GaryR	07/17/01	Stars 4.7 - End

is_default_inv_type	=	as_inv_type

end subroutine

public function string of_get_default_inv_type ();//************************************************************
//	Script:	of_get_default_inv_type
//
//	Arguments:	None
//
//	Returns:	String - The name of the user's default invoice type
//
//	Description:
//			This function will return the name of the user's 
//			default base invoice type.  This was previously saved
//			by of_set_default_inv_type
//************************************************************
//	GaryR	07/17/01	Stars 4.7	Cleanup Stars.ini file
//************************************************************

Return is_default_inv_type
end function

public subroutine of_set_user_messages (boolean ab_switch);//*********************************************************************
//	Script:	of_set_user_messages
//
//	Arguments:	ab_switch
//					TRUE	=	Enable the opening of w_user_messages
//					FALSE	=	Disable the opening of w_user_messages
//
//	Description:
//			This function will enable/disable the user message
//			icon on the microhelp bar.
//*********************************************************************
//
//	09/05/01	GaryR	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//	12/24/03	GaryR	Track 3751	Standardize fonts/colors
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************

//	09/05/01	GaryR	Stars 4.8 - Begin
Long	ll_ctr
String ls_msg
//	09/05/01	GaryR	Stars 4.8 - End

// Edit the input
IF	IsNull (ab_switch)	THEN
	Return
END IF

w_time_microhelp.p_user_messages.visible	=	ab_switch
w_time_microhelp.p_user_messages.enabled	=	ab_switch

//	09/05/01	GaryR	Stars 4.8 - Begin
IF	ab_switch	=	TRUE		THEN	
	select count(*) 
	into :ll_ctr
	from user_message 
	where user_id = :gc_user_id
	and message_status = 'A'
	Using StarsUserMsg;
	
	IF StarsUserMsg.of_check_status() <> 0 OR ll_ctr < 1 THEN
		ls_msg = "Click here for messages"
	ELSE
		IF ll_ctr = 1 THEN
			ls_msg = "Click here for 1 message"
		ELSE
			ls_msg = "Click here for " + String( ll_ctr ) + " messages"
		END IF
	END IF
	w_time_microhelp.st_user_messages.BackColor = stars_colors.window_background
ELSE
	ls_msg	=	"No new messages"
	w_time_microhelp.st_user_messages.BackColor = stars_colors.button_face
END IF

w_time_microhelp.st_user_messages.text	=	ls_msg
//	09/05/01	GaryR	Stars 4.8 - End
end subroutine

public function boolean of_get_idle ();//************************************************************************
//	
//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
//
//************************************************************************

RETURN ib_idle
end function

public function integer of_logon_to_server (string as_server_userid, string as_server_password);//************************************************************
//	Script:	of_logon_to_server - Overloaded function
//
//	Arguments:	1.	as_server_userid - User ID from w_sign_on
//					2.	as_server_password - Password from w_sign_on
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This overloaded function will logon to Stars Server using the
//			user ID and password entered from w_sign_on by calling
//			of_logon_to_server().  If this function connects to
//			Stars Server successfully, then gole_server can be used
//			to call methods on Stars Server.
//************************************************************
//
//	FDG	02/21/01	Stars 4.7.  Created.
//
//************************************************************

Long		ll_rc

String	ls_server_name,		&
			ls_server_dbname

This.of_set_server_userid (as_server_userid)
This.of_set_server_password (as_server_password)

IF	Trim (is_server_name)	<	' '		THEN
	// No server name set.  Get it from Stars.ini
	ls_server_name		=	ProfileString (is_ini_file, 'StarsServer', 'Server', 'StarWars')
	ls_server_dbname	=	ProfileString (is_ini_file, 'StarsServer', 'Warehouse', 'Error')
	This.of_set_server_name (ls_server_name)
	This.of_set_server_dbname (ls_server_dbname)
END IF

Return	This.of_logon_to_server()


end function

public subroutine of_set_idle (boolean ab_switch);//************************************************************************
//	
//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
//	04/13/04	GaryR	Track 6717c	Use Idle with PB9 to prevent double logon
//
//************************************************************************

ib_idle = ab_switch

IF ab_switch THEN
	Idle( il_idle_sec )
ELSE
	Idle( 0 )
END IF
end subroutine

public function boolean of_is_multiple_logon (string as_message);//************************************************************
//	Script:	of_is_multiple_logon
//
//	Arguments:	as_message - The message returned from Stars Server
//
//	Returns:		Boolean
//					TRUE	=	User numerously attempted to log in to Stars Server
//					FALSE	=	User did not numerously attempt to log in to Stars Server
//
//	Description:
//			This function is called by of_logon_to_server() and
//			of_logon_and_change_password().  This function will determine
//			if the user has reached the maximum of allowed login attempts.
//			This is determined by deciphering the text of the message.
//
//************************************************************
//
//	GayrR	10/23/01	Stars 5.0.0	Created.
//	GaryR	10/14/04	Track 3699d	Accomodate message changes for UserAdmin
//
//************************************************************

Return Match( Upper( as_message ), 'YOU HAVE BEEN LOCKED OUT' )
end function

public function integer of_logon_and_change_password (string as_server_userid, string as_server_password, string as_new_password);//************************************************************
//	Script:	of_logon_to_server - Overloaded function
//
//	Arguments:	1.	as_server_userid - User ID from w_sign_on
//					2.	as_server_password - Password from w_sign_on
//					3.	as_new_password - New password from w_sign_on
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This overloaded function will logon to Stars Server using the
//			user ID, password and new password entered from w_sign_on by 
//			calling of_logon_and_change_password().  If this function 
//			connects to Stars Server successfully, then gole_server can be 
//			used to call methods on Stars Server.
//************************************************************
//
//	FDG	02/21/01	Stars 4.7.  Created.
//
//************************************************************

Long		ll_rc

String	ls_server_name,		&
			ls_server_dbname

This.of_set_server_userid (as_server_userid)
This.of_set_server_password (as_server_password)
This.of_set_new_password (as_new_password)

IF	Trim (is_server_name)	<	' '		THEN
	// No server name set.  Get it from Stars.ini
	ls_server_name		=	ProfileString (is_ini_file, 'StarsServer', 'Server', 'StarWars')
	ls_server_dbname	=	ProfileString (is_ini_file, 'StarsServer', 'Warehouse', 'Error')
	This.of_set_server_name (ls_server_name)
	This.of_set_server_dbname (ls_server_dbname)
END IF

Return	This.of_logon_and_change_password()


end function

public function integer of_logon_to_server ();//************************************************************
//	Script:	of_logon_to_server
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will connect to Stars Server based on the user ID
//			and password entered in w_sign_on.  Please note that gole_server
//			is passed by reference.  If the call is successful, gole_server
//			can then be used to call Stars Server methods,
//************************************************************
//
//	FDG	02/21/01	Stars 4.7.  Created.
//	FDG	03/23/01	Stars 4.7.	Only 1 Stars Server method exists to log on
//						to Stars Server.  Call of_logon_and_change_password().
//
//************************************************************

Integer	li_rc

is_new_password	=	''

li_rc	=	This.of_logon_and_change_password()

Return	li_rc

//Long		ll_rc
//
//Integer	li_pos,				&
//			li_rc
//
//String	ls_error
//
//f_debug_box ('Debug', ' ')
//f_debug_box ('Debug', 'Logging on to Stars Server.')
//f_debug_box ('Debug', '   Stars Server Server name = '	+	is_server_name )
//f_debug_box ('Debug', '   Stars Server Server user ID = '	+	is_server_userid )
//f_debug_box ('Debug', '   Stars Server Server password = '	+	is_server_password )
//f_debug_box ('Debug', '   Stars Server Server dbname = '		+	is_server_dbname )
//f_debug_box ('Debug', ' ')
//
//// Destroy any previous pointers to gole_server
//IF	IsValid (gole_server)	THEN
//	Destroy	gole_server
//END IF
//
//gole_server	=	CREATE	OLEObject
//
//// Logon via the COM Object
//
//ll_rc	=	iole_factory.Logon	(is_server_name,		&
//										is_server_userid,		&
//										is_server_password,	&
//										is_server_dbname,		&
//										REF gole_server)
//
//f_debug_box ('Debug', 'Return code from Stars Server logon = '	+	String(ll_rc) )
//f_debug_box ('Debug', ' ')
//
//IF	ll_rc	<	0		THEN
//	ls_error	=	iole_factory.GetLastError()
//	// If the error occured becasue the user was already logged on,
//	//	then allow the user to kill any prior user sessions.  This same
//	//	edit also occurs in of_logon_and_change_password().
//	IF	This.of_is_previous_logon (ls_error)		THEN
//		li_rc	=	MessageBox ('Sign On Error', 'You are currently logged on to Stars.  Would you like to '	+	&
//									'destroy any previous logon sessions?', Question!, OKCancel!, 1)
//		IF	li_rc	=	2		THEN
//			Return	-999
//		END IF
//		// At this point, the user wants to kill any prior sessions and attempt to logon again
//		ll_rc	=	This.of_KillUserSession()
//		IF	ll_rc	<	0		THEN
//			Return	ll_rc
//		END IF
//		// Destroy any previous pointers to gole_server
//		IF	IsValid (gole_server)	THEN
//			Destroy	gole_server
//		END IF
//		gole_server	=	CREATE	OLEObject
//		f_debug_box ('Debug', 'Re-logging on to Stars Server.')
//		f_debug_box ('Debug', ' ')
//		ll_rc	=	iole_factory.Logon	(is_server_name,		&
//												is_server_userid,		&
//												is_server_password,	&
//												is_server_dbname,		&
//												REF gole_server)
//		f_debug_box ('Debug', 'Return code from Stars Server re-logon = '	+	String(ll_rc) )
//		f_debug_box ('Debug', ' ')
//		IF	ll_rc	<	0		THEN
//			// The re-logon was unsuccessful
//			ls_error	=	iole_factory.GetLastError()
//			MessageBox ("Stars Server Logon Error", ls_error)
//			Return	-1
//		END IF
//	ELSE
//		MessageBox ("Stars Server Logon Error", ls_error)
//		Return	-1
//	END IF
//END IF
//
//Return	1


end function

public function long of_registerserver ();//************************************************************************
//	Script:	of_RegisterServer
//
//	Arguments:	None
//
//	Returns:		Long
//					-1	=	Error
//					 1	=	Success
//
//	Description:
//			This function will register the Stars Server DLL to
//			the user's registry.
//************************************************************************
//
//	04/10/02	GaryR	Track 2977d	Registering the COM object programatically
//
//************************************************************************


Integer		li_rc

// FDG 02/19/01 - Create iole_object and connect to it.

iole_factory	=	CREATE	OleObject

li_rc	=	iole_factory.ConnectToNewObject ("StarWars.StarWars")

IF li_rc < 0 THEN
	//	Attempt to register the COM object
	li_rc		=	DllRegisterServer()
	
	IF	li_rc	<>	0		THEN
		MessageBox ( "Application Error", "Failed to register the StarsCom.dll required for StarsServer" + &
													 "~n~rPlease contact your System Administrator before executing STARS", StopSign! )
		Return -1
	END IF
	
	//	If registration was successful, then reconnect
	li_rc	=	iole_factory.ConnectToNewObject ("StarWars.StarWars")
	
	IF li_rc < 0 THEN
		MessageBox ( "Application Error", "Failed to connect to the StarsCom.dll required for StarsServer" + &
													 "~n~rPlease contact your System Administrator before executing STARS", StopSign! )
		Return -1
	END IF	
END IF

Return	1
//	04/10/02	GaryR	Track 2977d - End
end function

public function integer of_logon_and_change_password ();//************************************************************
//	Script:	of_logon_and_change_password
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will connect to Stars Server based on the user ID,
//			password, and new password entered in w_sign_on.  Please note that
//			gole_server is passed by reference.  If the call is successful, 
//			gole_server can then be used to call Stars Server methods,
//************************************************************
//
//	FDG	02/21/01	Stars 4.7.  Created.
//	FDG	03/23/01	Stars 4.7.	Only 1 Stars Server method exists to log on
//						to Stars Server which includes with or without a
//						new password.
//	GaryR	10/23/01	Stars 5.0.0	Check for maximum logon attemtps.
//	GaryR	11/05/01	Stars 5.0.0	Redesign password expiration at logon.
//	FDG	04/09/02	Track 4141c.  Remove KillUserSession call.  Destroying
//						gole_server already removes the server session.
//	GaryR	10/14/04	Track 3699d	Accomodate message changes for UserAdmin
//	GaryR	02/16/04	Track 4296d	Display password expiration message from the server
//
//************************************************************

Long		ll_rc

Integer	li_rc

String	ls_error

// Destroy any previous pointers to gole_server
IF	IsValid (gole_server)	THEN
	Destroy	gole_server
END IF

gole_server	=	CREATE	OLEObject

// FDG 03/23/01 - Edit is_new_password
IF	IsNull (is_new_password)			&
OR	Trim (is_new_password)	=	''		THEN
	is_new_password	=	''
END IF
// FDG 03/23/01 end


ll_rc	=	iole_factory.Logon	(is_server_name,		&
										is_server_userid,		&
										is_server_password,	&
										is_new_password,		&
										is_server_dbname,		&
										REF gole_server)

IF	ll_rc	<	0		THEN
	ls_error	=	iole_factory.GetLastError()
	// If the error occured because the user was already logged on,
	//	then allow the user to kill any prior user sessions.  This same
	//	edit also occurs in of_logon_and_change_password().
	IF	This.of_is_previous_logon (ls_error)		THEN
		li_rc	=	MessageBox ('Sign On Warning', "You are currently logged on to Stars.~n~r" + &
															 "Would you like to destroy the previous connections?", + &
															 Exclamation!, OKCancel!, 2)
		IF	li_rc	=	2		THEN
			Return	-999
		END IF
		// At this point, the user wants to kill any prior sessions and attempt to logon again
		ll_rc	=	This.of_KillUserSession()			// FDG 04/09/02
		IF	ll_rc	<	0		THEN
			Return	ll_rc
		END IF
		// Destroy any previous pointers to gole_server
		IF	IsValid (gole_server)	THEN
			Destroy	gole_server
		END IF
		gole_server	=	CREATE	OLEObject
		ll_rc	=	iole_factory.Logon	(is_server_name,		&
												is_server_userid,		&
												is_server_password,	&
												is_new_password,		&
												is_server_dbname,		&
												REF gole_server)
		IF	ll_rc	<	0		THEN
			// The re-logon was unsuccessful
			ls_error	=	iole_factory.GetLastError()
			MessageBox ("Stars Server Logon Error", ls_error, StopSign!)
			Return	-1
		END IF
	//	GaryR	10/23/01	Stars 5.0.0 - Begin
	ELSEIF	This.of_is_multiple_logon (ls_error)		THEN
		li_rc	=	MessageBox ('Sign On Error', "You have reached the maximum login attempts for Stars and are locked out.~n~r" + &
															"Please contact your User Administrator.", StopSign! )
		HALT CLOSE
	//	GaryR	10/23/01	Stars 5.0.0 - End
	//	GaryR	11/05/01	Stars 5.0.0 - Begin
	ELSEIF	This.of_is_password_expired (ls_error)		THEN
		li_rc	=	MessageBox ('Sign On Message', ls_error + "~n~r~n~rWould you like to change your password?", Exclamation!, YesNo! )
		IF li_rc = 2 THEN Return -999
		OpenWithParm( w_change_password, is_server_userid )
		li_rc = Message.DoubleParm
		SetNull( Message.DoubleParm )
		
		IF li_rc <> 1 THEN Return -999
	//	GaryR	11/05/01	Stars 5.0.0 - End
	ELSE
		MessageBox ("Stars Server Logon Error", ls_error, StopSign!)
		Return	-1
	END IF
END IF

Return	1
end function

public function integer of_decrypt_string (ref string as_string);//*********************************************************
//	Script:	of_decrypt_string
//
//	Arguments:
//		as_string (Reference) - String to decrypt
//
//	Returns:
//		Integer:	1=successful, -1=error
//
//	Description:
//		This function will decrypt the argument string.
//		
//
//*********************************************************

Char	lc_from[],		&
		lc_to[]
		
Integer	li_ctr,			&
			li_max,			&
			li_ascii,		&
			li_encrypt

IF	IsNull (as_string)		THEN
	Return -1
END IF

lc_from		=	as_string

li_max	=	UpperBound (lc_from)

FOR li_ctr	=	1	TO	li_max
	// Change the encryption for even characters
	IF	li_ctr	=	2		&
	OR	li_ctr	=	4		&
	OR	li_ctr	=	6		THEN
		li_encrypt	=	ii_encrypt	*	2
	ELSE
		li_encrypt	=	ii_encrypt
	END IF
	li_ascii	=	Asc ( lc_from[li_ctr] )
	li_ascii	=	li_ascii	-	li_encrypt
	lc_to [li_ctr]	=	Char (li_ascii)
NEXT

as_string	=	lc_to

Return 1

end function

public function boolean of_is_filter_name (string as_value);//============================================================================================//
//	Object		n_cst_appmanager
// Function		of_is_filter_name
//	Arguments	(String) Filter Name
//	Returns		(Boolean) TRUE if filter
//	Description	Determines if the string passed in is a filter (begins with '@')
//============================================================================================//
// Maintenance
// -------- -----	--------	-------------------------------------------------------------------
// 10/10/03 MikeF	SPR2989d	Created function
//	05/18/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//============================================================================================//

as_value = Trim( as_value )
IF	len(as_value) > 0 AND left(as_value,1) = '@' THEN RETURN TRUE

RETURN FALSE
end function

public function string of_get_filter_type (string as_filter_name);//============================================================================================//
//	Object		n_cst_appmanager
// Function		of_get_filter_type
//	Arguments	(String) Filter Name
//	Returns		(String) The data type of the filter or ERROR if not found
//	Description	This function will return the data type of a filter name
//============================================================================================//
// Maintenance
// -------- -----	-----------	------------------------------------------------------------------
// 10/10/03 MikeF	Track 2989d	Created function
//	02/22/06	GaryR	Track 4666	Check the delete indicator
//============================================================================================//

constant string err = "ERROR"
String	ls_type

// Check if @ is present
IF This.of_is_filter_name( as_filter_name ) THEN
	as_filter_name = mid(as_filter_name,2)
END IF

as_filter_name = trim(as_filter_name)

// Retrieve filter type
SELECT FILTER_DATA_TYPE
INTO :ls_type
FROM FILTER_CNTL
WHERE FILTER_ID = :as_filter_name
AND DELETE_IND <> 'Y'
USING Stars2ca;

// Check status
IF Stars2ca.of_check_status() < 0 THEN RETURN err

// Check value
IF IsNull( ls_type ) OR Trim( ls_type ) = "" THEN RETURN err

RETURN ls_type
end function

public subroutine of_set_lock (boolean ab_lock);//////////////////////////////////////////////////////////////////////////
//
//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
//	12/27/04	GaryR	Track 3971d	Check if user is client admin prior to enabling
// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access
//	10/27/08	GaryR	SPR 5531	Modernize the STARS Frame Menu and Toolbar
//
//////////////////////////////////////////////////////////////////////////

Boolean lb_switch

ib_lock = ab_lock
lb_switch = NOT ab_lock

//	Disable/enable menu items
m_stars_30.m_file.m_print.Enabled = lb_switch
m_stars_30.m_file.m_print.m_report.Enabled = lb_switch
m_stars_30.m_file.m_printersetup.Enabled = lb_switch
m_stars_30.m_file.m_printscreen.Enabled = lb_switch
m_stars_30.m_file.m_printpreview.Enabled = lb_switch
m_stars_30.m_file.m_fax.Enabled = lb_switch
m_stars_30.m_file.m_windowsapps.Enabled = lb_switch
m_stars_30.m_file.m_save.Enabled = lb_switch
m_stars_30.m_file.m_export.Enabled = lb_switch
m_stars_30.m_file.m_star.Enabled = lb_switch
m_stars_30.m_file.m_showsql.Enabled = lb_switch
m_stars_30.m_file.m_changepassword.Enabled = lb_switch
m_stars_30.m_file.m_closeall.Enabled = lb_switch
m_stars_30.m_file.m_exit.Enabled = lb_switch
m_stars_30.m_edit.Enabled = lb_switch
m_stars_30.m_analysis.Enabled = lb_switch
m_stars_30.m_analysis.m_queryengine.Enabled = lb_switch
m_stars_30.m_analysis.m_summaryanalysis.Enabled = lb_switch
m_stars_30.m_analysis.m_subsetlist.Enabled = lb_switch
m_stars_30.m_reporting.Enabled = lb_switch
m_stars_30.m_reporting.m_normanalysis.Enabled = lb_switch
m_stars_30.m_reporting.m_ratioreports.Enabled = lb_switch
m_stars_30.m_reporting.m_baselinereports.Enabled = lb_switch
m_stars_30.m_reporting.m_caseinventoryreports.Enabled = lb_switch
m_stars_30.m_reporting.m_userreportlist.Enabled = lb_switch
m_stars_30.m_case.Enabled = lb_switch
m_stars_30.m_case.m_casefolder.Enabled = lb_switch
m_stars_30.m_case.m_listcases.Enabled = lb_switch
m_stars_30.m_case.m_caseadd.Enabled = lb_switch
m_stars_30.m_case.m_casedetails.Enabled = lb_switch
m_stars_30.m_case.m_activecase.Enabled = lb_switch
m_stars_30.m_case.m_listtrackingentries.Enabled = lb_switch
m_stars_30.m_case.m_target.m_listtargetlists.Enabled = lb_switch
m_stars_30.m_case.m_notes.m_listnotes.Enabled = lb_switch
m_stars_30.m_case.m_leads.m_list1.Enabled = lb_switch
m_stars_30.m_interfaces.Enabled = lb_switch
m_stars_30.m_interfaces.m_jobstatus.Enabled = lb_switch
m_stars_30.m_interfaces.m_displayusermessages.Enabled = lb_switch
m_stars_30.m_lookup.Enabled = lb_switch
m_stars_30.m_lookup.m_lookupcode.Enabled = lb_switch
m_stars_30.m_lookup.m_lookupproviders.Enabled = lb_switch
m_stars_30.m_lookup.m_lookupenrollee.Enabled = lb_switch
m_stars_30.m_lookup.m_lookupproceduretimes.Enabled = lb_switch
m_stars_30.m_lookup.m_lookupclaimspaymentrange.Enabled = lb_switch
m_stars_30.m_window.Enabled = lb_switch
m_stars_30.m_help.Enabled = lb_switch
m_stars_30.m_help.m_starshelp.Enabled = lb_switch

IF ab_lock THEN
	m_stars_30.m_admin.Enabled = FALSE
ELSE
	IF gv_user_sl = 'AD' THEN m_stars_30.m_admin.Enabled = TRUE
END IF
end subroutine

public function boolean of_get_lock ();//	07/13/04	GaryR	Track 3971d	Lock all functionality during retrieval
Return ib_lock
end function

public subroutine of_set_idle_time (long al_idle_minutes);//************************************************************************
//	
//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
//	05/20/02	GaryR	Track 3073d	PB7 memory corruption on Idle()
//	04/13/04	GaryR	Track 6717c	Use Idle with PB9 to prevent double logon
//	10/14/04	GaryR	Track 3699d	Accomodate COM changes for UserAdmin
//
//************************************************************************

// Get idle seconds
il_idle_sec = al_idle_minutes * 60

IF IsNull( il_idle_sec ) OR il_idle_sec < 0 THEN
	MessageBox ( 'Value Error', 'Idle will default to 20 minutes for current session', Exclamation! )
	il_idle_sec = 1200			//	05/20/02	GaryR	Track 3073d
END IF

Idle (il_idle_sec)
end subroutine

public function string of_get_build ();//************************************************************
//	Script	: of_get_build
//	Arguments: None
//	Returns	: String: The version + build
//-------------------------------------------------------------
//	Returns the Build (Defined in the stars constructor event) 
// + the Build (instance variable ics_build)
//-------------------------------------------------------------
//
// 01/19/05 MikeF SPR 4228d Created
//	12/19/08	GaryR	Track 5617	Streamline automated build process
//
//************************************************************

Return	is_version + "." + ics_build

end function

public function boolean of_is_password_expired (ref string as_message);//************************************************************
//	Script:	of_is_password_expired
//
//	Arguments:	as_message - The message returned from Stars Server
//
//	Returns:		Boolean
//					TRUE	=	Stars Server password is expired
//					FALSE	=	Stars Server password is not expired
//
//	Description:
//			This function is called by of_logon_and_change_password().  
//			This function will determine if the Stars Server password is expired.
//			This is determined by deciphering the text of the message.
//
//************************************************************
//
//	GayrR	11/05/01	Stars 5.0.0	Created.
//	GaryR	02/16/04	Track 4296d	Display password expiration message from the server
//
//************************************************************

Integer	li_pos
Boolean	lb_rtn

li_pos = Pos( Upper( as_message ), 'YOUR PASSWORD HAS EXPIRED' )
IF li_pos > 0 THEN
	as_message = Mid( as_message, li_pos )
	lb_rtn = TRUE
END IF

Return lb_rtn
end function

public subroutine of_npi_cntl ();///////////////////////////////////////////////////////////////////
//
//n_cst_appmanager::of_npi_cntl()
//	checks sys_cntl for prov_cntl entry
//		0 - no changes
//		1 - NPI Fields have been added
//		2 - NPI Fields are replacing PROV_ID
//
///////////////////////////////////////////////////////////////////
//
//	11/09/06 Katie Created
//
///////////////////////////////////////////////////////////////////

integer li_rc, li_npi_cntl

select cntl_no
into :li_npi_cntl
from sys_cntl
where cntl_id = 'NPI_CNTL'
USING STARS2CA;

li_rc = stars2ca.of_check_status()

if li_rc <> 0 then
	gv_npi_cntl = 0
else
	gv_npi_cntl = li_npi_cntl
end if
end subroutine

public function string of_get_server_url ();//	04/25/07	GaryR	Track 5001	Launch Release Notes on the server

String	ls_server_name, ls_url
Integer	li_posstart, li_posstop

ls_server_name = This.of_get_server_name()

li_posstart = pos(ls_server_name, '://')
li_posstop = pos(ls_server_name, '/', li_posstart + 3)

IF li_posstop <> 0 THEN
	ls_url = left(ls_server_name, li_posstop - 1)
ELSE
	ls_url = ls_server_name
END IF

IF li_posstart = 0 THEN
	ls_url = 'http://' + ls_url
END IF

Return ls_url
end function

public subroutine of_set_colors ();//*********************************************************************************
// Script Name:	of_set_colors
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Initialize the global color structure with 
//						Section 508 compliant colors.
//
//*********************************************************************************
//
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//	05/25/09	GaryR	GNL.600.5633.007	Set protected background color to ButtonFace
//	10/20/09	GaryR	ACC.650.5786.001	Provide alternative color scheme
//													for lookup and indexed fields
//
//*********************************************************************************
debugbreak()
// Map colors to standard Windows OS schemes
stars_colors.window_background = 1073741824
stars_colors.window_text = 33554432
stars_colors.application_workspace = 276856960
stars_colors.button_face = 67108864
stars_colors.scroll_bar = 134217728
stars_colors.desktop = 134217729
stars_colors.active_title_bar = 134217730
stars_colors.inactive_title_bar = 134217731
stars_colors.menu_bar = 134217732
stars_colors.window_frame = 134217734
stars_colors.menu_text = 134217735
stars_colors.active_title_bar_text = 134217737
stars_colors.active_border = 134217738
stars_colors.inactive_border = 134217739
stars_colors.highlight = 134217741
stars_colors.highlight_text = 134217742
stars_colors.button_shadow = 134217744
stars_colors.disabled_text = 134217745
stars_colors.button_text = 134217746
stars_colors.inactive_title_bar_text = 134217747
stars_colors.button_highlight = 134217748
stars_colors.button_dark_shadow = 134217749
stars_colors.button_light_shadow = 134217750
stars_colors.tooltip_text = 134217751
stars_colors.tooltip = 134217752
stars_colors.link = 134217756
stars_colors.link_hover = 134217757
stars_colors.link_active = 134217758
stars_colors.link_visited = 134217759
stars_colors.transparent = 536870912

// Set color globals to standard defaults (similar to MS Office)		
stars_colors.label_back			=	stars_colors.button_face
stars_colors.label_text			=	stars_colors.highlight
stars_colors.input_back			=	stars_colors.window_background
stars_colors.input_text			=	stars_colors.window_text
stars_colors.lookup_back		=	stars_colors.inactive_title_bar
stars_colors.lookup_text		=	stars_colors.inactive_title_bar_text
stars_colors.index_back			=	stars_colors.button_shadow
stars_colors.index_text			=	stars_colors.highlight_text
stars_colors.protected_back	=	stars_colors.button_face
stars_colors.protected_text	=	stars_colors.window_text
stars_colors.datawindow_back	=	stars_colors.window_background
end subroutine

public function integer of_set_yellow_lookup (boolean ab_switch);//********************************************************************************
//	Script:	n_cst_appmanager::of_set_yellow_lookup
//
//	Arguments:	ab_switch 
//						TRUE - Enable yellow color scheme
//						FALSE - Enable Section 508 compliant color scheme
//			
//	Returns	-	1 = Success; -1 = Failure
//
//	Description:
//			Allows the user to override the defualt Section 508 compliant
//			color scheme and eable the traditional color scheme with 
//			yellow background for lookup and index fields only.
//
//********************************************************************************
//
///	10/20/09	GaryR	ACC.650.5786.001	Provide alternative color scheme
//													for lookup and indexed fields
//
//********************************************************************************

String	ls_user_ini
Integer	li_rc, li_fileNumber

ls_user_ini = This.of_get_user_ini_file()
IF IsNull( ls_user_ini ) OR Trim( ls_user_ini ) = "" THEN
	MessageBox( "Setting Error", "Unable to locate the STARS user initialization file.", StopSign! )
	Return -1
END IF

m_stars_30.m_window.m_yellowlookups.checked	=	ab_switch

IF	ab_switch THEN
	li_rc	=	SetProfileString (ls_user_ini, 'COLORS', 'EnableYellow', '1')
	stars_colors.lookup_text	=	0								// Black
	stars_colors.lookup_back	=	RGB (255, 255, 0)			// Yellow
	stars_colors.index_text		=	0								// Black
	stars_colors.index_back		=	RGB (255, 255, 0)			// Yellow
ELSE
	li_rc	=	SetProfileString (ls_user_ini, 'COLORS', 'EnableYellow', '0')
	This.of_set_colors()
END IF

IF li_rc <> 1 THEN
	MessageBox( "Setting Error", "Unable to write to the STARS user initialization file at: " + &
								ls_user_ini, StopSign! )
	Return -1
END IF

Return 1
end function

on n_cst_appmanager.create
call super::create
end on

on n_cst_appmanager.destroy
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Constructor
//
//	Description:	
//			Below is a template of services that can be used in
//			the descendant script.
//
//////////////////////////////////////////////////////////////////////////////
//
//	FDG	02/19/01	Stars 4.7 - Create iole_factory
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//////////////////////////////////////////////////////////////////////////////

//	Set the resize to null so it will attempt to get the resize data from
//	the user's ini file.
SetNull (ib_resize)

//	initialize the colors
This.of_set_colors()
end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Destructor
//
//	Description:	
//			Destroy any objects created from the constructor.
//
//////////////////////////////////////////////////////////////////////////////
//
//	FDG	02/19/01	Stars 4.7 - Destroy iole_factory
//
//
//////////////////////////////////////////////////////////////////////////////

IF	IsValid (iole_factory)	THEN
	Destroy	iole_factory
END IF


end event

