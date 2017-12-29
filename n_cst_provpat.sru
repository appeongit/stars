HA$PBExportHeader$n_cst_provpat.sru
$PBExportComments$<logic>
forward
global type n_cst_provpat from n_base
end type
end forward

global type n_cst_provpat from n_base autoinstantiate
end type

forward prototypes
public function integer of_get_xref_trans (ref n_tr atr_xref_trans)
end prototypes

public function integer of_get_xref_trans (ref n_tr atr_xref_trans);//	09/18/06	GaryR	Track 4683	Dynamically set the transaction of ENROLLEE_XREF table

String	ls_db

SELECT db 
INTO :ls_db
FROM DICTIONARY
WHERE ELEM_TYPE = 'TB'
AND ELEM_NAME = 'ENROLLEE_XREF'
USING STARS2CA;

IF Stars2ca.of_check_status( ) <> 0 THEN
	MessageBox( "ERROR", "Error locating  ENROLLEE_XREF table in DICTIONARY" )
	Return -1
END IF

IF IsNull( ls_db ) OR Trim( ls_db ) = "" THEN
	MessageBox( "ERROR", "Error identifying ENROLLEE_XREF database in DICTIONARY" )
	Return -1
END IF

ls_db = Upper( Trim( ls_db ) )

IF ls_db = gnv_sql.of_get_database_name( Stars2ca ) THEN
	atr_xref_trans = Stars2ca
ELSEIF ls_db = gnv_sql.of_get_database_name( Stars1ca ) THEN
	atr_xref_trans = Stars1ca
ELSE
	MessageBox( "ERROR", "Error identifying ENROLLEE_XREF transaction." )
	Return -1
END IF

Return 1
end function

on n_cst_provpat.create
call super::create
end on

on n_cst_provpat.destroy
call super::destroy
end on

