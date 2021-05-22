
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