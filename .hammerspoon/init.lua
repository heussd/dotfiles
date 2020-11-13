hs.hotkey.bind({"ctrl", "alt"}, "return", function()
    local app = hs.application.get("kitty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("kitty")
    end
end)

hs.hotkey.bind({"ctrl", "alt"}, "f", function()
    local app = hs.application.get("Firefox")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"Firefox", "New Tab"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("Firefox")
    end
end)