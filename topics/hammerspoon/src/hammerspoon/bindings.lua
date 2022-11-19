-- Toggle Alacritty
local trigger_term = function()
	--local name = "alacritty"
	local name = "wezterm"
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

hs.hotkey.bind({ "cmd" }, "º", trigger_term)
