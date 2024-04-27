local wezterm = require("wezterm")

local M = {}

function M.setup()
  wezterm.on("update-status", function(window, pane)
    local active_keytable = window:active_key_table()

    local title = pane:get_title():sub(1, 50)
    local sb_info = " "
    if active_keytable then
      local dim = pane:get_dimensions()
      sb_info = " " .. dim.scrollback_rows .. "L "
    end

    window:set_right_status(wezterm.format({
      { Background = { Color = "#504945" } },
      { Text = " " .. title },
      { Attribute = { Italic = true } },
      { Text = sb_info },
    }))

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
end

return M
