local wezterm = require("wezterm")

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s) return string.gsub(s, "(.*[/\\])(.*)", "%2") end

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then return title end
  return basename(tab_info.active_pane.foreground_process_name)
end

local M = {}

function M.setup()
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    local idx = tostring(tab.tab_index + 1)
    local zoomed = tab.active_pane.is_zoomed and "[z]" or ""

    local background = "#333333"
    local foreground = "#ebdbb2"

    if tab.is_active then
      background = "#405578"
      foreground = "#ffffff"
    end

    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = " " .. zoomed },
      { Attribute = { Intensity = "Bold" } },
      { Text = idx },
      { Attribute = { Intensity = "Normal" } },
      { Text = ":" .. title .. " " },
    }
  end)
end

return M
