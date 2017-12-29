$PBExportHeader$u_nvo_proc_code.sru
$PBExportComments$Used to get proc code descriptions (inherited from n_base) <logic>
forward
global type u_nvo_proc_code from n_base
end type
end forward

global type u_nvo_proc_code from n_base
end type
global u_nvo_proc_code u_nvo_proc_code

type variables
// Datawindow used
Protected	u_dw		idw_report

// Proc code column number
Protected	Integer		ii_proc_code_column

// Proc code description column number
Protected	Integer		ii_desc_column

// Invoice type
Protected	String		is_inv_type

// List of proc_codes and its descriptions
Protected	String		is_proc_code[]
Protected	String		is_desc[]

// Lookup code for proc_code
Protected	String		is_code_type

end variables

forward prototypes
public subroutine uf_set_dw (u_dw adw)
public subroutine uf_set_proc_code_column (integer ai_column)
public subroutine uf_set_desc_column (integer ai_column)
public subroutine uf_set_inv_type (string as_inv_type)
public subroutine uf_init ()
public function integer uf_get_descriptions ()
end prototypes

public subroutine uf_set_dw (u_dw adw);//*********************************************************************************
// Script Name:	uf_set_dw
//
//	Arguments:		adw - by reference
//
// Returns:			None
//
//	Description:	Store the pointer to the window's report datawindow.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
//	02/06/07	GaryR	Track 4889	Set the proper procedure columns
//
//*********************************************************************************

String	ls_dataobject

idw_report	=	adw

ls_dataobject	=	Lower (idw_report.dataobject)

CHOOSE CASE ls_dataobject
	CASE 'd_rpt_fiscal_year_by_proc'
		This.uf_set_proc_code_column (1)
		This.uf_set_desc_column (2)
		
	CASE 'd_rpt_fiscal_year_by_proc_2000'
		This.uf_set_proc_code_column (1)
		This.uf_set_desc_column (2)
		
	CASE 'd_rpt_top_250_proc'
		This.uf_set_proc_code_column (2)
		This.uf_set_desc_column (3)
		
	CASE 'd_rpt_top_100_proc_spec'
		This.uf_set_proc_code_column (6)
		This.uf_set_desc_column (7)
		
	CASE 'd_rpt_top_40_proc_top_100_diag'
		This.uf_set_proc_code_column (6)
		This.uf_set_desc_column (7)
		
END CHOOSE
end subroutine

public subroutine uf_set_proc_code_column (integer ai_column);//*********************************************************************************
// Script Name:	uf_set_proc_code_column
//
//	Arguments:		ai_column
//
// Returns:			None
//
//	Description:	Set the column used for proc_code.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
//
//*********************************************************************************

ii_proc_code_column	=	ai_column

end subroutine

public subroutine uf_set_desc_column (integer ai_column);//*********************************************************************************
// Script Name:	uf_set_desc_column
//
//	Arguments:		ai_column
//
// Returns:			None
//
//	Description:	Set the column used for proc_code description.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
//
//*********************************************************************************

ii_desc_column	=	ai_column

end subroutine

public subroutine uf_set_inv_type (string as_inv_type);//*********************************************************************************
// Script Name:	uf_set_inv_type
//
//	Arguments:		as_inv_type
//
// Returns:			None
//
//	Description:	Set the invoice type passed.  Get the code type for this
//						invoice type.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
// 10/19/04 MikeF	Track 3650d	Replaced local n_cst_dict with global service
//*********************************************************************************

is_inv_type	=	as_inv_type

// Get the lookup code for proc_code
is_code_type	=	gnv_dict.Event	ue_get_lookup_type (as_inv_type, 'PROC_CODE')

end subroutine

public subroutine uf_init ();//*********************************************************************************
// Script Name:	uf_init
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Initialize any instance variables.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
//
//*********************************************************************************

String	ls_empty[]

is_desc					=	ls_empty
is_proc_code			=	ls_empty
is_inv_type				=	''
ii_desc_column			=	0
ii_proc_code_column	=	0

end subroutine

public function integer uf_get_descriptions ();//*********************************************************************************
// Script Name:	uf_get_descriptions	
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	For each row in the datawindow, get the proc code descriptions.
//						is_proc_code[] and is_desc[] is set to prevent duplicate reads.
//
//*********************************************************************************
//	
// 07/05/00 FDG	Track 2891 (Stars 4.5 SP1).	Created.
//
//*********************************************************************************

Boolean	lb_found

Long		ll_row,				&
			ll_rowcount,		&
			ll_idx,				&
			ll_max


String	ls_empty[],			&
			ls_proc_code,		&
			ls_desc,				&
			ls_code_code

// Make sure that the required data has ben set.

IF	ii_desc_column			<	1		&
OR	ii_proc_code_column	<	1		THEN
	MessageBox ('Application Error', 'The proc_code column # have not been set in '		+	&
					'u_nvo_proc_code.uf_get_descriptions.')
	Return	-1
END IF

IF	is_inv_type	=	''		THEN
	MessageBox ('Application Error', 'The invoice type has not been set in '		+	&
					'u_nvo_proc_code.uf_get_descriptions.')
	Return	-1
END IF

// Clear out previously set data in is_proc_code[] and is_desc[]
is_proc_code	=	ls_empty
is_desc			=	ls_empty

// Prevent screen flicker
idw_report.SetRedraw (FALSE)

ll_rowcount		=	idw_report.RowCount()

w_main.SetMicroHelp ('Retrieving procedure code descriptions.  Please wait...')

FOR	ll_row	=	1	TO	ll_rowcount
	lb_found			=	FALSE
	ls_proc_code	=	idw_report.GetItemString (ll_row, ii_proc_code_column)
	ll_max			=	UpperBound (is_proc_code)
	FOR	ll_idx	=	1	TO	ll_max
		IF	ls_proc_code	=	is_proc_code[ll_idx]		THEN
			// Found the proc code.  Use its description.
			lb_found	=	TRUE
			idw_report.SetItem (ll_row, ii_desc_column, is_desc[ll_idx])
			Exit
		END IF
	NEXT
	IF	lb_found		=	FALSE		THEN
		// Proc code not found, add it to is_proc_code[] and get its description
		//	is_code_type was set in uf_set_inv_type()
		ll_max	++
		is_proc_code[ll_max]		=	ls_proc_code
		Select	code_desc
		Into		:ls_desc
		From		code
		Where		code_type	=	Upper( :is_code_type )
		And		code_code	=	Upper( :ls_proc_code )
		Using		Stars2ca;
		IF	Stars2ca.of_check_status()		<	0		THEN
			MessageBox ('Application Error', 'Cannot retrieve code description in '		+	&
							'u_nvo_proc_code.uf_get_descriptions.  code_type = '				+	&
							is_code_type	+	'.  code_code = '										+	&
							ls_proc_code	+	'.')
			idw_report.SetRedraw (TRUE)
			Return	-1
		END IF
		IF	Stars2ca.of_check_status()		=	100		THEN
			ls_desc				=	'UNKNOWN'
		END IF
		IF	ii_proc_code_column	=	ii_desc_column		THEN
			// Decription and proc_code columns are the same.  This is
			// a window operations lookup.
			ls_desc	=	ls_proc_code	+	' - '	+	ls_desc
		END IF
		idw_report.SetItem (ll_row, ii_desc_column, ls_desc)
		is_desc[ll_max]			=	ls_desc
	END IF
NEXT

idw_report.SetRedraw (TRUE)

w_main.SetMicroHelp ('Ready')

Return	1


end function

on u_nvo_proc_code.create
call super::create
end on

on u_nvo_proc_code.destroy
call super::destroy
end on

event constructor;call super::constructor;This.uf_init()

end event

