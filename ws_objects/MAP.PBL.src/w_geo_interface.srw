$PBExportHeader$w_geo_interface.srw
$PBExportComments$Inherited from w_master
forward
global type w_geo_interface from w_master
end type
type st_5 from statictext within w_geo_interface
end type
type st_1 from statictext within w_geo_interface
end type
type cb_map_it from u_cb within w_geo_interface
end type
type dw_provider_dbf from u_dw within w_geo_interface
end type
type rb_highlighting from radiobutton within w_geo_interface
end type
type cb_close from u_cb within w_geo_interface
end type
type em_1 from editmask within w_geo_interface
end type
type st_4 from statictext within w_geo_interface
end type
type rb_enrol_least from radiobutton within w_geo_interface
end type
type rb_enrol_most from radiobutton within w_geo_interface
end type
type rb_prov_least from radiobutton within w_geo_interface
end type
type rb_prov_most from radiobutton within w_geo_interface
end type
type rb_enrol_all from radiobutton within w_geo_interface
end type
type rb_enrol_selected from radiobutton within w_geo_interface
end type
type rb_prov_all from radiobutton within w_geo_interface
end type
type rb_prov_selected from radiobutton within w_geo_interface
end type
type dw_control from u_dw within w_geo_interface
end type
type ddlb_2 from dropdownlistbox within w_geo_interface
end type
type ddlb_1 from dropdownlistbox within w_geo_interface
end type
type dw_enrollee_dbf from u_dw within w_geo_interface
end type
type rb_none_enrollee from radiobutton within w_geo_interface
end type
type rb_none_provider from radiobutton within w_geo_interface
end type
type st_10 from statictext within w_geo_interface
end type
type dw_enrollee from u_dw within w_geo_interface
end type
type dw_provider from u_dw within w_geo_interface
end type
type st_3 from statictext within w_geo_interface
end type
type st_2 from statictext within w_geo_interface
end type
type rb_both_provider from radiobutton within w_geo_interface
end type
type rb_county_provider from radiobutton within w_geo_interface
end type
type rb_state_provider from radiobutton within w_geo_interface
end type
type st_by_what from statictext within w_geo_interface
end type
type rb_both_enrollee from radiobutton within w_geo_interface
end type
type rb_county_enrollee from radiobutton within w_geo_interface
end type
type rb_state_enrollee from radiobutton within w_geo_interface
end type
type cb_save from u_cb within w_geo_interface
end type
type cb_reset from u_cb within w_geo_interface
end type
type gb_3 from groupbox within w_geo_interface
end type
type gb_1 from groupbox within w_geo_interface
end type
type gb_2 from groupbox within w_geo_interface
end type
type gb_5 from groupbox within w_geo_interface
end type
type gb_4 from groupbox within w_geo_interface
end type
end forward

global type w_geo_interface from w_master
string accessiblename = "Geographic"
string accessibledescription = "Geographic"
integer x = 18
integer y = 24
integer width = 2738
integer height = 1696
string title = "Geographic"
st_5 st_5
st_1 st_1
cb_map_it cb_map_it
dw_provider_dbf dw_provider_dbf
rb_highlighting rb_highlighting
cb_close cb_close
em_1 em_1
st_4 st_4
rb_enrol_least rb_enrol_least
rb_enrol_most rb_enrol_most
rb_prov_least rb_prov_least
rb_prov_most rb_prov_most
rb_enrol_all rb_enrol_all
rb_enrol_selected rb_enrol_selected
rb_prov_all rb_prov_all
rb_prov_selected rb_prov_selected
dw_control dw_control
ddlb_2 ddlb_2
ddlb_1 ddlb_1
dw_enrollee_dbf dw_enrollee_dbf
rb_none_enrollee rb_none_enrollee
rb_none_provider rb_none_provider
st_10 st_10
dw_enrollee dw_enrollee
dw_provider dw_provider
st_3 st_3
st_2 st_2
rb_both_provider rb_both_provider
rb_county_provider rb_county_provider
rb_state_provider rb_state_provider
st_by_what st_by_what
rb_both_enrollee rb_both_enrollee
rb_county_enrollee rb_county_enrollee
rb_state_enrollee rb_state_enrollee
cb_save cb_save
cb_reset cb_reset
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
gb_5 gb_5
gb_4 gb_4
end type
global w_geo_interface w_geo_interface

type variables
integer iv_symbol_number, iv_num_cols, iv_counties_flag
integer iv_dflt_counter, iv_seq_num
long  iv_from_num, iv_to_num
integer iv_dflt_size,  iv_dflt_symb
integer iv_top_num, iv_bottom_num
integer iv_array_count, iv_prov_col, iv_enrol_col
integer iv_hold_col_num
datawindow iv_current_dw, iv_dw_map
string iv_column_text, iv_column, iv_prov_level_flag
string iv_enrol_level_flag, iv_number_counties
string iv_dflt_color, iv_prov_flag, iv_enrol_flag
string iv_user_id, iv_cntl_id, iv_map_array[50,4]
string iv_col_type, iv_temp_from_num, iv_temp
boolean iv_prov_in_dw, iv_enrol_in_dw 
long iv_num_of_rows, iv_recs_not_found
sx_map_struct iv_map_struct
boolean iv_prov_parm, iv_enrol_parm
end variables

forward prototypes
public function integer wf_range_overlap ()
public function integer wf_set_flags ()
public function integer wf_fill_dw ()
public function integer wf_retrieve_dflt (string retrieve_user_id, string retrieve_cntl_id, integer retrieve_window)
public function integer wf_retrieve_enrol_dflt (string retrieve_user_id, string retrieve_cntl_id, integer retrieve_window)
public function integer wf_pin_or_upin ()
end prototypes

public function integer wf_range_overlap ();integer lv_count, lv_symbol, lv_size
long  temp_to_range, temp_from_num

setpointer(hourglass!)

//CHECKS FOR OVERLAPPING RANGES
For lv_count = 1 to 4 
	iv_temp_from_num = "from_range_" + string(lv_count+1)
	temp_from_num = dw_provider.GetItemDecimal(1,"from_range_" + string(lv_count+1))
	temp_to_range = dw_provider.GetItemDecimal(1,"to_range_" + string(lv_count))
	If Not(temp_from_num = 0 AND temp_to_range = 0) then

		If (temp_from_num <= temp_to_range AND temp_from_num <> 0) then
			return -1
		End if

	End If
Next

For lv_count = 1 to 4 
	iv_temp_from_num = "from_range_" + string(lv_count+1)
	temp_from_num = dw_enrollee.GetItemDecimal(1,"from_range_" + string(lv_count+1))
	temp_to_range = dw_enrollee.GetItemDecimal(1,"to_range_" + string(lv_count))
	If Not(temp_from_num = 0 AND temp_to_range = 0) then
			
		If (temp_from_num <= temp_to_range AND temp_from_num <> 0) then 
			return -2
		End if

	End If
Next

//Validation check for symbol and size
For lv_count = 1 to 5 
	temp_from_num = dw_provider.GetItemDecimal(1,"from_range_" + string(lv_count))
	temp_to_range = dw_provider.GetItemDecimal(1,"to_range_" + string(lv_count))
	If Not(temp_from_num = 0 AND temp_to_range = 0) then
		iv_temp = "symbol_"+string(lv_count)
		lv_symbol = dw_provider.getitemnumber(1,"symbol_" + string(lv_count))
		if Not (lv_symbol >= 32 and lv_symbol <= 66) then
			return -3
		end if
		iv_temp = "size_"+string(lv_count)
		lv_size = dw_provider.getitemnumber(1,"size_" + string(lv_count))
		if Not (lv_size >= 1 and lv_size <= 48) then
			return -4
		end if	
	end if
	

	temp_from_num = dw_enrollee.GetItemDecimal(1,"from_range_" + string(lv_count))
	temp_to_range = dw_enrollee.GetItemDecimal(1,"to_range_" + string(lv_count))
	If Not(temp_from_num = 0 AND temp_to_range = 0) then
		iv_temp = "symbol_"+string(lv_count)
		lv_symbol = dw_enrollee.getitemnumber(1,"symbol_" + string(lv_count))
		if Not (lv_symbol >= 32 and lv_symbol <= 66) then
			return -5
		end if
		iv_temp = "size_"+string(lv_count)
		lv_size = dw_enrollee.getitemnumber(1,"size_" + string(lv_count))
		if Not (lv_size >= 1 and lv_size <= 48) then
			return -6
		end if
	end if
Next



Return 0
end function

public function integer wf_set_flags ();//Highlight Counties Flag
setpointer(hourglass!)

iv_counties_flag = 0
iv_prov_level_flag = "N"
iv_enrol_level_flag = "N"
iv_prov_flag = "0"
iv_enrol_flag = "0"

if  rb_prov_most.checked then  
	iv_counties_flag = 1
elseif rb_prov_least.checked then
	iv_counties_flag = 2
elseif rb_enrol_most.checked then
	iv_counties_flag = 3
elseif rb_enrol_least.checked then
	iv_counties_flag = 4
else
	iv_counties_flag = 0
end if

If (iv_counties_flag=1 OR iv_counties_flag=2 OR   &
    iv_counties_flag=3 OR iv_counties_flag=4) AND &
	(em_1.text="") Then  
	iv_number_counties = "1"
ElseIf (iv_counties_flag = 0) Then
	iv_number_counties = "0"
Else
	iv_number_counties = em_1.text
End If

//Provider Map at Level Flag
if rb_state_provider.checked then
	iv_prov_level_flag = "1"
elseif rb_both_provider.checked then
	iv_prov_level_flag = "B"
elseif rb_county_provider.checked then 
	iv_prov_level_flag = "2"
else
	iv_prov_level_flag = "N" 
end if

//Enrollee Map at Level Flag
if rb_state_enrollee.checked then
	iv_enrol_level_flag = "1"
elseif rb_both_enrollee.checked then
	iv_enrol_level_flag = "B"
elseif rb_county_enrollee.checked then 
	iv_enrol_level_flag = "2"
else
	iv_enrol_level_flag = "N" 
end if

//Provider Set Flag
if rb_prov_selected.checked then
	iv_prov_flag = "Y"
elseif rb_prov_all.checked then
	iv_prov_flag = "N"
else 
	iv_prov_flag = "0"
end if

//Enrollee Set Flag
if rb_enrol_selected.checked then
	iv_enrol_flag = "Y"
elseif rb_enrol_all.checked then
	iv_enrol_flag = "N"
else 
	iv_enrol_flag = "0"
end if

return 0
end function

public function integer wf_fill_dw ();integer lv_counter,  temp_symbol, temp_size
integer lv_increment, lv_rows_empty 
long    lv_temp_from_range, lv_temp_to_range
string  lv_temp_color

setpointer(hourglass!)

lv_increment = 0
lv_rows_empty = 0
If iv_prov_flag = 'Y' then
 FOR lv_counter = 1 to 5	
	lv_temp_from_range = dw_provider.GetItemDecimal(1,"from_range_" + string(lv_counter))
	lv_temp_to_range = dw_provider.GetItemDecimal(1,"to_range_" + string(lv_counter))
	
	If Not(lv_temp_from_range = 0 AND lv_temp_to_range = 0)  then	
		temp_symbol = dw_provider.GetitemNumber(1,"symbol_" + string(lv_counter)) 
		temp_size = dw_provider.GetItemNumber(1,"size_" + string(lv_counter))

		If IsNull(temp_size) OR temp_size = 0 then
			temp_size = 7
		End If

		lv_temp_color = dw_provider.GetItemString(1,"color_" + string(lv_counter))
		CHOOSE CASE lv_temp_color
			CASE '16711680'
				lv_temp_color = '255'
			CASE '32896'
				lv_temp_color = '8421376'
			CASE '16776960'	
				lv_temp_color = '65535'
			CASE '8388608'	
				lv_temp_color = '128'
			CASE '8421376'
				lv_temp_color = '32896'
			CASE '255'
				lv_temp_color = '16711680'
			CASE '65535'
				lv_temp_color = '16776960'
			CASE '128'
				lv_temp_color = '8388608'
			CASE ELSE
 				lv_temp_color = lv_temp_color
		END CHOOSE

		lv_increment = lv_increment + 1

		If dw_control.SetItem(1,"fromnum"+string(lv_increment),  &
			lv_temp_from_range) = -1 then
			messagebox('Error','Unable to insert from_range into control.dbf')
			return -1
		End If 
		If dw_control.SetItem(1,"tonum"+string(lv_increment),  &
			lv_temp_to_range) = -1 then
			messagebox('Error','Unable to insert to_range into control.dbf')
			return -1
		End If 


		If dw_control.SetItem(1,"symbol"+string(lv_increment), temp_symbol)  = -1 then
			messagebox('Error','Unable to insert symbol into control.dbf')
			return -1
		End If 
	
		If dw_control.SetItem(1,"size"+string(lv_increment), temp_size)  = -1 then
			messagebox('Error','Unable to insert size into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(1,"color"+string(lv_increment), long(lv_temp_color))  = -1 then
			messagebox('Error','Unable to insert color into control.dbf')
			return -1
		End If

		If dw_control.SetItem(4,"fromnum"+string(lv_increment),  &
			lv_temp_from_range) = -1 then
			messagebox('Error','Unable to insert from_range into control.dbf')
			return -1
		End If 
		If dw_control.SetItem(4,"tonum"+string(lv_increment),  &
			lv_temp_to_range) = -1 then
			messagebox('Error','Unable to insert to_range into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(4,"symbol"+string(lv_increment), temp_symbol)  = -1 then
			messagebox('Error','Unable to insert symbol into control.dbf')
			return -1
		End If 
	
		If dw_control.SetItem(4,"size"+string(lv_increment), temp_size)  = -1 then
			messagebox('Error','Unable to insert size into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(4,"color"+string(lv_increment), long(lv_temp_color))  = -1 then
			messagebox('Error','Unable to insert color into control.dbf')
			return -1
		End If

	Else 
		lv_rows_empty = lv_rows_empty + 1
	End If 
 NEXT
Else 
	lv_rows_empty = 5
End If

//Places zero in symbol column of empty legend rows
If lv_rows_empty > 0 then
	lv_rows_empty = lv_rows_empty - 1
	For lv_counter = 5 to 5 - lv_rows_empty  step -1
		dw_control.SetItem(1,"symbol"+string(lv_counter),0)
      dw_control.SetItem(4,"symbol"+string(lv_counter),0)
	Next
End If

lv_increment = 0
lv_rows_empty = 0

If iv_enrol_flag = 'Y' then
 FOR lv_counter = 1 to 5	
	lv_temp_from_range = dw_enrollee.GetItemDecimal(1,"from_range_" + string(lv_counter))
	lv_temp_to_range = dw_enrollee.GetItemDecimal(1,"to_range_" + string(lv_counter))
		
	If Not(lv_temp_from_range = 0 AND lv_temp_to_range = 0) then
				temp_symbol = dw_enrollee.GetitemNumber(1,"symbol_" + string(lv_counter)) 
		temp_size = dw_enrollee.GetItemNumber(1,"size_" + string(lv_counter))
	
		If IsNull(temp_size) OR temp_size = 0 then
			temp_size = 7
		End If
		
		lv_temp_color = dw_enrollee.GetItemString(1,"color_" + string(lv_counter))
		CHOOSE CASE lv_temp_color
			CASE '16711680'
				lv_temp_color = '255'
			CASE '32896'
				lv_temp_color = '8421376'
			CASE '16776960'	
				lv_temp_color = '65535'
			CASE '8388608'	
				lv_temp_color = '128'
			CASE '8421376'
				lv_temp_color = '32896'
			CASE '255'
				lv_temp_color = '16711680'
			CASE '65535'
				lv_temp_color = '16776960'
			CASE '128'
				lv_temp_color = '8388608'
			CASE ELSE
 				lv_temp_color = lv_temp_color
		END CHOOSE

		lv_increment = lv_increment + 1

		If dw_control.SetItem(2,"fromnum"+string(lv_increment),  &
			lv_temp_from_range) = -1 then
			messagebox('Error','Unable to insert from_range into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(2,"tonum"+string(lv_increment),  &
			lv_temp_to_range)  = -1 then
			messagebox('Error','Unable to insert symbol into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(2,"symbol"+string(lv_increment), temp_symbol) = -1 then
			messagebox('Error','Unable to insert symbol into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(2,"size"+string(lv_increment), temp_size) = -1 then
			messagebox('Error','Unable to insert size into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(2,"color"+string(lv_increment), long(lv_temp_color)) = -1 then
			messagebox('Error','Unable to insert color into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(5,"fromnum"+string(lv_increment),  &
			lv_temp_from_range) = -1 then
			messagebox('Error','Unable to insert from_range into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(5,"tonum"+string(lv_increment),  &
			lv_temp_to_range)  = -1 then
			messagebox('Error','Unable to insert symbol into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(5,"symbol"+string(lv_increment), temp_symbol) = -1 then
			messagebox('Error','Unable to insert symbol into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(5,"size"+string(lv_increment), temp_size) = -1 then
			messagebox('Error','Unable to insert size into control.dbf')
			return -1
		End If 

		If dw_control.SetItem(5,"color"+string(lv_increment), long(lv_temp_color)) = -1 then
			messagebox('Error','Unable to insert color into control.dbf')
			return -1
		End If 

	Else 
		lv_rows_empty = lv_rows_empty + 1
	End If
 NEXT
Else 
	lv_rows_empty = 5
End If


//Places zero in symbol column of empty legend rows
If lv_rows_empty > 0 then
	lv_rows_empty = lv_rows_empty - 1
	For lv_counter = 5 to 5 - lv_rows_empty step -1
		dw_control.SetItem(2,"symbol"+string(lv_counter),0)
		dw_control.SetItem(5,"symbol"+string(lv_counter),0)
	Next
End If

Return 0

end function

public function integer wf_retrieve_dflt (string retrieve_user_id, string retrieve_cntl_id, integer retrieve_window);// this function uses the values in in_cntl_id and in_user_id to retrieve the
// appropriate values from the Geo default table. The values are placed into
// the Provider datawindow.
integer rc, lv_rc
string lv_from, lv_to
 iv_dflt_counter = 0

setpointer(hourglass!)

 DECLARE c1 CURSOR FOR  
  SELECT GEO_DFLT.SEQ_NUM,   
         GEO_DFLT.FROM_NUM,   
         GEO_DFLT.TO_NUM,   
         GEO_DFLT.DFLT_SIZE,   
         GEO_DFLT.DFLT_COLOR,   
         GEO_DFLT.DFLT_SYMB   
    FROM GEO_DFLT  
   WHERE ( GEO_DFLT.USER_ID = Upper( :retrieve_user_id ) ) AND  
         ( GEO_DFLT.CNTL_ID = Upper( :retrieve_cntl_id ) ) AND
			( GEO_DFLT.GEO_TYPE = 'P' ) 
   USING stars2ca ;
if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error preparing to read the Geo Default Table')
	return (-1)
end if

open c1;

if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error opening the Geo Default Table')
	return (-1)
end if

do while stars2ca.sqlcode = 0 
   fetch c1 into :iv_seq_num, 
                 :iv_from_num,
                 :iv_to_num,
                 :iv_dflt_size,
                 :iv_dflt_color,
                 :iv_dflt_symb;
   if stars2ca.of_check_status() = 100 then exit
	if stars2ca.sqlcode <> 0 Then
		close c1;
		if stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error closing the Code Table during a Reading Error')
			return (-1)
		end if
		errorbox(stars2ca,'Error reading the Code Table')
		return (-1)
	end if
   
   if retrieve_window = 1 then        //Variable passed to function (1=Provider)
		iv_dflt_counter = iv_dflt_counter + 1
	 	lv_rc = dw_provider.SetItem(1, "from_range_"+String(iv_dflt_counter), iv_from_num)
 	   lv_rc = dw_provider.SetItem(1, "to_range_"+String(iv_dflt_counter), iv_to_num)
	   lv_rc = dw_provider.SetItem(1, "color_"+String(iv_dflt_counter), iv_dflt_color)
	   lv_rc = dw_provider.SetItem(1, "size_"+String(iv_dflt_counter), iv_dflt_size)
	   lv_rc = dw_provider.SetItem(1, "symbol_"+String(iv_dflt_counter), iv_dflt_symb)
			dw_provider.Modify("color_"+String(iv_dflt_counter)+".color="+"0")
		
		if iv_from_num =  0 and iv_to_num = 0 then	
			dw_provider.Modify("color_"+string(iv_dflt_counter)+".color="+"0")				
		end if																									

	end if 
loop

close c1;

return(0)
end function

public function integer wf_retrieve_enrol_dflt (string retrieve_user_id, string retrieve_cntl_id, integer retrieve_window);//// this function uses the values in in_cntl_id and in_user_id to retrieve the
// appropriate values from the Geo default table. The values are placed into
// the Provider datawindow.
integer rc, lv_rc
string lv_from, lv_to
 iv_dflt_counter = 0

setpointer(hourglass!)

 DECLARE c1 CURSOR FOR  
  SELECT GEO_DFLT.SEQ_NUM,   
         GEO_DFLT.FROM_NUM,   
         GEO_DFLT.TO_NUM,   
         GEO_DFLT.DFLT_SIZE,   
         GEO_DFLT.DFLT_COLOR,   
         GEO_DFLT.DFLT_SYMB   
    FROM GEO_DFLT  
   WHERE ( GEO_DFLT.USER_ID = Upper( :retrieve_user_id ) ) AND  
         ( GEO_DFLT.CNTL_ID = Upper( :retrieve_cntl_id ) ) AND
         ( GEO_DFLT.GEO_TYPE = 'E') 
   USING stars2ca ;
if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error preparing to read the Geo Default Table')
	return (-1)
end if

open c1;

if stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error opening the Geo Default Table')
	return (-1)
end if

do while stars2ca.sqlcode = 0 
   fetch c1 into :iv_seq_num, 
                 :iv_from_num,
                 :iv_to_num,
                 :iv_dflt_size,
                 :iv_dflt_color,
                 :iv_dflt_symb;
   if stars2ca.of_check_status() = 100 then exit
	if stars2ca.sqlcode <> 0 Then
		close c1;
		if stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error closing the Code Table during a Reading Error')
			return (-1)
		end if
		errorbox(stars2ca,'Error reading the Code Table')
		return (-1)
	end if

	iv_dflt_counter = iv_dflt_counter + 1
   	lv_rc = dw_enrollee.SetItem(1, "from_range_"+String(iv_dflt_counter), iv_from_num)
 	   lv_rc = dw_enrollee.SetItem(1, "to_range_"+String(iv_dflt_counter), iv_to_num)
	   lv_rc = dw_enrollee.SetItem(1, "color_"+String(iv_dflt_counter), iv_dflt_color)
	   lv_rc = dw_enrollee.SetItem(1, "size_"+String(iv_dflt_counter), iv_dflt_size)
	   lv_rc = dw_enrollee.SetItem(1, "symbol_"+String(iv_dflt_counter), iv_dflt_symb)
			dw_enrollee.Modify("color_"+String(iv_dflt_counter)+".color="+"0")
	
		if iv_from_num = 0 and iv_to_num = 0 then
			dw_enrollee.Modify("color_"+string(iv_dflt_counter)+".color="+"0")
		end if

loop

close c1;
return 0 
end function

public function integer wf_pin_or_upin ();long lv_count, lv_row 
integer lv_rc
boolean lv_pin, lv_upin, lv_message_flag
string lv_prov_id, lv_prov_pin, lv_prov_upin, lv_datastring
string lv_prov_name, lv_prov_address1, lv_prov_address2
string lv_prov_city, lv_prov_state, lv_prov_zip
real lv_prov_geo_x, lv_prov_geo_y
long lv_datavalue 
 
lv_pin = False
lv_upin = False
lv_row = 0
iv_recs_not_found = 0

setpointer(hourglass!)

//For future use with ratio reports
//sqlcmd('Connect',stars2ca,'Error connecting to Stars2ca',3)     PLB 10/20/95

For lv_count = 1 to iv_num_of_rows
	lv_prov_id = iv_dw_map.getitemstring(lv_count,iv_prov_col)

	Select Prov_Name, Prov_Address1, Prov_Address2, Prov_City,
			 Prov_State, Prov_Zip, Geo_X, Geo_Y
	Into	:lv_prov_name, :lv_prov_address1, :lv_prov_address2,
			:lv_prov_city, :lv_prov_state, :lv_prov_zip, 
			:lv_prov_geo_x, :lv_prov_geo_y
	From Providers
	Where PROV_ID = Upper( :lv_prov_id )
	Using Stars2ca;  			

	If Stars2ca.of_check_status() = 100 then     //not found by Pin
		Select Prov_Name, Prov_Address1, Prov_Address2, Prov_City,
			 	 Prov_State, Prov_Zip, Geo_X, Geo_Y
		Into	:lv_prov_name, :lv_prov_address1, :lv_prov_address2,
				:lv_prov_city, :lv_prov_state, :lv_prov_zip, 
				:lv_prov_geo_x, :lv_prov_geo_y
		From Providers
		Where PROV_UPIN = Upper( :lv_prov_id )
		Using Stars2ca;
  			
		If Stars2ca.of_check_status() = 100 then //not found by Upin
			iv_recs_not_found = iv_recs_not_found + 1
		Elseif Stars2ca.sqlcode = 0 then
			lv_upin = True	
			lv_pin = False
		Else
			errorbox(Stars2ca,'Error Reading Providers Table')
			return -1
		End If
		
	ElseIf Stars2ca.sqlcode = 0 Then
		lv_pin = True
		lv_upin = False	
	Else
		errorbox(Stars2ca,'Error Reading Providers Table')
		return -1
	End If


	if settransobject(dw_provider_dbf,stars2ca) < 1 then
		messagebox('Error','Unable to set transaction object for provider')
		return -1
	end if

//	IF (rb_pin.checked = True AND lv_pin = True) OR &
//		(rb_upin.checked = True AND lv_upin = True)  then
	lv_row = dw_provider_dbf.InsertRow(0)   //inserts row into invisible dw
	lv_rc = dw_provider_dbf.SetItem(lv_row,"prov_id",lv_prov_id) 	

	//RETRIEVES GRAPHDATA FROM STARS DW
		If iv_col_type = "number" OR match(iv_col_type, "decimal") then
			lv_datavalue = iv_dw_map.getitemnumber(lv_count,iv_hold_col_num)
 			lv_rc = dw_provider_dbf.SetItem(lv_row,"graphdata",lv_datavalue) 	 				
		else     //GETS STRING GRAPHDATA
			lv_datastring = iv_dw_map.getitemstring(lv_count,iv_hold_col_num)
    
    	   //CHECKS IF GRAPHDATA IS NUMERIC 
			if IsNumber(lv_datastring) then
				lv_rc = dw_provider_dbf.SetItem(lv_row,"graphdata",long(lv_datastring)) 			 							 				
			else
				if lv_message_flag = False then
			 		messagebox('NON-NUMERIC PROVIDER FIELD ENTRY', 'Choose OK to change all non-numeric ' & 
					+'entries to zero and continue.',Question!,OKCancel!,1)
					lv_message_flag = True
					if lv_rc = 2 then
						return -1
					end if
					lv_rc = dw_provider_dbf.SetItem(lv_row,"graphdata",0) 			 							 					
				else
					lv_rc = dw_provider_dbf.SetItem(lv_row,"graphdata",0) 	 			 				
				end if
			End If
		End If
		lv_prov_geo_x = lv_prov_geo_x * 1000000
		lv_prov_geo_y = lv_prov_geo_y * 1000000
		lv_rc = dw_Provider_dbf.SetItem(lv_row,2,lv_prov_name)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,3,lv_prov_address1)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,4,lv_prov_address2)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,5,lv_prov_city)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,6,lv_prov_state)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,7,lv_prov_zip)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,8,lv_prov_geo_x)
		lv_rc = dw_Provider_dbf.SetItem(lv_row,9,lv_prov_geo_y)

Next

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return -1
End If	



return 0
end function

event open;call super::open;//******************************************************************
//FNC 07/22/96 STARCARE Prob #921
//					Take out all references to network providers CBX_NETWORK
// MikeF	10/13/04	SPR3650d	Changed lookup refernces to use n_cst_dict
//******************************************************************

integer lv_suba, lv_counter
integer rc, ret_value, lv_rc
integer lv_column, lv_num_of_columns
string  lv_hold_col_name, lv_hold_label, lv_hold_col_tag 
string  lv_hold_col_type, lv_temp_str, lv_col_desc, lv_table_type 
string  lv_db_name, lv_cntl_id
long    lv_new_line_pos, ll_pos
integer lv_position,i
string  lv_where_message,lv_each_table_type
boolean lv_found

setpointer(Hourglass!)
iv_prov_parm = True
iv_enrol_parm = True
iv_array_count = 0

//fx_set_window_colors(w_geo_interface)		// FDG 05/22/96

//KMM 12/28/94 only show All Database Records radiobuttons if in winparm 
select cntl_id into :lv_cntl_id from stars_win_parm
	where win_id='W_GEO_INTERFACE' and cntl_id='ENROLALL'
using stars2ca;
if stars2ca.of_check_status()=100 then
	rb_enrol_all.checked = FALSE
	rb_enrol_all.enabled = FALSE
	iv_enrol_parm = False
elseif stars2ca.sqlcode<>0 then
	lv_where_message = 'win_id = W_GEO_INTERFACE and cntl_id = ENROLALL'
	errorbox(stars2ca,'Error reading win parm table: ' + lv_where_message)
end if
select cntl_id into :lv_cntl_id from stars_win_parm
	where win_id='W_GEO_INTERFACE' and cntl_id='PROVALL'
using stars2ca;
if stars2ca.of_check_status()=100 then
	rb_prov_all.checked = FALSE
	rb_prov_all.enabled = FALSE
	iv_prov_parm = False
elseif stars2ca.sqlcode<>0 then
	lv_where_message = 'win_id = W_GEO_INTERFACE and cntl_id = PROVALL'
	errorbox(stars2ca,'Error reading win parm table: ' + lv_where_message)
end if
//End KMM 12/28/94

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	



//SETS DEFAULTS 
//rb_pin.checked = True
//KMM 12/28/94 Checks All Database Records radiobuttons if in winparm
if iv_prov_parm then rb_prov_all.checked = True
if iv_enrol_parm then rb_enrol_all.checked = True
//End KMM 12/28/94
rb_prov_selected.enabled = False
rb_enrol_selected.enabled = False
rb_highlighting.checked = True
em_1.enabled = False
dw_provider.insertrow(0)
dw_enrollee.insertrow(0) 


//SET LEGEND DEFAULTS
For lv_counter = 1 to 25 
	dw_provider.SetItem(1,lv_counter,0)
	dw_enrollee.SetItem(1,lv_counter,0)
Next

//SET COLOR DEFAULTS
dw_provider.setitem(1,5,'16711680')
dw_provider.setitem(1,10,'8388608')
dw_provider.setitem(1,15,'16776960')
dw_provider.setitem(1,20,'8421376')
dw_provider.setitem(1,25,'32768')

dw_enrollee.setitem(1,5,'255')
dw_enrollee.setitem(1,10,'128')
dw_enrollee.setitem(1,15,'16711935')
dw_enrollee.setitem(1,20,'12632256')
dw_enrollee.setitem(1,25,'8421504')

iv_prov_in_dw = False
iv_enrol_in_dw = False

lv_table_type = iv_map_struct.table_type
iv_dw_map = iv_map_struct.dw
if not isvalid(iv_dw_map) then
	messagebox("ERROR","Datawindow source being mapped is no longer valid")
end if


//COUNTS NUMBER OF COLUMNS AND ROWS IN DW
iv_num_of_rows = iv_dw_map.RowCount()
lv_num_of_columns = long(iv_dw_map.Describe('datawindow.column.count'))
if lv_num_of_columns < 1 Then
  	messagebox("Print Message","Unable to obtain column names in order to allow you to select which column")
	return
end if

//sqlcmd('Connect',stars2ca,'Error connecting to Stars2ca',3)       PLB 10/20/95

// LOAD COLUMN NAMES AND WIDTHS INTO TABLES, LOAD DICTIONARY DESCRIPTION INTO LISTBOX  
FOR lv_suba = 1 to lv_num_of_columns
	lv_db_name = iv_dw_map.Describe('#'+string(lv_suba)+'.dbname')	
	lv_hold_col_name = iv_dw_map.Describe('#'+string(lv_suba)+'.name')	
	lv_hold_col_tag = iv_dw_map.Describe(lv_hold_col_name + ".Tag")
	lv_hold_col_type = iv_dw_map.Describe(lv_hold_col_name + ".coltype")
	lv_position = pos(lv_db_name,'.')
	if lv_position <> 0 then
		lv_db_name = mid(lv_db_name,lv_position+1)
	end if
	if (lv_hold_col_name = "" OR lv_hold_col_name = "!"   &
		OR lv_hold_col_name = "?"   ) then                		   		
		messagebox("Map Message","Unable to obtain column names in order to allow you to select which columns to map.  Unable to continue.")
		return
	end if

//GET DICTIONARY COLUMN DESCRIPTION
	if match(upper(lv_hold_col_tag),"MAP") then
		if lv_table_type = 'ML' then //HRB 10/18/95 prob #31 (EM) - if multiple table types, then loop thru table types until find one
			lv_found = false          //when coming from common subset view window (only place with ML at this point)   
			for i = 1 to gv_ss_parms.gsv_table_ct  
				lv_each_table_type = gv_ss_parms.gsv_table_type_name[i,1]
				lv_col_desc = gnv_dict.event ue_get_col_desc( lv_each_table_type, Upper(lv_db_name) )
				
				IF lv_col_desc <> 'ERROR' THEN
					lv_found = TRUE
					exit
				END IF
			next
			if not lv_found then			
				lv_where_message = 'elem_tbl_type = ' + lv_table_type + ' and elem_type = CL and elem_name = ' + lv_db_name
				errorbox(Stars2ca,'Error retrieving data from dictionary: ' + lv_where_message)
				return
			end if
		else      //HRB 10/18/95 - end 
			lv_col_desc = gnv_dict.event ue_get_col_desc( lv_table_type, Upper(lv_db_name) )
			if lv_col_desc = 'ERROR' then
				lv_where_message = 'elem_tbl_type = ' + lv_table_type + ' and elem_type = CL and elem_name = ' + lv_db_name
				errorbox(Stars2ca,'Error retrieving data from dictionary: ' + lv_where_message)
				return
			end if
		end if
		
		iv_array_count = iv_array_count + 1       //number of rows in array
		iv_map_array[iv_array_count,1] = lv_hold_col_name
		iv_map_array[iv_array_count,2] = lv_col_desc
		iv_map_array[iv_array_count,3] = lv_hold_col_type
		iv_map_array[iv_array_count,4] = string(lv_suba)		

	//CHECKS TAG VALUES FOR DW COLUMNS
		if match(upper(lv_hold_col_tag),"MAP_PROV") then
			iv_prov_in_dw = True  
			iv_prov_col = lv_suba   
		elseif match(upper(lv_hold_col_tag),"MAP_RECIP") then
			iv_enrol_in_dw = True
			iv_enrol_col = lv_suba
 		elseif match(upper(lv_hold_col_tag),"MAP") then
			ll_pos = pos(lv_col_desc, '/', 1)         // ABO 10/3/96 start
			if ll_pos > 0 then
				lv_col_desc = Left(lv_col_desc, ll_pos -1)
			end if                                    // ABO 10/3/96 end
			ddlb_1.AddItem(lv_col_desc)		
	 	 	ddlb_2.additem(lv_col_desc) 
		end if

	end if

NEXT

//sqlcmd('Disconnect',stars2ca,'Error disconnecting to Stars2ca',3)     PLB 10/20/95
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

//SET DROPDOWNLISTBOX DEFAULTS 
lv_rc = ddlb_1.additem("None")
ddlb_1.selectitem(lv_rc)
lv_rc = ddlb_2.additem("None")
ddlb_2.selectitem(lv_rc)


//ENABLES CORRECT PROVIDER OR RECIPIENT RECORDS BUTTON (ALL OR SELECTED RECORDS)

dw_provider.enabled = False
dw_enrollee.enabled = False

rb_both_provider.checked = True
rb_both_enrollee.checked = True

if Not iv_prov_in_dw then
	ddlb_1.enabled = False
   rb_prov_selected.enabled = False
   //KMM 12/28/94
	if iv_prov_parm then rb_prov_all.checked = True  
	//KMM 12/28/94
	rb_county_provider.enabled = False
   rb_state_provider.checked = False
	rb_state_provider.enabled = False
//   rb_none_provider.checked = True	        
   iv_prov_level_flag = 'N'
	iv_prov_flag = '0'
end if

if Not iv_enrol_in_dw then
	ddlb_2.enabled = False
   rb_enrol_selected.enabled = False
   if iv_enrol_parm then rb_enrol_all.checked = True 
	rb_county_enrollee.enabled = False
   rb_state_enrollee.checked = False
	rb_state_enrollee.enabled = False
//   rb_none_enrollee.checked = True
   iv_enrol_level_flag = 'N'
   iv_enrol_flag = '0'
end if

if Not iv_enrol_in_dw and Not iv_prov_in_dw then
  cb_save.enabled = False
end if



end event

on w_geo_interface.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_1=create st_1
this.cb_map_it=create cb_map_it
this.dw_provider_dbf=create dw_provider_dbf
this.rb_highlighting=create rb_highlighting
this.cb_close=create cb_close
this.em_1=create em_1
this.st_4=create st_4
this.rb_enrol_least=create rb_enrol_least
this.rb_enrol_most=create rb_enrol_most
this.rb_prov_least=create rb_prov_least
this.rb_prov_most=create rb_prov_most
this.rb_enrol_all=create rb_enrol_all
this.rb_enrol_selected=create rb_enrol_selected
this.rb_prov_all=create rb_prov_all
this.rb_prov_selected=create rb_prov_selected
this.dw_control=create dw_control
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.dw_enrollee_dbf=create dw_enrollee_dbf
this.rb_none_enrollee=create rb_none_enrollee
this.rb_none_provider=create rb_none_provider
this.st_10=create st_10
this.dw_enrollee=create dw_enrollee
this.dw_provider=create dw_provider
this.st_3=create st_3
this.st_2=create st_2
this.rb_both_provider=create rb_both_provider
this.rb_county_provider=create rb_county_provider
this.rb_state_provider=create rb_state_provider
this.st_by_what=create st_by_what
this.rb_both_enrollee=create rb_both_enrollee
this.rb_county_enrollee=create rb_county_enrollee
this.rb_state_enrollee=create rb_state_enrollee
this.cb_save=create cb_save
this.cb_reset=create cb_reset
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_map_it
this.Control[iCurrent+4]=this.dw_provider_dbf
this.Control[iCurrent+5]=this.rb_highlighting
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.rb_enrol_least
this.Control[iCurrent+10]=this.rb_enrol_most
this.Control[iCurrent+11]=this.rb_prov_least
this.Control[iCurrent+12]=this.rb_prov_most
this.Control[iCurrent+13]=this.rb_enrol_all
this.Control[iCurrent+14]=this.rb_enrol_selected
this.Control[iCurrent+15]=this.rb_prov_all
this.Control[iCurrent+16]=this.rb_prov_selected
this.Control[iCurrent+17]=this.dw_control
this.Control[iCurrent+18]=this.ddlb_2
this.Control[iCurrent+19]=this.ddlb_1
this.Control[iCurrent+20]=this.dw_enrollee_dbf
this.Control[iCurrent+21]=this.rb_none_enrollee
this.Control[iCurrent+22]=this.rb_none_provider
this.Control[iCurrent+23]=this.st_10
this.Control[iCurrent+24]=this.dw_enrollee
this.Control[iCurrent+25]=this.dw_provider
this.Control[iCurrent+26]=this.st_3
this.Control[iCurrent+27]=this.st_2
this.Control[iCurrent+28]=this.rb_both_provider
this.Control[iCurrent+29]=this.rb_county_provider
this.Control[iCurrent+30]=this.rb_state_provider
this.Control[iCurrent+31]=this.st_by_what
this.Control[iCurrent+32]=this.rb_both_enrollee
this.Control[iCurrent+33]=this.rb_county_enrollee
this.Control[iCurrent+34]=this.rb_state_enrollee
this.Control[iCurrent+35]=this.cb_save
this.Control[iCurrent+36]=this.cb_reset
this.Control[iCurrent+37]=this.gb_3
this.Control[iCurrent+38]=this.gb_1
this.Control[iCurrent+39]=this.gb_2
this.Control[iCurrent+40]=this.gb_5
this.Control[iCurrent+41]=this.gb_4
end on

on w_geo_interface.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_1)
destroy(this.cb_map_it)
destroy(this.dw_provider_dbf)
destroy(this.rb_highlighting)
destroy(this.cb_close)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.rb_enrol_least)
destroy(this.rb_enrol_most)
destroy(this.rb_prov_least)
destroy(this.rb_prov_most)
destroy(this.rb_enrol_all)
destroy(this.rb_enrol_selected)
destroy(this.rb_prov_all)
destroy(this.rb_prov_selected)
destroy(this.dw_control)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.dw_enrollee_dbf)
destroy(this.rb_none_enrollee)
destroy(this.rb_none_provider)
destroy(this.st_10)
destroy(this.dw_enrollee)
destroy(this.dw_provider)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.rb_both_provider)
destroy(this.rb_county_provider)
destroy(this.rb_state_provider)
destroy(this.st_by_what)
destroy(this.rb_both_enrollee)
destroy(this.rb_county_enrollee)
destroy(this.rb_state_enrollee)
destroy(this.cb_save)
destroy(this.cb_reset)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.gb_4)
end on

event ue_preopen;call super::ue_preopen;iv_map_struct = message.PowerObjectParm   //  get DW name to use from parm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

end event

type st_5 from statictext within w_geo_interface
string accessiblename = "Map at Level"
string accessibledescription = "Map at Level"
accessiblerole accessiblerole = statictextrole!
integer x = 1381
integer y = 88
integer width = 416
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Map at Level:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_geo_interface
string accessiblename = "Map at Level"
string accessibledescription = "Map at Level"
accessiblerole accessiblerole = statictextrole!
integer x = 78
integer y = 88
integer width = 416
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Map at Level:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_map_it from u_cb within w_geo_interface
string accessiblename = "Map..."
string accessibledescription = "Map..."
integer x = 2336
integer y = 1060
integer width = 338
integer height = 108
integer taborder = 230
integer weight = 400
string text = "&Map..."
boolean default = true
end type

event clicked;//*******************************************************************************
//
//	10/28/94	HRB	Added 3 rows to CONTROL table, 5 new tables, and 5 new .dbf's
//						for county information (provider, enrollee & network)
//	07/22/96	FNC	STARCARE Prob #921
//						Take out all references to network providers CBX_NETWORK
//	11/04/02	GaryR	SPR 3391d	Do not hard-code control.dbf path
//
//*******************************************************************************

integer lv_rc, lv_count, lv_from_text, lv_temp_symbol,lv_num_states
integer lv_savefile
string  lv_fromnum, lv_tonum,lv_state
string  lv_prov_map_by, lv_enrol_map_by
string  lv_prov_id, lv_enrol_id
string  lv_state_path, lv_state_open
string  lv_enrol_path, lv_enrol_open
string  lv_prov_path, lv_prov_open
string  lv_mapinfo, lv_col_type, lv_datastring
string  lv_enrol_name, lv_enrol_address1, lv_enrol_address2
string  lv_enrol_city, lv_enrol_state, lv_enrol_postal 
string  lv_net_symbol
string  lv_control_dbf, lv_prov_dbf, lv_enrol_dbf
string  lv_network, lv_network_dbf
real    lv_enrol_geo_x, lv_enrol_geo_y
integer lv_hold_col_num, lv_result
long 	  lv_dw_row, lv_row
long    lv_datavalue
boolean lv_null_flag, lv_message_flag

string lv_prov_cnty_path, lv_enrol_cnty_path, lv_network_cnty_dbf, lv_network_cnty
string lv_enrol_cnty_open, lv_prov_cnty_open, lv_network_open, lv_network_cnty_open
string lv_prov_cnty_dbf, lv_enrol_cnty_dbf
string lv_exceptions //djp

setmicrohelp(w_main,'Range Validation')
setpointer(hourglass!)

//RESET AND INSERT ROWS INTO DW_CONTROL
dw_enrollee_dbf.Reset()
dw_provider_dbf.Reset()
//dw_network.Reset()
dw_control.Reset()
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)  //djp

//ACCEPTS TEXT FROM CURSOR POSITION
lv_rc = dw_provider.accepttext()
if lv_rc < 1 then 
	dw_provider.setfocus()
	return
end if
lv_rc = dw_enrollee.accepttext()
if lv_rc < 1 then 
	dw_enrollee.setfocus()
	return
end if

lv_rc = wf_set_flags()

//KMM 12/29/94 Verifies there is something selected to map
if iv_prov_flag = '0' and iv_enrol_flag = '0' then
	lv_result = messagebox('Map Warning','Nothing selected to map.  Do you want to continue?',Question!,YESNO!,2)
	if	lv_result = 2 then
		return 
	end if
end if
//end KMM
	
if rb_none_provider.checked and rb_none_enrollee.checked then
  	messagebox('Error','Nothing selected to map.')
	RETURN
end if


//RANGE VALIDATION
For lv_count = 1 to 5
	lv_fromnum = 'from_range_' + string(lv_count)
	lv_tonum = 'to_range_' + string(lv_count)
	if (dw_provider.getitemdecimal(1,lv_fromnum)) >    &
		(dw_provider.getitemdecimal(1,lv_tonum)) then
		messagebox('Map Message','Provider range is incorrect. ~r' &
				+'Verify From range is less than To range. ~r' &
				+'Make sure legend is in ascending order.')
		dw_provider.SetFocus() 
		lv_rc = dw_provider.Setcolumn(lv_tonum) 
		return
	end if

	if dw_provider.getitemdecimal(1,lv_fromnum) <> 0 AND  &
		dw_provider.getitemdecimal(1,lv_tonum) <> 0 then
		lv_temp_symbol = dw_provider.GetItemNumber(1,"symbol_" + string(lv_count))
			If IsNull(lv_temp_symbol) OR lv_temp_symbol = 0 then
				messagebox('Map Message','Unable to map without symbol')
				dw_provider.SetFocus() 
				lv_rc = dw_provider.Setcolumn("symbol_"+string(lv_count)) 
				return 
			End if
	end if
Next	

For lv_count = 1 to 5
	lv_fromnum = 'from_range_' + string(lv_count)
	lv_tonum = 'to_range_' + string(lv_count)
	if (dw_enrollee.getitemdecimal(1,lv_fromnum)) > 	 &
		(dw_enrollee.getitemdecimal(1,lv_tonum)) then
		messagebox('Map Message','Patient range is incorrect. ~r' &
				+'Verify From range is less than To range. ~r' &
				+'Make sure legend is in ascending order.')
		dw_enrollee.SetFocus() 
		lv_rc = dw_enrollee.SetColumn(lv_tonum) 
		return
	end if

	if dw_enrollee.getitemdecimal(1,lv_fromnum) <> 0 AND  &	 
		dw_enrollee.getitemdecimal(1,lv_tonum) <> 0 then
		lv_temp_symbol = dw_enrollee.GetItemNumber(1,"symbol_" + string(lv_count))
		If IsNull(lv_temp_symbol) OR lv_temp_symbol = 0 then
			messagebox('Map Message','Unable to map without symbol')
			dw_enrollee.SetFocus() 
			lv_rc = dw_enrollee.Setcolumn("symbol_"+string(lv_count)) 
			return 
		End if
	end if
Next


//CHECKS FOR OVERLAPPING RANGES 
lv_rc = wf_range_overlap()
CHOOSE CASE lv_rc
	CASE -1 
		messagebox('Legend Error','Unable to map with overlapping provider ranges.~r' &
				+'Make sure legend is in ascending order.')
		dw_provider.SetFocus() 
		dw_provider.SetColumn(iv_temp_from_num)
   	return
	CASE -2 
		messagebox('Legend Error','Unable to map with overlapping patient ranges.~r' &
				+'Make sure legend is in ascending order.')
		dw_enrollee.SetFocus()
		dw_enrollee.SetColumn(iv_temp_from_num) 
		return 
	CASE -3
		messagebox('Legend Error','Unable to map with incorrect provider symbol.~r' &
				+'Verify symbol is between 32 and 66.')
		dw_provider.SetFocus() 
		return
	CASE -4	
		messagebox('Legend Error','Unable to map with incorrect provider size.~r' &
				+'Verify size is between 1 and 48.')
		dw_provider.SetFocus() 
		return
	CASE -5
		messagebox('Legend Error','Unable to map with incorrect patient symbol.~r' &
				+'Verify symbol is between 32 and 66.')
		dw_enrollee.SetFocus() 
		return
	CASE -6
		messagebox('Legend Error','Unable to map with incorrect patient size.~r' &
				+'Verify size is between 1 and 48.')
		dw_enrollee.SetFocus() 
		return
END CHOOSE

//FILLS INVISIBLE DW_GEO_CONTROL_DBF
lv_rc = wf_fill_dw() 
If lv_rc < 0 Then
	return
End If

setmicrohelp(w_main,'Loading Tables for MapInfo')

//FLAGS FOR PROVIDER SET AND ENROLLEE SET 
// All database records (flag='N') or just query records (flag='Y') 
dw_control.SetItem(1,"updaterequired",iv_prov_flag) 
dw_control.Setitem(2,"updaterequired",iv_enrol_flag)
dw_control.SetItem(4,"updaterequired",iv_prov_flag) 
dw_control.Setitem(5,"updaterequired",iv_enrol_flag)


CHOOSE CASE iv_counties_flag
	CASE 1
		if dw_control.SetItem(1,"high",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert most providers into control.dbf')
			return 
		end If 
		if dw_control.SetItem(4,"high",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert most providers into control.dbf')
			return 
		end If 
	CASE 2
		if dw_control.SetItem(1,"low",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert least providers into control.dbf')
			return 
		end If 
		if dw_control.SetItem(4,"low",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert least providers into control.dbf')
			return 
		end If 
	CASE 3
		if dw_control.SetItem(2,"high",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert most patients into control.dbf')
			return 
		end If 
		if dw_control.SetItem(5,"high",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert most patients into control.dbf')
			return 
		end If 
	CASE 4
		if dw_control.Setitem(2,"low",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert least patients into control.dbf')
			return 
		end If 
		if dw_control.Setitem(5,"low",integer(iv_number_counties)) < -1 then
			messagebox('Error','Unable to insert least patients into control.dbf')
			return 
		end If 
END CHOOSE

//SET RECTYPES AND OPENLEVEL IN CONTROL_DBF
if dw_control.SetItem(1,"rectype","P") < -1 then
	messagebox('Error','Unable to insert provider record type into control.dbf')
	return 
end If 
if dw_control.SetItem(2,"rectype","E")  < -1 then
	messagebox('Error','Unable to insert patient record type into control.dbf')
	return 
end If 
if dw_control.SetItem(3,"rectype","S")  < -1 then
	messagebox('Error','Unable to insert state record type into control.dbf')
	return 
end If
if dw_control.SetItem(4,"rectype","A") < -1 then
	messagebox('Error','Unable to insert provider record type into control.dbf')
	return 
end If 
if dw_control.SetItem(5,"rectype","B")  < -1 then
	messagebox('Error','Unable to insert patient record type into control.dbf')
	return 
end If 
if dw_control.SetItem(6,"rectype","X")  < -1 then  //djp
	messagebox('Error','Unable to insert exceptions record type into control.dbf')
	return 
end If 

if iv_prov_flag = 'N' then 
	if dw_control.SetItem(1,"openlevel","B") < -1 then
		messagebox('Error','Unable to insert provider openlevel into control.dbf')
		return 
	end if
	if dw_control.SetItem(4,"openlevel","B") < -1 then
		messagebox('Error','Unable to insert provider openlevel into control.dbf')
		return 
	end if
	dw_control.setitem(1,"size1",10)
	dw_control.setitem(1,"color1",7340256)
	dw_control.setitem(1,"symbol1",37)
	dw_control.setitem(4,"size1",10)
	dw_control.setitem(4,"color1",7340256)
	dw_control.setitem(4,"symbol1",37)
else
	if dw_control.SetItem(1,"openlevel",iv_prov_level_flag) < -1 then
		messagebox('Error','Unable to insert provider openlevel into control.dbf')
		return 
	end if
	if dw_control.SetItem(4,"openlevel",iv_prov_level_flag) < -1 then
		messagebox('Error','Unable to insert provider openlevel into control.dbf')
		return 
	end if
end if

if iv_enrol_flag = 'N' then
	if dw_control.SetItem(2,"openlevel","B") < -1 then
		messagebox('Error','Unable to insert patient openlevel into control.dbf')
		return 
	end If 
	if dw_control.SetItem(5,"openlevel","B") < -1 then
		messagebox('Error','Unable to insert patient openlevel into control.dbf')
		return 
	end If 
	dw_control.setitem(2,"size1",10)
	dw_control.setitem(2,"color1",20520)
	dw_control.setitem(2,"symbol1",36)
	dw_control.setitem(5,"size1",10)
	dw_control.setitem(5,"color1",20520)
	dw_control.setitem(5,"symbol1",36)
else
	if dw_control.SetItem(2,"openlevel",iv_enrol_level_flag) < -1 then
		messagebox('Error','Unable to insert patient openlevel into control.dbf')
		return 
	end If
	if dw_control.SetItem(5,"openlevel",iv_enrol_level_flag) < -1 then
		messagebox('Error','Unable to insert patient openlevel into control.dbf')
		return 
	end If
end If
 
if dw_control.setitem(3,"openlevel","1") < -1 then
	messagebox('Error','Unable to insert state openlevel into control.dbf')
	return
end if  

//READ STARS.INI
//DJP 2/5/96 - Change this part to use multi-states
lv_num_states=profileint(gv_ini_path+'stars.ini','MAP','NumStates',1)
if lv_num_states>1 then
	openwithparm(w_state_sel,lv_num_states)
	lv_state=message.stringparm
	if lv_state='cancel' then
		w_main.setmicrohelp('Map cancelled')
		return
	end if
else
	lv_state = ProfileString(gv_ini_path+"stars.ini","MAP","State"+string(x),"")
end if
lv_state_path = ProfileString(gv_ini_path+"stars.ini","MAP",lv_state+"StatePath","c:\mapdata")
lv_state_open = ProfileString(gv_ini_path+"stars.ini","MAP",lv_state+"StateOpenAs","c:\mapdata")
lv_exceptions = ProfileString(gv_ini_path+"stars.ini","MAP","Exceptions","c:\mapdata\excepts.tab")  //djp

lv_enrol_path = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolPath","c:\mapdata")
lv_enrol_cnty_path = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolCntyPath","c:\mapdata")
lv_enrol_open = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolOpenAs","c:\mapdata")
lv_enrol_cnty_open = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolCntyOpenAs","c:\mapdata")
lv_prov_path = ProfileString(gv_ini_path+"stars.ini","MAP","ProvPath","c:\mapdata")
lv_prov_cnty_path = ProfileString(gv_ini_path+"stars.ini","MAP","ProvCntyPath","c:\mapdata")
lv_prov_open = ProfileString(gv_ini_path+"stars.ini","MAP","ProvOpenAs","c:\mapdata")
lv_prov_cnty_open = ProfileString(gv_ini_path+"stars.ini","MAP","ProvCntyOpenAs","c:\mapdata")

//SET FILEPATHS AND OPENAS IN CONTROL_DBF
if iv_prov_flag = 'N' then
   lv_prov_path = ProfileString(gv_ini_path+"stars.ini","MAP","Provall","c:\mapdata")
   lv_prov_cnty_path = ProfileString(gv_ini_path+"stars.ini","MAP","ProvallCnty","c:\mapdata")
	if dw_control.SetItem(1,"filepath",lv_prov_path) < 1 then
		messagebox('Error','Unable to insert provider filepath into control.dbf')
		return
	end if
	if dw_control.SetItem(4,"filepath",lv_prov_cnty_path) < 1 then
		messagebox('Error','Unable to insert provider filepath into control.dbf')
		return
	end if
else	
	if dw_control.SetItem(1,"filepath",lv_prov_path) < 1 then
		messagebox('Error','Unable to insert provider filepath into control.dbf')
		return
	end if	
	if dw_control.SetItem(4,"filepath",lv_prov_cnty_path) < 1 then
		messagebox('Error','Unable to insert provider filepath into control.dbf')
		return
	end if	
end if

if dw_control.SetItem(1,"openas",lv_prov_open) < 1 then
	messagebox('Error','Unable to insert provider openas into control.dbf')
	return
end if	
if dw_control.SetItem(4,"openas",lv_prov_cnty_open) < 1 then
	messagebox('Error','Unable to insert provider openas into control.dbf')
	return
end if	

if iv_enrol_flag = 'N' then
	lv_enrol_path = ProfileString(gv_ini_path+"stars.ini","MAP","Enrolall","c:\mapdata")	
	lv_enrol_cnty_path = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolallCnty","c:\mapdata")	
	if dw_control.SetItem(2,"filepath",lv_enrol_path) < 1 then
		messagebox('Error','Unable to insert patient filepath into control.dbf')
		return
	end if
	if dw_control.SetItem(5,"filepath",lv_enrol_cnty_path) < 1 then
		messagebox('Error','Unable to insert patient filepath into control.dbf')
		return
	end if
else
	if dw_control.SetItem(2,"filepath",lv_enrol_path) < 1 then
		messagebox('Error','Unable to insert patient filepath into control.dbf')
		return
	end if
	if dw_control.SetItem(5,"filepath",lv_enrol_cnty_path) < 1 then
		messagebox('Error','Unable to insert patient filepath into control.dbf')
		return
	end if
end if

if dw_control.SetItem(2,"openas",lv_enrol_open) < 1 then
	messagebox('Error','Unable to insert patient openas into control.dbf')
	return
end if	
if dw_control.SetItem(5,"openas",lv_enrol_cnty_open) < 1 then
	messagebox('Error','Unable to insert patient openas into control.dbf')
	return
end if	
if dw_control.SetItem(3,"filepath",lv_state_path) < 1 then
	messagebox('Error','Unable to insert state filepath into control.dbf')
	return
end if	
if dw_control.SetItem(3,"openas",lv_state_open) < 1 then
	messagebox('Error','Unable to insert state openas into control.dbf')
	return
end if	
if dw_control.SetItem(6,"filepath",lv_exceptions) < 1 then
	messagebox('Error','Unable to insert exceptions filepath into control.dbf')
	return
end if	

//SET FIELDNAME IN CONTROL_DBF 
lv_prov_map_by = ddlb_1.text
lv_enrol_map_by = ddlb_2.text
lv_rc = dw_control.SetItem(1,"fieldname",lv_prov_map_by) 
lv_rc = dw_control.SetItem(2,"fieldname",lv_enrol_map_by) 
lv_rc = dw_control.SetItem(4,"fieldname",lv_prov_map_by) 
lv_rc = dw_control.SetItem(5,"fieldname",lv_enrol_map_by) 



//FILL INVISIBLE PROVIDER DATAWINDOW
//GET GRAPHDATAVALUE FROM STARS DW
lv_dw_row = 0
lv_row = 0
lv_message_flag = False

if lv_prov_map_by = "" then
	messagebox('ERROR','Provider Map By field can not be empty!')
	return
end if

If Not(lv_prov_map_by = "None" OR iv_prov_flag = "N") then
  //FIND COLUMN TYPE OF FIELD
	For lv_count =  1 to iv_array_count
		if match(iv_map_array[lv_count,2], lv_prov_map_by) then
			iv_col_type = iv_map_array[lv_count,3]
			iv_hold_col_num = integer(iv_map_array[lv_count,4])	
		exit
		end if
	Next

	lv_rc = wf_pin_or_upin()
	if lv_rc = -1 then return     // Database error encountered
	if iv_recs_not_found > 0 then
		lv_rc = messagebox('MAP MESSAGE', 'All provider records were not found. Choose OK' &
		 +' to continue and map.',Question!,OKCancel!,2)
		if lv_rc = 2 then
			setmicrohelp(w_main,'Ready')
			return
		end if		
	end if

End if


//FILL INVISIBLE ENROLLEE DATAWINDOW
//GET GRAPHDATAVALUE FROM STARS DW
lv_dw_row = 0
lv_row = 0
lv_message_flag = False
if lv_enrol_map_by = "" then
	messagebox('ERROR','Patient Map By field can not be empty!')
	return
end if

If Not(lv_enrol_map_by = "None" Or iv_enrol_flag = "N") then
  //FIND COLUMN TYPE OF FIELD
	For lv_count =  1 to iv_array_count
		if match(iv_map_array[lv_count,2], lv_enrol_map_by) then
			lv_col_type = iv_map_array[lv_count,3]
			lv_hold_col_num = integer(iv_map_array[lv_count,4])
			exit
		end if
	Next

//	sqlcmd('connect',stars2ca,'Error connecting to Stars2ca',3)     PLB 10/20/95

	For lv_count = 1 to iv_num_of_rows
		lv_row = dw_enrollee_dbf.InsertRow(0)  //inserts row into invisible dw
		lv_dw_row = lv_dw_row + 1	 				//increments row in stars dw 
	//RETRIEVES RECIPIENT ID AND GRAPHDATAVALUE FROM STARS DW
		if lv_col_type = "number" OR match(lv_col_type, "decimal") then
			lv_enrol_id = iv_dw_map.getitemstring(lv_dw_row,iv_enrol_col)
			lv_datavalue = iv_dw_map.getitemnumber(lv_dw_row,lv_hold_col_num)
	
			if dw_enrollee_dbf.SetItem(lv_row,"graphdatavalue",lv_datavalue) < 1 then
				messagebox('Map Message','Unable to set graphdatavalue in dw')
			end if	 			 				
	
		else     //GETS STRING GRAPHDATAVALUE
			lv_enrol_id = iv_dw_map.getitemstring(lv_dw_row,iv_enrol_col)
			lv_datastring = iv_dw_map.getitemstring(lv_dw_row,lv_hold_col_num)
    
    	   //CHECKS IF GRAPHDATAVALUE IS NUMERIC
       	if IsNumber(lv_datastring) then
					
				if dw_enrollee_dbf.SetItem(lv_row,"graphdatavalue",long(lv_datastring)) < 1 then
					messagebox('Map Message','Unable to set graphdatavalue in dw')
				end if
	 			 				
			else
				if lv_message_flag = False then
					lv_rc = messagebox('NON-NUMERIC PATIENT FIELD ENTRY', 'Choose OK to change all non-numeric ' & 
					+'entries to zero and continue',Question!,OKCancel!,1)
					lv_message_flag = True
					if lv_rc = 2 then
						return 
					end if
					lv_rc = dw_enrollee_dbf.SetItem(lv_row,"graphdatavalue",0) 			 									 					
				else
					lv_rc = dw_enrollee_dbf.SetItem(lv_row,"graphdatavalue",0) 	 			 				
				end if
			end if
	
		end if

		Select Patient_Name, Address_Line_1, Address_Line_2, City, State,
				Zip, Geo_X, Geo_Y
		Into :lv_enrol_name, :lv_enrol_address1, :lv_enrol_address2,
	   	  :lv_enrol_city, :lv_enrol_state, :lv_enrol_postal, 
			  :lv_enrol_geo_x, :lv_enrol_geo_y
		From Enrollee
		Where Recip_Id = Upper( :lv_enrol_id )
		Using stars2ca;
		If Stars2ca.of_check_status() = 100 then
		Elseif Stars2ca.sqlcode <> 0 Then
			Errorbox(Stars2ca, 'Error retrieving data from database')
		End If
			
		if settransobject(dw_enrollee_dbf,stars2ca) < 1 then
			messagebox('Error','Unable to set transaction object for patient')
		end if

		If Not(Stars2ca.sqlcode = 100) then
			lv_enrol_geo_x = lv_enrol_geo_x * 1000000
			lv_enrol_geo_y = lv_enrol_geo_y * 1000000
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,"recip_id",lv_enrol_id) 
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,2,lv_enrol_name)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,3,lv_enrol_address1)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,4,lv_enrol_address2)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,5,lv_enrol_city)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,6,lv_enrol_state)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,7,lv_enrol_postal)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,8,lv_enrol_geo_x)
			lv_rc = dw_enrollee_dbf.SetItem(lv_row,9,lv_enrol_geo_y)

		End if
		
	Next

	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	

End if

//SAVES INVISIBLEDATAWINDOWS 
lv_control_dbf = ProfileString(gv_ini_path+"stars.ini","MAP","ControlDbf","C:\control.dbf")
lv_prov_dbf = ProfileString(gv_ini_path+"stars.ini","MAP","ProvDbf","C:\")
lv_enrol_dbf = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolDbf","C:\")
lv_prov_cnty_dbf = ProfileString(gv_ini_path+"stars.ini","MAP","ProvCntyDbf","C:\")
lv_enrol_cnty_dbf = ProfileString(gv_ini_path+"stars.ini","MAP","EnrolCntyDbf","C:\")

lv_savefile = dw_control.SaveAs(lv_control_dbf,dBase3!,True)
If (lv_savefile = -1) Then
	MessageBox('Error','Error saving control datawindow as a .DBF')
End If
lv_savefile = dw_provider_dbf.SaveAs(lv_prov_dbf,dBase3!,True)
If (lv_savefile = -1) Then
	MessageBox('Error','Error saving provider datawindow as a .DBF')
End If
lv_savefile = dw_enrollee_dbf.SaveAs(lv_enrol_dbf,dBase3!,True)
If (lv_savefile = -1) Then
	MessageBox('Error','Error saving patient datawindow as a .DBF')
End If 
lv_savefile = dw_provider_dbf.SaveAs(lv_prov_cnty_dbf,dBase3!,True)
If (lv_savefile = -1) Then
	MessageBox('Error','Error saving provider datawindow as a .DBF')
End If
lv_savefile = dw_enrollee_dbf.SaveAs(lv_enrol_cnty_dbf,dBase3!,True)
If (lv_savefile = -1) Then
	MessageBox('Error','Error saving patient datawindow as a .DBF')
End If

setmicrohelp(w_main,'Opening MapInfo. Please Wait!')

lv_mapinfo = ProfileString(gv_ini_path+"stars.ini","MAP","MapInfo","C:\mapinfo c:\mapit\mapit.wor")
lv_rc = Run(lv_mapinfo,Maximized!)
if lv_rc = -1 then
	      MessageBox("Map Error", + &
                 "Error Opening MapInfo" + &
                 "~n~nPossible Causes:" + &
                 "~n   1.Not enough memory" + &   
                 "~n   2.Can not find MapInfo executable" + &
                 "~n   3.MapInfo already open",StopSign!,OK!,1)
//	messagebox('Map Message','Error Opening MapInfo.  Possible Causes:There may not be enough memory ' &
//				 + 'or MapInfo is already open.')
End If

setmicrohelp(w_main,'Ready')
end event

type dw_provider_dbf from u_dw within w_geo_interface
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2199
integer y = 1300
integer width = 142
integer height = 88
integer taborder = 0
string dataobject = "d_geo_provider_dbf"
end type

type rb_highlighting from radiobutton within w_geo_interface
string accessiblename = "None"
string accessibledescription = "None"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1010
integer y = 1272
integer width = 293
integer height = 72
integer taborder = 210
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "None"
end type

on clicked;em_1.text = ''
em_1.enabled = False
end on

type cb_close from u_cb within w_geo_interface
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2336
integer y = 1432
integer width = 338
integer height = 108
integer taborder = 260
integer weight = 400
string text = "&Close"
end type

on clicked;setmicrohelp(w_main,'Ready')
Close(w_geo_interface)
end on

type em_1 from editmask within w_geo_interface
string accessiblename = "Select Number of Counties"
string accessibledescription = "Select Number of Counties"
accessiblerole accessiblerole = textrole!
integer x = 1975
integer y = 1328
integer width = 197
integer height = 100
integer taborder = 220
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~10"
end type

type st_4 from statictext within w_geo_interface
string accessiblename = "Number of Counties "
string accessibledescription = "Number of Counties "
accessiblerole accessiblerole = statictextrole!
integer x = 1317
integer y = 1348
integer width = 626
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Number of Counties "
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_enrol_least from radiobutton within w_geo_interface
string accessiblename = "Least Patients"
string accessibledescription = "Least Patients"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1637
integer y = 1184
integer width = 581
integer height = 72
integer taborder = 200
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Least Patients"
end type

on clicked;em_1.enabled = True
end on

type rb_enrol_most from radiobutton within w_geo_interface
string accessiblename = "Most Patients"
string accessibledescription = "Most Patients"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1637
integer y = 1096
integer width = 581
integer height = 72
integer taborder = 190
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Most Patients"
end type

on clicked;em_1.enabled = True
end on

type rb_prov_least from radiobutton within w_geo_interface
string accessiblename = "Least Providers"
string accessibledescription = "Least Providers"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1010
integer y = 1184
integer width = 594
integer height = 72
integer taborder = 180
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Least Providers"
end type

on clicked;em_1.enabled = True
end on

type rb_prov_most from radiobutton within w_geo_interface
string accessiblename = "Most Providers"
string accessibledescription = "Most Providers"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1010
integer y = 1096
integer width = 594
integer height = 72
integer taborder = 170
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Most Providers"
end type

on clicked;em_1.enabled = True
end on

type rb_enrol_all from radiobutton within w_geo_interface
string accessiblename = "All Database Records"
string accessibledescription = "All Database Records"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 73
integer y = 1448
integer width = 763
integer height = 84
integer taborder = 160
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "All Database Records"
end type

on clicked;int lv_rc

lv_rc = ddlb_2.FindItem('None',1)
ddlb_2.SelectItem(lv_rc)
ddlb_2.TriggerEvent(SelectionChanged!)
end on

type rb_enrol_selected from radiobutton within w_geo_interface
string accessiblename = "Query Records Selected"
string accessibledescription = "Query Records Selected"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 73
integer y = 1364
integer width = 832
integer height = 72
integer taborder = 150
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Query Records Selected"
end type

type rb_prov_all from radiobutton within w_geo_interface
string accessiblename = "All Database Records"
string accessibledescription = "All Database Records"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 73
integer y = 1184
integer width = 763
integer height = 72
integer taborder = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "All Database Records"
end type

on clicked;int lv_rc

lv_rc = ddlb_1.FindItem('None',1)
ddlb_1.SelectItem(lv_rc)
ddlb_1.TriggerEvent(SelectionChanged!)
end on

type rb_prov_selected from radiobutton within w_geo_interface
string accessiblename = "Query Records Selected"
string accessibledescription = "Query Records Selected"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 73
integer y = 1096
integer width = 832
integer height = 76
integer taborder = 130
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Query Records Selected"
end type

type dw_control from u_dw within w_geo_interface
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2231
integer y = 1388
integer width = 101
integer height = 96
integer taborder = 0
string dataobject = "d_geo_control_dbf"
end type

type ddlb_2 from dropdownlistbox within w_geo_interface
string accessiblename = "Patient Map By Selection"
string accessibledescription = "Patient Map By Selection"
accessiblerole accessiblerole = comboboxrole!
integer x = 1714
integer y = 280
integer width = 887
integer height = 400
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;integer ret_value, lv_count 
string lv_col_desc, lv_hold_col_name

setpointer(hourglass!)
setmicrohelp('Retrieving Default Legend...')

// SET DEFAULT CONTROL VALUES FOR ENROLLEE LEGEND
lv_col_desc = ddlb_2.text


For lv_count = 1 to iv_array_count
	if match(upper(iv_map_array[lv_count,2]),upper(lv_col_desc)) then
		lv_hold_col_name = upper(iv_map_array[lv_count,1])
		exit		
	end if
Next

iv_cntl_id = lv_hold_col_name
iv_user_id = gc_user_id

ret_value = wf_retrieve_enrol_dflt(iv_user_id, iv_cntl_id,2)

if ret_value = -1 then return     // Database error encountered

if iv_dflt_counter = 0 then         // No values were found for UserId and CNTL_ID
  iv_user_id = "SYSTEM"
  ret_value = wf_retrieve_enrol_dflt(iv_user_id, iv_cntl_id,2)
  if ret_value = -1 then return
end if 

do while iv_dflt_counter < 5
	dw_enrollee.SetItem(1, (iv_dflt_counter * 5) + 1, 0)
	dw_enrollee.SetItem(1, (iv_dflt_counter * 5) + 2, 0)
	dw_enrollee.SetItem(1, (iv_dflt_counter * 5) + 3, 0)
	dw_enrollee.SetItem(1, (iv_dflt_counter * 5) + 4, 0)
	dw_enrollee.SetItem(1, (iv_dflt_counter * 5) + 5, 0)
  
   iv_dflt_counter = iv_dflt_counter + 1

//SD PB 4.0
   dw_enrollee.Modify("color_"+String(iv_dflt_counter)+".color="+"0")
loop

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

If Not(lv_col_desc = "None") then
	dw_enrollee.enabled = True
	rb_enrol_selected.enabled = True
   rb_enrol_selected.checked = True
	cb_save.enabled = True
else
	dw_enrollee.setitem(1,5,'255')
	dw_enrollee.setitem(1,10,'128')
	dw_enrollee.setitem(1,15,'16711935')
	dw_enrollee.setitem(1,20,'12632256')
	dw_enrollee.setitem(1,25,'8421504')
	dw_enrollee.enabled = False
	rb_enrol_selected.enabled = False
   rb_enrol_selected.checked = False
	//KMM 12/29/94 Checks All Database Records if in winparm
	if iv_enrol_parm then rb_enrol_all.checked = True
end if

setmicrohelp(w_main,'Ready')
end on

type ddlb_1 from dropdownlistbox within w_geo_interface
string accessiblename = "Provider Map By Selection"
string accessibledescription = "Provider Map By Selection"
accessiblerole accessiblerole = comboboxrole!
integer x = 357
integer y = 280
integer width = 887
integer height = 400
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;integer lv_rc, lv_count 
string lv_col_desc, lv_hold_col_name
 
setpointer(hourglass!)
setmicrohelp('Retrieving Default Legend...')

// SET DEFAULT CONTROL VALUES FOR PROVIDER LEGEND
lv_col_desc = ddlb_1.text

For lv_count = 1 to iv_array_count
	if match(upper(iv_map_array[lv_count,2]),upper(lv_col_desc)) then
		lv_hold_col_name = upper(iv_map_array[lv_count,1])
		exit
	end if
Next
	
iv_cntl_id = lv_hold_col_name
iv_user_id = gc_user_id

lv_rc = wf_retrieve_dflt(iv_user_id, iv_cntl_id, 1)  // last parm=1 means provider

if lv_rc = -1 then return     // Database error encountered

if iv_dflt_counter = 0 then         // No values were found for UserId and CNTL_ID
  iv_user_id = "SYSTEM"
  lv_rc = wf_retrieve_dflt(iv_user_id, iv_cntl_id, 1) 
  if lv_rc = -1 then return
end if 

do while iv_dflt_counter < 5
	dw_provider.SetItem(1, (iv_dflt_counter * 5) + 1, 0)
	dw_provider.SetItem(1, (iv_dflt_counter * 5) + 2, 0)
	dw_provider.SetItem(1, (iv_dflt_counter * 5) + 3, 0)
	dw_provider.SetItem(1, (iv_dflt_counter * 5) + 4, 0)
	dw_provider.SetItem(1, (iv_dflt_counter * 5) + 5, 0)
  
   iv_dflt_counter = iv_dflt_counter + 1

//SD PB 4.0
	dw_provider.Modify("color_"+String(iv_dflt_counter)+".color="+"0")
loop

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

If Not(lv_col_desc = "None") then
   dw_provider.enabled = True
	rb_prov_selected.enabled = True
   rb_prov_selected.checked = True
	rb_prov_all.checked = False
	cb_save.enabled = True
else
	//SET COLOR DEFAULTS
	dw_provider.setitem(1,5,'16711680')
	dw_provider.setitem(1,10,'8388608')
	dw_provider.setitem(1,15,'16776960')
	dw_provider.setitem(1,20,'8421376')
	dw_provider.setitem(1,25,'32768')
	dw_provider.enabled = False
   rb_prov_selected.enabled = False
   rb_prov_selected.checked = False
	//KMM 12/29/94 Checks All Database Records if in winparm
	if iv_prov_parm then rb_prov_all.checked = True
end if

setmicrohelp(w_main,'Ready')
end on

type dw_enrollee_dbf from u_dw within w_geo_interface
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2199
integer y = 1480
integer width = 137
integer height = 88
integer taborder = 0
string dataobject = "d_geo_enrollee_dbf"
end type

type rb_none_enrollee from radiobutton within w_geo_interface
string accessiblename = "None"
string accessibledescription = "None"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 2322
integer y = 172
integer width = 293
integer height = 72
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "None"
end type

on clicked;int lv_rc, lv_counter


//Disables enrollee legend
For lv_counter = 1 to 25 
	dw_enrollee.SetItem(1,lv_counter,0)
Next
dw_enrollee.setitem(1,5,'255')
dw_enrollee.setitem(1,10,'128')
dw_enrollee.setitem(1,15,'16711935')
dw_enrollee.setitem(1,20,'12632256')
dw_enrollee.setitem(1,25,'8421504')

dw_enrollee.enabled = False
lv_rc = ddlb_1.finditem("None",1)
ddlb_2.selectitem(lv_rc)
ddlb_2.enabled = False
rb_enrol_selected.enabled = False
rb_enrol_selected.checked = False
//KMM 12/29/94 //KMM 12/29/94 Checks All Database Records radiobutton if in winparm
if iv_enrol_parm then
	rb_enrol_all.enabled = False
	rb_enrol_all.checked = False
end if
rb_enrol_most.enabled = False
rb_enrol_least.enabled = False
rb_highlighting.checked = True

end on

type rb_none_provider from radiobutton within w_geo_interface
string accessiblename = "None"
string accessibledescription = "None"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1006
integer y = 172
integer width = 293
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "None"
end type

on clicked;int lv_rc,lv_counter


//Disables provider legend 
//SET LEGEND DEFAULTS
For lv_counter = 1 to 25 
	dw_provider.SetItem(1,lv_counter,0)
Next

//SET COLOR DEFAULTS
dw_provider.setitem(1,5,'16711680')
dw_provider.setitem(1,10,'8388608')
dw_provider.setitem(1,15,'16776960')
dw_provider.setitem(1,20,'8421376')
dw_provider.setitem(1,25,'32768')

dw_provider.enabled = False
lv_rc = ddlb_1.finditem("None",1)
ddlb_1.selectitem(lv_rc)
ddlb_1.enabled = False
rb_prov_selected.enabled = False
rb_prov_selected.checked = False
//KMM 12/29/94 //KMM 12/29/94 Checks All Database Records radiobutton if in winparm
if iv_prov_parm then
	rb_prov_all.enabled = False
	rb_prov_all.checked = False
end if
rb_prov_most.enabled = False
rb_prov_least.enabled = False
rb_highlighting.checked = True
iv_prov_flag = '0'

end on

type st_10 from statictext within w_geo_interface
string accessiblename = "Legend"
string accessibledescription = "Legend"
accessiblerole accessiblerole = statictextrole!
integer x = 69
integer y = 380
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Legend:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_enrollee from u_dw within w_geo_interface
event color_change pbm_custom01
string accessiblename = "Enrollee From and To Values"
string accessibledescription = "Enrollee From and To Values"
integer x = 1371
integer y = 456
integer width = 1285
integer height = 556
integer taborder = 120
string dataobject = "d_geo_legend"
boolean hscrollbar = true
boolean border = false
end type

on color_change;//dw_enrollee.Modify(iv_column+".background.color="+iv_column_text)	KMM 7/8/95 Prob#141
//if iv_column_text="16777215"  OR iv_column_text="65535" OR  &			KMM 7/8/95 Prob#141
//iv_column_text="12632256" OR iv_column_text="8421504"   OR  &			KMM 7/8/95 Prob#141
//iv_column_text="16776960" OR iv_column_text="65280" then					KMM 7/8/95 Prob#141
	dw_enrollee.Modify(iv_column+".color=0")
//else																						KMM 7/8/95 Prob#141
//	dw_enrollee.Modify(iv_column+".color=16777215")							KMM 7/8/95 Prob#141
//end if																						KMM 7/8/95 Prob#141
end on

on itemchanged;integer lv_column
long lv_cur_row
string lv_color_text

iv_column = getcolumnname()
iv_column_text = gettext()
lv_column = getcolumn()
lv_cur_row = getrow()
if (lv_column=5 OR lv_column=10 OR lv_column=15 OR lv_column=20 OR &
   lv_column=25) then
	dw_enrollee.postevent("color_change")
end if



end on

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

integer lv_row, lv_symbol

setpointer(hourglass!)

lv_row = getrow()

lv_symbol = dw_enrollee.getitemnumber(1,as_col)
setmicrohelp(w_main,'Opening Symbol Selection...')
Openwithparm(w_geo_symbol,lv_symbol)
iv_symbol_number = message.Doubleparm
//KMM Clear out message parm (PB Bug)
SetNull(message.doubleparm)
if iv_symbol_number <> -1 then 
	setitem(lv_row, as_col, iv_symbol_number) 
else
	setitem(lv_row,as_col, lv_symbol)
end if

setmicrohelp(w_main,'Ready')
end event

type dw_provider from u_dw within w_geo_interface
event button_enabled pbm_custom01
event color_change pbm_custom02
string accessiblename = "Provider From and To Values"
string accessibledescription = "Provider From and To Values"
integer x = 55
integer y = 456
integer width = 1285
integer height = 556
integer taborder = 60
string dataobject = "d_geo_legend"
boolean hscrollbar = true
boolean border = false
end type

on color_change;//Set background color to match text 
	dw_provider.Modify(iv_column+".color=0")

end on

on itemchanged;integer lv_column
long lv_cur_row
string lv_color_text

iv_column = getcolumnname()
iv_column_text = gettext()
lv_column = getcolumn()
lv_cur_row = getrow()
CHOOSE CASE lv_column
	CASE 5,10,15,20,25
		dw_provider.postevent("color_change")
END CHOOSE



end on

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

integer lv_row, lv_symbol

setpointer(hourglass!)

lv_row = getrow()

lv_symbol = dw_provider.getitemnumber( 1, as_col )
setmicrohelp(w_main,'Opening Symbol Selection...')
OpenWithParm(w_geo_symbol,lv_symbol)
iv_symbol_number = message.Doubleparm
//KMM Clear out message parm (PB Bug)
SetNull(message.doubleparm)
if iv_symbol_number <> -1 then
	setitem(lv_row, as_col, iv_symbol_number) 
else
	setitem(lv_row,as_col, lv_symbol)
end if

setmicrohelp(w_main,'Ready')
end event

type st_3 from statictext within w_geo_interface
string accessiblename = "Legend"
string accessibledescription = "Legend"
accessiblerole accessiblerole = statictextrole!
integer x = 1390
integer y = 380
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Legend:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_geo_interface
string accessiblename = "Map by"
string accessibledescription = "Map by"
accessiblerole accessiblerole = statictextrole!
integer x = 1385
integer y = 280
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Map by:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_both_provider from radiobutton within w_geo_interface
string accessiblename = "Both "
string accessibledescription = "Both "
accessiblerole accessiblerole = radiobuttonrole!
integer x = 718
integer y = 172
integer width = 274
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Both "
boolean checked = true
end type

on clicked;if iv_prov_in_dw then
	//KMM 12/29/94
  if iv_prov_parm then rb_prov_all.enabled = True
  ddlb_1.enabled = True
	if ddlb_1.text = "None" then
		//KMM 12/29/94
		if iv_prov_parm then rb_prov_all.checked = True		
		dw_provider.enabled = False
	else
		dw_provider.enabled = True
		rb_prov_selected.enabled = True
		rb_prov_selected.checked = True
	end if
	rb_prov_most.enabled = True
	rb_prov_least.enabled = True
else
	//KMM 12/29/94 //KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_prov_parm then
		rb_prov_all.enabled = True
		rb_prov_all.checked = True
	end if
   rb_prov_selected.enabled = False
end if

if ddlb_1.text = "None" then
	dw_provider.enabled = False
end if


end on

type rb_county_provider from radiobutton within w_geo_interface
string accessiblename = "County "
string accessibledescription = "County "
accessiblerole accessiblerole = radiobuttonrole!
integer x = 366
integer y = 172
integer width = 325
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "County "
end type

on clicked;if ddlb_1.text = "None" then
	dw_provider.enabled = False
	//KMM 12/29/94 Checks All Database Records radiobutton if in winparm	
	if iv_prov_parm then
		rb_prov_all.enabled = True	
		rb_prov_all.checked = True		
	end if
else
	dw_provider.enabled = True
	rb_prov_selected.enabled = True
	rb_prov_selected.checked = True
	//KMM 12/29/94 Enables All Database Records radiobutton if in winparm
	if iv_prov_parm then rb_prov_all.enabled = True		
end if

ddlb_1.enabled = True
rb_prov_most.enabled = True
rb_prov_least.enabled = True
end on

type rb_state_provider from radiobutton within w_geo_interface
string accessiblename = "State "
string accessibledescription = "State "
accessiblerole accessiblerole = radiobuttonrole!
integer x = 78
integer y = 172
integer width = 279
integer height = 72
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "State "
end type

on clicked;if ddlb_1.text = "None" then
	dw_provider.enabled = False	
	if iv_prov_parm then
		rb_prov_all.enabled = True	
		rb_prov_all.checked = True		
	end if
else
	dw_provider.enabled = True
	rb_prov_selected.enabled = True
	rb_prov_selected.checked = True
	//KMM 12/29/94 Enables All Database Records radiobutton if in winparm
	if iv_prov_parm then rb_prov_all.enabled = True		
end if

ddlb_1.enabled = True
rb_prov_most.enabled = True
rb_prov_least.enabled = True
end on

type st_by_what from statictext within w_geo_interface
string accessiblename = "Map by  "
string accessibledescription = "Map by  "
accessiblerole accessiblerole = statictextrole!
integer x = 73
integer y = 280
integer width = 279
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Map by:  "
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_both_enrollee from radiobutton within w_geo_interface
string accessiblename = "Both "
string accessibledescription = "Both "
accessiblerole accessiblerole = radiobuttonrole!
integer x = 2030
integer y = 172
integer width = 274
integer height = 72
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Both "
boolean checked = true
end type

on clicked;
if iv_enrol_in_dw then
  //KMM 12/29/94 //KMM 12/29/94 Enables All Database Records radiobutton if in winparm
  if iv_enrol_parm then rb_enrol_all.enabled = True
  ddlb_2.enabled = True
	if ddlb_2.text = "None" then
		//KMM 12/29/94
		if iv_enrol_parm then rb_enrol_all.checked = True		
		dw_enrollee.enabled = False
	else
		dw_enrollee.enabled = True
		rb_enrol_selected.enabled = True
		rb_enrol_selected.checked = True
	end if
	rb_enrol_most.enabled = True
	rb_enrol_least.enabled = True
else
	//KMM 12/29/94 //KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_enrol_parm then
		rb_enrol_all.enabled = True
		rb_enrol_all.checked = True
	end if
   rb_enrol_selected.enabled = False
end if

if ddlb_2.text = "None" then
	dw_enrollee.enabled = False
end if


end on

type rb_county_enrollee from radiobutton within w_geo_interface
string accessiblename = "County "
string accessibledescription = "County "
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1678
integer y = 172
integer width = 325
integer height = 72
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "County "
end type

on clicked;if ddlb_2.text = "None" then
	dw_enrollee.enabled = False
	//KMM 12/29/94 //KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_enrol_parm then
		rb_enrol_all.enabled = True	
		rb_enrol_all.checked = True		
	end if
else
	dw_enrollee.enabled = True
	rb_enrol_selected.enabled = True
	rb_enrol_selected.checked = True
	//KMM 12/29/94
	if iv_enrol_parm then rb_enrol_all.enabled = True
end if

rb_enrol_most.enabled = True
rb_enrol_least.enabled = True
ddlb_2.enabled = True

end on

type rb_state_enrollee from radiobutton within w_geo_interface
string accessiblename = "State "
string accessibledescription = "State "
accessiblerole accessiblerole = radiobuttonrole!
integer x = 1390
integer y = 172
integer width = 279
integer height = 72
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "State "
end type

on clicked;if ddlb_2.text = "None" then
	dw_enrollee.enabled = False
	//KMM 12/29/94 //KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_enrol_parm then
		rb_enrol_all.enabled = True	
		rb_enrol_all.checked = True		
	end if
else
	dw_enrollee.enabled = True
	rb_enrol_selected.enabled = True
	rb_enrol_selected.checked = True
	//KMM 12/29/94
	if iv_enrol_parm then rb_enrol_all.enabled = True
end if

rb_enrol_most.enabled = True
rb_enrol_least.enabled = True
ddlb_2.enabled = True

end on

type cb_save from u_cb within w_geo_interface
string accessiblename = "Save"
string accessibledescription = "Save"
integer x = 2336
integer y = 1184
integer width = 338
integer height = 108
integer taborder = 240
integer weight = 400
string text = "&Save"
end type

event clicked;integer lv_counter, temp_symbol, temp_size, SqlDBRc
long    temp_from_range, temp_to_range
string  temp_color, lv_col_desc, lv_hold_col_name 
string  lv_user_id, lv_cntl_id 
integer lv_seq_num 
integer lv_count, lv_rc, lv_temp_symbol
string  lv_fromnum, lv_tonum

if ddlb_1.text = "None" AND ddlb_2.text = "None" then
	messagebox('ERROR','Nothing selected to save.')
	return
end if

setmicrohelp(w_main,'Saving Legend Defaults...')
setpointer(hourglass!)

//ACCEPTS TEXT FROM CURSOR POSITION
lv_rc = dw_provider.accepttext()
if lv_rc < 1 then 
	dw_provider.setfocus()
	return
end if
lv_rc = dw_enrollee.accepttext()
if lv_rc < 1 then 
	dw_enrollee.setfocus()
	return
end if

//RANGE VALIDATION
For lv_count = 1 to 5
	lv_fromnum = 'from_range_' + string(lv_count)
	lv_tonum = 'to_range_' + string(lv_count)
	if (dw_provider.getitemdecimal(1,lv_fromnum)) >    &
		(dw_provider.getitemdecimal(1,lv_tonum)) then
		messagebox('Map Message','Provider range is incorrect. ~r' &
				+'Verify From range is less than To range. ~r' &
				+'Make sure legend is in ascending order.')
		dw_provider.SetFocus() 
		lv_rc = dw_provider.Setcolumn(lv_tonum) 
		return
	end if

	if dw_provider.getitemdecimal(1,lv_fromnum) <> 0 AND  &
		dw_provider.getitemdecimal(1,lv_tonum) <> 0 then
		lv_temp_symbol = dw_provider.GetItemNumber(1,"symbol_" + string(lv_count))
			If IsNull(lv_temp_symbol) OR lv_temp_symbol = 0 then
				messagebox('Map Message','Unable to map without symbol')
				dw_provider.SetFocus() 
				lv_rc = dw_provider.Setcolumn("symbol_"+string(lv_count)) 
				return 
			End if
	end if
Next	

For lv_count = 1 to 5
	lv_fromnum = 'from_range_' + string(lv_count)
	lv_tonum = 'to_range_' + string(lv_count)
	if (dw_enrollee.getitemdecimal(1,lv_fromnum)) > 	 &
		(dw_enrollee.getitemdecimal(1,lv_tonum)) then
		messagebox('Map Message','Patient range is incorrect. ~r' &
				+'Verify From range is less than To range. ~r' &
				+'Make sure legend is in ascending order.')
		dw_enrollee.SetFocus() 
		lv_rc = dw_enrollee.SetColumn(lv_tonum) 
		return
	end if

	if dw_enrollee.getitemdecimal(1,lv_fromnum) <> 0 AND  &	 
		dw_enrollee.getitemdecimal(1,lv_tonum) <> 0 then
		lv_temp_symbol = dw_enrollee.GetItemNumber(1,"symbol_" + string(lv_count))
		If IsNull(lv_temp_symbol) OR lv_temp_symbol = 0 then
			messagebox('Map Message','Unable to map without symbol')
			dw_enrollee.SetFocus() 
			lv_rc = dw_enrollee.Setcolumn("symbol_"+string(lv_count)) 
			return 
		End if
	end if
Next


//CHECKS FOR OVERLAPPING RANGES 
lv_rc = wf_range_overlap()
CHOOSE CASE lv_rc
	CASE -1 
		messagebox('Legend Error','Unable to map with overlapping provider ranges.~r' &
				+'Make sure legend is in ascending order.')
		dw_provider.SetFocus() 
		dw_provider.SetColumn(iv_temp_from_num)
   	return
	CASE -2 
		messagebox('Legend Error','Unable to map with overlapping patient ranges.~r' &
				+'Make sure legend is in ascending order.')
		dw_enrollee.SetFocus()
		dw_enrollee.SetColumn(iv_temp_from_num) 
		return 
	CASE -3
		messagebox('Legend Error','Unable to map with incorrect provider symbol.~r' &
				+'Verify symbol is between 32 and 66.')
		dw_provider.SetFocus()
		dw_provider.SetColumn(iv_temp)
		return
	CASE -4	
		messagebox('Legend Error','Unable to map with incorrect provider size.~r' &
				+'Verify size is between 1 and 48.')
		dw_provider.SetFocus()
		dw_provider.SetColumn(iv_temp)
		return
	CASE -5
		messagebox('Legend Error','Unable to map with incorrect patient symbol.~r' &
				+'Verify symbol is between 32 and 66.')
		dw_enrollee.SetFocus()
		dw_enrollee.SetColumn(iv_temp)
		return
	CASE -6
		messagebox('Legend Error','Unable to map with incorrect patient size.~r' &
				+'Verify size is between 1 and 48.')
		dw_enrollee.setFocus()
		dw_enrollee.SetColumn(iv_temp)
		return
END CHOOSE

lv_seq_num = 0

lv_col_desc = ddlb_1.text
For lv_counter = 1 to iv_array_count
	if match(upper(iv_map_array[lv_counter,2]),upper(lv_col_desc)) then
		lv_hold_col_name = upper(iv_map_array[lv_counter,1])
		exit
	end if
Next
	
iv_cntl_id = lv_hold_col_name

IF Not (ddlb_1.text = "None" OR ddlb_1.text = "") Then 

FOR lv_counter = 1 to 5	
	temp_from_range = dw_provider.GetItemDecimal(1,"from_range_" + string(lv_counter))
	temp_to_range = dw_provider.GetItemDecimal(1,"to_range_" + string(lv_counter))
	temp_symbol = dw_provider.GetItemNumber(1,"symbol_" + string(lv_counter))
	temp_size = dw_provider.GetItemNumber(1,"size_" + string(lv_counter))
	temp_color = dw_provider.GetItemString(1,"color_" + string(lv_counter))

		SELECT GEO_DFLT.USER_ID, GEO_DFLT.CNTL_ID, GEO_DFLT.SEQ_NUM
		INTO :lv_user_id, :lv_cntl_id, :lv_seq_num
		FROM GEO_DFLT
		WHERE GEO_DFLT.USER_ID = Upper( :gc_user_id )
			AND GEO_DFLT.CNTL_ID = Upper( :iv_cntl_id )
			AND GEO_DFLT.SEQ_NUM = :lv_counter
			AND GEO_DFLT.GEO_TYPE = 'P'
		USING stars2ca;

	If temp_from_range = 0 AND temp_to_range = 0 then
		temp_size = 0
		temp_symbol = 0
//		temp_color = '0'			 // KMM 7/8/95 Prob#141
	end if	

		if stars2ca.of_check_status() = 0 Then
			UPDATE GEO_DFLT
       	 SET
         	GEO_DFLT.FROM_NUM    = :temp_from_range,   
         	GEO_DFLT.TO_NUM      = :temp_to_range,   
         	GEO_DFLT.DFLT_SIZE   = :temp_size,   
         	GEO_DFLT.DFLT_COLOR  = :temp_color,   
         	GEO_DFLT.DFLT_SYMB   = :temp_symbol,  
				GEO_DFLT.TOP_NUM     = 0,   
         	GEO_DFLT.BOTTOM_NUM  = 0  
       	WHERE GEO_DFLT.USER_ID = Upper( :gc_user_id )
         	AND GEO_DFLT.CNTL_ID = Upper( :iv_cntl_id )
         	AND GEO_DFLT.SEQ_NUM = :lv_counter  
				AND GEO_DFLT.GEO_TYPE = 'P'
   	 	USING stars2ca ;
	
		elseif stars2ca.sqlcode = 100 Then
		 
			INSERT INTO GEO_DFLT
     		  (GEO_DFLT.USER_ID,
				GEO_DFLT.CNTL_ID, 
				GEO_DFLT.SEQ_NUM,   
       	 	GEO_DFLT.FROM_NUM,   
       	 	GEO_DFLT.TO_NUM,   
        		GEO_DFLT.DFLT_SIZE,   
        		GEO_DFLT.DFLT_COLOR,   
       	 	GEO_DFLT.DFLT_SYMB,   
       	 	GEO_DFLT.TOP_NUM,   
       	 	GEO_DFLT.BOTTOM_NUM,
				GEO_DFLT.GEO_TYPE)  
  			VALUES
     	 	  (:gc_user_id,
			  	:iv_cntl_id,
           	:lv_counter,
           	:temp_from_range,
           	:temp_to_range,
           	:temp_size,
           	:temp_color,
           	:temp_symbol,
			  	:iv_top_num,
           	:iv_bottom_num,  
				'P')
    		USING stars2ca;

		else
			errorbox(stars2ca,'Error reading the Code Table')
			return 
		end if	
NEXT

END IF


lv_col_desc = ddlb_2.text
For lv_counter = 1 to iv_array_count
	if match(upper(iv_map_array[lv_counter,2]),upper(lv_col_desc)) then
		lv_hold_col_name = upper(iv_map_array[lv_counter,1])
		exit
	end if
Next
	
iv_cntl_id = lv_hold_col_name
		
IF Not(ddlb_2.text = "None" OR ddlb_2.text = "") then

FOR lv_counter = 1 to 5	
	temp_from_range = dw_enrollee.GetItemDecimal(1,"from_range_" + string(lv_counter))
	temp_to_range = dw_enrollee.GetItemDecimal(1,"to_range_" + string(lv_counter))
	temp_symbol = dw_enrollee.GetItemNumber(1,"symbol_" + string(lv_counter))
	temp_size = dw_enrollee.GetItemNumber(1,"size_" + string(lv_counter))
	temp_color = dw_enrollee.GetItemString(1,"color_" + string(lv_counter))
 
	SELECT GEO_DFLT.USER_ID, GEO_DFLT.CNTL_ID, GEO_DFLT.SEQ_NUM
	INTO :lv_user_id, :lv_cntl_id, :lv_seq_num
	FROM GEO_DFLT
	WHERE GEO_DFLT.USER_ID = Upper( :gc_user_id )
		AND GEO_DFLT.CNTL_ID = Upper( :iv_cntl_id )
		AND GEO_DFLT.SEQ_NUM = :lv_counter
		AND GEO_DFLT.GEO_TYPE = 'E'	
	USING stars2ca;

	If temp_from_range = 0 AND temp_to_range = 0 then
		temp_size = 0
		temp_symbol = 0
//		temp_color = '0' 		//KMM 7/8/95 Prob#141
	end if

		if stars2ca.of_check_status() = 0 Then
  			UPDATE GEO_DFLT
      	 SET
      		GEO_DFLT.FROM_NUM    = :temp_from_range,   
         	GEO_DFLT.TO_NUM      = :temp_to_range,   
       		GEO_DFLT.DFLT_SIZE   = :temp_size,   
        		GEO_DFLT.DFLT_COLOR  = :temp_color,   
        		GEO_DFLT.DFLT_SYMB   = :temp_symbol,   
        		GEO_DFLT.TOP_NUM     = 0,   
        		GEO_DFLT.BOTTOM_NUM  = 0  
      	WHERE GEO_DFLT.USER_ID = Upper( :gc_user_id )
        		AND GEO_DFLT.CNTL_ID = Upper( :iv_cntl_id )
        		AND GEO_DFLT.SEQ_NUM = :lv_counter
            AND GEO_DFLT.GEO_TYPE = 'E'  
   		USING stars2ca ;
	
 		elseif stars2ca.sqlcode = 100 Then
	
	  		INSERT INTO GEO_DFLT
	     		(GEO_DFLT.USER_ID,
     	   	 GEO_DFLT.CNTL_ID, 
     	   	 GEO_DFLT.SEQ_NUM,   
     	  		 GEO_DFLT.FROM_NUM,   
				 GEO_DFLT.TO_NUM,   
				 GEO_DFLT.DFLT_SIZE,   
     	 		 GEO_DFLT.DFLT_COLOR,   
     	 		 GEO_DFLT.DFLT_SYMB,   
     	  		 GEO_DFLT.TOP_NUM,   
     	  		 GEO_DFLT.BOTTOM_NUM,  
				 GEO_DFLT.GEO_TYPE)
			VALUES
 	 		  (:gc_user_id,
			 	:iv_cntl_id,
       	 	:lv_counter,
       	 	:temp_from_range,
       	 	:temp_to_range,
      	 	:temp_size,
      	 	:temp_color,
       	 	:temp_symbol,
       	 	:iv_top_num,
				:iv_bottom_num,  
				'E')
			USING stars2ca;
		else
			errorbox(stars2ca,'Error reading the Code Table')
			return 
		end if
NEXT

END IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

setmicrohelp(w_main,'Ready')
end event

type cb_reset from u_cb within w_geo_interface
string accessiblename = "Reset"
string accessibledescription = "Reset"
integer x = 2336
integer y = 1308
integer width = 338
integer height = 108
integer taborder = 250
integer weight = 400
string text = "&Reset"
end type

on clicked;integer lv_counter, lv_rc 

setmicrohelp(w_main,'Resetting Legend...') 
setpointer(hourglass!)
dw_provider.setredraw(false)
dw_enrollee.setredraw(false)

if iv_prov_in_dw then
	rb_both_provider.checked = True  
	dw_provider.enabled = False
	rb_prov_selected.enabled = False
	//KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_prov_parm then
		rb_prov_all.enabled = True
		rb_prov_all.checked = True
	end if
	rb_prov_selected.checked = False
	rb_prov_most.checked = False
	rb_prov_least.checked = False
	lv_rc = ddlb_1.finditem("None",1)
	ddlb_1.selectitem(lv_rc)
	dw_provider.Reset()	
	dw_provider_dbf.Reset()
	dw_provider.InsertRow(0)
	For lv_counter = 1 to 25 
		dw_provider.Setitem(1,lv_counter,0)
	Next
   dw_provider.setitem(1,5,'16711680')
//   dw_provider.Modify("color_1"+".color="+"16777215")				KMM 7/8/95 Prob#141
// dw_provider.Modify("color_1"+".background.color="+"16711680")	KMM 7/8/95 Prob#141
   dw_provider.setitem(1,10,'8388608')
//   dw_provider.Modify("color_2"+".color="+"16777215")				KMM 7/8/95 Prob#141
// dw_provider.Modify("color_2"+".background.color="+"8388608")		KMM 7/8/95 Prob#141
   dw_provider.setitem(1,15,'16776960')
// dw_provider.Modify("color_3"+".background.color="+"16776960")	KMM 7/8/95 Prob#141
   dw_provider.setitem(1,20,'8421376')
//   dw_provider.Modify("color_4"+".color="+"16777215")				KMM 7/8/95 Prob#141
// dw_provider.Modify("color_4"+".background.color="+"8421376")		KMM 7/8/95 Prob#141
   dw_provider.setitem(1,25,'32768')
//   dw_provider.Modify("color_5"+".color="+"16777215")				KMM 7/8/95 Prob#141
// dw_provider.Modify("color_5"+".background.color="+"32768")		KMM 7/8/95 Prob#141
else
	rb_both_provider.checked = True
	//KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_prov_parm then
		rb_prov_all.enabled = True
		rb_prov_all.checked = True
	end if
end if



if iv_enrol_in_dw then
	rb_both_enrollee.checked = True   
	dw_enrollee.enabled = false
	rb_enrol_selected.enabled = false
	//KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_enrol_parm then
		rb_enrol_all.enabled = True
		rb_enrol_all.checked = True
	end if
	rb_enrol_selected.checked = false
	rb_enrol_most.checked = false
	rb_enrol_least.checked = false
	lv_rc = ddlb_2.finditem("None",1)
	ddlb_2.selectitem(lv_rc)
	dw_enrollee.Reset()
	dw_enrollee_dbf.Reset()
	dw_enrollee.InsertRow(0)
	For lv_counter = 1 to 25 
		dw_enrollee.Setitem(1,lv_counter,0)
	Next
   dw_enrollee.setitem(1,5,'255')
//   dw_enrollee.Modify("color_1"+".color="+"16777215")					KMM 7/8/95 Prob#141
//   dw_enrollee.Modify("color_1"+".background.color="+"255")			KMM 7/8/95 Prob#141
   dw_enrollee.setitem(1,10,'128')
//   dw_enrollee.Modify("color_2"+".color="+"16777215")					KMM 7/8/95 Prob#141
//   dw_enrollee.Modify("color_2"+".background.color="+"128")			KMM 7/8/95 Prob#141
   dw_enrollee.setitem(1,15,'16711935')
//   dw_enrollee.Modify("color_3"+".color="+"16777215")					KMM 7/8/95 Prob#141
//   dw_enrollee.Modify("color_3"+".background.color="+"16711935")		KMM 7/8/95 Prob#141
   dw_enrollee.setitem(1,20,'12632256')
//   dw_enrollee.Modify("color_4"+".background.color="+"12632256")		KMM 7/8/95 Prob#141
   dw_enrollee.setitem(1,25,'8421504')
//   dw_enrollee.Modify("color_5"+".background.color="+"8421504")		KMM 7/8/95 Prob#141
else
	rb_both_enrollee.checked = True
	//KMM 12/29/94 Checks All Database Records radiobutton if in winparm
	if iv_enrol_parm then
		rb_enrol_all.enabled = True
		rb_enrol_all.checked = True
	end if
end if

rb_prov_most.enabled = True
rb_prov_least.enabled = True
rb_enrol_least.enabled = True
rb_enrol_most.enabled = True

rb_highlighting.checked = True
em_1.text = ''       

dw_control.Reset()
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)
dw_control.InsertRow(0)


dw_provider.setredraw(true)
dw_enrollee.setredraw(true)

setmicrohelp(w_main,'Ready')
end on

type gb_3 from groupbox within w_geo_interface
string accessiblename = "Select Patient Set"
string accessibledescription = "Select Patient Set"
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer y = 1292
integer width = 896
integer height = 256
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Select Patient Set"
end type

type gb_1 from groupbox within w_geo_interface
string accessiblename = "PATIENT"
string accessibledescription = "PATIENT"
accessiblerole accessiblerole = groupingrole!
integer x = 1362
integer y = 12
integer width = 1307
integer height = 1012
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "PATIENT"
end type

type gb_2 from groupbox within w_geo_interface
string accessiblename = "Select Provider Set"
string accessibledescription = "Select Provider Set"
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer y = 1028
integer width = 896
integer height = 256
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Select Provider Set"
end type

type gb_5 from groupbox within w_geo_interface
string accessiblename = "PROVIDER "
string accessibledescription = "PROVIDER "
accessiblerole accessiblerole = groupingrole!
integer x = 46
integer y = 12
integer width = 1307
integer height = 1012
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "PROVIDER "
end type

type gb_4 from groupbox within w_geo_interface
string accessiblename = "Select Which Counties to Highlight"
string accessibledescription = "Select Which Counties to Highlight"
accessiblerole accessiblerole = groupingrole!
integer x = 974
integer y = 1028
integer width = 1271
integer height = 416
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Select Which Counties to Highlight"
end type

