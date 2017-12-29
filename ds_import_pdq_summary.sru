HA$PBExportHeader$ds_import_pdq_summary.sru
$PBExportComments$<logic>
forward
global type ds_import_pdq_summary from n_ds
end type
end forward

global type ds_import_pdq_summary from n_ds
string dataobject = "d_import_pdq_summary"
end type
global ds_import_pdq_summary ds_import_pdq_summary

on ds_import_pdq_summary.create
call super::create
end on

on ds_import_pdq_summary.destroy
call super::destroy
end on

