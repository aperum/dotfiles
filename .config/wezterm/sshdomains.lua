local wezterm = require("wezterm")

local identityfiles = "id_rsa id_ed25519 id_abilis"
local home = os.getenv("HOME")

local M = {}

local function get_hostnames()
  local hosts = {}
  local file = io.open(home .. "/.ssh/known_hosts", "r")

  for line in file:lines() do
    -- Der Hostname ist der erste Teil der Zeile, getrennt durch ein Leerzeichen oder ein Komma
    local host = line:match("([^ ,]+)")

    if not hosts[host] then
      hosts[host] = true
    end
  end

  file:close()

  return hosts
end

local function get_identities()
  local ident = ""

  for i in string.gmatch(identityfiles, '%w+') do
    ident = ident .. home .. "/.ssh/" .. i .. " "
  end

  return ident
end

function M.apply_to_config(config)
  local hosts = get_hostnames()

  config.ssh_domains = wezterm.default_ssh_domains()

  for h in pairs(hosts) do
    table.insert(config.ssh_domains,
      {
        name = h,
        remote_address = h,
        username = "root",
        ssh_option = {
          identityfile = "/home/aperum/.ssh/id_abilis"
        },
      })
  end
end

return M
