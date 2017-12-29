$PBExportHeader$n_cst_revenue.sru
$PBExportComments$Retrieve Revenue Table Type using invoice type <logic>
forward
global type n_cst_revenue from n_base
end type
end forward

global type n_cst_revenue from n_base
end type
global n_cst_revenue n_cst_revenue

type variables
//n_ds		ids_revenue		//	GaryR	08/29/02		Track 3284d	Database error
end variables

forward prototypes
public function string of_get_base_type (string as_inv_type)
public function string of_get_main_table (string as_fasttrack_type)
public function string of_get_fasttrack_invoice (string as_inv_type)
public function string of_get_revenue (string as_inv_type)
end prototypes

public function string of_get_base_type (string as_inv_type);//*******************************************************************
// Non Visual Object:		n_cst_revenue
//
//	Function:					of_get_base_type
//
// Purpose:						Retrieves the base type for the invoice type 
//									passed in as an argument.
//
// Input:						Invoice type
//
// Returns:						Invoice's base type
//
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		------------------------------------------------
//	JGG	04/16/98		STARS 4.0 - TS145 n_cst_revenue
//
//*******************************************************************


string 	ls_base_type,	&
			ls_filter
			
long 		ll_filter_count

w_main.dw_stars_rel_dict.SetFilter("")  
w_main.dw_stars_rel_dict.Filter()
ls_filter = "rel_type = 'QT' and id_2 = '" + as_inv_type + "'"
w_main.dw_stars_rel_dict.SetFilter(ls_filter)
w_main.dw_stars_rel_dict.Filter()


ll_filter_count	=	w_main.dw_stars_rel_dict.RowCount()

IF	ll_filter_count	>	0		THEN
	ls_base_type	=	Upper(w_main.dw_stars_rel_dict.getitemstring(1,'key6'))
ELSE
	ls_base_type	=	''
END IF

return ls_base_type
end function

public function string of_get_main_table (string as_fasttrack_type);/////////////////////////////////////////////////////////////////////////////////////
// This is a copy of fx_fasttrack_invoice_type
//
// 11/27/95 HRB FastTrack Create
// 
// 09/08/09 FNC	Track 1611. Move global function FX_Fasttrack_Invoice type into this
//						NVO because it peforming interpretting fasttrack data
//
// Function filters dw_stars_rel_dict to get the 'real' main table type for
// the fasttrack type.
//
// rel_type = 'DP'
// rel_id = arg_fasttrack_type
// id_3 <> ''
//
// returns id_3 (string containing main table type)
// OR
// returns 'ERROR' if unable to filter dw or if more than one row in filter
/////////////////////////////////////////////////////////////////////////////////////

int li_rc
string ls_filter

li_rc	=	w_main.dw_stars_rel_dict.SetFilter("")
li_rc	=	w_main.dw_stars_rel_dict.Filter()
ls_filter =	"rel_type = 'DP' and rel_id = '"	+	as_fasttrack_type +	"'"&
			   + " and id_3 <> '' and id_3 <> '*'"
li_rc	=	w_main.dw_stars_rel_dict.SetFilter(ls_filter)
li_rc	=	w_main.dw_stars_rel_dict.Filter()
if w_main.dw_stars_rel_dict.RowCount() <> 1 then
	messagebox('ERROR','Error reading Stars_Rel for FastTrack Type in n_cst_reveneu.of_get_main_table')
	return 'ERROR'
else
	return w_main.dw_stars_rel_dict.GetItemString(1,'id_3')
end if


end function

public function string of_get_fasttrack_invoice (string as_inv_type);/////////////////////////////////////////////////////////////////////////////////////
// 05/25/00 FNC Created
// 
// Function filters dw_stars_rel_dict to get the Fasttrack Invoice Type that 
//	corresponds to the main invoice type.
//
/////////////////////////////////////////////////////////////////////////////////////

string 	ls_sel

w_main.dw_stars_rel_dict.SetFilter("")
w_main.dw_stars_rel_dict.Filter()
ls_sel = "rel_type = 'DP' and id_3 = '" + as_inv_type + "'"
w_main.dw_stars_rel_dict.SetFilter(ls_sel)
w_main.dw_stars_rel_dict.Filter()

if w_main.dw_stars_rel_dict.RowCount() <> 1 then
	messagebox('ERROR','Error reading Stars_Rel for FastTrack Type in n_cst_reveneu.of_get_fasttrack_invoice')
	return 'ERROR'
else
	return w_main.dw_stars_rel_dict.GetItemString(1,'REL_ID')
end if


end function

public function string of_get_revenue (string as_inv_type);//*******************************************************************
// Non Visual Object:		n_cst_revenue
//
//	Function:					of_get_revenue
//
// Purpose:						Retrieves the Table Type for the UB92
//									revenue table.
//
// Input:						Revenue Invoice Type
//
// Returns:						Revenue Table Type
//
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		------------------------------------------------
//	JGG	03/05/98		STARS 4.0 - TS145 n_cst_revenue
//
//	FDG	07/15/98		Track 1507.  If no rows found (i.e.  id_3 = 'CR')
//							then return '' and display no message.
//	GaryR	08/29/02		Track 3284d	Database error
//
//*******************************************************************

// Declare local variables

Long								ll_rc

//	GaryR	08/29/02	Track 3284d - Begin
//String							ls_sql
String							ls_rev_code

n_ds								lds_revenue
lds_revenue					=	CREATE n_ds
lds_revenue.DataObject	=	"d_revenue"
lds_revenue.SetTransObject(Stars2ca)

//// Create the SQL statement to retrieve the table type from the STARS_REL
//// table using the invoice type passed to the function.
//
////	Moved the SQL to the datawindow
//
//ls_sql						=	" SELECT ID_3 FROM STARS_REL "		&
//								+	" WHERE REL_TYPE = 'GP' "				&
//								+	" AND ID_2 = "								&
//								+	" (SELECT REL_ID  FROM STARS_REL"	&
//								+	" WHERE REL_TYPE = 'DP' "				&
//								+	" AND ID_3 = '"							&
//								+	  upper(as_inv_type)						&
//								+	"')"
//								
//ll_rc							=	ids_revenue.SetSQLSelect(ls_sql)
//
//If ll_rc < 1 Then
//	ErrorBox(Stars2ca,"Unable to set up to retrieve Revenue Table Type.")
//	RETURN ""
//End if

// FDG 07/15/98 begin

//ll_rc	=	ids_revenue.Retrieve()
ll_rc	=	lds_revenue.Retrieve( as_inv_type )
//	GaryR	08/29/02	Track 3284d - End

IF	ll_rc	<	1		THEN
	Return	""
END IF

//ids_revenue.Retrieve()
//
//If ll_rc < 1 Then
//	ErrorBox(Stars2ca,"Unable to retrieve Revenue Table Type.")
//	RETURN ""
//End if

// FDG 07/15/98 end

//	GaryR	08/29/02	Track 3284d - Begin
//RETURN	ids_revenue.object.id_3[1]
ls_rev_code	=	lds_revenue.object.id_3[1]
Destroy	lds_revenue

Return	ls_rev_code
//	GaryR	08/29/02	Track 3284d - End
end function

event constructor;//*******************************************************************
// Non Visual Object:		n_cst_revenue
//
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
//	JGG	03/05/98		STARS 4.0 - TS145 n_cst_revenue
//	GaryR	08/29/02		Track 3284d	Database error
//
//*******************************************************************

// Instantiate instance variable datastore, assign its dataobject
// and set the transaction object.

//	GaryR	08/29/02	Track 3284d - Begin
//ids_revenue					=	CREATE n_ds
//
//ids_revenue.DataObject	=	"d_revenue"
//
//ids_revenue.SetTransObject(Stars2ca)
//	GaryR	08/29/02	Track 3284d - End
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

//	GaryR	08/29/02	Track 3284d
//DESTROY ids_revenue

end event

on n_cst_revenue.create
call super::create
end on

on n_cst_revenue.destroy
call super::destroy
end on

