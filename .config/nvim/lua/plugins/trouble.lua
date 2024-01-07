return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    mode = "document_diagnostics",
  },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" },
    { "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", desc = "Trouble workspace diag" },
    { "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", desc = "Trouble doc diag" },
    { "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "Trouble loclist" },
    { "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "Trouble quickfix" },
    { "gR",         "<cmd>Trouble lsp_references<cr>", desc = "Trouble LSP ref" },
  },
}
