HA$PBExportHeader$w_notes_list_response.srw
$PBExportComments$Inherited from w_notes_list.
forward
global type w_notes_list_response from w_notes_list
end type
end forward

global type w_notes_list_response from w_notes_list
string accessiblename = "Note List"
string accessibledescription = "Note List"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
int X=457
int Y=364
WindowType WindowType=response!
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_notes_list_response w_notes_list_response

type variables
Integer	ii_rtn
end variables

on w_notes_list_response.create
call super::create
end on

on w_notes_list_response.destroy
call super::destroy
end on

event close;/*
Gary-R	04/27/2000	Ts2173	this is a lookup window // Override Ancestor
*/

// Return value of 0 indicates that this window was simply closed
Message.DoubleParm = ii_rtn

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;cb_delete.Enabled = FALSE	//Gary-R	04/27/2000	Ts2173	Disable cb_delete since this window is used for lookup purposes
end event

type cb_select from w_notes_list`cb_select within w_notes_list_response
string Text="&Use"
end type

event cb_select::clicked;//**************************************************************************************
//Gary-R	04/27/2000	Ts2173	Override ancestor since window is lookup
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
		ii_rtn = 1
		CloseWithReturn( PARENT, inv_notes )	//Gary-R	04/27/2000	Ts2173
	END IF

else																							//08-14-97 FNC
	ii_rtn = 1
	CloseWithReturn( PARENT, inv_notes )	//Gary-R	04/27/2000	Ts2173
End if//if inv_notes.is_notes_rel_type = 'CA' then
setpointer (arrow!)
end event

type cb_new from w_notes_list`cb_new within w_notes_list_response
boolean Enabled=false
end type

type cb_delete from w_notes_list`cb_delete within w_notes_list_response
boolean Enabled=false
end type

event cb_exit::clicked;// Gary-R	04/27/2000	Ts2173	Override ancestor since window is used as lookup
Close( PARENT )
end event

type sle_range from w_notes_list`sle_range within w_notes_list_response
boolean BringToTop=true
end type

