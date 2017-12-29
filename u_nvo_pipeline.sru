HA$PBExportHeader$u_nvo_pipeline.sru
$PBExportComments$<logic>
forward
global type u_nvo_pipeline from pipeline
end type
end forward

global type u_nvo_pipeline from pipeline
string syntax = "DummySyntax"
string dataobject = "p_dummy_pipe"
end type
global u_nvo_pipeline u_nvo_pipeline

type variables
string		is_target_table
string		is_view_sql

boolean		ib_cancelled
boolean		ib_create_view

n_tr			itr_source	
n_tr			itr_target

n_ds			ids_error

w_transfer_status	iw_status

end variables

forward prototypes
public function string uf_get_error_message (integer ai_error)
public subroutine uf_set_syntax (string as_sql, ref datawindow adw_columns, string as_target_table)
public subroutine uf_execute ()
end prototypes

public function string uf_get_error_message (integer ai_error);CHOOSE CASE ai_error
 	CASE -1
		RETURN "Pipe open failed"
	CASE -2   
		RETURN "Too many columns"
	CASE -3   
		RETURN "Table already exists"
	CASE -4   
		RETURN "Table does not exist"
	CASE -5   
		RETURN "Missing connection"
	CASE -6   
		RETURN "Wrong arguments"
	CASE -7   
		RETURN "Column mismatch"
	CASE -8   
		RETURN "Fatal SQL error in source"
	CASE -9   
		RETURN "Fatal SQL error in destination"
	CASE -10  
		RETURN "Maximum number of errors exceeded"
	CASE -12  
		RETURN "Bad table syntax"
	CASE -13  
		RETURN "Key required but not supplied"
	CASE -15  
		RETURN "Pipe already in progress"
	CASE -16  
		RETURN "Error in source database"
	CASE -17  
		RETURN "Error in destination database"
	CASE -18  
		RETURN "Destination database is read-only"
END CHOOSE

RETURN "Undocumented Error"


end function

public subroutine uf_set_syntax (string as_sql, ref datawindow adw_columns, string as_target_table);//=======================================================================================//
//	Object:			u_nvo_pipeline
//	Function:		uf_set_syntax
//	Arguments:		String		as_sql				The SELECT SQL that will be executed
//						datawindow	adw_columns			Datawindow from dw_selected
//						String		as_target_table	Name of Access table to store results in
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Sets the Pipe syntax based on the selected columns and datatypes
//---------------------------------------------------------------------------------------//
//	08/12/04 MikeF	SPR3852d	Created
//=======================================================================================//
string	ls_header, ls_source, ls_retrieve, ls_target			// Portions of Syntax
string	ls_datawindow, ls_database, ls_access, ls_initial	// Data definitions
int 		li_rows, loop_ix, li_data_len, li_data_scale	
string 	ls_elem_name, ls_data_type, ls_format	
n_cst_export	ln_export
//---------------------------------------------------------------------------------------//
is_target_table = as_target_table

// HEADER
ls_header = "PIPELINE(source_connect=DUMMY,destination_connect=MS Access Database" + &
				",type=create,commit=1000,errors=100)"

//
ls_source 	= ' SOURCE(name="MEDC_C1PROF",'
ls_target	= ' DESTINATION(name="' + as_target_table + '",'
ls_retrieve = ' RETRIEVE(statement="' + as_sql + '")'

li_rows 	= adw_columns.rowcount()

// Loop through all columns
FOR loop_ix	= 1 TO li_rows
	ls_elem_name	= adw_columns.GetItemString(loop_ix, "ELEM_NAME")
	ls_data_type 	= Upper(adw_columns.GetItemString(loop_ix, "ELEM_DATA_TYPE"))
	li_data_len		= adw_columns.GetItemNumber(loop_ix, "ELEM_DATA_LEN")
	li_data_scale	= adw_columns.GetItemNumber(loop_ix, "ELEM_DATA_SCALE")
	ls_format		= adw_columns.GetItemString(loop_ix, "DISP_FORMAT")

	CHOOSE CASE ls_data_type
			
		CASE "DATE","DATETIME","SMALLDATETIME","TIMESTAMP"
			ls_datawindow	= "datetime"
			ls_database		= ls_data_type
			ls_access		= "DATETIME"
			ls_initial		= "today"
		
		CASE "SMALLINT","TINYINT"
			ls_datawindow	= "int"
			ls_database		= ls_data_type
			ls_access 		= "SMALLINT"
			ls_initial     = "0"	
			
		CASE "INT"
			ls_datawindow	= "real"
			ls_database		= ls_data_type
			ls_access 		= "INTEGER"
			ls_initial     = "0"
		
		CASE "NUMBER", "DECIMAL"
			ls_database		= "NUMBER(" + string(li_data_len) + "," + string(li_data_scale) + ")"
			ls_initial     = "0"
			
			IF pos(ls_format,"$") > 0 THEN
				ls_datawindow	= "decimal"
				ls_access		= "CURRENCY"
			ELSE
				IF li_data_scale = 0 THEN
					ls_datawindow	= "int"
					ls_access 		= "INTEGER"
				ELSE
					ls_datawindow	= "decimal"
					ls_access 		= "DOUBLE"
				END IF
			END IF
						
		CASE "MONEY", "SMALLMONEY"
			ls_datawindow	= "decimal"
			ls_database		= ls_data_type
			ls_initial     = "0"

			IF pos(ls_format,"$") > 0 THEN
				ls_access 	= "CURRENCY"
			ELSE
				ls_access 	= "DOUBLE"
			END IF

		CASE "FLOAT"
			ls_datawindow	= "double"
			ls_database		= ls_data_type
			ls_initial     = "0"
			ls_access 		= "DOUBLE"
		
		CASE ELSE
			ls_datawindow	= "char"
			ls_database		= ls_data_type + "(" + string(li_data_len) + ")"
			ls_access 		= "VARCHAR(" + string(li_data_len) + ")"
			ls_initial 		= "spaces"
			
	END CHOOSE

	ls_source += 'COLUMN(type=' + ls_datawindow + ',name="' + ls_elem_name + '",dbtype="' + ls_database + '"' + &
					 ',nulls_allowed=no) '
	ls_target += 'COLUMN(type=' + ls_datawindow + ',name="' + ls_elem_name + '",dbtype="' + ls_access   + '"' + &
					 ',nulls_allowed=no,initial_value="' + ls_initial + '") '
NEXT

ls_source += ")"
ls_target += ")"

this.syntax = ls_header + ls_source + ls_retrieve + ls_target

/*
this.syntax = 'PIPELINE(source_connect=SODEV5X,destination_connect=MS Access Database,type=create,commit=100,errors=100)' + &
					' SOURCE(name="MEDC_D1DIAG",COLUMN(type=varchar,name="ICN",dbtype="VARCHAR2(17)",nulls_allowed=no))' + &
					' RETRIEVE(statement="SELECT MEDC_D1DIAG.ICN FROM MEDC_D1DIAG")' + &
					' DESTINATION(name="EXP_123",COLUMN(type=varchar,name="Claim Num",dbtype="VARCHAR(17)",nulls_allowed=no,initial_value="spaces"))'

*/

end subroutine

public subroutine uf_execute ();//=======================================================================================//
//	Object:			u_nvo_pipeline
//	Event:			uf_execute
//	Arguments:		None
//	Returns:			None
//---------------------------------------------------------------------------------------//
// Executes transfer, checks return code, creates view, destroys transaction
//---------------------------------------------------------------------------------------//
// 12/22/04 MikeF SPR4184d Moved all control/error handling from QE to pipe 
// 04/01/06 JasonS Track 4206d  Query the db to find out how many rows were written it transfer is cancelled.
//=======================================================================================//
int		li_rc, li_view
string ls_sql
long ll_rowswritten

li_rc = this.start( itr_source, itr_target, ids_error)

IF li_rc = 1 THEN
	IF ib_cancelled THEN
		ls_sql = "Select count(*) from " + is_target_table
		PREPARE SQLSA FROM :ls_sql using itr_target ;
		DESCRIBE SQLSA INTO SQLDA ;
		DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
		OPEN DYNAMIC my_cursor USING DESCRIPTOR SQLDA ;
		FETCH my_cursor USING DESCRIPTOR SQLDA ;
		
		CHOOSE CASE SQLDA.OutParmType[1]
				  CASE TypeInteger!, TypeDecimal!, TypeDouble!, TypeLong!, TypeReal!,  TypeBoolean! 
						ll_rowswritten = GetDynamicNumber(SQLDA, 1)
		END CHOOSE
		
		CLOSE my_cursor ;

		
		MessageBox("Transfer Cancelled","Transfer cancelled. " + string(ll_rowswritten) + " rows written")
	ELSE
		MessageBox("Transfer Complete","Transfer complete. "   + string(rowswritten) + " rows written")
	END IF
	
	// Create the view
	IF ib_create_view THEN
		li_view = itr_target.of_execute( is_view_sql )
		
		IF li_view < 0 THEN
			MessageBox("Export Error","Error creating Microsoft Access Query " + is_target_table + "_LABELS")
		END IF

	END IF	
	
ELSE
	MessageBox("Error","Transfer failed. Return code = " + string(li_rc) + "~r~r" + &
					uf_get_error_message( li_rc) )
END IF

// Clean up
itr_target.of_commit()
itr_target.of_disconnect()
DESTROY itr_target

end subroutine

on u_nvo_pipeline.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_nvo_pipeline.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event pipeend;//=======================================================================================//
//	Object:			u_nvo_pipeline
//	Event:			pipeend
//	Arguments:		None
//	Returns:			long
//---------------------------------------------------------------------------------------//
// Closes Transfer window and prompts user if cancelled
//---------------------------------------------------------------------------------------//
//	08/12/04 MikeF	SPR3852d	Created
//=======================================================================================//
int	li_rc

IF this.rowsinerror > 0 THEN
	li_rc = ids_error.SaveAs( "C:\PipeError.xls",Excel5!,TRUE)
	IF li_rc = 1 THEN
		MessageBox("Access Errors", String(this.rowsinerror) + " errors encountered." + &
						"Refer to C:\PipeError.xls",Exclamation!)
	END IF
END IF

IF IsValid(iw_status) THEN
	iw_status.ib_ask = false
	Close(iw_status)
END IF


end event

event pipestart;//=======================================================================================//
//	Object:			u_nvo_pipeline
//	Event:			pipestart
//	Arguments:		None
//	Returns:			long
//---------------------------------------------------------------------------------------//
// Opens Transfer status window
//---------------------------------------------------------------------------------------//
//	08/12/04 MikeF	SPR3852d	Created
//=======================================================================================//
OpenWithParm(iw_status, this)
end event

event constructor;//=======================================================================================//
//	Object:			u_nvo_pipeline
//	Event:			constructor
//	Arguments:		None
//	Returns:			long
//---------------------------------------------------------------------------------------//
// Creates a new transaction object
//---------------------------------------------------------------------------------------//
//	08/12/04 MikeF	SPR3852d	Created
//=======================================================================================//
n_cst_clientinfo_attrib		lnv_client		

itr_source					= CREATE n_tr
itr_source.DBMS      	= stars2ca.DBMS
itr_source.Database  	= stars2ca.Database
itr_source.ServerName	= stars2ca.ServerName
itr_source.Lock      	= stars2ca.Lock
itr_source.DbParm    	= stars2ca.DbParm
itr_source.LogID     	= stars2ca.LogID
itr_source.LogPass   	= stars2ca.LogPass
itr_source.UserID    	= stars2ca.UserID
itr_source.DBPass    	= stars2ca.DBPass
// Get schema info for Oracle
lnv_client	=	gnv_server.of_GetClientInfo()
gnv_sql.of_set_schema (lnv_client.is_schema_name)
itr_source.of_connect( )

IF itr_source.of_check_status() <> 0 THEN
	RETURN
END IF

ids_error 	= CREATE n_ds
end event

