HA$PBExportHeader$w_subset_use.srw
$PBExportComments$Inherited window from w_subset_list to select subset id's for Use (Inherited from w_subset_list).
forward
global type w_subset_use from w_subset_list
end type
type cb_use from commandbutton within w_subset_use
end type
end forward

global type w_subset_use from w_subset_list
integer width = 3767
integer height = 1952
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_use cb_use
end type
global w_subset_use w_subset_use

type variables
sx_subset_use	istr_subset_use
end variables

on w_subset_use.create
int iCurrent
call super::create
this.cb_use=create cb_use
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_use
end on

on w_subset_use.destroy
call super::destroy
destroy(this.cb_use)
end on

event ue_row_access;
cb_delete.enabled = FALSE
end event

event open;call super::open;// 08/17/05 MikeF Track 4488d Subset Lookup PDRs not specifc to selected Invoice type
//	10/11/05	GaryR	Track 4549d	Lock Case to NONE from Folder
// 05/02/09 RickB GNL.600.5633.011 Trigger List click event at end of Open.

String 				ls_sql
DataWindowChild	ldwc_subset_type

dw_list.modify( "delete_flag.visible = 0" )

//	If from Case Folder
//	Search only for Case NONE
IF gv_from = 'FOLDER' THEN
	dw_search.SetItem( 1, "case_id", "NONE" )
	dw_search.Object.case_id.Protect = 1
	dw_search.Object.case_id.Color = stars_colors.protected_text
	dw_search.Object.case_id.Background.Color = stars_colors.protected_back
END IF

if len(istr_subset_use.inv_type) > 0 then
	// Re-retrieve and filter the dropdown
	ls_sql = "select Substring(stars_rel.rel_id,1,2), dictionary.elem_desc " + &
					"from stars_rel, dictionary " + &
					"where stars_rel.rel_id = dictionary.elem_tbl_type " + &
					"and dictionary.elem_type = 'TB' " + &
					"and stars_rel.rel_type in ( 'AN', 'IT' ) " + &
					"and stars_rel.rel_id = ('" + istr_subset_use.inv_type + "') " + &
					"order by stars_rel.rel_id"
	gnv_sql.of_get_substring( ls_sql )
	dw_search.GetChild( "subset_type", ldwc_subset_type )
	ldwc_subset_type.SetTransObject( Stars2ca )
	ldwc_subset_type.SetSQLSelect( ls_sql )
	ldwc_subset_type.retrieve()
	// Select the first invoice
	dw_search.SetItem( 1, "subset_type", istr_subset_use.inv_type )
	dw_search.Object.subset_type.Protect = 1
end if

cb_list.event clicked()
end event

event ue_postretrieve;// Ancestor overridden
end event

event ue_open_rmm;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

//	Ancestor overridden
//	Do not allow popup menus on response windows.  (Section 508)
end event

type cb_close from w_subset_list`cb_close within w_subset_use
integer x = 3387
integer y = 1748
end type

event cb_close::clicked;call super::clicked;// 01/04/06  JasonS  Track 4593d  - Set result to 100 if we "cancel" selection
gv_result = 100
end event

type uo_range from w_subset_list`uo_range within w_subset_use
end type

event uo_range::constructor;call super::constructor;// 08/17/05 MikeF SPR4488d Subset Lookup PDRs not specifc to selected Invoice type
IF IsValid(message.PowerObjectParm) THEN
	istr_subset_use = message.PowerObjectParm
END IF
SetNull(message.stringparm)
end event

type st_dw_ops from w_subset_list`st_dw_ops within w_subset_use
integer x = 37
integer y = 1764
integer width = 562
end type

type cb_delete from w_subset_list`cb_delete within w_subset_use
integer x = 2368
integer y = 1748
end type

type cb_reset from w_subset_list`cb_reset within w_subset_use
boolean visible = false
end type

type cb_add from w_subset_list`cb_add within w_subset_use
end type

type dw_details from w_subset_list`dw_details within w_subset_use
boolean visible = false
end type

type st_rows from w_subset_list`st_rows within w_subset_use
end type

type cb_update from w_subset_list`cb_update within w_subset_use
boolean visible = false
end type

type cb_list from w_subset_list`cb_list within w_subset_use
end type

type dw_list from w_subset_list`dw_list within w_subset_use
integer height = 1292
end type

event dw_list::rowfocuschanged;call super::rowfocuschanged;//	10/11/05	GaryR	Track 4553d	Disable the USE button if no active row

IF dw_list.RowCount() > 0 THEN
	cb_use.enabled = TRUE
ELSE
	cb_use.enabled = FALSE
END IF
end event

type dw_search from w_subset_list`dw_search within w_subset_use
end type

type gb_details from w_subset_list`gb_details within w_subset_use
boolean visible = false
end type

type ddlb_dw_ops from w_subset_list`ddlb_dw_ops within w_subset_use
integer x = 617
integer y = 1756
end type

type gb_2 from w_subset_list`gb_2 within w_subset_use
end type

type gb_1 from w_subset_list`gb_1 within w_subset_use
end type

type cb_view from w_subset_list`cb_view within w_subset_use
integer x = 3401
integer y = 1884
end type

type cb_criteria from w_subset_list`cb_criteria within w_subset_use
integer x = 2711
integer y = 1748
end type

type cb_summary from w_subset_list`cb_summary within w_subset_use
integer x = 1339
integer y = 1748
end type

type cb_query from w_subset_list`cb_query within w_subset_use
integer x = 3063
integer y = 1884
end type

type cb_patterns from w_subset_list`cb_patterns within w_subset_use
integer x = 1682
integer y = 1748
end type

type cb_sample from w_subset_list`cb_sample within w_subset_use
integer x = 2025
integer y = 1748
end type

type pb_notes from w_subset_list`pb_notes within w_subset_use
end type

type cb_notes from w_subset_list`cb_notes within w_subset_use
boolean visible = false
end type

type cb_use from commandbutton within w_subset_use
string accessiblename = "Use"
string accessibledescription = "Use"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 3049
integer y = 1748
integer width = 320
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Use"
end type

event clicked;// JasonS	12/14/2005	Track 4593d  Make sure we return 0 in gv_result to mark success
parent.wf_select_subset()
gv_result = 0
Close(parent)
end event

