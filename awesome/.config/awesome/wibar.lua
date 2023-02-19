-- Create a textclock widget
mytextclock = wibox.widget.textclock('%H.%M')

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

    local vicious = require('vicious')
    -- https://vicious.readthedocs.io/en/latest/widgets.html
    local datewidget = wibox.widget.textbox()
    vicious.register(datewidget, vicious.widgets.date, "%b %d, %R")

    local memwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.mem)
    vicious.register(memwidget, vicious.widgets.mem, "Mem: $1%", 15)
    -- vicious.register(memwidget, vicious.widgets.mem, "Mem: $1% ($2MiB/$3MiB)", 15)

    -- local cpuwidget = awful.widget.graph()
    -- cpuwidget:set_width(50)
    -- cpuwidget:set_background_color "#494B4F"
    -- cpuwidget:set_color { type = "linear", from = { 0, 0 }, to = { 50, 0 },
    --     stops = { { 0, "#FF5656" },
    --         { 0.5, "#88A175" },
    --         { 1,   "#AECF96" } } }
    -- vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 3)

    local uptimewidget = wibox.widget.textbox()
    -- vicious.cache(vicious.widgets.uptime)
    vicious.register(uptimewidget, vicious.widgets.uptime, "Up: $1d$2h LdAvg $4")

    local weatherwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.weather)
    vicious.register(weatherwidget, vicious.widgets.weather, function(widget, args)
        local wind = string.gmatch(args['{wind}'], "[NEWS]+")()
        return ("%dF, %s, %s %smph"):format(
                args['{tempf}'], args['{sky}'], wind, args['{windmph}'])
    end, 2, 'KSAT')

    local fswidget = wibox.widget.textbox()
    vicious.register(fswidget, vicious.widgets.fs, function(widget, args)
        return ("HD: %sG of %sG"):format(args['{/ used_gb}'], args['{/ size_gb}'])
    end)

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
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
            s.mylayoutbox,
        },
    }
end)
