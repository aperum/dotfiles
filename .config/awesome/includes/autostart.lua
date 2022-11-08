-- invoke our screenlocker on start
awful.spawn.with_shell(awful.util.getdir("config") .. "/lock.sh")

-- spawn daemons for virtualized envs
if virt == "oracle" then
  awful.spawn.with_shell("VBoxClient-all")
elseif virt == "vmware" then
  awful.spawn.with_shell("vmware-user")
end

-- awful.spawn("picom")
-- awful.spawn("remmina -i")
