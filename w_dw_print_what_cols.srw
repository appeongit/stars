HA$PBExportHeader$w_dw_print_what_cols.srw
$PBExportComments$DW selective column print function (inherited from w_master)
forward
global type w_dw_print_what_cols from w_master
end type
type st_title from statictext within w_dw_print_what_cols
end type
type cb_whatrows from u_cb within w_dw_print_what_cols
end type
type st_2 from statictext within w_dw_print_what_cols
end type
type st_1 from statictext within w_dw_print_what_cols
end type
type st_columns_selected from statictext within w_dw_print_what_cols
end type
type cbx_print_all from checkbox within w_dw_print_what_cols
end type
type lb_columns from listbox within w_dw_print_what_cols
end type
type cb_print from u_cb within w_dw_print_what_cols
end type
type st_column_count from statictext within w_dw_print_what_cols
end type
type cb_exit from u_cb within w_dw_print_what_cols
end type
type ln_1 from line within w_dw_print_what_cols
end type
end forward

global type w_dw_print_what_cols from w_master
boolean visible = false
string accessiblename = "Print Column Selection"
string accessibledescription = "Print Column Selection"
accessiblerole accessiblerole = windowrole!
integer x = 599
integer y = 252
integer width = 1746
integer height = 1384
string title = "Print Column Selection"
windowtype windowtype = response!
long backcolor = 67108864
event ue_close ( )
st_title st_title
cb_whatrows cb_whatrows
st_2 st_2
st_1 st_1
st_columns_selected st_columns_selected
cbx_print_all cbx_print_all
lb_columns lb_columns
cb_print cb_print
st_column_count st_column_count
cb_exit cb_exit
ln_1 ln_1
end type
global w_dw_print_what_cols w_dw_print_what_cols

type variables
u_dw	 dw_name
string hold_col_names[]       /* array of column names */
string hold_col_width[]       /* array of original column widths */
int num_of_columns
boolean process_done = FALSE
end variables

forward prototypes
public function integer wf_dw_print (ref u_dw adw_dw, integer ai_copies, string as_filename)
public function boolean wf_shr_unshr_print (ref u_dw dw_to_use)
end prototypes

event ue_close;call super::ue_close;Close(this)
end event

public function integer wf_dw_print (ref u_dw adw_dw, integer ai_copies, string as_filename);///////////////////////////////////////////////////////////////////////////////////
//
//    Function: 	wf_dw_print
//
//     Purpose:	prints a DataWindow. If copies and or filename are supplied,
//						the datawindow will be printed with those supplied parameters.
//						If no	parameters are supplied (copies =0 and filename ="") then
//						a print setup dialog will be open allowing the user to change the print options.
//
//	       Date:	October 11, 1994
//
//       Scope: 	Public
//
//   Arguments:  	u_dw		(Ref) adw_dw - the datawindow to print.
//						int      ai_copies - the number of copies to print of the datawindow
//						string	as_filename - the name of the text file the datawindow will be printed to.
//
//     Returns:	1 for successful print , -1 for error during print or user cancel
//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
//
// FDG	04/12/96	Modified to not print from this script when w_dw_print_options is opened.
// GaryR	10/27/00	2315d	Conforming STARS to the HIPAA Act
// GaryR	05/01/01	Stars 4.7 - Moved to window level from global.
//
//////////////////////////////////////////////////////////////////////////////////


int  li_printed, li_rc

//test if parameters were supplied
If ai_copies = 0 and as_filename = "" Then
	//open window with  print options
	 openwithparm(w_dw_print_options,adw_dw)
	li_rc = message.doubleparm
	//print the datawindow if they didn't hit cancel
	If li_rc = 1	Then 
//		li_printed = adw_dw.Print( )			// FDG 04/12/96
		li_printed = li_rc						// FDG 04/12/96
	Else
		li_printed = -1
	End If
Else  //Parameters supplied in arguments
	if ai_copies >= 0 Then adw_dw.modify('datawindow.print.copies=' + string(ai_copies) + ')')
	adw_dw.modify("datawindow.print.filename='" + string(as_filename) + "')")
	
	// GaryR	10/27/2000	2315d
	IF fx_disclaimer() = 1 THEN
		li_printed = adw_dw.Print( )
	ELSE
		li_printed = -1
	END IF
End If

//return condition code of the print function or -1 if user hit cancel in setup dialog
Return(li_printed)
end function

public function boolean wf_shr_unshr_print (ref u_dw dw_to_use);// This function is called to do the following:
//		Squash columns to zero lenght that are not selcted to print
//		Print the data window
//		Expand columns to original width
// Arguments - DW_TO_USE of type datawindow
//		This is the DW upon which all action will occur
//	Return value BOOLEAN - not actually used


integer suba

//SHRINK
//if isvalid(w_dw_print_what_cols) then
if cbx_print_all.checked = FALSE then
	for suba = 1 to num_of_columns
		if lb_columns.state(suba) = 0 then
			dw_to_use.Modify(hold_col_names[suba] + ".width=~'0~'")
		end if
	NEXT
end if
//end if

//PRINT
dw_to_use.Modify('datawindow.grid.lines = 2')
SetPointer(Arrow!)
MDI_main_frame.SetMicroHelp('Printing Report')
dw_to_use.accepttext()								//KMM 11-7-95 STARCARE 692
//Prob 0000660 EK 10/04/95
if wf_dw_print(dw_to_use,0,"") = 1 then
   MDI_main_frame.SetMicroHelp('Report successfully printed')
else
	MDI_main_frame.SetMicroHelp('Could NOT print report')
end if

// UNSHRINK

//if isvalid(w_dw_print_what_cols) then
if cbx_print_all.checked = FALSE then
	for suba = 1 to num_of_columns
			dw_to_use.Modify(hold_col_names[suba] + ".width= ~'"+hold_col_width[suba]+"~'")
	NEXT
end if
//end if
return(TRUE)

end function

event open;call super::open;/******************************************************************/
/*         WINDOW: Datawindow Print What Columns                  */
/******************************************************************/
/* This window is called when a datawindow is being printed.      */
/* It will list all of the colums on the datawindow and allow     */
/* the user to print only selected columns or all columns.        */
/* This is achieved by setting the column width to zero for the   */
/* columns to not be printed.  The function will restore the DW   */
/* to all of its original settings on exit.                       */
/* Datawindows that are not of type grid or are flagged with TAG  */
/* value of 'noselprint' will be printed as is.							*/
/* ARGUMENTS: The window receives one argument of datatype        */
/*					datawindow, this is the name of the datawindow     */
/*					being printed.                                   	*/
/******************************************************************/ 
// FNC 11/24/98	Track 1991. Call ue_close and issue return when
//						user cancels print. This will avoid an unrecoverable
//						error that occurs becasue the script continues to execute after
//						the close command.
// AJS 07-20-98   Use a temporary field to check column widths;	
//                do not place in array if width = 0; 
//	FDG 04/11/96	Prob 170 - Do not display an error message if a
//						column can't be added to the listbox.  Do display
//						the error message if no columns are added to the
//						listbox.
//
// DKG 04/29/96   Added call to set window colors. PROB 856 STARCARE
//                disk.
//******************************************************************** 								

int suba, li_available_column
string temp_str
string hold_label
string temp_label, temp_col_names[], temp_col_width[]
long new_line_pos,title_pos,eq_pos,end_pos
long total_dw_width = 0
string lv_title
Integer	li_cols = 0					//	FDG 04/11/96

SetMicroHelp('Getting print information')
Setpointer(Hourglass!)

if not isvalid(dw_name) then
	messagebox("PROGRAM ERROR","Datawindow sent to w_dw_print_what_cols is not valid.  Unable to print.")
	return
end if

lv_title=dw_name.tag
title_pos=pos(upper(lv_title),'TITLE')
if title_pos<>0 then
	eq_pos=pos(lv_title,'=',title_pos)	
	if eq_pos<>0 then
		end_pos=pos(lv_title,',',eq_pos)
		if end_pos<>0 then
			st_title.text=trim(mid(lv_title,eq_pos+1,end_pos - (eq_pos+1)))
		else
			st_title.text=trim(mid(lv_title,eq_pos+1))
		end if
	end if
end if

num_of_columns = integer(dw_name.Describe('datawindow.column.count'))
//EK 09-21-95 added Cancel button to Message box. Prob 0000319
if num_of_columns < 1 then
	if messagebox("Print Message","Unable to obtain column names in order to allow you to select which columns to print.  All columns will therefore be printed.",Exclamation!, OKCancel!,2) = 1 then
	 cbx_print_all.checked = TRUE
	 cb_print.triggerevent(CLICKED!)
    return
   else
 	 cbx_print_all.checked = FALSE
    this.post event ue_close()						// FNC 11/24/98
	 return													// FNC 11/24/98 
   end if

end if

// Do selective col print for grid DW only
if dw_name.Describe('datawindow.processing') <> "1"    	&
  OR match(upper(dw_name.tag),"NOSELPRINT") then
	cbx_print_all.checked = TRUE
	cb_print.triggerevent(CLICKED!)
	return
end if

//st_column_count.text = string(num_of_columns)		// FDG 04/11/96
st_columns_selected.text = st_column_count.text
SetMicroHelp('Working')
// LOAD COLUMN NAMES AND WIDTHS INTO TABLES, LOAD LABELS INTO LISTBOX  
li_available_column = 0										//ajs 07-20-98
FOR suba = 1 to num_of_columns
		temp_col_names[suba] = dw_name.Describe('#'+string(suba)+'.name')				//ajs 07-20-98
		temp_col_width[suba] = dw_name.Describe(temp_col_names[suba] + '.width')	//ajs 07-20-98
		temp_label = trim(dw_name.Describe(temp_col_names[suba]+'_t.text'))			//ajs 07-20-98

	if (temp_col_names[suba] = "" OR temp_col_names[suba] = "!"   &
		OR temp_col_names[suba] = "?"                   		&
 		OR temp_label = "!" OR temp_label = "?"  				&
		OR temp_label = ""       )       							& 
		OR (NOT Isnumber (temp_col_width[suba]))					&
		OR (temp_COL_WIDTH[suba] = '0' ) then					//ajs 07-20-98 
	ELSE
		// Strip out new line/carrage return characters
		li_available_column++
		hold_col_names[li_available_column] = dw_name.Describe('#'+string(suba)+'.name')	
		hold_col_width[li_available_column] = dw_name.Describe(hold_col_names[li_available_column] + '.width')	
		hold_label = trim(dw_name.Describe(hold_col_names[li_available_column]+'_t.text'))
		new_line_pos = pos(hold_label,"~n")	
		if new_line_pos > 1 then
			temp_str = mid(hold_label,1,new_line_pos - 1)  + " " &
					+ mid(hold_label,new_line_pos + 1,len(hold_label) - new_line_pos)			
			hold_label = temp_str
		end if
		new_line_pos = pos(hold_label,"~r")	
		if new_line_pos > 1 then
			temp_str = mid(hold_label,1,new_line_pos - 1)  + " " &
						+ mid(hold_label,new_line_pos + 1,len(hold_label) - new_line_pos)			
			hold_label = temp_str
		end if
	//EK 09-21-95 added Cancel button to Message box. Prob 0000319
		if (lb_columns.AddItem(hold_label)) < 1 then
			if messagebox("Print Message","Unable to obtain column names in order to allow you to select which columns to print.  All columns will therefore be printed.",Exclamation!,OKCancel!,2) = 1 then
			  cbx_print_all.checked = TRUE
	   	  return
	   	else
			  cbx_print_all.checked = FALSE
		    this.post event ue_close()						// FNC 11/24/98
			 return													// FNC 11/24/98 				 
	 	   end if
	//		cb_print.triggerevent(CLICKED!)
		else
			li_cols++						// FDG 04/11/96
		end if
		total_dw_width = total_dw_width + long(hold_col_width[li_available_column])
	END IF
NEXT
num_of_columns = li_available_column				//ajs 07-20-98

	//	FDG 04/11/96 - Display an error if no rows were added to the listbox
IF	li_cols	=	0			THEN
	if messagebox("Print Message","Unable to obtain column names in order to allow you to select which columns to print.  All columns will therefore be printed.",Exclamation!,OKCancel!,2) = 1 then
		cbx_print_all.checked = TRUE
		cb_print.triggerevent(CLICKED!)
		return
	else
		cbx_print_all.checked = FALSE
	    this.post event ue_close()						// FNC 11/24/98
		return													// FNC 11/24/98 			
	end if
END IF

st_column_count.text = string(li_cols)			// FDG 04/11/96

if gc_debug_mode = TRUE then
	messagebox("DW INFORMATION","total width = " + string(total_dw_width) + "~nunits = " + dw_name.Describe('datawindow.Units') + " (0=PB Units, 1=Pixels, 2=1000th Inch)~n" + "Orientation = " + dw_name.Describe('datawindow.print.orientation') + " (0=Wind Dft, 1=Lands, 2=Port)")
end if

cbx_print_all.TriggerEvent (Clicked!)		// FDG 04/11/96


w_dw_print_what_cols.visible = TRUE
SetMicroHelp('Select columns to print on report')
cb_print.enabled = TRUE 
cb_print.default = TRUE
cb_whatrows.enabled = TRUE
return
end event

on w_dw_print_what_cols.create
int iCurrent
call super::create
this.st_title=create st_title
this.cb_whatrows=create cb_whatrows
this.st_2=create st_2
this.st_1=create st_1
this.st_columns_selected=create st_columns_selected
this.cbx_print_all=create cbx_print_all
this.lb_columns=create lb_columns
this.cb_print=create cb_print
this.st_column_count=create st_column_count
this.cb_exit=create cb_exit
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
this.Control[iCurrent+2]=this.cb_whatrows
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_columns_selected
this.Control[iCurrent+6]=this.cbx_print_all
this.Control[iCurrent+7]=this.lb_columns
this.Control[iCurrent+8]=this.cb_print
this.Control[iCurrent+9]=this.st_column_count
this.Control[iCurrent+10]=this.cb_exit
this.Control[iCurrent+11]=this.ln_1
end on

on w_dw_print_what_cols.destroy
call super::destroy
destroy(this.st_title)
destroy(this.cb_whatrows)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_columns_selected)
destroy(this.cbx_print_all)
destroy(this.lb_columns)
destroy(this.cb_print)
destroy(this.st_column_count)
destroy(this.cb_exit)
destroy(this.ln_1)
end on

event ue_preopen;call super::ue_preopen;dw_name = message.PowerObjectParm   //  get DW name to use from parm
//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

end event

type st_title from statictext within w_dw_print_what_cols
string accessiblename = "Columns Selector Title"
string accessibledescription = "Columns Selector Title"
accessiblerole accessiblerole = statictextrole!
integer x = 128
integer y = 16
integer width = 1408
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_whatrows from u_cb within w_dw_print_what_cols
string accessiblename = "Print Selected Rows"
string accessibledescription = "Print Selected Rows"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 645
integer y = 1156
integer width = 658
integer height = 108
integer taborder = 20
boolean enabled = false
string text = "Print &Selected Rows"
end type

on clicked;if not isvalid(dw_name) then
	close(parent)
	return
end if
open(w_dw_print_what_rows)
end on

type st_2 from statictext within w_dw_print_what_cols
string accessiblename = "Columns Selected"
string accessibledescription = "Columns Selected"
accessiblerole accessiblerole = statictextrole!
integer x = 329
integer y = 1028
integer width = 567
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Columns Selected:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_dw_print_what_cols
string accessiblename = "Total Columns"
string accessibledescription = "Total Columns"
accessiblerole accessiblerole = statictextrole!
integer x = 439
integer y = 932
integer width = 457
integer height = 72
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Total Columns:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_columns_selected from statictext within w_dw_print_what_cols
string accessiblename = "Columns Selected"
string accessibledescription = "Columns Selected"
accessiblerole accessiblerole = statictextrole!
integer x = 914
integer y = 1020
integer width = 274
integer height = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_print_all from checkbox within w_dw_print_what_cols
string accessiblename = "Print All Columns"
string accessibledescription = "Print All Columns"
accessiblerole accessiblerole = checkbuttonrole!
integer x = 517
integer y = 816
integer width = 709
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
string text = "Print All Columns"
boolean checked = true
end type

on clicked;if cbx_print_all.checked = TRUE then
	lb_columns.enabled = FALSE
	st_columns_selected.text = st_column_count.text
else
	lb_columns.enabled = TRUE
	st_columns_selected.text = string(lb_columns.totalselected())
end if
end on

type lb_columns from listbox within w_dw_print_what_cols
string accessiblename = "Columns List"
string accessibledescription = "Columns List"
long textcolor = 33554432
accessiblerole accessiblerole = listrole!
integer x = 128
integer y = 96
integer width = 1408
integer height = 712
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 1073741824
boolean vscrollbar = true
boolean sorted = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;cbx_print_all.checked = FALSE
st_columns_selected.text = string(lb_columns.totalselected())
end on

type cb_print from u_cb within w_dw_print_what_cols
string accessiblename = "Print All Rows"
string accessibledescription = "Print All Rows"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 27
integer y = 1156
integer width = 594
integer height = 108
integer taborder = 40
integer textsize = -16
boolean enabled = false
string text = "&Print All Rows"
boolean default = true
end type

on clicked;// PRINT CLICKED SCRIPT

cb_print.enabled = FALSE  // SG Dec 94 to prevent "double-click"
cb_exit.enabled = FALSE   //HRB - 8/1/95 - prevent from clicking cancel during print 
cb_whatrows.enabled = FALSE //HRB - 8/1/95 - so that all buttons would be disabled (looks nicer)
Setpointer(Hourglass!)
// shrink columns, print dw, expand columns
if not isvalid(dw_name) then
	close(parent)
	return
end if

wf_shr_unshr_print(dw_name)

setmicrohelp(w_main,'Ready')

close(parent)
end on

type st_column_count from statictext within w_dw_print_what_cols
string accessiblename = "Column Count"
string accessibledescription = "Column Count"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 914
integer y = 920
integer width = 274
integer height = 80
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

type cb_exit from u_cb within w_dw_print_what_cols
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1330
integer y = 1156
integer width = 338
integer height = 108
integer taborder = 30
string text = "&Cancel"
end type

on clicked;setpointer(hourglass!)
setmicrohelp(w_main,'Ready')

close(parent)
end on

type ln_1 from line within w_dw_print_what_cols
string accessiblename = "Line Divider"
string accessibledescription = "Line Divider"
accessiblerole accessiblerole = defaultrole!
long linecolor = 33554432
integer linethickness = 4
integer beginx = 9
integer beginy = 1124
integer endx = 1719
integer endy = 1124
end type

