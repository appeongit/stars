HA$PBExportHeader$n_cst_wspell.sru
$PBExportComments$This is the wrapper for the spell checking DLL <logic>
forward
global type n_cst_wspell from n_base
end type
end forward

global type n_cst_wspell from n_base autoinstantiate
end type

type prototypes
///////////////////////////////////////////////////////////////////////////
//
//	Note, if SSCE external function contains a string parameter,
//	you must append the function with the ALIAS FOR "<FunctionName>;ANSI"
//
///////////////////////////////////////////////////////////////////////////
//
//	12/02/08	GaryR	SPR 4376	Use the Sentry Spell Checking Engine DLL
//
///////////////////////////////////////////////////////////////////////////


PROTECTED:

Function ulong FindWindowEx( ulong hwndParent, ulong hwndChildAfter, string lpszClass, long lpszWindow ) LIBRARY "user32.dll" ALIAS FOR "FindWindowExW"
Function integer SSCE_SetKey(long key) library "SSCE5532.DLL"
Function integer SSCE_SetIniFile(ref string fileName) library "SSCE5532.DLL" ALIAS FOR "SSCE_SetIniFile;ANSI"
Function integer SSCE_CheckCtrlDlg(ulong parentWin, ulong ctrlWin, integer selectedOnly) Library "SSCE5532.DLL" 
end prototypes

forward prototypes
public function integer of_check_rte (w_master aw_parent, u_rte a_rte)
public function integer of_set_ini ()
end prototypes

public function integer of_check_rte (w_master aw_parent, u_rte a_rte);//	12/02/08	GaryR	SPR 4376	Use the Sentry Spell Checking Engine DLL

ulong		hWin, hRTE
Integer	li_rc

//	Get the parent window handle
hWin = Handle ( aw_parent )

//	Get the RTE handle
hRTE = Handle ( a_rte )
hRTE = FindWindowEx ( hRTE, 0, "PBTxTextControl", 0 )
hRTE = FindWindowEx ( hRTE, 0, "AfxOleControl42u", 0 )
hRTE = FindWindowEx ( hRTE, 0, "TX13P", 0 )

li_rc = SSCE_CheckCtrlDlg( hWin, hRTE, 0) 

Return li_rc
end function

public function integer of_set_ini ();//	12/02/08	GaryR	SPR 4376	Use the Sentry Spell Checking Engine DLL

String	ls_path, ls_file, ls_separator = "\"
String	ls_values[]
Integer	li_rc
ContextKeyword lcxk_base

//	Get the path to the Common Files
GetContextService( "Keyword", lcxk_base )
li_rc = lcxk_base.GetContextKeywords( "CommonProgramFiles", ls_values )
IF li_rc < 1 THEN
	//	If not found, default to C:
	ls_path = "C:\Program Files\Common Files"
END IF

//	Set the ini path
ls_path = ls_values[1]
IF Right( ls_path, 1 ) <> ls_separator THEN ls_path += ls_separator
ls_file = ls_path + "SSCE\ssce.ini"

//	Validate path
li_rc = SSCE_SetIniFile( ls_file )
IF li_rc < 1 THEN
	MessageBox( "Spelling Checker", "Error Code = " + String( li_rc ) + &
	"    Unable to locate the initialization file @~n~r" + ls_file )
	Return -1
END IF

Return 1
end function

event constructor;call super::constructor;//	11/06/08	GaryR	SPR 4376	Provide spell checking facility in Notes
//	12/02/08	GaryR	SPR 4376	Use the Sentry Spell Checking Engine DLL

CONSTANT	Long lcl_lic_key = 1506386779
Integer	li_rtn

//	Set the license key
li_rtn = This.SSCE_SetKey( lcl_lic_key )

li_rtn = This.of_set_ini()
end event

on n_cst_wspell.create
call super::create
end on

on n_cst_wspell.destroy
call super::destroy
end on

