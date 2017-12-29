HA$PBExportHeader$w_definition.srw
$PBExportComments$Inherited from w_master
forward
global type w_definition from w_master
end type
type cb_1 from u_cb within w_definition
end type
type st_descr_and_code from statictext within w_definition
end type
type mle_code_description from multilineedit within w_definition
end type
type cb_lookup from u_cb within w_definition
end type
end forward

global type w_definition from w_master
string accessiblename = "Definition"
string accessibledescription = "Definition"
accessiblerole accessiblerole = windowrole!
integer x = 1659
integer y = 672
integer width = 1513
integer height = 616
string title = "Definition"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
cb_1 cb_1
st_descr_and_code st_descr_and_code
mle_code_description mle_code_description
cb_lookup cb_lookup
end type
global w_definition w_definition

type variables
boolean in_lookup

//	07/08/02	GaryR	Track 3181d
String	is_code_type
end variables

event open;call super::open;//Code Lookup open script
/////////////////////////////////////////////////////////////
//
//	GaryR		07/08/02	Track 3181d	Accomodate expanded code type.
// JasonS 	08/01/02 Track 3216d Display rm lookup on user id's
// Mikefl 	09/27/02	Track 3130d Replace All references to 'LK' code types with 'CD'
// Mikefl 	10/28/02	Track 3356d Some lookups not working - minor rewrite
// JasonS   03/20/03 Track 3216d Removed a redundant if block at the end that 
//											was left hanging there
//	GaryR		06/03/03	Track 5497c	Prevent DB error if duplicate pats/provs detected
//	GaryR		04/01/04	Track 3516c	Prevent lookup if Prov ID not found
//	GaryR		06/01/05	Track 4408d	Remove code description from code
// Katie		01/23/07	SPR 4766 Handle lookups of 'NPI' type
//	Katie		03/27/07 SPR 4963 Removed obsolete lv_lookup_from logic
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
/////////////////////////////////////////////////////////////

string lv_add1,lv_add2,lv_add3,lv_city,lv_state,lv_zip
string lv_status,lv_phone
string lv_code_id
string lv_county, lv_name, ls_lname
Integer	li_pos

is_code_type = gv_code_to_use		//	07/08/02	GaryR	Track 3181d

lv_code_id = gv_code_id_to_use

// Remove decoded value
li_pos = Pos( lv_code_id, " - " )
IF li_pos > 0 THEN lv_code_id = Left( lv_code_id, li_pos - 1 )

w_definition.x = gv_win_x_pos
w_definition.y = gv_win_y_pos

// MikeF 10/28/02 Track 3356 - Begin
IF is_code_type = 'UP~~L' THEN
	is_code_type	= 'UP'
END IF

CHOOSE CASE is_code_type

	// JasonS 08/01/02 Begin - Track 3216d
	CASE 'USERS'

		st_descr_and_code.text = 'User ID ' + lv_code_id
	
		SELECT USERS.USER_F_NAME, USERS.USER_L_NAME
		INTO :lv_name, :ls_lname
  		FROM USERS  
		WHERE USER_ID = Upper( :lv_code_id )
		USING Stars2ca;
	
		if (stars2ca.of_check_status()=100) then
			messagebox('Not Found','The User ID was not found in the Users Table.~r'+&
						  'The lookup is cancelled')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return	
		elseif (stars2ca.sqlcode<>0) Then
			errorbox(stars2ca,'Error Reading the Users Table')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return 
		end if
		
		mle_code_description.text = lv_name + " " + ls_lname
		cb_lookup.enabled = false
	// JasonS 08/01/02 End - Track 3216d

CASE 'NPI'
		if gv_npi_cntl > 0 then 
			gv_from = "NPI"
		
			gv_prov_npi = lv_code_id
	
			this.hide()
			cb_1.postevent(clicked!)
			opensheet (w_provider_list,MDI_MAIN_FRAME,HELP_MENU_POSITION,Layered!)
		else
			Select Code_desc into :st_descr_and_code.text 
			From Code
			Where Code_Type = 'CD' and
					Code_code = Upper( :is_code_type )
			using stars2ca;
				
			if (stars2ca.of_check_status()=100) then
				COMMIT Using Stars2ca;							// FDG 10/20/95
				This.visible = false
				cb_1.PostEvent(Clicked!)
				return	
			elseif (stars2ca.sqlcode<>0) Then
				errorbox(stars2ca,'Error Reading the Code Table')
				this.visible = false
				cb_1.PostEvent(Clicked!)
				return 
			end if
	
			st_descr_and_code.text += " " + lv_code_id
	
			cb_lookup.enabled = true   // JasonS 08/01/02 - Track 3216d
			
			Select 	Code_DESC into :mle_code_description.text 
			FROM 		Code
			Where 	Code_Type = Upper( :is_code_type ) and	//Upper( :lv_type ) //	07/08/02	GaryR	Track 3181d
						Code_code = Upper( :lv_code_id )
			Using stars2ca;
			
			if (stars2ca.of_check_status()=100) then
				COMMIT Using Stars2ca;							// FDG 10/20/95
				messagebox('NOT FOUND','The Code was not found in the Lookup Table.~r'+&
											  'The lookup is cancelled')
				this.visible = false
				cb_1.PostEvent(Clicked!)
				return	
			elseif (stars2ca.sqlcode<>0) Then
				errorbox(stars2ca,'Error Reading the Code Table')
				this.visible = false
				cb_1.PostEvent(Clicked!)
				return 
			end if
		
			COMMIT Using Stars2ca;
		end if
		
	CASE 'PV'
		
		gv_from = "PV"
	
		gv_prov_id = lv_code_id

		this.hide()
		cb_1.postevent(clicked!)
		opensheet (w_provider_list,MDI_MAIN_FRAME,HELP_MENU_POSITION,Layered!)
		
	CASE 'UP'
		
		gv_from = "UP"
	
		gv_prov_upin = lv_code_id
		//DJP 7/17/95 prob#536 - have to post to close this window
		this.hide()
		cb_1.postevent(clicked!)
		opensheet (w_provider_list,MDI_MAIN_FRAME,HELP_MENU_POSITION,Layered!)
		
	CASE 'RI'

		st_descr_and_code.text = 'Patient ID ' + lv_code_id

		Select PATIENT_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,
					 CITY,STATE,ZIP,COUNTY,TELEPHONE
			into :lv_name,:lv_add1,:lv_add2,:lv_add3,:lv_city,:lv_state,:lv_zip,&
				  :lv_county,:lv_phone
			FROM ENROLLEE
			Where RECIP_ID= Upper( :lv_code_id )
			Using stars2ca;
		
		IF gnv_sql.of_is_multiple_select( Stars2ca ) THEN
			MessageBox( "Duplicate", "More than one Patient ID detected in the Enrollee file" )
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return	
		elseif (stars2ca.of_check_status()=100) then
			COMMIT Using Stars2ca;
			messagebox('Not Found','The Patient ID was not found in the Lookup Table.~r'+&
									  'The lookup is cancelled')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return	
		elseif (stars2ca.sqlcode<>0) Then
			errorbox(stars2ca,'Error Reading the Enrollee Table')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return 
		end if
	
		mle_code_description.text = lv_name + '~r~n'  
		
		IF trim(lv_add1) <> '' THEN
			mle_code_description.text = mle_code_description.text + lv_add1+'~r~n'
		END IF
		
		IF trim(lv_add2) <> '' THEN
			mle_code_description.text = mle_code_description.text + lv_add2+'~r~n'
		END IF
		
		IF trim(lv_add3) <> '' THEN
			mle_code_description.text = mle_code_description.text + lv_add3+'~r~n'
		END IF
		
		mle_code_description.text 	= mle_code_description.text + lv_city + ', ' + lv_state + ' ' + lv_zip + '~r~n'

		IF trim(lv_status) <> '' THEN
			mle_code_description.text = mle_code_description.text + lv_status+'~r~n'
		END IF

		IF trim(lv_phone) <> '' THEN
			mle_code_description.text = mle_code_description.text + lv_phone
		END IF
	
	CASE ELSE

		Select Code_desc into :st_descr_and_code.text 
		From Code
		Where Code_Type = 'CD' and
				Code_code = Upper( :is_code_type )
		using stars2ca;
			
		if (stars2ca.of_check_status()=100) then
			COMMIT Using Stars2ca;							// FDG 10/20/95
			This.visible = false
			cb_1.PostEvent(Clicked!)
			return	
		elseif (stars2ca.sqlcode<>0) Then
			errorbox(stars2ca,'Error Reading the Code Table')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return 
		end if

		st_descr_and_code.text += " " + lv_code_id

		cb_lookup.enabled = true   // JasonS 08/01/02 - Track 3216d
		
		Select 	Code_DESC into :mle_code_description.text 
		FROM 		Code
		Where 	Code_Type = Upper( :is_code_type ) and	//Upper( :lv_type ) //	07/08/02	GaryR	Track 3181d
					Code_code = Upper( :lv_code_id )
		Using stars2ca;
		
		if (stars2ca.of_check_status()=100) then
			COMMIT Using Stars2ca;							// FDG 10/20/95
			messagebox('NOT FOUND','The Code was not found in the Lookup Table.~r'+&
										  'The lookup is cancelled')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return	
		elseif (stars2ca.sqlcode<>0) Then
			errorbox(stars2ca,'Error Reading the Code Table')
			this.visible = false
			cb_1.PostEvent(Clicked!)
			return 
		end if
	
		COMMIT Using Stars2ca;

END CHOOSE

// MikeF 10/28/02 Track 3356 - End

gv_code_id_to_use = ''

end event

on w_definition.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_descr_and_code=create st_descr_and_code
this.mle_code_description=create mle_code_description
this.cb_lookup=create cb_lookup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_descr_and_code
this.Control[iCurrent+3]=this.mle_code_description
this.Control[iCurrent+4]=this.cb_lookup
end on

on w_definition.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_descr_and_code)
destroy(this.mle_code_description)
destroy(this.cb_lookup)
end on

type cb_1 from u_cb within w_definition
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 1253
integer y = 12
integer width = 224
integer height = 96
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;close(parent)
end on

type st_descr_and_code from statictext within w_definition
string accessiblename = "Code Type Description and Code ID"
string accessibledescription = "Code Type Description and Code ID"
long textcolor = 33554432
accessiblerole accessiblerole = statictextrole!
integer x = 18
integer y = 32
integer width = 933
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean enabled = false
end type

type mle_code_description from multilineedit within w_definition
string accessiblename = "Code Description"
string accessibledescription = "Code Description"
long textcolor = 33554432
accessiblerole accessiblerole = textrole!
integer x = 18
integer y = 128
integer width = 1458
integer height = 368
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 1073741824
boolean vscrollbar = true
integer limit = 255
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_lookup from u_cb within w_definition
string accessiblename = "Lookup"
string accessibledescription = "Lookup"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 997
integer y = 12
integer width = 238
integer height = 96
integer taborder = 10
integer textsize = -8
string facename = "MS Sans Serif"
string text = "&Lookup"
boolean default = true
end type

event clicked;in_lookup = TRUE

//	07/08/02	GaryR	Track 3181d
gv_code_to_use = is_code_type
// 07/22/02 MikeFl Track 3181d
gv_from = 'lookup'

open (w_code_lookup)
in_lookup = FALSE


end event

