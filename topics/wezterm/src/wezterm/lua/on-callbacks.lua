local wezterm = require("wezterm")

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

wezterm.on("update-right-status", function(window, pane)
  local dim = pane:get_dimensions()
  window:set_right_status(wezterm.format({
    { Attribute = { Underline = "Single" } },
    { Attribute = { Italic = true } },
    { Text = pane:get_title() },
    { Foreground = { Color = "grey" } },
    { Text = " " .. dim.scrollback_rows .. "L " },
    { Foreground = { Color = "orange" } },
    { Text = window:active_workspace() .. " " },
  }))
end)

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#333333"
  local foreground = "#808080"

  if tab.is_active then
    background = "#333333"
    foreground = "#f0f0f0"
  elseif hover then
    background = "#3b3052"
    foreground = "#909090"
  end

  local index = " " .. tab.tab_index + 1 .. ": "
  local title = basename(tab.active_pane.foreground_process_name)

  if tab.active_pane.is_zoomed then
    title = "[Z]" .. title
    foreground = "Yellow"
  end

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Attribute = { Intensity = "Bold" } },
    { Text = index },
    "ResetAttributes",
    { Text = title .. " " },
  }
end)

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
  local args = { "bash", "-lic", "fzf < '" .. filename .. "' | $CLIPBOARD_COPY"}
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
