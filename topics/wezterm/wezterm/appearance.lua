local wezterm = require('wezterm')

local M = {}

local color_schemes = {
  ['mydark'] = wezterm.color.get_builtin_schemes()['Modus-Vivendi'],
  ['mylight'] = wezterm.color.get_builtin_schemes()['Modus-Operandi'],
}

local function scheme_for_appearance()
  if not wezterm.gui then return 'mydark' end
  local appearance = wezterm.gui.get_appearance()
  if appearance:find('Dark') then return 'mydark' end
  return 'mylight'
end

function M.apply(config)
  -- config.font = wezterm.font("Hack")
  config.font = wezterm.font({
    family = 'JetBrains Mono',
    harfbuzz_features = { 'zero', 'ss01', 'cv05', 'calt=0', 'clig=0', 'liga=0' },
  })

  config.force_reverse_video_cursor = true
  config.reverse_video_cursor_min_contrast = 2.5

  config.font_size = 15
  config.line_height = 1.2
  config.adjust_window_size_when_changing_font_size = false
  config.harfbuzz_features = {
    'calt=0', -- Contextual alternates (calt)
    'clig=0', -- Discretionary ligatures (dlig)
    'liga=0', -- Common/standard ligatures (liga)
  }

  config.enable_tab_bar = true
  config.window_frame = {
    font_size = 14,
  }

  config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 0.9,
  }

  config.color_schemes = color_schemes
  config.color_scheme = scheme_for_appearance()
end

wezterm.on('cycle-color-schemes', function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.colors then overrides.colors = {} end

  local keys = {}
  for key in pairs(color_schemes) do
    table.insert(keys, key)
  end

  local current_scheme = window:effective_config().color_scheme
  local current_index = 0
  for i, key in ipairs(keys) do
    if key == current_scheme then current_index = i end
  end

  local next_theme = keys[current_index % #keys + 1]
  wezterm.log_info('current theme: ', current_scheme, ', next theme: ', next_theme)
  overrides.color_scheme = next_theme
  window:set_config_overrides(overrides)
end)

return M
