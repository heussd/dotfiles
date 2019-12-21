set snippetName to text returned of (display dialog "New snippet name:" default answer "")

do shell script "pbpaste > ~/snippets/\"" & snippetName & "\""

tell application "Zazu" to quit
delay 1
tell application "Zazu" to launch