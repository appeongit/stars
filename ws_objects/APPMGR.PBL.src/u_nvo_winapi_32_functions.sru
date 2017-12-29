$PBExportHeader$u_nvo_winapi_32_functions.sru
$PBExportComments$Windows API 32 Bit Functions (inherited from u_nvo_winapi_functions) <logic>
forward
global type u_nvo_winapi_32_functions from u_nvo_winapi_functions
end type
end forward

type str_memorystatus from structure
    unsignedlong sul_dwlength
    unsignedlong sul_dwmemoryload
    unsignedlong sul_dwtotalphys
    unsignedlong sul_dwavailphys
    unsignedlong sul_dwtotalpagefile
    unsignedlong sul_dwavailpagefile
    unsignedlong sul_dwtotalvirtual
    unsignedlong sul_dwavailvirtual
end type

type os_size from structure
	long		l_cx
	long		l_cy
end type

global type u_nvo_winapi_32_functions from u_nvo_winapi_functions
end type
global u_nvo_winapi_32_functions u_nvo_winapi_32_functions

type prototypes
//playsound
Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "WINMM.DLL"
Function uint waveOutGetNumDevs () Library "WINMM.DLL"

//getsyscolor
Function ulong GetSysColor (int index) Library "USER32.DLL"

//getsystemmetrics
Function int GetSystemMetrics (int index) Library "USER32.DLL"

//getfreememory
Subroutine GlobalMemoryStatus (ref str_memorystatus memorystatus ) Library "KERNEL32.DLL"

//set and kill timer
Function Boolean KillTimer (long handle, uint id ) library "USER32.DLL"
Function uint SetTimer (long handle, uint id, uint time, long addr ) library "USER32.DLL"

//GetModuleHandle
Function long GetModuleHandleA(string modname) Library "KERNEL32.DLL"

Function boolean FlashWindow (long handle, boolean flash) Library "USER32.DLL"
Function uint GetWindow (long handle,uint relationship) Library "USER32.DLL"
Function int GetWindowTextA(long handle, ref string wintext, int length) Library "USER32.DLL"
Function boolean IsWindowVisible (long handle) Library "USER32.DLL"
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL"
Function uint GetDriveTypeA (string drive) library "KERNEL32.DLL"

Function boolean GetUserNameA (ref string name, ref ulong len) library "ADVAPI32.DLL"
Function ulong GetTickCount ( ) Library "KERNEL32.DLL"

// Get text size
Function uint GetDC(uint hWnd) Library "USER32.DLL"
Function uint ReleaseDC(uint hWnd, uint hdcr) Library "USER32.DLL"
Function boolean GetTextExtentPoint32A(uint hdcr, string lpString, integer nCount, ref os_size size) Library "GDI32.DLL"
Function uint SelectObject(uint hdc, uint hWnd) Library "GDI32.DLL"


Function UInt FindWindow (String ClassName, String WindowName) Library "USER32.DLL"
Function UInt SetActiveWindow (Uint hWnd) Library "USER32.DLL"
Function Boolean ShowWindow (Uint hWnd, Integer nCmd) Library "USER32.DLL"
Function Boolean IsIconic (Uint hWnd) Library "USER32.DLL"
Function Boolean BringWindowToTop (Uint hWnd) Library "USER32.DLL"
Function Int GetClassName (integer hWnd, string lbClassName, Integer nMaxCount) Library "USER32.DLL"

end prototypes

forward prototypes
public function integer of_playsound (string as_filename, integer ai_option)
public function unsignedlong of_getsyscolor (integer ai_index)
public function integer of_getscreenwidth ()
public function integer of_getscreenheight ()
public function uint of_getsystemdirectory (ref string as_dir, uint aui_size)
public function uint of_getdrivetype (int ai_drive)
public function unsignedinteger of_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size)
public function unsignedlong of_getfreememory ()
public function integer of_get_logon_name (ref string as_name)
public function unsignedlong of_get_logon_time ()
public function boolean of_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger of_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function boolean of_flash_window (long aui_handle, boolean ab_flash)
public function unsignedinteger of_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function boolean of_iswindowvisible (long aui_handle)
public function integer of_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
public function unsignedinteger of_findwindow (string as_classname, string as_windowname)
public function unsignedinteger of_setactivewindow (unsignedinteger aui_hwnd)
public function boolean of_showwindow (unsignedinteger aui_hwnd, integer ai_ncmd)
public function boolean of_isiconic (unsignedinteger aui_hwnd)
public function boolean of_bringwindowtotop (unsignedinteger aui_hwnd)
public function integer of_getclassname (integer ai_hwnd, string as_classname, integer ai_maxcount)
public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width)
end prototypes

public function integer of_playsound (string as_filename, integer ai_option);//Options as defined in mmystem.h These may be or'd together.

//#define SND_SYNC            0x0000  /* play synchronously (default) */
//#define SND_ASYNC           0x0001  /* play asynchronously */
//#define SND_NODEFAULT       0x0002  /* don't use default sound */
//#define SND_MEMORY          0x0004  /* lpszSoundName points to a memory file */
//#define SND_LOOP            0x0008  /* loop the sound until next sndPlaySound */
//#define SND_NOSTOP          0x0010  /* don't stop any currently playing sound */    



uint lui_numdevs


lui_numdevs = WaveOutGetNumDevs() 
If lui_numdevs > 0 Then 
	sndPlaySoundA(as_filename,ai_option)
	return 1
Else
	return -1
End If
end function

public function unsignedlong of_getsyscolor (integer ai_index);//GetsysColor in win32
Return GetSysColor (ai_index)
end function

public function integer of_getscreenwidth ();Return GetSystemMetrics(0)
end function

public function integer of_getscreenheight ();Return GetSystemMetrics(1)
end function

public function uint of_getsystemdirectory (ref string as_dir, uint aui_size);Return GetSystemDirectoryA(as_dir,aui_size)
end function

public function uint of_getdrivetype (int ai_drive);//drive types
Return GetDriveTypeA(Char(ai_drive + Asc ('A')) + ":\")
end function

public function unsignedinteger of_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size);Return GetWindowsDirectoryA(as_dir,aui_size)
end function

public function unsignedlong of_getfreememory ();//return # bytes free memory

str_memorystatus lstr_memory

//structure size is 8 ulong's or 8 * 4 bytes
lstr_memory.sul_dwlength = 32

GlobalMemoryStatus(lstr_memory)

//bytes of virtual memory available
Return (lstr_memory.sul_dwavailpagefile)
end function

public function integer of_get_logon_name (ref string as_name);//user win32 getusername

string ls_temp 
ulong lul_value =255
boolean lb_rc
ls_temp = string(255)
lb_rc = GetUserNameA(ls_temp,lul_value)
If lb_rc Then
	as_name = ls_temp
	Return 1
Else 
	Return -1
End If
end function

public function unsignedlong of_get_logon_time ();//use win32 gettickcount() for time logged in

Return GetTickCount()
end function

public function boolean of_killtimer (long aui_handle, unsignedinteger aui_id);//win32 to kill timer
Return KillTimer(aui_handle,aui_id)
end function

public function unsignedinteger of_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);//win 32 call to create timer
Return SetTimer(aui_handle,aui_id,aui_time,0)

end function

public function boolean of_flash_window (long aui_handle, boolean ab_flash);//function not found in descendent
Return FlashWindow(aui_handle, ab_flash)
end function

public function unsignedinteger of_getwindow (long aui_handle, unsignedinteger aui_relationship);//function not found
Return GetWindow(aui_handle,aui_relationship)
end function

public function boolean of_iswindowvisible (long aui_handle);Return IsWindowVisible(aui_handle)
end function

public function integer of_getwindowtext (long aui_handle, ref string as_text, integer ai_max);//function not found
Return GetWindowTextA (aui_handle,as_text,ai_max)
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

public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTextSize
//
//	Access:  public
//
//	Arguments:  
//	aw_obj:  Window where temporary text will be created
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
UInt			lui_Hdc, lui_Handle, lui_hFont
os_size 		lstr_Size

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

	// Get the size of the text.
	If Not GetTextExtentpoint32A(lui_Hdc, as_Text, li_Len, lstr_Size ) Then Return -1

	ai_Height = lstr_Size.l_cy
	ai_Width = lstr_Size.l_cx

	ReleaseDC(lui_Handle, lui_Hdc)

	li_Return = aw_obj.CloseUserObject(lst_Temp)
End if

Return li_Return

end function

on u_nvo_winapi_32_functions.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_winapi_32_functions.destroy
TriggerEvent( this, "destructor" )
end on

