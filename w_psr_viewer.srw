HA$PBExportHeader$w_psr_viewer.srw
forward
global type w_psr_viewer from w_master
end type
type st_row_count from statictext within w_psr_viewer
end type
type st_1 from statictext within w_psr_viewer
end type
type ddlb_window_operations from u_ddlb within w_psr_viewer
end type
type cb_close from u_cb within w_psr_viewer
end type
type dw_1 from u_dw within w_psr_viewer
end type
end forward

global type w_psr_viewer from w_master
long backcolor = 67108864
string accessiblename = "STARS Report Viewer"
string accessibledescription = "STARS Report Viewer"
accessiblerole accessiblerole = windowrole!
integer width = 2674
integer height = 2096
string title = "STARS Report Viewer"
st_row_count st_row_count
st_1 st_1
ddlb_window_operations ddlb_window_operations
cb_close cb_close
dw_1 dw_1
end type
global w_psr_viewer w_psr_viewer

type variables

end variables

forward prototypes
public subroutine wf_view_psr ()
end prototypes

public subroutine wf_view_psr ();
end subroutine

on w_psr_viewer.create
int iCurrent
call super::create
this.st_row_count=create st_row_count
this.st_1=create st_1
this.ddlb_window_operations=create ddlb_window_operations
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_row_count
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_window_operations
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_1
end on

on w_psr_viewer.destroy
call super::destroy
destroy(this.st_row_count)
destroy(this.st_1)
destroy(this.ddlb_window_operations)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open;call super::open;//--------------------------------------------------------------------------------------// 
// Object:		w_psr_viewer
// Event:		Open
// Parms:		None
// Returns:		None
//--------------------------------------------------------------------------------------// 
// Desc:			STARS Report Viewer window. Displays a PSR file into a data window.
//--------------------------------------------------------------------------------------// 
// Maintenance
//
// Name		Date		Track		Release	 Description
// -------- -------- -------- --------- ------------------------------------------------
// MikeFl	03/28/02 2760		5.1.0.003 Created window.
//
//--------------------------------------------------------------------------------------// 
// Local Variables
string		ls_path
string		ls_file
//--------------------------------------------------------------------------------------// 
//Begin
//--------------------------------------------------------------------------------------// 
IF GetFileOpenName("Import STARS Report", ls_path, ls_file, "psr", "STARS Reports (*.psr),*.psr") = 1 THEN
	dw_1.dataobject 		= ls_path
	st_row_count.text 	= string(dw_1.RowCount())
ELSE
	CLOSE(This)
END IF





end event

type st_row_count from statictext within w_psr_viewer
string accessiblename = "Row Count"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
integer x = 1147
integer y = 1844
integer width = 302
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_psr_viewer
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 1808
integer width = 617
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
string text = "Window Operations"
boolean focusrectangle = false
end type

type ddlb_window_operations from u_ddlb within w_psr_viewer
string accessiblename = "Window Operations"
string accessibledescription = "Window Operations"
long textcolor = 33554432
long backcolor = 1073741824
accessiblerole accessiblerole = comboboxrole!
integer x = 18
integer y = 1880
integer width = 617
integer height = 152
integer taborder = 10
integer textsize = -9
boolean sorted = false
string item[] = {"Sort/Rank","Display Filter","Find","Align"}
end type

event selectionchanged;call super::selectionchanged;CHOOSE CASE ddlb_window_operations.text
	CASE "Sort/Rank"
		Parent.SetMicroHelp("Double Click the Column Headings you want to Sort by")
	CASE "Display Filter"
		Parent.SetMicroHelp("Double Click the Column Headings you want to Filter by")
	CASE "Find"
		Parent.SetMicroHelp("Double Click the Column Headings you want to Search on")
	CASE "Align"
		Parent.SetMicroHelp("Double Click the Column Headings you want to Align")
END CHOOSE

Parent.of_set_is_operation(ddlb_window_operations.text)
Parent.Event ue_set_window_operations()
end event

type cb_close from u_cb within w_psr_viewer
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2213
integer y = 1844
integer taborder = 30
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_1 from u_dw within w_psr_viewer
string accessiblename = "Report Viewer"
string accessibledescription = "Report Viewer"
accessiblerole accessiblerole = clientrole!
integer x = 14
integer y = 32
integer width = 2587
integer height = 1756
integer taborder = 0
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_isupdateable = false
end type

event doubleclicked;call super::doubleclicked;Parent.of_window_operations(This, row, dwo)
end event

