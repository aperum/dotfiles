return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "richardbizik/nvim-toc",
    opts = {},
  },
  -- {
  --   "preservim/vim-markdown",
  --   dependencies = {
  --     "godlygeek/tabular",
  --   },
  -- }
}
