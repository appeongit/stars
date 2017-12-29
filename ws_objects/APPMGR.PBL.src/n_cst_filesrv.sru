$PBExportHeader$n_cst_filesrv.sru
$PBExportComments$PFC File handler service (inherited from n_base) <logic>
forward
global type n_cst_filesrv from n_base
end type
type os_filedatetime from structure within n_cst_filesrv
end type
type os_systemtime from structure within n_cst_filesrv
end type
type os_securityattributes from structure within n_cst_filesrv
end type
type os_finddata from structure within n_cst_filesrv
end type
type os_fileopeninfo from structure within n_cst_filesrv
end type
type openfilename from structure within n_cst_filesrv
end type
end forward

type os_filedatetime from structure
	unsignedlong		ul_lowdatetime
	unsignedlong		ul_highdatetime
end type

type os_systemtime from structure
    uint ui_wYear
    uint ui_WMonth
    uint ui_WDayOfWeek
    uint ui_WDay
    uint ui_wHour
    uint ui_wMinute 
    uint ui_wSecond
    uint ui_wMilliseconds
end type

type os_securityattributes from structure
	ulong		ul_Length
	char		ch_description
	boolean	b_inherit
end type

type os_finddata from structure
	unsignedlong		ul_fileattributes
	os_filedatetime		str_creationtime
	os_filedatetime		str_lastaccesstime
	os_filedatetime		str_lastwritetime
	unsignedlong		ul_filesizehigh
	unsignedlong		ul_filesizelow
	unsignedlong		ul_reserved0
	unsignedlong		ul_reserved1
	character		ch_filename[260]
	character		ch_alternatefilename[14]
end type

type os_fileopeninfo from structure
	character		c_length
	character		c_fixed_disk
	uint		ui_dos_error
	uint		ui_na1
	uint		ui_na2
	character		c_pathname[128]
end type

type openfilename from structure
	unsignedlong		lstructsize
	unsignedlong		hwndowner
	unsignedlong		hinstance
	unsignedlong		lpstrfilter
	unsignedlong		lpstrcustomfilter
	unsignedlong		nmaxcustfilter
	unsignedlong		nfilterindex
	unsignedlong		lpstrfile
	unsignedlong		nmaxfile
	unsignedlong		lpstrfiletitle
	unsignedlong		nmaxfiletitle
	unsignedlong		lpstrinitialdir
	unsignedlong		lpstrtitle
	unsignedlong		flags
	integer		nfileoffset
	integer		nfileextension
	unsignedlong		lpstrdefext
	unsignedlong		lcustdata
	unsignedlong		lpfnhook
	unsignedlong		lptemplatename
end type

global type n_cst_filesrv from n_base
end type
global n_cst_filesrv n_cst_filesrv

type prototypes
// Win 32 calls
Function uint GetDriveTypeA (string drive) library "KERNEL32.DLL" ALIAS FOR "GetDriveTypeA;Ansi"
Function boolean CreateDirectoryA (ref string directoryname, ref os_securityattributes secattr) library "KERNEL32.DLL" ALIAS FOR "CreateDirectoryA;Ansi"
Function boolean RemoveDirectoryA (ref string directoryname) library "KERNEL32.DLL" ALIAS FOR "RemoveDirectoryA;Ansi"
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL" ALIAS FOR "GetCurrentDirectoryA;Ansi"
Function boolean SetCurrentDirectoryA (ref string directoryname ) library "KERNEL32.DLL" ALIAS FOR "SetCurrentDirectoryA;Ansi"
Function ulong GetFileAttributesA (ref string filename) library "KERNEL32.DLL" ALIAS FOR "GetFileAttributesA;Ansi"
Function boolean SetFileAttributesA (ref string filename, ulong attrib) library "KERNEL32.DLL" ALIAS FOR "SetFileAttributesA;Ansi"
Function boolean MoveFileA (ref string oldfile, ref string newfile) library "KERNEL32.DLL" ALIAS FOR "MoveFileA;Ansi"
Function long FindFirstFileA (ref string filename, ref os_finddata findfiledata) library "KERNEL32.DLL" ALIAS FOR "FindFirstFileA;Ansi"
Function boolean FindNextFileA (long handle, ref os_finddata findfiledata) library "KERNEL32.DLL" ALIAS FOR "FindNextFileA;Ansi"
Function boolean FindClose (long handle) library "KERNEL32.DLL" ALIAS FOR "FindClose;Ansi"
Function boolean GetDiskFreeSpaceA (string drive, ref long sectpercluster, ref long bytespersect, ref long freeclusters, ref long totalclusters) library "KERNEL32.DLL" ALIAS FOR "GetDiskFreeSpaceA;Ansi"
Function long GetLastError() library "KERNEL32.DLL" ALIAS FOR "GetLastError;Ansi"
Function ulong GetLongPathName(string lpShortPath, ref string lpLongPath, ulong nBufferLength) library "KERNEL32.DLL" ALIAS FOR "GetLongPathNameW"
Function ulong GetTempPathA(ulong nBufferLength, ref string lpBuffer) library "KERNEL32.DLL" ALIAS FOR "GetTempPathA;Ansi"
Function long ShellExecuteA( long hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, 	integer nShowCmd 	) Library "shell32.dll" ALIAS FOR "ShellExecuteA;Ansi"

// Win32 calls for file date and time
Function ulong OpenFile (ref string filename, ref os_fileopeninfo of_struct, uint action) LIBRARY "KERNEL32.DLL"
Function boolean CloseHandle (ulong file_hand) LIBRARY "KERNEL32.DLL"
Function boolean GetFileTime(long hFile, ref os_filedatetime  lpCreationTime, ref os_filedatetime  lpLastAccessTime, ref os_filedatetime  lpLastWriteTime  )  library "KERNEL32.DLL"
Function boolean FileTimeToSystemTime(ref os_filedatetime lpFileTime, ref os_systemtime lpSystemTime) library "KERNEL32.DLL"
Function boolean FileTimeToLocalFileTime(ref os_filedatetime lpFileTime, ref os_filedatetime lpLocalFileTime) library "KERNEL32.DLL"
Function boolean SetFileTime(ulong hFile, os_filedatetime  lpCreationTime, os_filedatetime  lpLastAccessTime, os_filedatetime  lpLastWriteTime  )  library "KERNEL32.DLL"
Function boolean SystemTimeToFileTime(os_systemtime lpSystemTime, ref os_filedatetime lpFileTime) library "KERNEL32.DLL"
Function boolean LocalFileTimeToFileTime(ref os_filedatetime lpLocalFileTime, ref os_filedatetime lpFileTime) library "KERNEL32.DLL"

// Win32 calls for GetSaveFileName dialog
Function boolean GetSaveFileName( Ref OPENFILENAME lpOFN ) Library "comdlg32.dll" Alias For "GetSaveFileNameW"
Function ulong CommDlgExtendedError() Library "comdlg32.dll"
Function long RtlMoveMemory( Ref char dest[], long source, long size ) Library "kernel32.dll"
Function long RtlMoveMemory( long dest, Ref char source[], long Size ) Library "kernel32.dll"
Function long LocalAlloc( long uFlags, long uBytes ) Library "kernel32.dll"
Function long LocalFree( long hMem ) Library "kernel32.dll"
end prototypes

type variables
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

// Window State Options
Constant Long SW_HIDE = 0
Constant Long SW_NORMAL = 1
Constant Long SW_SHOWMINIMIZED = 2
Constant Long SW_SHOWMAXIMIZED = 3
Constant Long SW_SHOWNOACTIVATE = 4
Constant Long SW_SHOW = 5
Constant Long SW_MINIMIZE = 6
Constant Long SW_SHOWMINNOACTIVE = 7
Constant Long SW_SHOWNA = 8
Constant Long SW_RESTORE = 9
Constant Long SW_SHOWDEFAULT = 10

// File Open Return Codes
Constant Long SE_ERR_FNF = 2       // file not found
Constant Long SE_ERR_PNF = 3       // path not found
Constant Long SE_ERR_ACCESSDENIED = 5       // access denied
Constant Long SE_ERR_OOM = 8       // out of memory
Constant Long SE_ERR_SHARE = 26
Constant Long SE_ERR_ASSOCINCOMPLETE = 27
Constant Long SE_ERR_DDETIMEOUT = 28
Constant Long SE_ERR_DDEFAIL = 29
Constant Long SE_ERR_DDEBUSY = 30
Constant Long SE_ERR_NOASSOC = 31
Constant Long SE_ERR_DLLNOTFOUND = 32
		
Protected:
String	is_Separator = "\"
String	is_AllFiles = "*.*"

Private:
CONSTANT ulong OFN_READONLY				= 1
CONSTANT ulong OFN_OVERWRITEPROMPT		= 2
CONSTANT ulong OFN_HIDEREADONLY			= 4
CONSTANT ulong OFN_NOCHANGEDIR			= 8
CONSTANT ulong OFN_SHOWHELP				= 16
CONSTANT ulong OFN_ENABLEHOOK				= 32
CONSTANT ulong OFN_ENABLETEMPLATE		= 64
CONSTANT ulong OFN_ENABLETEMPLATEHANDLE	= 128
CONSTANT ulong OFN_NOVALIDATE				= 256
CONSTANT ulong OFN_ALLOWMULTISELECT		= 512
CONSTANT ulong OFN_EXTENSIONDIFFERENT	= 1024
CONSTANT ulong OFN_PATHMUSTEXIST			= 2048
CONSTANT ulong OFN_FILEMUSTEXIST			= 4096
CONSTANT ulong OFN_CREATEPROMPT			= 8192
CONSTANT ulong OFN_SHAREAWARE				= 16384
CONSTANT ulong OFN_NOREADONLYRETURN		= 32768
CONSTANT ulong OFN_NOTESTFILECREATE		= 65536
CONSTANT ulong OFN_NONETWORKBUTTON		= 131072
CONSTANT ulong OFN_NOLONGNAMES			= 262144
CONSTANT ulong OFN_EXPLORER				= 524288
CONSTANT ulong OFN_NODEREFERENCELINKS	= 1048576
CONSTANT ulong OFN_LONGNAMES				= 2097152
end variables

forward prototypes
public function string of_GetSeparator ()
public function string of_assemblepath (string as_drive, string as_dirpath, string as_filename, string as_ext)
public function integer of_CreateDirectory (string as_directoryname)
public function string of_getcurrentdirectory ()
public function boolean of_DirectoryExists (string as_directoryname)
public function integer of_changedirectory (string as_newdirectory)
public function integer of_RemoveDirectory (string as_directoryname)
public function string of_AssemblePath (string as_Drive, string as_DirPath, string as_FileName)
public function integer of_FileCopy (string as_sourcefile, string as_targetfile, boolean ab_append)
public function long of_FileRead (string as_FileName, ref blob ablb_Data)
public function long of_FileRead (string as_filename, ref string as_text[])
public function integer of_FileWrite (string as_filename, string as_text, boolean ab_append)
public function integer of_FileWrite (string as_FileName, blob ablb_Data, boolean ab_Append)
public function integer of_FileWrite (string as_filename, string as_text)
public function integer of_FileWrite (string as_FileName, blob ablb_Data)
public function integer of_FileCopy (string as_SourceFile, string as_TargetFile)
public function integer of_FileRename (string as_sourcefile, string as_targetfile)
public function integer of_dirlist (string as_filespec, long al_filetype, ref n_cst_dirattrib anv_dirlist[])
public function integer of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
public function integer of_GetFileAttributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdirectory, ref boolean ab_archive)
public function integer of_SetFileReadonly (string as_filename, boolean ab_readonly)
public function integer of_SetFileHidden (string as_filename, boolean ab_hidden)
public function integer of_SetFileSystem (string as_filename, boolean ab_system)
public function integer of_SetFileArchive (string as_filename, boolean ab_archive)
public function string of_getlongfilename (string as_altfilename)
public function string of_getaltfilename (string as_longfilename)
public function double of_GetFileSize (string as_FileName)
protected function unsignedlong of_calculatefileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
protected function boolean of_includefile (string as_filename, long al_attribmask, unsignedlong aul_fileattrib)
public function integer of_GetLastwriteDatetime (string as_filename, ref date ad_date, ref time at_time)
public function integer of_GetCreationDatetime (string as_filename, ref date ad_date, ref time at_time)
public function integer of_GetLastwriteDate (string as_FileName, ref date ad_Date)
public function integer of_GetLastwriteTime (string as_FileName, ref time at_Time)
public function integer of_GetCreationTime (string as_FileName, ref time at_Time)
public function integer of_GetCreationDate (string as_filename, ref date ad_date)
public function integer of_getlastaccessdate (string as_filename, ref date ad_date)
public function integer of_setlastwritedatetime (string as_filename, date ad_date, time at_time)
public function integer of_setcreationdatetime (string as_filename, date ad_date, time at_time)
public function integer of_setlastaccessdate (string as_filename, date ad_date)
public function integer of_deltree (string as_directoryname)
public function integer of_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename, ref string as_ext)
public function integer of_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename)
public function integer of_sortdirlist (ref n_cst_dirattrib anv_dirlist[], integer ai_sorttype, boolean ab_ascending)
public function integer of_sortdirlist (ref n_cst_dirattrib anv_dirlist[], integer ai_sorttype)
public function integer of_GetDiskSpace (character ac_drive, ref long al_totalspace, ref long al_freespace)
public function integer of_GetDriveType (character ac_drive)
public function integer of_getvolumes (ref string as_volumes[])
protected function integer of_ConvertFileDatetimeToPB (os_filedatetime astr_filetime, ref date ad_filedate, ref time at_filetime)
protected function integer of_ConvertPBDatetimeToFile (date ad_filedate, time at_filetime, ref os_filedatetime astr_filetime)
public function integer of_openfile (string as_filename, long al_windowstate)
public function string of_gettempdir ()
public function boolean of_filedelete (string as_path)
public function integer of_getsavefilename (long al_hwnd, ref string as_pathname, string as_filter)
end prototypes

public function string of_GetSeparator ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSeparator
//
//	Access:  public
//
//	Arguments:	None.
//
//	Returns:		String
//					The directory separator character.
//
//	Description:	Returns the value of the protected instance constant cis_Separator
//						which is the separator character for directories in the current
//						operating system.
//
//////////////////////////////////////////////////////////////////////////////

Return is_Separator

end function

public function string of_assemblepath (string as_drive, string as_dirpath, string as_filename, string as_ext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_AssemblePath
//
//	Access:  public
//
//	Arguments:
//	as_Drive					The disk drive from the path.
//	as_DirPath					The directory path.
//	as_FileName				The name of the file.
//	as_Ext						The file extension.
//
//	Returns:		String
//					The fully-qualified directory path.
//
//	Description:	Assemble a fully-qualified directory path from its component parts.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_Pos
String	ls_Path

// Set the Drive and Path.
ls_Path = Trim(as_Drive) + Trim(as_DirPath)

// Make sure the separator is included.
If Right(ls_Path, 1) <> is_Separator Then
	ls_Path = ls_Path + is_Separator
End If

// Add the filename.
ls_Path = ls_Path + Trim(as_FileName)

// Add the Extension.
If Trim(as_Ext) <> "" Then
	ls_Path = ls_Path + "." + Trim(as_Ext)
End if

// Return the assembled path.
Return ls_Path

end function

public function integer of_CreateDirectory (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CreateDirectory
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName		The name of the directory to be created; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Create a new directory.
//
//////////////////////////////////////////////////////////////////////////////

os_securityattributes	lstr_Security

lstr_Security.ul_Length = 7
lstr_Security.ch_description = "~000"	//use default security
lstr_Security.b_Inherit = False
If CreateDirectoryA(as_DirectoryName, lstr_Security) Then
	Return 1
Else
	Return -1
End If


end function

public function string of_getcurrentdirectory ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCurrentDirectory
//
//	Purpose:  Get the current working directory.
//
//	Scope:  public
//
//	Arguments:	None
//
//	Returns:		String			the current working directory
//
//	Written by Powersoft Corporation, 1995
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

String	ls_CurrentDir

ls_CurrentDir = Space (260)

GetCurrentDirectoryA(260, ls_CurrentDir)

Return ls_CurrentDir

end function

public function boolean of_DirectoryExists (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DirectoryExists
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName		The name of the directory to be checked; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Boolean
//					True if the directory exists, False if it does not.
//
//	Description:	Check if the specified directory exists.
//
//////////////////////////////////////////////////////////////////////////////

ULong	lul_RC

lul_RC = GetFileAttributesA(as_DirectoryName)

// Check if 5th bit is set, if so this is a directory
If Mod(Integer(lul_RC / 16), 2) > 0 Then 
	Return True
Else
	Return False
End If

end function

public function integer of_changedirectory (string as_newdirectory);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ChangeDirectory
//
//	Access:  public
//
//	Arguments:
//	as_NewDirectory			The name of the new working directory; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Change the current working directory.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC

If Trim(as_NewDirectory) = "" Then Return -1

If SetCurrentDirectoryA(as_NewDirectory) Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

end function

public function integer of_RemoveDirectory (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RemoveDirectory
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName		The name of the directory to be deleted; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Deleate a directory.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC

If Not of_DirectoryExists(as_DirectoryName) Then Return 1

If RemoveDirectoryA(as_DirectoryName) Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

end function

public function string of_AssemblePath (string as_Drive, string as_DirPath, string as_FileName);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_AssemblePath
//
//	Access:  public
//
//	Arguments:
//	as_Drive					The disk drive from the path.
//	as_DirPath					The directory path.
//	as_FileName				The name of the file.
//
//	Returns:		String
//					The fully-qualified directory path.
//
//	Description:	Assemble a fully-qualified directory path from its component parts.
//
//						This function overrides the real of_AssemblePath to allow the file
//						extension to be optional.
//
//////////////////////////////////////////////////////////////////////////////

Return of_AssemblePath(as_Drive, as_DirPath, as_FileName, "")

end function

public function integer of_FileCopy (string as_sourcefile, string as_targetfile, boolean ab_append);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileCopy
//
//	Access:  public
//
//	Arguments:
//	as_SourceFile			The name of the source file.
//	as_TargetFile				The name of the target file.
//	ab_Append				True - append to the target file if it exists,
//									False - overwrite the target file if it exists.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs reading the source file,
//					-2 if an error occurrs writting to the target file.
//
//	Description:	Copy a file.
//
//////////////////////////////////////////////////////////////////////////////

Blob		lblb_Data

// Read the source file into a blob
If of_FileRead(as_SourceFile, lblb_Data) < 0 Then Return -1

// Write to the target
If of_FileWrite(as_TargetFile, lblb_Data, ab_append) < 0 Then Return -2

Return 1

end function

public function long of_FileRead (string as_FileName, ref blob ablb_Data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileRead
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to read.
//	ablb_Data					The data from the file, passed by reference.
//
//	Returns:		Long
//					the size of the blob read, returns -1 if an error occurrs.
//
//	Description:	Open, read into a blob, and close a file.  Handles files > 32,765 bytes.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_FileNo, li_Reads, li_Cnt
Long			ll_FileLen
Blob			lblb_Data

ll_FileLen = FileLength(as_FileName)

li_FileNo = FileOpen(as_FileName, StreamMode!, Read!)
If li_FileNo < 0 Then Return -1

// Determine the number of reads required to read the entire file
If ll_FileLen > 32765 Then
	If Mod(ll_FileLen, 32765) = 0 Then
		li_Reads = ll_FileLen / 32765
	Else
		li_Reads = (ll_FileLen / 32765) + 1
	End if
Else
	li_Reads = 1
End if

// Empty the blob argument
ablb_Data = lblb_Data

// Read the file and build the blob with data from the file
For li_Cnt = 1 to li_Reads
	If FileRead(li_FileNo, lblb_Data) = -1 Then
		Return -1
	Else
		ablb_Data = ablb_Data + lblb_Data
	End if
Next

FileClose(li_FileNo)

Return ll_FileLen

end function

public function long of_FileRead (string as_filename, ref string as_text[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileRead
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to read.
//	as_Text[]					An array of strings to hold the text from the file,
//									passed by reference.
//
//	Returns:		Long
//					the number of elements in as_Text, returns -1 if an error occurrs.
//
//	Description:	Open, read, and close a file.  Handles files > 32,765 bytes by reading
//						it into an array of strings.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_FileNo, li_Cnt
Long			ll_FileLen, ll_Reads
String		ls_Text

ll_FileLen = FileLength(as_FileName)

li_FileNo = FileOpen(as_FileName, StreamMode!, Read!)
If li_FileNo < 0 Then Return -1

// Determine the number of reads required to read the entire file
If ll_FileLen > 32765 Then
	If Mod(ll_FileLen, 32765) = 0 Then
		ll_Reads = ll_FileLen / 32765
	Else
		ll_Reads = (ll_FileLen / 32765) + 1
	End if
Else
	ll_Reads = 1
End if

For li_Cnt = 1 to ll_Reads
	If FileRead(li_FileNo, as_Text[li_Cnt]) = -1 Then
		Return -1
	End if
Next

FileClose(li_FileNo)

Return ll_Reads

end function

public function integer of_FileWrite (string as_filename, string as_text, boolean ab_append);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileWrite
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to write to.
//	as_Text						The text to be written to the file.
//	ab_Append				True - append to the end of the file,
//									False - overwrite the existing file.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Open, write to, and close a file.  Handles strings > 32,765 bytes.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_FileNo
Long			ll_StrLen
String		ls_Text1, ls_Text2
Writemode	lwm_Mode

If ab_Append Then
	lwm_Mode = Append!
Else
	lwm_Mode = Replace!
End if

li_FileNo = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, lwm_Mode)
If li_FileNo < 0 Then Return -1

ll_StrLen = Len(as_Text)

// If the string is longer than 32765 bytes then it will require two writes to write it
If ll_StrLen > 32765 Then
	ls_Text1 = Left(as_Text, 32765)
	ls_Text2 = Right(as_Text, (ll_StrLen - 32765))
Else
	ls_Text1 = as_Text
End if

If FileWrite(li_FileNo, ls_Text1) = -1 Then
	Return -1
End if

If Trim(ls_Text2) <> "" Then
	If FileWrite(li_FileNo, ls_Text2) = -1 Then
		Return -1
	End if
End if

FileClose(li_FileNo)

Return 1

end function

public function integer of_FileWrite (string as_FileName, blob ablb_Data, boolean ab_Append);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileWrite
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to write to.
//	ablb_Data					The data to be written to the file.
//	ab_Append				True - append to the end of the file,
//									False - overwrite the existing file.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Open, write from a blob, and close a file.  Handles blobs > 32,765 bytes.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_FileNo, li_Writes, li_Cnt
Long		ll_BlobLen, ll_CurrentPos
Blob			lblb_Data
Writemode	lwm_Mode

If ab_Append Then
	lwm_Mode = Append!
Else
	lwm_Mode = Replace!
End if

li_FileNo = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, lwm_Mode)
If li_FileNo < 0 Then Return -1

ll_BlobLen = Len(ablb_Data)

// Determine the number of writes required to write the entire blob
If ll_BlobLen > 32765 Then
	If Mod(ll_BlobLen, 32765) = 0 Then
		li_Writes = ll_BlobLen / 32765
	Else
		li_Writes = (ll_BlobLen / 32765) + 1
	End if
Else
	li_Writes = 1
End if

ll_CurrentPos = 1

For li_Cnt = 1 To li_Writes
	lblb_Data = BlobMid(ablb_Data, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	If FileWrite(li_FileNo, lblb_Data) = -1 Then
		Return -1
	End if
Next

FileClose(li_FileNo)

Return 1

end function

public function integer of_FileWrite (string as_filename, string as_text);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileWrite
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to write to.
//	as_Text						The text to be written to the file.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Open, write to, and close a file.  Handles strings > 32,765 bytes.
//
//						This function overrides the real of_FileWrite to allow the Append
//						parameter to be optional (default is True).
//
//////////////////////////////////////////////////////////////////////////////

Return of_FileWrite(as_FileName, as_Text, True)

end function

public function integer of_FileWrite (string as_FileName, blob ablb_Data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileWrite
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to write to.
//	ablb_Data					The data to be written to the file.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Open, write from a blob, and close a file.  Handles blobs > 32,765 bytes.
//
//						This function overrides the real of_FileWrite to allow the Append
//						parameter to be optional (default is True).
//
//////////////////////////////////////////////////////////////////////////////

Return of_FileWrite(as_FileName, ablb_Data, True)

end function

public function integer of_FileCopy (string as_SourceFile, string as_TargetFile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileCopy
//
//	Access:  public
//
//	Arguments:
//	as_SourceFile			The name of the source file.
//	as_TargetFile				The name of the target file.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs reading the source file,
//					-2 if an error occurrs writting to the target file.
//
//	Description:	Copy a file.
//
//						This function overrides the real of_FileCopy to allow the Append
//						parameter to be optional (the default is False).
//
//////////////////////////////////////////////////////////////////////////////

Return of_FileCopy(as_SourceFile, as_TargetFile, False)

end function

public function integer of_FileRename (string as_sourcefile, string as_targetfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_file_rename
//
//	Access:  public
//
//	Arguments:
//	as_SourceFile			The file to rename.
//	as_TargetFile				The new file name.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Rename or move a file or directory.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC

If MoveFileA(as_SourceFile, as_TargetFile) Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

end function

public function integer of_dirlist (string as_filespec, long al_filetype, ref n_cst_dirattrib anv_dirlist[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DirList
//
//	Access:  public
//
//	Arguments:
//	as_FileSpec				The file spec. to list (including wildcards); an
//									absolute path may be specified or it will
//									be relative to the current working directory
//	al_FileType				A number representing one or more types of files
//									to include in the list, see PowerBuilder Help on
//									the DirList listbox function for an explanation.
//	anv_DirList[]				An array of n_cst_dirattrib structure whichl will contain
//									the results, passed by reference.
//
//	Returns:		Integer
//					The number of elements in anv_DirList if successful, -1 if an error occurrs.
//
//	Description:	List the contents of a directory (Name, Date, Time, and Size).
//
//////////////////////////////////////////////////////////////////////////////

Integer					li_Cnt, li_Entries
Long						ll_Handle
String					ls_Time, ls_Date
Char						lc_Drive
Boolean					lb_Found
Time						lt_Time
os_finddata			lstr_FindData
n_cst_dirattrib			lnv_Empty[]
n_cst_numerical		lnv_Numeric

// Empty the result array
anv_DirList = lnv_Empty

// List the entries in the directory
ll_Handle = FindFirstFileA(as_FileSpec, lstr_FindData)
If ll_Handle <= 0 Then Return -1
Do
	// Determine if this file should be included.
	If of_IncludeFile(String(lstr_FindData.ch_filename), al_FileType, lstr_FindData.ul_FileAttributes) Then
		
		// Add it to the array
		li_Entries ++
		anv_DirList[li_Entries].is_FileName = lstr_FindData.ch_filename
		anv_DirList[li_Entries].is_AltFileName = lstr_FindData.ch_alternatefilename
		If Trim(anv_DirList[li_Entries].is_AltFileName) = "" Then
			anv_DirList[li_Entries].is_AltFileName = anv_DirList[li_Entries].is_FileName
		End If
	
		// Set date and time
		of_ConvertFileDatetimeToPB(lstr_FindData.str_CreationTime, anv_DirList[li_Entries].id_CreationDate, &
													anv_DirList[li_Entries].it_CreationTime)
		of_ConvertFileDatetimeToPB(lstr_FindData.str_LastAccessTime, anv_DirList[li_Entries].id_LastAccessDate, lt_Time)
		of_ConvertFileDatetimeToPB(lstr_FindData.str_LastWriteTime, anv_DirList[li_Entries].id_LastWriteDate, &
													anv_DirList[li_Entries].it_LastWriteTime)

		// Calculate file size
		anv_DirList[li_Entries].idb_FileSize = (lstr_FindData.ul_FileSizeHigh * (2.0 ^ 32))  + lstr_FindData.ul_FileSizeLow
		
		// Set file attributes
		anv_DirList[li_Entries].ib_ReadOnly = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 1)
		anv_DirList[li_Entries].ib_Hidden = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 2)
		anv_DirList[li_Entries].ib_System = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 3)
		anv_DirList[li_Entries].ib_SubDirectory = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 5)
		anv_DirList[li_Entries].ib_Archive = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 6)
		anv_DirList[li_Entries].ib_Drive = False
		
		// Put brackets around subdirectories
		If anv_DirList[li_Entries].ib_SubDirectory Then
			anv_DirList[li_Entries].is_FileName = "[" + anv_DirList[li_Entries].is_FileName + "]"
			anv_DirList[li_Entries].is_AltFileName = "[" + anv_DirList[li_Entries].is_AltFileName + "]"
		End If
	End If
	
	lb_Found = FindNextFileA(ll_Handle, lstr_FindData)
Loop Until Not lb_Found
FindClose(ll_Handle)

// Add the drives if desired.
// If the type is > 32768 this was to prevent read-write files from being included.
If al_FileType >=32768 Then al_FileType = al_FileType - 32768

// If the type is > 16384, then a list of drives should be included
If al_FileType >= 16384 Then
	For li_Cnt = 0 To 25
		lc_Drive = Char(li_Cnt + 97)
		If of_GetDriveType(lc_Drive) > 1 Then
			li_Entries ++
			anv_DirList[li_Entries].is_FileName = "[-" + lc_Drive + "-]"
			anv_DirList[li_Entries].is_AltFileName = anv_DirList[li_Entries].is_FileName
			anv_DirList[li_Entries].ib_ReadOnly = False
			anv_DirList[li_Entries].ib_Hidden = False
			anv_DirList[li_Entries].ib_System = False
			anv_DirList[li_Entries].ib_SubDirectory = False
			anv_DirList[li_Entries].ib_Archive = False
			anv_DirList[li_Entries].ib_Drive = True
		End if
	Next
End if

Return li_Entries

end function

public function integer of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileAttributes
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The file whose attributes you want to set; an
//									absolute path may be specified or it will
//									be relative to the current working directory.
//	ab_ReadOnly				The new value for the Read-Only attribute.
//	ab_Hidden					The new value for the Hidden attribute.
//	ab_System					The new value for the System attribute.
//	ab_Archive					The new value for the Archive attribute.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the attributes of a file.  If null is passed for any of the attributes,
//						it will not be changed.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_RC
ULong		lul_Attrib

// Calculate the new attribute byte for the file
lul_Attrib = of_CalculateFileAttributes(as_FileName, ab_ReadOnly, ab_Hidden, ab_System, ab_Archive)
If lul_Attrib = -1 Then Return -1

If SetFileAttributesA(as_FileName, lul_Attrib) Then
	li_RC = 1
Else
	li_RC = 0
End If

Return li_RC

end function

public function integer of_GetFileAttributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdirectory, ref boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFileAttributes
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The file for which you want the attributes; an
//									absolute path may be specified or it will
//									be relative to the current working directory.
//	ab_ReadOnly				The Read-Only attribute, passed by reference.
//	ab_Hidden					The Hidden attribute, passed by reference.
//	ab_System					The System attribute, passed by reference.
//	ab_Subdirectory			The Subdirectory attribute, passed by reference.
//	ab_Archive					The Archive attribute, passed by reference.
//	
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the attributes for a file.
//
//////////////////////////////////////////////////////////////////////////////

Long						ll_Handle
os_finddata	lstr_FindData
n_cst_numerical		lnv_Numeric

// Find the file
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Set file attributes
ab_ReadOnly = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 1)
ab_Hidden = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 2)
ab_System = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 3)
ab_SubDirectory = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 5)
ab_Archive = lnv_Numeric.of_getbit(lstr_FindData.ul_FileAttributes, 6)

Return 1

end function

public function integer of_SetFileReadonly (string as_filename, boolean ab_readonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileReadonly
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose Read-Only attribute
//									is to be set.
//	ab_ReadOnly				The value to set the attribute to.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Set a file's Read-Only attribute.
//
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_Null

SetNull(lb_Null)

Return of_SetFileAttributes(as_FileName, ab_ReadOnly, lb_Null, lb_Null, lb_Null)

end function

public function integer of_SetFileHidden (string as_filename, boolean ab_hidden);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileHidden
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose Hidden attribute
//									is to be set.
//	ab_Hidden					The value to set the attribute to.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Set a file's Hidden attribute.
//
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_Null

SetNull(lb_Null)

Return of_SetFileAttributes(as_FileName, lb_Null, ab_Hidden, lb_Null, lb_Null)

end function

public function integer of_SetFileSystem (string as_filename, boolean ab_system);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileSystem
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose System attribute
//									is to be set.
//	ab_System					The value to set the attribute to.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Set a file's System attribute.
//
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_Null

SetNull(lb_Null)

Return of_SetFileAttributes(as_FileName, lb_Null, lb_Null, ab_System, lb_Null)

end function

public function integer of_SetFileArchive (string as_filename, boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileArchive
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose Archive attribute
//									is to be set.
//	ab_Archive					The value to set the attribute to.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Set a file's Archive attribute.
//
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_Null

SetNull(lb_Null)

Return of_SetFileAttributes(as_FileName, lb_Null, lb_Null, lb_Null, ab_Archive)

end function

public function string of_getlongfilename (string as_altfilename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLongFilename
//
//	Access:  public
//
//	Arguments:
//	as_AltFileName			The alternate (short) file name for which the long
//									file name is desired; an absolute path may be 
//									specified or it will be relative to the current working 
//									directory.
//
//	Returns:		String
//					The long file name (without the path), returns an empty string if 
//					an error occurrs.
//
//	Description:	Get the Win32 long file name for an alternate file name.
//
//////////////////////////////////////////////////////////////////////////////

Long						ll_Handle
String					ls_AltFileName
os_finddata	lstr_FindData

// Find the alternate file
ll_Handle = FindFirstFileA(as_AltFileName, lstr_FindData)
If ll_Handle <= 0 Then Return ""
FindClose(ll_Handle)

Return lstr_FindData.ch_filename

end function

public function string of_getaltfilename (string as_longfilename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetAltFilename
//
//	Access:  public
//
//	Arguments:
//	as_LongFileName		The long file name for which the alternate (short)
//									file name is desired; an absolute path may be 
//									specified or it will be relative to the current working 
//									directory.
//
//	Returns:		String
//					The alternate file name (without the path), returns an empty string if 
//					an error occurrs.
//
//	Description:	Get the alternate file name name for a Win32 long file.
//
//////////////////////////////////////////////////////////////////////////////

Long						ll_Handle
String					ls_LongFileName
os_finddata	lstr_FindData

// Find the long file name
ll_Handle = FindFirstFileA(as_LongFileName, lstr_FindData)
If ll_Handle <= 0 Then Return ""
FindClose(ll_Handle)

Return lstr_FindData.ch_alternatefilename

end function

public function double of_GetFileSize (string as_FileName);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFileSize
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose size is desired; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Double
//					The size of the file if successful, -1 if an error occurrs.
//
//	Description:	Get the size (in bytes) of a file.
//
//////////////////////////////////////////////////////////////////////////////

Double					ldb_Size
Long						ll_Handle
os_finddata	lstr_FindData

// Get the file
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Calculate file size
ldb_Size = (lstr_FindData.ul_FileSizeHigh * (2.0 ^ 32))  + lstr_FindData.ul_FileSizeLow

Return ldb_Size

end function

protected function unsignedlong of_calculatefileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileAttributes
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The file whose attributes you want to set; an
//									absolute path may be specified or it will
//									be relative to the current working directory.
//	ab_ReadOnly				The new value for the Read-Only attribute.
//	ab_Hidden					The new value for the Hidden attribute.
//	ab_System					The new value for the System attribute.
//	ab_Archive					The new value for the Archive attribute.
//
//	Returns:		Unsigned Long
//					The new attribute byte
//
//	Description:	Calculate the new attribute byte for a file.  If null is passed 
//						for any of the attributes, it will not be changed.
//
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_ReadOnly, lb_Hidden, lb_System, lb_Subdirectory, lb_Archive
ULong		lul_Attrib

// Get the current attribute values
If of_GetFileAttributes(as_FileName, lb_ReadOnly, lb_Hidden, &
		lb_System, lb_Subdirectory, lb_Archive) = -1 Then 
	Return -1
End If

// Preserve the Subdirectory attribute
If lb_Subdirectory Then
	lul_Attrib = 16
Else
	lul_Attrib = 0
End If

// Set Read-Only
If Not IsNull(ab_ReadOnly) Then
	If ab_ReadOnly Then lul_Attrib = lul_Attrib + 1
Else
	If lb_ReadOnly Then lul_Attrib = lul_Attrib + 1
End If

// Set Hidden
If Not IsNull(ab_Hidden) Then
	If ab_Hidden Then lul_Attrib = lul_Attrib + 2
Else
	If lb_Hidden Then lul_Attrib = lul_Attrib + 2
End If

// Set System
If Not IsNull(ab_System) Then
	If ab_System Then lul_Attrib = lul_Attrib + 4
Else
	If lb_System Then lul_Attrib = lul_Attrib + 4
End If

// Set Archive
If Not IsNull(ab_Archive) Then
	If ab_Archive Then lul_Attrib = lul_Attrib + 32
Else
	If lb_Archive Then lul_Attrib = lul_Attrib + 32
End If

Return lul_Attrib

end function

protected function boolean of_includefile (string as_filename, long al_attribmask, unsignedlong aul_fileattrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IncludeFile
//
//	Access:  protected
//
//	Arguments:
//	as_FileName				The name of the file.
//	al_AttribMask				The bit string that determines which files to include.
//	aul_FileAttrib				The attribute bits for the file.
//
//	Returns:		Boolean
//					True if the file should be included, False if not.
//
//	Description:	Determine whether a file should be included by the of_DirList function.
//						This is based on the attributes of the desired files and the file's attributes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   		Initial version
//	5.0.02	Fixed problem with NTFS file systems using different value for FILE_ATTRIBUTE_NORMAL
//
//////////////////////////////////////////////////////////////////////////////

Boolean				lb_ReadWrite
n_cst_numerical	lnv_Numeric

// Never include the "[.]" directory entry
If as_FileName = "." Then Return False

// If the mask is > 32768, then read/write files should be excluded
If al_AttribMask >=32768 Then
	al_AttribMask = al_AttribMask - 32768
	lb_ReadWrite = False
Else
	lb_ReadWrite = True
End if

// If the type is > 16384, then a list of drives should be included
If al_AttribMask >= 16384 Then al_AttribMask = al_AttribMask - 16384

// Include the file if lb_ReadWrite is true and the file is a read-write or
// read-only file (with or without the archive bit set)
// NTFS File Systems set Read/Write Files (FILE_ATTRIBUTE_NORMAL) = 128
If (lb_ReadWrite And (aul_FileAttrib = 0 Or &
								aul_FileAttrib = 1 Or &
								aul_FileAttrib = 32 Or &
								aul_FileAttrib = 33 Or &
								aul_FileAttrib = 128)) Then Return True

// Or include it if its attributes match the mask passed in (use bitwise AND).
If lnv_Numeric.of_BitwiseAnd(aul_FileAttrib, al_AttribMask) > 0 Then Return True

Return False

end function

public function integer of_GetLastwriteDatetime (string as_filename, ref date ad_date, ref time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date
//									and time; an absolute path may be specified or it
//									will be relative to the current working directory
//	ad_Date						The date the file was last modified, passed by reference.
//	at_Time						The time the file was last modified, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date and time a file was last modified.
//
//////////////////////////////////////////////////////////////////////////////

Long						ll_Handle
String					ls_Time, ls_Date
os_finddata	lstr_FindData

// Get the file information
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Convert the date and time
Return of_ConvertFileDatetimeToPB(lstr_FindData.str_LastWriteTime, ad_Date, at_Time)

end function

public function integer of_GetCreationDatetime (string as_filename, ref date ad_date, ref time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCreationDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date
//									and time; an absolute path may be specified or it
//									will be relative to the current working directory
//	ad_Date						The date the file was created, passed by reference.
//	at_Time						The time the file was created, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date and time a file was created.
//
//////////////////////////////////////////////////////////////////////////////

Long						ll_Handle
String					ls_Time, ls_Date
os_finddata	lstr_FindData

// Get the file information
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Convert the date and time
Return of_ConvertFileDatetimeToPB(lstr_FindData.str_CreationTime, ad_Date, at_Time)

end function

public function integer of_GetLastwriteDate (string as_FileName, ref date ad_Date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastwriteDate
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date;
//									an absolute path may be specified or it will be
//									relative to the current working directory
//	ad_Date						The date the file was last modified, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date a file was last modified.
//
//////////////////////////////////////////////////////////////////////////////

Time		lt_Time

Return of_GetLastwriteDatetime(as_FileName, ad_Date, lt_Time)

end function

public function integer of_GetLastwriteTime (string as_FileName, ref time at_Time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastwriteTime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its time;
//									an absolute path may be specified or it will be
//									relative to the current working directory
//	ad_Time					The time the file was last modified, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the time a file was last modified.
//
//////////////////////////////////////////////////////////////////////////////

Date		ld_Date

Return of_GetLastwriteDatetime(as_FileName, ld_Date, at_Time)

end function

public function integer of_GetCreationTime (string as_FileName, ref time at_Time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCreationTime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its time;
//									an absolute path may be specified or it will be
//									relative to the current working directory
//	ad_Time					The time the file was created, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the time a file was created.  This is only valid for Win32.
//
//////////////////////////////////////////////////////////////////////////////

Date		ld_Date

Return of_GetCreationDatetime(as_FileName, ld_Date, at_Time)

end function

public function integer of_GetCreationDate (string as_filename, ref date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCreationDate
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date;
//									an absolute path may be specified or it will be
//									relative to the current working directory
//	ad_Date						The date the file was created, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date a file was created.  This is only valid for Win32.
//
//////////////////////////////////////////////////////////////////////////////

Time		lt_Time

Return of_GetCreationDatetime(as_FileName, ad_Date, lt_Time)

end function

public function integer of_getlastaccessdate (string as_filename, ref date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastaccessDate
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date;
//									an absolute path may be specified or it will be
//									relative to the current working directory
//	ad_Date						The date the file was last accessed, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date a file was last accessed (opened).  Note:  This function
//						only returns the Date because Last Access Time is not stored by
//						the operating system.
//
//////////////////////////////////////////////////////////////////////////////

Long						ll_Handle
String					ls_Time, ls_Date
Time						lt_Time
os_finddata			lstr_FindData

// Get the file information
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Convert the date and time
Return of_ConvertFileDatetimeToPB(lstr_FindData.str_LastAccessTime, ad_Date, lt_Time)

end function

public function integer of_setlastwritedatetime (string as_filename, date ad_date, time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to be updated.
//	ad_FileDate				The date to be set.
//	at_FileTime				The time to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the Date/Time stamp on a file.
//
//////////////////////////////////////////////////////////////////////////////

Boolean						lb_Ret
Long							ll_Error, ll_Handle
os_filedatetime			lstr_FileTime, lstr_Empty
os_finddata				lstr_FindData
os_fileopeninfo			lstr_FileInfo

// Get the file information.
// This is required to keep the Last Access date from changing.
// It will be changed by the OpenFile function.
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Convert the date and time
If of_ConvertPBDatetimeToFile(ad_Date, at_Time, lstr_FileTime) < 0 Then Return -1

// Set the file structure information
lstr_FileInfo.c_fixed_disk = "~000"
lstr_FileInfo.c_pathname = as_FileName
lstr_FileInfo.c_length = "~142"

// Open the file
ll_Handle = OpenFile ( as_filename, lstr_FileInfo, 2 ) 
If ll_Handle < 1 Then Return -1
 
lb_Ret = SetFileTime(ll_Handle, lstr_Empty, lstr_FindData.str_LastAccessTime, lstr_FileTime)

CloseHandle(ll_Handle)

If lb_Ret Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_setcreationdatetime (string as_filename, date ad_date, time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetCreationDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to be updated.
//	ad_FileDate				The date to be set.
//	at_FileTime				The time to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the Creation Date/Time stamp on a file.
//
//////////////////////////////////////////////////////////////////////////////

Boolean						lb_Ret
Long							ll_Error, ll_Handle
os_filedatetime			lstr_FileTime, lstr_Empty
os_finddata				lstr_FindData
os_fileopeninfo			lstr_FileInfo

// Get the file information.
// This is required to keep the Last Access date from changing.
// It will be changed by the OpenFile function.
ll_Handle = FindFirstFileA(as_FileName, lstr_FindData)
If ll_Handle <= 0 Then Return -1
FindClose(ll_Handle)

// Convert the date and time
If of_ConvertPBDatetimeToFile(ad_Date, at_Time, lstr_FileTime) < 0 Then Return -1

// Set the file structure information
lstr_FileInfo.c_fixed_disk = "~000"
lstr_FileInfo.c_pathname = as_FileName
lstr_FileInfo.c_length = "~142"

// Open the file
ll_Handle = OpenFile ( as_filename, lstr_FileInfo, 2 ) 
If ll_Handle < 1 Then Return -1
 
lb_Ret = SetFileTime(ll_Handle, lstr_FileTime, lstr_FindData.str_LastAccessTime, lstr_Empty)

CloseHandle(ll_Handle)

If lb_Ret Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_setlastaccessdate (string as_filename, date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to be updated.
//	ad_FileDate				The date to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the Last Access Date on a file.
//
//////////////////////////////////////////////////////////////////////////////

Boolean						lb_Ret
Long							ll_Error, ll_Handle
Time							lt_Time
os_filedatetime			lstr_FileTime, lstr_Empty
os_fileopeninfo			lstr_FileInfo

// Convert the date and time
If of_ConvertPBDatetimeToFile(ad_Date, lt_Time, lstr_FileTime) < 0 Then Return -1

// Set the file structure information
lstr_FileInfo.c_fixed_disk = "~000"
lstr_FileInfo.c_pathname = as_FileName
lstr_FileInfo.c_length = "~142"

// Open the file
ll_Handle = OpenFile ( as_filename, lstr_FileInfo, 2 ) 
If ll_Handle < 1 Then Return -1
 
lb_Ret = SetFileTime(ll_Handle, lstr_Empty, lstr_FileTime, lstr_Empty)

CloseHandle(ll_Handle)

If lb_Ret Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_deltree (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DelTree
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName	The name of the directory to be deleted; an
//							absolute path may be specified or it will
//							be relative to the current working directory
//
//	Returns:		Integer
//					 1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Delete a directory and all its files and subdirectories.  
//						This function is recurrsive.
//
//////////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_RC, li_Entries, li_Cnt
String				ls_Directory, ls_Subdirectory
n_cst_dirattrib	lnv_DirList[]

If Not of_DirectoryExists(as_DirectoryName) Then Return 1

If Right(as_DirectoryName, 1) <> is_Separator Then
	ls_Directory = as_DirectoryName + is_Separator
Else
	ls_Directory = as_DirectoryName
End If

li_Entries = of_DirList(ls_Directory + is_AllFiles, 55, lnv_DirList)

For li_Cnt = 1 To li_Entries
	If lnv_DirList[li_Cnt].ib_SubDirectory Then

		// Recurrsively call this function to erase the subdirectory
		// Skip [..]
		If lnv_DirList[li_Cnt].is_FileName <> "[..]" Then

			// Remove [] from directory name
			ls_SubDirectory = Mid(lnv_DirList[li_Cnt].is_FileName, 2, &
				(Len(lnv_DirList[li_Cnt].is_FileName) - 2))

			li_RC = of_DelTree(ls_Directory + ls_SubDirectory)
			If li_RC < 0 Then
				Return li_RC
			End if
		End if

	Else	
		// Delete the file
		// Do not error out if delete fails
		This.of_FileDelete(ls_Directory + lnv_DirList[li_Cnt].is_FileName)
	End if
Next

Return of_RemoveDirectory(as_DirectoryName)

end function

public function integer of_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename, ref string as_ext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_ParsePath
//
//	Access:  	public
//
//	Arguments:
//	as_Path					The path to disassemble.
//	as_Drive					The disk drive from the path, passed by reference.
//	as_DirPath				The directory path, passed by reference.
//	as_FileName				The name of the file, passed by reference.
//	as_Ext					The file extension, passed by reference.  If null is 
//								passed in, the extension will not be parsed out of the file.
//
//	Returns:			integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Parse a fully-qualified directory path into its component parts.
//
//////////////////////////////////////////////////////////////////////////////

Integer			li_Pos
String			ls_File
n_cst_string 	lnv_string

If IsNull(as_path) or Len(Trim(as_path))=0 Then
	Return -1
End If

// Get the drive
li_Pos = Pos(as_Path, ":")
If li_Pos = 0 Then
	as_Drive = ""
Else
	If Mid(as_Path, (li_Pos + 1), 1) = is_Separator Then
		li_Pos ++
	End if

	as_Drive = Left(as_Path, li_Pos)
	as_Path = Right(as_Path, (Len(as_Path) - li_Pos))
End if

// Get the file name and extension
li_Pos = lnv_string.of_LastPos(as_Path, is_Separator, 0)
ls_File = Right(as_Path, (Len(as_Path) - li_Pos))
as_Path = Left(as_Path, li_Pos)

If IsNull(as_Ext) Then
	as_FileName = ls_File
	as_Ext = ""
Else
	// Get the extension
	li_Pos = lnv_string.of_LastPos(ls_File, ".")
	If li_Pos > 0 Then
		as_FileName = Left(ls_File, (li_Pos - 1))
		as_Ext = Right(ls_File, (Len(ls_File) - li_Pos))
	Else
		as_FileName = ls_File
		as_Ext = ""
	End if
End If

// Everything left is the directory path
as_DirPath = as_Path
Return 1

end function

public function integer of_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ParsePath
//
//	Access:  		public
//
//	Arguments:
//	as_Path			The path to disassemble.
//	as_Drive			The disk drive from the path, passed by reference.
//	as_DirPath		The directory path, passed by reference.
//	as_FileName		The name of the file, passed by reference.
//
//	Returns:			Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Parse a fully-qualified directory path into its component parts.
//
//						This function overrides the real of_ParsePath to allow the file
//						extension to be optional.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Ext
SetNull (ls_Ext)

Return of_ParsePath(as_Path, as_Drive, as_DirPath, as_FileName, ls_Ext)

end function

public function integer of_sortdirlist (ref n_cst_dirattrib anv_dirlist[], integer ai_sorttype, boolean ab_ascending);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SortDirList
//
//	Access:  		public
//
//	Arguments:
//	anv_DirList[]	The output structure from the of_DirList function.
//	ai_SortType		Sort by:  1 - File Name, 2 - File Ext.,
//									3 - File Last Write Date/Time, 
//									4 - File Size.
//	ab_Ascending				True - sort ascending,
//									False - sort in descending order.
//
//	Returns:			Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Sort the directory list from the of_DirList function.  
//						Sort algorithm used is a bubble sort.
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_Limit, li_Cnt, li_Pos
Boolean				lb_Done, lb_Swap
String				ls_Entry1, ls_Entry2, ls_Name1, ls_Name2, ls_Ext1, ls_Ext2
n_cst_dirattrib	lnv_DirEntry

// check arguments.
If IsNull(ai_sorttype) or IsNull(ab_ascending) Then
	Return -1
End If

li_Limit = UpperBound(anv_DirList) - 1
Do
	lb_Done = True	
	For li_Cnt = 1 to li_Limit
		lb_Swap = False

		If anv_DirList[li_Cnt].ib_Subdirectory Then
			ls_Entry1 = Mid(anv_DirList[li_Cnt].is_FileName, 2, (Len(anv_DirList[li_Cnt].is_FileName) - 2))
		ElseIf anv_DirList[li_Cnt].ib_Drive Then
			ls_Entry1 = Mid(anv_DirList[li_Cnt].is_FileName, 3, 1)
		Else
			ls_Entry1 = anv_DirList[li_Cnt].is_FileName
		End If
		If anv_DirList[li_Cnt + 1].ib_Subdirectory Then
			ls_Entry2 = Mid(anv_DirList[li_Cnt + 1].is_FileName, 2, (Len(anv_DirList[li_Cnt + 1].is_FileName) - 2))
		ElseIf anv_DirList[li_Cnt + 1].ib_Drive Then
			ls_Entry2 = Mid(anv_DirList[li_Cnt + 1].is_FileName, 3, 1)
		Else
			ls_Entry2 = anv_DirList[li_Cnt + 1].is_FileName
		End If
		
		// Place subdirectories before files, drives after files and always sort drives in alphabetical order.
		If (Not anv_DirList[li_Cnt].ib_Subdirectory And anv_DirList[li_Cnt + 1].ib_Subdirectory) Or &
			(anv_DirList[li_Cnt].ib_Drive And Not anv_DirList[li_Cnt + 1].ib_Drive) Or &
			(anv_DirList[li_Cnt].ib_Drive And anv_DirList[li_Cnt + 1].ib_Drive And ls_Entry1 > ls_Entry2) Then
			lb_Swap = True

		Elseif anv_DirList[li_Cnt].ib_Subdirectory = anv_DirList[li_Cnt + 1].ib_Subdirectory And &
				Not anv_DirList[li_Cnt].ib_Drive And Not anv_DirList[li_Cnt + 1].ib_Drive Then
				
			// Sort based on sort type.
			Choose Case ai_SortType
				Case 1	//  Sort by file name
					If (ab_Ascending And ls_Entry1 > ls_Entry2) Or &
						(Not ab_Ascending And ls_Entry1 < ls_Entry2) Then
						lb_Swap = True
					End if

				Case 2	// Sort by file extension
					li_Pos = Pos(ls_Entry1, ".")
					If li_Pos = 0 Or ls_Entry1 = ".." Then
						ls_Name1 = ls_Entry1
						ls_Ext1 = ""
					Else
						ls_Name1 = Left(ls_Entry1, (li_Pos - 1))
						ls_Ext1 = Right(ls_Entry1, (Len(ls_Entry1) - li_Pos))
					End If
					
					li_Pos = Pos(ls_Entry2, ".")
					If li_Pos = 0 Or ls_Entry2 = ".." Then
						ls_Name2 = ls_Entry2
						ls_Ext2 = ""
					Else
						ls_Name2 = Left(ls_Entry2, (li_Pos - 1))
						ls_Ext2 = Right(ls_Entry2, (Len(ls_Entry2) - li_Pos))
					End if
	
					If ab_Ascending And ((ls_Ext1 > ls_Ext2) Or ((ls_Ext1 = ls_Ext2) And (ls_Name1 > ls_Name2))) Or & 
						Not ab_Ascending And ((ls_Ext1 < ls_Ext2) Or ((ls_Ext1 = ls_Ext2) And (ls_Name1 < ls_Name2)))Then
						lb_Swap = True
					End if

				Case 3	// Sort by last write date.
					If ab_Ascending And (((anv_DirList[li_Cnt].id_LastWriteDate > anv_DirList[li_Cnt + 1].id_LastWriteDate) Or &
					   							   ((anv_DirList[li_Cnt].id_LastWriteDate = anv_DirList[li_Cnt + 1].id_LastWriteDate) And &
					   								(anv_DirList[li_Cnt].it_LastWriteTime > anv_DirList[li_Cnt + 1].it_LastWriteTime))) Or &
												   (anv_DirList[li_Cnt].id_LastWriteDate = anv_DirList[li_Cnt + 1].id_LastWriteDate And &
													anv_DirList[li_Cnt].it_LastWriteTime = anv_DirList[li_Cnt + 1].it_LastWriteTime And &
													ls_Entry1 > ls_Entry2)) Or &
					   Not ab_Ascending And (((anv_DirList[li_Cnt].id_LastWriteDate < anv_DirList[li_Cnt + 1].id_LastWriteDate) Or &
					   									((anv_DirList[li_Cnt].id_LastWriteDate = anv_DirList[li_Cnt + 1].id_LastWriteDate) And &
					  									 (anv_DirList[li_Cnt].it_LastWriteTime < anv_DirList[li_Cnt + 1].it_LastWriteTime))) Or &
														(anv_DirList[li_Cnt].id_LastWriteDate = anv_DirList[li_Cnt + 1].id_LastWriteDate And &
														 anv_DirList[li_Cnt].it_LastWriteTime = anv_DirList[li_Cnt + 1].it_LastWriteTime And &
														 ls_Entry1 < ls_Entry2)) Then
						lb_Swap = True
					End if

				Case 4	// Sort by size
					If ab_Ascending And (anv_DirList[li_Cnt].idb_FileSize > anv_DirList[li_Cnt + 1].idb_FileSize Or &
												  (anv_DirList[li_Cnt].idb_FileSize = anv_DirList[li_Cnt + 1].idb_FileSize And &
												   ls_Entry1 > ls_Entry2)) Or &
						Not ab_Ascending And (anv_DirList[li_Cnt].idb_FileSize < anv_DirList[li_Cnt + 1].idb_FileSize Or &
												  		 (anv_DirList[li_Cnt].idb_FileSize = anv_DirList[li_Cnt + 1].idb_FileSize And &
												   		  ls_Entry1 < ls_Entry2)) Then
						lb_Swap = True
					End if
			End Choose
		End If
		
		If lb_Swap Then
			lnv_DirEntry = anv_DirList[li_Cnt]
			anv_DirList[li_Cnt] = anv_DirList[li_Cnt + 1]
			anv_DirList[li_Cnt + 1] = lnv_DirEntry
			lb_Done = False
		End if
	Next
	li_Limit --

Loop Until lb_Done

Return 1
end function

public function integer of_sortdirlist (ref n_cst_dirattrib anv_dirlist[], integer ai_sorttype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SortDirList
//
//	Access:  		public
//
//	Arguments:
//	anv_DirList[]	The output structure from the of_DirList function.
//	ai_SortType		Sort by:  1 - File Name, 2 - File Ext.,
//									3 - File Last Write Date/Time, 
//									4 - File Size.
//
//	Returns:			Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Sort the directory list from the of_DirList function.  Sort algorithm used
//						is a bubble sort.
//
//						This function overrides the real of_SortDirList to allow the last parameter
//						to be optional.
//
//////////////////////////////////////////////////////////////////////////////

Return of_SortDirList(anv_DirList, ai_SortType, True)

end function

public function integer of_GetDiskSpace (character ac_drive, ref long al_totalspace, ref long al_freespace);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDiskSpace
//
//	Access:  public
//
//	Arguments:
//	ac_Drive					The letter of the drive to be checked.
//	al_TotalSpace			The total number of bytes on the drive, passed
//									by reference.
//	al_FreeSpace				The number of bytes free, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get space information about a drive.
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_SectPerCluster, ll_BytesPerSect, ll_FreeClusters, ll_TotalClusters, ll_ClusterBytes

If Not GetDiskFreeSpaceA(Upper(ac_Drive) + ":\", ll_SectPerCluster, ll_BytesPerSect, &
									ll_FreeClusters, ll_TotalClusters) Then Return -1

ll_ClusterBytes = ll_SectPerCluster * ll_BytesPerSect
al_TotalSpace = ll_ClusterBytes * ll_TotalClusters
al_FreeSpace = ll_ClusterBytes * ll_FreeClusters

Return 1

end function

public function integer of_GetDriveType (character ac_drive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDriveType
//
//	Access:  public
//
//	Arguments:
//	ac_Drive					The letter of the drive to be checked.
//
//	Returns:		Integer
//					The type of the drive:
//					2 - floppy drive,
//					3 - hard drive,
//					4 - network drive,
//					5 - cdrom drive,
//					6 - ramdisk,
//					any other value is the result of an error.
//
//	Description:	Determine the type of a drive.
//
//////////////////////////////////////////////////////////////////////////////

Return GetDriveTypeA(Upper(ac_Drive) + ":\")

end function

public function integer of_getvolumes (ref string as_volumes[]);//	Function not found in descendent

Return -1

end function

protected function integer of_ConvertFileDatetimeToPB (os_filedatetime astr_filetime, ref date ad_filedate, ref time at_filetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertFileDatetimeToPB
//
//	Access:  protected
//
//	Arguments:
//	astr_FileTime				The os_filedatetime structure containg the 
//									system date/time for the file.
//	ad_FileDate				The file date in PowerBuilder Date format,
//									passed by reference.
//	at_FileTime				The file time in PowerBuilder Time format,
//									passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Convert a sytem file type to PowerBuilder Date and Time.
//
//////////////////////////////////////////////////////////////////////////////

String				ls_Date, ls_Time
os_filedatetime	lstr_LocalTime
os_systemtime	lstr_SystemTime

If Not FileTimeToLocalFileTime(astr_FileTime, lstr_LocalTime) Then Return -1

If Not FileTimeToSystemTime(lstr_LocalTime, lstr_SystemTime) Then Return -1

ls_Date = String(lstr_SystemTime.ui_WMonth) + "/" + &
				String(lstr_SystemTime.ui_WDay) + "/" + &
				String(lstr_SystemTime.ui_wyear)
ad_FileDate = Date(ls_Date)

ls_Time = String(lstr_SystemTime.ui_wHour) + ":" + &
				String(lstr_SystemTime.ui_wMinute) + ":" + &
				String(lstr_SystemTime.ui_wSecond) + ":" + &
				String(lstr_SystemTime.ui_wMilliseconds)
at_FileTime = Time(ls_Time)

Return 1

end function

protected function integer of_ConvertPBDatetimeToFile (date ad_filedate, time at_filetime, ref os_filedatetime astr_filetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertPBDatetimeToFile
//
//	Access:  protected
//
//	Arguments:
//	ad_FileDate				The file date in PowerBuilder Date format.
//	at_FileTime				The file time in PowerBuilder Time format.
//	astr_FileTime				The os_filedatetime structure to contain the 
//									system date/time for the file, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Convert PowerBuilder Date and Time to the sytem file type.
//
//////////////////////////////////////////////////////////////////////////////

String				ls_Date, ls_Time
os_filedatetime	lstr_LocalTime
os_systemtime	lstr_SystemTime

ls_Date = String(ad_FileDate, "yyyy-mm-dd")
lstr_SystemTime.ui_wyear = Long(Left(ls_Date, 4))
lstr_SystemTime.ui_WMonth = Long(Mid(ls_Date, 6, 2))
lstr_SystemTime.ui_WDay = Long(Right(ls_Date, 2))

ls_Time = String(at_FileTime, "hh:mm:ss:ffffff")
lstr_SystemTime.ui_wHour = Long(Left(ls_Time, 2))
lstr_SystemTime.ui_wMinute = Long(Mid(ls_Time, 4, 2))
lstr_SystemTime.ui_wSecond = Long(Mid(ls_Time, 7, 2))
lstr_SystemTime.ui_wMilliseconds = Long(Right(ls_Time, 6))

If Not SystemTimeToFileTime(lstr_SystemTime, lstr_LocalTime) Then Return -1

If Not LocalFileTimeToFileTime(lstr_LocalTime, astr_FileTime) Then Return -1

Return 1

end function

public function integer of_openfile (string as_filename, long al_windowstate);//////////////////////////////////////////////////////////////////////////////////
//
// This method uses various Shell commands.
// The first is ShellExecuteA, which opens a file in its native application.
// Here is the parameter list/definition:
// ByVal hWnd As Long--Handle to the Window 
// ByVal lpOperation As String--Operation to perform 
// ByVal lpFile As String--File name or command to open/execute 
// ByVal lpParameters As String--Paramater(s) to file or command 
// ByVal lpDirectory As String--Full path of directory to file or command 
// ByVal nShowCmd As String--Specify how launched programs are displayed 
// SW_HIDE 0, SW_NORMAL 1, SW_SHOWMINIMIZED 2, SW_SHOWMAXIMIZED 3 
// SW_SHOWNOACTIVATE 4, SW_SHOW 5, SW_MINIMIZE 6, SW_SHOWMINNOACTIVE 7 
// SW_SHOWNA 8, SW_RESTORE 9, SW_SHOWDEFAULT 10
//
// Possible return codes are: 
// SE_ERR_FNF              2       // file not found
// SE_ERR_PNF              3       // path not found
// SE_ERR_ACCESSDENIED     5       // access denied
// SE_ERR_OOM              8       // out of memory
// SE_ERR_SHARE            26
// SE_ERR_ASSOCINCOMPLETE  27
// SE_ERR_DDETIMEOUT       28
// SE_ERR_DDEFAIL          29
// SE_ERR_DDEBUSY          30
// SE_ERR_NOASSOC          31
// SE_ERR_DLLNOTFOUND      32
//
// Arguments:	String	as_filename
//					Long		al_windowstate	See the nShowCmd value options
//
//	Description:	Opens the specified file in its native 
//						application as defined by Windows.
//						If the application is not defined
//						Display the Windows Open With dialog.
//
////////////////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
////////////////////////////////////////////////////////////////////////////////////

String	ls_Null
Long		ll_handle
Int		li_rtn

ll_handle = Handle( This )
SetNull(ls_Null)

li_rtn = ShellExecuteA( ll_handle, "open", as_filename, ls_null, ls_null, al_windowstate )

// If file not associated 
//	display Open With dialog
IF li_rtn = SE_ERR_NOASSOC THEN
	li_rtn = ShellExecuteA( ll_handle, ls_null, "RUNDLL32.EXE", &
					"shell32.dll,OpenAs_RunDLL " + as_filename, as_filename, al_windowstate )
END IF

Return li_rtn
end function

public function string of_gettempdir ();///////////////////////////////////////////////////////////////////////////
//
//	This method will get the temporary directory from
//	the various keys of the current user's registry.
//
//	Returns: temporary directory
//				"" - Error
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

constant long  lcl_maxpath = 260
string         ls_tempdir, ls_init, ls_longdir
ulong          lul_retval
integer			li_rtn

// Windows requires padded string
ls_init = Fill('0', lcl_maxpath)
ls_tempdir = ls_init
ls_longdir = ls_init

// Call local external function.
lul_retval = GetTempPathA( lcl_maxpath, ls_tempdir )

// Windows returns length of string returned, so if anything
// greater than zero, then windows returned something useful.
IF lul_retval <= 0 OR IsNull( ls_tempdir ) OR Trim( ls_tempdir ) = "" THEN
	// If not found, try the APPDATA in Registry
	li_rtn = RegistryGet( "HKEY_CURRENT_USER\Volatile Environment", &
												"APPDATA", RegString!, ls_tempdir ) 
												
	// If still not found, return error
	IF li_rtn <> 1 OR IsNull( ls_tempdir ) OR Trim( ls_tempdir ) = "" THEN Return ""
END IF

// Convert short to long path
lul_retval = GetLongPathName( ls_tempdir, ls_longdir, lcl_maxpath )

IF lul_retval > 0 THEN Return ls_longdir
Return ls_tempdir
end function

public function boolean of_filedelete (string as_path);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileDelete
//
//	Access:  public
//
//	Arguments:
//	as_path		The full path and filename to be deleted.
//					An absolute path may be specified or it will
//					be relative to the current working directory.
//
//	Returns:		Boolean
//					True - Success
//					False - Failure
//
//	Description:	Check if the specified directory exists.
//
//////////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
//////////////////////////////////////////////////////////////////////////////

IF FileExists( as_path ) THEN		
	// Turn off the ReadOnly flag
	This.of_SetFileReadOnly( as_path, FALSE )
	
	Return FileDelete( as_path )
END IF

Return TRUE
end function

public function integer of_getsavefilename (long al_hwnd, ref string as_pathname, string as_filter);//*********************************************************************************
// Script Name:	n_cst_filesrv.of_GetSaveFileName
//
// Arguments:	al_hwnd			-	Handle of main window
//					as_pathname		-	Full path (By Ref)
//					as_filter		-	Filter string (see PB Help for format)
//
// Returns:		 Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// Description:	This function opens the Windows GetSaveFileName dialog box
//
//*********************************************************************************
//
//	10/31/09	GaryR	EXP.650.4897.005	Add support for formatted export to all versions of Excel
//
//*********************************************************************************

Integer li_rc, li_cnt, li_max, li_pos
Long ll_errcode, ll_length
Char lc_pathname[], lc_filter[]
String ls_filter[], ls_work[], ls_ext, ls_sel_ext
CONSTANT ulong LMEM_ZEROINIT = 64
CONSTANT ulong MAX_LENGTH = 32767
n_cst_string	lnv_string
OPENFILENAME	lofn

lofn.lStructSize = 76
lofn.nFilterIndex = 1
lofn.nMaxFile = MAX_LENGTH
lofn.Flags = OFN_HIDEREADONLY + OFN_PATHMUSTEXIST + OFN_NOTESTFILECREATE

// set window handle
lofn.hwndOwner	= al_hwnd

// copy title
//SetNull(lofn.lpstrTitle)

// allocate memory and copy filter
ls_filter = lnv_string.of_stringtoarray( as_filter, "," )
li_max = UpperBound(ls_filter)
For li_cnt = 1 To li_max
	ll_length = lnv_string.of_char_string(Trim(ls_filter[li_cnt]), lc_filter)
Next
ll_length = UpperBound(lc_filter)*2
lofn.lpstrFilter = LocalAlloc(LMEM_ZEROINIT, ll_length)
RtlMoveMemory(lofn.lpstrFilter, lc_filter, ll_length)

// allocate memory for returned data
lc_pathname = Space(MAX_LENGTH)
lofn.nMaxFile = MAX_LENGTH
lofn.lpstrFile = LocalAlloc(LMEM_ZEROINIT, MAX_LENGTH)

// display dialog box
If GetSaveFileName(lofn) Then
	// copy returned pathnames to char array
	RtlMoveMemory(lc_pathname, lofn.lpstrFile, MAX_LENGTH)
	lnv_string.of_string_char(lc_pathname, ls_work)
	// copy pathname to output arguments
	If UpperBound(ls_work) = 1 Then
		as_pathname = Trim( ls_work[1] )
		li_cnt = lofn.nFilterIndex
		
		//	Check extension
		IF li_max > li_cnt THEN
			ls_sel_ext = Lower( Mid( Trim( ls_filter[li_cnt*2] ), 3 ) )
		END IF
		
		li_pos = LastPos( as_pathname, "." )
		IF li_pos > 0 THEN
			ls_ext = Lower( Mid( as_pathname, li_pos + 1 ) )
			IF ls_sel_ext <> ls_ext THEN as_pathname += "." + ls_sel_ext
		ELSE
			as_pathname += "." + ls_sel_ext
		END IF
		
		li_rc = li_cnt
	Else
		li_rc = -1
	End If
Else
	ll_errcode = CommDlgExtendedError()
	If ll_errcode = 0 Then
		li_rc = 0
	Else
		li_rc = -1
	End If
End If

// free allocated memory
LocalFree(lofn.lpstrFilter)
LocalFree(lofn.lpstrFile)

Return li_rc
end function

on n_cst_filesrv.create
call super::create
end on

on n_cst_filesrv.destroy
call super::destroy
end on

