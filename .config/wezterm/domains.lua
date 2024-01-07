local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
  config.unix_domains = {
    {
      name = "shells",
    },
    {
      name = "nvim",
    },
    {
      name = "ansible",
    },
    {
      name = "root",
    }
  }
end

return M
