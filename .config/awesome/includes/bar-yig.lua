local lain = require("lain")

local markup = lain.util.markup

-- {{{ Helper functions
local function client_menu_toggle_fn()
  local instance = nil

  return function()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}

-- Separators
local first = wibox.widget.textbox(markup.font("Tamzen 3", " "))
local spr = wibox.widget.textbox(" ")
local small_spr = wibox.widget.textbox(markup.font("Tamzen 4", " "))
local bar_spr = wibox.widget.textbox(
  markup.font("Tamzen 3", " ") .. markup.fontfg(theme.font, "#333333", "|") .. markup.font("Tamzen 5", " ")
)

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
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
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({}, 3, client_menu_toggle_fn()),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

-- wifi
wifiwidget = wibox.widget.textbox()
vicious.register(
  wifiwidget,
  vicious.widgets.wifi,
  'Connected to <span color="#7F9F7F">${ssid}</span> at <span color="#7F9F7F">${linp}%</span> | ',
  2,
  "wlp2s0"
)

-- Possible network devices
eths = { "enp0s31f6", "wlp2s0" }
netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net, function(widget, args)
  t = ""
  for i = 1, #eths do
    e = eths[i]
    if args["{" .. e .. " carrier}"] == 1 then
      if e == "wlp2s0" then
        t = t
          .. " "
          .. 'Wifi: <span color="#CC9933"> down: '
          .. args["{" .. e .. " down_kb}"]
          .. ' kbps</span>  <span color="#7F9F7F">up: '
          .. args["{" .. e .. " up_kb}"]
          .. " kbps </span>"
          .. "[ "
          .. args["{" .. e .. " rx_gb}"]
          .. " GB // "
          .. args["{" .. e .. " tx_gb}"]
          .. " GB ] "
      else
        t = t
          .. "| "
          .. 'Eth0: <span color="#CC9933"> down: '
          .. args["{" .. e .. " down_kb}"]
          .. ' kbps</span>  <span color="#7F9F7F">up: '
          .. args["{" .. e .. " up_kb}"]
          .. " kbps </span>"
          .. "[ "
          .. args["{" .. e .. " rx_gb}"]
          .. " GB // "
          .. args["{" .. e .. " tx_gb}"]
          .. " GB ] "
      end
    end
  end
  if string.len(t) > 0 then -- remove leading '|'
    return string.sub(t, 1, -1)
  end
  return "No network detected "
end, 1)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    for s = 1, screen.count() do
      gears.wallpaper.maximized(wallpaper, s, true)
    end
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ " Work ", " Misc ", " Shell ", " Srv ", " WWW ", " IM ", " Root ", " Mail " }, s, awful.layout.layouts[3])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

  -- Create a tasklist widget
  --s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
  s.mytasklist = awful.widget.tasklist(s)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "bottom", screen = s, height = 18 })
  --s.mywibox.bg = gears.color.create_pattern({
  --    type = "linear",
  --    from = { 0, 0 },
  --    to   = { 0, s.mywibox.height },
  --    stops = { { 0, "#000000" }, { 1, "#000077" } }
  --})

  -- Add widgets to the wibox
  s.mywibox:setup({
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
      --mykeyboardlayout,
      bar_spr,
      wifiwidget,
      bar_spr,
      require("battery-widget")({}),
      bar_spr,
      wibox.widget.systray(),
      bar_spr,
      mytextclock,
      bar_spr,
      s.mylayoutbox,
    },
  })
end)

-- load the widget code
local calendar = require("calendar")

-- attach it as popup to your text clock widget:
calendar({}):attach(mytextclock)
