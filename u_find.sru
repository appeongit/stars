HA$PBExportHeader$u_find.sru
$PBExportComments$Inherited from u_base <gui>
forward
global type u_find from u_base
end type
type cb_continue from u_cb within u_find
end type
type cb_search from u_cb within u_find
end type
type dw_find from u_dw within u_find
end type
type cb_clear from u_cb within u_find
end type
end forward

global type u_find from u_base
string accessiblename = "Find"
string accessibledescription = "Find"
integer width = 2263
integer height = 396
boolean border = false
long picturemaskcolor = 25166016
cb_continue cb_continue
cb_search cb_search
dw_find dw_find
cb_clear cb_clear
end type
global u_find u_find

type variables
long iv_row, iv_row_count
private u_dw iv_dw_name
private string iv_col_name
private string iv_data_type
private string iv_value
end variables

forward prototypes
public subroutine fuo_set_dw (ref w_uo_win arg_uo_win, u_dw arg_dw)
public subroutine fuo_set_value (string arg_value)
public subroutine fuo_set_col_name (string as_col_title, string arg_col_name, boolean arg_join, string arg_data_type)
public function long fuo_populatecolumns (ref u_dw audw_requestor)
end prototypes

public subroutine fuo_set_dw (ref w_uo_win arg_uo_win, u_dw arg_dw);//******************************************************
//	Script:	u_find.fuo_set_dw
//
//	Arguments:	1. arg_uo_win (type w_uo_win)
//					2.	arg_dw (type u_dw)
//
//	Returns		N/A
//
//	Description:
//			Save the datawindow passed to this function
//			for future use.
//******************************************************

iv_dw_name = arg_dw
end subroutine

public subroutine fuo_set_value (string arg_value);//******************************************************
//	Script:	u_find.fuo_set_value
//
//	Arguments:	1. arg_value (type string)
//
//	Returns		N/A
//
//	Description:
//			If a value is passed to this function, place it
//			in sle_value.text
//******************************************************
//
//	KMM   7/17/95	Prob#604 Added to plug cell value if user 
//				    	clicks on cell
// AJS   07/24/98 Stars 4.0 - Track #1455
//                change u_find to use external datasource
// Jason 09/26/02 Track 3309d  enable value to be set to ''
//	GaryR	06/10/05	Track 3309d	Address issues with resetting options on new column/value.
//	GaryR	08/30/05	Track 4495d	Compare codes only if decoded
//******************************************************

n_cst_decode lnv_decode
IF lnv_decode.of_is_decoded( iv_dw_name, iv_col_name ) THEN
	lnv_decode.of_remove_desc( arg_value )
END IF

dw_find.Object.value[1] = arg_value
end subroutine

public subroutine fuo_set_col_name (string as_col_title, string arg_col_name, boolean arg_join, string arg_data_type);//******************************************************
//	Script:	u_find.fuo_set_col_name
//
//	Arguments:	1. as_col_title (type string)
//					2.	arg_col_name (type string)
//					3.	arg_join (type boolean)
//					4. arg_data_type (type string)
//
//	Returns		N/A
//
//	Description:
//			Get the column header name from the datawindow
//			and place it in st_column.text
//******************************************************
//
//	FDG	12/8/97	Stars 3.6 - When removing ~r and ~n,
//						must edit for the header having both.
// AJS   07/24/98 Stars 4.0 - Track #1455
//                change u_find to use external datasource
//	GaryR	01/13/03	Track 2868d	Fix logic for duplicate column names
//	GaryR	06/10/05	Track 3309d	Address issues with resetting options on new column/value.
//
//******************************************************

long lv_len
int lv_pos_r, lv_pos_n, lv_pos
string lv_temp, lv_last_two

iv_col_name = arg_col_name
iv_data_type = arg_data_type
lv_pos = pos(arg_data_type,'(')
if lv_pos > 0 then
	iv_data_type = left(iv_data_type,lv_pos - 1)
end if

lv_temp = as_col_title

//This removes the ~r and ~n from the sort name
lv_pos_r	=	pos(lv_temp,"~r")
lv_pos_n	=	pos(lv_temp,"~n")

//	FDG 12/8/97 - Edit for the text to have both ~r and ~n.
IF	lv_pos_r		>	0		&
AND lv_pos_n	>	0		THEN
	lv_temp	=	Left (lv_temp,lv_pos_r - 1) + " " + Mid (lv_temp,lv_pos_r + 2)
ELSEIF (lv_pos_r > 1) 	THEN
	lv_temp	=	Left (lv_temp,lv_pos_r - 1) + " " + Mid (lv_temp,lv_pos_r + 1)
ELSEIF (lv_pos_n > 1) 	THEN
	lv_temp	=	Left (lv_temp,lv_pos_n - 1) + " " + Mid (lv_temp,lv_pos_n + 1)
END IF

This.cb_clear.event clicked( )
dw_find.Object.col_name[1] = lv_temp 			// AJS   07/24/98 4.0

//setfocus(sle_value)								// AJS   07/24/98 4.0
setfocus(dw_find)										// AJS   07/24/98 4.0
dw_find.setcolumn('value')							// AJS   07/24/98 4.0
end subroutine

public function long fuo_populatecolumns (ref u_dw audw_requestor);//*********************************************************************************
// Script Name:	u_find.fuo_populatecolumns
//
// Arguments:	u_dw	ref	audw_requestor
//
// Returns:		long
//
// Description:	Populate the col_name drop down in dw_decode.
//
//*********************************************************************************
//
// 04/12/09 Katie	GNL.600.5633 Initial Creation.
//	05/05/09	Katie	GNL.600.5633	Adjust logic to handle duplicate headers.
//	05/05/09	Katie	GNL.600.5633	Added isvalid check before processing columns.
//	05/12/09	Katie	GNL.600.5633	Add logic to ensure columns are visible before adding them to the 
//											drop-down.
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
//	07/30/09	GaryR	WIN.650.5721.006	Check visible property for formula
//
//*********************************************************************************

int li_col_num = 0, li_index
long ll_row, ll_width, ll_visible
string ls_col_name, ls_col_label, ls_data_type, ls_lookup, ls_dbname, &
			ls_hdr_name, ls_visible
datawindowchild ldwc_uo_columns
n_cst_string	lnv_string

if not IsValid(audw_requestor) then return -1

dw_find.GetChild( "col_name", ldwc_uo_columns )
iv_dw_name = audw_requestor

ldwc_uo_columns.reset( )

li_col_num =  long(audw_requestor.Describe('datawindow.column.count'))

FOR li_index = 1 TO li_col_num
	ls_dbname 		=	String(audw_requestor.Describe('#'+string(li_index)+'.dbname'))
	ls_col_name = String(audw_requestor.Describe ('#'+string(li_index)+'.name'))
	if (upper(ls_dbname) <> upper(ls_col_name)) and (match(right(ls_col_name,2), '^_[0-9]$')) then
		ls_hdr_name = Left( ls_col_name, Len( ls_col_name ) - 2 ) + &
				'_t' + right(ls_col_name,2) + '_t'
	else
		ls_hdr_name = ls_col_name + '_t'
	end if
	ls_col_label = String(audw_requestor.Describe(ls_hdr_name+'.text'))
	ls_data_type = String(audw_requestor.Describe ('#'+string(li_index)+'.coltype'))
	ls_visible = audw_requestor.Describe ('#'+string(li_index)+'.visible')
	IF NOT IsNumber( ls_visible ) THEN
		//	Formula, means column is visible
		ll_visible = 1
	ELSE
		ll_visible = Long( ls_visible )
	END IF
	ll_width = Long(audw_requestor.Describe ('#'+string(li_index)+'.width'))
	if ((trim(ls_col_label) <> "!") AND (ll_visible > 0) AND (ll_width > 1)) then
		// Remove special characters
		lnv_string.of_clean_label( ls_col_label )	
		ll_row = ldwc_uo_columns.insertrow( 0)
		ldwc_uo_columns.setitem( ll_row, "col_name", ls_col_label)
		ldwc_uo_columns.setitem( ll_row, "db_col",trim(ls_col_name))
		ldwc_uo_columns.setitem( ll_row, "datatype",trim(ls_data_type))
	end if
NEXT
ldwc_uo_columns.setsort( "col_name")
ldwc_uo_columns.sort( )
ldwc_uo_columns.setrow( 1)

return 1
end function

on u_find.create
int iCurrent
call super::create
this.cb_continue=create cb_continue
this.cb_search=create cb_search
this.dw_find=create dw_find
this.cb_clear=create cb_clear
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_continue
this.Control[iCurrent+2]=this.cb_search
this.Control[iCurrent+3]=this.dw_find
this.Control[iCurrent+4]=this.cb_clear
end on

on u_find.destroy
call super::destroy
destroy(this.cb_continue)
destroy(this.cb_search)
destroy(this.dw_find)
destroy(this.cb_clear)
end on

type cb_continue from u_cb within u_find
string accessiblename = "Continue"
string accessibledescription = "Continue"
integer x = 1947
integer y = 172
integer width = 293
integer height = 104
integer taborder = 40
boolean enabled = false
string text = "C&ontinue"
end type

event clicked;//******************************************************
//	Script:	cb_continue.clicked
//
//	Description:
//		Continue the search for the value entered in
//		sle_value.text.  It will continue to search
//		forward or backward depending on which radiobutton
//		was clicked.
//******************************************************
// AJS   07/24/98 Stars 4.0 - Track #1455
//                change u_find to use external datasource
//	FDG	01/20/99	Track 2058c.  Use 4 digit year.
// AJS   02/08/99 track 1709d. allow to search for spaces.
//	FDG	12/14/00	Stars 4.7.  Include data types from all DBMSs
//	GaryR	01/13/03	Track 2868d	Fix logic for duplicate column names
//	GaryR	08/30/05	Track 4495d	Compare codes only if decoded
//	GaryR	08/14/06	Track 4731	Trim the trailing spaces from string values
//******************************************************

string lv_string
date lv_date
string lv_search_date, lv_dwfind
string ls_value
long ll_rowcount
long ll_row
long lv_current_row
Boolean	lb_decoded
n_cst_decode	lnv_decode

//if rb_forward.checked = true then		//ajs 07-24-98 4.0
if dw_find.Object.rb_direction[1] = 1 then
	if iv_row > iv_row_count then
		cb_continue.enabled = false
		cb_search.enabled = True
//ajs 07-24-98 4.0
		Messagebox('INFORMATION','No row found for the search value ' + iv_value)				//ajs 07-24-98 4.0
		dw_find.Object.value[1] = ''
		return
	else	
		cb_continue.enabled = True
	end if
else
	if iv_row < 1 then
		cb_continue.enabled = false
		cb_search.enabled = True
//ajs 07-24-98 4.0
		Messagebox('INFORMATION','No row found for the search value ' + iv_value)				//ajs 07-24-98 4.0
		dw_find.Object.value[1] = ''
		return
	else	
		cb_continue.enabled = True
	end if
end if

lb_decoded = lnv_decode.of_is_decoded( iv_dw_name, iv_col_name )

ll_row = iv_dw_name.GetRow()
// JOHN_WO 9/22/97 FIX FOR 3.5.4- ADDED CHECK FOR LONG
//if rb_forward.checked = true then		//ajs 07-24-98 4.0
if dw_find.Object.rb_direction[1] = 1 then
	// FDG 12/14/00 - Include data types from all DBMSs
	//if upper(iv_data_type) = 'CHAR' then
	IF	gnv_sql.of_is_character_data_type (iv_data_type)	THEN
		ll_rowcount	=	iv_dw_name.RowCount()
		//AJS 02/08/99 start
		if Upper(iv_value) = 'BLANKS' then
			FOR ll_row	=	iv_row TO ll_rowcount
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF	IsNull(ls_value) or trim(ls_value)	=	''		THEN
					iv_row	=	ll_row
					Exit
				END IF
				iv_row = 0
			NEXT
		else
			FOR ll_row	=	iv_row TO ll_rowcount
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF lb_decoded THEN lnv_decode.of_remove_desc( ls_value )
				// Trim the trailing spaces from value
				IF	Upper( RightTrim( ls_value ) )	=	Upper (iv_value)		THEN
					iv_row	=	ll_row
					Exit
				END IF
				iv_row = 0
			NEXT
	   end if
	//AJS 02/08/99 end	
	// FDG 12/14/00 - Include data types from all DBMSs
	elseif gnv_sql.of_is_numeric_data_type (iv_data_type)	THEN
		if ISNUMBER(iv_value) then
			lv_string = iv_col_name + " = " + iv_value
			iv_row = iv_dw_name.Find(iv_col_name + " = " + iv_value,iv_row,iv_row_count)
		else
			messagebox('VALIDATION','Value entered needs to be a valid number')
			return
		end if
	// FDG 12/14/00 - Include data types from all DBMSs
	elseif gnv_sql.of_is_date_data_type (iv_data_type)	THEN
		if ISDATE(iv_value) then
			lv_date = date(iv_value)
			// FDG 01/20/99 begin
			lv_search_date = string(lv_date,'mm/dd/yyyy')
			lv_dwfind = "string("+iv_col_name+",~"mm/dd/yyyy~") = "+"~""+lv_search_date+"~""
			// FDG 01/20/99 begin
			iv_row = iv_dw_name.Find(lv_dwfind,iv_row,iv_row_count)
		else
			messagebox('VALIDATION','Value entered needs to be a valid date')
			return
		end if
	else 
		messagebox('ERROR','Error obtaining data type')
		return
	end if	
	if iv_row > 0 then
		//Row found, scroll to it and make it current
		iv_dw_name.SelectRow(0,FALSE)
		iv_dw_name.ScrollToRow(iv_row)
		iv_dw_name.SelectRow(iv_row,TRUE)
//		iv_row = iv_row + 1
	else
		//ajs 07-24-98 4.0
		Messagebox('INFORMATION','No more rows found for the search value ' + iv_value)					//ajs 07-24-98 4.0
		dw_find.Object.value[1] = ''																				//ajs 07-24-98 4.0
		cb_continue.enabled = false
		cb_search.enabled = True
		return
	end if
else
	// JOHN_WO 9/22/97 FIX FOR 3.5.4- ADDED CHECK FOR LONG
	// FDG 12/14/00 - Include data types from all DBMSs
	if gnv_sql.of_is_character_data_type (iv_data_type)	THEN
		//AJS 02/08/99 start
		lv_current_row = iv_row
		if Upper(iv_value) = 'BLANKS' then
			FOR ll_row	=	lv_current_row TO 1 step -1 
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF	IsNull(ls_value) or trim(ls_value)	=	''		THEN
					iv_row	=	ll_row
					Exit
				END IF
				iv_row = 0
			NEXT
		else
			FOR ll_row	=	lv_current_row TO 1 step -1
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF lb_decoded THEN lnv_decode.of_remove_desc( ls_value )
				// Trim the trailing spaces from value
				IF	Upper( RightTrim( ls_value ))	=	Upper (iv_value)		THEN
					iv_row	=	ll_row
					Exit
				END IF
				iv_row = 0
			NEXT
	   end if
		//AJS 02/08/99 end
	// FDG 12/14/00 - Include data types from all DBMSs
	elseif gnv_sql.of_is_numeric_data_type (iv_data_type)	THEN
		if ISNUMBER(iv_value) then
			lv_string = iv_col_name + " = " + iv_value
			iv_row = iv_dw_name.Find(iv_col_name + " = " + iv_value,iv_row,1)
		else
			messagebox('VALIDATION','Value entered needs to be a valid number')
			return
		end if
	// FDG 12/14/00 - Include data types from all DBMSs
	elseif gnv_sql.of_is_date_data_type (iv_data_type)	THEN
		if ISDATE(iv_value) then
			lv_date = date(iv_value)
			// FDG 01/20/99 begin
			lv_search_date = string(lv_date,'mm/dd/yyyy')
			lv_dwfind = "string("+iv_col_name+",~"mm/dd/yyyy~") = "+"~""+lv_search_date+"~""
			// FDG 01/20/99 end
			iv_row = iv_dw_name.Find(lv_dwfind,iv_row,1)
		else
			messagebox('VALIDATION','Value entered needs to be a valid date')
			return
		end if
	else 
		messagebox('ERROR','Error obtaining data type')
		return
	end if	
	if iv_row > 0 then
		//Row found, scroll to it and make it current
		iv_dw_name.SelectRow(0,FALSE)
		iv_dw_name.ScrollToRow(iv_row)
		iv_dw_name.SelectRow(iv_row,TRUE)
	else
		//ajs 07-24-98 4.0
		Messagebox('INFORMATION','No more rows found for the search value ' + iv_value)					//ajs 07-24-98 4.0
		dw_find.Object.value[1] = ''	
		cb_continue.enabled = false
		cb_search.enabled = True
		return
	end if
end if

//if rb_forward.checked = true then			//ajs 07-24-98 4.0
if dw_find.Object.rb_direction[1] = 1 then
	iv_row = iv_row + 1
	if iv_row > iv_row_count then
//		cb_continue.enabled = false
		return
	else	
		cb_continue.enabled = True
		cb_search.enabled = False
		cb_continue.setfocus()
	end if
else
	iv_row = iv_row - 1
	if iv_row < 1 then
//		cb_continue.enabled = false
		return
	else	
		cb_continue.enabled = True
		cb_search.enabled = False
		cb_continue.setfocus()
	end if
end if
end event

type cb_search from u_cb within u_find
string accessiblename = "Search"
string accessibledescription = "Search"
integer x = 1943
integer y = 48
integer width = 293
integer height = 104
integer taborder = 30
string text = "&Search"
boolean default = true
end type

event clicked;//**************************************************************************
//	Script:	cb_search.clicked
//
//	Description:
//		Search the datawindow for the value entered in
//		sle_value.text.  The search will occur either
//		forward or backward depending on which radiobutton
//		was clicked.
//**************************************************************************
// AJS   07/24/98 Stars 4.0 - Track #1455
//                Change u_find to use external datasource
//	FDG	11/04/98	Stars 4.0 - Track 1568
//						When performing a find, do not be case-sensitive.
//	FDG	01/20/99	Track 2058c.  Use 4 digit year.
// AJS   02/08/99 track 1709d. allow to search for spaces.
//	FDG	12/14/00	Stars 4.7.  Include data types from all DBMSs
//	GaryR	01/13/03	Track 2868d	Fix logic for duplicate column names
//	GaryR	08/30/05	Track 4495d	Compare codes only if decoded
//	GaryR	08/14/06	Track 4731	Trim the trailing spaces from string values
//	Katie	04/13/09	GNL.600.5633
//**************************************************************************

string lv_string,	ls_value
date lv_date
string lv_search_date, lv_dwfind
long ll_curr_row,	ll_row,	ll_rowcount
Boolean	lb_decoded
n_cst_decode	lnv_decode

if dw_find.Object.col_name[1] = '' then
	Messagebox('INFORMATION','Please double click a column to search.')	
	Return
end if

iv_value = trim(dw_find.Object.Value[1])
if iv_value = '' then
	Messagebox('INFORMATION','Please enter a search value.')
	SetFocus(dw_find)
	dw_find.SetColumn('value')
	Return
end if

lb_decoded = lnv_decode.of_is_decoded( iv_dw_name, iv_col_name )

iv_row_count = iv_dw_name.rowcount()
ll_curr_row = iv_dw_name.GetRow()
if dw_find.Object.rb_direction[1] = 1 then
	if gnv_sql.of_is_character_data_type (iv_data_type)	then
		iv_row		=	0
		ll_rowcount	=	iv_dw_name.RowCount()
		if Upper(iv_value) = 'BLANKS' then
				FOR ll_row	=	1 TO ll_rowcount
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF	IsNull(ls_value) or trim(ls_value)	=	''		THEN
					iv_row	=	ll_row
					Exit
				END IF
			NEXT
		else
			FOR ll_row	=	1 TO ll_rowcount
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF lb_decoded THEN lnv_decode.of_remove_desc( ls_value )
				// Trim the trailing spaces from value
				IF	Upper( RightTrim( ls_value ))	=	Upper (iv_value)		THEN
					iv_row	=	ll_row
					Exit
				END IF
			NEXT
	   end if
	
	elseif gnv_sql.of_is_numeric_data_type (iv_data_type)	then
		if ISNUMBER(iv_value) then
			lv_string = iv_col_name + " = " + iv_value
			iv_row = iv_dw_name.Find(iv_col_name + " = " + iv_value,iv_row,iv_row_count)
		else
			messagebox('VALIDATION','Value entered needs to be a valid number')
			return
		end if
	elseif gnv_sql.of_is_date_data_type (iv_data_type)	then
		if ISDATE(iv_value) then
			lv_date = date(iv_value)
			lv_search_date = string(lv_date,'mm/dd/yyyy')
			lv_dwfind = "string("+iv_col_name+",~"mm/dd/yyyy~") = "+"~""+lv_search_date+"~""
			iv_row = iv_dw_name.Find(lv_dwfind,iv_row,iv_row_count)
		else
			messagebox('VALIDATION','Value entered needs to be a valid date')
			return
		end if
	else 
		messagebox('ERROR','Error obtaining data type')
		return
	end if	
	if iv_row > 0 then
		//Row found, scroll to it and make it current
		iv_dw_name.SelectRow(0,FALSE)
		iv_dw_name.ScrollToRow(iv_row)
		iv_dw_name.SelectRow(iv_row,TRUE)
	else
		Messagebox('INFORMATION','No row found based on search value ' + iv_value)
		dw_find.Object.value[1] = ''
		Return
	end if
else
	if gnv_sql.of_is_character_data_type (iv_data_type)	then
		iv_row		=	iv_dw_name.RowCount()
		ll_rowcount	=	iv_dw_name.RowCount()
		if Upper(iv_value) = 'BLANKS' then
				FOR ll_row	=	ll_rowcount TO 1 step -1 
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF	IsNull(ls_value) or trim(ls_value)	=	''		THEN
					iv_row	=	ll_row
					Exit
				END IF
			NEXT
		else
			FOR ll_row	=	ll_rowcount TO 1 step -1
				ls_value	=	iv_dw_name.GetItemString (ll_row, iv_col_name)
				IF lb_decoded THEN lnv_decode.of_remove_desc( ls_value )
				// Trim the trailing spaces from value
				IF	Upper( RightTrim( ls_value ))	=	Upper (iv_value)		THEN
					iv_row	=	ll_row
					Exit
				END IF
			NEXT
	   end if
	elseif gnv_sql.of_is_numeric_data_type (iv_data_type)	then
		if ISNUMBER(iv_value) then
			lv_string = iv_col_name + " = " + iv_value
			iv_row = iv_dw_name.Find(iv_col_name + " = " + iv_value,iv_row,1)
		else
			messagebox('VALIDATION','Value entered needs to be a valid number')
			return
		end if
	elseif gnv_sql.of_is_date_data_type (iv_data_type)	then
		if ISDATE(iv_value) then
			lv_date = date(iv_value)
			lv_search_date = string(lv_date,'mm/dd/yyyy')
			lv_dwfind = "string("+iv_col_name+",~"mm/dd/yyyy~") = "+"~""+lv_search_date+"~""
			iv_row = iv_dw_name.Find(lv_dwfind,iv_row,1)
		else
			messagebox('VALIDATION','Value entered needs to be a valid date')
			return
		end if
	else 
		messagebox('ERROR','Error obtaining data type')
		return
	end if	
	if iv_row > 0 then
		//Row found, scroll to it and make it current
		iv_dw_name.SelectRow(0,FALSE)
		iv_dw_name.ScrollToRow(iv_row)
		iv_dw_name.SelectRow(iv_row,TRUE)
	else
		Messagebox('INFORMATION','No row found based on search value ' + iv_value)	
		dw_find.Object.value[1] = ''
	end if
end if

if dw_find.Object.rb_direction[1] = 1 then
	iv_row = iv_row + 1
	if iv_row > iv_row_count then
		cb_continue.enabled = false
		return
	else	
		cb_continue.enabled = True
		cb_search.enabled = False
		cb_continue.setfocus()
	end if
else
	iv_row = iv_row - 1
	if iv_row < 1 then
		cb_continue.enabled = false
		return
	else	
		cb_continue.enabled = True
		cb_search.enabled = False
		cb_continue.setfocus()
	end if
end if
end event

type dw_find from u_dw within u_find
string accessiblename = "Find Data Window"
string accessibledescription = "Find Data Window"
integer x = 9
integer y = 12
integer width = 1911
integer taborder = 20
string dataobject = "d_find"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//*********************************************************************************
// Script Name:	constructor
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Constructor for the find datawindow.  Initializes the datawindow.
//
//*********************************************************************************
//
//	Katie	04/12/09	GNL.600.5633	Remove protection on col_name.
//
//*********************************************************************************
This.SetTransObject (Stars2ca) 
This.of_setupdateable(false)
dw_find.reset()
dw_find.insertrow(0)
dw_find.Object.rb_direction[1] = 1

end event

event losefocus;call super::losefocus;//*********************************************************************************
// Script Name:	losefocus
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Accept the text for find datawindow.
//
//*********************************************************************************
//
//
//*********************************************************************************
dw_find.accepttext()
end event

event itemchanged;call super::itemchanged;//*********************************************************************************
// Script Name:	itemchanged
//
// Arguments:	long	row
//					dwobject dwo
//					string	data
//
// Returns:		long
//
// Description:	Enables/disables and sets values for items appropriately as the
//
//*********************************************************************************
//
//	Katie	04/12/09	GNL.600.5633	Set instance values when new column selected from col_name drop down.
//	Katie	04/30/09	GNL.600.5633	Removed logic that set focus on the value column after the col_name column changed.
//
//*********************************************************************************
datawindowchild ldwc_uo_columns
String ls_value, lv_temp
Integer li_direction, li_rownum

If  this.getcolumnname() = 'value' then
	ls_value = string(data)	
	if ls_value <> iv_value	then
		cb_search.enabled = True
		cb_continue.enabled = False
		cb_search.setfocus()
	end if
elseif this.getcolumnname() = 'col_name' then
	lv_temp = string(data)	
	dw_find.getchild( "col_name", ldwc_uo_columns)
	li_rownum = ldwc_uo_columns.find( "col_name = '" + lv_temp + "'", 0, ldwc_uo_columns.rowcount())
	iv_data_type = UPPER(ldwc_uo_columns.getitemstring(li_rownum, "datatype"))
	iv_col_name = ldwc_uo_columns.getitemstring(li_rownum, "db_col")

	parent.cb_clear.event clicked( )
 	dw_find.Object.col_name[1] = lv_temp
	
	setfocus(dw_find)
End If

If this.getcolumnname() = 'rb_direction' then
	li_direction = integer(data)
else
	li_direction = dw_find.Object.rb_direction[1]
End If

	iv_row = iv_dw_name.getrow()
	iv_row_count = iv_dw_name.rowcount()
	if li_direction = 1 then
		if iv_row = 1 then
			//process first row
		else 
			iv_row = iv_row + 1
		end if
	else
		if iv_row = 1 or iv_row = 0 then
			//start by processing last row
			iv_row = iv_row_count
		else
			iv_row = iv_row - 1
		end if	
	end if

		
end event

type cb_clear from u_cb within u_find
boolean visible = false
string accessiblename = "clear"
string accessibledescription = "clear"
integer x = 1998
integer y = 296
integer width = 215
integer height = 88
integer taborder = 10
string text = "clear"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_clear.clicked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Re-initialize the datawindow.
//
//*********************************************************************************
//
// JasonS 09/20/02 Track 3309d  Continue shouldn't be an option after clearing
//	Katie	04/12/09	GNL.600.5633	Remove protection on col_name.
//
//*********************************************************************************
dw_find.reset()
dw_find.insertrow(0)
dw_find.Object.rb_direction[1] = 1
cb_search.enabled = true
cb_continue.enabled = false
end event

