$PBExportHeader$w_stars_team.srw
forward
global type w_stars_team from w_master
end type
type cb_1 from commandbutton within w_stars_team
end type
type p_1 from picture within w_stars_team
end type
end forward

global type w_stars_team from w_master
long backcolor = 67108864
string accessiblename = "STARS Team"
string accessibledescription = "STARS Team"
accessiblerole accessiblerole = windowrole!
integer width = 2272
integer height = 1760
string title = "STARS Team"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean ib_disableresize = true
cb_1 cb_1
p_1 p_1
end type
global w_stars_team w_stars_team

on w_stars_team.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.p_1
end on

on w_stars_team.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.p_1)
end on

type cb_1 from commandbutton within w_stars_team
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1787
integer y = 1516
integer width = 457
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
boolean cancel = true
boolean default = true
end type

event clicked;Close( PARENT )
end event

type p_1 from picture within w_stars_team
string accessibledescription = "STARS Team Photo"
string accessiblename = "STARS Team Photo "
accessiblerole accessiblerole = graphicrole!
integer x = 5
integer width = 2240
integer height = 1492
string picturename = "steam.jpg"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

