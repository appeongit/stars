HA$PBExportHeader$w_code_maint.srw
$PBExportComments$Inherited from w_master
forward
global type w_code_maint from w_master
end type
type sle_type from u_sle within w_code_maint
end type
type cb_model from u_cb within w_code_maint
end type
type cb_clear from u_cb within w_code_maint
end type
type mle_descr from multilineedit within w_code_maint
end type
type cb_add from u_cb within w_code_maint
end type
type st_descr from statictext within w_code_maint
end type
type st_code_id from statictext within w_code_maint
end type
type sle_text from singlelineedit within w_code_maint
end type
type sle_numeric from singlelineedit within w_code_maint
end type
type sle_code_code from singlelineedit within w_code_maint
end type
type st_numeric from statictext within w_code_maint
end type
type st_type from statictext within w_code_maint
end type
type st_text from statictext within w_code_maint
end type
type cb_delete from u_cb within w_code_maint
end type
type cb_update from u_cb within w_code_maint
end type
type cb_retrieve from u_cb within w_code_maint
end type
type cb_exit from u_cb within w_code_maint
end type
end forward

global type w_code_maint from w_master
string accessiblename = "Code Details"
string accessibledescription = "Code Details"
integer x = 174
integer y = 0
integer width = 2601
integer height = 1544
string title = "Code Details"
boolean resizable = false
sle_type sle_type
cb_model cb_model
cb_clear cb_clear
mle_descr mle_descr
cb_add cb_add
st_descr st_descr
st_code_id st_code_id
sle_text sle_text
sle_numeric sle_numeric
sle_code_code sle_code_code
st_numeric st_numeric
st_type st_type
st_text st_text
cb_delete cb_delete
cb_update cb_update
cb_retrieve cb_retrieve
cb_exit cb_exit
end type
global w_code_maint w_code_maint

type variables
	string in_from
end variables

forward prototypes
public function integer fw_edit_code_code ()
end prototypes

public function integer fw_edit_code_code ();//This function edits for code types CA - Category, DE - Department and PC - Procedure
//to ensure the lengths entered are valid in the other places used in the database
/*
================================================================================
History
================================================================================
11/04/02 JasonS Track 3368d  	check dictionary for max length
03/17/03 JasonS Track 3368d  	Changed select to get min src_len
12/03/03	MikeF	 Track 3368d	Get Max SRC_LEN. (see 6282c)
================================================================================
*/

long ll_size = 0

select max(src_len)
into :ll_size
from dictionary
where elem_lookup_type = :sle_type.text
using stars2ca;

if ll_size = 0 then
	return 0
else
	if len(trim(sle_code_code.text)) > ll_size then
		Messagebox('EDIT', 'Codes cannot be longer than ' + string(ll_size) + ' for this code type.')
		Return -1
	end if
	Return 0
end if



end function

event open;call super::open;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
// JasonS 11/4/02 Track 3368d  Set code limit from db according to code type
//***********************************************************************

//***********************************************************************
//Sees what function it should perform.  Depending on which one certain buttons
//will be disabled and different defaults will be used.
//**************************************************************************

in_from = gv_from

SetFocus(sle_type)
//fx_set_window_colors(w_code_maint)
if in_from = 'A' Then
   w_code_maint.title = 'Code Add'
	CB_Add.default = TRUE
	CB_delete.enabled = FALSE
	CB_Update.enabled = FALSE
	sle_numeric.text = '0'
	sle_type.text = gv_code_type
	triggerevent (sle_type, Modified!)	// JasonS 11/4/02 Track 3368d
	show(w_code_maint)
end if

if in_from = 'M' Then
	sle_type.text = gv_code_type
	sle_code_code.text = gv_code_code
	triggerevent (sle_type, Modified!)	// JasonS 11/4/02 Track 3368d	
	TriggerEvent(CB_Retrieve,Clicked!)
end if 



end event

on w_code_maint.create
int iCurrent
call super::create
this.sle_type=create sle_type
this.cb_model=create cb_model
this.cb_clear=create cb_clear
this.mle_descr=create mle_descr
this.cb_add=create cb_add
this.st_descr=create st_descr
this.st_code_id=create st_code_id
this.sle_text=create sle_text
this.sle_numeric=create sle_numeric
this.sle_code_code=create sle_code_code
this.st_numeric=create st_numeric
this.st_type=create st_type
this.st_text=create st_text
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_type
this.Control[iCurrent+2]=this.cb_model
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.mle_descr
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.st_descr
this.Control[iCurrent+7]=this.st_code_id
this.Control[iCurrent+8]=this.sle_text
this.Control[iCurrent+9]=this.sle_numeric
this.Control[iCurrent+10]=this.sle_code_code
this.Control[iCurrent+11]=this.st_numeric
this.Control[iCurrent+12]=this.st_type
this.Control[iCurrent+13]=this.st_text
this.Control[iCurrent+14]=this.cb_delete
this.Control[iCurrent+15]=this.cb_update
this.Control[iCurrent+16]=this.cb_retrieve
this.Control[iCurrent+17]=this.cb_exit
end on

on w_code_maint.destroy
call super::destroy
destroy(this.sle_type)
destroy(this.cb_model)
destroy(this.cb_clear)
destroy(this.mle_descr)
destroy(this.cb_add)
destroy(this.st_descr)
destroy(this.st_code_id)
destroy(this.sle_text)
destroy(this.sle_numeric)
destroy(this.sle_code_code)
destroy(this.st_numeric)
destroy(this.st_type)
destroy(this.st_text)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_exit)
end on

type sle_type from u_sle within w_code_maint
string tag = "LOOKUP"
string accessiblename = "Lookup Field - Code Type"
string accessibledescription = "Lookup Field - Code Type"
integer x = 731
integer y = 180
integer width = 242
integer height = 96
integer taborder = 20
integer weight = 700
long textcolor = 134217747
long backcolor = 134217731
textcase textcase = upper!
integer limit = 5
end type

event modified;call super::modified;// JasonS 11/4/02 Track 3368d  Set code limit from db according to code type
// RickB  07/30/09  RTO.650.5712 - Changed SQL to check max elem_data_len from src_len
//		to match the SQL in w_code_list.

long ll_size = 0  //JasonS 11/4/02 Track 3368d

// JasonS 11/4/02 Begin - Track 3368d
if trim(sle_type.text) <> "" then
	select max(elem_data_len)
	into :ll_size
	from dictionary
	where elem_lookup_type = :sle_type.text
	using stars2ca;
	
	if ll_size > 0 then
		sle_code_code.limit = ll_size
	end if
end if
// JasonS 11/4/02 End - Track 3368d
end event

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
gv_which_dw = "CL"
gv_code_type = "CD"

open(w_select_box)

/*loads the selected information into the sles*/
if gv_selection1 <> "" and gv_selection2 <> "" Then
	This.text = gv_selection1	
end if

This.PostEvent ("Modified")
end event

type cb_model from u_cb within w_code_maint
string accessiblename = "Copy"
string accessibledescription = "Copy"
integer x = 1477
integer y = 1292
integer width = 338
integer height = 108
integer taborder = 100
integer textsize = -16
string text = "Co&py"
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
sle_type.enabled = TRUE
setmicrohelp(w_main,'Ready')
end on

type cb_clear from u_cb within w_code_maint
string accessiblename = "Clear"
string accessibledescription = "Clear"
integer x = 1838
integer y = 1292
integer width = 338
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
//This clears all the sle's on this screen by placing "" in them
//*********************************************************************


SetMicroHelp(w_main,"Clearing all fields")

sle_type.text = ""
sle_code_code.text = ""
mle_descr.text = ""
sle_text.text = ""
sle_numeric.text = "0"

cb_update.enabled = FALSE
cb_delete.enabled = FALSE
cb_retrieve.default = True
cb_retrieve.enabled = TRUE
cb_add.enabled = TRUE
sle_type.enabled = TRUE
sle_code_code.enabled = TRUE
SetFocus(sle_type)
SetMicroHelp(w_main,"Fields cleared")

end on

type mle_descr from multilineedit within w_code_maint
string accessiblename = "ID Description"
string accessibledescription = "Id Description"
accessiblerole accessiblerole = textrole!
integer x = 731
integer y = 504
integer width = 1614
integer height = 392
integer taborder = 30
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 33554432
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

type cb_add from u_cb within w_code_maint
string accessiblename = "Create"
string accessibledescription = "Create"
integer x = 754
integer y = 1292
integer width = 338
integer height = 108
integer taborder = 80
integer textsize = -16
string text = "Cr&eate"
end type

event clicked;//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- 	-------------------------------------------------------- 
// 10/19/93 SWD  	Created
// 12/28/93 FNC  	Add to CODE_DESC when record is added to CODE table
// 06/28/95 FNC  	Change the way chkcode is called
// 01/11/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
//	02/09/01	FDG	Stars 4.6 - PIMR.  Allow for 1st digit to be '#'.
// 03/16/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	11/13/01	GaryR	Track 2535d	Code Description is case insensitive
//***********************************************************************


int lv_numeric,rc,lv_exists, li_rc
string lv_null_arg, ls_empty

lv_numeric = Integer(sle_numeric.text)

SetPointer (hourglass!)
SetMicroHelp(w_main,'Adding Code to the Code Table')

// FDG 04/16/01 - Empty string = ' ' in Oracle
li_rc	=	gnv_sql.of_TrimData (ls_empty)

//***********************ERROR CHECKING SECTION*****************************
//This section does error checking.  First it checks to see if a valid code
//has been entered.  Then it makes sure that fieolds that shouldn't be null aren't
//Also the sle_Numeric is checke out to make sure a number is entered.
//*************************************************************************   

sle_type.text = trim(Upper(sle_type.text))        //alabama4 pat-d
If len(sle_type.text) > 5 then    //alabama4 pat-d
	setfocus(sle_type)             //alabama4 pat-d 
	Messagebox('EDIT','Code Type cannot be greater than 2 characters')  //alabama4 pat-d
	setmicrohelp(w_main,'Ready')
	RETURN                         //alabama4 pat-d
End IF                            //alabama4 pat-d 

rc = chkcode('CD',sle_type.text,lv_null_arg)

if rc = -1 Then
	// FDG 02/09/01 - Allow for # to be 1st digit
	String	ls_code_type
	ls_code_type	=	Mid (sle_type.text, 1, 1)
	IF	ls_code_type	<>	'#'		THEN
		messagebox('Error','An Invalid Code Type was entered~r'+&
								 'Please enter or choose a valid one'&
					  ,stopsign!,ok!)
		SetFocus(sle_type)
		setmicrohelp(w_main,'Ready')
		return
	END IF
	// FDG 02/09/01 - end
end if	

if rc = -2 Then     
	messagebox("Error","Error Reading the Code table to verify code type.~r"+&
   						 "Please contact the system administrator. "&
				  ,stopsign!,ok!)
	SetFocus(sle_type)
	setmicrohelp(w_main,'Ready')
	return
end if            

sle_code_code.text = trim(upper(sle_code_code.text))    //alabama4 pat-d
					/*Error checking for code_code*/
If Trim( sle_code_code.text ) = '' Then
	SetMicroHelp(w_main,'Add Cancelled')
	messagebox('ERROR','Code ID cannot be Null!~rEnter a value for Code ID',stopsign!,OK!)
	setfocus(sle_code_code)
	return
Else                                //alabama4 pat-d
	rc = fw_edit_code_code()  //alabama4 pat-d
	If rc = -1 then           //alabama4 pat-d
		SetMicroHelp(w_main,'Add Cancelled')   //alabama4 pat-d
		setfocus(sle_code_code)       //alabama4 pat-d   
		Return                        //alabama4 pat-d
	End IF                           //alabama4 pat-d
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
 where code_type = Upper( :sle_type.text ) and code_code = Upper( :sle_code_code.text )
 using stars2ca;

if stars2ca.of_check_status()<>0 then
	SetMicroHelp(w_main,'Ready')
	errorbox(stars2ca,'Error checking for already existing code.')
	return
elseif lv_exists>0 then
	SetMicroHelp(w_main,'Ready')
	if messagebox("ERROR",'Code '+sle_code_code.text+' already exists! Do you want to retrieve it?',exclamation!,yesno!,1)=1 then
		cb_retrieve.postevent(clicked!)
		return
	end if
	setfocus(sle_type)
	RETURN
end if

// 01/11/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( sle_text.text ) = "" THEN sle_text.text = ls_empty

Insert into code 
		(CODE_TYPE,CODE_CODE, CODE_DESC,CODE_VALUE_A,CODE_VALUE_N)
		values(:sle_type.text,:sle_code_code.text,:mle_descr.text,:sle_text.text,
				 :lv_numeric)			//	11/13/01	GaryR	Track 2535d
Using stars2ca;

//	Duplicate record is an error.
//DJP 8/1/95 prob#847 - move this to above the insert
If stars2ca.of_check_status() <> 0 Then
		SetMicroHelp(w_main,'Error Adding to the Code Table, Add Cancelled') 
		errorbox(stars2ca,'Error inserting into the Code Table')
		setfocus(sle_type)
		return
end if
	
COMMIT Using Stars2ca;


SetMicroHelp(w_main,'Add Complete')

sle_type.enabled = FALSE
sle_code_code.enabled = FALSE

cb_update.enabled = TRUE
cb_delete.enabled = TRUE
cb_clear.default = TRUE
cb_retrieve.enabled = FALSE
cb_add.enabled = FALSE
end event

type st_descr from statictext within w_code_maint
string accessiblename = "ID Description"
string accessibledescription = "ID Description"
accessiblerole accessiblerole = statictextrole!
integer x = 210
integer y = 504
integer width = 453
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "ID Description:"
alignment alignment = right!
end type

type st_code_id from statictext within w_code_maint
string accessiblename = "Code ID"
string accessibledescription = "Code ID"
accessiblerole accessiblerole = statictextrole!
integer x = 398
integer y = 336
integer width = 265
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code ID:"
alignment alignment = right!
end type

type sle_text from singlelineedit within w_code_maint
string accessiblename = "Text"
string accessibledescription = "Text"
accessiblerole accessiblerole = textrole!
integer x = 731
integer y = 976
integer width = 1518
integer height = 96
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_numeric from singlelineedit within w_code_maint
string accessiblename = "Numeric"
string accessibledescription = "Numeric"
accessiblerole accessiblerole = textrole!
integer x = 731
integer y = 1128
integer width = 457
integer height = 96
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type

type sle_code_code from singlelineedit within w_code_maint
string accessiblename = "Code ID"
string accessibledescription = "Code ID"
accessiblerole accessiblerole = textrole!
integer x = 731
integer y = 336
integer width = 590
integer height = 96
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

type st_numeric from statictext within w_code_maint
string accessiblename = "Numeric"
string accessibledescription = "Numeric"
accessiblerole accessiblerole = statictextrole!
integer x = 261
integer y = 1128
integer width = 393
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Numeric:"
alignment alignment = right!
end type

type st_type from statictext within w_code_maint
string accessiblename = "Code Type"
string accessibledescription = "Code Type"
accessiblerole accessiblerole = statictextrole!
integer x = 306
integer y = 180
integer width = 347
integer height = 72
fontcharset fontcharset = ansi!
string facename = "System"
long textcolor = 134217741
long backcolor = 67108864
boolean enabled = false
string text = "Code Type:"
alignment alignment = right!
end type

type st_text from statictext within w_code_maint
string accessiblename = "Text"
string accessibledescription = "Text"
accessiblerole accessiblerole = statictextrole!
integer x = 411
integer y = 976
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

type cb_delete from u_cb within w_code_maint
string accessiblename = "Delete"
string accessibledescription = "Delete"
integer x = 1115
integer y = 1292
integer width = 338
integer height = 108
integer taborder = 90
string text = "&Delete"
end type

event clicked;//                ***Clicked for cb_Delete****

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 12/28/93 FNC  Delete from CODE_DESC table when delete from CODE table
// 10/19/93 SWD  Created
// 08/05/02 MikeF	Track 3228. Don't allow deleting of System codes.
//***********************************************************************


/****************************Declaration Section***********************/
int lv_message_nbr

//***************************CONFIRMATION SECTION**********************
//Prints a confirmation box and finds out what button was pressed.
//********************************************************************

// MikeFl 8/5/02 - Track 3228 - BEGIN
//If sle_type.text = 'DP' and &
//	 (sle_code_code.text = 'SYSADD' or sle_code_code.text = 'SYSRECLS' OR &
//	  sle_code_code.text = 'SYSORCLS' or sle_code_code.text = 'SYSDELET' or &
//	  sle_code_code.text = 'REFERRED'	) THEN
//	Messagebox('EDIT','Cannot Delete System Controlled Dispositions')
//	setfocus(sle_code_code)
//	RETURN
//End IF

IF (sle_type.text = 'DP' OR sle_type.text = 'SA') &
AND integer(sle_numeric.text) > 0 THEN
	Messagebox('EDIT','Cannot Delete System Codes')
	RETURN
END IF
// MikeFl 8/5/02 - Track 3228 - END

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


/*Deletes the CD row from the database*/

DELETE FROM Code 
	WHERE CODE_TYPE = Upper( :sle_type.text ) and
			CODE_CODE = Upper( :sle_code_code.text )
	using Stars2ca;

if stars2ca.of_check_status() = 100 Then
	messagebox('Error','Record Not Found,Deletion cancelled',stopsign!)
	setfocus(sle_type)
	setmicrohelp(w_main,'Ready')
	return
elseif stars2ca.sqlcode <> 0 Then
	errorbox(stars2ca,'Error deleting from the Code Table')
	setfocus(sle_code_code)
	setmicrohelp(w_main,'Ready')
	return
end if

COMMIT Using Stars2ca;

SetMicroHelp(w_main,'Deletion Complete')

cb_clear.TriggerEvent(clicked!)
end event

type cb_update from u_cb within w_code_maint
string accessiblename = "Update"
string accessibledescription = "Update"
integer x = 393
integer y = 1292
integer width = 338
integer height = 108
integer taborder = 70
string text = "&Update"
end type

event clicked;                 //***CLICKED FOR CB_UPDATE***//

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- 	-------------------------------------------------------- 
// 10/19/93 SWD  	Created
// 12/28/93 FNC  	Update CODE_DESC table when code table is updated
// 01/11/01	GaryR	Stars 4.7 DataBase Port - Empty String in SQL
// 03/16/01	GaryR	Stars 4.7 DataBase Port - Case Sensitivity
//	11/13/01	GaryR	Track 2535d	Code Description is case insensitive
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
if isnumber(sle_numeric.text) = FALSE Then
	SetMicroHelp(w_main,'Update Cancelled')
	messagebox('Error','Numeric Value has to be a number'+ &
						  '~rPlease Enter a Numeric value',Stopsign!)	
	SetFocus(sle_numeric)
	return
end if

//Archana 4-17-00 Fs/Ts 2325c		**Begin**
int rc
rc = fw_edit_code_code()
if rc = -1 then
	SetMicroHelp (w_main,'Update Cancelled')
	setfocus(sle_code_code)
	Return
End if
//Archana 4-17-00 Fs/Ts 2325c			**End**

//************************THE UPDATE SECTION***************************
//This section does the actual update to the specified row.  It also does
//sql error checking.
//********************************************************************


//sqlcmd('Connect',stars2ca,'Error connecting to the database',5)  // FDG 10/20/95

// 01/11/01	GaryR	Stars 4.7 DataBase Port		// FDG 04/16/01
IF Trim( sle_text.text ) = "" THEN sle_text.text = ls_empty

UPDATE CODE
	SET CODE_DESC = :mle_descr.text, 		// 03/16/01	GaryR	Stars 4.7 DataBase Port		//	11/13/01	GaryR	Track 2535d
		 CODE_VALUE_A = :sle_text.text, 
		 CODE_VALUE_N = :lv_numeric
	WHERE (CODE_TYPE = Upper( :sle_type.text ) ) and 
			(CODE_CODE = Upper( :sle_code_code.text ) )
using stars2ca;

IF stars2ca.of_check_status() <> 0 Then
	SetMicroHelp(w_main,'Error Updating the Code Table, Update Cancelled')
   errorbox(stars2ca,'Error Updating the Code table')
	setfocus(sle_type)
	RETURN
end if 

COMMIT Using Stars2ca;							// FDG 10/20/95
IF Stars2ca.of_check_status()	<	0		THEN			// FDG 10/20/95
	ErrorBox(Stars2ca,'Error on COMMIT')	// FDG 10/20/95
END IF												// FDG 10/20/95


SetMicroHelp(w_main,'Update Complete')



end event

type cb_retrieve from u_cb within w_code_maint
string accessiblename = "Retrieve"
string accessibledescription = "Retrieve"
integer x = 32
integer y = 1292
integer width = 338
integer height = 108
integer taborder = 60
string text = "&Retrieve"
boolean default = true
end type

event clicked;//                    ***CLICKED FOR CB_RETRIEVE***

//***********************************************************************
//   Date   Init               Description of Changes Made                
// -------- ---- -------------------------------------------------------- 
// 10/19/93 SWD  Created
// 06-28-95 FNC  Change the way chkcode is called
//***********************************************************************


int rc
string lv_indx_ind,lv_table_type,lv_null_arg

SetPointer(hourglass!)
SetMicroHelp(w_main,'Retrieving record from Dictionary Table')	  

//****************************VALID CODE SECTION****************************
//This section makes sure that the code id being entered is a valid one.  If 
//it is not then it displays an error message and forces the user to enter
//a valid one.
//*************************************************************************

rc = chkcode('CD',sle_type.text,lv_null_arg)

if rc = -1 Then
	messagebox('Error','An Invalid Code Type was entered~r'+&
   						 'Please enter or choose a valid one'&
				  ,stopsign!,ok!)
	SetFocus(sle_type)
	setmicrohelp(w_main,'Ready')
	return
end if

if rc = -2 Then     //06-28-95 FNC Start
	messagebox("Error","Error Reading the Code table to verify code type.~r"+&
   						 "Please contact the system administrator. "&
				  ,stopsign!,ok!)
	SetFocus(sle_type)
	setmicrohelp(w_main,'Ready')
	return
end if              //06-28-95 FNC End

rc = chkcode(sle_type.text,sle_code_code.text,lv_null_arg)

if rc = -1 Then
	messagebox('Error','An Invalid Code id was entered~r'+&
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

// MIkeFL - Track 3228 - Code out this code and allow the retrieve but disallow the delete.
//If sle_type.text = 'DP' and &
//	 (sle_code_code.text = 'SYSADD' or sle_code_code.text = 'SYSRECLS' OR &
//	  sle_code_code.text = 'SYSORCLS' or sle_code_code.text = 'SYSDELET') THEN
//	Messagebox('EDIT','Cannot Retrieve System Controlled Dispositions')
//	setfocus(sle_code_code)
//	setmicrohelp(w_main,'Ready')
//	RETURN
//End IF

//***************************ACTUAL RETRIEVAL SECTION************************
//This Section finds the information based off the keys and puts it in the 
//appropiate sle's.  It then does sql error checking
//************************************************************************
 
SELECT CODE_TYPE,CODE_CODE,Code_DESC,CODE_VALUE_A,CODE_VALUE_N 
Into   :sle_type.text,:sle_code_code.text,:mle_descr.text,
		 :sle_text.text,:sle_numeric.text
		 From code
Where (CODE_TYPE = Upper( :sle_type.text ) ) and
		(Code_code = Upper( :sle_code_code.text ) ) 
Using stars2ca;

If stars2ca.of_check_status() = 100 Then
	SetMicroHelp(w_main,'Retrieve Cancelled')
	COMMIT Using Stars2ca;							// FDG 10/20/95
	messagebox('Not Found','Selection not found, Cannot be retrieved',StopSign!)
	sle_code_code.text = ''
	setfocus(sle_type)
	RETURN
elseIF stars2ca.sqlcode <> 0 Then
	SetMicroHelp(w_main,'Error retrieving from the Code Table, Retrieve Cancelled')
   errorbox(stars2ca,'Error retrieving from Code Table, Retrieve Cancelled')
	setfocus(sle_type)
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
sle_type.enabled = FALSE
sle_code_code.enabled = FALSE


SetMicroHelp(w_main,'Retrieve Complete')

end event

type cb_exit from u_cb within w_code_maint
string accessiblename = "Close"
string accessibledescription = "Close"
integer x = 2199
integer y = 1292
integer width = 338
integer height = 108
integer taborder = 120
string text = "&Close"
end type

on clicked;close(parent)
end on

