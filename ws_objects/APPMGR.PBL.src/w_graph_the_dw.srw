$PBExportHeader$w_graph_the_dw.srw
$PBExportComments$Generic window to graph a datawindow (inherited from w_master)
forward
global type w_graph_the_dw from w_master
end type
type st_4 from statictext within w_graph_the_dw
end type
type pb_copy from picturebutton within w_graph_the_dw
end type
type st_elevation from statictext within w_graph_the_dw
end type
type em_elevation from editmask within w_graph_the_dw
end type
type st_perspective from statictext within w_graph_the_dw
end type
type em_perspective from editmask within w_graph_the_dw
end type
type st_rotation from statictext within w_graph_the_dw
end type
type em_rotation from editmask within w_graph_the_dw
end type
type st_zoom from statictext within w_graph_the_dw
end type
type em_zoom from editmask within w_graph_the_dw
end type
type cbx_preview from checkbox within w_graph_the_dw
end type
type cb_print2 from u_cb within w_graph_the_dw
end type
type cb_design from u_cb within w_graph_the_dw
end type
type cb_close from u_cb within w_graph_the_dw
end type
type dw_2 from u_dw within w_graph_the_dw
end type
end forward

global type w_graph_the_dw from w_master
string accessiblename = "Graph Data"
string accessibledescription = "Graph Data"
integer x = 82
integer y = 24
integer width = 2757
integer height = 1680
string title = "Graph Data"
string icon = "GRAPH2.ICO"
event ue_close ( )
st_4 st_4
pb_copy pb_copy
st_elevation st_elevation
em_elevation em_elevation
st_perspective st_perspective
em_perspective em_perspective
st_rotation st_rotation
em_rotation em_rotation
st_zoom st_zoom
em_zoom em_zoom
cbx_preview cbx_preview
cb_print2 cb_print2
cb_design cb_design
cb_close cb_close
dw_2 dw_2
end type
global w_graph_the_dw w_graph_the_dw

type variables
u_dw in_dw_in
end variables

event ue_close;call super::ue_close;close(this)
end event

event open;call super::open;// Open script for w_graph_the_dw

//********************************************************************
// 11-25-96 FNC Prob #173 STARS35 Call set colors function
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//********************************************************************

// ***** variable declarations
string lv_error,newfilter
string lv_dw_style
string lv_dw_syntax
long lv_pos, lv_start_pos, lv_len
int right_cnt = 0, left_cnt = 0
string temp_str

setpointer(HourGlass!)

if not isvalid(in_dw_in) then
	messagebox("ERROR","The datawindow sent to be graphed is not valid")
end if

// get the syntax of the DW being graphed
lv_dw_syntax = in_dw_in.Describe("datawindow.syntax")
if lv_dw_syntax = "!" or lv_dw_syntax = "?" then
	messagebox("ERROR","Unable to determine syntax of datawindow being graphed.")
	return
end if

// find the start of the table section of the dw syntax
lv_start_pos = pos(upper(lv_dw_syntax),"TABLE(")
if lv_start_pos < 1 then
	messagebox("PROGRAM ERROR","Unable to locate 'TABLE(' in dw syntax")
	return
end if
lv_dw_syntax = mid(lv_dw_syntax,lv_start_pos)	 // remove before table section

// remove any extra sections that can be identified
// this code was added to speed up the for loop that follows
//  it appears to run much faster with a smaller string
lv_start_pos = pos(upper(lv_dw_syntax),"GRAPH(BAND")
if lv_start_pos > 5 then
	lv_dw_syntax = mid(lv_dw_syntax,1,lv_start_pos - 1)
end if
lv_start_pos = pos(upper(lv_dw_syntax),"TEXT(")
if lv_start_pos > 5 then
	lv_dw_syntax = mid(lv_dw_syntax,1,lv_start_pos - 1)
end if
lv_start_pos = pos(upper(lv_dw_syntax),"COLUMN(BAND")
if lv_start_pos > 5 then
	lv_dw_syntax = mid(lv_dw_syntax,1,lv_start_pos - 1)
end if
lv_start_pos = pos(upper(lv_dw_syntax),"COMPUTE(BAND")
if lv_start_pos > 5 then
	lv_dw_syntax = mid(lv_dw_syntax,1,lv_start_pos - 1)
end if

// locate the end of the table section in DW syntax by matching parens

lv_pos = 5
lv_len = len(lv_dw_syntax)
DO
	lv_pos ++
	temp_str = mid(lv_dw_syntax,lv_pos,1)
	if temp_str = '(' then
		left_cnt ++
	else
		if temp_str = ')' then
			right_cnt ++
		end if
	end if
LOOP UNTIL (right_cnt = left_cnt) or (lv_pos >= lv_len)

// check for errors
if right_cnt <> left_cnt then
	messagebox("PROGRAM ERROR","Unable to determine TABLE section of datawindow.")
	return
end if

// extract table section from syntax
lv_dw_syntax = mid(lv_dw_syntax,1,lv_pos)
if gc_debug_mode then
	messagebox ("GRAPH - DW TABLE SYNTAX",lv_dw_syntax)
end if

// add datawindow and band sections for graph DW to syntax
lv_dw_syntax = "release 3;~r~n"		&
				+ "datawindow(units=1 timer_interval=0 color=" + String( stars_colors.window_background ) + " " &
				+ "processing=3 print.documentname=~"GRAPH PRINT~" "  	&
				+ "print.orientation = 1 print.margin.left = 12 "  	&
				+ "print.copies = 1 " &
				+ "print.margin.right = 12 print.margin.top = 12 "  	&
				+ "print.margin.bottom = 12 print.paper.source = 0 "  &
				+ "print.paper.size = 0 print.prompt=no )" 		&
				+ "summary(height=0 color=~"" + String( stars_colors.transparent ) + "~")~r~n"		&
				+ "footer(height=0 color=~"" + String( stars_colors.transparent ) + "~")~r~n"  		&
				+ "detail(height=0 color=~"" + String( stars_colors.transparent ) + "~")~r~n"		&
				+ lv_dw_syntax

// add syntax for default graph settings 
lv_dw_syntax = lv_dw_syntax &
				+   "graph(band=background x=~"1~" y=~"2~" height=~"1301~" "	&
	+ "width=~"2647~" graphtype=~"7~" perspective=~"2~" "	&
	+ "rotation=~"-20~" color=~"" + String( stars_colors.window_text ) + "~" backcolor=~"" + String( stars_colors.window_background ) + "~" "	&
	+ "shadecolor=~"8355711~" range= 0 border=~"3~" "	&
	+ "overlappercent=~"0~" spacing=~"100~" elevation=~"20~" "	&
	+ "depth=~"100~" name=gr_1  sizetodisplay=1  category=~"~"  "	&
	+ "values=~"~"  title=~"~"  "	&
	+ "title.dispattr.backcolor=~"553648127~"  "	&
	+ "title.dispattr.alignment=~"2~"  title.dispattr.autosize=~"1~"  "	&
	+ "title.dispattr.font.charset=~"0~"  " 	&
	+ "title.dispattr.font.escapement=~"0~"  "	&
	+ "title.dispattr.font.face=~"Arial~"  "	&
	+ "title.dispattr.font.family=~"2~"  "	&
	+ "title.dispattr.font.height=~"1~"  "	&
	+ "title.dispattr.font.italic=~"0~"  "	&
	+ "title.dispattr.font.orientation=~"0~"  "	&
	+ "title.dispattr.font.pitch=~"2~"  "	&
	+ "title.dispattr.font.strikethrough=~"0~"  "	&
	+ "title.dispattr.font.underline=~"0~"  "	&
	+ "title.dispattr.font.weight=~"700~"  "	&
	+ "title.dispattr.format=~"[general]~"  "	&
	+ "title.dispattr.textcolor=~"0~"  legend=~"4~"  "	&
	+ "legend.dispattr.backcolor=~"536870912~"  "	&
	+ "legend.dispattr.alignment=~"0~"  "	&
	+ "legend.dispattr.autosize=~"1~"  "	&
	+ "legend.dispattr.font.charset=~"0~"  "	&
	+ "legend.dispattr.font.escapement=~"0~"  "	&
	+ "legend.dispattr.font.face=~"Arial~"  "	&
	+ "legend.dispattr.font.family=~"2~"  "	&
	+ "legend.dispattr.font.height=~"1~"  "	&
	+ "legend.dispattr.font.italic=~"0~"  "	&
	+ "legend.dispattr.font.orientation=~"0~"  "	&
	+ "legend.dispattr.font.pitch=~"2~"  "	&
	+ "legend.dispattr.font.strikethrough=~"0~"  "	&
	+ "legend.dispattr.font.underline=~"0~"  "	&
	+ "legend.dispattr.font.weight=~"400~"  "	&
	+ "legend.dispattr.format=~"[general]~"  "	&
	+ "legend.dispattr.textcolor=~"0~"~r~n "&
	+ "	series.autoscale=~"1~"  series.droplines=~"0~"  series.frame=~"1~"  series.label=~"~"  series.majordivisions=~"0~"  series.majorgridline=~"0~"  "	&
	+ "series.majortic=~"3~"  series.maximumvalue=~"0~"  series.minimumvalue=~"0~"  series.minordivisions=~"0~"  series.minorgridline=~"0~"  series.minortic=~"1~"  "	&
	+ "series.originline=~"1~"  series.primaryline=~"1~"  series.roundto=~"0~"  series.scaletype=~"1~"  series.scalevalue=~"1~"  series.secondaryline=~"0~"  "	&
	+ "series.shadebackedge=~"0~"  series.dispattr.backcolor=~"536870912~"  series.dispattr.alignment=~"0~"  series.dispattr.autosize=~"1~"  "	&
	+ "series.dispattr.font.charset=~"0~"  series.dispattr.font.escapement=~"0~"  series.dispattr.font.face=~"Arial~"  series.dispattr.font.family=~"2~"  "	&
	+ "series.dispattr.font.height=~"1~"  series.dispattr.font.italic=~"0~"  series.dispattr.font.orientation=~"0~"  series.dispattr.font.pitch=~"2~"  series.dispattr.font.strikethrough=~"0~"  series.dispattr.font.underline=~"0~"  series.dispattr.font.weight=~"400~"  series.dispattr.format=~"[general]~"  series.dispattr.textcolor=~"0~"  series.labeldispattr.backcolor=~"553648127~"  series.labeldispattr.alignment=~"2~"  series.labeldispattr.autosize=~"1~"  series.labeldispattr.font.charset=~"0~"  series.labeldispattr.font.escapement=~"0~"  series.labeldispattr.font.face=~"Arial~"  series.labeldispattr.font.family=~"2~"  series.labeldispattr.font.height=~"1~"  series.labeldispattr.font.italic=~"0~"  series.labeldispattr.font.orientation=~"0~"  series.labeldispattr.font.pitch=~"2~"  series.labeldispattr.font.strikethrough=~"0~"  series.labeldispattr.font.underline=~"0~"  series.labeldispattr.font.weight=~"400~"  series.labeldispattr.format=~"[general]~"  series.labeldispattr.textcolor=~"0~" ~r~n"	&
	+ "	category.autoscale=~"1~"  category.droplines=~"0~"  category.frame=~"1~"  category.label=~"(None)~"  category.majordivisions=~"0~"  category.majorgridline=~"0~"  "	&
	+ "category.majortic=~"3~"  category.maximumvalue=~"5~"  category.minimumvalue=~"0~"  category.minordivisions=~"0~"  category.minorgridline=~"0~"  "	&
	+ "category.minortic=~"1~"  category.originline=~"0~"  category.primaryline=~"1~"  category.roundto=~"0~"  category.scaletype=~"1~"  category.scalevalue=~"1~"  "	&
	+ "category.secondaryline=~"0~"  category.shadebackedge=~"1~"  category.dispattr.backcolor=~"556870912~"  category.dispattr.alignment=~"2~"  "	&
	+ "category.dispattr.autosize=~"1~"  category.dispattr.font.charset=~"0~"  category.dispattr.font.escapement=~"0~"  category.dispattr.font.face=~"Arial~"  "	&
	+ "category.dispattr.font.family=~"2~"  category.dispattr.font.height=~"1~"  category.dispattr.font.italic=~"0~"  category.dispattr.font.orientation=~"0~"  "	&
	+ "category.dispattr.font.pitch=~"2~"  category.dispattr.font.strikethrough=~"0~"  category.dispattr.font.underline=~"0~"  category.dispattr.font.weight=~"400~"  "	&
	+ "category.dispattr.format=~"[general]~"  category.dispattr.textcolor=~"0~"  category.labeldispattr.backcolor=~"556870912~"  category.labeldispattr.alignment=~"2~"  category.labeldispattr.autosize=~"1~"  category.labeldispattr.font.charset=~"0~"  category.labeldispattr.font.escapement=~"0~"  category.labeldispattr.font.face=~"Arial~"  category.labeldispattr.font.family=~"2~"  category.labeldispattr.font.height=~"1~"  category.labeldispattr.font.italic=~"0~"  category.labeldispattr.font.orientation=~"0~"  category.labeldispattr.font.pitch=~"2~"  category.labeldispattr.font.strikethrough=~"0~"  category.labeldispattr.font.underline=~"0~"  category.labeldispattr.font.weight=~"400~"  category.labeldispattr.format=~"[general]~"  category.labeldispattr.textcolor=~"0~" ~r~n"	&
	+ "	values.autoscale=~"1~"  values.droplines=~"0~"  values.frame=~"1~"  values.label=~"(None)~"  values.majordivisions=~"0~"  values.majorgridline=~"0~"  "	&
	+ "values.majortic=~"3~"  values.maximumvalue=~"250~"  values.minimumvalue=~"0~"  values.minordivisions=~"0~"  values.minorgridline=~"0~"  values.minortic=~"1~"  "	&
	+ "values.originline=~"1~"  values.primaryline=~"1~"  values.roundto=~"0~"  values.scaletype=~"1~"  values.scalevalue=~"1~"  values.secondaryline=~"0~"  "	&
	+ "values.shadebackedge=~"0~"  values.dispattr.backcolor=~"556870912~"  values.dispattr.alignment=~"1~"  values.dispattr.autosize=~"1~"  values.dispattr.font.charset=~"0~"  "	&
	+ "values.dispattr.font.escapement=~"0~"  values.dispattr.font.face=~"Arial~"  values.dispattr.font.family=~"2~"  values.dispattr.font.height=~"1~"  values.dispattr.font.italic=~"0~"  values.dispattr.font.orientation=~"0~"  "	&
	+ "values.dispattr.font.pitch=~"2~"  values.dispattr.font.strikethrough=~"0~"  values.dispattr.font.underline=~"0~"  values.dispattr.font.weight=~"400~"  values.dispattr.format=~"[General]~"  values.dispattr.textcolor=~"0~"  values.labeldispattr.backcolor=~"553648127~"  values.labeldispattr.alignment=~"2~"  values.labeldispattr.autosize=~"1~"  values.labeldispattr.font.charset=~"0~"  values.labeldispattr.font.escapement=~"900~"  values.labeldispattr.font.face=~"Arial~"  values.labeldispattr.font.family=~"2~"  values.labeldispattr.font.height=~"1~"  values.labeldispattr.font.italic=~"0~"  values.labeldispattr.font.orientation=~"0~"  values.labeldispattr.font.pitch=~"2~"  values.labeldispattr.font.strikethrough=~"0~"  values.labeldispattr.font.underline=~"0~"  values.labeldispattr.font.weight=~"400~"  values.labeldispattr.format=~"[general]~"  values.labeldispattr.textcolor=~"0~" )"
 
if (dw_2.Create(lv_dw_syntax)) < 1 then
	messagebox("ERROR","Unable to create graph datawindow from syntax")
	return
end if

//Use same filter as original dw
newfilter=in_dw_in.Describe('datawindow.table.filter')
if newfilter='?' then newfilter=''
dw_2.setfilter(newfilter)
in_dw_in.Sharedata(dw_2)

//cb_design.PostEvent(Clicked!)
//return
string ls_return

Open(w_graph_the_dw_2)
ls_return = message.StringParm
If ls_return = 'Cancel' then
	ib_disableclosequery = TRUE
	This.post event ue_close()
	Return
End if

em_zoom.text = '100'
em_rotation.text = "-20"
em_perspective.text = "2"
em_elevation.text = "20"
end event

on w_graph_the_dw.create
int iCurrent
call super::create
this.st_4=create st_4
this.pb_copy=create pb_copy
this.st_elevation=create st_elevation
this.em_elevation=create em_elevation
this.st_perspective=create st_perspective
this.em_perspective=create em_perspective
this.st_rotation=create st_rotation
this.em_rotation=create em_rotation
this.st_zoom=create st_zoom
this.em_zoom=create em_zoom
this.cbx_preview=create cbx_preview
this.cb_print2=create cb_print2
this.cb_design=create cb_design
this.cb_close=create cb_close
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.pb_copy
this.Control[iCurrent+3]=this.st_elevation
this.Control[iCurrent+4]=this.em_elevation
this.Control[iCurrent+5]=this.st_perspective
this.Control[iCurrent+6]=this.em_perspective
this.Control[iCurrent+7]=this.st_rotation
this.Control[iCurrent+8]=this.em_rotation
this.Control[iCurrent+9]=this.st_zoom
this.Control[iCurrent+10]=this.em_zoom
this.Control[iCurrent+11]=this.cbx_preview
this.Control[iCurrent+12]=this.cb_print2
this.Control[iCurrent+13]=this.cb_design
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.dw_2
end on

on w_graph_the_dw.destroy
call super::destroy
destroy(this.st_4)
destroy(this.pb_copy)
destroy(this.st_elevation)
destroy(this.em_elevation)
destroy(this.st_perspective)
destroy(this.em_perspective)
destroy(this.st_rotation)
destroy(this.em_rotation)
destroy(this.st_zoom)
destroy(this.em_zoom)
destroy(this.cbx_preview)
destroy(this.cb_print2)
destroy(this.cb_design)
destroy(this.cb_close)
destroy(this.dw_2)
end on

event ue_preopen;call super::ue_preopen;// process the parm sent
in_dw_in = message.powerobjectparm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectParm)

end event

event ue_postopen;call super::ue_postopen;
//em_zoom.text = '100'
//em_rotation.text = "-20"
//em_perspective.text = "2"
//em_elevation.text = "20"
//
end event

event resize;//****************************************************************
//AJS 09-09-98 Track #1573 Correct disappearing data in edit mask
//****************************************************************
string ls_zoom, ls_rotation, ls_perspective, ls_elevation
ls_zoom = em_zoom.text
ls_rotation = em_rotation.text
ls_perspective = em_perspective.text
ls_elevation = em_elevation.text

call super::resize;

em_zoom.text = ls_zoom
em_rotation.text = ls_rotation
em_perspective.text = ls_perspective
em_elevation.text = ls_elevation
end event

type st_4 from statictext within w_graph_the_dw
string accessiblename = "COPY"
string accessibledescription = "COPY"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 1452
integer width = 297
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "COPY"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

on clicked;pb_copy.triggerevent(Clicked!)
end on

type pb_copy from picturebutton within w_graph_the_dw
string accessiblename = "Copy"
string accessibledescription = "Copy"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 55
integer y = 1372
integer width = 297
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "copy1.bmp"
long textcolor = 33554432
long backcolor = 67108864
end type

on clicked;setpointer(hourglass!)
dw_2.Clipboard("gr_1")
end on

type st_elevation from statictext within w_graph_the_dw
boolean visible = false
string accessiblename = "Elevation"
string accessibledescription = "Elevation"
accessiblerole accessiblerole = statictextrole!
integer x = 1134
integer y = 1448
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Elevation"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_elevation from editmask within w_graph_the_dw
event enchange pbm_enchange
boolean visible = false
string accessiblename = "Elevation"
string accessibledescription = "Elevation"
accessiblerole accessiblerole = textrole!
integer x = 1458
integer y = 1440
integer width = 293
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 5
string minmax = "-90~~90"
end type

on enchange;string lv_message

setpointer(Hourglass!)

// edit the elevation amount
if not isnumber(em_elevation.text) then
	return
end if
if integer(em_elevation.text) < -90 then
	em_elevation.text = "-90"
end if
if integer(em_elevation.text) > 90 then
	em_elevation.text = "90"
end if

// Modify the elevation amount
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.elevation=" + em_elevation.text)
if len(lv_message) > 0 then
	messagebox("Elevation ERROR","Modify returned this message:~r~n" + lv_message)
end if


end on

type st_perspective from statictext within w_graph_the_dw
boolean visible = false
string accessiblename = "Perspective"
string accessibledescription = "Perspective"
accessiblerole accessiblerole = statictextrole!
integer x = 1079
integer y = 1344
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Perspective"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_perspective from editmask within w_graph_the_dw
event enchange pbm_enchange
boolean visible = false
string accessiblename = "Perspective"
string accessibledescription = "Perspective"
accessiblerole accessiblerole = textrole!
integer x = 1458
integer y = 1332
integer width = 293
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 5
string minmax = "1~~100"
end type

on enchange;string lv_message

setpointer(Hourglass!)

// edit the perspective amount
if not isnumber(em_perspective.text) then
	return
end if
if integer(em_perspective.text) < -1 then
	em_perspective.text = "1"
end if
if integer(em_perspective.text) > 100 then
	em_perspective.text = "100"
end if

// Modify the perspective amount
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.perspective=" + em_perspective.text)
if len(lv_message) > 0 then
	messagebox("Perspective ERROR","Modify returned this message:~r~n" + lv_message)
end if


end on

type st_rotation from statictext within w_graph_the_dw
boolean visible = false
string accessiblename = "Rotation"
string accessibledescription = "Rotation"
accessiblerole accessiblerole = statictextrole!
integer x = 1166
integer y = 1240
integer width = 261
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Rotation"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_rotation from editmask within w_graph_the_dw
event enchange pbm_enchange
boolean visible = false
string accessiblename = "Rotation"
string accessibledescription = "Rotation"
accessiblerole accessiblerole = textrole!
integer x = 1458
integer y = 1224
integer width = 293
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 5
string minmax = "-90~~90"
end type

on enchange;string lv_message

setpointer(Hourglass!)

// edit the rotation amount
if isnull(em_rotation.text) or em_rotation.text = " " &
	or em_rotation.text = "" then
	em_rotation.text = "0"
end if
if not isnumber(em_rotation.text) then
	return
end if
if integer(em_rotation.text) < -90 then
	em_rotation.text = "-90"
end if
if integer(em_rotation.text) > 90 then
	em_rotation.text = "90"
end if

// modify the rotation amount
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.rotation=" + em_rotation.text)
if len(lv_message) > 0 then
	messagebox("Rotation ERROR","Modify returned this message:~r~n" + lv_message)
end if

end on

type st_zoom from statictext within w_graph_the_dw
boolean visible = false
string accessiblename = "Zoom %"
string accessibledescription = "Zoom %"
accessiblerole accessiblerole = statictextrole!
integer x = 398
integer y = 1332
integer width = 283
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Zoom %"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_zoom from editmask within w_graph_the_dw
event enchange pbm_enchange
boolean visible = false
string accessiblename = "Zoom"
string accessibledescription = "Zoom"
accessiblerole accessiblerole = textrole!
integer x = 704
integer y = 1316
integer width = 247
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 5
string minmax = "1~~100"
end type

on enchange;// adjust zoom percent


string lv_error

setpointer(Hourglass!)

// edit the zoom percent entered
if not isnumber(em_zoom.text) then
	return
else
	if integer(em_zoom.text) < 1 then
		em_zoom.text = "5"
	else
		if integer(em_zoom.text) > 100 then
			em_zoom.text = "100"
		end if
	end if
end if

// modify the zoom in the DW
lv_error = 	dw_2.Modify("datawindow.print.preview.zoom = " + em_zoom.text)
if len(lv_error) > 0 then
	messagebox("ERROR","Zoom error: " + lv_error)
	return
end if

end on

type cbx_preview from checkbox within w_graph_the_dw
string accessiblename = "Print Preview"
string accessibledescription = "Print Preview"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 439
integer y = 1440
integer width = 530
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Print Preview"
end type

on clicked;// this script controls the print preview function

string lv_error


setpointer(HourGlass!)
if this.checked then
	dw_2.hscrollbar=true
	lv_error = 	dw_2.Modify("datawindow.print.preview.zoom = " + em_zoom.text)
	if len(lv_error) > 0 then
		messagebox("ERROR","Zoom error: " + lv_error)
		return
	end if
	lv_error = 	dw_2.Modify("datawindow.print.preview = yes")
	if len(lv_error) > 0 then
		messagebox("ERROR","Preview error: " + lv_error)
		return
	end if
	st_zoom.visible = TRUE
	em_zoom.visible = TRUE
else
	dw_2.hscrollbar=false
	lv_error = 	dw_2.Modify("datawindow.print.preview = no")
	if len(lv_error) > 0 then
		messagebox("ERROR","Preview error: " + lv_error)
		return
	end if
	st_zoom.visible = FALSE
	em_zoom.visible = FALSE
end if
end on

type cb_print2 from u_cb within w_graph_the_dw
boolean visible = false
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 55
integer y = 1228
integer width = 297
integer height = 108
integer taborder = 30
integer weight = 400
boolean enabled = false
string text = "&Print"
end type

on clicked;string rc
rc=dw_2.Modify("DataWindow.Print.Page.Range='1'")
rc = dw_2.Modify('datawindow.print.copies = 1')
//messagebox('',rc)
dw_2.print(TRUE)

//int job
//job = PrintOpen("Graph")
//PrintDataWindow(job,dw_2)
//PrintClose(job)
end on

type cb_design from u_cb within w_graph_the_dw
string accessiblename = "Design"
string accessibledescription = "Design..."
integer x = 1801
integer y = 1404
integer width = 370
integer height = 108
integer taborder = 90
integer weight = 400
string text = "&Design..."
end type

on clicked;setpointer(Hourglass!)
if not isvalid(in_dw_in) then
	messagebox("NOTICE","The data being graphed is no longer available.")
	cb_close.postevent(Clicked!)
	return
end if
if not isvalid(w_graph_the_dw_2) then
	open(w_graph_the_dw_2,parent)	
else
	w_graph_the_dw_2.visible = TRUE
//	w_graph_the_dw_2.Windowstate = Normal!
end if

end on

type cb_close from u_cb within w_graph_the_dw
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2263
integer y = 1404
integer width = 370
integer height = 108
integer taborder = 80
integer weight = 400
string text = "&Close"
end type

on clicked;setpointer(HourGlass!)
close(parent)
end on

type dw_2 from u_dw within w_graph_the_dw
string accessiblename = "Graph"
string accessibledescription = "Graph"
integer y = 4
integer width = 2702
integer height = 1204
integer taborder = 10
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

