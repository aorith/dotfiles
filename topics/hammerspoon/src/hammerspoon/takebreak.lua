local style = {
  fillColor = { red = 0.15, green = 0.15, blue = 0.2, alpha = 0.95 },
  textColor = { white = 1, alpha = 1 },
  textFont = 'Menlo',
  textSize = 64,
  radius = 32,
  atScreenEdge = 2,
  padding = 100,
  strokeWidth = 5,
  fadeInDuration = 1,
  fadeOutDuration = 1,
}

local escHotkey = nil
local currentAlert = nil
local minutes = 60

hs.timer.doEvery(60 * minutes, function()
  -- Play sounds
  for _, s in pairs({ 'Funk', 'Pop', 'Ping', 'Blow' }) do
    hs.sound.getByName(s):play()
    hs.timer.usleep(1000 * 350)
  end

  currentAlert = hs.alert.show('Time to take a break!', style, hs.screen.mainScreen(), 100)

  -- Create ESC hotkey to dismiss
  if escHotkey ~= nil then
    escHotkey:delete()
    escHotkey = nil
  end
  escHotkey = hs.hotkey.bind({}, 'escape', function()
    if currentAlert then
      hs.alert.closeSpecific(currentAlert)
      currentAlert = nil
    end
    if escHotkey then
      escHotkey:delete()
      escHotkey = nil
    end
  end)
end)
