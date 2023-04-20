local wezterm = require("wezterm")
local keymaps = require("keymaps")

require("status")
require("tabtitle")

local config = wezterm.config_builder()
config:set_strict_mode(true)

keymaps.apply_to_config(config)

config.default_cwd = os.getenv("HOME")
config.window_padding = { left = "0.5cell", right = "0.5cell", top = "0.5cell", bottom = "0.5cell" }
config.use_resize_increments = true
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false

config.enable_scroll_bar = true
config.scrollback_lines = 100000

-- fonts
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable ligadures
config.command_palette_font_size = 16.0

config.color_scheme = "Gruvbox Dark (Gogh)"

config.tab_max_width = 40

return config
