HA$PBExportHeader$w_case_subset_list.srw
$PBExportComments$Lists only subsets for a case (Inherited from w_master)
forward
global type w_case_subset_list from w_master
end type
type cb_stop from u_cb within w_case_subset_list
end type
type st_row_count from statictext within w_case_subset_list
end type
type cb_use from u_cb within w_case_subset_list
end type
type cb_close from u_cb within w_case_subset_list
end type
type dw_1 from u_dw within w_case_subset_list
end type
end forward

global type w_case_subset_list from w_master
string accessiblename = "Subsets in Active Case"
string accessibledescription = "Subsets in Active Case"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 540
integer width = 2075
integer height = 988
string title = "Subsets in Active Case"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
cb_stop cb_stop
st_row_count st_row_count
cb_use cb_use
cb_close cb_close
dw_1 dw_1
end type
global w_case_subset_list w_case_subset_list

type variables
string in_key, in_subset_id, in_subset_case
Boolean in_cancel

end variables

event open;call super::open;setpointer(hourglass!) 
//fx_set_window_colors(w_case_subset_list)
int lv_nbr_rows
String 	lv_case_id,lv_case_id_spl,lv_case_id_ver

//w_case_subset_list.x = 1
//w_case_subset_list.y = 1150

lv_case_id = left(gv_active_case,10)
lv_case_id_spl = mid(gv_active_case,11,2)
lv_case_id_ver = mid(gv_active_case,13,2)

Reset(dw_1)

If SetTransObject(dw_1,stars2ca) < 0 then
   Errorbox(stars2ca,'Error Setting Case Transaction Object')
   RETURN
End If
	
//list arguments in order of dw argument list
lv_nbr_rows = Retrieve(dw_1,lv_case_id,lv_case_id_spl,lv_case_id_ver)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	
If lv_nbr_rows <= 0 then
	Messagebox('LIST','No Subsets Associated with This Case',Exclamation!)
	cb_close.PostEvent(Clicked!)
	RETURN
End If

SetMicroHelp(w_case_subset_list,'Ready')
end event

on w_case_subset_list.create
int iCurrent
call super::create
this.cb_stop=create cb_stop
this.st_row_count=create st_row_count
this.cb_use=create cb_use
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stop
this.Control[iCurrent+2]=this.st_row_count
this.Control[iCurrent+3]=this.cb_use
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_1
end on

on w_case_subset_list.destroy
call super::destroy
destroy(this.cb_stop)
destroy(this.st_row_count)
destroy(this.cb_use)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type cb_stop from u_cb within w_case_subset_list
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2194
integer y = 60
integer width = 201
integer height = 108
integer taborder = 40
string text = "Stop"
end type

type st_row_count from statictext within w_case_subset_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 82
integer y = 764
integer width = 334
integer height = 80
integer textsize = -10
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

on clicked;in_cancel = true
end on

type cb_use from u_cb within w_case_subset_list
string accessiblename = "Use"
string accessibledescription = "Use"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1312
integer y = 764
integer width = 334
integer height = 108
integer taborder = 30
string text = "&Use"
boolean default = true
end type

event clicked;//********************************************************************
//* This button will allow the user to select a subset to make active.
//* Only subsets related to the case will be displayed.
//********************************************************************
// 3-16-98 ajs 4.0 TS145 - Hard Coding Removal
// 2-11-98 ajs 4.0 ts145 - global subset case id, subset name and id
If in_key <> '' Then
	gv_result =0
//	gv_subset_id = in_key
	gc_active_subset_name = in_key
	If isvalid(w_subset_active) then
//		gv_active_subset = gv_subset_id
      gc_active_subset_id = in_subset_id
		gc_active_subset_case = in_subset_case
//		w_subset_active.in_subset_in_what_table = 'SC' // 03-16-98 ajs 4.0 TS145 - Hard Coding Removal
		//triggerevent(w_subset_active.cb_return_from_subset_list,clicked!)	
	End If
	close(parent)
Else
	gv_result = 100
End If



	
end event

type cb_close from u_cb within w_case_subset_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1691
integer y = 764
integer width = 334
integer height = 108
integer taborder = 20
string text = "&Close"
end type

on clicked;gv_result = 100
close(parent)
end on

type dw_1 from u_dw within w_case_subset_list
string accessiblename = "Case Subset List"
string accessibledescription = "Case Subset List"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = Case Subset List"
integer x = 27
integer y = 12
integer width = 2007
integer height = 736
integer taborder = 10
string dataobject = "d_case_subset_list"
boolean vscrollbar = true
end type

on retrieveend;in_cancel = true
//parent.controlmenu = true								//FDG 06/13/96
cb_stop.enabled = false
st_row_count.text = string(rowcount())
triggerevent(dw_1,rowfocuschanged!)
end on

on retrievestart;setpointer(hourglass!)
setmicrohelp('Retrieving case subset list')
//	Parent.controlmenu = false								//FDG 06/13/96
in_cancel = false
//cb_stop.enabled = true
end on

event rowfocuschanged;long lv_row_nbr
string lv_case_id, lv_case_spl, lv_case_ver
setpointer(hourglass!)
setmicrohelp(w_main,'')
If not in_cancel then 
	RETURN
End If

lv_row_nbr = getrow(dw_1)
// FDG 01/17/02 Track 2699d.  If no rows exist, get out
If lv_row_nbr = 0 			&
or	This.RowCount()	<	1	then 
   selectrow(dw_1,0,false)
	in_key   = ''
	cb_use.enabled = false
	cb_close.default = true
   RETURN
End If

selectrow(dw_1,0,false)
selectrow(dw_1,lv_row_nbr,true)
setrow(dw_1,lv_row_nbr)
in_key = getitemstring(dw_1,lv_row_nbr,'link_name')		//ajs 4.0 02-11-98
lv_case_id = getitemstring(dw_1,lv_row_nbr,'case_id')		//ajs 4.0 02-11-98
lv_case_spl = getitemstring(dw_1,lv_row_nbr,'case_spl')	//ajs 4.0 02-11-98
lv_case_ver = getitemstring(dw_1,lv_row_nbr,'case_ver')	//ajs 4.0 02-11-98
in_subset_case = lv_case_id + lv_case_spl + lv_case_ver 	//ajs 4.0 02-11-98
in_subset_id = getitemstring(dw_1,lv_row_nbr,'link_key')	//ajs 4.0 02-11-98
cb_use.default = true
setpointer(arrow!)
end event

event doubleclicked;//*************************************************************
//* This script will select the subset to make active and close
//* it out.
//*************************************************************
integer lv_row
setmicrohelp(w_main,'')
setpointer(hourglass!)

//lv_row = getclickedrow(dw_1) 
lv_row = row

If lv_row > 0 then
	selectrow(dw_1,0,false)
	selectrow(dw_1,lv_row,true)
	triggerevent(dw_1,rowfocuschanged!)
	triggerevent(cb_use,clicked!)
End If
setpointer(arrow!)
end event

