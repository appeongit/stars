HA$PBExportHeader$n_cst_tableinfo_attrib.sru
$PBExportComments$Inherited from n_cst_attrib (Autoinstantiated) <logic>
forward
global type n_cst_tableinfo_attrib from n_cst_baseattrib
end type
end forward

global type n_cst_tableinfo_attrib from n_cst_baseattrib
end type

type variables
// The following are inputs
String	is_inv_type					// String containing the invoice type
String	is_operand					// Relational operand
String	is_paid_date				// String containing payment dates
Long		il_period_key				// In case period is used instead of payment date

// The following are outputs
String	is_base_table[]			// List of base table names
Boolean	ib_exclude_payment_date	// Is payment date to be excluded from the Where clause
DateTIme	idt_fromDate				//	Payment from date
DateTIme	idt_TDate					//	Payment thru date
Integer	il_rc							// Return code from Stars Server
String	is_message					// Error message from Stars Server

// The following payment_date Where clause is placed by Query Engine for future use
// This is set in u_nvo_create_sql.ue_format_where_criteria when payment_date is
//	included in the where clause
String	is_where_paid_date

// MikeF	03/04/04 SPR 3921d Using a LOJ with a UNION ALL View gives DB error
boolean	ib_view	
end variables

on n_cst_tableinfo_attrib.create
call super::create
end on

on n_cst_tableinfo_attrib.destroy
call super::destroy
end on

