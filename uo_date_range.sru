HA$PBExportHeader$uo_date_range.sru
$PBExportComments$<gui>
forward
global type uo_date_range from u_base
end type
type dw_1 from u_dw within uo_date_range
end type
end forward

global type uo_date_range from u_base
string accessiblename = "Date Range"
string accessibledescription = "Date Range"
integer width = 933
integer height = 256
boolean border = false
event ue_initialize ( )
dw_1 dw_1
end type
global uo_date_range uo_date_range

type variables
constant int	ici_all 			= 1
constant int	ici_days 		= 2
constant int	ici_range		= 3

int				ii_days

n_cst_datetime	inv_date
end variables

forward prototypes
public function integer of_get_type ()
public function integer of_get_range (ref date ad_from, ref date ad_thru)
public function integer of_validate_date (string as_date)
end prototypes

event ue_initialize();// 08/15/05 MikeF SPR4485d	Combined code from object and dw_1 constructors

u_nvo_sys_cntl		lnv_sys

lnv_sys = CREATE u_nvo_sys_cntl
lnv_sys.of_set_cntl_id( this.tag )
ii_days = lnv_sys.of_get_cntl_no()

// If ii days is 0, default to all. Else days
IF ii_days = 0 THEN
	dw_1.setItem( 1, "ai_type", ici_all)
ELSE
	// Auto-select Range and set default days
	dw_1.event itemchanged( 1, dw_1.Object.ai_type , string(ici_days) )
	dw_1.setItem( 1, "ai_type", ici_days)
END IF

DESTROY lnv_sys
end event

public function integer of_get_type ();int		li_value

li_value = dw_1.GetItemNumber(1, "ai_type")
RETURN li_value
end function

public function integer of_get_range (ref date ad_from, ref date ad_thru);// 08/16/05 MikeF	SPR4485d	Subset Date Range not picking up all dates in the Range
int				li_days, li_rc
date				ld_today

ld_today = date(gnv_sql.of_get_current_datetime())

CHOOSE CASE this.of_get_type()
		
	CASE ici_all
		ad_from = inv_date.of_getminimumdate()
		ad_thru = inv_date.of_getmaximumdate()
		
	CASE ici_days
		IF IsNull(dw_1.GetItemNumber(1, "ai_days")) &
		OR NOT IsNumber(String(dw_1.GetItemNumber(1, "ai_days"))) THEN
			MessageBox("Edit","Invalid number of days specified.~r~rPlease enter a valid number")
			dw_1.SetColumn( "ai_days" )
		ELSE
			li_days = dw_1.GetItemNumber(1, "ai_days")
		END IF
	
		ad_from = RelativeDate(ld_today, li_days * -1)
		ad_thru = RelativeDate(ld_today, 1)
		
	CASE ici_range
		
		IF this.of_validate_date( String( dw_1.GetItemDate( 1, "ad_from" ), "mm/dd/yyyy" )) < 0 THEN
			dw_1.SetColumn("ad_from")
			RETURN -1
		END IF
			
		IF this.of_validate_date( String( dw_1.GetItemDate( 1, "ad_thru" ), "mm/dd/yyyy" )) < 0 THEN
			dw_1.SetColumn("ad_thru")
			RETURN -1
		END IF
		
		ad_from = dw_1.GetItemDate (1, "ad_from")
		ad_thru = RelativeDate(dw_1.GetItemDate (1, "ad_thru"), 1)
		
END CHOOSE

RETURN this.of_get_type()
end function

public function integer of_validate_date (string as_date);string	ls_err
int		li_rc

li_rc = inv_date.of_IsValidDate (as_date) 

CHOOSE CASE	li_rc
		
	CASE	-1
		ls_err = 'Invalid date entered'
	CASE	-2
		ls_err = 'Date does not contain a 4 digit year'
	CASE	-3
		ls_err = 'The date must be between ' +	inv_date.of_GetMinimumStringDate() + &
					' and '	+	inv_date.of_GetMaximumStringDate()	
END CHOOSE

IF len(trim(as_date)) < 8 THEN
	ls_err 	= 'Please enter a valid date in MM/DD/YYYY format.'
	li_rc 	= -4
END IF

IF li_rc < 0 THEN
	MessageBox ('Date Error', ls_err)
END IF

RETURN li_rc
end function

on uo_date_range.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on uo_date_range.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within uo_date_range
string accessiblename = "Date Range Options"
string accessibledescription = "Date Range Options"
integer width = 923
integer height = 264
integer taborder = 10
string dataobject = "d_date_range"
boolean border = false
end type

event itemchanged;call super::itemchanged;/////////////////////////////////////////////////////////////////////////
//
//	05/26/06	GaryR	SPR 4752	Add spin control to enhance validation
//  05/28/09 RickB GNL.600.5633.006 - Changed constant variable lcl_white from hard-coded
//	white to Window Background.  Added AccessibileNames and AccessibleDescriptions
//  for each date option radio button.  Commented code that changed focus from radio button
//  to # of days and from date fields because acc properties were not being read.
//
/////////////////////////////////////////////////////////////////////////

constant long	lcl_buttonface = 67108864
constant long	lcl_white 		= 1073741824
constant long	lcl_black 		= 33554432

int		li_days
date		ld_date, as_date

SetNull(li_days)
SetNull(ld_date)

IF dwo.name = "ai_type" THEN 

	CHOOSE CASE data
			
		CASE "1"
			this.Object.ai_days.TabSequence = 0
			this.Object.ai_days.Background.Color = lcl_buttonface
			this.Object.ai_days.Color = lcl_buttonface
			this.Object.ad_from.TabSequence = 0
			this.Object.ad_from.Background.Color = lcl_buttonface
			this.Object.ad_thru.TabSequence = 0
			this.Object.ad_thru.Background.Color = lcl_buttonface
			this.Object.ai_type.AccessibleName = "All Dates radio button"
			this.Object.ai_type.AccessibleDescription = "All Dates radio button"
			
		CASE "2"
			this.Object.ai_days.TabSequence = 30
			this.Object.ai_days.Background.Color = lcl_white
			this.Object.ai_days.Color = lcl_black
			this.Object.ad_from.TabSequence = 0
			this.Object.ad_from.Background.Color = lcl_buttonface
			this.Object.ad_thru.TabSequence = 0
			this.Object.ad_thru.Background.Color = lcl_buttonface
			// Commented line below because accessibility properties are not being
			//     read for the radio button when focus is moved to the # of days field.
			//this.SetColumn("ai_days")
			this.Object.ai_type.AccessibleName = "Number of Days radio button"
			this.Object.ai_type.AccessibleDescription = "Number of Days radio button"
			li_days = ii_days
			
		CASE "3"
			this.Object.ai_days.TabSequence = 0
			this.Object.ai_days.Background.Color = lcl_buttonface
			this.Object.ai_days.Color = lcl_buttonface
			this.Object.ad_from.TabSequence = 40
			this.Object.ad_from.Background.Color = lcl_white
			this.Object.ad_thru.TabSequence = 50
			this.Object.ad_thru.Background.Color = lcl_white
			// Commented line below because accessibility properties are not being
			//     read for the radio button when focus is moved to the from date field.
			//this.SetColumn("ad_from")
			this.Object.ai_type.AccessibleName = "Date Range radio button"
			this.Object.ai_type.AccessibleDescription = "Date Range radio button"
	END CHOOSE
	
	this.Setitem( 1, "ai_days", li_days)
	this.Setitem( 1, "ad_from", ld_date)
	this.Setitem( 1, "ad_thru", ld_date)
	
END IF
end event

event constructor;call super::constructor;// 08/04/05 MikeFl SPR4473d Default to Range rather than ALL

THIS.of_SetUpdateable( FALSE )
THIS.of_SetDropDownCalendar( TRUE )
THIS.iuo_calendar.of_Register( "ad_from", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_Register( "ad_thru", this.iuo_calendar.NONE )
THIS.iuo_calendar.of_SetDateFormat( "mm/dd/yyyy" )

this.SetTransObject( Stars2ca )
this.InsertRow( 0 )
end event

event itemerror;call super::itemerror;// 05/15/09 RickB GNL.600.5633.001 - Bypassing DW validation message.

Return 2
end event

