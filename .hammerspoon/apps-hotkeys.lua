hyper:bind({}, "c", nil, function() 
    hs.application.launchOrFocus("kitty")
end)

hyper:bind({}, "a", nil, function()
    hs.application.launchOrFocus("Ferdi")
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
    hs.application.launchOrFocus("Starface")
end)


hyper:bind({}, "p", nil, function()
    if (hs.application.frontmostApplication():name() == "KeePassXC") then
        hs.window.focusedWindow():minimize()
    else
        hs.application.launchOrFocus("KeepassXC")
    end
end)

hyper:bind({}, "d", nil, function()
    notify("Dark mode toggled.")
    hs.execute("~/.scripts/dark-mode", true)
end)

hyper:bind({}, "w", nil, function()
    notify("Workapps toggled.")
    os.execute("~/.scripts/workapps &")
end)

hyper:bind({}, "v", nil, function()
    notify("VPN toggled.")
    hs.execute("~/.scripts/togglevpn")
end)
