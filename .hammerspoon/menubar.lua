local bar = hs.menubar.new()
bar:setTitle("™")


function test()
    hs.alert("OMG")
    hs.caffeinate.lockScreen()
    generate_menu()
end

function toggle_caffeine()
    hs.caffeinate.toggle("displayIdle")
    generate_menu()
end


function generate_menu()
    bar:setMenu({
        {title = "TEST", fn = test},
        {title = hs.caffeinate.get("displayIdle") and "Display stays AWAKE" or "Display will sleep", fn = toggle_caffeine},
        {title = 'Hammerspoon Console', fn = hs.toggleConsole}
    })
end


generate_menu()