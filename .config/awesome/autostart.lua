local awful = require("awful")

-- check if we are virtualized
local virthandle = io.popen("systemd-detect-virt")
local virt = virthandle:read("*a")
virthandle:close()
virt = string.gsub(virt, "%s+", "")

-- invoke our screenlocker on start
-- awful.spawn.with_shell(awful.util.getdir("config") .. "/lock.sh")

-- spawn daemons for virtualized envs
if virt == "oracle" then
  awful.spawn("VBoxClient-all")
elseif virt == "vmware" then
  awful.spawn("vmware-user")
end

awful.spawn("picom -b")
-- awful.spawn("remmina -i")
