require("nvim-navic").setup({
  lsp = {
    auto_attach = true,
    preference = nil,
  },
  highlight = false,
  separator = " > ",
  depth_limit = 2,
  depth_limit_indicator = "..",
  -- safe_output = true
})
