require("auto-session").setup({
  log_level = "info",
  auto_session_suppress_dirs = { "~/", "~/Projects" },
  auto_session_enable_last_session = true,
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
