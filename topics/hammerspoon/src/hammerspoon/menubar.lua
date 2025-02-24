menuBar1 = hs.menubar.new()

local icon = [[
1 . . . . . . . . . . . 3
. . . . . . . . . . . . .
. . . . . . . . . . . . .
. . . . . . . . . . . . .
. . . . . . 2 . . . . . .
. . . . . . . . . . . . .
. . . . 8 . . . 4 . . . .
. . . . . . . . . . . . .
. . . . . . 6 . . . . . .
. . . . . . . . . . . . .
. . . . . . . . . . . . .
. . . . . . . . . . . . .
7 . . . . . . . . . . . 5
]]

menuBar1:setIcon("ASCII:" .. icon)

local menu = nil

local reloadMenu = function() menuBar1:setMenu(menu) end

-- enable on startup
hs.caffeinate.toggle("displayIdle")

menu = {
  {
    title = "Caffeinate",
    checked = true,
    fn = function(modifiers, menuItem)
      local enabled = hs.caffeinate.toggle("displayIdle")
      if enabled then
        hs.notify.new({ title = "Caffeinate", informativeText = "Caffeinate on" }):send()
      else
        hs.notify.new({ title = "Caffeinate", informativeText = "Caffeinate off" }):send()
      end

      menuItem.checked = enabled
      reloadMenu()
    end,
  },
  {
    title = "-", -- separator
  },
  {
    title = "Rescue Windows",
    -- fn = rescue
  },
  {
    title = "-", -- separator
  },
  {
    title = "Auto Layout",
    -- fn = autoLayout
  },
}

reloadMenu()
