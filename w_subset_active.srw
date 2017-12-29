HA$PBExportHeader$w_subset_active.srw
$PBExportComments$Set active subset (Inherited from w_master)
forward
global type w_subset_active from w_master
end type
type sle_key from u_sle within w_subset_active
end type
type sle_description from multilineedit within w_subset_active
end type
type sle_subc_tables from singlelineedit within w_subset_active
end type
type st_subc_tables from statictext within w_subset_active
end type
type sle_source_from from singlelineedit within w_subset_active
end type
type sle_business from singlelineedit within w_subset_active
end type
type sle_subset_tbl_type from singlelineedit within w_subset_active
end type
type st_subset_tbl_type from statictext within w_subset_active
end type
type st_line_of_business from statictext within w_subset_active
end type
type sle_count from singlelineedit within w_subset_active
end type
type st_count from statictext within w_subset_active
end type
type cb_reset from u_cb within w_subset_active
end type
type cb_list_from_case from u_cb within w_subset_active
end type
type sle_active_subset from singlelineedit within w_subset_active
end type
type st_active_subset_id from statictext within w_subset_active
end type
type cb_ok from u_cb within w_subset_active
end type
type cb_view from u_cb within w_subset_active
end type
type st_source_type from statictext within w_subset_active
end type
type sle_subset_source_used from singlelineedit within w_subset_active
end type
type st_source from statictext within w_subset_active
end type
type st_selection_criteria_key from statictext within w_subset_active
end type
type sle_selection_criteria-key from singlelineedit within w_subset_active
end type
type st_description from statictext within w_subset_active
end type
type st_bb-key from statictext within w_subset_active
end type
type cb_exit from u_cb within w_subset_active
end type
type st_1 from statictext within w_subset_active
end type
type st_2 from statictext within w_subset_active
end type
type sle_active_subset_case from singlelineedit within w_subset_active
end type
type sle_subset_case_source_used from singlelineedit within w_subset_active
end type
end forward

global type w_subset_active from w_master
string accessiblename = "Subset Active"
string accessibledescription = "Subset Active"
integer x = 0
integer y = 500
integer width = 2903
integer height = 696
string title = "Subset Active"
sle_key sle_key
sle_description sle_description
sle_subc_tables sle_subc_tables
st_subc_tables st_subc_tables
sle_source_from sle_source_from
sle_business sle_business
sle_subset_tbl_type sle_subset_tbl_type
st_subset_tbl_type st_subset_tbl_type
st_line_of_business st_line_of_business
sle_count sle_count
st_count st_count
cb_reset cb_reset
cb_list_from_case cb_list_from_case
sle_active_subset sle_active_subset
st_active_subset_id st_active_subset_id
cb_ok cb_ok
cb_view cb_view
st_source_type st_source_type
sle_subset_source_used sle_subset_source_used
st_source st_source
st_selection_criteria_key st_selection_criteria_key
sle_selection_criteria-key sle_selection_criteria-key
st_description st_description
st_bb-key st_bb-key
cb_exit cb_exit
st_1 st_1
st_2 st_2
sle_active_subset_case sle_active_subset_case
sle_subset_case_source_used sle_subset_case_source_used
end type
global w_subset_active w_subset_active

type variables
string iv_subset_id, is_sub_desc
date iv_subset_date
string in_subset_in_what_table
string in_subc_tables
boolean iv_is_window_being_opened

end variables

forward prototypes
public function integer fw_load_subset_data ()
public subroutine wf_return_from_subset_list ()
public function integer wf_get_invoice_types ()
end prototypes

public function integer fw_load_subset_data ();//******************************************************************************
//		Object Type:	Window function
//		Object Name:	w_subset_active.fw_load_subset_date
//		Event Name:		N/A
//		Arguments:		None
//  
//******************************************************************************
// FNC 11/05/98	Track 1826 - If source subset has been deleted do not
//						display error message. Put the string deleted in the source
//						subset id.
//
//******************************************************************************
sx_subset_ids lstr_subset_ids
nvo_subset_functions lnv_subset_functions
integer li_rc
//  Load screen with subset data

//If gv_sub_src_type = 'SC' Then				//ajs 4.0 02-11-98
//	sle_source_from.text = 'Case Subset'	//ajs 4.0 02-11-98
If gv_sub_src_type = 'SS' Then				//ajs 4.0 02-11-98
	sle_source_from.text = 'Subset'			//ajs 4.0 02-11-98
	sle_subset_case_source_used.text = gv_sub_src_case				//ajs 4.0 03-11-98

	lnv_subset_functions = create nvo_subset_functions				//ajs 4.0 03-11-98
	lstr_subset_ids.subset_case_id = left(gv_sub_src_case,10)	//ajs 4.0 03-11-98
	lstr_subset_ids.subset_case_spl = mid(gv_sub_src_case,11,2)	//ajs 4.0 03-11-98
	lstr_subset_ids.subset_case_ver = mid(gv_sub_src_case,13,2) //ajs 4.0 03-11-98
	lstr_subset_ids.subset_id = gv_sub_src_name	//ajs 4.0 03-11-98 (This is really subset id)
	lnv_subset_functions.uf_set_structure(lstr_Subset_ids)		//ajs 4.0 03-11-98
	li_rc = lnv_subset_functions.uf_Retrieve_Subset_Name()		//ajs 4.0 03-11-98
		if li_rc < 1 then														//ajs 4.0 03-11-98
			sle_subset_source_used.text = 'DELETED'					// FNC 11/05/98
//			messagebox('Error','Unable to retrieve source subset name. It will not be displayed')
		else
			lstr_Subset_ids = lnv_subset_functions.uf_get_structure() //ajs 4.0 03-11-98
			sle_subset_source_used.text = lstr_subset_ids.subset_name //ajs 4.0 03-11-98
	end if																			//ajs 4.0 03-11-98
	Destroy(lnv_subset_functions)												//ajs 4.0 03-11-98

Else													//ajs 4.0 02-11-98
	sle_source_from.text = 'Base'				//ajs 4.0 02-11-98
	sle_subset_case_source_used.text	= ''	//ajs 4.0 02-11-98
	sle_subset_source_used.text	= ''		//ajs 4.0 02-11-98
End If												//ajs 4.0 02-11-98



sle_selection_criteria-key.text = gv_crit_name
sle_description.text = is_sub_desc
sle_count.text = string(gv_no_rows)
sle_subset_tbl_type.text = gv_subset_tbl_type
sle_business.text = gv_subset_bus
sle_subc_tables.text = in_subc_tables

//			gv_subset_id must be set but not shown 	
//			gv_crit_place_ind not used
//			lv_run_datetime not used

//If in_subset_in_what_table = 'SS' Then					//ajs 4.0 02-11-98
// 	sle_subset_type.text = 'Independent Subset'		//ajs 4.0 02-11-98
//Elseif  in_subset_in_what_table = 'SC' Then			//ajs 4.0 02-11-98
// 	sle_subset_type.text = 'Case Subset'				//ajs 4.0 02-11-98
//Elsev
// 	sle_subset_type.text = 'Unknown'						//ajs 4.0 02-11-98
//End If																//ajs 4.0 02-11-98


RETURN 0
end function

public subroutine wf_return_from_subset_list ();	//*******************************************************************
	//* New function to populate subset name when return from subset list
	//* window or case subset list window.
	//********************************************************************
	If gv_result = 0 Then											//ajs 4.0 2-11-98
 		sle_key.text  = gc_active_subset_name					//ajs 4.0 2-11-98
		cb_ok.setfocus()												//ajs 4.0 2-11-98
	Else																	//ajs 4.0 2-11-98
		sle_key.setfocus()											//ajs 4.0 2-11-98
		Messagebox('EDIT','No Subset ID Returned')	 		//ajs 4.0 2-11-98	
	End If																//ajs 4.0 2-11-98
end subroutine

public function integer wf_get_invoice_types ();//*********************************************************************************
//Modifications:
//
//	12/23/97	NLG	ts145 Subset Redesign ts145-fx retrieve subset.doc 
// 					Modify in 4.0 so that only the sub_cntl table is read
//	02/12/98	AJS	ts145 - globals - case id, subset id, and subset name
//	06/19/98 NLG	track #1360 1) Get description from case_link, not sub_cntl
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	09/24/02	GaryR	SPR 3323d	1) Moved to window level from global
//										2) Add link_type to criteria to prevent more than one row
//
//*********************************************************************************

Integer	li_rc

string ls_case_id, ls_case_spl, ls_case_ver						//NLG 6-19-98

ls_case_id = left(gc_active_subset_case,10)						//NLG 6-19-98
ls_case_spl = mid(gc_active_subset_case,11,2)					//NLG 6-19-98
ls_case_ver = mid(gc_active_subset_case,13,2)					//NLG 6-19-98

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
// FDG 04/16/01 - end

	Select	sub_cntl.subc_id,
				sub_cntl.subc_sub_src_type, 	
				sub_cntl.subc_sub_tbl_type,
				sub_cntl.subc_sub_src_id,
				sub_cntl.subc_crit_id,
				sub_cntl.subc_Place_id,
				case_link.link_desc,//subc_desc,   NLG Track #1360
				sub_cntl.subc_no_rows, 
				sub_cntl.subc_tables,
				sub_cntl.subc_sub_src_case_id
		into
			:gc_active_subset_id,	//ajs 4.0 02-12-98 
			:gv_sub_src_type,
			:gv_subset_tbl_type, 	
			:gv_sub_src_name,
			:gv_crit_name,
			:gv_crit_place_ind,
			:is_sub_desc,
			:gv_no_rows,
			:in_subc_tables,			//	09/24/02	GaryR	SPR 3323d
			:gv_sub_src_case
	from sub_cntl, case_link												//NLG 6-19-98
	where subc_id = :gc_active_subset_id	//ajs 4.0 02-12-98 
		and sub_cntl.subc_id = case_link.link_key									//NLG 6-19-98
		and case_link.case_id = Upper( :ls_case_id )								//NLG 6-19-98
		and case_link.case_spl = Upper( :ls_case_spl )							//NLG 6-19-98
		and case_link.case_ver = Upper( :ls_case_ver )							//NLG 6-19-98
		and case_link.link_name = Upper( :gc_active_subset_name )			//NLG 6-19-98
		and case_link.link_type = 'SUB'												//	09/24/02	GaryR	SPR 3323d
	using stars2ca;
	If stars2ca.sqlcode <> 0 Then
		if stars2ca.sqlcode = 100 then
			Messagebox('ERROR','Subset does not exist',Exclamation!)	
		else
			Errorbox(stars2ca,'Reading Subset Control, Case Link~r fx_retrieve_subset')
		end if
		RETURN -1
	Else
		COMMIT using Stars2ca;
		if Stars2ca.sqlcode <> 0 then
			errorbox(stars2ca,'Error performing commit in fx_retrieve_subset.')
		end if
		RETURN 0
	End If
end function

event activate;//************************************************************************	
//	03/12/98	AJS	4.0 fix setting of active subset case
//	05/31/02	SAH	Changed window width and other objects to accommodate 
//						80 byted subc_desc (Track 2945).  Changed Y positition
//						to fit with w_case_active's new matching size.
//	09/24/02	GaryR	SPR 3323d	Moved to window level from global
//************************************************************************
int rc

setpointer(hourglass!)

//If iv_is_window_being_opened = TRUE or gv_subset_id <> sle_active_subset.text Then
If iv_is_window_being_opened = TRUE or &
	gc_active_subset_name <> sle_active_subset.text Then		//ajs 4.0 02-11-98

//   iv_is_window_being_opened = FALSE
   w_subset_active.x = 1
	
	// SAH 05/31/02
   //w_subset_active.y = 545
	This.y = 645
   //fx_set_window_colors(w_subset_active)
   setmicrohelp(w_main,'Ready')
   in_subset_in_what_table = 'UK'
   setfocus(sle_key)

   If gc_active_subset_name <> '' then		
		sle_active_subset.text = gc_active_subset_name  
		sle_active_subset_case.text = gc_active_subset_case	//ajs 4.0 03-12-98
	   sle_key.text = gc_active_subset_name
		
		//	09/24/02	GaryR	SPR 3323d - Begin
		//rc = fx_retrieve_subset(in_subc_tables)	//NLG 12-24-97 ts145-fx_retrieve_subset.doc
		//If rc <> 0 Then
		//	RETURN
		//End If
		
		IF wf_get_invoice_types() <> 0 THEN Return
		//	09/24/02	GaryR	SPR 3323d - End
		rc = fw_load_subset_data()
		If rc <> 0 Then
			RETURN
		End If
		cb_view.enabled = TRUE

   Else

	      triggerevent(cb_reset,clicked!)

   End If

   setfocus(sle_key)
	
	iv_is_window_being_opened = FALSE

End If
end event

event open;call super::open;iv_is_window_being_opened = TRUE
This.of_set_queryengine (TRUE)	
end event

event close;call super::close;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

int lv_yesno
If sle_active_subset.text <> sle_key.text Then
	lv_yesno = Messagebox('WARNING','You have not updated Active Subset. Continue?', &
									Exclamation!,YesNo!,1)
	If lv_yesno = 2 Then
		setfocus(sle_key)
		RETURN
	End if
End If

If isvalid(w_case_subset_list) Then
	close (w_case_subset_list)
End If




end event

on w_subset_active.create
int iCurrent
call super::create
this.sle_key=create sle_key
this.sle_description=create sle_description
this.sle_subc_tables=create sle_subc_tables
this.st_subc_tables=create st_subc_tables
this.sle_source_from=create sle_source_from
this.sle_business=create sle_business
this.sle_subset_tbl_type=create sle_subset_tbl_type
this.st_subset_tbl_type=create st_subset_tbl_type
this.st_line_of_business=create st_line_of_business
this.sle_count=create sle_count
this.st_count=create st_count
this.cb_reset=create cb_reset
this.cb_list_from_case=create cb_list_from_case
this.sle_active_subset=create sle_active_subset
this.st_active_subset_id=create st_active_subset_id
this.cb_ok=create cb_ok
this.cb_view=create cb_view
this.st_source_type=create st_source_type
this.sle_subset_source_used=create sle_subset_source_used
this.st_source=create st_source
this.st_selection_criteria_key=create st_selection_criteria_key
this.sle_selection_criteria-key=create sle_selection_criteria-key
this.st_description=create st_description
this.st_bb-key=create st_bb-key
this.cb_exit=create cb_exit
this.st_1=create st_1
this.st_2=create st_2
this.sle_active_subset_case=create sle_active_subset_case
this.sle_subset_case_source_used=create sle_subset_case_source_used
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_key
this.Control[iCurrent+2]=this.sle_description
this.Control[iCurrent+3]=this.sle_subc_tables
this.Control[iCurrent+4]=this.st_subc_tables
this.Control[iCurrent+5]=this.sle_source_from
this.Control[iCurrent+6]=this.sle_business
this.Control[iCurrent+7]=this.sle_subset_tbl_type
this.Control[iCurrent+8]=this.st_subset_tbl_type
this.Control[iCurrent+9]=this.st_line_of_business
this.Control[iCurrent+10]=this.sle_count
this.Control[iCurrent+11]=this.st_count
this.Control[iCurrent+12]=this.cb_reset
this.Control[iCurrent+13]=this.cb_list_from_case
this.Control[iCurrent+14]=this.sle_active_subset
this.Control[iCurrent+15]=this.st_active_subset_id
this.Control[iCurrent+16]=this.cb_ok
this.Control[iCurrent+17]=this.cb_view
this.Control[iCurrent+18]=this.st_source_type
this.Control[iCurrent+19]=this.sle_subset_source_used
this.Control[iCurrent+20]=this.st_source
this.Control[iCurrent+21]=this.st_selection_criteria_key
this.Control[iCurrent+22]=this.sle_selection_criteria-key
this.Control[iCurrent+23]=this.st_description
this.Control[iCurrent+24]=this.st_bb-key
this.Control[iCurrent+25]=this.cb_exit
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.st_2
this.Control[iCurrent+28]=this.sle_active_subset_case
this.Control[iCurrent+29]=this.sle_subset_case_source_used
end on

on w_subset_active.destroy
call super::destroy
destroy(this.sle_key)
destroy(this.sle_description)
destroy(this.sle_subc_tables)
destroy(this.st_subc_tables)
destroy(this.sle_source_from)
destroy(this.sle_business)
destroy(this.sle_subset_tbl_type)
destroy(this.st_subset_tbl_type)
destroy(this.st_line_of_business)
destroy(this.sle_count)
destroy(this.st_count)
destroy(this.cb_reset)
destroy(this.cb_list_from_case)
destroy(this.sle_active_subset)
destroy(this.st_active_subset_id)
destroy(this.cb_ok)
destroy(this.cb_view)
destroy(this.st_source_type)
destroy(this.sle_subset_source_used)
destroy(this.st_source)
destroy(this.st_selection_criteria_key)
destroy(this.sle_selection_criteria-key)
destroy(this.st_description)
destroy(this.st_bb-key)
destroy(this.cb_exit)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_active_subset_case)
destroy(this.sle_subset_case_source_used)
end on

type sle_key from u_sle within w_subset_active
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Subset ID"
string accessibledescription = "Lookup Field - Subset ID"
integer x = 1682
integer y = 36
integer width = 800
integer height = 76
integer textsize = -8
string facename = "Microsoft Sans Serif"
long textcolor = 134217747
long backcolor = 134217731
boolean autohscroll = true
textcase textcase = upper!
integer limit = 20
end type

event modified;call super::modified;in_subset_in_what_table = 'UK'
end event

event ue_lookup;call super::ue_lookup;//*************************************************************************
//*  This script will allow the user to look up a subset id by using the
//*  subset_use response window.
//*************************************************************************
//
// 11/01/99 AJS Rel 4.5 ts2463 - pass empty structure to w_subset_use
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*************************************************************************

sx_subset_use lstr_subset_use

gv_from = 'U'
gv_subset_tbl_type = sle_subset_tbl_type.text
OpenWithParm (w_subset_use,lstr_subset_use,parent)	//ajs 11/01/99
wf_return_from_subset_list()
end event

type sle_description from multilineedit within w_subset_active
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 398
integer y = 496
integer width = 2085
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type sle_subc_tables from singlelineedit within w_subset_active
string accessiblename = "Invoice Types"
string accessibledescription = "Invoice Types"
accessiblerole accessiblerole = textrole!
integer x = 398
integer y = 312
integer width = 823
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_subc_tables from statictext within w_subset_active
string accessiblename = "Invoice Types"
string accessibledescription = "Invoice Types"
accessiblerole accessiblerole = statictextrole!
integer y = 312
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Invoice Types:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_source_from from singlelineedit within w_subset_active
string tag = "colorfixed"
string accessiblename = "Source"
string accessibledescription = "Source"
accessiblerole accessiblerole = textrole!
integer x = 398
integer y = 404
integer width = 823
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_business from singlelineedit within w_subset_active
boolean visible = false
string accessiblename = "Line of Business"
string accessibledescription = "Line of Business"
accessiblerole accessiblerole = textrole!
integer x = 1047
integer y = 220
integer width = 174
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_subset_tbl_type from singlelineedit within w_subset_active
string accessiblename = "Subset Type"
string accessibledescription = "Subset Type"
accessiblerole accessiblerole = textrole!
integer x = 398
integer y = 220
integer width = 174
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_subset_tbl_type from statictext within w_subset_active
string accessiblename = "Subset Type"
string accessibledescription = "Subset Type"
accessiblerole accessiblerole = statictextrole!
integer y = 220
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Subset Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_line_of_business from statictext within w_subset_active
boolean visible = false
string accessiblename = "Line of Business"
string accessibledescription = "Bus"
accessiblerole accessiblerole = statictextrole!
integer x = 768
integer y = 220
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Business:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_count from singlelineedit within w_subset_active
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = textrole!
integer x = 1682
integer y = 404
integer width = 288
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_count from statictext within w_subset_active
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1234
integer y = 404
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Count:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_reset from u_cb within w_subset_active
string accessiblename = "Reset"
string accessibledescription = "Reset"
integer x = 2514
integer y = 352
integer width = 338
integer height = 108
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Reset"
end type

event clicked;//********************************************************************
//** This button will reset the active subset
//********************************************************************
//*   02-11-98 ajs 4.0 update globals
//********************************************************************
setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
sle_active_subset.text = ''
sle_active_subset_case.text = ''				//ajs 4.0 03-12-98
sle_subset_case_source_used.text = ''		//ajs 4.0 03-12-98
sle_subset_source_used.text = ''
sle_description.text = ''
sle_key.text = ''
sle_selection_criteria-key.text = ''
//setmicrohelp(W_main,'')
setfocus(sle_key)
sle_source_from.text = ''
sle_count.text = ''
sle_subset_tbl_type.text = ''
sle_business.text = ''
//sle_subset_type.text = ''		//ajs 02-11-98

cb_view.enabled = FALSE

in_subset_in_what_table = 'UK'
gc_active_subset_name = ''			//ajs 02-11-98
gc_active_subset_id = ''			//ajs 02-11-98
gc_active_subset_case = ''			//ajs 02-11-98
gv_subset_tbl_type = ''
gv_sub_src_type = ''
gv_sub_src_name = ''
gv_crit_name = ''
is_sub_desc = ''
gv_no_rows = 0
gv_subset_bus = ''

setfocus(sle_key)
end event

type cb_list_from_case from u_cb within w_subset_active
string accessiblename = "List"
string accessibledescription = "List..."
integer x = 2514
integer y = 240
integer width = 338
integer height = 108
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&List..."
end type

event clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

Open(w_case_subset_list,parent)	//ajs 4.0 8-28-98
wf_return_from_subset_list()			//ajs 4.0 2-11-98
end event

type sle_active_subset from singlelineedit within w_subset_active
string tag = "colorfixed"
string accessiblename = "Active Subset"
string accessibledescription = "Active Subset"
accessiblerole accessiblerole = textrole!
integer x = 398
integer y = 36
integer width = 823
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean autohscroll = false
textcase textcase = upper!
integer limit = 10
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_active_subset_id from statictext within w_subset_active
string tag = "colorfixed"
string accessiblename = "Active Subset"
string accessibledescription = "Active Subset"
accessiblerole accessiblerole = statictextrole!
integer y = 36
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Active Subset:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_subset_active
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 2514
integer y = 16
integer width = 338
integer height = 108
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;//********************************************************************
//** This button will update the active subset
//********************************************************************
//	02/11/98 ajs	4.0 update globals
//	06/17/98 nlg	Track #1346 - after the opening of the Subset 
//						Cross Reference List check for empty subset id string
//	06/19/98	NLG	Track #1348 - if bad subset id, reset to active subset id
//	06/30/98 ajs	4.0 Fix track #1466
//	07/15/98 NLG	Add security check
//	07/31/02 MikeF	Track 2824 - Database error on the update.
//	09/24/02	GaryR	SPR 3323d	Moved to window level from global
// 06/10/05	MikeF	SPR4319d	Remove refernce to w_subset_maint
//********************************************************************
int rc
Integer li_num_rows, li_rc
sx_subset_ids lstr_subset_ids
NVO_Subset_Functions LUO_Subset_Functions

string ls_active_subset_name, ls_active_subset_case, ls_active_subset_id

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
setfocus(sle_key)

LUO_Subset_Functions = Create NVO_Subset_Functions

If sle_active_subset.text = '' Then
	cb_view.enabled = FALSE
else
	cb_view.enabled = TRUE
End If

If sle_key.text = sle_active_subset.text Then
	close(parent)
	RETURN
End If

If Trim( sle_key.text ) = '' then
	setfocus(sle_key)
	messagebox('EDIT','Subset Id Must Be Selected',Exclamation!)
	RETURN
End If

//   go against subc or subc_used to determine in_subset_in_what_table.
//   Retrieve other subset data fields as well

//gv_subset_id = trim(sle_key.text)
//get subset id

if gc_active_subset_name = trim(sle_key.text) then
	//bypass subset id look up
else
	
	lstr_subset_ids.subset_name = trim(sle_key.text)

	LUO_Subset_Functions.UF_Set_Structure(lstr_subset_ids)
	li_num_rows = LUO_Subset_Functions.UF_Select_Links_Using_Subset_Name()

	If li_num_rows > 1 then
		li_rc = Openwithparm(w_subset_cross_reference_list,lstr_subset_ids,parent)
		if li_rc = 1 then
			lstr_subset_ids = Message.PowerObjectparm
			if lstr_subset_ids.subset_id <> '' then			//NLG Track #1346		
				ls_active_subset_name = lstr_subset_ids.subset_name
				ls_active_subset_case = lstr_subset_ids.subset_case_id + lstr_subset_ids.subset_case_spl + lstr_subset_ids.subset_case_ver
				ls_active_subset_id = lstr_subset_ids.Subset_Id
			else
				messagebox('EDIT','Subset id not changed')
				return
			end if
		else
			messagebox('WARNING',' Unable to set subset id. Please try again')
			sle_key.text = gc_active_subset_name//NLG Track #1348
		return
		end if
	
	End If
	
	If li_num_rows = 1 then
				lstr_subset_ids = LUO_Subset_Functions.UF_Get_Structure()
				ls_active_subset_name = lstr_subset_ids.subset_name
				//ajs 06-30-98 4.0 fix Track#1466
				ls_active_subset_case = lstr_subset_ids.subset_case_id + lstr_subset_ids.subset_case_spl + lstr_subset_ids.subset_case_ver
				ls_active_subset_id = lstr_subset_ids.Subset_Id
	End IF
	
	If li_num_rows < 1 then
		messagebox('WARNING',' Unable to set subset id. Please try again')
		sle_key.text = gc_active_subset_name//NLG Track #1348
		return
	end if
	
	//NLG 7-15-98 security check
	li_rc = luo_subset_functions.uf_determine_case_security(ls_active_subset_case)
	if li_rc = 0 then
		gc_active_subset_name = ls_active_subset_name
		gc_active_subset_case = ls_active_subset_case
		gc_active_subset_id	 = ls_active_subset_id
	elseif li_rc = 100 then
		Messagebox('EDIT ERROR','This subset is attached to a Secured Case.  You have insufficient privileges for viewing.')
		sle_key.text = gc_active_subset_name
		return
	else
		Messagebox('EDIT ERROR','Cannot determine case security for this subset.  You may not view.')
		sle_key.text = gc_active_subset_name
		return
	end if
	
End If

Destroy(LUO_Subset_Functions)

//	09/24/02	GaryR	SPR 3323d
//rc = fx_retrieve_subset(in_subc_tables)	//NLG 12-24-97 ts145-fx_retrieve_subset.doc
rc = wf_get_invoice_types()

setfocus(sle_key)
If rc <> 0 Then
	setfocus(sle_key)
	RETURN
Else
	setmicrohelp(w_main,'Valid Subset')
End If

rc = fw_load_subset_data()
If rc <> 0 Then
	RETURN
End If

//  SET ACTIVE SUBSET
sle_active_subset.text = gc_active_subset_name
sle_active_subset_case.text = gc_active_subset_case
//gc_active_subset_name =  sle_key.text

If sle_active_subset.text = '' Then
	cb_view.enabled = FALSE
else
	cb_view.enabled = TRUE
End If


//sle_active_subset.text = gc_active_subset_name//NLG 6-18-98

//If gv_active_subset <> gv_subset_id Then
//	Messagebox('DEBUG ERROR','Active subset and id globals do not match',Exclamation!) 
//	Return
//End If
//needs correction
//UPDATE Users
//SET Active_Subset_Case = :gc_active_case_Subset
//WHERE User_Id = :gc_user_id
//Using Stars2ca;
//
// change script to fix globals ajs 4.0 02-11-98

// MikeFl 7/31/02 - Track 2824 - Begin
//UPDATE Users
//SET Active_Subset_Case = :gc_active_subset_case,
//	 active_subset_name = :gc_active_subset_name
//WHERE User_Id = Upper( :gc_user_id (
//Using Stars2ca;
//stars2ca.of_check_status()
//stars2ca.of_commit()
////ajs 4.0 end
UPDATE Users
SET Active_Subset_Case = :gc_active_subset_case,
	 active_subset_name = :gc_active_subset_name
WHERE User_Id = Upper( :gc_user_id )
Using Stars2ca;
stars2ca.of_check_status()
stars2ca.of_commit()
// MikeFl 7/31/02 - Track 2824 - End


if stars2ca.sqlcode <> 0 then
errorbox(stars2ca,'Active subset modified for this session only. Unable to update users table with new active subset')
end if
setfocus(sle_key)
end event

type cb_view from u_cb within w_subset_active
string accessiblename = "View"
string accessibledescription = "View..."
integer x = 2514
integer y = 128
integer width = 338
integer height = 108
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "&View..."
end type

event clicked;////////////////////////////////////////////////////////////////////
//
// 03/11/98	AJS	4.0 fix split of case id
//	01/29/02	LahuS	Track 2552d	Predefined Report (PDR)
//	09/24/02	GaryR	SPR 3323d	Moved to window level from global
//
////////////////////////////////////////////////////////////////////

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
int rc
If in_subset_in_what_table = 'UK' Then
	//	09/24/02	GaryR	SPR 3323d - Begin
	//rc = fx_retrieve_subset(in_subc_tables)//NLG 12-24-97 ts145 fx_retrieve_subset.doc
	//If rc <> 0 Then
	//	RETURN
	//End If
	
	IF wf_get_invoice_types() <> 0 THEN Return
	//	09/24/02	GaryR	SPR 3323d - End
End If
//gv_subset_id = sle_key.text

//  Must change to be smart enough to recognize subset type.
//gv_subset_tbl_type = 'RD'

//ajs 4.0 02-11-98
//if in_subset_in_what_table = 'SC' Then
//	gv_subset_from = 'CASE'
//	gv_case_active = gv_active_case
//Elseif in_subset_in_what_table = 'SS' Then
//	gv_subset_from = ''
//End If

gv_subset_from = ''

//
//OpenSheet(w_subset_cols,MDI_main_frame,help_menu_position,Layered!)
SX_Query_Engine_Parms Lstr_Query_Parms

//	Clear the query engine parms from previous attempts
inv_queryengine.uf_clear_query_parms()

//Get subset parms. from list
Lstr_Query_Parms.subset_id = gc_active_subset_id
Lstr_Query_Parms.subset_name = gc_active_subset_name
Lstr_Query_Parms.case_id = left(gc_active_subset_case,10)
Lstr_Query_Parms.case_spl = mid(gc_active_subset_case,11,2)
Lstr_Query_Parms.case_ver = mid(gc_active_subset_case,13,2)	// AJS   03-11-98 4.0 fix split of case id
// Set the subset parms. on nvo
inv_queryengine.uf_set_sxQueryEngineParms (Lstr_Query_Parms)	

//	01/29/02	Lahu S	Track 2552d 
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Open the query engine window
inv_queryengine.uf_open_query_engine()
end event

type st_source_type from statictext within w_subset_active
string accessiblename = "Source"
string accessibledescription = "Source"
accessiblerole accessiblerole = statictextrole!
integer y = 404
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Source:"
alignment alignment = right!
end type

type sle_subset_source_used from singlelineedit within w_subset_active
string accessiblename = "Source ID"
string accessibledescription = "Source ID"
accessiblerole accessiblerole = textrole!
integer x = 1682
integer y = 128
integer width = 800
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
textcase textcase = upper!
integer limit = 10
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

on rbuttondown;//setpointer(hourglass!)
//If rb_subset_source_from_subset.checked = false Then
//	Messagebox('EDIT','Cannot Select Subset From List If Subset Source Is Not Checked',Exclamation!)
//	setfocus(rb_subset_source_from_subset)
//	Return
//End If
//
//gv_from = 'U'
//gv_subset_tbl_type = 'RD'
//OpenSheet(w_subset_use,MDI_main_frame,help_menu_position,Layered!)
//
//
end on

type st_source from statictext within w_subset_active
string accessiblename = "Source ID"
string accessibledescription = "Source ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1234
integer y = 128
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Source ID:"
alignment alignment = right!
end type

type st_selection_criteria_key from statictext within w_subset_active
string accessiblename = "Criteria ID"
string accessibledescription = "Criteria ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1234
integer y = 312
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Criteria ID:"
alignment alignment = right!
end type

type sle_selection_criteria-key from singlelineedit within w_subset_active
string accessiblename = "Criteria ID"
string accessibledescription = "Criteria ID"
accessiblerole accessiblerole = textrole!
integer x = 1682
integer y = 312
integer width = 800
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
textcase textcase = upper!
integer limit = 10
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;//*************************************************************
// 07-12-95 FNC Commented unused code
//
// 03-11-98 JGG STARS 4.0 - TS145 Executable Changes
//
//*************************************************************
//setpointer(hourglass!)
//gv_from = 'u'
////gv_subset_tbl_type = 'RD'          //07-12-95 FNC
//OpenSheet(w_criteria_list,MDI_main_frame,help_menu_position,Layered!)
end event

on modified;trim(sle_selection_criteria-key.text)
end on

type st_description from statictext within w_subset_active
string accessiblename = "Desc"
string accessibledescription = "Desc"
accessiblerole accessiblerole = statictextrole!
integer y = 496
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Desc:"
alignment alignment = right!
end type

type st_bb-key from statictext within w_subset_active
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1234
integer y = 36
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID:"
alignment alignment = right!
end type

type cb_exit from u_cb within w_subset_active
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2514
integer y = 464
integer width = 338
integer height = 108
integer taborder = 60
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

event clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

int lv_yesno
If sle_active_subset.text <> sle_key.text Then
	lv_yesno = Messagebox('WARNING','You have not updated Active Subset. Continue?', &
									Exclamation!,YesNo!,1)
	If lv_yesno = 2 Then
		setfocus(sle_key)
		RETURN
	End if
End If


If isvalid(w_case_subset_list) Then
	close (w_case_subset_list)
End If
close (parent)



end event

type st_1 from statictext within w_subset_active
string accessiblename = "Source   Case ID"
string accessibledescription = "Source   Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1234
integer y = 220
integer width = 443
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Source Case ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_subset_active
string accessiblename = "Subset Case"
string accessibledescription = "Subset Case"
accessiblerole accessiblerole = statictextrole!
integer y = 128
integer width = 389
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Subset Case:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_active_subset_case from singlelineedit within w_subset_active
string accessiblename = "Active Subset Case"
string accessibledescription = "Active Subset Case"
accessiblerole accessiblerole = textrole!
integer x = 398
integer y = 128
integer width = 823
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
borderstyle borderstyle = styleraised!
end type

type sle_subset_case_source_used from singlelineedit within w_subset_active
string accessiblename = "Source Case ID"
string accessibledescription = "Source Case ID"
accessiblerole accessiblerole = textrole!
integer x = 1682
integer y = 220
integer width = 800
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
borderstyle borderstyle = styleraised!
end type

