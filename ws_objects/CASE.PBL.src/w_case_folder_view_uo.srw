$PBExportHeader$w_case_folder_view_uo.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_folder_view_uo from w_master
end type
type uo_1 from uo_case_folder_view within w_case_folder_view_uo
end type
end forward

global type w_case_folder_view_uo from w_master
boolean visible = false
string accessiblename = "Options"
string accessibledescription = "Options"
accessiblerole accessiblerole = windowrole!
integer x = 649
integer y = 704
integer width = 1623
integer height = 468
string title = "Options"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
windowtype windowtype = popup!
long backcolor = 67108864
uo_1 uo_1
end type
global w_case_folder_view_uo w_case_folder_view_uo

event open;call super::open;setpointer(hourglass!)
end event

on w_case_folder_view_uo.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_case_folder_view_uo.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from uo_case_folder_view within w_case_folder_view_uo
string accessiblename = "Case Folder More Options"
string accessibledescription = "Case Folder More Options"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
integer y = 4
integer height = 364
end type

on uo_1.destroy
call uo_case_folder_view::destroy
end on

