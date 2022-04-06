require("formatter").setup({
  logging = false,
  filetype = {
    sh = {
      function()
        return {
          exe = "shfmt",
          args = {},
          stdin = true,
        }
      end,
    },
    css = {
      function()
        return {
          exe = "prettier",
          args = { "--parser", "css" },
          stdin = true,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces", "-" },
          stdin = true,
        }
      end,
    },
  },
})

vim.cmd(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.css,*.lua,*.sh FormatWrite
augroup END
]],
  true
)
