return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local lspconfig = require("lspconfig")

    local wanted_servers = require("lsp.wanted").setup(HOST)
    local wanted_formatters = require("formatters.wanted").setup(HOST)

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = wanted_servers,
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
        "yamllint",
      },
    })

    -- Setup every needed language server in lspconfig
    local on_attach = function(client, bufnr)
    end

    local function make_config(server_name)
      local c = {}
      c.on_attach = on_attach
      c.capabilities = vim.lsp.protocol.make_client_capabilities()
      c.capabilities = require("cmp_nvim_lsp").default_capabilities()
      c.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }

      -- Merge user-defined lsp settings.
      local exists, module = pcall(require, "lsp." .. server_name)
      if exists then
        local user_config = module.config(c)
        for k, v in pairs(user_config) do
          c[k] = v
        end
      end

      return c
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        local c = make_config(server_name)
        lspconfig[server_name].setup(c)
      end,
    })

    -- Diagnostic sign setup
    local signs = {
      Error = "󰅚 ",
      Warn = " ",
      Hint = "󰌶 ",
      Info = " ",
    }

    for type, icon in pairs(signs) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type, numhl = "" })
    end
  end,
}
