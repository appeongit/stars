HA$PBExportHeader$uo_case_folder_view.sru
$PBExportComments$inherited from uo_sample_summ <gui>
forward
global type uo_case_folder_view from uo_sample_summ
end type
type pb_7 from picturebutton within uo_case_folder_view
end type
type pb_5 from picturebutton within uo_case_folder_view
end type
type pb_6 from picturebutton within uo_case_folder_view
end type
type pb_4 from picturebutton within uo_case_folder_view
end type
type pb_3 from picturebutton within uo_case_folder_view
end type
end forward

global type uo_case_folder_view from uo_sample_summ
string accessiblename = "Case Folder"
string accessibledescription = "Case Folder"
accessiblerole accessiblerole = clientrole!
integer width = 1586
integer height = 364
boolean border = false
long backcolor = 67108864
pb_7 pb_7
pb_5 pb_5
pb_6 pb_6
pb_4 pb_4
pb_3 pb_3
end type
global uo_case_folder_view uo_case_folder_view

on uo_case_folder_view.create
int iCurrent
call super::create
this.pb_7=create pb_7
this.pb_5=create pb_5
this.pb_6=create pb_6
this.pb_4=create pb_4
this.pb_3=create pb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_7
this.Control[iCurrent+2]=this.pb_5
this.Control[iCurrent+3]=this.pb_6
this.Control[iCurrent+4]=this.pb_4
this.Control[iCurrent+5]=this.pb_3
end on

on uo_case_folder_view.destroy
call super::destroy
destroy(this.pb_7)
destroy(this.pb_5)
destroy(this.pb_6)
destroy(this.pb_4)
destroy(this.pb_3)
end on

type pb_2 from uo_sample_summ`pb_2 within uo_case_folder_view
integer x = 1061
integer y = 0
integer width = 530
integer height = 120
string text = "S&umm Rpt"
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

on pb_2::clicked;call uo_sample_summ`pb_2::clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_summ_rpt ()
end on

type pb_1 from uo_sample_summ`pb_1 within uo_case_folder_view
integer x = 0
integer y = 0
integer width = 530
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

on pb_1::clicked;call uo_sample_summ`pb_1::clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_sample ()
end on

type pb_7 from picturebutton within uo_case_folder_view
string accessiblename = "Rename"
string accessibledescription = "Rename"
long textcolor = 33554432
accessiblerole accessiblerole = pushbuttonrole!
integer y = 240
integer width = 530
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Rename"
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

event clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_rename ()


end event

type pb_5 from picturebutton within uo_case_folder_view
string accessiblename = "Criteria"
string accessibledescription = "Criteria"
long textcolor = 33554432
accessiblerole accessiblerole = pushbuttonrole!
integer y = 120
integer width = 530
integer height = 120
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Criteria"
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

on clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_sub_criteria ()
end on

type pb_6 from picturebutton within uo_case_folder_view
string accessiblename = "Random Sample"
string accessibledescription = "Random Sample"
long textcolor = 33554432
accessiblerole accessiblerole = pushbuttonrole!
integer x = 530
integer width = 530
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "Ran&dom Sample"
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

on clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_random_sample ()
end on

type pb_4 from picturebutton within uo_case_folder_view
string accessiblename = "View"
string accessibledescription = "View"
long textcolor = 33554432
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1061
integer y = 120
integer width = 530
integer height = 120
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&View"
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

on clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_view ()
end on

type pb_3 from picturebutton within uo_case_folder_view
string accessiblename = "Target"
string accessibledescription = "Target"
long textcolor = 33554432
accessiblerole accessiblerole = pushbuttonrole!
integer x = 530
integer y = 120
integer width = 530
integer height = 120
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Target"
vtextalign vtextalign = vcenter!
long backcolor = 67108864
end type

on clicked;w_case_folder_view.triggerevent (activate!)
w_case_folder_view.wf_target ()
end on

