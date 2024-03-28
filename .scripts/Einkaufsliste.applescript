set allReminders to ""

tell application "Notes"
	set allReminders to (plaintext of note "Einkaufsliste" as string)
end tell


tell application "Reminders"
	set mylist to first list
	set myDueDate to (current date)
	tell mylist
		repeat with theItem in paragraphs of allReminders
			if (count theItem) is not 0 then
				make new reminder with properties {name:theItem, due date:(myDueDate), body:""}
			end if
		end repeat
	end tell
end tell
