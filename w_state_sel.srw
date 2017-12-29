HA$PBExportHeader$w_state_sel.srw
$PBExportComments$Inherited from w_master
forward
global type w_state_sel from w_master
end type
type st_1 from statictext within w_state_sel
end type
type cb_cancel from u_cb within w_state_sel
end type
type cb_map from u_cb within w_state_sel
end type
type lb_states from listbox within w_state_sel
end type
end forward

global type w_state_sel from w_master
string accessiblename = "State Selection Window"
string accessibledescription = "State Selection Window"
accessiblerole accessiblerole = windowrole!
int X=873
int Y=480
int Width=1161
int Height=964
WindowType WindowType=response!
boolean TitleBar=true
string Title="State Selection"
long BackColor=67108864
st_1 st_1
cb_cancel cb_cancel
cb_map cb_map
lb_states lb_states
end type
global w_state_sel w_state_sel

type variables
// Message.DoubleParm
Long	il_num_states
end variables

event open;call super::open;integer li_x
string lv_state


//fx_set_window_colors(w_state_sel)		// FDG 05/22/96

for li_x=1 to il_num_states
	lv_state = ProfileString(gv_ini_path+"stars.ini","MAP","State"+string(li_x),"")
	if trim(lv_state)<>'' then lb_states.additem(lv_state)
next

end event

on w_state_sel.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_map=create cb_map
this.lb_states=create lb_states
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_map
this.Control[iCurrent+4]=this.lb_states
end on

on w_state_sel.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_map)
destroy(this.lb_states)
end on

event ue_preopen;call super::ue_preopen;il_num_states=message.doubleparm
SetNull (Message.DoubleParm)

end event

type st_1 from statictext within w_state_sel
string accessiblename = "Please select a state to map"
string accessibledescription = "Please select a state to map"
accessiblerole accessiblerole = statictextrole!
int X=128
int Y=36
int Width=873
int Height=72
boolean Enabled=false
string Text="Please select a state to map:"
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

type cb_cancel from u_cb within w_state_sel
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
int X=681
int Y=728
int Width=306
int Height=108
int TabOrder=20
string Text="&Cancel"
end type

on clicked;closewithreturn(parent,'cancel')
end on

type cb_map from u_cb within w_state_sel
string accessiblename = "Map"
string accessibledescription = "Map"
accessiblerole accessiblerole = pushbuttonrole!
int X=155
int Y=728
int Width=306
int Height=108
int TabOrder=30
string Text="&Map"
boolean Default=true
end type

on clicked;string lv_state

lv_state=left(lb_states.selecteditem(),2)
if trim(lv_state)<>'' then
	closewithreturn(parent,lv_state)
else
	messagebox('Error','Please select a state')
end if
end on

type lb_states from listbox within w_state_sel
string accessiblename = "States List"
string accessibledescription = "States List"
accessiblerole accessiblerole = listrole!
int X=91
int Y=128
int Width=951
int Height=528
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=1073741824
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;cb_map.postevent(clicked!)
end on

