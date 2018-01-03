# Open the Color Picker via AppleScript
# http://qsapp.com/wiki/Color_Picker_(AppleScript)
tell application "System Events" to set _frontMostApp to (name of processes whose frontmost is true)
set _frontMostApp to item 1 of _frontMostApp
tell application _frontMostApp to activate
choose color