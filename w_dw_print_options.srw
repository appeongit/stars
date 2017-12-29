HA$PBExportHeader$w_dw_print_options.srw
$PBExportComments$New! Datawindow print options (inherited from w_master)
forward
global type w_dw_print_options from w_master
end type
type cb_banner from u_cb within w_dw_print_options
end type
type cb_file from u_cb within w_dw_print_options
end type
type st_print_file from statictext within w_dw_print_options
end type
type st_pf from statictext within w_dw_print_options
end type
type ddlb_range from dropdownlistbox within w_dw_print_options
end type
type st_4 from statictext within w_dw_print_options
end type
type cb_printer from u_cb within w_dw_print_options
end type
type cb_cancel from u_cb within w_dw_print_options
end type
type cbx_collate from checkbox within w_dw_print_options
end type
type cbx_print_to_file from checkbox within w_dw_print_options
end type
type st_3 from statictext within w_dw_print_options
end type
type sle_page_range from singlelineedit within w_dw_print_options
end type
type rb_pages from radiobutton within w_dw_print_options
end type
type rb_current_page from radiobutton within w_dw_print_options
end type
type rb_all from radiobutton within w_dw_print_options
end type
type em_copies from editmask within w_dw_print_options
end type
type st_2 from statictext within w_dw_print_options
end type
type sle_printer from singlelineedit within w_dw_print_options
end type
type st_1 from statictext within w_dw_print_options
end type
type cb_ok from u_cb within w_dw_print_options
end type
type gb_1 from groupbox within w_dw_print_options
end type
type gb_2 from groupbox within w_dw_print_options
end type
type rb_portrait from radiobutton within w_dw_print_options
end type
type rb_landscape from radiobutton within w_dw_print_options
end type
type cb_preview from u_cb within w_dw_print_options
end type
type cbx_grid from checkbox within w_dw_print_options
end type
end forward

global type w_dw_print_options from w_master
string accessiblename = "Datawindow Print Options"
string accessibledescription = "Datawindow Print Options"
accessiblerole accessiblerole = windowrole!
integer x = 142
integer y = 64
integer width = 2085
integer height = 1476
string title = "Datawindow Print Options"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
cb_banner cb_banner
cb_file cb_file
st_print_file st_print_file
st_pf st_pf
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_collate cbx_collate
cbx_print_to_file cbx_print_to_file
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
em_copies em_copies
st_2 st_2
sle_printer sle_printer
st_1 st_1
cb_ok cb_ok
gb_1 gb_1
gb_2 gb_2
rb_portrait rb_portrait
rb_landscape rb_landscape
cb_preview cb_preview
cbx_grid cbx_grid
end type
global w_dw_print_options w_dw_print_options

type variables
string is_page_range
u_dw idw_dw		//	12/13/04	GaryR	Track 4108d	Dynamic Report Options
end variables

forward prototypes
private subroutine wf_page_range (radiobutton who)
public subroutine wf_enable_printfile ()
public subroutine wf_disable_printfile ()
public function integer wf_modify_dw ()
end prototypes

private subroutine wf_page_range (radiobutton who);// FDG 04/10/96 - Because this can be called from the open event,
//						must check the appropriate radiobutton

choose case who
	case rb_all
		rb_all.checked		=	TRUE						// FDG 04/10/96
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'a'
	case rb_current_page
		rb_current_page.checked		=	TRUE			// FDG 04/10/96
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'c'
	case rb_pages		
		rb_pages.checked		=	TRUE					// FDG 04/10/96
		sle_page_range.enabled = true
		is_page_range = 'p'
end choose
end subroutine

public subroutine wf_enable_printfile ();//show all items related to choosing a file
st_pf.visible = true
st_print_file.visible = true
cb_file.visible = true
end subroutine

public subroutine wf_disable_printfile ();//hide all items related to choosing a file
st_pf.visible = false
st_print_file.visible = false
cb_file.visible = false
st_print_file.text = ''
end subroutine

public function integer wf_modify_dw ();// Function created FDG 04/12/96 - Called by cb_ok and by cb_banner

string tmp, command
long row 
string	docname, named
int	value


choose case lower(left(ddlb_range.text,1)) // determine rangeinclude (all,even,odd)
	case 'a' // all
		tmp = '0'
	case 'e' // even
		tmp = '1'
	case 'o' //odd
		tmp = '2'

end choose
command = 'datawindow.print.page.rangeinclude = '+tmp

if cbx_collate.checked then // collate output ?
	command = command +  " datawindow.print.collate = yes"
else
	command = command +  " datawindow.print.collate = no"
end if
choose case is_page_range // did they pick a page range?
	case 'a'  // all
		tmp = ''
	case 'c' // current page?
		row = idw_dw.getrow()
		tmp = idw_dw.Describe("evaluate('page()',"+string(row)+")")
	case 'p' // a range?
		tmp = sle_page_range.text
end choose		
command = command +  " datawindow.print.page.range = '"+tmp+"'"

// number of copies ?
if len(em_copies.text) > 0 then command = command +  " datawindow.print.copies = "+em_copies.text

If cbx_print_to_file.checked  and st_print_file.text = "" Then // print to file and no file seleted yet?
	value = GetFileSaveName("Print To File", docname, named, "PRN", "Print (*.PRN),*.PRN")
	if value = 1 then 
		st_print_file.text= docname
	else // they canceled out of the dialog so quit completely
		return 0
	end if
end if

If cbx_print_to_file.checked Then
	command = command + " datawindow.print.filename = '"+st_print_file.text+"'"
Else
	command = command + " datawindow.print.filename = '' "
End If

// now alter the datawindow
tmp = idw_dw.modify(command)
if len(tmp) > 0 then // if error the display the 
	messagebox('Error Setting Print Options','Error message = ' + tmp + '~r~nCommand = ' + command)
	return -1
end if

Return 1
end function

event open;call super::open;///////////////////////////////////////////////////////////////////////
//
// we assume that this window will be opened using openwitparm and that
// a datawindow control will be passed to it
//
///////////////////////////////////////////////////////////////////////
//
// 04/10/96	FDG	Prob 253 - Disable the pages until rb_pages is clicked
// 06/01/00	FDG	Track 2915c.  Default the print to landscape
// 10/12/00	GaryR	Track 3021c Allow users to print reports with grid lines
//	04/18/03	GaryR	Track 3508d	PDR Title page clean-up
// 10/19/04 MikeF					Replaced f_global_replace with n_cst_string
///////////////////////////////////////////////////////////////////////

string ls_rc
n_cst_string	lnv_string

sle_printer.text = idw_dw.Describe('datawindow.printer')

//set the page print include (all,even,odd)

ls_rc = idw_dw.Describe('datawindow.print.page.rangeinclude')

choose case Left(ls_rc,1)  // determine rangeinclude (all,even,odd)
	case '0' // all
		ddlb_range.SelectItem(1) 
		is_page_range = 'a'
	case '1' // even
		ddlb_range.SelectItem(2) 
		is_page_range = 'e'
	case '2' //odd
		ddlb_range.SelectItem(3) 
		is_page_range = 'o'
end choose


//if cbx_collate.checked then // collate output

ls_rc = idw_dw.describe('datawindow.print.collate')

If ls_rc = "yes" Then
	cbx_collate.checked = True
ElseIf ls_rc = "no" Then
	cbx_collate.checked = False
End If


//page_range 
ls_rc = idw_dw.describe('datawindow.print.page.range')
If ls_rc = "" Then
//	is_page_range = "a"					// FDG 04/10/96
//	rb_all.checked = true				//	FDG 04/10/96
	rb_all.TriggerEvent(Clicked!)		// FDG 04/10/96
Else
//	is_page_range = "p"					// FDG 04/10/96
//	rb_pages.checked =true				// FDG 04/10/96
	rb_pages.TriggerEvent (Clicked!)	// FDG 04/10/96
	sle_page_range.text = ls_rc
End If

//// number of copies ?
ls_rc = idw_dw.describe('datawindow.print.copies')

//copies = 0 is actually 1 copy.....

If ls_rc = "0" Then ls_rc = "1"
em_copies.text = ls_rc

//	Default the orientation from DW
IF idw_dw.Describe("DataWindow.Print.Orientation") = "2" THEN
	rb_portrait.checked = TRUE
ELSE
	// FDG 06/01/00 - Default to Landscape
	idw_dw.object.DataWindow.Print.Orientation	=	1
END IF

// GaryR 10/12/00	3021c Begin
// Make sure that this is a grid DW
IF idw_dw.Describe( "DataWindow.Processing" ) = "1" THEN
	// Check if DW is set to print the grid lines
	ls_rc = idw_dw.Describe( "DataWindow.Grid.Lines" )
	// Default to printing grid lines
	IF ls_rc <> "0" OR ls_rc <> "3" THEN idw_dw.Modify( "DataWindow.Grid.Lines=0" )
	cbx_grid.Checked = TRUE
ELSE
	cbx_grid.Visible = FALSE
END IF
// GaryR 10/12/00	3021c End

//print to file ?
ls_rc = idw_dw.describe('datawindow.print.filename')
If ls_rc <> "" and ls_rc <>"!"Then 
	cbx_print_to_file.checked = True
	wf_enable_printfile()
	//strip the ~'s out of the file name to display properly
	ls_rc = lnv_string.of_globalreplace( ls_rc, "~~", "")
	st_print_file.text = ls_rc
Else
	cbx_print_to_file.checked = False
	wf_disable_printfile()
End If


end event

on w_dw_print_options.create
int iCurrent
call super::create
this.cb_banner=create cb_banner
this.cb_file=create cb_file
this.st_print_file=create st_print_file
this.st_pf=create st_pf
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_collate=create cbx_collate
this.cbx_print_to_file=create cbx_print_to_file
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.em_copies=create em_copies
this.st_2=create st_2
this.sle_printer=create sle_printer
this.st_1=create st_1
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rb_portrait=create rb_portrait
this.rb_landscape=create rb_landscape
this.cb_preview=create cb_preview
this.cbx_grid=create cbx_grid
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_banner
this.Control[iCurrent+2]=this.cb_file
this.Control[iCurrent+3]=this.st_print_file
this.Control[iCurrent+4]=this.st_pf
this.Control[iCurrent+5]=this.ddlb_range
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.cb_printer
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.cbx_collate
this.Control[iCurrent+10]=this.cbx_print_to_file
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.sle_page_range
this.Control[iCurrent+13]=this.rb_pages
this.Control[iCurrent+14]=this.rb_current_page
this.Control[iCurrent+15]=this.rb_all
this.Control[iCurrent+16]=this.em_copies
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.sle_printer
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.cb_ok
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.rb_portrait
this.Control[iCurrent+24]=this.rb_landscape
this.Control[iCurrent+25]=this.cb_preview
this.Control[iCurrent+26]=this.cbx_grid
end on

on w_dw_print_options.destroy
call super::destroy
destroy(this.cb_banner)
destroy(this.cb_file)
destroy(this.st_print_file)
destroy(this.st_pf)
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_collate)
destroy(this.cbx_print_to_file)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.em_copies)
destroy(this.st_2)
destroy(this.sle_printer)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rb_portrait)
destroy(this.rb_landscape)
destroy(this.cb_preview)
destroy(this.cbx_grid)
end on

event ue_preopen;call super::ue_preopen;idw_dw = message.powerobjectparm

end event

type cb_banner from u_cb within w_dw_print_options
string accessiblename = "Banner..."
string accessibledescription = "Banner..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1504
integer y = 408
integer width = 366
integer height = 88
integer taborder = 140
string text = "Banner..."
end type

event clicked;	// FDG 04/12/96 - Placed logic in wf_modify_dw() so this script
	//						and cb_ok can modify the print parms for the d/w.
	//						w_banner_page will print both the banner page and
	//						the datawindow as part of the same print job.

Integer	li_return

IF wf_modify_dw() < 0		THEN
	Return
END IF

OpenWithParm (w_banner_page, idw_dw)

li_return	=	Message.DoubleParm

	//	If the user canceled out of the banner page window, nothing was
	//	printed.  Do not close this window when this occurs.

IF	li_return	=	0		THEN
	Return
END IF

closewithreturn(parent,li_return)

end event

type cb_file from u_cb within w_dw_print_options
string accessiblename = "File..."
string accessibledescription = "File..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1522
integer y = 1236
integer width = 247
integer taborder = 160
string text = "File..."
end type

on clicked;string ls_temp 
string ls_file
int li_rc
li_rc = GetFileSaveName("Print To File", ls_file, ls_temp, "PRN", "Print (*.PRN),*.PRN")

If li_rc = 1 Then	st_print_file.text = ls_file
end on

type st_print_file from statictext within w_dw_print_options
string accessiblename = "Print File"
string accessibledescription = "Print File"
accessiblerole accessiblerole = statictextrole!
integer x = 297
integer y = 1236
integer width = 1074
integer height = 96
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type st_pf from statictext within w_dw_print_options
string accessiblename = "Print File"
string accessibledescription = "Print File"
accessiblerole accessiblerole = statictextrole!
integer x = 96
integer y = 1236
integer width = 183
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Print File:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_range from dropdownlistbox within w_dw_print_options
string accessiblename = "Print Page Range"
string accessibledescription = "Print Page Range"
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 297
integer y = 1096
integer width = 1070
integer height = 288
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
string text = "All Pages In Range"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"All Pages in Range","Even Numbered Pages","Odd Numbered Pages"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_dw_print_options
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = statictextrole!
integer x = 101
integer y = 1104
integer width = 178
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "P&rint:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_printer from u_cb within w_dw_print_options
string accessiblename = "Printer"
string accessibledescription = "Printer..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1504
integer y = 300
integer width = 366
integer height = 88
integer taborder = 130
string text = "Prin&ter..."
end type

on clicked;printsetup()
sle_printer.text = idw_dw.Describe('datawindow.printer')
end on

type cb_cancel from u_cb within w_dw_print_options
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1504
integer y = 192
integer width = 366
integer height = 88
integer taborder = 120
string text = "Cancel"
boolean cancel = true
end type

on clicked;closewithreturn(parent,-1)
end on

type cbx_collate from checkbox within w_dw_print_options
string accessiblename = "Collate Copies"
string accessibledescription = "Collate Copies"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1472
integer y = 772
integer width = 535
integer height = 72
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Collate Cop&ies"
end type

type cbx_print_to_file from checkbox within w_dw_print_options
string accessiblename = "Print to File"
string accessibledescription = "Print to File"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1472
integer y = 684
integer width = 457
integer height = 72
integer taborder = 90
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Print to Fi&le"
end type

on clicked;If this.checked Then
	wf_enable_printfile()
Else
	wf_disable_printfile()
End If
end on

type st_3 from statictext within w_dw_print_options
string accessiblename = "Enter page numbers and/or page ranges separated by commas. For example, 2,5,8-10"
string accessibledescription = "Enter page numbers and/or page ranges separated by commas. For example, 2,5,8-10"
accessiblerole accessiblerole = statictextrole!
integer x = 87
integer y = 644
integer width = 1353
integer height = 128
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Enter page numbers and/or page ranges separated by commas. For example, 2,5,8-10"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_dw_print_options
string accessiblename = "Page Range"
string accessibledescription = "Page Range"
accessiblerole accessiblerole = textrole!
integer x = 475
integer y = 504
integer width = 887
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1073741824
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on losefocus;// FDG 04/10/96	Prob 253 - Set rb_pages when data is changed here

rb_pages.TriggerEvent (Clicked!)

end on

type rb_pages from radiobutton within w_dw_print_options
string accessiblename = "Pages"
string accessibledescription = "Pages"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 146
integer y = 508
integer width = 302
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pa&ges:"
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_dw_print_options
string accessiblename = "Current Page"
string accessibledescription = "Current Page"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 146
integer y = 424
integer width = 466
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Curr&ent Page"
end type

on clicked;wf_page_range(this)
end on

type rb_all from radiobutton within w_dw_print_options
string accessiblename = "All"
string accessibledescription = "All"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 146
integer y = 332
integer width = 247
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "&All"
end type

on clicked;wf_page_range(this)
end on

type em_copies from editmask within w_dw_print_options
string accessiblename = "Number of Copies"
string accessibledescription = "Number of Copies"
long backcolor = 1073741824
accessiblerole accessiblerole = textrole!
integer x = 315
integer y = 144
integer width = 247
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_2 from statictext within w_dw_print_options
string accessiblename = "Copies"
string accessibledescription = "Copies"
accessiblerole accessiblerole = statictextrole!
integer x = 69
integer y = 164
integer width = 215
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copies:"
boolean focusrectangle = false
end type

type sle_printer from singlelineedit within w_dw_print_options
string accessiblename = "Printer"
string accessibledescription = "Printer"
accessiblerole accessiblerole = textrole!
integer x = 315
integer y = 52
integer width = 987
integer height = 84
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1073741824
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

type st_1 from statictext within w_dw_print_options
string accessiblename = "Printer"
string accessibledescription = "Printer"
accessiblerole accessiblerole = statictextrole!
integer x = 69
integer y = 56
integer width = 215
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Printer:"
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_dw_print_options
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1504
integer y = 88
integer width = 366
integer height = 88
integer taborder = 110
string text = "OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////
//
// 04/12/96	FDG	Placed logic in wf_modify_dw() so cb_banner can
//						execute the same logic.
// 10/27/00	GaryR	2315d	Conforming STARS to the HIPAA Act
// 04/24/02	LahuS	Track 2552d Title page for PDR
//	09/24/02	GaryR	Track 2552d	Ask for title page only in PDR mode.
//	04/18/03	GaryR	Track 3508d	PDR Title page clean-up
//	04/22/03	GaryR	Track 3508d	PDR Title page clean-up
//	08/20/03	GaryR	Track 3627d	Link client names with logos
//	12/13/04	GaryR	Track 4108d	Dynamic Report Options
//	12/29/04	GaryR	Track 4108d	Allow Title Page in Saved Reports
//
//////////////////////////////////////////////////////////////////

Integer	li_printed
n_ds_titlepage		lds_titlepage

IF wf_modify_dw() < 0		THEN
	Return
END IF

	// FDG 04/12/96 - Print from this script instead of within f_dw_print
	// because the banner print (if used), needs to print the banner page
	//	and the report within the same print job.

IF fx_disclaimer() <> 1 THEN Return	// GaryR	 10/27/2000	2315d

//Lahu S 4/24/02 Track 2552d begin
//Prompt for PDR Title page
IF idw_dw.describe("st_report_id.visible") <> '!' THEN
	lds_titlepage = Create n_ds_titlepage
	IF lds_titlepage.Event ue_populate( idw_dw ) > 0 THEN
		li_printed	=	lds_titlepage.Print( FALSE )
	END IF
	
	Destroy lds_titlepage
END IF

li_printed	=	idw_dw.Print()	
closewithreturn(parent,li_printed)
end event

type gb_1 from groupbox within w_dw_print_options
string accessiblename = "Page Range"
string accessibledescription = "Page Range"
accessiblerole accessiblerole = groupingrole!
integer x = 69
integer y = 264
integer width = 1390
integer height = 524
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Page Range"
end type

type gb_2 from groupbox within w_dw_print_options
string accessiblename = "Print Orientation"
string accessibledescription = "Print Orientation"
accessiblerole accessiblerole = groupingrole!
integer x = 69
integer y = 820
integer width = 1390
integer height = 252
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Print Orientation"
end type

type rb_portrait from radiobutton within w_dw_print_options
string accessiblename = "Portrait"
string accessibledescription = "Portrait"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 142
integer y = 896
integer width = 809
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Portrait"
end type

event clicked;//*********************************************************************************
// Script Name:	rb_portrait.clicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Specify that the datawindow will be printed as Portrait.
//
//*********************************************************************************
//	
// 06/01/00 FDG	Track 2915c.  Created.
//
//*********************************************************************************

idw_dw.object.DataWindow.Print.Orientation	=	2


end event

type rb_landscape from radiobutton within w_dw_print_options
string accessiblename = "Landscape"
string accessibledescription = "Landscape"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 142
integer y = 980
integer width = 809
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Landscape"
boolean checked = true
end type

event clicked;//*********************************************************************************
// Script Name:	rb_landscape.clicked
//
//	Arguments:		N/A
//
// Returns:			N/A
//
//	Description:	Specify that the datawindow will be printed as Landscape.
//
//*********************************************************************************
//	
// 06/01/00 FDG	Track 2915c.  Created.
//
//*********************************************************************************

idw_dw.object.DataWindow.Print.Orientation	=	1


end event

type cb_preview from u_cb within w_dw_print_options
boolean visible = false
string accessiblename = "Preview"
string accessibledescription = "Preview..."
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1504
integer y = 520
integer width = 366
integer height = 88
integer taborder = 150
boolean enabled = false
string text = "Preview..."
end type

event clicked;// FDG 06/01/00 - Track 2915.  Place the d/w in print preview mode and
//						display it to the user.

//Integer	li_return
//
//IF wf_modify_dw()	<	0		THEN
//	Return
//END IF
//
//OpenWithParm (w_print_preview, idw_dw)
//
//li_return	=	Message.DoubleParm
//
////	If the user canceled out of the print preview window, nothing was
////	printed.  Do not close this window when this occurs.
//
//IF	li_return	<	0		THEN
//	Return
//END IF
//
//CloseWithReturn (Parent, 1)

end event

type cbx_grid from checkbox within w_dw_print_options
string accessiblename = "Print Grid Lines"
string accessibledescription = "Print Grid Lines"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 1472
integer y = 860
integer width = 558
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Print Grid Lines"
end type

event clicked;// GaryR 10/12/00	3021c Allow users to print reports with grid lines

IF THIS.Checked = TRUE THEN
	idw_dw.Modify( "DataWindow.Grid.Lines=0" )
ELSE
	idw_dw.Modify( "DataWindow.Grid.Lines=2" )
END IF
end event

