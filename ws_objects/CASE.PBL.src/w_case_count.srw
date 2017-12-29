$PBExportHeader$w_case_count.srw
$PBExportComments$PopUp Window to give Counts for Case (Inherited from w_master)
forward
global type w_case_count from w_master
end type
type cb_print from u_cb within w_case_count
end type
type dw_1 from u_dw within w_case_count
end type
type st_row_count from statictext within w_case_count
end type
type cb_close from u_cb within w_case_count
end type
end forward

global type w_case_count from w_master
string accessiblename = "Case Counts"
string accessibledescription = "Case Counts"
accessiblerole accessiblerole = windowrole!
integer x = 677
integer y = 276
integer width = 1545
integer height = 1072
string title = "Case Counts"
windowtype windowtype = popup!
long backcolor = 67108864
cb_print cb_print
dw_1 dw_1
st_row_count st_row_count
cb_close cb_close
end type
global w_case_count w_case_count

type variables
// Parm sent to this window
String	is_parm
end variables

event open;call super::open;//*******************************************************************
// DKG 01/25/96   Re-wrote d_case_count to take the times off the
//                group by. Added the IF statement to this code 
//                because there was no group by on new d_case_count.
//                PROB 50 Stars 3.1 Release disk.
//
// DKG 02/05/96   Added SQL to get correct count for st_row_count.
//                Could not do a row count because above change	
//                required a strange solution in the DW. PROBS 50,141
//                Stars 3.1 Release disk.
//
// DKG 02/14/96   Re-wrote above step to correct error with count.
// 09/01/98 AJS   FS362 convert case to case_cntl
//	01/13/99 NLG	TS2002c If counting by receive date with empty datawindow
//						list, was causing sql error.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//	05/15/03	GaryR	Track 3577d	Remove the times when totaling by recieve date.
//	12/08/03	GaryR	Track 3726d	Database error when joining to CASE_LOG
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//*******************************************************************		 

String lv_column_name, ls_parms[]
string ls_sql, lv_new_str

n_cst_sqlattrib	lstr_sql[]
n_cst_string	lnv_string

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

ls_parms[] = lnv_string.of_stringtoarray( is_parm , "~~" )
IF UpperBound( ls_parms ) <> 3 THEN
	MessageBox( "ERROR","Invalid number of parameters passed to Case Count.", StopSign! )
	Return
END IF

lv_new_str = ls_parms[1]
lv_column_name = "'" + ls_parms[2] + "'"
ls_sql = ls_parms[3]

//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)

If lv_new_str = 'CASE_DATE_RECV' then
	DW_1.DATAOBJECT = 'd_case_count'
	lv_new_str = "CASE_CNTL." + lv_new_str
	gnv_sql.of_remove_time( lv_new_str )
Else
	lv_new_str = "CASE_CNTL." + lv_new_str
	dw_1.MODIFY('case_cat_t.text = ' + lv_column_name)
End IF

//	Build the SQL to count
gnv_sql.of_parse( ls_sql, lstr_sql[] )
lstr_sql[1].s_columns = lv_new_str + ", count(" + lv_new_str + ")"
lstr_sql[1].s_group = lv_new_str

//	Set SQL to the Datawindow
ls_sql = gnv_sql.of_assemble( lstr_sql )

If gc_debug_mode = true then f_debug_box("Debug",ls_sql)

dw_1.setsqlselect(ls_sql)

If SetTransObject(dw_1,stars2ca) < 0 then
	Messagebox('ERROR','Unable to Set Transaction Object')
	RETURN
End If

st_row_count.text = string(RETRIEVE(DW_1))
If LONG(st_row_count.text) < 0 then
	If stars2ca.of_commit() <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	Messagebox('ERROR','Unable to Retrieve from Database')
	RETURN
End If

If stars2ca.of_commit() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If
end event

on w_case_count.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.dw_1=create dw_1
this.st_row_count=create st_row_count
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_row_count
this.Control[iCurrent+4]=this.cb_close
end on

on w_case_count.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.dw_1)
destroy(this.st_row_count)
destroy(this.cb_close)
end on

event ue_preopen;call super::ue_preopen;is_parm	=	Message.Stringparm
end event

type cb_print from u_cb within w_case_count
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 750
integer y = 840
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Print"
end type

on clicked;setpointer(Hourglass!)
setmicrohelp(w_main,'Printing')
print(dw_1)
setmicrohelp(w_main,'Ready')
end on

type dw_1 from u_dw within w_case_count
string accessiblename = "Case Count"
string accessibledescription = "Case Count"
accessiblerole accessiblerole = clientrole!
string tag = "CRYSTAL, title =Case Counts"
integer x = 5
integer width = 1477
integer height = 812
integer taborder = 10
string dataobject = "d_case_count_1"
boolean hscrollbar = true
boolean vscrollbar = true
end type

on retrievestart;setpointer(hourglass!)
end on

type st_row_count from statictext within w_case_count
string accessiblename = "Count"
string accessibledescription = "Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 9
integer y = 856
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_case_count
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1134
integer y = 840
integer width = 338
integer height = 108
integer taborder = 20
string text = "&Close"
boolean default = true
end type

on clicked;setmicrohelp(w_main,'Ready')
setpointer(hourglass!)
close(parent)

end on

