local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
  local color_scheme = wezterm.home_dir .. "/repos/configs/tokyonight.nvim/extras/wezterm/tokyonight_night.toml"

  local theme, _ = wezterm.color.load_scheme(color_scheme)

  config.colors = theme

  config.colors.tab_bar.background = "#1f2335"
end

return M
