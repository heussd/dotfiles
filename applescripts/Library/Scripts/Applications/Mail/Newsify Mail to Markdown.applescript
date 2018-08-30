on run
	tell application "Mail"
		set selectedMessages to selection
		if (count of selectedMessages) is equal to 0 then
			display alert "No Messages Selected" message "You must select a message first."
		else
			set theNotes to ""
			set theSource to ""
			repeat with theMessage in selectedMessages
				set theSource to source of theMessage
				set the clipboard to my extractFromMailSource(theSource)
				set theDecodedZettel to do shell script "pbpaste | perl -MMIME::QuotedPrint=decode_qp -e 'print decode_qp join\"\",<>' | tail -n +8 | tail -r | tail -n +2 | tail -r"
				set theDecodedZettel to "> " & my replaceText(ASCII character 13, "
> ", theDecodedZettel)
				
				
				display dialog theDecodedZettel
			end repeat
		end if
	end tell
end run


on writeFile(filename, content)
	do shell script "echo " & quoted form of (content) & " > " & ("~/Desktop/" & fsEscape(filename) & ".md")
end writeFile

on hashedFileName(content)
	return (do shell script "echo " & quoted form of (content) & " | md5")
end hashedFileName

on randomFileName()
	return (do shell script "date +%s") & "-" & (random number from 1 to 99999)
end randomFileName

on asQuote(content, source)
	return my newline() & my removeNewline("> " & content) & my newline() & my newline() & my removeNewline((source) & "<br/>(Last access " & (do shell script "date")) & ")"
end asQuote

on getPocketText(decodedPocketMailSource)
	set AppleScript's text item delimiters to "Quote from the article:"
	set decodedPocketMailSource to text of text item 2 of decodedPocketMailSource
	set decodedPocketMailSource to text 1 thru -2 of decodedPocketMailSource
	return decodedPocketMailSource
end getPocketText
on getPocketTitle(decodedPocketMailSource)
	set AppleScript's text item delimiters to "Quote from the article:"
	set source to (text of text item 1 of decodedPocketMailSource)
	return source
end getPocketTitle
on getPocketSource(decodedPocketMailSource)
	set AppleScript's text item delimiters to "Quote from the article:"
	set source to (text of text item 1 of decodedPocketMailSource)
	set AppleScript's text item delimiters to "http"
	set source to my removeNewline("http" & (text item 2 of source))
	set source to "[" & source & "](" & source & ")"
	return source
end getPocketSource
on removeNewline(content)
	set content to my replaceText(ASCII character 13, "
", content)
	set content to my replaceText("
", "", content)
	return content
end removeNewline
on removeJunk(content)
	set content to my replaceText(ASCII character 13, "
", content)
end removeJunk

on fsEscape(filename)
	set filename to my replaceText(" ", "_", filename)
	set filename to my replaceText(".", "_", filename)
	set filename to my replaceText("(", "_", filename)
	set filename to my replaceText(")", "_", filename)
	set filename to my replaceText("\\", "", filename)
	set filename to my replaceText("/", "", filename)
	set filename to my replaceText(":", "", filename)
	set filename to my replaceText("?", "", filename)
	
	-- This is hard bug using I guess...
	set AppleScript's text item delimiters to ASCII character 13
	set filename to text item 1 of filename
	
	
	if length of filename is less than 70 then
		return filename
	end if
	
	set filename to text 1 thru 70 of filename
	return filename
end fsEscape

on extractFromMailSource(SearchText)
	set tid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "Content-Transfer-Encoding: quoted-printable"
	set mailSource to text of text item 2 of SearchText
	return mailSource
end extractFromMailSource


-- Taken from https://stackoverflow.com/a/28115509
on replaceText(find, replace, subject)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set subject to text items of subject
	
	set text item delimiters of AppleScript to replace
	set subject to subject as text
	set text item delimiters of AppleScript to prevTIDs
	
	return subject
end replaceText


on newline()
	return "
"
end newline


-- https://stackoverflow.com/questions/3780985/how-do-i-write-to-a-text-file-using-applescript
on write_to_file(this_data, target_file, append_data) -- (string, file path as string, boolean)
	try
		set the target_file to the target_file as text
		set the open_target_file to Â
			open for access file target_file with write permission
		if append_data is false then Â
			set eof of the open_target_file to 0
		write this_data to the open_target_file starting at eof
		close access the open_target_file
		return true
	on error
		try
			close access file target_file
		end try
		return false
	end try
end write_to_file