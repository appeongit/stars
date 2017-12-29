HA$PBExportHeader$n_cst_dw_format.sru
$PBExportComments$<logic>
forward
global type n_cst_dw_format from nonvisualobject
end type
end forward

global type n_cst_dw_format from nonvisualobject autoinstantiate
event ue_register_dw ( u_dw adw )
end type

type variables

int		ii_units
int		ii_rpt_header_height
int		ii_cols
int		ii_page

string	is_inv_type

u_dw		idw
n_cst_string	inv_string

// Text Justify constants
constant	int	ici_left		= 0
constant	int	ici_right	= 1
constant	int	ici_center	= 2
constant	int	ici_full		= 3

// Text Border constants
constant	int	ici_noborder= 0
constant	int	ici_shadow	= 1
constant	int	ici_rect		= 2
constant	int	ici_resize	= 3
constant	int	ici_line		= 4
constant	int	ici_3dlow	= 5
constant	int	ici_3draise	= 6

// Datawindow units values
constant	int	ici_pbunits = 0
constant	int	ici_pixels	= 1
constant	int	ici_inch		= 2
constant	int	ici_cent		= 3


constant real	icr_inch_ratio = 1.041
constant real	icr_cent_ratio = 2.645

// Text length ratios
constant real icr_text_ratio  = 5.9





end variables

forward prototypes
public subroutine uf_mod_dw (string as_mod)
public subroutine uf_size_header_background ()
private function string uf_get_string_value (string as_describe)
private subroutine uf_toggle_visible (string as_object, boolean ab_visible)
private subroutine uf_create_label (string as_name, string as_value, integer ai_y)
private subroutine uf_create_info (string as_name, string as_value, integer ai_y, integer ai_width)
private subroutine uf_create_text (string as_name, string as_value, integer ai_x, integer ai_y, integer ai_height, integer ai_width, integer ai_font_size, long al_text_color, long al_background, integer ai_justify, integer ai_border, boolean ab_bold)
protected subroutine uf_set_text (string as_object, string as_text, boolean ab_display)
private function string uf_convert_mod_string (string as_mod, string as_units)
private subroutine uf_remove_header ()
private function integer uf_get_pixels (long al_value, boolean ab_x_axis)
private function long uf_get_units (long al_value, boolean ab_x_axis)
private function long uf_get_min_header_y ()
private function long uf_get_max_header_y ()
private subroutine uf_remove_footer ()
public function integer uf_add_header (sx_dw_format asx_format)
public subroutine uf_add_footer (boolean ab_add_page)
public subroutine uf_add_generic_title (string as_title)
public subroutine uf_format_col_headers ()
public subroutine uf_format_details ()
public function boolean uf_get_is_dw_grid ()
public function boolean uf_get_object_exists (string as_object)
public function sx_dw_format uf_get_structure ()
public subroutine uf_set_default_disp_formats (boolean ab_set_widths)
public subroutine uf_toggle_gridlines (boolean ab_visible)
public subroutine uf_set_header (sx_dw_format asx_format)
public subroutine uf_set_disp_formats (string as_tbl_type, boolean ab_set_widths)
public function integer uf_hide_header ()
private function string uf_get_default_text_mod (string as_col)
private function long uf_get_page_width ()
private subroutine uf_move_col_headers (long al_offset)
private function integer uf_set_text_height (string as_object, string as_text)
private function string uf_get_label_name (string as_name)
public subroutine uf_set_labels (string as_tbl_type)
private function integer uf_get_label_width (integer ai_col_number)
public subroutine uf_set_inv_type (string as_inv_type)
end prototypes

event ue_register_dw(u_dw adw);// When using n_cst_dw_format, you MUST call this event to register the datawindow before using any of the functions.

idw = adw
ii_units = integer(idw.Object.DataWindow.Units)
ii_cols 	= integer(idw.Describe ("datawindow.column.count") )

IF idw.Describe("DataWindow.Print.Orientation") = '2' THEN
	ii_page 		= 760
ELSE
	ii_page		= 1000
END IF

end event

public subroutine uf_mod_dw (string as_mod);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_mod_dw
// Arguments	as_mod			string	Datawindow modify string
// Returns		<None>
//=========================================================================================================//
// Attempts to modify datawindow based on string parm. Gives messagebox if it fails.
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
string		ls_rc, ls_mod

IF idw.object.datawindow.units = "1" THEN
	ls_mod = as_mod
ELSE
	ls_mod = this.uf_convert_mod_string( as_mod, idw.object.datawindow.units)
END IF

ls_rc = idw.modify(ls_mod)

IF len(ls_rc) > 0 THEN
	MessageBox("DataWindow Error", "Unable to modify datawindow syntax in n_cst_dw_format~r~r" + &
											ls_rc + "~r~r" + ls_mod)
END IF
end subroutine

public subroutine uf_size_header_background ();// MikeF 01/11/05 SPR4231d Background object was too large.

long		ll_value
string 	ls_mod

// Set height
IF ii_rpt_header_height = 0 THEN
	ll_value = this.uf_get_pixels(this.uf_get_min_header_y(), FALSE)
ELSE
	ll_value = ii_rpt_header_height
END IF

ls_mod = "t_background.height=" + string(ll_value - 1)
this.uf_mod_dw(ls_mod)

// Set width
ls_mod = "t_background.width="  + string(this.uf_get_pixels(this.uf_get_page_width(),TRUE))
this.uf_mod_dw(ls_mod)

idw.SetRedraw(TRUE)

end subroutine

private function string uf_get_string_value (string as_describe);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_string_value
// Arguments	as_describe	string	Object and property
// Returns						string	Value
//=========================================================================================================//
// Returns modify statement for standard data
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	12/29/04	GaryR	SPR4108d	Resolve special characters 
//=========================================================================================================//
string		ls_value
int			li_len

ls_value = trim(idw.describe(as_describe))

IF ls_value = '!' THEN RETURN ''

// Remove leading and trailing quotes if text object
IF right(as_describe,5) = ".text" &
AND left (ls_value,1)   = '"' &
AND right(ls_value,1)  	= '"' THEN
	li_len 	= len(ls_value)
	ls_value = mid(ls_value, 2, li_len - 2)
END IF

//	Replace special characters
ls_value = trim(ls_value)
ls_value = inv_string.of_globalreplace( ls_value, '~~~"', '"' )
ls_value = inv_string.of_globalreplace( ls_value, '&&', '&' )

RETURN ls_value
end function

private subroutine uf_toggle_visible (string as_object, boolean ab_visible);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_toggle_visible
//=========================================================================================================//
// Loops through all columns and replaces the Column Headings with ELEM_ELEM_LABEL from the dictionary
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
string	ls_visible = "0"

IF ab_visible THEN ls_visible = "1"

this.uf_mod_dw( as_object + ".visible='" + ls_visible + "'")

end subroutine

private subroutine uf_create_label (string as_name, string as_value, integer ai_y);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_create_label
//=========================================================================================================//
// Returns a modify string for a Navy Bold label as used in PDR's (i.e. Description)
//=========================================================================================================//
// Text color		Navy
//	Background		Transparent
//	Border			None
//	Justified		Left
//	Font Size		8
// Bold				Yes
//	x					5
// Height			15
// Width				110
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//=========================================================================================================//

this.uf_create_text(as_name, as_value, 5, ai_y, 15, 110, 8, stars_colors.highlight, stars_colors.transparent, ici_left, ici_noborder, TRUE)
end subroutine

private subroutine uf_create_info (string as_name, string as_value, integer ai_y, integer ai_width);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_create_info
//=========================================================================================================//
// Returns a modify string for the header details as used in PDR's (i.e. Description)
//=========================================================================================================//
// Text color		Navy
//	Background		Transparent
//	Border			None
//	Justified		Left
//	Font Size		8
// Bold				No
//	x					120
// Height			15
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//=========================================================================================================//

this.uf_create_text(as_name, as_value, 120, ai_y, 15, ai_width, 8, stars_colors.window_text, stars_colors.transparent, ici_left, ici_noborder, FALSE)
end subroutine

private subroutine uf_create_text (string as_name, string as_value, integer ai_x, integer ai_y, integer ai_height, integer ai_width, integer ai_font_size, long al_text_color, long al_background, integer ai_justify, integer ai_border, boolean ab_bold);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_create_text_mod
// Arguments	string 	as_name			Name of text object to create
// 				string 	as_value			Text value
//					integer 	ai_x				x position
//					integer	ai_y				y position
//					integer 	ai_height		object height
//					integer 	ai_width			object width
//					integer 	ai_font_size 	Font Point size (positive value)
//					long 		al_text_color	Text color
//					long 		al_background	Background color
//					integer 	ai_justify		Text justification
//					integer 	ai_border		Border Type
//					boolean 	ab_bold			Bold text toggle
// Return		string				
//=========================================================================================================//
// Create the datawindow modify string to add a text element to a header
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	12/29/04	GaryR	SPR4108d	Resolve special characters 
// 01/28/05 MikeF SPR4265d Moved special character logic to n_cst_string
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//=========================================================================================================//

string		ls_mod

//	Replace special characters
as_value = inv_string.of_fix_dwtext(as_value)

ls_mod 	= 	'create text(band=foreground alignment="' + string(ai_justify) + '" '
ls_mod 	+=	'text="' 	+ as_value + '" ' 			
ls_mod 	+=	'border="' 	+ string(ai_border) 		+ '" '
ls_mod 	+=	'color="'	+ string(al_text_color)	+ '" '
ls_mod 	+=	'x="'			+ string(ai_x)				+ '" '
ls_mod 	+=	'y="' 		+ string(ai_y) 			+ '" '
ls_mod 	+=	'height="'	+ string(ai_height)		+ '" '
ls_mod 	+=	'width="'	+ string(ai_width)		+ '" '
ls_mod 	+=	'html.valueishtml="0" '
ls_mod 	+=	'name='		+ as_name 					+ ' '
ls_mod 	+=	'visible="1"  font.face="Microsoft Sans Serif" ' 
ls_mod 	+=	'font.height="-' + string(ai_font_size) + '" '

IF ab_bold THEN
	ls_mod 	+=	'font.weight="700" '
ELSE
	ls_mod 	+=	'font.weight="400" '
END IF

ls_mod 	+=	'font.family="2" font.pitch="2" font.charset="0" background.mode="1" '
ls_mod 	+=	'background.color="' + string(al_background) + '" '

//	Set Accessibility Properties
as_value = inv_string.of_clean_string_acc( as_value )
ls_mod 	+=	'accessibledescription="~~"' + as_value + '~~"~~t~~"' + as_value + '~~"" accessiblename="~~"' + as_value + '~~"~~t~~"' + as_value + '~~"" accessiblerole=42 ) '

this.uf_mod_dw(ls_mod)
end subroutine

protected subroutine uf_set_text (string as_object, string as_text, boolean ab_display);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_format_column_mod
// Arguments	as_object	string	Datawindow object
//					as_text		string	Text
// Returns		<None>
//=========================================================================================================//
// Modifies the text property of a dw object
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/19/04	MikeF	SPR4108d	Created
//	12/29/04	GaryR	SPR4108d	Resolve special characters 
// 01/28/05 MikeF SPR4265d Moved special character logic to n_cst_string
//=========================================================================================================//
//	Replace special characters
as_text = inv_string.of_fix_dwtext(as_text)

IF idw.describe(as_object + ".text") <> '!' THEN	
	IF  len(as_text) > 0 THEN
		this.uf_mod_dw(as_object + '.text="' + as_text + '"')
	END IF
	
	IF  ab_display &
	AND len(as_text) > 0 THEN
		this.uf_mod_dw(as_object + '.visible="1"' )
	ELSE
		this.uf_mod_dw(as_object + '.visible="0"' )
	END IF
END IF


end subroutine

private function string uf_convert_mod_string (string as_mod, string as_units);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_convert_mod_string
//=========================================================================================================//
// Converts pixel based modify statement to other unit types
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
string			ls_temp, ls_mod, ls_string
long				ll_value 
int				li_pos1, li_pos2
n_cst_string	lnv_string

ls_mod	 = as_mod + " "

// x coordinate
li_pos1 	 = pos(ls_mod,"x=")

IF li_pos1 > 0 THEN
	li_pos1 += 2
	li_pos2 	 = pos(ls_mod," ",li_pos1)
	ls_string = mid(ls_mod,li_pos1, li_pos2 - li_pos1 )
	
	IF IsNumber(lnv_string.of_removequotes(ls_string)) THEN
		ll_value	= integer(lnv_string.of_removequotes(ls_string))
		ll_value = this.uf_get_units( ll_value, TRUE)
		ls_mod 	= lnv_string.of_globalreplace( ls_mod, 'x=' + ls_string, 'x="' + string(ll_value) + '"')
	END IF
END IF

// y coordinate
li_pos1 	 = pos(ls_mod,"y=")

IF li_pos1 > 0 THEN
	li_pos1 += 2
	li_pos2 	 = pos(ls_mod," ",li_pos1)
	ls_string = mid(ls_mod,li_pos1, li_pos2 - li_pos1 )
	
	IF IsNumber(lnv_string.of_removequotes(ls_string)) THEN
		ll_value = integer(lnv_string.of_removequotes(ls_string))
		ll_value = this.uf_get_units(ll_value, FALSE)
		ls_mod 	= lnv_string.of_globalreplace( ls_mod, 'y=' + ls_string, 'y="' + string(ll_value) + '"')
	END IF
END IF

// Width
li_pos1 	 = pos(ls_mod,"width=")

IF li_pos1 > 0 THEN
	li_pos1 += 6
	li_pos2 	 = pos(ls_mod," ",li_pos1)
	ls_string = mid(ls_mod,li_pos1, li_pos2 - li_pos1 )
	
	IF IsNumber(lnv_string.of_removequotes(ls_string)) THEN
		ll_value = integer(lnv_string.of_removequotes(ls_string))
		ll_value = this.uf_get_units(ll_value, TRUE)		
		ls_mod 	= lnv_string.of_globalreplace( ls_mod, 'width=' + ls_string, 'width="' + string(ll_value) + '"')
	END IF
END IF

// Height
li_pos1 	 = pos(ls_mod,"height=")

IF li_pos1 > 0 THEN
	li_pos1 += 7

	li_pos2 	 = pos(ls_mod," ",li_pos1)
	ls_string = mid(ls_mod,li_pos1, li_pos2 - li_pos1 )
	
	IF IsNumber(lnv_string.of_removequotes(ls_string)) THEN
		ll_value = integer(lnv_string.of_removequotes(ls_string))
		ll_value = this.uf_get_units(ll_value, FALSE)
		ls_mod 	= lnv_string.of_globalreplace( ls_mod, 'height=' + ls_string, 'height="' + string(ll_value) + '"')
	END IF
END IF

RETURN ls_mod
end function

private subroutine uf_remove_header ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_remove_header
// Arguments	<None>
// Return		<None>
//=========================================================================================================//
// Destroy or move all objects in the Header band to start from scratch
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/04/04	MikeF	SPR4108d	Created
// 01/06/05 MikeF SPR4205d Formatting issues when not a pixel dw
//=========================================================================================================//
Long		ll_cnt, ll_ctr, ll_y, ll_height
String	ls_objects, ls_names[], ls_band, ls_rc
n_cst_string	lnv_string

ls_objects 	= idw.Object.DataWindow.Objects
ll_cnt 		= lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )
ll_height 	= this.uf_get_min_header_y()

//	Loop through and destroy or move Y position of items.
FOR ll_ctr = 1 TO ll_cnt
	ls_band = Lower( idw.Describe( ls_names[ll_ctr] + ".Band" ))
	ll_y = long(idw.describe(ls_names[ll_ctr] + ".y"))	
	CHOOSE CASE ls_band
		CASE "foreground"
			IF idw.describe(ls_names[ll_ctr] + ".Tag") = 'BYPASS' THEN
				// Move it back to the top.
				ls_rc = idw.modify(ls_names[ll_ctr] + '.y="' + string(ll_y - ll_height) + '"')	
			ELSE
				this.uf_mod_dw("destroy " + ls_names[ll_ctr])		
			END IF
		CASE "header"
			ls_rc = idw.modify(ls_names[ll_ctr] + '.y="' + string(ll_y - ll_height) + '"')	
	END CHOOSE
NEXT

end subroutine

private function integer uf_get_pixels (long al_value, boolean ab_x_axis);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_pixels
// Arguments	al_value		long			Original value
//					ab_x_axis	boolean		TRUE if converting width or x component, FALSE if height or y
// Returns						long			Converted Pixel values
//=========================================================================================================//
// Returns the equivalent Pixel value from an original value
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/07/04	MikeF	SPR4108d	Created
//=========================================================================================================//
long		ll_value

CHOOSE CASE ii_units
	CASE ici_pbunits
		IF ab_x_axis THEN
			ll_value = UnitsToPixels(al_value, XUnitsToPixels!)		
		ELSE
			ll_value = UnitsToPixels(al_value, YUnitsToPixels!)		
		END IF
	CASE ici_pixels
		ll_value = al_value
	CASE ici_inch
		ll_value = al_value / icr_inch_ratio
	CASE ici_cent
		ll_value = al_value / icr_cent_ratio
END CHOOSE
		
RETURN ll_value
end function

private function long uf_get_units (long al_value, boolean ab_x_axis);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_units
// Arguments	al_value		long			Original value
//					ab_x_axis	boolean		TRUE if converting width or x component, FALSE if height or y
// Returns						long			Converted units
//=========================================================================================================//
// Returns the equivalent native dw value from an original pixel value
//=========================================================================================================////=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/07/04	MikeF	SPR4108d	Created
//=========================================================================================================//
long		ll_value

CHOOSE CASE ii_units
	CASE ici_pbunits
		IF ab_x_axis THEN
			ll_value = PixelsToUnits(al_value, XPixelsToUnits!)		
		ELSE
			ll_value = PixelsToUnits(al_value, YPixelsToUnits!)		
		END IF
	CASE ici_pixels
		ll_value = al_value
	CASE ici_inch
		ll_value = al_value * icr_inch_ratio
	CASE ici_cent
		ll_value = al_value * icr_cent_ratio
END CHOOSE
		
RETURN ll_value
end function

private function long uf_get_min_header_y ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_max_header_y
// Returns		long
//=========================================================================================================//
// Returns Y position of the top header element in UNITS
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
// 01/06/05 MikeF SPR4205d Formatting issues when not a pixel dw
//=========================================================================================================//
Long		ll_cnt, ll_ctr, ll_y, ll_min = 99999
String	ls_objects, ls_names[], ls_band, ls_tag
n_cst_string	lnv_string

ls_objects = idw.Object.DataWindow.Objects
ll_cnt = lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )

//	Loop through and find min Y position of header items.
FOR ll_ctr = 1 TO ll_cnt
	ls_band = Upper( idw.Describe( ls_names[ll_ctr] + ".Band" ) )
	ls_tag  = Upper( idw.Describe( ls_names[ll_ctr] + ".Tag" ) )
	IF  ls_band = "HEADER" &
	OR (ls_band = "FOREGROUND" AND ls_tag = "BYPASS") THEN
		ll_y = Long( idw.Describe( ls_names[ll_ctr] + ".y" ) )
		IF ll_y < ll_min THEN 
			ll_min = ll_y
		END IF
	END IF
NEXT

IF ll_min = 99999 THEN
	ll_min = 0
END IF

RETURN ll_min
end function

private function long uf_get_max_header_y ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_max_header_y
// Returns		long
//=========================================================================================================//
// Returns Y position of the bottom of the lowest header element in UNITS
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
// 01/06/05 MikeF SPR4205d Formatting issues when not a pixel dw
//=========================================================================================================//
Long		ll_cnt, ll_ctr, ll_y, ll_height, ll_max = 0
String	ls_objects, ls_names[], ls_band, ls_tag
n_cst_string	lnv_string

ls_objects = idw.Object.DataWindow.Objects
ll_cnt = lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )

//	Loop through and find min Y position of header items.
FOR ll_ctr = 1 TO ll_cnt
	ls_band = Upper( idw.Describe( ls_names[ll_ctr] + ".Band" ) )
	ls_tag  = Upper( idw.Describe( ls_names[ll_ctr] + ".Tag" ) )
	IF  ls_band = "HEADER" &
	OR (ls_band = "FOREGROUND" AND ls_tag = "BYPASS") THEN
		ll_y 		 = Long( idw.Describe( ls_names[ll_ctr] + ".y" ) )
		ll_height = Long( idw.Describe( ls_names[ll_ctr] + ".height" ) )
		IF ll_y + ll_height > ll_max THEN 
			ll_max = ll_y + ll_height
		END IF
	END IF
NEXT

RETURN ll_max
end function

private subroutine uf_remove_footer ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_create_text_mod
// Arguments	string 	as_name			Name of text object to create
// Return		<None>
//=========================================================================================================//
// Create the datawindow modify string to add a text element to a header
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/04/04	MikeF	SPR4108d	Created
//=========================================================================================================//
Long		ll_cnt, ll_ctr, ll_height, ll_y
String	ls_objects, ls_names[], ls_band
n_cst_string	lnv_string

ls_objects 	= idw.Object.DataWindow.Objects
ll_cnt 		= lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )
ll_height 	= 0

//	Loop through and find min Y position of header items.
FOR ll_ctr = 1 TO ll_cnt
	ls_band = Lower(idw.Describe( ls_names[ll_ctr] + ".Band" ))
	ll_y	  = long (idw.Describe( ls_names[ll_ctr] + ".y" ))
	IF ls_band = "footer" THEN
		IF idw.describe(ls_names[ll_ctr] + ".Tag") = 'BYPASS' THEN
			// Move it back to the top.
			IF ll_y > ll_height THEN
				ll_height = ll_y
			END IF
		ELSE
			this.uf_mod_dw("destroy " + ls_names[ll_ctr])		
		END IF
	END IF
NEXT

this.uf_mod_dw('DataWindow.Footer.Height="' + string(this.uf_get_pixels(ll_height, FALSE)) + '"')



end subroutine

public function integer uf_add_header (sx_dw_format asx_format);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_add_header
//=========================================================================================================//
// Creates all header elements and draws them based on whether a value was passed in.
//=========================================================================================================//
//													st_statement
// p_logo (draw_logo)						st_clientname (client_name)		t_report_id		st_report_id (report_id)
// l_1 -----------------------------------------------------------------------------------------------
//													st_title (title)
//													st_sub1	(subtitle1)
//													st_sub2	(subtitle2)
//													st_sub3	(subtitle3)
//													st_sub4	(subtitle4)
// t_report_type		st_report_type	(report_name)								t_report_date	st_date	(report_date)
// t_subject			st_subject		(subject)									
//	t_subset				st_subset		(subset)					
//	t_inv_type			st_inv_type		(inv_type)
// t_desc				st_desc			(description)
//	t_constraint		st_constraint	(criteria)
//
// Detail -------------------------------------------------------------------------------------------
// ..
// ..
// ..
// ..
//
// Footer -------------------------------------------------------------------------------------------
//	p_stars_logo								st_page (page_numbers)									
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	12/29/04	GaryR	SPR4108d	Resolve special characters
//	12/29/04	GaryR	SPR4205d	Add more witdth to Report Type and rename to Report Name
// 01/06/05 MikeF SPR4205d Formatting issues when not a pixel dw
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//	05/29/10	GaryR	SPR 5811	Set header background color back to white.
//
//=========================================================================================================//

int		li_x, li_y, li_page, li_right_x, li_row1_y, li_row2_y, li_height
string	ls_mod
boolean	lb_logo, lb_report_id

idw.SetRedraw(FALSE)

// Remove Existing header
this.uf_remove_header()

// Set page specifics
IF asx_format.portrait &
OR idw.Describe("DataWindow.Print.Orientation") = '2' THEN
	li_page 		= 760
	li_right_x 	= 575
ELSE
	li_page		= 1000
	li_right_x 	= 815
END IF

li_y = 1

// Draw white background (resized at end)
ls_mod = 'create text(band=foreground alignment="0" text=" " border="0" color="' + String( stars_colors.highlight ) + '" x="1" y="1" ' + &
			'height="2" width="100" html.valueishtml="0" '	+ &
			'name=t_background visible="1" font.face="Arial" font.height="-12" font.weight="400" '		+ &
			'font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="' + String( stars_colors.window_background ) + '" ' + &
			'accessibledescription="~~" ~~"~~t~~" ~~"" accessiblename="~~" ~~"~~t~~" ~~"" accessiblerole=42 ) '

this.uf_mod_dw(ls_mod)

// Custom Statement - st_statement
IF len(trim(asx_format.statement)) > 0 THEN
	this.uf_create_text("st_customstatement", trim(asx_format.statement), 2, li_y, 15, li_page, 10, stars_colors.window_text, stars_colors.transparent, ici_center, ici_noborder, FALSE)
	idw.Object.st_customstatement.Font.Italic = TRUE
	li_y += this.uf_set_text_height( "st_customstatement", asx_format.statement) 
END IF

// Client Name 
IF len(trim(asx_format.client_name)) > 0 THEN

	// Client Logo - p_logo
	IF len(trim(asx_format.logo_file)) > 0 THEN
		ls_mod = 'create bitmap(band=foreground filename="' + asx_format.logo_file + '" x="3" y="' + string(li_y) + '" ' + &
					'height="40" width="100" border="0"  name=p_sitelogo visible="1" ' + &
					'accessibledescription="~~"Client Logo~~"~~t~~"Client Logo~~"" accessiblename="~~"Client Logo~~"~~t~~"Client Logo~~"" accessiblerole=40 ) '
		this.uf_mod_dw(ls_mod)
		lb_logo  = TRUE
		li_x = 105
		li_y += 10 
	ELSE
		li_x = 3
	END IF

	// Client Name - st_clientname (Draw centered on the page)
	this.uf_create_text("st_clientname", trim(asx_format.client_name), li_x, li_y, 21, 500, 10, stars_colors.highlight, stars_colors.transparent, ici_left, ici_noborder, TRUE)

	IF lb_logo THEN
		li_y += 33
	ELSE
		li_y += 23
	END IF

END IF

// Main Title
IF len(trim(asx_format.title)) > 0 THEN
	this.uf_create_text("st_title", trim(asx_format.title), 2, li_y, 20, li_page, 12, stars_colors.window_text, stars_colors.transparent, ici_center, ici_noborder, TRUE)
	li_y += 22
END IF

// SubTitle 1
IF len(trim(asx_format.subtitle1)) > 0 THEN
	this.uf_create_text("st_sub1", trim(asx_format.subtitle1), 2, li_y, 16, li_page, 10, stars_colors.highlight, stars_colors.transparent, ici_center, ici_noborder, FALSE)
	li_y += 18
END IF

// SubTitle 2
IF len(trim(asx_format.subtitle2)) > 0 THEN
	this.uf_create_text("st_sub2", trim(asx_format.subtitle2), 2, li_y, 16, li_page, 10, stars_colors.highlight, stars_colors.transparent, ici_center, ici_noborder, FALSE)
	li_y += 18
END IF

// SubTitle 3
IF len(trim(asx_format.subtitle3)) > 0 THEN
	this.uf_create_text("st_sub3", trim(asx_format.subtitle3), 2, li_y, 16, li_page, 10, stars_colors.highlight, stars_colors.transparent, ici_center, ici_noborder, FALSE)
	li_y += 18
END IF

// SubTitle 4
IF len(trim(asx_format.subtitle4)) > 0 THEN
	this.uf_create_text("st_sub4", trim(asx_format.subtitle4), 2, li_y, 16, li_page, 10, stars_colors.highlight, stars_colors.transparent, ici_center, ici_noborder, FALSE)
	li_y += 18
END IF

IF lb_logo AND li_y < 51 THEN
	li_y = 52
END IF

// Report Type
IF len(trim(asx_format.report_name)) > 0 THEN
	// st_report_type
	this.uf_create_info( "st_report_type", trim(asx_format.report_name), li_y, 450)
	
	IF asx_format.display_report_name THEN
	// t_report_type
		this.uf_create_label( "t_report_type", "Report Name", li_y)
		li_row1_y = li_y
		li_row2_y = li_row1_y + 16
		li_y 		+= 16
	ELSE
		this.uf_toggle_visible( "st_report_type", FALSE )
	END IF
END IF

// Subject and Label
IF  len(trim(asx_format.subject_label)) 	> 0 &
AND len(trim(asx_format.subject)) 			> 0 THEN
	// Subject Text - st_subject ("Service Date","12345678 - Dr. Smith", etc...)
	this.uf_create_info( "st_subject", trim(asx_format.subject), li_y, 450)
	
	IF asx_format.display_subject THEN
		// Subject label - t_subject ("Summary Field", "Prov ID", etc...)
		this.uf_create_label( "t_subject", asx_format.subject_label, li_y)
		IF li_row1_y = 0 THEN
			li_row1_y = li_y
			li_row2_y = li_row1_y + 16
		END IF
		li_y += 16
	ELSE
		this.uf_toggle_visible( "st_subject", FALSE )
	END IF
	
END IF

// Subset ID + desc
IF len(trim(asx_format.subset)) > 0 THEN
	// Subset text - st_subset
	this.uf_create_info( "st_subset", trim(asx_format.subset), li_y, 450)
	
	IF asx_format.display_subset THEN
		// Subset label - t_subset
		this.uf_create_label( "t_subset", "Subset", li_y)
		IF li_row1_y = 0 THEN
			li_row1_y = li_y
			li_row2_y = li_row1_y + 16
		END IF
		li_y += 16
	ELSE
		this.uf_toggle_visible( "st_subset", FALSE)
	END IF
END IF

// Invoice Type + desc
IF len(trim(asx_format.inv_type)) > 0 THEN

	// Invoice Type text - st_inv_type
	this.uf_create_info( "st_inv_type", asx_format.inv_type, li_y, 450)
	
	IF asx_format.display_inv_type THEN
		// Invoice Type label - t_inv_type
		this.uf_create_label( "t_inv_type", "Invoice Type", li_y)
		IF li_row1_y = 0 THEN
			li_row1_y = li_y
			li_row2_y = li_row1_y + 16
		END IF
		li_y += 16
	ELSE	
		this.uf_toggle_visible( "st_inv_type", FALSE)
	END IF
END IF

// Report ID
IF len(trim(asx_format.report_id)) > 0 THEN

	IF asx_format.display_report_id THEN	
		IF li_row1_y = 0 THEN
			li_row1_y = li_y	
			li_row2_y = li_y + 16
		END IF
	END IF

	// Report ID - st_report_id
	this.uf_create_text( "st_report_id", asx_format.report_id, li_right_x + 80, li_row1_y, &
														15, 105, 8, stars_colors.window_text, stars_colors.transparent, ici_left, ici_noborder, FALSE)

	IF asx_format.display_report_id THEN	
		// Report Date label - t_report_id
		this.uf_create_text( "t_report_id", "Report ID", li_right_x, li_row1_y, 15, 75, 8, &
					stars_colors.highlight, stars_colors.transparent, ici_left, ici_noborder, TRUE)
		lb_report_id = TRUE
	ELSE	
		this.uf_toggle_visible( "st_report_id", FALSE )
	END IF
END IF

// If not displaying the report ID, shift the Date up.
IF NOT lb_report_id THEN 
	li_row2_y = li_row1_y
END IF

// Run Date
IF len(trim(asx_format.report_date)) > 0 THEN

	IF asx_format.display_report_date	&
	AND li_row2_y = 0 						THEN	
		li_row2_y = li_y
	END IF

	// Report Date - st_date
	this.uf_create_text( "st_date", asx_format.report_date, li_right_x + 80, li_row2_y, &
														15, 105, 8, stars_colors.window_text, stars_colors.transparent, ici_left, ici_noborder, FALSE)
	IF asx_format.display_report_date THEN	
		// Report Date label - t_report_date
		this.uf_create_text( "t_report_date", "Report Date", li_right_x, li_row2_y, 15, 75, &
															8, stars_colors.highlight, stars_colors.transparent, ici_left, ici_noborder, TRUE)
	ELSE	
		this.uf_toggle_visible( "st_date", FALSE )
	END IF

END IF

// SHift all of the page wide text below the Report Dates and IDs
IF  asx_format.display_report_id &
AND li_y < li_row1_y + 16 THEN
	li_y =  li_row1_y + 16
END IF

IF  asx_format.display_report_date &
AND li_y < li_row2_y + 16 THEN
	li_y =  li_row2_y + 16
END IF

// Description
IF len(trim(asx_format.description)) > 0 THEN
	// Description label - t_description
	this.uf_create_label( "t_description", "Description", li_y)
	
	// Description text - st_description
	this.uf_create_info( "st_description", trim(asx_format.description), li_y, li_page - 120)
	
	li_y += this.uf_set_text_height( "st_description", asx_format.description)
END IF

// Criteria
IF len(trim(asx_format.criteria)) > 0 THEN
	// Criteria text - st_description
	this.uf_create_info( "st_constraint", trim(asx_format.criteria), li_y, li_page - 120)

	IF asx_format.display_criteria THEN
		// Criteria label - t_description
		this.uf_create_label( "t_constraint", "Selection Criteria", li_y)
		li_y += this.uf_set_text_height( "st_constraint", asx_format.criteria)
	ELSE
		this.uf_toggle_visible( "st_constraint", FALSE )
	END IF
END IF

// Draw background
ii_rpt_header_height = li_y
this.uf_size_header_background()

// Shift all column headings down
this.uf_move_col_headers(li_y + 2)

// Size the header band (Report headings + Column Header height (converted to pixels))
li_height =	ii_rpt_header_height + 4 +	&										
				this.uf_get_pixels(this.uf_get_max_header_y(), FALSE) - this.uf_get_pixels(this.uf_get_min_header_y(), FALSE)		

this.uf_mod_dw("datawindow.header.height=" + string(li_height))

// Hide a text object containing the format flags for saved reports
this.uf_create_info( "t_format_flags", string(asx_format.report_options), 0, 0)
this.uf_toggle_visible( "t_format_flags", FALSE)

idw.SetRedraw(TRUE)

RETURN 0
end function

public subroutine uf_add_footer (boolean ab_add_page);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_add_footer
//=========================================================================================================//
// Creates all footer elements
//=========================================================================================================//
//													st_statement
// p_logo (draw_logo)						st_clientname (client_name)		t_report_id		st_report_id (report_id)
// l_1 -----------------------------------------------------------------------------------------------
//													st_title (title)
//													st_sub1	(subtitle1)
//													st_sub2	(subtitle2)
//													st_sub3	(subtitle3)
//													st_sub4	(subtitle4)
// t_report_type		st_report_type	(report_name)								t_report_date	st_date	(report_date)
// t_subject			st_subject		(subject)									
//	t_subset				st_subset		(subset)					
//	t_inv_type			st_inv_type		(inv_type)
// t_desc				st_desc			(description)
//	t_constraint		st_constraint	(criteria)
//
// Detail -------------------------------------------------------------------------------------------
// ..
// ..
// ..
// ..
//
// Footer -------------------------------------------------------------------------------------------
//	p_stars_logo								st_page (page_numbers)									
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	12/07/04	GaryR	Stars logo is required, but page is optional
// 09/04/08 Rick SPR 5534 Added accessibility properties to starslogo.bmp
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//=========================================================================================================//
string ls_mod

this.uf_remove_footer()

// Client Logo - p_logo
ls_mod = 'create bitmap(band=footer filename="starslogo.bmp" x="3" y="3" ' + &
				'height="25" width="50" border="0"  name=p_stars_logo visible="1" ' + &
				'accessibledescription="~~"STARS Logo~~"~~t~~"STARS Logo~~"" accessiblename="~~"STARS Logo~~"~~t~~"STARS Logo~~"" accessiblerole=40 ) '
this.uf_mod_dw(ls_mod)

// Page numbers
IF ab_add_page THEN
	ls_mod = 'create compute(band=footer alignment="0" expression="' + "'Page ' + page() + ' of ' + pageCount()" + '"'	+ &
				'border="0" color="' + String( stars_colors.window_text ) + '" x="567" y="8" height="13" width="94" format="[general]" html.valueishtml="0" ' 	+ &
				'name=page_1 visible="1" font.face="Microsoft Sans Serif" font.height="-8" font.weight="400" ' 			+ &
				'font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="' + String( stars_colors.transparent ) + '"' + &
				'accessibledescription="~~"Page Count~~"~~t~~"Page Count~~"" accessiblename="~~"Page Count~~"~~t~~"Page Count~~"" accessiblerole=42 ) '
	this.uf_mod_dw(ls_mod)
END IF

// Size the footer band
this.uf_mod_dw('datawindow.footer.height="30"')
end subroutine

public subroutine uf_add_generic_title (string as_title);//*********************************************************************************
// Script Name:	uf_add_generic_title
//
// Arguments:	String	value	as_title
//
// Returns:		None
//
// Description:	Adds a generic title to the requesting datawindow
//
//*********************************************************************************
//
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

string	ls_mod  

setpointer(hourglass!)

this.uf_mod_dw("datawindow.header.height=300")

//  Report Title
ls_mod = "create text(band=Header color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'" + &
	"  x='1500' y='50' height='200' width= '2000' text=~'" + as_title + "~' " + &
	" name=rpt_hdr_t font.face='System' font.height= '-10' font.weight='700' " + &
	"font.family='2' font.pitch='2' font.charset='0' font.italic='0' " + &
	"font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Title~~"~~t~~"Title~~"" accessiblename="~~"Title~~"~~t~~"Title~~"" accessiblerole=42 ) '

this.uf_mod_dw(ls_mod)

ls_mod = "create text(band=Foreground color='" + String( stars_colors.window_text ) + "' alignment='0' border='0'" + &
	"  x='4000' y='50' height='200' width= '2000' text=~'" + string(datetime(today(),now())) + "~' " + &
	" name=st_date font.face='System' font.height= '-10' font.weight='700' " + &
	" font.family='2' font.pitch='2' font.charset='0' font.italic='0' " + &
	" font.strikethrough='0' font.underline='0' background.mode='1' background.color='" + String( stars_colors.window_background ) + "' " + &
	'accessibledescription="~~"Date and time stamp~~"~~t~~"Date and time stamp~~"" accessiblename="~~"Date and time stamp~~"~~t~~"Date and time stamp~~"" accessiblerole=42 ) '
	
this.uf_mod_dw(ls_mod)
end subroutine

public subroutine uf_format_col_headers ();
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//=========================================================================================================//

int		li_index
string	ls_col, ls_mod, ls_label

FOR li_index = 1 to ii_cols
	ls_col = idw.Describe('#'+string(li_index)+'.name')
	IF this.uf_get_object_exists(ls_col + "_t") THEN
		ls_label = idw.Describe(ls_col + '_t.text')
		ls_mod =  ls_col + '_t.font.face="Microsoft Sans Serif" '
		ls_mod += ls_col + '_t.font.height="-8" ' 
		ls_mod += ls_col + '_t.font.weight="700" '
		ls_mod += ls_col + '_t.font.family="2" '
		ls_mod += ls_col + '_t.font.pitch="2" '
		ls_mod += ls_col + '_t.font.charset="0" '
		ls_mod += ls_col + '_t.border="' + string(ici_3draise) + '" '
		ls_mod += ls_col + '_t.height="40" '
		ls_mod += ls_col + '_t.alignment="'+ string(ici_center) + '" '
		ls_mod += ls_col + '_t.background.mode="2" ' 
		ls_mod += ls_col + '_t.background.color="' + String( stars_colors.button_face ) + '" '
		
		//	Set Accessibility Properties
		ls_label = inv_string.of_clean_string_acc( ls_label )
		ls_label = '"' + ls_label + '"~t"' + ls_label + '"'
		ls_mod += ls_col + ".AccessibleName='" + ls_label + "' "
		ls_mod += ls_col + ".AccessibleDescription='" + ls_label + "' "
		ls_mod += ls_col + ".AccessibleRole='27' "	//	ColumnRole!
		ls_mod += ls_col + "_t.AccessibleName='" + ls_label + "' "
		ls_mod += ls_col + "_t.AccessibleDescription='" + ls_label + "' "
		ls_mod += ls_col + "_t.AccessibleRole='42' "	//	TextRole!
	
		this.uf_mod_dw(ls_mod)
	END IF
NEXT
end subroutine

public subroutine uf_format_details ();
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
Long		ll_cnt, ll_ctr
String	ls_objects, ls_names[], ls_band, ls_mod
n_cst_string	lnv_string

ls_objects = idw.Object.DataWindow.Objects
ll_cnt 	  = lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )

//	Loop through and format all objects in the detail band where tag <> 'BYPASS'
FOR ll_ctr = 1 TO ll_cnt
	ls_band = Lower( idw.Describe( ls_names[ll_ctr] + ".Band" ) )
	IF ls_band = "detail" THEN
		IF idw.describe(ls_names[ll_ctr] + ".Tag") <> 'BYPASS' THEN
			ls_mod = this.uf_get_default_text_mod(ls_names[ll_ctr])		
			this.uf_mod_dw(ls_mod)
		END IF
	END IF
NEXT
end subroutine

public function boolean uf_get_is_dw_grid ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_is_dw_grid
//=========================================================================================================//
// Determines is a datawindow is a grid style
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/02/04	MikeF	SPR4108d	Created
//=========================================================================================================//
RETURN idw.describe("DataWindow.Processing") = "1"
end function

public function boolean uf_get_object_exists (string as_object);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_object_exists
// Arguments	adw			u_dw		Requestor
//					as_object	String	Object and property
// Returns						Boolean	Exists
//=========================================================================================================//
// Returns modify statement for standard data
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/02/04	MikeF	SPR4108d	Created
//=========================================================================================================//
RETURN idw.describe(as_object + ".visible") <> '!'

end function

public function sx_dw_format uf_get_structure ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_structure
//=========================================================================================================//
// Populates and returns astructure based on a dw
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/01/04	MikeF	SPR4108d	Created
//=========================================================================================================//
string			ls_value
sx_dw_format	lsx_format

lsx_format.title 					= this.uf_get_string_value( "st_title.text" )
lsx_format.subtitle1				= this.uf_get_string_value( "st_sub1.text" )
lsx_format.subtitle2				= this.uf_get_string_value( "st_sub2.text" )
lsx_format.subtitle3				= this.uf_get_string_value( "st_sub3.text" )
lsx_format.subtitle4				= this.uf_get_string_value( "st_sub4.text" )
lsx_format.description			= this.uf_get_string_value( "st_description.text" )

lsx_format.report_id				= this.uf_get_string_value( "st_report_id.text" )
lsx_format.display_report_id 	= this.uf_get_string_value( "st_report_id.visible" ) = "1"

lsx_format.report_name			= this.uf_get_string_value( "st_report_type.text" )
lsx_format.display_report_name= this.uf_get_string_value( "st_report_type.visible" ) = "1"

lsx_format.report_date			= this.uf_get_string_value( "st_date.text" )
lsx_format.display_report_date= this.uf_get_string_value( "st_date.visible" ) = "1"

lsx_format.subset					= this.uf_get_string_value( "st_subset.text" )
lsx_format.display_subset		= this.uf_get_string_value( "st_subset.visible" ) = "1"

lsx_format.criteria				= this.uf_get_string_value( "st_constraint.text" )
lsx_format.display_criteria	= this.uf_get_string_value( "st_constraint.visible" ) = "1"

lsx_format.subject_label		= this.uf_get_string_value( "t_subject.text" )
lsx_format.subject				= this.uf_get_string_value( "st_subject.text" )
lsx_format.display_subject		= this.uf_get_string_value( "st_subject.visible" ) = "1"

lsx_format.inv_type				= this.uf_get_string_value( "st_inv_type.text" )
lsx_format.display_inv_type	= this.uf_get_string_value( "st_inv_type.visible" ) = "1"

lsx_format.statement				= this.uf_get_string_value( "st_customstatement.text" )
lsx_format.client_name			= this.uf_get_string_value( "st_clientname.text" )
lsx_format.logo_file 			= this.uf_get_string_value( "p_sitelogo.filename" )

lsx_format.page_numbers			= this.uf_get_string_value( "page_1.visible" ) = "1"

lsx_format.gridlines = this.uf_get_string_value("DataWindow.Grid.Lines") = "0" 

// Get the hidden format flags
ls_value = idw.describe("t_format_flags.text")

IF  ls_value <> "!" &
AND isNumber(ls_value) THEN
	lsx_format.report_options = integer(ls_value)
ELSE
	lsx_format.report_options = 0
END IF

RETURN lsx_format
end function

public subroutine uf_set_default_disp_formats (boolean ab_set_widths);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_set_disp_formats
// Arguments	adw				u_dw		Datawindow to mainpulate
//					ab_set_widths	boolean	Flag to alter widths
// Returns		<None>
//=========================================================================================================//
// Loops through all columns and set default display formats based on data type. Optionally, sets columns 
// widths based on data type and length.
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
// 03/03/05 MikeF	SPR4339d	Set col width on CHAR data from dictionary if available
//=========================================================================================================//
int		li_index, li_pos, li_len, li_label_len
string	ls_col, ls_mod, ls_type, ls_dbname

FOR li_index = 1 to ii_cols
	ls_col 	= idw.Describe('#'+string(li_index)+'.name')
	ls_type 	= trim(idw.Describe(ls_col + '.ColType'))
	li_pos 	= pos(ls_type,"(")
	
	IF li_pos > 0 THEN 
		li_len 	= len(ls_type)
		li_len	= integer(mid(ls_type,li_pos + 1, li_len - li_pos - 1))
		ls_type 	= left(ls_type,li_pos - 1)
	ELSE
		li_len 	= 0
	END IF
		
	// Set display format
	IF	(gnv_sql.of_is_money_data_type (ls_type)	OR ls_type = 'number')	THEN
		idw.Setformat(ls_col,'###,###,##0.00')
		ls_mod = ls_col + ".width = 100 " 
	ELSEIF gnv_sql.of_is_date_data_type (ls_type) THEN
		idw.Setformat(ls_col,'mm/dd/yyyy')
		ls_mod = ls_col + ".width = 100 " 
	ELSEIF ls_type = 'long' THEN
		idw.Setformat(ls_col,'###,###,##0')
		ls_mod = ls_col + ".width = 60 " 
	ELSE
		// Character Data
		ls_dbname = idw.Describe('#'+string(li_index)+'.dbname')

		// If available, get the real data length from DICTIONARY 
		// - required due to strange dw results - ie Type Bill = char(41) ???
		IF len(is_inv_type) > 0  THEN
			IF gnv_dict.event ue_get_col_exists(is_inv_type, ls_dbname) THEN
				li_len = gnv_dict.event ue_get_data_len(is_inv_type, ls_dbname)
			END IF
		END IF

		IF li_len < 5 THEN
			li_len = 5
		END IF
		
		li_label_len = this.uf_get_label_width( li_index )
		
		IF li_label_len > li_len THEN
			li_len = li_label_len
		END IF
		
		ls_mod = ls_col + ".width = " + string(li_len * 8) + " "
		
	END IF

	// Set widths if ab_set_widths
	IF ab_set_widths THEN
		this.uf_mod_dw(ls_mod)
	END IF
NEXT

IF ab_set_widths THEN
	this.uf_size_header_background()
END IF



end subroutine

public subroutine uf_toggle_gridlines (boolean ab_visible);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_toggle_gridlines
//=========================================================================================================//
// Loops through all columns and replaces the Column Headings with ELEM_ELEM_LABEL from the dictionary
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
string	ls_grid = "1"

IF this.uf_get_is_dw_grid() THEN
	IF ab_visible THEN ls_grid = "0"
	this.uf_mod_dw("DataWindow.Grid.Lines='" + ls_grid + "'" )
END IF

end subroutine

public subroutine uf_set_header (sx_dw_format asx_format);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_set_header
//=========================================================================================================//
// Sets text for existing header elements (NON-dynamic headers)
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/19/04	MikeF	SPR4108d	Created
//=========================================================================================================//
idw.SetRedraw(FALSE)

// Client Logo - p_logo
IF len(trim(asx_format.logo_file)) > 0 THEN
	this.uf_mod_dw('p_sitelogo.filename="' + asx_format.logo_file + '"')
END IF

this.uf_set_text("st_customstatement", 	asx_format.statement,	TRUE)
this.uf_set_text("st_clientname", 	asx_format.client_name,	TRUE)
this.uf_set_text("st_title", 			asx_format.title,			TRUE)
this.uf_set_text("st_subtitle1", 	asx_format.subtitle1,	TRUE)
this.uf_set_text("st_subtitle2", 	asx_format.subtitle2,	TRUE)
this.uf_set_text("st_subtitle3", 	asx_format.subtitle3,	TRUE)
this.uf_set_text("st_subtitle4", 	asx_format.subtitle4,	TRUE)
this.uf_set_text("st_report_type", 	asx_format.report_name,	TRUE)
this.uf_set_text("t_subject",		 	asx_format.subject_label, TRUE)
this.uf_set_text("st_subject", 		asx_format.subject,		asx_format.display_subject)
this.uf_set_text("st_report_type", 	asx_format.report_name,	asx_format.display_report_name)
this.uf_set_text("st_subset", 		asx_format.subset,		asx_format.display_subset)
this.uf_set_text("st_description", 	asx_format.description,	TRUE)
this.uf_set_text("st_date", 			asx_format.report_date,	asx_format.display_report_date)
this.uf_set_text("st_report_id", 	asx_format.report_id,	asx_format.display_report_id)
this.uf_set_text("st_constraint", 	asx_format.criteria ,	asx_format.display_criteria)

//	Hide the header - This needs to be implemented
//IF NOT asx_format.display_header THEN This.uf_hide_header( adw )

idw.SetRedraw(TRUE)
end subroutine

public subroutine uf_set_disp_formats (string as_tbl_type, boolean ab_set_widths);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_set_disp_formats
// Arguments	adw				u_dw		Datawindow to mainpulate
//					ab_set_widths	boolean	Flag to alter widths
// Returns		<None>
//=========================================================================================================//
// Loops through all columns and sets display formats defined in dictionary. Optionally, sets columns 
// widths based on data type and length.
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
int		li_index, li_len, li_pos
string	ls_col, ls_format, ls_type, ls_mod

FOR li_index = 1 to ii_cols
	ls_col 		= idw.Describe('#'+string(li_index)+'.name')
	ls_type		= idw.Describe('#'+string(li_index)+'.ColType')
	
	li_pos 	= pos(ls_type,"(")
	
	IF li_pos > 0 THEN 
		li_len 	= len(ls_type)
		li_len	= integer(mid(ls_type,li_pos + 1, li_len - li_pos - 1))
		ls_type 	= left(ls_type,li_pos - 1)
	ELSE
		li_len 	= 0
	END IF
	
	IF gnv_dict.event ue_get_col_exists(as_tbl_type, ls_col) THEN
		// Get DISP_FORMAT from Dictionary
		ls_format	= trim(gnv_dict.event ue_get_disp_format(as_tbl_type, ls_col))

		IF gnv_sql.of_is_character_data_type (ls_type) THEN
			IF IsNumber(ls_format) THEN 
				li_len = integer(ls_format)
				ls_mod = ls_col + ".width = " + string(li_len * 10) + " "
			ELSE
				IF li_len > 5 THEN
					ls_mod = ls_col + ".width = " + string(li_len * 10) + " "
				ELSE
					ls_mod = ls_col + ".width = 40 "
				END IF
			END IF
		ELSE
			IF len(ls_format) > 0 THEN
				idw.Setformat(li_index, ls_format)
			END IF
			
			ls_mod = ls_col + ".width = 100 " 
				
		END IF
				
	END IF

	// Set widths if ab_set_widths
	IF ab_set_widths THEN
		this.uf_mod_dw(ls_mod)
	END IF
NEXT

IF ab_set_widths THEN
	this.uf_size_header_background()
END IF


end subroutine

public function integer uf_hide_header ();///////////////////////////////////////////////////////////////////
//
//	This method needs to be implemented for hiding static headers
//
///////////////////////////////////////////////////////////////////

Long		ll_cnt, ll_ctr, ll_y, ll_height, ll_max_height, ll_rpt_height, ll_min_y = 999999
String	ls_objects, ls_names[], ls_band
n_cst_string	lnv_string

ls_objects = idw.Object.DataWindow.Objects
ll_cnt = lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )

//	Set all objects in 
//	foreground band invisible
FOR ll_ctr = 1 TO ll_cnt
	ls_band = Lower( idw.Describe( ls_names[ll_ctr] + ".Band" ) )
	IF ls_band = "foreground" THEN
		idw.Modify( ls_names[ll_ctr] + ".visible=0" )
	ELSEIF ls_band = "header" THEN
		ll_y = Long( idw.Describe( ls_names[ll_ctr] + ".y" ) )
		IF ll_y < ll_min_y THEN ll_min_y = ll_y
	END IF
NEXT

//	Move the Report Id to top of report
IF idw.Describe( "st_report_id.visible" ) <> "!" THEN
	idw.object.st_report_id.visible = 1
	idw.object.st_report_id.y = 0
	idw.object.st_report_id.x = 0
	idw.object.st_report_id.alignment = 0
	idw.object.st_report_id.font.weight = 700
	idw.object.st_report_id.text = "Report ID: " + idw.object.st_report_id.text
	this.uf_mod_dw("st_report_id.width='" + string(Long(idw.object.st_report_id.width) * 3) + "'")
//	idw.object.st_report_id.width = Long( idw.object.st_report_id.width ) * 3
	ll_rpt_height = Long( idw.object.st_report_id.height ) + 2
END IF

FOR ll_ctr = 1 TO ll_cnt
	ls_band = Lower( idw.Describe( ls_names[ll_ctr] + ".Band" ) )
	IF ls_band = "header" THEN
		ll_y = Long( idw.Describe( ls_names[ll_ctr] + ".y" ) )
		this.uf_mod_dw(ls_names[ll_ctr] + ".y=" + String( ( ll_y - ll_min_y ) + ll_rpt_height ) )
		ll_height = Long( idw.Describe( ls_names[ll_ctr] + ".height" ) )
		ll_height = ( ll_y - ll_min_y ) + ll_height
		IF ll_height > ll_max_height THEN ll_max_height = ll_height
	END IF
NEXT

this.uf_mod_dw("DataWindow.Header.Height='" + string(ll_max_height + ll_rpt_height + 2) + "'")

Return 1
end function

private function string uf_get_default_text_mod (string as_col);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_format_column_mod
// Arguments	as_mod		string	Datawindow modify string
// Returns						string	Modify statement
//=========================================================================================================//
// Returns modify statement for standard data
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
string		ls_mod

// Modify columns
ls_mod =  as_col + '.font.face="Microsoft Sans Serif" '
ls_mod += as_col + '.font.height="-8" ' 
ls_mod += as_col + '.font.weight="400" '
ls_mod += as_col + '.font.family="2" '
ls_mod += as_col + '.font.pitch="2" '
ls_mod += as_col + '.font.charset="0" '

RETURN ls_mod
end function

private function long uf_get_page_width ();//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_get_page_width
// Returns		long
//=========================================================================================================//
// Returns the Page width, or sum of column widths (whichever is larger) in UNITS
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
int		li_index
long		ll_width

FOR li_index = 1 to ii_cols
	ll_width += long(idw.Describe('#'+string(li_index)+'.width'))
NEXT

IF this.uf_get_pixels(ll_width,TRUE) > ii_page THEN
	RETURN ll_width
END IF

RETURN this.uf_get_units(ii_page,TRUE)
end function

private subroutine uf_move_col_headers (long al_offset);
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
Long		ll_cnt, ll_ctr, ll_y
String	ls_objects, ls_names[], ls_band, ls_tag
n_cst_string	lnv_string

ls_objects 	= idw.Object.DataWindow.Objects
ll_cnt 		= lnv_string.of_parsetoarray( ls_objects, "~t", ls_names )

//	Move all objects in foreground band invisible
FOR ll_ctr = 1 TO ll_cnt
	ls_band 	= Upper( idw.Describe( ls_names[ll_ctr] + ".Band" ))
	ls_tag	= Upper( idw.Describe( ls_names[ll_ctr] + ".Tag"  ))
	IF ls_band = "HEADER" &
	OR	ls_tag  = "BYPASS" THEN
		ll_y = Long( idw.Describe( ls_names[ll_ctr] + ".y" ) )
		ll_y = this.uf_get_pixels( ll_y, FALSE)
		this.uf_mod_dw(ls_names[ll_ctr] + ".y='" + string(ll_y + al_offset) + "'")
	END IF
NEXT
end subroutine

private function integer uf_set_text_height (string as_object, string as_text);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_set_text_height
// Arguments	as_object	string	Datawindow object
//					as_text		string	Text
// Returns						int		Height of object when finished
//=========================================================================================================//
// Sizes the height of a description or criteria object based on the length of the text.
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 12/01/04	MikeF	SPR4108d	Created
//=========================================================================================================//
long		ll_height, ll_width 
int		li_len, li_lines

li_len 	 = len(trim(as_text))

// Get the objects height and convert to pixels
ll_height = integer(idw.describe(as_object + ".height"))
ll_height = this.uf_get_pixels( ll_height, FALSE)

// Get the objects width and convert to pixels
ll_width  = integer(idw.describe(as_object + ".width"))
ll_width  = this.uf_get_pixels( ll_width, TRUE)

li_lines 	= (li_len / (ll_width / icr_text_ratio)) + 1

IF li_lines = 1 THEN
	RETURN ll_height + 1
ELSE
	ll_height	= ll_height * li_lines
	this.uf_mod_dw( as_object + ".height='" + string(ll_height) + "'")
END IF

RETURN ll_height



end function

private function string uf_get_label_name (string as_name);//*********************************************************************************
// Script Name:	n_cst_dw_format.uf_get_label_name
//
// Arguments:	String	by value	as_name
//
// Returns:		String
//
// Description:	Get the header name for the argument column.
//
//*********************************************************************************
//
//	05/01/09	GaryR	PAT.600.5698.001	Follow the new duplicate column header naming convention 
//
//*********************************************************************************

int		li_pos
string	ls_dbname, ls_header

// Strip off alias name if necessary
ls_dbname = idw.describe(as_name + ".dbname")
li_pos 	 = 	pos(ls_dbname, '.')
if li_pos > 0 then
	ls_dbname 	= 	mid(ls_dbname, li_pos + 1)
end if

// Get the object name from the datawindow
if (upper(ls_dbname) <> upper(as_name)) and (match(right(as_name,2), '^_[0-9]$')) then
	ls_header = Left( as_name, Len( as_name ) - 2 ) + '_t' + right(as_name,2) + '_t'
else
	ls_header = as_name + '_t'
end if

RETURN ls_header
end function

public subroutine uf_set_labels (string as_tbl_type);//=========================================================================================================//
// Object		n_cst_dw_format
// Script		uf_set_labels
//=========================================================================================================//
// Loops through all columns and replaces the Column Headings with ELEM_ELEM_LABEL from the dictionary
//=========================================================================================================//
// Maintenance
// -------- ----- -------- --------------------------------------------------------------------------------
// 11/10/04	MikeF	SPR4108d	Created
//=========================================================================================================//
int		li_index
string	ls_col_name, ls_header, ls_dbname, ls_label

FOR li_index = 1 to ii_cols

	ls_dbname	= idw.Describe('#' + string(li_index) + '.dbname')
	ls_col_name	= idw.Describe('#' + string(li_index) + '.name')
	ls_header 	= this.uf_get_label_name( ls_col_name )

	// Get descriptive information for this database column from the dictionary
	IF gnv_dict.event ue_get_col_exists( Upper(as_tbl_type), Upper(ls_dbname)) THEN
		ls_label  = gnv_dict.event ue_get_elem_label ( Upper(as_tbl_type), Upper(ls_dbname))
		this.uf_mod_dw(ls_header + '.text="' + ls_label + '"')
	END IF

NEXT
//** This method is not in use as of 5.3 GA ** Meaning NOT TESTED *** //

end subroutine

private function integer uf_get_label_width (integer ai_col_number);int		li_text_len, li_pos
string	ls_col_name, ls_label_name
string	ls_label_text, ls_text1, ls_text2

ls_col_name		= idw.describe("#" + string(ai_col_number) + ".name")
ls_label_name 	= this.uf_get_label_name(ls_col_name)
	
IF this.uf_get_object_exists( ls_label_name ) THEN
	ls_label_text = idw.describe(ls_label_name + ".text")
		
	IF match(ls_label_text, '~n') THEN
		li_pos 	= 	pos(ls_label_text, '~n')
		ls_text1 = 	left(ls_label_text, li_pos - 1)
		ls_text2 = 	mid(ls_label_text, li_pos + 1)
		
		IF len(ls_text1) >= len(ls_text2) THEN
			li_text_len	=	len(ls_text1)
		ELSEIF len(ls_text2) > len(ls_text1) THEN
			li_text_len = 	len(ls_text2)
		END IF
		
	ELSEIF match(ls_label_text, '~r') THEN
		li_pos 	= 	pos(ls_label_text, '~r')
		ls_text1 = 	left(ls_label_text, li_pos - 1)
		ls_text2 = 	mid(ls_label_text, li_pos + 1)
		
		IF len(ls_text1) >= len(ls_text2) THEN
			li_text_len	=	len(ls_text1)
		ELSEIF len(ls_text2) > len(ls_text1) THEN
			li_text_len = 	len(ls_text2)
		END IF
	ELSE
		li_text_len = 	len(ls_label_text)
	END IF
ELSE
	li_text_len = 0
END IF

RETURN li_text_len 
end function

public subroutine uf_set_inv_type (string as_inv_type);is_inv_type = as_inv_type
end subroutine

on n_cst_dw_format.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dw_format.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// When using n_cst_dw_format, you MUST call ue_register_dw to register the datawindow before using any of the functions.

end event

