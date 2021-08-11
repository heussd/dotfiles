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


function narrow_left()
	move_window(0,0,0.3,1)
end

function narrow_right()
	move_window(0.7,0,0.3,1)
end

function wide_left()
	move_window(0,0,0.7,1)
end

function wide_right()
	move_window(0.3,0,0.7,1)
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


hyper:bind({}, "Up", maximize_current_window)
hyper:bind({}, "Down", wide_right_below)

hyper:bind({}, "Left", narrow_left)
hyper:bind({}, "Right", wide_right)

hyper:bind({"Option"}, "Left", left_half)
hyper:bind({"Option"}, "Right", right_half)
