local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys.vim")

local menu = {}

-- {{{ Menu
-- Create a launcher widget and a main menu
menu.myawesomemenu = {
  {
    "hotkeys",
    function()
      return false, hotkeys_popup.show_help
    end,
  },
  { "manual", config.terminal .. " -e man awesome" },
  { "edit config", config.editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  {
    "quit",
    function()
      awesome.quit()
    end,
  },
}

menu.mymainmenu = awful.menu({
  items = {
    { "awesome", menu.myawesomemenu, beautiful.awesome_icon },
    { "open terminal", config.terminal },
  },
})

menu.mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = menu.mymainmenu,
})

-- Menubar configuration
menubar.utils.terminal = config.terminal -- Set the terminal for applications that require it

return menu
