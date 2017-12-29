HA$PBExportHeader$u_display_user_id.sru
$PBExportComments$Used for User ID dropdown <gui>
forward
global type u_display_user_id from u_dw
end type
end forward

global type u_display_user_id from u_dw
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = clientrole!
integer width = 864
integer height = 108
string dataobject = "d_display_user_id"
end type
global u_display_user_id u_display_user_id

type variables
// Datastore to retrieve the list of departments
n_ds	ids_code

Integer ii_code_val_n


end variables

forward prototypes
public function string uf_get_default_user (string as_dept_id)
public function integer uf_filter_dept (string as_dept_id)
end prototypes

public function string uf_get_default_user (string as_dept_id);///////////////////////////////////////////////////////////////////////////////////////////
//
//	Script:		u_display_user_id.uf_get_default_user
//
//	Arguments:	as_dept_id - Department 
//
//	Returns:		String. 
//
//	Description:
//			Get the default user ID from the code table for the specified
//			department.
//
//
////////////////////////////////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/12/01	Stars 4.8.  Created.
//	SAH   01/07/02	Stars 5.0   Puplulate instance var ii_code_val_n
//										to remove filter on certain depts.
//	FDG	01/17/02	Track 2689d If 'NONE' is selected ids_code won't be found.
// 										
/////////////////////////////////////////////////////////////////////////////////////////////

String	ls_find,			&
			ls_dept_id,		&
			ls_user_id

Long		ll_row

Integer	li_rc

ls_dept_id	=	Trim (as_dept_id)

ls_find		=	"code_code = '"	+	ls_dept_id	+	"'"

ll_row		=	ids_code.Find (ls_find, 1, ids_code.RowCount() )


IF	ll_row	=	0	THEN
	ls_user_id	=	''
	ii_code_val_n	=	1			// FDG 01/17/02
ELSE
	ls_user_id	=	ids_code.object.code_value_a [ll_row]
	// SAH 01/07/02 begin
	ii_code_val_n = ids_code.object.code_value_n[ll_row]	// FDG 01/17/02 - Move to within the 'IF'
END IF

// FDG 01/17/02 - If department = NONE, then it won't be found
//IF ll_row < 1 THEN
//	MessageBox('Error', 'There are no rows in ids_code')
//END IF
// SAH 01/07/02 end

Return	ls_user_id



end function

public function integer uf_filter_dept (string as_dept_id);/////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Script:		u_display_user_id.uf_filter_dept
//
//	Arguments:	as_dept_id - Department to filter
//
//	Returns:		Integer.  1=success, -1=error
//
//	Description:
//			Filter the list of users based on the passed department ID
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//	Modification History:
//
//	FDG	09/12/01	Stars 4.8.  Created.
// SAH	01/04/02	Stars 5.0   For cerain depts (when code_value_n > 0)
//										remove filter on user_id dddw so that for 
//										those depts, a user can be associated with
//										more than one dept.
// SAH	03/11/02 Stars 5.1   Track #2862;No longer allow cases to be referred to 'NONE' 
//										if user_id is unknown, default to default user_id for dept.
//	JasonS 07/22/02 Track 3205d  First user selected from db cannot be referred to									
//////////////////////////////////////////////////////////////////////////////////////////////////

String	ls_filter,			&
			ls_dept_id

Long		ll_rowcount,		&
			ll_row				
			

Integer	li_rc,   			&
         li_code_val_n

DataWindowChild	ldwc

ls_dept_id	=	Trim (as_dept_id)

// Get the child d/w to filter
This.GetChild ('user_id', ldwc)

ls_filter	=	"user_dept = '"	+	ls_dept_id	+	"'"

IF	IsNull (ls_dept_id)		&
OR	Len (ls_dept_id)	=	0	THEN
	ls_filter	=	''
END IF

// SAH 01/04/02 begin

li_code_val_n = ii_code_val_n

IF li_code_val_n > 0 THEN
	li_rc	=	ldwc.SetFilter('')
	li_rc	=	ldwc.Filter()
ELSE 
	li_rc =  ldwc.SetFilter('')
	li_rc =  ldwc.Filter()
	li_rc	=	ldwc.SetFilter(ls_filter)
	li_rc	=	ldwc.Filter()
	li_rc	=	ldwc.SetSort("cf_name A")
	li_rc	=	ldwc.Sort()
END IF	
	
// SAH 03/11/02 Track #2862
	
//ll_row		=	ldwc.InsertRow(0)
//ldwc.SetItem (ll_row, 'cf_name', 'NONE')
//ldwc.SetItem (ll_row, 'user_id', 'NONE')

// JasonS 07/22/02 Begin - Track 3205d
//ldwc.SetItem(ll_row, 'cf_name', ' ')
//ldwc.SetItem(ll_row, 'user_id', ' ')
//ldwc.SetItem (ll_row, 'user_dept', ' ')
// JasonS 07/22/02 End - Track 3205d


Return	1
end function

event constructor;call super::constructor;// Insert a row and initialize
// JasonS	07/22/02	Track 3205d first user selected from db cannot be referred to
Long		ll_row,			&
			ll_rowcount,	&
			ll_rows

ll_row	=	This.InsertRow(0)
This.ScrollToRow(ll_row)

DataWindowChild	ldwc

// Get the child d/w and insert an empty row
This.GetChild ('user_id', ldwc)

ldwc.Reset()
ldwc.SetTransObject (Stars2ca)
ll_rowcount	=	ldwc.Retrieve()

// SAH 03/11/02 Track 2862
// No longer allow selection of user_id='NONE'
//ll_row		=	ldwc.InsertRow(0)
//ldwc.SetItem (ll_row, 'cf_name', 'NONE')
//ldwc.SetItem (ll_row, 'user_id', 'NONE')

// JasonS 07/22/02 Begin - Track 3205d
//ldwc.SetItem(ll_row, 'cf_name', ' ')
//ldwc.SetItem(ll_row, 'user_id', ' ')
//ldwc.SetItem (ll_row, 'user_dept', ' ')
// JasonS 07/22/02 End - Track 3205d

// Retrieve the departments (for finding default user IDs)
ids_code	=	CREATE	n_ds
ids_code.DataObject	=	'd_dddw_case_dept_2'
ids_code.SetTransObject (Stars2ca)
ll_rows = ids_code.Retrieve()
IF ll_rows = -1 THEN
	MessageBox('Error', 'Error Retrieving Department Information')
	Return -1
END IF





end event

event destructor;call super::destructor;
IF	IsValid (ids_code)		THEN
	Destroy	ids_code
END IF

end event

on u_display_user_id.create
end on

on u_display_user_id.destroy
end on

