$PBExportHeader$w_subset_cross_reference_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_subset_cross_reference_list from w_master
end type
type dw_1 from u_dw within w_subset_cross_reference_list
end type
type cb_use from u_cb within w_subset_cross_reference_list
end type
type cb_cancel from u_cb within w_subset_cross_reference_list
end type
type cb_criteria from u_cb within w_subset_cross_reference_list
end type
type st_rows from statictext within w_subset_cross_reference_list
end type
end forward

global type w_subset_cross_reference_list from w_master
string accessiblename = "Subset Cross Reference List"
string accessibledescription = "Subset Cross Reference List"
accessiblerole accessiblerole = windowrole!
integer x = 320
integer y = 348
integer width = 2949
integer height = 1344
string title = "Subset Cross Reference List"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
cb_use cb_use
cb_cancel cb_cancel
cb_criteria cb_criteria
st_rows st_rows
end type
global w_subset_cross_reference_list w_subset_cross_reference_list

type variables
sx_subset_ids istr_subset_ids
nvo_subset_functions inv_subset_functions//NLG 6-25-98
end variables

on w_subset_cross_reference_list.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_use=create cb_use
this.cb_cancel=create cb_cancel
this.cb_criteria=create cb_criteria
this.st_rows=create st_rows
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_use
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_criteria
this.Control[iCurrent+5]=this.st_rows
end on

on w_subset_cross_reference_list.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_use)
destroy(this.cb_cancel)
destroy(this.cb_criteria)
destroy(this.st_rows)
end on

event ue_preopen;call super::ue_preopen;//The code in this event will retrieve the parm sent to the window. The code is as follows:

Istr_Subset_Ids = message.PowerObjectParm

end event

event open;call super::open;//Modifications:
//
//NLG 6-25-98 Track #1340 - create nvo_subset_functions to enable security check
//-------------------------------------------------------------------------------------

long ll_rows

inv_subset_functions = create nvo_subset_functions //NLG Track #1340

//Verify that the subset name has been passed to the window.
If IsNull(Istr_Subset_Ids.Subset_Name) or trim(Istr_Subset_Ids.Subset_Name)  < ' ' then
		messagebox('Error','Cannot display Cross Reference, Subset Name not supplied')
end if

//Next retrieve the cross reference list datawindow

SetTransObject(DW_1,stars2ca)

ll_rows = Retrieve(dw_1,Istr_Subset_Ids.Subset_Name)

if ll_rows < 1 then
		messagebox('ERROR','Error retrieving cross reference list')
		return 
else
		st_rows.text = string(ll_rows)
		cb_use.enabled = TRUE
end if


end event

event close;call super::close;//Modifications:
//NLG 6-25-98 Track #1340 
//-----------------------------------------------------------------------------


if isValid(inv_subset_functions) then destroy inv_subset_functions

end event

type dw_1 from u_dw within w_subset_cross_reference_list
string accessiblename = "Subset Cross Reference List Data"
string accessibledescription = "Subset Cross Reference List Data"
accessiblerole accessiblerole = clientrole!
integer x = 105
integer y = 108
integer width = 2715
integer height = 920
integer taborder = 20
string dataobject = "d_subset_cross_reference_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SingleSelect(TRUE)

//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

event doubleclicked;call super::doubleclicked;IF	ib_multiselect					&
AND This.GetRow ()	=	row	THEN
	This.Event	ue_multiselect (row)
	Return
END IF

IF	ib_singleselect				THEN
	This.Event	ue_singleselect (row)	// hilite clicked row
	//	Set the clicked row as the current row
	IF	This.GetRow ()	<>	row	THEN
		This.SetRow (row)
	END IF
END IF

//Next the doubleclicked event must trigger the cb_use button. The code is as follows:

triggerevent(cb_use,clicked!)


end event

type cb_use from u_cb within w_subset_cross_reference_list
string accessiblename = "Use"
string accessibledescription = "Use"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1769
integer y = 1116
integer taborder = 30
string text = "Use"
end type

event clicked;call super::clicked;//	NLG	06/25/98	Track #1340 - check case security first
//	GaryR	11/16/04	Track	4115d	STARS Reporting - Claims PDRs

string ls_case_id, ls_case_spl, ls_case_ver	//NLG 6-25-98 Track #1340
integer li_rc 											//NLG 6-25-98 Track #1340
long ll_row

ll_row = dw_1.GetRow()

ls_case_Id = left(dw_1.object.case_id[ll_row],10)
ls_case_Spl = mid(dw_1.object.case_id[ll_row],11,2)
ls_case_Ver = mid(dw_1.object.case_id[ll_row],13,2)
Li_rc = Inv_Subset_Functions.UF_Determine_Case_Security(ls_case_id+ls_case_spl+ls_case_ver)
if li_rc = 0 then
	Istr_subset_ids.Subset_Id = dw_1.object.link_key[ll_row]
	istr_subset_ids.subset_desc = dw_1.object.link_desc[ll_row]
	Istr_subset_ids.subset_case_Id = ls_case_id
	Istr_subset_ids.subset_case_Spl = ls_case_spl
	Istr_subset_ids.subset_case_Ver = ls_case_ver
	closewithreturn(parent,istr_subset_ids)
elseif li_rc = 100 then
	Messagebox('EDIT ERROR','This subset is attached to a Secured Case.  You have insufficient privileges to use this Subset.')
else
	Messagebox('EDIT ERROR','Cannot determine case security for this subset.  You may not use this Subset.')
end if
end event

type cb_cancel from u_cb within w_subset_cross_reference_list
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2249
integer y = 1116
integer taborder = 10
string text = "Cancel"
end type

event clicked;call super::clicked;//Modifications:
//	06/16/98	NLG	Track #1358 CloseWithReturn
//------------------------------------------------------------------------------------

//Close(Parent)

Istr_subset_ids.Subset_Id = ''
istr_subset_ids.subset_name = ''
Istr_subset_ids.subset_case_Id = ''
Istr_subset_ids.subset_case_Spl = ''
Istr_subset_ids.subset_case_Ver = ''


closewithreturn(parent,istr_subset_ids)

end event

type cb_criteria from u_cb within w_subset_cross_reference_list
string accessiblename = "Criteria"
string accessibledescription = "Criteria..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1280
integer y = 1116
integer width = 334
integer taborder = 2
string text = "Criteria..."
end type

event clicked;call super::clicked;//NLG 6-25-98 Track #1340 - check case security before displaying criteria
//-----------------------------------------------------------------------------------
long ll_row
string ls_case_id, ls_case_spl, ls_case_ver	//NLG 6-25-98 Track #1340
integer li_rc											//NLG 6-25-98 Track #1340

SX_Display_Criteria  lstr_display_criteria

//SX_Display_Criteria is a new structure. A separate technical specification 
//describing this structure has been created.

//Next the structure must be loaded.

ll_row = dw_1.GetRow()
lstr_display_criteria.Parm = 'SUB'

//NLG 6-25-98 Track #1340 - check case security first
//lstr_display_criteria.subset_ids.Subset_Id = dw_1.object.link_key[ll_row]
//lstr_display_criteria.subset_ids.subset_case_Id = left(dw_1.object.case_id[ll_row],10)
//lstr_display_criteria.subset_ids.subset_case_Spl = mid(dw_1.object.case_id[ll_row],11,2)
//lstr_display_criteria.subset_ids.subset_case_Ver = mid(dw_1.object.case_id[ll_row],13,2)
ls_case_Id = left(dw_1.object.case_id[ll_row],10)
ls_case_Spl = mid(dw_1.object.case_id[ll_row],11,2)
ls_case_Ver = mid(dw_1.object.case_id[ll_row],13,2)
Li_rc = Inv_Subset_Functions.UF_Determine_Case_Security(ls_case_id+ls_case_spl+ls_case_ver)
if li_rc = 0 then
	lstr_display_criteria.subset_ids.Subset_Id = dw_1.object.link_key[ll_row]
	lstr_display_criteria.subset_ids.subset_case_Id = ls_case_id
	lstr_display_criteria.subset_ids.subset_case_Spl = ls_case_spl
	lstr_display_criteria.subset_ids.subset_case_Ver = ls_case_ver
	//Lastly, the criteria display window must be opened.
	//OpenSheetwithParm(w_case_display_criteria,lstr_Display_Criteria,MDI_Main_Frame,Help_Menu_Position,Layered!)//NLG Track #1367
	OpenwithParm(w_case_display_criteria,lstr_Display_Criteria)//NLG Track #1367
elseif li_rc = 100 then
	Messagebox('EDIT ERROR','This subset is attached to a Secured Case.  You have insufficient privileges for viewing.')
else
	Messagebox('EDIT ERROR','Cannot determine case security for this subset.  You may not view.')
end if





end event

type st_rows from statictext within w_subset_cross_reference_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 242
integer y = 1132
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

