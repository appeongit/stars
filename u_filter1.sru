HA$PBExportHeader$u_filter1.sru
$PBExportComments$Inherited from u_sort_dw <gui>
forward
global type u_filter1 from u_sort_dw
end type
end forward

global type u_filter1 from u_sort_dw
string accessiblename = "Filter"
string accessibledescription = "Filter"
integer width = 2473
integer height = 576
end type
global u_filter1 u_filter1

forward prototypes
public subroutine fuo_set_value (string arg_value)
public function string fuo_make_in_filter (string arg_col_name, string arg_operation, string arg_in_value, string arg_data_type, string arg_logic)
end prototypes

public subroutine fuo_set_value (string arg_value);//*********************************************************************************
// Script Name:	fuo_set_value
//
// Arguments:	string	arg_value
//
// Returns:		N/A
//
// Description:	Set value in the dw_sort datawindow.
//
//*********************************************************************************
//
//
//*********************************************************************************
string lv_value
int lv_row 
lv_row = dw_sort.getrow()
lv_value = dw_sort.getitemstring(lv_row,3)
dw_sort.setitem(lv_row,3,arg_value)
end subroutine

public function string fuo_make_in_filter (string arg_col_name, string arg_operation, string arg_in_value, string arg_data_type, string arg_logic);//*********************************************************************************
// Script Name:	fuo_make_in_filter
//
// Arguments:	string	arg_col_name
//					string arg_operation
//					string arg_in_value
//					string	arg_data_type
//					string	arg_logic
//
// Returns:		string
//
// Description:	Create filter string.
//
//*********************************************************************************
//
//
//*********************************************************************************
string lv_value,lv_in_filter,lv_date_value
integer lv_position,lv_counter
date lv_date

lv_in_filter  = "("
lv_counter = 1
do while match(arg_in_value,",") OR arg_in_value <> ""
	if match(arg_in_value,",") Then
		lv_position = pos(arg_in_value,",")
		lv_value = left(arg_in_value,lv_position - 1)
		arg_in_value = mid(arg_in_value,lv_position + 1)
	else
		lv_value = arg_in_value
		arg_in_value = ""
	end if
	if Match(UPPER(arg_data_type),'CHAR') Then 
		lv_value = "'"+lv_value+"'"
		if lv_counter  = 1 then
			// KTB 03-01-00 Spec #2456. Make Display Filter non-case-sensitive
			// Convert arg_col_name and lv_value to Upper Case.
			lv_in_filter = lv_in_filter+"UPPER("+arg_col_name+')'+ &
			               arg_operation+" "+"UPPER("+lv_value+')' 
		else
			lv_in_filter = lv_in_filter+" OR "+"UPPER("+arg_col_name+ &
			               arg_operation+ " "+"UPPER("+lv_value+')' 
			// End KTB
		end if
	end if
		if UPPER(arg_data_type) = 'DATETIME' Then
			lv_date = date(lv_value)
			lv_date_value = string(lv_date,'mm/dd/yy')
			if lv_counter = 1 then
				lv_in_filter = lv_in_filter + "string(" + arg_col_name + ",'mm/dd/yy')" + arg_operation + "'"+lv_date_value + "'"
			else
				lv_in_filter = lv_in_filter + " OR " + "string(" + arg_col_name + ",'mm/dd/yy')" + arg_operation + "'"+lv_date_value + "'"
			end if
		end if
	//NLG 11-04-97 check for numeric      START ****
	if Match(UPPER(arg_data_type),'NUMBER') OR Match(UPPER(arg_data_type),'DECIMAL') then 
		if lv_counter = 1 then
			lv_in_filter = lv_in_filter+arg_col_name + arg_operation + " " +lv_value
		else
			lv_in_filter = lv_in_filter+" OR "+arg_col_name + arg_operation + " " +lv_value
		end if
	end if
	//NLG 11-04-97 check for numeric      STOP ****		
	lv_counter++
loop

lv_in_filter = lv_in_filter + ")" 

return lv_in_filter
end function

on u_filter1.create
call super::create
end on

on u_filter1.destroy
call super::destroy
end on

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	constructor
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Constructor for the object.  
//
//*********************************************************************************
//
//FNC	11-26-97	Track 223 Rel3.6 TS 243 CBX_Suppress is bleeding 
//					through in Windows NT when display filter is selected and 
//					clear button is selected. Hide checkbox so it does not show
//	04/21/09	Katie	GNL.600.5633	Set in_dups_allowed to true.
//
//*************************************************************************
in_dups_allowed = true
end event

type cb_delete from u_sort_dw`cb_delete within u_filter1
integer x = 2130
integer y = 256
end type

event cb_delete::clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_delete.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Clear logic operation for final row.
//
//*********************************************************************************
//
//	Katie	04/11/09	GNL.600.5633	Initial Creation.
//
//*********************************************************************************
int li_rowcount

li_rowcount = dw_sort.rowcount( )
dw_sort.setitem(li_rowcount, "logic", " ")
end event

type cb_insert from u_sort_dw`cb_insert within u_filter1
integer x = 2130
integer y = 160
end type

type cbx_suppress from u_sort_dw`cbx_suppress within u_filter1
boolean visible = false
end type

type cb_reset from u_sort_dw`cb_reset within u_filter1
boolean visible = true
integer x = 2130
integer y = 448
integer width = 315
integer taborder = 70
end type

event cb_reset::clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_reset.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Get rowcount.
//
//*********************************************************************************
//
//	04/04/00	FDG	Track 2843c.  Use a long (instead of integer) to get the
//						rowcount.  This will prevent negative numbers from 
//						appearing.
//
//*********************************************************************************

long lv_total_count


singlelineedit sle
statictext st

if in_count_object.typeof() = singlelineedit! Then
	lv_total_count = in_datawindow_name.rowcount()
	sle = in_count_object
	sle.text = string(lv_total_count)
Else
	lv_total_count = in_datawindow_name.rowcount()
	st = in_count_object
	st.text = string(lv_total_count)
end if

in_datawindow_name.triggerevent(rowfocuschanged!)
end event

type cb_clear from u_sort_dw`cb_clear within u_filter1
integer x = 2130
integer y = 352
end type

event cb_clear::clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_clear.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Hide suppress checkbox.
//
//*********************************************************************************
//
//	11-26-97	FNC	Track 223 Rel3.6 TS 243 CBX_Suppress is bleeding 
//					through in Windows NT when display filter is selected and 
//					clear button is selected. Hide checkbox so it does not show
//
//*************************************************************************

cbx_suppress.hide()		//11-26-97 FNC
end event

type cb_sort from u_sort_dw`cb_sort within u_filter1
string accessiblename = "Filter"
string accessibledescription = "Filter"
integer x = 2130
integer y = 64
string text = "Filter"
end type

event cb_sort::clicked;//*********************************************************************************
// Script Name:	cb_sort.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Perform filter operation
//
//*********************************************************************************
//
//	01/20/99	FDG	Track 2058c.  Use 4 digit year.
// 03/01/00 KTB   Track 2456c.  Make Display filter non-case-sensitive.
// 03/27/00	FDG	Track 2456c.  Add additional logic to make the filter
//						non-case-sensitive.
//	04/04/00	FDG	Track 2843c.  Use a long (instead of integer) to get the
//						rowcount.  This will prevent negative numbers from 
//						appearing.
//	08/14/03	GaryR	Track 3647d	Fix numeric filters with between
//	04/10/09	Katie	GNL.600.5633 Altered the logic to pull the column names 
//						and db col name from the sort_col drop down datawindow.
//						Add logic to remove blank rows.
//	05/29/09	Katie	GNL.600.5633 Trim the filter column to support the Provider List with trailing spaces.
// 08/05/09	GaryR	WIN.650.5721.002	Defect #127 - Trim labels
//
///////////////////////////////////////////////////////////////////////////

long num_of_rows,lv_row,lv_counter,lv_position,lv_total_count
long lv_upperbound
int li_ctr, li_rowcount, li_delcount
datawindowchild ldwc_uo_columns
string lv_filter_name,lv_operation,lv_filter_value,lv_filter
string lv_value,lv_logic,lv_value1,lv_value2, lv_sort_name
string lv_date_value1,lv_date_value2, lv_data_type
date lv_date1,lv_date2
singlelineedit sle
statictext st

//Go through rows removing duplicates and blanks
li_rowcount = dw_sort.rowcount()
FOR li_ctr = 1 TO li_rowcount
	lv_sort_name = parent.dw_sort.GetItemString( li_ctr, "sort_name" )
	if (trim(lv_sort_name) = "" or isNull(lv_sort_name))then 
		parent.dw_sort.setitem( li_ctr, "delete", "Y")
		parent.dw_sort.accepttext( )
		li_delcount = li_delcount + 1
	end if
Next
if li_delcount>0 then
	parent.cb_delete.event clicked( )
end if

num_of_rows = dw_sort.rowcount()
dw_sort.getchild( "sort_name", ldwc_uo_columns)
//This loops through the datawindow  and builds the sort string
//for the setsort
For lv_row = 1 to num_of_rows	
	lv_filter_name = dw_sort.GetItemString(lv_row,1)
	lv_operation = dw_sort.getitemstring(lv_row,2)
	lv_value = dw_sort.getitemstring(lv_row,3)
	if isnull(lv_value) Then
		lv_value = ""
	else
		lv_value = UPPER(lv_value)
	end if

	lv_logic = dw_sort.getitemstring(lv_row,4)
	lv_counter = 1
	lv_upperbound = ldwc_uo_columns.rowcount( )
	Do while lv_counter <= lv_upperbound
		if lv_filter_name = ldwc_uo_columns.getitemstring(lv_counter, "col_name") then
			lv_filter_value = ldwc_uo_columns.getitemstring(lv_counter, "db_col")
			lv_data_type = ldwc_uo_columns.getitemstring(lv_counter, "datatype")
		end if
		lv_counter++
	Loop
	
	If isnull(lv_logic) then
		lv_logic = ''
	End If

	If match(lv_value,",") and lv_operation = "=" Then
		lv_filter = lv_filter + fuo_make_in_filter(lv_filter_value,lv_operation,lv_value,lv_data_type,lv_logic)
		lv_filter = lv_filter+" " + lv_logic + " "
	Elseif lv_operation = "><" Then
		If match(lv_value,",") Then
			lv_position = pos(lv_value,",")
			lv_value1 = left(lv_value,lv_position - 1)
			lv_value2 = mid(lv_value,lv_position + 1)
		End If
		If Match(UPPER(lv_data_type),'CHAR') Then
			lv_value1 = "'"+lv_value1+"'"
			lv_value2 = "'"+lv_value2+"'"
			lv_filter = lv_filter + "(" + "UPPER(" +lv_filter_value + ")" + " >= " + &
			           "UPPER(" + lv_value1 + ")" + " " + " AND " + &
						  "UPPER(" + lv_filter_value + ")" + " <=" + &
						  "UPPER(" + lv_value2 + ")" + " ) " + lv_logic + " "
		ElseIf UPPER(lv_data_type) = 'DATETIME' Then 
			lv_date1 = date(lv_value1)
			lv_date2 = date(lv_value2)
			lv_date_value1 = string(lv_date1,'yyyy/mm/dd') 
			lv_date_value2 = string(lv_date2,'yyyy/mm/dd') 
			lv_filter = lv_filter + "string(" + lv_filter_value + ",'yyyy/mm/dd')" &
				+ " >= " + "'"+lv_date_value1 + "'" + " AND "  + " " &
				+"string(" + lv_filter_value + ",'yyyy/mm/dd')" + " <= " &
				+ "'"+lv_date_value2 + "'"	&
				+ " " + lv_logic + " " 
		Else
			lv_filter = lv_filter + "(" + lv_filter_value + ">=" + lv_value1 + " AND " + &
							lv_filter_value + "<=" + lv_value2 + ")" + lv_logic + " "
		End If		
	Else
		If Match(UPPER(lv_data_type),'CHAR') Then
			lv_value = '~''+lv_value+'~''
			lv_value1 = "'"+lv_value1+"'"
			lv_value2 = "'"+lv_value2+"'"
			lv_filter	=	lv_filter	+	"UPPER("	+	lv_filter_value	+	&
								") "	+	lv_operation	+	' '	+	lv_value	+	&
								' '	+	lv_logic	+	' '
		ElseIf UPPER(lv_data_type) = 'DATETIME' Then
			lv_date1 = date(lv_value)
			lv_date_value1 = string(lv_date1,'yyyy/mm/dd')
			lv_filter = lv_filter + "string(" + lv_filter_value + ",'yyyy/mm/dd')" + lv_operation + "'"+lv_date_value1 + "'" + lv_logic + " "
		Else
			lv_filter = lv_filter+lv_filter_value + lv_operation +' '+lv_value+' ' +lv_logic+' '
		End If		
	End If
Next

lv_filter = trim(lv_filter)

//does the setsort and the sort
in_datawindow_name.SetFilter(lv_filter) 
in_datawindow_name.Filter()

in_datawindow_name.setrow(1)
in_datawindow_name.scrolltorow(1)
in_datawindow_name.triggerevent(rowfocuschanged!)
cb_sort.enabled = FALSE

if in_count_object.typeof() = singlelineedit! Then
	lv_total_count = in_datawindow_name.rowcount()
	sle = in_count_object
	sle.text = string(lv_total_count)
Else
	lv_total_count = in_datawindow_name.rowcount()
	st = in_count_object
	st.text = string(lv_total_count)
end if


end event

type dw_sort from u_sort_dw`dw_sort within u_filter1
integer x = 55
integer y = 64
integer width = 2071
integer height = 480
string dataobject = "d_filter"
end type

event dw_sort::itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	dw_sort.itemchanged
//
// Arguments:	long		row
//					dwobject	dwo
//					string		data
//
// Returns:		long
//
// Description:	Validate entries and hide suppress checkbox.
//
//*********************************************************************************
//
//FNC	11-26-97	Track 223 Rel3.6 TS 243 CBX_Suppress is bleeding 
//					through in Windows NT when display filter is selected and 
//					clear button is selected. Hide checkbox so it does not show
//	Katie	04/11/09	GNL.600.5633	Changed logic to use the values in the sort name drop down datawindow.
//
//*************************************************************************

string lv_value,lv_operator,lv_value1,lv_value2, lv_data_type, lv_sort_name
int lv_col_no,lv_row,lv_position, lv_ldwc_row
int li_value1, li_value2
datawindowchild ldwc_uo_columns

cb_sort.enabled = TRUE
lv_row = dw_sort.getrow()
lv_col_no = this.getcolumn()
dw_sort.getchild("sort_name", ldwc_uo_columns)
if lv_col_no = 3 then
	lv_operator = dw_sort.getitemstring(lv_row,2)
	lv_value = dw_sort.gettext()
	lv_sort_name = dw_sort.getitemstring(lv_row,"sort_name")
	lv_ldwc_row = ldwc_uo_columns.find("col_name ='"+lv_sort_name+"'",0,ldwc_uo_columns.rowcount())
	lv_data_type = ldwc_uo_columns.getitemstring(lv_ldwc_row, "datatype")
	if UPPER(lv_data_type) = 'DATETIME' Then
		if match(lv_value,",") then
			lv_position = pos(lv_value,",")
			lv_value1 = left(lv_value,lv_position - 1)
			lv_value2 = mid(lv_value,lv_position + 1)
			IF ISDate(lv_value1) = FALSE or IsDate(lv_value2) = False Then 
				messagebox("ERROR","This field has to be a Date Field")
				Return
			end if 
			if lv_operator = "><" then
				if Date(lv_value1) >= Date(lv_value2) Then
					Messagebox("ERROR","The first value cannot be bigger then the second value")
					Return
				end if
			end if
		Else
			IF ISDate(lv_value) = FALSE Then 
				messagebox("ERROR","This field has to be a Date Field")
				Return
			end if
		End If
		Return
	end if
End If

if lv_col_no = 3 then
	lv_operator = dw_sort.getitemstring(lv_row,2)
	lv_value = dw_sort.gettext()
	lv_ldwc_row = ldwc_uo_columns.find("col_name ='"+dw_sort.getitemstring(lv_row,"sort_name")+"'",0,ldwc_uo_columns.rowcount())
	lv_data_type = ldwc_uo_columns.getitemstring(lv_ldwc_row, "datatype")
	if UPPER(lv_data_type) = 'NUMBER' OR &
			Match(UPPER(ldwc_uo_columns.getitemstring(lv_ldwc_row, "datatype")),'DECIMAL') Then
		if lv_operator = "><" or match(lv_value,",")	then
			lv_position = pos(lv_value,",")
			lv_value1 = left(lv_value,lv_position - 1)
			lv_value2 = mid(lv_value,lv_position + 1)
			if isnumber(lv_value1) = FALSE or isnumber(lv_value2) = FALSE then
				messagebox("ERROR","This field has to be a number")
				return	
			end if
			li_value1 = integer(lv_value1)
			li_value2 = integer(lv_value2)
			if lv_operator = "><" AND (li_value1 >= li_value2) then
				Messagebox("ERROR","The first value cannot be bigger than the second")
				return
			end if
		else
			IF ISNUMBER(lv_value) = FALSE Then 
				messagebox("ERROR","This field has to be a number")
				Return
			end if 
		end if
	elseif lv_operator = "><" then
		lv_position = pos(lv_value,",")
		lv_value1 = left(lv_value,lv_position - 1)
		lv_value2 = mid(lv_value,lv_position + 1)
		if lv_value1 >= lv_value2 Then
			Messagebox("ERROR","The first value cannot be bigger then the second value")
			Return	
		end if
	end if
end if

cbx_suppress.hide()
end event

event dw_sort::rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	dw_sort.rowfocuschanged
//
// Arguments:	long 		currentrow
//
// Returns:		long
//
// Description:	Set logic when adding new row.
//
//*********************************************************************************
//
//
//*********************************************************************************
string lv_logic 
long lv_row

lv_row = getrow() - 1
if lv_row <= 0 then return
lv_logic = this.getitemstring(lv_row,'logic')
if ISNULL(lv_logic) OR lv_logic = '' then
	this.SetItem(lv_row,'logic','AND')
end if
end event

event dw_sort::doubleclicked;call super::doubleclicked;//*********************************************************************************
// Script Name:	dw_sort.doubleclicked
//
// Arguments:	long 		xpos
//					long		pos
//					long		row
//					dwobject	dwo
//
// Returns:		long
//
// Description:	Hide suppress checkbox.
//
//*********************************************************************************
//
//FNC	11-26-97	Track 223 Rel3.6 TS 243 CBX_Suppress is bleeding 
//					through in Windows NT when display filter is selected and 
//					clear button is selected. Hide checkbox so it does not show
//*************************************************************************

cbx_suppress.hide()
end event

type gb_1 from u_sort_dw`gb_1 within u_filter1
integer x = 27
integer width = 2437
integer height = 564
integer taborder = 80
string text = "Filter By"
end type

