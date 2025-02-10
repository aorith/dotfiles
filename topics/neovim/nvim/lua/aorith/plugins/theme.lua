return {
  --- tokyonight
  -- "folke/tokyonight.nvim",
  -- lazy = false,
  -- priority = 10000,
  --
  -- config = function()
  --   require("tokyonight").setup({
  --     style = "moon",
  --     dim_inactive = true, -- dims inactive windows
  --   })
  --
  --   vim.cmd.colorscheme("tokyonight")
  -- end,

  --- kanagawa
  -- "rebelot/kanagawa.nvim",
  -- lazy = false,
  -- priority = 10000,
  --
  -- config = function()
  --   require("kanagawa").setup({
  --     theme = "wave", -- wave, dragon, lotus
  --     background = {
  --       dark = "wave", -- wave, dragon
  --       light = "lotus",
  --     },
  --     dimInactive = true,
  --   })
  --
  --   vim.cmd.colorscheme("kanagawa")
  -- end,

  --- catppuccin
  -- "catppuccin/nvim",
  -- name = "catppuccin",
  -- priority = 10000,
  --
  -- config = function()
  --   require("catppuccin").setup({
  --     background = {
  --       dark = "frappe", -- frappe, macchiato, mocha
  --       light = "latte",
  --     },
  --     dim_inactive = { enabled = true },
  --     show_end_of_buffer = true,
  --
  --     integrations = { blink_cmp = true },
  --   })
  --
  --   vim.cmd.colorscheme("catppuccin")
  -- end,

  --- rose-pine
  -- "rose-pine/neovim",
  -- name = "rose-pine",
  -- priority = 10000,
  --
  -- config = function()
  --   require("rose-pine").setup({
  --     dark_variant = "moon",
  --     dim_inactive_windows = true,
  --   })
  --
  --   vim.cmd.colorscheme("rose-pine")
  -- end,

  --- sonokai
  "sainnhe/sonokai",
  lazy = false,
  priority = 10000,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
      pattern = "sonokai",
      callback = function()
        local config = vim.fn["sonokai#get_configuration"]()
        local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
        local set_hl = vim.fn["sonokai#highlight"]

        -- Override CursorLine for SnacksPicker to make it more visible
        -- :lua Snacks.picker.highlights({pattern = "hl_group:^SnacksPicker"})
        set_hl("SnacksPickerListCursorLine", palette.none, palette.diff_red)
      end,
    })

    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_style = "espresso" -- 'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'
    vim.g.sonokai_dim_inactive_windows = 1
    vim.g.sonokai_menu_selection_background = "red" -- 'blue', 'green', 'red'
    vim.g.sonokai_float_style = "dim" -- 'bright', 'dim'
    vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_diagnostic_virtual_text = "highlighted" -- 'grey'`, `'colored'`, `'highlighted'
    vim.g.sonokai_inlay_hints_background = "dimmed"

    vim.cmd.colorscheme("sonokai")
  end,
}
