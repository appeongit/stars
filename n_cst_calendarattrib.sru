HA$PBExportHeader$n_cst_calendarattrib.sru
$PBExportComments$<logic>
forward
global type n_cst_calendarattrib from n_cst_baseattrib
end type
end forward

global type n_cst_calendarattrib from n_cst_baseattrib
end type

type variables
Public:

boolean 	ib_dropdown = False
end variables

on n_cst_calendarattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_calendarattrib.destroy
TriggerEvent( this, "destructor" )
end on

