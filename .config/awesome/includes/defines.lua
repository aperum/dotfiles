hotkeys_popup = require("awful.hotkeys_popup").widget

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.get_configuration_dir() .. "themes/mine/theme.lua")
--beautiful.init(awful.util.get_configuration_dir() .. "themes/chameleon/theme.lua")
beautiful.layout_machi = machi.get_icon()

-- This is used later as the default terminal and editor to run.
--terminal = "urxvt"
if virt == "oracle" then
  terminal = "alacritty"
else
  terminal = "wezterm"
end

editor = os.getenv("EDITOR") or "gvim"
editor_cmd = editor

rofi_run = "rofi -show drun"
rofi_ssh = home .. "/bin/rofi-remmina.sh"
rofi_window = "rofi -show window"
rofi_password = home .. "/bin/rp.sh"
rofi_ppassword = home .. "/bin/rpp.sh"
rofi_calc = "rofi -show calc -modi calc -no-show-match -no-sort"
