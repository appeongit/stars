$PBExportHeader$w_norm_rpt.srw
$PBExportComments$With the new sort by savings/proc code (inherited from w_parent_rpt)
forward
global type w_norm_rpt from w_parent_rpt
end type
type cb_graph from u_cb within w_norm_rpt
end type
type dw_2 from u_dw within w_norm_rpt
end type
type cbx_threshold from checkbox within w_norm_rpt
end type
type st_dw_ops from statictext within w_norm_rpt
end type
type cb_update from u_cb within w_norm_rpt
end type
end forward

global type w_norm_rpt from w_parent_rpt
string accessiblename = "Norm Analysis Report"
string accessibledescription = "Norm Analysis Report"
integer height = 1696
string title = "Norm Analysis Report"
cb_graph cb_graph
dw_2 dw_2
cbx_threshold cbx_threshold
st_dw_ops st_dw_ops
cb_update cb_update
end type
global w_norm_rpt w_norm_rpt

type variables
string in_selection,in_proc_code,in_spec,in_gr_where
string in_graph_choice//,iv_invoice_type
string parm
boolean iv_process_done
long iv_next_group_ct, iv_dw2_row_ct,iv_rank_num	
int ii_rc
datetime id_from, id_thru, id_payment_from, id_payment_thru
sx_norm_analysis_parms isx_norm_analysis_parms
sx_norm_rpt_parms isx_norm_rpt_parms
end variables

forward prototypes
public function integer wf_binary_sort ()
public function integer wf_update_ctl_rec (long arg_target_row, long arg_dw1_row)
public function int wf_add_ctl_rec (string arg_dw1_proc_code, long arg_i, long arg_new_row)
public function integer wf_goto_row1 ()
end prototypes

public function integer wf_binary_sort ();//  wf_binary_sort    in w_norm_rpt



long dw2_item_ct, ll_rc, rcsi
long dw1_row_ct, dw2_group_ct
long lv_target_row
long lv_search_start_row, lv_search_end_row
long i, i2
string dw1_proc_code, dw2_proc_code, rs


Setpointer(hourglass!)
w_main.SetMicroHelp("Now Executing a Special Sort that Groups Procedure Codes Within Savings.  Please stand by.")
//setmicrohelp(w_main,'Now building the sort keys.')
iv_next_group_ct = 1
dw1_row_ct = dw_1.rowcount()


//  Any data retrieved via w_norm_analysis?  If so, process it.
if dw1_row_ct > 0 then
	//  Process each row of the report (from dw1)
	for i = 1 to dw1_row_ct
		dw1_proc_code = dw_1.GetItemString(i,"proc_code") 
		//  Test if dw2 has any rows yet.
		if iv_dw2_row_ct > 0 then
			iv_process_done = false
			lv_search_start_row = 1
			lv_search_end_row = iv_dw2_row_ct

			//  Start dw2 processing based on the proc code from dw1
			DO UNTIL iv_process_done = true
			lv_target_row = (lv_search_start_row + lv_search_end_row)/2
			if lv_target_row <= 0 then
				//  This is not a possible condition.  It can never be less than 1.
				iv_process_done = true
				messagebox("SYSTEM ERROR 10","While executing the special sort of Procedure Code and Savings, an unexpected result of ' + lv_target_row + ' was encountered.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly, or dropped.")
			end if
			//  Search the midpoint of the current segment of the table.
			dw2_proc_code = dw_2.GetItemString(lv_target_row,1) 

//------------------------------------------------------------------
			if dw1_proc_code = dw2_proc_code then
				//  Hit causes updating of existing proc code control records.
				wf_update_ctl_rec(lv_target_row,i)
			else

//------------------------------------------------------------------
				//  We did not get a hit.  Test if we should go forward in dw2.
				if dw1_proc_code < dw2_proc_code then
					//  are we at the start of the current search range?
					if lv_search_start_row = lv_target_row then
						//  The dw2 row has already been checked or it is the 1st row in the table.  Add the new row ahead of it.
						//  Insert a new row into dw2 and fill it.
						ll_rc   = dw_2.insertrow(lv_search_start_row)
						if ll_rc = -1 then
							//  failed insert row.  This cannot happen.
							iv_process_done = true
							messagebox("SYSTEM ERROR 1","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly, or dropped.")
						else
							//  Put data in the new row and update dw1
							wf_add_ctl_rec(dw1_proc_code,i,ll_rc)
						end if
					else
						//  Not at the end of the current search range.  Cut table in half and search again.
						lv_search_end_row = lv_target_row
					end if 
				else
//------------------------------------------------------------------
					//  dw1 proc code is greater than dw2 proc code
					//  Is the start of the current search range the same as the target row?
					if lv_search_start_row = lv_target_row then
						//  The dw2 row has already been checked. 
						//  this means we are done the search except for the last row of the current search range.
						dw2_proc_code = dw_2.GetItemString(lv_search_end_row,1) 
						if dw1_proc_code = dw2_proc_code then
							//  Found a hit on the last row or this segment of dw2.
							wf_update_ctl_rec(lv_search_end_row,i)
						else
							//  No hit, we need to add a new control record.
							if dw1_proc_code < dw2_proc_code then
								//  add rec before the last row of this segment of dw2.
								ll_rc   = dw_2.insertrow(lv_search_end_row)
								if ll_rc = -1 then
									//  failed insert row
									iv_process_done = true
									messagebox("SYSTEM ERROR 2","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly, or dropped.")
								else
									wf_add_ctl_rec(dw1_proc_code,i,ll_rc)
								end if
							else
								//  add rec after the last row of this segment of dw2.
								//  If end of dw2, use the 0 parm.
								if lv_search_end_row = iv_dw2_row_ct then
									ll_rc   = dw_2.insertrow(0)
								else
									ll_rc   = dw_2.insertrow(lv_search_end_row)
								end if
								if ll_rc = -1 then
									//  failed insert row
									iv_process_done = true
									messagebox("SYSTEM ERROR 3","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly, or dropped.")
								else
									wf_add_ctl_rec(dw1_proc_code,i,ll_rc)
								end if
							end if
						end if
					else
						//  Since the dw1 proc code is > dw2 proc code, change the start of the current search segment to the last target row.  This lets us work with the lower half of the current dw2 segment.
						lv_search_start_row = lv_target_row
					end if 
				end if
			end if
			LOOP
		else
			//  1st record processing, create the 1st control record in dw2
			ll_rc = dw_2.insertrow(1)
			if ll_rc = -1 then
				//  failed insertrow for dw2 - impossible occurrence.
				iv_process_done = true
				messagebox("SYSTEM ERROR 4","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly, or dropped.")
			else
				//  Once the new row is added, fill it with data and update dw1.
				wf_add_ctl_rec(dw1_proc_code,i,ll_rc)
			end if
		end if
	next
	setmicrohelp(w_main,'Now starting the sort.')

	//  Hide the work dw so that it will not print.
	dw_2.hide()

	//  Sort dw1 on group_ct, then item_ct columns
	setsort(dw_1,'14A,15A')
	sort(dw_1)
	wf_goto_row1()
	setmicrohelp(w_main,'Ready')
	return 1
else
	messagebox("NO MATCHING DATA","No data was found to match the selection criteria.")
	CB_CLOSE.TriggerEvent(Clicked!)
	return 1
end if

end function

public function integer wf_update_ctl_rec (long arg_target_row, long arg_dw1_row);//  wf_update_ctl_record    in w_norm_rpt      3-4-94   TPB
//  This module updates dw1 with a sort key (group/item), whenever
//  its proc code is found in dw2.  It also updates the item ct in dw2.

long ll_rc
long dw2_group_ct, dw2_item_ct


//  Hit causes updating of existing proc code control records in dw2.
//  Add 1 to the item ct for the new item.
dw2_group_ct = dw_2.GetItemNumber(arg_target_row,2) 
dw2_item_ct  = dw_2.GetItemNumber(arg_target_row,3) + 1
//  Test for errors in retrieving the data from dw2.
if (dw2_group_ct <= 0) or (dw2_item_ct <= 0) then
	iv_process_done = true
	messagebox("SYSTEM ERROR 6","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly.")
	return -1
else
	//  Update the item ct in dw2
	ll_rc = dw_2.SetItem(arg_target_row,3,dw2_item_ct)
	if ll_rc = 1 then
		//  Update the group ct in dw1
		ll_rc = dw_1.SetItem(arg_dw1_row,14,dw2_group_ct)
		if ll_rc = 1 then
			//  Update the item ct in dw1
			ll_rc = dw_1.SetItem(arg_dw1_row,15,dw2_item_ct)
			if ll_rc = 1 then
				//  Terminate the processing loop in the calling module.
				iv_process_done = true
				return 1
			end if
		end if
	end if
	iv_process_done = true
	messagebox("SYSTEM ERROR 7","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly.")
	return -1
end if
end function

public function int wf_add_ctl_rec (string arg_dw1_proc_code, long arg_i, long arg_new_row);//  wf_add_ctl_rec     in w_norm_rpt          3-4-94  TPB

//  Adds a new row to dw2 in sequential order based on proc code.
//  Also keeps a group and item count in dw2, and updates it for 
//  each row in dw1.  This becomes a sort key.

int rcsi, lc_first_item = 1


//  new control record creation processing.
//  Insert the proc code in col 1
rcsi = dw_2.SetItem(arg_new_row,1,arg_dw1_proc_code)
if rcsi = 1 then 
	//  Insert the group ct in col 2
	rcsi = dw_2.SetItem(arg_new_row,2,iv_next_group_ct)
	if rcsi = 1 then
		//  Insert the item ct in col 3
		rcsi = dw_2.SetItem(arg_new_row,3,lc_first_item)
		//  Keep track of the rows for the other modules.
		iv_dw2_row_ct = iv_dw2_row_ct + 1

		//  Update the report data row with the sort key (group/item)
		rcsi = dw_1.SetItem(arg_i,14,iv_next_group_ct)
		if rcsi = 1 then
			rcsi = dw_1.SetItem(arg_i,15,lc_first_item)
			if rcsi = 1 then
				iv_next_group_ct = iv_next_group_ct + 1
				//  Terminate the loop
				iv_process_done = true
				return 1
			end if
		end if
	end if
else
	//  Unsuccessful add to dw2 and update of dw1.  Still need to terminate the loop.
	iv_process_done = true
	messagebox("SYSTEM ERROR 5","While executing the special sort of Procedure Code and Savings, some form of unknown system error has occurred.  While it is not fatal, you are advised to closely check the results of the report sort.  At least one row of the report was not sorted correctly.")
	return rcsi      ;   //  Unsuccessful return code.
end if
end function

public function integer wf_goto_row1 ();//  wf_goto_row1     a function to highlight row 1 and set focus there

int li_rc
long row_nbr

row_nbr = 1
li_rc = SelectRow(dw_1,0,FALSE)
li_rc = SelectRow(dw_1,row_nbr,TRUE)
li_rc = dw_1.setrow(row_nbr)
//  RowFocusChanged must be forced to gets the current row information
//  under the followinging condition:  Cursor is on row 1;  a sort causes
//  row 1 information to be moved to another row; new information is in
//  row 1 but rowfocus has not changed.
dw_1.TriggerEvent(RowFocusChanged!)
return li_rc
end function

event open;//******************************************************************
//	Script:	open	-	Override the ancestor
//
//	Description:
//
//******************************************************************
//10-02-95 FNC Take rowcount out of loop
//
//07-17-97 FDG	1. Since this script overrides w_parent_rpt.open,
//					call w_master.open
//					2. Move getting of message.stringparm to ue_preopen
//
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
// 04/20/00 KTB	Starcare Track 2494. Disable graph functionality
//	03/18/01 FDG	Stars 4.7.  Store period key for future use.  
//	09/27/06	GaryR	Track 4285	Do not initially check the threshold checkbox
//	09/27/06	GaryR	Track 4282	Do not enable the graph button for some options
//******************************************************************
string  lv_sel, rs
string ls_desc
integer len_in_what, lv_position,lv_threshold, li_rc
long ll_x
double lv_carr_allow_chrg_per, lv_natl_allow_chrg_per
long lv_carr_allow_srvc
int lv_rowcount

Setpointer(hourglass!)

isx_norm_analysis_parms = Message.PowerObjectParm	// FNC 04/20/99
setnull(message.powerobjectparm)							// FNC 04/20/99


//	FDG 07/31/97 - Disable closequery processing
ib_disableclosequery	=	TRUE



Call w_master::Open				//	FDG	07/17/97

//fx_set_window_colors(w_norm_rpt)
setmicrohelp(w_main,'Ready')

//*******************//
// set report header //
//*******************//

//in_period = gv_period									// FNC 04/20/99

in_period = isx_norm_analysis_parms.l_period		// FNC 04/20/99

il_period_key	=	isx_norm_analysis_parms.l_period_key	// FDG 03/18/01

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
 WHERE period_key = :isx_norm_analysis_parms.l_period_key
 USING stars2ca;

if stars2ca.of_check_status() = -1 then
	Rollback using stars2ca;
	MessageBox('Error', 'Error selecting description from period_cntl')
	Return
else
	Commit using stars2ca;
end if

in_header = '~''+'Norm Report~n '+ls_desc+'~''

in_transaction_object = stars1ca
// FNC 04/20/99 Start
in_graph_choice = isx_norm_analysis_parms.s_sort
iv_invoice_type = isx_norm_analysis_parms.s_invoice_type
iv_rank_num = isx_norm_analysis_parms.l_rank_num
// FNC 04/20/99 END


//DKG 11/28/95
// Changed columns for new d_norm_analysis created 11/27/95.

in_columns_selected= 'Thrshld\5-30-3-4-26-27-25-5-6-15-16-11-12-21-22-9-28-29-group\4-item\3-'

//DKG END

in_create= FALSE
lv_sel = dw_1.GetSqlSelect()

in_what = fx_get_table('w_norm_rpt', 'open', iv_invoice_type)

//New threshold
select cntl_no into :lv_threshold from sys_cntl
  where cntl_id='NORM' using stars2ca;
if stars2ca.of_check_status()<>0 then lv_threshold=1

If stars2ca.of_commit() <> 0 Then
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
End if

lv_position = pos(lv_sel,' FROM ')
lv_sel = replace(lv_sel, lv_position, len(lv_sel), ' FROM ' + in_what)

If gc_debug_mode then
   messagebox('second lv_sel', lv_sel)
End If

in_sql = lv_sel + gv_analysis_1_sel
in_gr_where=gv_analysis_1_sel

//DKG 11/28/95
// Added SetTrans because w_parent_rpt blew up when referencing dw_1
// after the creation of new d_norm_analysis on 11/27/95.

li_rc = settransobject(dw_1,in_transaction_object)
    if li_rc= -1 then
       errorbox(in_transaction_object,'Error connecting to the data window')
	    gv_rc = li_rc
		 cb_close.Postevent(clicked!)
	    return
    end if

//DKG END

call w_parent_rpt::open 
if gv_rc <> -1 then
	//	w_norm_analysis.sle_count.text = string(in_row_count)
	//  Modify to shrink next 2 cols to 0 width in dw1 so they will not print
	// done here so that they will not be seen even if the sort is not executed.
	rs = dw_1.Modify("group_ct.width='0'")
	rs = dw_1.Modify("item_ct.width='0'")
end if

if	in_graph_choice= 'Procedure Code' OR 	in_graph_choice = 'Procedure Code/Savings' OR 	in_graph_choice = 'Specialty' Then
	cb_graph.enabled = False
	if	in_graph_choice= 'Procedure Code/Savings'  Then
		//  Perform special sort for procedure code/savings.
		wf_binary_sort()
	end if
else
	cb_graph.enabled = TRUE
end if

if lv_threshold=0 then
	cbx_threshold.show()
	cbx_threshold.triggerevent(clicked!)
	dw_1.setredraw(false)
   lv_rowcount = dw_1.rowcount() //10-02-95 FNC
	for ll_x=1 to lv_rowcount        //10-02-95 FNC
		dw_1.setitem(ll_x,'threshold','X')																						
	next
   //DKG 12/5/95 Added this update to reset the modifed count in the 
   // DW so changes can be monitored. This update does nothing
   // except reset the flag.
	dw_1.Update()
	// Initially diplay all rows
	cbx_threshold.checked = FALSE
	cbx_threshold.triggerevent(clicked!)
	dw_1.setredraw( TRUE )
	//DKG END
end if

//DKG 11/30/95
cb_update.Enabled = FALSE
//DKG END

// KTB 04-20-00 - Starcare Track 2494
m_stars_30.m_reporting.m_graph.Enabled = FALSE
// End KTB

end event

event closequery;//********************************************************************
// 11/29/95 DKG 	Override the ancestor.
//						This code checks to see if the DW has been modified and prompts the
// 					user to save the data before exiting.
//********************************************************************

//DKG 11/29/95
//	Override the ancestor
// This code checks to see if the DW has been modified and prompts the
// user to save the data before exiting.

Int	li_rc

IF dw_1.AcceptText() = -1 OR dw_1.ModifiedCount() > 0 THEN
	Choose Case MessageBox("Close", "Save Changes Before Exiting?", &
                          Question!, YesNoCancel!, 1)
	Case 1
		IF dw_1.AcceptText() = -1 THEN
			SetFocus(dw_1)
			Message.ReturnValue = 1
		ELSE
			li_rc = dw_1.Update()
			IF li_rc= -1 THEN
   			errorbox(STARS2CA,'Error Updating Table')
				gv_rc = li_rc
				cb_close.Postevent(clicked!)
				return
			END IF   
			COMMIT USING STARS2CA;
      END IF
   Case 2
      Message.ReturnValue = 0
   Case 3
      Message.ReturnValue = 1
	End Choose
END IF
end event

on w_norm_rpt.create
int iCurrent
call super::create
this.cb_graph=create cb_graph
this.dw_2=create dw_2
this.cbx_threshold=create cbx_threshold
this.st_dw_ops=create st_dw_ops
this.cb_update=create cb_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_graph
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cbx_threshold
this.Control[iCurrent+4]=this.st_dw_ops
this.Control[iCurrent+5]=this.cb_update
end on

on w_norm_rpt.destroy
call super::destroy
destroy(this.cb_graph)
destroy(this.dw_2)
destroy(this.cbx_threshold)
destroy(this.st_dw_ops)
destroy(this.cb_update)
end on

event ue_preopen;//********************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure. Move
//						script to open to avoid setting the structure to nulls
//********************************************************************

// FNC 04/20/99 Start
//parm = message.stringparm
////KMM Clear out message parm (PB Bug)
//SetNull(message.stringparm)

// FNC 04/20/99 End


end event

event close;call super::close;// KTB - Starcare Track 2494 - Enable graph functionality
m_stars_30.m_reporting.m_graph.Enabled = TRUE
// End KTB
end event

type ddlb_dw_ops from w_parent_rpt`ddlb_dw_ops within w_norm_rpt
integer y = 1364
integer taborder = 20
end type

event ddlb_dw_ops::selectionchanged;//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//	04/10/09	Katie	GNL.600.5633	Added decode structure call to fx_uo_control.
//	08/06/09	GaryR	WIN.650.5721.006	Reuse the initialized instance decode structure

string lv_control_text

SetPointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
if (lv_control_text='Display Filter' or lv_control_text='Sort/Rank') and cbx_threshold.checked then
	if messagebox('Window Operations','The chosen window operation will override the threshold option. Continue anyway?',question!,yesno!,2)=1 then
		cbx_threshold.checked=false
		cbx_threshold.triggerevent(clicked!)
	else
		return
	end if
end if
in_selected = '1'
in_dw_control = fx_uo_control(iv_uo_win,dw_1,lv_control_text,in_dw_control,sle_count, in_decode_struct)
iv_uo_win.uo_decode.of_set_invoice_type(iv_invoice_type)
end event

type cb_clear from w_parent_rpt`cb_clear within w_norm_rpt
boolean visible = false
boolean enabled = false
end type

type st_1 from w_parent_rpt`st_1 within w_norm_rpt
end type

type cb_save_report from w_parent_rpt`cb_save_report within w_norm_rpt
integer x = 1637
integer y = 1400
end type

on cb_save_report::clicked;in_save_name = 'Norm rpt dw'
call w_parent_rpt`cb_save_report::clicked

end on

type sle_count from w_parent_rpt`sle_count within w_norm_rpt
integer x = 64
integer taborder = 0
end type

type cb_stop from w_parent_rpt`cb_stop within w_norm_rpt
integer x = 2098
integer y = 1408
integer taborder = 110
end type

type mle_crit from w_parent_rpt`mle_crit within w_norm_rpt
end type

type cb_query from w_parent_rpt`cb_query within w_norm_rpt
integer x = 901
integer taborder = 50
boolean default = true
end type

event cb_query::clicked;//******************************************************************************
// 03/29/99 FNC	Track 2044d FS/TS2044D Change column name spec to prov spec to
//						match table.
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//******************************************************************************


setpointer(hourglass!)

//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
// put in buttons and not rowfocuschanged event because causing weird things to happen
n_cst_decode	lnv_decode

in_proc_code = trim(getitemstring(dw_1,in_row_nbr,'proc_code'))
in_spec = trim(getitemstring(dw_1,in_row_nbr,'prov_spec'))			// FNC 03/29/99 

//	Remove decoded values
IF lnv_decode.of_is_decoded( dw_1, "proc_code" ) THEN
	lnv_decode.of_remove_desc( in_proc_code )
END IF

IF lnv_decode.of_is_decoded( dw_1, "proc_spec" ) THEN
	lnv_decode.of_remove_desc( in_spec )
END IF

in_crit = ' WHERE PROC_CODE='+'~''+Upper( in_proc_code)+'~''+' AND PROV_SPEC='+'~''+Upper( in_spec )+'~''+' AND PERIOD ='+string(in_period)
gv_active_invoice = iv_invoice_type

in_what = fx_get_table('w_norm_rpt', 'query', iv_invoice_type)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

in_what = replace(in_what, 1, 2, 'M ')
in_what = ' FRO' + in_what + ' '

If gc_debug_mode then
   messagebox('in_what',in_what)
End If

in_going_to_claim = FALSE
call w_parent_rpt`cb_query::clicked
end event

type cb_view_detail from w_parent_rpt`cb_view_detail within w_norm_rpt
integer x = 1344
integer width = 439
string text = "&View Data..."
end type

event cb_view_detail::clicked;call super::clicked;////////////////////////////////////////////////////////////////
//	History
//
//	FDG	02/09/98	Do not hard code tbl_type (CF).  Get it from the
//						invoice type instead.
//	FDG	01/18/99	Track 2055c.  Convert dates to 'mm/dd/yyyy' format.
// FNC	03/29/99 Track 2044d FS/TS2044D Change column name spec to prov spec to
//						match table.
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
////////////////////////////////////////////////////////////////


string sort,lv_selection,lv_order//,parm
string lv_tbl_type,lv_mod,lv_send

gv_active_invoice = iv_invoice_type

Setpointer(hourglass!)

clear_crit_globals()

//HRB - 7/24/95 - prob#722 - if field is decoded, strip off description
// put in buttons and not rowfocuschanged event because causing weird things to happen
n_cst_decode	lnv_decode

in_proc_code = trim(getitemstring(dw_1,in_row_nbr,'proc_code'))
in_spec = trim(getitemstring(dw_1,in_row_nbr,'prov_spec'))			// FNC 03/29/99

// Remove description
IF lnv_decode.of_is_decoded( dw_1, "proc_code" ) THEN
	lnv_decode.of_remove_desc( in_proc_code )
END IF

IF lnv_decode.of_is_decoded( dw_1, "proc_spec" ) THEN
	lnv_decode.of_remove_desc( in_spec )
END IF

in_crit = ' WHERE PROC_CODE='+'~''+Upper( in_proc_code )+'~''+' AND PROV_SPEC='+'~''+Upper( in_spec )+'~''+' AND PERIOD ='+string(in_period)

gv_selection1 = in_selection

sort = ''
gv_stack1 = in_crit+sort
gv_stack1 = upper(gv_stack1)
if gc_debug_mode = TRUE THEN
	messagebox('Execute SQL',gv_stack1)
end if

lv_tbl_type	=	iv_invoice_type			// FDG 02/09/98
gv_left_paren[1] = ''
gv_exp1[1] = lv_tbl_type+'.PROC_CODE'
gv_op[1] = '='
gv_exp2[1] = in_proc_code
gv_right_paren[1] = ''
gv_logic[1] = 'AND'
gv_left_paren[2] = ''
gv_exp1[2] = lv_tbl_type+'.PROV_SPEC'
gv_op[2] = '='
gv_exp2[2] = in_spec
gv_right_paren[2] = ''
gv_logic[2] = 'AND'
gv_left_paren[3] = ''
gv_exp1[3] =lv_tbl_type+'.FROM_DATE'
gv_op[3] = 'BETWEEN'
//gv_exp2[3] = string(date(id_from)) +','+string(date(id_thru))		// FDG 01/18/99
gv_exp2[3] = string(date(id_from), 'mm/dd/yyyy') +','+string(date(id_thru), 'mm/dd/yyyy')		// FDG 01/18/99
gv_right_paren[3] = ''
gv_logic[3] = 'AND'
gv_left_paren[4] = ''
gv_exp1[4] = lv_tbl_type+'.PAYMENT_DATE'
gv_op[4] = 'BETWEEN'
//gv_exp2[4] = string(date(id_payment_from)) +','+string(date(id_payment_thru))		// FDG 01/18/99
gv_exp2[4] = string(date(id_payment_from), 'mm/dd/yyyy') +','+string(date(id_payment_thru), 'mm/dd/yyyy')	// FDG 01/18/99
gv_right_paren[4] = ''
gv_logic[4] = ''
	
if isvalid(w_norm_provider_list) Then
	close(w_norm_provider_list)
end if

//New norms with mod
lv_mod=dw_1.getitemstring(dw_1.getrow(),'proc_mod')

// FNC 04/20/99 Start
//lv_send=iv_invoice_type
//if trim(lv_mod)<>'' then lv_send=lv_send+'~t'+lv_mod

isx_norm_rpt_parms.s_invoice_type = iv_invoice_type
isx_norm_rpt_parms.s_proc_mod = lv_mod
isx_norm_rpt_parms.l_period = isx_norm_analysis_parms.l_period
isx_norm_rpt_parms.l_period_key = isx_norm_analysis_parms.l_period_key

//opensheetwithparm(w_norm_provider_list,lv_send,MDI_Main_Frame,Help_menu_position,Layered!)
opensheetwithparm(w_norm_provider_list,isx_norm_rpt_parms,MDI_Main_Frame,Help_menu_position,Layered!)

// FNC 04/20/99 End
end event

type cb_close from w_parent_rpt`cb_close within w_norm_rpt
integer x = 2254
integer taborder = 100
end type

event cb_close::clicked;call super::clicked;close(w_norm_provider_list)

end event

type dw_1 from w_parent_rpt`dw_1 within w_norm_rpt
string tag = "CRYSTAL, title = Norm Report"
integer x = 73
integer y = 504
integer width = 2578
integer height = 780
string dataobject = "d_norm_analysis"
end type

event dw_1::clicked;call super::clicked;/////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	09/02/98	Track 1641.  Clicking the column header hilites
//						all rows.
//
/////////////////////////////////////////////////////////////////////


//DKG 11/5/95 Added this to select row after DW was made updateable.
IF	row	>	0		THEN
	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)
	This.SetRow(row)
END IF
//DKG END
end event

on dw_1::itemchanged;call w_parent_rpt`dw_1::itemchanged;//DKG 11/29/95
cb_update.Enabled = TRUE


end on

event dw_1::rowfocuschanged;call super::rowfocuschanged;//******************************************************************************
// 03/29/99 FNC	Track 2044d FS/TS2044D Change column name spec to prov spec to
//						match table.
//******************************************************************************

if gv_cancel_but_clicked = TRUE and in_row_nbr <> 0 then
	in_proc_code = getitemstring(dw_1,in_row_nbr,'proc_code')
	in_spec = getitemstring(dw_1,in_row_nbr,'prov_spec')
	in_crit = ' WHERE PROC_CODE='+'~''+Upper( in_proc_code)+'~''+' AND SPEC='+'~''+Upper( in_spec)+'~''+' AND PERIOD ='+string(in_period)
end if


end event

on dw_1::retrieverow;call w_parent_rpt`dw_1::retrieverow;cnt ++
if cnt = iv_rank_num Then 
	dw_1.dbcancel()
end if

end on

on dw_1::doubleclicked;call w_parent_rpt`dw_1::doubleclicked;//if  trim(upper(ddlb_dw_ops.text)) = 'SORT/RANK' then
//	cbx_threshold.checked = false
//end if


end on

on dw_1::retrieveend;call w_parent_rpt`dw_1::retrieveend;cb_graph.enabled = TRUE
end on

type cb_graph from u_cb within w_norm_rpt
string accessiblename = "Graph "
string accessibledescription = "Graph "
integer x = 1829
integer y = 1452
integer width = 379
integer height = 108
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string text = "&Graph..."
end type

event clicked;//*****************************************************************
// 08-20-96 FNC	Prob #927 STARCARE
//						Add proc_mod to x-axis of graph.
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//	05/17/07	GaryR	Track 5026	Prevent divide-by-zero
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//*****************************************************************

string what,lv_graph,lv_sort,lv_type
int li_rc,num_of_values

setpointer(hourglass!)
gv_active_invoice = iv_invoice_type

if	in_graph_choice = 'Savings' Then
	num_of_values = 1
	lv_graph = 'Savings '
	lv_type = 'dec'
elseif in_graph_choice = 'Rank' Then
	num_of_values = 2
	lv_graph = 'Carr_Rank,NATL_RANK '
	lv_type = 'int'
elseif in_graph_choice = 'CARR Allow Srvc/1000' Then
	num_of_values = 2
	lv_graph = 'Carr_allow_srvc_per,NATL_ALLOW_SRVC_PER '
	lv_type = 'dec'
elseif in_graph_choice = 'CARR Allow Chrg/1000' Then
	num_of_values = 2
	lv_graph = 'Carr_Allow_chrg_per,NATL_ALLOW_CHRG_PER '
	lv_type = 'dec'
elseif in_graph_choice = 'Percent Changed' Then
	num_of_values = 1
	lv_graph = gnv_sql.of_get_norm_case() + ' '
	lv_type = 'dec'
end if

what = lv_graph+',proc_code' + gnv_sql.is_concat + '~'~n~'' + &
			gnv_sql.is_concat + 'prov_spec' + gnv_sql.is_concat + &
			'~'~n~'' + gnv_sql.is_concat + 'proc_mod  '

isx_norm_analysis_parms.s_invoice_type = iv_invoice_type
isx_norm_analysis_parms.l_rank_num = 0
isx_norm_analysis_parms.i_num_of_values = num_of_values
isx_norm_analysis_parms.s_type = lv_type

// FNC 04/20/99 END

gv_graph_sel = 'Select '+what+' From Bess_National '+in_gr_where

if gc_debug_mode = TRUE THEN
	messagebox('Execute SQL',gv_graph_sel)
end if
// FNC 04/20/99 Start

if isvalid(w_norm_analysis) Then
  isx_norm_analysis_parms.s_sort = w_norm_analysis.ddlb_sort.text
else
  isx_norm_analysis_parms.s_sort = in_graph_choice
end if 

// FNC 04/20/99 End

if isvalid(w_norm_graph) Then
	close(w_norm_graph)
end if

// FNC 04/20/99 Start
opensheetwithparm(w_norm_graph,isx_norm_analysis_parms,MDI_Main_Frame,Help_menu_position,Layered!)
// FNC 04/20/99 End
end event

type dw_2 from u_dw within w_norm_rpt
boolean visible = false
string accessiblename = "Not a visible control"
string accessibledescription = "Not a visible control"
integer x = 2057
integer y = 692
integer width = 174
integer height = 176
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_norm_rpt_work"
end type

type cbx_threshold from checkbox within w_norm_rpt
boolean visible = false
string accessiblename = "Lines Greater Than Threshold"
string accessibledescription = "Lines Greater Than Threshold "
accessiblerole accessiblerole = checkbuttonrole!
integer x = 818
integer y = 1360
integer width = 658
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Lines > Threshold"
boolean checked = true
end type

event clicked;//******************************************************************************
//7/16/98 Archana Disabling cb_view_detail when num of rows above threshold = 0.
//1/04/00 KTB 		Starcare track 2315 Stars 4.5. Disable query button when num or
//						rows above threshold is = 0.
//******************************************************************************

string	lv_allw_srv
string	lv_allw_chrg_per

//DKG 11/28/95
// Validate Reviewed field.
IF dw_1.AcceptText() = -1 THEN
	If This.Checked = TRUE THEN
      This.Checked = FALSE
	ELSE
      This.Checked = TRUE
	END IF
   SetFocus(dw_1)
	RETURN
END IF
//DKG END

//DKG 11/29/95
// Read SYS-CNTL to get threshold parameters.

SELECT cntl_case,
       cntl_text
  INTO :lv_allw_srv,
  	    :lv_allw_chrg_per
  FROM sys_cntl
 WHERE cntl_id = 'NORM'
 USING STARS2CA;

IF STARS2CA.of_check_status() = -1 THEN
 	errorbox(STARS2CA,'Error Selecting Threshold Parameters')
	cb_close.Postevent(clicked!)
	return
END IF

IF STARS2CA.SQLCODE = 100 THEN
	MessageBox('Norm Analysis', 'Parameters Not Found. Threshold Will Not Be Applied.')
	lv_allw_srv = '0'
	lv_allw_chrg_per = '0'
END IF    

//DKG END 

//DJP 9/14/95 prob#97(AK) - cleaned threshold up a bit
dw_1.setredraw(false)
if this.checked then
	//DKG 11/29/95
   //Changed number to the ones just read in from sys_cntl.
   dw_1.setfilter('carr_allow_srvc>' + lv_allw_srv + &
                  ' and carr_allow_chrg_per>(' + &
                  lv_allw_chrg_per + '*natl_allow_chrg_per)')
	//DKG END
//	dw_1.Modify("threshold.width='0'")
	dw_1.Modify("threshold.visible='0'")
else
	dw_1.setfilter('')
//	dw_1.Modify("threshold.width='50'")
	dw_1.Modify("threshold.visible='1'")
	dw_1.Modify("threshold.x='1'")
end if
dw_1.filter()
sle_count.text=string(dw_1.rowcount())

//7/16/98 Archana Begin
// KTB 1-4-00 Pushing the Query button if row count was 0 was causing a crash,
//            so only enable it if the row count is greater than 0
If dw_1.rowcount() = 0 then
	parent.cb_view_detail.enabled = false
	parent.cb_query.enabled = false  // KTB 1-4-00
else
	parent.cb_view_detail.enabled = true
	parent.cb_query.enabled = true // KTB 1-4-00
end if
//7/16/98 Archana End

dw_1.setredraw(true)

dw_1.SetSort("threshold D, savings D")  // ABO 10/14/96 
dw_1.Sort()


end event

type st_dw_ops from statictext within w_norm_rpt
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 64
integer y = 1288
integer width = 649
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

type cb_update from u_cb within w_norm_rpt
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 457
integer y = 1452
integer width = 398
integer height = 108
integer taborder = 90
boolean bringtotop = true
boolean enabled = false
string text = "&Update"
end type

on clicked;//DKG 11/29/95

Int		li_rc

SetPointer(HourGlass!)

IF dw_1.AcceptText() = -1 THEN
	SetFocus(dw_1)
	RETURN
ELSE
	li_rc = dw_1.Update()
   IF li_rc= -1 THEN
   	errorbox(STARS2CA,'Error Updating Table')
		gv_rc = li_rc
		cb_close.Postevent(clicked!)
		return
	END IF   
   COMMIT USING STARS2CA;
   This.Enabled = FALSE
END IF

//DKG END
end on

