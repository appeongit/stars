$PBExportHeader$w_notes_maint.srw
$PBExportComments$Inherited from w_master
forward
global type w_notes_maint from w_master
end type
type sle_rel_id from u_sle within w_notes_maint
end type
type sle_note_name from u_sle within w_notes_maint
end type
type cb_spell from u_cb within w_notes_maint
end type
type rte_text from u_rte within w_notes_maint
end type
type rte_print from u_rte within w_notes_maint
end type
type st_1 from statictext within w_notes_maint
end type
type sle_note_desc from singlelineedit within w_notes_maint
end type
type st_subtype from statictext within w_notes_maint
end type
type ddlb_subtype from dropdownlistbox within w_notes_maint
end type
type cb_model from u_cb within w_notes_maint
end type
type cb_clear from u_cb within w_notes_maint
end type
type st_date_time from statictext within w_notes_maint
end type
type sle_date_time from singlelineedit within w_notes_maint
end type
type ddlb_type from dropdownlistbox within w_notes_maint
end type
type sle_userid from singlelineedit within w_notes_maint
end type
type st_subject from statictext within w_notes_maint
end type
type st_type from statictext within w_notes_maint
end type
type st_notes-key from statictext within w_notes_maint
end type
type st_userid from statictext within w_notes_maint
end type
type cb_delete from u_cb within w_notes_maint
end type
type cb_add from u_cb within w_notes_maint
end type
type cb_update from u_cb within w_notes_maint
end type
type cb_retrieve from u_cb within w_notes_maint
end type
type cb_exit from u_cb within w_notes_maint
end type
type cb_print from u_cb within w_notes_maint
end type
type cb_import from u_cb within w_notes_maint
end type
type cb_export from u_cb within w_notes_maint
end type
end forward

global type w_notes_maint from w_master
string accessiblename = "Note Details"
string accessibledescription = "Note Details"
integer x = 5
integer y = 4
integer width = 2843
integer height = 1968
string title = "Note Details"
boolean ib_popup_menu = true
event type integer ue_import ( )
event type integer ue_export ( )
event ue_edit_case_closed ( )
event ue_set_mod_availability ( boolean ab_switch )
event ue_set_create_availability ( boolean ab_switch )
event ue_set_update_availability ( )
event ue_set_content_availability ( boolean ab_switch )
event type boolean ue_edit_case_referred ( )
sle_rel_id sle_rel_id
sle_note_name sle_note_name
cb_spell cb_spell
rte_text rte_text
rte_print rte_print
st_1 st_1
sle_note_desc sle_note_desc
st_subtype st_subtype
ddlb_subtype ddlb_subtype
cb_model cb_model
cb_clear cb_clear
st_date_time st_date_time
sle_date_time sle_date_time
ddlb_type ddlb_type
sle_userid sle_userid
st_subject st_subject
st_type st_type
st_notes-key st_notes-key
st_userid st_userid
cb_delete cb_delete
cb_add cb_add
cb_update cb_update
cb_retrieve cb_retrieve
cb_exit cb_exit
cb_print cb_print
cb_import cb_import
cb_export cb_export
end type
global w_notes_maint w_notes_maint

type variables
//*********************************************************************************
// Script Name:Instance Variables
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:   Declare the NVO and its related structure as instance variables.
//
//*********************************************************************************
//
//	01/30/98	VAV 4.0 
// 	Stars 4.8 - Case NVO
// 09/12/02 JasonS Track 3172d
// 12/9/04 JasonS Track 3664 Case Component UPdate
//	04/30/09	Katie	GNL.600.5633	Added boolean for the pop_menu.
//
//*********************************************************************************
nvo_subset_functions inv_subset_functions
sx_subset_ids istr_Subset_Id 

n_cst_notes inv_notes

n_cst_case	inv_case

sx_subset_options istr_sub_opt  
string 	ib_query_id			
string 	ib_query_name		
string 	ib_query_case		
boolean 	ib_look_up_link_id
boolean	ib_new_note

string is_comp_upd_status

boolean ib_pop_menu
end variables

forward prototypes
public subroutine wf_setmodifyrights (boolean ab_switch)
public function integer wf_new_note_text ()
public function integer wf_lookup_pattern ()
public function integer wf_lookup_pdq ()
public subroutine wf_setmodified (boolean ab_switch)
public function integer wf_ismodified ()
end prototypes

event type integer ue_import();//*********************************************************************************
// Script Name:	w_notes_maint.ue_import
//
//	Arguments:		n/a
//						
//
// Returns:			Integer	-1	=	Error
//									 1	=	Successful
//
//	Description:	Import an ASCII or RTF file into rte_text.  
//						This will replace the existing text.
//		
//
//*********************************************************************************
//	
// 07/21/99	FDG	Stars 4.5.	Created
//	04/27/2000	Gary-R	Ts2173 Append import instead of overwriting
//	10/29/08	GaryR	SPR 5522	PowerBuilder 11 New RTE Changes
//
//*********************************************************************************

String	ls_path_filename,		&
			ls_filename
			
Integer	li_rc

li_rc	=	GetFileOpenName( "Import File",										&
									ls_path_filename,										&
									ls_filename,											&
									"RTF",													&
									"RTF Files (*.RTF), *.RTF,"					+	&
									"Text Files (*.TXT), *.TXT,"					+	&
									"Microsoft Word Files (*.DOC), *.DOC,"		+	&
									"HTML Files (*.HTML), *.HTML,"				+	&
									"Graphic Files (*.BMP;*.WMF;*.PNG;*.JPG;"	+	&
									"),*.BMP;*.WMF;*.PNG;*.JPG;*.JPEG" )
									
IF	li_rc	<>	1							&
OR	Len (ls_path_filename)	=	0	THEN
	Return	-1
END IF

CHOOSE CASE Upper( Right( ls_filename, 3 ) )
	CASE "RTF"
		rte_text.InsertDocument( ls_path_filename, FALSE, FileTypeRichText! )
	CASE "DOC"
		rte_text.InsertDocument( ls_path_filename, FALSE, FileTypeDoc! )
	CASE "TML"
		rte_text.InsertDocument( ls_path_filename, FALSE, FileTypeHTML! )
	CASE "BMP"
		rte_text.InsertPicture( ls_path_filename, 1 )
	CASE "WMF"
		rte_text.InsertPicture( ls_path_filename, 2 )
	CASE "PNG"
		rte_text.InsertPicture( ls_path_filename, 3 )
	CASE "JPG", "PEG"
		rte_text.InsertPicture( ls_path_filename, 4 )
	CASE ELSE
		rte_text.InsertDocument( ls_path_filename, FALSE, FileTypeText! )
END CHOOSE

Return	1								
end event

event type integer ue_export();//*********************************************************************************
// Script Name:	w_notes_maint.ue_export
//
//	Arguments:		n/a
//						
//
// Returns:			Integer	-1	=	Error
//									 1	=	Successful
//
//	Description:	Export the notes text to an RTF or TXT file
//						Note that the duplicate file check is done 
//						in the FileExists event of the RTE
//		
//
//*********************************************************************************
//	
// 07/21/99	FDG	Stars 4.5.	Created
// 10/27/00	GaryR	2315d	Conforming STARS to the HIPAA Act
//	10/29/08	GaryR	SPR 5522	PowerBuilder 11 New RTE Changes
//
//*********************************************************************************

String	ls_path_filename,		&
			ls_filename
			
Integer	li_rc

IF fx_disclaimer() <> 1 THEN RETURN 1	// 10/27/00	GaryR	2315d

li_rc	=	GetFileSaveName( "Export File",										&
									ls_path_filename,									&
									ls_filename,										&
									"RTF",												&
									"Rich Text Files (*.RTF), *.RTF,"		+	&
									"Text Files (*.TXT), *.TXT,"				+	&
									"Microsoft Word Files (*.DOC), *.DOC,"	+	&
									"HTML Files (*.HTML), *.HTML,"			+	&
									"Portable Document Format Files (*.PDF), *.PDF" )

// Check if user canceled
IF li_rc = 0 THEN Return 1										
										
CHOOSE CASE Upper( Right( ls_filename, 3 ) )
	CASE "RTF"
		rte_text.SaveDocument( ls_path_filename, FileTypeRichText! )
	CASE "TXT"
		rte_text.SaveDocument( ls_path_filename, FileTypeText! )
	CASE "DOC"
		rte_text.SaveDocument( ls_path_filename, FileTypeDoc! )
	CASE "TML"
		rte_text.SaveDocument( ls_path_filename, FileTypeHTML! )
	CASE "PDF"
		rte_text.SaveDocument( ls_path_filename, FileTypePDF! )
	CASE ELSE
		MessageBox ('ERROR', 'Invalid File Extension')
		Return -1
END CHOOSE

Return	1

end event

event ue_edit_case_closed();//*******************************************************************
//	Script			ue_edit_case_closed
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description		Prevent updating this window if the case is closed
//						or deleted.
//
//
//*******************************************************************
//	09/21/01	FDG	Stars 4.8.	Created
//  12/20/05 JasonS Track 4536d  Allow a note to be added to an indepent subset
//*******************************************************************

Boolean	lb_valid_case,			&
			lb_enabled

String	ls_rel_type,			&
			ls_rel_id
			
lb_valid_case	=	TRUE

ls_rel_type		=	Left (ddlb_type.text, 2)
ls_rel_id		=	sle_rel_id.text

CHOOSE CASE ls_rel_type
	CASE 'CA'
		// Case note
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id)
	CASE 'PA'
		// Patterns note
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, 'PAT')
	CASE 'PQ'
		// PDQ note
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, 'PDQ')
	CASE 'SS'
		// Patterns note
		// 12/20/05 JasonS Track 4536d - If it is a subset, I don't care if is linked to a closed case, this note
		// is being added to the subset not the case.
		//lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, 'SUB')
END CHOOSE

IF	lb_valid_case	=	FALSE		THEN
	ddlb_type.enabled			=	FALSE
	ddlb_subtype.enabled		=	FALSE
	sle_rel_id.enabled		=	FALSE
	sle_date_time.enabled	=	FALSE
	sle_note_name.enabled	=	FALSE
	sle_userid.enabled		=	FALSE
	cb_add.enabled				=	FALSE
	cb_clear.enabled			=	FALSE
	cb_delete.enabled			=	FALSE
	cb_import.enabled			=	FALSE
	cb_model.enabled			=	FALSE
	cb_update.enabled			=	FALSE
	This.wf_SetModifyRights (FALSE)
END IF

end event

event ue_set_mod_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_mod_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for modifying 
//						the case notes component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************
cb_update.enabled = ab_switch
cb_delete.enabled = ab_switch
cb_model.enabled = ab_switch
cb_clear.enabled = ab_switch
cb_import.enabled = ab_switch

end event

event ue_set_create_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_create_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable the create button
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//	09/10/07 Katie	SPR 5162 Added additional items from the Notes window.
//*********************************************************************************

cb_add.enabled = ab_switch
ddlb_subtype.enabled = ab_switch
ddlb_type.enabled = ab_switch
sle_note_name.enabled = ab_switch
sle_rel_id.enabled = ab_switch
end event

event ue_set_update_availability();//*********************************************************************************
// Script Name:	ue_set_update_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the case
//						notes component base on the update status returned from
//						n_cst_case.
//
//*********************************************************************************
//	12/06/04	JasonS	Track 3664	Created.
// 09/30/05	MikeF	SPR4512d	Create / Update button enabling issues
//	02/04/06 JasonS	Track 4625d  call set content availabliltiy
// 03/11/06  JasonS Track 4677d  Fix AL to enable update button instead of create button
//*********************************************************************************
String ls_case_id, ls_case_spl, ls_case_ver

ls_case_id	=	Left (sle_rel_id.text, 10)
ls_case_spl	=	Mid (sle_rel_id.text, 11, 2)
ls_case_ver	=	Mid (sle_rel_id.text, 13, 2)

is_comp_upd_status = inv_case.uf_get_comp_upd_status_lead('CASENOTES', ls_case_id , ls_case_spl, ls_case_ver)

choose case is_comp_upd_status 
	case 'AO'
		this.event ue_set_mod_availability(false)
		this.event ue_set_create_availability(ib_new_note)
		this.event ue_set_content_availability(ib_new_note)
	case 'RO'
		this.event ue_set_mod_availability(false)
		this.event ue_set_create_availability(false)
		this.event ue_set_content_availability(false)
	case 'AL'
		this.event ue_set_mod_availability(true)
		this.event ue_set_create_availability(ib_new_note)
		this.event ue_set_content_availability(true)
end choose


end event

event ue_set_content_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_content_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for modifying 
//						the notes content. (Desc/Text)
//
//*********************************************************************************
//
//	02/04/06 	JasonS	Track 4625d 	Created.
//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//
//*********************************************************************************

cb_spell.enabled = ab_switch
sle_note_desc.enabled = ab_switch
rte_text.displayonly = NOT ab_switch
end event

event type boolean ue_edit_case_referred();//*********************************************************************************
// Script Name:	ue_edit_case_referred
//
//	Arguments:		n/a
//
//	 Returns:		boolean
//
// Description:   Places call to n_cst_case.uf_edit_case_referred(), passing case_id,
//						case_spl and case_ver, to check if the case has been referred.  If
//						it has, cb_delete is disabled to prevent user from deleting and updating case
//						from referred cases.
//
//*********************************************************************************
//
// Katie	02/21/07	SPR 4536 Created
//
//*********************************************************************************
Boolean lb_valid_case

lb_valid_case = inv_case.uf_edit_case_deleted(trim(sle_rel_id.text))

IF lb_valid_case = FALSE THEN
	ddlb_type.enabled			=	FALSE
	ddlb_subtype.enabled		=	FALSE
	sle_rel_id.enabled		=	FALSE
	sle_date_time.enabled	=	FALSE
	sle_note_name.enabled	=	FALSE
	sle_userid.enabled		=	FALSE
	cb_add.enabled				=	FALSE
	cb_clear.enabled			=	FALSE
	cb_delete.enabled			=	FALSE
	cb_import.enabled			=	FALSE
	cb_model.enabled			=	FALSE
	cb_update.enabled			=	FALSE
	This.wf_SetModifyRights (FALSE)
END IF

Return lb_valid_case
end event

public subroutine wf_setmodifyrights (boolean ab_switch);//*********************************************************************************
// Script Name:	wf_setmodifyrights
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description: Enable or Disable import, spell check and the right text window.
//
//*********************************************************************************
//
//	04/27/00	GaryR	Ts2173	Revoke modify rights if user did not create open note
//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//	04/29/09	Katie		GNL.600.5633	Removed setting boolean for PopMenu.
//
//*********************************************************************************

cb_import.Enabled = ab_switch
cb_spell.enabled = ab_switch
ib_pop_menu = ab_switch
rte_text.DisplayOnly = NOT ab_switch
end subroutine

public function integer wf_new_note_text ();//*********************************************************************************
// Script Name:	w_notes_maint.wf_new_note_text()
//
//	Arguments:		None
//
// Returns:			Integer -	-1	=	Error
//										 0	=	No text to insert.
//										 1	=	Success
//
//	Description:	This function is needed because the printing of the note
//						can now only come directly from the RTE.  It can no longer be
//						printed from a datawindow.  As a result, it is important to
//						include as much header information as possible in the note.
//
//*********************************************************************************
//	
// 07/21/99 FDG	Stars 4.5.	Created
//	02/01/00	FDG	Stars 4.5.	Allow for patterns notes.
// 01/23/02 JSB   Track 2695  Trap for when notes come from Subset List. Default
//                            relationship is to Case ID and not Subset ID. Added
//                            new variable is_notes_subset_id to n_cst_notes and
//                            will now paste subset id into the note as well.
//	04/29/04	GaryR	Track 6822c	Prevent overwriting the contents in the clipboard
//
//*********************************************************************************


String	ls_text

CHOOSE CASE inv_notes.is_notes_from
	CASE 'CA'
		ls_text	=	'Case: '
	CASE 'PQ'
		ls_text	=	'Pre-Defined Query: '
	CASE 'PA'
		ls_text	=	'Pattern: '
	CASE 'SS'
		ls_text	=	'Subset: '
	CASE ELSE
		Return 0
END CHOOSE


// JSB Track 2695  1/23/02
IF  inv_notes.is_notes_from = 'SS' &
AND inv_notes.is_notes_rel_type = 'CA' &
AND inv_notes.is_notes_sub_type = 'SB' THEN
   ls_text = 'Case: ' + inv_notes.is_notes_rel_id + '~r~n~r~n'
	ls_text = ls_text + 'Subset: ' + inv_notes.is_notes_subset_id + '~r~n~r~n'
ELSE
	ls_text	=	ls_text	+	inv_notes.is_notes_rel_id	+	'~r~n~r~n'
END IF
//ls_text	=	ls_text	+	inv_notes.is_notes_rel_id	+	'~r~n~r~n'
// END JSB Track 2695  1/23/02

IF  Len (ddlb_type.text)	>	0		THEN
	ls_text	=	ls_text	+	"Related Type: "	+	ddlb_type.text	+	'~r~n~r~n'
END IF

IF  Len (ddlb_subtype.text)	>	0		THEN
	ls_text	=	ls_text	+	"SubType: "	+	ddlb_subtype.text	+	'~r~n~r~n'
END IF

// Move the text to rte_text
rte_text.ReplaceText( ls_text )

Return 1
end function

public function integer wf_lookup_pattern ();//*********************************************************************************
// Script Name:	wf_lookup_pattern
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This function is called when sle_link_id is right-clicked.  This
//						function will get the user-defined pattern ID from the
//						patterns window (w_sampling_analysis_new_response).
//
//	Notes:			Under all other conditions, a subset ID would be required
//						to open patterns, but it can't occur because the subset is
//						unknown.  As a result, all possible invoice types must be
//						passed to the patterns window.
//
//*********************************************************************************
//	
// 02/25/99 FDG	Stars 4.5	Created
//
//*********************************************************************************

Integer	li_rc

Long		ll_row,						&
			ll_rowcount

String	ls_filter,					&
			ls_table_type,				&
			ls_empty[],					&
			ls_pattern_id

sx_subset_options	lstr_sub_opt

istr_sub_opt										=	lstr_sub_opt

istr_sub_opt.patt_struc.come_from			=	'LOOKUP'
istr_sub_opt.patt_struc.case_id				=	gv_active_case
istr_sub_opt.patt_struc.sub_src_type		=	'SS'
istr_sub_opt.patt_struc.subset_id			=	'NONE'
istr_sub_opt.patt_struc.subset_table_type	=	'ML'
istr_sub_opt.patt_struc.table_type			=	ls_empty

// Get all possible invoice types (not including 'MC')
ls_filter	=	"rel_type = 'GP'"

li_rc			=	w_main.dw_stars_rel_dict.SetFilter("")
li_rc			=	w_main.dw_stars_rel_dict.Filter()
li_rc			=	w_main.dw_stars_rel_dict.SetFilter(ls_filter)
li_rc			=	w_main.dw_stars_rel_dict.Filter()

ll_rowcount	=	w_main.dw_stars_rel_dict.RowCount()

FOR	ll_row	=	1	TO	ll_rowcount
	ls_table_type	=	w_main.dw_stars_rel_dict.object.id_2 [ll_row]
	istr_sub_opt.patt_struc.table_type [ll_row]	=	ls_table_type
NEXT

OpenWithParm (w_sampling_analysis_new_response, istr_sub_opt)

ls_pattern_id	=	Message.StringParm

IF	ls_pattern_id				=	''				&
OR	Upper (ls_pattern_id)	=	'ERROR'		THEN
	MessageBox ('Pattern Lookup', 'No pattern was selected.')
	Return	0
END IF

sle_rel_id.text	=	ls_pattern_id

Return	1

end function

public function integer wf_lookup_pdq ();//*********************************************************************************
// Script Name:wf_lookup_pdq
//
// Arguments:	N/A
//
// Returns:		integer
//
// Description: Open the right-mouse menu for the notes screen.
//
//*********************************************************************************
//
//
//*********************************************************************************
string ls_query_id, ls_sql
int li_orig_row
inv_queryengine = create uo_cst_queryengine
	gv_from = 'U'
			//	Clear the query engine parms from previous attempts
			inv_queryengine.uf_clear_query_parms()
			//	'USE' is passed as the query ID to query engine
			inv_queryengine.uf_set_query_id('USE')
			// Set the appropriate Query Engine Mode
			inv_queryengine.uf_set_query_engine_mode( 'PDQ' ) 
			// Open the query engine window
			inv_queryengine.uf_open_query_engine()
			//	Get the query ID set from w_query_engine
			ls_query_id	=	gnv_app.of_get_query_id()
			// If no query was selected, then display a message and get out
			IF	IsNull (ls_query_id)					&
				OR	Trim (ls_query_id)	<	'  '		THEN
				MessageBox ('Warning', 'No query was selected from the query engine window')
				Return 1
			END IF
			n_ds ds_sub_opt_case_link
			ds_sub_opt_case_link = CREATE n_Ds
			ds_sub_opt_case_link.DataObject = 'd_sub_opt_case_link'
			ds_sub_opt_case_link.SetTransObject(stars2ca)
			ds_sub_opt_case_link.of_SetTrim (TRUE)					
			ls_sql = ds_sub_opt_case_link.GetSqlSelect()
			ls_sql = ls_sql + "WHERE CASE_LINK.LINK_KEY = '" + Upper( ls_query_id ) + "'" + &
			" and CASE_LINK.CASE_ID = 'NONE'" + &
			" and CASE_LINK.LINK_TYPE = '" + 'PDQ' + "'"
			ds_sub_opt_case_link.SetSqlSelect(ls_Sql)
			li_orig_row = ds_sub_opt_case_link.Retrieve() 
			if stars2ca.of_check_status() < 0 Then
				MessageBox("Error","Cannot retrieve " + 'PDQ' + " information",StopSign!)
				destroy(ds_sub_opt_case_link)
				return 1
			end if
 			If li_orig_row <> 1 then
				MessageBox("Error","Cannot link, mutiple " + 'PDQ' + "s: " + ls_query_id + " exist",StopSign!)
				destroy(ds_sub_opt_case_link)
				return 1
			END IF

			//	Display the selected query
			sle_rel_id.text	=	ds_sub_opt_case_link.Object.Link_name[li_orig_row]
			ib_query_id	=	ds_sub_opt_case_link.Object.Link_key[li_orig_row]
			ib_query_name	=	ds_sub_opt_case_link.Object.Link_name[li_orig_row]
			ib_query_case = ds_sub_opt_case_link.Object.case_id[li_orig_row] + ds_sub_opt_case_link.Object.case_spl[li_orig_row] + ds_sub_opt_case_link.Object.case_ver[li_orig_row]
			ib_look_up_link_id = true
destroy inv_queryengine
return 1
end function

public subroutine wf_setmodified (boolean ab_switch);//*********************************************************************************
// Script Name:wf_set_modified
//
// Arguments:	boolean ab_switch
//
// Returns:		N/A
//
// Description: Set the ret as disabled or enabled.
//
//*********************************************************************************
//
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
//
//*********************************************************************************

rte_text.modified = ab_switch
end subroutine

public function integer wf_ismodified ();//*********************************************************************************
// Script Name:	w_notes_maint.wf_IsModified()
//
//	Arguments:		None
//
// Returns:			Integer -	-1	=	Error
//										 0	=	Canceled
//										 1	=	Success
//
//	Description:	This method will validate if updates are pending on the note.
//						If there are unsaved changes, will prompt the user to save.
//
//*********************************************************************************
//	
//	09/18/02	GaryR	Track 4598c	Validate pending updates
// 12/16/02 JasonS Track 2883d Check if desc is modified
//	01/24/03	GaryR	Track	3417d Validate pending updates
// 02/28/06 JasonS  Track 4625d Only ask to save changes if the update or create button are enabled
//*********************************************************************************

Integer	li_rt

IF rte_text.modified and (cb_add.enabled or cb_update.enabled) THEN
	li_rt = MessageBox( "Save Changes", "Do you want to save changes to note?", &
																				Exclamation!, YesNoCancel!, 1 )
	CHOOSE CASE li_rt
		CASE 1	//Save
			IF cb_add.enabled THEN
				IF cb_add.Event Clicked() < 0 THEN Return -1
			ELSE
				IF cb_update.Event Clicked() < 0 THEN Return -1
			END IF
		CASE 2	//Don't Save
		CASE ELSE	//Cancel
			Return 0
	END CHOOSE
END IF

Return 1
end function

event open;call super::open;//*********************************************************************************
// Script Name:	w_notes_maint.open
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	
//		
//
//*********************************************************************************
//	
//	04/20/98 FDG	Track 1093.  Query Engine notes should disable
//						sle_rel_id and related type.
//	05-12-98 NLG	1. change globals to nvo
//	07/21/99	FDG	Stars 4.5.  Use an RTE control (rte_text) instead of an MLE
//	02/01/00	FDG	Stars 4.5.	Allow for patterns notes.
// 04/27/00	GaryR	Ts2173	Disable modify rights if user did not create note
//	12/13/00	FDG	Stars 4.7.  Make the retrieval of note_text DBMS-independent
//	09/21/01	FDG	Stars 4.8.1	No updates can occur if the case is closed
//	09/17/02	GaryR	SPR 4182c	Pass three unique key arguments for notes retrieval
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
// 10/17/02 Jason	Track 2883d  Add note_desc to sql
// 10/29/02	Jason Track 2883d  Disable note desc
//	08/05/03	GaryR	Track 3438d	Prevent word wrapping
//	09/05/03	GaryR Track 3438d	Scroll to the first character on the first line
//	04/29/04	GaryR	Track 6822c	Prevent overwriting the contents in the clipboard
// 12/9/04 JasonS Track 3664 Case Component Update
// 09/30/05	MikeF	SPR4512d	Create / Update button enabling issues
//	02/21/07	Katie	SPR 4536	Added code to handle DL and RC Cases
//	09/10/07 Katie SPR 5162 Removed enabling/disabling on Case level.  Overwritten 
//						by functions in postopen so they weren't doing anything anyway.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//*********************************************************************************

//Create the NVO
Inv_Subset_Functions = create nvo_subset_functions //VAV 4.0 1/30/98
this.of_set_sys_cntl_range(TRUE)//ts2020c 

// OPEN EVENT FOR W_NOTES_MAINT
int lv_sqldbcode,rc, li_rc
string lv_sqlerrtext,lv_sqlusrmsg
string xcode,xdesc,lv_add_item, lv_note_rel_type, lv_note_sub_type
string ycode, ydesc
String ls_desc, ls_rte_ind						// FDG 07/21/99

datetime lv_datetime
gv_relist = 0

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
cb_Update.enabled = false
cb_add.enabled    = false
cb_delete.enabled = false
//wf_SetModifyRights( FALSE )	//Gary-R	04/27/2000	Ts2173
st_subtype.enabled = false

inv_case	=	CREATE	n_cst_case				// FDG 09/21/01

//  Load Note Subtype codes into DDLB from CODE table.  "NS"

declare c1 cursor for
  select code_code, code_desc from code where code_type = 'NS'
using stars2ca;

open c1;

if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Opening the Code Table')
	return
end if

do while stars2ca.sqlcode = 0 
   fetch c1 into :xcode, :xdesc;
	//  Test for EOF.
 	if stars2ca.of_check_status() = 100 then exit
	//  Test for any abnormal errors.  If any found, close table and exit.
	if stars2ca.sqlcode <> 0 Then
		close c1;
		if stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error closing the Code Table during a Reading Error.')
			return
		end if
		errorbox(stars2ca,'Error reading the Code Table.')
		return
	end if

   lv_add_item = xcode + ' - ' + xdesc
	AddItem(ddlb_subtype,lv_add_item)
loop

	
AddItem(ddlb_subtype,'                                     ')

declare c2 cursor for
  select code_code, code_desc from code where code_type = 'NT'
using stars2ca;

open c2;

if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Opening the Code Table')
	return
end if

do while stars2ca.sqlcode = 0 
   fetch c2 into :ycode, :ydesc;
	//  Test for EOF.
 	if stars2ca.of_check_status() = 100 then exit
	//  Test for any abnormal errors.  If any found, close table and exit.
	if stars2ca.sqlcode <> 0 Then
		close c2;
		if stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error closing the Code Table during a Reading Error.')
			return
		end if
		errorbox(stars2ca,'Error reading the Code Table.')
		return
	end if

   lv_add_item = ycode + ' - ' + ydesc
	AddItem(ddlb_type,lv_add_item)
loop

//  close the code table and disconnect from the database.
close c2;
if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error closing the Code Table.')
	return
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	


//  'A' is coming directly from the menu.
//  'N' is coming from w_notes_list.
If gv_from = 'A'  or gv_from = 'N' then
	this.title = 'Note Add'
	ib_new_note			= TRUE
	cb_add.enabled    = true
	cb_add.default    = true
	wf_SetModifyRights( TRUE )	//Gary-R	04/27/2000	Ts2173
	sle_userid.text = gc_user_id
	//nlg 5-12-98
	If inv_notes.is_notes_id = '' then
		sle_note_name.text = fx_get_next_key_id('NOTE')
	Else
		sle_note_name.text = inv_notes.is_notes_id//gv_notes_name	
	End If
	If sle_note_name.text = 'ERROR' then
		Messagebox('EDIT','Unable to get System Controlled Note Id')
	End IF

	sle_date_time.text = inv_sys_cntl.of_get_default_date()//ts2020c
	//NLG 5-12-98 change globals to nvo
	If inv_notes.is_notes_rel_type <> '' and inv_notes.is_notes_rel_type <> 'AA' then
		ddlb_type.selectitem(inv_notes.is_notes_rel_type,0)
	Else 
		if inv_notes.is_notes_rel_type='AA'  then
			ddlb_type.selectitem('CA',0)
		End If
	end if
	if ddlb_type.text='CA' then
		ddlb_subtype.enabled=true
	end if
	//nlg 5-12-98
	sle_rel_id.text=inv_notes.is_notes_rel_id
	ddlb_subtype.selectitem(inv_notes.is_notes_sub_type,0)
	//NLG 6-1-98 															BEGIN***
	//if coming from subset list or query engine, disable rel id, sub type, rel type
	// FDG 02/01/00 - Allow for patterns notes
	IF inv_notes.is_notes_from = 'PQ' &
	OR inv_notes.is_notes_from = 'PA' &
	OR inv_notes.is_notes_from = 'SS' THEN
		sle_rel_id.enabled	=	FALSE
		ddlb_type.enabled		=	FALSE
		ddlb_subtype.enabled = 	FALSE
	END IF
	// FDG 07/21/99 - Insert the initial text for the note depending on where you are coming from
	This.wf_new_note_text()
	//NLG 6-1-98															END***
	
	sle_note_name.SetFocus()
	RETURN
End If

sle_userid.text    = gv_user_id
sle_note_name.text = inv_notes.is_notes_id
sle_rel_id.text    = inv_notes.is_notes_rel_id

li_rc = rte_text.of_clear()

// FDG 12/13/00 - Retrieve note_text separately to make it
//	DBMS-independent
select	user_id,
			note_datetime, 
			note_rel_type, 
			note_sub_type, 
			rte_ind,
			note_desc		// JasonS 10/17/02 Track 2883d
into 		:sle_userid.text,
			:lv_datetime, 
			:lv_note_rel_type, 
			:lv_note_sub_type, 
			:ls_rte_ind,
			:sle_note_desc.text	// JasonS 10/17/02 Track 2883d
from		notes
where 	note_id       = Upper( :inv_notes.is_notes_id ) and
			note_rel_type = Upper( :inv_notes.is_notes_rel_type ) and 
			note_rel_id   = Upper( :inv_notes.is_notes_rel_id )
using 	stars2ca;

If stars2ca.of_check_status() = 100 then

	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Committing to Stars2')
		Return
	End If	
	setmicrohelp(w_main,'Record Does Not Exist May have been deleted')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
	LV_SQLUSRMSG = 'Error Retrieving Record ' + stars2ca.sqlerrtext
	Errorbox(stars2ca,lv_sqlusrmsg)
	cb_exit.PostEvent(Clicked!)
	RETURN
End If

//	09/17/02	GaryR	SPR 4182c
//ls_desc	=	gnv_sql.of_get_note_text (inv_notes.is_notes_id)	// FDG 12/13/00
ls_desc	=	gnv_sql.of_get_note_text( inv_notes.is_notes_id, &
													inv_notes.is_notes_rel_type, inv_notes.is_notes_rel_id )

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then

	Messagebox('EDIT','Error Committing to Stars2')
	Return
End If	


// FDG 07/21/99 - Move retrieved note_text into rte_text
IF	ls_rte_ind	=	'Y'	THEN
	rte_text.PasteRTF (ls_desc, Detail!)
ELSE
	rte_text.ReplaceText( ls_desc )
END IF

//	Scroll to the top
rte_text.SelectText ( 1, 1, 0, 0 )

wf_SetModified( FALSE )		//	09/18/02	GaryR	SPR 4598c

//DJP 7/24/95 prob#730 - made this 3d upper, grey instead of disabled
sle_note_name.enabled = false
sle_rel_id.enabled    = false
sle_date_time.text    = string(lv_datetime,"mmm dd yyyy  h:mmAM/PM")
ddlb_type.enabled     = false
cb_model.enabled = true
cb_retrieve.enabled=false

gv_user_id = sle_userid.text
If gv_user_id <> gc_user_id then
	cb_exit.default   = true	
	ddlb_type.selectitem(lv_note_rel_type,0)		//DKG 01/05/95 Added to fill Related Type and Sub Type DDLBs when looking at someone else's notes. I could not find a reason why these fields shouldn't be displayed.
	ddlb_subtype.selectitem(lv_note_sub_type,0)	//DKG 01/05/95 Added to fill Related Type and Sub Type DDLBs when looking at someone else's notes. I could not find a reason why these fields shouldn't be displayed.
	setfocus(cb_retrieve)
	wf_SetModifyRights( FALSE )	//Gary-R	04/27/2000	Ts2173
Else
	cb_update.enabled = true
	cb_delete.enabled = true
	wf_SetModifyRights( TRUE )	//Gary-R	04/27/2000	Ts2173

	cb_update.default = true
	if ddlb_type.selectitem(lv_note_rel_type,0)=0 then
		ddlb_type.enabled=true
		setfocus(ddlb_type)
		messagebox('EDIT','Please select a relation type.',stopsign!)
	elseif ddlb_subtype.selectitem(lv_note_sub_type,0)=0 then
		ddlb_type.postevent(selectionchanged!)
		messagebox('EDIT','Subtype has been altered.',exclamation!)
	end if
End If	

// JasonS 10/29/02 Begin - Track 2883d
if not cb_update.enabled then
	sle_note_desc.enabled = false
else
	sle_note_desc.enabled = true
end if
// JasonS 10/29/02 End - Track 2883d

setpointer(arrow!)

end event

event close;call super::close;//*********************************************************************************
// Script Name:wf_set_modified
//
// Arguments:	N/A
//
// Returns:		long
//
// Description: Close the window.
//
//*********************************************************************************
//
//	03/24/98	ASJ 4.0 Fix Track 960
//	09/21/01	FDG	Stars 4.8.	Destroy inv_case
//
//*********************************************************************************
If gv_from <> 'A' then 
	gv_from = 'L'
   If IsValid(w_notes_list) then
		setfocus(w_notes_list.dw_1)
   	triggerevent(w_notes_list.dw_1,rowfocuschanged!)
   End If 
End If

//VAV 4.0 2/3/98 The NVO created in the open script must be destroyed.
Destroy(Inv_Subset_Functions)

// FDG 09/21/01
IF	IsValid (inv_case)		THEN
	destroy	inv_case
END IF


end event

on w_notes_maint.create
int iCurrent
call super::create
this.sle_rel_id=create sle_rel_id
this.sle_note_name=create sle_note_name
this.cb_spell=create cb_spell
this.rte_text=create rte_text
this.rte_print=create rte_print
this.st_1=create st_1
this.sle_note_desc=create sle_note_desc
this.st_subtype=create st_subtype
this.ddlb_subtype=create ddlb_subtype
this.cb_model=create cb_model
this.cb_clear=create cb_clear
this.st_date_time=create st_date_time
this.sle_date_time=create sle_date_time
this.ddlb_type=create ddlb_type
this.sle_userid=create sle_userid
this.st_subject=create st_subject
this.st_type=create st_type
this.st_notes-key=create st_notes-key
this.st_userid=create st_userid
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_exit=create cb_exit
this.cb_print=create cb_print
this.cb_import=create cb_import
this.cb_export=create cb_export
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_rel_id
this.Control[iCurrent+2]=this.sle_note_name
this.Control[iCurrent+3]=this.cb_spell
this.Control[iCurrent+4]=this.rte_text
this.Control[iCurrent+5]=this.rte_print
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_note_desc
this.Control[iCurrent+8]=this.st_subtype
this.Control[iCurrent+9]=this.ddlb_subtype
this.Control[iCurrent+10]=this.cb_model
this.Control[iCurrent+11]=this.cb_clear
this.Control[iCurrent+12]=this.st_date_time
this.Control[iCurrent+13]=this.sle_date_time
this.Control[iCurrent+14]=this.ddlb_type
this.Control[iCurrent+15]=this.sle_userid
this.Control[iCurrent+16]=this.st_subject
this.Control[iCurrent+17]=this.st_type
this.Control[iCurrent+18]=this.st_notes-key
this.Control[iCurrent+19]=this.st_userid
this.Control[iCurrent+20]=this.cb_delete
this.Control[iCurrent+21]=this.cb_add
this.Control[iCurrent+22]=this.cb_update
this.Control[iCurrent+23]=this.cb_retrieve
this.Control[iCurrent+24]=this.cb_exit
this.Control[iCurrent+25]=this.cb_print
this.Control[iCurrent+26]=this.cb_import
this.Control[iCurrent+27]=this.cb_export
end on

on w_notes_maint.destroy
call super::destroy
destroy(this.sle_rel_id)
destroy(this.sle_note_name)
destroy(this.cb_spell)
destroy(this.rte_text)
destroy(this.rte_print)
destroy(this.st_1)
destroy(this.sle_note_desc)
destroy(this.st_subtype)
destroy(this.ddlb_subtype)
destroy(this.cb_model)
destroy(this.cb_clear)
destroy(this.st_date_time)
destroy(this.sle_date_time)
destroy(this.ddlb_type)
destroy(this.sle_userid)
destroy(this.st_subject)
destroy(this.st_type)
destroy(this.st_notes-key)
destroy(this.st_userid)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_exit)
destroy(this.cb_print)
destroy(this.cb_import)
destroy(this.cb_export)
end on

event ue_preopen;//*********************************************************************************
// Script Name:	ue_preopen
//
//	Arguments:		n/a
//
//	 Returns:		n/a
//
// Description:   Set inv_notes variable.
//
//*********************************************************************************
//
//05-12-98	NLG	1.	change globals to nvo
//
//*********************************************************************************

inv_notes = message.PowerObjectParm


end event

event ue_postopen;call super::ue_postopen;//*********************************************************************************
// Script Name:	ue_postopen
//
//	Arguments:		n/a
//
//	 Returns:		n/a
//
// Description:   Set's RTE's modified property to FALSE.  Handle case security.  
//
//*********************************************************************************
//
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
//	12/9/04  JasonS Track 3664 Case Component Update
//	05/20/09	GaryR	GNL.600.5633.012	Provide keyboard alternative to RTE focus bug
//
//*********************************************************************************

IF inv_notes.is_notes_from = "MM" THEN wf_SetModified( FALSE )

if trim(left(ddlb_type.text,2)) = 'CA' then
	this.event ue_set_update_availability()
	this.event ue_edit_case_referred()
end if

IF cb_add.enabled THEN
	cb_update.enabled = FALSE
END IF

cb_exit.SetFocus()
end event

event ue_open_rmm;call super::ue_open_rmm;//*********************************************************************************
// Script Name:	w_notes_maint.ue_open_rmm
//
// Arguments:	N/A
//
// Returns:		N/A
//
// Description: Open the right-mouse menu for the notes screen.
//
//*********************************************************************************
//
//	04/29/09	Katie	GNL.600.5633	Initial Creation.
//
//*********************************************************************************

boolean		lb_frame
string			ls_selectedtext
m_notes		lm_notes
window		lw_parent
window		lw_frame
window		lw_sheet
window		lw_childparent

if ib_pop_menu then 
	// Get the parent window.
	rte_text.of_GetParentWindow (lw_parent)
	if IsValid (lw_parent) then
		// Get the MDI frame window if available
		lw_frame = lw_parent
		do while IsValid (lw_frame)
			if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
				lb_frame = true
				exit
			else
				lw_frame = lw_frame.ParentWindow()
			end if
		loop
		
		if lb_frame then
			// If MDI frame window is available, use it as the reference point for the
			// popup menu for sheets (windows opened with OpenSheet function) or child windows
			if lw_parent.windowtype = child! then
				lw_parent = lw_frame
			else
				lw_sheet = lw_frame.GetFirstSheet()
				if IsValid (lw_sheet) then
					do
						// Use frame reference for popup menu if the parentwindow is a sheet
						if lw_sheet = lw_parent then
							lw_parent = lw_frame
							exit
						end if
						lw_sheet = lw_frame.GetNextSheet (lw_sheet)
					loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
				end if
			end if
		else
			// SDI application.  All windows except for child windows will use the parent
			// window of the control as the reference point for the popmenu
			if lw_parent.windowtype = child! then
				lw_childparent = lw_parent.ParentWindow()
				if IsValid (lw_childparent) then
					lw_parent = lw_childparent
				end if
			end if
		end if
	else
		return
	end if
	
	lm_notes = create m_notes
	lm_notes.of_SetParent (this)
	
	ls_selectedtext = rte_text.SelectedText()
	if Len (ls_selectedtext) > 0 then
		lm_notes.m_cut.enabled = true
		lm_notes.m_copy.enabled = true
	else
		lm_notes.m_cut.enabled = false
		lm_notes.m_copy.enabled = false
	end if
	
	lm_notes.m_paste.enabled = true
	lm_notes.m_selectall.enabled = true
	
	lm_notes.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
	
	destroy lm_notes
end if
end event

type sle_rel_id from u_sle within w_notes_maint
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Related ID"
string accessibledescription = "Lookup Field - Related ID"
integer x = 1687
integer y = 120
integer width = 923
integer height = 76
integer taborder = 30
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 20
end type

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:sle_rel_id.rbuttonup
//
//	Arguments:		N/A
//
// Returns:			long
//
//	Description:  Lookup
//
//*********************************************************************************
//
// 09/11/02 JasonS Track 3172d
// 09/13/05	MikeF SPR4481d	Populating Subset ID rather than Name
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

sx_subset_use lstr_subset_use
sx_subset_options	lstr_sub_opt

choose case left(ddlb_type.text,2)
	case 'CA'
		gv_from = 'AC'
		open(w_case_list_response)
		if gv_result <> 100 then
			sle_rel_id.text = gv_active_case
		end if
	case 'PA'
		wf_lookup_pattern()

	case 'PQ'
		wf_lookup_pdq()
		
	case 'SS'
		OpenWithParm(w_subset_use,lstr_subset_use,parent)
		if gv_result <> 100 then
			sle_rel_id.text = gc_active_subset_name
		end if
	case else
		Messagebox("Warning.", "You must select a related type~r~nbefore you can lookup a value.")
end choose
end event

type sle_note_name from u_sle within w_notes_maint
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Note ID"
string accessibledescription = "Lookup Field - Note ID"
integer x = 439
integer y = 120
integer width = 818
integer height = 76
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 10
end type

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:sle_note_name.rbuttondown
//
//	Arguments:		N/A
//
// Returns:			long
//
//	Description:	Notes lookup.
//
//*********************************************************************************
//
//	04/27/2000	Gary-R	Ts2173	Create lookup of notes.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

Int 			li_ctr, i
n_cst_notes lnv_notes
SetPointer( HourGlass!)

// Pass parameters and open the notes list response window
gv_from = "L"
lnv_notes.is_notes_from = "MM"
OpenWithParm( w_notes_list_response, lnv_notes )

IF Message.DoubleParm = 1 THEN	
	// Populate the sle's with returned values
	lnv_notes = Message.PowerObjectParm
	sle_note_name.Text = lnv_notes.is_notes_id
	ddlb_type.Text = lnv_notes.is_notes_rel_type
	sle_rel_id.Text = lnv_notes.is_notes_rel_id
	
	// Trigger retrieve button
	cb_retrieve.EVENT clicked()
END IF
end event

type cb_spell from u_cb within w_notes_maint
string accessiblename = "Spelling"
string accessibledescription = "Spelling"
integer x = 311
integer y = 1748
integer width = 306
integer height = 108
integer taborder = 80
boolean enabled = false
string text = "Spelling"
end type

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	cb_exit.clicked
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	clicked for cb_exit of w_notes_maint
//
//*********************************************************************************
//
//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//	11/12/08	GaryR	SPR 4376	Check for any runtime errors with the spelling control
//	12/02/08	GaryR	SPR 4376	Use the Sentry Spell Checking Engine DLL
//
//*********************************************************************************

n_cst_wspell lnv_spell

TRY
	lnv_spell.of_check_rte( Parent, rte_text )
CATCH (RunTimeError lerr_pdf)
	MessageBox( "Control Error", "The spell checking control is not properly installed on your system." + &
						 "~n~rPlease contact your System Administrator for assistance.", StopSign! )
END TRY
end event

type rte_text from u_rte within w_notes_maint
event ue_paste_date ( )
string accessiblename = "Text Editor"
string accessibledescription = "Text Editor"
integer x = 5
integer y = 388
integer width = 2789
integer height = 1352
integer taborder = 60
boolean init_hscrollbar = true
boolean init_vscrollbar = true
boolean init_wordwrap = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
long init_leftmargin = 1000
long init_topmargin = 1000
long init_rightmargin = 1000
long init_bottommargin = 1000
string init_documentname = "Note"
end type

event ue_paste_date();//*********************************************************************************
// Script Name:	w_notes_maint.ue_paste_date()
//
//	Arguments:		None
//
// Returns:			None
//
//*********************************************************************************
//	
// 10/06/99 FNC	Stars 4.5.	Created
//						This function pastes today's date in a note.
//	04/29/04	GaryR	Track 6822c	Prevent overwriting the contents in the clipboard
//
//*********************************************************************************

string ls_text
Datetime ldte_datetime

ldte_datetime = gnv_app.of_get_server_date_time()

ls_text	=	String(ldte_datetime, 'm/d/yyyy hh:mm:ss') + ' '
// Move the text to rte_text
rte_text.ReplaceText( ls_text )

Return
end event

event fileexists;call super::fileexists;//*********************************************************************************
// Script Name:	rte_text.fileexists
//
//	Arguments:		string filename
//
// Returns:			long
//
//	Description:	// This event automatically triggers when exporting the text to a file
//	and the file already exists.  Display a message and allow the user
//	to overwrite the file or cancel the export.
//
//*********************************************************************************
//
//
//*********************************************************************************


Integer	li_rc

li_rc	=	MessageBox ('Warning', 'The specified file already exists.  '	+	&
							'Do you want to overwrite it?', Question!, YesNo!, 1)
							
IF li_rc	=	2	THEN
	// User cancels the save.
	Return	-1
ELSE
	// File is overwritten
	Return	0
END IF
end event

event key;call super::key;//*********************************************************************************
// Script Name:rte_text.key()
//
//	Arguments:		keycode	key
//						unsignedlong	keyflags
//
// Returns:			long
//
//	Description:	Listen for F2 key and inseart date when hit.
//
//*********************************************************************************
//
// 10/06/99 FNC	Stars 4.5.	Created
//						This function determines if the user clicked F2. If so, it pastes 
//						today's date in a note.
//
//*********************************************************************************

W_master	lw_parent
Integer		li_rc

IF key = KeyF2! THEN
	this.Event  ue_paste_date()
end if
end event

event modified;call super::modified;//*********************************************************************************
// Script Name:rte_text.modified
//
//	Arguments:		keycode	key
//						unsignedlong	keyflags
//
// Returns:			long
//
//	Description:	We decided not to implement background spell checking in STARS 5.5
//	due to issues identified in the rbuttondown event of this control.
//
//*********************************************************************************
//
//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//
//*********************************************************************************

//ole_spell.autocheckrte( This )
//This.modified = FALSE
end event

event rbuttondown;call super::rbuttondown;//*********************************************************************************
// Script Name:rte_text.rbuttondown
//
//	Arguments:		N/A
//
// Returns:			long
//
//	Description:	This script calls the method which allows the spell checker's 
//	menu to popup when a misspelled word is clicked via the RMM.
// The RTE's popup menu must be disabled for this to work. 
//	This functionality was not implemented with STARS 5.5 because 
//	the X and Y coordinates did not seem to work as well as 
//	Section 508 issues with popup menus.
//
//*********************************************************************************
//
//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//
//*********************************************************************************

//ole_spell.showcontextmenu( rte_text )
end event

type rte_print from u_rte within w_notes_maint
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 965
integer y = 32
integer width = 82
integer height = 72
integer taborder = 0
boolean init_wordwrap = true
long init_leftmargin = 1000
long init_topmargin = 1000
long init_rightmargin = 1000
long init_bottommargin = 1000
end type

type st_1 from statictext within w_notes_maint
string accessiblename = "Note Desc"
string accessibledescription = "Note Desc"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 296
integer width = 393
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Note Desc:"
alignment alignment = right!
end type

type sle_note_desc from singlelineedit within w_notes_maint
string accessiblename = "Note Description"
string accessibledescription = "Note Description"
accessiblerole accessiblerole = textrole!
integer x = 439
integer y = 296
integer width = 2176
integer height = 76
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 80
borderstyle borderstyle = stylelowered!
end type

event modified;//*********************************************************************************
// Script Name:sle_note_desc
//
//	Arguments:		N/A
//
// Returns:			long
//
//	Description:	If note description changed set the note rte to modifiable.
//
//*********************************************************************************
//
//	01/24/03	GaryR	Track	3417d Validate pending updates
//
//*********************************************************************************
Parent.wf_SetModified( TRUE )
end event

type st_subtype from statictext within w_notes_maint
string accessiblename = "SubType"
string accessibledescription = "SubType"
accessiblerole accessiblerole = statictextrole!
integer x = 1362
integer y = 208
integer width = 311
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "SubType:"
alignment alignment = right!
end type

type ddlb_subtype from dropdownlistbox within w_notes_maint
string accessiblename = "Subtype"
string accessibledescription = "Subtype"
accessiblerole accessiblerole = comboboxrole!
integer x = 1687
integer y = 208
integer width = 928
integer height = 440
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean enabled = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_model from u_cb within w_notes_maint
string accessiblename = "Copy"
string accessibledescription = "Copy"
integer x = 1344
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 120
string text = "Co&py"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_model.clciked
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	Use the existing note to create a new note.  To do this, the only
//						thing required is to generate the new note ID
//
//*********************************************************************************
//	
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
// 11/24/02 JasonS Track 2883d Note Desc
//*********************************************************************************



SETPOINTER(HOURGLASS!)
SETMICROHELP(W_MAIN,'Ready')

IF Parent.wf_IsModified() < 1 THEN Return		//	09/18/02	GaryR	SPR 4598c

sle_note_name.enabled = true
sle_rel_id.enabled    = true
ddlb_type.enabled     = true
sle_note_desc.enabled = true
sle_userid.text       = gc_user_id

cb_add.enabled = true
CB_ADD.DEFAULT = TRUE
cb_update.enabled = false
cb_delete.enabled = false
SETFOCUS(SLE_NOTE_NAME)

IF left(ddlb_type.text,2) = 'CA' THEN
	ddlb_subtype.enabled = true
ELSE
	ddlb_subtype.enabled = false
END IF

sle_note_name.text = fx_get_next_key_id('NOTE')

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If
If sle_note_name.text = 'ERROR' then
	Messagebox('EDIT','Unable to get System Controlled Note Id')
End IF

wf_SetModified( TRUE )		//	09/18/02	GaryR	SPR 4598c

setpointer(arrow!)
end event

type cb_clear from u_cb within w_notes_maint
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1586
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 130
string text = "C&lear"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_clear.clicked
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	Clear the contents of the note
//		
//
//*********************************************************************************
//	
//	05-12-98	NLG	1. Change notes globals to notes nvo
//	07/21/99	FDG	Stars 4.5.  Use an RTE control (rte_text) instead of an MLE
// 04/27/00	GaryR	Ts2173		Rights control
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
// JasonS 10/17/02 Track 2883d	blank out note_desc
// JasonS 11/24/02 Track 2883d   enable note desc
// JasonS 12/9/04 Track 3664 case component update
//	02/21/07	Katie	SPR 4536	Added code to handle DL and RC Cases
//*********************************************************************************

int li_rc
string ls_desc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

IF Parent.wf_IsModified() < 1 THEN Return		//	09/18/02	GaryR	SPR 4598c

sle_userid.Text = gc_user_id	//Gary-R	04/27/2000	Ts2173
sle_note_name.text = ''
sle_rel_id.text = ''

// FDG 07/21/99 begin
//mle_description.text = ''
// Clear out the rte
//rte_text.SelectTextAll ()
//rte_text.Clear ()
li_rc = rte_text.of_clear()
// FDG 07/21/99 end

wf_SetModified( FALSE )		//	09/18/02	GaryR	SPR 4598c

sle_note_desc.enabled = true	// JasonS 11/24/02 Track 2883d
sle_date_time.text = ''
inv_notes.is_notes_id = ''
inv_notes.is_notes_rel_id = ''
inv_notes.is_notes_rel_type = ''
inv_notes.is_notes_sub_type = ''
SLE_NOTE_NAME.ENABLED = TRUE
SLE_REL_ID.ENABLED = TRUE
ddlb_subtype.Enabled = FALSE	//Gary-R	04/27/2000	Ts2173
ddlb_subtype.selectitem(0)
ddlb_subtype.text=''
DDLB_TYPE.ENABLED = TRUE
ddlb_type.selectitem(0)
ddlb_type.text=''
sle_note_desc.text = ''	// JasonS 10/17/02 Track 2883d
cb_clear.default=false
cb_add.default = true
cb_update.enabled = false
cb_delete.enabled = false
cb_add.enabled    = true
cb_retrieve.enabled=true
wf_SetModifyRights( TRUE )	//Gary-R	04/27/2000	Ts2173

// FDG 07/21/99 - Insert the initial text for the note depending on where you are coming from
Parent.wf_new_note_text()

parent.event ue_set_update_availability()
parent.event ue_edit_case_referred()

setfocus (sle_note_name)
setpointer(arrow!)
end event

type st_date_time from statictext within w_notes_maint
string accessiblename = "Datetime"
string accessibledescription = "Datetime"
accessiblerole accessiblerole = statictextrole!
integer x = 1335
integer y = 32
integer width = 338
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Datetime:"
alignment alignment = right!
end type

type sle_date_time from singlelineedit within w_notes_maint
string tag = "colorfixed"
string accessiblename = "Date Time"
string accessibledescription = "Date Time"
accessiblerole accessiblerole = textrole!
integer x = 1687
integer y = 32
integer width = 658
integer height = 76
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type ddlb_type from dropdownlistbox within w_notes_maint
string accessiblename = "Related Type"
string accessibledescription = "Related Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 439
integer y = 208
integer width = 818
integer height = 412
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//*********************************************************************************
// Script Name:	ddlb_type.selectionchanged
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	set objects appropriately for type selected
//
//*********************************************************************************
//
//	03/18/98	ASJ 		4.0 Fix notes for new selections
//	02/01/00	FDG		Stars 4.5.	Allow for patterns notes.
// 	09/11/02 JasonS 	Track 3172d
//	04/27/09	GaryR	GNL.600.5633.012	Accommodate Section 508 Compliancy
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

choose case left(ddlb_type.text,2)
	case 'CA', 'PA', 'PQ', 'SS'
		sle_rel_id.backcolor  = stars_colors.lookup_back
		sle_rel_id.textcolor  = stars_colors.lookup_text
		sle_rel_id.tag = "LOOKUP"
		sle_rel_id.accessiblename = "Lookup Field - " + left(ddlb_type.text,2)
		sle_rel_id.accessibledescription = "Lookup Field - " + left(ddlb_type.text,2)
	case else
		sle_rel_id.backcolor = stars_colors.input_back
		sle_rel_id.textcolor  = stars_colors.input_text
		sle_rel_id.tag = ""
		sle_rel_id.accessiblename = "Related ID"
		sle_rel_id.accessibledescription = "Related ID"
end choose

CHOOSE CASE left(ddlb_type.text,2)

CASE 'CA'
	ddlb_subtype.enabled = true
	ddlb_subtype.text = ' '
	if trim(inv_notes.is_notes_rel_id) = '' then 
		//if coming from subset list, the rel id should be active subset case, unless
		//selected an independent subset
		if inv_notes.is_notes_from = 'SS' then
			if gc_active_subset_case <> 'NONE' then 
				inv_notes.is_notes_rel_id = gc_active_subset_case
			else 
				inv_notes.is_notes_rel_id = ''
			end if
		else
 			inv_notes.is_notes_rel_id=gv_active_case
		end if
	End if
	sle_rel_id.text = inv_notes.is_notes_rel_id
CASE 'SS', 'PQ', 'PA'
	ddlb_subtype.enabled = false
	ddlb_subtype.selectitem('GI',0)
	sle_rel_id.text = ' '
	setFocus(sle_rel_id)
	
CASE ELSE
	MessageBox("ERROR","Invalid related type")
	return

END CHOOSE


end event

type sle_userid from singlelineedit within w_notes_maint
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = textrole!
integer x = 439
integer y = 32
integer width = 384
integer height = 76
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
integer limit = 8
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_subject from statictext within w_notes_maint
string accessiblename = "Related ID"
string accessibledescription = "Related ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1317
integer y = 120
integer width = 357
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Related ID:"
alignment alignment = right!
end type

type st_type from statictext within w_notes_maint
string accessiblename = "Related Type"
string accessibledescription = "Related Type"
accessiblerole accessiblerole = statictextrole!
integer y = 208
integer width = 425
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Related Type:"
alignment alignment = right!
end type

type st_notes-key from statictext within w_notes_maint
string accessiblename = "Note ID"
string accessibledescription = "Note ID"
accessiblerole accessiblerole = statictextrole!
integer x = 146
integer y = 120
integer width = 279
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Note ID:"
alignment alignment = right!
end type

type st_userid from statictext within w_notes_maint
string accessiblename = "User"
string accessibledescription = "User"
accessiblerole accessiblerole = statictextrole!
integer x = 169
integer y = 32
integer width = 256
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "User:"
alignment alignment = right!
end type

type cb_delete from u_cb within w_notes_maint
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1102
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 110
string text = "&Delete"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_delete.clicked
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	
//		
//
//*********************************************************************************
//	
// ajs 4.0 03-11-98 TS145-Fix globals
// JGG 03-12-98 	STARS 4.0 - TS145 Executable Changes
//	NLG 05-12-98	1. Replace notes globals with notes nvo
//	07/21/99	FDG	Stars 4.5.  Use an RTE control (rte_text) instead of an MLE
//	02/01/00	FDG	Stars 4.5.	Allow for patterns notes.
//	09/21/01	FDG	Stars 4.8.1.	Don't delete if its case is deleted or closed.
//						Also, add a case_log.
// 12/19/01 SAH   Include type and subtype with case id when updating log
//	06/10/05 MikeF	SPR4319d Remove refernces to w_subset_maint
//	09/14/07 Katie SPR 5174 Made adjustment for CA notes to call uf_edit_case_deleted function.
//	09/17/07 Katie SPR 5174 Set modified property to false to prevent save message when closing after clear.
//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//	05/20/09	GaryR	GNL.600.5633.012	Provide keyboard alternative to RTE focus bug
//
//*********************************************************************************

string lv_type,LV_SQLUSRMSG ,lv_rel_type
int lv_sqldbcode,lv_msg_nbr,lv_count

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
cb_clear.default = true

If gc_user_id <> trim(sle_userid.text) then
	Messagebox('EDIT','Cannot Delete Another Users Note',stopsign!)
	setfocus(sle_userid)
	RETURN
End If

If inv_notes.is_notes_id <> trim(sle_note_name.text) then
	Messagebox('EDIT','Must Retrieve Note Before Deleting - Note Name Changed')
	cb_clear.default = true
	RETURN
End If

lv_rel_type = left(ddlb_type.text,2)
If inv_notes.is_notes_rel_type <> lv_rel_type then
	Messagebox('EDIT','Must Retrieve Note Before Deleting - Rel Type Changed')
	cb_clear.default = true
	RETURN
End If

If lv_rel_type <> 'MI' then
	If sle_rel_id.text <> inv_notes.is_notes_rel_id then
		Messagebox('EDIT','Must Retrieve Note Before Deleting - Rel Name Changed')
		cb_clear.default = true
		Return
	End If
End IF

// FDG 09/21/01 begin
Boolean		lb_valid_case
String		ls_message,			&
				ls_rel_id,			&
				ls_rel_type,      &
				ls_rel_subtype
Integer		li_rc

lb_valid_case	=	TRUE

// SAH 12/19/01 begin
ls_rel_subtype = Left(ddlb_subtype.text, 2)
ls_rel_type		=	Left (ddlb_type.text, 2)
ls_rel_id		=	sle_rel_id.text

CHOOSE CASE ls_rel_type
	CASE 'CA'
		// Case note
		lb_valid_case	=	inv_case.uf_edit_case_deleted (ls_rel_id)
		ls_message		=	"Case note "	+	inv_notes.is_notes_id	+	&
								" (" + ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted."
		// SAH 12/19/01 end
		
	CASE 'PA'
		// Patterns note
		ls_rel_type		=	'PAT'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"Patterns note "	+	inv_notes.is_notes_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted for pattern "	+	ls_rel_id	+	"."
	CASE 'PQ'
		// PDQ note
		ls_rel_type		=	'PDQ'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"PDQ note "	+	inv_notes.is_notes_id	+ " (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted for query "	+	ls_rel_id	+	"."
	CASE 'SS'
		// Patterns note
		ls_rel_type		=	'SUB'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"Subset note "	+	inv_notes.is_notes_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted for subset "	+	ls_rel_id	+	"."
END CHOOSE

IF	lb_valid_case	=	FALSE		THEN
	MessageBox ('Error', 'Update not allowed because its associated case is either closed or deleted.')
	Return
END IF

// FDG 09/21/01 end

lv_msg_nbr = Messagebox('CONFIRMATION','Proceed With Delete',Question!,YesNo!,2)
If lv_msg_nbr = 2 then
	RETURN
End If

// FDG 09/21/01 begin
li_rc	=	inv_case.uf_audit_log (ls_rel_id, ls_rel_type, ls_message)

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	Return
END IF

// FDG 09/21/01 end

Delete From notes
	where Note_ID = Upper( :sle_note_name.text ) and
			note_rel_type = Upper( :lv_rel_type ) and
			note_rel_id   = Upper( :sle_rel_id.text )
Using stars2ca;

If stars2ca.of_check_status() = 100 then
	Messagebox('EDIT','Record Does Note Exist, Has already Been Deleted')
	RETURN
ElseIf stars2ca.sqlcode <> 0 then
	lv_sqlusrmsg = 'Delete Failed ' + stars2ca.sqlerrtext
	errorbox(stars2ca,lv_sqlusrmsg)
	RETURN
Else
	setmicrohelp(w_main,'Record ' + sle_note_name.text + ' Deleted')
End If

//KMM 8/24/95 If notes no longer exist, then make picture invisible
if lv_rel_type = 'CA' then
	Select count(*) into :lv_count
	From notes
	where note_rel_type = 'CA'  and
	note_rel_id   = Upper( :sle_rel_id.text )
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error reading Notes table: note_rel_type = CA and note_rel_id = ' + sle_rel_id.text)
		RETURN
	end if
	if lv_count <= 0 and gv_active_case = sle_rel_id.text then
		if isvalid(w_case_maint) then
			w_case_maint.p_notes.visible = false
		end if
		if isvalid(w_case_folder_view) then
			w_case_folder_view.p_notes.visible = false
		end if
	end if
elseif lv_rel_type = 'SS' then
	Select count(*) into :lv_count
	From notes
	where note_rel_type = 'SS'  and
	note_rel_id   = Upper( :sle_rel_id.text )
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then

		errorbox(stars2ca,'Error reading Notes table: note_rel_type = SS and note_rel_id = ' + sle_rel_id.text)
		RETURN
	end if
elseif lv_rel_type = 'PQ' then		//ajs 03-18-98
	Select count(*) into :lv_count
	From notes
	where note_rel_type = 'PQ'  and	//ajs 03-18-98
	note_rel_id   = Upper( :sle_rel_id.text )
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error reading Notes table: note_rel_type = PQ and note_rel_id = ' + sle_rel_id.text)
		RETURN
	end if
elseif lv_rel_type = 'PA' then		//ajs 03-18-98
	Select count(*) into :lv_count
	From notes
	where note_rel_type = 'PA'  and	//ajs 03-18-98
	note_rel_id   = Upper( :sle_rel_id.text )
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error reading Notes table: note_rel_type = PA and note_rel_id = ' + sle_rel_id.text)
		RETURN
	end if
end if
//KMM END

stars2ca.of_commit()
triggerevent(cb_clear,clicked!)
Parent.wf_setmodified( FALSE )
end event

type cb_add from u_cb within w_notes_maint
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 859
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 100
string text = "Cr&eate"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_add.clicked
//
//	Arguments:		n/a
//						
//
// Returns:			-1 Error
//
//	Description:	Add the new note.
//		
//
//*********************************************************************************
//	
//	ajs 03-11-98	4.0.  fix split of case id
//	06-18-97 FNC	FS/TS154 Check security before opening detail window
//						This will make sure all case security is consistent
//	04/20/98 FDG	Track 1093.  Query Engine notes should still use
//						sle_rel_id.
//	05-12-98 NLG	1.	replace notes globals with notes nvo
//	06-01-98 NLG	1. check for duplicate note before inserting note
//	08-31-98 NLG	FS362 convert case to case_cntl
//	01-12-99 AJS	FS1873d 4.1 Correct notes error messages
//	07/21/99	FDG	Stars 4.5.  Use an RTE control (rte_text) instead of an MLE
//	02/01/00	FDG	Stars 4.5.	Allow for patterns notes.
//	04/27/00	GR		Ts2173	Simplify DB error messages
//	05/12/00	FDG	Track 2283d.  When saving after importing, it may be possible that
//						certain characters cannot be converted.  Instead of displaying
//						the d/b error window, display a more user-friendly message instead.
//	12/05/00	FDG	Stars 4.7.  Make error checking DBMS-independent.
//	01/12/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	09/21/01	FDG	Stars 4.8.1.	Add not allow if its case is closed or deleted.
//						Also, add a case_log.
// 12/07/01	GaryR	Stars 5.0	Use of empty string in SQL.
// 12/19/01       Stars 5.0  Allow relative type and subtype to be added to the log
//									  along with the case_id	
// 09/11/02	Jason	Track 3172d  Reword error messages.
//	09/18/02	GaryR	Track 4598c	Validate pending updates
// 10/17/02 Jason	Track 2883d add note_desc to insert sql
//	01/24/03	GaryR	Track	3417d Validate pending updates
//	03/11/03	GaryR	Track 3172d	Contain is misspelled in the validation messages
//	06/30/03	GaryR	Track 3172d	Clean up Related ID message
//	07/21/03	GaryR	Track	5273c	Oracle limits string literals to 2000 bytes
//	04/15/04	GaryR	Track 4003d	Add DB error check between two steps
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
// 12/09/04 JasonS Track 3664 Case Component Update
// 12/22/05 HYL TRACK 4594d Disable cb_add when a new note is created
// 02/21/06 JasonS Track 4625d  set ib_new_note to false after the note is created
//	02/20/07	Katie	SPR 4536 Added catch for Adding notes to referred closed or deleted cases.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//	05/20/09	GaryR	GNL.600.5633.012	Provide keyboard alternative to RTE focus bug
//
//*********************************************************************************

string lv_type,LV_SQLUSRMSG,lv_sqlerrtext, lv_subtype, lv_note_no
string lv_note_id, ls_rel_id
string ls_case_id,ls_case_spl,ls_case_ver,ls_dept_code, ls_empty
String	ls_desc				// FDG 07/21/99
long lv_next_note
int lv_sqldbcode,lv_count
int li_code_sec,li_rc
datetime lv_datetime
boolean lv_valid_case

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if TRIM(left(ddlb_type.text,2)) = 'CA' then
	ls_case_id  = Trim (left(sle_rel_id.text,10) )	
	ls_case_spl = mid(sle_rel_id.text,11,2)
	ls_case_ver = mid(sle_rel_id.text,13,2)	
	lv_valid_case = inv_case.uf_edit_case_deleted(trim(sle_rel_id.text))
	if (inv_case.uf_get_comp_upd_status_lead( "CASENOTES", ls_case_id, ls_case_spl, ls_case_ver) = 'RO') &
		or NOT (lv_valid_case) then
		Messagebox("Error", "Cannot add note to this case due to the case being closed or deleted.")
		Return
	end if
end if

cb_add.default = true

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)

If trim(sle_note_name.text) = '' then
	sle_note_name.text = fx_get_next_key_id('NOTE')
	If sle_note_name.text = 'ERROR' then
		Messagebox('EDIT','Unable to get System Controlled Note Id')
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End IF
End IF

lv_type = trim(left(ddlb_type.text,2))
lv_subtype=trim(left(ddlb_subtype.text,2))

If lv_type = '' then
	ddlb_type.enabled=true
	setfocus(ddlb_type)
	messagebox('EDIT','Please select a relation type.',stopsign!)
	Return -1	//	09/18/02	GaryR	SPR 4598c
End if

If lv_type = 'CA' then
	if lv_subtype='' then
		Messagebox('EDIT','Please select a subtype.',Stopsign!)
		ddlb_subtype.enabled=true
		setfocus(ddlb_subtype)
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
End If

If lv_type <> 'MI' then
	If sle_rel_id.text = '' then
		Messagebox('EDIT','Must Enter a Related Id',Stopsign!)
		setfocus(sle_rel_id)
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
End If

// FDG 07/21/99 begin
// Get the description from the RTE and edit it
ls_desc	=	rte_text.CopyRTF (FALSE, Detail!)

If trim(ls_desc)	=	'' then
	If messagebox('EDIT',+ &
				'No description has been entered. Enter note anyway?',question!,yesno!,2) = 2 then
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End if
End if
// FDG 07/21/99 end

gnv_sql.of_TrimData( ls_desc )		// 12/07/01	GaryR	Stars 5.0

sle_rel_id.text	=	Trim(sle_rel_id.text)		// FDG 04/16/01

If lv_type = 'CA' then
	// 08-31-98 NLG FS362 convert case to case_cntl
	select count(*) into :lv_count
	from  case_cntl
	where case_id = Upper( :ls_case_id )
	and	case_spl = Upper( :ls_case_spl )
	and	case_ver = Upper( :ls_case_ver )
	using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error Checking Existence of Case')
		Return -1	//	09/18/02	GaryR	SPR 4598c
	Elseif lv_count = 0 then
		 COMMIT using STARS2CA;
		 If stars2ca.of_check_status() <> 0 Then
			Messagebox('EDIT','Error Commiting to Stars2')
			Return -1	//	09/18/02	GaryR	SPR 4598c
	    End If	
		 // JasonS 09/11/02 Begin - Track 3172d
		 Messagebox('ERROR','Related ID must contain a valid case id.')	//ajs 01-12-99
		 // JasonS 09/11/02 End - Track 3172d
		 setfocus(sle_rel_id)
		 Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
	
ElseIf lv_type = 'PQ' then
	//NLG 4-23-98 START
		select count(*) 
		into :lv_count
		from Case_Link
		Where (Link_type = 'PDQ' or Link_type = 'PDR') and
			CASE_ID = 'NONE' and
			link_name = Upper( :sle_rel_id.text )
		Using STARS2CA;
		If stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error Checking Existence of Predefined Query')
			Return -1	//	09/18/02	GaryR	SPR 4598c
		end if
		If lv_count > 0 then		//predefined query exists
			ls_rel_id = trim(sle_rel_id.text)
		elseif lv_count = 0 then
			//Check for case linked PDQ
			select count(*) 
				into :lv_count
				from Case_Link
				Where (Link_type = 'PDQ' or Link_type = 'PDR') and
				link_name = Upper( :sle_rel_id.text )
			Using STARS2CA;
			If stars2ca.of_check_status() <> 0 then
				errorbox(stars2ca,'Error Checking Existence of Predefined Query')
				Return -1	//	09/18/02	GaryR	SPR 4598c
			end if
			if lv_count > 0 then
				Messagebox("ERROR","Independent Query ID does not exist. Cannot add note.")
				Return -1	//	09/18/02	GaryR	SPR 4598c
			else

	    	   // JasonS 09/11/02 Begin - Track 3172d
				Messagebox('ERROR','Related ID must contain a valid query id.')	//ajs 01-12-99
		      // JasonS 09/11/02 End - Track 3172d

				Return -1	//	09/18/02	GaryR	SPR 4598c
			end if
		End If
	
	//NLG 4-23-98 STOP
	
ElseIf lv_type = 'PA' then
	//FDG 02/01/00 START
		select count(*) 
			into :lv_count
			from Case_Link
			Where Link_type = 'PAT' 
			and case_id <> 'NONE'
			and link_name = Upper( :sle_rel_id.text )
		Using STARS2CA;
		If stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca,'Error Checking Existence of a pattern in case_link')
			Return -1	//	09/18/02	GaryR	SPR 4598c
		end if
		if lv_count > 0 then
			Messagebox("ERROR","This pattern is already linked to a case. Cannot add note.")
			Return -1	//	09/18/02	GaryR	SPR 4598c
		end if
		// Pattern not linked to a case.  Determine if it exists.
		select count(*) 
		into :lv_count
		from patt_cntl
		Where patt_id = Upper( :sle_rel_id.text )
		Using STARS2CA;
		If stars2ca.of_check_status() <> 0 then
			errorbox(stars2ca, 'Error Checking Existence of a pattern in patt_cntl')
			Return -1	//	09/18/02	GaryR	SPR 4598c
		end if
		If lv_count > 0 then		//pattern exists
			ls_rel_id = trim(sle_rel_id.text)
		else
			
			// JasonS 09/11/02 Begin - Track 3172d
		 	Messagebox('ERROR','Related ID must contain a valid pattern id.')	//ajs 01-12-99
		 	// JasonS 09/11/02 End - Track 3172d

			Return -1	//	09/18/02	GaryR	SPR 4598c
		End If
	
	//FDG 02/01/00 STOP

ElseIf lv_type = 'RP' then
	SELECT count(*) 
	INTO	:lv_count
	FROM	case_link
	WHERE	link_type in ( 'RPT', 'MED', 'RDM' )
	AND	link_name = Upper( :sle_rel_id.text )
	USING	STARS2CA;

	If stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error Checking Existence of Report')
		Return -1	//	09/18/02	GaryR	SPR 4598c
	Elseif lv_count = 0 then
		IF STARS2CA.of_commit() <> 0 THEN
			Messagebox('EDIT','Error Commiting to Stars2')
			Return -1	//	09/18/02	GaryR	SPR 4598c
		 End If	
		 Messagebox('ERROR','Report Does Not Exist to Add a Note')
		 setfocus(sle_rel_id)
		 Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
ElseIf lv_type = 'SS' then
		//Set up the structure to be passed to INV_Subset_Functions
 		Istr_Subset_Id.subset_name = sle_rel_id.text
 		Istr_Subset_Id.subset_case_id = 'NONE'
		// FDG 04/16/01 - Account for empty string or space in case_spl, case_ver.
		li_rc	=	gnv_sql.of_TrimData (Istr_Subset_Id.subset_case_spl) 
		li_rc	=	gnv_sql.of_TrimData (Istr_Subset_Id.subset_case_ver)
 
		//Call function in the NVO to determine if case is independent
 		Inv_Subset_Functions.uf_set_structure(Istr_Subset_Id)
 		li_rc = Inv_Subset_Functions.uf_retrieve_subset_id()
 
 		If li_rc = -1 then 
 			MessageBox('ERROR','Error checking existence of subset')
 			Return -1	//	09/18/02	GaryR	SPR 4598c
 		Elseif li_rc = 0 then// -2 then				nlg 4-23-98 
			//Subset is not independent, call a function 
			//to determine if subset is linked to a case
 			Inv_Subset_Functions.uf_set_structure(Istr_Subset_Id)
 			li_rc = Inv_Subset_Functions.uf_select_links_Using_Subset_Name()
 			If li_rc = -1 then
 				Return -1	//	09/18/02	GaryR	SPR 4598c
 			Elseif li_rc = 0 then//-2 then			nlg 4-23-98
				//Subset not found on Case Link table
				
		 		// JasonS 09/11/02 Begin - Track 3172d
				Messagebox('ERROR','Related ID must contain a valid subset id.')	//ajs 01-12-99
		 		// JasonS 09/11/02 End - Track 3172d
 
				Return -1	//	09/18/02	GaryR	SPR 4598c										//nlg 4-23-98
 			Else
 				MessageBox('Error','Independent Subset ID does not exist. Cannot add note.')
 				Return -1	//	09/18/02	GaryR	SPR 4598c
 			End if
 		Else
 			istr_subset_id = inv_subset_functions.uf_get_structure()
 			
		 	//NLG 7-7-98 Now, make sure subset has been created ...
			select count(*) into :lv_count
			from  sub_cntl
			where subc_id = Upper( :istr_subset_id.subset_id )
			using stars2ca;

			If stars2ca.of_check_status() <> 0 then
				errorbox(stars2ca,'Error Checking Existence of Subset')
				Return -1	//	09/18/02	GaryR	SPR 4598c
			Elseif lv_count = 0 then
				COMMIT using stars2ca;
				If stars2ca.of_check_status() <> 0 Then
					Messagebox('EDIT','Error Committing to Stars2')
					Return -1	//	09/18/02	GaryR	SPR 4598c
			   End If	
				Messagebox('ERROR','Subset Does Not Exist to Add a Note')
				setfocus(sle_rel_id)
				Return -1	//	09/18/02	GaryR	SPR 4598c
			Else
				COMMIT using stars2ca;
				If stars2ca.of_check_status() <> 0 Then
					Messagebox('EDIT','Error Committing to Stars2')
					Return -1	//	09/18/02	GaryR	SPR 4598c
				End If	
			End If
			//NLG 7-7-98          *****STOP****
			
			ls_rel_id = istr_subset_id.subset_name 

 		End if
End if
//VAV 4.0 2/3/98 - end of new section

//06-18-97 FNC Start
If lv_type = 'CA' then
	// 08-31-98 NLG FS362 convert case to case_cntl
	Select code_value_a,code_value_n
	into :ls_dept_code, :li_code_sec
	from CODE CD,CASE_CNTL CC
	where CC.case_id = Upper( :ls_case_id ) and
			CC.case_spl = Upper( :ls_case_spl ) and
			CC.case_ver = Upper( :ls_case_ver ) and
			CC.case_cat = CD.code_code and
			CD.code_type = 'CA' 
	using stars2ca;

	If stars2ca.of_check_status() = 100 then
		Errorbox(stars2ca,'Case Category Code not found')
		Return -1	//	09/18/02	GaryR	SPR 4598c
	Elseif stars2ca.sqlcode <> 0 Then
		Errorbox(stars2ca,'Error Reading code Table for Category Code')
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
	
	If ls_dept_code <> gc_user_dept then
		If li_code_sec = 1 Then
			Messagebox('EDIT',+ &
						'This is a Secured Case you have insufficient privileges for adding notes')
			Return -1	//	09/18/02	GaryR	SPR 4598c
		End If
	End If
End if
//06-18-97 FNC End
	
lv_datetime = gnv_app.of_get_server_date_time()//ts2020c
lv_note_id = sle_note_name.text

/*VAV 4.0 2/3/98 -The variable sle_rel_ID.text must be replaced with ls_rel_id. 
						Ls_rel_id will contain the internal ids for queries and 
						subsets whereas sle_rel_id.text contains the subset name or query name. 
						Insert the following code prior to the Insert Statement 
						so that sle_rel_id.text is moved into ls_rel_id for all note types 
						other than 'SS' and 'PQ' and 'PA'. */

// FDG 02/01/00 - Allow for patterns notes
If lv_type <> 'SS'	&
and lv_type <> 'PQ'	&
and lv_type <> 'PA'	then
 	ls_rel_id = sle_rel_id.text
End if
//VAV 4.0 2/3/98 - end of new section

// NLG 6-1-98 check for duplicate note		start ***
select count(*) into :lv_count
	from  NOTES
	where note_rel_id = Upper( :ls_rel_id ) and
			note_rel_type = Upper( :lv_type ) and		
			note_id = Upper( :lv_note_id )
	using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		errorbox(stars2ca,'Error checking for duplicate note')
		Return -1	//	09/18/02	GaryR	SPR 4598c
	Elseif lv_count > 0 then
	    COMMIT using STARS2CA;
	    If stars2ca.of_check_status() <> 0 Then
			Messagebox('EDIT','Error Committing to Stars2')
			Return -1	//	09/18/02	GaryR	SPR 4598c
		 End If	
		 Messagebox('EDIT','Note already exists using this Note Id, Related Type and Related ID.')
		 setfocus(sle_note_name)
		 Return -1	//	09/18/02	GaryR	SPR 4598c
	end if
// NLG 6-1-98                               end ***

//	01/12/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( ls_rel_id ) = "" THEN ls_rel_id = ls_empty

// FDG 09/21/01 begin
Boolean		lb_valid_case
String		ls_message,			&
				ls_rel_type
String      ls_rel_subtype 

lb_valid_case	=	TRUE

//12/19/01 SAH Include type and subtype for 'CA' so it will appear in log
ls_rel_subtype =  Left (ddlb_subtype.text, 2)
ls_rel_type		=	Left (ddlb_type.text, 2)
ls_rel_id		=	sle_rel_id.text

CHOOSE CASE ls_rel_type
	CASE 'CA'
		// Case note
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id)
		ls_message		=	"Case note "	+	lv_note_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" added."
		// SAH 12/19/01 end
		
	CASE 'PA'
		// Patterns note
		ls_rel_type		=	'PAT'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"Patterns note "	+	lv_note_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" added for pattern "	+	ls_rel_id	+	"."
	CASE 'PQ'
		// PDQ note
		ls_rel_type		=	'PDQ'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"PDQ note "	+	lv_note_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" added for query "	+	ls_rel_id	+	"."
	CASE 'SS'
		// Patterns note
		ls_rel_type		=	'SUB'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"Subset note "	+	lv_note_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" added for subset "	+	ls_rel_id	+	"."
END CHOOSE

li_rc	=	inv_case.uf_audit_log (ls_rel_id, ls_rel_type, ls_message)

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	Return -1	//	09/18/02	GaryR	SPR 4598c
END IF

// FDG 09/21/01 end

// JasonS 10/17/02 Begin - Track 2883d
gnv_sql.of_TrimData (sle_note_desc.text)
// JasonS 10/17/02 End - Track 2883d


// FDG 07/21/99 - Use ls_desc instead of mle_description.text and 'Y' into rte_ind
Insert into notes
	(dept_id, user_id,
	 note_rel_type, note_sub_type, note_rel_id,
	 note_id, note_datetime, note_text, rte_ind, note_desc)	// JasonS 10/17/02 Track 2883d
Values (:gc_user_dept, :gc_user_id,
	  :lv_type, :lv_subtype, :ls_rel_id,  
	  :lv_NOTE_ID, :lv_datetime,  ' ', 'Y', :sle_note_desc.text) // JasonS 10/17/02 Track 2883d
Using stars2ca;

IF stars2ca.of_check_status() <> 0 THEN
	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		stars2ca.of_rollback()
		Messagebox('ERROR','Note already Exists',Stopsign!)
		Return -1
	ELSE
		stars2ca.of_rollback()
		Return -1
	END IF
END IF

// FDG 05/12/00 - Trap the d/b error code if characters could not be converted.
// FDG 12/05/00 - Make error checking DBMS-independent
IF gnv_sql.of_set_note_text( ls_desc, lv_note_id, lv_type, ls_rel_id ) < 0 THEN
	Stars2ca.of_rollback()
	Return -1	//	09/18/02	GaryR	SPR 4598c
Else
	If stars2ca.of_check_status() <> 0 then
		Stars2ca.of_rollback()
		Return -1
	Else
		sle_userid.text = gc_user_id
		setmicrohelp(w_main, 'Note ' + sle_note_name.text + ' Successfully Added')
	End If
End If

stars2ca.of_commit()
sle_note_name.enabled = false
sle_rel_id.enabled = false
ddlb_type.enabled  = false
ddlb_subtype.enabled  = false
sle_date_time.text = string(lv_datetime, "mmm dd yyyy  h:mmAM/PM")

inv_notes.is_notes_id = trim(sle_note_name.text)
inv_notes.is_notes_rel_id = trim(sle_rel_id.text)
inv_notes.is_notes_rel_type = left(ddlb_type.text,2)

cb_update.enabled = true
cb_add.enabled = false 
cb_delete.enabled = true
cb_add.default=false
cb_exit.default = true
Parent.wf_setmodified( FALSE )

//VAV 4.0 2/3/98 - the following code is replacing the previous one
If lv_type = 'CA' then
	li_rc = Inv_Subset_Functions.UF_Determine_Case_Security(sle_rel_id.text)

	If li_rc = 100 then
		Messagebox('EDIT', + &
		        'This is a Secured Case you have insufficient privileges for retrieving notes')
	Elseif li_rc < 0 then
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End if
End if
//VAV 4.0 2/3/98 - end of new section

ib_new_note = false

if trim(left(ddlb_type.text,2)) = 'CA' then
	parent.event ue_set_update_availability()
	parent.event ue_edit_case_referred()
end if

// TRACK 4594d HYL 12/22/05 start
// Without disrupting the existing behaviour of ue_set_create_availability(boolean)
// make cb_add disabled when a new noted gets created                                         
cb_add.enabled = false
// TRACK 4594d HYL 12/22/05 end

cb_retrieve.enabled = sle_note_name.enabled
end event

type cb_update from u_cb within w_notes_maint
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 617
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 90
string text = "&Update"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_update.clicked
//
//	Arguments:		n/a
//
// Returns:			-1 Error
//
//	Description:	Update the previously read note.
//		
//
//*********************************************************************************
//	
//	05-12-98	NLG	1. change notes globals to nvo
//	07/21/99	FDG	Stars 4.5.  Use an RTE control (rte_text) instead of an MLE
//	04/27/00	GR		Ts2173	Simplify DB error messages
//	05/12/00	FDG	Track 2283d.  When saving after importing, it may be possible that
//						certain characters cannot be converted.  Instead of displaying
//						the d/b error window, display a more user-friendly message instead.
//	12/05/00	FDG	Stars 4.7.  Make error checking DBMS-independent.
//	09/21/01	FDG	Stars 4.8.1.	No update allowed if the case is closed or deleted.
//						Also, add a case_log.
// 12/07/01	GaryR	Stars 5.0	Use of empty string in SQL.
// 12/19/01 SAH   Stars 5.0   Include relative type and subtype with case id when 
//						updating the log
//	09/18/02	GaryR	Track 4598c	Validate pending updates
// 10/17/02	Jason	Track 2883d add note_desc to update sql
// 12/16/02 Jason	Track 2883d set desc modified boolean to false
//	01/24/03	GaryR	Track	3417d Validate pending updates
//	02/07/03	GaryR	Track 3438d	Do not reretrieve the note, it distorts the RTE display
//	07/21/03	GaryR	Track	5273c	Oracle limits string literals to 2000 bytes
// 12/29/04 JasonS Track 4055 Allow update of not on closed case.
//	09/14/07 Katie SPR 5174 Made adjustment for CA notes to call uf_edit_case_deleted function. 
//	05/20/09	GaryR	GNL.600.5633.012	Provide keyboard alternative to RTE focus bug
//
//*********************************************************************************

int lv_sqldbcode
string lv_sqlerrtext,lv_sqlusrmsg,lv_rel_type, lv_subtype
String	ls_desc				// FDG 07/21/99
datetime lv_datetime

setpointer(hourglass!) 
setmicrohelp(w_main,'Ready')

cb_update.default=false
cb_exit.default = true
If gc_user_id <> trim(sle_userid.text) then
	Messagebox('ERROR','Not Authorized to Update this Note',STOPSIGN!)
	Return -1	//	09/18/02	GaryR	SPR 4598c
End If

//NLG 5-12-98
If inv_notes.is_notes_id <> trim(sle_note_name.text) then
	Messagebox('EDIT','Must Retrieve Note Before Updating - Note Name Changed')
	cb_clear.default = true
	Return -1	//	09/18/02	GaryR	SPR 4598c
End If

lv_rel_type = left(ddlb_type.text,2)
//NLG 5-12-98
If inv_notes.is_notes_rel_type <> lv_rel_type then
	Messagebox('EDIT','Must Retrieve Note Before Updating - Rel Type Changed')
	cb_clear.default = true
	Return -1	//	09/18/02	GaryR	SPR 4598c
End If

If lv_rel_type = 'CA' then
	if trim(ddlb_subtype.text) <> '' then
		lv_subtype = left(ddlb_subtype.text,2)
	Else
		Messagebox('EDIT','Please select a subtype.',Stopsign!)
		ddlb_subtype.enabled=true
		setfocus(ddlb_subtype)
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
Else
	lv_subtype = 'GI'
End If

If lv_rel_type <> 'MI' then
	If sle_rel_id.text <> inv_notes.is_notes_rel_id then
		Messagebox('EDIT','Must Retrieve Note Before Updating - Rel Name Changed')
		cb_clear.default = true
		Return -1	//	09/18/02	GaryR	SPR 4598c
	End If
End IF

// FDG 09/21/01 begin
Boolean		lb_valid_case
String		ls_message,			&
				ls_rel_id,			&
				ls_rel_type,      &
				ls_rel_subtype
Integer		li_rc

lb_valid_case	=	TRUE

// SAH 12/19/01 begin
ls_rel_subtype =  Left (ddlb_subtype.text, 2)
ls_rel_type		=	Left (ddlb_type.text, 2)
ls_rel_id		=	sle_rel_id.text

CHOOSE CASE ls_rel_type
	CASE 'CA'
		// Case note
		lb_valid_case	=	inv_case.uf_edit_case_deleted (ls_rel_id)
		ls_message		=	"Case note "	+	inv_notes.is_notes_id	+ &
								" (" + ls_rel_type + "/" + ls_rel_subtype + " )" +	&
								" updated."
		// SAH 12/19/01 end
		
	CASE 'PA'
		// Patterns note
		ls_rel_type		=	'PAT'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"Patterns note "	+	inv_notes.is_notes_id +	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" updated for pattern "	+	ls_rel_id	+	"."
	CASE 'PQ'
		// PDQ note
		ls_rel_type		=	'PDQ'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"PDQ note "	+	inv_notes.is_notes_id +	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" updated for query "	+	ls_rel_id	+	"."
	CASE 'SS'
		// Patterns note
		ls_rel_type		=	'SUB'
		lb_valid_case	=	inv_case.uf_edit_case_closed (ls_rel_id, ls_rel_type)
		ls_message		=	"Subset note "	+	inv_notes.is_notes_id +	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" updated for subset "	+	ls_rel_id	+	"."
END CHOOSE


li_rc	=	inv_case.uf_audit_log (ls_rel_id, ls_rel_type, ls_message)

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for note '	+	inv_notes.is_notes_id	+	&
					'.  Script: '		+	&
					'w_notes_maint.cb_update.clicked')
	Return -1	//	09/18/02	GaryR	SPR 4598c
END IF

// FDG 09/21/01 end

lv_datetime = gnv_app.of_get_server_date_time()//ts2020c

ls_desc	=	rte_text.CopyRTF (FALSE,Detail!)
gnv_sql.of_TrimData( ls_desc )		// 12/07/01	GaryR	Stars 5.0
gnv_sql.of_TrimData( sle_note_desc.text ) // JasonS 10/17/02 Track 2883d
Update notes
	set note_datetime = :lv_datetime,
		note_sub_type  = :lv_subtype,
		rte_ind			=	'Y',
		note_desc		= :sle_note_desc.text	// JasonS 10/17/02 Track 2883d
	Where note_ID    = Upper( :inv_notes.is_notes_id ) and
		note_rel_type = Upper( :inv_notes.is_notes_rel_type ) and
		note_rel_id   = Upper( :inv_notes.is_notes_rel_id )
using stars2ca;
// FDG 07/21/99 end

// FDG 05/12/00 - Trap the d/b error code if characters could not be converted.
// FDG 12/05/00 - Make error checking DBMS-independent
//If	stars2ca.sqldbcode = 2402	Then
IF gnv_sql.of_set_note_text( ls_desc, inv_notes.is_notes_id, inv_notes.is_notes_rel_type, inv_notes.is_notes_rel_id ) < 0 THEN
	Stars2ca.of_rollback()
	Return -1	//	09/18/02	GaryR	SPR 4598c
Else
	If stars2ca.of_check_status()  = 100 then
		Messagebox('ERROR','Note does not exist.  The note must have been deleted.')	
		Return -1	//	09/18/02	GaryR	SPR 4598c
	ElseIf stars2ca.sqlcode <> 0 then
	//	lv_sqlerrtext = stars2ca.sqlerrtext
	//	lv_sqlusrmsg = 'Update failed ' + stars2ca.sqlerrtext
	//	errorbox(stars2ca,lv_sqlusrmsg)	
		ROLLBACK USING stars2ca ;	//Gary-R	04/27/2000	Ts2173
		//THIS.Enabled = FALSE		// FDG 05/12/00
		Return -1	//	09/18/02	GaryR	SPR 4598c
	Else
		setmicrohelp(w_main,'RECORD ' + sle_note_name.text + ' Updated')
	End If
End If

//lv_sqlusrmsg = 'Committing Update'
commit using stars2ca;
//lv_sqlusrmsg = 'Disconnecting After Update'

sle_date_time.text = string(lv_datetime,"mmm dd YYYY  h:mmAM/PM")//ts2020c
ddlb_subtype.enabled=false
ddlb_type.enabled=false

Parent.wf_setmodified( FALSE )

setpointer(arrow!)

end event

type cb_retrieve from u_cb within w_notes_maint
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 9
integer y = 1748
integer width = 297
integer height = 108
integer taborder = 70
string text = "&Retrieve"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_retrieve.clicked
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	Retrieve the note.
//		
//
//*********************************************************************************
//	
//	06-18-97 FNC	FS/TS154 Check security before opening detail window
//						This will make sure all case security is consistent
//	05-12-98 NLG	1. change notes globals to nvo
//	07/21/99	FDG	Stars 4.5.  Use an RTE control (rte_text) instead of an MLE
//	10-12-99	NLG	Set textsize on database before retrieving note_text
// 04/27/00	GaryR	Ts2173	Rights Control
//	12/13/00	FDG	Stars 4.7.  Make the retrieval of note_text 
//						DBMS-independent
//	12/07/01	GaryR	Track 2571d	Format note datetime
//	09/17/02	GaryR	SPR 4182c	Pass three unique key arguments for notes retrieval
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
// 10/17/02	Jason Track 2883d added note_desc to sql
// 10/29/02 Jason 2883d disable note desc
//	08/05/03	GaryR	Track 3438d	Prevent word wrapping
//	09/05/03	GaryR Track 3438d	Scroll to the first character on the first line
//	04/29/04	GaryR	Track 6822c	Prevent overwriting the contents in the clipboard
// 12/9/04  JasonS Track 3664d Case Component Update.
// 12/22/05 HYL TRACK 4594d Disable cb_add when an existing note is modified
// 02/28/06 JasonS Track 4625d close back door....after a user hits retrieve, disable controls for AO
//	02/21/07	Katie	SPR 4536	Added code to handle DL and RC Cases
//	05/20/09	GaryR	GNL.600.5633.012	Provide keyboard alternative to RTE focus bug
//
//*********************************************************************************

int lv_sqldbcode,li_code_sec
string lv_sqlerrtext,lv_sqlusrmsg,LV_TYPE, lv_note_rel_type, lv_note_sub_type
string ls_dept_code,ls_case_id,ls_case_spl,ls_case_ver
int li_rc   											//VAV 4.0 2/3/98
string ls_rel_id										//VAV 4.0 2/3/98
String ls_desc,	ls_rte_ind						// FDG 07/21/99
DateTime	ldt_note_date								//	12/07/01	GaryR	Track 2571d

setpointer(hourglass!)
SETMICROHELP(W_MAIN,'Ready')
setfocus(sle_note_name)
Cb_retrieve.default = true
If	trim(sle_note_name.text)   = '' then 
	Messagebox ('EDIT','Must Enter Note ID',stopsign!)
	setfocus(sle_note_name)
	RETURN
End If

lv_type = left(ddlb_type.text,2)
If trim(lv_type)='' then
	MessageBox('EDIT','Must Enter a Related Type',StopSign!)
	SetFocus(ddlb_type)
	RETURN
End if

If trim(sle_rel_id.text) = '' then
	MessageBox('EDIT','Must Enter a Related Id',Stopsign!)
	SetFocus(sle_rel_id)
	RETURN
End If
//End If

SetMicroHelp(w_main,'Retrieving note please wait')
//lv_sqlusrmsg = 'Connecting to Retrieve Record'


//VAV 4.0 2/3/98
If lv_type = 'CA' then
	li_rc = Inv_Subset_Functions.UF_Determine_Case_Security(sle_rel_id.text)

	If li_rc = 100 then
		MessageBox('EDIT',+ &
			    'This is a Secured Case. You have insufficient privileges for retrieving notes.')
	Elseif li_rc < 0 then
		RETURN
	End if
End if
//VAV 4.0 2/3/98 - end of new section

Ls_rel_id = sle_rel_id.text

rte_text.of_clear()

// FDG 07/21/99 - Select into ls_desc instead of mle_description
// FDG 12/13/00 - Select note_text independently
//	12/07/01	GaryR	Track 2571d
// JasonS 10/17/02 Track 2883d added note_desc/sle_note_desc.text to sql below
Select user_id, note_datetime, note_rel_type, note_sub_type, rte_ind, note_desc
into :sle_userid.text, :ldt_note_date, :ddlb_type.text, :ddlb_subtype.text, :ls_rte_ind, :sle_note_desc.text
from notes
where note_ID       = Upper( :SLE_NOTE_NAME.TEXT )
	and note_rel_id   = Upper( :ls_rel_id )	 //VAV 4.0 2/3/98 -Replaced sle_rel_id.text with ls_rel_id.
	and note_rel_type = Upper( :lv_type )
using stars2ca;

sle_date_time.text = String( ldt_note_date, "mmm dd yyyy h:mmAM/PM" )			//	12/07/01	GaryR	Track 2571d

If stars2ca.sqlcode = 100 then

	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		RETURN
	End If	
	Messagebox('EDIT','Record Not Found')
	SETMICROHELP(W_MAIN,'Ready')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
	lv_sqlerrtext = stars2ca.sqlerrtext
	lv_sqlusrmsg = 'Error Retrieving Record' + lv_sqlerrtext
	errorbox(stars2ca,lv_sqlusrmsg)	
	SETMICROHELP(W_MAIN,'Ready')
	RETURN
End If
//lv_sqlusrmsg = 'Disconnecting after Retrieve' 

//	09/17/02	GaryR	SPR 4182c
//ls_desc	=	gnv_sql.of_get_note_text (SLE_NOTE_NAME.TEXT)	// FDG 12/13/00
ls_desc	=	gnv_sql.of_get_note_text( SLE_NOTE_NAME.TEXT, lv_type, ls_rel_id )

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Committing to Stars2')
	RETURN
End If	

// FDG 07/21/99 Move retrieved text into rte_text
IF	ls_rte_ind	=	'Y'	THEN
	rte_text.PasteRTF (ls_desc, Detail!)
ELSE
	rte_text.ReplaceText( ls_desc )
END IF

//	Scroll to the top
rte_text.SelectText ( 1, 1, 0, 0 )

wf_SetModified( FALSE )		//	09/18/02	GaryR	SPR 4598c

sle_note_name.enabled = false
sle_rel_id.enabled    = false
ddlb_type.enabled     = false
gv_user_id            = sle_userid.text
//NLG 5-12-98
inv_notes.is_notes_id 		 = trim(sle_note_name.text)
inv_notes.is_notes_rel_id 	 = trim(sle_rel_id.text)
inv_notes.is_notes_rel_type = left(ddlb_type.text,2)

IF ddlb_type.text = 'CA' THEN
	st_subtype.enabled = true
ELSE
	st_subtype.enabled = false
END IF

If gv_user_id = gc_user_id then
	cb_update.enabled = true
	cb_delete.enabled = true
	wf_SetModifyRights( TRUE )	//Gary-R	04/27/2000	Ts2173
Else
	cb_update.enabled = false
	cb_delete.enabled = false
	wf_SetModifyRights( FALSE )	//Gary-R	04/27/2000	Ts2173
End If

cb_add.enabled = false 
cb_update.default = true

// JasonS 10/29/02 Begin - Track 2883d
if not cb_update.enabled then
	sle_note_desc.enabled = false
else
	sle_note_desc.enabled = true
end if
// JasonS 10/29/02 End - Track 2883d

ib_new_note = false

if ddlb_type.text = 'CA' then
	parent.event ue_set_update_availability()
	parent.event ue_edit_case_referred()
end if

// TRACK 4594d HYL 12/22/05 start
// Without disrupting the existing behaviour of ue_set_create_availability(boolean)
// make cb_add disabled when a new noted gets created                                         
cb_add.enabled = false
// TRACK 4594d HYL 12/22/05 end

cb_retrieve.enabled = sle_note_name.enabled
ddlb_subtype.enabled = sle_note_name.enabled

cb_exit.SetFocus()
SETMICROHELP(W_MAIN,'Ready')
end event

type cb_exit from u_cb within w_notes_maint
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2555
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 170
string text = "&Close"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_exit.clicked
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	clicked for cb_exit of w_notes_maint
//
//*********************************************************************************
//
//	05/12/98	NLG	1. Change notes globals to notes nvo
//	09/18/02	GaryR	SPR 4598c	Validate pending updates
//
//*********************************************************************************
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

IF Parent.wf_IsModified() < 1 THEN Return	

inv_notes.is_notes_from = ''
inv_notes.is_notes_id = ''
inv_notes.is_notes_rel_type = ''
inv_notes.is_notes_rel_id = ''
inv_notes.is_notes_sub_type =''
close(parent)
IF(gv_relist = 1) THEN
   gv_relist = 0
  IF IsValid(w_notes_list.dw_1) then
   w_notes_list.cb_list.triggerevent(Clicked!)
  END IF
END IF
end event

type cb_print from u_cb within w_notes_maint
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 1829
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 140
string text = "&Print"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_print.clicked
//
//	Arguments:		n/a
//						
//
// Returns:			n/a
//
//	Description:	Print the content of rte_text
//		
//
//*********************************************************************************
//	
// 07/21/99	FDG	Stars 4.5.	Created
//	09/18/02	GaryR	Track 4598c	Validate pending updates
//	10/14/05	GaryR	Track 4548d	Address note printing issues
//
//*********************************************************************************

String	ls_user_id, ls_note_id, ls_rel_type, ls_sub_type, &
			ls_rel_id, ls_note_desc, ls_note_datetime, ls_note

// Clear any contents
rte_print.of_clear()

//	Get the header
ls_user_id = sle_userid.text
IF IsNull( ls_user_id ) THEN ls_user_id = ""
ls_note_id = sle_note_name.text
IF IsNull( ls_note_id ) THEN ls_note_id = ""
ls_rel_type = ddlb_type.text
IF IsNull( ls_rel_type ) THEN ls_rel_type = ""
ls_sub_type = ddlb_subtype.text
IF IsNull( ls_sub_type ) THEN ls_sub_type = ""
ls_rel_id = sle_rel_id.text
IF IsNull( ls_rel_id ) THEN ls_rel_id = ""
ls_note_desc = sle_note_desc.text
IF IsNull( ls_note_desc ) THEN ls_note_desc = ""
ls_note_datetime = sle_date_time.text
IF IsNull( ls_note_datetime ) THEN ls_note_datetime = ""

ls_note =  "~r~nUser ID: ~t" + ls_user_id + &
				"~r~nNote ID: ~t" + ls_note_id + &
				"~r~nRel Type:~t" + ls_rel_type + &
				"~r~nSub Type:~t" + ls_sub_type + &
				"~r~nRel ID: ~t" + ls_rel_id + &
				"~r~nDescription:~t" + ls_note_desc + &
				"~r~nNote Datetime: ~t" + ls_note_datetime + &
				"~r~n~r~n"

// Build the print note
rte_print.Replacetext( ls_note )
ls_note = rte_text.CopyRTF ( FALSE, Detail! )
rte_print.PasteRTF(ls_note,Detail!)
rte_print.Print (1, '', FALSE, FALSE)
end event

type cb_import from u_cb within w_notes_maint
string accessiblename = "Import"
string accessibledescription = "Import"
integer x = 2071
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 150
string text = "&Import"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_import.clicked
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	Import an ASCII or RTF file into rte_text.  
//						This will replace the existing text.
//		
//
//*********************************************************************************
//	
// 07/21/99	FDG	Stars 4.5.	Created
//
//*********************************************************************************

Parent.Event	ue_import()
end event

type cb_export from u_cb within w_notes_maint
string accessiblename = "Export"
string accessibledescription = "Export"
integer x = 2313
integer y = 1748
integer width = 242
integer height = 108
integer taborder = 160
string text = "E&xport"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_export.clicked
//
//	Arguments:		n/a
//
// Returns:			n/a
//
//	Description:	Export the notes text to an RTF or TXT file
//		
//
//*********************************************************************************
//	
// 07/21/99	FDG	Stars 4.5.	Created
//
//*********************************************************************************

Parent.Event	ue_export()
end event

