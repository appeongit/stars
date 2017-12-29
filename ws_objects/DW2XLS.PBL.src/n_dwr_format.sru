$PBExportHeader$n_dwr_format.sru
forward
global type n_dwr_format from nonvisualobject
end type
end forward

global type n_dwr_format from nonvisualobject
end type
global n_dwr_format n_dwr_format

type prototypes
//DLLEXPORT void PBCALL setNumFormat(const TCHAR* numFormat) {
Subroutine setNumFormat(ulong f, readonly string as_format) &
	Alias For "fmt_setNumFormat" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontName(const TCHAR* fontName) {
Subroutine setFontName(ulong f, readonly string as_font) &
	Alias For "fmt_setFontName" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontSize(int fontSize) {
Subroutine setFontSize(ulong f, long value) &
	Alias For "fmt_setFontSize" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontItalic(int fontItalic) {
Subroutine setFontItalic(ulong f, long value) &
	Alias For "fmt_setFontItalic" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontUnderline(int fontUnderline) {
Subroutine setFontUnderline(ulong f, long value) &
	Alias For "fmt_setFontUnderline" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontWeight(int fontWeight) {
Subroutine setFontWeight(ulong f, long value) &
	Alias For "fmt_setFontWeight" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setHAlign(int hAlign) {
Subroutine setHAlign(ulong f, long value) &
	Alias For "fmt_setHAlign" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setVAlign(int vAlign) {
Subroutine setVAlign(ulong f, long value) &
	Alias For "fmt_setVAlign" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setTextAlign(const TCHAR* value) {
Subroutine setTextAlign(ulong f, readonly string value) &
	Alias For "fmt_setTextAlign" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setWrap(int wrap) {
Subroutine setWrap(ulong f, long value) &
	Alias For "fmt_setWrap" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFgColor(uint fgColor) {
Subroutine setFgColor(ulong f, ulong value) &
	Alias For "fmt_setFgColor" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setBgColor(uint bgColor) {
Subroutine setBgColor(ulong f, ulong value) &
	Alias For "fmt_setBgColor" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setBorderStyle(int borderStyle) {
Subroutine setBorderStyle(ulong f, long value) &
	Alias For "fmt_setBorderStyle" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontFamily(int fontFamily) {
Subroutine setFontFamily(ulong f, long value) &
	Alias For "fmt_setFontFamily" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontCharset(int fontCharset) {
Subroutine setFontCharset(ulong f, long value) &
	Alias For "fmt_setFontCharset" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontShadow(int fontShadow) {
Subroutine setFontShadow(ulong f, long value) &
	Alias For "fmt_setFontShadow" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setFontOutline(int fontOutline) {
Subroutine setFontOutline(ulong f, long value) &
	Alias For "fmt_setFontOutline" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setRotation(int rotation) {
Subroutine setRotation(ulong f, long value) &
	Alias For "fmt_setRotation" Library "pb2xls.dll"
//DLLEXPORT void PBCALL destroyFormat() {
Subroutine destroyFormat(ulong f) &
	Alias For "fmt_destroyFormat" Library "pb2xls.dll"
//DLLEXPORT void PBCALL setLocked(int locked) {
Subroutine setLocked(ulong f, long value) &
	Alias For "fmt_setLocked" Library "pb2xls.dll"

end prototypes

type variables
public:
ulong handle = 0


end variables

forward prototypes
public function long of_str2alignment (string as_alignment)
end prototypes

public function long of_str2alignment (string as_alignment);Choose Case Lower(as_alignment)
	Case "left"
		Return n_dwr_const.ALIGN_LEFT
	Case "right"
		Return n_dwr_const.ALIGN_RIGHT
	Case "center"
		Return n_dwr_const.ALIGN_CENTER
	Case "justify", "justified"
		Return n_dwr_const.ALIGN_JUSTIFIED
	Case "top"
		Return n_dwr_const.ALIGN_TOP
	Case "bottom"
		Return n_dwr_const.ALIGN_BOTTOM
	Case "middle", "vcenter"
		Return n_dwr_const.ALIGN_VCENTER
	Case Else
		Return n_dwr_const.ALIGN_LEFT
End Choose
end function

on n_dwr_format.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_dwr_format.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If handle <> 0 Then
	destroyFormat(handle)
End If
end event

