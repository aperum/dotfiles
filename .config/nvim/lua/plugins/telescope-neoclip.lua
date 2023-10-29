return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require('neoclip').setup()

    require('telescope').load_extension('neoclip')
  end,
}
