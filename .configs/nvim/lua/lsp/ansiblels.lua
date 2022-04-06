-- ansiblels
--

local settings = {
  ansible = {
    ansible = {
      path = "ansible",
    },
    ansibleLint = {
      enabled = true,
      path = "ansible-lint",
    },
    python = {
      interpreterPath = "python",
    },
  },
}

local function config(server_config)
  server_config.settings = settings
  server_config.filetypes = { "yaml.ansible" }

  return server_config
end

return {
  config = config,
}
