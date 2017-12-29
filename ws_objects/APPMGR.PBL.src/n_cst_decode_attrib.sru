$PBExportHeader$n_cst_decode_attrib.sru
$PBExportComments$<logic>
forward
global type n_cst_decode_attrib from n_base
end type
end forward

global type n_cst_decode_attrib from n_base autoinstantiate
end type

type variables
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background

String	is_col_nam[], is_db_col[], is_sort[], is_lookup_type[]
Integer	ii_code_decode[], ii_col_num[]

u_dw	iudw_requestor
sx_decode_structure isx_decode_struc
w_master	iw_active
end variables

on n_cst_decode_attrib.create
call super::create
end on

on n_cst_decode_attrib.destroy
call super::destroy
end on

