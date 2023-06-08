local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local mason_null_ls = require("mason-null-ls")
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

local wanted_servers = require("lsp.wanted").setup(HOST)

mason.setup()
mason_lspconfig.setup({
  ensure_installed = wanted_servers,
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

--- Null-ls setup
local null_ls_sources = {
  formatting.prettier.with({
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html",
      "json", "jsonc", "markdown", "markdown.mdx", "graphql", "handlebars" },
  }),
  formatting.gofumpt,
  formatting.stylua,
}

null_ls.setup({})
mason_null_ls.setup({
  ensure_installed = { "prettier", "gofumpt", "stylua" },
  sources = null_ls_sources,
})

-- Diagnostic sign setup
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

for type, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type, numhl = "" })
end
