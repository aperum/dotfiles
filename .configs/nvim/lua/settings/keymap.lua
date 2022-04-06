-- leader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- leader invokes system clipboards
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<leader>P", '"+P', { noremap = true, silent = false })

vim.api.nvim_set_keymap(
  "n",
  "<F3>",
  ":set number! relativenumber!<CR>:IndentBlanklineToggle<CR>",
  { noremap = true, silent = false }
)
vim.api.nvim_set_keymap("n", "<F4>", ":set list! list?<CR>", { noremap = false, silent = false })
-- Git
vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = false, silent = false })
vim.api.nvim_set_keymap("n", "<leader>gg", ":Neogit<CR>", { noremap = false, silent = false })
-- LSP
vim.api.nvim_set_keymap("n", "<leader>,", ":lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>;", ":lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>la",
  ":lua vim.lsp.diagnostic.code_action()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>ltd",
  "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lm", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lr", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ls", ":lua vim.lsp.buf.document_symbol()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lsh", ":lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>lwa",
  "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lwr",
  "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lwl",
  "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>lca", "<cmd>CodeActionMenu<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>lld",
  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<space>lsl",
  "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lcl", "<cmd>lua vim.lsp.codelens.run()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>la", "<cmd>AerialToggle!<CR>", {})
vim.api.nvim_set_keymap("n", "{", "<cmd>AerialPrev<CR>", {})
vim.api.nvim_set_keymap("n", "}", "<cmd>AerialNext<CR>", {})
vim.api.nvim_set_keymap("n", "[[", "<cmd>AerialPrevUp<CR>", {})
vim.api.nvim_set_keymap("n", "]]", "<cmd>AerialNextUp<CR>", {})

-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>xw",
  "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>xd",
  "<cmd>Trouble lsp_document_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
-- Telescope
vim.api.nvim_set_keymap(
  "n",
  "<leader><space>",
  [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sf",
  [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sb",
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sh",
  [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>st",
  [[<cmd>lua require('telescope.builtin').tags()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sd",
  [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sp",
  [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>so",
  [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>?",
  [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
  { noremap = true, silent = true }
)
-- Bufferline
vim.api.nvim_set_keymap("n", "gb", ":BufferLinePick<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-1>", [[<cmd>BufferLineGoToBuffer 1<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", [[<cmd>BufferLineGoToBuffer 2<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", [[<cmd>BufferLineGoToBuffer 3<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-4>", [[<cmd>BufferLineGoToBuffer 4<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-5>", [[<cmd>BufferLineGoToBuffer 5<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-6>", [[<cmd>BufferLineGoToBuffer 6<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-7>", [[<cmd>BufferLineGoToBuffer 7<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-8>", [[<cmd>BufferLineGoToBuffer 8<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-9>", [[<cmd>BufferLineGoToBuffer 9<CR>]], { noremap = true, silent = true })
-- Kommentary
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default<C-c>", {})
-- LuaSnip
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
-- Formatter
vim.api.nvim_set_keymap("n", "<leader>f", [[<cmd>Format<CR>]], { noremap = true, silent = true })
-- NeoClip
vim.api.nvim_set_keymap("n", "<leader>nc", [[<cmd>Telescope neoclip plus<CR>]], { noremap = true, silent = true })
-- Aerial
vim.api.nvim_buf_set_keymap(0, "n", "<leader>a", "<cmd>AerialToggle!<CR>", { noremap = true, silent = true })
