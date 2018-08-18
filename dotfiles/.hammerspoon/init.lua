-------------------------------------------------------------------------------
-- Key mapping
-------------------------------------------------------------------------------

local fnKeyToSystemKey = {
    {fnKey = 'f1', systemKey = 'BRIGHTNESS_DOWN'},
    {fnKey = 'f2', systemKey = 'BRIGHTNESS_UP'},
    {fnKey = 'f7', systemKey = 'PREVIOUS'},
    {fnKey = 'f8', systemKey = 'PLAY'},
    {fnKey = 'f9', systemKey = 'NEXT'},
    {fnKey = 'f10', systemKey = 'MUTE'},
    {fnKey = 'f11', systemKey = 'SOUND_DOWN'},
    {fnKey = 'f12', systemKey = 'SOUND_UP'},
}

-- Map fn function keys to system keys
for _,fnKeyMap in ipairs(fnKeyToSystemKey) do
    hs.hotkey.bind({}, fnKeyMap.fnKey,
        function()
            hs.eventtap.event.newSystemKeyEvent(fnKeyMap.systemKey, true):post()
        end,
        function()
            hs.eventtap.event.newSystemKeyEvent(fnKeyMap.systemKey, false):post()
        end
    )
end

-- Map right command + escape to grave accent (`)
hs.hotkey.bind({'rightcmd'}, 'escape', function()
    hs.eventtap.keyStroke({}, '`')
end)

-- Lock the system with shift + ctrl + delete.
hs.hotkey.bind({'shift', 'ctrl'}, 'delete', function()
    hs.caffeinate.lockScreen()
end)

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

