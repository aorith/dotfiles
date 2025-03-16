local mod = { "alt", "ctrl" }

local H = {}

local GRID_SIZE = 2
local HALF_GRID_SIZE = GRID_SIZE / 2

hs.grid.setGrid(GRID_SIZE .. "x" .. GRID_SIZE)
hs.grid.setMargins({ 0, 0 })
hs.window.animationDuration = 0

H.pos = {
  left = { x = 0, y = 0, w = HALF_GRID_SIZE, h = GRID_SIZE },
  right = { x = HALF_GRID_SIZE, y = 0, w = HALF_GRID_SIZE, h = GRID_SIZE },
  top = { x = 0, y = 0, w = GRID_SIZE, h = HALF_GRID_SIZE },
  bottom = { x = 0, y = HALF_GRID_SIZE, w = GRID_SIZE, h = HALF_GRID_SIZE },
  topLeft = { x = 0, y = 0, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE },
  topRight = { x = HALF_GRID_SIZE, y = 0, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE },
  bottomLeft = { x = 0, y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE },
  bottomRight = { x = HALF_GRID_SIZE, y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE },
}

H.moveWindowToPosition = function(cell, window)
  if window == nil then window = hs.window.focusedWindow() end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

H.windowMaximize = function(window)
  if window == nil then window = hs.window.focusedWindow() end
  if window then window:maximize() end
end

hs.hotkey.bind(mod, "return", function() H.windowMaximize() end)
hs.hotkey.bind(mod, "right", function() H.moveWindowToPosition(H.pos.right) end)
hs.hotkey.bind(mod, "left", function() H.moveWindowToPosition(H.pos.left) end)
hs.hotkey.bind(mod, "up", function() H.moveWindowToPosition(H.pos.top) end)
hs.hotkey.bind(mod, "down", function() H.moveWindowToPosition(H.pos.bottom) end)
hs.hotkey.bind(mod, "space", function() hs.grid.show() end)
-- hs.hotkey.bind(mod, "1", function() wm.moveWindowToPosition(wm.pos.topLeft) end)
-- hs.hotkey.bind(mod, "2", function() wm.moveWindowToPosition(wm.pos.topRight) end)
-- hs.hotkey.bind(mod, "3", function() wm.moveWindowToPosition(wm.pos.bottomLeft) end)
-- hs.hotkey.bind(mod, "4", function() wm.moveWindowToPosition(wm.pos.bottomRight) end)
