HA$PBExportHeader$w_main_star.srw
$PBExportComments$Inherited from w_master
forward
global type w_main_star from w_master
end type
type p_star from picture within w_main_star
end type
end forward

global type w_main_star from w_master
string accessiblename = "Stars"
string accessibledescription = "Stars"
integer x = 105
integer y = 0
integer width = 3890
integer height = 1828
string title = "Stars"
p_star p_star
end type
global w_main_star w_main_star

event close;call super::close;m_stars_30.m_file.m_star.checked=false
end event

on w_main_star.create
int iCurrent
call super::create
this.p_star=create p_star
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_star
end on

on w_main_star.destroy
call super::destroy
destroy(this.p_star)
end on

event activate;call super::activate;//Anne-S 11-20-97 STARCARE 367 add code so baltimore bitmap does not
//cover open windows
w_main_star.BringToTop = FALSE
end event

event open;call super::open;//DJP - add variable bitmaps
//	05/28/09	GaryR	GNL.600.5715.002	Update the branding graphics

string ls_bitmap
Integer	li_pos

ls_bitmap=ProfileString(gv_ini_path + 'STARS.INI','carrier','bitmap','STARSLogoBig.gif') 
if not fileexists(ls_bitmap) then
	messagebox('Error','Specified background image does not exist.')
	close(this)
	return
end if

p_star.picturename=ls_bitmap
m_stars_30.m_file.m_star.checked=true
end event

type p_star from picture within w_main_star
string accessiblename = "Stars Logo"
string accessibledescription = "Stars Logo"
accessiblerole accessiblerole = graphicrole!
integer x = 645
integer y = 412
integer width = 2610
integer height = 880
boolean originalsize = true
boolean focusrectangle = false
end type

