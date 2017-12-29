HA$PBExportHeader$n_ds.sru
$PBExportComments$Ancestor DataStore <logic>
forward
global type n_ds from datastore
end type
end forward

global type n_ds from datastore
event type integer ue_preupdate ( )
event type integer ue_update ( boolean ab_accepttext,  boolean ab_resetflag )
event type integer ue_reconnect ( )
end type
global n_ds n_ds

type variables
//	Transaction object used by this d/w
n_tr			itr_object						// FDG 02/20/01

Protected		String	is_window_name = ''

// Data trimming service NVO
n_cst_trim  inv_trim

end variables

forward prototypes
public subroutine of_set_windowname (string as_window_name)
public subroutine of_set_dw_dbms ()
public subroutine of_set_dw_dbms (n_tr atr_trans)
public function integer settransobject (n_tr atr_trans)
public function integer of_set_dddw_dbms ()
public function integer of_settrim (boolean ab_switch)
end prototypes

event ue_preupdate;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	n_ds.ue_preupdate
//
//	Arguments:	None
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Additional processing prior to updating this d/s.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rtn = 1

// Convert specified fields to be updated to upper case
IF Upper( THIS.Describe( "t_uppercase.Text") ) = "UPPER" THEN
	li_rtn = gnv_sql.of_SetUpper( THIS )
	IF	li_rtn	<	0		THEN
		Return	li_rtn
	END IF
END IF	

IF	IsValid (inv_trim)		THEN
	li_rtn	=	inv_trim.Event	ue_preupdate()
	IF	li_rtn	<	0		THEN
		Return	li_rtn
	END IF
END IF

Return li_rtn
end event

event ue_update;////////////////////////////////////////////////////////////////////////////
//
//	Function:  	n_ds.ue_update
//
//	Arguments:
//	ab_accepttext	Should an Accepttext be performed before updating?
//	ab_resetflag	Should the d/s reset the update flags?
//
//	Returns:  		1=successful, -1=unsuccessful
//
//	Description:	Update this d/s.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

//	Verify arguments
IF	IsNull (ab_accepttext)	&
OR	IsNull (ab_resetflag)	THEN
	Return -1
END IF

// Fire the pre-update event
IF THIS.Event ue_preupdate() < 0 THEN Return -1

li_rc	=	This.Update (ab_accepttext, ab_resetflag)

Return li_rc

end event

event type integer ue_reconnect();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  n_ds.ue_reconnect
//
//	Description:	
//		This event is triggered from w_main.disconnect_connect_datastores when the
//		user is disconnected from timing out of the system.  If there is a valid
//		transaction object, perform a SetTransobject.
//
//////////////////////////////////////////////////////////////////////////////
//
//	02/19/04	GaryR	Track 3869d	Reestablish DB connection to datastores on reconnect
//
//////////////////////////////////////////////////////////////////////////////

IF	IsValid (itr_object)		THEN
	This.SetTransobject (itr_object)
ELSE
	Return 0
END IF

Return 1


end event

public subroutine of_set_windowname (string as_window_name);//************************************************************************
//	Script:	n_ds.of_set_windowname
//
//	Arguments:	as_window_name - The name of the window
//
//	Returns:		N/A
//
//	Description:	Save the name of the window in case the datastore's
//						DBError event occurs.
//
//************************************************************************

is_window_name	=	as_window_name


end subroutine

public subroutine of_set_dw_dbms ();//************************************************************************
//	Script:		n_ds.of_set_dw_dbms
//
//	Arguments:	None
//
//	Returns:		None
//
//	Description:	This overloaded function will change the name of the 
//						d/w object based on which DBMS the client is using.
//
//************************************************************************
//
//	FDG	11/15/00	Stars 4.7 - Oracle port.  
//
//************************************************************************

String	ls_dataobject

Integer	li_rc

ls_dataobject	=	This.DataObject
ls_dataobject	=	gnv_sql.of_get_dw_object(ls_dataobject)

This.DataObject	=	ls_DataObject

// If this datawindow object has any DDDWs with transact-SQL, the d/w
//	object name associated with the DDDW must be changed.
li_rc				=	This.of_set_dddw_dbms()


end subroutine

public subroutine of_set_dw_dbms (n_tr atr_trans);//************************************************************************
//	Script:		n_ds.of_set_dw_dbms
//
//	Arguments:	atr_trans (Type n_tr)
//
//	Returns:		None
//
//	Description:	This overloaded function will change the name of the 
//						d/w object based on which DBMS the client is using.
//
//************************************************************************
//
//	FDG	11/15/00	Stars 4.7 - Oracle port.  
//
//************************************************************************

This.of_set_dw_dbms()

IF	IsValid(atr_trans)		THEN
	This.SetTransObject(atr_trans)
END IF


end subroutine

public function integer settransobject (n_tr atr_trans);//************************************************************************
//	Script:	n_ds.SetTransObject
//
//	Arguments:	atr_trans -	The transaction to perform a SetTransobject on
//
//	Returns:	Integer
//
//	Description:
//		This function overloads the PowerBuilder SetTransObject()
//		function.  This script will save the transaction object passed
//		before calling PowerBuilder's SetTransObject function.
//
//************************************************************************
//
//	FDG	02/20/01	Stars 4.7.  Set atr_trans and itr_object to type n_tr
//
//************************************************************************

itr_object	=	atr_trans

Return	Super::Function	SetTransObject (atr_trans)

end function

public function integer of_set_dddw_dbms ();//************************************************************************
//	Script:		n_ds.of_set_dddw_dbms
//
//	Arguments:	None
//
//	Returns:		Integer
//					1	=	Success
//					-1	=	Error
//
//	Description:	This function will loop thru every column to determine
//						which DDDW columns have transact-SQL.  These columns
//						will contain ';DDDWSQL;' in its tag value.  For each
//						column containing this tag value, do the following:
//						1. Get the d/w object name from the DDDW
//						2. Get the new d/w object name and reassign it to
//							the DDDW.
//
//************************************************************************
//
//	FDG	11/15/00	Stars 4.7 - Oracle port.  
//
//************************************************************************

Integer	li_col,			&
			li_colcount,	&
			li_pos

String	ls_tag,			&
			ls_colname,		&
			ls_describe,	&
			ls_modify,		&
			ls_dwname,		&
			ls_rc
			
li_colcount	=	This.object.datawindow.column.count

FOR	li_col	=	1	to	li_colcount
	// Get the column name
	ls_describe	=	'#'	+	String(li_col)	+	'.Name'
	ls_colname	=	This.Describe (ls_describe)
	// Get the tag value for the column name
	ls_describe	=	ls_colname	+	'.Tag'
	ls_tag		=	This.Describe (ls_describe)
	// Determine if this tag specifies that the DDDW has transact SQL
	li_pos		=	Pos (ls_tag, gnv_sql.ics_dddwsql)
	IF	li_pos	>	0		THEN
		// Tag found.  DDDW d/w object contains transact-SQL.
		//	Change the d/w object name
		ls_describe	=	ls_colname	+	'.dddw.Name'
		ls_dwname	=	This.Describe (ls_describe)
		ls_dwname	=	gnv_sql.of_get_dw_object(ls_dwname)
		ls_modify	=	ls_colname	+	".dddw.Name='"	+	ls_dwname	+	"'"
		ls_rc			=	This.Modify (ls_modify)
	END IF
NEXT

Return	1

end function

public function integer of_settrim (boolean ab_switch);//************************************************************************
//	Script:	n_ds.of_settrim
//
//	Arguments:	ab_switch -	TRUE = Start (Create) the service
//									FALSE = Stop (Destroy) the service
//
//	Returns:	Integer
//				1	-	Successful
//				0	-	No action taken
//				-1	-	An error occured
//
//	Description:	Start or stop the data trimming service
//
//************************************************************************

//	Check argument
IF	IsNull (ab_switch)	THEN
	Return -1
END IF

IF	ab_switch	THEN
	IF	NOT	IsValid (inv_trim)	THEN
		inv_trim	=	CREATE	n_cst_trim
		inv_trim.of_SetRequestor (THIS)
		Return 1
	END IF
ELSE
	IF	IsValid (inv_trim)	THEN
		DESTROY	inv_trim
		Return 1
	END IF
END IF

Return 0


end function

event dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  DBError
//
//	Description:
//		Open w_db_error to display the database error data.  If this occured
//		during the ue_save process, do not open w_db_error until after
//		the data is rolled back.
//
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	02/17/98	Added dataobject to the structure.
//
//////////////////////////////////////////////////////////////////////////////

str_db_error	lstr_db
String			ls_message
Integer			li_rc

IF	NOT	IsValid (itr_object)		THEN
	itr_object	=	STARS1CA
END IF

ls_message =	"A database error has occurred in STARS." 

lstr_db.trans				=	itr_object
lstr_db.message			=	ls_message
lstr_db.row_num			=	row
lstr_db.sqldbcode			=	sqldbcode
lstr_db.sqlerrtext		=	sqlerrtext
lstr_db.sqlsyntax			=	sqlsyntax
lstr_db.sqlreturndata	=	itr_object.sqlreturndata
lstr_db.window_name		=	is_window_name
lstr_db.dataobject		=	This.DataObject			// FDG 02/17/98

OpenWithParm (w_db_error, lstr_db)

Return 1


end event

on n_ds.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ds.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  n_ds.Constructor
//
//	Description:  Use the desired services needed for this datastore.
//
//////////////////////////////////////////////////////////////////////////////
//
// IF you want to convert data to be updated to upper case
// (1) - add an invisible text object to the dataobject
//			must be named t_uppercase.  Set the text to UPPER.
//			This indicates that this dataobject needs conversion.
// (2) - Set the Tag value to ;UPPER; for each column to be converted
//
//////////////////////////////////////////////////////////////////////////////
//
//	02/19/04	GaryR	Track 3869d	Reestablish DB connection to datastores on reconnect
//////////////////////////////////////////////////////////////////////////////

Integer		li_upper  

IF NOT IsValid(  w_main ) THEN Return
li_upper = UpperBound( w_main.ids_reconnect )
w_main.ids_reconnect[li_upper + 1] = This

end event

event retrieveend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  n_ds.RetrieveEnd
//
//////////////////////////////////////////////////////////////////////////////
//	Revision History
//
//	FDG	04/12/01	Stars 4.7.	Add ability to trim the data.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

// FDG 04/12/01 - Trim the retrieve data - if necessary
IF	IsValid (inv_trim)		THEN
	li_rc	=	inv_trim.Event	ue_retrieveend (rowcount)
END IF


end event

event destructor;
This.of_SetTrim (FALSE)				//	FDG	04/12/01

end event

