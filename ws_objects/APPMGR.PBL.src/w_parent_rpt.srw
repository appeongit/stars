$PBExportHeader$w_parent_rpt.srw
$PBExportComments$inherited from w_master
forward
global type w_parent_rpt from w_master
end type
type ddlb_dw_ops from dropdownlistbox within w_parent_rpt
end type
type cb_clear from u_cb within w_parent_rpt
end type
type st_1 from statictext within w_parent_rpt
end type
type cb_save_report from u_cb within w_parent_rpt
end type
type sle_count from singlelineedit within w_parent_rpt
end type
type cb_stop from u_cb within w_parent_rpt
end type
type mle_crit from multilineedit within w_parent_rpt
end type
type cb_query from u_cb within w_parent_rpt
end type
type cb_view_detail from u_cb within w_parent_rpt
end type
type cb_close from u_cb within w_parent_rpt
end type
type dw_1 from u_dw within w_parent_rpt
end type
end forward

global type w_parent_rpt from w_master
string accessiblename = "Summary Report"
string accessibledescription = "Summary Report"
integer x = 169
integer y = 0
integer height = 1688
string title = "Summary Report"
event ue_query ( )
ddlb_dw_ops ddlb_dw_ops
cb_clear cb_clear
st_1 st_1
cb_save_report cb_save_report
sle_count sle_count
cb_stop cb_stop
mle_crit mle_crit
cb_query cb_query
cb_view_detail cb_view_detail
cb_close cb_close
dw_1 dw_1
end type
global w_parent_rpt w_parent_rpt

type variables
string in_holdmod_dw_1,in_hold_object,in_holdrow,in_what
string in_crit,in_current_sub_src_name
string in_subset_business
string in_select,in_where
int in_crit_level
string in_step_id
string in_subset_called_from
boolean in_call_prev_crit, iv_insert_crit, iv_filter_used
boolean in_copy_src_filt
n_tr	 in_transaction_object				// FDG 02/20/01
string in_table_type,in_sql,in_save_name,in_current_sub_src_type
long in_row_count, in_ss_rows
long in_period,cnt
int in_num_rows_sel,in_row_nbr,rc
string in_exp1[],in_exp2[],in_op[],in_logic[]
String in_left_paren[],in_right_paren[]
boolean in_create, in_subset_incomplete
string  in_columns_selected
string in_transaction_type,in_header
boolean in_subset_created
boolean in_create_subset_DW,in_going_to_claim
boolean in_subset_already_called
u_cb in_button_not_modified[]
sx_analysis_structure in_detail_struct
long in_dw_limit
w_uo_win iv_uo_win
string iv_invoice_type
string in_case_id, in_case_spl, in_case_ver
string in_selected,in_dw_control
sx_decode_structure in_decode_struct
boolean in_retrieve_cancelled
int in_end_cntr
string iv_schedule
boolean ib_schedule_sub = FALSE
boolean iv_xref_used
boolean ib_win_busy
string is_show_window // jww 10/30/97 spec 127 only used by w_ratio_proc_sum

n_cst_tableinfo_attrib	inv_table		// FDG 03/16/01

long		il_period_key						// FDG 03/16/01

end variables

forward prototypes
public function integer wf_strip_outer_join ()
public subroutine wf_process_crit_for_display ()
public function integer fw_variable_load (string arg_direction)
public function integer wf_get_base_tables (string as_inv_type, long al_period_key)
public function long wf_count_data (string as_inv_type[])
public function string wf_create_where (string as_table_type)
end prototypes

event ue_query;//john_wo 11/6/97 spec 127 3.6 code copied from cb_query
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//	03/18/01	FDG	Stars 4.7.	Use wf_count_data instead of fx_count_data since
//						ros_directory is no longer used.


string table_type[2]


//Does a special count if the query is against the claim data//
in_detail_struct.prov_query_structure.do_prov_query = false
if in_going_to_claim = TRUE Then
	// FDG 03/18/01 - Use wf_count_data instead of fx_count_data
	//sle_count.text = string(fx_count_data(in_detail_struct.table_type, &
	//												gv_number_of_tables, &
	//												in_detail_struct.src_type, &
	//												in_detail_struct.where_statement, &
	//												in_detail_struct.tbl_directory, &
	//												in_detail_struct.table_type, &
	//												TRUE, &
	//												0, &
	//												in_detail_struct.prov_query_structure))
	if gc_debug_mode = TRUE THEN
		f_debug_box('Debug','SQL where clause '	+	in_detail_struct.where_statement)
	end if
	sle_count.text	=	String(This.wf_count_data(in_detail_struct.table_type))
	// FDG 03/18/01 - end
else
string lv_select,u_hicn
	setpointer(hourglass!)
	in_what = upper(in_what)
	lv_select = 'Select count(*) '+in_what+in_crit
		if gc_debug_mode = TRUE THEN
			f_debug_box('Debug','Execute SQL = '	+	lv_select)
		end if
   	SQLCA.LogID = in_transaction_object.LogID
		SQLCA.LogPass = in_transaction_object.LogPass
		SQLCA.ServerName = in_transaction_object.ServerName
		SQLCA.Lock = in_transaction_object.Lock
		SQLCA.DBMS = in_transaction_object.DBMS
		SQLCA.database = in_transaction_object.database
		SQLCA.userid = in_transaction_object.userid
		SQLCA.dbpass = in_transaction_object.dbpass
		//sqlcmd('connect',sqlca,'Error Connecting to Database',5)		// FDG 02/20/01
		SQLCA.of_connect()															// FDG 02/20/01
		DECLARE c1 DYNAMIC CURSOR FOR SQLSA;
   	PREPARE SQLSA FROM :lv_select;
		CNT = 0
   	if sqlca.of_check_status() <> 0 then
      	errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
	      return
   	end if
		OPEN DYNAMIC c1;
   	if sqlca.of_check_status() <> 0 then
      	errorbox(sqlca,'Error Opening the Sum_prov table')
	      return
   	end if
	   Fetch c1 into :sle_count.text;
		If (sqlca.of_check_status() = 100) then
			RETURN
		end if
	 
		if sqlca.sqlcode <> 0 then
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
		SQLCA.of_disconnect()
end if
end event

public function integer wf_strip_outer_join ();int index, new_ind
string lv_exp1[], lv_op[], lv_left_paren[], lv_right_paren[]
string lv_exp2[], lv_logic[], lv_elem_name, lv_clear[]
boolean lv_outer_join
int lv_upperbound

// BV 7/16/95 - logic to prevent 'outer-join' lines from going into	
// the criteria, because they are only there for the claim report output
// They are stripped here because they need to be in the globals for
// use in the fx_remove_pay_date function

index = 1
lv_upperbound = upperbound(gv_exp1)

Do while index <= lv_upperbound
	if gv_op[index] = '*=' then
		 lv_outer_join = true
		 exit
	end if
	index ++
loop

if lv_outer_join = false then return 0

// Below will only happen if outer join is true

index = 1
new_ind = 1

Do while index <= lv_upperbound

	If gv_exp1[index] <> '' or gv_left_paren[index] <> '' or gv_right_paren[index] <> '' then		//KMM 6/23 Added code to check for left or right paren because it is a valid line
		If pos(gv_exp1[index],'.') > 0 then
			lv_elem_name = mid(gv_exp1[index],4)
		Else
			lv_elem_name = gv_exp1[index]
		End IF

		// Load all non-outer-join criteria into local vars with new index

		If lv_elem_name = 'CASE_ID' or lv_elem_name = 'CASE_SPL' or  &
			lv_elem_name = 'CASE_VER' or lv_elem_name = 'SUBC_ID' or  &
			gv_op[index] = '*=' then	
				index++
				continue		
		else
				lv_left_paren[new_ind] = gv_left_paren[index]
				lv_right_paren[new_ind] = gv_right_paren[index]
				lv_op[new_ind] = gv_op[index]
				lv_exp1[new_ind] = gv_exp1[index]
				lv_exp2[new_ind] = gv_exp2[index]
				lv_logic[new_ind] = gv_logic[index]
				new_ind ++
				index++
				continue		
		end if
	Else					//pat-d alabama 8/8/95
			index++	//pat-d alabama 8/8/95
	end if
loop

gv_left_paren[] = lv_clear[]
gv_right_paren[] = lv_clear[]
gv_op[] = lv_clear[]
gv_exp1[] = lv_clear[]
gv_exp2[] = lv_clear[]
gv_logic[] = lv_clear[]

index = 1
lv_upperbound = upperbound(lv_exp1)

Do while index <= lv_upperbound
		gv_left_paren[index] = lv_left_paren[index]
		gv_right_paren[index] = lv_right_paren[index]
		gv_op[index] = lv_op[index]
		gv_exp1[index] = lv_exp1[index]
		gv_exp2[index] = lv_exp2[index]
		gv_logic[index] = lv_logic[index]
		index++
		continue		
loop

return 0
end function

public subroutine wf_process_crit_for_display ();//******************************************************************
//	07/14/97 - remove in_sql and in_header as arguments
//	05/01/01	GaryR	Stars 4.7 DataBase Port - Remove view CODE_DESC
//******************************************************************
//This function will take the in_sql and create the criteria output
//for both the MLE in the window and the Datawindow
//    ARGUMENTS:	STRING IN_SQL - SQL used for select
//						STRING IN_HEADER - Header of report
//

string crit, criteria_string, temp_str
long qupos, position
string old_str, new_str
int start_pos

SetPointer(HourGlass!)
//These statements fill the mle with all information after the WHERE
//in the SQL Statement
position = pos (in_sql,'WHERE')+6
crit = mid(in_sql,position)
position = pos(crit,'ORDER')
if position <> 0 then
	crit = left(crit,position - 1) 
end if

//SKM: These statements change all likes back to equal signs//
old_str = 'LIKE'
new_str = '='
criteria_string = crit
start_pos = Pos(criteria_string,old_str,1)

	DO WHILE start_pos > 0
		// Replace old_str with new_str.
		criteria_string = Replace(criteria_string,start_pos,Len(old_str),new_str)
		// Find the next occurrence of old_str.
		start_pos = Pos(criteria_string,old_str,start_pos+Len(old_str))
	LOOP

mle_crit.text = criteria_string     // LOAD MLE

//	05/01/01	GaryR	Stars 4.7 DataBase Port - Begin
//// Now work on loading datawindow with criteria text
//qupos = pos(criteria_string,"'")
//do while (qupos > 0)                //remove embedded quotes
//	criteria_string = left(criteria_string,qupos - 1) + mid(criteria_string, qupos + 1)
//	qupos = pos(criteria_string,"'")
//LOOP
//criteria_string = trim(criteria_string)
//temp_str = "criteria_text.text=" + "~'" + Criteria_string + "~'"
//dw_crit_print.Modify(temp_str)
//
//// fix up header for display in datawindow
//position = pos(in_header,"~n")         //remove new line
//if position > 0 then 
//	in_header = left(in_header,position - 1) + " " + mid(in_header,position + 1)
//end if
//qupos = pos(in_header,"'")
//do while (qupos > 0)                //remove embedded quotes
//	in_header = left(in_header,qupos - 1) + mid(in_header, qupos + 1)
//	qupos = pos(in_header,"'")
//LOOP
//if in_header = "" then
//	in_header = "The Report That Follows"
//end if
//temp_str = "criteria_print_msg.text=" + "~'CRITERIA USED FOR:~n" + in_header + "~'"
//dw_crit_print.Modify(temp_str)
//
//// The following will insert a dummy row so the save/view DW will work 
//dw_crit_print.InsertRow(0)
//dw_crit_print.SetItem(1,1," ")
////dw_crit_print.visible = TRUE			// FDG 07/31/97
//dw_crit_print.BringToTop = FALSE
//
//RETURN(TRUE)
//	05/01/01	GaryR	Stars 4.7 DataBase Port - End
end subroutine

public function integer fw_variable_load (string arg_direction);
int index

string lv_clear_array[] 
int lv_exp1_upperbound, lv_left_upperbound, lv_right_upperbound

setpointer(hourglass!)
index = 1
if arg_direction = 'GV' Then
	gv_left_paren[]  = lv_clear_array[] 
	gv_exp1[] 	= lv_clear_array[] 
	gv_op[]   	= lv_clear_array[] 
	gv_exp2[] 	= lv_clear_array[] 
	gv_right_paren[] = lv_clear_array[] 
	gv_logic[]  	= lv_clear_array[] 

	gv_left_paren[]  = in_left_paren[]
	gv_exp1[] 	= in_exp1[]
	gv_op[]   	= in_op[]
	gv_exp2[] 	= in_exp2[]
	gv_right_paren[] = in_right_paren[]
	gv_logic[]  	= in_logic[]
Elseif arg_direction = 'IN' Then
	in_left_paren[]  = lv_clear_array[] 
	in_exp1[] 	= lv_clear_array[] 
	in_op[]   	= lv_clear_array[] 
	in_exp2[] 	= lv_clear_array[] 
	in_right_paren[] = lv_clear_array[] 
	in_logic[]  	= lv_clear_array[] 

   lv_exp1_upperbound = upperbound(gv_exp1)
	lv_left_upperbound = upperbound(gv_left_paren)
	lv_right_upperbound = upperbound(gv_right_paren)

	DO WHILE  index <= lv_exp1_upperbound 
		if index <= lv_left_upperbound then
			if gv_left_paren[index] = '(' and gv_exp1[index] = '' then
				gv_exp1[index] = ' '
			end if
		end if
		if	index <= lv_right_upperbound then 
			if gv_right_paren[index] = ')' and gv_exp1[index] = '' then
				gv_exp1[index] = ' '
			end if
		end if
				
		If gv_exp1[index] <> '' Then
			If index > upperbound(gv_left_paren) then
				gv_left_paren[index] = ''
			End IF
			If index > upperbound(gv_right_paren) then
				gv_right_paren[index] = ''
			End IF
			If index > upperbound(gv_logic) then
				gv_logic[index] = ''
			End IF
			in_left_paren[index] = gv_left_paren[index]  
			in_exp1[index] 	= gv_exp1[index]
			in_op[index]   	= gv_op[index]
			in_exp2[index] 	= gv_exp2[index]
			in_right_paren[index] =	gv_right_paren[index]
			in_logic[index]  	= gv_logic[index]
		end if
		index = index + 1
	LOOP
End If	

RETURN 0
end function

public function integer wf_get_base_tables (string as_inv_type, long al_period_key);////////////////////////////////////////////////////////////////////////
//	Script:		w_parent_rpt.wf_get_base_tables()
//
//	Arguments:	1.	as_inv_type - Invoice type of the base table
//					2.	al_period_key - Period key used to get the payment dates
//
//	Returns:		Integer.		1 = success, -1 = error.
//
//	Description:
//			This function will take the parms and get the base table names
//			and store them in inv_table (n_cst_tableinfo_attrib).  This
//			function is needed because ros_directory is no longer used.  As a
//			result, Stars Server will be called to generate the list of
//			table names.  Consequently, function wf_count_data() will take
//			the list of tables to generate counts.
//
////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	03/16/01	Stars 4.7.  Created
//
////////////////////////////////////////////////////////////////////////

Integer	li_rc

// Edit the input
IF	IsNull (as_inv_type)				&
OR	Trim (as_inv_type)	=	''		THEN
	MessageBox ('Application Error', 'In w_parent_rpt.wf_get_base_tables(), invoice type is required')
	Return	-1
END IF

IF	IsNull (al_period_key)				&
OR	al_period_key				=	0		THEN
	MessageBox ('Application Error', 'In w_parent_rpt.wf_get_base_tables(), period key is required')
	Return	-1
END IF

inv_table.is_inv_type		=	as_inv_type
inv_table.is_operand			=	''
inv_table.is_paid_date		=	''
inv_table.il_period_key		=	al_period_key

li_rc								=	gnv_server.of_GetClaimsTableNames (inv_table)
IF	inv_table.il_rc			<	0			THEN
	MessageBox ('Error', inv_table.is_message)
	Return	-1
END IF

Return	1






end function

public function long wf_count_data (string as_inv_type[]);////////////////////////////////////////////////////////////////////////
//	Script:		w_parent_rpt.wf_count_data()
//
//	Arguments:	1. as_inv_type[]
//
//	Returns:		Long.		-1 = error.
//
//	Description:
//			This function replaces global function fx_count_data().
//
//			This function will take the query in in_detail_struct and perform
//			a Select Count(*) as many times as specified.  At the end, the total
//			count is returned.
//
////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	03/16/01	Stars 4.7.  Created
//
////////////////////////////////////////////////////////////////////////

Integer	li_upper,			&
			li_idx,				&
			li_idx2,				&
			li_pos,				&
			li_rc,				&
			li_max_tables

String	ls_sql,				&
			ls_where,			&
			ls_multi_ind[],	&
			ls_filter,			&
			ls_table,			&
			ls_from,				&
			ls_select
			
Long		ll_count,			&
			ll_temp_count,		&
			ll_rowcount,		&
			ll_row

// u_nvo_count is used to get the count
u_nvo_count		lnv_count

// Storage NVO that contains a list of table names for an invoice type
n_cst_tableinfo_attrib	lnv_table[]

// Edit the input
IF	in_detail_struct.src_type	<>	'SB'		THEN
	MessageBox ('Query Count', 'Count against a non base claims table attempted.  '	+	&
					'Count failed!', StopSign!)
	Return	-1
END IF

ls_select	=	'SELECT COUNT(*) '

// Remove 'Order by' from the where clause
ls_where	=	Upper (in_detail_struct.where_statement)
li_pos	=	Pos (ls_where, 'ORDER BY')

IF	li_pos	>	0		THEN
	ls_where	=	Left (ls_where, li_pos - 1)
END IF

lnv_count	=	CREATE	u_nvo_count
lnv_count.uf_set_transaction (Stars1ca)

li_upper		=	UpperBound (as_inv_type)

// For each invoice type, get the table names and get the count for each table

FOR li_idx	=	1 TO li_upper
	// Only get the table name from gnv_server for base table.  Determine if this
	// invoice type is an ancillary invoice type.
	ls_filter	=	"rel_type = 'AN' and id_2 = '"	+	as_inv_type[li_idx]	+	"'"
	w_main.dw_stars_rel_dict.SetFilter("")  // Clear out prior filter
	w_main.dw_stars_rel_dict.Filter()
	w_main.dw_stars_rel_dict.SetFilter(ls_filter)
	w_main.dw_stars_rel_dict.Filter()
	ll_rowcount	=	w_main.dw_stars_rel_dict.RowCount()
	lnv_table[li_idx].is_inv_type		=	as_inv_type[li_idx]
	lnv_table[li_idx].is_operand		=	''
	lnv_table[li_idx].is_paid_date	=	''
	lnv_table[li_idx].il_period_key	=	il_period_key
	IF	ll_rowcount	<	1		THEN
		// Base table - Call gnv_server to get table names
		li_rc									=	gnv_server.of_GetClaimsTableNames (lnv_table[li_idx])
		IF	lnv_table[li_idx].il_rc		<	0		THEN
			MessageBox ('Error', 'Error retrieving table names in w_parent_rpt.wf_count_data().  '		+	&
							lnv_table[li_idx].is_message	+	'.  Invoice type = '	+	as_inv_type[li_idx]	+	&
							'.  Period key = '	+	String(il_period_key)	+	'.')
			Return	-1
		END IF
	ELSE
		// Ancillary invoice type - Get table name from w_main
		ls_table		=	w_main.dw_stars_rel_dict.object.value_a [1]
		lnv_table[li_idx].is_base_table[1]	=	ls_table
	END IF
	// Determine 
NEXT

// For each invoice type, get the count for each table name
li_max_tables	=	UpperBound (lnv_table[1].is_base_table)

FOR li_idx	=	1 TO li_max_tables
	ls_from	=	''
	// For each month of data, join the tables passed
	FOR li_idx2	=	1 TO	li_upper
		ls_from	=	ls_from	+	', '	+	lnv_table[li_idx2].is_base_table[li_idx]	+	&
						' '		+	as_inv_type[li_idx2]
	NEXT
	// Remove leading ', ' from the 'From' clause
	IF	Len (Trim(ls_from))	>	0		THEN
		ls_from	=	Mid (ls_from, 3)
	END IF
	// construct the SQL and get the count
	ls_sql			=	ls_select	+	' FROM '	+	ls_from	+	' '	+	ls_where
	ll_temp_count	=	lnv_count.uf_get_count (ls_sql)
	ll_count			=	ll_count	+	ll_temp_count
NEXT


Destroy	lnv_count

Return	ll_count



end function

public function string wf_create_where (string as_table_type);//This function takes the information in the global criteria arrays and
//uses them to build a where clause.  
//Arguments:    Table_type RH or RD
//returns:      a STRING
//********************************************************************
//	09-29-95 FNC 	Take upperbound out of loop
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
//	04/20/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity.
// 10/15/04	MikeF	
//********************************************************************


string 	ls_where, ls_data_type, ls_exp2,lv_col_name,lv_left_paren,lv_table_type
int count,position,lv_filters_applied
string lv_where_message
string lv_filter_id,lv_filter_sql
int lv_upperbound

setpointer(hourglass!)

ls_where = ' WHERE '
count = 1
lv_filters_applied = 0

//loops through the array until the array element is found
//to be blank or the count is greater than 24

lv_upperbound = Upperbound(gv_exp2)
do while count <= lv_upperbound          //09-29-95 FNC End
	If gv_exp2[count] <> '' then
	
		if left(gv_exp2[count],1) = '@' then
			lv_filters_applied = lv_filters_applied + 1
			lv_filter_id = mid(gv_exp2[count],2)
			position = pos(gv_exp1[count],'.')
			if position = 0 then
				lv_col_name = gv_exp1[count]
				lv_table_type = as_table_type
			else
				lv_table_type = left(gv_exp1[count],position - 1)
				lv_col_name = mid(gv_exp1[count],position+1)
			end if

			ls_data_type =	gnv_dict.event ue_get_elem_data_type( lv_table_type, lv_col_name )

			IF gnv_sql.of_is_character_data_type 	(ls_data_type)	THEN
				ls_data_type = 'Char'
			ELSEIF gnv_sql.of_is_number_data_type 	(ls_data_type)	THEN
				ls_data_type = 'Number'
			ELSEIF gnv_sql.of_is_date_data_type 	(ls_data_type)	THEN
				ls_data_type = 'Date'
			ELSEIF gnv_sql.of_is_money_data_type 	(ls_data_type)	THEN
				ls_data_type = 'Money'
			END IF
			// FDG 12/14/00 end
		
		   lv_filter_sql = '(' + gv_exp1[count] + ' = FV' + string(lv_filters_applied) + '.FILTER_DATA'

			ls_where = ls_where + ' ' + lv_filter_sql + ' '

		else
			//This section finds out if a prefix is on the column name being
			//processed.  If there it is stripped so the name can be found
			//in the dictionary.
			position = pos(gv_exp1[count],'.')
			if position = 0 then
				lv_col_name = gv_exp1[count]
				lv_table_type = as_table_type
			else
				lv_table_type = left(gv_exp1[count],position - 1)
				lv_col_name = mid(gv_exp1[count],position+1)
			end if
			if gv_left_paren[count] = 'J' Then
				lv_left_paren = ''
				ls_exp2 = gv_exp2[count]
			else
				lv_left_paren = gv_left_paren[count]
				ls_data_type =	gnv_dict.event ue_get_elem_data_type( lv_table_type, lv_col_name )

				IF gnv_sql.of_is_date_data_type (ls_data_type)				THEN
					ls_exp2	=	gnv_sql.of_get_to_date (gv_exp2[count])
				ELSEIF gnv_sql.of_is_character_data_type (ls_data_type)		THEN
					ls_exp2 = format_where(gv_exp2[count],gv_op[count], gv_exp1[count])
				else
					ls_exp2 = format_where_n(gv_exp2[count],gv_op[count])
				end if
			end if
				//creates the where statement//
			if (gv_op[count] = 'LIKE' or gv_op[count] = 'NOT LIKE') and match(gv_exp2[count],',') then
				ls_where = ls_where +' '+ls_exp2 +' '+gv_logic[count]+' '
			else
				ls_where = ls_where +lv_left_paren+gv_exp1[count]+' '+gv_op[count]+' '+ls_exp2+gv_right_paren[count]+' '+gv_logic[count]+' '
			end if
		end if

	//KMM 6/8/95 Added because a line with just a left or right paren is valid
	elseif gv_left_paren[count] <> '' then
		ls_where = ls_where + gv_left_paren[count]
	elseif gv_right_paren[count] <> '' then
		ls_where = ls_where + gv_right_paren[count] 
	end if
	count = count + 1
loop

COMMIT using Stars2ca;
if Stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Error performing commit in fx_make_where.')
end if
if ls_where = ' WHERE ' Then
	ls_where = ''
end if
return ls_where

end function

on closequery;if ib_win_busy then
	message.returnvalue=1
else
	message.returnvalue=0
end if

end on

event activate;// 01/07/05 Katie Track 5431c Added event to restore menu for current instance.

integer li_x, li_y

integer bottom_margin

setpointer(hourglass!)


this.setredraw(False)

li_x = dw_1.X
li_y = dw_1.Y

bottom_margin = dw_1.Y + dw_1.Height

if IsValid (mle_crit) = TRUE THEN
   if ib_show_sql = FALSE THEN
      dw_1.X        = mle_crit.X
      dw_1.Y        = 1
      dw_1.Width    = mle_crit.Width
      dw_1.Height   = bottom_margin - dw_1.Y
      mle_crit.hide ()
   else
      dw_1.X        = dw_1.X
      dw_1.Y        = (mle_crit.Y + mle_crit.Height) + 40
      dw_1.Width    = mle_crit.Width
      dw_1.Height   = bottom_margin - dw_1.Y
      mle_crit.Show ()
   end if
else
   dw_1.X      = dw_1.X
   dw_1.Y      = 1
   dw_1.Width  = dw_1.Width
   dw_1.Height = bottom_margin - dw_1.Y
end if
 
m_stars_30.m_file.m_showsql.event ue_restore_win_settings() 
 
dw_1.Show ()
this.setredraw(true)  
end event

event open;call super::open;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ----	-------------------------------------------------------- 
// 09/01/93 MH		Created 
// 10/03/93 SWD	Added Set FORMAT AND TITLE SECTION	
// 01/12/94 FNC	Check instance variable to determine database
//	10/17/95 FDG	1. Connect to Stars2ca before calling labels
//						2. Change dwmodify to Modify	
// 10/19/95 FNC	1. Take out connects and disconnects
// 07/14/97 NLG	TS #171 Remove in_sql & in_header arguments from
//                wf_process_crit_for_display
// 01/12/98 JGG	TS144 - STARS 4.0 - Call labels nvo in place of global function.
//	03/11/98 FDG 	Stars 4.0 Track 877 - Remove references to cb_subset
// 03/12/98 JGG	STARS 4.0 - TS145 Executable changes - remove wf_filter_copy.
//	09/25/02	GaryR	SPR 3324d	Centralize the logic to format labels
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//***********************************************************************
//********************************************************************
//This window is the parent and alot of other windows are descendants of it.
//This window is never actually used in the application.
//*********************************DECALRATION SECTION**********************

String lv_crit, lv_window_name
int lv_position, lv_group_pos
int n,r_cnt,position,lv_rc,lv_index
long num_of_col
n_cst_string	lnv_string

//****************************INTIALIZATION SECTION***********************
// these three lines of code will set the windows color after window is opened
// by w_invoice_selection
window temp_win
temp_win = this
setpointer(hourglass!)

// Default values for subset creation.
in_subset_created = FALSE
iv_insert_crit = true
gv_current_sub_src_type = 'SB'
gv_current_sub_src_name = ''
in_current_sub_src_type = gv_current_sub_src_type
in_current_sub_src_name = gv_current_sub_src_name
in_dw_limit = gc_dw_limit


This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'R','A')
lv_rc = fw_variable_load('IN')
If lv_rc <> 0 Then
	RETURN
End If
 

lv_rc= dw_1.SetSqlSelect(in_sql) 

if lv_rc= -1 then
   errorbox(in_transaction_object,'Error Setting SQL for the data window')
	gv_rc = lv_rc
	cb_close.Postevent(clicked!)
	return
end if

//This calls the labels function and sets all the labels to the corresponding
//dictionary entry. For calculated values a Constant Label is set.  

dw_1.Modify('header_t.text = ' + in_header)
//	Set Accessibility Properties
lv_crit = lnv_string.of_clean_string_acc( in_header )
lv_crit = '"' + lv_crit + '"~t"' + lv_crit + '"'
dw_1.Modify("header_t.AccessibleName='" + lv_crit + "'")
dw_1.Modify("header_t.AccessibleDescription='" + lv_crit + "'")

//	09/25/02	GaryR	SPR 3324d
//dw_1.inv_labels.of_labels (in_table_type, in_columns_selected)
dw_1.inv_labels.of_labels2( in_table_type, "95", "40", "50" )

	//if you are connecting to stars2 you need to connect after 
	//the labels function.
if in_transaction_object = stars2ca then
	This.of_SetTransaction (in_transaction_object)
   lv_rc = settransobject(dw_1,in_transaction_object)
	reset(dw_1)
    if lv_rc= -1 then
       errorbox(in_transaction_object,'Error connecting to the data window')
	    gv_rc = lv_rc
		 cb_close.Postevent(clicked!)
	    return
    end if
end if
//------------------------------------------------------------
//   Break up the in_sql into just the where statement.
//------------------------------------------------------------
lv_position = pos(in_sql,'WHERE') + 6
lv_crit = mid(in_sql,lv_position)

IF (pos(lv_crit,'GROUP') <> 0) THEN
   lv_group_pos = pos(lv_crit,'GROUP')
   lv_crit = left(lv_crit,lv_group_pos - 1)
END IF


//************************************************************************
//This disables all buttons while a retrieval is going on
//

mle_crit.Visible = FALSE
dw_1.Visible     = FALSE
fx_set_button_status(FALSE,in_button_not_modified[],this)
setpointer(hourglass!)

//These two statements make sure the window is showing while the reteieval
//is going on
//john_wo 10/30/97 spec 127 , 3.6 added switch to not show 
//        the window if the switch is set in w_ratio_proc_sum.
If is_show_window = 'N' Then
	this.visible = false
Else
	this.show()
	this.setfocus()
End If

// 7-24-95 PLB
//Only if this script is called from subset summary report will
//this field = 99, this is to avoid performing the global function.
//It is done in a window function instead to accomdiate the syntax.

If in_decode_struct.decoded <> 99 Then
	lv_window_name = UPPER(this.classname())
	lv_rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,in_transaction_object)
	If lv_rc = -5 Then
		lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
		ddlb_dw_ops.deleteitem(lv_index)
	End If
End If

lv_rc = settransobject(dw_1,in_transaction_object)

lv_rc = retrieve(dw_1)

if lv_rc = -1 then
   errorbox(in_transaction_object,'Error retrieving for the datawindow')
	fx_set_button_status(FALSE,in_button_not_modified[],this)
	gv_rc = lv_rc
	cb_close.Postevent(clicked!)
   return
end if

COMMIT using in_transaction_object;
if in_transaction_object.sqlcode <> 0 then
   errorbox(in_transaction_object,'Error performing commit in open')
   return
end if

in_row_count = rowcount(dw_1)
sle_count.text = string(in_row_count)
if in_row_count <=0 Then
   lv_crit = lv_crit + '@@' + in_header
	this.windowstate = minimized!
	OpenSheetwithParm(w_claim_rpt_no_data,lv_crit,MDI_main_frame,help_menu_position,original!)
	gv_rc = -1
	cb_close.Postevent(clicked!)
	return
end if

wf_process_crit_for_display()  // NLG 7/14/97
SetPointer(HourGlass!)
wf_strip_outer_join()		

//This makes the where statement to re-execute the query against ROS_DETAIL INFO
	
gv_where = this.wf_create_where(iv_invoice_type)		
if gv_where = 'ERROR' Then
	return
end if
in_where = gv_where
ib_allow_switch = TRUE
ib_show_sql = FALSE
end event

event deactivate;// 01/07/05 Katie Track 5431c Added event call to reset menu.

m_stars_30.m_file.m_showsql.event ue_reset()

if isvalid( iv_uo_win ) Then
	iv_uo_win.hide()
end if
end event

event close;call super::close;// 01/07/05 Katie Track 5431c Added event call to reset menu.

m_stars_30.m_file.m_showsql.event ue_reset()

If isvalid(iv_uo_win) Then
	close (iv_uo_win)
end if
end event

on w_parent_rpt.create
int iCurrent
call super::create
this.ddlb_dw_ops=create ddlb_dw_ops
this.cb_clear=create cb_clear
this.st_1=create st_1
this.cb_save_report=create cb_save_report
this.sle_count=create sle_count
this.cb_stop=create cb_stop
this.mle_crit=create mle_crit
this.cb_query=create cb_query
this.cb_view_detail=create cb_view_detail
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_dw_ops
this.Control[iCurrent+2]=this.cb_clear
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_save_report
this.Control[iCurrent+5]=this.sle_count
this.Control[iCurrent+6]=this.cb_stop
this.Control[iCurrent+7]=this.mle_crit
this.Control[iCurrent+8]=this.cb_query
this.Control[iCurrent+9]=this.cb_view_detail
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.dw_1
end on

on w_parent_rpt.destroy
call super::destroy
destroy(this.ddlb_dw_ops)
destroy(this.cb_clear)
destroy(this.st_1)
destroy(this.cb_save_report)
destroy(this.sle_count)
destroy(this.cb_stop)
destroy(this.mle_crit)
destroy(this.cb_query)
destroy(this.cb_view_detail)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type ddlb_dw_ops from dropdownlistbox within w_parent_rpt
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 64
integer y = 1336
integer width = 713
integer height = 312
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

event selectionchanged;//	Katie	04/10/09	GNL.600.5633 Added decode structure to fx_uo_control call.

string lv_control_text

SetPointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,sle_count, in_decode_struct)
end event

type cb_clear from u_cb within w_parent_rpt
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1810
integer y = 1452
integer width = 398
integer height = 108
integer taborder = 80
string text = "Clear"
end type

event clicked;in_num_rows_sel = 0
dw_1.selectrow(0,FALSE)
cb_view_detail.enabled = FALSE
cb_query.enabled = FALSE
cb_clear.enabled = FALSE





end event

type st_1 from statictext within w_parent_rpt
boolean visible = false
string accessiblename = "none"
string accessibledescription = "none"
accessiblerole accessiblerole = statictextrole!
integer x = 357
integer y = 1452
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_save_report from u_cb within w_parent_rpt
boolean visible = false
string accessiblename = "Save"
string accessibledescription = "Save"
integer x = 1714
integer y = 1488
integer width = 41
integer height = 36
integer taborder = 40
end type

type sle_count from singlelineedit within w_parent_rpt
string tag = "colorfixed"
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = textrole!
integer x = 69
integer y = 1460
integer width = 297
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type cb_stop from u_cb within w_parent_rpt
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
integer x = 1774
integer y = 1456
integer width = 247
integer height = 108
integer taborder = 70
integer textsize = -16
string text = "Stop"
end type

on clicked;gv_cancel_but_clicked = true

end on

type mle_crit from multilineedit within w_parent_rpt
string accessiblename = "Criteria"
string accessibledescription = "Criteria"
accessiblerole accessiblerole = textrole!
integer x = 64
integer y = 36
integer width = 2592
integer height = 360
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_query from u_cb within w_parent_rpt
string accessiblename = "Query"
string accessibledescription = "Query"
integer x = 425
integer y = 1452
integer width = 398
integer height = 108
integer taborder = 30
integer textsize = -16
boolean enabled = false
string text = "&Query"
end type

event clicked;//john_wo spec 127 3.6 moved code to user event to keep the window hidden
//        when going from w_ratio_rpt to the claim rpt screen. 11/5/97
parent.event ue_query()
end event

type cb_view_detail from u_cb within w_parent_rpt
string accessiblename = "View Data"
string accessibledescription = "View Data"
integer x = 887
integer y = 1452
integer width = 398
integer height = 108
integer taborder = 60
integer textsize = -16
boolean enabled = false
string text = "&View Data"
end type

event clicked;setpointer(hourglass!)

end event

type cb_close from u_cb within w_parent_rpt
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2277
integer y = 1452
integer width = 398
integer height = 108
integer taborder = 90
string text = "&Close"
end type

on clicked;setpointer(hourglass!)
close(parent)
end on

type dw_1 from u_dw within w_parent_rpt
string accessiblename = "Report Data"
string accessibledescription = "Report Data"
integer x = 64
integer y = 456
integer width = 2592
integer height = 860
integer taborder = 10
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

on retrieveend;in_end_cntr ++

if gv_cancel_but_clicked = FALSE Then
	in_retrieve_cancelled = false	// BV 7/13/95 - set to use in cb_subset to determine if retrieve was cancelled
	gv_cancel_but_clicked = TRUE	
	dw_1.triggerevent(rowfocuschanged!)
elseif gv_cancel_but_clicked = TRUE then
	if in_end_cntr = 1 then
		in_retrieve_cancelled = true
		in_end_cntr ++
	end if	
	dw_1.triggerevent(rowfocuschanged!)
end if 
setpointer(arrow!)
w_main.setmicrohelp('Ready')

fx_set_button_status(TRUE,in_button_not_modified[],mdi_main_frame.GetActiveSheet())
setfocus(dw_1)
ib_win_busy=false

end on

event doubleclicked;///////////////////////////////////////////////////////////////////////////
// Change History
///////////////////////////////////////////////////////////////////////////
// JasonS 10/02/02	Track 2273d  don't check for gv_cancel_but_clicked
///////////////////////////////////////////////////////////////////////////
int row_nbr,tabpos,lv_row_nbr, li_rc
string lv_col,lv_col_name,lv_data_type,lv_hold_object,lv_sort_name
string lv_tbl_type
boolean lv_join


lv_join = FALSE
setpointer(hourglass!)
//if gv_cancel_but_clicked=TRUE Then	// JasonS 10/02/02 Track 2273d
			/*gets the row and makes sure a row was clicked*/
		setpointer(hourglass!)
		lv_hold_object = Getobjectatpointer(dw_1)
//store the current row number and the column name
	
		tabpos = pos (lv_hold_object,"~t")
		lv_col = left(lv_hold_object,(tabpos - 1))
		
		If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
			If in_selected <> '1' Then
				Messagebox('Information','You must select an option from Window Operations')
			Else
				ddlb_dw_ops.triggerevent(selectionchanged!)
			End If
			li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
		ElseIf in_dw_control = 'FILTER' Then
				ddlb_dw_ops.triggerevent(selectionchanged!)
				lv_row_nbr = row
				li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
		ElseIf in_dw_control = 'FIND' Then
			ddlb_dw_ops.triggerevent(selectionchanged!)
			lv_row_nbr = row
			li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
		Else

		//*gets the row and makes sure a row was clicked*/
			row_nbr = row
			If row_nbr = 0 then
				return
			end if
			cb_view_detail.triggerevent(clicked!)
		end if
//end if	// JasonS 10/02/02 Track 2273d
end event

on rbuttondown;Setpointer(Hourglass!)
if upperbound(in_detail_struct.table_type[]) > 1 Then 
	gv_element_table_type2=in_detail_struct.table_type[2]
end if

// If this is not really a claim join, but there are filters applied,
//   then set gv_elem... to 'FL' so fx_lookup will strip off 'c'
//  prob 609 - lookups don't work when filter join occurs

if gv_element_table_type2 = '' and in_detail_struct.num_filters_applied > 0 then
	gv_element_table_type2 = 'FL'
end if		

fx_lookup(dw_1,in_table_type)
end on

on rowfocuschanged;
/*Clicked for data window 1*/
string test
int clicked_row
/*Sets select and delete to enabled when clicked*/

//This is uncommented when the delete button is made visible

if gv_cancel_but_clicked then	
	cb_query.enabled = TRUE
	cb_view_detail.enabled = TRUE

	/*gets the row and makes sure a row was clicked*/
	in_row_nbr = getrow(dw_1)
	If in_row_nbr = 0 then
		cb_query.enabled = FALSE
		cb_view_detail.enabled = FALSE
	//This is uncommented when the delete button is made visible
	
		return
	end if
	
	/*Highlights the selected row*/
	
	
	in_num_rows_sel = 1
	SelectRow ( dw_1, 0, FALSE )
	SelectRow ( dw_1, in_row_nbr, TRUE )
	
	
end if
	
	


end on

on retrievestart;//setpointer(hourglass!)
w_main.setmicrohelp('Retrieving rows, Please Wait!')

gv_cancel_but_clicked = FALSE
in_retrieve_cancelled = false
cb_stop.enabled = TRUE
in_end_cntr = 0
ib_win_busy=true

end on

event constructor;call super::constructor;//	TS144		STARS 4.0	Subset Redesign
//
// Log:		
//				JGG	01/12/98		Register the datawindow to the labels service (nvo)
//

This.of_SetLabels (TRUE)


end event

