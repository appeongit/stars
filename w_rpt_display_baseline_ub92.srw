HA$PBExportHeader$w_rpt_display_baseline_ub92.srw
$PBExportComments$Inherited from w_master
forward
global type w_rpt_display_baseline_ub92 from w_master
end type
type st_row_count from statictext within w_rpt_display_baseline_ub92
end type
type st_dw_ops from statictext within w_rpt_display_baseline_ub92
end type
type ddlb_dw_ops from dropdownlistbox within w_rpt_display_baseline_ub92
end type
type cb_1 from commandbutton within w_rpt_display_baseline_ub92
end type
type dw_1 from u_dw within w_rpt_display_baseline_ub92
end type
end forward

global type w_rpt_display_baseline_ub92 from w_master
string accessiblename = "Standard Analysis Report Display"
string accessibledescription = "Standard Analysis Report Display"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 4
integer width = 2743
integer height = 1676
string title = "Standard Analysis Report Display"
long backcolor = 67108864
st_row_count st_row_count
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
cb_1 cb_1
dw_1 dw_1
end type
global w_rpt_display_baseline_ub92 w_rpt_display_baseline_ub92

type variables
string in_limit,in_select,in_specialty
string iv_invoice_type
string iv_new_table_name
sx_baseln_rpt_ub92 in_parms

w_uo_win iv_uo_win
string in_selected
string in_dw_control
sx_decode_structure in_decode_struct
string iv_col_names[]


end variables

forward prototypes
public function integer update_where_specialty ()
public function integer wf_find_width (string cname, string tname, string ctype)
public function integer update_where_limit ()
public subroutine wf_set_attr ()
end prototypes

public function integer update_where_specialty ();string lv_select,lv_select_stmt,lv_in,spec[20],lv_order_by
integer spec_nbr,lv_pos,index,rc

lv_select_stmt = UPPER(dw_1.getsqlselect()) 
lv_pos = pos(lv_select_stmt,"ORDER")
if lv_pos > 0 then
    lv_select  = Mid(lv_select_stmt,1,lv_pos - 1)
    lv_order_by  = Mid(lv_select_stmt,lv_pos)
else
    lv_select = lv_select_stmt
end if

lv_pos = pos(in_specialty,",")

//If only one specialty
if lv_pos = 0 then
    in_select = lv_select + " AND " +  iv_new_table_name + ".CODE1 = '" + in_specialty + &
                "'" + lv_order_by
    return 0
end if

//If multiple specialties must construct IN clause
spec_nbr = 1
Do until in_specialty = ''
    if spec_nbr > 20 then
       exit
    end if
    if (lv_pos <> 0) then
       spec[spec_nbr] = Mid(in_specialty,1,lv_pos - 1)
       in_specialty = Mid(in_specialty,lv_pos + 1)
       lv_pos = pos(in_specialty,",")
       spec_nbr = spec_nbr + 1
   else
       spec[spec_nbr] = in_specialty
       in_specialty = ''
   end if   
Loop

index = 1
lv_in =  " AND " + iv_new_table_name + ".CODE1 IN ('" + spec[index] + "'"
index = 2 
do while index <= spec_nbr
   lv_in =  lv_in + ",'" + spec[index] + "'"
   index = index + 1
loop
 
in_select = lv_select + lv_in + ")" + lv_order_by
return 0   
end function

public function integer wf_find_width (string cname, string tname, string ctype);Int paren_position1,paren_position2,col_length,label_length,computed_length
Int length_of_datatype,char_pos,lv_width
String length_of_data,lv_data_name,rs
label_length = len(cname)
paren_position1 = Pos(tname,'(')
paren_position2 = Pos(tname,')')
length_of_datatype = (paren_position2 - paren_position1) - 1  

paren_position1 = paren_position1 + 1
length_Of_data = Mid(tname,paren_position1,length_of_datatype)
If upper(ctype) = 'CHAR' Then 
	if label_length > Integer(length_of_data) Then 
		lv_width = label_length * 11
	Else 
		lv_width = Integer(length_of_data) * 11
	End If 
	rs=dw_1.Modify(cname+'_t.alignment=~''+'0'+'~'')
Else
	
	If label_length > Integer(length_of_data) Then
		lv_width = label_length * 10
	Else 
		lv_width = Integer(length_of_data) * 10
	End If
	rs=dw_1.Modify(cname+'_t.alignment=~''+'1'+'~'') 
End If
Return lv_width
end function

public function integer update_where_limit ();string lv_select,lv_select_stmt,lv_order_by
integer lv_pos

lv_select_stmt = UPPER(dw_1.getsqlselect())
lv_pos = pos(lv_select_stmt,"ORDER")
if lv_pos > 0 then
    lv_select  = Mid(lv_select_stmt,1,lv_pos - 1)
    lv_order_by  = Mid(lv_select_stmt,lv_pos)
else
    lv_select = lv_select_stmt
end if

in_select = lv_select + in_limit + lv_order_by

return 0   
end function

public subroutine wf_set_attr ();/////////////////////////////////////////////////////////////////////////////////////
// AJS   01/14/99 FS2033c Y2K change mm/dd/yy to mm/dd/yyyy
//	FDG	12/14/00	Stars 4.7.  Make the checking of data types DBMS-independent.
/////////////////////////////////////////////////////////////////////////////////////

string rs,cname,test_string,tname,ctype
Int n,lv_width,lv_pos
Long num_of_col,lc_font_height=-10,lc_font_weight=700

test_string = dw_1.Describe('datawindow.syntax')

num_of_col = long(dw_1.Describe('datawindow.column.count'))
//rs=dw_1.Modify('datawindow.header.height= 60')
rs=dw_1.Modify('datawindow.Print.Orientation= 1')
for n = 1 to num_of_col
	cname = dw_1.Describe('#'+string(n)+'.name')
	iv_col_names[n] = cname
	tname = dw_1.Describe('#'+string(n)+'.coltype')

	lv_pos  = pos(tname,'(')
	ctype = left(tname,lv_pos - 1)
//   if cname = 'chrgs_100_pats' then
//    	ctype = 'float'
//   end if 
	// FDG 12/14/00 - Make checking of data types DBMS-independent
	//CHOOSE CASE upper(ctype)
	//	CASE 'DECIMAL', 'FLOAT'
	//		Setformat(dw_1,n,'#,##0.00')
	//	CASE 'SMALLDATETIME', 'DATETIME', 'DATE'
	//		Setformat(dw_1,n,'mm/dd/yyyy')	//ajs 01/14/99
	//END CHOOSE
	IF	gnv_sql.of_is_money_data_type (ctype)	THEN
		Setformat(dw_1,n,'#,##0.00')
	ELSEIF gnv_sql.of_is_date_data_type (ctype)	THEN
		Setformat(dw_1,n,'mm/dd/yyyy')	//ajs 01/14/99
	END IF

   lv_width=wf_find_width(cname,tname,ctype)
//	If lv_width < 100 then lv_width = 100
//	rs=dw_1.Modify(cname+'_t.y=120')
	rs=dw_1.Modify(cname+'.Width=~''+string(lv_width)+'~'')
	rs=dw_1.Modify(cname+'.font.Height=~''+string(lc_font_height) +'~'')
	rs=dw_1.Modify(cname+'.font.Weight=~''+string(lc_font_weight) +'~'')
	rs=dw_1.Modify(cname+'.font.face="System"')
	rs=dw_1.Modify(cname+'_t.font.height=~'' +string(lc_font_height)+'~'')
	rs=dw_1.Modify(cname+'_t.font.weight=~'' +string(lc_font_weight)+'~'') 
	rs=dw_1.Modify(cname+'_t.font.face="System"')
	rs=dw_1.Modify(cname+'_t.font.underline=1')
	rs=dw_1.Modify(cname+'_t.border="4"')
	rs=dw_1.Modify(cname+'_t.height=~''+'32'+'~'')
//	rs=dw_1.Modify(cname+'_t.y=~''+'40'+'~'')
	
next

test_string = dw_1.Describe('datawindow.syntax')



end subroutine

event open;call super::open;//*************************************************************
//	08/02/95	FNC	SWAT effort to display win parm parameters 
//	05/20/94 FNC	Add specialty parameter for top 40 top 25 report
//	05/03/94 FNC	Add parameters for ranking 
//	04/12/96 DKG	Moved set colors function call to lower in the
//             	script. PROB 856 STARCARE disk.
//	03/24/98 FDG	Stars 4.0 Track 951.  Fix the SQL to separate
//						the "From" from the "WHERE".
//	04/20/00 KTB	STarcare Track 2494. Disable graph functionality.
//	11/20/00 FDG	Stars 4.7 - Make SQL DBMS-independent
//	04/09/04	GaryR	Track 6255c	Make LOJ work when EN_XREF = 0
//	08/06/08	GaryR	SPR 5407	Add a class to support MSS variations
//*************************************************************

int lv_nbr_rows,rc,parm_separator,lv_pos,lv_pos2,lv_len,lv_index
string lv_old_sql, lv_new_sql,lv_old_tbl_name,lv_new_tbl_name
string temp_select,stringrc,parms,lv_rank,lv_title
string lv_where, lv_select, lv_from1, lv_from2,lv_window_name
string mod_str, lv_color, style, ls_error, lv_select_sql
int lv_xref
String	ls_join_from,		&
			ls_join_where
Integer	li_pos

int lv_rank1,lv_rank2,lv_report
string lv_tob,lv_dw,lv_revexcl[],lv_fiscyear, lv_proc_year
long lv_period

string lv_parm, dw_name, lv_invoice_type
string 	ls_temp_where[]
string	ls_replaced_where
		
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

//User can specify a limit so must adjust title of report to reflect
//limit in addition If user running report Top 40 Providers Utilizing Top 25 Procedures
// can specify specialty and a limit so must separate them

//KMM 8/25/95 Load table type in out_parms structure (found in Alaska training)
lv_parm = w_main.iv_test
Parm_Separator = Pos(lv_parm,'~t')
if Parm_Separator = 0 then
	dw_name = lv_parm 
else
    dw_name = Mid(lv_parm,1,parm_separator - 1)
    lv_parm = Mid(lv_parm,parm_separator + 1)
end if
Parm_Separator = Pos(lv_parm,'~t')
If Parm_separator = 0 then
	lv_invoice_type = lv_parm				
Else
	lv_invoice_type = Mid(lv_parm,1,parm_separator - 1)
end if

  SELECT SYS_CNTL.CNTL_TEXT  
   INTO :lv_fiscyear  
   FROM SYS_CNTL  
   WHERE SYS_CNTL.CNTL_ID = 'FISCYEAR'   
  Using Stars2ca;

	Stars2ca.of_check_status()

   SELECT SYS_CNTL.CNTL_NO  
    INTO :lv_xref  
    FROM SYS_CNTL  
   WHERE SYS_CNTL.CNTL_ID = 'EN_XREF'   
  Using Stars2ca;

	Stars2ca.of_check_status()

Select col_name
Into :lv_new_tbl_name
From Stars_win_parm
Where cntl_id = Upper( :in_parms.dw )
AND tbl_type = Upper( :lv_invoice_type	)	
  Using Stars2ca;


if stars2ca.of_check_status() = 100 then
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   lv_where = ' cntl_id = ' + in_parms.dw + ' and tbl_type = ' + lv_invoice_type
	messagebox('Error','Error retrieving table name from Stars Win Parm table.' + lv_where)
	return
elseif stars2ca.of_check_status() <> 0 then
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
   lv_where = ' cntl_id = ' + in_parms.dw + ' and tbl_type = ' + lv_invoice_type
	errorbox(stars2ca,'Error reading Stars Win Parm table.' + lv_where)
	return
end if
COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

Reset(dw_1)

/*Connects to datawindow and retrieves number of rows*/

dw_1.dataobject = in_parms.dw

SetTransObject(dw_1,stars1ca) 
	
lv_old_sql = dw_1.GetSQLSelect()
lv_pos = pos(lv_old_sql,'FROM')
lv_pos2 = pos(lv_old_sql,'WHERE')


// BV - 9/13/95 - changes for prob 91 - Alaska

if dw_1.dataobject = 'd_250_pats_by_billchg' then

// if the xref table is used (the enrollee view is a join) then
// an outer join will bomb and a regular join can cause summary
// table records to be lost in the report if there is no match in enrollee.
// thus take the join with enrollee out altogether - the user can use 
// code/decode. If no xref used, then keep the outer join

	if lv_xref = 0 then		// no xref
		lv_select = "SELECT UB.RANK_BILLED_CHRG , UB.RECIP_ID ," +  &
		"EN.PATIENT_NAME , UB.BILLED_CHARGES , " + &
		"UB.INP_DISCH_NUMB_CLAIM ," + &
		"UB.OUTP_FIN_NUMB_CLAIM , UB.UNIQUE_PROV " 

		// FDG 11/20/00 begin
		// ASE will return UB.RECIP_ID *= EN.RECIP_ID
		ls_join_from	=	gnv_sql.of_left_outer_join_from	(lv_new_tbl_name,		&
																			'UB',						&
																			'enrollee',				&
																			'EN')
		// UDB will return a value whereas ASE & Oracle will not.
		ls_join_where	=	gnv_sql.of_left_outer_join_where	(lv_new_tbl_name,		&
																			'recip_id',				&
																			'UB',						&
																			'enrollee',				&
																			'recip_id',				&
																			'EN')
		ls_join_from	=	Upper(ls_join_from)
		ls_join_where	=	Upper(ls_join_where)
		lv_where = " WHERE ( UB.RANK_BILLED_CHRG <= :RANK ) and " + &
		"( UB.PERIOD = :PERIOD ) and " + &
		"( UB.REPORT_ID = 'PAT4' ) "
	
		ls_temp_where[1] = ls_join_where
		ls_replaced_where = gnv_sql.of_left_outer_join_on(ls_temp_where)
		
		IF trim(ls_replaced_where) = '' THEN
			lv_where	=	lv_where	+	" and ("	+	ls_join_where	+	")"
		ELSE
			ls_join_from += ' ' + ls_replaced_where
			ls_join_where = ' '
		END IF
				
		IF	Trim (ls_join_from)	>	' '	THEN
			lv_from1	=	"FROM "	+	ls_join_from
			lv_from2	=	''
		ELSE
			lv_from1 =  "FROM " + lv_new_tbl_name + " UB "
			lv_from2 = " ,ENROLLEE EN "
		END IF
		// FDG 11/20/00 end

	else	// xref join in enrollee view (patient name is pulled from sum table)

		dw_1.dataobject = 'd_250_pats_by_billchg2'
		lv_select = "SELECT UB.RANK_BILLED_CHRG , UB.RECIP_ID ," +  &
		" UB.BILLED_CHARGES , " + &
		"UB.INP_DISCH_NUMB_CLAIM ," + &
		"UB.OUTP_FIN_NUMB_CLAIM , UB.UNIQUE_PROV " 

		lv_where = "WHERE ( UB.RANK_BILLED_CHRG <= :RANK ) and " + &
		"( UB.PERIOD = :PERIOD ) and " + &
		"( UB.REPORT_ID = 'PAT4' ) " 

		lv_from1 = "FROM " + lv_new_tbl_name + " UB "
		lv_from2 = ""

	end if

	lv_new_sql = lv_select + lv_from1 + lv_from2 + lv_where
	
else	// any other dw

	lv_len = lv_pos2 - lv_pos
	lv_new_tbl_name = 'FROM ' + lv_new_tbl_name + ' UB '		// FDG 3/24/98
	lv_new_sql = replace(lv_old_sql,lv_pos,lv_len,lv_new_tbl_name)

end if

mod_str = "datawindow.table.select = ~"" + lv_new_sql + "~""	// BV
stringrc = dw_1.Modify(mod_str)	

lv_report = in_parms.report
lv_period = in_parms.period 

SELECT period_desc
INTO   :lv_proc_year
FROM   period_cntl
WHERE  period = :lv_period and
       FUNCTION_NAME = 'SARS' and
		 invoice_type = Upper( :lv_invoice_type )
USING  stars2ca;

if stars2ca.of_check_status() <> 0 then
	Rollback using stars2ca;
	MessageBox('Error', 'Error selecting description from period_cntl')
	Return
else
	Commit using stars2ca;
end if

lv_window_name = UPPER(this.classname())

rc = fx_dw_syntax(lv_window_name,dw_1,in_decode_struct,stars1ca)
If rc = -5 Then
	lv_index = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(lv_index)
End If
SetTransObject(dw_1,stars1ca) 

CHOOSE CASE lv_report
    
 case 1
  lv_tob = in_parms.tob
  lv_rank1 = in_parms.rank1
  lv_nbr_rows = dw_1.Retrieve(lv_tob,lv_rank1,lv_period,lv_proc_year)
 case 2
  lv_tob = in_parms.tob
  lv_rank1 = in_parms.rank1
  lv_revexcl = in_parms.revexcl
  lv_nbr_rows = dw_1.Retrieve(lv_tob,lv_rank1,lv_period,lv_revexcl,lv_proc_year)
 case 3 
  lv_tob = in_parms.tob
  lv_rank1 = in_parms.rank1
  lv_rank2 = in_parms.rank2
  lv_nbr_rows = dw_1.Retrieve(lv_rank1,lv_rank2,lv_tob,lv_period,lv_proc_year)
 case 4
  lv_rank1 = in_parms.rank1
  lv_nbr_rows = dw_1.Retrieve(lv_rank1,lv_period,lv_proc_year)
 case 5
  lv_tob = in_parms.tob
  lv_rank1 = in_parms.rank1
  lv_nbr_rows = dw_1.Retrieve(lv_rank1,lv_tob,lv_period,lv_proc_year)
END CHOOSE

This.Event ue_set_window_colors(this.control)

If lv_nbr_rows = 0 Then
	COMMIT using STARS1CA;
	If stars1ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	SetMicroHelp(w_main,'Report Cancelled')
   messagebox('NO DATA','No data for the report specified',INFORMATION!,OK!)
   dw_1.taborder = 0
	cb_1.PostEvent(Clicked!)
   return
end if 

st_row_count.text = string(lv_nbr_rows)

// KTB 04-20-00 - Starcare Track 2494
m_stars_30.m_reporting.m_graph.Enabled = FALSE
// End KTB

SetMicroHelp(w_main,'Ready')

COMMIT using STARS1CA;
If stars1ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If
end event

on w_rpt_display_baseline_ub92.create
int iCurrent
call super::create
this.st_row_count=create st_row_count
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_row_count
this.Control[iCurrent+2]=this.st_dw_ops
this.Control[iCurrent+3]=this.ddlb_dw_ops
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_rpt_display_baseline_ub92.destroy
call super::destroy
destroy(this.st_row_count)
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;
in_parms = message.PowerObjectParm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectParm)

end event

event close;call super::close;// KTB 04-20-00 - Starcare Track 2494 - Enable graph functionality
m_stars_30.m_reporting.m_graph.Enabled = TRUE
// End KTB

end event

type st_row_count from statictext within w_rpt_display_baseline_ub92
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 1476
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 400
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

type st_dw_ops from statictext within w_rpt_display_baseline_ub92
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 1308
integer width = 658
integer height = 68
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

type ddlb_dw_ops from dropdownlistbox within w_rpt_display_baseline_ub92
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 14
integer y = 1380
integer width = 709
integer height = 308
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
long backcolor = 1073741824
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;//	Katie	04/10/09	GNL.600.5633	Added decode structure to fx_uo_control call.
string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,st_row_count, in_decode_struct)
end on

type cb_1 from commandbutton within w_rpt_display_baseline_ub92
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2409
integer y = 1452
integer width = 270
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "&Close"
boolean default = true
end type

on clicked;Close(parent)
end on

type dw_1 from u_dw within w_rpt_display_baseline_ub92
string accessiblename = "Baseline Report"
string accessibledescription = "Baseline Report"
accessiblerole accessiblerole = clientrole!
string tag = "listdatawindow,CRYSTAL, title = Baseline Report"
integer x = 14
integer y = 16
integer width = 2665
integer height = 1284
integer taborder = 10
string dataobject = "d_100_hcpcs_wn_tob_by_billchg"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Exclamation!"
end type

event doubleclicked;//Script for doubleclicked for dw_1
//********************************************************************
//Modifications
//07/17/97 - NLG FS#171 replace 2 occurrences of GetClickedRow(dw_1) 
//                      with argument row
//////////////////////////////////////////////////////////////////////
int tabpos,rc,lv_indx,lv_found
int lv_upper
long lv_row_nbr
string lv_hold_object,lv_col,lv_tbl_type
string lv_string_width,lv_hold_col_width,lv_col_name
boolean lv_lookup,lv_found_flag,lv_join

lv_join = FALSE

setpointer(hourglass!)
lv_hold_object = Getobjectatpointer(dw_1)
If lv_hold_object = '' then
	return
end if
tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
	else
		ddlb_dw_ops.triggerevent(selectionchanged!)  // MVR 3.6 01/13/97 Aded to match other routines
	End If
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
End If
end event

event rowfocuschanged;long row_nbr,clicked_row, rc

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
row_nbr = getrow(dw_1)
//Highlights the current row
rc = SelectRow(dw_1,0,FALSE)
rc = SelectRow(dw_1,row_nbr,TRUE)




end event

