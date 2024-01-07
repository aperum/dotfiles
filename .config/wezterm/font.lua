local wezterm = require("wezterm")

local M = {}

local function font_with_fallback(name, params)
	local names = { name, "FiraCode Nerd Font Mono", "Blobmoji" }
	return wezterm.font_with_fallback(names, params)
end

function M.apply_to_config(config)
	local term_font = "Hack Nerd Font Mono"

	config.font_size = 12
	config.font_shaper = "Harfbuzz"
	config.line_height = 1.0
	config.font = font_with_fallback(term_font)
	config.font_rules = {
		{
			italic = true,
			font = font_with_fallback(term_font, { italic = true }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(term_font, { bold = true, italic = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(term_font, { bold = true }),
		},
	}
end

return M
