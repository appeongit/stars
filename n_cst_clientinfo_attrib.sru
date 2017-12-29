HA$PBExportHeader$n_cst_clientinfo_attrib.sru
$PBExportComments$Inherited from n_cst_attrib (Autoinstantiated) <logic>
forward
global type n_cst_clientinfo_attrib from n_cst_baseattrib
end type
end forward

global type n_cst_clientinfo_attrib from n_cst_baseattrib
end type

type variables
// 09/20/04 Katie Track 3699 Added il_idle_time attribute
//	10/14/04	GaryR	Track 3699d	Accomodate COM changes for UserAdmin

String	is_userid
String	is_password
String	is_schema_name
Long		il_days_to_expire
Long 		il_idle_minutes
Boolean	ib_is_client_admin
end variables

on n_cst_clientinfo_attrib.create
call super::create
end on

on n_cst_clientinfo_attrib.destroy
call super::destroy
end on

