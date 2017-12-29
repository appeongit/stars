HA$PBExportHeader$u_sort_rank.sru
$PBExportComments$Inherited from u_sort_dw <gui>
forward
global type u_sort_rank from u_sort_dw
end type
type rb_top from radiobutton within u_sort_rank
end type
type rb_bot from radiobutton within u_sort_rank
end type
type st_1 from statictext within u_sort_rank
end type
type dw_rank_num from u_dw within u_sort_rank
end type
end forward

global type u_sort_rank from u_sort_dw
string accessiblename = "Sort Rank"
string accessibledescription = "Sort Rank"
integer width = 1984
integer height = 600
rb_top rb_top
rb_bot rb_bot
st_1 st_1
dw_rank_num dw_rank_num
end type
global u_sort_rank u_sort_rank

type variables
//*********************************************************************************
// Script Name:	Instance Variables
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description:	Instance Variables
//
//*********************************************************************************
//
//
//*********************************************************************************
boolean iv_already_checked
boolean in_filtered
end variables

on u_sort_rank.create
int iCurrent
call super::create
this.rb_top=create rb_top
this.rb_bot=create rb_bot
this.st_1=create st_1
this.dw_rank_num=create dw_rank_num
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_top
this.Control[iCurrent+2]=this.rb_bot
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_rank_num
end on

on u_sort_rank.destroy
call super::destroy
destroy(this.rb_top)
destroy(this.rb_bot)
destroy(this.st_1)
destroy(this.dw_rank_num)
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
//	FDG 11/20/97 - Stars 3.6 - replace sle_rank_num with dw_rank_num
//						because sle_rank_num could not receive focus.
//
//*********************************************************************************


Long	ll_row

ll_row	=	dw_rank_num.InsertRow(0)
dw_rank_num.ScrollToRow (ll_row)

end event

type cb_delete from u_sort_dw`cb_delete within u_sort_rank
integer x = 1614
integer y = 260
integer taborder = 80
end type

type cb_insert from u_sort_dw`cb_insert within u_sort_rank
integer x = 1614
integer y = 160
integer taborder = 70
end type

type cbx_suppress from u_sort_dw`cbx_suppress within u_sort_rank
integer y = 68
integer height = 96
integer taborder = 40
end type

type cb_reset from u_sort_dw`cb_reset within u_sort_rank
boolean visible = true
integer x = 1614
integer y = 456
integer width = 315
integer taborder = 100
end type

event cb_reset::clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_reset.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Rest the datawindo
//
//*********************************************************************************
//
// JSB Track 2407/3591/2610 added so that RESET
//          button will cause all rows to be re-displayed.
//
//*********************************************************************************

string ls_rc, ls_filter
long lv_total_count, ll_row_count
singlelineedit sle

cb_clear.triggerevent(clicked!)

if cbx_suppress.checked then
	ls_rc = in_datawindow_name.modify("datawindow.sparse = ''")	
	cbx_suppress.checked = FALSE
end if

if in_count_object.typeof() = singlelineedit! Then
	lv_total_count = in_datawindow_name.rowcount()
	sle = in_count_object
	sle.text = string(lv_total_count)
end if

ll_row_count = in_datawindow_name.rowcount()
ls_filter = 'rowcount() = ' + string(ll_row_count)
in_datawindow_name.setfilter(ls_filter)
in_datawindow_name.filter()
end event

type cb_clear from u_sort_dw`cb_clear within u_sort_rank
integer x = 1614
integer y = 360
integer taborder = 90
end type

event cb_clear::clicked;//*********************************************************************************
// Script Name:	cb_clear.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Default rank_num and top radio button prior to calling cb_clear of u_sort_dw.  
//
//*********************************************************************************
//
//	11/20/97	FDG 
//	05/07/09	Katie	GNL.600.5633	Disable cb_reset button.
//
//*********************************************************************************

dw_rank_num.object.rank_num [1] = ''		
rb_top.checked = TRUE
rb_bot.checked = FALSE
CALL U_SORT_DW `cb_clear::clicked

end event

type cb_sort from u_sort_dw`cb_sort within u_sort_rank
integer x = 1614
integer y = 60
integer taborder = 60
end type

event cb_sort::clicked;//*********************************************************************************
// Script Name:	cb_sort.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Perform the sort operation.  
//
//*********************************************************************************
//
//	05/05/99 FNC	Track 2231.  Stars 4.0 (SP2). Change integer function to long function.
//	04/19/99	FDG	Track 2231.  Stars 4.0 (SP2).  Change integers to long in case the
//						rowcount exceeds 32K.
//  04/10/09	Katie	GNL.600.5633 Changed to retrieving column names and data types from the sort_name column
//						of dw_sort.  Clean out duplicates and blanks before processing sort.
//	04/22/09	Katie	GNL.600.5633	Remove logic that was deleting duplicates and change logic for removing blanks to
//						remove them directly from the data window rather than use the db_delete.clicked function.
//	07/20/09	GaryR	WIN.650.5721.006	Accomodate blank rows
//
/////////////////////////////////////////////////////////////////////////////////////


Long	lv_row,lv_counter,lv_position		// FDG 04/19/99
string lv_first_sort_value,lv_sort_name,lv_order,lv_sort_value,lv_sort,lv_rank_num, lv_datatype
long lv_total_count
singlelineedit sle
Long	ll_currow								// FDG 04/19/99
string lv_sparse,lv_rc, ls_delind, lv_sort_name2
datawindowchild ldwc_uo_columns
int li_rowcount, li_rowcount2, li_ctr, li_ctr2, li_delcount

dw_rank_num.AcceptText()

dw_sort.getchild( "sort_name",ldwc_uo_columns)
ldwc_uo_columns.setfilter( "")
ldwc_uo_columns.filter( )
li_rowcount = dw_sort.rowcount()
lv_total_count = in_datawindow_name.rowcount()

dw_sort.getchild( "sort_name", ldwc_uo_columns)

If IsNull(dw_rank_num.object.rank_num [1]) then		//MVR 3.6 01/13/98
	dw_rank_num.object.rank_num [1] = ''				//MVR 3.6 01/13/98
End if															//MVR 3.6 01/13/98

//This loops through the datawindow  and builds the sort string
//for the setsort
in_datawindow_name.setredraw(FALSE) 
for lv_row = 1 to li_rowcount	
	lv_sort_name = dw_sort.GetItemString(lv_row,"sort_name")
	
	//	Bypass blank row
	IF IsNull( lv_sort_name ) OR Trim( lv_sort_name ) = "" THEN Continue
	lv_order = dw_sort.getitemstring(lv_row,"sort_order")
	ll_currow = ldwc_uo_columns.Find("col_name = '" + lv_sort_name + "'",0,ldwc_uo_columns.rowcount())
	lv_sort_value = ldwc_uo_columns.getitemstring( ll_currow, "db_col") 
	lv_datatype = ldwc_uo_columns.getitemstring( ll_currow, "datatype") 
	if lv_row = 1 and dw_rank_num.object.rank_num [1] <> '' Then
		if rb_top.checked  AND (UPPER(lv_datatype)= 'NUMBER' OR MATCH(UPPER(lv_datatype),'DECIMAL')) then 
			lv_order = 'D'
		elseif rb_bot.checked  AND (UPPER(lv_datatype)= 'NUMBER' OR MATCH(UPPER(lv_datatype),'DECIMAL')) Then
			lv_order = 'A'
		elseif rb_top.checked  AND (MATCH(UPPER(lv_datatype),'CHAR') OR UPPER(lv_datatype)= 'DATETIME') then 
			lv_order = 'A'
		elseif rb_bot.checked AND (MATCH(UPPER(lv_datatype),'CHAR') OR UPPER(lv_datatype)= 'DATETIME') Then
			lv_order = 'D'
		end if
		//This is the var Name for the first sort//
		lv_first_sort_value = lv_sort_value
	else 
		lv_order = dw_sort.getitemstring(lv_row,2)
	end if

	lv_sort = lv_sort+' '+lv_sort_value+' '+lv_order + ','
	//HRB 12/14/95 - Suppress Repeating Values
	if cbx_suppress.checked and dw_rank_num.object.rank_num [1] = '' then  
		lv_sparse = lv_sparse + '~t' + lv_sort_value
	end if
next

IF Trim( lv_sort ) = "" THEN
	MessageBox( "Sort", "Please select at least one column to sort." )
	Return
END IF

lv_sort = left(trim(lv_sort),Len(trim(lv_sort)) - 1)
//HRB 12/14/95 - Suppress Repeating Values
if cbx_suppress.checked and dw_rank_num.object.rank_num [1] = '' then
	lv_sparse = mid(lv_sparse,2)
end if
lv_rank_num = dw_rank_num.object.rank_num [1]

//MVR 12/05/97
If IsNull(lv_rank_num) then
	lv_rank_num = ""
end if

if right(lv_rank_num,1) = '%' Then
	lv_position = pos(lv_rank_num,'%')
	lv_rank_num = left(lv_rank_num,lv_position -1)
	if long(lv_rank_num) > 100 then 
		Messagebox('ERROR','A percentage cannot be higher then 100')
		return
	end if
	if isnumber(lv_rank_num) Then
		lv_rank_num = string((integer(lv_rank_num)/100) * lv_total_count)
		if (real(lv_rank_num) > 0) and (real(lv_rank_num) < .5) Then
			lv_rank_num = '1'
		end if
		lv_rank_num = string(round(real(lv_rank_num),0))
	end if
end if
if lv_rank_num = '' Then 
	lv_rank_num = string(lv_total_count)
//	in_datawindow_name.Setfilter('')
end If

if isnumber(lv_rank_num) = FALSE Then
	Messagebox('ERROR','The rank number has to be a number')
	return
end if
if long(lv_rank_num) <= 0 Then				// FNC 05/05/99
	Messagebox('ERROR','The rank number cannot be less then or equal to zero')
	return
end if
if integer(lv_rank_num) > lv_total_count Then
	//ALABAMA PART A TRIP 2 Changed the message
	Messagebox('WARNING','The number of records retrieved is less then the requested amount')
	lv_rank_num = string(lv_total_count)
end if

in_datawindow_name.SetSort(lv_sort)
in_datawindow_name.Sort()
in_datawindow_name.Setfilter("rowcount() = "+lv_rank_num)


in_datawindow_name.setrow(1)
in_datawindow_name.scrolltorow(1)
in_datawindow_name.triggerevent(rowfocuschanged!)

in_datawindow_name.filter()
//HRB 12/14/95 - Suppress Repeating Values
lv_rc = in_datawindow_name.modify("datawindow.sparse = ''")	//clear all other suppressions - prob 91 HRB 2/5/95
if cbx_suppress.checked and dw_rank_num.object.rank_num [1] = '' then
	lv_rc = in_datawindow_name.modify("datawindow.sparse = '"+lv_sparse+"'")	
end if
in_datawindow_name.setredraw(TRUE)

if dw_rank_num.object.rank_num [1] <> '' then
	call u_sort_dw `cb_sort::clicked
end if

cb_sort.enabled = FALSE
cbx_suppress.enabled = FALSE

if in_count_object.typeof() = singlelineedit! Then
	lv_total_count = in_datawindow_name.rowcount()
	sle = in_count_object
	sle.text = string(lv_total_count)
end if
end event

type dw_sort from u_sort_dw`dw_sort within u_sort_rank
integer y = 208
integer height = 352
integer taborder = 50
end type

type gb_1 from u_sort_dw`gb_1 within u_sort_rank
integer x = 23
integer width = 1938
integer height = 584
integer taborder = 0
end type

type rb_top from radiobutton within u_sort_rank
string accessiblename = "Top"
string accessibledescription = "Top"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 361
integer y = 68
integer width = 247
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "T&op"
boolean checked = true
boolean automatic = false
end type

event getfocus;//*********************************************************************************
// Script Name:	rb_top.getfocus
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Enable the sort button and supress checkbox when rank number changed.
//
//*********************************************************************************
//
//
//*********************************************************************************
if rb_top.checked = FALSE AND iv_rows_exist = TRUE Then
	cb_sort.enabled = TRUE
	cbx_suppress.enabled = TRUE
end if
end event

event clicked;//*********************************************************************************
// Script Name:	rb_bot.getfocus
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Handle radio button functionality and set Sort to enabled if rows are in datawindow.
//
//*********************************************************************************
//
//	05/07/09	Katie	GNL.600.5633	Initial Creation.
//
//*********************************************************************************

this.checked = true
parent.rb_bot.checked = false
if iv_rows_exist then
	parent.cb_sort.enabled = true
end if
end event

type rb_bot from radiobutton within u_sort_rank
string accessiblename = "Bottom"
string accessibledescription = "Bot"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 631
integer y = 68
integer width = 238
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "&Bot"
boolean automatic = false
end type

event getfocus;//*********************************************************************************
// Script Name:	rb_bot.getfocus
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Enable the sort button and supress checkbox when rank number changed.
//
//*********************************************************************************
//
//
//*********************************************************************************

if rb_bot.checked = FALSE AND iv_rows_exist = TRUE Then
	cb_sort.enabled = TRUE
	cbx_suppress.enabled = TRUE
end if
end event

event clicked;//*********************************************************************************
// Script Name:	rb_bot.getfocus
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Handle radio button functionality and set Sort to enabled if rows are in datawindow.
//
//*********************************************************************************
//
//	05/07/09	Katie	GNL.600.5633	Initial Creation.
//
//*********************************************************************************

this.checked = true
parent.rb_top.checked = false
if iv_rows_exist then
	parent.cb_sort.enabled = true
end if
end event

type st_1 from statictext within u_sort_rank
string accessiblename = "Rank"
string accessibledescription = "Rank"
accessiblerole accessiblerole = statictextrole!
integer x = 41
integer y = 88
integer width = 242
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Rank:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_rank_num from u_dw within u_sort_rank
event ue_changed pbm_enchange
string accessiblename = "Top or Bottom Rank Number"
string accessibledescription = "Top or Bottom Rank Number"
integer x = 873
integer y = 68
integer width = 279
integer height = 96
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_rank_num"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event ue_dwnkey;call super::ue_dwnkey;//*********************************************************************************
// Script Name:	dw_rank_num.ue_dwnkey
//
// Arguments:	keycode			key
//					unsignedlong	keyflags
//
// Returns:		long
//
// Description:	Enable buttons.
//
//*********************************************************************************
//
//	11/20/97	FDG 	Stars 3.6
//
//*********************************************************************************

IF	iv_rows_exist		THEN
	cb_sort.enabled		=	TRUE
	cbx_suppress.enabled	=	TRUE
END IF

end event

event ue_dwnprocessenter;call super::ue_dwnprocessenter;//*********************************************************************************
// Script Name:	dw_rank_num.ue_dwnprocessenter
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Enable buttons.
//
//*********************************************************************************
//
//	11/20/97	FDG 	Stars 3.6
//
//*********************************************************************************

IF	iv_rows_exist		THEN
	cb_sort.enabled		=	TRUE
	cbx_suppress.enabled	=	TRUE
END IF

end event

event editchanged;call super::editchanged;//*********************************************************************************
// Script Name:	dw_rank_num.editchanged
//
// Arguments:	long		row
//					dwobject	dwo
//					string		data
//
// Returns:		long
//
// Description:	Enable the sort button and supress checkbox when rank number changed.
//
//*********************************************************************************
//
//	11/20/97	FDG 	Stars 3.6
//
//*********************************************************************************

IF	iv_rows_exist		THEN
	cb_sort.enabled		=	TRUE
	cbx_suppress.enabled	=	TRUE
END IF

end event

event itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	dw_rank_num.itemchanged
//
// Arguments:	long		row
//					dwobject	dwo
//					string		data
//
// Returns:		long
//
// Description:	Enable the sort button and supress checkbox when rank number changed.
//
//*********************************************************************************
//
//	11/20/97	FDG 	Stars 3.6
//
//*********************************************************************************

IF	iv_rows_exist		THEN
	cb_sort.enabled		=	TRUE
	cbx_suppress.enabled	=	TRUE
END IF

end event

