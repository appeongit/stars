HA$PBExportHeader$w_norm_provider_list.srw
$PBExportComments$Inherited from w_parent_rpt
forward
global type w_norm_provider_list from w_parent_rpt
end type
type st_dw_ops from statictext within w_norm_provider_list
end type
end forward

global type w_norm_provider_list from w_parent_rpt
long backcolor = 67108864
string accessiblename = "Norm Analysis Provider Report"
string accessibledescription = " Norm Analysis Provider Report"
accessiblerole accessiblerole = windowrole!
string title = "Norm Analysis Provider Report"
event ue_view_detail ( )
st_dw_ops st_dw_ops
end type
global w_norm_provider_list w_norm_provider_list

type variables
string in_prov,in_proc_code,in_spec
int in_first
string iv_proc_mod//,iv_invoice_type
boolean in_open_event
datetime id_from, id_thru, id_payment_from, id_payment_thru
String parm
String	is_table_desc
sx_norm_rpt_parms isx_norm_rpt_parms

end variables

forward prototypes
public function string build_prov ()
end prototypes

event ue_view_detail();///////////////////////////////////////////////////////////
//	Script:	ue_view_detail
//
//	Description:
//		This event is triggered from cb_view_detail and will
//		open the query engine window
//	01/29/02	LahuS	Track 2552d	Predefined Report (PDR)
//
///////////////////////////////////////////////////////////

String	ls_rc

SetPointer (Hourglass!)

// Clear out query parms from previous attempts
inv_queryengine.uf_clear_query_parms()

//	Save the invoice type, tbl_type & src type for query engine
inv_queryengine.uf_set_invoice_type(iv_invoice_type)
inv_queryengine.uf_set_tbl_type(iv_invoice_type)
inv_queryengine.uf_set_tbl_rel('GP')
inv_queryengine.uf_set_src_type(in_detail_struct.src_type)
inv_queryengine.uf_set_rpt_title('Claim Report - ' + is_table_desc)


gv_active_invoice = iv_invoice_type

ls_rc = build_prov()

IF	ls_rc	=	'ERROR'	THEN
	Return
END IF

//	01/29/02	Lahu S	Track 2552d
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	open the query engine window
inv_queryengine.uf_open_query_engine()

end event

public function string build_prov ();//**********************************************************************
// 04/20/99  FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
// 07-30-98 ajs   Stars 4.0 - Track 1522.  Pass period key to QE if present.
// 07-08-98 JGG	Stars 4.0 - Track 1486.  Pass 4 digit years to Query Engine.
//	01-12-98	FDG	Stars 4.0 - Build the SQL for w_query_engine
//	06-18-97 FNC	FS/TS150 allow drilldown against any table type. 
//						Fix date check logic
// 09-18-96 FNC	STARS35 Prob #45 Check to see if id_from is null. 
//						If it is do not include it in the where statement. 
//						Id_from is retrieved from the period_cntl table.
//	12/14/00	FDG	Make the handling of dates DBMS-independent
//	10/25/01	GaryR	Track 2487d	Null dates are 1/1/1900
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//**********************************************************************


string lv_prov,lv_get_prov,lv_clear_array[]
long next_selected_row,selected_row
string lv_crit,select_prov,lv_period
String	ls_from_date,			&
			ls_thru_date,			&
			ls_pay_from_date,		&
			ls_pay_thru_date
//string parm
datetime ld_min_from
datetime ld_max_thru
Int	li_rc, li_index = 1			// FDG 01/12/98
int lv_first = 1
DateTime	ldt_default					//	10/25/01	GaryR	Track 2487d
n_cst_decode	lnv_decode

setpointer(hourglass!)

//*****************************************************//
// check to be sure claims data exists for this period //
//*****************************************************//

li_rc	=	inv_queryengine.uf_get_min_max_date (ld_min_from, ld_max_thru)

IF	li_rc	<	0		THEN
	MessageBox('Error', 'Error checking for claims data')
	Return 'ERROR'
END IF

//	Clear the query parm from previous attempts
inv_queryengine.uf_clear_query_parms()

//06-18-97 FNC 
if id_payment_thru < ld_min_from or id_payment_from > ld_max_thru then
	MessageBox('Claims Check', 'No claims data exists for payment dates ' + &
					string(date(id_payment_from), "mm/dd/yyyy") + ',' + &
					string(date(id_payment_thru), "mm/dd/yyyy"), StopSign!)
//07-08-98 JGG: end
	Return 'ERROR'
end if

do
	next_selected_row = GetSelectedRow(dw_1,selected_row)
	if next_selected_row = 0 then 
		exit
	end if
	lv_get_prov = trim(getitemstring(dw_1,next_selected_row,'prov_id'))

	//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
	IF lnv_decode.of_is_decoded( dw_1, "prov_id" ) THEN
		lnv_decode.of_remove_desc( lv_get_prov )
	END IF
	
	if lv_first = 1 then
		lv_prov = lv_get_prov
	else
		lv_prov = lv_prov+','+lv_get_prov
	end if
	selected_row = next_selected_row
	lv_first = lv_first + 1
loop until next_selected_row = 0

//This fills the structure//
in_detail_struct.src_type = 'SB'
in_detail_struct.period = in_period

select_prov = format_where(lv_prov,'IN','')

// FDG 12/14/00 - Make dates in where clause DBMS-independent
ls_pay_from_date	=	string(date(id_payment_from), "mm/dd/yyyy")
ls_pay_from_date	=	gnv_sql.of_get_to_date (ls_pay_from_date)
ls_pay_thru_date	=	string(date(id_payment_thru), "mm/dd/yyyy")
ls_pay_thru_date	=	gnv_sql.of_get_to_date (ls_pay_thru_date)
ls_from_date		=	string(date(id_from), "mm/dd/yyyy")
ls_from_date		=	gnv_sql.of_get_to_date (ls_from_date)
ls_thru_date		=	string(date(id_thru), "mm/dd/yyyy")
ls_thru_date		=	gnv_sql.of_get_to_date (ls_thru_date)

//	10/25/01	GaryR	Track 2487d
if ( IsNull(id_from) OR id_from = ldt_default ) AND ( IsNull(id_thru) OR id_thru = ldt_default ) then
	lv_period = ' AND '+in_detail_struct.table_type[1]+'.PAYMENT_DATE BETWEEN ' + &
					ls_pay_from_date	+	' AND '  + 	ls_pay_thru_date
else
	// FDG 12/14/00 - Make dates in where clause DBMS-independent
	lv_period = ' AND '+in_detail_struct.table_type[1]+'.FROM_DATE BETWEEN ' + &
					ls_from_date	+	' AND ' + ls_thru_date	+	' AND ' + &
					in_detail_struct.table_type[1]+'.PAYMENT_DATE BETWEEN ' + &
					ls_pay_from_date	+	' AND ' + ls_pay_thru_date
end if
//09-18-96 FNC End

in_detail_struct.where_statement = ' WHERE '+in_detail_struct.table_type[1]+&
	'.PROC_CODE = '+'~''+in_exp2[1]+'~''+ ' and '+&
	in_detail_struct.table_type[1]+'.PROV_SPEC = '+&
	'~''+in_exp2[2]+'~''+ ' AND '+in_detail_struct.table_type[1]+&
	'.PROV_ID IN '+select_prov+lv_period

//Norms with proc mod
if trim(iv_proc_mod)<>'' then	
	in_detail_struct.where_statement=in_detail_struct.where_statement + &
	" AND ("+in_detail_struct.table_type[1]+".PROC_MODIFIER_1 = '" + &
	iv_proc_mod+"' OR "+in_detail_struct.table_type[1] + &
	".PROC_MODIFIER_2 = '"+iv_proc_mod+"')"
end if

inv_queryengine.uf_load_where (in_left_paren[1], '', in_exp1[1], &
										in_op[1], in_exp2[1], in_right_paren[1], &
										in_logic[1], li_index)
inv_queryengine.uf_load_where (in_left_paren[2], '', in_exp1[2], &
										in_op[2], in_exp2[2], in_right_paren[2], &
										in_logic[2], li_index)
inv_queryengine.uf_load_where (in_left_paren[3], in_detail_struct.table_type[1], 'PROV_ID', &
										'IN', lv_prov, in_right_paren[3], &
										'AND', li_index)
If isx_norm_rpt_parms.l_period_key > 0 then			// FNC 04/20/99
	//period will be passed to qe thru uf_set_period_id
	inv_queryengine.uf_set_period_key(int(isx_norm_rpt_parms.l_period_key))			//ajs 4.0 07/20/98 Pass period key to QE
																											// FNC 04/20/99
	inv_queryengine.uf_set_period_function('NORM')					//ajs 4.0 07/20/98 Pass period key to QE
else
	// FDG 12/14/00 - The dates passed to Query Engine will be made DBMS-independent
	//	within Query Engine
	inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], 'PAYMENT_DATE', &
											'BETWEEN', string(date(id_payment_from), "mm/dd/yyyy") + &
											',' + string(date(id_payment_thru), "mm/dd/yyyy"), &
											'', 'AND', li_index)
	//	10/25/01	GaryR	Track 2487d
	//if not IsNull(id_from) then
	if not ( ( IsNull(id_from) OR id_from = ldt_default ) AND ( IsNull(id_thru) OR id_thru = ldt_default ) ) then	
		// FDG 12/14/00 - The dates passed to Query Engine will be made DBMS-independent
		//	within Query Engine
		inv_queryengine.uf_load_where ('', in_detail_struct.table_type[1], 'FROM_DATE', &
											'BETWEEN', string(date(id_from), "mm/dd/yyyy") + &
											','+string(date(id_thru), "mm/dd/yyyy"), &
											'', '', li_index)
	end if
end if
return 'OK'
end function

event open;//*************************************************************
//	Script:	Open	-	Override the ancestor
// 
//	Description:
//
//*************************************************************
//09-12-95 FNC Prob 664 Starcare Change JUN to JULY in heading
//             for period 02
//07-17-97 FDG Since this event overrides w_parent_rpt.open,
//					execute w_master.open
//01-12-98 FDG	Stars 4.0 - Use the query engine service
//03-11-98 FDG Stars 4.0 Track 877 - Remove references to cb_subset
//04/20/99 FNC	FS/TS2239 Starcare track 2239. Replace global period
//					variables with variables in a structure
//03/18/01 FDG	Stars 4.7.  Store period key for future use.  Also,
//					don't call fx_get_specific_table because it is used
//					to access ros_directory.
//*************************************************************

string  lv_sel,header,lv_clear_array[],ls_desc
integer len_in_what, lv_position,lv_pos, li_rc

isx_norm_rpt_parms = Message.PowerObjectParm		// FNC 04/20/99
SetNull(Message.PowerObjectParm)						// FNC 04/20/99


Call	w_master::Open				//	FDG	07/17/97

iv_invoice_type = isx_norm_rpt_parms.s_invoice_type
iv_proc_mod = isx_norm_rpt_parms.s_proc_mod

// FNC 04/20/99 End

select elem_desc into :is_table_desc
from dictionary 
where elem_tbl_type = Upper( :iv_invoice_type ) and
		elem_type = 'TB' 
using stars2ca;

Stars2ca.of_check_status()

//Norms with proc mod
in_detail_struct.table_type[1] = iv_invoice_type
in_detail_struct.src_type = 'SB'
in_detail_struct.period = isx_norm_rpt_parms.l_period		// FNC 04/20/99
in_detail_struct.invoice_type = iv_invoice_type

// FDG 03/18/01 begin
//in_detail_struct.tbl_directory[] = lv_clear_array[]
//li_rc = fx_get_specific_table(gv_sys_dflt,in_detail_struct.period,'','', &
//			in_detail_struct.tbl_directory,isx_norm_rpt_parms.l_period_key)	// FNC 04/20/99
//if li_rc = -1 then return 
il_period_key	=	isx_norm_rpt_parms.l_period_key
// FDG 03/18/01 end

in_transaction_object = stars1ca
This.of_SetTransaction(Stars1ca)			//	FDG	07/17/97

//*******************//
// set report header //
//*******************//

SELECT period_desc,
       from_date,
       thru_date,
       payment_from_date,
       payment_thru_date
  INTO :ls_desc,
       :id_from,
       :id_thru,
       :id_payment_from,
       :id_payment_thru
  FROM period_cntl
 WHERE period_key = :isx_norm_rpt_parms.l_period_key
 USING stars2ca;

if stars2ca.of_check_status() = -1 then
	Rollback using stars2ca;
	MessageBox('Error', 'Error selecting description from period_cntl')
	Return
else
	Commit using stars2ca;
end if

in_header = '~''+'Norm Provider List~n '+ls_desc+'~''

in_columns_selected = '5-7-8-10-Total # of Srvc\9-# Srvc/1000 Bene\9-'
lv_sel = dw_1.GetSqlSelect()

//sqlcmd('connect', stars2ca, '', 5)         PLB 10/20/95

in_what = fx_get_table('w_norm_provider_list', 'open', iv_invoice_type)
//HRB 7/23/95 prob#695 - check return code
if in_what='ERROR' then return


COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

in_table_type = mid(in_what,1,2)
len_in_what = len(in_what) - 2
in_what       = mid(in_what,3,len_in_what)

If gc_debug_mode then
   messagebox('last in_what', in_what)
   messagebox('in_table_type', in_table_type)
   messagebox('first lv_sel', lv_sel)
End If

lv_position = pos(lv_sel,' FROM ')
lv_sel = replace(lv_sel, lv_position, len(lv_sel), ' FROM ' + in_what)

If gc_debug_mode then
   messagebox('second lv_sel', lv_sel)
End If

in_open_event = TRUE
in_sql = lv_sel + gv_stack1
in_create = FALSE
in_table_type = 'SD'
in_proc_code = split(gv_selection1,'L','-')
in_spec = split(gv_selection1,'R','-')

call w_parent_rpt::open 

//	Make sure that of_set_queryengine is called after w_parent_rpt::open
//	because w_parent_rpt.fw_variable_load needs the data stored
//	in global variables (i.e. gv_exp1).  These globals are cleared
// out in in inv_queryengine.constructor event.
This.of_set_queryengine (TRUE)	//	FDG	01/12/98

if gv_rc <> -1 then
	w_norm_rpt.sle_count.text = string(in_row_count)
end if
end event

on w_norm_provider_list.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
end on

on w_norm_provider_list.destroy
call super::destroy
destroy(this.st_dw_ops)
end on

event ue_preopen;//*****************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure. Move
//						script to open to avoid setting the structure to nulls
//*****************************************************************

// FNC 04/20/99 Start
//parm=message.stringparm
//SetNull(message.stringparm)

// FNC 04/20/99 End
end event

type ddlb_dw_ops from w_parent_rpt`ddlb_dw_ops within w_norm_provider_list
integer x = 73
integer y = 1344
integer taborder = 20
end type

type cb_clear from w_parent_rpt`cb_clear within w_norm_provider_list
integer x = 1861
integer width = 338
string text = "C&lear"
end type

type st_1 from w_parent_rpt`st_1 within w_norm_provider_list
end type

type cb_save_report from w_parent_rpt`cb_save_report within w_norm_provider_list
end type

on cb_save_report::clicked;in_save_name = 'norm provider list dw'
call w_parent_rpt`cb_save_report::clicked
end on

type sle_count from w_parent_rpt`sle_count within w_norm_provider_list
integer x = 64
integer width = 274
integer height = 92
integer taborder = 0
end type

type cb_stop from w_parent_rpt`cb_stop within w_norm_provider_list
integer taborder = 60
end type

type mle_crit from w_parent_rpt`mle_crit within w_norm_provider_list
end type

type cb_query from w_parent_rpt`cb_query within w_norm_provider_list
integer x = 434
integer width = 338
end type

on cb_query::clicked;string ls_rc

gv_active_invoice = iv_invoice_type

ls_rc = build_prov()
in_going_to_claim = TRUE

if ls_rc = 'ERROR' then return

call w_parent_rpt`cb_query::clicked
end on

type cb_view_detail from w_parent_rpt`cb_view_detail within w_norm_provider_list
integer x = 869
integer width = 462
integer taborder = 50
string text = "&View Data..."
end type

event cb_view_detail::clicked;call super::clicked;Parent.Event	ue_view_detail()

end event

type cb_close from w_parent_rpt`cb_close within w_norm_provider_list
integer x = 2295
integer width = 338
end type

on cb_close::clicked;call w_parent_rpt`cb_close::clicked;//close(w_claim_rpt_mb)
//close(w_claim_view)
//close(w_header_rpt)
//close(w_line_rpt)
end on

type dw_1 from w_parent_rpt`dw_1 within w_norm_provider_list
string tag = "CRYSTAL, title = Provider List"
integer y = 428
integer height = 828
string dataobject = "d_norm_provider_list"
end type

event dw_1::clicked;call super::clicked;// THIS SCRIPT HANDLES THE SELECTION OR DE-SELECTION OF ROWS
// IN THE DATAWINDOW.  VARIOUS BUTTONS ARE TURNED ON OR OFF BASED
// ON THE NUMBER OF SELECTED ROWS.  SELECTED ROWS ARE LIMITED TO 10.
// ajs 01-20-99 FS1886d 4.1 Act like window is open id open & visible.

int row_nbr 
row_nbr = row

//ajs 01-20-99 begin
if isvalid(iv_uo_win) Then
	if iv_uo_win.visible then
		return
	end if
end If
//ajs 01-20-99 end

cb_view_detail.enabled = TRUE
cb_query.enabled = TRUE
cb_clear.enabled = TRUE

if row_nbr = 0 Then 
	cb_view_detail.enabled = FALSE
	cb_query.enabled = FALSE
	return
end if

if isSelected(dw_1,row_nbr) Then
	Selectrow(dw_1,row_nbr,FALSE)
	in_Num_rows_sel = in_Num_rows_sel - 1
else 
   if in_num_rows_sel >= 10 then
      Selectrow(dw_1,row_nbr,FALSE)
      MessageBox("Selection Error","You Have Selected The Maximum Number Of Rows (10)")
      // the following line to corrrect mouse error after popup window
      dw_1.Modify("datawindow.selected.mouse=no")
   else   
   	Selectrow(dw_1,row_nbr,TRUE)
	   in_Num_rows_sel = in_Num_rows_sel + 1
   end if
end if

if in_num_rows_sel <= 0 Then
	in_num_rows_sel = 0
	cb_view_detail.enabled = FALSE
   cb_query.enabled = FALSE
	cb_clear.enabled = FALSE
end if


end event

event dw_1::rowfocuschanged;in_row_nbr = getrow(dw_1)

If in_row_nbr = 0 Then 
	Return
end If

If in_row_nbr = 1 and in_open_event = TRUE Then
Else
	in_open_event = FALSE
End If
	
	
end event

on dw_1::retrieveend;in_button_not_modified[1] = cb_query
in_button_not_modified[2] = cb_view_detail
in_button_not_modified[3] = cb_clear
call w_parent_rpt `dw_1::retrieveend
end on

type st_dw_ops from statictext within w_norm_provider_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1268
integer width = 695
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

