$PBExportHeader$uo_splash.sru
$PBExportComments$visual user object containing the splash bitmap <gui>
forward
global type uo_splash from userobject
end type
type st_delay_msg from statictext within uo_splash
end type
type st_version from statictext within uo_splash
end type
type p_bitmap from picture within uo_splash
end type
end forward

global type uo_splash from userobject
string accessiblename = "Splash"
string accessibledescription = "Splash"
accessiblerole accessiblerole = clientrole!
integer width = 1079
integer height = 524
long backcolor = 67108864
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 553648127
st_delay_msg st_delay_msg
st_version st_version
p_bitmap p_bitmap
end type
global uo_splash uo_splash

type variables

//	RickB		SPR 5335	Section 508 variables.

PUBLIC integer ii_accessible_delay
string is_accessible_msg
end variables

on uo_splash.create
this.st_delay_msg=create st_delay_msg
this.st_version=create st_version
this.p_bitmap=create p_bitmap
this.Control[]={this.st_delay_msg,&
this.st_version,&
this.p_bitmap}
end on

on uo_splash.destroy
destroy(this.st_delay_msg)
destroy(this.st_version)
destroy(this.p_bitmap)
end on

event constructor;// 01/19/05 MikeF SPR4228d Change the way we get the version
// 04/29/08 RickB  SPR 5335 - Added code to call a timer and set it to the delay value in STARS.ini.
//                                         Also put the delay message string from STARS.ini into a static text field
//                                         gave it the focus so the screen reader can read it when it is set to read
//                                         highlighted fields only.  Maxed out timer at 99 seconds in case customer
//                                         enters something too big by mistake.
// 05/05/08  RickB  SPR 5335  Made global variables instance variables.
// 05/05/08  RickB  SPR 5335  Added line of code that assigns the accessibility message from the .ini file 
//										to the message variable is_accessible_msg.
//	05/28/09	GaryR	GNL.600.5715.002	Update the branding graphics

String	ls_bitmap
Date		ld_compile = Today()

// GaryR - Change only the SP and Build Version as needed.
//	The date will automatically reflect the date of the build.
st_version.text = gnv_app.of_get_build() + "   " + String( ld_compile, "mm/dd/yyyy" )

ls_bitmap = ProfileString( gv_ini_path + "STARS.INI", "carrier", "bitmap", 'STARSLogoBig.gif' ) 
IF FileExists( ls_bitmap ) THEN p_bitmap.PictureName =  ls_bitmap

ii_accessible_delay = ProfileInt( gv_ini_path + "STARS.INI", "Accessibility", "Delay", 0)
is_accessible_msg = ProfileString( gv_ini_path + "STARS.INI", "Accessibility", "Message", "")

if ii_accessible_delay < 1 then 
	ii_accessible_delay = 1
	timer(ii_accessible_delay)
else
	if ii_accessible_delay > 99 then ii_accessible_delay = 99
	st_delay_msg.text = is_accessible_msg
	st_delay_msg.setfocus( )
	timer(1, w_splash)
end if

end event

type st_delay_msg from statictext within uo_splash
string accessiblename = "Accessibility User Message"
string accessibledescription = "Accessibility User Message"
accessiblerole accessiblerole = statictextrole!
integer x = 14
integer y = 676
integer width = 2354
integer height = 580
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_version from statictext within uo_splash
string accessiblename = "Change version in constructor script."
string accessibledescription = "Change version in constructor script."
accessiblerole accessiblerole = statictextrole!
integer y = 448
integer width = 1079
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "TFArdent"
long textcolor = 134217742
long backcolor = 134217741
boolean enabled = false
string text = "Change version in constructor script."
alignment alignment = center!
boolean focusrectangle = false
end type

type p_bitmap from picture within uo_splash
string accessiblename = "STARS Logo"
string accessibledescription = "STARS Logo"
accessiblerole accessiblerole = graphicrole!
integer width = 1079
integer height = 448
boolean focusrectangle = false
end type

event constructor;//	uo_splash::constructor()
//	Set the version and version date 
//	
//	08-09-09	NLG	Created
// 11-05-99 NLG	Comment this event - The date on splash/About
//						should be the date the exe was created
///////////////////////////////////////////////////////////////////////////


//string ls_version, ls_version_date
//
//ls_version = gnv_app.of_get_version()
//ls_version_date = gnv_app.of_get_version_date()
//st_version.text = 'Version ' + ls_version + ' ' + ls_version_date
end event

