HA$PBExportHeader$w_qe_filter_name.srw
$PBExportComments$(Inherited from w_master)
forward
global type w_qe_filter_name from w_master
end type
type dw_filter_name from u_dw within w_qe_filter_name
end type
type cb_ok from u_cb within w_qe_filter_name
end type
type cb_cancel from u_cb within w_qe_filter_name
end type
end forward

global type w_qe_filter_name from w_master
long backcolor = 67108864
string accessiblename = "Filter Name"
string accessibledescription = "Filter Name"
accessiblerole accessiblerole = windowrole!
integer x = 814
integer y = 524
integer width = 2043
integer height = 1344
string title = "Filter Name"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_filter_name dw_filter_name
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_qe_filter_name w_qe_filter_name

type variables
PRIVATE:

sx_all_filter_info    isx_all_filter_info
Integer                  il_filter_count

n_cst_filter in_cst_filter // 02/09/06 HYL Track 4648d
Boolean ib_cancelled // 02/21/06 HYL Track 4648d
end variables

on w_qe_filter_name.create
int iCurrent
call super::create
this.dw_filter_name=create dw_filter_name
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter_name
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_qe_filter_name.destroy
call super::destroy
destroy(this.dw_filter_name)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event ue_postopen;call super::ue_postopen;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_qe_filter_name			ue_PostOpen
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Load dw_filter_name with column names and new filter_ids unless column has previously 
// defined filter id.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/08/98		Created.
//
//	FDG			03/19/98		Track 114.  Use the Count service to determine
//									if an entered filter ID already exists.
//									Change names to conform to standards.
// 
// FNC			06/03/98		Track 1202. Move new field in structure, col_desc
//									to datawindow instead of col_name.
//	GaryR			07/24/01		Track 2344d	Error with filter names.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

isx_all_filter_info = message.PowerObjectParm

Integer li_idx
Long ll_Row

IF NOT IsValid(in_cst_filter) THEN
	in_cst_filter = CREATE n_cst_filter // 02/09/06 HYL Track 4648d
END IF

il_filter_count = upperbound(isx_all_filter_info.filters[])

//	Use the "Select Count" service to edit filter IDs.
This.of_set_nvo_count (TRUE)				//	FDG 03/19/98

dw_filter_name.SetRedraw(FALSE)

for li_idx = 1 to il_filter_count
	ll_row = dw_filter_name.insertrow(0)
	dw_filter_name.object.col_name[ll_row] = isx_all_filter_info.filters[li_idx].col_desc
	
	//	GaryR			07/24/01		Track 2344d	Error with filter names.
	//if isx_all_filter_info.filters[li_idx].filter_id <> '' then
	if Trim( isx_all_filter_info.filters[li_idx].filter_id ) <> '' then	
		dw_filter_name.object.filter_id[ll_row] = isx_all_filter_info.filters[li_idx].filter_id
	else
		dw_filter_name.object.filter_id[ll_row] = fx_get_next_key_id("FILTER")
	end if
next

dw_filter_name.SetRedraw(TRUE)
end event

event close;call super::close;

IF IsValid(in_cst_filter) THEN
	DESTROY n_cst_filter // 02/09/06 HYL Track 4648d
END IF
end event

type dw_filter_name from u_dw within w_qe_filter_name
string accessiblename = "Filter Name"
string accessibledescription = "Filter Name"
accessiblerole accessiblerole = clientrole!
integer x = 32
integer y = 36
integer width = 1957
integer height = 1044
integer taborder = 10
string dataobject = "d_filter_name"
boolean vscrollbar = true
end type

event constructor;call super::constructor;this.SetTransObject(stars2ca)
this.of_SetUpdateable(FALSE)
this.of_SingleSelect(TRUE)
end event

event itemchanged;call super::itemchanged;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	dw_filter_name				ItemChanged
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// If a filter ID was entered, make sure it is unique.
// defined filter id.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	None.		
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------		----			-----------
//	FDG		03/19/98		Track 114.  Created.
//	HYL		02/20/06		Track 4648d Reject invalid characters for table name
/////////////////////////////////////////////////////////////////////////////

String	ls_colname,		&
			ls_sql,			&
			ls_value
integer	li_num_filters,li_filter
Long		ll_filter_count

IF ib_cancelled THEN RETURN // 02/21/06 HYL Track 4648d

ls_colname	=	dwo.Name

CHOOSE CASE ls_colname
	CASE 'filter_id'
		ls_value	=	data
		IF NOT in_cst_filter.of_isvalid_tablename(ls_value) THEN
			Messagebox('EDIT','Filter Id contains an invalid character.  Please Re-Key')
			RETURN 1
		END IF
		ls_sql	=	"Select Count(*) from filter_cntl where filter_id = '"  + &
						Upper( ls_value )	+	"'"
		ll_filter_count	=	inv_count.uf_get_count(ls_sql)
		IF	ll_filter_count	>	0		THEN
			MessageBox ('Error', 'Filter ID: ' + ls_value	+	&
							' already exists.')
			This.SetColumn ('filter_id')
			Return 1			//	Reject the value
		END IF
END CHOOSE

end event

event itemerror;// Override to reject the value without an itemerror message

Return 1
end event

event editchanged;call super::editchanged;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	dw_filter_name				EditChanged
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// 
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Documented PB Arguments
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Documented PB Return
/////////////////////////////////////////////////////////////////////////////
// HISTORY

//	Author		Date			Description
// ------		----			-----------
//
//	FNC			08/04/98		Track 1265
//
/////////////////////////////////////////////////////////////////////////////

String	ls_colname,		&
			ls_sql,			&
			ls_value
integer	li_num_filters,li_filter


li_num_filters = upperbound(isx_all_filter_info.filters)

for li_filter = 1 to li_num_filters
	if dw_filter_name.object.filter_id[row] = &
		isx_all_filter_info.filters[li_filter].filter_id then
		if isx_all_filter_info.filters[li_filter].filter_used then
			messagebox('Error', &
			'Cannot change filter id. Filter is referenced on another level')
			dw_filter_name.object.filter_id[row] = isx_all_filter_info.filters[li_filter].filter_id
			return 
		end if
	end if
next


end event

type cb_ok from u_cb within w_qe_filter_name
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
event clicked pbm_bnclicked
integer x = 654
integer y = 1132
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
// When clicked will check the filter_id's for dups, load filter_id's into the structure 
// and close the window.
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
//	FDG			03/19/98		Track 114.  Do an accepttext on dw_filter_name
//									in case something was entered in the filter ID.
//	HYL		02/10/06		Track 4648d Implemented pop-up message when invalid characters are entered for table name in creating background filters.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

n_Ds lds_Filter
lds_filter = CREATE n_Ds
Boolean lb_FilterError
Integer i, li_Row
String ls_sql, s_FilterId

//	FDG 03/19/98 begin
IF	dw_filter_name.AcceptText()	<	0		THEN
	// edit error
	Return
END IF
// FDG 03/19/98 End

//for i = 1 to il_filter_count // 02/09/06 HYL Track 4648d
//	s_FilterId = dw_filter_name.Object.filter_id[i]
//	IF NOT in_cst_filter.of_isvalid_tablename(dw_filter_name.Object.filter_id[i]) THEN
//		Messagebox('EDIT','Filter Id contains an invalid character.  Please Re-Key')
//		dw_filter_name.SelectRow(0, FALSE)
//		dw_filter_name.SelectRow(i, TRUE)
//		dw_filter_name.ScrollToRow(i)
//		DESTROY lds_Filter
//		RETURN
//	END IF
//next

lds_Filter.DataObject = 'd_filter_count'
lds_Filter.SetTransObject(stars2ca)		

/* ds_count - create datastore (n_ds) to hold the count */
for i = 1 to il_filter_count
		s_FilterId = dw_filter_name.Object.filter_id[i]
		IF Not(IsNull(s_FilterId)) Then
			li_Row = lds_Filter.Retrieve(s_FilterId)
		END IF
		IF li_Row > 0 Then
			if IsNull(s_FilterId) OR lds_filter.object.compute_0001[li_Row] > 0 then
				MessageBox("Error","Filter_id is not unique, please enter another.")
				lb_FilterError = TRUE
				exit
			end if
		END IF
		isx_all_filter_info.filters[i].filter_id = dw_filter_name.object.filter_id[i]
next

DESTROY lds_Filter

If lb_FilterError Then RETURN

closewithreturn(parent,isx_all_filter_info)
end event

type cb_cancel from u_cb within w_qe_filter_name
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
event clicked pbm_bnclicked
integer x = 1010
integer y = 1132
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
// Set level number to -1 so that w_qe_filter_list knows not to continue.
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
//	HYL			02/21/06		Track 4648d Allow to cancel by not going through itemchanged event when invalid character is present
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
// Set level number to -1 so that w_qe_filter_list knows not to continue.
ib_cancelled = TRUE // 02/21/06 HYL Track 4648d
isx_all_filter_info.filters[1].level_num = -1
closewithreturn(parent,isx_all_filter_info)
end event

