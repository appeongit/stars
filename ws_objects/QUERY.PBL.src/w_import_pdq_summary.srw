$PBExportHeader$w_import_pdq_summary.srw
forward
global type w_import_pdq_summary from w_master
end type
type cb_cancel from u_cb within w_import_pdq_summary
end type
type cb_print from u_cb within w_import_pdq_summary
end type
type cb_ok from u_cb within w_import_pdq_summary
end type
type st_1 from statictext within w_import_pdq_summary
end type
type dw_import from u_dw within w_import_pdq_summary
end type
type mle_comment from u_mle within w_import_pdq_summary
end type
end forward

global type w_import_pdq_summary from w_master
string accessiblename = "Import Pre Defined Query Summary"
string accessibledescription = "Import Pre Defined Query Summary"
integer width = 2537
integer height = 1412
string title = "PDQ Import Summary"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_filter_dep_inv_type ( long al_row,  string as_inv_type )
event ue_filter_inv_type ( long al_row )
event type integer ue_edit_data ( )
event type integer ue_edit_subset ( long al_row,  string as_subset_name )
cb_cancel cb_cancel
cb_print cb_print
cb_ok cb_ok
st_1 st_1
dw_import dw_import
mle_comment mle_comment
end type
global w_import_pdq_summary w_import_pdq_summary

type variables
Sx_import_pdq_summary	istr_import
dataWindowChild		idwc_dep_inv_type
dataWindowChild		idwc_inv_type
end variables

event ue_filter_dep_inv_type;//*********************************************************************************
// Script Name:	ue_filter_dep_inv_type
//
//	Arguments:		al_row	- current row
//						as_inv_type - selected invoice type
//						
//
// Returns:			N/A
//
//	Description:	This user event will filter the dependent invoice type by the 
//						row and invoice arguments
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

String ls_filter, ls_dep_invoice_type
Long ll_rows

IF dw_import.object.dep_inv_type_required [al_row] <> 'Y' or & 
 	Len ( Trim(as_inv_type) )  =  0 or IsNull(as_inv_type) THEN
	Return
END IF

// Unfilter old data
idwc_dep_inv_type.SetFilter('')
idwc_dep_inv_type.Filter()
// Filter on new data
ls_filter = "stars_rel_rel_id = '"  +  as_inv_type  +  "'"
idwc_dep_inv_type.SetFilter (ls_filter)
idwc_dep_inv_type.Filter()

//Scroll to the first row if only one choice available
ll_rows = idwc_dep_inv_type.RowCount()
If ll_rows = 1 then
	ls_dep_invoice_type = idwc_dep_inv_type.GetItemString(1,'compute_0001')
	idwc_dep_inv_type.SelectRow(1,TRUE)
	dw_import.object.dep_inv_type[al_row] = ls_dep_invoice_type
End If

end event

event ue_filter_inv_type;//*********************************************************************************
// Script Name:	ue_filter_inv_type
//
//	Arguments:		al_row	- current row
//						
//
// Returns:			N/A
//
//	Description:	This user event will filter the invoice type of the 
//						row argument
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//	05/08/00	FDG	Track 2269d.  Edit al_row to prevent an "Invalid row range" error.
//						dw_import.rowfocuschanged can pass zero to this event.
//
//*********************************************************************************

String ls_base_type, ls_tbl_rel, ls_inv_type, ls_filter, ls_invoice_type
Long ll_rows

// FDG 05/08/00 - Edit the row
IF	IsNull(al_row)			&
OR	al_row	<	1			THEN
	Return
END IF
// FDG 05/08/00 - end


//If the base type = 'AN', then the invoice type is an ancillary table.  
//If this occurs the invoice type should already have a value.  
//If so, then this should be the only entry otherwise, filter by base type. 

ls_base_type  = dw_import.object.base_type [al_row]
ls_inv_type  = left(dw_import.object.inv_type [al_row],2)
ls_tbl_rel  = dw_import.object.tbl_rel [al_row]
IF  ls_tbl_rel =  'AN'  THEN
	IF  Len (ls_inv_type)  <  0  THEN
		// Get ancillary invoice types only
		idwc_inv_type.SetFilter('')
		idwc_inv_type.Filter()
		ls_filter  =  "stars_rel_rel_type = 'AN'"
		idwc_inv_type.SetFilter (ls_filter)
		idwc_inv_type.Filter()
	ELSE
		// Get the current invoice type only
		idwc_inv_type.SetFilter('')
		idwc_inv_type.Filter()
		ls_filter  =  "stars_rel_id_2 = '"  +  ls_inv_type  +  "'"
		idwc_inv_type.SetFilter (ls_filter)
		idwc_inv_type.Filter()
	END IF
//	Return
ELSE
	//Filter based on base type.
	idwc_inv_type.SetFilter('')
	idwc_inv_type.Filter()
	// Filter on new data
	ls_filter = "stars_rel_key6 = '"  +  ls_base_type  +  "'"
	idwc_inv_type.SetFilter (ls_filter)
	idwc_inv_type.Filter()
End IF

//Scroll to the first row if only one choice available
ll_rows = idwc_inv_type.RowCount()
If ll_rows = 1 then
	ls_invoice_type = idwc_inv_type.GetItemString(1,'compute_0001')
	idwc_inv_type.SelectRow(1,TRUE)
	dw_import.object.inv_type[al_row] = ls_invoice_type
End If

//Filter the dependent table DDDW based on the invoice type.
This.Event  ue_filter_dep_inv_type (al_row, ls_inv_type)

end event

event ue_edit_data;//*********************************************************************************
// Script Name:	ue_edit_data
//
//	Arguments:		N/A
//						
//
// Returns:			 1 = continue
//						-1 = exit processing
//
//	Description:	This user event will edit user entered data in the summary window
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

long ll_rowcount, ll_row

//This event is triggered when the OK button is pressed.  
//This event will loop through all rows in dw_import to determine 
//if any data has not been entered. 
ll_rowcount  =  dw_import.RowCount()
FOR  ll_row  =  1  TO  ll_rowcount
	IF  dw_import.object.inv_type [ll_row]  =  '' &
		or IsNull(dw_import.object.inv_type [ll_row]) THEN
		MessageBox ('Error','Data Source is required')
		dw_import.ScrollToRow(ll_row)
		dw_import.SetColumn ('inv_type')
		dw_import.SetFocus()
		Return -1
	END IF
	IF  dw_import.object.dep_inv_type_required [ll_row]  =  'Y'  &
			AND (dw_import.object.dep_inv_type [ll_row]  = '' & 
					or IsNull(dw_import.object.dep_inv_type [ll_row])) THEN
		MessageBox ('Error','Additional Data Source is required')
		dw_import.ScrollToRow(ll_row)
		dw_import.SetColumn ('dep_inv_type')
		dw_import.SetFocus()
		Return -1
	END IF
	IF  dw_import.object.subset_required [ll_row]  =  'Y'  &
			AND (dw_import.object.subset_name [ll_row]  =  '' &
					or IsNull(dw_import.object.subset_name [ll_row])) THEN
		MessageBox ('Error','A subset is required')
		dw_import.ScrollToRow(ll_row)
		dw_import.SetColumn ('subset_name')
		dw_import.SetFocus()
		Return -1
	END IF
NEXT
Return 1



end event

event ue_edit_subset;//*********************************************************************************
// Script Name:	ue_edit_subset	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	This user event will edit the user entered subset to be sure 
//						it is valid and contains the proper invoice type.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Boolean lb_invoice_match
Integer li_rc
Long ll_rows, ll_current_row, ll_row
Nvo_Subset_Functions lnv_Subset_Functions 
N_ds lds_sub_step_cntl
Sx_subset_ids lstr_subset_ids
String ls_subset_id, ls_inv_type, ls_case_id

ll_current_row = al_row
lnv_Subset_Functions =  Create Nvo_Subset_Functions

lstr_subset_ids.subset_name = as_subset_name
lnv_subset_functions.uf_set_structure(lstr_subset_ids)
ll_rows = lnv_subset_functions.uf_select_links_using_subset_name()
if ll_rows < 1 then
		messagebox('Error','Error determining internal subset id processing cannot continue')
		If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)
		return -1
elseif ll_rows > 1 then
		li_rc = Openwithparm(w_subset_cross_reference_list,lstr_subset_ids)
		if li_rc = 1 then
			lstr_subset_ids = message.Powerobjectparm
			SetNull(message.Powerobjectparm)
			if lstr_subset_ids.subset_case_id <> '' then	
				//continue because one row selected
			else														
				Messagebox('EDIT','Subset id not set, case id is empty')		
				If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)
				return -1												
			end if													
		else
			messagebox('WARNING',' Unable to set subset id processing cannot continue')
			If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)
			return -1
		end if
else
		//one row found get structure
		lstr_subset_ids = lnv_subset_functions.uf_get_structure()	
End IF

//Edit selected subset to be sure it contains the proper invoice type.
ls_subset_id =  lstr_subset_ids.subset_id
ls_inv_type = left(dw_import.object.inv_type[ll_current_row],2)
lb_invoice_match = false

lds_sub_step_cntl  =  CREATE  n_ds
lds_sub_step_cntl.DataObject = 'd_sub_step_cntl'
lds_sub_step_cntl.settransobject(stars2ca)
ll_rows = lds_sub_step_cntl.Retrieve(ls_subset_id)

For ll_row = 1 to ll_rows
		If lds_sub_step_cntl.Object.inv_type[ll_row] = ls_inv_type and &
			lds_sub_step_cntl.Object.num_rows[ll_row] > 0 then
			lb_invoice_match = true
			Exit
		End If
Next
			
If lb_invoice_match then
		//Invoice matches so check security
		ls_case_id = lstr_subset_ids.subset_case_id +lstr_subset_ids.subset_case_spl +lstr_subset_ids.subset_case_ver
		li_rc = lnv_Subset_Functions.UF_Determine_Case_Security(ls_case_id)
		if li_rc = 0 then
				//security cleared
		elseif li_rc = 100 then
				Messagebox('EDIT ERROR','This subset is attached to a Secured Case.  You have insufficient privileges to use it.')
				If IsValid(lds_sub_step_cntl) then Destroy(lds_sub_step_cntl)
				If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)
				return -1
		else
				Messagebox('EDIT ERROR','Cannot determine case security for this subset.  You may not use it.')
				If IsValid(lds_sub_step_cntl) then Destroy(lds_sub_step_cntl)
				If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)
				return -1
		end if
		dw_import.object.subset_name[ll_current_row] = lstr_subset_ids.subset_name
		dw_import.object.case_id[ll_current_row] = lstr_subset_ids.subset_case_id
		dw_import.object.case_spl[ll_current_row] = lstr_subset_ids.subset_case_spl
		dw_import.object.case_ver[ll_current_row] = lstr_subset_ids.subset_case_ver
Else
		MessageBox ('Error','Subset: ' + as_subset_name + ' does not contain invoice type: ' &
									+ ls_inv_type + '. ~nPlease choose another subset.')
		If IsValid(lds_sub_step_cntl) then Destroy(lds_sub_step_cntl)
		If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)
		return -1
End If

If IsValid(lds_sub_step_cntl) then Destroy(lds_sub_step_cntl)
If IsValid(lnv_Subset_Functions) then Destroy(lnv_Subset_Functions)

Return 1
end event

on w_import_pdq_summary.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.cb_ok=create cb_ok
this.st_1=create st_1
this.dw_import=create dw_import
this.mle_comment=create mle_comment
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_import
this.Control[iCurrent+6]=this.mle_comment
end on

on w_import_pdq_summary.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.dw_import)
destroy(this.mle_comment)
end on

event ue_preopen;//*********************************************************************************
// Script Name:	ue_preopen
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Place passed message into structure
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

istr_import  =  Message.PowerObjectParm
SetNull (Message.PowerObjectParm)

end event

event open;call super::open;//*********************************************************************************
// Script Name:	open	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Populate summary window; get handle to child datawindow and retrieve
//                info; filter invoice types, if only choice select it.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************
	
Long ll_row, ll_rowcount

//Move the data to the window.
mle_comment.text  =  istr_import.comments
dw_import.object.data  =  istr_import.ds_import_pdq_summary.object.data

//Retrieve drop down datawindows
dw_import.GetChild ('dep_inv_type', idwc_dep_inv_type)
idwc_dep_inv_type.SetTransObject (Stars2ca) 
idwc_dep_inv_type.Retrieve()

dw_import.GetChild ('inv_type', idwc_inv_type)
idwc_inv_type.SetTransObject (Stars2ca) 
idwc_inv_type.Retrieve()

// Filter the Invoice type for all rows so levels with only one choice
// are selected.  Filter in decending order so the first row is active.
ll_rowcount = dw_import.RowCount()
ll_row = dw_import.RowCount()
For ll_row = ll_rowcount to 1 STEP -1
	This.Event  ue_filter_inv_type(ll_row)
Next


end event

type cb_cancel from u_cb within w_import_pdq_summary
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 2039
integer y = 1212
integer taborder = 50
string text = "&Cancel"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_cancel.clicked	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Cancel processing and return to QE  
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

istr_import.message = 'CANCEL'
setmicrohelp(w_main,'Request cancelled')
CloseWithReturn(Parent,istr_import)
end event

type cb_print from u_cb within w_import_pdq_summary
string accessiblename = "Print"
string accessibledescription = "Print"
integer x = 1102
integer y = 1212
integer taborder = 40
string text = "&Print"
end type

event clicked;//*********************************************************************************
// Script Name:	cb_print.clicked	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Print the contents of the datawindow.
//		
//
//*********************************************************************************
//	
// 11/24/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Long	ll_Job

SetPointer (HourGlass!)

ll_Job	=	PrintOpen( )

w_import_pdq_summary.Print(ll_Job, 500,1000)


PrintClose(ll_Job)
end event

type cb_ok from u_cb within w_import_pdq_summary
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 165
integer y = 1212
integer taborder = 30
string text = "&OK"
boolean default = true
end type

event clicked;//*********************************************************************************
// Script Name:	cb_ok.clicked	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Edit entered invoice types, if no errors return to QE and complete 
//						import processing.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

integer li_rc

dw_import.AcceptText()

li_rc = Parent.Event ue_edit_data()
If li_rc < 0 then
	Return
End IF
istr_import.message = 'COMPLETE'
istr_import.ds_import_pdq_summary.object.data = 	dw_import.object.data
CloseWithReturn(Parent,istr_import)
end event

type st_1 from statictext within w_import_pdq_summary
string accessiblename = "Comments"
string accessibledescription = "Comments"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 12
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Comments:"
boolean focusrectangle = false
end type

type dw_import from u_dw within w_import_pdq_summary
string accessiblename = "Import Options"
string accessibledescription = "Import Options"
integer x = 23
integer y = 352
integer width = 2487
integer height = 828
integer taborder = 20
string dataobject = "d_import_pdq_summary"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;//*********************************************************************************
// Script Name:	dw_import.itemchanged	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	If invoice selected by user, filter dependent invoices. 
//						If the user enters a subset id it will validate it.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Integer li_rc
String ls_inv_type

If  this.getcolumnname() = 'inv_type' then
	ls_inv_type = left(data,2)
	Parent.event ue_filter_dep_inv_type(row,ls_inv_type)
	dw_import.Object.subset_name[row] = ''
End If

IF this.getcolumnname() = 'subset_name' then
	//If subset lookup used do not edit user entered subset
	If dw_import.object.subset_name [row] = data then
		Return
	End If
	
	li_rc = Parent.event ue_edit_subset(row,data)
	If li_rc < 0 then
		dw_import.object.subset_name[row] = ''
		dw_import.ScrollToRow(row)
		dw_import.SetColumn ('subset_name')
		dw_import.SetFocus()
		Return 2 
	End If
End If

end event

event rowfocuschanged;call super::rowfocuschanged;//*********************************************************************************
// Script Name:	rowfocuschanged	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	Trigger user event to filter dependent invoice types
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Parent.Event ue_filter_inv_type(currentrow)
end event

event clicked;call super::clicked;//*********************************************************************************
// Script Name:	dw_import.clicked	
//
//	Arguments:		N/A
//						
//
// Returns:			N/A
//
//	Description:	If invoice selects the dependent table before choosing the main 
//						table, stop them from choosing a dependent.
//		
//
//*********************************************************************************
//	
// 12/03/99	AJS	Stars 4.5.	Created
//
//*********************************************************************************

Long ll_row

If dwo.Name = 'dep_inv_type' then
	ll_row = row
	If ll_row > 0 then
		if dw_import.object.dep_inv_type_required [ll_row]  =  'Y'  &
		   and (dw_import.object.inv_type [ll_row]  =  '' &
			or IsNull(dw_import.object.inv_type [ll_row])) THEN
			MessageBox ('Error','Data Source is required')
			dw_import.ScrollToRow(ll_row)
			dw_import.SetColumn ('inv_type')
			dw_import.SetFocus()
			Return 1
		end if
	End If
End If

If dwo.Name = 'subset_name' then
	ll_row = row
	If ll_row > 0 then
		if dw_import.object.subset_required [ll_row]  =  'Y'  &
		   and (dw_import.object.inv_type [ll_row]  =  '' &
			or IsNull(dw_import.object.inv_type [ll_row])) THEN
			MessageBox ('Error','Data Source is required')
			dw_import.ScrollToRow(ll_row)
			dw_import.SetColumn ('inv_type')
			dw_import.SetFocus()
			Return 1
		end if
	End If
End If
end event

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

long ll_current_row

//Before opening w_subset_use, the following Globals must be set:
gv_subset_tbl_type = gv_active_invoice	
gv_from = 'U'
gv_result = 0

ll_current_row = dw_import.GetRow()
If dw_import.object.inv_type [ll_current_row]  =  '' &
			or IsNull(dw_import.object.inv_type [ll_current_row]) then
			MessageBox ('Error','Data Source is required')
			Dw_import.ScrollToRow(ll_current_row)
			Dw_import.SetColumn ('inv_type')
			Dw_import.SetFocus()
			Return 
End IF

sx_subset_use lstr_subset_use
lstr_subset_use.inv_type = left(dw_import.object.inv_type [ll_current_row],2)
OpenWithParm (w_subset_use,lstr_subset_use)	

//On return use active subset to populate structure
If gv_result = 100 then
	//Closed out of subset use do not set subset id
Else
	dw_import.object.subset_name [ll_current_row] = gc_active_subset_name
	dw_import.object.case_id[ll_current_row] = left(gc_active_subset_case,10)
	dw_import.object.case_spl[ll_current_row] = mid(gc_active_subset_case,11,2)
	dw_import.object.case_ver[ll_current_row] = mid(gc_active_subset_case,13,2)
End If
end event

type mle_comment from u_mle within w_import_pdq_summary
string accessiblename = "Import Comments"
string accessibledescription = "Import Comments"
integer x = 23
integer y = 88
integer width = 2487
integer height = 244
string facename = "System"
boolean vscrollbar = true
integer limit = 255
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

