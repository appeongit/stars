HA$PBExportHeader$w_target_maintain.srw
$PBExportComments$Inherited from w_target_subset_maintain
forward
global type w_target_maintain from w_target_subset_maintain
end type
type st_target_key from statictext within w_target_maintain
end type
type sle_target_key from singlelineedit within w_target_maintain
end type
type cb_clear from u_cb within w_target_maintain
end type
type cb_insert from u_cb within w_target_maintain
end type
type cb_delete from u_cb within w_target_maintain
end type
type gb_1 from groupbox within w_target_maintain
end type
end forward

global type w_target_maintain from w_target_subset_maintain
string accessiblename = "Case Target Add"
string accessibledescription = "Case Target Add"
integer width = 3310
integer height = 1888
string title = "Case Target Add"
event ue_set_mod_availability ( boolean ab_switch )
event ue_set_update_availability ( )
st_target_key st_target_key
sle_target_key sle_target_key
cb_clear cb_clear
cb_insert cb_insert
cb_delete cb_delete
gb_1 gb_1
end type
global w_target_maintain w_target_maintain

type variables
//string in_case_business

// Stars 4.8 - Case NVO
n_cst_case	inv_case

// 12/9/04 JasonS Track 3664 Case Component Update
string is_comp_upd_status
end variables

event ue_set_mod_availability(boolean ab_switch);//*********************************************************************************
// Script Name:	ue_set_mod_availability
//
//	Arguments:		boolean - specifying to enable or disable
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for modifying 
//						the case target component.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//	02/21/07 Katie	SPR 4763 Fixed issue with enabling disabling ddlb_track_by
// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons
//*********************************************************************************

cb_insert.enabled = ab_switch
sle_target_key.enabled = ab_switch
cb_remove.enabled = ab_switch
cb_clear.enabled = ab_switch
cb_create.enabled = ab_switch
sle_case_id.enabled = ab_switch
ddlb_track_type.enabled = ab_switch
sle_description.enabled = ab_switch
sle_subset_id.enabled = ab_switch
if (left(ddlb_track_type.text,2) <> 'PV') then 
	ddlb_track_by.enabled = False
else
	ddlb_track_by.enabled = ab_switch
end if
end event

event ue_set_update_availability();//*********************************************************************************
// Script Name:	ue_set_update_availability
//
//	Arguments:		None
//
// Returns:			None
//
//	Description:	This method will enable or disable objects needed for the case
//						target component based on the update status returned from
//						n_cst_case.
//
//*********************************************************************************
//
//	12/06/04	JasonS	Track 3664	Created.
//*********************************************************************************


String ls_case_id
String ls_case_spl
String ls_case_ver


ls_case_id	=	Left (sle_case_id.text, 10)
ls_case_spl	=	Mid (sle_case_id.text, 11, 2)
ls_case_ver	=	Mid (sle_case_id.text, 13, 2)


is_comp_upd_status = inv_case.uf_get_comp_upd_status('CASETRACK', ls_case_id , ls_case_spl, ls_case_ver)

choose case is_comp_upd_status 
	case 'AO'
		this.event ue_set_mod_availability(true)
	case 'RO'
		this.event ue_set_mod_availability(false)
	case 'AL'
		this.event ue_set_mod_availability(true)
end choose


end event

event open;//******************************************************************
//	Script:	Open - Override w_target_subset_maintain.open
//
//******************************************************************
//10-20-95 FNC Take out connects and disconnects
//06-20-95 FNC Set in_proc_code_lookup to PC so that it is passed to
//             FX_INSERT_TRACK in the create button of w_target_subset_maintian
//08-31-98 NLG FS362 convert case to case_cntl
//09/21/01 FDG	Stars 4.8.1.	No updates can occur if the case is closed
//02/28/02 FDG	Track 2847d. Limit the length of sle_target_key based on
//					the length of column trk_key (table track).
// 07/30/02 JasonS Track 3188d Fix GPF
// JasonS 09/04/02 Track 3247d  Default track type to that of case type
// JasonS 10/29/02 Track 4055c call ue_retrieve, not cb_retrieve
// JasonS 10/15/04 Use gnv_dict instead of lnv_dict
// JasonS 12/17/05 Track 4588d  If case_type is user-defined, force them to select a track type
// Katie	11/20/2006 SPR 4763 Add logic to populate the prov id type drop-down.
// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//******************************************************************

String lv_subset,lv_target,lv_case_cat
String lv_sql_statement
Long lv_target_id
String lv_case_id,lv_case_spl,lv_case_ver
Boolean lv_targets_exist
String  lv_error,lv_style,lv_syntax
int  lv_result
string ls_case_type	// JasonS 09/04/02 Track 3247d
int li_index	// JasonS 09/04/02 Track 3247d

// FDG 02/28/02 - limit length of sle_target_key based on length of track.trk_key
String		ls_inv_type
Integer		li_data_len

Setpointer(Hourglass!)

// JasonS 07/30/02 Begin - Track 3188d
inv_subset_functions = create nvo_subset_functions
// JasonS 07/30/02 End - Track 3188d

//	Call w_master.open script since this overrides ancestor
Call	w_master::Open
this.of_set_sys_cntl_range(TRUE)//ts2020c used to get default server date
//fx_set_window_colors(w_target_maintain)
SETMICROHELP(w_main,'Ready')
//Need to set this rb cos in w_target_subset_maintain for track type 
// providers it must have a rb checked and this window is only by PIN
// for track type Providers
if gv_npi_cntl = 0 then 
	ddlb_track_by.InsertItem('PROV_ID',1)
	ddlb_track_by.InsertItem('PROV_UPIN',2)
	ddlb_track_by.SelectItem('PROV_ID',1)
elseif gv_npi_cntl = 1 then 	
	ddlb_track_by.InsertItem('PROV_ID',1)
	ddlb_track_by.InsertItem('PROV_UPIN',2)
	ddlb_track_by.InsertItem('PROV_NPI',3)
	ddlb_track_by.SelectItem('PROV_ID',1)
end if

inv_case	=	CREATE	n_cst_case				// FDG 09/21/01

ls_inv_type	=	gnv_dict.Event	ue_get_inv_type ('TRACK')
li_data_len	=	gnv_dict.Event	ue_get_data_len (ls_inv_type, 'TRK_KEY')

IF	li_data_len	>	0		THEN
	sle_target_key.limit	=	li_data_len
END IF
// FDG 02/28/02 end

in_from = gv_from
sle_case_id.text = trim(gv_active_case)		//ajs 4.0 03-11-98 ts145-fix globals
sle_target_id.text = trim(gv_case_target)
If sle_case_id.text = '' then
	Messagebox('EDIT','No active Case exists')
   cb_close.PostEvent(Clicked!)
	RETURN
End If

lv_case_id = left(gv_active_case,10)		//ajs 4.0 03-11-98 TS145-globals
lv_case_spl = mid(gv_active_case,11,2)		//ajs 4.0 03-11-98 TS145-globals
lv_case_ver = mid(gv_active_case,13,2)		//ajs 4.0 03-11-98 TS145-globals

//08-31-98 NLG FS362 convert case to case_cntl
//JasonS 4588d - changed case_track_type to case_type
String ls_track_type
Select case_type,case_business
	 into :ls_track_type,:in_case_business
	from case_cntl
	where case_id  = Upper( :lv_case_id ) and
			case_spl = Upper( :lv_case_spl ) and
			case_ver = Upper( :lv_case_ver )
Using stars2ca;
If stars2ca.of_check_status() = 100 then
      if stars2ca.of_commit() <> 0 then
         messagebox('ERROR','Error performing commit in open')
      end if                             //10-20-95 FNC End
		setmicrohelp(w_main,'Case Does Not Exist')
      cb_close.PostEvent(Clicked!)
		RETURN
Elseif stars2ca.sqlcode <> 0 then
		Errorbox(stars2ca,'Error Reading Case Control Table')
		cb_close.PostEvent(Clicked!)
		RETURN
End If
ddlb_track_type.SelectItem(ls_track_type,0)

    
//Coming in from View Folder ADD/SELECT unsure whether targets/track exist
//Either gv_target_subset_id or gv_case_target will have data, won't be in both
//Can also come in from Menu with gv_from = 'MENU'

If gv_case_target <> '' then
	Select trgt_datetime,trgt_desc,trgt_type
		into :sle_datetime.text,:sle_description.text,:ls_track_type
		from target_cntl
		where trgt_id  = Upper( :sle_target_id.text ) and
				case_id  = Upper( :lv_case_id ) and
				case_spl = Upper( :lv_case_spl ) and
				case_ver = Upper( :lv_case_ver )
	Using stars2ca;
	If stars2ca.of_check_status() = 100 then
			cb_delete.enabled = false
			cb_create.enabled = false
			st_row_count.text = ''
			dw_1.taborder     = 0
			Goto Create_targets
	Elseif stars2ca.sqlcode <> 0 then
		Errorbox(stars2ca,'Error Reading Target Table')
		cb_close.PostEvent(Clicked!)
		RETURN
	Else
		lv_targets_exist = true
		ddlb_track_type.SelectItem(ls_track_type,0)
	End If
Else
      if stars2ca.of_commit() <> 0 then
         messagebox('ERROR','Error performing commit in open')
      end if                             //10-20-95 FNC End
		setmicrohelp(w_main,'Target Id not linked to Case')
		cb_close.PostEvent(Clicked!)
		RETURN
End If

If lv_targets_exist then
   COMMIT using stars2ca;
   if stars2ca.of_check_status() <> 0 then
      errorbox(stars2ca,'Error performing commit in open')
      return
   end if                             //10-20-95 FNC End
	triggerevent("ue_retrieve")	// JasonS 10/29/02 Track 4055c
	in_track_created = true
	cb_create.enabled = false
	cb_split.enabled  = false
	cb_remove.enabled = false
	cb_insert.visible	= false
	gb_1.visible      = false
	cb_delete.enabled = false
	cb_clear.enabled  = false
	sle_target_id.enabled = false
	sle_description.enabled = false
	sle_target_key.visible = false
	st_target_key.visible  = false
	cb_close.default = true
	this.title = 'Case Target View'
	// FDG 09/21/01 - No updates can occur if the case is closed/deleted
	RETURN
End If

//Coming in to Add Targets and Tracks they do not exist and 
//a subset has been linked 
Create_Targets:
sle_datetime.text = inv_sys_cntl.of_get_default_date()//ts2020c use server date, not pc date
Setfocus(SLE_DESCRIPTION)

if stars2ca.of_commit() <> 0 then
   errorbox(stars2ca,'Error performing commit in open')
   return
end if                             //10-20-95 FNC End
cb_insert.DEFAULT = TRUE

// FDG 09/21/01 - No updates can occur if the case is closed/deleted

// JasonS 07/30/02 Begin - Track 3188d
is_subset_id = gv_target_subset_id
istr_subset_ids.subset_id = is_subset_id
istr_subset_ids.subset_case_id = lv_case_id
istr_subset_ids.subset_case_spl = lv_case_spl
istr_subset_ids.subset_case_ver = lv_case_ver
// JasonS 07/30/02 End - Track 3188d

If left(ddlb_track_type.text,2) <> 'PV' then
	ddlb_track_by.enabled = false
else 
	ddlb_track_by.enabled = true
End IF
end event

event close;call super::close;// JasonS 11/26/02 Track 3374d  Case Performance

gv_from = ''
//retrieve tracks on case maintain when adding a new track
if isvalid(w_case_maint) then
	//w_case_maint.triggerevent("ue_get_case")
	w_case_maint.triggerevent("ue_refresh_case")	// JasonS 11/26/02 Track 3374d
end if

// FDG 09/21/01	Stars 4.8.1  Destroy inv_case
IF	IsValid(inv_case)		THEN
	Destroy	inv_case
END IF

end event

on w_target_maintain.create
int iCurrent
call super::create
this.st_target_key=create st_target_key
this.sle_target_key=create sle_target_key
this.cb_clear=create cb_clear
this.cb_insert=create cb_insert
this.cb_delete=create cb_delete
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_target_key
this.Control[iCurrent+2]=this.sle_target_key
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.gb_1
end on

on w_target_maintain.destroy
call super::destroy
destroy(this.st_target_key)
destroy(this.sle_target_key)
destroy(this.cb_clear)
destroy(this.cb_insert)
destroy(this.cb_delete)
destroy(this.gb_1)
end on

event ue_edit_case_closed;//*******************************************************************
//	Script			ue_edit_case_closed - Override ancestor
//
//
//	Description		Prevent updating this window if the case is closed
//						or deleted.
//
//
//*******************************************************************
//	09/21/01	FDG	Stars 4.8.1.	Created
// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons
//*******************************************************************

Boolean		lb_valid_case

lb_valid_case	=	inv_case.uf_edit_case_closed (sle_case_id.text)

IF	lb_valid_case	=	FALSE		THEN
	cb_create.enabled = false
	cb_split.enabled  = false
	cb_remove.enabled = false
	cb_insert.visible = false
	gb_1.visible      = false
	cb_delete.enabled = false
	cb_clear.enabled  = false
	sle_target_id.enabled = false
	sle_description.enabled = false
	sle_target_key.visible = false
	st_target_key.visible  = false
	cb_close.default = true
END IF


end event

event ue_postopen;call super::ue_postopen;// 12/9/04 JasonS Track 3664 Case Component UPdate
this.event ue_set_update_availability()

end event

type cb_retrieve from w_target_subset_maintain`cb_retrieve within w_target_maintain
end type

type sle_case_id from w_target_subset_maintain`sle_case_id within w_target_maintain
integer x = 407
integer y = 32
integer height = 84
end type

type st_subset_id from w_target_subset_maintain`st_subset_id within w_target_maintain
boolean visible = false
integer x = 1408
integer y = 124
integer height = 84
string text = "None"
end type

type st_3 from w_target_subset_maintain`st_3 within w_target_maintain
boolean visible = false
integer height = 72
end type

type st_datetime from w_target_subset_maintain`st_datetime within w_target_maintain
integer x = 1161
integer y = 160
integer height = 72
end type

type sle_datetime from w_target_subset_maintain`sle_datetime within w_target_maintain
integer x = 1477
integer y = 160
integer width = 553
integer height = 84
string pointer = "`"
end type

type sle_description from w_target_subset_maintain`sle_description within w_target_maintain
integer x = 407
integer y = 288
integer width = 2455
integer taborder = 30
integer weight = 400
boolean displayonly = false
end type

type st_desc from w_target_subset_maintain`st_desc within w_target_maintain
integer y = 288
integer height = 72
end type

type st_row_count from w_target_subset_maintain`st_row_count within w_target_maintain
integer x = 37
integer y = 1620
integer width = 165
integer height = 96
long backcolor = 276856960
end type

type cb_stop from w_target_subset_maintain`cb_stop within w_target_maintain
integer x = 2039
integer y = 1536
boolean enabled = true
end type

type cb_close from w_target_subset_maintain`cb_close within w_target_maintain
integer x = 2885
integer y = 1620
integer taborder = 150
boolean default = true
end type

type st_link_name from w_target_subset_maintain`st_link_name within w_target_maintain
boolean visible = false
integer x = 1061
integer y = 32
end type

type st_4 from w_target_subset_maintain`st_4 within w_target_maintain
integer x = 1161
integer y = 32
integer height = 72
end type

type cb_list_targets from w_target_subset_maintain`cb_list_targets within w_target_maintain
integer x = 1243
integer y = 1536
integer width = 407
end type

type st_2 from w_target_subset_maintain`st_2 within w_target_maintain
integer y = 160
integer height = 72
end type

type sle_subset_id from w_target_subset_maintain`sle_subset_id within w_target_maintain
boolean visible = false
integer x = 1408
integer y = 28
integer height = 84
end type

type cb_notes from w_target_subset_maintain`cb_notes within w_target_maintain
integer x = 1801
integer y = 1620
integer taborder = 130
end type

type dw_1 from w_target_subset_maintain`dw_1 within w_target_maintain
integer x = 37
integer y = 416
integer width = 3182
integer height = 1088
boolean hscrollbar = true
end type

type sle_target_id from w_target_subset_maintain`sle_target_id within w_target_maintain
integer x = 1477
integer y = 32
integer width = 553
integer height = 84
integer taborder = 50
end type

on sle_target_id::getfocus;call w_target_subset_maintain`sle_target_id::getfocus;If sle_target_id.text <> '' then
	setfocus(sle_description)
End If
end on

type st_1 from w_target_subset_maintain`st_1 within w_target_maintain
integer y = 32
integer width = 256
integer height = 72
end type

type ddlb_track_type from w_target_subset_maintain`ddlb_track_type within w_target_maintain
integer x = 407
integer y = 160
end type

event ddlb_track_type::selectionchanged;call super::selectionchanged;//	02/21/07 Katie	SPR 4763 Fixed issue with enabling disabling ddlb_track_by

if (left(ddlb_track_type.text,2) <> 'PV') then
	ddlb_track_by.enabled = false
else 
	ddlb_track_by.enabled = true
end if
end event

type gb_main from w_target_subset_maintain`gb_main within w_target_maintain
integer x = 41
integer y = 480
integer width = 3122
end type

type cb_create from w_target_subset_maintain`cb_create within w_target_maintain
integer x = 1440
integer y = 1620
integer width = 338
integer taborder = 100
integer textsize = -10
integer weight = 400
string text = "C&reate"
end type

type cb_remove from w_target_subset_maintain`cb_remove within w_target_maintain
boolean visible = false
integer x = 2382
integer y = 376
integer taborder = 0
end type

type cb_split from w_target_subset_maintain`cb_split within w_target_maintain
integer x = 2409
integer y = 612
integer taborder = 0
end type

type ddlb_track_by from w_target_subset_maintain`ddlb_track_by within w_target_maintain
integer y = 32
end type

event ddlb_track_by::selectionchanged;//Override script from w_target_subset_maintain
end event

type st_5 from w_target_subset_maintain`st_5 within w_target_maintain
integer x = 2043
integer y = 32
end type

type st_target_key from statictext within w_target_maintain
string accessiblename = "Target Key"
string accessibledescription = "Key"
accessiblerole accessiblerole = statictextrole!
integer x = 233
integer y = 1640
integer width = 151
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Key:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_target_key from singlelineedit within w_target_maintain
string accessiblename = "Target Key"
string accessibledescription = "Target Key"
accessiblerole accessiblerole = textrole!
integer x = 389
integer y = 1624
integer width = 640
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons

cb_insert.default = true
end event

type cb_clear from u_cb within w_target_maintain
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 2162
integer y = 1620
integer width = 338
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer weight = 400
string text = "C&lear"
end type

event clicked;//	02/21/07 Katie	SPR 4763 Fixed issue with enabling disabling ddlb_track_by
// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
in_targets_removed = ''
in_target_status = ''
in_target_key = ''
in_track_created = false
reset(dw_1)
st_row_count.text = '0'
setfocus(sle_target_key)
sle_target_key.text = ''
cb_insert.default = true
cb_delete.enabled = false
ddlb_track_type.enabled = True	// JasonS 09/04/02 Track 3247d
if (left(ddlb_track_type.text,2) <> 'PV') then 
	ddlb_track_by.enabled = False
else
	ddlb_track_by.enabled = True
end if
end event

type cb_insert from u_cb within w_target_maintain
string accessiblename = "Add"
string accessibledescription = "Add"
integer x = 1056
integer y = 1620
integer width = 338
integer height = 108
integer taborder = 11
boolean bringtotop = true
string text = "&Add"
end type

event clicked;call super::clicked;//*******************************************************************
//10-20-95 FNC Take out connects and disconnects
//06-20-95 FNC Set proc code type if track by PC. Needed for 
//             FX_TRACK_EXISTS
// JasonS 09/04/02 Track 3247d  all tracks must be of same type
// Katie 08/17/08 Track 4449d Added edit to catch blank Track Type.
// Katie	11/20/2006 SPR 4763 Add prov_id_type to datastore.
// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons
//*******************************************************************

int    lv_pos, sub
sx_track_data lv_track_data

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

If trim(sle_target_key.text) = '' then
	Messagebox('EDIT','Target Key to be Added Must be Entered')
	setfocus(sle_target_key)
	This.default = true
	RETURN
End If

If trim(ddlb_track_type.text) = '' then
	Messagebox('EDIT','Must Select Track Type')
	setfocus(ddlb_track_type)
	This.default = true
	RETURN
End If

If (trim(ddlb_track_by.text) = '' and left(ddlb_track_type.text,2) = 'PV') then
	Messagebox('EDIT','Must Select Track By Type')
	setfocus(ddlb_track_by)
	This.default = true
	RETURN
End If

lv_track_data.track_key  = sle_target_key.text
lv_track_data.track_type = left(ddlb_track_type.text,2)
if ( left(ddlb_track_type.text,2) = 'PV') then 
	lv_track_data.prov_id_type = ddlb_track_by.text
else 
	lv_track_data.prov_id_type = ' '
end if

if lv_track_data.track_type = 'PC' then    //06-20-95 FNC Start
   lv_track_data.proc_track_code = 'PC'
end if                                     //06-20-95 FNC End
   
fx_track_exists(lv_track_data)

if stars2ca.of_commit() <> 0 then
   errorbox(stars2ca,'Error performing commit in pb_insert')
   return
end if                                  //10-20-95 FNC End
lv_pos =  integer(st_row_count.text)  
for sub = 1 to lv_pos
		string t_key
		t_key=dw_1.GetItemString(sub,1)
	if trim(sle_target_key.text) = trim(t_key) then
		Messagebox('EDIT','Duplicate Target Key - Already Entered')
		return
	end if
next

dw_1.taborder = 30
Insertrow(dw_1,0)
lv_pos = (integer(st_row_count.text) + 1)
st_row_count.text = string(lv_pos)
setitem(dw_1,lv_pos,1,sle_target_key.text)
setitem(dw_1,lv_pos,2,'A')
setitem(dw_1,lv_pos,3,lv_track_data.track_name)
setitem(dw_1,lv_pos,4,left(ddlb_track_type.text,2))
selectrow(dw_1,0,false)
selectrow(dw_1,lv_pos,true)
setrow(dw_1,lv_pos)
in_target_key = sle_target_key.text
in_target_status = 'A'

sle_target_key.text = ''
cb_delete.enabled = true
cb_create.enabled = true
setfocus(sle_target_key)
ddlb_track_type.enabled = false	// JasonS 09/04/02 Track 3247d
ddlb_track_by.enabled = false
end event

type cb_delete from u_cb within w_target_maintain
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 2523
integer y = 1620
integer width = 338
integer height = 108
integer taborder = 160
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;call super::clicked;//Script for W_target_maintain - cb_delete
//*******************************************************************
//	02/21/07 Katie	SPR 4763 Fixed issue with enabling disabling ddlb_track_by
// 09/10/08	GaryR	SPR 5519	Replace picturebuttons with standard commandbuttons

string lv_target
int    lv_pos,lv_row

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

lv_row = getrow(dw_1)
If lv_row > 0 then
	lv_target = getitemstring(dw_1,lv_row,1)
Else
	setmicrohelp(w_main,'No Targets to Delete')
	RETURN
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row,true)
setrow(dw_1,lv_row)

If Messagebox('CONFIRM','Proceed with Deleting Target ' + lv_target ,Question!,YesNo!,2) = 2 then
	RETURN
End IF

Deleterow(dw_1,lv_row)
st_row_count.text = string(long(st_row_count.text) - 1)

If long(st_row_count.text) > 0 then
	This.enabled = true
	cb_create.enabled = true
Else
	dw_1.taborder     = 0
	This.enabled = false
	cb_create.enabled = false
End IF

// JasonS 09/04/02 Begin - Track 3247d
if dw_1.rowcount() = 0 then
	ddlb_track_type.enabled = True
	if (left(ddlb_track_type.text,2) <> 'PV') then 
		ddlb_track_by.enabled = False
	else
		ddlb_track_by.enabled = True
	end if
end if
// JasonS 09/04/02 End - Track 3247d
end event

type gb_1 from groupbox within w_target_maintain
string accessiblename = "Add Track"
string accessibledescription = "Add Track"
accessiblerole accessiblerole = groupingrole!
integer x = 224
integer y = 1556
integer width = 1193
integer height = 204
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Add Track"
end type

