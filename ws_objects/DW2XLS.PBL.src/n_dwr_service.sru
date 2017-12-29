$PBExportHeader$n_dwr_service.sru
forward
global type n_dwr_service from n_dwr_service_base
end type
end forward

shared variables

end variables

global type n_dwr_service from n_dwr_service_base
end type
global n_dwr_service n_dwr_service

type variables
//private datawindow idw_dw
private powerobject ipo_requestor
private object ipo_requestortype
private DataWindow idw_requestor
private DataStore ids_requestor
private DataWindowChild idwc_requestor

public int ii_band_count = 0
public long il_cur_writer_row = 0
public boolean ib_show_progress = false
//public w_n_dwr_service_progress iw_progress
public n_dwr_progress ipo_progress
private int ii_analyse_as_rowcount = 10
//private long ii_percent_of_analyse
private constant long ii_percent_of_analyse = 5
private constant long ii_percent_of_stage1 = 70
private constant long ii_percent_of_stage2 = 25

private boolean ib_cancel = false
public boolean ib_modemultisheet = false 
public boolean ib_multisheet = false
public boolean ib_multidw = false
private integer ii_rows_per_detail = 1
public n_dwr_grid invo_global_vgrid

private boolean ib_group_newpage[]
public n_dwr_band invo_bands[]
private boolean ib_enable_merge_cells = true
//public n_xls_workbook invo_writer

//public n_xls_worksheet invo_cur_sheet

//new
public n_dwr_workbook inv_book

//new
public n_dwr_worksheet inv_sheet

public n_dwr_service_parm invo_parm

public n_dwr_nested_service_parm invo_nested_parm

public n_dwr_sub invo_sub

public n_dwr_colors invo_colors

private boolean ib_nested = false
private long il_base_x = 0
private long il_base_y = 0
private long il_RowCount = 0

private string is_object[]
private string is_object_band[]
private long il_object_nested_id[]
private long il_objectcount = -1
private long il_nested_weight = 50

//dwo type
public constant int DT_COLUMN = 1
public constant int DT_COMPUTE = 2
public constant int DT_TEXT = 3
public constant int DT_REPORT = 4

private boolean ib_defer_update_y = false

public integer ii_units = 0

private w_dw2xls_dynref iw_dynref
protected long il_bg_x2 = 0
protected long il_multidw_base_x = 0
protected long il_last_multidw_base_x = 0
protected boolean ib_multidw_progress = false
protected PowerObject ipo_multidw_requestor

protected long il_grid_width = 0
protected boolean ib_grid = false



end variables

forward prototypes
private function integer of_addband (string as_band_name, integer ai_band_type, integer ai_group_level)
private function integer of_addbands ()
private function int of_getband(string AS_BANDNAME, ref n_dwr_band ANVO_BAND)
private function integer of_groupcount ()
public function integer of_process_work ()
public function integer of_process ()
public function integer of_close ()
private function integer of_show_progress (integer ai_progress)
public function integer of_cancel ()
private function int of_set_yield(boolean AB_YIELD_STATUS)
public function boolean of_is_newpage (long al_row)
public function string of_describe (readonly string as_expr)
public function integer of_create (powerobject apo_requestor, n_dwr_workbook anv_book, string as_filename)
public function integer of_create (powerobject apo_requestor, n_dwr_workbook anv_book, string as_filename, n_dwr_service_parm anvo_parm, n_dwr_nested_service_parm anvo_nested_parm)
public function integer of_analyse_dw (integer ai_percent_of_analyse)
public function integer of_register_dynamic (powerobject apo_requestor)
public function integer of_set_col_width ()
public function string of_modify (readonly string as_expr)
public function long of_rowcount ()
private subroutine of_cache_metadata ()
public function long of_describe_expr (string as_expr, long al_row, ref string as_prop_expr)
public function string of_describe_str_expr (string as_expr, long al_row)
private function integer of_splitband (string as_band_name, integer ai_band_type, integer ai_group_level)
private function n_dwr_band of_createband (string as_band_name, integer ai_band_type, integer ai_group_level, long al_subband_y)
public function long of_countnested ()
protected subroutine of_reset_metadata_cache ()
public subroutine of_store_header ()
public function long of_getpagewidthinpbunits ()
public function integer of_export_to_current_sheet (powerobject apo_requestor)
public function integer of_close_progress ()
public function integer of_finish_work ()
public function integer of_create_multidw (n_dwr_workbook anv_book, string as_filename, n_dwr_service_parm anvo_parm)
public function integer of_store_multidw ()
public function integer of_multidw_endln ()
public function long of_get_bg_x2 ()
public function integer of_multidw_add_hspacer (long al_width)
public function integer of_multidw_add_vspacer (long al_height)
public function integer of_process_multidw ()
public function long of_find_grid_detail_width ()
public subroutine of_dispose ()
end prototypes

private function integer of_addband (string as_band_name, integer ai_band_type, integer ai_group_level);return of_splitband(as_band_name, ai_band_type, ai_group_level)
end function

private function integer of_addbands ();integer li_groupcount
integer li_i
integer li_ret = 1
string ls_bands, ls_band_arr[]
integer li_band_cnt
n_dwr_string lnvo_strsrv

li_groupcount = of_groupcount (  )


if ib_grid then
	il_grid_width = of_find_grid_detail_width()
end if
ls_bands = of_describe('datawindow.bands')
li_band_cnt = lnvo_strsrv.of_stringtoarray(ls_bands, '~t', ls_band_arr)

//11.05.2004 move before header
if invo_parm.ib_group_trailer then
    for li_i = li_groupcount to 1 step -1
      of_addband ( 'trailer.' + string ( li_i ) , 4, li_i )
    next
end if

//11.05.2004 move before header
if invo_parm.ib_footer then of_addband ( 'footer', 6, 0 )

for li_i = 1 to li_band_cnt
	if (left((ls_band_arr[li_i]), 6) = 'header') and & 
	   (left((ls_band_arr[li_i]), 7) <> 'header.') then
      if invo_parm.ib_header then of_addband (ls_band_arr[li_i], 1, 0 )
	end if	
next


if invo_parm.ib_group_header then
    for li_i = 1 to li_groupcount
      of_addband ( 'header.' + string ( li_i ) , 2, li_i )
    next
end if

if invo_parm.ib_detail then of_addband ( 'detail', 3, 0 )
if invo_parm.ib_summary then  of_addband ( 'summary', 5, 0 )

//11.05.2004 move before header
//if invo_parm.ib_footer then of_addband ( 'footer', 6, 0 )

for li_i = 1 to ii_band_count
	invo_bands[li_i].of_set_bg_x(il_base_x, il_bg_x2)
next


if ib_show_progress then
   of_set_yield ( true )
end if

return li_ret
end function

private function int of_getband(string AS_BANDNAME, ref n_dwr_band ANVO_BAND);long ll_i

if as_bandname = 'foreground' then
   if not ( invo_parm.ib_foreground )  then return -1
   as_bandname = 'header'
end if

if as_bandname = 'background' then
   if not ( invo_parm.ib_background )  then return -1
   as_bandname = 'header'
end if

for ll_i = 1 to ii_band_count
   if invo_bands [ ll_i ] .is_band_name = as_bandname then
      anvo_band = invo_bands [ ll_i ]
      return 1
   end if
next

return -1
end function

private function integer of_groupcount ();integer li_i
integer li_cnt = 0
string ls_bandname
string ls_syntax
long ll_pos_1, ll_pos_2
string ls_group_syn
boolean lb_newpage
do
  if isNumber ( of_describe ( 'datawindow.header.' + string ( li_cnt + 1 )  + '.Height' )  )  then
     li_cnt ++
  else
     exit
  end if
loop while  true

if li_cnt > 0 then
   ls_syntax = of_Describe('DataWindow.Syntax')
	for li_i = 1 to li_cnt 
		lb_newpage = false
		ll_pos_1 = pos( ls_syntax, 'group(level=' + string( li_i ) ) 
		if ll_pos_1 > 0 then
			ll_pos_2 = pos( ls_syntax, 'by=(', ll_pos_1)
			if ll_pos_2 > 0 then 
				ll_pos_2 = pos( ls_syntax, ')', ll_pos_2 + 3)
				if ll_pos_2 > 0 then 
					ll_pos_2 = pos( ls_syntax, ')', ll_pos_2 + 1)
				end if
			end if
			if ll_pos_2 > 0 then
				ls_group_syn = lower(Mid( ls_syntax, ll_pos_1, ll_pos_2 - ll_pos_1 + 1))
				if pos( ls_group_syn, 'newpage=y') > 0 then
					lb_newpage = true
				end if
			end if
		end if
		ib_group_newpage[li_i] = lb_newpage
	next
end if


return li_cnt


end function

public function integer of_process_work ();long ll_writer_row = 0
long ll_new_writer_rows, ll_obj_written
long ll_dw_row
long ll_dw_row_cnt
integer li_cur_band
integer li_ret = 1
//integer li_percent_of_analyse = 0
//integer li_percent_of_process = 0
//long ll_change_progress_each = 0
//long ll_cur_change_progress = 0
//long ll_progress_row = 0
//long ll_progress_rown = 0
integer li_progress
boolean lb_newpage
long ll_row_y

If ib_nested Then
	of_register_dynamic(invo_nested_parm.ipo_dynamic_requestor)
	ipo_progress = invo_nested_parm.ipo_progress
	ib_defer_update_y = True
End If

il_RowCount = of_RowCount()
ll_dw_row_cnt = il_RowCount + 1

if not ib_nested Then
	if ib_show_progress then
		ipo_progress.il_percent_of_analyse = ii_percent_of_analyse
		if ib_modemultisheet then
			
			ipo_progress.iw_progress.st_title.Text = 'Sheet "' + invo_parm.is_sheet_name + '"'
			
			
			
		end if
	end if
	if ib_show_progress Then
		li_ret = of_analyse_dw (ipo_progress.il_percent_of_analyse)
	else
		li_ret = of_analyse_dw (0)
	end if
	if li_ret <> 1 then return li_ret
	if ib_show_progress Then
		ipo_progress.il_progress_rown = ll_dw_row_cnt + of_CountNested() * il_nested_weight
		ipo_progress.il_percent_of_process = ii_percent_of_stage1
		ipo_progress.il_change_progress_each =  long ( round ( ipo_progress.il_progress_rown/ipo_progress.il_percent_of_process, 0 )  )
		ipo_progress.il_progress_row = 1
	end if
	of_store_header()
else //ib_nested
end if

If ib_multidw Then
	Return 1
End If

ll_dw_row = 1
ll_row_y = il_base_y
do while ll_dw_row <= ll_dw_row_cnt
    lb_newpage = of_is_newpage(ll_dw_row)
	 
    for li_cur_band = 1 to ii_band_count
		  If ib_defer_update_y Then
			  inv_sheet.beginBand(inv_sheet.Handle)
		  End If
		  ll_obj_written = invo_bands [ li_cur_band ] .of_check_process_row ( ll_dw_row, ll_row_y, lb_newpage, ipo_progress)
        if ib_cancel then
           li_ret = -1
           exit
        end if
		  If ib_defer_update_y Then
				If ll_obj_written > 0 Then
					ll_row_y = inv_sheet.endBand(inv_sheet.Handle, ii_units)
				Else
					inv_sheet.endBand(inv_sheet.Handle, ii_units)
				End If
		  Else
			  inv_sheet.updateY(inv_sheet.Handle)
			  ll_row_y = 0
		  End If
    next
    if li_ret <> 1 then exit
    if ib_show_progress then
       ipo_progress.il_cur_change_progress ++
       if ipo_progress.il_cur_change_progress >= ipo_progress.il_change_progress_each then
			 if ib_nested then
				 //all nested rows = il_nested_weight outer rows
          	 li_progress = integer ( round ( (ipo_progress.il_progress_row + ll_dw_row * il_nested_weight / ll_dw_row_cnt) * ipo_progress.il_percent_of_process / ipo_progress.il_progress_rown, 0 )  )
   		 else
          	 li_progress = integer ( round ( ipo_progress.il_progress_row * ipo_progress.il_percent_of_process / ipo_progress.il_progress_rown, 0 )  )
			 end if	  
          of_show_progress (  ipo_progress.il_percent_of_analyse + li_progress  )
          ipo_progress.il_cur_change_progress = 0
       end if
    end if
	 ll_dw_row += ii_rows_per_detail
	 if ib_nested then
	 elseif ib_show_progress then
		 ipo_progress.il_progress_row += ii_rows_per_detail 
	 end if
	 if ii_rows_per_detail > 1 then
		 if (ll_dw_row > ll_dw_row_cnt) and &
		    ((ll_dw_row - ii_rows_per_detail) < ll_dw_row_cnt) then ll_dw_row = ll_dw_row_cnt
	 end if
loop
if not ib_nested And li_ret = 1 then
	of_finish_work()
end if

if ib_show_progress And Not ib_nested then
	of_close_progress()
end if

if ib_nested then
	invo_nested_parm.il_writer_row = ll_writer_row 
	if ib_show_progress then
		ipo_progress.il_progress_row += il_nested_weight
	end if
end if
return li_ret
end function

public function integer of_process ();//	09/25/2009	GaryR	EXP.650.4897.002	If user cancels out return -2 instead of -1.

integer li_ret = 1
if invo_parm.ib_show_progress and (not ib_multidw or ib_multidw_progress) then
   ib_show_progress = true
	ipo_progress = Create n_dwr_progress
	w_n_dwr_service_progress w 
	ipo_progress.iw_progress = w // fix for PB5
   OpenWithParm ( ipo_progress.iw_progress, this)
   if ib_cancel then li_ret = -2
elseif ib_multidw then 
	if ib_multidw_progress then
	   li_ret = of_process_multidw()
	end if
else
   li_ret = of_process_work()
end if

return li_ret
end function

public function integer of_close ();if not isnull(inv_book) and isValid(inv_book) then inv_book.Save(inv_book.handle)
ib_multisheet = false
of_dispose()
return 1
end function

private function integer of_show_progress (integer ai_progress);if ib_show_progress then
   ipo_progress.iw_progress.event ue_show_progress ( ai_progress )
end if

return 1
end function

public function integer of_cancel ();ib_cancel = true
//if not ib_nested then
	//ib_show_progress = false
	//SetNull ( ipo_progress.iw_progress )
	//of_set_yield ( false )
//end if
integer li_i

if ii_band_count > 0 then
    for li_i = 1 to ii_band_count
        invo_bands[li_i].of_cancel()
    next
end if


return 1
end function

private function int of_set_yield(boolean AB_YIELD_STATUS);integer li_i
if ii_band_count > 0 then
    for li_i = 1 to ii_band_count
        invo_bands [ li_i ] .ib_yield_enable = ab_yield_status
    next
end if

return 1
end function

public function boolean of_is_newpage (long al_row);boolean lb_newpage = false
integer li_i

for li_i = 1 to ii_band_count
    if invo_bands[li_i].ii_band_type = 2 then
		 if (al_row = invo_bands[li_i].il_groupchangerow) and  &
		    (al_row > 1) and (invo_bands[li_i].ib_newpage) then
			 lb_newpage = true
       end if
    end if
next

return lb_newpage
end function

public function string of_describe (readonly string as_expr);Choose Case ipo_requestortype 
	Case DataWindow!
		Return idw_requestor.describe(as_expr)
	Case DataStore!
		Return ids_requestor.describe(as_expr)
	Case DataWindowChild!
		Return idwc_requestor.describe(as_expr)
	Case Else
		Return "!"
End Choose   

end function

public function integer of_create (powerobject apo_requestor, n_dwr_workbook anv_book, string as_filename);n_dwr_service_parm lnvo_parm
n_dwr_nested_service_parm lnvo_nested_parm

lnvo_parm = create n_dwr_service_parm

return of_create ( apo_requestor, anv_book, as_filename, lnvo_parm, lnvo_nested_parm)

end function

public function integer of_create (powerobject apo_requestor, n_dwr_workbook anv_book, string as_filename, n_dwr_service_parm anvo_parm, n_dwr_nested_service_parm anvo_nested_parm);integer li_ret = 1
string ls_tmp_dir
boolean lb_null[]
n_dwr_band lnvo_null[]
long ll_error

ipo_requestor = apo_requestor
of_reset_metadata_cache()

if Not ( isNull ( ipo_requestor )  )  then

   if isValid ( ipo_requestor )  then
		ipo_requestortype = ipo_requestor.TypeOf()
		Choose Case ipo_requestortype 
			Case DataWindow!
				idw_requestor = ipo_requestor
			Case DataStore!
				ids_requestor = ipo_requestor
			Case DataWindowChild!
				idwc_requestor = ipo_requestor
			Case Else
				   
				
					 MessageBox ( 'Error', 'Object type is not supported', StopSign! )
				   
				li_ret = -1
		End Choose   
		if li_ret = 1 then
			if of_describe ( 'Datawindow.Syntax' )  = '' then
				    
				 
				 MessageBox ( 'Error', 'Report is empty', StopSign! )
				    
				 li_ret = -1
			end if
		end if
   else
         
      
          MessageBox ( 'Error', 'Report is empty', StopSign! )
         
      li_ret = -1
   end if
else
         
      
          MessageBox ( 'Error', 'Report is empty', StopSign! )
         
  li_ret = -1
end if
If Not IsNull(anvo_nested_parm) Then
	If IsValid(anvo_nested_parm) Then
		ib_nested = true
	End If
End If

if li_ret = 1 then
   integer li_processing  
   li_processing = integer(of_describe ( 'Datawindow.Processing' )) 
   choose case li_processing
      case 0, 8, 9
      case 1
			ib_grid = true
      case 2
             
          
              MessageBox ( 'Error', 'Label presentation style is not supported', StopSign! )
             
          li_ret = -1  
      case 3
             
          
              MessageBox ( 'Error', 'Graph presentation style is not supported', StopSign! )
             
          li_ret = -1  
      case 4
			 of_Modify('DataWindow.Crosstab.StaticMode=Yes') 
             
          
              //MessageBox ( 'Error', 'Crosstab presentation style is not supported', StopSign! )
             
          //li_ret = -1  
      case 5
             
          
          //    MessageBox ( 'Error', 'Composite presentation style is not supported', StopSign! )
             
          //li_ret = -1  
			 
      case else
             
          
              MessageBox ( 'Error', 'This presentation style is not supported', StopSign! )
             
          li_ret = -1  
   end choose     
end if   

if li_ret = 1 And Not ib_nested then
	il_RowCount = of_RowCount()
   if il_RowCount  < 1 And li_processing <> 5  then
         
      
          MessageBox ( 'Error', 'Rows not found', StopSign! )
         
      li_ret = -1
   end if
end if

if li_ret = 1 then
//    idw_dw = adw_dw
   //invo_writer = anvo_writer
	inv_book = anv_book
	//-- 02.09.04
	ii_band_count = 0
	il_cur_writer_row = 0
	ib_show_progress = false
	ii_analyse_as_rowcount = 10
	ib_cancel = false
	ii_rows_per_detail = 1
	ib_group_newpage = lb_null
	invo_bands = lnvo_null
   invo_parm = anvo_parm
	ib_enable_merge_cells = invo_parm.ib_enable_merge_cells
	invo_nested_parm = anvo_nested_parm
	ii_units = integer(of_describe ( 'Datawindow.Units' ))
	invo_sub = create n_dwr_sub
	invo_sub.of_set_cur_units(ii_units) 
	//ls_tmp_dir = invo_sub.of_gettemppath()
	//if ls_tmp_dir <> '' then invo_writer.of_set_temp_dir( ls_tmp_dir ) 
	//--
	if ib_nested then
		invo_global_vgrid = anvo_nested_parm.invo_global_vgrid
		invo_colors = anvo_nested_parm.invo_colors
		//invo_cur_sheet = anvo_nested_parm.invo_cur_sheet
		inv_sheet = anvo_nested_parm.inv_sheet
		
		If IsValid(anvo_nested_parm.ipo_progress) Then
			ib_show_progress = true
		Else
			ib_show_progress = false
		End If
	else
		
		anvo_parm.il_nested_instance_count = 0 
		invo_global_vgrid = create n_dwr_grid
		invo_global_vgrid.ii_round_ratio = invo_global_vgrid.ii_round_init_ratio * invo_sub.of_get_conv_x()
		if not(ib_multisheet) then 
			ll_error = inv_book.of_create(anvo_parm.is_version, as_filename, true)
			if ll_error <> n_dwr_const.S_OK then 
				li_ret = -1
			else
				li_ret = 1
			end if
		end if
		
		if li_ret <> 1 then return li_ret
		
		inv_sheet = inv_book.of_AddWorkSheet(invo_parm.is_sheet_name)
		inv_sheet.SetAlign(inv_sheet.handle, anvo_parm.id_min_width, anvo_parm.id_min_height)
		if not(ib_multisheet) or isNull(invo_colors) or not isValid(invo_colors) then 
			invo_colors = create n_dwr_colors
		end if
	end if	
	
	if ib_modemultisheet then ib_multisheet = true
end if

return li_ret
end function

public function integer of_analyse_dw (integer ai_percent_of_analyse);integer li_ret = 1
n_dwr_string lnvo_str_srv
string ls_objects
string ls_object [  ]
long ll_objectcount
long ll_i
string ls_bandname
n_dwr_band lnvo_band

long ll_change_progress_each = 0
long ll_cur_change_progress = 0
integer li_progress
if ib_nested then
	il_base_x = invo_nested_parm.il_nested_x
	il_base_y = invo_nested_parm.il_nested_y
end if

do
    if ib_show_progress and not ib_nested then of_show_progress ( 0 )

	 ii_rows_per_detail = integer(of_describe ( 'DataWindow.rows_per_detail' ))
	 if (ii_rows_per_detail < 1) or isNull(ii_rows_per_detail) then ii_rows_per_detail = 1

    li_ret = of_addbands (  )
    if li_ret <> 1 then exit
	 if ib_show_progress and not ib_nested then of_show_progress ( ai_percent_of_analyse )
loop until true

ib_defer_update_y = False

return li_ret
end function

public function integer of_register_dynamic (powerobject apo_requestor);ipo_requestor = apo_requestor
ipo_requestortype = ipo_requestor.TypeOf()
Choose Case ipo_requestortype 
	Case DataWindow!
		idw_requestor = ipo_requestor
	Case DataStore!
		ids_requestor = ipo_requestor
	Case DataWindowChild!
		idwc_requestor = ipo_requestor
	Case Else
		Return -1
End Choose   

long li_band
For li_band = 1 To ii_band_count
	invo_bands[li_band].of_register_dynamic(ipo_requestor)
Next
Return 1
end function

public function integer of_set_col_width ();//TODO remove unused

long ll_col_count, ll_i
integer li_ret = 1

//ll_col_count = invo_global_vgrid.of_get_split_count (  )  - 1
//
//for ll_i = 1 to ll_col_count
//   invo_cur_sheet.of_set_column_width ( ll_i - 1, invo_global_vgrid.of_get_col_width(ll_i) / invo_sub.of_get_cur_coef_x())
//next

return li_ret
end function

public function string of_modify (readonly string as_expr);Choose Case ipo_requestortype 
	Case DataWindow!
		Return idw_requestor.Modify(as_expr)
	Case DataStore!
		Return ids_requestor.Modify(as_expr)
	Case DataWindowChild!
		Return idwc_requestor.Modify(as_expr)
	Case Else
		Return "!"
End Choose   

end function

public function long of_rowcount ();Choose Case ipo_requestortype 
	Case DataWindow!
		Return idw_requestor.RowCount()
	Case DataStore!
		Return ids_requestor.RowCount()
	Case DataWindowChild!
		Return idwc_requestor.RowCount()
	Case Else
		Return 0
End Choose   

end function

private subroutine of_cache_metadata ();String ls_objects, ls_object[], ls_bandname, ls_type
Long li_object, li_used_object
n_dwr_string s

If il_objectcount >= 0 Then
	Return
End If

ls_objects = of_describe("DataWindow.Objects")
il_objectcount = s.of_ParseToArray(ls_objects, '~t', ls_object[])
li_used_object = 0
For li_object = 1 to il_objectcount
	ls_bandname = of_describe(ls_object[li_object] + '.band')
	ls_type = of_describe(ls_object[li_object] + '.type')
	If ls_type = "report" Then
		invo_parm.il_nested_instance_count ++
	End If
	If ls_bandname = "foreground" Then
		If Not invo_parm.ib_foreground Then Continue
		ls_bandname = "header"
	End If
	If ls_bandname = "background" Then
		If Not invo_parm.ib_background Then Continue
		ls_bandname = "header"
	End If
	li_used_object ++
	is_object[li_used_object] = ls_object[li_object]
	is_object_band[li_used_object] = ls_bandname
	il_object_nested_id[li_used_object] = invo_parm.il_nested_instance_count

Next

il_objectcount = UpperBound(is_object[])


end subroutine

public function long of_describe_expr (string as_expr, long al_row, ref string as_prop_expr);string ls_val
long ll_pos
n_dwr_string lnvo_str
Choose Case ipo_requestortype //idw_requestor
	Case DataWindow!
		ls_val = idw_requestor.describe(as_expr)
	Case DataStore!
		ls_val = ids_requestor.describe(as_expr)
	Case DataWindowChild!
		ls_val = idwc_requestor.describe(as_expr)
	Case Else
		Return -1
End Choose   

ll_pos = pos(ls_val, '~t')
if ll_pos > 0 then
	ls_val = mid(ls_val, ll_pos + 1, len(ls_val) - ll_pos - 1)
   ls_val = lnvo_str.of_globalreplace(ls_val, "'", "~~~'")
	as_prop_expr = ls_val
   
	Choose Case ipo_requestortype 
		Case DataWindow!
			ls_val = idw_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataStore!
			ls_val = ids_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataWindowChild!
			ls_val = idwc_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case Else
			Return -1
	End Choose   
	if isNumber(ls_val) then return long(ls_val)
else
  as_prop_expr = ""
  if isNumber(ls_val) then return long(ls_val)
end if

return -1
end function

public function string of_describe_str_expr (string as_expr, long al_row);string ls_val
long ll_pos
//n_dwr_string lnvo_str
Choose Case ipo_requestortype //idw_requestor
	Case DataWindow!
		ls_val = idw_requestor.describe(as_expr)
	Case DataStore!
		ls_val = ids_requestor.describe(as_expr)
	Case DataWindowChild!
		ls_val = idwc_requestor.describe(as_expr)
	Case Else
		Return ""
End Choose   

ll_pos = pos(ls_val, '~t')
if ll_pos > 0 then
   ls_val = mid(ls_val, ll_pos + 1, len(ls_val) - ll_pos - 1)
	//
   //ls_val = lnvo_str.of_globalreplace(ls_val, '~~', '~~~~')
   //ls_val = lnvo_str.of_globalreplace(ls_val, '"', '~~~"')
   //ls_val = lnvo_str.of_globalreplace(ls_val, "'", "~~~'")
	Choose Case ipo_requestortype 
		Case DataWindow!
			ls_val = idw_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataStore!
			ls_val = ids_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataWindowChild!
			ls_val = idwc_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case Else
			Return ""
	End Choose   
	return ls_val
else
  return ls_val
end if

end function

private function integer of_splitband (string as_band_name, integer ai_band_type, integer ai_group_level);
Long li_object, li_band_object, li_y, li_band, li_ret
n_dwr_band lnvo_bands[]
n_dwr_field lnvo_field
long li_subband_y

DataStore lds_sort
String ls_expr
n_dwr_band lnvo_band

of_cache_metadata()
If of_describe("datawindow." + as_band_name + ".height.autosize") <> "yes" Then
	If of_describe("datawindow." + as_band_name + ".height") = "0" Then
		Return 1
	End If
End If
lds_sort = Create DataStore
lds_sort.DataObject = "d_dw2xls_object_sort"
li_band_object = 0
For li_object = 1 To il_objectcount
	If is_object_band[li_object] <> as_band_name Then 
		Continue
	End If
	li_band_object ++
	lds_sort.InsertRow(li_band_object)
	lds_sort.SetItem(li_band_object, "index", li_object)
	li_y = of_describe_expr(is_object[li_object] + ".y", 1, ls_expr) // FIXME support objects with .Y1 style coords (e.g. lines)
	lds_sort.SetItem(li_band_object, "sort_key", li_y)
Next
lds_sort.SetSort("sort_key a")
lds_sort.Sort()

li_subband_y = 0
li_band = 1
lnvo_bands[li_band] = of_CreateBand(as_band_name, ai_band_type, ai_group_level, li_subband_y)

li_band_object = 1

Do While li_band_object <= lds_sort.RowCount()
	li_object = lds_sort.GetItemDecimal(li_band_object, "index")
	SetNull(lnvo_field)
	li_ret = lnvo_bands[li_band].of_add_field(is_object[li_object], il_object_nested_id[li_object], lnvo_field)
	Choose Case li_ret
		Case 1 // field was added to band
			// do nothing
		Case -3 // split band
			li_subband_y += lnvo_field.of_get_band_y1()
			lnvo_bands[li_band].ib_newpage = false
			li_band ++
			lnvo_bands[li_band] = of_CreateBand(as_band_name, ai_band_type, ai_group_level, li_subband_y)
			lnvo_field.of_SetSubBandY(li_subband_y)
			li_ret = lnvo_bands[li_band].of_add_field(is_object[li_object], il_object_nested_id[li_object], lnvo_field)
		Case -2 // Y > H
			Exit 
		Case -1 // not supported field or failed nested
			// do nothing
		Case 2 // field was added to another band
			// do nothing
	End Choose
	li_band_object ++
	If Not IsNull(lnvo_field) Then
		il_bg_x2 = Max(il_bg_x2, lnvo_field.of_get_x2())
	End If
Loop
Destroy lds_sort

For li_band = 1 To UpperBound(lnvo_bands[])
	If UpperBound(lnvo_bands[li_band].invo_fields[]) = 0 Then Continue
	ii_band_count ++
	invo_bands[ii_band_count] = lnvo_bands[li_band]
Next

Return 1
end function

private function n_dwr_band of_createband (string as_band_name, integer ai_band_type, integer ai_group_level, long al_subband_y);n_dwr_band lnvo_band
integer li_ret = 1
boolean lb_newpage = false

lnvo_band = create n_dwr_band

do
  lnvo_band.id_x_coef = invo_sub.of_get_cur_coef_x()
  lnvo_band.id_y_coef = invo_sub.of_get_cur_coef_y()
  lnvo_band.id_conv = invo_sub.of_get_conv_x()
  lnvo_band.ii_units = ii_units
  lnvo_band.ib_nested = ib_nested
  lnvo_band.ipo_progress = ipo_progress
  lnvo_band.invo_nested_parm = invo_nested_parm
  lnvo_band.il_grid_detail_width = il_grid_width
  li_ret = lnvo_band.of_register (  ipo_requestor, inv_book, inv_sheet, invo_parm, invo_colors, ii_rows_per_detail, il_base_x, 0, al_subband_y )
 
  if li_ret <> 1 then exit
  
  if ai_group_level > 0 then
	  lb_newpage = ib_group_newpage[ai_group_level]
  end if
  
  li_ret = lnvo_band.of_init (  as_band_name, ai_band_type, ai_group_level, lb_newpage, invo_global_vgrid )

  if li_ret <> 1 then
     exit
  end if
  return lnvo_band
loop until true

SetNull(lnvo_band)
return lnvo_band



end function

public function long of_countnested ();Long li_band, li_bandn, li_field, li_fieldn, li_nestedn = 0
n_dwr_band lnv_band

li_bandn = UpperBound(invo_bands[])

For li_band = 1 To li_bandn
	lnv_band = invo_bands[li_band]
	li_fieldn = UpperBound(lnv_band.invo_fields[])
	For li_field = 1 To li_fieldn
		If lnv_band.invo_fields[li_field].ii_dwo_type = DT_REPORT Then
			li_nestedn ++
		End If
	Next
Next

Return li_nestedn
end function

protected subroutine of_reset_metadata_cache ();String ls_empty[]
Long li_empty[]

is_object[] = ls_empty[]
is_object_band[] = ls_empty[]
il_object_nested_id[] = li_empty[]
il_objectcount = -1

end subroutine

public subroutine of_store_header ();/**
Determines if the XLS header is enabled and then inserts it to XLS
*/

If invo_parm.is_title_text = "" Then
	Return
End If

n_dwr_format lnv_format
ulong ll_color
long ll_format_ix, ll_x1, ll_x2, ll_y1, ll_y2

// prepare cell format
lnv_format = inv_book.of_CreateFormat()

lnv_format.SetNumFormat(lnv_format.handle, "@")  //TODO
lnv_format.SetFontName(lnv_format.handle, invo_parm.is_title_font)
lnv_format.SetFontSize(lnv_format.handle, invo_parm.il_title_font_size)
If invo_parm.ib_title_font_italic Then lnv_format.SetFontItalic(lnv_format.handle, 1)
If invo_parm.ib_title_font_underline Then lnv_format.SetFontUnderline(lnv_format.handle, 1)
If invo_parm.ib_title_font_bold Then lnv_format.setFontWeight(lnv_format.handle, 700)
lnv_format.setHAlign(lnv_format.handle, lnv_format.of_str2alignment(invo_parm.is_title_text_align)) 
lnv_format.setVAlign(lnv_format.handle, n_dwr_const.ALIGN_TOP) 
lnv_format.setWrap(lnv_format.handle, 1) //TODO
lnv_format.setFgColor(lnv_format.handle, invo_parm.il_title_fg_color)
lnv_format.setBgColor(lnv_format.handle, invo_parm.il_title_bg_color)
lnv_format.SetFontCharset(lnv_format.handle, invo_parm.il_title_font_charset)
lnv_format.SetFontFamily(lnv_format.handle, invo_parm.il_title_font_family)

ll_format_ix = inv_book.of_AddFormat(lnv_format)

// determine cell pos and size
Long ll_page_width
ll_page_width = of_GetPageWidthInPbUnits()
Choose Case Lower(invo_parm.is_title_text_align)
	Case "left"
		ll_x1 = 0
	Case "center"
		ll_x1 = (ll_page_width - Min(ll_page_width, invo_parm.il_title_width)) / 2
	Case "right"
		ll_x1 = ll_page_width - Min(ll_page_width, invo_parm.il_title_width)
	Case Else
		ll_x1 = 0
End Choose
ll_y1 = 0
ll_x2 = ll_x1 + invo_parm.il_title_width
ll_y2 = ll_y1 + invo_parm.il_title_height

// write cell
inv_sheet.of_create_cell(&
	ll_x1, &
	ll_x2, &
	ll_y1, &
	ll_y2, &
	invo_parm.is_title_text, &
	ll_format_ix, &
	0 /*ii_units*/ &
	)

// write separator only if it has height set
If invo_parm.il_title_separator_height > 0 Then
	// prepare format
	// use defaults
	lnv_format = inv_book.of_CreateFormat()
	ll_format_ix = inv_book.of_AddFormat(lnv_format)

	// determine separator pos 
	ll_y1 += invo_parm.il_title_height
	ll_y2 = ll_y1 + invo_parm.il_title_separator_height
	// write separator
	inv_sheet.of_create_cell(&
		ll_x1, &
		ll_x2, &
		ll_y1, &
		ll_y2, &
		"", &
		ll_format_ix, &
		0 /*ii_units*/ &
		)
	
End If

// commit XLS data
inv_sheet.updateY(inv_sheet.Handle)

end subroutine

public function long of_getpagewidthinpbunits ();Return 2800 // 3630
end function

public function integer of_export_to_current_sheet (powerobject apo_requestor);int li_ret

ipo_multidw_requestor = apo_requestor
ib_multidw_progress = True
li_ret = of_process()

Return li_ret
end function

public function integer of_close_progress ();if ib_cancel then
	close ( ipo_progress.iw_progress )
else
	of_show_progress ( 100 )
	close ( ipo_progress.iw_progress )
end if
ib_show_progress = false
SetNull ( ipo_progress.iw_progress )
Return 1
end function

public function integer of_finish_work ();int li_progress
long li_celln, li_cell

inv_sheet.updateY(inv_sheet.Handle)
inv_sheet.updateX(inv_sheet.Handle)

li_celln = inv_sheet.getCellCount(inv_sheet.Handle)
if ib_show_progress Then
	ipo_progress.il_progress_rown = li_celln
	ipo_progress.il_percent_of_process = ii_percent_of_stage2
	ipo_progress.il_change_progress_each =  max(1, long ( round ( ipo_progress.il_progress_rown/ipo_progress.il_percent_of_process, 0 )))
	ipo_progress.il_cur_change_progress = 0
	li_cell = 0
	Do While li_cell < li_celln
		inv_sheet.writeCells(inv_sheet.Handle, li_cell, li_cell + ipo_progress.il_change_progress_each, 0, ib_enable_merge_cells)
		li_progress = integer ( round ( li_cell * ipo_progress.il_percent_of_process / ipo_progress.il_progress_rown, 0 )  )
		of_show_progress(ii_percent_of_analyse + ii_percent_of_stage1 + li_progress  )
		ipo_progress.il_cur_change_progress = 0
		li_cell += ipo_progress.il_change_progress_each
	Loop
else
	inv_sheet.writeCells(inv_sheet.Handle, 0, li_celln, 0, ib_enable_merge_cells)
end if

if invo_parm.ib_hide_grid then
	//invo_cur_sheet.of_hide_gridlines(3)
	inv_sheet.setPrintGridLines(inv_sheet.Handle, false)
	inv_sheet.setScreenGridLines(inv_sheet.Handle, false)
end if

// store orientation, 
Choose Case of_describe("DataWindow.Print.Orientation")  
	Case "1" //Landscape
		inv_sheet.of_set_landscape()
	Case "2" //Portrait
		inv_sheet.of_set_portrait()
	Case Else
		//default
End Choose
Return 1
end function

public function integer of_create_multidw (n_dwr_workbook anv_book, string as_filename, n_dwr_service_parm anvo_parm);int li_ret
DataStore lds_dummy
n_dwr_nested_service_parm lnvo_nested_parm 

lds_dummy = Create DataStore
li_ret = lds_dummy.Create( &
"release 5;~r~n&
datawindow(processing=0  )~r~n&
summary(height=0 color=~"536870912~" )~r~n&
footer(height=0 color=~"536870912~" )~r~n&
detail(height=32 color=~"536870912~" )~r~n&
table(column=(type=long updatewhereclause=yes name=a dbname=~"a~" )~r~n&
)~r~n&
data(1) ~r~n&
")

If li_ret = 1 Then
	ib_multidw = true
	li_ret = of_create(lds_dummy, anv_book, as_filename, anvo_parm, lnvo_nested_parm)
End If
If li_ret = 1 Then
	li_ret = of_process()
End If
Return li_ret
end function

public function integer of_store_multidw ();int li_ret
of_multidw_endln()
of_finish_work()
if ib_show_progress then
	of_close_progress()
end if

Return 1
end function

public function integer of_multidw_endln ();inv_sheet.updateY(inv_sheet.Handle)
il_last_multidw_base_x = il_multidw_base_x
il_multidw_base_x = 0
Return 1
end function

public function long of_get_bg_x2 ();Return il_bg_x2
end function

public function integer of_multidw_add_hspacer (long al_width);
il_multidw_base_x += al_width

Return 1
end function

public function integer of_multidw_add_vspacer (long al_height);

n_dwr_format lnv_format
ulong ll_color
long ll_format_ix, ll_x1, ll_x2, ll_y1, ll_y2

of_multidw_endln()

lnv_format = inv_book.of_CreateFormat()
ll_format_ix = inv_book.of_AddFormat(lnv_format)

If il_last_multidw_base_x <= 0 Then
	il_last_multidw_base_x = 100
End If
ll_x1 = 0
ll_x2 = il_last_multidw_base_x
ll_y1 = 0
ll_y2 = ll_y1 + al_height


inv_sheet.of_create_cell(&
	ll_x1, &
	ll_x2, &
	ll_y1, &
	ll_y2, &
	"", &
	ll_format_ix, &
	ii_units &
	)

of_multidw_endln()

Return 1
end function

public function integer of_process_multidw ();int li_ret


n_dwr_nested_service_parm lnvo_nested_parm
n_dwr_service lnvo_nestedservice

lnvo_nested_parm = Create n_dwr_nested_service_parm
lnvo_nested_parm.inv_sheet = inv_sheet
lnvo_nested_parm.invo_colors = invo_colors
lnvo_nested_parm.ipo_progress = ipo_progress
lnvo_nested_parm.il_nested_x = il_multidw_base_x
lnvo_nested_parm.il_nested_y = 0
lnvo_nested_parm.il_writer_row = 1
lnvo_nested_parm.il_parent_row = 1
lnvo_nested_parm.ipo_dynamic_requestor = ipo_multidw_requestor
lnvo_nested_parm.ib_multidw = true
//lnvo_nested_parm.invo_dynamic_hgrid = invo_hgrid

lnvo_nestedservice = Create n_dwr_service

li_ret = lnvo_nestedservice.of_create(ipo_multidw_requestor, inv_book, ":not applicable:", invo_parm, lnvo_nested_parm)
if ib_show_progress then
	ipo_progress.il_percent_of_analyse = ii_percent_of_analyse
	if ib_modemultisheet then
		
		ipo_progress.iw_progress.st_title.Text = 'Sheet "' + invo_parm.is_sheet_name + '"'
		
		
		
	end if
	ipo_progress.il_progress_rown = lnvo_nestedservice.of_RowCount()
	ipo_progress.il_percent_of_process = 100
	ipo_progress.il_change_progress_each =  long ( round ( ipo_progress.il_progress_rown/ipo_progress.il_percent_of_process, 0 )  )
	ipo_progress.il_progress_row = 1
end if

If li_ret = 1 Then
	li_ret = lnvo_nestedservice.of_Analyse_DW(0)
End If
If li_ret = 1 Then
	li_ret = lnvo_nestedservice.of_process_work()
End If
If li_ret = 1 Then
	il_multidw_base_x = lnvo_nestedservice.of_get_bg_x2()
	ii_units = lnvo_nestedservice.ii_units
End If
if ib_show_progress then
	of_close_progress()
end if

Return li_ret
end function

public function long of_find_grid_detail_width ();String ls_expr
Long ll_object, ll_w = 0
of_cache_metadata()
For ll_object = 1 To il_objectcount
	If is_object_band[ll_object] <> "detail" Then Continue
	If of_describe(is_object[ll_object] + '.id') = "!" Then Continue // skip non columns
	If of_describe(is_object[ll_object] + '.visible') = "0" Then Continue
	If of_describe(is_object[ll_object] + '.width') = "0" Then Continue
	ll_w = Max(ll_w, of_describe_expr(is_object[ll_object] + ".x", 1, ls_expr) + of_describe_expr(is_object[ll_object] + ".width", 1, ls_expr))
Next

Return ll_w
end function

public subroutine of_dispose ();
// force GC to destroy objects with mutual referrences

long ll_i
For ll_i = 1 to UpperBound(invo_bands[])
  	If IsValid(invo_bands[ll_i]) Then
		invo_bands[ll_i].of_dispose()
	End If
Next
n_dwr_band e[]
invo_bands[] = e[]

end subroutine

event ue_process_work;If ib_multidw Then
	of_process_multidw()
Else
	of_process_work()
End If
end event

event ue_cancel;of_cancel()
end event

on n_dwr_service.create
call super::create
end on

on n_dwr_service.destroy
call super::destroy
end on

