HA$PBExportHeader$w_main.srw
$PBExportComments$STARS frame window (inherited from w_master)
forward
global type w_main from w_master
end type
type mdi_1 from mdiclient within w_main
end type
type dw_stars_rel_dict from u_dw within w_main
end type
type sle_active_invoice from singlelineedit within w_main
end type
type sle_datetime from singlelineedit within w_main
end type
type cb_open_window from commandbutton within w_main
end type
type str_window from structure within w_main
end type
end forward

type str_window from structure
	string		s_window_name
	w_master		w_window
	long		l_handle
end type

global type w_main from w_master
string accessiblename = "STARS"
string accessibledescription = "STARS"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 0
integer width = 3054
integer height = 1960
string title = "STARS"
string menuname = "m_stars_30"
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 67108864
toolbaralignment toolbaralignment = alignatleft!
event disconnect_connect ( )
event ue_get_timermax ( )
event ue_open_user_messages ( )
mdi_1 mdi_1
dw_stars_rel_dict dw_stars_rel_dict
sle_active_invoice sle_active_invoice
sle_datetime sle_datetime
cb_open_window cb_open_window
end type
global w_main w_main

type variables
string iv_invoice_type,iv_invoice
string iv_test

window win_to_open
string is_opened_window //john_wo 11/13/97
window win_to_open_clear //john_wo 11/13/97

// Sheet Manager Service
n_cst_winsrv_sheetmanager	inv_sheetmanager

// Next window handle (for response/child windows)
Long		il_window_handle

// array of opened response/child windows
private str_window	istr_window[]

Constant  Long	il_timer_freq = 30
Long	                il_timer_max 
Long		il_timer_count

//	array of all created datastores for reconnection
n_ds		ids_reconnect[]
end variables

forward prototypes
public function integer of_setsheetmanager (boolean ab_switch)
public function long of_set_child_response (w_master aw_window)
public function integer of_move_statusbar ()
public subroutine of_set_timer_ctr (long al_sec)
end prototypes

event disconnect_connect();//************************************************************************
//		Object Type:	Window
//		Object Name:	w_main
//		Event Name:		disconnect_connect
//
//		This event is triggered by the idle event in the application
//
//		This event will disconnect from Stars1ca and Stars2ca and display
//		a messagebox.  When the user clicks ok, Stars1ca and Stars2ca will
//		be reconnected to.
//
//************************************************************************
//
// 06-06-96 FNC	Allow user to directly exit STARS
//	06/28/96 FDG	Turn the Idle off until the user clicks OK to reconnect.
//						Then turn the idle back on.  This will prevent this
//						script from executing multiple times while waiting for
//						the user to reconnect.
//	04/29/98	FDG	Track 1118.  Use the n_tr functions to disconnect and
//						to connect.
//	08/07/98	FDG	Track 1118.  Reconnect to all child and response
//						windows (in addition to sheet windows).
//	01/15/99	FDG	Track 2041c.  Compare the PC and server date when
//						reconnecting.
//	02/03/00 FNC	Connect and disconnect to new transaction added for user
//						message checking
// 02/16/00 FNC	Stop timer event from ocurring while user is disconnected
//						from Stars.
// 10/06/00 GaryR 2314d Timing out with pending updates or a response
//								window up causes GPF
// 10/06/00 GaryR 2315d HIPAA Compliance
//	02/22/01	FDG	Stars 4.7.  Disconnect from Stars Server.
//	09/14/01	GaryR	Track 2430d	PB's Idle() method causes memory corruption
//	04/09/02	FDG	Track 4141c.  Don't call killusersession.  Destroying gole_server
//						gracefully shuts down Stars Server.  Also, reset the idle time.
//						Move timer(0) to beginning of script in case it takes a while
//						to destroy the connections and gole_server.
//	05/20/02	GaryR	Track 3073d	PB7 memory corruption on Idle()
//										Changed Method signature.
// 08/12/02	Jason	Track 3027d  Add window name to timer(0), also turn off time
//							window timer
//	08/15/02	Jason	Track 3098d  Turn Idle back on right after it gets a successful
//							reconnection to the server
//	02/19/04	GaryR	Track 3869d	Reestablish DB connection to datastores on reconnect
//	01/12/05	GaryR	Track 4088d	Display last login timestamp and status
//************************************************************************

Integer	li_rc
Long		ll_upper,		&
			ll_idx,			&
			ll_rc

//	09/14/01	GaryR	Track 2430d
gnv_app.of_set_idle( FALSE )							//FDG 06/28/96

// JasonS 08/12/02 Begin - Track 3027d
//timer(0)			// FNC 02/16/00
timer(0, w_main)
timer(0, w_time_microhelp)
// JasonS 08/12/02 End - Track 3027d

li_rc	=	Stars1ca.of_disconnect()

li_rc	=	Stars2ca.of_disconnect()

li_rc	=	Starsusermsg.of_disconnect()	// FNC 02/03/00

// FDG 04/09/02 begin
//li_rc	=	gnv_app.of_KillUserSession()	// FDG 02/22/01 - Shutdown Stars Server for this user.
IF IsValid(gole_server)	THEN
	Destroy	gole_server
END IF

// 10/06/00 GaryR 2315d Begin
OpenWithParm( w_sign_on, -2 )
li_rc = Message.DoubleParm
SetNull( Message.DoubleParm )

// Immediately exit out of the system.
IF li_rc <> 1 THEN HALT	//10/06/00 GaryR 2314d

// JasonS 08/15/02 Begin - Track 3098d
gnv_app.of_set_idle( TRUE )
// JasonS 08/15/02 End - Track 3098d
// 10/06/00 GaryR 2315d End

// FDG 01/15/99 begin

n_cst_datetime		lnv_datetime

IF	lnv_datetime.of_IsValidPCDate()	=	FALSE		THEN
	// PC Date not close to server date and the user wants to exit the app.
	close(w_main)
	Return
END IF

// FDG 01/15/99 end

// FDG 04/29/98	begin

// Do a SetTransobject on every d/w on every window

w_master		lw_window
Boolean		lb_valid

lw_window		=	This.GetFirstSheet()
lb_valid			=	IsValid (lw_window)

DO WHILE lb_valid
	li_rc			=	lw_window.Event	ue_reconnect (lw_window.control)
	lw_window	=	This.GetNextSheet (lw_window)
	lb_valid		=	IsValid (lw_window)
LOOP

// FDG 04/29/98

// FDG 08/07/98	begin

// Reconnect to all opened response and child windows
ll_upper			=	UpperBound (istr_window)

FOR ll_idx		=	1	TO	ll_upper
	IF	IsValid (istr_window[ll_idx].w_window)		THEN
		lw_window	=	istr_window[ll_idx].w_window
		li_rc			=	lw_window.Event	ue_reconnect (lw_window.control)
	END IF
NEXT

// FDG 08/07/98	end

// Reconnect all valid datastores
ll_upper = UpperBound( ids_reconnect )

FOR ll_idx = 1 TO ll_upper
	IF IsValid( ids_reconnect[ll_idx] ) THEN
		li_rc = ids_reconnect[ll_idx].Event ue_reconnect()
	END IF
NEXT

// JasonS 08/12/02 Begin - Track 3027d
timer(il_timer_freq, w_main)
timer(30, w_time_microhelp)
// JasonS 08/12/02 End - Track 3027d
end event

event ue_get_timermax;//***********************************************************
//	Script:	w_main.ue_get_timermax
//	
//	Description:
//		Retrieves the time that should pass before the user
//		message table is retrieved in the timer event. This 
//		event is called from the ok button on the sign on window
//
//***********************************************************
//	Revision History:
//
//	11/18/99 FNC Created
//	
//***********************************************************

u_nvo_sys_cntl	lnv_sys_cntl

lnv_sys_cntl	=  CREATE u_nvo_sys_cntl				// FNC 11/17/99 Start
lnv_sys_cntl.of_set_cntl_id ('TIMERMAX')
il_timer_max  =  lnv_sys_cntl.of_get_cntl_no()
Destroy(lnv_sys_cntl)										// FNC 11/17/99 End
end event

event ue_open_user_messages;//*********************************************************************
//	Script:	w_main.ue_open_user_messages
//
//	Description: Open w_user_message_list
// 
//*********************************************************************
//	History
//
//	FDG	04/12/00	When opening w_user_message_list, post this event so that
//						any existing processing that may have occured can
//						complete before opening the window.
//
//*********************************************************************


//OpenSheetWithParm (w_user_message_list,gc_user_id,mdi_main_frame,help_menu_position,Layered!)

gnv_app.of_set_user_messages (TRUE)

end event

public function integer of_setsheetmanager (boolean ab_switch);//***************************************************************
//	Function:	of_SetSheetManager
//
//	Arguments:	ab_switch - Create/destroy the service
//
//	Returns:		Integer
//					 1 = Successful
//					 0 = No action
//					-1 = An error occured
//
//	Description:
//		Start or stop the sheet manager service
//
//***************************************************************

Integer		li_rc

//	Check arguments
IF	IsNull (ab_switch)		THEN
	Return -1
END IF

IF	ab_switch		THEN
	IF	IsNull (inv_sheetmanager)				&
	OR	NOT	IsValid (inv_sheetmanager)		THEN
		inv_sheetmanager	=	CREATE	n_cst_winsrv_sheetmanager
		inv_sheetmanager.of_SetRequestor (This)
		li_rc	=	1
	END IF
ELSE
	IF	IsValid (inv_sheetmanager)				THEN
		DESTROY	inv_sheetmanager
		li_rc	=	1
	END IF
END IF

Return li_rc

	
end function

public function long of_set_child_response (w_master aw_window);//***************************************************************
//	Function:	of_set_child_response
//
//	Arguments:	aw_window - the child/response window to register
//
//	Returns:		Long - A unique handle to the window
//
//	Description:
//		Register the child/popup/response window.  If the user times
//		out, then a SetTransobject can be performed to these
//		windows.
//
//***************************************************************

Long		ll_upper

il_window_handle ++

ll_upper	=	UpperBound (istr_window)

ll_upper ++

istr_window[ll_upper].w_window	=	aw_window
istr_window[ll_upper].l_handle	=	il_window_handle

Return	il_window_handle

end function

public function integer of_move_statusbar ();//********************************************************************
//	Script:	of_move_statusbar
//
//	Returns:	Integer (1=successful, -1=unsuccessful)
//
//	Description:
//		This function moves the status bar (w_time_microhelp) as the
//		frame window is moved.
//
//********************************************************************
//
// 10/22/08	GaryR	SPR 5531	Modernize the STARS Frame Menu and Toolbar
//
//********************************************************************

Integer	li_xpos,				&
			li_ypos
			
IF	NOT IsValid (w_time_microhelp)	THEN
	Return -1
END IF
			
li_xpos	=	This.x	+	This.width	-	w_time_microhelp.width
li_ypos	=	This.y	+	This.Height	-	MDI_1.MicroHelpHeight - 16

w_time_microhelp.y	=	li_ypos
w_time_microhelp.x	=	li_xpos

Return 1
end function

public subroutine of_set_timer_ctr (long al_sec);//	09/05/01	GaryR	Stars 4.8	WIC #6 FS50-001	Case Reassignment
il_timer_count = al_sec
end subroutine

event open;//***********************************************************
//	Script:	w_main.open - Override the ancestor
//	
//	Description:
//		Open the frame window for STARS.
//
//***********************************************************
//	Revision History:
//
//	FDG	07/01/97	Store the menu in gnv_app.
//
//	FDG	10/16/97	Register this window to w_time_microhelp
//
// FNC	11/17/99	Stop triggering timer event because code
//						in timer now accesses database and can't
//						access database until after sign on when
//						connect is performed.
// 10/22/08	GaryR	SPR 5531	Modernize the STARS Frame Menu and Toolbar
//
//***********************************************************


w_time_microhelp.visible = TRUE

timer(il_timer_freq)
w_time_microhelp.triggerevent(timer!)		// FNC 11/17/99

inv_count		= 	CREATE u_nvo_count		// FNC 11/17/99

gnv_app.of_set_frame (This)					//	FDG 07/01/97
end event

event toolbarmoved;//KMM 7/25/95 Prob#692
// 10/22/08	GaryR	SPR 5531	Modernize the STARS Frame Menu and Toolbar

this.triggerevent(resize!)
end event

event resize;// 10/22/08	GaryR	SPR 5531	Modernize the STARS Frame Menu and Toolbar

Integer	li_width, li_height, li_x, li_y
Boolean	lb_visible
ToolbarAlignment	lta_align

IF	NOT IsValid (w_time_microhelp)	THEN
	open(w_time_microhelp)
END IF

This.of_move_statusbar()				//	FDG	10/16/97

li_width  = this.WorkSpaceWidth()
li_height = this.WorkSpaceHeight()
li_height = li_height - MDI_1.MicroHelpHeight
MDI_1.Resize( li_width, li_height )

This.GetToolbar ( 1, lb_visible, lta_align )

IF lb_visible THEN
	CHOOSE CASE lta_align
		CASE AlignAtLeft!
			li_x = 115
			li_y = 0
		CASE AlignAtTop!
			li_x = 0
			li_y = 115
		CASE ELSE
			li_x = 0
			li_y = 0
			li_width = This.width
	END CHOOSE
ELSE
	li_x = 0
	li_y = 0
	li_width = This.width
END IF

MDI_1.Move( li_x, li_y )

w_master	lw_active_sheet
lw_active_sheet = This.GetActiveSheet()
IF IsValid(lw_active_sheet ) THEN lw_active_sheet.event resize( sizetype, li_width, li_height )
end event

event timer;//*********************************************************************
//	Script:	w_main.timer
//
//	Description:
// 
//*********************************************************************
//	History
//
//	FNC	11/17/99	Once the maximum amount of time is reached 
//						(stored in il_timer_max), determine if this user has 
//						any new messages.  If so, automatically open window 
//						w_user_message_list.
//
// FNC	02/03/00 Set transaction in u_nvo_count to new transaction used by the
//						timer even to check if user has messages on the user
//						message table
//
//	FDG	04/12/00	When opening w_user_message_list, post an event so that
//						any existing processing that may have occured can
//						complete before opening the window.
//
//	FDG	03/23/01	Stars 4.7.	Call a Stars Server method to prevent Stars
//						Server from timing out.
//
//*********************************************************************

string 	ls_count

long 		ll_count,			&
			ll_rc
			
u_nvo_sys_cntl	lnv_sys_cntl
n_tr ltr_stars2count
u_nvo_count lnv_count									// FNC 02/03/00 Start

if trim(gc_user_id) <> '' then
	lnv_count = create u_nvo_count
	
	lnv_count.uf_set_transaction (StarsUserMsg)	// FNC 02/03/00 End
		
	il_timer_count  =  il_timer_count  +  il_timer_freq		
	IF  il_timer_count  >=  il_timer_max  THEN
		// FDG 03/23/01 - Call a Stars Server method to keep it from timing out
		IF	 IsValid (gole_server)		&
		AND IsValid (gnv_server)		THEN
			ll_rc		=	gnv_server.of_PreventTimeOut()
		END IF
		// FDG 03/23/01 end
		il_timer_count  =  0
		ls_count  =  "select count(*) from user_message where user_id = '" + &
				Upper( gc_user_id )  +  "' and message_status = 'A'"
		ll_count  =  lnv_count.uf_get_count (ls_count)
		StarsUserMsg.of_commit()						// FDG 04/17/00
		IF  ll_count  >  0  THEN
			// FDG 04/12/00 - Post an event to open w_user_message_list
			//OpenSheetWithParm(w_user_message_list,gc_user_id,mdi_main_frame,help_menu_position,Layered!)
			This.Post	Event	ue_open_user_messages()
		END IF
	END IF			
	
	destroy(lnv_count)			// FNC 02/03/00
end if

w_time_microhelp.triggerevent(timer!)

end event

event close;call super::close;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 03/07/94 JMS  Moved all code to close of application.
//	08/07/98	FDG	Destroy the array of opened response/child windows
//***********************************************************************

//	Destroy any services previously created (FDG - 6/17/97)

//HRB comment out for compile - 95/97
//of_SetStatusBar (FALSE)

of_SetSheetManager (FALSE)


//sqlcmd('connect', stars2ca,'Error connecting to the database',5)
//
//update users
//	set trk_dflt = :gv_trk_dflt,
//		 src_dflt = :gv_src_dflt,
//		 cri_dflt = :gv_cri_dflt,
//		 tbl_dflt = :gv_tbl_dflt,
//		 DCT_dflt = :gv_dct_dflt,
//		 cod_dflt = :gv_cod_dflt,
//      last_case = :gv_active_case,
//    last_subset = :gv_active_subset
//	where user_id = :gc_user_id
//	using stars2ca;
//			
//if stars2ca.of_check_status() <> 0 then
//	errorbox(stars2ca,'Error updating the user table');
//else
//	sqlcmd('disconnect', stars2ca,'Error disconnecting from the database',1)
//end if
close(w_time_microhelp)

// FDG 08/07/98	begin

str_window	lstr_window[]

istr_window	=	lstr_window

destroy  inv_count				// FNC 11/17/99

// FDG 08/07/98	end

end event

on w_main.create
int iCurrent
call super::create
if this.MenuName = "m_stars_30" then this.MenuID = create m_stars_30
this.mdi_1=create mdi_1
this.dw_stars_rel_dict=create dw_stars_rel_dict
this.sle_active_invoice=create sle_active_invoice
this.sle_datetime=create sle_datetime
this.cb_open_window=create cb_open_window
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
this.Control[iCurrent+2]=this.dw_stars_rel_dict
this.Control[iCurrent+3]=this.sle_active_invoice
this.Control[iCurrent+4]=this.sle_datetime
this.Control[iCurrent+5]=this.cb_open_window
end on

on w_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.dw_stars_rel_dict)
destroy(this.sle_active_invoice)
destroy(this.sle_datetime)
destroy(this.cb_open_window)
end on

event move;call super::move;//***************************************************************
//	Event:	Move (pbm_move)
//
//	Description:
//		Notify the statusbar that the window has moved
//
//***************************************************************

This.of_move_statusbar()		//	FDG	10/16/97


end event

event activate;call super::activate;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

w_master	lw_active_sheet

lw_active_sheet = This.GetActiveSheet()
IF IsValid( lw_active_sheet ) THEN lw_active_sheet.event activate()
end event

type mdi_1 from mdiclient within w_main
string accessiblename = "STARS Main Window"
string accessibledescription = "STARS Main Window"
accessiblerole accessiblerole = clientrole!
long BackColor=67108864
end type

type dw_stars_rel_dict from u_dw within w_main
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = clientrole!
integer x = 1303
integer y = 604
integer width = 165
integer height = 248
integer taborder = 20
boolean enabled = false
string dataobject = "d_stars_rel_dict"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_active_invoice from singlelineedit within w_main
string accessiblename = "Active Invoice"
string accessibledescription = "Active Invoice"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
string tag = "colorfixed"
boolean visible = false
integer x = 2464
integer y = 1668
integer width = 480
integer height = 64
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
boolean hideselection = false
end type

type sle_datetime from singlelineedit within w_main
string accessiblename = "Date Time"
string accessibledescription = "Date Time"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
string tag = "colorfixed"
boolean visible = false
integer x = 1897
integer y = 1668
integer width = 549
integer height = 64
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long backcolor = 67108864
string text = " "
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
boolean hideselection = false
end type

type cb_open_window from commandbutton within w_main
boolean visible = false
string accessiblename = "open window"
string accessibledescription = "open window"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 869
integer y = 1460
integer width = 69
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "open window"
end type

event clicked;//********************************************************************
//06-01-95 FNC Change open for report selection to open sheet so that
//             the window goes away when the application is exited.
//01-13-99 AJS Add ability to random sample ML invoice subsets
//04-14-00 GR	
//********************************************************************

string lv_win_id,lv_string,lv_temp,lv_parm
long tabpos

sx_summary_parm lv_sum_parm
sx_rand_samp_selection lsx_rand_samp_selection	//ajs 01-13-99

if len(trim(iv_test)) < 1 then
	messagebox("PROGRAM ERROR","No parm set to menu item m_openwindow")
	return
end if

tabpos = pos(iv_test,'~t')
if tabpos > 0 then
	lv_win_id = mid(iv_test,1,tabpos - 1)
	lv_temp = mid(iv_test,tabpos + 1)
	tabpos = pos(lv_temp,'~t')
   iv_invoice_type = left(lv_temp,tabpos - 1)
   lv_string = mid(lv_temp,tabpos + 1)
end if

//john_wo 11/13/97 added the following If statement.
//   win_to_open contains the name of the prior window that was opened.
If IsValid(win_to_open) Then
	is_opened_window = ClassName(win_to_open)
End If
If IsNull(is_opened_window) or is_opened_window <= ' ' Then
Else
	If lv_win_id <> is_opened_window Then
		win_to_open = win_to_open_clear
	End If
End If
//
//If lv_win_id = 'W_SUMMARY_ANALYSIS' Then
//  OpensheetWithParm(w_summary_analysis,gv_active_invoice,MDI_main_frame,help_menu_position,layered!)
//ElseIf lv_win_id = 'W_SUMMARY_A_INPATIENT' Then
//  lv_sx_summ_a.invoice_type = gv_active_invoice
//  lv_sx_summ_a.desc_string = lv_string
//  OpenSheetWithParm(w_summary_a_inpatient,lv_sx_summ_a,MDI_main_frame,help_menu_position,layered!)
if lv_win_id = 'W_RPT_SELECTION' then
	lv_parm = gv_active_invoice				//KMM 7/11/95 Prob#437-441 Need to pass invoice type
   OpenSheetWithParm(w_rpt_selection,lv_parm,MDI_main_frame,help_menu_position,original!)   //06-01-95 FNC
   return
ElseIf lv_win_id = 'W_SUMMARY_FINANCIAL' then
	lv_sum_parm.invoice_type = gv_active_invoice
	lv_sum_parm.header = lv_string
	OpenSheetWithParm(w_summary_financial,lv_sum_parm,MDI_main_frame,help_menu_position,layered!)
//ajs 01-13-99 begin
ElseIf lv_win_id = 'W_RANDOM_SAMPLING_SELECTION' then
	lsx_rand_samp_selection.invoice_type = gv_active_invoice
	lsx_rand_samp_selection.subc_id = gc_active_subset_id 	//GR 4.5	04/14/2000 1741c subset_id is populated by global
	lsx_rand_samp_selection.case_id = left(gc_active_subset_case,10)
	lsx_rand_samp_selection.case_spl = mid(gc_active_subset_case,11,2)
	lsx_rand_samp_selection.case_ver = mid(gc_active_subset_case,13,2)
	OpenSheetWithParm(w_random_sampling_selection,lsx_rand_samp_selection,MDI_main_frame,help_menu_position,layered!)
//ajs 01-13-99 end
ElseIf iv_invoice <> '' then
// This section will open any window that does not need the global invoice type set
// the iv_invoice_type is being set form cb_select in w_invoice_selection
// You must have iv_invoice set iv_invoice_type here so it can be cleared out
// prior to the open statement to avoid GPFs.
  iv_invoice_type = iv_invoice
  iv_invoice = ''
  OpenSheetWithParm(win_to_open,iv_invoice_type,lv_win_id,MDI_main_frame,help_menu_position,layered!)      
Else
  OpenSheetWithParm(win_to_open,gv_active_invoice,lv_win_id,MDI_main_frame,help_menu_position,layered!)
End If

end event

