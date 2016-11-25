-------------------------------------------------------------------------------
-- Window movement
-------------------------------------------------------------------------------

-- Left align window
hs.hotkey.bind({'cmd', 'shift', 'ctrl'}, 'h', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Right align window
hs.hotkey.bind({'cmd', 'shift', 'ctrl'}, 'l', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Center align window
hs.hotkey.bind({'cmd', 'shift', 'ctrl'}, 'm', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = (max.w - f.w) / 2
    f.y = max.y
    f.h = max.h
    win:setFrame(f)
end)
