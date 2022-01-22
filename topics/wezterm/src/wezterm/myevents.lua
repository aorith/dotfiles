-- vim:ft=lua foldmethod=marker foldmarker=--(,--) foldlevel=0

local wezterm = require 'wezterm';
local io = require 'io';
local os = require 'os';

--( workspace
wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(window:active_workspace() .. '  ')
end)
--)

--( open in vim
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
--)

--( open in sublime
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
--(

--( tcdn-server-for
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
--)

