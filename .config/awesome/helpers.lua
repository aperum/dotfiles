local awful = require("awful")

local helpers = {}

-- check if we are virtualized
local virthandle = assert(io.popen("systemd-detect-virt"))
helpers.virt_result = assert(virthandle:read("*a"))
virthandle:close()

helpers.run_once = function(cmd_arr)
  local findme = ''

  for _, cmd in ipairs(cmd_arr) do
    findme = cmd
    local firstspace = cmd:find(" ")
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
  end
end

helpers.maximize_all_clients = function()
  local t = awful.screen.focused().selected_tag

  local clients = t:clients()

  local s = not clients[1].maximized

  for p = 1, #clients do
    clients[p].maximized = s
  end
end

return helpers
