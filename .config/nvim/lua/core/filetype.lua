local api = vim.api

local ansible_group = api.nvim_create_augroup("ansible_files", { clear = true })
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/playbooks/*.yml", "*/roles/*.yml" },
	command = "set filetype=yaml.ansible",
	group = ansible_group,
})

local docker_compose_group = api.nvim_create_augroup("docker_compose_files", { clear = true })
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/docker-compose.yml", "*/docker-compose.yaml" },
	command = "set filetype=yaml.docker-compose",
	group = docker_compose_group,
})
