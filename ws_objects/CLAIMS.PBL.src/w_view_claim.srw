$PBExportHeader$w_view_claim.srw
$PBExportComments$Inherited from w_master
forward
global type w_view_claim from w_master
end type
type pb_2 from picturebutton within w_view_claim
end type
type pb_1 from picturebutton within w_view_claim
end type
type cb_rec_type from u_cb within w_view_claim
end type
type cb_close from u_cb within w_view_claim
end type
type dw_1 from u_dw within w_view_claim
end type
end forward

global type w_view_claim from w_master
string accessiblename = "Claim Information"
string accessibledescription = "Claim Information"
integer x = 169
integer y = 0
integer width = 3291
integer height = 2192
string title = "Claim Information"
pb_2 pb_2
pb_1 pb_1
cb_rec_type cb_rec_type
cb_close cb_close
dw_1 dw_1
end type
global w_view_claim w_view_claim

type variables
string in_table_type
string iv_line_no_name   //DKG 1/11/96
sx_details_structure in_claim_info_struct
end variables

forward prototypes
public function integer wf_initialize_win ()
public subroutine wf_gen_dynamic_ffdw (string tb_name, ref n_tr tb_transaction)
end prototypes

public function integer wf_initialize_win ();//************************************************************************
//		Object Type:	Window function
//		Object Name:	w_view_claim.wf_initialize_win
//		Event Name:		N/A
//
//  2 changes from gv_sys_dflt to gv_ss_parms.gsv_subset_lob
//
//************************************************************************
//
//	FDG 11/08/95	Rename the subset table (thru fx_open_server_table)
//						to account for open server.
// DKG 12/06/95   Access dictionary (elem_type = 'TB') thru
//					   w_main.dw_stars_rel_dict.
// NLG 10-27-97   Clean up label
// JGG 03-11-98	STARS 4.0 - TS145 Executable changes
//						Replace fx_open_server_name with fx_build_subset_table_name
// FNC 02/08/00	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//	FDG 03/14/01	Stars 4.7.	Get the table name from in_claim_info_struct.
//						table_no is no longer used because ros_directory is no longer used.
//	GaryR	07/09/01	Move global function fx_gen_dynamic_ffdw to window level (wf_gen_dynamic_ffdw)
//	GaryR	03/13/06	Track 4684	Get the Subset database name from dictionary
//	GaryR	09/11/06	Track 4816	Convert the FastTrack invoice type to Revenue type
//	GaryR	02/09/07	Track 4572	Redesign screen/logic for to handle NPI
//************************************************************************

string lv_table_name,lv_key_value,lv_visible,lv_dw_object,lv_select
string lv_sql,lv_sys_id,lv_case_id,lv_case_id_spl,lv_case_id_ver
string lv_line_no_name,lv_butt_label,lv_line_no_label
n_tr lv_transaction
in_table_type = in_claim_info_struct.tbl_type
long rc,position,lv_position
boolean lv_get_line_no
string lv_where_message
string ls_table							// FDG 11/08/95
string ls_text                      // NLG 10-27-97
String ls_sub_db
String ls_main_table, ls_rev_table
n_cst_revenue	lnv_rev

lv_sys_id				=	gv_sys_dflt
lv_transaction	 		= 	stars1ca

//This sets the correct transaction and table name based on the
//src_type
Choose Case in_claim_info_struct.src_type 
	Case 'SB'
		lv_table_name	=	in_claim_info_struct.table_name
		lv_table_name 	= 	lv_table_name 									&
						  	+ 	' ' 												&
							+ 	in_claim_info_struct.tbl_type
	Case 'SS'
		// Convert FastTrack invoice type
		IF Left( in_claim_info_struct.tbl_type, 1 ) = 'Q' THEN
			lnv_rev = Create n_cst_revenue
			ls_main_table = lnv_rev.of_get_main_table(in_claim_info_struct.tbl_type)
			ls_rev_table = lnv_rev.of_get_revenue(ls_main_table)
			Destroy lnv_rev
			
			ls_table			= 	fx_build_subset_table_name(ls_rev_table,	&
													in_claim_info_struct.subset_id)
		ELSE
			ls_table			= 	fx_build_subset_table_name(in_claim_info_struct.tbl_type,	&
																	in_claim_info_struct.subset_id)
		END IF
		
		// Get database prefix
		SELECT db 
		INTO	:ls_sub_db
		FROM	dictionary 
		WHERE	elem_type = 'UT'
		AND	elem_tbl_type = 'SS'
		USING	Stars2ca;
		
		IF stars2ca.of_check_status() <> 0 OR IsNull( ls_sub_db ) THEN
			MessageBox( "ERROR", "Error reading dictionary to retrieve subset database name" )
			Return -1
		END IF
		
		stars2ca.of_commit()	
		ls_table 		=	gnv_sql.of_get_database_prefix( ls_sub_db ) + ls_table
		lv_table_name 	= 	ls_table 										&
							+ 	' '												&
							+	in_claim_info_struct.tbl_type
End Choose

// JGG 03/11/98 - end of changes


//This gets the label for the key value and the name of the key value
SELECT DT.ELEM_ELEM_LABEL,WP.COL_NAME INTO :ls_text,:lv_key_value 
FROM STARS_WIN_PARM WP, DICTIONARY DT
WHERE WP.WIN_ID = '*' AND
		WP.SYS_ID = Upper( :lv_sys_id ) AND
		WP.CNTL_ID = 'ICN_DEF' AND
		WP.TBL_TYPE = Upper( :in_table_type ) AND
		DT.ELEM_TYPE = 'CL' AND
		DT.ELEM_TBL_TYPE = Upper( :in_claim_info_struct.tbl_type ) AND
		WP.COL_NAME = DT.ELEM_NAME
USING stars2ca;

if stars2ca.of_check_status() = 100 Then
	lv_where_message = 'WIN_ID = * AND SYS_ID = ' + lv_sys_id + ' AND CNTL_ID = ICN_DEF AND TBL_TYPE = ' + in_table_type + ' AND ELEM_TYPE = CL AND ELEM_TBL_TYPE = ' + in_claim_info_struct.tbl_type + ' AND COL_NAME = ELEM_NAME'
	errorbox(stars2ca,'No Records found: ' + lv_where_message)
	return -1
elseif stars2ca.sqlcode <> 0 Then 
	lv_where_message = 'WIN_ID = * AND SYS_ID = ' + lv_sys_id + ' AND CNTL_ID = ICN_DEF AND TBL_TYPE = ' + in_table_type + ' AND ELEM_TYPE = CL AND ELEM_TBL_TYPE = ' + in_claim_info_struct.tbl_type + ' AND COL_NAME = ELEM_NAME'
	errorbox(stars2ca,'Error reading the dictionary table: ' + lv_where_message)
	return -1
end if

SELECT Label,Attrib INTO :lv_butt_label,:lv_visible
FROM STARS_WIN_PARM 
WHERE WIN_ID = 'W_VIEW_CLAIM' AND
		SYS_ID = Upper( :lv_sys_id ) AND
		CNTL_ID = 'CB_REC_TYPE_DEF' AND
		TBL_TYPE = Upper( :in_table_type )
USING stars2ca;
if stars2ca.of_check_status() = 100 Then
	lv_where_message = 'WIN_ID = w_view_claim AND SYS_ID = ' + lv_sys_id + ' AND CNTL_ID = CB_REC_TYPE_DEF AND TBL_TYPE = ' + in_table_type 
	errorbox(stars2ca,'No Records found: ' + lv_where_message)
	return -1
elseif stars2ca.sqlcode <> 0 Then 
	lv_where_message = 'WIN_ID = w_view_claim AND SYS_ID = ' + lv_sys_id + ' AND CNTL_ID = CB_REC_TYPE_DEF AND TBL_TYPE = ' + in_table_type 
	errorbox(stars2ca,'Error reading the win parm table: ' + lv_where_message)
	return -1
end if
if lv_visible = 'V' then
	cb_rec_type.visible = TRUE
elseif lv_visible = 'I' then
	cb_rec_type.visible = FALSE
end if 

COMMIT Using Stars2ca;							
IF Stars2ca.of_check_status()	<	0		THEN			
	ErrorBox(Stars2ca,'Error on COMMIT')	
END IF												

//connects the datawindow//
rc = settransobject(dw_1,lv_transaction)
DW_1.RESET()	

if rc= -1 then
   errorbox(lv_transaction,'Error connecting to the data window')
   cb_close.Postevent(clicked!)	
   return -1
end if

//This gets the current SQL statement from the datawindow

this.title = in_claim_info_struct.title
cb_rec_type.text = lv_butt_label

wf_gen_dynamic_ffdw(lv_table_name, lv_transaction)

// Need to disconnect Stars 2, if currently connected
// to Stars 1, after returning from the function.  SG Aug 94

If lv_transaction = stars1ca Then
	IF Stars2ca.of_commit()	<	0		THEN			
		ErrorBox(Stars2ca,'Error on COMMIT')
	END IF												
End If

IF lv_transaction.of_commit()	<	0		THEN			
	ErrorBox(lv_transaction,'Error on COMMIT')
END IF														

if in_claim_info_struct.tbl_type2 = '' Then cb_rec_type.visible = FALSE
return 0
end function

public subroutine wf_gen_dynamic_ffdw (string tb_name, ref n_tr tb_transaction);//************************************************************************
//		Object Type:	w_view_claim
//		Object Name:	wf_gen_dynamic_ffdw
//		Event Name:		N/A
//
//08/04/94 Youxiong Pang
//
//This global function is another version of fx_gen_std_freeformdw,
//instead of opening window w_freeform which contains a standard 
//freeform dw, it directly creates a freeform dw and associates it with
//the dw control as the passing in parm. It has two parms:
//
//  tb_name: It is a string of the table name, the data from this table
//           will be displayed in the freeform dw. 
//  where_clause: 
//           It is a string specifying the criteria for selecting data,
//           Make sure it starts with "where" and follows the syntax of 
//           where clause in SQL command.
//  tb_transaction:
//           It is a transaction object for the table, pass in by reference. 
//
//************************************************************************
//
// FDG 11/30/95	1.	Removed the cursor and replaced it with accessing
//							w_main.dw_dictionary_hidden.  This is done thru
//							fx_retrieve_dictionary.
//						2.	Combine & rename dwModifys (to Modify)
//						3.	Rename dwdescribe to Describe, dwcreate to Create
// DKG 12/18/95      Reversed the cursor change from 11/30/95.
//	FDG 03/31/99	Track 2220c (4.0 SP2).  Decrease row_distance so that
//						all columns can fit on one page.  This is a quick &
//						dirty solution to the page # problems because clients
//						can have many "plus" fields aded to the claim tables.
//************************************************************************
// GaryR	07/09/01	Moved this method to window level
//	GaryR	02/09/07	Track 4572	Redesign screen/logic for to handle NPI
//	GaryR	02/19/07	Track 4572	Trim the label descriptions
//	GaryR	03/22/07	Track 4572	Account for NULL disp_format
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//************************************************************************

String	ls_select, ls_where, ls_sql, ls_syntax, ls_err, ls_col_name, &
			ls_claim, ls_line, ls_label, ls_format, ls_datatype, &
			ls_gen = "[general]", ls_width
Integer	li_col, li_cnt, li_width, li_pix = 30
n_cst_string	lnv_string

ls_where = in_claim_info_struct.where
IF Len( ls_where ) < 9 THEN ls_where = ""

ls_select = gnv_dict.uf_get_select_all( Upper( in_claim_info_struct.tbl_type ), TRUE )
ls_sql = "SELECT " + ls_select + " FROM " + tb_name + " " + ls_where

ls_syntax = "datawindow(units=0 ) style(type=form) Column(font.Face=" + &
				"'Microsoft Sans Serif') Text(font.Face='Microsoft Sans Serif')"

ls_syntax = tb_transaction.SyntaxFromSQL ( ls_sql, ls_syntax, ls_err )
IF ls_err <> "" THEN
	MessageBox ( "Error", "The following errors occurred during the execution of SyntaxFromSQL: " + ls_err )
	Return
END IF
 
IF dw_1.Create( ls_syntax, ls_err ) < 0 THEN
	MessageBox ("Error", "The following errors occurred during the execution of datawindow:"  + ls_err )
	Return           
END IF

//	Modify DW
ls_syntax = "DataWindow.print.orientation='2' DataWindow.Header.Height='152' "

//	Set column/text properties
li_cnt = Integer( dw_1.Object.DataWindow.Column.Count )
FOR li_col = 1 TO li_cnt
	// Get the object name from the datawindow
	ls_col_name 	= 	dw_1.Describe('#' + string(li_col) + '.name')
	
	//	Get the label and format
	ls_label = Trim( gnv_dict.Event ue_get_col_desc( in_claim_info_struct.tbl_type, Upper( ls_col_name ) ) )
	ls_format = gnv_dict.Event ue_get_disp_format( in_claim_info_struct.tbl_type, Upper( ls_col_name ) )
	ls_datatype = gnv_dict.Event ue_get_data_type( in_claim_info_struct.tbl_type, Upper( ls_col_name ) )
	
	//	Reset
	ls_label += ":"
	ls_width = ""
	
	//	Get format based on datatype
	IF NOT gnv_sql.of_is_character_data_type( ls_datatype ) THEN
		IF IsNull( ls_format ) OR Trim( ls_format ) = "" THEN
			ls_format = ls_gen
		ELSE
			li_width = Len( ls_format ) * li_pix
			ls_width = ls_col_name + ".Width='" + String( li_width ) + "' "
		END IF
	ELSE
		ls_format = ls_gen
	END IF
	
	//	Set computes
	IF Upper( ls_col_name ) = "ICN" THEN
		ls_claim = "'" + ls_label + " ' +  icn"
	ELSEIF Upper( ls_col_name ) = "ICN_LINE_NO" THEN
		ls_line = "'" + ls_label + " ' + getrow() + ' of ' + rowcount()"
	END IF
	
	//	Generate the modify syntax
	ls_syntax += ls_col_name + ".Font.Height='-8' " + ls_col_name + ".Height='72' " + &
				ls_col_name + ".Format='" + ls_format + "' " + ls_width + &
				ls_col_name + ".Color='" + String( stars_colors.window_text ) + "' " + &
				ls_col_name + ".Background.Color='" + String( stars_colors.window_background ) + "' " + &
				ls_col_name + "_t.Background.Color='" + String( stars_colors.window_background ) + "' " + &
				ls_col_name + "_t.Border='0' " + ls_col_name + "_t.Color='" + String( stars_colors.highlight ) + "' " + &
				ls_col_name + "_t.Font.Height='-8' " + ls_col_name + "_t.Font.Weight='700' " + &
				ls_col_name + "_t.Height='72' " + ls_col_name + "_t.Text='" + ls_label + "' "
				
	//	Set Accessibility Properties
	ls_label = lnv_string.of_clean_string_acc( ls_label )
	ls_label = '"' + ls_label + '"~t"' + ls_label + '"'
	ls_syntax += ls_col_name + ".AccessibleName='" + ls_label + "' "
	ls_syntax += ls_col_name + ".AccessibleDescription='" + ls_label + "' "
	ls_syntax += ls_col_name + ".AccessibleRole='27' "	//	ColumnRole!
	ls_syntax += ls_col_name + "_t.AccessibleName='" + ls_label + "' "
	ls_syntax += ls_col_name + "_t.AccessibleDescription='" + ls_label + "' "
	ls_syntax += ls_col_name + "_t.AccessibleRole='42' "	//	TextRole!
NEXT

ls_syntax += 'create compute(band=header alignment="0" expression="' + ls_claim + '" border="0" color="' + String( stars_colors.highlight ) + '" x="37" y="20" height="80" width="1477" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Microsoft Sans Serif" font.height="-12" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="' + String( stars_colors.transparent ) + '" accessibledescription="~~"Claim Number~~"~~t~~"Claim Number~~"" accessiblename="~~"Claim Number~~"~~t~~"Claim Number~~"" accessiblerole=42 ) '
ls_syntax += 'create compute(band=header alignment="2" expression="' + ls_line + '" border="0" color="' + String( stars_colors.highlight ) + '" x="1541" y="20" height="80" width="919" format="[GENERAL]" html.valueishtml="0"  name=compute_4 visible="1~~tif( RowCount() > 1, 1, 0)"  font.face="Microsoft Sans Serif" font.height="-12" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="' + String( stars_colors.transparent ) + '" accessibledescription="~~"Claim Line Number~~"~~t~~"Claim Line Number~~"" accessiblename="~~"Claim Line Number~~"~~t~~"Claim Line Number~~"" accessiblerole=42 ) '
ls_syntax += 'create compute(band=header alignment="1" expression="~'Printed on: ~' + String( today(), ~'mm/dd/yyyy~')" border="0" color="' + String( stars_colors.highlight ) + '" x="2514" y="20" height="80" width="923" format="[GENERAL]" html.valueishtml="0"  name=compute_5 visible="1"  font.face="Microsoft Sans Serif" font.height="-12" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="' + String( stars_colors.transparent ) + '" accessibledescription="~~"Print Date~~"~~t~~"Print Date~~"" accessiblename="~~"Print Date~~"~~t~~"Print Date~~"" accessiblerole=42 ) '
ls_syntax += 'create line(band=header x1="27" y1="120" x2="3438" y2="120"  name=line_1 visible="1" pen.style="0" pen.width="5" pen.color="' + String( stars_colors.highlight ) + '"  background.mode="2" background.color="' + String( stars_colors.transparent ) + '" )'

ls_err = dw_1.Modify( ls_syntax )
fx_dw_syntax( This.classname(), dw_1, istr_decode_struct, tb_transaction )
dw_1.SetTransObject( tb_transaction )
dw_1.Retrieve()
end subroutine

event open;call super::open;//*********************************************************************************
// Script Name:	w_view_claim.open
//
// Arguments: n/a
//
// Returns:		long
//
// Description:	This script retrieves one row of full claim and		  
//					displays it.
//
//*********************************************************************************
//
// 06/12/94 SWD  			Created														  
// 10/03/94 SG   			Enable user to scroll through records in the data 
//               					window (if there are more than one)                             
// 02/08/00		FNC 		TS2072 Unique Key - Add flexiblity for client to select
//								custom claim key fields.
//	12/14/00		FDG 		Stars 4.7.  Make the checking of data types DBMS-independent.
//	02/09/07		GaryR	Track 4572	Redesign screen/logic for to handle NPI
//	05/27/09		Katie		GNL.600.5633	Set focus on the window after it opens.  
//**************************************************************************

//DECLARATION SECTION

int rc, li_row, li_rowcount
string 	ls_key1_value,	&
			ls_key2_value,	&
			ls_key3_value,	&
			ls_key4_value,	&
			ls_key5_value,	&
			ls_key6_value
boolean	lb_not_equal

rc = wf_initialize_win()
if rc = -1 then return

if dw_1.RowCount() > 1 Then  
   pb_1.visible = true
   pb_2.visible = true
//FNC 02/08/00 Start
//	for lv_row = 1 to dw_1.rowcount()			
//		lv_line_no = dw_1.getitemnumber(lv_row,"icn_line_no")
//		if in_claim_info_struct.line_no <> lv_line_no Then
//			pb_1.triggerevent(clicked!)
//		else
//			exit
//		end if
//	next
	li_rowcount = dw_1.rowcount()
	for li_row = 1 to li_rowcount	
		lb_not_equal = FALSE
		if trim(in_claim_info_struct.key1_name) <> ''  then
			// FDG 12/14/00 - Make data type checking DBMS-independent
			//CHOOSE CASE Upper(in_claim_info_struct.key1_data_type)
			//	CASE 'CHAR', 'VARCHAR', '', '*'
			//		ls_key1_value = dw_1.getitemstring(li_row,in_claim_info_struct.key1_name)
			//	CASE 'DATE', 'DATETIME', 'SMALLDATETIME'
			//		ls_key1_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key1_name),'mm/dd/yyyy')
			//	CASE 'MONEY', 'SMALLMONEY', 'FLOAT'
			//		ls_key1_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key1_name))
			//	CASE ELSE
			//		ls_key1_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key1_name))
			//END CHOOSE
			IF	gnv_sql.of_is_character_data_type (in_claim_info_struct.key1_data_type)	&
			OR	in_claim_info_struct.key1_data_type	=	'*'										&
			OR	in_claim_info_struct.key1_data_type	=	''											THEN
				ls_key1_value	=	dw_1.getitemstring(li_row,in_claim_info_struct.key1_name)
			ELSEIF gnv_sql.of_is_date_data_type (in_claim_info_struct.key1_data_type)	THEN
				ls_key1_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key1_name),'mm/dd/yyyy')
			ELSEIF gnv_sql.of_is_money_data_type (in_claim_info_struct.key1_data_type)	THEN
				ls_key1_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key1_name))
			ELSE
				ls_key1_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key1_name))
			END IF
			// FDG 12/14/00 end
			if in_claim_info_struct.key1_value <> ls_key1_value then
				lb_not_equal = TRUE
			end if
		else
			if lb_not_equal then
				pb_1.triggerevent(clicked!)
				continue
			else
				exit
			end if
		end if
		
		if trim(in_claim_info_struct.key2_name) <> ''  then
			// FDG 12/14/00 - Make data type checking DBMS-independent
			//CHOOSE CASE Upper(in_claim_info_struct.key2_data_type)
			//	CASE 'CHAR', 'VARCHAR', '', '*'
			//		ls_key2_value = dw_1.getitemstring(li_row,in_claim_info_struct.key2_name)
			//	CASE 'DATE', 'DATETIME', 'SMALLDATETIME'
			//		ls_key2_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key2_name),'mm/dd/yyyy')
			//	CASE 'MONEY', 'SMALLMONEY', 'FLOAT'
			//		ls_key2_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key2_name))
			//	CASE ELSE
			//		ls_key2_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key2_name))
			//END CHOOSE
			IF	gnv_sql.of_is_character_data_type (in_claim_info_struct.key2_data_type)	&
			OR	in_claim_info_struct.key2_data_type	=	'*'										&
			OR	in_claim_info_struct.key2_data_type	=	''											THEN
				ls_key2_value	=	dw_1.getitemstring(li_row,in_claim_info_struct.key2_name)
			ELSEIF gnv_sql.of_is_date_data_type (in_claim_info_struct.key2_data_type)	THEN
				ls_key2_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key2_name),'mm/dd/yyyy')
			ELSEIF gnv_sql.of_is_money_data_type (in_claim_info_struct.key2_data_type)	THEN
				ls_key2_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key2_name))
			ELSE
				ls_key2_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key2_name))
			END IF
			// FDG 12/14/00 end
			if in_claim_info_struct.key2_value <> ls_key2_value then
				lb_not_equal = TRUE
			end if
		else
			if lb_not_equal then
				pb_1.triggerevent(clicked!)
				continue				
			else
				exit
			end if
		end if
		
		if trim(in_claim_info_struct.key3_name) <> ''  then
			// FDG 12/14/00 - Make data type checking DBMS-independent
			//CHOOSE CASE Upper(in_claim_info_struct.key3_data_type)
			//	CASE 'CHAR', 'VARCHAR', '', '*'
			//		ls_key3_value = dw_1.getitemstring(li_row,in_claim_info_struct.key3_name)
			//	CASE 'DATE', 'DATETIME', 'SMALLDATETIME'
			//		ls_key3_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key3_name),'mm/dd/yyyy')
			//	CASE 'MONEY', 'SMALLMONEY', 'FLOAT'
			//		ls_key3_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key3_name))
			//	CASE ELSE
			//		ls_key3_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key3_name))
			//END CHOOSE
			IF	gnv_sql.of_is_character_data_type (in_claim_info_struct.key3_data_type)	&
			OR	in_claim_info_struct.key3_data_type	=	'*'										&
			OR	in_claim_info_struct.key3_data_type	=	''											THEN
				ls_key3_value	=	dw_1.getitemstring(li_row,in_claim_info_struct.key3_name)
			ELSEIF gnv_sql.of_is_date_data_type (in_claim_info_struct.key3_data_type)	THEN
				ls_key3_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key3_name),'mm/dd/yyyy')
			ELSEIF gnv_sql.of_is_money_data_type (in_claim_info_struct.key3_data_type)	THEN
				ls_key3_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key3_name))
			ELSE
				ls_key3_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key3_name))
			END IF
			// FDG 12/14/00 end
			if in_claim_info_struct.key3_value <> ls_key3_value then
				lb_not_equal = TRUE
			end if
		else
			if lb_not_equal then
				pb_1.triggerevent(clicked!)
				continue
			else
				exit
			end if
		end if
		
		if trim(in_claim_info_struct.key4_name) <> ''  then
			// FDG 12/14/00 - Make data type checking DBMS-independent
			//CHOOSE CASE Upper(in_claim_info_struct.key4_data_type)
			//	CASE 'CHAR', 'VARCHAR', '', '*'
			//		ls_key4_value = dw_1.getitemstring(li_row,in_claim_info_struct.key4_name)
			//	CASE 'DATE', 'DATETIME', 'SMALLDATETIME'
			//		ls_key4_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key4_name),'mm/dd/yyyy')
			//	CASE 'MONEY', 'SMALLMONEY', 'FLOAT'
			//		ls_key4_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key4_name))
			//	CASE ELSE
			//		ls_key4_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key4_name))
			//END CHOOSE
			IF	gnv_sql.of_is_character_data_type (in_claim_info_struct.key4_data_type)	&
			OR	in_claim_info_struct.key4_data_type	=	'*'										&
			OR	in_claim_info_struct.key4_data_type	=	''											THEN
				ls_key4_value	=	dw_1.getitemstring(li_row,in_claim_info_struct.key4_name)
			ELSEIF gnv_sql.of_is_date_data_type (in_claim_info_struct.key4_data_type)	THEN
				ls_key4_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key4_name),'mm/dd/yyyy')
			ELSEIF gnv_sql.of_is_money_data_type (in_claim_info_struct.key4_data_type)	THEN
				ls_key4_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key4_name))
			ELSE
				ls_key4_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key4_name))
			END IF
			// FDG 12/14/00 end
			if in_claim_info_struct.key4_value <> ls_key4_value then
				lb_not_equal = TRUE
			end if
		else			
			if lb_not_equal then
				pb_1.triggerevent(clicked!)
				continue
			else
				exit
			end if
		end if		
		
		if trim(in_claim_info_struct.key5_name) <> ''  then
			// FDG 12/14/00 - Make data type checking DBMS-independent
			//CHOOSE CASE Upper(in_claim_info_struct.key5_data_type)
			//	CASE 'CHAR', 'VARCHAR', '', '*'
			//		ls_key5_value = dw_1.getitemstring(li_row,in_claim_info_struct.key5_name)
			//	CASE 'DATE', 'DATETIME', 'SMALLDATETIME'
			//		ls_key5_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key5_name),'mm/dd/yyyy')
			//	CASE 'MONEY', 'SMALLMONEY', 'FLOAT'
			//		ls_key5_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key5_name))
			//	CASE ELSE
			//		ls_key5_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key5_name))
			//END CHOOSE
			IF	gnv_sql.of_is_character_data_type (in_claim_info_struct.key5_data_type)	&
			OR	in_claim_info_struct.key5_data_type	=	'*'										&
			OR	in_claim_info_struct.key5_data_type	=	''											THEN
				ls_key5_value	=	dw_1.getitemstring(li_row,in_claim_info_struct.key5_name)
			ELSEIF gnv_sql.of_is_date_data_type (in_claim_info_struct.key5_data_type)	THEN
				ls_key5_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key5_name),'mm/dd/yyyy')
			ELSEIF gnv_sql.of_is_money_data_type (in_claim_info_struct.key5_data_type)	THEN
				ls_key5_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key5_name))
			ELSE
				ls_key5_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key5_name))
			END IF
			// FDG 12/14/00 end
			if in_claim_info_struct.key5_value <> ls_key5_value then
				lb_not_equal = TRUE
			end if
		else
			if lb_not_equal then
				pb_1.triggerevent(clicked!)
				continue
			else
				exit
			end if
		end if			
		
		if trim(in_claim_info_struct.key6_name) <> ''  then
			// FDG 12/14/00 - Make data type checking DBMS-independent
			//CHOOSE CASE Upper(in_claim_info_struct.key6_data_type)
			//	CASE 'CHAR', 'VARCHAR', '', '*'
			//		ls_key6_value = dw_1.getitemstring(li_row,in_claim_info_struct.key6_name)
			//	CASE 'DATE', 'DATETIME', 'SMALLDATETIME'
			//		ls_key6_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key6_name),'mm/dd/yyyy')
			//	CASE 'MONEY', 'SMALLMONEY', 'FLOAT'
			//		ls_key6_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key6_name))
			//	CASE ELSE
			//		ls_key6_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key6_name))
			//END CHOOSE
			IF	gnv_sql.of_is_character_data_type (in_claim_info_struct.key6_data_type)	&
			OR	in_claim_info_struct.key6_data_type	=	'*'										&
			OR	in_claim_info_struct.key6_data_type	=	''											THEN
				ls_key6_value	=	dw_1.getitemstring(li_row,in_claim_info_struct.key6_name)
			ELSEIF gnv_sql.of_is_date_data_type (in_claim_info_struct.key6_data_type)	THEN
				ls_key6_value = string(dw_1.getitemdate(li_row,in_claim_info_struct.key6_name),'mm/dd/yyyy')
			ELSEIF gnv_sql.of_is_money_data_type (in_claim_info_struct.key6_data_type)	THEN
				ls_key6_value = string(dw_1.getitemdecimal(li_row,in_claim_info_struct.key6_name))
			ELSE
				ls_key6_value = string(dw_1.getitemnumber(li_row,in_claim_info_struct.key6_name))
			END IF
			// FDG 12/14/00 end
			if in_claim_info_struct.key6_value <> ls_key6_value then
				lb_not_equal = TRUE
			end if
		else
			if lb_not_equal then
				pb_1.triggerevent(clicked!)
				continue
			else
				exit
			end if
		end if
		
		/*this checks for key6 */
		if lb_not_equal then
				pb_1.triggerevent(clicked!)
		else
			exit
		end if
		
Next

// FNC 02/08/00 End
End if

dw_1.setfocus()
end event

on w_view_claim.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.cb_rec_type=create cb_rec_type
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.cb_rec_type
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_1
end on

on w_view_claim.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.cb_rec_type)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;
//receives the structur parm from the last window
in_claim_info_struct = message.Powerobjectparm

//KMM Clear out message parm (PB Bug)
SetNull(message.powerobjectparm)

end event

type pb_2 from picturebutton within w_view_claim
boolean visible = false
string accessiblename = "Prior"
string accessibledescription = "Prior"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1134
integer y = 1952
integer width = 247
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
boolean enabled = false
string picturename = "prior1.bmp"
string disabledname = "prior2.bmp"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;//**************************************************************************
// FNC 02/08/00	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//**************************************************************************

pb_1.enabled = true 
dw_1.ScrollPriorPage() 
if dw_1.getrow() = 1 then
  pb_2.enabled= false
end if

//Line number may not be in key.
//st_4.text = string(dw_1.getitemnumber(dw_1.GetRow(),iv_line_no_name)) // 02/08/00



end event

type pb_1 from picturebutton within w_view_claim
boolean visible = false
string accessiblename = "Next"
string accessibledescription = "Next"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1390
integer y = 1952
integer width = 247
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
string picturename = "next1.bmp"
string disabledname = "next2.bmp"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;//**************************************************************************
// FNC 02/08/00	Unique Key TS2072 - Add flexiblity for client to select
//						custom claim key fields.
//**************************************************************************

pb_2.enabled = true
dw_1.ScrollNextPage() 
if dw_1.getrow() = dw_1.rowcount() then
   pb_1.enabled = false
end if

//Icn line no may not be in key
//st_4.text = string(dw_1.getitemnumber(dw_1.GetRow(),iv_line_no_name)) // FNC 02/08/00 


end event

type cb_rec_type from u_cb within w_view_claim
string accessiblename = "Header"
string accessibledescription = "Header"
integer x = 1682
integer y = 1952
integer width = 338
integer height = 108
integer taborder = 50
end type

on clicked;string lv_temp_tbL_type,lv_temp_where,lv_temp_title
int rc

lv_temp_tbl_type = in_claim_info_struct.tbl_type
lv_temp_where = in_claim_info_struct.where
lv_temp_title = in_claim_info_struct.title

in_claim_info_struct.tbl_type = in_claim_info_struct.tbl_type2
in_claim_info_struct.where = in_claim_info_struct.where2
in_claim_info_struct.title = in_claim_info_struct.title2

in_claim_info_struct.tbl_type2 = lv_temp_tbl_type
in_claim_info_struct.where2 = lv_temp_where
in_claim_info_struct.title2 = lv_temp_title

dw_1.setredraw(FALSE)
rc = wf_initialize_win()
if rc = -1 then return
dw_1.setredraw(TRUE)
end on

type cb_close from u_cb within w_view_claim
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2889
integer y = 1952
integer width = 338
integer height = 108
integer taborder = 60
string text = "&Close"
boolean default = true
end type

on clicked;close(parent)
end on

type dw_1 from u_dw within w_view_claim
string accessiblename = "Claim View"
string accessibledescription = "Claim View"
integer x = 37
integer y = 32
integer width = 3182
integer height = 1888
integer taborder = 10
string dataobject = "d_initial"
boolean hscrollbar = true
boolean vscrollbar = true
end type

on rbuttondown;fx_lookup(dw_1,in_table_type)
end on

