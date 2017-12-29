$PBExportHeader$w_graph_the_dw_2.srw
$PBExportComments$inherited from w_master
forward
global type w_graph_the_dw_2 from w_master
end type
type rb_avg from radiobutton within w_graph_the_dw_2
end type
type rb_min from radiobutton within w_graph_the_dw_2
end type
type sle_graph_type from singlelineedit within w_graph_the_dw_2
end type
type cb_graph_type from u_cb within w_graph_the_dw_2
end type
type rb_cat_max from radiobutton within w_graph_the_dw_2
end type
type rb_cat_sum from radiobutton within w_graph_the_dw_2
end type
type rb_cat_count from radiobutton within w_graph_the_dw_2
end type
type rb_cat_none from radiobutton within w_graph_the_dw_2
end type
type st_5 from statictext within w_graph_the_dw_2
end type
type sle_title from singlelineedit within w_graph_the_dw_2
end type
type st_4 from statictext within w_graph_the_dw_2
end type
type st_3 from statictext within w_graph_the_dw_2
end type
type st_2 from statictext within w_graph_the_dw_2
end type
type lb_columns_3 from listbox within w_graph_the_dw_2
end type
type lb_columns_2 from listbox within w_graph_the_dw_2
end type
type st_1 from statictext within w_graph_the_dw_2
end type
type lb_columns from listbox within w_graph_the_dw_2
end type
type st_column_count from statictext within w_graph_the_dw_2
end type
type cb_min from u_cb within w_graph_the_dw_2
end type
type gb_1 from groupbox within w_graph_the_dw_2
end type
type cb_cancel from commandbutton within w_graph_the_dw_2
end type
end forward

global type w_graph_the_dw_2 from w_master
string accessiblename = "Graph Options Window"
string accessibledescription = "Graph Options Window"
accessiblerole accessiblerole = windowrole!
integer x = 123
integer y = 384
integer width = 2469
integer height = 1164
string title = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
string icon = "GRAPH2.ICO"
rb_avg rb_avg
rb_min rb_min
sle_graph_type sle_graph_type
cb_graph_type cb_graph_type
rb_cat_max rb_cat_max
rb_cat_sum rb_cat_sum
rb_cat_count rb_cat_count
rb_cat_none rb_cat_none
st_5 st_5
sle_title sle_title
st_4 st_4
st_3 st_3
st_2 st_2
lb_columns_3 lb_columns_3
lb_columns_2 lb_columns_2
st_1 st_1
lb_columns lb_columns
st_column_count st_column_count
cb_min cb_min
gb_1 gb_1
cb_cancel cb_cancel
end type
global w_graph_the_dw_2 w_graph_the_dw_2

type variables
u_dw dw_name
string hold_col_names[]       /* array of column names */
string hold_col_type[]       /* array of column types */
int num_of_columns
boolean process_done = FALSE
string in_graph_type
int in_graph_type_number
end variables

forward prototypes
public function integer wf_grapherror (string as_error_txt)
end prototypes

public function integer wf_grapherror (string as_error_txt);/*
05/15/2000	Gary-R	Ts2284D	GPF graphing
*/

MessageBox( "Graph Error", as_error_txt + "~n~rUnable to proceed graphing." )
IF IsValid( w_graph_the_dw.cb_close ) THEN w_graph_the_dw.cb_close.PostEvent( Clicked! ) 
cb_cancel.EVENT Clicked()
RETURN -1
end function

event open;call super::open;/********************************************************************/
/*         WINDOW:                 */
/********************************************************************/
/* This window is called when                                   	  */
//                                                                  */
// DKG 04/12/96  Added call to set colors. PROB 856 STARCARE disk.  */
/* 05/15/2000	Gary-R	Ts2284D	Added wf_GraphError to prevent GPF */
/********************************************************************/  								

int suba
string temp_str, lv_error
string hold_label, ls_err_txt
long new_line_pos

setpointer(Hourglass!)

if not isvalid(w_graph_the_dw.in_dw_in) then
	yield() 	// done to allow resp window that called this to close
	ls_err_txt = "Datawindow source being graphed is no longer valid."
	RETURN wf_GraphError( ls_err_txt )	//Gary-R	05/15/2000	Ts2284D
end if
num_of_columns = integer(w_graph_the_dw.in_dw_in.Describe('datawindow.column.count'))
if num_of_columns < 1 then
	ls_err_txt = "Unable to obtain column names in order to allow you to select which columns to graph."
	RETURN wf_GraphError( ls_err_txt )	//Gary-R	05/15/2000	Ts2284D
end if

st_column_count.text = string(num_of_columns)

// LOAD COLUMN NAMES AND WIDTHS INTO TABLES, LOAD LABELS INTO LISTBOX  
FOR suba = 1 to num_of_columns
	hold_col_names[suba] = w_graph_the_dw.in_dw_in.Describe('#'+string(suba)+'.name')	
	hold_col_type[suba] = w_graph_the_dw.in_dw_in.Describe(hold_col_names[suba] + '.coltype')	
	hold_label = trim(w_graph_the_dw.in_dw_in.Describe(hold_col_names[suba]+'_t.text'))


	if (hold_col_names[suba] = "" OR hold_col_names[suba] = "!"   &
		OR hold_col_names[suba] = "?"                   		&
 		OR hold_label = "!" OR hold_label = "?"  				&
		OR hold_label = ""       ) then
		ls_err_txt = "Unable to obtain column names in order to allow you to select which columns to graph."
		RETURN wf_GraphError( ls_err_txt )	//Gary-R	05/15/2000		Ts2284D
	end if
	// Strip out new line/carrage return characters
	new_line_pos = pos(hold_label,"~n")	
	if new_line_pos > 1 then
		temp_str = mid(hold_label,1,new_line_pos - 1)  + " " &
					+ mid(hold_label,new_line_pos + 1,len(hold_label) - new_line_pos)			
		hold_label = temp_str
	end if
	new_line_pos = pos(hold_label,"~r")	
	if new_line_pos > 1 then
		temp_str = mid(hold_label,1,new_line_pos - 1)  + " " &
					+ mid(hold_label,new_line_pos + 1,len(hold_label) - new_line_pos)			
		hold_label = temp_str
	end if

	if (lb_columns.AddItem(hold_label)) < 1		&
	  OR (lb_columns_2.additem(hold_label)) < 1	&
	  OR (lb_columns_3.additem(hold_label)) < 1 then
		yield()
		ls_err_txt = "Unable to add an item to the graph."
		RETURN wf_GraphError( ls_err_txt )	//Gary-R	05/15/2000	Ts2284D
	end if
NEXT

// set up graph type in order to set correct control enabled defaults
lv_error = w_graph_the_dw.dw_2.Describe("gr_1.graphtype")
if lv_error = "!" or lv_error = "?" then
	messagebox("Graph Type ERROR", "Unable to determine graph type - Please select a graph type")
else
	CHOOSE CASE lv_error
		CASE "15"
			in_graph_type_number = 15
			sle_graph_type.text = "3D Area"
		CASE "1"
			in_graph_type_number = 1
			sle_graph_type.text = "Area"
		CASE "6"
			in_graph_type_number = 6
			sle_graph_type.text = "Stacked Bar 3D Obj"
		CASE "5"
			in_graph_type_number = 5
			sle_graph_type.text = "Stacked Bar"
		CASE "4"
			in_graph_type_number = 4
			sle_graph_type.text = "3D Bar Obj"
		CASE "3"
			in_graph_type_number = 3
			sle_graph_type.text = "3D Bar"
		CASE "2"
			in_graph_type_number = 2
			sle_graph_type.text = "BAR"
		CASE "11"
			in_graph_type_number = 11
			sle_graph_type.text = "3D Stacked Col Obj"
		CASE "10"
			in_graph_type_number = 10
			sle_graph_type.text = "Stacked Column"
		CASE "9"
			in_graph_type_number = 9
			sle_graph_type.text = "3D Col Obj"
		CASE "8"
			in_graph_type_number = 8
			sle_graph_type.text = "3D Column"
		CASE "7"
			in_graph_type_number = 7
			sle_graph_type.text = "Column"
		CASE "16"
			in_graph_type_number = 16
			sle_graph_type.text = "3D Line"
		CASE "12"
			in_graph_type_number = 12
			sle_graph_type.text = "Line"
		CASE "17"
			in_graph_type_number = 17
			sle_graph_type.text = "3D Pie"
		CASE "13"
			in_graph_type_number = 13
			sle_graph_type.text = "Pie"
		CASE "14"
			in_graph_type_number = 14
			sle_graph_type.text = "Scatter"
		CASE ELSE
			in_graph_type_number = 0
			sle_graph_type.text = "ERROR"
	END CHOOSE	
end if

return
end event

on w_graph_the_dw_2.create
int iCurrent
call super::create
this.rb_avg=create rb_avg
this.rb_min=create rb_min
this.sle_graph_type=create sle_graph_type
this.cb_graph_type=create cb_graph_type
this.rb_cat_max=create rb_cat_max
this.rb_cat_sum=create rb_cat_sum
this.rb_cat_count=create rb_cat_count
this.rb_cat_none=create rb_cat_none
this.st_5=create st_5
this.sle_title=create sle_title
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.lb_columns_3=create lb_columns_3
this.lb_columns_2=create lb_columns_2
this.st_1=create st_1
this.lb_columns=create lb_columns
this.st_column_count=create st_column_count
this.cb_min=create cb_min
this.gb_1=create gb_1
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_avg
this.Control[iCurrent+2]=this.rb_min
this.Control[iCurrent+3]=this.sle_graph_type
this.Control[iCurrent+4]=this.cb_graph_type
this.Control[iCurrent+5]=this.rb_cat_max
this.Control[iCurrent+6]=this.rb_cat_sum
this.Control[iCurrent+7]=this.rb_cat_count
this.Control[iCurrent+8]=this.rb_cat_none
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.sle_title
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.lb_columns_3
this.Control[iCurrent+15]=this.lb_columns_2
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.lb_columns
this.Control[iCurrent+18]=this.st_column_count
this.Control[iCurrent+19]=this.cb_min
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.cb_cancel
end on

on w_graph_the_dw_2.destroy
call super::destroy
destroy(this.rb_avg)
destroy(this.rb_min)
destroy(this.sle_graph_type)
destroy(this.cb_graph_type)
destroy(this.rb_cat_max)
destroy(this.rb_cat_sum)
destroy(this.rb_cat_count)
destroy(this.rb_cat_none)
destroy(this.st_5)
destroy(this.sle_title)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.lb_columns_3)
destroy(this.lb_columns_2)
destroy(this.st_1)
destroy(this.lb_columns)
destroy(this.st_column_count)
destroy(this.cb_min)
destroy(this.gb_1)
destroy(this.cb_cancel)
end on

type rb_avg from radiobutton within w_graph_the_dw_2
string accessiblename = "Avg"
string accessibledescription = "Avg"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1275
integer y = 800
integer width = 256
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Avg"
end type

on clicked;lb_columns_2.triggerevent(selectionchanged!)
end on

type rb_min from radiobutton within w_graph_the_dw_2
string accessiblename = "Min"
string accessibledescription = "Min"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1275
integer y = 612
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Min"
end type

on clicked;lb_columns_2.triggerevent(selectionchanged!)
end on

type sle_graph_type from singlelineedit within w_graph_the_dw_2
string accessiblename = "Graph Type"
string accessibledescription = "Graph Type"
accessiblerole accessiblerole = textrole!
integer x = 1742
integer y = 728
integer width = 626
integer height = 96
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Graph Type"
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type cb_graph_type from u_cb within w_graph_the_dw_2
string accessiblename = "Select Graph Type"
string accessibledescription = "Select Graph Type"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1742
integer y = 592
integer width = 649
integer height = 108
integer taborder = 60
string text = "&Select Graph Type"
end type

on clicked;open(w_graph_the_dw_type)
string lv_message
string lv_do_this
boolean lv_3d = FALSE

setpointer(Hourglass!)

if len(in_graph_type) < 2 then   // if no graph type selected on popup
	return
end if

CHOOSE CASE upper(in_graph_type)
	CASE "AREA3D"
		in_graph_type_number = 15
		sle_graph_type.text = "3D Area"
		lv_3d = TRUE
	CASE "AREA"
		in_graph_type_number = 1
		sle_graph_type.text = "Area"
	CASE "BARSTACKED3DOBJ"
		in_graph_type_number = 6
		sle_graph_type.text = "Stacked Bar 3D Obj"
	CASE "BARSTACKED"
		in_graph_type_number = 5
		sle_graph_type.text = "Stacked Bar"
	CASE "BAR3DOBJ"
		in_graph_type_number = 4
		sle_graph_type.text = "3D Bar Obj"
	CASE "BAR3D"
		in_graph_type_number = 3
		sle_graph_type.text = "3D Bar"
		lv_3d = TRUE
	CASE "BAR"
		in_graph_type_number = 2
		sle_graph_type.text = "BAR"
	CASE "COLSTACKED3DOBJ"
		in_graph_type_number = 11
		sle_graph_type.text = "3D Stacked Col Obj"
	CASE "COLSTACKED"
		in_graph_type_number = 10
		sle_graph_type.text = "Stacked Column"
	CASE "COL3DOBJ"
		in_graph_type_number = 9
		sle_graph_type.text = "3D Col Obj"
	CASE "COL3D"
		in_graph_type_number = 8
		sle_graph_type.text = "3D Col"
		lv_3d = TRUE
	CASE "COL"
		in_graph_type_number = 7
		sle_graph_type.text = "Column"
	CASE "LINE3D"
		in_graph_type_number = 16
		sle_graph_type.text = "3D Line"
		lv_3d = TRUE
	CASE "LINE"
		in_graph_type_number = 12
		sle_graph_type.text = "Line"
	CASE "PIE3D"
		in_graph_type_number = 17
		sle_graph_type.text = "3D Pie"
		lv_3d = TRUE
	CASE "PIE"
		in_graph_type_number = 13
		sle_graph_type.text = "Pie"
	CASE "SCATTER"
		in_graph_type_number = 14
		sle_graph_type.text = "Scatter"
	CASE ELSE
		in_graph_type_number = 0
		sle_graph_type.text = "ERROR"
END CHOOSE
lv_do_this = "gr_1.graphtype=" + string(in_graph_type_number)
lv_message = w_graph_the_dw.dw_2.Modify(lv_do_this)
if len(lv_message) > 0 then
	messagebox("Graph Type ERROR","Modify returned this message:~r~n" + lv_message)
	return
end if

if lv_3d then
	w_graph_the_dw.em_perspective.visible = TRUE
	w_graph_the_dw.em_rotation.visible = TRUE
	w_graph_the_dw.em_elevation.visible = TRUE
	parent.show()
	w_graph_the_dw.st_perspective.visible = TRUE
	w_graph_the_dw.st_rotation.visible = TRUE
	w_graph_the_dw.st_elevation.visible = TRUE
	parent.show()
else
	w_graph_the_dw.em_perspective.visible = FALSE
	w_graph_the_dw.em_rotation.visible = FALSE
	w_graph_the_dw.em_elevation.visible = FALSE
	w_graph_the_dw.st_perspective.visible = FALSE
	w_graph_the_dw.st_rotation.visible = FALSE
	w_graph_the_dw.st_elevation.visible = FALSE
end if

end on

type rb_cat_max from radiobutton within w_graph_the_dw_2
string accessiblename = "Max"
string accessibledescription = "Max"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1275
integer y = 712
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Max"
end type

on clicked;lb_columns_2.triggerevent(selectionchanged!)
end on

type rb_cat_sum from radiobutton within w_graph_the_dw_2
string accessiblename = "Sum"
string accessibledescription = "Sum"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 937
integer y = 712
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sum"
end type

on clicked;lb_columns_2.triggerevent(selectionchanged!)
end on

type rb_cat_count from radiobutton within w_graph_the_dw_2
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 937
integer y = 808
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Count"
end type

on clicked;lb_columns_2.triggerevent(selectionchanged!)
end on

type rb_cat_none from radiobutton within w_graph_the_dw_2
string accessiblename = "None"
string accessibledescription = "None"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 937
integer y = 612
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "None"
boolean checked = true
end type

on clicked;lb_columns_2.triggerevent(selectionchanged!)
end on

type st_5 from statictext within w_graph_the_dw_2
string accessiblename = "Graph Title"
string accessibledescription = "Graph Title"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 580
integer width = 357
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Graph Title:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_title from singlelineedit within w_graph_the_dw_2
long backcolor = 1073741824
string accessiblename = "Graph Title"
string accessibledescription = "Graph Title"
accessiblerole accessiblerole = textrole!
integer x = 32
integer y = 664
integer width = 768
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

on modified;string lv_message

setpointer(Hourglass!)
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.title=" + "'" + sle_title.text + "'")
if len(lv_message) > 0 then
	messagebox("ERROR","MODIFY returned this message:~r~n" + lv_message)
end if
end on

type st_4 from statictext within w_graph_the_dw_2
string accessiblename = "Category - X Axis"
string accessibledescription = "Category - X Axis"
accessiblerole accessiblerole = statictextrole!
integer x = 9
integer y = 20
integer width = 795
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Category - X Axis"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_graph_the_dw_2
string accessiblename = "Series - Z Axis"
string accessibledescription = "Series - Z Axis"
accessiblerole accessiblerole = statictextrole!
integer x = 1641
integer y = 20
integer width = 768
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Series - Z Axis"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_graph_the_dw_2
string accessiblename = "Value - Y Axis"
string accessibledescription = "Value - Y Axis"
accessiblerole accessiblerole = statictextrole!
integer x = 832
integer y = 20
integer width = 782
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Value - Y Axis"
alignment alignment = center!
boolean focusrectangle = false
end type

type lb_columns_3 from listbox within w_graph_the_dw_2
string accessiblename = "Series - Z Axis"
string accessibledescription = "Series - Z Axis"
accessiblerole accessiblerole = listrole!
integer x = 1646
integer y = 108
integer width = 773
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;int selected_row
string lv_dw_mod
string lv_message
string selected_text

setpointer(Hourglass!)
selected_row = lb_columns_3.SelectedIndex()
selected_text = lb_columns_3.SelectedItem()

if selected_row < 1 then
	return
end if

lv_message = w_graph_the_dw.dw_2.Modify("gr_1.series=" + "'" + hold_col_names[selected_row] + "'")
if len(lv_message) > 0 then
	messagebox("Series ERROR","Modify returned this message:~r~n" + lv_message)
end if
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.series.maximumvalue='1'")
if len(lv_message) > 0 then
	messagebox("Series Maxvalue ERROR","Modify returned this message:~r~n" + lv_message)
end if
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.series.label=" + "'" + selected_text + "'")
if len(lv_message) > 0 then
	messagebox("Series Label ERROR","Modify returned this message:~r~n" + lv_message)
end if

end on

type lb_columns_2 from listbox within w_graph_the_dw_2
string accessiblename = "Value - Y Axis"
string accessibledescription = "Value - Y Axis"
accessiblerole accessiblerole = listrole!
integer x = 832
integer y = 108
integer width = 782
integer height = 400
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;int lv_selected_row
string lv_dw_mod
string lv_message
string lv_selected_text
string lv_use_this, lv_use_this_type

setpointer(Hourglass!)
lv_selected_row = lb_columns_2.SelectedIndex()
lv_selected_text = lb_columns_2.SelectedItem()


if lv_selected_row < 1 then
	return
end if

lv_use_this = hold_col_names[lv_selected_row] 
lv_use_this_type = hold_col_type[lv_selected_row]

// edit the aggregrate function selected
if (rb_min.checked or rb_cat_max.checked or rb_avg.checked 		&
		or rb_cat_sum.checked)												&
	and (not match(upper(lv_use_this_type),"NUMBER")	)		&
	and (not match(upper(lv_use_this_type),"DECIMAL")  ) then
	messagebox("Graph Information","The aggregrate function selected is not available for a non numeric column.~nPlease select another aggregate function",Stopsign!)
	return
end if
//messagebox("DW SYNTAX",w_graph_the_dw.dw_2.dwdescribe("datawindow.syntax"))
if rb_cat_count.checked then
	lv_use_this = "count(" + lv_use_this + " for graph)"
	lv_selected_text = "Count Of " + lv_selected_text
else
	if rb_cat_max.checked then
	 	lv_use_this = "max(" + lv_use_this + " for graph)"
		lv_selected_text = "Max Of " + lv_selected_text
	else
		if rb_cat_sum.checked then
		 	lv_use_this = "sum(" + lv_use_this + " for graph)"
			lv_selected_text = "Sum Of " + lv_selected_text
		else
			if rb_min.checked then
				lv_use_this = "min(" + lv_use_this + " for graph)"
				lv_selected_text = "Min Of " + lv_selected_text		
			else
				if rb_avg.checked then
						lv_use_this = "avg(" + lv_use_this + " for graph)"
						lv_selected_text = "Avg Of " + lv_selected_text
				end if
			end if	
		end if
	end if
end if

lv_message = w_graph_the_dw.dw_2.Modify("gr_1.values=" + "'" + lv_use_this + "'")
if len(lv_message) > 0 then
	messagebox("ERROR","Modify returned this message: " + lv_message)
end if
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.values.label=" + "'" + lv_selected_text + "'")
if len(lv_message) > 0 then
	messagebox("ERROR","Modify returned this message: " + lv_message)
end if

end on

type st_1 from statictext within w_graph_the_dw_2
string accessiblename = "Total Columns"
string accessibledescription = "Total Columns"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 916
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Total Columns:"
alignment alignment = center!
boolean focusrectangle = false
end type

type lb_columns from listbox within w_graph_the_dw_2
string accessiblename = "Category - X Axis"
string accessibledescription = "Category - X Axis"
accessiblerole accessiblerole = listrole!
integer x = 14
integer y = 108
integer width = 786
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;int selected_row
string lv_dw_mod
string lv_message
string selected_text
string lv_use_this


setpointer(Hourglass!)
selected_row = lb_columns.SelectedIndex()
selected_text = lb_columns.SelectedItem()


if selected_row < 1  then
	return
end if

lv_use_this = hold_col_names[selected_row] 

lv_message = w_graph_the_dw.dw_2.Modify("gr_1.category=" + "'" + lv_use_this + "'")
if len(lv_message) > 0 then
	messagebox("ERROR","Modify returned this message: " + lv_message)
end if
lv_message = w_graph_the_dw.dw_2.Modify("gr_1.category.label=" + "'" + selected_text + "'")
if len(lv_message) > 0 then
	messagebox("ERROR","Modify returned this message: " + lv_message)
end if

end on

type st_column_count from statictext within w_graph_the_dw_2
string accessiblename = "Column Count"
string accessibledescription = "Column Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 512
integer y = 916
integer width = 233
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_min from u_cb within w_graph_the_dw_2
string accessiblename = "Done"
string accessibledescription = "Done"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1751
integer y = 936
integer width = 265
integer height = 120
integer taborder = 80
string text = "&Done"
end type

event clicked;setpointer(Hourglass!)
//parent.visible = FALSE
//parent.Windowstate = Minimized!
closewithreturn(parent,'Okay')

end event

type gb_1 from groupbox within w_graph_the_dw_2
string accessiblename = "Value Aggregates"
string accessibledescription = "Value Aggregates"
accessiblerole accessiblerole = groupingrole!
integer x = 882
integer y = 540
integer width = 704
integer height = 376
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Value Aggregates"
end type

type cb_cancel from commandbutton within w_graph_the_dw_2
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2066
integer y = 936
integer width = 306
integer height = 120
integer taborder = 81
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,'Cancel')
end event

