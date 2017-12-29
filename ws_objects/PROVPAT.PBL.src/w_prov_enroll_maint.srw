$PBExportHeader$w_prov_enroll_maint.srw
$PBExportComments$Inherited from w_master
forward
global type w_prov_enroll_maint from w_master
end type
type mle_syntax from multilineedit within w_prov_enroll_maint
end type
type dw_1 from u_dw within w_prov_enroll_maint
end type
type cbx_xref from checkbox within w_prov_enroll_maint
end type
type cb_auth from u_cb within w_prov_enroll_maint
end type
type cb_clear from u_cb within w_prov_enroll_maint
end type
type cb_add from u_cb within w_prov_enroll_maint
end type
type cb_copy from u_cb within w_prov_enroll_maint
end type
type cb_update from u_cb within w_prov_enroll_maint
end type
type cb_retrieve from u_cb within w_prov_enroll_maint
end type
type cb_close from u_cb within w_prov_enroll_maint
end type
end forward

global type w_prov_enroll_maint from w_master
string accessiblename = "Maintain Enrollee Information"
string accessibledescription = "Maintain Enrollee Information"
integer x = 105
integer y = 208
integer width = 3191
integer height = 2092
string title = "Maintain Enrollee Information"
mle_syntax mle_syntax
dw_1 dw_1
cbx_xref cbx_xref
cb_auth cb_auth
cb_clear cb_clear
cb_add cb_add
cb_copy cb_copy
cb_update cb_update
cb_retrieve cb_retrieve
cb_close cb_close
end type
global w_prov_enroll_maint w_prov_enroll_maint

type variables
w_enr_id_xref iv_xref
string iv_recip_id
string iv_dict_info[100,3]
string iv_col_label[]
string iv_col_max_len[]
string iv_col_type[]
string iv_col_min_len[]
string iv_table_type
string in_from
boolean iv_flag = false
boolean iv_xref_flag
end variables

forward prototypes
public function integer wf_edit_medb ()
public function string wf_col_len_validation (string lv_dbname, string lv_min_len, string lv_max_len, string lv_label, string lv_dw_data_type, string lv_type_validation)
public function boolean wf_update ()
end prototypes

public function integer wf_edit_medb ();string lv_temp
integer lv_temp_1, lv_len
datetime lv_temp_2

setpointer(hourglass!)

lv_temp = dw_1.getitemstring(1,'prov_id')
If IsNull(lv_temp) or (trim(lv_temp) = '') then
	SetMicroHelp(w_main,'Processing Cancelled')
	messagebox('ERROR','Provider ID must be entered!',stopsign!,OK!)
	return -1
end if

lv_temp = dw_1.getitemstring(1,'prov_name')
If IsNull(lv_temp) or (trim(lv_temp) = '') then
	SetMicroHelp(w_main,'Processing Cancelled')
	messagebox('ERROR','Provider Name must be entered!',stopsign!,OK!)
	return -2
end if

lv_temp = dw_1.getitemstring(1,'prov_address1')
If IsNull(lv_temp) or (trim(lv_temp) = '') then
	SetMicroHelp(w_main,'Processing Cancelled')
	messagebox('ERROR','Provider Address 1 must be entered!',stopsign!,OK!)
	return -3
end if  

lv_temp = dw_1.getitemstring(1,'prov_city')
If IsNull(lv_temp) or (trim(lv_temp) = '') then
	SetMicroHelp(w_main,'Processing Cancelled')
	messagebox('ERROR','Provider City must be entered!',stopsign!,OK!)
	return -4
end if

lv_temp = trim(upper(dw_1.getitemstring(1,'prov_state')))
If IsNull(lv_temp) or (trim(lv_temp) = '') then
	SetMicroHelp(w_main,'Processing Cancelled')
	messagebox('ERROR','Provider State must be entered!',stopsign!,OK!)
	return -5
else
	if lv_temp = 'AL' or lv_temp = 'AK' or lv_temp = 'AZ' or &
		lv_temp = 'AR' or lv_temp = 'CA' or lv_temp = 'CO' or &
		lv_temp = 'CT' or lv_temp = 'DE' or lv_temp = 'DC' or &
		lv_temp = 'FL' or lv_temp = 'GA' or lv_temp = 'HI' or &
		lv_temp = 'ID' or lv_temp = 'IL' or lv_temp = 'IN' or &
		lv_temp = 'IA' or lv_temp = 'KS' or lv_temp = 'KY' or &
		lv_temp = 'LA' or lv_temp = 'ME' or lv_temp = 'MD' or &
		lv_temp = 'MA' or lv_temp = 'MI' or lv_temp = 'MN' or &
		lv_temp = 'MS' or lv_temp = 'MO' or lv_temp = 'MT' or &
		lv_temp = 'NE' or lv_temp = 'NV' or lv_temp = 'NH' or &
		lv_temp = 'NJ' or lv_temp = 'NM' or lv_temp = 'NY' or &
		lv_temp = 'NC' or lv_temp = 'ND' or lv_temp = 'OH' or &
		lv_temp = 'OK' or lv_temp = 'OR' or lv_temp = 'PA' or &
		lv_temp = 'PR' or lv_temp = 'RI' or lv_temp = 'SC' or &
		lv_temp = 'SD' or lv_temp = 'TN' or lv_temp = 'TX' or &
		lv_temp = 'UT' or lv_temp = 'VT' or lv_temp = 'VI' or &
		lv_temp = 'VA' or lv_temp = 'WA' or lv_temp = 'WV' or &
		lv_temp = 'WI' or lv_temp = 'WY' THEN
		//OK
	else
		messagebox('Validation','State abbreviation is not a valid state.')
		return -5
	end if
end iF

lv_temp = dw_1.getitemstring(1,'prov_zip')
If IsNull(lv_temp) or (trim(lv_temp) = '') then
	SetMicroHelp(w_main,'Processing Cancelled')
	messagebox('ERROR','Provider Zip Code must be entered!',stopsign!,OK!)
	return -6
end if

return 0
end function

public function string wf_col_len_validation (string lv_dbname, string lv_min_len, string lv_max_len, string lv_label, string lv_dw_data_type, string lv_type_validation);//*******************************************************************************
//
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
//
//*******************************************************************************

//  Validate for both min and max lengths, and data type.
setpointer(hourglass!)

string lv_mod_string, lv_dwmrc
string lv_len_mod, lv_type_mod, lv_len_msg, lv_type_msg
string lc_validate
string ls_data_type			// JGG 8/8/97 - contains Uppercase datatype passed as an argument
boolean lv_validate_len, lv_validate_type
long lv_hit
int lv_pos

lv_validate_len = false
lv_validate_type = false
lc_validate = lv_dbname + ".Validation=~'"

//KMM 7/5/95 Prob#5 Added so validation message prints label on one line
if match(lv_label,"~~r") Then
	lv_pos = pos(lv_label,"~~r")
	lv_label = Replace(lv_label,lv_pos,2," ")
end if
if match(lv_label,"~~n") Then
	lv_pos = pos(lv_label,"~~n")
	lv_label = Replace(lv_label,lv_pos,2," ")
end if
//KMM END

//JGG 8/8/97 - Rel 3.5.4 Testing
//             Under PB5, SyntaxFromSql call returns datatype LONG instead of NUMBER for 
//             prov or recip columns defined as INT.  As a result, no match on LONG datatypes
//             results in unknown data type message box.
//             The following code replaced with a choose case statement to eliminate 
//             message box.

//	//  Create Validation for Data Type
//	lv_hit = pos(upper(lv_dw_data_type),'CHAR')
//	if lv_hit > 0 then
//		// no action
//lv_validate_len = true
//lv_validate_type = false
//	else  
//		lv_hit = pos(upper(lv_dw_data_type),'DATETIME')
//		if lv_hit > 0 then
//			lv_type_mod =  " Isdate(gettext()) "
//			lv_type_msg = lv_label + " must be a valid datetime.~rFormat is MM/DD/YY. "
//			lv_validate_type = true
//lv_validate_len = false
//		else
//			lv_hit = pos(upper(lv_dw_data_type),'NUMBER')
//			if lv_hit > 0 then
//				lv_type_mod =  " Isnumber(gettext()) "
//				lv_type_msg = lv_label + " must be a valid number. "
//				lv_validate_type = true
//lv_validate_len = false
//			else
//				lv_hit = pos(upper(lv_dw_data_type),'DECIMAL')
//				if lv_hit > 0 then
//					lv_type_mod =  " Isnumber(gettext()) "
//					lv_type_msg = lv_label + " must be a valid number. "
//					lv_validate_type = true
//lv_validate_len = false
//				else
//					lv_hit = pos(upper(lv_dw_data_type),'TIME')
//					if lv_hit > 0 then
//						lv_type_mod =  " Istime(gettext()) "
//						lv_type_msg = lv_label + " must be a valid time. "
//						lv_validate_type = true
//lv_validate_len = false
//					else
//						lv_hit = pos(upper(lv_dw_data_type),'DATE')
//						if lv_hit > 0 then
//							lv_type_mod =  " Isdate(gettext()) "
//							lv_pos = pos(lv_label,'~r')
//							if lv_pos > 0 then
//								lv_label = left(lv_label, lv_pos - 1) + mid(lv_label, lv_pos + 2)
//							end if
//							lv_type_msg = lv_label + " must be a valid date.~rFormat is MM/DD/YY."
//							lv_validate_type = true
//lv_validate_len = false
//						else
//							messagebox("Unknow PB DW Data Type - " + lv_dw_data_type ,"Column is not copied to new record.")
//lv_validate_len = false
//lv_validate_type = false
//						end if
//					end if
//				end if
//			end if
//		end if
//	end if
//

//Set a local variable to the column data type passed as an argument
lv_pos				=	pos(lv_dw_data_type, '(')
IF lv_pos > 0 THEN
	ls_data_type	=	upper(left(lv_dw_data_type, lv_pos - 1))
ELSE
	ls_data_type	=	upper(lv_dw_data_type)
END IF

//Now test for specific data type values and validate accordingly.
// FDG 12/14/00 - Make the checking of data types DBMS-independent.

//CHOOSE CASE ls_data_type
//	CASE 'CHAR'
//		// no action
//		lv_validate_len 	=	true
//		lv_validate_type 	=	false
//	CASE 'DATETIME','SMALLDATETIME'
//		lv_type_mod 		=	" Isdate(gettext()) "
//		lv_type_msg 		=	lv_label + " must be a valid datetime.~rFormat is MM/DD/YY. "
//		lv_validate_type 	=	true
//		lv_validate_len 	=	false
//	CASE 'NUMBER','LONG','INT','SMALLINT'
//		lv_type_mod 		=	" Isnumber(gettext()) "
//		lv_type_msg 		=	lv_label + " must be a valid number. "
//		lv_validate_type 	=	true
//		lv_validate_len 	=	false
//	CASE 'DECIMAL','MONEY','SMALLMONEY'
//		lv_type_mod 		=  " Isnumber(gettext()) "
//		lv_type_msg 		=	lv_label + " must be a valid number. "
//		lv_validate_type	=	true
//		lv_validate_len	=	false
//	CASE 'TIME'
//		lv_type_mod 		=	" Istime(gettext()) "
//		lv_type_msg			=	lv_label + " must be a valid time. "
//		lv_validate_type	=	true
//		lv_validate_len	=	false
//	CASE 'DATE'
//		lv_type_mod			=	" Isdate(gettext()) "
//		lv_pos				=	pos(lv_label,'~r')
//		if lv_pos > 0 then
//			lv_label			=	left(lv_label, lv_pos - 1) + mid(lv_label, lv_pos + 2)
//		end if
//		lv_type_msg			=	lv_label + " must be a valid date.~rFormat is MM/DD/YY."
//		lv_validate_type	=	true
//		lv_validate_len	=	false
//	CASE ELSE
//		messagebox("Unknow PB DW Data Type - " + lv_dw_data_type ,"Column is not copied to new record.")
//		lv_validate_len	=	false
//		lv_validate_type	=	false
//END CHOOSE

IF gnv_sql.of_is_character_data_type (ls_data_type)		THEN
	// no action
	lv_validate_len 	=	true
	lv_validate_type 	=	false
ELSEIF gnv_sql.of_is_date_data_type (ls_data_type)			THEN
	lv_type_mod 		=	" Isdate(gettext()) "
	lv_type_msg 		=	lv_label + " must be a valid datetime.~rFormat is MM/DD/YY. "
	lv_validate_type 	=	true
	lv_validate_len 	=	false
ELSEIF gnv_sql.of_is_numeric_data_type (ls_data_type)		THEN
	lv_type_mod 		=	" Isnumber(gettext()) "
	lv_type_msg 		=	lv_label + " must be a valid number. "
	lv_validate_type 	=	true
	lv_validate_len 	=	false
ELSEIF ls_data_type	=	'TIME'									THEN
	lv_type_mod 		=	" Istime(gettext()) "
	lv_type_msg			=	lv_label + " must be a valid time. "
	lv_validate_type	=	true
	lv_validate_len	=	false
ELSE
	Messagebox("Unknow PB DW Data Type - " + lv_dw_data_type ,"Column is not copied to new record.")
	lv_validate_len	=	false
	lv_validate_type	=	false
END IF
// FDG 12/14/00 end
// JGG 8/8/97 - End change

if lv_validate_len then 
CHOOSE CASE upper(lv_type_validation) 
	CASE 'MIN'
	if (Isnumber(lv_min_len) and (long(lv_min_len) > 0) ) then
//		lv_mod_string = lv_dbname + ".Validation=~'len(gettext()) >= " + lv_min_len + "~'"
		lv_len_mod = "len(gettext()) >= " + lv_min_len 
//		lv_dwmrc = dw_1.Modify(lv_mod_string)

//		lv_mod_string = lv_dbname + ".ValidationMsg=~'" + lv_label + " must be at least " + lv_min_len +  " in length ~'"
		lv_len_msg = lv_label + " must be at least " + lv_min_len +  " in length "
//		lv_dwmrc = dw_1.Modify(lv_mod_string)
		lv_validate_len = true
	end if
		
	CASE 'MAX'
	if (Isnumber(lv_max_len) and (long(lv_max_len) >= 0 )) then
//		lv_mod_string = lv_dbname + ".Validation=~'len(gettext()) >= " + lv_max_len + "~'"
		lv_len_mod = "len(gettext()) >= " + lv_max_len 
//		lv_dwmrc = dw_1.Modify(lv_mod_string)

//		lv_mod_string = lv_dbname + ".ValidationMsg=~'" + lv_label + " must be no more than " + lv_max_len +  " in length ~'"
		lv_len_msg = lv_label + " must be no more than " + lv_max_len +  " in length "
//		lv_dwmrc = dw_1.Modify(lv_mod_string)
		lv_validate_len = true
	end if

	CASE 'BOTH'
	if ((Isnumber(lv_min_len) and long(lv_min_len) > 0) and (Isnumber(lv_max_len) and (long(lv_max_len) >= long(lv_min_len)))) then
//		lv_mod_string = lv_dbname + ".Validation=~'len(gettext()) >= " + lv_min_len + " and len(gettext()) <= " + lv_max_len + "~'"
		lv_len_mod = "len(gettext()) >= " + lv_min_len + " and len(gettext()) <= " + lv_max_len 
//		lv_dwmrc = dw_1.Modify(lv_mod_string)

//		lv_mod_string = lv_dbname + ".ValidationMsg=~'" + lv_label + " must be at least " + lv_min_len +  " in length, but no more than " + lv_max_len + " in length.~'"
		lv_len_msg = lv_label + " must be at least " + lv_min_len +  " in length, but no more than " + lv_max_len + " in length. "
//		lv_dwmrc = dw_1.Modify(lv_mod_string)
		lv_validate_len = true
	end if

	CASE ELSE
		//  Unexpected parameter.  No validation performed.
		MessageBox("Unexpected Validation parameter.","No column length validation performed on " + lv_dbname + ".")
		lv_dwmrc = lv_dbname
END CHOOSE
end if 


//  Create Validate= and ValidationMsg= parameters.
if lv_validate_len then
	if lv_validate_type then
		//  Both Length and Data type validations
		lv_mod_string = lv_dbname + ".Validation=~'" + lv_len_mod + " and " + lv_type_mod + " ~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)

		lv_mod_string = lv_dbname + ".ValidationMsg=~'" + lv_len_msg + " and " + lv_type_msg + " ~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	else
		//  Validation length only
		lv_mod_string = lv_dbname + ".Validation=~'" + lv_len_mod + " ~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)

		lv_mod_string = lv_dbname + ".ValidationMsg=~'" + lv_len_msg + " ~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	end if
else
	//  Validate Type only
	if lv_validate_type then
		lv_mod_string = lv_dbname + ".Validation=~'" + lv_type_mod + " ~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)

		lv_mod_string = lv_dbname + ".ValidationMsg=~'" + lv_type_msg + " ~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	else
		//  No validation required.
	end if
end if


return lv_dwmrc
end function

public function boolean wf_update ();//  wf_update in w_generic_maint
integer rc

setpointer(hourglass!)
rc=SetTransObject(DW_1,stars2ca)
if rc<>1 then
	messagebox('Error','Error setting transaction object',StopSign!)
	RETURN(false)
end if

rc=dw_1.EVENT ue_update( TRUE, TRUE )
if rc<>1 then
	SetMicroHelp(w_main,'Error...')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return FALSE
	End If	
	messagebox('Error','Error updating the Patient table',StopSign!)
	RETURN(false)
end if

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return FALSE
End If	
return(true)
end function

event open;call super::open;//  Open event for w_prov_enroll_maint
//
//************************************************************************
//
//	FDG	05/03/96	Prob 212 - GEO_X was inserted into ENROLLEE_INFO as a
//						null.  Don't remove GEO_X & GEO_Y, but protect it
//						and set it to 0 when inserting.
//						Also converted Date_death from a date format to a
//						datetime format.
//	FDG	01/20/98	Stars 4.0 - Use the query engine service
//	FDG	11/06/98	Stars 4.0 (Track 1944).  Fix a PB 6.5 problem where setting
//						autosize = Yes messes up the ability to scroll.
// KTB   01/03/00 FS/TS2584 Starcare Track 2584. Make sure 'NOTOT'
//                does not appear as the actual value for GEO_X & GEO_Y.
//	FDG	12/14/00	Stars 4.7.	Mak data type checking DBMS-independent
// FDG	02/20/01	Stars 4.7.  Use of_connect() in case an alter session command is needed
//	GaryR 07/25/01	Track 2362d	Case sensitivity and data trimming
// 10/25/04 MikeF	SPR 3650d Replaced local SQL w/ gnv_dict calls
// 11/11/04	MikeF	SPR4108d	Replaced global function with dw format service
// 01/06/05 MikeF SPR4205d	Must register dw w/ format service
// 10/02/07	Katie	SPR 5180	Trim id before saving back to screen.
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//************************************************************************

string lv_recip_rid, lv_sel, lv_syntax, lv_prov_id
string lv_table_name, lv_sql_cols, lv_sql_from
string lv_style, lv_color, lv_error, lv_cname
string lv_dbname, ls_rc, lv_title
string lv_init_value,  lv_dwmrc, lv_mod_string
string lv_debug, lv_dw_data_type
string lv_label, lv_max_len, lv_data_type, lv_min_len,lv_edit_mask,lv_value_a
long lc_font_weight = 700
//  -10 is font height in points; positive number is in window units.  Always use points.
long lc_font_height = -10
long lv_col, lv_num_of_col, lv_count, lv_position, lv_dict_ct
integer li_x, lv_tab_set, rcint,lv_pos,temp_auth
string lv_col_x, lv_col_y
long lv_col_x_moved, lv_col_y_moved
long lc_col_move = 700, lc_col_width = 500, lc_col_height = 50, ll_pos
string lv_first, lv_second
Date		ld_date
n_cst_dw_format	lnv_format
n_cst_string		lnv_string

SetMicroHelp(W_Main,'Now Creating the Maintenance Window, please stand by...')
setpointer(hourglass!)
in_from = gv_from

//	FDG	07/31/97 -	Don't execute the CloseQuery logic
ib_disableclosequery	=	TRUE

This.of_set_queryengine (TRUE)			// FDG 01/20/98
lv_recip_rid = gv_prov_id
ll_pos = Pos(lv_recip_rid,' - ')
if (ll_pos > 0) then
	lv_recip_rid = (left(lv_recip_rid, ll_pos - 1))
end if

//This retrieves the table that the data is going to be retrieved from
lv_table_name = gnv_dict.event ue_get_table_name( iv_table_type )

if lv_table_name = gnv_dict.ics_not_found Then
	MessageBox("ERROR",'No TB Record found in Dictionary for Table Type - ' + iv_table_type )
	return
elseif lv_table_name = gnv_dict.ics_error Then 
	MessageBox("ERROR",'Error reading the dictionary table for TB record')
	return
end if

select cntl_no into :iv_xref_flag from sys_cntl
	where cntl_id='EN_XREF'
	using stars2ca;
	
//sqlcode=100 is ok, just assume it's not available
if stars2ca.of_check_status() <> 0 and stars2ca.sqlcode<>100 Then
	errorbox(stars2ca,'Error reading sys_cntl for en_xref entry')
	return
end if

lv_sql_from = ' FROM ' + lv_table_name

//  String the columns together for the SELECT statement
lv_sql_cols = gnv_dict.uf_get_select_all(iv_table_type, TRUE)
lv_sel = 'SELECT ' + lv_sql_cols + lv_sql_from + ' ' + iv_table_type

//  units = 0=Powerbuilder, 1=display pixels, 2=one thousandth of inch
lv_style = ' datawindow(units=2)' + ' Text(Background.Mode = 1) ' + ' style(type = Form) '

//  Create the Maintenance DW
lv_syntax = SyntaxFromSQL(stars2ca,lv_sel,lv_style,lv_error)
if lv_error <> '' then
   messagebox('Error Returned From Create.',lv_error)
   cb_close.TriggerEvent(Clicked!)
   return
end if

rcint = dw_1.Create(lv_syntax)
if rcint <= 0 then
   messagebox('ERROR','Error creating datawindow')
   cb_close.TriggerEvent(Clicked!)
   return
end if

if iv_table_type = 'EI' then
	lv_title = "PATIENT DETAILS"
else
	lv_title = "PROVIDER DETAILS"
end if

w_prov_enroll_maint.title = lv_title
w_prov_enroll_maint.AccessibleName = lv_title
w_prov_enroll_maint.AccessibleDescription = lv_title

// Add Header
lnv_format.event ue_register_dw(dw_1)
lnv_format.uf_add_generic_title(lv_title)

// FDG 11/06/98 - Set Autosize to 'No' (from 'Yes') to fix PB 6.5 scrolling
lv_mod_string = "Datawindow.Detail.Height.AutoSize=No"
lv_dwmrc = dw_1.Modify(lv_mod_string)

lv_mod_string = "Datawindow.Table.UpdateTable=~'" + lv_table_name + "~'"
lv_dwmrc = dw_1.Modify(lv_mod_string)

lv_mod_string = "Datawindow.Table.UpdateWhere=1"
lv_dwmrc = dw_1.Modify(lv_mod_string)

lv_mod_string = "Datawindow.Table.UpdateKeyInPlace=no"
lv_dwmrc = dw_1.Modify(lv_mod_string)

	// FDG 05/03/96	Protect GEO_X & GEO_Y from being updated.
lv_mod_string = "GEO_X.Protect=1 GEO_Y.Protect=1"
lv_dwmrc = dw_1.Modify(lv_mod_string)

//  Correctly format each column in the DW
lv_num_of_col = long(dw_1.Describe('datawindow.column.count'))
lv_col = 0

lv_tab_set = 0
for lv_col = 1 to lv_num_of_col
	lv_tab_set = lv_tab_set + 5
	lv_dbname =	Upper( dw_1.Describe('#'+string(lv_col)+'.dbname') )
	lv_position = pos(lv_dbname,'.')
	if lv_position > 0 then
		lv_dbname = mid(lv_dbname,lv_position + 1)
	end if	

	lv_label 		= gnv_dict.event ue_get_elem_label			(iv_table_type, lv_dbname)
	lv_max_len		= string(gnv_dict.event ue_get_data_len  	(iv_table_type, lv_dbname))
	lv_data_type	= gnv_dict.event ue_get_elem_data_type 	(iv_table_type, lv_dbname)
	lv_min_len		= string(gnv_dict.event ue_get_min_length	(iv_table_type, lv_dbname))
	lv_edit_mask	= gnv_dict.event ue_get_edit_mask			(iv_table_type, lv_dbname)
	lv_value_a		= gnv_dict.event ue_get_value_a				(iv_table_type, lv_dbname)

	if lv_label = gnv_dict.ics_not_found Then
		//	Set Accessibility Properties
		lv_mod_string = lv_dbname + ".AccessibleRole='27' "	//	ColumnRole!
		lv_mod_string += lv_dbname + "_t.AccessibleRole='42' "	//	TextRole!
		lv_dwmrc = dw_1.Modify(lv_mod_string)
		
		continue
	elseif lv_label = gnv_dict.ics_error  Then
		MessageBox("ERROR","Error reading Dictionary - where elem_type='CL' and elem_tbl_type='"+iv_table_type+"' and elem_name='"+lv_dbname+"'")
		return
	end if
	
	//	GaryR 07/25/01	Track 2362d - Begin
	lv_label 		=	Trim( lv_label )
	lv_max_len 		=	Trim( lv_max_len )
	lv_data_type	=	Trim( lv_data_type )
	lv_min_len		=	Trim( lv_min_len )
	lv_edit_mask	=	Trim( lv_edit_mask )
	lv_value_a		=	Trim( lv_value_a )
	//	GaryR 07/25/01	Track 2362d - End
	
	IF gnv_sql.of_is_money_data_type (lv_data_type)		THEN
		Setformat(dw_1,lv_col,'#,##0.00')
		lv_init_value = '0'
	ELSEIF gnv_sql.of_is_date_data_type (lv_data_type)		THEN
		Setformat(dw_1,lv_col,'mm/dd/yyyy')
		lv_init_value = '01/01/1900'
	ELSE
		lv_init_value = ' '
	END IF
	// FDG 12/14/00 end

	lv_mod_string = lv_dbname + "_t.Background.Mode=~'1~'"
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	//KMM 8/14/95 STARS STANDARDS: Required field text is black and all others are blue
	if lv_dbname = 'PROV_ID' or lv_dbname = 'PROV_NAME' or lv_dbname = 'PROV_ADDRESS1' or lv_dbname = 'PROV_CITY'			&
	or lv_dbname = 'PROV_STATE' or lv_dbname = 'PROV_ZIP' or lv_dbname = 'RECIP_RID' or lv_dbname = 'PATIENT_NAME' 		&
	or lv_dbname = 'SSN' or lv_dbname = 'SEX' or lv_dbname = 'STATE' then
		lv_mod_string = lv_dbname + "_t.Color=" + String( stars_colors.window_text )
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	else
		lv_mod_string = lv_dbname + "_t.Color=" + String( stars_colors.highlight )
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	end if
	
	lv_mod_string = lv_dbname + ".Initial=~'" + lv_init_value + "~'"
	lv_dwmrc = dw_1.Modify(lv_mod_string)

   //ktb - 1-03-00 - Added the AND statement to check if edit_mask is not 
	//                equal to 'NOTOT'
	
	if (lv_edit_mask<>'') AND (Upper(lv_edit_mask) <> 'NOTOT') then
		lv_mod_string = lv_dbname + ".EditMask.Mask=~'" + lv_edit_mask + "~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	end if

	if upper(lv_value_a)='NOEDIT' then
		dw_1.settaborder(lv_dbname,0)
		lv_mod_string = lv_dbname + ".Border=~'6~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)
		lv_mod_string = lv_dbname + ".Background.Color=~'" + &
											String(stars_colors.button_face) + "~'"
		lv_dwmrc = dw_1.Modify(lv_mod_string)
	else
		dw_1.settaborder(lv_col,lv_tab_set)
	end if 

	lv_dw_data_type =	dw_1.Describe(lv_dbname + '.ColType')
	if isnull(lv_min_len) then
		if isnull(lv_max_len) then
			//  no validation performed
		else
			//  validate max len only	
			lv_dwmrc = wf_col_len_validation(lv_dbname, lv_min_len, lv_max_len, lv_label, lv_dw_data_type,'MAX')
			if lv_dwmrc <> '' then  Messagebox("MAX len validation failed.","Column name is " + lv_dbname)
		end if
	else
		if isnull(lv_max_len) then
			//  validate min len only
			lv_dwmrc = wf_col_len_validation(lv_dbname, lv_min_len, lv_max_len, lv_label, lv_dw_data_type,'MIN')
			if lv_dwmrc <> '' then  Messagebox("MIN len validation failed.","Column name is " + lv_dbname)
		else
			//  validate both min and max len
			lv_dwmrc = wf_col_len_validation(lv_dbname, lv_min_len, lv_max_len, lv_label, lv_dw_data_type,'BOTH')
			if lv_dwmrc <> '' then  Messagebox("MIN/MAX length failed during Validation.","Column name is " + lv_dbname)
		end if 
	end if 


	//  Column width
	lv_mod_string = lv_dbname + ".width"
	lv_col_x = dw_1.Describe(lv_mod_string)
	lv_col_x_moved = long(lv_col_x) + lc_col_width

	lv_mod_string = lv_dbname + ".width=" + string(lv_col_x_moved)
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	//  Column Header width
	lv_mod_string = lv_dbname + "_t.width"
	lv_col_x = dw_1.Describe(lv_mod_string)
	lv_col_x_moved = long(lv_col_x) + lc_col_width

	lv_mod_string = lv_dbname + "_t.width=" + string(lv_col_x_moved)
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	//	 Column Header height
	lv_mod_string = lv_dbname + "_t.height"
	lv_col_y = dw_1.Describe(lv_mod_string)
	lv_col_y_moved = long(lv_col_y) + lc_col_height

	lv_mod_string = lv_dbname + "_t.height=" + string(lv_col_y_moved)
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	//  Column starting location
	lv_mod_string = lv_dbname + ".X"
	lv_col_x = dw_1.Describe(lv_mod_string)
	lv_col_x_moved = long(lv_col_x) + lc_col_move + lc_col_width

	lv_mod_string = lv_dbname + ".X=" + string(lv_col_x_moved)
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	//  Column Header starting location
	lv_mod_string = lv_dbname + "_t.X"
	lv_col_x = dw_1.Describe(lv_mod_string)
	lv_col_x_moved = long(lv_col_x) + lc_col_move

	lv_mod_string = lv_dbname + "_t.X=" + string(lv_col_x_moved)
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	lv_mod_string = lv_dbname + ".Update=Yes"
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	lv_mod_string = lv_dbname + ".Border='2'"
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	lv_mod_string = lv_dbname + ".Edit.Limit= " + lv_max_len 
	lv_dwmrc = dw_1.Modify(lv_mod_string)

	lv_dwmrc = dw_1.Modify(lv_dbname+".font.Height=~'" + string(lc_font_height) + "~'")
	lv_dwmrc = dw_1.Modify(lv_dbname+".font.Weight=~'" + string(lc_font_weight) + "~'")
	lv_dwmrc = dw_1.Modify(lv_dbname+".font.Face='System'")

	lv_dwmrc = dw_1.Modify(lv_dbname+"_t.font.Height=~'" + string(lc_font_height) + "~'")
	lv_dwmrc = dw_1.Modify(lv_dbname+"_t.font.Weight=~'" + string(lc_font_weight) + "~'")
	lv_dwmrc = dw_1.Modify(lv_dbname+"_t.font.Face='System'")

	if match(lv_label,"~~r") Then
		lv_pos = pos(lv_label,"~~r")
		lv_label = Replace(lv_label,lv_pos,2," ")
	end if
	if match(lv_label,"~~n") Then
		lv_pos = pos(lv_label,"~~n")
		lv_label = Replace(lv_label,lv_pos,2," ")
	end if

	lv_mod_string = lv_dbname + "_t.text=" + "'" + lv_label + "'"
	lv_dwmrc = dw_1.Modify(lv_mod_string)
	
	//	Set Accessibility Properties
	lv_label = lnv_string.of_clean_string_acc( lv_label )
	lv_label = '"' + lv_label + '"~t"' + lv_label + '"'
	lv_mod_string = lv_dbname + ".AccessibleName='" + lv_label + "' "
	lv_mod_string += lv_dbname + ".AccessibleDescription='" + lv_label + "' "
	lv_mod_string += lv_dbname + ".AccessibleRole='27' "	//	ColumnRole!
	lv_mod_string += lv_dbname + "_t.AccessibleName='" + lv_label + "' "
	lv_mod_string += lv_dbname + "_t.AccessibleDescription='" + lv_label + "' "
	lv_mod_string += lv_dbname + "_t.AccessibleRole='42' "	//	TextRole!
	lv_dwmrc = dw_1.Modify(lv_mod_string)
next

//  Clipboard causes GPF if over 32K
clipboard('')
clipboard(mid(lv_debug,1,30000))

// Check to see if authorizations are available
if gv_sys_dflt<>'MC' then
	cb_auth.hide()
else
	select count(*) into :temp_auth from stars_win_parm
	 where cntl_id='XJOIN' and sys_id='*' and win_id='*'
	 and site_id='PR' and tbl_type='PA'
	 using stars2ca;
	Stars2ca.of_check_status() 
	if temp_auth=0 then 
		cb_auth.hide()
	ELSE
		// Added 1/23/98 FDG (Stars 4.0)
		Select Count(*) into :temp_auth from stars_rel
		 Where id_2 = 'PA'
		 Using Stars2ca;
		Stars2ca.of_check_status() 
		IF	temp_auth = 0		THEN
			cb_auth.hide()
		END IF
	END IF
end if

//DJP 7/17/95 - Sys_cntl'ed xref
if not iv_xref_flag or iv_table_type<>'EI' then cbx_xref.hide()
dw_1.insertrow(0)
//  in_from = 'A' when coming from 'ADD' button on the List window, or 'NEW' from the menu
if UPPER(in_from) = 'A' Then
	dw_1.settaborder(1,5) 
	if iv_table_type = 'EI' then
		dw_1.setcolumn('recip_rid')
		this.title = 'Patient Add'
		ld_date	=	Date ('6/6/2079')							//	FDG 5/3/96
		dw_1.setitem(1,'date_death',datetime(ld_date))	// FDG 5/3/96
	else
		dw_1.setcolumn('prov_id')
		this.title = 'Provider Add'
	end if
	dw_1.setfocus()
	cb_add.default = TRUE
	cb_Update.enabled = FALSE
else
	//  Coming from the SELECT button on the list window, or from Lookup windows.
	if iv_table_type = 'EI' then
		dw_1.setcolumn('recip_rid')
		this.title = 'Patient Add'
		dw_1.setitem(1,'recip_rid',lv_recip_rid)
	else
		dw_1.setcolumn('prov_id')
		this.title = 'Provider Add'
		dw_1.setitem(1,'prov_id',gv_prov_id)
		dw_1.setitem(1,'prov_upin',gv_prov_upin)
	end if
	TriggerEvent(CB_Retrieve,Clicked!)
end if

if (upper(in_from) = "LOOKUP") OR (upper(in_from) = "TRACK-MAINT") then
	dw_1.setitem(1,1,lv_recip_rid)
   w_prov_enroll_maint.title = lv_title
	cb_retrieve.hide()
	cb_update.hide()
	cb_add.hide()
	cb_copy.hide()
	cb_clear.hide()
	cb_close.default = TRUE
	setfocus(cb_close)
	for li_x=1 to integer(dw_1.Describe('datawindow.column.count'))
		dw_1.settaborder(li_x,0)
	next
end if	

SetMicroHelp(W_Main,'Ready')


end event

on w_prov_enroll_maint.create
int iCurrent
call super::create
this.mle_syntax=create mle_syntax
this.dw_1=create dw_1
this.cbx_xref=create cbx_xref
this.cb_auth=create cb_auth
this.cb_clear=create cb_clear
this.cb_add=create cb_add
this.cb_copy=create cb_copy
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_syntax
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cbx_xref
this.Control[iCurrent+4]=this.cb_auth
this.Control[iCurrent+5]=this.cb_clear
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_copy
this.Control[iCurrent+8]=this.cb_update
this.Control[iCurrent+9]=this.cb_retrieve
this.Control[iCurrent+10]=this.cb_close
end on

on w_prov_enroll_maint.destroy
call super::destroy
destroy(this.mle_syntax)
destroy(this.dw_1)
destroy(this.cbx_xref)
destroy(this.cb_auth)
destroy(this.cb_clear)
destroy(this.cb_add)
destroy(this.cb_copy)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_close)
end on

event ue_preopen;call super::ue_preopen;iv_table_type = message.stringparm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

end event

type mle_syntax from multilineedit within w_prov_enroll_maint
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "-1"
accessiblerole accessiblerole = textrole!
integer x = 1193
integer y = 1028
integer width = 1385
integer height = 260
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from u_dw within w_prov_enroll_maint
event fixdate pbm_custom01
string accessiblename = "Provider Maintenance"
string accessibledescription = "-1"
integer x = 41
integer y = 36
integer width = 3049
integer height = 1788
integer taborder = 10
boolean vscrollbar = true
end type

on fixdate;int lv_rc
string lv_init_value

//lv_init_value = '09/09/99'
//DJP 8/1/95 prob#826 
lv_init_value = '01/01/1900'
lv_rc = dw_1.settext(lv_init_value)
dw_1.accepttext()
end on

event itemchanged;// AJS   01/14/99 FS2033c Y2K change mm/dd/yy to mm/dd/yyyy
//	FDG	12/14/00	Stars 4.7.  Make data type checking DBMS-independent
int lv_col
string lv_col_name, lv_col_text, lv_data_type
string lv_mod_string, lv_init_value, lv_dwmrc, lv_dbname
int lv_position, lv_rc

lv_col = dw_1.getcolumn()
lv_dbname =	dw_1.Describe('#'+string(lv_col)+'.dbname')
lv_position = pos(lv_dbname,'.')

if lv_position > 0 then
	lv_dbname = mid(lv_dbname,lv_position + 1)
end if	

lv_col_name = 	dw_1.Describe('#'+string(lv_col)+'.name')
lv_data_type = upper(dw_1.describe(lv_col_name +'.coltype'))
lv_col_text = dw_1.gettext()

// FDG 12/14/00 - Make the checking of data types DBMS-independent.
//if lv_data_type = 'DATE' or lv_data_type = 'DATETIME' or lv_data_type = 'SMALLDATETIME' then	
IF gnv_sql.of_is_date_data_type (lv_data_type)		THEN
	if lv_col_text = '' or lv_col_text = ' ' or IsNull(lv_col_text) then
		Setformat(dw_1,lv_col,'mm/dd/yyyy')
//		lv_init_value = '09/09/99'
//DJP 8/1/95 prob#826 
		lv_init_value = '01/01/1900'
		dw_1.setitem(1,lv_col,lv_init_value)
		lv_rc = dw_1.settext(lv_init_value)
//		this.postevent('fixdate')
		lv_mod_string = lv_dbname + ".Initial=~'" + lv_init_value + "~'"
//		lv_dwmrc = dw_1.Modify(lv_mod_string)
		Return 2
	end if
end if
end event

event sqlpreview;string lv_sql
lv_sql = sqlsyntax
lv_sql=lv_sql
end event

event itemerror;int lv_col
string lv_col_name, lv_col_text

lv_col = dw_1.getcolumn()
lv_col_name = dw_1.describe('#'+string(lv_col)+'.Name') 
lv_col_text = dw_1.gettext()
if upper(lv_col_name) <> 'PROV_ID' AND upper(lv_col_name) <> 'PROV_NAME' AND        &
   upper(lv_col_name) <> 'PROV_ADDRESS1' AND upper(lv_col_name) <> 'PROV_CITY' AND  &
   upper(lv_col_name) <> 'PROV_STATE' AND upper(lv_col_name) <> 'PROV_ZIP' AND      &
   upper(lv_col_name) <> 'RECIP_RID' AND upper(lv_col_name) <> 'PATIENT_NAME' AND      &
	upper(lv_col_name) <> 'SSN' AND upper(lv_col_name) <> 'SEX' then
	if trim(lv_col_text) = '' then
		Return 2
	end if
else
	Return 0
end if


end event

type cbx_xref from checkbox within w_prov_enroll_maint
string accessiblename = "Patient ID"
string accessibledescription = "Patient IDs"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 46
integer y = 1868
integer width = 453
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Patient ID~'s"
end type

on clicked;//  CLICKED EVENT FOR CBX.XREF  IN W_PROV_ENROLL_MAINT

setpointer(hourglass!)
if dw_1.accepttext()=-1 then return
if this.checked = TRUE Then
	openwithparm(iv_xref,dw_1.getitemstring(1,1),parent)
elseif this.checked = FALSE Then
	close(iv_xref)
end if


end on

type cb_auth from u_cb within w_prov_enroll_maint
string accessiblename = "Auths"
string accessibledescription = "Auths..."
integer x = 727
integer y = 1860
integer width = 325
integer height = 112
integer taborder = 30
integer weight = 400
boolean enabled = false
string text = "Au&ths..."
end type

event clicked;// clicked event for cb_auth in w_generic_maint
//
//This copies the enrollee to the temp table and goes on 
//to detail front end for drilldown
//
//	FDG	1/20/98	Stars 4.0 - Open query engin window
//	01/29/02	LahuS	Track 2552d	Predefined Report (PDR)

String	ls_authorization_id

Long		ll_row

IF dw_1.accepttext()=-1 then 
	return
END IF

w_main.setmicrohelp('Opening Query Engine window...')

setpointer(hourglass!)

//	Clear out parms to query engine
inv_queryengine.uf_clear_query_parms()

//	Get the authorization id (recip_rid or prov_id) from the datawindow
ll_row	=	dw_1.GetRow()

If iv_table_type = 'EI' then
	//	Patient (enrollee)
	ls_authorization_id	=	'RPA' + dw_1.object.recip_rid [ll_row]
Else
	//	Provider
	ls_authorization_id	=	'PPA' + dw_1.object.prov_id [ll_row]
End If

inv_queryengine.uf_set_authorization_id (ls_authorization_id)

//	01/29/02	Lahu S	Track 2552d
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Open the query engine window
inv_queryengine.uf_open_query_engine()
end event

on getfocus;//setmicrohelp(w_main,'Proceeds to authorization drilldown')

end on

type cb_clear from u_cb within w_prov_enroll_maint
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 2441
integer y = 1860
integer width = 325
integer height = 112
integer taborder = 80
integer weight = 400
string text = "C&lear"
end type

on clicked;//  clicked event for cb_clear  -  w_generic_maint

SetMicroHelp(w_main,'Now Clearing All fields')

dw_1.enabled=true
dw_1.setredraw(false)
dw_1.reset()
dw_1.insertrow(0)
dw_1.settaborder(1,10)

if iv_table_type = 'EI' then
	//  Enrollee clears
//DJP 7/17/95 - Sys_cntl'ed xref
	if iv_xref_flag then
		cbx_xref.checked = false
		cbx_xref.triggerevent(clicked!)
		cbx_xref.enabled = false
	end if
	parent.title='Patient Add'
	dw_1.setcolumn('recip_rid')
else
	//  Provider clears
	parent.title='Provider Add'
	dw_1.settaborder(2,20)
	dw_1.setcolumn('prov_id')
	cbx_xref.hide()
end if	

dw_1.setredraw(true)
dw_1.setfocus()
cb_update.enabled   = FALSE
cb_add.enabled      = TRUE
cb_add.default      = True
cb_auth.enabled     = false
cb_retrieve.enabled = TRUE
cb_copy.enabled     = false

SetMicroHelp(w_main,'Ready')


end on

on getfocus;//setmicrohelp(w_main,'Clears all info')

end on

type cb_add from u_cb within w_prov_enroll_maint
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 1755
integer y = 1860
integer width = 325
integer height = 112
integer taborder = 60
integer weight = 400
string text = "Cr&eate"
end type

event clicked;//  clicked event for cb_create  in w_generic_maint
//
//************************************************************************
//
//	FDG	05/03/96	Prob 212 - Move 0 to GEO_X and GEO_Y because it cannot
//						accept nulls.
//						Changed maximum date from 6/1/2079 to 6/6/2079
// MVR   11/07/97 Added max date to provider par and term dates
//	GaryR	09/18/06	Track 4683	Dynamically set the transaction of ENROLLEE_XREF table
//************************************************************************

string recip_rid,recip,lv_recip_id,sql_syntax,temp
boolean rc
string lv_prov_id, lv_prov
integer lv_rc
//boolean rc
datetime temp_date, date1, date2
date lv_date
string y_pos,modstring
n_tr	ltr_xref
n_cst_provpat	lnv_provpat

if dw_1.accepttext()=-1 then return
setpointer(hourglass!)

dw_1.setitem(1,'GEO_X',0)						// FDG 05/03/96
dw_1.setitem(1,'GEO_Y',0)						// FDG 05/03/96


if iv_table_type = 'EI' then
	//  Enrollee Processing
	w_main.setmicrohelp('Adding patient...')

	recip_rid=dw_1.getitemstring(1,'recip_rid')
	if isnull(recip_rid) or trim(recip_rid) = '' then
		messagebox('Error','Patient RID must be entered',exclamation!)
		dw_1.setfocus()
		dw_1.setcolumn('recip_rid')
		w_main.setmicrohelp('Ready')
		return
	end if
	select recip_rid into :recip from enrollee_info
		where recip_rid = Upper( :recip_rid )
		using stars2ca;

	//  No Record Found, so we can add this as a new one.
	if stars2ca.of_check_status()=100 then
		temp = dw_1.getitemstring(1,'patient_name')
		if isnull(temp) or trim(temp) = '' then
			messagebox('Error','Patient Name must be entered',exclamation!)
			dw_1.setfocus()
			dw_1.setcolumn('patient_name')
			w_main.setmicrohelp('Ready')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			return
		end if

		temp=dw_1.getitemstring(1,'ssn')
		if isnull(temp) or trim(temp) = '' then
			messagebox('Error','Patient SSN must be entered',exclamation!)
			dw_1.setfocus()
			dw_1.setcolumn('ssn')
			w_main.setmicrohelp('Ready')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			return
		end if

		temp=dw_1.getitemstring(1,'sex')
		if isnull(temp) or trim(temp) = '' then
			messagebox('Error','Patient sex must be entered',exclamation!)
			dw_1.setfocus()
			dw_1.setcolumn('sex')
			w_main.setmicrohelp('Ready')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			return
		end if
	
		//dw_1.setitem(1,'update_date',today())
		dw_1.setitem(1,'update_date',gnv_app.of_get_server_date())//ts2020c use server date

		temp = trim(upper(dw_1.getitemstring(1,'state')))
		if isnull(temp) or trim(temp)='' then
			messagebox('Error','State must be entered',exclamation!)
			Y_pos = dw_1.describe('state.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('state')
			return 
		elseif temp = 'AL' or temp = 'AK' or temp = 'AZ' or &
			temp = 'AR' or temp = 'CA' or temp = 'CO' or &
			temp = 'CT' or temp = 'DE' or temp = 'DC' or &
			temp = 'FL' or temp = 'GA' or temp = 'HI' or &
			temp = 'ID' or temp = 'IL' or temp = 'IN' or &
			temp = 'IA' or temp = 'KS' or temp = 'KY' or &
			temp = 'LA' or temp = 'ME' or temp = 'MD' or &
			temp = 'MA' or temp = 'MI' or temp = 'MN' or &
			temp = 'MS' or temp = 'MO' or temp = 'MT' or &
			temp = 'NE' or temp = 'NV' or temp = 'NH' or &
			temp = 'NJ' or temp = 'NM' or temp = 'NY' or &
			temp = 'NC' or temp = 'ND' or temp = 'OH' or &
			temp = 'OK' or temp = 'OR' or temp = 'PA' or &
			temp = 'PR' or temp = 'RI' or temp = 'SC' or &
			temp = 'SD' or temp = 'TN' or temp = 'TX' or &
			temp = 'UT' or temp = 'VT' or temp = 'VI' or &
			temp = 'VA' or temp = 'WA' or temp = 'WV' or &
			temp = 'WI' or temp = 'WY' THEN
			//OK
		else
			messagebox('Validation','State abbreviation is not a valid state.')
			Y_pos = dw_1.describe('state.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('state')
			return 
		end if

		date1 = datetime(date("1900/01/01"))
// FDG 05/03/96 - Last date is 6/6/2079 (not 6/1/2079)
		date2 = datetime(date("2079/06/06"))
		temp_date = dw_1.getitemdatetime(1,'date_birth')
//KMM 5-22-95 Added code to check if date birth is updated
		lv_date = date(temp_date)
//		if lv_date = date('09/09/99') then
//DJP 8/1/95 prob#826
		if lv_date = date('01/01/1900') then
			lv_rc = messagebox('Warning','Date Birth has not been updated.  Would you like to update this field?',Question!,YESNO!,2)
			if lv_rc = 1 then
				Y_pos = dw_1.describe('date_birth.y')
				modstring = 'datawindow.verticalscrollposition=' + y_pos
				dw_1.modify(modstring)
				dw_1.setfocus()
				dw_1.setcolumn('date_birth')
				return
			end if
		end if
//KMM END	
		if temp_date < date1 or temp_date > date2 then
			messagebox('Error', 'Date Birth year must be between 1900 and 2079 to be valid.')
			Y_pos = dw_1.describe('date_birth.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)			
			dw_1.setfocus()
			dw_1.setcolumn('date_birth')
			return
		end if

		temp_date = dw_1.getitemdatetime(1,'date_death')
		if temp_date < date1 or temp_date > date2 then
			messagebox('Error', 'Date Death year must be between 1900 and 2079 to be valid.')
			Y_pos = dw_1.describe('date_death.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('date_death')
			return
		end if


		//  Now must assign a RECIP_ID to the enrollee
//DJP 7/17/95 - Sys_cntl'ed xref
		if iv_xref_flag then
			open(w_enroll_id)
			if isnull(message.stringparm) or message.stringparm='' then
				messagebox('Error','Could not read Patient ID.  Patient record not added.',stopsign!)
				w_main.setmicrohelp('Ready')
				return
			else
				lv_recip_id = message.stringparm
				//KMM Clear out message parm (PB Bug)
				SetNull(message.stringparm)
			end if
		end if

		//  Use update function to add enrollee to Enrollee_Info table
		rc=wf_update()
		if not rc then return
	
		//  Now add Recip_Id to Enrollee_xref table
//DJP 7/17/95 - Sys_cntl'ed xref
		if iv_xref_flag then
			IF lnv_provpat.of_get_xref_trans( ltr_xref ) <> 1 THEN Return
	 		sql_syntax="insert into enrollee_xref values ('"+lv_recip_id+"','"+dw_1.getitemstring(1,'recip_rid')+"')"
			execute immediate :sql_syntax using ltr_xref;
			if ltr_xref.of_check_status() <> 0 then 
				MessageBox("ERROR",'Could not insert into the enrollee xref table!')
			elseif ltr_xref.sqlcode = 0 then
				//  Found Recip_RID already on the Enrollee_Info table.  Can't re-add it; can only retrieve and update it.
				//DJP 8/8/95 prob#925
				if messagebox('Duplicate Patient RID','Patient RID '+recip+' already exists. Do you want to retrieve it?',question!,yesno!)=1 then
					cb_retrieve.postevent(clicked!)
				else
					Y_pos = dw_1.describe('recip_rid.y')
					modstring = 'datawindow.verticalscrollposition=' + y_pos
					dw_1.modify(modstring)
					dw_1.setfocus()
					dw_1.setcolumn('recip_rid')
					
					If ltr_xref.of_commit() <> 0 Then
						Messagebox('EDIT','Error Commiting XREF Insert')
						Return
					End If	
					return
				end if
			end if	
		end if
//DJP 7/31/95 prob - this elseif wasn't copied when this window was created
	elseif stars2ca.sqlcode=0 then
		if messagebox('Duplicate Recip RID','Recip RID '+recip+' already exists. Do you want to retrieve it?',question!,yesno!)=1 then
			cb_retrieve.postevent(clicked!)
		else
			return
		end if
	else
		errorbox(stars2ca,'SQL Error')
	end if


	cbx_xref.enabled=true
	dw_1.settaborder(1,0)

else

	// Provider Processing
	w_main.setmicrohelp('Adding new provider...')
	lv_prov_id = dw_1.getitemstring(1,'prov_id')

	If trim(lv_prov_id) = '' or IsNull(lv_prov_id) then
		messagebox('ERROR','Provider ID must be entered!',stopsign!,OK!)
		Y_pos = dw_1.describe('prov_id.y')
		modstring = 'datawindow.verticalscrollposition=' + y_pos
		dw_1.modify(modstring)
		dw_1.setfocus()
		dw_1.setcolumn('prov_id')
		w_main.SetMicroHelp('Ready')
		return 
	end if

	If len(lv_prov_id) < 4 then
		messagebox( 'ERROR','Provider ID must be at least 4 characters!',stopsign!,OK!)
		Y_pos = dw_1.describe('prov_id.y')
		modstring = 'datawindow.verticalscrollposition=' + y_pos
		dw_1.modify(modstring)
		dw_1.setfocus()
		dw_1.setcolumn('prov_id')
		w_main.setmicrohelp('Ready')
		return
	End if

	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	select prov_id into :lv_prov from providers
	where prov_id = Upper( :lv_prov_id )
	using stars2ca;

	if stars2ca.of_check_status() = 100 then
		//  Provider is not on file.  Prepare to add it.
		lv_rc = wf_edit_medb()
		CHOOSE CASE lv_rc
		CASE -1
			Y_pos = dw_1.describe('prov_id.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_id')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			w_main.setmicrohelp('Ready') 
			return
		CASE -2
			Y_pos = dw_1.describe('prov_name.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_name')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			w_main.setmicrohelp('Ready')
			return
		CASE -3
			Y_pos = dw_1.describe('prov_address1.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_address1')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			w_main.setmicrohelp('Ready')
			return
		CASE -4
			Y_pos = dw_1.describe('prov_city.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_city')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			w_main.setmicrohelp('Ready')
			return
		CASE -5
			Y_pos = dw_1.describe('prov_state.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_state')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			w_main.setmicrohelp('Ready')
			return
		CASE -6	
			Y_pos = dw_1.describe('prov_zip.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_zip')
			COMMIT using STARS2CA;
			If stars2ca.of_check_status() <> 0 Then
				Messagebox('EDIT','Error Commiting to Stars2')
				Return
			End If	
			w_main.setmicrohelp('Ready')
			return
		END CHOOSE

		date1 = datetime(date("1900/01/01"))
//MVR 11/07/97 - Date2 is 6/6/2079 (not 6/1/2079)
//		date2 = datetime(date("2079/06/01"))
		date2 = datetime(date("2079/06/06"))

		temp_date = dw_1.getitemdatetime(1,'prov_par_date')
//KMM 5-22-95 Added code to check if prov a term date and prov par date were updated

		lv_date = date(temp_date)
//		if lv_date = date('09/09/99') then
//DJP 8/1/95 prob#826
		if lv_date = date('01/01/1900') then
			lv_rc = messagebox('Warning','Par Date has not been updated.  Would you like to update this field?',Question!,YESNO!,2)
			if lv_rc = 1 then
				Y_pos = dw_1.describe('prov_par_date.y')
				modstring = 'datawindow.verticalscrollposition=' + y_pos
				dw_1.modify(modstring)
				dw_1.setfocus()
				dw_1.setcolumn('prov_par_date')
				return
			end if
		end if
//KMM END	
		if temp_date < date1 or temp_date > date2 then
			messagebox('Error', 'Par Date year must be between 1900 and 2079 to be valid.')
			return
			Y_pos = dw_1.describe('prov_par_date.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_par_date')
			return
		end if

		temp_date = dw_1.getitemdatetime(1,'prov_a_term_date')
//KMM 5-22-95 Added code to check if prov a term date and prov par date were updated
		lv_date = date(temp_date)
//		if lv_date = date('09/09/99') then
//DJP 8/1/95 prob#826
		if lv_date = date('01/01/1900') then
			lv_rc = messagebox('Warning','Term Date has not been updated.  Would you like to update this field?',Question!,YESNO!,2)
			if lv_rc = 1 then
				Y_pos = dw_1.describe('prov_a_term_date.y')
				modstring = 'datawindow.verticalscrollposition=' + y_pos
				dw_1.modify(modstring)
				dw_1.setfocus()
				dw_1.setcolumn('prov_a_term_date')
				return
			end if
		end if
//KMM END	
		if temp_date < date1 or temp_date > date2 then
			messagebox('Error', 'Term Date year must be between 1900 and 2079 to be valid.')
			Y_pos = dw_1.describe('prov_a_term_date.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_a_term_date')
			return
		end if

		//  Use update to add Provider to Providers Table
		rc = wf_update()
		if not rc then return
	elseif stars2ca.sqlcode=0 then
		if messagebox('Duplicate Prov ID','Prov ID '+lv_prov+' already exists. Do you want to retrieve it?',question!,yesno!)=1 then
			cb_retrieve.postevent(clicked!)
		else
			return
		end if
//DJP 7/31/95 prob#925 - this elseif wasn't copied when this window was created
	elseif stars2ca.sqlcode=0 then
		if messagebox('Duplicate Prov ID','Prov ID '+lv_prov+' already exists. Do you want to retrieve it?',question!,yesno!)=1 then
			cb_retrieve.postevent(clicked!)
		else
			return
		end if
	else
		errorbox(stars2ca,'SQL Error')
	end if


	dw_1.settaborder(1,0)
	dw_1.settaborder(2,0)

end if

//------------------------------------------------------------------

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
w_main.setmicrohelp('Ready')

cb_add.default    = false
cb_add.enabled    = false
cb_clear.default  = true
cb_update.enabled = true
cb_copy.enabled   = true
cb_auth.enabled   = true
iv_flag = false

SetMicroHelp(w_main,'Ready')
end event

on getfocus;//setmicrohelp(w_main,'Creates the new patient')
 
end on

type cb_copy from u_cb within w_prov_enroll_maint
string accessiblename = "Copy"
string accessibledescription = "Copy"
integer x = 2098
integer y = 1856
integer width = 325
integer height = 112
integer taborder = 70
integer weight = 400
boolean enabled = false
string text = "C&opy"
end type

event clicked;//  clicked event for cb_copy  -  w_generic_maint
//john-wo 10/22/97 prob 67 of rel 3.6 - prov_bed_count has a data type of long.
//         I put in a check for long.  Spec 206 for 3.6 release.
long lv_num_of_col, lv_col, lv_position, lv_hit
string lv_dbname, lv_data_type

cb_retrieve.enabled = TRUE
cb_add.enabled      = TRUE
cb_update.enabled   = FALSE
cb_auth.enabled     = FALSE

//DJP 7/17/95 - Sys_cntl'ed xref
if iv_xref_flag then
	cbx_xref.checked = FALSE
	cbx_xref.triggerevent(clicked!)
	cbx_xref.enabled = FALSE
end if

//  Correctly format each column in the DW
lv_num_of_col = long(dw_1.Describe('datawindow.column.count'))
lv_col = 0
dw_1.insertrow(1)


//  Copy each field from row 1 into the new, blank row 2.
for lv_col = 1 to lv_num_of_col
//	lv_tab_set = lv_tab_set + 5
	lv_dbname =	dw_1.Describe('#'+string(lv_col)+'.dbname')
	lv_position = pos(lv_dbname,'.')
	if lv_position > 0 then
		lv_dbname = mid(lv_dbname,lv_position + 1)
	end if
	lv_data_type =	dw_1.Describe(lv_dbname + '.ColType')
	

	lv_hit = pos(upper(lv_data_type),'CHAR')
	if lv_hit > 0 then
		dw_1.setitem(1,lv_col,dw_1.getitemstring(2,lv_col))
	else  
		lv_hit = pos(upper(lv_data_type),'DATETIME')
		if lv_hit > 0 then
			dw_1.setitem(1,lv_col,dw_1.getitemdatetime(2,lv_col))
		else
			lv_hit = pos(upper(lv_data_type),'NUMBER')
			if lv_hit > 0 then
				dw_1.setitem(1,lv_col,dw_1.getitemnumber(2,lv_col))
			else
				lv_hit = pos(upper(lv_data_type),'DECIMAL')
				if lv_hit > 0 then
					dw_1.setitem(1,lv_col,dw_1.getitemdecimal(2,lv_col))
				else
					lv_hit = pos(upper(lv_data_type),'TIME')
					if lv_hit > 0 then
						dw_1.setitem(1,lv_col,dw_1.getitemtime(2,lv_col))
					else
						lv_hit = pos(upper(lv_data_type),'DATE')
						if lv_hit > 0 then
							dw_1.setitem(1,lv_col,dw_1.getitemdate(2,lv_col))
						else
							lv_hit = pos(upper(lv_data_type),'LONG') //john-wo 10/22/97	
							if lv_hit > 0 then //john-wo 10/22/97	
								dw_1.setitem(1,lv_col,dw_1.getitemnumber(2,lv_col)) //john-wo 10/22/97	
							else //john-wo 10/22/97	
								messagebox("Unknown PB DW Data Type - " + lv_data_type ,"Column is not copied to new record.")
							end if //john-wo 10/22/97	
						end if
					end if
				end if
			end if
		end if
	end if

next


//  why is this row commented out??   update date?
//dw_1.setitem(1,31,dw_1.getitemdatetime(2,31))

dw_1.setrow(1)
dw_1.settaborder(1,5)
dw_1.setcolumn(1)
dw_1.setfocus()
cb_add.default = TRUE
setmicrohelp(w_main,'Ready')

//  why not delete row 2 after the copy is done???????


end event

on getfocus;//setmicrohelp(w_main,'Copies info to another record')

end on

type cb_update from u_cb within w_prov_enroll_maint
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 1413
integer y = 1860
integer width = 325
integer height = 112
integer taborder = 50
integer weight = 400
boolean enabled = false
string text = "&Update"
end type

event clicked;//  clicked event for cb_update  w_generic_maint

boolean rc
int lv_rc
datetime temp_date, date1, date2
date lv_date
string y_pos, modstring
string temp, lv_temp

if dw_1.accepttext() = -1 then return

setpointer(hourglass!)

if iv_table_type = 'EI' then
	setmicrohelp(w_main,'Updating the Patient table...')
	temp = dw_1.getitemstring(1,'patient_name')
		if isnull(temp) or trim(temp) = '' then
			messagebox('Error','Patient Name must be entered',exclamation!)
			Y_pos = dw_1.describe('patient_name.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('patient_name')
			w_main.setmicrohelp('Ready')
			return
		end if

		temp=dw_1.getitemstring(1,'ssn')
		if isnull(temp) or trim(temp) = '' then
			messagebox('Error','Patient SSN must be entered',exclamation!)
			Y_pos = dw_1.describe('ssn.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('ssn')
			w_main.setmicrohelp('Ready')
			return
		end if

		temp=dw_1.getitemstring(1,'sex')
		if isnull(temp) or trim(temp) = '' then
			messagebox('Error','Patient sex must be entered',exclamation!)
			Y_pos = dw_1.describe('sex.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('sex')
			w_main.setmicrohelp('Ready')
			return
		end if
	
		//dw_1.setitem(1,'update_date',today())
		dw_1.setitem(1,'update_date',gnv_app.of_get_server_date())//ts2020c use server date

		lv_temp = trim(upper(dw_1.getitemstring(1,'state')))
		if not isnull(lv_temp) or lv_temp <> '' or lv_temp <> ' ' then
			if lv_temp = 'AL' or lv_temp = 'AK' or lv_temp = 'AZ' or &
				lv_temp = 'AR' or lv_temp = 'CA' or lv_temp = 'CO' or &
				lv_temp = 'CT' or lv_temp = 'DE' or lv_temp = 'DC' or &
				lv_temp = 'FL' or lv_temp = 'GA' or lv_temp = 'HI' or &
				lv_temp = 'ID' or lv_temp = 'IL' or lv_temp = 'IN' or &
				lv_temp = 'IA' or lv_temp = 'KS' or lv_temp = 'KY' or &
				lv_temp = 'LA' or lv_temp = 'ME' or lv_temp = 'MD' or &
				lv_temp = 'MA' or lv_temp = 'MI' or lv_temp = 'MN' or &
				lv_temp = 'MS' or lv_temp = 'MO' or lv_temp = 'MT' or &
				lv_temp = 'NE' or lv_temp = 'NV' or lv_temp = 'NH' or &
				lv_temp = 'NJ' or lv_temp = 'NM' or lv_temp = 'NY' or &
				lv_temp = 'NC' or lv_temp = 'ND' or lv_temp = 'OH' or &
				lv_temp = 'OK' or lv_temp = 'OR' or lv_temp = 'PA' or &
				lv_temp = 'PR' or lv_temp = 'RI' or lv_temp = 'SC' or &
				lv_temp = 'SD' or lv_temp = 'TN' or lv_temp = 'TX' or &
				lv_temp = 'UT' or lv_temp = 'VT' or lv_temp = 'VI' or &
				lv_temp = 'VA' or lv_temp = 'WA' or lv_temp = 'WV' or &
				lv_temp = 'WI' or lv_temp = 'WY' THEN
				//OK
			else
				messagebox('Validation','State abbreviation is not a valid state.')
				Y_pos = dw_1.describe('state.y')
				modstring = 'datawindow.verticalscrollposition=' + y_pos
				dw_1.modify(modstring)
				dw_1.setfocus()
				dw_1.setcolumn('state')
				return 
			end if
		end if
	
		date1 = datetime(date("1900/01/01"))
		date2 = datetime(date("2079/06/01"))
		temp_date = dw_1.getitemdatetime(1,'date_birth')
//KMM 5-22-95 Added code to check if date birth is updated
		lv_date = date(temp_date)
//		if lv_date = date('09/09/99') then
//DJP 8/1/95 prob#826
		if lv_date = date('01/01/1900') then
			lv_rc = messagebox('Warning','Date Birth has not been updated.  Would you like to update this field?',Question!,YESNO!,2)
			if lv_rc = 1 then
				Y_pos = dw_1.describe('birth_date.y')
				modstring = 'datawindow.verticalscrollposition=' + y_pos
				dw_1.modify(modstring)
				dw_1.setfocus()
				dw_1.setcolumn('date_birth')
				return
			end if
		end if
//KMM END	
		if temp_date < date1 or temp_date > date2 then
			messagebox('Error', 'Date Birth year must be between 1900 and 2079 to be valid.')
			Y_pos = dw_1.describe('date_birth.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('date_birth')
			return
		end if

		temp_date = dw_1.getitemdatetime(1,'date_death')
		if temp_date < date1 or temp_date > date2 then
			messagebox('Error', 'Date Death year must be between 1900 and 2079 to be valid.')
			Y_pos = dw_1.describe('date_death.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('date_death')
			return
		end if
else
	setmicrohelp(w_main,'Updating the Provider table...')

	lv_rc = wf_edit_medb()
	CHOOSE CASE lv_rc
		CASE -1
			Y_pos = dw_1.describe('prov_id.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_id')
			w_main.setmicrohelp('Ready')
			return
		CASE -2
			Y_pos = dw_1.describe('prov_name.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_name')
			w_main.setmicrohelp('Ready')
			return
		CASE -3
			Y_pos = dw_1.describe('prov_address1.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_address1')
			w_main.setmicrohelp('Ready')
			return
		CASE -4
			Y_pos = dw_1.describe('prov_city.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_city')
			w_main.setmicrohelp('Ready')
			return
		CASE -5
			Y_pos = dw_1.describe('prov_state.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_state')
			w_main.setmicrohelp('Ready')
			return
		CASE -6	
			Y_pos = dw_1.describe('prov_zip.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_zip')
			w_main.setmicrohelp('Ready')
			return
		END CHOOSE

	date1 = datetime(date("1900/01/01"))
	date2 = datetime(date("2079/06/01"))
	
	temp_date = dw_1.getitemdatetime(1,'prov_par_date')
//KMM 5-22-95
	lv_date = date(temp_date)
//	if lv_date = date('09/09/99') then
//DJP 8/1/95 prob#826
	if lv_date = date('01/01/1900') then
		lv_rc = messagebox('Warning','Par Date has not been updated.  Would you like to update this field?',Question!,YESNO!,2)
		if lv_rc = 1 then
			Y_pos = dw_1.describe('prov_par_date.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_par_date')
			return
		end if
	end if
//KMM END
	if temp_date < date1 or temp_date > date2 then
		messagebox('Error', 'Par Date year must be between 1900 and 2079 to be valid.')
		Y_pos = dw_1.describe('prov_par_date.y')
		modstring = 'datawindow.verticalscrollposition=' + y_pos
		dw_1.modify(modstring)
		dw_1.setfocus()
		dw_1.setcolumn('prov_par_date')
		return
	end if

		temp_date = dw_1.getitemdatetime(1,'prov_a_term_date')
//KMM 5-22-95 Added code to check if prov a term date and prov par date were updated
	lv_date = date(temp_date)
//	if lv_date = date('09/09/99') then
//DJP 8/1/95 prob#826
	if lv_date = date('01/01/1900') then
		lv_rc = messagebox('Warning','Term Date has not been updated.  Would you like to update this field?',Question!,YESNO!,2)
		if lv_rc = 1 then
			Y_pos = dw_1.describe('prov_a_term_date.y')
			modstring = 'datawindow.verticalscrollposition=' + y_pos
			dw_1.modify(modstring)
			dw_1.setfocus()
			dw_1.setcolumn('prov_a_term_date')
			return
		end if
	end if
//KMM END	
	if temp_date < date1 or temp_date > date2 then
		messagebox('Error', 'Term Date year must be between 1900 and 2079 to be valid.')
		Y_pos = dw_1.describe('prov_a_term_date.y')
		modstring = 'datawindow.verticalscrollposition=' + y_pos
		dw_1.modify(modstring)
		dw_1.setfocus()
		dw_1.setcolumn('prov_a_term_date')
		return
	end if
end if


rc=wf_update()
if not rc then return

setmicrohelp(w_main,'Ready')
cb_update.default=false
cb_close.default=true

end event

on getfocus;//setmicrohelp(w_main,'Makes entered changes to patient')

end on

type cb_retrieve from u_cb within w_prov_enroll_maint
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 1070
integer y = 1860
integer width = 325
integer height = 112
integer taborder = 40
integer weight = 400
string text = "&Retrieve"
boolean default = true
end type

event clicked;//  clicked event for cb_retrieve 
//	09/26/2007	Katie	SPR 5180	Trimmed key for Provider Detail if passed a decoded value.  
//											Save new key back to datawindow after retrieval to eliminate decoded value being carried over.
//	10/02/2007	Katie	SPR 5180	Trim Recip_Id also if being passed a decoded value.

int rc,lv_num_rows
datetime lv_par_date
string lv_where
string lv_key,lv_select_stmt,lv_modify_select,stringrc
string lv_debug
long lv_where_pos, ll_pos

if dw_1.accepttext()=-1 then return

if iv_table_type = 'EI' then
	//  Enrollee Maintenance
	lv_key = dw_1.getitemstring(1,'recip_rid')
	ll_pos = Pos(lv_key,' - ')
	if (ll_pos > 0) then
		lv_key = (left(lv_key, ll_pos - 1))
	end if
	if trim(lv_key) = '' or isnull(lv_key) then
		messagebox("Error","Patient RID must be entered",exclamation!)
		dw_1.setfocus()
		dw_1.setcolumn('recip_rid')
		RETURN
	end if
	SetPointer(hourglass!)
	SetMicroHelp(w_main,'Retrieving record from Patient Table')	  
	if in_from <> 'lookup' then parent.title='Patient Details'
	lv_where = " where recip_rid = ~'" + Upper( lv_key ) + "~'"
else
	if iv_table_type = 'PV' then
		//  Provider Maintenance
		lv_key = dw_1.getitemstring(1,'prov_id')
		ll_pos = Pos(lv_key,' - ')
		if (ll_pos > 0) then
			lv_key = (left(lv_key, ll_pos - 1))
		end if
		if trim(lv_key) = '' or isnull(lv_key) then
			messagebox("Error","Prov ID must be entered",exclamation!)
			dw_1.setfocus()
			dw_1.setcolumn('prov_id')
			cb_copy.enabled=true
			RETURN
		end if
		SetPointer(hourglass!)
		SetMicroHelp(w_main,'Retrieving record from Provider Table')
		if in_from <> 'lookup' then parent.title='Provider Details'
		lv_where = " where prov_id = ~'" + Upper( lv_key ) + "~'"
	else
		messagebox("Error","An unknown Table Type of "  +  iv_table_type + " was encountered.  Maintenance window only set up to handle Providers or Enrollees.  Processing cannot continue.",stopsign!)
		dw_1.setfocus()
		dw_1.setcolumn(1)
		return
	end if
end if

//sqlcmd('Connect', stars2ca,'Error Connecting to the database',5)     PLB 10/20/95
//Reset(DW_1)
SetTransObject(DW_1,stars2ca)

lv_select_stmt = UPPER(dw_1.getsqlselect())
lv_where_pos = pos(upper(lv_select_stmt),'WHERE')
if lv_where_pos > 0 then
	//  Replace existing Where clause
	lv_select_stmt = left(lv_select_stmt, lv_where_pos - 1) + ' ' + lv_where
else
	lv_select_stmt = lv_select_stmt + ' ' + lv_where
end if

lv_modify_select = 'datawindow.table.select = "' + lv_select_stmt +  '"'
stringrc = dw_1.Modify(lv_modify_select)
if stringrc <> '' then
	messagebox("An Unknown Error with the Retrieve SQL",stringrc + " Processing cannot continue.",stopsign!)
	dw_1.setfocus()
	dw_1.setcolumn(1)
	RETURN
end if

lv_num_rows = Retrieve(dw_1)

if gc_debug_mode then
	lv_debug = dw_1.Describe("datawindow.syntax")
	mle_syntax.show()
	mle_syntax.text = ''
	mle_syntax.text = lv_debug
end if

If lv_num_rows = 0 Then
	SetMicroHelp(w_main,'Record Not found')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	messagebox('Record Not Found','Selection not found, Cannot be retrieved',StopSign!)
	cb_clear.triggerevent(clicked!)

	if iv_table_type = 'EI' then
		dw_1.setitem(1,'recip_rid',lv_key)
	else
		dw_1.setitem(1,'prov_id',lv_key)
	end if
	RETURN

elseif lv_num_rows < 0 then
   setmicrohelp(w_main,'Error...')
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	

	if iv_table_type = 'EI' then
		messagebox('Error', 'Error retrieving from Enrollee Table')	
		cb_clear.triggerevent(clicked!)
		dw_1.setitem(1,'recip_rid',lv_key)
	else
		messagebox('Error', 'Error retrieving from Provider Table')	
		cb_clear.triggerevent(clicked!)
		dw_1.setitem(1,'prov_id',lv_key)
	end if
	RETURN
end if 
		
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

if iv_table_type = 'EI' then
	cb_add.enabled = FALSE
	cb_retrieve.enabled = FALSE
	cb_update.enabled = TRUE
	cb_update.default = TRUE
	cb_auth.enabled=true
	cb_copy.enabled=true
	cbx_xref.enabled=true
	dw_1.settaborder(1,0)
else
	cb_add.enabled = FALSE
	cb_retrieve.enabled = FALSE
	cb_update.enabled = TRUE
	cb_update.default = TRUE
	cb_auth.enabled=true
	cb_copy.enabled=true
	dw_1.settaborder(1,0)
end if


SetMicroHelp(w_main,'Ready')
end event

on getfocus;//setmicrohelp(w_main,'Retrieves patient')

end on

type cb_close from u_cb within w_prov_enroll_maint
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2784
integer y = 1860
integer width = 325
integer height = 112
integer taborder = 90
integer weight = 400
string text = "&Close"
end type

on clicked;setmicrohelp(w_main,'Ready')
close(parent)
end on

on getfocus;//setmicrohelp(w_main,'Exits Patient Maintenance')

end on

