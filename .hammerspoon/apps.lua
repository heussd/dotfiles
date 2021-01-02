
hs.hotkey.bind(hyper, "c", function() 
    hs.application.launchOrFocus("kitty")
end)

hs.hotkey.bind(hyper, "return", function() 
    hs.application.launchOrFocus("kitty")
end)

hs.hotkey.bind(hyper, "e", function() 
    hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind(hyper, "f", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind(hyper, "g", function()
    hs.application.launchOrFocus("Firefox")
    hs.eventtap.keyStroke({"cmd"}, "t")
    hs.eventtap.keyStroke({"cmd"}, "v")
end)

hs.hotkey.bind(hyper, "s", function()
    hs.application.launchOrFocus("Firefox")
    hs.eventtap.keyStroke({"cmd"}, "t")
    hs.eventtap.keyStroke({"cmd"}, "v")
end)

hs.hotkey.bind({"alt"}, "space", function()
    hs.execute("~/.scripts/snippets-choose", false)
end)

