HA$PBExportHeader$w_select_box.srw
$PBExportComments$Inherited from w_master
forward
global type w_select_box from w_master
end type
type dw_1 from u_dw within w_select_box
end type
type st_row_count from statictext within w_select_box
end type
type cb_stop from u_cb within w_select_box
end type
type cb_exit from u_cb within w_select_box
end type
type cb_select from u_cb within w_select_box
end type
end forward

global type w_select_box from w_master
string accessiblename = "Select List"
string accessibledescription = "Select List"
accessiblerole accessiblerole = windowrole!
integer x = 594
integer y = 284
integer width = 1737
integer height = 1344
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
st_row_count st_row_count
cb_stop cb_stop
cb_exit cb_exit
cb_select cb_select
end type
global w_select_box w_select_box

type variables
int in_row_nbr,in_nbr_rows

end variables

forward prototypes
private function integer fx_get_filter ()
end prototypes

private function integer fx_get_filter ();string lv_filter_value,lv_idx = '0'

If gv_selection1 = '' then
	RETURN -1 
End If

gv_selection2 = ''
Declare filter_c cursor for
	Select fltr_key from filter
		where fltr_id = Upper( :gv_selection1 ) and
				fltr_status <> 'C'
using stars2ca;

Open filter_c;
If stars2ca.of_check_status() <> 0 then
	gv_selection1 = ''
	RETURN -1
End IF	

Do while stars2ca.sqlcode = 0 
	Fetch filter_c into :lv_filter_value;
	If stars2ca.of_check_status() = 100 then
		Exit
	Elseif stars2ca.sqlcode <> 0 then
			 close filter_c;
			 gv_selection1 = ''
			 RETURN -1
	End If
	If lv_idx      <> '0' then
		gv_selection2 = gv_selection2 + ',' + lv_filter_value
	Else
		lv_idx         = '1'
		gv_selection2 = lv_filter_value
	End If
Loop

Close filter_c;
COMMIT Using Stars2ca;
//sqlcmd('COMMIT',stars2ca,'Committing Filter Retrieval',1)
RETURN 0				
end function

event open;call super::open;//****************************************************************
//08-30-95 FNC Prob 908 Stars30 Put title on window when used for
//             lead disposition codes
//04-10-96 FDG Prob 239 Stars31 Dispostion is misspelled
// MikeFl	09/27/02 Track 3130d	Replace all 'LK' Code type references to 'CD'
//****************************************************************
int lv_res,rc
string lv_type,lv_cat_type
setpointer(hourglass!)
//fx_set_window_colors(w_select_box)
SetMicroHelp(W_Main,'Ready')

show(w_select_box)
gv_selection1 = ''
gv_selection2 = ''
gv_selection3 = 0

IF gv_which_dw = 'DT' or gv_which_dw = 'CL' Then
   if gv_code_type = 'DT' Then
		w_select_box.title = 'SELECT ELEMENT TYPE'
	elseif gv_code_type = 'TB' Then
		w_select_box.title = 'SELECT TABLE TYPE'
//	elseif gv_code_type = 'LK' Then								// MikeFl 9/27/02 Track 3130d
//		w_select_box.title = 'TYPES FOR LOOKUP'				// MikeFl 9/27/02 Track 3130d
	elseif gv_code_type = 'CD' Then
		w_select_box.title = 'SELECT CODE TYPES'
//DJP 8/4/95 prob#908 - add dispostion...
	elseif gv_code_type='DP' then
		this.title='Disposition List'		// FDG 04/10/96
		cb_select.text='&Use'
	end if
//	sqlcmd('CONNECT',stars2ca,'Connecting to Database',2)		// FDG 10/20/95
	dw_1.DataObject = 'd_select_codes'
	This.Event	ue_set_window_colors(This.Control)
//	w_select_box.controlmenu = FALSE									//FDG 06/13/96
	cb_select.enabled = FALSE
	cb_exit.enabled = FALSE
	rc = SetTransObject(dw_1,stars2ca)
	if rc = -1 Then
		errorbox(stars2ca,'Error in SetTransObject for the datawindow')
//		w_select_box.controlmenu = TRUE								//FDG 06/13/96
		cb_select.enabled = FALSE
		cb_exit.enabled = TRUE
		return
	end if
	rc = retrieve(dw_1,gv_code_type)
	if rc = -1 Then
		errorbox(stars2ca,'Error retrieving data for the datawindow')
		cb_select.enabled = FALSE
		cb_exit.enabled = TRUE
	return
	end if
	if dw_1.rowcount() = 0 then
      cb_select.enabled = FALSE
   end if  
	COMMIT Using Stars2ca;							// FDG 10/20/95
	IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
		ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
	END IF												// FDG 10/20/95
	return
end if

IF gv_which_dw = 'LD' Then
	this.title='Disposition List'   //08-30-95 FNC		// FDG 04/10/96
	cb_select.text='&Use'          //08-30-95 FNC
	cb_select.enabled = FALSE
	cb_exit.enabled = FALSE
	dw_1.dataobject = 'd_select_codes'
	This.Event	ue_set_window_colors(This.Control)
	If settransobject(dw_1,STARS2CA)  < 0 then		
		Errorbox(stars2ca,'Error Setting Transaction Object for Datawindow')
		cb_exit.PostEvent(clicked!)
		RETURN
	End if
	If retrieve(dw_1,gv_which_dw) < 0 then
		Errorbox(stars2ca,'Error Retrieving Data')
		cb_exit.PostEvent(clicked!)
	ELSE
		COMMIT Using Stars2ca;							// FDG 10/20/95
		IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
			ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
		END IF												// FDG 10/20/95
	End If
   return
End If

//following is code when coming in from Subset
//IF gv_which_dw = 'SB' Then
////	w_select_box.controlmenu = FALSE					//FDG 06/13/96
//	cb_select.enabled = FALSE
//	cb_exit.enabled = FALSE
//	dw_1.dataobject = 'd_subset_target'
//	This.Event	ue_set_window_colors(This.Control)
//	If settransobject(dw_1,STARS2CA)  < 0 then		
//		Errorbox(stars2ca,'Error Setting Transaction Object for Datawindow')
//		cb_exit.PostEvent(clicked!)
//		RETURN
//	End if
//	If retrieve(dw_1,gv_subset_target_type) < 0 then
//		Errorbox(stars2ca,'Error Retrieving Data')
//		cb_exit.PostEvent(clicked!)
//		RETURN
//	ELSE
//		COMMIT Using Stars2ca;							// FDG 10/20/95
//		IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
//			ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
//		END IF												// FDG 10/20/95
//		RETURN
//	End If
//End If

//This code will not be executed since criteria does not come here any more
//following is code when coming in from criteria
cb_select.enabled = false
lv_type = gv_crit_sub_type
dw_1.dataobject = 'd_criteria_dict'
This.Event	ue_set_window_colors(This.Control)
cb_select.enabled = FALSE
cb_exit.enabled = FALSE
If settransobject(dw_1,stars2ca)  < 0 then
	Errorbox(stars2ca,'Error Setting Transaction Object for Datawindow')
	cb_exit.PostEvent(clicked!)
	RETURN
End if

st_row_count.text = string(retrieve(dw_1,'CL',lv_type) )
If integer(st_row_count.text) < 0 then
	Errorbox(stars2ca,'Error Retrieving Data')
	cb_exit.PostEvent(clicked!)
	RETURN
End if

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95


dw_1.setredraw(false)
For lv_res = 1 to integer(st_row_count.text)
//	lv_type = left(getitemstring(dw_1,lv_res,1),15)
	dw_1.setitem(lv_res,1,left(getitemstring(dw_1,lv_res,1),15))
Next
dw_1.setredraw(true)


end event

on w_select_box.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_row_count=create st_row_count
this.cb_stop=create cb_stop
this.cb_exit=create cb_exit
this.cb_select=create cb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_row_count
this.Control[iCurrent+3]=this.cb_stop
this.Control[iCurrent+4]=this.cb_exit
this.Control[iCurrent+5]=this.cb_select
end on

on w_select_box.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_row_count)
destroy(this.cb_stop)
destroy(this.cb_exit)
destroy(this.cb_select)
end on

type dw_1 from u_dw within w_select_box
string accessiblename = "Select List"
string accessibledescription = "Select List"
accessiblerole accessiblerole = clientrole!
integer x = 27
integer y = 28
integer width = 1659
integer height = 1056
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieverow;//****************************************************************
//Modifications
// Date  Initials  Description
// ----  --------  -----------
//07/18/97  NLG    Replace reference to SetActionCode with Return
//****************************************************************
string last_row

last_row = Describe(dw_1,'datawindow.LastRowOnPage')

if dw_1.rowcount() <= integer(last_row) Then
	dw_1.ScrollNextRow()
end if
If isvalid(cb_stop) Then
	in_nbr_rows = dw_1.RowCount()
	st_row_count.text = string(in_nbr_rows)
end if

if gv_cancel_but_clicked = TRUE Then Return 1 //dw_1.SetActionCode(1)
end event

on rowfocuschanged;string test
int row_nbr,clicked_row
string lv_case_id, lv_case_spl, lv_case_ver

//This event will only function if the stop button has been clicked//


setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
if gv_cancel_but_clicked = TRUE Then 
	cb_select.enabled = true
	cb_select.default = true
	row_nbr = getrow(dw_1)
	If row_nbr = 0 then
   	cb_select.enabled = false
		return
	end if

//Highlights the current row
	SelectRow(dw_1,0,FALSE)
	SelectRow(dw_1,row_nbr,TRUE)
	in_row_nbr = row_nbr
end if

end on

on retrieveend;cb_stop.enabled = FALSE
cb_exit.enabled = TRUE


gv_cancel_but_clicked = TRUE

selectrow(dw_1,0,FALSE)
selectrow(dw_1,1,TRUE)
SetPointer(Arrow!)
triggerevent(dw_1,rowfocuschanged!)

end on

event doubleclicked;//****************************************************************
//Modifications
//  Date   Initials   Description
//  ----   --------   -----------
// 07/18/97  NLG		Replace GetClickedRow with argument row
//****************************************************************
int row_nbr

/*gets the row and makes sure a row was clicked*/

Setpointer(hourglass!)
setmicrohelp(w_main,'Ready')
if gv_cancel_but_clicked Then
	row_nbr = row
	If row_nbr = 0 then
		return
	end if
	in_row_nbr = row_nbr
	selectrow(dw_1,0,false)
	selectrow(dw_1,in_row_nbr,true)
	triggerevent(cb_select,Clicked!)
end if
end event

on retrievestart;setpointer(hourglass!)
gv_cancel_but_clicked = FALSE
cb_stop.enabled = TRUE
end on

type st_row_count from statictext within w_select_box
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 9
integer y = 1108
integer width = 283
integer height = 104
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_stop from u_cb within w_select_box
boolean visible = false
string accessiblename = "Stop"
string accessibledescription = "Stop"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 850
integer y = 1116
integer width = 247
integer height = 108
integer taborder = 40
integer textsize = -16
string text = "Stop"
end type

on clicked;gv_cancel_but_clicked = TRUE
end on

type cb_exit from u_cb within w_select_box
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1413
integer y = 1108
integer width = 274
integer height = 108
integer taborder = 30
string text = "&Close"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

close(parent)
end on

type cb_select from u_cb within w_select_box
string accessiblename = "Select"
string accessibledescription = "Select"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 338
integer y = 1108
integer width = 288
integer height = 108
integer taborder = 20
string text = "&Select"
boolean default = true
end type

on clicked;SetPointer(hourglass!)
setmicrohelp(w_main,'Ready')

IF gv_which_dw = 'DT' or gv_which_dw = 'CL' OR GV_WHICH_DW = 'LD' Then
   gv_selection1 = GetItemString(dw_1,in_row_nbr,1)
	gv_selection2 = GetItemString(dw_1,in_row_nbr,2)
	close(parent)
	return
end if

//FOLLOWING CODE IS FOR Subset
If gv_which_dw = 'SB' then
	gv_selection1 = getitemstring(dw_1,in_row_nbr,1)
	fx_get_filter()
	close(parent)
	RETURN
End If

//FOLLOWING CODE IS FOR CRITERIA
gv_selection1 = getitemstring(dw_1,in_row_nbr,4)
gv_selection2 = getitemstring(dw_1,in_row_nbr,2)
gv_selection3 = getitemnumber(dw_1,in_row_nbr,3)
close (parent)
RETURN
end on

