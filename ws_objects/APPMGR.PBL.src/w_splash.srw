$PBExportHeader$w_splash.srw
$PBExportComments$Inherited from w_master
forward
global type w_splash from w_master
end type
type uo_1 from uo_splash within w_splash
end type
end forward

global type w_splash from w_master
string accessiblename = "Splash Window"
string accessibledescription = "Splash Window"
long backcolor = 67108864
accessiblerole accessiblerole = windowrole!
integer x = 1627
integer y = 1272
integer width = 1088
integer height = 532
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean toolbarvisible = false
uo_1 uo_1
end type
global w_splash w_splash

type variables
// 04/29/08 RickB SPR 5335  Added integer counter variable.

integer ii_timer_ctr

end variables

on w_splash.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_splash.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;//	Override the ancestor

// Make sure this window in front of all others

//	Track 1080- Center the window

This.BringToTop = TRUE

This.of_SetBase (TRUE)			//	Enable the base window service
inv_base.of_center()				// Center the window\











end event

event timer;call super::timer;// 04/29/08 RickB  Added code for timer using the variable for the delay value in STARS.ini.

if ii_timer_ctr < uo_1.ii_accessible_delay then
	ii_timer_ctr ++
else
	close(this)
end if
end event

type uo_1 from uo_splash within w_splash
long backcolor = 67108864
string accessibledescription = "STARS Logo"
accessiblerole accessiblerole = clientrole!
string accessiblename = "STARS Logo"
integer taborder = 1
end type

on uo_1.destroy
call uo_splash::destroy
end on

