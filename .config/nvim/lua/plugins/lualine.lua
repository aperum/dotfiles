return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local navic = require("nvim-navic")
    local colors = require("tokyonight.colors").setup({ transform = true })

    local function is_lsp_active()
      if next(vim.lsp.get_active_clients()) ~= nil then
        return true
      end

      return false
    end

    local function get_lsp_name()
      local _, client = next(vim.lsp.get_active_clients())
      return client.name
    end
    local function get_lsp_status()
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
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
      },

      sections = {
        lualine_a = {
          {
            'mode',
            separator = { left = '', right = '' },
          },
        },
        lualine_b = {
          {
            'branch',
            separator = { left = '', right = '' },
            color = { fg = colors.fg, bg = colors.blue0 },
          },
          {
            'diff',
            symbols = { added = '', modified = '', removed = '' },
            color = { fg = colors.fg, bg = colors.blue7 },
            separator = { left = '', right = '' },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
          'diagnotics',
        },
        lualine_c = {
          {
            function()
              return navic.get_location()
            end,
            cond = function()
              return navic.is_available()
            end,
            color = { fg = colors.magenta, bg = colors.bg_highlight },
            separator = { left = '', right = '' },
          },
        },
        lualine_x = {
          {
            function()
              return get_lsp_status()
            end,
            cond = function()
              if get_lsp_status() ~= nil then
                return true
              else
                return false
              end
            end,
            color = { fg = colors.fg, bg = colors.bg_highlight },
            separator = { left = '', right = '' },
          },
          {
            function()
              return " " .. get_lsp_name()
            end,
            cond = function()
              return is_lsp_active()
            end,
            color = { fg = colors.fg, bg = colors.bg },
            separator = { left = '', right = '' },
          },
          -- 'encoding',
          -- 'fileformat',
          {
            'filetype',
            color = { fg = colors.fg, bg = colors.bg_highlight },
            separator = { left = '', right = '' },
          },
        },
        lualine_z = {},
      }
    }
  end,
}
