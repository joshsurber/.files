-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    { raise = true }
                )
            end
        end),
        awful.button({}, 3, function()
            awful.menu.client_list({ theme = { width = 250 } })
        end),
        awful.button({}, 4, function()
            awful.client.focus.byidx(1)
        end),
        awful.button({}, 5, function()
            awful.client.focus.byidx( -1)
        end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc( -1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc( -1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            -- filter  = awful.widget.taglist.filter.noempty,
            buttons = taglist_buttons
        }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Create a textclock widget
    -- mytextclock = wibox.widget.textclock('%H.%M')
    mytextclock = wibox.widget.textclock('%b %d, %R')

    local memwidget = awful.widget.watch(
            [[ bash -c 'free|head -2|tail -1' ]], 2,
            function(widget, stdout)
                local used, total
                for str in stdout:gmatch("%d+") do
                    if total == nil then
                        total = str
                    elseif used == nil then
                        used = str
                    end
                end
                widget:set_text(string.format('Mem: %.0f%%', used / total * 100))
            end)

    local uptimewidget = awful.widget.watch('uptime -p', 61,
            function(widget, stdout)
                stdout = stdout:gsub('up', 'Up:')
                stdout = stdout:gsub(' weeks?,?', 'w')
                stdout = stdout:gsub(' days?,?', 'd')
                stdout = stdout:gsub(' hours?,?', 'h')
                stdout = stdout:gsub(' minutes?,?', 'm')
                widget:set_text(stdout)
            end)

    local weatherwidget = awful.widget.watch(
            [[ curl -s http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=0\&locCode\=78245 ]],
            97, function(widget, stdout)
            for line in stdout:gmatch("[^\r\n]+") do
                if line:match("Currently") then
                    line = line:gsub('<title>Currently: ', '')
                    line = line:gsub('</title>', '')
                    widget:set_text(line)
                    return
                end
            end
        end)

    local fswidget = awful.widget.watch(
            "bash -c 'df -h --output='used,size,pcent' /|tail -1'",
            29, function(widget, stdout)
            local t = {}
            for str in stdout:gmatch('[^%s]+') do
                table.insert(t,str)
                -- t:insert(str)
            end
            widget:set_text(string.format('HD: %s/%s (%s)',t[1],t[2],t[3]))
        end
        )

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher, -- logo button
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            -- cpuwidget,
            weatherwidget,
            uptimewidget,
            fswidget,
            memwidget,
            wibox.widget.systray(),
            datewidget,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
