-- check if we are virtualized
local virt = os.execute("systemd-detect-virt --quiet")

-- invoke our screenlocker on start
awful.spawn.with_shell(awful.util.getdir("config") .. "/lock.sh")

-- spawn daemons for virtualized envs
if virt then
  awful.spawn.with_shell("vmware-user")
end

-- awful.spawn("picom")
-- awful.spawn("remmina -i")
