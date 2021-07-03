-- Fast key stroke, taken from
-- https://github.com/Hammerspoon/hammerspoon/issues/1011#issuecomment-261114434
function fastKeyStroke(modifiers, character)
    local event = require("hs.eventtap").event
    event.newKeyEvent(modifiers, string.lower(character), true):post()
    event.newKeyEvent(modifiers, string.lower(character), false):post()
end


function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
  end
  
function hl2play(word)
    local file = os.getenv("HOME") .. "/Developer/hl2/sound/npc/combine_soldier/vo/" .. word .. ".wav"
    if file_exists(file) then
        local sound = hs.sound.getByFile(file)
        sound:play()
    end
end

function hlspeak(word)
    local file = os.getenv("HOME") .. "/Developer/hl_text2speech/snd/male/" .. word .. ".wav"
    if file_exists(file) then
        local sound = hs.sound.getByFile(file)
        sound:play()
    end
end

-- Taken from https://gist.github.com/lucifr/b0780e38045235027ef11746041dc120
-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
	local win = hs.window.focusedWindow()
    win:moveToScreen(win:screen():next())
	local f = win:frame()
	--local screen = win:screen()
    local screen = win:screen({x=0,y=0})
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end