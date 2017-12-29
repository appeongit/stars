HA$PBExportHeader$w_filter_list_response.srw
$PBExportComments$Inherited from w_filter_list (stfilter) - no code in this window.
forward
global type w_filter_list_response from w_filter_list
end type
end forward

global type w_filter_list_response from w_filter_list
string accessiblename = "Filter List"
string accessibledescription = "Filter List"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
WindowType WindowType=response!
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_filter_list_response w_filter_list_response

on w_filter_list_response.create
call w_filter_list::create
end on

on w_filter_list_response.destroy
call w_filter_list::destroy
end on

