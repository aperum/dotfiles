return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      -- javascript = { "prettier" },
      -- typescript = { "prettier" },
      -- javascriptreact = { "prettier" },
      -- typescriptreact = { "prettier" },
      -- svelte = { "prettier" },
      -- css = { "prettier" },
      -- html = { "prettier" },
      -- json = { "prettier" },
      -- yaml = { "prettier" },
      -- markdown = { "prettier" },
      -- graphql = { "prettier" },
      lua = { "stylua" },
      sh = { "shfmt" },
    },
    --format_on_save = {
    --  lsp_fallback = true,
    --  async = false,
    --  timeout_ms = 1000,
    --},
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
