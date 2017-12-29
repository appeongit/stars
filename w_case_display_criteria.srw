HA$PBExportHeader$w_case_display_criteria.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_display_criteria from w_master
end type
type cb_filter from u_cb within w_case_display_criteria
end type
type dw_1 from u_dw within w_case_display_criteria
end type
type sle_criteria_id from singlelineedit within w_case_display_criteria
end type
type st_criteria_id from statictext within w_case_display_criteria
end type
type cb_stop from u_cb within w_case_display_criteria
end type
type st_row_count from statictext within w_case_display_criteria
end type
type cb_exit from u_cb within w_case_display_criteria
end type
end forward

global type w_case_display_criteria from w_master
string accessiblename = "Criteria View"
string accessibledescription = "Criteria View"
accessiblerole accessiblerole = windowrole!
integer x = 457
integer y = 364
integer width = 2752
integer height = 1676
string title = "Criteria View"
long backcolor = 67108864
cb_filter cb_filter
dw_1 dw_1
sle_criteria_id sle_criteria_id
st_criteria_id st_criteria_id
cb_stop cb_stop
st_row_count st_row_count
cb_exit cb_exit
end type
global w_case_display_criteria w_case_display_criteria

type variables
int in_nbr_rows
string  in_criteria_type
string in_case_active
string in_subset_id

// Message.Stringparm
//String  is_parm                                   //VAV 4.0 01/29/98

sx_display_criteria istr_display_criteria   //VAV 4.0 01/29/98
end variables

event open;call super::open;//				w_case_display_criteria.Open event

/*VAV 4.0 1/29/98-The functionality of the Criteria View window is not changing.  
						The Subset ID in the data window will display the name of 
						the Subset instead of the internal Subset ID. 
						Code for independent subset and independent criteria was removed. */
//	FDG	04/16/01	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	GaryR	11/03/01	Track 2528d	"Save As" subsets appear more than once.
//	FDG	02/20/02	Track 2827d. Remove gc_active_subset_name from criteria.

long ll_rows,ll_pos,ll_len,ll_idx

Integer	li_rc
// String ls_case_id,ls_case_spl,ls_case_ver //VAV 4.0 2/26/98
String ls_string1 = 'CRITERIA_USED_LINE.BY_TYPE = ~'CAS~''
String ls_string2 = 'CRITERIA_USED_LINE.BY_TYPE = ~~~'SMP~~~''
String ls_sql       
String ls_exp2
Boolean lb_filter_used
string ls_rc

//This window displays the criteria Saved from Criteria Screens - CRI
//Sample Subsets - SMP, Subsets Used - SUB, Claim Report - CRC
//Analysis Criteria - CRA.  is_parm has the value being passed
SetPointer(hourglass!)
SetMicrohelp(w_main,'Opening Criteria Display Window')
cb_exit.Default = true

/* VAV 4.0 01/29/98 - The following code should be removed. 
							 The case id is now passed to the window 
							 in the structure sx_display_criteria.

ls_case_id = left(gv_case_active,10)
ls_case_spl = mid(gv_case_active,11,2)
ls_case_ver = mid(gv_case_active,13,2)
in_case_active = gv_case_active 										

*/

//sqlcmd('CONNECT',Stars2ca,'',2)
//sqlcmd('CONNECT',Stars1ca,'',2)


/* VAV 4.0 01/29/98 - The following code replaced.
 
If  is_parm = 'SUBIND'  then
	 //sle_criteria_id.text = gv_active_subset
	 //st_criteria_id.text  = 'Subset ID: '
	//HRB 7/6/95 - changed to put criteria id in sle_criteria_id instead of
	// subset_id - prob#376
	Select subc_crit_id into :sle_criteria_id.text
		from  sub_cntl
		where subc_id  = :gv_subset_id
	Using Stars1ca;
	If Stars1ca.sqlcode <> 0 then
		Errorbox(Stars1ca,'Error Reading Subset Control')
		RETURN
	End If
//	sqlcmd('DISCONNECT',Stars1ca,'',1)  PLB 10/18/95
	COMMIT using STARS1CA;
	If stars1ca.sqlcode <> 0 Then
		errorbox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	in_subset_id = gv_active_subset
ElseIf isvalid(w_case_folder_view) and & 
		is_parm <> 'SUB' and is_parm <> 'SMP' &
			and is_parm <> 'ARC' then
		sle_criteria_id.text = w_case_folder_view.in_link_id
Else 
	//Get the criteria/Sample for SUB/SMP/ARC
	in_subset_id = gv_subset_id
	Select subc_crit_id into :sle_criteria_id.text
		from  sub_cntl_used
		where case_id = :ls_case_id and 
				case_spl = :ls_case_spl and
				case_ver = :ls_case_ver and
				subc_id  = :gv_subset_id
	Using Stars2ca;
	If Stars2ca.sqlcode <> 0 then
		Errorbox(Stars2ca,'Error Reading Subset Control')
		RETURN
	End If
End IF 																				
*/ 

/* VAV 4.0 01/29/98 - The following code replaced the previous one.*/
If IsValid(w_case_folder_view) and (istr_display_criteria.parm = 'CRC' or &
	istr_display_criteria.parm =  'CRA') then
   sle_criteria_id.text = w_case_folder_view.in_link_id
Else 
	Select subc_crit_id into :sle_criteria_id.text
	from  sub_cntl
	where subc_id  = Upper( :istr_display_criteria.subset_ids.subset_id )
	Using Stars2ca;
	If Stars2ca.sqlcode <> 0 then
		ErrorBox(Stars2ca,'Error Reading Subset Control')
		RETURN
	End If
End IF
//VAV 4.0 01/29/98 - End of new section

/* VAV 4.0 01/29/98 - The following code replaced.
If is_parm = 'CRI' then
//	DW_1.dataobject = 'd_criteria_detail'
	DW_1.dataobject = 'd_criteria_clm_rpt_detail'
Elseif is_parm = 'CRA' then
	DW_1.dataobject = 'd_anal_crit'
Elseif is_parm = 'CRC' then
	DW_1.dataobject = 'd_criteria_clm_rpt_detail'
Elseif is_parm = 'SUBIND' then
	DW_1.dataobject = 'd_subset_criteria'
	ls_rc = dw_1.modify("subset_id.text='"+gv_subset_id+"'")
End If
*/
/* VAV 4.0 01/29/98 - The following code replaced the previous code.*/
If istr_display_criteria.parm = 'CRA' then
	dw_1.DataObject = 'd_anal_crit'
	dw_1.of_SetTrim (TRUE)										// FDG 04/16/01
Elseif istr_display_criteria.parm = 'CRC' then
	dw_1.DataObject = 'd_criteria_clm_rpt_detail'
	dw_1.of_SetTrim (TRUE)										// FDG 04/16/01
End If
//VAV 4.0 01/29/98 - End of new section

//fx_set_window_colors(w_case_display_criteria)

If SetTransObject(dw_1,stars2ca) < 1 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		ErrorBox(stars2ca,'Error Commiting to Stars2')
		Return
	End If	
	MessageBox('EDIT','Unable to Set Transaction Object for Subset Criteria ')
	cb_exit.PostEvent(Clicked!)
	RETURN
End If

/* VAV 4.0 01/29/98 - The following code may be removed since 
							 the value 'SMP' is no longer valid.

If is_parm = 'SMP' then
	st_criteria_id.text = 'Sample No.:'
	ls_sql = dw_1.Describe('Datawindow.Table.Select')
	clipboard('')
	clipboard(ls_sql)
	ll_pos = pos(ls_sql,ls_string1)
	If ll_pos <= 0 then
//		Sqlcmd('DISCONNECT',Stars2ca,'',1)   PLB 10/18/95
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return
		End If	
		Messagebox('ERROR','Unable to obtain Datawindow Syntax')
		cb_exit.PostEvent(Clicked!)
		RETURN
	End IF
	ll_len = len(ls_string1)
	ls_sql = Replace(ls_sql,ll_pos,ll_len,ls_string2)
	clipboard('')
	clipboard(ls_sql)
	ls_sql = 'DataWindow.Table.Select = ~'' + ls_sql + '~''
	clipboard('')
	clipboard(ls_sql)
	ls_sql = DW_1.MODIFY(ls_sql)
	If ls_sql <> '' then
//		Sqlcmd('DISCONNECT',Stars2ca,'',1)  PLB  10/18/95
		COMMIT using STARS2CA;
		If stars2ca.of_check_status() <> 0 Then
			errorbox(stars2ca,'Error Commiting to Stars2')
			Return
		End If	
		Messagebox('ERROR','Unable to Change Data Window Syntax ' + ls_sql)
		cb_exit.PostEvent(Clicked!)
		RETURN
	End IF
End If 
*/
//VAV 4.0 01/29/98 - End of removed section

/* VAV 4.0 01/29/98 - The following code replaced.

If is_parm = 'SUB' or is_parm = 'SMP' &
		or is_parm = 'ARC' then
	ll_rows = retrieve(dw_1,ls_case_id,ls_case_spl,ls_case_ver,gv_subset_id)
ElseIf is_parm = 'CRI' then
//	ll_rows = retrieve(dw_1,sle_criteria_id.text)
	ll_rows = retrieve(dw_1,ls_case_id,ls_case_spl,ls_case_ver,sle_criteria_id.text,'CRI')
ElseIf is_parm = 'CRC' then
	ll_rows = retrieve(dw_1,ls_case_id,ls_case_spl,ls_case_ver,sle_criteria_id.text,'CRC')
ElseIf is_parm = 'CRA' then
	ll_rows = retrieve(dw_1,ls_case_id,ls_case_spl,ls_case_ver,sle_criteria_id.text)
ElseIf is_parm = 'SUBIND' then
//	ll_rows = retrieve(dw_1,sle_criteria_id.text)
	ll_rows = retrieve(dw_1,gv_subset_id)			//KMM 7/24/95 Prob#707 Pulls criteria by subset id for a subset
End IF
*/
/* VAV 4.0 01/29/98 - The following code replaced the previous code.*/

If istr_display_criteria.subset_ids.subset_case_id = "NONE" then
	// FDG 04/16/01 - Make sure case_spl and case_ver are properly trimmed
	//istr_display_criteria.subset_ids.subset_case_spl = ''
   //istr_display_criteria.subset_ids.subset_case_ver = ''
	li_rc	=	gnv_sql.of_TrimData (istr_display_criteria.subset_ids.subset_case_spl)
	li_rc	=	gnv_sql.of_TrimData (istr_display_criteria.subset_ids.subset_case_ver)
	// FDG 04/16/01 end
End if

If istr_display_criteria.parm = 'SUB' or istr_display_criteria.parm = 'ARC' then
			// FDG 02/20/02 - remove gc_active_subset_name from criteria
			ll_rows = retrieve(dw_1, &
			istr_display_criteria.subset_ids.subset_case_id, &
			istr_display_criteria.subset_ids.subset_case_spl, &
			istr_display_criteria.subset_ids.subset_case_ver, &
			istr_display_criteria.subset_ids.subset_id )		//	GaryR	11/03/01	Track 2528d
ElseIf istr_display_criteria.parm = 'CRC' then
		 	ll_rows = retrieve(dw_1, &
			istr_display_criteria.subset_ids.subset_case_id, &
		 	istr_display_criteria.subset_ids.subset_case_spl, &
		 	istr_display_criteria.subset_ids.subset_case_ver, &
		 	sle_criteria_id.Text,'CRC')
ElseIf istr_display_criteria.parm = 'CRA' then
			ll_rows = retrieve(dw_1, &
			istr_display_criteria.subset_ids.subset_case_id, &
			istr_display_criteria.subset_ids.subset_case_spl, &
			istr_display_criteria.subset_ids.subset_case_ver, &
			sle_criteria_id.Text)
End If
//VAV 4.0 01/29/98 - End of new section

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	ErrorBox(stars2ca,'Error Commiting to Stars2')
	Return
End If	

If ll_rows  <= 0 then
	MessageBox('EDIT','Unable to Retrieve Criteria Data')
	cb_exit.PostEvent(Clicked!)
	RETURN
Else
	st_row_count.Text = string(ll_rows)
End If

//If is_parm = 'SUB' then		//coming from case folder  //VAV 4.0 1/29/98
If istr_display_criteria.parm = 'SUB' then					//VAV 4.0 1/29/98
	For ll_idx = 1 to ll_rows
		 If left(getitemstring(dw_1,ll_idx,9),1) = '@' then
			 lb_filter_used = true
			 ll_idx = ll_rows
		 End IF
	Next
End IF

/* VAV 4.0 01/29/98 - The following code may be removed

If is_parm = 'SUBIND' then	//coming from independent subset
	For ll_idx = 1 to ll_rows
		 If left(getitemstring(dw_1,ll_idx,"crit_exp2"),1) = '@' then
			 lb_filter_used = true
			 ll_idx = ll_rows
		 End IF
	Next
End IF
*/

//in_criteria_type = is_parm								//VAV 4.0 01/29/98 - code modified with:
in_criteria_type = istr_display_criteria.parm      //VAV 4.0 01/29/98

If lb_filter_used = true then
	cb_filter.Visible = true
End IF

SetPointer(ARROW!)
SetMicrohelp(w_main,'Ready')
end event

on w_case_display_criteria.create
int iCurrent
call super::create
this.cb_filter=create cb_filter
this.dw_1=create dw_1
this.sle_criteria_id=create sle_criteria_id
this.st_criteria_id=create st_criteria_id
this.cb_stop=create cb_stop
this.st_row_count=create st_row_count
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filter
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.sle_criteria_id
this.Control[iCurrent+4]=this.st_criteria_id
this.Control[iCurrent+5]=this.cb_stop
this.Control[iCurrent+6]=this.st_row_count
this.Control[iCurrent+7]=this.cb_exit
end on

on w_case_display_criteria.destroy
call super::destroy
destroy(this.cb_filter)
destroy(this.dw_1)
destroy(this.sle_criteria_id)
destroy(this.st_criteria_id)
destroy(this.cb_stop)
destroy(this.st_row_count)
destroy(this.cb_exit)
end on

event ue_preopen;call super::ue_preopen;/* VAV 4.0 1/29/30 - replaced
is_parm	=	Message.StringParm				      

//KMM Clear out message parm (PB Bug)
SetNull(message.stringParm)
*/

//VAV 4.0 1/29/98
istr_display_criteria = Message.PowerObjectParm   
SetNull(message.PowerObjectParm)
//VAV 4.0 1/29/98 - end of new section
end event

type cb_filter from u_cb within w_case_display_criteria
boolean visible = false
string accessiblename = "Filter Details..."
string accessibledescription = "Filter Details..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1824
integer y = 1396
integer width = 475
integer height = 108
integer taborder = 20
string text = "&Filter Details..."
end type

event clicked;String lv_filters, lv_exp2
Int    lv_idx

//If in_criteria_type = 'SUB' then
//	For lv_idx = 1 to integer(st_row_count.text)in_case_active
//		lv_exp2 = getitemstring(dw_1,lv_idx,9)
//		If left(lv_exp2,1) = '@' then
//			lv_filters = lv_filters + ",'" + mid(lv_exp2,2) + "'"
//		End IF
//	Next
//End IF
//
//If in_criteria_type = 'SUBIND' then
//	For lv_idx = 1 to integer(st_row_count.text)
//		lv_exp2 = getitemstring(dw_1,lv_idx,"crit_exp2")
//		If left(lv_exp2,1) = '@' then
//			lv_filters = lv_filters + ",'" + mid(lv_exp2,2) + "'"
//		End IF
//	Next
//End IF
//lv_filters = mid(lv_filters,2)
//setmicrohelp(w_main,lv_filters)

OpenSheetWithParm(w_case_filters_display,istr_display_criteria.subset_ids,mdi_main_frame,help_menu_position,Layered!) //VAV 4.0 2/5/98 

end event

type dw_1 from u_dw within w_case_display_criteria
string accessiblename = "Criteria Used Print"
string accessibledescription = "Criteria Used Print"
accessiblerole accessiblerole = clientrole!
integer x = 32
integer y = 140
integer width = 2647
integer height = 1228
integer taborder = 10
string dataobject = "d_criteria_used_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type sle_criteria_id from singlelineedit within w_case_display_criteria
string accessiblename = "Criteria ID"
string accessibledescription = "Criteria ID"
accessiblerole accessiblerole = textrole!
integer x = 421
integer y = 20
integer width = 562
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

type st_criteria_id from statictext within w_case_display_criteria
string accessiblename = "Criteria ID"
string accessibledescription = "Criteria ID"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 28
integer width = 379
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Criteria ID:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_stop from u_cb within w_case_display_criteria
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1079
integer y = 1384
integer width = 352
integer height = 108
integer textsize = -16
string text = "Stop"
end type

on clicked;gv_cancel_but_clicked = TRUE
end on

type st_row_count from statictext within w_case_display_criteria
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

type cb_exit from u_cb within w_case_display_criteria
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2331
integer y = 1396
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Close"
boolean default = true
end type

on clicked;close (parent)
end on

