$PBExportHeader$w_report_options.srw
forward
global type w_report_options from w_master
end type
type cb_apply from u_cb within w_report_options
end type
type cb_cancel from u_cb within w_report_options
end type
type uo_report_options from u_report_options within w_report_options
end type
end forward

global type w_report_options from w_master
long backcolor = 67108864
string accessiblename = "Report Options"
string accessibledescription = "Report Options"
accessiblerole accessiblerole = windowrole!
integer width = 3122
integer height = 1808
string title = "Report Options"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
cb_apply cb_apply
cb_cancel cb_cancel
uo_report_options uo_report_options
end type
global w_report_options w_report_options

type variables
// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
sx_dw_format	isx_format
end variables

on w_report_options.create
int iCurrent
call super::create
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
this.uo_report_options=create uo_report_options
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_apply
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.uo_report_options
end on

on w_report_options.destroy
call super::destroy
destroy(this.cb_apply)
destroy(this.cb_cancel)
destroy(this.uo_report_options)
end on

event ue_preopen;call super::ue_preopen;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save

String	ls_text
Integer	li_pdr_flags
Boolean	lb_subset
u_dw		ldw_requestor

IF Message.PowerObjectParm.TypeOf() <> Datawindow! THEN Return

ldw_requestor = Message.PowerObjectParm
SetNull( Message.PowerObjectParm )
uo_report_options.of_register( ldw_requestor )

//	Get pdr_flags
ls_text = ldw_requestor.Describe( "t_format_flags.text" )
IF ls_text = "!" THEN
	li_pdr_flags = 0
ELSE
	li_pdr_flags = Long( ls_text )
END IF

//	Get subset
ls_text = ldw_requestor.Describe( "st_subset.text" )
lb_subset = ls_text <> "!"

isx_format = uo_report_options.of_init( li_pdr_flags, lb_subset )
uo_report_options.of_set( isx_format )
end event

type cb_apply from u_cb within w_report_options
string accessiblename = "Apply"
string accessibledescription = "Apply"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2459
integer y = 1612
integer taborder = 20
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "Apply"
end type

event clicked;call super::clicked;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save

sx_dw_format	lsx_format

lsx_format.criteria = isx_format.criteria
lsx_format.report_date = isx_format.report_date
lsx_format.report_id = isx_format.report_id
lsx_format.report_name = isx_format.report_name
lsx_format.subset = isx_format.subset
lsx_format.inv_type = isx_format.inv_type

uo_report_options.of_apply( lsx_format )
CloseWithReturn( Parent, 1 )
end event

type cb_cancel from u_cb within w_report_options
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2779
integer y = 1612
integer taborder = 20
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "Cancel"
end type

event clicked;call super::clicked;// 12/11/04 GaryR	Track 4147d	Modify report options and editable columns and save
Close( Parent )
end event

type uo_report_options from u_report_options within w_report_options
string accessiblename = "Report Options"
string accessibledescription = "Report Options"
long backcolor = 67108864
accessiblerole accessiblerole = clientrole!
integer taborder = 20
end type

on uo_report_options.destroy
call u_report_options::destroy
end on

