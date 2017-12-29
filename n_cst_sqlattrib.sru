HA$PBExportHeader$n_cst_sqlattrib.sru
$PBExportComments$PFC parsed SQL syntax for SQL Parser attributes <logic>
forward
global type n_cst_sqlattrib from n_cst_baseattrib
end type
end forward

global type n_cst_sqlattrib from n_cst_baseattrib
end type

type variables
//*********************************************************************************
//	
// Lahu S Stars 5.1	Created Track 2552d
//	SQL Parser attributes
//
//*********************************************************************************

string s_verb	
string s_tables	
string s_columns	
string s_values	
string s_where	
string s_order	
string s_group	
string s_having	

end variables

on n_cst_sqlattrib.create
call super::create
end on

on n_cst_sqlattrib.destroy
call super::destroy
end on

