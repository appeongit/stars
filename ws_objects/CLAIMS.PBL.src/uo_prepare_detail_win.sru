$PBExportHeader$uo_prepare_detail_win.sru
$PBExportComments$(inherited from n_base) <logic>
forward
global type uo_prepare_detail_win from n_base
end type
end forward

global type uo_prepare_detail_win from n_base
end type
global uo_prepare_detail_win uo_prepare_detail_win

type variables
private string in_tbl_type,in_src_type,in_case_id,in_subset_id
private long in_row,in_cumulitive_win_count
private datawindow in_datawindow_name
private w_parent_details in_detail_windows[]
private string in_key_value
private sx_details_structure in_details_struct
private string in_tbl_type_to_process[]
end variables

forward prototypes
public subroutine fuo_set_tbl_type (string arg_tbl_type)
public function string fuo_get_tbl_type ()
public subroutine fuo_set_row (long arg_row)
public function long fuo_get_row ()
public subroutine fuo_set_datawindow_name (datawindow arg_datawindow_name)
public function datawindow fuo_get_datawindow_name ()
public subroutine fuo_set_detail_windows (w_parent_details arg_detail_windows[])
public subroutine fuo_set_src_type (string arg_src_type)
public function string fuo_get_src_type ()
public subroutine fuo_set_case_id (string arg_case_id)
public function string fuo_get_case_id ()
public subroutine fuo_set_subset_id (string arg_subset_id)
public function string fuo_get_subset_id ()
public subroutine fuo_set_structure (sx_details_structure arg_detail_struct)
public subroutine fuo_set_tbl_types_to_process (string arg_tbl_types_to_process[])
public subroutine fuo_maximize_windows ()
public function integer fuo_switch ()
public subroutine fuo_close_windows (string arg_which_win)
public subroutine fuo_print_windows (string arg_which_win)
public function integer fuo_delete_from_array (window arg_win_to_delete)
public subroutine fuo_reposition_windows (string arg_display_side)
public function long fuo_get_cumulative_win_count ()
public subroutine fuo_set_cumulative_win_count (long arg_cum_win_count)
public function boolean fuo_check_counts (string arg_which_win)
public function integer fuo_fx_load_details (string arg_which_side)
end prototypes

public subroutine fuo_set_tbl_type (string arg_tbl_type);in_tbl_type = arg_tbl_type
end subroutine

public function string fuo_get_tbl_type ();string lv_tbl_type 

lv_tbl_type = in_tbl_type

return lv_tbl_type
end function

public subroutine fuo_set_row (long arg_row);in_row = arg_row


end subroutine

public function long fuo_get_row ();long lv_row

lv_row = in_row

return lv_row
end function

public subroutine fuo_set_datawindow_name (datawindow arg_datawindow_name);in_datawindow_name = arg_datawindow_name
end subroutine

public function datawindow fuo_get_datawindow_name ();datawindow lv_datawindow_name

lv_datawindow_name = in_datawindow_name

return lv_datawindow_name
end function

public subroutine fuo_set_detail_windows (w_parent_details arg_detail_windows[]);arg_detail_windows[] = in_detail_windows[]
end subroutine

public subroutine fuo_set_src_type (string arg_src_type);in_src_type = arg_src_type 
end subroutine

public function string fuo_get_src_type ();string lv_src_type

lv_src_type = in_src_type

return lv_src_type
end function

public subroutine fuo_set_case_id (string arg_case_id);in_case_id = arg_case_id
end subroutine

public function string fuo_get_case_id ();string lv_case_id

lv_case_id = in_case_id

return lv_case_id


end function

public subroutine fuo_set_subset_id (string arg_subset_id);in_subset_id = arg_subset_id
end subroutine

public function string fuo_get_subset_id ();string lv_subset_id

lv_subset_id = in_subset_id

return lv_subset_id
end function

public subroutine fuo_set_structure (sx_details_structure arg_detail_struct);in_details_struct = arg_detail_struct
end subroutine

public subroutine fuo_set_tbl_types_to_process (string arg_tbl_types_to_process[]);in_tbl_type_to_process[] = arg_tbl_types_to_process[]
end subroutine

public subroutine fuo_maximize_windows ();/////////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	10/23/98	FDG	Track 1854.  Fix PB 6.5 error where resize is 
//						getting messed up because this function changes
//						the size of this window AFTER w_parent_details
//						is opened.  This script will invoke the resize service for
//						w_parent_details.
/////////////////////////////////////////////////////////////////////////////////


int lv_counter,lv_upperbound

lv_counter = 1
lv_upperbound = UPPERBOUND(in_detail_windows)				//KMM 10/5/95
do while lv_counter <= lv_upperbound 							//KMM 10/5/95
	in_detail_windows[lv_counter].windowstate = normal!
	in_detail_windows[lv_counter].of_SetResize (TRUE)		// FDG 10/23/98
	lv_counter ++
loop
end subroutine

public function integer fuo_switch ();int lv_x,lv_y,lv_old_x,lv_old_y,lv_counter,lv_start,lv_upperbound
window lv_win_temp,lv_active_sheet
boolean lv_done


lv_upperbound = upperbound(in_detail_windows)

lv_counter = 1
do while lv_counter <= lv_upperbound
	if in_detail_windows[lv_counter] = w_main.getactivesheet() Then
		lv_start = lv_counter	
		lv_x = in_detail_windows[lv_counter].x
		lv_y = in_detail_windows[lv_counter].y
	end if
	lv_counter++
loop

if lv_start = 0 then			//ajs 07-27-98 Track #1370
	return 0						//ajs 07-27-98 Track #1370
end if							//ajs 07-27-98 Track #1370

lv_active_sheet = w_main.getactivesheet()

for lv_counter = lv_start to lv_upperbound 
	if lv_counter + 1 > lv_upperbound Then
		lv_win_temp = lv_active_sheet
	else
		lv_win_temp = in_detail_windows[lv_counter+1]
	end if
	lv_old_x = lv_win_temp.x
	lv_old_y = lv_win_temp.y
	in_detail_windows[lv_counter] = lv_win_temp
	in_detail_windows[lv_counter].move(lv_x,lv_y)
//	in_detail_windows[lv_counter].x = lv_x
//	in_detail_windows[lv_counter].y = lv_y
	lv_x = lv_old_x
	lv_y = lv_old_y
next 


return 0
end function

public subroutine fuo_close_windows (string arg_which_win);integer lv_index
boolean lv_do_close

lv_index = 1
lv_do_close = FALSE

For lv_index = UPPERBOUND(in_detail_windows[]) to 1 step -1		//KMM 10/5/95 Can not make a variable for upperbound, does not work
	if arg_which_win = '>ZERO' THEN
		if integer(in_detail_windows[lv_index].st_count.text) > 0 then 
			lv_do_close = TRUE
		else 
			lv_do_close  = FALSE
		end if
	elseif arg_which_win = '=ZERO' Then
		if integer(in_detail_windows[lv_index].st_count.text) = 0 then 
			lv_do_close = TRUE
		else
			lv_do_close  = FALSE
		end if		
	else
		lv_do_close = TRUE
	end if
	if lv_do_close = TRUE Then
		if isvalid(in_detail_windows[lv_index]) Then
			Close(in_detail_windows[lv_index])
		end if	
	end if
NEXT

end subroutine

public subroutine fuo_print_windows (string arg_which_win);integer lv_index
boolean lv_do_print

lv_index = 1
lv_do_print = FALSE

DO WHILE lv_index <= UPPERBOUND(in_detail_windows[])						//KMM 10/5/95 Can not make a variable for upperbound, does not work
	if arg_which_win = '>ZERO' THEN
		if integer(in_detail_windows[lv_index].st_count.text) > 0 then 
			lv_do_print = TRUE
		else 
			lv_do_print  = FALSE
		end if
	elseif arg_which_win = '=ZERO' Then
		if integer(in_detail_windows[lv_index].st_count.text) = 0 then 
			lv_do_print = TRUE
		else
			lv_do_print  = FALSE
		end if		
	else
		lv_do_print = TRUE
	end if
	if lv_do_print = TRUE Then
		if isvalid(in_detail_windows[lv_index]) Then
			MDI_main_frame.SetMicroHelp('Printing Report')
	  		OpenWithParm(w_dw_print_what_cols,in_detail_windows[lv_index].dw_1)
		end if	
	else
		messagebox('Warning','There is nothing to print for this selection') 
	end if
	lv_index++
loop

end subroutine

public function integer fuo_delete_from_array (window arg_win_to_delete);w_parent_details lv_win_temp[],lv_clear_array[]
int lv_counter,lv_counter2,lv_upperbound
lv_counter2 = 1

lv_upperbound = UPPERBOUND(in_detail_windows)				//KMM 10/5/95
for lv_counter = 1 to lv_upperbound 							//KMM 10/5/95
	if arg_win_to_delete <> in_detail_windows[lv_counter] Then		
		lv_win_temp[lv_counter2]= in_detail_windows[lv_counter]
		lv_counter2++
	end if
Next

in_detail_windows[] = lv_clear_array[]
in_detail_windows[] = lv_win_temp[]
if upperbound(in_detail_windows) <= 0 then
	Close (w_detail_backdrop)
end if
RETURN 0
end function

public subroutine fuo_reposition_windows (string arg_display_side);int lv_common_y,lv_specific_y,lv_index,lv_upperbound

lv_common_y = 1
lv_upperbound = upperbound(in_detail_windows) 				//KMM 10/5/95
for lv_index = 1 to lv_upperbound 								//KMM 10/5/95
	if arg_display_side = 'LEFT' Then
		in_detail_windows[lv_index].x = 1
		in_detail_windows[lv_index].y = lv_common_y
		lv_common_y = lv_common_y + 163
	elseif arg_display_side = 'RIGHT' Then
		in_detail_windows[lv_index].x = 1390
		in_detail_windows[lv_index].y = lv_specific_y
		lv_specific_y = lv_specific_y + 163
	end if
Next
end subroutine

public function long fuo_get_cumulative_win_count ();long lv_cum_win_count

lv_cum_win_count = in_cumulitive_win_count

return  lv_cum_win_count

end function

public subroutine fuo_set_cumulative_win_count (long arg_cum_win_count);in_cumulitive_win_count = arg_cum_win_count
end subroutine

public function boolean fuo_check_counts (string arg_which_win);//Send in your menu choice and it will return if all the windows
//are of that choice.  Then you can make decscions by it.

boolean lv_all_of_one
integer lv_index,lv_upperbound
lv_all_of_one = TRUE
lv_upperbound = UPPERBOUND(in_detail_windows[])					//KMM 10/5/95
For lv_index = lv_upperbound to 1 step -1							//KMM 10/5/95
	if arg_which_win = '>ZERO' Then
		if long(in_detail_windows[lv_index].st_count.text) > 0 Then
			lv_all_of_one = TRUE
		else 
			lv_all_of_one = FALSE
			exit
		end if
	elseif arg_which_win = '=ZERO' Then
		if long(in_detail_windows[lv_index].st_count.text) <= 0 Then
			lv_all_of_one = TRUE
		else 
			lv_all_of_one = FALSE
			exit
		end if
	end if	
next	
return lv_all_of_one
end function

public function integer fuo_fx_load_details (string arg_which_side);//*************************************************************************
// 06/09/98 FNC	Track 1310. Put key value in quotes.
// 06/10/98	FNC	Track 1309. Move data from w_main.dw_stars_rel_dict into
//						local array variables.
// 02/08/00	 FNC	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
// 12/13/00	GaryR	Stars 4.7 DataBase Port - Date Conversion
//	12/14/00	FDG	Stars 4.7.  Make checking of data types DBMS-independent
//	04/11/01	FDG	Stars 4.7.	Get table names from Stars Server
//	07/11/01	GaryR	Track 2359D Add payment date to where clause 
//						to avoid full table scan on partitioned tables.
//*************************************************************************

w_parent_details detail_windows[]
boolean lv_tbl_type_found
datetime lv_narrow_down_value
string lv_case_id,lv_case_id_spl,lv_case_id_ver
string ls_rel_mod[],ls_key1_variable_name[],ls_key2_variable_name[],lv_key2,lv_value,lv_key3
string ls_tbl_type[], ls_tbl_title[]
string lv_error_crit, ls_filter
string ls_where
int lv_counter,rc,lv_specific_x,lv_common_x,lv_common_y,lv_specific_y,lv_counter2
int lv_arg_for_meter, i, li_row
long lv_upperbound, ll_count

lv_tbl_type_found = FALSE
in_details_struct.window_count = upperbound(in_tbl_type_to_process)
SetPointer(hourglass!)

lv_common_y = 1
lv_specific_y = 1
	//This does the actual fetch//

lv_counter = 1

/* filter w_main.dw_stars_rel_dict to get dependent table info */
w_main.dw_stars_rel_dict.setfilter('')
w_main.dw_stars_rel_dict.filter()

ls_filter = Upper("rel_type = 'DP' and rel_id = '" + in_details_struct.tbl_type + "'" )
w_main.dw_stars_rel_dict.setfilter(ls_filter)
w_main.dw_stars_rel_dict.filter()
ll_count = w_main.dw_stars_rel_dict.rowcount()

if ll_count = 0 then
	messagebox("Error","No dependents for the selected invoice type.",StopSign!)
	return -1
end if

// FNC 06/10/98 Start
for li_row = 1 to ll_count
	ls_tbl_type[li_row] = w_main.dw_stars_rel_dict.object.id_2[li_row]
	ls_rel_mod[li_row] = w_main.dw_stars_rel_dict.object.rel_mod[li_row]
	ls_tbl_title[li_row] = w_main.dw_stars_rel_dict.object.dictionary_elem_desc[li_row]
//	ls_key1_variable_name[li_row] = w_main.dw_stars_rel_dict.object.key1[li_row]	
//	ls_key2_variable_name[li_row] = w_main.dw_stars_rel_dict.object.key2[li_row]
next
// FNC 06/10/98 End

// FNC 02/08/00 Take create of where statement out of loop. Use key column info in 
// 				sx_details_structure
// 12/13/00	GaryR/FDG	Stars 4.7 DataBase Port - Begin
If trim(in_details_struct.key1_name) <> '' then
	ls_where = "WHERE " + in_details_struct.key1_name + " = " 
	//Choose Case in_details_struct.key1_data_type
	//	Case 'CHAR', 'VARCHAR', 'VARCHAR2', 'DATA'	//,'DATETIME','SMALLDATETIME'
	//		ls_where = ls_where + "'" + in_details_struct.key1_value + "'"
	//	Case 'TIMESTAMP', 'DATE', 'DATETIME', 'SMALLDATETIME'
	//		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key1_value + "'" )
	//	Case Else
	//		ls_where = ls_where + in_details_struct.key1_value
	//End Choose
	IF	gnv_sql.of_is_character_data_type (in_details_struct.key1_data_type)	THEN
		ls_where = ls_where + "'" + Upper( in_details_struct.key1_value ) + "'"
	ELSEIF gnv_sql.of_is_date_data_type (in_details_struct.key1_data_type)	THEN
		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key1_value + "'" )
	ELSE
		ls_where = ls_where + in_details_struct.key1_value
	END IF
Else
	messagebox('ERROR','Cannot identify key field for details in FUO_FX_Load_Details. Details not available')	
	return -1	
End If

If trim(in_details_struct.key2_name) <> '' then
	ls_where = ls_where + " AND "  + in_details_struct.key2_name + " = "
	// FDG 12/14/00 - Make checking of data types DBMS-independent
	//Choose Case in_details_struct.key2_data_type
	//	Case 'CHAR', 'VARCHAR', 'VARCHAR2', 'DATA'	//,'DATETIME','SMALLDATETIME'
	//		ls_where = ls_where + "'" + in_details_struct.key2_value + "'"
	//	Case 'TIMESTAMP', 'DATE', 'DATETIME', 'SMALLDATETIME'
	//		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key2_value + "'" )
	//	Case Else
	//		ls_where = ls_where + in_details_struct.key2_value
	//End Choose
	IF	gnv_sql.of_is_character_data_type (in_details_struct.key2_data_type)	THEN
		ls_where = ls_where + "'" + Upper( in_details_struct.key2_value ) + "'"
	ELSEIF	gnv_sql.of_is_date_data_type (in_details_struct.key2_data_type)	THEN
		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key2_value + "'" )
	ELSE
		ls_where = ls_where + in_details_struct.key2_value
	END IF
End If

If trim(in_details_struct.key3_name) <> '' then
	ls_where = ls_where + " AND "  + in_details_struct.key3_name + " = "
	// FDG 12/14/00 - Make checking of data types DBMS-independent
	//Choose Case in_details_struct.key3_data_type
	//	Case 'CHAR', 'VARCHAR', 'VARCHAR2', 'DATA'	//,'DATETIME','SMALLDATETIME'
	//		ls_where = ls_where + "'" + in_details_struct.key3_value + "'"
	//	Case 'TIMESTAMP', 'DATE', 'DATETIME', 'SMALLDATETIME'
	//		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key3_value + "'" )
	//	Case Else
	//		ls_where = ls_where + in_details_struct.key3_value
	//End Choose
	IF	gnv_sql.of_is_character_data_type (in_details_struct.key3_data_type)	THEN
		ls_where = ls_where + "'" + Upper( in_details_struct.key3_value ) + "'"
	ELSEIF	gnv_sql.of_is_date_data_type (in_details_struct.key3_data_type)	THEN
		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key3_value + "'" )
	ELSE
		ls_where = ls_where + in_details_struct.key3_value
	END IF
End If

If trim(in_details_struct.key4_name) <> '' then
	ls_where = ls_where + " AND "  + in_details_struct.key4_name + " = "
	// FDG 12/14/00 - Make checking of data types DBMS-independent
	//Choose Case in_details_struct.key4_data_type
	//	Case 'CHAR', 'VARCHAR', 'VARCHAR2', 'DATA'	//,'DATETIME','SMALLDATETIME'
	//		ls_where = ls_where + "'" + in_details_struct.key4_value + "'"
	//	Case 'TIMESTAMP', 'DATE', 'DATETIME', 'SMALLDATETIME'
	//		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key4_value + "'" )
	//	Case Else
	//		ls_where = ls_where + in_details_struct.key4_value
	//End Choose
	IF	gnv_sql.of_is_character_data_type (in_details_struct.key4_data_type)	THEN
		ls_where = ls_where + "'" + Upper( in_details_struct.key4_value ) + "'"
	ELSEIF	gnv_sql.of_is_date_data_type (in_details_struct.key4_data_type)	THEN
		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key4_value + "'" )
	ELSE
		ls_where = ls_where + in_details_struct.key4_value
	END IF
End If

If trim(in_details_struct.key5_name) <> '' then
	ls_where = ls_where + " AND "  + in_details_struct.key5_name + " = "
	// FDG 12/14/00 - Make checking of data types DBMS-independent
	//Choose Case in_details_struct.key5_data_type
	//	Case 'CHAR', 'VARCHAR', 'VARCHAR2', 'DATA'	//,'DATETIME','SMALLDATETIME'
	//		ls_where = ls_where + "'" + in_details_struct.key5_value + "'"
	//	Case 'TIMESTAMP', 'DATE', 'DATETIME', 'SMALLDATETIME'
	//		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key5_value + "'" )
	//	Case Else
	//		ls_where = ls_where + in_details_struct.key5_value
	//End Choose
	IF	gnv_sql.of_is_character_data_type (in_details_struct.key5_data_type)	THEN
		ls_where = ls_where + "'" + Upper( in_details_struct.key5_value ) + "'"
	ELSEIF	gnv_sql.of_is_date_data_type (in_details_struct.key5_data_type)	THEN
		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key5_value + "'" )
	ELSE
		ls_where = ls_where + in_details_struct.key5_value
	END IF
End If

If trim(in_details_struct.key6_name) <> '' then
	ls_where = ls_where + " AND "  + in_details_struct.key6_name + " = "
	// FDG 12/14/00 - Make checking of data types DBMS-independent
	//Choose Case in_details_struct.key6_data_type
	//	Case 'CHAR', 'VARCHAR', 'VARCHAR2', 'DATA'	//,'DATETIME','SMALLDATETIME'
	//		ls_where = ls_where + "'" + in_details_struct.key6_value + "'"
	//	Case 'TIMESTAMP', 'DATE', 'DATETIME', 'SMALLDATETIME'
	//		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key6_value + "'" )
	//	Case Else
	//		ls_where = ls_where + in_details_struct.key6_value
	//End Choose
	IF	gnv_sql.of_is_character_data_type (in_details_struct.key6_data_type)	THEN
		ls_where = ls_where + "'" + Upper( in_details_struct.key6_value ) + "'"
	ELSEIF	gnv_sql.of_is_date_data_type (in_details_struct.key6_data_type)	THEN
		ls_where = ls_where + gnv_sql.of_get_to_date( "'" + in_details_struct.key6_value + "'" )
	ELSE
		ls_where = ls_where + in_details_struct.key6_value
	END IF
End If
// 12/13/00	GaryR	Stars 4.7 DataBase Port - End

//	GaryR		07/11/01		Track 2359D - Begin
If trim(in_details_struct.paid_date_col) <> '' then
	ls_where = ls_where + " AND " + in_details_struct.paid_date_col + " = "
	ls_where = ls_where + gnv_sql.of_get_to_date( in_details_struct.paid_date )	
End If
//	GaryR		07/11/01		Track 2359D - End

in_details_struct.where = ls_where

// FNC 02/08/00 End

for li_row = 1 to ll_count

	lv_upperbound = upperbound(in_tbl_type_to_process)			//KMM 10/5/95
	for lv_counter2 = 1 to lv_upperbound							//KMM 10/5/95
		if in_tbl_type_to_process[lv_counter2] = ls_tbl_type[li_row] Then
			lv_tbl_type_found = TRUE 
			exit
		else
			lv_tbl_type_found = FALSE
		end if
	Next
	if lv_tbl_type_found = FALSE Then 
		continue
	end if
	if UPPER(arg_which_side) = 'LEFT' Then
		if ls_rel_mod[li_row] <> 'C' then continue
	elseif UPPER(arg_which_side) = 'RIGHT' Then
		if ls_rel_mod[li_row] = 'C' then continue
	end if
	in_details_struct.tbl_type = 	ls_tbl_type[li_row]			// FNC 06/10/98
	in_details_struct.title = ls_tbl_title[li_row]				// FNC 06/10/98
// FNC 02/08/00 start Moved before the loop
//		in_details_struct.where = ' WHERE '+ls_tbl_type[li_row]+'.'+ls_key1_variable_name[li_row]+'= "' + &
//					in_details_struct.key_value + '"'					// FNC 06/10/98
//   	If trim(ls_key2_variable_name[li_row]) <> '' Then 
//         in_details_struct.where = in_details_struct.where + ' AND ' + &
//				ls_tbl_type[li_row] + '.' + ls_key2_variable_name[li_row] + ' = ' + &
//						string(in_details_struct.key2_value) 
//      End if 
// FNC 02/08/00 End
		
	if ls_rel_mod[li_row] = 'C' Then
		in_details_struct.side_displayed = 'LEFT'
		in_details_struct.x = 1
		in_details_struct.y = lv_common_y
		in_detail_windows[lv_counter] = w_parent_details
		rc = OpenSheetwithparm(in_detail_windows[lv_counter],in_details_struct,MDI_main_frame,help_menu_position,original!)
		lv_common_y = lv_common_y + 163
	else
		in_details_struct.side_displayed = 'RIGHT'
		in_details_struct.x = 1390
		in_details_struct.y = lv_specific_y
		in_detail_windows[lv_counter] = w_parent_details
		rc = OpenSheetwithparm(in_detail_windows[lv_counter],in_details_struct,MDI_main_frame,help_menu_position,original!)

		lv_specific_y = lv_specific_y + 163
	end if
	lv_arg_for_meter = in_cumulitive_win_count/in_details_struct.window_count * 100
	lv_counter++
	in_cumulitive_win_count++		
next

return 0
end function

on uo_prepare_detail_win.create
call super::create
end on

on uo_prepare_detail_win.destroy
call super::destroy
end on

