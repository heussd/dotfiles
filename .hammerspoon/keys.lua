require('utils')

hyper:bind({}, "c", nil, function() 
    hs.application.launchOrFocus("kitty")
end)

hyper:bind({}, "e", nil, function() 
    hs.application.launchOrFocus("Finder")
end)

hyper:bind({}, "i", nil, function()
    hs.application.launchOrFocus("Signal")
end)

hyper:bind({}, "m", nil, function()
    hs.application.launchOrFocus("MacVim")
end)


hyper:bind({}, "f", nil, function()
    hs.application.launchOrFocus("Firefox")
end)

hyper:bind({}, "s", nil, function()
    hs.application.launchOrFocus("Firefox")
    hs.eventtap.keyStroke({"cmd"}, "t")
    hs.eventtap.keyStroke({"cmd"}, "v")
end)


hs.hotkey.bind({"alt"}, "space", function()
    hs.execute("~/.scripts/snippets-choose", true)
end)


function lockAndSleep()
    hs.caffeinate.lockScreen()
    hs.caffeinate.systemSleep()
end

hyper:bind({}, "ä", nil, function()
    hs.alert.show("Good bye!", 2)
    hlspeak('doop')
    hs.timer.doAfter(2, lockAndSleep)
end)