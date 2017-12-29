$PBExportHeader$n_cst_string.sru
$PBExportComments$PFC String Service (inherited from n_base) <logic>
forward
global type n_cst_string from n_base
end type
end forward

global type n_cst_string from n_base autoinstantiate
end type

type variables

end variables

forward prototypes
public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function string of_gettoken (ref string as_source, string as_separator)
public function string of_padleft (string as_source, long al_length)
public function string of_padright (string as_source, long al_length)
public function boolean of_islower (string as_source)
public function boolean of_isupper (string as_source)
public function boolean of_iswhitespace (string as_source)
public function boolean of_isalpha (string as_source)
public function boolean of_isalphanum (string as_source)
public function string of_quote (string as_source)
public function boolean of_isspace (string as_source)
public function boolean of_ispunctuation (string as_source)
public function long of_lastpos (string as_source, string as_target, long al_start)
public function long of_lastpos (string as_source, string as_target)
public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase)
public function string of_globalreplace (string as_source, string as_old, string as_new)
public function long of_countoccurrences (string as_source, string as_target)
public function long of_countoccurrences (string as_source, string as_target, boolean ab_ignorecase)
public function string of_righttrim (string as_source)
public function string of_lefttrim (string as_source)
public function string of_lefttrim (string as_source, boolean ab_remove_spaces)
public function string of_lefttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint)
public function string of_righttrim (string as_source, boolean ab_remove_spaces)
public function string of_righttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint)
public function string of_trim (string as_source)
public function string of_trim (string as_source, boolean ab_remove_spaces)
public function string of_trim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint)
public function string of_getkeyvalue (string as_source, string as_keyword, string as_separator)
public function integer of_setkeyvalue (ref string as_source, string as_keyword, string as_keyvalue, string as_separator)
public function string of_wordcap (string as_source)
public function string of_removenonprint (string as_source)
public function boolean of_isempty (string as_source)
public function boolean of_isprintable (string as_source)
public function boolean of_isformat (string as_source)
public function string of_removewhitespace (string as_source)
public function boolean of_IsComparisonOperator (string as_source)
public function boolean of_IsArithmeticOperator (string as_source)
public function string of_removequotes (string as_source)
public function string of_padnumber (string as_source, integer ai_length)
public function string of_replacenonalphanum (string as_source)
public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string)
public function integer of_getyyyydates (ref string as_date)
public function string of_clean_string (string as_string)
public function any of_stringtoarray (string as_string, string as_delimiter)
public function string of_unfix_dwtext (string as_string)
public function string of_fix_dwtext (string as_string)
public function integer of_sortarray (ref string as_source[], boolean ab_remove_dups)
public function string of_clean_string_acc (string as_text)
public subroutine of_clean_label (ref string as_label)
public function integer of_removeduplicates (ref string as_source[])
public function long of_char_string (string as_string, ref character ac_char[])
public function long of_string_char (character ac_char[], ref string as_string[])
end prototypes

public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.
//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = as_source
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0 then
	ll_count++
	as_Array[ll_Count] = ls_holder
end if

//Return the number of entries found
Return ll_Count

end function

public function string of_gettoken (ref string as_source, string as_separator);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetToken
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string passed by reference
//	as_separator	Separator character in the source string which will be 
//						used to determine the length of characters to strip from
//						the left end of the source string.
//
//	Returns:  		string
//						The token stripped off of the source string.
//						If the separator character does not appear in the string, 
//						the entire source string is returned.
//						Otherwise, it returns the token stripped off of the left
//						end of the source string (not including the separator character)
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	This function strips a source string (from the left) up 
//						to the occurrence of a specified separator character.
//
//
//////////////////////////////////////////////////////////////////////////////

int 		li_pos
string 	ls_ret

//Check parameters
If IsNull(as_source) or IsNull(as_separator) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

/////////////////////////////////////////////////////////////////////////////////
// Get the position of the separator
/////////////////////////////////////////////////////////////////////////////////
li_pos = Pos(as_source, as_separator)	

/////////////////////////////////////////////////////////////////////////////////
// Compute the length of the token to be stripped off of the source string.
/////////////////////////////////////////////////////////////////////////////////

// If no separator, the token to be stripped is the entire source string
if li_pos = 0 then
	ls_ret = as_source
	as_source = ""	
else
	// Otherwise, return just the token and strip it & the separator from the source string
	ls_ret = Mid(as_source, 1, li_pos - 1)
	as_source = Right(as_source, Len(as_source) - (li_pos+Len(as_separator)-1) )
end if

return ls_ret
end function

public function string of_padleft (string as_source, long al_length);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_PadLeft
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	al_length		The desired length of the string.
//
//	Returns:  		String
//						A string of length al_length wich contains as_source with
//						spaces added to its left.
//						If any argument's value is NULL, function returns NULL.
//						If al_length is less or equal to length of as_source, the 
//						function returns the original as_source.
//
//	Description:  	Pad the original string with spaces on its left to make it of
//					   the desired length.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_cnt
string	ls_return

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(al_length) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Check for the lengths
If al_length <= Len(as_Source) Then
	//Return the original string
	Return as_source
End If

//Create the left padded string
ls_return = space(al_length - Len(as_Source)) + as_source

//Return the left padded string
Return ls_return
end function

public function string of_padright (string as_source, long al_length);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_PadRight
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	al_length		The desired length of the string.
//
//	Returns:  		String
//						A string of length al_length wich contains as_source with
//						spaces added to its right.
//						If any argument's value is NULL, function returns NULL.
//						If al_length is less or equal to length of as_source, the 
//						function returns the original as_source.
//
//	Description:  	Pad the original string with spaces on its right to make it of
//					   the desired length.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_cnt
string	ls_return

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(al_length) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Check for the lengths
If al_length <= Len(as_Source) Then
	//Return the original string
	Return as_source
End If

//Create the right padded string
ls_return = as_source + space(al_length - Len(as_Source))

//Return the right padded string
Return ls_return
end function

public function boolean of_islower (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsLower
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains lowercase characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only lowercase 
//						characters.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If as_source = Lower(as_source) Then
	Return True
Else
	Return False
End If
end function

public function boolean of_isupper (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsUpper
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains uppercase characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only uppercase 
//						characters.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

If as_source = Upper(as_source) Then
	Return True
Else
	Return False
End If
end function

public function boolean of_iswhitespace (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsWhiteSpace
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains White Space characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only White Space
//						characters. White Space characters include Newline, Tab,
//						Vertical tab, Carriage return, Formfeed, and Backspace.
//
//////////////////////////////////////////////////////////////////////////////

long 		ll_count=0
long 		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non WhiteSpace character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii=8	or			/* BackSpae */		 		& 
		li_ascii=9 	or			/* Tab */		 			& 
		li_ascii=10 or			/* NewLine */				& 
		li_ascii=11 or			/* Vertical Tab */		& 
		li_ascii=12 or			/* Form Feed */			& 
		li_ascii=13 or			/* Carriage Return */	&
		li_ascii=32 Then		/* Space */		
		//Character is a WhiteSpace.
		//Continue with the next character.
	Else
		/* Character is Not a White Space. */
		Return False
	End If
loop
	
// Entire string is White Space.
return True

end function

public function boolean of_isalpha (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsAlpha
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains alphabetic characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only alphabetic
//						characters.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Alpha character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// 'A'=65, 'Z'=90, 'a'=97, 'z'=122
	if li_ascii<65 or (li_ascii>90 and li_ascii<97) or li_ascii>122 then
		/* Character is Not an Alpha */
		Return False
	end if
loop
	
// Entire string is alpha.
return True
end function

public function boolean of_isalphanum (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsAlphaNum
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains alphabetic and Numeric
//						characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only alphabetic and
//						numeric characters.
//
//////////////////////////////////////////////////////////////////////////////

long ll_count=0
long ll_length
char lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters.
//Quit loop if Non Alphanemeric character is found.
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// '0'= 48, '9'=57, 'A'=65, 'Z'=90, 'a'=97, 'z'=122
	If li_ascii<48 or (li_ascii>57 and li_ascii<65) or &
		(li_ascii>90 and li_ascii<97) or li_ascii>122 then
		/* Character is Not an AlphaNumeric */
		Return False
	end if
loop
	
// Entire string is AlphaNumeric.
return True

end function

public function string of_quote (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Quote
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		String
//						The original string enclosed in quotations.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Enclose the original string in quotations.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	Return as_source
End If

// Enclosed original string in quotations.
return '"' + as_source + '"'

end function

public function boolean of_isspace (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsSpace
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains space characters. 
//						False if the string is empty or if it contains other
//						non-space characters.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only space characters.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Check for an empty string
If Len(as_source)=0 Then
	Return False
End If

If Trim(as_source) = '' Then
	// Entire string is made of spaces.
	return True
end if

//String is not made up entirely of spaces.
Return False

end function

public function boolean of_ispunctuation (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsPunctuation
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains punctuation characters.
//						If as_source is NULL, the function returns NULL.
//
//	Description:  	Determines whether a string contains only punctuation
//						characters.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Punctuation character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii=33 or			/* '!' */		 & 
		li_ascii=34 or			/* '"' */		 & 
		li_ascii=39 or			/* ''' */		 & 
		li_ascii=44 or			/* ',' */		 & 
		li_ascii=46 or			/* '.' */		 & 
		li_ascii=58 or			/* ':' */		 & 
		li_ascii=59 or			/* ';' */		 & 	
		li_ascii=63 Then 		/* '?' */
		//Character is a punctuation.
		//Continue with the next character.
	Else
		Return False
	End If
loop
	
// Entire string is punctuation.
return True

end function

public function long of_lastpos (string as_source, string as_target, long al_start);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LastPos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The being searched for.
//	al_start			The starting position, 0 means start at the end.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Search backwards through a string to find the last occurrence 
//						of another string.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If Len(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=Len(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -1
	ll_Pos = Pos(as_Source, as_Target, ll_Cnt)
	If ll_Pos = ll_Cnt Then 
		//String was found
		Return ll_Cnt
	End If
Next

//String was not found
Return 0

end function

public function long of_lastpos (string as_source, string as_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LastPos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The string being searched for.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  Search backwards through a string to find the last occurrence of another string
//
//////////////////////////////////////////////////////////////////////////////

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Set the starting position and perform the search
Return of_LastPos (as_source, as_target, Len(as_Source))

end function

public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Start, ll_OldLen, ll_NewLen
String ls_Source

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) or IsNull(ab_ignorecase) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = Len(as_Old)
ll_NewLen = Len(as_New)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_source = Lower(as_source)
Else
	ls_source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_Old)

Do While ll_Start > 0
	// replace as_Old with as_New
	as_Source = Replace(as_Source, ll_Start, ll_OldLen, as_New)
	
	//Should function respect case.
	If ab_ignorecase Then 
		ls_source = Lower(as_source)
	Else
		ls_source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

Return as_Source

end function

public function string of_globalreplace (string as_source, string as_old, string as_new);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// 
//Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_Start, li_OldLen, li_NewLen

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//The default is to ignore Case
as_Source = of_GlobalReplace (as_source, as_old, as_new, True)

Return as_Source


end function

public function long of_countoccurrences (string as_source, string as_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_CountOccurrences
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string in which to search.
//	as_Target		The string to search for.
//
//	Returns: 		long
//						The number of occurrences of as_Target in as_source.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Count the occurrences of one string within another.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Count

//Check for parameters
If IsNull(as_source) or IsNull(as_target) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Default is to ignore case.
ll_Count = of_CountOccurrences (as_source, as_target, True)

Return ll_Count

end function

public function long of_countoccurrences (string as_source, string as_target, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_CountOccurrences
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string in which to search.
//	as_Target		The string to search for.
//	ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns: 		long
//						The number of occurrences of as_Target in as_source.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Count the occurrences of one string within another.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Count, ll_Pos, ll_Len

//Check for parameters
If IsNull(as_source) or IsNull(as_target) or IsNull(ab_ignorecase) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Should function ignore case?
If ab_ignorecase Then
	as_source = Lower(as_source)
	as_target = Lower(as_target)
End If

ll_Len = Len(as_Target)
ll_Count = 0

ll_Pos = Pos(as_source, as_Target)

Do While ll_Pos > 0
	ll_Count ++
	ll_Pos = Pos(as_source, as_Target, (ll_Pos + ll_Len))
Loop

Return ll_Count

end function

public function string of_righttrim (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RightTrim
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string to be trimmed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the right end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the right end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the end of a string.
//							Remove nonprintable characters from the end of a string.
//							Remove spaces and nonprintable characters from the end 
//							of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=True, NonPrintCharacters=False
return of_RightTrim (as_source, True, False)
end function

public function string of_lefttrim (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LeftTrim
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string to be trimmed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the left end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning of a string.
//							Remove nonprintable characters from the beginning of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=True, NonPrintCharacters=False
return of_LeftTrim (as_source, True, False)
end function

public function string of_lefttrim (string as_source, boolean ab_remove_spaces);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LeftTrim
//
//	Access:  		public
//
//	Arguments:
//	as_source			The string to be trimmed.
//	ab_remove_spaces	A boolean stating if spaces should be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the left end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning of a string.
//							Remove nonprintable characters from the beginning of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) or IsNull(ab_remove_spaces) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=ab_remove_spaces, NonPrintCharacters=False
return of_LeftTrim (as_source, ab_remove_spaces, False)
end function

public function string of_lefttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LeftTrim
//
//	Access:  		public
//
//	Arguments:
//	as_source				The string to be trimmed.
//	ab_remove_spaces		A boolean stating if spaces should be removed.
//	ab_remove_nonprint	A boolean stating if nonprint characters should be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the left end of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the left end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning of a string.
//							Remove nonprintable characters from the beginning of a string.
//							Remove spaces and nonprintable characters from the beginning of a string.
//////////////////////////////////////////////////////////////////////////////

char		lc_char
boolean	lb_char
boolean	lb_printable_char

//Check parameters
If IsNull(as_source) or IsNull(ab_remove_spaces) or IsNull(ab_remove_nonprint) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

If ab_remove_spaces and ab_remove_nonprint Then
	// Remove spaces and nonprintable characters from the beginning of a string.
	do while Len (as_source) > 0 and not lb_char
		lc_char = as_source
		if of_IsPrintable(lc_char) and Not of_IsSpace(lc_char) then
			lb_char = true
		else
			as_source = Mid (as_source, 2)
		end if
	loop
	return as_source
ElseIf ab_remove_nonprint Then
	// Remove nonprintable characters from the beginning of a string.
	do while Len (as_source) > 0 and not lb_printable_char
		lc_char = as_source
		if of_IsPrintable(lc_char) then
			lb_printable_char = true
		else
			as_source = Mid (as_source, 2)
		end if
	loop
	return as_source
ElseIf ab_remove_spaces Then
	//Remove spaces from the beginning of a string.
	return LeftTrim(as_source)
End If

return as_source


end function

public function string of_righttrim (string as_source, boolean ab_remove_spaces);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RightTrim
//
//	Access:  		public
//
//	Arguments:
//	as_source			The string to be trimmed.
//	ab_remove_spaces	A boolean stating if spaces should be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the right end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the right end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the end of a string.
//							Remove nonprintable characters from the end of a string.
//							Remove spaces and nonprintable characters from the end 
//							of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) or IsNull(ab_remove_spaces) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove spaces=ab_remove_spaces, NonPrintCharacters=False
return of_RightTrim (as_source, ab_remove_spaces, False)
end function

public function string of_righttrim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RightTrim
//
//	Access:  		public
//
//	Arguments:
//	as_source				The string to be trimmed.
//	ab_remove_spaces		A boolean stating if spaces should be removed.
//	ab_remove_nonprint	A boolean stating if nonprint characters should be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the right
//						end of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the right end of a string.
//						The options depending on the parameters are:
//							Remove spaces from the end of a string.
//							Remove nonprintable characters from the end of a string.
//							Remove spaces and nonprintable characters from the end of
//							a string.
//////////////////////////////////////////////////////////////////////////////

boolean	lb_char
char		lc_char
boolean	lb_printable_char

//Check parameters
If IsNull(as_source) or IsNull(ab_remove_spaces) or IsNull(ab_remove_nonprint) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

If ab_remove_spaces and ab_remove_nonprint Then
	// Remove spaces and nonprintable characters from the end of a string.
	do while Len (as_source) > 0 and not lb_char
		lc_char = Right (as_source, 1)
		if of_IsPrintable(lc_char) and Not of_IsSpace(lc_char) then
			lb_char = true
		else
			as_source = Left (as_source, Len (as_source) - 1)
		end if
	loop
	return as_source
	
ElseIf ab_remove_nonprint Then
	// Remove nonprintable characters from the end of a string.
	do while Len (as_source) > 0 and not lb_printable_char
		lc_char = Right (as_source, 1)
		if of_IsPrintable(lc_char) then
			lb_printable_char = true
		else
			as_source = Left (as_source, Len (as_source) - 1)
		end if
	loop
	return as_source
	
ElseIf ab_remove_spaces Then
	//Remove spaces from the end of a string.
	return RightTrim(as_source)
End If

return as_source
end function

public function string of_trim (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Trim
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string to be trimmed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the left and right end of 
//						a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning and end of a string.
//							Remove nonprintable characters from the beginning and 
//							end of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning and end of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove Spaces=True, NonPrintCharacters=False
return of_Trim (as_source, True, False)

end function

public function string of_trim (string as_source, boolean ab_remove_spaces);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Trim
//
//	Access:  		public
//
//	Arguments:
//	as_source			The string to be trimmed.
//	ab_remove_spaces	A boolean stating if spaces should be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the left end 
//						of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the left and right end of 
//						a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning and end of a string.
//							Remove nonprintable characters from the beginning and 
//							end of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning and end of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) or IsNull(ab_remove_spaces) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

// Remove Spaces=ab_remove_spaces, NonPrintCharacters=False
return of_Trim (as_source, ab_remove_spaces, False)

end function

public function string of_trim (string as_source, boolean ab_remove_spaces, boolean ab_remove_nonprint);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Trim
//
//	Access:  		public
//
//	Arguments:
//	as_source				The string to be trimmed.
//	ab_remove_spaces		A boolean stating if spaces should be removed.
//	ab_remove_nonprint	A boolean stating if nonprint characters should be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed from the left and 
//						right end of the string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes desired characters from the left and right end of 
//						a string.
//						The options depending on the parameters are:
//							Remove spaces from the beginning and end of a string.
//							Remove nonprintable characters from the beginning and 
//							end of a string.
//							Remove spaces and nonprintable characters from the 
//							beginning and end of a string.
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) or IsNull(ab_remove_spaces) or IsNull(ab_remove_nonprint) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

If ab_remove_spaces and ab_remove_nonprint Then
	// Remove spaces and nonprintable characters from the beginning and end 
	// of a string.
	as_source = of_LeftTrim (as_source, ab_remove_spaces, ab_remove_nonprint)
	as_source = of_RightTrim(as_source, ab_remove_spaces, ab_remove_nonprint)

ElseIf ab_remove_nonprint Then
	// Remove nonprintable characters from the beginning and end
	// of a string.
	as_source = of_LeftTrim (as_source, ab_remove_spaces, ab_remove_nonprint)
	as_source = of_RightTrim(as_source, ab_remove_spaces, ab_remove_nonprint)

ElseIf ab_remove_spaces Then
	//Remove spaces from the beginning and end of a string.
	as_source = Trim(as_source)

End If

return as_source
end function

public function string of_getkeyvalue (string as_source, string as_keyword, string as_separator);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetKeyValue
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string to be searched.
//	as_keyword		The keyword to be searched for.
//	as_separator	The separator character used in the source string.
//
//	Returns:  		string	
//						The value found for the keyword.
//						If no matching keyword is found, an empty string is returned.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Gets the value portion of a keyword=value pair from a string.
//
//////////////////////////////////////////////////////////////////////////////

boolean	lb_done=false
integer	li_keyword, &
			li_separator, &
			li_equal
string	ls_keyvalue

//Check parameters
If IsNull(as_source) or IsNull(as_keyword) or IsNull(as_separator) Then
	string ls_null
	SetNull (ls_null)
	Return ls_null
End If

//Initialize key value
ls_keyvalue = ''

do while not lb_done
	li_keyword = Pos (Lower(as_source), Lower(as_keyword))
	if li_keyword > 0 then
		as_source = LeftTrim(Right(as_source, Len(as_source) - (li_keyword + Len(as_keyword) - 1)))

		if Left(as_source, 1) = "=" then
			li_separator = Pos (as_source, as_separator, 2)
			if li_separator > 0 then
				ls_keyvalue = Mid(as_source, 2, li_separator - 2)
			else
				ls_keyvalue = Mid(as_source, 2)
			end if
			ls_keyvalue = Trim(ls_keyvalue)
			lb_done = true
		end if
	else
		lb_done = true
	end if
loop

return ls_keyvalue
end function

public function integer of_setkeyvalue (ref string as_source, string as_keyword, string as_keyvalue, string as_separator);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetKeyValue
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string to have the set performed on.  Passed by reference.
//							Format:  keyword = value; ...
//	as_keyword		The keyword to set a value for.
//	as_keyvalue		The new value for the specified keyword.
//	as_separator	The separator character used in the source string.
//
//	Returns:			integer
//						1 Successful operation.
//						-1 The specified keywork did not exist in the source string.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:	Sets the value portion of a keyword=value pair from a string
//
//////////////////////////////////////////////////////////////////////////////


integer	li_found=-1
integer	li_keyword, &
			li_separator, &
			li_equal
string	ls_temp

//Check paramemeters
If IsNull(as_source) or IsNull(as_keyword) or IsNull(as_keyvalue) or IsNull(as_separator) Then
	integer li_null
	SetNull (li_null)
	Return li_null
End If

do 
	li_keyword = Pos (Lower(as_source), Lower(as_keyword), li_keyword + 1)
	if li_keyword > 0 then
		ls_temp = LeftTrim (Right (as_source, Len(as_source) - (li_keyword + Len(as_keyword) - 1)))
		if Left (ls_temp, 1) = "=" then
			li_equal = Pos (as_source, "=", li_keyword + 1)
			li_separator = Pos (as_source, as_separator, li_equal + 1)
			if li_separator > 0 then
				as_source = Left(as_source, li_equal) + as_keyvalue + as_separator + Right(as_source, Len(as_source) - li_separator)
			else
				as_source = Left(as_source, li_equal) + as_keyvalue
			end if
			li_found = 1
		end if
	end if
loop while li_keyword > 0

return li_found
end function

public function string of_wordcap (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_WordCap
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		String
//						Returns string with the first letter of each word set to
//						uppercase and the remaining letters lowercase if it succeeds
//						and NULL if an error occurs.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Sets the first letter of each word in a string to a capital 
//						letter and all other letters to lowercase (for example, 
//						ROBERT E. LEE would be Robert E. Lee).
//////////////////////////////////////////////////////////////////////////////

integer	li_pos
boolean	lb_capnext
string 	ls_ret
long		ll_stringlength
char		lc_char
char		lc_string[]

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get and check length
ll_stringlength = Len(as_source)
If ll_stringlength = 0 Then
	Return as_source
End If

//Convert all characters to lowercase and put it into Character Array
lc_string = Lower(as_source)

//The first character should be capitalized
lb_capnext = TRUE

//Loop through the entire string
For li_pos = 1 to ll_stringlength
	//Get one character at a time
	lc_char = lc_string[li_pos]
	
	If Not of_IsAlpha(lc_char) Then
		//The next character should be capitalized
		lb_capnext = True
	ElseIf lb_capnext Then
		//Capitalize this Alphabetic character
		lc_string[li_pos] = Upper(lc_char)
		//The next character should not be capitalized
		lb_capnext = False
	End If
Next

//Copy the Character array back to a string variable
ls_ret = lc_string

//Return the 
return ls_ret
end function

public function string of_removenonprint (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RemoveNonPrint
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string from which all nonprint characters are to
//						be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes all nonprint characters.
//
//////////////////////////////////////////////////////////////////////////////

char		lch_char
boolean	lb_printable_char
long		ll_pos = 1
long		ll_loop
string	ls_source
long		ll_source_len

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

ls_source = as_source
ll_source_len = Len(ls_source)

// Remove nonprintable characters 
FOR ll_loop = 1 TO ll_source_len
	lch_char = Mid(ls_source, ll_pos, 1)
	if of_IsPrintable(lch_char) then
		ll_pos ++	
	else
		ls_source = Replace(ls_source, ll_pos, 1, "")
	end if 
NEXT

Return ls_source

end function

public function boolean of_isempty (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsEmpty
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string has a lenght of 0 or is NULL.
//
//	Description:  	Determines whether a string has a lenght of 0 or is NULL.
//
//////////////////////////////////////////////////////////////////////////////

if IsNull(as_source) or Len(as_source)=0 then
	//String is empty
	Return True
end if
	
//String is Not empty
return False
end function

public function boolean of_isprintable (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsPrintable
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains Printable characters.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string is composed entirely of 
//						Printable characters.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if NonPrintable character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// 'space'=32, '~'=126
	if li_ascii<32 or li_ascii>126 then
		/* Not a printable character */
		Return False
	end if
loop
	
// Entire string is of printable characters.
return True

end function

public function boolean of_isformat (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsFormat
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains Formatting characters.
//						If as_source is NULL, the function returns NULL.
//
//	Description:  	Determines whether a string contains only Formatting
//						characters.  Format characters for this function
//						are all printable characters that are not AlphaNumeric.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Operator character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If (li_ascii>=33 and li_ascii<=47) or &
		(li_ascii>=58 and li_ascii<=64) or &
		(li_ascii>=91 and li_ascii<=96) or &
		(li_ascii>=123 and li_ascii<=126) Then
		//Character is a Format.
		//Continue with the next character.
	Else
		Return False
	End If
loop
	
// Entire string is made of Format characters.
return True

end function

public function string of_removewhitespace (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RemoveWhiteSpace
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string from which all WhiteSpace characters are to
//						be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes all WhiteSpace characters.
//
//////////////////////////////////////////////////////////////////////////////

char		lch_char
boolean	lb_printable_char
long		ll_pos = 1
long		ll_loop
string	ls_source
long		ll_source_len

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

ls_source = as_source
ll_source_len = Len(ls_source)

// Remove WhiteSpace characters 
FOR ll_loop = 1 TO ll_source_len
	lch_char = Mid(ls_source, ll_pos, 1)
	if Not of_IsWhiteSpace(lch_char) then
		ll_pos ++	
	else
		ls_source = Replace(ls_source, ll_pos, 1, "")
	end if 
NEXT

Return ls_source

end function

public function boolean of_IsComparisonOperator (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsComparisonOperator
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains Comparison Operator
//						characters.
//						If as_source is NULL, the function returns NULL.
//
//	Description:  	Determines whether a string contains only Comparison
//						Operator characters.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Operator character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii=60 or			/* < less than */	 & 
		li_ascii=61 or			/* = equal */		 & 
		li_ascii=62 Then		/* > greater than */
		//Character is an Comparison Operator.
		//Continue with the next character.
	Else
		Return False
	End If
loop
	
// Entire string is made of Comparison Operators.
return True

end function

public function boolean of_IsArithmeticOperator (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsArithmeticOperator
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains Arithmetic Operator
//						characters.
//						If as_source is NULL, the function returns NULL.
//
//	Description:  	Determines whether a string contains only Arithmetic
//						Operator characters.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Operator character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	If li_ascii=40 or			/* ( left parenthesis */	 & 
		li_ascii=41 or			/* ) right parenthesis */	 & 
		li_ascii=43 or			/* + addition */				 & 
		li_ascii=45 or			/* - subtraction */			 & 
		li_ascii=42 or			/* * multiplication */		 & 
		li_ascii=47 or			/* / division */				 & 
		li_ascii=94 Then		/* ^ power */	
		//Character is an operator.
		//Continue with the next character.
	Else
		Return False
	End If
loop
	
// Entire string is made of arithmetic operators.
return True

end function

public function string of_removequotes (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RemoveQuotes
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string from which all " or ' characters are to
//						be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes all single quote (') and double quote (") characters.
//
//////////////////////////////////////////////////////////////////////////////

string		ls_string

int			loop_ix

IF IsNull(as_source) THEN
	string ls_null
	SetNull(ls_null)
	RETURN ls_null
END IF

FOR loop_ix = 1 TO len(as_source)
	IF mid(as_source,loop_ix,1) = "'" &
	OR mid(as_source,loop_ix,1) = '"' THEN
		// Bypass
	ELSE
		ls_string += mid(as_source,loop_ix,1)
	END IF
NEXT

RETURN ls_string
end function

public function string of_padnumber (string as_source, integer ai_length);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_PadNumber
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	ai_length		The desired length of the integer.
//
//	Returns:  		String
//						A numeric string of length ai_length wich contains as_source with
//						zeros added to its left.
//						If any argument's value is NULL, function returns NULL.
//						If as_source is not number, function returns NULL.
//						If ai_length is less or equal to length of as_source, the 
//						function returns the original as_source.
//
//	Description:  	Pad the original numeric string with zeros on its left to make it of
//					   the desired length.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_return,	&
			ls_source,	&
			ls_null

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(ai_length) Then
	SetNull(ls_null)
	Return ls_null
End If

//Verify that a number was passed
if not isnumber(as_source) then
	SetNull(ls_null)
	Return ls_null
end if

//Check for the lengths
If ai_length <= Len(as_source) Then
	//Return the original string
	Return as_source
End If

//Create the left padded string
ls_return = fill('0',ai_length - Len(as_source)) + as_source

//Return the left padded string
Return ls_return
end function

public function string of_replacenonalphanum (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ReplaceNonAlphaNum
//
//	Access:  		public
//
//	Arguments:
//	as_source		The string from which all non-alphanumeric characters are to
//						be replaced with spaces.
//
//	Returns:  		string
//						as_source with all desired characters are replaced with spaces.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Replaces all non-alphanumeric characters with spaces.
//
//////////////////////////////////////////////////////////////////////////////

char		lch_char,			&
			lch_char2
boolean	lb_printable_char
long		ll_pos = 1
long		ll_loop
string	ls_source
long		ll_source_len

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

ls_source = as_source
ll_source_len = Len(ls_source)

// Remove nonprintable characters 
FOR ll_loop = 1 TO ll_source_len
	lch_char = Mid(ls_source, ll_pos, 1)
	if of_IsAlphaNum(lch_char) then
		ll_pos ++	
	else
		lch_char2	=	Mid(ls_source, ll_pos + 1, 1)
		if	 lch_char	=	'~~'									&
		and (lch_char2	=	'n'	or	lch_char2	=	'r')	THEN
			//	Have a ~r or ~n.  Replace this with a space.
			ls_source	=	Left (ls_source, ll_pos - 1)	+	' '	+	Mid (ls_source, ll_pos + 2)
			ll_source_len	--
			ll_loop			--
		else
			ls_source = Replace(ls_source, ll_pos, 1, " ")
			ll_pos ++
		end if
	end if 
NEXT

Return ls_source

end function

public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ArrayToString
//
//	Access:  		public
//
//	Arguments:
//	as_source[]		The array of string to be moved into a single string.
//	as_Delimiter	The delimeter string.
//	as_ref_string	The string to be filled with the array of strings,
//						passed by reference.
//
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//
//	Description:  	Create a single string from an array of strings separated by
//						the passed delimeter.
//						Note: Function will not include on the single string any 
//								array entries which match an empty string.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_ArrayUpBound
string 	ls_holder
boolean	lb_EntryFound = False

//Get the array size
ll_ArrayUpBound = UpperBound(as_source[])

//Check parameters
IF IsNull(as_delimiter) or (Not ll_ArrayUpBound>0) Then
	Return -1
End If

//Reset the Reference string
as_ref_string = ''

For ll_Count = 1 to ll_ArrayUpBound
	//Do not include any entries that match an empty string
	If as_source[ll_Count] <> '' Then
		If Len(as_ref_string) = 0 Then
			//Initialize string
			as_ref_string = as_source[ll_Count]
		else
			//Concatenate to string
			as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
		End If
	End If
Next 

return 1

end function

public function integer of_getyyyydates (ref string as_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetYYYYDates
//
//	Arguments:		as_date (by reference).  Examples of the following formats:
//						07/01/1999
//						7/1/99
//						03/01/1999,03/31/1999
//						03/01/99,04/01/99
//						02/01/99,03/01/99,04/01/99,05/01/99
//
//	Returns:  		Integer
//						1 for a successful transfer.
//						-1 if a problem was found.
//
//	Description:  	This function takes a string as input (which can contain one
//						or more dates) and makes sure that each date has a 4 digit
//						year.  Stars Server expects all string dates has a 4 digit year.
//
//////////////////////////////////////////////////////////////////////////////
//	Modification History
//
//	FDG	11/05/01	Stars 5.0 (track 2520d).	Created.
//
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_done

Date		ldt_date

String	ls_date,				&
			ls_temp_date,		&
			ls_prev_date

ls_date	=	Trim (as_date)
as_date	=	""

DO WHILE lb_done	=	FALSE
	IF	Trim (ls_date)	=	""	THEN
		lb_done	=	TRUE
		Exit
	END IF
	// Get each date (separated by a comma) and convert the year to 4 digits
	ls_temp_date	=	This.of_GetToken (ls_date, ',')
	ls_prev_date	=	ls_temp_date
	ldt_date			=	Date (ls_temp_date)
	ls_temp_date	=	String (ldt_date, "mm/dd/yyyy")
	as_date			=	as_date	+	","	+	ls_temp_date
LOOP

// Remove the leading ","
IF	Len (as_date)	>	0		THEN
	as_date	=	Mid (as_date, 2)
END IF
			
Return	1



end function

public function string of_clean_string (string as_string);string	ls_string
char		lc_char
int		li_ascii, loop_ix
boolean	lb_space

as_string = trim(as_string)
as_string = this.of_GlobalReplace( as_string, "~r", " " )
as_string = this.of_GlobalReplace( as_string, "~n", " " )

FOR loop_ix = 1 TO len(as_string)
	
	lc_char  = mid(as_string,loop_ix)
	
	li_ascii = Asc (lc_char)
	
	CHOOSE CASE li_ascii
		CASE 8,10,11,12,13
			// Bypass
			// 8	 	BackSpace
			// 10  	NewLine
			// 11 	Vertical Tab
			// 12 	Form Feed
			// 13 	Carriage Return
			lb_space = FALSE
		CASE 9
			// Tab Character
			IF NOT lb_space THEN
				ls_string += ' '
			END IF
			lb_space = TRUE
		CASE 32
			// Space
			IF NOT lb_space THEN // Last Character was a space
				ls_string += string(lc_char)
			END IF
			lb_space = TRUE
		CASE ELSE
			ls_string += string(lc_char)
			lb_space = FALSE
	END CHOOSE
	
NEXT

RETURN ls_string

end function

public function any of_stringtoarray (string as_string, string as_delimiter);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_StringToArray
//
//	Access:  		public
//
//	Arguments:		as_ref_string	The string to be parsed into the array.
//						as_Delimiter	The delimeter string.
//
//	Returns:  		The array of string to be moved into a single string.
//
//	Description:  	Create an array of strings separated by
//						the passed delimeter from the single string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	07/29/05	GaryR	Track 4432d	Allow multi-column decode in background
//
//////////////////////////////////////////////////////////////////////////////


string		ls_array[], ls_string
int			li_len, li_delim, li_begin, li_pos, li_index

li_delim	= len(as_delimiter)
ls_string = as_string

// Loop through the string searching for delimiters
DO 
	li_index++
	
	li_len = len(ls_string)
	li_pos = pos(ls_string, as_delimiter)
	
	IF li_pos = 0 THEN	// String ends w/o delimiter
		ls_array[li_index] = ls_string
		li_begin = li_len + li_delim
	ELSE
		li_pos --
		ls_array[li_index] = left(ls_string,li_pos)		
		li_begin = li_pos + li_delim
		ls_string = mid(ls_string,li_pos + 2,li_len)	
	END IF
	
LOOP UNTIL li_begin >= li_len

RETURN ls_array


end function

public function string of_unfix_dwtext (string as_string);//=================================================================================================//
// Object	:	n_cst_string
//	Function	:	of_unfix_dwtext
//	Access	: 	public
//	Arguments:	as_string	The original (from datawndow) string
//	Returns	:  String		The modified (user friendly) version
//=================================================================================================//
// Modifies a string value to return it to the version the user originally enetered
//=================================================================================================//
// * Removes leading and trailing double quotes
// * Replaces ~~~" 	with "
// * Replaces &&		with &
//=================================================================================================//
// Maintenance
// -------- ----- -------- ------------------------------------------------------------------------
// 01/28/05 MikeF SPR4265d	Created function to centralize logic
//=================================================================================================//
as_string = trim(as_string)

IF len(as_string) = 0 THEN
	RETURN ""
END IF

// Remove leading quote
IF left(as_string,1) = '"' THEN
	as_string = mid(as_string,2)
END IF

// Remove trailing quote unless prefaced with ~
IF right(as_string,1)  = '"' THEN
	IF right(as_string,2) = '~"' THEN
	ELSE
		as_string = left(as_string,len(as_string) - 1)
	END IF
END IF

as_string = this.of_globalreplace( as_string, '~~~"', '"' )
as_string = this.of_globalreplace( as_string, '&&', '&' )

RETURN as_string

end function

public function string of_fix_dwtext (string as_string);//=================================================================================================//
// Object	:	n_cst_string
//	Function	:	of_fix_dwtext
//	Access	: 	public
//	Arguments:	as_string	The original (typed in) string
//	Returns	:  String		The modified (dw friendly) version
//=================================================================================================//
// Modifies a string value to allow it to be set using a modify statement.
//=================================================================================================//
// * Replaces " with ~~~"
// * Replaces & with &&
//=================================================================================================//
// Maintenance
// -------- ----- -------- ------------------------------------------------------------------------
// 01/28/05 MikeF SPR4265d	Created function to centralize logic
//=================================================================================================//
as_string = trim(as_string)

IF len(as_string) = 0 THEN
	RETURN ""
END IF

as_string = this.of_globalreplace( as_string, '"', '~~~"' )
as_string = this.of_globalreplace( as_string, '&', '&&' )

RETURN as_string

end function

public function integer of_sortarray (ref string as_source[], boolean ab_remove_dups);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SortArray
//
//	Access:  		public
//
//	Arguments:
//	as_source[]		(By Ref)	The array of string to be sorted.  Used as return as well.
//	ab_remove_dups				Flag to remove any duplicate values
//
//	Returns:  		Integer:	1 - Success, 0 - Nothing done, -1 - Failure
//
//	Description:  	Sort the values in the argument string array.
//						If necessary, remove any duplicate values.
//
//////////////////////////////////////////////////////////////////////////////
//
//	05/18/07	GaryR	Track 5027	Handle multiple values
//
//////////////////////////////////////////////////////////////////////////////

DataStore	lds_sort
String		ls_syntax, ls_err, ls_cur_val, ls_prev_val = "#SOME*INIT%VAL$"
Long 			ll_ctr, ll_cnt

//	Validate arguments
IF UpperBound( as_source ) < 2 THEN Return 0

//	Create the dummy datawindow
lds_sort = CREATE datastore
ls_syntax = 'release 6; datawindow() table(column=(type=char(255) name=a dbname="a") )'

IF lds_sort.Create( ls_syntax, ls_err ) < 0 THEN
	MessageBox( "ERROR", "Failed to create sort datawindow: " + ls_err, StopSign! )
	Return -1
END IF

// Put the array in the datastore
lds_sort.object.a.current = as_source
lds_sort.SetSort("a ASC")
lds_sort.Sort()

//	Remove dups if flagged
IF ab_remove_dups THEN
	ll_cnt = lds_sort.RowCount()
	FOR ll_ctr = 1 to ll_cnt
		ls_cur_val = lds_sort.object.a.current[ll_ctr]
		IF ls_cur_val = ls_prev_val THEN
			lds_sort.DeleteRow( ll_ctr )
			ll_ctr --
			ll_cnt --
		END IF
		ls_prev_val = lds_sort.object.a.current[ll_ctr]
	NEXT
END IF

// Get back the array
as_source = lds_sort.object.a.current
Destroy lds_sort

Return 1
end function

public function string of_clean_string_acc (string as_text);//*********************************************************************************
// Script Name:	of_clean_string_acc
//
// Arguments:	String	as_text
//
// Returns:		String
//
// Description:	This function will remove any extraneous characters from the
//						passed in string so that the accessibility property is more meaningful
//
//*********************************************************************************
//
//	04/29/09	GaryR	GNL.600.5633	Accommodate Section 508 Compliancy
//
//*********************************************************************************

//	Clean up text for Accessibility Properties
as_text = of_globalreplace( as_text, "~n~r", " ", TRUE )
as_text = of_globalreplace( as_text, "~r~n", " ", TRUE )
as_text = of_globalreplace( as_text, "~n", " ", TRUE )
as_text = of_globalreplace( as_text, "~r", " ", TRUE )
as_text = of_globalreplace( as_text, "~~n", " ", TRUE )
as_text = of_globalreplace( as_text, "~~r", " ", TRUE )
as_text = of_globalreplace( as_text, " & ", " and ", TRUE )
as_text = of_globalreplace( as_text, "&", "", TRUE )
as_text = of_globalreplace( as_text, "' ", " ", TRUE )
as_text = of_globalreplace( as_text, "'", "", TRUE )
as_text = of_globalreplace( as_text, '" ', " ", TRUE )
as_text = of_globalreplace( as_text, '"', "", TRUE )
as_text = of_globalreplace( as_text, "~~", "", TRUE )
as_text = of_globalreplace( as_text, ":", "", TRUE )

Return as_text
end function

public subroutine of_clean_label (ref string as_label);//*********************************************************************************
// Script Name:	of_clean_label
//
// Arguments:	String	by reference	as_label
//
// Returns:		None
//
// Description:	This function will remove the following characters
//						from the passed in string: ~n, ~r, " 
//						This is primarily called from Window operations.
//
//*********************************************************************************
//
//	07/17/09	GaryR	WIN.650.5721.002	Standardize logic that removes return characters
// 08/05/09	GaryR	WIN.650.5721.002	Defect #127 - Trim labels
//
//*********************************************************************************

// Remove special characters from label
as_label = of_globalreplace( as_label, "~n~r", " ", TRUE )
as_label = of_globalreplace( as_label, "~r~n", " ", TRUE )
as_label = of_globalreplace( as_label, "~n", " ", TRUE )
as_label = of_globalreplace( as_label, "~r", " ", TRUE )
as_label = of_globalreplace( as_label, "~~n", " ", TRUE )
as_label = of_globalreplace( as_label, "~~r", " ", TRUE )
as_label = of_globalreplace( as_label, '"', "", TRUE )

as_label = Trim( as_label, TRUE )
end subroutine

public function integer of_removeduplicates (ref string as_source[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RemoveDuplicates
//
//	Access:  		public
//
//	Arguments:
//	as_source[]		(By Ref)	The array of string to be checked for dups.  Used as return as well.
//	ab_remove_dups				Flag to remove any duplicate values
//
//	Returns:  		Integer:	1 - Success, 0 - Nothing done, -1 - Failure
//
//	Description:  	Check the values in the argument string array and 
//						remove any duplicate values.
//
//////////////////////////////////////////////////////////////////////////////
//
//	10/28/09 RickB Created
//
//////////////////////////////////////////////////////////////////////////////

DataStore	lds_dupcheck
String		ls_syntax, ls_err, ls_cur_val, ls_prev_val = "#SOME*INIT%VAL$"
Long 			ll_ctr, ll_cnt

//	Validate arguments
IF UpperBound( as_source ) < 2 THEN Return 0

//	Create the dummy datawindow
lds_dupcheck = CREATE datastore
ls_syntax = 'release 6; datawindow() table(column=(type=char(255) name=a dbname="a") )'

IF lds_dupcheck.Create( ls_syntax, ls_err ) < 0 THEN
	MessageBox( "ERROR", "Failed to create sort datawindow: " + ls_err, StopSign! )
	Return -1
END IF

// Put the array in the datastore
lds_dupcheck.object.a.current = as_source[]
// Uncomment to sort
//lds_dupcheck.SetSort("a ASC")					
//lds_dupcheck.Sort()

//	Remove dups
ll_cnt = lds_dupcheck.RowCount()
FOR ll_ctr = 1 to ll_cnt
	ls_cur_val = lds_dupcheck.object.a.current[ll_ctr]
	IF ls_cur_val = ls_prev_val THEN
		lds_dupcheck.DeleteRow( ll_ctr )
		ll_ctr --
		ll_cnt --
	END IF
	ls_prev_val = lds_dupcheck.object.a.current[ll_ctr]
NEXT

// Get back the array
as_source = lds_dupcheck.object.a.current
Destroy lds_dupcheck

Return 1
end function

public function long of_char_string (string as_string, ref character ac_char[]);//*********************************************************************************
// Script Name:	n_cst_string.of_char_string
//
// Arguments:	String	as_string	String to convert
//					Character By Ref	ac_char[]	String variable to search for
//
// Returns:		Long	Number of entries in the array
//
// Description:	This function converts a string to an array of chars.  If this
//						function is called again, the string is added to the end of the
//						array.  Each string is separated by a single null and there are
//						two nulls at the end.
//
//*********************************************************************************
// 
//	10/31/09	GaryR	EXP.650.4897.005	Add support for formatted export to all versions of Excel
//
//*********************************************************************************

Long ll_len, ll_char, ll_into

// copy string to array
ll_len = Len(as_string)
FOR ll_char = 1 TO ll_len
	If ll_char = 1 Then
		ll_into = UpperBound(ac_char)
		If ll_into = 0 Then
			ll_into = 1
		End If
	Else
		ll_into = UpperBound(ac_char) + 1
	End If
	ac_char[ll_into] = Mid(as_string, ll_char, 1)
NEXT

// terminate with two nulls
SetNull(ac_char[ll_into + 1])
SetNull(ac_char[ll_into + 2])

Return UpperBound(ac_char)
end function

public function long of_string_char (character ac_char[], ref string as_string[]);//*********************************************************************************
// Script Name:	n_cst_string.of_string_char
//
// Arguments:	ac_char[]		-	Character array
//					as_string[]		-	Output String array
//
// Returns:		Long - Number of entries in the string array
//
// Description:	 This function converts a character array into an array of
//						strings.  Each string is separated by a null entry.
//
//*********************************************************************************
// 
//	10/31/09	GaryR	EXP.650.4897.005	Add support for formatted export to all versions of Excel
//
//*********************************************************************************

Long ll_char, ll_max, ll_array = 1
String ls_empty[]

as_string = ls_empty

ll_max = UpperBound(ac_char)
FOR ll_char = 1 TO ll_max
	If ac_char[ll_char] = Char(0) Then
		If ac_char[ll_char + 1] = Char(0) Then
			Exit
		Else
			ll_array = ll_array + 1
		End If
	Else
		as_string[ll_array] += String(ac_char[ll_char])
	End If
NEXT

Return UpperBound(as_string)
end function

on n_cst_string.create
call super::create
end on

on n_cst_string.destroy
call super::destroy
end on

