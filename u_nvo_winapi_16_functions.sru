HA$PBExportHeader$u_nvo_winapi_16_functions.sru
$PBExportComments$Windows API 16 Bit Functions (inherited from u_nvo_winapi_functions) <logic>
forward
global type u_nvo_winapi_16_functions from u_nvo_winapi_functions
end type
end forward

global type u_nvo_winapi_16_functions from u_nvo_winapi_functions
end type
global u_nvo_winapi_16_functions u_nvo_winapi_16_functions

type prototypes
//playsound
Function boolean sndPlaySound (string SoundName, uint Flags) Library "mmsystem.dll"
Function uint waveOutGetNumDevs () Library "mmsystem.dll"

//getsyscolor
Function ulong GetSysColor (int index) Library "user.exe"

//getsystem width/height
Function int GetSystemMetrics(int index) Library "user.exe"

//getfreememory
Function ulong GetFreeSpace(uint dummy) Library "kernel.exe"

//get os mode
Function ulong GetWinFlags () Library "kernel.exe"

//Settimer KillTimer
Function boolean KillTimer (uint handle, uint id) library "user.exe"
Function uint SetTimer (uint handle, uint id, uint time, long addr) library "user.exe"

//get free system resources
Function uint Getfreesystemresources (uint resource) Library "user.exe"

//module handle
Function uint GetModuleHandle(string ModName) Library "kernel.exe"
Function integer GetModuleUsage (uint Handle) Library "kernel.exe"

Function boolean FlashWindow (uint handle, boolean flash) Library "user.exe"
Function uint GetWindow (uint handle,uint relationship) Library "user.exe"
Function int GetWindowText(uint handle, ref string wintext, int length) Library "user.exe"
Function boolean IsWindowvisible (uint handle) Library "user.exe"
Function uint GetWindowsDirectory (ref string dirtext, uint textlen) library "kernel.exe"
Function uint GetSystemDirectory (ref string dirtext, uint textlen) library "kernel.exe"
Function uint GetDriveType (int drive) library "kernel.exe"

function ulong GetTickCount() library "USER.EXE"
function int WNetGetUser(ref string User, ref uint UserLength) library "user.exe"

Function UInt FindWindow (String ClassName, String WindowName) Library "user.exe"
Function UInt SetActiveWindow (Uint hWnd) Library "user.exe"
Function Boolean ShowWindow (Uint hWnd, Integer nCmd) Library "user.exe"
Function Boolean IsIconic (Uint hWnd) Library "user.exe"
Function Boolean BringWindowToTop (Uint hWnd) Library "user.exe"
Function Int GetClassName (Integer hWnd, String lbClassName, Integer nMaxCount) Library "user.exe"

// Get text size
Function uint GetDC  (uint hWnd) Library "USER.EXE"
Function uint ReleaseDC (uint hWnd, uint hdcr) Library "USER.EXE"
Function ulong GetTextExtent (uint hdcr, string lpString, integer nCount) Library "GDI.EXE"
Function uint SelectObject (uint hdc, uint hWnd) Library "GDI.EXE"

end prototypes

forward prototypes
public function int of_getscreenwidth ()
public function int of_getscreenheight ()
public function string of_getos_mode ()
public function unsignedlong of_getfreememory ()
public function integer of_getmoduleusage (unsignedinteger aui_modhandle)
public function uint of_getsystemdirectory (ref string as_dir, uint aui_size)
public function unsignedinteger of_getdrivetype (integer ai_drive)
public function unsignedinteger of_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size)
public function unsignedlong of_get_logon_time ()
public function boolean of_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger of_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function integer of_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
public function boolean of_flash_window (long aui_handle, boolean ab_flash)
public function unsignedinteger of_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function boolean of_iswindowvisible (long aui_handle)
public function integer of_get_logon_name (ref string as_name)
public function unsignedinteger of_getfreesystemresources (integer ai_parm)
public function integer of_playsound (string as_filename, integer ai_option)
public function unsignedlong of_getsyscolor (integer ai_index)
public function unsignedinteger of_findwindow (string as_classname, string as_windowname)
public function unsignedinteger of_setactivewindow (unsignedinteger aui_hwnd)
public function boolean of_showwindow (unsignedinteger aui_hwnd, integer ai_ncmd)
public function boolean of_isiconic (unsignedinteger aui_hwnd)
public function boolean of_bringwindowtotop (unsignedinteger aui_hwnd)
public function integer of_getclassname (integer ai_hwnd, string as_classname, integer ai_maxcount)
public function unsignedlong of_getmodulehandle (string as_modname)
public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width)
end prototypes

public function int of_getscreenwidth ();Return GetSystemMetrics(0)
end function

public function int of_getscreenheight ();return getSystemMetrics(1)
end function

public function string of_getos_mode ();/*
	GetWinFlags Returns a double word of binary encoded values.
	If the 6th bit is turned on, then the system is 386 enhanced mode
	If the 5th bit is turned on, then the system is standard mode
	else its in Real Mode
*/

String	ls_temp 
ULong		ll_winflags

ll_winflags = GetWinFlags()

If Mod(Int (ll_winflags / 32), 2) > 0 Then
	ls_temp = "Enhanced Mode"
ElseIf Mod( Int(ll_winflags / 16) , 2) > 0 Then
	ls_temp =  "Standard Mode"
Else
	ls_temp = "Real Mode"
End If

Return ls_temp
end function

public function unsignedlong of_getfreememory ();Return GetFreeSpace(0)
end function

public function integer of_getmoduleusage (unsignedinteger aui_modhandle);Return GetModuleUsage(aui_modhandle)

end function

public function uint of_getsystemdirectory (ref string as_dir, uint aui_size);Return GetSystemDirectory(as_dir,aui_size)
end function

public function unsignedinteger of_getdrivetype (integer ai_drive);Return GetDriveType(ai_drive)
end function

public function unsignedinteger of_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size);Return GetWindowsDirectory(as_dir, aui_size)
end function

public function unsignedlong of_get_logon_time ();Return GetTickCount()

end function

public function boolean of_killtimer (long aui_handle, unsignedinteger aui_id);Return KillTimer(aui_handle,aui_id)
end function

public function unsignedinteger of_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);Return(SetTimer(aui_handle, aui_id, aui_time, 0))
end function

public function integer of_getwindowtext (long aui_handle, ref string as_text, integer ai_max);Return GetWindowText (aui_handle, as_text, ai_max)
end function

public function boolean of_flash_window (long aui_handle, boolean ab_flash);Return FlashWindow(aui_handle, ab_flash)
end function

public function unsignedinteger of_getwindow (long aui_handle, unsignedinteger aui_relationship);Return GetWindow(aui_handle, aui_relationship)
end function

public function boolean of_iswindowvisible (long aui_handle);Return IsWindowVisible(aui_handle)
end function

public function integer of_get_logon_name (ref string as_name);UInt		lui_len = 255
Integer	li_rc
String	ls_temp

ls_temp	= Space(lui_len)
li_rc		= WNetGetUser(ls_temp, lui_len)

as_name = ls_temp

Return li_rc
end function

public function unsignedinteger of_getfreesystemresources (integer ai_parm);Return GetFreeSystemResources(ai_parm)
end function

public function integer of_playsound (string as_filename, integer ai_option);/*
	Options as defined in mmystem.h These may be or'd together.

	#define SND_SYNC            0x0000  /* play synchronously (default) */
	#define SND_ASYNC           0x0001  /* play asynchronously */
	#define SND_NODEFAULT       0x0002  /* don't use default sound */
	#define SND_MEMORY          0x0004  /* lpszSoundName points to a memory file */
	#define SND_LOOP            0x0008  /* loop the sound until next sndPlaySound */
	#define SND_NOSTOP          0x0010  /* don't stop any currently playing sound */    
*/

If WaveOutGetNumDevs() < 1 Then Return -1 

sndPlaySound(as_filename, ai_option)

Return 1

end function

public function unsignedlong of_getsyscolor (integer ai_index);Return GetSysColor (ai_index)
end function

public function unsignedinteger of_findwindow (string as_classname, string as_windowname);Return FindWindow (as_classname, as_windowname)

end function

public function unsignedinteger of_setactivewindow (unsignedinteger aui_hwnd);Return SetActiveWindow (aui_hwnd)

end function

public function boolean of_showwindow (unsignedinteger aui_hwnd, integer ai_ncmd);Return ShowWindow (aui_hwnd, ai_ncmd)

end function

public function boolean of_isiconic (unsignedinteger aui_hwnd);Return IsIconic (aui_hwnd)

end function

public function boolean of_bringwindowtotop (unsignedinteger aui_hwnd);Return BringWindowToTop (aui_hwnd)

end function

public function integer of_getclassname (integer ai_hwnd, string as_classname, integer ai_maxcount);Return GetClassName (ai_hwnd, as_classname, ai_maxcount)

end function

public function unsignedlong of_getmodulehandle (string as_modname);Return GetModuleHandle(as_modname)
end function

public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTextSize
//
//	Access:  public
//
//	Arguments:  
//	aw_obj:   Window where temporary text will be created
//	as_Text						The text to be sized.
//	as_FontFace				The font used.
//	ai_FontSize				The point size of the font.
//	ab_Bold						True - Bold, False - Normal.
//	ab_Italic					True - Yes, False - No.
//	ab_Underline				True - Yes, False - No.
//	ai_Height					the height of the object in pixels
//	ai_Width					the width of the object in pixels
//
//
//	Returns:  Integer			1 if successful, -1 if an error occurrs
//	
//
//	Description:  Calculates the size of a text object in pixels
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_Size, li_Height, li_Width, li_Len, li_Return, &
				li_WM_GETFONT = 49 	//  hex 0x0031
StaticText	lst_Temp
ULong		lul_Size
UInt			lui_Hdc, lui_Handle, lui_hFont &

// Datawindow syntax specifies font point size is negative
li_Size = -1 * ai_FontSize

if IsNull(aw_obj) Or Not IsValid (aw_obj) then
	return -1
end if

// Create a dummy StaticText Object on the window
// containing text with the desired characteristics
li_Return = aw_obj.OpenUserObject(lst_Temp)
If li_Return = 1 Then
	lst_Temp.FaceName = as_FontFace
	lst_Temp.TextSize = li_Size
	If ab_Bold Then
		lst_Temp.Weight = 700
	Else
		lst_Temp.Weight = 400
	End If
	lst_Temp.Italic = ab_Italic
	lst_Temp.Underline = ab_Underline

	li_Len = Len(as_Text)

	// Get the handle of the StaticText Object and create a Device Context
	lui_Handle = Handle(lst_Temp)
	lui_Hdc = GetDC(lui_Handle)

	// Get the font in use on the Static Text
	lui_hFont = Send(lui_Handle, li_WM_GETFONT, 0, 0)

	// Select it into the device context
	SelectObject(lui_Hdc, lui_hFont)

	// Get the size of the text.  This function returns a double word -
	// the low order word is the width, the high order word is the height.
	lul_Size = GetTextExtent(lui_Hdc, as_Text, li_Len)
	ai_Height = IntHigh(lul_Size)
	ai_Width = IntLow(lul_Size)

	ReleaseDC(lui_Handle, lui_Hdc)

	li_Return = aw_obj.CloseUserObject(lst_Temp)
End if

Return li_Return

end function

on u_nvo_winapi_16_functions.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_winapi_16_functions.destroy
TriggerEvent( this, "destructor" )
end on

