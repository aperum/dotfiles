return {
  "tsakirist/telescope-lazy.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require('telescope').load_extension('lazy')
  end,
}
