local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

wezterm.on('update-right-status', function(window, pane) window:set_right_status(window:active_workspace()) end)

function M.apply(config)
  config.disable_default_key_bindings = false

  config.keys = {
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    { key = 'P', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCommandPalette },
    { key = 'T', mods = 'CTRL|SHIFT', action = act.EmitEvent('cycle-color-schemes') },
    { key = 'n', mods = 'SUPER|SHIFT', action = wezterm.action.SpawnWindow },

    -- Make Option-Left/Right equivalent to Alt-b/Alt-f which many line editors interpret as backward-word/forward-word
    { key = 'LeftArrow', mods = 'OPT', action = act({ SendString = '\x1bb' }) },
    { key = 'RightArrow', mods = 'OPT', action = act({ SendString = '\x1bf' }) },

    -- Create a new workspace with a random name and switch to it
    { key = 'T', mods = 'SUPER|SHIFT', action = act.SwitchToWorkspace },
    -- Show the launcher in fuzzy selection mode and have it list all workspaces
    -- and allow activating one.
    {
      key = ',',
      mods = 'SUPER',
      action = act.ShowLauncherArgs({
        flags = 'FUZZY|WORKSPACES',
      }),
    },

    -- Close pane
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane({ confirm = false }) },

    -- Split panes
    { key = 'd', mods = 'SUPER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = 'D', mods = 'SUPER|SHIFT', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  }

  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection('PrimarySelection'),
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL|SHIFT',
      action = act.OpenLinkAtMouseCursor,
    },
    -- Disable the 'Down' event of CTRL|SHIFT-Click to avoid weird program behaviors
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL|SHIFT',
      action = act.Nop,
    },
    {
      event = { Up = { streak = 2, button = 'Left' } },
      action = act.SelectTextAtMouseCursor('SemanticZone'),
      mods = 'ALT',
    },
  }
end

return M
