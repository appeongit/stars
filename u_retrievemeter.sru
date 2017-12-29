HA$PBExportHeader$u_retrievemeter.sru
$PBExportComments$Visual UO to display progress via .BMP (inherited from u_base) <gui>
forward
global type u_retrievemeter from u_base
end type
type st_1 from statictext within u_retrievemeter
end type
type st_rowcount from statictext within u_retrievemeter
end type
type st_message from statictext within u_retrievemeter
end type
type cb_cancel from u_cb within u_retrievemeter
end type
end forward

global type u_retrievemeter from u_base
string accessiblename = "Progress Bar"
string accessibledescription = "Progress Bar"
integer width = 1157
integer height = 500
st_1 st_1
st_rowcount st_rowcount
st_message st_message
cb_cancel cb_cancel
end type
global u_retrievemeter u_retrievemeter

type variables
//	RickB				05/06/08		SPR 5335 - Removed ii_Index and ii_MaxIndex.  They're not needed
//														since the retrievemeter bmps are not used.

w_master iw_parent




end variables

forward prototypes
public function integer of_setmessage (string as_message)
protected function integer of_center ()
public subroutine of_progress ()
end prototypes

public function integer of_setmessage (string as_message);this.st_message.Text = as_Message

RETURN 1
end function

protected function integer of_center ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	u_retrievemeter			of_Center				Protected
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Centers the control within the parent window.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument	Datatype	Description
//	---------	--------	--------	-----------
// None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/06/98		Created.
//  RickB				05/05/08		SPR 5335 - Deleted reference to dw_retrievemeter.  Added iw_parent instance
//										variable to get width and height of parent.
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Integer i_Return, i_x = 1, i_y = 1	// default to upper left corner

i_x = iw_Parent.Width - this.Width
i_y =	iw_Parent.Height - this.Height

If i_x > 1 Then
	this.x = i_x / 2
End If

If i_y > 1 Then
	this.y = i_y / 2
End If

RETURN i_Return
end function

public subroutine of_progress ();/////////////////////////////////////////////////////////////////////////////
// Object						Event/Function			Access	
// ------						--------------			------	
//	u_retrievemeter			of_ChangeBmp			Public
/////////////////////////////////////////////////////////////////////////////
// Description
// -----------
//	Changes which .bmp (from right to left) is displayed on the dw.
/////////////////////////////////////////////////////////////////////////////
// PARAMETERS
//	Passed by	Argument				Datatype	Description
//	---------	--------				--------	-----------
// None.
/////////////////////////////////////////////////////////////////////////////
// RETURNS
//	Datatype		Value			Description
//	--------		-----			-----------
//	Integer			1			Success			
/////////////////////////////////////////////////////////////////////////////
// HISTORY
//
//	Author			Date			Description
// ------			----			-----------
//	J.Mattis			02/06/98		Created.
//	GaryR				02/16/04		Track 6028c	Add running row counter
//	RickB				05/05/08		SPR 5335 - Removed references to dw_retrievemeter.  It's not being used
//										anymore as a result of the Section 508 changes.  Also removed code that
//										changed the bmp in retrievemeter.  Changed to Return Type (None) because
//                                           ii_index is not used now that bmps in retrievemeter are not being used.
//	RickB				5/28/08		SPR 5335 - Incremented rowcounter by 1000 to slow the counter down. 
//										The fast counting created flashing text.
//	GaryR				07/11/08		SPR 5335	Refresh rowcounter every row
//
/////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

gv_rowcounter = gv_rowcounter + 1
st_rowcount.text = String(gv_rowcounter)
end subroutine

on u_retrievemeter.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_rowcount=create st_rowcount
this.st_message=create st_message
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_rowcount
this.Control[iCurrent+3]=this.st_message
this.Control[iCurrent+4]=this.cb_cancel
end on

on u_retrievemeter.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_rowcount)
destroy(this.st_message)
destroy(this.cb_cancel)
end on

event constructor;////////////////////////////////////////////////////////////////////////
//
//	GaryR	02/20/04	Track 6028c	Keep a continuous count of rows retrieved
//	RickB				05/05/08		SPR 5335 - Removed reference to dw_retrievemeter.  It's not being used
//										anymore as a result of the Section 508 changes.  Also removed call to 
//										of_changebmp; don't need it anymore.
//	RickB				05/06/08		SPR 5335 - Removed ls_bitmap variable and the pointer to the bmp 
//										in the .ini file -- not needed anymore.  Also removed ll_rows variable.
//	GaryR				05/01/09	GNL.600.5633.005	Section 508 keyboard equivalent
//
////////////////////////////////////////////////////////////////////////

iw_parent = message.PowerObjectParm
this.BringTotop = TRUE
this.of_Center()
cb_cancel.SetFocus()
 

end event

type st_1 from statictext within u_retrievemeter
string accessiblename = "Rows Retrieved"
string accessibledescription = "Rows Retrieved"
accessiblerole accessiblerole = statictextrole!
integer x = 101
integer y = 164
integer width = 517
integer height = 88
integer textsize = -10
integer weight = 700
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rows Retrieved:"
end type

type st_rowcount from statictext within u_retrievemeter
string accessiblename = "Row Count"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
integer x = 727
integer y = 168
integer width = 242
integer height = 88
integer textsize = -10
integer weight = 700
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "0"
alignment alignment = center!
end type

type st_message from statictext within u_retrievemeter
string accessiblename = "Retrieving rows, please wait..."
string accessibledescription = "Retrieving rows, please wait..."
accessiblerole accessiblerole = statictextrole!
integer x = 101
integer y = 40
integer width = 951
integer height = 88
integer textsize = -10
integer weight = 700
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Retrieving rows, please wait..."
end type

type cb_cancel from u_cb within u_retrievemeter
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
integer x = 425
integer y = 312
integer taborder = 20
string text = "&Cancel"
boolean default = true
end type

event clicked;call super::clicked;gv_cancel_but_clicked	=	TRUE
end event

