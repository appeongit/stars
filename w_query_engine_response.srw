HA$PBExportHeader$w_query_engine_response.srw
$PBExportComments$Response window version of w_query_engine - No code in this window.
forward
global type w_query_engine_response from w_query_engine
end type
end forward

global type w_query_engine_response from w_query_engine
boolean controlmenu = false
string accessiblename = "Query Response Window"
string accessibledescription = "Query Response Window"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_query_engine_response w_query_engine_response

on w_query_engine_response.create
call super::create
end on

on w_query_engine_response.destroy
call super::destroy
end on

event ue_open_rmm;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

//	Ancestor overridden
//	Do not allow popup menus on response windows.  (Section 508)

end event

type dw_pdr_sources from w_query_engine`dw_pdr_sources within w_query_engine_response
end type

type dw_pdq_cntl from w_query_engine`dw_pdq_cntl within w_query_engine_response
end type

type dw_pdq_case_link from w_query_engine`dw_pdq_case_link within w_query_engine_response
end type

type dw_pdq_criteria from w_query_engine`dw_pdq_criteria within w_query_engine_response
end type

type dw_pdq_columns from w_query_engine`dw_pdq_columns within w_query_engine_response
end type

type tab_level from w_query_engine`tab_level within w_query_engine_response
boolean bringtotop = true
end type

type tabpage_1 from w_query_engine`tabpage_1 within tab_level
end type

type tabpage_2 from w_query_engine`tabpage_2 within tab_level
end type

type tabpage_3 from w_query_engine`tabpage_3 within tab_level
end type

type tabpage_4 from w_query_engine`tabpage_4 within tab_level
end type

type tabpage_5 from w_query_engine`tabpage_5 within tab_level
end type

type tabpage_6 from w_query_engine`tabpage_6 within tab_level
end type

type tabpage_7 from w_query_engine`tabpage_7 within tab_level
end type

type tabpage_8 from w_query_engine`tabpage_8 within tab_level
end type

type tabpage_9 from w_query_engine`tabpage_9 within tab_level
end type

type tabpage_10 from w_query_engine`tabpage_10 within tab_level
end type

type dw_pdq_tables from w_query_engine`dw_pdq_tables within w_query_engine_response
end type

