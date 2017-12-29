HA$PBExportHeader$w_dwlabel_definition.srw
$PBExportComments$Inherited from w_master
forward
global type w_dwlabel_definition from w_master
end type
type cb_1 from u_cb within w_dwlabel_definition
end type
type mle_description from multilineedit within w_dwlabel_definition
end type
end forward

global type w_dwlabel_definition from w_master
string accessiblename = "Definition"
string accessibledescription = "DEFINITION"
integer x = 0
integer y = 352
integer width = 1714
integer height = 600
string title = "DEFINITION"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
cb_1 cb_1
mle_description mle_description
end type
global w_dwlabel_definition w_dwlabel_definition

event open;call super::open;//This window is now capable of handling a dw with a join in it. If your
//dw has a join, set gv_element_table_type and gv_element_table_type2
//to the respective table types you are using. If there is no join,
//set gv_element_table_type2 to ''. -DJP 8/94

//11/24/98	FNC	Track 1989. Add gv_element_table_type3 to lookup tables so that
//						columns on all three tables in ratio_proc_sum are eligible for
//						lookup.
// newhcange

integer li_x
boolean lv_found=false
string table_name,table_type[3],sql_statement

table_type[1]=gv_element_table_type
table_type[2]=gv_element_table_type2
table_type[3]=gv_element_table_type3							// FNC 11/24/98

for li_x=1 to 3														// FNC 11/24/98
	if table_type[li_x]<>'' then
		Select ELEM_DESC into :mle_description.text 
		FROM Dictionary
		Where ELEM_Type IN ('CL','CC') and
				ELEM_TBL_TYPE = Upper( :table_type[li_x] ) and
				ELEM_NAME = Upper( :gv_element_name )
			Using stars2ca;

		if (stars2ca.of_check_status()=0) then
			lv_found=true
			exit
		elseif (stars2ca.sqlcode<>0) and (stars2ca.sqlcode<>100) Then
			errorbox(stars2ca,'Error Reading Dictionary Table where Elem Type = CL, ELEM_TBL_TYPE = ' + table_type[li_x] + ' and ELEM_NAME = ' + gv_element_name)
			cb_1.PostEvent(Clicked!)
			Stars2ca.of_commit()
			return 
		end if
	end if
next

if not lv_found then
	messagebox('Not Found', gv_element_name + ' is not in the Dictionary Table')
	cb_1.PostEvent(Clicked!)
end if

IF Stars2ca.of_commit() < 0 THEN
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95
end event

on w_dwlabel_definition.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.mle_description=create mle_description
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.mle_description
end on

on w_dwlabel_definition.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.mle_description)
end on

type cb_1 from u_cb within w_dwlabel_definition
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 1422
integer y = 404
integer width = 242
string text = "&Close"
boolean cancel = true
boolean default = true
end type

on clicked;close(parent)
end on

type mle_description from multilineedit within w_dwlabel_definition
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 18
integer y = 16
integer width = 1646
integer height = 368
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 255
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

