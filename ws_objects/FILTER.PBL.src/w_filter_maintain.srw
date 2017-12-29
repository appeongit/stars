$PBExportHeader$w_filter_maintain.srw
$PBExportComments$Inherited from w_master
forward
global type w_filter_maintain from w_master
end type
type pb_delete from u_cb within w_filter_maintain
end type
type pb_insert from u_cb within w_filter_maintain
end type
type cb_export from u_cb within w_filter_maintain
end type
type cb_import from u_cb within w_filter_maintain
end type
type cbx_selectall from checkbox within w_filter_maintain
end type
type cbx_retrieve_desc from checkbox within w_filter_maintain
end type
type st_row_count from statictext within w_filter_maintain
end type
type st_5 from statictext within w_filter_maintain
end type
type ddlb_data_types from dropdownlistbox within w_filter_maintain
end type
type cb_copy from u_cb within w_filter_maintain
end type
type cb_clear from u_cb within w_filter_maintain
end type
type sle_filter_val from singlelineedit within w_filter_maintain
end type
type dw_2 from u_dw within w_filter_maintain
end type
type st_4 from statictext within w_filter_maintain
end type
type st_3 from statictext within w_filter_maintain
end type
type st_2 from statictext within w_filter_maintain
end type
type st_1 from statictext within w_filter_maintain
end type
type sle_datetime from singlelineedit within w_filter_maintain
end type
type sle_description from singlelineedit within w_filter_maintain
end type
type sle_column from singlelineedit within w_filter_maintain
end type
type sle_filter_id from singlelineedit within w_filter_maintain
end type
type cb_close from u_cb within w_filter_maintain
end type
type cb_retrieve from u_cb within w_filter_maintain
end type
type cb_update from u_cb within w_filter_maintain
end type
type cb_create from u_cb within w_filter_maintain
end type
type gb_1 from groupbox within w_filter_maintain
end type
type gb_2 from groupbox within w_filter_maintain
end type
type dw_1 from u_dw within w_filter_maintain
end type
end forward

global type w_filter_maintain from w_master
string accessiblename = "Filter Add"
string accessibledescription = "Filter Add"
integer x = 64
integer y = 132
integer width = 3561
integer height = 2280
string title = "Filter Add"
event type integer ue_import_insert_item ( string as_data_type,  string as_filter_val )
event type long ue_import_remove_dupes ( string as_datatype )
pb_delete pb_delete
pb_insert pb_insert
cb_export cb_export
cb_import cb_import
cbx_selectall cbx_selectall
cbx_retrieve_desc cbx_retrieve_desc
st_row_count st_row_count
st_5 st_5
ddlb_data_types ddlb_data_types
cb_copy cb_copy
cb_clear cb_clear
sle_filter_val sle_filter_val
dw_2 dw_2
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_datetime sle_datetime
sle_description sle_description
sle_column sle_column
sle_filter_id sle_filter_id
cb_close cb_close
cb_retrieve cb_retrieve
cb_update cb_update
cb_create cb_create
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
end type
global w_filter_maintain w_filter_maintain

type variables
constant string is_filter_column_name = 'FILTER_DATA'

long 		in_highlighted_rows
boolean 	iv_from_copy = false
string 	is_user_id, is_lookup
integer	ii_data_len				
Boolean	ib_exists				

sx_filter_data ix_filter_data

n_cst_filter in_cst_filter


end variables

forward prototypes
public subroutine of_setdataobject (string as_data_type)
public function integer wf_validate_and_insert (string as_data_type, string as_input_val, boolean ab_import)
public function integer wf_retrieve_data ()
end prototypes

event type integer ue_import_insert_item(string as_data_type, string as_filter_val);//*********************************************************************************
// Script Name:	ue_import_insert_item
//
//	Arguments:		1.	as_data_type - datatype of value about to be inserted
//						2.	as_filter_val - the filter value to be inserted
//
// Returns:			Integer.
//						 0 =	Success
//						-1	=	Error
//
//	Description:	This event is called from cb_import.clicked.
//						For importing filters, it replaces the call to wf_validate_and_insert.
//						It checks for valid data and inserts into dw_2.
//
//*********************************************************************************
//	
// 03/28/00 NLG	Stars 4.5	Created
//	10/16/01	GaryR	Track	2485d	Trim excess spaces
//	01/29/03	GaryR	Track 4705c	Expand string filter limit to 255
//	10/04/05	GaryR	Track 4524d	Convert manual filter values to upper case
// 07/28/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
//*********************************************************************************

boolean		lb_time_exists

int			li_rc,					&
				li_max_len,				&
				li_pos

decimal{2}	ld_val,					&
				ld_hi_val = +922337203685477.58

string 		ls_char,					&
				ls_data_type,			&
				ls_input_val,			&
				ls_filter_val,			&
				ls_filter_time
long			ll_item_num,			&
				ll_row,					&
				ll_val,					&
				ll_hi_val = +2147483647
decimal{2}	ld_item_decimal
datetime		ldt_item_date

ls_data_type = as_data_type
ls_input_val = Trim( as_filter_val )	//	10/16/01	GaryR	Track	2485d

ll_row = dw_2.InsertRow(0)	//NLG 4-7-00

CHOOSE CASE ls_data_type
	CASE 'CHAR'
		li_max_len		=	255
		IF	ii_data_len	>	0						THEN
			// ii_data_len is computed from dictionary (based on filter_tbl_type & filter_col)
			li_max_len	=	ii_data_len
		END IF
		
		IF Len( ls_input_val ) > li_max_len THEN
			return -1
		END IF

		//ll_row = dw_2.InsertRow(0)	//NLG 4-7-00
	   dw_2.SetItem(ll_row,is_filter_column_name,Upper(ls_input_val))
		li_rc = dw_2.AcceptText()
		IF li_rc < 0 THEN
			return -1
		END IF
		//
	CASE 'NUMBER', 'MONEY'
		IF NOT isnumber(ls_input_val) THEN
			return -1
		END IF

		IF ls_data_type = 'NUMBER' THEN
			//NUMBER data type field validation routine
			
			//now check for value out of range of valid values for this data type 
			ll_val = abs(long(ls_input_val))
			IF ll_val > ll_hi_val THEN
				return -1
			END IF
			
			ll_item_num = long(ls_input_val)
			//ll_row = dw_2.InsertRow(0)	//NLG 4-7-00
	   	dw_2.SetItem(ll_row,is_filter_column_name,ll_item_num)
			li_rc = dw_2.AcceptText()
			IF li_rc < 0 THEN
				return -1
			END IF
		ELSE
			//MONEY data type field validation routine
			
			//now check for value out of range of valid values for this data type 
			ld_val = abs(dec(ls_input_val))
			IF ld_val > ld_hi_val THEN
				return -1
			END IF
			ld_item_decimal = dec(ls_input_val)
			
			//ll_row = dw_2.InsertRow(0)  //NLG 4-7-00
	   	dw_2.SetItem(ll_row,is_filter_column_name,ld_item_decimal)
			li_rc = dw_2.AcceptText()
			IF li_rc < 0 THEN
				return -1
			END IF
		END IF
		
	CASE 'DATE'
		
		li_pos = pos(trim(ls_input_val),' ')
		
		IF li_pos > 0 THEN
			lb_time_exists = true
			ls_filter_val 	= trim(left(ls_input_val,li_pos - 1))
			ls_filter_time = trim(mid(ls_input_val,li_pos + 1))
			IF NOT isdate(ls_filter_val) THEN
				return -1
			END IF
			
			IF NOT istime(ls_filter_time) THEN
				return -1
			END IF
		ELSE
			IF NOT isdate(ls_input_val) THEN
				return -1
			END IF
		END IF
		
		if lb_time_exists then																	
			ldt_item_date = datetime(date(ls_filter_val),time(ls_filter_time))
			//ll_row = dw_2.InsertRow(0)			//NLG 4-7-00
   		dw_2.SetItem(ll_row,is_filter_column_name,ldt_item_date)    						
		else
	   	ldt_item_date = datetime(date(ls_input_val))
			//ll_row = dw_2.InsertRow(0)		//NLG 4-7-00
   		dw_2.SetItem(ll_row,is_filter_column_name,ldt_item_date)
		end if
		li_rc = dw_2.AcceptText()
		IF li_rc < 0 THEN
			return -1
		END IF
END CHOOSE

SetMicroHelp(w_main, "Inserting: " + String(dw_2.RowCount()))

RETURN 0
end event

event type long ue_import_remove_dupes(string as_datatype);//*********************************************************************************
// Script Name:	ue_import_remove_dupes
//
//	Arguments:		string.
//						 as_datatype - datatype of data being imported.
//
// Returns:			Integer.
//						 0 =	no duplicates
//						 2 =	found duplicate
//
//	Description:	This event is called from cb_import.clicked.
//						It sorts the datastore which is holding the imported data
//						and removes the duplicates
//*********************************************************************************
//	
// 03/28/00 NLG	Stars 4.5	Created
//
//*********************************************************************************

int			li_rc

long 			ll_idx,			&
				ll_rowCount,	&
				ll_dupes

SetMicroHelp(w_main,"Removing duplicates ...")


//Sort the input values
li_rc = dw_2.SetSort(is_filter_column_name)
li_rc = dw_2.Sort()
CHOOSE CASE as_datatype
	CASE "CHAR"
		ll_rowCount = dw_2.RowCount()
		ll_rowCount = ll_rowcount - 1
		FOR ll_idx = 1 TO ll_rowCount
			IF dw_2.GetItemString(ll_idx,is_filter_column_name) = &
				dw_2.GetItemString(ll_idx + 1,is_filter_column_name) THEN
				li_rc = dw_2.RowsDiscard(ll_idx,ll_idx,Primary!)
				ll_idx --
				ll_rowCount --
				ll_dupes++
			END IF
		NEXT
	CASE "NUMBER"
		//Sort the input values
		ll_rowCount = dw_2.RowCount()
		ll_rowCount = ll_rowcount - 1
		FOR ll_idx = 1 TO ll_rowCount
			IF dw_2.GetItemNumber(ll_idx,is_filter_column_name) = &
				dw_2.GetItemNumber(ll_idx + 1,is_filter_column_name) THEN
				li_rc = dw_2.RowsDiscard(ll_idx,ll_idx,Primary!)
				ll_idx --
				ll_rowCount --
				ll_dupes++
			END IF
		NEXT
	CASE "MONEY"
		//Sort the input values
		ll_rowCount = dw_2.RowCount()
		ll_rowCount = ll_rowcount - 1
		FOR ll_idx = 1 TO ll_rowCount
			IF dw_2.GetItemNumber(ll_idx,is_filter_column_name) = &
				dw_2.GetItemNumber(ll_idx + 1,is_filter_column_name) THEN
				li_rc = dw_2.RowsDiscard(ll_idx,ll_idx,Primary!)
				ll_idx --
				ll_rowCount --
				ll_dupes++
			END IF
		NEXT
	CASE "DATE"
		//Sort the input values
		ll_rowCount = dw_2.RowCount()
		ll_rowCount = ll_rowcount - 1
		FOR ll_idx = 1 TO ll_rowCount
			IF dw_2.object.filter_data[ll_idx] = &
				dw_2.object.filter_data[ll_idx + 1] THEN
				li_rc = dw_2.RowsDiscard(ll_idx,ll_idx,Primary!)
				ll_idx --
				ll_rowCount --
				ll_dupes++
			END IF
		NEXT
END CHOOSE




ll_rowcount = dw_2.RowCount()//debugging

SetMicroHelp(w_main,"Ready")

return ll_dupes
end event

public subroutine of_setdataobject (string as_data_type);//set the data object based on the data type
IF	gnv_sql.of_is_character_data_type (as_data_type)	THEN
	dw_2.dataobject = 'd_filter_vals_string'
	dw_1.dataobject = 'd_filter_vals_string'	
ELSEIF gnv_sql.of_is_number_data_type (as_data_type)	THEN
	dw_2.dataobject = 'd_filter_vals_number'
	dw_1.dataobject = 'd_filter_vals_number'
ELSEIF gnv_sql.of_is_money_data_type (as_data_type)	THEN
	dw_2.dataobject = 'd_filter_vals_money'
	dw_1.dataobject = 'd_filter_vals_money'
ELSEIF gnv_sql.of_is_date_data_type (as_data_type)	THEN
	dw_2.dataobject = 'd_filter_vals_date'
	dw_1.dataobject = 'd_filter_vals_date'
END IF	

dw_2.settransobject(stars2ca)
dw_1.settransobject(stars2ca)
dw_2.ShareData(dw_1)


end subroutine

public function integer wf_validate_and_insert (string as_data_type, string as_input_val, boolean ab_import);/////////////////////////////////////////////////////////////////////////////////////////
//
//This window function controls the editing of any value to be added to the data window.
//The function is invoked if the user clicks the add button and supplies a filter value,
//or if the user clicks the import button and supplies a valid file name.
//
//The boolean ab_import indicates whether this routine is invoked to validate
//one manually entered filter value or one filter value imported from a text file.
//As such, before invoking the routine, set ab_import to FALSE for manually entered filter
//values, TRUE to process an imported value.  The way the boolean is set determines 
//whether or not an error message is displayed to the user.
//
//Returns:		 0		No error found, passed value added to dw_1 
//					>0		Field value is incorrect or out of range.  Error number returned.
//
/////////////////////////////////////////////////////////////////////////////////////////
//
// FDG	01/18/02	Track 2691d.  Validate the length (if a string filter)
//	FDG	02/05/02	Track 3042c.  Allow a '#' as a valid character.
// Jason 07/02/02	Track 3163d  Commenting out all check for character, allow any character
//	GaryR	01/29/03	Track 4705c	Expand string filter limit to 255
// GaryR	07/28/06	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
/////////////////////////////////////////////////////////////////////////////////////////

Boolean 		lb_import,										&
				lb_time_exists =	False

Datetime 	ldt_item_date

Decimal{2}  ld_item_decimal,								&
				ld_hi_val	=	+922337203685477.58,		&
				ld_val

integer		li_len,											&
				li_max_len

Long   		ll_hi_val	=	+2147483647,				&
				ll_item_num,									&
				li_pos, 											&
				li_sub,											&
				ll_val
				
String 		ls_char,											&
				ls_data_type,									&
				ls_filter_val, 								&
				ls_filter_time,								&
				ls_input_val,									&
				ls_item_string,								&
				ls_new_val
				
Time   		lt_time

//Save arguments passed from calling routine locally

ls_data_type	=	trim(upper(as_data_type))
ls_input_val	=	Upper(as_input_val)
lb_import		=	ab_import

setpointer(hourglass!)
setmicrohelp(w_main,'Inserting new filter value...')

//Check for valid data types

CHOOSE CASE ls_data_type
	CASE 'NUMBER', 'MONEY'
		IF NOT isnumber(ls_input_val) THEN
			//invalid data type
			IF lb_import THEN
				RETURN 1					
			ELSE
		   	Messagebox('EDIT',	+&
							  'Please enter a Valid Numeric Value')
				RETURN 1
	   	END IF
		END IF

		IF ls_data_type = 'NUMBER' THEN
			//NUMBER data type field validation routine
			
			//now check for value out of range of valid values for this data type 
			ll_val = abs(long(ls_input_val))
			IF ll_val > ll_hi_val THEN
				//invalid data type
				IF lb_import THEN
					RETURN 1				
				ELSE
	 				Messagebox('EDIT',											+&
				 				  'Please enter a Valid Numeric Value '	+&
								  'between -2,147,483,647 '					+&
								  'and 2,147,483,647')
  					RETURN 1
				END IF
			END IF
		ELSE
			//MONEY data type field validation routine
			
			//now check for value out of range of valid values for this data type 
			ld_val = abs(dec(ls_input_val))
			IF ld_val > ld_hi_val THEN
				//invalid data type
				IF lb_import THEN
					RETURN 1				
				ELSE
	 				Messagebox('EDIT',											+&
				 				  'Please enter a Valid Decimal Value '	+&
								  'between -922,337,203,685,477.58 '		+&
								  'and 922,337,203,685,477.58')
  					RETURN 1
				END IF
			END IF
		END IF
		
	CASE 'CHAR'
		// FDG 01/18/02 begin
		li_max_len		=	255
		IF	ii_data_len	>	0						THEN
			// ii_data_len is computed from dictionary (based on filter_tbl_type & filter_col)
			li_max_len	=	ii_data_len
		END IF
		// FDG 01/18/02 end
			
		IF len(string(ls_input_val)) > li_max_len		THEN
			//invalid data type
			IF lb_import THEN
				RETURN 1				
			ELSE
 				Messagebox('EDIT',	+&
				 			  'Please enter a valid character value <= ' + String(li_max_len) + ' characters')
   			RETURN 1
			END IF
		END IF
		
		//KMM 11-17-95 Alaska prob#138
		li_len = len(string(ls_input_val))
		
	CASE 'DATE'
		li_pos = pos(trim(ls_input_val),' ')
		
		//KMM 5-22-95 Added code to check for datetime insert	
		IF li_pos > 0 THEN
			lb_time_exists = true
			ls_filter_val 	= trim(left(ls_input_val,li_pos - 1))
			ls_filter_time = trim(mid(ls_input_val,li_pos + 1))
			IF NOT isdate(ls_filter_val) THEN
				//invalid data type
				IF lb_import THEN
					RETURN 1		
				ELSE
					Messagebox('EDIT',	+&
								  'Please enter a Valid Date Value')
   				RETURN 1
				END IF
			END IF
			
			IF NOT istime(ls_filter_time) THEN
				//invalid data type
				IF lb_import THEN
					RETURN 1		
				ELSE
					Messagebox('EDIT',	+&
								  'Please enter a Valid Time Value')
   				RETURN 1
				END IF
			END IF
			//KMM END
		ELSE
			IF NOT isdate(ls_input_val) THEN
				//invalid data type
				IF lb_import THEN
					RETURN 1		
				ELSE
			   	Messagebox('EDIT',	+&
								  'Please enter a Valid Date Value')
   				RETURN 1
				END IF
			END IF
		END IF
END CHOOSE

// Check for duplicate values within list already entered.

li_pos = Long(st_row_count.text)

IF li_pos > 0 THEN
	FOR li_sub = 1 TO li_pos
		CHOOSE CASE ls_data_type
			CASE 'CHAR'
			   ls_item_string = TRIM(DW_1.GetItemString(li_sub,is_filter_column_name))
			   IF trim(ls_input_val) = ls_item_string THEN
					IF lb_import THEN
						RETURN 2
					ELSE
		   	   	Messagebox('EDIT',	+&
									  'Duplicate Filter Value - Already Entered')
			   	   RETURN 2
					END IF
   			END IF
				
			CASE 'NUMBER'
		   	ll_item_num = DW_1.GetItemnumber(li_sub,is_filter_column_name)
			   IF long(trim(ls_input_val)) = ll_item_num THEN
					IF lb_import THEN
						RETURN 2
					ELSE
		   		   Messagebox('EDIT',	+&
									  'Duplicate Filter Value - Already Entered')
				      RETURN 2
					END IF
   			END IF
				
			CASE 'MONEY'
			   ld_item_decimal = DW_1.GetItemdecimal(li_sub,is_filter_column_name)	
				
			   IF dec(trim(ls_input_val)) = ld_item_decimal THEN
					IF lb_import THEN
						RETURN 2
					ELSE
		   		   Messagebox('EDIT',	+&
									  'Duplicate Filter Value - Already Entered')
				      RETURN 2
					END IF
   			END IF
				
			CASE 'DATE'
			   ldt_item_date = DW_1.GetItemdatetime(li_sub,is_filter_column_name)
				
				//KMM 5-22-95 Code to check for a datetime insert
				IF lb_time_exists THEN
					IF datetime(date(ls_filter_val),time(ls_filter_time)) = ldt_item_date THEN
						IF lb_import THEN
							RETURN 2
						ELSE
	 						Messagebox('EDIT','Duplicate Filter Value - Already Entered')
			      		RETURN 2
						END IF
					END IF
				ELSE
				//KMM END
		   		IF datetime(date(trim(ls_input_val)),lt_time) = ldt_item_date THEN
						IF lb_import THEN
							RETURN 2
						ELSE
			   	   	Messagebox('EDIT',	+&
										  'Duplicate Filter Value - Already Entered')
				      	RETURN 2
						END IF
	   			END IF
				END IF
		END CHOOSE
	NEXT
END IF

//Now insert the value into the appropriate row in the data window.

li_pos = (Long(st_row_count.text) + 1)
st_row_count.text = string(li_pos)

InsertRow(dw_2, li_pos)

CHOOSE CASE ls_data_type
	CASE 'CHAR'
	   ls_item_string = ls_input_val
	   dw_2.SetItem(li_pos,is_filter_column_name,ls_item_string)
	CASE 'NUMBER' 
		   ll_item_num = long(ls_input_val)
	   	dw_2.SetItem(li_pos,is_filter_column_name,ll_item_num)
	CASE 'MONEY'
		   ld_item_decimal = dec(ls_input_val)
	   	dw_2.SetItem(li_pos,is_filter_column_name,ld_item_decimal)
	CASE 'DATE'
			if lb_time_exists then																	//KMM 5-22-95
				ldt_item_date = datetime(date(ls_filter_val),time(ls_filter_time))	//KMM 5-22-95
	   		dw_2.SetItem(li_pos,is_filter_column_name,ldt_item_date)    						//KMM 5-22-95
			else
		   	ldt_item_date = datetime(date(ls_input_val))
	   		dw_2.SetItem(li_pos,is_filter_column_name,ldt_item_date)
			end if
END CHOOSE

IF cbx_selectall.checked = FALSE THEN
	selectrow(dw_1,0,FALSE)
END IF

selectrow(dw_1,li_pos,TRUE)
setrow(dw_1,li_pos)
in_highlighted_rows ++
dw_1.ScrollToRow(li_pos)

RETURN 0
end function

public function integer wf_retrieve_data ();// FDG 01/18/02	Track 2691d.  Get filter_tbl_type and filter_col to determine
//						the data length of column filter_data.
// 10/19/04 MikeF	Track 3650d	Replaced local n_cst_dict with global service
//	12/22/04	GaryR	Track 4163d	Trigger update on delete
// 09/23/05	MikeF	SPR4383c	Decode CODE_CODE filters

string ls_sql, ls_rc
String Lv_data_type
Datetime lv_datetime
string ls_table_name, ls_filter_col, ls_filter_tbl_type
string	ls_col_array[]
n_cst_string	lnv_string

setpointer(hourglass!)
in_highlighted_rows = 0

// Get Filter information
SELECT   USER_ID, FILTER_COL,  FILTER_DATETIME,   
         FILTER_DESC, FILTER_DATA_TYPE, FILTER_TBL_TYPE
INTO		:is_user_id, :ls_filter_col, :lv_datetime,
			:sle_description.text, :lv_data_type, :ls_filter_tbl_type
FROM FILTER_CNTL
WHERE FILTER_ID = Upper( :sle_filter_id.text )
Using Stars2ca;

If Stars2ca.of_check_status() = 100 then
	Messagebox('EDIT','Filters do not exist with this Filter Id')
	RETURN -1
ELSEIf Stars2ca.sqlcode <> 0 then
	Errorbox(Stars2ca,'Filters do not exist for this Filter Id')
	RETURN -1
End IF

// Process results
sle_column.text 					= ls_filter_col
ls_col_array = lnv_string.of_stringtoarray( ls_filter_col, '-')
ix_filter_data.sx_col_name 	= trim(ls_col_array[1])
ix_filter_data.sx_filter_id 	= sle_filter_id.text

IF trim(ls_col_array[1]) = 'CODE_CODE' THEN
	IF upperbound(ls_col_array) = 2 THEN // Lookup type is present
		is_lookup = trim(ls_col_array[2])
	ELSE
		is_lookup = ''
	END IF
ELSE
	is_lookup = gnv_dict.event ue_get_lookup_type( ls_filter_tbl_type, ls_filter_col )
	ix_filter_data.sx_inv_type	= ls_filter_tbl_type			
END IF

cbx_retrieve_desc.enabled = (len(trim(is_lookup)) > 0 AND is_lookup <> gnv_dict.ics_not_found)

// Get the filtrer table table name
ls_table_name = gnv_server.of_GetFilterTableName(sle_filter_id.text)

// FDG 01/18/02 - Get the data length from dictionary
IF	 Trim( ls_filter_tbl_type )	>	' '		&
AND Trim( ls_filter_col )	>	' '				THEN
	ii_data_len	=	gnv_dict.Event	ue_get_data_len( ls_filter_tbl_type, ls_filter_col )
ELSE
	ii_data_len	=	0
END IF
// FDG 01/18/02 end

of_SetDataObject(lv_data_type)

IF dw_1.dataobject = 'd_filter_vals_money' or dw_1.dataobject = 'd_filter_vals_date' then
	ls_sql = "select filter_data from " + ls_table_name
else
	ls_sql = "select filter_data, ' ' from " + ls_table_name
end if

ls_sql += " ORDER BY FILTER_DATA"

dw_2.setsqlselect(ls_sql)
ls_rc = dw_2.modify("datawindow.table.updatetable='"+ls_table_name+ "'")
ib_exists = TRUE
dw_2.settransobject(stars2ca)
dw_2.retrieve()

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return -1
End If	

sle_datetime.text = string(lv_datetime,"m/d/yyyy hh:mm:ss")
ddlb_data_types.selectitem(lv_data_type,1)

dw_1.setredraw(False)

dw_2.Sharedata(dw_1)
dw_1.setredraw(true)

Return 0
end function

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////
// W_Filter_Maintain - Open
//
//	Entry mode will be one of the following 
//		blank 	-	Entry from MENU
//		ADD		-	Entry from Filter List to create new filters
//		SELECT	-	Entry from Filter List to Retrieve and Update Existing Filters
//		APPEND	-	Entry from other Functionality e.g. claim report to 
//							Append the Filters from a data column to existing filters
//		CREATE	-	Entry from other Functionality e.g. claim report to 
//							Create Filters from a data column
////////////////////////////////////////////////////////////////////////////////////
// History
//
// 07/30/98 FNC	Track 1290. Keep cbx_selectall set to FALSE when come in as add. 
//						Don't	want all rows to be highlighted. Only want last row that was
//						added to be hightlighted.
// 08/04/98	FNC	Track 1495. Check for data type of Long. It is treated other 
//						numeric data types.
//	12/14/00	FDG	Make the checking of data types DBMS-independent.
// 01/16/02 LMC	TRACK #2675 - Fixed retrieve description check box
//	02/21/02	FDG	Track 2831d. dw_2.dataobject not set when entry mode = CREATE.
//	07/25/02	GaryR	Track 3105d	Append Filter not displaying data
//	01/29/03	GaryR	Track 4705c	Expand string filter limit to 255
//	02/20/03	GaryR	Track 3006d	Accomodate compute fields
// 10/19/04 MikeF	Track 3650d	Replaced local n_cst_dict with global service
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
// 09/23/05 MikeF	Track 4383c	Decode CODE_CODE filters
// 01/16/06 Jason Track 4524d Convert char filters to upper case
//	04/05/06	GaryR	Track 4383c	Make checkboxes function logically.
//	05/23/06	GaryR	Track 4750d	Do not select all rows when is_from = "L"
// 07/25/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows GPF
//	07/22/09	GaryR	WIN.650.5721.007	Nullify variables so that 0 gets added to filter
//
////////////////////////////////////////////////////////////////////////////////////

string  	ls_filter_id, ls_data_type, ls_col_name
string 	ls_item_string, ls_last_item_string
double 	lv_item_decimal, lv_last_item_decimal
datetime lv_item_date, lv_last_item_date
long   	lv_item_no, lv_last_item_no
int    	li_pos, li_rc
long		ll_rows
String 	lv_ddlb_display
Long   	lv_priordw_count,lv_rowcount, lv_index
Boolean	lb_decode
n_cst_decode	lnv_decode

ib_disableclosequery	=	TRUE
this.of_set_sys_cntl_range(TRUE)
setpointer(hourglass!)
setmicrohelp(w_main,'Opening Filter Add...')

ls_col_name = ix_filter_data.sx_col_name

IF NOT IsValid(in_cst_filter) THEN
	in_cst_filter = CREATE n_cst_filter // 02/09/06 HYL Track 4648d
END IF

cb_create.default   = false
cb_create.enabled   = false
cb_retrieve.enabled = false
cb_update.enabled   = false
cb_copy.enabled     = false
cb_clear.enabled    = false
cbx_selectall.checked = false

//	Nullify variables so that default values such as 0 get added to filter
SetNull( lv_last_item_decimal )
SetNull( lv_last_item_no )

If upper(ix_filter_data.sx_entry_mode) = 'CREATE' then 
		this.title = 'Filter Add' //VAV 4.0 1/30/98 - was 'Filter Independant Add' 
		cb_create.enabled   = true
	   cb_create.default   = true
Elseif upper(ix_filter_data.sx_entry_mode) = 'APPEND' then
		this.title = 'Filter Details' //VAV 4.0 1/30/98 - was 'Filter Independant Detail' 
   	cb_update.enabled   = true
   	cb_update.default   = true
		sle_filter_id.text  = ix_filter_data.sx_filter_id	//08-20-97 JGG
Elseif upper(ix_filter_data.sx_entry_mode) = 'SELECT' then
		this.title = 'Filter Details' //VAV 4.0 1/30/98 - was 'Filter Independant Detail'
   	cb_update.enabled   = true
	   cb_copy.enabled     = true
		cb_retrieve.enabled = true
		cb_retrieve.default = true
		sle_filter_id.text  = ix_filter_data.sx_filter_id	//08-20-97 JGG
Else									//Entry from Menu or ADD from Filter List
		this.title = 'Filter Add' //VAV 4.0 1/30/98 - was 'Filter Independant Add' 
		cb_create.enabled   = true
	   cb_create.default   = true
		cb_retrieve.enabled = true
		cb_clear.enabled    = true
End IF

If	upper(ix_filter_data.sx_entry_mode)  = 'SELECT' then
	cb_retrieve.postevent(clicked!)
	RETURN
End IF

If	upper(ix_filter_data.sx_entry_mode)  = 'ADD' then
	ddlb_data_types.selectitem('Char',1)
	dw_2.Sharedata(dw_1)
	of_SetDataObject(ddlb_data_types.text)
	RETURN
End IF

ls_data_type = upper(ix_filter_data.sx_data_window.Describe(ix_filter_data.sx_col_name + ".ColType"))
of_SetDataObject(ls_data_type)

li_pos = pos(ls_data_type, '(')
if li_pos > 0 then
	ls_data_type = left(ls_data_type, (li_pos - 1))
end if

sle_datetime.text = inv_sys_cntl.of_get_default_date()

// Set column text
sle_column.text 	= trim(upper(ix_filter_data.sx_col_name))

// FDG 12/14/00 - Make data type checking DBMS-independent

IF	gnv_sql.of_is_character_data_type (ls_data_type)	THEN
	lv_ddlb_display = 'Char'
ELSEIF gnv_sql.of_is_number_data_type (ls_data_type)	THEN
		 lv_ddlb_display = 'Number'
ELSEIF gnv_sql.of_is_money_data_type (ls_data_type)	THEN
		 lv_ddlb_display = 'Money'
ELSEIF gnv_sql.of_is_date_data_type (ls_data_type)	THEN
		 lv_ddlb_display = 'Date'
END IF	

//set the drop down list box with the correct data type
ddlb_data_types.selectitem(lv_ddlb_display,1)

of_SetDataObject(lv_ddlb_display)			//	07/25/02	GaryR	Track 3105d

If	upper(ix_filter_data.sx_entry_mode) = 'APPEND' then
	IF wf_retrieve_data() <> 0 THEN
		cb_close.postevent(clicked!)
		RETURN
	End IF
	ll_rows = dw_2.rowcount()
	ll_rows++
Else
	ll_rows = 1
End IF

IF	upper(ix_filter_data.sx_entry_mode) = 'CREATE' THEN
	IF	 Trim( ix_filter_data.sx_inv_type )	>	' '	&
	AND Trim( ix_filter_data.sx_col_name )	>	' '	THEN
		ii_data_len	= gnv_dict.Event ue_get_data_len ( 	ix_filter_data.sx_inv_type, 	&
																		ix_filter_data.sx_col_name)
		is_lookup 	= gnv_dict.event ue_get_lookup_type(ix_filter_data.sx_inv_type, 	&
																		ix_filter_data.sx_col_name)
	ELSE
		ii_data_len	=	0
	END IF
END IF

IF ix_filter_data.sx_col_name = 'CODE_CODE' THEN
	sle_column.text += ' - ' + ix_filter_data.sx_inv_type
	is_lookup = ix_filter_data.sx_inv_type
END IF

// Set Retrieve desc enabled
cbx_retrieve_desc.enabled = (len(trim(is_lookup)) > 0 AND is_lookup <> gnv_dict.ics_not_found)

//	Check if column is decoded
lb_decode = lnv_decode.of_is_decoded( ix_filter_data.sx_data_window, ls_col_name )

lv_priordw_count = ix_filter_data.sx_data_window.RowCount()
For lv_index = 1 to lv_priordw_count
	If upper(ddlb_data_types.text) = 'CHAR' then
		IF ix_filter_data.sx_col_no = 0 THEN
			ls_item_string = ix_filter_data.sx_data_window.GetItemString(lv_index,ls_col_name)
		ELSE
		   ls_item_string = ix_filter_data.sx_data_window.GetItemString(lv_index,ix_filter_data.sx_col_no)
		END IF
		
		//	Remove decoded value
		IF lb_decode THEN
			li_pos = Pos( ls_item_string, " - " )
			IF li_pos > 0 THEN ls_item_string = Trim( Left( ls_item_string, li_pos ) )
		END IF
		
		if ls_item_string <> ls_last_item_string and trim(ls_item_string) <> '' Then
      	InsertRow(dw_2, ll_rows)
		   dw_2.SetItem(ll_rows, is_filter_column_name, upper(ls_item_string))
   		ls_last_item_string = ls_item_string
			ll_rows++
	   End If
	ElseIf upper(ddlb_data_types.text) = 'NUMBER' then
		IF ix_filter_data.sx_col_no = 0 THEN
			lv_item_no = ix_filter_data.sx_data_window.GetItemnumber(lv_index, ls_col_name)
		ELSE
			lv_item_no = ix_filter_data.sx_data_window.GetItemnumber(lv_index, ix_filter_data.sx_col_no)
		END IF
		if lv_item_no = lv_last_item_no Then
			// Do nothing
		ELSE
      	InsertRow(dw_2, ll_rows)
		   dw_2.SetItem(ll_rows, is_filter_column_name, lv_item_no)
	  		lv_last_item_no = lv_item_no
			ll_rows++
	   End If
	ElseIf upper(ddlb_data_types.text) = 'MONEY' then
		IF ix_filter_data.sx_col_no = 0 THEN
			lv_item_decimal = ix_filter_data.sx_data_window.GetItemdecimal(lv_index, ls_col_name)
		ELSE
			lv_item_decimal = ix_filter_data.sx_data_window.GetItemdecimal(lv_index, ix_filter_data.sx_col_no)
		END IF
		if lv_item_decimal = lv_last_item_decimal Then
			// Do nothing
		ELSE
      	InsertRow(dw_2, ll_rows)
		   dw_2.SetItem(ll_rows,is_filter_column_name,lv_item_decimal)
	  		lv_last_item_decimal = lv_item_decimal
			ll_rows = ll_rows + 1
	   End If
	ElseIf upper(ddlb_data_types.text) = 'DATE' then
		IF ix_filter_data.sx_col_no = 0 THEN
			lv_item_date = ix_filter_data.sx_data_window.GetItemdatetime(lv_index, ls_col_name)
		ELSE
			lv_item_date = ix_filter_data.sx_data_window.GetItemdatetime(lv_index, ix_filter_data.sx_col_no)
		END IF
		if lv_item_date <> lv_last_item_date Then
      	InsertRow(dw_2, ll_rows)
		   dw_2.SetItem(ll_rows,is_filter_column_name,lv_item_date)
	  		lv_last_item_date = lv_item_date
			ll_rows = ll_rows + 1
	   End If
	End IF
Next

//KMM 7/12/95 Sort dw to get rid of any duplicate filter values
li_rc = dw_2.SetSort(is_filter_column_name)
li_rc = dw_2.Sort()

if upper(ix_filter_data.sx_entry_mode) = 'APPEND' or upper(ix_filter_data.sx_entry_mode) = 'CREATE' then 
	lv_rowcount = dw_2.rowcount()
	if lv_rowcount > 1 then
		If upper(ddlb_data_types.text) = 'CHAR' then
	   		ls_last_item_string = dw_2.GetItemString(1,is_filter_column_name)
		ElseIf upper(ddlb_data_types.text) = 'NUMBER' then
	   		lv_last_item_no = dw_2.GetItemnumber(1,is_filter_column_name)
		ElseIf upper(ddlb_data_types.text) = 'MONEY' then
	   		lv_last_item_decimal = dw_2.GetItemdecimal(1,is_filter_column_name)
		ElseIf upper(ddlb_data_types.text) = 'DATE' then
	  		 	lv_last_item_date = dw_2.GetItemdatetime(1,is_filter_column_name)
		End If
		for lv_index = 2 to lv_rowcount
			If upper(ddlb_data_types.text) = 'CHAR' then
	   		ls_item_string = dw_2.GetItemString(lv_index, is_filter_column_name)
				if ls_item_string = ls_last_item_string Then
     		 		DeleteRow(dw_2, lv_index)
					lv_rowcount = lv_rowcount - 1
					lv_index = lv_index - 1
					continue
	   		else
					ls_last_item_string = ls_item_string
				end if
			ElseIf upper(ddlb_data_types.text) = 'NUMBER' then
	   		lv_item_no = dw_2.GetItemnumber(lv_index, is_filter_column_name)
				if lv_item_no = lv_last_item_no Then
      			DeleteRow(dw_2, lv_index)
					lv_rowcount = lv_rowcount - 1
					lv_index = lv_index - 1
					continue
				else
	  				lv_last_item_no = lv_item_no
				end if
	   	ElseIf upper(ddlb_data_types.text) = 'MONEY' then
	   		lv_item_decimal = dw_2.GetItemdecimal(lv_index, is_filter_column_name)
				if lv_item_decimal = lv_last_item_decimal Then
      			DeleteRow(dw_2, lv_index)
					lv_rowcount = lv_rowcount - 1
					lv_index = lv_index - 1
					continue
				else
	  				lv_last_item_decimal = lv_item_decimal
				end if
			ElseIf upper(ddlb_data_types.text) = 'DATE' then
	  		 	lv_item_date = dw_2.GetItemdatetime(lv_index, is_filter_column_name)
				if lv_item_date = lv_last_item_date Then
      			DeleteRow(dw_2,lv_index)
					lv_rowcount = lv_rowcount - 1
					lv_index = lv_index - 1
					continue
				else   
					lv_last_item_date = lv_item_date
				end if
			End IF
		Next
	end if
end if
//KMM END

li_rc = dw_2.ShareData(dw_1)
st_row_count.text = string(dw_1.rowcount())
ddlb_data_types.enabled = false

If	upper(ix_filter_data.sx_entry_mode)  = 'CREATE' then
	cbx_selectall.CHECKED = TRUE
	CBX_SELECTALL.TRIGGEREVENT(CLICKED!)
End IF

RETURN
end event

on mousemove;setmicrohelp(w_main,'Ready')
end on

on w_filter_maintain.create
int iCurrent
call super::create
this.pb_delete=create pb_delete
this.pb_insert=create pb_insert
this.cb_export=create cb_export
this.cb_import=create cb_import
this.cbx_selectall=create cbx_selectall
this.cbx_retrieve_desc=create cbx_retrieve_desc
this.st_row_count=create st_row_count
this.st_5=create st_5
this.ddlb_data_types=create ddlb_data_types
this.cb_copy=create cb_copy
this.cb_clear=create cb_clear
this.sle_filter_val=create sle_filter_val
this.dw_2=create dw_2
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_datetime=create sle_datetime
this.sle_description=create sle_description
this.sle_column=create sle_column
this.sle_filter_id=create sle_filter_id
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.cb_update=create cb_update
this.cb_create=create cb_create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_delete
this.Control[iCurrent+2]=this.pb_insert
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.cb_import
this.Control[iCurrent+5]=this.cbx_selectall
this.Control[iCurrent+6]=this.cbx_retrieve_desc
this.Control[iCurrent+7]=this.st_row_count
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.ddlb_data_types
this.Control[iCurrent+10]=this.cb_copy
this.Control[iCurrent+11]=this.cb_clear
this.Control[iCurrent+12]=this.sle_filter_val
this.Control[iCurrent+13]=this.dw_2
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.sle_datetime
this.Control[iCurrent+19]=this.sle_description
this.Control[iCurrent+20]=this.sle_column
this.Control[iCurrent+21]=this.sle_filter_id
this.Control[iCurrent+22]=this.cb_close
this.Control[iCurrent+23]=this.cb_retrieve
this.Control[iCurrent+24]=this.cb_update
this.Control[iCurrent+25]=this.cb_create
this.Control[iCurrent+26]=this.gb_1
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.dw_1
end on

on w_filter_maintain.destroy
call super::destroy
destroy(this.pb_delete)
destroy(this.pb_insert)
destroy(this.cb_export)
destroy(this.cb_import)
destroy(this.cbx_selectall)
destroy(this.cbx_retrieve_desc)
destroy(this.st_row_count)
destroy(this.st_5)
destroy(this.ddlb_data_types)
destroy(this.cb_copy)
destroy(this.cb_clear)
destroy(this.sle_filter_val)
destroy(this.dw_2)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_datetime)
destroy(this.sle_description)
destroy(this.sle_column)
destroy(this.sle_filter_id)
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.cb_update)
destroy(this.cb_create)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;
// ix_filter_data = message.powerobjectparm

If isvalid(message.powerobjectparm) AND (not Isnull(message.powerobjectparm)) then
	ix_filter_data = message.powerobjectparm
	//KMM Clear out message parm (PB Bug)
	SetNull(message.powerobjectparm)
Else
	ix_filter_data.sx_entry_mode = 'ADD' 
End IF

end event

event close;call super::close;
DESTROY in_cst_filter
end event

type pb_delete from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 2011
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 170
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Delete"
end type

event clicked;//	12/22/04	GaryR	Track 4163d	Trigger update on delete

int lv_message_nbr,lv_rc 
long lv_tot_row_count, lv_row_nbr

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

If cbx_selectall.checked = true then
	in_highlighted_rows = dw_1.rowcount()
end if

If in_highlighted_rows <= 0 then
   messagebox('ERROR','There are no rows selected to delete')
   Return
End If

//Prints a confirmation box and finds out what button was pressed
lv_message_nbr = MessageBox ('CONFIRMATION!', 'Delete All Selected Rows', &
                   Question!,YesNo!,2)
If lv_message_nbr = 2 Then
   Return
End IF

//Deletes row(s) from table
SetMicroHelp(w_main,"Deleting the records from the table")
lv_tot_row_count = dw_1.RowCount()

For lv_row_nbr = lv_tot_row_count to 1 STEP -1
  If dw_1.IsSelected(lv_row_nbr) = TRUE Then
    lv_rc = dw_1.DeleteRow(lv_row_nbr)
    If lv_rc = -1 Then
      MessageBox("ERROR","Error Deleting row from database")
      Return
    End If
    in_highlighted_rows = in_highlighted_rows - 1
  End If
Next

st_row_count.text = string(dw_1.rowcount())

//	If filter exists, trigger update
IF ib_exists THEN cb_update.event clicked()

cb_close.default = true
setmicrohelp(w_main,'Ready')
setpointer(arrow!)
end event

type pb_insert from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Add"
string accessibledescription = "Add"
integer x = 2377
integer y = 1768
integer width = 334
integer height = 108
integer taborder = 170
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Add"
end type

event clicked;call super::clicked;//This script passes the data type and filter value text to a window function
//to verify that the data is correct.
// 
// --------	-----	--------	------------------------------------------------------------------- //
// 09/28/05 MikeF SPR4383c Auto-save when value is added

integer		li_rc

setpointer(hourglass!)
setmicrohelp(w_main,'Inserting new filter value...')

IF trim(sle_filter_val.text) = '' THEN
   Messagebox('EDIT',	+&
				  'Filter to be Added Must be Entered')
   setfocus(sle_filter_val)
	setmicrohelp(w_main,'Ready')
   pb_insert.default = true
   RETURN
END IF

IF trim(ddlb_data_types.text) = '' THEN
   Messagebox('EDIT',	+&
				  'Please Select a Data Type')
   setfocus(ddlb_data_types)
	setmicrohelp(w_main,'Ready')
   pb_insert.default = true
   RETURN
END IF

//Call the window function to validate the data entered by the user.  
//If no errors found, the value is added to the datawindow within the function.
//Set instance boolean to indicate that we are manually adding an entry to the datawindow.

li_rc			=	wf_validate_and_insert(ddlb_data_types.text, &
												  sle_filter_val.text,	&
												  FALSE)

IF li_rc = 0 THEN				//No error found, so reset filter value for next entry
	sle_filter_val.text = ''
END IF

// Re-enable description lookup if new code added
IF cbx_retrieve_desc.checked THEN cbx_retrieve_desc.checked = FALSE
cbx_retrieve_desc.enabled = (len(trim(is_lookup)) > 0 AND is_lookup <> gnv_dict.ics_not_found)

//	If filter exists, trigger update
IF ib_exists THEN cb_update.event clicked()

//Final clean up before giving control back to the user.
setfocus(sle_filter_val)
setmicrohelp(w_main,'Ready')
end event

type cb_export from u_cb within w_filter_maintain
string accessiblename = "Export"
string accessibledescription = "Export"
integer x = 3109
integer y = 1768
integer width = 334
integer height = 108
integer taborder = 110
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Export"
end type

event clicked;//The export button opens an external file on the local pc or network and writes one
//record per filter value contained within the filter values data window.
//
//	AJS 	01-13-00 TRACK 2088D
// GaryR	07/28/06	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
///////////////////////////////////////////////////////////////////////////////////////

boolean			lb_file_exists

datetime			ldt_item_date

decimal			ld_item_dec

Long				li_filelen,				&
					li_filenum,				&
					li_max_rows,			&
					li_rc,					&
					li_recs_out,			&
					li_replace,				&
					li_row_count,			&
					li_write_errors,		&
					ll_item_num

string			ls_data_type,			&
					ls_filename,			&
					ls_filter_val,			&
					ls_pathname
					
//Set microhelp and pointer

setpointer(hourglass!)
setmicrohelp(w_main,'Exporting filter values...')

//Check that rows already exist in the datawindow.
//Return if no rows found.

IF st_row_count.text = '0' OR st_row_count.text = '' OR  st_row_count.text = ' ' THEN
	MessageBox('Export Filter',											&
				  'No rows found to export.  Export Cancelled!',	&
				  StopSign!)
	setmicrohelp(w_main,'Ready')
	cb_export.default = TRUE
	RETURN
END IF
	
//Open the save/save as file object to name the external file.  If file already exists,
//determine file mode - overwrite or append.
//Return if cancel pressed.

//AJS 01-13-00 TRACK 2088D
ls_pathname = gv_user_ini_path + "filter"

li_rc			=	GetFileSaveName('Export File',						&
										 ls_pathname,							&
										 ls_filename,							&
										 'TXT',									&
										 'Text Files (*.TXT),*.TXT')

CHOOSE CASE li_rc
	CASE 0
		//Cancel pressed
		setmicrohelp(w_main,'Ready')
		cb_export.default = TRUE
		RETURN
	CASE -1
		//Error Occurred
		MessageBox('Export Filter',										 &
					  'Error occurred getting export file name.  '	+&
					  'Export Cancelled!',									 &
					  StopSign!)
		setmicrohelp(w_main,'Ready')
		cb_export.default = TRUE
		RETURN
END CHOOSE

//Okay to continue, so open the file in the appropriate mode.  
//Return if open error occurs.

lb_file_exists	=	FileExists(ls_pathname)

IF lb_file_exists THEN
	//Find out whether to replace the file or append to it.  The value of the
	//button pressed determines the mode (yes/replace = 1, no/append = 2)
	li_replace	=	MessageBox('Export File',									 &
								     'File already exists.  '						+&
									  'Do you want to replace this file?',		 &
									  Question!,										 &
						  			  YesNo!)
ELSE
	//Default to Append mode if the file does not exist.
	li_replace	=	2								
END IF
							
IF li_replace = 1 THEN
	//Replace
	li_filenum	=	FileOpen(ls_pathname,			&
								   LineMode!,				&
									Write!,					&
									LockReadWrite!,		&
									Replace!)
ELSE
	//Append
	li_filenum	=	FileOpen(ls_pathname,			&
								   LineMode!,				&
									Write!,					&
									LockReadWrite!,		&
									Append!)
END IF

IF li_filenum = -1 THEN
	//Error occurred opening file
	MessageBox('Open Export File',										 &
				  'Error occurred opening the export file.  '		+&
				  'Export Cancelled!',										 &
				  StopSign!)
	setmicrohelp(w_main,'Ready')
	cb_export.default = TRUE
	RETURN
END IF

//Okay to continue, so loop through the data window and write out one record per
//filter value.  Keep track of the number of filter values written out.

li_max_rows		=	Long(st_row_count.text)
ls_data_type	=	trim(upper(ddlb_data_types.text))

DO WHILE li_row_count < li_max_rows
	
	//Increment current row count
	li_row_count++
	
	CHOOSE CASE ls_data_type
		CASE 'CHAR'
			//Store the filter value in the current row as a string.
			ls_filter_val	=	TRIM(dw_1.GetItemString(li_row_count,		&
																   is_filter_column_name))
		CASE 'NUMBER'
	   	ll_item_num 	=	dw_1.GetItemnumber(li_row_count,				&
															 is_filter_column_name)
			ls_filter_val	=	String(ll_item_num)
		
		CASE 'MONEY'
		   ld_item_dec		=	dw_1.GetItemdecimal(li_row_count,			&
														     is_filter_column_name)	
			ls_filter_val	=	String(ld_item_dec)				
		CASE 'DATE'
		   ldt_item_date	=	dw_1.GetItemdatetime(li_row_count,			&
																is_filter_column_name)					
			ls_filter_val	=	String(ldt_item_date)
	END CHOOSE

	//Now write out the record.
	li_rc		=	FileWrite(li_filenum,									&
								 ls_filter_val)
								 
	CHOOSE CASE li_rc
		CASE -1
			//Error occurred writing record
			li_write_errors++
		CASE ELSE
			li_recs_out++
	END CHOOSE
LOOP

li_rc	=	FileClose(li_filenum)

IF li_rc < 0 THEN
	MessageBox('Close Export File',										 &
				  'Error occurred closing export file.  '				+&
				  'File is suspect!',										 &
				  Exclamation!)
	setmicrohelp(w_main,'Ready')
	cb_export.default = TRUE
ELSE
	MessageBox('Export Filter',									 		 &
				  'Values written : ' + string(li_recs_out)  		+&
				  '.  Errors : ' + string(li_write_errors) + '.',	+&
				  Exclamation!)
	setmicrohelp(w_main,'Ready')
	cb_export.default = FALSE
END IF

end event

type cb_import from u_cb within w_filter_maintain
string accessiblename = "Import"
string accessibledescription = "Import"
integer x = 2738
integer y = 1768
integer width = 334
integer height = 108
integer taborder = 100
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Import"
end type

event clicked;//The import button opens an external file on the local pc or on the network
//and retrieves columnar data from each record in the file.
//The expected format is simply a list of one filter value in text format per record,
//x number of records within the file.
//
//History
//	03-29-00	NLG	Stars4.5.  Importing large files is too slow.  Instead of
//						checking every existing row against new value in order to
//						remove duplicates, bring all rows into dw_2, sort and 
//						remove duplicates.
// 07/28/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
/////////////////////////////////////////////////////////////////////////////////////

boolean		lb_file_exists

Long			li_duplicate_data,		&
				li_filenum,					&
				li_filter_added,			&
				li_filter_val_len,		&
				li_invalid_data,			&
				li_rc,						&
				li_records,					&
				ll_filelen

string		ls_data_type,				&
				ls_filename,				&
				ls_filter_val,				&
				ls_pathname
long 			ll_duplicate_data,		&
				ll_filter_added,			&
				ll_invalid_data,			&
				ll_records

//Set microhelp and pointer
setpointer(hourglass!)
setmicrohelp(w_main,'Importing new filter values...')

//Check that the data type drop down list box has been set.
IF len(ddlb_data_types.text) = 0 THEN
	MessageBox("Import Filter", "Please set data type for imported filters.", &
					Exclamation!)
	ddlb_data_types.SetFocus()
   setmicrohelp(w_main,'Ready')
	cb_import.default = TRUE
   RETURN
End IF

//Open the object to retrieve the name of the file on the pc or network. 
//Return if cancel pressed.
li_rc		=	GetFileOpenName("Import Filter File",	+&
								 	  ls_pathname,				+&
									  ls_filename,				+&
									  "TXT",						+&
									  "Text Files (*.TXT), *.TXT")

CHOOSE CASE li_rc
	CASE 0
		//Cancel
      setmicrohelp(w_main,'Ready')
   	cb_import.default = TRUE
		RETURN
	CASE -1
		//Error
		MessageBox("Get File Name", "Error occurred getting file name.",	+&
					  StopSign!)
      setmicrohelp(w_main,'Ready')
		cb_import.default = TRUE
		RETURN
END CHOOSE

//Okay to continue, so open the named file.
//Return if open error occurs.
lb_file_exists	=	FileExists(ls_pathname)

IF NOT lb_file_exists THEN		
	//File does not exist or is locked by another user
	MessageBox("Open File", "Selected import file does not exist or is locked!",	+&
				  StopSign!)
   setmicrohelp(w_main,'Ready')
	cb_import.default = TRUE
	RETURN
END IF

li_filenum	=	FileOpen(ls_pathname,	&
								LineMode!,		&
								Read!,			&
								LockReadWrite!)
								
IF li_filenum < 0 THEN		
	//Error occurred
	MessageBox("Open File", "Error occurred opening import file!",	&
				  StopSign!)
   setmicrohelp(w_main,'Ready')
	cb_import.default = TRUE
	RETURN
END IF

//Okay to continue, so read the first record from the external file.
//Return if at end of file already.
li_rc		=	FileRead(li_filenum,			&
							ls_filter_val)
							
CHOOSE CASE li_rc
	CASE -100			
		//End of file - should not happen if file len > 0
		MessageBox("Read File", "End of file encountered reading first record!",	&
					  StopSign!)
      setmicrohelp(w_main,'Ready')
		cb_import.default = TRUE
		RETURN
	CASE -1				
		//Error occurred
		MessageBox("Read File", "Error occurred reading first record!",	&
					  StopSign!)
      setmicrohelp(w_main,'Ready')
		cb_import.default = TRUE
		RETURN
	CASE 0				
		//CR LF encountered before any character in file
		MessageBox("Read File", "Length of first record is zero!",	&
					  StopSign!)
      setmicrohelp(w_main,'Ready')
		cb_import.default = TRUE
		RETURN
END CHOOSE

SetPointer(HourGlass!)//nlg 3-29-00
dw_1.SetRedraw(FALSE)//nlg 3-29-00

//Now loop through all the records in the external file.  
//Validate each record, only adding valid values to the data window.
//Keep track of the number of records read, number of values added to the data window,
//number of records failing data type validation.
DO UNTIL li_rc < 1

	//li_records++
	ll_records++//NLG 3-29-00

	//Test the value to see if it matches the datatype indicated in the data type
	//drop down list box.  The function also adds the filter value to the datawindow.

	//NLG 3-29-00 Replace function with call to ue_import_insert_item()		***START**
	//li_rc			=	wf_validate_and_insert(ddlb_data_types.text, &
	//												  ls_filter_val,			&
	//												  TRUE)
	li_rc = parent.event ue_import_insert_item(UPPER(ddlb_data_types.text),ls_filter_val)
	IF li_rc = 0 THEN 
		ll_filter_added++
	ELSEIF li_rc < 0 THEN
		ll_invalid_data++
	END IF
	//NLG 3-29-00																	***END***

	//Increment appropriate count field based on the return code from the edit function.
	//Returns:		 0		No error found, passed value added to dw_1 
	//					>0		Field value is incorrect or out of range.  
	//                   Error number is returned, where:
	//                   1 = invalid data, 
	//                   2 = duplicate.
	
	//NLG 3-29-00 START
	//CHOOSE CASE li_rc
	//	CASE 0
	//		li_filter_added++
	//	CASE 1
	//		li_invalid_data++
	//	CASE 2
	//		li_duplicate_data++
	//END CHOOSE
	//NLG 3-29-00 END
	
	//Now read the next record in the file.  This call resets li_rc for the loop.
	li_rc		=	FileRead(li_filenum,		&
								ls_filter_val)
								
	IF li_rc < 1 AND li_rc <> -100 THEN
		//Error occurred - length of record is 0 or other error.
		MessageBox("Read File", "Error occurred reading the import file!  "	+&
					  "Last record processed: " + String(ll_records) + ".",		 &
					  StopSign!)
      setmicrohelp(w_main,'Ready')
		cb_import.default = TRUE
		RETURN
	END IF

LOOP

//NLG 3-29-00 START
//This event sorts dw_2 and removes duplicates
ll_duplicate_data = parent.event ue_import_remove_dupes(UPPER(ddlb_data_types.text))
ll_filter_added -= ll_duplicate_data


dw_1.SetRedraw(TRUE)

//NLG 3-29-00 STOP


//Close external file.
FileClose(li_filenum)

//Now build a message providing count statistics.

//NLG 3-29-00 use longs
st_row_count.Text = string(dw_2.RowCount())
//IF li_rc = -100 THEN
//	MessageBox('Import Filter',	&
//				  'Records read : ' + string(li_records) +&
//				  		'.  Added : ' + string(li_filter_added) +&
//				  		'.  Invalid data : ' + string(li_invalid_data) +&
//			  			'.  Duplicate values : ' + string(li_duplicate_data) +&  
//						'.', &
//				  Exclamation!)
//END IF
IF li_rc = -100 THEN
	MessageBox('Import Filter',	&
				  'Records read : ' + string(ll_records) +&
				  		'.  Added : ' + string(ll_filter_added) +&
				  		'.  Invalid data : ' + string(ll_invalid_data) +&
			  			'.  Duplicate values : ' + string(ll_duplicate_data) +&  
						'.', &
				  Exclamation!)
END IF

//NLG 3-29-00

setmicrohelp(w_main,'Ready')
cb_import.default = FALSE

RETURN
end event

type cbx_selectall from checkbox within w_filter_maintain
string accessiblename = "Select All"
string accessibledescription = "Select All"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1810
integer y = 184
integer width = 498
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;//	04/05/06	GaryR	Track 4383c	Make checkboxes function logically.

If dw_1.rowcount() <= 0 then Return

If this.checked = false then
	selectrow(dw_1,0,false)
Else
	selectrow(dw_1,0,true)
	in_highlighted_rows = dw_1.rowcount()
End IF


end event

type cbx_retrieve_desc from checkbox within w_filter_maintain
string accessiblename = "Retrieve Description"
string accessibledescription = "Retrieve Description"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1810
integer y = 88
integer width = 750
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Retrieve Description"
end type

event clicked;////////////////////////////////////////////////////////////////////////////////
//
// 09/15/05 MikeF SPR4383c	Decode filters created from code list 
//	04/05/06	GaryR	Track 4383c	Make checkboxes function logically.
// 07/28/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
////////////////////////////////////////////////////////////////////////////////

long 				ll_row
string 			ls_desc, ls_value
string 			lv_where_message
n_cst_decode	lnv_decode

setpointer(hourglass!)

IF dw_1.RowCount() < 1 THEN Return

IF this.checked THEN
	setmicrohelp(w_main,'Retrieving Descriptions...')	
	dw_1.Modify("Filter_Desc.visible=1")	
		
	// Set transaction object for n_cst_decode
	lnv_decode.of_initialize_add( )
	
	// Loop through and set descriptions
	FOR ll_row = 1 to dw_1.rowcount()
		ls_value = dw_1.getitemstring(ll_row,is_filter_column_name)
		ls_desc	= lnv_decode.of_get_description( is_lookup, ls_value )
		dw_1.setitem(ll_row,'FILTER_DESC',ls_desc)
	NEXT
ELSE
	setmicrohelp(w_main,'Removing Descriptions...')	
	dw_1.Modify("Filter_Desc.visible=0")	
END IF
end event

type st_row_count from statictext within w_filter_maintain
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 1964
integer width = 270
integer height = 80
integer textsize = -10
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

type st_5 from statictext within w_filter_maintain
string accessiblename = "Data Type"
string accessibledescription = "Data Type"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 192
integer width = 366
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Data Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_data_types from dropdownlistbox within w_filter_maintain
string accessiblename = "Data Types"
string accessibledescription = "Data Types"
accessiblerole accessiblerole = comboboxrole!
integer x = 402
integer y = 188
integer width = 558
integer height = 388
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Char","Number","Date","Money"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Setpointer(hourglass!)
reset(dw_2)
st_row_count.text = '0'
dw_1.setredraw(false)
dw_1.setredraw(true)

SETFOCUS(sle_filter_val)	
of_SetDataObject(this.text)

end event

type cb_copy from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Copy"
string accessibledescription = "Copy"
integer x = 2377
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 160
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "C&opy"
end type

on mouseover;w_main.setmicrohelp('Copy existing Filters with different Filter ID')
end on

event clicked;////////////////////////////////////////////////////////////////////////////
//
//	12/22/04	GaryR	Track 4163d	Trigger update on delete
// 07/28/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
////////////////////////////////////////////////////////////////////////////

setpointer(hourglass!)
setmicrohelp(w_main,'Copying Filter Data...')
sle_filter_id.text = ''
ix_filter_data.sx_filter_id = ''
ib_exists = FALSE
cb_retrieve.enabled = false
cb_create.enabled = true
cb_update.enabled = false
pb_insert.enabled = true
pb_delete.enabled = true
cbx_selectall.enabled = true
cbx_selectall.checked = true

iv_from_copy = true
cb_create.default = true
CBX_SELECTALL.TRIGGEREVENT(CLICKED!)
setmicrohelp(w_main,'Ready')
end event

type cb_clear from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 2743
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 170
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "C&lear"
end type

on mouseover;w_main.setmicrohelp('Clears Filters from the datawindow')
end on

event clicked;//	04/05/06	GaryR	Track 4383c	Make checkboxes function logically.

setpointer(hourglass!)
setmicrohelp(w_main,'Clearing datawindow...')
reset(dw_2)
st_row_count.text = '0'
in_highlighted_rows = 0
CBX_SELECTALL.ENABLED = TRUE
CBX_SELECTALL.CHECKED = TRUE
setfocus(sle_filter_val)
pb_insert.default = true
setmicrohelp(w_main,'Ready')
end event

type sle_filter_val from singlelineedit within w_filter_maintain
string accessiblename = "Filter Value"
string accessibledescription = "Filter Value"
accessiblerole accessiblerole = textrole!
integer x = 1285
integer y = 1780
integer width = 1056
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

on getfocus;pb_insert.default = true
end on

type dw_2 from u_dw within w_filter_maintain
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = " Not a visible control"
integer x = 1998
integer y = 488
integer width = 567
integer height = 72
integer taborder = 10
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

type st_4 from statictext within w_filter_maintain
string accessiblename = "Created"
string accessibledescription = "Created"
accessiblerole accessiblerole = statictextrole!
integer x = 969
integer y = 192
integer width = 256
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Created:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_filter_maintain
string accessiblename = "Column"
string accessibledescription = "Column"
accessiblerole accessiblerole = statictextrole!
integer x = 969
integer y = 92
integer width = 256
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Column:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_filter_maintain
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 296
integer width = 370
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_filter_maintain
string accessiblename = "Filter ID"
string accessibledescription = "Filter ID"
accessiblerole accessiblerole = statictextrole!
integer x = 59
integer y = 96
integer width = 338
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Filter ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_datetime from singlelineedit within w_filter_maintain
string accessiblename = "Date Time"
string accessibledescription = "Date Time"
accessiblerole accessiblerole = textrole!
integer x = 1243
integer y = 192
integer width = 471
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_description from singlelineedit within w_filter_maintain
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 402
integer y = 288
integer width = 3003
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
integer limit = 80
borderstyle borderstyle = stylelowered!
end type

type sle_column from singlelineedit within w_filter_maintain
string accessiblename = "Column"
string accessibledescription = "Column"
accessiblerole accessiblerole = textrole!
integer x = 1243
integer y = 92
integer width = 471
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_filter_id from singlelineedit within w_filter_maintain
string accessiblename = "Filter Id"
string accessibledescription = "Filter Id"
accessiblerole accessiblerole = textrole!
integer x = 402
integer y = 84
integer width = 558
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type cb_close from u_cb within w_filter_maintain
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 3113
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 180
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Close"
end type

on clicked;setpointer(hourglass!)
close(parent)
end on

type cb_retrieve from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 919
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 120
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Retrieve"
boolean cancel = true
end type

on mouseover;w_main.setmicrohelp('Retrieves Filter data')
end on

event clicked;// 12/08/04 MikeF	SPR4140d Allow Client Admins to update system filters
// 09/23/05 MikeF	SPR4383c Decode CODE_CODE filters
//	04/05/06	GaryR	Track 4383c	Make checkboxes function logically.
//	02/06/07	GaryR	Track 4871	Allow Client Admin to update any filter

int lv_rc 

setpointer(hourglass!)
RESET(DW_2)
ST_ROW_COUNT.TEXT = '0'
in_highlighted_rows = 0 
cb_create.enabled = false
CB_CLEAR.ENABLED  = FALSE

If trim(sle_filter_id.text) = '' then
	Messagebox('EDIT','Please enter Filter Id')
	setmicrohelp(w_main,'Ready')
	Setfocus(sle_filter_id)
	RETURN
End IF

setmicrohelp(w_main,'Retrieving Filter Data...')
dw_1.setredraw(false)
lv_rc = wf_retrieve_data()
dw_1.setredraw(true)

If lv_rc <> 0 then
	RETURN
End IF

ddlb_data_types.enabled = false
st_row_count.text = string(dw_1.rowcount())
cbx_selectall.CHECKED = false

cb_copy.enabled = true

// Allow updates if user owns filter or admin user
IF gv_user_sl = "AD" OR is_user_id = gc_user_id THEN
	cb_update.enabled = true
	pb_delete.enabled = true
	pb_insert.enabled = true
ELSE
	pb_delete.enabled = false
	cb_update.enabled = false
	pb_insert.enabled = false
end if

//KMM 10-29-95 ALASKA Set active filter
gv_active_filter = sle_filter_id.text

setmicrohelp(w_main,'Ready')
end event

type cb_update from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 1280
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 130
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "&Update"
end type

on mouseover;w_main.setmicrohelp('Creates Filters of all Rows in the Datawindow')
end on

event clicked;//UPDATE updates all the rows on the datawindow NOT JUST HILITED ROWS//
///////////////////////////////////////////////////////////////////////
//
//	01/11/01	GaryR	Stars 4.7 Database Port - Empty String in SQL
//	06/20/06	GaryR	SPR 4014	Update filter table statistics
// 07/28/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows limit
//
///////////////////////////////////////////////////////////////////////

string lv_filter_id, lv_description, lv_data_type,	ls_empty
int li_rc
datetime lv_cur_date_time

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

setpointer(hourglass!)
setmicrohelp(w_main,'Updating Filters on the Datawindow')
If sle_filter_id.text <> ix_filter_data.sx_filter_id then
//DJP 11/7/95 - changed this mbox to be more explanatory
// Messagebox('EDIT','Please Retrieve the Filters before Update')
	Messagebox('EDIT','Please use Copy then Create to rename a filter')
	setmicrohelp(w_main,'Ready')
	RETURN
End IF

If dw_2.rowcount() <= 0 then
	Messagebox('EDIT','Please Enter Filters to be updated')
	setmicrohelp(w_main,'Ready')
	setfocus(sle_filter_val)
	RETURN
Else
		 sle_filter_id.text = ix_filter_data.sx_filter_id
End IF

lv_description = upper(sle_description.text)

// FDG 04/16/01
IF Trim(lv_description)	=	''		THEN	lv_description	=	ls_empty

// get the current date and time
//lv_cur_date_time = datetime(today(), now())   		//1-15-99 ts2020c use server date
lv_cur_date_time = gnv_app.of_get_server_date_time()	//1-15-99 ts2020c
sle_datetime.text = string(lv_cur_date_time,"M/D/YYYY hh:mm:ss")//1-15-99 format to display 4digit year 

// update the filter vals table

li_rc = dw_2.settransobject(stars2ca)
If li_rc <> 1 Then
   Errorbox(stars2ca,'Error setting trans object')
End If
li_rc = dw_2.EVENT ue_update( TRUE, TRUE )
If li_rc <> 1 Then
   MessageBox('EDIT','Error Adding to Filter Values Table')
   Return 
End If

// Add the new filter ID to the filter control table
// a couple of things are hard-coded
Update FILTER_CNTL  
	set filter_desc = :lv_description,
	    filter_datetime = :lv_cur_date_time
	where filter_id = Upper( :sle_filter_id.text )
Using stars2ca ;

If stars2ca.of_check_status() <> 0 then
	Errorbox(Stars2ca,'Error Updating to Filter Control')
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
setmicrohelp(W_main,'Filter successfully Updated')

// Update statistics
gnv_server.of_UpdateFilterStats( ix_filter_data.sx_filter_id )

//KMM 5-1-95 Update gv_active_filter
gv_active_filter = sle_filter_id.text

cb_retrieve.enabled = true
cb_retrieve.default = true
cb_copy.enabled = true

//cb_clear.enabled = true
RETURN
end event

type cb_create from u_cb within w_filter_maintain
event mouseover pbm_mousemove
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 1646
integer y = 1940
integer width = 334
integer height = 108
integer taborder = 140
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "Cr&eate"
end type

on mouseover;w_main.setmicrohelp('Creates Filters of Highlighted Rows Only')
end on

event clicked;//*******************************************************************
// DKG	02/27/96	Added 1 to upper ASCII value. z is 122 so value has
//             	to be less than 123 not 122. PROB 192 STARS 3.1
//             	Release disk.
//	FDG	10/02/00	Track 3005.  Stars 4.5 SP1.  All variables associated
//						with datawindow rows must be a 'long' instead of
//						integer.
//	FDG	12/05/00	Stars 4.7.  Make error checking DBMS-independent.
//	GaryR	01/11/01	Stars 4.7 Database Port - Empty String in SQL
//	GaryR	08/30/01	Track 2428d	Empty String in SQL
//	GaryR	09/20/02	Track 4622c	Prevent processing if 
//										filter create fails on the server
//	GaryR	12/22/04	Track 4163d	Trigger update on delete
//	GaryR	08/09/05	Track 4466d	Release FITLR_CNTL table lock
// MikeF	09/15/05 Track 4383c	Decode filters created from code list 
//	HYL	02/10/06	Track 4648d	Moved the character validation logic to n_cst_filter object
//	GaryR	04/05/06	Track 4383c	Make checkboxes function logically.
//	GaryR	05/23/06	Track 4750d	Do not select all rows when is_from = "L"
//	GaryR	06/20/06	Track 4014	Update filter table statistics
// GaryR	07/28/06	Track 4792	Change Int to Long to prevent 32K+ rows limit
//	GaryR	04/13/07	Track 4750	Reset update flags when copying filter
//*******************************************************************

string 	lv_filter_id, lv_description, lv_data_type, lv_col_name
long		i, li_rc, lv_row, lv_dw_row, lv_count		
datetime lv_cur_date_time
string 	lv_filter_string
int 		lv_filter_number
dec 		lv_filter_money
datetime lv_filter_date
string 	lv_char, ls_empty
string 	lv_table_name
string 	ls_sql, ls_rc, ls_date_value, ls_tbl_type

setpointer(hourglass!)
setmicrohelp(w_main,'Creating Filter...')

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

li_rc = Getselectedrow(dw_1,0)
If li_rc = 0  then 
	Messagebox('EDIT','Please Select Filters to be Created')
	setmicrohelp(w_main,'Ready')
	RETURN
End If

lv_description = upper(sle_description.text)
lv_data_type   = upper(ddlb_data_types.text)

// get the current date and time
lv_cur_date_time = gnv_app.of_get_server_date_time()	//ts2020c 
sle_datetime.text = string(lv_cur_date_time,"m/d/yyyy hh:mm:ss")//ts2020c format 4-digit year

// get the new filter ID
If sle_filter_id.text = '' then
	lv_filter_id = fx_get_next_key_id('FILTER')
	If lv_filter_id = 'ERROR' then
		Messagebox('EDIT','Unable to get Filter Id')
		RETURN
	End IF	
	sle_filter_id.text = lv_filter_id
Else 
	If len(sle_filter_id.text) > 10 then
		Messagebox('EDIT','Filter Id length can be maximum of 10 characters')
		setmicrohelp(w_main,'Ready')
		RETURN
	Else
		//This will pull each character from the case id
		//and validate that it is 0-9, A-Z, or a-z.
		//KMM 10-24-95 AK 129
		// 02/10/06 HYL Track 4648d Moved the character validation logic to n_cst_filter object
		IF NOT in_cst_filter.of_isvalid_tablename(sle_filter_id.text) THEN
			Messagebox('EDIT','Filter Id contains an invalid character.  Please Re-Key')
			setfocus(sle_filter_id)
			return
		END IF
		lv_filter_id = sle_filter_id.text
	End IF
End IF

lv_col_name = upper(ix_filter_data.sx_col_name)

// Add the new filter ID to the filter control table

Select count(*) 
into :lv_count
from Filter_Cntl
where filter_id = Upper( :lv_filter_id )
using stars2ca;

//	Release lock
Stars2ca.of_commit()

if lv_count > 0 then
	Messagebox('EDIT','Filter Exists with Filter ID ' + sle_filter_id.text + '.' + '~rRetrieve filter to update.')
	setmicrohelp(w_main,'Ready')
	Setfocus(sle_filter_id)
	cb_retrieve.enabled = true
	cb_retrieve.default = true
	RETURN
end if

IF Trim( lv_col_name )						= "" THEN lv_col_name						= ls_empty
IF Trim( gc_user_dept )						= "" THEN gc_user_dept						= ls_empty
IF Trim( ix_filter_data.sx_inv_type )	= "" THEN ix_filter_data.sx_inv_type	= ls_empty
IF Trim( lv_description )					= "" THEN lv_description					= ls_empty

// If Code Filter, concatenate column name + code type
// - FILTER_TBL_TYPE is 2 chars + Code type can be up to 5.
IF lv_col_name = 'CODE_CODE' THEN
	lv_col_name += ' - ' + trim(ix_filter_data.sx_inv_type)
	ls_tbl_type = ' '
ELSE
	ls_tbl_type = ix_filter_data.sx_inv_type
END IF

// Insert row into FILTER_CNTL
INSERT INTO FILTER_CNTL  
       ( DEPT_ID,   
         USER_ID,   
         FILTER_ID,   
         FILTER_TBL_TYPE,   
         FILTER_COL,   
         FILTER_DATETIME,   
         FILTER_DESC,   
         FILTER_DATA_TYPE,
			DELETE_IND)  
VALUES ( :gc_user_dept,   
         :gc_user_id,   
         :lv_filter_id,   
         :ls_tbl_type,   
         :lv_col_name,   
         :lv_cur_date_time,   
         :lv_description,   
         :lv_data_type,' ') 
Using stars2ca ;

If stars2ca.of_check_status() <> 0 then
	
	// Check for duplicates
	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		If stars2ca.of_commit() <> 0 Then Return

		Messagebox('EDIT','Filter Exists with Filter ID ' + sle_filter_id.text)
		setmicrohelp(w_main,'Ready')
		Setfocus(sle_filter_id)
		RETURN
	Else
		Stars2ca.of_rollback()
		Errorbox(Stars2ca,'Error writing to Filter Control')
		RETURN
	End IF
End IF

//	Release lock
Stars2ca.of_commit()

// insert the filter ID into invisible dw for Rows Highlited

For i = 1 to dw_1.RowCount()
	If dw_1.IsSelected(i) = false then
		dw_2.deleterow(i)
		i = i - 1
	End IF
Next

// Call the server method to create the filter table
IF left(lv_col_name,9) = 'CODE_CODE'					&
OR len(trim(lv_col_name)) = 0  				&
OR len(trim(ix_filter_data.sx_inv_type)) = 0 THEN
	// Code filter or Imported filter
	li_rc = gnv_server.of_CreateFilterTable(lv_filter_id, lv_data_type, lv_table_name)
ELSE
	// All other filters
	li_rc = gnv_server.of_CreateFilterTable(lv_filter_id, ix_filter_data.sx_inv_type, lv_col_name, lv_table_name)
END IF

//	GaryR	09/20/02	SPR 4622c - Begin
IF li_rc < 0 THEN
	//	Delete the previously inserted row from filter_cntl
	DELETE FROM FILTER_CNTL
	WHERE FILTER_ID = :lv_filter_id
	USING Stars2ca;
	
	Stars2ca.of_commit()
	w_main.SetMicroHelp( "Create filter failed" )
	Return		
END IF
//	GaryR	09/20/02	SPR 4622c - End

//KMM Checks to see if coming from copy
//KMM Has to select all items form dw and do an insert when the copy button has been clicked first  
//LMC This code that performs insert is not needed according to specs?
ls_rc=dw_2.modify("datawindow.table.updatetable='"+lv_table_name + "'")
if iv_from_copy = true then
	lv_dw_row = dw_2.rowcount()
	for lv_row = 1 to lv_dw_row
		IF	gnv_sql.of_is_character_data_type (lv_data_type)	THEN
			lv_filter_string = dw_2.getitemstring(lv_row,is_filter_column_name)
			ls_sql = "insert into " + lv_table_name + " ( filter_data ) values ( '" + lv_filter_string + "' ) "
		ELSEIF gnv_sql.of_is_number_data_type (lv_data_type)	THEN
			lv_filter_number = dw_2.getitemnumber(lv_row,is_filter_column_name)
			ls_sql = "insert into " + lv_table_name + " ( filter_data ) values ( " + string(lv_filter_number) + " ) "
		ELSEIF gnv_sql.of_is_money_data_type (lv_data_type)	THEN
			lv_filter_money = dw_2.getitemdecimal(lv_row,is_filter_column_name)
			ls_sql = "insert into " + lv_table_name + " ( filter_data ) values ( " + string(lv_filter_money) + " ) "
		ELSEIF gnv_sql.of_is_date_data_type (lv_data_type)	THEN
			lv_filter_date = dw_2.getitemdatetime(lv_row,is_filter_column_name)
			ls_date_value = gnv_sql.of_get_to_date(string(lv_filter_date))
			ls_sql = "insert into " + lv_table_name + " ( filter_data ) values (" + ls_date_value + ") "
		END IF	
		
			
		execute immediate :ls_sql Using stars2ca;
		
		If stars2ca.of_check_status() <> 0 then
			Errorbox(Stars2ca,'Error writing to Filter Vals Table: ' + lv_table_name)
			RETURN
		End IF 
	next
	
	//	Reset update flags
	dw_2.ResetUpdate()
//KMM END
else
	li_rc = dw_2.settransobject(stars2ca)
	If li_rc <> 1 Then
   	Errorbox(stars2ca,'Error setting trans object')
	End If
	li_rc = dw_2.EVENT ue_update( TRUE, TRUE )
	If li_rc <> 1 Then
  		MessageBox('EDIT','Error Adding to Filter Values Table')
   	Return 
	End If
end if

iv_from_copy = false
ib_exists = TRUE
st_row_count.text = string(dw_1.rowcount())

If stars2ca.of_commit() <> 0 Then Return
setmicrohelp(W_main,'Filter successfully created')

// Update statistics
gnv_server.of_UpdateFilterStats( lv_filter_id )

//KMM 5-1-95 Update gv_active_filter
gv_active_filter = lv_filter_id

this.enabled = false
cb_update.enabled = true
cb_update.default = true
cb_copy.enabled   = true
cb_retrieve.enabled = true
cb_clear.enabled = false
ix_filter_data.sx_filter_id = sle_FILTER_ID.TEXT
cbx_selectall.CHECKED = FALSE
cbx_selectall.TriggerEvent( Clicked! )

RETURN
end event

type gb_1 from groupbox within w_filter_maintain
string accessiblename = "Filter Values"
string accessibledescription = "Filter Values"
accessiblerole accessiblerole = groupingrole!
integer x = 1243
integer y = 1692
integer width = 2222
integer height = 224
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Filter Values"
end type

type gb_2 from groupbox within w_filter_maintain
string accessiblename = "Control"
string accessibledescription = "Control"
accessiblerole accessiblerole = groupingrole!
integer x = 23
integer y = 4
integer width = 3424
integer height = 416
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
string text = "Control"
end type

type dw_1 from u_dw within w_filter_maintain
string accessiblename = "Filter"
string accessibledescription = "Filter"
integer x = 23
integer y = 448
integer width = 3429
integer height = 1232
integer taborder = 70
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;// 07/28/06	GaryR	Track 4792	Change Int to Long to prevent 32K+ rows limit

Long lv_cur_row, lv_rc 
boolean lv_result

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
//lv_cur_row = getclickedrow(dw_1)
lv_cur_row = row
If lv_cur_row < 0 then
	setmicrohelp(w_main,'Select a Valid Row')
	RETURN
ElseIf lv_cur_row > 0 Then
	  If dw_1.IsSelected(lv_cur_row) = True Then
		 dw_1.selectrow(lv_cur_row,FALSE)
	    in_highlighted_rows = in_highlighted_rows - 1
	  Else
   	 dw_1.selectrow(lv_cur_row,TRUE)
	    in_highlighted_rows = in_highlighted_rows + 1
	  End If
End If

lv_rc = Getselectedrow(dw_1,0)
If lv_rc = 0  then 
	cbx_selectall.CHECKED = FALSE
	CBX_SELECTALL.TRIGGEREVENT(CLICKED!)
	RETURN
End If

setpointer(arrow!)
end event

