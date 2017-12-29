HA$PBExportHeader$n_cst_filter.sru
$PBExportComments$<logic>
forward
global type n_cst_filter from nonvisualobject
end type
end forward

global type n_cst_filter from nonvisualobject
end type
global n_cst_filter n_cst_filter

type variables
n_ds ids_filter_cntl_filter_id

end variables

forward prototypes
public function long of_retrievefiltercntl (string as_filterid)
public function boolean of_isvalid_tablename (string as_tbl_name)
end prototypes

public function long of_retrievefiltercntl (string as_filterid);long ll_row

ids_filter_cntl_filter_id.dataobject = 'd_filter_ctl_filter_id'
ids_filter_cntl_filter_id.SetTransObject (Stars2ca)
ll_row	=	ids_filter_cntl_filter_id.Retrieve (as_filterid)

return ll_row

end function

public function boolean of_isvalid_tablename (string as_tbl_name);///////////////////////////////////////////////////////////////////////////
// Function:	of_isvalid_tablename
//
// Purpose: This function validates where the argument string contains any character other than 0-9, A-Z, or a-z.
//
// Scope:	public
//
// Parameters:		as_tbl_name 	: string
// Returns : Boolean  - True ( meaning the argument string is valid for table name ), FALSE, otherwise
//
//	DATE			NAME		REVISION
// ----		------------------------------------------------------------
// 02/09/06 HYL Track 4648d This track originated this function since w_filter_maintain and w_qe_filter_name call this function.
//////////////////////////////////////////////////////////////////////

Integer i_len, i_idx
Boolean b_rtn = TRUE
String s_char
i_len = len(as_tbl_name)
For i_idx = 1 to i_len
	s_char = mid(as_tbl_name,i_idx,1)
	If Asc(s_char) > 47 and Asc(s_char) < 58 Then
		Continue
	ElseIf Asc(s_char) > 64 and Asc(s_char) < 91 Then
		Continue
	ElseIf Asc(s_char) > 96 and Asc(s_char) < 123 Then	
		Continue
	Else
		b_rtn = FALSE
		EXIT
	End If
Next
RETURN b_rtn
end function

on n_cst_filter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_filter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;IF	IsValid (ids_filter_cntl_filter_id)		THEN
	Destroy	ids_filter_cntl_filter_id
END IF

end event

event constructor;ids_filter_cntl_filter_id = create n_ds

end event

