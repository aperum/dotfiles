local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
  config.keys = {
    {
      key = "|",
      mods = "LEADER",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "c",
      mods = "LEADER",
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = ",",
      mods = "LEADER",
      action = wezterm.action.PromptInputLine({
        description = "Enter new name for tab",
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }),
    },
    {
      key = "f",
      mods = "CTRL|SUPER",
      action = wezterm.action.Search { CaseSensitiveString = '' },
    },
    {
      key = "n",
      mods = "LEADER",
      action = wezterm.action.ActivateTabRelative(1)
    },
    {
      key = "p",
      mods = "LEADER",
      action = wezterm.action.ActivateTabRelative(-1)
    },
    {
      key = "LeftArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = "RightArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
      key = "UpArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = "DownArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = "End",
      mods = "SHIFT",
      action = wezterm.action.ScrollToBottom,
    },

    {
      key = 's',
      mods = 'LEADER',
      action = wezterm.action.ShowLauncherArgs {
        flags = 'FUZZY|WORKSPACES',
      },
    },

    {
      key = "c",
      mods = "CTRL|SUPER",
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
  }

  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = "LEADER",
      action = wezterm.action.ActivateTab(i - 1),
    })
  end
end

return M
