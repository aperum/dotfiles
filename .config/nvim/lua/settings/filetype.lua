local api = vim.api

local ansible_group = api.nvim_create_augroup("ansible_files", { clear = true })
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/playbooks/*.yml", "*/roles/*.yml" },
	command = "set filetype=yaml.ansible",
	group = ansible_group,
})
