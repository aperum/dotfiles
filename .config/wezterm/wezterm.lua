local wezterm = require("wezterm")
local mux = wezterm.mux

local keys = require("keys")
local font = require("font")
local colors = require("colors")
local tabbar = require("tabbar")
local domains = require("domains")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

keys.apply_to_config(config)
font.apply_to_config(config)
colors.apply_to_config(config)
tabbar.apply_to_config(config)
-- domains.apply_to_config(config)

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

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  local ansible_tab, ansible_first_pane, ansible_window = mux.spawn_window {
    workspace = 'ansible',
    cwd = wezterm.home_dir .. "/repos/hetzner-ansible",
    args = { 'zsh' },
  }
  local _, ansible_second_pane, _ = ansible_window:spawn_tab {
    cwd = wezterm.home_dir .. "/repos/hetzner-ansible/roles",
  }

  local shells_tab, shells_first_pane, shells_window = mux.spawn_window {
    workspace = 'shells',
    args = { 'zsh' },
  }

  local nvim_tab, nvim_first_pane, nvim_window = mux.spawn_window {
    workspace = 'nvim',
    cwd = wezterm.home_dir .. "/repos/qldap",
    args = { 'zsh' },
  }
  local _, nvim_second_pane, _ = nvim_window:spawn_tab {
    cwd = wezterm.home_dir .. "/.config/nvim",
  }

  local root_tab, root_first_pane, root_window = mux.spawn_window {
    workspace = 'root',
    args = { 'zsh' },
  }

  -- We want to startup in the coding workspace
  mux.set_active_workspace 'shells'
end)

-- wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
--   local zoomed = ''
--   if tab.active_pane.is_zoomed then
--     zoomed = '[Z] '
--   end
--
--   local index = ''
--   if #tabs > 1 then
--     index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
--   end
--
--   print("zoomed: " .. zoomed)
--   print("index: " .. index)
--   print("title: " .. tab.active_pane.title)
--   print("combine: " .. zoomed .. index .. tab.active_pane.title)
--
--   return zoomed .. index .. tab.active_pane.title
-- end)

return config
