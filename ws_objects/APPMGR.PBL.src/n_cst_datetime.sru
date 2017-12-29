$PBExportHeader$n_cst_datetime.sru
$PBExportComments$PFC Date and/or Datetime service class (autoinstatiated) (inherited from n_base) <logic>
forward
global type n_cst_datetime from n_base
end type
end forward

global type n_cst_datetime from n_base autoinstantiate
end type

type variables
Protected:
// To support other languages, this array could be changed
// in the constructor event.
String 	is_month[12] = { &
	"January", "February", "March", "April", &
	 "May",  "June", "July", "August",  "September", &
	"October",  "November", "December" }

// Minimum & maximum dates to handle SmallDateTime
// columns.
DateTime		idt_minimum
DateTime		idt_maximum

// NVO used to get the default range and date
u_nvo_sys_cntl	inv_sys_cntl

end variables

forward prototypes
public function date of_gregorian (long al_julian)
public function long of_days (long al_seconds)
public function long of_hours (long al_seconds)
public function long of_yearsafter (date ad_start, date ad_end)
public function long of_weeksafter (date ad_start, date ad_end)
public function long of_millisecsafter (time atm_start, time atm_end)
public function integer of_wait (datetime adtm_target)
public function integer of_wait (unsignedlong al_seconds)
public function boolean of_isvalid (datetime adtm_source)
public function date of_firstdayofmonth (date ad_source)
public function boolean of_isleapyear (date ad_source)
public function boolean of_isweekday (date ad_source)
public function boolean of_isweekend (date ad_source)
public function long of_julian (date ad_source)
public function long of_juliandaynumber (date ad_source)
public function date of_lastdayofmonth (date ad_source)
public function datetime of_relativedatetime (datetime adtm_start, long al_offset)
public function long of_secondsafter (datetime adtm_start, datetime adtm_end)
public function date of_relativemonth (date ad_source, long al_month)
public function date of_relativeyear (date ad_source, long al_years)
public function long of_weeknumber (date ad_source)
public function long of_monthsafter (date ad_start, date ad_end)
public function string of_monthname (integer ai_monthnumber)
public function string of_monthname (date ad_source)
public function boolean of_isvalid (time atm_source)
public subroutine of_setminimumdatetime (string as_date)
public subroutine of_setmaximumdatetime (string as_date)
public function datetime of_getminimumdatetime ()
public function datetime of_getmaximumdatetime ()
public function date of_getminimumdate ()
public function date of_getmaximumdate ()
public function datetime of_getfromdatetime (date ad_start, long al_range)
public function datetime of_getfromdatetime (ref string as_startdate, ref string as_range)
public function string of_getminimumstringdate ()
public function string of_getmaximumstringdate ()
public function boolean of_isvalidpcdate ()
public function date of_getnextmonth (date ad_source)
public function boolean of_isvalid (date ad_source)
public function integer of_isvaliddate (string as_date)
public function integer of_dayofweek (date ad_source)
public function integer of_editstringdates (string as_date)
public function date of_getpriormonth (date ad_source)
end prototypes

public function date of_gregorian (long al_julian);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Gregorian
//
//	Access:  		public
//
//	Arguments:
//	al_julian 		Julian date
//
//	Returns:  		date
//						Converted from julian.
//						If al_julian is NULL, function returns NULL.
//
//	Description:	Converts a julian date to gregorian date.
//						Note: Julian zero day is Jan. 1, year 0000.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(al_julian) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

long ll_numqc
long ll_numq
long ll_numc
long ll_cent = 36524
long ll_quad = 1461
int li_year, li_month, li_day
int li_DaysInMonth[12] = {31,28,31,30,31,30,31,31,30,31,30,31}

ll_numqc = al_julian / 146097 // 4 centuries
li_year = int(ll_Numqc) * 400
al_julian -= (146097 * ll_numqc)

ll_numc = 0
If al_julian > (ll_cent + 1) Then
	al_julian -= (ll_cent + 1)
	li_year += 100
	ll_numc = al_julian / ll_cent
	li_year += int(ll_numc) * 100
	al_julian -= ll_numc * ll_cent
	ll_numc ++
End If

If (ll_numc > 0) and (al_julian > (ll_quad - 1)) Then
	al_julian -= (ll_quad - 1)
	li_year += 4
End If

ll_numq = al_julian / ll_quad
li_year += int(ll_numq) * 4
al_julian -= ll_numq* ll_quad

If (of_IsLeapYear(Date(li_year, 1, 1))) Then
	If al_julian >= 366 Then
		al_julian -=366
		li_year ++
	elseif (al_julian = 59) Then
		li_month = 2
		li_day = 29
		Return Date(li_year,li_month,li_day)
	elseif (al_julian > 59) Then
		al_julian --
	end if
end if

Do While al_julian >= 365
	al_julian -=365
	li_year ++
loop

li_month = 0

Do While (li_DaysinMonth[li_month+1] <= al_julian)
	al_julian -= li_DaysinMonth[li_month+1]
	li_month++
Loop

li_month ++
li_day = al_julian + 1

Return Date(li_year,li_month,li_day)

end function

public function long of_days (long al_seconds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Days
//
//	Access:  		public
//
//	Arguments:
//	al_seconds 		Number of seconds to convert to days.
//
//	Returns:  		long 
//						Number of whole days.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Given the number of seconds, function will return the equivalient
//       			number of whole days
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_result

//Check parameters
If IsNull(al_seconds) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

If al_seconds < 0 Then
	Return -1
End If

//converts to hours and divide by 24
ll_result = (al_seconds / 3600) / 24

Return ll_result
end function

public function long of_hours (long al_seconds);//////////////////////////////////////////////////////////////////////////////
//
//	Function: 		of_Hours
//
//	Access:  		public
//
//	Arguments:
//	al_seconds		Number of seconds to be converted.
//
//	Returns:  		long
//						Number of whole hours eqivalent to the seconds passed.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:	Given a number of seconds, will return the equivalent
//						number of whole hours.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_result

//Check parameters
If IsNull(al_seconds) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

If al_seconds < 0 Then
	Return -1
End If

//converts to hours (divide by 3600)
ll_result = al_seconds / 3600

Return ll_result
end function

public function long of_yearsafter (date ad_start, date ad_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_YearsAfter
//
//	Access:  		public
//
//	Arguments:
//	ad_start			Starting date.
//	ad_end			Ending date.
//
//	Returns:  		Long
//						Number of years difference.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:	Given two dates will determine the number of whole 
//						years between the two dates.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

date ld_temp
int li_year, li_mult
double adb_start, adb_end

//Check paramemters
If IsNull(ad_start) or IsNull(ad_end) or &
	Not of_IsValid(ad_start) or Not of_IsValid(ad_end) Then
	long ll_null
	SetNull (ll_null)
	Return ll_null
End If

If ad_start > ad_end Then
	ld_temp = ad_start
	ad_start = ad_end
	ad_end = ld_temp
	li_mult = -1
else
	li_mult = 1
End If

li_year = year(ad_end) - year(ad_start)

adb_start = month(ad_start)
adb_start = adb_start + day(ad_start) / 100

adb_end = month(ad_end)
adb_end = adb_end + day(ad_end) / 100

If adb_start > adb_end Then
	li_year --
End If

Return li_year * li_mult

end function

public function long of_weeksafter (date ad_start, date ad_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function: 		of_WeeksAfter
//
//	Access:  		public
//
//	Arguments:
//	ad_start 		Starting date.
//	ad_end			Ending date.
//
//	Returns:  		Long
//						Number of whole weeks between the two dates.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:  	Given two dates, will determine the number of whole
//						weeks between the two.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_start) or IsNull(ad_end) or & 
	Not of_IsValid(ad_start) or Not of_IsValid(ad_end) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

Return Daysafter(ad_start,ad_end) /7
end function

public function long of_millisecsafter (time atm_start, time atm_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_MillisecsAfter
//
//	Access: 			public
//
//	Arguments:
//	atm_start 		The first time.
//	atm_end   		The second time.
//
//	Returns:  		long
//						The number of milliseconds between the two times.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Given two times will return the number of milliseconds
//						between the two. If the second time is less than the
//						first, the result will be negative.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

Long ll_start, ll_end
Long ll_temp

//Check parameters
If IsNull(atm_start) or IsNull(atm_end) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

ll_start = Long (String (atm_start,"fff"))
ll_temp = Second(atm_start) * 1000
ll_start = ll_start + ll_temp
ll_temp = Minute(atm_start) * 60000
ll_start = ll_start + ll_temp
ll_temp = hour(atm_start) *  3600000
ll_start = ll_start + ll_temp

ll_end = Long (String (atm_end,"fff"))
ll_temp = Second(atm_end) * 1000
ll_end = ll_end + ll_temp
ll_temp = minute(atm_end) * 60000
ll_end = ll_end + ll_temp
ll_temp = hour(atm_end) * 3600000
ll_end = ll_end + ll_temp

return ll_end - ll_start
end function

public function integer of_wait (datetime adtm_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Wait
//
//	Access:  		public
//
//	Arguments:
//	adtm_Target 	Target DateTime.
//
//	Returns:  		integer
//						1 if function waited the expected time.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Given a datetime, will wait until datetime is reached.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

date 	ldt_value

//Check parameters
If IsNull(adtm_Target) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//There is only need to test the Date portion of the DateTime.
ldt_value = Date(adtm_Target)

//Check for invalid date
If Not of_IsValid(ldt_value) Then
	Return -1
End If

//Wait until Target datetime
DO UNTIL DateTime(Today(),Now()) >= adtm_Target
	Yield() //Yields control to other graphic objects, including objects that are not PB.
LOOP

Return 1

end function

public function integer of_wait (unsignedlong al_seconds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Wait
//
//	Access:  		public
//
//	Arguments:
//	al_seconds 		Wait this many Seconds.
//
//	Returns:  		integer
//						1 if function waited the expected time.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Given a datetime, will wait until datetime is reached.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

datetime ldtm_target
integer	li_ret

//Check parameters
If IsNull(al_seconds) Then
	Return al_seconds
End If

//Check invalid parameters
If al_seconds <= 0 Then
	Return -1
End If

//Get the Target DateTime
ldtm_target = of_RelativeDatetime(DateTime(Today(),Now()), al_seconds)

//Perform the actual wait.
li_ret = of_Wait(ldtm_target)

Return li_ret

end function

public function boolean of_isvalid (datetime adtm_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValid
//
//	Access:  		public
//
//	Arguments:
//	adtm_source		DateTime to test.
//
//	Returns:  		boolean
//						True if argument is a valid datetime.
//						If any argument's value is NULL, function returns False.
//						If any argument's value is Invalid, function returns False.
//
//	Description:  	Given a datetime, will determine if the Datetime is valid.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

date 	ldt_value

//Check parameters
If IsNull(adtm_source) Then
	Return False
End If

//There is only need to test the Date portion of the DateTime.
//Can't tell if time is invalid because 12am is 00:00:00:000000
ldt_value = Date(adtm_source)

//Check for invalid date
If Not of_IsValid(ldt_value) Then
	Return False
End If

Return True

end function

public function date of_firstdayofmonth (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_FirstDayOfMonth
//
//	Access:  		public
//
//	Arguments:
//	date	ad_source		Date to test.
//
//	Returns:  		date
//						The first date of the month passed.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function 
//						returns 1900-01-01.
//
//	Description:  	Given a date, will determine the first day of the month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ad_source
End If

// Date (Year, Month, Day)
Return Date (Year(ad_source), Month(ad_source), 1)

end function

public function boolean of_isleapyear (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsLeapYear
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date which contains the year to be tested.
//
//	Returns:  		boolean
//						TRUE if year is a leap year.
//						FALSE if year is not a leap year.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:  	Based on the year in the passed date, determine if it is a 
//						leap year.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

int li_year
boolean lb_null
SetNull(lb_null)

//Check parameters
If IsNUll(ad_source) Then
	Return lb_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return lb_null
End If

//Get the year using the string function instead of Year()
li_year = integer(string(ad_source,'yyyy'))

If ( (Mod(li_year,4) = 0 And Mod(li_year,100) <> 0) Or (Mod(li_year,400) = 0) ) Then
	Return True
End If

Return False


end function

public function boolean of_isweekday (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsWeekday
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date to test.
//
//	Returns:			boolean
//						True if the date is a weekday.
//						False if the date is not a weekday.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:  Given a date, will determine if the date is a weekday.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) or Not of_IsValid(ad_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If (DayNumber(ad_source) > 1) and (DayNumber(ad_source) < 7) Then
	Return True
End If

Return False

end function

public function boolean of_isweekend (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsWeekend
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date to test.
//
//	Returns:  		boolean
//						True if the date is a weekend.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:  	Given a date, will determine if the date is a weekend.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) or Not of_IsValid(ad_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

Return Not of_IsWeekday(ad_source)
end function

public function long of_julian (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Julian	
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date to be converted
//
//	Returns:  		long 
//						Date as a julian
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Converts a date to Julian format.
//						Note: Julian zero day is Jan. 1, year 0000.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return -1
End If

Return DaysAfter(Date(0000,01,01),ad_source)

end function

public function long of_juliandaynumber (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_JulianDayNumber
//
//	Access:  		public
//
//	Arguments:
//	ad_source 		Date to test
//
//	Returns:  		long
//						Number of the day (ex. 1/1/95=1 and 12/31/95=365)
//						If ad_source is NULL, function returns NULL.
//
//	Description:  	Given a date, will determine the day number within the same
//						year.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) Then
	long ll_null
	SetNull (ll_null)
	Return ll_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return -1
End If

// Get the days after the last day of the Previous Year.
Return daysafter(Date((Year(ad_source) - 1),12,31), ad_source)
end function

public function date of_lastdayofmonth (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LastDayOfMonth
//
//	Access:  		public
//
//	Arguments:
//	ad_source 		Date to test.
//
//	Returns:  		date
//						The last date of the month passed.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a date, will determine the last day of the month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

integer li_year, li_month, li_day

//Check parameters
If IsNull(ad_source) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ad_source
End If

li_year = Year(ad_source)
li_month = Month(ad_source)
li_day = 31

//Check for a valid day (i.e., February 30th is never a valid date)
Do While Not of_IsValid(Date(li_year, li_month, li_day)) &
		and li_day > 0
	li_day --
Loop

Return (Date(li_year, li_month, li_day))

end function

public function datetime of_relativedatetime (datetime adtm_start, long al_offset);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RelativeDatetime
//
//	Access:  		public
//
//	Arguments:
//	adtm_start 		Starting datetime point of calculation.
//	al_offset     	Number of seconds before/after datetime to be returned.
//
//	Returns:		 	Datetime
//						Relative datetime.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a datetime, find the relative datetime +/- n seconds
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

datetime ldt_null
date ld_sdate
time lt_stime
long ll_date_adjust
long ll_time_adjust, ll_time_test

//Check parameters
If IsNull(adtm_start) or IsNull(al_offset) Then
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(adtm_start) Then
	Return ldt_null
End If

//Initialize date and time portion
ld_sdate = date(adtm_start)
lt_stime = time(adtm_start)

//Find out how many days are contained
//Note: 86400 is # of seconds in a day
ll_date_adjust = al_offset /  86400
ll_time_adjust = mod(al_offset, 86400)

//Adjust date portion
ld_sdate = RelativeDate(ld_sdate, ll_date_adjust)

//Adjust time portion
//	Allow for time adjustments periods crossing over days
//	Check for time rolling forwards a day
If ll_time_adjust > 0 then
	ll_time_test = SecondsAfter(lt_stime,time('23:59:59'))
	If ll_time_test < ll_time_adjust Then
		ld_sdate = RelativeDate(ld_sdate,1)
		ll_time_adjust = ll_time_adjust - ll_time_test -1
		lt_stime = time('00:00:00')
	End If
	lt_stime = RelativeTime(lt_stime, ll_time_adjust)
//Check for time rolling backwards a day
ElseIf  ll_time_adjust < 0 then
	ll_time_test = SecondsAfter(lt_stime,time('00:00:00'))
	If   ll_time_test > ll_time_adjust Then
		ld_sdate = RelativeDate(ld_sdate,-1)
		ll_time_adjust = ll_time_adjust - ll_time_test +1
		lt_stime = time('23:59:59')
	End If
	lt_stime = RelativeTime(lt_stime, ll_time_adjust)
End If

return(datetime(ld_sdate,lt_stime))
end function

public function long of_secondsafter (datetime adtm_start, datetime adtm_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SecondsAfter
//
//	Access:  		public
//
//	Arguments:
//	adtm_start 		Beginning time.
//	adtm_end   		Ending time.
//
//	Returns:  		long
//						Number of whole seconds between two date times.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:  	Given two datetimes, return the number of seconds between 
//						the two.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_total_seconds, ll_day_adjust
date ld_sdate, ld_edate
time lt_stime, lt_etime

//Check parameters
If IsNull(adtm_start) or IsNull(adtm_end) or &
	Not of_IsValid(adtm_start) or Not of_IsValid(adtm_end) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

ld_sdate = date(adtm_start)
ld_edate = date(adtm_end)

lt_stime = time(adtm_start)
lt_etime = time(adtm_end)

//Note: 86400 is number of seconds in a day.
If ld_sdate = ld_edate then 
	ll_total_seconds = secondsafter(	lt_stime,lt_etime)
Elseif ld_sdate < ld_edate Then
	ll_total_seconds = SecondsAfter(lt_stime,Time('23:59:59'))
	ll_day_adjust = DaysAfter(ld_sdate,ld_edate) -1
	If ll_day_adjust > 0 Then ll_total_seconds = ll_total_seconds + 86400 * ll_day_adjust
	ll_total_seconds = ll_total_seconds + SecondsAfter(Time('00:00:00'),lt_etime) +1
Else //end date < start date
	ll_total_seconds = SecondsAfter(lt_stime,Time('00:00:00'))
	ll_day_adjust = DaysAfter(ld_sdate,ld_edate) +1
	If ll_day_adjust < 0 Then ll_total_seconds = ll_total_seconds + 86400 * ll_day_adjust
	ll_total_seconds = ll_total_seconds + SecondsAfter(Time('23:59:59'),lt_etime) -1
end If

return ll_total_seconds

end function

public function date of_relativemonth (date ad_source, long al_month);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RelativeMonth
//
//	Access:			Public
//
//	Arguments:
//	ad_source		Base date (starting poing).
//	al_month	 		Number of months to increment or decrement the base date by.
//
//	Returns:  		date 
//						The adjusted date.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a date, will return the date +/- the number of months passed
//						in the second parameter.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

integer li_adjust_months, li_adjust_years
integer li_month, li_year, li_day
integer li_temp_month

//Check parameters
If IsNull(ad_source) or IsNull(al_month) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ad_source
End If
	
//Number 12 is for the Twelve months in a year.
li_adjust_months = mod(al_month, 12)
li_adjust_years = (al_month / 12)

li_temp_month = Month(ad_source) + li_adjust_months
If li_temp_month > 12 Then
	// Add one more year and adjust for the month
	li_month = li_temp_month - 12
	li_adjust_years ++
ElseIf li_temp_month <= 0 Then
	// Subtract one more year and adjust for the month
	li_month = li_temp_month + 12
	li_adjust_years --
Else
	// No need for any adjustments
	li_month = li_temp_month
End If

li_year = Year(ad_source) + li_adjust_years
li_day = Day(ad_source)

//Check for a valid day (i.e., February 30th is never a valid date)
Do While Not of_IsValid(Date(li_year, li_month, li_day)) &
		and li_day > 0
	li_day --
Loop

Return( Date(li_year, li_month, li_day))

end function

public function date of_relativeyear (date ad_source, long al_years);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RelativeYear
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Bbase date (starting point).
//	al_years			Number of years to increment or decrement the base date by.
//
//	Returns:  		date
//						The adjusted date
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a date, will return the date +/- the number of years passed
//						in the second parameter.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

integer li_year, li_month, li_day

//Check parameters
If IsNull(ad_source) or IsNull(al_years) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ad_source
End If

li_year = Year(ad_source) + al_years
li_month = Month(ad_source)
li_day = Day(ad_source)

//Check for a valid day (i.e., February 30th is never a valid date)
Do While Not of_IsValid(Date(li_year, li_month, li_day)) &
		and li_day > 0
	li_day --
Loop

Return( Date(li_year, li_month, li_day))

end function

public function long of_weeknumber (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_WeekNumber
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date to be determined.
//
//	Returns:  		long 
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Obtains the week number that corresponds to the date from 
//						the begining of the year.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

date		ld_first_ofyear
integer	li_weeknumber
integer	li_leftover_days

//Check parameters
If IsNull(ad_source) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return -1
End If

//Set to the first of the same year. 
ld_first_ofyear = Date(Year(ad_source), 01, 01)

//Get the number of weeks passed from the begining of the year.
li_weeknumber = of_WeeksAfter (ld_first_ofyear, ad_source) + 1 

//Get the leftover days.
li_leftover_days = Mod(DaysAfter (ld_first_ofyear, ad_source), 7)

//If needed, increment the weeks count by one.
If (of_DayOfWeek(ld_first_ofyear) + li_leftover_days) >= 8 then
	li_weeknumber ++
End If

Return li_weeknumber


end function

public function long of_monthsafter (date ad_start, date ad_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_MonthsAfter
//
//	Access:  		public
//
//	Arguments:
//	ad_start			Starting date.
//	ad_end			Ending date.
//
//	Returns:  		Long
//						Number of whole months between the two dates.
//						If the end date is prior the start date, function returns
//						a negative number of months.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:	Given two dates, returns the number of whole months 
// 					between the two.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

date 		ld_temp
integer 	li_month
integer	li_mult

//Check parameters
If IsNull(ad_start) or IsNull(ad_end) or &
	Not of_IsValid(ad_start) or Not of_IsValid(ad_end) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

If ad_start > ad_end Then
	ld_temp = ad_start
	ad_start = ad_end
	ad_end = ld_temp
	li_mult = -1
else
	li_mult = 1
End If

li_month = (year(ad_end) - year(ad_start) ) * 12
li_month = li_month + month(ad_end) - month(ad_start)

If day(ad_start) > day(ad_end) Then 
	li_month --
End If

Return li_month * li_mult
end function

public function string of_monthname (integer ai_monthnumber);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_MonthName
//
//	Access:  		public
//
//	Arguments:
//	ai_monthnumber		Based on the the passed month number, determines the Month name.
//
//	Returns:  		string
//		the month.
//
//	Description:  	
//		Based on the the passed date, determines the Month name.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////


//Check parameters
If IsNull(ai_monthnumber) or ai_monthnumber<0 or ai_monthnumber>12 Then
	Return '!'
End If

return is_month[ai_monthnumber]

end function

public function string of_monthname (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_MonthName
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date for which the Month name is desired
//
//	Returns:  		string
// 	The month.
//
//	Description:  	
//		Based on the the passed date, determines the Month name.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) Then
	Return '!'
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return '!'
End If

Return of_MonthName( Month(ad_source) )

end function

public function boolean of_isvalid (time atm_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValid
//
//	Access:  		public
//
//	Arguments:
//	adtm_source		DateTime to test.
//
//	Returns:  		boolean
//						True if argument is a valid time.
//						If any argument's value is NULL, function returns False.
//						If any argument's value is Invalid, function returns False.
//
//	Description:  	Given a time, will determine if the time is valid.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

integer 	li_hour
integer	li_minute
integer	li_second

// Initialize test values.
li_hour = Hour(atm_source)
li_minute = Minute(atm_source)
li_second = Second(atm_source)

// Check for nulls.
If IsNull(atm_source) Or IsNull(li_hour) or IsNull(li_minute) or IsNull(li_second) Then
	Return False
End If

// Check for invalid values.
If li_hour < 0 or li_minute < 0 or li_second < 0 Then
	Return False
End If

// Passed all testing.
Return True

end function

public subroutine of_setminimumdatetime (string as_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetMinimumDateTime
//
//	Access:  		public
//
//	Arguments:
//	as_date			String date.
//
//	Returns:  		N/A
//
//	Description:  	This function converts a string to a datetime and sets
//						the minimum date.  This date is to handle ShortDateTime columns.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

Date		ld_date

// Edit input
IF	IsNull (as_date)			&
OR	Trim (as_date)	=	''		THEN
	as_date	=	'01/02/1900'		// Default the date
END IF

IF	Not IsDate (as_date)		THEN
	Return
END IF

ld_date		=	Date (as_date)
idt_minimum	=	DateTime (ld_date)

end subroutine

public subroutine of_setmaximumdatetime (string as_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetMaximumDateTime
//
//	Access:  		public
//
//	Arguments:
//	as_date			String date.
//
//	Returns:  		N/A
//
//	Description:  	This function converts a string to a datetime and sets
//						the maximum date.  This date is to handle ShortDateTime columns.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

Date		ld_date

// Edit input
IF	IsNull (as_date)			&
OR	Trim (as_date)	=	''		THEN
	as_date	=	'06/06/2079'		// Default the date
END IF

IF	Not IsDate (as_date)		THEN
	Return
END IF

ld_date		=	Date (as_date)
idt_maximum	=	DateTime ( ld_date, Time('23:59:29') )

end subroutine

public function datetime of_getminimumdatetime ();Return	idt_minimum

end function

public function datetime of_getmaximumdatetime ();Return	idt_maximum

end function

public function date of_getminimumdate ();// Get the minimum datetime and convert it to a date.

DateTime	ldt_minimum
Date		ld_minimum

ldt_minimum		=	This.of_GetMinimumDateTime()
ld_minimum		=	Date (ldt_minimum)

Return	ld_minimum
end function

public function date of_getmaximumdate ();// Get the maximum datetime and convert it to a date.

DateTime	ldt_maximum
Date		ld_maximum

ldt_maximum		=	This.of_GetMaximumDateTime()
ld_maximum		=	Date (ldt_maximum)

Return	ld_maximum

end function

public function datetime of_getfromdatetime (date ad_start, long al_range);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetFromDateTime
//
//	Arguments:		ad_start 		Starting date.
//						al_range			Date range.
//
//	Returns:  		DateTime
//
//	Description:  	This function will return a date based on the input date
//						and offset.  Each window that uses a date range uses it to
//						get the from date.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

// Edit the input

IF	IsNull (ad_start)		THEN
	ad_start		=	gnv_app.of_get_server_date()
END IF

IF	IsNull (al_range)		THEN
	al_range	=	inv_sys_cntl.of_get_cntl_no()
END IF

// If the range is positive, make it negative.

IF	al_range		>	0		THEN
	al_range		=	al_range	*	-1
END IF

// Compute the new relative date.

Date		ld_date
DateTime	ldt_datetime,			&
			ldt_minimum,			&
			ldt_maximum
			
ld_date			=	RelativeDate (ad_start, al_range)
ldt_datetime	=	DateTime (ld_date)

// If the relative date < the minimum date, set the relative date
//	to the minimum date.

ldt_minimum		=	This.of_GetMinimumDateTime()
ldt_maximum		=	This.of_GetMaximumDateTime()

IF	ldt_datetime	<	ldt_minimum			THEN
	ldt_datetime	=	ldt_minimum
END IF

// If the relative date > the maximum date, set the relative date
//	to the minimum date.

IF	ldt_datetime	>	ldt_maximum			THEN
	ldt_datetime	=	ldt_maximum
END IF

Return	ldt_datetime

end function

public function datetime of_getfromdatetime (ref string as_startdate, ref string as_range);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetFromDateTime (Overloaded)
//
//	Arguments:		as_startdate (by reference) - String date
//						as_range (by reference) - String range
//
//	Returns:  		DateTime
//
//	Description:  	This function will return a date based on the input date
//						and offset.  Each window that uses a date range uses it to
//						get the from date.
//
//	Note:				The parms are passed by reference and can change values.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

Date		ld_date
Long		ll_range

// Edit the input

IF	IsNull (as_startdate)			&
OR	Trim (as_startdate)	=	''		THEN
	as_startdate	=	inv_sys_cntl.of_get_default_date()
END IF

ld_date		=	Date (as_startdate)

IF	IsNull (as_range)				&
OR	Trim (as_range)	=	''		THEN
	ll_range	=	inv_sys_cntl.of_get_cntl_no()
	as_range	=	String (ll_range)
ELSE
	ll_range	=	Long (as_range)
END IF

Return	This.of_GetFromDateTime (ld_date, ll_range)

end function

public function string of_getminimumstringdate ();// Get the minimum date and return as a string

Date		ldt_date
String	ls_date

ldt_date	=	This.of_GetMinimumDate()

ls_date	=	String (ldt_date, 'm/d/yyyy')

Return	ls_date

end function

public function string of_getmaximumstringdate ();// Get the maximum date and return as a string

Date		ldt_date
String	ls_date

ldt_date	=	This.of_GetMaximumDate()

ls_date	=	String (ldt_date, 'm/d/yyyy')

Return	ls_date

end function

public function boolean of_isvalidpcdate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValidPCDate
//
//	Arguments:		None
//
//	Returns:  		Boolean
//						TRUE	=	PC Date is valid
//						FALSE	=	PC Date is not valid
//
//	Description:  	This function will compare the PC's current datetime to
//						the server's current datetime to see if there is a
//						discrepancy.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

DateTime		ldt_server,				&
				ldt_pc
				
n_ds			lds_allw_secs

Integer		li_rc

Long			ll_seconds,				&
				ll_max_difference,	&
				ll_row

// Get the PC and Server DateTime
ldt_server	=	gnv_app.of_get_server_date_time()
ldt_pc		=	DateTime ( Today(), Now() )

//	Get the maximum difference (in seconds) from sys_cntl
lds_allw_secs	=	CREATE	n_ds
lds_allw_secs.DataObject	=	'd_sys_cntl_cntl_id'
lds_allw_secs.SetTransObject (STARS2CA)

ll_row	=	lds_allw_secs.Retrieve ('DIFFSECOND')

IF	ll_row	<	1		THEN
	MessageBox ('Migration Error', 'No row exists in sys_cntl to get the maximum difference '	+	&
					'(DIFFSECOND) between the PCs date and the servers date.  '		+	&
					'Script: n_cst_datetime.of_IsValidPCDate().')
	Return	FALSE
END IF

ll_max_difference	=	lds_allw_secs.object.cntl_no [ll_row]

ll_seconds			=	This.of_SecondsAfter (ldt_server, ldt_pc)

DESTROY	lds_allw_secs

IF	Abs (ll_seconds)	>	Abs (ll_max_difference)		THEN
	li_rc	=	MessageBox ("WARNING", "There is a discrepancy between the server date/time "	+	&
								" and your PC's date/time.  Server date/time = "						+	&
								String (ldt_server,'mm/dd/yyyy hh:mm')	+	".  PC date/time = "								+	&
								String (ldt_pc,'mm/dd/yyyy hh:mm')		+	".  Do you wish to change the PC date "	+	&
								"before continuing?", Question!, YesNo!, 2)
	IF	li_rc	=	1		THEN
		Return	FALSE
	ELSE
		MessageBox ("WARNING", "Since you choose not to modify the PC date/time, the date "	+	&
						"displayed on your reports may not be accurate.")
		Return	TRUE
	END IF
ELSE
	Return	TRUE
END IF




end function

public function date of_getnextmonth (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetNextMonth
//
//	Access:  		public
//
//	Arguments:
//	ad_source 		Date to test.
//
//	Returns:  		date
//						The month after passed month.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a date, will return date with the following month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//	12-09-99	NLG	Created.
//
//////////////////////////////////////////////////////////////////////////////

integer li_year, li_month, li_day

//Check parameters
If IsNull(ad_source) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ad_source
End If

li_year = Year(ad_source)
li_month = Month(ad_source)
li_day	= Day(ad_source)

if li_month = 12 then 
	li_month = 1
	li_year++
else
	li_month++
end if

//Check for a valid day (i.e., February 30th is never a valid date)
//The only reason date would be invalid is if it's the end of month and 
//following month has more days than original month passed into function
Do While Not of_IsValid(Date(li_year, li_month, li_day)) &
		and li_day > 0
	li_day --
Loop

Return (Date(li_year, li_month, li_day))

end function

public function boolean of_isvalid (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValid
//
//	Access:  		public
//
//	Arguments:
//	ad_source 			Date to test.
//
//	Returns:  		boolean
//						True if argument contains a valid date.
//						If any argument's value is NULL, function returns False.
//						If any argument's value is Invalid, function returns False.
//
//	Description:  	Given a date, will determine if the Date is valid.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	FDG	1/11/99	Track 2047c.  Do not allow a date < 1900 and > 2079 to 
//						handle a column that is declared ShortDateTime
//
//////////////////////////////////////////////////////////////////////////////

Integer 	li_year
Integer	li_month
Integer	li_day

Date		ld_minimum,		&
			ld_maximum


// Initialize test values.
li_year = Year(ad_source)
li_month = Month(ad_source)
li_day = Day(ad_source)

// Check for nulls.
If IsNull(ad_source) Or IsNull(li_year) or IsNull(li_month) or IsNull(li_day) Then
	Return False
End If

// Check for invalid values.
If	li_year <= 0 or li_month <= 0 or li_day <= 0 Then
	Return False
End If

// Date must be between 1/2/1900 and 6/6/2079

ld_minimum	=	This.of_GetMinimumDate()
ld_maximum	=	This.of_GetMaximumDate()

IF	ad_source	<	ld_minimum		&
OR	ad_source	>	ld_maximum		THEN
	Return False
END IF

// Passed all testing.
Return True

end function

public function integer of_isvaliddate (string as_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValidDate
//
//	Arguments:		as_date 			Date to test.
//
//	Returns:  		Integer
//						1	Valid Date
//						0	No Date passed
//						-1	Invalid date
//						-2	Not a 4-digit year
//						-3	Not between 1/1/1900 & 6/6/2079
//
//	Description:  	Given a date, will determine if the Date is valid.
//
//////////////////////////////////////////////////////////////////////////////
//
//	04/17/01	GaryR	SD2329 - Invalid dates accepted
//	05/14/03	GaryR	Track 3546d	Validate that the format is (mm/dd/yyyy)
//
//////////////////////////////////////////////////////////////////////////////

Integer 	li_year
Integer 	li_month
Integer 	li_day
Integer	li_pos

String	ls_year

Date		ld_date

DateTime	ldt_datetime,		&
			ldt_minimum,		&
			ldt_maximum

IF	IsNull (as_date)		&
OR	Trim (as_date)		<	' '	THEN
	// No date passed
	Return	0
END IF

//	04/17/01	GaryR	SD2329
IF	NOT	IsDate (as_date)		OR	&
Pos( as_date, "//" ) > 0		OR	&
Pos( as_date, "--" ) > 0		THEN
	// Invalid format for a date
	Return	-1
END IF

//	Validate the format (mm/dd/yyyy)
li_pos = Pos( as_date, "/" )
IF li_pos > 0 THEN
	IF Pos( as_date, "/", li_pos + 1 ) = 0 THEN Return -1
ELSE
	Return -1
END IF

//	Edit for 4-digit year
ls_year	=	Right (as_date, 4)

IF	NOT	IsNumber (ls_year)	THEN
	// Not a 4-digit year
	Return	-2
END IF

// Because dates can be of type SmallDateTime, the date must be
//	between 1/1/1900 and 6/6/2079

ld_date			=	Date (as_date)
ldt_datetime	=	DateTime (ld_date)

ldt_minimum		=	This.of_GetMinimumDateTime()
ldt_maximum		=	This.of_GetMaximumDateTime()

IF	ldt_datetime	<	ldt_minimum		&
OR	ldt_datetime	>	ldt_maximum		THEN
	Return	-3
END IF

// Passed all testing.
Return	1


end function

public function integer of_dayofweek (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_DayOfWeek
//
//	Access:  		public
//
//	Arguments:
//	ad_source		Date which contains the day to be determined.
//
//	Returns:  		integer
//						1 - If the Day is Sunday.
//						2 - If the Day is Monday
//						3 - If the Day is Tuesday.
//						4 - If the Day is Wednesday.
//						5 - If the Day is Thursday.
//						6 - If the Day is Friday.
//						7 - If the Day is Saturday.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Based on the the passed date, determines the day of the week.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ad_source) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return -1
End If

return DayNumber (ad_source)

end function

public function integer of_editstringdates (string as_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_EditStringDates
//
//	Arguments:		as_date (by reference).  Examples of the following formats:
//						07/01/1999
//						7/1/99 (invalid)
//						03/01/1999,03/31/1999
//						03/01/99,04/01/99 (invalid)
//						03/01/1999,03/31/1999,03/12/1999,03/15/1999
//						02/01/99,03/01/99,04/01/99,05/01/99 (invalid)
//
//	Returns:  		Integer
//						1 = success.
//						< 0 if a problem was found.
//
//	Description:  	This function takes a string as input (which can contain one
//						or more dates) and makes sure that each date is valid.
//
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	11/15/01	Stars 5.0 (track 2520d).	Created.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_string		lnv_string			// Autoinstantiated

Boolean	lb_done

Integer	li_rc

Date		ldt_date

String	ls_date,				&
			ls_temp_date,		&
			ls_prev_date

ls_date	=	Trim (as_date)
as_date	=	""

DO WHILE lb_done	=	FALSE
	IF	Trim (ls_date)	=	""	THEN
		lb_done	=	TRUE
		Exit
	END IF
	// Get each date (separated by a comma) and edit the date
	ls_temp_date	=	Trim (lnv_string.of_GetToken (ls_date, ',') )
	li_rc				=	This.of_IsValidDate (ls_temp_date)
	IF	li_rc			<	0		THEN
		// Error occured.  Get out.
		lb_done		=	TRUE
		Return	li_rc
	END IF
LOOP

Return	1

end function

public function date of_getpriormonth (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetNextMonth
//
//	Access:  		public
//
//	Arguments:
//	ad_source 		Date to test.
//
//	Returns:  		date
//						The month after passed month.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a date, will return date with the following month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//	10/28/04	MikeF	Created.
//
//////////////////////////////////////////////////////////////////////////////

integer li_year, li_month, li_day

//Check parameters
If IsNull(ad_source) Then
	date ldt_null
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ad_source
End If

li_year = Year(ad_source)
li_month = Month(ad_source)
li_day	= Day(ad_source)

if li_month = 1 then 
	li_month = 12
	li_year = li_year - 1
else
	li_month = li_month -1
end if

//Check for a valid day (i.e., February 30th is never a valid date)
//The only reason date would be invalid is if it's the end of month and 
//following month has more days than original month passed into function
Do While Not of_IsValid(Date(li_year, li_month, li_day)) &
		and li_day > 0
	li_day --
Loop

Return (Date(li_year, li_month, li_day))

end function

on n_cst_datetime.create
call super::create
end on

on n_cst_datetime.destroy
call super::destroy
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Script:  		Constructor
//
//	Description:  	Perform all initialization here.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

// Set the minimum and maximum dates (to handle smalldatetime columns)

This.of_SetMinimumDateTime ('01/02/1900')
This.of_SetMaximumDateTime ('06/06/2079')

// This NVO is used to get the default range and date.
// NOTE:	In PB 5.0, there used to be a bug regarding autoinstantiation.  
//			Powersoft claims that this has been fixed in PB 6.0.  
//			If GPFs occur while testing regarding u_nvo_sys_cntl, then the 
//			functionality in this object may need to be duplicated here.  

inv_sys_cntl	=	CREATE	u_nvo_sys_cntl
inv_sys_cntl.of_set_cntl_id ('RANGE')
end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Script:  		Destructor
//
//	Description:  	Destroy any previously created objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//
//////////////////////////////////////////////////////////////////////////////

IF IsValid (inv_sys_cntl)		THEN
	DESTROY	inv_sys_cntl
END IF

end event

