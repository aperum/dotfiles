local M = {}

local wanted_matrix = {
  stylua = {},
  prettier = { "hastur", "azathoth", "guardian" },
  gofumpt = { "raspberrypi" },
  shfmt = {},
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
