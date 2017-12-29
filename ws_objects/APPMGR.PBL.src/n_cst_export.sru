$PBExportHeader$n_cst_export.sru
$PBExportComments$This object contains supporting functionality used during exports - GR. <logic>
forward
global type n_cst_export from n_base
end type
end forward

global type n_cst_export from n_base autoinstantiate
event type integer ue_excel ( u_dw adw_export,  string as_path,  string as_version )
event type integer ue_pdf ( string as_filename,  u_dw adw_requestor,  string as_title )
event type integer ue_access ( u_dw adw_source )
event type integer ue_append_doc ( string as_source,  string as_target )
event type integer ue_init_pdf ( ref oleobject aole_pdf )
end type

type prototypes
//	08/09/02	GaryR	Track 3249d	Provide export to PDF format
//				API method to register the PDF ActiveX interface
//	12/02/08	GaryR	SPR 5592	Upgrade PDF Printer for Vista

Function	long	DllRegisterServer()	Library	"cdintf300.dll"
end prototypes

type variables
//	PDF ActiveX Constants
Constant	Long		NoPrompt = 1, UseFileName = 2
Constant	String	PrinterName = "STARS PDF Converter"

String 	is_path, is_file_name, is_dflt_prn
boolean  ib_cancelled
boolean	ib_visible[]
String	is_captions[]
sx_access_options	isx_access_options
n_tr		itr_access

//	These are the Excel row limits by version
Constant Long	il_xlrowlimit = 65536
Constant Long	il_xl2007rowlimit = 1048576
end variables

forward prototypes
public function string of_getexcelrange (integer ai_col1, integer ai_row1, integer ai_col2, integer ai_row2)
public function string of_getexcelrange (integer ai_col1, integer ai_col2)
public function string of_inttocolumn (integer ai_col)
public function string uf_get_view_sql (readonly u_dw adw, string as_table_name)
public function boolean of_get_table_exists (ref n_tr atr, string as_object_name)
public function integer of_set_access_tran ()
public function integer of_create_view (readonly u_dw adw, string as_table_name)
public function boolean of_get_access_tables_exist (ref string as_table_name)
public function integer of_save_export_sql (string as_sql)
public function integer of_save_export_criteria (u_dw adw_criteria)
public function integer of_create_table (readonly u_dw adw)
public subroutine of_set_access_options (string ab_parm)
public function integer of_setpdfprinter ()
public function integer of_resetdefaultprinter ()
public subroutine of_activateprinter (oleobject aole_pdf)
end prototypes

event type integer ue_excel(u_dw adw_export, string as_path, string as_version);//*********************************************************************************
// Script Name:	n_cst_export.ue_excel
//
// Arguments:	u_dw	adw_export	datawindow to export
//					String	as_path	save path
//					String	as_version	Excel version and type to export
//
// Returns:		Integer	1 = Success; -1 = Fail; -2 = Cancel
//
// Description:	This is a wrapper script for the dw2xls library developed by
//						Desta. This library is located in DW2XLS.PBL and allows for 
//						WYSIWYG exporting to legacy Excel as well as Excel 2007.
//						For more info go to http://desta.com.ua/dw2xls/index.html
//
//						This event will also process the logic for formatted exports
//						to legacy Excel and Excel 2007.
//
//*********************************************************************************
//
//	09/25/09	GaryR	EXP.650.4897.001	Add support for exporting to Excel 2007
// 09/25/09	GaryR	EXP.650.4897.002	Add support for Excel WYSIWYG export
// 09/29/09	GaryR	EXP.650.4897.004	Prevent timeout during export
//	10/31/09	GaryR	EXP.650.4897.005	Add support for formatted export to all versions of Excel
//	11/04/09	GaryR	EXP.650.4897.005	QCD157-Revert back to exporting to Excel5 
//														format due to performance issues
//	11/04/09	GaryR	EXP.650.4897.005	QCD161-Provide better error handling when SaveAs fails
//	11/06/09	GaryR	EXP.650.4897.001	QCD156-Alternative solution for exporting to Excel 2007
//														due to the issues with the PowerBuilder functionality
//	05/29/10	GaryR	SPR 5811	Workaround for desta limitation of exporting headers that extend beyond the detail band
//	06/02/10	Katie	SPR 5804	For XLSX file export to DBF then open in Excel to maintain formatting - prevent
//										exponential numbers and truncated leading zeros.
//
//*********************************************************************************

Integer			li_rtn, li_ctr, li_workbook, li_colcount, li_writecols, li_format, li_version
Integer			li_pos, li_width, li_x, li_ptr, li_ptr_detail
String				ls_test, ls_column, ls_dup_num, ls_format, ls_type, ls_tmp = ".dbf"
String				ls_mod, ls_controls[], ls_width
Boolean			lb_visible
Long				ll_cnt
n_dwr_service_parm lnv_xl_parms
OLEObject		excel, wrksheet
n_cst_string	lnv_string
n_cst_export	lnv_export

SetPointer( HourGlass! )
gnv_app.of_set_idle( FALSE )

CHOOSE CASE as_version
	CASE "XLSW!", "XLSXW!"				// WYSIWYG Legacy and Excel	2007
		li_colcount = lnv_string.of_parsetoarray( adw_export.Describe("DataWindow.Objects"), "~t", ls_controls )
		FOR li_ctr = 1 TO li_colcount
			ls_column = ls_controls[li_ctr]
			
			//	Bypass the background control as it's not properly sized.
			IF ls_column = "t_background" THEN Continue
				
			// Compute the right most pointer of a visible control that is not in the detail band
			IF Lower( adw_export.Describe(ls_column + ".band") ) <> "detail" AND adw_export.Describe(ls_column + ".visible") = "1" THEN
				li_width = Long(adw_export.Describe(ls_column + ".width"))
				li_x = Long(adw_export.Describe(ls_column + ".x"))
					
				//	Set the largest pointer
				IF li_ptr < li_width + li_x THEN li_ptr = li_width + li_x
							
			// Compute the right most pointer of a visible control that is in the detail band
			ELSEIF Lower( adw_export.Describe(ls_column + ".band") ) = "detail" AND adw_export.Describe(ls_column + ".visible") = "1" THEN
				li_width = Long(adw_export.Describe(ls_column + ".width"))
				li_x = Long(adw_export.Describe(ls_column + ".x"))
					
				//	Set the largest pointer
				IF li_ptr_detail < li_width + li_x THEN
					li_ptr_detail = li_width + li_x
					ls_test = ls_column	// Store the widest column name
				END IF
						
			END IF
		NEXT
		
		//	Disable the background control if exists
		adw_export.SetRedraw( FALSE )
		ls_mod = "t_background.visible=0"
		adw_export.Modify(ls_mod)
			
		//	If column pointer extends beyond header pointer then exit
		IF li_ptr_detail < li_ptr THEN
			//	Store the width and col num
			ls_width =  adw_export.Describe( ls_test + ".width" )
			ls_format = ls_width + "|" + ls_test
				
			//	Resize column just beyond the right most pointer of controls outside 
			//	the detail band to include those controls in WYSIWYG export
			ls_mod = ls_test + ".width='" + String(  Long( ls_width ) + li_ptr - li_ptr_detail ) + "'"
			ls_test = adw_export.Modify(ls_mod)
		END IF
		
		IF as_version = "XLSW!" THEN
			li_rtn = uf_save_dw_as_excel( adw_export, as_path )
		ELSE
			lnv_xl_parms = Create n_dwr_service_parm
			lnv_xl_parms.is_version = "OOXML"
			li_rtn = uf_save_dw_as_excel_parm( adw_export, as_path, lnv_xl_parms )
			
			IF IsValid( lnv_xl_parms ) THEN Destroy lnv_xl_parms
		END IF

		li_pos = Pos( ls_format, "|" )
		IF li_pos <> 0 THEN
			//	Resize column back to original state
			ls_mod = Mid( ls_format, li_pos + 1 ) + ".width='" + Left( ls_format, li_pos - 1) + "'"
			ls_test = adw_export.Modify(ls_mod)
		END IF
		
		//	Enable the background control if exists
		ls_mod = "t_background.visible=1"
		ls_test = adw_export.Modify(ls_mod)
		adw_export.SetRedraw( TRUE )
	
	CASE "XLS!", "XLSX!"		// Formatted Legacy and Excel 2007
		IF as_version = "XLS!" THEN
			li_rtn = adw_export.SaveAs( as_path, Excel5!, TRUE )
			li_format = -4143
		ELSE
			li_rtn = adw_export.SaveAs( as_path + ls_tmp, dBASE3!	, TRUE )
			li_format = 51
		END IF
		
		//	Exit if failed
		IF li_rtn <> 1 THEN GOTO EXIT_SCRIPT

		excel = CREATE OLEObject
		IF excel.ConnectToNewObject( "excel.application" ) = 0 THEN
			
			//	OLE connection established. 
			//	Execute macro functionality.
			TRY
				excel.application.DisplayAlerts = FALSE
				IF as_version = "XLS!" THEN
					excel.application.workbooks.Open( as_path )
				ELSE
					//	If there are more rows, including the header row,
					//	than is allowed by legacy Excel.
					//	Check the version of Excel on the client machine.
					//	If older than Excel 2007, then warn user that not all rows will export
					ll_cnt = adw_export.RowCount() + 1
					IF ll_cnt > il_xlrowlimit THEN
						li_version = Integer( excel.version )
						IF li_version < 12 THEN
							IF MessageBox( "WARNING", "You are attempting to export more rows (" + &
									String( ll_cnt, "#,###,###" ) + ") than your version of Excel (" + &
									String( li_version ) + ") can handle.~n~rIf you proceed with " + &
									"this export, only " + String( il_xlrowlimit, "##,###" ) + &
									" rows will be transferred.", Exclamation!, OKCancel! ) = 2 THEN
									excel.DisconnectObject()
									Destroy excel
									FileDelete( as_path + ls_tmp )
									gnv_app.of_set_idle( TRUE )
									Return -2
								END IF
						END IF
					END IF
					excel.application.workbooks.Open(as_path + ls_tmp)
				END IF
				li_workbook = excel.application.workbooks.Count
				excel.application.workbooks(li_workbook).Parent.Windows(excel.application.workbooks(li_workbook).Name).Visible = True
				wrksheet = excel.application.workbooks(li_workbook).worksheets[1]
				
				li_colcount = Long( adw_export.Object.DataWindow.Column.Count )
				li_writecols = li_colcount 
			
				FOR li_ctr = li_colcount TO 1 STEP -1
					ls_test = "#" + String(li_ctr) + ".Name"
					ls_column = adw_export.Describe( ls_test )
					ls_format = adw_export.Describe( "#" + String(li_ctr) + ".Format" )
					ls_type = adw_export.Describe( "#" + String(li_ctr) + ".Coltype" )
					
					IF adw_export.Describe( "#" + String(li_ctr) + ".visible" ) = "0" THEN
						lb_visible = FALSE
					ELSE
						lb_visible = TRUE
					END IF
					
					//	Carry the PB format to excel
					IF Lower( ls_format ) = "[general]" THEN
						IF gnv_sql.of_is_date_data_type( ls_type ) THEN
							ls_format = "mm/dd/yyyy"
						ELSE
							ls_format = "General"
						END IF
					ELSEIF Lower( ls_format ) = "[shortdate] [time]" THEN
						ls_format = "mm/dd/yyyy hh:mm:ss"
					ELSEIF Pos( Lower( ls_format ), ":fff" ) > 0 THEN
						ls_format = Replace( ls_format, Pos( Lower( ls_format ), ":fff" ), 4, ".000" )
					END IF
					ls_test = adw_export.Describe( ls_column + "_t.Text" )
					
					//	If column is a dupe, the header is t_#_t
					IF ls_test = "!" THEN
						ls_dup_num = Right( ls_column, 1 )
						IF IsNumber( ls_dup_num ) THEN
							ls_test = adw_export.Describe( Left( ls_column, Len( ls_column ) - 1 ) + "t_" + ls_dup_num + "_t.text" )
						END IF
					END IF
					
					IF IsNull( ls_test ) OR Trim( ls_test ) = "" OR Trim( ls_test ) = "!" OR NOT lb_visible THEN
						wrksheet.Columns( lnv_export.of_GetExcelRange( li_ctr, li_ctr ) ).EntireColumn.Delete
						li_writecols = li_writecols - 1
					ELSE
						ls_test = lnv_string.of_GlobalReplace( ls_test, "~n~r", " " )
						ls_test = lnv_string.of_GlobalReplace( ls_test, "~r~n", " " )
						ls_test = lnv_string.of_GlobalReplace( ls_test, "~r", " " )
						ls_test = lnv_string.of_GlobalReplace( ls_test, "~n", " " )
						ls_test = lnv_string.of_GlobalReplace( ls_test, '"', "" )
						wrksheet.cells[1, li_ctr]=ls_test
						wrksheet.Columns( lnv_export.of_GetExcelRange( li_ctr, li_ctr ) ).Select
						wrksheet.application.Selection.NumberFormat = ls_format
					END IF

				NEXT
				
				wrksheet.application.Range( lnv_export.of_GetExcelRange( 1, 1, li_writecols, 1 ) ).Select()								
				wrksheet.application.Selection.Font.Bold = True
				wrksheet.Columns( lnv_export.of_GetExcelRange( 1, li_writecols ) ).EntireColumn.AutoFit
				wrksheet.application.Range( "A1" ).Select()
				
				excel.application.workbooks(li_workbook).saveas(as_path, li_format)
				excel.application.workbooks(li_workbook).close()
				excel.DisconnectObject()

			CATCH (RunTimeError lerr_rte)
				MessageBox("ERROR", "An OLE excption has occurred. Error saving report.~r~r" + &
								lerr_rte.getmessage(), &
								Exclamation!, OK!)
				li_rtn = -1
			END TRY

		else
			MessageBox("Warning", "Unable to connect to Excel to format labels" + &
										 "~n~rThe exported report will not have formatted headers", Exclamation!)
		end if

		DESTROY excel
		
		//	Delete temp file
		FileDelete( as_path + ls_tmp )
		
	CASE ELSE
		li_rtn = -1
		
END CHOOSE

EXIT_SCRIPT:
gnv_app.of_set_idle( TRUE )
Return li_rtn
end event

event type integer ue_pdf(string as_filename, u_dw adw_requestor, string as_title);////////////////////////////////////////////////////////////////////////////////
//	Script:		ue_pdf
//
//	Arguments:	String	as_filename 	- The complete path and name of file to convert
//					u_dw		adw_requestor 	- The datawindow to export
//					String	as_title			- The title of the datawindow
//
//	Returns:		Integer
//					-1	=	Error
//					 1	=	Success
//
//	Description:
//					Converts a datawindow to PDF format using Amyuni PDF Converter.
//					PDF Converter interface CDINTF300.DLL must be registered as an ActiveX
//					The following documents describe the interface and its methods.
//					"Amyuni PDF Converter.pdf", "Common Driver Interface.pdf"
//
//	Notes:	1. All GUI edits must occur before calling this.
//				2.	idw_case must be registered (uf_set_case_dw).
//
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	08/09/02	GaryR	Track 3249d	Provide export to PDF format
// 01/28/05 MikeF SPR4263d Removed quotes from title before OLE call
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes
//	12/02/08	GaryR	SPR 5592	Upgrade PDF Printer for Vista
//
////////////////////////////////////////////////////////////////////////////////


String 		ls_printer
OleObject	lole_pdf
n_cst_string	lnv_string

SetPointer( HourGlass! )

//	Initialize and connect to 
//	the PDF ActiveX interface
IF This.event ue_init_pdf( lole_pdf ) < 0 THEN Return -1

//	Pass the filename selected in the calling method
lole_pdf.DefaultFileName = as_filename

// Set file options for the current print job
lole_pdf.FileNameOptions = NoPrompt + UseFileName

// Print or "Export" the Datawindow
as_title = lnv_string.of_removequotes(as_title)
adw_requestor.object.datawindow.print.documentname = "Exporting " + Trim( as_title )
ls_printer = adw_requestor.object.datawindow.printer
adw_requestor.object.datawindow.printer = PrinterName

This.of_activatePrinter( lole_pdf )
adw_requestor.print( FALSE )

//	Reset the printer
adw_requestor.object.datawindow.printer = ls_printer

// Reset file options
lole_pdf.FileNameOptions = 0
Destroy lole_pdf

Return	1
end event

event type integer ue_access(u_dw adw_source);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Event:			ue_access
//	Arguments:		u_dw		adw_source 	- The datawindow to export
//						String	as_path		- Path of target Access Database
//	Returns:			Integer (-1	= Error, 0 = Success, -2 = Cancelled at Options Window)
//---------------------------------------------------------------------------------------//
//	Copies rows from the current datawindow into Access. User must select a valid Access 
// database and choose a target table name.
//---------------------------------------------------------------------------------------//
//	Steps:	1. Create ODBC connection to Access									
//				2. Get target table name from user
//				3. Create datastore version of dw and change trans object to Access
//				4. Generate and execute CREATE TABLE SQL for Access
//				5. Save datastore as SQLInsert
//				6. Loop through SQL file to generate INSERT statements and execute
//
//	Notes:	Will eliminate invisible columns from CREATE and INSERT statements
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
// 12/29/04 MikeF SPR4172d Added logic to account for a column value split onto two lines.
// 01/06/05 MikeF SPR4219d Still getting complete message when cancelled
// 04/19/05 MikeF SPR4206d Cancel export to Access / Progress Bar
//---------------------------------------------------------------------------------------//
int		li_rc, li_filenum, li_len, li_field, li_pos
long		ll_line, ll_rows
string	ls_sql_file, ls_sql, ls_line
string	ls_syntax
n_ds		lds_target			

w_master_status	lw_status
//---------------------------------------------------------------------------------------//
// Connect to Access
li_rc = This.of_set_access_tran()
IF li_rc < 0 THEN RETURN li_rc					// Connect failed or was cancelled

// Get Target Table Name 
this.of_set_access_options("EXPORT")

IF isx_access_options.cancelled THEN // Cancelled from w_pipe_options
	DESTROY itr_access
	RETURN -2	
END IF

// Create datastore version of datawindow
lds_target = CREATE n_ds
ls_syntax = adw_source.Object.DataWindow.Syntax 
lds_target.create( ls_syntax )
lds_target.settrans( itr_access )
adw_source.ShareData( lds_target )

// Create SQL insert file
Setmicrohelp(w_main,'Preparing data for export - Please wait...')

li_pos = pos(is_path,is_file_name)
ls_sql_file = left(is_path,li_pos - 1) + isx_access_options.table_name + ".sql"
li_rc = lds_target.SaveAs( ls_sql_file, SQLInsert!, TRUE)

IF li_rc < 0 THEN
	MessageBox("Export Error","Unable to create SQL file for Access export.")
	RETURN li_rc
END IF

// Create target table in Access
li_rc = this.of_create_table( adw_source )
IF li_rc < 0 THEN
	RETURN li_rc
END IF

// Add additional User Objects
IF li_rc = 0 THEN
	// Save SQL
	IF isx_access_options.save_sql THEN
		this.of_save_export_sql( lds_target.getsqlselect() )
	END IF
	
	// Create View with labels
	IF isx_access_options.create_query THEN
		this.of_create_view( adw_source, isx_access_options.table_name)
	END IF
END IF

// Read file and loop through INSERT statements
li_filenum 	= FileOpen(ls_sql_file)
ll_rows 		= adw_source.RowCount()

Setmicrohelp(w_main,'Copying data...')

OPEN(lw_status)
lw_status.ib_prompt = TRUE
lw_status.st_description.text = "Copying Data. Please wait..."
lw_status.uf_initialize( ll_rows, "row" )

DO
	
	// Check to see if decode was cancelled or window was closed
	IF IsValid(lw_status) THEN
	 	IF lw_status.ib_cancelled THEN
			ib_cancelled = TRUE
			EXIT
		END IF
	ELSE
		EXIT
	END IF
	
	// Check for complete line(data may have contained carriagre return)
	IF right(ls_line,1) = "," &
	OR right(ls_line,1) = ";" THEN
		li_field++	
	END IF	
	
	// Only append to the SQL if the column is visible
	IF  ll_line  > 0 &
	AND li_field > 0 THEN
		// Individual values
		IF ib_visible[li_field] THEN
			ls_sql += ls_line
		END IF
	ELSE
		// "INSERT INTO" Line
		ls_sql += ls_line
	END IF
	
	// Check for end of SQL character. 
	IF right(trim(ls_line),1) = ";" THEN
		ll_line++	

		ls_sql = trim(ls_sql)
		
		// Last column may have been invisible. May need to manipulate SQL string
		IF right(ls_sql,1) = "," THEN
			li_len = len(ls_sql)
			ls_sql = left(ls_sql, li_len - 1) + " );"			
		END IF

		// Execute SQL - Bypass Create table statement (li_line=1)
		IF ll_line > 1 THEN
			lw_status.uf_step(ll_line - 1)
			li_rc = itr_access.of_execute( ls_sql )
		END IF

		IF li_rc < 0 THEN
			MessageBox("Export Error","Insert failed~r~r." + ls_sql)
			SetMicroHelp(w_main,"Export Failed")
			EXIT
		ELSE
			IF MOD(ll_line, 1000) = 0 THEN
				itr_access.of_commit( )
			END IF
		END IF
				
		ls_sql = ''
		li_field = 0
	END IF
	
LOOP WHILE FileRead(li_filenum, ls_line) > 0

// Close status window
IF IsValid(lw_status) THEN
	lw_status.ib_prompt = false
	CLOSE(lw_status)
END IF

// Close and delete .sql file
FileClose(li_filenum)
FileDelete(ls_sql_file)

// Commit and destroy transaction
itr_access.of_commit( )
itr_access.of_disconnect( )
DESTROY itr_access
DESTROY lds_target

RETURN li_rc
end event

event type integer ue_append_doc(string as_source, string as_target);//===================================================================================//
// Object:		n_cst_export
//	Script:		ue_append_doc
//
//	Arguments:	String	as_source 		File to be read
//					String	as_target 		File to be written to
//
//	Returns:		Integer						-1	= Error, 0	= Success
//===================================================================================//
// Appends the contents of one PDF document to another
//===================================================================================//
//	Maintenance
// -------- ----- ----------- -------------------------------------------------------
//	11/05/04	MikeF	SPR 5817c	Created
//	12/02/08	GaryR	SPR 5592		Upgrade PDF Printer for Vista
//
//===================================================================================//
oleobject 	lole_source, lole_target
int			li_rc

lole_source = create oleobject
lole_target = create oleobject

// Connect ole objects to the Document interface of CDIntf.dll
li_rc = lole_source.ConnectToNewObject("CDIntfEx.document")
li_rc = lole_target.ConnectToNewObject("CDIntfEx.document")

IF li_rc < 0 THEN
	//	Attempt to register the ActiveX
	li_rc		=	DllRegisterServer()
	
	IF	li_rc	<>	0		THEN
		MessageBox ( "Export Error", "Failed to register CDIntf300.dll required for appending documents." + &
													 "~n~rPlease contact your System Administrator for assistance.", StopSign! )
		Return -1
	END IF
	
	//	If registration was successful, then reconnect
	li_rc = lole_source.ConnectToNewObject("CDIntfEx.document")
	li_rc = lole_target.ConnectToNewObject("CDIntfEx.document")
	
	IF li_rc < 0 THEN
		MessageBox ( "Export Error", "Failed to connect to CDIntf interface required for appending documents." + &
													 "~n~rPlease contact your System Administrator for assistance.", StopSign! )
		Return -1
	END IF	
END IF

TRY
	// Open the documents that will be concatenated
	lole_source.Open (as_source)
	lole_target.Open (as_target)
		 
	// Concatenate the two documents.
	lole_target.AppendEx (lole_source)
		 
	// Save the resulted pdf file
	lole_target.Save (as_target)
	
CATCH (RunTimeError lerr_pdf)
	MessageBox ("Export Error","Error appending document " + as_source + " to " + as_target + ".~n~r" + &
								lerr_pdf.text + "~n~rPlease contact your System Administrator for assistance.", StopSign! )
	Return -1
END TRY
    
// Destroy the used objects.
Destroy lole_source 
Destroy lole_target

RETURN 0
end event

event type integer ue_init_pdf(ref oleobject aole_pdf);////////////////////////////////////////////////////////////////////////////////
//	Script:		ue_init_pdf
//
//	Arguments:	OLEControl	(ByRef)	as_filename	- Created PDF OLEobject
//
//	Returns:		Integer
//					-1	=	Error
//					 1	=	Success
//
//	Description:
//					Connects to the Amyuni PDF Converter.
//					PDF Converter interface CDINTF300.DLL must be registered as an ActiveX.
//					The following documents describe the interface and its methods.
//					"Amyuni PDF Converter.pdf", "Common Driver Interface.pdf"
//
//	Notes:	This method will attempt to register the ActiveX if connection fails.
//
//
////////////////////////////////////////////////////////////////////////////////
//	History:
//
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes
//	12/02/08	GaryR	SPR 5592	Upgrade PDF Printer for Vista
//
////////////////////////////////////////////////////////////////////////////////

Long			ll_rc

SetPointer( HourGlass! )

//	Initialize and connect to 
//	the PDF ActiveX interface
aole_pdf = Create OleObject
ll_rc	=	aole_pdf.ConnectToNewObject( "CDIntfEx.CDIntfEx" )

IF ll_rc < 0 THEN
	//	Attempt to register the ActiveX
	ll_rc		=	DllRegisterServer()
	
	IF	ll_rc	<>	0		THEN
		MessageBox ( "Export Error", "Failed to register CDIntf300.dll required for PDF exports." + &
													 "~n~rPlease contact your System Administrator for assistance.", StopSign! )
		Return -1
	END IF
	
	//	If registration was successful, then reconnect
	ll_rc	=	aole_pdf.ConnectToNewObject( "CDIntfEx.CDIntfEx" )
	
	IF ll_rc < 0 THEN
		MessageBox ( "Export Error", "Failed to connect to CDIntf interface required for PDF exports." + &
													 "~n~rPlease contact your System Administrator for assistance.", StopSign! )
		Return -1
	END IF	
END IF

TRY
	//	Attach to the PDF Converter
	aole_pdf.DriverInit( PrinterName )
CATCH (RunTimeError lerr_pdf)
	//	Utilize the catch statement to prevent
	//	the SystemError from firing if the Printer 
	//	was renamed or deleted from the printer properties
	MessageBox ( "Export Error", "Failed to connect to <" + PrinterName + "> required for PDF exports.~n~r" + lerr_pdf.text + &
											 "~n~rPlease contact your System Administrator for assistance.", StopSign! )
	Return -1
END TRY

Return 1
end event

public function string of_getexcelrange (integer ai_col1, integer ai_row1, integer ai_col2, integer ai_row2);Return of_IntToColumn( ai_col1 ) + String( ai_row1 ) + ":" + of_IntToColumn( ai_col2 ) + String( ai_row2 )
end function

public function string of_getexcelrange (integer ai_col1, integer ai_col2);Return of_IntToColumn( ai_col1 ) + ":" + of_IntToColumn( ai_col2 )
end function

public function string of_inttocolumn (integer ai_col);// Convert a column number into a spreadsheet column reference

// ----- -------- ----------- -----------------------------------------------------------------------------------------//
// MikeF	10/17/02	Track 3350d	Rewrote logic to set the columns from the int. Was bombing on 26.
//	GaryR	08/15/03	Track 2451d	Fix bug that caused GPF on 52nd column
//
//---------------------------------------------------------------------------------------------------------------------//

String 	ls_col
int		li_col1, li_col2

IF ai_col <= 0 THEN RETURN ""

//MikeF 10/17/02 - Track 3350 Begin
IF ai_col > 26 THEN
	li_col1 = Int( ai_col / 26.1 )
	li_col2 = ai_col - (li_col1 * 26)
	ls_col = char(li_col1 + 64) + char(li_col2 + 64)
ELSE
	ls_col = char(ai_col + 64)
END IF
//MikeF 10/17/02 - Track 3350 End

RETURN ls_col
end function

public function string uf_get_view_sql (readonly u_dw adw, string as_table_name);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_create_view
//	Arguments:		u_dw		adw				Source datawindow
//						String	as_table_name	Target table name
//	Returns:			String						CREATE TABLE statement
//---------------------------------------------------------------------------------------//
// Generates Access specific CREATE VIEW SQL from Datawindow
//---------------------------------------------------------------------------------------//
//	Steps:	1. Loops through datawindow columns 							
//				2. Sets the view column to the label
//
// Notes:	* Bypasses invisible columns 
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
// 12/22/04 MikeF	SPR4181d Moved SQL creation to a seperate function for pipeline
// 01/07/05 MikeF SPR4220d Some labels were wrong case.
//---------------------------------------------------------------------------------------//
string			ls_sql, ls_col_name, ls_label
string			ls_error
int				li_cols, loop_ix
int				li_pos, li_len
n_cst_string	ln_string
//---------------------------------------------------------------------------------------//
ls_sql = "CREATE VIEW " + as_table_name + "_LABELS AS SELECT "

li_cols = integer( adw.Describe( 'datawindow.column.count' ) )

FOR loop_ix = 1 TO li_cols

	// Generic column info
	ls_col_name = adw.Describe('#' + String( loop_ix ) + '.Name' )
	
	// IF column is invisible, bypass it
	IF integer(adw.Describe('#' + String( loop_ix ) + '.Visible')) = 1 THEN
		ib_visible[loop_ix] = TRUE
	ELSE
		ib_visible[loop_ix] = FALSE
		CONTINUE
	END IF 

	// Get Column Label
	ls_label = trim(adw.Describe(ls_col_name + "_t.Text"))
	 
 	IF ls_label = '!' THEN
		ls_sql += ls_col_name + ' AS "' + ls_col_name + '",'
	ELSE
	 	ls_label = ln_string.of_removequotes(ls_label)
		ls_label = ln_string.of_globalreplace( ls_label, ".", "")
		ls_label = ln_string.of_clean_string(ls_label)
		IF UPPER(ls_col_name) = UPPER(ls_label) THEN
			ls_sql += ls_label + ","
		ELSE
			ls_sql += ls_col_name + ' AS "' + ls_label + '",'
		END IF
	END IF

NEXT

IF RIGHT(trim(ls_sql),1) = "," THEN
	li_len = len(ls_sql)
	ls_sql = left(ls_sql, li_len - 1)	
END IF

ls_sql += " FROM " + as_table_name

RETURN ls_sql
end function

public function boolean of_get_table_exists (ref n_tr atr, string as_object_name);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_get_access_tran
//	Arguments:		(Reference) n_tr	atr 	Access transaction object
//	Returns:			BOOLEAN 						TRUE if table exists, else false
//---------------------------------------------------------------------------------------//
// Determines whether or not a table exists in Access
// -------- ----- -------- --------------------------------------------------------------
//	01/18/05 MikeF	SPR4239d	Created
//---------------------------------------------------------------------------------------//
int 		li_rc
string	ls_sql

ls_sql = "SELECT COUNT(*) FROM " + as_object_name

EXECUTE IMMEDIATE :ls_sql USING atr;

RETURN atr.sqlcode >= 0
end function

public function integer of_set_access_tran ();//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_get_access_tran
//	Arguments:		(Reference) n_tr	itr_access 	Access transaction object
//	Returns:			Integer 		-2  	Connection error
//										-1		File Not found
//										0 		User Cancelled
//										1 		Successful connection
//---------------------------------------------------------------------------------------//
// Creates ODBC connection to a specified Access database
//---------------------------------------------------------------------------------------//
//	Steps:	1. If file path is blank, prompt for mdb									
//				2. Connect and check return code
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
//	01/18/05 MikeF	SPR4239d	Set itr_access variable rather than returning n_tr
//---------------------------------------------------------------------------------------//
int 		li_rc, li_connect
string	ls_connect, ls_file
//---------------------------------------------------------------------------------------//
IF len(trim(is_path)) > 0 THEN 			// Was set in fx_m_export (Save As...)
	IF FileExists(trim(is_path)) THEN
		li_rc = 1
	ELSE
		li_rc = -1
	END IF
ELSE
	li_rc = GetFileOpenName("Select database", is_path, ls_file, "MDB", "Microsoft Access databases (*.mdb),*.mdb")
END IF

IF li_rc > 0 THEN
	
	itr_access = CREATE n_tr
	itr_access.dbms = "ODBC"
	itr_access.AutoCommit = False
	ls_connect = "ConnectString='DBQ=" + is_path + ";Driver={Microsoft Access Driver (*.mdb)}'"
	itr_access.DBParm = ls_connect

	CONNECT USING itr_access;
	
	li_connect = itr_access.of_check_status() 

END IF

// 0 = User cancelled, -1 = error
IF li_rc = -1 THEN 			// Error opening file
	MessageBox("Error","Unable to open file:~r~r" + is_path)
END IF

IF li_connect < 0 THEN
	MessageBox("Error","Unable to establish ODBC connection to Access database:~r~r" + is_path)
	RETURN -2
END IF

RETURN li_rc
end function

public function integer of_create_view (readonly u_dw adw, string as_table_name);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_create_view
//	Arguments:		u_dw		adw				Source datawindow
//						String	as_table_name	Target table name
//	Returns:			String						CREATE TABLE statement
//---------------------------------------------------------------------------------------//
// Generates Access Query (View)
//---------------------------------------------------------------------------------------//
//	Steps:	1. Gets SQL							
//				2. Executes it
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
// 12/22/04 MikeF	SPR4181d Moved SQL creation to a seperate function
//---------------------------------------------------------------------------------------//
string		ls_sql
int			li_rc

ls_sql = this.uf_get_view_sql(adw, as_table_name)

li_rc = itr_access.of_execute(ls_sql) 

IF li_rc < 0 THEN
	MessageBox("Export Error","Error creating Microsoft Access Query " + as_table_name + "_LABELS")
END IF

RETURN li_rc
end function

public function boolean of_get_access_tables_exist (ref string as_table_name);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_get_access_tran
//	Arguments:		(Reference) n_tr	itr_access 	Access transaction object
//	Returns:			BOOLEAN 						TRUE if table exists, else false
//---------------------------------------------------------------------------------------//
// Determines whether or not a table exists in Access
// -------- ----- -------- --------------------------------------------------------------
//	01/18/05 MikeF	SPR4239d	Created
//---------------------------------------------------------------------------------------//
int 		li_rc
string	ls_sql

// Check for base table
IF this.of_get_table_exists( itr_access, isx_access_options.table_name ) THEN
	as_table_name = isx_access_options.table_name
	RETURN TRUE
END IF

// Check <base>_SQL
IF isx_access_options.save_sql THEN
	as_table_name = isx_access_options.table_name + "_SQL"
	IF this.of_get_table_exists( itr_access, as_table_name ) THEN
		RETURN TRUE
	END IF
END IF

// Check <base>_LABELS
IF isx_access_options.create_query THEN
	as_table_name = isx_access_options.table_name + "_LABELS"
	IF this.of_get_table_exists( itr_access, as_table_name ) THEN
		RETURN TRUE
	END IF
END IF

// Check <base>_CRITERIA
IF isx_access_options.save_criteria THEN
	as_table_name = isx_access_options.table_name + "_CRITERIA"
	IF this.of_get_table_exists( itr_access, as_table_name ) THEN
		RETURN TRUE
	END IF
END IF

// Not found
as_table_name=""
RETURN FALSE
end function

public function integer of_save_export_sql (string as_sql);//=======================================================================================//
//	Object:			n_cst_export
//	Function:		of_save_export_sql
//	Arguments:		(Reference) n_tr	atr_access 		Access transaction object
//						String				as_table_name	Target Table name
//						String				as_sql			SQL Statement
//	Returns:			Integer (-1	= Error, 0 = Success)
//---------------------------------------------------------------------------------------//
// Creates and populates a table in Access to store SQL
//---------------------------------------------------------------------------------------//
//	Steps:	1. Creates <ExportTableName>_SQL table
//				2. Cuts the SQL into 255 byte chunks
//				3. Populates datastore
//				4. Updates (inserts) rows to Access
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
//=======================================================================================//
int		li_rc
int		li_pos, li_len, li_line
string	ls_sql, ls_line
n_ds		lds_export_sql
n_cst_string	lnv_string

// Create EXPORT_SQL table
ls_sql = "CREATE TABLE " + isx_access_options.table_name + "_SQL ( LineNum SMALLINT, SqlLine VARCHAR(255) );"
li_rc = itr_access.of_execute(ls_sql)

IF li_rc < 0 THEN
	MessageBox("Export Error","Unable to create SQL table " + isx_access_options.table_name + "_SQL")
	RETURN li_rc
END IF

// Create datastore for syntax 
lds_export_sql = CREATE n_ds
lds_export_sql.dataobject = 'd_export_sql'
lds_export_sql.settransobject( itr_access )
lds_export_sql.Object.DataWindow.Table.UpdateTable = isx_access_options.table_name + "_SQL"

// Remove carriage returns and line feeds
ls_sql = lnv_string.of_clean_string( as_sql )

// Chop SQL up into 255 byte pieces and populate datastore rows
li_len = len(ls_sql)

DO
	li_line++
	ls_line = mid(ls_sql,li_pos + 1, li_pos + 255)
	li_pos += 255

	lds_export_sql.InsertRow(0)
	lds_export_sql.Object.LineNum   [li_line] = li_line
	lds_export_sql.Object.SqlLine   [li_line] = ls_line
	
LOOP WHILE li_len > li_pos

// Update SQL table
li_rc = lds_export_sql.update()
itr_access.of_commit()

IF li_rc < 0 THEN
	MessageBox("Export Error","Unable to save SQL to " + isx_access_options.table_name + "_SQL")
END IF

DESTROY lds_export_sql
RETURN li_rc


end function

public function integer of_save_export_criteria (u_dw adw_criteria);//=======================================================================================//
//	Object:			n_cst_export
//	Function:		of_save_export_sql
//	Arguments:		(Reference) n_tr	atr_access 		Access transaction object
//						String				isx_access_options.table_name	Target Table name
//						String				as_sql			SQL Statement
//	Returns:			Integer (-1	= Error, 0 = Success)
//---------------------------------------------------------------------------------------//
// Creates and populates a table in Access to store SQL
//---------------------------------------------------------------------------------------//
//	Steps:	1. Creates <ExportTableName>_SQL table
//				2. Cuts the SQL into 255 byte chunks
//				3. Populates datastore
//				4. Updates (inserts) rows to Access
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
//=======================================================================================//
int		loop_ix, li_lines, li_rc
string	ls_sql, ls_line
n_ds		lds_export_criteria

// Create EXPORT_SQL table
ls_sql = "CREATE TABLE " + isx_access_options.table_name + "_CRITERIA " + &
			"( LineNum SMALLINT, LeftParen CHAR(2), ColumnName VARCHAR(35)," + &
			 " Operator CHAR(10), QueryValue MEMO, RightParen CHAR(2), AndOr CHAR(3) );" 
li_rc = itr_access.of_execute(ls_sql)

IF li_rc < 0 THEN
	MessageBox("Export Error","Unable to create CRITERIA table " + isx_access_options.table_name + "_CRITERIA")
	RETURN li_rc
END IF

// Create datastore for syntax 
lds_export_criteria = CREATE n_ds
lds_export_criteria.dataobject = 'd_export_criteria'
lds_export_criteria.settransobject( itr_access )
lds_export_criteria.Object.DataWindow.Table.UpdateTable = isx_access_options.table_name + "_CRITERIA"

// Loop through criteria and insert into datastore
li_lines = adw_criteria.RowCount()

FOR loop_ix = 1 TO li_lines

	lds_export_criteria.InsertRow(0)
	lds_export_criteria.Object.LineNum    [loop_ix] = loop_ix
	lds_export_criteria.Object.LeftParen  [loop_ix] = adw_criteria.GetItemString(loop_ix,"left_paren")
	lds_export_criteria.Object.ColumnName [loop_ix] = adw_criteria.GetItemString(loop_ix,"expression_one")
	lds_export_criteria.Object.Operator   [loop_ix] = adw_criteria.GetItemString(loop_ix,"relational_op")
	lds_export_criteria.Object.QueryValue [loop_ix] = adw_criteria.GetItemString(loop_ix,"expression_two")
	lds_export_criteria.Object.RightParen [loop_ix] = adw_criteria.GetItemString(loop_ix,"right_paren")
	lds_export_criteria.Object.AndOr      [loop_ix] = adw_criteria.GetItemString(loop_ix,"logical_op")
	
NEXT

li_rc = lds_export_criteria.update()
itr_access.of_commit()

IF li_rc < 0 THEN
	MessageBox("Export Error","Unable to save rows to " + isx_access_options.table_name + "_CRITERIA")
END IF

RETURN li_rc
end function

public function integer of_create_table (readonly u_dw adw);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_get_create_sql
//	Arguments:		u_dw		adw				Source datawindow
//						String	isx_access_options.table_name	Target table name
//	Returns:			String						CREATE TABLE statement
//---------------------------------------------------------------------------------------//
// Creates table in Access based on a datawindow
//---------------------------------------------------------------------------------------//
//	Steps:	1. Loops through datawindow columns 							
//				2. Determines appropriate target data type based on dw type
//
// Notes:	* Bypasses invisible columns 
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
//
//---------------------------------------------------------------------------------------//
string			ls_sql, ls_col_name, ls_dw_def, ls_col_def, ls_label, ls_format
string			ls_error
int				li_cols, loop_ix
int				li_pos, li_len
int				li_rc
n_cst_string	ln_string
//---------------------------------------------------------------------------------------//
ls_sql = "CREATE TABLE " + isx_access_options.table_name + " ( "

li_cols = integer( adw.Describe( 'datawindow.column.count' ) )

FOR loop_ix = 1 TO li_cols

	// Generic column info
	ls_col_name = adw.Describe('#' + String( loop_ix ) + '.Name' )
	ls_dw_def   = adw.Describe('#' + String( loop_ix ) + '.ColType' )
	ls_format  	= adw.Describe('#' + String( loop_ix ) + '.Format' )
	
	// IF column is invisible, bypass it
	IF integer(adw.Describe('#' + String( loop_ix ) + '.Visible')) = 1 THEN
		ib_visible[loop_ix] = TRUE
	ELSE
		ib_visible[loop_ix] = FALSE
		CONTINUE
	END IF 

	// Set Access DataType
	IF pos(ls_dw_def,'decimal') > 0 THEN
		IF pos(ls_format,"$") > 0 THEN
			ls_col_def	= "CURRENCY"
		ELSE
			ls_col_def 	= "double"
		END IF
	ELSE
		ls_col_def = ls_dw_def
	END IF
		
	ls_sql += ls_col_name + " " + ls_col_def + ","
	
NEXT

IF RIGHT(trim(ls_sql),1) = "," THEN
	li_len = len(ls_sql)
	ls_sql = left(ls_sql, li_len - 1)	
END IF

ls_sql += " )"

// Execute SQL and check return 
li_rc = itr_access.of_execute(ls_sql) 

IF li_rc < 0 THEN
	MessageBox("Export Error","Error creating Access table " + isx_access_options.table_name + "~r~r" + ls_sql)
END IF

RETURN li_rc
end function

public subroutine of_set_access_options (string ab_parm);//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_get_access_tran
//	Arguments:		(Reference) n_tr	atr_access 	Access transaction object
//	Returns:			Integer 		-2  	Connection error
//										-1		File Not found
//										0 		User Cancelled
//										1 		Successful connection
//---------------------------------------------------------------------------------------//
// Creates ODBC connection to a specified Access database
//---------------------------------------------------------------------------------------//
//	Steps:	1. If file path is blank, prompt for mdb									
//				2. Connect and check return code
//
// -------- ----- -------- --------------------------------------------------------------
//	08/12/04 MikeF	SPR3852d	Created
//
//---------------------------------------------------------------------------------------//
boolean 	lb_exists
string	ls_table

lb_exists = TRUE
DO WHILE lb_exists
	// Get Access options -------------------------------------------------------------- //
	OpenWithParm(w_access_options, ab_parm)
	isx_access_options = Message.Powerobjectparm
	setNull(Message.Powerobjectparm)

	IF isx_access_options.cancelled THEN 			// Cancelled from w_pipe_options
		DESTROY itr_access
		RETURN 	
	END IF
	
	lb_exists = this.of_get_access_tables_exist(ls_table)

	IF lb_exists THEN
		MessageBox("Table Exists","Table " + ls_table + " already exists.~r~r" + &
						"Please choose a unique table_name.", Exclamation!,OK!)
	END IF
LOOP
end subroutine

public function integer of_setpdfprinter ();//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_SetPDFPrinter
//	Arguments:		None
//	Returns:			Integer		(1) Success (-1) Failure 
//---------------------------------------------------------------------------------------//
// Description:
//	Sets the STARS PDF Converter as the default printer.
//	Call of_ResetDefaultPrinter to revert back to the previuosly defaulted printer
//
//---------------------------------------------------------------------------------------//
//	Modifications:
// -------- ----- -------- --------------------------------------------------------------
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes
//
//---------------------------------------------------------------------------------------//

String	ls_printers, ls_pdf_prn, ls_prn_list[]
Integer	li_pos, li_cnt
n_cst_string	lnv_string

//	Store the current printer
is_dflt_prn = PrintGetPrinter()
ls_printers = PrintGetPrinters()
li_cnt = lnv_string.of_parsetoarray( ls_printers, "~n", ls_prn_list )

//	Find the PDF converter
FOR li_pos = 1 TO li_cnt
	IF Match( ls_prn_list[li_pos], PrinterName ) THEN
		ls_pdf_prn = Trim( ls_prn_list[li_pos] )
		Exit
	END IF
NEXT

IF IsNull( ls_pdf_prn ) OR ls_pdf_prn = "" THEN
	MessageBox( "Export Error", "Unable to find the STARS PDF Converter.~n~r" + &
					"Please contact your System Administrator.", StopSign! )
	Return -1
ELSE
	//	Remove the trailing tab char
	li_pos = LastPos( ls_pdf_prn, ":" )
	IF li_pos > 0 THEN ls_pdf_prn = Left( ls_pdf_prn, li_pos )
END IF

//	Set the PDF converter
//	as the current printer
IF PrintSetPrinter( ls_pdf_prn ) < 0 THEN
	MessageBox( "Export Error", "Unable to set the (" + ls_pdf_prn + &
					") as the default printer.~n~r" + &
					"Please contact your System Administrator.", StopSign! )
	Return -1
END IF

Return 1
end function

public function integer of_resetdefaultprinter ();//---------------------------------------------------------------------------------------//
//	Object:			n_cst_export
//	Function:		of_ResetDefaultPrinter
//	Arguments:		None
//	Returns:			Integer		(1) Success (-1) Failure 
//---------------------------------------------------------------------------------------//
// Description:
//	Reets the default printer prior to calling the of_SetPDFPrinter method
//
//---------------------------------------------------------------------------------------//
//	Modifications:
// -------- ----- -------- --------------------------------------------------------------
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes
//
//---------------------------------------------------------------------------------------//

//	Reset the default printer
IF PrintSetPrinter( is_dflt_prn ) < 0 THEN
	MessageBox( "Export Error", "Unable to reset the (" + is_dflt_prn + &
					") as the default printer.~n~r" + &
					"Please contact your System Administrator.", StopSign! )
	Return -1
END IF

Return 1
end function

public subroutine of_activateprinter (oleobject aole_pdf);//	12/02/08	GaryR	SPR 5592	Upgrade PDF Printer for Vista

//	With Amyuni 3.02 we are required to pass 
//	the licening info before every print call
aole_pdf.EnablePrinter( "VIPS", &
	"07EFCDAB01000100B0A0F37DB41B119BB32306F1BD8811B4C1B19B34BE7E7FA7958E0DEE6D94C3F810D4F35BCFA742EFE575089EA5A43BE0889080986E524D" )
end subroutine

on n_cst_export.create
call super::create
end on

on n_cst_export.destroy
call super::destroy
end on

