$PBExportHeader$w_prov_pat_list.srw
$PBExportComments$Provides Provider and Patient Info (inherited from w_master)
forward
global type w_prov_pat_list from w_master
end type
type st_dw_ops from statictext within w_prov_pat_list
end type
type ddlb_dw_ops from dropdownlistbox within w_prov_pat_list
end type
type cb_close from u_cb within w_prov_pat_list
end type
type st_row_ct from statictext within w_prov_pat_list
end type
type dw_list from u_dw within w_prov_pat_list
end type
end forward

global type w_prov_pat_list from w_master
string accessiblename = "Provider Information List"
string accessibledescription = "Provider Information List"
integer x = 64
integer y = 148
integer width = 2784
integer height = 1632
string title = "Provider Information List"
st_dw_ops st_dw_ops
ddlb_dw_ops ddlb_dw_ops
cb_close cb_close
st_row_ct st_row_ct
dw_list dw_list
end type
global w_prov_pat_list w_prov_pat_list

type variables
// Parm passed to this window
sx_list_parms	istr_parm

// The tempory table service
n_cst_temp_table	invo_temp_table

String		is_selected,	&
		is_dw_control

// Table type for the dictionary table
String		is_tbl_type

sx_decode_structure istr_decode_struct
Constant	String	ics_providers = 'PROVIDERS'
end variables

forward prototypes
public function string wf_get_patient_sql ()
end prototypes

public function string wf_get_patient_sql ();///////////////////////////////////////////////////////////
//	Script:	wf_get_patient_sql
//
//	Arguments:	None
//
//	Returns:		String - The patient SQL
//
//	Description:
//			Get the SQL to join the temp table with the
//		enrollee table.
//
///////////////////////////////////////////////////////////
//
//Archana 4-12-99 Add patient_address_2 in the sql statement.
//	FDG	03/21/01	Stars 4.7.	In the temp table, column 'ID' is
//						now recip_id.
//
///////////////////////////////////////////////////////////

Boolean		lb_xref_join

String		ls_recip_rid,		&
				ls_sql

SetPointer (HourGlass!)

// Determine if the Enrollee table data is a join of
//	recip_id and recip_rid.  If so, there will be 1 or more
//	recip_ids for each recip_rid.

SELECT	CNTL_NO
  INTO	:lb_xref_join
  FROM	SYS_CNTL
 WHERE	CNTL_ID	=	'EN_XREF'
 USING	STARS2CA ;
 
IF	Stars2ca.of_check_status()	<	0		THEN
	MessageBox ('Error', 'Error accessing SYS_CNTL in w_pat_prov_list.wf_get_patient_sql')
	Return ''
END IF

IF	lb_xref_join	=	TRUE		THEN
	//	Include recip_rid in the SQL
	ls_recip_rid	=	', e.recip_rid'
ELSE
	//	Don't include recip_rid in the SQL
	ls_recip_rid	=	''
END IF

// FDG 03/21/01 - Make column 'ID' recip_id
ls_sql	=	'Select Distinct e.recip_id' +	ls_recip_rid		+	&
				', e.patient_name, e.address_line_1, e.address_line_2, e.city, '		+	&
				'e.state, e.county, e.zip, e.ssn, e.sex, '			+	&
				'e.relationship, e.link_primary_insured, '			+	&
				'e.date_birth '												+	&
				'From Enrollee e, ' + istr_parm.tmp_table + ' b '	+	&
				'Where e.recip_id = b.recip_id '
//				'Where e.recip_id = b.id '			// FDG 03/21/01
				
Return	ls_sql


end function

event open;call super::open;////////////////////////////////////////////////////////////////////////
//	Script:	Open
//
//	Description:
//		Load the DDLB and create the temp table service.
//
//	Note:
//		The retrieving of the data is in ue_postopen.
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	01/28/98	FDG	Created
//
//
////////////////////////////////////////////////////////////////////////

String lv_sql, lv_syntax, lv_style, lv_error
int	li_rc

// Load the Windows operations DDLB
This.Event	ue_load_ddlb_dw_ops(ddlb_dw_ops,'S','A')

//	Create the temp table service
invo_temp_table		=	CREATE	n_cst_temp_table
end event

on w_prov_pat_list.create
int iCurrent
call super::create
this.st_dw_ops=create st_dw_ops
this.ddlb_dw_ops=create ddlb_dw_ops
this.cb_close=create cb_close
this.st_row_ct=create st_row_ct
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_dw_ops
this.Control[iCurrent+2]=this.ddlb_dw_ops
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.st_row_ct
this.Control[iCurrent+5]=this.dw_list
end on

on w_prov_pat_list.destroy
call super::destroy
destroy(this.st_dw_ops)
destroy(this.ddlb_dw_ops)
destroy(this.cb_close)
destroy(this.st_row_ct)
destroy(this.dw_list)
end on

event ue_preopen;call super::ue_preopen;////////////////////////////////////////////////////////////////////////
//	Script:	ue_preopen
//
//	Description:
//		Get the parm from the previous window (w_query_engine)
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	01/28/98	FDG	Created
//
//
////////////////////////////////////////////////////////////////////////

istr_parm	=	Message.PowerObjectParm

//	Set Null to the parm to fix a Stars bug.
SetNull(Message.PowerObjectParm)

end event

event ue_postopen;call super::ue_postopen;////////////////////////////////////////////////////////////////////////
//	Script:	ue_postopen
//
//	Description:
//		This event is posted to after the window opens.  This event will
//		format, create, and retrieve the datawindow for either provider
//		or patient data.
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	01/28/98	FDG	Created
// 04/15/99 Archana Fs/Ts2224c
//	03/21/01	FDG	Stars 4.7.	In the temp table, column 'ID' is
//						now prov_id.
//	01/22/07	Katie	SPR 4766 Added code to select NPI into Provider Information List
//						if the NPI_CNTL > 0.
//
////////////////////////////////////////////////////////////////////////

Integer		li_rc,				&
				li_idx

String		ls_window_name,	&
				ls_sql,				&
				ls_style,			&
				ls_syntax,			&
				ls_error,			&
				ls_col_name[]

Long			ll_rowcount

dw_list.Reset()

ls_window_name = Upper ( This.ClassName() )

// The prov_id/recip_id keys to retrieve are stored in the temporary table

IF	Upper (istr_parm.parm_type)	=	ics_providers		THEN
	//	Provider list
	is_tbl_type	=	'PV'
	// FDG 03/21/01 - Change column 'ID' to prov_id
	if (gv_npi_cntl > 0) then 
		ls_sql	=	"Select p.prov_id, p.prov_upin, n.prov_npi, p.prov_name, "		+ &
					"p.prov_spec, p.prov_area, "				+ &
					"p.prov_address1, p.prov_address2, p.prov_city, p.prov_state, "		+ &
					"p.prov_zip, p.prov_county, p.prov_ein "				+ &
					"From " + istr_parm.tmp_table + " b, Providers p left outer join Prov_Npi_xref n on p.prov_id = n.prov_id "	+ &
					"Where p.prov_id = b.prov_id"
	else
		ls_sql	=	"Select p.prov_id, p.prov_upin, p.prov_name, "		+ &
					"p.prov_spec, p.prov_area, "				+ &
					"p.prov_address1, p.prov_address2, p.prov_city, p.prov_state, "		+ &
					"p.prov_zip, p.prov_county, p.prov_ein "				+ &
					"From Providers p, " + istr_parm.tmp_table + " b "	+ &
					"Where p.prov_id = b.prov_id"
	end if 
	This.Title	=	'Provider Information List'
ELSE
	//	Patient (enrollee) list
	is_tbl_type	=	'EN'
	ls_sql	=	This.wf_get_patient_sql()
	This.Title	=	'Patient Information List'
END IF

ls_style		=	"datawindow(units=1) style(type=grid)"
ls_syntax	=	SyntaxFromSQL (Stars2ca, ls_sql, ls_style, ls_error)

IF	ls_error	<>	''		THEN
	MessageBox ('Error', 'Error building provider/patient report ' + &
					'in w_pat_prov_list.ue_postopen.  Error = ' + &
					ls_error + '.  SQL = ' + ls_sql + '.' )
	Close (This)
	Return
END IF

li_rc			=	dw_list.Create(ls_syntax)

IF	li_rc		<	0		THEN
	MessageBox ('Error', 'Error building provider/patient report ' + &
					'in w_pat_prov_list.ue_postopen.  Error = ' + &
					ls_error + '.  SQL = ' + ls_sql + '.' )
	Close (This)
	Return
END IF

li_rc	=	fx_dw_syntax (ls_window_name, dw_list, istr_decode_struct, Stars2ca)
								
If li_rc = -5 Then
	li_idx = ddlb_dw_ops.Finditem('Code/Decode',1)
	ddlb_dw_ops.deleteitem(li_idx)
End If

fx_add_d_head (This.Title, dw_list, ls_col_name[], &
					'50', '65', '125', '2', '350')

dw_list.inv_labels.of_labels2 (is_tbl_type, '95', '40', '50')

// PLB set flag to true, this is a static data window 
//	with a join column names don't have a leading 'C' 
//istr_decode_struct.static_pattern = TRUE   

dw_list.SetTransObject(stars2ca)
ll_rowcount	=	dw_list.Retrieve()

Stars2ca.of_commit()		

st_row_ct.text = string(ll_rowcount)

IF	ll_rowcount	<=	0	THEN
	Messagebox ('NO RECORDS FOUND','No ' + istr_parm.parm_type + &
					' records were found to match the ' + &
					istr_parm.parm_type + ' IDs in the datawindow')
	Close (This)
	Return
END IF


end event

event close;call super::close;////////////////////////////////////////////////////////////////////////
//	Script:	Close
//
//	Description:
//		Destroy the temporary table service previously created.
//
////////////////////////////////////////////////////////////////////////
//	History
//
//	01/28/98	FDG	Created
//
//
////////////////////////////////////////////////////////////////////////

IF	IsValid(invo_temp_table)		THEN
	// Drop the temporary table - It's no longer needed
	invo_temp_table.of_drop_table (istr_parm.tmp_table)
	// Destroy this service
	DESTROY	invo_temp_table
END IF
end event

type st_dw_ops from statictext within w_prov_pat_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 59
integer y = 1324
integer width = 631
integer height = 68
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

type ddlb_dw_ops from dropdownlistbox within w_prov_pat_list
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = comboboxrole!
integer x = 59
integer y = 1400
integer width = 709
integer height = 308
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Katie	04/10/09 GNL.600.5633 Added decode structure to fx_uo_control call.

string lv_control_text

Setpointer(Hourglass!)
lv_control_text = ddlb_dw_ops.text 
is_selected = '1'
is_dw_control = fx_uo_control(iw_uo_win,dw_list,lv_control_text,is_dw_control,st_row_ct, istr_decode_struct)
end event

type cb_close from u_cb within w_prov_pat_list
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2263
integer y = 1380
integer width = 334
integer height = 108
integer taborder = 30
string text = "&Close"
boolean default = true
end type

event clicked;Close (Parent)
end event

type st_row_ct from statictext within w_prov_pat_list
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
integer x = 837
integer y = 1404
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_list from u_dw within w_prov_pat_list
string accessiblename = "List"
string accessibledescription = "List"
integer x = 59
integer y = 32
integer width = 2638
integer height = 1280
integer taborder = 10
string dataobject = "d_prov_from_claim"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;//////////////////////////////////////////////////////////////////////
//	Script: Doubleclicked for dw_list
//////////////////////////////////////////////////////////////////////

Integer		li_pos,				&
				li_rc

String		ls_hold_object,	&
				ls_col

Long			ll_row

SetPointer(HourGlass!)

ls_hold_object = GetObjectAtPointer(dw_list)

IF ls_hold_object	=	''		THEN
	Return
END IF

li_pos = Pos (ls_hold_object,"~t")
ls_col = Left(ls_hold_object,(li_pos - 1))

// See if the column header was double-clicked
IF Right(ls_col,2) = '_t'				&
AND UPPER (ls_col) <> 'HEADER_T'		THEN
	//	The column header was double-clicked
	IF isvalid(iw_uo_win) = FALSE THEN
		IF is_selected <> '1' THEN
			Messagebox('Information','You must select an option from Window Operations')
		ELSE
			ddlb_dw_ops.triggerevent(selectionchanged!)
		END IF
	ELSE
		ddlb_dw_ops.triggerevent(selectionchanged!)  
	END IF     
	li_rc = fx_dw_control(dw_list,ls_hold_object,is_dw_control,iw_uo_win,'',0,istr_decode_struct)
ELSE
	//	The column header was not double-clicked
	IF is_dw_control = 'FILTER' THEN
		ddlb_dw_ops.triggerevent(selectionchanged!)
		ll_row = row 
		li_rc = fx_dw_control(dw_list,ls_hold_object,is_dw_control,iw_uo_win,'cell',ll_row,istr_decode_struct)
	ELSEIF is_dw_control = 'FIND' THEN
		ddlb_dw_ops.triggerevent(selectionchanged!)
		ll_row = row 
		li_rc = fx_dw_control(dw_list,ls_hold_object,is_dw_control,iw_uo_win,'cell',ll_row,istr_decode_struct)
	END IF
END IF
end event

event rbuttondown;Setpointer(Hourglass!)
	
fx_lookup(dw_list,is_tbl_type)
end event

event constructor;call super::constructor;// Use the labels service
This.of_setlabels (TRUE)

// Single-select rows
This.of_SingleSelect (TRUE)
end event

