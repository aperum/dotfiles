local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({

  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.tokyonight")
    end,
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   config = function()
  --     require("plugins.nvim-notify")
  --   end,
  -- },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require "plugins.mason"
    end
  },

  {
    "ojroques/nvim-osc52",
    config = function()
      require("plugins.nvim-ocs52")
    end,
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.aerial")
    end,
  },
  {
    "onsails/lspkind-nvim",
    lazy = true,
    config = function()
      require("plugins.lspkind")
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.trouble")
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("plugins.lightbulb")
    end,
  },
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },

  -- Autocomplete
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.luasnip")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "f3fora/cmp-spell",
      "saadparwaiz1/cmp_luasnip",
      "ray-x/cmp-treesitter",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.nvim-cmp")
    end,
  },
  {
    "andymass/vim-matchup",
    config = function()
      require("plugins.matchup")
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.nvim-autopairs")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end,
  },
  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  -- },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("plugins.tabout")
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("plugins.nvim-navic")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("plugins.nvim-treesitter-context")
    end,
  },

  -- Golang
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugins.go")
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Status Line and Bufferline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "noib3/nvim-cokeline",
    config = function()
      require("plugins.nvim-cokeline")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
  },
  {
    "benfowler/telescope-luasnip.nvim",
    config = function()
      require('telescope').load_extension('luasnip')
    end,
  },
  {
    "tsakirist/telescope-lazy.nvim",
    config = function()
      require('telescope').load_extension('lazy')
    end,
  },
  {
    "axieax/urlview.nvim",
    config = function()
      require("plugins.urlview")
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("plugins.neoclip")
    end,
  },

  -- Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.neo-tree")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "vijaymarupudi/nvim-fzf",
    },
    config = function()
      require("plugins.fzf-lua")
    end,
  },

  -- Color
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   config = function()
  --     require("plugins.colorizer")
  --   end,
  -- },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("plugins.diffview")
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    config = function()
      require("plugins.neogit")
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("plugins.git-conflict")
    end,
  },

  -- Mini
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("plugins.mini")
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("plugins.twilight")
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("plugins.eyeliner")
    end,
  },

  -- YAML
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },

}, {
  -- install = { colorscheme = { "tokyonight-night" } },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})
