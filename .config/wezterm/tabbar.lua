local wezterm = require("wezterm")

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local SOLID_LEFT_CIRCLE = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_CIRCLE = wezterm.nerdfonts.ple_right_half_circle_thick

local M = {}

local function indexOfTab(array, value)
  for i, v in ipairs(array) do
    if v.tab_id == value.tab_id then
      return i
    end
  end
  return nil
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  -- If it is a ssh session remove user part
  title = tab_info.active_pane.title
  title = title:gsub("^[^@]+@", "")
  print(title)

  return title
end

local function has_unseen_output(tab)
  local has_unseen = false

  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      has_unseen = true
      break;
    end
  end

  return has_unseen
end

local function merge_colors(t1, t2)
  local colors = t1

  for k, v in pairs(t2) do colors[k] = v end

  return colors
end

local function tab_color(config)
  local c = config.colors.tab_bar

  local tabcol = {
    inactive = {
      sep1_background = c.inactive_tab.bg_color,
      sep1_foreground = c.background,
      sep2_background = c.background,
      sep2_foreground = c.inactive_tab.bg_color,

      background = c.inactive_tab.bg_color,
      foreground = c.inactive_tab.fg_color,

      bar = {
        background = c.background,
      },
    },
    active = {
      background = c.active_tab.bg_color,
      foreground = c.active_tab.fg_color,
      sep1_background = c.active_tab.bg_color,
      sep1_foreground = c.background,
      sep2_background = c.background,
      sep2_foreground = c.active_tab.bg_color,

      bar = {
        background = c.background,
      },
    },
    hover = {
      background = c.inactive_tab_hover.bg_color,
      foreground = c.inactive_tab_hover.fg_color,
    },
    status = {
      left = {
        sep1_background = c.active_tab.bg_color,
        sep1_foreground = c.background,
        sep2_background = c.active_tab.bg_color,
        sep2_foreground = c.background,
      },
      right = {
        sep1_background = c.background,
        sep1_foreground = c.active_tab.bg_color,
        sep2_background = c.active_tab.bg_color,
        sep2_foreground = c.background,
      },
    },
  }
  return tabcol
end

function M.apply_to_config(config)
  config.hide_tab_bar_if_only_one_tab = false
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 20
  config.show_tab_index_in_tab_bar = false

  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local tabcols = tab_color(config)
    local tab_pos = indexOfTab(tabs, tab)
    local title = " " .. tab_pos .. ": " .. tab_title(tab)

    title = wezterm.truncate_right(title, max_width - 2)

    local tabcol = merge_colors(tabcols.inactive, {})

    if tab.is_active then
      tabcol = merge_colors(tabcols.inactive, tabcols.active)
    elseif hover then
      tabcol = merge_colors(tabcols.inactive, tabcols.hover)
    end

    if not tab.is_active then
      if has_unseen_output(tab) then
        tabcol.foreground = "#FFAA00"
      end
    end

    return {
      { Background = { Color = tabcol.sep1_background } },
      { Foreground = { Color = tabcol.sep1_foreground } },
      { Text = SOLID_RIGHT_CIRCLE },
      { Background = { Color = tabcol.background } },
      { Foreground = { Color = tabcol.foreground } },
      { Text = title },
      { Background = { Color = tabcol.sep2_background } },
      { Foreground = { Color = tabcol.sep2_foreground } },
      { Text = SOLID_RIGHT_CIRCLE },
    }
  end)

  -- Show which key t able is active in the status area
  wezterm.on('update-status', function(window, pane)
    local tabcols = tab_color(config)

    local name = window:active_key_table()
    if name then
      name = ' ' .. name .. ' '
    else
      name = ' default '
    end

    local tabcol = merge_colors(tabcols.active, tabcols.status.left)

    local left_status = {
      { Background = { Color = tabcol.background } },
      { Foreground = { Color = tabcol.foreground } },
      { Text = " " .. window:active_workspace() },
      { Background = { Color = tabcol.sep2_foreground } },
      { Foreground = { Color = tabcol.sep2_background } },
      { Text = SOLID_RIGHT_CIRCLE },
    }
    window:set_left_status(wezterm.format(left_status))

    tabcol = merge_colors(tabcols.active, tabcols.status.right)

    local right_status = {
      { Background = { Color = tabcol.sep1_background } },
      { Foreground = { Color = tabcol.sep1_foreground } },
      { Text = SOLID_LEFT_CIRCLE },
      { Background = { Color = tabcol.background } },
      { Foreground = { Color = tabcol.foreground } },
      { Text = name },
      -- { Background = { Color = tabcol.sep2_background } },
      -- { Foreground = { Color = tabcol.sep2_foreground } },
      -- { Text = SOLID_LEFT_CIRCLE },
    }
    window:set_right_status(wezterm.format(right_status))
  end)
end

return M
