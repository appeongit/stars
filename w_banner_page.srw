HA$PBExportHeader$w_banner_page.srw
$PBExportComments$Create a banner page window (inherited from w_master)
forward
global type w_banner_page from w_master
end type
type st_1 from statictext within w_banner_page
end type
type cb_cancel from u_cb within w_banner_page
end type
type cb_print from u_cb within w_banner_page
end type
type dw_banner_page from u_dw within w_banner_page
end type
end forward

global type w_banner_page from w_master
string accessiblename = "Banner Page"
string accessibledescription = "Banner Page"
accessiblerole accessiblerole = windowrole!
integer x = 87
integer y = 64
integer width = 2793
integer height = 1796
string title = "Banner Page"
windowtype windowtype = response!
long backcolor = 67108864
st_1 st_1
cb_cancel cb_cancel
cb_print cb_print
dw_banner_page dw_banner_page
end type
global w_banner_page w_banner_page

type variables
//	12/13/04	GaryR	Track 4108d	Dynamic Report Options

u_dw	idw
end variables

event open;call super::open;//************************************************************************
//	Object Name:	w_banner_page
//	Object Type:	Window
//	Event Name:		Open
//
//		This script will retrieve the data for the banner page.
//
//		This window requires the datawindow to print to be passed to it.
//
//************************************************************************

STRING	ls_describe
STRING	ls_title
LONG		ll_row
LONG		ll_pos,	ll_pos2,	ll_pos3,	ll_len

ls_title	=	''

SetPointer (HourGlass!)

IF NOT IsValid(idw)		THEN
	SetPointer (Arrow!)
	MessageBox ('Banner Page Error', 'This window requires a datawindow ' + &
					' to be passed to it')
	Close (This)
	Return
END IF

	// Retrieve the banner page data using the user id as the retrieval
	//	argument

dw_banner_page.SetRedraw (FALSE)
dw_banner_page.SetTransObject (STARS2CA)

ll_row	=	dw_banner_page.Retrieve (gc_user_id)

IF ll_row	<	1		THEN
	SetPointer (Arrow!)
	MessageBox ('Banner Page Error', 'The Userid for this banner ' + &
					'page could not be found.')
	Close (This)
	Return
END IF

ls_title	=	idw.Describe ("DataWindow.Print.DocumentName")

//f_debug_box ('Debug - w_banner_page.Open', &
//				'DataWindow.Print.DocumentName = ' + ls_title)

	//	If no name was set for this d/w, look for a title in the header
	//	This logic can't be executed because the titles are stored
	// inconsistently among different datawindows.
//IF	Trim (ls_title)	<	'  ' OR ls_title = '!' OR ls_title = '!' 	THEN
//	ls_describe	=	idw.Describe ("DataWindow.Syntax")
//	f_debug_box ('Debug - w_banner_page.Open', &
//					'DataWindow.Syntax = ' + ls_describe)
//	ll_pos		=	Pos (ls_describe, 'text(band=', 1)
//	ll_pos2		=	Pos (ls_describe, 'text=', ll_pos)
//	ll_pos3		=	Pos (ls_describe, '"', ll_pos2 + 6)
//	ll_len		=	ll_pos3	-	(ll_pos2	+ 6)
//	IF	ll_len	>	0		THEN
//		ls_title		=	Mid (ls_describe, ll_pos2 + 6, ll_len)
//	END IF
//END IF

IF Trim (ls_title)	<	' '	&
OR Trim (ls_title)	=	'!'	&
OR Trim (ls_title)	=	'?'	THEN
	ls_title				=	'STARS Report'
END IF

dw_banner_page.SetItem (ll_row, 'banner_title', ls_title)

dw_banner_page.Modify ("DataWindow.Zoom=75")

dw_banner_page.SetRedraw (TRUE)

MDI_main_frame.SetMicroHelp ('Scroll down the banner page if you ' + &
							'want to add text.')

SetPointer (Arrow!)

end event

on w_banner_page.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.dw_banner_page=create dw_banner_page
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_banner_page
end on

on w_banner_page.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.dw_banner_page)
end on

event ue_preopen;call super::ue_preopen;
	// Save the datawindow passed to this window
idw	=	Message.PowerObjectParm

end event

type st_1 from statictext within w_banner_page
string accessiblename = "Scroll down the banner page if you want to add text."
string accessibledescription = "Scroll down the banner page if you want to add text."
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 421
integer y = 16
integer width = 1911
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
string text = "Scroll down the banner page if you want to add text."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_cancel from u_cb within w_banner_page
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1303
integer y = 1560
integer width = 361
integer height = 108
integer taborder = 30
string text = "Cancel"
end type

on clicked;CloseWithReturn (Parent,0)
end on

type cb_print from u_cb within w_banner_page
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 891
integer y = 1560
integer width = 361
integer height = 108
integer taborder = 20
string text = "Print"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////
//
//	04/22/03	GaryR	Track 3508d	PDR Title page clean-up
//	08/20/03	GaryR	Track 3627d	Link client names with logos
//	12/13/04	GaryR	Track 4108d	Dynamic Report Options
//	12/29/04	GaryR	Track 4108d	Allow Title Page in Saved Reports
//
//////////////////////////////////////////////////////////////////

Integer	li_printed
Long		ll_job
n_ds_titlepage		lds_titlepage

SetPointer (HourGlass!)

IF fx_disclaimer() <> 1 THEN Return

MDI_main_frame.SetMicroHelp ('Printing banner page and report...')

dw_banner_page.AcceptText()

dw_banner_page.Modify ("DataWindow.Zoom=100")

ll_job		=	PrintOpen()
li_printed	=	PrintDataWindow (ll_job, dw_banner_page)

//Prompt for PDR Title page 
IF idw.describe("st_report_id.visible") <> '!' THEN
	lds_titlepage = Create n_ds_titlepage
	IF lds_titlepage.Event ue_populate( idw ) > 0 THEN
		li_printed	=	PrintDataWindow (ll_job, lds_titlepage)
	END IF
	
	Destroy lds_titlepage
END IF

li_printed	=	PrintDataWindow (ll_job, idw)

PrintClose (ll_job)

MDI_main_frame.SetMicroHelp ('Ready')

CloseWithReturn (Parent,li_printed)
end event

type dw_banner_page from u_dw within w_banner_page
string accessiblename = "Banner Page"
string accessibledescription = "Banner Page"
accessiblerole accessiblerole = clientrole!
integer y = 120
integer width = 2743
integer height = 1400
integer taborder = 10
string dataobject = "d_banner_page"
boolean hscrollbar = true
boolean vscrollbar = true
end type

