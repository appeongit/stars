$PBExportHeader$n_cst_labels.sru
$PBExportComments$Non Visual Object to perform all dictionary label processing (inherited from n_base) <logic>
forward
global type n_cst_labels from n_base
end type
end forward

global type n_cst_labels from n_base
end type
global n_cst_labels n_cst_labels

type variables
// STARS 4.0	Subset Redesign
//		TS144 - labels
//
// Object:		n_cst_labels non visual object 
//		instance variables
//
// Log: 	JGG	01/12/98		Created NVO
//
  
// idw is the datawindow registered to be used by this NVO

Protected		u_dw	idw

end variables

forward prototypes
public function string of_split (string as_splitobject, string as_side, string as_splitat)
public subroutine of_labels2 (string as_table_type)
public subroutine of_labels2 (string as_table_type, string as_hdr_height)
public subroutine of_setdw (u_dw adw)
public subroutine of_labels2 (string as_table_type, string as_hdr_height, string as_col_height)
public subroutine of_labels2 (string as_table_type, string as_hdr_height, string as_col_height, string as_col_y)
public subroutine of_trk_info_width (string as_trk_type)
end prototypes

public function string of_split (string as_splitobject, string as_side, string as_splitat);// STARS 4.0		Subset Redesign
//						TS144 - labels
//
// Object:			n_cst_labels non visual object 
//	Object Type:	function
//
// Log: 				JGG	01/12/98		Created NVO
//
// 
// This function will accept a string with a tab separator in it (i.e. ~t), 
// a parm indicating which side to split from and return ( L=left, R=right), 
// and what character to split on (i.e. ~t).  
// If the right side of the string is required, the contents of the string to the right of the 
// search character will be returned.  
// If the left side of the string is required, the contents of the string to the left of the 
// search character will be returned.
// If the search character is not found or the side to split parm is invalid, 
// this function will return the original value.

int					li_char_pos
string				ls_split
string				ls_orig_string

// Determine if the search character exists within the search string.  Return the original
// string value if search character is not found.

ls_orig_string	=	as_splitobject
li_char_pos		=	Pos(as_splitobject, as_splitat)

If li_char_pos = 0 Then
	RETURN '-1'
End if

// Left side processing

If Upper(as_side) = 'L' &
Or Upper(as_side) = 'LEFT' Then
   ls_split		=	Left(as_splitobject, (li_char_pos - 1))
	RETURN			ls_split
End if

// Right side processing

If Upper(as_side) = 'R' &
Or Upper(as_side) = 'RIGHT' Then
	If Len(as_splitat) > 1 Then
		li_char_pos	=	li_char_pos + Len(as_splitat) - 1
	End if
   ls_split		=	Mid(as_splitobject, (li_char_pos + 1))
	RETURN			ls_split
End if

// Indicate no split processing performed.

RETURN '-1'

end function

public subroutine of_labels2 (string as_table_type);// STARS 4.0		Subset Redesign
//						TS144 - labels
//
// Object:			n_cst_labels non visual object 
//	Object Type:	function - overloaded
//
// Log: 				JGG	01/12/98		Created NVO
//
// 
// This function overloads the previously defined of_labels2.  
// This function will simply take its parms, add additional default parms, 
// and call of_labels to perform the actual processing.

String						ls_col_height 	= 	'',	&
								ls_col_y 		= 	'',	&
								ls_hdr_height 	= 	''  

This.of_labels2 (as_table_type, ls_hdr_height, ls_col_height, ls_col_y)


end subroutine

public subroutine of_labels2 (string as_table_type, string as_hdr_height);// STARS 4.0		Subset Redesign
//						TS144 - labels
//
// Object:			n_cst_labels non visual object 
//	Object Type:	function - overloaded
//
// Log: 				JGG	01/12/98		Created NVO
//
// 
// This function overloads the previously defined of_labels2.  
// This function will simply take its parms, add additional default parms, 
// and call of_labels to perform the actual processing.

String						ls_col_height 	= 	'',	&
								ls_col_y 		= 	''  

This.of_labels2 (as_table_type, as_hdr_height, ls_col_height, ls_col_y)


end subroutine

public subroutine of_setdw (u_dw adw);// STARS 4.0		Subset Redesign
//						TS144 - labels
//
// Object:			n_cst_labels non visual object 
//	Object Type:	function
//
// Log: 				JGG	01/12/98		Created NVO
//
// 
// This function will "register" the datawindow passed to this function so that this datawindow 
// can be accessed and used by this NVO.  Registering a datawindow to a non visual object 
// establishes a pointer to the original datawindow because the datawindow is automatically 
// passed by reference.  

idw	=	adw

end subroutine

public subroutine of_labels2 (string as_table_type, string as_hdr_height, string as_col_height);// STARS 4.0		Subset Redesign
//						TS144 - labels
//
// Object:			n_cst_labels non visual object 
//	Object Type:	function - overloaded
//
// Log: 				JGG	01/12/98		Created NVO
//
// 
// This function overloads the previously defined of_labels2.  
// This function will simply take its parms, add additional default parms, 
// and call of_labels to perform the actual processing.

String						ls_col_y 		= 	''  

This.of_labels2 (as_table_type, as_hdr_height, as_col_height, ls_col_y)


end subroutine

public subroutine of_labels2 (string as_table_type, string as_hdr_height, string as_col_height, string as_col_y);/////////////////////////////////////////////////////////////////////////////////////
//
// Object:			n_cst_labels non visual object 
//	Object Type:	function
//
// Notes:         This nvo function originated from the labels2 global function
//
//						ALL SCRIPTS CALLING LABELS2 MUST ALREADY BE CONNECTED TO STARS2CA
//
// SUMMARY:  		This function will read the dictionary table and modify
//   					a datawindow based on the column name stored in the data base  .
// ARGUMENTS: 		This function receives the following arguments        
//						1)		Table Type:
//								The table type for which you need column names changed (EX: RD)                                  
// 					2)		DataWindow Header Band height:
//								A string containing a number that sets the height of the 
// 							report header band.  It must be between 540 and 675 (4-5 lines).        
// 					3)		Column header text height:
//								A string containing a number that sets the height of the    
// 							report column headers.  It must be between 270 and 300 (2 lines only).
// 					4)		Column header text "y" position:
//								A string containing a number that sets the upper position      
// 							of the column header text, relative to the start of the header
// 							band.  This should be the DW header band height   
// 							minus the col hdr text height.                    
//
/////////////////////////////////////////////////////////////////////////////////////
//
//	JGG		01/12/98	STARS 4.0 Subset Redesign TS144 - labels
//	FDG		12/14/00	Stars 4.7.  Make the checking of data types DBMS-independent.
//	FDG		05/02/01	Stars 4.7.	Concatenate modify string for efficiency.
//	GaryR	07/12/02	Track 2735d	Make character field lengths dictionary driven.
// JasonS 08/06/02 Track 3232d Set width of date fields to the width of the disp_format
// JasonS 08/22/02 Track 2982d replace dupe fields (_t_1_t) with (_t_1)
// MikeF	10/13/04	SPR3650d	Computed columns. Changed label lookups.
//	Katie	08/19/08	SPR 5503 PB11 - made the modify statements consistent so that all columns/headers
//								would align properly.  
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//	05/01/09	GaryR	PAT.600.5698.001	Follow the new duplicate column header naming convention 
//
/////////////////////////////////////////////////////////////////////////////////////

int 							li_db_col_len,			&
								li_len, 					&
								li_n, 					&
								li_position, 			&
								li_text_len
								
long 							ll_num_of_col

string 						ls_elem_label, 		&
								ls_data_type, 	&
								ls_col_name, 			&
								ls_hdr_name,			&
								ls_text, 				&
								ls_text1, 				&
								ls_text2, 				&
								ls_text_len,			&
								ls_dwmodify_rc, 		&
								ls_label, 				&
								ls_dbname,				&
								ls_modify,				&
								ls_disp_format,		&
								ls_where_message
								
n_cst_string	lnv_string

//******** LOCAL CONSTANTS

decimal 						ldc_number_pixels 	=   8.9

// Avg pixels set at 11 for Capital letters in System 10 font;	8 for numbers
int  							lic_cap_char_pixels 	=  11
								
// -10 is font height in points; positive number is in window units.  Always use points.
long 							llc_font_height 		= -10

long 							llc_font_weight 		= 700,	&
	 							llc_max_col_hgt 		=  50, 	&
								llc_max_hdr_hgt 		= 900, 	&
								llc_min_col_hgt 		=  20,	&
								llc_min_hdr_hgt 		=  50

//******** FUNCTION CODE

setpointer(hourglass!)

idw.SetRedraw (FALSE)		// FDG 05/02/01 - Prevent screen flicker

// Validate and Set the datawindow header band height (if it is present)
// Insure that the 'y' position is correct, or fix it.
if  as_hdr_height <> '' &
and IsNumber(as_hdr_height) then
	if  (long(as_hdr_height) >= llc_min_hdr_hgt) &
	and (long(as_hdr_height) <= llc_max_hdr_hgt) then
		if  as_col_height <> '' &
		and IsNumber(as_col_height) then
			if  (long(as_col_height) >= llc_min_col_hgt) &
			and (long(as_col_height) <= llc_max_col_hgt) then
				if  as_col_y <> '' &
				and IsNumber(as_col_y) then
					if long(as_col_y) > (long(as_hdr_height) - long(as_col_height)) then
						as_col_y = string(long(as_hdr_height) - long(as_col_height) -1) 
					end if
				else
					as_col_height	= 	''
					as_col_y 		= 	''
				end if
				ls_dwmodify_rc = idw.Modify("DataWindow.Header.Height=" + as_hdr_height)
			else
				as_col_height 	= 	''
				as_col_y 		= 	''
			end if
		else
			as_col_height 	= 	''
			as_col_y 		= 	''
		end if
	else
		as_hdr_height 	= 	''
		as_col_height 	= 	''
		as_col_y 		=	''
	end if
else
	as_hdr_height 	= 	''
	as_col_height 	= 	''
	as_col_y 		= 	''
end if

// Get the number of columns on the datawindow
ll_num_of_col 		= 	long(idw.Describe('datawindow.column.count'))

// Read and process the labels parm string
for li_n	=	1 to ll_num_of_col
	
	// Get the name of the database column from the datawindow 
	ls_dbname 		=	idw.Describe('#' + string(li_n) + '.dbname')
	
	// Strip off alias name if necessary
	li_position 	= 	pos(ls_dbname, '.')
	
	if li_position > 0 then
		ls_dbname 	= 	mid(ls_dbname, li_position + 1)
	end if
	
	// Get the object name from the datawindow
	ls_col_name 	= 	idw.Describe('#' + string(li_n) + '.name')

	if (upper(ls_dbname) <> upper(ls_col_name)) and (match(right(ls_col_name,2), '^_[0-9]$')) then
		ls_hdr_name = Left( ls_col_name, Len( ls_col_name ) - 2 ) + &
					'_t' + right(ls_col_name,2) + '_t'
	else
		ls_hdr_name = ls_col_name + '_t'
	end if

	// Get descriptive information for this database column from the dictionary
	IF gnv_dict.event ue_get_col_exists( Upper(as_table_type), Upper(ls_dbname)) THEN
		li_len 			= gnv_dict.event ue_get_data_len   		( Upper(as_table_type), Upper(ls_dbname))
		ls_elem_label  = gnv_dict.event ue_get_elem_label 		( Upper(as_table_type), Upper(ls_dbname))
		ls_data_type 	= gnv_dict.event ue_get_elem_data_type ( Upper(as_table_type), Upper(ls_dbname))
		ls_disp_format = gnv_dict.event ue_get_disp_format		( Upper(as_table_type), Upper(ls_dbname))
	ELSE
		// These modifications are done for columns that are not in the
		// dictionary such as calculated fields
		// Modify column hdr font height and weight; and col data 
		//	font height and weight.
		// Set standard font face and column header underlining.
		ls_modify 	= 	ls_modify + " " + ls_col_name + ".font.Height=~'" + string(llc_font_height) + "~'"
		ls_modify 	= 	ls_modify + " " + ls_col_name + ".font.Weight=~'" + string(llc_font_weight) + "~'"
		ls_modify 	= 	ls_modify + " " + ls_col_name + ".font.Face='System'"
	
	// JasonS 08/22/02 Begin - Track 2982d
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".font.Height=~'" + string(llc_font_height) + "~'"
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".font.Weight=~'" + string(llc_font_weight) + "~'"
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".font.Face='System'"
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".border='4'"

		// Modify the Column Header Label height and 'y' pos, if necessary.
		if as_col_height <> '' then
			// JasonS 08/22/02 begin - track 2982d
			ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".height=~'" + as_col_height + "~'"
			ls_modify 	=	ls_modify + " " + ls_hdr_name + ".y=~'" + as_col_y + "~'"
			// JasonS 08/22/02 end - track 2982d
		end if
		
		//	Set Accessibility Properties
		ls_elem_label = idw.Describe( ls_hdr_name + ".Text" )
		IF NOT IsNull( ls_elem_label ) AND Trim( ls_elem_label ) <> "" AND ls_elem_label <> "!" THEN
			ls_elem_label = lnv_string.of_clean_string_acc( ls_elem_label )
			ls_text = '"' + ls_elem_label + '"~t"' + ls_elem_label + '"'
			ls_modify += " " + ls_col_name + ".AccessibleName='" + ls_text + "'"
			ls_modify += " " + ls_col_name + ".AccessibleDescription='" + ls_text + "'"
			ls_modify += " " + ls_hdr_name + ".AccessibleName='" + ls_text + "'"
			ls_modify += " " + ls_hdr_name + ".AccessibleDescription='" + ls_text + "'"
		END IF
		
		ls_modify += " " + ls_col_name + ".AccessibleRole='27'"	//	ColumnRole!
		ls_modify += " " + ls_hdr_name + ".AccessibleRole='42'"	//	TextRole!
		
		continue
	end if 
	
	// FDG 05/02/01 - elem_data_len could = 0
	IF	li_len			=	0		THEN
		IF	gnv_sql.of_is_money_data_type (ls_data_type)	=	TRUE			THEN
			li_len		=	14
		ELSEIF gnv_sql.of_is_date_data_type (ls_data_type)	=	TRUE		THEN
			li_len		=	8
		ELSEIF gnv_sql.of_is_number_data_type (ls_data_type)	=	TRUE	THEN
			li_len		=	9
		ELSE
			li_len		=	15
		END IF
	END IF
	// FDG 05/02/01 end
			
	// this handles the col # format
	IF	trim(ls_disp_format)	>	' '	THEN
		IF gnv_sql.of_is_character_data_type (ls_data_type) THEN
			IF IsNumber( ls_disp_format ) THEN li_len = Long( ls_disp_format )
		elseif gnv_sql.of_is_date_data_type(ls_data_type) then
			li_len = len(ls_disp_format)
			Setformat(idw, li_n, trim(ls_disp_format))
		ELSE
			Setformat(idw, li_n, trim(ls_disp_format)) 
		END IF

	ELSE
		IF	gnv_sql.of_is_money_data_type (ls_data_type)	THEN
			Setformat (idw, li_n, '#,##0.00')
		ELSEIF gnv_sql.of_is_date_data_type (ls_data_type)	THEN
			Setformat (idw, li_n, 'mm/dd/yyyy')
		END IF
	END IF															  

	// Determine the width of the new col hdrs.
	ls_label 	=	'~'' + ls_elem_label + '~''
	ls_modify 	= 	ls_modify + " " + ls_hdr_name + '.text = ' + ls_label
	
	//	Set Accessibility Properties
	ls_elem_label = lnv_string.of_clean_string_acc( ls_elem_label )
	ls_text = '"' + ls_elem_label + '"~t"' + ls_elem_label + '"'
	ls_modify += " " + ls_col_name + ".AccessibleName='" + ls_text + "'"
	ls_modify += " " + ls_col_name + ".AccessibleDescription='" + ls_text + "'"
	ls_modify += " " + ls_col_name + ".AccessibleRole='27'"	//	ColumnRole!
	ls_modify += " " + ls_hdr_name + ".AccessibleName='" + ls_text + "'"
	ls_modify += " " + ls_hdr_name + ".AccessibleDescription='" + ls_text + "'"
	ls_modify += " " + ls_hdr_name + ".AccessibleRole='42'"	//	TextRole!
	
	ls_text		=	ls_label
	
	// Look for control characters within the label and determine the 
	// largest number of characters to appear in the column header
	if match(ls_text, '~n') then
		li_position 	= 	pos(ls_text, '~n')
		ls_text1 		= 	left(ls_text, li_position - 1)
		ls_text2 		= 	mid(ls_text, li_position + 1)
		
		if len(ls_text1) >= len(ls_text2) then
			li_text_len	=	len(ls_text1)
		elseif len(ls_text2) > len(ls_text1) then
			li_text_len = 	len(ls_text2)
		end if
	elseif match(ls_text, '~r') then
		li_position 	= 	pos(ls_text, '~r')
		ls_text1 		= 	left(ls_text, li_position - 1)
		ls_text2 		= 	mid(ls_text, li_position + 1)
		
		if len(ls_text1) >= len(ls_text2) then
			li_text_len	=	len(ls_text1)
		elseif len(ls_text2) > len(ls_text1) then
			li_text_len = 	len(ls_text2)
		end if
	else
		li_text_len 	= 	len(ls_text)
	end if

   // Calculate the size of the column header in pixels by datatype.
	// 10 is the avg # of pixels per character, (for BOLD, SYSTEM 10 font). 
	if li_text_len >= 5 Then
		li_text_len = li_text_len * 8
	else
		li_text_len = li_text_len * lic_cap_char_pixels
	end if

	IF	gnv_sql.of_is_numeric_data_type (ls_data_type)	THEN
		li_db_col_len	= 	Round (li_len * ldc_number_pixels, 0)
	ELSEIF	gnv_sql.of_is_date_data_type (ls_data_type)	THEN
		li_db_col_len	= 	Round (li_len * ldc_number_pixels, 0)
	ELSE
		li_db_col_len	= 	Round (li_len * lic_cap_char_pixels, 0)
	END IF
			
	// Set the col length to the longest of the col hdr label width 
	// or the chars of data in the dictionary.
	if li_text_len > li_db_col_len then
		ls_text_len	= 	string(li_text_len)
	else
		ls_text_len = 	string(li_db_col_len)
	end if

	// Modify column hdr font height and weight; and col data font 
	//	height and weight.
	// Set standard font face and column header underlining.
	ls_modify	= 	ls_modify + " " + ls_col_name + '.width= ~'' + ls_text_len + '~''
	ls_modify 	= 	ls_modify + " " + ls_col_name + ".font.Height=~'" + string(llc_font_height) + "~'"
	ls_modify 	= 	ls_modify + " " + ls_col_name + ".font.Weight=~'" + string(llc_font_weight) + "~'"
	ls_modify 	= 	ls_modify + " " + ls_col_name + ".font.Face='System'"

	// JasonS 08/22/02 Begin - Track 2982d
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".font.Height=~'" + string(llc_font_height) + "~'"
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".font.Weight=~'" + string(llc_font_weight) + "~'"
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".font.Face='System'"
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".border='4'"

	//  Modify the Column Header Label height and 'y' pos, if necessary.
	if as_col_height <> '' then
		// JasonS 08/22/02 begin - track 2982d
		ls_modify 	= 	ls_modify + " " + ls_hdr_name + ".height=~'" + as_col_height + "~'"
		ls_modify 	=	ls_modify + " " + ls_hdr_name + ".y=~'" + as_col_y + "~'"
		// JasonS 08/22/02 end - track 2982d
	end if
next

IF	Len (ls_modify)	>	0		THEN
	ls_dwmodify_rc	=	idw.Modify(ls_modify)		// FDG 05/02/01
END IF

idw.SetRedraw (TRUE)		// FDG 05/02/01
end subroutine

public subroutine of_trk_info_width (string as_trk_type);/*
=============================================================================
Method Name:	n_cst_labels::of_trk_info_width

Method Desc:	This method will set the width of the trk_key and trk_name 
					columns according to the track type.

Access:			Public
Return:			NONE
Arguments:		as_trk_type(string) - track type
=============================================================================
Author	Date		SPR		Comments
=============================================================================
JasonS 	10/23/02 4055c		Created.
=============================================================================
*/

constant decimal ldc_pixels = 8.9
integer li_key_len, li_name_len, li_key_width, li_name_width
string ls_rc

choose case as_trk_type
	case 'PV'
		select max(elem_data_len) 
		into :li_key_len
		from dictionary
		where elem_name = 'PROV_ID'
		using stars2ca;
		
		select max(elem_data_len)
		into :li_name_len
		from dictionary
		where elem_name = 'PROV_NAME'
		using stars2ca;
	case 'RV'
		select max(elem_data_len) 
		into :li_key_len
		from dictionary
		where elem_name = 'REV_CODE'
		using stars2ca;
		
		li_name_len = 50
	case 'PC'
		select max(elem_data_len) 
		into :li_key_len
		from dictionary
		where elem_name = 'PROC_CODE'
		using stars2ca;
		
		li_name_len = 50		
	case 'BE'
		select max(elem_data_len) 
		into :li_key_len
		from dictionary
		where elem_name = 'RECIP_ID'
		using stars2ca;
		
		select max(elem_data_len)
		into :li_name_len
		from dictionary
		where elem_name = 'PATIENT_NAME'
		using stars2ca;
end choose

li_key_width = li_key_len * ldc_pixels
li_name_width = li_name_len * ldc_pixels

ls_rc = idw.modify( 'trk_key.width= ~'' + string(li_key_width) + '~'' )
ls_rc = idw.modify( 'trk_name.width= ~'' + string(li_name_width) + '~'' )
ls_rc = idw.modify( 'track_trk_key.width= ~'' + string(li_key_width) + '~'' )
ls_rc = idw.modify( 'track_trk_name.width= ~'' + string(li_name_width) + '~'' )



end subroutine

on n_cst_labels.create
call super::create
end on

on n_cst_labels.destroy
call super::destroy
end on

