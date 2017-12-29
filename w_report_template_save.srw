HA$PBExportHeader$w_report_template_save.srw
$PBExportComments$(Inherited from w_master)
forward
global type w_report_template_save from w_master
end type
type dw_report_template_save from u_dw within w_report_template_save
end type
type cb_save from u_cb within w_report_template_save
end type
type cb_cancel from u_cb within w_report_template_save
end type
end forward

global type w_report_template_save from w_master
long backcolor = 67108864
string accessiblename = "Report Template Save"
string accessibledescription = "Report Template Save"
accessiblerole accessiblerole = windowrole!
integer x = 654
integer y = 576
integer width = 2354
integer height = 1356
string title = "Report Template Save"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type integer ue_check_report_template_id ( )
dw_report_template_save dw_report_template_save
cb_save cb_save
cb_cancel cb_cancel
end type
global w_report_template_save w_report_template_save

type variables
string is_report_template_id
string ic_path
end variables

event type integer ue_check_report_template_id();//int ue_check_report_template_id()
//This event is called by the clicked event of cb_save.  Will check 
//the case_link table to see if the report template id has 
//already been used for that user (templates are unique by user_id 
//and template_name). Return -1 if find duplicate else return 0.
///////////////////////////////////////////////////////////////////////////////
// Revision History
//
// JasonS	07/10/02	Track 3177d		Changed query to check for link type 'TMP'
//
///////////////////////////////////////////////////////////////////////////////

u_nvo_count lu_nvo_count
string ls_template_id, ls_sql
long ll_current_row, ll_count

/* ds_count - create datastore (n_ds) to hold the count */
ll_current_row = dw_report_template_save.GetRow()
ls_template_id = &
	dw_report_template_save.GetItemString(ll_current_row,'report_template_id')

//NLG Track #1690  Check for quotation marks in report template id
string ls_single_quote, ls_double_quote
ls_single_quote = "'"; ls_double_quote = '"'
if match(ls_template_id,ls_single_quote) or match(ls_template_id,ls_double_quote) then
	Messagebox("Save Report","Report Template ID cannot contain quotes",StopSign!,Ok!)
	return -1
end if


//ls_sql = "select count(*) from case_link where " +
//link_name = '" + dw_report_template_save.object.report_template_id[1] + 
//"' and " + "link_type = 'RPT' and user_id = '" + gc_user_id 
//+ "'"
// Begin - Track 3177d
//ls_sql = "select count(*) from case_link where link_name = '" &
//	+ Upper( ls_template_id ) + "' and link_type = 'RPT' and " &
//	+ "case_id = '" + Upper( gc_user_id ) + "'" //NLG track #1645 changed 'case_id <> user id' to 'case_id = user id'
ls_sql = "select count(*) from case_link where link_name = '" &
	+ Upper( ls_template_id ) + "' and link_type = 'TMP' and " &
	+ "case_id = '" + Upper( gc_user_id ) + "'" //NLG track #1645 changed 'case_id <> user id' to 'case_id = user id'
// End - Track 3177d


lu_nvo_count = Create u_nvo_count
ll_count = lu_nvo_count.uf_get_count(ls_sql)
Destroy lu_nvo_count

if ll_count > 0 then
	MessageBox('Error',&
		'The report template id is not unique. Please enter another id.',StopSign!,Ok!)
	return -1
end if

return 0

end event

on w_report_template_save.create
int iCurrent
call super::create
this.dw_report_template_save=create dw_report_template_save
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report_template_save
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_report_template_save.destroy
call super::destroy
destroy(this.dw_report_template_save)
destroy(this.cb_save)
destroy(this.cb_cancel)
end on

event ue_postopen;call super::ue_postopen;/////////////////////////////////////////////////////////////////////////////
// Script:		w_report_template_save.ue_postopen
//	
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	
//	Must get messageobjectparm and load into the datawindow.  
//	If the path is Save As (A) then report template id will be loaded 
//	with a new id and the description will be the report title.  
//	If the path is Save (S) then all the fields are loaded with what 
//	is passed in.  Set the title accordingly.  Also if coming from 
//	the Save path, make the report template id not editable.
//////////////////////////////////////////////////////////////////////////////////
//	HISTORY
//
//	???	????????	Created.
//
// FNC 	04/16/98 Track 1082. Change column name for description to correct name.
//
//	FDG	06/05/98	Track 1302. Get the report template key passing 'PDQ_TMP_ID'
//						instead of 'RPTTEMPL'.
//
//	NLG	08/21/98	ts144 Report on enhancements.
//	NLG 	09/02/98	Track #1645.  Save path in instance variable
//////////////////////////////////////////////////////////////////////////////////


string ls_parm, ls_return
long ll_current_row

sx_report_template_save lsx_report_template_save

lsx_report_template_save = message.Powerobjectparm

ic_path = lsx_report_template_save.path	//NLG 9-2-98

ll_current_row = dw_report_template_save.insertrow(0)

dw_report_template_save.SetItem(ll_current_row,'user_id', gc_user_id)

dw_report_template_save.SetItem(ll_current_row,'report_template_type', &
	lsx_report_template_save.report_template_type)
	
dw_report_template_save.SetItem(ll_current_row,'report_template_desc', &
	lsx_report_template_save.report_template_desc)
	
dw_report_template_save.SetItem(ll_current_row,'report_template_addl_type', &
	lsx_report_template_save.report_template_addl_type)		//NLG ts144
	
dw_report_template_save.SetItem(ll_current_row,'report_template_default', &
	lsx_report_template_save.report_template_default)			//NLG ts144
	
if lsx_report_template_save.path = 'A' then
	is_report_template_id = fx_get_next_key_id("PDQ_TMP_ID")			// FDG 06/05/98
	dw_report_template_save.SetItem(ll_current_row,'report_template_id', &
		is_report_template_id)
	this.title = 'Report Template Save As'
	
else
	is_report_template_id = lsx_report_template_save.report_template_id
	dw_report_template_save.SetItem(ll_current_row,'report_template_id', &
		lsx_report_template_save.report_template_name)
	//FNC 04-16-98 
	dw_report_template_save.SetItem(ll_current_row,'report_template_desc', &
		lsx_report_template_save.report_template_desc)
	ls_return = dw_report_template_save.Modify("report_template_id.Protect=1")
	this.title = 'Report Template Save'
end if

end event

type dw_report_template_save from u_dw within w_report_template_save
string accessiblename = "Report Template Save Options"
string accessibledescription = "Report Template Save Options"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 28
integer width = 2304
integer height = 1044
integer taborder = 10
string dataobject = "d_report_template_save"
end type

type cb_save from u_cb within w_report_template_save
string accessiblename = "Save"
string accessibledescription = "Save"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 782
integer y = 1136
integer taborder = 20
string text = "&Save"
boolean default = true
end type

event clicked;//cb_save (command button inherited from u_cb)
//This first checks to make sure the report template id is unique then 
//saves the information entered by the user and closes the window.
//Clicked Event:
//This button checks the id then loads the structure with all the 
//information from the datawindow and closes the window returning 
//the structure.
/////////////////////////////////////////////////////////////////////////
//	History
//
//	???	????????	Created.
//
//	FDG	04/03/98	Track 1031.  Perform an AcceptText before executing
//						ue_check_report_template_id.  Also, report_template_name
//						is set from report_template_id (not user_id).  User_id
//						is already set to the case_id.
//
//	NLG	08/21/98	ts144 Report On Enhancements
// FNC	10/29/98	Track 1754. If Description contains single and double quotes 
//						change the double quotes to single before saving.
//	GaryR	10/25/01	Track 2449d	Using empty string in SQL
/////////////////////////////////////////////////////////////////////////

sx_report_template_save lsx_report_template_save
Long		ll_row
Integer	li_rc
string ls_single_quote, ls_double_quote
n_cst_string	lnvo_cst_string

ls_single_quote = "'"; ls_double_quote = '"'

li_rc	=	dw_report_template_save.AcceptText()

IF	li_rc	<	0		THEN
	Return -1
END IF

if ic_path = 'A' then//NLG 9-2-98 if save as, check id. If save, template id is protected
	if parent.event ue_check_report_template_id() = -1 then
		/* select report template id field */
		return
	end if
end if					//NLG 9-2-98


ll_row = dw_report_template_save.GetRow()

lsx_report_template_save.report_template_name = &
		dw_report_template_save.GetItemString(ll_row,'report_template_id')
	
lsx_report_template_save.report_template_id = is_report_template_id

lsx_report_template_save.report_template_type = &
		dw_report_template_save.GetItemString(ll_row,'report_template_type')

lsx_report_template_save.report_template_desc = &
		dw_report_template_save.GetItemString(ll_row,'report_template_desc')

// FNC 10/29/98 start
if match(lsx_report_template_save.report_template_desc,ls_single_quote) then													
	if match(lsx_report_template_save.report_template_desc,ls_double_quote) then
		li_rc = 	messagebox('QUESTION','Template description contains single ' + &
					'and double quoutes. Double quotes will be changed to single.' + &
					'Do you wish to continue save?',Question!,YesNo!)
	end if			
	if li_rc = 2 then return
	lsx_report_template_save.report_template_desc = &
		lnvo_cst_string.of_globalreplace(lsx_report_template_save.report_template_desc, &
			ls_double_quote,ls_single_quote)
end if
// FNC 10/29/98 End

lsx_report_template_save.report_template_addl_type = &
		dw_report_template_save.GetItemString(ll_row,'report_template_addl_type')	//NLG ts144
		
lsx_report_template_save.report_template_default = &
		UPPER(dw_report_template_save.GetItemString(ll_row,'report_template_default')	)	//NLGl ts144
		
/*if the default template checkbox is checked, determine if any other template for this data source/additional
source exists.  If so, update the existing template, setting its default indicator to a value of spaces. */
string ls_default, ls_user_id,ls_query_type,ls_addl_query_type,ls_temp_id
int li_idx
n_ds lds_update_default_template

ls_query_type = lsx_report_template_save.report_template_type
ls_addl_query_type = lsx_report_template_save.report_template_addl_type
ls_user_id = dw_report_template_save.GetItemString(ll_row,'user_id')
ls_default = dw_report_template_save.GetItemString(ll_row,'report_template_default')

if upper(ls_default) = 'Y' then
	lds_update_default_template = create n_ds
	lds_update_default_template.dataobject = 'd_rpt_temp_update_default'
	li_rc = lds_update_default_template.SetTransObject(stars2ca)
	
	if li_rc < 0 then
			Messagebox('Error','Error in SetTransObject in cb_save of w_report_template_save'+&
							'~r Unable to update default indicator.')
	else
			//	GaryR	10/25/01	Track 2449d
			gnv_sql.of_TrimData( ls_addl_query_type )
			ll_row = lds_update_default_template.retrieve(ls_user_id,ls_query_type,ls_addl_query_type)
			/*If rows returned (should return 1 at most) set default indicator to '  ' 
				unless it's the present query */
			if ll_row > 0 then
				for li_idx = 1 to ll_row
					ls_temp_id = lds_update_default_template.GetItemString(li_idx,'query_id')
					if ls_temp_id <> is_report_template_id then
							lds_update_default_template.SetItem(li_idx,'default_template',' ')
					end if
				Next
				
				/*Update the table*/
				li_rc = lds_update_default_template.EVENT ue_update( TRUE, TRUE )
				If li_rc < 0 then
					Stars2ca.of_rollback()
					MessageBox('ERROR','Update error when resetting default template indicator on pdq control table.')
				Else
					Stars2ca.of_commit()				
				End If
				
			elseif ll_row < 0 then
				Messagebox('ERROR','Retrieve error when updating default indicator.')
			end if
	end if

if IsValid(lds_update_default_template) then destroy(lds_update_default_template)

end if

closewithreturn(parent,lsx_report_template_save)

end event

type cb_cancel from u_cb within w_report_template_save
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1221
integer y = 1136
integer taborder = 30
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;//cb_cancel (command button inherited from u_cb)
//This closes the window without saving any changes.
//Clicked Event:
//Will close the window returning 'N' in the path to inform 
//the event calling in not to save the report template.

sx_report_template_save lsx_report_template_save

lsx_report_template_save.path = 'N'
closewithreturn(parent,lsx_report_template_save)

end event

