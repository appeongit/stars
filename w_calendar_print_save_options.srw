HA$PBExportHeader$w_calendar_print_save_options.srw
forward
global type w_calendar_print_save_options from w_master
end type
type cbx_bypass from checkbox within w_calendar_print_save_options
end type
type ddlb_thru_year from dropdownlistbox within w_calendar_print_save_options
end type
type ddlb_from_year from dropdownlistbox within w_calendar_print_save_options
end type
type ddlb_thru_month from dropdownlistbox within w_calendar_print_save_options
end type
type rb_range from radiobutton within w_calendar_print_save_options
end type
type rb_current from radiobutton within w_calendar_print_save_options
end type
type st_2 from statictext within w_calendar_print_save_options
end type
type st_1 from statictext within w_calendar_print_save_options
end type
type cb_cancel from commandbutton within w_calendar_print_save_options
end type
type cb_ok from commandbutton within w_calendar_print_save_options
end type
type ddlb_from_month from dropdownlistbox within w_calendar_print_save_options
end type
type rb_all from radiobutton within w_calendar_print_save_options
end type
type gb_1 from groupbox within w_calendar_print_save_options
end type
end forward

global type w_calendar_print_save_options from w_master
long backcolor = 67108864
string accessiblename = "Print and Export Options"
string accessibledescription = "Print/Export Options"
accessiblerole accessiblerole = windowrole!
integer width = 1193
integer height = 832
string title = "Print/Export Options"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
cbx_bypass cbx_bypass
ddlb_thru_year ddlb_thru_year
ddlb_from_year ddlb_from_year
ddlb_thru_month ddlb_thru_month
rb_range rb_range
rb_current rb_current
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
ddlb_from_month ddlb_from_month
rb_all rb_all
gb_1 gb_1
end type
global w_calendar_print_save_options w_calendar_print_save_options

type variables
date 					id_min_date, id_max_date
n_cst_datetime 	inv_date
sx_calendar_print_save_options isx_options


end variables

forward prototypes
public subroutine wf_set_enabled ()
public function boolean wf_valid_ddlb (ref dropdownlistbox addlb_list)
end prototypes

public subroutine wf_set_enabled ();//===================================================================================//
// Object		w_calendar_print_save_options
//	Script		wf_set_enabled
//	Arguments	None	
//	Returns		None
//===================================================================================//
// User options for exporting or printing calendars
//===================================================================================//
//	Maintenance
// -------- ----- ----------- -------------------------------------------------------
//	11/05/04	MikeF	SPR 5817c	Created
//===================================================================================//
ddlb_from_month.enabled = rb_range.checked
ddlb_from_year.enabled 	= rb_range.checked
ddlb_thru_month.enabled = rb_range.checked
ddlb_thru_year.enabled 	= rb_range.checked
end subroutine

public function boolean wf_valid_ddlb (ref dropdownlistbox addlb_list);//===================================================================================//
// Object		w_calendar_print_save_options
//	Script		wf_valid_ddlb
//	Arguments	dropdownlistbox	
//	Returns		boolean				TRUE if valid, FALSE otherwise
//===================================================================================//
// User options for exporting or printing calendars
//===================================================================================//
//	Maintenance
// -------- ----- ----------- -------------------------------------------------------
//	11/05/04	MikeF	SPR 5817c	Created
//===================================================================================//
IF len(addlb_list.text) = 0 THEN
	MessageBox("Edit","Please select a valid date range")
	SetFocus(addlb_list)	
	RETURN FALSE
END IF

RETURN TRUE
end function

on w_calendar_print_save_options.create
int iCurrent
call super::create
this.cbx_bypass=create cbx_bypass
this.ddlb_thru_year=create ddlb_thru_year
this.ddlb_from_year=create ddlb_from_year
this.ddlb_thru_month=create ddlb_thru_month
this.rb_range=create rb_range
this.rb_current=create rb_current
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.ddlb_from_month=create ddlb_from_month
this.rb_all=create rb_all
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_bypass
this.Control[iCurrent+2]=this.ddlb_thru_year
this.Control[iCurrent+3]=this.ddlb_from_year
this.Control[iCurrent+4]=this.ddlb_thru_month
this.Control[iCurrent+5]=this.rb_range
this.Control[iCurrent+6]=this.rb_current
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.ddlb_from_month
this.Control[iCurrent+12]=this.rb_all
this.Control[iCurrent+13]=this.gb_1
end on

on w_calendar_print_save_options.destroy
call super::destroy
destroy(this.cbx_bypass)
destroy(this.ddlb_thru_year)
destroy(this.ddlb_from_year)
destroy(this.ddlb_thru_month)
destroy(this.rb_range)
destroy(this.rb_current)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.ddlb_from_month)
destroy(this.rb_all)
destroy(this.gb_1)
end on

event open;call super::open;//===================================================================================//
// Object		w_calendar_print_save_options
//	Event			open
//	Arguments	<None>
//	Returns		<None>
//===================================================================================//
// User options for exporting or printing calendars
//===================================================================================//
//	Maintenance
// -------- ----- ----------- -------------------------------------------------------
//	11/05/04	MikeF	SPR 5817c	Created
//===================================================================================//
int		li_index

isx_options = Message.PowerObjectParm

isx_options.cancelled = TRUE
id_min_date = isx_options.begin_date
id_max_date = isx_options.end_date

ddlb_from_month.SelectItem(month(id_min_date))
ddlb_thru_month.SelectItem(month(id_max_date))

// Set Year DropDown
FOR li_index = year(id_min_date) TO year(id_max_date)
	ddlb_from_year.Additem( string(li_index) )
	ddlb_thru_year.Additem( string(li_index) )
NEXT

ddlb_from_year.SelectItem(1)
ddlb_thru_year.SelectItem( ddlb_thru_year.totalitems() )

end event

event close;call super::close;CloseWithReturn(this,isx_options)
end event

type cbx_bypass from checkbox within w_calendar_print_save_options
long textcolor = 33554432
string accessiblename = "Bypass months without data"
string accessibledescription = "Bypass months without data"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 32
integer y = 532
integer width = 1120
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Bypass months without data"
boolean checked = true
end type

type ddlb_thru_year from dropdownlistbox within w_calendar_print_save_options
string accessiblename = "Thru Year"
string accessibledescription = "Thru Year"
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 741
integer y = 400
integer width = 361
integer height = 324
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_from_year from dropdownlistbox within w_calendar_print_save_options
string accessiblename = "From Year"
string accessibledescription = "From Year"
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 741
integer y = 308
integer width = 361
integer height = 324
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_thru_month from dropdownlistbox within w_calendar_print_save_options
string accessiblename = "Thru Month"
string accessibledescription = "Thru Month"
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 265
integer y = 400
integer width = 466
integer height = 768
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
borderstyle borderstyle = stylelowered!
end type

type rb_range from radiobutton within w_calendar_print_save_options
long textcolor = 33554432
string accessiblename = "Specify range"
string accessibledescription = "Specify range"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 59
integer y = 224
integer width = 480
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Specify range"
end type

event clicked;parent.wf_set_enabled()
end event

type rb_current from radiobutton within w_calendar_print_save_options
long textcolor = 33554432
string accessiblename = "Current month"
string accessibledescription = "Current month"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 59
integer y = 156
integer width = 480
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Current month"
end type

event clicked;parent.wf_set_enabled()
end event

type st_2 from statictext within w_calendar_print_save_options
string accessiblename = "Thru"
string accessibledescription = "Thru"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 404
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Thru"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_calendar_print_save_options
string accessiblename = "From"
string accessibledescription = "From"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 320
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "From"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_calendar_print_save_options
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 599
integer y = 632
integer width = 283
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Cancel"
end type

event clicked;parent.event close( )
end event

type cb_ok from commandbutton within w_calendar_print_save_options
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 261
integer y = 632
integer width = 283
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "OK"
end type

event clicked;
date					ld_date

IF rb_all.checked THEN
	isx_options.month_selection = 1
ELSEIF rb_current.checked THEN
	isx_options.month_selection = 2
ELSE
	isx_options.month_selection = 3

	// Validate From Date
	IF parent.wf_valid_ddlb(ddlb_from_month) THEN
		IF parent.wf_valid_ddlb(ddlb_from_year) THEN
			ld_date = date(ddlb_from_year.text + " " + ddlb_from_month.text + "1")
			IF ld_date < inv_date.of_firstdayofmonth(id_min_date) THEN
				MessageBox("EDIT", "Specified date is prior to the earliest date in the report:" + string(id_min_date))
				RETURN
			ELSE
				isx_options.begin_date = ld_date
			END IF
		ELSE
			RETURN
		END IF
	ELSE
		RETURN
	END IF

	// Validate Thru Date
	IF parent.wf_valid_ddlb(ddlb_thru_month) THEN
		IF parent.wf_valid_ddlb(ddlb_thru_year) THEN
			ld_date = date(ddlb_thru_year.text + " " + ddlb_thru_month.text + "1")
			IF ld_date > inv_date.of_lastdayofmonth(id_max_date) THEN
				MessageBox("EDIT", "Specified date is after to the last date in the report:" + string(id_max_date))
				RETURN
			ELSE
				isx_options.end_date = inv_date.of_lastdayofmonth(ld_date)
			END IF
		ELSE
			RETURN
		END IF
	ELSE
		RETURN
	END IF

END IF

isx_options.cancelled = FALSE
isx_options.print_blank = NOT cbx_bypass.checked
parent.event close()
	
end event

type ddlb_from_month from dropdownlistbox within w_calendar_print_save_options
string accessiblename = "From Month"
string accessibledescription = "From Month"
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 265
integer y = 308
integer width = 466
integer height = 768
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
borderstyle borderstyle = stylelowered!
end type

type rb_all from radiobutton within w_calendar_print_save_options
long textcolor = 33554432
string accessiblename = "All months"
string accessibledescription = "All months"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 59
integer y = 88
integer width = 480
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "All months"
boolean checked = true
end type

event clicked;parent.wf_set_enabled()
end event

type gb_1 from groupbox within w_calendar_print_save_options
string accessiblename = "Options"
string accessibledescription = "Options"
accessiblerole accessiblerole = groupingrole!
integer x = 14
integer y = 24
integer width = 1152
integer height = 484
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Options"
end type

type ddlb_thru from dropdownlistbox within w_calendar_print_save_options
integer x = 265
integer y = 404
integer width = 617
integer height = 324
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean allowedit = true
borderstyle borderstyle = stylelowered!
end type

