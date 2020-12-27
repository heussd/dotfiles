function say(text) --a helper function to speak something with either VoiceOver or speech synthesis if it's not running
	if hs.application.get("VoiceOver") ~=nil then
		
	hs.osascript.applescript("tell application \"VoiceOver\" to output \"" ..text .."\"")
	else --VoiceOver is not running, use speech synthesis
		synth:speak(text)
		end --VoiceOver running check
        end --function
        

hs.hotkey.bind({}, "f20", function()
    hs.application.launchOrFocus("kitty")
end)

hs.hotkey.bind({"shift"}, "f20", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"command"}, "f20", function()
    hs.application.launchOrFocus("Firefox")
    hs.eventtap.keyStroke({"cmd"}, "t")
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