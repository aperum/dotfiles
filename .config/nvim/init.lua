-- Get our hostname
HOST = io.popen("uname -n", "r"):read("*l")

-- Disable buildins
require("settings.disable-buildins")
-- Packer
require("plugins")
-- Config
require("settings")

-- Make sure we are secure (after everything is done)
vim.opt.secure = true
