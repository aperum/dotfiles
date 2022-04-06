local lsp_installer_servers = require("nvim-lsp-installer.servers")
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

local wanted_servers = {
  "ansiblels",
  "bashls",
  "clangd",
  "cssls",
  "diagnosticls",
  "dockerls",
  "efm",
  "gopls",
  "html",
  "jsonls",
  "sumneko_lua",
  "pylsp",
  "solargraph",
  "rust_analyzer",
  "terraformls",
  "vimls",
  "lemminx",
  "yamlls",
}

local function install_servers(servers)
  for _, server in pairs(servers) do
    local ok, s = lsp_installer_servers.get_server(server)
    if ok then
      if not s:is_installed() then
        s:install()
      end
    end
  end
end

install_servers(wanted_servers)
