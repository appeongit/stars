HA$PBExportHeader$u_nvo_winapi_functions.sru
$PBExportComments$Windows API Functions - Ancestor (inherited from n_base) <logic>
forward
global type u_nvo_winapi_functions from n_base
end type
end forward

global type u_nvo_winapi_functions from n_base
end type
global u_nvo_winapi_functions u_nvo_winapi_functions

type prototypes

end prototypes

forward prototypes
public function integer of_playsound (string as_filename, integer ai_options)
public function unsignedlong of_getsyscolor (integer ai_index)
public function integer of_getscreenwidth ()
public function integer of_getscreenheight ()
public function unsignedlong of_getfreememory ()
public function integer of_getmoduleusage (unsignedinteger aui_inst)
public function unsignedinteger of_getdrivetype (integer ai_drive)
public function unsignedinteger of_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size)
public function unsignedinteger of_getsystemdirectory (ref string as_dir, unsignedinteger aui_size)
public function unsignedinteger of_getfreesystemresources (integer parm)
public function boolean of_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger of_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function unsignedinteger of_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function integer of_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
public function boolean of_iswindowvisible (long aui_handle)
public function boolean of_flash_window (long aui_handle, boolean ab_flash)
public function integer of_get_logon_name (ref string as_name)
public function unsignedlong of_get_logon_time ()
public function string of_getos_mode ()
public function boolean of_showwindow (unsignedinteger aui_hwnd, integer ai_ncmd)
public function boolean of_isiconic (unsignedinteger aui_hwmd)
public function boolean of_bringwindowtotop (unsignedinteger aui_hwnd)
public function unsignedinteger of_findwindow (string as_classname, string as_windowname)
public function unsignedinteger of_setactivewindow (unsignedinteger aui_hwnd)
public function integer of_getclassname (integer ai_hwnd, string as_classname, integer ai_maxcount)
public function unsignedlong of_getmodulehandle (string as_name)
public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width)
end prototypes

public function integer of_playsound (string as_filename, integer ai_options);Return -1
end function

public function unsignedlong of_getsyscolor (integer ai_index);Return 0
end function

public function integer of_getscreenwidth ();Return -1
end function

public function integer of_getscreenheight ();Return -1
end function

public function unsignedlong of_getfreememory ();Return 0
end function

public function integer of_getmoduleusage (unsignedinteger aui_inst);//	NOTE: THIS FUNCTION DOES NOT EXIST IN 32-BIT MODE

Return -1

end function

public function unsignedinteger of_getdrivetype (integer ai_drive);Return 0
end function

public function unsignedinteger of_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size);Return 0
end function

public function unsignedinteger of_getsystemdirectory (ref string as_dir, unsignedinteger aui_size);Return 0
end function

public function unsignedinteger of_getfreesystemresources (integer parm);Return 0
end function

public function boolean of_killtimer (long aui_handle, unsignedinteger aui_id);Return False
end function

public function unsignedinteger of_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);Return 0
end function

public function unsignedinteger of_getwindow (long aui_handle, unsignedinteger aui_relationship);Return 0
end function

public function integer of_getwindowtext (long aui_handle, ref string as_text, integer ai_max);Return 0
end function

public function boolean of_iswindowvisible (long aui_handle);Return false
end function

public function boolean of_flash_window (long aui_handle, boolean ab_flash);Return false
end function

public function integer of_get_logon_name (ref string as_name);Return -1
end function

public function unsignedlong of_get_logon_time ();Return 0
end function

public function string of_getos_mode ();//	NOTE: THIS FUNCTION DOES NOT EXIST IN 32-BIT MODE

Return ""
end function

public function boolean of_showwindow (unsignedinteger aui_hwnd, integer ai_ncmd);Return FALSE

end function

public function boolean of_isiconic (unsignedinteger aui_hwmd);Return FALSE

end function

public function boolean of_bringwindowtotop (unsignedinteger aui_hwnd);Return FALSE

end function

public function unsignedinteger of_findwindow (string as_classname, string as_windowname);Return 0

end function

public function unsignedinteger of_setactivewindow (unsignedinteger aui_hwnd);Return 0

end function

public function integer of_getclassname (integer ai_hwnd, string as_classname, integer ai_maxcount);Return -1

end function

public function unsignedlong of_getmodulehandle (string as_name);Return 0
end function

public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width);//	Function not found in descendent

Return -1
end function

on u_nvo_winapi_functions.create
call super::create
end on

on u_nvo_winapi_functions.destroy
call super::destroy
end on

