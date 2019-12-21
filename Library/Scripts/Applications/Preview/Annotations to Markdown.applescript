global markdownTargetFolder, pdfVerzetteltTargetFolder
set markdownTargetFolder to "~/projects/zettelwirtschaft/excerpts/"
set pdfVerzetteltTargetFolder to expandTilde("~/Archive/Verzettelt/")


set pdfFile to ""
tell application "Preview"
	set pdfFile to get path of document 1
end tell

tell application "Skim"
	open pdfFile
	convert notes document 1
	delay 3
	
	set allNotes to ""
	
	log (number of notes of document 1) & " notes to extract"
	set pdfName to name of document 1 as text
	
	set counter to 0
	repeat with oneNote in (notes of document 1)
		set pdfPage to label of page of oneNote
		
		set oneNoteType to (type of oneNote)
		
		log "Found a " & oneNoteType
		
		if oneNoteType is in {highlight note, text note, anchored note, strike out note} then
			
			if (oneNoteType is in {anchored note, text note}) then
				set oneNoteText to text of oneNote
			else
				set oneNoteText to selection of oneNote
			end if
			
			if oneNoteText is missing value or oneNoteText is "" then
				display alert "Failed to extract the text of notation" & my newline() & my newline() & "Note number " & counter & " on Page " & pdfPage & my newline() & "Type " & oneNoteType
			else
				-- Extraction seems to have worked
				try
					set oneNoteText to "" & oneNoteText
					
					set oneNoteText to my removeJunk(oneNoteText)
					set allNotes to allNotes & my asQuote(oneNoteText, pdfName, pdfPage) & my newline() & my newline() & my newline()
					
					
					my writeFile(my hashedFileName(allNotes), allNotes)
					set allNotes to ""
					set counter to (counter + 1)
				end try
			end if
			
		end if
	end repeat
	
	if counter is 0 then display dialog "Nothing was extracted - sorry"
	
	quit saving no
end tell

do shell script "mv \"" & (pdfFile) & "\" " & pdfVerzetteltTargetFolder & "/"

on asQuote(content, pdfName, page)
	return my newline() & "> " & content & my newline() & my newline() & escapePdfName(pdfName) & ", page " & page
end asQuote

on escapePdfName(filename)
	set filename to "	" & filename
	return filename
end escapePdfName

on removeJunk(oneNoteText as string)
	set oneNoteText to my replaceText("- ", "", oneNoteText as string)
	set oneNoteText to my replaceText("  ", " ", oneNoteText as string)
	return oneNoteText
end removeJunk

on hashedFileName(content)
	return (do shell script "echo " & quoted form of (content) & " | md5")
end hashedFileName

on writeFile(filename, content)
	do shell script "echo " & quoted form of (content) & " > " & (markdownTargetFolder & fsEscape(filename) & ".md")
end writeFile

on randomFileName()
	return (do shell script "date +%s") & "-" & (random number from 1 to 99999)
end randomFileName

on fsEscape(filename)
	set filename to my replaceText(" ", "_", filename)
	set filename to my replaceText(".", "_", filename)
	set filename to my replaceText("(", "_", filename)
	set filename to my replaceText(")", "_", filename)
	
	if length of filename is less than 70 then
		return filename
	end if
	
	set filename to text 1 thru 70 of filename
	return filename
end fsEscape

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

use framework "Foundation"
on expandTilde(givenPath)
	-- create a temporary Obj-C/Cocoa NSString object with the givenPath
	set tempCocoaString to current application's NSString's stringWithString:givenPath
	-- call the object's stringByExpandingTildeInPath method
	-- to create a new path with expanded tilde
	return (tempCocoaString's stringByExpandingTildeInPath) as string
end expandTilde