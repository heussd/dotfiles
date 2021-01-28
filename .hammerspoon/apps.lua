hyper:bind({}, "c", nil, function() 
    hs.application.launchOrFocus("kitty")
end)

hyper:bind({}, "e", nil, function() 
    hs.application.launchOrFocus("Finder")
end)

hyper:bind({}, "f", nil, function()
    hs.application.launchOrFocus("Firefox")
end)

hyper:bind({}, "m", nil, function()
    hs.application.launchOrFocus("MacVim")
end)

hyper:bind({}, "a", nil, function()
    if (hs.application.frontmostApplication():name() == "Stickies") then
        hs.application.frontmostApplication():hide()
    else
        hs.application.launchOrFocus("Stickies")
    end
end)

hyper:bind({}, "s", nil, function()
    hs.application.launchOrFocus("Firefox")
    hs.eventtap.keyStroke({"cmd"}, "t")
    hs.eventtap.keyStroke({"cmd"}, "v")
end)

hs.hotkey.bind({"alt"}, "space", function()
    hs.execute("~/.scripts/snippets-choose", false)
end)

