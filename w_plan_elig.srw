HA$PBExportHeader$w_plan_elig.srw
$PBExportComments$Inherited from w_master
forward
global type w_plan_elig from w_master
end type
type cb_1 from u_cb within w_plan_elig
end type
type mle_desc from multilineedit within w_plan_elig
end type
type sle_ein from singlelineedit within w_plan_elig
end type
type sle_id from singlelineedit within w_plan_elig
end type
type st_4 from statictext within w_plan_elig
end type
type st_3 from statictext within w_plan_elig
end type
type st_2 from statictext within w_plan_elig
end type
end forward

global type w_plan_elig from w_master
string accessiblename = "Plan Eligibility"
string accessibledescription = "Plan Eligibility"
accessiblerole accessiblerole = windowrole!
int X=128
int Y=132
int Width=2661
int Height=1660
boolean TitleBar=true
string Title="PLAN ELIGIBILITY"
long BackColor=67108864
cb_1 cb_1
mle_desc mle_desc
sle_ein sle_ein
sle_id sle_id
st_4 st_4
st_3 st_3
st_2 st_2
end type
global w_plan_elig w_plan_elig

type variables
sx_plan_elig iv_struct_elig
end variables

event open;call super::open;string lv_struct_id, lv_struct_ein, lv_struct_desc


//fx_set_window_colors(w_plan_elig)

lv_struct_id = iv_struct_elig.id
lv_struct_ein = iv_struct_elig.ein
lv_struct_desc = iv_struct_elig.desc

sle_id.text = lv_struct_id
sle_ein.text = lv_struct_ein
mle_desc.text = lv_struct_desc



SetMicroHelp(W_Main,'Ready')

end event

on w_plan_elig.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.mle_desc=create mle_desc
this.sle_ein=create sle_ein
this.sle_id=create sle_id
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.mle_desc
this.Control[iCurrent+3]=this.sle_ein
this.Control[iCurrent+4]=this.sle_id
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
end on

on w_plan_elig.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.mle_desc)
destroy(this.sle_ein)
destroy(this.sle_id)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
end on

event ue_preopen;call super::ue_preopen;
if (not isnull(message.powerobjectparm)) and isvalid(message.powerobjectparm) then
	iv_struct_elig=message.powerobjectparm
	//KMM Clear out message parm (PB Bug)
	SetNull(message.powerobjectparm)
end if

end event

type cb_1 from u_cb within w_plan_elig
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
int X=2185
int Y=1324
int Width=274
int Height=108
int TabOrder=40
string Text="&Close"
boolean Default=true
end type

on clicked;close(w_plan_elig)
end on

type mle_desc from multilineedit within w_plan_elig
string accessiblename = "Plan Description"
string accessibledescription = "Plan Description"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
int X=553
int Y=488
int Width=1993
int Height=616
int TabOrder=30
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
int Limit=255
boolean DisplayOnly=true
long BackColor=1073741824
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_ein from singlelineedit within w_plan_elig
string accessiblename = "Employee Identification Number"
string accessibledescription = "Employee Identification Number"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
int X=558
int Y=380
int Width=416
int Height=88
int TabOrder=20
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
int Limit=10
long BackColor=1073741824
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_id from singlelineedit within w_plan_elig
string accessiblename = "Plan ID"
string accessibledescription = "Plan ID"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
int X=558
int Y=276
int Width=599
int Height=88
int TabOrder=10
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
int Limit=15
long BackColor=1073741824
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_plan_elig
string accessiblename = "Plan Description"
string accessibledescription = "Plan Description"
accessiblerole accessiblerole = statictextrole!
int X=27
int Y=496
int Width=521
int Height=72
boolean Enabled=false
string Text="Plan Description:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=134217741
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_plan_elig
string accessiblename = "Employee Identification Number"
string accessibledescription = "Employee Identification Number"
accessiblerole accessiblerole = statictextrole!
int X=398
int Y=384
int Width=151
int Height=72
boolean Enabled=false
string Text="Ein:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=134217741
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_plan_elig
string accessiblename = "Plan ID"
string accessibledescription = "Plan ID"
accessiblerole accessiblerole = statictextrole!
int X=302
int Y=276
int Width=247
int Height=72
boolean Enabled=false
string Text="Plan Id:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=134217741
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

