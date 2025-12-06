-- to check keycodes in the console, then use as 'hs.keycodes.map[CODE]'
-- hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event) print("Keycode:", event:getKeyCode()) end):start()

-- Main keybindings
local apps = {
  F1 = "Ghostty",
  F2 = "Google Chrome",
  F3 = "Mattermost",
  F4 = "Obsidian",
  F5 = "KeePassXC",
}

for key, app in pairs(apps) do
  hs.hotkey.bind({ "cmd" }, key, function() hs.application.launchOrFocus(app) end)
end

-- Disable alt+space
hs.hotkey.bind({ "alt" }, "space", function() end)

-- swap Right Command and Right Opt
local cmd = [[hidutil property --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x7000000e7,
      "HIDKeyboardModifierMappingDst":0x7000000e6},
     {"HIDKeyboardModifierMappingSrc":0x7000000e6,
      "HIDKeyboardModifierMappingDst":0x7000000e7}]
}']]
local _, _, _, rc = hs.execute(cmd)
hs.alert.show((rc == 0 and "SUCCESS: " or "ERROR: ") .. "Swapping R-CMD with R-Alt")

-- https://github.com/nikitabobko/AeroSpace?tab=readme-ov-file#tip-of-the-day
hs.execute([[defaults write -g NSWindowShouldDragOnGesture -bool true]])
-- Now, you can move windows by holding ctrl+cmd and dragging any part of the window (not necessarily the window title)
