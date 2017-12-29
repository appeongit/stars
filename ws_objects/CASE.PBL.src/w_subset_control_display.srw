$PBExportHeader$w_subset_control_display.srw
$PBExportComments$Inherited from w_master
forward
global type w_subset_control_display from w_master
end type
type sle_subc_tables from singlelineedit within w_subset_control_display
end type
type st_subc_tables from statictext within w_subset_control_display
end type
type st_3 from statictext within w_subset_control_display
end type
type sle_type from singlelineedit within w_subset_control_display
end type
type st_2 from statictext within w_subset_control_display
end type
type sle_count from singlelineedit within w_subset_control_display
end type
type sle_run_date from singlelineedit within w_subset_control_display
end type
type st_1 from statictext within w_subset_control_display
end type
type sle_criteria_id from singlelineedit within w_subset_control_display
end type
type st_count from statictext within w_subset_control_display
end type
type cb_4 from u_cb within w_subset_control_display
end type
type sle_subset_source_used from singlelineedit within w_subset_control_display
end type
type st_source from statictext within w_subset_control_display
end type
type mle_description from multilineedit within w_subset_control_display
end type
type sle_subset_id from singlelineedit within w_subset_control_display
end type
type st_description from statictext within w_subset_control_display
end type
type st_bb-key from statictext within w_subset_control_display
end type
type cb_close from u_cb within w_subset_control_display
end type
type st_billed_chrgs from statictext within w_subset_control_display
end type
type st_allwd_amt from statictext within w_subset_control_display
end type
type st_denied from statictext within w_subset_control_display
end type
type st_pymt from statictext within w_subset_control_display
end type
type em_billed_chrg from editmask within w_subset_control_display
end type
type em_allwd_amt from editmask within w_subset_control_display
end type
type em_denied_amt from editmask within w_subset_control_display
end type
type em_pymt from editmask within w_subset_control_display
end type
end forward

global type w_subset_control_display from w_master
string accessiblename = "Case Subset Information"
string accessibledescription = "Case Subset Information"
accessiblerole accessiblerole = windowrole!
integer x = 539
integer y = 280
integer width = 1609
integer height = 1692
string title = "Case Subset Information"
windowtype windowtype = response!
long backcolor = 67108864
sle_subc_tables sle_subc_tables
st_subc_tables st_subc_tables
st_3 st_3
sle_type sle_type
st_2 st_2
sle_count sle_count
sle_run_date sle_run_date
st_1 st_1
sle_criteria_id sle_criteria_id
st_count st_count
cb_4 cb_4
sle_subset_source_used sle_subset_source_used
st_source st_source
mle_description mle_description
sle_subset_id sle_subset_id
st_description st_description
st_bb-key st_bb-key
cb_close cb_close
st_billed_chrgs st_billed_chrgs
st_allwd_amt st_allwd_amt
st_denied st_denied
st_pymt st_pymt
em_billed_chrg em_billed_chrg
em_allwd_amt em_allwd_amt
em_denied_amt em_denied_amt
em_pymt em_pymt
end type
global w_subset_control_display w_subset_control_display

type variables
// Parm passed to this window
String	is_parm

end variables

event open;call super::open;//*******************************************************************************
//Modifications:
//01-26-98 NLG 4.0 Subset Redesign:
//					1.	display external subset id, but use internal subset id for
//						database access
//					2.	use nvo_subset_functions to retrieve internal id using external id
//					3.	Instead of retrieving data from sub_cntl_used, use sub_cntl
//03-11-98 AJS 4.0 Fix split of case id
//07-13-98 AJS 4.0 If source deleted display deleted
//09-02-98 AJS 4.0 Track #1652 Add link type to SQL 
//04/16/01 FDG	Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//*******************************************************************************
Datetime lv_runtime
Long     lv_no_rows
String   lv_case_id,lv_case_spl,lv_case_ver
string	ls_src_subset_id, ls_src_subset_case_id, ls_src_subset_case_spl //1-26-98 NLG 4.0
string	ls_src_subset_case_ver														 //1-26-98 NLG 4.0
nvo_subset_functions lnv_subset_functions											 //1-26-98 NLG 4.0
sx_subset_ids lstr_subset_ids															 //1-26-98 NLG 4.0
int		li_rc

setpointer(hourglass!)
//fx_set_window_colors(w_subset_control_display)
setmicrohelp(w_main,'Ready')
//this.x = 1650
//this.y = 450

lv_case_id = Trim (left(gv_active_case,10) )			// FDG 04/16/01
lv_case_spl = mid(gv_active_case,11,2)
lv_case_ver = mid(gv_active_case,13,2)

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (lv_case_spl)
li_rc	=	gnv_sql.of_TrimData (lv_case_ver)
// FDG 04/16/01 - end

//Archana 9-16-99
//Added billed charges, payment, allowed amount, denied amount sle and their retrieval to the select 
//statement

sle_subset_id.text = gc_active_subset_name
Select  sc.subc_sub_src_id,
         sc.subc_sub_src_case_id,
         sc.subc_sub_tbl_type,
         sc.subc_crit_id,
         cl.link_date,
         cl.link_desc,
         sc.subc_no_rows,
         sc.subc_tables,
		sc.billed_charges,
		sc.payment,
		sc.allowed_amt,
		sc.denied_amt
 Into    :ls_src_subset_id,
         :ls_src_subset_case_id,
         :sle_type.text,
         :sle_criteria_id.text,
         :lv_runtime,
         :mle_description.text,
         :lv_no_rows,
         :sle_subc_tables.text,
		:em_billed_chrg.text,
		:em_pymt.text,
		:em_allwd_amt.text,
		:em_denied_amt.text
 From    case_link   cl,
         sub_cntl    sc
 Where   cl.case_id      = Upper( :lv_case_id )
 and     cl.case_spl     = Upper( :lv_case_spl )
 and     cl.case_ver     = Upper( :lv_case_ver )
 and     cl.link_name     = Upper( :gc_active_subset_name )
 and     sc.subc_id      = cl.link_key
 and 		cl.link_type	= 'SUB'
 //09-02-98 AJS 4.0 Track #1652  added 'SUB above
 //1-26-98 NLG 4.0                   					stop**********
Using Stars2ca;
If Stars2ca.of_check_status() <> 0 then
	COMMIT using STARS2CA;
	If stars2ca.of_check_status() <> 0 Then
		Messagebox('EDIT','Error Commiting to Stars2')
		Return
	End If	
	Messagebox('EDIT','Subset Control Information is not Available')
	cb_close.PostEvent(Clicked!)
	RETURN
End IF

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('Edit','Error Commiting to Stars2')
	Return
End If	
sle_count.text = string(lv_no_rows)
sle_run_date.text = string(lv_runtime)

//01-26-98 NLG 4.0                                    ***start
IF trim(upper(ls_src_subset_case_id)) = 'NONE' THEN
	ls_src_subset_case_spl = ' '
	ls_src_subset_case_ver = ' '
ELSE
	ls_src_subset_case_spl = mid(ls_src_subset_case_id,11,2)
	ls_src_subset_case_ver = mid(ls_src_subset_case_id,13,2)	//ajs 4.0 03-11-98 fix split of case id
	ls_src_subset_case_id  = Trim (left(ls_src_subset_case_id, 10) )			// FDG 04/16/01
END IF

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_src_subset_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_src_subset_case_ver)
// FDG 04/16/01 - end

//ajs 4.0 07-13-98
If ls_src_subset_id > '' then
	Select  cl.link_name
	Into    :sle_subset_source_used.text
	From    case_link     cl
	Where   cl.case_id    	= Upper( :ls_src_subset_case_id )
			And cl.case_spl   = Upper( :ls_src_subset_case_spl )
			And cl.case_ver   = Upper( :ls_src_subset_case_ver )
			And cl.link_key   = Upper( :ls_src_subset_id )
			And cl.link_type = 'SUB'
	Using   stars2ca;

	if stars2ca.of_check_status() = 100 then
		sle_subset_source_used.text = 'DELETED'
	end if
End If
//ajs 4.0 07-13-98 end
//01-26-98 NLG 4.0                                    ***stop

//KMM Clear out message parm (PB Bug)
//SetNull(message.stringparm)
Setpointer(arrow!)
end event

on w_subset_control_display.create
int iCurrent
call super::create
this.sle_subc_tables=create sle_subc_tables
this.st_subc_tables=create st_subc_tables
this.st_3=create st_3
this.sle_type=create sle_type
this.st_2=create st_2
this.sle_count=create sle_count
this.sle_run_date=create sle_run_date
this.st_1=create st_1
this.sle_criteria_id=create sle_criteria_id
this.st_count=create st_count
this.cb_4=create cb_4
this.sle_subset_source_used=create sle_subset_source_used
this.st_source=create st_source
this.mle_description=create mle_description
this.sle_subset_id=create sle_subset_id
this.st_description=create st_description
this.st_bb-key=create st_bb-key
this.cb_close=create cb_close
this.st_billed_chrgs=create st_billed_chrgs
this.st_allwd_amt=create st_allwd_amt
this.st_denied=create st_denied
this.st_pymt=create st_pymt
this.em_billed_chrg=create em_billed_chrg
this.em_allwd_amt=create em_allwd_amt
this.em_denied_amt=create em_denied_amt
this.em_pymt=create em_pymt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_subc_tables
this.Control[iCurrent+2]=this.st_subc_tables
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.sle_type
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_count
this.Control[iCurrent+7]=this.sle_run_date
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_criteria_id
this.Control[iCurrent+10]=this.st_count
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.sle_subset_source_used
this.Control[iCurrent+13]=this.st_source
this.Control[iCurrent+14]=this.mle_description
this.Control[iCurrent+15]=this.sle_subset_id
this.Control[iCurrent+16]=this.st_description
this.Control[iCurrent+17]=this.st_bb-key
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.st_billed_chrgs
this.Control[iCurrent+20]=this.st_allwd_amt
this.Control[iCurrent+21]=this.st_denied
this.Control[iCurrent+22]=this.st_pymt
this.Control[iCurrent+23]=this.em_billed_chrg
this.Control[iCurrent+24]=this.em_allwd_amt
this.Control[iCurrent+25]=this.em_denied_amt
this.Control[iCurrent+26]=this.em_pymt
end on

on w_subset_control_display.destroy
call super::destroy
destroy(this.sle_subc_tables)
destroy(this.st_subc_tables)
destroy(this.st_3)
destroy(this.sle_type)
destroy(this.st_2)
destroy(this.sle_count)
destroy(this.sle_run_date)
destroy(this.st_1)
destroy(this.sle_criteria_id)
destroy(this.st_count)
destroy(this.cb_4)
destroy(this.sle_subset_source_used)
destroy(this.st_source)
destroy(this.mle_description)
destroy(this.sle_subset_id)
destroy(this.st_description)
destroy(this.st_bb-key)
destroy(this.cb_close)
destroy(this.st_billed_chrgs)
destroy(this.st_allwd_amt)
destroy(this.st_denied)
destroy(this.st_pymt)
destroy(this.em_billed_chrg)
destroy(this.em_allwd_amt)
destroy(this.em_denied_amt)
destroy(this.em_pymt)
end on

event ue_preopen;call super::ue_preopen;//is_parm	=	Message.Stringparm
//
end event

type sle_subc_tables from singlelineedit within w_subset_control_display
string accessiblename = "Invoice Types"
string accessibledescription = "Invoice Types"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 18
integer y = 624
integer width = 1211
integer height = 96
integer taborder = 30
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_subc_tables from statictext within w_subset_control_display
string accessiblename = "Invoice Types"
string accessibledescription = "Invoice Types"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 552
integer width = 896
integer height = 68
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Invoice Types:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_subset_control_display
string accessiblename = "Subset Type"
string accessibledescription = "Subset Type"
accessiblerole accessiblerole = statictextrole!
integer x = 1015
integer y = 20
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset Type:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_type from singlelineedit within w_subset_control_display
string accessiblename = "Subset Type"
string accessibledescription = "Subset Type"
accessiblerole accessiblerole = textrole!
integer x = 1024
integer y = 96
integer width = 201
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_subset_control_display
string accessiblename = "Created"
string accessibledescription = "Created"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 376
integer width = 306
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Created:"
boolean focusrectangle = false
end type

type sle_count from singlelineedit within w_subset_control_display
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = textrole!
integer x = 1024
integer y = 448
integer width = 498
integer height = 88
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_run_date from singlelineedit within w_subset_control_display
string accessiblename = "Created Date"
string accessibledescription = "Created Date"
accessiblerole accessiblerole = textrole!
integer x = 18
integer y = 452
integer width = 677
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

type st_1 from statictext within w_subset_control_display
string accessiblename = "Criteria ID"
string accessibledescription = "Criteria ID"
accessiblerole accessiblerole = statictextrole!
integer x = 1010
integer y = 204
integer width = 329
integer height = 60
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Criteria ID:"
alignment alignment = right!
end type

type sle_criteria_id from singlelineedit within w_subset_control_display
string accessiblename = "Criteria ID"
string accessibledescription = "Criteria ID"
accessiblerole accessiblerole = textrole!
integer x = 1024
integer y = 276
integer width = 498
integer height = 96
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_count from statictext within w_subset_control_display
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 1024
integer y = 376
integer width = 201
integer height = 68
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Count:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_4 from u_cb within w_subset_control_display
string accessiblename = "cr123"
string accessibledescription = "cr123"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1810
integer y = 1748
integer width = 119
integer height = 80
integer taborder = 10
string text = "cr123"
end type

type sle_subset_source_used from singlelineedit within w_subset_control_display
string accessiblename = "Subset Source ID"
string accessibledescription = "Subset Source ID"
accessiblerole accessiblerole = textrole!
integer x = 18
integer y = 276
integer width = 983
integer height = 96
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
textcase textcase = upper!
integer limit = 20
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_source from statictext within w_subset_control_display
string accessiblename = "Subset Srce ID"
string accessibledescription = "Subset Srce ID"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 204
integer width = 471
integer height = 60
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Subset Srce ID:"
alignment alignment = right!
end type

type mle_description from multilineedit within w_subset_control_display
string accessiblename = "Description"
string accessibledescription = "Description"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
string tag = "colorfixed"
integer x = 18
integer y = 800
integer width = 1499
integer height = 164
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 1073741824
integer limit = 80
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_subset_id from singlelineedit within w_subset_control_display
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 18
integer y = 96
integer width = 987
integer height = 96
fontcharset fontcharset = ansi!
string facename = "System"
long backcolor = 67108864
textcase textcase = upper!
integer limit = 20
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_description from statictext within w_subset_control_display
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 728
integer width = 370
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Description:"
alignment alignment = right!
end type

type st_bb-key from statictext within w_subset_control_display
string accessiblename = "Subset ID"
string accessibledescription = "Subset ID"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 20
integer width = 329
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Subset ID:"
alignment alignment = right!
end type

type cb_close from u_cb within w_subset_control_display
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1216
integer y = 1440
integer width = 251
integer height = 108
integer taborder = 20
string text = "&Close"
boolean default = true
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

close (parent)



end on

type st_billed_chrgs from statictext within w_subset_control_display
string accessiblename = "Billed Charges"
string accessibledescription = "Billed Charges"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 988
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Billed Charges:"
boolean focusrectangle = false
end type

type st_allwd_amt from statictext within w_subset_control_display
string accessiblename = "Allowed Amount"
string accessibledescription = "Allowed Amount"
accessiblerole accessiblerole = statictextrole!
integer x = 795
integer y = 988
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Allowed Amount:"
boolean focusrectangle = false
end type

type st_denied from statictext within w_subset_control_display
string accessiblename = "Denied Amount"
string accessibledescription = "Denied Amount"
accessiblerole accessiblerole = statictextrole!
integer x = 37
integer y = 1200
integer width = 507
integer height = 56
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Denied Amount:"
boolean focusrectangle = false
end type

type st_pymt from statictext within w_subset_control_display
string accessiblename = "Payment"
string accessibledescription = "Payment"
accessiblerole accessiblerole = statictextrole!
integer x = 795
integer y = 1200
integer width = 530
integer height = 68
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Payment:"
boolean focusrectangle = false
end type

type em_billed_chrg from editmask within w_subset_control_display
string accessiblename = "Billed Charges"
string accessibledescription = "Billed Charges"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 27
integer y = 1064
integer width = 722
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
alignment alignment = right!
borderstyle borderstyle = styleraised!
string mask = "###,###,##0.00"
end type

type em_allwd_amt from editmask within w_subset_control_display
string accessiblename = "Allowed Amount"
string accessibledescription = "Allowed Amount"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 786
integer y = 1064
integer width = 722
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
alignment alignment = right!
borderstyle borderstyle = styleraised!
string mask = "###,###,##0.00"
end type

type em_denied_amt from editmask within w_subset_control_display
string accessiblename = "Denied Amount"
string accessibledescription = "Denied Amount"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 27
integer y = 1268
integer width = 722
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
alignment alignment = right!
borderstyle borderstyle = styleraised!
string mask = "###,###,##0.00"
end type

type em_pymt from editmask within w_subset_control_display
string accessiblename = "Payment"
string accessibledescription = "Payment"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 786
integer y = 1268
integer width = 722
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
alignment alignment = right!
borderstyle borderstyle = styleraised!
string mask = "###,###,##0.00"
end type

