require("bufferline").setup({
  options = {
    numbers = "ordinal",
    indicator_icon = "▎",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    separator_style = "thick",
    -- separator_style = { "", "" },
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 25,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
        s = s .. n .. sym
      end
      return s
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
      },
      {
        filetype = "minimap",
        text = "Minimap",
        text_align = "center",
      },
      {
        filetype = "Outline",
        text = "Symbols",
        text_align = "center",
      },
      {
        filetype = "packer",
        text = "Plugins manager",
        text_align = "center",
      },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    always_show_bufferline = true,
    sort_by = "id",
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.diagnostic.get(0, [[Error]])
        local warning = vim.diagnostic.get(0, [[Warning]])
        local info = vim.diagnostic.get(0, [[Information]])
        local hint = vim.diagnostic.get(0, [[Hint]])

        if error ~= 0 then
          result[1] = {
            text = "  " .. error,
            guifg = "#ff6c6b",
          }
        end

        if warning ~= 0 then
          result[2] = {
            text = "  " .. warning,
            guifg = "#ECBE7B",
          }
        end

        if hint ~= 0 then
          result[3] = {
            text = "  " .. hint,
            guifg = "#98be65",
          }
        end

        if info ~= 0 then
          result[4] = {
            text = "  " .. info,
            guifg = "#51afef",
          }
        end

        return result
      end,
    },
  },
})
