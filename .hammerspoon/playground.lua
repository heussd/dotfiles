function system()
    hlspeak('system')
end

function activated()
    hlspeak('activated')
end


function omg(test)
    hs.alert(test)
end


hyper:bind({}, "ä", nil, function() 
    hs.alert("Playground")

    device = hs.audiodevice.defaultOutputDevice()
    device:setOutputVolume(20)

    hl2speak('friends', 'message')

    hlspeak('dadeda')
    if (hs.fs.chdir(os.getenv("HOME") .. "/Developer/hl_text2speech/snd/male/") == nil) then
        hs.alert("EMPTY")
    else
        hlspeak('dadeda')
        hs.timer.doAfter(0.7, system)
        hs.timer.doAfter(1.4, activated)
    end
end)