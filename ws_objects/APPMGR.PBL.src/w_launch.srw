$PBExportHeader$w_launch.srw
$PBExportComments$Launch Other Windows Applications (inherited from w_master)
forward
global type w_launch from w_master
end type
type dw_window_apps from u_dw within w_launch
end type
type cb_2 from u_cb within w_launch
end type
type st_1 from statictext within w_launch
end type
type cb_1 from u_cb within w_launch
end type
end forward

shared variables
boolean flag_window1
boolean flag_fish
boolean flag_train
boolean flag_colors
boolean flag_multwin
end variables

global type w_launch from w_master
string accessiblename = "Windows APPs"
string accessibledescription = "Windows APPs"
accessiblerole accessiblerole = windowrole!
integer x = 923
integer y = 468
integer width = 1079
integer height = 992
string title = "Windows APPs"
long backcolor = 67108864
dw_window_apps dw_window_apps
cb_2 cb_2
st_1 st_1
cb_1 cb_1
end type
global w_launch w_launch

event open;call super::open;Long		ll_row

//fx_set_window_colors (w_launch) 


dw_window_apps.SetTransObject(STARS2CA) //NLG 10/14/97 

ll_row	=	dw_window_apps.Retrieve()

COMMIT using STARS2CA;
If Stars2ca.of_check_status() <> 0 Then
	ErrorBox (Stars2ca, 'Error Commiting to Stars2')
	Return
End If	

IF	ll_row	<	1		THEN
	MessageBox ('Window APPs Error', 'There are no Windows Applications' + &
					' to launch.  Have your administrator add these ' + &
					'applications to the codes.')
	Close (this)
   RETURN
End If


end event

on w_launch.create
int iCurrent
call super::create
this.dw_window_apps=create dw_window_apps
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_window_apps
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_1
end on

on w_launch.destroy
call super::destroy
destroy(this.dw_window_apps)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type dw_window_apps from u_dw within w_launch
string accessiblename = "Windows Applications"
string accessibledescription = "Windows Applications"
accessiblerole accessiblerole = clientrole!
integer x = 178
integer y = 12
integer width = 690
integer height = 580
integer taborder = 10
string dataobject = "d_window_apps"
boolean vscrollbar = true
end type

on doubleclicked;call u_dw::doubleclicked;// Run the selected application

String	ls_application,	&
			ls_app_name
Long		ll_row

ll_row	=	This.GetRow()

IF	ll_row	<	1		THEN
	Return
END IF

ls_app_name		=	This.GetItemString (ll_row, 'code_code')
ls_application	=	This.GetItemString (ll_row, 'code_desc')

IF	Run (ls_application)		=	-1		THEN
	MessageBox ('Windows Error', 'Error launching ' + ls_app_name)
END IF


end on

event constructor;call super::constructor;This.of_SingleSelect (TRUE)	//	Single select rows
This.of_SetUpdateable (FALSE)	//	This d/w is not updateable

end event

type cb_2 from u_cb within w_launch
string accessiblename = "Select"
string accessibledescription = "Select"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 155
integer y = 756
integer width = 320
integer height = 108
integer taborder = 30
string text = "Select"
boolean default = true
end type

on clicked;dw_window_apps.TriggerEvent (DoubleClicked!)

end on

type st_1 from statictext within w_launch
string accessiblename = "Double Click an Application"
string accessibledescription = "Double Click an Application"
accessiblerole accessiblerole = statictextrole!
integer x = 55
integer y = 632
integer width = 942
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Double Click an Application"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_launch
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 590
integer y = 756
integer width = 320
integer height = 108
integer taborder = 20
string text = "Close"
boolean cancel = true
end type

on clicked;Close (parent)
end on

