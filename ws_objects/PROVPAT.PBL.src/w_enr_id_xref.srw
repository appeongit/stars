$PBExportHeader$w_enr_id_xref.srw
$PBExportComments$Inherited from w_master
forward
global type w_enr_id_xref from w_master
end type
type st_1 from statictext within w_enr_id_xref
end type
type dw_1 from u_dw within w_enr_id_xref
end type
end forward

global type w_enr_id_xref from w_master
string accessiblename = "Related IDs"
string accessibledescription = "Related IDs"
accessiblerole accessiblerole = windowrole!
integer x = 672
integer y = 264
integer width = 873
integer height = 820
string title = "Related ID~'s"
windowtype windowtype = child!
long backcolor = 67108864
st_1 st_1
dw_1 dw_1
end type
global w_enr_id_xref w_enr_id_xref

type variables
string recip_rid
end variables

event open;call super::open;//	09/18/06	GaryR	Track 4683	Dynamically set the transaction of ENROLLEE_XREF table

int return_code
n_tr	ltr_xref
n_cst_provpat	lnv_provpat

setpointer(hourglass!)
w_main.setmicrohelp("Retrieving Recip ID's")

IF lnv_provpat.of_get_xref_trans( ltr_xref ) <> 1 THEN 
	postevent(close!)
ELSE
	dw_1.settransobject(ltr_xref)
	dw_1.retrieve(recip_rid)

	If ltr_xref.of_commit( ) <> 0 Then
		Messagebox('EDIT','Error Commiting')
		Return
	End If	
END IF

w_main.setmicrohelp('Ready')
end event

on w_enr_id_xref.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_enr_id_xref.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;if (not isnull(message.stringparm)) and message.stringparm<>'' then
	recip_rid=message.stringparm
	//KMM Clear out message parm (PB Bug)
	SetNull(message.stringparm)
	st_1.text=st_1.text+recip_rid
else
	postevent(close!)
end if

end event

type st_1 from statictext within w_enr_id_xref
string accessiblename = "Patient Alternate ID"
string accessibledescription = "RID"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 32
integer width = 731
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "RID:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_enr_id_xref
string accessiblename = "Recipient ID"
string accessibledescription = "-1"
accessiblerole accessiblerole = clientrole!
integer x = 55
integer y = 128
integer width = 727
integer height = 576
string dataobject = "d_enr_id_xref"
boolean vscrollbar = true
end type

