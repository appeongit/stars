HA$PBExportHeader$w_graph_the_dw_type.srw
$PBExportComments$inherited from w_master
forward
global type w_graph_the_dw_type from w_master
end type
type cb_ok from commandbutton within w_graph_the_dw_type
end type
type cb_cancel from commandbutton within w_graph_the_dw_type
end type
type pb_2d_area from picturebutton within w_graph_the_dw_type
end type
type pb_2d_bar from picturebutton within w_graph_the_dw_type
end type
type pb_2d_column from picturebutton within w_graph_the_dw_type
end type
type pb_2d_line from picturebutton within w_graph_the_dw_type
end type
type pb_2d_pie from picturebutton within w_graph_the_dw_type
end type
type pb_2d_scatter from picturebutton within w_graph_the_dw_type
end type
type st_2d_area from statictext within w_graph_the_dw_type
end type
type st_2d_bar from statictext within w_graph_the_dw_type
end type
type st_2d_column from statictext within w_graph_the_dw_type
end type
type st_2d_line from statictext within w_graph_the_dw_type
end type
type st_2d_pie from statictext within w_graph_the_dw_type
end type
type st_2d_scatter from statictext within w_graph_the_dw_type
end type
type pb_3d_area from picturebutton within w_graph_the_dw_type
end type
type pb_3d_bar from picturebutton within w_graph_the_dw_type
end type
type pb_3d_column from picturebutton within w_graph_the_dw_type
end type
type pb_3d_line from picturebutton within w_graph_the_dw_type
end type
type pb_3d_pie from picturebutton within w_graph_the_dw_type
end type
type st_2d from statictext within w_graph_the_dw_type
end type
type st_3d from statictext within w_graph_the_dw_type
end type
type pb_stack_bar from picturebutton within w_graph_the_dw_type
end type
type pb_stack_column from picturebutton within w_graph_the_dw_type
end type
type pb_solid_bar from picturebutton within w_graph_the_dw_type
end type
type pb_solid_column from picturebutton within w_graph_the_dw_type
end type
type pb_ss_bar from picturebutton within w_graph_the_dw_type
end type
type pb_ss_column from picturebutton within w_graph_the_dw_type
end type
type st_stacked from statictext within w_graph_the_dw_type
end type
type st_solid from statictext within w_graph_the_dw_type
end type
type st_stack_solid from statictext within w_graph_the_dw_type
end type
type st_graph_label from statictext within w_graph_the_dw_type
end type
type st_graph_selection from statictext within w_graph_the_dw_type
end type
end forward

global type w_graph_the_dw_type from w_master
string accessiblename = "GRAPH TYPE"
string accessibledescription = "GRAPH TYPE"
accessiblerole accessiblerole = windowrole!
integer x = 306
integer y = 352
integer width = 2345
integer height = 1224
string title = "GRAPH TYPE"
windowtype windowtype = response!
long backcolor = 67108864
cb_ok cb_ok
cb_cancel cb_cancel
pb_2d_area pb_2d_area
pb_2d_bar pb_2d_bar
pb_2d_column pb_2d_column
pb_2d_line pb_2d_line
pb_2d_pie pb_2d_pie
pb_2d_scatter pb_2d_scatter
st_2d_area st_2d_area
st_2d_bar st_2d_bar
st_2d_column st_2d_column
st_2d_line st_2d_line
st_2d_pie st_2d_pie
st_2d_scatter st_2d_scatter
pb_3d_area pb_3d_area
pb_3d_bar pb_3d_bar
pb_3d_column pb_3d_column
pb_3d_line pb_3d_line
pb_3d_pie pb_3d_pie
st_2d st_2d
st_3d st_3d
pb_stack_bar pb_stack_bar
pb_stack_column pb_stack_column
pb_solid_bar pb_solid_bar
pb_solid_column pb_solid_column
pb_ss_bar pb_ss_bar
pb_ss_column pb_ss_column
st_stacked st_stacked
st_solid st_solid
st_stack_solid st_stack_solid
st_graph_label st_graph_label
st_graph_selection st_graph_selection
end type
global w_graph_the_dw_type w_graph_the_dw_type

type variables
string graph_type
end variables

on w_graph_the_dw_type.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.pb_2d_area=create pb_2d_area
this.pb_2d_bar=create pb_2d_bar
this.pb_2d_column=create pb_2d_column
this.pb_2d_line=create pb_2d_line
this.pb_2d_pie=create pb_2d_pie
this.pb_2d_scatter=create pb_2d_scatter
this.st_2d_area=create st_2d_area
this.st_2d_bar=create st_2d_bar
this.st_2d_column=create st_2d_column
this.st_2d_line=create st_2d_line
this.st_2d_pie=create st_2d_pie
this.st_2d_scatter=create st_2d_scatter
this.pb_3d_area=create pb_3d_area
this.pb_3d_bar=create pb_3d_bar
this.pb_3d_column=create pb_3d_column
this.pb_3d_line=create pb_3d_line
this.pb_3d_pie=create pb_3d_pie
this.st_2d=create st_2d
this.st_3d=create st_3d
this.pb_stack_bar=create pb_stack_bar
this.pb_stack_column=create pb_stack_column
this.pb_solid_bar=create pb_solid_bar
this.pb_solid_column=create pb_solid_column
this.pb_ss_bar=create pb_ss_bar
this.pb_ss_column=create pb_ss_column
this.st_stacked=create st_stacked
this.st_solid=create st_solid
this.st_stack_solid=create st_stack_solid
this.st_graph_label=create st_graph_label
this.st_graph_selection=create st_graph_selection
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.pb_2d_area
this.Control[iCurrent+4]=this.pb_2d_bar
this.Control[iCurrent+5]=this.pb_2d_column
this.Control[iCurrent+6]=this.pb_2d_line
this.Control[iCurrent+7]=this.pb_2d_pie
this.Control[iCurrent+8]=this.pb_2d_scatter
this.Control[iCurrent+9]=this.st_2d_area
this.Control[iCurrent+10]=this.st_2d_bar
this.Control[iCurrent+11]=this.st_2d_column
this.Control[iCurrent+12]=this.st_2d_line
this.Control[iCurrent+13]=this.st_2d_pie
this.Control[iCurrent+14]=this.st_2d_scatter
this.Control[iCurrent+15]=this.pb_3d_area
this.Control[iCurrent+16]=this.pb_3d_bar
this.Control[iCurrent+17]=this.pb_3d_column
this.Control[iCurrent+18]=this.pb_3d_line
this.Control[iCurrent+19]=this.pb_3d_pie
this.Control[iCurrent+20]=this.st_2d
this.Control[iCurrent+21]=this.st_3d
this.Control[iCurrent+22]=this.pb_stack_bar
this.Control[iCurrent+23]=this.pb_stack_column
this.Control[iCurrent+24]=this.pb_solid_bar
this.Control[iCurrent+25]=this.pb_solid_column
this.Control[iCurrent+26]=this.pb_ss_bar
this.Control[iCurrent+27]=this.pb_ss_column
this.Control[iCurrent+28]=this.st_stacked
this.Control[iCurrent+29]=this.st_solid
this.Control[iCurrent+30]=this.st_stack_solid
this.Control[iCurrent+31]=this.st_graph_label
this.Control[iCurrent+32]=this.st_graph_selection
end on

on w_graph_the_dw_type.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.pb_2d_area)
destroy(this.pb_2d_bar)
destroy(this.pb_2d_column)
destroy(this.pb_2d_line)
destroy(this.pb_2d_pie)
destroy(this.pb_2d_scatter)
destroy(this.st_2d_area)
destroy(this.st_2d_bar)
destroy(this.st_2d_column)
destroy(this.st_2d_line)
destroy(this.st_2d_pie)
destroy(this.st_2d_scatter)
destroy(this.pb_3d_area)
destroy(this.pb_3d_bar)
destroy(this.pb_3d_column)
destroy(this.pb_3d_line)
destroy(this.pb_3d_pie)
destroy(this.st_2d)
destroy(this.st_3d)
destroy(this.pb_stack_bar)
destroy(this.pb_stack_column)
destroy(this.pb_solid_bar)
destroy(this.pb_solid_column)
destroy(this.pb_ss_bar)
destroy(this.pb_ss_column)
destroy(this.st_stacked)
destroy(this.st_solid)
destroy(this.st_stack_solid)
destroy(this.st_graph_label)
destroy(this.st_graph_selection)
end on

event open;call super::open;setnull(graph_type)
end event

type cb_ok from commandbutton within w_graph_the_dw_type
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1943
integer y = 756
integer width = 265
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;if isnull(graph_type) or graph_type = '' then
	Messagebox('Graph Selection','Select a graph type from the dropdown list box first.',Exclamation!)
	return
end if

w_graph_the_dw_2.in_graph_type = graph_type

close(w_graph_the_dw_type)
end event

type cb_cancel from commandbutton within w_graph_the_dw_type
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1943
integer y = 884
integer width = 265
integer height = 100
integer taborder = 190
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;close(w_graph_the_dw_type)
end event

type pb_2d_area from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Two-dimensional Area Graph"
string accessiblename = "Two-dimensional Area Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 256
integer y = 144
integer width = 183
integer height = 164
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "2d-area.bmp"
vtextalign vtextalign = top!
end type

event clicked;graph_type = "area"
st_graph_selection.text = '2D Area'


end event

type pb_2d_bar from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Two-dimensional Bar Graph"
string accessiblename = "Two-dimensional Bar Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 512
integer y = 144
integer width = 183
integer height = 164
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "2d-bar.bmp"
vtextalign vtextalign = top!
end type

event clicked;graph_type = "bar"
st_graph_selection.text = '2D Bar'

end event

type pb_2d_column from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Two-dimensional Column Graph"
string accessiblename = "Two-dimensional Column Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 768
integer y = 144
integer width = 183
integer height = 164
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "2d-colum.bmp"
vtextalign vtextalign = top!
end type

event clicked;graph_type = "col"
st_graph_selection.text = '2D Column'

end event

type pb_2d_line from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Two-dimensional Line Graph"
string accessiblename = "Two-dimensional Line Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1024
integer y = 144
integer width = 183
integer height = 164
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "2d-line.bmp"
vtextalign vtextalign = top!
end type

event clicked;graph_type = "line"
st_graph_selection.text = '2D Line'

end event

type pb_2d_pie from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Two-dimensional Pie Graph"
string accessiblename = "Two-dimensional Pie Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1280
integer y = 144
integer width = 183
integer height = 164
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "2d-pie.bmp"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;graph_type = "pie"
st_graph_selection.text = '2D Pie'

end event

type pb_2d_scatter from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Two-dimensional Scatter Graph"
string accessiblename = "Two-dimensional Scatter Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1536
integer y = 144
integer width = 183
integer height = 164
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "2d-scatt.bmp"
vtextalign vtextalign = top!
end type

event clicked;graph_type = "scatter"
st_graph_selection.text = '2D Scatter'

end event

type st_2d_area from statictext within w_graph_the_dw_type
string accessiblename = "Area"
string accessibledescription = "Area"
accessiblerole accessiblerole = statictextrole!
integer x = 215
integer y = 32
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Area"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2d_bar from statictext within w_graph_the_dw_type
string accessiblename = "Bar"
string accessibledescription = "Bar"
accessiblerole accessiblerole = statictextrole!
integer x = 471
integer y = 32
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Bar"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2d_column from statictext within w_graph_the_dw_type
string accessiblename = "Column"
string accessibledescription = "Column"
accessiblerole accessiblerole = statictextrole!
integer x = 727
integer y = 32
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Column"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2d_line from statictext within w_graph_the_dw_type
string accessiblename = "Line"
string accessibledescription = "Line"
accessiblerole accessiblerole = statictextrole!
integer x = 983
integer y = 32
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Line"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2d_pie from statictext within w_graph_the_dw_type
string accessiblename = "Pie"
string accessibledescription = "Pie"
accessiblerole accessiblerole = statictextrole!
integer x = 1239
integer y = 32
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Pie"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2d_scatter from statictext within w_graph_the_dw_type
string accessiblename = "Scatter"
string accessibledescription = "Scatter"
accessiblerole accessiblerole = statictextrole!
integer x = 1495
integer y = 32
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Scatter"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_3d_area from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Three-dimensional Area Graph"
string accessiblename = "Three-dimensional Area Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 256
integer y = 336
integer width = 183
integer height = 164
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "3d-area.bmp"
end type

event clicked;graph_type = "area3d"
st_graph_selection.text = '3D Area'

end event

type pb_3d_bar from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Three-dimensional Bar Graph"
string accessiblename = "Three-dimensional Bar Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 512
integer y = 336
integer width = 183
integer height = 164
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "3d-bar.bmp"
end type

event clicked;graph_type = "bar3d"
st_graph_selection.text = '3D Bar'

end event

type pb_3d_column from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Three-dimensional Column Graph"
string accessiblename = "Three-dimensional Column Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 768
integer y = 336
integer width = 183
integer height = 164
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "3d-colum.bmp"
end type

event clicked;graph_type = "col3d"
st_graph_selection.text = '3D Column'

end event

type pb_3d_line from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Three-dimensional Line Graph"
string accessiblename = "Three-dimensional Line Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1024
integer y = 336
integer width = 183
integer height = 164
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "3d-line.bmp"
end type

event clicked;graph_type = "line3d"
st_graph_selection.text = '3D Line'

end event

type pb_3d_pie from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Three-dimensional Pie Graph"
string accessiblename = "Three-dimensional Pie Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1280
integer y = 336
integer width = 183
integer height = 164
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "3d-pie.bmp"
alignment htextalign = left!
end type

event clicked;graph_type = "pie3d"
st_graph_selection.text = '3D Pie'

end event

type st_2d from statictext within w_graph_the_dw_type
string accessiblename = "2-D"
string accessibledescription = "2-D"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 192
integer width = 146
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "2-D"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3d from statictext within w_graph_the_dw_type
string accessiblename = "3-D"
string accessibledescription = "3-D"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 384
integer width = 146
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "3-D"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_stack_bar from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Stacked Bar Graph"
string accessiblename = "Stacked Bar Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 512
integer y = 528
integer width = 183
integer height = 164
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "st-bar.bmp"
end type

event clicked;graph_type = "barstacked"
st_graph_selection.text = '2D Stacked Bar'

end event

type pb_stack_column from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Stacked Column Graph"
string accessiblename = "Stacked Column Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 768
integer y = 528
integer width = 183
integer height = 164
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "st-colum.bmp"
end type

event clicked;graph_type = "colstacked"
st_graph_selection.text = '2D Stacked Column'

end event

type pb_solid_bar from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Solid Bar Graph"
string accessiblename = "Solid Bar Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 512
integer y = 720
integer width = 183
integer height = 164
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "so-bar.bmp"
end type

event clicked;graph_type = "bar3dobj"
st_graph_selection.text = '3D Solid Bar'

end event

type pb_solid_column from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Solid Column Graph"
string accessiblename = "Solid Column Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 768
integer y = 720
integer width = 183
integer height = 164
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "so-colum.bmp"
end type

event clicked;graph_type = "col3dobj"
st_graph_selection.text = '3D Solid Column'

end event

type pb_ss_bar from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Stacked Solid Bar Graph"
string accessiblename = "Stacked Solid Bar Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 512
integer y = 912
integer width = 183
integer height = 164
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "ss-bar.bmp"
end type

event clicked;graph_type = "barstacked3dobj"
st_graph_selection.text = '3D Stacked Solid Bar'

end event

type pb_ss_column from picturebutton within w_graph_the_dw_type
long textcolor = 33554432
long backcolor = 67108864
string accessibledescription = "Stacked Solid Column Graph"
string accessiblename = "Stacked Solid Column Graph"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 768
integer y = 912
integer width = 183
integer height = 164
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "ss-colum.bmp"
end type

event clicked;graph_type = "colstacked3dobj"
st_graph_selection.text = '3D Stacked Solid Column'

end event

type st_stacked from statictext within w_graph_the_dw_type
string accessiblename = "Stacked"
string accessibledescription = "Stacked"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 576
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stacked"
boolean focusrectangle = false
end type

type st_solid from statictext within w_graph_the_dw_type
string accessiblename = "Solid"
string accessibledescription = "Solid"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 768
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Solid"
boolean focusrectangle = false
end type

type st_stack_solid from statictext within w_graph_the_dw_type
string accessiblename = "Stack/Solid"
string accessibledescription = "Stack/Solid"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 960
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stack/Solid"
boolean focusrectangle = false
end type

type st_graph_label from statictext within w_graph_the_dw_type
string accessiblename = "Graph Selection"
string accessibledescription = "Graph Selection"
accessiblerole accessiblerole = statictextrole!
integer x = 1152
integer y = 672
integer width = 585
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Graph Selection"
boolean focusrectangle = false
end type

type st_graph_selection from statictext within w_graph_the_dw_type
string accessiblename = "Selected Graph Type"
string accessibledescription = "Selected Graph Type"
accessiblerole accessiblerole = statictextrole!
integer x = 1152
integer y = 752
integer width = 745
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

