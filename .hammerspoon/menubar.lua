local bar = hs.menubar.new()


require('time-tracker')


function update_menubar()
    print("Updating")
    local cw = "CW " .. string.format("%u", os.date("%V"))
    local stats = show_work_stats()

    if stats == "0.0 / 0.0" then
        local styledText = hs.styledtext.new(cw .. "\n ", {
        font = {name = ".AppleSystemUIFont", size = 8},
            color = {hex = "#FFFFFF"}
        })
        bar:setTitle(styledText)
        return
    else
        local clock_ticking = worktimer:running() and "🔴" or "⏸"

        local styledText = hs.styledtext.new(cw .. "\n " .. clock_ticking .. " " .. stats, {
            font = {name = ".AppleSystemUIFont", size = 8},
            color = {hex = "#FFFFFF"}
        })
        bar:setTitle(styledText)
    end
end



update_menubar()
updateTimer = hs.timer.doEvery(60, function()
    update_menubar()
end)



function test()
    hs.alert("OMG")
    hs.caffeinate.lockScreen()
    generate_menu()
end

-- https://www.ohmyrss.com/post/1590808168248
-- function: read applescript content. copy content to data
function applescript_reader(string)
    local path = string
    local file = io.open(path, "r")
    local data = file:read("*a")
    file:close()
    return data
end

function toggle_dark_mode()
    hs.execute("~/.scripts/dark-mode", true)
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

function gita_sync()
    local output = hs.execute("gita sync", true)
    hs.alert(output)
end 

function open_config()
    hs.execute("code ~/.hammerspoon", true)
end

function sponge_type(word)
    local result = ""
    for i = 1, #word do
        local c = word:sub(i,i)
        if (math.fmod(i,2) == 0) then
            result = result .. c
        else
            result = result .. c:upper()
        end
    end
    return result
end

function spongeTypeClipboard()
    local string = hs.pasteboard.readString()
    string = string:gsub(" ", "  ")
    string = sponge_type(string)
    string = string:gsub("  ", " ")
    hs.alert(string)

    hs.pasteboard.writeObjects(string)
end

function focus_mode()
    windowFilter = hs.window.filter.new():setOverrideFilter{
    visible = true,
    fullscreen = false,
    allowScreens = '-1,0',
    currentSpace = true
  }
  hs.alert(hs.window.highlight)
  hs.window.highlight.start(nil, windowFilter)
end


require('media-control')

function toggleMediaControl()
    mediaControlActive = not mediaControlActive
    if mediaControlActive then
        horizontalScroll:start()
        homeButton:start()
        
        for i = 1, 10 do
            hs.eventtap.event.newSystemKeyEvent('BRIGHTNESS_DOWN', true):post()
            hs.eventtap.event.newSystemKeyEvent('BRIGHTNESS_DOWN', false):post()
        end
    else
        horizontalScroll:stop()
        homeButton:stop()
    end
end




function toggleWorktimer()
    if worktimer:running() then
        worktimer:stop()
    else
        worktimer:start()
    end

    update_menubar()
    generate_menu()
end


function generate_menu()
    bar:setMenu({
        {title = "-" },
        {title = "Work timer is " .. (worktimer:running() and "ON" or "OFF"), fn = toggleWorktimer},
        {title = "Toggle Dark Mode", fn = toggle_dark_mode },
        {title = "-" },
        {title = "Toggle Mouse media control Mode", fn = toggleMediaControl },
        {title = "Gita sync", fn = gita_sync },
        {title = "-" },
        {title = "Focus Mode", fn = focus_mode },
        {title = "Good Night", fn = goodnight},
        {title = "Download Auto Sort", fn = download_autosort},
        {title = "-" },
        {title = "MoCkInG SPoNgE TYpE CLiPbOaRd", fn = spongeTypeClipboard},
        {title = "-" },
        {
            title = hs.caffeinate.get("displayIdle") and "Display stays AWAKE" or "Display will sleep",
            checked = hs.caffeinate.get("displayIdle"),
            fn = toggle_caffeine
        },
        {title = "-" },
        {title = 'Hammerspoon Console', fn = hs.toggleConsole},
        {title = "-" },
        {title = 'Edit Hammerspoon Configuration', fn = open_config},
        {title = 'Reload Hammerspoon Configuration', fn = hs.reload}
    })
end


generate_menu()


menuStandbyWatcher = hs.caffeinate.watcher.new(function(eventType)
    if eventType == hs.caffeinate.watcher.screensDidUnlock then
        hs.sleep(4)
        update_menubar()
    end
end)
menuStandbyWatcher:start()