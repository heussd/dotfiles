require('utils')

function narrow_right()
    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x + (max.w*0.7)
	f.y = max.y + (max.h*0)
	f.w = max.w*0.30
	f.h = max.h*1
	win:setFrame(f)
end

function wide_left()
    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x + (max.w*0)
	f.y = max.y + (max.h*0)
	f.w = max.w*0.70
	f.h = max.h*1
	win:setFrame(f)
end

function wide_left_below()
    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x + (max.w*0)
	f.y = max.y + (max.h*0.55)
	f.w = max.w*0.70
	f.h = max.h*0.45
	win:setFrame(f)
end

function maximize_current_window()
    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end


function left_half()
    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w*5.5
	f.h = max.h
	win:setFrame(f)
end


function right_half()
    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x + (max.w*0.5)
	f.y = max.y
	f.w = max.w*0.5
	f.h = max.h
	win:setFrame(f)
end


hyper:bind({}, "-", narrow_right)
hyper:bind({}, ".", wide_left)
hyper:bind({}, "Up", maximize_current_window)
hyper:bind({"Option"}, "Left", left_half)
hyper:bind({}, "Left", wide_left)
hyper:bind({"Option"}, "Right", right_half)
hyper:bind({}, "Right", narrow_right)
hyper:bind({}, "Down", wide_left_below)
