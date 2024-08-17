-- Taken from https://gist.github.com/lucifr/b0780e38045235027ef11746041dc120
-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function move_window(x, y, w, h)
	local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end
function move_window_v(y, h)
	local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.y = max.y + (max.h*y)
	f.h = max.h*h
	win:setFrame(f)
end


function narrow_left()
	move_window(0,0,0.25,1)
end

function narrow_right()
	move_window(0.75,0,0.25,1)
end

function wide_left()
	move_window(0,0,0.75,1)
end

function wide_right()
	move_window(0.25,0,0.75,1)
end

function wide_left_below()
	move_window(0,0.5,0.7,0.5)
end

function wide_right_below()
	move_window(0.3,0.5,0.7,0.5)
end

function maximize_current_window()
	move_window(0,0,1,1)
end

function left_half()
    move_window(0,0,0.5,1)
end

function right_half()
	move_window(0.5,0,0.5,1)
end

function upper_half()
	move_window_v(0,0.5)
end
function upper_wide()
	move_window_v(0,0.7)
end
function upper_narrow()
	move_window_v(0,0.3)
end

function lower_narrow()
	move_window_v(0.7,0.3)
end
function lower_half()
	move_window_v(0.5,0.5)
end
function lower_wide()
	move_window_v(0.3,0.7)
end

function move_to_next_screen()
	-- Taken from https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon#58662204

	local win = hs.window.focusedWindow()
	-- get the screen where the focused window is displayed, a.k.a. current screen
	local screen = win:screen()
	-- compute the unitRect of the focused window relative to the current screen
	-- and move the window to the next screen setting the same unitRect 
	win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)

	-- Also move mouse cursor
	-- Taken from https://medium.com/@jma/use-hammerspoon-to-move-cursor-between-monitors-1a53b727b147
	local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)hs.mouse.setAbsolutePosition(center)
end


hyper:bind({}, "y", move_to_next_screen)

hyper:bind({}, "x", maximize_current_window)

hyper:bind({"Option"}, "x", nil, function()
	local win = hs.window.focusedWindow()
        if win ~= nil then
            win:setFullScreen(not win:isFullScreen())
        end
end)


hyper:bind({"Shift"}, "Down", lower_narrow)
hyper:bind({}, "Down", lower_half)
hyper:bind({"Option"}, "Down", lower_wide)


hyper:bind({"Shift"}, "Up", upper_narrow)
hyper:bind({}, "Up", upper_half)
hyper:bind({"Option"}, "Up", upper_wide)


hyper:bind({}, "Left", left_half)
hyper:bind({}, "Right", right_half)

hyper:bind({"Option"}, "Left", wide_left)
hyper:bind({"Option"}, "Right", wide_right)

hyper:bind({"Shift"}, "Left", narrow_left)
hyper:bind({"Shift"}, "Right", narrow_right)
