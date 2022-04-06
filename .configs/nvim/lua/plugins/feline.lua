local colors = require("tokyonight.colors").setup({})
local lsp = require("feline.providers.lsp")

local icon_styles = {
  default = {
    left = "",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
  arrow = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  block = {
    left = " ",
    right = " ",
    main_icon = "   ",
    vi_mode_icon = "  ",
    position_icon = "  ",
  },

  round = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  slant = {
    left = " ",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

local statusline_style = icon_styles["default"]

-- Initialize the components table
local components = {
  active = {},
  inactive = {},
}

-- Initialize left, mid and right
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

components.active[1][1] = {
  provider = statusline_style.main_icon,

  hl = {
    fg = colors.bg_dark,
    bg = colors.blue,
  },

  right_sep = { str = statusline_style.right, hl = {
    fg = colors.blue,
    bg = colors.blue0,
  } },
}

components.active[1][2] = {
  provider = function()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon == nil then
      icon = "  "
      return icon
    end
    return icon .. " " .. filename .. " "
  end,
  hl = {
    fg = colors.white,
    bg = colors.blue0,
  },

  right_sep = {
    str = statusline_style.right,
    hl = {
      fg = colors.blue0,
      bg = colors.comment,
    },
  },
}

components.active[1][3] = {
  provider = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. dir_name .. " "
  end,

  hl = {
    fg = colors.dark3_fg2,
    bg = colors.comment,
  },
  right_sep = {
    str = statusline_style.right,
    hl = {
      fg = colors.comment,
      bg = colors.fg_gutter,
    },
  },
}

components.active[1][4] = {
  provider = function()
    local gps = ""
    if require("nvim-gps").is_available() then
      gps = require("nvim-gps").get_location()
      if gps == "" then
        gps = ""
      end
    else
      gps = ""
    end
    return gps .. " "
  end,
  -- enabled = function()
  --   return require("nvim-gps").is_available()
  -- end,

  hl = {
    fg = colors.green,
    bg = colors.fg_gutter,
  },
  right_sep = {
    str = statusline_style.right,
    hl = {
      fg = colors.fg_gutter,
      bg = colors.bg_dark,
    },
  },
}

components.active[1][5] = {
  provider = "git_diff_added",
  hl = {
    fg = colors.dark3_fg2,
    bg = colors.bg_dark,
  },
  icon = " ",
}
-- diffModfified
components.active[1][6] = {
  provider = "git_diff_changed",
  hl = {
    fg = colors.dark3_fg2,
    bg = colors.bg_dark,
  },
  icon = "   ",
}
-- diffRemove
components.active[1][7] = {
  provider = "git_diff_removed",
  hl = {
    fg = colors.dark3_fg2,
    bg = colors.bg_dark,
  },
  icon = "  ",
}

components.active[1][8] = {
  provider = "diagnostic_errors",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
  end,
  hl = {
    fg = colors.red,
    bg = colors.bg_dark,
  },
  icon = "  ",
}

components.active[1][9] = {
  provider = "diagnostic_warnings",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
  end,
  hl = { fg = colors.yellow },
  icon = "  ",
}

components.active[1][10] = {
  provider = "diagnostic_hints",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
  end,
  hl = {
    fg = colors.dark3_fg2,
    bg = colors.bg_dark,
  },
  icon = "  ",
}

components.active[1][11] = {
  provider = "diagnostic_info",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
  end,
  hl = {
    fg = colors.green,
    bg = colors.bg_dark,
  },
  icon = "  ",
}

components.active[2][1] = {
  provider = function()
    local Lsp = vim.lsp.util.get_progress_messages()[1]
    if Lsp then
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = {
        "",
        "",
        "",
      }

      local success_icon = {
        "",
        "",
        "",
      }

      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      else
        return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end
    end
    return ""
  end,
  hl = {
    fg = colors.green,
    bg = colors.bg_dark,
  },
}

components.active[3][1] = {
  provider = { name = "file_type" },
  icon = "  ",
  hl = {
    bg = colors.bg_dark,
  },
}

components.active[3][2] = {
  provider = function()
    if next(vim.lsp.buf_get_clients()) ~= nil then
      return "  LSP"
    else
      return ""
    end
  end,
  hl = { fg = colors.dark3_fg2, bg = colors.bg_dark },
}

components.active[3][3] = {
  provider = "git_branch",
  hl = {
    fg = colors.dark3_fg2,
    bg = colors.bg_dark,
  },
  icon = "  ",
}

components.active[3][4] = {
  provider = " " .. statusline_style.left,
  hl = {
    fg = colors.bg_highlight,
    bg = colors.bg_dark,
  },
}

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.purple },
  ["ic"] = { "INSERT", colors.purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.blue },
  ["S"] = { "S-LINE", colors.blue },
  [""] = { "S-BLOCK", colors.blue },
  ["c"] = { "COMMAND", colors.magenta },
  ["cv"] = { "COMMAND", colors.magenta },
  ["ce"] = { "COMMAND", colors.magenta },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
  return {
    fg = mode_colors[vim.fn.mode()][2],
    bg = colors.bg_dark,
  }
end

components.active[3][5] = {
  provider = statusline_style.left,
  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.bg_highlight,
    }
  end,
}

components.active[3][6] = {
  provider = statusline_style.vi_mode_icon,
  hl = function()
    return {
      fg = colors.bg_dark,
      bg = mode_colors[vim.fn.mode()][2],
    }
  end,
}

components.active[3][7] = {
  provider = function()
    return " " .. mode_colors[vim.fn.mode()][1] .. " "
  end,
  hl = chad_mode_hl,
}

components.active[3][8] = {
  provider = statusline_style.left,
  hl = {
    fg = colors.bg_highlight,
    bg = colors.bg_dark,
  },
}

components.active[3][9] = {
  provider = statusline_style.left,
  hl = {
    fg = colors.green,
    bg = colors.bg_dark,
  },
}

components.active[3][10] = {
  provider = statusline_style.position_icon,
  hl = {
    fg = colors.black,
    bg = colors.green,
  },
}

components.active[3][11] = {
  provider = function()
    local current_line = vim.fn.line(".")
    local total_line = vim.fn.line("$")

    if current_line == 1 then
      return " Top "
    elseif current_line == vim.fn.line("$") then
      return " Bot "
    end
    local result, _ = math.modf((current_line / total_line) * 100)
    return " " .. result .. "%% "
  end,

  hl = {
    fg = colors.green,
    bg = colors.bg_dark,
  },
}

require("feline").setup({
  colors = {
    bg = colors.bg_dark,
    fg = colors.fg,
  },
  components = components,
})
