local themes = {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end,
  },
}

for i in pairs(themes) do
  if themes[i].enabled then
    return themes[i]
  end
end
return {}
