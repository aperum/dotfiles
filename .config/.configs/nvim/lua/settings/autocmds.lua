vim.cmd([[autocmd BufReadPost * lua Goto_last_pos()]])
function Goto_last_pos()
  local last_pos = vim.fn.line("'\"")
  if last_pos > 0 and last_pos <= vim.fn.line("$") then
    vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
  end
end

vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")

vim.cmd([[ autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500) ]], false)
