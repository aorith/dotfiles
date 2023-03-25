local wezterm = require("wezterm")

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local dump_scrollback_to_file = function(window, pane, full)
  local scrollback
  if full then
    scrollback = pane:get_lines_as_text(500000)
  else
    scrollback = pane:get_lines_as_text()
  end

  local name = os.tmpname()
  local f = io.open(name, "w+")
  if f == nil then
    return nil
  end
  f:write(scrollback)
  f:flush()
  f:close()
  return name
end

local open_in_zoomed_split = function(window, pane, args)
  window:perform_action(
    wezterm.action({
      SplitVertical = {
        args = args,
      },
    }),
    pane
  )
  wezterm.sleep_ms(50)
  window:perform_action("TogglePaneZoomState", pane)
end

wezterm.on("update-status", function(window, pane)
  window:set_left_status(wezterm.format({
    { Background = { Color = "#333333" } },
    { Foreground = { Color = "orange" } },
    { Text = " " .. window:active_workspace() .. " " },
  }))

  local dim = pane:get_dimensions()
  window:set_right_status(wezterm.format({
    { Background = { Color = "#333333" } },
    { Attribute = { Underline = "Single" } },
    { Attribute = { Italic = true } },
    { Text = pane:get_title() },
    { Foreground = { Color = "grey" } },
    { Text = " " .. dim.scrollback_rows .. "L " },
  }))
end)

local HEADING_COLOR = { "#ffb2cc", "#a4a4a4" }
local BG_COLOR = { "#111111", "#333333" }
local FONT_COLOR = { "#ffffff", "#aaaaaa" }

if string.match(wezterm.target_triple, "darwin") then
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local active_idx = tab.is_active and 1 or 2

    local index = " " .. tab.tab_index + 1 .. " "
    local zoomed = tab.active_pane.is_zoomed and "🔎 " or ""
    local title = basename(tab.active_pane.foreground_process_name)

    return {
      { Background = { Color = BG_COLOR[active_idx] } },
      { Foreground = { Color = HEADING_COLOR[active_idx] } },
      { Text = index .. zoomed },
      { Foreground = { Color = FONT_COLOR[active_idx] } },
      { Attribute = { Intensity = "Half" } },
      { Text = title },
      "ResetAttributes",
    }
  end)
else
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local active_idx = tab.is_active and 1 or 2

    local index = " " .. tab.tab_index + 1 .. " "
    local zoomed = tab.active_pane.is_zoomed and "🔎 " or ""
    local title = tab.active_pane.title

    return {
      { Background = { Color = BG_COLOR[active_idx] } },
      { Foreground = { Color = HEADING_COLOR[active_idx] } },
      { Text = index .. zoomed },
      { Foreground = { Color = FONT_COLOR[active_idx] } },
      { Attribute = { Intensity = "Half" } },
      { Text = title },
      "ResetAttributes",
    }
  end)
end

wezterm.on("tcdn-server-for", function(window, pane)
  local filename = dump_scrollback_to_file(window, pane, false)
  if filename == nil then
    return
  end

  local args = {
    os.getenv("HOME") .. "/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/scripts-private/bin/fzf_server_for",
    filename,
  }
  open_in_zoomed_split(window, pane, args)
end)

wezterm.on("fzf-search-scrollback", function(window, pane)
  local filename = dump_scrollback_to_file(window, pane, false)
  if filename == nil then
    return
  end
  local args = { "bash", "-lic", "fzf < '" .. filename .. "' | $CLIPBOARD_COPY" }
  open_in_zoomed_split(window, pane, args)
end)

wezterm.on("nvim-open-scrollback", function(window, pane)
  local filename = dump_scrollback_to_file(window, pane, false)
  if filename == nil then
    return
  end
  local args = { "bash", "-lic", "nvim " .. filename }
  open_in_zoomed_split(window, pane, args)
end)
