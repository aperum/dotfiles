-- Get home directory
home = os.getenv("HOME")

-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")
vicious = require("vicious")
machi = require("layout-machi")
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
--require("awful.remote")

local socket = require("socket")
local hostname = socket.dns.gethostname()
local host = hostname:match("([%w]+).?")

require("includes/errorhandling")
require("includes/defines")
require("includes/functions")
require("includes/run_once")
require("includes/keys")
require("includes/bar-" .. host)
require("includes/menu")
require("includes/rules")
require("includes/signals")
require("includes/autostart")

collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(10, function()
  collectgarbage("step", 20000)
  return true
end)
