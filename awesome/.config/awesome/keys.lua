-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
local KeyOS = { modkey }
local CtlOS = { modkey, "Control" }
local SftOS = { modkey, "Shift" }
local CtrlShiftOS = { modkey, "Control", "Shift" }
-- local DMargs=' -i -l 20 -fn CascadiaMono-10'
local DMargs = ' -i -fn CascadiaMono-10'
local awesome, client = awesome, client

globalkeys = gears.table.join(
    -- Global commands
        awful.key(KeyOS, "d", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
        awful.key(CtlOS, "z", awesome.restart, { description = "reload awesome", group = "awesome" }),
        awful.key(CtlOS, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

        -- System stuff
        -- awful.key(KeyOS, "l", function() awful.spawn('xscreensaver-command -lock') end, { description = "Lock screen", group = "launcher" }),
        awful.key(KeyOS, "v", function() awful.spawn('clipmenu' .. DMargs) end, { description = "Clipboard history", group = "system" }),
        awful.key(KeyOS, "l", function() awful.spawn('slock') end, { description = "Lock screen", group = "system" }),
        awful.key(SftOS, "z", function() awful.spawn('nitrogen --restore') end, { description = "Restore wallpaper", group = "system" }),
        awful.key(KeyOS, "x", function() awful.spawn('dm-logout') end, { description = "Power menu", group = "system" }),
        awful.key(KeyOS, "p", function() awful.spawn('dmenu_run' .. DMargs) end, { description = "run dmenu", group = "system" }),
        awful.key(CtlOS, "p", function() awful.spawn('dmenu_run -z ' .. DMargs) end, { description = "run dmenu fuzzy", group = "system" }),
        awful.key(KeyOS, "b", function() awful.spawn("dm-lights") end, {description="Adjust backlight",group="system"}),
        awful.key(KeyOS, "Print", function() awful.util.spawn("dm-maim") end, {description="Take screenshot with options",group="system"}),
        awful.key({}, "Print", function() awful.util.spawn_with_shell("maim --select | xclip -selection clipboard -target image/png") end, {description="Copy area screenshot to clipboard",group="system"}),
        -- awful.key(KeyOS, "r", function() awful.screen.focused().mypromptbox:run() end, { description = "run prompt", group = "launcher" }),
        -- awful.key(KeyOS, "w", function() mymainmenu:show() end, { description = "show main menu", group = "awesome" }),

        -- Switch windows
        awful.key(KeyOS, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
        awful.key(KeyOS, "Tab", function() awful.client.focus.history.previous() if client.focus then client.focus:raise() end end, { description = "go back", group = "client" }),
        awful.key(KeyOS, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
        awful.key(KeyOS, "n", function() awful.client.focus.byidx(1) end, { description = "focus next by index", group = "client" }),
        awful.key(KeyOS, "e", function() awful.client.focus.byidx( -1) end, { description = "focus previous by index", group = "client" }),
        awful.key(CtlOS, "n", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),
        awful.key(CtlOS, "e", function() awful.screen.focus_relative( -1) end, { description = "focus the previous screen", group = "screen" }),

        -- Move and resize windows
        awful.key(SftOS, "k", function() local c = awful.client.restore() if c then c:emit_signal("request::activate", "key.unminimize", { raise = true }) end end, { description = "restore minimized", group = "client" }),
        awful.key(SftOS, "n", function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "client" }),
        awful.key(SftOS, "e", function() awful.client.swap.byidx( -1) end, { description = "swap with previous client by index", group = "client" }),
        awful.key(KeyOS, "h", function() awful.tag.incmwfact( -0.05) end, { description = "decrease master width factor", group = "layout" }),
        awful.key(KeyOS, "i", function() awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
        awful.key(SftOS, "h", function() awful.tag.incnmaster(1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
        awful.key(SftOS, "i", function() awful.tag.incnmaster( -1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),
        awful.key(CtlOS, "h", function() awful.tag.incncol(1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
        awful.key(CtlOS, "i", function() awful.tag.incncol( -1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),
        awful.key(KeyOS, "space", function() awful.layout.inc(1) end, { description = "select next layout", group = "layout" }),
        awful.key(SftOS, "space", function() awful.layout.inc( -1) end, { description = "select previous layout", group = "layout" }),

        -- Launcher
        awful.key(KeyOS, "r", function() awful.spawn('pcmanfm') end, { description = "launch pcmanfm", group = "launcher" }),
        awful.key(CtlOS, "r", function() awful.spawn(terminal .. ' -e vifm') end, { description = "launch vifm", group = "launcher" }),
        awful.key(KeyOS, "s", function() awful.spawn('google-chrome-stable') end, { description = "launch Chrome", group = "launcher" }),
        awful.key(CtlOS, "s", function() awful.spawn('qutebrowser') end, { description = "launch qutebrowser", group = "launcher" }),
        awful.key(KeyOS, "t", function() awful.spawn(terminal) end, { description = "open a terminal", group = "launcher" }),
        nil -- Allows for moving lines, since they can all end in a space
    )

clientkeys = gears.table.join(
        awful.key(SftOS, "f", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
        awful.key(KeyOS, "t", function(c) c.ontop = not c.ontop end, { description = "toggle keep on top", group = "client" }),
        awful.key(KeyOS, "k", function(c) c.minimized = true end, { description = "minimize", group = "client" }),
        awful.key(CtlOS, "Return", function(c) c:swap(awful.client.getmaster()) end, { description = "move to master", group = "client" }),
        awful.key(KeyOS, "f", function(c) c.fullscreen = not c.fullscreen c:raise() end, { description = "toggle fullscreen", group = "client" }),
        awful.key(KeyOS, "m", function(c) c.maximized = not c.maximized c:raise() end, { description = "(un)maximize", group = "client" }),
        awful.key(CtlOS, "m", function(c) c.maximized_vertical = not c.maximized_vertical c:raise() end, { description = "(un)maximize vertically", group = "client" }),
        awful.key(SftOS, "m", function(c) c.maximized_horizontal = not c.maximized_horizontal c:raise() end, { description = "(un)maximize horizontally", group = "client" }),
        awful.key(KeyOS, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "screen" }),
        awful.key(KeyOS, "q", function(c) c:kill() end, { description = "close", group = "client" }),

        -- Move and resize floating windows
        awful.key(KeyOS, "Next", function(c) c:relative_move(20, 20, -40, -40) end), -- bigger PgUp
        awful.key(KeyOS, "Prior", function(c) c:relative_move( -20, -20, 40, 40) end), -- smaller PgDn
        awful.key(KeyOS, "Up", function(c) c:relative_move(0, -20, 0, 0) end), -- move up
        awful.key(KeyOS, "Down", function(c) c:relative_move(0, 20, 0, 0) end), -- move down
        awful.key(KeyOS, "Left", function(c) c:relative_move( -20, 0, 0, 0) end), -- move left
        awful.key(KeyOS, "Right", function(c) c:relative_move(20, 0, 0, 0) end), -- move right
        awful.key(SftOS, "Up", function(c) c:relative_move(0, 20, 0, -40) end), -- shorter
        awful.key(SftOS, "Down", function(c) c:relative_move(0, -20, 0, 40) end), -- taller
        awful.key(SftOS, "Left", function(c) c:relative_move(20, 0, -40, 0) end), -- narrower
        awful.key(SftOS, "Right", function(c) c:relative_move( -20, 0, 40, 0) end), -- wider

        nil -- Allows for moving lines, since they can all end in a space
    )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
            -- View tag only.
            awful.key(KeyOS, "#" .. i + 9,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end,
                { description = "view tag #" .. i, group = "tag" }),
            -- Toggle tag display.
            awful.key(CtlOS, "#" .. i + 9,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end,
                { description = "toggle tag #" .. i, group = "tag" }),
            -- Move client to tag.
            awful.key(SftOS, "#" .. i + 9,
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end,
                { description = "move focused client to tag #" .. i, group = "tag" }),
            -- Toggle tag on focused client.
            awful.key(CtrlShiftOS, "#" .. i + 9,
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end,
                { description = "toggle focused client on tag #" .. i, group = "tag" })

        )
end

clientbuttons = gears.table.join(
    -- Move/resize via mouse (OS+left to move, OS+right to resize)
        awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
        awful.button(KeyOS, 1,
            function(c)
                c:emit_signal("request::activate", "mouse_click", { raise = true })
                awful.mouse.client.move(c)
            end),
        awful.button(KeyOS, 3,
            function(c)
                c:emit_signal("request::activate", "mouse_click", { raise = true })
                awful.mouse.client.resize(c)
            end)
    )

-- Set keys
root.keys(globalkeys)
