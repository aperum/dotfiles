local helpers = require("helpers")

local home = os.getenv("HOME")

local config = {
  terminal = "wezterm",
  editor_cmd = os.getenv("EDITOR") or "gvim",
  rofi_run = "rofi -show drun",
  rofi_ssh = home .. "/bin/rofi-remmina.sh",
  rofi_window = "rofi -show window",
  rofi_password = home .. "/bin/rp.sh",
  rofi_ppassword = home .. "/bin/rpp.sh",
  rofi_calc = "rofi -show calc -modi calc -no-show-match -no-sort",
  virt = string.gsub(helpers.virt_result, "%s+", ""),
}

return config
