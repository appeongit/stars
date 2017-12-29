HA$PBExportHeader$n_dwr_workbook.sru
forward
global type n_dwr_workbook from nonvisualobject
end type
end forward

type CELL_COORD from structure
	long		x1
	long		x2
	long		y1
	long		y2
end type

global type n_dwr_workbook from nonvisualobject
end type
global n_dwr_workbook n_dwr_workbook

type prototypes

Function ulong createWorkbook(readonly string as_format, readonly string as_file, boolean ab_overwrite, ref long al_errorcode) &
	Alias For "g_createWorkbook" Library "pb2xls.dll"
	
	
//DLLEXPORT static CWorksheet * PBCALL wb_addWorksheet (CWorkbook *wb, const TCHAR * sheetName)
Function ulong addWorksheet(ulong wb, readonly string as_sheetName) &
	Alias For "wb_addWorksheet" Library "pb2xls.dll"

//DLLEXPORT static ErrorCode PBCALL wb_save(CWorkbook * wb)
Function long save(ulong wb) &
	Alias For "wb_save" Library "pb2xls.dll"

//DLLEXPORT static void PBCALL wb_destroy(CWorkbook * wb) {
Subroutine _destroy(ulong wb) &
	Alias For "wb_destroy" Library "pb2xls.dll"


Function ulong GetModuleFileNameA (ulong hinstModule, ref string lpszPath, ulong cchPath ) Library "KERNEL32.DLL" 
Function ulong GetModuleFileNameW (ulong hinstModule, ref string lpszPath, ulong cchPath ) Library "KERNEL32.DLL" 
Function ulong LoadLibraryA (ref string lpLibFileName) Library "KERNEL32.DLL"
Function ulong LoadLibraryW (ref string lpLibFileName) Library "KERNEL32.DLL"
Function boolean FreeLibrary (ulong hLibModule) Library "KERNEL32.DLL"


//DLLEXPORT static CFormat* PBCALL wb_createFormat(CWorkbook * wb) {
Function ulong createFormat(ulong wb) &
	Alias For "wb_createFormat" Library "pb2xls.dll"

//DLLEXPORT static int PBCALL wb_addFormat(CWorkbook * wb, CFormat* f) {
Function ulong addFormat(ulong wb, ulong format) &
	Alias For "wb_addFormat" Library "pb2xls.dll"

end prototypes

type variables
public:
ulong handle = 0


//legacy code, to be removed
n_dwr_worksheet invo_worksheets[]
end variables

forward prototypes
public function n_dwr_worksheet of_addworksheet (readonly string as_sheetname)
public function long of_create (readonly string as_format, readonly string as_file, boolean ab_overwrite)
public function boolean of_iswidepb ()
private function string of_getexedir ()
private function unsignedlong of_loadlibrary (string as_dll)
public function n_dwr_format of_createformat ()
public function long of_addformat (n_dwr_format anv_format)
end prototypes

public function n_dwr_worksheet of_addworksheet (readonly string as_sheetname);
n_dwr_worksheet lnv_sheet

lnv_sheet = Create n_dwr_worksheet
lnv_sheet.handle = addWorksheet(handle, as_sheetname)
If lnv_sheet.handle = 0 Then
	SetNull(lnv_sheet)
Else
	invo_worksheets[UpperBound(invo_worksheets[]) + 1] = lnv_sheet
	lnv_sheet.of_InitUnitConvertor()
End If
Return lnv_sheet

end function

public function long of_create (readonly string as_format, readonly string as_file, boolean ab_overwrite);Long ll_errorcode = n_dwr_const.S_OK

//preload PB2XLS.DLL if it exists in EXE directory
ulong h 
h = of_LoadLibrary("pb2xls.dll")

handle = createWorkbook(as_format, as_file, ab_overwrite, ll_errorcode)

If h > 0 Then
	FreeLibrary(h)
End If

Return ll_errorcode
end function

public function boolean of_iswidepb ();Return Len(blob("*")) = 2
end function

private function string of_getexedir ();String ls_path
Long li_max = 1024, li_pos

If Handle(GetApplication()) = 0 Then
	//IDE
	
	ClassDefinition lcd
	lcd = this.ClassDefinition
	ls_path = lcd.LibraryName
	
	
Else
	//Run-time
	ls_path = Space(li_max)
	If of_IsWidePB() Then
		GetModuleFileNameW(Handle(GetApplication()), ls_path, li_max)
	Else
		GetModuleFileNameA(Handle(GetApplication()), ls_path, li_max)
	End If
End If
li_pos = Pos(Reverse(ls_path), "\")
If li_pos > 0 Then
	ls_path = Left(ls_path, Len(ls_path) - li_pos)
Else
	ls_path = "."
End If


Return ls_path
end function

private function unsignedlong of_loadlibrary (string as_dll);String ls_dll
ls_dll = of_GetEXEDir() +"\" + as_dll
If of_IsWidePB() Then
	Return LoadLibraryW(ls_dll)
Else
	Return LoadLibraryA(ls_dll)
End If
end function

public function n_dwr_format of_createformat ();n_dwr_format lnv_format
lnv_format = Create n_dwr_format 
lnv_format.handle = createFormat(handle)
return lnv_format
end function

public function long of_addformat (n_dwr_format anv_format);Return addFormat(handle, anv_format.handle)
end function

on n_dwr_workbook.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_dwr_workbook.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If handle > 0 Then 
	_destroy(handle)
	handle = 0
End If
end event

