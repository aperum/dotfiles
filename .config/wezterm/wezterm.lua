local wezterm = require("wezterm")

local keys = require("keys")
local font = require("font")
local colors = require("colors")
local tabbar = require("tabbar")
-- local sshdomains = require("sshdomains")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

keys.apply_to_config(config)
font.apply_to_config(config)
colors.apply_to_config(config)
tabbar.apply_to_config(config)
-- sshdomains.apply_to_config(config)

config.check_for_updates = false
config.term = "wezterm"
config.scrollback_lines = 999999
config.hyperlink_rules = {}
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false
config.selection_word_boundary = " \t\n{}[]()\"'`"
config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.4cell',
  bottom = '0',
}

return config
