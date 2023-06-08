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
local half_spr = wibox.widget.textbox(" ")
local task_spr = wibox.widget.textbox("               ")

-- Systray
local systray = wibox.container.margin(wibox.widget.systray(), 3, 3, 3, 3)

local function custom_shape(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, RADIUS)
end

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a wibox for each screen and add it
awful.util.taglist_buttons = awful.util.table.join(
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
  awful.button({}, 5, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 4, function(t)
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

--local volumearc_widget = require("awesome-wm-widgets.volumearc-widget.volumearc")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local lo = awful.layout.layouts
local my_tags = {
  tags = {
    {
      --names = { "3as", "Misc", "Shell", "Hastur", "WWW", "IM", "Root", "Mail" },
      names = { "", "󰖷", "󰅬", "", "", "󰍩", "󰅬", "" },
      layout = { lo[3], lo[3], lo[3], lo[3], lo[3], lo[3], lo[3], lo[3], lo[3] },
      icons = {
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      },
    },
    {
      names = { "Calendar", "Music" },
      layout = { lo[3], lo[3] },
      icons = {
        "",
        "",
      },
    },
  },
}
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  awful.tag(my_tags.tags[s.index].names, s, my_tags.tags[s.index].layout)
  for i, t in ipairs(s.tags) do
    local icon = my_tags.tags[s.index].icons[i]
    if icon ~= "" then
      t.icon = icon
      t.icon_only = 1
    end
  end

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
  --
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    style = {
      shape = gears.shape.rounded_rect,
    },
    layout = {
      spacing = 0,
      spacing_widget = {
        color = theme.fg_normal,
        shape = gears.shape.rounded_rect,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          {
            shape = "",
            widget = wibox.container.background,
          },
          {
            {
              id = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 0,
            widget = wibox.container.margin,
          },
          {
            id = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.align.horizontal,
        },
        left = 8,
        right = 8,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
    buttons = awful.util.taglist_buttons,
  })

  -- Create a tasklist widget
  -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.minimizedcurrenttags, tasklist_buttons)
  -- s.mytasklist.visible = true

  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.minimizedcurrenttags,
    buttons = tasklist_buttons,
    style = {
      shape_border_width = 1,
      shape_border_color = theme.bg_light,
      shape = gears.shape.rounded_bar,
    },
    layout = {
      spacing = 10,
      spacing_widget = {
        {
          forced_width = 5,
          shape = gears.shape.circle,
          widget = wibox.widget.separator,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      layout = wibox.layout.flex.horizontal,
    },
  })

  -- Create the wibox
  local box_width = s.geometry.width * 0.97
  local box_height = 24

  s.mywibox = wibox({
    screen = s,
    height = box_height,
    width = box_width,
    x = (s.geometry.width - box_width) / 2,
    y = 4,
    bg = theme.bg_light,
    shape = custom_shape,
    -- border_width = 3,
    -- border_color = theme.border_wibar,
    visible = true,
  })
  s.mywibox:struts({ top = box_height + 3 })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    {
      -- Left widgets
      {
        layout = wibox.layout.fixed.horizontal,
        {
          s.mytaglist,
          bg = theme.wibar_bg,
          shape = gears.shape.rounded_rect,
          widget = wibox.container.background,
        },
      },
      -- widget = wibox.container.margin,
      widget = wibox.container.margin,
      bottom = 2,
      top = 2,
      left = 2,
    },
    {
      -- Center widgets
      {
        layout = wibox.layout.align.horizontal,
        task_spr,
        {
          s.mytasklist,
          shape = gears.shape.rounded_rect,
          widget = wibox.container.background,
        },
        task_spr,
      },
      widget = wibox.container.margin,
      bottom = 2,
      top = 2,
    },
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      {
        {
          layout = wibox.layout.fixed.horizontal,
          {
            {
              layout = wibox.layout.fixed.horizontal,
              half_spr,
              todo_widget(),
              half_spr,
            },
            bg = theme.wibar_bg,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
          },
          half_spr,
          {
            {
              layout = wibox.layout.fixed.horizontal,
              half_spr,
              volume_widget({
                device = "default",
                widget_type = "arc",
              }),
              half_spr,
            },
            bg = theme.wibar_bg,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
          },
          half_spr,
          {
            {
              layout = wibox.layout.fixed.horizontal,
              valign = "center",
              half_spr,
              mytextclock,
              half_spr,
            },
            bg = theme.wibar_bg,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
          },
          half_spr,
          {
            {
              layout = wibox.layout.fixed.horizontal,
              half_spr,
              systray,
              half_spr,
            },
            bg = theme.wibar_bg,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
          },
          half_spr,
          {
            {
              layout = wibox.layout.fixed.horizontal,
              half_spr,
              s.mylayoutbox,
              -- half_spr,
            },
            -- bg = theme.bg,
            bg = theme.wibar_bg,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
          },
          -- half_spr,
        },
        widget = wibox.container.margin,
        bottom = 2,
        top = 2,
        right = 2,
      },
    },
  })
end)

-- load the widget code
local calendar = require("awesome-wm-widgets.calendar-widget.calendar")
local cw = calendar({
  theme = "outrun",
  placement = "top_right",
})

mytextclock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    cw.toggle()
  end
end)
