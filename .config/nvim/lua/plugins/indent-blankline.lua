vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 guibg=NONE gui=NONE blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B guibg=NONE gui=NONE blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 guibg=NONE gui=NONE blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 guibg=NONE gui=NONE blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF guibg=NONE gui=NONE blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD guibg=NONE gui=NONE blend=nocombine]]

require("indent_blankline").setup {
  show_current_context = true,
  buftype_exclude = {'terminal', 'nofile'},
  filetype_exclude = {'help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'NvimTree'},

  use_treesitter = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  disable_with_list = true,
  char_highlight = 'LineNr',
  char = '┊',
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}
