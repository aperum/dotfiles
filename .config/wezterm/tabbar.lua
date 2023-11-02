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
  return tab_info.active_pane.title
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

function M.apply_to_config(config)
  config.hide_tab_bar_if_only_one_tab = false
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 20
  config.show_tab_index_in_tab_bar = false

  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local c = config.colors.tab_bar

    local sep1_background = c.inactive_tab.bg_color
    local sep1_foreground = c.background
    local sep2_background = c.background
    local sep2_foreground = c.inactive_tab.bg_color

    local background = c.inactive_tab.bg_color
    local foreground = c.inactive_tab.fg_color

    -- local is_first = tab.tab_id == tabs[1].tab_id
    -- local is_last = tab.tab_id == tabs[#tabs].tab_id

    if tab.is_active then
      background = c.active_tab.bg_color
      foreground = c.active_tab.fg_color
      sep1_background = c.active_tab.bg_color
      sep1_foreground = c.background
      sep2_background = c.background
      sep2_foreground = c.active_tab.bg_color
    elseif hover then
      background = c.inactive_tab_hover.bg_color
      foreground = c.inactive_tab_hover.fg_color
      -- sep1_background = c.inactive_tab_bar.bg_color
      -- sep1_foreground = c.background
      -- sep2_background = c.background
      -- sep2_foreground = c.inactive_tab_bar.bg_color
    end

    if not tab.is_active then
      if has_unseen_output(tab) then
        foreground = "#FFAA00"
      end
    end

    local tab_pos = indexOfTab(tabs, tab)
    local title = " " .. tab_pos .. ": " .. tab_title(tab)

    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = sep1_background } },
      { Foreground = { Color = sep1_foreground } },
      { Text = SOLID_RIGHT_CIRCLE },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = sep2_background } },
      { Foreground = { Color = sep2_foreground } },
      { Text = SOLID_RIGHT_CIRCLE },
    }
  end)
end

return M
