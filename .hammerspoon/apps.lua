
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

hs.hotkey.bind({"alt"}, "space", function()
    hs.execute("~/.scripts/snippets-choose", false)
end)

hs.hotkey.bind({"command", "shift"}, "g", function()
    hs.execute("open https://www.google.de", false)
end)


hs.hotkey.bind({"ctrl", "alt"}, "return", function()
    local app = hs.application.get("kitty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            --app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("kitty")
    end
end)

hs.hotkey.bind({"command", "shift"}, "f", function()
   local app = hs.application.get("Firefox")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"Firefox", "New Tab"})
        elseif app:isFrontmost() then
            --app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("Firefox")
    end
end)


hs.hotkey.bind({"ctrl", "alt"}, "return", function()
    local app = hs.application.get("kitty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            --app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("kitty")
    end
end)
