$PBExportHeader$n_cst_dwobjectattrib.sru
$PBExportComments$PFC Attributes for the Modify / Describe service <logic>
forward
global type n_cst_dwobjectattrib from nonvisualobject
end type
end forward

global type n_cst_dwobjectattrib from nonvisualobject autoinstantiate
end type
global n_cst_dwobjectattrib n_cst_dwobjectattrib

type variables
Public:
string 	is_column
string	is_datatype
string 	is_value
end variables

on n_cst_dwobjectattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwobjectattrib.destroy
TriggerEvent( this, "destructor" )
end on

