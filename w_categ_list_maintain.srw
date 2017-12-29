HA$PBExportHeader$w_categ_list_maintain.srw
$PBExportComments$inherited from w_master
forward
global type w_categ_list_maintain from w_master
end type
type sle_procedure from u_sle within w_categ_list_maintain
end type
type sle_category from u_sle within w_categ_list_maintain
end type
type dw_count from u_dw within w_categ_list_maintain
end type
type st_copy_count from statictext within w_categ_list_maintain
end type
type st_period_count from statictext within w_categ_list_maintain
end type
type dw_dup_check from u_dw within w_categ_list_maintain
end type
type uo_new from u_display_period within w_categ_list_maintain
end type
type st_new from statictext within w_categ_list_maintain
end type
type cb_exit from u_cb within w_categ_list_maintain
end type
type dw_next_period from u_dw within w_categ_list_maintain
end type
type dw_new_period from u_dw within w_categ_list_maintain
end type
type dw_categ_proc from u_dw within w_categ_list_maintain
end type
type cb_file from u_cb within w_categ_list_maintain
end type
type cb_next_period from u_cb within w_categ_list_maintain
end type
type uo_1 from u_display_period within w_categ_list_maintain
end type
type st_period from statictext within w_categ_list_maintain
end type
type sle_categ_desc from singlelineedit within w_categ_list_maintain
end type
type st_1 from statictext within w_categ_list_maintain
end type
type st_row_count from statictext within w_categ_list_maintain
end type
type cb_stop from u_cb within w_categ_list_maintain
end type
type cb_delete from u_cb within w_categ_list_maintain
end type
type cb_add from u_cb within w_categ_list_maintain
end type
type cb_list from u_cb within w_categ_list_maintain
end type
type st_add_proc from statictext within w_categ_list_maintain
end type
type st_category from statictext within w_categ_list_maintain
end type
type dw_1 from u_dw within w_categ_list_maintain
end type
end forward

global type w_categ_list_maintain from w_master
string accessiblename = "Category Procedure List Maintenance"
string accessibledescription = "Category Procedure List Maintenance"
integer x = 293
integer y = 100
integer height = 1652
string title = "Category Procedure List Maintenance"
sle_procedure sle_procedure
sle_category sle_category
dw_count dw_count
st_copy_count st_copy_count
st_period_count st_period_count
dw_dup_check dw_dup_check
uo_new uo_new
st_new st_new
cb_exit cb_exit
dw_next_period dw_next_period
dw_new_period dw_new_period
dw_categ_proc dw_categ_proc
cb_file cb_file
cb_next_period cb_next_period
uo_1 uo_1
st_period st_period
sle_categ_desc sle_categ_desc
st_1 st_1
st_row_count st_row_count
cb_stop cb_stop
cb_delete cb_delete
cb_add cb_add
cb_list cb_list
st_add_proc st_add_proc
st_category st_category
dw_1 dw_1
end type
global w_categ_list_maintain w_categ_list_maintain

type variables
int in_nbr_rows
long in_period
string in_category,iv_invoice_type
string in_procedure
string in_1st_six_year, in_2nd_six_year, in_1st_six_oct_year
string is_new_tbl_name
string is_old_select1, is_old_select2, is_old_select3
string is_old_select4, is_old_count_sql
end variables

forward prototypes
public function string wf_padinteger (integer pad_number, integer num_chars)
public function string wf_padstring (string string_text, integer num_chars)
public subroutine wf_set_table_name (u_dw arg_dw_name)
public subroutine wf_file ()
public function integer wf_next_period ()
end prototypes

public function string wf_padinteger (integer pad_number, integer num_chars);STRING ls_string1, ls_string2

ls_string1 = "0000000000000000" + String ( pad_number)
ls_string2 = Right ( ls_string1, num_chars )

RETURN ls_string2


end function

public function string wf_padstring (string string_text, integer num_chars);
STRING ls_string1, ls_string2

IF IsNull(string_text) OR (string_text = " ") OR (string_text = "") THEN
	ls_string2 = Space(num_chars)
ELSE
	ls_string1 = string_text + Space ( num_chars )
	ls_string2 = Left ( ls_string1, num_chars )
END IF

RETURN ls_string2


end function

public subroutine wf_set_table_name (u_dw arg_dw_name);// FDG 10/31/01	Track 2491d.	Since ls_new_sql will have single and double
//						quotes, use dot notation instead of modify.

string ls_new_sql
integer li_pos
integer li_pos_from

ls_new_sql = arg_dw_name.Describe("Datawindow.Table.Select")

li_pos_from = pos(upper(ls_new_sql), 'FROM')

li_pos = pos(ls_new_sql,'CATG_PROC',li_pos_from+1)

ls_new_sql = replace(ls_new_sql,li_pos,len('CATG_PROC'),is_new_tbl_name)

// FDG 10/31/01
//arg_dw_name.Modify('Datawindow.Table.Select="'+ls_new_sql+'"')
arg_dw_name.object.datawindow.table.select	=	ls_new_sql
end subroutine

public subroutine wf_file ();////////////////////////////////////////////////////////////////////////////////////////
//
// Gary-R 7/11/2000 TS2262SD Windows Standard File Browser.
// FDG 10/31/01	Track 2491d.  Use Stars2ca instead of stars1ca because of the possible
//						removal of views.
//
////////////////////////////////////////////////////////////////////////////////////////

string  ls_filename
string  ls_categ_id
string  ls_categ_proc
string  ls_record
string  ls_tilde
string  ls_file
string  ls_end
integer li_file_number
integer li_row_count
integer li_row
long    ll_period
long    ll_selected_period
long    ll_period_key

SetPointer(Hourglass!)

//******************************************************************//
// call user object function to return the period the user selected //
//******************************************************************//

ll_selected_period = uo_1.uf_return_period()

//************************************************************//
// retrieve all rows from categ_proc with the selected period //
//************************************************************//

// FDG 10/31/01 - Use dot notation because SQL may have single and double quotes
//dw_categ_proc.Modify('Datawindow.Table.Select="'+is_old_select2+'"')
dw_categ_proc.object.Datawindow.Table.Select	=	is_old_select2
// FDG 10/31/01 end
dw_categ_proc.Reset()
dw_categ_proc.SetTransObject(stars2ca)		// FDG 10/31/01
wf_set_table_name(dw_categ_proc)
dw_categ_proc.Retrieve(ll_selected_period)

if dw_categ_proc.RowCount() = 0 then
	MessageBox("Produce File", "No rows exists for the selected period.  Click the 'Add Next Period' button to add category/procedure rows.", StopSign!)
	Return
end if

//**************************//
// error check the filename //
//**************************//

//Gary-R 7/11/2000 Begin

//ls_file = iv_invoice_type + string(ll_selected_period) + '.txt' + 'Y'
//openwithparm(w_output_filename,ls_file)
//if Message.StringParm = 'NO' then Return
//ls_filename = Message.StringParm

ls_filename = iv_invoice_type + string(ll_selected_period) + '.txt'

IF IsNull( ls_filename ) THEN
	MessageBox( "Produce File", "The file name is null", StopSign! )
	RETURN
END IF

IF GetFileSaveName( "Produce File", ls_filename, ls_file, "*.TXT", "Text Files, *.TXT, All Files, *.*" ) <> 1 THEN RETURN

IF FileExists( ls_filename ) THEN
   IF MessageBox( "Produce File", "File " + ls_filename + " already exists.~n~rWould you like to overwrite the existing file?", Question!, YesNo!, 2 ) = 2 THEN RETURN
END IF

//Gary-R 7/11/2000 End

//**********************//
// open the output file //
//**********************//

li_file_number = FileOpen(ls_filename, linemode!, write!, lockwrite!, replace!)

if li_file_number = -1 then
	MessageBox ('FILE OPEN ERROR','Output file could not be opened',StopSign! )
	return
end if

//*******************//
// write out records //
//*******************//

SetPointer(Hourglass!)

ls_end   = '}'
ls_tilde = '~~'

li_row_count = dw_categ_proc.RowCount()

// 01-27-98 MVR 3.6 TS302 - Changed length of (ls_categ_id,2) to (ls_categ_id,5)
FOR li_row = 1 TO li_row_count

	ls_categ_id     = dw_categ_proc.GetItemString(li_row, 'catg_id')
	ls_categ_proc   = dw_categ_proc.GetItemString(li_row, 'catg_proc')
	ll_period       = Long(Left(string(dw_categ_proc.GetItemNumber(li_row, 'period')),7))
	
	ls_record       =   wf_padstring(string(ll_period),6) + &
                       ls_tilde + &
						     wf_padstring(ls_categ_id,5) + &
                       ls_tilde + &
            		     wf_padstring(ls_categ_proc,5) + &
                       ls_end

	FileWrite(li_file_number, ls_record)

NEXT

//john-wo change for 161 - rel 3.6 - set use_catg_proc to y
ll_period_key = uo_1.uf_return_key()
  UPDATE PERIOD_CNTL  
     SET USE_CATGPROC = 'Y'  
   WHERE PERIOD_CNTL.PERIOD_KEY = :ll_period_key  
	Using Stars2ca;

If stars2ca.of_check_status() = 100 Then
	Messagebox('Update','Row not found on Period CNTL Table with a key of ' &
		+ String(ll_period_key) + '.',stopsign!)
	setmicrohelp(w_main,'Update Cancelled')
	Return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error updating the use_catgproc column from the Period CNTL Table ' &
		+ 'where the period key = ' + String(ll_period_key) + '.')
	Setmicrohelp(w_main,'Deletion Cancelled')
	return
end If
	
//sqlcmd('DisConnect',stars2ca,'Error DisConnecting to the database',5)     PLB 10/19/95
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If
// end change john-wo 161 8/97
if FileClose(li_file_number) = - 1 then
	MessageBox('Produce File', 'Error creating file ' + ls_filename)
else
	MessageBox('Produce File', 'File ' + ls_filename + ' successfully created')
end if

end subroutine

public function integer wf_next_period ();////////////////////////////////////////////////////////////////////////////
//
//	12/04/00	GaryR	Stars 4.7 DataBase Port - Prefixing the DataBase name.
// 10/31/01	FDG	Track 2491d.  Use Stars2ca instead of stars1ca because of the possible
//						removal of views.
//	09/10/02	GaryR	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//
////////////////////////////////////////////////////////////////////////////

string   ls_stars1_db
string   ls_sql_statement
string   ls_dup_sql
long     ll_new_period
long     ll_selected_period
long     ll_dup_count
integer  li_period_row
integer  li_period_count
integer  li_row
integer  li_row_count
date     ld_run_date
date     ld_min_date

//**************************************************//
// determine the next ratio period from period_cntl //
//**************************************************//

ll_new_period = uo_new.uf_return_period()

if IsNull(ll_new_period) then
	MessageBox('Next Period', 'Select a new period to copy the category/procedures to', StopSign!)
	Return - 1
end if

//*********************************************************//
// check to see if this period already exists in catg_proc //
//*********************************************************//

// FDG 10/31/01 - Use dot notation because of the combination of single and double quotes
//dw_categ_proc.Modify('Datawindow.Table.Select="'+is_old_select2+'"')
//dw_dup_check.Modify('Datawindow.Table.Select="'+is_old_select3+'"')
//dw_new_period.Modify('Datawindow.Table.Select="'+is_old_select4+'"')
dw_categ_proc.object.Datawindow.Table.Select	=	is_old_select2
dw_dup_check.object.Datawindow.Table.Select	=	is_old_select3
dw_new_period.object.Datawindow.Table.Select	=	is_old_select4
// FDG 10/31/01 end

dw_dup_check.Reset()
dw_dup_check.SetTransObject(stars2ca)		// FDG 10/31/01
wf_set_table_name(dw_dup_check)
dw_dup_check.Retrieve(ll_new_period)
ll_dup_count = dw_dup_check.GetItemNumber(1,'dup_count')

if ll_dup_count > 0 then
	MessageBox('Next Period', 'Category/Procedure rows already exist for period ' + string(ll_new_period))
	Return -1
end if

//******************************************************************//
// call user object function to return the period the user selected //
//******************************************************************//

ll_selected_period = uo_1.uf_return_period()

//************************************************************//
// retrieve all rows from categ_proc with the selected period //
//************************************************************//

dw_categ_proc.Reset()
dw_categ_proc.SetTransObject(stars2ca)		// FDG 10/31/01
wf_set_table_name(dw_categ_proc)
dw_categ_proc.Retrieve(ll_selected_period)
 
li_row_count = dw_categ_proc.RowCount()

if li_row_count = 0 then
	MessageBox('Category/Procedure', 'There is no data for the selected period to copy')
	Return -1
end if

//******************************************//
// copy categ_proc rows to empty datawindow //
//******************************************//

wf_set_table_name(dw_new_period)
dw_new_period.Modify("DataWindow.Table.UpdateTable = " + '~"' + is_new_tbl_name + '~"')
dw_categ_proc.RowsCopy(1, li_row_count, Primary!, dw_new_period, 1, Primary!)

//******************************************************//
// update the period on the new rows to the next period //
//******************************************************//

For li_row = 1 to li_row_count

	dw_new_period.SetItem(li_row, 'period', ll_new_period)
	dw_new_period.SetItemStatus(li_row, 0, Primary!, NewModified!)

Next

//	09/10/02	GaryR	Track 3468d
//dw_new_period.SetTransObject(stars1ca)
dw_new_period.SetTransObject( Stars2ca )

if dw_new_period.EVENT ue_update( TRUE, TRUE ) = -1 then
	//	09/10/02	GaryR	Track 3468d
	//Rollback using stars1ca;
	Stars2ca.of_rollback()
	
	MessageBox('Next Period', 'Error updating categ_proc table')
	Return -1
else
	//	09/10/02	GaryR	Track 3468d
	//Commit using stars1ca;
	Stars2ca.of_commit()
	MessageBox('Next Period', 'Successfully copied categories/procedures to period ' + string(ll_new_period), Information!)
end if

//*******************************************//
// delete inactive periods off of categ_proc //
//*******************************************//

//	12/04/00	GaryR		Stars 4.7 DataBase Port - Begin
//ls_stars1_db = stars2ca.database + '..period_cntl p'
ls_stars1_db = gnv_sql.of_get_database_prefix( stars2ca.database ) + "period_cntl"

//ls_sql_statement = &
//	'DELETE ' + is_new_tbl_name + ' FROM ' + is_new_tbl_name + ' c, ' + ls_stars1_db + ' WHERE c.period = p.period and ' + &
//   'p.function = "RAT"  and p.function_status = "IN" '
ls_sql_statement = "DELETE FROM " + is_new_tbl_name + " WHERE period IN (SELECT period " + &
						 "FROM " + ls_stars1_db + &
						 " WHERE function_name = 'RAT' and function_status = 'IN') "
//	12/04/00	GaryR		Stars 4.7 DataBase Port - End

//	09/10/02	GaryR	Track 3468d - Begin
//EXECUTE IMMEDIATE	:ls_sql_statement USING Stars1ca;
//
//if stars1ca.of_check_status() <> 0 then
//	Rollback using stars1ca;
//	MessageBox('Category/Procedure', 'Error deleting inactive periods')
//	Return -1
//else
//	Commit using stars1ca;
//end if

IF Stars2ca.of_execute( ls_sql_statement ) <> 0 THEN
	Stars2ca.of_rollback()
	MessageBox('Category/Procedure', 'Error deleting inactive periods')
	Return -1
ELSE
	Stars2ca.of_commit()
END IF
//	09/10/02	GaryR	Track 3468d - End

Return 1
end function

event open;call super::open;/***************Script for open w_categ_list_maintain*****************/

//*******************************************************************
//09-25-96 FNC Prob #180	STARSENH Allow user to specify a proc code
//									for list 
//09-28-95 FNC Prob #1094 Stars30 Change period from radio buttons
//             to a ddlb
// FDG 10/31/01	Track 2491d.  Use Stars2ca instead of stars1ca because of the possible
//						removal of views.
// JSB 01/11/02   Track 2491c.  If no periods are available, disable LIST button,
//                              display NONE in period DDLB, and fire messagebox.
//*******************************************************************
datawindowchild ldw_newchild
datawindowchild ldw_child
long ll_test
int  li_test
int  li_find
long ll_new_row 
long ll_row_count, ll_counter
long ll_new_count
long ll_future_count, ll_pos
long ll_found                     //JSB 01/11/02 Track 2491c.
string ls_status, ls_select, ls_new_select, ls_use_catgproc, ls_test

//	FDG 07/31/97 - Disable closequery processing
ib_disableclosequery	=	TRUE

dw_1.taborder =0

cb_delete.enabled = false
cb_stop.enabled = false

if gv_from = "lookup" then
	cb_add.visible = FALSE
	cb_delete.visible = FALSE
   cb_next_period.visible = FALSE
	cb_file.visible = FALSE
end if

//*********************************//
// determine table name to be used //
//*********************************//

// FDG 10/31/01 begin
//This.of_SetTransaction (stars1ca)		// Register which transaction this window will use
//dw_1.SetTransObject(stars1ca)          // settransobject has to be
//dw_categ_proc.SetTransObject(stars1ca) // set before a getsqlselect
//dw_dup_check.SetTransObject(stars1ca)  // can be called ABO 9/20/96
//dw_new_period.SetTransObject(stars1ca)
//dw_count.SetTransObject(stars1ca)
This.of_SetTransaction (stars2ca)		// Register which transaction this window will use
dw_1.SetTransObject(stars2ca)          // settransobject has to be
dw_categ_proc.SetTransObject(stars2ca) // set before a getsqlselect
dw_dup_check.SetTransObject(stars2ca)  // can be called ABO 9/20/96
dw_new_period.SetTransObject(stars2ca)
dw_count.SetTransObject(stars2ca)
// FDG 10/31/01 end

is_old_select1 = dw_1.GetSqlSelect()
is_old_select2 = dw_categ_proc.GetSqlSelect()
is_old_select3 = dw_dup_check.GetSqlSelect()
is_old_select4 = dw_new_period.GetSqlSelect()
is_old_count_sql = dw_count.GetSqlSelect()

Select col_name
Into :is_new_tbl_name
From Stars_win_parm
Where Win_id = 'W_CATEG_LIST_MAINTAIN' and tbl_type = Upper( :iv_invoice_type )
Using Stars2ca;

If stars2ca.of_check_status() = 100 Then
	Messagebox('EDIT','Column name not found where Win_id = w_categ_list_maintain and tbl_type = ' + iv_invoice_type + ',Process is cancelled',stopsign!)
	setmicrohelp(w_main,'List process cancelled')
	return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error reading Stars Win Parm Where Win_id = w_categ_list_maintain and tbl_type = ' + iv_invoice_type)
	Setmicrohelp(w_main,'List Process Cancelled')
	Return
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

//************************//
// load period drop downs //
//************************//

//uo_1.uf_load_dddw('RATIO', iv_invoice_type, '%', 'FALSE')
uo_1.uf_load_dddw('RATIO', iv_invoice_type, '%', 'TRUE')
// JSB 01/11/02 Track 2491  Changed to TRUE so we get the 'NONE' record in the DDLB.

uo_new.uf_load_dddw('RATIO', iv_invoice_type, '%', 'FALSE')

uo_1.getchild('period_key', ldw_child)
uo_new.getchild('period_key', ldw_newchild)
ll_row_count = ldw_child.RowCount()
ll_new_count = ldw_newchild.RowCount()

//************************************//
// delete rows with unwanted statuses //
//************************************//

For ll_new_row = 1 to ll_new_count
	ls_test = ldw_newchild.GetItemString(ll_new_row, 'period_desc')
	ls_status = ldw_newchild.GetItemString(ll_new_row, 'function_status')
	if ls_status = 'AC' or ls_status = 'IN' or ls_status = 'HO' then
		ldw_newchild.DeleteRow(ll_new_row)
      ll_new_count = ll_new_count - 1
      ll_new_row   = ll_new_row - 1
		continue //john_wo added 11/11/97 spec 127
	end if
//john_wo 11/11/97 spec 127 don't load periods with use_catgproc = n
//This for next loop deletes rows from the 'copy to' user object.
	ls_use_catgproc = &
		ldw_newchild.GetItemString(ll_new_row, 'use_catgproc')
	if ls_use_catgproc = 'N' then
		li_test = ldw_newchild.DeleteRow(ll_new_row)
      ll_new_count = ll_new_count - 1
      ll_new_row   = ll_new_row - 1
	end if
//john_wo 11/11/97 spec 127 end 
Next

//john_wo 11/12/97 spec 127 3.6 - delete rows from the visible uo when
//use_catgproc = 'N'
For ll_counter = 1 to ll_row_count
	ls_test = ldw_child.GetItemString(ll_counter, 'period_desc')
	ls_use_catgproc = &
		ldw_child.GetItemString(ll_counter, 'use_catgproc')
	if ls_use_catgproc = 'N' and ls_test <> 'NONE' then   // JSB 01/11/2001 Track 2491
	                                                      // Do not delete NONE record.
		li_test = ldw_child.DeleteRow(ll_counter)
      ll_row_count = ll_row_count - 1
      ll_counter   = ll_counter - 1
	end if
Next

// Start JSB 01/11/2001 Track 2491
// If no periods are available, only record left will be 'NONE'.  If this is the case,
// disable the list button and fire a messagebox.  If periods are available, get rid of
// this 'NONE' row.

ll_row_count = ldw_child.RowCount()
ll_found = ldw_child.find( "period_desc = 'NONE'", 1, ll_row_count)
if ll_row_count > 1 then
	//periods found
	if ll_found > 0 then
		li_test = ldw_child.DeleteRow(ll_found)
	end if
else
	// no periods found
	messagebox('Alert!','No eligible periods are available for this invoice type.', exclamation!)
	cb_list.enabled = FALSE
end if
//end JSB 01/11/2001 Track 2491


uo_1.uf_scroll_to_max_period(ldw_child)
//john_wo 11/12/97 spec 127 end 

uo_new.uf_scroll_to_max_period(ldw_newchild)

//fx_set_window_colors(w_main.win_to_open)		// FDG 05/22/96
//fx_set_window_colors(lv_temp) //DJP 12/2/96
SetMicroHelp('Ready')
end event

on w_categ_list_maintain.create
int iCurrent
call super::create
this.sle_procedure=create sle_procedure
this.sle_category=create sle_category
this.dw_count=create dw_count
this.st_copy_count=create st_copy_count
this.st_period_count=create st_period_count
this.dw_dup_check=create dw_dup_check
this.uo_new=create uo_new
this.st_new=create st_new
this.cb_exit=create cb_exit
this.dw_next_period=create dw_next_period
this.dw_new_period=create dw_new_period
this.dw_categ_proc=create dw_categ_proc
this.cb_file=create cb_file
this.cb_next_period=create cb_next_period
this.uo_1=create uo_1
this.st_period=create st_period
this.sle_categ_desc=create sle_categ_desc
this.st_1=create st_1
this.st_row_count=create st_row_count
this.cb_stop=create cb_stop
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_list=create cb_list
this.st_add_proc=create st_add_proc
this.st_category=create st_category
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_procedure
this.Control[iCurrent+2]=this.sle_category
this.Control[iCurrent+3]=this.dw_count
this.Control[iCurrent+4]=this.st_copy_count
this.Control[iCurrent+5]=this.st_period_count
this.Control[iCurrent+6]=this.dw_dup_check
this.Control[iCurrent+7]=this.uo_new
this.Control[iCurrent+8]=this.st_new
this.Control[iCurrent+9]=this.cb_exit
this.Control[iCurrent+10]=this.dw_next_period
this.Control[iCurrent+11]=this.dw_new_period
this.Control[iCurrent+12]=this.dw_categ_proc
this.Control[iCurrent+13]=this.cb_file
this.Control[iCurrent+14]=this.cb_next_period
this.Control[iCurrent+15]=this.uo_1
this.Control[iCurrent+16]=this.st_period
this.Control[iCurrent+17]=this.sle_categ_desc
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.st_row_count
this.Control[iCurrent+20]=this.cb_stop
this.Control[iCurrent+21]=this.cb_delete
this.Control[iCurrent+22]=this.cb_add
this.Control[iCurrent+23]=this.cb_list
this.Control[iCurrent+24]=this.st_add_proc
this.Control[iCurrent+25]=this.st_category
this.Control[iCurrent+26]=this.dw_1
end on

on w_categ_list_maintain.destroy
call super::destroy
destroy(this.sle_procedure)
destroy(this.sle_category)
destroy(this.dw_count)
destroy(this.st_copy_count)
destroy(this.st_period_count)
destroy(this.dw_dup_check)
destroy(this.uo_new)
destroy(this.st_new)
destroy(this.cb_exit)
destroy(this.dw_next_period)
destroy(this.dw_new_period)
destroy(this.dw_categ_proc)
destroy(this.cb_file)
destroy(this.cb_next_period)
destroy(this.uo_1)
destroy(this.st_period)
destroy(this.sle_categ_desc)
destroy(this.st_1)
destroy(this.st_row_count)
destroy(this.cb_stop)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_list)
destroy(this.st_add_proc)
destroy(this.st_category)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;
iv_invoice_type = message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

end event

type sle_procedure from u_sle within w_categ_list_maintain
string tag = "LOOKUP"
string accessiblename = "Lookup Field -  Procedure"
string accessibledescription = "Lookup Field -  Procedure"
integer x = 2231
integer y = 104
integer width = 398
integer height = 100
integer taborder = 40
integer weight = 700
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 15
end type

event getfocus;call super::getfocus;//*********************************************************************************
// Script Name:	GetFocus
//
// Arguments:	None
//
// Returns:		None
//
// Description:	On focus logic
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

cb_add.default = true
end event

event ue_lookup;call super::ue_lookup;//                 ***RBUTTONCLICKED FOR SLE_SEL_PROC***
//***********************************************************************
//This script gets the lookup type and then passed that to w_code_lookup.
//When the application returns from the window it displays the code picked
//in the sle as long as it is not spaces
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 09/01/93  MH  Created 
// 10/03/93 SWD  Added line that calls the function split, to retrieve the
//					  proper lookup type for this sle.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//***********************************************************************

string lv_from

gv_code_to_use = 'PC'
lv_from=gv_from
gv_from=''
open(w_code_lookup)
gv_from=lv_from

if gv_code_to_use <> '' Then This.text = gv_code_to_use
end event

type sle_category from u_sle within w_categ_list_maintain
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Category"
string accessibledescription = "Lookup Field - Category"
integer x = 1838
integer y = 104
integer width = 347
integer height = 100
integer taborder = 30
integer weight = 700
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 15
end type

event getfocus;call super::getfocus;cb_list.default = true
end event

event modified;call super::modified;sle_categ_desc.text = ''
end event

event ue_lookup;call super::ue_lookup;//                 ***RBUTTONCLICKED FOR SLE_SEL_PROC***
//***********************************************************************
//This script gets the lookup type and then passed that to w_code_lookup.
//When the application returns from the window it displays the code picked
//in the sle as long as it is not spaces
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 09/01/93  MH  Created 
// 10/03/93 SWD  Added line that calls the function split, to retrieve the
//					  proper lookup type for this sle.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//***********************************************************************

string lv_from

gv_code_to_use = 'CT'
lv_from=gv_from
gv_from=''
open(w_code_lookup)
gv_from=lv_from

if gv_code_to_use <> '' Then This.text = gv_code_to_use
end event

type dw_count from u_dw within w_categ_list_maintain
boolean visible = false
string accessiblename = "Count"
string accessibledescription = "d_count_box"
integer x = 329
integer y = 500
integer width = 274
integer height = 212
integer taborder = 0
string dataobject = "d_count_box"
end type

type st_copy_count from statictext within w_categ_list_maintain
string tag = "colorfixed"
boolean visible = false
string accessiblename = "Copy Count"
string accessibledescription = "Copy Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1358
integer y = 296
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_period_count from statictext within w_categ_list_maintain
string tag = "colorfixed"
string accessiblename = "Period Count"
string accessibledescription = "Period Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1358
integer y = 92
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_dup_check from u_dw within w_categ_list_maintain
boolean visible = false
string accessiblename = "Duplicate Check"
string accessibledescription = "d_dup_check"
integer x = 1902
integer y = 500
integer width = 274
integer height = 212
integer taborder = 0
string dataobject = "d_dup_check"
end type

type uo_new from u_display_period within w_categ_list_maintain
boolean visible = false
string accessiblename = "Copy To"
string accessibledescription = "Copy To"
integer x = 14
integer y = 284
integer taborder = 20
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;// FDG 10/31/01	Track 2491d.  Use Stars2ca instead of stars1ca because of the possible
//						removal of views.


long ll_selected_period

ll_selected_period = uo_new.uf_return_period()

// FDG 10/31/01 - Use dot notation because of combining single and double quotes
//dw_count.Modify('Datawindow.Table.Select="'+is_old_count_sql+'"')
dw_count.object.Datawindow.Table.Select	=	is_old_count_sql
// FDG 10/31/01 end

dw_count.Reset()
dw_count.SetTransObject(stars2ca)			// FDG 10/31/01
wf_set_table_name(dw_count)
dw_count.Retrieve(ll_selected_period)
st_copy_count.text = string(dw_count.GetItemNumber(1,'count'))


end event

type st_new from statictext within w_categ_list_maintain
boolean visible = false
string accessiblename = "Copy To"
string accessibledescription = "Copy To"
accessiblerole accessiblerole = statictextrole!
integer x = 5
integer y = 208
integer width = 261
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Copy To:"
boolean focusrectangle = false
end type

type cb_exit from u_cb within w_categ_list_maintain
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2391
integer y = 1412
integer width = 265
integer height = 108
integer taborder = 130
string text = "&Close"
end type

on clicked;close(parent)
end on

type dw_next_period from u_dw within w_categ_list_maintain
boolean visible = false
string accessiblename = "Next Period"
string accessibledescription = "d_next_ratio_period"
integer x = 1509
integer y = 500
integer width = 274
integer height = 212
integer taborder = 0
string dataobject = "d_next_ratio_period"
end type

type dw_new_period from u_dw within w_categ_list_maintain
boolean visible = false
string accessiblename = "New Period"
string accessibledescription = "d_categ_proc"
integer x = 1120
integer y = 500
integer width = 274
integer height = 212
integer taborder = 0
string dataobject = "d_categ_proc"
end type

type dw_categ_proc from u_dw within w_categ_list_maintain
boolean visible = false
string accessiblename = "Category Procedure"
string accessibledescription = "d_categ_proc"
integer x = 722
integer y = 500
integer width = 274
integer height = 212
integer taborder = 0
string dataobject = "d_categ_proc"
end type

type cb_file from u_cb within w_categ_list_maintain
string accessiblename = "Produce File"
string accessibledescription = "Produce File"
integer x = 1906
integer y = 1412
integer width = 439
integer height = 108
integer taborder = 120
string text = "&Produce File"
end type

on clicked;wf_file()
end on

type cb_next_period from u_cb within w_categ_list_maintain
string accessiblename = "Add Next Period"
string accessibledescription = "Add Next Period"
integer x = 1317
integer y = 1412
integer width = 549
integer height = 108
integer taborder = 100
string text = "&Add Next Period"
end type

on clicked;if uo_new.visible = FALSE then
	uo_new.visible = TRUE
	st_new.visible = TRUE
	st_copy_count.visible = TRUE
	this.text = 'Continue'
	MessageBox('Add Next Period', 'Select a period to copy the category procedure rows to and click the continue button.', Information!)
	Return
else
	wf_next_period()
	this.text = 'Add Next Period'
	uo_new.visible = FALSE
	st_new.visible = FALSE
	st_copy_count.visible = FALSE
end if

end on

type uo_1 from u_display_period within w_categ_list_maintain
integer x = 14
integer y = 84
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long ll_selected_period

ll_selected_period = uo_1.uf_return_period()

dw_count.Modify('Datawindow.Table.Select="'+is_old_count_sql+'"')
dw_count.Reset()

//	09/10/02	GaryR	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//dw_count.SetTransObject(stars1ca)
dw_count.SetTransObject( Stars2ca )

wf_set_table_name(dw_count)
dw_count.Retrieve(ll_selected_period)
st_period_count.text = string(dw_count.GetItemNumber(1,'count'))


end event

type st_period from statictext within w_categ_list_maintain
string accessiblename = "Period"
string accessibledescription = "Period"
accessiblerole accessiblerole = statictextrole!
integer x = 9
integer y = 8
integer width = 256
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Period:"
boolean focusrectangle = false
end type

type sle_categ_desc from singlelineedit within w_categ_list_maintain
string accessiblename = "Category Description"
string accessibledescription = "Category Description"
accessiblerole accessiblerole = textrole!
integer x = 1829
integer y = 304
integer width = 864
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_categ_list_maintain
string accessiblename = "Category Description"
string accessibledescription = "Category Description"
accessiblerole accessiblerole = statictextrole!
integer x = 1824
integer y = 228
integer width = 654
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Category Description:"
boolean focusrectangle = false
end type

type st_row_count from statictext within w_categ_list_maintain
string tag = "colorfixed"
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1428
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_stop from u_cb within w_categ_list_maintain
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
integer x = 1920
integer y = 1412
integer width = 334
integer height = 108
integer taborder = 110
string text = "Stop"
end type

on clicked;gv_cancel_but_clicked = TRUE
end on

type cb_delete from u_cb within w_categ_list_maintain
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1006
integer y = 1412
integer width = 270
integer height = 108
integer taborder = 90
string text = "&Delete"
end type

event clicked;/*Clicked event for the Delete Button*/
/*Deletes the row from the table*/

/////////////////////////////////////////////////////////////////////////////
//
//	09/10/02	GaryR	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//
/////////////////////////////////////////////////////////////////////////////

int lv_message_nbr, lv_pos, row_nbr
string lv_SQL_delete, lv_new_tbl_name

if IsNull(in_period) = true then
   MessageBox('Error','Must select a row in order to delete')
end if

/*Prints a confirmation box and finds out what button was pressed*/
lv_message_nbr = MessageBox('CONFIRMATION!','Delete Record ~nCategory =' + in_category + &
                 '~nProcedure Code = '+in_procedure,Question!,OKCANCEL!,2)
If lv_message_nbr = 2 then
	  SetMicroHelp(w_main,'Deletion of Category/Procedure Cancelled')	
     Return
end if

SetPointer(Hourglass!)
SetMicroHelp(w_main,'Deleting Category/Procedure entry from Dictionary Table')
 
Select col_name
Into :lv_new_tbl_name
From Stars_win_parm
Where Win_id = 'W_CATEG_LIST_MAINTAIN' and tbl_type = Upper( :iv_invoice_type )
Using Stars2ca;
If stars2ca.of_check_status() = 100 Then
	Messagebox('EDIT','Column name not found where win Parm where Win ID = w_categ_list_maintain and table type = ' + iv_invoice_type + ' ,Deletion cancelled',stopsign!)
	setmicrohelp(w_main,'Deletion Cancelled')
	Return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error retrieving column name from win Parm where Win ID = w_categ_list_maintain and table type = ' + iv_invoice_type)
	Setmicrohelp(w_main,'Deletion Cancelled')
	return
end If
	
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	


lv_SQL_delete = 'DELETE FROM ' + lv_new_tbl_name &
              + ' WHERE ( PERIOD = ' + STRING(in_period) + &   
              + ' ) AND ( CATG_ID = ' + '~'' + Upper( in_category ) + '~'' &
              + ' ) AND ( CATG_PROC = ' + '~'' + Upper( in_procedure ) + '~'' + ' )'
				  
//	09/10/02	GaryR	Track 3468d - Begin
//EXECUTE IMMEDIATE :lv_SQL_delete using Stars1ca;
//
If gc_debug_mode = True Then
   clipboard(lv_SQL_delete)
   MessageBox('SQL DELETE :',lv_SQL_delete)
End If
//
///*Checks to see there was a error in reading the database or*/
///*if there was no match in the database*/
//If stars2ca.of_check_status() = 100 Then
//	SetMicroHelp(w_main,'Deletion Cancelled')
//	COMMIT using STARS1CA;
//	If stars1ca.of_check_status() <> 0 Then
//		Messagebox('EDIT','Error Commiting to Stars2')
//		Return
//	End If	
//	messagebox('Not Found','Selection not found, Cannot be Deleted',StopSign!)
//	setfocus(dw_1)
//	RETURN
//elseIF stars1ca.sqlcode < 0 Then
//	SetMicroHelp(w_main,'Error Deleting from Category/Procedure Table, Deletion Cancelled')
//   errorbox(stars1ca,'Error deleting from the Category/Procedure table')
//	RETURN
//end if 
//
//COMMIT using STARS1CA;
//If stars1ca.of_check_status() <> 0 Then
//	Messagebox('EDIT','Error Commiting to Stars2')
//	Return
//End If

//	Check to see there was a error in reading the database or
//	if there was no match in the database
IF Stars2ca.of_execute( lv_sql_delete ) <> 0 THEN
	Stars2ca.of_rollback()
	w_main.SetMicroHelp( "Error Deleting from Category/Procedure Table.  Deletion Cancelled" )
	MessageBox( "Delete", "Error Deleting from Category/Procedure Table.  Deletion Cancelled", StopSign! )
	dw_1.SetFocus()
	Return
END IF

Stars2ca.of_commit()
//	09/10/02	GaryR	Track 3468d - End

row_nbr = getrow(dw_1)

deleterow(dw_1,row_nbr)

st_row_count.text = string(integer(st_row_count.text) - 1)

if row_nbr > integer(st_row_count.text) then
    lv_pos = row_nbr - 1
else
    lv_pos = row_nbr
end if

setrow(dw_1,lv_pos)
selectrow(dw_1,lv_pos,true)

dw_1.taborder = 50
setfocus(dw_1)
cb_delete.default = true
SetMicroHelp(w_main,'Deletion Complete')

end event

type cb_add from u_cb within w_categ_list_maintain
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 681
integer y = 1412
integer width = 279
integer height = 108
integer taborder = 80
string text = "Cr&eate"
end type

event clicked;//************************************************************
//	09/10/02	GaryR	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//	02/20/01	FDG	Stars 4.7 - remove SQLCMD
//	12-04-00	FDG	Stars 4.7.  Remove duplicate insert check because
//						n_tr.of_check_status already errors out on a
//						duplicate insert.
// 09-25-96 FNC	Set in_period = to il_period in user object
//	09-25-96 FNC	Prob #83 STARS35 Allow user to add a category only
//						for future periods.
// 09-28-95 FNC Prob #1094 Stars30 Change period from radio buttons
//             to a ddlb
// 04-24-94 FNC Add category to code table and add a field for
//              category description
//************************************************************
string lv_proc_desc,lv_categ_desc,lv_new_tbl_name
string lv_SQL_insert,ls_period_function
int    lv_pos,li_period_key
long   lv_period

setpointer(hourglass!)
setmicrohelp(w_main,'Adding Category/Procedure...')

//09-25-96 FNC Start
li_period_key = uo_1.uf_return_key()

SELECT PERIOD_CNTL.FUNCTION_STATUS  
  INTO :ls_period_function  
FROM PERIOD_CNTL  
WHERE PERIOD_CNTL.PERIOD_KEY = :li_period_key   
USING stars2ca;

if stars2ca.of_check_status() <> 0 then
	errorbox(stars2ca,'Period specified is not on Period Control. Cannot add procedure.')
	cb_add.default = true
	setmicrohelp(w_main,'Ready')
	RETURN
end if

commit using stars2ca;	
 
if ls_period_function <> 'FU' then
	messagebox('WARNING','May only add to future periods')
	cb_add.default = true
	setmicrohelp(w_main,'Ready')
	RETURN
end if
//09-28-96 FNC End

If trim(sle_category.text) = '' then
	Messagebox('EDIT','Category Must be Entered')
	setfocus(sle_category)
	cb_add.default = true
	setmicrohelp(w_main,'Ready')
	RETURN
End If


in_period = uo_1.uf_return_period()			//09-25-96 FNC

If trim(sle_procedure.text)  = '' then
	Messagebox('EDIT','Procedure Code Must be Entered')
	setfocus(sle_procedure)
	cb_add.default = true
	setmicrohelp(w_main,'Ready')
	RETURN
End If


SELECT CODE_DESC  
    INTO :lv_proc_desc  
    FROM CODE  
   WHERE ( CODE_TYPE = 'PC' ) AND  
         ( CODE_CODE = Upper( :sle_procedure.text ) ) 
   USING stars2ca  ;

If stars2ca.of_check_status() <> 0 then
   if stars2ca.sqlcode = 100 then
      SetMicroHelp(w_main,'Procedure Code not found on code table')
      messagebox('INFORMATION','Unable to find Procedure Code on code table.  Please check your entry.',Exclamation!)
      //sqlcmd('rollback',stars2ca,'Error performing rollback on the stars2ca database',1)  
		STARS2CA.of_rollback()																// FDG 02/20/01
      setfocus(uo_1)  //09-28-95 FNC
      return
   else
      SetMicroHelp(w_main,'Error Retrieving Procedure Code Description')
      messagebox('Information','Unable to retrieve procedure code. Record has not been added')
		STARS2CA.of_rollback()																// FDG 02/20/01
      setfocus(uo_1)  //09-28-95 FNC
      return
   end if
else
	COMMIT USING STARS2CA;
end if

SELECT CODE_DESC   
    INTO :lv_categ_desc  
    FROM CODE  
   WHERE ( CODE_TYPE = 'CT' ) AND  
         ( CODE_CODE = Upper( :sle_category.text ) ) 
   USING stars2ca  ;

If stars2ca.of_check_status() <> 0 then
    if stars2ca.sqlcode = 100 then
       //sqlcmd('rollback',stars2ca,'Error performing commit on database',1) 
		 STARS2CA.of_rollback()																// FDG 02/20/01
        if sle_categ_desc.text = '' then
          messagebox('INFORMATION', 'Please enter the category description for new category')
          setfocus(sle_categ_desc)
			 setmicrohelp(w_main,'Ready')
          return
       else
          lv_categ_desc = sle_categ_desc.text
       end if
    else
         SetMicroHelp(w_main,'Error Retrieving Category Code Description')
         errorbox(stars2ca,'Error retrieving category code, record not added')
			STARS2CA.of_rollback()																// FDG 02/20/01
         setfocus(uo_1)  //09-28-95 FNC
         return
    end if
else
   sle_categ_desc.text = lv_categ_desc 
	COMMIT USING STARS2CA;
end if

// Reset the description in case the actual descriptin for the category
// is different than what is currently displayed

Select col_name
Into :lv_new_tbl_name
From Stars_win_parm
Where Win_id = 'W_CATEG_LIST_MAINTAIN' and tbl_type = Upper( :iv_invoice_type )
Using Stars2ca;
If stars2ca.of_check_status() <> 0 Then
   MessageBox('ERROR','Unable to retrieve from the Stars Win Parm Table Where Win_id = w_categ_list_maintain and tbl_type = ' + iv_invoice_type)
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	setmicrohelp(w_main,'Ready')
   Return
End If

lv_SQL_insert = 'INSERT INTO ' + lv_new_tbl_name &
              + ' ( PERIOD, CATG_ID, CATG_PROC ) VALUES (' &
              + STRING(in_period) + ',~'' + sle_category.text &
              + '~',~'' + sle_procedure.text + '~'' + ')'
				  
//	09/10/02	GaryR	Track 3468d - Begin
//EXECUTE IMMEDIATE :lv_SQL_insert using Stars1ca;

If gc_debug_mode = True Then
   clipboard(lv_SQL_insert)
   f_debug_box('Debug','w_categ_list_maintain.cb_add insert = ' + lv_SQL_insert)
End If

//If stars1ca.of_check_status() <> 0 then
IF Stars2ca.of_execute( lv_sql_insert ) <> 0 THEN
//	09/10/02	GaryR	Track 3468d - End	
	// FDG 12/04/00 - Remove dup insert checking (its already checked for).
//   If stars1ca.sqldbcode = gv_sql_dup or stars1ca.sqldbcode = gv_sql_dup2 Then
//	   SetMicroHelp(w_main,'Add Cancelled')
//		COMMIT using STARS2CA;
//		If stars2ca.of_check_status() <> 0 Then
//			Messagebox('EDIT','Error Commiting to Stars2')
//			Return
//		End If	
//      errorbox(stars1ca,'Error adding period/category/procedure, Add Cancelled')
//	   setfocus(uo_1)  //09-28-95 FNC
//      RETURN
//   else
//	   SetMicroHelp(w_main,'Error adding to the Catg Procedure Table, Retrieve Cancelled')
//		COMMIT using STARS2CA;
//		If stars2ca.of_check_status() <> 0 Then
//			Messagebox('EDIT','Error Commiting to Stars2')
//			Return
//		End If	
//      errorbox(stars1ca,'Error adding period/category/procedure, Add Cancelled')
//	   setfocus(uo_1)  //09-28-95 FNC
// 	   RETURN
//   end if
	SetMicroHelp(w_main,'Error adding to the Catg Procedure Table, Retrieve Cancelled')
	setfocus(uo_1)  //09-28-95 FNC
 	RETURN
end if

  INSERT INTO CODE  
         ( CODE_TYPE,   
           CODE_CODE,   
           CODE_DESC,   
           CODE_VALUE_A,   
           CODE_VALUE_N )  
  VALUES ( 'CT',   
           :sle_category.text,  
           :lv_categ_desc,   
           ' ',  
           0 )
           USING STARS2CA ;

If stars2ca.of_check_status() <> 0 then
	// FDG 12/04/00 - Remove dup insert checking (its already checked for).
//   If stars2ca.sqldbcode <> gv_sql_dup and stars2ca.sqldbcode <> gv_sql_dup2 Then
//	   SetMicroHelp(w_main,'Error adding to the Code Table, Retrieve Cancelled')
//      sqlcmd('Rollback',stars1ca,'Error performing rollback on the stars1ca database',1)   
//      errorbox(stars2ca,'Error adding period/category/procedure, Add Cancelled')
//	   setfocus(uo_1)  //09-28-95 FNC
//	   RETURN
//   End If
	SetMicroHelp(w_main,'Error adding to the Code Table, Retrieve Cancelled')
	setfocus(uo_1)  //09-28-95 FNC
	Return
End if

//	09/10/02	GaryR	Track 3468d - Begin
//COMMIT USING STARS1CA;
//COMMIT USING STARS2CA;
Stars2ca.of_commit()
//	09/10/02	GaryR	Track 3468d - End

dw_1.taborder = 50
Insertrow(dw_1,0)
lv_pos = (integer(st_row_count.text) + 1)
//lv_period = long(sle_period.text)
st_row_count.text = string(lv_pos)
//in_period = lv_period				//09-25-96 FNC
in_category = sle_category.text
in_procedure = sle_procedure.text
//04-24-94 FNC Shifted cols to allow for categ desc
setitem(dw_1,lv_pos,1,in_period)
setitem(dw_1,lv_pos,2,sle_category.text)
setitem(dw_1,lv_pos,3,lv_categ_desc)
setitem(dw_1,lv_pos,4,sle_procedure.text)
setitem(dw_1,lv_pos,5,lv_proc_desc)
selectrow(dw_1,0,false)
selectrow(dw_1,lv_pos,true)
setrow(dw_1,lv_pos)
scrolltorow(dw_1,lv_pos)

sle_procedure.text = ''
cb_add.default = true

setpointer(arrow!)
setmicrohelp(w_main,'Add Completed')
end event

type cb_list from u_cb within w_categ_list_maintain
string accessiblename = "List"
string accessibledescription = "List"
integer x = 384
integer y = 1412
integer width = 256
integer height = 108
integer taborder = 70
string text = "&List"
boolean default = true
end type

event clicked;//*******************************************************************
//	09-28-95 FNC	Prob #1094 Stars30 Change period from radio buttons
//             	to a ddlb
//	09-25-96 FNC	Prob #180 STARSENH Add proc code to list parameters
//	02/20/01	FDG	Stars 4.7 - remove SQLCMD
//	05/01/01	GaryR	Stars 4.7 DataBase Port - Eliminate view CODE_DESC
//	10/31/01	FDG	Track 2491d.  Since SQL combine single and double-quotes,
//						use dot notation instead of Modify  
//						Use stars2ca instead of stars1ca
//	09/10/02	GaryR	Track 3468d	Eliminate CATG_PROC view reference in Stars1
//*******************************************************************
Long lv_nbr_rows 
int rc, lv_pos, lv_len
string lv_new_sql, lv_new_tbl_name
string lv_categ_desc  
long lv_test, ll_test

setpointer(hourglass!) 
SetMicroHelp(W_Main,'Listing All Procedures in the Category Specified')	

//dw_1.Modify('Datawindow.Table.Select="'+is_old_select1+'"')		// FDG 10/31/01
//dw_1.object.Datawindow.Table.Select	=	is_old_select1					// FDG 10/31/01
Reset(DW_1)
SetTransObject(DW_1,stars2ca) 												// FDG 10/31/01
wf_set_table_name(dw_1)

in_period = uo_1.uf_return_period()
ll_test = in_period

//09-25-96 FNC Add proc code to retrieval arguments
lv_nbr_rows = Retrieve(dw_1,sle_category.text+'%', in_period, sle_procedure.text+'%')

st_row_count.text = string(lv_nbr_rows)

/*Checks to see if there is no data in the table*/
If lv_nbr_rows = 0 Then
	//	09/10/02	GaryR	Track 3468d - Begin
	//	COMMIT using STARS1CA;
	//	If stars1ca.of_check_status() <> 0 Then
	//		Messagebox('EDIT','Error Commiting to Stars2')
	//		Return
	//	End If
	//	09/10/02	GaryR	Track 3468d - End
	
	SetMicroHelp(w_main,'Search Cancelled')
   messagebox('NO DATA','No data for that search criteria',INFORMATION!,OK!)
   setfocus(sle_category)
	dw_1.taborder = 0
   return
end if 

if sle_category.text <> '' then
	//	05/01/01	GaryR	Stars 4.7 DataBase Port
   SELECT CODE_DESC   
      INTO :lv_categ_desc  
      FROM CODE
      WHERE ( CODE_TYPE = 'CT' ) AND  
            ( CODE_CODE = Upper( :sle_category.text ) ) 
   USING stars2ca  ;

   if stars2ca.of_check_status() <> 0 then
       //sqlcmd('rollback',stars1ca,'Error performing commit the database',1) 
		 STARS2CA.of_rollback()																// FDG 02/20/01
       setfocus(uo_1) //09-28-95 FNC
   else
       sle_categ_desc.text = lv_categ_desc
   end if
end if

SetMicroHelp(w_main,'Ready')

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	
end event

type st_add_proc from statictext within w_categ_list_maintain
string accessiblename = "Procedure"
string accessibledescription = "Procedure"
accessiblerole accessiblerole = statictextrole!
integer x = 2235
integer y = 24
integer width = 325
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Procedure:"
boolean focusrectangle = false
end type

type st_category from statictext within w_categ_list_maintain
string accessiblename = "Category"
string accessibledescription = "Category"
accessiblerole accessiblerole = statictextrole!
integer x = 1842
integer y = 24
integer width = 293
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Category:"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_categ_list_maintain
string tag = "CRYSTAL, title = Category/Procedure List"
string accessiblename = "Category Procedure List"
string accessibledescription = "d_categ_list_maintain"
integer x = 9
integer y = 416
integer width = 2683
integer height = 960
integer taborder = 60
string dataobject = "d_categ_list_maintain"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;//***************************************************************
// 09-25-96 FNC	Set in_period = to il_period in user object
//***************************************************************
/*Clicked for data window 1*/
string test
int row_nbr,clicked_row
/*Sets select to enabled when clicked*/
cb_delete.enabled = true
cb_delete.default = true

/*gets the row and makes sure a row was clicked*/
row_nbr = getrow(dw_1)
// FDG 01/17/02 Track 2699d.  If no rows exist, get out
If row_nbr = 0 			&
or	This.RowCount()	<	1	then 
   cb_delete.enabled = false
	return
end if

/*Highlights the selected row*/
SelectRow(dw_1,0,FALSE)
SelectRow(dw_1,row_nbr,TRUE)
/*Loads the selected rows keys into the instance variables*/
in_period = uo_1.uf_return_period()			//09-25-96 FNC
in_category = GetItemString(dw_1,row_nbr,2)
in_procedure = GetItemString(dw_1,row_nbr,4)

end event

on retrieveend;//w_categ_list_maintain.controlmenu = TRUE
cb_stop.enabled = FALSE


gv_cancel_but_clicked = TRUE

end on

on retrievestart;setpointer(hourglass!)

gv_cancel_but_clicked = FALSE

end on

event constructor;call super::constructor;// FDG 11/17/00 - Stars 4.7.  Change the d/w object name for the appropriate DBMS
This.of_set_dw_dbms()

end event

