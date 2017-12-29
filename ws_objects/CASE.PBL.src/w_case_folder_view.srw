$PBExportHeader$w_case_folder_view.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_folder_view from w_master
end type
type sle_link_id from u_sle within w_case_folder_view
end type
type cb_details from u_cb within w_case_folder_view
end type
type sle_bus_desc from singlelineedit within w_case_folder_view
end type
type sle_type_desc from singlelineedit within w_case_folder_view
end type
type sle_cat_desc from singlelineedit within w_case_folder_view
end type
type cb_save from commandbutton within w_case_folder_view
end type
type p_notes from u_pb within w_case_folder_view
end type
type cb_add from commandbutton within w_case_folder_view
end type
type cb_more from commandbutton within w_case_folder_view
end type
type sle_business from singlelineedit within w_case_folder_view
end type
type st_4 from statictext within w_case_folder_view
end type
type cb_refresh from commandbutton within w_case_folder_view
end type
type cb_stop from commandbutton within w_case_folder_view
end type
type sle_category from singlelineedit within w_case_folder_view
end type
type st_3 from statictext within w_case_folder_view
end type
type st_row_count from statictext within w_case_folder_view
end type
type cb_close from commandbutton within w_case_folder_view
end type
type sle_track_type from singlelineedit within w_case_folder_view
end type
type cb_remove from commandbutton within w_case_folder_view
end type
type st_link_type from statictext within w_case_folder_view
end type
type ddlb_link_type from dropdownlistbox within w_case_folder_view
end type
type st_link_id from statictext within w_case_folder_view
end type
type st_2 from statictext within w_case_folder_view
end type
type dw_1 from u_dw within w_case_folder_view
end type
type sle_case_id from singlelineedit within w_case_folder_view
end type
type st_1 from statictext within w_case_folder_view
end type
type gb_1 from groupbox within w_case_folder_view
end type
type gb_2 from groupbox within w_case_folder_view
end type
end forward

shared variables

end variables

global type w_case_folder_view from w_master
string accessiblename = "Case Folder"
string accessibledescription = "Case Folder"
integer x = 169
integer y = 0
integer width = 3186
integer height = 2180
string title = "Case Folder"
event type integer ue_delete_target_tracks ( )
event type integer ue_delete_tracks ( )
event ue_notes ( )
event ue_edit_cb_more ( )
event ue_edit_desc ( )
event ue_edit_description ( )
event type integer ue_delete_subset ( string as_link_key,  string as_link_name,  string as_link_type )
event ue_set_add_availability ( boolean ab_switch )
event ue_set_mod_availability ( boolean ab_switch )
event ue_set_update_availability ( )
event ue_set_rename_availability ( boolean ab_switch )
sle_link_id sle_link_id
cb_details cb_details
sle_bus_desc sle_bus_desc
sle_type_desc sle_type_desc
sle_cat_desc sle_cat_desc
cb_save cb_save
p_notes p_notes
cb_add cb_add
cb_more cb_more
sle_business sle_business
st_4 st_4
cb_refresh cb_refresh
cb_stop cb_stop
sle_category sle_category
st_3 st_3
st_row_count st_row_count
cb_close cb_close
sle_track_type sle_track_type
cb_remove cb_remove
st_link_type st_link_type
ddlb_link_type ddlb_link_type
st_link_id st_link_id
st_2 st_2
dw_1 dw_1
sle_case_id sle_case_id
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_case_folder_view w_case_folder_view

type variables
Boolean in_cancel,in_tracks_required,in_rand_samp
String in_link_id,in_link_type, in_link_name
String in_from, iv_invoice_type
String in_case_status
String in_disp_hold
String in_case_business
String iv_tbl_type[]
string is_subc_tables
string ib_query_id
string ib_query_name
string ib_query_case

sx_subset_options istr_sub_opt
sx_decode_structure in_decode_struct
sx_subset_ids istr_subset_ids
boolean iv_nosqlcmd
boolean ib_target_just_added
boolean ib_look_up_link_id
boolean ib_look_up_query_id

String	is_parm

//Subset functions NVO
nvo_subset_functions   inv_subset_functions

// Stars 4.8 - Case Disposition to edit for referrals
String	is_case_disp
Constant String	ics_referred = 'REFERRED'
n_cst_case	inv_case

// JasonS 12/9/04 Track 3664 Case Component Update
String is_comp_upd_status

// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
string	is_case_id, is_case_spl, is_case_ver, is_case_key
end variables

forward prototypes
public subroutine wf_sub_criteria ()
public subroutine wf_summ_rpt ()
public subroutine wf_random_sample ()
public function integer wf_read_relationship_dw (string arg_rel_type, string arg_base_type)
public function boolean wf_search_for_hospital (string arg_tables[])
public function integer wf_lookup_pattern ()
public function integer wf_criteria_pattern ()
public subroutine wf_sample ()
protected function integer fx_delete_target (string target_id)
private function integer fx_get_trk_dept (string case_id)
public subroutine wf_view ()
public subroutine wf_target ()
protected function integer fw_delete_cra (string criteria_id)
public subroutine wf_set_more_buttons ()
public subroutine wf_rename ()
end prototypes

event type integer ue_delete_target_tracks();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_delete_target_tracks					W_Case_Folder
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Delete info from target and track records info
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Successful
//                -1				UnSuccessful
/////////////////////////////////////////////////////////////////////////////
// DESCRIPTION
//	This event calls another event to delete the tracks associated with the 
// target that the user is deleting. If a good return code is received from
// the track delete event, this event deletes the target selected by the user.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
// FNC				3/18/99		Created
// JasonS 			08/08/02		Track 4157c  update case financial totals when a track is deleted
/////////////////////////////////////////////////////////////////////////////


integer	li_rc
string	ls_case_id,		&
			ls_case_spl,	&
			ls_case_ver

Li_rc = this.event UE_Delete_Tracks()
If Li_rc <> 0 then return li_rc

ls_case_id = left(gv_active_case,10)
ls_case_spl = mid(gv_active_case,11,2)
ls_case_ver = mid(gv_active_case,13,2)	

// Delete Targets
Delete from Target_cntl
	Where	case_id  = Upper( :ls_case_id ) and 
			 	case_spl = Upper( :ls_case_spl ) and
			 	case_ver = Upper( :ls_case_ver ) and
				trgt_id  = Upper( :in_link_name )
Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Target Control Table')
	return -1
End If

Delete from Target
	where 	case_id  = Upper( :ls_case_id ) and 
			 	case_spl = Upper( :ls_case_spl ) and
				case_ver = Upper( :ls_case_ver ) and
				trgt_id  = Upper( :in_link_name )

Using  stars2ca;
If stars2ca.of_check_status() < 0 then 
	Errorbox(stars2ca,'ERROR Deleting Target Table')
	return -1
End If

stars2ca.of_commit()

// JasonS 08/08/02 Begin - Track 4157c
inv_case.uf_compute_case_totals(ls_case_id, ls_case_spl, ls_case_ver)
// JasonS 08/08/02 End - Track 4157c

Return 0
end event

event type integer ue_delete_tracks();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// ue_delete_tracks							W_Case_Folder
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Delete info from track records info
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Successful
//                -1				UnSuccessful
/////////////////////////////////////////////////////////////////////////////
// DESCRIPTION
//	This event determines if the tracks associated with the deleted target are
//	associated with any other target. If they are, the tracks are not deleted. 
// If they are only associated with the deleted target then the tracks are also
// deleted.
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
// FNC		3/18/99		Created
//	FDG		04/16/01		Stars 4.7.	Properly trim the data.
//	GaryR		08/07/02		Track 3243d	Create log entry for each deleted track
// Katie		01/20/05		Track 3741d Removed logic to determine if track associated with more
//								than one target.  Added target_id to delete statements for track and track_log.
//
/////////////////////////////////////////////////////////////////////////////
string	ls_case_id,		&
			ls_case_spl,	&
			ls_case_ver,	&
			ls_track_key,	&
			ls_message		//	GaryR	08/07/02	Track 3243d
integer	li_rc
			
long		ll_num_rows,	&
			ll_row,			&
			ll_count

ls_case_id	= Trim(left(gv_active_case,10) )		// FDG 04/16/01
ls_case_spl = mid(gv_active_case,11,2)
ls_case_ver = mid(gv_active_case,13,2)

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
// FDG 04/16/01 end

n_ds lds_tracks

lds_tracks = create n_ds

Lds_Tracks.dataobject = 'd_targets'

/*Retrieve tracks associated with target */
li_rc = Lds_Tracks.SetTransObject(stars2ca) 
if li_rc <> 1 then
messagebox('Error','Cannot retrieve links to subset id. Error in SetTransObject')
	return -1
end if

ll_num_rows = Lds_Tracks.Retrieve(ls_case_id,ls_case_spl,ls_case_ver,in_link_name)
if ll_num_rows < 1 then
	MessageBox("Delete Error","Error retrieving track keys.")
	return -1
end if

For ll_row = 1 to ll_num_rows
		
		ls_track_key = Lds_Tracks.Object.Trgt_key[ll_row]
		li_rc	=	gnv_sql.of_TrimData (ls_track_key)			// FDG 04/16/01

		Delete from track 
			where 	Case_id  = Upper( :ls_case_id ) and
						case_spl = Upper( :ls_case_spl ) and
						case_ver = Upper( :ls_case_ver ) and
						trk_key  = Upper( :ls_track_key ) and
						target_id = Upper( :in_link_name )
		Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			Messagebox('EDIT','Track Record not Found for ' + ls_track_key)
		Elseif Stars2ca.sqlcode <> 0 then
			 Errorbox(Stars2ca,'Error Deleting from Track Table')
			 RETURN -1
		End If

		Delete from track_log 
			where Case_id  = Upper( :ls_case_id ) and
					case_spl = Upper( :ls_case_spl ) and
					case_ver = Upper( :ls_case_ver ) and
					trk_key  = Upper( :ls_track_key ) and
					target_id = Upper( :in_link_name )
		Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			Messagebox('EDIT','Track Log not found for ' + ls_track_key)
		Elseif Stars2ca.sqlcode <> 0 then
			 Errorbox(Stars2ca,'Error Deleting from Log Table')
			 RETURN -1
		End If
		
		//	GaryR	08/07/02	Track 3243d - Begin
		ls_message	=	"Track "	+	ls_track_key +	" removed."

		li_rc			=	inv_case.uf_audit_log (gv_active_case, ls_message)
	
		IF	li_rc		<	0		THEN
			Stars2ca.of_rollback()
			MessageBox ('Database Error', 'Could not insert case log for removal of Track '	+	&
													ls_track_key	+	'.  Case: ' + gv_active_case + &
													'.~n~rScript: w_case_folder_view.ue_delete_tracks')
			Return -1
		END IF
		//	GaryR	08/07/02	Track 3243d - End
Next

Return 0

end event

event ue_notes();//======================================================================================
//w_case_folder::ue_notes
//Modifications:
//12-02-99	NLG	Created.
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
//======================================================================================

datetime ldt_datetime

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Case Notes')

select case_datetime into :ldt_datetime
		from case_CNTL
		where case_id = Upper( :is_case_id ) and
				case_spl = Upper( :is_case_spl ) and
				case_ver = Upper( :is_case_ver )
using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	Messagebox ('EDIT','Case must exist on Database to add a NOTE')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
			Errorbox(stars2ca,'Error Reading Case_cntl')
			RETURN
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Committing to Stars2')
	Return
End If	

n_cst_notes lnv_notes

lnv_notes.is_notes_from = 'CA'
lnv_notes.is_notes_rel_id = sle_case_id.Text
lnv_notes.idt_notes_date   = date(ldt_datetime)
OPENSheetwithParm(W_NOTES_LIST,lnv_notes,MDI_Main_Frame,Help_Menu_Position,Layered!)

end event

event ue_edit_cb_more;// FDG 09/20/01 - Stars 4.8.  New event that's triggered when the window
//						is opened and when the row changes in dw_1.


if (w_case_folder_view_uo.uo_1.pb_1.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_2.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_3.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_4.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_5.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_6.enabled = false and	&
	 w_case_folder_view_uo.uo_1.pb_7.enabled = false) then
  cb_more.enabled = false
else
  cb_more.enabled = true
end if  

end event

event ue_edit_description();SetFocus(dw_1)


end event

event type integer ue_delete_subset(string as_link_key, string as_link_name, string as_link_type);///////////////////////////////////////////////////////////////////////////////////
// Event: ue_delete_subset( )
// Purpose: Delete a subset linked to a case along with any attached targets/tracks
//
// Input: link_key, link_name, link_type
// Returns:  Interger
//					0 - successful
//				  -1 - Error
///////////////////////////////////////////////////////////////////////////////////
// Change History
///////////////////////////////////////////////////////////////////////////////////
// JasonS 09/05/02 Created.
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
///////////////////////////////////////////////////////////////////////////////////

int li_rc
Constant String ls_tgt_link_type = 'TGT'

// Set stucture for nvo_subset_functions
istr_subset_ids.subset_case_id  = is_case_id
istr_subset_ids.subset_case_spl = is_case_spl
istr_subset_ids.subset_case_ver = is_case_ver
istr_subset_ids.subset_id = in_link_id
istr_subset_ids.subset_name = in_link_name
inv_subset_functions.uf_set_structure(istr_Subset_ids)

li_rc = inv_subset_functions.uf_delete_subset()
if li_rc <> 1 then
	messagebox('Error','Unable to delete subset')
	cb_close.default = true
	return -1
end if

Return 0
end event

event ue_set_add_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_add_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for adding objects
// 					to the case folder component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************

ddlb_link_type.enabled = ab_switch
sle_link_id.enabled = ab_switch
cb_add.enabled = ab_switch
end event

event ue_set_mod_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_mod_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for modifying 
//						the case folder component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************

cb_remove.enabled = ab_switch
cb_refresh.enabled = ab_switch
cb_save.enabled = ab_switch

if ab_switch then
	dw_1.Object.DataWindow.ReadOnly="No"
else
	dw_1.Object.DataWindow.ReadOnly="Yes"
end if

this.event ue_set_rename_availability(ab_switch)

end event

event ue_set_update_availability();//*********************************************************************************
// Script Name:	ue_set_update_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the case
//						folder component base on the update status returned from
//						n_cst_case.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
//*********************************************************************************

is_comp_upd_status = inv_case.uf_get_comp_upd_status('CASEFOLDER', is_case_id , is_case_spl, is_case_ver)

choose case is_comp_upd_status 
	case 'AO'
		this.event ue_set_mod_availability(false)
		this.event ue_set_add_availability(true)
	case 'RO'
		this.event ue_set_mod_availability(false)
		this.event ue_set_add_availability(false)
	case 'AL'
		this.event ue_set_mod_availability(true)
		this.event ue_set_add_availability(true)
end choose



end event

event ue_set_rename_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_rename_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable the rename button on the more
//						screen.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//	10/25/06	GaryR		Track 4836	Do not enable Rename of referred Cases
//
//*********************************************************************************

// Do not process if Case referred
IF is_case_disp	=	ics_referred THEN Return

if isvalid(w_case_folder_view_uo) then
	w_case_folder_view_uo.uo_1.pb_7.enabled = ab_switch
end if
end event

public subroutine wf_sub_criteria ();//Script for w_case_folder - sub criteria
//*************************************************************
// AJS   01/20/98 Stars 4.0 Open criteria display with structure
//	FDG	04/04/96	Prob 58 - Remove references to 'SMP'
//	FDG	02/29/00	Stars 4.5.  Allow for patterns criteria.
//*************************************************************
Integer	li_rc

sx_display_criteria	lstr_display_criteria

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

// FDG 02/29/00 begin
IF	in_link_type	=	'PAT'		THEN
	li_rc	=	This.wf_criteria_pattern()
	Return
END IF
// FDG 02/29/00 end

if in_link_type <> 'SUB' and in_link_type <> 'ARC' then		// FDG 04/04/96
	Setmicrohelp(w_main,'Can Only view Criteria for Subsets, Sample and Patterns')
	w_case_folder_view_uo.uo_1.pb_5.enabled = false
	RETURN
End IF

setmicrohelp(w_main,'Opening Subset Criteria')
//gv_case_active = w_case_folder_view.sle_case_id.text //ajs 02-19-98
gv_active_case = w_case_folder_view.sle_case_id.text
gc_active_subset_id = in_link_id			//ajs 01/20/98
gc_active_subset_case = gv_active_case	//ajs 02/02/98
//need to set gc_active_subset_name ajs 02-19-98


//gv_subset_id = in_link_id			//ajs 01/20/98
lstr_display_criteria.parm = 'SUB'			//ajs 01/20/98
lstr_display_criteria.subset_ids.subset_id = in_link_id 		//ajs 01/20/98
lstr_display_criteria.subset_ids.subset_case_id = left(gv_active_case,10)	//ajs 02/02/98
lstr_display_criteria.subset_ids.subset_case_spl = mid(gv_active_case,11,2)	//ajs 02/02/98
lstr_display_criteria.subset_ids.subset_case_ver = mid(gv_active_case,13,2)	//ajs 02/02/98
OpenSheetwithParm(w_case_display_criteria,lstr_display_criteria,MDI_Main_Frame,Help_Menu_Position,Layered!)

end subroutine

public subroutine wf_summ_rpt ();//Script for w_case_folder - Summ Rpt
//*******************************************************************
//	FDG	04/04/96	Prob 58 - Remove all references to 'SMP'
// AJS   01/20/98 Stars 4.0 - remove sc only subset id sent
// AJS   03/04/98 4.0 TS145 - remove extra code
// 04/25/05 MikeF	SPR4386d	Unrecoverable error going to Subset Summary
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
//*******************************************************************

string parm
String lv_table_type
string lv_init_array[]

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if (in_link_type <> 'SUB' and in_link_type <> 'ARC') then	// FDG 4/4/96
	Setmicrohelp(w_main,'Can Only go to Summary Reports for Subsets and Samples')
	w_case_folder_view_uo.uo_1.pb_2.enabled = false
	RETURN
End IF

gv_exp1[] 			= lv_init_array[]
gv_exp2[] 			= lv_init_array[]
gv_left_paren[] 	= lv_init_array[]
gv_right_paren[] 	= lv_init_array[]
gv_op[] 				= lv_init_array[]
gv_logic[] 			= lv_init_array[]		
setmicrohelp(w_main,'Opening Summary Report')

istr_subset_ids.subset_case_id 	= is_case_id
istr_subset_ids.subset_case_spl 	= is_case_spl
istr_subset_ids.subset_case_ver	= is_case_ver
istr_subset_ids.subset_id 			= in_link_id
istr_subset_ids.subset_name 		= in_link_name
inv_subset_functions.uf_set_structure(istr_subset_ids)

OpenSheetwithParm(w_subset_summary_analysis,istr_subset_ids,MDI_main_frame,help_menu_position,Layered!)
return




end subroutine

public subroutine wf_random_sample ();/////////////////////////////////////////////////////////////////////////////

// Event/Function								Object				
//	--------------								------				
// wf_random_sample							w_case_folder_view
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Opens random sampling window
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	A.Sola			01/20/98		Updated to open window w/tables passed in.
// AJS				01/13/99    Allow random sample of ML
//
/////////////////////////////////////////////////////////////////////////////
string ls_parm
Sx_Rand_Samp_Selection lsx_rand_samp_selection	//ajs 01-13-99

If iv_invoice_type = 'ML' Then
	ls_parm = "W_RANDOM_SAMPLING_SELECTION" + "," + is_subc_tables
	setpointer(hourglass!)
	OpenWithParm(w_invoice_selections,ls_parm)
else 
// ajs 01-13-99 begin
	lsx_rand_Samp_Selection.invoice_type = iv_invoice_type
	lsx_rand_Samp_Selection.subc_id = ''
	lsx_rand_Samp_Selection.case_id = ''
	lsx_rand_Samp_Selection.case_spl = ''
	lsx_rand_Samp_Selection.case_ver = ''
	OpenSheetwithParm(w_random_sampling_selection, lsx_rand_Samp_Selection, MDI_Main_Frame, Help_Menu_Position,Layered!)	
//	OpenSheetwithParm(w_random_sampling_selection,iv_invoice_type,MDI_Main_Frame,Help_Menu_Position,Layered!)	
// ajs 01-13-99 end
End If

setmicrohelp(w_main,'Ready')

end subroutine

public function integer wf_read_relationship_dw (string arg_rel_type, string arg_base_type);//******************************************************************
//06-29-95 FNC Created
//This function reads the datawindow in w_main that was loaded with
//the relationship table.
//******************************************************************
String DWfilter1
int lv_nbr_rows,lv_index
//HRB 2/11/96 - remove FastTrack inv types
string lv_inv_type, lc_fasttrack_inv_type = 'Q'

w_main.dw_stars_rel_dict.SetFilter('')

if arg_base_type = '' then
   DWfilter1 = 'rel_type = ~'' + arg_rel_type + '~' and Rel_id = ~'' + gv_sys_dflt + '~''
else
   DWfilter1 = 'rel_type = ~'' + arg_rel_type + '~' and Rel_id = ~'' + gv_sys_dflt + '~' and key6 = ~'' + arg_base_type + '~''
end if

w_main.dw_stars_rel_dict.SetFilter(DWfilter1)
w_main.dw_stars_rel_dict.filter()

lv_nbr_rows = w_main.dw_stars_rel_dict.rowcount()

if lv_nbr_rows = 0 then
   messagebox('INFO','Relationship data not available. Please contact your system administrator')
   return -1
end if

For lv_index = 1 to lv_nbr_rows
	//HRB 2/11/96 - remove fasttrack inv types
	lv_inv_type = w_main.dw_stars_rel_dict.GetItemString (lv_index, 'id_2')
	if upper(left(lv_inv_type,1)) <> lc_fasttrack_inv_type then
   	iv_tbl_type[lv_index] = lv_inv_type
	end if
Next

Return 0
end function

public function boolean wf_search_for_hospital (string arg_tables[]);//****************************************************************
//This function checks to see if an ML subset has any UB92 base 
//type subsets and then eliminates the table types that are not of
//UB92 base.
//
// Arg_tables are the tables in the subset
// in_subset_table_type are the UB92 table types.
//****************************************************************

boolean lv_response
long lv_pos
int lv_index, lv_count,lv_nbr_ub92_tables,lv_nbr_ml_tables
string lv_ub92,lv_tables[]

lv_nbr_ub92_tables = upperbound(iv_tbl_type[])

lv_ub92 = iv_tbl_type[1]

For lv_index = 2 to lv_nbr_ub92_tables
    lv_ub92 = lv_ub92 + ',' + iv_tbl_type[lv_index]
Next

lv_nbr_ml_tables = upperbound(arg_tables)

lv_count = 0
For lv_index = 1 to lv_nbr_ml_tables
    lv_pos = pos(lv_ub92,arg_tables[lv_index])
    if lv_pos > 0 then
       lv_response = true
       lv_count = lv_count + 1 
       lv_tables[lv_count] = arg_tables[lv_index]   
    end if
Next

iv_tbl_type[] = lv_tables[]

return lv_response
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
istr_sub_opt.patt_struc.case_id				=	sle_case_id.text
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

sle_link_id.text	=	ls_pattern_id

Return	1

end function

public function integer wf_criteria_pattern ();//*********************************************************************************
// Script Name:	wf_criteria_pattern
//
//	Arguments:		None
//
// Returns:			Integer
//						 1	=	Success
//						-1	=	Error
//
//	Description:	This function is called when the Criteria button is clicked
//						and a Pattern case_link is hilited.
//
//						This function will get the user-defined pattern ID from the
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

setmicrohelp (w_main, 'Opening Pattern Criteria...')

// Get the hilited row from dw_1.
ll_row	=	dw_1.GetSelectedRow(0)

IF	ll_row	<	1		THEN
	Return	0
END IF

ls_pattern_id	=	dw_1.object.case_link_link_key [ll_row]

istr_sub_opt.patt_struc.come_from			=	'CRITERIA'
istr_sub_opt.patt_struc.pattern_id			=	ls_pattern_id
istr_sub_opt.patt_struc.case_id				=	sle_case_id.text
istr_sub_opt.patt_struc.sub_src_type		=	'SS'
istr_sub_opt.patt_struc.subset_id			=	'NONE'
istr_sub_opt.patt_struc.subset_table_type	=	''
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

OpenSheetWithParm (w_sampling_analysis_new, istr_sub_opt, MDI_Main_Frame, Help_Menu_Position, Layered!)  

Return	1

end function

public subroutine wf_sample ();//Script for w_case_folder - sampling
// 2-13-95 PLB pass structure to W_Sampling_Analysis and set up If stmt
//					to check table type.
// 1-20-98 AJS STARS 4.0 changes - Use subset options structure
// 08/29/05	MikeF	SPR3927d	Use instance variables for Case ID, Split, and version	
//********************************************************************
string lv_subset_table_type
string lv_table_array[],lv_subc_tables
int lv_rc


Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

if (in_link_type <> 'SUB' and in_link_type <> 'ARC') then
	Setmicrohelp(w_main,'Can Only Sample Subsets')
	w_case_folder_view_uo.uo_1.pb_1.enabled = false
   w_case_folder_view_uo.uo_1.pb_6.enabled = false //random_sample button
	RETURN
Elseif iv_invoice_type = gv_sys_dflt then
		 Messagebox('EDIT','You may not Pattern from ' + iv_invoice_type + ' common invoice type')
		 RETURN
End IF
setmicrohelp(w_main,'Opening Pattern Recognition')
//gv_case_active = sle_case_id.text		//ajs 4.0
//gv_active_subset = in_link_id			//ajs 4.0 

// 2-13-95 PLB
//Sqlcmd('CONNECT',Stars2ca,'',2)   PLB  10/18/95
istr_sub_opt.patt_struc.come_from = 'SUBSET'
istr_sub_opt.patt_struc.sub_src_type = 'SS'	//ajf 01/20/98
istr_sub_opt.patt_struc.subset_id = in_link_id
istr_sub_opt.patt_struc.case_id = sle_case_id.text

// Add to this select the new field for all table types
Select subc_sub_tbl_type,subc_tables
	 INTO :lv_subset_table_type,:lv_subc_tables
	From Sub_cntl
	where subc_id = Upper( :in_link_id )
Using Stars2ca;
If Stars2ca.of_check_status() <> 0 then
	Messagebox('EDIT','Subset Table Type Information is not Available')
	return
End IF
istr_sub_opt.patt_struc.subset_table_type = lv_subset_table_type

If lv_subset_table_type = 'ML' Then
	lv_rc = fx_decode_tables(lv_subc_tables,lv_table_array[])
	If lv_rc <> 0 Then
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error retrieving table types')
			return
		End If
	end If
Else
	lv_table_array[1] = lv_subset_table_type	
End If
istr_sub_opt.patt_struc.table_type[] = lv_table_array[]

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	

OpenSheetwithparm(w_sampling_analysis_new,istr_sub_opt,MDI_Main_Frame,Help_Menu_Position,Layered!)  


end subroutine

protected function integer fx_delete_target (string target_id);/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// fx_delete_target 							w_case_folder_view
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Delete info from target info
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
// FDG		02/20/01		Stars 4.7.  Use of_connect() in case an alter session command is needed
//	FDG		04/16/01		Stars 4.7.	Properly trim the data.
//
/////////////////////////////////////////////////////////////////////////////
Integer lv_count,	li_rc
String Lv_target_key
String lv_case_id,lv_case_spl,lv_case_ver

n_tr STARS2CA3
STARS2CA3 = CREATE n_tr 
STARS2CA3.DBMS = STARS2CA.DBMS
STARS2CA3.DATABASE = STARS2CA.DATABASE
STARS2CA3.LOGID = STARS2CA.LOGID
STARS2CA3.LOGPASS = STARS2CA.LOGPASS
STARS2CA3.SERVERNAME = STARS2CA.SERVERNAME
STARS2CA3.USERID = STARS2CA.USERID
STARS2CA3.DBPASS = STARS2CA.DBPASS
STARS2CA3.LOCK = STARS2CA.LOCK
STARS2CA3.DBPARM = STARS2CA.DBPARM

//sqlcmd('CONNECT',stars2ca3,'',2)			// FDG 02/20/01
stars2ca3.of_connect()							// FDG 02/20/01

lv_case_id 	= Trim(left(gv_active_case,10) )	//ajs 4.0 03-04-98 	// FDG 04/16/01
lv_case_spl = mid(gv_active_case,11,2)			//ajs 4.0 03-04-98 globals
lv_case_ver = mid(gv_active_case,13,2)			//ajs 4.0 03-04-98 globals

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
li_rc	=	gnv_sql.of_TrimData (target_id)
// FDG 04/16/01 end


Declare tgt_c cursor for
		Select trgt_key
			from Target
			where Case_id  = Upper( :lv_case_id ) and
					case_spl = Upper( :lv_case_spl ) and
					case_ver = Upper( :lv_case_ver ) and
					trgt_id  = Upper( :target_id )
Using stars2ca3;

Open tgt_c;
If stars2ca3.of_check_status() <> 0 then
		COMMIT using STARS2CA3;
		If stars2ca3.of_check_status() <> 0 Then
			Messagebox('EDIT','Error Commiting to Stars2')
			Return -1
		End If	
		Errorbox(Stars2ca3,'Error Opening Target  Cursor')
		//sqlcmd('DISCONNECT',stars2ca3,'',1)					// FDG 02/20/01
		stars2ca3.of_disconnect()									// FDG 02/20/01
		Destroy Stars2ca3;
		RETURN -1 
End If

Do while Stars2ca3.sqlcode = 0
		Fetch tgt_c into
			:lv_target_key;
		If stars2ca3.of_check_status() = 100 then exit

		If stars2ca3.sqlcode <> 0 then
			COMMIT using STARS2CA3;
			If stars2ca3.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return -1 
			End If	
			close tgt_c; 
			//sqlcmd('DISCONNECT',Stars2ca3,'Error fetching Target  Cursor',1)		// FDG 02/20/01
			stars2ca3.of_disconnect()																// FDG 02/20/01
			Destroy Stars2ca3;
			RETURN  -1
		End If

//Tracks are written once per case id.  A track could be in more than one
// Target per case
		Select count(*) into :lv_count
			 from target
			where Case_id  = Upper( :lv_case_id ) and
					case_spl = Upper( :lv_case_spl ) and
					case_ver = Upper( :lv_case_ver ) and
					trgt_key  = Upper( :lv_target_key )
		Using Stars2ca;

		If Stars2ca.of_check_status() <> 0 then
			 //sqlcmd('DISCONNECT',Stars2ca3,'Error Reading Target',1)			// FDG 02/20/01
			 stars2ca3.of_disconnect()														// FDG 02/20/01
			 Destroy Stars2ca3;
			 Errorbox(Stars2ca,'Error Reading Target Table')
			 RETURN -1
		Elseif lv_count > 1 then
					Continue
		End If

		Delete from track 
			where Case_id  = Upper( :lv_case_id ) and
					case_spl = Upper( :lv_case_spl ) and
					case_ver = Upper( :lv_case_ver ) and
					trk_key  = Upper( :lv_target_key )  and
					target_id = Upper( :target_id )
		Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			cb_close.default = true
			Messagebox('EDIT','Track Record not Found for ' + target_id)
		Elseif Stars2ca.sqlcode <> 0 then
			 stars2ca.of_rollback()															// FDG 02/20/01
			 //sqlcmd('DISCONNECT',Stars2ca3,'Error Deleting Track',1)			// FDG 02/20/01
			 stars2ca3.of_disconnect()														// FDG 02/20/01
			 Destroy Stars2ca3;
			 Errorbox(Stars2ca,'Error Deleting from Track Table')
			 RETURN -1
		End If

		Delete from track_log 
			where Case_id  = Upper( :lv_case_id ) and
					case_spl = Upper( :lv_case_spl ) and
					case_ver = Upper( :lv_case_ver ) and
					trk_key  = Upper( :lv_target_key )  and
					target_id = Upper( :target_id )
		Using stars2ca;
		If stars2ca.of_check_status() = 100 then
			cb_close.default = true
			Messagebox('EDIT','Track Log not found for ' + target_id)
		Elseif Stars2ca.sqlcode <> 0 then
			 stars2ca.of_rollback()																// FDG 02/20/01
			 //sqlcmd('DISCONNECT',Stars2ca3,'Error Deleting from Track',1)		// FDG 02/20/01
			 stars2ca3.of_disconnect()															// FDG 02/20/01
			 Destroy Stars2ca3;
			 Errorbox(Stars2ca,'Error Deleting from Log Table')
			 RETURN -1
		End If

Loop
close tgt_c; 
If stars2ca3.of_check_status() <> 0 then
		stars2ca.of_rollback()						// FDG 02/20/01
		//sqlcmd('Rollback',stars2ca,'Error closing Target  Cursor',1)		// FDG 02/20/01
		COMMIT using STARS2CA3;
		If stars2ca3.of_check_status() <> 0 Then
			messagebox('EDIT','Error Commiting to Stars2')
			Return -1
		End If	
		Errorbox(Stars2ca3,'Error closing Target  Cursor')
		Destroy Stars2ca3;
		RETURN -1
End If

//sqlcmd('DISCONNECT',stars2ca3,'Closing Target  Cursor',1)		// FDG 02/20/01
stars2ca3.of_disconnect()													// FDG 02/20/01
Destroy stars2ca3;
return 0
end function

private function integer fx_get_trk_dept (string case_id);//////////////////////////////////////////////////////////
// 08/31/98 AJS   FS362 convert case to case_cntl
//	09/20/01	FDG	Stars 4.8.	Get case_disp to edit for referrals
//	01/05/03	GaryR	Track 5676c	Decode Case codes and accommodate GUI
// 08/10/05 Katie Track 4449d Removed reference to case_trk_type.  Changed Track Type Description
//						to be retrieved from CODE table.
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//////////////////////////////////////////////////////////

String lv_case_id,lv_case_spl,lv_case_ver

n_cst_decode	lnv_decode

lv_case_id = left(case_id,10)
lv_case_spl = mid(case_id,11,2)
lv_case_ver = mid(case_id,13,2)

// 08/31/98 AJS   FS362 convert case to case_cntl
// FDG 09/20/01 - Get case_disp
Select  case_type,case_cat,case_status,
		  case_disp_hold,Case_business, case_disp            
	into :sle_track_type.text,:sle_category.text,:in_case_status,
		  :in_disp_hold,:in_case_business, :is_case_disp   
		from Case_CNTL
		where Case_id  = :lv_case_id and
				case_spl = :lv_case_spl and
				case_ver = :lv_case_ver 
Using stars2ca;
If stars2ca.of_check_status() = 100 then
	reset(dw_1)
	st_row_count.text = '0'
	RETURN 100
Elseif stars2ca.sqlcode <> 0 then
	st_row_count.text = ''
	Errorbox(stars2ca,'Error Reading Case Table')
	RETURN -1
End If

// Decode the values
lnv_decode.of_initialize_add()
sle_cat_desc.text = Upper( sle_category.text ) + " - " + &
					lnv_decode.of_get_description( "CA", Upper( sle_category.text ) )
sle_bus_desc.text = Upper( in_case_business ) + " - " + &
					lnv_decode.of_get_description( "LB", Upper( in_case_business ) )
sle_type_desc.text = Upper( Trim( sle_track_type.text ) ) + " - " + &
					lnv_decode.of_get_description( "TYPE", Upper( Trim( sle_track_type.text ) ) )

Stars2ca.of_commit()

RETURN 0
end function

public subroutine wf_view ();//***********************************************************************
//	Script:	wf_view
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:
//		This function is called when the user clicks the "More" button, and
//		then clicks "View".
//
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ----	-------------------------------------------------------- 
// 03/14/94 JMS	Modified call to ViewDataWindow to specify new parameters.
// 03/08/95	PLB	Modified code for 'RPT' to check if background generated
//             	report.  If it is then a check is done on the display
//             	indicator to see if already read.
//	04/04/96	FDG	Removed all references to 'SMP' (Prob 58)
// 11/12/96 FNC	FS118 add RDM as a report type. RDM is created from 
//				   	w_random_sampling_unique_hics when user checks box for
//						sampling report. Treat like RPT.
//	01/13/98	FDG	Stars 4.0 - Open the query engine window when the
//						d/w changes the link type to "PDQ" (Pre-defined
//						query).
// 01/20/98 AJS   Stars 4.0 - Modify SQl to use Delete Ind instead 
//                of the display ind. Remove old types
// 01/26/98 AJS   Stars 4.0 - Fix opening of criteria view window and globals
//	01/29/02	GaryR	Track 2552d	Predefined Report (PDR)
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	12/22/04	GaryR Track 4182d	Apply modify/update security
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	07/02/07	GaryR	Track 5089	When modifing saved PDR, update date and create log
//	04/22/08	GaryR	SPR 5103	Resolve dup providers and centralize logic
//
//***********************************************************************

string lv_rpt_id,lv_delete_ind
string lv_parm, ls_link_name

sx_display_criteria lstr_display_criteria
n_cst_report	lnv_report
n_cst_attachments	lnv_att

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

If (in_link_type = 'RPT') or (in_link_type = 'RDM') or (in_link_type = 'MED') then
	ls_link_name = dw_1.GetItemString( dw_1.GetRow(), "case_link_link_name" )

	Select delete_ind                   //01-20-97 AJS
		into :lv_delete_ind					//01-20-97 AJS
		from bg_rpt_cntl
		where rpt_id = Upper( :in_link_id )
	Using stars2ca;
	Stars2ca.of_check_status()
	If stars2ca.sqlcode = 100 then
		//rpt not generated and 'ML' from back end
		stars2ca.of_commit()
		lnv_report.of_view( gv_active_case, in_link_id, ls_link_name, cb_save.enabled )
	ElseIf stars2ca.sqlcode = 0 Then
		If lv_delete_ind = 'Y' Then		//01-20-97 AJS
			//Rpt has already been viewed and saved as stars report
			stars2ca.of_commit()
			lnv_report.of_view( gv_active_case, in_link_id, ls_link_name, cb_save.enabled )
		Else 
			lnv_report.of_view_patt_rpt( gv_active_case, in_link_id, ls_link_name )
		End If
	Else				
		Messagebox('Database error','Unable to read the Background Report Control Table')
		Return
	End If	                                //03-08-95 PLB End
elseif (in_link_type = 'SUB' or in_link_type = 'ARC') then	// FDG 04/04/96
		SX_Query_Engine_Parms Lstr_Query_Parms
		//	Clear the query engine parms from previous attempts
		inv_queryengine.uf_clear_query_parms()
		//Get subset parms. from list
		Lstr_Query_Parms.subset_id = gc_active_subset_id
		Lstr_Query_Parms.subset_name = gc_active_subset_name
		Lstr_Query_Parms.case_id  = is_case_id
		Lstr_Query_Parms.case_spl = is_case_spl
		Lstr_Query_Parms.case_ver = is_case_ver
		// Set the subset parms. on nvo
		inv_queryengine.uf_set_sxQueryEngineParms (Lstr_Query_Parms)	 
		//	Open the query engine window
		inv_queryengine.uf_open_query_engine()
//		ajs 4.0 end
Elseif (in_link_type = 'TGT') then
		//Opening an instance of this window
		gv_from = 'VIEW'
		gv_case_target = in_link_id
//		gv_case_subset = ''	// ajs 4.0 03-04-98
		gv_target_subset_id = ''	//ajs 4.0 03-04-98
		w_target_view w_targ
		openSheet(w_targ,MDI_Main_Frame,Help_Menu_Position,Layered!)
		w_targ.cb_list_targets.visible = false
		w_targ.cb_notes.visible = false
		w_targ.sle_target_id.displayonly = true
		w_targ.sle_subset_id.displayonly = true
		w_targ.sle_description.displayonly = true
//	01/29/02	GaryR	Track 2552d
//Elseif (in_link_type = 'PDQ') then
Elseif in_link_type = 'PDQ' OR in_link_type = 'PDR' then
		//	Open the query engine window
		//	Clear the query engine parms from previous attempts
		inv_queryengine.uf_clear_query_parms()
		//	01/29/02	GaryR	Track 2552d
		inv_queryengine.uf_set_query_engine_mode( in_link_type )
		//	Get the query ID from the datawindow
		inv_queryengine.uf_set_query_id(in_link_id)
		//	Open the query engine window
		inv_queryengine.uf_open_query_engine()
//01-20-98 Anne-s
Elseif (in_link_type = 'CRC' or in_link_type = 'CRA') then 
		//ajs 4.0 02-26-98 fix opening of display criteria window
		//	OpenSheetwithParm(w_case_display_criteria,in_link_type,MDI_Main_Frame,Help_Menu_Position,Layered!)
		gv_active_case = w_case_folder_view.sle_case_id.text
		gc_active_subset_id = in_link_id			//ajs 01/20/98
		gc_active_subset_case = gv_active_case	//ajs 02/02/98
		//need to set gc_active_subset_name ajs 02-19-98


		//gv_subset_id = in_link_id			//ajs 01/20/98
		lstr_display_criteria.parm = in_link_type		//ajs 01/20/98
		lstr_display_criteria.subset_ids.subset_id = in_link_id 		//ajs 01/20/98
		lstr_display_criteria.subset_ids.subset_case_id  = is_case_id
		lstr_display_criteria.subset_ids.subset_case_spl = is_case_spl
		lstr_display_criteria.subset_ids.subset_case_ver = is_case_ver
		OpenSheetwithParm(w_case_display_criteria,lstr_display_criteria,MDI_Main_Frame,Help_Menu_Position,Layered!)
		//ajs 4.0 fix end
Elseif in_link_type = 'ATT' THEN
	lnv_att.of_view( in_link_id )
Else
		setmicrohelp(w_main,'Can view only Types ~'ATT~', ~'SUB~', ~'ARC~', ~'TGT~',' &
						+'~'CRC~' , ~'CRA~', ~'MED~' , ~'PDQ~' , ~'PDR~' , ~'RPT~'and ~'RDM~'')	//01-20-98 AJS	//	01/29/02	GaryR	Track 2552d
End if

end subroutine

public subroutine wf_target ();//Script for w_case_folder - Target
//**************************************************************
// 03-04-98 ajs 4.0 TS145-globals
// 01-20-98 AJS Change select to use subc_cntl
// If link type = subset
// Then  must go through subset/target link logic  
// 06-30-95 FNC Determine table types available for revenue tracking
//              utilizing a datawindow on w_main that contains the
//              relationship window. Call a window function to retrieve
//              all QT entries with a base type = 'UB92'
// 03-03-95 PLB Added coe form 'ML subsets' - decode subc_table
//              then loop to determine if hospital is included.
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//***************************************************************
String lv_table_array[]
String lv_tbl_type,lv_sub_tbl_type,lv_subc_tables
int li_count
int lv_relationship_rc,lv_nbr_hosp_tables,lv_index
Boolean hosp_flag
n_cst_attachments	lnv_att

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

// Handle attachments first
// This is the Download option
IF in_link_type = 'ATT' THEN
	lnv_att.of_download( in_link_id )
	Return
END IF

If w_case_folder_view.Sle_category.text = 'REF' or w_case_folder_view.sle_category.text = 'CA?' then
	Messagebox('EDIT','Cannot Go to Tracking For Case Category ' &
		+ w_case_folder_view.sle_category.text)
	w_case_folder_view.cb_close.default = true
	RETURN
End IF
setmicrohelp(w_main,'Opening Targets Screen')

If in_link_type = 'SUB' or in_link_type = 'ARC' then
//	in_tracks_required = false
//	Need this put here as well because add link triggers this button
//pat-d open same screen for all targets to be viewed
	Select count(*) into :li_count
		from target_cntl
		where case_id  = Upper( :is_case_id ) and
				case_spl = Upper( :is_case_spl ) and
				case_ver = Upper( :is_case_ver ) and
			   subc_id  = Upper( :in_link_id )
	Using Stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(Stars2ca,'Unable to Read Target Control')
		RETURN
	End If

	If li_count > 0 then
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return
		End If	
//		gv_case_subset =  in_link_id 			//ajs 4.0 03-04-98
		gv_target_subset_id =  in_link_id 	//ajs 4.0 03-04-98
		gv_case_target =  ''
		gv_from = 'M'
		OpenSheet(w_target_view,MDI_main_frame,help_menu_position,Layered!)
		RETURN
	End IF

//10-18-94 PRD Don't go to targets if the track type is RV and 
// subset type is not the group or hospital
//07-02-95 FNC Start
	If sle_track_type.text = 'RV' and iv_invoice_type <> gv_sys_dflt then
      lv_relationship_rc = wf_read_relationship_dw('QT','UB92')
      if lv_relationship_rc <> 0 then 
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return
			End If	
         messagebox('INFO','Cannot create targets.Problem reading relationship datawindow')
         return
      end if
// 03-03-95 PLB Start
		If iv_invoice_type = 'ML' Then
			Select subc_sub_tbl_type,subc_tables
				into :lv_sub_tbl_type,:lv_subc_tables
				from sub_cntl
				where subc_id  = Upper( :in_link_id )
			Using stars2ca;
			If stars2ca.of_check_status() <> 0 Then
				Errorbox(stars2ca,'Error reading Sub Control Table')
				Return
			End If	
			fx_decode_tables(lv_subc_tables,lv_table_array[])
         hosp_flag = wf_search_for_hospital(lv_table_array[])	
//03-03-95 PLB End
      else 
         lv_nbr_hosp_tables = upperbound(iv_tbl_type)
         For lv_index = 1 to lv_nbr_hosp_tables
   		    If (iv_tbl_type[lv_index] = iv_invoice_type ) then
                hosp_flag = true
             end if
         Next
      end if
      if hosp_flag = false then
		//KMM 7/18/95 Prob#99 Changed from Microhelp to messagebox 
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				errorbox(stars2ca,'Error Commiting to Stars2')
				Return
			End If	
			messagebox('Information','This is a ' + iv_invoice_type + ' Subset.' +  &
			'  Revenue Codes can only be tracked for Hospital Claims.') 
//   	   Setmicrohelp(W_main,'This is a ' + iv_invoice_type + &
//		   ' Subset.  Revenue Codes can only be tracked for  ' + &
//     	   + ' Hospital Claims') 
         Return
		end if
	end IF

	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
//	gv_case_subset =  in_link_id						//ajs 4.0 03-04-98
	gv_target_subset_id =  in_link_id				//ajs 4.0 03-04-98
//	gv_active_subset = gv_case_subset				//ajs 4.0 03-04-98
	gc_active_subset_id = gv_target_subset_id		//ajs 4.0 03-04-98
	gv_case_target =  ''
	gv_from = 'FOLDER'
	openSheet (w_target_subset_maintain,MDI_Main_Frame,Help_Menu_Position,Layered!)
ElseIf in_link_type = 'TGT' then
//	gv_case_subset =  ''			//ajs 4.0 03-04-98
	gv_target_subset_id = ''	//ajs 4.0 03-04-98
	gv_case_target =  in_link_id
	If ib_target_just_added = true then
		ib_target_just_added = false
		gv_from = 'FOLDER'
		openSheet(w_target_maintain,MDI_Main_Frame,Help_Menu_Position,Layered!)
	Else
//pat-d open one window to view regardless of how the target was created
		Select count(*) into :li_count
			from target_cntl
			where case_id  = Upper( :is_case_id ) and
					case_spl = Upper( :is_case_spl ) and
					case_ver = Upper( :is_case_ver ) and
				   Trgt_id  = Upper( :in_link_id )
		Using Stars2ca;
		If stars2ca.of_check_status() <> 0 then
			Errorbox(Stars2ca,'Unable to Read Target Control')
			RETURN
		End If
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return
		End If	
		If li_count > 0 then
			gv_from = 'M'
			OpenSheet(w_target_view,MDI_main_frame,help_menu_position,Layered!)
			RETURN
		Else
			gv_from = 'FOLDER'
			openSheet(w_target_maintain,MDI_Main_Frame,Help_Menu_Position,Layered!)
		End IF
	End IF
Else
	setmicrohelp(w_main,'Select Valid for Types ~'SUB~', ~'ARC~' and ~'TGT~'')
	w_case_folder_view_uo.uo_1.pb_3.enabled = false
End If
setpointer(arrow!)
end subroutine

protected function integer fw_delete_cra (string criteria_id);
/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// fx_delete_cra								w_case_folder_view
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Delete info from Analysis criteria Sort table
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    Value       criteria_id			string
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Successful
//                1				UnSuccessful
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date		Description
// ------	----		-----------
//	A.Sola	01/20/98	Updated.
//	FDG		09/23/98	Track 1794.  Remove tables anal_crit_col, anal_crit_from_tbls,
//							anal_crit_grp, anal_crit_stack.
//
/////////////////////////////////////////////////////////////////////////////

Delete from Anal_crit_cntl
	where crit_id  = Upper( :in_link_id )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return -1
	End If	
	Messagebox('EDIT','Analysis Criteria Control Record Has Already Been Deleted')
	Return 100
Elseif Stars2ca.sqlcode <> 0 then
		 Errorbox(Stars2ca,'Error Deleting from Analysis Criteria Control Table')
		 RETURN -1
End If


Delete from Anal_crit_line
	where crit_id  = Upper( :in_link_id )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return -1
	End If	
	Messagebox('EDIT','Analysis Criteria Line Record Has Already Been Deleted')
	Return 100
Elseif Stars2ca.sqlcode <> 0 then
		 Errorbox(Stars2ca,'Error Deleting from Analysis Criteria Line Table')
		 RETURN -1
End If


Delete from Anal_crit_sort
	where crit_id  = Upper( :in_link_id )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return -1
	End If	
	Messagebox('EDIT','Analysis Criteria Sort Record Has Already Been Deleted')
	Return 100
Elseif Stars2ca.sqlcode <> 0 then
		 Errorbox(Stars2ca,'Error Deleting from Analysis Criteria Sort Table')
		 RETURN -1
End If

return 0
end function

public subroutine wf_set_more_buttons ();// 06/12/02  JasonS  Track 3065 - Should not have Pattern, Random Sample, or Summ Rpt for AN types

// Begin - Track 3065
boolean lb_an_type
string ls_sqlstatement, ls_rel_id

lb_an_type = false
ls_sqlstatement = "SELECT rel_id from stars_rel where rel_type = 'AN'"

DECLARE an_cursor DYNAMIC CURSOR FOR SQLSA ;

PREPARE SQLSA FROM :ls_sqlstatement using stars2ca;

OPEN DYNAMIC an_cursor;

FETCH NEXT an_cursor INTO :ls_rel_id;

do while (stars2ca.sqlcode = 0)
	if (in_link_type = 'SUB') AND (dw_1.getitemstring(dw_1.getrow(),'sub_cntl_subc_sub_tbl_type') = ls_rel_id) then
		lb_an_type = true
	end if
	FETCH NEXT an_cursor INTO :ls_rel_id;
Loop

CLOSE an_cursor ;

if lb_an_type then
	w_case_folder_view_uo.uo_1.pb_1.enabled	=	FALSE		// Patterns
	w_case_folder_view_uo.uo_1.pb_6.enabled	=	FALSE		// Random Sample
	w_case_folder_view_uo.uo_1.pb_2.enabled	=	FALSE		// Summ Rpt
	w_case_folder_view_uo.uo_1.pb_3.enabled	=	FALSE		// Target
end if

// End - Track 3065


end subroutine

public subroutine wf_rename ();//Script for w_case_folder - rename
//****************************************************************
// AJS   01/20/98 Stars 4.0 change to pass structure to rename window
// FNC	11/12/96	FS118 add RDM as a report type. RDM is created from 
//						w_random_sampling_unique_hics when user checks box for
//					   sampling report. Treat like RPT.
// FNC	07/01/96 STARCARE Prob #907 Allow users to rename MED reports
// FNC   04/25/96 STARS31 Prob # 269 allow rename for ARC subsets
//	FDG	04/04/96	Prob 58 - Remove all references to 'SMP'
//	FDG	02/25/00	Stars 4.5 - Allow for patterns.
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	GaryR	01/29/02	Track 2552d	Predefined Report (PDR)
// MikeF 07/23/02 Track 3197d Pass the LINK_ID when Renaming report
//	GaryR	08/27/02	Track 3197d	Redesign the logic
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
//*******************************************************************
Long	ll_row
sx_case_link_info lstr_case_link_info

ll_row = dw_1.GetRow()

IF ll_row < 1 THEN
	MessageBox( "Link Rename", "Please select a valid row to rename" )
	Return
END IF

lstr_case_link_info.link_type	=	dw_1.GetItemString( ll_row, "case_link_link_type" )
lstr_case_link_info.link_name	=	dw_1.GetItemString( ll_row, "case_link_link_name" )
lstr_case_link_info.link_id	=	dw_1.GetItemString( ll_row, "case_link_link_key" )
lstr_case_link_info.case_id	=	is_case_id
lstr_case_link_info.case_spl	=	is_case_spl
lstr_case_link_info.case_ver	=	is_case_ver

IF lstr_case_link_info.link_type = "TGT" THEN
	MessageBox( "Link Rename", "Targets cannot be renamed" )
	Return
END IF

OpenWithParm( w_case_folder_rename, lstr_case_link_info )
cb_refresh.Event Clicked()
//	GaryR	08/27/02	Track 3197d - End
end subroutine

event open;call super::open;//////////////////////////////////////////////////////////////////////////////////////
//
// 08/08/94 FNC	Display case business on the screen
// 04/25/96 FNC	STARS31 Prob #269 Allow rand samp for ARC Subsets
//	01/13/98 FDG	Use the query engine service
// 01/20/98 AJS	Change the column number for Subset ID from 2 to 7;
//          		add creation of nvo subset functions
//	07/15/98 NLG	Track #1471 Check security before allowing to view folder
// 09/29/99 FNC	Stars 4.5 Use security check in n_cst_case
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	09/20/01	FDG	Stars 4.8.1.	A newly referred case has its data copied.
//						Remove edits for sle_category = 'REF'.  Add edits for
//						the original case being referred.
//	01/29/02	GaryR	Track 2552d	Predefined Report (PDR)
// 08/13/02	Jason	Track 3065d  call wf_set_more_buttons
//	02/06/03	GaryR	Tracks 2324d, 3437d	Disable rename and description field if the Stars 
//						user is not the owner of the link or if the Case link is referred
// 08/29/05	MikeF	SPR3927d	Create instance variable for Case ID, Split, and version	
// 09/26/05 MikeF	SPR4521d Delete message showing PDQ ID rather than name
//////////////////////////////////////////////////////////////////////////////////////

String ls_case_cat, ls_link_type
String  lv_title
string ls_security_msg
Boolean lv_active_subset,lv_active_criteria
long lv_nrows
integer lv_count, li_rc
integer lv_result,lv_active_subset_row,lv_row
//n_cst_case lnv_cst_case				// FDG 09/20/01

SETPOINTER(HOURGLASS!)
open (w_case_folder_view_uo)

SETPOINTER(HOURGLASS!)
setmicrohelp(w_main,'Opening Case Folder')

This.of_set_queryengine (TRUE)		//	FDG 01/13/98

in_from = gv_from

If gv_active_case = '' then		//ajs 4.0 02-19-98 globals
	setmicrohelp(w_main,'No Active Case, Must have an Active Case to ' &
						+ 'View Folder')
	cb_close.Postevent(clicked!)
	RETURN
End If

inv_subset_functions = Create nvo_subset_functions			//ajs 01-20-98	

// Set instance case variables. ONCE.
is_case_id  = Trim (left(gv_active_case,10) )				
is_case_spl = mid(gv_active_case,11,2)
is_case_ver = mid(gv_active_case,13,2)
// Trim data
gnv_sql.of_TrimData(is_case_spl)
gnv_sql.of_TrimData(is_case_ver)
is_case_key = is_case_id + is_case_spl + is_case_ver

inv_case		=	CREATE	n_cst_case			// FDG 09/20/01
ls_security_msg = inv_case.uf_edit_case_security(is_case_id,is_case_spl,is_case_ver)	// FDG 09/20/01

if trim(ls_security_msg) <> '' then
	messagebox('SECURITY',ls_security_msg)
	cb_close.Postevent(clicked!)
	return
end if
// FNC 09/29/99 End

This.of_SetTransaction (STARS2CA)

//sle_case_id.text = trim(gv_case_active)		//ajs 4.0 02-19-98 globals
sle_case_id.text = trim(gv_active_case)		//ajs 4.0 02-19-98 globals

cb_remove.enabled = false
cb_add.enabled    = false
w_case_folder_view_uo.uo_1.pb_1.enabled = false
w_case_folder_view_uo.uo_1.pb_2.enabled = false
w_case_folder_view_uo.uo_1.pb_3.enabled = false
w_case_folder_view_uo.uo_1.pb_4.enabled = false
w_case_folder_view_uo.uo_1.pb_5.enabled = false
w_case_folder_view_uo.uo_1.pb_6.enabled = false  		//random sampling

//KMM 8/22/95 PROB#1066 Read to see if notes exist for case
Select count(*) into :lv_count
From Notes
Where note_rel_type = 'CA' 
and note_rel_id = Upper( :sle_case_id.text )
using stars2ca;
if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error reading Notes table: Note_rel_type = CA and note_rel_id = ' + sle_case_id.text)
	return
end if

if lv_count > 0 then
	p_notes.visible = true
else
	p_notes.visible = false
end if
//KMM END


//Gets the track type and the category for the case
//lv_result = fx_get_trk_dept(gv_case_active)  //alabama2 pat-d	//ajs 4.0 globals
lv_result = fx_get_trk_dept(gv_active_case)  //alabama2 pat-d		//ajs 4.0 globals
If lv_result = -1 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox('Error','Unable to Read Case/Code Table')
	cb_close.Postevent(clicked!)
	RETURN
Elseif lv_result = 100 then
		 COMMIT using STARS2CA;
		 If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return
		 End If
		 // SAH 03/27/02 -Add MessageBox
		 MessageBox('Error', 'Record not found in Case table')
		 Setmicrohelp(w_main,'Select an Active Case')
		 RETURN
End If

If settransobject(dw_1,Stars2ca) < 0 then	
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_close.default = true
	RETURN
End If

show(this)
this.setredraw(false)
iv_nosqlcmd=true
lv_nrows=dw_1.retrieve(is_case_id,is_case_spl,is_case_ver)
st_row_count.text = string(lv_nrows)
iv_nosqlcmd=false
setpointer(hourglass!)
this.setredraw(true)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
cb_close.default = true

sle_business.text = in_case_business                //08-08-94 FNC

If integer(st_row_count.text) < 0 then
	Messagebox('EDIT','Error Retrieving Data from Case Link')
	RETURN
ElseIf integer(st_row_count.text) = 0 then
		 setmicrohelp(w_main,'Nothing Has been Linked to this case')
		 // FDG 09/20/01 - remove references to 'REF'
		 //If sle_category.text <> 'CA?' AND SLE_CATEGORY.TEXT <> 'REF' then  
		 If sle_category.text	<> 'CA?'	&
		 and is_case_disp			<>	ics_referred	then  
			 gb_1.show()
			 ddlb_link_type.show()		//show groupbox again DJP 12/9/94
			 st_link_type.show()
			 st_link_id.show()
			 sle_link_id.show()
			 cb_add.show()
			 cb_add.enabled = true
			 cb_Add.default = true
			 ddlb_link_type.setfocus()
		 Else
			 sle_link_id.visible = false
			 ddlb_link_type.visible = false
			 st_link_type.visible = false
			 st_link_id.visible = false
			 gb_1.visible = false
			 cb_add.visible = false
			 cb_remove.visible = false				  
		 End If
		 RETURN
End If

//Coming in from w_case_maint CB_UPDATE with a prior category of REF or CA?
//Sets a switch if subsets exists for the referred case to ensure 
//tracks are created otherwise the subset must be delinked before exit
For lv_result = 1 to integer(st_row_count.text)
	 If getitemstring(dw_1,lv_result,1) = 'SUB' &
	 	or getitemstring(dw_1,lv_result,1) = 'ARC' then
	 	// FDG 09/20/01 - remove references to 'REF'
		//If  is_parm = 'REF' OR  &
		//	 (is_parm = 'CA?' and sle_category.text <>  'CA?') then
		If  (is_parm = 'CA?' and sle_category.text <>  'CA?') then
				//KMM Clear out message parm (PB Bug)
				SetNull(message.stringparm)
				in_tracks_required = true
		End IF
		If gc_active_subset_id <> '' then
			If getitemstring(dw_1,lv_result,"case_link_link_key") = gc_active_subset_id then  //ajs 01-20-98
//					lv_active_subset = true
				lv_active_subset_row = lv_result
			End If
		End If
	End IF
	
	//	Protect if user id is not the 
	//	current user or if case is refered.
	IF gc_user_id <> dw_1.GetItemString( lv_result, "case_link_user_id" ) &
	OR	is_case_disp = "REFERRED" THEN 
		dw_1.SetItem( lv_result, "compute_0010", "1" )
		dw_1.SetItemStatus( lv_result, "compute_0010", Primary!, NotModified! )
	END IF
Next

If lv_active_subset_row  = 0 or IsNull(lv_active_subset_row) then
	lv_active_subset_row = 1
	cb_close.default = true
Else
//	w_case_folder_view_uo.uo_1.pb_3.default = true
End IF

dw_1.Event RowFocusChanged( lv_active_subset_row )
dw_1.setfocus()

// FDG 09/20/01 - remove references to 'REF'
//If sle_category.text = 'REF'  then
If is_case_disp	=	'REFERRED'  then
	st_link_type.visible = false
	st_link_id.visible = false
	sle_link_id.visible = false
	ddlb_link_type.visible = false
	gb_1.visible = false
	cb_add.visible = false
	cb_remove.visible = false
	cb_save.visible = FALSE
		
	This.Event	ue_edit_cb_more()
	Return
	// FDG 09/20/01 end
	
Elseif sle_category.text = 'CA?' then
	 st_link_type.visible = false
	 st_link_id.visible = false
	 sle_link_id.visible = false
	 ddlb_link_type.visible = false
	 gb_1.visible = false
	 cb_add.visible = false
	 cb_remove.enabled = true       //alabama2 pat-d
Else
	 gb_1.show()
	 ddlb_link_type.show()		//show groupbox again DJP 12/9/94
	 st_link_type.show()
	 st_link_id.show()
	 sle_link_id.show()
	 cb_add.show()
	cb_add.enabled = true
	cb_remove.enabled = true
End IF

lv_row = dw_1.getrow()  //if a subset is selected, enable button if true
ls_link_type = dw_1.getitemstring(lv_row,"case_link_link_type")			//ajs 02/05/98
in_link_type = ls_link_type
in_link_id   = dw_1.getitemstring(lv_row,"case_link_link_key")				//ajs 4.0 02-19-98
If in_link_type = 'SUB' or in_link_type = 'ARC' then 							//ajs 01-19-98
	gc_active_subset_id = in_link_id													//ajs 01-19-98
	gc_active_subset_name = dw_1.getitemstring(lv_row,"case_link_link_name")	//ajs 01-19-98
	gc_active_subseT_case = gv_active_case											//ajs 01-19-98
End If
in_rand_samp = TRUE
if ls_link_type = 'SUB' or ls_link_type = 'ARC' and in_rand_samp then
	w_case_folder_view_uo.uo_1.pb_6.enabled = true
end if

//	01/29/02	GaryR	Track 2552d
if ls_link_type = 'PDQ' OR ls_link_type = 'PDR' then					//ajs 02/05/98
	w_case_folder_view_uo.uo_1.pb_4.enabled = true  //View button	//ajs 02/05/98
end if																				//ajs 02/05/98


if iv_invoice_type = "MC" then  //ajs 01-20-98 remove invoice type ml
   w_case_folder_view_uo.uo_1.pb_6.enabled = false  
end if

// FDG 09/20/01 - Trigger rowfocuschanged of dw_1 and edit the enabling of cb_mo
This.Event	ue_edit_cb_more()
// FDG 09/20/01 end

// JasonS 08/13/02 Begin - Track 3065d
wf_set_more_buttons()
// JasonS 08/13/02 End - Track 3065d
	
//setmicrohelp(w_main,'Ready')
w_main.SetMicroHelp('Select a link')
end event

event activate;
//  w_case_folder_view_uo.enabled = false
If isvalid(w_case_folder_view_uo) then
	w_case_folder_view_uo.visible = false
End IF

end event

event close;call super::close;//ajs 01-20-98 destroy subset functions nvo
//NLG 8-31-99	ts2363c.
//					Trigger w_case_maint.ue_retrieve instead of cb_retrieve
//	FDG	09/20/01	Stars 4.8.1.	Destroy inv_case
//
///////////////////////////////////////////////////////////////////////
String lv_case_id,lv_case_spl,lv_case_ver
Integer lv_result

SETPOINTER(HOURGLASS!)
setmicrohelp(w_main,'')

If Isvalid(w_case_maint)  then
 If in_from = 'CASE' then
	If w_case_maint.in_track_exists = false then
			//triggerevent(w_case_maint.cb_retrieve,clicked!)
			triggerevent('w_case_maint.ue_retrieve')
	End If
 End If
End If

If isvalid(w_case_display_criteria) then
	close(w_case_display_criteria)
End IF
If isvalid(w_case_folder_view_uo) then
	close(w_case_folder_view_uo)
End IF

// FDG 09/20/01 - destroy inv_case
IF	IsValid (inv_case)	THEN	Destroy	inv_case

destroy inv_subset_functions	//ajs 01-20-98
setpointer(arrow!)

end event

on rbuttondown;if (w_case_folder_view_uo.uo_1.pb_1.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_2.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_3.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_4.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_5.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_6.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_7.enabled = false ) then
  cb_more.enabled = false
  messagebox ("Message", "All Option Buttons Are Disabled In Current Condition.")
else
  cb_more.enabled = true
  cb_more.default = false	
  w_case_folder_view_uo.enabled = true
  w_case_folder_view_uo.visible = true
end if  


end on

event deactivate;// enable the refresh button for when the user next sees this window
//if GetFocus() <> cb_add and GetFocus() <> cb_remove &
//  and GetFocus() <> ddlb_link_type and GetFocus() <> w_case_folder_view_uo.uo_1.pb_7 then  //pb_7 is rename button
//if GetFocus() <> cb_add and GetFocus() <> cb_remove &
// and GetFocus() <> ddlb_link_type then
	cb_refresh.default = TRUE
//end if
end event

on w_case_folder_view.create
int iCurrent
call super::create
this.sle_link_id=create sle_link_id
this.cb_details=create cb_details
this.sle_bus_desc=create sle_bus_desc
this.sle_type_desc=create sle_type_desc
this.sle_cat_desc=create sle_cat_desc
this.cb_save=create cb_save
this.p_notes=create p_notes
this.cb_add=create cb_add
this.cb_more=create cb_more
this.sle_business=create sle_business
this.st_4=create st_4
this.cb_refresh=create cb_refresh
this.cb_stop=create cb_stop
this.sle_category=create sle_category
this.st_3=create st_3
this.st_row_count=create st_row_count
this.cb_close=create cb_close
this.sle_track_type=create sle_track_type
this.cb_remove=create cb_remove
this.st_link_type=create st_link_type
this.ddlb_link_type=create ddlb_link_type
this.st_link_id=create st_link_id
this.st_2=create st_2
this.dw_1=create dw_1
this.sle_case_id=create sle_case_id
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_link_id
this.Control[iCurrent+2]=this.cb_details
this.Control[iCurrent+3]=this.sle_bus_desc
this.Control[iCurrent+4]=this.sle_type_desc
this.Control[iCurrent+5]=this.sle_cat_desc
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.p_notes
this.Control[iCurrent+8]=this.cb_add
this.Control[iCurrent+9]=this.cb_more
this.Control[iCurrent+10]=this.sle_business
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_refresh
this.Control[iCurrent+13]=this.cb_stop
this.Control[iCurrent+14]=this.sle_category
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.st_row_count
this.Control[iCurrent+17]=this.cb_close
this.Control[iCurrent+18]=this.sle_track_type
this.Control[iCurrent+19]=this.cb_remove
this.Control[iCurrent+20]=this.st_link_type
this.Control[iCurrent+21]=this.ddlb_link_type
this.Control[iCurrent+22]=this.st_link_id
this.Control[iCurrent+23]=this.st_2
this.Control[iCurrent+24]=this.dw_1
this.Control[iCurrent+25]=this.sle_case_id
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.gb_1
this.Control[iCurrent+28]=this.gb_2
end on

on w_case_folder_view.destroy
call super::destroy
destroy(this.sle_link_id)
destroy(this.cb_details)
destroy(this.sle_bus_desc)
destroy(this.sle_type_desc)
destroy(this.sle_cat_desc)
destroy(this.cb_save)
destroy(this.p_notes)
destroy(this.cb_add)
destroy(this.cb_more)
destroy(this.sle_business)
destroy(this.st_4)
destroy(this.cb_refresh)
destroy(this.cb_stop)
destroy(this.sle_category)
destroy(this.st_3)
destroy(this.st_row_count)
destroy(this.cb_close)
destroy(this.sle_track_type)
destroy(this.cb_remove)
destroy(this.st_link_type)
destroy(this.ddlb_link_type)
destroy(this.st_link_id)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.sle_case_id)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;is_parm	=	Message.StringParm
SetNull (Message.StringParm)
end event

event ue_save;call super::ue_save;Return 0
end event

event ue_postopen;call super::ue_postopen;// 12/9/2004  JasonS  Track 3664 Case Component Update
this.event ue_set_update_availability()

end event

type sle_link_id from u_sle within w_case_folder_view
string accessiblename = "Link ID"
string accessibledescription = "Link ID"
integer x = 2245
integer y = 204
integer width = 823
integer height = 96
integer taborder = 20
boolean autohscroll = true
textcase textcase = upper!
integer limit = 20
end type

event ue_lookup;call super::ue_lookup;//*************************************************************
// 11/18/98 FDG	Track 1903 - Move to rbuttonup from rbuttondown
//	06-25-98 NLG	Track #1326 - if opening Subset Use, set gv_from to 'FOLDER'
//						so that subset use displays only independent subsets
// 07-12-95 FNC	Commented unused code
// 11/01/99 AJS	Rel 4.5 ts2463 - pass empty structure to w_subset_use
//	02/25/00	FDG	Stars 4.5 - Allow for patterns
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	01/29/02	GaryR	Track 2552d	Predefined Report (PDR)
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*************************************************************

string ls_query_id, ls_sql
String	ls_path, ls_name
integer li_orig_row
sx_subset_use lstr_subset_use
n_ds ds_sub_opt_case_link

setpointer(hourglass!)

If left(ddlb_link_type.text,3) = 'SUB' then	
	gv_from = 'FOLDER'							//NLG 6-25-98 Track #1326
	OpenWithParm(w_subset_use,lstr_subset_use,parent)	//ajs 11/01/99
	If gv_result = 0 Then
		ib_look_up_link_id = true
 		sle_link_id.text = gc_active_subset_name
 		cb_add.default = true
 	Else
 		setfocus(sle_link_id)
 		setmicrohelp(w_main,'No Subset ID Returned from List Subset; Please Enter')		
 	End If
Else
	gv_from = 'U'									//NLG 6-25-98 Track #1326
	//	01/29/02	GaryR	Track 2552d
	If left(ddlb_link_type.text,3) = 'PDQ' OR left(ddlb_link_type.text,3) = 'PDR' then
		//	Clear the query engine parms from previous attempts
		inv_queryengine.uf_clear_query_parms()
		//	'USE' is passed as the query ID to query engine
		inv_queryengine.uf_set_query_id('USE')
		// Set the appropriate Query Engine Mode
		//	01/29/02	GaryR	Track 2552d
		inv_queryengine.uf_set_query_engine_mode( Left( ddlb_link_type.text, 3 ) )
		// Open the query engine window
		inv_queryengine.uf_open_query_engine()
		//	Get the query ID set from w_query_engine
		ls_query_id	=	gnv_app.of_get_query_id()
		// If no query was selected, then display a message and get out
		IF	IsNull (ls_query_id)	OR	Trim (ls_query_id)	<	'  '		THEN
			MessageBox ('Warning', 'No query was selected from the query engine window')
			Return
		END IF
		
		ds_sub_opt_case_link = CREATE n_Ds
		ds_sub_opt_case_link.DataObject = 'd_sub_opt_case_link'
		ds_sub_opt_case_link.SetTransObject(stars2ca)
		ds_sub_opt_case_link.of_SetTrim (TRUE)					// FDG 04/16/01
		ls_sql = ds_sub_opt_case_link.GetSqlSelect()
		ls_sql = ls_sql + "WHERE CASE_LINK.LINK_KEY = '" + Upper( ls_query_id ) + "'" + &
		" and CASE_LINK.CASE_ID = 'NONE'" + &
		" and CASE_LINK.LINK_TYPE = '" + Left( ddlb_link_type.text, 3 ) + "'"	//	01/29/02	GaryR	Track 2552d
		ds_sub_opt_case_link.SetSqlSelect(ls_Sql)
		li_orig_row = ds_sub_opt_case_link.Retrieve() 
		if stars2ca.of_check_status() < 0 Then
			//	01/29/02	GaryR	Track 2552d
			MessageBox("Error","Cannot retrieve " + Left( ddlb_link_type.text, 3 ) + " information",StopSign!)
			destroy(ds_sub_opt_case_link)
			return
		end if
		If li_orig_row <> 1 then
			//	01/29/02	GaryR	Track 2552d
			MessageBox("Error","Cannot link, mutiple " + Left( ddlb_link_type.text, 3 ) + "s: " + ls_query_id + " exist",StopSign!)
			destroy(ds_sub_opt_case_link)
			return
		END IF

		//	Display the selected query
		sle_link_id.text	=	ds_sub_opt_case_link.Object.Link_name[li_orig_row]
		ib_query_id	=	ds_sub_opt_case_link.Object.Link_key[li_orig_row]
		ib_query_name	=	ds_sub_opt_case_link.Object.Link_name[li_orig_row]
		ib_query_case = ds_sub_opt_case_link.Object.case_id[li_orig_row] + ds_sub_opt_case_link.Object.case_spl[li_orig_row] + ds_sub_opt_case_link.Object.case_ver[li_orig_row]
		destroy(ds_sub_opt_case_link)
		ib_look_up_link_id = true
		w_case_folder_view_uo.uo_1.pb_4.enabled = true  //View button	//ajs 02/05/98
	ElseIf	left(ddlb_link_type.text,3) = 'PAT'		then	
		// Perform a pattern lookup
		Parent.wf_lookup_pattern()
	Elseif left(ddlb_link_type.text,3) = 'ATT'	then
		IF GetFileOpenName("Select File", ls_path, ls_name ) = 1 THEN
			sle_link_id.text = ls_path
		END IF
	End IF
End IF
end event

event getfocus;call super::getfocus;cb_add.default = true
end event

type cb_details from u_cb within w_case_folder_view
string accessiblename = "Details..."
string accessibledescription = "Details..."
integer x = 2373
integer y = 1952
integer width = 238
integer height = 100
integer taborder = 90
boolean enabled = false
string text = "Details..."
end type

event clicked;call super::clicked;//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	10/30/06	GaryR	Track 3153	Minor changes to reflect the finalized requirements

CHOOSE CASE in_link_type
	CASE 'SUB', 'ARC'
		open(w_subset_control_display)
	CASE 'PAT'
		Parent.wf_criteria_pattern()
	CASE 'ATT'
		OpenWithParm( w_attach_details, in_link_id + is_case_key )
END CHOOSE
end event

type sle_bus_desc from singlelineedit within w_case_folder_view
string tag = "protect"
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 1111
integer y = 204
integer width = 878
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_type_desc from singlelineedit within w_case_folder_view
string tag = "protect"
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 279
integer y = 204
integer width = 471
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_cat_desc from singlelineedit within w_case_folder_view
string tag = "protect"
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 1111
integer y = 88
integer width = 878
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type cb_save from commandbutton within w_case_folder_view
string accessiblename = "Save"
string accessibledescription = "Save"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2121
integer y = 1952
integer width = 238
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Save"
end type

event clicked;// Save the changes
Parent.Event ue_save()
end event

type p_notes from u_pb within w_case_folder_view
boolean visible = false
string accessiblename = "Notes"
string accessibledescription = "Notes"
integer x = 251
integer y = 1940
integer width = 155
integer height = 108
integer taborder = 50
string picturename = "script1.bmp"
boolean map3dcolors = true
end type

event clicked;w_master	lw_parent
Integer			li_rc
li_rc = 	This.of_GetParentWindow(lw_parent)
lw_parent.dynamic event ue_notes()
end event

type cb_add from commandbutton within w_case_folder_view
string accessiblename = "Add"
string accessibledescription = "Add"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2830
integer y = 84
integer width = 238
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Add"
end type

event clicked;//*******************************************************************
//	Script: cb_add.clicked
//
//	Description:
//		Add entered link type and link id to case link table
//*******************************************************************
//	History
// AJS   10/14/98 Stars 4.0 track #1924 Add back logic for LTR & POL
// AJS   07/13/98 Stars 4.0 Revamp entire add logic.
// NLG	06/16/98	track #1327 - only allow independent subsets to be linked
//	NLG	06/03/98 Stars 4.0 - when adding independent ss/pdq, bring
//										along any attached notes
// AJS   06/01/98 Stars 4.0 - Correct extra insert of case link table
// AJS   01/20/98 Stars 4.0 - Remove logic for CRI
//	FDG	01/13/98	Stars 4.0 - For query engine processing (link type
//						= 'PDQ' (Predefined Query), open w_query_engine
//						so the user can select a query to add to the case
//						link.
// AJS 	10/06/99 TS2443 - Rls 4.5 Enhanced notes
//	NLG	10/13/99 Replace dw retrieve with embedded sql for enhanced notes
//						If note > 32K, cannot retrieve into datawindow
//	FDG	02/25/00	Stars 4.5 - Allow for patterns
// GaryR	11/01/00	2920c	Standardize windows colors
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	FDG	09/20/01	Stars 4.8.1.	Create case_log.
//	GaryR	01/29/02	Track 2552d	Predefined Report (PDR)
//	GaryR	07/30/02	Track 3219d	Prevent targets on ancillary subsets
//	GaryR	08/07/02	Track	3241d	Do not add case log for targets here
//	GaryR	09/04/02	Track 3273d	Prevent saving duplicate link names
// Jason	10/17/02 Track 2883d Populate stucture with note_desc
//	GaryR	01/24/03	Track 3212d	Display user friendly error
//	GaryR	02/07/03	Track 3273d	Prevent saving duplicate link names
// Katie 08/16/05 Track 4449d Prevented Target from being added for custom case types.
//	GaryR	08/16/05	Track 4361d	Add log entry for new notes
// Katie 10/07/05 Track 4544d Allowed users to add Targets to custom case types if specifically
//										a target was being added and not a subset.
// Katie 10/11/05 Track 4551d Added BE to Target logic statements.
//	GaryR	08/14/06	Track 4708	Keep original link type on archive links
//	GaryR	10/16/06	Track 3153	Add external file attachment facility to Case
//	GaryR	10/30/06	Track 3153	Minor changes to reflect the finalized requirements
//	GaryR	04/25/07	Track 4997	Convert LongLong to Decimal due to PB bug
// GaryR	05/23/07	Track 5037	Added CASEFOLDER component check when replacing attachment
// Katie	08/03/07	Track 5037	Changed error message for modifying/deleting attachment when 
//										case security does not permit it.
//	GaryR	04/22/08	SPR 5103	Resolve dup providers and centralize logic
//
//*******************************************************************

char lv_arc_ind
datetime ldte_current_datetime
string ls_active_case_id,ls_active_case_spl,ls_active_case_ver, ls_active_case_type
String ls_link_type, ls_tmp, ls_message, ls_user_id, ls_attach_user, ls_case_owner
String ls_subset_type, ls_sql
string ls_link_name, ls_link_key, ls_link_case_id, ls_link_desc	//ajs 01/20/98 
integer lv_return, li_rc, li_rows, li_orig_row, li_row
long ll_row, ll_count

String	ls_path, ls_filename, ls_ext
Decimal	ldec_maxMB, ldec_FileSize, ldec_MaxFileSize
n_ds ds_sub_opt_case_link
n_cst_attachments	lnv_att

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

setfocus(ddlb_link_type)
Cb_add.default = true

//Edits on different case types
If sle_category.text = 'REF' then
	messagebox ('EDIT','Cannot Link for this Case Category')
	cb_close.default = true
   Return
End IF

ls_link_type = left(trim(ddlb_link_type.text),3)
If ls_link_type  = ''  then
	messagebox ('EDIT','Select Link Type ')
   Return
End IF

ls_tmp = ls_link_type

If sle_category.text = 'CA?' then
	If ls_link_type = 'TGT' or ls_link_type = 'SUB' then
		messagebox ('EDIT','Cannot Link Targets to a Potential Case')
		cb_close.default = true
	   Return	
	End If
End IF

//Check that user entered a value to link
If sle_link_id.text = ''  then
	messagebox ('EDIT','Enter Link Id ')
	setfocus(sle_link_id)
   Return
End IF

//Get the current date/time & active case info
ldte_current_datetime = gnv_app.of_get_server_date_time()

ls_active_case_id  = left(sle_case_id.text,10)
ls_active_case_spl = mid(sle_case_id.text,11,2)
ls_active_case_ver = mid(sle_case_id.text,13,2)
ls_active_case_type = left(sle_type_desc.text,2)
ls_link_name  = sle_link_id.text	
ls_link_case_id = 'NONE'

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_active_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_active_case_ver)
// FDG 04/16/01 - end

//Process Target
If ls_link_type = 'TGT' then
		//check id record already exists in case
		Select count(*) into :lv_return
			from target_cntl
			where case_id  = Upper( :ls_active_case_id ) and
					case_spl = Upper( :ls_active_case_spl ) and
					case_ver = Upper( :ls_active_case_ver ) and
					trgt_id = Upper( :ls_link_name )
 			Using stars2ca;
		If stars2ca.of_check_status() < 0 then
			Messagebox('Error','Error Reading Target Control File')
			Return
		ElseIf lv_return > 0 then
			Stars2ca.of_rollback()
			setfocus(sle_link_id)
			cb_add.default = true
			Messagebox('EDIT','Target Id already exists in case')
			RETURN
		End If
		
		//Insert target into case_link done by target window.
		ls_link_key = ls_link_name
		ls_link_desc = 'Target added on ' + string(ldte_current_datetime)
End If
	
If ls_link_type = 'POL' or ls_link_type = 'LTR' then
	
	//Check if link id already linked to the case 
	Select count(*) into :ll_count							
	from Case_link													
	where case_id  = Upper( :ls_active_case_id ) and				
			case_spl = Upper( :ls_active_case_spl ) and				
			case_ver = Upper( :ls_active_case_ver ) and				
			link_type = Upper( :ls_link_type ) and						
			link_name = Upper( :ls_link_name )				
	Using Stars2ca;												
																			
	If stars2ca.of_check_status() <> 0 then
			Messagebox('Error','Error Reading Case Link')
			RETURN
	ElseIf ll_count > 0 then
			Stars2ca.of_rollback()
			setfocus(sle_link_id)
			cb_add.default = true
			Messagebox('EDIT','Record Already Exists in Case.')
			RETURN
	End If
	lv_return = 	&
	Messagebox('EDIT','Unable to Verify Existence, Proceed',Question!,YesNo!)
	If lv_return = 2 then
		//	sqlcmd('DISCONNECT',stars2ca,"Error DISconnecting from stars2",2)    PLB  10/18/95
		COMMIT using STARS2CA;
		If stars2ca.sqlcode <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2 - cb_add(8)')
			Return
		End If	
		setmicrohelp(w_main,'Link Cancelled')
		RETURN
	End If
	
	ds_sub_opt_case_link = CREATE n_Ds
	ds_sub_opt_case_link.DataObject = 'd_sub_opt_case_link'
	ds_sub_opt_case_link.SetTransObject(stars2ca)
	ds_sub_opt_case_link.of_SetTrim(TRUE)						// FDG 04/16/01
	li_row = ds_sub_opt_case_link.InsertRow(0)
	ds_sub_opt_case_link.Object.Case_id[li_row] = ls_active_case_id
	ds_sub_opt_case_link.Object.Case_spl[li_row] = ls_active_case_spl
	ds_sub_opt_case_link.Object.Case_ver[li_row] = ls_active_case_ver
	ds_sub_opt_case_link.Object.Link_type[li_row] = ls_link_type
	ds_sub_opt_case_link.Object.Link_key[li_row] = ls_link_name
	ds_sub_opt_case_link.Object.Link_name[li_row] = ls_link_name
	ds_sub_opt_case_link.Object.Link_desc[li_row] = ls_link_type + ' ' + ls_link_name + ' added through case folder window'
	ds_sub_opt_case_link.Object.User_id[li_row] = gc_user_id
	ds_sub_opt_case_link.Object.link_date[li_row] = ldte_current_datetime
	ds_sub_opt_case_link.Object.Link_status[li_row] = 'A'
	
	ds_sub_opt_case_link.EVENT ue_update( TRUE, TRUE )
	
	if stars2ca.of_check_status() <> 0 then
			messagebox('ERROR','Error linking to active case')
			destroy(ds_sub_opt_case_link)
			return 
	else
			stars2ca.of_commit()
			destroy(ds_sub_opt_case_link)
	end if
	
End If

// FDG 02/25/00 - Include patterns
//	GaryR	01/29/02	Track 2552d
If ls_link_type = 'PDQ' or ls_link_type = 'PDR' or ls_link_type = 'SUB' or ls_link_type = 'PAT' then
	
	CHOOSE CASE ls_link_type
		CASE "SUB"
			ls_link_desc = "Subset"
		CASE "PAT"
			ls_link_desc = "Pattern"
		CASE ELSE
			ls_link_desc = ls_link_type
	END CHOOSE
		
		SELECT	count(*)
		INTO 		:ll_count
		FROM 		case_link
		WHERE 	link_type = Upper( :ls_link_type )
		AND		link_name   = Upper( :ls_link_name )
		USING		stars2ca;
		
		IF stars2ca.of_check_status() <> 0 OR ll_count = 0 THEN
			Messagebox( "Error", "Invalid " + ls_link_desc + &
						" ID. Right mouse click to select a valid ID from the list.", Exclamation! )
			Return
		End If
		
		//	Check if link already linked to 
		//	current case under the same name
		SELECT	count(*)
		INTO	 	:ll_count
		FROM		case_link
		WHERE		case_id		= Upper( :ls_active_case_id )
		AND		case_spl		= Upper( :ls_active_case_spl )
		AND		case_ver		= Upper( :ls_active_case_ver )
		AND		link_type	= Upper( :ls_link_type )
		AND		link_name	= Upper( :ls_link_name	)
		USING		Stars2ca;
		
		IF stars2ca.of_check_status() < 0 THEN
			MessageBox( "Add Link", "Error reading CASE_LINK table" )
			Return
		ELSEIF ll_count > 0 THEN
			setfocus(sle_link_id)
			cb_add.default = true
			Messagebox( "Add Link", "Link name (" + ls_link_name + &
														") already exists in Case.", Exclamation! )
			Return
		END IF
		
		//Get Link Id for Link Name entered
		Select link_key into :ls_link_key						//ajs 01-21-98
		from Case_link													//ajs 01-21-98
		where case_id  = Upper( :ls_link_case_id ) and					//ajs 01-21-98
				link_type = Upper( :ls_link_type ) and						//ajs 01-21-98
				link_name   = Upper( :ls_link_name )					//ajs 01-21-98
		Using Stars2ca;												//ajs 01-21-98
																			//ajs 01-21-98
		If stars2ca.of_check_status() < 0 then
			Messagebox('Error','Error Reading Case Link to get internal id')
			RETURN
		ELSEIF stars2ca.of_check_status() = 100 THEN
			CHOOSE CASE ls_link_type
				CASE "SUB"
					Messagebox( "Error", "This " + ls_link_desc + &
								" is already linked to a case.~n~rTo link it to another case go to the " + &
								ls_link_desc + " Details window and click the SAVE AS button.", Exclamation! )
				CASE ELSE
					Messagebox( "Error", "This " + ls_link_desc + &
								" is already linked to a case.~n~rTo link it to another case go to the " + &
								ls_link_desc + " Criteria Tab and select SAVE AS from the right Mouse Menu.", Exclamation! )
			END CHOOSE			
			Return
		End If

		//SUBSET ONLY logic
		If ls_link_type = 'SUB' then
			
			//Do not allow linking of temporary subsets
			If left(ls_link_key,2) = 'TS' then
				If stars2ca.of_commit() < 0 Then
					Messagebox('Error','Error Commiting to Stars2 cb_add(2)')
					Return
				End If	
				Messagebox('EDIT','Cannot Link a Temporary Subset')
				RETURN
			End If
		

			//archive indicator for case folder
			//and get the type for the case folder datawindow
			Select subc_sub_tbl_type, subc_arc_ind into :ls_subset_type, :lv_arc_ind
				from Sub_cntl
				where subc_id = Upper( :ls_link_key )
				Using stars2ca;
			If stars2ca.of_check_status() = 100  then
				Messagebox('EDIT','Subset Does Not Exist')
				setmicrohelp(w_main,'Link Cancelled')
				stars2ca.of_commit()
				RETURN
			Elseif stars2ca.of_check_status() < 0 then	
				Messagebox('Error','Error Reading Subset Control File')
				stars2ca.of_commit()
				RETURN
			Else
				stars2ca.of_commit()	
				if lv_arc_ind = 'A' then  // subset from archive restoral
					if (messagebox("ARCHIVE SUBSET WARNING","The subset selected consists of restored claims.  " + &
									"If you continue the subset will be linked with link type ARC.  " + &
									"Are you sure you wish to link this subset?",Question!,YesNo!,2)) <> 1 then
						return
					else
						ls_link_type = "ARC"
					end if
				end if
			End If
		End If 
		//SUBSET ONLY Logic end
	
	ds_sub_opt_case_link = CREATE n_Ds
	ds_sub_opt_case_link.DataObject = 'd_sub_opt_case_link'
	ds_sub_opt_case_link.SetTransObject(stars2ca)
	ds_sub_opt_case_link.of_SetTrim(TRUE)						// FDG 04/16/01

	//Get Old record Information
	ls_sql = ds_sub_opt_case_link.GetSqlSelect()
	ls_sql = ls_sql + "WHERE CASE_LINK.LINK_NAME = '" + Upper( ls_link_name ) + &
			"' and CASE_LINK.LINK_TYPE = '" + Upper( ls_tmp ) + "'" +&
			" and CASE_LINK.CASE_ID = '" + Upper( ls_link_case_id ) + "'" 
	ds_sub_opt_case_link.SetSqlSelect(ls_Sql)
	li_orig_row = ds_sub_opt_case_link.Retrieve() 
	
	if stars2ca.of_check_status() < 0 Then
		MessageBox("Error","Cannot retrieve " + ls_link_name + " case link information",StopSign!)
		destroy(ds_sub_opt_case_link)
		return
	end if

 	If li_orig_row <> 1 then	
		MessageBox("Error","Cannot link. Mutiple ids named: " + ls_link_name + " exist",StopSign!)
		destroy(ds_sub_opt_case_link)
		return
	END IF
 
	//Add new record linked to case for SUBSETS, replace "NONE" case_link record for PDQs and Patterns
	If ls_link_type = 'SUB' or ls_link_type = 'ARC' then
		li_row = ds_sub_opt_case_link.InsertRow(0)
	else
		li_row = li_orig_row
	End If
	
	ds_sub_opt_case_link.Object.Case_id[li_row] = ls_active_case_id
	ds_sub_opt_case_link.Object.Case_spl[li_row] = ls_active_case_spl
	ds_sub_opt_case_link.Object.Case_ver[li_row] = ls_active_case_ver
	ds_sub_opt_case_link.Object.Link_type[li_row] = ds_sub_opt_case_link.Object.Link_type[li_orig_row]
	ds_sub_opt_case_link.Object.Link_key[li_row] = ds_sub_opt_case_link.Object.Link_key[li_orig_row]
	ds_sub_opt_case_link.Object.Link_name[li_row] = ds_sub_opt_case_link.Object.Link_name[li_orig_row]
	ds_sub_opt_case_link.Object.Link_desc[li_row] = ds_sub_opt_case_link.Object.Link_desc[li_orig_row]
	ds_sub_opt_case_link.Object.User_id[li_row] = gc_user_id
	ds_sub_opt_case_link.Object.link_date[li_row] = ldte_current_datetime
	ds_sub_opt_case_link.Object.Link_status[li_row] = ds_sub_opt_case_link.Object.Link_status[li_orig_row]
	

	ds_sub_opt_case_link.EVENT ue_update( TRUE, TRUE )
	
	if stars2ca.of_check_status() <> 0 then
			messagebox('ERROR','Error linking to active case')
			destroy(ds_sub_opt_case_link)
			return 
	else
			stars2ca.of_commit()
			destroy(ds_sub_opt_case_link)
	end if

	//Add notes to case for this Independent PDQ or subset
	string ls_rel_type, ls_rel_id, ls_sub_type
	long ll_rows, ll_row_num

	if ls_link_type = 'SUB' or ls_link_type = 'ARC' then 
		ls_rel_type = 'SS'
		ls_sub_type = 'SB'
	elseif ls_link_type = 'PAT'	THEN		// FDG 02/25/00
		ls_rel_type = 'PA'
		ls_sub_type = 'PA'
	else
		ls_rel_type = 'PQ'
		ls_sub_type = 'PQ'
	end if
	ls_rel_id = ls_link_name

	n_cst_notes lnvo_notes
	n_ds ds_notes
	ds_notes = CREATE n_Ds
	ds_notes.DataObject = 'd_notes'
	li_rc = ds_notes.SetTransObject(stars2ca)
	if li_rc <> 1 then
		messagebox("ERROR","Error checking for attached Notes.")
	else
		ll_rows = ds_notes.Retrieve(ls_rel_type, ls_rel_id) 
		if ll_rows < 0 Then
			MessageBox("Error","Error checking for notes attached to " + sle_link_id.text,StopSign!)
			if isValid(ds_notes) then destroy(ds_notes)
		else
			//if notes exist for PDQ/SS, copy rows to this case, changing rel_type to CA
			if ll_rows > 0 then
				for ll_row_num = 1 to ll_rows
					lnvo_notes.is_notes_id = fx_get_next_key_id('NOTE')
					lnvo_notes.is_user_id = ds_notes.GetItemString(ll_row_num, 'user_id')
					lnvo_notes.is_dept_id = ds_notes.GetItemString(ll_row_num, 'dept_id')
					lnvo_notes.is_notes_rel_type = 'CA'
					lnvo_notes.is_notes_rel_id = sle_case_id.text
					lnvo_notes.is_notes_sub_type = ls_sub_type
					lnvo_notes.idt_datetime = ds_notes.GetItemDateTime(ll_row_num,'note_datetime')
					lnvo_notes.is_rte_ind = ds_notes.getItemString(ll_row_num,'rte_ind')
					lnvo_notes.is_old_note_id = ds_notes.GetItemString(ll_row_num, 'note_id')
					lnvo_notes.is_old_rel_type = ds_notes.GetItemString(ll_row_num, 'note_rel_type')
					lnvo_notes.is_old_rel_id = ds_notes.GetItemString(ll_row_num, 'note_rel_id')
					// JasonS 10/17/02 Begin - Track 2883d
					lnvo_notes.is_notes_desc = ds_notes.GetItemString(ll_row_num, 'note_desc')					
					// JasonS 10/17/02 Begin - Track 2883d					
					li_rc = lnvo_notes.uf_copy_note()
					if li_rc <> 1 then
						messagebox('NOTES','Error copying notes')
					end if
				next

				if li_rc <> 1 then
					ErrorBox(Stars2ca,'Error copying attached Notes.')
				end if			
			end if //ll_rows > 0
		end if //ll_rows < 0
	end if //li_rc <> 1
	
	if isValid(ds_notes) then destroy(ds_notes)
	setmicrohelp(w_main,'Link Added')
End If

//	Process Attachments
IF ls_link_type = "ATT" THEN
	ls_path = Trim( ls_link_name )
	
	// Validate the file & path
	IF NOT FileExists( ls_path ) THEN
		MessageBox( "Attachment Error", "File " + ls_path + " does not exist!" + &
							"~n~rPlease verify the supplied file path and name.", StopSign! )
		Return
	END IF
	
	// Get max and file sizes
	ldec_MaxFileSize = lnv_att.of_getmaxfilesize()
	ldec_FileSize = FileLength64( ls_path )
	
	// Check empty file
	IF ldec_FileSize < 1 THEN
		MessageBox( "Attachment Error", "The file you are attempting to attach contains no data.", StopSign! )
		Return
	END IF
	
	// Check file size restriction
	IF ldec_MaxFileSize > 0 THEN
		IF ldec_FileSize > ldec_MaxFileSize THEN
			// Compute max MB
			ldec_maxMB = ldec_MaxFileSize / 1048576
			MessageBox( "Attachment Error", "The file you are attempting to attach" + &
										" is larger then your defined system limit of " + &
										String( ldec_maxMB, "##,##0.00" ) + " MB~n~r" + &
										"Please contact your System Administrator to " + &
										"request an increase to the limit on attachments.", StopSign! )
			Return
		END IF
	END IF
	
	//	Parse the file path
	IF lnv_att.of_parse_filename( ls_path, ls_filename, ls_ext ) <> 1 THEN
		MessageBox( "Attachment Error", "Error parsing the file path." )
		Return
	END IF
	
	// Check file name length
	IF Len( ls_filename + "." + ls_ext ) > 80 THEN
		MessageBox( "Attachment Error", "Filename and extension cannot exceed 80 characters." + &
						"~n~rPlease rename the file and try again." )
		Return
	END IF
	
	// Check if File Name already exists for this Case
	SELECT cl.link_key, cl.link_name, cl.user_id, fc.attach_user_id
	INTO :ls_link_key, :ls_link_name, :ls_user_id, :ls_attach_user
	FROM case_link cl, file_cntl fc
	WHERE cl.link_key = fc.file_id
	AND	cl.case_id	= Upper( :ls_active_case_id )
	AND	cl.case_spl	= Upper( :ls_active_case_spl )
	AND	cl.case_ver	= Upper( :ls_active_case_ver )
	AND	cl.link_type= Upper( :ls_link_type )
	AND	fc.file_name= Upper( :ls_filename )
	AND	fc.file_type= Upper( :ls_ext )
	USING	Stars2ca;
		
	IF stars2ca.of_check_status() < 0 THEN
		MessageBox( "Attachment Error", "Error reading CASE_LINK and FILE_CNTL tables" )
		Return
	END IF
	
	// release locks
	Stars2ca.of_commit()
	
	// If file exists then ask to replace existing, else add new.
	IF NOT IsNull( ls_link_key ) AND Trim( ls_link_key ) <> "" THEN
		// First check for sufficient security
		IF is_comp_upd_status = 'AO' THEN
			MessageBox( "Attachment", "File name " + ls_filename + "." + ls_ext + &
								" already exists in current Case.~n~rYou cannot replace " + &
								"this attachment because at your~n~rsite the security" + &
								" for Case Folder permits you to only~n~radd new attachments. " +&
								"Modifying or deleting existing~n~rfiles is not permitted.", StopSign! )
								

			Return
		END IF
		
		//	Select Case Owner
		SELECT CASE_ASGN_ID
		INTO :ls_case_owner
		FROM CASE_CNTL
		WHERE case_id	= Upper( :ls_active_case_id )
		AND	case_spl	= Upper( :ls_active_case_spl )
		AND	case_ver	= Upper( :ls_active_case_ver )
		Using Stars2ca;
		
		IF stars2ca.of_check_status() < 0 THEN
			MessageBox( "Attachment Error", "Error reading CASE_CNTL table" )
			Return
		END IF
		
		// release locks
		Stars2ca.of_commit()
	
		// Next check if the dup file is assigned to or attached
		//	by the current user or user is case owner or client admin
		IF ls_user_id <> gc_user_id AND &
			ls_attach_user <> gc_user_id AND &
			ls_case_owner <> gc_user_id AND &
			gv_user_sl <> "AD" THEN
			MessageBox( "Attachment", "File name " + ls_filename + "." + ls_ext + &
								" already exists in current Case.~n~rYou cannot replace " + &
								"this file because it is currently assigned to user: " + &
								ls_user_id, StopSign! )
			Return
		END IF
		
		IF Messagebox( "Attachment", "File name " + ls_filename + "." + ls_ext + " already exists in current Case." + &
			"~n~rWould you like to replace the existing file with the specified file?", Exclamation!, YesNoCancel! ) <> 1 THEN Return
		
		// Update CASE_LINK
		UPDATE CASE_LINK
		SET user_id = :gc_user_id,
			link_date = :ldte_current_datetime
		WHERE case_id	= Upper( :ls_active_case_id )
		AND	case_spl	= Upper( :ls_active_case_spl )
		AND	case_ver	= Upper( :ls_active_case_ver )
		AND	link_type= Upper( :ls_link_type )
		AND	link_key = :ls_link_key
		USING	Stars2ca;
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox(  "Attachment Error", "Error updating CASE_LINK:~n~r" + Stars2ca.sqlerrtext )
			Stars2ca.of_rollback()
			Return
		END IF
		
		// Update FILE_CNTL
		IF lnv_att.of_update_cntl( ls_link_key, ldec_FileSize ) <> 1 THEN
			Stars2ca.of_rollback()
			Return
		END IF
		
		// Replace the file
		IF lnv_att.of_insertfile( ls_link_key, ls_path ) <> 1 THEN
			Stars2ca.of_rollback()
			Return
		END IF
		
		// Mass commit
		IF Stars2ca.of_commit() <> 0 THEN
			Stars2ca.of_rollback()
			Return
		END IF
		
		lnv_att.of_ask_delete_file( ls_path )
		ls_message = "Attachment " + ls_filename + "." + ls_ext + " ("	+	ls_link_name	+	") replaced."
	ELSE
		// insert CASE_LINK
		ls_link_key = fx_get_next_key_id("RSTR")
		ls_link_name = ls_link_key

		IF IsValid( ds_sub_opt_case_link ) THEN Destroy ds_sub_opt_case_link
		ds_sub_opt_case_link = CREATE n_Ds
		ds_sub_opt_case_link.DataObject = 'd_sub_opt_case_link'
		ds_sub_opt_case_link.SetTransObject(stars2ca)
		ds_sub_opt_case_link.of_SetTrim(TRUE)
		li_row = ds_sub_opt_case_link.InsertRow(0)
		ds_sub_opt_case_link.Object.Case_id[li_row] = ls_active_case_id
		ds_sub_opt_case_link.Object.Case_spl[li_row] = ls_active_case_spl
		ds_sub_opt_case_link.Object.Case_ver[li_row] = ls_active_case_ver
		ds_sub_opt_case_link.Object.Link_type[li_row] = ls_link_type
		ds_sub_opt_case_link.Object.Link_key[li_row] = ls_link_key
		ds_sub_opt_case_link.Object.Link_name[li_row] = ls_link_name
		ds_sub_opt_case_link.Object.Link_desc[li_row] = ls_filename + "." + ls_ext
		ds_sub_opt_case_link.Object.User_id[li_row] = gc_user_id
		ds_sub_opt_case_link.Object.link_date[li_row] = ldte_current_datetime
		ds_sub_opt_case_link.Object.Link_status[li_row] = 'A'

		// Update CASE_LINK
		ds_sub_opt_case_link.EVENT ue_update( TRUE, TRUE )
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "Attachment Error", "Error inserting into CASE_LINK:~n~r" + Stars2ca.sqlerrtext )
			Stars2ca.of_rollback()
			Destroy ds_sub_opt_case_link
			Return 
		END IF
		
		Destroy ds_sub_opt_case_link
		
		// Update FILE_CNTL
		IF lnv_att.of_insert_cntl( ls_link_key, ls_filename, ls_ext, &
							ldec_FileSize, gc_user_id, ldte_current_datetime ) <> 1 THEN
			Stars2ca.of_rollback()
			Return
		END IF
		
		//	Insert the file contents
		IF lnv_att.of_insertfile( ls_link_key, ls_path ) <> 1 THEN
			Stars2ca.of_rollback()
			Return
		END IF
		
		// Mass commit
		IF Stars2ca.of_commit() <> 0 THEN
			Stars2ca.of_rollback()
			Return
		END IF
		
		lnv_att.of_ask_delete_file( ls_path )
		ls_message = "Attachment " + ls_filename + "." + ls_ext + " ("	+	ls_link_name	+	") added."
	END IF
ELSE
	//Increment count on Screen
	st_row_count.text = String(Integer(st_row_count.text) + 1)
	
	//Add New Case Link Info to a row in the DW
	Insertrow(dw_1,integer(st_row_count.text))
	Setitem(dw_1,integer(st_row_count.text),1,ls_link_type)
	Setitem(dw_1,integer(st_row_count.text),2,ls_link_name)		//ajs 01-21-98
	Setitem(dw_1,integer(st_row_count.text),7,ls_link_key)		//ajs 01-21-98
	
	If ls_link_type = 'SUB' or ls_link_type =  'ARC'  THEN		//PAT-D ADDED TO SHOW SUBSET TABLE TYPE
		Setitem(dw_1,integer(st_row_count.text),6,ls_subset_type)
	END if
	
	ls_message	=	"Link "	+	ls_link_name	+	" ("	+	ls_link_type	+	") added."
END IF

// FDG 09/20/01 - Add case_log
//	GaryR	08/07/02	Track	3241d
IF ls_link_type <> "TGT" THEN	li_rc	=	inv_case.uf_audit_log (gv_active_case, ls_message)
// FDG 09/20/01 end

//Set instance variables 
in_link_id   = ls_link_key
in_link_type = ls_link_type
ls_link_key = ''
selectitem(ddlb_link_type,0)
st_link_id.text = "ID:"
sle_link_id.text = ''
setfocus(dw_1)
selectrow(dw_1,0,false)
selectrow(dw_1,integer(st_row_count.text),true)
setrow(dw_1,integer(st_row_count.text))

//HRB 12/13/94 used to determine if there are subsets for random sampling
in_rand_samp = TRUE
triggerevent(dw_1,rowfocuschanged!)

cb_remove.enabled = true

If ((ls_link_type = 'SUB'  or ls_link_type = 'ARC' or ls_link_type = 'TGT') AND &
	sle_category.text <> 'CA?')  then
	//GaryR	11/01/2000	2920c begin
	sle_link_id.backcolor  = stars_colors.input_back 
	sle_link_id.textcolor  = stars_colors.input_text
	//sle_link_id.backcolor = rgb(0,128,128)
	//GaryR	11/01/2000	2920c	end
	
	//	GaryR	07/30/02	Track 3219d - Begin
	//	Check if subset is ancillary type
	IF ls_link_type = 'SUB' THEN
		w_main.dw_stars_rel_dict.SetFilter( "" )
		w_main.dw_stars_rel_dict.Filter()
		w_main.dw_stars_rel_dict.SetFilter( "rel_type = 'AN' and id_2 = '"	+	ls_subset_type	+	"'" )
		w_main.dw_stars_rel_dict.Filter()
		ll_count	=	w_main.dw_stars_rel_dict.RowCount()
		IF	((ll_count < 1) AND ((ls_active_case_type = 'PV') OR (ls_active_case_type = 'RV') OR (ls_active_case_type = 'PC') OR (ls_active_case_type = 'EN') OR (ls_active_case_type = 'BE'))) THEN wf_target ()	// Only perform this for claims subsets
	ELSE
		IF	((ls_active_case_type = 'PV') OR (ls_active_case_type = 'RV') OR (ls_active_case_type = 'PC') OR (ls_active_case_type = 'EN') OR (ls_active_case_type = 'BE') OR (ls_link_type = 'TGT')) THEN wf_target ()
	END IF
	//	GaryR	07/30/02	Track 3219d - End
End If
if (w_case_folder_view_uo.uo_1.pb_1.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_2.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_3.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_4.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_5.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_6.enabled = false ) then
  cb_more.enabled = false
else
  cb_more.enabled = true
end if  

w_case_folder_view.Event Open()
end event

type cb_more from commandbutton within w_case_folder_view
string accessiblename = "More..."
string accessibledescription = "More..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2624
integer y = 1952
integer width = 238
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&More..."
end type

on clicked;parent.triggerevent (rbuttondown!)
this.default = false
end on

type sle_business from singlelineedit within w_case_folder_view
string tag = "protect"
boolean visible = false
string accessiblename = "Business"
string accessibledescription = "Business"
accessiblerole accessiblerole = textrole!
integer x = 613
integer y = 1964
integer width = 101
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_4 from statictext within w_case_folder_view
string accessiblename = "Business"
string accessibledescription = "Business"
accessiblerole accessiblerole = statictextrole!
integer x = 795
integer y = 204
integer width = 297
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Business:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_refresh from commandbutton within w_case_folder_view
string accessiblename = "Refresh"
string accessibledescription = "Refresh"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1870
integer y = 1952
integer width = 238
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "Re&fresh"
end type

event clicked;w_case_folder_view.TriggerEvent(open!)

end event

type cb_stop from commandbutton within w_case_folder_view
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 421
integer y = 1940
integer width = 78
integer height = 108
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
boolean enabled = false
string text = "&Stop"
end type

type sle_category from singlelineedit within w_case_folder_view
string tag = "PROTECT"
boolean visible = false
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 1964
integer width = 101
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
integer limit = 14
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_case_folder_view
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = statictextrole!
integer x = 805
integer y = 88
integer width = 283
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Category:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_row_count from statictext within w_case_folder_view
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1952
integer width = 206
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_case_folder_view
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2875
integer y = 1952
integer width = 238
integer height = 100
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Close"
boolean default = true
end type

event clicked;close(parent)



end event

type sle_track_type from singlelineedit within w_case_folder_view
string tag = "protect"
boolean visible = false
string accessiblename = "Type"
string accessibledescription = "Type"
accessiblerole accessiblerole = textrole!
integer x = 718
integer y = 1964
integer width = 101
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type cb_remove from commandbutton within w_case_folder_view
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1618
integer y = 1952
integer width = 238
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Delete"
end type

event clicked;//Script for w_case_folder - remove link
//*******************************************************************
//	GaryR	01/29/02	Track 2552d	Predefined Report (PDR)
//	FDG	09/20/01	Stars 4.8.1.	Add case_log
//	GaryR	06/07/01	Stars 4.7	Do not delete case_link row for Patterns and PDQ's.
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
// FNC	03/19/99 TS2199C. Correct logic to delete targets
// FNC	12/1/98	Track 2006. Set delete indicator on bg_rpt_cntl = 'Y'
//						when deleting background pattern reports that have not 
//						been viewed.
// ajs   03/04/98 ajs 4.0 TS145 - fix globals
// FNC	11/12/96	FS118 add RDM as a report type. RDM is created from 
//						w_random_sampling_unique_hics when user checks box for
//					   sampling report. Treat like RPT.
//	FDG	04/04/96	Prob 58 - Remove all references to 'SMP'
// JasonS	6/6/2002	Track 3093 - Deletes not working, when a record is deleted from dw
//											 user needed to click save button for it to be permanent
// 										 we are now calling ue_save automatically for deletes
// JasonS 07/26/02 Track 3093d  made some additional changes
// JasonS 07/31/02 Track 3093d  Re-work flow of script
// JasonS 08/01/02 Track 3225d  Fix RPT, RDM, MED deletes
// JasonS 09/05/02 Track 3226d  Split out SUB and ARC.  Add messagebox for verification
// JasonS 01/07/03 Track 2945d  Check for changed items before deleting
// JasonS 03/20/03 Track 3226d  Fixed check for subset/target deletes
// JasonS 04/01/03 Track 3226d  Moved target check message to nvo_subset_functions
//	GaryR	05/04/04	Track 3544d	Redesign report save/view logic to improve performance
// MikeF	08/29/05	SPR3927d	Create instance variable for Case ID, Split, and version	and 
//									Consolidate subset delete logic.	
//	GaryR	10/16/06	Track 3153	Add external file attachment facility to Case
//*******************************************************************
string 	lv_target_key,lv_delete_target,ls_delete_ind
integer 	lv_message_nbr,li_count,li_rc
String	ls_empty, ls_message, ls_delete_target, ls_object_id
boolean 	lb_refresh_dw = false
int 		li_access
n_cst_report	lnv_report
n_cst_attachments	lnv_att

//  delink highlighted row from case link table
Setpointer(hourglass!)

// JasonS 01/07/03 Begin - Track 2945d
dw_1.accepttext()
if dw_1.modifiedcount() > 0 then
	messagebox("Warning", "You are attempting to delete an item when there are~r~nunsaved changes.  Please save the changes~r~nor refresh before deleting.")
	Return
end if
// JasonS 01/07/03 End - Track 2945d

setmicrohelp(w_main,'Deleting Link')

If integer(st_row_count.text) <= 0 then
	this.enabled = false
	setfocus(ddlb_link_type)
	cb_close.default = true
   Return
End IF


cb_remove.default = true
If in_link_id = ''  then
	messagebox ('EDIT','Select Link Name from Datawindow')
	setfocus(dw_1)
   Return
End IF

If (in_link_type = 'SUB' or in_link_type = 'TGT' or in_link_type = 'ARC') and &
	(sle_category.text = 'REF') then
	Messagebox('EDIT','Cannot remove Targets for this Category')
	setfocus(dw_1)
	RETURN
End If

If in_link_type <> 'SUB' then
	lv_message_nbr = MessageBox ('CONFIRMATION!', &
							'Remove Highlighted Link?',Question!,YesNo!,2)
	Choose Case lv_message_nbr
	Case 2
   	  Return
	End Choose
End If

li_rc	=	gnv_sql.of_TrimData (ls_empty)

// JasonS 07/31/02 Begin - Track 3093d     Reused same code as below, just reworked flow and fixed subset deletes
CHOOSE CASE in_link_type
	CASE 'SUB'
		// Check subset delete access.
		inv_subset_functions.uf_retrieve_datastores() // Placed here to get up-to-date info.
		li_access = inv_subset_functions.uf_get_delete_access(in_link_name, is_case_key, ls_object_id)
		IF li_access > 0 THEN
			MessageBox('Access Denied','Cannot delete the specified subset link.~r~r' + &
							inv_subset_functions.isi_access_msg[li_access] + ls_object_id)
			RETURN
		END IF
		
		// Prompt with Target delete message
		IF inv_subset_functions.uf_target_chk_msg('CASE_FOLDER', is_case_id, is_case_spl, is_case_ver) = 2 THEN
			return
		end if
		
		li_rc = parent.event ue_delete_subset(in_link_id, in_link_name, in_link_type)
		if li_rc = 0 then
			parent.event ue_save()
			GOTO REFRESH_DW
		end if
		
	CASE 'ARC'
		istr_subset_ids.subset_case_id  = is_case_id
		istr_subset_ids.subset_case_spl = is_case_spl
		istr_subset_ids.subset_case_ver = is_case_ver
		istr_subset_ids.subset_id = in_link_id
		istr_subset_ids.subset_name = in_link_name
		inv_subset_functions.uf_set_structure(istr_Subset_ids)
		li_rc = inv_subset_functions.uf_delete_subset()
		if li_rc <> 1 then
			messagebox('Error','Unable to delete subset')
			cb_close.default = true
			return
		end if
		lb_refresh_dw = True
		// Goto refresh, case log entry made within uf_delete_subset above
		GOTO REFRESH_DW
	CASE 'PAT', 'PDQ', 'PDR'
		// Make case_id in case link = NONE  (soft delete)
		UPDATE case_link
			SET case_id = 'NONE',
			case_spl		=	:ls_empty,
			case_ver		=	:ls_empty			
			where Case_id   = Upper( :is_case_id ) and 
					case_spl  = Upper( :is_case_spl ) and 
					case_ver  = Upper( :is_case_ver ) and
					link_type = Upper( :in_link_type ) and
					link_name = Upper( :in_link_name )
		Using stars2ca;
		
		If stars2ca.of_check_status() = 100 then
			// already been deleted, delete row from dw
			cb_close.default = true
			Messagebox('EDIT','Case Link Record Has Already Been Deleted')
			GOTO DELETE_ROW
		Elseif Stars2ca.sqlcode <> 0 then
			cb_close.default = true
			RETURN
		ELSE
			stars2ca.of_commit()
			lb_refresh_dw = True
			GOTO CASE_LOG_ENTRY
		End If	
	CASE 'RPT', 'MED', 'RDM'
		Select delete_ind         
			into :ls_delete_ind
			from bg_rpt_cntl
			where rpt_id = Upper( :in_link_id )
		Using stars2ca;
		
		If stars2ca.of_check_status() <> 0 then
			if stars2ca.of_check_status() <> 100 then
				errorbox(stars2ca,'Error removing report.')
				Return
			else
				/* Report is not a background pattern report */
				Stars2ca.of_commit()
				IF lnv_report.of_delete( in_link_id, in_link_type ) < 0 THEN Return
			end if
		else
			Stars2ca.of_commit()
		End If	
		
		if ls_delete_ind = 'Y' then	
			/* Background Pattern report has been viewed*/
			IF lnv_report.of_delete( in_link_id, in_link_type ) < 0 THEN Return
		else
			/* Report is background pattern that has not be viewed */
			Update bg_rpt_cntl
				Set delete_ind = 'Y'
				Where rpt_id = Upper( :in_link_id )
			Using Stars2ca;
			
			If stars2ca.of_check_status() <> 0 then
				errorbox(stars2ca,'Error setting delete indicator. Reoport not removed')
				Return
			else
				commit using stars2ca;
			End If	
		end if											// FNC 12/1/98 End				
		GOTO DELETE_ROW
		// JasonS 08/01/02 End - Track 3225d
	CASE 'TGT'
		// Delete Target
		Li_rc = Parent.event UE_Delete_Target_Tracks ()
		if li_rc <> 0 then
			messagebox('Error','Unable to delete target')
			cb_close.default = true
			return
		end if
		// DO DB Delete
		GOTO DB_DELETE
	CASE 'CRA'
		li_rc = fw_delete_cra(in_link_id)
		If li_rc = 100 then
			GOTO DELETE_ROW
		ElseIf li_rc = -1 then
			cb_close.default = true
			RETURN
		End IF
		// DO DB Delete
		GOTO DB_DELETE
	CASE 'CRC'
		Select count(*) into :li_rc
			 from Case_link 
			where	link_type = Upper( :in_link_type ) and
					link_key  = Upper( :in_link_id )
		Using stars2ca;
			if Stars2ca.of_check_status() <> 0 then
			 Errorbox(Stars2ca,'Error Reading Case Link Table, Unable to determine if Criteria is used by other cases')
			 cb_close.default = true
			 RETURN
		End If
	//ajs not sure of this, why does crc use cri on criteria tables
		If  li_rc = 0 then		
			Delete from Criteria_Used
				where by_id = Upper( :in_link_id )
				and by_type = 'CRI'
			Using stars2ca;
			If stars2ca.of_check_status() = 100 then
				COMMIT using STARS2CA;
				If stars2ca.of_check_status() <> 0 Then
					errorbox(stars2ca,'Error Commiting to Stars2')
					Return
				End If	
				cb_close.default = true
				Messagebox('EDIT','Criteria Record Has Already Been Deleted')
				Goto Delete_row
			Elseif Stars2ca.sqlcode <> 0 then
					 Errorbox(Stars2ca,'Error Deleting from Criteria Table')
					 cb_close.default = true
					 RETURN
			End If
			Delete from Criteria_from_tbls_Used
				where by_id = Upper( :in_link_id )
					and by_type = 'CRI'
			Using stars2ca;
			If stars2ca.of_check_status() = 100 then
				COMMIT using STARS2CA;
				If stars2ca.of_check_status() <> 0 Then
					errorbox(stars2ca,'Error Commiting to Stars2')
					Return
				End If	
				cb_close.default = true
				Messagebox('EDIT','Criteria From Table Record Has Already Been Deleted')
				Goto Delete_row
			Elseif Stars2ca.sqlcode <> 0 then
				 Errorbox(Stars2ca,'Error Deleting from Criteria From Table')
				 cb_close.default = true
				 RETURN
			End If
			Delete from Criteria_Used_line
				where by_id = Upper( :in_link_id )
				and by_type = 'CRI'
			Using stars2ca;
			If stars2ca.of_check_status() = 100 then
				COMMIT using STARS2CA;
				If stars2ca.of_check_status() <> 0 Then
					errorbox(stars2ca,'Error Commiting to Stars2')
					Return
				End If	
				cb_close.default = true
				Messagebox('EDIT','Criteria Line Record Has Already Been Deleted')
				Goto Delete_row
			Elseif Stars2ca.sqlcode <> 0 then
					 Errorbox(Stars2ca,'Error Deleting from Criteria Line Table')
					 cb_close.default = true
					 RETURN
			End If
		End If
		// DO DB Delete
		GOTO DB_DELETE
	CASE 'ATT'
		li_rc = lnv_att.of_delete_cntl( in_link_id )
		IF li_rc <> 1 THEN
			Stars2ca.of_rollback()
			Return
		End IF
		// DO DB Delete
		GOTO DB_DELETE		
	CASE else
		GOTO DELETE_ROW
END CHOOSE


DB_DELETE:
	Delete from Case_link 
		where Case_id   = Upper( :is_case_id ) and 
				case_spl  = Upper( :is_case_spl ) and 
				case_ver  = Upper( :is_case_ver ) and
				link_type = Upper( :in_link_type ) and
				link_name = Upper( :in_link_name )
	Using stars2ca;

	If stars2ca.of_check_status() = 100 then
		// already been deleted, delete row from dw
		cb_close.default = true
		Messagebox('EDIT','Case Link Record Has Already Been Deleted')
		GOTO DELETE_ROW
	Elseif Stars2ca.sqlcode <> 0 then
		Stars2ca.of_rollback()
		cb_close.default = true
		RETURN
	ELSE
		stars2ca.of_commit()
		lb_refresh_dw = True
		GOTO CASE_LOG_ENTRY
	End If	
DELETE_ROW:
	stars2ca.of_commit()
	setmicrohelp(w_main,'Link Has Been Removed')
	dw_1.setitem(getrow(dw_1),1,'')		//Added this because row focuschanged reads sub control
	deleterow(dw_1,0)
	parent.event ue_save()
	GOTO CASE_LOG_ENTRY
CASE_LOG_ENTRY:
	// make case log entry
	ls_message	=	"Link "	+	in_link_name	+	" ("	+	in_link_type	+	") removed."

	li_rc			=	inv_case.uf_audit_log (gv_active_case, ls_message)

	IF	li_rc		<	0		THEN
		Stars2ca.of_rollback()
		MessageBox ('Database Error', 'Could not insert case log for removal of link '	+	in_link_name	+	&
						'.  Case: ' + gv_active_case + '. Script: '		+	&
						'w_case_folder_view.cb_delete.clicked')
		Return
	END IF
	// if sent from a refresh instance then refresh before ending
	IF lb_refresh_dw THEN
		GOTO REFRESH_DW
	ELSE
		GOTO END_SCRIPT
	END IF
REFRESH_DW:
	// refresh dw then end 
	cb_refresh.triggerevent(clicked!)
	GOTO END_SCRIPT
END_SCRIPT:
	setmicrohelp(w_main,'Ready')
	setpointer(arrow!)

// JasonS 07/31/02 End - Track 3093d  - rework logic
end event

type st_link_type from statictext within w_case_folder_view
string accessiblename = "Type"
string accessibledescription = "Type"
accessiblerole accessiblerole = statictextrole!
integer x = 2080
integer y = 96
integer width = 165
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_link_type from dropdownlistbox within w_case_folder_view
string accessiblename = "Link Type"
string accessibledescription = "Link Type"
accessiblerole accessiblerole = comboboxrole!
integer x = 2245
integer y = 88
integer width = 544
integer height = 392
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"                                                                0","LTR - Letter","PDQ - Predefined Queries","POL - Policy","SUB - Subset","TGT - Target","PAT - Patterns","PDR - Predefined Reports","ATT - Attachments"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
// selectionchanged 							ddlb_link_type
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//This function will change the color depending on the link type chosen.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype				Description
//		---------	--------				--------				-----------
//    None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//
//	A.Sola	01/20/98	Updated. Stars 4.0
//	FDG		02/25/00	Stars 4.5 - Allow for patterns
//	GaryR		01/29/02	Track 2552d	Predefined Report (PDR)
// JasonS 	11/1/02 	Track 3042d set link_id limit according to link type
//	GaryR		10/16/06	Track 3153	Add external file attachment facility to Case
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
/////////////////////////////////////////////////////////////////////////////
setmicrohelp(w_main,'Ready')

string ls_tbl_type	// JasonS 11/1/02 Track 3042d
long 	ll_limit	// JasonS 11/1/02 Track 3042d

st_link_id.text = "ID:"
sle_link_id.text = ''
sle_link_id.enabled = true
//	GaryR		01/29/02	Track 2552d
If left(ddlb_link_type.text,3) = 'SUB' & 
Or	left(ddlb_link_type.text,3) = 'PDQ' &
Or	left(ddlb_link_type.text,3) = 'PDR' &
Or	left(ddlb_link_type.text,3) = 'PAT' then
	sle_link_id.backcolor  = stars_colors.lookup_back
	sle_link_id.textcolor  = stars_colors.lookup_text
	sle_link_id.tag = "LOOKUP"
	sle_link_id.accessiblename = "Lookup Field - " + Left(ddlb_link_type.text,3)
	sle_link_id.accessibledescription = "Lookup Field - " + Left(ddlb_link_type.text,3)
ElseIf left(ddlb_link_type.text,3) = 'TGT' then
	sle_link_id.text = fx_get_next_key_id('TARGET')
	sle_link_id.enabled = false
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	

	sle_link_id.backcolor  = stars_colors.input_back
	sle_link_id.textcolor  = stars_colors.input_text
	sle_link_id.tag = ""
	sle_link_id.accessiblename = "Link ID"
	sle_link_id.accessibledescription = "Link ID"
ElseIf left(ddlb_link_type.text,3) = 'ATT' THEN
	st_link_id.text = "Path:"
	sle_link_id.backcolor  = stars_colors.lookup_back
	sle_link_id.textcolor  = stars_colors.lookup_text
	sle_link_id.tag = "LOOKUP"
	sle_link_id.accessiblename = "Lookup Field - Path"
	sle_link_id.accessibledescription = "Lookup Field - Path"
Else
	sle_link_id.backcolor  = stars_colors.input_back
	sle_link_id.textcolor  = stars_colors.input_text
	sle_link_id.tag = ""
	sle_link_id.accessiblename = "Link ID"
	sle_link_id.accessibledescription = "Link ID"
End IF

// JasonS 11/1/02 Begin - Track 3042d
ls_tbl_type = gnv_dict.event ue_get_inv_type( 'CASE_LINK' )

choose case left(ddlb_link_type.text,3)
	case 'LTR', 'POL'
		select elem_data_len
		into :ll_limit
		from dictionary
		where elem_tbl_type = :ls_tbl_type
		and elem_name = 'LINK_KEY'
		using stars2ca;
	case 'ATT'
		ll_limit = 255
	case else
		select elem_data_len
		into :ll_limit
		from dictionary
		where elem_tbl_type = :ls_tbl_type
		and elem_name = 'LINK_NAME'
		using stars2ca;		
end choose

sle_link_id.limit = ll_limit

// JasonS 11/1/02 End - Track 3042d
end event

type st_link_id from statictext within w_case_folder_view
string accessiblename = "ID"
string accessibledescription = "ID"
accessiblerole accessiblerole = statictextrole!
integer x = 2139
integer y = 224
integer width = 105
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_case_folder_view
string accessiblename = "Type"
string accessibledescription = "Type"
accessiblerole accessiblerole = statictextrole!
integer x = 110
integer y = 204
integer width = 165
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_case_folder_view
string tag = "NO GRAPH,CRYSTAL, title = Case Folder Links"
string accessiblename = "Case Folder"
string accessibledescription = "Case Folder"
integer y = 348
integer width = 3127
integer height = 1572
integer taborder = 40
string dataobject = "d_case_folder"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;//////////////////////////////////////////////////////////////////////////////////////
//
//	Object Type:	DataWindow
//	Object Name:	w_case_folder_view.dw_1
//	Event Name:		RowFocusChanged
//
//////////////////////////////////////////////////////////////////////////////////////
//
//	FDG	04/04/96	Prob 58 - Remove all references to 'SMP'
// FNC   04/25/96 STARS31 Prob #269 Open up rename and patterns for ARC subsets
// FNC	11/12/96	FS118 add RDM as a report type. RDM is created from 
//						w_random_sampling_unique_hics when user checks box for
//					   sampling report. Treat like RPT.
// AJS   01/20/98 Stars 4.0 change subset_id column number; remove cri logic;
//                allow random sampling on ML subsets
// NLG	06/24/98	Track #1413 - enable Rename for PDQ
// AJS   07/17/98 Track #1366 - add variable for link name to correct delete
// AJS   10/14/98 Track #1924 - Add POL & LTR back.
// FDG	02/29/00	Stars 4.5.  Allow for patterns.
//	FDG	09/20/01	Stars 4.8.	Data for referred cases gets all data copied.
//						Restrict access to original canse and allow access to 
//						referred case.
//	GaryR	01/29/02	Track 2552d	Predefined Report (PDR)
//	GaryR	05/21/02	Track 3049d	Problems viewing patterns
// Jason 06/12/02 Track 3065d Displaying invalid options for Ancillary subsets (on more button)
// Jason 07/10/02 Track 3093d Added PAT to if statment to use link name in log, not link id
// Jason 08/01/02 Track 3225d Added RPT, MED, RDM to if statment to use link name in log, not link id
//	GaryR	02/06/03	Tracks 2324d, 3437d	Disable rename and description field if the Stars 
//						user is not the owner of the link or if the Case link is referred
// JasonS 12/9/04 Track 3664d Case Component Update
//	GaryR	10/16/06	Track 3153	Add external file attachment facility to Case
//	GaryR	04/22/08	SPR 5312	Use link_key to delete renamed attachments
//
//////////////////////////////////////////////////////////////////////////////////////

long lv_row_nbr

setpointer(hourglass!)

If not in_cancel then RETURN

setmicrohelp(w_main,'Ready')
lv_row_nbr = getrow(dw_1)

// Reset text
w_case_folder_view_uo.uo_1.pb_3.text = "&Target"
cb_details.enabled = FALSE

If lv_row_nbr = 0 then 
	in_link_id   = ''
	// FDG 09/20/01 - disable all buttons only if no rows exist
	IF	This.RowCount()	=	0	THEN
		w_case_folder_view_uo.uo_1.pb_3.enabled = false  //Target button
		w_case_folder_view_uo.uo_1.pb_4.enabled = false  //View button
		cb_remove.enabled = false
		w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
		w_case_folder_view_uo.uo_1.pb_6.enabled = false  //Random sample button
		w_case_folder_view_uo.uo_1.pb_2.enabled = false  //Summ Rpt button
		w_case_folder_view_uo.uo_1.pb_5.enabled = false  //Criteria button
		w_case_folder_view_uo.uo_1.pb_7.enabled = false  //rename button
	END IF
	
	// FDG 09/20/01 - edit for originally referred case
	//If sle_category.text <> 'REF'  and sle_category.text <> 'CA?' then
	If is_case_disp <> ics_referred  and sle_category.text <> 'CA?' then
		setfocus(ddlb_link_type)
		cb_add.enabled = true
		cb_add.default = true
	Else	
		cb_add.enabled = false
		cb_close.default = true
	End IF
	Parent.Event	ue_edit_cb_more()			// FDG 09/20/01
	setpointer(arrow!)
   RETURN
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

//	Do not allow changing description if the 
//	link owner is not the current user or link is referred
IF dw_1.GetItemString( lv_row_nbr, "compute_0010" ) = "1" THEN
	dw_1.Object.case_link_link_desc.Edit.DisplayOnly = "Yes"
ELSE
	dw_1.Object.case_link_link_desc.Edit.DisplayOnly = "No"
END IF

//ajs 4.0 02-19-98 Set globals here is stead of every window function
in_link_type = getitemstring(dw_1,lv_row_nbr,"case_link_link_type")
in_link_id   = getitemstring(dw_1,lv_row_nbr,"case_link_link_key")		//ajs 01-19-98
// //JasonS Track 3093d added 'PAT' to if statment to use link name when writing to case log
// JasonS Track 3225d added 'RDM', 'MED' and 'RPT' to if statement

// Enable/disable details
cb_details.enabled = in_link_type = 'SUB' OR in_link_type = 'ARC' &
									OR in_link_type = 'PAT' OR in_link_type = 'ATT'

If in_link_type = 'SUB' or in_link_type = 'ARC' or in_link_type = 'PDQ' then 	//ajs 01-19-98
	gc_active_subset_id = in_link_id													//ajs 01-19-98
	gc_active_subset_name = getitemstring(dw_1,lv_row_nbr,"case_link_link_name")	//ajs 01-19-98
	gc_active_subset_case = gv_active_case											//ajs 01-19-98
	in_link_name = getitemstring(dw_1,lv_row_nbr,"case_link_link_name")	//ajs 07-17-98 Track 1366
elseif in_link_type = 'LTR' or in_link_type = 'POL' or in_link_type = 'PAT' &
	or in_link_type = 'RPT' or in_link_type = 'MED' or in_link_type = 'RDM' &
	OR in_link_type = 'ATT' then
	in_link_name = getitemstring(dw_1,lv_row_nbr,"case_link_link_name")	//ajs 10-14-98 Track 1924
else
	in_link_name = getitemstring(dw_1,lv_row_nbr,"case_link_link_key")  //ajs 07-17-98 Track 1366
End If
//ajs 4.0 end

CB_MORE.ENABLED = TRUE

If in_link_type = 'SUB' or in_link_type = 'ARC' then   //04-25-96 FNC
//ajs change select columns
	Select subc_sub_tbl_type, subc_tables					//ajs 01-26-98
		into :iv_invoice_type, :is_subc_tables				//ajs 01-26-98
		From Sub_cntl
	  Where subc_id = Upper( :in_link_id )
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Error Reading Subset Control')
	End IF
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
End If

// FDG 09/20/01 - edit for originally referred case
//If sle_category.text = 'REF' then
If is_case_disp	=	ics_referred then
	cb_remove.enabled = FALSE
   w_case_folder_view_uo.uo_1.pb_3.enabled = false  //Target button
	w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
	w_case_folder_view_uo.uo_1.pb_6.enabled = false  //Random sample button
   w_case_folder_view_uo.uo_1.pb_2.enabled = false  //Summ Rpt button
	w_case_folder_view_uo.uo_1.pb_7.enabled = false  //rename button
	
	//	GaryR	05/21/02	Track 3049d - Begin
	w_case_folder_view_uo.uo_1.pb_5.enabled = false  //Criteria button
	w_case_folder_view_uo.uo_1.pb_4.enabled = false  //View button
	//	GaryR	05/21/02	Track 3049d - End
	
	cb_close.default = true

		// FDG 04/04/96 - Remove 'SMP'	
		// FNC 11/12/96 - Add RDM
	If in_link_type = 'RPT' or in_link_type = 'MED' OR &
		in_link_type = 'RDM' OR &
		in_link_type = 'CRC' or in_link_type = 'CRA'   then
		w_case_folder_view_uo.uo_1.pb_4.enabled = true //View button
		w_case_folder_view_uo.uo_1.pb_4.default = true //View button
      //w_case_folder_view_uo.uo_1.pb_2.enabled = true //Summ Rpt button
	Elseif in_link_type = 'SUB' or in_link_type = 'ARC'	Then
		w_case_folder_view_uo.uo_1.pb_4.enabled = true //View button
		w_case_folder_view_uo.uo_1.pb_4.default = true //View button
      w_case_folder_view_uo.uo_1.pb_2.enabled = true //Summ Rpt button
		w_case_folder_view_uo.uo_1.pb_5.enabled = true //Criteria button
	Elseif in_link_type = 'PDQ' OR in_link_type = 'PDR' 	Then	//	GaryR	01/29/02	Track 2552d
	//Elseif in_link_type = 'PDQ' 	Then
		w_case_folder_view_uo.uo_1.pb_4.enabled = true //View button
		w_case_folder_view_uo.uo_1.pb_4.default = true //View button
	Elseif in_link_type = 'PAT' 	Then
		w_case_folder_view_uo.uo_1.pb_5.enabled = true //Criteria button
		w_case_folder_view_uo.uo_1.pb_5.default = true //Criteria button
	Elseif in_link_type = 'TGT' 	Then
		w_case_folder_view_uo.uo_1.pb_3.enabled = true //Target button
		w_case_folder_view_uo.uo_1.pb_3.default = true //Target button
	ElseIf in_link_type = "ATT" THEN
		w_case_folder_view_uo.uo_1.pb_3.text = "&Download"
		w_case_folder_view_uo.uo_1.pb_3.enabled = true
		w_case_folder_view_uo.uo_1.pb_4.enabled = true
		w_case_folder_view_uo.uo_1.pb_4.default = true //View button
	End IF
	Parent.Event	ue_edit_cb_more()
	// FDG 09/20/01 end
	RETURN
End If

If sle_category.text = 'CA?' then
	If in_link_type = 'RPT' OR in_link_type = 'MED' OR in_link_type = 'RDM' OR &
	 in_link_type = 'CRC' or in_link_type = 'CRA'  then
		w_case_folder_view_uo.uo_1.pb_4.enabled = true  //view button
      w_case_folder_view_uo.uo_1.pb_4.default = true  //view button
		w_case_folder_view_uo.uo_1.pb_3.enabled = false  //target button
		w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
		w_case_folder_view_uo.uo_1.pb_6.enabled = false  //random sample button
      w_case_folder_view_uo.uo_1.pb_2.enabled = false  //summ rpt button
		w_case_folder_view_uo.uo_1.pb_5.enabled = false  //sub crit button
		w_case_folder_view_uo.uo_1.pb_7.enabled = true   //rename button
	Elseif in_link_type = 'SUB' or in_link_type = 'ARC' then
      w_case_folder_view_uo.uo_1.pb_4.enabled = true  //view button
		w_case_folder_view_uo.uo_1.pb_4.default = true  //view button
		w_case_folder_view_uo.uo_1.pb_2.enabled = TRUE //sUMM rPT button
		w_case_folder_view_uo.uo_1.pb_3.enabled = false //target button
      w_case_folder_view_uo.uo_1.pb_1.enabled = true //sample button		
		if in_rand_samp then w_case_folder_view_uo.uo_1.pb_6.enabled = true // random sample button		

      w_case_folder_view_uo.uo_1.pb_2.enabled = true  //summ rpt button
		w_case_folder_view_uo.uo_1.pb_5.enabled = true  //sub crit button
		if in_link_type = 'SUB' or in_link_type = 'ARC' then
			w_case_folder_view_uo.uo_1.pb_7.enabled = true  //rename button	
			w_case_folder_view_uo.uo_1.pb_2.enabled = true //Summ Rpt button
		Else
			w_case_folder_view_uo.uo_1.pb_7.enabled = false  //rename button
		End IF
	ElseIf in_link_type = "ATT" THEN
		w_case_folder_view_uo.uo_1.pb_3.text = "&Download"
		w_case_folder_view_uo.uo_1.pb_3.enabled = true
		w_case_folder_view_uo.uo_1.pb_4.enabled = true
		w_case_folder_view_uo.uo_1.pb_4.default = true //View button
		w_case_folder_view_uo.uo_1.pb_7.enabled = true   //rename button
	Else
		// FDG 04/04/96 - Remove 'SMP'
		w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
		w_case_folder_view_uo.uo_1.pb_2.enabled = false  
      w_case_folder_view_uo.uo_1.pb_3.enabled = false  
      w_case_folder_view_uo.uo_1.pb_4.enabled = false  
      w_case_folder_view_uo.uo_1.pb_5.enabled = false  
      w_case_folder_view_uo.uo_1.pb_6.enabled = false  
      w_case_folder_view_uo.uo_1.pb_7.enabled = false 
      cb_close.default = true 
	End IF
	setpointer(arrow!)
	RETURN
End If

//Categories other than REF and CA? drop here
w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
w_case_folder_view_uo.uo_1.pb_2.enabled = false  
w_case_folder_view_uo.uo_1.pb_3.enabled = false  
w_case_folder_view_uo.uo_1.pb_4.enabled = false  
w_case_folder_view_uo.uo_1.pb_5.enabled = false  
w_case_folder_view_uo.uo_1.pb_6.enabled = false  
w_case_folder_view_uo.uo_1.pb_7.enabled = false
cb_close.default = true

If (in_link_type = 'SUB' or in_link_type = 'ARC')  then
	If gv_sys_dflt <> iv_invoice_type then					//ajs 01-20-98
	   w_case_folder_view_uo.uo_1.pb_1.enabled = true  //sample button
	End IF
   if in_rand_samp then w_case_folder_view_uo.uo_1.pb_6.enabled = true  //random sample button
	w_case_folder_view_uo.uo_1.pb_3.enabled = true  //target
   w_case_folder_view_uo.uo_1.pb_3.default = true 
   w_case_folder_view_uo.uo_1.pb_4.enabled = true  //view button
	w_case_folder_view_uo.uo_1.pb_2.enabled = true  //summ rpt button
	w_case_folder_view_uo.uo_1.pb_5.enabled = true  //sub crit button
	
	If in_link_type = 'SUB' or in_link_type = 'ARC' then
		w_case_folder_view_uo.uo_1.pb_2.enabled = true  //summ rpt button
		w_case_folder_view_uo.uo_1.pb_7.enabled = true  //rename  button
	End IF
ElseIf (in_link_type = 'TGT')  then
      w_case_folder_view_uo.uo_1.pb_3.enabled = true  //target button
		w_case_folder_view_uo.uo_1.pb_3.default = true  //target button
		w_case_folder_view_uo.uo_1.pb_4.enabled = false  //view button
		w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
		w_case_folder_view_uo.uo_1.pb_6.enabled = false  //random sample button
      w_case_folder_view_uo.uo_1.pb_2.enabled = false  //sum rpt button
		w_case_folder_view_uo.uo_1.pb_5.enabled = false  //sub crit button
	//	FDG 04/04/96 - Remove 'SMP'
ElseIf (in_link_type = 'RPT') OR (in_link_type = 'MED')  OR (in_link_type = 'RDM') then	//11-12-96 FNC
		w_case_folder_view_uo.uo_1.pb_4.enabled = true   //view button
		w_case_folder_view_uo.uo_1.pb_4.default = true   //view button
		w_case_folder_view_uo.uo_1.pb_3.enabled = false  //target button
		w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
      w_case_folder_view_uo.uo_1.pb_6.enabled = false  // random sample button
		w_case_folder_view_uo.uo_1.pb_2.enabled = false   //summ rpt button
		w_case_folder_view_uo.uo_1.pb_5.enabled = false  //sub crit button
		w_case_folder_view_uo.uo_1.pb_7.enabled = true   //rename button
ElseIf (in_link_type = 'CRC' or in_link_type = 'CRA')  then
		w_case_folder_view_uo.uo_1.pb_4.enabled = true   //view button
		w_case_folder_view_uo.uo_1.pb_4.default = true   //view button
		w_case_folder_view_uo.uo_1.pb_3.enabled = false  //target button
		w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
      w_case_folder_view_uo.uo_1.pb_6.enabled = false  // random sample button
		w_case_folder_view_uo.uo_1.pb_2.enabled = false   //summ rpt butto
		If in_link_type = 'CRA' or in_link_type = 'CRC' then
			w_case_folder_view_uo.uo_1.pb_7.enabled = true   //rename button
		End IF
ElseIf in_link_type = 'PDQ' OR in_link_type = 'PDR' then		//	GaryR	01/29/02	Track 2552d
//ElseIf in_link_type = 'PDQ' then														//ajs 02/05/98
		w_case_folder_view_uo.uo_1.pb_4.enabled = true   //View button	//ajs 02/05/98
		w_case_folder_view_uo.uo_1.pb_7.enabled = true   //rename button  //NLG 6-24-98
ElseIf in_link_type = 'PAT' then														//ajs 02/05/98
		w_case_folder_view_uo.uo_1.pb_5.enabled = true   //Criteria button//FDG 02/29/00
		w_case_folder_view_uo.uo_1.pb_7.enabled = true   //rename button  //FDG 02/29/00
ElseIf in_link_type = "ATT" THEN
	w_case_folder_view_uo.uo_1.pb_3.text = "&Download"
	w_case_folder_view_uo.uo_1.pb_3.enabled = true
	w_case_folder_view_uo.uo_1.pb_4.enabled = true
	w_case_folder_view_uo.uo_1.pb_4.default = true //View button
	w_case_folder_view_uo.uo_1.pb_7.enabled = true		
End If

if iv_invoice_type = "MC" then  			//ajs 01-20-98 remove ML, Rand Sample now OK for ML
   w_case_folder_view_uo.uo_1.pb_6.enabled = false  
end if

// Begin - Track 3065
Parent.wf_set_more_buttons()
// End - Track 3065

//	Do not allow rename if the link 
//	owner is not the current user or link is referred
IF dw_1.GetItemString( lv_row_nbr, "compute_0010" ) = "1" THEN
	w_case_folder_view_uo.uo_1.pb_7.enabled = FALSE
END IF

choose case is_comp_upd_status 
	case 'AO'
		parent.event ue_set_mod_availability(false)
	case 'RO'
		parent.event ue_set_mod_availability(false)
	case 'AL'
		parent.event ue_set_mod_availability(true)
end choose

Parent.Event	ue_edit_cb_more()
// FDG 09/20/01	end
end event

event retrievestart;setpointer(hourglass!)
in_cancel = false
cb_stop.enabled = true
cb_add.enabled = false
cb_close.enabled = false
cb_remove.enabled = false
//ajs 01-20-98 remove reference to removed command button
//cb_return_from_subset_list.enabled = false
//w_case_folder_view_uo.uo_1.pb_1.enabled = false  //sample button
//w_case_folder_view_uo.uo_1.pb_6.enabled = false  //randon sample button
//w_case_folder_view_uo.uo_1.pb_3.enabled = false  //Target button
//w_case_folder_view_uo.uo_1.pb_5.enabled = false  //Sub Crit button
//w_case_folder_view_uo.uo_1.pb_2.enabled = false  //summ Rpt button
//w_case_folder_view_uo.uo_1.pb_4.enabled = false  //View button

//w_case_folder_view.controlmenu = false				//FDG 07/03/96 (PB 5.0)

end event

event doubleclicked;//************************************************************************
//	Object Type:	DataWindow
//	Object Name:	w_case_folder_view.dw_1
//	Event Name:		DoubleClicked
//
//
//************************************************************************
//	FDG	04/04/96	Prob 58 - When double-clicking a link that is not a
//						subset, the message still refers to SMP.  Remove all
//						references to SMP.
//	FDG	02/29/00	Stars 4.5.  Allow double-click for patterns.
//	GaryR	10/16/06	Track 3153	Add external file attachment facility to Case
//
//************************************************************************

integer lv_row,	li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

lv_row = row

If lv_row > 0 then
	selectrow(dw_1,0,false)
	selectrow(dw_1,lv_row,true)
	triggerevent(dw_1,rowfocuschanged!)
	
	// Trigger details
	cb_details.TriggerEvent( Clicked! )
End If

end event

event retrieveend;in_cancel = true
cb_stop.enabled = false
cb_add.enabled = true
cb_close.enabled = true
cb_remove.enabled = true
//ajs 01-20-98 remove reference to removed command button
//cb_return_from_subset_list.enabled = true
//w_case_folder_view_uo.uo_1.pb_3.enabled = true  //Target button
//w_case_folder_view_uo.uo_1.pb_5.enabled = true  //Sub Crit button
//w_case_folder_view_uo.uo_1.pb_2.enabled = true  //summ Rpt button
//w_case_folder_view_uo.uo_1.pb_4.enabled = true  //View button

//if in_case_business <> 'MC' then
//   w_case_folder_view_uo.uo_1.pb_1.enabled = true  //sample button
//   w_case_folder_view_uo.uo_1.pb_6.enabled = true  //random sample button
//end if
//w_case_folder_view.controlmenu = true				//FDG 07/03/96 (PB 5.0)
triggerevent(dw_1,rowfocuschanged!)


 
if (w_case_folder_view_uo.uo_1.pb_1.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_2.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_3.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_4.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_5.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_6.enabled = false and  &
    w_case_folder_view_uo.uo_1.pb_7.enabled = false ) then
  cb_more.enabled = false
else
  cb_more.enabled = true
end if  
end event

on getfocus;If integer(st_row_count.text) = 0  then 
//	If	in_case_dept = gc_user_dept then
		setfocus(ddlb_link_type)
//	End If
End if
end on

event constructor;call super::constructor;//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
This.of_SetTrim (TRUE)

end event

event clicked;call super::clicked;//************************************************************************
//	Object Type:	DataWindow
//	Object Name:	w_case_folder_view.dw_1
//	Event Name:		Clicked
//
//
//************************************************************************
//	JasonS	6/5/2002	Track 3109  Users wanted to be able to click on any field in the dw to select row
//							on click of row, now matter where, i am setting row to that row, this stopped working 
//							in version 5.1 due to making the desc editable
//************************************************************************

// Begin - Track 3109
this.setrow(row)
// End - Track 3109	

end event

type sle_case_id from singlelineedit within w_case_folder_view
event charentered pbm_char
string tag = "protect"
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = textrole!
integer x = 279
integer y = 88
integer width = 471
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
integer limit = 14
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

on charentered;//If sle_link_id.enabled = false then
//	sle_link_id.enabled = true
//	ddlb_link_type.enabled = true
// cb_add.enabled = true
//End If
end on

type st_1 from statictext within w_case_folder_view
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 88
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Case ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_case_folder_view
string accessiblename = "Add Link"
string accessibledescription = "Add Link"
accessiblerole accessiblerole = groupingrole!
integer x = 2034
integer width = 1088
integer height = 328
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Add Link"
end type

type gb_2 from groupbox within w_case_folder_view
string accessiblename = "Case"
string accessibledescription = "Case"
accessiblerole accessiblerole = groupingrole!
integer width = 2016
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Case"
end type

