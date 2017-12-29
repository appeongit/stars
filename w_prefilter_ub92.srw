HA$PBExportHeader$w_prefilter_ub92.srw
$PBExportComments$Displays and formats where criteria for HCPCs and Revenue Codes (Inherited from w_master)
forward
global type w_prefilter_ub92 from w_master
end type
type cb_1 from u_cb within w_prefilter_ub92
end type
type cb_ignore from u_cb within w_prefilter_ub92
end type
type cb_ok from u_cb within w_prefilter_ub92
end type
type dw_criteria from u_dw within w_prefilter_ub92
end type
end forward

global type w_prefilter_ub92 from w_master
string accessiblename = "Subset Prefilter "
string accessibledescription = "Subset Prefilter "
accessiblerole accessiblerole = windowrole!
integer x = 187
integer y = 412
integer width = 2875
integer height = 1000
string title = "Subset Prefilter "
windowtype windowtype = response!
long backcolor = 67108864
cb_1 cb_1
cb_ignore cb_ignore
cb_ok cb_ok
dw_criteria dw_criteria
end type
global w_prefilter_ub92 w_prefilter_ub92

type variables
string is_src_type
string is_prefix
string is_subset_id[]
int      ii_filter_count
int      ii_index
n_cst_prefilter_attrib inv_cst_prefilter_attrib
end variables

forward prototypes
public function integer wf_check_filter_datatype (string as_filter_id, ref string as_data_field, ref string as_data_type)
public function string wf_format_sql ()
end prototypes

public function integer wf_check_filter_datatype (string as_filter_id, ref string as_data_field, ref string as_data_type);//******************************************************************
// 03-16-98 ajs 4.0 TS145 - Hard Coding Removal
// 06-12-96 FNC Accommodate an array of subset id's. Filter could 
//              been used for any of the subsets. Orginally only 
//              checked the first one.
//******************************************************************

string lv_filter_tbl, lv_filter_col, lv_data_type
n_tr lt_transaction
setpointer(hourglass!)
integer lv_upperbound

lv_upperbound = upperbound(is_subset_id)
For ii_index = 1 to lv_upperbound
	lt_transaction = stars2ca
	select filter_tbl_type, filter_col, FILTER_DATA_TYPE
	into :lv_filter_tbl, :lv_filter_col, :LV_DATA_TYPE
	 from sub_filter_cntl
	 where subc_id = Upper( :is_subset_id[ii_index] ) and
		  filter_id = Upper( :as_filter_id )
	Using lt_transaction;
	if lt_transaction.of_check_status() = 0 then EXIT
Next

If lt_transaction.sqlcode = 100 then
	MessageBox ('EDIT','Filter does not exist')
	RETURN lt_transaction.sqlcode
Elseif lt_transaction.sqlcode <> 0 then
		 RETURN lt_transaction.sqlcode
End If

If upper(lv_data_type) = 'CHAR' then
	as_data_field = ' FILTER_STRING '
ELSEIf UPPER(LV_DATA_TYPE) = 'NUMBER' Then
		 as_data_field = ' FILTER_NUM '
ELSEIf UPPER(lv_data_type) = 'MONEY'  THEN
		 as_data_field = ' FILTER_MONEY '
ELSEIf UPPER(LV_DATA_TYPE) = 'DATE'   THEN
		 as_data_field = ' FILTER_DATE '
END IF	

as_DATA_TYPE = LV_DATA_TYPE
Return 0
end function

public function string wf_format_sql ();//****************************************************************
// 06-13-96 FNC 	Set subset id in where statement = to the subset id
//             	that contains the filter. This is necessary for 
//              	situations where more than one subset is selected 
//						i.e. Random Sampling.
// 03-16-98 ajs   4.0 TS145 - Hard Coding Removal
// 07/21/98 ajs   4.0 Track #1524 - correct return sql if 2 or more
//                filters are selected.
// 08-03-98 ajs   4.0 Track #1524 - correct extra formatting for INs
// 04-10-00 ktb   Track #2782 - Errors retrieving subset summary
//                using a filter for a fast track query
//	12/14/00	FDG	Stars 4.7.
//						1. Make data type checking DBMS-independent
//						2. Make dates DBMS-independent
//	04/23/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
// 11/16/01 FNC 	Track 3759 Starcare. Replace join to sub_filter_vals
//						with an inner select.
//	04/08/04	GaryR	Track 3759c	Allow user to choose logical operand
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//	06/29/07 Katie		SPR5091 Added WHERE logic to ensure we are only pulling back the values for 
//							that particular filter_id.
//	07/09/07 Katie		SPR5091 Added logic to get the subset id of the selected row for the where statement.
//****************************************************************

String ls_expone,	ls_exptwo,	ls_temp
String ls_relop,ls_logic, ls_lp, ls_rp
String ls_type
Int    li_row,li_rc, li_row_count, li_next_row, li_selected
String ls_sql
String ls_frmt_exp
String ls_format_line
String ls_filter_id, ls_filter_type, ls_filter_field
string ls_alias = 'FV'
boolean	lb_lp = TRUE
string ls_subset_id

dw_criteria.AcceptText()
li_row_count = dw_criteria.RowCount()

For li_row = 1 to li_row_count
 if isSelected(dw_criteria,li_row) then
	ls_rp = ""
	ls_lp = ""
	IF lb_lp THEN ls_lp = "("
	lb_lp = FALSE
	
	ls_expone = trim(getitemstring(dw_criteria,li_row,1))
	li_rc = pos(ls_expone,'.')
	if li_rc  >  0 then
		ls_expone = is_prefix + mid(ls_expone,li_rc+1)
	end if
	ls_relop  = trim(getitemstring(dw_criteria,li_row,2))
	ls_exptwo = trim(getitemstring(dw_criteria,li_row,3))
	li_next_row = dw_criteria.GetSelectedRow(li_row)
	if li_next_row > 0 then
		IF dw_criteria.object.criteria_used_line_crit_exp1[li_row] <> &
			dw_criteria.object.criteria_used_line_crit_exp1[li_next_row] THEN
			ls_rp = ")"
			lb_lp = TRUE
		END IF
		ls_logic	 = Trim( dw_criteria.GetItemString( li_row, "crit_logic" ) )
	else
   	ls_logic  = ""
		ls_rp = ")"
	end if
	ls_type   = trim(getitemstring(dw_criteria,li_row,5))
	ls_subset_id   = Trim( dw_criteria.GetItemString( li_row, "by_id" ) )

	If (ls_type <> 'JOIN' and pos(ls_exptwo,'@')  = 0 ) then
		// FDG 12/14/00 begin
		IF gnv_sql.of_is_date_data_type (ls_type)				THEN
			// Call format_where() for editing purposes only since it places
			//	quotes around the value
			ls_temp	=	format_where(ls_exptwo,ls_relop,'')
			IF	Left (ls_temp, 1)	=	'!'		THEN
				// Error occurred
				ls_exptwo	=	ls_temp
			ELSE
				// Make sure the date value is DBMS-independent
				ls_exptwo	=	gnv_sql.of_get_to_date (ls_exptwo)
			END IF
		ELSEIF gnv_sql.of_is_character_data_type (ls_type)	THEN
			If ls_relop = 'IN' then							//AJS 08-03-98 Track #1524
				//bypass format
				ls_frmt_exp = ls_exptwo
			else
				ls_frmt_exp = format_where(ls_exptwo,ls_relop,'')
			End If
		Else
			// Numeric data type
			ls_frmt_exp = format_where_n(ls_exptwo,ls_relop)	
		End If
		// FDG 12/14/00 end
		If mid(ls_frmt_exp,1,1) = '!' then
			Messagebox('Syntax Error',ls_frmt_exp + ' in line' + string(li_row))
			RETURN ''
		End If
	ELSE
			ls_frmt_exp = ls_exptwo
	End IF

	//ajs 07/21/98 4.0 Track #1524
	If pos(ls_exptwo,'@')  = 0 then
		ls_format_line =  ls_format_line + ' ' + ls_lp + ls_expone + ' ' + ls_relop + ' ' + &
								ls_frmt_exp  + ' ' + ls_rp + ls_logic
	Else 
		ii_filter_count ++
		//	04/23/01	GaryR	Stars 4.7 DataBase Port
		ls_filter_id = Upper( mid(ls_exptwo,2) )
		li_rc = wf_check_filter_datatype(ls_filter_id,ls_filter_field,ls_filter_type)
		If li_rc = 100 then
			MessageBox ('EDIT','Filter does not exist')
			RETURN  ''
		elseif li_rc <> 0 then
			Messagebox('EDIT','Error reading Filter Control')
	 		RETURN  ''
		End IF
		
		//FNC 11/16/01 Start
		ls_format_line = ls_format_line + ' ' + ls_lp + '(' + ls_expone + ' IN (SELECT DISTINCT ' +trim(ls_filter_field) + &
										' FROM SUB_FILTER_VALS_' + ls_subset_id + ' WHERE FILTER_ID = ~'' + ls_filter_id + '~')'
								
		//FNC 11/16/01 End
		ls_format_line = ls_format_line  +  ') ' + ls_rp + ls_logic
	end if
	
	li_selected ++
	inv_cst_prefilter_attrib.ii_selected_rows[li_selected] = li_row
	inv_cst_prefilter_attrib.is_boolean[li_selected] = &
					Trim( dw_criteria.GetItemString( li_row, "crit_logic" ) )
 end if
Next	

//Return ls_sql
Return ls_format_line
end function

event open;call super::open;//****************************************************************
// 03-16-98 ajs 4.0 TS145 - Hard Coding Removal
// 11-26-96 FNC Prob #173 STARS35 Call color function
// 06-12-96 FNC Set li_value = 0 before parsing subset string
//
// 11/22/00	GaryR	Stars 4.7 DataBase Port - Conversion of data types
//	04/08/04	GaryR	Track 3759c	Allow user to choose logical operand
//	07/29/04	GaryR	Track 3759c	If no criteria found, close window
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//****************************************************************

int    li_value,li_pos
string ls_crit_type,ls_subset_id
boolean	lb_crit

li_value = pos(inv_cst_prefilter_attrib.is_where,'~~t')
if li_value = 0 then
	messagebox("EDIT",'Incorrect values passed through string parm')
	cb_ignore.postevent(clicked!)
	return
end if
is_src_type = left(inv_cst_prefilter_attrib.is_where, li_value - 1)
inv_cst_prefilter_attrib.is_where = mid(inv_cst_prefilter_attrib.is_where, li_value + 2)

li_value = pos(inv_cst_prefilter_attrib.is_where,'~~t')
if li_value = 0 then
	messagebox("EDIT",'Incorrect values passed through string parm')
	cb_ignore.postevent(clicked!)
	return
end if

is_prefix = left(inv_cst_prefilter_attrib.is_where, li_value - 1)
ls_subset_id = mid(inv_cst_prefilter_attrib.is_where, li_value + 2)
 
li_pos = pos(ls_subset_id,',')
if li_pos >  0 then
	li_value = 0										//06-12-96 FNC
	DO UNTIL li_pos =  0
		li_value++
		is_subset_id[li_value] = left(ls_subset_id, li_pos - 1)
		ls_subset_id = mid(ls_subset_id,li_pos + 1)
		li_pos = pos(ls_subset_id,',')
	LOOP


	//06-12-96 FNC  - Put in last subset id
	li_value++
	is_subset_id[li_value] = ls_subset_id   
else
	is_subset_id[1]	= ls_subset_id
end if

If settransobject(dw_criteria,Stars2ca) < 0 then	
	Messagebox('EDIT','Error Setting Transaction Object')
	cb_ignore.postevent(clicked!)
	RETURN 
End If

// 03-16-98 ajs 4.0 TS145 - Hard Coding Removal
//if  is_src_type = 'SC' then
//	 ls_crit_type = 'CAS'
//else
	 ls_crit_type = 'SUB'
//end if
// 03-16-98 ajs 4.0 end

// 11/22/00	GaryR	Stars 4.7 DataBase Port
gnv_sql.of_get_substring( dw_criteria )

li_value = dw_criteria.Retrieve(is_subset_id,ls_crit_type)

COMMIT using stars2ca;

if li_value = 0 then
	This.Visible = FALSE 
	cb_ignore.postevent(clicked!)
	Return
end if

//	Format rows with parens and operands
dw_criteria.object.crit_lp[1] = "("
IF li_value > 1 THEN
	FOR li_pos = 1 TO li_value - 1
		IF dw_criteria.object.criteria_used_line_crit_exp1[li_pos] <> &
			dw_criteria.object.criteria_used_line_crit_exp1[li_pos + 1] THEN
			dw_criteria.object.crit_rp[li_pos] = ")"
			dw_criteria.object.crit_logic[li_pos] = "AND"
			dw_criteria.object.crit_lp[li_pos + 1] = "("
		END IF
	NEXT
END IF
dw_criteria.object.crit_rp[li_value] = ")"

// If rows passed in, then select programmatically
li_value = UpperBound( inv_cst_prefilter_attrib.ii_selected_rows )
IF li_value > 0 THEN
	FOR li_pos = 1 TO li_value
		dw_criteria.SetItem( inv_cst_prefilter_attrib.ii_selected_rows[li_pos], &
				"crit_logic", inv_cst_prefilter_attrib.is_boolean[li_pos] )
		dw_criteria.SelectRow( inv_cst_prefilter_attrib.ii_selected_rows[li_pos], TRUE )
	NEXT
	cb_ok.Event clicked()
END IF
end event

on w_prefilter_ub92.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_ignore=create cb_ignore
this.cb_ok=create cb_ok
this.dw_criteria=create dw_criteria
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_ignore
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_criteria
end on

on w_prefilter_ub92.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_ignore)
destroy(this.cb_ok)
destroy(this.dw_criteria)
end on

event ue_preopen();call super::ue_preopen;
if not isnull(message.PowerObjectParm) then
	inv_cst_prefilter_attrib = message.PowerObjectParm
	SetNull(message.PowerObjectParm)
else
	messagebox("EDIT",'Missing input parameter for prefilter')
	cb_ignore.postevent(clicked!)
	return
end if

end event

type cb_1 from u_cb within w_prefilter_ub92
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2528
integer y = 768
integer width = 306
integer height = 108
integer taborder = 40
string text = "&Cancel"
end type

event clicked;//*****************************************************************
// 06-12-96 FNC New button added to allow user to cancel report
//*****************************************************************

inv_cst_prefilter_attrib.is_where = 'CANCEL'

Closewithreturn(parent,inv_cst_prefilter_attrib)

end event

type cb_ignore from u_cb within w_prefilter_ub92
string accessiblename = "Ignore"
string accessibledescription = "Ignore"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2217
integer y = 768
integer width = 306
integer height = 108
integer taborder = 30
string text = "&Ignore"
boolean cancel = true
end type

event clicked;//Track #1371 AJS 4.0 correct error when coming from subset summary analysis
//            07-21-98
inv_cst_prefilter_attrib.is_where = 'IGNORE'
Closewithreturn(parent,inv_cst_prefilter_attrib)

end event

type cb_ok from u_cb within w_prefilter_ub92
string accessiblename = "Apply"
string accessibledescription = "Apply"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1906
integer y = 768
integer width = 306
integer height = 108
integer taborder = 20
string text = "&Apply"
boolean default = true
end type

event clicked;//*****************************************************************************************************
// DKG 02/10/96 	Added an edit to disallow the user to use more than
//              	one filter in the prefilter. PROB 167 Stars 3.1
//              	Release disk.
//
// FNC 06/12/96 	Add edit to ensure that at lease one row has been
//              	selected
//
// FNC 04/16/98 	Track 1078 If revenue is in additional data source must open the
//					 	prefilter window. Instead of replacing quotes the extra quote
//						must be removed
// FNC 06/09/98	Track 1137. Remove spaces between '(' and ls_where
// FNC 01/17/02 	Track 2684. Only increment filter counter if filter is in criteria
//******************************************************************************************************

string ls_where, old_str, new_str, mystring
int 	 start_pos, li_i
string ls_filter_crit

int li_row, li_row_count				//DKG 02/10/96
int li_selected											//FNC 06/12/96

//DKG 02/10/96 BEGIN

li_selected = 0
li_row_count = dw_criteria.RowCount()
FOR li_row = 1 TO li_row_count
 IF IsSelected(dw_criteria, li_row) then
	 li_selected++									//06-12-96 FNC
	 if pos(trim(getItemString(dw_criteria,li_row,3)),'@') > 0 then		// FNC 01/17/02
		 inv_cst_prefilter_attrib.ii_filter_count++
		 ls_filter_crit=trim(getItemString(dw_criteria,li_row,3))
		 inv_cst_prefilter_attrib.is_filter_id[inv_cst_prefilter_attrib.ii_filter_count] = mid(ls_filter_crit,2)	//FNC 01/17/02
	end if
 END IF
NEXT

if li_selected = 0 then							//06-12-96 FNC Start
	MessageBox('EDIT', 'At least one row must be selected to apply')
	RETURN
end if												//06-12-96 FNC End

IF inv_cst_prefilter_attrib.ii_filter_count > 1 THEN
	MessageBox('EDIT', 'More than one filter cannot be used with prefilter.')
	RETURN
END IF
//DKG 02/10/96 END



ls_where = wf_format_sql()

start_pos = 1

old_str = "''"			//FNC 04/16/98
new_str = "'"			//FNC 04/16/98
mystring = ls_where

// Find the first occurrence of old_str.

start_pos = Pos(mystring, old_str, start_pos)

// Only enter the loop if you find old_str.
DO WHILE start_pos > 0

// Replace old_str with new_str.
	mystring = &
	  Replace(mystring, start_pos, Len(old_str), new_str)

// Find the next occurrence of old_str.
	start_pos = &
	  Pos(mystring, old_str, start_pos+Len(new_str))
LOOP

ls_where = mystring
//FNC 04/16/98 End

if ls_where > "" then
	ls_where =  " AND (" + ls_where + ")  "					// FNC 06/09/98
end if 

inv_cst_prefilter_attrib.is_where = ls_where

Closewithreturn(parent,inv_cst_prefilter_attrib)



end event

type dw_criteria from u_dw within w_prefilter_ub92
string accessiblename = "Filter Criteria"
string accessibledescription = "Filter Criteria"
accessiblerole accessiblerole = clientrole!
integer width = 2834
integer height = 752
integer taborder = 10
string dataobject = "d_prefilter_ub92"
boolean vscrollbar = true
end type

event clicked;int li_row_nbr

li_row_nbr = row

if isSelected(dw_criteria,li_row_nbr) Then
   Selectrow(dw_criteria,li_row_nbr,FALSE)
else
   Selectrow(dw_criteria,li_row_nbr,TRUE)
end if
end event

