local M = {}

-- Exclude the listed hosts from installing this LSP
-- We do not want nodejs, etc. on our servers
-- And some LSPs do not have aarch64 versions
local wanted_matrix = {
  ansiblels = { "hastur", "azathoth", "guardian" },
  bashls = { "hastur", "azathoth", "guardian" },
  clangd = { "raspberrypi", "hastur", "azathoth", "guardian" },
  cssls = { "hastur", "azathoth", "guardian" },
  diagnosticls = { "hastur", "azathoth", "guardian" },
  dockerls = { "hastur", "azathoth", "guardian" },
  efm = { "hastur", "azathoth", "guardian" },
  gopls = { "hastur", "azathoth", "guardian" },
  html = { "hastur", "azathoth", "guardian" },
  jsonls = { "hastur", "azathoth", "guardian" },
  lemminx = { "hastur", "azathoth", "guardian" },
  marksman = { "hastur", "azathoth", "guardian" },
  sumneko_lua = { "hastur", "azathoth", "guardian" },
  pylsp = { "hastur", "azathoth", "guardian" },
  solargraph = { "hastur", "azathoth", "guardian" },
  rust_analyzer = { "hastur", "azathoth", "guardian" },
  terraformls = { "hastur", "azathoth", "guardian" },
  vimls = { "hastur", "azathoth", "guardian" },
  yamlls = { "hastur", "azathoth", "guardian" },
}

function M.setup(tag)
  local wanted_list = {}

  for lsp, tags in pairs(wanted_matrix) do
    local exclude = false
    for _, v in pairs(tags) do
      if v == tag then
        exclude = true
        break
      end
    end
    if not exclude then
      table.insert(wanted_list, lsp)
    end
  end

  return wanted_list
end

return M
