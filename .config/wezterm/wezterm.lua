local wezterm = require("wezterm")

function font_with_fallback(name, params)
  local names = { name, "FiraCode Nerd Font Mono", "Blobmoji" }
  return wezterm.font_with_fallback(names, params)
end

return {
  check_for_updates = false,

  term = "wezterm",

  scrollback_lines = 9999,
  hide_tab_bar_if_only_one_tab = true,

  window_close_confirmation = "NeverPrompt",
  adjust_window_size_when_changing_font_size = false,

  warn_about_missing_glyphs = false,

  -- Font Stuff
  font = font_with_fallback("Hack Nerd Font Mono"),
  font_rules = {
    {
      italic = true,
      font = font_with_fallback("Hack Nerd Font Mono", { italic = true }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("Hack Nerd Font Mono", { bold = true, italic = true }),
    },
    {
      intensity = "Bold",
      font = font_with_fallback("Hack Nerd Font Mono", { bold = true }),
    },
  },
  font_size = 12,
  font_shaper = "Harfbuzz",
  line_height = 1.0,

  colors = {
    foreground = "#c0caf5",
    background = "#1a1b26",
    cursor_bg = "#c0caf5",
    cursor_border = "#c0caf5",
    cursor_fg = "#1a1b26",
    selection_bg = "#33467C",
    selection_fg = "#c0caf5",

    -- The color of the split lines between panes
    split = "#444444",

    ansi = { "#15161E", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
    brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
  },
}
