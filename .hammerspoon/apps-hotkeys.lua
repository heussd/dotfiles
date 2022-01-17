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
	local win = hs.window.focusedWindow()
        if win ~= nil then
            win:setFullScreen(not win:isFullScreen())
        end
end)

hyper:bind({}, "s", nil, function()
    hs.application.launchOrFocus("Firefox")
    hs.eventtap.keyStroke({"cmd"}, "t")
    hs.eventtap.keyStroke({"cmd"}, "v")
end)

hs.hotkey.bind({"alt"}, "space", function()
    hs.execute("~/.scripts/snippets-choose", true)
end)

