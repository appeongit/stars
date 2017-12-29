HA$PBExportHeader$n_cst_toolbarattrib.sru
$PBExportComments$PFC Toolbar attributes used by the Toolbar window <logic>
forward
global type n_cst_toolbarattrib from nonvisualobject
end type
end forward

global type n_cst_toolbarattrib from nonvisualobject autoinstantiate
end type
global n_cst_toolbarattrib n_cst_toolbarattrib

type variables
Public:
window	iw_owner
boolean	ib_visibleenabled
boolean	ib_positionenabled
boolean	ib_largebuttonsenabled
boolean	ib_tooltipsenabled
end variables

on n_cst_toolbarattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_toolbarattrib.destroy
TriggerEvent( this, "destructor" )
end on

