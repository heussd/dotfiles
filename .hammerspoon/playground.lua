function hlspeak(word)
    local file = os.getenv("HOME") .. "/projects/hl_text2speech/snd/male/" .. word .. ".wav"
    print (file)
    local sound = hs.sound.getByFile(file)
    sound:play()
end

function system()
    hlspeak('system')
end

function activated()
    hlspeak('activated')
end

hyper:bind({"command"}, "p", nil, function() 
    hs.alert("Playground :-)")
end)

hyper:bind({}, "p", nil, function() 
    hs.alert("Playground")

    if (hs.fs.chdir(os.getenv("HOME") .. "/projects/hl_text2speech/snd/male/") == nil) then
        hs.alert("EMPTY")
    else
        hlspeak('dadeda')
        hs.timer:doAfter(0.7, system)
        hs.timer:doAfter(1.4, activated)
    end
end)