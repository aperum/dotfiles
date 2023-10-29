return {
  "echasnovski/mini.nvim",
  config = function()
    local align = require("mini.align")
    local animate = require("mini.animate")
    local comment = require("mini.comment")
    local cursorword = require("mini.cursorword")
    local hipatterns = require("mini.hipatterns")
    local indentscope = require("mini.indentscope")
    local sessions = require("mini.sessions")
    local starter = require("mini.starter")
    local surround = require("mini.surround")
    local splitjoin = require("mini.splitjoin")

    align.setup({})
    animate.setup({})
    comment.setup({
      mappings = {
        comment = "<leader>c",
        comment_line = "<leader>cc",
        textobject = "<leader>c",
      },
    })
    cursorword.setup({})
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
