require('utils')

-- Emulate VIM key bindings for arrow keys

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