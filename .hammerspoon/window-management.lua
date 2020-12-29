-- https://github.com/Hammerspoon/hammerspoon/issues/2566
local window = require("hs.window") -- make sure this is loaded
local winMT  = getmetatable(window)
local original_index = winMT.__index
winMT.__index = function(self, key)
    local answer = original_index(self, key)
    if answer then
        return answer
    else
        return hs.getObjectMetatable("hs.window")[key]
    end
end


hs.hotkey.bind(hyper, "Up", function()
	hs.window.focusWindowNorth()
end)
hs.hotkey.bind(hyper, "Right", function()
	hs.window.focusWindowEast()
end)
hs.hotkey.bind(hyper, "Down", function()
	hs.window.focusWindowSouth()
end)
hs.hotkey.bind(hyper, "Left", function()
	hs.window.focusWindowWest()
end)
