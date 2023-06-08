-- Get our hostname
HOST = io.popen("uname -n", "r"):read("*l")

-- Disable buildins
require("settings.disable-buildins")
-- Config
require("settings")
-- Packer
require("plugins")

-- vim.cmd("colorscheme tokyonight-night")
vim.cmd([[hi TabLineFill guibg=NONE ctermbg=NONE]])

vim.opt.secure = true
