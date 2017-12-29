$PBExportHeader$w_save_pattern.srw
$PBExportComments$Pattern Save window (inherited from w_master)
forward
global type w_save_pattern from w_master
end type
type dw_save from u_dw within w_save_pattern
end type
type cb_save from u_cb within w_save_pattern
end type
type cb_cancel from u_cb within w_save_pattern
end type
end forward

global type w_save_pattern from w_master
string accessiblename = "Pattern Save"
string accessibledescription = "Pattern Save"
integer width = 2345
integer height = 1680
string title = "Pattern Save"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type integer ue_check_pattern_id ( string as_link_name )
event type integer ue_edit_case ( string as_case )
event ue_save_pattern ( )
event ue_cancel ( )
dw_save dw_save
cb_save cb_save
cb_cancel cb_cancel
end type
global w_save_pattern w_save_pattern

type variables
// NVO to edit for case security
//n_cst_case	inv_case					//12/21/01	GaryR	Track 2497D	Memory Corruption

// Parm passed to this window
n_ds		ids_parm

// Pattern ID
String		is_pattern_id

end variables

event ue_check_pattern_id;//*********************************************************************************
// Script Name:	ue_check_pattern_id
//
//	Arguments:		as_link_name
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This event is triggered by the itemchanged event of dw_save.
//						This script will check the case_link table to see if the
//						user-defined pattern ID has already been used.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//
//*********************************************************************************

SetPointer(HourGlass!)

Constant	String	lcs_single_quote	=	"'"
Constant	String	lcs_double_quote	=	'"'

Integer	li_rc	=	1

String	ls_sql,					&
			ls_case_id,				&
			ls_case_spl,			&
			ls_pattern_id,			&
			ls_case_ver			

Long		ll_count

ls_pattern_id	=	dw_save.object.pattern_id [1]
ls_case_id		=	Left (dw_save.object.case_id [1], 10)
ls_case_spl		=	Mid (dw_save.object.case_id [1], 11, 12)
ls_case_ver		=	Mid (dw_save.object.case_id [1], 13, 14)

IF	IsNull (as_link_name)			&
OR	Trim (as_link_name)	<	' '	THEN
	MessageBox ("Error", "Pattern ID is required.  It will be reset to its original value.", StopSign!)
	dw_save.SetText (ls_pattern_id)
	Return  -1
ELSE
	IF Match (as_link_name, lcs_single_quote)		&
	OR Match (as_link_name, lcs_double_quote)		THEN
		Messagebox ("Error", "Pattern ID cannot contain quotes", StopSign!)
		Return	-1
	END IF
END IF


This.of_set_nvo_count (TRUE)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
// FDG 04/16/01 - end

ls_sql	=	"select count(*) from case_link where link_name = "	+	&
 				"'"	+	Upper( as_link_name )	+	"'"					+	&  
				" and link_type = 'PAT'"										+	&
				" and case_id = '"	+	Upper( ls_case_id	) +	"'"	+	&
				" and case_spl = '"	+	Upper( ls_case_spl )	+	"'"	+	&
				" and case_ver = '"	+	Upper( ls_case_ver )	+	"'"

ll_count	=	inv_count.uf_get_count(ls_sql)

IF ll_count > 0		THEN
	MessageBox ("Error", "Pattern ID is not unique.  Please enter another.", StopSign!)
	dw_save.SetText (ls_pattern_id)	
	li_rc =  -1
END IF

RETURN	li_rc

end event

event type integer ue_edit_case(string as_case);//*********************************************************************************
// Script Name:	ue_edit_case
//
//	Arguments:		as_case
//
// Returns:			Integer
//						-1	=	Error
//						 1	=	Success
//
//	Description:	Edit the case.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//	12/21/01	GaryR	Track 2497D	Memory Corruption
//
//*********************************************************************************

Integer	li_rc

String	ls_case_id,		&
			ls_case_spl,	&
			ls_case_ver,	&
			ls_msg

n_cst_case	lnv_case			//	12/21/01	GaryR	Track 2497D

ls_case_id		=	Left (as_case, 10)
ls_case_spl		=	Mid (as_case, 11, 2)
ls_case_ver		=	Mid (as_case, 13, 2)

IF	ls_case_id	=	''			&
OR	ls_case_id	=	'NONE'	THEN
	Return	1
END IF

lnv_case = Create n_cst_case			//	12/21/01	GaryR	Track 2497D
li_rc				=	lnv_case.uf_valid_case (ls_case_id, ls_case_spl, ls_case_ver)		//	12/21/01	GaryR	Track 2497D

CHOOSE CASE	li_rc
	CASE	0
		ls_msg	=	lnv_case.uf_edit_case_security (ls_case_id, ls_case_spl, ls_case_ver)		//	12/21/01	GaryR	Track 2497D
		Destroy lnv_case		//	12/21/01	GaryR	Track 2497D
		IF	Len (ls_msg)	>	0		THEN			
			MessageBox ('Case Security Error', ls_msg)
			Return	-1
		END IF
	CASE	-1
		MessageBox ('Error', 'Case not found.  Select another case.')
		Return	-1
	CASE	-2
		MessageBox ('Error', 'Case has been deleted.  Select another case.')
		Return	-1
	CASE	-3
		MessageBox ('Error', 'Case has been closed.  Select another case.')
		Return	-1
	CASE	-4
		MessageBox ('Error', 'Error verifying case ID')
		Return	-1
END CHOOSE

Return	1

end event

event ue_save_pattern;//*********************************************************************************
// Script Name:	ue_save_pattern
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event moves the data from dw_save to ids_parm and
//						closes the window.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

Constant	String	lcs_single_quote	=	"'"
Constant	String	lcs_double_quote	=	'"'

Integer	li_rc

String	ls_short_desc,		&
			ls_case,				&
			ls_pattern_id,		&
			ls_link_name

DateTime	ldtm_datetime

n_cst_string	lnv_string		// Autoinstantiated

SetPointer (HourGlass!)

li_rc	=	dw_save.AcceptText()

IF	li_rc	<	0		THEN
	Return
END IF

ls_short_desc	=	dw_save.object.short_desc [1]
ls_pattern_id	=	dw_save.object.pattern_id [1]
ls_link_name	=	dw_save.object.link_name [1]

IF	IsNull (ls_short_desc)			&
OR	Len (ls_short_desc)	=	0		THEN
	ldtm_datetime	=	gnv_app.of_get_server_date_time ()
	ls_short_desc	=	is_pattern_id	+	" created on "	+	&
							String (ldtm_datetime, "m-d-yy h:mm am/pm;'none'")	+	"."
	dw_save.object.short_desc [1]	=	ls_short_desc
END IF

IF	Match (ls_short_desc, lcs_single_quote)			THEN
	IF	Match (ls_short_desc, lcs_double_quote)		THEN
		li_rc	=	MessageBox ('Question', 'Pattern short description contains single '			+	&
									'and double quoutes. Double quotes will be changed to single.'	+	&
									'Do you wish to continue save?',Question!,YesNo!)
		IF	li_rc	=	2		THEN
			Return
		END IF
		ls_short_desc	=	lnv_string.of_GlobalReplace (ls_short_desc, lcs_double_quote, lcs_single_quote)
		dw_save.object.short_desc [1]	=	ls_short_desc
	END IF
END IF

// Edit the case
ls_case	=	dw_save.object.case_id [1]
li_rc	=	This.Event	ue_edit_case (ls_case)

IF	li_rc	<	0		THEN
	Return
END IF

// Set the new pattern ID based on what was entered.
dw_save.object.pattern_id [1]		=	ls_pattern_id

// Move the data from dw_save to ids_parm
ids_parm.object.data	=	dw_save.object.data

CloseWithReturn (This, ids_parm)


end event

event ue_cancel;//*********************************************************************************
// Script Name:	ue_save_pattern
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This event moves the data from dw_save to ids_parm and
//						closes the window.
//
//						This event will cancel the save.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

SetPointer (HourGlass!)

// Let the calling program know that the save is being cancelled.
dw_save.object.pattern_id [1]	=	'CANCEL'

// Disable CloseQuery processing
ib_disableclosequery	=	TRUE			

// Move the data from dw_save to ids_parm
ids_parm.object.data	=	dw_save.object.data

CloseWithReturn (This, ids_parm)


end event

on w_save_pattern.create
int iCurrent
call super::create
this.dw_save=create dw_save
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_save
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_save_pattern.destroy
call super::destroy
destroy(this.dw_save)
destroy(this.cb_save)
destroy(this.cb_cancel)
end on

event open;call super::open;//*********************************************************************************
// Script Name:	Open
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Take the data passed to this window and load dw_save.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

String		ls_save_ind,			&
				ls_link_name

DateTime		ldtm_datetime

n_cst_string	lnv_string

dw_save.object.data	=	ids_parm.object.data

ls_save_ind			=	dw_save.object.save_ind [1]
is_pattern_id		=	dw_save.object.pattern_id [1]
ldtm_datetime		=	dw_save.object.create_date [1]

dw_save.object.user_id [1]		=	gc_user_id

CHOOSE CASE	ls_save_ind
	CASE	'S'
		// Save
		dw_save.object.case_id.protect		=	1
		dw_save.object.link_ind.protect		=	1
		dw_save.object.link_name.protect		=	1
		dw_save.SetColumn ('short_desc')
		dw_save.SetFocus()
	CASE	'L'
		// Link an existing pattern to a case
		dw_save.object.case_id.protect		=	1
		dw_save.object.link_ind.protect		=	1
		dw_save.object.link_name.protect		=	1
		dw_save.object.link_id [1]	=	'Y'	// linking to a case
		dw_save.object.case_id [1]	=	gv_active_case
		dw_save.object.short_desc.protect	=	1
		This.Title	=	'Pattern Link'
		dw_save.SetColumn ('case_id')
		dw_save.SetFocus()
	CASE	'A'
		// Save As
		is_pattern_id		=	fx_get_next_key_id ("PATTERNID")
		is_pattern_id		=  'USER'	+	lnv_string.of_padnumber (is_pattern_id, 6)
		dw_save.object.pattern_id [1]	=	is_pattern_id
		dw_save.object.link_name [1]	=	is_pattern_id
		This.Title			=	is_orig_title	+	' As'
		w_main.SetMicroHelp ('Ready')
END CHOOSE

ls_link_name	=	dw_save.object.link_name [1]

IF	IsNull (ls_link_name)		&
OR	ls_link_name	=	''			THEN
	dw_save.object.link_name [1]	=	is_pattern_id
END IF

IF	IsNull (ldtm_datetime)		THEN
	ldtm_datetime	=	DateTime (Today())
	dw_save.object.create_date [1]	=	ldtm_datetime
END IF
end event

event ue_preopen;//*********************************************************************************
// Script Name:	ue_preopen
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Store the datastore passed to this window.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

ids_parm		=	Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

end event

event ue_postopen();call super::ue_postopen;//*********************************************************************************
// Script Name:	ue_postopen
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Create the NVO to edit for Case security
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//	12/21/01	GaryR	Track 2497D	Memory Corruption
//
//*********************************************************************************

//inv_case	=	CREATE	n_cst_case		//	12/21/01	GaryR	Track 2497D
end event

event close;call super::close;//*********************************************************************************
// Script Name:	Close
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Destroy any created instance variables.
//
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//	12/21/01	GaryR	Track 2497D	Memory Corruption
//
//*********************************************************************************

//	12/21/01	GaryR	Track 2497D
//IF IsValid (inv_case)		THEN
//	Destroy	inv_case
//END IF

end event

type dw_save from u_dw within w_save_pattern
string accessiblename = "Save Pattern"
string accessibledescription = "Save Pattern"
integer x = 23
integer y = 28
integer width = 2281
integer height = 1416
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_save_pattern"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;// This datawindow will not be included in the ue_save process
This.of_SetUpdateable (FALSE)

end event

event itemchanged;//*********************************************************************************
// Script Name:	dw_save.itemchanged
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	If link_name is changed, see if its a dup.  If link_ind is
//						changed, then populate the case_id.  If a case_id is entered,
//						then see if the case is valid and secure.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

CHOOSE CASE	dwo.name
	CASE	'link_name'
		li_rc	=	Parent.Event	ue_check_pattern_id (data)
		IF	li_rc	<	0		THEN
			Return	1
		END IF
	CASE	'link_ind'
		IF	data	=	'Y'		THEN
			This.object.case_id [row]	=	gv_active_case
		ELSE
			This.object.case_id [row]	=	'NONE'
		END IF
	CASE	'case_id'
		li_rc	=	Parent.Event	ue_edit_case (data)
		IF	li_rc	<	0		THEN
			Return	1
		END IF
END CHOOSE

end event

event itemerror;call super::itemerror;//*********************************************************************************
// Script Name:	dw_save.itemerror
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	Return 1 to prevent the default PB error messagebox from displaying.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

Return	1

end event

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	dw_save.rbuttondown
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	If rightclicking on case ID do a lookup on it.
//
//*********************************************************************************
//	
// 11/01/99 FDG	Stars 4.5	Created
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

String	ls_setting

IF Lower( as_col ) = "case_id" THEN
	ls_setting	=	This.object.case_id.protect
	IF	ls_setting	=	'0'		THEN
		gv_from		=	'AC'
		gv_result	=	0
		Open (w_case_list_response)
		IF	gv_result	=	0		THEN
			This.object.case_id [1]	=	gv_active_case
		END IF
	END IF
END IF

end event

type cb_save from u_cb within w_save_pattern
string accessiblename = "Save"
string accessibledescription = "Save"
integer x = 1618
integer y = 1480
integer taborder = 20
boolean bringtotop = true
string text = "&Save"
boolean default = true
end type

event clicked;Parent.Event	ue_save_pattern()
end event

type cb_cancel from u_cb within w_save_pattern
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 1989
integer y = 1480
integer taborder = 30
boolean bringtotop = true
string text = "&Cancel"
boolean default = true
end type

event clicked;Parent.Event	ue_cancel()

end event

