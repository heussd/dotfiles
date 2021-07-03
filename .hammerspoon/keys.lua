require('steps')
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

hyper:bind({}, "b", nil, function()
    hs.application.launchOrFocus("KeePassXC")
end)


hs.hotkey.bind({"alt"}, "space", function()
    hs.execute("~/.scripts/snippets-choose", true)
end)

hyper:bind({}, "-", narrow_right)
hyper:bind({}, ".", wide_left)
hyper:bind({}, "Up", maximize_current_window)

hyper:bind({}, "q", nil, function()
    pre_lock()
    
    local message = "Going down for sleep..."
    hs.alert.show(message, 2)
    
    local duration = 2.5
    hs.timer.doAfter(duration, function()
        hs.alert(message .. " 3")
    end)
    hs.timer.doAfter(2*duration, function()
        hs.alert(message .. " 2")
    end)
    hs.timer.doAfter(3*duration, function()
        hs.alert(message .. " 1")
    end)
    hs.timer.doAfter(4*duration, function()
        hs.caffeinate.lockScreen()
        hs.caffeinate.systemSleep()
    end)
end)