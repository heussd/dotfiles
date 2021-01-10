local bar = hs.menubar.new()
bar:setTitle(hs.host:localizedName())


function test()
    hs.alert("OMG")
    hs.caffeinate.lockScreen()
    generate_menu()
end

function toggle_caffeine()
    hs.caffeinate.toggle("displayIdle")
    generate_menu()
end

function goodnight()
    hs.execute("~/goodnight.sh", true)
end

function download_autosort()
    hs.execute("~/.scripts/autosort_downloads", true)
end

function open_config()
    hs.execute("code ~/.hammerspoon", true)
end


function generate_menu()
    bar:setMenu({
        {title = "-" },
        {title = "Good Night", fn = goodnight},
        {title = "Download Auto Sort", fn = download_autosort},
        {title = "-" },
        {title = globalmute.muted and "Microphone is MUTED" or "Microphone is OPEN", fn = toggleMic,},
        {
            title = hs.caffeinate.get("displayIdle") and "Display stays AWAKE" or "Display will sleep",
            checked = hs.caffeinate.get("displayIdle"),
            fn = toggle_caffeine
        },
        {title = "-" },
        {title = 'Hammerspoon Console', fn = hs.toggleConsole},
        {title = "-" },
        {title = 'Open Hammerspoon Configuration', fn = open_config},
        {title = 'Reload Hammerspoon Configuration', fn = hs.reload}
    })
end


generate_menu()