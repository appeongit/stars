$PBExportHeader$w_enroll_id.srw
$PBExportComments$Inherited from w_master
forward
global type w_enroll_id from w_master
end type
type cb_close from u_cb within w_enroll_id
end type
type cb_ok from u_cb within w_enroll_id
end type
type sle_id from singlelineedit within w_enroll_id
end type
end forward

global type w_enroll_id from w_master
string accessiblename = "Patient ID"
string accessibledescription = "Patient ID"
accessiblerole accessiblerole = windowrole!
integer x = 1106
integer y = 712
integer width = 974
integer height = 492
string title = "Patient ID"
windowtype windowtype = response!
long backcolor = 67108864
cb_close cb_close
cb_ok cb_ok
sle_id sle_id
end type
global w_enroll_id w_enroll_id

event open;call super::open;//fx_set_window_colors(w_enroll_id)

end event

on w_enroll_id.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.sle_id=create sle_id
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.sle_id
end on

on w_enroll_id.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.sle_id)
end on

type cb_close from u_cb within w_enroll_id
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 603
integer y = 240
integer width = 256
integer height = 112
integer taborder = 20
string text = "&Close"
end type

on clicked;close (parent)

end on

type cb_ok from u_cb within w_enroll_id
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 73
integer y = 240
integer width = 256
integer height = 112
integer taborder = 30
string text = "OK"
boolean default = true
end type

event clicked;//	09/18/06	GaryR	Track 4683	Dynamically set the transaction of ENROLLEE_XREF table

string lv_id,lv_recip_id
n_tr	ltr_xref
n_cst_provpat	lnv_provpat

lv_id = sle_id.text

if len(sle_id.text)<4 then
	messagebox('Recip ID','Recip ID must be at least 4 characters',stopsign!)
	setfocus(sle_id)
else
	 IF lnv_provpat.of_get_xref_trans( ltr_xref ) <> 1 THEN Return
	select recip_id into :lv_recip_id from enrollee_xref
   	where recip_id = Upper( :lv_id )
  		using ltr_xref;	
	if	ltr_xref.sqlcode=100 then
		closewithreturn(parent,sle_id.text)
	elseif ltr_xref.sqlcode=0 then
		messagebox('Duplicate Recip ID','Recip ID '+sle_id.text+' already exists.',stopsign!)
		setfocus(sle_id)
	else
		Messagebox("ERROR",'SQL Error')
	end if

	If ltr_xref.of_commit( ) <> 0 Then
		Messagebox('EDIT','Error Commiting')
		Return
	End If	
end if

end event

type sle_id from singlelineedit within w_enroll_id
string accessiblename = "Patient ID"
string accessibledescription = "-1"
accessiblerole accessiblerole = textrole!
integer x = 73
integer y = 32
integer width = 786
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
integer limit = 25
borderstyle borderstyle = stylelowered!
end type

