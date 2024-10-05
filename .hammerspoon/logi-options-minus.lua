-- A lightweight alternative to what I do with Logi Options+

mouseClickListener = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(event)
    local buttonNumber = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
    if buttonNumber == 4 then
        hs.eventtap.keyStroke({"cmd"}, "W")
        return true
    end
    if buttonNumber == 3 then
        hs.eventtap.keyStroke({}, "return")
        return true
    end
    return false
end):start()
