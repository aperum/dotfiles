local awful = require("awful")
local gears = require("gears")
local machi = require("layout-machi")
local helpers = require("helpers")
local menu = require("menu")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys.vim")

require("helpers")

local keys = {}

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
  --    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
  --              {description = "view previous", group = "tag"}),
  --    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
  --              {description = "view next", group = "tag"}),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, {
    description = "focus next by index",
    group = "client",
  }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, {
    description = "focus previous by index",
    group = "client",
  }),
  awful.key({ modkey }, "w", function()
    menu.mymainmenu:show()
  end, {
    description = "show main menu",
    group = "awesome",
  }),

  awful.key({ modkey }, "b", function()
    mouse.screen.mywibox.visible = not mouse.screen.mywibox.visible
  end, {
    description = "show/hide wibox",
    group = "screen",
  }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "swap with next client by index",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client by index",
    group = "client",
  }),
  awful.key({ modkey }, "Right", function()
    awful.screen.focus_relative(1)
  end, {
    description = "focus the next screen",
    group = "screen",
  }),
  awful.key({ modkey }, "Left", function()
    awful.screen.focus_relative(-1)
  end, {
    description = "focus the previous screen",
    group = "screen",
  }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey }, "l", function()
    awful.spawn("xautolock -locknow")
  end, {
    description = "lock screen",
    group = "launcher",
  }),
  awful.key({ "Mod1" }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = "go back",
    group = "client",
  }),

  -- Standard program
  awful.key({ modkey }, "s", function()
    awful.spawn(config.terminal)
  end, {
    description = "open a terminal",
    group = "launcher",
  }),
  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  -- Machi layout
  awful.key({ modkey }, ".", function()
    machi.default_editor.start_interactive()
  end, {
    description = "edit the current layout if it is a machi layout",
    group = "layout",
  }),
  awful.key({ modkey }, "+", function()
    machi.switcher.start(client.focus)
  end, {
    description = "switch between windows for a machi layout",
    group = "layout",
  }),

  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, {
    description = "increase master width factor",
    group = "layout",
  }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, {
    description = "decrease master width factor",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, {
    description = "increase the number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease the number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, {
    description = "increase the number of columns",
    group = "layout",
  }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, {
    description = "decrease the number of columns",
    group = "layout",
  }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, {
    description = "select next",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, {
    description = "select previous",
    group = "layout",
  }),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      client.focus = c
      c:raise()
    end
  end, {
    description = "restore minimized",
    group = "client",
  }),

  -- Hotkeys
  awful.key({ modkey }, "Return", function()
    hotkeys_popup.show_help()
  end, {
    dewcription = "show keybinding popup",
    group = "launcher",
  }),
  -- Prompt
  --awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
  awful.key({ modkey }, "r", function()
    awful.spawn(config.rofi_run)
  end, {
    description = "run prompt",
    group = "launcher",
  }),

  -- SSH
  -- awful.key({ modkey }, "c", function()
  --   awful.spawn(config.rofi_ssh)
  -- end, {
  --   description = "ssh connect prompt",
  --   group = "launcher",
  -- }),

  -- Window chooser
  awful.key({ modkey }, "Tab", function()
    awful.spawn(config.rofi_window)
  end, {
    description = "window chooser",
    group = "launcher",
  }),

  -- Rofi calculator
  -- awful.key({ modkey }, "c", function()
  --   awful.spawn(config.rofi_calc)
  -- end, {
  --   description = "calculator",
  --   group = "launcher",
  -- }),

  awful.key({ modkey }, "x", function()
    awful.prompt.run({
      prompt = "Run Lua code: ",
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval",
    })
  end, {
    description = "lua execute prompt",
    group = "awesome",
  }),
  -- Password rofi
  awful.key({ modkey }, "p", function()
    awful.spawn.with_shell(config.rofi_password)
  end, {
    description = "show the menubar",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "p", function()
    awful.spawn.with_shell(config.rofi_ppassword)
  end, {
    description = "show the menubar",
    group = "launcher",
  }),
  -- Toggle taskbar
  awful.key({ modkey, "Control" }, "t", function()
    awful.screen.focused().mytasklist.visible = not awful.screen.focused().mytasklist.visible
  end, {
    description = "toggle taskbar visabilility",
    group = "layout",
  })
)

keys.clientkeys = gears.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, {
    description = "toggle fullscreen",
    group = "client",
  }),
  awful.key({ modkey, "Mod1" }, "m", function()
    helpers.maximize_all_clients()
  end, {
    description = "toggle maximize all clients",
    group = "screen",
  }),
  awful.key({ modkey, "Shift" }, "c", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, {
    description = "move to master",
    group = "client",
  }),
  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, {
    description = "move to screen",
    group = "client",
  }),
  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, {
    description = "toggle keep on top",
    group = "client",
  }),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, {
    description = "minimize",
    group = "client",
  }),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, {
    description = "(un)maximize",
    group = "client",
  }),
  awful.key({ modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, {
    description = "(un)maximize vertically",
    group = "client",
  }),
  awful.key({ modkey }, "z", function(c)
    c.floating = true
    local geo = screen[1].geometry
    geo.x2 = geo.x + geo.width
    geo.y2 = geo.y + geo.height
    for s in screen do
      local geo2 = s.geometry
      geo.x = math.min(geo.x, geo2.x)
      geo.y = math.min(geo.y, geo2.y)
      geo.x2 = math.max(geo.x2, geo2.x + geo2.width)
      geo.y2 = math.max(geo.y2, geo2.y + geo2.height)
    end
    c:geometry({
      x = geo.x,
      y = geo.y,
      width = geo.x2 - geo.x,
      height = geo.y2 - geo.y,
    })
  end, {
    description = "really big window",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, {
    description = "(un)maximize horizontally",
    group = "client",
  })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  keys.globalkeys = gears.table.join(
    keys.globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, {
      description = "view tag #" .. i,
      group = "tag",
    }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, {
      description = "toggle tag #" .. i,
      group = "tag",
    }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, {
      description = "move focused client to tag #" .. i,
      group = "tag",
    }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, {
      description = "toggle focused client on tag #" .. i,
      group = "tag",
    })
  )
end

keys.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    client.focus = c
    c:raise()
  end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(keys.globalkeys)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function()
    menu.mymainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

return keys
