HA$PBExportHeader$w_graph_stars_select.srw
$PBExportComments$Inherited from w_master
forward
global type w_graph_stars_select from w_master
end type
type cb_cancel from u_cb within w_graph_stars_select
end type
type lb_dws from listbox within w_graph_stars_select
end type
end forward

global type w_graph_stars_select from w_master
string accessiblename = "Select Data to Graph"
string accessibledescription = "Select Data to Graph"
accessiblerole accessiblerole = windowrole!
int X=851
int Y=597
int Width=1212
int Height=721
WindowType WindowType=response!
boolean TitleBar=true
string Title="Select Data To Graph"
long BackColor=67108864
cb_cancel cb_cancel
lb_dws lb_dws
end type
global w_graph_stars_select w_graph_stars_select

type variables
integer in_title_ctrl_nbr[]
datawindow in_dw_control[]
end variables

event open;call super::open;// *****************************************************************
// W_GRAPH_STARS_SELECT
// *****************************************************************
// This window will search the active sheet for all datawindows.
// If there is only one datawindow it will open the graph system for
// the one datawindow.  If there are more than one datawindow it
// will look for the titles of each datawindow in the tag value of
// the control.  If only one title is found it will call the graph
// system for that datawindow.  If more than one title is found then
// window W_graph_stars_select will be visible to select the one to
// graph. 
//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 8/94		MSD	New module
//	1/29/98	JTM	Added logic for uo_Query parameter (4.0 redesign).
//	04/27/98	FDG	Track 1112.  Get the d/w from the 'View Report' tab
//						instead of the 'Report On' tab.
//	07/24/98	FDG	Track 1474.  If dw_view has no rows, don't display a graph.
//***********************************************************************

integer 	dw_nbr = 0, title_counter =0, dw_counter, lv_start_pos
string lv_grid
integer	lv_end_pos, lv_length, lv_use_this 
Window     active_sheet
Long       current_control, lv_upperbound
string lv_title[]			 	 // List of DW titles for those that have titles 

u_dw		ldw_view

uo_Query luo_Query
luo_Query = message.PowerObjectParm

this.visible = FALSE
if isvalid(w_graph_the_dw) then
	if messagebox("Graph Message","You are already graphing data.  Do you wish to cancel the current graph and start a new one?",Question!,YesNo!,2) = 1 then
		close(w_graph_the_dw)
	else
		w_graph_the_dw.BringToTop = TRUE
		cb_cancel.postevent(Clicked!)
		return
	end if
end if
	
setpointer(Hourglass!)

// 4.0 JTM 1/29/98
If IsValid(luo_Query) Then
	// store report datawindow in an array
	//in_dw_control[1] = luo_Query.of_Get_Report_Dw()		// FDG 04/27/98
	ldw_view = luo_Query.of_get_view_dw()						// FDG 04/27/98
	in_dw_control[1] = ldw_view									// FDG 04/27/98
	// FDG 07/24/98 begin
	IF	ldw_view.RowCount()	<	1			THEN
		MessageBox ('Error', 'There is no data to graph.')
		cb_cancel.postevent(Clicked!)
		Return
	END IF
	// FDG 07/24/98 end
	dw_nbr=1
Else	
	active_sheet = gnv_App.of_Get_Frame().GetActiveSheet()

	if (Not IsValid(active_sheet)) then
		MessageBox('GRAPH','No sheet is currently active.',StopSign!)
		cb_cancel.Postevent(Clicked!)
		return
	end if
	
	// store datawindows in an array
	lv_upperbound = UpperBound(active_sheet.control[]) 				//KMM 10/5/95
	for current_control = 1 to lv_upperbound								//KMM 10/5/95
	  if (active_sheet.control[current_control].TypeOf() = DataWindow!) and &
		  (active_sheet.control[current_control].visible  = True)        then 
		dw_nbr ++
		in_dw_control[dw_nbr] = active_sheet.control[current_control]
	  end if
	next
End If

// end 4.0 JTM 1/29/98

if (dw_nbr = 0) then 
	MessageBox('Graph Report','Current Sheet does NOT contain a datawindow to graph.',StopSign!)
	cb_cancel.Postevent(Clicked!)
	return
end if

// if only one DW is on sheet - graph it
if dw_nbr = 1 then
   lv_grid = in_dw_control[1].Describe(" datawindow.Processing")   
   if lv_grid <> '1' or match(upper(in_dw_control[1].tag),'NO GRAPH') then
      messagebox("Graph Information","There are no Datawindows to be graphed in the current window!")
   else
		MDI_main_frame.SetMicroHelp('Graphing Report')
   	OpensheetWithParm(w_graph_the_dw,in_dw_control[1],mdi_main_frame,help_menu_position,Layered!)
	end if
	cb_cancel.Postevent(Clicked!)
	return
end if

// since there are more than one DW open the selection window

for dw_counter = 1 to dw_nbr
   lv_grid = in_dw_control[dw_counter].Describe(" datawindow.Processing")   
   if lv_grid = '1' and not match(upper(in_dw_control[dw_counter].tag),'NO GRAPH') then
		lv_start_pos = pos(upper(in_dw_control[dw_counter].tag),"TITLE")
   	if lv_start_pos = 0 then
	     continue
   	else
			lv_end_pos = pos(in_dw_control[dw_counter].tag, "," ,lv_start_pos)  
   	   lv_start_pos = pos(in_dw_control[dw_counter].tag,"=",lv_start_pos)
      	if lv_end_pos = 0 then  //no comma, end of string
	        lv_length = 100       //so will read to end of string
   	   else
	  		  lv_length = lv_end_pos - lv_start_pos - 1
   	   end if
			lb_dws.AddItem( mid(in_dw_control[dw_counter].tag,lv_start_pos+1,lv_length) )
			title_counter ++
			in_title_ctrl_nbr[title_counter] = dw_counter
	    end if
	end if
next
    
if title_counter <= 0 then
	messagebox("Graph Information","There are no Datawindows to be graphed in the current window!")
	cb_cancel.postevent(Clicked!)
	return
else
	if title_counter = 1 then
   	OpensheetWithParm(w_graph_the_dw,in_dw_control[in_title_ctrl_nbr[1]],mdi_main_frame,help_menu_position,Layered!)
		cb_cancel.postevent(Clicked!)		
		return
	else
		this.visible = TRUE
		//fx_set_window_colors(w_graph_stars_select)
		return
	end if
end if	


	

end event

on w_graph_stars_select.create
int iCurrent
call w_master::create
this.cb_cancel=create cb_cancel
this.lb_dws=create lb_dws
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_cancel
this.Control[iCurrent+2]=lb_dws
end on

on w_graph_stars_select.destroy
call w_master::destroy
destroy(this.cb_cancel)
destroy(this.lb_dws)
end on

type cb_cancel from u_cb within w_graph_stars_select
string accessiblename = "Cancel"
string accessibledescription = "Cancel"
accessiblerole accessiblerole = pushbuttonrole!
int X=417
int Y=477
int Width=339
int Height=109
int TabOrder=20
string Text="&Cancel"
end type

on clicked;close(parent)
end on

type lb_dws from listbox within w_graph_stars_select
string accessiblename = "Data Selection"
string accessibledescription = "Data Selection"
long backcolor = 1073741824
accessiblerole accessiblerole = listrole!
int X=33
int Y=41
int Width=1111
int Height=385
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean Sorted=false
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;int lv_selected_item

setpointer(Hourglass!)
lv_selected_item = lb_dws.selectedindex() 
if lv_selected_item > 0 then
  	OpensheetWithParm(w_graph_the_dw,in_dw_control[in_title_ctrl_nbr[lv_selected_item]],mdi_main_frame,help_menu_position,Layered!)
	cb_cancel.postevent(Clicked!)		
	return
end if

return

end on

