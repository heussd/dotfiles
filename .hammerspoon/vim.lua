-- Emulate VIM key bindings for arrow keys

hyper:bind({}, 'j', nil, function()
    hs.eventtap.keyStroke(nil, "Down")
end)

hyper:bind({}, 'k', nil, function()
    hs.eventtap.keyStroke(nil, "Up")
end)

hyper:bind({}, 'h', nil, function()
    hs.eventtap.keyStroke(nil, "Left")
end)

hyper:bind({}, 'l', nil, function()
    hs.eventtap.keyStroke(nil, "Right")
end)