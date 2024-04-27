local wezterm = require("wezterm")

local config = wezterm.config_builder()
config:set_strict_mode(true)

config.default_cwd = os.getenv("HOME")
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 40
config.show_new_tab_button_in_tab_bar = false

config.enable_scroll_bar = true
config.scrollback_lines = 25000

-- fonts
config.bold_brightens_ansi_colors = true
config.font = wezterm.font_with_fallback({
  "IosevkaInputFixed SmEx",
  -- "JetBrains Mono",
  -- 'Iosevka Term',
})
config.font_size = 17
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable ligadures

config.command_palette_font_size = 16.0

config.color_scheme = "Tomorrow Night (Gogh)"
config.inactive_pane_hsb = {
  -- default: 0.9
  saturation = 1,
  -- default: 0.8
  brightness = 0.6,
}

require("status").setup()
require("tabtitle").setup()
local keymaps = require("keymaps")

config.disable_default_key_bindings = true
config.leader = keymaps.leader
config.colors = { compose_cursor = "yellow" } -- highlight cursor when leader is active

config.enable_kitty_keyboard = true
--config.use_dead_keys = true
--config.use_ime = true

config.keys = keymaps.keys
config.key_tables = keymaps.key_tables

return config
