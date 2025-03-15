function log()
    os.execute("mkdir -p " .. os.getenv("HOME") .. "/time-tracking")
    filename=os.date(os.getenv("HOME") .. '/time-tracking/%Y-CW-%V.log')
    file = io.open(filename, "a")
    file:write(string.format('%s;On for 5 minutes;\n', os.date('%Y-%m-%dT%H:%M:%S')))
    file:close()
end


worktimer = hs.timer.new((5*60), function()
    print("Log work activity")
    log()
end)



-- Find the most recent log file
function find_latest_log()
    local handle = io.popen('ls -t ~/time-tracking/[0-9][0-9][0-9][0-9]-CW-*.log 2>/dev/null | head -n1')
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+$", "") -- trim whitespace
end

-- Process the log file and return daily and weekly stats
function process_log(filename)
    if filename == "" then
        print("Error: No log file found matching pattern YYYY-CW-*.log")
        os.exit(1)
    end

    print("Using log file: " .. filename)
    
    -- Read the file and process lines
    local daily_counts = {}
    local total_count = 0
    
    for line in io.lines(filename) do
        total_count = total_count + 1
        local date = line:match("^([^,]+)")  -- get first field before comma
        if date then
            date = date:match("^(.-)T") -- get part before T
            daily_counts[date] = (daily_counts[date] or 0) + 1
        end
    end
    
    local dates = {}
    for date in pairs(daily_counts) do
        table.insert(dates, date)
    end
    table.sort(dates)
    local day,week = "",""
    for _, date in ipairs(dates) do
        local count = daily_counts[date]
        local hours = math.floor(count * 5 / 60)
        local minutes = (count * 5) % 60
        day = string.format("%d:%02d", hours, minutes)
    end

    local total_hours = math.floor(total_count * 5 / 60)
    local total_minutes = (total_count * 5) % 60
    week = string.format("%d:%02d", total_hours, total_minutes)


    return day .. " / " .. week
end


function show_work_stats()
    local log_file = find_latest_log()
    if log_file == nil or log_file == "" then
        return "0.0 / 0.0"
    end
    return process_log(log_file)
end


function start_automatically()
    local hostname = hs.host.localizedName()
    if not hostname:sub(1,2) == "AU" then
        return
    end

    local day_of_week = tonumber(os.date("%w"))
    if day_of_week == 0 or day_of_week == 6 then
        return
    end

    worktimer:start()
    print("Starting work log tracker")
end
start_automatically()


standbyWatcher = hs.caffeinate.watcher.new(function(eventType)
    if eventType == hs.caffeinate.watcher.screensDidLock then
        print("[TT] screens locked, stopping work timer.")
        worktimer:stop()
    elseif eventType == hs.caffeinate.watcher.screensDidUnlock then
        print("[TT] screens unlocked, starting work timer.")
        start_automatically()
    end
end)
standbyWatcher:start()
