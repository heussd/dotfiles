function system()
    hlspeak('system')
end

function activated()
    hlspeak('activated')
end

hyper:bind({"command"}, "p", nil, function() 
    hs.alert("Playground :-)")
end)

function omg(test)
    hs.alert(test)
end

function do_sth()
end

hyper:bind({}, "p", nil, function() 
    hs.alert("Playground")

    if (hs.fs.chdir(os.getenv("HOME") .. "/Developer/hl_text2speech/snd/male/") == nil) then
        hs.alert("EMPTY")
    else
        hlspeak('dadeda')
        hs.timer.doAfter(0.7, system)
        hs.timer.doAfter(1.4, activated)
    end
end)