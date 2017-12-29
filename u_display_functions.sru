HA$PBExportHeader$u_display_functions.sru
$PBExportComments$Inherited from u_dw <gui>
forward
global type u_display_functions from u_dw
end type
end forward

global type u_display_functions from u_dw
string accessiblename = "Function"
string accessibledescription = "Function"
accessiblerole accessiblerole = clientrole!
integer width = 722
integer height = 108
string dataobject = "d_display_functions"
end type
global u_display_functions u_display_functions

type variables
string is_function
end variables

forward prototypes
public subroutine uf_load_dddw (string as_invoice_type)
public function string uf_get_function ()
end prototypes

public subroutine uf_load_dddw (string as_invoice_type);DataWindowChild ldw_child
long    ll_insert_row

//*******************************//
// retrieve the child datawindow //
//*******************************//

this.Reset()
ll_insert_row = this.InsertRow(0)
this.GetChild('function_name',ldw_child)
ldw_child.Reset()
ldw_child.SetTransObject(stars2ca)
ldw_child.Retrieve(as_invoice_type)
	
this.triggerevent(itemchanged!)
end subroutine

public function string uf_get_function ();//	If the function is not set properly, get the function from the d/w

Long		ll_row

IF	IsNull(is_function)			&
OR	Trim(is_function)	<	' '	THEN
	ll_row	=	This.GetRow()
	is_function	=	This.GetItemString (ll_row, 'function_name')
END IF

Return	is_function

end function

event itemchanged;long ll_row_count
long ll_row_nbr
//*********************************************************//
// Highlights the current row and assigns column data from //
// that row to instance variables.  The return functions   //
// can be called to retrieve those variables.              //
//*********************************************************//

ll_row_nbr = this.getrow()

If ll_row_nbr > 0 then

//	this.SelectRow(0,FALSE)
//	this.SelectRow(ll_row_nbr,TRUE)
   
	is_function = this.gettext()

	IF	Trim (is_function)	<	' '	THEN
		is_function	=	this.GetItemString (ll_row_nbr, 'function_name')
	END IF

else
	return
end if


end event

on losefocus;//this.TriggerEvent(itemchanged!)
end on

on u_display_functions.create
end on

on u_display_functions.destroy
end on

