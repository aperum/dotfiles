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
    keys = {
      {
        "<leader><space>",
        function()
          require('telescope.builtin').buffers()
        end,
        desc = "Telescope buffers",
      },
      {
        "<leader>sf",
        function()
          require('telescope.builtin').find_files({
            previewer = false,
          })
        end,
        desc = "Telescope find files",
      },
      {
        "<leader>sb",
        function()
          require('telescope.builtin').current_buffer_fuzzy_find()
        end,
        desc = "Telescope buffer fuzzy find",
      },
      {
        "<leader>sh",
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = "Telescope help tags",
      },
      {
        "<leader>st",
        function()
          require('telescope.builtin').tags()
        end,
        desc = "Telescope tags",
      },
      {
        "<leader>sd",
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = "Telescope grep string",
      },
      {
        "<leader>sp",
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = "Telescope live grep",
      },
      {
        "<leader>so",
        function()
          require('telescope.builtin').tags({ only_current_buffer = true })
        end,
        desc = "Telescope current buffer",
      },
      {
        "<leader>s?",
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = "Telescope old files",
      },
    },
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
