local wezterm = require("wezterm")

local M = {}

local color_scheme_keys = { "MyDark", "MyLight", "MyBlack", "MyWhite" } -- to be able to cycle them
local color_schemes = {
  [color_scheme_keys[1]] = wezterm.color.get_builtin_schemes()["Selenized Dark (Gogh)"],
  [color_scheme_keys[2]] = wezterm.color.get_builtin_schemes()["Selenized Light (Gogh)"],
  [color_scheme_keys[3]] = wezterm.color.get_builtin_schemes()["Selenized Black (Gogh)"],
  [color_scheme_keys[4]] = wezterm.color.get_builtin_schemes()["Selenized White (Gogh)"],
}

local function is_dark()
  if wezterm.gui then return wezterm.gui.get_appearance():find("Dark") end
  return true
end

function M.apply(config)
  -- config.font = wezterm.font("Hack")
  config.font = wezterm.font({
    family = "JetBrains Mono",
    harfbuzz_features = { "zero", "ss01", "cv05" },
  })
  -- config.font = wezterm.font("Zed Mono", { weight = "Regular" })
  -- config.font = wezterm.font("Source Code Pro", { weight = "Regular" })

  config.dpi = 144
  config.font_size = 16
  config.line_height = 1.4
  config.use_cap_height_to_scale_fallback_fonts = true
  config.adjust_window_size_when_changing_font_size = false
  config.bold_brightens_ansi_colors = "BrightAndBold"
  config.harfbuzz_features = {
    "calt=0", -- Contextual alternates (calt)
    "clig=0", -- Discretionary ligatures (dlig)
    "liga=0", -- Common/standard ligatures (liga)
  }

  config.window_decorations = "RESIZE"
  config.enable_tab_bar = false
  config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  }
  config.window_content_alignment = {
    horizontal = "Center",
    vertical = "Top",
  }

  config.color_schemes = color_schemes

  if is_dark() then
    config.color_scheme = "MyDark"
  else
    config.color_scheme = "MyLight"
  end
end

wezterm.on("cycle-color-schemes", function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.colors then overrides.colors = {} end

  local current_scheme = window:effective_config().color_scheme
  local current_index = 0
  for i, key in ipairs(color_scheme_keys) do
    if key == current_scheme then current_index = i end
  end

  overrides.color_scheme = color_scheme_keys[current_index % #color_scheme_keys + 1]
  wezterm.log_info(overrides.color_scheme)
  window:set_config_overrides(overrides)
end)

return M
