-- vim: ft=lua foldmethod=marker foldmarker=--(,--) foldlevel=0

local io = require 'io';
local os = require 'os';
local wezterm = require 'wezterm';
require 'myevents'

local cfg = {
  term = "xterm-256color",
  --front_end = "Software",

  --color_scheme = "mygruvbox",
  color_scheme = "Paraiso Dark",

  scrollback_lines = 400000,
  audible_bell = "Disabled",
  exit_behavior = "Close",

  use_fancy_tab_bar = true,
  enable_tab_bar = true,
  tab_max_width = 24,

  window_padding = {
    left = 4, right = 4,
    top = 4, bottom = 4,
  },

  visual_bell = {
    fade_in_function = "EaseIn",
    fade_out_function = "EaseInOut",
    fade_in_duration_ms = 50,
    fade_out_duration_ms = 50,
    --target = "CursorColor",
  },
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.85,
  },
  --font = wezterm.font("JetBrains Mono", {stretch="Normal"}),
  font = wezterm.font_with_fallback(
    {
      {family="Iosevka Fixed", stretch="Normal"},
      {family="Noto Color Emoji", stretch="Normal"},
    }
  ),
  font_size = 15.0,
  adjust_window_size_when_changing_font_size = false,
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"}, -- disable ligadures
}

--( window_frame
cfg.window_frame = {
	font_size = 10.0,
    active_titlebar_bg = "#282828",
    inactive_titlebar_bg = "#1d2021",
    active_titlebar_border_bottom = "#282828",
    inactive_titlebar_border_bottom = "#1d2021",
}
--)

--( keyboard config
cfg.use_ime = true;
-- están alreves? left y right... el comportamiento bueno es con 'true' es el que deja escribir '~' y tal, sin embargo tengo que poner right en false y left en true ...
-- UPDATE: resulta que en el teclado MXKeys están al revés pero en el teclado de macos no.
cfg.send_composed_key_when_left_alt_is_pressed = true;
cfg.send_composed_key_when_right_alt_is_pressed = true;
cfg.enable_csi_u_key_encoding = false; -- (rompe cierta compatiblidad con xterm) new keyboard protocol http://www.leonard.org/hacks/fixterms/
cfg.use_dead_keys = true;
--)

--( Keymaps
cfg.disable_default_key_bindings = true;
cfg.leader = {mods="SUPER", key="Enter"};
local mykeys = {
  -- leader
  {mods="LEADER", key="r", action="ReloadConfiguration"},
  -- common
  {key="q", mods="SUPER", action="QuitApplication"},
  {key="n", mods="SUPER|SHIFT", action="SpawnWindow"},
  {key="g", mods="SUPER", action="ActivateCopyMode"},
  -- workspaces
  {key="t", mods="SUPER|SHIFT", action=wezterm.action{SwitchToWorkspace={}}}, -- create new
  {key=",", mods="SUPER", action=wezterm.action{SwitchWorkspaceRelative=1}},
  -- copy paste
  {key="c", mods="SUPER", action={CopyTo="Clipboard"}},
  {key="v", mods="SUPER", action={PasteFrom="Clipboard"}},
  {key="Insert", mods="CTRL", action={CopyTo="PrimarySelection"}},
  {key="Insert", mods="SHIFT", action={PasteFrom="PrimarySelection"}},
  {key="g", mods="SUPER", action="ActivateCopyMode"},
  -- font size
  {key="+", mods="SUPER", action="IncreaseFontSize"},
  {key="-", mods="SUPER", action="DecreaseFontSize"},
  {key="0", mods="SUPER", action="ResetFontSize"},
  -- instead of SpawnTab, this always opens the tab at home
  {key="t", mods="SUPER", action={SpawnCommandInNewTab={cwd = wezterm.home_dir}}},
  -- panes
  {key="w", mods="SUPER", action={CloseCurrentPane={confirm=false}}},
  {key="d", mods="SUPER", action={SplitHorizontal={domain="CurrentPaneDomain"}}},
  {key="d", mods="SUPER|SHIFT", action={SplitVertical={domain="CurrentPaneDomain"}}},
  {key="z", mods="SUPER", action="TogglePaneZoomState"},
  {key="h", mods="SUPER", action={ActivatePaneDirection="Left"}},
  {key="l", mods="SUPER", action={ActivatePaneDirection="Right"}},
  {key="k", mods="SUPER", action={ActivatePaneDirection="Up"}},
  {key="j", mods="SUPER", action={ActivatePaneDirection="Down"}},
  -- other
  {key="f", mods="SUPER", action={Search={CaseInSensitiveString=""}}},
  {key="f", mods="SUPER|SHIFT", action={Search={Regex=""}}},
  {key="F9", mods="ALT", action="ShowTabNavigator"},
  {key="F11", mods="SUPER", action="ToggleFullScreen"},
  -- scrolling
  {key="UpArrow", mods="SHIFT", action={ScrollByLine=-10}},
  {key="DownArrow", mods="SHIFT", action={ScrollByLine=10}},
  {key="PageUp", mods="SHIFT", action={ScrollByPage=-1}},
  {key="PageDown", mods="SHIFT", action={ScrollByPage=1}},
  {key="l", mods="CTRL", action={Multiple={{ClearScrollback="ScrollbackAndViewport"},{SendKey={key="l", mods="CTRL"}}}}},
  {key="l", mods="CTRL|SHIFT", action={SendKey={key="l", mods="CTRL|SHIFT"}}}, -- for vim, instead of C-l

  -- remap keys not working on macos FIXED in nightly
  --{key="+", mods="ALT", action={SendKey={key="]"}}},
  --{key="ç", mods="ALT", action={SendKey={key="}"}}},
  --{key=" ", mods="ALT", action={SendKey={key=" "}}}, -- ALT+Space has a bad behaviour in vim without this

  -- custom events and commands
  {key="v", mods="CTRL|SHIFT", action={EmitEvent="trigger-vim-with-scrollback"}},
  {key="s", mods="CTRL|SHIFT", action={EmitEvent="trigger-subl-with-scrollback"}},
  {key="i", mods="SUPER", action={EmitEvent="tcdn-server-for"}},
  {key="p", mods="SUPER", action={SpawnCommandInNewTab={args={"bash", "-li", os.getenv("HOME") .. "/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/tcdn/kitty/bin/bw-get.sh"}}}},
}

for i = 1, 8 do
  table.insert(mykeys, {
      key=tostring(i),
      mods="SUPER",
      action=wezterm.action{ActivateTab=i-1},
    })
end

cfg.keys = mykeys;
--)

--( mouse bindings
cfg.mouse_bindings = {
  {event={Drag={streak=1, button="Left"}}, mods="SUPER", action="Nop"},
  {event={Drag={streak=1, button="Left"}}, mods="CTRL|SHIFT", action="Nop"},
  -- dont open links on UP without SHIFT
  {event={Up={streak=1, button="Left"}}, mods="", action={CompleteSelection="PrimarySelection"}},
  -- selections the way I want
  {event={Down={streak=1, button="Left"}}, mods="SHIFT", action={SelectTextAtMouseCursor="Cell"}},
  {event={Down={streak=2, button="Left"}}, mods="SHIFT", action={SelectTextAtMouseCursor="Word"}},
  {event={Down={streak=3, button="Left"}}, mods="SHIFT", action={SelectTextAtMouseCursor="Line"}},
  {event={Up={streak=1, button="Left"}}, mods="SHIFT", action={CompleteSelectionOrOpenLinkAtMouseCursor="PrimarySelection"}},
  {event={Up={streak=2, button="Left"}}, mods="SHIFT", action={CompleteSelection="PrimarySelection"}},
  {event={Up={streak=3, button="Left"}}, mods="SHIFT", action={CompleteSelection="PrimarySelection"}},
  {event={Drag={streak=1, button="Left"}}, mods="SHIFT", action={ExtendSelectionToMouseCursor="Cell"}},
  {event={Drag={streak=2, button="Left"}}, mods="SHIFT", action={ExtendSelectionToMouseCursor="Word"}},
  {event={Drag={streak=3, button="Left"}}, mods="SHIFT", action={ExtendSelectionToMouseCursor="Line"}},
  -- right button
  {event={Drag={streak=1, button="Right"}}, mods="", action={ExtendSelectionToMouseCursor={}}},
  {event={Drag={streak=1, button="Right"}}, mods="SHIFT", action={ExtendSelectionToMouseCursor={}}},
  -- here first we extend the selection then complete it using 'Multiple' action, otherwise the clipboard won't have the content
  {event={Up={streak=1, button="Right"}}, mods="", action={Multiple={{ExtendSelectionToMouseCursor={}},{CompleteSelection="PrimarySelection"}}}},
  {event={Up={streak=1, button="Right"}}, mods="SHIFT", action={Multiple={{ExtendSelectionToMouseCursor={}},{CompleteSelection="PrimarySelection"}}}},
}
--)

return cfg
