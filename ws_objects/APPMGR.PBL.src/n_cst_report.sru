$PBExportHeader$n_cst_report.sru
$PBExportComments$<logic>
forward
global type n_cst_report from n_base
end type
end forward

global type n_cst_report from n_base autoinstantiate
end type

type variables
//	07/02/07	GaryR	Track 5089	When modifing saved PDR, update date and create log
DateTime	idt_update
String	is_case_id
end variables

forward prototypes
public function integer of_delete (string as_rept_id, string as_link_type)
public function integer of_save (u_dw adw_save, string as_rept_id, datetime adt_created)
public function long of_get_limit ()
public function integer of_update_rpt_syntax (datawindow adw_save, string as_rept_id)
public function integer of_update_rpt_data (datawindow adw_save, string as_rept_id)
public function integer of_view (string as_case_id, string as_rept_id, string as_link_name, boolean ab_unsecure)
public function integer of_view_patt_rpt (string as_case_id, string as_rept_id, string as_link_name)
end prototypes

public function integer of_delete (string as_rept_id, string as_link_type);/////////////////////////////////////////////////////////////////////////////////////
//
//	This method will delete all rows in REPORT_CNTL 
//	and REPORT_SYNTAX for the specified report id
//	if there are no more links to the report
//
/////////////////////////////////////////////////////////////////////////////////////
//
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	07/02/07	GaryR	Track 5089	When modifing saved PDR, update date and create log
//
/////////////////////////////////////////////////////////////////////////////////////

Long		ll_count
String	ls_sql
u_nvo_count	lnv_count

IF IsNull( as_rept_id ) OR Trim( as_rept_id ) = "" THEN
	MessageBox( "Delete Report", "No report name specified to delete.", StopSign! )
	Return -1
END IF
IF Trim( as_link_type ) <> "" THEN
	lnv_count = Create u_nvo_count
	lnv_count.uf_set_transaction( Stars2ca )
	ls_sql = "select count(*) from case_link where link_key = '" + &
				as_rept_id + "' and link_type = '" + as_link_type + "'"
	ll_count = lnv_count.uf_get_count( ls_sql )
	Destroy lnv_count
	
	IF ll_count < 0 THEN
		MessageBox( "Delete Report", "Unable to read CASE_LINK table", StopSign! )
		Return -1
	END IF
END IF

// Do not delete if more than 
//	one link still exists
IF ll_count > 1 THEN Return 1

DELETE FROM REPORT_CNTL
WHERE REPT_ID = Upper( :as_rept_id )
USING Stars2CA;

IF Stars2ca.of_check_status() < 0 THEN Return -1
Stars2ca.of_commit()

DELETE FROM REPORT_SYNTAX
WHERE REPT_ID = Upper( :as_rept_id )
USING Stars2CA;

IF Stars2ca.of_check_status() < 0 THEN Return -1
Stars2ca.of_commit()

Return 1
end function

public function integer of_save (u_dw adw_save, string as_rept_id, datetime adt_created);/////////////////////////////////////////////////////////////////////////////////////
//
// This method will save the format and the 
//	contents of the argument Datawindow
//
/////////////////////////////////////////////////////////////////////////////////////
//
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//
/////////////////////////////////////////////////////////////////////////////////////

Int	li_ctr
Blob	lbl_value
Long	ll_rows
String	ls_err
n_ds	lds_break

IF NOT IsValid( adw_save ) THEN Return -1
IF IsNull( as_rept_id ) OR Trim( as_rept_id ) = "" THEN Return -1

INSERT INTO REPORT_SYNTAX 
VALUES ( :as_rept_id, 'S', 1, ' ' )
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Save Error", "Unable to insert syntax into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	Return -1
END IF

IF Stars2ca.of_commit() <> 0 THEN
	MessageBox( "Save Error", "Unable to commit syntax to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	Return -1
END IF

lbl_value = Blob( adw_save.Object.DataWindow.Syntax )

UPDATEBLOB REPORT_SYNTAX
SET REPT_SYNTAX = :lbl_value
WHERE REPT_ID = :as_rept_id
AND REPT_TYPE = 'S'
USING	Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Save Error", "Unable to update syntax into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	This.of_delete( as_rept_id, "" )
	Return -1
END IF

IF Stars2ca.of_commit() <> 0 THEN
	MessageBox( "Save Error", "Unable to commit syntax to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	This.of_delete( as_rept_id, "" )
	Return -1
END IF

// Break up rows by limit
ll_rows = This.of_get_limit()
IF adw_save.RowCount() > ll_rows THEN
	lds_break = Create n_ds
	IF lds_break.Create( String( lbl_value ), ls_err ) < 0 THEN
		MessageBox( "Save Error", "Unable to produce break datawindow: " + ls_err )
		Destroy lds_break
		This.of_delete( as_rept_id, "" )
		Return -1
	END IF
		
	adw_save.RowsCopy( 1, ll_rows, Primary!, lds_break, 1, Primary! )
	
	DO WHILE lds_break.RowCount() > 0
		li_ctr ++
		INSERT INTO REPORT_SYNTAX 
		VALUES ( :as_rept_id, 'D', :li_ctr, ' ' )
		USING Stars2ca;
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "Save Error", "Unable to insert data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
			Destroy lds_break
			Stars2ca.of_rollback()
			This.of_delete( as_rept_id, "" )
			Return -1
		END IF
		
		IF Stars2ca.of_commit() <> 0 THEN
			MessageBox( "Save Error", "Unable to commit data to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
			Destroy lds_break
			Stars2ca.of_rollback()
			This.of_delete( as_rept_id, "" )
			Return -1
		END IF
		
		lbl_value = Blob( lds_break.Object.DataWindow.Data )
		
		UPDATEBLOB REPORT_SYNTAX
		SET REPT_SYNTAX = :lbl_value
		WHERE REPT_ID = :as_rept_id
		AND REPT_TYPE = 'D'
		AND SEQ_NO = :li_ctr
		USING	Stars2ca;
		
		lbl_value = Blob( "" )
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "Save Error", "Unable to update data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
			Destroy lds_break
			Stars2ca.of_rollback()
			This.of_delete( as_rept_id, "" )
			Return -1
		END IF
		
		IF Stars2ca.of_commit() <> 0 THEN
			MessageBox( "Save Error", "Unable to commit data to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
			Destroy lds_break
			Stars2ca.of_rollback()
			This.of_delete( as_rept_id, "" )
			Return -1
		END IF
		
		lds_break.Reset()
		adw_save.RowsCopy( (ll_rows * li_ctr) + 1, ll_rows * (li_ctr + 1), Primary!, lds_break, 1, Primary! )
	LOOP
	Destroy lds_break
ELSE
	INSERT INTO REPORT_SYNTAX 
	VALUES ( :as_rept_id, 'D', 1, ' ' )
	USING Stars2ca;
	
	IF Stars2ca.of_check_status() <> 0 THEN
		MessageBox( "Save Error", "Unable to insert data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		Stars2ca.of_rollback()
		This.of_delete( as_rept_id, "" )
		Return -1
	END IF
	
	IF Stars2ca.of_commit() <> 0 THEN
		MessageBox( "Save Error", "Unable to commit data to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		Stars2ca.of_rollback()
		This.of_delete( as_rept_id, "" )
		Return -1
	END IF
	
	lbl_value = Blob( adw_save.Object.DataWindow.Data )
	
	UPDATEBLOB REPORT_SYNTAX
	SET REPT_SYNTAX = :lbl_value
	WHERE REPT_ID = :as_rept_id
	AND REPT_TYPE = 'D'
	USING	Stars2ca;
	
	lbl_value = Blob( "" )
	
	IF Stars2ca.of_check_status() <> 0 THEN
		MessageBox( "Save Error", "Unable to update data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		Stars2ca.of_rollback()
		This.of_delete( as_rept_id, "" )
		Return -1
	END IF
	
	IF Stars2ca.of_commit() <> 0 THEN
		MessageBox( "Save Error", "Unable to commit data to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		Stars2ca.of_rollback()
		This.of_delete( as_rept_id, "" )
		Return -1
	END IF
END IF

INSERT INTO REPORT_CNTL( DEPT_ID, USER_ID, REPT_ID, REPT_TYPE, REPT_DATETIME )
VALUES( :gc_user_dept, :gc_user_id, :as_rept_id, ' ', :adt_created )
USING Stars2CA;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Save Error", "Unable to insert into REPORT_CNTL: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	This.of_delete( as_rept_id, "" )
	Return -1
END IF

IF Stars2ca.of_commit() <> 0 THEN
	MessageBox( "Save Error", "Unable to commit REPORT_CNTL: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	This.of_delete( as_rept_id, "" )
	Return -1
END IF

Return 1
end function

public function long of_get_limit ();/////////////////////////////////////////////////////////////////////////////////////
//
//	This method will get the maximum number
//	of rows to save per iteration
//
/////////////////////////////////////////////////////////////////////////////////////
//
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//
/////////////////////////////////////////////////////////////////////////////////////

Long	ll_limit

SELECT cntl_no
INTO	:ll_limit
FROM	sys_cntl
WHERE	cntl_id = 'SAVEROWS'
USING	Stars2ca;

// If not found or error then no limit
IF Stars2ca.of_check_status() <> 0 THEN ll_limit = 999999

Return ll_limit
end function

public function integer of_update_rpt_syntax (datawindow adw_save, string as_rept_id);/////////////////////////////////////////////////////////////////////////////////////
//
// This method will save the format of the argument Datawindow
//
/////////////////////////////////////////////////////////////////////////////////////
//
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//
/////////////////////////////////////////////////////////////////////////////////////


Blob	lbl_value

IF NOT IsValid( adw_save ) THEN Return -1
IF IsNull( as_rept_id ) OR Trim( as_rept_id ) = "" THEN Return -1

lbl_value = Blob( adw_save.Object.DataWindow.Syntax )

UPDATEBLOB REPORT_SYNTAX
SET REPT_SYNTAX = :lbl_value
WHERE REPT_ID = :as_rept_id
AND REPT_TYPE = 'S'
USING	Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Save Error", "Unable to update syntax into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
	Stars2ca.of_rollback()
	Return -1
END IF

Return 1
end function

public function integer of_update_rpt_data (datawindow adw_save, string as_rept_id);/////////////////////////////////////////////////////////////////////////////////////
//
// This method will save the contents of the argument Datawindow
//
/////////////////////////////////////////////////////////////////////////////////////
//
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//
/////////////////////////////////////////////////////////////////////////////////////

Int	li_ctr
Blob	lbl_value
Long	ll_rows
String	ls_err
n_ds	lds_break
Boolean lb_commit_tran = true
Int li_ret_val

IF NOT IsValid( adw_save ) THEN Return -1
IF IsNull( as_rept_id ) OR Trim( as_rept_id ) = "" THEN Return -1

DELETE FROM REPORT_SYNTAX
WHERE REPT_ID = :as_rept_id
AND REPT_TYPE = 'D'
USING	Stars2ca;

// Break up rows by limit
ll_rows = This.of_get_limit()
IF adw_save.RowCount() > ll_rows THEN
	lds_break = Create n_ds
	IF lds_break.Create( String( lbl_value ), ls_err ) < 0 THEN
		MessageBox( "Save Error", "Unable to produce break datawindow: " + ls_err )
		Destroy lds_break
		lb_commit_tran = false
		li_ret_val = -1
		Goto CommitTransaction
	END IF
		
	adw_save.RowsCopy( 1, ll_rows, Primary!, lds_break, 1, Primary! )
	
	DO WHILE lds_break.RowCount() > 0
		li_ctr ++
		INSERT INTO REPORT_SYNTAX 
		VALUES ( :as_rept_id, 'D', :li_ctr, ' ' )
		USING Stars2ca;
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "Save Error", "Unable to insert data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
			Destroy lds_break
			lb_commit_tran = false
			li_ret_val = -1
			Goto CommitTransaction
		END IF
		
		lbl_value = Blob( lds_break.Object.DataWindow.Data )
		
		UPDATEBLOB REPORT_SYNTAX
		SET REPT_SYNTAX = :lbl_value
		WHERE REPT_ID = :as_rept_id
		AND REPT_TYPE = 'D'
		AND SEQ_NO = :li_ctr
		USING	Stars2ca;
		
		lbl_value = Blob( "" )
		
		IF Stars2ca.of_check_status() <> 0 THEN
			MessageBox( "Save Error", "Unable to update data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
			Destroy lds_break
			lb_commit_tran = false
			li_ret_val = -1
			Goto CommitTransaction
		END IF
		
		lds_break.Reset()
		adw_save.RowsCopy( (ll_rows * li_ctr) + 1, ll_rows * (li_ctr + 1), Primary!, lds_break, 1, Primary! )
	LOOP
	Destroy lds_break
ELSE
	
	INSERT INTO REPORT_SYNTAX 
	VALUES ( :as_rept_id, 'D', 1, ' ' )
	USING Stars2ca;
	
	IF Stars2ca.of_check_status() <> 0 THEN
		MessageBox( "Save Error", "Unable to insert data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		lb_commit_tran = false
		li_ret_val = -1
		Goto CommitTransaction
	END IF
	
	lbl_value = Blob( adw_save.Object.DataWindow.Data )
	
	UPDATEBLOB REPORT_SYNTAX
	SET REPT_SYNTAX = :lbl_value
	WHERE REPT_ID = :as_rept_id
	AND REPT_TYPE = 'D'
	USING	Stars2ca;
	
	lbl_value = Blob( "" )
	
	IF Stars2ca.of_check_status() <> 0 THEN
		MessageBox( "Save Error", "Unable to update data into REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		lb_commit_tran = false
		li_ret_val = -1
		Goto CommitTransaction
	END IF
END IF

li_ret_val = 1

CommitTransaction:

if lb_commit_tran then
	IF Stars2ca.of_commit() <> 0 THEN
		MessageBox( "Save Error", "Unable to commit syntax to REPORT_SYNTAX: " + Stars2ca.SQLErrText )
		Stars2ca.of_rollback()
		li_ret_val = -1
	END IF
else
	stars2ca.of_rollback()
end if

Return li_ret_val
end function

public function integer of_view (string as_case_id, string as_rept_id, string as_link_name, boolean ab_unsecure);/////////////////////////////////////////////////////////////////////////////////////
//
//	This method will recreate the report with the 
//	syntax and the data at the time it was saved
//
/////////////////////////////////////////////////////////////////////////////////////
//
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
// 10/08/04 MikeF	Track 4107d	If calendar, open w_calendar
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
//	12/22/04	GaryR Track 4182d	Apply modify/update security
//	10/04/05	GaryR	Track 4531d	For PDR reports, use the CASE_LINK report_id
//	07/02/07	GaryR	Track 5089	When modifing saved PDR, update date and create log
//
/////////////////////////////////////////////////////////////////////////////////////

Blob		lbl_value
String	ls_err, ls_sql
Integer	li_cnt, li_ctr
u_nvo_count	lnv_count

IF IsNull( as_rept_id ) OR Trim( as_rept_id ) = "" THEN Return -1

SELECTBLOB REPT_SYNTAX
INTO	:lbl_value
FROM REPORT_SYNTAX
WHERE REPT_ID = :as_rept_id
AND	REPT_TYPE = 'S'
USING	Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "View Error", "Unable to retrieve report syntax" )
	Return -1
END IF

IF OpenSheet( w_dw_viewer, mdi_main_frame, help_menu_position, Layered! ) <> 1 THEN
	MessageBox( 'View Data Window','Could NOT open datawindow viewer window.' )
	Return -1
END IF

IF NOT IsValid( w_dw_viewer ) THEN
	MessageBox( 'View Data Window','Datawindow viewer window not valid' )
	Return -1
END IF

is_case_id = as_case_id
w_dw_viewer.Title = 'View of ' + as_link_name + ' Report'
w_dw_viewer.is_link_name = as_link_name
w_dw_viewer.inv_report = This

If Pos(Upper(String(lbl_value)),"GRAPH") > 0 then
	w_dw_viewer.ddlb_dw_ops.Visible = FALSE 
	w_dw_viewer.st_dw_ops.Visible = FALSE 
end if

if w_dw_viewer.dw_1.Create(String(lbl_value),ls_err) = -1 then
   Close(w_dw_viewer)
   MessageBox('View Data Window','Could NOT recreate original data window.',StopSign!)
   return -1
end if

lnv_count = Create u_nvo_count
ls_sql = "select count(*) from report_syntax where rept_id = '" + &
				as_rept_id + "' and rept_type = 'D'"
li_cnt = lnv_count.uf_get_count( ls_sql )
Destroy lnv_count

FOR li_ctr = 1 TO li_cnt
	SELECTBLOB REPT_SYNTAX
	INTO	:lbl_value
	FROM	REPORT_SYNTAX
	WHERE REPT_ID = :as_rept_id
	AND	REPT_TYPE = 'D'
	AND	SEQ_NO = :li_ctr
	USING	Stars2ca;
	
	IF Stars2ca.of_check_status() <> 0 THEN
		Close(w_dw_viewer)
		MessageBox( "View Error", "Unable to retrieve report data" )
		Return -1
	END IF
	
	IF w_dw_viewer.dw_1.ImportString( String( lbl_value ) ) < 0 THEN
		Close(w_dw_viewer)
	END IF
	
	lbl_value = Blob( "" )
NEXT

w_dw_viewer.dw_1.GroupCalc()
w_dw_viewer.st_count.text = String( w_dw_viewer.dw_1.rowcount() )

// enable or disable report options/save button
w_dw_viewer.event ue_enable_report_options( ab_unsecure, as_rept_id )

Return 1
end function

public function integer of_view_patt_rpt (string as_case_id, string as_rept_id, string as_link_name);//********************************************************************
// 01/14/99 ajs FS2033c Y2K change mm/dd/yy to mm/dd/yyyy
// 03/17/98 ajs 4.0 Track 927 Fix field change in bg_rpt_cntl table
//	02/16/98	FDG	Remove the colors from the created d/w
// 11/25/96 FNC Prob #173 STARS35 Call set colors function
// 02/15/95	PLB this Window will retrieve into the data Window all
//         	rows which match the ID from the Report Table for		
//         	Multi Claim subsets.  The data window is dynamically
//         	created by a Create in a grid format.
// 11/01/00	GaryR	2920c	Standardize windows colors
//	12/14/00	FDG	Stars 4.7.  Make data type checking DBMS-independent.
//	02/20/01	FDG	Stars 4.7 - remove SQLCMD
//	08/10/01	GaryR	Track 2399d	Attempt to insert null
//	05/04/04	GaryR	Track 3544d	Redesign report save/view logic to improve performance
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//********************************************************************

String	ls_syntax, ls_sql, ls_style, ls_error, ls_nbr_cols
String	ls_title, ls_title1, ls_col_type, lv_col_name
String	mod_string
Integer	li_rc, li_index, li_pos
Integer	li_font_height = -10, li_font_weight = 700
Datetime ldt_rept_date
n_cst_string	lnv_string

Setpointer(Hourglass!)
w_main.SetMicroHelp(" Creating the datawindow for Report" )
IF IsNull( as_rept_id ) OR Trim( as_rept_id ) = "" THEN Return -1

ls_style = "datawindow(units=1) style(type=grid) " + &
			"Column(font.Face='Systems') Text(font.Face='Systems') "

ls_sql = 'Select * from BG_' + as_rept_id
ls_syntax = Stars2ca.SyntaxFromSQL( ls_sql, ls_style, ls_error)
IF ls_error <> "" THEN
	MessageBox( "SYNTAX ERROR", ls_error )
	Stars2ca.of_commit()
	Return -1
END IF

IF OpenSheet( w_dw_viewer, mdi_main_frame, help_menu_position, Layered! ) <> 1 THEN
	MessageBox( 'View Data Window','Could NOT open datawindow viewer window.' )
	Return -1
END IF

IF NOT IsValid( w_dw_viewer ) THEN
	MessageBox( 'View Data Window','Datawindow viewer window not valid' )
	Return -1
END IF

w_dw_viewer.Title = 'View of ' + as_link_name + ' Report'
w_dw_viewer.AccessibleName = 'View of ' + as_link_name + ' Report'
w_dw_viewer.AccessibleDescription = 'View of ' + as_link_name + ' Report'
is_case_id = as_case_id
w_dw_viewer.inv_report = This

IF w_dw_viewer.dw_1.Create( ls_syntax, ls_error ) < 1 THEN
	Close( w_dw_viewer )
	MessageBox( "SYNTAX ERROR", ls_error )
	Return -1
END IF

ls_title = 'Report ID: ' + as_link_name
ls_title1 = 'Case ID: ' + as_case_id
w_dw_viewer.dw_1.Modify( "datawindow.header.height = 100" )

mod_string = "create text(band=background color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'" + &
	"  x= '15' y='25' height='36' width= '750' text=~'" + ls_title + "~' " + &
	" name=header_t font.face='System' font.height= '-10' font.weight=~'" + string(li_font_weight) + &
	"~' font.family='2' font.pitch='2' font.charset='0' font.italic='0' " + &
	" font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Report ID~~"~~t~~"Report ID~~"" accessiblename="~~"Report ID~~"~~t~~"Report ID~~"" accessiblerole=42 ) '
w_dw_viewer.dw_1.Modify( mod_string )

mod_string = "create text(band=background color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'" + &
	"  x= '15' y='45' height='36' width= '750' text=~'" + ls_title1 + "~' " + &
	" name=header_t font.face='System' font.height= '-10' font.weight=~'" + string(li_font_weight) + &
	"~' font.family='2' font.pitch='2' font.charset='0' font.italic='0' " + &
	" font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Case ID~~"~~t~~"Case ID~~"" accessiblename="~~"Case ID~~"~~t~~"Case ID~~"" accessiblerole=42 ) '
w_dw_viewer.dw_1.Modify(mod_string)

ls_nbr_cols = w_dw_viewer.dw_1.Describe( 'Datawindow.Column.Count' )
For li_index = 1 to Integer( ls_nbr_cols )
	lv_col_name = w_dw_viewer.dw_1.describe('#' + string(li_index) + '.NAME')
	mod_string = w_dw_viewer.dw_1.Modify(lv_col_name + ".font.Height'~'" + string(li_font_height) + "~'")
	mod_string = w_dw_viewer.dw_1.Modify(lv_col_name + ".font.Weight'~'" + string(li_font_weight) + "~'")
	mod_string = w_dw_viewer.dw_1.Modify(lv_col_name + ".font.Face = 'System'")

	mod_string = w_dw_viewer.dw_1.Modify(lv_col_name + "_t.font.Height'~'" + string(li_font_height) + "~'")
	mod_string = w_dw_viewer.dw_1.Modify(lv_col_name + "_t.font.Weight'~'" + string(li_font_weight) + "~'")
	mod_string = w_dw_viewer.dw_1.Modify(lv_col_name + "_t.font.Face ='System'")
	mod_string = lv_col_name + '_t.y = 85 '
	
	//	Set Accessibility Properties
	ls_syntax = w_dw_viewer.dw_1.describe(lv_col_name + "_t.text")
	ls_syntax = lnv_string.of_clean_string_acc( ls_syntax )
	ls_syntax = '"' + ls_syntax + '"~t"' + ls_syntax + '"'
	mod_string += " " + lv_col_name + ".AccessibleName='" + ls_syntax + "'"
	mod_string += " " + lv_col_name + ".AccessibleDescription='" + ls_syntax + "'"
	mod_string += " " + lv_col_name + ".AccessibleRole='27'"	//	ColumnRole!
	mod_string += " " + lv_col_name + "_t.AccessibleName='" + ls_syntax + "'"
	mod_string += " " + lv_col_name + "_t.AccessibleDescription='" + ls_syntax + "'"
	mod_string += " " + lv_col_name + "_t.AccessibleRole='42'"	//	TextRole!
	
	w_dw_viewer.dw_1.modify(mod_string)
	ls_col_type = w_dw_viewer.dw_1.Describe('#'+string(li_index)+'.coltype')
	li_pos = Pos( ls_col_type, '(' )
	ls_col_type = Left( ls_col_type, li_pos - 1 )
	IF gnv_sql.of_is_money_data_type (ls_col_type)			THEN
		Setformat(w_dw_viewer.dw_1,li_index,'#,##0.00')
	ELSEIF gnv_sql.of_is_date_data_type (ls_col_type)		THEN
		Setformat(w_dw_viewer.dw_1,li_index,'mm/dd/yyyy')	//ajs 01-14-99
	END IF
Next

w_dw_viewer.dw_1.settransobject( stars2ca )
w_dw_viewer.dw_1.retrieve()
Stars2ca.of_commit()

//save as report
SetMicroHelp(w_main,'Saving Report to Database')
ldt_rept_date = gnv_app.of_get_server_date_time()//ts2020c
IF This.of_save( w_dw_viewer.dw_1, as_rept_id, ldt_rept_date ) > 0 THEN   
	Update bg_rpt_cntl
		set delete_ind = 'Y'
		where rpt_id = Upper( :as_rept_id )
	Using stars2ca;
	If stars2ca.of_check_status() <> 0 then
		Errorbox(stars2ca,'Unable to update Background Report Control Table')
		STARS2CA.of_rollback()																// FDG 02/20/01
		Return -1
	End If
	
	STARS2CA.of_commit()	
	w_dw_viewer.st_count.text = String( w_dw_viewer.dw_1.RowCount() )
	w_main.SetMicroHelp('Report successfully saved to DataBase')
else
	STARS2CA.of_commit()	
	Messagebox('Information','Report has no data to display')
end if

Return 1
end function

on n_cst_report.create
call super::create
end on

on n_cst_report.destroy
call super::destroy
end on

