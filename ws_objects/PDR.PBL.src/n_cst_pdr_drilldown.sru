$PBExportHeader$n_cst_pdr_drilldown.sru
$PBExportComments$Non-visual user object to store PDR drilldown information <logic>
forward
global type n_cst_pdr_drilldown from nonvisualobject
end type
end forward

global type n_cst_pdr_drilldown from nonvisualobject autoinstantiate
end type

type variables
//////////////////////////////////////////////////////////////////////
//
//	Lahu S
//	10/21/04	GaryR	Track 4089d	Add third tier to PDR report selection
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
//////////////////////////////////////////////////////////////////////

string		pdr_cat, pdr_type, pdr
n_ds			ids_criteria
n_ds			ids_source
sx_dw_format	isx_report_options


end variables

on n_cst_pdr_drilldown.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_pdr_drilldown.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//
//////////////////////////////////////////////////////////////////////

ids_criteria = CREATE n_ds
ids_criteria.dataobject = "d_criteria_drilldown"

ids_source = CREATE n_ds
ids_source.dataobject = "d_pdr_source"
end event

event destructor;//////////////////////////////////////////////////////////////////////
//
//	11/16/04	GaryR	Track	4115d	STARS Reporting - Claims PDRs
//
//////////////////////////////////////////////////////////////////////

IF IsValid( ids_criteria ) THEN Destroy ids_criteria
IF IsValid( ids_source ) THEN Destroy ids_source
end event

