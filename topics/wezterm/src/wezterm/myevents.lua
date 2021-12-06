-- vim:ft=lua foldmethod=marker foldmarker=-{{{,-}}} foldlevel=0
local wezterm = require 'wezterm';
local io = require 'io';
local os = require 'os';

--{{{ open in vim
wezterm.on("trigger-vim-with-scrollback", function(window, pane)
  local pane_dim = pane:get_dimensions();
  local rows = pane_dim.scrollback_rows;
  local scrollback = pane:get_lines_as_text(rows);

  local name = os.tmpname();
  local f = io.open(name, "w+");
  f:write(scrollback);
  f:flush();
  f:close();

  window:perform_action(wezterm.action{SplitVertical={
    args={"vim", "-u", "~/.vim/min-vimrc", name}}
  }, pane);
  wezterm.sleep_ms(50);
  window:perform_action("TogglePaneZoomState", pane);

  wezterm.sleep_ms(2000);
  os.remove(name);
end)
--}}}

--{{{ open in sublime
wezterm.on("trigger-subl-with-scrollback", function(window, pane)
  local pane_dim = pane:get_dimensions();
  local rows = pane_dim.scrollback_rows;
  local scrollback = pane:get_lines_as_text(rows);

  local name = os.tmpname();
  local f = io.open(name, "w+");
  f:write(scrollback);
  f:flush();
  f:close();

  wezterm.run_child_process({"/usr/local/bin/subl", name})

  wezterm.sleep_ms(2000);
  os.remove(name);
end)
--}}}

--{{{ tcdn-server-for
wezterm.on("tcdn-server-for", function(window, pane)
  local scrollback = pane:get_lines_as_text();

  local name = os.tmpname();
  local f = io.open(name, "w+");
  f:write(scrollback);
  f:flush();
  f:close();

  window:perform_action(wezterm.action{SplitVertical={
    args={os.getenv("HOME") .. "/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/tcdn/kitty/bin/fzf_server_for", name}}
  }, pane);
  wezterm.sleep_ms(50);
  window:perform_action("TogglePaneZoomState", pane);

  wezterm.sleep_ms(2000);
  os.remove(name);
end)
--}}}

--{{{ Tab format
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local fixed_title = tab.active_pane.user_vars.panetitle
  if fixed_title ~= nil and #fixed_title > 0 then
    title = fixed_title
  end

  if tab.active_pane.is_zoomed then
    return {
      {Attribute={Intensity="Bold"}},
      {Foreground={Color="#975909"}},
      {Text=" Z"},
      {Foreground={Color="#000000"}},
      {Text=" " .. tab.tab_index + 1 .. ":"},
      {Attribute={Intensity="Normal"}},
      {Text=title .. " "},
    }
  else
    return {
      {Attribute={Intensity="Bold"}},
      {Text=" " .. tab.tab_index + 1 .. ":"},
      {Attribute={Intensity="Normal"}},
      {Text=title .. " "},
    }
  end
end)
--}}}
