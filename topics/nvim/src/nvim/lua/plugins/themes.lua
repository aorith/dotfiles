-- Current colorscheme
local enabled = "zenbones"

local is_enabled = function(colorscheme)
  if colorscheme == enabled then
    return true
  end
  return false
end

return {
  {
    "folke/tokyonight.nvim",
    enabled = is_enabled("tokyonight"),
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        style = "moon",
      })
      require("tokyonight").load()
    end,
  },

  {
    "catppuccin/nvim",
    enabled = is_enabled("catppuccin"),
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    enabled = is_enabled("kanagawa"),
    lazy = false,
    priority = 1000,
    build = "KanagawaCompile",
    config = function()
      require("kanagawa")
      vim.cmd.colorscheme("kanagawa")
    end,
  },

  {
    "mcchrish/zenbones.nvim",
    enabled = is_enabled("zenbones"),
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("zenbones")
      vim.cmd.colorscheme("zenbones")
    end,
  },
}
