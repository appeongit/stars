HA$PBExportHeader$n_cst_infoattrib.sru
$PBExportComments$Inherited from n_cst_baseattrib <logic>
forward
global type n_cst_infoattrib from n_cst_baseattrib
end type
end forward

global type n_cst_infoattrib from n_cst_baseattrib
end type
global n_cst_infoattrib n_cst_infoattrib

type variables
Public:

String	is_name
String	is_description

end variables

on n_cst_infoattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_infoattrib.destroy
TriggerEvent( this, "destructor" )
end on

