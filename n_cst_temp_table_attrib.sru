HA$PBExportHeader$n_cst_temp_table_attrib.sru
$PBExportComments$Contains data required to create or drop temporary tables (inherited from n_cst_baseattrib) <logic>
forward
global type n_cst_temp_table_attrib from n_cst_baseattrib
end type
end forward

global type n_cst_temp_table_attrib from n_cst_baseattrib
end type

type variables
String	is_function	// CREATE or DROP
String	is_table_name	// Only populated if DROP or Creating a Temp Table.  
String	is_inv_type		// Required for Stars Server

//	09/24/01	GaryR	Track 2418d	Handle additional data source when creating Temp Tables
String	is_add_inv_type	// Only populated if Creating a Temp Table.

sx_cols	istr_cols[]		// only populated if CREATE
sx_index_cols	istr_index_cols[]	// only populated if CREATE

Integer	ii_request	// 1 = ICN table, 2 = Key table, 3 = Temp table

// Error message processing from Stars Server
String	is_message
Long		il_rc

// Values for ii_request
Constant	Integer	ici_icn_table	=	1
Constant	Integer	ici_key_table	=	2
Constant	Integer	ici_temp_table	=	3

end variables

on n_cst_temp_table_attrib.create
call super::create
end on

on n_cst_temp_table_attrib.destroy
call super::destroy
end on

