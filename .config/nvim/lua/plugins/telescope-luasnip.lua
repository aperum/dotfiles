return {
  "benfowler/telescope-luasnip.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require('telescope').load_extension('luasnip')
  end,
}
