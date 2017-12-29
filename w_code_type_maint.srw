HA$PBExportHeader$w_code_type_maint.srw
$PBExportComments$Inherited from w_master
forward
global type w_code_type_maint from w_master
end type
type sle_code_code from u_sle within w_code_type_maint
end type
type mle_descr from multilineedit within w_code_type_maint
end type
type cb_model from u_cb within w_code_type_maint
end type
type cb_clear from u_cb within w_code_type_maint
end type
type cb_add from u_cb within w_code_type_maint
end type
type st_description from statictext within w_code_type_maint
end type
type cb_list_codes from u_cb within w_code_type_maint
end type
type sle_numeric from singlelineedit within w_code_type_maint
end type
type sle_text from singlelineedit within w_code_type_maint
end type
type st_numeric from statictext within w_code_type_maint
end type
type st_type from statictext within w_code_type_maint
end type
type st_text from statictext within w_code_type_maint
end type
type cb_delete from u_cb within w_code_type_maint
end type
type cb_update from u_cb within w_code_type_maint
end type
type cb_retrieve from u_cb within w_code_type_maint
end type
type cb_exit from u_cb within w_code_type_maint
end type
end forward

global type w_code_type_maint from w_master
string accessiblename = "Code Type Details"
string accessibledescription = "Code Type Details"
integer x = 174
integer y = 0
integer width = 2601
integer height = 1620
string title = "Code Type Details"
sle_code_code sle_code_code
mle_descr mle_descr
cb_model cb_model
cb_clear cb_clear
cb_add cb_add
st_description st_description
cb_list_codes cb_list_codes
sle_numeric sle_numeric
sle_text sle_text
st_numeric st_numeric
st_type st_type
st_text st_text
cb_delete cb_delete
cb_update cb_update
cb_retrieve cb_retrieve
cb_exit cb_exit
end type
global w_code_type_maint w_code_type_maint

type variables
string in_from
end variables

event open;call super::open;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

//***********************************************************************
//Sees what function it should perform.  Depending on which one certain buttons
//will be disabled and different defaults will be used.
//**************************************************************************

in_from = gv_from

SetFocus(sle_code_code)
//fx_set_window_colors(w_code_type_maint)
if in_from = 'A' Then
   w_code_type_maint.title = 'Code Type Add'
	CB_Add.default = TRUE
	CB_delete.enabled = FALSE
	CB_Update.enabled = FALSE
	cb_list_codes.enabled=false
	sle_numeric.text = '0'
end if

if in_from = 'M' Then
	sle_code_code.text = gv_code_code
	
	TriggerEvent(CB_Retrieve,Clicked!)
end if 
end event

on w_code_type_maint.create
int iCurrent
call super::create
this.sle_code_code=create sle_code_code
this.mle_descr=create mle_descr
this.cb_model=create cb_model
this.cb_clear=create cb_clear
this.cb_add=create cb_add
this.st_description=create st_description
this.cb_list_codes=create cb_list_codes
this.sle_numeric=create sle_numeric
this.sle_text=create sle_text
this.st_numeric=create st_numeric
this.st_type=create st_type
this.st_text=create st_text
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_code_code
this.Control[iCurrent+2]=this.mle_descr
this.Control[iCurrent+3]=this.cb_model
this.Control[iCurrent+4]=this.cb_clear
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.st_description
this.Control[iCurrent+7]=this.cb_list_codes
this.Control[iCurrent+8]=this.sle_numeric
this.Control[iCurrent+9]=this.sle_text
this.Control[iCurrent+10]=this.st_numeric
this.Control[iCurrent+11]=this.st_type
this.Control[iCurrent+12]=this.st_text
this.Control[iCurrent+13]=this.cb_delete
this.Control[iCurrent+14]=this.cb_update
this.Control[iCurrent+15]=this.cb_retrieve
this.Control[iCurrent+16]=this.cb_exit
end on

on w_code_type_maint.destroy
call super::destroy
destroy(this.sle_code_code)
destroy(this.mle_descr)
destroy(this.cb_model)
destroy(this.cb_clear)
destroy(this.cb_add)
destroy(this.st_description)
destroy(this.cb_list_codes)
destroy(this.sle_numeric)
destroy(this.sle_text)
destroy(this.st_numeric)
destroy(this.st_type)
destroy(this.st_text)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_exit)
end on

type sle_code_code from u_sle within w_code_type_maint
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Code Type"
string accessibledescription = "Lookup Field - Code Type"
integer x = 599
integer y = 248
integer width = 206
integer height = 96
long textcolor = 134217747
long backcolor = 134217731
boolean autohscroll = true
textcase textcase = upper!
integer limit = 5
end type

event ue_lookup;call super::ue_lookup;//*********************************************************************************
// Script Name:	ue_lookup
//
// Arguments:	None
//
// Returns:		None
//
// Description:	Execute lookup functionality
//
//*********************************************************************************
//
//	05/13/09	GaryR	GNL.600.5633.011	Accommodate Lookups with Section 508
//
//*********************************************************************************

SetPointer(Hourglass!)

/*Sets the global variable so w_select_box knows which DW to use*/
gv_which_dw = 'CL'
gv_code_type = 'CD'

open(w_select_box)

/*loads the selected information into the sles*/
if gv_selection1 <> '' and gv_selection2 <> '' Then
	This.text = gv_selection1
	mle_descr.text = gv_selection2	
end if

end event

type mle_descr from multilineedit within w_code_type_maint
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = textrole!
integer x = 599
integer y = 436
integer width = 1778
integer height = 388
integer taborder = 20
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

type cb_model from u_cb within w_code_type_maint
string accessiblename = "Copy"
string accessibledescription = "Copy"
integer x = 1216
integer y = 1356
integer width = 256
integer height = 108
integer taborder = 90
integer textsize = -16
string text = "C&opy"
end type

on clicked;//                    ***CLICKED FOR CB_MODEL***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

cb_retrieve.enabled = TRUE
cb_add.enabled = TRUE
cb_update.enabled=FALSE
sle_code_code.enabled = TRUE
cb_add.default = TRUE
setmicrohelp(w_main,'Ready')
end on

type cb_clear from u_cb within w_code_type_maint
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1957
integer y = 1356
integer width = 256
integer height = 108
integer taborder = 110
integer textsize = -16
string text = "C&lear"
end type

on clicked;//                   ***CLICKED FOR CB_CLEAR***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************

//********************************************************************
//This clears all the sle's on this screen by placing '' in them
//*********************************************************************


SetMicroHelp(w_main,'Clearing all fields')

sle_code_code.text = ''
mle_descr.text = ''
sle_text.text = ''
sle_numeric.text = '0'

cb_update.enabled = FALSE
cb_delete.enabled = FALSE
cb_retrieve.default = True
cb_retrieve.enabled = TRUE
cb_list_codes.enabled=false
cb_add.enabled = TRUE
sle_code_code.enabled = TRUE
SetFocus(sle_code_code)
SetMicroHelp(w_main,'Fields cleared')

end on

type cb_add from u_cb within w_code_type_maint
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 933
integer y = 1356
integer width = 256
integer height = 108
integer taborder = 80
integer textsize = -16
string text = "Cr&eate"
end type

event clicked;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ----	-------------------------------------------------------- 
// 10/19/93 SWD	Created
//	12/05/00	FDG	Stars 4.7.  Make error checking DBMS-independent
//	01/11/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 03/16/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	11/13/01	GaryR	Track 2535d	Code Description is case insensitive
//***********************************************************************


int lv_numeric,rc,lv_exists, li_rc

String	ls_empty

lv_numeric = Integer(sle_numeric.text)

SetPointer (hourglass!)
SetMicroHelp(w_main,'Adding Code to the Code Table')

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

//***********************ERROR CHECKING SECTION*****************************
//This section does error checking.  First it checks to see if a valid code
//has been entered.  Then it makes sure that fields that shouldn't be null aren't
//Also the sle_Numeric is checked out to make sure a number is entered.
//*************************************************************************   



	
					/*Error checking for code_code*/
If trim(sle_code_code.text) = '' Then
	SetMicroHelp(w_main,'Add Cancelled')
	messagebox('ERROR','Code ID cannot be Null!~rEnter a value for Code ID',stopsign!,OK!)
	setfocus(sle_code_code)
	return
end if

					/*Error checking for description*/
If trim(mle_descr.text) = '' Then
	SetMicroHelp(w_main,'Add Cancelled')
	messagebox('ERROR','Description cannot be Null!~rEnter a value for Description',stopsign!,OK!)
	setfocus(mle_descr)
	return
end if

					/*Error checking for numeric*/
if sle_numeric.text = "" then sle_numeric.text = "0"
if isnumber(sle_numeric.text) = FALSE Then
	SetMicroHelp(w_main,'Add Cancelled')
	messagebox('Error','Numeric Value has to be a number'+ &
						  '~rPlease Enter a Numeric value',Stopsign!)	
	SetFocus(sle_numeric)
	return
end if


//************************INSERT SECTION******************************
//This section inserts the information entered by the user into the 
//database.  Also does sql error checking
//********************************************************************

//DJP 8/1/95 prob#847 - check to see if code exists
select count(*) into :lv_exists from code
 where code_type='CD' and code_code = Upper( :sle_code_code.text )
 using stars2ca;

if stars2ca.of_check_status()<>0 then
	SetMicroHelp(w_main,'Ready')
	errorbox(stars2ca,'Error checking for already existing code.')
	return
elseif lv_exists>0 then
	SetMicroHelp(w_main,'Ready')
	if messagebox("ERROR",'Code Type '+sle_code_code.text+' already exists! Do you want to retrieve it?',exclamation!,yesno!,1)=1 then
		cb_retrieve.postevent(clicked!)
		return
	end if
	setfocus(sle_code_code)
	RETURN
end if

//	01/11/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( sle_text.text ) = "" THEN sle_text.text = ls_empty

Insert into code 
		(CODE_TYPE,CODE_CODE, CODE_DESC,CODE_VALUE_A,CODE_VALUE_N)
		values('CD',:sle_code_code.text,:mle_descr.text,:sle_text.text,
				 :lv_numeric)	// 03/16/01	GaryR	Stars 4.7 DataBase Port		//	11/13/01	GaryR	Track 2535d
Using stars2ca;

//	Duplicate record is an error.
If stars2ca.of_check_status() < 0 Then
	// FDG 12/05/00 - Make error checking DBMS-independent
	//If stars2ca.sqldbcode = gv_sql_dup or stars2ca.sqldbcode = gv_sql_dup2 Then
	IF	gnv_sql.of_is_duplicate_insert (Stars2ca.sqldbcode)	=	TRUE		THEN
		SetMicroHelp(w_main,'Add Cancelled')
  		messagebox("ERROR",'Error attempting to insert a duplicate record into the Code Type table~nUse Retrieve & Update if you wish to modify the code',StopSign!)
		setfocus(sle_code_code)
 		RETURN
	Else
// 		if return code -1, database error
		SetMicroHelp(w_main,'Error Adding to Code Table, Add Cancelled') 
		errorbox(stars2ca,'Error inserting into the Code Table')
		setfocus(sle_code_code)
		return
   end if
end if
	
COMMIT Using Stars2ca;
//sqlcmd('commit',stars2ca,'Error commiting to the database',1)
//sqlcmd('disconnect',stars2ca,'Error disconnecting to the database',1)	// FDG 10/20/95
SetMicroHelp(w_main,'Add Complete')


sle_code_code.enabled = FALSE
cb_update.enabled = TRUE
cb_delete.enabled = TRUE
cb_clear.default = TRUE
cb_list_codes.enabled=true
cb_retrieve.enabled = FALSE
cb_add.enabled = FALSE
end event

type st_description from statictext within w_code_type_maint
string accessiblename = "Description"
string accessibledescription = "Description"
accessiblerole accessiblerole = statictextrole!
integer x = 206
integer y = 452
integer width = 370
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Description:"
alignment alignment = right!
end type

type cb_list_codes from u_cb within w_code_type_maint
string accessiblename = "List Codes"
string accessibledescription = "List Codes..."
integer x = 1499
integer y = 1356
integer width = 430
integer height = 108
integer taborder = 100
string text = "L&ist Codes..."
end type

on clicked;gv_code_type = sle_code_code.text
setpointer(hourglass!)
setmicrohelp(w_main,'Opening Codes List...')
OpenSheet(w_code_list,MDI_main_frame,help_menu_position,Layered!)
setmicrohelp(w_main,'Ready')
setpointer(arrow!)
end on

type sle_numeric from singlelineedit within w_code_type_maint
string accessiblename = "Numeric"
string accessibledescription = "Numeric"
accessiblerole accessiblerole = textrole!
integer x = 599
integer y = 1040
integer width = 219
integer height = 92
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_text from singlelineedit within w_code_type_maint
string accessiblename = "Text"
string accessibledescription = "Text"
accessiblerole accessiblerole = textrole!
integer x = 599
integer y = 876
integer width = 1778
integer height = 92
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean enabled = false
integer limit = 32
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type st_numeric from statictext within w_code_type_maint
string accessiblename = "Numeric"
string accessibledescription = "Numeric"
accessiblerole accessiblerole = statictextrole!
integer x = 283
integer y = 1056
integer width = 293
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Numeric:"
alignment alignment = right!
end type

type st_type from statictext within w_code_type_maint
string accessiblename = "Code Type"
string accessibledescription = "Code Type"
accessiblerole accessiblerole = statictextrole!
integer x = 229
integer y = 260
integer width = 347
integer height = 64
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code Type:"
alignment alignment = right!
end type

type st_text from statictext within w_code_type_maint
string accessiblename = "Text"
string accessibledescription = "Text"
accessiblerole accessiblerole = statictextrole!
integer x = 329
integer y = 880
integer width = 247
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Text:"
alignment alignment = right!
end type

type cb_delete from u_cb within w_code_type_maint
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 649
integer y = 1356
integer width = 256
integer height = 108
integer taborder = 70
string text = "&Delete"
end type

event clicked;//                ***Clicked for cb_Delete****

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
//***********************************************************************


/****************************Declaration Section***********************/
int lv_message_nbr
string temp_str
//***************************CONFIRMATION SECTION**********************
//Prints a confirmation box and finds out what button was pressed.
//********************************************************************

lv_message_nbr = MessageBox('CONFIRMATION!','Delete Record',Question!,OKCANCEL!)
If lv_message_nbr = 2 Then
	  SetMicroHelp(w_main,'Deletion of Code type Cancelled')
     Return
end if

SetMicroHelp(W_Main,'Deleting the Code from the Code Table')

//****************************DELETING SECTION***************************
//This section deletes the specified code type and all the code id's
//under that code type.
//*******************************************************************\

/*Deletes the row from the table*/
//sqlcmd('Connect',stars2ca,'Error connecting to the database',5)  // FDG 10/20/95

SetPointer(Hourglass!)

/* Check to see if there are any code of this type on file */
SELECT CODE_CODE
	INTO :temp_str 	
	FROM CODE
	WHERE CODE_TYPE = Upper( :sle_code_code.text )
		and CODE_CODE = (SELECT MAX(CODE_CODE) FROM CODE 
								WHERE CODE_TYPE = Upper( :sle_code_code.text ) )
	USING stars2ca;

if stars2ca.of_check_status() = 0 Then
	if (messagebox("WARNING","If you continue, all codes of type " + sle_code_code.text  + " will be deleted!",QUESTION!,OKCancel!) = 2) then
		SetMicroHelp(w_main,'Deletion Cancelled')	
		return
	end if
	setfocus(sle_code_code)
elseif stars2ca.sqlcode <> 100 Then
	errorbox(stars2ca,'Error reading from the CODE Table')
	setfocus(sle_code_code)
	SetMicroHelp(w_main,'Deletion Cancelled')
	return
end if

/*Deletes the CD row from the database*/

DELETE FROM Code 
	WHERE CODE_TYPE = 'CD' and
			CODE_CODE = Upper( :sle_code_code.text )
	using Stars2ca;

if stars2ca.of_check_status() = 100 Then
	messagebox('Error','Record Not Found,Deletion cancelled',stopsign!)
	setfocus(sle_code_code)
	SetMicroHelp(w_main,'Deletion Cancelled')
	return
elseif stars2ca.sqlcode <> 0 Then
	errorbox(stars2ca,'Error deleting from the CODE Table')
	setfocus(sle_code_code)
	SetMicroHelp(w_main,'Deletion Cancelled')
	return
end if


/*Deletes the code id's under that code type*/
DELETE FROM code 
	WHERE Code_type = Upper( :sle_code_code.text )
	USING Stars2ca;

if (stars2ca.of_check_status() <> 100) and (stars2ca.sqlcode <> 0) Then
	errorbox(stars2ca,'Error deleting from the CODE Table')
	SetMicroHelp(w_main,'Deletion Cancelled')
	return
end if

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

SetMicroHelp(w_main,'Deletion Complete')
cb_clear.TriggerEvent(clicked!)
end event

type cb_update from u_cb within w_code_type_maint
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 366
integer y = 1356
integer width = 256
integer height = 108
integer taborder = 60
string text = "&Update"
end type

event clicked;                 //***CLICKED FOR CB_UPDATE***//

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- 	-------------------------------------------------------- 
// 10/19/93 SWD  	Created
//	01/11/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 03/16/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	11/13/01	GaryR	Track 2535d	Code Description is case insensitive
//	07/27/04	GaryR	Track 4048d	Add CODE_TYPE to where clause to prevent mass update
//***********************************************************************



int lv_numeric, li_rc

String	ls_empty

SetPointer (hourglass!)
SetMicroHelp(w_main,'Updating the Code Table')	 
lv_numeric = integer(sle_numeric.text)

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)
	
//*************************ERROR CHECKING SECTION************************
//This section checks fields that can't be null.  If it is Null an error
//message is displayed and the user is forced to enter a value.  Also
//it checks the sle_numeric to make sure a number is entered.
//*************************************************************************

					/*Error checking for description*/
If trim(mle_descr.text) = '' Then
	SetMicroHelp(w_main,'Update Cancelled')
	messagebox('ERROR','Code Description cannot be Null!~rEnter a value for description',stopsign!,OK!)
	setfocus(mle_descr)
	return
end if

                  /*Error checking for numeric*/
if Trim( sle_numeric.text ) = "" then sle_numeric.text = "0"
if isnumber(sle_numeric.text) = FALSE Then
	SetMicroHelp(w_main,'Update Cancelled')
	messagebox('Error','NUmeric Value has to be a number'+ &
						  '~rPlease Enter a Numeric value',Stopsign!)	
	SetFocus(sle_numeric)
	return
end if

//************************THE UPDATE SECTION***************************
//This section does the actual update to the specified row.  It also does
//sql error checking.
//********************************************************************

//sqlcmd('Connect',stars2ca,'Error connecting to the database',5)  // FDG 10/20/95

//	01/11/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( sle_text.text ) = "" THEN sle_text.text = ls_empty

UPDATE CODE
	SET CODE_DESC = :mle_descr.text,		// 03/16/01	GaryR	Stars 4.7 DataBase Port		//	11/13/01	GaryR	Track 2535d
		 CODE_VALUE_A = :sle_text.text, 
		 CODE_VALUE_N = :lv_numeric
	WHERE (CODE_CODE = Upper( :sle_code_code.text ) )
	AND CODE_TYPE = 'CD'
using stars2ca;

IF stars2ca.of_check_status() <> 0 Then
	SetMicroHelp(w_main,'Error Updating the Code Table, Update Cancelled')
   errorbox(stars2ca,'Error Updating the Code table')
	setfocus(sle_code_code)
	RETURN
end if 

cb_clear.default = True

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

SetMicroHelp(w_main,'Update Complete')



end event

type cb_retrieve from u_cb within w_code_type_maint
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 46
integer y = 1356
integer width = 293
integer height = 108
integer taborder = 50
string text = "&Retrieve"
boolean default = true
end type

event clicked;//                    ***CLICKED FOR CB_RETRIEVE***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
// 06-28-95 FNC  Change the way chkcode is called
//	03/07/02	FDG	Track 2861d.  Trim sle_code_code.
//***********************************************************************


int rc
string lv_indx_ind,lv_table_type,lv_null_arg

SetPointer(hourglass!)
SetMicroHelp(w_main,'Retrieving record from Dictionary Table')	  

// FDG 03/07/02 - trim data
sle_code_code.text	=	Trim (sle_code_code.text)

//****************************VALID CODE SECTION****************************
//This section makes sure that the code id being entered is a valid one.  If 
//it is not then it displays an error message and forces the user to enter
//a valid one.
//*************************************************************************

rc = chkcode('CD',sle_code_code.text,lv_null_arg)

if rc = -1 Then
	messagebox('Error','An Invalid Code Type was entered~r'+&
   						 'Please enter or choose a valid one'&
				  ,stopsign!,ok!)
	SetFocus(sle_code_code)
	setmicrohelp(w_main,'Ready')
	return
end if

if rc = -2 Then     //06-28-95 FNC Start
	messagebox("Error","Error Reading the Code table to verify code type.~r"+&
   						 "Please contact the system administrator. "&
				  ,stopsign!,ok!)
	SetFocus(sle_code_code)
	setmicrohelp(w_main,'Ready')
	return
end if              //06-28-95 FNC End

//***************************ACTUAL RETRIEVAL SECTION************************
//This Section finds the information based off the keys and puts it in the 
//appropiate sle's.  It then does sql error checking
//************************************************************************
 
SELECT CODE_CODE,Code_DESC,CODE_VALUE_A,CODE_VALUE_N 
Into   :sle_code_code.text,:mle_descr.text,
		 :sle_text.text,:sle_numeric.text
		 From code
Where (CODE_TYPE = 'CD') and
		(Code_code = Upper( rtrim(:sle_code_code.text ) ) )
Using stars2ca;

If stars2ca.of_check_status() = 100 Then
	SetMicroHelp(w_main,'Retrieve Cancelled')
	COMMIT Using Stars2ca;							// FDG 10/20/95
	messagebox('Not Found','Selection not found, Cannot be retrieved',StopSign!)
	sle_code_code.text = ''
	setfocus(sle_code_code)
	RETURN
elseIF stars2ca.sqlcode <> 0 Then
	SetMicroHelp(w_main,'Error retrieving from the Code Table, Retrieve Cancelled')
   errorbox(stars2ca,'Error retrieving from Code Table, Retrieve Cancelled')
	setfocus(sle_code_code)
	RETURN
end if 

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95

//*************************ENABLING AND DISABLING SECTION******************************
//This section enables buttons and then locks the keys, so it can not be
//changed.
//**************************************************************************8
cb_add.enabled = FALSE
cb_retrieve.enabled = FALSE
cb_update.enabled = TRUE
cb_delete.enabled = TRUE
cb_update.default = TRUE
sle_code_code.enabled = FALSE
cb_list_codes.enabled=true

SetMicroHelp(w_main,'Retrieve Complete')

end event

type cb_exit from u_cb within w_code_type_maint
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2240
integer y = 1356
integer width = 256
integer height = 108
integer taborder = 120
string text = "&Close"
end type

on clicked;close(parent)
end on

