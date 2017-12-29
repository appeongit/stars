$PBExportHeader$w_access_options.srw
forward
global type w_access_options from w_master
end type
type st_criteria from statictext within w_access_options
end type
type st_sql from statictext within w_access_options
end type
type st_labels from statictext within w_access_options
end type
type cbx_view from checkbox within w_access_options
end type
type cbx_criteria from checkbox within w_access_options
end type
type cb_cancel from commandbutton within w_access_options
end type
type cbx_sql from checkbox within w_access_options
end type
type st_1 from statictext within w_access_options
end type
type sle_table_name from singlelineedit within w_access_options
end type
type cb_ok from commandbutton within w_access_options
end type
end forward

global type w_access_options from w_master
string accessiblename = "Export Options"
string accessibledescription = "Export Options"
integer width = 1184
integer height = 1092
string title = "Export Options"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
st_criteria st_criteria
st_sql st_sql
st_labels st_labels
cbx_view cbx_view
cbx_criteria cbx_criteria
cb_cancel cb_cancel
cbx_sql cbx_sql
st_1 st_1
sle_table_name sle_table_name
cb_ok cb_ok
end type
global w_access_options w_access_options

type variables
sx_access_options		isx_access_options
end variables

forward prototypes
public subroutine uf_set_table_names ()
public function boolean uf_get_is_valid_name ()
end prototypes

public subroutine uf_set_table_names ();
st_labels.text   = "Creates an Access Query using STARS labels named " + sle_table_name.text + "_LABELS"
st_sql.text 	  = "Stores the SQL used to produce the results to " 	  + sle_table_name.text + "_SQL"
st_criteria.text = "Stores the Query Engine criteria to " 				  + sle_table_name.text + "_CRITERIA"
end subroutine

public function boolean uf_get_is_valid_name ();// 01/06/05 MikeF SPR4219d Add more validation for table names
string	ls_name, ls_char
int		li_index
n_cst_string lnv_string

ls_name = trim(sle_table_name.text)

IF len(ls_name) = 0 THEN
	MessageBox("Invalid Table Name","Result Table Name cannot be blank")
	SetFocus(sle_table_name)
	RETURN FALSE
END IF

IF pos(ls_name," ") > 0 THEN
	MessageBox("Invalid Table Name","Result Table Name cannot contain spaces")
	SetFocus(sle_table_name)
	RETURN FALSE
END IF

FOR li_index = 1 TO len(ls_name)
	ls_char = mid(ls_name,li_index,1)
	IF lnv_string.of_isalphanum(ls_char) &
	OR ls_char = '_' THEN
		// Valid character.
	ELSE
		MessageBox("Invalid Table Name","Invalid character " + ls_char + " used in Result Table Name.~r~r" + &
					  "Table name can only contain letters, numbers, and the underscore (_) character.")
		RETURN FALSE
	END IF
NEXT

RETURN TRUE


end function

on w_access_options.create
int iCurrent
call super::create
this.st_criteria=create st_criteria
this.st_sql=create st_sql
this.st_labels=create st_labels
this.cbx_view=create cbx_view
this.cbx_criteria=create cbx_criteria
this.cb_cancel=create cb_cancel
this.cbx_sql=create cbx_sql
this.st_1=create st_1
this.sle_table_name=create sle_table_name
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_criteria
this.Control[iCurrent+2]=this.st_sql
this.Control[iCurrent+3]=this.st_labels
this.Control[iCurrent+4]=this.cbx_view
this.Control[iCurrent+5]=this.cbx_criteria
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.cbx_sql
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_table_name
this.Control[iCurrent+10]=this.cb_ok
end on

on w_access_options.destroy
call super::destroy
destroy(this.st_criteria)
destroy(this.st_sql)
destroy(this.st_labels)
destroy(this.cbx_view)
destroy(this.cbx_criteria)
destroy(this.cb_cancel)
destroy(this.cbx_sql)
destroy(this.st_1)
destroy(this.sle_table_name)
destroy(this.cb_ok)
end on

event close;call super::close;CloseWithReturn( this, isx_access_options)
end event

event open;call super::open;string		ls_from

ls_from = Message.StringParm
setNull(Message.StringParm)

IF ls_from = "QUERY" THEN
	cbx_criteria.enabled = TRUE
	st_criteria.disabledlook = FALSE
END IF

sle_table_name.text = "EXP" + fx_get_next_key_id("PDQ_TMP_ID")
this.uf_set_table_names( )

end event

type st_criteria from statictext within w_access_options
string accessiblename = "Stores the Query Engine criteria to "
string accessibledescription = "Stores the Query Engine criteria to "
accessiblerole accessiblerole = statictextrole!
integer x = 110
integer y = 724
integer width = 997
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stores the Query Engine criteria to "
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_sql from statictext within w_access_options
string accessiblename = "Stores the SQL used to produce the results to "
string accessibledescription = "Stores the SQL used to produce the results to "
accessiblerole accessiblerole = statictextrole!
integer x = 110
integer y = 524
integer width = 997
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stores the SQL used to produce the results to "
boolean focusrectangle = false
end type

type st_labels from statictext within w_access_options
string accessiblename = "Creates an Access Query using STARS labels named"
string accessibledescription = "Creates an Access Query using STARS labels named"
accessiblerole accessiblerole = statictextrole!
integer x = 110
integer y = 324
integer width = 997
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Creates an Access Query using STARS labels named"
boolean focusrectangle = false
end type

type cbx_view from checkbox within w_access_options
string accessiblename = "Save Labels to Access Query"
string accessibledescription = "Save Labels to Access Query"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 32
integer y = 252
integer width = 1051
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Save Labels to Access Query"
boolean checked = true
end type

type cbx_criteria from checkbox within w_access_options
string accessiblename = "Save Criteria to Access"
string accessibledescription = "Save Criteria to Access"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 32
integer y = 644
integer width = 1051
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Save Criteria to Access"
end type

type cb_cancel from commandbutton within w_access_options
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 626
integer y = 872
integer width = 320
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Cancel"
end type

event clicked;isx_access_options.cancelled = TRUE
Parent.event close( )
end event

type cbx_sql from checkbox within w_access_options
string accessiblename = "Save SQL to Access"
string accessibledescription = "Save SQL to Access"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 32
integer y = 448
integer width = 1051
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Save SQL to Access"
end type

type st_1 from statictext within w_access_options
string accessiblename = "Results Table Name"
string accessibledescription = "Results Table Name"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 44
integer width = 873
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Results Table Name"
boolean focusrectangle = false
end type

type sle_table_name from singlelineedit within w_access_options
string accessiblename = "Table Name"
string accessibledescription = "Table Name"
accessiblerole accessiblerole = textrole!
integer x = 32
integer y = 132
integer width = 1088
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "<Enter Table Name here>"
integer limit = 25
borderstyle borderstyle = stylelowered!
end type

event modified;parent.uf_set_table_names( )
end event

type cb_ok from commandbutton within w_access_options
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 197
integer y = 872
integer width = 320
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "OK"
end type

event clicked;
IF parent.uf_get_is_valid_name( ) THEN
	isx_access_options.table_name 	= sle_table_name.text
	isx_access_options.save_sql		= cbx_sql.checked
	isx_access_options.save_criteria = cbx_criteria.checked
	isx_access_options.create_query  = cbx_view.checked
	
	Parent.event close( )
END IF
end event

