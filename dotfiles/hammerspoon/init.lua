--------------------------------------------------------------------------------
-- Left align window
--------------------------------------------------------------------------------
hs.hotkey.bind({'ctrl'}, 'forwarddelete', function()
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

--------------------------------------------------------------------------------
-- Right align window
--------------------------------------------------------------------------------
hs.hotkey.bind({'ctrl'}, 'pagedown', function()
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

--------------------------------------------------------------------------------
-- Center align window
--------------------------------------------------------------------------------
hs.hotkey.bind({'ctrl'}, 'end', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = (max.w - f.w) / 2
    f.y = max.y
    f.h = max.h
    win:setFrame(f)
end)

--------------------------------------------------------------------------------
-- Window focus
--------------------------------------------------------------------------------
hs.hotkey.bind({'ctrl'}, 'k', function()
    hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind({'ctrl'}, 'j', function()
    hs.window.focusedWindow():focusWindowSouth()
end)

hs.hotkey.bind({'ctrl'}, 'l', function()
    hs.window.focusedWindow():focusWindowEast(nil, true)
end)

hs.hotkey.bind({'ctrl'}, 'h', function()
    hs.window.focusedWindow():focusWindowWest(nil, true)
end)

hs.hotkey.bind({}, 'F12', function()
    hs.application.launchOrFocus('Xcode-beta')
    local xcode = hs.appfinder.appFromName('Xcode')
    xcode:activate()

    xcode:selectMenuItem({'Product', 'Run'})
end)
