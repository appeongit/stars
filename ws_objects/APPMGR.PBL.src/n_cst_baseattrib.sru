$PBExportHeader$n_cst_baseattrib.sru
$PBExportComments$Base attributes NVO - All Attribute NVOs are inherited from this. <logic>
forward
global type n_cst_baseattrib from nonvisualobject
end type
end forward

global type n_cst_baseattrib from nonvisualobject autoinstantiate
end type

on n_cst_baseattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_baseattrib.destroy
TriggerEvent( this, "destructor" )
end on

