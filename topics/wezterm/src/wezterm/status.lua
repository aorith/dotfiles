local wezterm = require("wezterm")

wezterm.on("update-status", function(window, pane)
  window:set_left_status(wezterm.format({
    { Background = { Color = "#fe8019" } },
    { Foreground = { Color = "#000000" } },
    { Text = " " .. window:active_workspace() .. " " },
  }))
end)

wezterm.on("update-right-status", function(window, pane)
  local dim = pane:get_dimensions()
  local leader = window:leader_is_active() and { Text = " P " } or { Text = "" }
  local active_keytable = window:active_key_table()
  local keytable = active_keytable and { Text = " " .. active_keytable .. " " } or { Text = "" }

  window:set_right_status(wezterm.format({
    { Background = { Color = "#504945" } },
    { Text = " " .. pane:get_title() },
    { Attribute = { Italic = true } },
    { Text = " " .. dim.scrollback_rows .. "L " },
    { Attribute = { Intensity = "Bold" } },
    { Background = { Color = "yellow" } },
    { Foreground = { Color = "black" } },
    leader,
    { Background = { Color = "lightblue" } },
    keytable,
  }))
end)
