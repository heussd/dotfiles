-- Emulate VIM key bindings for arrow keys

-- Fast key stroke, taken from
-- https://github.com/Hammerspoon/hammerspoon/issues/1011#issuecomment-261114434
fastKeyStroke = function(modifiers, character)
    local event = require("hs.eventtap").event
    event.newKeyEvent(modifiers, string.lower(character), true):post()
    event.newKeyEvent(modifiers, string.lower(character), false):post()
end


local up = function()
    fastKeyStroke(nil, "Up")
end
local down = function()
    fastKeyStroke(nil, "Down")
end
local left = function()
    fastKeyStroke(nil, "Left")
end
local right = function()
    fastKeyStroke(nil, "Right")
end


hyper:bind({}, 'j', down, nil, down)
hyper:bind({}, 'k', up, nil, up)
hyper:bind({}, 'h', left, nil, left)
hyper:bind({}, 'l', right, nil, right)