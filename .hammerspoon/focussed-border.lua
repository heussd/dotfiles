lastMouseClick = hs.timer.secondsSinceEpoch()
mouseClickListener = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown }, function(event)
    lastMouseClick = hs.timer.secondsSinceEpoch() 
end):start()

function redrawBorder()
    -- Only redraw border if mouse has not been used for n seconds
    if (hs.timer.secondsSinceEpoch() - lastMouseClick < 20) then
        return
    end

    win = hs.window.focusedWindow()
    if win ~= nil then
        top_left = win:topLeft()
        size = win:size()
        if global_border ~= nil then
            global_border:delete()
        end
        global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
        global_border:setStrokeColor({["red"]=1,["blue"]=1,["green"]=0,["alpha"]=0.5})
        global_border:setFill(false)
        global_border:setStrokeWidth(20)
        global_border:show()
        global_border:hide(1)
    end
end

redrawBorder()

allwindows = hs.window.filter.new(nil)
allwindows:subscribe(hs.window.filter.windowCreated, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowFocused, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowMoved, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowUnfocused, function () redrawBorder() end)
