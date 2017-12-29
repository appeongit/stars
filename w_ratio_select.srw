HA$PBExportHeader$w_ratio_select.srw
$PBExportComments$Inherited from w_master
forward
global type w_ratio_select from w_master
end type
type sle_sel_spec from u_sle within w_ratio_select
end type
type sle_sel_area from u_sle within w_ratio_select
end type
type sle_sel_cat from u_sle within w_ratio_select
end type
type cb_query from u_cb within w_ratio_select
end type
type uo_1 from u_display_period within w_ratio_select
end type
type st_ratio3_connect from statictext within w_ratio_select
end type
type st_provider_connect from statictext within w_ratio_select
end type
type em_ratio3_where from editmask within w_ratio_select
end type
type em_provider_where from editmask within w_ratio_select
end type
type rb_ratio3 from radiobutton within w_ratio_select
end type
type st_count from statictext within w_ratio_select
end type
type st_area_connect from statictext within w_ratio_select
end type
type st_cat_connect from statictext within w_ratio_select
end type
type rb_ratio1 from radiobutton within w_ratio_select
end type
type rb_rpt3 from radiobutton within w_ratio_select
end type
type rb_rpt2 from radiobutton within w_ratio_select
end type
type rb_rpt1 from radiobutton within w_ratio_select
end type
type rb_ratio2 from radiobutton within w_ratio_select
end type
type em_area_where from editmask within w_ratio_select
end type
type em_cat_where from editmask within w_ratio_select
end type
type em_spec_where from editmask within w_ratio_select
end type
type st_6 from statictext within w_ratio_select
end type
type cb_clear from u_cb within w_ratio_select
end type
type cb_view_report from u_cb within w_ratio_select
end type
type st_3 from statictext within w_ratio_select
end type
type st_1 from statictext within w_ratio_select
end type
type cb_close from u_cb within w_ratio_select
end type
type gb_3 from groupbox within w_ratio_select
end type
type gb_2 from groupbox within w_ratio_select
end type
type gb_1 from groupbox within w_ratio_select
end type
type st_5 from statictext within w_ratio_select
end type
type st_rank_connect from statictext within w_ratio_select
end type
type em_rank_where from editmask within w_ratio_select
end type
type sle_sel_rank from singlelineedit within w_ratio_select
end type
type st_variance from statictext within w_ratio_select
end type
type st_variance_connect from statictext within w_ratio_select
end type
type em_variance_where from editmask within w_ratio_select
end type
type sle_sel_variance from singlelineedit within w_ratio_select
end type
type mle_cutoff_percent from multilineedit within w_ratio_select
end type
type cbx_npi from checkbox within w_ratio_select
end type
type sle_sel_ratio3 from singlelineedit within w_ratio_select
end type
type st_7 from statictext within w_ratio_select
end type
type sle_sel_prov from u_sle within w_ratio_select
end type
type st_4 from statictext within w_ratio_select
end type
end forward

shared variables

end variables

global type w_ratio_select from w_master
string accessiblename = "Ratio Report Analysis"
string accessibledescription = "Ratio Report Analysis"
integer x = 165
integer y = 0
integer width = 2697
integer height = 1680
string title = "Ratio Report Analysis"
sle_sel_spec sle_sel_spec
sle_sel_area sle_sel_area
sle_sel_cat sle_sel_cat
cb_query cb_query
uo_1 uo_1
st_ratio3_connect st_ratio3_connect
st_provider_connect st_provider_connect
em_ratio3_where em_ratio3_where
em_provider_where em_provider_where
rb_ratio3 rb_ratio3
st_count st_count
st_area_connect st_area_connect
st_cat_connect st_cat_connect
rb_ratio1 rb_ratio1
rb_rpt3 rb_rpt3
rb_rpt2 rb_rpt2
rb_rpt1 rb_rpt1
rb_ratio2 rb_ratio2
em_area_where em_area_where
em_cat_where em_cat_where
em_spec_where em_spec_where
st_6 st_6
cb_clear cb_clear
cb_view_report cb_view_report
st_3 st_3
st_1 st_1
cb_close cb_close
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
st_5 st_5
st_rank_connect st_rank_connect
em_rank_where em_rank_where
sle_sel_rank sle_sel_rank
st_variance st_variance
st_variance_connect st_variance_connect
em_variance_where em_variance_where
sle_sel_variance sle_sel_variance
mle_cutoff_percent mle_cutoff_percent
cbx_npi cbx_npi
sle_sel_ratio3 sle_sel_ratio3
st_7 st_7
sle_sel_prov sle_sel_prov
st_4 st_4
end type
global w_ratio_select w_ratio_select

type variables
sx_dictionary_data iv_dict_structure[]
string iv_where
string iv_cat, iv_area, iv_spec, iv_period
string iv_rpt_type, iv_rpt_ver
string iv_sql_stmt
string iv_invoice_type

int iv_ratio_rpt_sel 
string is_use_catgproc = 'X'
string iv_r1_sql_stmt,iv_table_type,iv_r2_sql_stmt,iv_r3_sql_stmt

//NLG TS2239 4-20-99
sx_ratio_select_parms isx_ratio_select_parms

//FNC Starcare 1804 4.0 SP2
boolean  ib_use_bill

//	07/01/03	GaryR	Track 3613d Account for DENTAL codes
String	is_pc_lookup, is_ps_lookup, is_pa_lookup

//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
String	is_prov = "PROV_ID", is_npi = " ' ', "
end variables

forward prototypes
public function integer wf_test_rb ()
public subroutine wf_which_ratio_rpt_sel ()
public function integer wf_get_tbl_type ()
private function integer wf_build_sql_parms (string arg_what)
private function integer wf_create_main_sql (string arg_type)
public function string wf_get_win_parm (string as_rpt)
end prototypes

public function integer wf_test_rb ();//  WF_TEST_RB
//  Tests to insure that each radio button is selected, since no defaults are allowed.

if rb_ratio1.checked <> true then
	if rb_ratio2.checked <> true then
      if rb_ratio3.checked <> true then
		   messagebox('ERROR','No Ratio Report has been selected.  Please select Ratio Report 1 or 2 before proceeding.')
		   rb_ratio1.SetFocus()
         return -1
	   end if
   end if
end if
if rb_rpt1.checked <> true then
	if rb_rpt2.checked <> true then
		if rb_rpt3.checked <> true then
			messagebox('ERROR','No Report Version has been selected.  Please select 1 of the 3 Report Versions before proceeding.')
			rb_rpt1.SetFocus()
			return -1
		end if
	end if
end if
if Len(string(uo_1.uf_return_period())) < 1 then
   messagebox('ERROR','No Date Period has been selected.  Please select a Date Period before proceeding.')
	return -1
end if

return 1
end function

public subroutine wf_which_ratio_rpt_sel ();
end subroutine

public function integer wf_get_tbl_type ();//============================================================================//
// Object		w_ratio_select
// Function		wf_get_dict_info
//============================================================================//
// Sets dictionary structure based on Ratio Report Table type
//============================================================================//
// Maintenance
// -------- ----- -------- -------------------------------------------------- //
// 10/22/04 MikeF	SPR3650d	Remove refernces to fx_get_table
//	02/16/07	GaryR	Track 4905	Centralize logic to prevent PB reference bugs
//============================================================================//

Integer	li_index
string	ls_table_name

IF rb_ratio1.checked THEN
	iv_rpt_type = 'R1'  
ELSEIF rb_ratio2.checked THEN
	iv_rpt_type = 'R2'  
ELSE
	iv_rpt_type = 'R3'  
END IF

ls_table_name  = this.wf_get_win_parm(iv_rpt_type)
iv_table_type = gnv_dict.event ue_get_table_type( ls_table_name )

CHOOSE CASE iv_rpt_type
	CASE 'R1'
		iv_r1_sql_stmt = ' FROM ' + ls_table_name + ' ' + iv_table_type
	CASE 'R2'
		iv_r2_sql_stmt = ' FROM ' + ls_table_name + ' ' + iv_table_type
	CASE 'R3'
		iv_r3_sql_stmt = ' FROM ' + ls_table_name + ' ' + iv_table_type
END CHOOSE

IF gnv_dict.uf_get_dict_info( iv_table_type, iv_dict_structure ) < 0 THEN Return -1

//	Set lookup types
li_index = gnv_dict.uf_get_info_index( iv_dict_structure, "CAT_OF_SERV" )
IF li_index > 0 THEN is_pc_lookup = iv_dict_structure[li_index].elem_lookup

li_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROV_SPEC" )
IF li_index > 0 THEN is_ps_lookup = iv_dict_structure[li_index].elem_lookup

li_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROV_AREA" )
IF li_index > 0 THEN is_pa_lookup = iv_dict_structure[li_index].elem_lookup

Return 0
end function

private function integer wf_build_sql_parms (string arg_what);///////////////////////////////////////////////////////////////////////
//  wf_build_sql_parms:  window function for w_ratio_select
//
//	Modification History
//
//  anne-s 11-03-97 Rel 3.6 Trk# 145
//
//	FDG	04/06/98	Rel 4.0 Track 933.  All quotes must be removed from
//						sle_sel_variance.text.  n_cst_string.of_removequotes()
//						was created to do this.
// AJS   07-16-98 4.0 Correct error received when place % in field
//	NLG	04-20-99	Track 2239. Remove references to gv_period,gv_period key
//	GaryR	02/03/05	Track 4273d	Trim all edit text values
//	02/16/07	GaryR	Track 4905	Centralize logic to prevent PB reference bugs
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//
///////////////////////////////////////////////////////////////////////

string sel_area, sel_spec, sel_rank, sel_variance, sel_cat
string period, period_connect, sel_connect, temp_sel, lv_where
integer lv_index

iv_where = ''

//********************************************************************
//* where SPECIALTY
//********************************************************************

if Trim( sle_sel_spec.text ) = '' then 
	em_spec_where.text = '='
else
   temp_sel = sle_sel_spec.text
	lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROV_SPEC" )

	if lv_index = -1 Then
		messagebox("ERROR","PROV_SPEC Not found in Dictionary")
		return -1
	end if
   lv_where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_spec_where.text,temp_sel,'Spec',sle_sel_spec,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)

   if lv_where = 'ERROR' Then
	   return - 1
   end if

   if pos(temp_sel,'%') > 1 then
	   temp_sel = left(temp_sel,len(temp_sel)- 1)
   end if
 
   IF rb_ratio1.checked = TRUE THEN
//making dynamic SWD
	   sel_spec = format_where(temp_sel,lv_where,iv_table_type+'.PROV_SPEC')
   else
      IF rb_ratio2.checked = TRUE THEN
   	   sel_spec = format_where(temp_sel,lv_where,iv_table_type+'.PROV_SPEC')
      else
         sel_spec = format_where(temp_sel,lv_where,iv_table_type+'.Prov_SPEC')
      end if
   end if

   if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and (pos(sel_spec,' OR ') > 0 or pos(sel_spec,' AND ') > 0) then
	   iv_where = iv_where +  ' ' + sel_spec  
   else
	   IF rb_ratio1.checked = TRUE THEN
			//This is to make it dynamic SWD//
   		iv_where = iv_where +  ' ' + ' ( '+iv_table_type+'.PRov_SPEC ' + lv_where + ' ' + sel_spec   + ' ) ' 
	   ELSE
         IF rb_ratio2.checked = TRUE THEN
		      iv_where = iv_where +  ' ' + ' ( '+iv_table_type+'.PROV_SPEC ' + lv_where + ' ' + sel_spec   + ' ) ' 
         else
		      iv_where = iv_where +  ' ' + ' ( '+iv_table_type+'.PROV_SPEC ' + lv_where + ' ' + sel_spec   + ' ) ' 
         end if
	   END IF
   end if

end if
              
//********************************************************************
// where CATEGORY
// Ignore if Ratio 3  SG Apr 95
//********************************************************************

if Trim( sle_sel_cat.text ) = '' or rb_ratio3.checked = TRUE then 
	em_cat_where.text   = '='
else
   temp_sel = sle_sel_cat.text
	lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "CAT_OF_SERV" )

	if lv_index = -1 Then
		messagebox("ERROR","CAT_OF_SERV Not found in Dictionary")
		return -1
	end if
   lv_where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_cat_where.text,temp_sel,'Category',sle_sel_cat,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)

   if lv_where = 'ERROR' Then
	   return - 1
   end if

   if pos(temp_sel,'%') > 1 then
	   temp_sel = left(temp_sel,len(temp_sel)- 1)
   end if

   IF rb_ratio1.checked = TRUE THEN
	   sel_cat = format_where(temp_sel,lv_where,iv_table_type+'.CAT_of_serv')
   else
      sel_cat = format_where(temp_sel,lv_where,iv_table_type+'.CAT_of_serv')
   end if

   if iv_where = '' then
	   sel_connect = ''
   else
	   sel_connect = st_cat_connect.text
   end if

   if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and (pos(sel_cat,' OR ') > 0 or pos(sel_cat,' AND ') > 0) then
	   iv_where = iv_where + ' ' + sel_connect + ' ' + sel_cat 
   else
	   IF rb_ratio1.checked = TRUE THEN
		   iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.CAT_of_serv ' + lv_where + ' ' + sel_cat   + ' ) ' 
	   ELSE
     	   IF rb_ratio2.checked = TRUE THEN
   		   iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.CAT_OF_SERV ' + lv_where + ' ' + sel_cat   + ' ) ' 
         ELSE
   		   iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.CAT_OF_SERV ' + lv_where + ' ' + sel_cat   + ' ) ' 
         END IF
   	END IF
   end if

end if

//********************************************************************
//* where AREA
//********************************************************************

if Trim( sle_sel_area.text ) = '' then 
	em_area_where.text = '='
else
   temp_sel = sle_sel_area.text
	lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROV_AREA" )

	if lv_index = -1 Then
		messagebox("ERROR","PROV_AREA Not found in Dictionary")
		return -1
	end if
   lv_where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_area_where.text,temp_sel,'Area',sle_sel_area,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
   
   if lv_where = 'ERROR' Then
	   return - 1
   end if

   if pos(temp_sel,'%') > 1 then
	   temp_sel = left(temp_sel,len(temp_sel)- 1)
   end if

   IF rb_ratio1.checked = TRUE THEN
	   sel_area = format_where(temp_sel,lv_where,iv_table_type+'.Prov_AREA')
   else		
      IF rb_ratio2.checked = TRUE THEN
	      sel_area = format_where(temp_sel,lv_where,iv_table_type+'.PROV_AREA')
      else
         sel_area = format_where(temp_sel,lv_where,iv_table_type+'.PROV_AREA')
      end if
   end if

   if iv_where = '' then
	   sel_connect = ''
   else
	   sel_connect = st_area_connect.text
   end if

   if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and (pos(sel_area,' OR ') > 0 or pos(sel_area,' AND ') > 0) then
	   iv_where = iv_where + ' ' + sel_connect + ' ' +  sel_area  
   else
	   IF rb_ratio1.checked = TRUE THEN
		   iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.PROV_AREA ' + lv_where + ' ' + sel_area   + ' ) ' 
	   ELSE
         IF rb_ratio2.checked = TRUE THEN
		      iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.PROV_AREA ' + lv_where + ' ' + sel_area   + ' ) ' 
         else
		      iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.PROV_AREA ' + lv_where + ' ' + sel_area   + ' ) ' 
         end if
	   END IF
   end if
end if

//********************************************************************
//* where PROVIDER
// Only if Ratio 3, Reports 1 or 3.  SG Apr 95
//********************************************************************
if Trim( sle_sel_prov.text ) = '' then 
	em_provider_where.text = '='
else
	temp_sel = sle_sel_prov.text
	lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, is_prov )

	if lv_index = -1 Then
		messagebox("ERROR", is_prov + " not found in Dictionary")
		return -1
	end if
	lv_where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_provider_where.text,temp_sel,is_prov,sle_sel_prov,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
	if lv_where = 'ERROR' Then
		return - 1
	end if
	if pos(temp_sel,'%') > 1 then
		temp_sel = left(temp_sel,len(temp_sel)- 1)
	end if
	sel_area = format_where(temp_sel,lv_where,+iv_table_type+'.' + is_prov)
	if iv_where = '' then
		sel_connect = ''
	else
		sel_connect = st_provider_connect.text
	end if
	if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and (pos(sel_area,' OR ') > 0 or pos(sel_area,' AND ') > 0) then
		iv_where = iv_where + ' ' + sel_connect + ' ' +  sel_area  
	else
		iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.' + is_prov + ' ' + lv_where + ' ' + sel_area   + ' ) ' 
	end if
end if
//********************************************************************
//* where PROV RATIO 3
// Only if Ratio 3, Reports 1 or 3.  SG Apr 95
//********************************************************************

if rb_ratio3.checked = TRUE then
   if rb_rpt1.checked = TRUE or rb_rpt3.checked = TRUE then
      if Trim( sle_sel_ratio3.text ) = '' then 
	      em_ratio3_where.text = '='
      else
         temp_sel = sle_sel_ratio3.text
			lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "PROV_RATIO_3" )
			
			if lv_index = -1 Then
				messagebox("ERROR","PROV_RATIO_3 Not found in Dictionary")
				return -1
			end if
         lv_where = fx_error_check_fields(iv_dict_structure[lv_index].data_type,em_ratio3_where.text,temp_sel,'Ratio 3',sle_sel_prov,iv_dict_structure[lv_index].min_len,iv_dict_structure[lv_index].max_len,iv_dict_structure[lv_index].leading_alpha)
         if lv_where = 'ERROR' Then
	         return - 1
         end if
   		if pos(temp_sel,'%') > 1 then
	         temp_sel = left(temp_sel,len(temp_sel)- 1)
         end if
         sel_area = format_where(temp_sel,lv_where,+iv_table_type+'.PROV_RATIO_3')
         sel_area = mid(sel_area,2)
         sel_area = left(sel_area,len(sel_area)-1)
         if iv_where = '' then
	         sel_connect = ''
         else
	         sel_connect = st_ratio3_connect.text
         end if
         if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and (pos(sel_area,' OR ') > 0 or pos(sel_area,' AND ') > 0) then
	         iv_where = iv_where + ' ' + sel_connect + ' ' +  sel_area  
         else
          iv_where = iv_where + ' ' + sel_connect + ' ' + ' ( '+iv_table_type+'.PROV_RATIO_3 ' + lv_where + sel_area + ' ) ' 
         end if
      end if
   end if
end if
//john_wo spec 127 for 3.6 release - added rank to window.
//********************************************************************
//* where rank
// Rank is valid for reports 1, 2 and 3.  john_wo
//********************************************************************

if Trim( sle_sel_rank.text ) = '' then 
	em_rank_where.text = '='
else
	temp_sel = sle_sel_rank.text
	lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "RANK" )

	if lv_index = -1 Then
		messagebox("ERROR","RANK Not found in Dictionary")
		return -1
	end if
   lv_where = fx_error_check_fields &
		(iv_dict_structure[lv_index].data_type,em_rank_where.text,&
		temp_sel,'Rank',sle_sel_rank, &
		iv_dict_structure[lv_index].min_len,&
		iv_dict_structure[lv_index].max_len,&
		iv_dict_structure[lv_index].leading_alpha)
   if lv_where = 'ERROR' Then
		return - 1
   end if
   if pos(temp_sel,'%') > 1 then
		temp_sel = left(temp_sel,len(temp_sel)- 1)
   end if
	//anne-s 11-03-97
   sel_rank = format_where_n(temp_sel,lv_where)
		
	// Format where places quotes around the string. This causes problems for numeric fields	
   if iv_where = '' then
		sel_connect = ''
   else
		sel_connect = st_rank_connect.text
   end if
   if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and &
				(pos(sel_rank,' OR ') > 0 or pos(sel_rank,' AND ') > 0) then
		iv_where = iv_where + ' ' + sel_connect + ' ' +  sel_rank  
   else
		iv_where = iv_where + ' ' + sel_connect + ' ' &
		+ ' ( '+iv_table_type+'.RANK ' + lv_where + ' ' + sel_rank + ' ) ' 
	
	end if
end if
//* where variance
// Variance is valid for reports 1 and 2.  john_wo

if Trim( sle_sel_variance.text ) = '' or rb_ratio3.checked = TRUE then 
	em_variance_where.text = '='
else
	temp_sel = sle_sel_variance.text
	lv_index = gnv_dict.uf_get_info_index( iv_dict_structure, "std_variance" )

	if lv_index = -1 Then
		messagebox("ERROR","Std Variance Not found in Dictionary")
		return -1
	end if
   lv_where = fx_error_check_fields &
		(iv_dict_structure[lv_index].data_type,em_variance_where.text,&
		temp_sel,'std_variance',sle_sel_variance, &
		iv_dict_structure[lv_index].min_len,&
		iv_dict_structure[lv_index].max_len,&
		iv_dict_structure[lv_index].leading_alpha)
   if lv_where = 'ERROR' Then
		return - 1
   end if
   if pos(temp_sel,'%') > 1 then
		temp_sel = left(temp_sel,len(temp_sel)- 1)
   end if
   sel_variance = &
		format_where(temp_sel,lv_where,+iv_table_type+'.variance')
		n_cst_string		lnv_string												// FDG 04/06/98
		sel_variance	=	lnv_string.of_removequotes(sel_variance)		// FDG 04/06/98
	
   if iv_where = '' then
		sel_connect = ''
   else
		sel_connect = st_variance_connect.text
   end if
   if (lv_where = 'LIKE' or lv_where = 'NOT LIKE') and &
			(pos(sel_variance,' OR ') > 0 or pos(sel_variance,' AND ') > 0) then
		iv_where = iv_where + ' ' + sel_connect + ' ' +  sel_variance  
   else
      iv_where = iv_where + ' ' + sel_connect + ' ' &
		+ ' ( '+iv_table_type+'.std_variance ' + lv_where + ' ' + sel_variance + ' ) ' 
	end if
end if
//end john_wo 11/11/97 spec 127 (add variance)
//********************************************************************
// Create the "period" where clause.
//********************************************************************
//  Include the "selected" period 
if iv_where = '' then
	period_connect = ''
else
	period_connect = 'AND'
end if

period = string(uo_1.uf_return_period())

//NLG 4-20-99 Ts2239
isx_ratio_select_parms.l_period = long(period)
isx_ratio_select_parms.l_period_key = uo_1.uf_return_key()

IF rb_ratio1.checked = TRUE THEN
	iv_where = iv_where + period_connect + ' ( '	+ iv_table_type+'.PERIOD ' + '= ' + period + ' ) '
ELSE
	IF rb_ratio2.checked = TRUE THEN
		iv_where = iv_where + period_connect + ' ( '	+ iv_table_type+'.PERIOD ' + '= ' + period + ' ) '
	else
		iv_where = iv_where + period_connect + ' ( '	+  iv_table_type+'.PERIOD ' + '= ' + period + ' ) '
	end if
END IF

if gc_debug_mode then
    messagebox('iv_where variable',iv_where)
end if

return 0
end function

private function integer wf_create_main_sql (string arg_type);//////////////////////////////////////////////////////////////////////////
//  WF_CREATE_MAIN_SQL   in W_RATIO1_SELECT  (generates Ratio1 Report)
//////////////////////////////////////////////////////////////////////////
//
//	10/03/94	SG		Modified to read STARS_WIN_PARM to get table names
//	09/05/96	SB		Changed the Hard coding of Prov Spec Area and Catg
//						this was changed on the tables and causing an error
//	01/22/01	GaryR	Stars 4.7 DataBase Port - Using Group By
//	03/22/02	FDG	Track 2920d. For Top providers report, use iv_r2_sql_stmt
//						instead of lv_sql_stmt.
// JasonS 09/27/02 Track 4370c  Sort "Top Provider" by rank then prov_id
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//	05/14/08	GaryR	SPR 5360	Fix reversed columns RATIO_NORM and STD_DEV in SQL
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////

string lv_sql_stmt, lv_col, lv_groupby, lv_where, lv_having
string lv_r1_sql_stmt, lv_r2_sql_stmt, lv_r3_sql_stmt
string lv_ver1_order_by, lv_ver2_order_by, lv_ver3_order_by 
string lv_table_type

IF arg_type = 'COUNT' OR arg_type = 'count' THEN
	//This was added for prob 907
	//Version 2 needs everything grouped together.
	if rb_ratio3.checked = TRUE then
		if rb_rpt2.checked = TRUE Then		
			lv_col = "SELECT COUNT (DISTINCT PROV_SPEC" + gnv_sql.is_concat + "PROV_AREA ) "
		else
			lv_col = 'SELECT COUNT (*) '				
		end if
	else
		lv_col = 'SELECT COUNT (*) '		
	end if
ELSE
   If rb_ratio3.checked = false then
	   lv_col = 'SELECT NBR_CAT, AVG_RANK,' + is_npi + 'PROV_ID, PROV_NAME, Prov_SPEC, Prov_AREA, CAT_of_serv, NBR_PAT, NBR_SRVC, RATIO, RANK, NORM_95_PER, RATIO_NORM, STD_DEV, NBR_PROV, STD_VARIANCE ' //SB changed to match the Prov_ratio table- JWW 9/15/97 ADDED STD_VARIANCE FOR SPEC 127 3.6 REL
   else
      lv_col = 'SELECT * '
   end if
//	01/22/01	GaryR	Stars 4.7 DataBase Port
END IF

lv_where = ' WHERE ' + iv_where 

//	01/22/01	GaryR	Stars 4.7 DataBase Port - Begin
lv_groupby = " AND " + is_prov + " IN ( SELECT " + is_prov + " "
lv_having = lv_where + " GROUP BY " + is_prov + " ) "
//	01/22/01	GaryR	Stars 4.7 DataBase Port - End

lv_ver1_order_by = ' ORDER BY PROV_SPEC ASC, NBR_CAT DESC, AVG_RANK ASC, ' + is_prov + ' ASC '
lv_ver2_order_by = ' ORDER BY PROV_SPEC ASC, RANK ASC, ' + is_prov + ' ASC '
// JasonS 09/27/02 Begin - Track 4370c
lv_ver3_order_by = ' ORDER BY PROV_SPEC ASC, PROV_AREA ASC, CAT_OF_SERV ASC, RANK ASC '
// JasonS 09/27/02 End - Track 4370c

IF arg_type = 'COUNT' OR arg_type = 'count' THEN
	IF rb_ratio1.checked = true THEN
		lv_sql_stmt = iv_r1_sql_stmt + lv_where 
	ELSE
      IF rb_ratio2.checked = true then
   		lv_sql_stmt = iv_r2_sql_stmt + lv_where 
      else
     		lv_sql_stmt = iv_r3_sql_stmt + lv_where
      end if
   end if
ELSE
	//	01/22/01	GaryR	Stars 4.7 DataBase Port - Begin
	IF rb_ratio1.checked = true THEN
		IF rb_rpt1.checked = TRUE THEN
			lv_sql_stmt = iv_r1_sql_stmt + lv_where + lv_groupby + iv_r1_sql_stmt + lv_having + lv_ver1_order_by 
		ELSEIF rb_rpt2.checked = TRUE THEN
			lv_sql_stmt = iv_r1_sql_stmt + lv_where + lv_groupby + iv_r1_sql_stmt + lv_having + lv_ver2_order_by 
		ELSE
			lv_sql_stmt = iv_r1_sql_stmt + lv_where + lv_groupby + iv_r1_sql_stmt + lv_having + lv_ver3_order_by 
		END IF
	ELSE
   	IF rb_ratio2.checked = true THEN
		   IF rb_rpt1.checked = TRUE THEN
				lv_sql_stmt = iv_r2_sql_stmt + lv_where + lv_groupby + iv_r2_sql_stmt + lv_having + lv_ver1_order_by 
		   ELSEIF rb_rpt2.checked = TRUE THEN
				lv_sql_stmt = iv_r2_sql_stmt + lv_where + lv_groupby + iv_r2_sql_stmt + lv_having + lv_ver2_order_by 
		   ELSE
				lv_sql_stmt = iv_r2_sql_stmt + lv_where + lv_groupby + iv_r2_sql_stmt + lv_having + lv_ver3_order_by
		   END IF
      ELSE
		   lv_sql_stmt = iv_r3_sql_stmt + lv_where
      END IF
	END IF
END IF

iv_sql_stmt = lv_col + lv_sql_stmt

if gc_debug_mode then
  messagebox('IV_SQL_STMT',iv_sql_stmt)
end if

return 1
end function

public function string wf_get_win_parm (string as_rpt);//////////////////////////////////////////////////////////////////////////
//
// Function: fx_get_table
// Author: Skip Goldie   Date: September 1994
// Description: Retrieves table name (and type) from STARS_WIN_PARM 
// Arguments: (1) window (passed by value)
//            (2) which_event (passed by value)
//            (3) invoice_type (passed by reference)
// Returns: A string containing the table name and type.
//          The first two characters are the table type.
//          The remainder of the string is the table name.
//
//////////////////////////////////////////////////////////////////////////
//
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//
//////////////////////////////////////////////////////////////////////////

string ls_table, ls_win_id = "W_RATIO_SELECT"

IF isx_ratio_select_parms.b_npi THEN ls_win_id = "W_RATIO_SELECT_NPI"

select label 
into 	:ls_table
from stars_win_parm
where win_id   = :ls_win_id
  and tbl_type = :iv_invoice_type 
  and cntl_id  = :as_rpt
using stars2ca;

if stars2ca.of_check_status() <> 0 then
   errorbox(stars2ca, "Error retrieving Ratio table from STARS_WIN_PARM table")
	return 'ERROR'
end if

RETURN ls_table
end function

event open;call super::open;//                  *** OPEN FOR W_RATIO1_SELECT ***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- 	-------------------------------------------------------- 
//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
// 05/04/99 FNC	FS/TS1804c Starcare track 1804. Determine if ratio 3 report
//						will display allowed amount or billed amount.
// 07/21/98 AJS  	Stars 4.0 Track #1296
// 11-21-97 AJS  	Prob 128 Rel 3.6 remove equal signs; add to postopen
// 08/26/94 FNC  	Force business type = MB
// 12/17/93 tpb  	Created from w_norm_analysis
//
//***********************************************************************

long ll_check_for_periods

setpointer(hourglass!)
setmicrohelp(w_main,'Opening Ratio Selection...')

uo_1.uf_load_dddw('RATIO', iv_invoice_type, 'AC', 'FALSE')

ll_check_for_periods = uo_1.uf_return_key()		//ajs 4.0 07-21-98 4.0 Track #1296
if ll_check_for_periods = 0 then						//ajs 4.0 07-21-98 4.0 Track #1296
	close(this)												//ajs 4.0 07-21-98 4.0 Track #1296
	Return
end if														//ajs 4.0 07-21-98 4.0 Track #1296

ib_use_bill  =  uo_1.uf_get_use_bill()				// FDG 05/20/99

rb_ratio1.checked = true		//KMM 7/10/95 sets ratio 1 as the default
rb_ratio1.triggerevent(clicked!)

//	Check NPI
SELECT count(*)
INTO :ll_check_for_periods
FROM PERIOD_CNTL
WHERE FUNCTION_NAME = 'RATIO'
AND FUNCTION_STATUS = 'AC'
AND INVOICE_TYPE = :iv_invoice_type
AND RUN_BY_OPTIONS = 1
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "ERROR", "Unable to check for NPI Ratios" )
END IF

IF ll_check_for_periods > 0 THEN	cbx_npi.visible = TRUE

setmicrohelp(w_main,'Ready')
end event

on activate;sle_sel_spec.SetFocus()
end on

on w_ratio_select.create
int iCurrent
call super::create
this.sle_sel_spec=create sle_sel_spec
this.sle_sel_area=create sle_sel_area
this.sle_sel_cat=create sle_sel_cat
this.cb_query=create cb_query
this.uo_1=create uo_1
this.st_ratio3_connect=create st_ratio3_connect
this.st_provider_connect=create st_provider_connect
this.em_ratio3_where=create em_ratio3_where
this.em_provider_where=create em_provider_where
this.rb_ratio3=create rb_ratio3
this.st_count=create st_count
this.st_area_connect=create st_area_connect
this.st_cat_connect=create st_cat_connect
this.rb_ratio1=create rb_ratio1
this.rb_rpt3=create rb_rpt3
this.rb_rpt2=create rb_rpt2
this.rb_rpt1=create rb_rpt1
this.rb_ratio2=create rb_ratio2
this.em_area_where=create em_area_where
this.em_cat_where=create em_cat_where
this.em_spec_where=create em_spec_where
this.st_6=create st_6
this.cb_clear=create cb_clear
this.cb_view_report=create cb_view_report
this.st_3=create st_3
this.st_1=create st_1
this.cb_close=create cb_close
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_5=create st_5
this.st_rank_connect=create st_rank_connect
this.em_rank_where=create em_rank_where
this.sle_sel_rank=create sle_sel_rank
this.st_variance=create st_variance
this.st_variance_connect=create st_variance_connect
this.em_variance_where=create em_variance_where
this.sle_sel_variance=create sle_sel_variance
this.mle_cutoff_percent=create mle_cutoff_percent
this.cbx_npi=create cbx_npi
this.sle_sel_ratio3=create sle_sel_ratio3
this.st_7=create st_7
this.sle_sel_prov=create sle_sel_prov
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_sel_spec
this.Control[iCurrent+2]=this.sle_sel_area
this.Control[iCurrent+3]=this.sle_sel_cat
this.Control[iCurrent+4]=this.cb_query
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_ratio3_connect
this.Control[iCurrent+7]=this.st_provider_connect
this.Control[iCurrent+8]=this.em_ratio3_where
this.Control[iCurrent+9]=this.em_provider_where
this.Control[iCurrent+10]=this.rb_ratio3
this.Control[iCurrent+11]=this.st_count
this.Control[iCurrent+12]=this.st_area_connect
this.Control[iCurrent+13]=this.st_cat_connect
this.Control[iCurrent+14]=this.rb_ratio1
this.Control[iCurrent+15]=this.rb_rpt3
this.Control[iCurrent+16]=this.rb_rpt2
this.Control[iCurrent+17]=this.rb_rpt1
this.Control[iCurrent+18]=this.rb_ratio2
this.Control[iCurrent+19]=this.em_area_where
this.Control[iCurrent+20]=this.em_cat_where
this.Control[iCurrent+21]=this.em_spec_where
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.cb_clear
this.Control[iCurrent+24]=this.cb_view_report
this.Control[iCurrent+25]=this.st_3
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.cb_close
this.Control[iCurrent+28]=this.gb_3
this.Control[iCurrent+29]=this.gb_2
this.Control[iCurrent+30]=this.gb_1
this.Control[iCurrent+31]=this.st_5
this.Control[iCurrent+32]=this.st_rank_connect
this.Control[iCurrent+33]=this.em_rank_where
this.Control[iCurrent+34]=this.sle_sel_rank
this.Control[iCurrent+35]=this.st_variance
this.Control[iCurrent+36]=this.st_variance_connect
this.Control[iCurrent+37]=this.em_variance_where
this.Control[iCurrent+38]=this.sle_sel_variance
this.Control[iCurrent+39]=this.mle_cutoff_percent
this.Control[iCurrent+40]=this.cbx_npi
this.Control[iCurrent+41]=this.sle_sel_ratio3
this.Control[iCurrent+42]=this.st_7
this.Control[iCurrent+43]=this.sle_sel_prov
this.Control[iCurrent+44]=this.st_4
end on

on w_ratio_select.destroy
call super::destroy
destroy(this.sle_sel_spec)
destroy(this.sle_sel_area)
destroy(this.sle_sel_cat)
destroy(this.cb_query)
destroy(this.uo_1)
destroy(this.st_ratio3_connect)
destroy(this.st_provider_connect)
destroy(this.em_ratio3_where)
destroy(this.em_provider_where)
destroy(this.rb_ratio3)
destroy(this.st_count)
destroy(this.st_area_connect)
destroy(this.st_cat_connect)
destroy(this.rb_ratio1)
destroy(this.rb_rpt3)
destroy(this.rb_rpt2)
destroy(this.rb_rpt1)
destroy(this.rb_ratio2)
destroy(this.em_area_where)
destroy(this.em_cat_where)
destroy(this.em_spec_where)
destroy(this.st_6)
destroy(this.cb_clear)
destroy(this.cb_view_report)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_5)
destroy(this.st_rank_connect)
destroy(this.em_rank_where)
destroy(this.sle_sel_rank)
destroy(this.st_variance)
destroy(this.st_variance_connect)
destroy(this.em_variance_where)
destroy(this.sle_sel_variance)
destroy(this.mle_cutoff_percent)
destroy(this.cbx_npi)
destroy(this.sle_sel_ratio3)
destroy(this.st_7)
destroy(this.sle_sel_prov)
destroy(this.st_4)
end on

event ue_preopen;call super::ue_preopen;
iv_invoice_type = Message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

end event

event ue_postopen;call super::ue_postopen;//anne-s 11-21-97 Prob 128 Rel 3.6 add equal signs to edit masks that were not displaying
em_spec_where.text = '='
em_cat_where.text = '='
em_area_where.text = '='
em_provider_where.text = '='
em_rank_where.text = '='
em_variance_where.text = '>='
em_ratio3_where.text = '='

end event

type sle_sel_spec from u_sle within w_ratio_select
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Specialty"
string accessibledescription = "Lookup Field - Specialty"
integer x = 1129
integer y = 684
integer width = 1477
integer height = 100
integer taborder = 110
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event modified;call super::modified;st_count.text = ''
end event

event ue_lookup;call super::ue_lookup;///////////////////////////////////////////////////////
//
//	07/01/03	GaryR	Track 3613d Account for DENTAL codes
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
///////////////////////////////////////////////////////

setpointer(hourglass!)

IF Trim( is_ps_lookup ) <> "" THEN
	gv_code_to_use = is_ps_lookup
ELSE
	gv_code_to_use = 'SP'
END IF

open(w_code_lookup)
if gv_code_to_use <> '' Then
	sle_sel_spec.text = gv_code_to_use
end if
end event

type sle_sel_area from u_sle within w_ratio_select
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Area"
string accessibledescription = "Lookup Field - Area"
integer x = 1129
integer y = 900
integer width = 1477
integer height = 100
integer taborder = 150
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event modified;call super::modified;st_count.text = ''
end event

event ue_lookup;call super::ue_lookup;///////////////////////////////////////////////////////
//
//	07/01/03	GaryR	Track 3613d Account for DENTAL codes
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
///////////////////////////////////////////////////////

setpointer(hourglass!)

IF Trim( is_pa_lookup ) <> "" THEN
	gv_code_to_use = is_pa_lookup
ELSE
	gv_code_to_use = 'AR'
END IF

open(w_code_lookup)
if gv_code_to_use <> '' Then
	sle_sel_area.text = gv_code_to_use
end if
end event

type sle_sel_cat from u_sle within w_ratio_select
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Category"
string accessibledescription = "Lookup Field - Category"
integer x = 1129
integer y = 792
integer width = 1477
integer height = 100
integer taborder = 130
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event modified;call super::modified;st_count.text = ''
end event

event ue_lookup;call super::ue_lookup;/////////////////////////////////////////////////////////////////////
//
//	12/18/97	FDG	Stars 3.6 (Prob 173) - When doing a code lookup on
//						category, if the period states that the ratios
//						are processed by procedure only, then do a lookup
//						on procedure code instead of category.
//	07/01/03	GaryR	Track 3613d Account for DENTAL codes
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
/////////////////////////////////////////////////////////////////////

setpointer(hourglass!)

//	FDG 12/18/97 begin
//gv_code_to_use = 'CT'

IF	Upper (is_use_catgproc)	=	'N'	THEN
	IF Trim( is_pc_lookup ) <> "" THEN
		gv_code_to_use				=	is_pc_lookup
	ELSE
		gv_code_to_use				=	'PC'
	END IF
ELSE
	gv_code_to_use				=	'CT'
END IF
//	FDG 12/18/97 end

open(w_code_lookup)

if gv_code_to_use <> '' Then
	sle_sel_cat.text = gv_code_to_use
end if
end event

type cb_query from u_cb within w_ratio_select
string accessiblename = "Query"
string accessibledescription = "Query"
integer x = 407
integer y = 1428
integer width = 480
integer height = 108
integer taborder = 240
integer weight = 400
string text = "&Query"
boolean default = true
end type

event clicked;//  Clicked event for cb_query  in w_ratio1_select
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed

int cnt,rc                 
string lv_sql_stmt

gv_active_invoice = iv_invoice_type

SetMicroHelp(w_main,"Now counting Ratio Report records")

st_count.text = ''
setpointer(hourglass!)

rc = wf_test_rb()
if rc <> 1 then 
	return
end if

rc = wf_build_sql_parms('COUNT')
IF rc = -1 THEN
	return
ELSE
	rc = wf_create_main_sql('COUNT')
	if gc_debug_mode then
		clipboard('')
		clipboard(iv_sql_stmt)
		messagebox('Created SQL Statement.',iv_sql_stmt)
	end if
	IF rc = -1 THEN
		return
	END IF

   SQLCA.LogID      = stars1ca.LogID
	SQLCA.LogPass    = stars1ca.LogPass
	SQLCA.ServerName = stars1ca.ServerName
	SQLCA.Lock       = stars1ca.Lock
	SQLCA.DBMS       = stars1ca.DBMS
	SQLCA.database   = stars1ca.database
	SQLCA.userid     = stars1ca.userid
	SQLCA.dbpass     = stars1ca.dbpass

	//sqlcmd('connect',sqlca,'Error Connecting to Database',5)			// FDG 02/20/01
	SQLCA.of_connect()																// FDG 02/20/01
	
	DECLARE c1 DYNAMIC CURSOR FOR SQLSA;

   PREPARE SQLSA FROM :iv_sql_stmt;
	cnt = 0
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Preparing to Read the Ratio 1 tables')
      return
   end if
	OPEN DYNAMIC c1;
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Opening the Ratio 1 tables')
      return
   end if

   Fetch c1 into :st_count.text;
	If (sqlca.of_check_status() = 100) then
		st_count.text = '0'
		//sqlcmd('disconnect',sqlca,'Error disconnecting from database',1)	// FDG 02/20/01
		SQLCA.of_disconnect()																// FDG 02/20/01
		RETURN
	end if
	 
	if sqlca.of_check_status() <> 0 then
		close c1;
		if sqlca.of_check_status() <> 0 then
      	errorbox(sqlca,'Error Closing the Ratio 1 tables after a Read Error')
      	return
   	end if
      errorbox(sqlca,'Error Reading the Ratio 1 tables')
      return
   end if

   close c1;
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Preparing to Read the Ratio 1 tables')
      return
   end if
	//sqlcmd('disconnect',sqlca,'Error disconnecting from database',1)	// FDG 02/20/01
	SQLCA.of_disconnect()																// FDG 02/20/01
END IF

SetMicroHelp(w_main,"Ready")
end event

type uo_1 from u_display_period within w_ratio_select
integer x = 261
integer y = 464
integer taborder = 80
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//*********************************************************//
// Highlights the current row and assigns column data from //
// that row to instance variables.  The return functions   //
// can be called to retrieve those variables.              //
//*********************************************************//
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************//

string ls_period_desc
long ll_current_child_row
datawindowchild ldw_child
decimal ldc_cutoff_percent
integer li_cutoff_percent

st_count.text = ''

this.GetChild('period_key',ldw_child)
ll_current_child_row = ldw_child.GetRow()
   
if ll_current_child_row > 0 then
	ldc_cutoff_percent = &
	ldw_child.getitemnumber(ll_current_child_row, 'cutoff_percent_float')
	ldc_cutoff_percent = Round(ldc_cutoff_percent,2) * 100
	li_cutoff_percent = ldc_cutoff_percent
	mle_cutoff_percent.text = 'Top ' + String(li_cutoff_percent) + '%'
	mle_cutoff_percent.text = 'Top ' + String(li_cutoff_percent) + '%'
	is_use_catgproc = ldw_child.getitemstring(ll_current_child_row, 'use_catgproc')
	if Upper(is_use_catgproc) = 'Y' then
		st_3.text			=	'Category:'			//	FDG 12/18/97
		st_3.accessiblename = "Category"
		st_3.accessibledescription = "Category"
		sle_sel_cat.accessiblename = "Lookup Field - Category"
		sle_sel_cat.accessibledescription = "Lookup Field - Category"
		mle_cutoff_percent.text = mle_cutoff_percent.text + &
										' - Reporting by Category/Procedure'
	elseif Upper(is_use_catgproc) = 'N' then
		st_3.text			=	'Procedure:'		//	FDG 12/18/97
		st_3.accessiblename = "Procedure"
		st_3.accessibledescription = "Procedure"
		sle_sel_cat.accessiblename = "Lookup Field - Procedure"
		sle_sel_cat.accessibledescription = "Lookup Field - Procedure"
		mle_cutoff_percent.text = mle_cutoff_percent.text + &
										'- Reporting by Procedure Code'
	end if
else
	is_use_catgproc = ''
	mle_cutoff_percent.text = ''
	return
end if

end event

type st_ratio3_connect from statictext within w_ratio_select
boolean visible = false
string accessiblename = "AND"
string accessibledescription = "AND"
accessiblerole accessiblerole = statictextrole!
integer x = 613
integer y = 1020
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "AND"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_provider_connect from statictext within w_ratio_select
string accessiblename = "AND"
string accessibledescription = "AND"
accessiblerole accessiblerole = statictextrole!
integer x = 613
integer y = 1020
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "AND"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_ratio3_where from editmask within w_ratio_select
boolean visible = false
string accessiblename = "Provider Operator"
string accessibledescription = "Provider Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 1012
integer width = 242
integer height = 100
integer taborder = 160
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = ">~t>/>=~t>=/<~t</<=~t<=/=~t=/<>~t<>/><~t></"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type em_provider_where from editmask within w_ratio_select
string accessiblename = "Provider Operator"
string accessibledescription = "Provider Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 1012
integer width = 242
integer height = 100
integer taborder = 170
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = ">~t>/>=~t>=/<~t</<=~t<=/=~t=/<>~t<>/><~t></"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type rb_ratio3 from radiobutton within w_ratio_select
string accessiblename = "Ratio 3 Report"
string accessibledescription = "Ratio 3 Report"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 183
integer y = 260
integer width = 549
integer height = 68
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Ratio 3 Report"
boolean automatic = false
end type

event clicked;//*********************************************************************************
// Script Name:	rb_ratio3.checked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Reset criteria screen to reflect Ratio 3.
//
//*********************************************************************************
// 08/26/98	FNC	Track 1597. Change the description for the third radio button.
//
// 05/04/99 FNC	FS/TS1804c Starcare track 1804. Determine if ratio 3 report
//						will display allowed amount or billed amount.
//	05/28/09	Katie	GNL.600.5633	Moved radio button functionality here.  Handling enabling and disabling of 
//						the ratio 3 and prov boxes appropriately.
//*********************************************************************************

integer rc

rb_ratio1.checked = false
rb_ratio2.checked = false
rb_ratio3.checked = true

setpointer(hourglass!)
st_3.visible = false
st_cat_connect.visible = false
em_cat_where.visible = false
sle_sel_cat.visible = false
ib_use_bill	=	uo_1.uf_get_use_bill()	// FDG 05/20/99
IF ib_use_bill  THEN					// FNC 05/04/99 Start
   rb_rpt1.text = "Provs by Inc in Bill Charges"
   rb_rpt3.text = " Provs by Inc in Bill Charges within Specialty/Area"
else
	rb_rpt1.text = "Provs by Inc in Allw Charges"
	rb_rpt3.text = " Provs by Inc in Allw Charges within Specialty/Area"	// FNC 08/26/98
END IF									// FNC 05/04/99 End

rb_rpt2.text = "Specialty / Area Statistics"

rb_rpt1.checked = true
rb_rpt2.checked = false
rb_rpt3.checked = false

sle_sel_area.text = ''
sle_sel_cat.text = ''
sle_sel_prov.text = ''
sle_sel_rank.text = ''
sle_sel_ratio3.text = ''
sle_sel_spec.text = ''
sle_sel_variance.text = ''

st_variance.visible = FALSE
st_variance_connect.visible = FALSE
em_variance_where.visible = FALSE
sle_sel_variance.visible = FALSE


st_7.visible = TRUE
st_ratio3_connect.visible = TRUE
sle_sel_ratio3.visible = TRUE
sle_sel_ratio3.enabled = TRUE
em_ratio3_where.visible = TRUE
em_ratio3_where.enabled = TRUE
sle_sel_prov.visible = false
sle_sel_prov.enabled = false
em_provider_where.visible = FALSE
em_provider_where.enabled = FALSE

rc = wf_get_tbl_type()
end event

type st_count from statictext within w_ratio_select
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1440
integer width = 265
integer height = 80
integer textsize = -10
integer weight = 400
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

type st_area_connect from statictext within w_ratio_select
string accessiblename = "AND"
string accessibledescription = "AND"
accessiblerole accessiblerole = statictextrole!
integer x = 613
integer y = 920
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "AND"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cat_connect from statictext within w_ratio_select
string accessiblename = "AND"
string accessibledescription = "AND"
accessiblerole accessiblerole = statictextrole!
integer x = 613
integer y = 812
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "AND"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_ratio1 from radiobutton within w_ratio_select
string accessiblename = "Ratio 1 Report"
string accessibledescription = "Ratio 1 Report"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 183
integer y = 108
integer width = 576
integer height = 68
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Ratio 1 Report"
boolean automatic = false
end type

event clicked;//*********************************************************************************
// Script Name:	rb_ratio1.checked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Reset criteria screen to reflect Ratio 1.
//
//*********************************************************************************
// 08/26/98		FNC	Track 1597. Remove st_2 because put all text into string that
//							sets radio button name
//	05/28/09		Katie	GNL.600.5633	Moved radio button functionality into here.    Handling enabling and disabling of 
//						the ratio 3 and prov boxes appropriately.
//
//*********************************************************************************

integer rc

setpointer(hourglass!)

rb_ratio1.checked = true
rb_ratio2.checked = false
rb_ratio3.checked = false

st_3.visible = true
st_cat_connect.visible = true
em_cat_where.visible = true
sle_sel_cat.visible = true

gb_2.enabled = true
rb_rpt1.text = "By # Categories, Avg. Rank"
rb_rpt2.text = "By Specialty"
rb_rpt3.text = "Top Providers"
rb_rpt1.checked = true
rb_rpt2.checked = false
rb_rpt3.checked = false
st_variance.visible = TRUE
st_variance_connect.visible = TRUE
em_variance_where.visible = TRUE
sle_sel_variance.visible = TRUE
sle_sel_ratio3.visible = false
sle_sel_ratio3.enabled = false
em_ratio3_where.visible = FALSE
em_ratio3_where.enabled = FALSE
sle_sel_prov.visible = true
sle_sel_prov.enabled = true
em_provider_where.visible = TRUE
em_provider_where.enabled = TRUE

st_7.visible = FALSE
st_ratio3_connect.visible = FALSE
sle_sel_ratio3.visible = FALSE
rc = wf_get_tbl_type()
end event

type rb_rpt3 from radiobutton within w_ratio_select
string accessiblename = "Top Providers"
string accessibledescription = "Top Providers"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1344
integer y = 252
integer width = 1221
integer height = 68
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Top Providers"
boolean automatic = false
end type

event clicked;//*********************************************************************************
// Script Name:	rb_rpt3.checked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Reset criteria screen to reflect Report 3.
//
//*********************************************************************************
//
//	05/28/09		Katie	GNL.600.5633	Moved radio button functionality into here.  Handle enabling/disabling of
//							the ratio 3 and prov fields.
//
//*********************************************************************************
if rb_ratio3.checked = true then	
	st_7.visible = TRUE
	st_ratio3_connect.visible = TRUE
	em_ratio3_where.visible = TRUE
	sle_sel_ratio3.visible = TRUE
	sle_sel_ratio3.enabled = TRUE
	em_ratio3_where.visible = TRUE
	em_ratio3_where.enabled = TRUE
	sle_sel_prov.visible = FALSE
	sle_sel_prov.enabled = FALSE
	em_provider_where.visible = FALSE
	em_provider_where.enabled = FALSE
	
end if

rb_rpt1.checked = false
rb_rpt2.checked = false
rb_rpt3.checked = true
end event

type rb_rpt2 from radiobutton within w_ratio_select
string accessiblename = "By Specialty"
string accessibledescription = "By Specialty"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1344
integer y = 176
integer width = 1221
integer height = 68
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "By Specialty"
boolean automatic = false
end type

event clicked;//*********************************************************************************
// Script Name:	rb_rpt2.checked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Reset criteria screen to reflect Report 2.
//
//*********************************************************************************
//
//	05/28/09		Katie	GNL.600.5633	Moved radio button functionality into here.  Handle enabling/disabling of
//							the ratio 3 and prov fields.
//
//*********************************************************************************
if rb_ratio3.checked = true then
	st_7.visible = FALSE
	st_ratio3_connect.visible = FALSE
	em_ratio3_where.visible = FALSE
	sle_sel_ratio3.visible = FALSE
	sle_sel_ratio3.enabled = FALSE
	em_ratio3_where.visible = FALSE
	em_ratio3_where.enabled = FALSE
	sle_sel_prov.visible = TRUE
	sle_sel_prov.enabled = TRUE
	em_provider_where.visible = TRUE
	em_provider_where.enabled = TRUE
end if

rb_rpt1.checked = false
rb_rpt2.checked = true
rb_rpt3.checked = false
end event

type rb_rpt1 from radiobutton within w_ratio_select
string accessiblename = "By # Categories, Avg. Rank"
string accessibledescription = "By # Categories, Avg. Rank"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1344
integer y = 104
integer width = 1221
integer height = 68
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "By # Categories, Avg. Rank"
boolean automatic = false
end type

event clicked;//*********************************************************************************
// Script Name:	rb_rpt1.checked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Reset criteria screen to reflect Report 1.
//
//*********************************************************************************
//
//	05/28/09		Katie	GNL.600.5633	Moved radio button functionality into here.  Handle enabling/disabling of
//							the ratio 3 and prov fields.
//
//*********************************************************************************
if rb_ratio3.checked = true then
	st_7.visible = TRUE
	st_ratio3_connect.visible = TRUE
	em_ratio3_where.visible = TRUE
	sle_sel_ratio3.visible = TRUE
	sle_sel_ratio3.enabled = TRUE
	em_ratio3_where.visible = TRUE
	em_ratio3_where.enabled = TRUE
	sle_sel_prov.visible = FALSE
	sle_sel_prov.enabled = FALSE
	em_provider_where.visible = FALSE
	em_provider_where.enabled = FALSE
end if

rb_rpt1.checked = true
rb_rpt2.checked = false
rb_rpt3.checked = false
end event

type rb_ratio2 from radiobutton within w_ratio_select
string accessiblename = "Ratio 2 Report"
string accessibledescription = "Ratio 2 Report"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 183
integer y = 176
integer width = 576
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Ratio 2 Report"
boolean automatic = false
end type

event clicked;//*********************************************************************************
// Script Name:	rb_ratio2.checked
//
// Arguments:	N/A
//
// Returns:		long
//
// Description:	Reset criteria screen to reflect Ratio 2.
//
//*********************************************************************************
// 08/26/98		FNC	Track 1597. Remove st_2 because put all text into string that
//							sets radio button name
//	05/28/09		Katie	GNL.600.5633	Moved radio button functionality here.  Handling enabling and disabling of 
//						the ratio 3 and prov boxes appropriately.
//
//*********************************************************************************


integer rc

rb_ratio1.checked = false
rb_ratio2.checked = true
rb_ratio3.checked = false

setpointer(hourglass!)
st_3.visible = true
st_cat_connect.visible = true
em_cat_where.visible = true
sle_sel_cat.visible = true
gb_2.enabled = true
rb_rpt1.text = "By # Categories, Avg. Rank"
rb_rpt2.text = "By Specialty"
rb_rpt3.text = "Top Providers"

rb_rpt1.checked = true
rb_rpt2.checked = false
rb_rpt3.checked = false

st_variance.visible = TRUE
st_variance_connect.visible = TRUE
em_variance_where.visible = TRUE
sle_sel_variance.visible = TRUE

st_7.visible = FALSE
st_ratio3_connect.visible = FALSE
sle_sel_ratio3.visible = FALSE
sle_sel_ratio3.enabled = FALSE
em_ratio3_where.visible = FALSE
em_ratio3_where.enabled = FALSE
sle_sel_prov.visible = true
sle_sel_prov.enabled = true
em_provider_where.visible = TRUE
em_provider_where.enabled = TRUE

rc = wf_get_tbl_type()
end event

type em_area_where from editmask within w_ratio_select
event change pbm_enchange
string accessiblename = "Area Operator"
string accessibledescription = "Area Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 900
integer width = 242
integer height = 100
integer taborder = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = ">~t>/>=~t>=/<~t</<=~t<=/=~t=/<>~t<>/><~t></"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_cat_where from editmask within w_ratio_select
event change pbm_enchange
string accessiblename = "Category Operator"
string accessibledescription = "Category Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 792
integer width = 242
integer height = 100
integer taborder = 120
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = ">~t>/>=~t>=/<~t</<=~t<=/=~t=/<>~t<>/><~t></"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type em_spec_where from editmask within w_ratio_select
event change pbm_enchange
string accessiblename = "Specialty Operator"
string accessibledescription = "Specialty Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 684
integer width = 242
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = "=~t=/><~t></<>~t<>/>~t>/<~t</>=~t>=/<=~t<=/"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

on change;st_count.text = ''
end on

type st_6 from statictext within w_ratio_select
string accessiblename = "Area"
string accessibledescription = "Area"
accessiblerole accessiblerole = statictextrole!
integer x = 325
integer y = 920
integer width = 256
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Area:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_clear from u_cb within w_ratio_select
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1527
integer y = 1428
integer width = 480
integer height = 108
integer taborder = 260
integer weight = 400
string text = "C&lear"
end type

event clicked;//	11/21/97	AnneS	Added equal signs to edit mask fields that were missing
//  					them clicked script for cb_clear in w_ratio_select
//	09/12/06	GaryR	Track 4705	Clear Rank and Normalized Value fields

st_count.text    = ''
sle_sel_spec.text = ''
sle_sel_cat.text  = ''
sle_sel_area.text = ''
sle_sel_prov.text = ''
sle_sel_ratio3.text = ''
sle_sel_rank.text = ''
sle_sel_variance.text = ''

em_spec_where.text = '='
em_cat_where.text  = '='
em_area_where.text = '='
//anne-s 11-21-97
em_provider_where.text = '='
em_rank_where.text = '='
em_variance_where.text = '='

uo_1.uf_load_dddw('RATIO', iv_invoice_type, 'AC', 'FALSE')
rb_ratio1.triggerevent(Clicked!)
rb_rpt1.triggerevent(Clicked!)
end event

type cb_view_report from u_cb within w_ratio_select
string accessiblename = "View Report..."
string accessibledescription = "View Report..."
integer x = 969
integer y = 1428
integer width = 480
integer height = 108
integer taborder = 250
integer weight = 400
string text = "&View Report..."
end type

event clicked;//Modifications:
//
//	04-20-99	NLG	Ts2239. Remove references to gv_period and gv_period_key. Pass
//						structure instead of stringparm to w_ratio_rpt
//	05/20/99	FDG	1804c.  4.0 SP2.  Pass use_bill_alwd to w_ratio_rpt.
//
/////////////////////////////////////////////////////////////////////////////////////

//  Clicked event for cb_view_report  in w_ratio_select
int rc
string what, lv_rpt_type, lv_rpt_ver,parm

setpointer(hourglass!)
gv_active_invoice = iv_invoice_type
w_main.triggerevent('timer')
what = ''

rc = wf_test_rb()
if rc <> 1 then 
	return
end if

// Set instance variable to the ratio report chosen.  SG Mar 95

if rb_ratio1.checked = true then
   SetMicroHelp(w_main,"Now generating the Ratio 1 Report")
   iv_ratio_rpt_sel = 1
	lv_rpt_type = 'R1'
else
   if rb_ratio2.checked = true then
	   SetMicroHelp(w_main,"Now generating the Ratio 2 Report")
      iv_ratio_rpt_sel = 2
	   lv_rpt_type = 'R2'
   else
	   SetMicroHelp(w_main,"Now generating the Ratio 3 Report")
      iv_ratio_rpt_sel = 3
	   lv_rpt_type = 'R3'
   end if
end if

// This window builds and passes both the full SQL SELECT statement, and the custom "where"
//clause that is created in this window if the user selects specialty, category or area.  
//Period is always passed in the custom "where" clause.  The SQL SELECT will be used
// to retrieve the data for the report.  The custom "where" clause is displayed in the MLE.
//  create the full SQL statement
rc = wf_build_sql_parms('')
if rc = -1 then
	return
else
	rc = wf_create_main_sql('')
	IF rc = -1 THEN
		return
	END IF
end if

IF rb_rpt1.checked = TRUE THEN
	lv_rpt_ver = '1'
ELSEIF rb_rpt2.checked = TRUE THEN
	lv_rpt_ver = '2'
ELSE
	lv_rpt_ver = '3'
END IF

if gc_debug_mode then
	clipboard('')
	clipboard(iv_sql_stmt)
	messagebox('Created where Statement - going to Ratio1 rpt.',iv_where)
	messagebox('RATIO REPORT SQL Sent From View',iv_sql_stmt)
end if

//  4 Parms are passed to Ratio Report window: 
//		- the full SQL Statement
//		- the "where" criteria without the "where" keyword.  Use "iv_where" variable.
//		- the report type (R1,R2)
//		- the report verison (1,2,3)
//		- the invoice type
//NLG TS2239 pass structure instead of string
//parm = iv_sql_stmt + '~t' + iv_where + '~t' + lv_rpt_type+ '~t' + lv_rpt_ver + '~t' + iv_invoice_type
//opensheetwithparm(w_ratio_rpt,parm,MDI_Main_Frame,Help_menu_position,Layered!)

//LMC Track 2654 - make sql upper because oracle is case sensitive
//isx_ratio_select_parms.s_sql_statement = iv_sql_stmt
//isx_ratio_select_parms.s_sql_where = iv_where
isx_ratio_select_parms.s_sql_statement = upper(iv_sql_stmt)
isx_ratio_select_parms.s_sql_where = upper(iv_where)
isx_ratio_select_parms.s_rpt_type = lv_rpt_type
isx_ratio_select_parms.s_rpt_ver = lv_rpt_ver
isx_ratio_select_parms.s_invoice_type = iv_invoice_type
isx_ratio_select_parms.b_use_bill = uo_1.uf_get_use_bill()

opensheetwithparm(w_ratio_rpt,isx_ratio_select_parms,MDI_Main_Frame,Help_menu_position,Layered!)

SetMicroHelp(w_main,"Ready")

end event

type st_3 from statictext within w_ratio_select
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = statictextrole!
integer x = 183
integer y = 812
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Category:"
alignment alignment = right!
end type

type st_1 from statictext within w_ratio_select
string accessiblename = "Specialty"
string accessibledescription = "Specialty"
accessiblerole accessiblerole = statictextrole!
integer x = 165
integer y = 700
integer width = 421
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Specialty:"
alignment alignment = right!
end type

type cb_close from u_cb within w_ratio_select
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2085
integer y = 1428
integer width = 480
integer height = 108
integer taborder = 270
integer weight = 400
string text = "&Close"
end type

on clicked;
close(parent)
//close(w_ratio_rpt)
//close(w_ratio_proc_list)
//
//close(w_claim_rpt)
//close(w_header_rpt)
//close(w_line_rpt)
//close(w_claim_view)
//
end on

type gb_3 from groupbox within w_ratio_select
string accessiblename = "Report Version"
string accessibledescription = "Report Version"
accessiblerole accessiblerole = groupingrole!
integer x = 1303
integer y = 24
integer width = 1289
integer height = 336
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Report Version"
end type

type gb_2 from groupbox within w_ratio_select
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = groupingrole!
integer x = 201
integer y = 392
integer width = 2277
integer height = 252
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Period"
end type

type gb_1 from groupbox within w_ratio_select
string accessiblename = "Report Choice"
string accessibledescription = "Report Choice"
accessiblerole accessiblerole = groupingrole!
integer x = 137
integer y = 28
integer width = 1042
integer height = 328
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Report Choice"
end type

type st_5 from statictext within w_ratio_select
string accessiblename = "Rank"
string accessibledescription = "Rank"
accessiblerole accessiblerole = statictextrole!
integer x = 375
integer y = 1208
integer width = 201
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Rank:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_rank_connect from statictext within w_ratio_select
string accessiblename = "AND"
string accessibledescription = "AND"
accessiblerole accessiblerole = statictextrole!
integer x = 613
integer y = 1208
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "AND"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_rank_where from editmask within w_ratio_select
string accessiblename = "Prov Ratio 3 Operator"
string accessibledescription = "Prov Ratio 3 Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 1176
integer width = 242
integer height = 100
integer taborder = 200
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = ">~t>/>=~t>=/<~t</<=~t<=/=~t=/<>~t<>/><~t></"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type sle_sel_rank from singlelineedit within w_ratio_select
string accessiblename = "Rank"
string accessibledescription = "Rank"
accessiblerole accessiblerole = textrole!
integer x = 1129
integer y = 1176
integer width = 1477
integer height = 100
integer taborder = 210
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_variance from statictext within w_ratio_select
string accessiblename = "Normalized Value"
string accessibledescription = "Normalized Value"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 1304
integer width = 553
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Normalized Value:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_variance_connect from statictext within w_ratio_select
string accessiblename = "AND"
string accessibledescription = "AND"
accessiblerole accessiblerole = statictextrole!
integer x = 613
integer y = 1304
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "AND"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_variance_where from editmask within w_ratio_select
string accessiblename = "Normalized Value Operator"
string accessibledescription = "Normalized Value Operator"
accessiblerole accessiblerole = textrole!
integer x = 873
integer y = 1296
integer width = 242
integer height = 100
integer taborder = 220
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
boolean spin = true
string displaydata = ">~t>/>=~t>=/<~t</<=~t<=/=~t=/<>~t<>/><~t></"
double increment = 1
string minmax = "~~"
boolean usecodetable = true
end type

type sle_sel_variance from singlelineedit within w_ratio_select
string accessiblename = "Nomalized Value"
string accessibledescription = "Normalized Value"
accessiblerole accessiblerole = textrole!
integer x = 1129
integer y = 1296
integer width = 1477
integer height = 100
integer taborder = 230
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type mle_cutoff_percent from multilineedit within w_ratio_select
string accessiblename = "Cutoff Percentage"
string accessibledescription = "Cutoff Percentage"
accessiblerole accessiblerole = textrole!
integer x = 1664
integer y = 444
integer width = 713
integer height = 184
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_npi from checkbox within w_ratio_select
boolean visible = false
string accessiblename = "NPI"
string accessibledescription = "NPI"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 942
integer y = 152
integer width = 201
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "NPI"
end type

event clicked;//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI

//	Refresh the periods
IF This.checked THEN
	st_4.text = "Prov NPI:"
	st_4.accessiblename = "Provider NPI"
	st_4.accessibledescription = "Provider NPI"
	sle_sel_prov.accessiblename = "Lookup Field - Provider NPI"
	sle_sel_prov.accessibledescription = "Lookup Field - Provider NPI"
	is_prov = "PROV_NPI"
	is_npi = " PROV_NPI, "
	isx_ratio_select_parms.b_npi = TRUE
	uo_1.uf_load_dddw('RATIO', iv_invoice_type, 'AC', 'NPI')
ELSE
	st_4.text = "Provider:"
	st_4.accessiblename = "Provider ID"
	st_4.accessibledescription = "Provider ID"
	sle_sel_prov.accessiblename = "Lookup Field - Provider ID"
	sle_sel_prov.accessibledescription = "Lookup Field - Provider ID"
	is_prov = "PROV_ID"
	is_npi = " ' ', "
	isx_ratio_select_parms.b_npi = FALSE
	uo_1.uf_load_dddw('RATIO', iv_invoice_type, 'AC', 'FALSE')
END IF

wf_get_tbl_type()
end event

type sle_sel_ratio3 from singlelineedit within w_ratio_select
boolean visible = false
string accessiblename = "Prov Ratio 3"
string accessibledescription = "Prov Ratio 3"
accessiblerole accessiblerole = textrole!
integer x = 1129
integer y = 1008
integer width = 1477
integer height = 100
integer taborder = 180
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_ratio_select
boolean visible = false
string accessiblename = "Prov Ratio 3"
string accessibledescription = "Prov Ratio 3"
accessiblerole accessiblerole = statictextrole!
integer x = 151
integer y = 1020
integer width = 425
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Prov Ratio 3:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_sel_prov from u_sle within w_ratio_select
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Provider ID"
string accessibledescription = "Lookup Field - Provider ID"
integer x = 1129
integer y = 1008
integer width = 1477
integer height = 100
integer taborder = 190
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
end type

event ue_lookup;call super::ue_lookup;//	04/14/08	GaryR	SPR 4435	Accommodate Ratios by NPI
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508

IF isx_ratio_select_parms.b_npi THEN
	gv_code_to_use = 'NPI'
ELSE
	gv_code_to_use = 'PV'
END IF

open(w_code_lookup)
if gv_code_to_use <> '' Then
	sle_sel_prov.text = gv_code_to_use
end if
end event

type st_4 from statictext within w_ratio_select
string accessiblename = "Provider"
string accessibledescription = "Provider"
accessiblerole accessiblerole = statictextrole!
integer x = 279
integer y = 1032
integer width = 297
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Provider:"
alignment alignment = right!
boolean focusrectangle = false
end type

