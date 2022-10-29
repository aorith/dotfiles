local wezterm = require("wezterm")

return {
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
}
