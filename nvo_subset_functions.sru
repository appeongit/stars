HA$PBExportHeader$nvo_subset_functions.sru
$PBExportComments$This non visual object will consist of a datastore, that will be linked to multiple dataobjects, and multiple functions that access the case link table and sub_cntl table. (inherited from n_base) <logic>
forward
global type nvo_subset_functions from n_base
end type
end forward

global type nvo_subset_functions from n_base
end type
global nvo_subset_functions nvo_subset_functions

type variables
//Public:

// Delete access constants
constant int	ici_allow	 	 	= 0
constant int	ici_case_closed 	= 1
constant int	ici_case_referred	= 2
constant int	ici_not_owner 		= 3
constant int	ici_pdq_link	 	= 4
constant int	ici_pdr_link		= 5
constant int	ici_bg_job 			= 6

// Delete access messages
string isi_access_msg[] = {'Case is closed', 	&
                           'Case was referred',	&
									'Not subset owner',	&
									'Used in PDQ ',		&
									'Used in PDR Query ',&
									'Used in pending subset job '}

// Datastores
n_ds 				ids_1, ids_pdq_tables, ids_bg_step_cntl

// Subset structure
sx_subset_ids 	istr_subset_ids


end variables

forward prototypes
public function integer uf_set_structure (sx_subset_ids astr_subset_ids)
public function sx_subset_ids uf_get_structure ()
public function integer uf_check_if_source_subset ()
public function integer uf_retrieve_subset_id ()
public function integer uf_select_links_using_subset_name ()
public function integer uf_select_links_using_subset_id ()
public function integer uf_determine_case_security (string as_case_id)
public function integer uf_delete_subc_track_info (string as_target_id)
public function integer uf_retrieve_subset_name ()
public function integer uf_isvalid_subset (string as_subset, character as_parm_type)
public function integer uf_delete_subc_target_info ()
public function integer uf_delete_subset ()
public function integer uf_target_chk_msg (string as_called_from, string as_case_id, string as_case_spl, string as_case_ver)
public subroutine uf_retrieve_datastores ()
public function integer uf_get_delete_access (string as_subset_name, string as_case_key, ref string as_object_name)
public function integer uf_post_rename (string as_old_name, string as_new_name, string as_case_id, string as_case_spl, string as_case_ver)
end prototypes

public function integer uf_set_structure (sx_subset_ids astr_subset_ids);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	uf_set_structure							nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Assign the argument astr_subset_id to instance istr_subset_id.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		Value			astr_subset_id	sx_subset_id		Subset ID structure.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success			
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/05/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

istr_subset_ids = astr_subset_ids

RETURN 1
end function

public function sx_subset_ids uf_get_structure ();/////////////////////////////////////////////////////////////////////////////
// Event/Function							Object				
//	--------------							------				
//	uf_get_structure				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype			Value					Description
//		--------			-----					-----------
//		sx_subset_ids	ISTR_subset_ids				
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	Naomi				12/29/97		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Return ISTR_Subset_Ids
end function

public function integer uf_check_if_source_subset ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	uf_check_if_source_subset				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
//                0           Subset ID not found; not a source subset
//                -1          Unsuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	Anne-s			06/02/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

integer li_rows, li_rc

SetPointer(HourGlass!)

istr_subset_ids.Subset_ID = trim(istr_subset_ids.Subset_ID)

if istr_subset_ids.Subset_ID = '' then
	messagebox('Error','Subset id not provided.~r' +&
					'Cannot delete since cannot verify links')
	Return -1
End if


IDS_1.dataobject = 'D_sub_cntl_with_sub_src_Id'


li_rc = IDS_1.SetTransObject(stars2ca)  

if li_rc <> 1 then
	messagebox('Error','Cannot delete subset. ' +&
					'Cannot verify links to subset id. ~rError in SetTransObject')
	return -1
end if

li_rows = IDS_1.Retrieve(istr_subset_ids.Subset_ID)

if li_rows = 0 then
	return 0
elseif li_rows < 0 then
	messagebox('Error', 'Error retrieving Step Cntl using subset id~rto verify job links. Cannot delete subset.')
	Return -1
else 
	Return li_rows
end if

end function

public function integer uf_retrieve_subset_id ();/////////////////////////////////////////////////////////////////////////////
// Event/Function							Object				
//	--------------							------				
//	uf_retrieve_subset_id				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success		
//                0           Subset ID not found
//                -1          Unsuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/05/97		Created.
//	FDG		04/16/01		Stars 4.7.	Account for empty string in case_spl, case_ver.
//	GaryR		11/16/04		Track	4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

long ll_rows
integer li_rc

istr_subset_ids.Subset_Name = trim(istr_subset_ids.Subset_Name)
istr_subset_ids.subset_Case_ID = trim(istr_subset_ids.subset_Case_ID)
istr_subset_ids.subset_Case_Spl = trim(istr_subset_ids.subset_Case_Spl)
istr_subset_ids.subset_Case_Ver = trim(istr_subset_ids.subset_Case_Ver)

if istr_subset_ids.Subset_Name = '' then
	messagebox('Error','Cannot retrieve subset ID, subset name not provided')
	Return -1
End if

if istr_subset_ids.subset_Case_ID = '' then
	messagebox('Error','Cannot retrieve subset ID, case id not provided')
	Return -1
End if

If istr_subset_ids.subset_Case_ID = 'NONE' then		//ajs 4.0 2-11-98
	//bypass case ver & spl check							//ajs 4.0 2-11-98
else																//ajs 4.0 2-11-98
	if istr_subset_ids.subset_Case_Ver = '' then
		messagebox('Error','Case_Ver not provided. ~rCannot delete since cannot verify links')
		Return -1
	End if
	if istr_subset_ids.subset_Case_Spl = '' then
		messagebox('Error','Case Spl not provided. ~rCannot delete since cannot verify links')
		Return -1
	End if
End If															//ajs 4.0 2-11-98

ids_1.dataobject = 'D_List_Case_Link_With_Subset_Name_CaseId'

li_rc = ids_1.SetTransObject(stars2ca)


if li_rc <> 1 then
	messagebox('Error','Cannot retrieve subset ID. Error in SetTransObject~r'+&
					'SQLErrText = ' + SQLCA.SQLErrText)
	return -1
end if

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (istr_subset_ids.subset_case_spl)
li_rc	=	gnv_sql.of_TrimData (istr_subset_ids.subset_case_ver)
// FDG 04/16/01 - end

ll_rows = ids_1.Retrieve(istr_subset_ids.Subset_Name, istr_subset_ids.subset_Case_Id, &
	istr_subset_ids.subset_Case_Spl,istr_subset_ids.subset_Case_Ver)

if ll_rows < 0 then
	messagebox('Error', 'Error retrieving subset ID')
	Return -1
elseif ll_rows > 1 then
	messagebox('Error','Cannot retrieve subset ID. ~rMore than one subset ID identified')
	return -1
elseif ll_rows = 0 then
//	messagebox('Error','Subset name not found on case link table')
	return 0
else
	istr_subset_ids.Subset_ID = ids_1.GetItemString(1,'Link_KEY')
	istr_subset_ids.subset_desc = ids_1.GetItemString(1,'link_desc')
	return 1
end if
end function

public function integer uf_select_links_using_subset_name ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	uf_select_links_using_subset_name	nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		#				number of rows	> 1 is usually an error
//                0           Subset Name not found on case link
//                -1          Unsuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	J.Mattis	12/05/97		Created.
//	FDG		04/16/01		Stars 4.7.	Account for empty string in case_spl, case_ver.
//	GaryR		11/16/04		Track	4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

integer li_rc, li_rows

istr_subset_ids.Subset_Name = trim(istr_subset_ids.Subset_Name)

if istr_subset_ids.Subset_Name = '' then
	messagebox('Error','Cannot retrieve case link with subset name.~rSubset name not provided')
	Return -1
End if

IDS_1.dataobject = 'D_List_Case_Link_With_Subset_Name'


li_rc = IDS_1.SetTransObject(stars2ca) 

if li_rc <> 1 then
	messagebox('Error','Cannot verify links to subset name. ~rError in SetTransObject')
	return -1
end if

li_rows = ids_1.Retrieve(istr_subset_ids.Subset_Name)

if li_rows < 0 then
	messagebox('Error', 'Error retrieving Case_Link using subset name')
	Return -1
elseif li_rows = 0 then
//	messagebox('Error','Subset id not found on case link table',Stopsign!)
	return 0
elseif li_rows = 1 then
	istr_subset_ids.Subset_ID = ids_1.GetItemString(1,'Link_key')
	istr_subset_ids.Subset_Case_ID = ids_1.GetItemString(1,'Case_ID')
	istr_subset_ids.Subset_Case_Spl = Trim (ids_1.GetItemString(1,'Case_Spl') )	// FDG 04/16/01
	istr_subset_ids.Subset_Case_Ver = Trim (ids_1.GetItemString(1,'Case_Ver') )	// FDG 04/16/01
	istr_subset_ids.subset_desc = ids_1.GetItemString(1,'link_desc')
end if

Return li_rows
end function

public function integer uf_select_links_using_subset_id ();/////////////////////////////////////////////////////////////////////////////
// Event/Function							Object				
//	--------------							------				
//	uf_select_links_using_subset_id	nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		#				Number of Rows, > 1 is usually an error
//                0           Subset ID not found on case link
//                -1          Unsuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	Naomi		12/29/97		Created.
//	FDG		04/16/01		Stars 4.7.	Account for empty string in case_spl, case_ver.
//
/////////////////////////////////////////////////////////////////////////////

integer li_rc, li_rows

SetPointer(HourGlass!)

istr_subset_ids.Subset_ID = trim(istr_subset_ids.Subset_ID)

if istr_subset_ids.Subset_ID = '' then
	messagebox('Error','Cannot retrieve case link with subset ID.~r Subset id not provided')
	Return -1
End if

IDS_1.dataobject = 'D_List_Case_Link_With_Subset_Id'


li_rc = IDS_1.SetTransObject(stars2ca) 
if li_rc <> 1 then
	messagebox('Error','Cannot retrieve links to subset id. Error in SetTransObject')
	return -1
end if

li_rows = IDS_1.Retrieve(istr_subset_ids.Subset_ID)

if li_rows < 0 then
	messagebox('Error', 'Error retrieving Case_Link using subset ID')
	Return -1
elseif li_rows = 0 then
//	messagebox('Error','Subset id not found on case link table')
	return 0
elseif li_rows = 1 then
	istr_subset_ids.Subset_Name = ids_1.GetItemString(1,'Link_Name')
	istr_subset_ids.Subset_Case_ID = ids_1.GetItemString(1,'Case_ID')
	istr_subset_ids.Subset_Case_Spl = Trim (ids_1.GetItemString(1,'Case_Spl') )	// FDG 04/16/01
	istr_subset_ids.Subset_Case_Ver = Trim (ids_1.GetItemString(1,'Case_Ver') )	// FDG 04/16/01
end if

Return li_rows

end function

public function integer uf_determine_case_security (string as_case_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	uf_determine_case_security				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		value			as_case_id	string
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		-1				UnSuccessful		
//                100         Access denied
//                 0          Access permitted
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
// A.Sola         02/26/98    Add code to skip security check if case id=NONE
//	J.Mattis			12/05/97		Created.
//	NLG				08-11-99		Replace this w/call to n_cst_case::uf_edit_case_security
//	FDG				12/21/01		Track 2497.  Declare n_cst_case as a local to remove memory leaks.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

String ls_case_id, ls_case_spl, ls_case_ver
String ls_dept_code
String ls_msg
Integer li_rc, li_rows, li_code_sec

n_cst_case		lnv_case				// FDG 12/21/01

//Edit the arguments

as_case_id = trim(as_case_id)

if as_case_id = '' OR IsNull(as_case_id) then
	messagebox('Error','Case id not provided. Cannot verify security')
	Return -1
End if

If trim(as_case_id) = "NONE" then	//ajs 4.0 02-26-98
	return 0									//ajs 4.0 02-26-98
End If										//ajs 4.0 02-28-98

ls_case_id = left(as_case_id,10)
ls_case_spl = mid(as_case_id,11,2)
ls_case_ver = mid(as_case_id,13,2)	//ajs 4.0 03-11-98 fix case split


//NLG 08-11-99 Replace this with call to n_cst_case::uf_edit_case_security
//ids_1.dataobject = 'D_Case_Cat_Dept'
//
//li_rc = ids_1.SetTransObject(stars2ca)	
//
//if li_rc <> 1 then
//	messagebox('Error','Cannot verify security. Error in SetTransObject')
//	return -1
//end if
//
////Retrieve the datastore
//li_rows = ids_1.Retrieve(ls_case_id,ls_case_spl,ls_case_ver)
//
//if li_rows < 1 then
//	messagebox('Error', 'Case category not found on code table. ~rCannot verify security')
//	Return -1
//elseif li_rows > 1 then
//	messagebox('Error', 'More than one record for case category ~rfound on code table. Cannot verify security')
//	Return -1
//end if
//
//ls_dept_code = ids_1.getitemstring(1,'code_code_value_a')
//li_code_sec = ids_1.getitemnumber(1,'code_code_value_n')
//
//If ls_dept_code <> gc_user_dept then
//	If li_code_sec = 1 Then
//		Return 100
//	else
//		Return 0
//	end if
//else
//	return 0
//end if

// FDG 12/21/01 - use lnv_case instead of inv_case
lnv_case		=	CREATE	n_cst_case
//IF Not IsValid (inv_case)  THEN
//	inv_case  =  CREATE  n_cst_case
//END IF

Ls_msg  =  lnv_case.uf_edit_case_security(ls_case_id, ls_case_spl, ls_case_ver)

Destroy	lnv_case			// FDG 12/21/01

IF  Len(ls_msg)  >  0  THEN
	Return 100
ELSE
	Return 0
END IF


end function

public function integer uf_delete_subc_track_info (string as_target_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// fx_delete_subc_track_info				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Delete info from track records info
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    Value       Target ID			String
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Successful
//                1				UnSuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
// ajs      02/04/98    4.0 TS145- globals fixed
//	A.Sola	01/20/98		Updated.
//	FDG		02/15/02		Track 2378d.  Legitimate to retrieve 0 rows from ids_1.
//	GaryR		08/07/02		Track 3243d	Create log entry for each deleted track
// Katie		01/20/05		Track 3741d Removed logic to determine if track associated with more
//								than one target.  Added target_id to delete statements for track and track_log.
//
/////////////////////////////////////////////////////////////////////////////
Integer lv_count, li_rc
String Lv_target_key
long ll_row, ll_num_rows

//	GaryR	08/07/02	Track 3243d - Begin
String		ls_message
n_cst_case	lnv_case
lnv_case		=	CREATE	n_cst_case
//	GaryR	08/07/02	Track 3243d - End

//Removed call of user object function because it resets the structure //ajs 07-13-98
IDS_1.dataobject = 'd_targets'

li_rc = IDS_1.SetTransObject(stars2ca) 
if li_rc <> 1 then
	Destroy	lnv_case			//	GaryR	08/07/02	Track 3243d
	messagebox('Error','Cannot retrieve links to subset id. Error in SetTransObject')	
	return -1				
end if

ll_num_rows = IDS_1.Retrieve(istr_subset_ids.subset_case_id,istr_subset_ids.subset_case_spl,istr_subset_ids.subset_case_ver,as_target_id)
//ajs 07-13-98 end
if ll_num_rows < 1 then
	Destroy	lnv_case			//	GaryR	08/07/02	Track 3243d
	//MessageBox("Delete Error","Error retrieving track keys.")		// FDG 02/15/02
	return 0					// FDG 02/15/02
end if

For ll_row = 1 to ll_num_rows
		
		lv_target_key = IDS_1.Object.Trgt_key[ll_row]

		Delete from track 
			where Case_id  = Upper( :istr_subset_ids.subset_case_id ) and
					case_spl = Upper( :istr_subset_ids.subset_case_spl ) and
					case_ver = Upper( :istr_subset_ids.subset_case_ver ) and
					trk_key  = Upper( :lv_target_key ) and
					target_id = Upper( :as_target_id )
		Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			Messagebox('EDIT','Track Record not Found for ' + lv_target_key)
		Elseif Stars2ca.sqlcode <> 0 then
			 Destroy	lnv_case			//	GaryR	08/07/02	Track 3243d
			 Errorbox(Stars2ca,'Error Deleting from Track Table')
			 RETURN -1
		End If

		Delete from track_log 
			where Case_id  = Upper( :istr_subset_ids.subset_case_id ) and
					case_spl = Upper( :istr_subset_ids.subset_case_spl ) and
					case_ver = Upper( :istr_subset_ids.subset_case_ver ) and
					trk_key  = Upper( :lv_target_key ) and
					target_id = Upper( :as_target_id )
		Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			Messagebox('EDIT','Track Log not found for ' + lv_target_key)
		Elseif Stars2ca.sqlcode <> 0 then
			 Destroy	lnv_case			//	GaryR	08/07/02	Track 3243d
			 Errorbox(Stars2ca,'Error Deleting from Log Table')
			 RETURN -1
		End If
		
		//	GaryR	08/07/02	Track 3243d - Begin		
		ls_message	=	"Track "	+	lv_target_key +	" removed."
		
		li_rc			=	lnv_case.uf_audit_log ( istr_subset_ids.subset_case_id, &
															istr_subset_ids.subset_case_spl, &
															istr_subset_ids.subset_case_ver, &
															ls_message )
		
		IF	li_rc		<	0		THEN
			Stars2ca.of_rollback()
			MessageBox ('Database Error', 'Could not insert case log for Track '	+	lv_target_key	+	&
							'.  Case: ' + istr_subset_ids.subset_case_id + &
							istr_subset_ids.subset_case_spl + &
							istr_subset_ids.subset_case_ver + '.~n~rScript: '		+	&
							'nvo_subset_functions.uf_delete_subc_track_info')
			Destroy	lnv_case
			Return	-1
		END IF		
		//	GaryR	08/07/02	Track 3243d - End
Next

//	GaryR	08/07/02	Track 3243d
IF IsValid( lnv_case ) THEN Destroy	lnv_case

Return 1
end function

public function integer uf_retrieve_subset_name ();/////////////////////////////////////////////////////////////////////////////
// Event/Function							Object				
//	--------------							------				
//	uf_retrieve_subset_name				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		1				Success	
//                0           Subset Name not found
//                -1          Unsuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	Naomi		12/29/97		Created.
//	FDG		04/16/01		Stars 4.7.	Account for empty string in case_spl, case_ver.
//	GaryR		11/03/01		Track 2528d	"Save As" subsets appear more than once.
//	FDG		12/11/01		Track 2471d Do not use gc_active_subset_name as a retrieval
//								argument when getting subset name.
// MikeFl 	08/08/02 	2822d		Removing redundant data object D_List_Case_Link_With_Subset_Id_Case_Id2, 
//											now that I fixed the original
//	GaryR		11/16/04		Track	4115d	STARS Reporting - Claims PDRs
//
/////////////////////////////////////////////////////////////////////////////

long ll_rows
integer li_rc

SetPointer(HourGlass!)

istr_subset_ids.Subset_ID = trim(istr_subset_ids.Subset_ID)
istr_subset_ids.Subset_Case_ID = trim(istr_subset_ids.Subset_Case_ID)
istr_subset_ids.Subset_Case_Spl = trim(istr_subset_ids.Subset_Case_Spl)
istr_subset_ids.subset_Case_Ver = trim(istr_subset_ids.subset_Case_Ver)

if istr_subset_ids.Subset_ID = '' then
	messagebox('Error','Cannot retrieve subset name, subset id not provided')
	Return -1
End if

if istr_subset_ids.Subset_Case_ID = '' then
	messagebox('Error','Cannot retrieve subset name, case id not provided')
	Return -1
End if

If istr_subset_ids.subset_Case_ID = 'NONE' then		//ajs 4.0 2-11-98
	//bypass case ver & spl check							//ajs 4.0 2-11-98
else																//ajs 4.0 2-11-98
	if istr_subset_ids.subset_Case_Ver = '' then
		messagebox('Error','Error retrieving subset name.  Case_Ver not provided.')
		Return -1
	End if
	if istr_subset_ids.subset_Case_Spl = '' then
		messagebox('Error','Error retrieving subset name.  Case Spl not provided.')
		Return -1
	End if
End If															//ajs 4.0 2-11-98


// MikeFl 8/8/02 - Removing redundant data object D_List_Case_Link_With_Subset_Id_Case_Id2, now that I fixed the original
//IDS_1.dataobject = 'D_List_Case_Link_With_Subset_Id_Case_Id'		// FDG 12/11/01
//IDS_1.dataobject = 'D_List_Case_Link_With_Subset_Id_Case_Id2'		// FDG 12/11/01
IDS_1.dataobject = 'D_List_Case_Link_With_Subset_Id_Case_Id'


li_rc = IDS_1.SetTransObject(stars2ca) 

if li_rc <> 1 then
	messagebox('Error','Cannot retrieve subset name. Error in SetTransObject')
	return -1
end if

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (istr_subset_ids.subset_case_spl)
li_rc	=	gnv_sql.of_TrimData (istr_subset_ids.subset_case_ver)
// FDG 04/16/01 - end

// FDG 12/11/01 begin
//ll_rows = IDS_1.Retrieve(istr_subset_ids.Subset_Id, istr_subset_ids.Subset_Case_Id, &
//	istr_subset_ids.Subset_Case_Spl, istr_subset_ids.Subset_Case_Ver, gc_active_subset_name)	//	GaryR	11/03/01	Track 2528d
ll_rows = IDS_1.Retrieve(istr_subset_ids.Subset_Id, istr_subset_ids.Subset_Case_Id, &
	istr_subset_ids.Subset_Case_Spl, istr_subset_ids.Subset_Case_Ver)	
// FDG 12/11/01 end

if ll_rows < 0 then
	messagebox('Error', 'Error retrieving subset name')
	Return -1
elseif ll_rows > 1 then
	messagebox('Error','Cannot retrieve subset name. ~rMore than one subset name identified')
	return -1
elseif ll_rows = 0 then
//	messagebox('Error','Subset id not found on case link table')
	return 0
else
	istr_subset_ids.Subset_Name = Ids_1.GetItemString(1,'Link_Name')
	istr_subset_ids.subset_desc = ids_1.GetItemString(1,'link_desc')
	return 1
end if

end function

public function integer uf_isvalid_subset (string as_subset, character as_parm_type);////////////////////////////////////////////////////////////////////////////////////
// Function:	nvo_subset_functions.uf_isvalid_subset
// Purpose:  To determine if the subset id/name passed in exits (isvalid)
//
// Input Parameters:		as_subset - subset name or id to be checked
//								as_parm_type - Either an 'N' or an 'I' signifies if the 
//													as_subset is a name ('N') or an id ('I')
//
//	Return Codes:	0 - Valid Subset
//					  -1 - Invalid Subset
//
////////////////////////////////////////////////////////////////////////////////////
// Change History
////////////////////////////////////////////////////////////////////////////////////
// JasonS 08/27/02	Created.
////////////////////////////////////////////////////////////////////////////////////

string ls_subset_id

choose case as_parm_type
	case 'I'
		select subc_id
		into :ls_subset_id
		from sub_cntl
		where subc_id = :as_subset
		using stars2ca;
	case 'N'
		select subc_id
		into :ls_subset_id
		from sub_cntl
		where subc_desc = :as_subset
		using stars2ca;
	case else
		Return -1
end choose

if (trim(ls_subset_id) <> '') AND (not isnull(ls_subset_id)) then
	Return 0
else
	Return -1
end if

end function

public function integer uf_delete_subc_target_info ();string ls_delete_target
integer li_rc
string ls_target_key, ls_message // JasonS 09/09/02 Track 3226d
n_cst_case lnv_case // JasonS 09/09/02 Track 3226d

lnv_case = create n_cst_case // JasonS 09/09/02 Track 3226d

//Check if Target Information for subset exists

		Select trgt_id into :ls_delete_target
				from target_cntl
				where Case_id = Upper( :ISTR_Subset_Ids.Subset_Case_ID ) and
						case_spl = Upper( :ISTR_Subset_Ids.Subset_Case_Spl ) and 
						case_ver = Upper( :ISTR_Subset_Ids.Subset_Case_Ver ) and
						Subc_id  = Upper( :ISTR_Subset_Ids.Subset_ID )	
				Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return 1
			End If	
			Return 1
		Elseif Stars2ca.sqlcode <> 0 then
				 Errorbox(Stars2ca,'Error Reading Target Table')
			 	RETURN -1
		End If
		
		Delete from target_cntl
		where Case_id = Upper( :ISTR_Subset_Ids.Subset_Case_ID ) and
				case_spl = Upper( :ISTR_Subset_Ids.Subset_Case_Spl ) and 
				case_ver = Upper( :ISTR_Subset_Ids.Subset_Case_Ver ) and
				trgt_id  = Upper( :ls_delete_target )
				Using stars2ca;

		If stars2ca.of_check_status() = 100 then
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return -1
			End If	
		Elseif Stars2ca.sqlcode <> 0 then
			 Errorbox(Stars2ca,'Error Deleting Target Control Table')
			 RETURN -1
		End If

		//Deletes Tracking
		li_rc = uf_delete_subc_track_info(ls_delete_target)
		If li_rc = -1 then
			RETURN -1
		End IF
		
		// JasonS 09/09/02 Begin - Track 3226d
		select trgt_id into :ls_target_key
		from target
		where Case_id = Upper( :ISTR_Subset_Ids.Subset_Case_ID ) and
				case_spl = Upper( :ISTR_Subset_Ids.Subset_Case_Spl ) and 
				case_ver = Upper( :ISTR_Subset_Ids.Subset_Case_Ver ) and
				trgt_id  = Upper( :ls_delete_target )
				Using stars2ca;
		// JasonS 09/09/02 End - Track 3226d
		
		Delete from target
		where Case_id = Upper( :ISTR_Subset_Ids.Subset_Case_ID ) and
				case_spl = Upper( :ISTR_Subset_Ids.Subset_Case_Spl ) and 
				case_ver = Upper( :ISTR_Subset_Ids.Subset_Case_Ver ) and
				trgt_id  = Upper( :ls_delete_target )
				Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return -1
		End If	
		Elseif Stars2ca.sqlcode <> 0 then
			 	Errorbox(Stars2ca,'Error Deleting from Target Table')
			 	RETURN -1
		End If
		
		// JasonS 09/09/02 Begin - Track 3226d
		delete from case_link
		where Case_id = Upper( :ISTR_Subset_Ids.Subset_Case_ID ) and
				case_spl = Upper( :ISTR_Subset_Ids.Subset_Case_Spl ) and 
				case_ver = Upper( :ISTR_Subset_Ids.Subset_Case_Ver ) and
				link_key  = Upper( :ls_target_key )
				Using stars2ca;

		If stars2ca.of_check_status() = 100 then
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return -1
			End If	
		Elseif Stars2ca.sqlcode <> 0 then
			 	Errorbox(Stars2ca,'Error Deleting from Target Case Link')
			 	RETURN -1
		End If
		
		ls_message	=	"Target "	+	ls_target_key +	" removed."
		
		li_rc			=	lnv_case.uf_audit_log ( istr_subset_ids.subset_case_id, &
															istr_subset_ids.subset_case_spl, &
															istr_subset_ids.subset_case_ver, &
															ls_message )
		
		IF	li_rc		<	0		THEN
			Stars2ca.of_rollback()
			MessageBox ('Database Error', 'Could not insert case log for Track '	+	ls_target_key	+	&
							'.  Case: ' + istr_subset_ids.subset_case_id + &
							istr_subset_ids.subset_case_spl + &
							istr_subset_ids.subset_case_ver + '.~n~rScript: '		+	&
							'nvo_subset_functions.uf_delete_subc_track_info')
			Destroy	lnv_case
			Return	-1
		END IF		

		// JasonS 09/09/02 End - Track 3226d
Return 1
end function

public function integer uf_delete_subset ();//==============================================================================================//
// Object			nvo_subset_functions
//	Function			uf_delete_subset					
// PARAMETERS		None
//	RETURNS			Integer		1	Success		
//									  -1	Error
//										2	Delete cancelled either because:	
//										 	1) user req cancel due to error updating sub_cntl with delete_ind
//-----------------------------------------------------------------------------------------------//
//	Maintenance
//
// Author	Date			Description
// ------	----			-----------
//	Naomi		12/29/97		Created.
// Anne-s   07/17/98    Remove call of uf because it overlayed structure
//                      Add logic to delete associated notes & targets/tracks
// AJS      10-16-98    Track #1808 - Correct delete message.
//	FDG		02/20/01		Stars 4.7 - remove SQLCMD
//	GaryR		03/21/01		Stars 4.7 DataBase Port - Implement server functionality
//	FDG		04/16/01		Stars 4.7.	Account for empty string in case_spl, case_ver.
//	FDG		10/15/01		Stars 4.8.1.	Add case_log.
//	FDG		12/21/01		Track 2497.  Declare n_cst_case as a local to remove memory leaks.
//	FDG		02/13/02		Track 2648d.  Trim case_id.  Coming in as 'NONE '.
// JasonS 	09/10/02		Track 3226d.  Re-compute case financials after deleting tracks.
// 08/29/05	MikeF	SPR3927d	Centralized subset delete logic. Assumes that subset can be deleted based on
//									this.uf_get_delete_access
//==============================================================================================//
long 			ll_rows
integer 		li_rc
string 		ls_errmsg, ls_sqldbmsg, ls_sqldbrc, ls_sqlnrows
string 		ls_delete_target
string 		ls_message
n_cst_case	lnv_case	

SetPointer(HourGlass!)

// FDG 02/13/02 - trim case_id
IF	Len (istr_subset_ids.subset_case_id)	>	1	THEN
	istr_subset_ids.subset_case_id	=	Trim (istr_subset_ids.subset_case_id)	
END IF

// Check to see if this is the last subset link for this ID
ids_1.dataobject = 'd_list_case_link_with_subset_id'
ids_1.SetTransObject(stars2ca) 
ll_rows = IDS_1.Retrieve(istr_subset_ids.Subset_ID)
	
if ll_rows < 1 then
	MessageBox("Delete Error","Error checking case link.")
	return -1
end if

IF ll_rows = 1 then											
	// One row, mark subset for deletion	
	ids_1.dataobject = 'd_update_sub_cntl'				
	ids_1.setTransObject(STARS2CA) 

	ll_rows = ids_1.retrieve(istr_subset_ids.subset_id)

	if ll_rows = 1 then								
		// This should ALWAYS be true - One row in SUB_CNTL per subset ID
		ids_1.setItem(1,'DELETE_IND','Y')	

		IF ids_1.EVENT ue_update( TRUE, TRUE ) <> 1 then
			ls_errmsg = "An error has occurred in processing your delete request,"+&
					"~r~thowever, the subset may still be deleted from your case."+&
					"~r~tPlease report the error to your system administrator."+&
					"~r~tDo you wish to continue removing the case link to the subset?"
			ls_sqldbmsg = STARS2CA.sqlerrtext
			ls_sqlnrows = string(STARS2CA.SqlNrows)
			ls_sqldbrc = string(STARS2CA.SqlDBcode)
														//does user want to continue with delete?
			li_rc = Messagebox("DB ERROR",&										 
			"User MSG:  " + ls_errmsg + &  								
			"~rError MSG: " + ls_sqldbmsg + &
			"~rDB Code:   " + ls_sqldbrc + &
			"~rSQL Rows:  " + ls_sqlnrows + &
			"~r-----------------------------------" + &
			"~rDBMS:      " + STARS2CA.dbms + &
			"~rServer:    " + STARS2CA.servername + &
			"~rDatabase:  " + STARS2CA.database + &
			"~rLocking:   " + STARS2CA.lock, Question!,YesNo!)
					
			STARS2CA.of_rollback()																// FDG 02/20/01
			
			if li_rc = 2 then
				return 2
			end if
		end if //update failed
	end if //ll_rows=1 in sub_cntl
END IF 

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (istr_subset_ids.subset_case_spl)
li_rc	=	gnv_sql.of_TrimData (istr_subset_ids.subset_case_ver)
// FDG 04/16/01 - end

// Log delete in Case Log
ls_message	=	"Subset "	+	istr_subset_ids.subset_name	+	" removed from case."

lnv_case		=	CREATE	n_cst_case
li_rc			=	lnv_case.uf_audit_log ( istr_subset_ids.subset_case_id, &
													istr_subset_ids.subset_case_spl, &
													istr_subset_ids.subset_case_ver, &
													ls_message )

IF	li_rc	< 0 THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for subset '	+	istr_subset_ids.subset_name	+	&
					'.  Case: ' + istr_subset_ids.subset_case_id + &
					istr_subset_ids.subset_case_spl + &
					istr_subset_ids.subset_case_ver + '. Script: '		+	&
					'nvo_subset_functions.uf_delete_subset')
	Destroy	lnv_case	
	Return	-1
END IF

// Delete from CASE_LINK
DELETE from Case_Link
WHERE	Case_ID 	=	Upper( :ISTR_Subset_Ids.Subset_Case_ID ) AND
		Case_Spl =	Upper( :ISTR_Subset_Ids.Subset_Case_Spl) AND
		Case_Ver =	Upper( :ISTR_Subset_Ids.Subset_Case_Ver) AND
		Link_Type = 'SUB' AND
		Link_Name =	Upper( :ISTR_Subset_Ids.Subset_Name )
USING STARS2CA;

li_rc = STARS2CA.of_check_status()

if  li_rc >= 0 then
	//STARS2CA.of_commit()						// FDG 02/20/01 - Commit at end of LUW
else
	Errorbox(STARS2CA,'Error performing Commit ~rin nvo_subset_functions.uf_delete_subset')
	STARS2CA.of_rollback()																// FDG 02/20/01
	return -1
end if

IF istr_subset_ids.subset_case_id = 'NONE' THEN
	//Delete from NOTES
	DELETE FROM notes
	WHERE 	note_rel_id   = Upper( :ISTR_Subset_Ids.Subset_Name ) and
				note_rel_type = 'SS'
	USING stars2ca;
	li_rc = STARS2CA.of_check_status()

	IF li_rc >= 0 then
		//STARS2CA.of_commit()						// FDG 02/20/01 - Commit at end of LUW
	else
		Errorbox(STARS2CA,'Error performing Commit ~rin nvo_subset_functions.uf_delete_subset')
		STARS2CA.of_rollback()																// FDG 02/20/01
		return -1
	end if
	
ELSE
	//Delete target information for subsets in case
	IF uf_delete_subc_target_info() < 1 then
		STARS2CA.of_rollback()																// FDG 02/20/01
		return -1
	END IF
		
	// Update Case totals
	lnv_case.uf_compute_case_totals(	istr_subset_ids.subset_case_id, 	&
												istr_subset_ids.subset_case_spl, &
												istr_subset_ids.subset_case_ver)	
END IF

STARS2CA.of_commit()	

Destroy	lnv_case			

Return 1
end function

public function integer uf_target_chk_msg (string as_called_from, string as_case_id, string as_case_spl, string as_case_ver);int li_button_nbr
string ls_delete_target

Select trgt_id into :ls_delete_target
from target_cntl
where Case_id = Upper( :as_case_id ) and
		case_spl = Upper( :as_Case_Spl ) and 
		case_ver = Upper( :as_Case_Ver ) and
		Subc_id  = Upper( :gc_active_subset_id )	
Using stars2ca;

If ls_delete_target <> "" Then
	li_button_nbr = Messagebox("Warning.", "This action will delete all targets/tracks~r~nassociated with the selected subset.~r~nDo you wish to continue?", Question!, YesNo!)
Else
	If as_called_from = 'CASE_FOLDER' Then
		li_button_nbr = MessageBox ('CONFIRMATION!', 'Remove Highlighted Link?', &
                   	 Question!,YesNo!,2)		
	Else
		li_button_nbr = MessageBox ('CONFIRMATION!', 'Proceed with Subset Delete?', &
   	                Question!,YesNo!,2)
	End If
End if

Return li_button_nbr
end function

public subroutine uf_retrieve_datastores ();// 09/30/05 MikeF SPR4521d	Get PDQ Name rather than ID / Performance
int	li_rc

// Retrieve datastores to be used in this.uf_get_delete_access
li_rc = ids_pdq_tables.Retrieve()
li_rc = ids_bg_step_cntl.Retrieve()

end subroutine

public function integer uf_get_delete_access (string as_subset_name, string as_case_key, ref string as_object_name);//==============================================================================================//
// Object	nvo_subset_function
// Function	uf_get_delete_access
// -------------------------------------------------------------------------------------------- //
// Determines if a Subset Case Link can be deleted
// NOTE: Must call this.uf_retrieve_pdq_list prior to running.
// -------------------------------------------------------------------------------------------- //
// Maintenance
// -------- ----- ------------------------------------------------------------------------------
// 08/29/05	MikeF	SPR3927d	Centralized subset delete logic. Assumes that subset can be deleted based on
//									this.uf_get_delete_access
// 09/26/05 MikeF	SPR4521d Query ID showing instead of name / Performance
//	03/10/06	GaryR	SPR4679	Do not change Case NONE to space
//==============================================================================================//
string		ls_find
integer		li_access
long			ll_row

li_access 	= this.ici_allow

// Check to see if subset is linked to PDQ or PDR Query
ls_find 	= "subset_name = '" + as_subset_name + "' and case_key = '" + as_case_key + "'"
ll_row 	= ids_pdq_tables.find(ls_find, 1, ids_pdq_tables.Rowcount())

IF ll_row > 0 THEN
	as_object_name = ids_pdq_tables.GetItemString(ll_row, "link_name")
	
	IF ids_pdq_tables.GetItemString(ll_row, "pdq_type") = 'SS' THEN
		li_access = ici_pdq_link							
	ELSE
		li_access = ici_pdr_link
	END IF

END IF

// Check to see if subset is used as base in a scheduled job
IF li_access = ici_allow THEN
	ls_find 	= "src_subc_name='" + as_subset_name + "' and src_case_id = '" + as_case_key + "'"
	ll_row = ids_bg_step_cntl.Find(ls_find, 1, ids_bg_step_cntl.Rowcount())
	IF ll_row > 0 THEN	
		li_access = ici_bg_job
		// Get first job ID associated with this subset 
		// Note: Datawindow SQL already filters out Error and Complete steps
		as_object_name = ids_bg_step_cntl.GetItemString(ll_row, "job_id")
	END IF
END IF

RETURN li_access

end function

public function integer uf_post_rename (string as_old_name, string as_new_name, string as_case_id, string as_case_spl, string as_case_ver);//==============================================================================================//
// Object	nvo_subset_function
// Function	uf_post_rename
// -------------------------------------------------------------------------------------------- //
// Follows through and updates all places affected by a subset rename
//==============================================================================================//
// Maintenance
// -------- ----- ------------------------------------------------------------------------------
// 09/26/05	MikeF	SPR4522d	Created. Renaming subset doesn't carry down to PDQ and PDRs
//==============================================================================================//
string	ls_case_id

// Update existing PDQs
UPDATE pdq_tables
SET	src_subset_name = :as_new_name
WHERE	src_subset_name = :as_old_name
AND	src_case_id  = :as_case_id 
AND	src_case_spl = :as_case_spl
AND	src_case_ver = :as_case_ver
USING stars2ca;

IF (stars2ca.of_check_status() = 0) &
OR (stars2ca.sqlcode = 100) THEN
	// Worked fine or not found
ELSE
	errorbox(stars2ca,"Error updating existing PDQs.")
END IF

// Update BG jobs
ls_case_id = trim(as_case_id + as_case_spl + as_case_ver)

UPDATE bg_step_cntl
SET 	src_subc_name = :as_new_name
WHERE src_case_id = :ls_case_id
AND 	src_subc_name = :as_old_name
USING stars2ca;

IF (stars2ca.of_check_status() = 0) &
OR (stars2ca.sqlcode = 100) THEN
	// Worked fine or not found
ELSE
	errorbox(stars2ca,'Error updating bg_step_cntl with new subset name')
END IF

RETURN 0
end function

on nvo_subset_functions.create
call super::create
end on

on nvo_subset_functions.destroy
call super::destroy
end on

event constructor;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	constructor				nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Instantiate objects.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Long			0				Continue processing		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// -------- ----- --------	--------------------------------------------------
//	12/05/97	J.Mattis			Created.
// 09/30/05 MikeF SPR4521d	Get PDQ Name rather than ID / Performance
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

string	ls_tbl_type, ls_data_type, ls_sql, ls_join

SetPointer(HourGlass!)

//Instantiate the datastores
ids_1 = Create n_Ds

// Set SQL for uf_get_delete_access
ls_tbl_type 	= gnv_dict.event ue_get_table_type( "PDQ_CNTL" )
ls_data_type	= gnv_dict.event ue_get_data_type( ls_tbl_type, "QUERY_ID" )
ls_join			= gnv_sql.of_get_to_char(ls_data_type + ",B.PDR_LINK")
			
ls_sql = "SELECT 'SS', b.src_subset_name, b.src_case_id " + gnv_sql.is_concat + &
			" b.src_case_spl  " + gnv_sql.is_concat + " b.src_case_ver, "	+ &
			"a.query_id, c.link_name FROM pdq_cntl a, pdq_tables b, case_link c "						+ &
			"WHERE a.query_id = b.query_id AND a.query_id = c.link_key AND a.delete_ind <> 'Y' "	+ & 
			"AND b.src_type ='SS' AND c.link_type ='PDQ' UNION ALL "											+ &
			"SELECT a.query_type, d.link_name, b.src_case_id, a.query_id, c.link_name "				+ &
			"FROM pdq_cntl a, pdr_source b, case_link c, case_Link d "										+ &
			"WHERE A.query_id = " + ls_join + " AND a.query_id = c.link_key "								+ &
			"AND a.delete_ind <> 'Y' AND C.LINK_TYPE='PDR' AND b.SRC_SUBSET_ID = d.link_key " 		+ &
			"AND d.link_type='SUB' AND b.src_case_id = RTRIM(D.CASE_ID " + &
			gnv_sql.is_concat + " D.CASE_SPL " + gnv_sql.is_concat + " D.CASE_VER) "

// PDQ / PDR Query datastore
ids_pdq_tables	=	CREATE	n_ds
ids_pdq_tables.DataObject	= 'd_subset_pdq_list'
ids_pdq_tables.SetTransObject(Stars2ca)
ids_pdq_tables.SetSqlSelect( ls_sql )

// Background job datastore
ids_bg_step_cntl	=	CREATE	n_ds
ids_bg_step_cntl.DataObject	= 'd_subset_bg_jobs'
ids_bg_step_cntl.SetTransObject(Stars2ca)
end event

event destructor;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	destructor									nvo_subset_functions
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Destroy objects.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Long			0				Continue processing		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			12/05/97		Created.
//	NLG				08-11-99		Destroy inv_case if it exists
//	FDG				12/21/01		Track 2497.  Declare n_cst_case as a local to remove memory leaks.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

//Destroy the datastore
if IsValid(ids_1) Then
	Destroy ids_1
end if

DESTROY ids_pdq_tables
DESTROY ids_bg_step_cntl

end event

