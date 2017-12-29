$PBExportHeader$n_ds_titlepage.sru
$PBExportComments$<logic>
forward
global type n_ds_titlepage from n_ds
end type
end forward

global type n_ds_titlepage from n_ds
string dataobject = "d_title_page"
event type integer ue_populate ( ref u_dw adw_report )
end type
global n_ds_titlepage n_ds_titlepage

forward prototypes
public subroutine of_parse_title_desc (ref sx_dw_format asx_report_options)
end prototypes

event type integer ue_populate(ref u_dw adw_report);//	12/13/04	GaryR	Track 4108d	Dynamic Report Options
// 01/06/05 MikeF	SPR 4205d	Must register dw w/ n_cst_dw_format

String	ls_dblquote
sx_dw_format	lsx_report_options
n_cst_dw_format	lnv_format

IF messagebox("Print","Would you like to print the Title page", Question!, YesNo!, 2) <> 1 THEN Return 0

IF NOT IsValid( adw_report ) THEN Return -1

This.Reset()
This.InsertRow( 0 )

lnv_format.event ue_register_dw(adw_report)
lsx_report_options = lnv_format.uf_get_structure()

This.of_parse_title_desc( lsx_report_options )
This.SetItem( 1, "report_title", lsx_report_options.title )
This.SetItem( 1, "sub_title1", lsx_report_options.subtitle1 )
This.SetItem( 1, "sub_title2", lsx_report_options.subtitle2 )
This.SetItem( 1, "sub_title3", lsx_report_options.subtitle3 )
This.SetItem( 1, "sub_title4", lsx_report_options.subtitle4 )
This.SetItem( 1, "description", lsx_report_options.description )
This.SetItem( 1, "client_name", lsx_report_options.client_name )
This.SetItem( 1, "custom_stmt", lsx_report_options.statement )
This.SetItem( 1, "report_type", lsx_report_options.report_name )
This.SetItem( 1, "run_date", lsx_report_options.report_date )
This.SetItem( 1, "report_id", lsx_report_options.report_id )
This.SetItem( 1, "criteria", lsx_report_options.criteria )
This.SetItem( 1, "user_id", gv_user_id )
This.object.p_sitelogo.filename = lsx_report_options.logo_file

IF Trim( lsx_report_options.subset ) <> "" THEN
	This.object.subset_t.visible = 1
	This.object.subset.visible = 1
	This.SetItem( 1, "subset", lsx_report_options.subset )
END IF

IF Trim( lsx_report_options.inv_type ) <> "" THEN
	This.object.invoice_t.visible = 1
	This.object.invoice.visible = 1
	This.SetItem( 1, "invoice", lsx_report_options.inv_type )
END IF

Return 1
end event

public subroutine of_parse_title_desc (ref sx_dw_format asx_report_options);////////////////////////////////////////////////////////////////////////////////
//
//	This method will parse old titles and break them down into the new format
//
////////////////////////////////////////////////////////////////////////////////
//
//	12/13/04	GaryR	Track 4108d	Dynamic Report Options
//
////////////////////////////////////////////////////////////////////////////////

String	ls_title[]
Constant	String	BREAK = Char(13) + Char(10)
Integer	i, li_ctr, li_pos
n_cst_string	lnv_string


//	Check for line breaks in legacy titles
lnv_string.of_parsetoarray( asx_report_options.title, BREAK, ls_title )

FOR i = 1 TO UpperBound( ls_title )
	//	Check for more than 80 bytes in legacy titles
	li_ctr ++
	IF Len( ls_title[i] ) > 80 THEN
		//	Break on last space
		li_pos  = LastPos( ls_title[i], " " )
		IF li_pos < 1 THEN li_pos = 80
		CHOOSE CASE li_ctr
			CASE 1
				asx_report_options.title = Left( ls_title[i], li_pos )
				asx_report_options.subtitle1 = Mid( ls_title[i], li_pos + 1 )
			CASE 2
				asx_report_options.subtitle1 = Left( ls_title[i], li_pos )
				asx_report_options.subtitle2 = Mid( ls_title[i], li_pos + 1 )
			CASE 3
				asx_report_options.subtitle2 = Left( ls_title[i], li_pos )
				asx_report_options.subtitle3 = Mid( ls_title[i], li_pos + 1 )
			CASE 4
				asx_report_options.subtitle3 = Left( ls_title[i], li_pos )
				asx_report_options.subtitle4 = Mid( ls_title[i], li_pos + 1 )
		END CHOOSE
		li_ctr ++
	ELSE
		CHOOSE CASE li_ctr
			CASE 1
				asx_report_options.title = ls_title[i]
			CASE 2
				asx_report_options.subtitle1 = ls_title[i]
			CASE 3
				asx_report_options.subtitle2 = ls_title[i]
			CASE 4
				asx_report_options.subtitle3 = ls_title[i]
			CASE 5
				asx_report_options.subtitle4 = ls_title[i]
		END CHOOSE
	END IF
NEXT

//	Remove any carriage returns in legacy descriptions
asx_report_options.description = lnv_string.of_globalreplace( asx_report_options.description, BREAK, " " )
end subroutine

on n_ds_titlepage.create
call super::create
end on

on n_ds_titlepage.destroy
call super::destroy
end on

