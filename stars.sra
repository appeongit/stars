HA$PBExportHeader$stars.sra
forward
global type stars from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// This logic gets the current build number from a file called build.ini
// which resides under "V:\Development\Stars\Builds" with a [version_control] 
// section and a "build" key. This file is shared by both the GUI and Server
// logic to get the latest build number.  We need to manually increase the 
// build number in the build.ini before the scheduled task executes.
//	07/20/06	GaryR	SPR 4773	Automate the GUI build process
//	01/23/07 Katie 4758 Added gv_prov_npi
// 04/29/08 Rick 5335 Added gl_accessible_delay and gs_accessible_msg to hold the delay seconds
//                             and message values, respectively, from the STARS.ini file.
// 05/05/08 RickB SPR 5335  Removed obsolete variable gv_bg_process.
// 05/05/08 RickB SPR 5335  Deleted Global variables gl_accessible_delay and gs_accessible_msg
//									  to make them instance variables in uo_splash.
// 05/20/08 RickB SPR 5335  Added gv_rowcounter
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//	12/19/08	GaryR	Track 5617	Streamline automated build process
//**********************************************************************

error	 	error 
// NVO for external functions
u_nvo_winapi_functions	 gapi 

//NVO for database-specific SQL (FDG 11/14/00 - 4.7)
n_cst_sql		gnv_sql

// COM object to interface with the Stars Server (FDG 02/27/01 - 4.7)
OleObject		gole_server

//NVO wrapper to interface with gole_server (FDG 02/27/01 - 4.7)
n_cst_server	gnv_server

// Is the d/w in print preview mode & was previously enabled?
boolean  gb_print_preview_enabled

string	gc_active_subset_case 
string	gc_active_subset_id 
string	gc_active_subset_name 
string	gc_area_label 
string	gc_charged_label 
boolean  gc_debug_mode 
long	 	gc_dw_limit 
string	gc_period_label 
string	gc_proc_code_label 
string	gc_prov_id_label 
string	gc_spec_label 
string	gc_srvc_cnt_label 
string	gc_user_dept 
string	gc_user_id 

// STARS Application manager NVO
n_cst_appmanager 	 gnv_app 

long gl_accessible_delay
string	gv_active_case 
string	gv_active_category 
string	gv_active_crit 
string	gv_active_filter 
string	gv_active_invoice  
string	gv_analysis_1_sel 
string	gv_business 
boolean  gv_cancel 
boolean  gv_cancel_but_clicked 
string	gv_case_disp 
string	gv_case_dup_ids 
string	gv_case_target 
string	gv_cd_desc[] 
string	gv_cod_dflt 
string	gv_code_code 
string	gv_code_id_to_use 
string	gv_code_to_use 
string	gv_code_type 
string	gv_compare_by 
string	gv_cri_dflt 
string	gv_crit_name 
string	gv_crit_place_ind 
string	gv_crit_sub_type 
string	gv_current_sub_src_name 
string	gv_current_sub_src_type 
string	gv_da_desc[] 
string	gv_del_ind 
string	gv_display_subset_rows_sel 
string	gv_drilldown 
string	gv_dt_desc[] 
string	gv_element_name 
string	gv_element_table_type 
string	gv_element_table_type2 
string	gv_element_table_type3 
string	gv_english_crit 
string	gv_exp1[] 
string	gv_exp2[] 
string	gv_from 
string	gv_graph_sel 
string	gv_ini_path 
string	gv_left_paren[] 
integer  gv_line_no 
string	gv_lk_desc[] 
string	gv_logic[] 
string	gv_name 
string	gv_new_ccn 
datetime gv_new_date 
long		gv_no_rows 			// FDG 03/18/02 - Track 4111c - Change from int to long
date	 	gv_notes_date 
string	gv_notes_from 
string	gv_notes_name 
string	gv_notes_rel_name 
string	gv_notes_rel_type 
string	gv_notes_sub_type 
string	gv_ns_desc[] 
string	gv_nt_desc[] 
integer  gv_num_of_cd 
integer  gv_number_of_tables 
string	gv_op[] 
string	gv_pass_crit 
long	 	gv_period 
long	 	gv_period_key 
integer  gv_prev_year 
integer  gv_prior_prev_year 
string	gv_prov_id 
string	gv_prov_upin 
string gv_prov_npi
integer  gv_rc 
integer  gv_relist 
string	gv_report_id 
long	 	gv_report_period 
integer  gv_report_year 
integer  gv_result 
string	gv_right_paren[] 
long gv_rowcounter
string	gv_rstr_id 
string	gv_selection1 
string	gv_selection2 
integer  gv_selection3 
gs_table_info  gv_ss_parms 
string	gv_st_desc[] 
string	gv_stack1 
string	gv_stack2 
string	gv_stars2 
datetime gv_sub_run_time 
string	gv_sub_src_name 
string	gv_sub_src_case 
string	gv_sub_src_type 
string	gv_subset_break_array[20,10] 
string	gv_subset_bus 
string	gv_subset_from 
string	gv_subset_id 
string	gv_subset_request 
string	gv_subset_sel 
string	gv_subset_sel_values 
string	gv_subset_target_type 
string	gv_subset_tbl_type 
string	gv_subset_total_array[50,10] 
boolean  gv_summ_flg  = FALSE
string	gv_sys_dflt 
string	gv_target_1 
string	gv_target_2 
string	gv_target_name 
string	gv_target_subset_id 
string	gv_target_trk_type 
string	gv_tb_desc[] 
string	gv_tbl_dflt 
string	gv_tbl_directory[18] 
string	gv_trk_dflt 
string	gv_trk_key 
string	gv_trk_type 
string	gv_tt_desc[] 
string	gv_user_id 
string	gv_user_ini_path 
string	gv_user_sl 
string	gv_where 
string	gv_which_dw 
integer  gv_win_x_pos 
integer  gv_win_y_pos 

n_tr	sqlca 
n_tr	stars1ca 
n_tr	stars2ca 
n_tr  starsusermsg

integer  help_menu_position = 9
window	mdi_main_frame 
message  message 
dynamicdescriptionarea   sqlda 
dynamicstagingarea	    sqlsa 

win_colors stars_colors 

// SPR3650d - Computed columns: Add global Dictionary service
n_cst_dict		gnv_dict

int 	gv_npi_cntl

end variables

global type stars from application
string appname = "stars"
end type
global stars stars

type prototypes

end prototypes

type variables

end variables

event open;//************************************************************************
//		Object Type:	Application
//		Object Name:	Stars
//		Event Name:		Open
//
//
//	NOTE:	Stars1ca and Stars2ca is connected to in w_sign_on after the
//			user signs onto Stars.
//
//************************************************************************
//	FDG	07/18/96	Replace all global external functions with the NVO
//						functions.  This is to hide the difference between 
//						16 & 32 bit operating system.
//
//	FNC	06/24/97	Update for PB 5.0
//
//	FDG	07/01/97	Add n_cst_appmanager as a "Global NVO".  Any global
//						functions that are executed often can be placed
//						in n_cst_appmanager.
//
//	FDG	01/05/98	Replace "TRANSACTION" with n_tr for Stars1ca and
//						Stars2ca.  Do the same with the properties of SQLCA.
//
// JGG	04/02/98 Open the splash window.
//						Reverse the way the STAR screen is handled.  In order to
//						view the STAR screen when the application opens, the
//						user has to have /PIC defined as a command line parm.
//Archana 04/12/99Enable the user to default baltimore bitmap on or off at login.
//
//	NLG	08/08/99	TS2363c. Move create of gnv_app to beginning of script.
//						Call set version function for version 4.1
//
// FNC	02/03/00 Fraud PDQs - Create new transaction by the
//						timer even to check if user has messages on the user
//						message table
//
// Gary-R 07/10/2000 Eliminate two globals::gv_crystal_path, gv_runcrw_path
//
//	FDG	11/14/00	Stars 4.7 - Oracle Port.  Instantiate gnv_sql, gole_server.
//	FDG	04/23/01	Stars 4.7.	Modify the version for STARS 4.7.
//	GaryR	07/17/01	Stars 4.7	Clean up Stars.ini
//	GaryR	09/19/01	Stars 4.7	Clean up Stars.ini
//	GaryR	09/20/01	Stars 4.7	Centralize all connection parms
//	GaryR	11/06/01	Stars 5.0.0	Accomodate for spaces in ini path
//	GaryR	04/10/02	Track 2977d	Registering the COM object programatically
// MikeF 01/11/05 Track	4228d	Change Application title
//	GaryR	11/07/06	Track	4821	Remove obsolete global variables
//  RickB 04/29/08 Track 5335  Adding values to two new accessibility variables within the section
//                                          that checks for an existing .ini file.  Moved Open(w_splash) below
//                                          that because we need those variables for the splash screen.
//  RickB 04/29/08 Track 5335  Deleted the code that assigned values to global accessibility 
//										variables because they were made instance variables in uo_splash.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
//************************************************************************

String lv_title,lv_temp
int lv_pos
ENVIRONMENT		lenv										//FDG 07/18/96
boolean lb_open_star = false							//JGG 04/02/98
STRING ls_open_star
String	ls_dbms											//FDG	11/14/00
String	ls_server										//FDG 02/22/01
String	ls_dbname										//FDG 02/22/01

gnv_app	=	CREATE	n_cst_appmanager				//NLG 08-09-99

// Change the following line of script only if there is a database migration
//	associated with this release.  If changing this line of code, also update
// column (to the same value) cntl_text of the 'VERSION' row in sys_cntl.
gnv_app.of_set_version('Version 6.5')				//NLG 08-09-99

//FDG 07/18/96 Begin 
GetEnvironment (lenv)

CHOOSE CASE	lenv.OSType	
	CASE	Windows!
		IF	lenv.win16	THEN										//06-24-97 FNC
			gapi	=	CREATE	u_nvo_winapi_16_functions	//06-24-97 FNC
		ELSE
			gapi	=	CREATE	u_nvo_winapi_32_functions	//06-24-97 FNC
		END IF
	CASE	WindowsNT!
		gapi	=	CREATE	u_nvo_winapi_32_functions
	CASE	ELSE
		gapi	=	CREATE	u_nvo_winapi_32_functions
END CHOOSE
//FDG 07/18/96 End	

// * OPEN SCRIPT FOR APPLICATION STARS    *
STARS1CA = CREATE n_tr				//	FDG 01/05/98 - Replace TRANSACTION with n_tr
STARS2CA = CREATE n_tr				//	FDG 01/05/98 - Replace TRANSACTION with n_tr
starsusermsg = create n_tr  		//	FNC 02/03/00

//DJP
gv_ini_path = CommandParm ( )

lv_pos = Pos( gv_ini_path, "/" )								//	GaryR	11/06/01	Stars 5.0.0
if lv_pos>0 then
	lv_temp=upper(mid(gv_ini_path,lv_pos))
	gv_ini_path=Trim( left(gv_ini_path,lv_pos - 1) )	//	GaryR	11/06/01	Stars 5.0.0
	if pos(lv_temp,'/DB',1)>0 then gc_debug_mode=true
	if pos(lv_temp, '/PIC',1)>0 then lb_open_star = TRUE	//Archana 4/12/99
end if

// Setup for AUTOMATIC sign_on to Stars for gc_user_id
// Normally this should be set to blank (in the exe)
// Vips Developers can set this to their UserId/PassWord for automatic signon

gc_user_id = ''

IF (gv_ini_path = '' OR gv_ini_path = ' ') THEN	
	gv_ini_path = "C:\Stars\Source\ini\"
END IF

//	FDG 07/01/97 - Set the STARS ini file & ini path for the application
gnv_app.of_set_ini_file (gv_ini_path	+	'STARS.INI')
gnv_app.of_set_directory (gv_ini_path)

// FDG 11/14/00 - Begin

// Register StarWars.dll to the user's registry
IF gnv_app.of_RegisterServer() < 0 THEN HALT		//	04/10/02	GaryR	Track 2977d

// Instantiate the Stars Server objects
gole_server	=	CREATE	OLEObject
gnv_server	=	CREATE	n_cst_server

// Instantiate the DBMS-specific version of n_cst_sql
ls_dbms	=	Upper (ProfileString (gv_ini_path + 'STARS.INI', 'carrier', 'DBMS', 'ASE') )

CHOOSE CASE	ls_dbms
	CASE	'ORA'
		gnv_sql	=	CREATE	n_cst_sql_ora
	CASE	'UDB'	
		gnv_sql	=	CREATE	n_cst_sql_udb
	CASE	'MSS'	
		gnv_sql	=	CREATE	n_cst_sql_mss
	CASE	ELSE
		gnv_sql	=	CREATE	n_cst_sql_ase
		ls_dbms	=	gnv_sql.ics_ase
END CHOOSE

gnv_sql.of_set_dbms (ls_dbms)

// FDG 11/14/00 - End
Randomize(0)  // start random number generator by system clock

IF FileExists ( gv_ini_path + 'STARS.INI' ) THEN
	lv_title = "STARS - " + Profilestring(gv_ini_path + 'STARS.INI','Carrier','APPLTITLE','STARS')  
	
	//Archana 4-12-99 Begin
	ls_open_star = ProfileString(gv_ini_path+'STARS.INI','Carrier','ShowBitmap','NO')
	IF Upper(ls_open_star) = 'YES' THEN
		lb_open_star = TRUE
	END IF
	//Archana 4-12-99 End
	gnv_app.of_set_appname (lv_title)		// FDG 07/01/97

   gv_user_ini_path =Profilestring(gv_ini_path + 'STARS.INI','Carrier','UserINIpath', 'C:\')
	if right(gv_user_ini_path,1) <> '\' then 
		gv_user_ini_path = gv_user_ini_path + '\'
	end if

ELSE
	MessageBox ( 'Missing STARS.INI', 'You are missing the STARS.INI file. ' + &
					 'Please contact your System Administrator for assistance.', StopSign! )
	HALT
END IF

Open(w_splash)

Open (w_main)
W_main.title = lv_title
MDI_main_frame = w_main

// FDG 02/22/01 - Get the Stars server name and d/b name
ls_server = Profilestring(gv_ini_path + 'STARS.INI','StarsServer','Server','StarWars')
ls_dbname = Profilestring(gv_ini_path + 'STARS.INI','StarsServer','Warehouse','Stars2')

gnv_app.of_set_server_name(ls_server)
gnv_app.of_set_server_dbname(ls_dbname)
// FDG 02/22/01 end

//DJP - add ability to turn off star on startup
if lb_open_star then 
	OpenSheet(w_main_star,MDI_main_frame,help_menu_position,Layered!)
end if

gnv_dict = CREATE n_cst_dict

//	GaryR	09/19/01	Stars 4.7
Open( w_sign_on )
end event

event close;//************************************************************************
//		Object Type:	Application
//		Object Name:	Stars 
//		Event Name:		Close
//
//************************************************************************
// 08-03-94 FNC	Set the criteria and subset default to AH or RD 
//             	depending on business default
// 06/04-96 FNC	Remove delete from USER_TEMP_CCN_LINE for stars1ca
//             	since it was changed to a view also added commits
// 10/19/95 FDG	Remove the connects and disconnect from Stars1ca and
//						Stars2ca.
//	07/01/97 FDG	Destroy gnv_app that was created in the open event
// 12/22/97 JGG	Replace users table columns last_case with active_case
//             	last_subset with active_subset_name.
//	02/17/98	FDG	1. Use of_check_status() for SQL error checking.
//						2. Remove the call to user_temp_ccn_line since it's 
//						no longer used.
// 03/04/98 AJS   4.0 Correct globals; fix update of user table
//	02/03/00 FNC	Fraud PDQs - Disconnect and destroy the new transaction used 
//						by the timer even to check if user has messages on the user
//						message table
//	01/08/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 02/20/01	FDG	Stars 4.7.  Use of_disconnect() to disconnect from the d/b.
//						Also, shutdown Stars Server for this user
//	01/14/02	FDG	Stars 5.0.  Track 2678d.  Drop all previously created 
//						temp tables.
//	08/23/02	GaryR	Track 3279d	Do not reference user_temp_key view
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//************************************************************************

string lv_sys_dflt
long lv_handle
boolean lv_temp
Integer	li_rc				// FDG 02/20/01
n_cst_attachments	lnv_att

IF gc_user_id = '' then
	RETURN
End IF

// Delete the attachments temp files
lnv_att.of_deletetempfiles()

if stars1ca.of_check_status() <> 0 and stars1ca.sqlcode <> 100 then //06-04-96 FNC Start
	rollback using stars1ca;
else
	commit using stars1ca;
end if											//06-04-96 FNC End
	

Delete from User_temp_key 
	where user_id = Upper( :gc_user_id )
Using Stars2ca;

if stars2ca.of_check_status() <> 0 and stars2ca.sqlcode <> 100 then //06-04-96 FNC Start
	rollback using stars2ca;
else
	commit using stars2ca;
end if											//06-04-96 FNC End

//	01/08/01	GaryR	Stars 4.7 DataBase Port - Begin
IF gv_trk_dflt					= "" THEN gv_trk_dflt				= " "
IF gv_cri_dflt 				= "" THEN gv_cri_dflt				= " "
IF gv_tbl_dflt 				= "" THEN gv_tbl_dflt				= " "
//IF gv_dct_dflt 				= "" THEN gv_dct_dflt				= " "		//	10/07/02	GaryR	SPR 3196d
IF gv_cod_dflt 				= "" THEN gv_cod_dflt				= " "
IF gv_active_case				= "" THEN gv_active_case			= " "
IF gc_active_subset_name	= "" THEN gc_active_subset_name	= " "
IF gc_active_subset_case	= "" THEN gc_active_subset_case	= " "
//	01/08/01	GaryR	Stars 4.7 DataBase Port - End

update users
	set trk_dflt = :gv_trk_dflt,
		 cri_dflt = :gv_cri_dflt,
		 tbl_dflt = :gv_tbl_dflt,
		 //DCT_dflt = :gv_dct_dflt,			//	10/07/02	GaryR	SPR 3196d
		 cod_dflt = :gv_cod_dflt,
   	 active_case = :gv_active_case,
   	 active_subset_name = :gc_active_subset_name,
		 active_subset_case = :gc_active_subset_case
	where user_id = Upper( :gc_user_id )
using stars2ca;
			
if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error updating the user table');
end if

// FDG 01/14/02 - Drop previously created temp tables.
li_rc	=	gnv_server.of_drop_tempTables()

Stars1ca.of_disconnect()
Stars2ca.of_disconnect()
Starsusermsg.of_disconnect()

// Disconnect from Stars Server
li_rc	=	gnv_app.of_shutdown_server()

IF	IsValid (gnv_server)	THEN
	Destroy gnv_server
END IF

IF	IsValid (gole_server)	THEN
	Destroy gole_server
END IF

// FDG 02/20/01 end

destroy gapi							//FDG 07/18/96
destroy gnv_app						//FDG 07/01/97
destroy gnv_sql

destroy stars2ca
destroy stars1ca
destroy starsusermsg					//FNC 02/03/00
end event

event idle;//************************************************************************
//		Object Type:	Application
//		Object Name:	Stars
//		Event Name:		Idle
//
//		This event is triggered when the Idle() function reaches its 
//		threshold of no activity.  The Idle() function occurs in the
//		application open event.
//
//		This event posts an event in w_main which disconnect from 
//		Stars1ca and Stars2ca and displays a messagebox.  When the 
//    user clicks ok, Stars1ca and Stars2ca will be reconnected.
//************************************************************************
//	
//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
//	05/20/02	GaryR	Track 3073d	PB7 memory corruption on Idle()
//	04/13/04	GaryR	Track 6717c	Use Idle with PB9 to prevent double logon
//
//************************************************************************

//	09/14/01	GaryR	Track 2430d
//	05/20/02	GaryR	Track 3073d
//IF gnv_app.of_get_idle() THEN	w_main.TriggerEvent("disconnect_connect")
//IF gnv_app.of_get_idle() THEN	
w_main.Event disconnect_connect()
end event

event systemerror;//************************************************************************
//		Object Type:	Application
//		Object Name:	Stars
//		Event Name:		SystemError
//
//************************************************************************
//
//	FDG	09/19/01	Stars 4.8.1.	Rollback any database changes.
//
//************************************************************************

string lv_error

lv_error=error.text	+	' - line '	+	string(error.line)
if error.objectevent<>error.windowmenu then lv_error=lv_error + ' in ' + error.objectevent
if error.object<>error.windowmenu then lv_error = lv_error + ' event for ' + error.object
lv_error=lv_error +'  of ' + error.windowmenu
messagebox('SYSTEM ERROR','An unrecoverable error has occurred forcing STARS to shut down.'+'~r'+lv_error,stopsign!)

ROLLBACK	Using	Stars2ca;			// FDG 09/19/01		

halt close

end event

on stars.create
appname="stars"
message=create message
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on stars.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

