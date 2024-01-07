local map = vim.keymap.set
local opt_silent = { silent = true }

-- Leader
map("", "<Space>", "<Nop>", opt_silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Leader invokes system clipboards
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>y", '"+y')
map("n", "<leader>yy", '"+yy')

map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')

-- UI Shortcuts
map(
  "n",
  "<F3>",
  ":set number! relativenumber!<CR><Cmd>IndentBlanklineToggle<CR><Cmd>lua vim.diagnostic.disable()<CR>"
)
map("n", "<F4>", ":set list! list?<CR>")

-- LSP
map("n", "<leader>,", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opt_silent)
map("n", "<leader>;", ":lua vim.lsp.diagnostic.goto_next()<CR>", opt_silent)
map("n", "<leader>lA", ":lua vim.lsp.diagnostic.code_action()<CR>", opt_silent)
map("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", opt_silent)
map("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", opt_silent)
map("n", "<leader>ltd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt_silent)
map("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", opt_silent)
map("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", opt_silent)
map("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", opt_silent)
-- map("n", "<leader>lm", ":lua vim.lsp.buf.rename()<CR>", opt_silent)
map("n", "<leader>lm", ":IncRename ", opt_silent)
map("n", "<leader>lr", ":lua vim.lsp.buf.references()<CR>", opt_silent)
map("n", "<leader>ls", ":lua vim.lsp.buf.document_symbol()<CR>", opt_silent)
map("n", "<leader>lsh", ":lua vim.lsp.buf.signature_help()<CR>", opt_silent)
map("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opt_silent)
map("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opt_silent)
map(
  "n",
  "<leader>lwl",
  "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  opt_silent
)

map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opt_silent)
map("n", "<leader>lld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opt_silent)
map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opt_silent)
map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opt_silent)
map("n", "<space>lsl", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opt_silent)
map("n", "<leader>lcl", "<cmd>lua vim.lsp.codelens.run()<CR>", opt_silent)

-- LuaSnip
map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("i", "<C-E>", "<Plug>luasnip-next-choice", {})
map("s", "<C-E>", "<Plug>luasnip-next-choice", {})
--
-- Formatting
map("n", "<leader>f", [[<cmd>lua vim.lsp.buf.format()<CR>]], opt_silent)

-- NeoClip
map("n", "<leader>nc", [[<cmd>Telescope neoclip plus<CR>]], opt_silent)

-- Aerial
vim.api.nvim_buf_set_keymap(0, "n", "<leader>a", "<cmd>AerialToggle!<CR>", opt_silent)

-- Git mergetool/conflicts
map("n", "<leader>1", ":diffget LOCAL<CR>", { desc = "mergetool mapping" })
map("n", "<leader>2", ":diffget BASE<CR>", { desc = "mergetool mapping" })
map("n", "<leader>3", ":diffget REMOTE<CR>", { desc = "mergetool mapping" })

-- Sessions
map("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])
map("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]])
map("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])
