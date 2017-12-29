HA$PBExportHeader$n_cst_dwsrv_dropdownsearch.sru
$PBExportComments$DataWindow DropDownSearch service (inherited from n_cst_dwsrv) <logic>
forward
global type n_cst_dwsrv_dropdownsearch from n_cst_dwsrv
end type
type os_columns from structure within n_cst_dwsrv_dropdownsearch
end type
end forward

type os_columns from structure
	string		s_columnname
	string		s_editstyle
	datawindowchild		dwc_object
end type

global type n_cst_dwsrv_dropdownsearch from n_cst_dwsrv
event ue_editchanged ( ref long al_row,  ref dwobject adwo_obj,  ref string as_data )
event ue_itemfocuschanged ( long al_row,  ref dwobject adwo_object )
end type
global n_cst_dwsrv_dropdownsearch n_cst_dwsrv_dropdownsearch

type variables
Protected:
os_columns	istr_columns[]
integer                 	ii_currentindex
boolean		ib_performsearch=False
string		is_textprev


end variables

forward prototypes
public function integer of_removecolumn (string as_column)
public function integer of_addcolumn ()
public function integer of_addcolumn (string as_column)
public function integer of_getcolumn (ref string as_columns[])
protected function integer of_searchitem (string as_column)
protected function integer of_DeleteItem (integer ai_index)
public subroutine of_setrequestor (u_dw adw)
end prototypes

event ue_editchanged(ref long al_row, ref dwobject adwo_obj, ref string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		ue_editchanged
//
//	Arguments:
//	al_row:  	row number
//	adwo_obj:  	DataWindow object passed by reference
//	as_data:  	The current data on the column.  (The search text)
//
//	Returns:   none
//
//	Description:	This event should be mapped to the editchanged
//			   		event of a DataWindow. When is event is "fired", it will use
//						instance variables (set in the ue_itemfocuschanged) to access
//						items in the instance structure.
//						The instance structure contains information about the dddw and 
//						ddlb columns this service uses.
//
//////////////////////////////////////////////////////////////////////////////
//
//	10/08/02	GaryR	SPR 2893d	Auto-populate only after invoice
//										type and first letter are entered
//	10/30/02	GaryR	SPR 3360d	Perform search on deletion of text
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_searchtextlen
Long			ll_findrow
String		ls_dddw_displaycol
String		ls_foundtext
String		ls_findexp
String		ls_searchcolname
Long			ll_dddw_rowcount
Long			li_ddlb_index=0
String		ls_displaydata_value
String		ls_searchtext
Boolean		lb_matchfound=False

// Check requirements.
If IsNull(adwo_obj) Then Return

// Confirm that the search capabilities are valid for this column.
if ib_performsearch=False or ii_currentindex <= 0 THEN return

// Get information on the column and text.
ls_searchcolname = adwo_obj.Name
ls_searchtext = as_data
li_searchtextlen = Len (ls_searchtext)

//	10/08/02	GaryR	SPR 2893d
IF NOT Match( ls_searchtext, "^..\.." ) THEN Return

// If the user performed a delete operation, do not perform the search.
// If the text entered is the same as the last search, do not perform another search.
//	10/30/02	GaryR	SPR 3360d
//(li_searchtextlen < Len(is_textprev)) or &
If (Lower (ls_searchtext) = Lower (is_textprev)) Then
	// Store the previous text information.
	is_textprev = ''
	Return 
End If

// Store the previous text information.
is_textprev = ls_searchtext

If istr_columns[ii_currentindex].s_editstyle = 'dddw' Then
	// *** DropDownDatawindow Search ***
	// Build the find expression to search the dddw for the text 
	// entered in the parent datawindow column.
	ls_dddw_displaycol = adwo_obj.dddw.displaycolumn
	ls_findexp = "Lower (Left (" + ls_dddw_displaycol + ", " + &
		String (li_searchtextlen) + ")) = '" + Lower (ls_searchtext) + "'"

	// Perform the Search on the dddw.
	ll_dddw_rowcount = istr_columns[ii_currentindex].dwc_object.rowcount()
	ll_findrow = istr_columns[ii_currentindex].dwc_object.Find (ls_findexp, 0, ll_dddw_rowcount)

	// Determine if a match was found on the dddw.
	lb_matchfound = (ll_findrow > 0)

	// Set the found text if found on the dddw.
	if lb_matchfound then
		// Get the text found.
		ls_foundtext =	istr_columns[ii_currentindex].dwc_object.GetItemString (&
									ll_findrow, ls_dddw_displaycol)
	End If								
Else
	// *** DropDownListBox Search ***
	// Loop around the entire Code Table until a match is found (if any).
	Do
		li_ddlb_index	++
		ls_displaydata_value = idw_requestor.GetValue(ls_searchcolname, li_ddlb_index)
		If ls_displaydata_value = '' Then 
			// No more entries on the Code Table.
			Exit
		End If
	
		// Determine if a match has been found on the ddlb.
		lb_matchfound = ( Lower(ls_searchtext) = Lower( Left(ls_displaydata_value, Len(ls_searchtext))) )
	Loop Until lb_matchfound
	
	// Check if a match was found on the ddlb.
	If lb_matchfound Then
		// Get the text found by discarding the data value (just keep the display value).
		ls_foundtext = Left (ls_displaydata_value, Pos(ls_displaydata_value,'~t') -1)			
	End If
End If

// For either dddw or ddlb, check if a match was found.
If lb_matchfound Then
	// Set the text.
	idw_requestor.SetText (ls_foundtext)

	// Determine what to highlight or where to move the cursor..
	if li_searchtextlen = len(ls_foundtext) THEN
		// Move the cursor to the end
		idw_requestor.SelectText (Len (ls_foundtext)+1, 0)
	else
		// Hightlight the portion the user has not actually typed.
		idw_requestor.SelectText (li_searchtextlen + 1, Len (ls_foundtext))
	end if
end if

end event

event ue_itemfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		ue_itemfocuschanged
//
//	Arguments:
//	al_row:  	row number
//	adwo_obj:  	DataWindow object passed by reference
//	
//
//	Returns:   	none
//
//	Description:	This event is fired from the itemfocuschanged event. 
//						It will set an index based on the loacation of the current
//						column in the array.  Also, it will make sure the column is
//						of type dddw or ddlb and set a flag to indicate so.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_editstyle
String 	ls_dwcolname
String	ls_ddlb_displaydatavalue, ls_ddlb_displayvalue
Int		li_index

// Initialize values.
ib_performsearch = False
ii_currentindex = 0
is_textprev = ''

// Check the column type.
ls_editstyle = adwo_object.Edit.Style
if ls_editstyle <> "dddw" And ls_editstyle <> "ddlb" THEN Return

// Get column name.
ls_dwcolname = adwo_object.Name

// Check if column is in the search column array.
li_index = of_SearchItem(ls_dwcolname)
If li_index <= 0 Then Return

//////////////////////////////////////////////////////////////////////////////
// The current column is of type DDDW or DDLB and is found on the array.
//////////////////////////////////////////////////////////////////////////////

// Store the variable that says OK to perform search.
ib_performsearch = True

// Store the current index.
ii_currentindex = li_index

// Store the previous text information.
If ls_editstyle = 'dddw' Then
	is_textprev = idw_requestor.GetText()
Else
	ls_ddlb_displaydatavalue = idw_requestor.GetValue(ls_dwcolname, al_row)
	ls_ddlb_displayvalue = Left(ls_ddlb_displaydatavalue, Pos(ls_ddlb_displaydatavalue, '~t') -1)
	is_textprev = ls_ddlb_displayvalue
End If

// If a DDDW, Validate the dddw object.  If Not Valid, get it now.
If ls_editstyle <> 'dddw' Then
	If	IsNull(istr_columns[li_index].dwc_object)			Or	&
		Not isValid(istr_columns[li_index].dwc_object)	Then
		adwo_object.getchild(ls_dwcolname, istr_columns[li_index].dwc_object) 
	End If
End If


end event

public function integer of_removecolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		of_RemoveColumn
//
//	Access:  		public
//
//	Arguments:  	
//	as_column 		Column to remove from the service.
//
//	Returns:  		Integer
//						 1 succesful operation.
//						 0 if column not found.
//						-1 if an error is encountered.
//
//	Description:  	This function is called to remove a column from the list the
//						services uses.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_index
Integer	li_rc
 
// Find the column in the array.
li_index = of_SearchItem(as_column)

// Check if column was found.
IF NOT li_index >0 THEN return 0

// Delete the column from the array.
Return of_DeleteItem(li_index)

end function

public function integer of_addcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_AddColumn
//
//	Access: 			public
//
//	Arguments:		None
//
//	Returns: 		integer
//						The number of columns added.
//						-1 if an error is encountered.
//
//	Description:	Add all the appropriate dropdowndatawindow and dropdownlistboxe 
//						columns from the datawindow to have dropdown search capabilities.
//
//		*Note:	For a dropdowndatawindow column to be added it most have
//					a display value type char.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_colcount, li_i, li_count, li_rc
String		ls_editstyle, ls_displayvaluecolumn, ls_displayvaluecoltype
String		ls_colname
DataWindowChild ldwc_obj

// Get the number of columns in the datawindow object
li_colcount = integer(idw_requestor.object.datawindow.Column.Count)

// Loop around all columns looking for dddw or ddlb columns.
For li_i = 1 to li_colcount
	//Get-Validate the name and edit style of the column.
	ls_editstyle = idw_requestor.Describe("#"+string(li_i)+".Edit.Style")
	ls_colname = idw_requestor.Describe("#"+string(li_i)+".Name")
	If ls_colname = '!' or ls_editstyle = '!' Then Return -1	

	If ls_editstyle = 'dddw' Then
		// Get the displayvalue column name.
		ls_displayvaluecolumn = idw_requestor.Describe(ls_colname+".dddw.displaycolumn")
		If ls_displayvaluecolumn = '!' Then Return -1

		// Get a reference to the DropDownDatawindow.
		li_rc = idw_requestor.GetChild(ls_colname, ldwc_obj)
		If li_rc<>1 Then Return -1
		
		// If displayvalue column is not of type "Char," skip it.	
		ls_displayvaluecoltype = ldwc_obj.Describe(ls_displayvaluecolumn+".coltype")
		If pos(ls_displayvaluecoltype, "char") >= 1 Then
			// Add entry into array.
			li_count = upperbound(istr_columns)+1
			istr_columns[li_count].s_editstyle	= ls_editstyle
			istr_columns[li_count].s_columnname = ls_colname
			istr_columns[li_count].dwc_object   = ldwc_obj
		End If
	ElseIf ls_editstyle = 'ddlb' Then
		// Add entry into array.
		li_count = upperbound(istr_columns)+1
		istr_columns[li_count].s_editstyle	= ls_editstyle
		istr_columns[li_count].s_columnname = ls_colname		
	End If
Next

Return upperbound(istr_columns)
end function

public function integer of_addcolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_AddColumn
//
//	Access:  		public
//
//	Arguments:
//	as_column		Column to add.
//
//	Returns:  		Integer
//						1 if the column was added.
//						0 if the column was not added.
//						-1 if an error is encountered.
//
//	Description: 	Add a dropdowndatawindow or a dropdownlistboxe column to 
//						the dropdown search services.
//
//		*Note:	For a dropdowndatawindow column to be added it must have
//					a display value type char.
//
//////////////////////////////////////////////////////////////////////////////

Integer 			li_count, li_rc
String			ls_editstyle, ls_coltype
String			ls_displayvaluecolumn, ls_displayvaluecoltype
DataWindowChild ldwc_obj

// Check arguments
If IsNull(as_column) Or Len(Trim(as_column))=0 Or &
	Not IsValid(idw_requestor) Then Return -1

ls_editstyle = idw_requestor.Describe(as_column+".Edit.Style")
If ls_editstyle = 'dddw' Then
	// Get the displayvalue column name.
	ls_displayvaluecolumn = idw_requestor.Describe(as_column+".dddw.displaycolumn")
	If ls_displayvaluecolumn = '!' Then Return -1

	// Get a reference to the DropDownDatawindow.
	li_rc = idw_requestor.GetChild(as_column, ldwc_obj)
	If li_rc<>1 Then Return -1
	
	// If displayvalue column is not of type "Char," skip it.	
	ls_displayvaluecoltype = ldwc_obj.Describe(ls_displayvaluecolumn+".coltype")		
	If pos(ls_displayvaluecoltype, "char") >= 1 Then
		// Add the new entry.				
		li_count = upperbound(istr_columns) +1					
		istr_columns[li_count].s_editstyle	= ls_editstyle		
		istr_columns[li_count].s_columnname	= as_column
		istr_columns[li_count].dwc_object 	= ldwc_obj
		Return 1
	End If
ElseIf ls_editstyle = 'ddlb' Then
		// Add DropDownListBox entry into array.
		li_count = upperbound(istr_columns) +1
		istr_columns[li_count].s_editstyle	= ls_editstyle
		istr_columns[li_count].s_columnname = as_column	
		Return 1
End If	

// The column was not added.
Return 0
end function

public function integer of_getcolumn (ref string as_columns[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function: 		of_GetColumn
//
//	Access:  		public
//
//	Arguments:
//	as_columns[]	Columns names for which the service is providing dropdown 
//						search capabilities. (by reference)
//
//
//	Returns:  		integer
//						The number of entries in the returned array.
//
//	Description:  	This function returns the column names for which the service 
//						is providing dropdown search capabilities.
//
//////////////////////////////////////////////////////////////////////////////

Integer 	li_i
Integer	li_count
String	ls_empty[]

// Initialize string.
as_columns = ls_empty

// Get the number of entries on the internal array.
li_count = upperbound(istr_columns)
If li_count <=0 Then Return 0

// Loop around all entries and populate array with column names.
For li_i=1 To li_count
	as_columns[li_i] = istr_columns[li_i].s_columnname
Next

Return li_count 
end function

protected function integer of_searchitem (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SearchItem
//
//	Access:  		protected
//
//	Arguments:
//	as_column		column to serach for
//
//	Returns:  		integer
//						Index of array where column was found.
//						0 if not found
//						-1 if an error is encountered.
//
//	Description: 	This function is called to search the instance structure that
//						holds column information currently used by this service
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_count
Integer	li_i

// Check arguments
If IsNull(as_column) Or Len(Trim(as_column))=0 Then Return -1

// Get the size of the array.
li_count = upperbound(istr_columns)

// Check for an empty array.
if li_count <= 0 THEN return 0

// Find column name in array.
for li_i=1 TO li_count
	if istr_columns[li_i].s_columnname = as_column THEN
		// Column name was found.
		return li_i
	end if
next

// Column name not found in array.
return 0
end function

protected function integer of_DeleteItem (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		of_DeleteItem
//
//	Access:			protected
//
//	Arguments:
//	ai_index			index number 
//
//	Returns:  		Integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description: 	This function is called to remove a entry from the array.
//
//		*Note: 	Function will also repack the array.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_i, li_count
os_columns	lstr_columns[]

// Get the size of the array.
li_count = upperbound(istr_columns)

// Validate the argument.
If IsNull(ai_index) or ai_index <=0 or ai_index > li_count Then Return -1

// Copy from the begining to the entry prior the passed value.
If ai_index >= 2 Then
	For li_i=1 To ai_index -1
		lstr_columns[li_i] = istr_columns[li_i]	
	Next
End If	

// Also copy the rest of the array skipping the passed entry value.
If li_count > ai_index Then
	For li_i = ai_index +1 To li_count
		lstr_columns[li_i -1] = istr_columns[li_i]
	Next	
End If

// Store the new array on the instance variable.
istr_columns = lstr_columns
Return 1
end function

public subroutine of_setrequestor (u_dw adw);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetRequestor
//
//	Access: 			public
//
//	Arguments:		adw - The DataWindow used for DDDWs
//
//	Returns: 		None
//
//	Description:	Register the DataWindow to this NVO
//
//////////////////////////////////////////////////////////////////////////////

idw_requestor	=	adw

end subroutine

on n_cst_dwsrv_dropdownsearch.destroy
call super::destroy
end on

on n_cst_dwsrv_dropdownsearch.create
call super::create
end on

