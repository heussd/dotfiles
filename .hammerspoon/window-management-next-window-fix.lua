-- Fix "Focus next window" hotkey which seems to be broken since Sonoma
-- https://www.reddit.com/r/MacOS/comments/16zpjau/comment/k79y4pd/?context=3


function getOrderedWindowsOfCurrentApp()
  local currentWindow = hs.window.focusedWindow()
  local appWindows = currentWindow:application():allWindows()

  -- Filter out minimized windows and sort by window id
  local orderedWindows = {}
  for _, win in pairs(appWindows) do
    if not win:isMinimized() then
      table.insert(orderedWindows, win)
    end
  end
  table.sort(orderedWindows, function(a, b) return a:id() < b:id() end)

  return orderedWindows, currentWindow
end

function switchToNextWindowOfSameApp()
  local orderedWindows, currentWindow = getOrderedWindowsOfCurrentApp()

  for i, win in ipairs(orderedWindows) do
    if win == currentWindow then
      local nextWindow = orderedWindows[i + 1] or orderedWindows[1]
      nextWindow:focus()
      break
    end
  end
end

function switchToPreviousWindowOfSameApp()
  local orderedWindows, currentWindow = getOrderedWindowsOfCurrentApp()

  for i, win in ipairs(orderedWindows) do
    if win == currentWindow then
      local previousWindow = orderedWindows[i - 1] or orderedWindows[#orderedWindows]
      previousWindow:focus()
      break
    end
  end
end

hs.hotkey.bind('cmd', '`', switchToNextWindowOfSameApp)
hs.hotkey.bind({'cmd', '`'}, '=', switchToPreviousWindowOfSameApp)
