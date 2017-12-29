HA$PBExportHeader$w_transfer_status.srw
forward
global type w_transfer_status from w_master
end type
type st_table_name from statictext within w_transfer_status
end type
type st_export_name from statictext within w_transfer_status
end type
type st_recs_written from statictext within w_transfer_status
end type
type st_written from statictext within w_transfer_status
end type
type st_recs_error from statictext within w_transfer_status
end type
type st_errors from statictext within w_transfer_status
end type
type st_recs_read from statictext within w_transfer_status
end type
type st_retrieved from statictext within w_transfer_status
end type
type cb_cancel from commandbutton within w_transfer_status
end type
end forward

global type w_transfer_status from w_master
long backcolor = 67108864
string accessiblename = "Transfer Progress"
string accessibledescription = "Transfer Progress"
accessiblerole accessiblerole = windowrole!
integer width = 1070
integer height = 596
string title = "Transfer Progress"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
boolean center = true
st_table_name st_table_name
st_export_name st_export_name
st_recs_written st_recs_written
st_written st_written
st_recs_error st_recs_error
st_errors st_errors
st_recs_read st_recs_read
st_retrieved st_retrieved
cb_cancel cb_cancel
end type
global w_transfer_status w_transfer_status

type variables
u_nvo_pipeline  iu_pipe

boolean ib_ask = TRUE
end variables

forward prototypes
public function integer uf_cancel ()
end prototypes

public function integer uf_cancel ();int		li_rc
boolean 	lb_cancel

IF ib_ask THEN
	li_rc = MessageBox( "Cancel Transfer?", &
					"Closing this window will terminate the transfer~r~r" + &
					"Click OK to terminate, Cancel to continue", &
					Exclamation!, OKCancel!, 1)
					
	IF li_rc = 1 THEN	// Cancel
		iu_pipe.ib_cancelled = TRUE
	ELSE
		RETURN 1
	END IF
	
END IF

iu_pipe.cancel( )
Timer(0, this)

RETURN 0 
	
	
end function

on w_transfer_status.create
int iCurrent
call super::create
this.st_table_name=create st_table_name
this.st_export_name=create st_export_name
this.st_recs_written=create st_recs_written
this.st_written=create st_written
this.st_recs_error=create st_recs_error
this.st_errors=create st_errors
this.st_recs_read=create st_recs_read
this.st_retrieved=create st_retrieved
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_table_name
this.Control[iCurrent+2]=this.st_export_name
this.Control[iCurrent+3]=this.st_recs_written
this.Control[iCurrent+4]=this.st_written
this.Control[iCurrent+5]=this.st_recs_error
this.Control[iCurrent+6]=this.st_errors
this.Control[iCurrent+7]=this.st_recs_read
this.Control[iCurrent+8]=this.st_retrieved
this.Control[iCurrent+9]=this.cb_cancel
end on

on w_transfer_status.destroy
call super::destroy
destroy(this.st_table_name)
destroy(this.st_export_name)
destroy(this.st_recs_written)
destroy(this.st_written)
destroy(this.st_recs_error)
destroy(this.st_errors)
destroy(this.st_recs_read)
destroy(this.st_retrieved)
destroy(this.cb_cancel)
end on

event open;call super::open;IF IsValid(Message.Powerobjectparm) THEN
	iu_pipe = Message.Powerobjectparm
END IF

st_table_name.text = iu_pipe.is_target_table

Timer(2, this)

end event

event timer;call super::timer;st_recs_read.text 	= string(iu_pipe.rowsread)
st_recs_written.text = string(iu_pipe.rowswritten)
st_recs_error.text 	= string(iu_pipe.rowsinerror)
Yield()	// 12/16/04	GaryR	Track 3852d	Allow que'd up messages to execute concurrently
end event

event closequery;call super::closequery;RETURN uf_cancel()
end event

type st_table_name from statictext within w_transfer_status
string accessiblename = "Transfer Table Name"
string accessibledescription = "Transfer Table Name"
accessiblerole accessiblerole = statictextrole!
integer x = 517
integer y = 16
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_export_name from statictext within w_transfer_status
string accessiblename = "Table Name"
string accessibledescription = "Table Name"
accessiblerole accessiblerole = statictextrole!
integer x = 27
integer y = 8
integer width = 384
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Table Name:"
boolean focusrectangle = false
end type

type st_recs_written from statictext within w_transfer_status
string accessiblename = "Number of Records Written"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
integer x = 517
integer y = 196
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
boolean focusrectangle = false
end type

type st_written from statictext within w_transfer_status
string accessiblename = "Rows Processed"
string accessibledescription = "Rows Processed"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 196
integer width = 466
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rows Processed:"
boolean focusrectangle = false
end type

type st_recs_error from statictext within w_transfer_status
string accessiblename = "Number of Records in Error"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
integer x = 517
integer y = 284
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
boolean focusrectangle = false
end type

type st_errors from statictext within w_transfer_status
string accessiblename = "Errors"
string accessibledescription = "Errors"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 284
integer width = 384
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Errors:"
boolean focusrectangle = false
end type

type st_recs_read from statictext within w_transfer_status
string accessiblename = "Number of Records Read"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
integer x = 517
integer y = 104
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
boolean focusrectangle = false
end type

type st_retrieved from statictext within w_transfer_status
string accessiblename = "Rows Read"
string accessibledescription = "Rows Read"
accessiblerole accessiblerole = statictextrole!
integer x = 32
integer y = 100
integer width = 384
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rows Read:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_transfer_status
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 347
integer y = 380
integer width = 347
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;ib_ask 		 			= FALSE
iu_pipe.ib_cancelled = TRUE
uf_cancel()

end event

