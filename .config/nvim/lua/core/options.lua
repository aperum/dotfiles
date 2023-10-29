-- Global
vim.opt.modeline = false
vim.opt.fillchars = { vert = "▍" }
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}
vim.cmd([[highlight VertSplit ctermfg=white ctermbg=black guifg=white guibg=black]])
vim.opt.showtabline = 2
vim.opt.scrolloff = 5
vim.opt.mouse = ""
vim.opt.backupcopy = "yes"
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.shortmess:append({ c = true, S = true })
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrapscan = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.errorbells = false
vim.opt.joinspaces = false
vim.opt.title = true
vim.opt.colorcolumn = "0"
vim.opt.lazyredraw = true
vim.o.breakindent = true
vim.opt.encoding = "UTF-8"
-- vim.opt.clipboard = "unnamedplus"
vim.opt.listchars = { tab = "⭾>", trail = "·", precedes = "←", extends = "→", eol = "↲", nbsp = "␣" }
vim.opt.updatetime = 250
-- Buffer
vim.opt.fileformat = "unix"
vim.opt.tabstop = 2
-- vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.inccommand = "nosplit"
-- Window
vim.opt.number = true
vim.opt.colorcolumn = "+1"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 1
vim.opt.list = false
vim.opt.foldnestmax = 10
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.foldenable = false
vim.opt.cursorline = true
vim.opt.laststatus = 3
-- Color
vim.opt.termguicolors = true
