local gears = require("gears")
require("awful.autofocus")

local socket = require("socket")
local hostname = socket.dns.gethostname()
local host = hostname:match("([%w]+).?")
local home = os.getenv("HOME")

require("errorhandling")
require("defines")
require("keys")
require("bars." .. host)
require("rules")
require("signals")
require("autostart")

collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(10, function()
  collectgarbage("step", 20000)
  return true
end)
