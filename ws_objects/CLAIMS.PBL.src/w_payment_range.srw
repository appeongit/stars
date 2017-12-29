$PBExportHeader$w_payment_range.srw
forward
global type w_payment_range from w_master
end type
type cb_close from u_cb within w_payment_range
end type
type dw_payment_range from u_dw within w_payment_range
end type
type st_row_count from statictext within w_payment_range
end type
end forward

global type w_payment_range from w_master
long backcolor = 67108864
string accessiblename = "Claims Payment Range"
string accessibledescription = "Claims Payment Range"
accessiblerole accessiblerole = windowrole!
integer width = 3145
integer height = 1872
string title = "Claims Payment Range"
cb_close cb_close
dw_payment_range dw_payment_range
st_row_count st_row_count
end type
global w_payment_range w_payment_range

on w_payment_range.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_payment_range=create dw_payment_range
this.st_row_count=create st_row_count
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_payment_range
this.Control[iCurrent+3]=this.st_row_count
end on

on w_payment_range.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_payment_range)
destroy(this.st_row_count)
end on

type cb_close from u_cb within w_payment_range
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2770
integer y = 1668
integer taborder = 20
string text = "&Close"
boolean cancel = true
end type

event clicked;call super::clicked;Close( Parent )
end event

type dw_payment_range from u_dw within w_payment_range
string accessiblename = "Claims Payment Range"
string accessibledescription = "Claims Payment Range"
accessiblerole accessiblerole = clientrole!
integer width = 3086
integer height = 1656
integer taborder = 10
string dataobject = "d_payment_range"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;///////////////////////////////////////////////////////////////
//
//	10/07/02	GaryR	Track 3275d	Give users ability to lookup
//										Claims Payment Range.  Added.
// 10/19/04 MikeF	Track 3650d	Replaced local n_cst_dict with global service
///////////////////////////////////////////////////////////////

Integer	li_row
String	ls_sql, ls_tbl_type
DateTime	ldtm_from_date, ldtm_to_date
DatawindowChild	ldwc_inv_type
n_cst_labels		lnv_labels

This.of_SetUpdateable( FALSE )
This.of_SingleSelect( TRUE )
This.SetTransObject( Stars1ca )

ls_sql = "SELECT CLAIMS_CNTL.INV_TYPE, " + &
					 "CLAIMS_CNTL.FROM_DATE, " + &
					 "CLAIMS_CNTL.TO_DATE, " + &
					 "CLAIMS_CNTL.MSG " + &
			"FROM CLAIMS_CNTL " + &
			"UNION SELECT SR.ID_2, " + &
					 "CLAIMS_CNTL.FROM_DATE, " + &
					 "CLAIMS_CNTL.TO_DATE, " + &
					 "CLAIMS_CNTL.MSG " + &
			"FROM " + gnv_sql.of_get_database_prefix( Stars2ca.DataBase ) + &
			"STARS_REL SR, CLAIMS_CNTL " + &
			"WHERE SR.REL_TYPE = 'GP' " + &
			"AND SR.ID_3 = CLAIMS_CNTL.INV_TYPE"
			
This.SetSQLSelect( ls_sql )
This.Retrieve()

//	Retrieve the invoice 
//	type dddw for decoding
This.GetChild( "inv_type", ldwc_inv_type )
ldwc_inv_type.SetTransObject( Stars2ca )
ldwc_inv_type.Retrieve()

// Add MC to list
IF gnv_server.of_GetLoadedRange( "MC", "", ldtm_from_date, ldtm_to_date ) = 1 THEN
	li_row = This.InsertRow( 0 )
	This.SetItem( li_row, "inv_type", "MC" )
	This.SetItem( li_row, "from_date", ldtm_from_date )
	This.SetItem( li_row, "to_date", ldtm_to_date )
END IF

//	Reformat DW according to dictionary
ls_tbl_type = gnv_dict.event ue_get_inv_type( "CLAIMS_CNTL" )
IF ls_tbl_type <> "Error" THEN
	lnv_labels = Create n_cst_labels
	lnv_labels.of_SetDW( This )
	lnv_labels.of_labels2( ls_tbl_type )
	Destroy lnv_labels
END IF

//	Sort the list
This.SetSort( "inv_type asc" )
This.Sort()

st_row_count.text = String( This.RowCount() )
end event

type st_row_count from statictext within w_payment_range
string accessiblename = "Row Count"
string accessibledescription = "0"
accessiblerole accessiblerole = statictextrole!
string tag = "colorfixed"
integer y = 1668
integer width = 274
integer height = 80
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
long backcolor = 134217744
boolean enabled = false
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

