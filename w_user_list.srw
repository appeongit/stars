HA$PBExportHeader$w_user_list.srw
$PBExportComments$User List and Case Subset Criteria (inherited from w_master)
forward
global type w_user_list from w_master
end type
type cb_list from u_cb within w_user_list
end type
type st_row_count from statictext within w_user_list
end type
type cb_exit from u_cb within w_user_list
end type
type dw_user_list from u_dw within w_user_list
end type
end forward

global type w_user_list from w_master
string accessiblename = "User List Window"
string accessibledescription = "User List"
accessiblerole accessiblerole = windowrole!
integer x = 41
integer y = 0
integer width = 3086
integer height = 1908
string title = "User List"
long backcolor = 67108864
event ue_refresh ( )
cb_list cb_list
st_row_count st_row_count
cb_exit cb_exit
dw_user_list dw_user_list
end type
global w_user_list w_user_list

type variables

end variables

event ue_refresh;////////////////////////////////////////////////////////////////////////
//
// 10/06/2000 GaryR 2316d Redesign the user maintenance screen
//
////////////////////////////////////////////////////////////////////////

Long	ll_row

dw_user_list.SetRedraw( FALSE )

// Refresh the user list screen
ll_row  = dw_user_list.GetSelectedRow( 0 )
cb_list.EVENT Clicked()
	
IF ll_row > 0 THEN
	dw_user_list.SetRow( ll_row )
	dw_user_list.SelectRow( 0, FALSE )				
	dw_user_list.SelectRow( ll_row, TRUE )
	dw_user_list.ScrollToRow( ll_row )
END IF

dw_user_list.SetRedraw( TRUE )
end event

event open;call super::open;setpointer(hourglass!)
setmicrohelp(w_main,'Opening User List')
triggerevent(cb_list,clicked!)
RETURN
end event

on w_user_list.create
int iCurrent
call super::create
this.cb_list=create cb_list
this.st_row_count=create st_row_count
this.cb_exit=create cb_exit
this.dw_user_list=create dw_user_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_list
this.Control[iCurrent+2]=this.st_row_count
this.Control[iCurrent+3]=this.cb_exit
this.Control[iCurrent+4]=this.dw_user_list
end on

on w_user_list.destroy
call super::destroy
destroy(this.cb_list)
destroy(this.st_row_count)
destroy(this.cb_exit)
destroy(this.dw_user_list)
end on

type cb_list from u_cb within w_user_list
string accessiblename = "List"
string accessibledescription = "List"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2560
integer y = 1716
integer width = 233
integer taborder = 20
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&List"
end type

event clicked;int rc
long lv_nbr_rows

setpointer(hourglass!)
setmicrohelp(w_main,'Retrieving User List')
st_row_count.text = ''
reset(dw_user_list)

rc = dw_user_list.SetTransObject(stars2ca)
if rc = -1 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	cb_exit.default = TRUE
	return
end if

//list arguments in order of dw argument list
lv_nbr_rows = Retrieve (dw_user_list)
if lv_nbr_rows = -1 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	cb_exit.default = TRUE
	return
end if
If lv_nbr_rows = 0 Then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
   return
end if 
	
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

//cb_select.default = true Katie 09/20/04 Track 3699
setfocus(dw_user_list)
selectrow(dw_user_list,0,false)
dw_user_list.selectrow(1,true)
dw_user_list.setrow(1)

st_row_count.text = string(lv_nbr_rows)
SETPOINTER(ARROW!)
setmicrohelp(w_main,'Ready')
end event

type st_row_count from statictext within w_user_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer y = 1720
integer width = 274
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_exit from u_cb within w_user_list
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2807
integer y = 1716
integer width = 233
integer taborder = 70
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

on clicked;close (parent)
end on

type dw_user_list from u_dw within w_user_list
string accessiblename = "User List Data"
string accessibledescription = "User List Data"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title = User List"
integer width = 3040
integer height = 1704
integer taborder = 10
string dataobject = "d_user_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;This.of_SingleSelect( TRUE )
end event

