setfiletype tabsep

syn region myFold start="^##" end="\n\n\n" transparent fold
syn sync fromstart
set foldmethod=syntax
