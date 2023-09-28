local A = vim.api
local map = vim.keymap.set
local my_au = A.nvim_create_augroup("AORITH_MINIFILES", { clear = true })

-- mapping to toggle hidden files
local show_dotfiles = true
local filter_show = function(fs_entry) return true end
local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end
local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

-- Mappings to open in split
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local new_target_window
    local target_window = MiniFiles.get_target_window()
    if not target_window then return end
    A.nvim_win_call(target_window, function()
      vim.cmd(direction .. " split")
      new_target_window = A.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target_window)
    MiniFiles.go_in()
    MiniFiles.close()
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  map("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

-- extra mappings
A.nvim_create_autocmd("User", {
  group = my_au,
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    map_split(buf_id, "gs", "belowright horizontal")
    map_split(buf_id, "gv", "belowright vertical")
    map("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
    map("n", "<ESC>", MiniFiles.close, { buffer = buf_id, desc = "Close MiniFiles" })
  end,
})

require("mini.files").setup({
  -- Module mappings created only inside explorer.
  -- Use `''` (empty string) to not create one.
  mappings = {
    close = "q",
    go_in = "l",
    go_in_plus = "<RETURN>",
    go_out = "h",
    go_out_plus = "H",
    reset = "<BS>",
    reveal_cwd = "@",
    show_help = "g?",
    synchronize = "=",
    trim_left = "<",
    trim_right = ">",
  },

  -- Customization of explorer windows
  windows = {
    preview = true,
    width_preview = 50,
  },
})
