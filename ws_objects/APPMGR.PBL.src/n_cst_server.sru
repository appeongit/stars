$PBExportHeader$n_cst_server.sru
$PBExportComments$Wrapper NVO for the Stars Server (gole_server) <logic>
forward
global type n_cst_server from n_base
end type
end forward

global type n_cst_server from n_base
end type
global n_cst_server n_cst_server

type variables
// Datastore to retrieve claims_cntl
n_ds		ids_range

// From and to dates based on period key
Protected	DateTime	idtm_period_from,		&
							idtm_period_to

OLEObject	iole_claims
OLEObject	iole_base

// Track 2678d - List of created temporary tables.  When this object is
//	destroyed, Drop all tables in this array.
Protected	String	is_temp_table[]


end variables

forward prototypes
public function integer of_get_period_dates (long al_period_key)
public function boolean of_aredatesinrange (string as_inv_type, string as_operand, string as_paid_date, long al_period_key)
public function boolean of_isclientadmin ()
public function long of_jobcancel (long al_job_id)
public function long of_jobcreate (ref long al_job_id)
public function long of_jobdelete (long al_job_id)
public function long of_jobreset (long al_job_id)
public function long of_jobsubmit (long al_job_id, string as_job_desc, integer ai_priority, integer ai_sched_rule, datetime adtm_first_date)
public function long of_changepassword (string as_currentpassword, string as_newpassword)
public function long of_jobupdatedesc (long al_job_id, string as_job_desc)
public function n_cst_clientinfo_attrib of_getclientinfo ()
public function boolean of_aredatesinrange (string as_inv_type, string as_operand, string as_paid_date)
public function long of_preventtimeout ()
public subroutine of_issessiondead (string as_msg)
public subroutine of_isserverdown (string as_msg)
public function string of_GetFilterTableName (string as_filterId)
public function integer of_getclaimstablenames (ref n_cst_tableinfo_attrib anv_table)
public function integer of_createfiltertable (string as_filterid, string as_invtype, string as_colname, ref string as_table_name)
public function long of_createfiltertable (string as_filterid, string as_datatype, ref string as_table_name)
public function long of_checkstatus (long al_rc, string as_msg)
public function long of_droptemptable (string as_table)
public function integer of_drop_temptables ()
public function long of_createkeytable (long al_job_id, string as_inv_type, ref string as_table)
public function long of_createtemptable (ref n_cst_temp_table_attrib anv_temp)
public function long of_createicntable (long al_job_id, string as_inv_type, ref string as_table)
public function integer of_addtemptable (string as_table)
public function boolean of_aredatesinrange (string as_inv_type, datetime adtm_from_date, datetime adtm_to_date)
public function integer of_getloadedrange (string as_inv_type, string as_add_inv_type, ref datetime adtm_from_date, ref datetime adtm_to_date)
public subroutine of_ismessagenull (string as_msg)
public function long of_getidleminutes ()
public function long of_updatefilterstats (string as_filterid)
end prototypes

public function integer of_get_period_dates (long al_period_key);//************************************************************
//	Script:	of_get_period_dates
//
//	Arguments:	1.	al_period_key
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will period_cntl to get the from and to
//			dates.
//************************************************************
//
//	FDG	03/09/01	Stars 4.7.  Created.
//
//************************************************************


SELECT payment_from_date,
		 payment_thru_date
  INTO :idtm_period_from,
		 :idtm_period_to
  FROM period_cntl
 WHERE period_key = :al_period_key
 USING Stars2ca;

IF Stars2ca.of_check_status() <	0	 THEN
	Stars2ca.of_rollback()
	MessageBox('Error', 'Error selecting paid dates from period_cntl in n_cst_server.of_get_period_dates')
	Return	-1
ELSE
	Stars2ca.of_commit()
END IF

Return	1


end function

public function boolean of_aredatesinrange (string as_inv_type, string as_operand, string as_paid_date, long al_period_key);//************************************************************
//	Script:	of_AreDatesInRange - Overloaded function
//
//	Arguments:	1.	as_inv_type
//					2.	as_operand
//					3.	as_paid_date
//					4. al_period_key
//
//	Returns:		Boolean
//					TRUE	=	Dates are within the range
//					FALSE	=	Dates not in range
//
//	Description:
//			This function will read claims_cntl to determine
//			if the input dates are within the range of dates.  If
//			the period key exists and dates don't exist, then get
//			the from and to date from period_cntl.
//************************************************************
//
//	FDG	03/09/01	Stars 4.7.  Created.
//	GaryR	05/29/01	Stars 4.7	Rename table CLAIMS_RANGE_CNTL to CLAIMS_CNTL
//
//************************************************************

Boolean	lb_in_range

Integer	li_rc

// Edit the input

IF	 al_period_key	>	0							&
AND Len ( Trim(as_paid_date) )	=	0		THEN
	// Use period_key to get the from and to dates
	li_rc	=	This.of_get_period_dates (al_period_key)
	IF	li_rc	<	0		THEN
		Return	FALSE
	END IF
	lb_in_range	=	This.of_AreDatesInRange (as_inv_type, idtm_period_from, idtm_period_to)
ELSE
	lb_in_range	=	This.of_AreDatesInRange (as_inv_type, as_operand, as_paid_date)
END IF
		
Return	lb_in_range

end function

public function boolean of_isclientadmin ();//************************************************************
//	Script:		of_IsClientAdmin
//
//	Arguments:	None
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.IsClientAdmin to determine
//			if the User ID is an Admin.
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc,		&
			ll_admin

String	ls_msg

ll_rc		=	gole_server.IsClientAdmin (REF ll_admin)

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling IsClientAdmin in n_cst_server.of_IsClientAdmin.  ' + &
//					ls_msg	+	'.')
//	Return	FALSE
//END IF

ls_msg	=	'Error calling IsClientAdmin in n_cst_server.of_IsClientAdmin.'
IF	of_CheckStatus( ll_rc, ls_msg ) 	<	0		THEN	Return	FALSE
//	GaryR	06/29/01	Stars	4.7 - End

IF	ll_admin	>	0		THEN
	Return	TRUE
ELSE
	Return	FALSE
END IF


end function

public function long of_jobcancel (long al_job_id);//************************************************************
//	Script:	of_JobCancel
//
//	Arguments:	1.	al_job_id
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.JobCancel to cancel
//			a job on Stars Server. 
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc

String	ls_msg

ll_rc		=	gole_server.JobCancel (al_job_id)

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling JobCancel in n_cst_server.of_JobCancel.  ' + &
//					ls_msg	+	'.  job_id = '	+ String (al_job_id) + '.')
//END IF

ls_msg	=	'Error calling JobCancel in n_cst_server.of_JobCancel.  job_id = '	+ String (al_job_id)
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc


end function

public function long of_jobcreate (ref long al_job_id);//************************************************************
//	Script:	of_JobCreate
//
//	Arguments:	Long	(ref)	al_job_id
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.JobCreate to create
//			a job on Stars Server. 
//************************************************************
//
//	GaryR	03/22/01	Stars 4.7	Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc
String	ls_msg

ll_rc		=	gole_server.JobCreate( REF al_job_id )

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox( 'Application Error', 'Error calling JobCreate in n_cst_server.of_JobCreate.~n~r' + &
//					ls_msg	+	'.~n~rjob_id = '	+ String( al_job_id ) + '.')
//END IF

ls_msg	=	'Error calling JobCreate in n_cst_server.of_JobCreate.  job_id = '	+ String( al_job_id )
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc

end function

public function long of_jobdelete (long al_job_id);//************************************************************
//	Script:	of_JobDelete 
//
//	Arguments:	1.	al_job_id 
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.JobDelete to delete
//			a job on Stars Server. 
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc

String	ls_msg

ll_rc		=	gole_server.JobDelete (al_job_id)

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling JobDelete in n_cst_server.of_JobDelete.  ' + &
//					ls_msg	+	'.  job_id = '	+ String (al_job_id) + '.')
//END IF

ls_msg	=	'Error calling JobDelete in n_cst_server.of_JobDelete.  job_id = '	+ String (al_job_id)
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc


end function

public function long of_jobreset (long al_job_id);//************************************************************
//	Script:	of_JobReset 
//
//	Arguments:	1.	al_job_id 
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.JobReset to reset
//			a job on Stars Server. 
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc

String	ls_msg

ll_rc		=	gole_server.JobReset (al_job_id)

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling JobReset in n_cst_server.of_JobReset.  ' + &
//					ls_msg	+	'.  job_id = '	+ String (al_job_id) + '.')
//END IF

ls_msg	=	'Error calling JobReset in n_cst_server.of_JobReset.  job_id = '	+ String (al_job_id)
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc


end function

public function long of_jobsubmit (long al_job_id, string as_job_desc, integer ai_priority, integer ai_sched_rule, datetime adtm_first_date);//************************************************************
//	Script:		of_JobSubmit 
//
//	Arguments:	1.	al_job_id 
//					2. as_job_desc
//					3. ai_priority
//					4. ai_sched_rule
//					5. adtm_first_date
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.JobSubmit to submit
//			a job on Stars Server. 
//************************************************************
//
//	GaryR	03/23/01	Stars 4.7	Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc

String	ls_msg,				&
			ls_first_date

// Convert date to a string format.
ls_first_date	=	String (adtm_first_date, "YYYY-MM-DD HH:MM:SS")

ll_rc		=	gole_server.JobSubmit( al_job_id, as_job_desc, ai_priority, ai_sched_rule, ls_first_date )

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling JobSubmit in n_cst_server.of_JobSubmit.~n~r' + &
//					ls_msg	+	'.~n~rjob_id = '	+ String (al_job_id) + '. job_desc = '	+	as_job_desc	+	&
//									'. priority = '	+ String( ai_priority ) + '.  sched_rule = ' + &
//									String(ai_sched_rule) + '.  first_date = ' + ls_first_date + '.')
//END IF

ls_msg	=	'Error calling JobSubmit in n_cst_server.of_JobSubmit.~n~r' + &
				'job_id = '	+ String (al_job_id) + '  job_desc = '	+	as_job_desc	+	&
				'  priority = '	+ String( ai_priority ) + '  sched_rule = ' + &
				String(ai_sched_rule) + '  first_date = ' + ls_first_date
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc


end function

public function long of_changepassword (string as_currentpassword, string as_newpassword);//************************************************************
//	Script:	of_ChangePassword
//
//	Arguments:	1.	as_currentpassword
//					2.	as_newpassword
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.changepassword to change
//			the user's password on Stars Server.
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc

String	ls_msg

w_main.SetMicrohelp ('Changing password on STARS Server')

ll_rc		=	gole_server.ChangePassword (as_currentpassword, as_newpassword)

w_main.SetMicrohelp ('Ready')

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	// This is not necesarily an application programming error
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Error', 'Error changing password.  '	+	ls_msg)
//END IF

// This is not necesarily an application programming error
ls_msg	=	'Error changing password.'
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc

end function

public function long of_jobupdatedesc (long al_job_id, string as_job_desc);//************************************************************
//	Script:		of_JobUpdate
//
//	Arguments:	1.	al_job_id 
//					2. as_job_desc
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.JobUpdateDesc to update
//			a job on Stars Server. 
//************************************************************
//
//	GaryR	04/30/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc
String	ls_msg

ll_rc		=	gole_server.JobUpdateDesc( al_job_id, as_job_desc )

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling JobUpdateDesc in n_cst_server.of_JobUpdateDesc.~n~r' + &
//					ls_msg	+	'.~n~rjob_id = '	+ String (al_job_id) + '. job_desc = '	+	as_job_desc + '.')
//END IF

ls_msg	=	'Error calling JobUpdateDesc in n_cst_server.of_JobUpdateDesc.~n~r' + &
				'job_id = '	+ String (al_job_id) + '  job_desc = '	+	as_job_desc
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc
end function

public function n_cst_clientinfo_attrib of_getclientinfo ();//************************************************************
//	Script:	of_GetClientInfo
//
//	Arguments:	None
//
//	Returns:		n_cst_clientinfo_attrib
//
//	Description:
//			This function will call gole_server.GetClientInfo to get
//			the userid, password, schema name from Stars Server.
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//	GaryR	02/10/05	Track 4178d	Make COM backwards compatible
//
//************************************************************

Integer	li_rc

Long		ll_rc

String	ls_msg

n_cst_clientinfo_attrib		lnv_client		// Autoinstantiated

// PB can't pass structures to COM
OLEObject	lole

lole	=	CREATE	OLEObject
ll_rc		=	gole_server.GetClientInfo (REF lole)

ls_msg	=	'Error calling gole_server.GetClientInfo.'
IF	of_CheckStatus( ll_rc, ls_msg )	<	0		THEN	GoTo	Clean_up
//	GaryR	06/29/01	Stars	4.7 - End

lnv_client.is_userid				=	lole.GetUserName()
lnv_client.is_password			=	lole.GetPassword()
lnv_client.is_schema_name		=	lole.GetSchema()
lnv_client.il_days_to_expire	=	lole.DaysToExpire()
lnv_client.il_idle_minutes		=  This.of_getidleminutes()
lnv_client.ib_is_client_admin	=	This.of_isclientadmin()

Clean_up:

IF	IsValid (lole)		THEN
	lole.DisconnectObject()
	Destroy	lole
END IF

Return	lnv_client

end function

public function boolean of_aredatesinrange (string as_inv_type, string as_operand, string as_paid_date);//************************************************************
//	Script:	of_AreDatesInRange
//
//	Arguments:	1.	as_inv_type
//					2.	as_operand
//					3.	as_paid_date
//
//	Returns:		Boolean
//					TRUE	=	Dates are within the range
//					FALSE	=	Dates not in range
//
//	Description:
//			This function will read claims_cntl to determine
//			if the input dates are within the range of dates.
//************************************************************
//
//	FDG	03/06/01	Stars 4.7.  Created.
//
//************************************************************

Integer	li_pos,						&
			li_pos2,						&
			li_pos3

Long		ll_row,						&
			ll_rowcount

Date		ldt_default

DateTime	ldtm_from_date,			&
			ldtm_to_date,				&
			ldtm_from_date2,			&
			ldtm_to_date2,				&
			ldtm_default,				&
			ldtm_date[]

String	ls_date,						&
			ls_find

// Edit the input

ldt_default	=	Date('1/1/1900')

CHOOSE CASE	Upper (as_operand)
	CASE	'>', '<', '<>', '=', '>=', '<='
		li_pos3	=	Pos (as_paid_date, ',')
		IF	li_pos3	>	0		THEN
			MessageBox ('Error', 'Multiple dates cannot be entered with operator '	+	as_operand	+	'.')
			Return	False
		END IF
	CASE	'BETWEEN', '><'
		li_pos3	=	Pos (as_paid_date, ',')
		IF	li_pos3	=	0		THEN
			MessageBox ('Error', 'Multiple dates are required with operator '	+	as_operand	+	'.')
			Return	False
		END IF
END CHOOSE

ldtm_default	=	DateTime (Date('1/1/1900') )

CHOOSE CASE	Upper (as_operand)
	CASE	'>'
		// Add 1 day to the date for range purposes
		ldtm_from_date	=	DateTime ( RelativeDate (Date(as_paid_date), 1 ) )
		ldtm_to_date	=	ldtm_default
	CASE	'<'
		// Subtract 1 day to the date for range purposes
		ldtm_to_date	=	DateTime ( RelativeDate (Date(as_paid_date), -1 ) )
		ldtm_from_date	=	ldtm_default
	CASE	'>=', '=', '<>'
		ldtm_from_date	=	DateTime ( Date(as_paid_date) )
		ldtm_to_date	=	ldtm_default
	CASE	'<='
		ldtm_to_date	=	DateTime ( Date(as_paid_date) )
		ldtm_from_date	=	ldtm_default
	CASE	'BETWEEN', '><'
		// Get the date to the left and the right of the comma
		li_pos			=	Pos (as_paid_date, ',')
		ls_date			=	Left (as_paid_date, li_pos - 1)
		ldtm_from_date	=	DateTime ( Date(ls_date) )
		ls_date			=	Mid  (as_paid_date, li_pos + 1)
		ldtm_to_date	=	DateTime ( Date(ls_date) )
	CASE	'IN', 'NOT IN'
		// Can possibly be more than two dates.  As a result, each date must be placed
		//	in an external source d/w and sorted.  Then the min and max dates entered are
		//	passed to the overloaded function.
		n_ds		lds_date
		lds_date	=	CREATE	n_ds
		lds_date.DataObject	=	'd_date_external'
		li_pos			=	Pos (as_paid_date, ',')
		li_pos2			=	1
		IF	li_pos		=	0		THEN
			ldtm_from_date	=	DateTime ( Date(as_paid_date) )
			ldtm_to_date	=	ldtm_default
		ELSE
			DO WHILE	li_pos	>	0
				// Place each date into lds_date
				ls_date	=	Mid (as_paid_date, 1, li_pos - li_pos2)
				ll_row	=	lds_date.InsertRow (0)
				lds_date.object.date [ll_row]	=	DateTime ( Date(ls_date) )
				li_pos2	=	li_pos	+	1
				li_pos	=	Pos (as_paid_date, ',', li_pos2)
			LOOP
			// Place the last date into lds_date, sort lds_date, then get the 1st
			//	and last dates in lds_date
			ls_date	=	Mid (as_paid_date, li_pos2)
			ll_row	=	lds_date.InsertRow (0)
			lds_date.object.date [ll_row]	=	DateTime ( Date(ls_date) )
			// Sort lds_date
			lds_date.SetSort ("date A")
			lds_date.Sort()
			ldtm_from_date	=	lds_date.object.date [1]
			ldtm_to_date	=	lds_date.object.date [ll_row]
		END IF
END CHOOSE

Return	This.of_AreDatesInRange (as_inv_type, ldtm_from_date, ldtm_to_date)		

// FDG 11/03/01 - If track 2483 is being implemented, comment the Return statement
//	above and uncomment all code below.  If it is eventually decided that this
//	track will not be implemented, remove the code below.
////Return	This.of_AreDatesInRange (as_inv_type, ldtm_from_date, ldtm_to_date)
//IF	 Date (ldtm_from_date)	<>	ldt_default		&
//AND Date (ldtm_to_date)		<>	ldt_default	THEN
//	Return	This.of_AreDatesInRange (as_inv_type, ldtm_from_date, ldtm_to_date)
//END IF
//
//// If the invoice type passed is a FastTrack invoice type, then get the main
//// invoice type.
//IF	Upper (Left (as_inv_type, 1) )	=	'Q'		THEN
//	as_inv_type	=	fx_fasttrack_invoice_type (as_inv_type)
//END IF
//
//ll_rowcount	=	ids_range.RowCount()
//
//IF	ll_rowcount	<	1		THEN
//	// claims_cntl not previously read - read it.
//	ids_range.DataObject	=	'd_claims_cntl'
//	ids_range.SetTransObject(Stars1ca)			//	GaryR	06/07/01	Stars 4.7
//	ll_rowcount	=	ids_range.Retrieve()
//END IF
//
//ls_find	=	"inv_type = '"	+	as_inv_type	+	"'"
//
//ll_row	=	ids_range.Find (ls_find, 1, ll_rowcount)
//
//IF	ll_row	<	1		THEN
//	MessageBox ('Application Error', 'Cannot find row in n_cst_server.of_AreDatesInRange().  '	+	&
//					'inv_type = ' + as_inv_type + '.  from_date = ' + String (ldtm_from_date, 'mm/dd/yyyy') + &
//					'.  to_date = ' + String (ldtm_to_date, 'mm/dd/yyyy') + '.')
//	Return	FALSE
//END IF
//
//ldtm_from_date2	=	ids_range.object.from_date [ll_row]
//ldtm_to_date2		=	ids_range.object.to_date [ll_row]
//
//IF	 Date (ldtm_from_date)	=	ldt_default		&
//AND Date (ldtm_to_date)		=	ldt_default		THEN
//	// No dates entered
//	Return	FALSE
//END IF
//
//IF	Date (ldtm_from_date)	=	ldt_default		THEN
//	// No from_date - edit against to_date only
//	IF	 Date (ldtm_to_date)			>=	Date (ldtm_from_date2)	&
//	AND Date (ldtm_to_date)			<=	Date (ldtm_to_date2)		THEN
//		Return	TRUE
//	ELSE
//		IF	Date (ldtm_to_date)		>=	Date (ldtm_to_date2)		THEN
//			CHOOSE CASE	as_operand
//				CASE	'<', '<='
//					Return	TRUE
//				CASE	ELSE
//					Return	FALSE
//			END CHOOSE
//		END IF
//	END IF
//END IF
//
//IF	Date (ldtm_to_date)	=	ldt_default		THEN
//	// No to_date - edit against from_date only
//	IF	 Date (ldtm_from_date)		>=	Date (ldtm_from_date2)	&
//	AND Date (ldtm_from_date)		<=	Date (ldtm_to_date2)		THEN
//		Return	TRUE
//	ELSE
//		IF	Date (ldtm_from_date)		<=	Date (ldtm_from_date2)		THEN
//			CHOOSE CASE	as_operand
//				CASE	'>', '>='
//					Return	TRUE
//				CASE	ELSE
//					Return	FALSE
//			END CHOOSE
//		END IF
//	END IF
//END IF
//
//// Both dates were passed
//IF	 Date (ldtm_from_date)			>=	Date (ldtm_from_date2)		&
//AND Date (ldtm_to_date)				<=	Date (ldtm_to_date2)		THEN
//	Return	TRUE
//ELSE
//	Return	FALSE
//END IF
//
//
//// FDG 11/03/01 end

end function

public function long of_preventtimeout ();//************************************************************
//	Script:	of_PreventTimeOut
//
//	Arguments:	None
//
//	Returns:		Long
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call a Stars Server method in order to 
//			prevent a time out on Stars Server.  This function is
//			called from w_main.timer when checking for user messages.
//************************************************************
//
//	FDG	03/23/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//
//************************************************************

Long		ll_rc

String	ls_msg

ll_rc		=	gole_server.ResetExpiration ()

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling ResetExpiration in n_cst_server.of_PreventTimeOut.  ' + &
//					ls_msg	+	'.')
//END IF

ls_msg	=	'Error calling ResetExpiration in n_cst_server.of_PreventTimeOut.'
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc


end function

public subroutine of_issessiondead (string as_msg);//************************************************************
//	Script:	of_IsSessionDead
//
//	Arguments:	1.	as_msg = Error message from the server
//
//	Returns:		None
//
//	Description:
//			This function will decipher the error message returned
//			by the server to determine if the current session is valid.
//			If current session is not valid, notify user and exit out.
//************************************************************
//
//	GaryR	06/29/01	Stars 4.7.  Created.
//	FDG	11/12/01	Track 2539d.	Stars Server changed text of the message
//						to "Session xxx does not exist" where xxx is the user ID.
//
//************************************************************

IF  Match( Upper( as_msg ), "SESSION" ) 	&
AND Match( Upper( as_msg ), "DOES NOT EXIST" ) 	THEN
	MessageBox( "Session Error", "Current session was destroyed by another session" + &
											"~n~rSTARS will be shut down immediately", StopSign! )
	HALT
END IF

end subroutine

public subroutine of_isserverdown (string as_msg);//************************************************************
//	Script:	of_IsServerDown
//
//	Arguments:	1.	as_msg = Error message from the server
//
//	Returns:		None
//
//	Description:
//			This function will decipher the error message returned
//			by the server to determine if the StarsServer is operational.
//			If the StarsServer is not valid, notify user and exit out.
//************************************************************
//
//	GaryR	12/07/01	Track 2539d  Created.
//
//************************************************************

IF Match( Upper( as_msg ), "A CONNECTION WITH THE SERVER COULD NOT BE ESTABLISHED" ) 	THEN
	MessageBox( "Stars Server Error", as_msg + "~n~rSTARS will be shut down immediately", StopSign! )
	HALT
END IF

end subroutine

public function string of_GetFilterTableName (string as_filterId);//************************************************************
//	Script:	of_CreateFilterTable
//
//	Arguments:	1.	as_filterId
//					2.	as_tableName
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.GetFilterTableName to get
//			the name of a filter table on Stars Server, based on the filter id.
//************************************************************
//
//	LMC	12/24/01	Stars 4.7.  Created.
//
//************************************************************

Long		ll_rc

String	ls_msg
String	ls_tableName

w_main.SetMicrohelp ('Getting Filter Table Name on STARS Server')

ll_rc		=	gole_server.GetFilterTableName (as_filterId, REF ls_tableName)

w_main.SetMicrohelp ('Ready')

ls_msg	=	'Error calling GetFilterTableName in n_cst_server.of_GetFilterTableName.~n~r' + &
				'filterId = '	+ as_filterId
of_CheckStatus( ll_rc, ls_msg )

//Return	ll_rc
return ls_tableName

end function

public function integer of_getclaimstablenames (ref n_cst_tableinfo_attrib anv_table);//************************************************************
//	Script:		of_GetClaimsTableNames
//
//	Arguments:	n_cst_tableinfo_attrib (by reference)
//
//	Returns:		Integer
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.GetClaimsTableNames to get
//			the table names for the list of invoice types.  This will return
//			a list of base table names and whether or not the payment date can be excluded.
//
//	Note:	The interface between PB and COM does not handle string arrays.
//			String arrays are handled thru methods in the StarWars.StringList
//			COM object.  See the StringList programmable object in the OLE
//			tab of the Object Browser for more details. 
//
//************************************************************
//
//	FDG	03/02/01	Stars 4.7.  Created. 
//	GaryR	05/16/01	Stars 4.7	Map a dependent invoice type to the main.
//										This should only be done for O1 invoices.
//										The server has logic to map Q1-2 fast tracks.
//	GaryR	05/30/01	Stars 4.7	Added payment from and thru dates to ComClaimsInfo.
//										Use COM's Access methods to populate instance variables.
//	GaryR	06/29/01	Stars	4.7	Check if the current session is active.
//	GaryR	07/03/01	Stars	4.7	Check the validity of the OLE object.
//	GaryR	07/10/01	Track 2360D	Reset the filter of dw_rel_dict on w_main after processing.
//	FDG	11/06/01	Track 2520d Make sure 4-digit years are passed to Stars Server.
//
//************************************************************

Integer	li_rc

Long		ll_rc,			&
			ll_upper,		&
			ll_idx

String	ls_msg,				&
			ls_empty[],			&
			ls_table,			&
			ls_inv_type
			
String 	ls_fromDate, ls_TDate			//	GaryR	05/30/01	Stars 4.7
String	ls_filter, ls_old_filter		//	GaryR	05/16/01					//	GaryR	07/10/01	Track 2360D

Constant String	lcs_default = '1900-01-01'
	
w_main.SetMicrohelp ('Calling STARS Server to get the table names')
	
//f_debug_box ('Debug', 'Entering gnv_server.of_GetClaimsTableNames()')
//f_debug_box ('Debug', '  operator = '		+	anv_table.is_operand)
//f_debug_box ('Debug', '  date value = '	+	anv_table.is_paid_date)


// Initialize output in case it was previously filled in
anv_table.is_base_table					=	ls_empty
anv_table.ib_exclude_payment_date	=	FALSE
anv_table.il_rc							=	0
anv_table.is_message						=	''

//	GaryR	07/03/01	Stars	4.7
IF	NOT	IsValid (iole_claims)	OR	IsNull(iole_claims)	THEN
//	f_debug_box ('Debug', ' Calling iole_claims	=	CREATE	OLEObject')
	iole_claims	=	CREATE	OLEObject
//	f_debug_box ('Debug', ' Calling iole_claims.ConnectToNewObject ("StarWars.ComClaimsInfo")')
	li_rc	=	iole_claims.ConnectToNewObject ("StarWars.ComClaimsInfo")
//	f_debug_box ('Debug', '   Return code from iole_claims.ConnectToNewObject ("StarWars.ComClaimsInfo") = '	+	String(li_rc))
END IF

//	GaryR	07/10/01	Track 2360D
ls_old_filter = w_main.dw_stars_rel_dict.Object.DataWindow.Table.Filter
IF IsNull( ls_old_filter ) OR ls_old_filter = "?" THEN ls_old_filter = ""

//	GaryR	05/16/01 - Begin
w_main.dw_stars_rel_dict.SetFilter( "" )
w_main.dw_stars_rel_dict.Filter()
ls_filter =	"rel_type = 'DP' and id_2 = '"	+	anv_table.is_inv_type +	"'" &
				+ " and Trim( id_3 ) <> '' and id_3 <> '*' and NOT IsNull( id_3 )"
w_main.dw_stars_rel_dict.SetFilter( ls_filter )
w_main.dw_stars_rel_dict.Filter()
IF w_main.dw_stars_rel_dict.RowCount() > 0 THEN
	anv_table.is_inv_type = w_main.dw_stars_rel_dict.GetItemString( 1, "id_3" )
END IF

//	GaryR	07/10/01	Track 2360D
w_main.dw_stars_rel_dict.SetFilter( ls_old_filter )
w_main.dw_stars_rel_dict.Filter()
//	GaryR	05/16/01 - End

// If period_key is used and payment_date is not, get the from and to date
//	from period_cntl
IF	 Len ( Trim(anv_table.is_paid_date) )	=	0			&
AND anv_table.il_period_key					>	0			THEN
	// Get the from and to dates from period_cntl
	li_rc	=	This.of_get_period_dates (anv_table.il_period_key)
	IF	li_rc	<	0		THEN
		Return	li_rc
	END IF
	// Format these dates into a string
	anv_table.is_paid_date	=	String ( Date(idtm_period_from), 'mm/dd/yyyy' )	+	','	+	&
										String ( Date(idtm_period_to), 'mm/dd/yyyy' )
	IF	Len ( Trim(anv_table.is_operand) )	=	0		THEN
		anv_table.is_operand	=	'BETWEEN'
	END IF
//	f_debug_box ('Debug', '  operator = '		+	anv_table.is_operand)
//	f_debug_box ('Debug', '  date value = '	+	anv_table.is_paid_date)
END IF

// FDG 11/06/01 - Make sure that 4-digit years are passed to Stars Server
n_cst_string		lnv_string		// Autoinstantiated
li_rc		=	lnv_string.of_getyyyydates( anv_table.is_paid_date )

w_main.SetMicrohelp ('Receiving table names from STARS Server')

//f_debug_box ('Debug', '  Calling gole_server.GetClaimsTableNames ')

// Call the function returning iole_claims
ll_rc	=	gole_server.GetClaimsTableNames (anv_table.is_inv_type,		&
														anv_table.is_operand,		&
														anv_table.is_paid_date,		&
														REF iole_claims)

w_main.SetMicrohelp ('Ready')

//f_debug_box ('Debug', '  GetClaimsTableNames return code = '	+	String(ll_rc))

IF	ll_rc	<	0		THEN
	// Error occured
	anv_table.is_message	=	gole_server.GetLastError()
	of_IsSessionDead( anv_table.is_message )	//	GaryR	06/29/01	Stars	4.7
	anv_table.il_rc		=	ll_rc
//	f_debug_box ('Debug', '  GetClaimsTableNames error message = '	+	anv_table.is_message)
	GoTo Clean_up
END IF

//f_debug_box ('Debug', '  Calling iole_claims.IsExcludePaymentDate()')
ll_rc	=	iole_claims.IsExcludePaymentDate()
//f_debug_box ('Debug', '  Return code from iole_claims.IsExcludePaymentDate() = ' + String(ll_rc))
IF	ll_rc			>	0		THEN
	anv_table.ib_exclude_payment_date	=	TRUE
ELSEIF ll_rc	=	0		THEN
	anv_table.ib_exclude_payment_date	=	FALSE
ELSE
	// Error occured
	anv_table.is_message	=	iole_claims.GetLastError()
	anv_table.il_rc		=	ll_rc
	GoTo Clean_up
END IF

//	GaryR	05/30/01	Stars 4.7 - Begin
ls_fromDate	= iole_claims.GetFromDate()
ls_TDate		= iole_claims.GetTDate()

IF NOT IsDate( ls_fromDate ) OR NOT IsDate( ls_TDate ) THEN
	anv_table.is_message	=	"Dates returned by ComClaimsInfo are not valid"
	anv_table.il_rc		=	-1
	GoTo Clean_up
END IF

anv_table.idt_fromDate	= DateTime( Date( ls_fromDate ) )
anv_table.idt_TDate		= DateTime( Date( ls_TDate ) )
//	GaryR	05/30/01	Stars 4.7 - End

IF	NOT	IsValid (iole_base)		THEN
//	f_debug_box ('Debug', ' Calling iole_base	=	CREATE	OLEObject')
	iole_base	=	CREATE	OLEObject
//	f_debug_box ('Debug', ' Calling iole_base.ConnectToNewObject ("StarWars.StringList")')
	li_rc	=	iole_base.ConnectToNewObject ("StarWars.StringList")
//	f_debug_box ('Debug', '   Return code from iole_base.ConnectToNewObject ("StarWars.StringList") = '	+	String(li_rc))
END IF

// Get the string array of base tables and additional tables
//f_debug_box ('Debug', '  Calling iole_claims.GetBaseTableNames()')
iole_base	=	iole_claims.GetBaseTableNames()
//f_debug_box ('Debug', '  Calling iole_base.GetCount()')
ll_upper		=	iole_base.GetCount()
//f_debug_box ('Debug', '  iole_base(StringList).GetCount() = '	+	String(ll_upper))

FOR ll_idx	=	1	TO	ll_upper
	// Please note that the server indexes begin with 0 on the server.
	ls_table	=	''
//	f_debug_box ('Debug', '  Index for iole_base(StringList).Get() = '	+	String(ll_idx - 1))
	ll_rc	=	iole_base.Get (ll_idx - 1, REF ls_table )
//	f_debug_box ('Debug', '   Return code from iole_base(StringList).Get() = '	+	String(ll_rc))
	IF	ll_rc	<	0		THEN
		// Error occured
		anv_table.is_message	=	iole_base.GetLastError()
		anv_table.il_rc		=	ll_rc
		GoTo Clean_up
	END IF
	IF	Trim (ls_table)	>	' '		THEN
		anv_table.is_base_table [ll_idx]		=	ls_table
//		f_debug_box ('Debug', '  Base table[' + String(ll_idx) + '] = ' + anv_table.is_base_table [ll_idx])
	END IF
NEXT

IF	IsValid (iole_base)		THEN
//	f_debug_box ('Debug', ' Calling iole_base.DisconnectObject()')
	iole_base.DisconnectObject()
//	f_debug_box ('Debug', ' Calling Destroy iole_base')
	Destroy	iole_base
END IF

Clean_up:

// Destroy the objects
IF	IsValid (iole_base)		THEN
//	f_debug_box ('Debug', ' Calling iole_base.DisconnectObject()')
	iole_base.DisconnectObject()
//	f_debug_box ('Debug', ' Calling Destroy iole_base')
	Destroy	iole_base
END IF

IF	IsValid (iole_claims)		THEN
//	f_debug_box ('Debug', ' Calling iole_claims.DisconnectObject()')
	iole_claims.DisconnectObject()
//	f_debug_box ('Debug', ' Calling Destroy iole_claims')
	Destroy	iole_claims
END IF


//f_debug_box ('Debug', 'Leaving of_getclaimstablenames().')

Return	anv_table.il_rc

end function

public function integer of_createfiltertable (string as_filterid, string as_invtype, string as_colname, ref string as_table_name);//************************************************************
//	Script:	of_CreateFilterTable
//
//	Arguments:	1.	as_filterId
//					2.	as_invType
//					3. as_colName 
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.CreateFilterTable to create
//			a filter table on Stars Server.
//************************************************************
//
//	LMC	12/24/01	Stars 4.7.  Created.
//
//************************************************************

Long		ll_rc

String	ls_msg

w_main.SetMicrohelp ('Creating Filter Table on STARS Server')

ll_rc		=	gole_server.CreateFilterTable (as_filterId, as_invType, as_colName, REF as_table_name)

w_main.SetMicrohelp ('Ready')

ls_msg	=	'Error calling CreateFilterTable in n_cst_server.of_CreateFilterTable.~n~r' + &
				'filterId = '	+ as_filterId + '  inv_type = ' + as_invType + '  col_name = ' + as_colName
of_CheckStatus( ll_rc, ls_msg )

Return	ll_rc
end function

public function long of_createfiltertable (string as_filterid, string as_datatype, ref string as_table_name);//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.CreateFilterTable to create
//			a filter table on Stars Server when you do not know the column name.
//************************************************************
//
//	LMC	12/24/01	Stars 4.7.  Created.
//
//************************************************************

Long		ll_rc

String	ls_msg

w_main.SetMicrohelp ('Creating Filter Table on STARS Server')

ll_rc		=	gole_server.CreateImportFilterTable (as_filterId, as_dataType, REF as_table_name)

w_main.SetMicrohelp ('Ready')

ls_msg	=	'Error calling CreateFilterTable in n_cst_server.of_CreateFilterTable.~n~r' + &
				'filterId = '	+ as_filterId + '  dataType = ' + as_dataType 
of_CheckStatus( ll_rc, ls_msg )

Return	ll_rc
end function

public function long of_checkstatus (long al_rc, string as_msg);//************************************************************
//	Script:		of_CheckStatus
//
//	Arguments:	1:	Long		-	al_rc		=	Code returned by the server
//					2:	String	-	as_msg	=	Additional user error message
//
//	Returns:		Long - Code returned by the server
//
//	Description:
//			This function will handle any errors from the server.
//************************************************************
//
//	GaryR	06/29/01	Stars 4.7.  Created.
//	GaryR	12/07/01	Track 2539d	Determine if the StarsServer is operational
//	GaryR	04/09/03	Track 3461d	Check for null message
//
//************************************************************

String	ls_msg

IF	al_rc	<	0		THEN
	ls_msg	=	gole_server.GetLastError()
	of_IsServerDown( ls_msg )		//	GaryR	12/07/01	Track 2539d
	of_IsSessionDead( ls_msg )
	of_IsMessageNull( ls_msg )
	MessageBox( 'Stars Server Error', as_msg + "~n~r" + ls_msg )
END IF

RETURN al_rc
end function

public function long of_droptemptable (string as_table);//************************************************************
//	Script:	of_DropTempTable
//
//	Arguments:	1.	as_table - The table name to drop.
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.DropTempTable to drop
//			the temporary temp table on Stars Server based previously
//			created.
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
// FDG	01/14/02	Track 2678.  Can now be performed when the application closes.
//
//************************************************************

Long		ll_rc

String	ls_msg

//w_main.SetMicrohelp ('Dropping temp table '	+	as_table	+' on STARS Server')		// FDG 01/14/02

ll_rc		=	gole_server.DropTempTable (as_table)

//w_main.SetMicrohelp ('Ready')				// FDG 01/14/02

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling DropTempTable in n_cst_server.of_DropTempTable.  ' + &
//					ls_msg	+	'.  Table name = '	+ as_table)
//END IF

ls_msg	=	'Error calling DropTempTable in n_cst_server.of_DropTempTable.  Table name = '	+ as_table
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

Return	ll_rc


end function

public function integer of_drop_temptables ();//************************************************************
//	Script:	of_Drop_TempTables
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will get all tables stored in is_temp_table[],
//			determine if they still exist, and drop them.  This function
//			is called from the Application's close event when the user
//			gracefully exits from STARS.
//************************************************************
//
//	FDG	01/14/02	Stars 5.0.  Track 2678d.  Created.
//
//************************************************************

Integer	li_idx,		&
			li_upper,	&
			li_rc

Long		ll_rc

li_upper	=	UpperBound( is_temp_table )

FOR li_idx	=	1	TO	li_upper
	li_rc		=	gnv_sql.of_table_exists( is_temp_table[li_idx] )
	IF	li_rc	>	0		THEN
		// Table exists - drop it
		ll_rc	=	This.of_DropTempTable( is_temp_table[li_idx] )
	END IF
NEXT

COMMIT	Using Stars2ca ;

Return	1


end function

public function long of_createkeytable (long al_job_id, string as_inv_type, ref string as_table);//************************************************************
//	Script:	of_CreateKeyTable
//
//	Arguments:	1.	al_job_id
//					2.	as_inv_type
//					3. as_table - Temp table name returned
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.CreateKeyTable to create
//			a temporary temp table on Stars Server based on the unique key
//			of the invoice type.
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//	FDG	01/14/02	Stars 5.0.  Track 2678d.  Add temp table to is_temp_table[].
//	FDG	01/29/02	Track 2762d Undo change to track 2678d.
//
//************************************************************

Long		ll_rc

String	ls_msg

w_main.SetMicrohelp ('Creating Key Temp Table on STARS Server')

ll_rc		=	gole_server.CreateKeyTable (al_job_id, as_inv_type, REF as_table)

w_main.SetMicrohelp ('Ready')

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling CreateKeyTable in n_cst_server.of_CreateKeyTable.  ' + &
//					ls_msg	+	'.  job_id = '	+ String (al_job_id) + '.  inv_type = ' + as_inv_type)
//END IF

ls_msg	=	'Error calling CreateKeyTable in n_cst_server.of_CreateKeyTable.~n~r' + &
				'job_id = '	+ String (al_job_id) + '  inv_type = ' + as_inv_type
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

// FDG 01/14/02 - Add temp table to is_temp_table[].		// FDG 01/29/02
//IF	ll_rc	>=	0		THEN
//	This.of_AddTempTable( as_table )
//END IF
// FDG 01/14/02 - end

Return	ll_rc


end function

public function long of_createtemptable (ref n_cst_temp_table_attrib anv_temp);//************************************************************
//	Script:	of_CreateTempTable
//
//	Arguments:	1.	anv_temp (n_cst_temp_table_attrib)
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.CreateTempTable to create
//			a temporary temp table on Stars Server.
//
//************************************************************
//
//	FDG	03/20/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//	GaryR	09/24/01	Track 2418d	Handle additional data source
//										when creating Temp Tables
//	FDG	01/14/02	Stars 5.0.  Track 2678d.  Add temp table to is_temp_table[].
//
//************************************************************

Integer	li_rc,			&
			li_upper,		&
			li_idx

Long		ll_rc,			&
			ll_upper,		&
			ll_idx,			&
			ll_row,			&
			ll_rowcount,	&
			ll_add_rowcount	//	GaryR	09/24/01	Track 2418d

String	ls_msg,			&
			ls_find,			&
			ls_inv_type			//	GaryR	09/24/01	Track 2418d

n_ds		lds_dict,	&
			lds_add_dict		//	GaryR	09/24/01	Track 2418d

// Initialize output in case it was previously filled in

// PB can't pass structures or string arrays to COM
// The input columns must be inserted one at a time into the Stringlist COM object.

OLEObject	lole_index,	&
				lole_col_nbr

lole_index		=	CREATE	OLEObject
lole_col_nbr	=	CREATE	OLEObject

lds_dict			=	CREATE	n_ds
lds_add_dict	=	CREATE	n_ds	//	GaryR	09/24/01	Track 2418d

// Load the invoice types into the StringList OleObject

li_rc	=	lole_index.ConnectToNewObject ("StarWars.StringList")

//f_debug_box ('Debug', ' ')
//f_debug_box ('Debug', 'StarWars.StringList ConnectToNewObject return code = '	+	String(li_rc)	+	'.')

IF	li_rc	<	0		THEN
	MessageBox ('Application Error', 'StarWars.StringList ConnectToNewObject return code = '	+	&
					String(li_rc)	+	'.  Error in n_cst_server.of_createtemptable().')
	anv_temp.il_rc		=	li_rc
	GoTo Clean_up
END IF

li_rc	=	lole_col_nbr.ConnectToNewObject ("StarWars.ComIntList")
//f_debug_box ('Debug', 'StarWars.ComIntListList ConnectToNewObject return code = '	+	String(li_rc)	+	'.')

IF	li_rc	<	0		THEN
	anv_temp.is_message	=	'StarWars.ComIntList ConnectToNewObject return code = '	+	&
									String(li_rc)	+	'.  Error in n_cst_server.of_createtemptable().'
	MessageBox ('Application Error', anv_temp.is_message)
	anv_temp.il_rc		=	li_rc
	GoTo Clean_up
END IF

//f_debug_box ('Debug', 'Calling Stars Server CreateTempTable()')

li_upper		=	UpperBound (anv_temp.istr_cols)

IF	li_upper	<	1		THEN
	anv_temp.is_message	=	"Application error.  Cannot get the column names in "	+	&
									"n_cst_server.of_CreateTempTable() because no columns "	+	&
									"were sent to this function."
	MessageBox ('Application Error', anv_temp.is_message)
	anv_temp.il_rc		=	-2
	GoTo Clean_up
END IF


IF	IsNull (anv_temp.is_inv_type)			&
OR	Trim (anv_temp.is_inv_type)	=	''	THEN
	anv_temp.is_message	=	"Application error.  Cannot get the invoice type in "	+	&
									"n_cst_server.of_CreateTempTable()."
	MessageBox ('Application Error', anv_temp.is_message)
	anv_temp.il_rc		=	-3
	GoTo Clean_up
END IF

// Add the index names to lole_index
li_upper	=	UpperBound (anv_temp.istr_index_cols[1].is_index_col)

FOR	li_idx	=	1 TO li_upper
//	f_debug_box ('Debug', '  index[' +	String(li_idx)	+ '] = '	+ anv_temp.istr_index_cols[1].is_index_col[li_idx])
	lole_index.Add ( anv_temp.istr_index_cols[1].is_index_col[li_idx] )
NEXT

// Add the column numbers to lole_col_nbr
lds_dict.DataObject	=	'd_dictionary_tbl_type'
lds_dict.SetTransObject (Stars2ca)
ll_rowcount	=	lds_dict.Retrieve (anv_temp.is_inv_type)

IF	ll_rowcount	<	1		THEN
	anv_temp.is_message	=	'Could not retrieve dictionary rows in n_cst_server.of_CreateTempTable.  ' + &
									'function_name = '	+ anv_temp.is_function + &
									'.  inv_type = ' + anv_temp.is_inv_type
	MessageBox ('Application Error', anv_temp.is_message)
	anv_temp.il_rc		=	ll_rc
	GoTo Clean_up
END IF

//	GaryR	09/24/01	Track 2418d - Begin
ls_inv_type = anv_temp.is_inv_type

// Retrieve additional invoice type fields
IF Trim( anv_temp.is_add_inv_type ) <> "" THEN
	ls_inv_type += "+" + anv_temp.is_add_inv_type
	lds_add_dict.DataObject	=	'd_dictionary_tbl_type'
	lds_add_dict.SetTransObject (Stars2ca)
	ll_add_rowcount	=	lds_add_dict.Retrieve (anv_temp.is_add_inv_type)
	
	IF	ll_add_rowcount	<	1		THEN
		anv_temp.is_message	=	'Could not retrieve dictionary rows in n_cst_server.of_CreateTempTable.  ' + &
										'function_name = '	+ anv_temp.is_function + &
										'.  addtl_inv_type = ' + anv_temp.is_add_inv_type
		MessageBox ('Application Error', anv_temp.is_message)
		anv_temp.il_rc		=	ll_rc
		GoTo Clean_up
	END IF
END IF
//	GaryR	09/24/01	Track 2418d - End

li_upper		=	UpperBound (anv_temp.istr_cols)


FOR	li_idx	=	1 TO li_upper
//	f_debug_box ('Debug', '  column[' +	String(li_idx)	+ '] = '	+ anv_temp.istr_cols[li_idx].is_col_name)
	ls_find	=	Upper ("elem_name = '"	+	anv_temp.istr_cols[li_idx].is_col_name	+	"'")
	ll_row	=	lds_dict.Find (ls_find, 1, ll_rowcount)
	IF	ll_row	=	0		THEN
		//	GaryR	09/24/01	Track 2418d - Begin
		IF Trim( anv_temp.is_add_inv_type ) <> "" THEN
			ll_row	=	lds_add_dict.Find (ls_find, 1, ll_add_rowcount)
			IF	ll_row	=	0		THEN
				anv_temp.is_message	=	'Could not find dictionary row in n_cst_server.of_CreateTempTable.  ' + &
												'function_name = '	+ anv_temp.is_function + &
												'.  inv_type = ' + anv_temp.is_inv_type + &
												'.  inv_addtl_type = ' + anv_temp.is_add_inv_type + '.  find = ' + ls_find
				MessageBox ('Application Error', anv_temp.is_message)
				anv_temp.il_rc		=	ll_rc
				GoTo Clean_up
			ELSE
				anv_temp.istr_cols[li_idx].ii_col_number	=	-1 * lds_add_dict.object.elem_col_number [ll_row]
			END IF
		ELSE
			anv_temp.is_message	=	'Could not find dictionary row in n_cst_server.of_CreateTempTable.  ' + &
											'function_name = '	+ anv_temp.is_function + &
											'.  inv_type = ' + anv_temp.is_inv_type + '.  find = ' + ls_find
			MessageBox ('Application Error', anv_temp.is_message)
			anv_temp.il_rc		=	ll_rc
			GoTo Clean_up
		END IF
	ELSE
		anv_temp.istr_cols[li_idx].ii_col_number	=	lds_dict.object.elem_col_number [ll_row]
	END IF
	//	GaryR	09/24/01	Track 2418d - End
//	f_debug_box ('Debug', '  column_number[' +	String(li_idx)	+ '] = '	+ &
//					String(anv_temp.istr_cols[li_idx].ii_col_number) )
	lole_col_nbr.Add ( anv_temp.istr_cols[li_idx].ii_col_number )
NEXT

// Pass the column numbers and index column names to Stars Server

w_main.SetMicrohelp ('Creating Temp Table '	+	anv_temp.is_table_name	+	' on STARS Server')

//	GaryR	09/24/01	Track 2418d
ll_rc		=	gole_server.CreateTempTable ( anv_temp.is_table_name,		&
														ls_inv_type,					&
														lole_col_nbr,					&
														lole_index )

w_main.SetMicrohelp ('Ready')

anv_temp.il_rc		=	ll_rc

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	anv_temp.is_message	=	'Error calling CreateTempTable in n_cst_server.of_CreateTempTable.  ' + &
//									ls_msg	+	'.  function_name = '	+ anv_temp.is_function + &
//									'.  inv_type = ' + anv_temp.is_inv_type
//	MessageBox ('Application Error', anv_temp.is_message)
//	GoTo Clean_up
//END IF

ls_msg	=	'Error calling CreateTempTable in n_cst_server.of_CreateTempTable.~n~r' + &
				'function_name = '	+ anv_temp.is_function + '  inv_type = ' + anv_temp.is_inv_type
IF	of_CheckStatus( ll_rc, ls_msg )	<	0		THEN
	anv_temp.is_message	=	ls_msg
	GoTo Clean_up
END IF
//	GaryR	06/29/01	Stars	4.7 - End

// FDG 01/14/02 - Add temp table to is_temp_table[].
IF	ll_rc	>=	0		THEN
	This.of_AddTempTable( anv_temp.is_table_name )
END IF
// FDG 01/14/02 - end

Clean_up:

IF	IsValid (lole_index)		THEN
	lole_index.DisconnectObject()
	Destroy	lole_index
END IF

IF	IsValid (lole_col_nbr)		THEN
	lole_col_nbr.DisconnectObject()
	Destroy	lole_col_nbr
END IF

Destroy	lds_dict
Destroy	lds_add_dict	//	GaryR	09/24/01	Track 2418d

Return	anv_temp.il_rc



end function

public function long of_createicntable (long al_job_id, string as_inv_type, ref string as_table);//************************************************************
//	Script:	of_CreateICNTable
//
//	Arguments:	1.	al_job_id
//					2.	as_inv_type
//					3. as_table - Temp table name returned
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.CreateICNTable to create
//			a temporary ICN temp table on Stars Server.
//************************************************************
//
//	FDG	02/28/01	Stars 4.7.  Created.
//	GaryR	06/29/01	Stars	4.7	Perform error checking in one method
//	FDG	01/14/02	Stars 5.0.  Track 2678d.  Add temp table to is_temp_table[].
//	FDG	01/29/02	Track 2762d Undo change to track 2678d.
//
//************************************************************

Long		ll_rc

String	ls_msg

w_main.SetMicrohelp ('Creating ICN Temp Table on STARS Server')

ll_rc		=	gole_server.CreateICNTable (al_job_id, as_inv_type, REF as_table)

w_main.SetMicrohelp ('Ready')

//	GaryR	06/29/01	Stars	4.7 - Begin
//IF	ll_rc	<	0		THEN
//	ls_msg	=	gole_server.GetLastError()
//	MessageBox ('Application Error', 'Error calling CreateICNTable in n_cst_server.of_CreateICNTable.  ' + &
//					ls_msg	+	'.  job_id = '	+ String (al_job_id) + '.  inv_type = ' + as_inv_type)
//END IF

ls_msg	=	'Error calling CreateICNTable in n_cst_server.of_CreateICNTable.~n~r' + &
				'job_id = '	+ String (al_job_id) + '  inv_type = ' + as_inv_type
of_CheckStatus( ll_rc, ls_msg )
//	GaryR	06/29/01	Stars	4.7 - End

// FDG 01/14/02 - Add temp table to is_temp_table[].		// FDG 01/29/02
//IF	ll_rc	>=	0		THEN
//	This.of_AddTempTable( as_table )
//END IF
// FDG 01/14/02 - end

Return	ll_rc


end function

public function integer of_addtemptable (string as_table);//************************************************************
//	Script:	of_AddTempTable
//
//	Arguments:	String - Table name
//
//	Returns:		Integer
//					 1	=	Success
//					-1	=	Error
//
//	Description:
//			This function will add the created temp table into is_temp_table[].
//
//************************************************************
//
//	FDG	01/14/02	Stars 5.0.  Track 2678d.  Created.
//
//************************************************************

Integer	li_upper,	&
			li_rc

Long		ll_rc

IF	IsNull( as_table )				&
OR	Trim  ( as_table )	=	''		THEN
	Return	-1
END IF

li_upper	=	UpperBound( is_temp_table )
li_upper	++

is_temp_table [li_upper]	=	as_table

Return	1


end function

public function boolean of_aredatesinrange (string as_inv_type, datetime adtm_from_date, datetime adtm_to_date);//************************************************************
//	Script:	of_AreDatesInRange
//
//	Arguments:	1.	as_inv_type
//					2.	adtm_from_date
//					3.	adtm_to_date
//
//	Returns:		Boolean
//					TRUE	=	Dates are within the range
//					FALSE	=	Dates not in range
//
//	Description:
//			This function will read claims_cntl to determine
//			if the input dates are within the range of dates.
//************************************************************
//
//	FDG	03/06/01	Stars 4.7.  Created.
//	GaryR	05/29/01	Stars 4.7	Rename table CLAIMS_RANGE_CNTL to CLAIMS_CNTL
//	GaryR	06/07/01	Stars 4.7	Move CLAIMS_CNTL from Stars2 to Stars1
//	FDG	02/15/02	Track 2882c. Also check for 'O' for Fasttrack.
//
//************************************************************

Long		ll_row,				&
			ll_rowcount

Date		ldt_default

DateTime	ldtm_from_date,	&
			ldtm_to_date

String	ls_find

ldt_default	=	Date('1/1/1900')

// If the invoice type passed is a FastTrack invoice type, then get the main
// invoice type.
// FDG 02/15/02 - Also check for 'O'
IF	Upper (Left (as_inv_type, 1) )	=	'Q'		&
OR	Upper (Left (as_inv_type, 1) )	=	'O'		THEN
	as_inv_type	=	fx_fasttrack_invoice_type (as_inv_type)
END IF

ll_rowcount	=	ids_range.RowCount()

IF	ll_rowcount	<	1		THEN
	// claims_cntl not previously read - read it.
	ids_range.DataObject	=	'd_claims_cntl'
	ids_range.SetTransObject(Stars1ca)			//	GaryR	06/07/01	Stars 4.7
	ll_rowcount	=	ids_range.Retrieve()
END IF

ls_find	=	"inv_type = '"	+	as_inv_type	+	"'"

ll_row	=	ids_range.Find (ls_find, 1, ll_rowcount)

IF	ll_row	<	1		THEN
	MessageBox ('Application Error', 'Cannot find row in n_cst_server.of_AreDatesInRange().  '	+	&
					'inv_type = ' + as_inv_type + '.  from_date = ' + String (adtm_from_date, 'mm/dd/yyyy') + &
					'.  to_date = ' + String (adtm_to_date, 'mm/dd/yyyy') + '.')
	Return	FALSE
END IF

ldtm_from_date	=	ids_range.object.from_date [ll_row]
ldtm_to_date	=	ids_range.object.to_date [ll_row]

IF	Date (adtm_from_date)	=	ldt_default		THEN
	// No from_date - edit against to_date only
	IF	 Date (adtm_to_date)	<>	ldt_default		&
	AND Date (adtm_to_date)	<=	Date (ldtm_to_date)	THEN
		Return	TRUE
	ELSE
		Return	FALSE
	END IF
END IF

IF	Date (adtm_to_date)	=	ldt_default		THEN
	// No to_date - edit against from_date only
	IF	 Date (adtm_from_date)	<>	ldt_default		&
	AND Date (adtm_from_date)	>=	Date (ldtm_from_date)	THEN
		Return	TRUE
	ELSE
		Return	FALSE
	END IF
END IF

// Both dates were passed
IF	 Date (adtm_from_date)	>=	Date (ldtm_from_date)		&
AND Date (adtm_to_date)		<=	Date (ldtm_to_date)		THEN
	Return	TRUE
ELSE
	Return	FALSE
END IF



end function

public function integer of_getloadedrange (string as_inv_type, string as_add_inv_type, ref datetime adtm_from_date, ref datetime adtm_to_date);//****************************************************************************
//	Script:	of_GetLoadedRange
//
//	Arguments:	1.	as_inv_type
//					2.	as_add_inv_type
//					3.	adtm_from_date - by reference
//					4.	adtm_to_date - by reference
//
//	Returns:		Integer
//					 1	=	success
//					-1	=	error
//
//	Description:
//			This function will read claims_cntl to identify
//			the loaded payment range based on the invoice types.
//****************************************************************************
//
//	GaryR	09/12/02	Track	3275d	Created
//	GaryR	09/12/02	Track	3275d	Include range of dependant in calculation
//
//****************************************************************************

String	ls_find,	ls_inv_type[]
Integer	li_row, li_rowcount, i, li_count
DateTime	ldtm_from_date, ldtm_to_date

n_cst_datetime	lnv_date			// Autoinstantiated

li_rowcount	=	ids_range.RowCount()

IF	li_rowcount	<	1		THEN
	// claims_cntl not previously read - read it.
	ids_range.DataObject	= "d_claims_cntl"
	ids_range.SetTransObject( Stars1ca )
	li_rowcount	= ids_range.Retrieve()
END IF

ls_inv_type[1] = as_inv_type
adtm_from_date = lnv_date.of_GetMinimumDateTime()
adtm_to_date = lnv_date.of_GetMaximumDateTime()

// If the invoice type passed is a FastTrack invoice type, 
//	then get the header invoice type
IF	Upper( Left( as_inv_type, 1 ) )	=	'Q'		&
OR	Upper( Left( as_inv_type, 1 ) )	=	'O'		THEN
	ls_inv_type[1] = fx_fasttrack_invoice_type( as_inv_type )
END IF

//	If the invoice type is MC then
//	compute the common date range
IF Upper( as_inv_type )	=	'MC' THEN
	w_main.dw_stars_rel_dict.SetFilter( "" )
	w_main.dw_stars_rel_dict.filter()
	w_main.dw_stars_rel_dict.SetFilter( "rel_type = 'GP' and id_3 = '*' " )
	w_main.dw_stars_rel_dict.filter()
	li_count = w_main.dw_stars_rel_dict.RowCount()
	
	IF	li_count < 1 THEN
		MessageBox( "Application Error", "MC is not mapped to any claims in " + &
						"n_cst_server.of_GetLoadedRange()." )
		Return -1
	END IF
	
	FOR i = 1 TO li_count
		ls_inv_type[i] = w_main.dw_stars_rel_dict.GetItemString( i, "id_2" )
	NEXT
END IF

li_count = UpperBound( ls_inv_type )

//	GaryR	09/12/02	Track	3275d - Begin
IF NOT IsNull( as_add_inv_type ) AND Trim( as_add_inv_type ) <> "" THEN
	// If the invoice type passed is a FastTrack invoice type, 
	//	then get the header invoice type
	IF	Upper( Left( as_add_inv_type, 1 ) )	=	'Q'		&
	OR	Upper( Left( as_add_inv_type, 1 ) )	=	'O'		THEN
		as_add_inv_type = fx_fasttrack_invoice_type( as_add_inv_type )
	END IF
	li_count ++
	ls_inv_type[li_count] = as_add_inv_type
END IF
//	GaryR	09/12/02	Track	3275d - End

FOR i = 1 TO li_count
	ls_find	=	"inv_type = '"	+ ls_inv_type[i] + "'"
	li_row	=	ids_range.Find( ls_find, 1, li_rowcount )
	
	IF	li_row < 1 THEN
		MessageBox( "Application Error", "Cannot find CLAIMS_CNTL row in " + &
						"n_cst_server.of_GetLoadedRange(). inv_type = " + ls_inv_type[i] )
		Return -1
	END IF
	
	//	Obtain the from and the to dates for the invoice
	ldtm_from_date = ids_range.object.from_date [li_row]
	ldtm_to_date = ids_range.object.to_date [li_row]
	
	//	Compute the greatest from date and the least to date
	IF ldtm_from_date > adtm_from_date THEN adtm_from_date = ldtm_from_date
	IF ldtm_to_date < adtm_to_date THEN adtm_to_date = ldtm_to_date
NEXT

//	Make sure that the from date 
//	is greater than the to date
IF adtm_from_date > adtm_to_date THEN Return -1

Return	1
end function

public subroutine of_ismessagenull (string as_msg);//************************************************************
//	Script:	of_IsMessageNull
//
//	Arguments:	1.	as_msg = Error message from the server
//
//	Returns:		None
//
//	Description:
//			This function will decipher the error message returned
//			by the server to determine if the message is null.
//			If the error message is null, notify user and exit out.
//************************************************************
//
//	04/09/03	GaryR	Track 3461d	Check for null message
//
//************************************************************

IF Upper( as_msg ) = "NULL" 	THEN
	MessageBox( "Stars Server Error", "Stars Server returned a null error" + &
								"~n~rSTARS will be shut down immediately", StopSign! )
	HALT
END IF
end subroutine

public function long of_getidleminutes ();//************************************************************
//	Script:		of_GetIdleMinutes
//
//	Arguments:	None
//
//	Returns:		Long
//					>=0	=	Success
//					<0		=	Error
//
//	Description:
//			This function will call gole_server.GetIdleMinutes to determine
//			the number of minutes to allow the system to idle before timing out
//************************************************************
//
//	GaryR	02/10/05	Track 4178d	Make COM backwards compatible
//
//************************************************************

Long		ll_rc,		&
			ll_minutes

String	ls_msg

ll_rc		=	gole_server.GetIdleMinutes (REF ll_minutes)

ls_msg	=	'Error calling GetIdleMinutes in n_cst_server.of_GetIdleMinutes.'
IF	of_CheckStatus( ll_rc, ls_msg ) 	<	0 THEN Return -1

Return ll_minutes

end function

public function long of_updatefilterstats (string as_filterid);//************************************************************
//	Script:	of_UpdateFilterStats
//
//	Arguments:	1.	as_filterId
//
//	Returns:		Long
//					 0	=	Success
//					-1	=	Error
//
//	Description:
//			This function will call gole_server.UpdateFilterStats to update
//			the statistics of the specified filter table based on the filter id. 
//			While the FrontEnd blindly calls this method, the server contains
//			logic to determine weather or not to actually update the statistics.
//************************************************************
//
//	06/20/06	GaryR	SPR 4014	Update filter table statistics
//
//************************************************************

Long		ll_rc
String	ls_msg

w_main.SetMicrohelp ('Updating the Filter Table Statistics...')
ll_rc		=	gole_server.UpdateFilterStats(as_filterId)
w_main.SetMicrohelp ('Ready')

ls_msg	=	'Error calling UpdateFilterStats in n_cst_server.of_UpdateFilterStats.~n~r' + &
				'filterId = '	+ as_filterId
of_CheckStatus( ll_rc, ls_msg )

Return ll_rc
end function

on n_cst_server.create
call super::create
end on

on n_cst_server.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_range	=	CREATE	n_ds
end event

event destructor;call super::destructor;//	GaryR	02/10/05	Track 4178d	Make COM backwards compatible

IF	IsValid (ids_range)		THEN
	Destroy	ids_range
END IF

end event

