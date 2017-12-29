$PBExportHeader$w_case_referral.srw
$PBExportComments$Inherited from w_master
forward
global type w_case_referral from w_master
end type
type st_8 from statictext within w_case_referral
end type
type st_default_id from statictext within w_case_referral
end type
type dw_user from u_display_user_id within w_case_referral
end type
type st_6 from statictext within w_case_referral
end type
type cb_close from u_cb within w_case_referral
end type
type cb_refer from u_cb within w_case_referral
end type
type st_newcaseno from statictext within w_case_referral
end type
type st_referdate from statictext within w_case_referral
end type
type ddlb_referto from dropdownlistbox within w_case_referral
end type
type st_referby from statictext within w_case_referral
end type
type st_referfrom from statictext within w_case_referral
end type
type st_5 from statictext within w_case_referral
end type
type st_4 from statictext within w_case_referral
end type
type st_3 from statictext within w_case_referral
end type
type st_2 from statictext within w_case_referral
end type
type st_1 from statictext within w_case_referral
end type
end forward

global type w_case_referral from w_master
string accessiblename = "Case Referral Details"
string accessibledescription = "Case Referral Details"
accessiblerole accessiblerole = windowrole!
integer x = 315
integer y = 604
integer width = 3168
integer height = 760
string title = "Case Referral Details"
windowtype windowtype = response!
long backcolor = 67108864
st_8 st_8
st_default_id st_default_id
dw_user dw_user
st_6 st_6
cb_close cb_close
cb_refer cb_refer
st_newcaseno st_newcaseno
st_referdate st_referdate
ddlb_referto ddlb_referto
st_referby st_referby
st_referfrom st_referfrom
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_case_referral w_case_referral

type variables
string in_from
string in_case_status,in_case_disposition
string in_case_status_desc
Date in_case_status_date,in_refer_date
Time in_case_status_time,in_refer_time
string in_case_status_user
string in_case_refer_to
string in_case_spl,in_case_ver
string in_case_id
Boolean in_track_exists
String in_case_cat
Boolean in_bad_retrieve
String in_case_refer_from_dept, in_case_refer_by_rep
Datetime in_case_refer_date
String is_parm

// FDG 09/11/01 Stars 4.8 - Return Structure
sx_case_refer	istr_case_refer

end variables

event open;call super::open;//**************************************************************
//Script for w_case_referral - open
//**************************************************************
// 09/01/98 AJS   FS362 convert case to case_cntl
//	09/03/99	NLG	ts2363c. Don't reference w_case_maint.sle_case_id
//	09/12/01	FDG	Stars 4.8.1  Initialize the DDDW for dw_user.
// 02/11/02 SAH   Stars 4.8.1 Remove blank line in ddlb_referto
// 03/28/02	GaryR	Track 2958d	GPF on close
//**************************************************************
string lv_case_id, lv_case_id_spl, lv_case_id_ver, ls_from_dept, ls_refer_id
integer lv_count, lv_idx
string lv_cat_code, lv_refer_ver,lv_code_and_description, lv_code_desc


//fx_set_window_colors(w_case_referral)
setmicrohelp(w_main,'Retrieving Referral Data')
lv_case_id = left(gv_active_case,10)//left(w_case_maint.sle_case_id.text,10)
lv_case_id_spl = mid(gv_active_case,11,2)//mid(w_case_maint.sle_case_id.text,11,2)
lv_case_id_ver = mid(gv_active_case,13,2)//mid(w_case_maint.sle_case_id.text,13,2)

ls_from_dept = gc_user_dept
ls_refer_id = gc_user_id

// SAH 01/25/02 -Begin
// Load the Refer to Departments in the drop down list box
lv_idx = 0
Declare dept_c cursor for
	Select code_code, code_desc
	  from code
	 where code_type = 'DE'
	 using stars2ca;
Open dept_c;
If stars2ca.of_check_status() <> 0 then
//	Close(this)
	Errorbox(stars2ca,'Unable to Open Cursor for Department Names')
	cb_close.Postevent(clicked!)
	RETURN
End If

Do while stars2ca.sqlcode = 0 
	Fetch dept_c 
		into :lv_cat_code, :lv_code_desc;
	If stars2ca.of_check_status() = 100 then
		//ddlb_referto.Insertitem('NONE',1)
		//ddlb_referto.InsertItem(" ", 1)	// SAH 02/11/02
		Exit
	Elseif stars2ca.sqlcode <> 0  then
//			Close(this)
			close dept_c;
			Errorbox(stars2ca,'Unable to Fetch Cursor for Department Names')
			cb_close.Postevent(clicked!)
			RETURN
	End If	
	
	lv_code_and_description = lv_cat_code + " " + " " + lv_code_desc
	
	lv_idx = lv_idx + 1
	//ddlb_referto.Insertitem(lv_cat_code, lv_idx)
	ddlb_referto.Insertitem(lv_code_and_description, lv_idx)
Loop
close dept_c;
If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca,'ERROR Closing Department Name Cursor')
End If
COMMIT USING STARS2CA;
//sqlcmd('COMMIT',stars2ca,'Commit to Release Department Names',1)

// SAH 01/25/02 -End

// 09/01/98 AJS   FS362 convert case to case_cntl
Select 	 refer_to_dept,
			 case_cat,
			 case_status,case_disp,
			 case_updt_user,
			 case_status_desc,
			 refer_from_dept,
			 refer_by_rep,
			 refer_date
	into	 
			 :in_case_refer_to,
			 :in_case_cat,
			 :in_case_status,:in_case_disposition,
			 :in_case_status_user,
			 :in_case_status_desc,
			 :in_case_refer_from_dept, :in_case_refer_by_rep, :in_case_refer_date
	 from  case_cntl 
	where  case_id  = Upper( :lv_case_id ) and 
			 case_spl = Upper( :lv_case_id_spl ) and
			 case_ver = Upper( :lv_case_id_ver )
Using  stars2ca;


If stars2ca.of_check_status() <> 0 then
	Errorbox(stars2ca, 'ERROR reading Case Table')
	return
End If

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	errorbox(stars2ca,'Error Commiting to Stars2')
	Return
End If	

// set the values for from and by
st_referfrom.text = in_case_refer_from_dept
st_referby.text = in_case_refer_by_rep
ddlb_referto.text = in_case_refer_to

If year(date(in_case_refer_date)) <= 1900 then
	st_referdate.text = ''
Else
	st_referdate.text = string(date(in_case_refer_date))
End If
// if there's a refer date, there should be a refer case ID (our case + 1)
if len(st_referdate.text) > 0 then
	lv_refer_ver             = string(integer(lv_case_id_ver) + 1)
	If len(lv_refer_ver) = 1 then
		lv_refer_ver = '0' + lv_refer_ver
	End If
	st_newcaseno.text = lv_case_id + lv_case_id_spl + lv_refer_ver
end if

in_case_id = lv_case_id
in_case_spl = lv_case_id_spl
in_case_ver = lv_case_id_ver

istr_case_refer.b_case_referred	=	FALSE					// FDG 09/12/01
istr_case_refer.s_case_id			=	lv_case_id			// FDG 09/12/01
istr_case_refer.s_case_spl			=	lv_case_id_spl		// FDG 09/12/01
istr_case_refer.s_case_ver			=	lv_case_id_ver		// FDG 09/12/01
// Set Message.PowerObjectParm in case user clicks x instead of cancel
// 03/28/02	GaryR	Track 2958d
//Message.PowerObjectParm				=	istr_case_refer	// FDG 09/12/01 


// SAH 03/11/02 Static text objects weren't populating
st_referfrom.Text = " " + ls_from_dept
st_referby.Text = " " + ls_refer_id
st_referdate.Text = " " + String(Date(gnv_app.of_get_server_date_time()))

lv_refer_ver = string(integer(lv_case_id_ver) + 1)
IF len(lv_refer_ver) = 1 THEN
	lv_refer_ver = '0' + lv_refer_ver
END IF

st_newcaseno.Text = " " + lv_case_id + lv_case_id_spl + lv_refer_ver

// parse out the message.StringParm

If is_parm = 'Enable' Then
	cb_refer.Enabled = True
   ddlb_referto.enabled = true
	dw_user.enabled	=	True				// FDG 09/12/01
	dw_user.uf_filter_dept('999999')		// FDG 09/12/01
Else
	cb_refer.Enabled = False
	ddlb_referto.enabled = false
	dw_user.enabled	=	False				// FDG 09/12/01
End If

//KMM Clear out message parm (PB Bug)
//SetNull(message.stringparm)				// FDG 09/12/01
setmicrohelp(w_main,'Ready')

end event

on w_case_referral.create
int iCurrent
call super::create
this.st_8=create st_8
this.st_default_id=create st_default_id
this.dw_user=create dw_user
this.st_6=create st_6
this.cb_close=create cb_close
this.cb_refer=create cb_refer
this.st_newcaseno=create st_newcaseno
this.st_referdate=create st_referdate
this.ddlb_referto=create ddlb_referto
this.st_referby=create st_referby
this.st_referfrom=create st_referfrom
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_8
this.Control[iCurrent+2]=this.st_default_id
this.Control[iCurrent+3]=this.dw_user
this.Control[iCurrent+4]=this.st_6
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_refer
this.Control[iCurrent+7]=this.st_newcaseno
this.Control[iCurrent+8]=this.st_referdate
this.Control[iCurrent+9]=this.ddlb_referto
this.Control[iCurrent+10]=this.st_referby
this.Control[iCurrent+11]=this.st_referfrom
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_1
end on

on w_case_referral.destroy
call super::destroy
destroy(this.st_8)
destroy(this.st_default_id)
destroy(this.dw_user)
destroy(this.st_6)
destroy(this.cb_close)
destroy(this.cb_refer)
destroy(this.st_newcaseno)
destroy(this.st_referdate)
destroy(this.ddlb_referto)
destroy(this.st_referby)
destroy(this.st_referfrom)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event ue_preopen;call super::ue_preopen;is_parm	=	Message.Stringparm

end event

event close;call super::close;// 03/28/02	GaryR	Track 2958d	GPF on close
Message.PowerObjectParm				=	istr_case_refer
end event

type st_8 from statictext within w_case_referral
string accessiblename = "Dept Default User"
string accessibledescription = "Dept Default User"
accessiblerole accessiblerole = statictextrole!
integer y = 332
integer width = 562
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Dept Default User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_default_id from statictext within w_case_referral
string accessiblename = "Department Default User"
string accessibledescription = "Department Default User"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 576
integer y = 328
integer width = 1111
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_user from u_display_user_id within w_case_referral
string accessiblename = "Refer to User Drop Down List"
string accessibledescription = "Refer to User Drop Down List"
accessiblerole accessiblerole = clientrole!
integer x = 2245
integer y = 180
integer width = 859
integer height = 92
integer taborder = 20
boolean border = false
end type

type st_6 from statictext within w_case_referral
string accessiblename = "Refer To User"
string accessibledescription = "Refer To User"
accessiblerole accessiblerole = statictextrole!
integer x = 1765
integer y = 192
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Refer To User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_case_referral
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2638
integer y = 484
integer width = 434
integer height = 108
integer taborder = 30
string text = "&Cancel"
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
//
// 09/12/01	FDG	Stars 4.8.1  Return istr_case_defer
// 03/28/02	GaryR	Track 2958d	GPF on close
//
/////////////////////////////////////////////////////////////////////////////

//if cb_refer.enabled then
//	closewithreturn(parent, 'Enable')
//else
//	closewithreturn(parent, 'Disable')
//end if

istr_case_refer.b_case_referred	=	FALSE		// FDG 09/12/01

// 03/28/02	GaryR	Track 2958d
//CloseWithReturn (parent, istr_case_refer)		// FDG 09/12/01
Close( PARENT )


end event

type cb_refer from u_cb within w_case_referral
string accessiblename = "Refer Case"
string accessibledescription = "Refer Case"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2144
integer y = 484
integer width = 434
integer height = 108
integer taborder = 20
string text = "&Refer Case"
end type

event clicked;//
//Script for w_case_referral - Refer
//
//**************************************************************************************
//	Modifications:
// 03/20/98 JGG	STARS 4.0 TS145 Executable changes - remove reference
//						to subc_sys in string variable sub_cntl_fields
//
//	1-13-98	NLG	4.0 Subset Redesign.  Update new columns in case_link
//						Use datawindow retrieve instead of cursor
//
// 4/23/96  FDG   If a case is referred, get the create date from
//						1st case in dw_case_id_hidden  (Prob 128)
// 09/01/98 AJS   FS362 convert case to case_cntl
// 09/03/99	NLG	ts2363c. 1) Remove references to w_case_maint.sle_'s
//						2) period from & to are now smalldatetime, not integers
//	11/1/99	NLG	New case money columns must be copied also,
//						but any money rolled up from track becomes $0.00
// 11/3/99 FNC		Stars 4.5 Case Money Changes. Set assigned id of the new 
//						referred case to NONE instead of ''. This necessary for the
//						inventory summary reports by user id.
//	12/05/00	FDG	Stars 4.7.  Make error checking DBMS-independent
//	01/09/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	02/09/01	JFS	Stars 4.6 - PIMR - Add PIMR data.
//	03/21/01	FDG	Stars 4.6.  Initialize PIMR status data for the new case
//	04/16/01	FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	09/12/01	FDG	Stars 4.8.	After edits are performed, return istr_case_refer.
//						User ID is required and no pending jobs can exist for
//						this case.
//	01/17/02	FDG	Track 2696d.  Remove edit for in_case_refer_to because it's
//						unnecessary.
// 03/11/02 SAH   Track 2862.  User ID is required again, remove 'NONE'
// 03/28/02	GaryR	Track 2958d	GPF on close
// 06/18/02 JasonS Track 3063d change case status on referral
//****************************************************************************************
Int      lv_return
String   lv_link_type,lv_link_id
//String   lv_case_active,lv_case_id,lv_case_spl
string   lv_case_ver,lv_cat_dept,lv_active_case
Date     lv_init_date
Time     lv_init_time
string   lv_status,lv_disposition,lv_status_desc
string   Lv_dept,lv_user 
string   lv_assigned,lv_assigned_priority
datetime lv_assigned_date,lv_refer_date,lv_created_datetime
DATETIME lv_current_datetime,LV_RECEIPT_DATE,lv_today_datetime
DATETIME	ldt_receipt_date							// FDG 05/15/96
datetime ldt_period_to, ldt_period_from
Datetime lv_system_datetime
DateTime ldt_create_date							// FDG 04/23/96
Long		ll_rowcount									// FDG 04/23/96
String	ls_user										// FDG 04/23/96
string   lv_refer_from,lv_refer_By
string   lv_case_type,lv_case_cat
string   lv_line_of_bus
string   lv_plan,lv_track_type
string   lv_edit,lv_disp_hold
//double	lv_savings
long		lv_period_from,lv_period_to
string   lv_case_desc	
string   lv_case_status_desc     //alabama2 pat-d
string   lv_case_business
//string   lv_case_id_ver
string 	ls_case_id,ls_case_spl,ls_case_ver
sTRING   LV_SQL_INSERT
Boolean  lv_link_exists 
Int		lv_count
integer	li_rc																					//1-12-98 NLG 4.0 Subset Redesign
long 		ll_row, ll_row_num, ll_new_row												//1-12-98 NLG 4.0 Subset Redesign
string	ls_link_type, ls_link_key, ls_link_name, ls_link_desc, ls_user_id	//1-12-98 NLG 4.0 Subset Redesign
string	ls_link_status																		//1-12-98 NLG 4.0 Subset Redesign
datetime	ldt_link_date																		//1-12-98 NLG 4.0 Subset Redesign
long 		ll_dw_row
string 	ls_refer_disp
double	ld_identified_amt,	&
			ld_op_amt,				&
			ld_amt_recv,			&
			ld_recovered_addtl_amt,	&
			ld_future_savings_amt,	&
			ld_referred_amt,			&
			ld_amt_writeoff,			&
			ld_balance_remaining_amt,&
			ld_case_custom1_amt,		&
			ld_case_custom2_amt,		&
			ld_case_custom3_amt,		&
			ld_custom1_amt,			&
			ld_custom2_amt,			&
			ld_custom3_amt,			&
			ld_custom4_amt,			&
			ld_custom5_amt,			&
			ld_custom6_amt
// Start JFS 02/09/01
string 	ls_cont_id, ls_ready_cd, ls_created_cd, ls_prov_type, ls_custom1_cd, ls_custom1_char, &
			ls_custom2_cd, ls_custom3_cd, ls_frd_rfrl_cd, ls_acpt_cd, ls_ready_user, &
			ls_created_user, ls_case_prov_spec, ls_custom2_char, ls_custom4_cd, ls_custom5_cd,&
			ls_subject_id
String	ls_empty						// FDG 04/16/01
datetime ldt_ready_date, ldt_created_date, ldt_custom1_date, ldt_custom2_date, ldt_custom3_date,	&
			ldt_default
long		ll_custom1_cnt, ll_custom2_cnt, ll_custom3_cnt, ll_custom4_cnt, ll_custom5_cnt, &
			ll_custom6_cnt, ll_custom7_cnt, ll_custom8_cnt
double	ld_pmr_custom4_amt, ld_pmr_custom5_amt, ld_pmr_custom6_amt, ld_pmr_custom7_amt, &
			ld_pmr_custom8_amt, ld_pmr_custom9_amt 
// End JFS 02/09/01

setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
lv_init_date = date(1900,01,01)
lv_init_time = time(00,00,01)
ldt_default	=	DateTime (lv_init_date)				// FDG 03/21/01

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

ll_dw_row = w_case_maint.tab_case.tabpage_general.dw_general.GetRow()
ls_case_id = w_case_maint.tab_case.tabpage_general.dw_general.GetItemString(ll_dw_row,"case_id")
ls_case_spl = w_case_maint.tab_case.tabpage_general.dw_general.GetItemString(ll_dw_row,"case_spl")
ls_case_ver = w_case_maint.tab_case.tabpage_general.dw_general.GetItemString(ll_dw_row,"case_ver")
gv_active_case = Trim (ls_case_id + ls_case_spl + ls_case_ver)			// FDG 04/16/01

//lv_case_cat    = left(w_case_maint.ddlb_case_cat.text,3)
lv_case_cat = w_case_maint.tab_case.tabpage_general.dw_general.GetItemString(ll_dw_row,"case_cat")
If gv_active_case <> in_case_id + in_case_spl + in_case_ver then	//ajs 4.0 03-11-98
	Messagebox ('EDIT','Must Retrieve Record Before Referring')
//	setfocus(sle_Case_id)
	RETURN
End If

// FDG 01/17/02.  Track 2696d - remove in_case_refer_to edit
//If in_case_refer_to = '' then
	If trim(ddlb_referto.text) = '' or &
		trim(ddlb_referto.text) = 'NONE'		then
		Messagebox('EDIT','Refer To Department Must be entered')
		selectitem(ddlb_referto,1)
		setfocus(ddlb_referto)
		RETURN
	End If
//Else
//	Messagebox('EDIT','Case has been referred earlier')
//	RETURN
//End IF
// FDG 01/17/02 end

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
in_case_id	=	Trim (in_case_id)
li_rc	=	gnv_sql.of_TrimData (in_case_spl)
li_rc	=	gnv_sql.of_TrimData (in_case_ver)
// FDG 04/16/01 - end

setmicrohelp(w_main,'Referring Case')
// 09/01/98 AJS   FS362 convert case to case_cntl
// 02/09/01 JFS - include PIMR data
Select 	 dept_id,user_id,
			 case_asgn_id,case_asgn_prio,case_asgn_date,
			 refer_from_dept,refer_to_dept,
			 refer_by_rep,refer_date,
			 case_datetime,case_type,
			 case_cat,case_business,case_line_b,
			 case_plan,case_trk_type,
			 case_edit,//case_savings,
			 case_disp_hold,
			 case_from_period,case_to_period,
			 case_status,case_disp,
			 case_updt_user,case_status_date,
			 case_desc,case_status_desc,CASE_DATE_RECV,
			 identified_amt,future_savings_amt,
			 case_custom1_amt,case_custom2_amt,case_custom3_amt,
			 pmr_contractor_id,pmr_ready_cd,pmr_created_cd,
			 pmr_ready_date,pmr_created_date,pmr_prov_type_cd,
			 pmr_custom1_cd,pmr_custom1_char,pmr_case_custom1_cnt,
			 pmr_case_custom2_cnt,pmr_case_custom4_amt,pmr_case_custom5_amt,
			 pmr_case_custom6_amt,pmr_case_custom3_cnt,pmr_case_custom4_cnt,
			 pmr_case_custom5_cnt,pmr_case_custom7_amt,pmr_custom1_date,
			 pmr_custom2_cd,pmr_custom3_cd,pmr_frd_rfrl_cd,pmr_acpt_cd,
			 pmr_ready_user,pmr_created_user,case_prov_spec,
			 pmr_case_custom8_amt,pmr_case_custom9_amt,pmr_case_custom6_cnt,
			 pmr_case_custom7_cnt,pmr_case_custom8_cnt,pmr_custom2_char,
			 pmr_custom4_cd,pmr_custom5_cd,pmr_custom2_date,pmr_custom3_date,
			 pmr_subject_id
	into	 :Lv_dept,:ls_user,
			 :lv_assigned,:lv_assigned_priority,:lv_assigned_date,
			 :lv_refer_from,:in_case_refer_to,
			 :lv_refer_by,:lv_refer_date,
			 :ldt_create_date,:lv_case_type,
			 :IN_case_cat,:lv_case_business,:lv_line_of_bus,
			 :lv_plan,:lv_track_type,
			 :lv_edit,//:lv_savings,
			 :lv_disp_hold,
			 :ldt_period_from,:ldt_period_to,
			 :in_case_status,:in_case_disposition,
			 :in_case_status_user,:lv_current_datetime,
			 :lv_case_desc,:in_case_status_desc,:lv_receipt_date,
			 :ld_identified_amt,:ld_future_savings_amt,
			 :ld_case_custom1_amt,:ld_case_custom2_amt,:ld_case_custom3_amt,
			 :ls_cont_id,:ls_ready_cd,:ls_created_cd,
			 :ldt_ready_date,:ldt_created_date,:ls_prov_type,
			 :ls_custom1_cd,:ls_custom1_char,:ll_custom1_cnt,
			 :ll_custom2_cnt,:ld_pmr_custom4_amt,:ld_pmr_custom5_amt,
			 :ld_pmr_custom6_amt,:ll_custom3_cnt,:ll_custom4_cnt,
			 :ll_custom5_cnt,:ld_pmr_custom7_amt,:ldt_custom1_date,
			 :ls_custom2_cd,:ls_custom3_cd,:ls_frd_rfrl_cd,:ls_acpt_cd,
			 :ls_ready_user,:ls_created_user,:ls_case_prov_spec,
			 :ld_pmr_custom8_amt,:ld_pmr_custom9_amt,:ll_custom6_cnt,
			 :ll_custom7_cnt,:ll_custom8_cnt,:ls_custom2_char,
			 :ls_custom4_cd,:ls_custom5_cd,:ldt_custom2_date,:ldt_custom3_date,
			 :ls_subject_id
	 from  case_CNTL
	where  case_id  = Upper( :IN_case_id ) and 
			 case_spl = Upper( :IN_case_spl ) and
			 case_ver = Upper( :IN_case_ver )
Using  stars2ca;

If stars2ca.of_check_status() = 100 then 
	Errorbox(stars2ca,'Case Cannot be Retrieved')
	return
Elseif stars2ca.sqlcode <> 0 then
	Errorbox(stars2ca,'Error Reading Case Id')
	RETURN
End If

//NLG 11-1-99 These are the money amounts rolled up from Track
//					Per JGG, make them 0
ld_op_amt					= 0
ld_amt_recv 				= 0
ld_recovered_addtl_amt 	= 0
ld_referred_amt 			= 0
ld_amt_writeoff 			= 0
ld_balance_remaining_amt= 0
ld_custom1_amt 			= 0
ld_custom2_amt 			= 0
ld_custom3_amt 			= 0
ld_custom4_amt 			= 0
ld_custom5_amt 			= 0
ld_custom6_amt 			= 0

// FDG 03/21/01 - initialize PIMR status fields
ls_ready_cd					=	' '
ls_created_cd				=	' '
ldt_ready_date				=	ldt_default
ldt_created_date			=	ldt_default
ls_ready_user				=	' '
ls_created_user			=	' '
// FDG 03/21/01 end

in_case_status_date = date(lv_current_datetime)     //alabama4 pat-d

If in_case_cat = 'CA?' then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	selectitem(ddlb_referto,1)                  //ALABAMA 2 PAT-D
   If  lv_case_cat /* left(w_case_maint.ddlb_case_cat.text,3)*/ <> 'CA?' then
		Messagebox('EDIT','Cannot Refer Potential Cases, Update Case Category')
		RETURN
	Else
		Messagebox('EDIT','Cannot Refer Potential Cases')
		RETURN
	End IF
End If

// Begin - Track 3063d
//If in_case_status = 'CL' then
If in_case_status = 'CL' OR in_case_status = 'RC' then
// End - Track 3063d
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		errorbox(stars2ca,'Error Committing to Stars2')
		Return
	End If	
	selectitem(ddlb_referto,1)                  //ALABAMA 2 PAT-D
	Messagebox('EDIT','Cannot Refer Closed Cases')
	RETURN
End If

// FDG 09/12/01 - begin.	Remove database updates from this script and add additional edits.
//									User ID is required and no pending jobs for this case can exist.
//

// No pending jobs can exist for this case.
n_ds		lds_pending
String	ls_pending_jobs,		&
			ls_job_id,				&
			ls_prev_job = ''

lds_pending	=	CREATE	n_ds
lds_pending.DataObject	=	'd_pending_jobs'
lds_pending.SetTransObject (Stars2ca)

ll_rowcount	=	lds_pending.Retrieve (in_case_id, in_case_spl, in_case_ver)

IF	ll_rowcount	>	0		THEN
	FOR ll_row	=	1	TO	ll_rowcount
		// Include all unique job IDs in the message
		ls_job_id		=	lds_pending.object.job_desc [ll_row]
		IF	ls_job_id	<>	ls_prev_job		THEN
			ls_prev_job	=	ls_job_id
			ls_pending_jobs	=	ls_pending_jobs	+	"~r~n"	+	ls_job_id
		END IF
	NEXT
	MessageBox ('EDIT', 'This case cannot be referred because the following pending jobs are '	+	&
					'associated with this case: '	+	ls_pending_jobs)
	Destroy	lds_pending
	RETURN
END IF

Destroy	lds_pending

// Display a warning message if no user is specified.
ls_user_id	=	Trim ( dw_user.object.user_id [1] )

// SAH 03/12/02 Track 2862
IF IsNull(ls_user_id) OR len(ls_user_id) = 0 OR ls_user_id = " " THEN
	MessageBox('EDIT', 'The User ID is required.' )
	SetFocus(dw_user)
	Return
END IF


//IF	IsNull (ls_user_id)					&
//OR	Len (ls_user_id)		=	0			&
//OR	Upper (ls_user_id)	=	'NONE'	THEN
//	// No user assigned.  Display a warning message and continue with the referral.
//	//dw_user.SetColumn ('user_id')
//	//dw_user.SetFocus()
//	IF MessageBox ('Warning', 'No user has been designated to review unassigned referrals.  '	+	&
//					'Therefore no user will be alerted to this referral.  Please contact '		+	&
//					'the user via other means and contact your STARS administrator to set '		+	&
//					'the appropriate STARS preferences. The assigned user will be "NONE" '     +  &
//					'Would you like to continue with the referral?', Question!, YesNo!) = 2 THEN
//					Return
//	END IF
//END IF

//lv_refer_date = gnv_app.of_get_server_date_time()//ts2020c
//st_referdate.text = string(lv_refer_date,"mm/dd/yyyy hh:mm:ss") //ts2020c
//lv_case_status_desc = 'CASE REFERRED'
//lv_current_datetime = gnv_app.of_get_server_date_time()//ts2020c
//
////	01/09/01	GaryR	Stars 4.7 DataBase Port			// FDG 04/16/01
//IF Trim( ddlb_referto.text ) = "" THEN ddlb_referto.text = ls_empty
//
//// 09/01/98 AJS   FS362 convert case to case_cntl
//Update Case_CNTL
//			Set
//				 case_disp     = 'REFERRED',                   //alabama2 pat-d				
//				 case_updt_user = :gc_user_id,                //alabama2 pat-d
//				 case_status_date = :lv_current_datetime,    //alabama2 pat-d
//				 case_status_desc = :lv_case_status_desc,   //alabama2 pat-d
//				 Refer_to_dept = :ddlb_referto.text,
//				 Refer_date    = :lv_refer_date
//			where case_id  = Upper( :in_case_id ) and
//					case_spl = Upper( :in_case_spl ) and
//					case_ver = Upper( :in_case_ver )
//Using stars2ca;
//
//If stars2ca.of_check_status() <> 0 then
//	Errorbox(Stars2ca,'Error Updating Case for Refer Fields')
//	RETURN
//End If
//
//in_case_disposition = 'REFERRED'                 //alabama2 pat-d
//in_case_status_user = gc_user_id                 //alabama2 pat-d
//in_case_status_desc = lv_case_status_desc        //alabama2 pat-d 
//st_referdate.text = string(date(lv_current_datetime),"mm/dd/yyyy hh:mm:ss")  //alabama2 pat-d
//in_case_status_date   = date(st_referdate.text)   //alabama4 pat-d
//
//lv_today_datetime = datetime(date(lv_current_datetime),now())    //alabama4 pat-d
//
//lv_system_datetime = gnv_app.of_get_server_date_Time()//ts2020c use server date, not pc date
//
////NLG 11-1-99 Add the new money columns
//// 02/09/01 JFS - include PIMR data
////Write an entry to the log file for the changed disposition     //alabama2 pat-d
//Insert into Case_log
//			(case_id,case_spl,case_ver,
//			 status,disp,
//			 status_desc,status_datetime,
//			 User_id,sys_datetime,
//			 identified_amt,future_savings_amt,
//			 case_custom1_amt,case_custom2_amt,case_custom3_amt,
//			 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//			 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//			 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//			 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//			 pmr_case_custom4_amt,pmr_case_custom5_amt,
//			 pmr_case_custom6_amt,pmr_case_custom7_amt,
//			 pmr_case_custom8_amt,pmr_case_custom9_amt)
//		Values
//			(:in_case_id,:in_case_spl,:in_case_ver,
//			 :in_case_status,:in_case_disposition,
//			 :in_case_status_desc,:lv_today_datetime,   //alabama4 pat-d
//			 :gc_user_id,:lv_system_datetime,
//			 :ld_identified_amt,:ld_future_savings_amt,
//			 :ld_case_custom1_amt,:ld_case_custom2_amt,:ld_case_custom3_amt,
//			 :ll_custom1_cnt,:ll_custom2_cnt,
//			 :ll_custom3_cnt,:ll_custom4_cnt,
//			 :ll_custom5_cnt,:ll_custom6_cnt,
//			 :ll_custom7_cnt,:ll_custom8_cnt,
//			 :ld_pmr_custom4_amt,:ld_pmr_custom5_amt,
//			 :ld_pmr_custom6_amt,:ld_pmr_custom7_amt,
//			 :ld_pmr_custom8_amt,:ld_pmr_custom9_amt)
//Using stars2ca;
//If stars2ca.of_check_status() <> 0 then 
//		cb_close.default = true
//		Errorbox(stars2ca,'Error Inserting Case Log')
//		RETURN
//End If
//
//lv_case_ver		 = string(integer(IN_case_ver) + 1)
//if len(lv_case_ver) = 1 then
//	lv_case_ver = '0' + lv_case_ver
//End If
//
//lv_current_datetime = gnv_app.of_get_server_date_time()//ts2020c use server date
//lv_status			 = 'OP'
//lv_disposition 	 = 'SYSREFER'    //refered
//lv_case_status_desc = 'Referred Case'          //alabama2 pat-d
//lv_refer_date = datetime(lv_init_date,lv_init_time)
//
//ldt_receipt_date = gnv_app.of_get_server_date_time()//ts2020c use server date
//lv_created_datetime = ldt_receipt_date
//lv_assigned = 'NONE'		// FNC 11/03/99
//
////NLG 11-09-99 Make assign date be today's date - Setting it to null
////					caused bad assign date when view/update case details
////					for original case
////lv_assigned_date = lv_refer_date  
//lv_assigned_date = ldt_receipt_date
//
////	01/09/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
//IF Trim( lv_assigned_priority )	= "" THEN lv_assigned_priority	= ls_empty
//IF Trim( gc_user_dept )				= "" THEN gc_user_dept				= ls_empty
//IF Trim( gc_user_id )				= "" THEN gc_user_id					= ls_empty
//IF Trim( lv_line_of_bus )			= "" THEN lv_line_of_bus			= ls_empty
//IF Trim( lv_plan )					= "" THEN lv_plan						= ls_empty
//IF Trim( lv_edit )					= "" THEN lv_edit						= ls_empty
//IF Trim( lv_case_desc )				= "" THEN lv_case_desc				= ls_empty
////	01/09/01	GaryR	Stars 4.7 DataBase Port - End
//
////NLG 11-1-99 Add new money columns
//// 09/01/98 AJS   FS362 convert case to case_cntl
//// 02/09/01 JFS - include PIMR data
//Insert into Case_CNTL 
//		 	(dept_id,user_id,
//			 case_id,case_spl,case_ver,
//			 case_asgn_id,case_asgn_prio,case_asgn_date,
//			 refer_from_dept,refer_to_dept,
//			 refer_by_rep,refer_date,
//			 case_datetime,case_type,
//			 case_cat,case_business,case_line_b,
//			 case_plan,case_trk_type,
//			 case_edit,//case_savings,
//			 case_disp_hold,
//			 case_from_period,case_to_period,
//			 case_status,case_disp,
//			 case_updt_user,case_status_date,
//			 case_desc,case_status_desc,case_date_recv,
//			 identified_amt,op_amt,amt_recv,
//			 recovered_addtl_amt,future_savings_amt,
//			 referred_amt,amt_writeoff,balance_remaining_amt,
//			 case_custom1_amt,case_custom2_amt,case_custom3_amt,
//			 custom1_amt,custom2_amt,custom3_amt,custom4_amt,custom5_amt,custom6_amt,
//			 pmr_contractor_id,pmr_ready_cd,pmr_created_cd,
//			 pmr_ready_date,pmr_created_date,pmr_prov_type_cd,
//			 pmr_custom1_cd,pmr_custom1_char,pmr_case_custom1_cnt,
//			 pmr_case_custom2_cnt,pmr_case_custom4_amt,pmr_case_custom5_amt,
//			 pmr_case_custom6_amt,pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//			 pmr_case_custom5_cnt,pmr_case_custom7_amt,pmr_custom1_date,
//			 pmr_custom2_cd,pmr_custom3_cd,pmr_frd_rfrl_cd,pmr_acpt_cd,
//			 pmr_ready_user,pmr_created_user,case_prov_spec,
//			 pmr_case_custom8_amt,pmr_case_custom9_amt,pmr_case_custom6_cnt,
//			 pmr_case_custom7_cnt,pmr_case_custom8_cnt,pmr_custom2_char,
//			 pmr_custom4_cd,pmr_custom5_cd,pmr_custom2_date,pmr_custom3_date,
//			 pmr_subject_id)
//		Values	
//			(:ddlb_referto.text,:ls_user,
//			 :in_case_id,:in_case_spl,:lv_case_ver,
//			 :lv_assigned,:lv_assigned_priority,:lv_assigned_date,
//			 :gc_user_dept,' ',:gc_user_id,:lv_refer_date,
//			 :ldt_create_date,:lv_case_type,
//			 'REF',:lv_case_business,:lv_line_of_bus,
//			 :lv_plan,:lv_track_type,
//			 :lv_edit,//:lv_savings,
//			 ' ',
//			 :ldt_period_from,:ldt_period_to,
//			 :lv_status,:lv_disposition,
//			 :gc_USER_ID,:lv_current_datetime,
//			 :lv_case_desc,:lv_case_status_desc,:ldt_receipt_date,
//			 :ld_identified_amt,:ld_op_amt,:ld_amt_recv,
//			 :ld_recovered_addtl_amt,:ld_future_savings_amt,
//			 :ld_referred_amt,:ld_amt_writeoff,:ld_balance_remaining_amt,
//			 :ld_case_custom1_amt,:ld_case_custom2_amt,:ld_case_custom3_amt,
//			 :ld_custom1_amt,:ld_custom2_amt,:ld_custom3_amt,:ld_custom4_amt,:ld_custom5_amt,:ld_custom6_amt,
//			 :ls_cont_id,:ls_ready_cd,:ls_created_cd,
//			 :ldt_ready_date,:ldt_created_date,:ls_prov_type,
//			 :ls_custom1_cd,:ls_custom1_char,:ll_custom1_cnt,
//			 :ll_custom2_cnt,:ld_pmr_custom4_amt,:ld_pmr_custom5_amt,
//			 :ld_pmr_custom6_amt,:ll_custom3_cnt,:ll_custom4_cnt,
//			 :ll_custom5_cnt,:ld_pmr_custom7_amt,:ldt_custom1_date,
//			 :ls_custom2_cd,:ls_custom3_cd,:ls_frd_rfrl_cd,:ls_acpt_cd,
//			 :ls_ready_user,:ls_created_user,:ls_case_prov_spec,
//			 :ld_pmr_custom8_amt,:ld_pmr_custom9_amt,:ll_custom6_cnt,
//			 :ll_custom7_cnt,:ll_custom8_cnt,:ls_custom2_char,
//			 :ls_custom4_cd,:ls_custom5_cd,:ldt_custom2_date,:ldt_custom3_date,
//			 :ls_subject_id)
//Using  stars2ca;
//
//If stars2ca.of_check_status() <> 0  then
//	ROLLBACK using STARS2CA; 										
//	// FDG 12/05/00 - Make error checking DBMS-independent
//	//If stars2ca.sqldbcode = 2601 then 
//	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
//		Messagebox('ERROR','Case Referred Already Exists')
//		return
//	Else
//		Errorbox(stars2ca,'Error Inserting into Case Id')
//		RETURN
//	End If
//End If
//
////NLG add new money columns
//// 02/09/01 JFS - include PIMR data
////Write to Case Log opening of New Refer case 
////and Present Status/Disposition
//lv_system_datetime = lv_created_datetime
//Insert into Case_log
//		(case_id,case_spl,case_ver,
//		 status,disp,
//		 status_desc,status_datetime,
//		 User_id,sys_datetime,
//		 identified_amt,future_savings_amt,
//			case_custom1_amt,case_custom2_amt,case_custom3_amt,
//			pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//			 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//			 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//			 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//			 pmr_case_custom4_amt,pmr_case_custom5_amt,
//			 pmr_case_custom6_amt,pmr_case_custom7_amt,
//			 pmr_case_custom8_amt,pmr_case_custom9_amt)
//	Values
//		(:in_case_id,:in_case_spl,:lv_case_ver,
//		 'OP','SYSADD','New Referred Case Added',:lv_created_datetime,   //alabama2 pat-d
//		 :gc_user_id,:lv_system_datetime,
//		 :ld_identified_amt,:ld_future_savings_amt,
//			 :ld_case_custom1_amt,:ld_case_custom2_amt,:ld_case_custom3_amt,
//			 :ll_custom1_cnt,:ll_custom2_cnt,
//			 :ll_custom3_cnt,:ll_custom4_cnt,
//			 :ll_custom5_cnt,:ll_custom6_cnt,
//			 :ll_custom7_cnt,:ll_custom8_cnt,
//			 :ld_pmr_custom4_amt,:ld_pmr_custom5_amt,
//			 :ld_pmr_custom6_amt,:ld_pmr_custom7_amt,
//			 :ld_pmr_custom8_amt,:ld_pmr_custom9_amt)
//Using stars2ca;
//If stars2ca.of_check_status() <> 0 then 
//	cb_close.default = true
//	Errorbox(stars2ca,'Error Inserting Case Log')
//	RETURN
//End If
//
////NLG add new money columns
//// 02/09/01 JFS - include PIMR data
//Insert into Case_log
//		(case_id,case_spl,case_ver,
//		 status,disp,
//		 status_desc,status_datetime,
//		 User_id,sys_datetime,
//		 identified_amt,future_savings_amt,
//			 case_custom1_amt,case_custom2_amt,case_custom3_amt,
//			 pmr_case_custom1_cnt,pmr_case_custom2_cnt,
//			 pmr_case_custom3_cnt,pmr_case_custom4_cnt,
//			 pmr_case_custom5_cnt,pmr_case_custom6_cnt,
//			 pmr_case_custom7_cnt,pmr_case_custom8_cnt,
//			 pmr_case_custom4_amt,pmr_case_custom5_amt,
//			 pmr_case_custom6_amt,pmr_case_custom7_amt,
//			 pmr_case_custom8_amt,pmr_case_custom9_amt)
//	Values
//		(:in_case_id,:in_case_spl,:lv_case_ver,
//		 :lv_status,:lv_disposition,
//		 :lv_case_status_desc,:lv_created_datetime,           //alabama2 pat-d
//		 :gc_user_id,:lv_system_datetime,
//		 :ld_identified_amt,:ld_future_savings_amt,
//			 :ld_case_custom1_amt,:ld_case_custom2_amt,:ld_case_custom3_amt,
//			 :ll_custom1_cnt,:ll_custom2_cnt,
//			 :ll_custom3_cnt,:ll_custom4_cnt,
//			 :ll_custom5_cnt,:ll_custom6_cnt,
//			 :ll_custom7_cnt,:ll_custom8_cnt,
//			 :ld_pmr_custom4_amt,:ld_pmr_custom5_amt,
//			 :ld_pmr_custom6_amt,:ld_pmr_custom7_amt,
//			 :ld_pmr_custom8_amt,:ld_pmr_custom9_amt)
//Using stars2ca;
//If stars2ca.of_check_status() <> 0 then 
//	cb_close.default = true
//	Errorbox(stars2ca,'Error Inserting Case Log')
//	RETURN
//End If
//
//
//li_rc = dw_case_link.SetTransObject(STARS2CA)
//if li_rc <> 1 then
//	ErrorBox(Stars2ca,'Cannot retrieve case link information.~r'+&
//					'Error in SetTransObject.  Referral cancelled.')
//	cb_refer.enabled = false
//	return
//end if
//
//ll_row = dw_case_link.retrieve(in_case_id, in_case_spl, in_case_ver)
//if ll_row < 0 then
// 	ErrorBox(Stars2ca,'Cannot retrieve case link information.~r'+&
//					'Error in Retrieve.  Referral cancelled.')
//	cb_refer.enabled = false
//	return
//end if
//
//setmicrohelp(w_main,'Updating case link information')
//
//if ll_row > 0 then
//	for ll_row_num = 1 to ll_row
//		ls_link_type = dw_case_link.GetItemString(ll_row_num, 'link_type')
//		ls_link_key = dw_case_link.GetItemString(ll_row_num, 'link_key')
//		ls_link_name = dw_case_link.GetItemString(ll_row_num, 'link_name')
//		ls_link_desc = dw_case_link.GetItemString(ll_row_num, 'link_desc')
//		ls_user_id = dw_case_link.GetItemString(ll_row_num, 'user_id')
//		ldt_link_date = dw_case_link.GetItemDateTime(ll_row_num, 'link_date')
//		ls_link_status = dw_case_link.GetItemString(ll_row_num, 'link_status')
//
//		//	01/09/01	GaryR	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
//		IF Trim( ls_link_type )				= "" THEN ls_link_type				= ls_empty
//		IF Trim( ls_link_key )				= "" THEN ls_link_key				= ls_empty
//		IF Trim( ls_link_name )				= "" THEN ls_link_name				= ls_empty
//		IF Trim( ls_link_desc )				= "" THEN ls_link_desc				= ls_empty
//		IF Trim( ls_user_id )				= "" THEN ls_user_id					= ls_empty
//		IF Trim( ls_link_status )			= "" THEN ls_link_status			= ls_empty
//		//	01/09/01	GaryR	Stars 4.7 DataBase Port - End
//
//		//insert rows for new case_ver		
//		ll_new_row = ll_row_num + ll_row		
//		dw_case_link.InsertRow(ll_new_row)
//		dw_case_link.setItem(ll_new_row,'case_id',in_case_id)
//		dw_case_link.setItem(ll_new_row,'case_spl',in_case_spl)
//		dw_case_link.setItem(ll_new_row,'case_ver',lv_case_ver)
//		dw_case_link.setItem(ll_new_row,'link_type',ls_link_type)
//		dw_case_link.setItem(ll_new_row,'link_key',ls_link_key)
//		dw_case_link.setItem(ll_new_row,'link_name',ls_link_name)
//		dw_case_link.setItem(ll_new_row,'link_desc',ls_link_desc)
//		dw_case_link.setItem(ll_new_row,'user_id',ls_user_id)
//		dw_case_link.setItem(ll_new_row,'link_date',ldt_link_date)
//		dw_case_link.setItem(ll_new_row,'link_status',ls_link_status)
//	next
//	
//	li_rc = dw_case_link.EVENT ue_update( TRUE, TRUE )
//	
//	if li_rc <> 1 then
//		ErrorBox(Stars2ca,'Error updating case link information. Case Not Referred.')
//		cb_refer.enabled = false
//		return
//	end if
//
//
//end if //ll_row >0
//
//COMMIT USING STARS2CA;
//li_rc = STARS2CA.of_check_status()
//if  li_rc >= 0 then
//	STARS2CA.of_commit()
//else
//	Errorbox(STARS2CA,'Error performing Commit ~rin cb_refer of w_case_referral')
//end if
//
//setmicrohelp(w_main,'Case Referred')
//st_newcaseno.text = in_case_id + in_case_spl + lv_case_ver
//
////w_case_maint.sle_changed_by.text = gc_user_id                     //alabama2 pat-d
////w_case_maint.sle_disposition.text = in_case_disposition + '-Case Referred'          //alabama2 pat-d
////w_case_maint.sle_current_desc.text = in_case_status_desc          //alabama2 pat-d
//ls_refer_disp = in_case_disposition + '-Case Referred'
//w_case_maint.tab_case.tabpage_general.dw_general.SetItem(ll_dw_row,"case_updt_user",gc_user_id)
//w_case_maint.tab_case.tabpage_general.dw_general.SetItem(ll_dw_row,"case_disp",ls_refer_disp)
//w_case_maint.tab_case.tabpage_general.dw_general.SetItem(ll_dw_row,"case_status_desc",ls_refer_disp)
//
//
//in_case_refer_to  = ddlb_referto.text
//ddlb_referto.enabled = false
//cb_refer.enabled = false
//message.StringParm = 'Disable'

// FDG 09/12/01	- begin.  Close window and return the pertinent information.
istr_case_refer.b_case_referred	=	TRUE
istr_case_refer.s_user_id			=	dw_user.object.user_id [1]
istr_case_refer.s_dept_id			=	Trim (Left((ddlb_referto.text), 3))	// SAH 01/25/02 return just the dept_id, not desc
//istr_case_refer.s_dept_id        = Trim(ddlb_referto.text)

lv_case_ver		 = string(integer(IN_case_ver) + 1)
if len(lv_case_ver) = 1 then
	lv_case_ver = '0' + lv_case_ver
End If

istr_case_refer.s_case_ver			=	lv_case_ver

// 03/28/02	GaryR	Track 2958d
//CloseWithReturn (parent, istr_case_refer)
Close( PARENT )
// FDG 09/12/01	- end


end event

type st_newcaseno from statictext within w_case_referral
string accessiblename = "New Case Number"
string accessibledescription = "New Case Number"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 2245
integer y = 332
integer width = 846
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_referdate from statictext within w_case_referral
string accessiblename = "Referral Date"
string accessibledescription = "Referral Date"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 576
integer y = 468
integer width = 1111
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_referto from dropdownlistbox within w_case_referral
string accessiblename = "Refer to  "
string accessibledescription = "Refer to  "
accessiblerole accessiblerole = comboboxrole!
integer x = 576
integer y = 184
integer width = 1111
integer height = 480
integer taborder = 10
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

event selectionchanged;// ddlb_referto.selectionchanged
//
// FDG	09/12/01	Stars 4.8.1. Filter dw_user based on this selection
// SAH   03/12/02 Track 2862   User ID is required/remove 'NONE' 

String	ls_dept,		&
			ls_user
			
// SAH 01/25/02  Get only the dept code, remove the description
ls_dept	=	Trim ( Upper( Left(This.text, 3) ) )
//ls_dept	=	Trim ( Upper(This.text) )

IF	IsNull(ls_dept)		&
OR	Len(ls_dept) =	0		THEN
	ls_dept	=	'999999'		// Bogus value
END IF

// Reset any previous selected user ID
ls_user	=	dw_user.uf_get_default_user (ls_dept)

// SAH 03/11/02 Track 2862

IF	Trim(ls_user)	=	''		THEN
	//dw_user.object.user_id [1]	=	'NONE'
	// Clear out last user_id
	st_default_id.Text = 'UNKNOWN'
	dw_user.object.user_id[1] = ' '
	MessageBox('Warning','No default user has been set for this department.  Please select a specific' +&
				 ' User ID or a different department and contact your Systems Administrator to set up a default user.')
ELSE
	dw_user.object.user_id [1]	=	ls_user
	st_default_id.Text = " " + ls_user
END IF

dw_user.uf_filter_dept (ls_dept)


end event

type st_referby from statictext within w_case_referral
string accessiblename = "Referred By"
string accessibledescription = "Referred By"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 2245
integer y = 48
integer width = 841
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_referfrom from statictext within w_case_referral
string accessiblename = "Referred From"
string accessibledescription = "Referred From"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 576
integer y = 48
integer width = 1111
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_case_referral
string accessiblename = "New Case Number"
string accessibledescription = "New Case Number"
accessiblerole accessiblerole = statictextrole!
integer x = 1765
integer y = 332
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "New Case No.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_case_referral
string accessiblename = "Referral Date"
string accessibledescription = "Referral Date"
accessiblerole accessiblerole = statictextrole!
integer x = 137
integer y = 472
integer width = 425
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Referral Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_case_referral
string accessiblename = "Refer To Dept"
string accessibledescription = "Refer To Dept"
accessiblerole accessiblerole = statictextrole!
integer x = 123
integer y = 192
integer width = 439
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Refer To Dept:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_case_referral
string accessiblename = "Referred By"
string accessibledescription = "Referred By"
accessiblerole accessiblerole = statictextrole!
integer x = 1765
integer y = 48
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Referred By:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_case_referral
string accessiblename = "Referred From"
string accessibledescription = "Referred From"
accessiblerole accessiblerole = statictextrole!
integer x = 105
integer y = 48
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Referred From:"
alignment alignment = right!
boolean focusrectangle = false
end type

