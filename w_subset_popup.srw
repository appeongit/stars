HA$PBExportHeader$w_subset_popup.srw
$PBExportComments$Response window to provide Sort/Break/Total options for Subset View (Inherited from w_master).
forward
global type w_subset_popup from w_master
end type
type dw_sortchoices from u_dw within w_subset_popup
end type
type cb_ok from u_cb within w_subset_popup
end type
type wsx_popup_parms from structure within w_subset_popup
end type
end forward

type wsx_popup_parms from structure
	string		col_desc
	string		data_type
	string		totals
end type

global type w_subset_popup from w_master
string accessiblename = "Sort Choices"
string accessibledescription = "Sort Choices"
integer x = 937
integer y = 740
integer width = 1783
integer height = 808
string title = "Sort Choices"
windowtype windowtype = response!
dw_sortchoices dw_sortchoices
cb_ok cb_ok
end type
global w_subset_popup w_subset_popup

type variables
Protected:

Constant String ICS_DEFAULTSORT = 'SASC'  //Sort Ascending default
end variables

on w_subset_popup.create
int iCurrent
call super::create
this.dw_sortchoices=create dw_sortchoices
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sortchoices
this.Control[iCurrent+2]=this.cb_ok
end on

on w_subset_popup.destroy
call super::destroy
destroy(this.dw_sortchoices)
destroy(this.cb_ok)
end on

event open;call super::open;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	w_subset_popup				Open
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Will insert the datawindow and load the column name into the sort field.
// In addition, will not allow Break with Totals for Quantity columns if Totaling is 
//	already selected for Quantity or will not allow Break with Totals for Money columns 
// if Totaling is already selected for Money.  Can select sort sequence.  
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	02/06/98		Created.
// FNC		06/02/98		Track 1294. 1. Replace if statement with case statement.
//								2. Set color to disabled color since cannot disable 
//								radio button on DW. 
//								3. If user select no totals disable break with totals.
// FNC		09/15/98		Track 1718. Set default for sort radio buttons to
//								break with totals if it is not disabled.
//	FDG		12/14/00		Stars 4.7.  Make the checking of data types DBMS-independent.
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

sx_popup_parm lsx_popup_parms
integer li_row

lsx_popup_parms = message.PowerObjectParm

li_row = dw_sortchoices.insertrow(0)				// FNC 06/02/98 

dw_sortchoices.object.sort_field[1] = lsx_popup_parms.col_desc

// FNC 06/02/98 Start
Choose Case lsx_popup_parms.totals
	Case 'A'
		// FDG 12/14/00 - Make the checking of data types DBMS-independent.
		IF	gnv_sql.of_is_numeric_data_type (lsx_popup_parms.data_type)		THEN
			dw_sortchoices.object.rb_options[li_row] = 'S'
			dw_sortchoices.object.rb_options.protect = TRUE
			dw_sortchoices.object.rb_options.Color = stars_colors.disabled_text
			dw_sortchoices.object.rb_sort_t.Color = stars_colors.disabled_text
		ELSE
			dw_sortchoices.object.rb_options[li_row] = 'B'		// FNC 09/15/98
		END IF
		// FDG 12/14/00 end
	Case 'M'
		// FDG 12/14/00 - Make the checking of data types DBMS-independent.
		IF	gnv_sql.of_is_money_data_type (lsx_popup_parms.data_type)		THEN
			dw_sortchoices.object.rb_options[li_row] = 'S'
			dw_sortchoices.object.rb_options.protect = TRUE
			dw_sortchoices.object.rb_options.Color = stars_colors.disabled_text
			dw_sortchoices.object.rb_sort_t.Color = stars_colors.disabled_text
		ELSE
			dw_sortchoices.object.rb_options[li_row] = 'B'		// FNC 09/15/98
		END IF
		// FDG 12/14/00 end
	Case 'Q'
		// FDG 12/14/00 - Make the checking of data types DBMS-independent.
		IF	gnv_sql.of_is_number_data_type (lsx_popup_parms.data_type)		THEN
			dw_sortchoices.object.rb_options[li_row] = 'S'
			dw_sortchoices.object.rb_options.protect = TRUE
			dw_sortchoices.object.rb_options.Color = stars_colors.disabled_text
			dw_sortchoices.object.rb_sort_t.Color = stars_colors.disabled_text
		ELSE
			dw_sortchoices.object.rb_options[li_row] = 'B'		// FNC 09/15/98
		END IF
		// FDG 12/14/00 end
	Case 'N'
		/*Selected No Totals so disable Break with Totals */				
		dw_sortchoices.object.rb_options[li_row] = 'S'
		dw_sortchoices.object.rb_options.protect = TRUE
		dw_sortchoices.object.rb_options.Color = stars_colors.disabled_text
		dw_sortchoices.object.rb_sort_t.Color = stars_colors.disabled_text
End Choose
// FNC 06/02/98 End
end event

type dw_sortchoices from u_dw within w_subset_popup
string accessiblename = "Sort Choices"
string accessibledescription = "Sort Choices"
integer x = 91
integer width = 1641
integer height = 460
integer taborder = 10
string dataobject = "d_sort_choices"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetUpdateable(FALSE)
end event

type cb_ok from u_cb within w_subset_popup
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 713
integer y = 564
integer taborder = 20
string text = "&OK"
boolean default = true
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	cb_Ok							Clicked
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Will create a string that contains the sort options as its first character and the
// sort sequence option as the second character.  Use closewithreturn to pass the string 
// back to w_subset_sort.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/06/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_Return = ICS_DEFAULTSORT

If dw_sortchoices.GetRow() = 1 Then 
	ls_Return = dw_sortchoices.object.rb_options[1] + dw_sortchoices.object.rb_sort[1]
End If

CloseWithReturn(parent,ls_Return)
end event

