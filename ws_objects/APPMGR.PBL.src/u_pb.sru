$PBExportHeader$u_pb.sru
$PBExportComments$Ancestor picturebutton <gui>
forward
global type u_pb from picturebutton
end type
end forward

global type u_pb from picturebutton
string accessiblename = "Picture Button User Object"
string accessibledescription = "Picture Button User Object"
long textcolor = 33554432
long backcolor = 67108864
accessiblerole accessiblerole = pushbuttonrole!
int Width=192
int Height=160
int TabOrder=10
Alignment HTextAlign=Left!
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pb u_pb

forward prototypes
public function uo_query of_getuoquery ()
public function integer of_getparentwindow (ref window aw_window)
end prototypes

public function uo_query of_getuoquery ();//************************************************************************
//	Script:	u_cb.of_getuoquery
//
//	Arguments:	None
//
//	Returns:		uo_query 
//
//	Description:	Get the handle to uo_query for this object
//
//************************************************************************

PowerObject		lpo_parent
uo_query			luo_query
Tab				ltab

Boolean			lb_found	=	FALSE

//	Loop getting the parent of the object until it is a window

lpo_parent	=	This.GetParent ()

DO WHILE lb_found =	FALSE		AND	IsValid (lpo_parent)
	IF	lpo_parent.TypeOf ()				=	Tab!		THEN
		ltab									=	lpo_parent
		IF	Upper ( Trim (ltab.Tag) )	>	'  '		THEN
			lb_found	=	TRUE
			luo_query	=	lpo_parent
			Return	luo_query
			Exit
		END IF
	END IF
	lpo_parent	=	lpo_parent.GetParent ()
LOOP

SetNull (luo_query)

Return	luo_query

end function

public function integer of_getparentwindow (ref window aw_window);//************************************************************************
//	Script:	u_pb.of_getparentwindow
//
//	Arguments:	aw_window (by reference) 
//
//	Returns:	Integer -	1 = ok
//								-1 = unsuccessful
//
//	Description:	Get the parent window of this object
//
//************************************************************************

PowerObject		lpo_parent

//	Loop getting the parent of the object until it is a window

lpo_parent	=	This.GetParent ()

DO WHILE lpo_parent.TypeOf ()	<>	Window!	AND	IsValid (lpo_parent)
	lpo_parent	=	lpo_parent.GetParent ()
LOOP

IF	NOT	IsValid (lpo_parent)		THEN
	SetNull (aw_window)
	Return -1
END IF

aw_window	=	lpo_parent

Return 1

end function

