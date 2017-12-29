HA$PBExportHeader$w_case_export.srw
forward
global type w_case_export from w_master
end type
type rte_print from u_rte within w_case_export
end type
type cb_oper from u_cb within w_case_export
end type
type cb_close from u_cb within w_case_export
end type
type tab_print from tab within w_case_export
end type
type tabpage_case from userobject within tab_print
end type
type cbx_folder from u_cbx within tabpage_case
end type
type cbx_case_log from u_cbx within tabpage_case
end type
type cbx_pimr from u_cbx within tabpage_case
end type
type cbx_financial from u_cbx within tabpage_case
end type
type cbx_status from u_cbx within tabpage_case
end type
type cbx_general from u_cbx within tabpage_case
end type
type dw_case_folder from u_dw within tabpage_case
end type
type gb_case from groupbox within tabpage_case
end type
type tabpage_case from userobject within tab_print
cbx_folder cbx_folder
cbx_case_log cbx_case_log
cbx_pimr cbx_pimr
cbx_financial cbx_financial
cbx_status cbx_status
cbx_general cbx_general
dw_case_folder dw_case_folder
gb_case gb_case
end type
type tabpage_tracks from userobject within tab_print
end type
type dw_tracks from u_dw within tabpage_tracks
end type
type cbx_track_log from u_cbx within tabpage_tracks
end type
type cbx_track_financial from u_cbx within tabpage_tracks
end type
type cbx_track_status from u_cbx within tabpage_tracks
end type
type cbx_track_general from u_cbx within tabpage_tracks
end type
type gb_tracks from groupbox within tabpage_tracks
end type
type tabpage_tracks from userobject within tab_print
dw_tracks dw_tracks
cbx_track_log cbx_track_log
cbx_track_financial cbx_track_financial
cbx_track_status cbx_track_status
cbx_track_general cbx_track_general
gb_tracks gb_tracks
end type
type tabpage_targets from userobject within tab_print
end type
type dw_targets from u_dw within tabpage_targets
end type
type tabpage_targets from userobject within tab_print
dw_targets dw_targets
end type
type tabpage_leads from userobject within tab_print
end type
type dw_leads from u_dw within tabpage_leads
end type
type tabpage_leads from userobject within tab_print
dw_leads dw_leads
end type
type tabpage_notes from userobject within tab_print
end type
type dw_notes from u_dw within tabpage_notes
end type
type tabpage_notes from userobject within tab_print
dw_notes dw_notes
end type
type tabpage_attachments from userobject within tab_print
end type
type dw_attachments from u_dw within tabpage_attachments
end type
type tabpage_attachments from userobject within tab_print
dw_attachments dw_attachments
end type
type tab_print from tab within w_case_export
tabpage_case tabpage_case
tabpage_tracks tabpage_tracks
tabpage_targets tabpage_targets
tabpage_leads tabpage_leads
tabpage_notes tabpage_notes
tabpage_attachments tabpage_attachments
end type
end forward

global type w_case_export from w_master
long backcolor = 67108864
string accessiblename = "Case Print - "
string accessibledescription = "Case Print - "
accessiblerole accessiblerole = windowrole!
integer width = 2350
integer height = 1904
string title = "Case Print - "
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
rte_print rte_print
cb_oper cb_oper
cb_close cb_close
tab_print tab_print
end type
global w_case_export w_case_export

type variables
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes

String	is_case_id, is_case_spl, is_case_ver
Boolean	ib_export_mode
end variables

forward prototypes
public function integer wf_export_attachments (string as_dir)
public function integer wf_export_notes (string as_dir)
end prototypes

public function integer wf_export_attachments (string as_dir);//	This method will export all selected Case Attachments
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes

Integer	li_row, li_ctr
String	ls_filename, ls_fileid, ls_path
n_cst_attachments	lnv_attach

li_row = tab_print.tabpage_attachments.dw_attachments.GetSelectedRow( 0 )
DO WHILE li_row > 0
	ls_fileid = tab_print.tabpage_attachments.dw_attachments.GetItemString( li_row, "file_cntl_file_id" )

	// Get the filename
	ls_filename = lnv_attach.of_get_filename( ls_fileid )
	IF ls_filename <> "" THEN
		ls_path = as_dir + "\" + ls_filename
	
		// Write the file
		IF lnv_attach.of_writefile( ls_fileid, ls_path ) = 1 THEN li_ctr ++
	END IF
	
	li_row = tab_print.tabpage_attachments.dw_attachments.GetSelectedRow( li_row )
LOOP

Return li_ctr
end function

public function integer wf_export_notes (string as_dir);//	This method will export all selected Case Notes
//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes
//	12/02/08	GaryR	SPR 5592	Upgrade PDF Printer for Vista

String	ls_noteid, ls_userid, ls_deptid, ls_sub_type, ls_rte_ind, &
			ls_note_desc, ls_rte_string, ls_desc, ls_path
Integer	li_row, li_ctr
DateTime	ldt_note
OLEObject	lole_pdf
n_cst_export	lnv_export

//	Initialize and connect to 
//	the PDF ActiveX interface
IF lnv_export.Event ue_init_pdf( lole_pdf ) < 0 THEN Return -1

// Set file options for the current print job
lole_pdf.FileNameOptions = lnv_export.NoPrompt + lnv_export.UseFileName

//	Set the PDF converter
//	as the current printer
lnv_export.of_SetPDFPrinter()

//	Loop through all selected notes
li_row = tab_print.tabpage_notes.dw_notes.GetSelectedRow( 0 )
DO WHILE li_row > 0
	//	Get the control info
	ls_noteid = tab_print.tabpage_notes.dw_notes.GetItemString( li_row, "note_id" )
	ls_userid = tab_print.tabpage_notes.dw_notes.GetItemString( li_row, "user_id" )
	ls_deptid = tab_print.tabpage_notes.dw_notes.GetItemString( li_row, "dept_id" )
	ls_sub_type = tab_print.tabpage_notes.dw_notes.GetItemString( li_row, "note_sub_type" )
	ldt_note = tab_print.tabpage_notes.dw_notes.GetItemDateTime( li_row, "note_datetime" )
	ls_note_desc = tab_print.tabpage_notes.dw_notes.GetItemString( li_row, "note_desc" )
	ls_rte_ind = tab_print.tabpage_notes.dw_notes.GetItemString( li_row, "rte_ind" )
	
	//	Create header
	ls_rte_string = "~r~nUser ID: ~t" + ls_userid + &
		"~r~nDept ID: ~t" + ls_deptid + "~r~nNote ID: ~t" + ls_noteid + &
		"~r~nSub Type:~t" + ls_sub_type + "~r~nDescription:~t" + ls_note_desc + &
		"~r~nNote Datetime: ~t" + String( ldt_note, "mm/dd/yyyy hh:mm:ss" ) + "~r~n~r~n"
	rte_print.ReplaceText( ls_rte_string )
	
	//	Get note text
	ls_desc	=	gnv_sql.of_get_note_text( ls_noteid, "CA", is_case_id + is_case_spl + is_case_ver )
	
	//	If rte indicator is set, it's rich text
	IF ls_rte_ind = 'Y' THEN
		rte_print.PasteRTF( ls_desc, Detail! )
	ELSE
		rte_print.ReplaceText( ls_desc )
	END IF
	
	//	Build the full path
	ls_path = as_dir + "\Note ID-" + ls_noteid + ".PDF"
	lole_pdf.DefaultFileName = ls_path
	
	//	Send to pdf printer
	lnv_export.of_activatePrinter( lole_pdf )
	rte_print.Print( 1, "", FALSE, FALSE )
	rte_print.of_clear( )
	
	li_ctr ++	
	li_row = tab_print.tabpage_notes.dw_notes.GetSelectedRow( li_row )
LOOP

//	Reset the default printer
lnv_export.of_ResetDefaultPrinter()

// Reset file options
lole_pdf.FileNameOptions = 0
Destroy lole_pdf

Return li_ctr
end function

on w_case_export.create
int iCurrent
call super::create
this.rte_print=create rte_print
this.cb_oper=create cb_oper
this.cb_close=create cb_close
this.tab_print=create tab_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rte_print
this.Control[iCurrent+2]=this.cb_oper
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.tab_print
end on

on w_case_export.destroy
call super::destroy
destroy(this.rte_print)
destroy(this.cb_oper)
destroy(this.cb_close)
destroy(this.tab_print)
end on

event open;call super::open;//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS

String	ls_sql, ls_cat
Long		ll_row, ll_rowcount
Datetime	ldt_from, ldt_thru
n_cst_case lnv_case

// Validate active case
IF IsNull( gv_active_case ) OR Trim( gv_active_case ) = "" THEN
	MessageBox( "ERROR", "Active Case not set", StopSign! )
	cb_close.PostEvent( Clicked! )
	Return
END IF

is_case_id = Trim( Left( gv_active_case, 10 ) )
is_case_spl = Mid( gv_active_case, 11, 2 )
is_case_ver = Mid( gv_active_case, 13, 2 )

gnv_sql.of_TrimData( is_case_spl )
gnv_sql.of_TrimData( is_case_ver )

IF ib_export_mode THEN
	This.title = "Notes/Attachments Export - Case: " + gv_active_case
	cb_oper.Text = "&Export"
	tab_print.Post SelectTab( 5 )
ELSE
	This.title = "Case Print - " + gv_active_case
	cb_oper.Text = "&Print"
	tab_print.tabpage_attachments.visible = FALSE
END IF

//-------- This logic was used to test Case printing/export in STARS 5.4.0 ------
//// Retrieve Case Folder
//tab_print.tabpage_case.dw_case_folder.SetTransObject( Stars2ca )
//tab_print.tabpage_case.dw_case_folder.Retrieve( is_case_id, is_case_spl, is_case_ver )
//tab_print.tabpage_case.dw_case_folder.Object.Datawindow.ReadOnly = "Yes"
//tab_print.tabpage_case.dw_case_folder.Object.case_link_link_desc.Edit.DisplayOnly = "Yes"
//tab_print.tabpage_case.dw_case_folder.Object.case_link_link_desc.Border = "0"
//tab_print.tabpage_case.dw_case_folder.Object.case_link_link_desc.Background.Color = "536870912"
//tab_print.tabpage_case.dw_case_folder.Object.DataWindow.Color= "16777215"
//tab_print.tabpage_case.dw_case_folder.SelectRow( 0, TRUE )
//
//// Retrieve Tracks
//tab_print.tabpage_tracks.dw_tracks.SetTransObject( Stars2ca )
//ls_sql = tab_print.tabpage_tracks.dw_tracks.GetSQLSelect()
//ls_sql += " WHERE CASE_CNTL.CASE_ID = TRACK.CASE_ID " + &
//			"AND CASE_CNTL.CASE_SPL = TRACK.CASE_SPL " + &
//			"AND CASE_CNTL.CASE_VER = TRACK.CASE_VER " + &
//			"AND TRACK.CASE_ID = '" + is_case_id + "' " + &
//			"AND TRACK.CASE_SPL = '" + is_case_spl + "' " + &
//			"AND TRACK.CASE_VER = '" + is_case_ver + "' " + &
//			"ORDER BY TRACK.TRK_TYPE, TRACK.TRK_KEY"
//tab_print.tabpage_tracks.dw_tracks.SetSQLSelect( ls_sql )
//ll_rowcount = tab_print.tabpage_tracks.dw_tracks.Retrieve()
//
//// Case security and header formatting
//lnv_case = Create n_cst_case
//FOR  ll_row  =  1  TO  ll_rowcount
//	ls_cat  = tab_print.tabpage_tracks.dw_tracks.object.case_cat [ll_row]	
//	ls_sql  =  lnv_case.uf_edit_case_security( ls_cat )
//	IF  Len( ls_sql )  >  0   THEN
//		tab_print.tabpage_tracks.dw_tracks.RowsDiscard (ll_row, ll_row, Primary!)
//		ll_row -- 
//		ll_rowcount --
//	END IF
//NEXT
//
//lnv_case.uf_format_custom_headings( tab_print.tabpage_tracks.dw_tracks )
//Destroy lnv_case
//
//tab_print.tabpage_tracks.dw_tracks.Object.case_id.Visible = "0"
//tab_print.tabpage_tracks.dw_tracks.Object.case_spl.Visible = "0"
//tab_print.tabpage_tracks.dw_tracks.Object.case_ver.Visible = "0"
//tab_print.tabpage_tracks.dw_tracks.Object.DataWindow.Summary.Height = '0'
//tab_print.tabpage_tracks.dw_tracks.Object.DataWindow.Footer.Height = '0'
//tab_print.tabpage_tracks.dw_tracks.SelectRow( 0, TRUE )
//
//// Retireve Targets
//tab_print.tabpage_targets.dw_targets.SetTransObject( Stars2ca )
//tab_print.tabpage_targets.dw_targets.Retrieve( is_case_id, is_case_spl, is_case_ver )
//tab_print.tabpage_targets.dw_targets.SelectRow ( 0, TRUE )
//
//// Retrieve Leads
//ldt_thru = DateTime( Today(), Now() )
//tab_print.tabpage_leads.dw_leads.SetTransObject( Stars2ca )
//tab_print.tabpage_leads.dw_leads.Retrieve( is_case_id, is_case_spl, is_case_ver, &
//						"%", "%", "%",ldt_from,ldt_thru, "%" )
//tab_print.tabpage_leads.dw_leads.Object.case_id.Visible = "0"
//tab_print.tabpage_leads.dw_leads.Object.case_spl.Visible = "0"
//tab_print.tabpage_leads.dw_leads.Object.case_ver.Visible = "0"
//tab_print.tabpage_leads.dw_leads.SelectRow ( 0, TRUE )

// Retrieve Notes
tab_print.tabpage_notes.dw_notes.SetTransObject( Stars2ca )
ll_row = tab_print.tabpage_notes.dw_notes.Retrieve( is_case_id + is_case_spl + is_case_ver )
tab_print.tabpage_notes.dw_notes.SelectRow ( 0, TRUE )

// Retrieve Attachments
IF ib_export_mode THEN
	tab_print.tabpage_attachments.dw_attachments.SetTransObject( Stars2ca )
	ll_row += tab_print.tabpage_attachments.dw_attachments.Retrieve( is_case_id, is_case_spl, is_case_ver )
	tab_print.tabpage_attachments.dw_attachments.SelectRow ( 0, TRUE )
END IF

IF ll_row < 1 THEN
	MessageBox( "Export", "There are no available links to export for this Case.", Exclamation! )
	This.visible = FALSE
	cb_close.PostEvent( Clicked! )
END IF
end event

event ue_preopen;call super::ue_preopen;//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes

ib_export_mode = Message.StringParm = "E"
SetNull( Message.StringParm )
end event

type rte_print from u_rte within w_case_export
boolean visible = false
string accessiblename = "Print"
string accessibledescription = "Print"
long backcolor = 1073741824
accessiblerole accessiblerole = textrole!
integer x = 37
integer y = 1696
integer width = 146
integer height = 96
integer taborder = 40
boolean bringtotop = true
long init_backcolor = 1090519039
boolean init_wordwrap = true
long init_leftmargin = 1000
long init_topmargin = 1000
long init_rightmargin = 1000
long init_bottommargin = 1000
end type

type cb_oper from u_cb within w_case_export
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1646
integer y = 1696
integer taborder = 30
string text = "&Print"
boolean cancel = true
end type

event clicked;call super::clicked;//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes

Integer	li_ctr, li_rtn
String	ls_filename, ls_dir, ls_filepath, ls_fileid

IF fx_disclaimer() <> 1 THEN Return

// Get the directory
li_rtn = GetFolder( "Export Case links to...", ls_dir )
IF li_rtn <> 1 THEN Return

//Create the Case Folder
IF Right( ls_dir, 1 ) <> "\" THEN ls_dir += "\"
ls_dir += "Case " + is_case_id + is_case_spl + is_case_ver

// Check duplicate folder
IF DirectoryExists( ls_dir ) THEN
	IF MessageBox( "Export", "The specified directory (" + ls_dir + ") already exists." + &
					"~n~rAny files with duplicate names within this directory " + &
					"will be overwritten.~n~r~n~rWould you like to continue exporting " + &
					"to the existing directory?", Exclamation!, YesNoCancel! ) <> 1 THEN	Return
ELSE
	//	Create Direcory
	IF CreateDirectory( ls_dir ) = -1 THEN
		MessageBox( "Export Error", "Unable to create directory: " + ls_dir, StopSign! )
		Return
	END IF
END IF

SetPointer( HourGlass! )

//	Export Notes
li_ctr += Parent.wf_export_notes( ls_dir )

//	Export Attachments
li_ctr += Parent.wf_export_attachments( ls_dir )

IF li_ctr = 0 THEN
	MessageBox( "Export", "There are no selected links to export", Information! )
ELSE
	MessageBox( "Export", "The selected links were exported to: " + ls_dir, Information! )
END IF

//-------- This logic was used to test Case printing in STARS 5.4.0 ------
//Long	ll_job, ll_row, ll_ctr
//sx_case_track lstr_case_track
//w_track_maint	lw_track_inst[]
//
//IF NOT IsValid( w_case_maint ) THEN Return
//
//w_case_maint.tab_case.SetRedraw( FALSE )
//w_case_maint.tab_case.tabpage_general.dw_general.Object.DataWindow.Header.Height = '100'
//w_case_maint.tab_case.tabpage_current.dw_current.Object.DataWindow.Header.Height = '100'
//w_case_maint.tab_case.tabpage_savings.dw_savings.Object.DataWindow.Header.Height = '100'
//w_case_maint.tab_case.tabpage_pimr.dw_pimr.Object.DataWindow.Header.Height = '100'
//w_case_maint.tab_case.tabpage_pimr.dw_pimr.Object.header_title_t.text = &
//																w_case_maint.tab_case.tabpage_pimr.text
//w_case_maint.tab_case.tabpage_log.dw_display_log.Object.DataWindow.Footer.Height = '20'
//
//ll_job = PrintOpen( "Case " + is_case_id + is_case_spl + is_case_ver, TRUE )
//// Print Case Details
//PrintDataWindow( ll_job, w_case_maint.tab_case.tabpage_general.dw_general )
//PrintDataWindow( ll_job, w_case_maint.tab_case.tabpage_current.dw_current )
//PrintDataWindow( ll_job, w_case_maint.tab_case.tabpage_savings.dw_savings )
//PrintDataWindow( ll_job, w_case_maint.tab_case.tabpage_pimr.dw_pimr )
////PrintDataWindow( ll_job, w_case_maint.tab_case.tabpage_log.dw_display_log )
//
//// Print Case Folder
//PrintDataWindow( ll_job, parent.tab_print.tabpage_case.dw_case_folder )
//
// Print Tracks
//ll_row = tab_print.tabpage_tracks.dw_tracks.GetSelectedRow( 0 )
//
//DO WHILE ll_row > 0
//	lstr_case_track.case_id = is_case_id + is_case_spl + is_case_ver
//	lstr_case_track.trk_type = tab_print.tabpage_tracks.dw_tracks.GetItemString( ll_row, "trk_type" )
//	lstr_case_track.trk_key = tab_print.tabpage_tracks.dw_tracks.GetItemString( ll_row, "trk_key" )
//	lstr_case_track.target_id = tab_print.tabpage_tracks.dw_tracks.GetItemString( ll_row, "track_target_id" )
//	ll_ctr ++
//	OpenWithParm( lw_track_inst[ll_ctr], lstr_case_track, "w_track_maint" )
//	//lw_track_inst.visible = FALSE
//	//PrintDataWindow( ll_job, lw_track_inst[ll_ctr].tab_track.tabpage_general.dw_general )
//	lw_track_inst[ll_ctr].tab_track.tabpage_general.dw_general.Print()
//	
//	//Close( lw_track_inst )
//	
//	ll_row = tab_print.tabpage_tracks.dw_tracks.GetSelectedRow( ll_row )
//LOOP
//
//PrintClose( ll_job )
//
//w_case_maint.tab_case.tabpage_general.dw_general.Object.DataWindow.Header.Height = '0'
//w_case_maint.tab_case.tabpage_current.dw_current.Object.DataWindow.Header.Height = '0'
//w_case_maint.tab_case.tabpage_savings.dw_savings.Object.DataWindow.Header.Height = '0'
//w_case_maint.tab_case.tabpage_pimr.dw_pimr.Object.DataWindow.Header.Height = '0'
//w_case_maint.tab_case.tabpage_log.dw_display_log.Object.DataWindow.Footer.Height = '0'
//w_case_maint.tab_case.SetRedraw( TRUE )
end event

type cb_close from u_cb within w_case_export
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1989
integer y = 1696
integer taborder = 30
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;//	02/22/07	GaryR	Track 4824	Facility to export Attachments and Notes

Close( Parent )
end event

type tab_print from tab within w_case_export
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = clientrole!
integer x = 37
integer y = 32
integer width = 2267
integer height = 1632
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_case tabpage_case
tabpage_tracks tabpage_tracks
tabpage_targets tabpage_targets
tabpage_leads tabpage_leads
tabpage_notes tabpage_notes
tabpage_attachments tabpage_attachments
end type

on tab_print.create
this.tabpage_case=create tabpage_case
this.tabpage_tracks=create tabpage_tracks
this.tabpage_targets=create tabpage_targets
this.tabpage_leads=create tabpage_leads
this.tabpage_notes=create tabpage_notes
this.tabpage_attachments=create tabpage_attachments
this.Control[]={this.tabpage_case,&
this.tabpage_tracks,&
this.tabpage_targets,&
this.tabpage_leads,&
this.tabpage_notes,&
this.tabpage_attachments}
end on

on tab_print.destroy
destroy(this.tabpage_case)
destroy(this.tabpage_tracks)
destroy(this.tabpage_targets)
destroy(this.tabpage_leads)
destroy(this.tabpage_notes)
destroy(this.tabpage_attachments)
end on

type tabpage_case from userobject within tab_print
boolean visible = false
long textcolor = 33554432
string accessiblename = "Case"
string accessibledescription = "Case"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 2231
integer height = 1516
long backcolor = 67108864
string text = "Case"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cbx_folder cbx_folder
cbx_case_log cbx_case_log
cbx_pimr cbx_pimr
cbx_financial cbx_financial
cbx_status cbx_status
cbx_general cbx_general
dw_case_folder dw_case_folder
gb_case gb_case
end type

on tabpage_case.create
this.cbx_folder=create cbx_folder
this.cbx_case_log=create cbx_case_log
this.cbx_pimr=create cbx_pimr
this.cbx_financial=create cbx_financial
this.cbx_status=create cbx_status
this.cbx_general=create cbx_general
this.dw_case_folder=create dw_case_folder
this.gb_case=create gb_case
this.Control[]={this.cbx_folder,&
this.cbx_case_log,&
this.cbx_pimr,&
this.cbx_financial,&
this.cbx_status,&
this.cbx_general,&
this.dw_case_folder,&
this.gb_case}
end on

on tabpage_case.destroy
destroy(this.cbx_folder)
destroy(this.cbx_case_log)
destroy(this.cbx_pimr)
destroy(this.cbx_financial)
destroy(this.cbx_status)
destroy(this.cbx_general)
destroy(this.dw_case_folder)
destroy(this.gb_case)
end on

type cbx_folder from u_cbx within tabpage_case
long backcolor = 67108864
string accessiblename = "Case Folder"
string accessibledescription = "Case Folder"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 18
integer y = 348
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Case Folder"
boolean checked = true
end type

type cbx_case_log from u_cbx within tabpage_case
long backcolor = 67108864
string accessiblename = "Case Log"
string accessibledescription = "Case Log"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 18
integer y = 252
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Case Log"
boolean checked = true
end type

type cbx_pimr from u_cbx within tabpage_case
long backcolor = 67108864
string accessiblename = "PIMR Data Tab"
string accessibledescription = "PIMR Data Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1627
integer y = 92
integer width = 443
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "PIMR Data Tab"
boolean checked = true
end type

type cbx_financial from u_cbx within tabpage_case
long backcolor = 67108864
string accessiblename = "Financial Data Tab"
string accessibledescription = "Financial Data Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1006
integer y = 92
integer width = 517
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Financial Data Tab"
boolean checked = true
end type

type cbx_status from u_cbx within tabpage_case
long backcolor = 67108864
string accessiblename = "Status Tab"
string accessibledescription = "Status Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 567
integer y = 92
integer width = 439
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Status Tab"
boolean checked = true
end type

type cbx_general from u_cbx within tabpage_case
long backcolor = 67108864
string accessiblename = "General Tab"
string accessibledescription = "General Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 91
integer y = 92
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "General Tab"
boolean checked = true
end type

type dw_case_folder from u_dw within tabpage_case
string accessiblename = "Case Folder"
string accessibledescription = "Case Folder"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 444
integer width = 2194
integer height = 1056
integer taborder = 20
string dataobject = "d_case_folder"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_multiselect = true
boolean ib_isupdateable = false
end type

type gb_case from groupbox within tabpage_case
long textcolor = 134217741
string accessiblename = "Case Details"
string accessibledescription = "Case Details"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer y = 28
integer width = 2194
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Case Details"
end type

type tabpage_tracks from userobject within tab_print
boolean visible = false
long textcolor = 33554432
string accessiblename = "Tracks"
string accessibledescription = "Tracks"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 2231
integer height = 1516
long backcolor = 67108864
string text = "Tracks"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_tracks dw_tracks
cbx_track_log cbx_track_log
cbx_track_financial cbx_track_financial
cbx_track_status cbx_track_status
cbx_track_general cbx_track_general
gb_tracks gb_tracks
end type

on tabpage_tracks.create
this.dw_tracks=create dw_tracks
this.cbx_track_log=create cbx_track_log
this.cbx_track_financial=create cbx_track_financial
this.cbx_track_status=create cbx_track_status
this.cbx_track_general=create cbx_track_general
this.gb_tracks=create gb_tracks
this.Control[]={this.dw_tracks,&
this.cbx_track_log,&
this.cbx_track_financial,&
this.cbx_track_status,&
this.cbx_track_general,&
this.gb_tracks}
end on

on tabpage_tracks.destroy
destroy(this.dw_tracks)
destroy(this.cbx_track_log)
destroy(this.cbx_track_financial)
destroy(this.cbx_track_status)
destroy(this.cbx_track_general)
destroy(this.gb_tracks)
end on

type dw_tracks from u_dw within tabpage_tracks
string accessiblename = "Track List"
string accessibledescription = "Track List"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 348
integer width = 2194
integer height = 1152
integer taborder = 11
string dataobject = "d_tracking_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_multiselect = true
boolean ib_isupdateable = false
end type

type cbx_track_log from u_cbx within tabpage_tracks
long backcolor = 67108864
string accessiblename = "Track Log"
string accessibledescription = "Track Log"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 18
integer y = 252
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Track Log"
boolean checked = true
end type

type cbx_track_financial from u_cbx within tabpage_tracks
long backcolor = 67108864
string accessiblename = "Financial Data Tab"
string accessibledescription = "Financial Data Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1006
integer y = 92
integer width = 517
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Financial Data Tab"
boolean checked = true
end type

type cbx_track_status from u_cbx within tabpage_tracks
long backcolor = 67108864
string accessiblename = "Status Tab"
string accessibledescription = "Status Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 567
integer y = 92
integer width = 439
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "Status Tab"
boolean checked = true
end type

type cbx_track_general from u_cbx within tabpage_tracks
long backcolor = 67108864
string accessiblename = "General Tab"
string accessibledescription = "General Tab"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 91
integer y = 92
integer textsize = -8
integer weight = 400
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
string text = "General Tab"
boolean checked = true
end type

type gb_tracks from groupbox within tabpage_tracks
long textcolor = 134217741
string accessiblename = "Track Details"
string accessibledescription = "Track Details"
accessiblerole accessiblerole = groupingrole!
integer x = 18
integer y = 28
integer width = 2194
integer height = 192
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 67108864
string text = "Track Details"
end type

type tabpage_targets from userobject within tab_print
boolean visible = false
long textcolor = 33554432
string accessiblename = "Targets"
string accessibledescription = "Targets"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 2231
integer height = 1516
long backcolor = 67108864
string text = "Targets"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_targets dw_targets
end type

on tabpage_targets.create
this.dw_targets=create dw_targets
this.Control[]={this.dw_targets}
end on

on tabpage_targets.destroy
destroy(this.dw_targets)
end on

type dw_targets from u_dw within tabpage_targets
string accessiblename = "Target By Case Print"
string accessibledescription = "Target By Case Print"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 28
integer width = 2194
integer height = 1472
integer taborder = 11
string dataobject = "d_target_by_case_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_multiselect = true
boolean ib_isupdateable = false
end type

type tabpage_leads from userobject within tab_print
boolean visible = false
long textcolor = 33554432
string accessiblename = "Leads"
string accessibledescription = "Leads"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 2231
integer height = 1516
long backcolor = 67108864
string text = "Leads"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_leads dw_leads
end type

on tabpage_leads.create
this.dw_leads=create dw_leads
this.Control[]={this.dw_leads}
end on

on tabpage_leads.destroy
destroy(this.dw_leads)
end on

type dw_leads from u_dw within tabpage_leads
string accessiblename = "Leads List"
string accessibledescription = "Leads List"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 28
integer width = 2194
integer height = 1472
integer taborder = 11
string dataobject = "d_leads_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_multiselect = true
boolean ib_isupdateable = false
end type

type tabpage_notes from userobject within tab_print
long textcolor = 33554432
string accessiblename = "Notes"
string accessibledescription = "Notes"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 2231
integer height = 1516
long backcolor = 67108864
string text = "Notes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_notes dw_notes
end type

on tabpage_notes.create
this.dw_notes=create dw_notes
this.Control[]={this.dw_notes}
end on

on tabpage_notes.destroy
destroy(this.dw_notes)
end on

type dw_notes from u_dw within tabpage_notes
string accessiblename = "Export Notes List"
string accessibledescription = "Export Notes List"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 28
integer width = 2194
integer height = 1472
integer taborder = 11
string dataobject = "d_export_notes_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_multiselect = true
boolean ib_isupdateable = false
end type

type tabpage_attachments from userobject within tab_print
long textcolor = 33554432
string accessiblename = "Attachments"
string accessibledescription = "Attachments"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 100
integer width = 2231
integer height = 1516
long backcolor = 67108864
string text = "Attachments"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_attachments dw_attachments
end type

on tabpage_attachments.create
this.dw_attachments=create dw_attachments
this.Control[]={this.dw_attachments}
end on

on tabpage_attachments.destroy
destroy(this.dw_attachments)
end on

type dw_attachments from u_dw within tabpage_attachments
string accessiblename = "Attachment List"
string accessibledescription = "Attachment List"
accessiblerole accessiblerole = clientrole!
integer x = 18
integer y = 28
integer width = 2194
integer height = 1472
integer taborder = 11
string dataobject = "d_attach_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_multiselect = true
boolean ib_isupdateable = false
end type

