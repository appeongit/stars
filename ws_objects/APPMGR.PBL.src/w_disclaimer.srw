$PBExportHeader$w_disclaimer.srw
$PBExportComments$Login Disclaimer
forward
global type w_disclaimer from w_master
end type
type cb_print from u_cb within w_disclaimer
end type
type cb_consent from u_cb within w_disclaimer
end type
type cb_decline from u_cb within w_disclaimer
end type
type rte_1 from u_rte within w_disclaimer
end type
end forward

global type w_disclaimer from w_master
long backcolor = 67108864
string accessiblename = "Login Disclaimer"
string accessibledescription = "Login Disclaimer"
accessiblerole accessiblerole = windowrole!
integer width = 3077
integer height = 1856
string title = "Login Disclaimer"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean clientedge = true
boolean center = true
cb_print cb_print
cb_consent cb_consent
cb_decline cb_decline
rte_1 rte_1
end type
global w_disclaimer w_disclaimer

on w_disclaimer.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_consent=create cb_consent
this.cb_decline=create cb_decline
this.rte_1=create rte_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_consent
this.Control[iCurrent+3]=this.cb_decline
this.Control[iCurrent+4]=this.rte_1
end on

on w_disclaimer.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_consent)
destroy(this.cb_decline)
destroy(this.rte_1)
end on

event open;call super::open;//	12/07/07	GaryR	SPR 5213	Dynamic Login Disclaimer

String	ls_desc

//	Get the disclaimer RichText from NOTES table
ls_desc	=	gnv_sql.of_get_note_text( "**********", "**", "********************" )
Stars2ca.of_commit()
rte_1.PasteRTF (ls_desc, Detail!)

//	Scroll to the top
rte_1.SelectText ( 1, 1, 0, 0 )

cb_consent.SetFocus()
end event

type cb_print from u_cb within w_disclaimer
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 352
integer y = 1652
integer width = 334
integer height = 104
integer taborder = 20
string text = "&Print"
end type

event clicked;call super::clicked;//	12/07/07	GaryR	SPR 5213	Dynamic Login Disclaimer

rte_1.Print( 1, "", FALSE, FALSE )
end event

type cb_consent from u_cb within w_disclaimer
string accessiblename = "Consent"
string accessibledescription = "Consent"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2706
integer y = 1652
integer width = 334
integer height = 104
integer taborder = 20
string text = "&Consent"
boolean default = true
end type

event clicked;call super::clicked;//	12/07/07	GaryR	SPR 5213	Dynamic Login Disclaimer

// Consent to disclaimer
CloseWithReturn( PARENT, 1 )
end event

type cb_decline from u_cb within w_disclaimer
string accessiblename = "Decline"
string accessibledescription = "Decline"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 9
integer y = 1652
integer width = 334
integer height = 104
integer taborder = 20
string text = "&Decline"
boolean cancel = true
end type

event clicked;call super::clicked;Close( PARENT )
end event

type rte_1 from u_rte within w_disclaimer
string accessiblename = "Disclaimer"
string accessibledescription = "Disclaimer"
long backcolor = 1073741824
accessiblerole accessiblerole = textrole!
integer x = 9
integer y = 8
integer width = 3031
integer height = 1636
boolean init_vscrollbar = true
boolean init_displayonly = true
end type

