local wezterm = require("wezterm")
local act = wezterm.action

local leader = { key = "b", mods = "CTRL", timeout_milliseconds = 5000 }
local wez_mod = "CTRL|SHIFT" -- 'setxkbmap -option ctrl:nocaps' capslock acts as ctrl
local both = { "LEADER", wez_mod }

local keys = {}
local copy_mode = {}
local search_mode = {}

local function map(tbl, key, mods, action)
  if type(mods) == "table" then
    for _, mod in pairs(mods) do
      table.insert(tbl, { key = key, mods = mod, action = action })
    end
  else
    table.insert(tbl, { key = key, mods = mods, action = action })
  end
end

-- helpers
local rename = act.PromptInputLine({
  description = "New name",
  action = wezterm.action_callback(function(window, pane, line)
    if line then
      window:active_tab():set_title(line)
    end
  end),
})

-- bypass leader key by pressing it twice
map(keys, leader.key, "LEADER|CTRL", act.SendKey({ key = leader.key, mods = "CTRL" }))

-- copy & paste
map(keys, "c", { "SUPER", "CTRL|SHIFT" }, act.CopyTo("Clipboard"))
map(keys, "Insert", "CTRL", act.CopyTo("PrimarySelection"))
map(keys, "v", { "SUPER", "CTRL|SHIFT" }, act.PasteFrom("Clipboard"))
map(keys, "Insert", "SHIFT", act.PasteFrom("Clipboard"))
map(keys, "Insert", "CTRL|SHIFT", act.PasteFrom("PrimarySelection"))

-- clear scrollback
map(
  keys,
  "l",
  "CTRL",
  act.Multiple({ act.ClearScrollback("ScrollbackOnly"), act.SendKey({ key = "l", mods = "CTRL" }) })
)

-- activate tabs
for i = 1, 9 do
  map(keys, "phys:" .. tostring(i), both, act.ActivateTab(i - 1))
end
-- splits
map(keys, '"', { "LEADER|SHIFT", wez_mod .. "|ALT" }, act.SplitVertical)
map(keys, "%", { "LEADER|SHIFT", wez_mod .. "|ALT" }, act.SplitHorizontal)

-- move between panes
map(keys, "h", both, act.ActivatePaneDirection("Left"))
map(keys, "j", both, act.ActivatePaneDirection("Down"))
map(keys, "k", both, act.ActivatePaneDirection("Up"))
map(keys, "l", both, act.ActivatePaneDirection("Right"))
-- rotate panes
map(keys, "Enter", both, act.RotatePanes("Clockwise"))
-- spawn
map(keys, "t", both, act.SpawnCommandInNewTab({ cwd = os.getenv("HOME") }))
map(keys, "n", both, act.SpawnWindow)
-- rename
map(keys, "r", both, rename)
-- close
map(keys, "w", both, act.CloseCurrentPane({ confirm = true }))
-- search
map(
  keys,
  "f",
  both,
  act.Multiple({ act.ActivateCopyMode, act.CopyMode("ClearPattern"), act.Search("CurrentSelectionOrEmptyString") })
)
-- zoom
map(keys, "z", both, act.TogglePaneZoomState)
map(keys, "F12", "", act.ToggleFullScreen)
-- font size
map(keys, "-", { "CTRL", "SUPER" }, act.DecreaseFontSize)
map(keys, "+", { "CTRL", "SUPER" }, act.IncreaseFontSize)
map(keys, "0", { "CTRL", "SUPER" }, act.ResetFontSize)
-- palette & debug overlay
map(keys, "p", both, act.ActivateCommandPalette)
map(keys, "d", both, act.ShowDebugOverlay)
-- copy mode
map(keys, "x", both, act.Multiple({ act.CopyMode("ClearPattern"), act.ActivateCopyMode }))
-- quickselect
map(keys, "Space", both, act.QuickSelect)

--- copy mode
map(copy_mode, "h", "NONE", act.CopyMode("MoveLeft"))
map(copy_mode, "j", "NONE", act.CopyMode("MoveDown"))
map(copy_mode, "k", "NONE", act.CopyMode("MoveUp"))
map(copy_mode, "l", "NONE", act.CopyMode("MoveRight"))

map(copy_mode, "End", "NONE", act.CopyMode("MoveToEndOfLineContent"))
map(copy_mode, "Home", "NONE", act.CopyMode("MoveToStartOfLine"))
map(copy_mode, "$", "SHIFT", act.CopyMode("MoveToEndOfLineContent"))
map(copy_mode, "0", "NONE", act.CopyMode("MoveToStartOfLineContent"))
map(copy_mode, "G", "SHIFT", act.CopyMode("MoveToScrollbackBottom"))
map(copy_mode, "g", "NONE", act.CopyMode("MoveToScrollbackTop"))
map(copy_mode, "w", "NONE", act.CopyMode("MoveForwardWord"))
map(copy_mode, "b", "NONE", act.CopyMode("MoveBackwardWord"))
map(copy_mode, "PageUp", "NONE", act.CopyMode("PageUp"))
map(copy_mode, "PageDown", "NONE", act.CopyMode("PageDown"))

map(copy_mode, "v", "NONE", act.CopyMode({ SetSelectionMode = "Cell" }))
map(copy_mode, "V", "SHIFT", act.CopyMode({ SetSelectionMode = "Line" }))
map(copy_mode, "v", "CTRL", act.CopyMode({ SetSelectionMode = "Block" }))

map(copy_mode, "y", "NONE", act.Multiple({ act.CopyTo("Clipboard"), act.ClearSelection, act.CopyMode("Close") }))
map(
  copy_mode,
  "c",
  "NONE",
  act.Multiple({ act.CopyTo("Clipboard"), act.ClearSelection, act.CopyMode("ClearSelectionMode") })
)

map(
  copy_mode,
  "/",
  "SHIFT",
  act.Multiple({ act.CopyMode("ClearSelectionMode"), act.Search("CurrentSelectionOrEmptyString") })
)
map(copy_mode, "n", "NONE", act.CopyMode("NextMatch"))
map(copy_mode, "N", "SHIFT", act.CopyMode("PriorMatch"))

map(
  copy_mode,
  "Escape",
  "NONE",
  act.Multiple({ act.CopyMode("ClearPattern"), act.CopyMode("Close"), act.ClearSelection })
)

--- search mode
map(search_mode, "r", "CTRL", act.CopyMode("CycleMatchType"))
map(search_mode, "Backspace", "ALT", act.CopyMode("ClearPattern"))
map(search_mode, "Enter", "NONE", act.Multiple({ act.ActivateCopyMode, act.CopyMode("AcceptPattern") }))
map(search_mode, "Escape", "NONE", act.Multiple({ act.CopyMode("ClearPattern"), act.CopyMode("Close") }))

local M = {}

function M.apply_to_config(config)
  config.disable_default_key_bindings = true
  config.key_map_preference = "Mapped"
  config.leader = leader
  config.keys = keys
  config.key_tables = {
    copy_mode = copy_mode,
    search_mode = search_mode,
  }
  config.colors = { compose_cursor = "yellow" } -- highligh cursor when leader is active

  config.enable_kitty_keyboard = false
  config.use_dead_keys = false -- I usually don't need to type "áéíóú" in the terminal
  config.use_ime = true
end

return M
