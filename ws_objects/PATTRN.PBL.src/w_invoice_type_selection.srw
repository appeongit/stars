$PBExportHeader$w_invoice_type_selection.srw
$PBExportComments$Inherited from w_master
forward
global type w_invoice_type_selection from w_master
end type
type cb_ok from u_cb within w_invoice_type_selection
end type
type ddlb_main_tbl_names from dropdownlistbox within w_invoice_type_selection
end type
type sle_dep_tbl_name from singlelineedit within w_invoice_type_selection
end type
type gb_1 from groupbox within w_invoice_type_selection
end type
type wsx_parm from structure within w_invoice_type_selection
end type
type wsx_tbls from structure within w_invoice_type_selection
end type
end forward

type wsx_parm from structure
    string message[]
end type

type wsx_tbls from structure
    string tbl_type
    string tbl_desc
end type

global type w_invoice_type_selection from w_master
string accessiblename = "Invoice Selection"
string accessibledescription = "Invoice Selection"
accessiblerole accessiblerole = windowrole!
integer x = 672
integer y = 264
integer width = 1545
integer height = 976
string title = "Invoice Selection"
windowtype windowtype = response!
long backcolor = 67108864
cb_ok cb_ok
ddlb_main_tbl_names ddlb_main_tbl_names
sle_dep_tbl_name sle_dep_tbl_name
gb_1 gb_1
end type
global w_invoice_type_selection w_invoice_type_selection

type variables
wsx_tbls iv_desc[]

// Message.powerobjectparm
sx_parm istr_parm
end variables

event open;call super::open;//load sle_dep_tbl_name with dependent column label 
//load ddlb_main_tbl_names with main tables (get labels from dictionary)

//*********************************************************
//10-03-95 FNC Take upperbound out of loop
//11-24-95 FDG Access dictionary thru w_main.dw_stars_rel_dict
//*********************************************************

//HRB 11/2/95 - PartA Conversion
// rewrote to put label into sle_dep_tbl_name & structure 
// (sx_parm) was redefined to include label and dep_tbl_type


int i,j,lv_upperbound
long ll_rc										

sle_dep_tbl_name.text = istr_parm.dep_tbl + '.' + istr_parm.label
j = 1

lv_upperbound = upperbound(istr_parm.main_tbls)	
for i = 1 to lv_upperbound                   
	if istr_parm.main_tbls[i] <> '' then
		ll_rc = fx_filter_stars_rel_id_2 (istr_parm.main_tbls[i])
		IF ll_rc	< 1	THEN
			errorbox(stars2ca,'Error Reading Dictionary.(Invoice Desc)')
			exit
		END IF
		iv_desc[j].tbl_desc = w_main.dw_stars_rel_dict.GetItemString (1, "dictionary_elem_desc")
		iv_desc[j].tbl_type = istr_parm.main_tbls[i]
		ddlb_main_tbl_names.additem(iv_desc[j].tbl_desc)
		j++
	end if
next
ddlb_main_tbl_names.selectitem(1)
end event

on w_invoice_type_selection.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.ddlb_main_tbl_names=create ddlb_main_tbl_names
this.sle_dep_tbl_name=create sle_dep_tbl_name
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.ddlb_main_tbl_names
this.Control[iCurrent+3]=this.sle_dep_tbl_name
this.Control[iCurrent+4]=this.gb_1
end on

on w_invoice_type_selection.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.ddlb_main_tbl_names)
destroy(this.sle_dep_tbl_name)
destroy(this.gb_1)
end on

event ue_preopen;call super::ue_preopen;
istr_parm = message.PowerObjectParm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

end event

type cb_ok from u_cb within w_invoice_type_selection
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 576
integer y = 736
integer width = 338
integer height = 108
integer taborder = 30
string text = "&OK"
boolean default = true
end type

on clicked;//return tbl type of main table

//*********************************************************
//10-03-95 FNC Take upperbound out of loop
//*********************************************************

string lv_label,lv_return
int i,lv_upperbound

lv_label = ddlb_main_tbl_names.text
lv_upperbound = upperbound(iv_desc)   //10-03-95 FNC
for i = 1 to lv_upperbound  //10-04-95 FNC
	if lv_label = iv_desc[i].tbl_desc then
		lv_return = iv_desc[i].tbl_type
		exit
	end if
next
closewithreturn(parent,lv_return)
end on

type ddlb_main_tbl_names from dropdownlistbox within w_invoice_type_selection
string accessiblename = "Invoice Type Selection"
string accessibledescription = "Invoice Type Selection"
accessiblerole accessiblerole = comboboxrole!
integer x = 306
integer y = 340
integer width = 882
integer height = 312
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type sle_dep_tbl_name from singlelineedit within w_invoice_type_selection
string accessiblename = "Table Name"
string accessibledescription = "Table Name"
accessiblerole accessiblerole = textrole!
integer x = 229
integer y = 80
integer width = 1033
integer height = 108
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 1073741824
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_invoice_type_selection
string accessiblename = "Select Invoice Type"
string accessibledescription = "Select Invoice Type"
accessiblerole accessiblerole = groupingrole!
integer x = 50
integer y = 240
integer width = 1394
integer height = 444
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Select Invoice Type"
end type

