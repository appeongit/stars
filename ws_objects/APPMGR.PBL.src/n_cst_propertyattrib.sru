$PBExportHeader$n_cst_propertyattrib.sru
$PBExportComments$Inherited from n_cst_baseattrib <logic>
forward
global type n_cst_propertyattrib from n_cst_baseattrib
end type
end forward

global type n_cst_propertyattrib from n_cst_baseattrib
end type
global n_cst_propertyattrib n_cst_propertyattrib

type variables
Public:

// NOTE:  Not all attributes will be used by all objects

String	is_name
String	is_description
String	is_propertypage[]
String	is_propertytabtext

Boolean	ib_switchbuttons

end variables

on n_cst_propertyattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_propertyattrib.destroy
TriggerEvent( this, "destructor" )
end on

