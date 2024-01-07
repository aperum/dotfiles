return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
  },
  keys = {
    { "<leader>la", "<cmd>AerialToggle!<CR>", desc = "AerialToggle" },
    { "{", "<cmd>AerialPrev<CR>", desc = "Aerial jump backwards" },
    { "}", "<cmd>AerialNext<CR>", desc = "Aerial jump forward" },
  },
}
