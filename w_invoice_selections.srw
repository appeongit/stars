HA$PBExportHeader$w_invoice_selections.srw
$PBExportComments$Inherited from w_master
forward
global type w_invoice_selections from w_master
end type
type st_1 from statictext within w_invoice_selections
end type
type st_in_retrieval from statictext within w_invoice_selections
end type
type dw_1 from u_dw within w_invoice_selections
end type
type cb_select from u_cb within w_invoice_selections
end type
type cb_close from u_cb within w_invoice_selections
end type
end forward

global type w_invoice_selections from w_master
string accessiblename = "Invoices"
string accessibledescription = "Invoices"
accessiblerole accessiblerole = windowrole!
integer x = 553
integer y = 468
integer width = 1815
integer height = 1016
string title = "Invoices"
windowtype windowtype = response!
long backcolor = 67108864
st_1 st_1
st_in_retrieval st_in_retrieval
dw_1 dw_1
cb_select cb_select
cb_close cb_close
end type
global w_invoice_selections w_invoice_selections

type variables
string iv_invoice_type
boolean iv_select 


String iv_menu_item

String is_subc_dep_table_types
end variables

event open;call super::open;//  Maintenance Log:
//
//  Date:		By:		Project:			Description:
//  --------   ------   ----------- 	----------------------------------------
//  01/24/98   JGG      STARS 4.0      Allow multi level subsets to be selected
//													for random sampling.  Invoice type  
//													selection has to filter all available 
//													invoice types in the STARS_WIN_PARM
//													table by those used to make up the 
//													ML subset.
//	03/03/03		GaryR		Track 2994d		Auto-select first row for ML subsets
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//


integer 	li_row_cnt
integer	li_num_types	=	0
long		ll_comma_pos	=	0
long		ll_plus_pos		=	0
String	ls_dep_tbl_types
String	ls_filter_text
String	ls_tbl_type

// 01/24/98 JGG - end

Setpointer(Hourglass!)
This.visible = False
st_in_retrieval.visible = False

dw_1.SetTransObject(Stars2ca)

// 01/24/98	JGG - begin
// 					Test for the presence of a comma in the parm string.
//						This only occurs when the user selects an ML subset on case
//						folder window and then clicks the random sample button.

ll_comma_pos	=	Pos(iv_menu_item, ',')

// If comma found, store data to the right of it in instance variable and strip data
// from the name of the menu item.

If ll_comma_pos > 0 Then
	is_subc_dep_table_types	=	Trim(Upper(Mid(iv_menu_item, ll_comma_pos + 1)))
	iv_menu_item				=	Left(iv_menu_item, ll_comma_pos - 1)
Else
	is_subc_dep_table_types	=	""
End if

CHOOSE CASE lower(iv_menu_item)
	CASE 'm_summaryanalysis'
  			title	=	'Invoices - Summary Analysis'
	CASE 'm_baselinereports'
			title	=	'Invoices - Standard Analysis'
	CASE 'w_random_sampling_selection'
			title	=	'Invoices - Random Sample'
	CASE 'm_ratioreports'
  			title	=	'Invoices - Ratio Reports'
	CASE 'm_normanalysis'
  			title	=	'Invoices - Norm Analysis'
END CHOOSE

dw_1.Retrieve(iv_menu_item,GV_SYS_DFLT)

if Stars2ca.of_commit() <> 0 then
	errorbox(stars2ca,'Error performing commit in w_invoice_selections.')
end if

// 01/24/98 - JGG: 	Now filter out invoice types not in the multi-level subset
//							if chosen for random sampling

If lower(iv_menu_item) = 'w_random_sampling_selection' Then
	If is_subc_dep_table_types > ' ' Then
		// Parse the string containing the inv types within the ML subset 
		// and construct the filter statement
		ls_filter_text		=	"TBL_TYPE IN ("
		ls_dep_tbl_types	=	is_subc_dep_table_types
		ll_plus_pos			=	Pos(ls_dep_tbl_types, '+')
		
		// Build the filter string using all dependent invoice types
		DO WHILE ll_plus_pos > 0 
			If li_num_types > 0 Then
				ls_filter_text	=	ls_filter_text + ","
			End If
			ls_tbl_type			=	Trim(Left(ls_dep_tbl_types, ll_plus_pos - 1))
			ls_dep_tbl_types	=	Trim(Mid(ls_dep_tbl_types, ll_plus_pos + 1))
			ls_filter_text		=	ls_filter_text + "'" + ls_tbl_type + "'"
			li_num_types++
			ll_plus_pos			=	Pos(ls_dep_tbl_types, '+')
		LOOP
		
		// If the number of types is greater than 0, then filter.
		
		If li_num_types > 0 Then
			// Check for another invoice type after last plus sign
			If Len(ls_dep_tbl_types) > 0 Then
				ls_filter_text	=	ls_filter_text + ",'" + ls_dep_tbl_types + "'"
			End if
			ls_filter_text		=	ls_filter_text + ")"
			
			dw_1.SetFilter(ls_filter_text)
			dw_1.Filter()
		End if
	End if	
End if		

li_row_cnt = dw_1.RowCount()
If li_row_cnt = 0 Then
  cb_select.enabled = False
  This.visible = True
  st_in_retrieval.visible = True
  cb_close.default = true   
  RETURN
End If  

dw_1.SelectRow(1,True)

If li_row_cnt > 1 Then
  This.visible = True
  RETURN
End If

cb_select.postevent(clicked!)
end event

event close;call super::close;If iv_select = TRUE Then
	w_main.cb_open_window.postevent(clicked!)
End If
end event

on w_invoice_selections.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_in_retrieval=create st_in_retrieval
this.dw_1=create dw_1
this.cb_select=create cb_select
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_in_retrieval
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.cb_close
end on

on w_invoice_selections.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_in_retrieval)
destroy(this.dw_1)
destroy(this.cb_select)
destroy(this.cb_close)
end on

event ue_preopen;call super::ue_preopen;iv_menu_item = Message.StringParm
//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

end event

type st_1 from statictext within w_invoice_selections
string accessiblename = "Invoice Types"
string accessibledescription = "Invoice Types"
accessiblerole accessiblerole = statictextrole!
integer x = 146
integer y = 28
integer width = 448
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Invoice Types:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_in_retrieval from statictext within w_invoice_selections
boolean visible = false
string accessiblename = "Retrieval Error on invoice type"
string accessibledescription = "Retrieval Error on invoice type"
accessiblerole accessiblerole = statictextrole!
integer x = 146
integer y = 432
integer width = 1463
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 1073741824
boolean enabled = false
string text = "Retrieval Error on invoice type"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_invoice_selections
string accessiblename = "Invoice Types"
string accessibledescription = "Invoice Types"
accessiblerole accessiblerole = clientrole!
integer x = 137
integer y = 124
integer width = 1481
integer height = 604
integer taborder = 10
string dataobject = "d_invoice_types"
boolean vscrollbar = true
end type

event doubleclicked;int row_nbr

row_nbr = row //GetClickedRow(dw_1)
If row_nbr > 0 Then
	cb_select.TriggerEvent(Clicked!)
Else
   Messagebox('NOTICE','You have tried to select an invalid row,~r Pleas try again',Information!,OK!)
	Return
End If
end event

event rowfocuschanged;//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

integer lv_row_nbr

/*gets the row and makes sure a row was clicked*/
lv_row_nbr = getrow(dw_1)
If lv_row_nbr <= 0 then
	return
else
	SelectRow ( dw_1, 0, FALSE )
	SelectRow ( dw_1, lv_row_nbr, TRUE )
	cb_select.enabled = True
end if

end event

event clicked;/////////////////////////////////////////////////////////////////////
// This code will retrieve the clicked row from the invoice type
// datawindow.  If will first determine if there are multiple paths
// in which the user may choose.  If only one path exists then the
// window will be loaded automatically without the user seeing the
// selection window.  If multiple path may exist then the screen is
// set to visible and the user may then make their selection
/////////////////////////////////////////////////////////////////////
//
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////

integer lv_row_nbr


lv_row_nbr = row
If lv_row_nbr <= 0 Then
   Return
End If
dw_1.SelectRow(0,FALSE)
dw_1.SelectRow(lv_row_nbr,True)
cb_select.enabled = True

end event

type cb_select from u_cb within w_invoice_selections
string accessiblename = "Select"
string accessibledescription = "Select..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 357
integer y = 776
integer width = 466
integer height = 108
integer taborder = 30
boolean enabled = false
string text = "&Select..."
boolean default = true
end type

event clicked;//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

string  lv_win_id,lv_string,lv_parm,lv_win_desc
integer lv_row_nbr

Setpointer(Hourglass!)
iv_select = false
lv_row_nbr = dw_1.GetSelectedRow(0)
lv_win_id = upper(dw_1.GetItemString(lv_row_nbr,"cntl_id"))
iv_invoice_type = dw_1.GetItemString(lv_row_nbr,"tbl_type")
lv_string = dw_1.GetItemString(lv_row_nbr,"col_name")

If lv_win_id = 'W_CATEG_LIST_MAINTAIN' OR lv_win_id = 'W_RPT_SELECTION' Then
// this line will set the instance variable for opening the window through w_main
// without setting the global variable
	w_main.iv_invoice = iv_invoice_type
Else
	gv_active_invoice = iv_invoice_type
	w_main.triggerevent('timer')
End If

iv_select = true
lv_parm = lv_win_id + '~t' + iv_invoice_type + '~t' + lv_string
w_main.iv_test = lv_parm
cb_close.triggerevent(clicked!)
end event

type cb_close from u_cb within w_invoice_selections
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 887
integer y = 776
integer width = 471
integer height = 108
integer taborder = 20
string text = "&Close"
end type

on clicked;setmicrohelp("Ready")
close(w_invoice_selections)

end on

