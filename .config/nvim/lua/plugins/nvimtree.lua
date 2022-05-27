vim.g.nvim_tree_width = 25
vim.g.nvim_tree_auto_ignore_ft = "startify"
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = { unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = "" },
  folder = { default = "", open = "", empty = "", empty_open = "", symlink = "" },
}

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_cursor = true,
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
})

vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeToggle<CR>", { noremap = false, silent = true })
