$PBExportHeader$n_cst_attachments.sru
$PBExportComments$<logic>
forward
global type n_cst_attachments from n_base
end type
end forward

global type n_cst_attachments from n_base autoinstantiate
end type

type prototypes

end prototypes

type variables
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

Private:
//	04/25/07	GaryR	Track 4997	Convert LongLong to Decimal due to PB bug
Decimal idec_DfltFileSize = 2147483647

String	is_temp_dir = "ViPS\STARS\"

// File and OS service
n_cst_filesrv	inv_file
end variables

forward prototypes
public function integer of_insertfile (string as_fileid, string as_filepath)
public subroutine of_ask_delete_file (string as_filepath)
public function integer of_parse_filename (string as_filepath, ref string as_filename, ref string as_ext)
public function string of_get_filename (string as_fileid)
public function integer of_download (string as_fileid)
public function integer of_writefile (string as_fileid, string as_filepath)
public function integer of_view (string as_fileid)
public subroutine of_deletetempfiles ()
public function integer of_delete_cntl (string as_fileid)
public function string of_copy_cntl (string as_fileid)
public function string of_gettempdir ()
public function decimal of_getmaxfilesize ()
public function integer of_update_cntl (string as_fileid, decimal adec_filesize)
public function integer of_insert_cntl (string as_fileid, string as_filename, string as_filetype, decimal adec_filesize, string as_userid, datetime adt_current)
end prototypes

public function integer of_insertfile (string as_fileid, string as_filepath);///////////////////////////////////////////////////////////////////////////
//
//	This method will read the file into a blob based on the passed in path
// and update the blob FILE_CONTENTS column of FILE_CNTL 
//	NOTE: This method does not commit or rollback.  The caller must manage this
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

Blob		lbl_contents
Long		ll_fileread
Integer	li_filenum

as_filepath = Trim( as_filepath )

//	Validate arguments
IF IsNull( as_filepath ) OR Trim( as_filepath ) = "" &
OR IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid arguments passed to method of_insertfile.", StopSign! )
	Return -1
END IF

//	Check file
IF NOT FileExists( as_filepath ) THEN
	MessageBox( "Attachment Error", "File " + as_filepath + " does not exist!" + &
						"~n~rPlease verify the supplied file path and name.", StopSign! )
	Return -1
END IF

// Open file
li_filenum = FileOpen( as_filepath, StreamMode! )
IF li_filenum >= 0 THEN
	//worked fine
ELSE
	MessageBox( "Attachment Error", "Unable to open file " + as_filepath + &
						"~n~rPlease verify that you have sufficient rights to this file.", StopSign! )
	Return -1
END IF

// Read file
ll_fileread = FileReadEx( li_filenum, lbl_contents )
IF IsNull( ll_fileread ) OR ll_fileread = -1 THEN
	MessageBox( "Attachment Error", "Unable to read file " + as_filepath + &
						"~n~rPlease verify that you have sufficient rights to this file.", StopSign! )
	FileClose( li_filenum )
	Return -1
END IF

//	Close file
FileClose( li_filenum )

// Update contents
UPDATEBLOB file_cntl
SET file_contents = :lbl_contents
WHERE file_id = :as_fileid
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Attachment Error", "Unable to update data into FILE_CNTL" + &
	"~n~rError: " + Stars2ca.SQLErrText, StopSign! )
	Return -1
END IF

Return 1
end function

public subroutine of_ask_delete_file (string as_filepath);///////////////////////////////////////////////////////////////////////////
//
//	This method will prompt the user to delete the file from the system
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

//	Validate arguments
IF IsNull( as_filepath ) OR Trim( as_filepath ) = "" THEN
	MessageBox( "Attachment Error", "Invalid argument passed to method of_ask_delete_file.", StopSign! )
	Return 
END IF

IF MessageBox( "Attachment", "The file has been successfully attached to Case." + &
							"~n~rWould you like to delete the source file: " + &
							as_filepath, Question!, YesNo! ) = 1 THEN
	IF NOT inv_file.of_FileDelete( as_filepath ) THEN
		MessageBox( "Attachment Warning", "Unable to delete file: " + as_filepath, Exclamation! )
	END IF
END IF
end subroutine

public function integer of_parse_filename (string as_filepath, ref string as_filename, ref string as_ext);//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

String	ls_test

Return inv_file.of_parsepath( as_filepath, ls_test, ls_test, as_filename, as_ext )
end function

public function string of_get_filename (string as_fileid);///////////////////////////////////////////////////////////////////////////
//
//	This method will get the FILE_NAME and FILE_TYPE from FILE_CNTL
//	The concatinated result will be the Windows filename.fileextension
//
//	Returns: filename.fileextension
//				"" = Error
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	07/23/08	GaryR	SPR 5409	Accommodate column concatenation in MSS
//
///////////////////////////////////////////////////////////////////////////

String	ls_filename, ls_filetype

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid argument passed to method of_get_filename.", StopSign! )
	Return ""
END IF

SELECT file_name, file_type
INTO :ls_filename, :ls_filetype
FROM FILE_CNTL
WHERE FILE_ID = :as_fileid
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 OR IsNull( ls_filename ) OR Trim( ls_filename ) = "" &
OR IsNull( ls_filetype ) OR Trim( ls_filetype ) = "" THEN
	MessageBox( "Attachment Error", "Unable to identify row in FILE_CNTL for FILE_ID " + as_fileid, StopSign! )
	Return ""
END IF

Return ls_filename + "." + ls_filetype
end function

public function integer of_download (string as_fileid);///////////////////////////////////////////////////////////////////////////
//
//	This method contains all functionality to transfer the specified file
//	from the database into the selected directory on the file system.
//
//	Returns: -1 - Error
//				 0 - Cancel
//				 1 - Success
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

String	ls_filename, ls_dir, ls_filepath
Integer	li_rtn

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid argument passed to method of_download.", StopSign! )
	Return -1
END IF

IF fx_disclaimer() <> 1 THEN Return 0

// Get the filename
ls_filename = This.of_get_filename( as_fileid )
IF ls_filename = "" THEN Return -1

// Get the directory
li_rtn = GetFolder( "Download attachment to...", ls_dir )
IF li_rtn <> 1 THEN Return li_rtn
ls_filepath = ls_dir + "\" + ls_filename

// Check duplicate filename
IF FileExists( ls_filepath ) THEN
	IF MessageBox( "Attachment Download", "The selected directory: " + ls_dir + &
					"~n~rAlready contains a file named " + ls_filename + "~n~r~n~r" + &
					"Would you like to replace the existing file?", Exclamation!, YesNoCancel! ) <> 1 THEN
		Return 0
	END IF
END IF

// Write the file
IF This.of_writefile( as_fileid, ls_filepath ) <> 1 THEN Return -1

IF MessageBox( "Attachment Download", "Attachment was successfully downloaded to:~n~r" + &
		ls_filepath + "~n~r~n~rWould you like to open this file?", Question!, YesNo! ) = 1 THEN
	
	li_rtn = inv_file.of_openfile( ls_filepath, inv_file.sw_showdefault )

	IF li_rtn <= 32 THEN
		MessageBox( "Attachment Download", "Unable to open the file in its native application." + &
									" Error Code: " + String( li_rtn ) + &
									"~n~rPlease try to open the file manually at " + ls_filepath, StopSign! )
		Return -1
	END IF	
END IF

Return 1
end function

public function integer of_writefile (string as_fileid, string as_filepath);///////////////////////////////////////////////////////////////////////////
//
//	This method will read the FILE_CONTENTS from FILE_CNTL into a blob 
// and write the contents into a physical file to the specified path.
// NOTE: This method does not check if a duplicate filename exists in
//	the specified directory. If exists, this method will overwrite it without a warning.
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

Blob	lbl_contents
integer	li_filenum

as_filepath = Trim( as_filepath )

//	Validate arguments
IF IsNull( as_filepath ) OR Trim( as_filepath ) = "" &
OR IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid arguments passed to method of_write.", StopSign! )
	Return -1
END IF

//	Get the file contents
SELECTBLOB FILE_CONTENTS
INTO :lbl_contents
FROM FILE_CNTL
WHERE FILE_ID = :as_fileid
USING Stars2ca;

// Error checking
IF Stars2ca.of_check_status() <> 0 &
OR IsNull( lbl_contents ) OR Len( lbl_contents ) = 0 THEN
	MessageBox( "Attachment Error", "Unable to locate the contents of the file.", StopSign! )
	Return -1
END IF

// Open the file in Stream Write mode
li_filenum = FileOpen( as_filepath, StreamMode!, Write!, LockReadWrite!, Replace! )
IF li_filenum < 0 THEN
	MessageBox( "Attachment Error", "Unable to create file: " + as_filepath, StopSign! )
	Return -1
END IF

IF FileWriteEx( li_filenum, lbl_contents ) < 0 THEN
	MessageBox( "Attachment Error", "Unable to write to file: " + as_filepath, StopSign! )
	FileClose( li_filenum )
	Return -1
END IF

IF FileClose( li_filenum ) <> 1 THEN
	MessageBox( "Attachment Error", "Unable to close file: " + as_filepath, StopSign! )
	Return -1
END IF

Return 1
end function

public function integer of_view (string as_fileid);///////////////////////////////////////////////////////////////////////////
//
//	This method contains all functionality to transfer the specified file
//	from the database into the temp directory on the file system in View mode
//
//	Returns: -1 - Error
//				 1 - Success
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

String	ls_filename, ls_filepath
Integer	li_pos, li_rtn
Boolean	lb_Null

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid argument passed to method of_view.", StopSign! )
	Return -1
END IF

// Get the filename
ls_filename = This.of_get_filename( as_fileid )
IF ls_filename = "" THEN Return -1

// Get the temporary directory
ls_filepath = This.of_GetTempDir()
IF ls_filepath = "" THEN Return -1
ls_filepath += ls_filename

// Check duplicate filename
DO WHILE FileExists( ls_filepath )
	// First, try to delete file
	IF NOT inv_file.of_FileDelete( ls_filepath ) THEN
		// If delete fails, make unique name
		// Get the position of last dot
		li_pos = LastPos( ls_filepath, "." )
		IF li_pos = 0 THEN Exit
		// Append 1 to the filename until unique
		ls_filepath = Left( ls_filepath, li_pos - 1 ) + "1" + Mid( ls_filepath, li_pos )
	END IF       
LOOP

// Write the file
IF This.of_writefile( as_fileid, ls_filepath ) <> 1 THEN Return -1

// Set ReadOnly and Hidden attributes
SetNull( lb_Null )
inv_file.of_setfileattributes( ls_filepath, TRUE, TRUE, lb_Null, lb_Null )

li_rtn = inv_file.of_openfile( ls_filepath, inv_file.sw_showdefault )

IF li_rtn <= 32 THEN
	MessageBox( "Attachment Download", "Unable to open the file in its native application." + &
										" Error Code: " + String( li_rtn ), StopSign! )
	Return -1
END IF

Return 1
end function

public subroutine of_deletetempfiles ();///////////////////////////////////////////////////////////////////////////
//
//	This method will delete the temporary "View" directory from the PC
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

String	ls_temp

// Get the temporary directory
ls_temp = inv_file.of_GetTempDir()
// Check for last slash and append app folders
IF NOT Match( ls_temp, "\\$" ) THEN ls_temp += "\"
ls_temp = ls_temp + is_temp_dir

// Delete the temp directory for all STARS user folders
inv_file.of_deltree( ls_temp )


end subroutine

public function integer of_delete_cntl (string as_fileid);///////////////////////////////////////////////////////////////////////////
//
//	This method will delete the FILE_CNTL information for specified attachment
//	NOTE: This method does not commit or rollback.  The caller must manage this
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid argument passed to method of_delete_cntl.", StopSign! )
	Return -1
END IF

DELETE FILE_CNTL
WHERE FILE_ID = :as_fileid
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Attachment Error", "Unable to delete data from FILE_CNTL" + &
	"~n~rError: " + Stars2ca.SQLErrText, StopSign! )
	Return -1
END IF

Return 1
end function

public function string of_copy_cntl (string as_fileid);///////////////////////////////////////////////////////////////////////////
//
//	This method will copy the FILE_CNTL information for specified attachment
//	NOTE: This method does not commit or rollback.  The caller must manage this
//
//	Return:	String - "" = Error
//							New file_id when successfull
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	04/25/07	GaryR	Track 4997	Convert LongLong to Decimal due to PB bug
//
///////////////////////////////////////////////////////////////////////////

Blob		lbl_contents
String	ls_newFileid, ls_filename, ls_filetype, ls_user_id
Decimal	ldec_filesize
DateTime	ldt_filedate

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" THEN
	MessageBox( "Attachment Error", "Invalid argument passed to method of_copy_cntl.", StopSign! )
	Return ""
END IF

// Get new fileid
ls_newFileid = fx_get_next_key_id( "RSTR" )
IF IsNull( ls_newFileid ) OR Trim( ls_newFileid ) = "" OR ls_newFileid = "ERROR" THEN
	MessageBox( "Attachment Error", "Unable to get the new LINK_KEY id from SYS_CNTL.", StopSign! )
	Return ""
END IF

// Get existing CNTL data
SELECT FILE_NAME, 
		FILE_TYPE, 
		FILE_SIZE, 
		ATTACH_USER_ID, 
		ATTACH_DATE
INTO	:ls_filename,
		:ls_filetype,
		:ldec_filesize,
		:ls_user_id,
		:ldt_filedate
FROM FILE_CNTL
WHERE FILE_ID = :as_fileid
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Attachment Error", "Unable to read data from FILE_CNTL for FILE_ID: " + &
								as_fileid + "~n~rError: " + Stars2ca.SQLErrText, StopSign! )
	Return ""
END IF

//	Insert new cntl row
IF This.of_insert_cntl( ls_newFileid, ls_filename, ls_filetype, ldec_filesize, ls_user_id, ldt_filedate ) <> 1 THEN Return ""

//	Get the file contents
SELECTBLOB FILE_CONTENTS
INTO :lbl_contents
FROM FILE_CNTL
WHERE FILE_ID = :as_fileid
USING Stars2ca;

// Error checking
IF Stars2ca.of_check_status() <> 0 &
OR IsNull( lbl_contents ) OR Len( lbl_contents ) = 0 THEN
	MessageBox( "Attachment Error", "Unable to locate the contents of the file.", StopSign! )
	Return ""
END IF

// Update contents
UPDATEBLOB file_cntl
SET file_contents = :lbl_contents
WHERE file_id = :ls_newFileid
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Attachment Error", "Unable to update data into FILE_CNTL" + &
	"~n~rError: " + Stars2ca.SQLErrText, StopSign! )
	Return ""
END IF

Return ls_newFileid
end function

public function string of_gettempdir ();///////////////////////////////////////////////////////////////////////////
//
//	This method will build the temporary directory path
//
//	Returns: temporary directory
//				"" - Error
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//
///////////////////////////////////////////////////////////////////////////

Long		ll_elements, ll_ctr
String 	ls_dir, ls_temp, ls_slash = "\", ls_folders[]
Boolean	lb_build
n_cst_string	lnv_string

ls_temp = inv_file.of_GetTempDir()
IF ls_temp = "" THEN
	MessageBox( "Attachment Error", "Unable to identify the temporary directory " + &
						"for Attachments.~n~rPlease make sure that you have the TEMP/TMP " + &
						"Environment Variables properly defined on your machine.", StopSign! )
	Return ""
END IF

// Check for last slash
// And append app/user info
IF NOT Match( ls_temp, "\\$" ) THEN ls_temp += ls_slash
ls_dir = ls_temp + is_temp_dir + gc_user_id + ls_slash

ll_elements = lnv_string.of_parseToArray( ls_dir, ls_slash, ls_folders )

FOR ll_ctr = 1 TO ll_elements 
	// Start building at ViPS folder
	IF ls_folders[ll_ctr] = "ViPS" THEN lb_build = TRUE
	IF NOT lb_build THEN Continue
	
	// Create the temp dir 
	// if it does not exist
	ls_temp += ls_folders[ll_ctr] + ls_slash
	IF NOT DirectoryExists( ls_temp ) THEN
		IF CreateDirectory( ls_temp ) <> 1 THEN
			MessageBox( "Attachment Error", "Unable to create the following temp directory: " + &
									ls_temp, StopSign! )
			Return ""
		END IF
	END IF
NEXT

Return ls_dir
end function

public function decimal of_getmaxfilesize ();////////////////////////////////////////////////////////////////////////////
//
//	This method will return the Max File Size setting from SYS_CNTL
//	IF it's not found, the defualt is 2GB.  0 means no limit.
//
////////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	04/25/07	GaryR	Track 4997	Convert LongLong to Decimal due to PB bug
//
////////////////////////////////////////////////////////////////////////////

Decimal	ldec_MaxFileSize

SELECT CNTL_NO
INTO :ldec_MaxFileSize
FROM SYS_CNTL
WHERE CNTL_ID = 'MAXFILELEN'
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 OR IsNull( ldec_MaxFileSize ) THEN Return idec_DfltFileSize
Return ldec_MaxFileSize
end function

public function integer of_update_cntl (string as_fileid, decimal adec_filesize);///////////////////////////////////////////////////////////////////////////
//
//	This method will update the FILE_CNTL information for attachments
//	To insert the actual file contents use method of_insertFile()
//	NOTE: This method does not commit or rollback.  The caller must manage this
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	04/25/07	GaryR	Track 4997	Convert LongLong to Decimal due to PB bug
//
///////////////////////////////////////////////////////////////////////////

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" OR IsNull( adec_filesize ) THEN
	MessageBox( "Attachment Error", "Invalid arguments passed to method of_update_cntl.", StopSign! )
	Return -1
END IF

UPDATE FILE_CNTL
SET FILE_SIZE = :adec_filesize
WHERE FILE_ID = :as_fileid
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Attachment Error", "Unable to update data into FILE_CNTL" + &
	"~n~rError: " + Stars2ca.SQLErrText, StopSign! )
	Return -1
END IF

Return 1
end function

public function integer of_insert_cntl (string as_fileid, string as_filename, string as_filetype, decimal adec_filesize, string as_userid, datetime adt_current);///////////////////////////////////////////////////////////////////////////
//
//	This method will insert the FILE_CNTL information for attachments
//	To insert the actual file contents use method of_insertFile()
//	NOTE: This method does not commit or rollback.  The caller must manage this
//
///////////////////////////////////////////////////////////////////////////
//
//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case
//	04/25/07	GaryR	Track 4997	Convert LongLong to Decimal due to PB bug
//
///////////////////////////////////////////////////////////////////////////

//	Validate arguments
IF IsNull( as_fileid ) OR Trim( as_fileid ) = "" &
OR IsNull( as_filename ) OR Trim( as_filename ) = "" &
OR IsNull( as_filetype ) OR Trim( as_filetype ) = "" &
OR IsNull( as_userid ) OR Trim( as_userid ) = "" &
OR IsNull( adec_filesize ) OR IsNull( adt_current ) THEN
	MessageBox( "Attachment Error", "Invalid arguments passed to method of_insert_cntl.", StopSign! )
	Return -1
END IF

// Upper variables
as_filename = Upper( as_filename )
as_filetype = Upper( as_filetype )

INSERT INTO FILE_CNTL (
	FILE_ID, 
	FILE_NAME, 
	FILE_TYPE, 
	FILE_SIZE, 
	ATTACH_USER_ID, 
	ATTACH_DATE,
	FILE_CONTENTS)
VALUES ( 
	:as_fileid,
	:as_filename,
	:as_filetype,
	:adec_filesize,
	:as_userid,
	:adt_current,
	'1F')			// This is a hex value, which is required in Oracle blobs instead of spaces
USING Stars2ca;

IF Stars2ca.of_check_status() <> 0 THEN
	MessageBox( "Attachment Error", "Unable to insert data into FILE_CNTL" + &
	"~n~rError: " + Stars2ca.SQLErrText, StopSign! )
	Return -1
END IF

Return 1
end function

on n_cst_attachments.create
call super::create
end on

on n_cst_attachments.destroy
call super::destroy
end on

event constructor;call super::constructor;//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

inv_file = Create n_cst_filesrv
end event

event destructor;call super::destructor;//	10/16/06	GaryR	Track 3153	Add external file attachment facility to Case

Destroy inv_file
end event

