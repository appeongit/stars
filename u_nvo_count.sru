HA$PBExportHeader$u_nvo_count.sru
$PBExportComments$Service to perform a select Count(*) (inherited from n_base) <logic>
forward
global type u_nvo_count from n_base
end type
end forward

global type u_nvo_count from n_base
end type
global u_nvo_count u_nvo_count

type variables
// Datastore to do the select Count(*)
n_ds	ids_count

// SQL used to perform the Count
String	is_sql

// Transaction object used for the datawindow retrieve
n_tr	itr_trans

// MikeF	03/04/04 SPR 3921d Using a LOJ with a UNION ALL View gives DB error
// Determines whether or not to use biew logic when doing counts
boolean		ib_ds_count

end variables

forward prototypes
public subroutine uf_set_sql (string as_sql)
public function long uf_get_count ()
public function long uf_get_count (string as_sql)
public subroutine uf_set_transaction (n_tr atr_trans)
public subroutine uf_set_ds_count (boolean ab_ds_count)
end prototypes

public subroutine uf_set_sql (string as_sql);//*********************************************************************************
// Event Name:	u_nvo_count.uf_set_sql
//
//	Arguments:	as_sql - The SQL to assign to the datastore - Must be a 
//					Select Count(*)
//
// Returns:		None
//
//	Description:
//		Change the SQL on the datastore.
//
//*********************************************************************************
//
// 01-16-98 FDG	Created
//
//*********************************************************************************

Integer	li_rc

is_sql	=	as_sql

li_rc	=	ids_count.SetSQLSelect (as_sql)

end subroutine

public function long uf_get_count ();//*********************************************************************************
// Event Name:	u_nvo_count.uf_get_count
//
//	Arguments:	None
//
// Returns:		Long - The count returned from the Select Count(*)
//
//	Description:
//		This function will perform a Select Count(*) on a datastore.  It will
//		then get the result and return it to the calling script.
//
//*********************************************************************************
//
// 01/16/98 FDG	Created
//
//	05/04/98	FDG	Track 1179.  If the sql is a union, then multiple rows can be
//						retrieved.  Get the count from every row.
// 03/02/04 MikeF	SPR 3909d Speed up select count when using Views
// 03/04/04 MikeF	SPR 3921d Using a LOJ with a UNION ALL View gives DB error
//*********************************************************************************

Long	ll_row,			&
		ll_count,		&
		ll_rowcount

ids_count.SetTransobject (itr_trans)

ll_rowcount	=	ids_count.Retrieve()

IF	ll_rowcount	<	1		THEN
	Return -1
END IF

IF ib_ds_count THEN
	RETURN ll_rowcount
END IF

FOR	ll_row	=	1	TO	ll_rowcount
	ll_count	=	ll_count	+	ids_count.object.count [ll_row]
NEXT

Return ll_count


end function

public function long uf_get_count (string as_sql);//*********************************************************************************
// Event Name:	u_nvo_count.uf_get_count(as_sql) - an overloaded function
//
//	Arguments:	as_sql - The SQL to assign to the datastore - Must be a 
//					Select Count(*)
//
// Returns:		Long - The result of the Select Count(*)
//
//	Description:
//		This is an overloaded function which assigns the SQL to the datastore, then
//		retrieves the datastore and returns the result.
//
//*********************************************************************************
//
// 01-16-98 FDG	Created
//
//*********************************************************************************

Long	ll_count

This.uf_set_sql (as_sql)	//	Assign the SQL to ids_count

ll_count		=	This.uf_get_count()

Return	ll_count

end function

public subroutine uf_set_transaction (n_tr atr_trans);//*********************************************************************************
// Event Name:	u_nvo_count.uf_set_transaction
//
//	Arguments:	atr_trans - The input transaction.  Will usually = Stars1ca or
//					stars2ca.  Stars2ca is the default.
//
// Returns:		None
//
//	Description:
//		Sets the transacion object for the datawindow.
//
//*********************************************************************************
//
// 02/05/98 FDG	Created
//
//*********************************************************************************

itr_trans	=	atr_trans


end subroutine

public subroutine uf_set_ds_count (boolean ab_ds_count);ib_ds_count = ab_ds_count
end subroutine

event constructor;//*********************************************************************************
// Event Name:	u_nvo_count.Constructor
//
//	Arguments:	None
//
// Returns:		None
//
//	Description:
//		Create the datastore to perform the Select Count(*)
//
//*********************************************************************************
//
// 01-16-98 FDG	Created
//	01/05/00	FNC	Rename the d_count datawindow because there were two datawindows
//						name d_count. The other one is in stperiod.pbl
//
//*********************************************************************************

ids_count	=	CREATE	n_ds
ids_count.DataObject	=	'd_query_engine_count'	// FNC 01/04/00

This.uf_set_transaction (Stars2ca)




end event

event destructor;Destroy	ids_count


end event

on u_nvo_count.create
call super::create
end on

on u_nvo_count.destroy
call super::destroy
end on

