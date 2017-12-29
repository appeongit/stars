$PBExportHeader$w_calendar_options.srw
forward
global type w_calendar_options from w_master
end type
type sle_filter_id from u_sle within w_calendar_options
end type
type st_6 from statictext within w_calendar_options
end type
type st_5 from statictext within w_calendar_options
end type
type cbx_filter from checkbox within w_calendar_options
end type
type gb_5 from groupbox within w_calendar_options
end type
type pb_down from picturebutton within w_calendar_options
end type
type pb_up from picturebutton within w_calendar_options
end type
type sle_description from singlelineedit within w_calendar_options
end type
type st_4 from statictext within w_calendar_options
end type
type st_1 from statictext within w_calendar_options
end type
type sle_title from singlelineedit within w_calendar_options
end type
type dw_selected from u_dw within w_calendar_options
end type
type dw_available from u_dw within w_calendar_options
end type
type st_3 from statictext within w_calendar_options
end type
type st_2 from statictext within w_calendar_options
end type
type st_selected from statictext within w_calendar_options
end type
type st_available from statictext within w_calendar_options
end type
type pb_deselect from picturebutton within w_calendar_options
end type
type pb_select from picturebutton within w_calendar_options
end type
type cb_cancel from commandbutton within w_calendar_options
end type
type cb_okay from commandbutton within w_calendar_options
end type
type ddlb_year from dropdownlistbox within w_calendar_options
end type
type ddlb_month from dropdownlistbox within w_calendar_options
end type
type rb_specify from radiobutton within w_calendar_options
end type
type rb_earliest from radiobutton within w_calendar_options
end type
type gb_1 from groupbox within w_calendar_options
end type
type gb_2 from groupbox within w_calendar_options
end type
type rb_mon_sun from radiobutton within w_calendar_options
end type
type rb_sun_sat from radiobutton within w_calendar_options
end type
type gb_4 from groupbox within w_calendar_options
end type
type gb_3 from groupbox within w_calendar_options
end type
type cbx_holidays from checkbox within w_calendar_options
end type
end forward

global type w_calendar_options from w_master
string accessiblename = "Calendar Options"
string accessibledescription = "Calendar Options"
integer width = 2016
integer height = 2076
string title = "Calendar Options"
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
sle_filter_id sle_filter_id
st_6 st_6
st_5 st_5
cbx_filter cbx_filter
gb_5 gb_5
pb_down pb_down
pb_up pb_up
sle_description sle_description
st_4 st_4
st_1 st_1
sle_title sle_title
dw_selected dw_selected
dw_available dw_available
st_3 st_3
st_2 st_2
st_selected st_selected
st_available st_available
pb_deselect pb_deselect
pb_select pb_select
cb_cancel cb_cancel
cb_okay cb_okay
ddlb_year ddlb_year
ddlb_month ddlb_month
rb_specify rb_specify
rb_earliest rb_earliest
gb_1 gb_1
gb_2 gb_2
rb_mon_sun rb_mon_sun
rb_sun_sat rb_sun_sat
gb_4 gb_4
gb_3 gb_3
cbx_holidays cbx_holidays
end type
global w_calendar_options w_calendar_options

type variables
sx_calendar_options	isx_options
end variables

forward prototypes
public subroutine wf_update_counts ()
public subroutine wf_reorder_row (string as_direction)
public subroutine wf_add_row ()
public subroutine wf_remove_row ()
end prototypes

public subroutine wf_update_counts ();// Unhighlight all rows
dw_available.SelectRow(0, FALSE)
dw_selected.SelectRow(0, FALSE)
dw_available.SetRedraw(TRUE)
dw_selected.SetRedraw(TRUE)

st_available.text = string(dw_available.RowCount()) + ' available'
st_selected.text 	= string(dw_selected.RowCount())  + ' selected'
end subroutine

public subroutine wf_reorder_row (string as_direction);long	ll_row
int	li_new

ll_row = dw_selected.GetSelectedRow(0)

IF as_direction = 'UP' then
	IF ll_row = 1 THEN RETURN
	
	dw_selected.rowsmove(ll_row,ll_row,Primary!,dw_selected,ll_row - 1,Primary!)
	li_new = ll_row - 1
else
	IF ll_row = dw_selected.RowCount() THEN RETURN
	
	dw_selected.rowsmove(ll_row,ll_row,Primary!,dw_selected,ll_row + 2,Primary!)
	li_new = ll_row + 1
end if

dw_selected.selectrow	(0,FALSE)
dw_selected.SelectRow	(li_new,TRUE)


end subroutine

public subroutine wf_add_row ();//======================================================================================================//
// Object	w_calendar_options
// Event		wf_add_row
//------------------------------------------------------------------------------------------------------//
// Moves a row from dw_available to dw_selected
//------------------------------------------------------------------------------------------------------//
// Maintenance
// -------- ----- -------- -----------------------------------------------------------------------------
// 11/08/04 MikeF	SPR4107d Calendar interface - initial creation
//======================================================================================================//
long		ll_row

IF dw_selected.RowCount() = 8 THEN
	MessageBox("Error","Only 8 metrics can be displayed on the calendar")
	RETURN
END IF

ll_row = dw_available.GetSelectedRow(0)

dw_available.RowsMove(ll_row,ll_row,Primary!,dw_selected,dw_selected.RowCount() + 1,Primary!)

this.wf_update_counts()
end subroutine

public subroutine wf_remove_row ();//======================================================================================================//
// Object	w_calendar_options
// Event		wf_remove row
//------------------------------------------------------------------------------------------------------//
// Moves a row from dw_selected to dw_available
//------------------------------------------------------------------------------------------------------//
// Maintenance
// -------- ----- -------- -----------------------------------------------------------------------------
// 11/08/04 MikeF	SPR4107d Calendar interface - initial creation
//======================================================================================================//
long		ll_row

IF dw_selected.RowCount() = 0 THEN
	RETURN
END IF

ll_row = dw_selected.GetSelectedRow(0)

dw_selected.RowsMove(ll_row,ll_row,Primary!,dw_available,1,Primary!)

this.wf_update_counts()




end subroutine

on w_calendar_options.create
int iCurrent
call super::create
this.sle_filter_id=create sle_filter_id
this.st_6=create st_6
this.st_5=create st_5
this.cbx_filter=create cbx_filter
this.gb_5=create gb_5
this.pb_down=create pb_down
this.pb_up=create pb_up
this.sle_description=create sle_description
this.st_4=create st_4
this.st_1=create st_1
this.sle_title=create sle_title
this.dw_selected=create dw_selected
this.dw_available=create dw_available
this.st_3=create st_3
this.st_2=create st_2
this.st_selected=create st_selected
this.st_available=create st_available
this.pb_deselect=create pb_deselect
this.pb_select=create pb_select
this.cb_cancel=create cb_cancel
this.cb_okay=create cb_okay
this.ddlb_year=create ddlb_year
this.ddlb_month=create ddlb_month
this.rb_specify=create rb_specify
this.rb_earliest=create rb_earliest
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rb_mon_sun=create rb_mon_sun
this.rb_sun_sat=create rb_sun_sat
this.gb_4=create gb_4
this.gb_3=create gb_3
this.cbx_holidays=create cbx_holidays
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_filter_id
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.cbx_filter
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.pb_down
this.Control[iCurrent+7]=this.pb_up
this.Control[iCurrent+8]=this.sle_description
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.sle_title
this.Control[iCurrent+12]=this.dw_selected
this.Control[iCurrent+13]=this.dw_available
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_selected
this.Control[iCurrent+17]=this.st_available
this.Control[iCurrent+18]=this.pb_deselect
this.Control[iCurrent+19]=this.pb_select
this.Control[iCurrent+20]=this.cb_cancel
this.Control[iCurrent+21]=this.cb_okay
this.Control[iCurrent+22]=this.ddlb_year
this.Control[iCurrent+23]=this.ddlb_month
this.Control[iCurrent+24]=this.rb_specify
this.Control[iCurrent+25]=this.rb_earliest
this.Control[iCurrent+26]=this.gb_1
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.rb_mon_sun
this.Control[iCurrent+29]=this.rb_sun_sat
this.Control[iCurrent+30]=this.gb_4
this.Control[iCurrent+31]=this.gb_3
this.Control[iCurrent+32]=this.cbx_holidays
end on

on w_calendar_options.destroy
call super::destroy
destroy(this.sle_filter_id)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cbx_filter)
destroy(this.gb_5)
destroy(this.pb_down)
destroy(this.pb_up)
destroy(this.sle_description)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.sle_title)
destroy(this.dw_selected)
destroy(this.dw_available)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_selected)
destroy(this.st_available)
destroy(this.pb_deselect)
destroy(this.pb_select)
destroy(this.cb_cancel)
destroy(this.cb_okay)
destroy(this.ddlb_year)
destroy(this.ddlb_month)
destroy(this.rb_specify)
destroy(this.rb_earliest)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rb_mon_sun)
destroy(this.rb_sun_sat)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.cbx_holidays)
end on

event open;//======================================================================================================//
// Object	w_calendar_options
// Event		open
//------------------------------------------------------------------------------------------------------//
// Populates the window controls based on values in the structure
//------------------------------------------------------------------------------------------------------//
// Maintenance
// -------- ----- -------- -----------------------------------------------------------------------------
// 11/08/04 MikeF	SPR4107d Calendar interface - initial creation
// 12/14/04 MikeF SPR4145d Set MessageParm null
//======================================================================================================//
int		li_cols, li_index, li_min_year, li_max_year

isx_options = Message.PowerObjectParm
setNull(Message.PowerObjectParm)

li_cols = UpperBound(isx_options.dw_col)

FOR li_index = 1 TO li_cols
	dw_available.insertrow(0)	
	dw_available.Setitem(li_index, "col_number", isx_options.dw_col		[li_index])
	dw_available.Setitem(li_index, "col_name", 	isx_options.dw_col_name	[li_index])
	dw_available.Setitem(li_index, "col_type", 	isx_options.dw_col_type	[li_index])
	dw_available.Setitem(li_index, "col_label", 	isx_options.dw_label		[li_index])
	dw_available.Setitem(li_index, "col_format", isx_options.dw_format	[li_index])
	dw_available.Setitem(li_index, "col_color", 	isx_options.dw_color		[li_index])
	dw_available.Setitem(li_index, "col_weight", isx_options.dw_weight	[li_index])
NEXT

// Set sort
dw_available.SetSort("col_number asc")
dw_available.Sort()

// Pre-Select first 8 columns
IF li_cols > 8 THEN
	li_cols = 8
END IF

dw_available.RowsMove( 1, li_cols, Primary!, dw_selected, 1, Primary!)
dw_available.SelectRow(0,FALSE)
dw_selected.SelectRow(0,FALSE)

this.wf_update_counts()

// Will only be set to false if OK is clicked
isx_options.cancelled = TRUE

// Set Year DropDown
li_min_year = year(isx_options.min_date)
li_max_year = year(isx_options.max_date)

FOR li_index = li_min_year TO li_max_year
	ddlb_year.Additem( string(li_index) )
NEXT

// Set default title
sle_title.text = isx_options.report_title
end event

event close;call super::close;CloseWithReturn(this,isx_options)
end event

type sle_filter_id from u_sle within w_calendar_options
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Filter ID"
string accessibledescription = "Lookup Field - Filter ID"
integer x = 1225
integer y = 716
integer width = 626
integer taborder = 110
integer textsize = -8
integer weight = 700
string facename = "Microsoft Sans Serif"
long textcolor = 134217747
long backcolor = 134217731
boolean enabled = false
boolean autohscroll = true
end type

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

sx_filter_data		lsx_filter_data

lsx_filter_data.sx_window		=	Parent
lsx_filter_data.sx_entry_mode	=	'USE'
lsx_filter_data.sx_col_name	=	"DATE"

OpenwithParm (w_filter_list_response, lsx_filter_data)
this.text = '@'	+	gv_active_filter
end event

type st_6 from statictext within w_calendar_options
string accessiblename = "Filter Dates are identified by a thick border"
string accessibledescription = "Filter Dates are identified by a thick border"
accessiblerole accessiblerole = statictextrole!
integer x = 1225
integer y = 600
integer width = 622
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filter Dates are identified by a thick border"
boolean focusrectangle = false
end type

type st_5 from statictext within w_calendar_options
string accessiblename = "Holidays are identified by an asterisk after the date"
string accessibledescription = "Holidays are identified by an asterisk (*) after the date"
accessiblerole accessiblerole = statictextrole!
integer x = 1230
integer y = 404
integer width = 654
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Holidays are identified by an asterisk (*) after the date"
boolean focusrectangle = false
end type

type cbx_filter from checkbox within w_calendar_options
string accessiblename = "Mark Filter Dates"
string accessibledescription = "Mark Filter Dates"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1143
integer y = 532
integer width = 754
integer height = 64
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mark Filter Dates"
end type

event clicked;sle_filter_id.enabled = this.checked
end event

type gb_5 from groupbox within w_calendar_options
string accessiblename = "Date Options"
string accessibledescription = "Date Options"
accessiblerole accessiblerole = groupingrole!
integer x = 1111
integer y = 264
integer width = 805
integer height = 568
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Date Options"
end type

type pb_down from picturebutton within w_calendar_options
string accessiblename = "Move Down"
string accessibledescription = "Move Down"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1797
integer y = 1392
integer width = 105
integer height = 96
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "DOWN2.BMP"
alignment htextalign = left!
boolean map3dcolors = true
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;parent.wf_reorder_row("DOWN")
end event

type pb_up from picturebutton within w_calendar_options
string accessiblename = "Move Up"
string accessibledescription = "Move Up"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1797
integer y = 1172
integer width = 105
integer height = 96
integer taborder = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "UP1.BMP"
alignment htextalign = left!
boolean map3dcolors = true
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;parent.wf_reorder_row("UP")
end event

type sle_description from singlelineedit within w_calendar_options
string accessiblename = "Calendar Description"
string accessibledescription = "Calendar Description"
accessiblerole accessiblerole = textrole!
integer x = 389
integer y = 156
integer width = 1522
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
integer limit = 80
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_calendar_options
string accessiblename = "Calendar Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 59
integer y = 168
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Description"
boolean focusrectangle = false
end type

type st_1 from statictext within w_calendar_options
string accessiblename = "Calendar Title"
string accessibledescription = "Title"
accessiblerole accessiblerole = statictextrole!
integer x = 59
integer y = 80
integer width = 146
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Title"
boolean focusrectangle = false
end type

type sle_title from singlelineedit within w_calendar_options
string accessiblename = "Enter Calendar Title"
string accessibledescription = "Enter Calendar Title"
accessiblerole accessiblerole = textrole!
integer x = 389
integer y = 60
integer width = 1522
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
integer limit = 80
borderstyle borderstyle = stylelowered!
end type

type dw_selected from u_dw within w_calendar_options
string accessiblename = "Calender Metrics"
string accessibledescription = "d_calender_metrics"
integer x = 997
integer y = 1008
integer width = 759
integer height = 688
integer taborder = 150
string dataobject = "d_calendar_metrics"
boolean vscrollbar = true
boolean ib_singleselect = true
boolean ib_singlerow = true
end type

event doubleclicked;call super::doubleclicked;

parent.wf_remove_row()
end event

type dw_available from u_dw within w_calendar_options
string accessiblename = "Available Fields"
string accessibledescription = "Available Fields"
integer x = 64
integer y = 1008
integer width = 759
integer height = 688
integer taborder = 120
string dataobject = "d_calendar_metrics"
boolean vscrollbar = true
boolean ib_singleselect = true
boolean ib_singlerow = true
end type

event doubleclicked;call super::doubleclicked;parent.wf_add_row()
end event

type st_3 from statictext within w_calendar_options
string accessiblename = "Selected Fields"
string accessibledescription = "Selected"
accessiblerole accessiblerole = statictextrole!
integer x = 997
integer y = 936
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selected"
boolean focusrectangle = false
end type

type st_2 from statictext within w_calendar_options
string accessiblename = "Available"
string accessibledescription = "Available"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 936
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Available"
boolean focusrectangle = false
end type

type st_selected from statictext within w_calendar_options
string accessiblename = "Number of Selected Fields"
string accessibledescription = "0 selected"
accessiblerole accessiblerole = statictextrole!
integer x = 997
integer y = 1708
integer width = 690
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "0 selected"
boolean focusrectangle = false
end type

type st_available from statictext within w_calendar_options
string accessiblename = "Number of Available Fields"
string accessibledescription = "0 available"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1708
integer width = 690
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "0 available"
boolean focusrectangle = false
end type

type pb_deselect from picturebutton within w_calendar_options
string accessiblename = "Deselect"
string accessibledescription = "Deselect"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 864
integer y = 1392
integer width = 110
integer height = 96
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "VCRPrior!"
alignment htextalign = left!
boolean map3dcolors = true
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;
parent.wf_remove_row()
end event

type pb_select from picturebutton within w_calendar_options
string accessiblename = "Select"
string accessibledescription = "Select"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 864
integer y = 1172
integer width = 110
integer height = 96
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "VCRNext!"
alignment htextalign = left!
boolean map3dcolors = true
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;
parent.wf_add_row()
end event

type cb_cancel from commandbutton within w_calendar_options
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1627
integer y = 1836
integer width = 293
integer height = 108
integer taborder = 190
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Cancel"
end type

event clicked;parent.event close()
end event

type cb_okay from commandbutton within w_calendar_options
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1294
integer y = 1836
integer width = 293
integer height = 108
integer taborder = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;int		li_index
date		ld_date

// Blank arrays
int		li_blank_array[]
string	ls_blank_array[]

n_cst_datetime	lnv_date

// Verify at least one metric is selected
IF dw_selected.RowCount() = 0 THEN
	MessageBox("EDIT","Please select at least one metric.")
	RETURN
END IF

// Validate date if one is specified
IF rb_specify.checked THEN
	// Check month ddlb
	IF len(ddlb_month.text) = 0 THEN
		MessageBox("EDIT","Please select a valid month")
		SetFocus(ddlb_month)
		RETURN
	END IF

	// Check year ddlb
	IF len(ddlb_year.text) = 0 THEN
		MessageBox("EDIT","Please select a valid year")
		SetFocus(ddlb_year)
		RETURN
	END IF
	
	// Check for Specified date before earliest Date
	ld_date 	= lnv_date.of_lastdayofmonth(date(ddlb_year.text + ' ' + ddlb_month.text + ' 1'))
	IF ld_date < isx_options.min_date THEN
		MessageBox("EDIT","Selected Date is prior to earliest date in the report: " + &
								string(isx_options.min_date))
		SetFocus(ddlb_month)
		RETURN
	END IF

	
	// Check for Specified date after latest Date
	ld_date = lnv_date.of_firstdayofmonth(date(ddlb_year.text + ' ' + ddlb_month.text + ' 1')) 
	IF ld_date > isx_options.max_date THEN
		MessageBox("EDIT","Selected Date is beyond to latest date in the report: " + &
								string(isx_options.max_date))
		SetFocus(ddlb_month)
		RETURN
	END IF
	
	isx_options.report_date = lnv_date.of_firstdayofmonth(date(ddlb_year.text + ' ' + ddlb_month.text + ' 1')) 
ELSE
	isx_options.report_date = lnv_date.of_firstdayofmonth(isx_options.min_date)
END IF

// Validate Date filter
IF cbx_filter.checked THEN
	
	IF len(trim(sle_filter_id.text)) = 0  THEN
		MessageBox("EDIT","Please enter a filter ID")
		SetFocus(sle_filter_id)
		RETURN
	END IF
	
	IF gnv_app.of_get_filter_type(trim(sle_filter_id.text)) <> 'DATE' THEN
		MessageBox("EDIT","Please enter a valid Date filter ID")
		SetFocus(sle_filter_id)
		RETURN
	END IF

END IF

// Clear out isx_options arrays
isx_options.dw_col 		= li_blank_array
isx_options.dw_col_name = ls_blank_array
isx_options.dw_col_type = ls_blank_array
isx_options.dw_label		= ls_blank_array
isx_options.dw_format	= ls_blank_array
isx_options.dw_color		= ls_blank_array
isx_options.dw_weight	= ls_blank_array

// Populate structure with selected columns' data
FOR li_index = 1 TO dw_selected.RowCount()
	isx_options.dw_col 		[li_index] = dw_selected.GetItemNumber( li_index, "col_number")
	isx_options.dw_col_name [li_index] = dw_selected.GetItemString( li_index, "col_name")
	isx_options.dw_col_type [li_index] = dw_selected.GetItemString( li_index, "col_type")
	isx_options.dw_label		[li_index] = dw_selected.GetItemString( li_index, "col_label")
	isx_options.dw_format	[li_index] = dw_selected.GetItemString( li_index, "col_format")
	isx_options.dw_color		[li_index] = dw_selected.GetItemString( li_index, "col_color")
	isx_options.dw_weight	[li_index] = dw_selected.GetItemString( li_index, "col_weight")
NEXT

// Set other options
isx_options.mark_holidays 		= cbx_holidays.checked
isx_options.mark_filter_dates	= cbx_filter.checked
isx_options.filter_id			= sle_filter_id.text
isx_options.sun_sat 		  		= rb_sun_sat.checked
isx_options.cancelled 			= FALSE
isx_options.report_title		= trim(sle_title.text)
isx_options.report_desc			= trim(sle_description.text)

parent.event close( )
end event

type ddlb_year from dropdownlistbox within w_calendar_options
string accessiblename = "Year"
string accessibledescription = "Year"
accessiblerole accessiblerole = comboboxrole!
integer x = 718
integer y = 716
integer width = 329
integer height = 324
integer taborder = 80
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

type ddlb_month from dropdownlistbox within w_calendar_options
string accessiblename = "Month"
string accessibledescription = "Month"
accessiblerole accessiblerole = comboboxrole!
integer x = 169
integer y = 716
integer width = 526
integer height = 728
integer taborder = 70
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

type rb_specify from radiobutton within w_calendar_options
string accessiblename = "Specify Month and Year"
string accessibledescription = "Specify Month and Year"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 91
integer y = 636
integer width = 704
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Specify Month and Year"
end type

event clicked;ddlb_month.enabled = this.checked
ddlb_year.enabled  = this.checked
end event

type rb_earliest from radiobutton within w_calendar_options
string accessiblename = "Draw earliest dates calendar"
string accessibledescription = "Draw earliest dates calendar"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 91
integer y = 568
integer width = 837
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Draw earliest date~'s calendar"
boolean checked = true
end type

event clicked;ddlb_year.enabled  = NOT this.checked
ddlb_month.enabled = NOT this.checked

end event

type gb_1 from groupbox within w_calendar_options
string accessiblename = "Initial Month"
string accessibledescription = "Initial Month"
accessiblerole accessiblerole = groupingrole!
integer x = 59
integer y = 504
integer width = 1042
integer height = 328
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Initial Month"
end type

type gb_2 from groupbox within w_calendar_options
string accessiblename = "Displayed metrics (Choose up to 8)"
string accessibledescription = "Displayed metrics (Choose up to 8)"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer y = 872
integer width = 1925
integer height = 924
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Displayed metrics (Choose up to 8)"
end type

type rb_mon_sun from radiobutton within w_calendar_options
string accessiblename = "Monday - Sunday"
string accessibledescription = "Monday - Sunday"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 87
integer y = 392
integer width = 594
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Monday - Sunday"
end type

type rb_sun_sat from radiobutton within w_calendar_options
string accessiblename = "Sunday - Saturday"
string accessibledescription = "Sunday - Saturday"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 87
integer y = 320
integer width = 594
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sunday - Saturday"
boolean checked = true
end type

type gb_4 from groupbox within w_calendar_options
string accessiblename = "Weeks View"
string accessibledescription = "Weeks View"
accessiblerole accessiblerole = groupingrole!
integer x = 59
integer y = 264
integer width = 1042
integer height = 232
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Weeks View"
end type

type gb_3 from groupbox within w_calendar_options
string accessiblename = "Options"
string accessibledescription = "Options"
accessiblerole accessiblerole = groupingrole!
integer x = 27
integer y = 12
integer width = 1925
integer height = 844
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

type cbx_holidays from checkbox within w_calendar_options
string accessiblename = "Identify Holidays"
string accessibledescription = "Identify Holidays"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1143
integer y = 340
integer width = 603
integer height = 64
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Identify Holidays"
boolean checked = true
end type

