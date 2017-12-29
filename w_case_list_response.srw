HA$PBExportHeader$w_case_list_response.srw
$PBExportComments$Response window inherited from w_case_list.
forward
global type w_case_list_response from w_case_list
end type
end forward

global type w_case_list_response from w_case_list
string accessiblename = "Case List Window"
string accessibledescription = "Case List Window"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
integer x = 407
integer y = 364
integer width = 3666
integer height = 2060
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_case_list_response w_case_list_response

on w_case_list_response.create
call super::create
end on

on w_case_list_response.destroy
call super::destroy
end on

type dw_search from w_case_list`dw_search within w_case_list_response
integer width = 3602
integer height = 564
end type

type st_dw_ops from w_case_list`st_dw_ops within w_case_list_response
integer y = 1740
end type

type ddlb_dw_ops from w_case_list`ddlb_dw_ops within w_case_list_response
integer y = 1800
end type

type cb_use from w_case_list`cb_use within w_case_list_response
integer x = 3017
integer y = 1864
end type

type cb_total from w_case_list`cb_total within w_case_list_response
integer x = 2734
integer y = 1864
end type

type cb_log from w_case_list`cb_log within w_case_list_response
integer x = 2450
integer y = 1864
end type

type cb_list from w_case_list`cb_list within w_case_list_response
integer x = 1883
integer y = 1864
end type

type cb_close from w_case_list`cb_close within w_case_list_response
integer x = 3301
integer y = 1864
end type

type cb_stop from w_case_list`cb_stop within w_case_list_response
integer x = 1600
integer y = 1864
integer width = 279
integer height = 80
end type

type cb_select from w_case_list`cb_select within w_case_list_response
integer x = 2167
integer y = 1864
end type

type gb_1 from w_case_list`gb_1 within w_case_list_response
integer width = 3625
integer height = 632
end type

type dw_1 from w_case_list`dw_1 within w_case_list_response
integer y = 652
integer width = 3616
string is_run_date = "0.00"
end type

type st_row_count from w_case_list`st_row_count within w_case_list_response
integer y = 1892
end type

