HA$PBExportHeader$w_master_status.srw
forward
global type w_master_status from window
end type
type st_status from statictext within w_master_status
end type
type st_description from statictext within w_master_status
end type
type hpb_status from hprogressbar within w_master_status
end type
type cb_cancel from commandbutton within w_master_status
end type
end forward

global type w_master_status from window
string accessiblename = "Processing"
string accessibledescription = "Processing..."
accessiblerole accessiblerole = windowrole!
integer width = 1221
integer height = 512
boolean titlebar = true
string title = "Processing..."
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
boolean center = true
st_status st_status
st_description st_description
hpb_status hpb_status
cb_cancel cb_cancel
end type
global w_master_status w_master_status

type variables

boolean	ib_cancelled, ib_prompt
long		il_max
string	is_metric

end variables

forward prototypes
public subroutine uf_step (long al_row)
public subroutine uf_initialize (long al_max, string as_metric)
public function integer uf_cancel ()
end prototypes

public subroutine uf_step (long al_row);//===================================================================================================//
// Object		w_master_status
// Function		uf_step		Public
// Arguments	as_low		Long		Current row number
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Changes progress display
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4206d	Created
//===================================================================================================//

hpb_status.position = al_row

st_status.text = "Processing " + is_metric + " " + string(al_row) + " of " + string(il_max)

yield()



end subroutine

public subroutine uf_initialize (long al_max, string as_metric);//===================================================================================================//
// Object		w_master_status
// Function		uf_initialize	Public
// Arguments	al_max			Long		Upperbound for progress bar
//					as_metric		String	Unit of measure for processing (row, month, etc...)
// Returns		None
// ------------------------------------------------------------------------------------------------- //
// Changes progress display
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4206d	Created
//===================================================================================================//

hpb_status.maxposition = al_max
hpb_status.setrange(0, al_max)
hpb_status.OffSetPos(0)

il_max 		= al_max
is_metric 	= as_metric

this.setredraw( TRUE )
end subroutine

public function integer uf_cancel ();//===================================================================================================//
// Object		w_master_status
// Function		uf_cancel		Public
// Arguments	None
// Returns		Integer	0 to let
// ------------------------------------------------------------------------------------------------- //
// Changes progress display
//===================================================================================================//
// Maintenance
// --------	----- -------- -------------------------------------------------------------------------
//	04/19/05	MikeF	SPR4206d	Created
//===================================================================================================//

IF ib_prompt THEN
	ib_cancelled = MessageBox("Cancel Request","Cancel Current Operation?", Question!, YesNo!) = 1 
ELSE
	ib_cancelled = TRUE
END IF

IF ib_cancelled THEN RETURN 0

RETURN 1
end function

on w_master_status.create
this.st_status=create st_status
this.st_description=create st_description
this.hpb_status=create hpb_status
this.cb_cancel=create cb_cancel
this.Control[]={this.st_status,&
this.st_description,&
this.hpb_status,&
this.cb_cancel}
end on

on w_master_status.destroy
destroy(this.st_status)
destroy(this.st_description)
destroy(this.hpb_status)
destroy(this.cb_cancel)
end on

event closequery;RETURN this.uf_cancel()



end event

type st_status from statictext within w_master_status
string accessiblename = "Progress"
string accessibledescription = "Progress"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 196
integer width = 1147
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_description from statictext within w_master_status
string accessiblename = "Progress Description"
string accessibledescription = "Progress Description"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 24
integer width = 1147
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_status from hprogressbar within w_master_status
string accessiblename = "Progress Bar"
string accessibledescription = "Progress Bar"
accessiblerole accessiblerole = progressbarrole!
integer x = 27
integer y = 116
integer width = 1147
integer height = 64
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
boolean smoothscroll = true
end type

type cb_cancel from commandbutton within w_master_status
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 421
integer y = 300
integer width = 343
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Cancel"
end type

event clicked;parent.uf_cancel()
end event

