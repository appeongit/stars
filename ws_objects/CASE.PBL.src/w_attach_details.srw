$PBExportHeader$w_attach_details.srw
forward
global type w_attach_details from w_master
end type
type cb_close from u_cb within w_attach_details
end type
type dw_details from u_dw within w_attach_details
end type
end forward

global type w_attach_details from w_master
long backcolor = 67108864
string accessiblename = "Attachment Details"
string accessibledescription = "Attachment Details"
accessiblerole accessiblerole = windowrole!
integer width = 2062
integer height = 928
string title = "Attachment Details"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
cb_close cb_close
dw_details dw_details
end type
global w_attach_details w_attach_details

on w_attach_details.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_details=create dw_details
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_details
end on

on w_attach_details.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_details)
end on

event ue_preopen;call super::ue_preopen;//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	10/30/06	GaryR	Track 3153	Minor changes to reflect the finalized requirements
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

String	ls_fileid, ls_empty
String	ls_case_id, ls_case_spl, ls_case_ver

ls_fileid = Message.StringParm
SetNull( Message.StringParm )

// Parse values
ls_case_id = Mid( ls_fileid, 11 )
ls_fileid = Left( ls_fileid, 10 )

// Check the argument
IF IsNull( ls_fileid ) OR Trim( ls_fileid ) = "" THEN
	MessageBox( "ERROR", "Invalid File ID argument passed to view Attachment Details", StopSign! )
	cb_close.PostEvent( Clicked! )
ELSEIF IsNull( ls_case_id ) OR Trim( ls_case_id ) = "" THEN
	MessageBox( "ERROR", "Invalid Case ID argument passed to view Attachment Details", StopSign! )
	cb_close.PostEvent( Clicked! )
ELSE
	ls_case_spl = Trim( Mid( ls_case_id, 11, 2 ) )
	ls_case_ver = Trim( Mid( ls_case_id, 13, 2 ) )
	ls_case_id = Trim( Left( ls_case_id, 10 ) )
	
	gnv_sql.of_trimdata( ls_case_spl )
	gnv_sql.of_trimdata( ls_case_ver )
	
	dw_details.SetTransObject( Stars2ca )
	IF dw_details.Retrieve( ls_fileid, ls_case_id, ls_case_spl, ls_case_ver ) <> 1 THEN
		MessageBox( "ERROR", "Unable to get the Attachment Details for FILE_ID: " + &
					ls_fileid + " CASE_ID: " + ls_case_id + ls_case_spl + ls_case_ver, StopSign! )
		cb_close.PostEvent( Clicked! )
	END IF
END IF
end event

type cb_close from u_cb within w_attach_details
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1723
integer y = 744
integer taborder = 20
string text = "&Close"
boolean cancel = true
boolean default = true
end type

event clicked;call super::clicked;//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
Close( Parent )
end event

type dw_details from u_dw within w_attach_details
string accessiblename = "Attachment Details"
string accessibledescription = "Attachment Details"
accessiblerole accessiblerole = clientrole!
integer width = 2039
integer height = 728
integer taborder = 10
string dataobject = "d_attach_details"
end type

