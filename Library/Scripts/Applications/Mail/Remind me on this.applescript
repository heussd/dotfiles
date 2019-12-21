# A lot has been taken from https://github.com/moritzregnier/create-reminder-from-mail-mac

tell application "Mail"
	set theSelection to selection as list
	# do nothing if no email is selected in Mail
	try
		set theMessage to item 1 of theSelection
	on error
		return
	end try
	
	set theSubject to theMessage's subject
	set theOrigMessageId to theMessage's message id
	set theUrl to {"message:%3C" & my replaceText(theOrigMessageId, "%", "%25") & "%3E"}
	
	
	# Get the unique identifier (ID) of selected email/message
	set theOrigMessageId to theMessage's message id
	
	#we need to encode % with %25 because otherwise the URL will be screwed up in Reminders and you won't be able to just click on it to open the linked message in Mail
	set theUrl to {"message:%3C" & my replaceText(theOrigMessageId, "%", "%25") & "%3E"}
	
end tell

tell application "Reminders"
	set mylist to last list
	set myDueDate to (current date)
	tell mylist
		# create new reminder with proper due date, subject name and the URL linking to the email in Mail
		make new reminder with properties {name:theSubject, remind me date:myDueDate, body:theUrl}
	end tell
end tell


#################################################################################
# Functions
#################################################################################

# string replace function
# used to replace % with %25
on replaceText(subject, find, replace)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set subject to text items of subject
	
	set text item delimiters of AppleScript to replace
	set subject to "" & subject
	set text item delimiters of AppleScript to prevTIDs
	
	return subject
end replaceText
