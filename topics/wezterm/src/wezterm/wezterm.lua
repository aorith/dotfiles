local wezterm = require("wezterm")

local config = {
  window_decorations = "RESIZE", -- RESIZE: don't show titlebar but allow resize
  color_scheme = "kanagawabones",
  colors = {
    cursor_bg = "#52ad70",
    cursor_fg = "black",
    cursor_border = "#52ad70",
  },
  font_size = 16.0,
  --font = wezterm.font("MesloLGMDZ Nerd Font Mono"),
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- --> disable ligadures
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  disable_default_key_bindings = true,
}

config.hyperlink_rules = {
  { regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" },
  { regex = [[\bfile://\S*\b]], format = "$0" },
  { regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
}

config.keys = {
  { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },

  -- fix ALT+Space writing 0xA0
  { key = "Space", mods = "ALT", action = wezterm.action.SendString(" ") },

  -- font size
  { key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

  -- copy & paste
  { key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("PrimarySelection") },
  { key = "v", mods = "CMD", action = wezterm.action.PasteFrom("PrimarySelection") },
  { key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("PrimarySelection") },
  { key = "c", mods = "CMD", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
}

if string.match(wezterm.target_triple, "darwin") then
  config.send_composed_key_when_left_alt_is_pressed = true
  config.send_composed_key_when_right_alt_is_pressed = false
end

return config
