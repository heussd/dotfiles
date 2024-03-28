set theString to display dialog "What to type?"

delay 5
repeat with i from 1 to count of characters in theString
	tell application "System Events" to keystroke (character i of theString)
	delay 0.1
end repeat


