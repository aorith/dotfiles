local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local function tmux_key(k)
  return act.Multiple({
    act.SendKey({ key = "b", mods = "CTRL" }),
    act.SendKey({ key = k }),
  })
end

function M.apply(config)
  config.disable_default_key_bindings = true

  config.keys = {
    { key = "q", mods = "SUPER", action = act.QuitApplication },
    { key = "P", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },
    { key = "i", mods = "SUPER", action = act.EmitEvent("cycle-color-schemes") },
    { key = "l", mods = "CTRL", action = act.Multiple({ { ClearScrollback = "ScrollbackOnly" }, { SendKey = { key = "l", mods = "CTRL" } } }) },
    { key = "F12", mods = "NONE", action = act.ToggleFullScreen },
    { key = "n", mods = "SHIFT|SUPER", action = wezterm.action.SpawnWindow },

    -- Make Option-Left/Right equivalent to Alt-b/Alt-f which many line editors interpret as backward-word/forward-word
    { key = "LeftArrow", mods = "OPT", action = act({ SendString = "\x1bb" }) },
    { key = "RightArrow", mods = "OPT", action = act({ SendString = "\x1bf" }) },

    { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
    { key = "0", mods = "SUPER", action = act.ResetFontSize },

    { key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
    { key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
    { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },

    --- tmux
    { key = "w", mods = "SUPER", action = tmux_key("x") },
    { key = "t", mods = "SUPER", action = tmux_key("c") },
    { key = "t", mods = "SUPER|SHIFT", action = tmux_key("C") },

    { key = "h", mods = "SUPER", action = tmux_key("h") },
    { key = "j", mods = "SUPER", action = tmux_key("j") },
    { key = "k", mods = "SUPER", action = tmux_key("k") },
    { key = "l", mods = "SUPER", action = tmux_key("l") },

    { key = "h", mods = "SUPER|SHIFT", action = tmux_key("H") },
    { key = "j", mods = "SUPER|SHIFT", action = tmux_key("J") },
    { key = "k", mods = "SUPER|SHIFT", action = tmux_key("K") },
    { key = "l", mods = "SUPER|SHIFT", action = tmux_key("L") },

    { key = "LeftArrow", mods = "SUPER", action = act({ SendString = "\x02\x08" }) },
    { key = "DownArrow", mods = "SUPER", action = act({ SendString = "\x02\x0a" }) },
    { key = "UpArrow", mods = "SUPER", action = act({ SendString = "\x02\x0b" }) },
    { key = "RightArrow", mods = "SUPER", action = act({ SendString = "\x02\x0c" }) },

    { key = "Enter", mods = "SUPER|SHIFT", action = tmux_key("Space") },
    { key = "d", mods = "SUPER", action = tmux_key("%") },
    { key = "d", mods = "SUPER|SHIFT", action = tmux_key('"') },
    { key = "s", mods = "SUPER", action = tmux_key("s") },

    { key = "1", mods = "SUPER", action = tmux_key("1") },
    { key = "2", mods = "SUPER", action = tmux_key("2") },
    { key = "3", mods = "SUPER", action = tmux_key("3") },
    { key = "4", mods = "SUPER", action = tmux_key("4") },
    { key = "5", mods = "SUPER", action = tmux_key("5") },
    { key = "6", mods = "SUPER", action = tmux_key("6") },
    { key = "7", mods = "SUPER", action = tmux_key("7") },
    { key = "8", mods = "SUPER", action = tmux_key("8") },
    { key = "9", mods = "SUPER", action = tmux_key("9") },

    { key = "g", mods = "SUPER", action = tmux_key("[") },
    { key = "r", mods = "SUPER", action = tmux_key("W") },
    { key = "r", mods = "SUPER|SHIFT", action = tmux_key("S") },
    { key = "Comma", mods = "SUPER", action = tmux_key("(") },
    { key = "z", mods = "SUPER", action = tmux_key("z") },
    { key = "f", mods = "SUPER", action = tmux_key("/") },
    { key = "p", mods = "SUPER", action = tmux_key("p") },
  }

  -- config.mouse_bindings = {
  --   {
  --     event = { Up = { streak = 1, button = "Left" } },
  --     mods = "NONE",
  --     action = act.CompleteSelection("PrimarySelection"),
  --   },
  --   {
  --     event = { Up = { streak = 1, button = "Left" } },
  --     mods = "CTRL",
  --     action = act.OpenLinkAtMouseCursor,
  --   },
  --   -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  --   {
  --     event = { Down = { streak = 1, button = "Left" } },
  --     mods = "CTRL",
  --     action = act.Nop,
  --   },
  --   {
  --     event = { Up = { streak = 2, button = "Left" } },
  --     action = act.SelectTextAtMouseCursor("SemanticZone"),
  --     mods = "ALT",
  --   },
  -- }
end

return M
