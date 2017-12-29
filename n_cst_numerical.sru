HA$PBExportHeader$n_cst_numerical.sru
$PBExportComments$PFC Base Numerical Service (inherited from n_base) <logic>
forward
global type n_cst_numerical from n_base
end type
end forward

global type n_cst_numerical from n_base autoinstantiate
end type

forward prototypes
public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit)
public function string of_binary (long al_decimal)
public function long of_decimal (string as_binary)
public function long of_BitwiseAnd (long al_value1, long al_value2)
public function long of_BitwiseOr (long al_value1, long al_value2)
public function long of_BitwiseXor (long al_value1, long al_value2)
public function long of_bitwisenot (long al_value)
public function boolean of_is_bitwise (long al_option, long al_value)
end prototypes

public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetBit
//
//	Access: 			public
//
//	Arguments:
//	al_decimal		Decimal value whose on/off value needs to be determined.
//	ai_bit			Position bit from right to left on the Decimal value.
//
//	Returns: 		boolean
//						True if the value is On.
//						False if the value is Off.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:   Determines if the nth binary bit of a decimal number is 
//						1 or 0.
//
//////////////////////////////////////////////////////////////////////////////

Boolean lb_null

//Check parameters
If IsNull(al_decimal) or IsNull(ai_bit) then
	SetNull(lb_null)
	Return lb_null
End If

//Assumption ai_bit is the nth bit counting right to left with
//the leftmost bit being bit one.
//al_decimal is a binary number as a base 10 long.
If (Mod(Int(al_decimal /  2 ^(ai_bit - 1)), 2) > 0) Then
	Return True
End If

Return False

end function

public function string of_binary (long al_decimal);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Binary
//
//	Access: 			public
//
//	Arguments:
//	al_decimal		Decimal value whose binary representation needs to be determined.
//
//	Returns: 		string
//						The binary representation of the decimal number.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns NULL.
//
//	Description:   Determines the Binary representation of a Decimal number.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_remainder
string	ls_binary=''

//Check parameters
If IsNull(al_decimal) or al_decimal< 0 Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

If al_decimal = 0 Then
	Return '0'
End If

Do Until al_decimal= 0
	li_remainder = mod(al_decimal, 2)
	al_decimal = al_decimal /2
	
	//Build binary string
	ls_binary = string(li_remainder) + ls_binary
Loop
Return ls_binary
end function

public function long of_decimal (string as_binary);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Decimal
//
//	Access: 			public
//
//	Arguments:
//	as_binary		Binary value whose Decimal representation needs to be determined.
//
//	Returns: 		string
//						The positive Decimal representation of the Binary number.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:   Determines the Decimal representation of a Binary number.
//
//////////////////////////////////////////////////////////////////////////////

integer 	li_cnt
long		ll_len
long		ll_power
char		lch_char[]
long		ll_decimal=0

//Check parameters
If IsNull(as_binary) or Len(as_binary)<=0 then
	long ll_null
	SetNull(ll_null)	
	Return ll_null
End If

//Get the length
ll_len = Len(as_binary)

//Move string into arrach of characters
lch_char = as_binary

For li_cnt = 1 to ll_len
	//Make sure only 0's and 1's are present
	If (Not lch_char[li_cnt]='1') AND (Not lch_char[li_cnt]='0') Then
		Return -1
	End If
	//Build the decimal equivalent
	ll_decimal = ll_decimal + (long(lch_char[li_cnt]) * (2 ^ (ll_len - li_cnt)))
Next

Return ll_decimal
end function

public function long of_BitwiseAnd (long al_value1, long al_value2);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BitwiseAnd
//
//	Access: 			public
//
//	Arguments:
//	al_Value1		The first value to be used in the operation.
//	al_Value2		The second value to be used in the operation.
//
//	Returns: 		Long
//						The result of the AND operation.
//						If either argument's value is NULL, function returns NULL.
//
//	Description:   Performs a bitwise AND operation (al_Value1 && al_Value2),
//						which ANDs each bit of the values.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_Cnt
Long			ll_Result
Boolean		lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
	SetNull(ll_Result)
	Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
	lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
	lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// And them together
For li_Cnt = 1 To 32
	If lb_Value1[li_Cnt] And lb_Value2[li_Cnt] Then
		ll_Result = ll_Result + (2^(li_Cnt - 1))
	End If
Next

Return ll_Result

end function

public function long of_BitwiseOr (long al_value1, long al_value2);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BitwiseOr
//
//	Access: 			public
//
//	Arguments:
//	al_Value1		The first value to be used in the operation.
//	al_Value2		The second value to be used in the operation.
//
//	Returns: 		Long
//						The result of the OR operation.
//						If either argument's value is NULL, function returns NULL.
//
//	Description:   Performs a bitwise OR operation (al_Value1 || al_Value2),
//						which ORs each bit of the values.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_Cnt
Long			ll_Result
Boolean		lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
	SetNull(ll_Result)
	Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
	lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
	lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// Or them together
For li_Cnt = 1 To 32
	If lb_Value1[li_Cnt] Or lb_Value2[li_Cnt] Then
		ll_Result = ll_Result + (2^(li_Cnt - 1))
	End If
Next

Return ll_Result

end function

public function long of_BitwiseXor (long al_value1, long al_value2);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BitwiseXor
//
//	Access: 			public
//
//	Arguments:
//	al_Value1		The first value to be used in the operation.
//	al_Value2		The second value to be used in the operation.
//
//	Returns: 		Long
//						The result of the XOR operation.
//						If either argument's value is NULL, function returns NULL.
//
//	Description:   Performs a bitwise exclusive OR operation (al_Value1 XOR al_Value2),
//						which exclusively ORs each bit of the values.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_Cnt
Long			ll_Result
Boolean		lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
	SetNull(ll_Result)
	Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
	lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
	lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// Perfor the XOR
For li_Cnt = 1 To 32
	If (lb_Value1[li_Cnt] And Not lb_Value2[li_Cnt]) Or &
		(Not lb_Value1[li_Cnt] And lb_Value2[li_Cnt]) Then
		ll_Result = ll_Result + (2^(li_Cnt - 1))
	End If
Next

Return ll_Result

end function

public function long of_bitwisenot (long al_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BitwiseNot
//
//	Access: 			public
//
//	Arguments:
//	al_Value		The value to be used in the operation e.g. 57.
//
//	Returns: 		Long
//						The result of the NOT operation.
//						If the argument's value is NULL, function returns NULL.
//
//	Description:   Performs a bitwise NOT operation (! al_Value),
//						which reverses each bit.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0     Initial version
// 5.0.02  Fixed function from returning negative wrong value
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_Cnt, li_Count
Long			ll_Result
string		ls_Value, ls_Result

// Check for nulls
If IsNull(al_Value) Then
	SetNull(ll_Result)
	Return ll_Result
End If

// return a binary string e.g. 100101
ls_Value = of_binary(al_Value)
li_Cnt = Len(ls_Value)

// change 0 to 1 and 1 to 0
For li_Count = 1 To li_Cnt
	If Mid(ls_Value, li_Count, 1) = '0' Then
		ls_Result = ls_Result + '1'
	Else
		ls_Result = ls_Result + '0'
	End If
End For
	
// return the result in decimal form e.g. 57	
Return of_decimal(ls_Result)	

end function

public function boolean of_is_bitwise (long al_option, long al_value);///////////////////////////////////////////////////////////////
//
//	12/11/04	GaryR	Track 4108d	Dynamic Report Options
//
///////////////////////////////////////////////////////////////

IF IsNull( al_option ) OR IsNull( al_value ) THEN Return FALSE
Return This.of_bitwiseand( al_option, al_value ) = al_option
end function

on n_cst_numerical.create
call super::create
end on

on n_cst_numerical.destroy
call super::destroy
end on

