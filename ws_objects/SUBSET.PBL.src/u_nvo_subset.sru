$PBExportHeader$u_nvo_subset.sru
$PBExportComments$<logic>
forward
global type u_nvo_subset from nonvisualobject
end type
end forward

global type u_nvo_subset from nonvisualobject autoinstantiate
event type integer ue_construct ( string as_subset_id )
end type

type variables


string	is_subset_id
string	is_subset_name
string	is_subset_desc

n_ds		ids_criteria
n_ds		ids_sub_cntl
n_ds		ids_case_link
end variables

forward prototypes
public function string uf_get_subset_type ()
public function string uf_get_description ()
public function string uf_get_subset_tables ()
public function any of_get_inv_types ()
public function string uf_get_link_desc (string as_case, string as_case_spl, string as_case_ver)
public function string uf_get_link_name (string as_case, string as_case_spl, string as_case_ver)
public function integer of_get_default_sched_time (ref datetime adt_cur, ref datetime adt_dflt_schd)
end prototypes

event type integer ue_construct(string as_subset_id);

int	li_rc

is_subset_id = as_subset_id

// Get SUB_CNTL values
ids_sub_cntl = CREATE n_ds
ids_sub_cntl.DataObject = 'd_case_sub_cntl'
ids_sub_cntl.SetTransObject(stars2ca)
li_rc = ids_sub_cntl.retrieve( as_subset_id )

// Get Criteria
ids_criteria = CREATE n_ds
ids_criteria.dataObject = 'd_subset_criteria'
ids_criteria.setTransObject(stars2ca)
li_rc = ids_criteria.retrieve( as_subset_id )

// Get Case Link
ids_case_link = CREATE n_ds
ids_case_link.dataObject = 'd_case_link_subset'
ids_case_link.setTransObject(stars2ca)
li_rc = ids_case_link.retrieve( as_subset_id )

RETURN li_rc
end event

public function string uf_get_subset_type ();RETURN ids_sub_cntl.GetItemString(1, "SUBC_SUB_TBL_TYPE")
end function

public function string uf_get_description ();RETURN ids_sub_cntl.GetItemString(1, "SUBC_DESC")
end function

public function string uf_get_subset_tables ();RETURN ids_sub_cntl.GetItemString(1, "SUBC_TABLES")
end function

public function any of_get_inv_types ();int				li_rows, li_index
string			ls_subset_type
string			ls_inv_types[]
n_ds 				ds_sub_step_cntl
n_cst_string	lnv_string
ls_subset_type = this.uf_get_subset_type()

CHOOSE CASE ls_subset_type
	CASE 'ML'
		ls_inv_types = lnv_string.of_stringtoarray( this.uf_get_subset_tables() , "+")
	CASE 'MC'
		ds_sub_step_cntl = CREATE n_ds
		ds_sub_step_cntl.DataObject = 'd_sub_step_cntl_by_subc_id_rows'
		ds_sub_step_cntl.SetTransObject(stars2ca)
		li_rows = ds_sub_step_cntl.Retrieve(is_subset_id) 
		
		if stars2ca.of_check_status() < 0 Then
			MessageBox("Error","Cannot retrieve subset step cntl data",StopSign!)
			destroy(ds_sub_step_cntl)
		end if
	
		for li_index = 1 to li_rows
			ls_inv_types[li_index] = ds_sub_step_cntl.Object.inv_type[li_index]
		next
	
		DESTROY (ds_sub_step_cntl)
	CASE ELSE
		ls_inv_types[1] = ls_subset_type
END CHOOSE

RETURN ls_inv_types
end function

public function string uf_get_link_desc (string as_case, string as_case_spl, string as_case_ver);int	li_index

FOR li_index = 1 TO ids_case_link.RowCount()
	IF  trim(as_case) 		= trim(ids_case_link.GetItemString(li_index, "CASE_ID")) 	&
	AND trim(as_case_spl) 	= trim(ids_case_link.GetItemString(li_index, "CASE_SPL")) 	&
	AND trim(as_case_ver) 	= trim(ids_case_link.GetItemString(li_index, "CASE_VER"))	THEN
		RETURN ids_case_link.GetItemString(li_index, "LINK_DESC")
	END IF
NEXT

RETURN ' '
end function

public function string uf_get_link_name (string as_case, string as_case_spl, string as_case_ver);int	li_index

FOR li_index = 1 TO ids_case_link.RowCount()
	IF  trim(as_case) 		= trim(ids_case_link.GetItemString(li_index, "CASE_ID")) 	&
	AND trim(as_case_spl) 	= trim(ids_case_link.GetItemString(li_index, "CASE_SPL")) 	&
	AND trim(as_case_ver) 	= trim(ids_case_link.GetItemString(li_index, "CASE_VER"))	THEN
		RETURN ids_case_link.GetItemString(li_index, "LINK_NAME")
	END IF
NEXT

RETURN ' '
end function

public function integer of_get_default_sched_time (ref datetime adt_cur, ref datetime adt_dflt_schd);// Name : of_get_default_sched_time
// Purpose : Returns arguments after reading the stars_win_parm table to obtain the default schedule time. 
// Arguments : adt_cur (reference), adt_dflt_schd (reference)
// 02/15/2006 HYL Track 4651d Prevent default schedule date for Ancillary subset

datetime ldte_datetime
date ld_date
time lt_time
string ls_default_time

ldte_datetime = gnv_app.of_get_server_date_time()
//idt_default_datetime = datetime(date('01/01/1900'))
adt_cur = ldte_datetime
ld_date = date(ldte_datetime)
lt_time = time(ldte_datetime)

Select a_dflt 
Into :ls_default_time
From Stars_Win_Parm
Where Win_Id = 'W_SUBSET_OPTIONS' and
	Cntl_Id = 'DEFAULT_TIME'
Using stars2ca;

if stars2ca.of_check_status() <> 0 then 
	//Messagebox('Warning', 'Error retrieving default start time. Start time will be set to current server time')
	RETURN -1
else
	if IsTime(ls_default_time) THEN
		lt_time = Time(ls_default_time)
	else
		//messagebox('Warning', 'Default time in Stars Win Parms is not in correct format. Start time will be set to current server time')
		RETURN -2
	end if
end if

adt_dflt_schd = datetime(ld_date,lt_time)

Return 0
end function

on u_nvo_subset.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_nvo_subset.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

