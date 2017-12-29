HA$PBExportHeader$w_sampling_analysis_new_response.srw
$PBExportComments$Opened from case folder (Response window inherited from w_sampling_analysis_new)
forward
global type w_sampling_analysis_new_response from w_sampling_analysis_new
end type
end forward

global type w_sampling_analysis_new_response from w_sampling_analysis_new
boolean controlmenu = false
string accessiblename = "Pattern Recognition Analysis Window"
string accessibledescription = "Pattern Recognition Analysis Window"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_sampling_analysis_new_response w_sampling_analysis_new_response

on w_sampling_analysis_new_response.create
call super::create
end on

on w_sampling_analysis_new_response.destroy
call super::destroy
end on

event ue_open_rmm;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

//	Ancestor overridden
//	Do not allow popup menus on response windows.  (Section 508)
end event

type tab_patt from w_sampling_analysis_new`tab_patt within w_sampling_analysis_new_response
end type

type tabpage_list from w_sampling_analysis_new`tabpage_list within tab_patt
end type

type gb_2 from w_sampling_analysis_new`gb_2 within tabpage_list
end type

type uo_list_rmm from w_sampling_analysis_new`uo_list_rmm within tabpage_list
end type

type dw_parms from w_sampling_analysis_new`dw_parms within tabpage_list
end type

type dw_list from w_sampling_analysis_new`dw_list within tabpage_list
end type

type dw_list_desc from w_sampling_analysis_new`dw_list_desc within tabpage_list
end type

type st_count_list from w_sampling_analysis_new`st_count_list within tabpage_list
end type

type cb_list_list from w_sampling_analysis_new`cb_list_list within tabpage_list
end type

type cb_list_select from w_sampling_analysis_new`cb_list_select within tabpage_list
end type

type cb_list_next from w_sampling_analysis_new`cb_list_next within tabpage_list
end type

type cb_list_close from w_sampling_analysis_new`cb_list_close within tabpage_list
end type

type tabpage_criteria from w_sampling_analysis_new`tabpage_criteria within tab_patt
end type

type gb_1 from w_sampling_analysis_new`gb_1 within tabpage_criteria
end type

type gb_3 from w_sampling_analysis_new`gb_3 within tabpage_criteria
end type

type cbx_not from w_sampling_analysis_new`cbx_not within tabpage_criteria
end type

type dw_patt_cntl from w_sampling_analysis_new`dw_patt_cntl within tabpage_criteria
end type

type cb_criteria_clear from w_sampling_analysis_new`cb_criteria_clear within tabpage_criteria
end type

type cb_criteria_next from w_sampling_analysis_new`cb_criteria_next within tabpage_criteria
end type

type cb_criteria_prev from w_sampling_analysis_new`cb_criteria_prev within tabpage_criteria
end type

type cb_criteria_close from w_sampling_analysis_new`cb_criteria_close within tabpage_criteria
end type

type pb_notes from w_sampling_analysis_new`pb_notes within tabpage_criteria
end type

type dw_criteria from w_sampling_analysis_new`dw_criteria within tabpage_criteria
end type

type uo_criteria_rmm from w_sampling_analysis_new`uo_criteria_rmm within tabpage_criteria
end type

type tabpage_options from w_sampling_analysis_new`tabpage_options within tab_patt
end type

type uo_options_rmm from w_sampling_analysis_new`uo_options_rmm within tabpage_options
end type

type dw_patt_options from w_sampling_analysis_new`dw_patt_options within tabpage_options
end type

type cb_options_clear from w_sampling_analysis_new`cb_options_clear within tabpage_options
end type

type cb_options_next from w_sampling_analysis_new`cb_options_next within tabpage_options
end type

type cb_options_prev from w_sampling_analysis_new`cb_options_prev within tabpage_options
end type

type cb_options_close from w_sampling_analysis_new`cb_options_close within tabpage_options
end type

type tabpage_timeframe from w_sampling_analysis_new`tabpage_timeframe within tab_patt
end type

type uo_timeframe_rmm from w_sampling_analysis_new`uo_timeframe_rmm within tabpage_timeframe
end type

type dw_timeframe from w_sampling_analysis_new`dw_timeframe within tabpage_timeframe
end type

type cb_timeframe_clear from w_sampling_analysis_new`cb_timeframe_clear within tabpage_timeframe
end type

type cb_timeframe_next from w_sampling_analysis_new`cb_timeframe_next within tabpage_timeframe
end type

type cb_timeframe_prev from w_sampling_analysis_new`cb_timeframe_prev within tabpage_timeframe
end type

type cb_timeframe_close from w_sampling_analysis_new`cb_timeframe_close within tabpage_timeframe
end type

type tabpage_custom from w_sampling_analysis_new`tabpage_custom within tab_patt
end type

type uo_custom_rmm from w_sampling_analysis_new`uo_custom_rmm within tabpage_custom
end type

type dw_title from w_sampling_analysis_new`dw_title within tabpage_custom
end type

type st_1 from w_sampling_analysis_new`st_1 within tabpage_custom
end type

type st_2 from w_sampling_analysis_new`st_2 within tabpage_custom
end type

type dw_available from w_sampling_analysis_new`dw_available within tabpage_custom
end type

type dw_selected from w_sampling_analysis_new`dw_selected within tabpage_custom
end type

type cb_custom_add from w_sampling_analysis_new`cb_custom_add within tabpage_custom
end type

type cb_custom_remove from w_sampling_analysis_new`cb_custom_remove within tabpage_custom
end type

type cb_custom_up from w_sampling_analysis_new`cb_custom_up within tabpage_custom
end type

type cb_custom_down from w_sampling_analysis_new`cb_custom_down within tabpage_custom
end type

type st_custom_count from w_sampling_analysis_new`st_custom_count within tabpage_custom
end type

type cb_custom_next from w_sampling_analysis_new`cb_custom_next within tabpage_custom
end type

type cb_custom_prev from w_sampling_analysis_new`cb_custom_prev within tabpage_custom
end type

type cb_custom_close from w_sampling_analysis_new`cb_custom_close within tabpage_custom
end type

type tabpage_report from w_sampling_analysis_new`tabpage_report within tab_patt
end type

type uo_report_rmm from w_sampling_analysis_new`uo_report_rmm within tabpage_report
end type

type dw_report from w_sampling_analysis_new`dw_report within tabpage_report
end type

type st_count from w_sampling_analysis_new`st_count within tabpage_report
end type

type cb_report_prev from w_sampling_analysis_new`cb_report_prev within tabpage_report
end type

type cb_report_close from w_sampling_analysis_new`cb_report_close within tabpage_report
end type

type dw_3 from w_sampling_analysis_new`dw_3 within w_sampling_analysis_new_response
end type

type dw_2 from w_sampling_analysis_new`dw_2 within w_sampling_analysis_new_response
end type

