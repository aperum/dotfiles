return {
	"ziontee113/icon-picker.nvim",
	dependencies = {
		"stevearc/dressing.nvim",
	},
  keys = {
    { "<leader>i", "<cmd>IconPickerNormal<cr>", desc = "IconPicker" },
  },
	opts = {
		disable_legacy_commands = true,
	},
}
