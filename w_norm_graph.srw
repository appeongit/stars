HA$PBExportHeader$w_norm_graph.srw
$PBExportComments$Inherited from w_master
forward
global type w_norm_graph from w_master
end type
type cb_print from u_cb within w_norm_graph
end type
type st_count from statictext within w_norm_graph
end type
type hsb_1 from hscrollbar within w_norm_graph
end type
type gr_1 from graph within w_norm_graph
end type
type cb_view_detail from u_cb within w_norm_graph
end type
type cb_close from u_cb within w_norm_graph
end type
end forward

global type w_norm_graph from w_master
long backcolor = 67108864
string accessiblename = "Norm Analysis Graph"
string accessibledescription = "Norm Analysis Graph"
accessiblerole accessiblerole = windowrole!
integer x = 133
integer y = 0
integer width = 2766
integer height = 1696
string title = "Norm Analysis Graph"
cb_print cb_print
st_count st_count
hsb_1 hsb_1
gr_1 gr_1
cb_view_detail cb_view_detail
cb_close cb_close
end type
global w_norm_graph w_norm_graph

type variables
int in_num_of_values,in_max_num_on_page
string in_sel,in_values_label,in_type
int in_old_position
string iv_invoice_type
string in_parm, parm
sx_norm_analysis_parms isx_norm_analysis_parms
end variables

forward prototypes
public function integer wf_scroll_graph ()
end prototypes

public function integer wf_scroll_graph ();
//***********************************************************************
//When the user uses the scrollbar this function will in the next bars
//of the graph depending on which option of the scrollbar they used.
//It also will not allow them to move beyond there minium and maxium values. 
//
// Usage:
//   rv = wf_scroll_graph()
//
// Usage Notes:
//   If there is a errorcheck is activated a message is displayed and
//	  'ERROR' is returned
//   If there is no error then a 0 is returned else a negative 1 is used.
//
//*********************************************************************
//			CHANGE HISTORY
//
//	04/01/96	FDG	Add SetRedraw(TRUE) when exiting the script.
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//
//*********************************************************************

int lv_start,lv_end,count,lv_int_value,lv_int_value2,cnt
string lv_category
int SNUM,lv_skip
real lv_dec_value,lv_dec_value2

//The first if checks to see if they have moved beyond the max position
//of the scrollbar
if hsb_1.position > hsb_1.maxposition then
//The second if statement checks to see if the position before the
//user used the horizontal scroll bar is equal to the maxpostion.
//This tells it that there are no other rows to show and they cant go
//any further.  IF there are not equal then it's going to show the rest of 
//the rows.  An example of when they are not equal are when you have
//three rows left and the user hits a page(8 places). Officially
//the position is over the limit but the three rows still need to be
//shown.  This check will do this
	if in_old_position = hsb_1.maxposition  then 
		hsb_1.position = hsb_1.maxposition
		in_old_position = hsb_1.position
		return -1
	end if
	lv_skip = in_old_position
	hsb_1.position = hsb_1.maxposition
//The first if checks to see if they have moved beyond the min position
//of the scrollbar
elseif hsb_1.position < hsb_1.minposition then
//The second if statement checks to see if the position before the
//user used the horizontal scroll bar is equal to the minpostion.
//This tells it that there are no other rows to show and they cant go
//any further.  IF there are not equal then it's going to show the rest of 
//the rows.  An example of when they are not equal are when you have
//three rows left and the user hits a page(8 places). Officially
//the position is over the limit but the three rows still need to be
//shown.  This check will do this
	if in_old_position = hsb_1.minposition Then
		hsb_1.position = hsb_1.minposition
		in_old_position = hsb_1.position
		return -1
	end if
	lv_skip = 0
	hsb_1.position = in_max_num_on_page
else
//This is for a normal move when it has not gone beyond any limits.
	lv_skip  =  hsb_1.position - 8
end if


gr_1.Reset( All!)			//Resets the graph

//Declares the transaction for a dymanic cursor//
SQLCA.LogID = stars1ca.LogID
SQLCA.LogPass = stars1ca.LogPass
SQLCA.ServerName = stars1ca.ServerName
SQLCA.Lock = stars1ca.Lock
SQLCA.DBMS = stars1ca.DBMS
SQLCA.database = stars1ca.database
SQLCA.userid = stars1ca.userid
SQLCA.dbpass = stars1ca.dbpass

//sqlcmd('connect',sqlca,'Error Connecting to Database',5)		// FDG 02/20/01
SQLCA.of_connect()															// FDG 02/20/01

//Declares and prepares the cursor using the Select statement in gv_graph_sel
DECLARE c1 DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :gv_graph_sel;
cnt = 0
if sqlca.of_check_status() <> 0 then
	errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
   return -1
end if
OPEN DYNAMIC c1;
if sqlca.of_check_status() <> 0 then
   errorbox(sqlca,'Error Opening the Sum_prov table')
   return -1
end if

//This counter will loop from 1 to the postion of the box for the
//scrollbar.
for count = 1 to hsb_1.position
	//If just one category is being then one value needs to be retrieved.
	if in_num_of_values = 1 Then
		//Checks to see if the value of the graph that was
		//chosen in norm_analysis is a integer ot a decimal value
		//so the number from the fetch will be put in the proper
		//variable
		if in_type = 'int' then
			Fetch c1 into :lv_int_value,:lv_category;
		elseif in_type = 'dec' then
			Fetch c1 into :lv_dec_value,:lv_category;
		end if
	//If two categories are being used then two values need to be retrieved
	elseif in_num_of_values = 2 Then
		//Checks to see if the value of the graph that was
		//chosen in norm_analysis is a integer ot a decimal value
		//so the number from the fetch will be put in the proper
		//variable	
		if in_type = 'int' then
			Fetch c1 into :lv_int_value,:lv_int_value2,:lv_category;
		elseif in_type = 'dec' then
			Fetch c1 into :lv_dec_value,:lv_dec_value2,:lv_category;
		end if
	end if
	If (sqlca.sqlcode = 100) then
		exit
	end if
	//What this does is you only want to display a page of bars which
	//in this case is equal 8.  lv_skip in most cases set to 8 less then
	//postion.  This statement will skip anything before the value 
	//So whatends up happening is that the only values that are graphed are
	//between lv_stop and the postion. 
	if count <= lv_skip then continue
	gr_1.setredraw(FALSE)						//Won't draw to the end//
	
	//Plots the data for first catgory
	SNUM = gr_1.AddSeries('CARRIER')
	//Checks the data types to see which one to plot
	if in_type = 'int' then
		gr_1.AddData(SNUM,lv_int_value,lv_category)
	elseif in_type = 'dec' then
		gr_1.AddData(SNUM,lv_dec_value,lv_category)
	end if
	//Plots the second category if there is one
	if in_num_of_values = 2 Then
		SNUM = gr_1.AddSeries('NATIONAL')
		if in_type = 'int' then
			gr_1.AddData(SNUM,lv_int_value2,lv_category)
		elseif in_type = 'dec' then
			gr_1.AddData(SNUM,lv_dec_value2,lv_category)
		end if
	end if
	if sqlca.of_check_status() <> 0 then
		close c1;
		if sqlca.of_check_status() <> 0 then
			gr_1.setredraw(TRUE)									//	FDG 04/01/96
      	errorbox(sqlca,'Error Closing the Sum_prov table durring a Reading Error')
      	return -1
   	end if
		gr_1.setredraw(TRUE)										//	FDG 04/01/96
      errorbox(sqlca,'Error Reading the Sum_prov table')
      return -1
   end if
next	
close c1;
if sqlca.of_check_status() <> 0 then
	gr_1.setredraw(TRUE)									//	FDG 04/01/96
   errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
   return -1
end if

//sqlcmd('disconnect',sqlca,'Error disconnecting from database',1)	// FDG 02/20/01
SQLCA.of_disconnect()																// FDG 02/20/01

gr_1.values.Label = in_values_label      //sets the value label corresponding to what they picked
gr_1.setredraw(TRUE)							  //draws the graph
in_old_position = hsb_1.position			 //remembers the old position
return 0
end function

event open;call super::open;//********************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
// 02/20/01	FDG	Stars 4.7.  Use of_connect() in case an alter session command is needed
//********************************************************************

int SNUM,cnt,count
string lv_graph,lv_category,lv_count_query
int position,lv_int_value,lv_int_value2,num_to_get
double lv_dec_value,lv_dec_value2

// variables needed to change table
string lv_table_and_type
string lv_table
string lv_select, lv_from, lv_where 
long   lv_position1, lv_position2,rc
int    lv_len_table, lv_len_of_from, lv_len_of_statement

in_sel = gv_analysis_1_sel
in_num_of_values = isx_norm_analysis_parms.i_num_of_values
in_type = isx_norm_analysis_parms.s_type
iv_invoice_type = isx_norm_analysis_parms.s_invoice_type

//This gets the top or bottom X and assigns it to num_to_get.
//If it is blank then it is assigned 0.
if isvalid(w_norm_analysis) Then
	num_to_get = integer(w_norm_analysis.sle_percent.text)
else
	num_to_get = 0
end if

setpointer(hourglass!)
in_max_num_on_page = 8	//This is how many rows will appear on a page
lv_table_and_type = fx_get_table('w_norm_graph', 'open', iv_invoice_type)

COMMIT using STARS2CA;
If stars2ca.of_check_status() <> 0 Then
	Messagebox('EDIT','Error Commiting to Stars2')
	Return
End If	

lv_len_table      = len(lv_table_and_type) - 2
lv_table          = mid(lv_table_and_type, 3, lv_len_table)

If gc_debug_mode then
   MessageBox('lv_table',lv_table)
End If

//This is the query used to get the count
lv_count_query = 'SELECT COUNT(*) FROM ' + lv_table + ' ' + in_sel

If gc_debug_mode then
   MessageBox('lv_count_query',lv_count_query)
End If

//Strips the order by off the query
if match(lv_count_query,'ORDER BY') Then
	position = pos(lv_count_query,'ORDER BY')
	lv_count_query = left(lv_count_query,position - 1)
end if

gr_1.Reset( All!)    //resets the graph

//Sets the transaction for dynamic cursor
SQLCA.LogID = stars1ca.LogID
SQLCA.LogPass = stars1ca.LogPass
SQLCA.ServerName = stars1ca.ServerName
SQLCA.Lock = stars1ca.Lock
SQLCA.DBMS = stars1ca.DBMS
SQLCA.database = stars1ca.database
SQLCA.userid = stars1ca.userid
SQLCA.dbpass = stars1ca.dbpass

//This sets the position to statting position and also sets the
//min position
hsb_1.position = in_max_num_on_page
hsb_1.minPosition = in_max_num_on_page

//sqlcmd('connect',sqlca,'Error Connecting to Database',5)			// FDG 02/20/01
SQLCA.of_connect()																// FDG 02/20/01

DECLARE c_count DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :lv_count_query;
cnt = 0
if sqlca.of_check_status() <> 0 then
  	errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
   return
end if
OPEN DYNAMIC c_count;
if sqlca.of_check_status() <> 0 then
  	errorbox(sqlca,'Error Opening the Sum_prov table')
   return
end if

//Fetches the count from the query performed
Fetch c_count into :st_count.text;
if sqlca.of_check_status() <> 0 then
	close c_count;
	if sqlca.of_check_status() <> 0 then
  	  	errorbox(sqlca,'Error Closing the Sum_prov table durring a Reading Error')
  		return
  	end if
  	errorbox(sqlca,'Error Reading the Sum_prov table')
   return
end if
close c_count;
if sqlca.of_check_status() <> 0 then
  	errorbox(sqlca,'Error Preparing to Read the Bess National table')
   return
end if
//This checks to see if a value was enetered for the Top X.  If it wasn't
//then maxposition is set to whatever the count was from the query.
if num_to_get <> 0 Then
	//if the num_to_get(top X value) is greater then the count then
	//num_to_get set to the count
	if num_to_get > integer(st_Count.text) then
		num_to_get = integer(st_count.text )
	end if
	//this sets the count box to num_to_get and then sets the maxpostion
	//to the num_to_get.
	st_count.text = string(num_to_get)
	hsb_1.maxposition = num_to_get
	//if the top X amount is less then the maxium rows on a page then
	// the maxium rows allowed on a page is set to the top X
	if num_to_get < in_max_num_on_page Then
		in_max_num_on_page = num_to_get
	end if
else
	
	hsb_1.maxposition = integer(st_count.text)
end if

If gc_debug_mode then
  messagebox('first gv_graph_sel', gv_graph_sel)
End If

lv_len_of_statement = len(gv_graph_sel)
lv_position1 = pos(gv_graph_sel,' From ')
lv_position2 = pos(gv_graph_sel,' WHERE ')
lv_len_of_from = lv_position2 - lv_position1
lv_select = mid(gv_graph_sel, 1, lv_position1)
lv_from   = mid(gv_graph_sel, lv_position1, lv_len_of_from)
lv_where  = mid(gv_graph_sel, lv_position2, lv_len_of_statement)
// build the new gv_graph_sel
lv_from   = ' From ' + lv_table
gv_graph_sel = lv_select + lv_from + lv_where

If gc_debug_mode then
  messagebox('second gv_graph_sel', gv_graph_sel)
End If

DECLARE c1 DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :gv_graph_sel;
cnt = 0
if sqlca.of_check_status() <> 0 then
	errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
   return
end if
OPEN DYNAMIC c1;
if sqlca.of_check_status() <> 0 then
	errorbox(sqlca,'Error Opening the Sum_prov table')
   return
end if
count = 1

//loops though from 1 to how many rows can fit on a page(8 in this case)
for count = 1 to in_max_num_on_page
	//This is done for when one category is used
	if in_num_of_values = 1 Then
		//Checks to see if the fetch should be stored in a integer
		//variable or a real variable
		if IN_TYPE = 'int' then
			Fetch c1 into :lv_int_value,:lv_category;
		elseif IN_TYPE = 'dec' then
			Fetch c1 into :lv_dec_value,:lv_category;
		end if
	//This is done for when two categoies is used
	elseif in_num_of_values = 2 Then
		//Checks to see if the fetch should be stored in a integer
		//variable or a real variable
		if IN_TYPE = 'int' then
			Fetch c1 into :lv_int_value,:lv_int_value2,:lv_category;
		elseif IN_TYPE = 'dec' then
			Fetch c1 into :lv_dec_value,:lv_dec_value2,:lv_category;
		end if
	end if
	If (sqlca.of_check_status() = 100) then
		exit
	end if
	//Plots data for one category
	SNUM = gr_1.AddSeries('CARRIER')
	//Plots for integers
	if IN_TYPE = 'int' then
		rc =gr_1.AddData(SNUM,lv_int_value,lv_category)
	//Plots for decimal values
	elseif IN_TYPE = 'dec' then
		rc = gr_1.AddData(SNUM,lv_dec_value,lv_category)
	end if

	//Plots for second category
	if in_num_of_values = 2 Then
		SNUM = gr_1.AddSeries('NATIONAL')
		if IN_TYPE = 'int' then
			rc = gr_1.AddData(SNUM,lv_int_value2,lv_category)
		elseif IN_TYPE = 'dec' then
			rc =gr_1.AddData(SNUM,lv_dec_value2,lv_category)
		end if
	end if
	if sqlca.of_check_status() <> 0 then
		close c1;
		if sqlca.of_check_status() <> 0 then
      	errorbox(sqlca,'Error Closing the Sum_prov table durring a Reading Error')
      	return
   	end if
      errorbox(sqlca,'Error Reading the Sum_prov table')
      return
   end if
next
	
   close c1;
   if sqlca.of_check_status() <> 0 then
      errorbox(sqlca,'Error Preparing to Read the Sum_prov table')
      return
   end if
	//sqlcmd('disconnect',sqlca,'Error disconnecting from database',1)		// FDG 02/20/01
	SQLCA.of_disconnect()																	// FDG 02/20/01
//Puts the value label(y axis) based on what they picked in the screen before
gr_1.values.Label = in_values_label

in_old_position = hsb_1.position			//intializes the old position

//	if the mazium position is less then or equal to the maxium rows\
//that can fit on a page then the scroll bar is not shown
if hsb_1.maxposition <= in_max_num_on_page then
	hsb_1.visible = FALSE
end if
end event

on w_norm_graph.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.st_count=create st_count
this.hsb_1=create hsb_1
this.gr_1=create gr_1
this.cb_view_detail=create cb_view_detail
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.st_count
this.Control[iCurrent+3]=this.hsb_1
this.Control[iCurrent+4]=this.gr_1
this.Control[iCurrent+5]=this.cb_view_detail
this.Control[iCurrent+6]=this.cb_close
end on

on w_norm_graph.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.st_count)
destroy(this.hsb_1)
destroy(this.gr_1)
destroy(this.cb_view_detail)
destroy(this.cb_close)
end on

event ue_preopen;//********************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//********************************************************************

// FNC 04/20/99 Start
//parm = message.stringparm
//KMM Clear out message parm (PB Bug)
//SetNull(message.stringparm)
isx_norm_analysis_parms = message.PowerObjectParm
SetNull(message.PowerObjectParm)

// FNC 04/20/99 Start


end event

type cb_print from u_cb within w_norm_graph
string accessiblename = "Print"
string accessibledescription = "Print"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1298
integer y = 1460
integer width = 457
integer height = 108
integer taborder = 20
string text = "&Print"
end type

on clicked;integer job_no,lv_counter,lv_y_position,rc,lv_scroll_position
boolean lv_first_time
string lv_p_string
w_main.Setmicrohelp("Printing Norm Graph")
SetPointer(hourglass!)

lv_counter = 0
lv_scroll_position = hsb_1.position
if hsb_1.position <> in_max_num_on_page then
	hsb_1.position = in_max_num_on_page
	rc = wf_scroll_graph()
	if rc = -1 then
		return
	end if
end if
job_no = PrintOpen()
//lv_p_string = "~027&I1O"+"Change to Lanscape"
//Printsend(job_no,lv_p_string)
lv_first_time = TRUE
do while hsb_1.position < hsb_1.maxposition
	lv_counter ++
	if lv_counter = 2 Then
		lv_y_position = 4250
		lv_counter = 0
	else
		lv_y_position = 750
		if lv_first_time = FALSE Then
			printpage(job_no)
		end if
	end if		
	gr_1.print(job_no,2250,lv_y_position)
	hsb_1.triggerevent(pageright!)
	lv_first_time = False
loop

lv_counter++
if lv_counter = 2 Then
	lv_y_position = 4250
	lv_counter = 1
else
	lv_y_position = 0
	if lv_first_time = FALSE Then
		printpage(job_no)
	end if
end if		

gr_1.print(job_no,2250,lv_y_position)

printclose(job_no)

if hsb_1.position <> in_max_num_on_page then
	hsb_1.position = lv_scroll_position
	rc = wf_scroll_graph()
	if rc = -1 then
		return
	end if
end if
w_main.Setmicrohelp("Ready")
SetPointer(Arrow!)

end on

type st_count from statictext within w_norm_graph
string accessiblename = "Row Count"
string accessibledescription = "Row Count"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer x = 105
integer y = 1476
integer width = 274
integer height = 80
integer textsize = -10
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

type hsb_1 from hscrollbar within w_norm_graph
string accessiblename = "Norm Analysis Graph"
string accessibledescription = "Norm Analysis Graph"
accessiblerole accessiblerole = scrollbarrole!
event endscroll pbm_sbnthumbposition
integer x = 110
integer y = 1360
integer width = 2487
integer height = 52
end type

on endscroll;int rc

rc = wf_scroll_graph()
if rc = -1 then
	return
end if
end on

on pageright;int rc,num_to_move
num_to_move = in_max_num_on_page
hsb_1.position = hsb_1.position + num_to_move
rc = wf_scroll_graph()
if rc = -1 then
	return
end if



end on

on lineleft;int rc,num_to_move
num_to_move = 1

hsb_1.position = hsb_1.position - num_to_move
rc = wf_scroll_graph()
if rc = -1 then
	return
end if

end on

on pageleft;int rc,num_to_move
num_to_move = in_max_num_on_page
hsb_1.position = hsb_1.position - num_to_move
rc = wf_scroll_graph()
if rc = -1 then
	return
end if

end on

on lineright;
int rc,num_to_move
num_to_move = 1

hsb_1.position = hsb_1.position + num_to_move
rc = wf_scroll_graph()
if rc = -1 then
	return
end if

end on

type gr_1 from graph within w_norm_graph
string accessiblename = "Norm Analysis Graph"
string accessibledescription = "Norm Analysis Graph"
long textcolor = 33554432
accessiblerole accessiblerole = diagramrole!
integer x = 110
integer y = 16
integer width = 2487
integer height = 1344
boolean enabled = false
boolean border = true
grgraphtype graphtype = col3dobjgraph!
long backcolor = 67108864
long shadecolor = 6316128
integer spacing = 100
string title = "NORM ANALYSIS GRAPH"
integer elevation = 20
integer rotation = -20
integer perspective = 2
integer depth = 100
grlegendtype legend = atbottom!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

on gr_1.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="System"
TitleDispAttr.FontCharSet=DefaultCharSet!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=553648127
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="Proc Code/Speciality/Proc Mod"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=700
Category.DispAttr.FaceName="System"
Category.DispAttr.FontCharSet=DefaultCharSet!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=553648127
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Arial"
Category.LabelDispAttr.FontCharSet=DefaultCharSet!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=549503168
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="(None)"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontCharSet=DefaultCharSet!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="System"
Values.LabelDispAttr.FontCharSet=DefaultCharSet!
Values.LabelDispAttr.BackColor=553648127
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontCharSet=DefaultCharSet!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontCharSet=DefaultCharSet!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=549503168
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="Arial"
LegendDispAttr.FontCharSet=DefaultCharSet!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Arial"
PieDispAttr.FontCharSet=DefaultCharSet!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_1.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

type cb_view_detail from u_cb within w_norm_graph
string accessiblename = "View Report"
string accessibledescription = "View Report"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 480
integer y = 1460
integer width = 457
integer height = 108
integer taborder = 10
string text = "&View Report"
end type

event clicked;//********************************************************************
// 04/20/99	FNC	FS/TS2239 Starcare track 2239. Replace global period
//						variables with variables in a structure
//********************************************************************

gv_active_invoice = iv_invoice_type

gv_analysis_1_sel=in_sel

OpenSheetWithParm(w_norm_rpt,isx_norm_analysis_parms,MDI_main_frame,help_menu_position,Layered!) // SG Nov 94
// FNC 04/20/99 End

end event

type cb_close from u_cb within w_norm_graph
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2162
integer y = 1460
integer width = 457
integer height = 108
integer taborder = 30
integer textsize = -16
string text = "&Close"
end type

on clicked;close(parent)
end on

