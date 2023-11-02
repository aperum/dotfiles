return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "cmake",
          "comment",
          "cpp",
          "css",
          "dockerfile",
          "go",
          "gomod",
          "gowork",
          "html",
          "java",
          "javascript",
          "json",
          "json5",
          "jsonc",
          "lua",
          "make",
          "markdown",
          "ninja",
          "php",
          "regex",
          "ruby",
          "rust",
          "toml",
          "typescript",
          "vim",
          "yaml",
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
          disable = { "yaml" },
        },

        context_commentstring = {
          enable = true,
        },

        autopairs = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },

        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = true },
        },
      })
    end,
  },


  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
  },
}
