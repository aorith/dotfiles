local wezterm = require("wezterm")
require("lua.on-callbacks")

local function font_with_fallback(name, params)
  local names = { name, "Noto Color Emoji", "Hack Nerd Font", "JetBrainsMono Nerd Font Mono" }
  return wezterm.font_with_fallback(names, params)
end

local config = {
  status_update_interval = 900,

  window_decorations = "RESIZE", -- RESIZE: don't show titlebar but allow resize
  cursor_blink_rate = 800,
  enable_scroll_bar = true,
  scrollback_lines = 350000,
  min_scroll_bar_height = "2cell",

  --color_scheme = "One Light (base16)",
  --color_scheme = "OneDark (base16)",
  color_scheme = "Gruvbox dark, hard (base16)",
  --color_scheme = "mylight",

  font_size = 19.0,
  font = font_with_fallback("Hack Nerd Font"),
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- --> disable ligadures

  window_frame = {
    font_size = 16.0,
    font = wezterm.font("Hack Nerd Font"),
    active_titlebar_bg = "#333333",
    inactive_titlebar_bg = "#333333",
  },

  colors = {
    scrollbar_thumb = "grey",
  },

  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,
  disable_default_key_bindings = false,
}

config.hyperlink_rules = {
  { regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" },
  { regex = [[\bfile://\S*\b]], format = "$0" },
  { regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
}

if string.match(wezterm.target_triple, "darwin") then
  -- they're in reverse between the built-in keyboard and the external MXKeys
  config.send_composed_key_when_left_alt_is_pressed = true
  config.send_composed_key_when_right_alt_is_pressed = true

  local wz_keys = require("lua.keybinds").wezterm_keys
  config.keys = wz_keys.keys
  config.key_tables = wz_keys.key_tables
end

config.mouse_bindings = require("lua.mouse_actions").mouse_actions

return config
