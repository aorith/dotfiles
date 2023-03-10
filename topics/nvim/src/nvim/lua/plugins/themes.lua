-- auto-background
--vim.opt.background = require("core.utils").os_background()

-- Current colorscheme
local colorscheme_choice = "kanagawa" -- dark theme
if require("core.utils").os_background() == "light" then
  colorscheme_choice = "catppuccin" -- light theme
end

local is_enabled = function(colorscheme)
  if colorscheme == colorscheme_choice then
    return true
  end
  return false
end

return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      if is_enabled("tokyonight") then
        require("tokyonight").setup({
          style = "moon",
        })
        require("tokyonight").load()
      end
    end,
  },

  {
    "catppuccin/nvim",
    enabled = true,
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      if is_enabled("catppuccin") then
        vim.cmd.colorscheme("catppuccin")
      end
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    build = function()
      require("kanagawa")
      vim.cmd.KanagawaCompile()
    end,
    config = function()
      if is_enabled("kanagawa") then
        require("kanagawa").setup({ compile = true })
        vim.cmd.colorscheme("kanagawa")
      end
    end,
  },

  {
    "mcchrish/zenbones.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      if is_enabled("zenbones") then
        require("zenbones")
        vim.cmd.colorscheme("zenbones")
      end
    end,
  },
}
