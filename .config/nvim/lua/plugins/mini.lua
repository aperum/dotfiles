require("mini.align").setup({})
require("mini.animate").setup({})
require("mini.comment").setup({
  mappings = {
    comment = "<leader>c",
    comment_line = "<leader>cc",
    textobject = "<leader>c",
  },
})
require("mini.cursorword").setup({})
require("mini.hipatterns").setup({
  highlighters = {
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
})
require("mini.indentscope").setup({
  -- Draw options
  draw = {
    animation = require("mini.indentscope").gen_animation.none(),
  },

  options = {
    try_as_border = true,
  },
})
-- require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.splitjoin").setup({})
