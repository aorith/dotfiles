local wezterm = require("wezterm")
local act = wezterm.action

local is_darwin = wezterm.target_triple:find("darwin") ~= nil
local mod = is_darwin and "CMD" or "ALT"

local M = {}

M.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 5000 }

M.keys = {
  { key = "b", mods = "CTRL|LEADER", action = act.SendKey({ key = "b", mods = "CTRL" }) },
  { key = "Enter", mods = mod, action = act.RotatePanes("Clockwise") },

  { key = "+", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "+", mods = mod, action = act.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
  { key = "-", mods = mod, action = act.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = act.ResetFontSize },

  { key = "0", mods = mod, action = act.ResetFontSize },

  { key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
  { key = "c", mods = mod, action = act.CopyTo("Clipboard") },
  { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  { key = "v", mods = mod, action = act.PasteFrom("Clipboard") },

  { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
  { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },

  { key = "D", mods = mod, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = mod, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

  { key = "f", mods = mod, action = act.Multiple({ "ActivateCopyMode", { CopyMode = "ClearPattern" }, { Search = "CurrentSelectionOrEmptyString" } }) },
  { key = "g", mods = mod, action = act.ActivateCopyMode },

  { key = "h", mods = mod, action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = mod, action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = mod, action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = mod, action = act.ActivatePaneDirection("Right") },

  { key = "l", mods = "CTRL", action = act.Multiple({ { ClearScrollback = "ScrollbackOnly" }, { SendKey = { key = "l", mods = "CTRL" } } }) },
  { key = "n", mods = mod, action = act.SpawnWindow },
  { key = "o", mods = "LEADER", action = act.ShowDebugOverlay },
  { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
  {
    -- rename pane
    key = "r",
    mods = mod,
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Rename pane to" },
      }),
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    }),
  },
  {
    -- create a new workspace with a given name
    key = "T",
    mods = mod,
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line and line ~= "" then window:perform_action(
          act.SwitchToWorkspace({
            name = line,
          }),
          pane
        ) end
      end),
    }),
  },
  { key = ",", mods = mod, action = act.SwitchWorkspaceRelative(1) },

  { key = "t", mods = mod, action = act.SpawnCommandInNewTab({ cwd = os.getenv("HOME"), domain = "CurrentPaneDomain" }) },
  { key = "v", mods = mod, action = act.PasteFrom("Clipboard") },
  { key = "w", mods = mod, action = act.CloseCurrentPane({ confirm = true }) },
  { key = "x", mods = mod, action = act.Multiple({ { CopyMode = "ClearPattern" }, "ActivateCopyMode" }) },
  { key = "z", mods = mod, action = act.TogglePaneZoomState },

  { key = "phys:1", mods = mod, action = act.ActivateTab(0) },
  { key = "phys:2", mods = mod, action = act.ActivateTab(1) },
  { key = "phys:3", mods = mod, action = act.ActivateTab(2) },
  { key = "phys:4", mods = mod, action = act.ActivateTab(3) },
  { key = "phys:5", mods = mod, action = act.ActivateTab(4) },
  { key = "phys:6", mods = mod, action = act.ActivateTab(5) },
  { key = "phys:7", mods = mod, action = act.ActivateTab(6) },
  { key = "phys:8", mods = mod, action = act.ActivateTab(7) },
  { key = "phys:9", mods = mod, action = act.ActivateTab(8) },

  { key = "phys:Space", mods = mod, action = act.QuickSelect },
  { key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },
  { key = "Insert", mods = "CTRL", action = act.CopyTo("PrimarySelection") },
  { key = "Insert", mods = "SHIFT|CTRL", action = act.PasteFrom("PrimarySelection") },
  { key = "F12", mods = "NONE", action = act.ToggleFullScreen },

  { key = "o", mods = mod, action = act.EmitEvent("trigger-vim-with-scrollback") },
}

M.key_tables = {
  copy_mode = {
    { key = "q", mods = "NONE", action = act.Multiple({ { CopyMode = "ClearPattern" }, { CopyMode = "Close" }, "ClearSelection" }) },
    { key = "Escape", mods = "NONE", action = act.Multiple({ { CopyMode = "ClearPattern" }, { CopyMode = "Close" }, "ClearSelection" }) },
    { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "/", mods = "SHIFT", action = act.Multiple({ { CopyMode = "ClearSelectionMode" }, { Search = "CurrentSelectionOrEmptyString" } }) },
    { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "N", mods = "NONE", action = act.CopyMode("PriorMatch") },
    { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
    { key = "c", mods = "NONE", action = act.Multiple({ { CopyTo = "Clipboard" }, "ClearSelection", { CopyMode = "ClearSelectionMode" } }) },
    { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
    { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
    { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "y", mods = "NONE", action = act.Multiple({ { CopyTo = "Clipboard" }, "ClearSelection", { CopyMode = "Close" } }) },
    { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
    { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
    { key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
  },

  search_mode = {
    { key = "Backspace", mods = "ALT", action = act.CopyMode("ClearPattern") },
    { key = "Enter", mods = "NONE", action = act.CopyMode("AcceptPattern") },
    { key = "Escape", mods = "NONE", action = act.Multiple({ { CopyMode = "ClearPattern" }, { CopyMode = "Close" } }) },
    { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
  },
}

return M
