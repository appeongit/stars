HA$PBExportHeader$n_cst_stars_rel.sru
$PBExportComments$Everything STARS_REL related <logic>
forward
global type n_cst_stars_rel from n_base
end type
end forward

global type n_cst_stars_rel from n_base autoinstantiate
end type

type variables
n_ds		ids_stars_rel
end variables

forward prototypes
public function string of_get_revenue (string as_inv_type)
public subroutine of_filter_rows (string ls_filter)
public function integer of_clear_filters ()
public function string of_get_string (string as_column_name)
public function string of_get_it_base_type (string as_inv_type)
public function string of_get_base_type (string as_inv_type)
public function boolean of_get_is_ub92 (string as_inv_type)
public function string of_get_ft_revenue (string as_inv_type)
public function boolean of_is_ancillary_type (string as_inv_type)
public function string of_get_invoice_types (string as_base_type)
public function boolean of_get_is_claims (string as_inv_type)
public function boolean of_get_is_ft_rev (string as_inv_type)
public function string of_get_main_from_ft_rev (string as_inv_type)
end prototypes

public function string of_get_revenue (string as_inv_type);//=================================================================================================//
// Non Visual Object:		n_cst_stars_rel
//	Function:					of_get_base_type
// Purpose:						Retrieves the REAL revenue type for main invoice type passed in as an argument.
// Input:						Header Invoice type			ex: CH
// Returns:						Revenue Invoice type			ex: CR
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//
//=================================================================================================//
string	ls_base_type, ls_filter
int		li_row

ls_filter = "REL_TYPE='IT' AND REL_ID='" + as_inv_type + "'"

this.of_filter_rows( ls_filter )

IF ids_stars_rel.rowcount( ) = 0 THEN
	MessageBox("Error","No rows in STARS_REL meeting criteria:~r~r" + ls_filter)
	RETURN "ERROR"
END IF

return this.of_get_string( "ID_2" )
end function

public subroutine of_filter_rows (string ls_filter);//=================================================================================================//
// Object:		n_cst_stars_rel
//	Function:	of_clear_filters
// Arguments:	ls_filter	String		Filter string
// Returns:		<None>
//=================================================================================================//
// Filters ids_stars_rel
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//=================================================================================================//
IF this.of_clear_filters( ) <> 1 THEN
	MessageBox("Error","Error resetting filters in n_cst_stars_rel")
END IF
	
IF ids_stars_rel.SetFilter(ls_filter) <> 1 THEN
	MessageBox("Error","Error setting filter in n_cst_stars_rel~r~r" + ls_filter)
END IF

ids_stars_rel.Filter()

end subroutine

public function integer of_clear_filters ();//=================================================================================================//
// Object:		n_cst_stars_rel
//	Function:	of_clear_filters
// Arguments:	None
// Returns:		Integer		1 = success, -1 = failure
//=================================================================================================//
// Removes any filters from ids_stars_rel
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//=================================================================================================//
ids_stars_rel.SetFilter("")
RETURN ids_stars_rel.Filter()
end function

public function string of_get_string (string as_column_name);
RETURN ids_stars_rel.GetItemString(1,as_column_name)
end function

public function string of_get_it_base_type (string as_inv_type);//=================================================================================================//
// Non Visual Object:		n_cst_stars_rel
//	Function:					of_get_base_type
// Purpose:						Retrieves the base type for the invoice type passed in as an argument.
// Input:						Invoice type				ex: CF
// Returns:						Invoice's base type		ex: 1500
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//
//=================================================================================================//
string	ls_base_type, ls_filter
int		li_row

ls_filter = "REL_TYPE='IT' AND REL_ID='" + as_inv_type + "'"

this.of_filter_rows( ls_filter )

IF ids_stars_rel.rowcount( ) = 0 THEN
	MessageBox("Error","No rows in STARS_REL meeting criteria:~r~r" + ls_filter)
	RETURN "ERROR"
END IF

return this.of_get_string( "VALUE_A" )
end function

public function string of_get_base_type (string as_inv_type);//=================================================================================================//
// Non Visual Object:		n_cst_stars_rel
//	Function:					of_get_base_type
// Purpose:						Retrieves the base type for the invoice type passed in as an argument.
// Input:						Invoice type				ex: CF
// Returns:						Invoice's base type		ex: 1500
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//
//=================================================================================================//
string	ls_base_type, ls_filter
int		li_row

ls_filter = "REL_TYPE='QT' AND ID_2='" + as_inv_type + "'"

this.of_filter_rows( ls_filter )

IF ids_stars_rel.rowcount( ) = 0 THEN
	MessageBox("Error","No rows in STARS_REL meeting criteria:~r~r" + ls_filter)
	RETURN "ERROR"
END IF

return this.of_get_string( "KEY6" )
end function

public function boolean of_get_is_ub92 (string as_inv_type);//=================================================================================================//
// Object:		n_cst_stars_rel
//	Function:	of_get_is_claims
// Arguments:	String		as_inv_type		Invoice type to check
// Returns:		Boolean		
//=================================================================================================//
// Determines if invoice type is a UB92 claim header table
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//=================================================================================================//
IF this.of_get_base_type( as_inv_type ) = "UB92" THEN
	RETURN TRUE
END IF

RETURN FALSE

end function

public function string of_get_ft_revenue (string as_inv_type);//=================================================================================================//
// Non Visual Object:		n_cst_stars_rel
//	Function:					of_get_base_type
// Purpose:						Retrieves the FastTrack revenue type for main invoice type passed in as an argument.
// Input:						Header Invoice type			ex: CH
// Returns:						Revenue Invoice type			ex: Q1
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//
//=================================================================================================//
string	ls_base_type, ls_filter
int		li_row

ls_filter = "REL_TYPE='IT' AND REL_ID='" + as_inv_type + "'"

this.of_filter_rows( ls_filter )

IF ids_stars_rel.rowcount( ) = 0 THEN
	MessageBox("Error","No rows in STARS_REL meeting criteria:~r~r" + ls_filter)
	RETURN "ERROR"
END IF

return this.of_get_string( "REL_MOD" )
end function

public function boolean of_is_ancillary_type (string as_inv_type);//=================================================================================================//
// Non Visual Object:		n_cst_stars_rel
//	Function:					of_is_ancillary_type
// Purpose:						Determines if the invoice type is ancillary.
// Input:						Invoice type		ex: PV
// Returns:						True if ancillary.
//=================================================================================================//
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//
//=================================================================================================//

String	ls_filter
ls_filter = "REL_TYPE='AN' AND REL_ID='" + as_inv_type + "'"

this.of_filter_rows( ls_filter )

Return ids_stars_rel.rowcount( ) > 0
end function

public function string of_get_invoice_types (string as_base_type);//=================================================================================================//
// Non Visual Object:		n_cst_stars_rel
//	Function:					of_get_invoice_types
// Purpose:						Retrieves the invoices type for the base type passed in as an argument.
// Input:						Base type		ex: 1500
// Returns:						Base type's invoices -	comma delimited
//=================================================================================================//
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//
//=================================================================================================//

string	ls_base_type, ls_filter, ls_inv_types, ls_inv_type
int		li_row, li_rows

ls_filter = "REL_TYPE='IT' AND VALUE_A='" + as_base_type + "'"

this.of_filter_rows( ls_filter )

li_rows = ids_stars_rel.rowcount( )
IF li_rows < 1 THEN
	MessageBox("Error","No rows in STARS_REL meeting criteria:~r~r" + ls_filter)
	RETURN "ERROR"
END IF

FOR li_row = 1 TO li_rows
	ls_inv_type = ids_stars_rel.GetItemString( li_row, "REL_ID")
	IF IsNull( ls_inv_type ) OR Trim( ls_inv_type ) = "" THEN
		MessageBox("Error","An invalid invoice type was detected for base type " + as_base_type)
		RETURN "ERROR"
	END IF
	ls_inv_types += "," + ls_inv_type
NEXT

// Remove the extra space
ls_inv_types = Mid( ls_inv_types, 2 )

Return ls_inv_types
end function

public function boolean of_get_is_claims (string as_inv_type);//=================================================================================================//
// Object:		n_cst_stars_rel
//	Function:	of_get_is_claims
// Arguments:	String		as_inv_type		Invoice type to check
// Returns:		Boolean		
//=================================================================================================//
// Determines if invoice type is for a claims table
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:			Description:
//	-----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//=================================================================================================//
this.of_filter_rows("REL_TYPE='IT' AND REL_ID='" + as_inv_type + "'")

IF ids_stars_rel.rowcount( ) > 0 THEN
	RETURN TRUE
END IF

RETURN FALSE

end function

public function boolean of_get_is_ft_rev (string as_inv_type);//=================================================================================================//
// Object:		n_cst_stars_rel
//	Function:	of_get_is_ft_rev
// Arguments:	String		as_inv_type		Invoice type to check
// Returns:		Boolean		
//=================================================================================================//
// Determines if invoice type is a FastTrack Revenue Type (ex: Q1)
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:		SPR:		Description:
//	-----	--------	-------	------------------------------------------------
//	MikeF	01/27/05				Created
//=================================================================================================//
this.of_filter_rows("REL_TYPE='IT' AND REL_MOD='" + as_inv_type + "'")

IF ids_stars_rel.rowcount( ) > 0 THEN
	RETURN TRUE
END IF

RETURN FALSE

end function

public function string of_get_main_from_ft_rev (string as_inv_type);//=================================================================================================//
// Object:		n_cst_stars_rel
//	Function:	of_get_main_from_ft_rev
// Arguments:	String		as_inv_type		FT Rev inv type
// Returns:		String		
//=================================================================================================//
// Returns the main inv type from a FastTrack Revenue Type (ex: Returns CH from Q1)
//=================================================================================================//
// Maintenance Log:
//
// By:	Date:		SPR:		Description:
//	-----	--------	-------	------------------------------------------------
//	MikeF	01/27/05				Created
//=================================================================================================//
this.of_filter_rows("REL_TYPE='IT' AND REL_MOD='" + as_inv_type + "'")

IF ids_stars_rel.rowcount( ) > 0 THEN
	return this.of_get_string( "REL_ID" )
END IF

RETURN " "

end function

event constructor;//*******************************************************************
// Non Visual Object:		n_cst_stars_rel
//	Event:						constructor
//
// Purpose:						Housekeeping when object created
//
// Input:						None
//
// Returns:						None
//
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		------------------------------------------------
//	MikeF	10/11/04		Created
//
//*******************************************************************

// Instantiate instance variable datastore, assign its dataobject
// and set the transaction object.

ids_stars_rel					=	CREATE n_ds
ids_stars_rel.DataObject	=	"d_stars_rel_dict"
ids_stars_rel.SetTransObject(Stars2ca)
ids_stars_rel.retrieve()

end event

event destructor;//*******************************************************************
// Non Visual Object:		n_cst_revenue
//
//	Event:						destructor
//
// Purpose:						Housekeeping when object destroyed
//
// Input:						None
//
// Returns:						None
//
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		------------------------------------------------
//	JGG	03/05/98		STARS 4.0 - TS145 n_cst_revenue
//	GaryR	08/29/02		Track 3284d	Database error
//
//*******************************************************************

// Destroy the instance variable datastore
DESTROY ids_stars_rel

end event

on n_cst_stars_rel.create
call super::create
end on

on n_cst_stars_rel.destroy
call super::destroy
end on

