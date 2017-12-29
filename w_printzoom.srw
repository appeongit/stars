HA$PBExportHeader$w_printzoom.srw
$PBExportComments$Print zoom options window (inherited from w_master)
forward
global type w_printzoom from w_master
end type
type st_2 from statictext within w_printzoom
end type
type cbx_print_preview from checkbox within w_printzoom
end type
type st_4 from statictext within w_printzoom
end type
type st_1 from statictext within w_printzoom
end type
type em_custom from editmask within w_printzoom
end type
type pb_cancel_preview from picturebutton within w_printzoom
end type
type cbx_rulers from checkbox within w_printzoom
end type
type st_percent from statictext within w_printzoom
end type
type cb_ok from u_cb within w_printzoom
end type
type cb_cancel from u_cb within w_printzoom
end type
type rb_custom from radiobutton within w_printzoom
end type
type rb_30 from radiobutton within w_printzoom
end type
type rb_65 from radiobutton within w_printzoom
end type
type rb_100 from radiobutton within w_printzoom
end type
type rb_200 from radiobutton within w_printzoom
end type
type gb_1 from groupbox within w_printzoom
end type
end forward

global type w_printzoom from w_master
string accessiblename = "Report Zoom"
string accessibledescription = "Report Zoom"
accessiblerole accessiblerole = windowrole!
integer x = 535
integer y = 420
integer width = 1778
integer height = 1080
string title = "Report Zoom"
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
cbx_print_preview cbx_print_preview
st_4 st_4
st_1 st_1
em_custom em_custom
pb_cancel_preview pb_cancel_preview
cbx_rulers cbx_rulers
st_percent st_percent
cb_ok cb_ok
cb_cancel cb_cancel
rb_custom rb_custom
rb_30 rb_30
rb_65 rb_65
rb_100 rb_100
rb_200 rb_200
gb_1 gb_1
end type
global w_printzoom w_printzoom

type variables
datawindow idw
end variables

forward prototypes
public function string wf_get_token (ref string source, string separator)
public subroutine wf_initialize_pct (string as_pct)
end prototypes

public function string wf_get_token (ref string source, string separator);// String Function wf_get_token(ref string Source, string Separator)

// The function Get_Token receive, as arguments, the string from which
// the token is to be stripped off, from the left, and the separator
// character.  If the separator character does not appear in the string,
// it returns the entire string.  Otherwise, it returns the token, not
// including the separator character.  In either case, the source string
// is truncated on the left, by the length of the token and separator
// character, if any.


int 		p
string 	ret

p = Pos(source, separator)	// Get the position of the separator

if p = 0 then					// if no separator, 
	ret = source				// return the whole source string and
	source = ""					// make the original source of zero length
else
	ret = Mid(source, 1, p - 1)	// otherwise, return just the token and
	source = Right(source, Len(source) - p)	// strip it & the separator
end if

return ret
end function

public subroutine wf_initialize_pct (string as_pct);
Choose Case as_pct

	Case '200'
		rb_200.checked = true
		rb_200.triggerevent(clicked!)

	Case '100'
		rb_100.checked = true
		rb_100.triggerevent(clicked!)

	Case '65'
		rb_65.checked = true
		rb_65.triggerevent(clicked!)

	Case '30'
		rb_30.checked = true
		rb_30.triggerevent(clicked!)

	Case else
		rb_custom.checked = true
		IF	Long (as_pct) > 0	and Long (as_pct) < 201		THEN
			em_custom.text = as_pct
		ELSE
			em_custom.text = '50'
		END IF
		rb_custom.TriggerEvent (Clicked!)

End Choose

end subroutine

event open;call super::open;//	Open
Boolean	lb_preview
String	ls_tmp, ls_yes, ls_zoom,	ls_describe
Integer	li_pct

ls_tmp = idw.Describe('DataWindow.Print.Preview DataWindow.Print.Preview.rulers DataWindow.Print.Preview.Zoom')
lb_preview = ('yes' = wf_get_token(ls_tmp,'~n'))

	// If the window was already in print preview mode, disable and check
	//	the print preview checkbox.

IF	lb_preview	=	TRUE		THEN
	cbx_print_preview.checked		=	TRUE
	cbx_print_preview.enabled		=	FALSE
END IF

ls_zoom = idw.Describe('DataWindow.Zoom')
li_pct	=	Integer (ls_zoom)

cbx_rulers.checked = ('yes' = wf_get_token(ls_tmp,'~n'))

IF	li_pct	<>	100		THEN
	ls_tmp		=	ls_zoom
	lb_preview	=	TRUE
END IF

pb_cancel_preview.enabled = lb_preview

em_custom.enabled	=	TRUE
em_custom.text		=	'50'

wf_initialize_pct (ls_tmp)
end event

on w_printzoom.create
int iCurrent
call super::create
this.st_2=create st_2
this.cbx_print_preview=create cbx_print_preview
this.st_4=create st_4
this.st_1=create st_1
this.em_custom=create em_custom
this.pb_cancel_preview=create pb_cancel_preview
this.cbx_rulers=create cbx_rulers
this.st_percent=create st_percent
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.rb_custom=create rb_custom
this.rb_30=create rb_30
this.rb_65=create rb_65
this.rb_100=create rb_100
this.rb_200=create rb_200
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cbx_print_preview
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_custom
this.Control[iCurrent+6]=this.pb_cancel_preview
this.Control[iCurrent+7]=this.cbx_rulers
this.Control[iCurrent+8]=this.st_percent
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.rb_custom
this.Control[iCurrent+12]=this.rb_30
this.Control[iCurrent+13]=this.rb_65
this.Control[iCurrent+14]=this.rb_100
this.Control[iCurrent+15]=this.rb_200
this.Control[iCurrent+16]=this.gb_1
end on

on w_printzoom.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cbx_print_preview)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.em_custom)
destroy(this.pb_cancel_preview)
destroy(this.cbx_rulers)
destroy(this.st_percent)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.rb_custom)
destroy(this.rb_30)
destroy(this.rb_65)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.gb_1)
end on

event ue_preopen;call super::ue_preopen;
idw = Message.PowerObjectParm

end event

type st_2 from statictext within w_printzoom
string accessiblename = "PAGE LAYOUT NOTES"
string accessibledescription = " is not permitted."
accessiblerole accessiblerole = statictextrole!
integer x = 160
integer y = 860
integer width = 512
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " is not permitted."
boolean focusrectangle = false
end type

type cbx_print_preview from checkbox within w_printzoom
string accessiblename = "View as Page Layout?"
string accessibledescription = "View as Page Layout?"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 983
integer y = 512
integer width = 750
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "View as Page Layout?"
end type

on clicked;IF	This.checked			=	TRUE		THEN
	cbx_rulers.enabled	=	TRUE
	rb_custom.checked		=	TRUE
	em_custom.text			=	'55'
	rb_custom.TriggerEvent (Clicked!)
ELSE
	cbx_rulers.checked	=	FALSE
	cbx_rulers.enabled	=	FALSE
END IF

end on

type st_4 from statictext within w_printzoom
string accessiblename = "PAGE LAYOUT NOTES"
string accessibledescription = "1. Only one page will display and scrolling"
accessiblerole accessiblerole = statictextrole!
integer x = 91
integer y = 780
integer width = 1774
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "1. Only one page will display and scrolling"
boolean focusrectangle = false
end type

type st_1 from statictext within w_printzoom
string accessiblename = "PAGE LAYOUT NOTES"
string accessibledescription = "PAGE LAYOUT NOTES"
accessiblerole accessiblerole = statictextrole!
integer x = 91
integer y = 676
integer width = 754
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "PAGE LAYOUT NOTES:"
boolean focusrectangle = false
end type

type em_custom from editmask within w_printzoom
string accessiblename = "Custom Magnification Selection"
string accessibledescription = "Custom Magnification Selection"
accessiblerole accessiblerole = textrole!
event spun pbm_enchange
integer x = 535
integer y = 456
integer width = 242
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
string text = "50"
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 5
string minmax = "1~~1000"
end type

on spun;rb_custom.Checked = true

end on

type pb_cancel_preview from picturebutton within w_printzoom
string accessiblename = "Cancel Zoom"
string accessibledescription = "Cancel Zoom"
long textcolor = 33554432
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1111
integer y = 296
integer width = 325
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string text = "Cancel &Zoom"
vtextalign vtextalign = multiline!
long backcolor = 67108864
end type

on clicked;//	Clicked

String	ls_tmp,	ls_zoom
Integer	li_pct

SetPointer(HourGlass!)

ls_tmp = "DataWindow.Print.Preview = no DataWindow.Print.Preview.Zoom=100"
ls_zoom = idw.Describe('DataWindow.Zoom')
li_pct	=	Integer (ls_zoom)

IF	li_pct	<>	100	THEN
	ls_tmp	=	ls_tmp	+	" DataWindow.Zoom=100"
END IF

idw.Modify(ls_tmp)

	// If the d/w was previously enabled before going into print preview
	// mode, print preview mode disabled the d/w.  When this occurs, the
	//	d/w must be enabled again.

IF	gb_print_preview_enabled		THEN
	idw.enabled		=	TRUE
END IF

gb_print_preview_enabled	=	FALSE

Close(Parent)	 
end on

type cbx_rulers from checkbox within w_printzoom
string accessiblename = "Show Rulers?"
string accessibledescription = "Show Rulers?"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 983
integer y = 604
integer width = 576
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Show Rulers?"
end type

on clicked;IF	This.checked			=	TRUE		THEN
	rb_custom.checked		=	TRUE
	em_custom.text			=	'50'
	rb_custom.TriggerEvent (Clicked!)
END IF

end on

type st_percent from statictext within w_printzoom
string accessiblename = "%"
string accessibledescription = "%"
accessiblerole accessiblerole = statictextrole!
integer x = 782
integer y = 472
integer width = 55
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_printzoom
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1111
integer y = 32
integer width = 320
integer height = 112
integer taborder = 20
string text = "&OK"
boolean default = true
end type

event clicked;//	Clicked
// FDG	07/26/00	Track 2141c.  Stars 4.5 SP1.  Make the datawindow 'ReadOnly'
//						instead of disabling it so the user can scroll while in
//						Print Preview Mode

String	ls_tmp
String	ls_preview
String	ls_rc
Boolean	lb_preview

	// If the d/w was already in print preview mode, don't reset
	//	gb_print_preview_enabled because this may have already been set
	// to true.

ls_tmp = idw.Describe('DataWindow.Print.Preview DataWindow.Print.Preview.rulers DataWindow.Print.Preview.Zoom')
lb_preview = ('yes' = wf_get_token(ls_tmp,'~n'))

IF	lb_preview	<>	TRUE		THEN
	gb_print_preview_enabled	=	FALSE
END IF

ls_preview = "DataWindow.Zoom=" + em_custom.text


	// If putting the window in print preview mode, see if the d/w
	//	is enabled.  If so, disable it so the user cannot select any
	// rows.  Print preview mode will cause any selected rows to
	//	disappear.

IF	cbx_print_preview.checked		=	TRUE		THEN
	IF	idw.enabled						=	TRUE		THEN
		//idw.enabled						=	FALSE					// FDG 07/27/00
		ls_rc	=	idw.Modify ('datawindow.readonly = yes')	// FDG 07/27/00
		gb_print_preview_enabled	=	TRUE
		idw.SelectRow (0, FALSE)
	END IF
	ls_tmp = "DataWindow.Zoom=100 " + &
			"DataWindow.Print.Preview.Zoom=" + em_custom.text + &
			" DataWindow.Print.Preview = yes DataWindow.Print.Preview.rulers = "
	IF cbx_rulers.checked then 
		ls_tmp = ls_tmp + "yes"
	ELSE
		ls_tmp = ls_tmp + 'no'
	END IF
ELSE
	ls_tmp	=	ls_preview
END IF

SetPointer(HourGlass!)

ls_rc	=	idw.Modify (ls_tmp)

Close(Parent)	 
end event

type cb_cancel from u_cb within w_printzoom
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1111
integer y = 164
integer width = 320
integer height = 112
integer taborder = 60
string text = "&Cancel"
boolean cancel = true
end type

on clicked;Close(Parent)
end on

type rb_custom from radiobutton within w_printzoom
string accessiblename = " Custom"
string accessibledescription = " Custom"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 178
integer y = 476
integer width = 334
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = " C&ustom"
boolean checked = true
end type

on clicked;em_custom.enabled	=	TRUE
em_custom.SetFocus()
end on

type rb_30 from radiobutton within w_printzoom
string accessiblename = " 30 %"
string accessibledescription = " 30 %"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 178
integer y = 384
integer width = 256
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = " &30 %"
end type

on clicked;em_custom.text = '30'
end on

type rb_65 from radiobutton within w_printzoom
string accessiblename = " 65 %"
string accessibledescription = " 65 %"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 178
integer y = 296
integer width = 256
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = " &65 %"
end type

on clicked;em_custom.text = '65'
end on

type rb_100 from radiobutton within w_printzoom
string accessiblename = "100 %"
string accessibledescription = "100 %"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 178
integer y = 208
integer width = 288
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "&100 %"
end type

on clicked;em_custom.text = '100'
end on

type rb_200 from radiobutton within w_printzoom
string accessiblename = "200 %"
string accessibledescription = "200 %"
accessiblerole accessiblerole = radiobuttonrole!
integer x = 178
integer y = 120
integer width = 270
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "&200 %"
end type

on clicked;em_custom.text = '200'

end on

type gb_1 from groupbox within w_printzoom
string accessiblename = "Magnification"
string accessibledescription = "Magnification"
accessiblerole accessiblerole = groupingrole!
integer x = 123
integer y = 40
integer width = 763
integer height = 548
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Magnification"
end type

