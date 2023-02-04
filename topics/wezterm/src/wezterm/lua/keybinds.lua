local wezterm = require("wezterm")
local act = wezterm.action

local copy_mode = {}
local search_mode = {}
if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  search_mode = wezterm.gui.default_key_tables().search_mode
end

local copy_mode_extra_keys = {
  { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
  { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
  { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
  {
    key = "y",
    mods = "NONE",
    action = act.Multiple({
      act.CopyTo("ClipboardAndPrimarySelection"),
      act.CopyMode("ClearPattern"),
      act.CopyMode("Close"),
    }),
  },
  {
    key = "Escape",
    mods = "NONE",
    action = act.Multiple({
      act.CopyMode("ClearPattern"),
      act.CopyMode("Close"),
    }),
  },
}

local search_mode_extra_keys = {
  { key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
  { key = "Enter", mods = "SHIFT", action = act.CopyMode("NextMatch") },
  { key = "f", mods = "SUPER", action = act.CopyMode("ClearPattern") },
  { key = "F", mods = "SUPER|SHIFT", action = act.CopyMode("CycleMatchType") },
  { key = "Backspace", mods = "ALT", action = act.CopyMode("ClearPattern") },
  {
    key = "Escape",
    mods = "NONE",
    action = act.Multiple({
      act.CopyMode("ClearPattern"),
      act.CopyMode("Close"),
    }),
  },
}

for i in pairs(copy_mode_extra_keys) do
  table.insert(copy_mode, copy_mode_extra_keys[i])
end
for i in pairs(search_mode_extra_keys) do
  table.insert(search_mode, search_mode_extra_keys[i])
end

local M = {}

M.wezterm_keys = {
  keys = {
    { key = "d", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
    { key = "n", mods = "CTRL|SHIFT", action = act.SpawnWindow },

    -- fix ALT+Space writing 0xA0
    { key = "Space", mods = "ALT", action = act.SendString(" ") },

    -- font size
    { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
    { key = "0", mods = "SUPER", action = act.ResetFontSize },

    -- copy & paste
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("PrimarySelection") },
    { key = "phys:Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
    { key = "v", mods = "SUPER", action = act.PasteFrom("PrimarySelection") },
    { key = "c", mods = "SUPER", action = act.CopyTo("ClipboardAndPrimarySelection") },

    -- scrollback
    {
      key = "l",
      mods = "CTRL",
      action = act.Multiple({
        act.ClearScrollback("ScrollbackAndViewport"),
        act.SendKey({ key = "L", mods = "CTRL" }),
      }),
    },

    { key = "q", mods = "SUPER", action = act.QuitApplication },

    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
    { key = "Enter", mods = "SUPER|SHIFT", action = act.RotatePanes("Clockwise") },

    { key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "D", mods = "SUPER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    { key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "T", mods = "SUPER|SHIFT", action = act.SwitchToWorkspace },

    { key = "h", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "SUPER", action = act.ActivatePaneDirection("Right") },

    { key = "H", mods = "SUPER|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) }, -- move pane
    { key = "J", mods = "SUPER|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) },
    { key = "K", mods = "SUPER|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) },
    { key = "L", mods = "SUPER|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) },

    { key = "1", mods = "SUPER", action = act.ActivateTab(0) }, -- switch to pane 1
    { key = "2", mods = "SUPER", action = act.ActivateTab(1) },
    { key = "3", mods = "SUPER", action = act.ActivateTab(2) },
    { key = "4", mods = "SUPER", action = act.ActivateTab(3) },
    { key = "5", mods = "SUPER", action = act.ActivateTab(4) },
    { key = "6", mods = "SUPER", action = act.ActivateTab(5) },
    { key = "7", mods = "SUPER", action = act.ActivateTab(6) },
    { key = "8", mods = "SUPER", action = act.ActivateTab(7) },
    { key = "9", mods = "SUPER", action = act.ActivateTab(8) },
    { key = "g", mods = "SUPER", action = act.ActivateCopyMode }, -- enter copy mode
    { key = "r", mods = "SUPER", action = act.SendString("\x1br") }, -- rename pane  TODO
    { key = "R", mods = "SUPER|SHIFT", action = act.SendString("\x1bR") }, -- rename session TODO
    { key = "Comma", mods = "SUPER", action = act.SwitchWorkspaceRelative(1) },

    { key = "z", mods = "SUPER", action = act.TogglePaneZoomState }, -- toggle zoom (maximize pane)
    {
      key = "f",
      mods = "SUPER",
      action = act.Multiple({
        act.CopyMode("ClearPattern"),
        act.Search({ CaseInSensitiveString = "" }),
      }),
    },
    { key = "i", mods = "SUPER", action = act.EmitEvent("tcdn-server-for") },
    { key = "F", mods = "SUPER|SHIFT", action = act.EmitEvent("fzf-search-scrollback") },
    { key = "E", mods = "SUPER|SHIFT", action = act.EmitEvent("nvim-open-scrollback") },
  },

  key_tables = {
    copy_mode = copy_mode,
    search_mode = search_mode,
  },
}

return M
