-- EFM settings

local settings = {
  efm = {},
}

local function config(server_config)
  server_config.settings = settings
  server_config.filetypes = {}

  return server_config
end

return {
  config = config,
}
