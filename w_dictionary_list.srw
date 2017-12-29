HA$PBExportHeader$w_dictionary_list.srw
$PBExportComments$Inherited from w_master
forward
global type w_dictionary_list from w_master
end type
type ddlb_dw_ops from dropdownlistbox within w_dictionary_list
end type
type st_1 from statictext within w_dictionary_list
end type
type dw_maint from u_dw within w_dictionary_list
end type
type cb_update from u_cb within w_dictionary_list
end type
type dw_search from u_dw within w_dictionary_list
end type
type st_row_count from statictext within w_dictionary_list
end type
type dw_list from u_dw within w_dictionary_list
end type
type cb_list from u_cb within w_dictionary_list
end type
type cb_exit from u_cb within w_dictionary_list
end type
type gb_1 from groupbox within w_dictionary_list
end type
type gb_2 from groupbox within w_dictionary_list
end type
end forward

global type w_dictionary_list from w_master
string accessiblename = "Dictionary List"
string accessibledescription = "Dictionary List"
accessiblerole accessiblerole = windowrole!
integer x = 73
integer y = 0
integer width = 3319
integer height = 2080
string title = "Dictionary List"
long backcolor = 67108864
event type integer ue_delete_system_templates ( string as_elem_tbl_type )
ddlb_dw_ops ddlb_dw_ops
st_1 st_1
dw_maint dw_maint
cb_update cb_update
dw_search dw_search
st_row_count st_row_count
dw_list dw_list
cb_list cb_list
cb_exit cb_exit
gb_1 gb_1
gb_2 gb_2
end type
global w_dictionary_list w_dictionary_list

type variables
String	is_slash			//	11/14/02	GaryR	SPR 3196d
end variables

forward prototypes
public subroutine wf_checksecurity ()
public function integer wf_updatepending ()
public subroutine wf_setenabled (string as_elem_type, string as_data_type, boolean ab_switch)
public subroutine wf_splitdesc (string as_elem_type)
end prototypes

event type integer ue_delete_system_templates(string as_elem_tbl_type);///////////////////////////////////////////////////////////////////////////
//	Event:			ue_delete_system_templates
//	Arguments:		as_elem_tbl_type - this is the table type for which
//												the user has modified the disp_seq
//
//	Description:	This event takes the dictionary table type for which
//						the user has modified the disp_seq and checks if there
//						are any system default report templates where this table
//						type is either a main table or a dependent table.  
//						If so, deletes from pdq_columns, case_link, and pdq_cntl
///////////////////////////////////////////////////////////////////////////
//	History:
// 01-18-99 NLG ts1655d. Created.
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
///////////////////////////////////////////////////////////////////////////

int li_rc
long li_x, ll_templates
string ls_query_type, ls_addl_query_type,ls_query_id
n_ds lnv_check_for_system_templates
lnv_check_for_system_templates = create n_ds
lnv_check_for_system_templates.dataobject = 'd_check_for_system_templates'
li_rc = lnv_check_for_system_templates.SetTransObject(stars2ca)
if li_rc <> 1 then
	Messagebox('SetTransObject','Error in SetTransObject for d_check_for_system_templates. ~r'+&
					'Unable to delete system default report templates.')
	return -1
else
	ll_templates = lnv_check_for_system_templates.retrieve(as_elem_tbl_type)
	if ll_templates > 0 then
		for li_x = 1 to ll_templates
			ls_query_type = lnv_check_for_system_templates.object.query_type[li_x]
			ls_addl_query_type = lnv_check_for_system_templates.object.addl_query_type[li_x]
			ls_query_id = lnv_check_for_system_templates.object.query_id[li_x]
			
			DELETE FROM PDQ_COLUMNS
			WHERE QUERY_ID = Upper( :ls_query_id )
			using stars2ca;
			
			IF stars2ca.of_check_status() <> 0 Then
				SetMicroHelp(w_main,'Error deleting system report template from pdq_columns for ' + ls_query_type + ' ' + ls_addl_query_type)
			   errorbox(stars2ca,'Error deleting from PDQ_COLUMNS. ~r'+&
								'System Default Template for invoice type ' + ls_query_type + ' ' + ls_addl_query_type + ' must ~r' +&
								'be manually deleted')
				RETURN -1
			end if 
			
			DELETE FROM CASE_LINK
			WHERE CASE_ID = 'SYSTEM'
			AND CASE_SPL = '00'
			AND CASE_VER = '00'
			AND LINK_TYPE = 'TMP'
			AND LINK_KEY = Upper( :ls_query_id )
  			using stars2ca;
			  
			IF stars2ca.of_check_status() <> 0 Then
				SetMicroHelp(w_main,'Error deleting system report template from case_link for ' + ls_query_type + ' ' + ls_addl_query_type)
			   errorbox(stars2ca,'Error deleting from CASE_LINK. ~r'+&
								'System Default Template for invoice type ' + ls_query_type + ' ' + ls_addl_query_type + ' must ~r' +&
								'be manually deleted')
				RETURN -1
			end if 
			
			DELETE FROM PDQ_CNTL
			WHERE USER_ID = 'SYSTEM'
			AND QUERY_TYPE = Upper( :ls_query_type )
			AND ADDL_QUERY_TYPE = Upper( :ls_addl_query_type )
			AND QUERY_ID = Upper( :ls_query_id )
			using stars2ca;	
			IF stars2ca.of_check_status() <> 0 Then
				SetMicroHelp(w_main,'Error deleting system report template from pdq_cntl for ' + ls_query_type + ' ' + ls_addl_query_type)
			   errorbox(stars2ca,'Error deleting from PDQ_CNTL. ~r'+&
								'System Default Template for invoice type ' + ls_query_type + ' ' + ls_addl_query_type + ' must ~r' +&
								'be manually deleted')
				RETURN -1
			end if 
		next
	end if
end if

COMMIT Using Stars2ca;							
IF Stars2ca.of_check_status()	<	0		THEN		
	ErrorBox(Stars2ca,'Error on COMMIT')
END IF		

return 1
end event

public subroutine wf_checksecurity ();///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

IF gv_user_sl = "AD" THEN
	dw_maint.of_SetUpdateable( TRUE )
	cb_update.enabled = TRUE
ELSE
	dw_maint.of_SetUpdateable( FALSE )
	cb_update.enabled = FALSE
	dw_maint.object.disp_seq.background.color = stars_colors.protected_back
	dw_maint.object.disp_seq.color = stars_colors.protected_text
	dw_maint.object.crit_seq.background.color = stars_colors.protected_back
	dw_maint.object.crit_seq.color = stars_colors.protected_text
	dw_maint.object.min_len.background.color = stars_colors.protected_back
	dw_maint.object.min_len.color = stars_colors.protected_text
	dw_maint.object.lead_alpha.background.color = stars_colors.protected_back
	dw_maint.object.lead_alpha.color = stars_colors.protected_text
	dw_maint.object.elem_lookup_type.background.color = stars_colors.protected_back
	dw_maint.object.elem_lookup_type.color = stars_colors.protected_text
	dw_maint.object.disp_format.background.color = stars_colors.protected_back
	dw_maint.object.disp_format.color = stars_colors.protected_text
	dw_maint.object.elem_elem_label.background.color = stars_colors.protected_back
	dw_maint.object.elem_elem_label.color = stars_colors.protected_text
	dw_maint.object.elem_crit_label.background.color = stars_colors.protected_back
	dw_maint.object.elem_crit_label.color = stars_colors.protected_text
	dw_maint.object.elem_desc.background.color = stars_colors.protected_back
	dw_maint.object.elem_desc.color = stars_colors.protected_text
	dw_maint.InsertRow( 0 )
END IF
end subroutine

public function integer wf_updatepending ();///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

Integer	li_msg

dw_maint.AcceptText()
IF dw_maint.Event ue_updatespending() > 0 THEN
	li_msg	=	MessageBox( 'Warning', is_closequery_msg,	Exclamation!, YesNoCancel! )
	CHOOSE CASE	li_msg
		CASE	1
			//	Yes - Update.
			IF This.Event ue_save() < 0 THEN Return -1
		CASE	2
			//	No - Do not update.
			Return 1
		CASE	3
			Return -1
	END CHOOSE
END IF

Return 1
end function

public subroutine wf_setenabled (string as_elem_type, string as_data_type, boolean ab_switch);///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

IF gv_user_sl <> "AD" THEN Return

dw_maint.enabled = ab_switch

IF ab_switch THEN
	IF as_elem_type = "CL" &
	OR as_elem_type = "CC" THEN
		dw_maint.object.disp_seq.background.color = stars_colors.input_back
		dw_maint.object.disp_seq.color = stars_colors.input_text
		dw_maint.object.disp_seq.protect = FALSE
		dw_maint.object.crit_seq.background.color = stars_colors.input_back
		dw_maint.object.crit_seq.color = stars_colors.input_text
		dw_maint.object.crit_seq.protect = FALSE
		
		IF gnv_sql.of_is_character_data_type( as_data_type ) THEN
			dw_maint.object.min_len.background.color = stars_colors.input_back
			dw_maint.object.min_len.color = stars_colors.input_text
			dw_maint.object.min_len.protect = FALSE
			dw_maint.object.lead_alpha.background.color = stars_colors.input_back
			dw_maint.object.lead_alpha.color = stars_colors.input_text
			dw_maint.object.lead_alpha.protect = FALSE
			dw_maint.object.elem_lookup_type.background.color = stars_colors.input_back
			dw_maint.object.elem_lookup_type.color = stars_colors.input_text
			dw_maint.object.elem_lookup_type.protect = FALSE
		ELSE
			dw_maint.object.min_len.background.color = stars_colors.protected_back
			dw_maint.object.min_len.color = stars_colors.protected_text
			dw_maint.object.min_len.protect = TRUE
			dw_maint.object.lead_alpha.background.color = stars_colors.protected_back
			dw_maint.object.lead_alpha.color = stars_colors.protected_text
			dw_maint.object.lead_alpha.protect = TRUE
			dw_maint.object.elem_lookup_type.background.color = stars_colors.protected_back
			dw_maint.object.elem_lookup_type.color = stars_colors.protected_text
			dw_maint.object.elem_lookup_type.protect = TRUE
		END IF
		
		dw_maint.object.disp_format.background.color = stars_colors.input_back
		dw_maint.object.disp_format.color = stars_colors.input_text
		dw_maint.object.disp_format.protect = FALSE
		dw_maint.object.elem_elem_label.background.color = stars_colors.input_back
		dw_maint.object.elem_elem_label.color = stars_colors.input_text
		dw_maint.object.elem_elem_label.protect = FALSE
		dw_maint.object.elem_crit_label.background.color = stars_colors.input_back
		dw_maint.object.elem_crit_label.color = stars_colors.input_text
		dw_maint.object.elem_crit_label.protect = FALSE
		dw_maint.object.elem_desc.background.color = stars_colors.input_back
		dw_maint.object.elem_desc.color = stars_colors.input_text
		dw_maint.object.elem_desc.protect = FALSE
	ELSE
		dw_maint.object.disp_seq.background.color = stars_colors.protected_back
		dw_maint.object.disp_seq.color = stars_colors.protected_text
		dw_maint.object.disp_seq.protect = TRUE
		dw_maint.object.crit_seq.background.color = stars_colors.protected_back
		dw_maint.object.crit_seq.color = stars_colors.protected_text
		dw_maint.object.crit_seq.protect = TRUE
		dw_maint.object.min_len.background.color = stars_colors.protected_back
		dw_maint.object.min_len.color = stars_colors.protected_text
		dw_maint.object.min_len.protect = TRUE
		dw_maint.object.lead_alpha.background.color = stars_colors.protected_back
		dw_maint.object.lead_alpha.color = stars_colors.protected_text
		dw_maint.object.lead_alpha.protect = TRUE
		dw_maint.object.elem_lookup_type.background.color = stars_colors.protected_back
		dw_maint.object.elem_lookup_type.color = stars_colors.protected_text
		dw_maint.object.elem_lookup_type.protect = TRUE
		dw_maint.object.disp_format.background.color = stars_colors.protected_back
		dw_maint.object.disp_format.color = stars_colors.protected_text
		dw_maint.object.disp_format.protect = TRUE
		dw_maint.object.elem_elem_label.background.color = stars_colors.protected_back
		dw_maint.object.elem_elem_label.color = stars_colors.protected_text
		dw_maint.object.elem_elem_label.protect = TRUE
		dw_maint.object.elem_crit_label.background.color = stars_colors.protected_back
		dw_maint.object.elem_crit_label.color = stars_colors.protected_text
		dw_maint.object.elem_crit_label.protect = TRUE
		dw_maint.object.elem_desc.background.color = stars_colors.input_back
		dw_maint.object.elem_desc.color = stars_colors.input_text
		dw_maint.object.elem_desc.protect = FALSE
	END IF
ELSE
	dw_maint.Reset()
	dw_maint.InsertRow( 0 )
	dw_maint.object.disp_seq.background.color = stars_colors.protected_back
	dw_maint.object.disp_seq.color = stars_colors.protected_text
	dw_maint.object.crit_seq.background.color = stars_colors.protected_back
	dw_maint.object.crit_seq.color = stars_colors.protected_text
	dw_maint.object.min_len.background.color = stars_colors.protected_back
	dw_maint.object.min_len.color = stars_colors.protected_text
	dw_maint.object.lead_alpha.background.color = stars_colors.protected_back
	dw_maint.object.lead_alpha.color = stars_colors.protected_text
	dw_maint.object.elem_lookup_type.background.color = stars_colors.protected_back
	dw_maint.object.elem_lookup_type.color = stars_colors.protected_text
	dw_maint.object.disp_format.background.color = stars_colors.protected_back
	dw_maint.object.disp_format.color = stars_colors.protected_text
	dw_maint.object.elem_elem_label.background.color = stars_colors.protected_back
	dw_maint.object.elem_elem_label.color = stars_colors.protected_text
	dw_maint.object.elem_crit_label.background.color = stars_colors.protected_back
	dw_maint.object.elem_crit_label.color = stars_colors.protected_text
	dw_maint.object.elem_desc.background.color = stars_colors.protected_back
	dw_maint.object.elem_desc.color = stars_colors.protected_text
END IF
end subroutine

public subroutine wf_splitdesc (string as_elem_type);///////////////////////////////////////////////////////////////////////////
//
//	11/14/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

String	ls_desc, ls_label
Integer	li_pos

IF  Upper( as_elem_type ) <> "CL" &
AND Upper( as_elem_type ) <> "CC" THEN Return 

ls_desc = dw_maint.GetItemString( 1, "elem_desc" )
is_slash = ""
li_pos = Pos( ls_desc, "/" )

IF	li_pos = 0 THEN
	Return		//	Everything stays in description
END IF

// Split description into 2 columns
//	Store only the 1st 15 bytes in label
IF li_pos > 16 THEN
	ls_label = Left( ls_desc, 15 )
	ls_desc = Mid( ls_desc, 16 )
ELSE
	is_slash = "/"
	ls_label = Left( ls_desc, li_pos - 1 )
	ls_desc = Mid( ls_desc, li_pos + 1 )
END IF

dw_maint.SetItem( 1, "elem_desc", ls_desc )
dw_maint.SetItem( 1, "elem_crit_label", Trim( ls_label ) )

dw_maint.SetItemStatus( 1, 0, Primary!, NotModified! )
end subroutine

event open;call super::open;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

DatawindowChild	ldwc_elem_type, ldwc_elem_tbl_type, ldwc_lookup_type

//	Prep the search DW
dw_search.SetTransObject( Stars2ca )
dw_search.of_SetUpdateable( FALSE )
dw_search.InsertRow( 0 )
dw_search.GetChild( "elem_type", ldwc_elem_type )
ldwc_elem_type.InsertRow( 1 )
ldwc_elem_type.SetItem( 1, "cf_elem_types", "" )
dw_search.GetChild( "elem_tbl_type", ldwc_elem_tbl_type )
ldwc_elem_tbl_type.InsertRow( 1 )
ldwc_elem_tbl_type.SetItem( 1, "cf_tbl_types", "" )

//	Prep the list DW
dw_list.SetTransObject( Stars2ca )
dw_list.of_SetUpdateable( FALSE )

//	Prep the maint DW
dw_maint.SetTransObject( Stars2ca )
dw_maint.of_SetTrim( TRUE )
This.wf_SetEnabled( "", "", FALSE )
dw_maint.GetChild( "elem_lookup_type", ldwc_lookup_type )
ldwc_lookup_type.InsertRow( 1 )
ldwc_lookup_type.SetItem( 1, "code_code", "" )
ldwc_lookup_type.SetItem( 1, "cf_codes", "" )

This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')

This.wf_CheckSecurity()
end event

on w_dictionary_list.create
int iCurrent
call super::create
this.ddlb_dw_ops=create ddlb_dw_ops
this.st_1=create st_1
this.dw_maint=create dw_maint
this.cb_update=create cb_update
this.dw_search=create dw_search
this.st_row_count=create st_row_count
this.dw_list=create dw_list
this.cb_list=create cb_list
this.cb_exit=create cb_exit
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_dw_ops
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_maint
this.Control[iCurrent+4]=this.cb_update
this.Control[iCurrent+5]=this.dw_search
this.Control[iCurrent+6]=this.st_row_count
this.Control[iCurrent+7]=this.dw_list
this.Control[iCurrent+8]=this.cb_list
this.Control[iCurrent+9]=this.cb_exit
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
end on

on w_dictionary_list.destroy
call super::destroy
destroy(this.ddlb_dw_ops)
destroy(this.st_1)
destroy(this.dw_maint)
destroy(this.cb_update)
destroy(this.dw_search)
destroy(this.st_row_count)
destroy(this.dw_list)
destroy(this.cb_list)
destroy(this.cb_exit)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_postsave;call super::ue_postsave;///////////////////////////////////////////////////////////////////////////
//
//	11/14/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

Long	ll_row

// Refresh the new values in list
ll_row = dw_list.GetRow()
dw_list.SetItem( ll_row, "elem_elem_label", dw_maint.GetItemString( 1, "elem_elem_label" ) )
dw_list.SetItem( ll_row, "crit_seq", dw_maint.GetItemNumber( 1, "crit_seq" ) )
dw_list.SetItem( ll_row, "disp_seq", dw_maint.GetItemNumber( 1, "disp_seq" ) )
dw_list.SetItem( ll_row, "elem_lookup_type", dw_maint.GetItemString( 1, "elem_lookup_type" ) )
dw_list.SetItem( ll_row, "elem_desc", dw_maint.GetItemString( 1, "elem_desc" ) )
This.Post wf_SplitDesc( dw_maint.GetItemString( 1, "elem_type" ) )

Return AncestorReturnValue
end event

type ddlb_dw_ops from dropdownlistbox within w_dictionary_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 910
integer y = 1876
integer width = 713
integer height = 204
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 1073741824
string text = "Data Window Manipulations"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//	04/10/09	Katie	GNL.600.5633 Added decode structure to fx_uo_control call.
//
///////////////////////////////////////////////////////////////////////////

SetPointer( Hourglass! )
is_operation = '1'
is_dw_control = fx_uo_control( iw_uo_win, dw_list, ddlb_dw_ops.text, is_dw_control, st_row_count, istr_decode_struct )
end event

type st_1 from statictext within w_dictionary_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 293
integer y = 1880
integer width = 613
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_maint from u_dw within w_dictionary_list
string accessiblename = "Display Control"
string accessibledescription = "Display Control"
accessiblerole accessiblerole = clientrole!
string tag = "NO SAVE"
integer x = 23
integer y = 1352
integer width = 3191
integer height = 472
integer taborder = 30
boolean enabled = false
string dataobject = "d_dictionary_maint"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_preupdate;call super::ue_preupdate;////////////////////////////////////////////////////////////////
//
//	01/12/95	EK		Added Lookup_Type "updateability"
// 01/11/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	11/14/02	GaryR	Track 3196d	Redesign Dictionary interface
//	03/27/03	GaryR	Track	3499d	Templates is misspelled
//
////////////////////////////////////////////////////////////////

String	ls_elem_type, ls_desc, ls_label, ls_crit_label, ls_format, &
			ls_tbl_type, ls_data_type, ls_lookup, ls_empty
Integer	li_data_length, li_min_len, li_alpha, li_disp, &
			li_orig_disp, li_crit
n_cst_string	lnv_string		//auto-instantiated

gnv_sql.of_TrimData (ls_empty)

ls_elem_type = dw_maint.GetItemString( 1, "elem_type" )
ls_desc = dw_maint.GetItemString( 1, "elem_desc" )
li_data_length = dw_maint.GetItemNumber( 1, "elem_data_len" )
li_disp = dw_maint.GetItemNumber( 1, "disp_seq" )
li_orig_disp = dw_maint.GetItemNumber( 1, "disp_seq", Primary!, TRUE )
li_crit = dw_maint.GetItemNumber( 1, "crit_seq" )
li_min_len = dw_maint.GetItemNumber( 1, "min_len" )
li_alpha = dw_maint.GetItemNumber( 1, "lead_alpha" )
ls_label = dw_maint.GetItemString( 1, "elem_elem_label" )
ls_crit_label = dw_maint.GetItemString( 1, "elem_crit_label" )
ls_lookup = dw_maint.GetItemString( 1, "elem_lookup_type" )
ls_format = dw_maint.GetItemString( 1, "disp_format" )
ls_tbl_type = dw_maint.GetItemString( 1, "elem_tbl_type" )
ls_data_type = dw_maint.GetItemString( 1, "elem_data_type" )

//	Validate values for elem_type "CL"
//	seperately form other values
IF ls_elem_type = "CL" &
OR ls_elem_type = "CC" THEN
	//	Validate label
	IF IsNull( ls_label ) OR Trim( ls_label ) = "" THEN
		MessageBox( "Validation Error", "Please enter a valid value for Display Label.", StopSign!, OK! )
		dw_maint.SetFocus()
		dw_maint.SetColumn( "elem_elem_label" )
		Return -1
	END IF
	
	//	Below validations are for character data type only
	IF gnv_sql.of_is_character_data_type( ls_data_type ) THEN	
		//	Validate min_len
		IF li_min_len > li_data_length THEN
			MessageBox( "Validation Error", "Minimum Length cannot be greater than Data Length.", StopSign!, OK! )
			dw_maint.SetFocus()
			dw_maint.SetColumn( "min_len" )
			Return -1
		END IF
		
		//	Validate lead_alpha
		IF li_alpha > li_data_length THEN
			MessageBox( "Validation Error", "Alpha Length cannot be greater than Data Length.", StopSign!, OK! )
			dw_maint.SetFocus()
			dw_maint.SetColumn( "lead_alpha" )
			Return -1
		END IF
		
		//	Validate character format
		//	to be of a numeric value
		IF NOT IsNull( ls_format ) AND Trim( ls_format ) <> "" THEN
			IF NOT IsNumber( ls_format ) THEN
				MessageBox( "Validation Error", "Please enter a valid numeric value for Display Format.", StopSign!, OK! )
				dw_maint.SetFocus()
				dw_maint.SetColumn( "disp_format" )
				Return -1
			END IF
		END IF			
	END IF
	
	//	Validate description and criteria label
	IF IsNull( ls_desc ) OR Trim( ls_desc ) = "" THEN ls_desc = ""
	IF IsNull( ls_crit_label ) OR Trim( ls_crit_label ) = "" THEN ls_crit_label = ""
	IF ls_desc = "" AND ls_crit_label = "" THEN
		MessageBox( "Validation Error", "Please enter a valid value for Criteria Label or Description.", StopSign!, OK! )
		dw_maint.SetFocus()
		dw_maint.SetColumn( "elem_crit_label" )
		Return -1
	END IF
	
	IF ls_crit_label <> "" AND is_slash = "" THEN is_slash = "/"

	ls_desc = lnv_string.of_PadRight( ls_crit_label, 15 ) + is_slash + ls_desc
	dw_maint.SetItem( 1, "elem_desc", ls_desc )
	dw_maint.AcceptText()

	// 01/11/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
	IF IsNull( ls_lookup ) OR Trim( ls_lookup ) = "" THEN ls_lookup = ls_empty
	
	//	NLG ts1655d First, check if disp_seq is being updated.
	//	If so, delete system default template for any template 
	//	containing that invoice type
	IF li_orig_disp <> li_disp THEN
		IF MessageBox( "Update Dictionary", "Altering the Display Sequence will delete all related System Report Templates." + &
													"~n~rDo you want to continue with the update?", Exclamation!, YesNo! ) <> 1 THEN Return -1
		Parent.Post Event ue_delete_system_templates( ls_tbl_type )
	END IF
ELSE
	//	Validate description
	IF IsNull( ls_desc ) OR Trim( ls_desc ) = "" THEN
		MessageBox( "Validation Error", "Please enter a valid value for Description.", StopSign!, OK! )
		dw_maint.SetFocus()
		dw_maint.SetColumn( "elem_desc" )
		Return -1
	END IF
END IF

Return 1
end event

type cb_update from u_cb within w_dictionary_list
string accessiblename = "Update"
string accessibledescription = "Update"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2688
integer y = 1872
integer width = 270
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Update"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////
//
//	11/14/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
////////////////////////////////////////////////////////////////

Parent.Event ue_save()
end event

type dw_search from u_dw within w_dictionary_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = clientrole!
string tag = "NO SAVE"
integer x = 46
integer y = 56
integer width = 3168
integer height = 216
integer taborder = 10
string dataobject = "d_dictionary_search"
boolean border = false
end type

type st_row_count from statictext within w_dictionary_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 14
integer y = 1872
integer width = 219
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_list from u_dw within w_dictionary_list
string accessiblename = "Dictionary List"
string accessibledescription = "Dictionary List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Dictionary List"
integer x = 14
integer y = 288
integer width = 3241
integer height = 1012
integer taborder = 20
string dataobject = "d_dictionary_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

Long		ll_row
String	ls_elem_type, ls_tbl_type, ls_name, ls_data_type, ls_filter, ls_empty
DataWindowChild	ldwc_disp_format

ll_row = This.GetRow()

IF ll_row < 1 THEN Return

dw_list.SelectRow( 0, FALSE )
dw_list.SelectRow( ll_row, TRUE )
dw_list.ScrollToRow( ll_row )

ls_elem_type = dw_list.GetItemString( ll_row, "elem_type" )
ls_tbl_type = dw_list.GetItemString( ll_row, "elem_tbl_type" )
ls_name = dw_list.GetItemString( ll_row, "elem_name" )
ls_data_type = dw_list.GetItemString( ll_row, "elem_data_type" )

IF dw_maint.Retrieve( ls_elem_type, ls_tbl_type, ls_name ) <> 1 THEN
	MessageBox( "Dictionary List", "Error retrieving the details for current row" )
	Return
END IF

// Split description into 2 columns
Parent.wf_SplitDesc( ls_elem_type )

//	Filter the disp_format dddw
//	based on current data type
IF ls_elem_type = "CL" &
OR ls_elem_type = "CC" THEN
	IF gnv_sql.of_is_character_data_type( ls_data_type ) THEN
		//	Character data types should be editable
		dw_maint.object.disp_format.dddw.AllowEdit	= "Yes"
		ls_filter = "%CHARACTER%"
	ELSEIF gnv_sql.of_is_number_data_type( ls_data_type ) THEN
		dw_maint.object.disp_format.dddw.AllowEdit	= "No"
		ls_filter = "%NUMBER%"
	ELSEIF gnv_sql.of_is_money_data_type( ls_data_type ) THEN
		dw_maint.object.disp_format.dddw.AllowEdit	= "No"
		ls_filter = "%MONEY%"	
	ELSEIF gnv_sql.of_is_date_data_type( ls_data_type ) THEN
		dw_maint.object.disp_format.dddw.AllowEdit	= "No"
		ls_filter = "%DATE%"
	END IF
		
		dw_maint.GetChild( "disp_format", ldwc_disp_format )
		ldwc_disp_format.SetTransObject( Stars2ca )
		ldwc_disp_format.Retrieve( ls_filter )
		ldwc_disp_format.InsertRow( 1 )
		gnv_sql.of_TrimData( ls_empty )
		ldwc_disp_format.SetItem( 1, "code_value_a", ls_empty )
		ldwc_disp_format.SetItem( 1, "compute_1", ls_empty )
END IF

Parent.wf_SetEnabled( ls_elem_type, ls_data_type, TRUE )
end event

event doubleclicked;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

int tabpos,rc
long lv_row_nbr
string lv_hold_object,lv_col

setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_list)
If lv_hold_object = '' then return

tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
	If is_operation <> '1' Then
		Messagebox('Information','You must select an option from Window Operations')
	Else
		ddlb_dw_ops.triggerevent(selectionchanged!)
	End If
	rc = fx_dw_control(dw_list,lv_hold_object,is_dw_control,iw_uo_win,'',0,istr_decode_struct)
ElseIf is_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
	rc = fx_dw_control(dw_list,lv_hold_object,is_dw_control,iw_uo_win,'cell',lv_row_nbr,istr_decode_struct)
ElseIf is_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
	rc = fx_dw_control(dw_list,lv_hold_object,is_dw_control,iw_uo_win,'cell',lv_row_nbr,istr_decode_struct)
Else

End If
end event

event rowfocuschanging;call super::rowfocuschanging;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

IF Parent.wf_updatepending() = -1 THEN Return 1
end event

type cb_list from u_cb within w_dictionary_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2391
integer y = 1872
integer width = 270
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&List"
boolean default = true
end type

event clicked;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

Long		ll_rows
String	ls_elem_type, ls_tbl_type, ls_name, ls_label, ls_desc

SetPointer( HourGlass! )
w_main.SetMicrohelp( "Retrieving rows based on search criteria..." )

IF Parent.wf_updatepending() = -1 THEN Return

Parent.SetRedraw( FALSE )

dw_search.AcceptText()
ls_elem_type = dw_search.GetitemString( 1, "elem_type" )
ls_tbl_type = dw_search.GetitemString( 1, "elem_tbl_type" )
ls_name = dw_search.GetitemString( 1, "elem_name" )
ls_label = dw_search.GetitemString( 1, "elem_elem_label" )
ls_desc = dw_search.GetitemString( 1, "elem_desc" )

//	Validate parameters
IF IsNull( ls_elem_type ) OR Trim( ls_elem_type ) = "" THEN ls_elem_type = "%"
IF IsNull( ls_tbl_type ) OR Trim( ls_tbl_type ) = "" THEN ls_tbl_type = "%"
IF IsNull( ls_name ) OR Trim( ls_name ) = "" THEN
	ls_name = "%"
ELSE
	ls_name = "%" + ls_name + "%"
END IF
IF IsNull( ls_label ) OR Trim( ls_label ) = "" THEN
	ls_label = "%"
ELSE
	ls_label = "%" + ls_label + "%"
END IF
IF IsNull( ls_desc ) OR Trim( ls_desc ) = "" THEN
	ls_desc = "%"
ELSE
	ls_desc = "%" + ls_desc + "%"
END IF

Parent.wf_SetEnabled( "", "", FALSE )

ll_rows = dw_list.Retrieve( ls_elem_type, ls_tbl_type, ls_name, ls_label, ls_desc )
st_row_count.text = String( ll_rows )
w_main.SetMicrohelp( "Ready" )

IF ll_rows < 1 THEN
	Parent.SetRedraw( TRUE )
	MessageBox( "Dictionary List", "There were no rows matching the criteria" )
	Return
END IF

dw_list.SetRow( 1 )
dw_list.TriggerEvent( "RowFocusChanged" )
Parent.SetRedraw( TRUE )
end event

on getfocus;SetMicroHelp(W_Main,"Lists Dictionary Entries Based on the Search Criteria")
end on

type cb_exit from u_cb within w_dictionary_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2985
integer y = 1872
integer width = 270
integer taborder = 60
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
boolean cancel = true
end type

event clicked;///////////////////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	SPR 3196d	Redesign Dictionary interface
//
///////////////////////////////////////////////////////////////////////////

Close( Parent )

end event

on getfocus;SetMicroHelp(W_Main,"Quits List Dictionary Window")
end on

type gb_1 from groupbox within w_dictionary_list
string accessiblename = "Search By"
string accessibledescription = "Search By"
accessiblerole accessiblerole = groupingrole!
integer x = 14
integer width = 3241
integer height = 284
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Search By"
end type

type gb_2 from groupbox within w_dictionary_list
string accessiblename = "Display Control"
string accessibledescription = "Display Control"
accessiblerole accessiblerole = groupingrole!
integer x = 14
integer y = 1300
integer width = 3241
integer height = 556
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Display Control"
end type

