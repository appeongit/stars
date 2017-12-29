$PBExportHeader$n_cst_trim.sru
$PBExportComments$Data trimming service (inherited from n_base) <logic>
forward
global type n_cst_trim from n_base
end type
end forward

global type n_cst_trim from n_base
event type integer ue_retrieveend ( long al_rowcount )
event type integer ue_preupdate ( )
end type
global n_cst_trim n_cst_trim

type variables

Protected:

// Number of columns in the datawindow
Long	il_columns

// String array of flags stating whether or not to trim a column
// There will be an entry for every column which will = 'N' or 'Y'
String	is_trim[]

// String array of column names contained in this datawindow
String	is_column[]

// The datawindow or datastore used to trim the data.
PowerObject	ipo_requestor

end variables

forward prototypes
public subroutine of_setrequestor (u_dw adw_requestor)
public subroutine of_setrequestor (n_ds ads_requestor)
public function integer of_getcolumnstotrim ()
end prototypes

event type integer ue_retrieveend(long al_rowcount);//////////////////////////////////////////////////////////////////////////////
//
//	Script:  		ue_retrieveend
//
//	Access:   		Public
//
//	Arguments:		1.	al_rowcount - The # of rows retrieved
//		
//
//	Returns:  		Integer
//						 1 for success.
//						-1 for error.
//
//	Description:  
//		This event is triggered when the data is retrieved.  This event will loop 
//		thru all rows retrieved and trim any character data.  This may be required
//		because Oracle interprets an empty string as null.  As a result, a single
//		blank may be retrieved from the database which will require trimming.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	FDG	04/12/01	Stars 4.7.	Created.
//	GaryR	07/13/01	Track 2365d	Make trimming of data DBMS independent.
//	GaryR	07/05/02	Track 2754d	Fix trimming bug.
// Jason 11/25/02 Track 3374d	Turn redraw off/on for performance
//	GaryR	01/30/03	Track 3423d	Jason added the checks for u_dw that were causing 
//										the unrecoverable error reported in this Track.
//										I changed code to set redrawing back on at the end.
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_row_changed

Integer		li_rc

Long			ll_row,			&
				ll_rowcount,	&
				ll_column

String		ls_value,		&
				ls_trim_value

if ipo_requestor.classname() = 'u_dw' then
	ipo_requestor.Dynamic SetRedraw(False) // JasonS 11/26/02 Track 3374d
end if

IF	il_columns	=	0		THEN
	// Determine which columns to trim by setting is_trim[]
	li_rc	=	This.of_GetColumnsToTrim()
END IF

ll_rowcount		=	ipo_requestor.Dynamic RowCount()

// Trim the data
FOR	ll_row	=	1	TO	ll_rowcount
	lb_row_changed		=	FALSE
	FOR	ll_column	=	1	TO	il_columns
		IF	is_trim [ll_column]	<>	'Y'	THEN
			// The column is not trimable - get the next column
			Continue
		END IF
		// Trim the column
		ls_value	=	ipo_requestor.Dynamic GetItemString(ll_row, ll_column)
		//	GaryR	07/13/01	Track 2365d
		//ls_trim_value	=	Trim (ls_value)
		//	GaryR	07/05/02	Track 2754d - Begin
		//gnv_sql.of_TrimData (ls_value)
		ls_trim_value	=	ls_value
		gnv_sql.of_TrimData (ls_trim_value)
		//	GaryR	07/05/02	Track 2754d - End
		IF	ls_value	<>	ls_trim_value		THEN
			lb_row_changed		=	TRUE
			ipo_requestor.Dynamic SetItem (ll_row, ll_column, ls_trim_value)
			// Set the column and row status to notmodified
			li_rc	=	ipo_requestor.Dynamic SetItemStatus (ll_row, ll_column, Primary!, NotModified!)
		END IF
	NEXT
	IF	lb_row_changed		THEN
		li_rc	=	ipo_requestor.Dynamic SetItemStatus (ll_row, 0, Primary!, NotModified!)
	END IF
NEXT

if ipo_requestor.classname() = 'u_dw' then
	ipo_requestor.Dynamic SetRedraw(TRUE) // JasonS 11/26/02 Track 3374d
end if

Return	1


end event

event type integer ue_preupdate();//////////////////////////////////////////////////////////////////////////////
//
//	Script:  		ue_preupdate
//
//	Access:   		Public
//
//	Arguments:		None
//
//	Returns:  		Integer
//						 1 for success.
//						-1 for error.
//
//	Description:  
//		This event is triggered when the data is being updated.  This event will loop 
//		thru all changed rows and trim any character data.  This may be required
//		because Oracle interprets an empty string as null.  As a result, an empty string
//		may require changeing to a ' ' and a value containing trailing spaces will
//		need to be trimmed.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	FDG	04/12/01	Stars 4.7.	Created.
// JasonS 11/26/02 Track 3374d  turn redraw off/on for performance
//////////////////////////////////////////////////////////////////////////////

Integer		li_rc

Long			ll_row,			&
				ll_column

String		ls_value

IF	il_columns	=	0		THEN
	// Determine which columns to trim by setting is_trim[]
	li_rc	=	This.of_GetColumnsToTrim()
END IF

if ipo_requestor.classname() = 'u_dw' then
	ipo_requestor.Dynamic SetRedraw(False) // JasonS 11/26/02 Track 3374d
end if

// For each changed row, trim the data
ll_row	=	ipo_requestor.Dynamic GetNextModified (ll_row, Primary!)

DO WHILE	ll_row	<>	0
	FOR	ll_column	=	1	TO	il_columns
		IF	is_trim [ll_column]	<>	'Y'	THEN
			// The column is not trimable - get the next column
			Continue
		END IF
		// Trim the column - if it changed
		IF	ipo_requestor.Dynamic GetItemStatus (ll_row, ll_column, Primary!)	<>	DataModified!	THEN
			// Column not changed - get the next column
			Continue
		END IF
		// Trim the value and it may have to set the value to ' ' if empty.
		ls_value	=	ipo_requestor.Dynamic GetItemString(ll_row, ll_column)
		li_rc		=	gnv_sql.of_TrimData (ls_value)
		ipo_requestor.Dynamic SetItem (ll_row, ll_column, ls_value)
	NEXT
	ll_row	=	ipo_requestor.Dynamic GetNextModified (ll_row, Primary!)
LOOP

if ipo_requestor.classname() = 'u_dw' then
	ipo_requestor.Dynamic SetRedraw(True) // JasonS 11/26/02 Track 3374d
end if

Return	1


end event

public subroutine of_setrequestor (u_dw adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor - Overrides ancestor function
//
//	Access:    Public
//
//	Arguments:
//   adw_Requestor   The datawindow requesting the service
//
//	Returns:  None
//
//	Description:  Associates a datawindow control with a datawindow service NVO
//			        by setting the ipo_Requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////

ipo_Requestor	=	adw_Requestor

end subroutine

public subroutine of_setrequestor (n_ds ads_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor - Overrides ancestor function
//
//	Access:    Public
//
//	Arguments:
//   ads_Requestor   The datastore requesting the service
//
//	Returns:  None
//
//	Description:  Associates a datastore with a datawindow service NVO
//			        by setting the ipo_Requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////

ipo_Requestor	=	ads_Requestor

end subroutine

public function integer of_getcolumnstotrim ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetColumnsToTrim
//
//	Access:   		Public
//
//	Arguments:		None	
//
//	Returns:  		Integer
//						 1 for success.
//						-1 for error.
//
//	Description:  
//		Determine which columns in the datawindow to trim.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	FDG	04/12/01	Stars 4.7.	Created.
//
//////////////////////////////////////////////////////////////////////////////

Constant	String	lcs_no_trim	=	';NOTRIM;'

String	ls_describe,			&
			ls_tag,					&
			ls_colname,				&
			ls_coltype,				&
			ls_empty[]

Long		ll_col

Integer	li_pos

// Reset the array of trimmed columns
is_trim		=	ls_empty
is_column	=	ls_empty

il_columns	=	Long ( ipo_requestor.Dynamic Describe("DataWindow.Column.Count") )

FOR	ll_col	=	1	TO	il_columns
	is_trim [ll_col]	=	'N'		// Initialize to 'No'
	ls_colname			=	ipo_requestor.Dynamic Describe ("#" + String(ll_col) + ".Name")
	ls_tag				=	ipo_requestor.Dynamic Describe (ls_colname	+	".Tag")
	li_pos				=	Pos (ls_tag, lcs_no_trim)
	is_column[ll_col]	=	ls_colname
	IF	li_pos			>	0			THEN
		// Notrim found for the column, don't trim it
		Continue
	ELSE
		ls_coltype	=	Upper ( ipo_requestor.Dynamic Describe (ls_colname	+	".ColType") )
		IF	Left ( Trim (ls_coltype), 4 )	=	'CHAR'		THEN
			is_trim [ll_col]	=	'Y'
		END IF
	END IF
NEXT

Return	1

end function

on n_cst_trim.create
call super::create
end on

on n_cst_trim.destroy
call super::destroy
end on

