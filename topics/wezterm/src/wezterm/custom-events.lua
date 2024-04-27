local wezterm = require("wezterm")
local io = require("io")
local os = require("os")
local act = wezterm.action

local M = {}

function M.setup()
  wezterm.on("trigger-vim-with-scrollback", function(window, pane)
    -- Retrieve the text from the pane
    local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

    -- Create a temporary file to pass to vim
    local name = os.tmpname()
    local f = io.open(name, "w+")
    if f == nil then return end
    f:write(text)
    f:flush()
    f:close()

    -- Open a new window running vim and tell it to open the file
    window:perform_action(act.SpawnCommandInNewWindow({ args = { "vim", "-u", "~/.vim/min-vimrc", name } }), pane)

    -- This ends with an unusuable pane at the end ...
    -- window:perform_action(
    --   act.SplitPane({
    --     direction = "Right",
    --     command = { args = { "vim", "-u", "~/.vim/min-vimrc", name } },
    --     size = { Percent = 90 },
    --     top_level = true,
    --   }),
    --   pane
    -- )

    -- Wait "enough" time for vim to read the file before we remove it.
    -- The window creation and process spawn are asynchronous wrt. running
    -- this script and are not awaitable, so we just pick a number.
    --
    -- Note: We don't strictly need to remove this file, but it is nice
    -- to avoid cluttering up the temporary directory.
    wezterm.sleep_ms(3000)
    os.remove(name)
  end)
end

return M
