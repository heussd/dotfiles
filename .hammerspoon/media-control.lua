mediaControlActive = false

horizontalScroll = hs.eventtap.new({ hs.eventtap.event.types.scrollWheel }, function(event)
    local scrollX = event:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis2)
    if scrollX == 0 then
        return false
    end

    if scrollX < 0 then
        hs.eventtap.event.newSystemKeyEvent('SOUND_UP', true):post()
        hs.eventtap.event.newSystemKeyEvent('SOUND_UP', false):post()
        return true
    else
        hs.eventtap.event.newSystemKeyEvent('SOUND_DOWN', true):post()
        hs.eventtap.event.newSystemKeyEvent('SOUND_DOWN', false):post()
        return true
    end 
end)

homeButton = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(event)
    local buttonNumber = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
    if buttonNumber == 3 then
        hs.eventtap.keyStroke({"cmd"}, "1")
        return true
    end
    return false
end)