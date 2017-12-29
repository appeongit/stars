HA$PBExportHeader$w_query_save.srw
$PBExportComments$Query save and save as window (Inherited from w_master).
forward
global type w_query_save from w_master
end type
type cb_save from u_cb within w_query_save
end type
type cb_cancel from u_cb within w_query_save
end type
type dw_query_save from u_dw within w_query_save
end type
end forward

global type w_query_save from w_master
string accessiblename = "Query Save"
string accessibledescription = "Query Save"
integer x = 901
integer y = 424
integer width = 1915
integer height = 1552
string title = "Query Save"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type integer ue_check_query_id ( string as_queryid )
event type integer ue_verify_case_id ( string as_case_id )
cb_save cb_save
cb_cancel cb_cancel
dw_query_save dw_query_save
end type
global w_query_save w_query_save

type variables
Protected:

Character                      ic_Path
String                            is_query_id
nvo_subset_functions  invo_subset_functions
sx_query_save isx_query_save
end variables

event type integer ue_check_query_id(string as_queryid);/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_save				ue_check_query_id
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This event is called by the itemchanged event of dw_query_save when a query_id is 
// entered.  Will check the case_link table to see if the query id has already been used. 
// Return -1 if find duplicate else return 0.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument		Datatype	Description
//	---------	--------		--------	-----------
//	Value			as_QueryId	String	The keyed query id.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer		0				Success, no duplicate query id.
//					-1				Duplicate query id.
//					-2				No rows in query save dw.
//					-3				Cannot validate Query id.
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date			Description
// ------	----			-----------
//	J.Mattis	01/14/98		Created.
//
//	FDG		04/28/98		Track 1125.  Rewrite the script to include:
//								1. Use the count service.
//								2. Compare against link_name instead of link_key.
//								3. Include case_id data in the select.
//
//	FDG		05/06/98		Track 1204. Query ID must be entered.
// FNC		10/29/98		Track 1754. Query ID may not contain a quote.
//	FDG		04/16/01		Stars 4.7.	Account for empty string or space in case_spl, case_ver.
//	GaryR		02/27/03		Track 3455d	Check for duplicate case link entry
//	GaryR		03/25/03		Track 3273d	Do not check dups when Save
//	GaryR		05/04/04		Track 3544d	Redesign report save/view logic to improve performance
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer	li_rc 
String	ls_sql,			&
			ls_case_id,		&
			ls_case_spl,	&
			ls_query_id,	&
			ls_case_ver,	&
			ls_single_quote, &
			ls_double_quote			
Long		ll_count,		&
			ll_row
			
ls_single_quote = "'"; ls_double_quote = '"'

IF dw_query_save.RowCount() < 1 Then 
	RETURN -2
End If

ll_row	=	dw_query_save.GetRow()

ls_query_id	=	dw_query_save.object.query_id [ll_row]
ls_case_id	=	Left (dw_query_save.object.case_id [ll_row], 10)
ls_case_spl	=	Mid (dw_query_save.object.case_id [ll_row], 11, 2)
ls_case_ver	=	Mid (dw_query_save.object.case_id [ll_row], 13, 2)

// FDG 05/06/98	begin
IF	IsNull (as_queryid)			&
OR	Trim (as_queryid)	<	' '	THEN
	MessageBox ("Error", "Name is required.  It will be reset to its original value.", StopSign!)
	dw_query_save.SetColumn( "query_id" )
	dw_query_save.SetText (is_query_id)
	Return  -1
	// FDG 05/06/98	end
else
	// FNC 10/29/98 Start
	if match(as_queryid,ls_single_quote) or match(as_queryid,ls_double_quote) then
		Messagebox("Error","Name cannot contain quotes",StopSign!,Ok!)
		return -1
	end if
	// FNC 10/29/98 End
END IF

IF isx_query_save.path = 'S' THEN Return li_rc

// FDG 04/16/01 - Make sure case_spl & case_ver is properly trimmed.
li_rc	=	gnv_sql.of_TrimData (ls_case_spl)
li_rc	=	gnv_sql.of_TrimData (ls_case_ver)
// FDG 04/16/01 - end

This.of_set_nvo_count (TRUE)			// FDG 04/28/98

ls_sql = "select count(*) from case_link where link_name = " + &
 			"'" + Upper( as_QueryId ) + "'" + &  
			" and link_type = '" + isx_query_save.link_type + "'" + &
			" and case_id = '" + Upper( ls_case_id ) + "'"	+	&
			" and case_spl = '" + Upper( ls_case_spl ) + "'" + &
			" and case_ver = '" + Upper( ls_case_ver ) + "'"

ll_count	=	inv_count.uf_get_count(ls_sql)			// FDG 04/28/98

IF ll_count > 0 THEN
	MessageBox("Error","Name is not unique.  Please enter another name.",StopSign!)
	li_rc =  -1
END IF

RETURN li_rc

end event

event type integer ue_verify_case_id(string as_case_id);/////////////////////////////////////////////////////////////////////////////////
// 09/01/98		FNC		Track 1640. Validate case id.
//	08-13-99	NLG	ts2363c. Replace u_nvo_case_functions with n_cst_case
/////////////////////////////////////////////////////////////////////////////////

n_cst_case	lnv_case
int li_return
string ls_case_id,ls_case_spl,ls_case_ver
string ls_msg

ls_case_id = left(as_case_id,10)
ls_case_spl = mid(as_case_id,11,2)
ls_case_ver = mid(as_case_id,13,2)

lnv_case = Create n_cst_case
li_return = lnv_case.uf_valid_case(ls_case_id,ls_case_spl,ls_case_ver)

Choose Case li_return
	case 0
		ls_msg =	lnv_case.uf_edit_case_security(ls_case_id,ls_case_spl,ls_case_ver)
		IF LEN(ls_msg) > 0 THEN
			messagebox("SECURITY ERROR",ls_msg)
			li_return = -1
		END IF
	case -1
		messagebox('ERROR','Case not found. Select another case')
	case -2
		messagebox('ERROR','Case has been deleted. Select another case')
	case -3
		messagebox('ERROR','Case has been closed. Select another case')
	case -4
		messagebox('ERROR','Error verifying case id.')
End Choose

if IsValid(lnv_case) then destroy lnv_case

return li_return

end event

on w_query_save.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.dw_query_save=create dw_query_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.dw_query_save
end on

on w_query_save.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.dw_query_save)
end on

event ue_postopen;call super::ue_postopen;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	w_query_save				ue_PostOpen
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Must get messageobjectparm and load into the datawindow.  If the path is Save As (A)
// then common_flg is unchecked, the query_id is a new id, query_type is what's passed in, 
// the query_desc is blank and the link is None.  If the path is Save (S) or Link (L) then 
// all fields get what is passed in.  Set the title accordingly.  Also if coming from the 
// Save path, make the query id not editable and if from Link path make query_id and 
// query_desc not editable.  Lastly, must create subset functions user object to use to
// check security of case when case id is entered.
//
//
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
// ------	----			-----------
//	J.Mattis	01/14/98		Created.
//	J.Mattis	02/20/98		Added path assignment.
//	FDG		04/10/98		Track 1044.  fx_get_next_key_id sets Microhelp that
//								doesn't need to be displayed.
//	FDG		04/30/98		Track 1095.  Remove references to common_flg.  It
//								will not be used.
//	FDG		06/05/98		Track 1302.  Pass 'PDQ_TMP_ID' instead of 'PDQUERY'
//								when determining the next query id.
// FNC		07/30/98		Track 1538. Protect the case id and link radio button
//								when come in as save.
// Lahu S	1/21/02		Track - 2552d Set Query description field
//	GaryR		05/13/03		Track 3562d	Change colors on protected fields
//	GaryR		02/26/04		Track 3885d	Set Case Id field background color 
//								to lookup in Report Save mode
// JasonS	10/06/04		Track 5651c - allow reports to be saved to case none
//	GaryR		10/21/04		Track 4089d	Add third tier to PDR report selection
//	GaryR		01/04/05		Track 5651c	Trim active case
/////////////////////////////////////////////////////////////////////////////
String ls_mod_string


SetPointer(HourGlass!)


invo_subset_functions = create NVO_Subset_Functions
isx_query_save = message.Powerobjectparm

// Begin - Track 2946d
if isx_query_save.path = 'R' then
	dw_query_save.dataobject = 'd_report_save'
else
	dw_query_save.dataobject = 'd_query_save'
end if
// End - Track 2946d

IF dw_query_save.insertrow(0) > 0 THEN
	IF isx_query_save.link_type = "PDR" THEN
		dw_query_save.object.query_type_t.visible = 0
		dw_query_save.object.query_type.visible = 0
	END IF
	
	dw_query_save.object.user_id[1] = gc_user_id
	dw_query_save.object.query_type[1] = isx_query_save.query_type
	// Lahu S	1/21/02	Track - 2552d	begin
	//Set Query description field	
	dw_query_save.object.query_desc[1] = isx_query_save.query_desc
	// Lahu S	1/21/02		End	
  	ic_path = isx_query_save.path
	
	if isx_query_save.path = 'A' then
		is_query_id = fx_get_next_key_id("PDQ_TMP_ID")		// FDG 06/05/98
		w_main.SetMicroHelp('Ready')								// FDG 04/10/98
		dw_query_save.object.query_id[1] = is_query_id
		this.title = this.title + ' As'
	else
		is_query_id = isx_query_save.query_id
		//dw_query_save.object.common_flg[1] = String(isx_query_save.common_flg)	// FDG 04/30/98
		dw_query_save.object.query_id[1] = isx_query_save.query_name
		dw_query_save.object.query_id.protect = 1
		dw_query_save.object.query_id.color = stars_colors.protected_text
		dw_query_save.object.query_id.Background.color = stars_colors.protected_back
		
		IF Not(IsNull(isx_query_save.link)) AND Trim(isx_query_save.link) <> ''  THEN
			dw_query_save.object.rb_link[1] = UPPER(Trim(isx_query_save.link))
			IF dw_query_save.object.rb_link[1] = 'CASE' THEN
				dw_query_save.object.case_id[1] = isx_query_save.case_id
			END IF
		END IF
		dw_query_save.object.query_desc[1] = isx_query_save.query_desc
		dw_query_save.object.case_id.protect = 1			// FNC 07/30/98
		dw_query_save.object.case_id.color = stars_colors.protected_text
		dw_query_save.object.case_id.Background.color = stars_colors.protected_back
		if isx_query_save.path <> 'R' then
			dw_query_save.object.rb_link.protect = 1			// FNC 07/30/98
			dw_query_save.object.rb_link.color = stars_colors.protected_text
			dw_query_save.object.rb_link.Background.color = stars_colors.protected_back
		end if
	end if
	
	if isx_query_save.path = 'L' then
		dw_query_save.object.query_desc.protect = 1
		dw_query_save.object.query_desc.color = stars_colors.protected_text
		dw_query_save.object.query_desc.Background.color = stars_colors.protected_back
		dw_query_save.object.rb_link[1] = 'CASE'
		dw_query_save.object.case_id[1] = gv_active_case
		this.title = 'Query Link'
		/* select case_id field */
		dw_query_save.SetColumn("case_id")
		dw_query_save.SetFocus()
	end if
	
	// begin track 2946d
	if isx_query_save.path = 'R' then
		this.title = 'User Report Save'
		dw_query_save.object.query_id.protect = 0
		dw_query_save.object.query_id.color = stars_colors.input_text
		dw_query_save.object.query_id.Background.color = stars_colors.input_back
		dw_query_save.object.query_desc.protect = 0
		dw_query_save.object.query_desc.color = stars_colors.input_text
		dw_query_save.object.query_desc.Background.color = stars_colors.input_back
		dw_query_save.object.case_id.protect = 0
		dw_query_save.object.case_id.color = stars_colors.lookup_text
		dw_query_save.object.case_id.Background.color = stars_colors.lookup_back
		If trim(gv_active_case) = "" or Trim( gv_active_case ) = "NONE" then
			dw_query_save.object.case_id[1] = "NONE"
			dw_query_save.object.rb_link[1] = "NONE"
		else
			dw_query_save.object.case_id[1] = gv_active_case
			dw_query_save.object.rb_link[1] = 'CASE'
		end if
	end if
	// end track 2946d
END IF
end event

event close;call super::close;// Must destroy subset functions user object when close the window.
If IsValid(invo_subset_functions) Then
	Destroy invo_subset_functions
End If


end event

type cb_save from u_cb within w_query_save
string accessiblename = "Save"
string accessibledescription = "Save"
integer x = 1211
integer y = 1344
integer taborder = 30
boolean bringtotop = true
string text = "&Save"
boolean default = true
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	cb_save						clicked
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// This button loads the structure with all the information from the datawindow and 
// closes the window returning the structure.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author	Date		Description
// ------	----		-----------
//	J.Mattis	01/14/98	Created.
//	J.Mattis	02/20/98	Added path assignment.
//	J.Mattis	02/24/98	Added default query description.
//	FDG		04/02/98	Track 968.  If an error occured, don't close
//							the window.
//	FDG		04/30/98	Track 1095.  Remove references to common_flg.  It
//							is no longer being used.
//	FDG		05/13/98	Track 1231.  Remove the leading space in the default
//							description.
// FNC		09/01/98	Track 1640. Verify case id before returning to w_query_engine.
//							If gv_active_case was blank then case_id defaulted to a blank.
//							If user tries to save without entering a valid case it will
//							cause problems.
// FNC		10/29/98	Track 1754. If Description contains single and double quotes 
//							change the double quotes to single before saving.
//	GaryR		02/27/03	Track 3455d	Check for duplicate case link entry
//	GaryR		05/04/04	Track 3544d	Redesign report save/view logic to improve performance
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

integer li_return
string ls_single_quote, ls_double_quote
n_cst_string	lnvo_cst_string

ls_single_quote = "'"; ls_double_quote = '"'

sx_query_save lsx_query_save


IF dw_query_save.RowCount() > 0 AND dw_query_save.AcceptText() = 1 THEN	
	lsx_query_save.path 	= ic_path
	//lsx_query_save.common_flg 	= dw_query_save.object.common_flg[1]		// FDG 04/30/98
	lsx_query_save.query_name	= Trim( dw_query_save.object.query_id[1] )
	lsx_query_save.query_id		= is_query_id
	lsx_query_save.query_type 	= dw_query_save.object.query_type[1]
	
	IF Parent.Event ue_check_query_id( lsx_query_save.query_name ) <	0 THEN Return
	
	//check for valid desc.	JTM 2/24/98
	IF IsNull(dw_query_save.object.query_desc[1]) OR dw_query_save.object.query_desc[1] = '' THEN
		// assign default query description
		lsx_query_save.query_desc 	= Trim( dw_query_save.object.query_id[1] ) + " created on " + &
			String(gnv_App.of_Get_Server_Date_Time(),"m-d-yy h:mm am/pm;'none'") + "."
	ELSE
		// FNC 10/29/98 start
		lsx_query_save.query_desc 	= dw_query_save.object.query_desc[1]
		if match(lsx_query_save.query_desc,ls_single_quote) then													
			if match(lsx_query_save.query_desc,ls_double_quote) then
				li_return = 	messagebox('QUESTION','Query description contains single ' + &
							'and double quoutes. Double quotes will be changed to single.' + &
							'Do you wish to continue save?',Question!,YesNo!)
			end if			
			if li_return = 2 then return
			lsx_query_save.query_desc = &
				lnvo_cst_string.of_globalreplace(lsx_query_save.query_desc,ls_double_quote,ls_single_quote)
		end if
		// FNC 10/29/98 End
	END IF					// JTM 2/24/98 end
	
	lsx_query_save.link 			= dw_query_save.object.rb_link[1]
	
	li_return = parent.event ue_verify_case_id(dw_query_save.object.case_id[1])	// FNC 09/01/98 Start
	if li_return <> 0  then	
		return
	else
		lsx_query_save.case_id 		= dw_query_save.object.case_id[1]
	end if																		// FNC 09/01/98 End
ELSE
	Return
END IF

closewithreturn(parent,lsx_query_save)
end event

type cb_cancel from u_cb within w_query_save
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 1577
integer y = 1344
integer taborder = 40
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	cb_cancel					clicked
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// Will close the window returning 'N' in the path to inform the event calling in not to 
// save the query.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				Continue
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			01/14/98		Created.
//
//	FDG				04/02/98		Track 968.  Don't perform any closequery processing.
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
sx_query_save lsx_query_save
lsx_query_save.path = 'N'
ib_disableclosequery	=	TRUE				// FDG 04/02/98

closewithreturn(parent,lsx_query_save)

end event

type dw_query_save from u_dw within w_query_save
string accessiblename = "Query Save"
string accessibledescription = "Query Save"
integer x = 18
integer y = 32
integer width = 1861
integer height = 1272
integer taborder = 10
string dataobject = "d_query_save"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;// prevent update from being attempted
This.of_SetUpdateable (FALSE)
end event

event itemchanged;/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function				
// ------						--------------				
//	dw_query_save				itemchanged
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
// If the common flag is checked must grey out the Link group box and set the case to 
// None (not able to link common queries to cases).  If query id is changed must check 
// to see if it is a dup.  If the case link is selected must populate the case_id with 
// the active case.  If a case_id is entered must check to see if the case is valid 
// and secure.  If it is secure must make  sure the case department matches the users 
// department. If  they don't match, error.  
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			row		Long		
//					dwo		dwobject
//					data		String
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			0				(Default) Accept the data value
//					1				Reject the data value and don't allow focus to change
//					2				Reject the data value but allow the focus to change
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		01/14/98		Created.
//	FDG			04/30/98		Track 1095.  Remove references to common_flg.  It
//									is no longer being used.
// FNC			07/21/98		Track 1318. Verify that the case exists and is not
//									closed or deleted.
// FNC			09/01/98		Track 1640. Consolidate case id edit code into a 
//									window function.
// FNC			04/18/00		Track 2095. Testing this track revealed that 
//									u_nvo_case_functions is obsolete. Moving to the 
//									stars 4.5 obsolete pbl.
// JasonS		06/13/02		Track 2946d  Report save window change
//	GaryR			02/27/03		Track 3455d	Check for duplicate case link entry
// JasonS		09/10/03		Track 5651c Allow report to be saved to NONE (remove 2496d)
//	GaryR			01/04/05		Track 5651c	Trim active case
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

//u_nvo_case_functions luo_case_functions
string ls_case_id

choose case dwo.Name
	case 'rb_link'
		if data = "CASE" then
			IF IsNull( gv_active_case) OR Trim( gv_active_case ) = "NONE" THEN
				dw_query_save.object.case_id[1] = ""
			ELSE
				dw_query_save.object.case_id[1] = gv_active_case
			END IF
		elseif data = "NONE" then								//NLG 4-21-98
			dw_query_save.object.case_id[1] = 'NONE'		//NLG 4-21-98
		end if
		
	case 'case_id'
		Integer li_Return
		if Trim(data) <> '' then
			// FNC 07/21/98, 09/01/98 Start
			ls_case_id = Trim(data)
			
			if trim(ls_case_id) <> 'NONE' then
				li_return = parent.event ue_verify_case_id(ls_case_id)
				if li_return <> 0 then return 1
			end if
		end if	
		
end choose

RETURN 0
end event

event itemerror;// Override to not display the generic PB Item error messagebox.  (Track 968)

Return 1
end event

event ue_lookup;call super::ue_lookup;/////////////////////////////////////////////////////////////////////////////
// Object							Event/Function		Access	
// ------							--------------		------	
//	dw_query_save					rbuttondown			Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Lookup the case id.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
//	Value			xpos		Integer
//	Value			ypos		Integer
//	Value			row		Long	
//	Value			dwo		dwObject
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Long			    1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author		Date			Description
// ------		----			-----------
//	J.Mattis		02/26/98		Created.
//
//	FDG			05/01/00		Remove the ability to right-click if the column
//									is protected.
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

// make sure only the case id provides lookup
IF Lower(as_col) = 'case_id' THEN
	IF	this.object.case_id.protect	=	'0'		THEN
		gv_from = 'AC'	/* 'message' w_case_list to enable the use commandbutton, 
							   and retrieve the case list. */
		Open(w_case_list_response)
		This.object.case_id[1] = gv_active_case	// get 'message' case id
	END IF
END IF
end event

