HA$PBExportHeader$n_dwr_service_parm.sru
forward
global type n_dwr_service_parm from nonvisualobject
end type
end forward

shared variables

end variables

global type n_dwr_service_parm from nonvisualobject
end type
global n_dwr_service_parm n_dwr_service_parm

type variables
public boolean ib_header = true
public boolean ib_foreground = true
public boolean ib_background = true
public boolean ib_detail = true
public boolean ib_summary = true
public boolean ib_footer = true
public boolean ib_group_header = true
public boolean ib_group_trailer = true
public boolean ib_keep_band_height = false
public boolean ib_enable_merge_cells = true
public boolean ib_show_progress = true
public boolean ib_hide_grid = false
public string is_version = '97' // 97, OOXML
public string is_sheet_name = 'Sheet1'
public boolean ib_group_pagebreak = false
public boolean ib_group_pageheader = true
public boolean ib_nested = true
public double id_min_width = 0.5 /* Excel units */
public double id_min_height = 4.0 /* Excel units */

//internal use only
public long il_nested_instance_count = 0
public int ii_nested_extract_method = 1 // 0, 1

// <XLS header support>

// The text to be added in top of XLS
// If is_title_text = "" then the rest of header parameters are ignored 
// and the header is not generated. 
String is_title_text = ""

//The font
String is_title_font = "Arial"
Long il_title_font_family = 0
Long il_title_font_charset = 0
//The font size
Long il_title_font_size = 10

//The colors. Use RGB()
ULong il_title_fg_color = 33554432
ULong il_title_bg_color = 1073741824 

//The alignment of the text inside the header cell. 
String is_title_text_align = "center" //("center"|"left"|"right")

//The alignment of the header cell inside the page. 
String is_title_align = "left" //("center"|"left"|"right")


//The font is bold/italic/underlined 
Boolean ib_title_font_bold = True
Boolean ib_title_font_underline = False
Boolean ib_title_font_italic = False

//The size of header cell (DW units).
Long il_title_height = 100
Long il_title_width = 2800

//The height of empty row separating the header from the rest of data
Long il_title_separator_height = 100

// Export lines (except inclined)
Boolean ib_lines = false
// Export rectangles
Boolean ib_rectangles = false

Boolean ib_background_color = false

// </XLS header support>



end variables

forward prototypes

end prototypes

on n_dwr_service_parm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_dwr_service_parm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

