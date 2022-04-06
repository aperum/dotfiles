require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "single",
  },
  extra_trigger_chars = { "," },
})
