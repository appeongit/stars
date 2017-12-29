$PBExportHeader$w_user_message_list.srw
$PBExportComments$Display the messages for a user
forward
global type w_user_message_list from w_master
end type
type dw_message from u_dw within w_user_message_list
end type
type cb_delete from u_cb within w_user_message_list
end type
type cb_close from u_cb within w_user_message_list
end type
type ddlb_dw_ops from u_ddlb within w_user_message_list
end type
type st_1 from statictext within w_user_message_list
end type
type st_count from statictext within w_user_message_list
end type
type dw_user_msg_desc from u_dw within w_user_message_list
end type
type cbx_all_users from checkbox within w_user_message_list
end type
type cbx_new_messages from checkbox within w_user_message_list
end type
end forward

global type w_user_message_list from w_master
string accessiblename = "User Message List"
string accessibledescription = "User Message List"
integer width = 4485
integer height = 1764
string title = "User Message List"
event ue_prev_messages ( )
dw_message dw_message
cb_delete cb_delete
cb_close cb_close
ddlb_dw_ops ddlb_dw_ops
st_1 st_1
st_count st_count
dw_user_msg_desc dw_user_msg_desc
cbx_all_users cbx_all_users
cbx_new_messages cbx_new_messages
end type
global w_user_message_list w_user_message_list

type variables
// 09/05/01 GaryR
boolean ib_added_messages

end variables

event ue_prev_messages;//*********************************************************************
//	Script:	w_user_message_list.ue_prev_messages
//
//	Description:
// This event unfilters dw_message to show the previously displayed messages.
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//	FNC	03/16/00	Track 2155 Stardev. Make delete button invisible 
//						when prev messages are displayed.
// FNC	03/30/00	Track 2084. Change row count when prev messages are
//						displayed.
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//*********************************************************************

Long	ll_rowcount	//	GaryR	09/05/01	Stars 4.8

dw_message.SetRedraw (FALSE)

//	GaryR	09/05/01	Stars 4.8 - Begin
IF cbx_new_messages.Checked THEN	
	dw_message.SetFilter( "message_status = 'A'" )
	dw_message.Filter()
	//dw_message.SetSort('user_id A, message_datetime D')
	//dw_message.Sort()
ELSE	
	dw_message.SetFilter( "" )
	dw_message.Filter()
END IF

dw_message.SetRedraw (TRUE)

//	GaryR	09/05/01	Stars 4.8 - Begin
//cb_delete.visible = FALSE		// FNC 03/16/00
//st_count.text = string(dw_message.Rowcount())	// FNC 03/30/00
//SetMicroHelp ( w_main, 'Displayed Messages are marked for deletion' )	// FNC 03/16/00
//	GaryR	09/05/01	Stars 4.8 - End

ll_rowcount  =  dw_message.Rowcount()
IF ll_rowcount > 0 THEN
	dw_message.ShareData( dw_user_msg_desc )
	dw_message.EVENT RowFocusChanged( 1 )
ELSE
	dw_user_msg_desc.ShareDataOff()
	cb_delete.enabled = FALSE
END IF

st_count.text = string(ll_rowcount)
//	GaryR	09/05/01	Stars 4.8 - End
end event

on w_user_message_list.create
int iCurrent
call super::create
this.dw_message=create dw_message
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_1=create st_1
this.st_count=create st_count
this.dw_user_msg_desc=create dw_user_msg_desc
this.cbx_all_users=create cbx_all_users
this.cbx_new_messages=create cbx_new_messages
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_message
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.ddlb_dw_ops
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_count
this.Control[iCurrent+7]=this.dw_user_msg_desc
this.Control[iCurrent+8]=this.cbx_all_users
this.Control[iCurrent+9]=this.cbx_new_messages
end on

on w_user_message_list.destroy
call super::destroy
destroy(this.dw_message)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.ddlb_dw_ops)
destroy(this.st_1)
destroy(this.st_count)
destroy(this.dw_user_msg_desc)
destroy(this.cbx_all_users)
destroy(this.cbx_new_messages)
end on

event ue_delete;//*********************************************************************
//	Script:	w_user_message_list.ue_delete
//
//	Description:
// This event overrides the ancestor and will update the highlighted row
// in dw_message and save the data.  
//
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
// MikeFl 09/04/02 Track 3713c	Disable Delete button if no rows left.
//
//*********************************************************************

long 		ll_row
string	ls_save_msg

// Flag the current row as displayed.
ll_row  =  dw_message.GetRow()
IF  ll_row  >  0  THEN
ls_save_msg		=	is_save_successful_msg
is_save_successful_msg	=	'Message deleted'
		dw_message.object.message_status [ll_row]  =  'X'
		dw_message.object.message_datetime [ll_row]  =  gnv_app.of_get_server_date_time()
	This.Event	ue_save()
	is_save_successful_msg	=	ls_save_msg
END IF

// MikeFl 9/4/02 Track 3713 - Begin
ll_row  =  dw_message.Rowcount() 
IF ll_row = 0 THEN
	cb_delete.enabled = FALSE
END IF
// MikeFl 9/4/02 Track 3713 - End
end event

event ue_preopen;///////////////////////////////////////////////////////////////////
//
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//
///////////////////////////////////////////////////////////////////

//	GaryR	09/05/01	Stars 4.8 - Begin
//is_userid = Message.StringParm
IF	Message.DoubleParm = 1 THEN ib_added_messages = TRUE
SetNull( Message.DoubleParm )
//	GaryR	09/05/01	Stars 4.8 - End


end event

event ue_retrieve;//*********************************************************************
//	Script:	w_user_message_list.ue_retrieve
//
//	Description:
// Retrieve data
//
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
// FNC	03/27/00 Track 2166 Starsdev - Display message in a separate
//						datawindow so user can view entire message at the 
//						same time.
//	FNC	04/18/00 Problem with messages not always displaying in the
//						description datawindow
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//*********************************************************************

long ll_rowcount
integer li_rc

dw_message.SetRedraw (FALSE)						// FNC 04/18/00 
dw_user_msg_desc.ShareDataOff()					//	GaryR	09/05/01	Stars 4.8

//	GaryR	09/05/01	Stars 4.8 - Begin
IF cbx_all_users.Checked THEN
	ll_rowcount  =  dw_message.Retrieve( '%' )
	//dw_message.SetFilter ("")
	//dw_message.Filter()	
ELSE	
	//ll_rowcount  =  dw_message.Retrieve()
	ll_rowcount  =  dw_message.Retrieve( gc_user_id )		
//	st_count.text = string(ll_rowcount)
//	IF ib_added_messages  THEN
//		ib_added_messages = FALSE
//		dw_message.SetFilter ("")
//		dw_message.Filter()
//		dw_message.SetFilter ("message_status = 'A'")
//		dw_message.Filter()
//	END IF
END IF

dw_message.ShareData (dw_user_msg_desc)		// FNC 03/29/00
dw_message.SetRedraw (TRUE)						// FNC 04/18/00 

ll_rowcount  =  dw_message.Rowcount()
IF ll_rowcount > 0 THEN
	dw_message.EVENT RowFocusChanged( 1 )
ELSE
	dw_user_msg_desc.ShareDataOff()
	cb_delete.enabled = FALSE
END IF
//	GaryR	09/05/01	Stars 4.8 - End

st_count.text = string(ll_rowcount)
end event

event open;call super::open;//*********************************************************************
//	Script:	w_user_message_list.open
//
//	Description:
// If the admin is opening the window (is_userid = 'ADMIN'), then set the 
// datawindow object for dw_message to 'd_user_message_list_all' so that 
// column user_id can also be displayed.  If 'ADMIN' is not the user ID 
// passed, then disable and hide cb_delete and cb_all_users.
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
// FNC	03/27/00 Track 2166 Stardev - Display message in a separate
//						datawindow so user can view entire message at the 
//						same time.
// FNC	04/11/00	Track 2181 Stardev Release 4.5 Display microhelp
// FNC	04/17/00	Commit after retrieving datawindow.
//	FDG	04/27/00	Sort by user_message_id instead of datetime
//						because datetime only includes hours and minutes.
//						Also, there can now be multiple messages for a single
//						job.
//	FDG	05/05/00	Set dw_message as the print d/w so that both d/ws don't
//						get printed.
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//*********************************************************************


//	GaryR	09/05/01	Stars 4.8 - Begin
String	ls_user_sl
//string	ls_where,	&
//			ls_sql,
//	GaryR	09/05/01	Stars 4.8 - End
integer li_rc

// Set dw_message as the print d/w
This.of_SetPrintDW (dw_message)

// Fill in the Window Operations entries
This.Event	ue_load_ddlb_dw_ops (ddlb_dw_ops, 'S', 'P')

//Set the Where and Order By clause based on the contents of is_userid. 
//	GaryR	09/05/01	Stars 4.8 - Begin
//if is_userid = 'ADMIN' THEN
//	dw_message.dataobject = 'd_user_message_list_all'
//	dw_user_msg_desc.dataobject = 'd_user_msg_desc_all'			// FNC 03/29/00
//else
//	dw_message.dataobject = 'd_user_message_list'
//	ls_where  =  " WHERE user_id = '"  +  is_userid  +  "' "
//	dw_user_msg_desc.dataobject = 'd_user_msg_desc'			// FNC 03/29/00
//end if
//	GaryR	09/05/01	Stars 4.8 - End

li_rc = dw_message.SetTransObject(stars2ca)

if li_rc = -1 Then
	errorbox(starsusermsg,'Error connecting to the datawindow')	// FNC 04/12/00
	return
end if

//	GaryR	09/05/01	Stars 4.8 - Begin
//	GaryR	09/05/01	Stars 4.8 - Moved the sorting to DW level in d_user_message_list
//is_orig_sql  =  dw_message.GetSQLSelect()
////is_orderby  =  " ORDER BY user_id Asc, message_datetime Desc"
//is_orderby  =  " ORDER BY user_id Asc, user_message_id Asc"
//ls_sql  =  is_orig_sql +  ls_where  +  is_orderby
//dw_message.SetSQLSelect (ls_sql)
//	GaryR	09/05/01	Stars 4.8 - End

//Retrieve the data. 
This.Event	ue_retrieve()
stars2ca.of_commit()									// FNC 04/17/00

//	GaryR	09/05/01	Stars 4.8 - Begin
//if is_userid <> 'ADMIN' then
//	cb_delete.hide()
//end if

cbx_all_users.Enabled = (gv_user_sl = "AD")
cbx_new_messages.Checked = ib_added_messages
THIS.Event ue_prev_messages()
//	GaryR	09/05/01	Stars 4.8 - End

SetMicroHelp ( w_main, 'See Job Status List for additional details' )	// FNC 04/11/00




end event

event closequery;//*********************************************************************
//	Script:	w_user_message_list.closequery
//
//	Description:
// Overrides the ancestor closequery event so that data can be updated 
// before saving it.
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//	FDG	04/20/00	Disable the icon in w_time_microhelp
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//
//*********************************************************************

long 	ll_rowcount,	&
		ll_row
		
string 	ls_status,	&
			ls_userid

is_save_successful_msg = 'Ready'

//	GaryR	09/05/01	Stars 4.8 - Begin
dw_message.SetRedraw( FALSE )
dw_message.SetFilter( "message_status = 'A' and user_id = '" + Upper( gc_user_id ) + "'" )
dw_message.Filter()
//	GaryR	09/05/01	Stars 4.8 - End

ll_rowcount  =  dw_message.RowCount()

//	GaryR	09/05/01	Stars 4.8 - Begin
IF ll_rowcount > 0 THEN
	FOR  ll_row  =  1  TO  ll_rowcount		
		//ls_status  =  dw_message.object.message_status [ll_row]
		//ls_userid  = dw_message.object.user_id [ll_row]
		//IF  ls_status = 'A'  AND ls_userid  =  is_userid  THEN
			// Message added.  Change to 'Displayed'
			dw_message.object.message_status [ll_row]  =  'D'
			dw_message.object.message_status_datetime [ll_row]  =  gnv_app.of_get_server_date_time()
		//END IF
	NEXT
	This.Event  ue_save()
END IF

dw_message.SetRedraw( TRUE )
//	GaryR	09/05/01	Stars 4.8 - End

gnv_app.of_set_user_messages (FALSE)
end event

type dw_message from u_dw within w_user_message_list
string accessiblename = "Message List"
string accessibledescription = "Message List"
integer x = 14
integer y = 12
integer width = 4416
integer height = 1116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_user_message_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;//This.SetTransObject (Stars2ca)		// FNC 04/12/00

// Single-select rows
This.of_SingleSelect (TRUE)

// Update this datawindow as soon as a row is deleted.
This.of_SetSingleRow (TRUE)

end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************
//	script:	w_user_message_list.dw_message.RowFocusChanged
//
//	Description:
// 
//*********************************************************************
//	History
//
//	FNC	11/17/99	Created
//
// FNC	03/27/00 Track 2166 Starsdev - Display message in a separate
//						datawindow so user can view entire message at the 
//						same time.
//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
//*********************************************************************

//	GaryR	09/05/01	Stars 4.8  - Begin
Long	ll_row, ll_msg_id, ll_msg_row

ll_row = THIS.GetRow()
IF ll_row < 1 THEN
	dw_user_msg_desc.ShareDataOff()
	cb_delete.Enabled = FALSE
	Return	
END IF

cb_delete.Enabled = THIS.GetItemString( ll_row, "user_id" ) = gc_user_id

//IF	currentrow	>	0		THEN
//	dw_user_msg_desc.ScrollToRow (currentrow)
//END IF

ll_msg_id = THIS.GetItemNumber( ll_row, "user_message_id" )
ll_msg_row = dw_user_msg_desc.Find( "user_message_id = " + String( ll_msg_id ), 1, dw_user_msg_desc.RowCount() )
IF ll_msg_row < 1 THEN	Return

dw_user_msg_desc.ScrollToRow( ll_msg_row )
//	GaryR	09/05/01	Stars 4.8 - End

end event

event doubleclicked;w_user_message_list	lw_parent

This.of_GetParentWindow (lw_parent)

lw_parent.of_window_operations(this ,row, dwo)
end event

type cb_delete from u_cb within w_user_message_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 3744
integer y = 1520
integer width = 311
integer height = 124
integer taborder = 50
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;Parent.event	ue_delete()
Parent.event	ue_retrieve()

end event

type cb_close from u_cb within w_user_message_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 4078
integer y = 1520
integer width = 311
integer height = 124
integer taborder = 60
boolean bringtotop = true
string text = "&Close"
boolean cancel = true
end type

event clicked;Close (Parent)
end event

type ddlb_dw_ops from u_ddlb within w_user_message_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
integer x = 366
integer y = 1544
integer taborder = 20
boolean bringtotop = true
end type

event selectionchanged;w_user_message_list	lw_parent

This.of_GetParentWindow (lw_parent)

is_operation = this.text

lw_parent.event ue_set_window_operations()


end event

type st_1 from statictext within w_user_message_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 370
integer y = 1472
integer width = 791
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type st_count from statictext within w_user_message_list
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 1532
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_user_msg_desc from u_dw within w_user_message_list
string accessiblename = "User Message Description"
string accessibledescription = "User Message Description"
integer x = 14
integer y = 1148
integer width = 4416
integer height = 328
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_user_msg_desc"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	dw_list_desc.Constructor
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	This d/w is not updateable.
//
//*********************************************************************************
//	
// 03/29/00		Stars 4.5	Created
//
//*********************************************************************************

This.of_SetUpdateable (FALSE)


end event

type cbx_all_users from checkbox within w_user_message_list
string accessiblename = "View other users messages"
string accessibledescription = "View other users messages"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1458
integer y = 1572
integer width = 1586
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "&View other users~' messages"
end type

event clicked;PARENT.EVENT ue_retrieve()		//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
end event

type cbx_new_messages from checkbox within w_user_message_list
string accessiblename = "View new user messages"
string accessibledescription = "View new user messages"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1458
integer y = 1496
integer width = 1449
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "&View new user messages"
end type

event clicked;parent.event ue_prev_messages()	//	GaryR	09/05/01	Stars 4.8	WIC #6 FS50-001	Case Reassignment
end event

