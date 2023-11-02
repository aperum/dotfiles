return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    opts = {},
  },

  {
    "tsakirist/telescope-lazy.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require('telescope').load_extension('lazy')
    end,
  },

  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require('telescope').load_extension('luasnip')
    end,
  },

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require('neoclip').setup()

      require('telescope').load_extension('neoclip')
    end,
  },

  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}
