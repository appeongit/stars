$PBExportHeader$n_cst_notes.sru
$PBExportComments$inherited from n_cst_baseattrib <logic>
forward
global type n_cst_notes from n_cst_baseattrib
end type
end forward

global type n_cst_notes from n_cst_baseattrib
end type

type variables
/////////////////////////////////////////////////////////////////////////////
// Change History
/////////////////////////////////////////////////////////////////////////////
// Jason 10/17/02 Track 2883d add variable for note_desc
//	GaryR	08/16/05	Track 4361d	Centralize logic under one NVO
/////////////////////////////////////////////////////////////////////////////

string is_notes_from
string is_notes_rel_type
string is_notes_sub_type
string is_notes_rel_id
string is_notes_id
String is_notes_desc	// JasonS 10/17/02 Track 2883d
String is_note_text
date idt_notes_date
Datetime	idt_datetime
string is_notes_subset_id //JSB 01/23/02 Track 2695
String	is_old_note_id, is_old_rel_type, is_old_rel_id
String	is_dept_id, is_user_id
String	is_rte_ind
end variables

forward prototypes
public function integer uf_copy_note ()
public function integer uf_create_note ()
end prototypes

public function integer uf_copy_note ();/////////////////////////////////////////////////////////////////////////
//
//	FDG	12/13/00	Stars 4.7.  Make the retrieval of note_text 
//						DBMS-independent
//	GaryR	01/12/01	Stars 4.7 DataBase Port - Empty String in SQL
//	GaryR	09/17/02	SPR 4182c	Pass three unique key arguments for notes retrieval
// Jason 10/17/02 Track 2883d  Copy note_desc with rest of note
//	GaryR	08/16/05	Track 4361d	Centralize logic under one NVO
/////////////////////////////////////////////////////////////////////////

//	GaryR	09/17/02	SPR 4182c
is_note_text	=	gnv_sql.of_get_note_text( is_old_note_id, is_old_rel_type, is_old_rel_id )

IF	Trim (is_note_text)	=	''		THEN
	MessageBox ('Error', 'Error retrieving note_text from NOTES in u_nvo_notes.uf_copy_notes()')
	Return	-1
END IF
// FDG 12/13/00 End

Return This.uf_create_note()
end function

public function integer uf_create_note ();/////////////////////////////////////////////////////////////////////////
// Function: uf_create_note( )
// Purpose: This function will create a note using the instance variables 
//          which need to be set by the calling function after this nvo has
//          been instantiated.
/////////////////////////////////////////////////////////////////////////
// Change History
/////////////////////////////////////////////////////////////////////////
//	Jason 08/14/02	Created.
// Jason 12/19/02	Track 2883d add note_desc
//	GaryR	08/16/05	Track 4361d	Centralize logic under one NVO
/////////////////////////////////////////////////////////////////////////

String	ls_empty, ls_message
int li_rc
n_cst_case	lnv_case

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

//	GaryR	01/12/01	Stars 4.7 DataBase Port - Begin		// FDG 04/16/01
IF Trim( is_notes_rel_type )	= "" THEN is_notes_rel_type	= ls_empty
IF Trim( is_notes_sub_type )	= "" THEN is_notes_sub_type	= ls_empty
IF Trim( is_notes_rel_id )		= "" THEN is_notes_rel_id		= ls_empty
IF Trim( is_notes_id )			= "" THEN is_notes_id			= ls_empty
IF Trim( is_rte_ind )			= "" THEN is_rte_ind				= ls_empty
//	GaryR	01/12/01	Stars 4.7 DataBase Port - End

INSERT into NOTES (dept_id,user_id,note_rel_type,note_rel_id,note_id,
		note_sub_type,note_datetime,note_text,rte_ind, note_desc)
values (:is_dept_id,:is_user_id,:is_notes_rel_type,:is_notes_rel_id,:is_notes_id,
		:is_notes_sub_type,:idt_datetime,' ',:is_rte_ind, :is_notes_desc)
using stars2ca;

if stars2ca.of_check_status() <> 0 then
	Stars2ca.of_rollback()
	Return -1
end if

//	Insert note text
gnv_sql.of_set_note_text( is_note_text, is_notes_id, is_notes_rel_type, is_notes_rel_id )

// Add log to Case
IF is_notes_rel_type = 'CA' THEN
	lnv_case = Create n_cst_case
	ls_message		=	"Case note "	+	is_notes_id	+	" (" + &
							is_notes_rel_type + "/" + is_notes_sub_type + " )" + &
							" added."
							
	li_rc	=	lnv_case.uf_audit_log (is_notes_rel_id, is_notes_rel_type, ls_message)
	Destroy lnv_case
	
	IF	li_rc	<	0		THEN
		Stars2ca.of_rollback()
		Return -1	//	09/18/02	GaryR	SPR 4598c
	END IF
END IF

Stars2ca.of_commit()
Return 1
end function

on n_cst_notes.create
call super::create
end on

on n_cst_notes.destroy
call super::destroy
end on

