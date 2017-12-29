$PBExportHeader$u_nvo_sys_cntl_range.sru
$PBExportComments$Inherited from u_nvo_sys_cntl <logic>
forward
global type u_nvo_sys_cntl_range from u_nvo_sys_cntl
end type
end forward

global type u_nvo_sys_cntl_range from u_nvo_sys_cntl
end type
global u_nvo_sys_cntl_range u_nvo_sys_cntl_range

forward prototypes
public function integer of_get_earliest_range ()
end prototypes

public function integer of_get_earliest_range ();Return -3650
end function

event constructor;call super::constructor;This.of_set_cntl_id('RANGE')
end event

on u_nvo_sys_cntl_range.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_sys_cntl_range.destroy
TriggerEvent( this, "destructor" )
end on

