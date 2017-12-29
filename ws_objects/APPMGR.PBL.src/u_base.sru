$PBExportHeader$u_base.sru
$PBExportComments$All custom visual user objects are inherited from this object. <gui>
forward
global type u_base from UserObject
end type
end forward

global type u_base from UserObject
string accessiblename = "Base User Object"
string accessibledescription = "Base User Object"
accessiblerole accessiblerole = clientrole!
int Width=2533
int Height=1517
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event documentation ( )
end type
global u_base u_base

on u_base.create
end on

on u_base.destroy
end on

