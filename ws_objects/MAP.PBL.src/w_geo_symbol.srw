$PBExportHeader$w_geo_symbol.srw
$PBExportComments$Inherited from w_master
forward
global type w_geo_symbol from w_master
end type
type st_2 from statictext within w_geo_symbol
end type
type st_1 from statictext within w_geo_symbol
end type
type em_symbol from editmask within w_geo_symbol
end type
type cb_2 from u_cb within w_geo_symbol
end type
type cb_1 from u_cb within w_geo_symbol
end type
type p_1 from picture within w_geo_symbol
end type
end forward

global type w_geo_symbol from w_master
string accessiblename = "Symbol"
string accessibledescription = "Symbol"
accessiblerole accessiblerole = windowrole!
integer x = 544
integer y = 384
integer width = 1829
integer height = 1144
string title = "Symbol"
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
st_1 st_1
em_symbol em_symbol
cb_2 cb_2
cb_1 cb_1
p_1 p_1
end type
global w_geo_symbol w_geo_symbol

type variables
// Message.Doubleparm
long	il_temp
end variables

event open;call super::open;
em_symbol.text = string(il_temp)

//fx_set_window_colors(w_geo_symbol)		// FDG 05/22/96

setmicrohelp(w_main,'Ready')
end event

on w_geo_symbol.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.em_symbol=create em_symbol
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_symbol
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.p_1
end on

on w_geo_symbol.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_symbol)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_1)
end on

event ue_preopen;call super::ue_preopen;il_temp = message.doubleparm
//KMM Clear out message parm (PB Bug)
SetNull(message.doubleparm)

end event

type st_2 from statictext within w_geo_symbol
string accessiblename = "SYMBOLS"
string accessibledescription = "SYMBOLS"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 677
integer y = 36
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 67108864
boolean enabled = false
string text = "SYMBOLS"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_geo_symbol
string accessiblename = "Enter Choice"
string accessibledescription = "Enter Choice"
accessiblerole accessiblerole = statictextrole!
integer x = 1074
integer y = 304
integer width = 407
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Enter Choice:"
boolean focusrectangle = false
end type

type em_symbol from editmask within w_geo_symbol
string accessiblename = "Enter Symbol Choice"
string accessibledescription = "Enter Symbol Choice"
accessiblerole accessiblerole = textrole!
integer x = 1527
integer y = 284
integer width = 197
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type cb_2 from u_cb within w_geo_symbol
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1426
integer y = 744
integer width = 338
integer height = 108
integer taborder = 30
integer weight = 400
string text = "&Cancel"
end type

on clicked;setmicrohelp(w_main,'Ready')
ClosewithReturn(w_geo_symbol,-1)
end on

type cb_1 from u_cb within w_geo_symbol
string accessiblename = "OK"
string accessibledescription = "OK"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1029
integer y = 744
integer width = 338
integer height = 108
integer taborder = 20
integer weight = 400
string text = "&OK"
boolean default = true
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Returning Symbol...')
if em_symbol.text < '32' or em_symbol.text > '66' then
	messagebox('Symbol Error','Symbol must be between 32 and 66.')
	em_symbol.setfocus()
	setmicrohelp(w_main,'Ready')
	return	
end if
CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end on

type p_1 from picture within w_geo_symbol
string accessibledescription = "Map Symbols"
string accessiblename = "Map Symbols"
accessiblerole accessiblerole = graphicrole!
integer x = 101
integer y = 148
integer width = 855
integer height = 852
string picturename = "sym.bmp"
boolean focusrectangle = false
end type

on clicked;setpointer(hourglass!)

integer x_pic, y_pic, box_size = 100,                 &
 		  x_pos_1 = 33,  x_pos_2 = 161, x_pos_3 = 289,  &
		  x_pos_4 = 417, x_pos_5 = 545, x_pos_6 = 673,  &
   	  y_pos_1 = 33,  y_pos_2 = 165, y_pos_3 = 297,  &
		  y_pos_4 = 429, y_pos_5 = 561, y_pos_6 = 693
 
x_pic = this.pointerX()
y_pic = this.pointerY()

//If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
//	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
//	em_symbol.text = '31'
//	return
//end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '32'
	return
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '33'
	return
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '34'
	return
end if	

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '35'
	return
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '36'
	return
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '37'
	return
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '38'
	return
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '39'
	return
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '40'
	return
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '41'
	return
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '42'
	return
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '43'
	return
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '44'
	return
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '45'
	return
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '46'
	return
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '47'
	return
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '48'
	return
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And & 
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '49'
	return
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '50'
	return
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '51'
	return
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '52'
	return
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '53'
	return
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '54'
	return
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '55'
	return
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '56'
	return
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '57'
	return
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '58'
	return
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '59'
	return
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And & 
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '60'
	return
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '61'
	return
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '62'
	return
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '63'
	return
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '64'
	return
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '65'
	return
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '66'
	return
end if

// MicroHelp if clicked in white area		
end on

on doubleclicked;setpointer(hourglass!)
setmicrohelp(w_main,'Returning Symbol...')
integer x_pic, y_pic, box_size = 100,                 &
 		  x_pos_1 = 33,  x_pos_2 = 161, x_pos_3 = 289,  &
		  x_pos_4 = 417, x_pos_5 = 545, x_pos_6 = 673,  &
   	  y_pos_1 = 33,  y_pos_2 = 165, y_pos_3 = 297,  &
		  y_pos_4 = 429, y_pos_5 = 561, y_pos_6 = 693
 
x_pic = this.pointerX()
y_pic = this.pointerY()


If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '31'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '32'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '33'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '34'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if	

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '35'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_1 And y_pic<=y_pos_1+box_size)) then
	em_symbol.text = '36'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '37'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '38'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '39'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '40'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '41'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_2 And y_pic<=y_pos_2+box_size)) then
	em_symbol.text = '42'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '43'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '44'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '45'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '46'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '47'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_3 And y_pic<=y_pos_3+box_size)) then
	em_symbol.text = '48'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And & 
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '49'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '50'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '51'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '52'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '53'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_4 And y_pic<=y_pos_4+box_size)) then
	em_symbol.text = '54'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '55'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '56'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '57'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '58'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '59'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And & 
	(y_pic>=y_pos_5 And y_pic<=y_pos_5+box_size)) then
	em_symbol.text = '60'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_1 And x_pic<=x_pos_1+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '61'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_2 And x_pic<=x_pos_2+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '62'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_3 And x_pic<=x_pos_3+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '63'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_4 And x_pic<=x_pos_4+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '64'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_5 And x_pic<=x_pos_5+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '65'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if

If ((x_pic>=x_pos_6 And x_pic<=x_pos_6+box_size) And &
	(y_pic>=y_pos_6 And y_pic<=y_pos_6+box_size)) then
	em_symbol.text = '66'
	CloseWithReturn(w_geo_symbol, integer(em_symbol.text))
end if	

// MicroHelp if clicked in white area			
end on

