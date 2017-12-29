$PBExportHeader$w_about_stars.srw
$PBExportComments$Inherited from w_master
forward
global type w_about_stars from w_master
end type
type shl_3 from statichyperlink within w_about_stars
end type
type shl_2 from statichyperlink within w_about_stars
end type
type shl_1 from statichyperlink within w_about_stars
end type
type st_3 from statictext within w_about_stars
end type
type cb_1 from u_cb within w_about_stars
end type
type mle_1 from multilineedit within w_about_stars
end type
type uo_1 from uo_splash within w_about_stars
end type
end forward

global type w_about_stars from w_master
string accessiblename = "About STARS"
string accessibledescription = "About STARS"
integer x = 1120
integer y = 836
integer width = 1728
integer height = 1680
string title = "About STARS"
windowtype windowtype = response!
shl_3 shl_3
shl_2 shl_2
shl_1 shl_1
st_3 st_3
cb_1 cb_1
mle_1 mle_1
uo_1 uo_1
end type
global w_about_stars w_about_stars

on w_about_stars.create
int iCurrent
call super::create
this.shl_3=create shl_3
this.shl_2=create shl_2
this.shl_1=create shl_1
this.st_3=create st_3
this.cb_1=create cb_1
this.mle_1=create mle_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.shl_3
this.Control[iCurrent+2]=this.shl_2
this.Control[iCurrent+3]=this.shl_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.mle_1
this.Control[iCurrent+7]=this.uo_1
end on

on w_about_stars.destroy
call super::destroy
destroy(this.shl_3)
destroy(this.shl_2)
destroy(this.shl_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.uo_1)
end on

type shl_3 from statichyperlink within w_about_stars
string accessiblename = "STARS Server Hyperlink"
string accessibledescription = "STARS Server Hyperlink"
accessiblerole accessiblerole = linkrole!
integer x = 457
integer y = 612
integer width = 731
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "STARS Server Information"
alignment alignment = right!
boolean focusrectangle = false
end type

event constructor;// 09/02/2005	Katie	Track 4503d Added code to create the STARS Server Information hyperlink based on
//					the server the front-end is connected to.
//	04/25/07		GaryR	Track 5001	Launch Release Notes on the server

String ls_url

ls_url = gnv_app.of_get_server_url() + '/STARServerInfo'
shl_3.URL=ls_url
end event

type shl_2 from statichyperlink within w_about_stars
string accessiblename = "ViPS Assist Hyperlink"
string accessibledescription = "ViPS Assist Hyperlink"
accessiblerole accessiblerole = linkrole!
integer x = 1010
integer y = 688
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "VIPSAssist"
alignment alignment = right!
boolean focusrectangle = false
string url = "http://www.vipsassist.com/Assist/Stars.nsf/homepage?openform"
end type

type shl_1 from statichyperlink within w_about_stars
string accessiblename = "ViPS, Inc Hyperlink"
string accessibledescription = "ViPS, Inc Hyperlink"
accessiblerole accessiblerole = linkrole!
integer x = 274
integer y = 688
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "ViPS, Inc"
boolean focusrectangle = false
string url = "http://www.vips.com"
end type

type st_3 from statictext within w_about_stars
string accessiblename = "Copyright"
string accessibledescription = "Copyright 2008"
accessiblerole accessiblerole = statictextrole!
integer x = 571
integer y = 1092
integer width = 489
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copyright 2009"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_about_stars
string accessiblename = "OK"
string accessibledescription = "OK"
integer x = 645
integer y = 1212
integer width = 338
integer height = 108
integer taborder = 30
integer textsize = -9
integer weight = 400
string text = "OK"
boolean default = true
end type

on clicked;close(parent)
end on

type mle_1 from multilineedit within w_about_stars
string accessiblename = "Copyright Information"
string accessibledescription = "Copyright Information"
accessiblerole accessiblerole = textrole!
integer x = 137
integer y = 776
integer width = 1358
integer height = 268
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "This Software is the Proprietary and  Confidential Property of ViPS, Inc.   Unless a written license is obtained from ViPS, Inc., possession of the Software does not confer any right to use or disclose such Software or any portion thereof.  All rights under applicable copyright laws are reserved. "
boolean border = false
alignment alignment = center!
end type

type uo_1 from uo_splash within w_about_stars
string accessiblename = "Stars Logo"
string accessibledescription = "Stars Logo"
integer x = 274
integer y = 56
integer taborder = 10
boolean enabled = false
end type

on uo_1.destroy
call uo_splash::destroy
end on

