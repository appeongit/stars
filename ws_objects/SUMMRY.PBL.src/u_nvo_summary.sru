$PBExportHeader$u_nvo_summary.sru
$PBExportComments$Summary non-visual object (inherited from n_base) <logic>
forward
global type u_nvo_summary from n_base
end type
end forward

global type u_nvo_summary from n_base
end type
global u_nvo_summary u_nvo_summary

type variables
// Summary parm structure
Private	sx_summary_parm	istr_summary_parm

//iv_fields[] from w_summary_financial
Private	sx_field	is_fields[]

// Datawindow containing d_sum_rel
u_dw	idw

// Datawindow containing d_sum_select
u_dw	idw_sum_select

// DataWindow containing d_dict_cols
u_dw	idw_dict_cols

//Summary Table Type & Table Name
Private	String	is_tbl_type = ''
Private	String	is_table_name = ''

//Provider Universe table type, table name, & where clause
Private	String	is_universe_tbl_type
Private	String	is_universe_table
Private	String	is_universe_where

//Max # of 'Sum_fld' in table sum_rel
Private	Integer	ic_field_num = 6

//'Sum_fld' prefix for sum_rel
Private	String	ic_sum_fld = 'sum_fld'

//Filter for sum_rel
Private	String	is_sum_rel_filter,	&
		is_function_filter

//Boolean for patient profile
boolean ib_pat_profile

end variables

forward prototypes
public subroutine fuo_set_summary_parm (ref sx_summary_parm astr_summary_parm)
public function sx_summary_parm fuo_get_summary_parm ()
public subroutine fuo_set_dw (ref datawindow adw)
public subroutine fuo_set_dw_dict_cols (ref datawindow adw)
public subroutine fuo_set_sum_rel_filter (string as_filter)
public subroutine fuo_reset_sum_rel_filter ()
public function string fuo_get_universe_tbl_type ()
public function string fuo_get_universe_where ()
public function string fuo_get_sum_rel_filter ()
public subroutine fuo_set_sx_field (sx_field as_fields[])
public function string fuo_get_function_filter ()
public function boolean fuo_get_ib_pat_profile ()
public function integer fuo_set_pat_profile (boolean ab_pat_profile)
public function long fuo_get_num_months (date ad_start, date ad_end)
public function string fuo_get_tbl_type (string as_table_name)
public function string fuo_get_universe_table ()
public function integer uf_convert (ref string as_col_name)
public function string fuo_get_calculated_fields ()
public function string fuo_get_universe_select ()
public subroutine fuo_set_dw_sum_select (ref datawindow adw)
public function string fuo_create_group_by_select (string as_tbl_type)
public function integer fuo_filter_dw ()
public subroutine fuo_reset_filter ()
public function string fuo_create_group_by ()
public function long fuo_get_sum_select (string as_col_type)
public function any fuo_get_calc_disp_formats (boolean ab_universe)
end prototypes

public subroutine fuo_set_summary_parm (ref sx_summary_parm astr_summary_parm);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_summary
//
//	Description:	This function stores sx_summary_parm for future use.
//	Arguments:		astr_summary_parm (Type sx_summary_parm) passed by
//						reference.
//************************************************************************

istr_summary_parm		=	astr_summary_parm

end subroutine

public function sx_summary_parm fuo_get_summary_parm ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_summary
//
//	Description:	This function returns istr_summary_parm.
//	Arguments:		None.
//	Returns:			istr_summary_parm (Type sx_summary_parm)
//************************************************************************

Return istr_summary_parm

end function

public subroutine fuo_set_dw (ref datawindow adw);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_dw
//
//	Description:	This function registers the datawindow
//	Arguments:		adw (reference) - DataWindow to be registered.
//	Returns:			None
//************************************************************************

idw	=	adw

end subroutine

public subroutine fuo_set_dw_dict_cols (ref datawindow adw);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_dw_dict_cols
//
//	Description:	This function registers the datawindow (d_dict_cols)
//	Arguments:		adw (reference) - DataWindow to be registered.
//	Returns:			None
//************************************************************************

idw_dict_cols	=	adw

idw_dict_cols.SetTransObject (Stars2ca)

end subroutine

public subroutine fuo_set_sum_rel_filter (string as_filter);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_sum_rel_filter
//
//	Description:	This function saves the filter for the sum_rel table
//						(idw) so the datawindow can be re-filtered.
//	Arguments:		as_filter - The filter string
//	Returns:			None
//************************************************************************

is_sum_rel_filter				=	as_filter
istr_summary_parm.filter	=	as_filter

end subroutine

public subroutine fuo_reset_sum_rel_filter ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_reset_sum_rel_filter
//
//	Description:	This function filters the datawindow (idw) based on
//						the values stored in is_sum_rel_filter.  idw must
//						use datawindow object d_sum_rel and fuo_set_sum_rel_filter
//						must have been previously called.
//	Arguments:		None
//	Returns:			Integer: 1=Successful, -1=Unsuccessful
//************************************************************************

Integer	li_rc
string ls_filter

	//	Remove any previous filters
This.fuo_reset_filter()

	//	Filter idw (sum_rel) based on what was previously stored in 
	//	is_sum_rel_filter (This was set by fuo_set_sum_rel_filter).  This
	//	filter must also include period and function.

ls_filter	=	This.fuo_get_sum_rel_filter()

li_rc	=	idw.SetFilter(ls_filter)
li_rc	=	idw.Filter()



end subroutine

public function string fuo_get_universe_tbl_type ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_universe_tbl_type
//
//	Description:	This function gets the table type of the 'Master' record
//						table name.  This is determined in fuo_get_universe_table
//						when the 'Provider Universe' is checked.
//	Returns:			String - Table Type.  '' = no table type. 
//************************************************************************


	//	If the table name has already been determined, there is no need to
	//	compute it.


	//	Compute the table type thru fuo_get_universe_table

This.fuo_get_universe_table()

Return is_universe_tbl_type


end function

public function string fuo_get_universe_where ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_universe_where
//
//	Description:	This function gets the where clause of the 'Master' 
//						record table name.  This is determined in 
//						fuo_get_universe_table when the 'Provider Universe' is 
//						checked.
//	Returns:			String - Partial where clause prefixed with 'AND '.
//						'' = no table type. 
//************************************************************************


	//	If the table name has already been determined, there is no need to
	//	compute it.

//djp
//IF	is_universe_where	>	' '	THEN
//	Return is_universe_where
//END IF

	//	Compute the where clause thru fuo_get_universe_table

This.fuo_get_universe_table()

Return is_universe_where


end function

public function string fuo_get_sum_rel_filter ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_sum_rel_filter
//
//	Description:	This function gets the filter for the sum_rel table
//						(idw) that was previously saved.
//	Arguments:		as_filter - The filter string
//	Returns:			None
//************************************************************************

String		ls_filter

	//	If the filter does not already include period and function, add
	//	period and function to the filter

IF	is_sum_rel_filter	>	''		THEN
	IF	Pos (is_sum_rel_filter, 'period')	=	0	THEN
		ls_filter	=	is_sum_rel_filter	+	' and '	+	is_function_filter
	ELSE
		ls_filter	=	is_sum_rel_filter
	END IF
ELSE
	ls_filter		=	is_function_filter
END IF

Return	ls_filter
end function

public subroutine fuo_set_sx_field (sx_field as_fields[]);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_sx_field
//
//	Description:	This function saves iv_fields[] passed by
//						w_summary_financial into is_fields[]
//	Arguments:		as_fields[] (type sx_field)
//	Returns:			N/A
//************************************************************************

is_fields	=	as_fields

end subroutine

public function string fuo_get_function_filter ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_sum_rel_filter
//
//	Description:	This function gets the filter that was previously
//						set by fuo_reset_filter.  This filter is based on
//						function and period.
//	Arguments:		None
//	Returns:			String - Filter
//************************************************************************

Return	is_function_filter

end function

public function boolean fuo_get_ib_pat_profile ();return ib_pat_profile
end function

public function integer fuo_set_pat_profile (boolean ab_pat_profile);ib_pat_profile = ab_pat_profile
return 1
end function

public function long fuo_get_num_months (date ad_start, date ad_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		fuo_get_num_months
//
//	Access:  		public
//
//	Arguments:
//	ad_start			Starting date.
//	ad_end			Ending date.
//
//	Returns:  		Long
//						Number of whole months between the two dates.
//						If the end date is prior the start date, function returns
//						a negative number of months.
//						If the start date is first of month and end date is last
//						of month, increments number of months by 1
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:	Given two dates, returns the number of whole months 
// 					between the two.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//	NLG	3-10-00	Created for patient profiles to determine how many months
//						the thru date and end date encompass.  This function
//						was taken from n_cst_datetime.of_monthsafter() and modified to determine
//						if beginning date is first of month and end date is last
//						day of month. Also, of_monthsafter considered 1/1/00 to 2/29/00
//						to be 1 month.  This function considers it 2 months.
//
//////////////////////////////////////////////////////////////////////////////

date		ld_lastDayOfMonth
date 		ld_temp
integer 	li_month
integer	li_mult
n_cst_datetime lnv_date

//Check parameters
If IsNull(ad_start) or IsNull(ad_end) or &
	Not lnv_date.of_IsValid(ad_start) or Not lnv_date.of_IsValid(ad_end) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

If ad_start > ad_end Then
	ld_temp = ad_start
	ad_start = ad_end
	ad_end = ld_temp
	li_mult = -1
else
	li_mult = 1
End If

li_month = (year(ad_end) - year(ad_start) ) * 12
li_month = li_month + month(ad_end) - month(ad_start)

If day(ad_start) > (day(ad_end) + 1) Then 
	li_month --
End If

//If start date is first of month and end date is last of month, increment num of months
ld_lastDayOfMonth = lnv_date.of_lastdayofmonth(ad_end)
IF day(ad_start) = 1 AND day(ad_end) = day(ld_lastDayOfMonth) THEN
	li_month ++
END IF

Return li_month * li_mult
end function

public function string fuo_get_tbl_type (string as_table_name);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_tbl_type
//
//	Description:	This function retrieves the table type from dictionary.
//	Arguments:		as_table - Name of table for which to get the table type
//	Returns:			String - The table type.  'ERROR' = Not found
//************************************************************************


String	ls_where_message

	//	If this Table type was previously created by this function,
	//	return the previous created table type.

IF	as_table_name	=	is_table_name		THEN
	Return is_tbl_type
END IF

is_table_name		=	as_table_name

SELECT elem_tbl_type
INTO :is_tbl_type
FROM Dictionary 
WHERE Elem_Type		= 'TB'					
  AND	Elem_Name		= Upper( :as_table_name	)
  AND	Elem_Tbl_Type	NOT LIKE 'O%'			 
  AND	Elem_Tbl_Type	NOT LIKE 'Q%' 
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 Then
	ls_where_message =	"Where Elem_type = 'TB' AND Elem_Name = :" + &
								Upper( as_table_name )
	ErrorBox (Stars2ca,'Error reading the Dictionary: ' + ls_where_message)
	Return 'ERROR'
END IF

Return is_tbl_type

end function

public function string fuo_get_universe_table ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_universe_table
//
//	Description:	This function filters the datawindow (idw) to get
//						the table name for 'Provider Universe'.  Once the
//						table name is accessed from sum_rel, the columns
//						required for the where clause are used to fill in
//						the remainder of the 'Where' clause.
//	Returns:			String - Table Name.  '' = no table. 
//************************************************************************

Integer	li_rc,			&
			li_upper,		&
			li_col2,			&
			li_col
String	ls_col_name[]
String	ls_filter,		&
			ls_where_message,	&
			lc_upin = 'PROV_UPIN',	&
			lc_spec = 'PROV_SPEC',	&
			ls_universe_col,	&
			ls_connector,	&
			ls_table,		&
			ls_tbl_type,	&
			ls_col
Long		ll_rowcount,	&
			ll_row,			&
			ll_found_row = 0
Boolean	lb_found_universe = FALSE,	&
			lb_found_spec		= FALSE, &
			lb_found_master	= FALSE

	//	If the table name has already been determined, there is no need to
	//	compute it.

//djp
//IF	is_universe_table	>	' '	THEN
//	Return is_universe_table
//END IF

is_universe_where	=	''

	// Get the table name and table type
ls_table	=	idw.GetItemString ( 1, 'table_name')
ls_tbl_type	=	This.fuo_get_tbl_type (ls_table)

	//	See if prov_upin exists in the existing data.  While checking for
	//	this, save the column name in an array.

FOR li_col	=	1	TO	ic_field_num
	ls_col_name[li_col]	=	idw.GetItemString ( 1, ic_sum_fld + string(li_col) )
	IF	Upper (ls_col_name[li_col])	=	lc_upin		THEN
		lb_found_universe	=	TRUE
	END IF
NEXT

li_upper		=	UpperBound (ls_col_name)


	//	Reset the d/w so there is no filtered data
This.fuo_reset_filter()
ls_filter	=	"sum_flag = 'M'"	+ " and "+is_function_filter

	//	Create the new filter
li_rc	=	idw.SetFilter(ls_filter)
li_rc	=	idw.Filter()

ll_rowcount	=	idw.RowCount()

	//	If more than 1 row, edit for upin
	
//djp - comment the if and leave the else
IF	ll_rowcount	=	1	THEN ll_found_row	=	1
//ELSE

	FOR	ll_row	= 1	TO	ll_rowcount	
		lb_found_master	=	FALSE
		lb_found_spec		=	FALSE

		FOR li_col	=	1	TO	ic_field_num
			ls_col	=	idw.GetItemString ( 1, ic_sum_fld + string(li_col) )
			IF	Upper (ls_col)		=	lc_upin		THEN
				lb_found_master	=	TRUE
			END IF
			IF	Upper (ls_col)		=	lc_spec		THEN
				lb_found_spec		=	TRUE
			END IF
		NEXT

			//	If both the universe (sum_flag = U) and master (sum_flag = M)
			//	rows either both have 'PROV_UPIN' or neither have 'PROV_UPIN'
			//	then that's the row to use to get the table name.
		IF	(lb_found_master AND lb_found_universe)	&
		OR (lb_found_master = FALSE AND lb_found_universe = FALSE)		THEN
			ll_found_row	=	ll_row
			ll_row			=	ll_rowcount		// Get out of the loop
		END IF

	NEXT
//END IF

IF	ll_found_row	=	0		THEN
	MessageBox ('Error in u_nvo_summary.fuo_get_universe_table', &
					'Error.  Please contact technical support.  ' + &
					'There are multiple rows in sum_rel where ' + &
					'sum_flag = M (Master) and the PROV_UPIN data ' + &
					'could not be properly found.')
	Return ''
END IF

is_universe_table		=	idw.GetItemString (ll_found_row, 'table_name')

	//	Get the universe table type for the new table

SELECT elem_tbl_type
INTO :is_universe_tbl_type
FROM Dictionary 
WHERE Elem_Type		= 'TB'					
  AND	Elem_Name		= Upper( :is_universe_table )
  AND	Elem_Tbl_Type	NOT LIKE 'O%'			 
  AND	Elem_Tbl_Type	NOT LIKE 'Q%' 
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 Then
	ls_where_message =	"Where Elem_type = 'TB' AND Elem_Name = :" + &
								Upper( is_universe_table )
	ErrorBox (Stars2ca,'Error reading the Dictionary: ' + ls_where_message)
	Return 'ERROR'
END IF

	// Add the 'joining' of the two tables in the 'Where' clause.
is_universe_where	=	' AND ' + ls_tbl_type + '.' + 'PERIOD = ' + &
							is_universe_tbl_type  + '.' + 'PERIOD'


FOR li_col	=	1	TO	ic_field_num
	ls_universe_col	=	idw.GetItemString (1, ic_sum_fld + string(li_col) )
	IF	Trim (ls_universe_col)	>	' '		THEN

		FOR li_col2	=	1	TO	li_upper
			IF	ls_col_name[li_col2]	=	ls_universe_col	THEN
				is_universe_where	=	is_universe_where	+	' AND ' + &
										ls_tbl_type + '.' + ls_col_name[li_col2] + &
										' = ' + is_universe_tbl_type + '.' + &
										ls_universe_col
			END IF
		NEXT

	END IF
NEXT

	//	IF Prov_upin found, add to the where clause
IF	lb_found_master 		&
AND lb_found_universe	THEN
	is_universe_where	=	is_universe_where	+	" AND " + &
								is_universe_tbl_type + ".PROV_ID = '*' AND " + &
								is_universe_tbl_type + ".PROV_AREA = '*'"
END IF

IF lb_found_master = FALSE 		&
AND lb_found_universe = FALSE		THEN
	is_universe_where	=	is_universe_where	+	" AND " + &
								is_universe_tbl_type + ".PROV_ID <> '*'"
END IF

//djp
if lb_found_master and not lb_found_universe then
	is_universe_where+=" AND "+is_universe_tbl_type+".PROV_UPIN<>'*'"
END IF

//djpIF lb_found_spec = FALSE 		THEN
IF lb_found_spec 	THEN
	is_universe_where	=	is_universe_where	+	" AND " + &
								is_tbl_type + ".PROV_SPEC = '*'"
END IF

	//	Reset the filter back to its original state
This.fuo_reset_sum_rel_filter()

Return is_universe_table


end function

public function integer uf_convert (ref string as_col_name);////////////////////////////////////////////////////////////////////////////
//
//	This method converts the raw sql stored in
//	table SUM_SELECT to be DBMS independant
//
////////////////////////////////////////////////////////////////////////////
//
//	04/09/01	GaryR	Stars 4.7 DataBase Port - Conversion of table SUM_SELECT
//
////////////////////////////////////////////////////////////////////////////

String	ls_convert = "CONVERT(", ls_datatype, ls_column, ls_new_col
Integer	li_pos, li_start, li_end
n_cst_string	lnv_string

IF IsNull( as_col_name ) THEN Return -1
li_pos = Pos( Upper( as_col_name ), ls_convert )
IF li_pos = 0 THEN Return 1

li_start = Pos( as_col_name, ",", li_pos ) + 1
li_end = Pos( as_col_name, ")", li_start )
ls_column = Trim( Mid( as_col_name, li_start, li_end  - li_start ) )

ls_datatype = Upper( Mid( as_col_name, li_pos + Len( ls_convert ), 2 ) )
CHOOSE CASE ls_datatype
	CASE	"MO"	//Money	
		ls_new_col = gnv_sql.of_get_to_money( ls_column )
	CASE 	"DA"	//Date DateTime
		ls_new_col = gnv_sql.of_get_to_date( ls_column )
	CASE 	"IN"	//Int
		ls_new_col = gnv_sql.of_get_to_number( ls_column )
	CASE	"CH", "VA"	//Char Varchar
		li_start = li_pos + Len( ls_convert )
		li_end = lnv_string.of_LastPos( as_col_name, ")" )
		ls_column = Trim( Mid( as_col_name, li_start, li_end  - li_start ) )
		ls_new_col = gnv_sql.of_get_to_char( ls_column )
	CASE ELSE
		Return -1
END CHOOSE

IF ls_new_col = "" THEN Return -1
as_col_name = Replace( as_col_name, li_pos, (li_end - li_pos) + 1, ls_new_col )

Return 1
end function

public function string fuo_get_calculated_fields ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_calculated_fields
//
//	Description:	This function retrieves the data from sum_select and
//						then uses the data (calculated fields) to format the
//						remainder of the select statement.
//
//						NOTE:	The calling script must determine if the Select
//								statement has selected any columns.  If so, it
//								must insert a ', ' before attaching the calculated
//								columns.
//	Arguments:		None
//	Returns:			String - The remainder of the select statement using
//									the calculated fields retrieved.
//************************************************************************
//	03/10/00	NLG	Patient profiles.  Translate #d (number of months in
//						date of service) & #p (number of months in pay date)
//						by going to period_cntl
//	04/10/01	GaryR	Stars 4.7 DataBase Port - Conversion of table SUM_SELECT
//	03/01/07 Katie		SPR 4540 Set formats of calculated fields based on disp_format in SUM_SELECT
//************************************************************************

Long		ll_row,ll_pos
Long		ll_max_rows
String	ls_calc = '',ls_temp

	//	Retrieve the calculated fields from sum_select
ll_max_rows	=	This.fuo_get_sum_select ( 'SUMMARY' )

IF	ll_max_rows	<	1		THEN
	Return ''
END IF

	//	Format the calculated fields so that it can be attached to the
	//	end of a select statement.  If a calulated field has already been
	//	accessed, attach a comma to the beginning of the string.

FOR ll_row	=	1 TO ll_max_rows
	IF	ls_calc	<>	''		THEN
		ls_calc	=	ls_calc	+	', '
	END IF
//djp - must change the alias - first the main table
	ls_temp=idw_sum_select.GetItemString ( ll_row, 'col_name')
	ll_pos = Pos(ls_temp, '@')
	DO WHILE ll_pos > 0
		ls_temp = Replace(ls_temp, ll_pos, 1, is_tbl_type)
		ll_pos = Pos(ls_temp, '@', ll_pos+len(is_tbl_type))
	LOOP
	ll_pos = LastPos(ls_temp, '"')
	ls_temp = Replace(ls_temp, ll_pos, 1, ' aabb"')
	//	04/10/01	GaryR	Stars 4.7 DataBase Port
	IF uf_convert( ls_temp ) = -1 THEN Return " "
	ls_calc	=	ls_calc	+	ls_temp
NEXT

//NLG 3-10-00  The code that follows is for patient profiles only 
IF not ib_pat_profile THEN 
	return ls_calc
END IF


//=================================================================================
//NLG 3-10-00 check calculated fields for number of months
//=================================================================================
datetime	ldte_thru, ldte_from
int 		li_rc
long 		ll_rows
long		ll_num_of_months
string 	ls_date_type
string 	ls_num_of_months
n_cst_datetime	lnv_date	// Autoinstantiated 

n_ds 		lds_period_cntl_dates//nvo to get period_cntl to and from dates to translate #p, #d
lds_period_cntl_dates = CREATE n_ds
lds_period_cntl_dates.dataobject = 'd_period_cntl_dates'
li_rc = lds_period_cntl_dates.SetTransObject(stars2ca)
ll_rows = lds_period_cntl_dates.retrieve(istr_summary_parm.period_key)
IF ll_rows < 1 THEN
	messagebox('Error','Error reading period_key where period_key = ' +&
				string(istr_summary_parm.period_key)  +&
				'~r in u_nvo_summary.fuo_get_calculated_fields')
	IF IsValid(lds_period_cntl_dates) THEN destroy lds_period_cntl_dates
	return ' '		
END IF

ls_temp = ls_calc
ll_pos = pos(ls_temp,'#')
DO WHILE ll_pos > 0
	ls_date_type = UPPER(mid(ls_temp,ll_pos+1,1))//get the char after the #--either p or d
	IF ls_date_type = 'P' THEN	
		ldte_from = lds_period_cntl_dates.GetItemDateTime(1,'payment_from_date')
		ldte_thru = lds_period_cntl_dates.GetItemDateTime(1,'payment_thru_date')		
	ELSEIF ls_date_type = 'D' THEN	
		ldte_from = lds_period_cntl_dates.GetItemDateTime(1,'from_date')
		ldte_thru = lds_period_cntl_dates.GetItemDateTime(1,'thru_date')
	ELSE
		Messagebox("ERROR","Error in sum_select computed columns" +&
						"~rwhere col_type = SUMMARY" +&
						"~rand inv_type = " + istr_summary_parm.invoice_type +&
						"~rDivisor should be #P or #D")
		IF IsValid(lds_period_cntl_dates) THEN destroy lds_period_cntl_dates
		return ' '
	END IF
	ll_num_of_months = fuo_get_num_months(date(ldte_from),date(ldte_thru))//lnv_date.of_monthsafter(date(ldte_from),date(ldte_thru))
	ls_num_of_months = string(ll_num_of_months)
	ls_temp = Replace(ls_temp, ll_pos, 2, ls_num_of_months)
	ll_pos = Pos(ls_temp, '#', ll_pos+len(ls_num_of_months))
LOOP

IF IsValid(lds_period_cntl_dates) THEN destroy lds_period_cntl_dates

ls_calc = ls_temp

Return ls_calc


end function

public function string fuo_get_universe_select ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_universe_select
//
//	Description:	This function retrieves the data from sum_select and
//						then uses the data (Universe Providers) to format the
//						remainder of the select statement.
//
//						NOTE:	The calling script must determine if the Select
//								statement has selected any columns.  If so, it
//								must insert a ', ' before attaching the calculated
//								columns.
//	Arguments:		None
//	Returns:			String - The remainder of the select statement using
//									the data retrieved.
//************************************************************************
//
//	04/10/01	GaryR	Stars 4.7 DataBase Port - Conversion of table SUM_SELECT
//
//************************************************************************

Long		ll_row
Long		ll_max_rows, ll_pos
String	ls_calc = '', ls_temp

	//	Retrieve the calculated fields from sum_select
ll_max_rows	=	This.fuo_get_sum_select ( 'UNIVERSE' )

IF	ll_max_rows	<	1		THEN
	Return ''
END IF

	//	Format the Universe fields so that it can be attached to the
	//	end of a select statement.  If a Universe field has already been
	//	accessed, attach a comma to the beginning of the string.

FOR ll_row	=	1 TO ll_max_rows
	IF	ls_calc	<>	''		THEN
		ls_calc	=	ls_calc	+	', '
	END IF

//djp - must change the aliases - first the main table
	ls_temp=idw_sum_select.GetItemString ( ll_row, 'col_name')
	ll_pos = Pos(ls_temp, '@')
	DO WHILE ll_pos > 0
		ls_temp = Replace(ls_temp, ll_pos, 1, is_tbl_type)
		ll_pos = Pos(ls_temp, '@', ll_pos+len(is_tbl_type))
	LOOP
//djp - now for the universe table
	ll_pos = Pos(ls_temp, '$')
	DO WHILE ll_pos > 0
		ls_temp = Replace(ls_temp, ll_pos, 1, is_universe_tbl_type)
		ll_pos = Pos(ls_temp, '$', ll_pos+len(is_universe_tbl_type))
	LOOP
	
	//	04/10/01	GaryR	Stars 4.7 DataBase Port
	IF uf_convert( ls_temp ) = -1 THEN Return " "
	ls_calc	=	ls_calc	+	ls_temp
NEXT

Return ls_calc


end function

public subroutine fuo_set_dw_sum_select (ref datawindow adw);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_set_dw_sum_select
//
//	Description:	This function registers the datawindow (d_sum_select)
//	Arguments:		adw (reference) - DataWindow to be registered.
//	Returns:			None
//************************************************************************
//
//	FDG	04/16/01	Stars 4.7.	Properly trim the data.
//
//************************************************************************

idw_sum_select	=	adw

idw_sum_select.SetTransObject (Stars2ca)

idw_sum_select.of_SetTrim (TRUE)					// FDG 04/16/01
end subroutine

public function string fuo_create_group_by_select (string as_tbl_type);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_create_group_by_select
//
//	Description:	This function edits and creates a select statement
//						from sum_rel when there's a 'group by' clause.
//	Arguments:		as_tbl_type
//	Returns:			String.  '' = No select clause
//************************************************************************
//
//	12/14/00	FDG	Stars 4.7.  Make the checking of data types DBMS-independent.
//	05/18/01	GaryR	Stars 4.7 DataBase Port - Using column aliases.
// 05/23/07	GaryR	Track 4540	Summarized columns must retain thier database
//										names instead of the labels to support formatting
//	06/12/07	GaryR	Track 5066	Include the label within double quotes
//
//************************************************************************

Integer	li_ix,				&
			li_upper
String	ls_col_name,		&
			ls_elem_name,		&
			ls_table_name,		&
			ls_tbl_type,		&
			ls_elem_type,		&
			ls_elem_indx_ind,	&
			ls_select = '',	&
			ls_sum_flag
Long		ll_row,				&
			ll_max_rows
Boolean	lb_found

// Reset the sum_rel filter
This.fuo_reset_sum_rel_filter()
	
//	Get the table name and table type
ls_table_name	=	idw.GetItemString ( 1, 'table_name')
ls_tbl_type		=	This.fuo_get_tbl_type (ls_table_name)

li_upper		=	UpperBound (is_fields)

//	Retrieve the data to attach to the SELECT
ll_max_rows	=	idw_dict_cols.Retrieve (as_tbl_type)

IF	ll_max_rows	<	1		THEN	Return ''

//	For each indexed column in dw_dict_cols with a value, attach the
//	column name to the 'Select' clause.
FOR	li_ix	=	1	TO	li_upper
	IF Trim (is_fields[li_ix].col_name)		>	' '			&
	AND Upper(is_fields[li_ix].col_name)	<>	'PERIOD'		THEN
		IF	ls_select	=	''				THEN
			ls_select	=	'SELECT '	+	ls_tbl_type	+ &
								'.'	+	is_fields[li_ix].col_name
		ELSE
			ls_select	=	ls_select	+	', '	+	ls_tbl_type	+ &
								'.'	+	is_fields[li_ix].col_name
		END IF
	END IF
NEXT

//	For each non-indexed column in dw_dict_cols with a value, 'SUM' the
//	column name to the 'Select' clause.
FOR	ll_row	=	1	TO	ll_max_rows
	lb_found			=	FALSE
	ls_elem_name	=	upper(idw_dict_cols.GetItemString ( ll_row, 'elem_name'))
	ls_elem_type	=	idw_dict_cols.GetItemString ( ll_row, 'elem_data_type')
	ls_elem_indx_ind	=	idw_dict_cols.GetItemString ( ll_row, 'elem_indx_ind')

	IF ls_elem_name<>'' &
	AND NOT IsNull ( ls_elem_name )	&
	AND ls_elem_name<>'PERIOD' &
   and not (idw.getitemstring(1,'sum_flag')='G' and idw_dict_cols.getitemstring(ll_row,'elem_target_type')='G') then
		// FDG 12/14/00 - Make the checking of data types DBMS-independent.
		IF	gnv_sql.of_is_numeric_data_type (ls_elem_type)		THEN
			//	05/18/01	GaryR	Stars 4.7 DataBase Port
			ls_select	=	ls_select	+	", SUM("	+	ls_tbl_type	+ 	&
								'.' +	ls_elem_name	+	') "'	+	ls_elem_name	+	'"'
		END IF
	END IF
NEXT

Return	ls_select
end function

public function integer fuo_filter_dw ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_filter_dw
//
//	Description:	This function filters the datawindow (idw) based on
//						the values stored in istr_summary_parm.  idw must
//						use datawindow object d_sum_rel to work.
//	Arguments:		None
//	Returns:			Integer: 1=Successful, -1=Unsuccessful
//************************************************************************

Integer	li_rc

is_sum_rel_filter	=	"period = "	+	istr_summary_parm.period +	&
					" and function_name = '"	+	istr_summary_parm.function_nm + "'"

li_rc	=	idw.SetFilter(is_sum_rel_filter)
li_rc	=	idw.Filter()

Return li_rc


end function

public subroutine fuo_reset_filter ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_filter_dw
//
//	Description:	This function filters the datawindow (idw) to its
//						original result set.
//	Arguments:		None
//	Returns:			Integer: 1=Successful, -1=Unsuccessful
//************************************************************************

Integer	li_rc

is_function_filter	=	"period=" + istr_summary_parm.period + &
								" and function_name='" + &
								istr_summary_parm.function_nm + "'"

	// Reset any previous filters made to this datawindow
li_rc =  idw.setfilter('')
li_rc	=	idw.Filter()
li_rc	=	idw.SetFilter(is_function_filter)
li_rc	=	idw.Filter()



end subroutine

public function string fuo_create_group_by ();//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_create_group_by
//
//	Description:	This function edits and creates a group by statement
//						from sum_rel.  If there is a group by, it also
//						returns the order by.
//	Arguments:		None
//	Returns:			String.  '' = No group by clause
//************************************************************************
// 09-19-96 FNC	STARS35 Prob #36 IsNull function was not working and
//						sometimes there might be a space in the SUM_FLAG column
//						so code was changed to an if statement checking if = ''
//						or ' '
//	11-30-98	NLG	Implement Archana's changes for TS341
//************************************************************************

Integer	li_ix,				&
			li_upper
String	ls_col_name,		&
			ls_table_name,		&
			ls_tbl_type,		&
			ls_group_by = '',	&
			ls_sum_flag,		&
			ls_elem_name,		&
			ls_elem_indx_ind
Long		ll_row,				&
			ll_max_rows, ll_pos

//f_debug_box ('Debug', 'Entering fuo_create_group_by.  ')

	//	Reset the sum_rel back to its original state.
This.fuo_reset_sum_rel_filter()

	//	Edit to determine if you can create a 'group by' clause.
//djp - add error checking
if idw.rowcount() = 1 then 
	ls_sum_flag = idw.GetItemString ( 1, 'sum_flag')
	istr_summary_parm.group_by_flag = ls_sum_flag	//ts341 11-30-98
END IF

//djp - change <> to =
//09-19-96 FNC remove IsNull
//if ls_sum_flag = '' OR ls_sum_flag = ' ' OR ls_sum_flag	=	'G' THEN
if ls_sum_flag	<>	'G' or isnull(ls_sum_flag) THEN
	Return ''
END IF

	//	Get the table name and table type
ls_table_name	=	idw.GetItemString ( 1, 'table_name')
ls_tbl_type		=	This.fuo_get_tbl_type (ls_table_name)

li_upper			=	UpperBound (is_fields)

//f_debug_box ('Debug', '  ll_max_rows (idw_dict_cols) =' + String(ll_max_rows) )

IF	li_upper	<	1		THEN
	//f_debug_box ('Debug', 'Leaving fuo_create_group_by.  ls_select =')
	Return ''
END IF

//	For each column in is_fields, attach the column name to the
//	'Select' clause.

FOR	li_ix	=	1	TO	li_upper
	IF Trim (is_fields[li_ix].col_name)		>	' '			&
	AND Upper(is_fields[li_ix].col_name)	<>	'PERIOD'		THEN
			//	Concatenate table type with column name
		ls_col_name	=	ls_tbl_type	+	'.'	+	is_fields[li_ix].col_name
		IF	ls_group_by	=	''				THEN
			ls_group_by =	' GROUP BY '	+	ls_col_name
		ELSE
			ls_group_by	=	ls_group_by	+	', '	+	ls_col_name
		END IF
	END IF
NEXT


//	Attach the order by clause to the group by clause
ls_group_by	= ls_group_by

//f_debug_box ('Debug', 'Leaving fuo_create_group_by.  ls_group_by =' + &
//				ls_group_by)


Return	ls_group_by
end function

public function long fuo_get_sum_select (string as_col_type);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_sum_select
//
//	Description:	This function retrieves the data into idw_sum_select.
//						fuo_set_dw_sum_select must be called before this
//						function is executed.
//	Arguments:		as_col_type - Column type
//										  Values: 'SUMMARY', 'UNIVERSE', 'TREND'
//	Returns:			Long - The # of rows retrieved
//************************************************************************
//
//	FDG	04/16/01	Stars 4.7.	Properly trim the data.
//	GaryR	03/22/06	Track 4614	Convert GROUP_FLG value accordingly if it's null.
//
//************************************************************************

String	ls_inv_type, ls_function
String	ls_sum_flag
Long		ll_row
Integer	li_rc

	//	Get the invoice type and summary flag from sum_rel
ls_inv_type	=	idw.GetItemString ( 1, 'inv_type')
ls_sum_flag	=	trim(idw.GetItemString ( 1, 'sum_flag'))
//	When COL_TYPE is UNIVERSE, SUM_FLAG could be null
IF IsNull( ls_sum_flag ) THEN ls_sum_flag = ""
ls_function =  idw.GetItemString ( 1, 'function_name')

//NLG 2/14/00 Sum_flag can be 'B' for patient profiles
IF (ls_sum_flag <> 'G') AND (ls_sum_flag <> 'B') THEN ls_sum_flag = ''

// FDG 04/16/01 - Empty string in Oracle is null
li_rc	=	gnv_sql.of_TrimData (ls_inv_type)
li_rc	=	gnv_sql.of_TrimData (ls_sum_flag)
li_rc	=	gnv_sql.of_TrimData (ls_function)
// FDG 04/16/01 end

//djp 9/16/96 - must put in for time out
idw_sum_select.SetTransObject (Stars2ca)
ll_row		=	idw_sum_select.Retrieve (ls_inv_type, as_col_type, ls_sum_flag, ls_function)

Return ll_row

end function

public function any fuo_get_calc_disp_formats (boolean ab_universe);//************************************************************************
//	Object Name:	u_nvo_summary
//	Object Type:	Custom Class User Object Function
//	Script Name:	fuo_get_calc_disp_formats
//
//	Description:	This function retrieves the disp_format from sum_select.
//
//	Arguments:		Boolean - Include Provider Universe columns
//	Returns:			String - The remainder of the select statement using
//									the calculated fields retrieved.
//************************************************************************
//
//	03/01/07 Katie	SPR 4540 Set formats of calculated fields based on disp_format in SUM_SELECT
//	04/20/07	GaryR	SPR 4995	Include Provider Universe Computed Columns
//
//************************************************************************

Long		ll_row, ll_max_rows, ll_cnt
String 	ls_calc[]

//	Retrieve the calculated fields from sum_select
ll_max_rows	=	This.fuo_get_sum_select ( 'SUMMARY' )

FOR ll_row	=	1 TO ll_max_rows
	ls_calc[ll_row] = idw_sum_select.GetItemString ( ll_row, 'disp_format')
NEXT

IF ab_universe THEN
	//	Retrieve the Provider Universe 
	//	calculated fields from sum_select
	ll_cnt = ll_max_rows
	ll_max_rows	=	This.fuo_get_sum_select ( 'UNIVERSE' )

	FOR ll_row	=	1 TO ll_max_rows
		ls_calc[ll_cnt + ll_row] = idw_sum_select.GetItemString ( ll_row, 'disp_format')
	NEXT
END IF

Return ls_calc
end function

on u_nvo_summary.create
call super::create
end on

on u_nvo_summary.destroy
call super::destroy
end on

