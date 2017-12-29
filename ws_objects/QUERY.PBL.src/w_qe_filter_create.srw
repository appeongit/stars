$PBExportHeader$w_qe_filter_create.srw
$PBExportComments$(Inherited from w_master)
forward
global type w_qe_filter_create from w_master
end type
type dw_filter_list from u_dw within w_qe_filter_create
end type
type cb_ok from u_cb within w_qe_filter_create
end type
type cb_cancel from u_cb within w_qe_filter_create
end type
end forward

global type w_qe_filter_create from w_master
long backcolor = 67108864
string accessiblename = "Create Filter"
string accessibledescription = "Create Filter"
accessiblerole accessiblerole = windowrole!
integer x = 923
integer y = 512
integer width = 1806
string title = "Create Filter"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_check_filter_id ( string arg_elem_name,  ref boolean arg_filter_used )
dw_filter_list dw_filter_list
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_qe_filter_create w_qe_filter_create

type variables
PRIVATE:

boolean ib_allow_unclick

sx_all_filter_info isx_filter_parms
end variables

event ue_check_filter_id;call super::ue_check_filter_id;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	UE_Check_Filter_id						w_qe_filter_create
/////////////////////////////////////////////////////////////////////////////
//	Description
//	
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument				Datatype			Description
//		---------	--------				--------			-----------
//		Value			arg_elem_name		string			Elem name of the filter column	
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	FNC			08/04/98		Track 1265
//
/////////////////////////////////////////////////////////////////////////////

integer li_num_filters, li_filter

li_num_filters = upperbound(isx_filter_parms.filters)

if li_num_filters = 0 then return

for li_filter = 1 to li_num_filters
	if arg_elem_name = isx_filter_parms.filters[li_filter].col_name then
		arg_filter_used = isx_filter_parms.filters[li_filter].filter_used
		continue
	end if
next
end event

on w_qe_filter_create.create
int iCurrent
call super::create
this.dw_filter_list=create dw_filter_list
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter_list
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_qe_filter_create.destroy
call super::destroy
destroy(this.dw_filter_list)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event ue_postopen;call super::ue_postopen;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	ue_PostOpen									w_qe_filter_create
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Will retrieve the message parm which will contain the data source and the additional
// data source (if one selected).  Create sql using the invoice type(s) and retrieve the 
// dw_filter_list.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/07/98		Created.
//
//	FDG			03/17/98		Change variable names to conform to standards.
//
// FNC			08/04/98		Track 1265. Row must be selected so it will be 
//									highlighted.
//	GaryR			04/20/01		Stars 4.7 DataBase Port - Empty String in SQL.
//	GaryR			09/12/02		SPR 3070d	Preserve case of description
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

isx_filter_parms = message.PowerObjectParm

String ls_inv_types, ls_sql, ls_inv_type
Long ll_num_inv, ll_idx, ll_rowcount, ll_count, ll_row
Integer li_pos

/* string together for in clause */
ll_num_inv = upperbound(isx_filter_parms.data_type)

for ll_idx =	1 to ll_num_inv
	ls_inv_type = isx_filter_parms.data_type[ll_idx]
	If Not(IsNull(ls_inv_type)) Then
		//	GaryR			04/20/01		Stars 4.7 DataBase Port
		gnv_sql.of_TrimData( ls_inv_type )
		ls_inv_types = ls_inv_types + ",'" + ls_inv_type + "'"
	End If
next

ls_inv_types = mid(ls_inv_types,2)  /* remove first "," */

ls_sql = "select distinct elem_desc, elem_name," + & 
	"elem_data_type, elem_tbl_type, ' ' from dictionary " + &
	" where elem_type IN ('CL','CC') and elem_tbl_type in (" + &
	Upper( ls_inv_types ) + ") and crit_seq <> 0"

dw_filter_list.setsqlselect(ls_sql)

dw_filter_list.SetRedraw(FALSE)

ll_rowcount = dw_filter_list.retrieve()

dw_filter_list.setsort("elem_tbl_type A, elem_desc A")
dw_filter_list.sort()
ll_count = upperbound(isx_filter_parms.filters)

// loop thru and highlight previously selected filters and set their id's
for ll_idx = 1 to ll_count
	for ll_row = 1 to ll_rowcount
		if isx_filter_parms.filters[ll_idx].col_name = &
			dw_filter_list.object.elem_name[ll_row] then
			// select row in dw_filter_list 
			dw_filter_list.object.compute_0005[ll_row] = isx_filter_parms.filters[ll_idx].filter_id
			dw_filter_list.selectrow(ll_row,TRUE)					// FNC 08/04/98						
			exit
		end if
	next
next

dw_filter_list.SetRedraw(TRUE)
end event

type dw_filter_list from u_dw within w_qe_filter_create
string accessiblename = "Filter List"
string accessibledescription = "Filter List"
accessiblerole accessiblerole = clientrole!
integer x = 37
integer y = 32
integer width = 1714
integer height = 1008
integer taborder = 10
string dataobject = "d_qe_filter_list"
boolean vscrollbar = true
end type

event constructor;call super::constructor;this.SetTransObject(stars2ca)
this.of_SetUpdateable(FALSE)
this.of_MultiSelect(TRUE)
this.of_SetTrim( TRUE )	//GaryR	05/17/01
end event

event clicked;////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	Clicked										W_QE_Filter_Create.DW_Filter_List
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// When clicked will verify if the filter is referenced in another level in the
//	query. If so, it does not allow the user to deselect the row.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Powerbuilder documented parameters	
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author	Date			Description
// ------	----			-----------
//	FNC		08/04/98		Track 1265.
/////////////////////////////////////////////////////////////////////////////

boolean lb_filter_used

If IsSelected(row) then
	lb_filter_used = FALSE
	parent.event ue_check_filter_id(dw_filter_list.object.elem_name[row],lb_filter_used)
	if lb_filter_used = TRUE then
		messagebox('WARNING','Cannot deselect row. It is reference in another level of the query')
		ib_allow_unclick = FALSE
	else
		Super::EVENT clicked(xpos,ypos,row,dwo)		
		ib_allow_unclick = TRUE
	end if
else
	Super::EVENT clicked(xpos,ypos,row,dwo)		
	ib_allow_unclick = TRUE
end if


end event

event rowfocuschanged;if ib_allow_unclick then
	Super::EVENT RowFocusChanged(currentrow)
end if
end event

type cb_ok from u_cb within w_qe_filter_create
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 581
integer y = 1156
integer taborder = 20
string text = "&OK"
boolean default = true
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	clicked										cb_Ok
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// When clicked will open w_qe_filter_name passing it the list of selected columns.  
//	Then will close the window.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/07/98		Created.
//
//	FDG			03/17/98		Changed variables to conform to standards.
// FNC			06/03/98		Track 1202. Display Col desc in filter name window.
//									Must save col desc in filter structure.
// FNC			08/04/98		Track 1265. Call new event W_QE_Filter_Create.
//									UE_Check_Filter_ID to set filter_used so that the 
//									filter_name window will be able to determine if a 
//									change may be made.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

sx_all_filter_info lsx_all_filter_info

Long ll_SelectedRow, ll_FilterIndex, ll_MaxRow
boolean lb_filter_used

ll_MaxRow = dw_filter_list.RowCount()

ll_SelectedRow = dw_filter_list.GetSelectedRow(ll_SelectedRow)

DO WHILE ll_SelectedRow > 0
	/* loop thru datawindow pulling out selected columns and load into 
	sx_all_filter_info: */
	ll_FilterIndex++
	lsx_all_filter_info.filters[ll_FilterIndex].col_name = dw_filter_list.object.elem_name[ll_SelectedRow]
	// FNC 06/03/98
	lsx_all_filter_info.filters[ll_FilterIndex].col_desc = mid(dw_filter_list.object.compute_0001[ll_SelectedRow],4)	
	lsx_all_filter_info.filters[ll_FilterIndex].data_type = dw_filter_list.object.elem_data_type[ll_SelectedRow]
	lsx_all_filter_info.filters[ll_FilterIndex].tbl_type = dw_filter_list.object.elem_tbl_type[ll_SelectedRow] 
	lsx_all_filter_info.filters[ll_FilterIndex].filter_id = dw_filter_list.object.compute_0005[ll_SelectedRow]
	// FNC 08/04/98 Start
	lb_filter_used = FALSE	
	parent.event ue_check_filter_id(dw_filter_list.object.elem_name[ll_SelectedRow], &
		lb_filter_used)	
	lsx_all_filter_info.filters[ll_FilterIndex].filter_used = lb_filter_used	
	// FNC 08/04/98 End
	ll_SelectedRow = dw_filter_list.GetSelectedRow(ll_SelectedRow)
LOOP

openwithparm(w_qe_filter_name,lsx_all_filter_info)

lsx_all_filter_info = message.PowerObjectParm

If UpperBound(lsx_all_filter_info.filters[]) > 0 Then
	//check for cancel in w_qe_filter_name
	if lsx_all_filter_info.filters[1].level_num = -1 then return
End If

closewithreturn(parent,lsx_all_filter_info)
end event

type cb_cancel from u_cb within w_qe_filter_create
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 919
integer y = 1156
integer taborder = 30
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////
// Event/Function								Object				
//	--------------								------				
//	clicked										cb_Cancel
/////////////////////////////////////////////////////////////////////////////
//	Description
//	-----------
// Set level number to -1 so that w_query_engine knows not to continue.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//		Passed by	Argument		Datatype				Description
//		---------	--------		--------				-----------
//		None.
/////////////////////////////////////////////////////////////////////////////
//	RETURNS
//		Datatype		Value			Description
//		--------		-----			-----------
//		None.		
/////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
// Author			Date			Description
// ------			----			-----------
//	J.Mattis			01/07/98		Created.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

// Set level number to -1 so that w_query_engine knows not to continue.

isx_filter_parms.filters[1].level_num = -1
closewithreturn(parent,isx_filter_parms)

end event

