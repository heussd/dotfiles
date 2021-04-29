local bar = hs.menubar.new()
-- bar:setTitle(hs.host:localizedName())
bar:setTitle("™")


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
    hs.osascript.applescriptFromFile(os.getenv("HOME") .. "/.scripts/toggle-dark-mode.applescript")
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


function generate_menu()
    bar:setMenu({
        {title = "-" },
        {title = "Toggle Dark Mode", fn = toggle_dark_mode },
        {title = "-" },
        {title = "Good Night", fn = goodnight},
        {title = "Download Auto Sort", fn = download_autosort},
        {title = "-" },
        {title = "MoCkInG SPoNgE TYpE CLiPbOaRd", fn = spongeTypeClipboard},
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
        {title = 'Edit Hammerspoon Configuration', fn = open_config},
        {title = 'Reload Hammerspoon Configuration', fn = hs.reload}
    })
end


generate_menu()