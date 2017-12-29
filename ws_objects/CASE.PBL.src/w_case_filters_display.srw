$PBExportHeader$w_case_filters_display.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_filters_display from w_master
end type
type dw_1 from u_dw within w_case_filters_display
end type
type sle_subset_id from singlelineedit within w_case_filters_display
end type
type st_criteria_id from statictext within w_case_filters_display
end type
type st_row_count from statictext within w_case_filters_display
end type
type cb_exit from u_cb within w_case_filters_display
end type
end forward

global type w_case_filters_display from w_master
string accessiblename = "Subset Filter Details"
string accessibledescription = "Subset Filter Details"
accessiblerole accessiblerole = windowrole!
integer x = 41
integer y = 0
integer width = 2752
integer height = 1676
string title = "Subset Filter Details"
long backcolor = 67108864
dw_1 dw_1
sle_subset_id sle_subset_id
st_criteria_id st_criteria_id
st_row_count st_row_count
cb_exit cb_exit
end type
global w_case_filters_display w_case_filters_display

type variables
int in_nbr_rows
string  in_criteria_type
string in_case_active
string in_subset_id
//String iv_message    //VAV 4.0 2/5/98
sx_subset_ids istr_subset_ids   //VAV 4.0 2/5/98
end variables

event open;call super::open;/*VAV 4.0 2/11/98-There will now be one filter vals table for each subset. 
						The SQL for DW_1 must be modified before it is retrieved since 
						the table name from which the data is retrieved is dependent 
						on the subset id. Currently the datawindow control can be set 
						to one of two different datawindows. Since the SQL will be modified 
						before the datawindow is retrieved, the datawindow control 
						can be set to one datawindow. The datawindow that DW_1 
						should be permanantly associated with is D_Ind_Filter_Display.  */
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//						Set lt_trans data type n_tr (instead of type transaction)
long ll_rows
//String ls_case_id,ls_case_spl,ls_case_ver	//VAV 4.0 2/5/98
n_tr lt_trans											// FDG 02/20/01
String ls_select          							//VAV 4.0 1/30/98
int li_rc												//VAV 4.0 1/30/98

Setpointer(hourglass!)
setmicrohelp(w_main,'Opening Criteria Display Window')

cb_exit.default = true


ls_select = 'Select Filter_Id , Filter_String ,Filter_Num ,Filter_Date ,Filter_Money'+ &    
 			  ' From Sub_Filter_Vals_' + istr_subset_ids.subset_id

DW_1.Object.DataWindow.Table.Select=ls_select
lt_trans=stars2ca

If settransobject(dw_1,lt_trans) < 1 then
	lt_trans.of_commit()
	If lt_trans.sqlcode <> 0 Then
		errorbox(lt_trans,'Error Commiting to Stars2')
		RETURN
	End If	
	Messagebox('EDIT','Unable to Set Transaction Object for Subset Criteria')
	cb_exit.PostEvent(Clicked!)
	RETURN
End If

/* VAV 4.0 1/30/98 - The subset name will now be displayed instead 
							of the internal subset id. A function in NVO_Subset_Functions 
							must be called to convert  the subset id into the subset name. 
							Accordingly, replace the following code:
sle_subset_id.text=gv_subset_id
with:										*/

//VAV 4.0 1/30/98
//Declare an instance variable of type NVO_Subset_Functions
NVO_Subset_Functions lnv_Subset_Functions

//Create the subset functions user object with the following statement:
lnv_Subset_Functions = Create NVO_Subset_Functions

/*	VAV 4.0 2/5/98 - the following code removed:
	istr_subset_ids.subset_id = gv_subset_id
	istr_subset_ids.subset_case_id = ls_case_id
	istr_subset_ids.subset_case_spl = ls_case_spl
	istr_subset_ids.subset_case_ver = ls_case_ver */

li_rc = lnv_subset_functions.uf_set_structure(istr_subset_ids)
If li_rc <> 1 then
	MessageBox('Edit','Error retrieving external subset id')
	cb_exit.PostEvent(Clicked!)
	Destroy lnv_subset_functions
	RETURN
End if

li_rc = lnv_subset_functions.uf_retrieve_subset_name()
If li_rc <> 1 then
	Messagebox('Edit','Error retrieving external subset id')
	cb_exit.PostEvent(Clicked!)
	Destroy lnv_subset_functions
	RETURN
End if
istr_subset_ids = lnv_subset_functions.uf_get_structure()

sle_subset_id.text = istr_subset_ids.subset_name
//	VAV 4.0 1/30/98 - end of hew section

/* VAV 4.0 1/30/98 - Since there will only be one datawindow 
							there is only one retrieve statement required. 
							The following code had been replaced:
If iv_message = 'SUB' then
	ll_rows = retrieve(dw_1,ls_case_id,ls_case_spl,ls_case_ver,gv_subset_id)
ElseIf iv_message = 'SUBIND' then
	ll_rows = retrieve(dw_1,gv_subset_id)
End IF
With:              				*/
ll_rows = retrieve(dw_1,istr_subset_ids.subset_id)   //VAV 4.0 1/30/98

lt_trans.of_commit()						// FDG 02/20/01
If lt_trans.sqlcode <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	RETURN
End If	

If ll_rows  <= 0 then
	Messagebox('EDIT','Unable to Retrieve Criteria Data')
	cb_exit.PostEvent(Clicked!)
	RETURN
Else
	st_row_count.text = string(ll_rows)
End If

//KMM Clear out message parm (PB Bug)
SetNull(message.stringparm)

setmicrohelp(w_main,'Ready')

Destroy(lnv_subset_functions)			//VAV 4.0 1/30/98 - to destroy the NVO
end event

on w_case_filters_display.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.sle_subset_id=create sle_subset_id
this.st_criteria_id=create st_criteria_id
this.st_row_count=create st_row_count
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.sle_subset_id
this.Control[iCurrent+3]=this.st_criteria_id
this.Control[iCurrent+4]=this.st_row_count
this.Control[iCurrent+5]=this.cb_exit
end on

on w_case_filters_display.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.sle_subset_id)
destroy(this.st_criteria_id)
destroy(this.st_row_count)
destroy(this.cb_exit)
end on

event ue_preopen;call super::ue_preopen;//iv_message=message.stringparm    //VAV 4.0 2/5/98

//VAV 4.0 2/5/98
istr_subset_ids = Message.PowerObjectParm   
SetNull(message.PowerObjectParm)
//VAV 4.0 2/5/98 - end of new section
end event

type dw_1 from u_dw within w_case_filters_display
string accessiblename = "Case Filter Display"
string accessibledescription = "Case Filter Display"
accessiblerole accessiblerole = clientrole!
string tag = "colorfixed"
integer x = 32
integer y = 140
integer width = 2647
integer height = 1228
integer taborder = 10
string dataobject = "d_case_filter_display"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type sle_subset_id from singlelineedit within w_case_filters_display
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = textrole!
integer x = 421
integer y = 16
integer width = 832
integer height = 88
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_criteria_id from statictext within w_case_filters_display
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 28
integer width = 361
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_row_count from statictext within w_case_filters_display
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 46
integer y = 1416
integer width = 274
integer height = 80
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_exit from u_cb within w_case_filters_display
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2331
integer y = 1396
integer width = 338
integer height = 108
integer taborder = 20
string text = "&Close"
boolean default = true
end type

on clicked;close (parent)
end on

