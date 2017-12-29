HA$PBExportHeader$n_cst_resize.sru
$PBExportComments$Window Resize service (inherited from n_base) <logic>
forward
global type n_cst_resize from n_base
end type
type os_resize from structure within n_cst_resize
end type
end forward

type os_resize from structure
	powerobject		classdefinition
	graphicobject		wo_control
	string		s_classname
	string		s_typeof
	boolean		b_scale
	boolean		b_movex
	boolean		b_movey
	boolean		b_scalewidth
	boolean		b_scaleheight
	real		r_x
	real		r_y
	real		r_width
	real		r_height
	integer		i_widthmin
	integer		i_heightmin
	integer		i_movex
	integer		i_movey
	integer		i_scalewidth
	integer		i_scaleheight
end type

global type n_cst_resize from n_base
event type integer pfc_resize ( unsignedlong aul_sizetype,  integer ai_newwidth,  integer ai_newheight )
end type
global n_cst_resize n_cst_resize

type variables
//////////////////////////////////////////////////////////////////////
Protected:

constant string  ics_dragobject = 'dragobject!'
constant string  ics_line = 'line!'
constant string  ics_oval = 'oval!'
constant string  ics_rectangle = 'rectangle!'
constant string  ics_roundrectangle = 'roundrectangle!'
constant string ics_mdiclient = 'mdiclient!'

long 	il_parentminimumwidth=0
long	il_parentminimumheight=0
long	il_parentprevwidth=-1
long	il_parentprevheight=-1

//xz 12/16/96
real         ir_ratiowidth
real         ir_ratioheight

os_resize	istr_registered[]

//////////////////////////////////////////////////////////////////////
end variables

forward prototypes
public function integer of_unregister (windowobject awo_control)
protected function string of_typeof (windowobject awo_control)
public function integer of_register (windowobject awo_control, string as_method)
public function integer of_setminsize (integer ai_minwidth, integer ai_minheight)
public function integer of_setorigsize (integer ai_width, integer ai_height)
public function integer of_getminmaxpoints (windowobject awo_control[], ref integer ai_min_x, ref integer ai_min_y, ref integer ai_max_x, ref integer ai_max_y)
protected function integer of_resize (integer ai_newwidth, integer ai_newheight)
public function integer of_getobjectxy (string as_ClassName, ref real ar_x, ref real ar_y)
public function real of_getratiowidth ()
public function real of_getratioheight ()
public function integer of_get_height_width (string as_classname, ref real ar_height, ref real ar_width)
end prototypes

event pfc_resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//		Send resize notification to services.
//
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	01/25/99	Track 2073c.  If minimizing the window, do not resize
//						the controls.
//
//////////////////////////////////////////////////////////////////////////////

// FDG 01/25/99 begin
IF	 ai_newwidth	=	0			&
AND ai_newheight	=	0			THEN
	Return	0
END IF
// FDG 01/25/99 end

Return of_Resize(ai_newwidth, ai_newheight)

end event

public function integer of_unregister (windowobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister	
//
//	Access:  		public
//
//	Arguments:		
//	awo_control		The control to unregister.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////

integer			li_upperbound
integer			li_cnt
integer			li_registered_slot

//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) Then
	Return -1
End If

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Get the current UpperBound
li_upperbound = UpperBound (istr_registered[])

//Find the registered object
li_registered_slot = 0
For li_cnt = 1 to li_upperbound
	If istr_registered[li_cnt].wo_control = awo_control Then
		li_registered_slot = li_cnt
		exit
	End If
Next

//If the control was not previously registered, return
//an error code.
If li_registered_slot = 0 Then
	Return -1
End If

//Unregister the control
SetNull(istr_registered[li_registered_slot].wo_control)
istr_registered[li_registered_slot].s_typeof = ''
istr_registered[li_registered_slot].b_movex = False
istr_registered[li_registered_slot].b_movey = False
istr_registered[li_registered_slot].b_scalewidth = False
istr_registered[li_registered_slot].b_scaleheight = False
istr_registered[li_registered_slot].i_movex = 0
istr_registered[li_registered_slot].i_movey = 0
istr_registered[li_registered_slot].i_scalewidth = 0
istr_registered[li_registered_slot].i_scaleheight = 0


Return 1

end function

protected function string of_typeof (windowobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_TypeOf
//
//	Access:  		protected
//
//	Arguments:		
//	awo_control		The window object for which a type is needed.
//
//	Returns:  		string
//						Describes the type of the object.
//						'!' if an error occurs.
//
//	Description:  	Determines on the type of an object for the purposes of 
//						getting to its attributes.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) Then
	Return '!'
End If

//Validate and set typeof value
Choose Case awo_control.TypeOf()
	Case checkbox!, commandbutton!, datawindow!, dropdownlistbox!, &
			dropdownpicturelistbox!, graph!, groupbox!, hscrollbar!, listbox!, &
			picturelistbox!, listview!, multilineedit!, editmask!, picture!, &
			picturebutton!, radiobutton!, richtextedit!, singlelineedit!, statictext!, &
			tab!, treeview!, userobject!, vscrollbar!, omcontrol!, omcustomcontrol!, &
			olecustomcontrol!, omembeddedcontrol!, olecontrol!
		Return ics_dragobject 
	Case line!
		Return ics_line
	Case oval!
		Return ics_oval
	Case rectangle!
		Return ics_rectangle
	Case roundrectangle!
		Return ics_roundrectangle
	Case mdiclient!
		Return ics_mdiclient
End Choose

Return '!'
end function

public function integer of_register (windowobject awo_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	awo_control		The window object being registered.
//	as_method		The desired resize/move method.
//						Valid values are:
//						 'FixedToRight'
//						 'FixedToBottom'
//						 'FixedToRight&Bottom'
//						 'Scale'
//						 'ScaleToRight'
//						 'ScaleToBottom'
//						 'ScaleToRight&Bottom'
//						 'FixedToRight&ScaleToBottom'
//						 'FixedToBottom&ScaleToRight'
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.  The action taken on this
//						control depends on the four attributes: ab_movex, ab_movey,
//						ab_scalewidth, and ab_scaleheight.
//						Note: the service object needs to be initialized (of_SetOrigSize())
//						prior to	any registering (this function) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	10/09/03	GaryR	Track 5915c	Do not register objects with NO RESIZE in tag
//
//////////////////////////////////////////////////////////////////////////////

dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
boolean			lb_movex=False, lb_movey=False
boolean			lb_scalewidth=False, lb_scaleheight=False
boolean			lb_scale=False


//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) or IsNull(as_method) Then
	Return -1
End If

//Check tag
IF Pos( Upper( awo_control.tag ), "NO RESIZE" ) > 0 THEN Return 1

//Translate and finish validating parameteters
Choose Case Lower(as_method)
	Case Lower('FixedToRight')
		lb_movex = True
	Case Lower('FixedToBottom')
		lb_movey = True
	Case Lower('FixedToRight&Bottom')
		lb_movex = True
		lb_movey = True
	Case Lower('Scale')
		lb_scale = True
	Case Lower('ScaleToRight')
		lb_scalewidth = True
	Case Lower('ScaleToBottom')
		lb_scaleheight = True
	Case Lower('ScaleToRight&Bottom')
		lb_scalewidth = True
		lb_scaleheight = True
	Case Lower('FixedToRight&ScaleToBottom')		
		lb_movex = True		
		lb_scaleheight = True				
	Case Lower('FixedToBottom&ScaleToRight')	
		lb_movey = True
		lb_scalewidth = True		
Case Else
		Return -1
End Choose

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Get the previous Bound
li_upperbound = UpperBound (istr_registered[])

//Determine if there is an open slot available other than a
//new entry on the array
li_slot_available = 0
For li_cnt = 1 to li_upperbound
	IF	IsNull(istr_registered[li_cnt].wo_control)		Or	&
		Not IsValid(istr_registered[li_cnt].wo_control) Then
		If li_slot_available = 0 Then
			//Get the first slot found
			li_slot_available = li_cnt
		End If
	Else
		//Check if control has already been registered
		If istr_registered[li_cnt].wo_control = awo_control Then
			Return -1
		End If
	End If
Next

//If an available slot was not found then create a new entry
If li_slot_available = 0 Then
	li_slot_available = li_upperbound + 1
End If

///////////////////////////////////////////////////////////////////////////////////////
//Register the new object
///////////////////////////////////////////////////////////////////////////////////////

//Validate and set typeof value
Choose Case of_TypeOf(awo_control)
	Case ics_dragobject
		//Store a reference to the control
		ldrg_cntrl = awo_control
		//Store the type of the control to speed access to its attributes
		istr_registered[li_slot_available].s_typeof = ics_dragobject		
		//Store the position and size of control
		li_x = ldrg_cntrl.X
		li_y = ldrg_cntrl.Y
		li_width = ldrg_cntrl.Width
		li_height = ldrg_cntrl.Height
	Case ics_line
		ln_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = ics_line		
		li_x = ln_cntrl.BeginX
		li_y = ln_cntrl.BeginY
		li_width = ln_cntrl.EndX
		li_height = ln_cntrl.EndY
	Case ics_oval
		loval_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = ics_oval			
		li_x = loval_cntrl.X
		li_y = loval_cntrl.Y
		li_width = loval_cntrl.Width
		li_height = loval_cntrl.Height		
	Case ics_rectangle
		lrec_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = ics_rectangle		
		li_x = lrec_cntrl.X
		li_y = lrec_cntrl.Y
		li_width = lrec_cntrl.Width
		li_height = lrec_cntrl.Height		
	Case ics_roundrectangle
		lrrec_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = ics_roundrectangle				
		li_x = lrrec_cntrl.X
		li_y = lrrec_cntrl.Y
		li_width = lrrec_cntrl.Width
		li_height = lrrec_cntrl.Height		
	Case Else
		//An unknown control type has been encountered
		Return -1
End Choose

//Register the actual object
istr_registered[li_slot_available].wo_control = awo_control
istr_registered[li_slot_available].s_classname = awo_control.ClassName()

//Set the behavior attributes
istr_registered[li_slot_available].b_movex = lb_movex
istr_registered[li_slot_available].b_movey = lb_movey
istr_registered[li_slot_available].b_scalewidth = lb_scalewidth
istr_registered[li_slot_available].b_scaleheight = lb_scaleheight
istr_registered[li_slot_available].b_scale = lb_scale

//Set the initial position/size attributes
istr_registered[li_slot_available].r_x = li_x
istr_registered[li_slot_available].r_y = li_y
istr_registered[li_slot_available].r_width = li_width
istr_registered[li_slot_available].r_height = li_height

Return 1

end function

public function integer of_setminsize (integer ai_minwidth, integer ai_minheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetMinSize
//
//	Access:  		public
//
//	Arguments:		
//	ai_minwidth		The minimum width for the parent object.
//	ai_minheight	The minimum height for the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Sets the current object minimum size attributes.
//						Note: the service object needs to be initialized (of_SetOrigSize())
//						prior to	setting the Minimum size of the object.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If	IsNull(ai_minwidth) or IsNull(ai_minheight) Then
	Return -1
End If

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Set the minimum values for the width and height
il_parentminimumwidth = ai_minwidth
il_parentminimumheight = ai_minheight

Return 1

end function

public function integer of_setorigsize (integer ai_width, integer ai_height);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetOrigSize
//
//	Access:  		public
//
//	Arguments:		
//	ai_width			The current width of the parent object.
//	ai_height		The current height of the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Initializes the Resize object by setting the current object
//						size.
//						Note: the service object needs to be initialized (this function)
//						prior to	the registering (of_register()) of objects.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ai_width) or IsNull(ai_height) Then
	Return -1
End If

//Set the current width and height
il_parentprevwidth = ai_width
il_parentprevheight = ai_height

Return 1

end function

public function integer of_getminmaxpoints (windowobject awo_control[], ref integer ai_min_x, ref integer ai_min_y, ref integer ai_max_x, ref integer ai_max_y);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetMinMaxPoints
//
//	Access:  		public
//
//	Arguments:		
//	awo_control[]	The control array for whom the Min and Max attributes are needed.
//	ai_min_x			The minimum X point found by looking at the X attributes of all
//							the controls on the control array (by reference).
//	ai_min_y			The minimum Y point found by looking at the X attributes of all
//							the controls on the control array (by reference).
//	ai_max_x			The maximum X point found by adding the X and Width attributes
//							of all the controls on the control array (by reference).
//	ai_max_y			The maximum Y point found by adding the Y and Height attributes
//							of all the controls on the control array (by reference).
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Determines the four extreme points of the controls within a 
//						control array by looking at the X, Y, Width, Height, BeginX, 
//						BeginY, EndX, EndY attributes.
//
//////////////////////////////////////////////////////////////////////////////

dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

integer			li_x, li_y, li_width, li_height, li_temp
integer			li_upperbound
integer			li_cnt

//Check arguments
If IsNull(awo_control) or IsNull(awo_control[]) or UpperBound(awo_control[])=0 Then
	Return -1
End If

//Initialize
ai_min_x=32767
ai_min_y=32767
ai_max_x=0
ai_max_y=0

//Get the Control upper bound
li_upperbound = UpperBound (awo_control[])

//Determine position of the right most and bottom most control.
For li_cnt = 1 to li_upperbound
	If IsValid(awo_control[li_cnt]) Then
		Choose Case of_TypeOf(awo_control[li_cnt])
			Case ics_dragobject
				//Set a reference to the control.
				ldrg_cntrl = awo_control[li_cnt]
				//Get the position, width, and height of the control.
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case ics_line
				ln_cntrl = awo_control[li_cnt]
				li_x = ln_cntrl.BeginX
				li_y = ln_cntrl.BeginY
				li_width = ln_cntrl.EndX
				li_height = ln_cntrl.EndY
				//Correct for lines that may have the End points 
				//before to the Begin points.
				If li_width >= li_x Then
					li_width = li_width - li_x
				Else
					li_temp = li_x
					li_x = li_width
					li_width = li_temp - li_x
				End If	
				If li_height >= li_y Then
					li_height = li_height - li_y
				Else
					li_temp = li_y
					li_y = li_height
					li_height = li_temp - li_y
				End If
			Case ics_oval
				loval_cntrl = awo_control[li_cnt]
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height		
			Case ics_rectangle
				lrec_cntrl = awo_control[li_cnt]
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height		
			Case ics_roundrectangle
				lrrec_cntrl = awo_control[li_cnt]
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height
			Case ics_mdiclient
				Continue
			Case Else
				//An unknown control type has been encountered
				Return -1
		End Choose
		
		//Determine the Min and Max points
		If li_x < ai_min_x Then ai_min_x = li_x
		If li_y < ai_min_y Then ai_min_y = li_y
		If li_x + li_width > ai_max_x Then ai_max_x = li_x + li_width
		If li_y + li_height > ai_max_y Then ai_max_y = li_y + li_height
		
	End If
Next


Return 1

end function

protected function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Resize
//
//	Access:  		protected
//
//	Arguments:		
//	ai_newwidth		The new width of the parent object.
//	ai_newheight	The new height of the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Moves or resizes objects that were registered with the service.
//						Performs the actions that were requested via the
//						of_SetOrigSize() and of_Register functions.
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//Note: For the line control: the width and height variables are
//										used to hold EndX and EndY attributes.
//////////////////////////////////////////////////////////////////////////////

//Temporary controls to get to attributes
dragobject		ldrg_cntrl
oval				loval_cntrl
line				lln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

//Local variables
integer			li_upperbound
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight

constant int	lci_rounding = 5

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Check the parameters
If IsNull(ai_newwidth) or IsNull(ai_newheight) Then
	return -1
End If

//Prevent the contents of the windows from resizing past the min width/height
If ai_newwidth < il_parentminimumwidth   Then ai_newwidth = il_parentminimumwidth
If ai_newheight < il_parentminimumheight Then ai_newheight = il_parentminimumheight

//Set the deltas/ratios for the width and height as compared to the previous size
li_deltawidth  = ai_newwidth  - il_parentprevwidth 
li_deltaheight = ai_newheight - il_parentprevheight
If il_parentprevwidth=0 Then il_parentprevwidth=1
If il_parentprevheight=0 Then il_parentprevheight=1	
lr_ratiowidth  = ai_newwidth  / il_parentprevwidth
lr_ratioheight = ai_newheight / il_parentprevheight

//xz 12/16/96 save the ratio width and height to an instance variable
ir_ratiowidth = lr_ratiowidth
ir_ratioheight = lr_ratioheight

//Only continue if the size has changed
If li_deltawidth=0 And li_deltaheight=0 Then Return 1

//Set the new previous size
il_parentprevwidth = ai_newwidth
il_parentprevheight = ai_newheight

///////////////////////////////////////////////////////////////////////////////////////////////
// Loop through all registered controls - Moving and resizing as appropriate
///////////////////////////////////////////////////////////////////////////////////////////////

//Loop trough all controls
li_upperbound = UpperBound (istr_registered[])
For li_cnt = 1 to li_upperbound
	
	//Initialize variables
	li_x = 0
	li_y = 0 
	li_width = 0
	li_height = 0
	lr_move_deltax = 0	
	lr_move_deltay = 0
	lr_resize_deltawidth = 0	
	lr_resize_deltaheight = 0	
	SetNull(ldrg_cntrl)
	SetNull(loval_cntrl)
	SetNull(lln_cntrl)
	SetNull(lrec_cntrl)
	SetNull(lrrec_cntrl)
	
	If IsValid(istr_registered[li_cnt].wo_control) Then
		
		//Get attribute information from the appropriate control
		Choose Case istr_registered[li_cnt].s_typeof
			Case ics_dragobject 
				ldrg_cntrl = istr_registered[li_cnt].wo_control
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case ics_line
				// For the line control, the width and height variables 
				// are used to hold EndX and EndY attributes
				lln_cntrl = istr_registered[li_cnt].wo_control
				li_x = lln_cntrl.BeginX
				li_y = lln_cntrl.BeginY
				li_width = lln_cntrl.EndX
				li_height = lln_cntrl.EndY
			Case ics_oval
				loval_cntrl = istr_registered[li_cnt].wo_control
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height		
			Case ics_rectangle
				lrec_cntrl = istr_registered[li_cnt].wo_control
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height
			Case ics_roundrectangle
				lrrec_cntrl = istr_registered[li_cnt].wo_control			
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height				
			Case Else
				Return -1
		End Choose
		
		//Correct for any rounding or moving/resizing of objects trough
		//any other means
		If abs(istr_registered[li_cnt].r_x - li_x) > lci_rounding Then
			istr_registered[li_cnt].r_x = li_x
		End If				
		If abs(istr_registered[li_cnt].r_y - li_y) > lci_rounding Then
			istr_registered[li_cnt].r_y = li_y
		End If		
		If abs(istr_registered[li_cnt].r_width - li_width) > lci_rounding And &
		   li_width > istr_registered[li_cnt].i_widthmin Then
			istr_registered[li_cnt].r_width = li_width
		End If							
		If abs(istr_registered[li_cnt].r_height - li_height) > lci_rounding And &
		   li_height > istr_registered[li_cnt].i_heightmin Then
			istr_registered[li_cnt].r_height = li_height
		End If			
		
		//Define the deltas for this control:  Move and Resize
		If istr_registered[li_cnt].b_scale Then
			lr_move_deltax = (istr_registered[li_cnt].r_x * lr_ratiowidth) - istr_registered[li_cnt].r_x
			lr_move_deltay = (istr_registered[li_cnt].r_y * lr_ratioheight) - istr_registered[li_cnt].r_y
			lr_resize_deltawidth = (istr_registered[li_cnt].r_width * lr_ratiowidth) - istr_registered[li_cnt].r_width
			lr_resize_deltaheight = (istr_registered[li_cnt].r_height * lr_ratioheight) - istr_registered[li_cnt].r_height
		Else
			If istr_registered[li_cnt].b_movex Then lr_move_deltax = li_deltawidth
			If istr_registered[li_cnt].b_movey Then lr_move_deltay = li_deltaheight
			If istr_registered[li_cnt].b_scalewidth Then lr_resize_deltawidth = li_deltawidth
			If istr_registered[li_cnt].b_scaleheight Then lr_resize_deltaheight = li_deltaheight
		End If

		//If appropriate move the control along the X and Y attribute.
		If lr_move_deltax <> 0 Or lr_move_deltay <> 0 Then	
			//Save the 'exact' X and Y attributes.
			istr_registered[li_cnt].r_x = istr_registered[li_cnt].r_x + lr_move_deltax		
			istr_registered[li_cnt].r_y = istr_registered[li_cnt].r_y + lr_move_deltay
			Choose Case istr_registered[li_cnt].s_typeof
				Case ics_dragobject 
					ldrg_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)
				Case ics_line
					//X moving
					lln_cntrl.BeginX = istr_registered[li_cnt].r_x
					istr_registered[li_cnt].r_width = istr_registered[li_cnt].r_width + lr_move_deltax					
					lln_cntrl.EndX = istr_registered[li_cnt].r_width
					//Y moving
					lln_cntrl.BeginY = istr_registered[li_cnt].r_y
					istr_registered[li_cnt].r_height = istr_registered[li_cnt].r_height + lr_move_deltay
					lln_cntrl.EndY = istr_registered[li_cnt].r_height					
				Case ics_oval
					loval_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)					
				Case ics_rectangle
					lrec_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)
				Case ics_roundrectangle
					lrrec_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)
			End Choose	
		End If /* Move */
		
		//If appropriate Resize the Width And Height of the control.
		//Performing one Resize instead of changing Width and Height individually.
		If lr_resize_deltawidth <> 0 Or lr_resize_deltaheight <> 0 Then		
			//Save the 'exact' Width and Height attributes.
			istr_registered[li_cnt].r_width = istr_registered[li_cnt].r_width + lr_resize_deltawidth	
			istr_registered[li_cnt].r_height = istr_registered[li_cnt].r_height + lr_resize_deltaheight		
			Choose Case istr_registered[li_cnt].s_typeof
				Case ics_dragobject 
					ldrg_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = ldrg_cntrl.Width
					li_height = ldrg_cntrl.Height
				Case ics_line
					lln_cntrl.EndX = istr_registered[li_cnt].r_width
				Case ics_oval
					loval_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = loval_cntrl.Width
					li_height = loval_cntrl.Height					
				Case ics_rectangle
					lrec_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = lrec_cntrl.Width
					li_height = lrec_cntrl.Height				
				Case ics_roundrectangle
					lrrec_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = lrrec_cntrl.Width
					li_height = lrrec_cntrl.Height					
			End Choose		
			
			//Determine if the object does not support the requested Width or Height.
			//Used to determine if the object was resized by any other means.
			If li_width > istr_registered[li_cnt].r_width Then
				istr_registered[li_cnt].i_widthmin = li_width
			Else
				istr_registered[li_cnt].i_widthmin = 0
			End If
			If li_height > istr_registered[li_cnt].r_height Then
				istr_registered[li_cnt].i_heightmin = li_height
			Else
				istr_registered[li_cnt].i_heightmin = 0
			End If					
		End If /* Resize */

	End If /* If IsValid(istr_registered[li_cnt].wo_control) Then */
Next /* For li_cnt = 1 to li_upperbound */

Return 1

end function

public function integer of_getobjectxy (string as_ClassName, ref real ar_x, ref real ar_y);//**********************************************************
//* This function returns the current x, y of a window control 
//* 
//* Arguments: string	as_ClassName by value
//*				real 		ar_x by reference
//*				real 		ar_y by reference
//*
//* return 1 if successful 
//**********************************************************
integer li_UpperBound, li_cnt

li_UpperBound = UpperBound(istr_registered[])

FOR li_cnt = 1 TO li_UpperBound
	IF IsValid(istr_registered[li_Cnt].wo_control) THEN
		IF (istr_registered[li_Cnt].s_ClassName = as_ClassName) THEN
			ar_x = istr_registered[li_Cnt].r_x
			ar_y = istr_registered[li_Cnt].r_y
			Return 1
		END IF
	END IF
NEXT

Return 0
end function

public function real of_getratiowidth ();Return ir_RatioWidth
end function

public function real of_getratioheight ();Return ir_RatioHeight
end function

public function integer of_get_height_width (string as_classname, ref real ar_height, ref real ar_width);//**********************************************************
//	Script:	of_get_height_width (Not in PFC)
//
// This function returns the current height & width of a 
// window control 
// 
// Arguments:	String	as_ClassName by value
//					Real 		ar_height by reference
//					Real 		ar_width by reference
//
// Returns:		Integer
//					1 if successful 
//					0 if control not registered
//**********************************************************

Integer	li_UpperBound,		&
			li_cnt

li_UpperBound = UpperBound(istr_registered[])

FOR li_cnt = 1 TO li_UpperBound
	IF IsValid(istr_registered[li_Cnt].wo_control) THEN
		IF (istr_registered[li_Cnt].s_ClassName = as_ClassName) THEN
			ar_height = istr_registered[li_Cnt].r_height
			ar_width = istr_registered[li_Cnt].r_width
			Return 1
		END IF
	END IF
NEXT

Return 0
end function

on n_cst_resize.create
call super::create
end on

on n_cst_resize.destroy
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  n_cst_resize
//
//	Description:
//	Resize service.
// XZ 12/16/96 added functions: of_GetObjectXY()
//										  of_GetRatioWidth()
//										  of_GetRatioHeight()
//					added instant variables ir_RatioWidth & ir_RatioHeight
//					added two lines in function of_ReSize to save lr_RatioWidth
//							& lr_RatioHeight to ir_RatioWidth & ir_RatioHeight
//////////////////////////////////////////////////////////////////////////////


end event

