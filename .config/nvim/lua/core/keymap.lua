local map = vim.keymap.set

-- Leader
map("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Leader invokes system clipboards
map("v", "<leader>y", '"+y', { noremap = true, silent = false })
map("n", "<leader>Y", '"+yg_', { noremap = true, silent = false })
map("n", "<leader>y", '"+y', { noremap = true, silent = false })
map("n", "<leader>yy", '"+yy', { noremap = true, silent = false })

map("n", "<leader>p", '"+p', { noremap = true, silent = false })
map("n", "<leader>P", '"+P', { noremap = true, silent = false })
map("v", "<leader>p", '"+p', { noremap = true, silent = false })
map("v", "<leader>P", '"+P', { noremap = true, silent = false })

-- UI Shortcuts
map(
  "n",
  "<F3>",
  ":set number! relativenumber!<CR><Cmd>IndentBlanklineToggle<CR><Cmd>lua vim.diagnostic.disable()<CR>",
  { noremap = true, silent = false }
)
map("n", "<F4>", ":set list! list?<CR>", { noremap = false, silent = false })

-- LSP
map("n", "<leader>,", ":lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
map("n", "<leader>;", ":lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
map("n", "<leader>lA", ":lua vim.lsp.diagnostic.code_action()<CR>", { noremap = true, silent = true })
map("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
map("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
map("n", "<leader>ltd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })
map("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })
map("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
map("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
map("n", "<leader>lm", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
map("n", "<leader>lr", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
map("n", "<leader>ls", ":lua vim.lsp.buf.document_symbol()<CR>", { noremap = true, silent = true })
map("n", "<leader>lsh", ":lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
map("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { noremap = true, silent = true })
map("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { noremap = true, silent = true })
map(
  "n",
  "<leader>lwl",
  "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  { noremap = true, silent = true }
)

map("n", "<leader>lca", "<cmd>CodeActionMenu<CR>", { noremap = true, silent = true })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
map("n", "<leader>lld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { noremap = true, silent = true })
map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
map("n", "<space>lsl", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { noremap = true, silent = true })
map("n", "<leader>lcl", "<cmd>lua vim.lsp.codelens.run()<CR>", { noremap = true, silent = true })
map("n", "<leader>la", "<cmd>AerialToggle!<CR>", {})
map("n", "{", "<cmd>AerialPrev<CR>", {})
map("n", "}", "<cmd>AerialNext<CR>", {})
map("n", "[[", "<cmd>AerialPrevUp<CR>", {})
map("n", "]]", "<cmd>AerialNextUp<CR>", {})

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

-- Telescope
map("n", "<leader><space>", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
map(
  "n",
  "<leader>sf",
  [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
  { noremap = true, silent = true }
)
map(
  "n",
  "<leader>sb",
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)
map("n", "<leader>sh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
map("n", "<leader>st", [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
map("n", "<leader>sd", [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
map("n", "<leader>sp", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
map(
  "n",
  "<leader>so",
  [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
  { noremap = true, silent = true }
)
map("n", "<leader>?", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Cokeline
for i = 1, 9 do
  map("n", ("<A-%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
end

-- LuaSnip
map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("i", "<C-E>", "<Plug>luasnip-next-choice", {})
map("s", "<C-E>", "<Plug>luasnip-next-choice", {})
--
-- Formatting
map("n", "<leader>f", [[<cmd>lua vim.lsp.buf.format()<CR>]], { noremap = true, silent = true })

-- NeoClip
map("n", "<leader>nc", [[<cmd>Telescope neoclip plus<CR>]], { noremap = true, silent = true })

-- Aerial
vim.api.nvim_buf_set_keymap(0, "n", "<leader>a", "<cmd>AerialToggle!<CR>", { noremap = true, silent = true })

-- Git mergetool/conflicts
map("n", "<leader>1", ":diffget LOCAL<CR>", { desc = "mergetool mapping" })
map("n", "<leader>2", ":diffget BASE<CR>", { desc = "mergetool mapping" })
map("n", "<leader>3", ":diffget REMOTE<CR>", { desc = "mergetool mapping" })
