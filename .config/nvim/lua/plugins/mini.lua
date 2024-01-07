local win_config = function()
	height = math.floor(0.618 * vim.o.lines)
	width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

return {
	"echasnovski/mini.nvim",
	config = function()
		local align = require("mini.align")
		local animate = require("mini.animate")
		local comment = require("mini.comment")
		local cursorword = require("mini.cursorword")
		local extra = require("mini.extra")
		local hipatterns = require("mini.hipatterns")
		local indentscope = require("mini.indentscope")
		local pairs = require("mini.pairs")
		local pick = require("mini.pick")
		local sessions = require("mini.sessions")
		-- local starter = require("mini.starter")
		local surround = require("mini.surround")
		local splitjoin = require("mini.splitjoin")

		align.setup({})
		animate.setup({})
		comment.setup({
			mappings = {
				comment = "<leader>c",
				comment_line = "<leader>cc",
				comment_visual = "<leader>c",
				textobject = "<leader>c",
			},
		})
		cursorword.setup({})
		extra.setup({})
		hipatterns.setup({
			highlighters = {
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
		indentscope.setup({
			-- Draw options
			draw = {
				animation = indentscope.gen_animation.none(),
			},

			options = {
				try_as_border = true,
			},
		})
		pairs.setup({})

		-- pick.setup({
		-- 	window = {
		-- 		config = win_config,
		-- 	},
		--
		-- 	mappings = {
		-- 		scroll_down = "<PageDown>",
		-- 		scroll_up = "<PageUp>",
		-- 	},
		-- })
		-- -- Override ui select
		-- vim.ui.select = pick.ui_select

		sessions.setup({})
		-- starter.setup({
		--   items = {
		--     starter.sections.builtin_actions(),
		--     starter.sections.recent_files(10, false, true),
		--     starter.sections.sessions(),
		--   },
		-- })
		surround.setup({})
		splitjoin.setup({})
	end,
}
