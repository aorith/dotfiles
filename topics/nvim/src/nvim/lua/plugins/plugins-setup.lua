-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f2229" })
    print("Cloning packer ..")
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return true
end

packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  use("tpope/vim-surround") -- add, delete, change surroundings, ie: ysw" (surround word with ")
  use("tpope/vim-fugitive")
  use("ojroques/nvim-osc52")
  use("fgsch/vim-varnish")
  use("psf/black")

  use({
    "lewis6991/gitsigns.nvim",
    tag = "v0.5",
  })

  -- requirements
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
  use("nvim-lua/popup.nvim") -- (telescope)

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope.nvim")

  use("neovim/nvim-lspconfig")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } }) -- Additional textobjects for treesitter

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/cmp-nvim-lsp-signature-help")

  -- remaps
  use("folke/which-key.nvim")

  -- vs-code like icons
  use("kyazdani42/nvim-web-devicons")

  -- file explorer
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
      },
    },
  })

  -- statusline
  use("nvim-lualine/lualine.nvim")
  -- bufferline
  use({ "akinsho/bufferline.nvim", tag = "v3.*" })

  -- autoinstall language servers
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
  })

  -- icons for LSP completion
  use("onsails/lspkind.nvim")

  -- undotree
  use("mbbill/undotree")

  -- themes
  use({ "folke/tokyonight.nvim", opt = false })
  use({ "rebelot/kanagawa.nvim", opt = false })
  use({ "ellisonleao/gruvbox.nvim", opt = false })
  use({ "navarasu/onedark.nvim", opt = false })
  use({ "sainnhe/everforest", opt = false })

  if packer_bootstrap then
    require("packer").sync()
  end
end)

return packer_bootstrap
