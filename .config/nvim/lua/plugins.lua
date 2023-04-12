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

  -- Helpers
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.nvim-notify")
    end,
  },

  "folke/tokyonight.nvim",

  -- LSP
  {
    "stevearc/aerial.nvim",
    config = function()
      require("plugins.aerial")
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end,
  },
  {
    "onsails/lspkind-nvim",
    config = function()
      require("plugins.lspkind")
    end,
  },
  {
    "folke/lsp-trouble.nvim",
    config = function()
      require("plugins.trouble")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lspsignature")
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
    dependencies = "rafamadriz/friendly-snippets",
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
      "f3fora/cmp-spell",
      "saadparwaiz1/cmp_luasnip",
      "ray-x/cmp-treesitter",
    },
    config = function()
      require("plugins.nvim-cmp")
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.nvim-autopairs")
    end,
  },
  {
    "andymass/vim-matchup",
    config = function()
      require("plugins.matchup")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    config = function()
      require("plugins.nvim-ts-rainbow")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("plugins.tabout")
    end,
  },
  {
    "SmiteshP/nvim-gps",
    config = function()
      require("plugins.nvim-gps")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("plugins.nvim-treesitter-context")
    end,
  },

  -- Syntax
  "npxbr/glow.nvim",
  {
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter")
    end,
  },

  -- Golang
  {
    "ray-x/go.nvim",
    dependencies = "ray-x/guihua.lua",
    config = function()
      require("plugins.go")
    end,
  },

  -- Status Line and Bufferline
  -- {
  --   "feline-nvim/feline.nvim",
  --   config = function()
  --     require("plugins.feline")
  --   end,
  -- },
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
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    "axieax/urlview.nvim",
    config = function()
      require("plugins.urlview")
    end,
  },
  "nvim-telescope/telescope-project.nvim",
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("plugins.neoclip")
    end,
  },
  "someone-stole-my-name/yaml-companion.nvim",

  -- Explorer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
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
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  },

  -- Comment
  {
    "b3nj5m1n/kommentary",
    config = function()
      require("plugins.kommentary")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
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

  -- Misc
  {
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.dressing")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm")
    end,
  },
  {
    "winston0410/range-highlight.nvim",
    dependencies = {
      { "winston0410/cmd-parser.nvim", module = "cmd-parser" },
    },
    config = function()
      require("plugins.range-highlight")
    end,
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("plugins.numb")
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("plugins.neoscroll")
    end,
  },
  "simrat39/symbols-outline.nvim",
  {
    "mrjones2014/legendary.nvim",
    config = function()
      require("plugins.legendary")
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
    "kylechui/nvim-surround",
    config = function()
      require("plugins.nvim-surround")
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("plugins.eyeliner")
    end,
  },
  "gpanders/editorconfig.nvim",
}, {
  install = { colorscheme = { "tokyonight-night" } },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})
