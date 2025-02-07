-- Toggle Alacritty
local trigger_term = function()
  local name = "alacritty"
  --local name = "wezterm"
  local app = hs.application.find(name)
  if app then
    if app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus(name)
  end
end

local nop = function() end

-- to check keycodes in the console, then use as 'hs.keycodes.map[CODE]'
-- hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event) print("Keycode:", event:getKeyCode()) end):start()

-- hs.hotkey.bind({ "cmd" }, hs.keycodes.map[10], trigger_term)

hs.hotkey.bind({ "alt" }, "space", nop)

-- swap Right Command and Right Opt
local cmd = [[hidutil property --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x7000000e7,
      "HIDKeyboardModifierMappingDst":0x7000000e6},
     {"HIDKeyboardModifierMappingSrc":0x7000000e6,
      "HIDKeyboardModifierMappingDst":0x7000000e7}]
}']]

local output, status, _, rc = hs.execute(cmd)
local msg
if rc == 0 then
  msg = "SUCCESS: "
else
  msg = "ERROR: "
end
hs.alert.show(msg .. "Swapping R-CMD with R-Alt: ")
