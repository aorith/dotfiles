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
}

H.moveWindowToPosition = function(pos)
  local window = hs.window.focusedWindow()
  if not window then return end
  local screen_id = window:screen():id()

  if pos == H.pos.left then
    hs.grid.pushWindowLeft(window)
  elseif pos == H.pos.right then
    hs.grid.pushWindowRight(window)
  elseif pos == H.pos.top then
    hs.grid.pushWindowUp(window)
  elseif pos == H.pos.bottom then
    hs.grid.pushWindowDown(window)
  end

  if screen_id == window:screen():id() then hs.grid.set(window, pos, nil) end
end

H.windowMaximize = function()
  local window = hs.window.focusedWindow()
  if window then window:maximize() end
end

hs.hotkey.bind(mod, "return", function() H.windowMaximize() end)
hs.hotkey.bind(mod, "right", function() H.moveWindowToPosition(H.pos.right) end)
hs.hotkey.bind(mod, "left", function() H.moveWindowToPosition(H.pos.left) end)
hs.hotkey.bind(mod, "up", function() H.moveWindowToPosition(H.pos.top) end)
hs.hotkey.bind(mod, "down", function() H.moveWindowToPosition(H.pos.bottom) end)
hs.hotkey.bind(mod, "space", function() hs.grid.show(nil, true) end)
