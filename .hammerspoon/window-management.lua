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


hyper:bind({}, "Up", nil, function()
	hs.window.focusWindowNorth()
end)

hyper:bind({}, "Right", nil, function()
	hs.window.focusWindowEast()
end)

hyper:bind({}, "Down", nil, function()
	hs.window.focusWindowSouth()
end)

hyper:bind({}, "Left", nil, function()
	hs.window.focusWindowWest()
end)
