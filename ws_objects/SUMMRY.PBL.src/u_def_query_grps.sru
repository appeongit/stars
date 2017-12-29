$PBExportHeader$u_def_query_grps.sru
$PBExportComments$<gui>
forward
global type u_def_query_grps from u_dw
end type
end forward

global type u_def_query_grps from u_dw
string accessiblename = "Sort Column"
string accessibledescription = "Sort Column"
accessiblerole accessiblerole = clientrole!
integer width = 795
integer height = 104
string dataobject = "d_def_query_col_label"
boolean border = false
borderstyle borderstyle = stylebox!
event ue_post_itemchanged ( )
end type
global u_def_query_grps u_def_query_grps

type variables
string is_sort_col //the column to sort the report by
boolean ib_pat_profile//NLG 03-06-00
end variables

forward prototypes
public function integer uf_set_patient_boolean (boolean ab_switch)
public function string uf_get_sort_col ()
public subroutine uf_load_dddw (long as_period, string as_function, string as_inv_type, string as_tbl_type, boolean ab_load)
public subroutine uf_load_dddw (string as_tbl_type, string as_sum_flag, boolean ab_load)
end prototypes

event ue_post_itemchanged;//ue_post_itemchanged
//
//	NLG	03-06-00	The dataobject will change depending on if
//						summary is a patient profile or not
//						Check ib_pat_profile and check the correct column
/////////////////////////////////////////////////////////////////////////

long ll_row_count
long ll_row_nbr
//*********************************************************//
// Highlights the current row and assigns column data from //
// that row to instance variables.  The return functions   //
// can be called to retrieve those variables.              //
//*********************************************************//

ll_row_count = this.RowCount()
ll_row_nbr = this.getrow()

If ll_row_nbr > 0 then
   
	is_sort_col = this.gettext()

	IF	Trim (is_sort_col)	<	' '	THEN
		IF ib_pat_profile THEN													//NLG 03-06-00
			is_sort_col = this.GetItemString(ll_row_nbr,'sort_col')	//NLG 03-06-00
		ELSE																			//NLG 03-06-00
			is_sort_col	=	this.GetItemString (ll_row_nbr, 'col_label')
		END IF																		//NLG 03-06-00
	END IF

else
	return
end if

end event

public function integer uf_set_patient_boolean (boolean ab_switch);//Set instance variable ib_pat_profile 
//If it's a patient profile, a different dataobject is used to
//retrieve sort columns.
//
//	NLG	03-06-00	Created
//////////////////////////////////////////////////////////////////

ib_pat_profile = ab_switch

return 1
end function

public function string uf_get_sort_col ();//is_sort_col is set in ue_post_itemchanged().  If
//the sort column is not set, get it from the d/w

Long		ll_row

IF	IsNull(is_sort_col)			&
OR	Trim(is_sort_col)	<	' '	THEN
	ll_row	=	This.GetRow()
	IF ib_pat_profile THEN
		is_sort_col = This.GetItemString (ll_row, 'sort_col')
	ELSE
		is_sort_col	=	This.GetItemString (ll_row, 'col_label')
	END IF
END IF

Return	is_sort_col

end function

public subroutine uf_load_dddw (long as_period, string as_function, string as_inv_type, string as_tbl_type, boolean ab_load);//uf_load_dddw().  
//This is an overloaded function.  If is a patient
//profile, will use this 'version' of uf_load_dddw to get
//the sort (rank) column from period_cntl/dictionary.
//If not a patient profile, will call other version of uf_load_dddw and
//retrieve sort columns from defined_query_groups.  
/////////////////////////////////////////////////////////////////////
//
//	11/27/00	GaryR	Stars 4.7 DataBase Port - Conversion of data types
//	04/17/03	GaryR	Track 3396d	Rewrite the flow of sorting
//	05/28/03	GaryR	Track 3593d	Add visual aid for sorting options
//
/////////////////////////////////////////////////////////////////////

DataWindowChild ldw_child
long    ll_insert_row,ll_rows
int li_rc

this.Reset()
ll_insert_row = this.InsertRow(0)
 
this.scrollToRow(ll_insert_row)

li_rc = this.GetChild('sort_col',ldw_child)
li_rc = ldw_child.Reset()

//	Do not load if criteria is empty
IF ab_load THEN
	li_rc = ldw_child.SetTransObject(stars2ca)
	//11/27/00	GaryR	Stars 4.7 DataBase Port
	gnv_sql.of_get_substring( ldw_child )
	ll_rows = ldw_child.Retrieve(as_period,as_function,as_inv_type,as_tbl_type)
END IF

ll_insert_row = ldw_child.InsertRow( 1 )
ldw_child.SetItem( ll_insert_row, "elem_desc", "Selected Fields" )
ldw_child.SetItem( ll_insert_row, "elem_name", "Selected Fields" )
IF ldw_child.RowCount() > 1 THEN
	This.SetItem( 1, "sort_col", ldw_child.GetItemString( 2,'elem_desc' ) )
ELSE
	This.SetItem( 1, "sort_col", ldw_child.GetItemString( 1,'elem_desc' ) )
END IF

this.triggerevent(itemchanged!)

end subroutine

public subroutine uf_load_dddw (string as_tbl_type, string as_sum_flag, boolean ab_load);//uf_load_dddw().  
//This is an overloaded function.  If not a patient profile, will
//will call this 'version' of uf_load_dddw and
//retrieve sort columns from defined_query_groups.  If is a patient
//profile, will use the other 'version' of uf_load_dddw to get
//the sort (rank) column from period_cntl/dictionary.
/////////////////////////////////////////////////////////////////////
// Change History
/////////////////////////////////////////////////////////////////////
// 10/11/02	Jason	Created.  Track 2991d  remove char data types
//						I added as_overload_func just because there was
//						already a function with two string inputs and
//						I didn't want to changed that one.  I will pass an
//						empty string into as_overload_func and it will not
//						be used.
//	04/17/03	GaryR	Track 3396d	Rewrite the flow of sorting
//	05/28/03	GaryR	Track 3593d	Add visual aid for sorting options
/////////////////////////////////////////////////////////////////////

DataWindowChild ldw_child
long    ll_insert_row,ll_rows
int i

this.Reset()
ll_insert_row = this.InsertRow(0)
 
this.scrollToRow(ll_insert_row)//NLG 02-28-00

ldw_child.setredraw(false)

this.GetChild('col_label',ldw_child)
ldw_child.Reset()

//	Do not load if criteria is empty
IF ab_load THEN
	ldw_child.SetTransObject(stars2ca)
	ll_rows = ldw_child.Retrieve(as_tbl_type)
	
	for i = 1 to ll_rows
		if pos(ldw_child.getitemstring(i, "elem_desc"), '/') > 0 then
			ldw_child.setitem(i, "elem_desc", left(ldw_child.getitemstring(i, "elem_desc"), pos(ldw_child.getitemstring(i, "elem_desc"), '/') - 1))
		else
			ldw_child.setitem(i, "elem_desc", left(ldw_child.getitemstring(i, "elem_desc"), 16))
		end if
	next
	
	do while (ll_rows >= 1)
		if gnv_sql.of_is_character_data_type(ldw_child.getitemstring(ll_rows, 'elem_data_type')) OR trim(ldw_child.getitemstring(ll_rows, 'elem_desc')) = "" then
			ldw_child.rowsdiscard(ll_rows, ll_rows, Primary!)		
		end if
		ll_rows --
	loop
	
	if (as_sum_flag = 'G') then
		ll_rows = ldw_child.rowcount()
		do while (ll_rows >= 1)
		if not gnv_sql.of_is_money_data_type(ldw_child.getitemstring(ll_rows, 'elem_data_type')) OR trim(ldw_child.getitemstring(ll_rows, 'elem_desc')) = "" then
			ldw_child.rowsdiscard(ll_rows, ll_rows, Primary!)		
		end if
		ll_rows --
		loop
	end if
END IF

ll_insert_row = ldw_child.InsertRow( 1 )
ldw_child.SetItem( ll_insert_row, "elem_desc", "Selected Fields" )
ldw_child.SetItem( ll_insert_row, "elem_name", "Selected Fields" )
This.SetItem( 1, "col_label", ldw_child.GetItemString( 1,'elem_desc' ) )

ldw_child.setredraw(true)

this.triggerevent(itemchanged!)

end subroutine

event itemchanged;//NLG 02-28-00 post this event
//long ll_row_count
//long ll_row_nbr
////*********************************************************//
//// Highlights the current row and assigns column data from //
//// that row to instance variables.  The return functions   //
//// can be called to retrieve those variables.              //
////*********************************************************//
//
//ll_row_count = this.RowCount()
//ll_row_nbr = this.getrow()
//
//If ll_row_nbr > 0 then
//
////	this.SelectRow(0,FALSE)
////	this.SelectRow(ll_row_nbr,TRUE)
//   
//	is_sort_col = this.gettext()
//
//	IF	Trim (is_sort_col)	<	' '	THEN
//		is_sort_col	=	this.GetItemString (ll_row_nbr, 'col_label')
//	END IF
//
//else
//	return
//end if
//
//NLG 02-28-00 move to user event and post event.  
this.post event ue_post_itemchanged()


//NLG 02-28-00 


end event

on u_def_query_grps.create
end on

on u_def_query_grps.destroy
end on

