-- vim.cmd [[packadd packer.nvim]]
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute("packadd packer.nvim")
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require("packer").init({ display = { auto_clean = false } })

return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use("wbthomason/packer.nvim")

  -- Helpers
  use({
    "nvim-lua/plenary.nvim",
  })
  use({
    "kyazdani42/nvim-web-devicons",
  })
  use({
    "MunifTanjim/nui.nvim",
  })
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.nvim-notify")
    end,
  })

  -- LSP
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("plugins.aerial")
    end,
  })
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end,
  })
  use({
    "williamboman/nvim-lsp-installer",
    config = function()
      require("plugins.lspinstall")
    end,
  })
  use({
    "onsails/lspkind-nvim",
    config = function()
      require("plugins.lspkind")
    end,
  })
  use({
    "folke/lsp-trouble.nvim",
    config = function()
      require("plugins.trouble")
    end,
  })
  use({
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.lspsignature")
    end,
  })
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      require("plugins.lightbulb")
    end,
  })
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })
  -- use({
  --   "jose-elias-alvarez/null-ls.nvim",
  --   after = "plenary.nvim",
  --   config = function()
  --     require("plugins.null_ls")
  --   end,
  -- })

  -- Autocomplete
  use({
    "L3MON4D3/LuaSnip",
    requires = "rafamadriz/friendly-snippets",
    config = function()
      require("plugins.luasnip")
    end,
  })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
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
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.nvim-autopairs")
    end,
    after = "nvim-cmp",
  })
  use({
    "andymass/vim-matchup",
    config = function()
      require("plugins.matchup")
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    -- branch = "0.5-compat",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  })
  use({
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
    config = function()
      require("plugins.nvim-ts-rainbow")
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
    config = function()
      require("plugins.indent-blankline")
    end,
  })
  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  })
  use({
    "abecodes/tabout.nvim",
    config = function()
      require("plugins.tabout")
    end,
    after = { "nvim-cmp", "nvim-treesitter" },
  })
  use({
    "SmiteshP/nvim-gps",
    after = { "nvim-treesitter" },
    config = function()
      require("plugins.nvim-gps")
    end,
  })

  -- Syntax
  use({
    "npxbr/glow.nvim",
  })
  use({
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter")
    end,
  })

  -- Golang
  use({
    "ray-x/go.nvim",
    requires = "ray-x/guihua.lua",
    config = function()
      require("plugins.go")
    end,
  })

  -- DAP
  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.nvim-dap")
    end,
  })
  use({
    "rcarriga/nvim-dap-ui",
    after = { "nvim-dap" },
    config = function()
      require("plugins.nvim-dap-ui")
    end,
  })
  use({
    "theHamsta/nvim-dap-virtual-text",
    after = { "nvim-dap" },
    config = function()
      require("plugins.nvim-dap-virtual-text")
    end,
  })

  -- Status Line and Bufferline
  use({
    "famiu/feline.nvim",
    after = { "nvim-web-devicons", "nvim-gps", "nvim-treesitter" },
    config = function()
      require("plugins.feline")
    end,
  })
  -- use({
  --   "akinsho/bufferline.nvim",
  --   after = "nvim-web-devicons",
  --   config = function()
  --     require("plugins.bufferline")
  --   end,
  -- })
  use({
    "noib3/nvim-cokeline",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.nvim-cokeline")
    end,
  })
  -- use({
  --   "yamatsum/nvim-cursorline",
  --   config = function()
  --     require("plugins.cursorline")
  --   end,
  -- })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    after = "plenary.nvim",
    config = function()
      require("plugins.telescope")
    end,
  })
  use({
    "axieax/urlview.nvim",
    config = function()
      require("plugins.urlview")
    end,
  })
  use({
    "nvim-telescope/telescope-project.nvim",
  })
  use({
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("plugins.neoclip")
    end,
  })

  -- Explorer
  use({
    "kyazdani42/nvim-tree.lua",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.nvimtree")
    end,
  })
  -- use({
  --   "nvim-neo-tree/neo-tree.nvim",
  --   after = {
  --     "plenary.nvim",
  --     "nvim-web-devicons",
  --     "nui.nvim",
  --   },
  --   config = function()
  --     require("plugins.neo-tree")
  --   end,
  -- })
  use({
    "ibhagwan/fzf-lua",
    requires = {
      "vijaymarupudi/nvim-fzf",
    },
    after = { "nvim-web-devicons" },
    config = function()
      require("plugins.fzf-lua")
    end,
  })

  -- Color
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  })

  -- Comment
  use({
    "b3nj5m1n/kommentary",
    config = function()
      require("plugins.kommentary")
    end,
  })
  use({
    "folke/todo-comments.nvim",
    after = "plenary.nvim",
    config = function()
      require("plugins.todo-comments")
    end,
  })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    after = "plenary.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  })
  use({
    "sindrets/diffview.nvim",
    config = function()
      require("plugins.diffview")
    end,
  })
  use({
    "TimUntersberger/neogit",
    requires = {
      "sindrets/diffview.nvim",
    },
    after = { "plenary.nvim" },
    config = function()
      require("plugins.neogit")
    end,
  })

  -- Session
  use({
    "rmagatti/auto-session",
    config = function()
      require("plugins.auto-session")
    end,
  })
  use({
    "rmagatti/session-lens",
    after = { "telescope.nvim", "auto-session" },
    config = function()
      require("plugins.session-lens")
    end,
  })

  -- Colorschema
  -- use({
  --   "olimorris/onedarkpro.nvim",
  -- })
  use({
    "folke/tokyonight.nvim",
  })

  -- Misc
  use({
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.dressing")
    end,
  })
  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm")
    end,
  })
  use({
    "winston0410/range-highlight.nvim",
    requires = {
      { "winston0410/cmd-parser.nvim", module = "cmd-parser" },
    },
    config = function()
      require("plugins.range-highlight")
    end,
  })
  use({
    "nacro90/numb.nvim",
    config = function()
      require("plugins.numb")
    end,
  })
  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("plugins.neoscroll")
    end,
  })
  use({
    "simrat39/symbols-outline.nvim",
  })
  -- This requires neovim 0.7
  if vim.fn.has("nvim-0.7") == 1 then
    use({
      "mrjones2014/legendary.nvim",
      config = function()
        require("plugins.legendary")
      end,
    })
    use({
      "folke/which-key.nvim",
      after = "legendary.nvim",
      config = function()
        require("plugins.which-key")
      end,
    })
  else
    use({
      "folke/which-key.nvim",
      config = function()
        require("plugins.which-key")
      end,
    })
  end
  -- use({
  --   "beauwilliams/focus.nvim",
  --   config = function()
  --     require("plugins.focus")
  --   end,
  -- })
  use({
    "folke/twilight.nvim",
    config = function()
      require("plugins.twilight")
    end,
  })
  -- use({
  --   "bennypowers/nvim-regexplainer",
  --   after = "plenary.nvim",
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("plugins.regexplainer")
  --   end,
  -- })
end)
