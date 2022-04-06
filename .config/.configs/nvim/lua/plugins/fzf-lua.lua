vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true, noremap = true })
