require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    -- check_outdated_packages_on_open = false,
  },
})
require("mason-lspconfig").setup({
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })
  elseif client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", { noremap = true, silent = true })
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd(
      [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end
end

-- config that activates keymaps and enables snippet support
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

-- Enable the following language servers
local wanted_servers = require("plugins.lspinstall.wanted").setup(HOST)
for _, lsp in ipairs(wanted_servers) do
  local config = make_config(lsp)
  lspconfig[lsp].setup(config)
end

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

for type, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- lsp_lines handles virtual_text, disable if lsp_lines is active
  virtual_text = true,
  signs = true,
  underline = true,
  undercurl = true,
  update_in_insert = false,
})
