HA$PBExportHeader$n_base.sru
$PBExportComments$All NVOs are inherited from this object. <logic>
forward
global type n_base from nonvisualobject
end type
end forward

global type n_base from nonvisualobject
event documentation ( )
end type
global n_base n_base

type variables
// Temp table service
n_cst_temp_table	inv_temp_table
end variables

forward prototypes
public function integer of_set_temp_table (boolean ab_switch)
end prototypes

event documentation;/*

Place object documentation here.

*/

end event

public function integer of_set_temp_table (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Set_temp_table
//
//	Arguments:		
//		ab_switch   Starts/stops the temp table service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//		Starts or stops the temp table service
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_temp_table) then
		inv_temp_table = create n_cst_temp_table
		li_rc = 1
	end if
else
	if IsValid (inv_temp_table) then
		destroy inv_temp_table
		li_rc = 1
	end if
end If

return li_rc

end function

on n_base.create
TriggerEvent( this, "constructor" )
end on

on n_base.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;// To use the temp table service (to create a temp table)
//This.of_set_temp_table (TRUE)
end event

event destructor;// Destroy any created objects
This.of_set_temp_table (FALSE)

end event

