HA$PBExportHeader$w_prov_choices.srw
$PBExportComments$Inherited from w_master
forward
global type w_prov_choices from w_master
end type
type st_1 from statictext within w_prov_choices
end type
type cb_cancel from u_cb within w_prov_choices
end type
type cb_ok from u_cb within w_prov_choices
end type
type lb_prov_choices from listbox within w_prov_choices
end type
end forward

global type w_prov_choices from w_master
string accessiblename = "Provider Choices"
string accessibledescription = "Provider Choices"
accessiblerole accessiblerole = windowrole!
integer x = 672
integer y = 264
integer width = 1440
integer height = 908
string title = "Provider Choices"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
lb_prov_choices lb_prov_choices
end type
global w_prov_choices w_prov_choices

type variables
sx_prov_query_structure  iv_prov_query
end variables

forward prototypes
public function integer wf_find_index (string arg_choice)
end prototypes

public function integer wf_find_index (string arg_choice);//This window function sends a search argument and searches the	
//array to see if it is there.  if it is found it returns the index of
//the array else it returns -1.

integer lv_counter,lv_upperbound
boolean lv_found

lv_upperbound = Upperbound(iv_prov_query.prov_fields)
for lv_counter = 1 to lv_Upperbound
	if iv_prov_query.prov_fields[lv_counter].label = arg_choice then
		lv_found = TRUE
		exit
	end if
	lv_found = FALSE
next
		
if lv_found = TRUE Then
	return lv_counter
else
	return -1
end if	



end function

event open;call super::open;//This loops through and loads the listbox with the labels of
//columns passed in

string lv_col_label
integer lv_counter,lv_position,lv_upperbound
string lv_where_message
string	ls_tbl_type, ls_col_name

//Loops through the columns passed in
lv_upperbound = upperbound(iv_prov_query.prov_fields[])
for lv_counter = 1 to lv_upperbound

	//Reads the dictionary to get the label for the current field name
	ls_tbl_type = Upper( iv_prov_query.prov_fields[lv_counter].table_type )
	ls_col_name = Upper( iv_prov_query.prov_fields[lv_counter].prov_col_name )
	
	lv_col_label = gnv_dict.event ue_get_elem_label( ls_tbl_type, ls_col_name )
	
	if lv_col_label = gnv_dict.ics_not_found Then
		lv_where_message = 'Elem_type = CL AND ELEM_TBL_TYPE = ' + iv_prov_query.prov_fields[lv_counter].table_type + ' AND ELEM_NAME = ' + iv_prov_query.prov_fields[lv_counter].prov_col_name
		errorbox(stars2ca,"Cannot find the column in the Dictionary: " + lv_where_message)
		return
	elseif lv_col_label = gnv_dict.ics_error Then
		lv_where_message = 'Elem_type = CL AND ELEM_TBL_TYPE = ' + iv_prov_query.prov_fields[lv_counter].table_type + ' AND ELEM_NAME = ' + iv_prov_query.prov_fields[lv_counter].prov_col_name		
		errorbox(stars2ca,"Error Reading the Dictionary: " + lv_where_message)
		return
	end if
	
	//Strips out ~r or ~n
	if match(lv_col_label,"~~r") Then
		lv_position = pos(lv_col_label,"~~r")
		lv_col_label = Replace(lv_col_label,lv_position,2," ")
	end if
  
	if match(lv_col_label,"~~n") Then
		lv_position = pos(lv_col_label,"~~n")
		lv_col_label = Replace(lv_col_label,lv_position,2," ")
	end if

	//If the SQl doesn't fail then structure is with the labels and
	//that all fields are selected
	iv_prov_query.prov_fields[lv_counter].label = lv_col_label
	iv_prov_query.prov_fields[lv_counter].selected = TRUE

	//Adds the label to the listbox
	lb_prov_choices.additem(lv_col_label)
next

COMMIT Using Stars2ca;							
IF Stars2ca.of_check_status()	<	0		THEN			
	ErrorBox(Stars2ca,'Error on COMMIT')	
END IF												


//This causes all selections to be highlighted. (This  is part
//of the functionality)
lb_prov_choices.SetState(0, TRUE)

end event

on w_prov_choices.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.lb_prov_choices=create lb_prov_choices
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.lb_prov_choices
end on

on w_prov_choices.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.lb_prov_choices)
end on

event ue_preopen;call super::ue_preopen;
iv_prov_query = message.powerobjectparm

//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

end event

type st_1 from statictext within w_prov_choices
string accessiblename = "Provider Choices"
string accessibledescription = "Provider Choices"
accessiblerole accessiblerole = statictextrole!
integer x = 69
integer y = 60
integer width = 539
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Provider Choices:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from u_cb within w_prov_choices
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1006
integer y = 692
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Close"
boolean cancel = true
end type

event clicked;sx_prov_query_structure		lstr_prov_query

//	Initialize iv_prov_query

iv_prov_query	=	lstr_prov_query
iv_prov_query.do_prov_query	=	FALSE

CloseWithReturn(parent,iv_prov_query)

end event

type cb_ok from u_cb within w_prov_choices
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 78
integer y = 692
integer width = 338
integer height = 108
integer taborder = 20
string text = "&OK"
boolean default = true
end type

event clicked;//Loops thourgh the listbox and finds out if the row is
//deselected.  If it is then a boolean is set to False to tell this

integer lv_lb_index,lv_index

for lv_lb_index = 1 to lb_prov_choices.totalitems()
	if lb_prov_choices.state(lv_lb_index) = 0 Then 
		//	entry is not selected
		lv_index = wf_find_index(lb_prov_choices.text(lv_lb_index))
		iv_prov_query.prov_fields[lv_index].selected = FALSE
	else
		//	At least one entry is selected
		iv_prov_query.do_prov_query	=	TRUE
	end if
next

closewithreturn(parent,iv_prov_query)
end event

type lb_prov_choices from listbox within w_prov_choices
string accessiblename = "Provider Choices"
string accessibledescription = "Provider Choices"
long textcolor = 33554432
accessiblerole accessiblerole = listrole!
integer x = 82
integer y = 144
integer width = 1266
integer height = 520
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

