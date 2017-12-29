HA$PBExportHeader$w_target_view.srw
$PBExportComments$View Targets from Target List/Case Folder View Button (inherited from w_master)
forward
global type w_target_view from w_master
end type
type cb_retrieve from u_cb within w_target_view
end type
type sle_case_id from singlelineedit within w_target_view
end type
type st_subset_id from statictext within w_target_view
end type
type st_3 from statictext within w_target_view
end type
type st_datetime from statictext within w_target_view
end type
type sle_datetime from singlelineedit within w_target_view
end type
type sle_description from singlelineedit within w_target_view
end type
type st_desc from statictext within w_target_view
end type
type st_row_count from statictext within w_target_view
end type
type cb_stop from u_cb within w_target_view
end type
type cb_close from u_cb within w_target_view
end type
type st_link_name from statictext within w_target_view
end type
type st_4 from statictext within w_target_view
end type
type cb_list_targets from u_cb within w_target_view
end type
type st_2 from statictext within w_target_view
end type
type sle_subset_id from singlelineedit within w_target_view
end type
type cb_notes from u_cb within w_target_view
end type
type dw_1 from u_dw within w_target_view
end type
type sle_target_id from singlelineedit within w_target_view
end type
type st_1 from statictext within w_target_view
end type
type ddlb_track_type from u_ddlb within w_target_view
end type
type gb_main from groupbox within w_target_view
end type
end forward

global type w_target_view from w_master
string accessiblename = "Case Target Details"
string accessibledescription = "Case Target Details"
accessiblerole accessiblerole = windowrole!
integer x = 169
integer y = 0
integer width = 2926
integer height = 2084
string title = "Case Target Details"
long backcolor = 67108864
event case_dept pbm_custom01
cb_retrieve cb_retrieve
sle_case_id sle_case_id
st_subset_id st_subset_id
st_3 st_3
st_datetime st_datetime
sle_datetime sle_datetime
sle_description sle_description
st_desc st_desc
st_row_count st_row_count
cb_stop cb_stop
cb_close cb_close
st_link_name st_link_name
st_4 st_4
cb_list_targets cb_list_targets
st_2 st_2
sle_subset_id sle_subset_id
cb_notes cb_notes
dw_1 dw_1
sle_target_id sle_target_id
st_1 st_1
ddlb_track_type ddlb_track_type
gb_main gb_main
end type
global w_target_view w_target_view

type variables
string in_from
string in_case_dept
Boolean in_cancel
String in_target_key,in_target_status
string in_targets_removed 

// message.stringparm
String	is_parm

string is_subset_id //1-14-98 NLG 4.0
string is_subset_name
end variables

forward prototypes
public function integer wf_retrieve_subset_name ()
public function integer wf_retrieve_subset_id ()
end prototypes

event case_dept;//***************************************************************
//08-31-98	NLG 	FS362	convert case to case_cntl
//10-20-95 	FNC 			Take out connects and disconnects
//***************************************************************
string lv_case_id,lv_case_spl,lv_case_ver
string lv_case_cat

lv_case_id  = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

//08-31-98 NLG FS362 convert case to case_cntl
String ls_track_type
Select case_trk_type,case_cat
	into :ls_track_type,:lv_case_cat
	from Case_cntl
	where case_id =  Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in case_dept')
   end if                            // 10-20-95 FNC End
	setmicrohelp(w_main,'Case is not found')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Reading Case Table')
	Close(this)
	RETURN
End If

Commit using stars2ca;
ddlb_track_type.SelectItem(ls_track_type,0)

Select  code_value_a
	into :in_case_dept
	from  code
	where code_type = 'CA' and
			code_code = Upper( :lv_case_cat )
using stars2ca;
If stars2ca.of_check_status() = 100 then 
	Errorbox(stars2ca,'Case Category Code not Found')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Reading Code Table for Category Codes')
	RETURN
End If

Commit using stars2ca;


end event

public function integer wf_retrieve_subset_name ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	wf_retrieve_subset_name					w_target_view
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	 call nvo_subset_functions to retrieve external subset id.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Success			
//						-1				Error
/////////////////////////////////////////////////////////////////////////////
//
//	01/15/97	Naomi	Created.
//	03/11/98	AJS	Fix split of case id
//	05/15/03	GaryR	Track 3578d	Populate subset_id static text with Link Name
//
/////////////////////////////////////////////////////////////////////////////

long ll_rows
integer li_return
sx_subset_ids lstr_Subset_Ids
nvo_subset_functions lnv_subset_functions
u_nvo_subset lnv_subset

lnv_subset_functions = create nvo_subset_functions

//Set up the structure
lstr_Subset_Ids.Subset_Id = IS_Subset_Id
lstr_Subset_Ids.Subset_Case_Id = left(sle_case_id.text,10)
lstr_Subset_Ids.Subset_Case_Spl = mid(sle_case_id.text,11,2)
lstr_Subset_Ids.Subset_Case_Ver= mid(sle_case_id.text,13,2)	// AJS   03-11-98 4.0 fix split of case id

//Set up the structure for the nvo
LNV_Subset_Functions.UF_Set_Structure(Lstr_Subset_Ids)

//call the nvo to retrieve the subset name
ll_rows = Lnv_Subset_Functions.UF_Retrieve_Subset_Name()

If ll_rows = 1 then
	Lstr_subset_ids = Lnv_Subset_Functions.UF_Get_Structure()
	Is_subset_name = lstr_Subset_ids.subset_name
	sle_subset_id.text = trim(is_subset_name)
	st_subset_id.text = is_subset_id
	li_return = 0
Else
	Messagebox('ERROR','Cannot retrieve subset name.~r'+&
					'Cannot display subset id') 
	li_Return = -1
End if

if isValid(lnv_subset_functions) then destroy lnv_subset_functions

return li_return
end function

public function integer wf_retrieve_subset_id ();/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	wf_retrieve_subset_id					w_target_view
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
//	Call nvo_subset_functions to retrieve internal subset id
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument			Datatype				Description
//		---------	--------			--------				-----------
//		None
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		Integer		0				Success			
//					   -1 			Error
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
// AJS   			03-11-98 	4.0 fix split of case id
//	Naomi				1-15-98		Created.
/////////////////////////////////////////////////////////////////////////////

sx_subset_ids Lstr_Subset_Ids
nvo_subset_functions lnv_subset_functions
integer li_return
long ll_rows

lnv_subset_functions = create nvo_subset_functions

//Set up the structure
Lstr_Subset_Ids.Subset_Name = Sle_Subset_Id.Text
Lstr_Subset_Ids.subset_Case_Id = left(sle_case_id.text,10)
Lstr_Subset_Ids.subset_Case_Spl = mid(sle_case_id.text,11,2)
Lstr_Subset_Ids.subset_Case_Ver= mid(sle_case_id.text,13,2) // AJS   03-11-98 4.0 fix split of case id

//Call the appropriate functions

LNV_Subset_Functions.UF_Set_Structure(Lstr_Subset_Ids)

LL_rows = Lnv_Subset_Functions.UF_Retrieve_Subset_ID()

If ll_rows = 1 then
	Lstr_subset_ids = LNV_Subset_Functions.UF_Get_Structure()
	Is_Subset_Id = lstr_Subset_ids.subset_id
	li_Return = 0
Else
	Messagebox('ERROR','Cannot retrieve subset id.') 
	is_subset_id = '' 
	li_Return = -1
End if

if isValid(lnv_subset_functions) then destroy lnv_Subset_functions

return li_return
end function

event close;call super::close;gv_case_target = ''
//gv_case_subset = ''		//ajs 4.0 03-11-98 TS145-fix globals
gv_target_subset_id = ''	//ajs 4.0 03-11-98 TS145-fix globals
end event

event open;call super::open;//*****************************************************************************
//Modifications:
//	1-15-98 	NLG 	4.0 		Subset Redesign. Display Subset Name rather than Subset Id
// 08/08/02	MikeF	3239d		Made the following changes:
//									* Changed sle_case_id to static text.
//									* Added Subset ID display control. Modified existing for CASE_LINK
// JasonS 10/29/02 Track 4055c Placed cb_retrieve code in ue_retrieve and deleted
//						 cb_retrieve.
// JasonS 02/27/03 Track 4055c added the cb_retrieve button back in
//*****************************************************************************
int li_pos, li_rc

Setpointer(Hourglass!)
SETMICROHELP(w_main,'Ready')
in_from = gv_from
if trim(is_parm) = '' or isNull(is_parm) then	
	If trim(gv_active_case) = '' then	//ajs 4.0 03-11-98 TS145-fix globals
		Messagebox('EDIT','No active Case exists')
		cb_close.PostEvent(Clicked!)
	End If		
	sle_case_id.text 	= trim(gv_active_case)		//ajs 4.0 03-11-98 TS145-fix globals
	sle_target_id.text = trim(gv_case_target)
else													
	li_pos = pos(is_parm,'~~')		
	sle_case_id.text = left(is_parm,li_pos - 1)	
	sle_target_id.text = mid(is_parm,li_pos + 1)	
end if

is_Subset_Id = gv_target_subset_id	//ajs 4.0 03-11-98

if trim(is_subset_id) <> '' then 	//NLG 6-30-98 Track #1459
	st_subset_id.text = is_subset_id		// MikeFl 8/8/02 Track 3239 
	li_rc = wf_Retrieve_subset_Name()
	if li_rc <> 0 then return
ELSE												// MikeFl 8/8/02 Track 3239 
	st_subset_id.text = "None"				// MikeFl 8/8/02 Track 3239 
end if										//NLG 6-30-98 Track #1459
If in_from = 'M'  or in_from = 'VIEW' then
	triggerevent("ue_retrieve")	// JasonS 10/29/02 Track 4055c
Else
	setmicrohelp(w_main,'Unable to Establish Entry')
End If
setpointer(arrow!)
end event

on w_target_view.create
int iCurrent
call super::create
this.cb_retrieve=create cb_retrieve
this.sle_case_id=create sle_case_id
this.st_subset_id=create st_subset_id
this.st_3=create st_3
this.st_datetime=create st_datetime
this.sle_datetime=create sle_datetime
this.sle_description=create sle_description
this.st_desc=create st_desc
this.st_row_count=create st_row_count
this.cb_stop=create cb_stop
this.cb_close=create cb_close
this.st_link_name=create st_link_name
this.st_4=create st_4
this.cb_list_targets=create cb_list_targets
this.st_2=create st_2
this.sle_subset_id=create sle_subset_id
this.cb_notes=create cb_notes
this.dw_1=create dw_1
this.sle_target_id=create sle_target_id
this.st_1=create st_1
this.ddlb_track_type=create ddlb_track_type
this.gb_main=create gb_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_retrieve
this.Control[iCurrent+2]=this.sle_case_id
this.Control[iCurrent+3]=this.st_subset_id
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_datetime
this.Control[iCurrent+6]=this.sle_datetime
this.Control[iCurrent+7]=this.sle_description
this.Control[iCurrent+8]=this.st_desc
this.Control[iCurrent+9]=this.st_row_count
this.Control[iCurrent+10]=this.cb_stop
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.st_link_name
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.cb_list_targets
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.sle_subset_id
this.Control[iCurrent+17]=this.cb_notes
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.sle_target_id
this.Control[iCurrent+20]=this.st_1
this.Control[iCurrent+21]=this.ddlb_track_type
this.Control[iCurrent+22]=this.gb_main
end on

on w_target_view.destroy
call super::destroy
destroy(this.cb_retrieve)
destroy(this.sle_case_id)
destroy(this.st_subset_id)
destroy(this.st_3)
destroy(this.st_datetime)
destroy(this.sle_datetime)
destroy(this.sle_description)
destroy(this.st_desc)
destroy(this.st_row_count)
destroy(this.cb_stop)
destroy(this.cb_close)
destroy(this.st_link_name)
destroy(this.st_4)
destroy(this.cb_list_targets)
destroy(this.st_2)
destroy(this.sle_subset_id)
destroy(this.cb_notes)
destroy(this.dw_1)
destroy(this.sle_target_id)
destroy(this.st_1)
destroy(this.ddlb_track_type)
destroy(this.gb_main)
end on

event ue_preopen;call super::ue_preopen;is_parm = message.stringparm					//KMM 9/26/95 Prob#1102

end event

event ue_retrieve;call super::ue_retrieve;//*******************************************************************
//08-31-98 NLG FS362 convert case to case_cntl
//01-15-98 NLG 4.0 subset Redesign
//					Display external subset id rather than internal subset id
//10-20-95 FNC Take out connects and disconnects
//06-20-95 FNC add track type as an argument so that it can be selected and used 
//             when fx_insert_track is called in the cb_create_button
// JasonS 10/24/02 Track 4055c call n_cst_labels
//	03/15/07	Katie	SPR 4946 Corrected values populated in st_subset_id
//*******************************************************************
String lv_case_id,lv_case_spl,lv_case_ver, ls_track_type, ls_datetime
int li_rc
datetime ldte_datetime
date ldt_date
n_cst_labels lnv_labels		// JasonS 10/24/02 Track 4055c

SETPOINTER(HOURGLASS!)
SETMICROHELP(W_MAIN,'Ready')

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

If trim(sle_target_id.text) = '' and &
	trim(sle_subset_id.text) = '' then
	Messagebox('EDIT','Must Enter a Target Id or Subset Id for this Case')
	Setfocus(sle_target_id)
	RETURN
End If

reset(dw_1)
st_row_count.text = ''
If (sle_target_id.text) <> '' then
	select subc_id, trgt_datetime,trgt_desc, trgt_type
	 	into :is_subset_id,	// :sle_subset_id.text 1-15-98 NLG 4.0
		 		 //:sle_datetime.text,
				 :ldte_datetime,
				 :sle_description.text,
				 :ls_track_type //11-04-99 AJS 4.5
		from target_cntl
		where case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver ) and
				trgt_id  = Upper( :sle_target_id.text )
	Using stars2ca;
	If stars2ca.of_check_status() = 100 then
		If is_subset_id = '' then // sle_subset_id.text 1-15-98 NLG 4.0
         COMMIT using stars2ca;
         if stars2ca.of_check_status() <> 0 then
            messagebox('ERROR','Error performing commit in cb_retrieve')
         end if                            // 10-20-95 FNC End
			Messagebox('EDIT','No Targets Found - Check Target/Subset Id or Select Target List')
			setfocus(sle_target_id)
			cb_list_targets.default = true
			RETURN
		End IF
	Elseif stars2ca.sqlcode <> 0 then
			 Errorbox(stars2ca,'Error Reading Target Control')
			 RETURN
	End IF
	if trim(is_subset_id) <> '' then				//NLG 6-30-98 Track #1459
		li_rc = wf_retrieve_subset_name()
		if li_rc <> 0 then return
	end if												//NLG 6-30-98 Track #1459
End If



If sle_subset_id.text <> '' and sle_target_id.text = '' then
	Li_rc = WF_Retrieve_Subset_Id()		//1-15-98 NLG 4.0	
	If li_rc <> 0 then
		Messagebox('ERROR','Cannot retrieve target id because '+&
						'error converting subset id.')
		Return
	End if						

	select trgt_id,trgt_datetime,trgt_desc, trgt_type
	 	into :sle_target_id.text,
		 :ldte_datetime,
		 //:sle_datetime.text,
		 :sle_description.text,
		 :ls_track_type
		from target_cntl
		where case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver ) and
				subc_id  = Upper( :is_subset_id )	//:sle_subset_id.text  1-15-98 NLG 4.0
	Using stars2ca;
	If stars2ca.of_check_status() = 100 then
      COMMIT using stars2ca;
      if stars2ca.of_check_status() <> 0 then
         messagebox('ERROR','Error performing commit in cb_retrieve')
      end if                            // 10-20-95 FNC End
		Messagebox('EDIT','No Targets Found - Check Target/Subset Id or Select Target List')
		setfocus(sle_target_id)
		cb_list_targets.default = true
		RETURN
	Elseif stars2ca.sqlcode <> 0 then
			 Errorbox(stars2ca,'Error Reading Target Control')
			 RETURN
	End IF
End IF

ddlb_track_type.SelectItem(ls_track_type,0)
Commit using stars2ca;

If settransobject(dw_1,stars2ca) < 0 then
	Errorbox(stars2ca,'Error Setting Transaction Object')
	RETURN
End If

//06-20-95 FNC Start
st_row_count.text = &
string(dw_1.retrieve(sle_target_id.text,LV_CASE_ID,LV_CASE_SPL,LV_CASE_VER,ddlb_track_type.text))
//06-20-95 FNC End

// JasonS 10/29/02 Begin - Track 4055c
lnv_labels = create n_cst_labels
lnv_labels.of_setdw(dw_1)
lnv_labels.of_trk_info_width( trim(ddlb_track_type.text) )
// JasonS 10/29/02 End - Track 4055c


COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in cb_retrieve')
   return
end if                            // 10-20-95 FNC End
If long(st_row_count.text) < 0 then
	st_row_count.text = '0'
	Messagebox('EDIT','Error Retrieving Target Data')
Elseif integer(st_row_count.text) = 0 then
	 	setmicrohelp(w_main,'No Target Keys for this Target Id')
End If

// SAH 04/05/02
ldt_date = Date(ldte_datetime)
sle_datetime.Text = String(ldt_date)


cb_close.default = true
destroy lnv_labels	// JasonS 10/24/02 Track 4055c
setpointer(arrow!)
end event

type cb_retrieve from u_cb within w_target_view
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 352
integer y = 1848
integer width = 421
integer height = 108
integer taborder = 100
integer weight = 400
string text = "&Retrieve"
end type

event clicked;call super::clicked;parent.triggerevent("ue_retrieve")
end event

type sle_case_id from singlelineedit within w_target_view
long backcolor = 1073741824
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 12
integer width = 635
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_subset_id from statictext within w_target_view
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1463
integer y = 224
integer width = 553
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_target_view
string accessiblename = "Subset Key"
string accessibledescription = "Subset Key"
accessiblerole accessiblerole = statictextrole!
integer x = 1061
integer y = 224
integer width = 370
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset Key:"
boolean focusrectangle = false
end type

type st_datetime from statictext within w_target_view
string accessiblename = "Created Date"
string accessibledescription = "Created"
accessiblerole accessiblerole = statictextrole!
integer x = 1061
integer y = 116
integer width = 242
integer height = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Created:"
boolean focusrectangle = false
end type

type sle_datetime from singlelineedit within w_target_view
string accessiblename = "Date Time"
string accessibledescription = "Date Time"
accessiblerole accessiblerole = textrole!
integer x = 1463
integer y = 116
integer width = 535
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
boolean displayonly = true
end type

type sle_description from singlelineedit within w_target_view
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 348
integer width = 2455
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
boolean displayonly = true
end type

type st_desc from statictext within w_target_view
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 348
integer width = 370
integer height = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
boolean focusrectangle = false
end type

type st_row_count from statictext within w_target_view
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 23
integer y = 1860
integer width = 128
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
string text = " "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_stop from u_cb within w_target_view
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1326
integer y = 1620
integer width = 338
integer height = 108
integer taborder = 10
integer weight = 400
boolean enabled = false
string text = "S&top"
end type

type cb_close from u_cb within w_target_view
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2469
integer y = 1848
integer width = 338
integer height = 108
integer taborder = 90
integer weight = 400
string text = "&Close"
end type

on clicked;SETPOINTER(HOURGLASS!)
SETMICROHELP(W_MAIN,'Ready')

close(parent)
end on

type st_link_name from statictext within w_target_view
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 224
integer width = 347
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_target_view
string accessiblename = "Target ID"
string accessibledescription = "Target ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1061
integer y = 12
integer width = 293
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Target ID:"
boolean focusrectangle = false
end type

type cb_list_targets from u_cb within w_target_view
string accessiblename = "List Target"
string accessibledescription = "List Target..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 869
integer y = 1848
integer width = 421
integer height = 108
integer taborder = 70
integer weight = 400
string text = "&List Target..."
end type

on clicked;setpointer (hourglass!)
SETMICROHELP(W_MAIN,'Ready')
OpenSheet(w_target_list,MDI_main_frame,help_menu_position,Layered!)
CLOSE(PARENT)
end on

type st_2 from statictext within w_target_view
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 116
integer width = 347
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Track Type:"
boolean focusrectangle = false
end type

type sle_subset_id from singlelineedit within w_target_view
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = textrole!
integer x = 375
integer y = 224
integer width = 635
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type cb_notes from u_cb within w_target_view
string accessiblename = "Notes"
string accessibledescription = "Notes..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1710
integer y = 1848
integer width = 338
integer height = 108
integer taborder = 80
integer weight = 400
string text = "&Notes..."
end type

event clicked;//*************************************************************
//10-20-95 	FNC 			Take out connects and disconnects
//05-12-98 	NLG 			replace notes globals with notes nvo
//08-31-98 	NLG 	FS362 convert case to case_cntl
//*************************************************************

datetime lv_datetime
string lv_case_id,lv_case_spl,lv_case_ver

Setpointer(Hourglass!)
setmicrohelp(w_main,'Ready')

lv_case_id = left(sle_case_id.text,10)
lv_case_spl = mid(sle_case_id.text,11,2)
lv_case_ver = mid(sle_case_id.text,13,2)

//08-31-98 NLG FS362 convert case to case_cntl
select case_datetime into :lv_datetime
		from case_cntl
		where case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
using stars2ca;
If stars2ca.of_check_status() = 100 then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      messagebox('ERROR','Error performing commit in cb_notes')
   end if                           //  10-20-95 FNC End
	Messagebox ('EDIT','Case Must exist on Database to add a NOTE')
	RETURN
Elseif stars2ca.sqlcode <> 0 then
			Errorbox(stars2ca,'Error Reading Case Database')
			RETURN
End If

COMMIT using stars2ca;
if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca,'Error performing commit in cb_notes')
   return
end if                            // 10-20-95 FNC End
n_cst_notes lnv_notes

lnv_notes.is_notes_from    = 'CA'
lnv_notes.is_notes_rel_id 	= sle_case_id.text	
lnv_notes.idt_notes_date   = date(lv_datetime)
OpenSheetWithParm(W_NOTES_LIST,lnv_notes,MDI_main_frame,help_menu_position,Layered!)

SETPOINTER(ARROW!)

end event

type dw_1 from u_dw within w_target_view
string accessiblename = "Case Target Details"
string accessibledescription = "Case Target Details"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Target Details"
integer y = 448
integer width = 2853
integer height = 1280
integer taborder = 50
string dataobject = "d_target_maint_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

on rowfocuschanged;long lv_row_nbr

If not in_cancel then 
	RETURN
End If

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
lv_row_nbr = getrow(dw_1)
If lv_row_nbr = 0 then 
	lv_row_nbr = 1
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

in_target_key = getitemstring(dw_1,lv_row_nbr,1)
in_target_status = getitemstring(dw_1,lv_row_nbr,2)
end on

on retrieveend;
cb_stop.enabled = false
//in_cancel = true
triggerevent(dw_1,rowfocuschanged!)
end on

on retrievestart;Setpointer(hourglass!)
cb_stop.enabled = true
end on

event doubleclicked;long lv_row_nbr

If not in_cancel then 
	RETURN
End If

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
lv_row_nbr = row
If lv_row_nbr = 0 then 
	lv_row_nbr = 1
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

in_target_key = getitemstring(dw_1,lv_row_nbr,1)
in_target_status= getitemstring(dw_1,lv_row_nbr,2)
end event

type sle_target_id from singlelineedit within w_target_view
string accessiblename = "Target ID"
string accessibledescription = "Target ID"
accessiblerole accessiblerole = textrole!
integer x = 1463
integer y = 12
integer width = 553
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_target_view
string accessiblename = "Case ID"
string accessibledescription = "Case ID"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 12
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Case ID:"
boolean focusrectangle = false
end type

type ddlb_track_type from u_ddlb within w_target_view
string accessiblename = "Track Type"
string accessibledescription = "Track Type"
long textcolor = 33554432
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 375
integer y = 116
integer width = 635
integer taborder = 20
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
boolean enabled = false
boolean vscrollbar = false
string item[] = {"PV - Provider","PC - Procedure","BE - Patient","RV - Revenue"}
borderstyle borderstyle = styleraised!
end type

type gb_main from groupbox within w_target_view
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer y = 376
integer width = 2784
integer height = 364
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 134217741
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

