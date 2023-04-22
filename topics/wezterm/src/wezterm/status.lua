local wezterm = require("wezterm")

wezterm.on("update-status", function(window, pane)
  local active_keytable = window:active_key_table()
  if active_keytable then
    window:set_left_status(wezterm.format({
      { Foreground = { Color = "black" } },
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = "lightblue" } },
      { Text = " " .. active_keytable .. " " },
    }))
    return
  end

  if window:leader_is_active() then
    window:set_left_status(wezterm.format({
      { Foreground = { Color = "#fe8019" } },
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = "yellow" } },
      { Foreground = { Color = "black" } },
      { Text = " Leader " },
    }))
    return
  end

  window:set_left_status(wezterm.format({
    { Foreground = { Color = "#fe8019" } },
    { Attribute = { Intensity = "Bold" } },
    { Text = " " .. window:active_workspace() .. " " },
  }))
end)

wezterm.on("update-right-status", function(window, pane)
  local dim = pane:get_dimensions()

  window:set_right_status(wezterm.format({
    { Background = { Color = "#504945" } },
    { Text = " " .. pane:get_title() },
    { Attribute = { Italic = true } },
    { Text = " " .. dim.scrollback_rows .. "L " },
  }))
end)
