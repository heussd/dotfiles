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

function hl2speak(path, word)
    local file = os.getenv("HOME") .. "/Developer/hl2/sound/" .. path .. "/" .. word .. ".wav"
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
