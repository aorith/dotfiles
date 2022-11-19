local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "Noto Color Emoji", "Hack Nerd Font", "JetBrainsMono Nerd Font Mono" }
	return wezterm.font_with_fallback(names, params)
end

local config = {
	window_decorations = "RESIZE", -- RESIZE: don't show titlebar but allow resize
	cursor_blink_rate = 0, -- disable blinking
	color_scheme = "GitHub Dark",
	colors = {
		cursor_bg = "#52ad70",
		cursor_fg = "black",
		cursor_border = "#52ad70",
	},

	font_size = 16.0,
	font = font_with_fallback("JetBrains Mono"),
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- --> disable ligadures

	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	disable_default_key_bindings = true,
}

config.hyperlink_rules = {
	{ regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" },
	{ regex = [[\bfile://\S*\b]], format = "$0" },
	{ regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
}

config.keys = {
	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },

	-- fix ALT+Space writing 0xA0
	{ key = "Space", mods = "ALT", action = wezterm.action.SendString(" ") },

	-- font size
	{ key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },

	-- copy & paste
	{ key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("PrimarySelection") },
	{ key = "phys:Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("PrimarySelection") },
}

-- TODO: implement this with wezterm mux
local macos_tmux_keys = {
	{ key = "q", mods = "CMD", action = wezterm.action.QuitApplication },

	{ key = "w", mods = "CMD", action = wezterm.action.SendString("\x1bw") }, -- close pane/window
	{ key = "t", mods = "CMD", action = wezterm.action.SendString("\x1bt") }, -- new pane
	{ key = "T", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bT") }, -- new session
	{ key = "h", mods = "CMD", action = wezterm.action.SendString("\x1bh") }, -- switch pane
	{ key = "j", mods = "CMD", action = wezterm.action.SendString("\x1bj") }, -- switch pane
	{ key = "k", mods = "CMD", action = wezterm.action.SendString("\x1bk") }, -- switch pane
	{ key = "l", mods = "CMD", action = wezterm.action.SendString("\x1bl") }, -- switch pane
	{ key = "H", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bH") }, -- move pane
	{ key = "J", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bJ") }, -- move pane
	{ key = "K", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bK") }, -- move pane
	{ key = "L", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bL") }, -- move pane
	{ key = "Return", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1b\r") }, -- switch layout
	{ key = "d", mods = "CMD", action = wezterm.action.SendString("\x1bd") }, -- new horiz pane
	{ key = "D", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bD") }, -- new vert pane
	{ key = "s", mods = "CMD", action = wezterm.action.SendString("\x1bs") }, -- toggle synchronize panes
	{ key = "1", mods = "CMD", action = wezterm.action.SendString("\x1b1") }, -- switch to pane 1
	{ key = "2", mods = "CMD", action = wezterm.action.SendString("\x1b2") },
	{ key = "3", mods = "CMD", action = wezterm.action.SendString("\x1b3") },
	{ key = "4", mods = "CMD", action = wezterm.action.SendString("\x1b4") },
	{ key = "5", mods = "CMD", action = wezterm.action.SendString("\x1b5") },
	{ key = "6", mods = "CMD", action = wezterm.action.SendString("\x1b6") },
	{ key = "7", mods = "CMD", action = wezterm.action.SendString("\x1b7") },
	{ key = "8", mods = "CMD", action = wezterm.action.SendString("\x1b8") },
	{ key = "9", mods = "CMD", action = wezterm.action.SendString("\x1b9") },
	{ key = "g", mods = "CMD", action = wezterm.action.SendString("\x1bg") }, -- enter copy mode
	{ key = "r", mods = "CMD", action = wezterm.action.SendString("\x1br") }, -- rename pane
	{ key = "R", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1bR") }, -- rename session
	{ key = "Comma", mods = "CMD", action = wezterm.action.SendString("\x1b,") }, -- cycle sessions
	{ key = "n", mods = "CMD", action = wezterm.action.SendString("\x1bn") }, -- cycle panes
	{ key = "z", mods = "CMD", action = wezterm.action.SendString("\x1bz") }, -- toggle zoom (maximize pane)
	{ key = "f", mods = "CMD", action = wezterm.action.SendString("\x1bf") }, -- search
	{ key = "u", mods = "CMD", action = wezterm.action.SendString("\x1bu") }, -- tmux open url
	{ key = "i", mods = "CMD", action = wezterm.action.SendString("\x1bi") }, -- tmux server for
	{ key = "p", mods = "CMD", action = wezterm.action.SendString("\x1bm") }, -- tmux & bitwarden
	-- font size
	{ key = "+", mods = "CMD", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = wezterm.action.ResetFontSize },
	-- copy & paste
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("PrimarySelection") },
	{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
}

if string.match(wezterm.target_triple, "darwin") then
	-- they're in reverse between the built-in keyboard and the external MXKeys
	config.send_composed_key_when_left_alt_is_pressed = true
	config.send_composed_key_when_right_alt_is_pressed = true

	for i, v in ipairs(macos_tmux_keys) do
		table.insert(config.keys, v)
	end
end

return config
