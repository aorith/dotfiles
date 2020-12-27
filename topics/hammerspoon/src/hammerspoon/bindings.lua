-- Toggle Alacritty
hs.hotkey.bind({"cmd"}, "º", function()
    local name = "kitty"
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
end)

