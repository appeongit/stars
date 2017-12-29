HA$PBExportHeader$w_parent_details.srw
$PBExportComments$Inherited from w_master
forward
global type w_parent_details from w_master
end type
type cb_restore from u_cb within w_parent_details
end type
type st_count from statictext within w_parent_details
end type
type cb_close from u_cb within w_parent_details
end type
type dw_1 from u_dw within w_parent_details
end type
end forward

shared variables
w_parent_details sh_detail_windows[]
int sh_counter,sh_counter2
boolean sh_first_open_flag,sh_do_switch
m_detail_menu m_popup_menu

end variables

global type w_parent_details from w_master
string accessiblename = "Restore"
string accessibledescription = "Restore"
integer x = 169
integer y = 0
integer width = 1408
integer height = 904
windowstate windowstate = minimized!
boolean ib_popup_menu = true
event checkwinsize pbm_syscommand
cb_restore cb_restore
st_count st_count
cb_close cb_close
dw_1 dw_1
end type
global w_parent_details w_parent_details

type variables
string in_icn,in_table_type
int in_window_count,in_orginal_dw_height,in_orginal_dw_width
int in_orig_close_x,in_orig_close_y,in_orig_win_height
int in_orig_win_width
int in_orig_win_x, in_orig_win_y
int in_orig_restore_x, in_orig_restore_y 
sx_details_structure in_detail_info_struct

end variables

forward prototypes
public function integer wf_dw_title_info ()
public function integer wf_delete_array ()
public function integer wf_switch ()
end prototypes

event checkwinsize;if message.wordparm = 61488 then
	//dw_1.height = 1400
	//dw_1.width = 2600
	//cb_close.y = 1530
	//cb_close.x = 2500
   //cb_restore.x = 2139
   //cb_restore.y = 1530 
   cb_restore.Enabled = TRUE
   
elseif message.wordparm = 61728 then
	// FDG 10/20/97	Stars 3.6
	//						Restore the window's dimensions.  The resize
	//						will automatically take care of the other
	//						window's controls
	This.x		=	in_orig_win_x
	This.y		=	in_orig_win_y
	This.width	=	in_orig_win_width
	This.height	=	in_orig_win_height
//	dw_1.height = in_orginal_dw_height
//	dw_1.width = in_orginal_dw_width
//	cb_close.y = in_orig_close_y
//	cb_close.x = in_orig_close_x
// cb_restore.x = in_orig_restore_x
// cb_restore.y = in_orig_restore_y 
   cb_restore.Enabled = FALSE
end if

//KMM Clear out message parm (PB Bug)
SetNull(message.wordparm)
end event

public function integer wf_dw_title_info ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_parent_details.wf_dw_title_info
//		Event Name:		N/A
//
//  Changes and spaces title, page, date for Subset Common Data window
//
//************************************************************************
//
//GaryR	11/01/2000	2920c	Standardize windows colors
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//////////////////////////////////////////////////////////////////////////

string lv_mod_string, lv_dwm_rc, ls_text
n_cst_string	lnv_string

// Create the report titles for the Common Datawindow
lv_mod_string = "create text(band=Foreground color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'" + &
	"  x=~'450~' y='2' height='32' width=~'" + string(200) + "~' text= '"+UPPER(in_detail_info_struct.title) +"'"+ &
	" name=rpt_hdr_t font.face='System' font.height=~'" + string(-10) + "~' font.weight=~'" + string(700) + &
	"~' font.family='2' font.pitch='2' font.charset='1' font.italic='0' " + &
	" font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + String( stars_colors.window_background ) + "' "
	
//	Set Accessibility Properties
ls_text = lnv_string.of_clean_string_acc( UPPER(in_detail_info_struct.title) )
lv_mod_string += 'accessibledescription="~~"' + ls_text + '~~"~~t~~"' + ls_text + '~~"" accessiblename="~~"' + ls_text + '~~"~~t~~"' + ls_text + '~~"" accessiblerole=42 ) '
lv_dwm_rc = DW_1.Modify(lv_mod_string)

//  Create the Report Date
lv_mod_string = " create compute(band=Foreground color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'" + &
	" x='800' y='2' height='16' width='114' " + &
	" format='mm/dd/yy hh:mm' expression='today()' font.face='System' font.height='-10' "+ &
	" font.face='System' font.weight=~'" + string(700) + "~' font.family='2'" + &
	" font.pitch='2' font.charset='1' font.italic='0' font.strikethrough='0' font.underline='0' " + &
	" background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Report Date~~"~~t~~"Report Date~~"" accessiblename="~~"Report Date~~"~~t~~"Report Date~~"" accessiblerole=42 ) '
lv_dwm_rc = DW_1.Modify(lv_mod_string)

//  Create the Report page #
lv_mod_string = " create compute(band=foreground color='" + String( stars_colors.window_text ) + "' alignment='0' border='0' " + &
	" x='900' y='2' height='16' width='95' format='[GENERAL]' " + &
	" expression=~'~~~'    Page ~~~' + page()~' font.face='System' font.height='-10' " + &
	" font.weight=~'" + string(700) + "~' font.family='2' font.pitch='2' font.charset='1' font.italic='0' font.strikethrough='0' font.underline='0' " + &
	" background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Page Count~~"~~t~~"Page Count~~"" accessiblename="~~"Page Count~~"~~t~~"Page Count~~"" accessiblerole=42 ) '
lv_dwm_rc = DW_1.Modify(lv_mod_string)
return 0
end function

public function integer wf_delete_array ();w_parent_details lv_win_temp[],lv_clear_array[]
int lv_counter,lv_counter2,lv_upperbound
lv_counter2 = 1

lv_upperbound = UPPERBOUND(sh_detail_windows)
for lv_counter = 1 to lv_upperbound 
	if w_main.getactivesheet() <> sh_detail_windows[lv_counter] Then		
		lv_win_temp[lv_counter2]= sh_detail_windows[lv_counter]
		lv_counter2++
	end if
Next

sh_detail_windows[] = lv_clear_array[]
sh_detail_windows[] = lv_win_temp[]

RETURN 0
end function

public function integer wf_switch ();int lv_x,lv_y,lv_old_x,lv_old_y,lv_counter,lv_start,lv_upperbound
window lv_win_temp,lv_active_sheet
boolean lv_done


lv_upperbound = upperbound(sh_detail_windows)

lv_counter = 1
do while lv_counter <= lv_upperbound
	if sh_detail_windows[lv_counter] = w_main.getactivesheet() Then
		lv_start = lv_counter
		lv_x = sh_detail_windows[lv_counter].x
		lv_y = sh_detail_windows[lv_counter].y
		exit
	end if
	lv_counter++
loop

lv_active_sheet = w_main.getactivesheet()

lv_upperbound = upperbound(sh_detail_windows)

for lv_counter = lv_start to lv_upperbound 
	if lv_counter + 1 > upperbound(sh_detail_windows) Then
		lv_win_temp = lv_active_sheet
	elseif sh_detail_windows[lv_counter].X <> sh_detail_windows[lv_counter+1].X  then
		lv_win_temp = lv_active_sheet
		lv_done = TRUE
	else
		lv_win_temp = sh_detail_windows[lv_counter+1]
	end if
	lv_old_x = lv_win_temp.x
	lv_old_y = lv_win_temp.y
	sh_detail_windows[lv_counter] = lv_win_temp
	sh_detail_windows[lv_counter].x = lv_x
	sh_detail_windows[lv_counter].y = lv_y
	lv_x = lv_old_x
	lv_y = lv_old_y
	if lv_done = TRUE Then
		exit
	end if
next 
return 0
end function

event open;call super::open;//****************************TITLE*********************************
//   Date   Init               Description of Changes Made         
// -------- ---- --------------------------------------------------
// 06/05/94 SWD  Created
// 10/16/95 FDG  Connect to Stars2ca before calling labels2.  Add
//					  SetRedraw() to prevent the window from repainting
//					  multiple times.
//	11/08/95 FDG  Rename the subset table (thru fx_open_server_table)
//					  to account for open server.
// 12/06/95 DKG  Access dictionary (elem_type = 'TB') thru
//					  w_main.dw_stars_rel_dict.
//	04/01/96 FDG  Add SetRedraw(TRUE) when exiting the script
//	10/20/97 FDG	Stars 3.6 - Only save the windows dimensions in the
//						open event.  The resize service will take care of
//						the controls' dimensions.
// 06/22/98	FNC	If source is SS lv_transaction should be equal to 
//						stars2ca not stars1ca.
//	10/23/98	FDG	Track 1854.  Fix PB 6.5 error where resize is 
//						getting messed up because w_detail_main.cb_details
//						changes the size of this window AFTER this window
//						is opened.  uo_prepare_detail_win.fuo_maximize_windows
//						will invoke the resize service.
//	04/11/01	FDG	Stars 4.7.	Get table name from Stars Server.
//	09/25/02	GaryR	SPR 3324d	Centralize the logic to format labels
// 10/22/04 MikeF SPR 3650d	Replaced fx_col_select with gnv_dict
//******************************************************************
//DESCRIPTION  																	  
// OF SCRIPT:	This fills the datawindow with rows based from the   
//				where statement sent in.   Depending on what claim	  
//				type is sent in determines what table info comes from
//******************************************************************

//DECLARATION SECTION
string lv_table_type,lv_table_name,lv_dw_object,lv_icn,lv_select,lv_sql
string style,ls_error
int li_rc
long lv_row_count,position
n_tr lv_transaction
w_parent_details lv_clear_array[]
string lv_where_message
string ls_table					// FDG 11/08/95

n_cst_tableinfo_attrib	lnv_table					// FDG 04/11/01
n_cst_labels				lnv_labels					//	09/25/02	GaryR	SPR 3324d

SetPointer(hourglass!)

this.SetRedraw(FALSE)			// FDG 10/16/95

if sh_first_open_flag = FALSE Then
	sh_counter = 0
	sh_counter2 = 0
	sh_do_switch = FALSE
	sh_detail_windows[] = lv_clear_array[]
	sh_first_open_flag = TRUE
end if
sh_counter++
sh_detail_windows[sh_counter] = this

style = ' datawindow(units=1)' + ' style(type = grid) '   //12-24-97 Archana Trk # 193

w_main.Setmicrohelp('Loading '+ in_detail_info_struct.title+' Detail Window') 

in_table_type = in_detail_info_struct.tbl_type
in_window_count = in_detail_info_struct.window_count

	//This sets the x,y and the title for the window//
this.x = in_detail_info_struct.x
this.y = in_detail_info_struct.y
this.title = in_detail_info_struct.title

	//This determines which table the query should go against
lv_table_name =	fx_get_stars_rel_elem_name (in_detail_info_struct.tbl_type)
IF lv_table_name = '' THEN
   lv_where_message = 'elem_type = TB and elem_tbl_type = '+in_detail_info_struct.tbl_type
	this.SetRedraw(TRUE)							// FDG 10/16/95
   Errorbox(Stars2ca,'Error reading the dictionary table: ' + lv_where_message)
   RETURN 
END IF

	//Depending on the src type the transaction is set and the table name
	//is set
if in_detail_info_struct.src_type = 'SB' Then
	// FDG 04/11/01 - Get table names from Stars Server
	//lv_table_name = lv_table_name + string(in_detail_info_struct.table_no)+' '+in_detail_info_struct.tbl_type
	lnv_table.is_inv_type		=	in_detail_info_struct.tbl_type
	lnv_table.is_operand			=	'='
	lnv_table.is_paid_date		=	in_detail_info_struct.paid_date
	lnv_table.il_period_key		=	0
	li_rc								=	gnv_server.of_GetClaimsTableNames (lnv_table)
	IF	lnv_table.il_rc			<	0			THEN
		MessageBox ('Error', lnv_table.is_message)
		Return
	END IF
	IF	UpperBound (lnv_table.is_base_table)	<	1		THEN
		MessageBox ('Application Error', 'Could not retrieve table name in w_parent_details.open.'	+	&
						'  paid_date = '	+	in_detail_info_struct.paid_date	+	'.'	+	&
						'  tbl type = '	+	in_detail_info_struct.tbl_type)
		Return
	END IF
	lv_table_name	=	lnv_table.is_base_table[1]	+	' '	+	in_detail_info_struct.tbl_type
	// FDG 04/11/01 - end
	lv_transaction = stars1ca
elseif in_detail_info_struct.src_type = 'SS' Then
	ls_table = fx_build_subset_table_name(in_detail_info_struct.tbl_type,in_detail_info_struct.subset_id) // VAV 4.0 1/30/98
	lv_table_name = ls_table + ' ' + in_detail_info_struct.tbl_type
	lv_transaction = stars2ca		// FNC 06/22/98
end if

lv_select = 'SELECT ' + gnv_dict.uf_get_select_all( in_detail_info_struct.tbl_type, TRUE )

lv_sql = lv_select+' FROM '+lv_table_name +' '+ in_detail_info_struct.where


	//This dynamically creates the datawindow based from the style and
	//the sql statement
li_rc = Create(dw_1,SyntaxFromSQL(lv_transaction,lv_sql,style,ls_error))
if li_rc = -1 Then
   messagebox("ERROR",'Error Returned From Create:'+ls_error)
	COMMIT Using lv_transaction;		
	this.SetRedraw(TRUE)					
   return
end if
if ls_error <> '' then
   messagebox('Error Returned From Create.',ls_error)
	COMMIT Using lv_transaction;			
	this.SetRedraw(TRUE)						
   return
end if

	//Connects to the datawindow
li_rc = settransobject(dw_1,lv_transaction)
DW_1.RESET()	

//	09/25/02	GaryR	SPR 3324d - Begin
//labels2(dw_1,in_detail_info_struct.tbl_type,'95','40','50')

lnv_labels = Create n_cst_labels
lnv_labels.of_SetDW( dw_1 )
lnv_labels.of_labels2( in_detail_info_struct.tbl_type, "95", "40", "50" )
Destroy lnv_labels
//	09/25/02	GaryR	SPR 3324d - End

wf_dw_title_info()

	//This retrieves the rows
li_rc = retrieve(dw_1)
if li_rc = -1 then
   errorbox(lv_transaction,'Error retrieving for the datawindow')
	close(this)
	return
end if

	//This sets the count box
st_count.text = string(li_rc)

m_popup_menu = create m_detail_menu

//sqlcmd('disconnect',lv_transaction,'',1)		
COMMIT Using lv_transaction;							
IF lv_transaction.of_check_status()	<	0		THEN			
	this.SetRedraw(TRUE)									
	ErrorBox(lv_transaction,'Error on COMMIT')	
END IF														


IF lv_transaction	<> Stars2ca		THEN
	COMMIT Using Stars2ca;								
	IF Stars2ca.of_check_status()	<	0		THEN				
		this.SetRedraw(TRUE)								
		ErrorBox(Stars2ca,'Error on COMMIT')		
	END IF													
END IF

//	FDG	10/20/97 Begin
in_orig_win_x			=	This.x
in_orig_win_y			=	This.y
in_orig_win_width		=	This.width
in_orig_win_height	=	This.height
//	FDG	10/20/97	End

this.SetRedraw(TRUE)			

end event

event activate;call super::activate;if sh_do_switch = FALSE Then
	sh_counter2++
end if
if sh_counter2 = in_window_count Then
	if sh_do_switch = TRUE  Then
		if in_detail_info_struct.side_displayed = 'RIGHT' Then
			w_detail_main.in_u_prepare_right_side.fuo_switch()
		elseif in_detail_info_struct.side_displayed = 'LEFT' Then
			w_detail_main.in_u_prepare_left_side.fuo_switch()
		end if
		
	end if
	sh_do_switch = TRUE
end if

//	FDG 10/20/97	Stars 3.6 - Only save the windows dimensions in the
//						open event.  The resize service will take care of
//						the controls' dimensions.
IF	This.WindowState = Maximized!	THEN
	cb_restore.Enabled = TRUE
END IF

end event

event close;call super::close;window lv_current_win

sh_first_open_flag = FALSE

lv_current_win = this
if in_detail_info_struct.side_displayed = 'RIGHT' Then
	w_detail_main.in_u_prepare_right_side.fuo_delete_from_array(lv_current_win)
elseif in_detail_info_struct.side_displayed = 'LEFT' Then
	w_detail_main.in_u_prepare_left_side.fuo_delete_from_array(lv_current_win)
end if

boolean lv_all_greater_zero_left,lv_all_greater_zero_right
boolean lv_all_equal_zero_left,lv_all_equal_zero_right

lv_all_greater_zero_left = w_detail_main.in_u_prepare_left_side.fuo_check_counts('>ZERO')
lv_all_greater_zero_right = w_detail_main.in_u_prepare_right_side.fuo_check_counts('>ZERO')

//if there all greater than zero than menu item = zero will be disabled
//but if there all = zero then the menu item > zero will be disabled

if lv_all_greater_zero_left = TRUE and lv_all_greater_zero_right = TRUE Then 
	m_popup_menu.m_details.m_print1.m_printcounts01.enabled = FALSE
	m_popup_menu.m_details.m_close.m_closecounts01.enabled = FALSE
end if

lv_all_equal_zero_left = w_detail_main.in_u_prepare_left_side.fuo_check_counts('=ZERO')
lv_all_equal_zero_right = w_detail_main.in_u_prepare_right_side.fuo_check_counts('=ZERO')
if lv_all_equal_zero_left = TRUE and lv_all_equal_zero_right = TRUE Then 
	m_popup_menu.m_details.m_print1.m_printcounts0.enabled = FALSE
	m_popup_menu.m_details.m_close.m_closecounts0.enabled = FALSE
end if



end event

event resize;call super::resize;//
//if this.width = 2802 and this.height = 1792 Then
//	dw_1.height = 1400
//	dw_1.width = 2600
//	cb_close.y = 1530
//	cb_close.x = 2500
//elseif this.width = in_orig_win_width and this.height = in_orig_win_height Then
//	dw_1.height = in_orginal_dw_height
//	dw_1.width = in_orginal_dw_width
//	cb_close.y = in_orig_close_y
//	cb_close.x = in_orig_close_x
//end if
end event

on w_parent_details.create
int iCurrent
call super::create
this.cb_restore=create cb_restore
this.st_count=create st_count
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_restore
this.Control[iCurrent+2]=this.st_count
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_1
end on

on w_parent_details.destroy
call super::destroy
destroy(this.cb_restore)
destroy(this.st_count)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;/////////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	10/23/98	FDG	Track 1854.  Fix PB 6.5 error where resize is 
//						getting messed up because w_detail_main.cb_details
//						changes the size of this window AFTER this window
//						is opened.  uo_prepare_detail_win.fuo_maximize_windows
//						will invoke the resize service.
/////////////////////////////////////////////////////////////////////////////////
	
	//receives the structure from the previous window
in_detail_info_struct = message.Powerobjectparm
	//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

ib_disableresize	=	TRUE			// FDG 10/23/98
end event

event ue_open_rmm;call super::ue_open_rmm;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

boolean lv_all_greater_zero_left,lv_all_greater_zero_right
boolean lv_all_equal_zero_left,lv_all_equal_zero_right

lv_all_greater_zero_left = w_detail_main.in_u_prepare_left_side.fuo_check_counts('>ZERO')
lv_all_greater_zero_right = w_detail_main.in_u_prepare_right_side.fuo_check_counts('>ZERO')

//if there all greater than zero than menu item = zero will be disabled
//but if there all = zero then the menu item > zero will be disabled

if lv_all_greater_zero_left = TRUE and lv_all_greater_zero_right = TRUE Then 
	m_popup_menu.m_details.m_print1.m_printcounts01.enabled = FALSE
	m_popup_menu.m_details.m_close.m_closecounts01.enabled = FALSE
end if

lv_all_equal_zero_left = w_detail_main.in_u_prepare_left_side.fuo_check_counts('=ZERO')
lv_all_equal_zero_right = w_detail_main.in_u_prepare_right_side.fuo_check_counts('=ZERO')
if lv_all_equal_zero_left = TRUE and lv_all_equal_zero_right = TRUE Then 
	m_popup_menu.m_details.m_print1.m_printcounts0.enabled = FALSE
	m_popup_menu.m_details.m_close.m_closecounts0.enabled = FALSE
end if
m_popup_menu.m_details.popmenu(1293,1513)

end event

event rbuttondown;call super::rbuttondown;// 09/04/08	GaryR	SPR 5533	Section 508 1194.21(a) - Keyboard Access

This.event ue_open_rmm()
end event

type cb_restore from u_cb within w_parent_details
string accessiblename = "Restore"
string accessibledescription = "Restore"
integer x = 727
integer y = 668
integer width = 274
integer height = 108
integer taborder = 30
boolean enabled = false
string text = "&Restore"
end type

event clicked;
parent.WindowState = Normal!

// FDG 10/20/97	Stars 3.6
//						Restore the window's dimensions.  The resize
//						will automatically take care of the other
//						window's controls

Parent.x			=	in_orig_win_x
Parent.y			=	in_orig_win_y
Parent.width	=	in_orig_win_width
Parent.height	=	in_orig_win_height
This.Enabled	=	FALSE

end event

type st_count from statictext within w_parent_details
string tag = "colorfixed"
string accessiblename = "Count"
string accessibledescription = "Count"
accessiblerole accessiblerole = statictextrole!
integer x = 23
integer y = 4
integer width = 352
integer height = 72
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

type cb_close from u_cb within w_parent_details
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 1051
integer y = 668
integer width = 274
integer height = 108
integer taborder = 10
string text = "&Close"
end type

on clicked;

close (parent)

end on

type dw_1 from u_dw within w_parent_details
string accessiblename = "Restore"
string accessibledescription = "Restore"
integer x = 18
integer y = 88
integer width = 1312
integer height = 560
integer taborder = 20
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_singleselect = true
end type

on rbuttondown;fx_lookup(dw_1,in_table_type)
end on

