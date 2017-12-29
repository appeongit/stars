HA$PBExportHeader$n_cst_prefilter_attrib.sru
$PBExportComments$<logic>
forward
global type n_cst_prefilter_attrib from n_cst_baseattrib
end type
end forward

global type n_cst_prefilter_attrib from n_cst_baseattrib
end type

type variables
int 		ii_filter_count
string	is_where
string	is_filter_id[]

//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
int		ii_selected_rows[]
string	is_boolean[]
end variables

on n_cst_prefilter_attrib.create
call super::create
end on

on n_cst_prefilter_attrib.destroy
call super::destroy
end on

