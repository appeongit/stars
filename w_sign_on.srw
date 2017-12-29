HA$PBExportHeader$w_sign_on.srw
$PBExportComments$Inherited from w_master
forward
global type w_sign_on from w_master
end type
type st_9 from statictext within w_sign_on
end type
type st_6 from statictext within w_sign_on
end type
type st_4 from statictext within w_sign_on
end type
type st_3 from statictext within w_sign_on
end type
type st_1 from statictext within w_sign_on
end type
type st_version from statictext within w_sign_on
end type
type sle_password from singlelineedit within w_sign_on
end type
type sle_user_id from singlelineedit within w_sign_on
end type
type st_8 from statictext within w_sign_on
end type
type st_7 from statictext within w_sign_on
end type
type st_5 from statictext within w_sign_on
end type
type cb_cancel from u_cb within w_sign_on
end type
type cb_ok from u_cb within w_sign_on
end type
type st_2 from statictext within w_sign_on
end type
type cb_reconnect from u_cb within w_sign_on
end type
type cb_exit from u_cb within w_sign_on
end type
type p_3 from picture within w_sign_on
end type
type p_1 from picture within w_sign_on
end type
end forward

global type w_sign_on from w_master
string accessiblename = "Welcome To STARS"
string accessibledescription = "Welcome To STARS"
integer x = 1627
integer y = 752
integer width = 2793
integer height = 1636
string title = "Welcome To STARS"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
event type boolean ue_edit_pc_date ( )
st_9 st_9
st_6 st_6
st_4 st_4
st_3 st_3
st_1 st_1
st_version st_version
sle_password sle_password
sle_user_id sle_user_id
st_8 st_8
st_7 st_7
st_5 st_5
cb_cancel cb_cancel
cb_ok cb_ok
st_2 st_2
cb_reconnect cb_reconnect
cb_exit cb_exit
p_3 p_3
p_1 p_1
end type
global w_sign_on w_sign_on

type variables


end variables

forward prototypes
public function integer wf_disable ()
public subroutine wf_get_last_login (string as_user_id)
end prototypes

event ue_edit_pc_date;// Compare the PC Date with the server date
// FDG 01/15/99 begin

Boolean	lb_valid
n_cst_datetime		lnv_datetime

lb_valid	=	lnv_datetime.of_IsValidPCDate()

Return	lb_valid

end event

public function integer wf_disable ();//*************************************************************************

// HRB 12/14/94 Disable Menu Items in WinParm
//
// Reads the STARS_WIN_PARM for the following:
// Win_ID  = 'MENU'
// Sys_ID  = :gv_sys_dflt
// Cntl_ID = 'DISABLE' or 'HIDE'
// Label   = menu item
//
// The Label contains the menu item, with each of its levels delimited by a
// '/'. For example: to disable the Print Item under the File Menu, the Label
// would be '&File/&Print'.  The item must be entered exactly as it is on the
// menu, including the '&', used for underlining.
//
// Also note, when entering items into the WinParm table, the Cntl_Type must
// be filled with a number, preferably in sequence with the others, to make the
// key non-duplicate.
//
// Once the WinParm is read, the Menu name is passed to fx_disable_menu_item,
// which searches the menu and disables or hides the item, depending on what
// is in Cntl_ID.  The function returns an error code (-1) if it cannot find
// the item.  This is used to give the user a warning messagebox.


string lv_cntl_id,lv_menu_string, lv_menu[], lv_clear_array[]
int i,lv_pos,lv_rc
string lv_where_message

DECLARE get_menu CURSOR FOR
	SELECT cntl_id,label
	FROM Stars_Win_Parm
	WHERE win_id = 'MENU'
	AND sys_id = Upper( :gv_sys_dflt )
	AND (cntl_id = 'DISABLE'
	OR cntl_id = 'HIDE')
	USING Stars2ca;

OPEN get_menu;
if Stars2ca.of_check_status() <> 0 then
	lv_where_message = 'win_id = MENU AND sys_id = ' + gv_sys_dflt + ' AND cntl_id = DISABLE OR cntl_id = HIDE'
	messagebox("SIGN ON - MENU DISABLE ERROR","Error Opening Cursor: " + lv_where_message)
  	return -1
end if
do while Stars2ca.sqlcode = 0
	FETCH get_menu INTO :lv_cntl_id, :lv_menu_string;
	if Stars2ca.of_check_status() = 100 then EXIT
	if Stars2ca.sqlcode <> 0 then
		lv_where_message = 'win_id = MENU AND sys_id = ' + gv_sys_dflt + ' AND cntl_id = DISABLE OR cntl_id = HIDE'
		messagebox("SIGN ON - MENU DISABLE ERROR","Error reading WinParm: " + lv_where_message)
	 	return -1
	end if
   i = 0
	lv_menu[] = lv_clear_array[]
	do while len(lv_menu_string) > 0
		i++
		lv_pos = pos(lv_menu_string,'/')
		if lv_pos = 0 then		
			lv_menu[i] = trim(lv_menu_string)
			lv_menu_string = ''
		else
			lv_menu[i] = trim(left(lv_menu_string,lv_pos - 1))
			lv_menu_string = mid(lv_menu_string,lv_pos + 1)
		end if				
	loop
	lv_rc = fx_disable_menu_item(lv_menu,lv_cntl_id,i)
	if lv_rc = -1 then
		messagebox('MENU WARNING','A menu item under the ' + lv_menu[1] + ' menu' &
		           +' was not disabled.  Please contact your System Administrator for assistance.')
	end if
loop
CLOSE get_menu;
if Stars2ca.of_check_status() <> 0 then
	lv_where_message = 'win_id = MENU AND sys_id = ' + gv_sys_dflt + ' AND cntl_id = DISABLE OR cntl_id = HIDE'
	messagebox("SIGN ON - MENU DISABLE ERROR","Error closing Cursor: " + lv_where_message)
  	return -1
end if

COMMIT Using Stars2ca;							// FDG 10/19/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/19/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/19/95
END IF												// FDG 10/19/95


return 0
end function

public subroutine wf_get_last_login (string as_user_id);//	01/12/05	GaryR	Track 4088d	Display last login timestamp and status

Datetime	ldt_last_login, ldt_init
String	ls_message, ls_status
String	ls_logon = "Logon", ls_invalid_password = "Invalid Password"

as_user_id = Upper( as_user_id )

//	Get the previous date and status
SELECT	log_date, log_desc
INTO		:ldt_last_login, :ls_status
FROM		user_log
WHERE		user_id = :as_user_id
AND		log_desc IN (:ls_logon, :ls_invalid_password)
AND		log_date = (SELECT	max(log_date)
					  		FROM		user_log
					  		WHERE		user_id = :as_user_id
					  		AND		log_desc IN (:ls_logon, :ls_invalid_password)
							AND		log_date < (SELECT	max(log_date)
												  		FROM		user_log
											  			WHERE		user_id = :as_user_id
					  									AND		log_desc IN (:ls_logon, :ls_invalid_password)))
USING	Stars2ca;

IF IsNull( ldt_last_login ) OR ldt_last_login = ldt_init THEN
	ls_message = "Last login unknown"
ELSE
	IF ls_status = ls_logon THEN
		ls_message = "Last login on " + &
			String( ldt_last_login, "mm/dd/yyyy 'at' hh:mm:ss am/pm" ) + " was successful"
	ELSEIF ls_status = ls_invalid_password THEN
		ls_message = "Last login on " + &
			String( ldt_last_login, "mm/dd/yyyy 'at' hh:mm:ss am/pm" ) + " was unsuccessful"
	ELSE
		ls_message = "Last login on " + String( ldt_last_login, "mm/dd/yyyy 'at' hh:mm:ss am/pm" )
	END IF
END IF

//	Set the microhelp with last login date
w_main.POST SetMicroHelp( ls_message )
end subroutine

event open;//***********************************************************************
//	w_sign_on.open	-	Override the ancestor
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 03/07/94 JMS  Modified to provide automatic signon if gc_user_id
//               contains a UserId/PassWord.
// 06/07/94 LKD  Read Sys control to get the default title and version
//               for application 
//	02/20/98	FDG  Center the window
// 04/02/98 JGG  Close the splash screen if it exists
// 10/06/00 GaryR 2315d Conforming STARS to the HIPAA Act
//	03/02/01	FDG	Stars 4.7.  If reconnecting, don't allow a new password.
// 09/19/01	GaryR	Stars 4.7	Eliminate obsolete Stars.ini keys
//	11/05/01	GaryR	Stars 5.0.0	Redesign password expiration at logon.
// 10/28/04 Katie	Track 4069 Redesign log-in screen to change HIPAA and Privacy Messages - Removed default picture
// 01/19/05 MikeF SPR4228d	Change version display
// 04/29/08 RickB SPR 5335  Commented the code that closes w_splash; letting the timer do it.
// 05/05/08 RickB SPR 5335  Removed the code that was commented on 4/29.
//***********************************************************************

Long slash_pos
String	ls_bitmap

/*ls_bitmap = ProfileString( gv_ini_path + "STARS.INI", "carrier", "bitmap", 'star31b.bmp' ) 
IF FileExists( ls_bitmap ) THEN p_1.PictureName =  ls_bitmap*/

// Check if this is a new connection
// or a time out reconnection
IF Message.DoubleParm = -2 THEN
	SetNull( Message.DoubleParm )
	st_2.Visible = TRUE
	sle_user_id.Text = gc_user_id
	sle_user_id.Enabled = FALSE	
	cb_reconnect.Visible = TRUE
	cb_reconnect.Default = TRUE
	cb_reconnect.TabOrder = 40	
	cb_exit.Visible = TRUE
	cb_exit.TabOrder = 50
	sle_password.SetFocus()
	cb_ok.Enabled = FALSE
	cb_cancel.Enabled = FALSE
	// FDG 03/02/01 - Don't allow a new password when reconnecting
	//sle_new_password.enabled	=	FALSE		//	GaryR	11/05/01	Stars 5.0.0
	THIS.Title = "Reconnect To STARS"	
ELSE
	// 09/19/01	GaryR	Stars 4.7 - Begin
//	in_open_case = message.stringparm
//	//KMM Clear out message parm (PB Bug)
//	SetNull(message.stringparm)
	// 09/19/01	GaryR	Stars 4.7 - End
	
	// JGG 04/02/98 - Close splash screen
	
	st_version.text = gnv_app.of_get_build()
	
	//	FDG 02/20/98	Begin
	IF	ib_disablecenter	=	FALSE			&
	AND NOT	IsValid (inv_resize)			THEN
	This.of_SetBase (TRUE)			//	Enable the base window service
	inv_base.of_center()
	END IF
	//	FDG 02/20/98	End
	
	if (gc_user_id <> '') then
	slash_pos = Pos(gc_user_id,'/')
	if (slash_pos <> 0) then
		sle_user_id.text 	= Mid(gc_user_id,1,slash_pos - 1)
		sle_password.text	= Mid(gc_user_id,slash_pos   + 1)
	else
		sle_user_id.text	= gc_user_id
		sle_password.text	= ''
	end if
	gc_user_id  		   = ''
	if (sle_user_id.text <> '') and (sle_password.text <> '') then PostEvent(cb_ok,Clicked!)
	end if
	
END IF
end event

event close;call super::close;w_main.SetMicroHelp("Ready")
end event

on w_sign_on.create
int iCurrent
call super::create
this.st_9=create st_9
this.st_6=create st_6
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.st_version=create st_version
this.sle_password=create sle_password
this.sle_user_id=create sle_user_id
this.st_8=create st_8
this.st_7=create st_7
this.st_5=create st_5
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_2=create st_2
this.cb_reconnect=create cb_reconnect
this.cb_exit=create cb_exit
this.p_3=create p_3
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_9
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_version
this.Control[iCurrent+7]=this.sle_password
this.Control[iCurrent+8]=this.sle_user_id
this.Control[iCurrent+9]=this.st_8
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.cb_cancel
this.Control[iCurrent+13]=this.cb_ok
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.cb_reconnect
this.Control[iCurrent+16]=this.cb_exit
this.Control[iCurrent+17]=this.p_3
this.Control[iCurrent+18]=this.p_1
end on

on w_sign_on.destroy
call super::destroy
destroy(this.st_9)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_version)
destroy(this.sle_password)
destroy(this.sle_user_id)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.cb_reconnect)
destroy(this.cb_exit)
destroy(this.p_3)
destroy(this.p_1)
end on

type st_9 from statictext within w_sign_on
string accessiblename = "ViPS Copyright Statement"
string accessibledescription = "ViPS Copyright Statement"
accessiblerole accessiblerole = statictextrole!
integer y = 1252
integer width = 2766
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "obtained only pursuant to a signed, written license agreement between ViPS, Inc. and your employer."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_sign_on
string accessiblename = "ViPS Copyright Statement"
string accessibledescription = "ViPS Copyright Statement"
accessiblerole accessiblerole = statictextrole!
integer y = 1196
integer width = 2766
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "consent of ViPS, Inc. is strictly prohibited. This system is for authorized users only; authorization may be "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_sign_on
string accessiblename = "ViPS Copyright Statement"
string accessibledescription = "ViPS Copyright Statement"
accessiblerole accessiblerole = statictextrole!
integer y = 1140
integer width = 2766
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "contained in this software application (or any part thereof) and use of the STARS mark, without express written "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_sign_on
string accessiblename = "ViPS Copyright Statement"
string accessibledescription = "ViPS Copyright Statement"
accessiblerole accessiblerole = statictextrole!
integer y = 1084
integer width = 2766
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "contains confidential, proprietary information belonging to ViPS, Inc. Use or disclosure of the information "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_sign_on
string accessiblename = "ViPS Copyright Statement"
string accessibledescription = "ViPS Copyright Statement"
accessiblerole accessiblerole = statictextrole!
integer y = 1028
integer width = 2766
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Copyright 2009 ViPS, Inc. All Rights Reserved. STARS is a registered trademark of ViPS, Inc. This material "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_sign_on
string accessiblename = "STARS Version"
string accessibledescription = "STARS Version"
accessiblerole accessiblerole = statictextrole!
integer x = 2171
integer y = 1320
integer width = 581
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
end type

type sle_password from singlelineedit within w_sign_on
string tag = "Enter your PASSWORD ..."
string accessiblename = "Enter your Password"
string accessibledescription = "Password"
accessiblerole accessiblerole = textrole!
integer x = 1038
integer y = 916
integer width = 498
integer height = 80
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;SETMICROHELP (W_MAIN, THIS.TAG)
THIS.SelectText( 1, Len( THIS.Text ) )	//Gary-R 09/27/2000
end event

type sle_user_id from singlelineedit within w_sign_on
string tag = "Enter your USERID ..."
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = textrole!
integer x = 1038
integer y = 816
integer width = 498
integer height = 80
integer taborder = 10
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event getfocus;SETMICROHELP (W_MAIN, THIS.TAG)
THIS.SelectText( 1, Len( THIS.Text ) )	//Gary-R 09/27/2000

end event

type st_8 from statictext within w_sign_on
string accessiblename = "Password"
string accessibledescription = "Password"
accessiblerole accessiblerole = statictextrole!
integer x = 681
integer y = 920
integer width = 325
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Password:"
alignment alignment = right!
end type

type st_7 from statictext within w_sign_on
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = statictextrole!
integer x = 695
integer y = 824
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "User ID:"
alignment alignment = right!
end type

type st_5 from statictext within w_sign_on
string accessiblename = "System Sign On Information "
string accessibledescription = "System Sign On Information "
accessiblerole accessiblerole = statictextrole!
integer x = 855
integer y = 728
integer width = 896
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "System Sign On Information "
alignment alignment = center!
end type

type cb_cancel from u_cb within w_sign_on
string tag = "Exit the System"
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 1577
integer y = 916
integer height = 80
integer taborder = 50
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Cancel"
end type

on clicked;//HALT CLOSE
close(parent)
close(w_main)
end on

on getfocus;setmicrohelp (w_main, this.tag)
end on

type cb_ok from u_cb within w_sign_on
string tag = "Accept Userid and Password ...."
string accessiblename = "Login"
string accessibledescription = "Login"
integer x = 1577
integer y = 816
integer height = 80
integer taborder = 40
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Login"
boolean default = true
end type

event clicked;//                   ***SCRIPT FOR CLICKED CB_OK OF W_SIGN_ON***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 12/22/97 JGG	Replace users table columns last_case with active_case
//             	last_subset with active_subset_name.
//	03/05/98	FDG	Stars 4.0 - Track 904.  Update PDQUERY & RPTTEMPL in
//						sys_cntl.
// 03/11/98 AJS	Add code to set active subset id
// 08/26/98 FNC	Track 1302 & 1577. Change update to sys_cntl for PDQUERY to 
//						PDQ_TMP_ID and remove update in sys_cntl for RPTTEMPL. 
//						The template and query id's have been combined into one.
// 08/31/98 AJS	FS362 convert case to case_cntl
// 12-10-98 AJS	STARDEV 2027 Y2K - remove hardcoded century
//	01/15/99	FDG	Track 2041c.  Compare the PC date to the server date.
//	08-09-99	NLG	FS2363c Compare version set in app:open() with version 
//						stored in sys_cntl
// 10-05-99 NLG	Back out the 8-9-99 change. Would have forced a sys_cntl
//						update for every new executable
// 11/18/99 FNC	Call event in w_main to set up timer max instance variable.
// 02/03/00 FNC	 Fraud PDQs - Connect to new transaction by the
//						timer even to check if user has messages on the user
//						message table Fraud PDQs - 
//	12/04/00	FDG	1.	Stars 4.7 - Call gnv_sql function for invalid connection
//							SQLDBCode to make the App DBMS-independent. 
//						2.	If connecting to ASE, the User ID and password on this
//							window is used to connect to the d/b.  With the other
//							DBMSs, the user ID and password must be edited against
//							the users table.
//						3. Remove references to ut_elig_recips
// 12/13/00	GaryR	Stars 4.7 DataBase Port - Date Conversion
//	01/08/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 02/20/01	FDG	Stars 4.7.  
//						1. Use of_connect() in case an alter session command is needed
//						2. Connect to Stars Server before connecting to the database
// 01/16/01	JFS	Stars 4.6 - PIMR.  Enable menu option 'Create PIMR File' 
//						if USEPIMR = 1
//	04/23/01	FDG	Stars 4.7.	Compare the software version against the database
//						version.  The software version is set in the Application's
//						open event.
//	06/14/01	GaryR	Stars 4.7	Redesign password expiration logic
//	08/02/01	GaryR	Track 2391d	obsolete table and view USER_TEMP_ELIG_MEMBERS
//	09/05/01	GaryR	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
// 09/19/01	GaryR	Stars 4.7	Eliminate obsolete Stars.ini keys
//	10/19/01	FDG	Stars 4.8.1.	Don't open w_alert if case is closed.
//	11/05/01	GaryR	Stars 5.0.0	Redesign password expiration at logon.
//	02/20/02 FDG	Track 2830d. If cannot connect to Stars1ca, get out.
// 06/18/02 JasonS Track 3063d  Change case status to RC on referral
// 08/16/02 JasonS Track 3098d  Turn on idle after connecting to stars server
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
// 09/21/04 Katie Track 3699d Removed references to User_s2 - s9, User_prod_code and user_pw
//	10/14/04	GaryR	Track 3699d	Accomodate COM changes for UserAdmin
//	12/09/04	Katie	Track 4113d Changed password expiration message to pop-up based on 
//					clientinfo.il_days_to_expire as passed by the server rather than li_passwarn.
//	12/17/04	GaryR	Track 4142d	Identify individual user sessions in the database
//	01/04/05	GaryR	Track 5651c	Trim active case
//	01/12/05	GaryR	Track 4088d	Display last login timestamp and status
//	11/07/06	GaryR	Track	4821	Remove obsolete global variables
// 11/09/06	Katie	SPR 4849d Added call to n_cst_appmgr.of_prov_cntl()
//										to support new NPI functionality.
//	12/07/07	GaryR	SPR 5213	Dynamic Login Disclaimer
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//	10/20/09	GaryR	ACC.650.5786.001	Provide alternative color scheme
//													for lookup and indexed fields
//
//***********************************************************************

STRING test_id, test_pw, holduid, holdpw
STRING lv_new_pw,	ls_userinifile
string lv_sys_month, lv_sys_year, lv_cntl_month, lv_cntl_year
string lv_month,stri,sqldbmsg
date lv_sys_date,lv_cntl_date
datetime ldte_getdate
boolean UpdateCntl
String lv_user_s1
long lv_cntl_no
INT u_button,sqldbrc
string name,label,lookup
String lv_case_disp_hold,lv_case_status
String lv_case_id,lv_case_spl,lv_case_ver
Boolean lv_invalid_case 
String lv_dflt_month,lv_claim_table
int lv_rc, li_rc
int lv_alert_days             // SG Nov 94
int li_future_count, li_disclaimer
date lv_date_plus_alert_days  // SG Nov 94
int lv_alert_count            // SG Nov 94
string ls_model
datetime ld_max_date
string ls_active_case				//ajs 4.0 02-11-98 TS-Global case id, subset id,name,case 
long ll_rows
integer li_next_model
Integer	li_pimr_sw				// JFS 01/16/01
DateTime	ldt_where				// 12/13/00	GaryR	Stars 4.7 DataBase Port
Long		ll_rc						// FDG 02/20/01
String	ls_microhelp			// FDG 02/20/01
String	ls_empty					// FDG 04/16/01
String	ls_sql
Integer	li_passwarn				//	06/14/01	GaryR	Stars 4.7

sx_subset_ids lstr_subset_ids
nvo_subset_functions lnv_subset_functions

// FDG 02/20/01 - Save text of Microhelp
ls_microhelp	=	'Attempting to sign on ' + sle_user_id.text + '...'

w_main.SetMicroHelp ( ls_microhelp )
SetPointer ( Hourglass! )

test_id 		= trim(sle_user_id.TEXT)
test_pw 		= trim(sle_password.TEXT)

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

IF test_id = ''  OR test_id = ' ' THEN
	setfocus(sle_user_id)
	MessageBox ( 'Sign On Error','You must enter your USER ID to proceed!', StopSign! )
	RETURN
END IF

IF test_pw = '' OR test_pw = ' '  THEN
	setfocus(sle_password)
	MessageBox ( 'Sign On Error','You must enter a PASSWORD to proceed!', StopSign! )
	RETURN
END IF

// Logging on to Stars Server instantiates gole_server
gnv_app.of_set_server_userid (test_id)
gnv_app.of_set_server_password (test_pw)
gnv_app.of_set_new_password ( "" )		//	11/05/01	GaryR	Stars 5.0.0

w_main.SetMicroHelp ( 'Attempting to logon to Stars Server.  Please wait ...' )

ll_rc	=	gnv_app.of_logon_and_change_password()

IF	ll_rc	<	0		THEN
	// Invalid logon - get out
	w_main.SetMicroHelp ( 'Logon to Stars Server was unsuccessful' )
	Return
END IF

// Get information about the user from Stars Server

n_cst_clientinfo_attrib	lnv_client		// Autoinstantiated

lnv_client	=	gnv_server.of_GetClientInfo()

IF	Trim (lnv_client.is_userid)	<	' '	THEN
	Return
END IF

// Oracle requires a 'Set Schema' command so that the SQL will not require the
//	table name to be prefixed for the table's owner.
gnv_sql.of_set_schema (lnv_client.is_schema_name)		//Remove hard-coding of value
gnv_sql.of_set_userid( Upper( test_id ) )

w_main.SetMicroHelp ( 'Logged on to Stars Server.  '	+	ls_microhelp )

// FDG 02/20/01	end

// JasonS 08/16/02 Begin - Track 3098d
gnv_app.of_set_idle( TRUE )											// FDG 06/27/96
// JasonS 08/16/02 End - Track 3098d

gnv_sql.of_setup_transactions (lnv_client.is_userid, lnv_client.is_password)
// FDG 12/04/00 End

//CONNECT Using stars2ca;		// FDG 02/20/01
Stars2ca.of_connect()			// FDG 02/20/01
if (stars2ca.sqlcode <> 0) then
	// FDG 12/04/00 - Make error checking DBMS independent.
   //if (stars2ca.Sqldbcode = 4002) then
	IF	gnv_sql.of_is_bad_connection (stars2ca.Sqldbcode)	=	TRUE	THEN
      SqlDBRc  = stars2ca.SqlDBCode
      ROLLBACK   Using stars2ca;
      stars2ca.of_disconnect()						// FDG 02/20/01
      MessageBox("Sign On Error", + &
                 "Error Connecting To Database" + &
                 "~n~nPossible Causes:" + &
                 "~n   1. Invalid User Id" + &   
                 "~n   2. Invalid Password" + &
                 "~n   3. Database Error" + &   
                 "~n   4. STARS.INI is not properly setup" + &   
                 "~n~n SqlDBCode = " + String(SqlDBRc) + &
                 "~n~n Retry Sign On",StopSign!,OK!,1)
     setfocus(sle_user_id)
     return
     HALT CLOSE
   else
       SqlDBRc  = stars2ca.SqlDBCode
       SqlDBMsg = stars2ca.SqlErrText
       ROLLBACK   Using Stars2ca;
       stars2ca.of_disconnect()										// FDG 02/20/01
       MessageBox("Sign On Error", &
                  "Error Connecting To Database" + &
                  "~n" + SqlDBMsg + &
                  "~n~n SqlDBCode = " + String(SqlDBRc) + &
                  "~n~n Retry Sign On",StopSign!,OK!,1)
		 setfocus(sle_password)				
       return 
       HALT CLOSE
   end if
end if

//NLG 10-13-99 call of_set_textsize 
li_rc = stars2ca.of_set_textsize()

// FDG 02/20/02 - If cannot connect, get out.
li_rc	=	Stars1ca.of_connect()		// FDG 02/20/01

IF	li_rc	<>	0		THEN
	SqlDBRc  = stars1ca.SqlDBCode
	SqlDBMsg = stars1ca.SqlErrText
	ROLLBACK   Using Stars1ca;
	stars1ca.of_disconnect()										// FDG 02/20/01
	MessageBox("Sign On Error", &
				"Error Connecting To Database" + &
				"~n~nPossible Causes:" + &
            "~n   1. Invalid User Id" + &   
            "~n   2. Invalid Password" + &
            "~n   3. Database Error" + &   
            "~n   4. STARS.INI is not properly setup" + &   
				"~n" + SqlDBMsg + &
				"~n~n SqlDBCode = " + String(SqlDBRc) + &
				"~n~n Retry Sign On",StopSign!,OK!,1)
	setfocus(sle_password)				
	return 
	HALT CLOSE
END IF
// FDG 02/20/02 end

Starsusermsg.of_connect()	// FDG 02/20/01

SELECT user_id,
		 user_sl,
		 user_dept,
		 trk_dflt,
		 sys_dflt,
		 cri_dflt,
		 tbl_dflt,
		 cod_dflt,
       active_case,					//JGG 12/22/97
       active_subset_name,			//JGG 12/22/97
		 active_subset_case,			//JGG 12/22/97
       alert_days,  // SG Nov 94
		 user_s1
  INTO :gc_user_id,
		 :gv_user_sl,
		 :gc_user_dept,
		 :gv_trk_dflt,
		 :gv_sys_dflt,
		 :gv_cri_dflt,
		 :gv_tbl_dflt,
		 :gv_cod_dflt,
       :gv_active_case,
       :gc_active_subset_name,	//JGG 12/22/97
		 :gc_active_subset_case,	//JGG 12/22/97
       :lv_alert_days,  // SG Nov 94
		 :lv_user_s1
   FROM USERS
  WHERE user_id = Upper( :test_id )
  using stars2ca;
If stars2ca.of_check_status() = 100 Then
	u_button = MessageBox ( 'Sign On Error', test_id + ' does not exist!', &
									StopSign!, RetryCancel!, 1 )
	Commit Using Stars2ca;									// FDG 10/19/95
	IF u_button = 1 THEN
		Setfocus(sle_user_id)
		RETURN
	ELSE
      HALT CLOSE
	END IF
elseIF stars2ca.sqlcode <> 0 THEN
	Errorbox(stars2ca,'Error Reading the User Table')
	Return
END IF

// FDG 04/23/01 - Edit the software version against the database version.
IF	gnv_app.of_edit_version()	=	FALSE		THEN
	MessageBox ('Sign On Error', 'The version of the software does not match the version of the '	+	&
					'database migration.~n~rPlease contact your System Administrator to either provide '	+	&
					'you with the correct~n~rrelease of the software or to execute the database '				+	&
					'migration for this release.~n~r~n~rThe application will now terminate.', StopSign! )
	HALT CLOSE
END IF

// Login Disclaimer
SELECT cntl_no
INTO :li_disclaimer
FROM SYS_CNTL
WHERE cntl_id = 'DISCLAIMER'
using Stars2ca;

IF li_disclaimer > 0 THEN
	Open( w_disclaimer )
	//	Close app if user does not consent to dislaimer
	IF IsNull( Message.DoubleParm ) OR Message.DoubleParm <> 1 THEN HALT CLOSE
	SetNull( Message.DoubleParm )
END IF

//ajs 4.0 03-11-98 Add code to retrieve subset id
If IsNull(Trim(gc_active_subset_name)) or IsNull(Trim(gc_active_subset_case)) &
   or Trim(gc_active_subset_name) = '' or gc_active_subset_case = '' then
	gc_active_subset_id   = ''
	gc_active_subset_name = ''
	gc_active_subset_case = ''
Else
	lnv_subset_functions = create nvo_subset_functions
	lstr_subset_ids.subset_case_id = left(gc_active_subset_case,10)
	lstr_subset_ids.subset_case_spl = mid(gc_active_subset_case,11,2)
	lstr_subset_ids.subset_case_ver = mid(gc_active_subset_case,13,2)
	lstr_subset_ids.subset_name = gc_active_subset_name
	lnv_subset_functions.uf_set_structure(lstr_Subset_ids)
	ll_rows = lnv_subset_functions.uf_Retrieve_Subset_ID()
	if ll_rows = 1 then
		lstr_subset_ids = lnv_subset_functions.uf_get_structure()
		gc_active_subset_id = lstr_subset_ids.subset_id
	else
		gc_active_subset_id   = ''
		gc_active_subset_name = ''
		gc_active_subset_case = ''
	end if
	destroy(lnv_subset_functions)
End If
//ajs 4.0 03-11-98 end


gv_sys_dflt = upper(gv_sys_dflt)       //11-29-94 FNC

COMMIT USING STARS2CA;

//	Set the user id & user ini file in gnv_app
gnv_app.of_set_userid (gc_user_id)						// FDG 07/01/97
ls_userinifile	=	gnv_app.of_get_user_ini_file()	// FDG 07/01/97

//	Set the yellow lookups menu
IF ProfileInt( ls_userinifile, 'COLORS', 'EnableYellow', 0 ) = 1 THEN
	gnv_app.of_set_yellow_lookup( TRUE )
END IF

//	Set the resize menu option
gnv_app.of_get_resize()										// FDG 07/01/97

gv_user_id = gc_user_id
holduid = stars2ca.LOGID
holdpw  = stars2ca.LOGPASS

SELECT cntl_no,cntl_date INTO :lv_cntl_no,:ldte_getdate
from sys_cntl 
	WHERE cntl_ID = 'CASE' 			
using stars2ca;
if stars2ca.of_check_status() = 100 Then
	errorbox(stars2ca,'Record Not Found for Case on System Control table')
	return
elseif stars2ca.sqlcode <> 0 Then 
	errorbox(stars2ca,'Error reading the sys_cntl table')
	return
end if

COMMIT USING STARS2CA;

SELECT cntl_no INTO :gc_dw_limit
	FROM SYS_CNTL
	WHERE cntl_id = 'QUERY'
using stars2ca;
if stars2ca.of_check_status() = 100 Then
	errorbox(stars2ca,'No Records found')
	return
elseif stars2ca.sqlcode <> 0 Then 
	errorbox(stars2ca,'Error reading the sys_cntl table')
	return
end if


COMMIT USING STARS2CA;

// FDG 01/15/99 begin

IF	Parent.Event	ue_edit_pc_date()	=	FALSE		THEN
	// PC Date not close to server date and the user wants to exit the app.
	cb_cancel.PostEvent (Clicked!)
	Return
END IF

// FDG 01/15/99 end

//DJP 8/5/96 #930 - read date from Sybase
lv_sys_date	=	gnv_app.of_get_server_date()	// FDG 01/15/99
lv_sys_month = string(month(lv_sys_date))
lv_sys_year = left(string(year(lv_sys_date)),1) + right(string(year(lv_sys_date)),2)

if len(lv_sys_month) = 1 then 
    lv_sys_month = '0'+ lv_sys_month 
end if 

lv_cntl_date = date(ldte_getdate)
lv_cntl_month = string(month(lv_cntl_date))
lv_cntl_year = left(string(year(lv_cntl_date)),1) + right(string(year(lv_cntl_date)),2) 

if len(lv_cntl_month) = 1 then 
    lv_cntl_month = '0'+ lv_cntl_month 
end if 

if lv_sys_month <> lv_cntl_month then
    lv_cntl_month = lv_sys_month
    UpdateCntl = true
end if

if lv_sys_year <> lv_cntl_year then
    lv_cntl_year = lv_sys_year
    UpdateCntl = true
end if

if UpdateCntl then 
	lv_cntl_no = long(lv_cntl_year+lv_cntl_month+'00000')

	UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'CASE'
	USING STARS2CA;

	UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'TARGET'
	USING STARS2CA;

	UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'NOTE'
	USING STARS2CA;

	UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'LEAD'
	USING STARS2CA;

   UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'RSTR'
	USING STARS2CA;

   UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'REPORT'
	USING STARS2CA;

   UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'CRITERIA'
	USING STARS2CA;

   UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'SUBSET'
	USING STARS2CA;
	
   UPDATE SYS_CNTL                      
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'JOB_ID'
	USING STARS2CA;
	
   UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'FILTER'
	USING STARS2CA;                     

   UPDATE SYS_CNTL
		SET CNTL_NO = :lv_cntl_no, 
			 CNTL_DATE = :lv_sys_date
	WHERE CNTL_ID = 'PDQ_TMP_ID'
	USING STARS2CA;                     

end if                        
COMMIT USING STARS2CA;

//Release Hold on Case if it was being held by this user
//Select max(Cntl_case) into :gv_case_active		//ajs 4.0
Select max(Cntl_case) into :ls_active_case
	from sys_cntl
	where cntl_id = Upper( :gc_user_id )
Using Stars2ca;
If Stars2ca.of_check_status() <> 0 and stars2ca.sqlcode <> 100 Then
	MessageBox ('EDIT','Error reading System Control for a Case on hold with your Id')
	ls_active_case = ''					//ajs 4.0
ELSEIF IsNull(ls_active_case) then	//ajs 4.0
	ls_active_case	= ''				// ajs 4.0

	Delete from sys_cntl            				//11-29-94 FNC Start - Don't really
		where cntl_id = Upper( :gc_user_id )	// know why the case id would be null
	Using Stars2ca;                 				// but sometimes it is.
	If stars2ca.of_check_status() <> 0 then
		Messagebox('ERROR','You are holding a lock on Case ' + ls_active_case + '.  This case does not exist.  Unable to delete from System Control')	//ajs 4.0
		stars2ca.of_rollback()							// FDG 02/20/01
	End If
COMMIT USING STARS2CA;
ELSEIf trim(ls_active_case) <> '' and not isnull(ls_active_case) then //ajs 4.0
	gv_active_case = ls_active_case			//ajs 4.0
	lv_case_id = left(ls_active_case,10)	//ajs 4.0
	lv_case_spl = mid(ls_active_case,11,2)	//ajs 4.0
	lv_case_ver = mid(ls_active_case,13,2)	//ajs 4.0
	//AJS FS362 convert case to case_cntl
	//	01/08/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
	Update case_cntl
		set  CASE_DISP_HOLD = :ls_empty
		where case_id = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Messagebox('ERROR','Unable to release hold on Case ' + ls_active_case)	//ajs 4.0
		stars2ca.of_rollback()							// FDG 02/20/01
		gv_active_case = ''	//ajs 4.0
		goto proceed_logic
	End IF		
	Delete from sys_cntl 
		where Cntl_case = Upper( :ls_active_case )	//ajs 4.0
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Messagebox('ERROR','You are holding a lock on Case ' + ls_active_case + '.  This case does not exist.  Unable to delete from System Control')
		gv_active_case = ''	//ajs 4.0
		stars2ca.of_rollback()							// FDG 02/20/01
	End If
	COMMIT USING STARS2CA;
End If

Proceed_logic:

if Trim( gv_active_case ) <> '' AND Trim( gv_active_case ) <> 'NONE' then
   lv_case_id = left(gv_active_case,10)          //03-14-94 FNC  START
   lv_case_spl = mid(gv_active_case,11,2)
   lv_case_ver = mid(gv_active_case,13,2)
	
	//AJS FS362 convert case to case_cntl
   SELECT CASE_CNTL.CASE_DISP_HOLD, CASE_CNTL.CASE_STATUS
     INTO :lv_case_disp_hold, :lv_case_status  
     FROM CASE_CNTL  
   WHERE ( CASE_CNTL.CASE_ID = Upper( :lv_case_id ) ) AND  
         ( CASE_CNTL.CASE_SPL = Upper( :lv_case_spl ) ) AND  
         ( CASE_CNTL.CASE_VER = Upper( :lv_case_ver ) )   
   USING STARS2CA;

   If stars2ca.of_check_status() = 100 Then
    	MessageBox ( 'Sign On Error', 'Active Case' + gv_active_case + ' does not exist!', &
									StopSign!)
		gv_active_case = ''
		lv_invalid_case = true
   elseif stars2ca.sqlcode <> 0 then
   	Errorbox(stars2ca,'Error Reading the Case Table') 
   end if                                     
end if

if lv_case_status = 'DL' then    // 06-16-94 FNC Start
  MessageBox ( 'Sign On Error', 'Active Case ' + gv_active_case + ' has been Deleted', &
									StopSign!)
  gv_active_case = ''
elseif lv_case_disp_hold = 'HOLD' then
  MessageBox ( 'Sign On Error', 'Active Case ' + gv_active_case + ' is held by another user!', &
									StopSign!)
elseif lv_case_status = 'CL' then
  MessageBox ( 'Sign On Error', 'Active Case ' + gv_active_case + ' has been Closed', &
									StopSign!)
// Begin - Track 3063d									
elseif lv_case_status = 'RC' then									
	MessageBox ( 'Sign On Error', 'Active Case ' + gv_active_case + ' has been Closed due to Referral', &
									StopSign!)
// End - Track 3063d				
end if                          // 06-16-94 FNC End

lv_rc = wf_disable()


IF gv_user_sl = 'AD' THEN
   m_stars_30.m_admin.enabled = TRUE

	SetMicroHelp ( w_main, 'ADMINISTRATOR LEVEL sign-on successful...' )
ELSE
   m_stars_30.m_admin.enabled = FALSE
//DJP 2/1/96 prob#86 - change message here for security purposes
	if gv_user_sl = 'SA' THEN
		SetMicroHelp ( w_main, 'SUPERVISOR LEVEL sign-on successful...' )
	else
		SetMicroHelp ( w_main, 'NORMAL LEVEL sign-on successful...' )
	end if
END IF

lv_date_plus_alert_days = RelativeDate(lv_sys_date, lv_alert_days)  // SG Nov 94

//load the stars relationship table
w_main.dw_stars_rel_dict.settransobject(stars2ca)
lv_rc = w_main.dw_stars_rel_dict.retrieve()

If lv_rc <= 0 then
	Commit Using Stars2ca;					// FDG 10/19/95
	Messagebox('EDIT','Unable to Retrieve Stars Relationship')
	RETURN
End IF

w_main.event ue_get_timermax()			// FNC 11/18/99

// ABO 9/6/96 start
if gv_user_sl = 'AD' then
	SELECT count(*)
	  INTO :li_future_count
	  FROM period_cntl
	 WHERE function_status = 'FU'
    USING stars2ca;

	if li_future_count = 0 then
		SELECT max(model)
   	  INTO :ls_model
     	  FROM period_cntl
	 	 USING stars2ca;
		  li_next_model = integer(ls_model) + 1
		  MessageBox('Sign On', 'A period control model needs to be created for ' + string(li_next_model) + '.', Information!)
	end if
end if
// ABO 9/6/96 end

// SG Nov 94 -- Check for alerts
//AJS FS362 convert case to case_cntl
// FDG 10/19/01	Stars 4.8.1.  Don't retrieve rows for deleted or closed cases.
SELECT count(*) into :lv_alert_count   
FROM CASE_CNTL,   
     LEAD  
WHERE ( CASE_CNTL.CASE_ID = LEAD.CASE_ID ) AND  
		( CASE_CNTL.CASE_spl = LEAD.CASE_spl ) AND  
		( CASE_CNTL.CASE_ver = LEAD.CASE_ver ) AND  
      ( CASE_CNTL.CASE_ASGN_ID = Upper( :gc_user_id ) ) AND
      ( CASE_CNTL.CASE_STATUS <> 'CL' ) AND
      ( CASE_CNTL.CASE_STATUS <> 'DL' ) AND
		( CASE_CNTL.CASE_STATUS <> 'RC' ) AND		// JasonS 06/18/02   Track 3063d
      ( LEAD.LTR_DUE_DATE BETWEEN :lv_sys_date AND :lv_date_plus_alert_days) AND 
      ( LEAD.LTR_DUE_DATE > LEAD.DATE_AK ) AND
		( LEAD.DATE_AK = :ldt_where )					//Archana 4-26-99
using stars2ca;

if lv_alert_count > 0 Then
	//AJS FS362 convert case to case_cntl
	// 12/13/00	GaryR	Stars 4.7 DataBase Port - Begin
   ls_sql = 'SELECT LEAD.CASE_ID, LEAD.CASE_SPL, LEAD.CASE_VER, LEAD.LEAD_ID, ' + &
							'LEAD.LTR_DUE_DATE ' + &   
                      'FROM CASE_CNTL, LEAD ' +                              &                          
                      'WHERE ( CASE_CNTL.CASE_ID = LEAD.CASE_ID ) AND ' +    &
                      ' ( CASE_CNTL.CASE_spl = LEAD.CASE_spl ) AND ' +    &
                      ' ( CASE_CNTL.CASE_ver = LEAD.CASE_ver ) AND ' +    &
                      '( CASE_CNTL.CASE_ASGN_ID = ' + "'" + Upper( gc_user_id ) + &
							 "'" + ' ) AND ' + '( LEAD.LTR_DUE_DATE BETWEEN ' +  &
                      gnv_sql.of_get_to_date( "'" + String(lv_sys_date, 'mm/dd/yyyy') + "'" ) + &
							 ' AND ' + gnv_sql.of_get_to_date( "'" + String(lv_date_plus_alert_days, 'mm/dd/yyyy') + "'"  ) + &
                      ' ) AND ( LEAD.LTR_DUE_DATE > LEAD.DATE_AK ) ' +  &
							 ' AND ( LEAD.DATE_AK = ' + gnv_sql.of_get_to_date( "'01/01/1900'" ) + &
							 ') ORDER BY LEAD.LTR_DUE_DATE'							 
	// 12/13/00	GaryR	Stars 4.7 DataBase Port - End	
	OpenWithParm(w_alert, ls_sql )

End if   

// FDG 02/20/01 begin
// Warn the user if the password is within 2 weeks of expiring
//	06/14/01	GaryR	Stars 4.7 - BEgin
// 12/09/2004 Katie Track 4113 
IF	 lnv_client.il_days_to_expire	>	-1 THEN
	IF MessageBox ('Password Warning', 'Your password will expire in '	+	&
					String(lnv_client.il_days_to_expire)	+	' days!'		+	&
					'~n~rWould you like to change your password now?', &
					Exclamation!, YesNo!) = 1 THEN	Open( w_change_password )			
		
END IF
//	06/14/01	GaryR	Stars 4.7 - End
// FDG 02/20/01 end

//Start create PIMR logic - JFS 1/16/01

Select cntl_no
into :li_pimr_sw
from sys_cntl
where cntl_id = 'USEPIMR'
using Stars2ca;

if Stars2ca.of_check_status() <> 0 then
	li_pimr_sw = 0
end if
	
if li_pimr_sw = 1 then
	String	ls_user_s1
	Select	user_s1
	into		:ls_user_s1
	from		users
	Where		user_id	=	Upper( :gc_user_id )
	Using		Stars2ca;
	IF	Stars2ca.of_check_status() <> 0	THEN
		ls_user_s1	=	' '
	END IF
	IF	ls_user_s1	=	'P'	THEN
		m_stars_30.m_admin.m_createpimrfile.enabled = true
	ELSE
		m_stars_30.m_admin.m_createpimrfile.enabled = false
	END IF
else
	m_stars_30.m_admin.m_createpimrfile.enabled = false
end if

//End create PIMR Logic - JFS

// 09/19/01	GaryR	Stars 4.7
If lv_invalid_case then	OPENSHEET(W_CASE_ACTIVE,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)

gnv_app.of_npi_cntl()

gnv_app.of_set_idle_time(lnv_client.il_idle_minutes)
w_main.of_set_timer_ctr( 999999 )					//	09/05/01	GaryR	Stars 4.8

Parent.wf_get_last_login( test_id )

Close ( parent )
end event

on getfocus;setmicrohelp (w_main, this.tag)

end on

type st_2 from statictext within w_sign_on
boolean visible = false
string accessiblename = "You have timed out of the STARS system.  Please enter your password to reconnect."
string accessibledescription = "You have timed out of the STARS system.  Please enter your password to reconnect."
accessiblerole accessiblerole = statictextrole!
integer y = 724
integer width = 2779
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "You have timed out of the STARS system.  Please enter your password to reconnect."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_reconnect from u_cb within w_sign_on
string tag = "Reconnect to the STARS system"
boolean visible = false
string accessiblename = "Reconnect"
string accessibledescription = "Reconnect"
integer x = 1577
integer y = 816
integer height = 80
integer taborder = 60
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Reconnect"
end type

event clicked;////////////////////////////////////////////////////////////////////
//
// 10/06/00	GaryR 2315d Conforming STARS to the HIPAA Act
//	02/22/01	FDG	Stars 4.7 - Reconnect to Stars Server
//	01/12/05	GaryR	Track 4088d	Display last login timestamp and status
//
////////////////////////////////////////////////////////////////////


String	ls_pass,			&
			ls_microhelp

Long		ll_rc

ls_pass = sle_password.Text

// FDG 03/02/01 - Save text of Microhelp
ls_microhelp	=	"Attempting to reconnect " + sle_user_id.text + "..."

w_main.SetMicroHelp ( ls_microhelp )

IF IsNull( ls_pass ) OR Trim( ls_pass ) = "" THEN
	SetFocus( sle_password )
	MessageBox( 'Reconnection Error','You must enter a PASSWORD to proceed!', StopSign! )
	RETURN
END IF

// FDG 02/22/01 - call gnv_app.of_get_server_password instead of STARS2CA.LogPass
IF ls_pass <> gnv_app.of_get_server_password()	THEN
	MessageBox( "Reconnection Error", "Invalid password!  Please try again.", StopSign! )	
	SetFocus( sle_password )
	RETURN
END IF

// FDG 02/22/01 - Reconnect to Stars Server

w_main.SetMicroHelp ( 'Attempting to reconnect to Stars Server.  Please wait ...' )

ll_rc	=	gnv_app.of_logon_to_server()

IF	ll_rc	<	0		THEN
	w_main.SetMicroHelp ( 'Reconnect to Stars Server was unsuccessful' )
	Return
END IF

w_main.SetMicroHelp ( 'Reconnected on to Stars Server.  '	+	ls_microhelp )

// FDG 02/22/01 end

IF Stars1ca.of_connect() <> 0 THEN Return
IF Stars2ca.of_connect() <> 0 THEN Return
IF Starsusermsg.of_connect() <> 0 THEN Return

Parent.wf_get_last_login( sle_user_id.text )

CloseWithReturn( PARENT, 1 )
end event

event getfocus;setmicrohelp (w_main, this.tag)
end event

type cb_exit from u_cb within w_sign_on
string tag = "Exit out of STARS"
boolean visible = false
string accessiblename = "Exit"
string accessibledescription = "Exit"
integer x = 1577
integer y = 916
integer height = 80
integer taborder = 70
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Exit"
end type

event clicked;Close( PARENT )
end event

event getfocus;setmicrohelp (w_main, this.tag)
end event

type p_3 from picture within w_sign_on
string accessiblename = "STARS Logo"
string accessibledescription = "STARS Logo"
accessiblerole accessiblerole = graphicrole!
integer y = 1412
integer width = 3511
integer height = 144
boolean originalsize = true
string picturename = "maintop1.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_sign_on
string accessiblename = "STARS Signon Banner"
string accessibledescription = "STARS Signon Banner"
accessiblerole accessiblerole = graphicrole!
integer width = 2793
integer height = 652
boolean originalsize = true
string picturename = "logintop1.bmp"
boolean focusrectangle = false
end type

