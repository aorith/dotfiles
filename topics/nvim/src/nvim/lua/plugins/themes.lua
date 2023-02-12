local themes = {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      { "rktjmp/lush.nvim", lazy = false },
    },
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[
      let g:zenbones_compat = 1
      set background=light
      ]])
      vim.cmd.colorscheme("zenbones")
    end,
  },
}

for i in pairs(themes) do
  if themes[i].enabled then
    return themes[i]
  end
end
return {}
