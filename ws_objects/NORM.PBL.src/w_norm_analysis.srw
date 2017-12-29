$PBExportHeader$w_norm_analysis.srw
$PBExportComments$Inherited from w_master
forward
global type w_norm_analysis from w_master
end type
type sle_sel_spec from u_sle within w_norm_analysis
end type
type sle_sel_proc from u_sle within w_norm_analysis
end type
type sle_sel_mod from u_sle within w_norm_analysis
end type
type uo_1 from u_display_period within w_norm_analysis
end type
type sle_sel_reviewed from singlelineedit within w_norm_analysis
end type
type em_reviewed_where from editmask within w_norm_analysis
end type
type em_percent_change_connect from editmask within w_norm_analysis
end type
type st_12 from statictext within w_norm_analysis
end type
type em_mod_connect from editmask within w_norm_analysis
end type
type em_mod_where from editmask within w_norm_analysis
end type
type st_11 from statictext within w_norm_analysis
end type
type st_7 from statictext within w_norm_analysis
end type
type st_count from statictext within w_norm_analysis
end type
type st_10 from statictext within w_norm_analysis
end type
type em_percent_change_where from editmask within w_norm_analysis
end type
type em_allowed_amt_connect from editmask within w_norm_analysis
end type
type em_allowed_amt_where from editmask within w_norm_analysis
end type
type em_denied_services_where from editmask within w_norm_analysis
end type
type em_allowed_srvc_where from editmask within w_norm_analysis
end type
type em_sav_where from editmask within w_norm_analysis
end type
type em_spec_where from editmask within w_norm_analysis
end type
type em_proc_where from editmask within w_norm_analysis
end type
type em_denied_srvc_connect from editmask within w_norm_analysis
end type
type em_allowed_srvc_connect from editmask within w_norm_analysis
end type
type em_sav_connect from editmask within w_norm_analysis
end type
type em_spec_connect from editmask within w_norm_analysis
end type
type em_proc_connect from editmask within w_norm_analysis
end type
type st_8 from statictext within w_norm_analysis
end type
type st_6 from statictext within w_norm_analysis
end type
type ddlb_sort from dropdownlistbox within w_norm_analysis
end type
type st_5 from statictext within w_norm_analysis
end type
type sle_sel_denied_services from singlelineedit within w_norm_analysis
end type
type st_4 from statictext within w_norm_analysis
end type
type sle_sel_allowed_amt from singlelineedit within w_norm_analysis
end type
type st_2 from statictext within w_norm_analysis
end type
type sle_sel_allowed_srvc from singlelineedit within w_norm_analysis
end type
type cb_graph from u_cb within w_norm_analysis
end type
type st_top_label from statictext within w_norm_analysis
end type
type cb_clear from u_cb within w_norm_analysis
end type
type cb_view_report from u_cb within w_norm_analysis
end type
type sle_percent from singlelineedit within w_norm_analysis
end type
type st_3 from statictext within w_norm_analysis
end type
type st_1 from statictext within w_norm_analysis
end type
type sle_sel_sav from singlelineedit within w_norm_analysis
end type
type ddlb_list from dropdownlistbox within w_norm_analysis
end type
type cb_close from u_cb within w_norm_analysis
end type
type cb_query from u_cb within w_norm_analysis
end type
type st_9 from statictext within w_norm_analysis
end type
type sle_percent_change from singlelineedit within w_norm_analysis
end type
end forward

shared variables

end variables

global type w_norm_analysis from w_master
string accessiblename = "Norm Analysis"
string accessibledescription = "Norm Analysis"
integer x = 169
integer y = 0
integer width = 2711
integer height = 1648
string title = "Norm Analysis"
sle_sel_spec sle_sel_spec
sle_sel_proc sle_sel_proc
sle_sel_mod sle_sel_mod
uo_1 uo_1
sle_sel_reviewed sle_sel_reviewed
em_reviewed_where em_reviewed_where
em_percent_change_connect em_percent_change_connect
st_12 st_12
em_mod_connect em_mod_connect
em_mod_where em_mod_where
st_11 st_11
st_7 st_7
st_count st_count
st_10 st_10
em_percent_change_where em_percent_change_where
em_allowed_amt_connect em_allowed_amt_connect
em_allowed_amt_where em_allowed_amt_where
em_denied_services_where em_denied_services_where
em_allowed_srvc_where em_allowed_srvc_where
em_sav_where em_sav_where
em_spec_where em_spec_where
em_proc_where em_proc_where
em_denied_srvc_connect em_denied_srvc_connect
em_allowed_srvc_connect em_allowed_srvc_connect
em_sav_connect em_sav_connect
em_spec_connect em_spec_connect
em_proc_connect em_proc_connect
st_8 st_8
st_6 st_6
ddlb_sort ddlb_sort
st_5 st_5
sle_sel_denied_services sle_sel_denied_services
st_4 st_4
sle_sel_allowed_amt sle_sel_allowed_amt
st_2 st_2
sle_sel_allowed_srvc sle_sel_allowed_srvc
cb_graph cb_graph
st_top_label st_top_label
cb_clear cb_clear
cb_view_report cb_view_report
sle_percent sle_percent
st_3 st_3
st_1 st_1
sle_sel_sav sle_sel_sav
ddlb_list ddlb_list
cb_close cb_close
cb_query cb_query
st_9 st_9
sle_percent_change sle_percent_change
end type
global w_norm_analysis w_norm_analysis

type variables
string sel_where,in_order_by
string iv_invoice_type
string iv_first_norm_table
string iv_first_norm_alias
string iv_second_norm_table
string iv_second_norm_alias
string iv_message

sx_dictionary_data iv_dict_structure[]
sx_norm_analysis_parms isx_norm_analysis_parms
end variables

forward prototypes
public function integer build_sql (string what)
public function long wf_count_norms (long arg_period)
end prototypes

public function integer build_sql (string what);//********************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//	02/16/07	GaryR	Track 4905	Centralize logic to prevent PB reference bugs
//	05/17/07	GaryR	Track 5026	Prevent divide-by-zero
//********************************************************************

string sel_count, sel_list_srvc, sel_list_hic, sel_list_dollars
string sel_prov, sel_proc, sel_mod, sel_area, sel_spec, sel_sav, sel_rev
string sel_what,sel_who,sel_when,sel_how
string sel_order_by,sel_group_by,sel_having,sel_from,sel_sum,where,sel_all_srvc,sel_den_srvc 
string sel_allw_amt,period,period_connect,sel_connect
string temp_sel
integer lv_index
date cdate
if what <> '' Then
	sel_what = 'Select '+what
end if
//********************************************************************
//* FROM
//********************************************************************
if what <> '' Then
   sel_from = ' from ' + iv_first_norm_table + ' where '  // SG Nov 94
else 
	sel_from = ' where '
end if
sel_having = ''
sel_group_by = ''
sel_order_by = ''

//********************************************************************
//* COMPARE and ORDER BY
//********************************************************************
if what <> 'COUNT(*)' Then
	if ddlb_sort.text = 'Rank' and ddlb_list.text = 'Top' Then 
		sel_order_by = ' order by carr_rank asc,natl_rank desc,prov_spec asc,proc_code asc '
	elseif ddlb_sort.text = 'Rank' and ddlb_list.text = 'Bottom' Then 
		sel_order_by = ' order by carr_rank desc,natl_rank asc,prov_spec asc,proc_code asc '
	elseif ddlb_sort.text = 'Savings' and ddlb_list.text = 'Top' THEN
		sel_order_by = ' order by savings desc,prov_spec Asc,Proc_code Asc'
	elseif ddlb_sort.text = 'Savings' and ddlb_list.text = 'Bottom' THEN
		sel_order_by = ' order by savings asc,prov_spec asc,proc_code asc ' 
	elseif ddlb_sort.text = 'CARR Allow Srvc/1000' and ddlb_list.text = 'Top' Then	
		sel_order_by = ' order by carr_allow_srvc_per desc,prov_spec asc,proc_code asc '
	elseif ddlb_sort.text = 'CARR Allow Srvc/1000' and ddlb_list.text = 'Bottom' Then	
		sel_order_by = ' order by carr_allow_srvc_per asc,prov_spec asc,proc_code asc '
	elseif ddlb_sort.text = 'Procedure Code' and ddlb_list.text = 'Top' Then	
		sel_order_by = ' order by proc_code asc '
	elseif ddlb_sort.text = 'Procedure Code' and ddlb_list.text = 'Bottom' Then	
		sel_order_by = ' order by proc_code desc '
	elseif ddlb_sort.text = 'Specialty' and ddlb_list.text = 'Top' Then	
		sel_order_by = ' order by prov_spec asc '
	elseif ddlb_sort.text = 'Specialty' and ddlb_list.text = 'Bottom' Then	
		sel_order_by = ' order by prov_spec desc '
	elseif ddlb_sort.text = 'Procedure Code/Savings' Then	
		sel_order_by = ' order by Savings desc '
	elseif ddlb_sort.text = 'CARR Allow Chrg/1000' and ddlb_list.text = 'Top' Then	
		sel_order_by = ' order by CARR_ALLOW_CHRG_per desc '
	elseif ddlb_sort.text = 'CARR ALLOW Chrg/1000' and ddlb_list.text = 'Bottom' Then	
		sel_order_by = ' order by CARR_ALLOW_CHRG_per asc '
	elseif ddlb_sort.text = 'Percent Changed' and ddlb_list.text = 'Top' Then
		sel_order_by = ' ORDER BY ' + gnv_sql.of_get_norm_case() + ' desc '
	elseif ddlb_sort.text = 'Percent Changed' and ddlb_list.text = 'Bottom' Then	
		sel_order_by = ' ORDER BY ' + gnv_sql.of_get_norm_case() + ' asc '
	end if
end if

sel_where = ''

//********************************************************************
//* where PROCEDURE
//********************************************************************

if sle_sel_proc.text = '' then 
	em_proc_where.text = '='
	goto x_mod
end if
temp_sel = sle_sel_proc.text
lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROC_CODE" )

if lv_index = -1 Then
	messagebox("ERROR","PROC_CODE Not found in Dictionary")
	return -1
end if
where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_proc_where.text,temp_sel,'Proc Code',sle_sel_proc,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if

if match(temp_sel,'%') then
	temp_sel = left(temp_sel,len(temp_sel)- 1)
end if

sel_proc = format_where(temp_sel,where,'PROC_CODE')

if mid(sel_proc,1,1) = '!' then
   messagebox('Syntax Error',sel_proc)
   return -1
end if

if (where = 'LIKE' or where = 'NOT LIKE') and (pos(sel_proc,' OR ') > 0 or pos(sel_proc,' AND ') > 0) then
	sel_where = sel_where + sel_connect+ & 
               + sel_proc  + ' ' 
else
sel_where = sel_where + ' proc_code ' & 
            + where + ' ' & 
            + sel_proc  + ' ' 
end if
                      
//********************************************************************
//* where MODIFIER
//********************************************************************
x_mod:
if sle_sel_mod.text = '' then 
   em_mod_connect.text = 'AND'
	em_mod_where.text = '='
   goto x_spec
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROC_MOD" )
if lv_index = -1 Then
	messagebox("ERROR","PROC_MOD Not found in Dictionary")
	return -1
end if

temp_sel = sle_sel_mod.text
where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_mod_where.text,temp_sel,'Modifier',sle_sel_mod,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if

if match(temp_sel,'%') then
	temp_sel = left(temp_sel,len(temp_sel)- 1)
end if

sel_mod = format_where(temp_sel,where,'PROC_MOD')

if mid(sel_mod,1,1) = '!' then
   messagebox('Syntax Error',sel_mod)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_proc_connect.text
end if

if (where = 'LIKE' or where = 'NOT LIKE') and (pos(sel_mod,' OR ') > 0 or pos(sel_mod,' AND ') > 0) then
	sel_where = sel_where + sel_connect+ & 
               + sel_mod  + ' ' 
else
sel_where = sel_where + sel_connect + ' ' &
                      + ' proc_mod ' &
                      + where + ' ' & 
                      + sel_mod   + ' ' 
end if
                      
//********************************************************************
//* where SPECIALTY
//********************************************************************
x_spec:
if sle_sel_spec.text = '' then 
   em_proc_connect.text = 'AND'
	em_spec_where.text = '='
   goto x_sav
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROV_SPEC" )
if lv_index = -1 Then
	messagebox("ERROR","PROV_SPEC Not found in Dictionary")
	return -1
end if

temp_sel = sle_sel_spec.text
where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_spec_where.text,temp_sel,'prov_spec',sle_sel_spec,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if

if match(temp_sel,'%') then
	temp_sel = left(temp_sel,len(temp_sel)- 1)
end if

sel_spec = format_where(temp_sel,where,'PROV_SPEC')

if mid(sel_spec,1,1) = '!' then
   messagebox('Syntax Error',sel_spec)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_mod_connect.text
end if

if (where = 'LIKE' or where = 'NOT LIKE') and (pos(sel_spec,' OR ') > 0 or pos(sel_spec,' AND ') > 0) then
	sel_where = sel_where + sel_connect+ & 
               + sel_spec  + ' ' 
else
sel_where = sel_where + sel_connect + ' ' &
                      + ' prov_spec ' &
                      + where + ' ' & 
                      + sel_spec   + ' ' 
end if
                      
//********************************************************************
//* where SAVINGS
//********************************************************************
x_sav:
if sle_sel_sav.text = '' then 
   em_spec_connect.text = 'AND'
	em_sav_where.text = '>'
   goto x_allowed_srvc
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "SAVINGS" )
if lv_index = -1 Then
	messagebox("ERROR","SAVINGS Not found in Dictionary")
	return -1
end if
temp_sel = sle_sel_sav.text
where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_sav_where.text,temp_sel,'Savings',sle_sel_sav,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if

sel_sav = format_where_n(sle_sel_sav.text,where)

if mid(sel_sav,1,1) = '!' then
   messagebox('Syntax Error',sel_sav)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_spec_connect.text
end if

sel_where = sel_where + sel_connect + ' ' &
                      + ' savings ' &
                      + where + ' ' & 
                      + sel_sav   + ' ' 

//********************************************************************
//* where ALLOWED SERVICES/1000
//********************************************************************
x_allowed_srvc:
if sle_sel_allowed_srvc.text = '' then 
   em_sav_connect.text = 'AND'
   em_allowed_srvc_where.text = '>'
	goto x_den_srvc
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "CARR_ALLOW_SRVC_PER" )
if lv_index = -1 Then
	messagebox("ERROR","CARR_ALLOW_SRVC_PER Not found in Dictionary")
	return -1
end if

where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_allowed_srvc_where.text,sle_sel_allowed_srvc.text,'Allowed Srvc',sle_sel_allowed_srvc,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if
sel_all_srvc = format_where_n(sle_sel_allowed_srvc.text,where)

if mid(sel_all_srvc,1,1) = '!' then
   messagebox('Syntax Error',sel_all_srvc)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_sav_connect.text
end if

sel_where = sel_where + sel_connect + ' ' &
                      + ' carr_allow_srvc_per ' &
                      + where + ' ' & 
                      + sel_all_srvc   + ' ' 
//********************************************************************
//* where denied SERVICES
//********************************************************************
x_den_srvc:
if sle_sel_denied_services.text = '' then 
   em_allowed_srvc_connect.text = 'AND'
	em_denied_services_where.text = '>'
   goto x_allowed_amt
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "CARR_DEN_SRVC" )
if lv_index = -1 Then
	messagebox("ERROR","CARR_DEN_SRVC Not found in Dictionary")
	return -1
end if

where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_denied_services_where.text,sle_sel_denied_services.text,'Denied Srvc',sle_sel_denied_services,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if

sel_den_srvc = format_where_n(sle_sel_denied_services.text,where)

if mid(sel_den_srvc,1,1) = '!' then
   messagebox('Syntax Error',sel_den_srvc)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_allowed_srvc_connect.text
end if

sel_where = sel_where + sel_connect + ' ' &
                      + ' carr_den_srvc ' &
                      + where + ' ' & 
                      + sel_den_srvc  + ' ' 

//********************************************************************
//* where Allowed amount
//********************************************************************
x_allowed_amt:
if sle_sel_allowed_amt.text = '' then 
   em_denied_srvc_connect.text = 'AND'
	em_allowed_amt_where.text = '>'
   goto x_per_changed
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "CARR_ALLOW_CHRG" )
if lv_index = -1 Then
	messagebox("ERROR","CARR_ALLOW_CHRG Not found in Dictionary")
	return -1
end if
where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_allowed_amt_where.text,sle_sel_allowed_amt.text,'Allowed Chrg',sle_sel_allowed_amt,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if
sel_allw_amt = format_where_n(sle_sel_allowed_amt.text,where)

if mid(sel_allw_amt,1,1) = '!' then
   messagebox('Syntax Error',sel_allw_amt)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_denied_srvc_connect.text
end if

sel_where = sel_where + sel_connect + ' ' &
                      + ' Carr_Allow_Chrg ' &
                      + where + ' ' & 
                      + sel_allw_amt  + ' ' 

//********************************************************************
//* where Percent_changed
//********************************************************************
x_per_changed:
if sle_percent_change.text = '' then 
   em_allowed_amt_connect.text = 'AND'
	em_percent_change_where.text = '>'
	goto x_reviewed
end if

where = em_percent_change_where.text
where = fx_error_check_fields('NUMBER',em_percent_change_where.text,sle_percent_change.text,'Percent Changed',sle_percent_change,9,9,0)
if where = 'ERROR' Then
	return - 1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_allowed_amt_connect.text
end if

//DKG 11/29/95
//********************************************************************
//* where REVIEWED
//********************************************************************
x_reviewed:
if sle_sel_reviewed.text = '' then 
   em_percent_change_connect.text = 'AND'
	em_reviewed_where.text = '='
   goto x_period
end if

lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "REVIEWED_PRIOR_YEAR" )
if lv_index = -1 Then
	messagebox("ERROR","REVIEWED_PRIOR_YEAR Not found in Dictionary")
	return -1
end if

temp_sel = sle_sel_reviewed.text
where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_reviewed_where.text,temp_sel,'Reviewed',sle_sel_reviewed,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
if where = 'ERROR' Then
	return - 1
end if

if match(temp_sel,'%') then
	temp_sel = left(temp_sel,len(temp_sel)- 1)
end if

sel_rev = format_where(temp_sel,where,'REVIEWED_PRIOR_YEAR')

if mid(sel_rev,1,1) = '!' then
   messagebox('Syntax Error',sel_rev)
   return -1
end if

if sel_where = '' then
   sel_connect = ''
else
	sel_connect = em_percent_change_connect.text
end if

if (where = 'LIKE' or where = 'NOT LIKE') and (pos(sel_rev,' OR ') > 0 or pos(sel_rev,' AND ') > 0) then
	sel_where = sel_where + sel_connect+ & 
               + sel_rev  + ' ' 
else
sel_where = sel_where + sel_connect + ' ' &
                      + ' reviewed_prior_year ' &
                      + where + ' ' & 
                      + sel_rev   + ' ' 
end if

x_period:
if sel_where = '' then
   period_connect = ''
else
   period_connect = 'AND'
end if
//cdate = today()
cdate = gnv_app.of_get_server_date() //ts2020c

period = string(uo_1.uf_return_period())
isx_norm_analysis_parms.l_period_key = uo_1.uf_return_key()			// FNC 04/20/99
isx_norm_analysis_parms.l_period = long(period)							// FNC 04/20/99
sel_where = sel_where + period_connect + ' ' &								 
					+ ' period '+ '= '+period + ' '


gv_analysis_1_sel = upper(sel_what + &
                     sel_from + &
                     sel_where + &
							sel_group_by + &
							sel_order_by )

in_order_by = sel_order_by 
return 0
end function

public function long wf_count_norms (long arg_period);// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed

string sel
string lv_sql_statement,lv_message
long lv_count
long period
st_count.text = ''


cb_graph.enabled = TRUE
cb_query.enabled = TRUE
cb_view_report.enabled  = TRUE
period = arg_period

	setpointer(hourglass!)

lv_sql_statement = 'SELECT COUNT(*) FROM '               &                 
                   + iv_first_norm_table                 &
                   + ' WHERE PERIOD = ' + string(period)

SQLCA.LogID = stars1ca.LogID
SQLCA.LogPass = stars1ca.LogPass
SQLCA.ServerName = stars1ca.ServerName
SQLCA.Lock = stars1ca.Lock
SQLCA.DBMS = stars1ca.DBMS
SQLCA.database = stars1ca.database
SQLCA.userid = stars1ca.userid
SQLCA.dbpass = stars1ca.dbpass
SQLCA.dbparm = stars1ca.dbparm

//sqlcmd('connect',sqlca,'Error Connecting to Database',5)			// FDG 02/20/01
SQLCA.of_connect()																// FDG 02/20/01

Declare C1 DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :lv_sql_statement using sqlca;

OPEN DYNAMIC C1;
if sqlca.of_check_status() <> 0 then
   errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
   return -1
end if
fetch C1 into :lv_count;
if sqlca.of_check_status() <> 0 then
   errorbox(sqlca,'Error Reading the Sum_prov table')
   return -1
end if
close C1;

//sqlcmd('disconnect',sqlca,'Error disconnecting from database',1)		// FDG 02/20/01
SQLCA.of_disconnect()																	// FDG 02/20/01

return lv_count
end function

event open;call super::open;//                  ***OPEN FOR W_ANALYSIS_4***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 09/01/93  MH  Created 
// 10/03/93  SWD Added in the SPLIT LABEL SECTION,STORE LABEL INTO RB SECTION
//					  and STORE LABEL INTO STATIC TEXT SECTION.  Basically these
//					  sections store the labels.
// 08/26/94  FNC Force gv_sys_dflt to MB
// 07/21/98  AJS Stars 4.0 Track #1296
//	02/16/07	GaryR	Track 4905	Centralize logic to prevent PB reference bugs
//***********************************************************************

LONG PERIOD
int lv_count
//w_norm_graph w_norm_graph2
string lv_table_and_type, lv_both_aliases, lv_both_tables
string lv_sql_statement
long lv_len, lv_position, ll_check_for_periods
integer li_rc

gv_active_invoice = iv_invoice_type

//**********************//
// load the period dddw //
//**********************//

uo_1.uf_load_dddw('NORM', iv_invoice_type, 'AC', 'FALSE')
// 07/21/98  AJS Stars 4.0 Track #1296
ll_check_for_periods = uo_1.uf_return_key()		//ajs 4.0 07-21-98 4.0 Track #1296
if ll_check_for_periods = 0 then						//ajs 4.0 07-21-98 4.0 Track #1296
	close(this)												//ajs 4.0 07-21-98 4.0 Track #1296
	Return
end if														//ajs 4.0 07-21-98 4.0 Track #1296

ddlb_sort.text = 'Savings'

em_denied_srvc_connect.text = 'AND'
em_allowed_amt_where.text = '>'
em_allowed_srvc_connect.text = 'AND'
em_allowed_srvc_where.text = '>'
em_sav_connect.text = 'AND'
em_denied_services_where.text = '>'

em_proc_where.text = '='
em_sav_where.text = '>'
em_spec_where.text = '='
em_spec_connect.text = 'AND'
em_mod_where.text='='
em_mod_connect.text='AND'
em_proc_connect.text = 'AND'
em_allowed_amt_connect.text = 'AND'
em_percent_change_where.text = '>'

//DKG 11/29/95
em_percent_change_connect.text = 'AND'
em_reviewed_where.text='='
//DKG END

lv_table_and_type = fx_get_table('w_norm_analysis', 'open', iv_invoice_type)

lv_len = len(lv_table_and_type)
lv_len = lv_len - 5
lv_both_aliases = mid(lv_table_and_type,1,5)
iv_first_norm_alias  = mid(lv_both_aliases,1,2)
iv_second_norm_alias = mid(lv_both_aliases,4,2)
lv_both_tables  = mid(lv_table_and_type,6,lv_len)
lv_len = len(lv_both_tables)
lv_position = pos(lv_both_tables, ',')
iv_first_norm_table  = mid(lv_both_tables,1,(lv_position - 1))
iv_second_norm_table = mid(lv_both_tables,(lv_position + 1),(lv_len - lv_position))

IF gnv_dict.uf_get_dict_info( iv_first_norm_alias, iv_dict_structure ) = -1 THEN Return
end event

on w_norm_analysis.create
int iCurrent
call super::create
this.sle_sel_spec=create sle_sel_spec
this.sle_sel_proc=create sle_sel_proc
this.sle_sel_mod=create sle_sel_mod
this.uo_1=create uo_1
this.sle_sel_reviewed=create sle_sel_reviewed
this.em_reviewed_where=create em_reviewed_where
this.em_percent_change_connect=create em_percent_change_connect
this.st_12=create st_12
this.em_mod_connect=create em_mod_connect
this.em_mod_where=create em_mod_where
this.st_11=create st_11
this.st_7=create st_7
this.st_count=create st_count
this.st_10=create st_10
this.em_percent_change_where=create em_percent_change_where
this.em_allowed_amt_connect=create em_allowed_amt_connect
this.em_allowed_amt_where=create em_allowed_amt_where
this.em_denied_services_where=create em_denied_services_where
this.em_allowed_srvc_where=create em_allowed_srvc_where
this.em_sav_where=create em_sav_where
this.em_spec_where=create em_spec_where
this.em_proc_where=create em_proc_where
this.em_denied_srvc_connect=create em_denied_srvc_connect
this.em_allowed_srvc_connect=create em_allowed_srvc_connect
this.em_sav_connect=create em_sav_connect
this.em_spec_connect=create em_spec_connect
this.em_proc_connect=create em_proc_connect
this.st_8=create st_8
this.st_6=create st_6
this.ddlb_sort=create ddlb_sort
this.st_5=create st_5
this.sle_sel_denied_services=create sle_sel_denied_services
this.st_4=create st_4
this.sle_sel_allowed_amt=create sle_sel_allowed_amt
this.st_2=create st_2
this.sle_sel_allowed_srvc=create sle_sel_allowed_srvc
this.cb_graph=create cb_graph
this.st_top_label=create st_top_label
this.cb_clear=create cb_clear
this.cb_view_report=create cb_view_report
this.sle_percent=create sle_percent
this.st_3=create st_3
this.st_1=create st_1
this.sle_sel_sav=create sle_sel_sav
this.ddlb_list=create ddlb_list
this.cb_close=create cb_close
this.cb_query=create cb_query
this.st_9=create st_9
this.sle_percent_change=create sle_percent_change
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_sel_spec
this.Control[iCurrent+2]=this.sle_sel_proc
this.Control[iCurrent+3]=this.sle_sel_mod
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.sle_sel_reviewed
this.Control[iCurrent+6]=this.em_reviewed_where
this.Control[iCurrent+7]=this.em_percent_change_connect
this.Control[iCurrent+8]=this.st_12
this.Control[iCurrent+9]=this.em_mod_connect
this.Control[iCurrent+10]=this.em_mod_where
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.st_7
this.Control[iCurrent+13]=this.st_count
this.Control[iCurrent+14]=this.st_10
this.Control[iCurrent+15]=this.em_percent_change_where
this.Control[iCurrent+16]=this.em_allowed_amt_connect
this.Control[iCurrent+17]=this.em_allowed_amt_where
this.Control[iCurrent+18]=this.em_denied_services_where
this.Control[iCurrent+19]=this.em_allowed_srvc_where
this.Control[iCurrent+20]=this.em_sav_where
this.Control[iCurrent+21]=this.em_spec_where
this.Control[iCurrent+22]=this.em_proc_where
this.Control[iCurrent+23]=this.em_denied_srvc_connect
this.Control[iCurrent+24]=this.em_allowed_srvc_connect
this.Control[iCurrent+25]=this.em_sav_connect
this.Control[iCurrent+26]=this.em_spec_connect
this.Control[iCurrent+27]=this.em_proc_connect
this.Control[iCurrent+28]=this.st_8
this.Control[iCurrent+29]=this.st_6
this.Control[iCurrent+30]=this.ddlb_sort
this.Control[iCurrent+31]=this.st_5
this.Control[iCurrent+32]=this.sle_sel_denied_services
this.Control[iCurrent+33]=this.st_4
this.Control[iCurrent+34]=this.sle_sel_allowed_amt
this.Control[iCurrent+35]=this.st_2
this.Control[iCurrent+36]=this.sle_sel_allowed_srvc
this.Control[iCurrent+37]=this.cb_graph
this.Control[iCurrent+38]=this.st_top_label
this.Control[iCurrent+39]=this.cb_clear
this.Control[iCurrent+40]=this.cb_view_report
this.Control[iCurrent+41]=this.sle_percent
this.Control[iCurrent+42]=this.st_3
this.Control[iCurrent+43]=this.st_1
this.Control[iCurrent+44]=this.sle_sel_sav
this.Control[iCurrent+45]=this.ddlb_list
this.Control[iCurrent+46]=this.cb_close
this.Control[iCurrent+47]=this.cb_query
this.Control[iCurrent+48]=this.st_9
this.Control[iCurrent+49]=this.sle_percent_change
end on

on w_norm_analysis.destroy
call super::destroy
destroy(this.sle_sel_spec)
destroy(this.sle_sel_proc)
destroy(this.sle_sel_mod)
destroy(this.uo_1)
destroy(this.sle_sel_reviewed)
destroy(this.em_reviewed_where)
destroy(this.em_percent_change_connect)
destroy(this.st_12)
destroy(this.em_mod_connect)
destroy(this.em_mod_where)
destroy(this.st_11)
destroy(this.st_7)
destroy(this.st_count)
destroy(this.st_10)
destroy(this.em_percent_change_where)
destroy(this.em_allowed_amt_connect)
destroy(this.em_allowed_amt_where)
destroy(this.em_denied_services_where)
destroy(this.em_allowed_srvc_where)
destroy(this.em_sav_where)
destroy(this.em_spec_where)
destroy(this.em_proc_where)
destroy(this.em_denied_srvc_connect)
destroy(this.em_allowed_srvc_connect)
destroy(this.em_sav_connect)
destroy(this.em_spec_connect)
destroy(this.em_proc_connect)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.ddlb_sort)
destroy(this.st_5)
destroy(this.sle_sel_denied_services)
destroy(this.st_4)
destroy(this.sle_sel_allowed_amt)
destroy(this.st_2)
destroy(this.sle_sel_allowed_srvc)
destroy(this.cb_graph)
destroy(this.st_top_label)
destroy(this.cb_clear)
destroy(this.cb_view_report)
destroy(this.sle_percent)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.sle_sel_sav)
destroy(this.ddlb_list)
destroy(this.cb_close)
destroy(this.cb_query)
destroy(this.st_9)
destroy(this.sle_percent_change)
end on

event ue_preopen;call super::ue_preopen;iv_invoice_type = message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)



end event

event activate;//********************************************************************
// 03/10/94 FNC Discontinue resetting of the screen upon return.
//********************************************************************

ddlb_list.setfocus()
end event

type sle_sel_spec from u_sle within w_norm_analysis
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Specialty"
string accessibledescription = "Lookup Field - Specialty"
integer x = 1134
integer y = 596
integer width = 1472
integer height = 100
integer taborder = 120
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event modified;call super::modified;st_count.text = ''
end event

event ue_lookup;call super::ue_lookup;// 12/08/2004	Katie	Track 4030 Added code to pull lookup type from dictionary.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

string ls_table_type

ls_table_type = gnv_dict.event ue_get_table_type(iv_second_norm_table)

gv_code_to_use = gnv_dict.event ue_get_lookup_type( ls_table_type, 'PROV_SPEC')

open(w_code_lookup)
if gv_code_to_use <> '' Then
	This.text = gv_code_to_use
end if
end event

type sle_sel_proc from u_sle within w_norm_analysis
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Procedure Code"
string accessibledescription = "Lookup Field - Procedure Code"
integer x = 1134
integer y = 372
integer width = 1472
integer height = 100
integer taborder = 60
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event modified;call super::modified;st_count.text = ''
end event

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

gv_code_to_use = 'PC'								
open(w_code_lookup)
if gv_code_to_use <> '' Then
	This.text = gv_code_to_use
end if
end event

type sle_sel_mod from u_sle within w_norm_analysis
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Procedure Modifier"
string accessibledescription = "Lookup Field - Procedure Modifier"
integer x = 1134
integer y = 484
integer width = 1472
integer height = 100
integer taborder = 90
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

gv_code_to_use = 'MD'
open(w_code_lookup)
if gv_code_to_use <> '' Then
	This.text = gv_code_to_use
end if
end event

event modified;call super::modified;st_count.text = ''						//KMM 7/25/95 Prob#696
end event

type uo_1 from u_display_period within w_norm_analysis
integer x = 617
integer y = 240
integer width = 1271
integer height = 112
integer taborder = 40
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_sel_reviewed from singlelineedit within w_norm_analysis
string accessiblename = "Reviewed"
string accessibledescription = "Reviewed"
accessiblerole accessiblerole = textrole!
integer x = 1134
integer y = 1268
integer width = 1472
integer height = 100
integer taborder = 300
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type em_reviewed_where from editmask within w_norm_analysis
string accessiblename = "Reviewed"
string accessibledescription = "Reviewed"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 1268
integer width = 247
integer height = 100
integer taborder = 290
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type em_percent_change_connect from editmask within w_norm_analysis
string accessiblename = "Percent Changed"
string accessibledescription = "Percent Changed"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 1268
integer width = 251
integer height = 100
integer taborder = 280
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type st_12 from statictext within w_norm_analysis
string accessiblename = "Reviewed"
string accessibledescription = "Reviewed"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1268
integer width = 576
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Reviewed:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_mod_connect from editmask within w_norm_analysis
string accessiblename = "Procedure Modifier"
string accessibledescription = "Procedure Modifier"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 596
integer width = 251
integer height = 100
integer taborder = 100
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND ~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type em_mod_where from editmask within w_norm_analysis
string accessiblename = "Procedure Modifier"
string accessibledescription = "Procedure Modifier"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 484
integer width = 247
integer height = 100
integer taborder = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/<~t</>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type st_11 from statictext within w_norm_analysis
string accessiblename = "Proc Mod"
string accessibledescription = "Proc Mod"
accessiblerole accessiblerole = statictextrole!
integer x = 201
integer y = 504
integer width = 398
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Proc Mod:"
alignment alignment = right!
end type

type st_7 from statictext within w_norm_analysis
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = statictextrole!
integer x = 352
integer y = 252
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Period:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_count from statictext within w_norm_analysis
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1408
integer width = 274
integer height = 80
integer textsize = -16
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

type st_10 from statictext within w_norm_analysis
string accessiblename = "Percent Changed"
string accessibledescription = "Percent Changed"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1164
integer width = 576
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Percent Changed:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_percent_change_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Percent Changed"
string accessibledescription = "Percent Changed"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 1156
integer width = 247
integer height = 100
integer taborder = 260
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_allowed_amt_connect from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Allowed Charge"
string accessibledescription = "Allowed Charge"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 1156
integer width = 251
integer height = 100
integer taborder = 250
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_allowed_amt_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Allowed Charge"
string accessibledescription = "Allowed Charge"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 1044
integer width = 247
integer height = 100
integer taborder = 230
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_denied_services_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Denied Services"
string accessibledescription = "Denied Services"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 932
integer width = 247
integer height = 100
integer taborder = 200
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/=~t=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_allowed_srvc_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Allowed Services Per 1000 Enrolled"
string accessibledescription = "Allowed Services Per 1000 Enrolled"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 820
integer width = 247
integer height = 100
integer taborder = 170
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_sav_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Potential Savings"
string accessibledescription = "Potential Savings"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 708
integer width = 247
integer height = 100
integer taborder = 140
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_spec_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 596
integer width = 247
integer height = 100
integer taborder = 110
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_proc_where from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Procedure"
string accessibledescription = "Procedure"
accessiblerole accessiblerole = textrole!
integer x = 878
integer y = 372
integer width = 247
integer height = 100
integer taborder = 50
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "<>~t<>/<~t</<=~t<=/>~t>/<~t</>=~t>=/><~t></=~t=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on modified;st_count.text = ''
end on

type em_denied_srvc_connect from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Denied Services"
string accessibledescription = "Denied Services"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 1044
integer width = 251
integer height = 100
integer taborder = 220
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_allowed_srvc_connect from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Allowed Services Per 1000 Enrolled"
string accessibledescription = "Allowed Services Per 1000 Enrolled"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 932
integer width = 251
integer height = 100
integer taborder = 190
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_sav_connect from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Potential Savings"
string accessibledescription = "Potential Savings"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 820
integer width = 251
integer height = 100
integer taborder = 160
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_spec_connect from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 708
integer width = 251
integer height = 100
integer taborder = 130
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_proc_connect from editmask within w_norm_analysis
event change pbm_enchange
string accessiblename = "Procedure"
string accessibledescription = "Procedure"
accessiblerole accessiblerole = textrole!
integer x = 617
integer y = 484
integer width = 251
integer height = 100
integer taborder = 70
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "AND ~tAND/OR~tOR/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type st_8 from statictext within w_norm_analysis
string accessiblename = "Sort By/Graph By"
string accessibledescription = "Sort By/Graph By"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 136
integer width = 562
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Sort By/Graph By:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_norm_analysis
string accessiblename = "per 1000 enrolled"
string accessibledescription = "per 1000 enrolled"
accessiblerole accessiblerole = statictextrole!
integer x = 5
integer y = 868
integer width = 599
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "per 1000 enrolled:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_sort from dropdownlistbox within w_norm_analysis
string accessiblename = "Sort By/Graph By"
string accessibledescription = "Sort By/Graph By"
accessiblerole accessiblerole = comboboxrole!
integer x = 617
integer y = 132
integer width = 873
integer height = 476
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Rank","Procedure Code","Specialty","Savings","Procedure Code/Savings","CARR Allow Srvc/1000","Percent Changed","CARR Allow Chrg/1000"}
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;//********************************************************************
// 03/10/94 FNC reset sle_percent and st_top_label to show
//********************************************************************

if ddlb_sort.text = 'Procedure Code' OR ddlb_sort.text = 'Procedure Code/Savings' OR ddlb_sort.text = 'Specialty' Then
	cb_graph.enabled = False
else
	cb_graph.enabled = TRUE
end if

//  Changed 3-1-94 TPB - Cannot use TOP/Bottom with Procedure code/savings because of special sort in w_norm_rpt.
//  Changed 3-10-94 FNC - Reset top/bottom for other sort orders
if ddlb_sort.text =  'Procedure Code/Savings' then
	ddlb_list.hide()
   ddlb_list.text = 'Top'
	sle_percent.hide()
   sle_percent.text = ''
   st_top_label.hide()
else
   ddlb_list.show()
	sle_percent.show()
   st_top_label.show()
end if
end on

type st_5 from statictext within w_norm_analysis
string accessiblename = "Denied Services"
string accessibledescription = "Denied Services"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 956
integer width = 576
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Denied Services:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sel_denied_services from singlelineedit within w_norm_analysis
event change pbm_enchange
string accessiblename = "Denied Services"
string accessibledescription = "Denied Services"
accessiblerole accessiblerole = textrole!
integer x = 1134
integer y = 932
integer width = 1472
integer height = 100
integer taborder = 210
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

on change;st_count.text = ''
end on

type st_4 from statictext within w_norm_analysis
string accessiblename = "Allowed Charge"
string accessibledescription = "Allowed Charge"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 1060
integer width = 571
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Allowed Charge:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sel_allowed_amt from singlelineedit within w_norm_analysis
event change pbm_enchange
string accessiblename = "Allowed Charge"
string accessibledescription = "Allowed Charge"
accessiblerole accessiblerole = textrole!
integer x = 1134
integer y = 1044
integer width = 1472
integer height = 100
integer taborder = 240
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

on change;st_count.text = ''
end on

type st_2 from statictext within w_norm_analysis
string accessiblename = "Allowed Services"
string accessibledescription = "Allowed Services"
accessiblerole accessiblerole = statictextrole!
integer x = 5
integer y = 812
integer width = 594
integer height = 64
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Allowed Services"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sel_allowed_srvc from singlelineedit within w_norm_analysis
event change pbm_enchange
string accessiblename = "Allowed Services Per 1000 Enrolled"
string accessibledescription = "Allowed Services Per 1000 Enrolled"
accessiblerole accessiblerole = textrole!
integer x = 1134
integer y = 820
integer width = 1472
integer height = 100
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

on change;st_count.text = ''
end on

type cb_graph from u_cb within w_norm_analysis
string accessiblename = "Graph "
string accessibledescription = "Graph "
integer x = 1440
integer y = 1396
integer width = 338
integer height = 108
integer taborder = 330
integer textsize = -16
string text = "&Graph..."
end type

event clicked;//*****************************************************************
// 08-20-96 FNC	Prob #927 STARCARE
//						Add proc_mod to x-axis of graph.
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//	05/17/07	GaryR	Track 5026	Prevent divide-by-zero
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//*****************************************************************

string what,lv_graph,lv_sort,lv_type,parm
string sequence,sequence2
int li_rc,num_of_values

gv_active_invoice = iv_invoice_type

if ddlb_list.text = 'Top' Then
	sequence = 'asc'
	sequence2 = 'desc'
elseif ddlb_list.text = 'Bottom' Then
	sequence = 'desc'
	sequence2 = 'asc'
end if 

setpointer(hourglass!)
if sle_percent.text = '' Then
	sle_percent.text = ''
elseif isnumber(sle_percent.text) = FALSE Then
	messagebox('Error','Please enter a Number for this field',stopsign!)
	setfocus(sle_percent)
	return
end if


if integer(sle_percent.text) < 1 then
	sle_percent.text = ''
end if

what = ''

li_rc = build_sql(what)
if li_rc = -1 then return

if ddlb_sort.text = 'Savings' Then
	num_of_values = 1
	lv_graph = 'Savings '

	lv_sort = ' Order By Savings '+sequence2
	lv_type = 'dec'
elseif ddlb_sort.text = 'Rank' Then
	num_of_values = 2
	lv_graph = 'Carr_Rank,Natl_Rank '
	lv_sort = ' Order By Carr_Rank '+sequence+',Natl_Rank '+sequence2
	lv_type = 'int'
elseif ddlb_sort.text = 'CARR Allow Srvc/1000' Then
	num_of_values = 2
	lv_graph = 'Carr_allow_srvc_per,Natl_Allow_Srvc_per '
	lv_sort = ' Order By Carr_allow_srvc_per '+sequence2
	lv_type = 'dec'
elseif ddlb_sort.text = 'CARR Allow Chrg/1000' Then
	num_of_values = 2
	lv_graph = 'Carr_Allow_chrg_per,Natl_Allow_chrg_per '
	lv_sort = ' Order By Carr_allow_chrg_per '+sequence2
	lv_type = 'dec'
elseif ddlb_sort.text = 'Percent Changed' Then
	num_of_values = 1	
	lv_graph = gnv_sql.of_get_norm_case() + ' '
	lv_sort = ' ORDER BY ' + gnv_sql.of_get_norm_case() + sequence2
	lv_type = 'dec'
end if				   

what = lv_graph+',proc_code' + gnv_sql.is_concat + '~'~n~'' + &
				gnv_sql.is_concat + 'prov_spec' + gnv_sql.is_concat + &
				'~'~n~'' + gnv_sql.is_concat + 'proc_mod '			

gv_graph_sel = 'Select '+what+' From ' + iv_first_norm_table + ' WHERE '+sel_where+in_order_by  // SG Nov 94

// FNC 04/20/99 Start
isx_norm_analysis_parms.s_sort = ddlb_sort.text
isx_norm_analysis_parms.s_invoice_type = iv_invoice_type
isx_norm_analysis_parms.l_rank_num = 0
isx_norm_analysis_parms.i_num_of_values = num_of_values
isx_norm_analysis_parms.s_type = lv_type
// FNC 04/20/99 End

if gc_debug_mode = TRUE THEN
	messagebox('Execute SQL',gv_graph_sel)
end if
if isvalid(w_norm_graph) Then
	close(w_norm_graph)
end if

opensheetwithparm(w_norm_graph,isx_norm_analysis_parms,MDI_Main_Frame,Help_menu_position,Layered!)
end event

type st_top_label from statictext within w_norm_analysis
string accessiblename = "Ranking"
string accessibledescription = "Ranking"
accessiblerole accessiblerole = statictextrole!
integer x = 329
integer y = 24
integer width = 274
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Ranking:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_clear from u_cb within w_norm_analysis
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1865
integer y = 1396
integer width = 338
integer height = 108
integer taborder = 340
integer textsize = -16
string text = "C&lear"
end type

on clicked;long lv_count

sle_percent.TEXT = ''
sle_sel_proc.text = ''
sle_sel_spec.text = ''
sle_sel_sav.text = ''
sle_sel_allowed_amt.text = ''
sle_sel_allowed_srvc.text = ''
sle_sel_denied_services.text = ''
sle_sel_mod.text = ''
//DKG 11/30/95
sle_sel_reviewed.text = ''
sle_percent_change.text = ''
//DKG END

em_proc_where.text = '='
em_proc_connect.text = 'AND'
em_sav_where.text = '>'
em_spec_connect.text = 'AND'
em_spec_where.text = '='
em_denied_srvc_connect.text = 'AND'
em_allowed_amt_where.text = '>'
em_allowed_srvc_connect.text = 'AND'
em_allowed_srvc_where.text = '>'
em_sav_connect.text = 'AND'
em_denied_services_where.text = '>'
em_allowed_amt_connect.text = 'AND'
em_percent_change_where.text = '>'

//DKG 11/30/95
em_percent_change_connect.text = 'AND'
em_reviewed_where.text = '='
//DKG END

uo_1.uf_load_dddw('NORM', iv_invoice_type, 'AC', 'FALSE')

st_count.text = ''

end on

type cb_view_report from u_cb within w_norm_analysis
string accessiblename = "View Report"
string accessibledescription = "View Report "
integer x = 841
integer y = 1396
integer width = 512
integer height = 108
integer taborder = 320
integer textsize = -16
string text = "&View Report..."
end type

event clicked;//********************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//********************************************************************

int li_rc
string what,parm

gv_active_invoice = iv_invoice_type
w_main.triggerevent('timer')

setpointer(hourglass!)
if sle_percent.text = '' Then
	sle_percent.text = ''
elseif isnumber(sle_percent.text) = FALSE Then
	messagebox('Error','Please enter a Number for this field',stopsign!)
	setfocus(sle_percent)
	return
end if

if integer(sle_percent.text) < 1 then
	sle_percent.text = ''
end if
what = ''
				   
li_rc = build_sql(what)
if li_rc = -1 then return
if gc_debug_mode = TRUE THEN
	messagebox('Execute SQL',gv_analysis_1_sel)
end if
if isvalid(w_norm_rpt) Then
	close(w_norm_rpt)
end if

isx_norm_analysis_parms.s_sort = ddlb_sort.text
isx_norm_analysis_parms.s_invoice_type = iv_invoice_type
isx_norm_analysis_parms.l_rank_num = long(sle_percent.text)
isx_norm_analysis_parms.i_num_of_values = 0
isx_norm_analysis_parms.s_type = ' '

opensheetwithparm(w_norm_rpt,isx_norm_analysis_parms,MDI_Main_Frame,Help_menu_position,Layered!)
// FNC 04/20/99 ENd

end event

type sle_percent from singlelineedit within w_norm_analysis
string accessiblename = "Percent Changed"
string accessibledescription = "Percent Changed"
accessiblerole accessiblerole = textrole!
integer x = 1038
integer y = 16
integer width = 219
integer height = 96
integer taborder = 20
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on modified;if integer(sle_percent.text) > 30 Then
	messagebox("Error","Cannot be greater than thirty")
end if
end on

type st_3 from statictext within w_norm_analysis
string accessiblename = "Potential Savings"
string accessibledescription = "Potential Savings"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 728
integer width = 585
integer height = 68
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Potential Savings:"
alignment alignment = right!
end type

type st_1 from statictext within w_norm_analysis
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = statictextrole!
integer x = 146
integer y = 616
integer width = 453
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Specialty:"
alignment alignment = right!
end type

type sle_sel_sav from singlelineedit within w_norm_analysis
event change pbm_enchange
string accessiblename = "Potential Savings"
string accessibledescription = "Potential Savings"
accessiblerole accessiblerole = textrole!
integer x = 1134
integer y = 708
integer width = 1472
integer height = 100
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

on change;st_count.text = ''
end on

type ddlb_list from dropdownlistbox within w_norm_analysis
string accessiblename = "Ranking"
string accessibledescription = "Ranking"
accessiblerole accessiblerole = comboboxrole!
integer x = 617
integer y = 24
integer width = 366
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
string text = "Top"
boolean vscrollbar = true
string item[] = {"Top","Bottom"}
borderstyle borderstyle = stylelowered!
end type

type cb_close from u_cb within w_norm_analysis
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2290
integer y = 1396
integer width = 338
integer height = 108
integer taborder = 350
string text = "&Close"
end type

on clicked;
close(parent)
end on

type cb_query from u_cb within w_norm_analysis
string accessiblename = "Query"
string accessibledescription = "Query"
integer x = 416
integer y = 1396
integer width = 338
integer height = 108
integer taborder = 310
string text = "&Query"
boolean default = true
end type

event clicked;// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed

int cnt,li_rc                 

setpointer(hourglass!)

li_rc = build_sql('COUNT(*)')
if li_rc = -1 then return

   SQLCA.LogID = stars1ca.LogID
	SQLCA.LogPass = stars1ca.LogPass
	SQLCA.ServerName = stars1ca.ServerName
	SQLCA.Lock = stars1ca.Lock
	SQLCA.DBMS = stars1ca.DBMS
	SQLCA.database = stars1ca.database
	SQLCA.userid = stars1ca.userid
	SQLCA.dbpass = stars1ca.dbpass
	
	//sqlcmd('connect',sqlca,'Error Connecting to Database',5)		// FDG 02/20/01
	SQLCA.of_connect()															// FDG 02/20/01
	
	DECLARE c1 DYNAMIC CURSOR FOR SQLSA;
   PREPARE SQLSA FROM :gv_analysis_1_sel;
	cnt = 0
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
      return
   end if
	OPEN DYNAMIC c1;
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Opening the Sum_prov table')
      return
   end if
   Fetch c1 into :st_count.text;
	If (sqlca.of_check_status() = 100) then
		COMMIT using STARS1CA;
		If stars1ca.of_check_status() <> 0 Then
			Messagebox('EDIT','Error Commiting to Stars2')
			Return
		End If	
		RETURN
	end if
	 
	if sqlca.of_check_status() <> 0 then
		close c1;
		if sqlca.of_check_status() <> 0 then
      	errorbox(sqlca,'Error Closing the Sum_prov table durring a Reading Error')
      	return
   	end if
      errorbox(sqlca,'Error Reading the Sum_prov table')
      return
   end if

	
   close c1;
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
      return
   end if
	
	//sqlcmd('disconnect',sqlca,'Error disconnecting from database',1)		// FDG 02/20/01
	SQLCA.of_disconnect()																	// FDG 02/20/01
	
end event

type st_9 from statictext within w_norm_analysis
string accessiblename = "Procedure"
string accessibledescription = "Procedure"
accessiblerole accessiblerole = statictextrole!
integer x = 206
integer y = 396
integer width = 393
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Procedure:"
alignment alignment = right!
end type

type sle_percent_change from singlelineedit within w_norm_analysis
event change pbm_enchange
string accessiblename = "Percent Changed"
string accessibledescription = "Percent Changed"
accessiblerole accessiblerole = textrole!
integer x = 1134
integer y = 1156
integer width = 1472
integer height = 100
integer taborder = 270
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on change;st_count.text = ''
end on

