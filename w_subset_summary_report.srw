HA$PBExportHeader$w_subset_summary_report.srw
$PBExportComments$Inherited from w_parent_rpt
forward
global type w_subset_summary_report from w_parent_rpt
end type
type st_dw_ops from statictext within w_subset_summary_report
end type
type cb_calendar from commandbutton within w_subset_summary_report
end type
end forward

global type w_subset_summary_report from w_parent_rpt
long backcolor = 67108864
string accessiblename = "Subset Summary Report"
string accessibledescription = "Subset Summary Report"
accessiblerole accessiblerole = windowrole!
integer x = 110
integer y = 116
integer width = 3401
integer height = 2348
string title = "Subset Summary Report"
event ue_view_detail ( )
st_dw_ops st_dw_ops
cb_calendar cb_calendar
end type
global w_subset_summary_report w_subset_summary_report

type variables
//	GaryR	08/06/04	Track 4049d	Provide drilldown from Subset Summary
STRING iv_col_names[]
sx_subset_summary iv_enter
end variables

event ue_view_detail();/////////////////////////////////////////////////////////////////////////
//	Script:	w_subset_summary_report.ue_view_detail
//
//	Description:
//		This event is triggered from cb_view_detail and will open 
//		w_query_engine
//
/////////////////////////////////////////////////////////////////////////
//
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
// 10/21/04	MikeF Track 3650d Removed stripping off invoice type
//	12/15/04	GaryR	Track 4160d	Add double parens at the beginning and end of criteria
//	03/03/05	GaryR Track 4336d	Remove descriptions on decoded columns when drilling down
// 07/12/05 Katie Track 3661d Change empty field to "BLANKS" for drilling down.
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	09/08/06	GaryR	Track 4816	Set proper inv type when drilling down from ML FT Subset Summary
//
/////////////////////////////////////////////////////////////////////////

sx_query_engine_parms	lstr_query_engine_parms

String	ls_type,			&
			ls_column[],	&
			ls_value[],		&
			ls_bool[],		&
			ls_lp[],			&
			ls_rp[]
Long		ll_upperbound, &
			ll_row
			
Int 		i, li_cnt, li_ctr, li_pos
n_cst_decode	lnv_decode

ll_row = dw_1.GetSelectedRow( 0 )
IF ll_row = 0 THEN
	MessageBox( "Selection Error", "Please select a valid row", StopSign! )
	Return
END IF

//	Clear out the query parms from previous attempts
This.of_set_queryengine (TRUE)
inv_queryengine.uf_clear_query_parms()

lstr_query_engine_parms.pdq_subset = TRUE
lstr_query_engine_parms.sub_inv_type = iv_enter.invoice_type
lstr_query_engine_parms.sumbyrev = iv_enter.report_id = "SUMBYREV"
lstr_query_engine_parms.prefilter_rows = iv_enter.selected_rows
lstr_query_engine_parms.prefilter_bool = iv_enter.is_boolean
lstr_query_engine_parms.ft_main_inv_type = iv_enter.is_main_inv_type
inv_queryengine.uf_set_sxQueryEngineParms (lstr_query_engine_parms)	// JTM 2/11/98
inv_queryengine.uf_set_query_engine_mode( "PDQ" )

//	Populate the where criteria
li_cnt = UpperBound( iv_enter.selected_columns )
do while ll_row > 0
	FOR i = 1 TO li_cnt
		li_ctr ++
		ls_column[li_ctr] = iv_enter.selected_columns[i]
		ls_type = dw_1.Describe("#" + String(i) + ".ColType")
		IF gnv_sql.of_is_character_data_type( ls_type ) THEN
			ls_value[li_ctr] = dw_1.GetItemString( ll_row, i )
			// Remove decoded value
			IF lnv_decode.of_is_decoded( dw_1, i ) THEN
				lnv_decode.of_remove_desc( ls_value[li_ctr] )
			END IF
		ELSEIF gnv_sql.of_is_date_data_type( ls_type ) THEN
			ls_value[li_ctr] = String( dw_1.GetItemDateTime( ll_row, i ), "mm/dd/yyyy" )
		ELSEIF gnv_sql.of_is_number_data_type( ls_type ) THEN
			ls_value[li_ctr] = String( dw_1.GetItemNumber( ll_row, i ) )
		ELSEIF gnv_sql.of_is_money_data_type( ls_type ) THEN
			ls_value[li_ctr] = String( dw_1.GetItemDecimal( ll_row, i ) )
		ELSE
			MessageBox( "ERROR", "Unable to determine data type: " + ls_type )
			Return
		END IF
		
		IF IsNull( ls_value[li_ctr] )  OR Trim( ls_value[li_ctr] ) = "" THEN
			ls_value[li_ctr] = 'BLANKS'
		END IF
		
		IF i = li_cnt THEN
			ls_bool[li_ctr] = "OR"
		ELSE
			ls_bool[li_ctr] = "AND"
		END IF
		
		ls_lp[li_ctr] = "("
		ls_rp[li_ctr] = ")"
	NEXT
	ll_row = dw_1.GetSelectedRow( ll_row )
loop

//	Load the criteria
FOR i = 1 TO li_ctr
	li_cnt ++
	//	Enclose the added criteria in parenthesis
	IF i = 1 THEN ls_lp[i] = "(("
	IF i = li_ctr THEN ls_rp[i] = "))"
	inv_queryengine.uf_load_where( ls_lp[i], iv_enter.invoice_type, &
				ls_column[i], "=", ls_value[i], ls_rp[i], ls_bool[i], li_cnt )
NEXT

//	Open the query engine window
w_main.Setmicrohelp('Bringing up Query Engine.  Please Wait!')
inv_queryengine.uf_open_query_engine()
end event

event open;//*****************************************************************
//	Script:	Open	-	Override the ancestor
//
//	Description:
//
//*****************************************************************
//	02-18-98 ajs	4.0 145-subset summary report; display sub name instead of id
//	09-17-97 MSS	remove totals on the subset summary report 
//	07-17-97 FDG	Since this script overrides w_parent_rpt.open,
//						call w_master.open
//	05-12-97 MSS	Include totals on the subset summary report FS#139/TS#140
//	08-02-95 FNC	SWAT effort to display win parm parameters 
//	11/01/00	GaryR	2920c	Standardize windows colors
// 01/23/01	GaryR	Eliminate global gv_subset_summary_select
// 02/20/01	FDG	Stars 4.7.  Set in_transaction_object data type n_tr (instead of type transaction)
//	07/31/02	GaryR	Track 4453c	Use long varibles for integers
//	01/15/04	GaryR	Track 6147c	Obtain the ranking column fron the built DW
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
// 11/08/04 MikeF	SPR4107d	Added formatting and Calendar button 
// 01/06/05 MikeF SPR4205d Must register dw with format service
//	01/11/05 Katie Track 5431c Changed global references to instance.
// 02/15/05 MikeF	Track 4291d Reworked calendar button logic
// 02/21/05 MikeF	Track 4307d Subset name not on title of Subset summary
// 03/03/05 MikeF SPR4339d	Size char columns based on data length / label
//	07/10/06	GaryR	Track 4387d	Remove obsolete decode structure key
//	04/23/08	GaryR	SPR 5331	Fix selected rows counter logic
//
//*****************************************************************

String 	lv_color, style, ls_error, lv_sort_string, ls_type
string 	lv_where 
int		li_rc, li_rows, li_index, li_cols, li_dates
n_cst_dw_format	lnv_format
sx_dw_format		lsx_format

iv_enter = Message.PowerObjectParm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

Call	w_master::Open			//	FDG	07/17/97

in_create= FALSE

in_table_type = iv_enter.invoice_type						//ajs 4.0 02-18-98
in_transaction_object = stars2ca								//ajs 4.0 02-18-98

lv_color = string( stars_colors.datawindow_back ) //GaryR	11/01/2000	2920c
style = 'datawindow(units=1 color='+lv_color+')'+'style(type=grid)'

// 01/23/01	GaryR	Eliminate global gv_subset_summary_select
li_rc = Create(dw_1,Syntaxfromsql(in_transaction_object,iv_enter.subset_summary_select,style,ls_error))
if li_rc = -1 Then
	messagebox("ERROR",'error returned from Create:'+ls_error)
	IN_TRANSACTION_OBJECT.of_commit()			// FDG 02/20/01
	If IN_TRANSACTION_OBJECT.sqlcode <> 0 Then
		Messagebox('EDIT','Error Commiting to in_transaction_object')
		Return
	End If	
	return
end If

if ls_error <> '' Then 
	messagebox('error returned from Create.',ls_error)
	IN_TRANSACTION_OBJECT.of_commit()			// FDG 02/20/01
	return
end If

in_sql = iv_enter.subset_summary_select 

if gc_debug_mode then
	messagebox("select statement in w_summary_rpt_display",iv_enter.subset_summary_select)
end if

fx_dw_syntax(UPPER(this.classname()),dw_1,in_decode_struct,in_transaction_object)
in_decode_struct.decoded = 99

call w_parent_rpt::open   //calls the parent open statement

// Add and format header
lsx_format.subset 		= iv_enter.subset_name 	+ ' - ' + iv_enter.subset_desc
lsx_format.inv_type		= iv_enter.invoice_type + ' - ' + gnv_dict.event ue_get_table_desc(iv_enter.invoice_type)
lsx_format.report_date 	= trim(string(gnv_sql.of_get_current_datetime()))
lsx_format.report_name	= "Subset Summary Report"
lsx_format.display_report_name= TRUE
lsx_format.display_inv_type 	= TRUE
lsx_format.display_subset 		= TRUE
lsx_format.display_report_date= TRUE

lnv_format.event ue_register_dw(dw_1)
lnv_format.uf_add_header(lsx_format)

// Format column headings and columns
lnv_format.uf_format_col_headers()
lnv_format.uf_format_details()
lnv_format.uf_set_inv_type( iv_enter.invoice_type )
lnv_format.uf_set_default_disp_formats(TRUE)

dw_1.SetRedraw(TRUE)

//Checks to see if an error occurred in the parent. if it did not 
//it gets the count for summary analysis

if gv_rc <> -1 then
	w_subset_summary_report.sle_count.text = string(in_row_count)
else
   Return
end if

IF dw_1.Describe( "rank.visible" ) <> "!" THEN

	lv_sort_string = '#' + String( Long( dw_1.object.rank.id ) - 1 ) + ' D'

	dw_1.SetSort(lv_sort_string)
	dw_1.Sort()
	dw_1.GroupCalc()
	
	li_rows = dw_1.RowCount()
	
	for li_index = 1 to li_rows 
	  dw_1.SetItem(li_index,"rank",li_index)
	next
	
	li_rc = SelectRow(dw_1,0,FALSE)
	li_rc = SelectRow(dw_1,1,TRUE)
ELSE
	SelectRow(dw_1,0,FALSE)
	SelectRow(dw_1,1,TRUE)
END IF

cb_calendar.visible = iv_enter.enable_calendar

ib_allow_switch = TRUE

SetMicroHelp(w_subset_summary_report,'Ready')
end event

event activate;// Katie 01/11/05 Track 5431c Changed global references to instance and added event to restore window
//						settings in menu.
integer li_x, li_y

integer bottom_margin

setpointer(hourglass!)
this.setredraw(False)

li_x = dw_1.X
li_y = dw_1.Y

bottom_margin = dw_1.Y + dw_1.Height 

if IsValid (mle_crit) = TRUE THEN
   if ib_show_sql = FALSE THEN
      dw_1.X        = mle_crit.X
      dw_1.Y        = 177
      dw_1.Width    = mle_crit.Width
      dw_1.Height   = bottom_margin - dw_1.Y 
      mle_crit.hide ()
   else
      dw_1.X        = dw_1.X
      dw_1.Y        = (mle_crit.Y + mle_crit.Height) + 40
      dw_1.Width    = mle_crit.Width
      dw_1.Height   = bottom_margin - dw_1.Y
      mle_crit.Show ()
   end if
else
   dw_1.X      = dw_1.X
   dw_1.Y      = 1
   dw_1.Width  = dw_1.Width
   dw_1.Height = bottom_margin - dw_1.Y
end if
 
m_stars_30.m_file.m_showsql.event ue_restore_win_settings() 
 
dw_1.Show ()
this.setredraw(true)  
end event

on w_subset_summary_report.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
this.cb_calendar=create cb_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
this.Control[iCurrent+2]=this.cb_calendar
end on

on w_subset_summary_report.destroy
call super::destroy
destroy(this.st_dw_ops)
destroy(this.cb_calendar)
end on

type ddlb_dw_ops from w_parent_rpt`ddlb_dw_ops within w_subset_summary_report
integer x = 50
integer y = 2036
integer width = 763
integer height = 228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
end type

event ddlb_dw_ops::selectionchanged;call super::selectionchanged;//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background

iv_uo_win.uo_decode.of_set_invoice_type( in_table_type )
end event

type cb_clear from w_parent_rpt`cb_clear within w_subset_summary_report
boolean visible = false
integer x = 1134
integer y = 1984
integer taborder = 60
boolean enabled = false
end type

type st_1 from w_parent_rpt`st_1 within w_subset_summary_report
integer x = 334
integer y = 2060
end type

type cb_save_report from w_parent_rpt`cb_save_report within w_subset_summary_report
integer x = 1467
integer y = 2116
integer taborder = 30
end type

type sle_count from w_parent_rpt`sle_count within w_subset_summary_report
integer x = 850
integer y = 2040
integer width = 274
integer height = 100
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
end type

type cb_stop from w_parent_rpt`cb_stop within w_subset_summary_report
integer x = 1147
integer y = 2108
integer taborder = 50
end type

type mle_crit from w_parent_rpt`mle_crit within w_subset_summary_report
boolean visible = false
integer x = 23
integer y = 32
integer width = 3296
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
end type

type cb_query from w_parent_rpt`cb_query within w_subset_summary_report
boolean visible = false
integer x = 402
integer y = 2060
integer taborder = 10
end type

type cb_view_detail from w_parent_rpt`cb_view_detail within w_subset_summary_report
integer x = 2496
integer y = 2076
integer width = 384
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
boolean enabled = true
string text = "&View Data..."
end type

event cb_view_detail::clicked;call super::clicked;////////////////////////////////////////////////////////////////////
//
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//
////////////////////////////////////////////////////////////////////

Parent.event ue_view_detail()
end event

type cb_close from w_parent_rpt`cb_close within w_subset_summary_report
integer x = 2930
integer y = 2076
integer width = 384
integer taborder = 70
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "Microsoft Sans Serif"
string text = "Cl&ose"
boolean default = true
end type

type dw_1 from w_parent_rpt`dw_1 within w_subset_summary_report
string tag = "CRYSTAL, title = Summary Report"
integer x = 23
integer y = 28
integer width = 3291
integer height = 1932
integer taborder = 20
end type

event dw_1::rowfocuschanged;////////////////////////////////////////////////////////////////////
//
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//
////////////////////////////////////////////////////////////////////

//this script is not extended
end event

event dw_1::doubleclicked;//// Keep this comment here at all times to blank out inherited script
//// Any problems see ScottD
//string lv_hold_object,lv_col,lv_col_name,lv_sort_name,lv_data_type
//int tabpos
//		setpointer(hourglass!)
//		lv_hold_object = dwgetobjectatpointer(dw_1)
////store the current row number and the column name
//		tabpos = pos (lv_hold_object,"~t")
//		lv_col = left(lv_hold_object,(tabpos - 1))
//		
//		if right(lv_col,2) = '_t' AND UPPER(lv_col) <> 'HEADER_T' then
//			lv_col_name = left(lv_col,len(lv_col) - 2)
//			lv_sort_name = dw_1.Describe(lv_col+'.text')
//			lv_data_type = dw_1.Describe(lv_col_name+'.Coltype')       
//			lv_sort_name = dw_1.Describe(lv_col+'.text')
//			if isvalid(iv_uo_win) = FALSE Then
//				cbx_rank_sort.checked = TRUE
//				cbx_rank_sort.triggerevent(clicked!)
//			end if      
//			iv_uo_win.uo_rank.fuo_set_dw(dw_1)          
//			rc = iv_uo_win.uo_rank.fuo_set_code_table(lv_sort_name,lv_col_name,lv_data_type)
//			if rc = -1 then return
//			iv_uo_win.uo_rank.fuo_Insert_sort_Info()
//			iv_uo_win.uo_rank.fuo_Default_order()
//
//		SetMicroHelp(w_main,"Ready")
//
//	end if

//Script for W_Subset_Summary_Report doubleclicked for dw_1
//////////////////////////////////////////////////////////////////////
//anne-s 11-28-97 TS242 Rel 3.6
int tabpos,li_rc,lv_indx,lv_found
int lv_upper
long lv_row_nbr
string lv_hold_object,lv_col,lv_tbl_type
string lv_string_width,lv_hold_col_width,lv_col_name
boolean lv_lookup,lv_found_flag,lv_join

lv_join = FALSe

setpointer(hourglass!)
lv_hold_object = GetObjectatPointer(dw_1)
If lv_hold_object = '' then
	return
end if
tabpos = pos (lv_hold_object,"~t")
lv_col = left(lv_hold_object,(tabpos - 1))
If right(lv_col,2) = '_t' and UPPER (lv_col) <> 'HEADER_T' Then
	//anne-s 11-28-97 TS242 Rel 3.6
//	If isvalid(iv_uo_win) = FALSE Then
		If in_selected <> '1' Then
			Messagebox('Information','You must select an option from Window Operations')
		Else
			ddlb_dw_ops.triggerevent(selectionchanged!)
		End If
//	End if      
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'',0,in_decode_struct)
ElseIf in_dw_control = 'FILTER' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
ElseIf in_dw_control = 'FIND' Then
	ddlb_dw_ops.triggerevent(selectionchanged!)
	lv_row_nbr = row
//	lv_tbl_type = fx_get_tbl_type(dw_1,lv_col,lv_join)
	li_rc = fx_dw_control(dw_1,lv_hold_object,in_dw_control,iv_uo_win,'cell',lv_row_nbr,in_decode_struct)
End If

end event

event dw_1::rbuttondown;//===================================================================================//
// Window		w_subset_summary_report
// Object		dw_1
// Event			rbuttondown
//===================================================================================//
// Right mouse event used for lookups
//===================================================================================//
// Maintenance
// -------- ----- -------------------------------------------------------------------
//	10-11-95 FNC	Take upperbound out of script
//	08-02-95 FNC	SWAT effort display dictionary parameters
//	04/11/01	GaryR	Stars 4.7 DataBase Port - Trimming the data
//	07/31/02	GaryR	Track 4453c	Use long varibles for integers
// 10/19/04 MikeF	SPR3650d	Replaced local code with fx_lookup
//===================================================================================//
fx_lookup(dw_1,iv_enter.invoice_type)
end event

event dw_1::clicked;call super::clicked;// THIS SCRIPT HANDLES THE SELECTION OR DE-SELECTION OF ROWS
// IN THE DATAWINDOW.  VARIOUS BUTTONS ARE TURNED ON OR OFF BASED
// ON THE NUMBER OF SELECTED ROWS.  SELECTED ROWS ARE LIMITED TO 10.
//************************************************************************
//
//	08/06/04	GaryR	Track 4049d	Provide drilldown from Subset Summary
//	04/23/08	GaryR	SPR 5331	Fix selected rows counter logic
//
//************************************************************************

Long	ll_selected_cnt

IF row = 0 THEN Return

IF This.isSelected(row) THEN
	This.SelectRow(row,FALSE)
ELSE
	ll_selected_cnt = Long(This.Describe("Evaluate('sum(if(isSelected(), 1, 0))', 1)"))
	IF ll_selected_cnt >= 10 THEN
		This.SelectRow(row,FALSE)
		MessageBox("Selection Error","You Have Selected The Maximum Number Of Rows (10)")
		This.Modify("datawindow.selected.mouse=no")
		Return
	ELSE		
		This.SelectRow(row,TRUE)
	END IF
END IF

ll_selected_cnt = Long(This.Describe("Evaluate('sum(if(isSelected(), 1, 0))', 1)"))
IF ll_selected_cnt <= 0 THEN
	cb_view_detail.enabled = FALSE
ELSE			
	cb_view_detail.enabled = TRUE
END IF	
end event

type st_dw_ops from statictext within w_subset_summary_report
string accessiblename = "Window Operations"
string accessibledescription = "Window  Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 50
integer y = 1972
integer width = 699
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Window Operations:"
boolean focusrectangle = false
end type

type cb_calendar from commandbutton within w_subset_summary_report
boolean visible = false
string accessiblename = "Calendar"
string accessibledescription = "Calendar"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2062
integer y = 2076
integer width = 384
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Calendar"
end type

event clicked;

OpenSheetwithParm(w_calendar,dw_1,MDI_main_frame,help_menu_position,Layered!)

end event

