$PBExportHeader$w_code_lookup.srw
$PBExportComments$Inherited from w_master
forward
global type w_code_lookup from w_master
end type
type st_1 from statictext within w_code_lookup
end type
type rb_code_id from radiobutton within w_code_lookup
end type
type cb_filter from u_cb within w_code_lookup
end type
type cb_print from u_cb within w_code_lookup
end type
type st_row_count from statictext within w_code_lookup
end type
type ddlb_type from dropdownlistbox within w_code_lookup
end type
type dw_1 from u_dw within w_code_lookup
end type
type mle_code_description from multilineedit within w_code_lookup
end type
type sle_text from singlelineedit within w_code_lookup
end type
type sle_id from singlelineedit within w_code_lookup
end type
type st_range from statictext within w_code_lookup
end type
type st_code_id from statictext within w_code_lookup
end type
type st_type from statictext within w_code_lookup
end type
type cb_list from u_cb within w_code_lookup
end type
type cb_use from u_cb within w_code_lookup
end type
type cb_exit from u_cb within w_code_lookup
end type
type gb_1 from groupbox within w_code_lookup
end type
type rb_code_description from radiobutton within w_code_lookup
end type
end forward

global type w_code_lookup from w_master
string accessiblename = "Code Lookup"
string accessibledescription = "Code Lookup"
integer x = 233
integer y = 64
integer width = 2875
integer height = 2012
string title = "Code Lookup"
windowtype windowtype = response!
st_1 st_1
rb_code_id rb_code_id
cb_filter cb_filter
cb_print cb_print
st_row_count st_row_count
ddlb_type ddlb_type
dw_1 dw_1
mle_code_description mle_code_description
sle_text sle_text
sle_id sle_id
st_range st_range
st_code_id st_code_id
st_type st_type
cb_list cb_list
cb_use cb_use
cb_exit cb_exit
gb_1 gb_1
rb_code_description rb_code_description
end type
global w_code_lookup w_code_lookup

type variables
boolean in_cb_use_clicked
boolean ib_clicked_filter=false
long in_dw_limit
string type_to_use
string iv_code_to_use
string is_from      //10-16-96 FNC
w_uo_win iv_uo_win

//	LKP.650.5678.GARY
Boolean	ib_multi_code
String	is_code_list, is_curr_list


//	LKP.650.5678.001  Rick
Boolean	ib_clicked
end variables

forward prototypes
public subroutine wf_reset_window ()
public function long wf_pat_prov_lookup (string as_code)
public subroutine wf_sort_type_list_by_desc ()
public subroutine wf_sort_type_list_by_code ()
public subroutine wf_build_multi_code ()
end prototypes

public subroutine wf_reset_window ();// wf_reset_window - Reset the microhelp, cursor, and datawindow to its
//							original state

SetMicroHelp (w_main,'Ready')

SetPointer (Arrow!)

dw_1.SetRedraw (TRUE)


end subroutine

public function long wf_pat_prov_lookup (string as_code);/////////////////////////////////////////////////////////////////////////
//
//	02/15/02	GaryR	Track 2710d	Build Patient/Enrollee SQL dynamically
//	04/24/03	GaryR	Track 3537d	Add Stars user lookup
// 10/19/04 MikeF	Track 3650d	Replaced local n_cst_dict with global service
// 09/01/05 MikeF SPR4095d	Hardcoded GetItem commands causing system crashes
// 01/23/07 Katie SPR 4766 Handle NPI Lookup type
// 09/29/09 RickB LKP.650.5678.001 - Turned off the Selected.Mouse property.  If it's on and the user 
// 				exceeds the 255 char limit on multiselect window, the mouse automatically and 
//				erroneously hilites data.
/////////////////////////////////////////////////////////////////////////

Long		ll_rowcount
String	ls_select, ls_from, ls_where, ls_sql
String	ls_id, ls_name, ls_elem_tbl_type
String	ls_style, ls_syntax, ls_error
n_cst_labels	lnvo_labels
n_cst_string	lnv_string

//	Build the where clause
ls_id = 		"'" + sle_id.text		+ "%'"
ls_name = 	"'" + sle_text.text 	+ "%'"

CHOOSE CASE as_code
	CASE "RI"
		ls_elem_tbl_type = "EN"
		ls_select = "SELECT RECIP_ID, PATIENT_NAME, ADDRESS_LINE_1, ADDRESS_LINE_2, " + &
						"CITY, STATE, ZIP"
		ls_from 	= " FROM ENROLLEE"
		ls_where = " WHERE RECIP_ID LIKE " + Upper( ls_id ) + &
					  " AND PATIENT_NAME LIKE " + Upper( ls_name )				  
	CASE "PV"
		ls_elem_tbl_type = "PV"
		ls_select = gnv_dict.event ue_build_dict_sql_select( "PROVIDERS" )
		ls_from 	= " FROM PROVIDERS"
		ls_where = " WHERE PROV_ID LIKE " + Upper( ls_id ) + &
					  " AND PROV_NAME LIKE " + Upper( ls_name )
	CASE "UP"
		ls_elem_tbl_type = "PV"
		ls_select = gnv_dict.event ue_build_dict_sql_select( "PROVIDERS" )
		ls_from 	= " FROM PROVIDERS"
		ls_where = " WHERE PROV_UPIN LIKE " + Upper( ls_id ) + &
					  " AND PROV_NAME LIKE " + Upper( ls_name )
	CASE "NPI"
		ls_elem_tbl_type = "NP"
		ls_select = gnv_dict.event ue_build_dict_sql_select( "PROV_NPI_XREF" )
		ls_from 	= " FROM PROV_NPI_XREF"
		ls_where = " WHERE PROV_NPI LIKE " + Upper( ls_id ) + &
					  " AND PROV_NPI_NAME LIKE " + Upper( ls_name )
					  
	CASE "USERS"
		ls_elem_tbl_type = gnv_dict.event ue_get_inv_type( "USERS" )
		ls_select = " SELECT USER_ID, USER_F_NAME, USER_L_NAME, USER_DEPT"
		ls_from 	= " FROM USERS"
		ls_where = " WHERE USER_ID LIKE " + Upper( ls_id ) + &
					  " AND (USER_F_NAME LIKE " + Upper( ls_name ) + &
					  " OR USER_L_NAME LIKE " + Upper( ls_name ) + ")"				  
	CASE ELSE				  
		MessageBox( 'ERROR', 'Invalid code ' + as_code + " passed to wf_pat_prov_lookup" )
		Return -1
END CHOOSE

IF ls_select = "ERROR" THEN
   MessageBox( 'ERROR', 'Cannot retrieve columns from dictionary where code = ' + as_code )
	Return -1
END IF

ls_sql = ls_select + ls_from + ls_where

//	Limit the retrieval to 2500 rows
IF gnv_sql.of_SetRowLimit( ls_sql, 2500, Stars2ca ) < 1 THEN
	MessageBox( 'Database Error', 'Could not set the row count in sql - ' + ls_sql )
	Return -1
END IF

//	Build the datawindow
ls_style = " datawindow(units = 1 color = " + &
				string(stars_colors.datawindow_back)+ ") style(type = grid) " + &
				"text(font.face='System')  Column(font.Face='System')"

ls_syntax = Stars2ca.SyntaxFromSQL( ls_sql, ls_style, ls_error )

IF ls_syntax = "" THEN
	MessageBox( 'Error', 'Error creating syntax for report. Error = ' +	ls_error )
	gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca )
	Return -1
END IF

IF dw_1.Create( ls_syntax ) = -1 THEN
	MessageBox( 'ERROR', 'Error creating datawindow for report' )
	gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca )
	Return -1
END IF

// Turn off Selected.Mouse property.  If it's on and a user exceeds the 255 char limit on lookups
// while  using the "IN" or "NOT IN", the mouse automatically and erroneously hilites data.
ls_id =dw_1.Modify("DataWindow.Selected.Mouse=No")

//	Customize the layout
IF fx_dw_syntax( is_window_name, dw_1, istr_decode_struct, Stars2ca ) = -1 THEN
	gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca )
	Return -1
END IF

//	Dictionarize the labels
lnvo_labels = Create n_cst_labels
lnvo_labels.of_setdw( dw_1 )
lnvo_labels.of_labels2( ls_elem_tbl_type, '95', '40', '50' )
Destroy( lnvo_labels)

This.Event ue_set_window_colors( This.Control )

dw_1.SetTransObject( Stars2ca )
ll_rowcount = dw_1.Retrieve()

IF gnv_sql.of_SetRowLimit( ls_sql, 0, Stars2ca ) < 1 THEN
	MessageBox( 'Database Error', 'Could not set the row count in sql - ' + ls_sql )
END IF

IF ll_rowcount >= 2500 THEN	MessageBox( "Warning", "The maximum number of rows limit was reached" + &
																	"~n~rMore rows match your query than are displayed", Exclamation! )
Return ll_rowcount
end function

public subroutine wf_sort_type_list_by_desc ();//*********************************************************************************
// Script Name:	wf_sort_type_list_by_desc
//
// Arguments: n/a
//
// Returns:		n/a
//
// Description:	Alter window to search by description.
//
//*********************************************************************************
//
//  09/27/02	MikeF	Track 3130d	Remove all references to 'LK' code types
//	05/27/09	Katie	GNL.600.5633	Handle radio button checking and unchecking.  
//
//*********************************************************************************
string lv_code_code,lv_code_desc
int total, idx

rb_code_id.checked = FALSE
rb_code_description.checked = TRUE

ddlb_type.Reset()

// MikeFl 9/27/02 - Track 3130 - Begin
//declare CODE cursor for
//  select code_code, code_desc
//	 from code 
//	where code_type = 'LK'
//	order by code_desc
//	using stars2ca;

declare CODE cursor for
  select code_code, code_desc
	 from code 
	where code_type = 'CD'
	order by code_desc
	using stars2ca;

// MikeFl 9/27/02 - Track 3130 - End

open CODE;

if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error opening the  Code Table. Cannot load code drop down list box')
end if

do while stars2ca.sqlcode = 0 
   fetch CODE into :lv_code_code,:lv_code_desc;
   if stars2ca.of_check_status() = 100 then exit
	if stars2ca.sqlcode <> 0 Then
      messagebox('INFO','Error reading the Code Table while loading code drop down list box')
      exit
	end if
  	ddlb_type.Additem( lv_code_desc + " - " + lv_code_code)
loop
close CODE;

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF
end subroutine

public subroutine wf_sort_type_list_by_code ();//*********************************************************************************
// Script Name:	wf_sort_type_list_by_code
//
// Arguments: n/a
//
// Returns:		n/a
//
// Description:	Alter window to search by code.
//
//*********************************************************************************
//
//  09/27/02	MikeF	Track 3130d	Remove all references to 'LK' code types
//	05/27/09	Katie	GNL.600.5633	Handle radio button checking and unchecking.  
//
//*********************************************************************************

string lv_code_code,lv_code_desc
int total, idx

rb_code_id.checked = TRUE
rb_code_description.checked = FALSE

ddlb_type.Reset()

// MikeFl 9/27/02 - Track 3130 - Begin
//declare CODE cursor for
//  select code_code, code_desc
//	 from code 
//	where code_type = 'LK'
//	using stars2ca;

declare CODE cursor for
  select code_code, code_desc
	 from code 
	where code_type = 'CD'
	using stars2ca;

// MikeFl 9/27/02 - Track 3130 - End

open CODE;

if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error opening the  Code Table. Cannot load code drop down list box')
end if

do while stars2ca.sqlcode = 0 
   fetch CODE into :lv_code_code,:lv_code_desc;
   if stars2ca.of_check_status() = 100 then exit
	if stars2ca.sqlcode <> 0 Then
      messagebox('INFO','Error reading the Code Table while loading code drop down list box')
      exit
	end if
  	ddlb_type.Additem( lv_code_code + " - " + lv_code_desc)
loop
close CODE;

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF
end subroutine

public subroutine wf_build_multi_code ();//***********************************************************************
//  09/25/09 RickB LKP.650.5678.001 (LKP.650.5678.GARY) - Fixed multiple multiselect issues.
// 10/14/09 RickB LKP.650.5678.001 - changed ls_code from 'users' to 'user_id' in CASE statement
// 10/28/09 RickB LKP.650.5678.001 QC Defect #152 - get rid of dups in multiselect value string
// 11/3/09 RickB LKP.650.5678.001 QC Defect #152 - Needed one more loop.  switched from
//			DO WHILE to LOOP WHILE.
// 11/13/09 RickB LKP.650.5678.001 QC Defect #163 - Need to allow for quotes (when SQL is built)
//			when checking length of values string.
// 11/13/09 GaryR LKP.650.5678.001 QC Defect #163 - Change < 255 to <= 255
// 11/16/09 RickB LKP.650.5678.001 Added + 4 to account for spaces and parens in create subset SQL
//
//***********************************************************************

String	ls_code, ls_item, ls_curr_list_a[]
Long 		ll_row, ll_quotes
n_cst_string		 lnv_string

// Get lookup type
CHOOSE CASE iv_code_to_use
	CASE	'PV'
		ls_code = 'prov_id'
	CASE 'NPI'
		ls_code = 'prov_npi'
	CASE 'RI'
		ls_code = 'recip_id'
	CASE 'UP'
		ls_code = 'prov_upin'
	CASE 'USERS'
		ls_code = 'user_id'
	CASE ELSE
		ls_code = 'code_code'
END CHOOSE

// Get current value list
is_curr_list = is_code_list
// Count the number of values in the string
ls_curr_list_a = lnv_string.of_stringtoarray( is_curr_list, "," )
// Count the number of spaces needed for quotes in SQL processing later
ll_quotes = (upperbound(ls_curr_list_a)*2)

// Loop through the selected rows and build string.
//	Limit selections to 255 chars.
ll_row = dw_1.GetSelectedRow( 0 )

DO 
	// Selected value
	ls_item = dw_1.GetItemString( ll_row, ls_code )
		
	// Check the current selection to see if it pushes the length over 255
	// Include space for quotes
	// Added + 4 to account for spaces and parens in create subset SQL
	IF (ll_quotes+3) + Len( is_curr_list ) + Len( ls_item ) + 4 <= 255 THEN 
		is_curr_list = is_curr_list + "," + ls_item
		// Increase ll_quotes for each value 
		ll_quotes = ll_quotes + 2
	// over 255 limit	
	ELSE
		// deselect all rows over 255, if shift-click selected too many rows
		do while ll_row > 0
			dw_1.selectrow(ll_row, FALSE)
			ll_row = dw_1.GetSelectedRow( ll_row )
		loop
			MessageBox( "Selections Over Limit", "The selected codes exceed the field size limit. ~n~r" + &
						"If you would like to include additional codes in your " + &
						"selection, ~n~rplease consider the following:~n~r~r     - deselect currently selected code(s) or ~n~r" + &
						"     - re-execute Code Lookup or ~n~r     - create a filter.", Exclamation! )
	END IF
	
	if ll_row > 0 then 
		ll_row = dw_1.GetSelectedRow( ll_row )
	end if
	
	// Sort and remove dups and leading comma
	IF Left( is_curr_list, 1 ) = "," THEN is_curr_list = Mid( is_curr_list, 2 )
	ls_curr_list_a = lnv_string.of_stringtoarray( is_curr_list, "," )
	lnv_string.of_sortarray( ls_curr_list_a, TRUE)
	lnv_string.of_arraytostring(ls_curr_list_a,',',is_curr_list)
LOOP	WHILE ll_row > 0				

//	Remove first comma
IF Left( is_curr_list, 1 ) = "," THEN is_curr_list = Mid( is_curr_list, 2 )
		
end subroutine

event open;call super::open;// 10-16-96 FNC	Prob#204 Stars35 Move gv_from to an instance variable
//					 	because it can get modified by another window. 
//	09-26-96 FNC Prob #144 STARSENH Allow user to create a column filter
// 06-28-95 FNC Read code table to load ddlb instead of global
//	05/01/09	GaryR	GNL.600.5633.005	Section 508 focus indicator
//******************************************************************

int n = 1, indexnum, lv_pos

Setpointer(hourglass!)

in_cb_use_clicked = FALSE
ib_clicked_filter = FALSE					//09-26-96 FNC

wf_sort_type_list_by_code()

If gv_code_to_use <> '' Then
	lv_pos = pos(gv_code_to_use,'~~')
	if lv_pos > 0 then
		sle_id.text = mid(gv_code_to_use,(lv_pos + 1))
		iv_code_to_use = left(gv_code_to_use,(lv_pos - 1))
	else
		iv_code_to_use = gv_code_to_use
	end if
	indexnum = ddlb_type.finditem(iv_code_to_use,0)
	if indexnum > 0 then ddlb_type.selectitem(indexnum)
	ddlb_type.triggerevent(selectionchanged!)
End If
gv_code_to_use = ''
is_from = gv_from					//10-16-96 FNC

setfocus(ddlb_type)
SetMicroHelp(W_main,"Ready")
end event

event close;call super::close;//Code Lookup exit script
if in_cb_use_clicked = FALSE Then
	gv_code_to_use = ''
	gv_result = 100
end if




end event

on w_code_lookup.create
int iCurrent
call super::create
this.st_1=create st_1
this.rb_code_id=create rb_code_id
this.cb_filter=create cb_filter
this.cb_print=create cb_print
this.st_row_count=create st_row_count
this.ddlb_type=create ddlb_type
this.dw_1=create dw_1
this.mle_code_description=create mle_code_description
this.sle_text=create sle_text
this.sle_id=create sle_id
this.st_range=create st_range
this.st_code_id=create st_code_id
this.st_type=create st_type
this.cb_list=create cb_list
this.cb_use=create cb_use
this.cb_exit=create cb_exit
this.gb_1=create gb_1
this.rb_code_description=create rb_code_description
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.rb_code_id
this.Control[iCurrent+3]=this.cb_filter
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.st_row_count
this.Control[iCurrent+6]=this.ddlb_type
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.mle_code_description
this.Control[iCurrent+9]=this.sle_text
this.Control[iCurrent+10]=this.sle_id
this.Control[iCurrent+11]=this.st_range
this.Control[iCurrent+12]=this.st_code_id
this.Control[iCurrent+13]=this.st_type
this.Control[iCurrent+14]=this.cb_list
this.Control[iCurrent+15]=this.cb_use
this.Control[iCurrent+16]=this.cb_exit
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.rb_code_description
end on

on w_code_lookup.destroy
call super::destroy
destroy(this.st_1)
destroy(this.rb_code_id)
destroy(this.cb_filter)
destroy(this.cb_print)
destroy(this.st_row_count)
destroy(this.ddlb_type)
destroy(this.dw_1)
destroy(this.mle_code_description)
destroy(this.sle_text)
destroy(this.sle_id)
destroy(this.st_range)
destroy(this.st_code_id)
destroy(this.st_type)
destroy(this.cb_list)
destroy(this.cb_use)
destroy(this.cb_exit)
destroy(this.gb_1)
destroy(this.rb_code_description)
end on

event ue_preopen;call super::ue_preopen;//******************************************************************
//	07-31-97 FDG	Stars3.6 - This window is defined as a response
//						window but the menu must open it as a sheet (because
//						this window can open another window).  When it's
//						opened as a sheet, the window should resize.
//  9/28/09 RickB - LKP.650.5678.001 Lookup Type DDLB disabled if right-mouse/F2 from lookup field.
//  10/1/09 RickB - LKP.650.5678.001 (LKP.650.5678.GARY) - added code to check for multiselect
//						parm and set multiselect values
//
//******************************************************************

String	ls_parms

//	Check incoming parms
ls_parms = Trim( Message.StringParm )
SetNull( Message.StringParm )

IF Left( ls_parms, 1 ) = "1" THEN
	//	Set multiselect values
	ib_multi_code = TRUE
	is_code_list = RightTrim( Mid( ls_parms, 2 ) )
	dw_1.of_multiselect( TRUE )
END IF

//	FDG 07/31/97	Begin
//	If this window is opened as a sheet (from the menu), then gv_from
//	is 'lookup'.  If so, resize the window (the ancestor script will
//	not resize a window defined as a response window).
IF	Lower ( Trim(gv_from) )	=	'lookup'		THEN
	IF	gnv_app.of_get_resize()	=	TRUE		&
	AND ib_disableresize			=	FALSE		THEN
		This.of_SetResize (TRUE)
	END IF
// If right-mouse lookup, then lookup type cannot be changed.
ELSE
	ddlb_type.enabled = FALSE
END IF
//	FDG 07/31/97	End
end event

type st_1 from statictext within w_code_lookup
string accessiblename = "Sort Type List By "
string accessibledescription = "Sort Type List By "
accessiblerole accessiblerole = statictextrole!
integer x = 123
integer y = 212
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Sort Type List By: "
boolean focusrectangle = false
end type

type rb_code_id from radiobutton within w_code_lookup
string accessiblename = "Code"
string accessibledescription = "Code"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 677
integer y = 212
integer width = 288
integer height = 64
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Code"
boolean checked = true
boolean automatic = false
end type

event clicked;wf_sort_type_list_by_code()
rb_code_description.checked = false
end event

type cb_filter from u_cb within w_code_lookup
string accessiblename = "Filter"
string accessibledescription = "Filter"
integer x = 2071
integer y = 1780
integer width = 338
integer height = 108
integer taborder = 100
integer textsize = -16
boolean enabled = false
string text = "&Filter"
end type

event clicked;//*********************************************************************
// 09-26-96 FNC Prob #144 STARSENH Allow user to create a column filter
// 09/16/05	MikeF	SPR4383c	Can't get descriptions from Code Filter
// 04/10/09	Katie	GNL.600.5633 Added decode structure to fx_uo_control call.
// 09/10/09 RickB LKP.650.5678.004 - Assigned type_to_use to gv_code_to_use so the table type
//		could be used in u_append_filter.of_appendfilter when creating a filter from code lookup.
//*********************************************************************
string ls_control_text

setpointer(hourglass!)
ls_control_text = 'Create Col Filter'
is_dw_control = fx_uo_control(iv_uo_win,dw_1,ls_control_text,is_dw_control,st_row_count, istr_decode_struct)

if is_dw_control = 'CREATE' then	
	istr_decode_struct.table_type[1] = type_to_use
	gv_code_to_use = type_to_use
	ib_clicked_filter = TRUE	
	SetMicroHelp(W_main,"Click column heading to create filter")
else
	ib_clicked_filter = FALSE
end if	
end event

type cb_print from u_cb within w_code_lookup
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 1682
integer y = 1780
integer width = 338
integer height = 108
integer taborder = 90
boolean enabled = false
string text = "&Print"
end type

on clicked;//setpointer(hourglass!)
//dw_1.print()
OpenWithParm(w_dw_print_what_cols,dw_1)

end on

type st_row_count from statictext within w_code_lookup
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 1788
integer width = 274
integer height = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_code_lookup
string accessiblename = "Type"
string accessibledescription = "Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 507
integer y = 84
integer width = 1467
integer height = 468
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// extract the real code from the ddlb data
//	09/21/05	GaryR	Track 4440d	Get the last dash if sorted by description
// 09/10/09 RickB LKP.650.5678.004 - Disabled cb_filter when selection changes. Can't create a filter
//												until List is clicked and results are found.

int dashpos

if rb_code_id.checked then
	dashpos = pos(ddlb_type.text,"-")
	if dashpos < 1 then
		type_to_use = ddlb_type.text
	else
		type_to_use= mid(ddlb_type.text,1,dashpos - 2)
	end if
else
	dashpos = LastPos(ddlb_type.text,"-")
	if dashpos < 1 then
		type_to_use = ddlb_type.text
	else
		type_to_use= trim(mid(ddlb_type.text,dashpos + 1))
	end if
end if

dw_1.Reset()
mle_code_description.text = ''
cb_filter.enabled = FALSE


end event

type dw_1 from u_dw within w_code_lookup
string tag = "CRYSTAL, title = Code List"
string accessiblename = "Code List"
string accessibledescription = "Code List"
integer x = 82
integer y = 472
integer width = 2697
integer height = 1048
integer taborder = 60
string dataobject = "d_code_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;//*********************************************************************
// 10-16-96 FNC	Prob#204 Stars35 Move gv_from to an instance variable
//				 	because it can get modified by another window. 
// 09-26-96 FNC	Created
//					Prob #144 STARSENH Allow user to create a column filter
// 10/1/09 RickB - LKP.650.5678.001 (LKP.650.5678.GARY) - sending to new function
//						wf_build_multi_code.  Also, setting ib_clicked to TRUE.  it's used in
//						rowfocuschanged so the new function is not called twice with the same click.
// 10/28/09 RickB LKP.650.5678 QC Defect #151 - Moved column selection code from here to 
// 						double-clicked event to make filter column selection consistent across STARS.
//						The RETURN was the cause of the defect.
// 10/30/09 RickB LKP.650.5678 QC Defect #151 - Removed variables not needed here anymore
//
//*********************************************************************

setpointer(hourglass!)

ib_clicked = TRUE

if is_from <> 'lookup' then 
	IF ib_multi_code THEN
		Parent.Post wf_build_multi_code()
	END IF
end if

SetMicroHelp(W_main,"Ready")
end event

event retrieveend;//	05/01/09	GaryR	GNL.600.5633.005	Section 508 focus indicator  
// 10/1/09 RickB - LKP.650.5678.001 (LKP.650.5678.GARY) - If not a multiselect lookup window, then
// 			trigger rowfocuschanged.  This will highlight the first row when the window opens.  Multiselect
//			windows should not have any rows selected at first.

cb_exit.enabled = TRUE
cb_list.enabled = TRUE

if gv_from <> "lookup" then cb_use.enabled = TRUE
gv_cancel_but_clicked = TRUE
IF NOT ib_multi_code THEN This.triggerevent(rowfocuschanged!)
end event

event doubleclicked;//*********************************************************************
// 9/15/09 RickB LKP.650.5678.001 - taking away double-click if multiselect and added check for
//						ib_multi_code.
// 10/28/09 RickB LKP.650.5678 QC Defect #151 - Moved column selection code to here from 
// 						clicked event to make filter column selection consistent across STARS.  Also,
//						leaving ib_clicked_filter = true so user can select a different column to filter on.
//	11/2/09 RickB LKP.650.5678 QC Defect #154 - ib_clicked_filter if gv_from = 'lookup'
//									returns a null object reference.  Moved check to ELSE.
//
//*********************************************************************

string ls_hold_object,ls_col
integer li_rc
long ll_tabpos

setpointer(hourglass!)
if gv_from <> 'lookup' then
	// Double-click row selection disabled if multiselect window.
	if NOT ib_multi_code AND (gv_cancel_but_clicked) &
	AND cb_use.enabled Then cb_use.event clicked( )
else
	// Check that clicked object is a header.  If not, return message to user.
	if ib_clicked_filter then
		ls_hold_object = Getobjectatpointer(dw_1)
		
		//store the current row number and the column name
		ll_tabpos = pos (ls_hold_object,"~t")
		ls_col = left(ls_hold_object,(ll_tabpos - 1))
	
		If right(ls_col,2) = '_t' and UPPER (ls_col) <> 'HEADER_T' Then
			li_rc = fx_dw_control(dw_1,ls_hold_object,is_dw_control,iv_uo_win,'',0,istr_decode_struct)
		else
			messagebox('WARNING','Must click on a column heading in order to filter')
			return
		end if
		
		SetMicroHelp(W_main,"Column filter created")
	end if
end if

SetMicroHelp(W_main,"Ready")

end event

event rowfocuschanged;/////////////////////////////////////////////////////////////////
//
//	04/11/01	GaryR	Stars 4.7 DataBase Port - Trimming the data
//	02/15/02	GaryR	Track 2710d	Build Patient/Enrollee SQL dynamically
//	04/24/03	GaryR	Track 3537d	Add Stars user lookup
//	11/21/06 Katie	SPR 4766 Add logic to create description for NPI
//	10/1/09 RickB - LKP.650.5678.001 (LKP.650.5678.GARY) - added check for ib_clicked.  If clicked event
//				kicked off wf_build_multi_code, there's no need to do it again here.
//
/////////////////////////////////////////////////////////////////

long lv_row_nbr
string lv_col_nbr_str
int lv_col_count, lv_col_nbr

if gv_cancel_but_clicked Then
	if gv_from <> "lookup" then
		Cb_Use.enabled = true
	end if

	If iv_code_to_use > '' Then
		If iv_code_to_use <> type_to_use Then
			cb_use.enabled = False
		End If
	End If
	
	lv_row_nbr = getrow(dw_1)
	
	IF ib_multi_code THEN
		IF lv_row_nbr = 0 THEN Return
		this.event ue_multiselect( lv_row_nbr)
		// If ib_clicked is TRUE, the clicked event is building the multi code.  
		IF ib_clicked = TRUE THEN
			ib_clicked = FALSE  
		ELSE
			Parent.Post wf_build_multi_code()
		END IF
	ELSE		
		If lv_row_nbr = 0 then 
			selectrow(dw_1,0,false)
			Cb_Use.enabled = false
			RETURN
		End If
		selectrow(dw_1,0,false)
		selectrow(dw_1,lv_row_nbr,true)
	END IF

	if type_to_use ='PV' OR type_to_use = 'UP' Then
		if type_to_use ='PV' Then
			//	04/11/01	GaryR	Stars 4.7 DataBase Port
			//	02/15/02	GaryR	Track 2710d
			//gv_code_to_use = Trim( getitemstring(dw_1,lv_row_nbr,1) )
			gv_code_to_use = Trim( dw_1.GetItemString( lv_row_nbr, "prov_id" ) )
		elseif type_to_use = 'UP' Then
			//	04/11/01	GaryR	Stars 4.7 DataBase Port
			//	02/15/02	GaryR	Track 2710d
			//gv_code_to_use = Trim( getitemstring(dw_1,lv_row_nbr,2) )
			gv_code_to_use = Trim( dw_1.GetItemString( lv_row_nbr, "prov_upin" ) )
		end if
		//	02/15/02	GaryR	Track 2710d
		mle_code_description.text = gv_code_to_use + '   ' + &
											 getitemstring(dw_1,lv_row_nbr,4) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,5) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,6) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,7) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,8) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,9) +', ' +&
											 getitemstring(dw_1,lv_row_nbr,10)
	elseif type_to_use = 'NPI' Then										  
		gv_code_to_use = Trim( dw_1.GetItemString( lv_row_nbr, "prov_npi" ) )
		mle_code_description.text = gv_code_to_use + '   ' + &
											 getitemstring(dw_1,lv_row_nbr,'PROV_NPI_NAME') + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,'PROV_ID')
		
	elseif type_to_use ='RI' Then
		//	04/11/01	GaryR	Stars 4.7 DataBase Port
		//	02/15/02	GaryR	Track 2710d
		//gv_code_to_use = Trim( getitemstring(dw_1,lv_row_nbr,2) )
		gv_code_to_use = Trim( dw_1.GetItemString( lv_row_nbr, "recip_id" ) )
		mle_code_description.text = getitemstring(dw_1,lv_row_nbr,1) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,2) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,3) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,4) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,5) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,6)
	elseif type_to_use ='USERS' Then
		gv_code_to_use = Trim( dw_1.GetItemString( lv_row_nbr, "user_id" ) )
		mle_code_description.text = getitemstring(dw_1,lv_row_nbr,2) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,3) + '   ' +&
											 getitemstring(dw_1,lv_row_nbr,4)
	else
		//	04/11/01	GaryR	Stars 4.7 DataBase Port
		gv_code_to_use = Trim( getitemstring(dw_1,lv_row_nbr,'code_code') )
		mle_code_description.text = getitemstring(dw_1,lv_row_nbr,'code_desc')
	end if	
end if

end event

event retrievestart;//	05/01/09	GaryR	GNL.600.5633.005	Section 508 focus indicator

Setpointer(hourglass!)
in_dw_limit = gc_dw_limit
gv_cancel_but_clicked = FALSE
end event

type mle_code_description from multilineedit within w_code_lookup
string accessiblename = "Code Description"
string accessibledescription = "Code Description"
accessiblerole accessiblerole = textrole!
integer x = 82
integer y = 1548
integer width = 2697
integer height = 200
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 255
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_text from singlelineedit within w_code_lookup
string accessiblename = "Code Description"
string accessibledescription = "Code Description"
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 324
integer width = 2235
integer height = 80
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
integer limit = 60
borderstyle borderstyle = stylelowered!
end type

type sle_id from singlelineedit within w_code_lookup
string accessiblename = "Code ID"
string accessibledescription = "Code ID"
accessiblerole accessiblerole = textrole!
integer x = 2240
integer y = 84
integer width = 498
integer height = 88
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

type st_range from statictext within w_code_lookup
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 123
integer y = 324
integer width = 430
integer height = 80
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
end type

type st_code_id from statictext within w_code_lookup
string accessiblename = "Code"
string accessibledescription = "Code"
accessiblerole accessiblerole = statictextrole!
integer x = 2011
integer y = 92
integer width = 183
integer height = 80
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code:"
alignment alignment = center!
end type

type st_type from statictext within w_code_lookup
string accessiblename = "Type"
string accessibledescription = "Type"
accessiblerole accessiblerole = statictextrole!
integer x = 123
integer y = 92
integer width = 187
integer height = 80
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Type:"
end type

type cb_list from u_cb within w_code_lookup
string accessiblename = "List"
string accessibledescription = "List"
integer x = 901
integer y = 1780
integer width = 338
integer height = 108
integer taborder = 70
string text = "&List"
boolean default = true
end type

event clicked;//************************************************************************
//Code Lookup list button script
//************************************************************************
//
//	09/26/96 FNC	Prob #144 STARSENH Allow user to create a column filter
//	05/14/96	FDG	Add a SetRedraw to prevent the d/w from painting
//						multiple times
// 10/26/01	GaryR	Track 2484d	Limit rows logic
//	11/12/01	GaryR	Track 2535d	Code Description is case insensitive
//	02/15/02	GaryR	Track 2710d	Build Patient/Enrollee SQL dynamically
//	03/07/02	FDG	Track 2861d.  Trim sle_id, sle_text.
// 07/23/02 MikeF Track 3181d. Disable 'Use' button when coming from Definition
//	04/24/03	GaryR	Track 3537d	Add Stars user lookup
//	11/21/06 Katie	SPR 4766 Added logic for NPI Lookup type
//
//************************************************************************

int rc
long lv_nbr_rows

//	02/15/02	GaryR	Track 2710d
//// 10/26/01	GaryR	Track 2484d - Begin
//Long		ll_rowlimit = 2500
//String	ls_limitsql
//// 10/26/01	GaryR	Track 2484d - End

setpointer(hourglass!)
setmicrohelp(w_main,'Listing All Codes Based On The Criteria')
dw_1.SetRedraw (FALSE)						// FDG 05/14/96

// FDG 03/07/02 - trim data
sle_id.text		=	Trim (sle_id.text)
sle_text.text	=	Trim (sle_text.text)

If type_to_use = '' Then
	setfocus(ddlb_type)
	Messagebox('EDIT','Please Enter Code Type for List',Exclamation!)
	wf_reset_window()							// FDG 05/14/96
	RETURN
End If

//	 type_to_use = "UP" OR type_to_use = "PV" OR type_to_use = "RI") &	//	02/15/02	GaryR	Track 2710d
if (type_to_use = "AP" or type_to_use = "RC" OR type_to_use = "ID" OR &
	 type_to_use = "PC" OR type_to_use = "DX" OR type_to_use = "AB" OR &
	 type_to_use = "PA" OR type_to_use = "DN" OR type_to_use = "PH") &
	and sle_id.text = "" and sle_text.text = "" then
	if messagebox("WARNING","The query you have requested may take a long time to process.  You should specify at least one search parameter.  Do you wish to continue?",QUESTION!,OKCancel!,2)= 2 then
		wf_reset_window()							// FDG 05/14/96
		return
	end if
end if 

cb_use.enabled = FALSE
cb_exit.enabled = FALSE
cb_list.enabled = FALSE
cb_print.enabled=false

//	02/15/02	GaryR	Track 2710d - Begin
CHOOSE CASE type_to_use
	CASE "PV", "RI", "UP", "USERS", "NPI"
		lv_nbr_rows = Parent.wf_pat_prov_lookup( type_to_use )
CASE ELSE
	dw_1.DataObject = 'd_code_lookup'
	rc = settransobject(dw_1,stars2ca)
	Parent.Event	ue_set_window_colors (Parent.Control)
	lv_nbr_rows = retrieve(dw_1,type_to_use,sle_id.text+'%','%'+sle_text.text+'%')
END CHOOSE
//	02/15/02	GaryR	Track 2710d - End

If lv_nbr_rows <= 0 then
	cb_use.enabled = false
	cb_exit.enabled = true
	cb_list.enabled = true
	setfocus(sle_id)
	Messagebox('LIST ERROR','No Match for a Search By that Criteria',Exclamation!)
	st_row_count.text = ''
	mle_code_description.text = ''	
	COMMIT Using Stars2ca;							// FDG 10/20/95
	wf_reset_window()									// FDG 05/14/96
   RETURN
End If

//KMM 7/5/95 Added check to see if coming from menu
//When from menu, use button should be disabled
if gv_from = 'L' then
	cb_use.enabled = false
end if

if gv_from = 'lookup' then
	cb_filter.enabled = TRUE						//FNC 09/26/96
end if
//KMM END

setfocus(dw_1)
dw_1.taborder = 50

st_row_count.text = string(lv_nbr_rows)

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

If iv_code_to_use > '' Then
// MikeFl 7/23/02 - Track 3181d - Begin
//	If iv_code_to_use <> type_to_use Then
	If iv_code_to_use <> type_to_use &
	OR Lower (Trim(gv_from)) =	'lookup'	THEN
// MikeFl 7/23/02 - Track 3181d - End
		cb_use.enabled = False
	Else
		cb_use.enabled = True
	End If
End If

wf_reset_window()							// FDG 05/14/96

setmicrohelp(w_main,'Retrieve Completed')

cb_print.enabled=true

end event

type cb_use from u_cb within w_code_lookup
string accessiblename = "Use"
string accessibledescription = "Use"
integer x = 1294
integer y = 1780
integer width = 338
integer height = 108
integer taborder = 80
boolean enabled = false
string text = "&Use"
end type

event clicked;//Code Lookup use button script
// 10/1/09 RickB - LKP.650.5678.001 (LKP.650.5678.GARY) - assigning the value list (is_curr_list) created by
//		wf_build_multi_code to gv_code_to_use.  It then goes to expression_two in QE Search Criteria tab.

IF ib_multi_code THEN gv_code_to_use = is_curr_list
gv_result = 0
in_cb_use_clicked = TRUE
close(parent)


end event

type cb_exit from u_cb within w_code_lookup
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2450
integer y = 1780
integer width = 338
integer height = 108
integer taborder = 110
string text = "&Close"
end type

event clicked;// LKP.650.5678

gv_from = ""
Setpointer(hourglass!)
close(parent)
end event

type gb_1 from groupbox within w_code_lookup
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 82
integer y = 4
integer width = 2693
integer height = 432
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

type rb_code_description from radiobutton within w_code_lookup
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 974
integer y = 212
integer width = 1769
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Description"
boolean automatic = false
end type

event clicked;wf_sort_type_list_by_desc()
end event

