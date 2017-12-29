HA$PBExportHeader$w_calendar.srw
forward
global type w_calendar from w_master
end type
type dw_data from u_dw within w_calendar
end type
type pb_last from picturebutton within w_calendar
end type
type pb_next from picturebutton within w_calendar
end type
type pb_prior from picturebutton within w_calendar
end type
type pb_first from picturebutton within w_calendar
end type
type cb_close from commandbutton within w_calendar
end type
type cb_update from commandbutton within w_calendar
end type
type ddlb_year from dropdownlistbox within w_calendar
end type
type st_6 from statictext within w_calendar
end type
type st_5 from statictext within w_calendar
end type
type dw_calendar from u_dw within w_calendar
end type
type ddlb_month from dropdownlistbox within w_calendar
end type
type gb_1 from groupbox within w_calendar
end type
type gb_2 from groupbox within w_calendar
end type
end forward

global type w_calendar from w_master
string accessiblename = "Calendar Report"
string accessibledescription = "Calendar Report"
integer width = 3895
integer height = 2388
string title = "Calendar Report"
event ue_set_data ( )
event ue_export_pdf ( )
dw_data dw_data
pb_last pb_last
pb_next pb_next
pb_prior pb_prior
pb_first pb_first
cb_close cb_close
cb_update cb_update
ddlb_year ddlb_year
st_6 st_6
st_5 st_5
dw_calendar dw_calendar
ddlb_month ddlb_month
gb_1 gb_1
gb_2 gb_2
end type
global w_calendar w_calendar

type variables
// 04/10/09  RickB  SPR 5633 Changed constant values for icl_weekday and icl_weekend
//                to Windows bg colors and added icl_weekday_font and icl_weekend_font and
//                made them Windows colors, too.


int		ii_rows, ii_cols, ii_date_col
string	is_date_col, is_date_type
date		id_min_date, id_max_date, id_report_date
boolean	ib_datetime, ib_redraw

// Print/Save Month Options
constant int	ici_all 		= 1 	// Process entire date range
constant int	ici_current = 2	// Process current month only
constant int	ici_range 	= 3	// Process user-defined range

// Colors for day borders
//  RickB 4/10/09 Section 508 color changes from hard-coded to Windows colors
constant	long	icl_weekday = 134217741		// Highlight
constant	long	icl_weekend = 134217750		// Button Light Shadow
constant long	icl_weekday_font = 134217742  // Highlight Text
constant long	icl_weekend_font = 33554432  // Window Text


n_ds				ids_holidays, ids_user_dates
n_cst_datetime	inv_date

sx_calendar_options	isx_options
sx_calendar_print_save_options	isx_print_options
end variables

forward prototypes
public subroutine wf_get_options ()
public function boolean wf_draw_calendar (date ad_report_date)
end prototypes

event ue_export_pdf();//===================================================================================//
// Object		w_calendar
//	Event			ue_export_pdf
//	Arguments	<None>
//	Returns		<None>
//===================================================================================//
// Loops through the months and creates a PDF, then appends it to the "real" file
//===================================================================================//
//	Maintenance
// -------- ----- ----------- -------------------------------------------------------
//	11/05/04	MikeF	SPR 5817c	Created
// 12/29/04 MikeF	SPR 4203d	Add completion message after export completes.
//===================================================================================//
string	ls_path, ls_file, ls_title
int		li_index, li_months, li_rc
date		ld_begin, ld_end, ld_date, ld_current

n_cst_export	lnv_export

this.wf_get_options()

IF isx_print_options.cancelled THEN
	RETURN
END IF

li_rc = GetFileSaveName("File Save Name", ls_path, ls_file, "PDF", "Portable Document Format (*.PDF), *.PDF")

// User cancelled or error
IF li_rc < 1 THEN
	RETURN
END IF

// Turns redraw off and store current month so user sees no difference
ld_current 	= id_report_date
ib_redraw	= FALSE

// Set report range
CHOOSE CASE isx_print_options.month_selection
	CASE ici_all
		ld_begin	= id_min_date
		ld_end	= id_max_date
	CASE ici_current
		ld_begin	= id_report_date
		ld_end	= id_report_date
	CASE ici_range
		ld_begin	= isx_print_options.begin_date
		ld_end	= isx_print_options.end_date
END CHOOSE		

ld_begin		= inv_date.of_firstdayofmonth(ld_begin)
ld_end		= inv_date.of_lastdayofmonth (ld_end)
ld_date 		= ld_begin

li_months = inv_date.of_monthsafter(ld_begin,ld_end) + 1

// Draw and print each month
FOR li_index = 1 TO li_months
	
	// Create PDF if month has rows OR user chooses to display empty months
	IF this.wf_draw_calendar(ld_date) &
	OR isx_print_options.print_blank THEN
	
		// Create PDF
		IF dw_calendar.describe("st_title.text") = "!" THEN
			ls_title = "Calendar Report"
		ELSE
			ls_title = dw_calendar.describe("st_title.text")
		END IF
		
		li_rc = lnv_export.event ue_pdf( ls_path + string(li_index), dw_calendar, ls_title)
	
		IF li_rc < 0 THEN
			MessageBox("Export Failed","Unable to export calendars to PDF file")
			EXIT
		END IF

		// Process the file
		IF li_index = 1 THEN
			// Copy file to real name
			FileCopy(ls_path + string(li_index), ls_path, TRUE)
		ELSE
			// Append current month onto save file
			lnv_export.event ue_append_doc( ls_path + string(li_index), ls_path)
		END IF
	END IF
	
	// Increment date
	ld_date = inv_date.of_getnextmonth(ld_date)
		
NEXT

// Delete temporary files
FOR li_index = 1 TO li_months
	IF FileExists(ls_path + string(li_index)) THEN
		FileDelete(ls_path + string(li_index))
	END IF
NEXT

// Check return code and return message
IF li_rc = 1 THEN
	MessageBox("Save Report","Export complete.")
ELSE
	MessageBox("Save Report","The attempt to export data to~n~r"	+ ls_path + " failed.~n~r" + &
					"No data was saved.", StopSign! )
	IF FileExists(ls_path) THEN
		FileDelete(ls_path)
	END IF
END IF

// Refresh dw_calendar
ib_redraw	= TRUE
this.wf_draw_calendar(ld_current)

end event

public subroutine wf_get_options ();//======================================================================================//
// Object		w_calendar
// Function		wf_get_options
// Arguments	None
// Returns		None
//======================================================================================//
// Opens the Print / Export options dialog and sets instance structure
//======================================================================================//
// Maintenance
// -------- ----- --------	-------------------------------------------------------------
// 11/08/04	MikeF	SPR4107d	Created
//======================================================================================//
int		li_rc
string	ls_filter

// Set parms 
isx_print_options.begin_date 	= id_min_date
isx_print_options.end_date 	= id_max_date

// Open Options window
OpenWithParm(w_calendar_print_save_options,isx_print_options,this)

// Retrieve isx_options from Close
isx_print_options = Message.Powerobjectparm



end subroutine

public function boolean wf_draw_calendar (date ad_report_date);//======================================================================================//
// Object		w_calendar
// Function		wf_draw_calendar
// Arguments	date					Date to draw the month from
// Returns		boolean				Whether the report contained any rows from current month
//======================================================================================//
// Calculates and displays all elements for the current month for dw_calendar 
//======================================================================================//
// Maintenance
// -------- ----- --------	-------------------------------------------------------------
// 11/08/04	MikeF	SPR4107d	Created
// 01/11/05 MikeF SPR4231d	Size the detail band based on # weeks so there is no trailing print page
// 01/11/05 MikeF SPR4169d Labels cutting off.
// 01/11/05 MikeF SPR4169d Fixed issue with date filters marking days.
// 04/10/09 RickB	SPR5336	Changed background colors of headings for weekends and weekdays
//               				from non-Windows colors to Windows colors to be Section 508 compliant.
//									Also, changed the asterisk indicating a holiday to "Holiday".
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//======================================================================================//

boolean	lb_day_exists
string	ls_find, ls_object, ls_value, ls_type, ls_label_id, ls_visible, ls_color, ls_weight, ls_eval, ls_rc
int		li_rc, li_cell, li_x, li_y, li_pos, li_row, li_rowcount
int		li_day, li_last_day, li_field, li_index, li_weeks
date		ld_date

id_report_date = inv_date.of_firstdayofmonth(ad_report_date)

// Set dropdowns to report month
IF ib_redraw THEN
	ddlb_month.selectitem(month(ad_report_date))
	ddlb_year.text = string(year(ad_report_date))
	dw_calendar.event ue_reset( )
END IF

// Disable the buttons if first or last month
IF id_report_date = inv_date.of_firstdayofmonth(id_min_date) THEN
	pb_first.visible = FALSE
	pb_prior.visible = FALSE
ELSE
	pb_first.visible = TRUE
	pb_prior.visible = TRUE
END IF

IF id_report_date = inv_date.of_firstdayofmonth(id_max_date) THEN
	pb_last.visible = FALSE
	pb_next.visible = FALSE
ELSE
	pb_last.visible = TRUE
	pb_next.visible = TRUE
END IF

// Reset the datawindow
dw_calendar.SetRedraw(FALSE)
lb_day_exists = FALSE

// Delete the current "row" and insert the new one
IF dw_calendar.RowCount() > 0 THEN
	dw_calendar.deleterow(1)
END IF

dw_calendar.Insertrow(0)
dw_calendar.SetItem( 1, "ad_date", ad_report_date)

// Validate that date is within range
IF inv_date.of_lastdayofmonth(ad_report_date) < id_min_date THEN
	MessageBox("EDIT","Selected Date is prior to earliest date in the report: " + &
							string(id_min_date))
	SetFocus(ddlb_month)
	RETURN FALSE
END IF

IF inv_date.of_firstdayofmonth(ad_report_date) > id_max_date THEN
	MessageBox("EDIT","Selected Date is beyond latest date in the report: " + &
							string(id_max_date))
	SetFocus(ddlb_month)
	RETURN FALSE
END IF

// Prepare variables
li_last_day		= day(inv_date.of_lastdayofmonth(id_report_date))
li_cell			= inv_date.of_dayofweek(id_report_date)

IF isx_options.sun_sat THEN
	// Calendar is standard Sun - Sat
ELSE
	// Draw calendar as Mon - Sun
	IF li_cell = 1 THEN
		// Month starts on Sunday
		li_cell = 7 
	ELSE
		// Shift the cells back 1
		li_cell = li_cell - 1
	END IF
	
	// Reset week labels
	dw_calendar.modify("t_day1.text='Monday'")
	dw_calendar.modify("t_day2.text='Tuesday'")
	dw_calendar.modify("t_day3.text='Wednesday'")
	dw_calendar.modify("t_day4.text='Thursday'")
	dw_calendar.modify("t_day5.text='Friday'")
	dw_calendar.modify("t_day6.text='Saturday'")
	dw_calendar.modify("t_day7.text='Sunday'")
	
	//	Set Accessibility Properties
	ls_value = '"Monday"~t"Monday"'
	dw_calendar.modify("t_day1.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day1.AccessibleDescription='" + ls_value + "'" )
	ls_value = '"Tuesday"~t"Tuesday"'
	dw_calendar.modify("t_day2.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day2.AccessibleDescription='" + ls_value + "'" )
	ls_value = '"Wednesday"~t"Wednesday"'
	dw_calendar.modify("t_day3.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day3.AccessibleDescription='" + ls_value + "'" )
	ls_value = '"Thursday"~t"Thursday"'
	dw_calendar.modify("t_day4.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day4.AccessibleDescription='" + ls_value + "'" )
	ls_value = '"Friday"~t"Friday"'
	dw_calendar.modify("t_day5.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day5.AccessibleDescription='" + ls_value + "'" )
	ls_value = '"Saturday"~t"Saturday"'
	dw_calendar.modify("t_day6.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day6.AccessibleDescription='" + ls_value + "'" )
	ls_value = '"Sunday"~t"Sunday"'
	dw_calendar.modify("t_day7.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("t_day7.AccessibleDescription='" + ls_value + "'" )
END IF

// Alter the visible property of the labels
li_weeks = (li_cell + li_last_day + 5) / 7

FOR li_index = 1 TO 6
	IF li_index > li_weeks THEN
		ls_visible = '0'
	ELSE
		ls_visible = '1'
	END IF
	
	// Change visible property
	FOR li_field = 1 TO ii_cols
		dw_calendar.modify("wk" + string(li_index) + "_label" + string(li_field) + &
								 ".visible='" + ls_visible + "'")
	NEXT	
NEXT

// Set page height based on # weeks
dw_calendar.Object.DataWindow.Detail.Height = (li_weeks * 142) + 43

// Loop through days
FOR li_day = 1 TO 31

	IF li_day > li_last_day THEN
		dw_calendar.event ue_setdayvisible(li_day, FALSE)
		CONTINUE
	END IF
	
	// Get data from datastore
	ld_date	= date(year(ad_report_date), month(ad_report_date), li_day)
	ls_find 	= is_date_col + " = date('" + string(ld_date) + "')" 
	li_row 	= dw_data.Find(ls_find, 1, ii_rows)

	// Determine the position of the day
	li_x = (mod(li_cell - 1,7) * 94) + 111
	li_y = (li_cell - 1) / 7
	li_y = (li_y * 142) + 43
	
	// Set the day
	dw_calendar.modify("d"  + string(li_day) + "_day.text='" + string(li_day) 		+ "'")
	ls_value = '"' + string(li_day) + '"~t"' + string(li_day) + '"'
	dw_calendar.modify("d"  + string(li_day) + "_day.AccessibleName='" + ls_value + "'" )
	dw_calendar.modify("d"  + string(li_day) + "_day.AccessibleDescription='" + ls_value + "'" )
	dw_calendar.modify("d"  + string(li_day) + "_day.x='" 	+ string(li_x) 		+ "'")
	dw_calendar.modify("d"  + string(li_day) + "_day.y='" 	+ string(li_y + 1) 	+ "'")
	dw_calendar.modify("r_" + string(li_day) + ".x='" 			+ string(li_x - 1) 	+ "'")
	dw_calendar.modify("r_" + string(li_day) + ".y='" 			+ string(li_y) 		+ "'")

	// Loop through and set the columns
	FOR li_field = 1 TO ii_cols

		ls_object = "d" + string(li_day) + "_" + string(li_field)

		IF li_row = 0 THEN
			// No data for specified day. Default to spaces.
			ls_value = ' '	
		ELSE
			lb_day_exists = TRUE
			// Get column data type and remove precision if exists
			ls_type 	= isx_options.dw_col_type[li_field]
			li_pos	= pos(ls_type,"(")
			IF li_pos > 0 THEN 
				ls_type = left(ls_type,li_pos - 1)
			END IF
			
			CHOOSE CASE ls_type
				CASE 'int','long','number'
					ls_value = 	string(dw_data.GetItemNumber (li_row,isx_options.dw_col[li_field]), &
									isx_options.dw_format[li_field])
				CASE 'decimal'
					ls_value = 	string(dw_data.GetItemDecimal(li_row,isx_options.dw_col[li_field]), &
									isx_options.dw_format[li_field])
			END CHOOSE

			// Set Text color
			IF NOT IsNumber(isx_options.dw_color[li_field]) THEN
				ls_eval  = "evaluate('" + isx_options.dw_color[li_field] + "'," + string(li_row) + ")"
				ls_color = dw_data.describe(ls_eval)
				dw_calendar.modify(ls_object + '.color="' + ls_color + '"')
			END IF
			
			// Set Text Weight
			IF NOT IsNumber(isx_options.dw_weight[li_field]) THEN
				ls_eval  = "evaluate('" + isx_options.dw_weight[li_field] + "'," + string(li_row) + ")"
				ls_weight = dw_data.describe(ls_eval)
				dw_calendar.modify(ls_object + '.Font.Weight="' + ls_weight + '"')
			END IF
			
		END IF		

		// Set the value
		dw_calendar.modify(ls_object + '.text="' + ls_value + '"')
		ls_value = '"' + ls_value + '"~t"' + ls_value + '"'
		dw_calendar.modify(ls_object + ".AccessibleName='" + ls_value + "'" )
		dw_calendar.modify(ls_object + ".AccessibleDescription='" + ls_value + "'" )

		// Move the dw to the appropriate location
		li_y = (li_cell - 1) / 7
		li_y = (li_y * 142) + (li_field * 15) + 45

		dw_calendar.modify( ls_object + ".x=" + string(li_x) )
		dw_calendar.modify( ls_object + ".y=" + string(li_y) )
		
	NEXT
	
	// Change background color for weekends
	IF (inv_date.of_dayofweek(ld_date)) = 1 &
	OR (inv_date.of_dayofweek(ld_date)) = 7 THEN
		dw_calendar.modify("d" + string(li_day) + "_day.background.color=" + string(icl_weekend))
		dw_calendar.modify("d" + string(li_day) + "_day.color=" + string(icl_weekend_font))
	ELSE
		dw_calendar.modify("d" + string(li_day) + "_day.background.color=" + string(icl_weekday))
		dw_calendar.modify("d" + string(li_day) + "_day.color=" + string(icl_weekday_font))
	END IF
	

	
	// Mark holidays
	IF isx_options.mark_holidays THEN
		ls_find 	= "FILTER_DATA = date('" + string(ld_date) + "')" 
		li_row 	= ids_holidays.Find(ls_find, 1, ids_holidays.rowcount())
		
		IF li_row > 0 THEN
			ls_rc = dw_calendar.modify("d" + string(li_day) + '_day.text="' + string(li_day) + ' - Holiday"')
			ls_value = '"' + string(li_day) + ' - Holiday"~t"' + string(li_day) + ' - Holiday"'
			dw_calendar.modify("d"  + string(li_day) + "_day.AccessibleName='" + ls_value + "'" )
			dw_calendar.modify("d"  + string(li_day) + "_day.AccessibleDescription='" + ls_value + "'" )
		END IF
	END IF

	// Mark filter_dates
	IF isx_options.mark_filter_dates THEN
		ls_find 	= "FILTER_DATA = date('" + string(ld_date) + "')" 
		li_row 	= ids_user_dates.Find(ls_find, 1, ids_user_dates.rowcount())
		
		IF li_row > 0 THEN
			dw_calendar.modify("r_" + string(li_day) + '.pen.width="3"')
		ELSE
			dw_calendar.modify("r_" + string(li_day) + '.pen.width="1"')
		END IF
	END IF
		
	dw_calendar.event ue_setdayvisible( li_day, TRUE )
	
	li_cell++
NEXT

dw_calendar.accepttext()
dw_calendar.SetRedraw(ib_redraw)

RETURN lb_day_exists
end function

on w_calendar.create
int iCurrent
call super::create
this.dw_data=create dw_data
this.pb_last=create pb_last
this.pb_next=create pb_next
this.pb_prior=create pb_prior
this.pb_first=create pb_first
this.cb_close=create cb_close
this.cb_update=create cb_update
this.ddlb_year=create ddlb_year
this.st_6=create st_6
this.st_5=create st_5
this.dw_calendar=create dw_calendar
this.ddlb_month=create ddlb_month
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
this.Control[iCurrent+2]=this.pb_last
this.Control[iCurrent+3]=this.pb_next
this.Control[iCurrent+4]=this.pb_prior
this.Control[iCurrent+5]=this.pb_first
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_update
this.Control[iCurrent+8]=this.ddlb_year
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.dw_calendar
this.Control[iCurrent+12]=this.ddlb_month
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_calendar.destroy
call super::destroy
destroy(this.dw_data)
destroy(this.pb_last)
destroy(this.pb_next)
destroy(this.pb_prior)
destroy(this.pb_first)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.ddlb_year)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.dw_calendar)
destroy(this.ddlb_month)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;//======================================================================================//
// Object		w_calendar
// Event			open
//======================================================================================//
// This window accepts a refernce to a grid datawindow and displays the information in
// monthly calendars. 
//======================================================================================//
// * Creates a copy of the refernce datawindow locally so sorting/filtering have no affect
// * Adds a hidden text element so Report list, etc.. know to open the report in this window
// * Sets header text elements
// * Prompts user for options
// * Draws initial calendar
//======================================================================================//
// Maintenance
// -------- ----- --------	-------------------------------------------------------------
// 11/08/04	MikeF	SPR4107d	Created
// 12/14/04 MikeF SPR4145d	Remove carraige returns from labels
//	12/20/04	GaryR	Track 4171d	Alert user if report has no data and close
// 01/06/05 MikeF SPR4205d	Must register dw with format service
// 01/28/05 MikeF				Bypass all char columns for list of columns to display.
// 01/28/05 MikeF SPR4265d	Remove all special character formatting from titles
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//======================================================================================//

string	ls_cols, ls_col_type, ls_col_name, ls_label, ls_format, ls_item
string	ls_value, ls_color, ls_weight, ls_field
string	ls_inv_type, ls_replace[]
int		li_index, li_metric, li_rc, li_field, li_pos
boolean	lb_valid

u_dw		ldw_ref

sx_dw_format		lsx_format
n_cst_dw_format	lnv_format
n_cst_string		lnv_string

// Create copy of datawindow so filtering / sorting has no effect on source
ldw_ref	= Message.PowerObjectParm
SetNull(Message.Powerobjectparm)

// Get information from DataWindow
ii_rows 	= ldw_ref.RowCount()

IF ii_rows < 1 THEN
	MessageBox( This.Title, "Report does not contain data!", StopSign! )
	POST Close( THIS )
	Return
END IF
ii_cols 	= integer(ldw_ref.Object.DataWindow.Column.Count)

// Copy rows to hidden u_dw for filtering, sorting, and saving
ls_value = ldw_ref.Object.DataWindow.Syntax
li_rc = dw_data.create(ls_value)
li_rc = ldw_ref.RowsCopy( 1, ii_rows, Primary!, dw_data, 1, Primary!)

// Set hidden label for save function
dw_data.modify('create text(band=foreground alignment="0" text="calendar" border="0" ' 				+ &
			'color="8388608" x="2" y="6" height="1" width="1" html.valueishtml="0" ' 			+ &
			'name=t_calendar visible="0" font.face="Microsoft Sans Serif" font.height="-8" '	+ &
			'font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" ' + &
			'background.color="536870912" )')

// Find Date column (should be first)
FOR li_index = 1 TO ii_cols
	ls_col_type = ldw_ref.describe("#" + string(li_index) + ".ColType")
	ls_col_name = ldw_ref.describe("#" + string(li_index) + ".DbName")
	ls_format 	= ldw_ref.describe("#" + string(li_index) + ".Format")
	ls_color		= ldw_ref.describe("#" + string(li_index) + ".Color")
	ls_weight	= ldw_ref.describe("#" + string(li_index) + ".Font.Weight")
	ls_label 	= ldw_ref.describe(ls_col_name + "_t.text")
	ls_label		= lnv_string.of_clean_string(ls_label)
	ls_label		= lnv_string.of_removequotes(ls_label)
	
	IF ls_col_type 	= 'date' &
	OR ls_col_type 	= 'datetime' THEN
		ii_date_col 	= li_index
		is_date_col 	= ls_col_name
		is_date_type 	= ls_col_type
	ELSE
		// Bypass all non-visible and string columns.
		IF ldw_ref.describe("#" + string(li_index) + ".visible") = "0" &
		OR pos(ls_col_type,'char') > 0 THEN
			CONTINUE
		END IF
	
		// Current column is a Metric. Populate structure
		li_metric++
		isx_options.dw_col		[li_metric] = li_index
		isx_options.dw_col_name [li_metric] = ls_col_name
		isx_options.dw_col_type [li_metric] = ls_col_type
		isx_options.dw_format 	[li_metric] = ls_format
		isx_options.dw_label	 	[li_metric] = ls_label
		
		IF IsNumber(ls_color) THEN
			isx_options.dw_color	[li_metric] = ls_color
		ELSE
			li_pos = pos(ls_color,"~t")
			IF li_pos > 0 THEN
				ls_color = mid(ls_color,li_pos + 1)
				isx_options.dw_color	[li_metric] = lnv_string.of_removequotes(ls_color)
			ELSE
				isx_options.dw_color	[li_metric] = "0"
			END IF
		END IF

		IF IsNumber(ls_weight) THEN
			isx_options.dw_weight[li_metric] = ls_weight
		ELSE
			li_pos = pos(ls_weight,"~t")
			IF li_pos > 0 THEN
				ls_weight = mid(ls_weight,li_pos + 1)
				isx_options.dw_weight [li_metric] = lnv_string.of_removequotes(ls_weight)
			ELSE
				isx_options.dw_weight [li_metric] = "400"
			END IF
		END IF
	END IF
NEXT

dw_data.SetSort( is_date_col + " ASC")
dw_data.Sort() 

// Get the earliest and latest dates for navigation / validation
IF is_date_type = 'date' THEN
	id_min_date = dw_data.GetItemdate(1, is_date_col)
	id_max_date = dw_data.GetItemdate(ii_rows, is_date_col)
ELSE
	ib_datetime = TRUE
	id_min_date = date(dw_data.GetItemdatetime(1, is_date_col))
	id_max_date = date(dw_data.GetItemdatetime(ii_rows, is_date_col))
END IF

isx_options.min_date = id_min_date
isx_options.max_date = id_max_date

// Get other things
ls_inv_type = left(ldw_ref.describe("st_inv_type.text"),2)

// Check if Subset Summary
IF ldw_ref.tag = 'CRYSTAL, title = Summary Report' THEN
	isx_options.report_title 	= 'Subset Summary Report'
	lsx_format.subject_label 	= 'Summary Field'
	lsx_format.subject		 	= gnv_dict.event ue_get_col_desc(ls_inv_type,is_date_col)
ELSE
	// Title
	ls_value = dw_data.describe("st_title.text") 
	IF ls_value = '!'	THEN
		ls_value = dw_data.describe("st_report_type.text") 
		IF ls_value = '!'	THEN
			isx_options.report_title = ' '
		ELSE
			isx_options.report_title = lnv_string.of_unfix_dwtext(ls_value)
		END IF
	ELSE
		isx_options.report_title = lnv_string.of_unfix_dwtext(ls_value)
	END IF
	
	// Subject ID
	ls_value = ldw_ref.describe("t_subject.text")
	IF ls_value <> '!'	THEN
		lsx_format.subject_label = ls_value
	END IF

	// Subject ID
	ls_value = ldw_ref.describe("st_subject.text")
	
	// If conditional statement, get the value
	IF ls_value = '!'	THEN
		ls_value = ldw_ref.describe("st_subject.expression")
		ls_value = 'evaluate("' + ls_value + '",1)'
		ls_value = ldw_ref.describe(ls_value)
	END IF
	
	IF ls_value = '!' THEN
		lsx_format.subject = ' '
	ELSE
		lsx_format.subject = ls_value
	END IF
END IF

// Subset ID and description
ls_value = ldw_ref.describe("st_subset.text")
IF ls_value <> '!'	THEN
	lsx_format.subset = ls_value
END IF

// Invoice Type
ls_value = ldw_ref.describe("st_inv_type.text")
IF ls_value <> '!'	THEN
	lsx_format.inv_type = ls_value
END IF

// Report Date
ls_value = ldw_ref.describe("st_date.text")
IF ls_value <> '!'	THEN
	lsx_format.report_date = ls_value
END IF

// Set Year DropDown
FOR li_index = year(id_min_date) TO year(id_max_date)
	ddlb_year.Additem( string(li_index) )
NEXT

// Open Options window
OpenWithParm(w_calendar_options,isx_options,this)

// Retrieve isx_options from Close
isx_options = Message.Powerobjectparm
SetNull(Message.Powerobjectparm)

IF isx_options.cancelled THEN
	close(this)
	RETURN
END IF

// Set the rest of the header structure and create header
lsx_format.portrait		= TRUE
lsx_format.title 			= isx_options.report_title
lsx_format.description 	= isx_options.report_desc
lsx_format.display_inv_type 	= TRUE
lsx_format.display_subset 		= TRUE
lsx_format.display_report_date= TRUE
lsx_format.display_subject		= TRUE

lnv_format.event ue_register_dw(dw_calendar)
lnv_format.uf_add_header(lsx_format)

// Loop through options and capture stuff.
ii_cols	= UpperBound(isx_options.dw_col)

// Set labels for all 6 weeks.
FOR li_index = 1 TO 6
	FOR li_field = 1 TO ii_cols
		dw_calendar.modify("wk" + string(li_index) + "_label" + string(li_field) + &
								 ".text='" + isx_options.dw_label[li_field] + "'")
		//	Set Accessibility Properties
		ls_label = '"' + isx_options.dw_label[li_field] + '"~t"' + isx_options.dw_label[li_field] + '"'
		dw_calendar.modify("wk" + string(li_index) + "_label" + string(li_field) + &
									".AccessibleName='" + ls_label + "'" )
		dw_calendar.modify("wk" + string(li_index) + "_label" + string(li_field) + &
									".AccessibleDescription='" + ls_label + "'" )
	NEXT
NEXT

// Retrieve Holiday date filter
IF isx_options.mark_holidays THEN
	ids_holidays = CREATE n_ds
	ids_holidays.DatAObject = 'd_filter_vals_date'
	ids_holidays.SetTransObject(stars2ca)
	ids_holidays.SetSQLSelect("SELECT FILTER_DATA FROM FV_SYSHOLIDAY")
	li_rc = ids_holidays.Retrieve()
END IF

// Retrieve User requested date filter
IF isx_options.mark_filter_dates THEN
	ids_user_dates = CREATE n_ds
	ids_user_dates.DatAObject = 'd_filter_vals_date'
	ids_user_dates.SetTransObject(stars2ca)
	ids_user_dates.SetSQLSelect("SELECT FILTER_DATA FROM FV_" + mid(isx_options.filter_id,2))
	li_rc = ids_user_dates.Retrieve()
END IF

// Draw the requested month
ib_redraw = TRUE
this.wf_draw_calendar( isx_options.report_date )
end event

event ue_print;//===================================================================================//
// Object		w_calendar
//	Event			ue_print
//	Arguments	<None>
//	Returns		<None>
//===================================================================================//
// Prints one or more calendars
//===================================================================================//
//	Maintenance
// -------- ----- ----------- -------------------------------------------------------
//	11/05/04	MikeF	SPR 5817c	Created
//===================================================================================//
int		li_index, li_months, li_rc
date		ld_date, ld_current, ld_begin, ld_end
long		ll_print_job

// Prompt user for print options
this.wf_get_options()

IF isx_print_options.cancelled THEN
	RETURN
END IF

// Set the range to print
CHOOSE CASE isx_print_options.month_selection 
	CASE ici_all
		ld_begin = id_min_date
		ld_end 	= id_max_date
	CASE ici_current 
		ld_begin = id_report_date
		ld_end 	= id_report_date
	CASE ici_range
		ld_begin = isx_print_options.begin_date
		ld_end 	= isx_print_options.end_date
END CHOOSE

// Capture current month so the user ends up where they began
ld_current	= id_report_date
ib_redraw	= FALSE

// Calculate the number of months
ld_date 	 = inv_date.of_firstdayofmonth(ld_begin)
li_months = inv_date.of_monthsafter(ld_date,inv_date.of_lastdayofmonth(ld_end)) + 1

// Create Print Job
ll_print_job = PrintOpen()

// Draw and print each month
FOR li_index = 1 TO li_months
	IF this.wf_draw_calendar(ld_date) &
	OR isx_print_options.print_blank THEN
		PrintDataWindow(ll_print_job,dw_calendar)
	END IF
	ld_date = inv_date.of_getnextmonth(ld_date)
NEXT

PrintClose(ll_print_job)

// Refresh dw_calendar
ib_redraw	= TRUE
this.wf_draw_calendar(ld_current)
end event

type dw_data from u_dw within w_calendar
boolean visible = false
string accessiblename = "Calendar Data"
string accessibledescription = "Calendar Data"
integer x = 2674
integer y = 36
integer width = 389
integer height = 144
integer taborder = 20
end type

type pb_last from picturebutton within w_calendar
string accessiblename = "Last Month"
string accessibledescription = "Last Month"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2437
integer y = 72
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRLast!"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Scrolls to last month~'s report"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;parent.wf_draw_calendar(id_max_date)

end event

type pb_next from picturebutton within w_calendar
string accessiblename = "Next Month"
string accessibledescription = "Next Month"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2309
integer y = 72
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRNext!"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Next month~'s report"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;parent.wf_draw_calendar(inv_date.of_getnextmonth(id_report_date))

end event

type pb_prior from picturebutton within w_calendar
string accessiblename = "Previous Month"
string accessibledescription = "Previous Month"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2181
integer y = 72
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRPrior!"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Previous month~'s report"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;parent.wf_draw_calendar(inv_date.of_getpriormonth(id_report_date))

end event

type pb_first from picturebutton within w_calendar
string accessiblename = "First Month"
string accessibledescription = "First Month"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2053
integer y = 72
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRFirst!"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Scrolls to earliest month~'s report"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;parent.wf_draw_calendar(id_min_date)

end event

type cb_close from commandbutton within w_calendar
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3470
integer y = 56
integer width = 343
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_update from commandbutton within w_calendar
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1454
integer y = 52
integer width = 343
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Update"
end type

event clicked;parent.wf_draw_calendar(date(ddlb_year.text + ' ' + ddlb_month.text + ' 1'))

end event

type ddlb_year from dropdownlistbox within w_calendar
string accessiblename = "Year"
string accessibledescription = "Year"
accessiblerole accessiblerole = comboboxrole!
integer x = 987
integer y = 80
integer width = 361
integer height = 488
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_calendar
string accessiblename = "Year"
string accessibledescription = "Year"
accessiblerole accessiblerole = statictextrole!
integer x = 841
integer y = 88
integer width = 123
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_calendar
string accessiblename = "Month"
string accessibledescription = "Month"
accessiblerole accessiblerole = statictextrole!
integer x = 87
integer y = 92
integer width = 174
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Month"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_calendar from u_dw within w_calendar
event ue_reset ( )
event ue_setdayvisible ( integer ai_day,  boolean ab_visible )
string tag = "Calendar"
string accessiblename = "Calendar"
string accessibledescription = "Calendar"
integer x = 55
integer y = 208
integer width = 3776
integer height = 2052
integer taborder = 50
string dataobject = "d_calendar_month"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_reset();//======================================================================================//
// Object		dw_calendar
// Event			ue_reset
// Arguments	None
// Returns		None
//======================================================================================//
// Resets all days
//======================================================================================//
// Maintenance
// -------- ----- --------	-------------------------------------------------------------
// 11/08/04	MikeF	SPR4107d	Created
//======================================================================================//

int loop_ix

FOR loop_ix = 1 TO 31
	this.event ue_setdayvisible( loop_ix, FALSE)
NEXT
end event

event ue_setdayvisible(integer ai_day, boolean ab_visible);//======================================================================================//
// Object		dw_calendar
// Event			ue_setdayvisible
// Arguments	None
// Returns		None
//======================================================================================//
// Toggles all elements for a day visible property
//======================================================================================//
// Maintenance
// -------- ----- --------	-------------------------------------------------------------
// 11/08/04	MikeF	SPR4107d	Created
//======================================================================================//
this.modify( "d" + string(ai_day) +"_day.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_1.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_2.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_3.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_4.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_5.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_6.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_7.visible=" + string(ab_visible))
this.modify( "d" + string(ai_day) +"_8.visible=" + string(ab_visible))
this.modify( "r_" + string(ai_day) + ".visible=" + string(ab_visible))
end event

type ddlb_month from dropdownlistbox within w_calendar
string accessiblename = "Month"
string accessibledescription = "Month"
accessiblerole accessiblerole = comboboxrole!
integer x = 302
integer y = 80
integer width = 480
integer height = 1244
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_calendar
string accessiblename = "Navigation"
string accessibledescription = "Navigation"
accessiblerole accessiblerole = groupingrole!
integer x = 2021
integer y = 4
integer width = 544
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Navigation"
end type

type gb_2 from groupbox within w_calendar
string accessiblename = "Displayed Report Period"
string accessibledescription = "Displayed Report Period"
accessiblerole accessiblerole = groupingrole!
integer x = 55
integer y = 4
integer width = 1769
integer height = 184
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Displayed Report Period"
end type

