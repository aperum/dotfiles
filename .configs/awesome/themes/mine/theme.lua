---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/"

theme = {}

theme.font = "Work Sans 11"
-- theme.taglist_font = "Roboto Mono Medium 15"
theme.taglist_font = "Work Sans Medium 15"

theme.bg_normal = "#1a1b26"
theme.bg_focus = "#545c7e"
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = "#353b45"
theme.bg_systray = theme.bg_normal
theme.bg_light = "#1a1438"
theme.bg_bar = "#3a3458"
-- theme.wibar_bg = "#1a1b26aa"
theme.wibar_bg = theme.bg_bar

theme.fg_normal = "#c0caf5"
theme.fg_focus = "#9ece6a"
theme.fg_urgent = "#bb9af7"
theme.fg_minimize = "#000000"

theme.useless_gap = dpi(3)
theme.border_width = dpi(3)
theme.border_normal = "#7aa2f7"
theme.border_focus = theme.fg_focus
theme.border_marked = "#9ece6a"
theme.border_wibar = "#000000FF"

theme.systray_icon_spacing = dpi(5)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.tasklist_disable_icon = true

-- Generate taglist squares:
--local taglist_square_size = dpi(4)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--    taglist_square_size, theme.fg_normal
--)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--    taglist_square_size, theme.fg_normal
--)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "mine/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)
theme.menu_border_color = "#000000DD"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "mine/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "mine/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "mine/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "mine/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "mine/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "mine/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "mine/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "mine/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "mine/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "mine/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "mine/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "mine/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "mine/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "mine/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "mine/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "mine/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "mine/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "mine/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "mine/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "mine/titlebar/maximized_focus_active.png"

--theme.wallpaper = themes_path.."mine/background.png"
--theme.wallpaper = themes_path.."mine/walls/starry_night-wallpaper-1920x1080.jpg"
--theme.wallpaper = {}
--theme.wallpaper[1] = home .. "/Pictures/kg2SiD.jpg"
--theme.wallpaper[2] = home .. "/Pictures/GpUinf.png"
theme.wallpaper = function(s)
  local wallpapers = {
    themes_path .. "mine/walls/deep_blue.jpg",
    home .. "/wall.png",
    home .. "/Pictures/kg2SiD.jpg",
    home .. "/Pictures/GpUinf.png",
  }

  return wallpapers[s.index]
end

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "mine/layouts/fairh.png"
theme.layout_fairv = themes_path .. "mine/layouts/fairv.png"
theme.layout_floating = themes_path .. "mine/layouts/floating.png"
theme.layout_magnifier = themes_path .. "mine/layouts/magnifier.png"
theme.layout_max = themes_path .. "mine/layouts/max.png"
theme.layout_fullscreen = themes_path .. "mine/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "mine/layouts/tilebottom.png"
theme.layout_tileleft = themes_path .. "mine/layouts/tileleft.png"
theme.layout_tile = themes_path .. "mine/layouts/tile.png"
theme.layout_tiletop = themes_path .. "mine/layouts/tiletop.png"
theme.layout_spiral = themes_path .. "mine/layouts/spiral.png"
theme.layout_dwindle = themes_path .. "mine/layouts/dwindle.png"
theme.layout_cornernw = themes_path .. "mine/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "mine/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "mine/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "mine/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
