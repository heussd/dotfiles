local bar = hs.menubar.new()
-- bar:setTitle(hs.host:localizedName())
bar:setTitle("CW " .. string.format("%u", os.date( "%V")))


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


function generate_menu()
    bar:setMenu({
        {title = "-" },
        {title = "Toggle Dark Mode", fn = toggle_dark_mode },
        {title = "-" },
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
