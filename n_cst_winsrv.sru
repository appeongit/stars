HA$PBExportHeader$n_cst_winsrv.sru
$PBExportComments$PFC Base Window service (inherited from n_base) <logic>
forward
global type n_cst_winsrv from n_base
end type
end forward

global type n_cst_winsrv from n_base
end type
global n_cst_winsrv n_cst_winsrv

type variables
Protected:
w_master		iw_requestor

// The user's ini file name
Protected		String	is_userinifile

// The STARS ini file name
Protected		String	is_inifile

// The STARS help file name
Protected		String	is_helpfile

end variables

forward prototypes
public function integer of_center ()
public function integer of_setrequestor (w_master aw_requestor)
public function string of_getuserinifile ()
public function string of_getinifile ()
public function string of_gethelpfile ()
end prototypes

public function integer of_center ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Center
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Centers the window relative to the dimensions of the
//	current display resolution.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_screenheight
Integer		li_screenwidth
Integer		li_width
Integer		li_height
Integer		li_rc
Integer		li_x = 1
Integer		li_y = 1
environment	lenv_obj

li_width		=	iw_requestor.Width
li_height	=	iw_requestor.Height

//Check for a window association with this object
If IsNull(iw_requestor) Or Not IsValid (iw_requestor) Then
	Return -1
End If

// Get environment
If GetEnvironment (lenv_obj) = -1 Then
	Return -1
End If

// Determine current screen resolution and validate
//li_screenheight = PixelsToUnits (lenv_obj.screenheight, YPixelsToUnits!)
//li_screenwidth = PixelsToUnits (lenv_obj.screenwidth, XPixelsToUnits!)
//If Not (li_screenheight > 0) or Not (li_screenwidth > 0) Then
//	Return -1
//End If

// Get the height and width of the frame's workspace area

IF	IsValid (w_main)		THEN
	li_x					=	w_main.x	+	w_main.WorkSpaceX()	+	40			// Default X
	li_y					=	w_main.y	+	w_main.WorkspaceY()	+	160		// Default Y
	li_screenheight	=	w_main.WorkSpaceHeight()
	li_screenwidth		=	w_main.WorkSpaceWidth()
ELSE
	li_screenheight	=	PixelsToUnits (lenv_obj.screenheight, YPixelsToUnits!)
	li_screenwidth		=	PixelsToUnits (lenv_obj.screenwidth, XPixelsToUnits!)
END IF

IF	li_screenheight	<=	0		&
OR	li_screenwidth		<=	0		THEN
	Return	-1
END IF

// Get center points

If li_screenwidth	>	li_Width Then
	li_x	=	li_x	+	(li_screenwidth / 2) - (li_Width / 2)
End If

If li_screenheight >	li_Height Then
	li_y	=	li_y	+	(li_screenheight / 2) - (li_height / 2)
End If

// Center window
li_rc = iw_requestor.Move (li_x, li_y)
If li_rc <> 1 Then
	Return -1
End If

Return 1
end function

public function integer of_setrequestor (w_master aw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetRequestor
//
//	Access:  		public
//
//	Arguments:		
//	aw_requestor	The window requesting this service
//
//	Returns:  		Integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Associates a window with this service.
//
//////////////////////////////////////////////////////////////////////////////

If IsNull(aw_requestor) Or Not IsValid(aw_requestor) Then
	Return -1
End If

iw_requestor = aw_requestor
Return 1
end function

public function string of_getuserinifile ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getuserinifile
//
//	Access:  		public
//
//	Arguments:		N/A
//
//	Returns:  		String
//						The name of the user's ini file
//						
//	Description:  	Get the user's ini file.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_path

IF	Trim (is_userinifile)	<	' '	THEN
	ls_path	=	ProfileString ( This.of_getinifile(), 'carrier', 'UserINIPath', '')
	is_userinifile	=	ls_path	+	gc_user_id	+	'.INI'
END IF

Return is_userinifile
end function

public function string of_getinifile ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getinifile
//
//	Access:  		public
//
//	Arguments:		N/A
//
//	Returns:  		String
//						The name of the STARS ini file
//						
//	Description:  	Get the STARS ini file name.
//
//////////////////////////////////////////////////////////////////////////////

IF	Trim (is_inifile)		<	' '		THEN
	is_inifile		=	gv_ini_path		+	'STARS.INI'
END IF

Return is_inifile
end function

public function string of_gethelpfile ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_gethelpfile
//
//	Access:  		public
//
//	Arguments:		N/A
//
//	Returns:  		String
//						The name of the STARS help file
//						
//	Description:  	Get the STARS help file.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_path

IF	Trim (is_helpfile)	<	' '	THEN
	ls_path	=	ProfileString ( This.of_getinifile(), 'carrier', 'HelpPath', '')
	is_helpfile	=	ls_path	+	'starshlp.hlp'
END IF

Return is_helpfile
end function

on n_cst_winsrv.create
TriggerEvent( this, "constructor" )
end on

on n_cst_winsrv.destroy
TriggerEvent( this, "destructor" )
end on

