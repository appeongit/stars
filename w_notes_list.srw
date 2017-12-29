HA$PBExportHeader$w_notes_list.srw
$PBExportComments$List of Notes by Rel Type (Inherited from w_master)
forward
global type w_notes_list from w_master
end type
type st_dw_ops from statictext within w_notes_list
end type
type ddlb_dw_ops from dropdownlistbox within w_notes_list
end type
type ddlb_subtype from dropdownlistbox within w_notes_list
end type
type st_2 from statictext within w_notes_list
end type
type cb_stop from u_cb within w_notes_list
end type
type st_1 from statictext within w_notes_list
end type
type sle_rel_name from singlelineedit within w_notes_list
end type
type st_name from statictext within w_notes_list
end type
type sle_name from singlelineedit within w_notes_list
end type
type sle_user_id from singlelineedit within w_notes_list
end type
type st_user_id from statictext within w_notes_list
end type
type st_row_count from statictext within w_notes_list
end type
type st_range from statictext within w_notes_list
end type
type st_date from statictext within w_notes_list
end type
type st_type from statictext within w_notes_list
end type
type rb_sort_date from radiobutton within w_notes_list
end type
type sle_date from singlelineedit within w_notes_list
end type
type ddlb_type from dropdownlistbox within w_notes_list
end type
type rb_sort_type from radiobutton within w_notes_list
end type
type dw_1 from u_dw within w_notes_list
end type
type cb_list from u_cb within w_notes_list
end type
type cb_select from u_cb within w_notes_list
end type
type cb_new from u_cb within w_notes_list
end type
type cb_delete from u_cb within w_notes_list
end type
type cb_exit from u_cb within w_notes_list
end type
type gb_1 from groupbox within w_notes_list
end type
type sle_range from editmask within w_notes_list
end type
end forward

global type w_notes_list from w_master
string accessiblename = "Note List"
string accessibledescription = "Note List"
accessiblerole accessiblerole = windowrole!
integer x = 169
integer y = 0
integer width = 2752
integer height = 1680
string title = "Note List"
long backcolor = 67108864
event type boolean ue_edit_case_referred ( )
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
ddlb_subtype ddlb_subtype
st_2 st_2
cb_stop cb_stop
st_1 st_1
sle_rel_name sle_rel_name
st_name st_name
sle_name sle_name
sle_user_id sle_user_id
st_user_id st_user_id
st_row_count st_row_count
st_range st_range
st_date st_date
st_type st_type
rb_sort_date rb_sort_date
sle_date sle_date
ddlb_type ddlb_type
rb_sort_type rb_sort_type
dw_1 dw_1
cb_list cb_list
cb_select cb_select
cb_new cb_new
cb_delete cb_delete
cb_exit cb_exit
gb_1 gb_1
sle_range sle_range
end type
global w_notes_list w_notes_list

type variables
string in_from
boolean in_cancel
STRING iv_sort_type, iv_sort_date
w_uo_win iv_uo_win
string in_selected, in_dw_control
sx_decode_structure in_decode_struct

n_cst_notes inv_notes//5-12-98 use nvo instead of globals
n_cst_case inv_case
end variables

event open;call super::open;////////////////////////////////////////////////////////////////////////
//  OPEN EVENT FOR W_NOTES_LIST
////////////////////////////////////////////////////////////////////////
//	Modification history
//
//	???	????????	Created.
//
//	FDG	04/20/98	Track 1075.  
//						1.	Retrieve the data via event ue_retrieve
//						2. Range is set incorrectly.
// NLG	05/12/98 1. Change notes globals to nvo
//	FDG	01/13/99	Track 2047c.  Get the default range and date.
//	FDG	02/01/00	Stars 4.5.  Allow for patterns notes.
//	GaryR	12/06/01	Track 2553d	Trim value.
//	GaryR	03/19/03	Track 3456d	Do not compute range for links
// 08/12/05 MikeF	SPR4479d Changed Range + removed cursors
////////////////////////////////////////////////////////////////////////
string 	ls_add_text
int		li_rows, li_index
long 		lv_nbr_rows, ll_range
n_ds		lds_codes

setpointer(hourglass!)
This.of_set_sys_cntl_range (TRUE)
inv_case = CREATE n_cst_case
gv_from 	= 'L'
in_from  = gv_from
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','P')
setmicrohelp(w_main,'Ready')
cb_list.default = TRUE

// Create Code datastore
lds_codes = CREATE n_ds
lds_codes.Dataobject = 'd_code_lookup'
lds_codes.SetTransobject(stars2ca)

// Retrieve Note Types and add to Dropdown
li_rows = lds_codes.Retrieve('NT','%','%')

AddItem(ddlb_subtype,' ')

FOR li_index = 1 TO li_rows
   ls_add_text = lds_codes.GetItemString(li_index, 'code_code') + ' - ' + &
				 	  lds_codes.GetItemString(li_index, 'code_desc')
	AddItem(ddlb_type,ls_add_text)
NEXT

AddItem(ddlb_type,'AA - All Note Types')
selectitem(ddlb_type,'AA',0)

// Retrieve Note Sub Types and add to Dropdown
li_rows = lds_codes.Retrieve('NS','%','%')

FOR li_index = 1 TO li_rows
   ls_add_text = lds_codes.GetItemString(li_index, 'code_code') + ' - ' + &
				 	  lds_codes.GetItemString(li_index, 'code_desc')
	AddItem(ddlb_subtype,ls_add_text)
NEXT

AddItem(ddlb_subtype,' ')

DESTROY lds_codes

// Set Date text box
sle_date.text = String(today(), 'mm/dd/yyyy')

CHOOSE CASE inv_notes.is_notes_from 
	CASE 'MM' // From Menu
		sle_range.text	=	String ( inv_sys_cntl.of_get_cntl_no() )
		ddlb_type.text = 'AA'
		dw_1.taborder = 0
		RETURN
	CASE 'SS' // From Subset List
		if Trim( gc_active_subset_case ) = 'NONE' then
			ddlb_type.text = 'SS'
		else 
			ddlb_type.text = 'CA'
		end if
	CASE 'PQ' // From PDQ
		if inv_notes.is_notes_rel_type = 'PQ' then
			ddlb_type.text = 'PQ'
		else
			ddlb_type.text = 'CA'
		end if
	CASE 'PA' // Patterns
		if inv_notes.is_notes_rel_type = 'PA' then
			ddlb_type.text = 'PA'
		else
			ddlb_type.text = 'CA'
		end if
	CASE ELSE		
		ddlb_type.text = inv_notes.is_notes_from 
END CHOOSE

ddlb_type.triggerevent(selectionchanged!)

sle_rel_name.text = inv_notes.is_notes_rel_id
sle_range.text = "9999"

This.Post	Event	ue_retrieve()
dw_1.SelectRow (0, FALSE)

SETPOINTER(ARROW!) 
end event

event close;call super::close;IF	IsValid (w_notes_maint)		THEN
	close(w_notes_maint)
END IF

IF IsValid(inv_case) THEN DESTROY inv_case
end event

on w_notes_list.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.ddlb_subtype=create ddlb_subtype
this.st_2=create st_2
this.cb_stop=create cb_stop
this.st_1=create st_1
this.sle_rel_name=create sle_rel_name
this.st_name=create st_name
this.sle_name=create sle_name
this.sle_user_id=create sle_user_id
this.st_user_id=create st_user_id
this.st_row_count=create st_row_count
this.st_range=create st_range
this.st_date=create st_date
this.st_type=create st_type
this.rb_sort_date=create rb_sort_date
this.sle_date=create sle_date
this.ddlb_type=create ddlb_type
this.rb_sort_type=create rb_sort_type
this.dw_1=create dw_1
this.cb_list=create cb_list
this.cb_select=create cb_select
this.cb_new=create cb_new
this.cb_delete=create cb_delete
this.cb_exit=create cb_exit
this.gb_1=create gb_1
this.sle_range=create sle_range
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
this.Control[iCurrent+2]=this.ddlb_dw_ops
this.Control[iCurrent+3]=this.ddlb_subtype
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_stop
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_rel_name
this.Control[iCurrent+8]=this.st_name
this.Control[iCurrent+9]=this.sle_name
this.Control[iCurrent+10]=this.sle_user_id
this.Control[iCurrent+11]=this.st_user_id
this.Control[iCurrent+12]=this.st_row_count
this.Control[iCurrent+13]=this.st_range
this.Control[iCurrent+14]=this.st_date
this.Control[iCurrent+15]=this.st_type
this.Control[iCurrent+16]=this.rb_sort_date
this.Control[iCurrent+17]=this.sle_date
this.Control[iCurrent+18]=this.ddlb_type
this.Control[iCurrent+19]=this.rb_sort_type
this.Control[iCurrent+20]=this.dw_1
this.Control[iCurrent+21]=this.cb_list
this.Control[iCurrent+22]=this.cb_select
this.Control[iCurrent+23]=this.cb_new
this.Control[iCurrent+24]=this.cb_delete
this.Control[iCurrent+25]=this.cb_exit
this.Control[iCurrent+26]=this.gb_1
this.Control[iCurrent+27]=this.sle_range
end on

on w_notes_list.destroy
call super::destroy
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.ddlb_subtype)
destroy(this.st_2)
destroy(this.cb_stop)
destroy(this.st_1)
destroy(this.sle_rel_name)
destroy(this.st_name)
destroy(this.sle_name)
destroy(this.sle_user_id)
destroy(this.st_user_id)
destroy(this.st_row_count)
destroy(this.st_range)
destroy(this.st_date)
destroy(this.st_type)
destroy(this.rb_sort_date)
destroy(this.sle_date)
destroy(this.ddlb_type)
destroy(this.rb_sort_type)
destroy(this.dw_1)
destroy(this.cb_list)
destroy(this.cb_select)
destroy(this.cb_new)
destroy(this.cb_delete)
destroy(this.cb_exit)
destroy(this.gb_1)
destroy(this.sle_range)
end on

event ue_retrieve;////////////////////////////////////////////////////////////////////////
//  w_notes_list.ue_retrieve  (moved from CB_LIST.Clicked)
////////////////////////////////////////////////////////////////////////
//	Modification history
//
//	???	????????	Created.
//
//	FDG	04/20/98	Track 1075.  
//						1. Corrected the generated SQL syntax.
//						2. Corrected the SQL to include the entered data.  The
//							SQL cannot have retrieval arguments.
//						3. Rename local variables to conform to standards.
//						4. Used column names instead of column numbers for
//							setting the sort order.
// NLG	4-21-98	ALLSTARS Track #873 
//						1.	Add description field to the datawindow
//	NLG	4-28-98  1. Use sys_cntl to set range
//						2.	use % in user_id, but convert it to a local first
// NLG	5-12-98	1. change notes globals to nvo
//	FDG	01/12/99	Track 2047c.  Y2K changes to allow a 4-digit date and range.
//	FDG	12/13/00	Stars 4.7.  
//						1.	Remove the retrieval of note_text since it must be 
//							retrieved separately and its not needed in this window.
// GaryR	01/04/01	Stars 4.7 DataBase Port - Date Conversion
//	FDG	09/21/01	Stars 4.8.1.	Trigger rowfocuschanged in 1st row
// JasonS 10/17/02 Track 2883d  Added note_desc to sql statement
////////////////////////////////////////////////////////////////////////


Long		ll_nbr_rows 
String	ls_sort_order,ls_name, ls_subtype
Datetime lv_from_date,lv_to_date,lv_date
String	ls_dw_sql //VAV 4.0 2/3/98
String   ls_notes_rel_name, ls_notes_rel_type //NLG 5-11-98
Integer	li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
reset(dw_1)
st_row_count.text = ''
cb_select.enabled = false
cb_delete.enabled = false
cb_list.default = true
setfocus(sle_name)

inv_notes.is_notes_rel_type = left(ddlb_type.text,2)
If inv_notes.is_notes_rel_type = 'AA' then	
	ls_notes_rel_type = '%'
else
	ls_notes_rel_type = inv_notes.is_notes_rel_type + '%'
End If

ls_subtype = trim(left(ddlb_subtype.text,2)) + '%'
inv_notes.is_notes_rel_id = trim(sle_rel_name.text)
ls_notes_rel_name = inv_notes.is_notes_rel_id + '%'

gv_user_id = trim(sle_user_id.text)

string ls_user_id
ls_user_id = gv_user_id + '%'

ls_name = trim(sle_name.text) + '%'

n_cst_datetime		lnv_datetime

li_rc		=	lnv_datetime.of_IsValidDate (sle_date.text)

CHOOSE CASE li_rc
	CASE	-1
		MessageBox ('Error', 'Invalid date entered')
		sle_date.SetFocus()
		Return
	CASE	-2
		MessageBox ('Error', 'The year entered must be a 4 digit year')
		sle_date.SetFocus()
		Return
	CASE	-3
		MessageBox ('Error', 'The date must be between '	+	&
						lnv_datetime.of_GetMinimumStringDate()	+	' and '	+	&
						lnv_datetime.of_GetMaximumStringDate()	)
		sle_date.SetFocus()
		Return
END CHOOSE

// The parms passed to the following function are passed by reference
//	and can change values.
lv_from_date	=	lnv_datetime.of_GetFromDateTime (sle_date.text, sle_range.text)
lv_to_date		=	DateTime (Date(sle_date.text), 23:59:59)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

If SetTransObject(dw_1,stars2ca) < 0 then
	Messagebox('ERROR','Unable to Set Transaction Object')
	cb_exit.default = true
   RETURN
End If

// FDG 12/13/00 - Remove note_text from retrieval.
// GaryR	01/04/01	Stars 4.7 DataBase Port - Begin
//ls_dw_sql = + &
// 	"Select Notes.User_Id, Notes.Note_Id, Notes.Note_Rel_Type,Notes.Note_Sub_Type,"+&
//	 "Notes.Note_rel_id,Notes.Note_Datetime" + &
//   " From Notes "+ &
//   " Where (Notes.User_Id Like '" + ls_user_id + "')" + &
// 	" And (Notes.Note_Id Like '" + ls_name  + "')" + &
// 	" And (Notes.Note_Rel_id Like '" + ls_notes_rel_name  + "')" + &
// 	" And (Notes.Note_Datetime >= '" + String(lv_from_date,'mm/dd/yyyy hh:mm:ss') + "')" + &
// 	" And (Notes.Note_Datetime <= '" + String(lv_to_date,'mm/dd/yyyy hh:mm:ss') + "')" + &
// 	" And (Notes.Note_Sub_Type Like '" + ls_subtype + "')" + &  
//	" And (Notes.Note_rel_type like '" + ls_notes_rel_type + "')" + &
//	" Order By Notes.Note_Rel_Type Asc, Notes.Note_Sub_Type Asc," + & 
//          "Notes.Note_Id Asc"

// JasonS 10/17/02 Track 2883d Added note_desc in sql below
ls_dw_sql = + &
 	"Select Notes.User_Id, Notes.Note_Id, Notes.Note_Rel_Type,Notes.Note_Sub_Type,"+&
	 "Notes.Note_rel_id,Notes.Note_Datetime, Notes.Note_Desc" + &	
   " From Notes "+ &
   " Where (Notes.User_Id Like '" + Upper( ls_user_id ) + "')" + &
 	" And (Notes.Note_Id Like '" + Upper( ls_name )  + "')" + &
 	" And (Notes.Note_Rel_id Like '" + Upper( ls_notes_rel_name )  + "')" + &
 	" And (Notes.Note_Datetime >= " + gnv_sql.of_get_to_date( String(lv_from_date,'mm/dd/yyyy hh:mm:ss') ) + ")" + &
 	" And (Notes.Note_Datetime <= " + gnv_sql.of_get_to_date( String(lv_to_date,'mm/dd/yyyy hh:mm:ss') ) + ")" + &
 	" And (Notes.Note_Sub_Type Like '" + Upper( ls_subtype ) + "')" + &  
	" And (Notes.Note_rel_type like '" + Upper( ls_notes_rel_type ) + "')" + &
	" Order By Notes.Note_Rel_Type Asc, Notes.Note_Sub_Type Asc," + & 
          "Notes.Note_Id Asc"
// GaryR	01/04/01	Stars 4.7 DataBase Port - End

DW_1.Object.DataWindow.Table.Select = ls_dw_sql//NLG 5-11-98

				
ll_nbr_rows	=	dw_1.Retrieve()																	// FDG 04/20/98

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
selectrow(dw_1,0,false)

If rb_sort_date.checked = true then
	ls_sort_order = 'note_datetime D, user_id A, note_id A'
Else
	ls_sort_order = 'note_sub_type A, note_datetime D, user_id A, note_id A'
End If

setsort(dw_1, ls_sort_order)
sort(dw_1)

//st_row_count.text = string(ll_nbr_rows)   //NLG 4-21-98 move this line below

If ll_nbr_rows <= 0 then
	Messagebox('NOTES LIST','No Existing Notes for Search Criteria')
   setfocus(sle_date)
   RETURN
End If

st_row_count.text = string(ll_nbr_rows)

cb_select.enabled = true
cb_select.default = true
If gv_user_id <> gc_user_id then
	cb_delete.enabled = false
Else
	cb_delete.enabled = true
End If

sle_name.text  = ''
//sle_rel_name.text = ''
dw_1.taborder = 80
setfocus(dw_1)
selectrow(dw_1,1,true)
setrow(dw_1,1)

inv_notes.is_notes_id = getitemstring(dw_1,1,'note_id')
inv_notes.is_notes_rel_type = getitemstring(dw_1,1,'note_rel_type')
inv_notes.is_notes_rel_id = getitemstring(dw_1,1,'note_rel_id')

// FDG 09/21/01 begin
IF	dw_1.RowCount()	>	0		THEN
	dw_1.Event	RowFocusChanged(0)
	dw_1.Event	RowFocusChanged(1)
END IF
// FDG 09/21/01 end

SETPOINTER(ARROW!)
end event

event ue_preopen;call super::ue_preopen;//---------------------------------------------------------------------------------
// ue_preopen for w_notes_list
// Modifications:
// 05-12-98	Naomi 1. change notes globals to use nvo instead
//---------------------------------------------------------------------------------

inv_notes = message.powerobjectparm

end event

type st_dw_ops from statictext within w_notes_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 46
integer y = 1252
integer width = 677
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type ddlb_dw_ops from dropdownlistbox within w_notes_list
string accessiblename = "Windows Operations"
string accessibledescription = "Windows Operations"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 46
integer y = 1324
integer width = 713
integer height = 312
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure call to fx_uo_control call.
string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end on

type ddlb_subtype from dropdownlistbox within w_notes_list
string accessiblename = "Subtype"
string accessibledescription = "Subtype"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 1733
integer y = 280
integer width = 951
integer height = 376
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_notes_list
string accessiblename = "SubType"
string accessibledescription = "SubType"
accessiblerole accessiblerole = statictextrole!
integer x = 1728
integer y = 208
integer width = 306
integer height = 60
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "SubType"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_stop from u_cb within w_notes_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1947
integer y = 1440
integer width = 338
integer height = 108
integer taborder = 10
integer textsize = -16
boolean enabled = false
string text = "S&top"
end type

on clicked;in_cancel = true
end on

type st_1 from statictext within w_notes_list
string accessiblename = "Related ID"
string accessibledescription = "Related ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1029
integer y = 208
integer width = 370
integer height = 60
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Related ID"
alignment alignment = center!
end type

type sle_rel_name from singlelineedit within w_notes_list
string accessiblename = "Related Id"
string accessibledescription = "Related Id"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 1033
integer y = 280
integer width = 667
integer height = 96
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type st_name from statictext within w_notes_list
string accessiblename = "Note ID"
string accessibledescription = "Note ID"
accessiblerole accessiblerole = statictextrole!
integer x = 512
integer y = 16
integer width = 233
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Note ID"
alignment alignment = center!
end type

type sle_name from singlelineedit within w_notes_list
string accessiblename = "Related Type"
string accessibledescription = "Related Type"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 507
integer y = 92
integer width = 439
integer height = 96
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type sle_user_id from singlelineedit within w_notes_list
string accessiblename = "User ID"
string accessibledescription = "User ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 46
integer y = 92
integer width = 402
integer height = 96
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

on modified;//setpointer(hourglass!)
//setmicrohelp(w_main,'')
//gv_user_id = sle_user_id.text
//reset(dw_1)
//st_row_count.text = ''
//cb_select.enabled = false
//cb_delete.enabled = false
//cb_list.default = true
//setpointer(arrow!)
end on

type st_user_id from statictext within w_notes_list
string accessiblename = "User ID"
string accessibledescription = "User ID"
accessiblerole accessiblerole = statictextrole!
integer x = 73
integer y = 16
integer width = 247
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "User ID"
alignment alignment = center!
end type

type st_row_count from statictext within w_notes_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 46
integer y = 1452
integer width = 274
integer height = 80
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
string text = "    "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

type st_range from statictext within w_notes_list
string accessiblename = "Range"
string accessibledescription = "Range"
accessiblerole accessiblerole = statictextrole!
integer x = 1463
integer y = 16
integer width = 201
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Range"
alignment alignment = center!
end type

type st_date from statictext within w_notes_list
string accessiblename = "Date"
string accessibledescription = "Date"
accessiblerole accessiblerole = statictextrole!
integer x = 969
integer y = 16
integer width = 219
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Date"
alignment alignment = center!
end type

type st_type from statictext within w_notes_list
string accessiblename = "Related Type"
string accessibledescription = "Related Type"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 208
integer width = 425
integer height = 60
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Related Type"
alignment alignment = center!
end type

type rb_sort_date from radiobutton within w_notes_list
string accessiblename = "Date Only"
string accessibledescription = "Date Only"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1728
integer y = 92
integer width = 389
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Date Only"
boolean checked = true
end type

event clicked;//==================================================================================
//clicked for rb_sort_date of w_case_list
//Modifications:
//05-12-98	NLG	1.	Replace notes globals with notes nvo
//==================================================================================
setpointer(hourglass!)
setmicrohelp(w_main,'')
If integer(st_row_count.text) > 0 then
	selectrow(dw_1,0,false)
	setsort(dw_1, '6D,1A,2A')
	sort(dw_1)
	setfocus(dw_1)
	selectrow(dw_1,1,true)
	setrow(dw_1,1)
	gv_USER_ID            = getitemstring(dw_1,1,1)
	//gv_notes_name         = getitemstring(dw_1,1,2)
	//gv_notes_rel_type     = getitemstring(dw_1,1,3)
	//gv_notes_rel_name     = getitemstring(dw_1,1,4)
	inv_notes.is_notes_id 		 = getitemstring(dw_1,1,'note_id')
	inv_notes.is_notes_rel_type = getitemstring(dw_1,1,'note_rel_type')
	inv_notes.is_notes_rel_id   = getitemstring(dw_1,1,'note_rel_id')
End If
end event

type sle_date from singlelineedit within w_notes_list
string accessiblename = "Date"
string accessibledescription = "Date"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 987
integer y = 92
integer width = 439
integer height = 96
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type ddlb_type from dropdownlistbox within w_notes_list
string accessiblename = "Type"
string accessibledescription = "Type"
long textcolor = 33554432
accessiblerole accessiblerole = comboboxrole!
integer x = 46
integer y = 280
integer width = 951
integer height = 328
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Selectionchanged for ddlb_type of w_notes_list
//Modifications:
//05-12-98	NLG	1. change globals to nvo
//06-01-98  NLG	1.	if coming from subset list or query engine, disable sub type, rel type, rel id
//02-01-00	FDG	Stars 4.5.  Allow for patterns notes.
//**********************************************************************************

setpointer(hourglass!)
setmicrohelp(w_main,'')
reset(dw_1)

//NLG 5-12-98 change globals to nvo
//gv_notes_rel_type = left(ddlb_type.text,2)
inv_notes.is_notes_rel_type = left(ddlb_type.text,2)

st_row_count.text = '0'
cb_list.default = true
cb_select.enabled = false
cb_delete.enabled = false

//if gv_notes_rel_type='CA' or gv_notes_rel_type='AA' then
if inv_notes.is_notes_rel_type='CA' or inv_notes.is_notes_rel_type='AA' then
	ddlb_subtype.enabled=true
	//NLG 6-1-98 if coming from subset list or query engine, subtype will by SB or PQ *start**
	if inv_notes.is_notes_from = 'SS' then
		ddlb_subtype.selectitem('SB',0)
	elseif inv_notes.is_notes_from = 'PQ' then
		ddlb_subtype.selectitem('PQ',0)
	elseif inv_notes.is_notes_from = 'PA' then
		ddlb_subtype.selectitem('PA',0)					// FDG 02/01/00
	else
		ddlb_subtype.text=' '
	end if
	//NLG 6-1-98                                                                       ***end***
else
	ddlb_subtype.selectitem('GI',0)
	ddlb_subtype.enabled=false
end if

If inv_notes.is_notes_rel_type='CA' then
	// FDG 02/01/00 - Allow for patterns
	if inv_notes.is_notes_from = 'SS' &
	or inv_notes.is_notes_from = 'PQ' &
	or inv_notes.is_notes_from = 'PA' then
		//do nothing, has already been set
	else
 		if trim(inv_notes.is_notes_rel_id) = '' then 
			inv_notes.is_notes_rel_id = gv_active_case
		end if
	end if
 	sle_rel_name.text = inv_notes.is_notes_rel_id
Else
 	sle_rel_name.text=''
End if

//NLG 1-6-98 if coming from subset list or query engine, disable sub type, rel type, rel id
// FDG 02/01/00 - Allow for patterns
if inv_notes.is_notes_from = 'SS' &
or inv_notes.is_notes_from = 'PQ' &
or inv_notes.is_notes_from = 'PA' then
	ddlb_type.enabled = false
	ddlb_subtype.enabled = false
	sle_rel_name.enabled = false
end if

setpointer(arrow!)
end event

type rb_sort_type from radiobutton within w_notes_list
string accessiblename = "SubType/Date"
string accessibledescription = "SubType/Date"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 2162
integer y = 92
integer width = 512
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "SubType/Date"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'')
If integer(st_row_count.text) > 0 then
	selectrow(dw_1,0,false)
	setsort(dw_1, '3A,4A,6D,1A,2A')
	sort(dw_1)
	setfocus(dw_1)
	selectrow(dw_1,1,true)
	setrow(dw_1,1)
	gv_USER_ID            = getitemstring(dw_1,1,1)
	gv_notes_name         = getitemstring(dw_1,1,2)
	gv_notes_rel_type     = getitemstring(dw_1,1,3)
	gv_notes_rel_name     = getitemstring(dw_1,1,4)
End If
end on

type dw_1 from u_dw within w_notes_list
string accessiblename = "Note List"
string accessibledescription = "Note List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Notes List"
integer x = 46
integer y = 396
integer width = 2638
integer height = 844
integer taborder = 100
string dataobject = "d_notes_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;//====================================================================================
//rowfocuschanged for dw_1 of w_notes_list
//Modifications:
//05-12-98	NLG	1. change notes globals to notes nvo
// 09/21/01	FDG	Stars 4.8.1.  Cannot delete a note associated with a
//						closed/deleted case.
// JasonS 10/17/02 Track 2883d  update info in n_cst_notes for note_desc
//	Katie	03/05/07 SPR 2901 Added Case Component Security to 'CA' notes and removed it from 'PQ' notes.
//====================================================================================

long lv_row_nbr

	If not in_cancel then RETURN
	setpointer(hourglass!)
	setmicrohelp(w_main,'Ready')

	lv_row_nbr = getrow(dw_1)
	// FDG 01/17/02 - Track 2699d.  If no rows exist, get out
	If lv_row_nbr = 0				&
	or	This.RowCount()	<	1	then
	    selectrow(dw_1,0,false)
		 inv_notes.is_notes_id      = ''
		 inv_notes.is_notes_rel_type = ''
		 inv_notes.is_notes_rel_id	 = ''
		 inv_notes.is_notes_desc = ''	// JasonS 10/17/02 Track 2883d
		 cb_select.enabled = false
		 cb_delete.enabled = false
		 setfocus(dw_1)
	    RETURN
	End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)

gv_user_id          = getitemstring(dw_1,lv_row_nbr,1)
inv_notes.is_notes_id       = getitemstring(dw_1,lv_row_nbr,'note_id')
inv_notes.is_notes_rel_type = getitemstring(dw_1,lv_row_nbr,'note_rel_type')
inv_notes.is_notes_sub_type = getitemstring(dw_1,lv_row_nbr,'note_sub_type')
inv_notes.is_notes_rel_id   = getitemstring(dw_1,lv_row_nbr,'note_rel_id')
inv_notes.is_notes_desc		 = getitemstring(dw_1,lv_row_nbr,'note_desc') // JasonS 10/17/02 Track 2883d

cb_select.enabled = true
if gv_user_id=gc_user_id then
	cb_delete.enabled = true
else
	cb_delete.enabled=false
end if

// FDG 09/21/01 begin - Don't allow deletion of notes if the associated case is closed/deleted
Boolean	lb_valid_case,			&
			lb_enabled
			
lb_valid_case	=	TRUE
lb_enabled		=	cb_delete.enabled

CHOOSE CASE inv_notes.is_notes_rel_type
	CASE 'CA'
		// Case note
		String is_comp_upd_status
		is_comp_upd_status = inv_case.uf_get_comp_upd_status_lead('CASENOTES', Left( inv_notes.is_notes_rel_id, 10 ), &
			Mid( inv_notes.is_notes_rel_id, 11, 2 ), Mid( inv_notes.is_notes_rel_id, 13, 2 ))
		if (is_comp_upd_status = 'AO' or is_comp_upd_status = 'RO') then
			lb_valid_case = FALSE
		else 
			lb_valid_case	=	inv_case.uf_edit_case_deleted (Left( inv_notes.is_notes_rel_id, 10 ), &
				Mid( inv_notes.is_notes_rel_id, 11, 2 ), Mid( inv_notes.is_notes_rel_id, 13, 2 ))
		end if
	CASE 'PA'
		// Patterns note
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, 'PAT')
	CASE 'SS'
		// Patterns note
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, 'SUB')
END CHOOSE

IF	lb_valid_case	=	FALSE THEN
	cb_delete.enabled	=	FALSE
ELSE
	cb_delete.enabled	=	lb_enabled
END IF
// FDG 09/21/01 end


end event

on retrievestart;setpointer(hourglass!)
//parent.controlmenu = false								//FDG 06/13/96
in_cancel = false
cb_stop.enabled = true
end on

event doubleclicked;//======================================================================================
//doubleclicked for dw_1 of w_notes_list
//Modifications:
//anne-s 11-28-97 TS242 Rel 3.6
//05-12-98	NLG	1. change notes globals to notes nvo
// JasonS 10/17/02 Track 2883d  populate note_desc in nvo
//======================================================================================
long lv_row_nbr
int tabpos,rc,lv_indx,lv_found
int lv_upper
string lv_hold_object,lv_col,lv_tbl_type
string lv_string_width,lv_hold_col_width,lv_col_name
boolean lv_lookup,lv_found_flag,lv_join

lv_join = FALSE

If not in_cancel then RETURN

setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_1)
If lv_hold_object = '' then
	return
end if
tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
		ddlb_dw_ops.triggerevent(selectionchanged!)
		lv_row_nbr = row
		rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
Else
	setpointer(hourglass!)
	setmicrohelp(w_main,'Ready')

	lv_row_nbr = row
	If lv_row_nbr = 0 then 
	    selectrow(dw_1,0,false)
 		 inv_notes.is_notes_id = ""
	    inv_notes.is_notes_rel_type = ""
	    inv_notes.is_notes_rel_id = ""
		 inv_notes.is_notes_desc = ''	// JasonS 10/17/02 Track 2883d
		 cb_select.enabled = false
		 cb_delete.enabled = false
	    RETURN
	Else 
		 cb_select.enabled = true
		 cb_delete.enabled = true
	End If

	selectrow(dw_1,0,false)
	selectrow(dw_1,lv_row_nbr,true)
	setrow(dw_1,lv_row_nbr)
	gv_user_id        = getitemstring(dw_1,lv_row_nbr,'user_id')			//ajs 4.0 03-18-98 Use column name
	inv_notes.is_notes_id     	 = getitemstring(dw_1,lv_row_nbr,'note_id')		
	inv_notes.is_notes_rel_type = getitemstring(dw_1,lv_row_nbr,'note_rel_type')
	inv_notes.is_notes_rel_id   = getitemstring(dw_1,lv_row_nbr,'note_rel_id')
	inv_notes.is_notes_desc		 = getitemstring(dw_1,lv_row_nbr,'note_desc')	// JasonS 10/17/02 Track 2883d
	sle_user_id.text = gv_user_id
	Triggerevent(cb_select,Clicked!)
End If
end event

on retrieveend;//parent.controlmenu = true					//FDG 06/13/96
cb_stop.enabled = false
in_cancel = true
triggerevent(dw_1,rowfocuschanged!)
end on

type cb_list from u_cb within w_notes_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 430
integer y = 1440
integer width = 338
integer height = 108
integer taborder = 120
string text = "&List"
boolean default = true
end type

event clicked;////////////////////////////////////////////////////////////////////////
//  Clicked event for CB_LIST on W_NOTES_LIST
////////////////////////////////////////////////////////////////////////
//	Modification history
//
//	???	????????	Created.
//
//	FDG	04/20/98	Track 1075.  
//						Move logic to ue_retrieve.
//
////////////////////////////////////////////////////////////////////////

Parent.Event	ue_retrieve()

end event

type cb_select from u_cb within w_notes_list
string accessiblename = "Select"
string accessibledescription = "Select..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 809
integer y = 1440
integer width = 338
integer height = 108
integer taborder = 130
boolean enabled = false
string text = "&Select..."
end type

event clicked;//**************************************************************************************
//08-14-97 FNC FS/TS181 RLS354 #6 Fix mistake from 6-18-97. Allow user to select non 
//					CA notes.
//06-18-97 FNC FS/TS154 Check security before opening detail window
//					This will make sure all case security is consistent
//ajs 4.0 03-11-98 fix split of case id
//05-12-98 NLG	change notes globals to nvo
// 08-31-98 NLG FS362 convert case to case_cntl
//	08-11-99	NLG TS2363c. Use new case nvo for security check
//**************************************************************************************
string ls_case_id,ls_case_spl,ls_case_ver,ls_dept_code	//06-18-97 FNC
integer li_code_sec													//06-18-97 FNC
string ls_msg

setpointer (hourglass!)
setmicrohelp(w_main,'Ready')
If integer(st_row_count.text) <= 0 then
	Messagebox('ERROR','No Record to Select')
	cb_select.enabled = false
	cb_delete.enabled = false
	RETURN
End If

if inv_notes.is_notes_id = ''  or inv_notes.is_notes_id = ' ' then 
	setfocus(dw_1)
	messagebox ('ERROR','Select an Item from the List, or Exit')
   Return
End If

gv_from='L'

if inv_notes.is_notes_rel_type = 'CA' then
	ls_case_id = left(inv_notes.is_notes_rel_id,10)
	ls_case_spl = mid(inv_notes.is_notes_rel_id,11,2)
	ls_case_ver = mid(inv_notes.is_notes_rel_id,13,2)	//ajs 4.0 03-11-98 fix split of case id

	Ls_msg  =  inv_case.uf_edit_case_security(ls_case_id, ls_case_spl, ls_case_ver)
	IF  Len (ls_msg)  >  0   THEN
		MessageBox ('Security Error', ls_msg)
		Return
	ELSE
		opensheetwithparm(w_notes_maint,inv_notes,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
	END IF

else																							//08-14-97 FNC
	opensheetwithparm(w_notes_maint,inv_notes,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
End if//if inv_notes.is_notes_rel_type = 'CA' then
setpointer (arrow!)
end event

type cb_new from u_cb within w_notes_list
string accessiblename = "Add"
string accessibledescription = "Add..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1189
integer y = 1440
integer width = 338
integer height = 108
integer taborder = 140
string text = "&Add..."
end type

event clicked;//=================================================================================
//clicked for cb_new of w_notes_list
//Modifications:
//08-31-98 NLG FS362 convert case to case_cntl
//08-11-98	NLG	1. Allow Add window to open if other than case note and note id is populated
//							Track #1567
//05-12-98	NLG	1. replace notes globals with notes nvo
//ajs 4.0 03-11-98 fix split of case id
//	08-11-99	NLG	1. Use new nvo to check case security
//	09/21/01	FDG	Stars 4.8.1.	Don't allow notes additions if the associated case
//						is closed or deleted.
//	08/06/02	GaryR	Track 3237d	Do not validate active case
// 12/29/04 JasonS Track 4055 Remove check for closed case.
//=================================================================================
int lv_nbr_rows, lv_count,lv_sqldbcode
integer li_code_sec
string lv_sqlerrtxt,lv_sqlusrmsg
string ls_case_id,ls_case_spl,ls_case_ver,ls_dept_code
string ls_msg

Boolean	lb_valid_case				// FDG 09/21/01


setpointer (hourglass!)
setmicrohelp(w_main,'Ready')

gv_user_id = gc_user_id
sle_name.text = trim(sle_name.text)
inv_notes.is_notes_id         = sle_name.text
inv_notes.is_notes_rel_type   = left(ddlb_type.text,2)
inv_notes.is_notes_rel_id     = trim(sle_rel_name.text)

If inv_notes.is_notes_rel_type = 'AA' then
	inv_notes.is_notes_rel_type = ''
	inv_notes.is_notes_rel_id   = ''
End If

If inv_notes.is_notes_rel_type = '' then
	inv_notes.is_notes_rel_type = 'CA'
	inv_notes.is_notes_rel_id = gv_active_case
End If

if inv_notes.is_notes_rel_type = 'CA' then
	if trim(inv_notes.is_notes_rel_id) = '' then
		inv_notes.is_notes_rel_id = gv_active_case
	end if
end if

inv_notes.is_notes_sub_type=ddlb_subtype.text

gv_from = 'N'

Select count(*) into :lv_count 
	from notes
	where user_id = Upper( :gv_user_id ) and note_id = Upper( :sle_name.text )
using stars2ca;

If stars2ca.of_check_status() <> 0 then
	lv_sqlerrtxt = stars2ca.sqlerrtext
	LV_SQLUSRMSG = 'Select statement Error ' + stars2ca.sqlerrtext
	Errorbox(stars2ca,lv_sqlusrmsg)
	cb_exit.default = true
	RETURN
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
If lv_count > 0 then
	Messagebox ('ERROR', 'Note for ' + sle_name.text + ' Already Exists')
	cb_exit.default = true
	RETURN
End If

// FDG 09/21/01 begin - Don't allow new notes if the associated case is closed/deleted
lb_valid_case	=	TRUE

CHOOSE CASE inv_notes.is_notes_rel_type
	CASE 'CA'
		// Case note
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id)
	CASE 'PA'
		// Patterns note
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, 'PAT')
	CASE 'PQ'
		// PDQ note
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, 'PDQ')
	CASE 'SS'
		// Subset note
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, 'SUB')
END CHOOSE


// FDG 09/21/01 end

//	08/06/02	GaryR	Track 3237d
//if inv_notes.is_notes_rel_type = 'CA' then
if inv_notes.is_notes_rel_type = 'CA' AND Trim( gv_active_case ) <> "" then
	ls_case_id = left(inv_notes.is_notes_rel_id,10)
	ls_case_spl = mid(inv_notes.is_notes_rel_id,11,2)
	ls_case_ver = mid(inv_notes.is_notes_rel_id,13,2)	
	ls_msg = inv_case.uf_edit_case_security(+&
					ls_case_id,ls_case_spl,ls_case_ver)
	//if no message returned, user has proper security, no other errors occurred
	IF  Len (ls_msg)  >  0   THEN
			MessageBox ('Security Error', ls_msg)
		Return
	ELSE
		opensheetwithparm(w_notes_maint,inv_notes,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)
	END IF
	
else//If other than case note ...																			//Track #1567
	opensheetwithparm(w_notes_maint,inv_notes,MDI_MAIN_FRAME,HELP_MENU_POSITION,LAYERED!)	//Track #1567
End if//

setpointer(arrow!)
end event

type cb_delete from u_cb within w_notes_list
string accessiblename = "Delete"
string accessibledescription = "Delete"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1568
integer y = 1440
integer width = 338
integer height = 108
integer taborder = 150
boolean enabled = false
string text = "&Delete"
end type

event clicked;//
// Delete not logic
//
// Maintenance Log:
// By:	Date:			Description:
//	----	--------		---------------------------------------------
//	JGG	03/11/98		STARS 4.0 - TS145 - Executable Changes
//	NLG	05/12/98		replace notes globals with notes nvo
//	FDG	09/21/01		Stars 4.8.1.  Don't delete notes associated with a
//							closed or deleted case.  Also, add a case_log.
//	GaryR	01/28/03		Track 3416d Fix case log when deleting note
//	06/10/05 MikeF	SPR4319d Remove refernces to w_subset_maint
//	09/14/07 Katie SPR 5174 Made adjustment for CA notes to call uf_edit_case_deleted function.
//----------------------------------------------------------------

int lv_message_nbr, lv_count, lv_sqldbcode,lv_row
string lv_sqlerrtext, LV_SQLUSRMSG
string lv_rel_id

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
If integer(st_row_count.text) = 0 then
	Messagebox('EDIT','No Record to Delete')
	cb_delete.enabled = false
	cb_select.enabled = false
	cb_list.default = true
	setfocus(sle_name)
	RETURN
End If

//if gv_notes_name = '' then 
if inv_notes.is_notes_id = '' then 
	messagebox ('EDIT','Select an Item to Delete, or Exit')
	setfocus(dw_1)
   Return
End IF

if gv_user_id <> gc_user_id  then 
	messagebox ('EDIT','Cannot Delete another User~'s Note')
	setfocus(sle_name)
	cb_delete.enabled = false
	cb_exit.default = true
   Return
End IF

// FDG 09/21/01 begin - Don't allow deletions if the associated case is closed/deleted
Boolean	lb_valid_case
Integer	li_rc
String	ls_rel_type,		&
			ls_rel_id,			&
			ls_rel_subtype,	&
			ls_message

lb_valid_case	=	TRUE

ls_rel_subtype = inv_notes.is_notes_sub_type
ls_rel_type		=	inv_notes.is_notes_rel_type
ls_rel_id		=	inv_notes.is_notes_rel_id

CHOOSE CASE inv_notes.is_notes_rel_type
	CASE 'CA'
		// Case note
		lb_valid_case	=	inv_case.uf_edit_case_deleted (inv_notes.is_notes_rel_id)
		ls_message		=	"Case note "	+	inv_notes.is_notes_id	+	&
								" (" + ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted."
	CASE 'PA'
		// Patterns note
		ls_rel_type		=	'PAT'
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, ls_rel_type)
		ls_message		=	"Patterns note "	+	inv_notes.is_notes_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted for pattern "	+	ls_rel_id	+	"."
	CASE 'PQ'
		// PDQ note
		ls_rel_type		=	'PDQ'
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, ls_rel_type)
		ls_message		=	"PDQ note "	+	inv_notes.is_notes_id	+ " (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted for query "	+	ls_rel_id	+	"."
	CASE 'SS'
		// Subset note
		ls_rel_type		=	'SUB'
		lb_valid_case	=	inv_case.uf_edit_case_closed (inv_notes.is_notes_rel_id, ls_rel_type)
		ls_message		=	"Subset note "	+	inv_notes.is_notes_id	+	" (" + &
								ls_rel_type + "/" + ls_rel_subtype + " )" + &
								" deleted for subset "	+	ls_rel_id	+	"."
END CHOOSE

IF	lb_valid_case	=	FALSE		THEN
	MessageBox ('Case Error', 'This note cannot be deleted because its associated case '	+	&
					'is either closed or deleted')
	Return
END IF
// FDG 09/21/01 end

lv_message_nbr = MessageBox ('CONFIRMATION!', 'Delete Selected Note', &
                   Question!,YesNo!,2)
Choose Case lv_message_nbr
Case 2
     Return
End Choose

Delete from notes
       where user_id  = Upper( :gv_user_id )
		   and note_id  = Upper( :inv_notes.is_notes_id )
			and note_rel_type = Upper( :inv_notes.is_notes_rel_type )
			and note_rel_id   = Upper( :inv_notes.is_notes_rel_id )
using stars2ca;
If stars2ca.of_check_status() = 100 Then
	 Messagebox('Error','Record has already been Deleted')
ElseIf stars2ca.sqlcode <> 0 Then
		 LV_SQLUSRMSG = 'Delete Failed' + stars2ca.sqlerrtext
   	 errorbox(stars2ca,lv_sqlusrmsg)
		 cb_exit.default = true
		 RETURN
End If

// FDG 09/21/01 begin
li_rc	=	inv_case.uf_audit_log (ls_rel_id, ls_rel_type, ls_message)

IF	li_rc	<	0		THEN
	Stars2ca.of_rollback()
	MessageBox ('Database Error', 'Could not insert case log for note '	+	inv_notes.is_notes_id	+	&
					'.  Script: '		+	&
					'w_notes_maint.cb_update.clicked')
	Return
END IF
// FDG 09/21/01 end

//KMM 8/24/95 If notes no longer exist, then make picture invisible
Select count(*) into :lv_count
From notes
where note_rel_type = 'CA'  and
note_rel_id   = Upper( :sle_rel_name.text )
Using stars2ca;
If stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error reading Notes table: note_rel_type = CA and note_rel_id = ' + sle_rel_name.text)
	RETURN
end if
if lv_count <= 0 then
	if isvalid(w_case_maint) then
		w_case_maint.p_notes.visible = false
	end if
	if isvalid(w_case_folder_view) then
		w_case_folder_view.p_notes.visible = false
	end if
end if
stars2ca.of_commit()

deleterow(dw_1,0)
st_row_count.text = string(integer(st_row_count.text) - 1)
dw_1.resetupdate()
If integer(st_row_count.text) > 0 then
	lv_row = getrow(dw_1)
	selectrow(dw_1,lv_row,true)
	setrow(dw_1,lv_row)
	gv_USER_ID            = getitemstring(dw_1,lv_row,1)
	inv_notes.is_notes_id   = getitemstring(dw_1,lv_row,'note_id')
	inv_notes.is_notes_rel_type = getitemstring(dw_1,lv_row,'note_rel_type')
	inv_notes.is_notes_rel_id = getitemstring(dw_1,lv_row,'note_rel_id')
	cb_select.default = true
Else
	cb_select.enabled = false
	cb_delete.enabled = false
	cb_list.default = true
End If

setfocus(dw_1)
cb_exit.default = true
setpointer(arrow!)

end event

type cb_exit from u_cb within w_notes_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2327
integer y = 1440
integer width = 338
integer height = 108
integer taborder = 160
string text = "&Close"
end type

event clicked;//=================================================================================
//clicked for cb_exit of w_notes_list
//Modifications:
//05-12-98	NLG	1. replace notes globals with notes nvo
// JasonS 10/17/02 Track 2883d reset note_desc in n_cst_notes
//=================================================================================

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
//gv_notes_name = ''
//gv_notes_rel_type = ''
//gv_notes_rel_name = ''
//gv_notes_sub_type=''
//gv_notes_from = 'MM'
inv_notes.is_notes_id = ''
inv_notes.is_notes_rel_type = ''
inv_notes.is_notes_rel_id = ''
inv_notes.is_notes_sub_type =''
inv_notes.is_notes_from = 'MM'
inv_notes.is_notes_desc = ''	// JasonS 10/17/02 Track 2883d

close(w_notes_maint)
close(parent)
end event

type gb_1 from groupbox within w_notes_list
string accessiblename = "Sort By"
string accessibledescription = "Sort By"
accessiblerole accessiblerole = groupingrole!
integer x = 1705
integer y = 24
integer width = 978
integer height = 172
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Sort By"
end type

type sle_range from editmask within w_notes_list
string accessiblename = "Range"
string accessibledescription = "Range"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 1454
integer y = 92
integer width = 229
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####"
end type

