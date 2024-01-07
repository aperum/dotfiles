return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local colors = require("tokyonight.colors").setup({})
    local rq_mappings = require("cokeline/mappings")
    local hlgroups = require("cokeline.hlgroups")

    local str_rep = string.rep

    local comments_fg = hlgroups.get_hl_attr("Comment", "colors.fg")
    local errors_fg = hlgroups.get_hl_attr("DiagnosticError", "colors.fg")
    local warnings_fg = hlgroups.get_hl_attr("DiagnosticWarn", "colors.fg")
    local focused_fg = colors.magenta

    local min_buffer_width = 23

    local components = {
      separator = {
        text = " ",
        bg = colors.bg_dark,
        truncation = { priority = 1 },
      },

      space = {
        text = " ",
        truncation = { priority = 1 },
      },

      left_half_circle = {
        text = "",
        fg = colors.bg_highlight,
        bg = colors.bg_dark,
        truncation = { priority = 1 },
      },

      right_half_circle = {
        text = "",
        fg = colors.bg_highlight,
        bg = colors.bg_dark,
        truncation = { priority = 1 },
      },

      devicon_or_pick_letter = {
        text = function(buffer)
          return (rq_mappings.is_picking_focus() or rq_mappings.is_picking_close()) and buffer.pick_letter .. " "
              or buffer.devicon.icon
        end,
        fg = function(buffer)
          return (rq_mappings.is_picking_focus() and colors.yellow)
              or (rq_mappings.is_picking_close() and colors.red)
              or buffer.devicon.color
        end,
        style = function(_)
          return (rq_mappings.is_picking_focus() or rq_mappings.is_picking_close()) and "italic,bold" or nil
        end,
        truncation = { priority = 1 },
      },

      index = {
        text = function(buffer)
          return buffer.index .. ": "
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and errors_fg) or (buffer.diagnostics.warnings ~= 0 and warnings_fg) or
              nil
        end,
        truncation = { priority = 1 },
      },

      unique_prefix = {
        text = function(buffer)
          return buffer.unique_prefix
        end,
        fg = comments_fg,
        style = "italic",
        truncation = {
          priority = 3,
          direction = "left",
        },
      },

      filename = {
        text = function(buffer)
          return buffer.filename
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and errors_fg)
              or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
              or (buffer.is_focused and focused_fg)
              or comments_fg
        end,
        style = function(buffer)
          return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
              or (buffer.is_focused and "bold")
              or (buffer.diagnostics.errors ~= 0 and "underline")
              or nil
        end,
        truncation = {
          priority = 2,
          direction = "left",
        },
      },

      diagnostics = {
        text = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and " 󰅚 " .. buffer.diagnostics.errors)
              or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
              or ""
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and errors_fg) or (buffer.diagnostics.warnings ~= 0 and warnings_fg) or
              nil
        end,
        truncation = { priority = 1 },
      },

      close_or_unsaved = {
        text = function(buffer)
          return buffer.is_modified and "●" or "󰅖"
        end,
        fg = function(buffer)
          return buffer.is_modified and colors.green or nil
        end,
        delete_buffer_on_left_click = true,
        truncation = { priority = 1 },
      },
    }

    local get_remaining_space = function(buffer)
      local used_space = 0
      for _, component in pairs(components) do
        used_space = used_space
            + vim.fn.strwidth(
              (type(component.text) == "string" and component.text)
              or (type(component.text) == "function" and component.text(buffer))
            )
      end
      return math.max(0, min_buffer_width - used_space)
    end

    local left_padding = {
      text = function(buffer)
        local remaining_space = get_remaining_space(buffer)
        return str_rep(" ", remaining_space / 2 + remaining_space % 2)
      end,
    }

    local right_padding = {
      text = function(buffer)
        local remaining_space = get_remaining_space(buffer)
        return str_rep(" ", remaining_space / 2)
      end,
    }

    local filtered_types = { "neogitstatus", "terminal" }

    require("cokeline").setup({
      show_if_buffers_are_at_least = 1,

      buffers = {
        filter_valid = function(buffer)
          for _, type in ipairs(filtered_types) do
            if buffer.type ~= type then
              return true
            end
          end
        end,
        filter_visible = function(buffer)
          for _, type in ipairs(filtered_types) do
            if buffer.type ~= type then
              return true
            end
          end
        end,
        focus_on_delete = "prev",
        new_buffers_position = "last",
      },

      sidebar = {
        filetype = "neo-tree",
        components = {
          {
            text = "  Explorer",
            fg = colors.yellow,
            bg = colors.bg,
            style = "bold",
          },
        },
      },

      default_hl = {
        fg = colors.fg,
        bg = colors.bg_highlight,
      },

      components = {
        components.separator,
        components.left_half_circle,
        left_padding,
        components.devicon_or_pick_letter,
        components.index,
        components.unique_prefix,
        components.filename,
        -- components.diagnostics,
        components.space,
        right_padding,
        -- components.close_or_unsaved,
        components.right_half_circle,
      },
    })

    for i = 1, 9 do
      vim.keymap.set("n", ("<A-%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
    end
  end,
}
